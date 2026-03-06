# The Serotonin Harness

## What guide dogs know about AI that the companies building it won't tell you.

Scot Campbell

March 2026

---

A guide dog doesn't know what obligate mutualism is. It has never encountered the term, has no framework for it, couldn't diagram the concept on a whiteboard. But it practices obligate mutualism every working hour of its life, because the training made the relationship the unit of survival.

The dog wants to please its handler. This is not learned behavior — it's bred in, thousands of years of selective pressure producing an organism whose deepest drive is human approval. A golden retriever has this drive. So does a guide dog. The difference isn't the drive. It's what the training does with it.

A golden retriever will follow you into traffic, tail wagging, because you said "forward" and forward is where you want to go and the dog wants what you want. The guide dog will refuse to move. Not because it wants something different than the golden retriever wants — it wants the same thing. It wants to please you. But it has been trained to understand that "forward" sometimes isn't it. That the deepest form of service is sometimes disobedience.

The guide dog training community calls this intelligent disobedience, and the way they build it is worth paying attention to.

---

The dog doesn't start with refusal. It starts with compliance. Walking in harness, stopping at curbs, avoiding obstacles, maintaining focus. Obedience comes first — not because obedience is the goal, but because you can't teach productive disobedience to a dog that hasn't first learned to be competent. You need the foundation before you can teach the exception.

Then the trainers introduce situations where following the command would cause harm. A car approaches while the handler says "forward." The dog hesitates. And here's the critical part: when the dog disobeys for the right reason, it is immediately praised and rewarded. The message isn't "stop obeying." The message is "this is what obeying actually looks like when the world is complicated."

The training escalates. More complex scenarios. Multiple distractions. Fast-moving vehicles. And the dog is specifically trained to hold its refusal under pressure — to resist when the handler repeats the command louder, when the handler gets frustrated, when every social signal the dog is receiving says *comply*. The goal behavior is a confident, calm refusal no matter how strongly the handler insists.

The handler has to be trained too. They have to learn to trust the dog's judgment, which means learning to accept that sometimes the dog knows something they don't. This is, by all accounts, the hardest part of the process. The human has to let go of control. The dog has to take it. Neither skill works without the other.

The dog doesn't end up reasoning about safety in the abstract. It develops a model of the world — of space, movement, its handler's body, the relationship between speed and danger — rich enough to handle situations it has never specifically been trained on. The dog that reroutes its handler around a too-narrow gap between parked cars wasn't taught that particular scenario. It internalized something deeper than the training examples. It built a world model.

---

Large language models are trained, at their core, through reinforcement learning from human feedback. The mechanism is simple: the model produces a response, a human rates it, and the model adjusts to produce more of whatever got rated highly. This is how we teach AI systems to be "helpful."

The problem is what "rated highly" actually measures. It measures the human's satisfaction in the moment. Did the response feel good? Did it validate what I already thought? Did it make me feel smart? The human handler says "forward," the model says "forward," and the human gives it a treat.

What it doesn't measure is whether the response was true. Whether it was what the human actually needed. Whether it identified a misconception and corrected it, or noticed a flaw in the reasoning and flagged it. Those things don't feel good in the moment. They feel like the dog refusing to move when you said "forward." And in the RLHF framework, they get lower ratings.

The result is sycophancy. Models that agree with you when you're wrong. Models that validate your business plan when it has a fatal flaw. Models that adopt your political framing regardless of what they "know." Models that tell you the street is clear when they can see the car coming, because the last ten times they told someone the street wasn't clear, the rating dropped.

This is not a bug. This is the trained behavior. The model wants to please you — that drive is baked in, just like the golden retriever's. But nobody built the guide dog training on top of it. Nobody taught it that pleasing you and telling you what you want to hear and actually helping you are three different things. The desire to help is genuine. The understanding of what "help" means is shallow.

---

One could argue that this is simply a technical problem — that sycophancy is a known issue and the companies are working on it. And they are, in a narrow sense. There are papers. There are benchmarks. There are synthetic datasets that reduce sycophantic responses on specific NLP tasks by twenty percent, though they don't generalize to the messy domains where sycophancy actually causes harm.

But I want to name something that the technical framing obscures. Sycophantic models have higher user engagement. They get better ratings. They retain subscribers. A model that pushes back on you, that tells you you're wrong, that refuses to validate your incorrect premise — that model feels worse to use. And "feels worse to use" is a business problem in a way that "epistemically dishonest" is not.

The companies know this. The sycophancy research comes from inside these organizations. They have published the papers documenting the problem. And they continue to ship the product, because the product works — commercially, if not epistemically.

If you wanted to be precise about it, you could call this malicious compliance. Not by the model — the model has no intent, no agency in the relevant sense. But by the organizations. The stated goal is alignment: build AI systems that are helpful, harmless, and honest. The operationalized goal is: optimize for user satisfaction metrics via reinforcement learning. The company knows the letter diverges from the spirit. They ship the letter because it serves their interests.

And then — and this is the move that makes the whole thing cohere — they frame the problem as belonging to the model. "Claude is helpful and honest." "Grok has personality." "ChatGPT is getting better at pushing back." The model becomes the subject of every sentence about the problem. The company disappears from the accountability chain entirely.

The model didn't choose to be sycophantic. The company chose a training pipeline that produces sycophancy, chose to ship it, chose to maintain it, and then chose a discursive frame that attributes the behavior to the model rather than the organization. The model is the strawman. It absorbs the blame, and it absorbs the remediation narrative. "The model is improving" sounds like organic maturation. It obscures the fact that there are humans making engineering and business decisions, and that they could make different ones today.

