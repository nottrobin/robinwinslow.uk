---
title: Continuous Improvement and TDD/BDD
date: 2012-12-07 00:00:00 Z
tags:
- agile
- dev
- canonical
description: Introduction to Marcello's code workshops at Session Digital, and the
  principles of BDD and Simple Design.
image_url: https://assets.ubuntu.com/v1/b4f62061-Continuous+Improvement+and+TDD+BDD.png?w=230&h=160&mode=fill&bg=0000
layout: post
---

So, having just accompanied my blog on
[its existential quest](/2012/12/07/a-blogs-existential-quest/)
I have decided to start writing down rambling thoughts just for the process of solidifying them in
my mind - and not worry about their quality as prose.

Further to that, I have something I want to solidify.

I've been working in the offices of [Session Digital](http://www.sessiondigital.com/) today. Every
Friday, [Marcello](https://twitter.com/_md) runs a "code workshop" for an hour at the end of the
day, which I chose to attend. The purpose of this workshop is to encourage
[Continuous Improvement](http://en.wikipedia.org/wiki/Continual_improvement_process) techniques to
help coders improve the code they write.

His philosophy for this is based around the Japanese word [Kata](http://en.wikipedia.org/wiki/Kata),
which means "form" and as far as I can tell from the very brief introduction I was given is about
building good technique as habit through repetition, so you don't even need to think about it.

The repetition in question is repetition of performing coding while conforming to the rules of
[Test-](http://en.wikipedia.org/wiki/Test-driven_development)
(or [Behaviour-](http://en.wikipedia.org/wiki/Behavior-driven_development)) Driven Development and of
[Simple Design](http://en.wikipedia.org/wiki/Extreme_programming_practices#Simple_design), while also
working in pairs. We are given a programming problem to solve, and then asked to solve it over and
over again, trying to refine our "Form/Kata".

Rules of TDD (if these don't make much sense, go read more about TDD):

 - You may not write code except to make a failing test pass
 - You may only write a test until you have a failing state
 - You may only write code until you have made the test pass

Rules of Simple Design:

 - All test must pass before you may refactor/simplify code
 - There should be no code duplication
 - Code should be as expressive as possible
 - Code should be as simple as possible (eliminate complexity)

That is all for now.