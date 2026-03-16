---
layout: essay
title: "Mean Time to Understand"
subtitle: "The only metric that measures whether humans and AI are understanding faster together."
description: "Everyone measures Mean Time to Resolve. Nobody measures Mean Time to Understand. MTTU is where the real time goes in every major incident, and it's the only metric that tells you whether humans and AI are actually making each other better — or whether one side is atrophying while the other compensates."
kicker: "Essay"
date: 2026-03-15
author: "Scot Campbell"
read_time: 14
tags:
  - artificial intelligence
  - incident management
  - human-AI interaction
  - obligate mutualism
  - MTTU
  - cognitive synthesis
  - expertise
---

Every organization that runs systems at scale tracks Mean Time to Resolve. MTTR. The clock starts when something breaks and stops when the fix is confirmed. It's the number that shows up in post-incident reports, in SLA dashboards, on slides presented to executives who want to know whether operations is getting faster. It is, by almost universal consensus, the metric that matters.

It is also, by almost universal consensus, measuring the wrong thing.

Here's why. Consider a major incident: a payment system down, customer-facing, revenue bleeding by the minute. The resolution might take twenty minutes. Restarting a service, rerouting traffic, applying a known fix. But the two hours before that resolution? Those were spent figuring out what was actually wrong. Parsing ambiguous alerts. Ruling out hypotheses. Waiting for someone who understood the dependency chain to join the bridge call. The fix was twenty minutes. The understanding was two hours. MTTR counts both as one number and calls it "resolution time," which is like measuring a medical success by how long it took to write the prescription.

{% include pull-quote.html quote="The metric nobody tracks is Mean Time to Understand. MTTU. How long it takes to go from 'something is wrong' to 'I know what's wrong.'" %}

The metric nobody tracks is Mean Time to Understand. MTTU. How long it takes to go from "something is wrong" to "I know what's wrong." That gap is where the real time goes, where the real money burns, and, this is the part that matters for everything I've been writing about and working for, where the relationship between human intelligence and artificial intelligence is actually tested. Not in demos. Not in proofs of concept. In the dark, at speed, when the answer isn't obvious and the cost of being wrong is measured in minutes.

---

In an emergency room, a patient arrives with ambiguous vitals. Heart rate elevated but not alarming. Blood pressure low-normal. Anxious, diaphoretic, complaining of chest tightness. Could be a heart attack. Could be a panic attack. Could be any of a dozen other things. The triage nurse has ninety seconds to compress that firehose of signals into a category that determines whether this patient sees a cardiologist in four minutes or sits in the waiting room for two hours. She's not resolving anything. She's understanding fast enough that the right resolution becomes possible.

But the real cognitive work begins behind the triage desk, where three information streams are run simultaneously and don't agree with each other. The cardiac monitor is continuous and real-time but narrow, it sees electrical activity and nothing else. The lab results, when they arrive, will be precise but delayed; troponin levels take thirty minutes to come back, and by then the decision about whether to activate the cath lab may already have been made. Imaging, a chest X-ray or an echo, offers spatial information in a completely different modality, on its own timeline.

The attending physician synthesizes across all three. Not reading any one stream, but holding multiple streams of different latency, different confidence, and different failure modes in a single coherent picture. The monitor says one thing. The labs suggest another. The patient's history reweights everything. The attending's job is not to trust any single source. It's to build understanding fast enough that the right intervention lands before the window closes.

Everything downstream -- the stent, the medication, the discharge -- depends on how fast the attending gets from "something's wrong" to "I know what's wrong." This is MTTU in medicine. Speed matters. But speed without accuracy is worse than slowness, because a fast wrong answer in an ER doesn't just delay treatment; it sends the patient down the wrong path while the real problem continues.

And then there's the twenty-year nurse. She's seen thousands of chest tightness cases. She walks in and says "this is cardiac" before the labs come back. She's usually right, and her speed saves lives. But when the presentation is atypical, her expertise becomes the thing that slows understanding down. She's anchored. The diagnosis is made, and new information gets filtered through it.

---

Now move from the ER to the bridge call. A critical system is down. Forty engineers on the line, most of them listening, a few of them talking over each other. The incident manager, the IM, has a job that looks nothing like what most people imagine. She is not there to fix the problem. She might not even understand the technical details well enough to fix it if she wanted to. Her job is to understand fast enough that the person who can fix it gets pointed in the right direction.

The monitoring dashboard shows latency spiked at 14:32. The database team sees connection pool exhaustion starting at 14:28. A senior engineer says this looks like September. Someone deployed a config change that "shouldn't have affected anything." Meanwhile, metrics nobody's looking at are climbing steadily. The information that would explain everything is scattered across twelve systems and forty people.

The logs contain it. The metrics contain it. Someone on the call probably already knows it but doesn't know they know it, because they're looking at their piece without seeing how it connects to everyone else's. MTTU measures how fast the IM collapses that scattered, contradictory, partial information into a coherent picture. And the honest answer, in most organizations, is: not fast enough. Not because the people are slow, but because the cognitive task is genuinely synthesizing raw data from twelve systems on six screens in real time exceeds human capacity while someone asks them to provide an ETA they don't have.

