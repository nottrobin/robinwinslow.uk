---
title: A CSS tutorial for modern times
layout: post
description:
    An introduction to modern CSS best practice concepts, in multiple parts.
    Including CSS preprocessors, grouping of code, selectors best practice (don't use IDs)
tags:
    - CSS
    - front-end
    - development
---

This is a re-introduction to CSS in the modern context. There are a bunch of new ideas and tools out
there for CSS that have recently emerged, including:

 - Resets: eric mayer’s reset, normalise.css
 - Best practices: *CSS Lint*
 - Architectures: *OOCSS, BEM, SMACSS*
 - Grid systems: *960.gs, semantic.gs*
 - Frameworks: *foundation, bootstrap*
 - Preprocesspors: *LESS, SASS*
 - I will briefly introduce each of them and explore the problem tackled by each, before explaining
   how to bring them all together for an elegant and scalable CSS strategy.

What is CSS (in brief)
===

In the beginning of the internet there was only HTML. People used tables and <font> tags to make
their pages look how they wanted:

``` html
// Oldendays people thought capitals were cool. How wrong they were.
<TABLE><TR><TD><IMG class=”logo”></TD><TD><FONT size=”big”><!—title—></FONT></TD></TR></TABLE>
```

Problems with this approach included:

 - Duplication: styling information has to be repeated in multiple places
 - Separation: markup has to be edited to change styling
 - Accessibility: hard to parse or understand the document information

CSS solves all three problems (initially at least) by abstracting styling information into a
separate block or document:

``` html
// Moderndays people have realised that lowercase is much cooler
<link rel=”stylesheet” href=”mystyle.css” />
<header><img class=”logo”><h1><!—title—></h1></header>
```

``` css
/* mystyle.css */
header img {float: left;}
header h1 {float: right; font-size: big } 
```

Problems with CSS
===

CSS is a central part of any modern website project. Modern websites are larger and need more styling
information. Although there is a recent trend for designs to be simpler, with more repeated elements
and fewer elements in general, it is also true that CSS is expected to handle more of the styling, with
the introduction of *gradients*, *rounded corners*, *multiple backgrounds* and *CSS transitions*.

The design of modern website is also likely to change quite frequently, particularly for projects with
a strong focus on developing usability. This brings a set of problems - it needs to be quick to develop
new and existing style elements while maintaining consistency across the site. 

Inconsistent application
===

Size and structure
===

Nowadays people working on big projects *brag about getting their CSS down to under 10000 lines*.

The bigger the CSS, the more cumbersome is the task of keeping it tidy. A new developer may want to achieve
a styling effect that already exists but have no idea where to find it, so they just dump a new rule into
the bottom of a massive CSS file.

Repeatability
===

CSS solved the problem of repeated styling only at the highest level - if you have 2 elements in the HTML
that you want to look the same you can give them the same class. However the majority of CSS projects still
contain plenty of repetition within blocks - leading to bigger CSS which is header to maintain because
rules need changing in multiple places:

``` css
header {margin: 10px auto; max-width: 960px; background-color: black;}
footer {margin: 5px auto; max-width: 960px; background-color: grey;}
```
