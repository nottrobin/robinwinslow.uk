---
date: 2023-06-08
description: Some guiding principles for creating platform tools for DevSecOps enablement
title: Principles for platform engineering
---

I've learned a lot about how to build a good engineering team in my time at Canonical. An important piece of this was a term I ran into about a year ago, although it's definitely been around significantly longer than that: [Platform engineering](https://thenewstack.io/devops-is-dead-embrace-platform-engineering/).

Platform engineering is the deliberate design of an "internal developer platform" (IDF) to support developers in performing tasks to support the development and deployment of their projects. And, to me, it's a really essential component of good DevSecOps practice, to deliver projects in the most reliable way.

I've been reading [a lot more about](https://octopus.com/devops/platform-engineering/patterns-anti-patterns/) platform engineering recently, and mostly as an exercise to myself to solidify this knowledge, I'm going to write down some principles of good platform engineering:

1. *Invest in the platform*: If you develop a platform that falls into disrepair or is abandoned entirely, you will have done more harm than good. Don't steal good developers for the creation of the platform without replacing them - instead fully staff a new team to support the platform.
2. *Solve developer needs*: Start from key functions that the engineers actually need solved. Don't imagine use-cases, and don't create an overly general platform. Help out the developers. Test with developers. Ask for their feedback.
3. *Start small*: Don't try to solve everything at once. Find the most impactful place to create a platform enhancement and do that first, in isolation. Evolve from there.
4. *Create golden paths*: The most powerful part of platform engineering is the ability to create default paths for the most common use-cases that work out of the box.
5. *Focus on usability*: It's essential that the platform be simple, straightforward, easy to use. Use usability principles to make a well-described and pleasant interface.
6. *Empower developers*: Be very careful not to overly obfuscate or restrict developers' exposure to the underlying technologies. Platform tools should be deeply configurable, and, if possible, should act as progressive enhancements of the existing tools. Developers should be able to bypass the platform tools if needed.
7. *Encourage contributions*: While platform tools should be owned by a platform team, input and contributions should be encouraged from engineers and operations. It's best to operate in an open source model ([InnerSource commons](https://innersourcecommons.org/)).
8. *Avoid silos*: Platform engineering is a strategy for Dev(Sec)Ops, so its whole purpose is to create cohesion and overlap between developers, operations, security etc. This needs to be baked into the mission of platform development.