---
cross_posts:
  DEV: https://dev.to/nottrobin/whats-wrong-with-coding-tests-and-how-to-do-them-right-1h0b
  Hacker News: https://news.ycombinator.com/item?id=38648962
date: 2023-11-18 09:46
description: Ideas for improving coding tests, and some thoughts on how we got here
email_campaign_id: 521492653f
title: What's wrong with coding tests and how to do them right
---

Live coding tests are extremely common when hiring software engineers, and online coding tests with tight timeframes are just as common.

I'm far from the first person to mention how bad high-pressure coding tests generally are (e.g. [1][1], [2][2], [3][3], [4][4], [5][5], [6][6], [7][7]). But much like [open-plan offices](https://www.sciencedirect.com/science/article/abs/pii/S0272494408000728), high-stress coding tests seem to stubbornly persist despite [clear research findings](http://chrisparnin.me/pdf/stress_FSE_20.pdf) warning against them:

> Interviewers may be filtering out qualified candidates by confounding assessment of problem-solving ability with unnecessary stress.
> ...
> Our study raises key questions about the validity and equity of a core procedure used for making hiring decisions across the software industry. 

It's not just job candidate who aren't happy. Software developer jobs may be [objectively the hardest roles to fill](https://www.dice.com/career-advice/28-hardest-to-fill-technology-jobs-include-software-developer-engineer), with hiring managers [also bemoaning](https://www.quora.com/Why-aren-t-developers-passing-coding-tests-despite-being-given-lots-of-study-resources-What-gives-They-look-like-seniors-principals-on-paper-then-fail) how poorly many experienced developers perform on coding tests.

I believe many standard coding tests are woefully broken, and lead to companies hiring poor candidates and missing out on great ones.

(Jump straight to [my recommendations](#recommendations) or [my subjective philosophical and historical analysis](#the-big-picture))

# Ideas for improving coding tests

For the last couple of years in my previous role, there was a significant focus on hiring inside the company. I had the opportunity to research and think deeply about effective ways to hire good developers, although I only got to have minimal impact over the actual process.

Here are my well-researched thoughts:

## Reducing pressure

_Performing under pressure is not a useful skill for software engineers_

The most obvious flaw with coding tests is that many of them put candidates under a lot of pressure. Different people will respond differently to different sorts of pressure, but there are two things that we can be pretty sure will cause some anxiety in many people:

- Performing in front of an interviewer
- Performing under tight time pressure

Testing a candidates' performance under a particular type of pressure could be perfectly valid, if that was a clear requirement for the job. I would argue that for almost all development teams, this is not a key requirements. And if it is a requirement, it probably shouldn't be. A high-pressure working environment should be an undesirable temporary state for a software team that they should be working to resolve as quickly as possible, and hence, there's very little value to making this a key requirement for permanent employees.

If you think about the actual process of programming, very little of it is high-stress. It's usually a solitary activity where you have and need a lot of time to consider the shape of a problem and try out many different solutions. The sort of person who is good at this type of problem solving may very likely be the exact opposite to the sort of person who performs well under stress.

Studies show that anxiety hugely effects performance. I believe this is a key reason why many senior developers often fail coding tests, and therefore why companies find "good candidates" so hard to find.

Therefore our goal should be to try to reduce any possible source of anxiety when testing software engineers. To achieve this, I would recommend only using at-home technical tests that developers can do in their own time without a tight timeframe.

This doesn't completely negate the use of standard coding test tools like [HackerRank](https://www.hackerrank.com/) or [DevSkiller](https://devskiller.com/), but since both require setting a time limit (I think), I would suggest making this time limit something extra-generous like 1 day or more, instead of the much more common hour-or-two time limit.

## Targeting the right skills

_Test for the actual job requirements_

The next obvious question is what sort of exercises should we be setting to find the candidates we really need?

An extremely common practice is to set challenging algorithmic problems, like the ["balance a binary tree"](https://www.geeksforgeeks.org/convert-normal-bst-balanced-bst/) cliche. These sorts of tests are also the most hated.

It's incredibly rare that an engineer will need to solve complex and novel algorithmic problems in their day to day job. This means that these assignments will likely also cause a lot of anxiety, as candidates will be immediately know that this isn't something they have much experience doing. 

A tricky algorithmic brain-teaser is very unlikely to be the best way to find the engineers we really need. So what is?

Many tests will check for deep programming knowledge - for example, a Python test might test someone's knowledge of [`**kwargs`](https://realpython.com/python-kwargs-and-args/) or [the GIL](https://realpython.com/python-gil/). However, I would still argue that even deep testing of programming ability shouldn't be our primary driver, especially in more senior developers.

As developers get more senior, their job [tends to involve](https://staffeng.com/guides/what-do-staff-engineers-actually-do/) more and more things that aren't pure coding: mentoring, code reviews, stakeholder communication, architectural discussions, culture building etc. Therefore a developer will likely be sharpest at actual programming when they're somewhere between mid-weight and senior, and from then upwards their programming skills will take a back seat.

This isn't to say that we shouldn't be testing for technical knowledge. On the contrary, it means we should think very carefully about hiring for really valuable technical experience as opposed to esoterica that can be easily googled when needed.

These actually useful skills will look different for every team, but they may include:
- how they choose to structure their code
- how they design their interfaces
- how they make trade-offs between different sorts of performance
- whether their code is readable and accessible to other engineers

It's also worth considering the skills you're testing around the actual challenge. As there are many soft skills that are important in software engineering, if we can incorporate these into the test then so much the better. For example, asking them to submit a pull request will test not only the code, but also:
- their use of Git and GitHub
- their communication in describing pull requests
- potentially even how they discuss changes on a PR, whether they get defensive etc.

## Making efficient use of time

Another key reason why people hate coding tests is that they ask engineers to invest a lot of time for a job they likely won't get anyway.

I certainly don't have a silver bullet for this one. It's natural that employers want to do as much vetting up-front as possible to avoid a costly bad hire, and the more of that effort they can push onto the candidate the better for them, so they can spend their limited resources on pushing more candidates through the pipeline. And it's natural for the candidates to not want to do that work for free.

It would be great if employers paid candidates for their time, and [some do](https://duckduckgo.com/assets/hiring/how_we_hire.pdf), but most employers are unlikely to ever do this unless they have to. Ultimately this is just a power struggle that depends on the job market and who is more desperate.

But given that it's such a sort point, there is a real risk that great candidates will be put off by how expensive your hiring process is. So we should do all the up-front work we possibly can to reduce the time cost on both sides for each candidate.

This means thinking deeply about the most efficient way to test the skills we really care about. We should also consider where in the hiring process we need to test these skills. It's clearly going to be more palatable to candidates if they're asked do a lot of work once they're further through the hiring process and therefore more likely to actually get the job.

We should also do anything we can to reduce any set-up costs for the assignment.

## Recommendations

Taking all these points into account, my preferred type of technical tests would be either:

- Ask them to submit a pull request to an open source GitHub repository (other code hosts are available); or
- Ask them to review an existing pull request (this will naturally take up less of their time)

You can then discuss the code with them as in-depth as you'd like. You could even do a code review as an early stage in your hiring process, and then have them submit their own PR at a later stage in the process.

Either way, I believe there's huge benefit to tests centred around pull-requests into an open-source GitHub repository. It's also important that the assignment is something very close to the work they would actually be doing in the job.

For example, I really liked [the assignment I did a while back](https://www.linkedin.com/posts/robin-winslow-morris_tech-sector-job-interviews-assess-anxiety-activity-7100914498588286976-y4RL?utm_source=share&utm_medium=member_desktop) for [Deepset AI](https://www.deepset.ai/).

By doing a test within an actual project on a code hosting platform, you get to test the engineer's skills:

- within that platform
- in the version control technology
- in how they communicate around code

I believe this is the most time-efficient way to get an impression of how a prospective developer would perform their actual job.

If both sides are comfortable investing more time than this (so maybe in the very final stages), you can do actual pair programming on existing code problem together. You might even ask them to come into an office to do this. But this requires too much commitment to be a general-purpose assignment for a whole batch of candidates.

# How did we get here?

This is a big looming question over all this is. Why are we in this state where so many hiring processes are so chronically broken, given how much that must be costing companies?

I believe this all stems from a sort of tech exceptionalism, an idea that the point of hiring developers is to find the true geniuses, the worthy ones, in a sort of initiation ceremony.

Today's tech leaders were the bullied, four-eyed, scrawny geeks of the 80s and 90s. Back in the 90s and early 00s, there was a real feeling that these hackers and tech wizards were changing the world for the better by rejecting all the old precepts of the past. Mixed with a slight feeling of revenge against their cooler, tech-illiterate schoolmates, this led to this idea that software engineers were a superior breed, extra intelligent, and of course this worldview carried its own mythology.

All this landed into a western culture that was already fairly obsessed with IQ. That is, obsessed with the idea that some people were born with an innate superiority, and discovering which people were superior was a worthy goal.

To me, this is the only way in which these high-pressure algorithmic brain-teasers make sense in a hiring process - if you believe that you're searching for superior people who will be good at brain teasers and therefore good at everything else.

## The antidote

Of course the above worldview isn't at all accurate.

The IQ test is [not a very good predictor](https://www.youtube.com/watch?v=03JZfssM8XY) of most other skills. There are many many different sorts of "intelligence", and using generalised tests as a stand-in for actually assessing these skills directly is not only ineffective, but it will [introduce a lot of bias](https://www.tutor2u.net/psychology/reference/gould-1982).

The best way to assess people for a job will always be to get as close as you can to letting them actually do the job.

Coding tests, as with all sorts of hiring, will be most effective if they test for what's actually needed in the day-to-day job.

[1]: https://garrettdimon.com/journal/posts/live-coding-interviews
[2]: https://medium.com/swlh/why-you-should-never-consent-to-a-coding-test-in-an-interview-8e22f5078c7f
[3]: https://dev.to/bradstondev/why-i-stopped-interviewing-with-companies-that-require-a-coding-test-2j6n
[4]: https://www.quora.com/Are-coding-interviews-flawed
[5]: https://eliw.wordpress.com/2008/12/04/interviewing-programmers/
[6]: https://codingcraftsman.wordpress.com/2022/03/02/i-dont-want-to-do-your-stinking-coding-test/
[7]: https://brandonsavage.net/why-coding-tests-are-a-bad-interview-technique/