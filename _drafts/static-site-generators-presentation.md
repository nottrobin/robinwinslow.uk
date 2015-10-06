---
title: static site generators presentation
---

(This is a fairly technical subject, I have difficulty knowing exactly how to pitch it)

Who would count themselves as a developer?

What I'm going to do:
- Complexity hurts
- Caching is bad
- Complexity hurts

Hillarys
---

I work for Hillarys. We make Blinds.

I'm going to tell you a little bit about why it sucks.

The main website I maintain is web-blinds.com.

- Ecommerce site based on Magento

Magento
---

This is the magento database: 

Magento is an extremely large project that does many many things. Almost everything you could ever want. They also tried to design the system to be endlessly flexible.

- Magento work like this (diagram):

request -> blinds page -> pull data together from the database -> put page together -> serve back to user
(10 seconds)

Caching is a problem
---

To counteract this, Magento has 8 caches and 8 indexes. If I make a change, a fix, or whatever, I'll probably have to clear a cache. I may have to rebuild indexes. Rebuilding all the indexes takes about 20 minutes.

This slows me down not only because I have to test my work, but also because I can't tell where the problem is.

Complexity breed complexity
---

Because I could never understand the whole of how the system operates, I end up coming up with the quickest way I can to solve a problem, and I tack it on the end. This makes the whole thing more complex, more disjointed, more layered.

The only solution is to take every opportunity to keep the project simple.

Simplicity is key
---

The main problem here is complexity. The complex a system is, the more layers it needs to deal with that complexity.

Websites in general
---

Magento is particularly complex, but most pieces of web software has similar problems

Here is wordpress's database

The problem with databases
---

Aside from the inherent performance problems, there's another problem with databases:

You can copy the files for a project easily. You can then put them on a different environment in exactly the same format. And you can tell the differences between two sets of files easily.

Databases are, unfortunately, more complicated. The data changes far too often and too easily. There are various solutions to this problem, but none of them are easy.

Databases are necessary...
---
...if you have dynamically updating data

Unfortunately, you do usually *need* a database. If you have an ecommerce website, people will be placing orders all the time. This data needs to be stored, and storing such rapidly updating data in files would not be efficient.

But let's think of a sort of website that doesn't have constantly updating data. A blog. Or a news site. Actually most sites on the internet are probably blogs or news sites.

A simple blog without a database
---



The end
---

If you get the chance, give static site generators a try.

More than that, take every opportunity you can to eliminate complexity. It will help so much in the long-run.

I'm trying out the opinion that you should try rewriting your project every 6 months.
