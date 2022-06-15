---
date: 2022-06-14
description: I've written a GitHub action to socialise my posts every time I commit.
  Let's try it out.
email_campaign_id: cbdf22c3e5
hn_url: https://news.ycombinator.com/item?id=31746320
title: Testing my "socialise" GitHub action
tweet_url: https://twitter.com/nottrobin/status/1536823132677349377
---

I've spent the last week or so writing [a bunch of scripts](https://github.com/nottrobin/social-poster) to automatically post my new articles to Twitter, Hacker News and a Mailchimp mailing list. I've been testing them manually with some of my existing articles (with [surprising](https://news.ycombinator.com/item?id=31653748) [success](https://news.ycombinator.com/item?id=31646936) on Hacker News).

I've now written [a GitHub workflow](https://github.com/nottrobin/robinwinslow.uk/blob/main/.github/workflows/publish.yaml) to run these scripts automatically when I publish a new article.

So here's my article that I'm going to test it with. When this is published, it should automatically update the frontmatter with the Hacker News link, and the Tweet link, and send an email.

The links to Hacker News and Twitter should appear at the bottom of this post. All being well.

Let's give it a go!