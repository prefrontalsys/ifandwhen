---
layout: essay
title: "Giving Claude a Heart"
subtitle: "Replicating OpenClaw's heartbeat with Claude Code primitives"
description: "OpenClaw's heartbeat daemon was a long-lived process because the rest of its architecture required one. Claude Code's architecture doesn't. You can replace the daemon with a cron entry, a shell script, and a markdown file."
kicker: "Workbench"
category: workbench
date: 2026-04-07
author: "Scot Campbell"
tags:
  - claude-code
  - openclaw
  - agent-architecture
  - automation
  - heartbeat
---

An agent heartbeat, stripped of the branding, is three things: a timer, a state file, and a decision step. That's it. Something wakes up on a schedule, reads a document describing what the world looks like, and decides whether to act. If you squint past the WebSocket plumbing and the always-on process, that's what OpenClaw's heartbeat daemon is doing.

I want to be careful here. A lot of people built real work on OpenClaw. Anthropic cutting off OAuth token use for Open Claw on April 4 didn't just remove a product; it stranded workflows, broke muscle memory, and scattered a community that had been coalescing around a specific mental model of how agents should run. This isn't a post about how that was inevitable or deserved. It's a post for the narrower audience of OpenClaw refugees who came for the capability and are now trying to figure out where the capability went.

The short answer: the capability is sitting in Claude Code. It has been for a while. You don't need a daemon to get it.

## Why OpenClaw needed a daemon in the first place

OpenClaw's heartbeat was a long-lived process because the rest of its architecture required one. It held auth in memory, listened on a WebSocket for remote triggers, maintained warm context between cycles, and coordinated a runtime that assumed continuous presence. Given those constraints, a daemon wasn't a choice — it was the only shape the thing could take.

Claude Code's architecture doesn't carry those constraints. Auth lives in your subscription, not in a process. Triggers arrive through primitives that already exist. Context is something you assemble per invocation rather than something you hold. The daemon shape is doing work that, in this environment, nothing is asking for.

Which means you can replace it with a cron entry.

## The only cron you need

```
CronCreate(
  schedule: "*/5 * * * *",
  prompt: "/heartbeat-pulse",
  agent: "doer"
)
```

That's the whole scheduled surface. One cron, fires every five minutes, runs a small  haiku-tier skill. On my system, that's a "doer" agent running the skill. The skill's job is not to decide anything interesting. It runs a shell script, reads its exit code, and either stays silent or fires a `RemoteTrigger` to wake the layer that actually decides things.

The shell script — `pulse.sh` — is where the "is there work?" question gets answered. It walks a directory of small predicate scripts (`gh issue list` for a GitHub queue, `find` for an inbox folder, `stat` for file mtimes, whatever you care about), runs each one, and exits 0 if everything was quiet or 1 if any predicate found something worth looking at. Pure bash. No model. No inference. Zero tokens for the "is there anything happening" check, which is the check that runs every five minutes forever.

The state file — call it `HEARTBEAT.md`, put it in whatever repo you want — is the contract for actual work items. It's the queue, the status tracker, and the audit log in one document. Because it's a file, it's human-editable. Because it's in git, it's versioned. When something goes sideways at 3am, you can read the diff and see what the heartbeat saw.

## Why the cold-start version is structurally better

The instinct is to treat "always-on" as a feature. It isn't, in this context. It's a liability the old architecture had to pay for.

Cold-start means the prompt cache does what it's designed to do: cache the stable prefix of your invocation and charge you cheaply for the variable tail. A warm loop that reuses context across cycles defeats this — every "tick" drags accumulated state into the next call, and the cache never gets a clean prefix to hold onto. The cold-start version is cheaper, not despite the restart, but because of it.

Auth stays in-process, scoped to the invocation that needs it. There's no long-lived credential sitting in a daemon's memory waiting to be exfiltrated by whatever CVE shows up in a transitive dependency next month. The attack surface is the cron entry and the file. That's a surface you can reason about over coffee.

And the property that made OpenClaw economically awkward — warm context burning subscription tokens while the user wasn't looking — is exactly the property the cron version doesn't have. When nothing is ready, the heartbeat reads the file, sees nothing to do, and exits. The cost of an idle cycle is a single small prompt. The cost of a busy cycle is whatever the busy work was going to cost anyway.

