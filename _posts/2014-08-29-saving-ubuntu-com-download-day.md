---
title: 'Saving ubuntu.com on download day: caching location specific pages'
date: 2014-08-29 00:00:00 Z
tags:
- back-end
- front-end
- dev
- canonical
description: How we significantly reduced the load on the ubuntu.com servers by caching
  location-specific download pages.
image_url: https://assets.ubuntu.com/v1/74ef0c00-ubuntu+location.png?w=230&h=160&mode=fill&bg=0000
layout: post
---

<small>(This article is was <a href="http://design.canonical.com/2014/08/saving-ubuntu-com-on-download-day-caching-location-specific-pages/">originally posted on design.canonical.com</a>)</small>

On release day we can get up to 8,000 requests a second to [ubuntu.com](http://ubuntu.com) from people trying to download the new release. In fact, last October ([13.10](http://en.wikipedia.org/wiki/Ubuntu_13.10_Saucy_Salamander#Ubuntu_13.10_.28Saucy_Salamander.29)) was the first release day in a long time that the site didn't crash under the load at some point during the day (huge credit to the [infrastructure team](http://www.ubuntu.com/management/ubuntu-advantage)).

Ubuntu.com has been running on [Drupal](https://www.drupal.org/), but we've been gradually migrating it to a more bespoke [Django](https://www.djangoproject.com/) based system. In March we started work on migrating the download section in time for the release of [Trusty Tahr](http://en.wikipedia.org/wiki/List_of_Ubuntu_releases#Ubuntu_14.04_LTS_.28Trusty_Tahr.29). This was a prime opportunity to look for ways to reduce some of the load on the servers.

### Choosing [geolocated](http://en.wikipedia.org/wiki/Geolocation) download mirrors is hard work for an application

When someone downloads Ubuntu from ubuntu.com (on [a thank-you page](http://www.ubuntu.com/download/desktop/thank-you?version=14.04.1&architecture=amd64)), they are actually sent to one of the [300 or so mirror sites](https://launchpad.net/ubuntu/+cdmirrors) that's [nearby](http://en.wikipedia.org/wiki/Geolocation).

To pick a mirror for the user, the [application](https://en.wikipedia.org/wiki/Web_application) has to:

1. Decide from the client's [IP address](http://en.wikipedia.org/wiki/Ip_address) what country they're in
2. Get the list of mirrors and find the ones that are in their country
3. Randomly pick them a mirror, while sending more people to mirrors with higher bandwidth

This process is by far the most intensive operation on the whole site, not because these tasks are particularly complicated in themselves, but because this needs to be done for each and every user - potentially 8,000 a second while every other page on the site can be aggressively [cached](https://en.wikipedia.org/wiki/Cache_(computing)) to prevent most requests from hitting the application itself.

For the site to be able to handle this load, we'd need to [load-balance](https://en.wikipedia.org/wiki/Load_balancing_(computing)) requests across perhaps 40 [VMs](https://en.wikipedia.org/wiki/Virtual_machine).

### Can everything be done client-side?

Our first thought was to embed the entire mirror list in the [thank-you page](http://ubuntu.com/download/desktop/thank-you) and use [JavaScript](http://en.wikipedia.org/wiki/Javascript) in the users' browsers to select an appropriate mirror. This would drastically reduce the load on the application, because the download page would then be effectively [static](http://en.wikipedia.org/wiki/Static_web_page) and cache-able like every other page.

The only way to reliably get the user's location [client-side](http://en.wikipedia.org/wiki/Client-side_scripting) is with the [geolocation API](https://developer.mozilla.org/en/docs/WebAPI/Using_geolocation), which [is only supported by 85% of users' browsers](http://caniuse.com/#search=geolocation). Another slight issue is that the user has to give permission before they could be assigned a mirror, which would slightly hinder their experience.

This solution would inconvenience users just a bit too much. So we found a trade-off:

### A mixed solution - Apache geolocation

[mod_geoip2](http://dev.maxmind.com/geoip/legacy/mod_geoip2/) for Apache can apply server rules based on a user's location and is much faster than doing geolocation at the application level. This means that we can use Apache to send users to a country-specific version of the download page (e.g. [the German desktop thank-you page](http://www.ubuntu.com/download/desktop/thank-you?country=DE&version=12.04.4&architecture=amd64)) by adding `&country=GB` to the end of the URL.

These country specific pages contain the list of mirrors for that country, and each one can now be cached, vastly reducing the load on the server. Client-side JavaScript randomly selects a mirror for the user, weighted by the bandwidth of each mirror, and kicks off their download, without the need for client-side geolocation support.

This solution was successfully implemented shortly before the release of [Trusty Tahr](http://en.wikipedia.org/wiki/List_of_Ubuntu_releases#Ubuntu_14.04_LTS_.28Trusty_Tahr.29).