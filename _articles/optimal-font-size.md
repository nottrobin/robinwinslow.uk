---
redirect_from: /2013/02/18/optimal-font-size/
date: 2013-02-18
layout: post
description: An exploration of how to achieve the ultimate optimal font-size and spacing.
title: Optimal font-size, line-height and line-length
tags:
  - front-end
  - canonical
---

## Font-size

I googled "Optimal font-size", read first
[16 pixels](http://www.smashingmagazine.com/2011/10/07/16-pixels-body-copy-anything-less-costly-mistake/)
then [a dao of web design](http://alistapart.com/article/dao) and came to the conclusion that
the optimal font-size is _not to specify one_.

## Line-height

As for optimal line-height - around
[1.5em is common](http://www.smashingmagazine.com/2009/08/20/typographic-design-survey-best-practices-from-the-best-blogs/),
but [The Golden Ratio](http://www.pearsonified.com/2011/12/golden-ratio-typography.php) seems a little
neater. So that's a good standard.

## Line-length

As for line length - [golden ratio typography](http://www.pearsonified.com/2011/12/golden-ratio-typography.php)
claims that it should be proportional to line-height, which makes sense, but the equation they suggest
just doesn't make any sense.
A [Smashing Magazine article](http://www.smashingmagazine.com/2009/08/20/typographic-design-survey-best-practices-from-the-best-blogs/)
suggests that around 65 characters per line is ideal, but that most people go for more like 75.
`65em / 1.618 (golden) = 40.173` so I'm going to suggest that **41 times line height**.