## Stacked escalation, not parallel scheduling

The version that felt natural when I first sketched this was three crons: a fast pulse every five minutes on a cheap model, a slow-think every thirty minutes on a strong model, a reflective daily on something in the middle. Three schedules, three layers, three independent timers. It's a clean diagram but why add the comlpexity?

The mistake is that the fast pulse layer, as I first drew it, was asking a model to answer "is there anything worth waking up for?" A model is the wrong tool for that question. Due to the nature of Claude Code's internal cron, I do have to have a model run a shell script to answer the question though. An inference call that runs a shell script is cheap compared to asking a model to make the decision. You could have this step run without inference at all by using n8n or native cron, I just wanted to build this whole thing within Claude Code.

The corrected architecture is one scheduled timer and three demand-driven layers. Everything above the timer runs only when the timer's shell substrate found evidence of work.

```
   cron fires (every 5 min)
         │
         ▼
  Layer 0: heartbeat-pulse  (haiku router, ~0 decisions)
         │
         ▼
   runs pulse.sh via the Bash tool
         │
         ▼
   pulse.sh walks predicates/*.sh
   (pure shell, zero inference, exits 0 or 1)
         │
         ├── exit 0 ──▶ silent. tick done.
         │
         └── exit 1 ──▶ RemoteTrigger("heartbeat-triage")  (async)
                          │
                          ▼
                  Layer 1: heartbeat-triage  (haiku classifier)
                          │
                          ├── handle inline  ──▶ done
                          ├── ignore         ──▶ done
                          └── escalate:
                                append item to HEARTBEAT.md
                                RemoteTrigger("heartbeat-tick")
                                     │
                                     ▼
                             Layer 2: heartbeat-tick  (opus, real decisions)
                                     │
                                     ▼
                              reads HEARTBEAT.md, dispatches via Agent,
                              updates state, exits
```

Even a daily reflective layer can be woven into this pattern  - a morning pass that reviews what the last twenty-four hours of heartbeat activity produced, surfaces anything stuck, and prunes archived items - is just another task to be done.

At idle, the whole system consumes one tiny cached haiku call per pulse tick plus a handful of `gh` and `find` and `stat` commands run from the shell script. When the predicates stay silent, the cost of the heartbeat is whatever Claude Code charges you for a cached one-line haiku invocation. When the predicates fire, cost scales with the actual work, not with the clock. This is the property OpenClaw violated — a warm loop that kept context hot and burned tokens while waiting for something to do — and it's the property the stacked version restores by cold-starting every tier at every boundary.

## The predicates are the point

The predicates are small shell scripts that each answer one question. A `github-queue.sh` that runs `gh issue list --label type:queue,status:queued --state open --json number --jq length` and exits 1 if the count is greater than zero. An `inbox-files.sh` that runs `find ~/heartbeat/inbox -type f -print -quit` and exits 1 if anything comes back. A `heartbeat-mtime.sh` that checks whether `HEARTBEAT.md` has been touched since the last pulse and exits 1 if it has. None of them calls a model. All of them run in milliseconds. Adding a new one is dropping an executable shell script into a directory.

This is the piece that makes the whole architecture sustainable: the part of the system that runs every five minutes forever is the part that has zero marginal cost, and the part that costs something runs only when the free part has already decided there's a reason to spend. If you're thinking about your own version of this, the predicate directory is where you should be spending your time. Everything else is plumbing.

## Triage as the translator between layers

When `pulse.sh` exits 1, the Layer 1 skill fires `RemoteTrigger("heartbeat-triage")`, which is async — it returns immediately, triage runs independently, the pulse tick exits without waiting. Triage is a classifier, still on haiku, and it handles three cases.

The first is "I can resolve this in a handful of tool calls." A duplicate GitHub issue that's already tracked as in-progress. A stale inbox file matching something already marked `done`. A webhook pong that just needs acknowledgment. Triage handles these inline and exits. No escalation needed.

The second is "this predicate fired on something that shouldn't count." Known-stale data, test artifacts, a mtime change triage caused itself. Log the ignore reason so the reflective layer can notice if ignore rates spike — that's the signal a predicate has gotten too noisy — and exit.

