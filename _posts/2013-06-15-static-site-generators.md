---
title: Blog like a pro with static site generators - it's easier than you think
date: 2013-06-15 00:00:00 Z
tags:
- dev
- blogging
- server-side
- canonical
description: Why technically proficient editors, bloggers, and especially web developers,
  should all use static site generators for their own sites
image_url: https://assets.ubuntu.com/v1/2fa38689-static+sites.png?w=230&h=160&mode=fill&bg=0000
layout: post
---

Static site generators (like [Jekyll](http://jekyllrb.com/) and [Hyde](http://ringce.com/hyde)) offer a much simpler and more transparent way to create a website. There's a small learning curve, but it's totally worth it. Especially if you're a developer already.

## What is a static site generator?

A piece of software that can read a set of files in a particular format and convert them into static files (e.g. HTML &c.) that can then be served directly as a website.

Note that just because a site is static on the server-side doesn't mean it can't be dynamic on the client-side. You can easily include comments and other dynamic functionality through JavaScript plugins.

The workflow goes something like this:

``` bash
$ sublime-text _posts/2013-05-30-why-i-love-the-internet.md # create a new blog post
$ jekyll --server # build the static site into my _site/2013/05/30/why-i-love-the-internet.html directory and run a test server
# check the site and my new blog post look okay
$ git add . && git commit -m 'new post: why i love the internet' # save it in version control
$ git push heroku # release the change to my live site (I use heroku)
```

## Why bother?

Personally I think static sites make managing websites really fun.

For the right kind of project, static sites can make it so much simpler to manage a site. They remove a whole bunch of concerns that you used to have to worry about (e.g. with CMSs like [Wordpress](http://wordpress.org/) or [Drupal](http://drupal.org/), or frameworks like [Django](https://www.djangoproject.com/), [Rails](http://rubyonrails.org/) or [Symfony](http://symfony.com/)):

- **caching** - You can forget about server-side caching, since you're already serving static files
- **databases** - You don't need a database - all the data is stored as files
- **version control** - You easily keep your whole site including document changes in version control
- **easy to start** - Hardly have to write any code to get started.
- **easy to maintain** - Tweaking your site is more transparent and direct - you can easily view and edit the static files directly.

## Which sites make sense?

Any site that needs to do anything complex on the server-side work will *not* be appropriate. However, any site which is basically just **a collection of static information** - like a **blog**, a **brochure site**, or even a **news or magazine site** - could work as a static site.

The other important thing is that everyone who wants to be able to edit the site needs to learn how to do it.

This needn't necessarily exclude anyone. Many static site generators use [Markdown document syntax](http://daringfireball.net/projects/markdown/basics), which anyone can understand and learn. [Github](https://github.com/) even has a lets you edit files directly online, which anyone with permission can use to edit the website files. Editors will have to understand the concept of version control, and understand how the site structure works, but this shared understanding will probably aid rather than hinder your project's progression.

In any case, if the only people who edit the site directly are developers then using a static site generator should come absolutely naturally.

## How?

There are many static site generators out there written in many different languages:

- ruby: [jekyll](http://jekyllrb.com/) | [middleman](http://middlemanapp.com/) | [nanoc](http://nanoc.ws/)
- python: [hyde](http://ringce.com/hyde) | [pelican](http://getpelican.com/)
- php: [phrozen](http://www.phrozn.info/en/) | [sculpin](https://sculpin.io/)

Personally I use [jekyll for my website](https://github.com/nottrobin/robinwinslow.uk). Originally this was because it is [natively supported in Github Pages](https://help.github.com/articles/using-jekyll-with-pages).

I'm not going to go into how to use a [Jekyll](http://jekyllrb.com/) in depth in this post, but I'll try to write another couple of posts soon:

1. How to set up a basic static site with Jekyll on Github Pages
2. How to host a Jekyll-based site on Heroku