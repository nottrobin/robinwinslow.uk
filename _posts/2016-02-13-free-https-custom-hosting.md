---
title: How to host an HTTPS site on a custom domain completely for free"
description: "The combination of the free services from CloudFlare and Github Pages make it incredibly easy to host a secure website."
tags:
  - dev
layout: post
---

I've written before about [how to setup an HTTPS website for free with StartSSL
and OpenShift][free-https]. However, StartSSL is very hard to use and provides
very basic certificates, and setting up a website on OpenShift is a fairly technical
undertaking.

There now exists [a much simpler way to setup an slick HTTPS website][simple-https] with
[CloudFlare][] and [GitHub Pages][]. The only downsides are:

- It must be a static site
- There's no way to absolutely force every user to use HTTPS

GitHub Pages
===

As most developers will now be aware by now, GitHub offer a fantastic free static
hosting solution in [GitHub Pages][].

All you have to do is [put your HTML files in the `gh-pages` branch][gh-pages-setup] of one of
your repositories and they will be served as a website at
`{username}.github.io/{project-name}`. And all files are passed through the
[Jekyll][] parser first, so if you want to split up your HTML into templates
you can.

Websites on `github.io` also [support HTTPS][], so you can serve your site up
at `https://{username}.github.io/{project-name}` if you want.

GitHub Pages also [support custom domains][] (still for free). Just add a file
called with `CNAME` to the repository with your domain name in it - e.g.
`project.example.com` - and then go and setup the [DNS CNAME][] for `project.example.com`
to point to `{username}.github.io`.

The only thing you can't do directly with GitHub Pages is offer HTTPS
on your custom domain - e.g. `https://project.example.com`. This is where
CloudFlare comes in.

CloudFlare
===

CloudFlare offer a really quite impressive free DNS and CDN service. Of course
there are paid plans, but I myself can't see why you'd need one. This free
service includes some really impressive offerings, the first two of which
are really helpful here:

- Free automatic HTTPS for your domain
- HTTP Strict Transport Security (HSTS)
- DNSSEC
- Alias DNS records

Because CloudFlare are a CDN *and* a DNS host, they can do the HTTPS negotiation
for you. They've taken advantage of this to provide you with a free HTTPS
certificate to encrypt communication between your users and their cached site.

Between CloudFlare and your host the connection doesn't have to be encrypted,
but I would certainly suggest that it still should be. But crucially for us,
this encrypted connection doesn't actually need a *valid* HTTPS certificate.

So simply setup your DNS with CloudFlare to point to `{username}.github.io`,
allow CloudFlare to cache the site, turn on SSL, but turn off certificate
verification. Et. voila! You now have an encrypted custom domain in front of
GitHub Pages completely for free!

Encouraging HTTPS
===

As I said at the top, one of the downsides here is that you can't force *all*
your visitors onto HTTPS (they could choose to visit `http://project.example.com`
instead of `https://project.example.com`).

The way to do it would be to catch all users visiting `http://project.example.com`
and send them a [301 redirect][] to `https://project.example.com`.

However, there are other powerful ways that we can force many visitors to HTTPS
and encourage the others to use it.

HTTP Strict Transport Security (HTST)
---

The first thing we can do is turn on [HSTS with CloudFlare][] (still for free).
If you're using a subdomain (e.g. `project.example.com`), remember to enable
"Apply HSTS policy to subdomains".

[HTST][] [is in fact superior][] to the 301 redirect method. With a 301 redirect
you run the risk of a man-in-the-middle attacker intercepting the user *before*
the redirect has happened to secure the user. However, unfortunately [not all
browsers support HSTS][], so people using IE 10 or below will still be able to
visit the insecure site.

Tell search engines to use HTTPS
---

Firstly, always make sure any links to your site that you have control over
use the HTTPS version of the URL.

Then, if you add a `rel="canonical"` instruction ([thanks Eric Mill][ghp-https]) to your HTML pages:

``` html
<link rel="canonical" href="https://project.example.com/this-page" />
```

Then search engines like Google will only send people to the HTTPS version of
the page.

JavaScript redirecting
---

To catch any users who still come through to your site on plan unencrypted HTTP,
you could add a JavaScript snippet to redirect them (stolen [from Sheharyar Naseer][simple-https]):

``` html
<script>
    if (window.location.protocol != "https:") {
      window.location.protocol = "https";
    }
</script>
```

This will of course only catch people with JavaScript turned on. But hopefully
the number of people visiting your site by typing in the HTTP URL directly,
with IE10 or below and with JavaScript turned off is small enough not to be
too worried about.

[HSTS with CloudFlare]: https://blog.cloudflare.com/enforce-web-policy-with-hypertext-strict-transport-security-hsts/ "CloudFlare blog: Enforce Web Policy with HTTP Strict Transport Security (HSTS)"
[free-https]: /2014/08/26/host-your-site-with-https-for-free/ "Robin Winslow: Host your site with HTTPS for free"
[CloudFlare]: https://www.cloudflare.com/ "CloudFlare is a free global CDN and DNS provider that can speed up and protect any site online"
[Github Pages]: https://pages.github.com/ "Github Pages Websites for you and your projects"
[simple-https]: https://sheharyar.me/blog/free-ssl-for-github-pages-with-custom-domains/ "Sheharyar Naseer: Set Up SSL on Github Pages With Custom Domains for Free"
[Jekyll]: https://jekyllrb.com/ "Transform your plain text into static websites and blogs."
[support HTTPS]: https://konklone.com/post/github-pages-now-sorta-supports-https-so-use-it ""Eric Mill: GitHub Pages Now (Sorta) Supports HTTPS, So Use It"
[support custom domains]: https://help.github.com/articles/setting-up-a-custom-domain-with-github-pages/ "GitHub help: Setting up a custom domain with GitHub Pages"
[DNS CNAME]: https://en.wikipedia.org/wiki/CNAME_record "Wikipedia: CNAME record"
[gh-pages-setup]: https://help.github.com/articles/creating-project-pages-manually/ "Creating Project Pages manually"
[301 redirect]: https://moz.com/learn/seo/redirection "MOZ: Redirection"
[HTST]: https://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security "Wikipedia: HTTP Strict Transport Security"
[is in fact superior]: https://www.eff.org/deeplinks/2014/02/websites-hsts "EFF: Websites Must Use HSTS in Order to Be Secure"
[not all browsers support HSTS]: http://caniuse.com/#feat=stricttransportsecurity "Can I use... HSTS"
[ghp-https]: https://konklone.com/post/github-pages-now-sorta-supports-https-so-use-it#telling-search-engines "Eric Mill: GitHub Pages Now (Sorta) Supports HTTPS, So Use It - Telling search engines"
