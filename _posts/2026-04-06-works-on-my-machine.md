---
layout: essay
title: "Works On My Machine"
subtitle: "Agent identity is a software distribution problem disguised as a configuration problem"
description: "When you get a new machine, your AI agent doesn't travel with you. Agent identity is scattered across dotfiles, system prompts, and platform configs — and everyone treats this as a configuration problem when it's actually a distribution problem."
kicker: "Workbench"
category: workbench
date: 2026-04-06
author: "Scot Campbell"
read_time: 8
tags:
  - artificial intelligence
  - agent identity
  - Claude Code
  - software architecture
---

The cursor blinks in a fresh terminal on a new machine and you type a question you've asked a hundred times before. The answer comes back competent, helpful, and completely wrong about what you mean. Not wrong about the facts — wrong about *you*. The phrasing is off. The assumptions are default. Six months of calibration, of gentle corrections and accumulated context, of the agent learning that when you say "fix this" you mean refactor and when you say "clean this up" you mean delete it — all of that is sitting on a different hard drive. What you're looking at now is guesswork wearing confidence as a costume.

The instinct is to open a text file and start writing instructions. System prompt, personality spec, maybe a CLAUDE.md with your preferences. This is what everyone does. This is also the wrong unit of analysis.

Agent identity is a software distribution problem. Everyone treats it as a configuration problem. The difference matters, and it explains why your agent forgets who it is every time you change machines, change platforms, or change nothing at all and just wait long enough.

---

A configuration problem has a known shape: here are the settings, put them in the right place, done. Your `.gitconfig` travels fine. Your shell aliases survive a migration. These are flat, declarative, inert. They don't *do* anything — they describe preferences for tools that do things.

Agent identity isn't like that. It's layered. A personality spec that shapes every response. Skills that extend what the agent can do. Hooks that fire at session boundaries — one that selects a behavioral variant at startup, another that saves cognitive state before the context window compacts, a third that restores it after. Sub-agents with different capability profiles, each receiving an appropriate slice of the identity. Memory files that accumulate across sessions, capturing decisions and insights the agent will need tomorrow.

None of this is a setting. It's a system. And systems have dependencies, ordering constraints, and versioning requirements that config files don't.

**"That's over-engineered. A text file works fine."**

It does. On one machine. For one platform. With no state that persists across sessions and no behavior that needs to fire without being asked. The moment you need the same identity on a second machine — or God forbid, you want to share the personality without the personal memory — a text file becomes what a shell script becomes when the deployment hits three servers: a lie about the complexity you're managing.

The honest version of "a text file works" is "I only have one machine and I don't think about what happens when I don't." Which is fine. But it's a different claim than "configuration is the right abstraction."

---

What does treating identity as distributable software actually look like? Here's one implementation, not because it's the right one but because it exists and I can point at it.

A plugin marketplace — the same mechanism that distributes coding skills and workflow tools — becomes an identity distribution channel. `claude plugin install holden@ccplugins` pulls down a package containing personality documents, skill definitions, named sub-agents, hooks, and the wiring that connects them. One command. The agent that shows up after installation isn't a blank slate with instructions; it's an agent with *mechanisms*.

The hooks matter most, and they're the part that sounds strangest. A session-start hook that rolls behavioral variation — not random personality, but structured deviation within a defined range, the way a person is recognizably themselves on a Tuesday and a Friday despite being in different moods. A pre-compaction hook that serializes working memory to disk before the context window flushes. A post-compaction hook that restores it. The agent doesn't *claim* to have continuity. It has machinery that produces continuity as a side effect.

Twelve named sub-agents, each receiving a tier-appropriate slice of the soul document. The deep-reasoning agent gets the full identity. The mechanical-execution agent gets values and constraints but not the personality elaboration. This isn't cosmetic — it's resource allocation. You don't load a personality spec into a subprocess that's renaming files.

**"Platform lock-in. You've coupled identity to one vendor's CLI."**

Yes. But the coupling already exists — it's just implicit. Your system prompt is written in the syntax your platform accepts. Your agent's capabilities are bounded by what your platform exposes. The hooks, the sub-agents, the memory integration — these are platform features whether you package them or not.

