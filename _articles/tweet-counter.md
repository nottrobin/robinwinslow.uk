---
cross_posts:
  DEV: https://dev.to/nottrobin/tweet-counter-a-module-to-calculate-the-length-of-a-tweet-4eon
  Hacker News: https://news.ycombinator.com/item?id=32424293
  Twitter: https://twitter.com/nottrobin/status/1557695935563571208
date: 2022-08-10
description: Count the number of "characters" in a tweet, according to Twitter's character
  counting rules
email_campaign_id: 4f557b85c9
tags:
- python
- cli
- showdev
- devjournal
title: 'Tweet-counter: A module to calculate the length of a tweet'
---

If you want to automate posting of tweet using Python, it's pretty important to know if your tweet exceeds the 280-character limit.

It turns out, working this out is non-trivial, as Twitter has [a few rules](https://developer.twitter.com/en/docs/counting-characters) around how it count's characters. These are basically:

- Twitter will convert anything that looks like a URL (with a [valid TLD](https://data.iana.org/TLD/tlds-alpha-by-domain.txt) - e.g. `example.ae`) into a Twitter short link, and count it as taking up exactly 23 characters
- Twitter counts emoji and any unicode character above `U+2037` as each taking up 2 characters

To it's credit, Twitter [provides official open-source libraries](https://github.com/twitter/twitter-text) for calculating tweet length.

But there isn't a library for Python that I could find. So I made one. It's probably far from perfect, but it does at least take into account the top two conditions, which should cover most common English-language use cases.

```
$ pip3 install tweet-counter
$ count-tweet "Otters 👪 otters 𝗼𝘁𝘁𝗲𝗿𝘀 otters otters.com/otters"
60
```

I'm hoping to use it in an automatic tool for turning blog posts into twitter threads that I'm working on.