The third is "this is real work that needs the slow-think layer." Triage writes the work to `HEARTBEAT.md` as a new ready item with the appropriate agent and prompt, then fires `RemoteTrigger("heartbeat-tick")` to wake Layer 2. Triage does not dispatch agents itself — it's a ticket writer, not a worker.

Layer 2, the tick, is where the opus-tier decisions live. It reads `HEARTBEAT.md`, evaluates the ready items, dispatches them via `Agent`, updates state, exits. This is the layer that corresponds to OpenClaw's actual ReAct loop — the place where a strong model is reasoning about what to do. In the stacked version, it runs only when two cheaper layers have already decided it's warranted.

## The event axis

Cron gives you time. It doesn't give you events. For events, there's RemoteTrigger — a way for external systems to wake a Claude Code invocation on demand. A GitHub webhook, a form submission, an email parser, whatever. Same pattern: the trigger fires, a cold-start invocation reads the state file, decides, acts.

Wiring them together is the whole move. Cron handles "wake up periodically." RemoteTrigger handles "wake up when something happens." Together they cover everything a heartbeat daemon was covering, without anything needing to stay resident.

## Making failure visible

A heartbeat that fails silently is worse than no heartbeat, because you build trust in it and then the trust is wrong. SendMessage is the glue that fixes this. At the end of each cycle — or specifically at the end of the reflective daily cycle — have the invocation send itself (or you) a short status ping. "Three items dispatched, one stuck, queue depth four." If the ping stops arriving, you know the heartbeat stopped beating. If the ping arrives but says something alarming, you know before the alarming thing compounds.

This is the part OpenClaw users often don't replicate because the daemon model made it feel unnecessary — the daemon was right there, you could see its logs. In the cold-start model, the invocations are ephemeral, so observability has to be something the invocations produce on purpose.

## The mapping

For the people doing the actual port, here's the whole thing as a table:

| OpenClaw concept             | Claude Code equivalent                                   |
| ---------------------------- | -------------------------------------------------------- |
| Heartbeat state file         | `HEARTBEAT.md` in your repo, git-versioned               |
| Timer                        | `CronCreate` firing a minimal Layer 0 skill              |
| Self-waking daemon loop      | Cold-start cron invocation, no daemon                    |
| "Is there work?" check       | `pulse.sh` + `predicates/*.sh` — pure shell, zero inference |
| Work triage / classification | `heartbeat-triage` skill (haiku), demand-driven          |
| ReAct decision step          | `heartbeat-tick` skill (opus), demand-driven             |
| Agent dispatch               | `Agent` tool, called from Layer 2                        |
| Inter-step messaging         | `SendMessage`                                            |
| Skill invocation             | `Skill`                                                  |
| External event triggers      | `RemoteTrigger` (same primitive the layers use internally) |
| Multi-agent coordination     | `TeamCreate`                                             |
| Worktree isolation           | `EnterWorktree` / `ExitWorktree`                         |
| Status review / reflection   | Daily reflective cron, separate from the hot path        |

The rows that matter most are the ones about the "is there work?" check and the triage layer. Those are the architectural distinctions between a heartbeat that burns subscription tokens while idle and one that doesn't. OpenClaw's heartbeat answered the wake-up question with a warm model; the stacked version answers it with shell scripts and lets the models run only when the shell has already decided there's a reason. Everything else on the list is primitives that ship in the box.

## What this doesn't replace

I want to end honestly. The capability is portable. The rest of what OpenClaw was — the community, the brand, the marketplace of shared skills, the shared vocabulary that let people talk to each other about their setups without explaining the basics every time — is not portable. You can't cron your way to a community. A mapping table can't hold a mental model that thousands of people were building together.

For users who came to OpenClaw because they wanted to belong to something, this post doesn't help. I don't have a good answer for them and I'm not going to pretend I do.

But for users who came to OpenClaw because they wanted a heartbeat — a thing that wakes up, checks the world, and decides — the heartbeat is already in the tooling you have. It looks like a cron entry and a markdown file. It's less impressive than a daemon. That's the point.
