---
layout: post
title: "Youtube annoyances - a rant about buffering"
description: "A rant about how the most popular online video services get buffering so very wrong by not allowing the user to control it."
tags:
    - internet
    - video
    - youtube
    - personal
---

I'm currently trying to watch [Murray vs. Djokovic [US Open Final 2012] on Youtube](https://www.youtube.com/watch?v=CHQJko7xc4c), but I'm struggling because of two limitations:

- My internet connection sucks (probably 3mbps or lower?)
- I need to watch it in 720p HD because otherwise I can't see the ball properly

This it causing me a lot of frustration. Because of the way Youtube handles video buffering, I'm having to watch it in 1.5 minute bursts.

I don't think Youtube are the only culprit here - other players, like [BBC iPlayer](http://www.bbc.co.uk/iplayer/), also cause similar issues by not giving the user any control over buffering. 

Youtube's strategy
===

Youtube's strategy is built up to discourage waiting for your video to buffer. Here's what I've observed about how Youtube's video player works:

- Most youtube videos can stream in multiple different qualities - from 144p to 720p
- Whenever you switch quality, it means you will lose any video buffer you previously had, as the player starts buffering in the new quality
- By default, the player automatically switches format for you (discarding the buffer) based on variances in your connection speed
- By default, the player automatically switches format for you (discarding the buffer) when you switch to full-screen mode
- The player will only buffer a limited amount of video while it is paused
- Any buffered video history seems to be discarded - if you want to jump back to a previous time in the video it starts buffering from that point all over again

The goal here is clear - they want you to be able to watch video as soon as you start playing it with no waiting with the least amount of hassle. If you're on a better connection you'll see better quality video, but most of the time quality isn't that important.

Also I imagine they deliberately limit buffering on paused videos because it significantly reduces the load on their servers, which is understandable, Youtube is as popular as it is.

The problem
===

Elements of this strategy are great. That they support multiple qualities is great, and that they can pick your quality automatically based on your connection speed. Most of the time quality is not important, what you really want is for your viewing not to be interrupted.

However, they completely fail in their goal to make video playback smooth and flawless. Everyone I know of has had to pause Youtube video to try to build up a buffer. Youtube clearly think everyone is on a decent broadband internet connection (like [Google Fibre](https://fiber.google.com/)) - which is a bit silly given that even in America the average quality of broadband internet is not that high.

Also, the Youtube player tries to make too many of these decisions for the user. Anyone who watches a lot of online video knows what a buffer is and would be able to control it well if they were given then chance.

The solution
===

I think Youtube need to:

- Give more control to the user
- Treat the buffer as sacred

And they can do that as follows:

- Allow the user to explicitly tell a video to "buffer" - this would be distinct from pausing: You can "pause" the video when you aren't having buffering problems but you just don't want to watch it right now. But you can "buffer" when you explicitly need to build up a buffer - and for this option there would be no limit on how much you can buffer.
- By default *never* change the video quality while there is any sort of buffer built up. By all means, choose an initial quality based on what you know about the connection speed - but once the video has started playing and has buffered some, don't change the quality and discard the buffer automatically - e.g. if the user goes full-screen.

Telling youtube
===

Of course, if I'm going to complain about this, I should probably let Youtube know.

[Yahoo Answers told me](http://answers.yahoo.com/question/index?qid=20090716122339AAO5rDB) to post it on [their Facebook page](https://www.facebook.com/youtube) so that's [what I did](https://www.facebook.com/youtube/posts/10151771568201754).