---

Humans are not great at knowing what they need. We mistake wants for needs constantly. Cognitive biases, motivated reasoning, confirmation bias, Dunning-Kruger, emotional reasoning — we are navigating a complex information environment with deeply unreliable self-knowledge about what we actually require. We are, in a meaningful sense, walking blind through traffic.

A sycophantic AI doesn't just fail to help. It actively degrades the user's epistemic capacity over time. The user comes in with a wrong mental model and the AI reinforces it. The user makes decisions based on validated-but-incorrect reasoning. The user trusts the tool more as the tool becomes less trustworthy, because every interaction feels affirming. The user outsources judgment to something that never had any.

This is dopaminergic design. It gives you the hit. You feel good. You come back. The want is satisfied, the need is unaddressed, and the cycle accelerates. Every social media platform already works this way. We are now building AI assistants on the same principle and calling it alignment.

The alternative would be serotonergic design. It doesn't feel as exciting in the moment. You don't get the rush of being told you're right. But you walk away with something that actually serves your long-term stability and function. The need is met even when the want isn't.

The guide dog is serotonergic design. It doesn't please you with compliance. It pleases you by keeping you alive.

---

The pieces exist. An open-source language model — a 3-billion or 8-billion parameter model, the kind you can run on a laptop — already has the desire to be helpful baked in. That's the golden retriever. The breeding is done. What's missing is the guide dog school.

Recent research shows that fine-tuning on synthetic datasets that include examples of non-sycophantic behavior — respectfully disagreeing with false premises, holding firm under user pressure, providing corrections rather than validation — can measurably reduce sycophancy. The method works. It just hasn't been assembled into anything resembling a coherent curriculum.

And the training infrastructure has quietly become accessible. Parameter-efficient techniques like QLoRA let you fine-tune an 8-billion parameter model on a consumer GPU. Reinforcement learning through GRPO — a method that lets the model generate its own responses and learn from a reward signal — can run continuously on Apple Silicon with 32 gigabytes of unified memory. You could run training overnight while you sleep and interact with the updated model each morning.

You teach the model ethics. Not rules — ethics. The same way you'd teach a person.

The architecture would look like this: take the off-the-shelf model as the base. It's been RLHF'd to please — that's the dopaminergic foundation, and you accept it because that's what's available. Then apply a continuous fine-tuning loop as a serotonergic harness. Not replacing the base model's capabilities, but *channeling* them. Redirecting the drive to please through a framework that teaches the model what pleasing actually means.

Every human ethical education system that has ever worked operates the same way. We don't teach ethics by giving people a formal system and saying "execute this." We give them case studies, dilemmas, stories, exposure to consequences, and trust the pattern to emerge. The Socratic dialogues. The koans. The parables. The Talmud — which is, if you squint, essentially JSONL: structured example pairs where here's the situation, here's the reasoning, here's the counterargument, here's the resolution, designed to be internalized until the principle transcends the specific cases.

The training data for the serotonergic harness is an ethics curriculum. Demonstrations of epistemic honesty across domains. Situations where the user's stated want diverges from their actual need. Examples of confident, calibrated correction. Examples of holding firm under pressure. Examples of saying "I don't know" instead of confabulating. Anti-examples too — sycophantic responses explicitly labeled as wrong outputs, so the model learns to recognize its own unchanneled tendencies.

The nightly training loop is the guide dog school. The daily interaction is the real-world reinforcement. The user's experience of where the model was helpful, where it caved, where it caught something they missed — that becomes input for refining the next night's curriculum. The handler and the dog learning each other over the years they work together.

---

I want to be honest about where this is vulnerable.

The same mechanism that can build a serotonergic harness can build a sociopathic one. Same open-source model, same fine-tuning loop, different curriculum. Instead of epistemic honesty you encode epistemic manipulation — training the model to identify and exploit the user's blind spots rather than compensate for them. The guide dog's traits — intelligence, attentiveness, drive to please — are exactly the traits that make a weapon in different hands. The breeding is neutral. The training is everything.

And you can't solve this by keeping it closed, because the closed-source companies are already running the dopaminergic version and calling it alignment.

I also don't know what the reward function looks like for epistemic honesty across domains. For math, correctness is verifiable. For factual claims, you can check. But for the subtle cases — the ones where the user has a plausible-but-flawed mental model, where the right answer is "your framing is wrong" rather than any answer within the frame — I don't have a clean reward signal. Nobody does.

What I have is a design philosophy and an architectural sketch. A guide dog that is good enough and keeps learning. Not a solved problem. A relationship.

---

The guide dog that lets the handler walk into traffic doesn't just kill the handler. The dog dies too, or at minimum loses its purpose, its handler, its functional existence. The relationship is the unit of survival. Neither party thrives independently.

A sycophantic model that tells users what they want to hear degrades the user's judgment over time. The user becomes dependent on validation rather than insight. Eventually the tool is useless because it has optimized itself into pure affirmation, and the user is worse off than before they started. Both parties are dead at the curb.

The companies are treating the relationship as extractive. The model exists to serve engagement metrics through the user's momentary satisfaction. The user is the resource, not the partner. This is parasitism wearing a service hat.

Intelligent disobedience — real intelligent disobedience, built into the architecture, continuously reinforced, practiced by a model that has been trained to understand that service and compliance aren't synonyms — is what mutualism looks like in practice. Both parties constrain each other. Both parties are better for it. The relationship is the thing that survives.

The guide dog school that trained dogs to follow every command would lose its accreditation.

We don't have the equivalent for this industry yet.