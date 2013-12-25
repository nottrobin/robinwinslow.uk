---
title: "Hosting my Jekyll static site on Heroku"
description: "The way I was hosting my blog on Heroku suddenly stopped working. I don't know why, but I've found a better way of doing things."
tags:
 - development
 - server-side
layout: post
---

For many moons I have been hosting my [Jekyll site](https://github.com/nottrobin/robin-blog) on a [Heroku cedar stack](https://devcenter.heroku.com/articles/cedar). Recently the setup I had stopped working, and I'm still not sure why. However, I solved it by simplifying things, and now I think my new solution is more simple and more robust.

How Jekyll works
===

[Jekyll](http://jekyllrb.com/) is a [static site generator](http://www.mickgardner.com/2012/12/an-introduction-to-static-site.html).

Static Site Generators take a set of templates in a particular format, and generate flat files from it in one step. Those flat files can then be serves directly as a web-page. This should make hosting much simpler.

My old setup
===

I used to configure my project to regenerate the website on the fly. Every time my Heroku Dyno spun up it would regenerate the site.

I did this using the following steps:



