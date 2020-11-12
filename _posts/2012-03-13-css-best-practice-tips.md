---
title: CSS best practice tips
date: 2012-03-13 00:00:00 Z
tags:
- CSS
- front-end
- best-practice
- dev
- canonical
description: Some (slightly contentious) general rules for writing good CSS.
image_url: https://assets.ubuntu.com/v1/a1aab0b1-CSS+best+practice+tips.png?w=230&h=160&mode=fill&bg=0000
layout: post
---

## Never use IDs

They are useless. You get no performance benefit from using IDs, and you confuse yourself by
adding more specificity rules that you have to think about (IDs bind harder than classes).
There is no situation where you use an ID that you could not instead use a class. Only use IDs
in mark-up to show sections in the document - for # hashtags. Never use them for CSS.

## Always make rules as generic as possible

You never know when a rule might need to be re-used, on a different element, so you should avoid
ever limiting a class to a specific tag name. So div.header is wrong. Just do .header. Also
using really specific rules makes it more likely that your CSS is going to get really confusing.

## Use class with semantics in mind

From [the W3C](http://www.w3.org/QA/Tips/goodclassnames#id01):

> Good names don't change. Think about why you want something to look a certain way,
> and not really about how it should look. Looks can always change, but the reasons for giving
> something a look stay the same.

You might have to break this rule if using CSS frameworks.
I'll leave that one up to you.

## Useful resources for CSS best practice

 - [About CSS lint](http://csslint.net/about.html)
 - [Web Designer Depot - CSS best practices](http://www.webdesignerdepot.com/2009/05/10-best-css-practices-to-improve-your-code/)
 - [Evotech - CSS best practices](http://www.evotech.net/blog/2007/04/css-best-practices/)
 - [Paul Irish - A new way of doing conditional IE CSS](http://paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/)