---
title: Website front-end performance tips
date: 2012-03-13 00:00:00 Z
tags:
- dev
- performance
- front-end
- canonical
image_url: https://assets.ubuntu.com/v1/3e9feff8-Website+front+end+performance+tips.png?w=230&h=160&mode=fill&bg=0000
layout: post
---

## Design performance

 - Write the whole page design in CSS (no images) if at all possible
 - Mobile-first (with no images at all)
 - Design the page so all *all* images could be lazy-loaded without the page looking stupid
 - Obviously don't include unnecessary elements in the page

## Architecture

 - Lazy-load *all* images, depending on visibility
 - Serve all files yourself - then you can bundle them up into a single request
 - Use sprites wherever possible
 - Try to have *one* request for all JS, and one for all CSS.