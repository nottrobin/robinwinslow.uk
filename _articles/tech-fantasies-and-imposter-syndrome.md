---
cross_posts:
  DEV: https://dev.to/nottrobin/tech-fantasies-and-impostor-syndrome-3602
  Hacker News: https://news.ycombinator.com/item?id=36234743
date: 2022-06-07 23:46
description: Software is opaque; unknowable. This leads to a lot of pretence, pressure
  and imposter syndrome. There are some remedies.
email_campaign_id: 79940808df
layout: post
title: Tech fantasies and impostor syndrome
---

I'd be curious how old-school engineers feel, but to me it seems like software engineering has unique epistemological challenges.

This is because software is immediately complex, and there are really no theoretical limits on its potential complexity. Computer code is all about instructing computer chips to run what amounts to many thousands or millions of instructions. That's the point of computers. And it's incredibly easy to throw in an extra loop and add another ten thousand operations. 

That, coupled with the fact that no part of software is empirically visible: all instructions are sent to an opaque and unseen microchip.

Of course there are touch points where code is shared, reviewed, can be reasoned about together in real terms. But for the most part, any given line of code has only been looked at by a handful of people, or often a single person. And a whole codebase is vanishingly unlikely to be understood in its entirety by even a single person. Let alone a whole technology stack.

The implications of this visibility problem are huge, this is why computer *science* is a thing and observability is such a hot topic. Since it's incredibly hard to know exactly how any given program was written, we have to instead observe and study the behaviour of our programmes as if they were an unknowable black box.

I believe this lends anything to do with computers - software development, machine learning, high-frequency trading, hacking - an immediate mystique. And this mystique carries with it a very large number of negative consequences for the industry and the world.

In my experience, there's usually a level of pretence in those who work in tech. They have to exhibit competence over and confidence in domains that are almost entirely intangible and theoretical. Often, the person who appears the most technically competent is the person most willing to speak confidently about the reality of domains that we can all only picture in our heads.

And I believe this in turn makes impostor syndrome rampant in the software industry. Since it is, in practical terms, impossible to fully understand the domains within which we're all working, it would be a very unusual person who genuinely has 100% confidence in their ability. We're surrounded by fantasists desperately trying to convince everyone around them that they know exactly what they're doing, but we couldn't possibly actually think that of ourselves, and so we must be impostors.

People respond to impostor syndrome in different ways. Personally, my impostor syndrome used to manifest as an attempt to bluff my way through it, to appear superior to others so they wouldn't dare call me out. I think this is probably quite a common response, especially in men. Other people respond by withdrawing and becoming more timid, nervous to take any action.

This can very easily lead to a toxic mix. People lying about how well they understand their products, all trying to keep their head above water by trying to prove they know the unknowable more than the next person. People over-promise, desperate to exhibit their competence. They get themselves into messes of complexity and then when they can't deliver they shift the blame around.

And for more senior people in organisations this problem is exacerbated from both ends: They both have more responsibility over unknowably complex tech, and they are further from the actual implementation. So they make unfounded promises based on even less knowledge, based on high level assumptions about what should be possible, and then have no choice but to pass the pressure to deliver down to the engineers below them.

There are of course remedies to this. These are good practices in work in general, in human interaction in general, but because of the unique epistemological challenges of the tech industry, I believe they're absolutely essential in tech:

- Under promise: Try to understand everything you can as deeply as you can, but then overestimate your ignorance. Imagine all the things that could go wrong and then add some extra space beyond that. Introduce scepticism early about your ability to meet targets where there's any uncertainty.
- Have contingency plans: Think about what will happen if you don't deliver on a target, and take that possibility seriously. Decide what you would do in that situation.
- Collaborate: Where possible, work together with other people. Do pair programming. Share the way that problems have been solved, and solve them together.
- Over-communicate: Write down as much as possible about the process of doing the work. Share decisions and discussions widely.
- Keep solutions small and simple: Given the ease with which complexity can spiral out of control, out of concievability, in tech, the more you can break down work, the more you can deliver small, atomic units, the more likely to are to be able to deliver predictably.
- Be humble: Talk very openly about the things you don't know. Encourage others to do the same.
- Believe people: If someone tells you something is hard, believe them. If anyone ever says something "should be easy" call it out.
- No blame, systems thinking: When something goes wrong, do not blame individuals for it. If you see others doing it, call it out. If you allow blame to be thrown around, people will respond by putting up walls of pretence. So instead, focus on what system can be put in place to avoid that thing going wrong again.
- Demo: Share and demonstrate work as deeply as possible. Get as technical as possible in describing the work.
- Gather evidence, make things tangible: Do everything you can to create clarity over what the software is doing:
  - Write a concise set of clearly understood high-level tests that can really exhibit the health of a project.
  - Create a small number of key dashboards displaying health metrics for the software, and make sure people see them regularly in their daily work.
  - Know what impact given pieces of work are expected to have and check the work afterwards.

These are just some ideas, but overall the important thing is to encourage transparency, honesty, humility and understanding. Realise that the team is going on a journey of discovery together, and they need to be supportive to achieve success.