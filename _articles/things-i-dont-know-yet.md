---
cross_posts:
  DEV: https://dev.to/nottrobin/things-i-dont-know-yet-4nii
  Hacker News: https://news.ycombinator.com/item?id=34566831
  Twitter: https://twitter.com/nottrobin/status/1619645078196174849
date: 2023-01-29
description: These are technologies are mentioned a lot nowadays, and I'd like to
  know them better
email_campaign_id: ff88f6a234
title: Things I don't know yet
---

I've been in the same job for a long time, and using, broadly, the same tech stack. Some of this tech still sounds modern and relevant (Kubernetes, Docker, Typescript etc.), other bits not so much.

I'd like to understand better how the industry at large is developing, so here I'm going to create a list of technologies I'd like to look into, at least to understand the basics. I hope to write a little piece as I do it about my first impressions.

I hope to circle back and update this post as I find new tech to learn, or as I can tick things off the list.

## Technologies

So here are the technologies I hope to learn more about in the coming months:

### Terraform

This is an infrastructure-as-code tool. I believe it's basically trying to achieve the same thing as Canonical's Juju (which I'm more familiar with), and I suppose, at a stretch, other recipe-making tools like Ansible, Chef, Puppet etc.

I've done [the "Quick Start" interactive lab](https://developer.hashicorp.com/terraform/tutorials/azure-get-started/infrastructure-as-code#quick-start), which walks you through using it to create a Docker container, but that seems incredibly basic. I need to look a bit deeper into what it can actually do.

### Playwright JS

I've used Playwright for Python (and I'm hoping to write about it) but really it's more of a JS library. So I should just spin it up with JS so I know how that works.

### GraphQL

I love clean REST APIs. I know a fair bit about GraphQL, but I've never implemented a GraphQL interface myself. I should just quickly spin one up to see how neat it can be, and if it can avoid my primary concerns.

### Grafana Loki

I'd like to know more about Grafana, and especially Loki. We use Graylog for logs at Canonical and it's pretty cool, I understand that a fair bit, but Loki looks also interesting. We use Grafana already, but I don't understand it as much as I'd like to.

### Rust

Rust has really matured as a language. It's now officially in the Linux kernel, and is used is more and more places. I have close friends raving about it.

I really don't even know the basic syntax, so I'd really like to learn it, at least to the point of knowing how to install the core tooling and write and compile a basic script.

### Helm

Helm is a configuration manager for Kubernetes. At Canonical, we wrote our own configuration manager, which suited our purposes pretty well, but Helm is definitely the market leader. I should know how it works to see if we can get any ideas from it.

### Ruby

Ruby is not especially new. I think it's fair to say it's somewhat in decline against Python, which we use heavily. But it's still very relevant and it should be very easy for me to pick up the basics. It feels like a big hole in my knowledge.

### Svelte, vue.js

My JavaScript knowledge basically stagnated around 2015. I've written a small amount of React, but I really would like to know more about the patterns in use in modern applications. I don't want to go very deep, but it would be good to just get a basic site running in these two frameworks.

### Typescript

I believe most modern JavaScript shops are in fact writing Typescript these days. Similar to the front-end frameworks, I don't expect it to take me very long to learn, as I believe it's really just a light superset of JS that introduces strong typing (which is not a new concept to me). But I'd like to be able to talk about it with real knowledge.

### AWS, Azure, GCP

At Canonical we host and manage our own private OpenStack cloud (because we also sell these to enterprise clients). This has been fantastic for learning many things about how a cloud platform is set up in general. However, I have no idea how this experience actually compares to using AWS, Azure or GCP in anger. I should really get to the point of running a basic website on each of these platforms so I can understand the landscape of their Kubernetes, CDN, Serverless etc. services.

### Firebase and real-time databases

I believe Firebase offers a slick way to quickly add a data layer to an application, but I've never used it. I should use it in an application to understand what's involved.

### RabbitMQ and Kafka

I've never had the opportunity to use message queues or brokers, but I think they're very often essential in complex systems. So I'd like to learn more about how these two work specifically, so I could make use of them in future architectures.

### ActivityPub

Mastodon and the Fediverse are definitely in the ascendency. I'd like to understand the protocol and the very basics of how to build on top of it.

### Large-language models

I don't think any of us can afford to ignore the evolving space of Large Language Models. ChatGPT is likely to impact anyone in the knowledge economy in one way or another. I'm not exactly sure yet what there is to learn here. I suppose it's probably more about understanding how LLMs work so we can understand what they are and aren't capable of (staying far, far away from the deluded "general AI" narratives).

### Apache spark, pyspark

"Unified engine for large-scale data analytics". This sounds like it could be interesting. If it's in Python, how hard can it be?

### Tensorflow, pytorch

I'm not sure how far I want to go down this path specifically, but Tensorflow certainly has a lot of buzz. I'd like to know the rough shape of it at least.

### Kotlin

I've only heard this mentioned in a few places, but where it is mentioned people seem to love it. It's another new language, mainly talked about as a Java replacement. I'd like to learn the very basics so I can see if there are any new interesting programming structures or paradigms.

## What's missing

These are technologies that are in the news a lot, but which I'm not interested in learning at this point:

### Blockchain

Blockchain and cryptocurrencies definitely dominate the news cycle. I know a lot about this space already, even though I don't know how to write any of the tech. Blockchain itself might have a future in some niche that I'm not currently aware of, but I believe cryptocurrency has had its day, and will only decline from here.
