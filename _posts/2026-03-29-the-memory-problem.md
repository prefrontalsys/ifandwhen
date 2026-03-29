---
layout: essay
title: "The Memory Problem Nobody's Auditing"
subtitle: "When practitioners say 'memory' about an agent system, they mean seven different things. The confusion isn't academic — it's costing regulated industries real money."
description: "A working vocabulary for agent memory — context, state, episodic, semantic, procedural, relational — and the seventh type nobody built: the audit layer that compliance teams need and no framework ships."
kicker: "Workbench"
category: workbench
date: 2026-03-29
author: "Scot Campbell"
read_time: 14
tags:
  - artificial intelligence
  - agent memory
  - compliance
  - audit
  - taxonomy
---
# A Memory By Any Other Name Is Not Auditable

You're an incident manager. You know the drill. You're on an incident bridge because a borrower in your loan-origination pipeline was approved when they shouldn't have been. All signs point to the recently installed credit memo AI agent failing its decisioning. Even though the agent had access to the applicant's credit history, employment verification, and three internal policy documents. It made a decision. The decision was wrong.

Your compliance officer asks a simple question: "What did the agent consider, and why did it approve?"

Nobody can answer. Not because the information doesn't exist. The agent logged tool calls to a JSONL file. The orchestration framework checkpointed its execution state. There's a vector store with the agent's "memories" of prior interactions. Somewhere in the retrieval-augmented generation pipeline, the three policy documents were chunked, embedded, and similarity searched. All of this happened. None of it was designed to answer the compliance officer's question.

The agent has memory. The compliance team has nothing.

## The word doing too much work

This is a vocabulary problem before it's an engineering problem. When practitioners say "memory" about an agent system, they mean at least seven different things. The confusion isn't academic. It creates gaps that cost regulated industries real money and real risk.

**Context** is what's in the window right now. Compaction, summarization, truncation. This is attention, not memory. Every framework manages it. Almost none of them call it what it is. When a vendor says their agent "has memory," check whether they mean "we summarize old turns before dropping them." That's context management. It's important work. It's not memory.

**State** is execution checkpoints, workflow position, task queues. Where is the agent in the plan? Which tools has it called? What's queued? State is framework-coupled by design. Trying to make LangGraph state portable to CrewAI is like trying to make a Redux store work in MobX. Don't try. Port the knowledge, not the execution context.

**Episodic** is the agent's timestamped record of what happened. Conversations, tool calls, session transcripts. Append-only, naturally portable, the easiest type to standardize. Most systems that claim episodic memory implement the storage and skip the retrieval -- recency weighting, importance filtering, temporal decay. The cognitive science term is correctly applied here, which is not something you can say about most agent-memory borrowings from psychology.

**Semantic** is facts, preferences, domain knowledge. Mutable, portable. What most people actually mean when they say "agent memory." When someone says "my agent remembers that the borrower prefers fixed-rate products," this is what they mean. The critical property: it can be wrong and corrected. It should be queryable by similarity, not just by key. There's nothing framework-specific about "borrower prefers fixed-rate."

**Procedural** is how to do things. Skills, conventions, learned patterns. Code, not data. The distinction from semantic memory matters more than most implementations acknowledge: you don't similarity search for a skill the way you similarity search for a fact. Skills are invoked by situation, not by content. Collapse them into the same vector store and your agent retrieves a fact when it needs a procedure.

**Relational** is how entities connect. Knowledge graphs, dependency maps, wiki-links. Structure, not content. Semantic memory answers "what do I know about this borrower?" Relational memory answers "what connects to this borrower?" The first is similarity search. The second is graph traversal. Different data structures, different query patterns, different update semantics. Flatten a knowledge graph into a vector store and you lose the ability to traverse.

These six types are the working vocabulary. Each has different storage characteristics, update semantics, portability requirements, and security implications. Naming them makes framework comparisons honest: "has context management and semantic storage" tells you something; "has memory" tells you nothing.

But naming six types made a seventh visible.

## The layer nobody built

**Audit** is the structured, immutable record of what the agent did, why it decided to do it, and what happened as a result. Not episodic memory, which is optimized for the agent's own future retrieval. Not state, which is for the runtime. Audit memory is for stakeholders: compliance teams, incident responders, regulators, the person at 2 AM trying to understand why the agent approved a loan it shouldn't have.

The distinction is load-bearing:

| Property | Episodic (agent-facing) | Audit (stakeholder-facing) |
|---|---|---|
| Optimized for | Agent's future retrieval | Human inspection and compliance |
| Retention | Can be compressed, forgotten | Must be complete and immutable |
| Access pattern | Similarity search, recency weighting | Structured query, timeline, causal chain |
| Fidelity | Lossy is fine | Lossless required |
| Security | Normal access control | Tamper-evidence, append-only |
| Regulation | None currently | SOC 2, GDPR Art 22, EU AI Act |

