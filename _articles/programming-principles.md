---
date: 2022-06-14T00:00:00+01:00
description: Some principles that I hold in high regard for solving problems well in programming
email_campaign_id: c9f6b6d2bf
hn_url: https://news.ycombinator.com/item?id=31736907
tweet_url: https://twitter.com/nottrobin/status/1536656713675378688
title: Programming principles
---

This is a list of principles that I respect for trying to write good software.

At the moment it's very rough. I shared it with my team on our internal team Discourse in this raw form. But I figure I might as well share it. Just remember it's a work in progress, I hope I come back and improve it sometime, but I probably won't.

---

[12 factor app](https://12factor.net/)

[**Design principles**](https://milkov.tech/assets/psd.pdf#page=185) from [A philosophy of software design](https://milkov.tech/assets/psd.pdf):

1. [Complexity is incremental](https://milkov.tech/assets/psd.pdf#page=24): you have to sweat the small stuff
2. [Working code isn’t enough](https://milkov.tech/assets/psd.pdf#page=25): Strategic vs tactical programming
3. [Modules should be deep](https://milkov.tech/assets/psd.pdf#page=31)
4. [Interfaces should be designed to make the most common usage as simple as possible](https://milkov.tech/assets/psd.pdf#page=39)
5. [General-purpose modules are deeper](https://milkov.tech/assets/psd.pdf#page=50)
6. [Different layers should have different abstractions](https://milkov.tech/assets/psd.pdf#page=56)
7. [Pull complexity downwards](https://milkov.tech/assets/psd.pdf#page=65): It’s more important for a module to have a simple interface than a simple implementation
8. [Separate general-purpose and special-purpose code](https://milkov.tech/assets/psd.pdf#page=72)
9. [Define errors (and special cases) out of existence](https://milkov.tech/assets/psd.pdf#page=88)
10. [Design it twice](https://milkov.tech/assets/psd.pdf#page=99)
11. [Comments should describe things that are not obvious from the code](https://milkov.tech/assets/psd.pdf#page=107)
12. [Code should be obvious](https://milkov.tech/assets/psd.pdf#page=152): Software should be designed for ease of reading, not ease of writing
13. [The increments of software development should be abstractions, not features](https://milkov.tech/assets/psd.pdf#page=162)

[Questions for a new technology](https://kellanem.com/notes/new-tech)

[A Management Maturity Model for Performance](https://infrequently.org/2022/05/performance-management-maturity/)

[GitHub repo: webpro/programming-principles](https://github.com/webpro/programming-principles)

[**Web API design**](https://robinwinslow.uk/api-design-ebook-2012-03.pdf):
- [Nouns are good; verbs are bad](https://robinwinslow.uk/api-design-ebook-2012-03.pdf#page=4)
- [Plural nouns and concrete names](https://robinwinslow.uk/api-design-ebook-2012-03.pdf#page=8)
- [Simplify associations - sweep complexity under the ‘?’](https://robinwinslow.uk/api-design-ebook-2012-03.pdf#page=9)
- [Errors: Use HTTP status codes; Be descriptive](https://robinwinslow.uk/api-design-ebook-2012-03.pdf#page=11)
- [Versioning APIs](https://robinwinslow.uk/api-design-ebook-2012-03.pdf#page=14) - use whole numbers, maintain back versions  
  
  *I disagree with the advice to “never release an API without a version”. I think a lot of APIs stay on v1 for a very long time, especially if they’re not heavily used or worked on. For this reason, I’d say drop the version number for the first version, and  only introduce it when you need to create /v2/.*
- [Use “limit” and “offset” for pagination](https://robinwinslow.uk/api-design-ebook-2012-03.pdf#page=17)
- [Indicate output format with a “filename” suffix (e.g. “.json”)](https://robinwinslow.uk/api-design-ebook-2012-03.pdf#page=20)
- [Use “?q=” for global search](https://robinwinslow.uk/api-design-ebook-2012-03.pdf#page=22)
- [Use an “api.” subdomain](https://robinwinslow.uk/api-design-ebook-2012-03.pdf#page=23)
- [Use the API facade pattern](https://robinwinslow.uk/api-design-ebook-2012-03.pdf#page=34)  
  See also: [wikipedia](https://en.wikipedia.org/wiki/Facade_pattern)
