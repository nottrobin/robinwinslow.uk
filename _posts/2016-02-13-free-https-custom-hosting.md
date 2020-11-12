---
title: How to host your static site with HTTPS on GitHub Pages and CloudFlare
date: 2016-02-13 00:00:00 Z
tags:
- dev
description: The combination of the free services from CloudFlare and Github Pages
  make it incredibly easy to host a secure website.
image_url: https://assets.ubuntu.com/v1/5b0dd214-How+to+host+your+static+site+with+HTTPS+on+GitHub+Pages+and+CloudFlare.png?w=230&h=160&mode=fill&bg=0000
layout: post
---

There has been a [growing][] [movement][] to get all websites to use SSL
connections where possible. Nowadays, Google even [uses it as a criterion][] for
ranking websites.

I've written before about [how to host an HTTPS website for free with StartSSL
and OpenShift][free-https]. However, StartSSL is very hard to use and provides
very basic certificates, and setting up a website on OpenShift is a fairly technical
undertaking.

There now exists [a much simpler way to setup an HTTPS website][simple-https] with
[CloudFlare][] and [GitHub Pages][]. This only works for static sites.

If your site is more complicated and needs a database or dynamic functionality,
or you need an SHA-1 fallback certificate (explained below)
then look at my other post about [the OpenShift solution][free-https]. However,
if a static site works for you, read on.

## GitHub Pages

As most developers will be aware by now, GitHub offer a fantastic free
static website hosting solution in [GitHub Pages][].

All you have to do is [put your HTML files in the `gh-pages` branch][gh-pages-setup] of one of
your repositories and they will be served as a website at
`{username}.github.io/{project-name}`.

