---
layout: post
title: "Host your site with HTTPS for free"
description: "How to get completely free HTTPS (SSL or TLS) encrypted website hosting with Redhat Openshift."
tags:
    - back-end
    - dev
    - canonical
---

If you glance up to the address bar, you will see that this post is being served securely. I've done this because I believe strongly in the importance of [internet privacy](http://en.wikipedia.org/wiki/Internet_privacy), and I support the [Reset The Net](https://www.resetthenet.org/) campaign to encrypt the web.

I've done this *completely for free*. Here's how:

Get a free certificate
===

[StartSSL](http://www.startssl.com/) isn't the nicest website in the world to use. However, they will give you a free certificate without too much hassle. Click "Sign up" and follow the instructions.

Get an OpenShift Bronze account
===

Sign up to a [RedHat OpenShift Bronze account](https://www.openshift.com/products/pricing). Although this account is free to use, as long as you only use one 1-3 gears, it does require you to provide card details.

Once you have an account, create a new application. On the application screen, [open the list of domain aliases](https://www.openshift.com/blogs/domain-names-and-ssl-in-the-openshift-web-console) by clicking on the aliases link (might say "change"):

![Application page - click on aliases](//i.imgur.com/61cdNL8.png)

Edit your selected domain name and upload the certificate, chain file and private key. *NB: Make sure you upload the chain file*. If the chain file isn't uploaded initially it may not register later on.

Pushing your site
===

Now you can [push](https://www.openshift.com/developers/deploying-and-building-applications) any website to the created application and it should be securely hosted.

Given that you only get 1-3 gears for free, if you have a [static site](/2013/06/15/static-site-generators/), it's more likely to handle high load. For instance, this site [gets about 250 visitors a day](https://robinwinslow.uk/2013/06/28/public-analytics-data-for-this-site/) and runs perfectly fine on the free resources from OpenShift.
