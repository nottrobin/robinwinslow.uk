---
title: Chrome v25 breaks layout of date field
date: 2013-03-05 00:00:00 Z
tags:
- front-end
- dev
- progressive enhancement
- canonical
description: Chrome ruined my day by introducing a serious breaking change in the
  update to v25. The HTML5 input date type is likely to display wrong.
image_url: https://assets.ubuntu.com/v1/1535bd80-broken+chrome.png?w=230&h=160&mode=fill&bg=0000
layout: post
---

Chrome version 25 appears to have made a pretty serious change to how the [HTML5 input date type](http://www.w3.org/TR/html-markup/input.date.html) is rendered.

Now the `date` type defaults to `display: -webkit-inline-flex`, and (this is the bad bit) if you use `display: block` the layout breaks:

![date field layout broken](//i.imgur.com/K1HqV3L.png)

([try it yourself](http://jsfiddle.net/nottrobin/zjHbv/2/))

## Why is this bad?

We use the date type on [arena blinds](http://arena-blinds.com),
and to have more control over the layout of the input fields, they are all set to `display: block`.
I think this is, if not "best", at least a pretty common practice.

So one day we realised our date fields looked broken in Chrome, and it was because of this issue. So my boss said:

> If we can't rely on the date control not to break, we have to abandon the HTML5 date field altogether

And that's entirely fair reasoning.

## Cognitive dissonance

My boss's perfectly reasonable conclusion goes against everything progressive that I've been trying to instil in my team.

[Progressive enhancement](http://en.wikipedia.org/wiki/Progressive_enhancement) is accepted best practice nowadays - to
use the built-in functionality when it's there, with fall-backs for browsers that don't support it. E.g.:

``` javascript
if (!Modernizr.inputtypes['date']) {
    $('input[type=date]').datepicker();
}
```

This is a solid approach I strongly believe in.
But if Chrome are going to implement breaking changes like this, I don't know what to think any more.

Chrome, you've ruined my day.