![GitHub pages minimal files](http://i.imgur.com/DBeJSBN.png)

And all files are passed through the
[Jekyll][] parser first, so if you want to split up your HTML into templates
you can. And if you don't want to craft your site by hand, you can use the
[Automatic Page Generator][].

![automatic page generator themes](https://camo.githubusercontent.com/d60800ddc54bf9d0317ca901e7fb14590167f7fd/68747470733a2f2f6769746875622d696d616765732e73332e616d617a6f6e6177732e636f6d2f626c6f672f323031322f706167652d67656e657261746f722d7069636b65722e706e67)

Websites on `github.io` also [support HTTPS][], so you can serve your site up
at `https://{username}.github.io/{project-name}` if you want.

![mytestwebsite GitHub pages](http://i.imgur.com/2ZvKJEP.png)

GitHub Pages also [support custom domains][] (still for free). Just add a `CNAME`
file to the repository with your domain name in it - e.g.
`mytestwebsite.robinwinslow.uk` - and then go and setup the [DNS CNAME][]
to point to `{username}.github.io`.

![mytestwebsite GitHub pages files](http://i.imgur.com/7EF2uwyg.png)

The only thing you can't do directly with GitHub Pages is offer HTTPS
on your custom domain - e.g. `https://mytestwebsite.robinwinslow.uk`. This is where
CloudFlare comes in.

## CloudFlare

CloudFlare offer a really quite impressive free DNS and CDN service. This free
service includes some really impressive offerings, the first three of which
are especially helpful for our current HTTPS mission:

- [Free automatic HTTPS for your domain][] - no need to buy a certificate
- [Page Rules][cloudflare-rules] - custom settings and redirects for URL patterns
- [HTTP Strict Transport Security][cloudflare-hsts] (HSTS) - protection from [MITM attacks][mitm]
- [DNSSEC][cloudflare-dnssec] - protection from DNS poisoning attacks
- [HTTP/2][cloudflare-http2] - optimised connections for browsers that support it
- [CNAME flattening][cloudflare-alias] - so you can use a [DNS CNAME][] at the domain apex
- ["Always online" protection][] - Your cached website will stay up even if the host goes down
- [Firewall][cloudflare-firewall] - intelligent protection against [DDOS attacks][]

The most important downside to CloudFlare's free tier SSL is that it doesn't
include the [fall-back to legacy SHA-1 for older browsers][cloudflare-sha1].
This means that the most out-of-date (and therefore probably the poorest) 1.5%
of global citizens won't be able to access your site without upgrading their
browser. If this is important to you, either find a different HTTPS solution or
upgrade to a [paid CloudFlare account][cloudflare-plans].

### Setting up HTTPS

Because CloudFlare are a CDN *and* a DNS host, they can do the HTTPS negotiation
for you. They've taken advantage of this to provide you with a free HTTPS
certificate to encrypt communication between your users and their cached site.

First simply setup your DNS with CloudFlare to point to `{username}.github.io`,
and allow CloudFlare to cache the site.

![mytestwebsite CloudFlare DNS setup](http://i.imgur.com/VxPqzgFg.png)


Between CloudFlare and your host the connection doesn't have to be encrypted,
but I would certainly suggest that it still should be. But crucially for us,
this encrypted connection doesn't actually need a *valid* HTTPS certificate. To
enable this we should select the "Full" (rather than "Flexible" or "Strict")
option.

![CloudFlare full SSL encryption](http://i.imgur.com/olf2JH2g.png)

Et voilà! You now have an encrypted custom domain in front of
GitHub Pages completely for free!

![mytestwebsite with a secure domain](http://i.imgur.com/eBgFJqp.png)

## Ensuring all visitors use HTTPS

To make our site properly secure, we need to ensure all users are sent
to the HTTPS site (`https://mytestwebsite.robinwinslow.uk`) instead of the HTTP
one (`http://mytestwebsite.robinwinslow.uk`).

### Setting up a page rule

The first step to get visitors to use HTTPS is to send a [301 redirect][]
from `http://mytestwebsite.robinwinslow.uk` to `https://mytestwebsite.robinwinslow.uk`.

Although this is not supported with GitHub Pages, it [can be achieved][] with
CloudFlare page rules.

Just add a page rule for `http://*{your-domain.com}/*` (e.g. `http://*robinwinslow.uk/*`)
and turn on "Always use HTTPS":

![CloudFlare always use HTTPS page rule](http://i.imgur.com/1l6tyIAg.png)

Now we can check that our domain is redirecting users to HTTPS
by inspecting the headers:

``` bash
$ curl -I mytestwebsite.robinwinslow.uk
HTTP/1.1 301 Moved Permanently
...
Location: https://mytestwebsite.robinwinslow.uk/
```

### HTTP Strict Transport Security (HSTS)

To protect our users from [man-in-the-middle attacks][mitm], we should also
turn on [HSTS with CloudFlare][] (still for free). Note that this can cause
problems if you're ever planning on removing HTTPS from your site.

If you're using a subdomain (e.g. `mytestwebsite.robinwinslow.uk`),
remember to enable "Apply HSTS policy to subdomains".

![CloudFlare: HSTS setting](http://i.imgur.com/tYam5yng.png)

This will tell [modern browsers][] to always use the HTTPS protocol for this domain.

``` bash
$ curl -I https://mytestwebsite.robinwinslow.uk
HTTP/1.1 200 OK
...
Strict-Transport-Security: max-age=15552000; includeSubDomains; preload
X-Content-Type-Options: nosniff
```

It can take several weeks for your domain to make it into the
[Chromium HSTS preload list][]. You can check if it's in there, or add it
again, by visiting `chrome://net-internals/#hsts` in a Chrome or Chromium
browser and looking for the `static_sts_domain` setting.

## That's it!

You now have an incredibly quick and easy way to put a fully secure website
online in minutes, totally for free!

[HSTS with CloudFlare]: https://blog.cloudflare.com/enforce-web-policy-with-hypertext-strict-transport-security-hsts/ "CloudFlare blog: Enforce Web Policy with HTTP Strict Transport Security (HSTS)"
[free-https]: /2014/08/26/host-your-site-with-https-for-free/ "Robin Winslow: Host your site with HTTPS for free"
[CloudFlare]: https://www.cloudflare.com/ "CloudFlare is a free global CDN and DNS provider that can speed up and protect any site online"
[Github Pages]: https://pages.github.com/ "Github Pages: Websites for you and your projects"
[simple-https]: https://sheharyar.me/blog/free-ssl-for-github-pages-with-custom-domains/ "Sheharyar Naseer: Set Up SSL on Github Pages With Custom Domains for Free"
[Jekyll]: https://jekyllrb.com/ "Jekyll: Transform your plain text into static websites and blogs."
[support HTTPS]: https://konklone.com/post/github-pages-now-sorta-supports-https-so-use-it "Eric Mill: GitHub Pages Now (Sorta) Supports HTTPS, So Use It"
[support custom domains]: https://help.github.com/articles/setting-up-a-custom-domain-with-github-pages/ "GitHub help: Setting up a custom domain with GitHub Pages"
[DNS CNAME]: https://en.wikipedia.org/wiki/CNAME_record "Wikipedia: CNAME record"
[gh-pages-setup]: https://help.github.com/articles/creating-project-pages-manually/ "GitHub help: Creating Project Pages manually"
[301 redirect]: https://moz.com/learn/seo/redirection "MOZ: Redirection"
[HSTS]: https://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security "Wikipedia: HTTP Strict Transport Security"
[is in fact superior]: https://www.eff.org/deeplinks/2014/02/websites-hsts "EFF: Websites Must Use HSTS in Order to Be Secure"
[modern browsers]: http://caniuse.com/#feat=stricttransportsecurity "Can I use... Strict Transport Security"
[ghp-https]: https://konklone.com/post/github-pages-now-sorta-supports-https-so-use-it#telling-search-engines "Eric Mill: GitHub Pages Now (Sorta) Supports HTTPS, So Use It - Telling search engines"
[growing]: https://www.chapterthree.com/blog/why-your-site-should-be-using-https "Why your site should be using HTTPS"
[movement]: https://www.youtube.com/watch?v=cBhZ6S0PFCY "Google I/O 2014 - HTTPS Everywhere"
[uses it as a criterion]: https://googlewebmastercentral.blogspot.co.uk/2014/08/https-as-ranking-signal.html "Google Webmaster Central Blog: HTTPS as a ranking signal"
[Free automatic HTTPS for your domain]: https://blog.cloudflare.com/introducing-universal-ssl/ "CloudFlare: Introducing Universal SSL"
["Always online" protection]: https://www.cloudflare.com/always-online/ "CloudFlare: Always Online™"
[cloudflare-hsts]: https://blog.cloudflare.com/enforce-web-policy-with-hypertext-strict-transport-security-hsts/ "CloudFlare: Enforce Web Policy with HTTP Strict Transport Security (HSTS)"
[cloudflare-dnssec]: https://www.cloudflare.com/dnssec/universal-dnssec/ "CloudFlare Universal DNSSEC"
[cloudflare-alias]: https://blog.cloudflare.com/introducing-cname-flattening-rfc-compliant-cnames-at-a-domains-root/ "CloudFlare: Introducing CNAME Flattening: RFC-Compliant CNAMEs at a Domain's Root"
[cloudflare-firewall]: https://www.cloudflare.com/features-security/ "CloudFlare: Security"
[cloudflare-rules]: https://support.cloudflare.com/hc/en-us/articles/200168306-Is-there-a-tutorial-for-Page-Rules- "CloudFlare support: Is there a tutorial for Page Rules?"
[can be achieved]: https://support.cloudflare.com/hc/en-us/articles/200170536-How-do-I-redirect-all-visitors-to-HTTPS-SSL- "CloudFlare support: How do I redirect all visitors to HTTPS/SSL?"
[mitm]: https://en.wikipedia.org/wiki/Man-in-the-middle_attack "Wikipedia: Man-in-the-middle attack"
[Chromium HSTS preload list]: https://hstspreload.appspot.com/ "Chromium HSTS preload list"
[cloudflare-http2]: https://www.cloudflare.com/http2/ "CloudFlare HTTP/2"
[DDOS attacks]: https://en.wikipedia.org/wiki/Denial-of-service_attack "Wikipedia: Denial-of-service attack"
[cloudflare-plans]: https://www.cloudflare.com/plans/ "CloudFlare: Plans"
[Automatic Page Generator]: https://github.com/blog/1081-instantly-beautiful-project-pages "GitHub: Instantly Beautiful Project Pages"
[cloudflare-sha1]: https://blog.cloudflare.com/sha-1-deprecation-no-browser-left-behind/ "CloudFlare blog: SHA-1 Deprecation: No Browser Left Behind"