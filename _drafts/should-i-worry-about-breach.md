---
title: "Should I worry about the BREACH vulnerability?"
description: "Should the BREACH vulnerability prevent me enabling Gzip compression on my SSL/TLS-enabled website?"
---

We recently realised that content on [our assets server][our-assets] wasn't being [compressed][http-compression], meaning the [performance of our websites][gzip-explained] wasn't quite what it could have been. We were just about to enable [mod_deflate][mod-deflate], when [Will][will-profile] discovered that enabling Gzip on a website with [TLS][TLS] might leave us vulnerable to [the BREACH attack][breach].

This left us with the question:

> Should we enable Gzip compression on our SSL/TLS-enabled site?

Ultimately we decided that BREACH didn't apply in our case, and so we should enable Gzip.

# What are BREACH and CRIME?

The BREACH attack is an implementation of the CRIME vulnerability discovered in 2011. While the original proof-of-concept, which relied on SSL compression, has bee almost entirely mitigated in modern servers and browsers, there is still a version of BREACH which works in very specific circumstances.

Do your users enter sensitive data on your site? And do you ever display this sensitive data back to them? If not BREACH probably doesn't apply to your site and so it's perfectly safe to enable compression.

However it's worth understanding the circumstances in which BREACH can be used against your site so you can be aware in case your site might become vulnerable in the future.

# When does BREACH work?

BREACH can be used to discover sensitive information in a web page if the web page response contains:

* Content submitted by the user *AND*
* Secret content which an attacker might want to find out

So, for a very contrived example, if your website has a `search` function, and for some reason the search results page displays *both* the entered search term *and* displays a user's credit card number, then these credit card numbers could be discovered using the BREACH attack:

![An illustration of the BREACH attack][breach-example]

Of course it may be much more subtle than this. There may be situations where user-entered data my be from hidden fields in a form and will be displayed only in the markup of the page and not displayed at all. And the sensitive information that is also displayed on the response page may be simply their username or email address, which could still be used maliciously.

# How does BREACH work?

The attack works by inspecting the size of compressed and encrypted responses coming back from the website's server. If a compressed response contains the same information twice, the compression algorythm will use this to optimise the response, and the response will be smaller. So in the example above, the response from `localhost/demo/Search?p=hello` will be larger than the response from `localhost/demo/Search?p=4545`, because in the latter case it matches the beginning of the credit card number.

This then allows the attacker to "guess" one character at a time of the sensitive information and tell if they have got it right by inspecting the size of the response.

## Specific circumstances

BREACH attacks must be directly targeted at a specific user. First of all, the attacker must setup a [man-in-the-middle][MITM] listening to all traffic being sent between the user and the website server, e.g. with an [evil twin network][evil-twin]. Then they need to know that the user is logged in to another site which has specific sensitive information that they want to retrieve, and is vulnerable to BREACH.

Once this is in place, the attacker must be able to cause the user's browser to make multiple requests to specific URLs, chosen by the attacker (e.g. `localhost/demo/Search?p=4545`). They can do this by using their man-in-the-middle to inject JavaScript into an unencrypted page, or by sending an email with an image linking to the required URLs. Then they can inspect the encrypted response from the server.

# How to prevent BREACH

The most obvious way to prevent BREACH is not to use compression in the response. However this is less-than-ideal, as compression can bring with it significant performance gains.

First of all consider whether your site will be vulnerable to BREACH at all.

**Your site won't be vulnerable if any pages which return user-entered data straight back to the user *definitely* don't contain any sensitive data.**

If your site is vulnerable to BREACH, then simply removing any cases where sensitive information is displayed on pages with user-controlled output will prevent BREACH.

If this is not possible, then there are [other ways to mitigate BREACH][mitigations].

# Summary

BREACH is not the most serious vulnerability out there, as it probably only applies to a relatively small number of sites and requires specifically targeted attacks.

However, it is an attack without an effective security patch - it will still work against modern servers and browsers.

For this reason, I think it's worth being aware of so that you can take precautions to prevent your application becoming vulnerable:

- Display sensitive information back to the user as sparingly as possible
- Let users specify the content of the response as sparingly as possible
- Try to avoid ever doing the two together
- If you enable Gzip and TLS together, consider if they site is vulnerable, and apply a mitigation

[mod-deflate]: http://httpd.apache.org/docs/current/mod/mod_deflate.html "Apache mod_deflate"
[will-profile]: http://design.canonical.com/author/willmoggridge "Will Moggridge on design.ubuntu.com"
[gzip-explained]: https://developer.yahoo.com/performance/rules.html#gzip "Gzip and performance"
[breach]: http://breachattack.com/ "The BREACH attack"
[breach-example]: http://i.imgur.com/jDEw2uQ.png "An illustration of the BREACH attack"
[MITM]: https://en.wikipedia.org/wiki/Man-in-the-middle_attack "Wikipedia: Man-in-the-middle attack"
[evil-twin]: https://en.wikipedia.org/wiki/Evil_twin_(wireless_networks) "Wikipedia: Evil twin network"
[mitigations]: http://breachattack.com/#mitigations "Other ways to mitigate the BREACH attack"
[our-assets]: https://assets.ubuntu.com/v1/ "Ubuntu's assets server"
[http-compression]: https://en.wikipedia.org/wiki/HTTP_compression "Wikipedia: HTTP compression"
[TLS]: https://en.wikipedia.org/wiki/Transport_Layer_Security "Wikipedia: TLS"
