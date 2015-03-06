---
title: A seachange in front-end best practice - but not for a while
layout: post
description: "With the advent of HTTP/2, many front-end performance best practices will change. But we should only switch over when the browser support is there."
tags:
  - dev
  - front-end
  - back-end
---

Despite [some reservations](https://queue.acm.org/detail.cfm?id=2716278), it looks like [HTTP/2](http://en.wikipedia.org/wiki/HTTP/2) is very definitely the future of the Internet.

Speed improvements
===

HTTP/2 may not be the perfect standard, but it will bring with it many long-awaited speed improvements to internet communication:

- Sending of many different resources in the first response
- Multiplexing requests to prevent blocking
- Header compression
- Keep connections alive
- Bi-directional communication

Changes in long-held performance practices
===

I read [a very informative post](https://mattwilcox.net/web-development/http2-for-front-end-web-developers) today (via [Web Operations Weekly](http://webopsweekly.com/)) which laid out all the ways this will change some deeply embedded performance principles for front-end developers. Namely:

- [Combining CSS and Javascript](https://developer.yahoo.com/performance/rules.html#num_http) into one file
- [Image sprites](http://alistapart.com/article/sprites) (concatenation of images together in the same file)
- Serving assets [from a cookie-less domain](http://www.ravelrumba.com/blog/static-cookieless-domain/)
- [Sharding](http://www.stevesouders.com/blog/2009/05/12/sharding-dominant-domains/) - serving assets from many different domains

Each of these practices are hacks which make website setups more complex and more opaque, but with the goal of speeding up front-end performance by working around limitations in HTTP. Fortunately, these somewhat ugly practices are no longer necessary with HTTP/2.

Importantly, Matt Wilcox points out that in an HTTP/2 world, these practices might actually slow down your website, for the following reasons:

- If you serve concatenated CSS, Javascript or image files, it's likely you're sending more content than you strictly need to for each page
- Serving assets from different domains prevents HTTP/2 from reusing existing connections, forcing it to open extra ones

But not yet...
===

This is all very exciting, but note that we can't and shouldn't start changing our practices *yet*. Even [server-side support for HTTP/2](http://en.wikipedia.org/wiki/HTTP/2#HTTP.2FHTTPS_servers) is still patchy, with [nginx](http://nginx.org/) only promising full support by the end of 2015 (and Microsoft unusually leading the way).

But of course the main limiting factor will, as usual, be [browsers](http://en.wikipedia.org/wiki/HTTP/2#Browser_support):

- Firefox leads the way, with support since version 36
- Chrome has support for spdy4, but it isn't enabled by default yet 
- Internet Explorer 11 supports HTTP/2 only in Windows 10 beta

As usual the main limiting factor will be waiting for [market share of older versions of Internet Explorer to drop off](http://www.theie9countdown.com/). Braver organisations may want to be progressive by deliberately slowing down the experience for people on older browsers to speed up the more up-to-date and hence push adoption of good technology.

If you want to get really clever, you could serve a different website structure based on the user agent string, but this would really be a pain to implement and I doubt many people would want to do this.

Even with the most progressive strategy, I doubt anyone will be brave enough to drop decent HTTP/1 performance until at least 2016, as this is when nginx support should land; Windows 10 and therefore IE 11 will have had some time to gain traction and of course Internet Explorer market share in general will have [continued to drop][1] in favour of Chrome and Firefox.

TL;DR: We front-end developers should be ready to change our ways, but we don't need to worry about it just yet.

[1]: http://en.wikipedia.org/wiki/Usage_share_of_web_browsers#mediaviewer/File:Usage_share_of_web_browsers_(Source_StatCounter).svg