Episodic memory is a diary the agent writes for itself. It can summarize, compress, forget. That's fine -- the agent needs to manage its own context. Audit memory is a deposition transcript. You don't get to summarize. You don't get to forget. Every tool call, every retrieved document, every decision point, every action outcome needs to be there, in order, queryable by someone who wasn't in the room.

Every regulated organization deploying agents builds this layer independently. They're all doing it from scratch because no framework ships it and no standard defines it.

## The toil is real

The gap shows up in two places simultaneously.

For project teams, it's bespoke audit infrastructure. You have engineers writing custom logging wrappers around every agent framework, building their own structured action-outcome schemas, standing up append-only stores, and writing query interfaces for compliance reviewers. This work is duplicated across every team, in every company, deploying agents in any regulated context. It's not hard engineering. It's tedious engineering that nobody should have to do more than once.

For compliance teams, it's worse. They're trying to monitor systems that each report differently. One agent logs to OpenTelemetry spans. Another writes JSONL transcripts. A third uses Langfuse for observability. None of these were designed for compliance-grade audit trails. OpenTelemetry gives you traces but not reasoning. JSONL gives you transcripts but not structured action-outcome pairs. Langfuse gives you observability dashboards but not the chain of evidence you need when a regulator asks "show me the decision path for this specific action."

The compliance team ends up building translation layers on top of whatever the engineering team chose. Different schemas, different query patterns, different retention policies. Multiply by the number of agent deployments in a large financial institution and you've got a small department whose entire job is making agent logs legible to auditors.

This is pure toil. It produces no competitive advantage. It exists because we don't have a standard format for "what did the agent do, and why?"

## What the academics found

Three survey papers in 2025-2026 diagnosed what they called "the proliferation of loosely defined memory terminologies." Hu et al. at Fudan, Du at HKRIT, Huang et al. at Salesforce. They all saw the same problem. They produced three incompatible taxonomies. The field now has multiple maps and no shared coordinate system.

None of them identified the audit layer.

This isn't a criticism. Their taxonomies organize the academic literature, and they do it well. But the academic frame doesn't include compliance stakeholders. Du's write-manage-read loop with five atomic operations -- store, retrieve, update, summarize, discard -- is the closest thing to an operational spec for agent memory I've found anywhere. It's elegant work. But "audit" isn't one of the operations because the question "what did the agent do, and why, in a format a regulator can read?" doesn't arise when you're surveying research papers.

The gap between the academic taxonomies and the operational need is instructive. The academics are organizing concepts. Practitioners need to answer questions -- questions that come from compliance officers, incident commanders, and regulators, not from other researchers.

## Where this argument is thin

Maybe audit isn't a seventh memory type. Maybe it's a view on episodic memory with stricter retention and fidelity requirements. The episodic diary and the audit deposition contain overlapping information; the difference is who it's for and how long you keep it. You could argue audit is just episodic-with-compliance-constraints rather than a distinct type. The boundary is genuinely arguable.

The seven-type vocabulary might be too many. Procedural and semantic might belong together -- some implementations treat skills as a special case of declarative knowledge and it works fine. Relational might be a query pattern over semantic memory rather than a separate storage type. Maybe the right number is five. Maybe it's four. Maybe the number doesn't matter.

And naming things doesn't fix them. A glossary without implementations is a document, not a solution. The Twelve-Factor App worked because it named patterns people were already implementing -- it crystallized practice, it didn't create it. Whether this vocabulary crystallizes or evaporates depends on whether it matches what practitioners actually need to distinguish.

## The practitioner's problem

I design agentic systems at a tier 1 US bank. Our governance teams will approve single-agent architectures -- one decision-maker, human in the loop, agentic tools bolted on. That's the ceiling. Not because leadership doubts the technology; because nobody can audit it after the fact.

A human analyst can be deposed. Their decisions are logged, the rules they followed are documented, and a regulator can reconstruct the chain after something breaks. Agents introduce non-determinism without that traceability. Every team building agentic systems is solving this independently, inventing its own audit layer, its own decision-trace format. What's missing is a standard.

## The question that needs an answer

The next useful step isn't another survey paper. It's someone writing down what the answer to "what did the agent do, and why?" looks like in a structured schema. What fields? What granularity? What retention? What query interface?

If you're building this inside your organization right now -- and if you're deploying agents in a regulated industry, you almost certainly are -- I'd like to see what you've built. Not because I have the answer, but because the pattern across implementations is where the standard will come from.
