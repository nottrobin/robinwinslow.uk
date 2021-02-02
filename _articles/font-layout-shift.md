---
layout: post
title: Font loading performance and Cumulative Layout Shift
description: 'Most sites should use "font-display: optional"'
date: 2021-02-02 10:26
---

I just sent basically this as an email to my team, but since I think this is very interesting (to web experience & performance geeks) I'm gonna quickly throw it up as a post:

I just read [More than you ever wanted to know about font loading on the web](https://www.industrialempathy.com/posts/high-performance-web-font-loading/) (which I found on [Hacker News](https://news.ycombinator.com/)).

![Font loading CLS](https://i.imgur.com/606OjVu.gif)

This article is all about how best to load fonts. It looks like just another dude's opinion but it's actually got a really impressive depth of knowledge behind it.

## Summary

I really recommend reading the whole article, but here are the important points:

*   If you use non-native fonts, browsers' default font loading strategies often lead to[ Cumulative Layout Shift](https://web.dev/cls/) issues, and[ Largest Contentful Paint](https://web.dev/lcp/) issues
    *   Apart from bad scores being a bad user experience, these measures are also "[web vitals](https://web.dev/vitals/)" which[ will be](https://developers.google.com/search/blog/2020/11/timing-for-page-experience) used in Google's PageRank calculations from May 2021.
*   The best easy option to use is "font-display: optional"
    *   What this does is display using the best font that is immediately available. So if you first visit[ ubuntu.com](http://ubuntu.com) and don't have "Ubuntu" available, it will use the next font from the list (unless it's able to download "ubuntu" super fast, which might sometimes happen). Then it will still download and cache "ubuntu" and use it for the next page load.
*   Another option is to pick a fall-back font that matches the size characteristics of "ubuntu" (he provides[ a tool](https://www.industrialempathy.com/perfect-ish-font-fallback/?font=Montserrat) for finding one), so that there's minimal layout shift. Although presumably this option will have no impact on Largest Contentful Paint

## Use `"font-display: optional"`

Long before Web Vitals came along, I was always quite frustrated at how fonts load on ubuntu.com - being invisible on first load, or swapping fonts in the first second - and it is far from the worst offender.

`font-display: optional` sounds like the perfect compromise between performance & user interests, and the desire to present elegant professional designs. It doesn't slow down the user unnecessarily, but will lead to most people getting the best experience most of the time.

## Browser no longer share caches

I learned something else quite interesting from this article, although it's actually news from over a year ago:

I was aware that performance gurus had stopped recommending linking directly to shared file host CDNs like `fonts.google.com`, but I assumed it was because someone had noticed that people rarely actually had these files cached in practice (which is probably true).

In fact there's a much more solid reason: browsers [no longer shared caches between domains](https://www.jefftk.com/p/shared-cache-is-going-away). This is because it opens up users to fingerprinting attacks, and it means that the stated benefit of shared CDNs has disappeared - even if someone has previous cached, say, `fonts.google.com/ubuntu.woff` on a different domain, our domains *can't* benefit from that because the browsers forbid it.
