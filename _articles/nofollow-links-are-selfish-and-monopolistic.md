---
title: '"Nofollow" links are selfish and monopolistic'
description: 'PageRank was a beautiful idea. Then nofollow ruined it.'
date: 2022-08-13
tags:
- devjournal
- opensource
- webdev
- ethics
---

Although [other search engines are available](https://ahrefs.com/blog/alternative-search-engines/), eveybody knows that [Google is all that really matters](https://www.oberlo.co.uk/statistics/search-engine-market-share#:~:text=Handling%20over%2090%25%20of%20all,done%20through%20the%20internet%20giant.). That's why there's [a $40 billion industry](https://www.globenewswire.com/en/news-release/2022/07/07/2475626/28124/en/Agencies-SEO-Services-Global-Market-Report-2022-Surge-in-Smartphone-and-Internet-Usage-Driving-Growth.html) dedicated to reading tea-leaves to discern how Google's mysterious search algorithm will behave.

The secrecy and monopoly of Google's search algorithm is as blatant as it is disgusting. But it's the behaviour of the rest of the web that I want to focus on today.

While nobody knows the particulars of the Google algorithm, we do know that it has its foundations in [PageRank](https://en.wikipedia.org/wiki/PageRank). This is the idea that underpins basically all search engines on the web, and it is both simple and beautiful.

> PageRank works by counting the number and quality of links to a page to determine a rough estimate of how important the website is. The underlying assumption is that more important websites are likely to receive more links from other websites.  
> _[Google's "Facts about Google and Competition", 2011 (archive.org)](https://web.archive.org/web/20111104131332/https://www.google.com/competition/howgooglesearchworks.html)_

The idea is that as people write articles on the web (like this one), they choose to link out to authoritative sources to support their writing. By looking at all the times people on the internet chose to refer to an articles on the web, we can organically learn and improve our understanding of the best sources of information.

This worked fairly well in 1998. The early web was mostly just people writing static articles. But as the web got more dynamic and started providing user-submitted comments, spam became a problem - since anyone could boost their PageRank simply by submitting hundreds of comments on other sites.

So in 2005, Google introduced [the nofollow attribute](https://en.wikipedia.org/wiki/Nofollow), and stated that any link carrying this attribute would not contribute to PageRank. By encouraging sites to add `rel="nofollow"` to any links submitted by the public, the incentive for spammers to spam links was removed. It's hard to say to what extent this achieved its intended goal. It certainly didn't remove all spam, and I believe that it also destroyed PageRank. Nowadays we have got pretty good at preventing spam, but it certainly wasn't the `nofollow` attribute that did it.

When `nofollow` was first conceived, it may have been true that much of the useful online discourse was in the form of articles. Still, even then, this attitude showed a certain sneering disregard for mere commenters who didn't own their own websites. And I remember the disdain with which people talked about comment theads - I sort of aluded to it in my recent article about [re-enabling comments](https://robinwinslow.uk/i-now-support-comments) on this blog. But even if that was true then, it certainly isn't now and hasn't been true for a long time.

Nowadays, it's plainly obvious that the vast _vast_ majority of writing and discussion produced by the human race is effectively "comments" on big tech's platforms (or at least, that seems to be their attitude). It's posts on Facebook and Twitter, comments on Quora and YouTube. And sure enough, every one of these platforms adds `rel="nofollow"` to every link. YouTube (which is fricking Google themselves) even adds it to the descriptions under their videos. Disqus, the biggest comments plugin for blogs, does it. And even the Tax Research UK blog, which looks entirely custom written, [does it in their comment section](https://www.taxresearch.org.uk/Blog/). The Giscus plugin I'm using on this blog does it, which is probably because GitHub also add `nofollow` to all links in issues and discussions.

While there is the odd merciful exception (StackOverflow don't add `nofollow` to links in questions and answers, only to comments on those answers), this basically means that the only links on the internet that carry any PageRank come from the owners of massive platforms. It's the small amount of content on Facebook's, Twitter's, Google's own editorial content, and it's major news sites. And have you noticed how seldom those news sites actually link off their own site? It's exceedingly rare. (And, of course, it's the odd blogger like me, but we will only ever be a drop in the ocean).

A big unanswered question here is - why? Why is everyone so bloody keen to add `rel="nofollow"` all over the place? Officially they're only strongly recommended [for paid links](https://developers.google.com/search/docs/advanced/guidelines/link-schemes).

I think it comes down to the pseudoscience of SEO. In the absence of any actually reliable information from Google about how their algorithm works, the whole industry is based on rumours and half-truths. One of these rumours is that if you link off to other sites, [you "leak" PageRank](https://blogs.cornell.edu/info2040/2015/10/17/will-outbound-links-reduce-the-pagerank/). This is definitely not true, [it's been thoroughly tested](https://www.rebootonline.com/blog/long-term-outgoing-link-experiment/) - in fact, the opposite is true, the more outbound links you have, the better your SEO. But I suspect it's one of those ideas that has taken hold. But I dispair at the cynicism of this trend. People are so willing to believe that they might accidentally give away something of value that they would rather withhold PageRank _just in case_ than do any actual research.

The funny thing is that this whole situation suites the major online players just fine. The authoritative sites on the web, [the alexa top 500](https://web.archive.org/web/20160819105430/http:/www.alexa.com/topsites), who have the power to actually influence Google's algorithm will, naturally, largely link to each other. They are the online establishment. The voices of the many are sidelined, the voices of the few raise each other up. It's almost like a racket. Our participation is discouraged by design. PageRank was a beautiful idea for the democratic discovery of human knowledge, and `nofollow` is the antidote.

Google have actually realised this major flaw in PageRank. For one thing, they don't actually properly respect `nofollow` - they [definitely do follow those links](https://www.semrush.com/blog/are-nofollow-links-actually-good-for-seo-here-is-proof/), just in their own secret way that nobody understands. And they have actually evolved their recommendations - they now [encourage the use](https://developers.google.com/search/docs/advanced/guidelines/qualify-outbound-links) of the more descriptive `rel="sponsored"` and `rel="ugc"` (for user-generated content). Although they do still suggest `nofollow`, and even suggest you combine them (worst of all worlds). And if you think they tell you explicitly how they actually treat these links, you've really not been paying attention.

So, although we internet users are fairly powerless to change this reality, all I can say is this: If you care about the open web, please don't deliberately add `nofollow` to links for anything other than actual spam and paid links. And if you are responsible for building a platform for users to publish comments or other online content, please consider letting them create links free from the tyranny of `nofollow`.

Go forth and link!