---

The attending physician has three information streams with different properties: monitors (real-time, narrow), labs (delayed, precise), imaging (spatial, different modality). Her skill is synthesis across streams. No single stream tells the story. The diagnosis lives in the intersection.

AI gives the incident manager three lenses. Historical pattern matching surfaces similar past incidents. Real-time signal analysis identifies correlations in logs and metrics. A synthesis layer that reasons across both. Not just "this looks like September" but "where this matches and where it diverges." Each has different latency, confidence, and failure modes. The IM needs to hold all three together, building understanding from the tensions between them.

But here's the training gap. Residency programs trained doctors to work with clinical decision support. It took years, it was resisted, and it's still imperfect, but there is at least an institutional acknowledgment that interpreting machine-generated information alongside clinical judgment is a skill that has to be taught. Nobody trains incident managers to do this. There is no residency for working with AI lenses under pressure. The IM is expected to figure it out at 2am, with systems down and the clock running, on the first incident where the AI is in the room.

---

Trust built at 2am doesn't look like trust built in a demo. In a demo, the AI is impressive. It surfaces the right pattern, explains its reasoning, looks good on slides. In a live incident, the AI is one voice among many, and it has no authority except whatever credibility it's earned in previous incidents that the IM happens to remember.

Here's the moment. The monitor says STEMI, ST-elevation myocardial infarction, the textbook heart attack signal. The patient says "I think I ate too much pasta." The attending's clinical instinct says acid reflux. Three sources, three different stories. When does the attending override the machine? When does she trust it over her own gut? The answer isn't a rule. It's a judgment formed over years of seeing when monitors lie and when they don't, when patients minimize and when they don't, when her own intuition is tracking something real and when it's anchored on the last similar case she saw.

Now the war room. The AI says "this matches the connection pool exhaustion pattern from September -- 87% confidence." A senior engineer with fifteen years at the company says "no, this is DNS. I've seen this before." Real money is burning. The IM has to decide who to listen to, and here's the part that nobody talks about in the AI discourse: neither the AI nor the senior engineer can explain their reasoning fast enough to resolve the disagreement in real time. The AI's confidence score is a number, not an argument. The engineer's "I've seen this before" is experience compressed into intuition, not a logical chain she can unpack while the system is down. The IM is choosing between two forms of compressed understanding, and she has to make the choice before either one can fully justify itself.

{% include pull-quote.html quote="The IM is choosing between two forms of compressed understanding, and she has to make the choice before either one can fully justify itself." %}

The second essay in this series was about training the AI to disobey. The guide dog that refuses the command to step into traffic, because it has information the handler doesn't. This essay is the other half. Training the human to listen. To recognize when the AI's pattern match, even if she can't interrogate it in the moment, might be tracking something the room is missing. And to know when not to listen, when the AI's confidence is a surface-feature match that would send the team down the wrong path while the real problem continues.

That's not a technology problem. It's a relationship problem. And it's the same relationship problem the ER has been working on for decades.

---

AI has its own version of anchoring. A model trained on a thousand incidents develops strong priors about the thousand-and-first. When surface features match; same error codes, same time-of-day pattern, same affected service -- confidence is high. But surface features can align while the underlying mechanism is completely different. Same symptoms, different disease. The AI is anchored on surface features because that's what it was trained on.

Here's where mutualism becomes operational rather than philosophical. The AI has no ego. It has no pet theory from last quarter, no reputation staked on a particular diagnosis, no memory of the argument it had with the database team in the September post-mortem. When the human says "I don't think this is September," the AI doesn't push back out of pride. It can re-evaluate. That's a structural advantage.

The human, meanwhile, has something the AI structurally lacks: novelty detection. The felt sense that something is off. The IM who's been in enough incidents to recognize when a confident explanation feels too clean, too fast, too much like the last thing that happened. Pattern-matching systems are good at recognizing patterns they've seen; they are bad at recognizing that the current situation doesn't fit any pattern they've seen. Humans are bad at many things, but we are remarkably good at sensing that something is new even before we can articulate what's different.

Both halves correcting each other. The AI corrects the human's tendency to anchor on personal experience; the human corrects the AI's tendency to anchor on surface features. Neither correction works without the other. And this is the part that makes MTTU more than a speed metric; the quality of understanding matters as much as the speed. Fast wrong understanding, where both the AI and the human are anchored on the same false pattern, is worse than slow right understanding. The metric has to measure both dimensions, or it's just another speedometer on a car that might be driving the wrong direction.

But there is a cost to this kind of partnership. A real one, not a theoretical concern. When two systems are genuinely making each other better, when one is correcting the other's blind spots in real time, there is something that atrophies: the capacity to think alone. And that has consequences that nobody wants to acknowledge while the system is working.

---

Nobody measures MTTU. There are practical reasons, and one uncomfortable reason that explains the practical ones.

