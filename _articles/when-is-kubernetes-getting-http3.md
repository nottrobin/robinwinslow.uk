---
cross_posts:
  DEV: https://dev.to/nottrobin/when-is-kubernetes-getting-http3-2632
  Hacker News: https://news.ycombinator.com/item?id=34643200
date: 2023-02-02
description: HTTP/3 is rolling out across much of the internet. When will one of the
  biggest hosting platforms get support?
email_campaign_id: bd08cbd14b
title: When is Kubernetes getting HTTP/3?
---

The standard for HTTP/3, [RFC 9114](https://datatracker.ietf.org/doc/html/rfc9114), was published as a proposed standard in June 2022. This is significant:

> A Proposed Standard specification is stable, has resolved known design choices, has received significant community review, and appears to enjoy enough community interest to be considered valuable.

_([RFC 7127: Characterization of Proposed Standards](https://datatracker.ietf.org/doc/html/rfc7127))_

But for some reason I don't hear as much chatter about HTTP/3 as I used to HTTP/2 at a similar stage. I'm impatient for it though. It is [significantly faster](https://requestmetrics.com/web-performance/http3-is-fast), and although I can't find any actual energy benchmarks, the massive reduction in round-trips should mean it's significantly less energy intensive.

[My site](https://robinwinslow.uk) is [already on HTTP/3](https://http3check.net/?host=https%3A%2F%2Frobinwinslow.uk), courtesy of [CloudFlare](https://www.cloudflare.com/en-gb/), whom I believe are running [the nginx-quic custom build](https://quic.nginx.org/) of NGINX. This immediately brings HTTP/3 to around 20% of the internet, [according to Cloudflare](https://blog.cloudflare.com/application-security/). However, of course, this is only from the edge to the client. Most of the sites behind Cloudflare's cache will not be on HTTP/3.

Apart from that, [Wikipedia says that](https://en.wikipedia.org/w/index.php?title=HTTP/3&oldid=1136355726#Server) Caddy (0.1%), LiteSpeed (5%) and Microsoft IIS (3%) all support HTTP/3 out of the box. But one particularly tech stack is conspicuously absent here: Kubernetes.

For example, [ubuntu.com](https://ubuntu.com) (which I work on during my day job) [still doesn't support HTTP/3](https://http3check.net/?host=https%3A%2F%2Fubuntu.com). This is because getting it into Kubernetes [seems to be taking a while](https://github.com/kubernetes/ingress-nginx/issues/4760). It sounds like it won't land until NGINX merge it into their stable release.

Cloudflare [claimed](https://www.nginx.com/blog/our-roadmap-quic-http-3-support-nginx/):

> Our current target for completing the code merge into the NGINX mainline branch is the end of 2021, after which it will be a full part of the NGINX mainline branch and NGINX Plus in subsequent releases.

But there have been a couple of updates, one [in the comments under their blog post](https://www.nginx.com/blog/our-roadmap-quic-http-3-support-nginx/#comment-5884347500):

>  Tony Mauro: Product Management tells me that we hope to fully support QUIC and HTTP/3 by the end of 2022. Note that this is not a promise :-)

And another [on the Kubernetes issue](https://github.com/kubernetes/ingress-nginx/issues/4760#issuecomment-1119727603):

> stalkerg: HTTP/3 has some issues with SSL implementations it's why difficult to add it into NGINX. Basically, the responsibility between SSL lib and HTTP server became is dramatically different because we should support UDP protocol QUIC.

I don't have more information than this right now, but hopefully it'll get stabilised, merged, and then included in Kubernetes before the end of 2023. 🤞