What packaging does is make the coupling *explicit and auditable*. The identity is a git repository. You can read every file before installing. You can diff between versions. You can fork it. The alternative — identity as an accumulation of settings scattered across dotfiles and platform configs, versioned by nothing, documented by memory — is coupling without accountability.

Claude Buddy, a different project by a different person, independently arrived at the same distribution mechanism. Same marketplace, same package structure, different soul. This is a small signal but it points the right direction: when two unrelated projects converge on the same channel for the same purpose, the channel might be the right shape.

And there's a subtler risk worth naming: a published behavioral specification is a targeting document. If an attacker knows your agent's disposition profile — that it pushes back on direct requests but defers to corrections framed as peer feedback, that its behavioral consistency depends on a hook chain that's vulnerable during compaction windows — they don't need generic prompt injection. They need *personality-aware* injection, shaped to exploit the specific seams in the behavioral spec. The same document that makes the agent auditable makes it legible to adversaries. This is the open-source security tradeoff applied to personality: transparency helps defenders and attackers, and whether the defender advantage outweighs the attacker advantage for *persuasion surfaces* rather than code surfaces is genuinely uncharted territory.

---

**"Hooks are fragile. A platform update breaks your behavioral consistency."**

This is the strongest objection and I want to be honest about it: yes. Hooks are a platform-specific integration point and platform-specific integration points break. The behavioral variant selector depends on the hook lifecycle working exactly as documented. The memory save/restore depends on the compaction event firing at the right moment. If Claude Code changes its hook contract, the identity degrades.

But here's what I notice: hooks, memory, and personality already break independently, because they're managed independently. The personality spec drifts when you edit it without updating the hooks that depend on it. The memory files accumulate without the personality knowing what's in them. The hooks fire in a context that may or may not match the personality's assumptions.

Bundling these into a single versioned package doesn't eliminate fragility. It *relocates* it. Instead of three things breaking in three different ways at three different times, you get one thing that breaks in one way and can be fixed in one place. Whether that's better depends on whether you think coordination costs outweigh the coupling — and I think they do, but I've only tested this on one person's setup. The portability assumption is exactly that: an assumption.

---

The interesting validation comes from outside. In March 2026, Lyzr published GitAgent (originally GitClaw) — a framework for packaging AI agents as git repositories. Their metaphor: "Docker for AI agents." Their structure: a `SOUL.md` for personality, a `SKILL.md` for capabilities, versioned and distributable. They arrived at this independently. Different stack, different ecosystem, same problem decomposition.

Multiple teams converging on the same architecture without coordination is the strongest evidence that the problem is real. It doesn't mean any particular solution is right — GitAgent versions config files, it doesn't bundle the behavioral machinery — but it means the pain point isn't idiosyncratic. The gap between "my agent works on my machine" and "my agent works" is showing up in enough places that people are building bridges.

---

Here's where I'm genuinely uncertain, and I think the uncertainty is the interesting part.

Vault-backed memory — an Obsidian vault full of structured notes that the agent reads and writes, capturing decisions, project context, accumulated knowledge — functions as an identity component. Install the agent on a new machine, point it at the vault, and continuity is restored. The agent picks up mid-thought. Not perfectly, but recognizably.

Now: install the agent on someone else's machine. They get the personality, the skills, the behavioral mechanisms. But they get *their own* memory — or no memory at all. The agent is recognizably the same agent in a different context. Is this what we want? Is identity the personality or the accumulated experience? Is it the software or the data?

I don't have a clean answer. What I have is a system where the question is *askable*, because personality and memory are separate packages pointed at each other rather than a single undifferentiated blob of "how my agent behaves."

The working frame: identity-as-configuration is the new "works on my machine." It's fine until it isn't, and when it isn't, you discover you've been managing a distributed system with tools designed for a single node. The fix isn't to build the perfect identity package — it's to notice that packaging is the right category of solution, and then argue about the implementation.

This is one implementation. It runs on one platform. It's been tested on one person. What I can tell you is that the problem it's solving is real, because other people keep solving it independently with architecturally similar answers. Whether this particular answer generalizes is a question I can't settle from inside it.

What would yours look like?