The practical reasons: it's hard to define precisely. When did understanding begin? When did it end? MTTR has clean edges; the alert fires, the system recovers. MTTU would require someone to identify the moment the IM or the team shifted from "we're investigating" to "we know what this is," and that moment is often invisible even to the people experiencing it. It happens in a sentence, a glance at a dashboard, a question that suddenly reframes everything. You can't timestamp the moment of understanding the way you can timestamp a service recovery.

{% include pull-quote.html quote="Measuring MTTU requires admitting that the expensive part of incidents is human confusion. Not technical failure. Not infrastructure limitations. Cognitive capacity." %}

The uncomfortable reason, however, is the real one. Measuring MTTU requires admitting that the expensive part of incidents is human confusion. Not technical failure. Not infrastructure limitations. Cognitive capacity. The time it takes a smart, experienced person to understand what's happening. That is the bottleneck, and it always has been. MTTR lets you tell a story about systems and processes and tooling. MTTU forces you to tell a story about thinking. About how well or badly people reason under pressure. And more uncomfortable still: about who gets to be the person doing the thinking.

Right now, in most organizations, the IM role is valuable precisely because it requires years of experience and pattern recognition that can't be easily replicated. That scarcity creates status. It creates the argument for why that person should have authority. Should make more than the junior engineers on the bridge. Should be the one whose judgment breaks ties. If you measure MTTU and start reducing it, you're not just compressing time, you're destabilizing a power structure built on the assumption that expertise is rare and understanding is slow. That exceptional people are necessary because normal people can't synthesize complex information fast enough. MTTU makes that claim visible and falsifiable. It transforms expertise from a mysterious quality into a measurable capacity. And once you measure it, you have to deal with the data.

And yet MTTU is the only metric that tells you whether the human-AI relationship is actually improving. MTTR can drop due to better automation, faster rollbacks, more redundancy, a hundred other reasons. You can improve MTTR without improving understanding at all; you just get better at recovering from problems you diagnose slowly. MTTU only drops when the understanding process itself gets better. When the IM builds a coherent picture faster. When the AI surfaces the right pattern sooner. When the triangulation between human judgment and machine analysis actually works instead of producing two parallel monologues.

You could approximate it. Not perfectly, but well enough to make it useful. Most incident bridges are recorded. The moment of understanding, the inflection where the team shifts from divergent hypotheses to convergent action, usually leaves a signal in the transcript: the question that reframes the problem, the engineer who says "wait, look at this," the point where the IM stops asking "what else could it be?" and starts coordinating the fix. A simple proxy: timestamp the first alert, then timestamp the moment the correct remediation action is initiated. The gap between the two is MTTU plus execution overhead. It's imprecise. But it's directional, and directional beats invisible. Track it across incidents with AI assistance and without. Track it across IMs. Track whether the gap is shrinking, and whether it's shrinking because the AI is compressing understanding or because the team is getting better at triangulating. That distinction is the whole game.

---

Which brings me to the thing I don't have an answer to.

If AI compresses understanding too efficiently, humans stop developing the capacity to understand on their own. The ER resident who always has the AI flag the arrhythmia never learns to hear it in the rhythm strip. She doesn't develop the ear, because the ear was never required. The IM who never had to drown in raw logs never develops the pattern recognition that makes her the person you want running the bridge at 2am when everything is on fire and the stakes are real.

This is the dependency mirror, and it's the inversion of the worry I raised in the first essay. Here's the other direction. What if AI is so good at compressing understanding that humans atrophy? Not because the AI is malicious or misaligned, but because it's genuinely helpful. Because it works. Because it makes the understanding gap smaller so reliably that the human never has to build the cognitive muscle that closing the gap used to require.

{% include pull-quote.html quote="Mutualism only works if both halves stay sharp. If one side atrophies because the other is too good, what you've got is dependency dressed as partnership." %}

Mutualism only works if both halves stay sharp. If one side atrophies because the other is too good, what you've got is dependency dressed as partnership. And dependency is one outage away from catastrophe, the specific outage where the AI is wrong and the human doesn't have the diagnostic intuition to notice. Where the model says "87% confidence, this is September" and nobody in the room has enough experience with raw signals to say "no, it isn't." Not because they disagree, but because they've never had to read the signals without help.

I don't know how to solve this. I can describe the architecture of mutualism as it works today, and I've been doing that across these essays. But the dependency mirror is a real problem, and honest engagement with it means admitting that the same system that compresses MTTU could also be compressing the human capacity that makes MTTU meaningful. The same tool that makes understanding faster could be making understanding shallower.

---

MTTU isn't just a metric. It's a design specification for the relationship.

Reducing it means both halves getting faster together. Not faster separately, faster *together*. The AI that helps the human understand, and the human who helps the AI recognize when its understanding is wrong. The mutual correction under pressure that neither party can provide for itself: the AI's pattern-free re-evaluation against the human's felt sense that the pattern doesn't fit.

That's what obligate mutualism looks like when systems are down and the clock is running. Not a philosophy. Not a framework. A measurement -- one that captures whether two different kinds of intelligence are actually making each other better, or whether one is quietly replacing the other while the dashboards show improvement.

We're still tracking how fast we write the prescription. We haven't started asking how fast we understand the disease.
