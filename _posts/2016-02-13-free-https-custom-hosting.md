---
title: "How to host your static site with HTTPS on GitHub Pages and CloudFlare"
description: "The combination of the free services from CloudFlare and Github Pages make it incredibly easy to host a secure website."
tags:
  - dev
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
[CloudFlare][] and [GitHub Pages][], with two small downsides:

- It must be a static site
- We can't ensure 100% of users use HTTPS (but we can get pretty close)

If your site is more complicated and needs a database or dynamic functionality,
then look at my other post about [the OpenShift solution][free-https]. However,
if a static site works for you, read on.

GitHub Pages
===

As most developers will be aware by now, GitHub offer a fantastic free
static website hosting solution in [GitHub Pages][].

All you have to do is [put your HTML files in the `gh-pages` branch][gh-pages-setup] of one of
your repositories and they will be served as a website at
`{username}.github.io/{project-name}`.

![GitHub pages minimal files](http://i.imgur.com/DBeJSBN.png)

And all files are passed through the
[Jekyll][] parser first, so if you want to split up your HTML into templates
you can.

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

CloudFlare
===

CloudFlare offer a really quite impressive free DNS and CDN service. Of course
there are paid plans, but I myself can't see why you'd need one. This free
service includes some really impressive offerings, the first two of which
are really helpful here:

- [Free automatic HTTPS for your domain][]
- [HTTP Strict Transport Security][cloudflare-hsts] (HSTS)
- [DNSSEC][cloudflare-dnssec]
- [CNAME flattening][cloudflare-alias]
- ["Always online" protection][]
- [A firewall][] to protect against DDOS attacks

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

Et voila! You now have an encrypted custom domain in front of
GitHub Pages completely for free!

![mytestwebsite with a secure domain](http://i.imgur.com/eBgFJqp.png)

Encouraging HTTPS
===

As I said earlier, one of the downsides here is we can't get quite 100%
of our visitors to use HTTPS (they could choose to visit `http://mytestwebsite.robinwinslow.uk`
instead of `https://mytestwebsite.robinwinslow.uk`).

The most robust way to get visitors to use HTTPS is to send a [301 redirect][]
from `http://mytestwebsite.robinwinslow.uk` to `https://mytestwebsite.robinwinslow.uk`. unfortunately
this is not supported with GitHub Pages.

However, there are other powerful ways that we can send many visitors to HTTPS
and encourage the others to use it.

HTTP Strict Transport Security (HSTS)
---

The first thing we can do is turn on [HSTS with CloudFlare][] (still for free).
If you're using a subdomain (e.g. `mytestwebsite.robinwinslow.uk`), remember to enable
"Apply HSTS policy to subdomains".

![CloudFlare: HSTS setting](http://i.imgur.com/tYam5yng.png)

This will tell modern browsers to always use the HTTPS protocol for this domain.

``` bash
$ curl -sI https://mytestwebsite.robinwinslow.uk
HTTP/1.1 200 OK
...
Strict-Transport-Security: max-age=15552000; includeSubDomains; preload
X-Content-Type-Options: nosniff
```

[HSTS][] [is in fact superior][] to the 301 redirect method. With a 301 redirect
you run the risk of a man-in-the-middle attacker intercepting the user *before*
the redirect has happened to secure the user. However, unfortunately [not all
browsers support HSTS][], so people using IE 10 or below will still be able to
visit the insecure site.

Tell search engines to use HTTPS
---

Firstly, always make sure any links to your site that you have control over
use the HTTPS version of the URL.

``` html
<a href="https://mytestwebsite.robinwinslow.uk">mytestwebsite</a>
```

Then, if you add a `rel="canonical"` instruction ([thanks Eric Mill][ghp-https])
to your HTML pages then search engines like Google will only send people to the
HTTPS version of the page:

``` html
<link rel="canonical" href="https://mytestwebsite.robinwinslow.uk/index.html" />
```

JavaScript redirecting
---

To catch any users who still come through to your site on plain unencrypted HTTP,
you could add a JavaScript snippet to redirect them
(modified [from Sheharyar Naseer][simple-https]'s solution):

``` html
<script>
  if (window.location.protocol != "https:") {
    window.location.protocol = "https";
  }
</script>
```

This will of course only catch people with JavaScript turned on. But hopefully
the number of people visiting your site who are:

1. Not coming from a search engine
2. Running IE10 or below and
3. Have disabled JavaScript

is small enough not to be too worried about.

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
[not all browsers support HSTS]: http://caniuse.com/#feat=stricttransportsecurity "Can I use... Strict Transport Security"
[ghp-https]: https://konklone.com/post/github-pages-now-sorta-supports-https-so-use-it#telling-search-engines "Eric Mill: GitHub Pages Now (Sorta) Supports HTTPS, So Use It - Telling search engines"
[growing]: https://www.chapterthree.com/blog/why-your-site-should-be-using-https "Why your site should be using HTTPS"
[movement]: https://www.youtube.com/watch?v=cBhZ6S0PFCY "Google I/O 2014 - HTTPS Everywhere"
[uses it as a criterion]: https://googlewebmastercentral.blogspot.co.uk/2014/08/https-as-ranking-signal.html "Google Webmaster Central Blog: HTTPS as a ranking signal"
[Free automatic HTTPS for your domain]: https://blog.cloudflare.com/introducing-universal-ssl/ "CloudFlare: Introducing Universal SSL"
["Always online" protection]: https://www.cloudflare.com/always-online/ "CloudFlare: Always Online™"
[cloudflare-hsts]: https://blog.cloudflare.com/enforce-web-policy-with-hypertext-strict-transport-security-hsts/ "CloudFlare: Enforce Web Policy with HTTP Strict Transport Security (HSTS)"
[cloudflare-dnssec]: https://www.cloudflare.com/dnssec/universal-dnssec/ "CloudFlare Universal DNSSEC"
[cloudflare-alias]: https://blog.cloudflare.com/introducing-cname-flattening-rfc-compliant-cnames-at-a-domains-root/ "CloudFlare: Introducing CNAME Flattening: RFC-Compliant CNAMEs at a Domain's Root"
[A firewall]: https://www.cloudflare.com/waf/ "CloudFlare: Affordable Web Application Firewall"
