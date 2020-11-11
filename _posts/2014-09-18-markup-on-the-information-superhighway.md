---
title: The importance of markup on the information superhighway
date: 2014-09-18 00:00:00 Z
tags:
- front-end
- dev
- blogging
- politics
- canonical
description: A fairly informal piece about the importance of understanding markup
  and the internet.
image_url: https://assets.ubuntu.com/v1/bea730a9-The+importance+of+markup+on+the+information+superhighway.png?w=230&h=160&mode=fill&bg=0000
layout: post
---

Following are my long-form notes for a [short presentation](http://prezi.com/rkxcaj2hebal/the-information-superhighway/) I gave to the [team here at Canonical](http://design.canonical.com/team).

---

We are all aware that the Internet is truly today's information superhighway.

So much of the world's information today is written in HTML that it's almost synonymous with "information".

HTML is the basic component of the Internet. We all use the Internet. If you take away CSS and JavaScript, you're left with just a whole bunch of HTML.

Understanding the interplay between markup and the Internet is important for anyone who writes content for the Internet

## Simplicity and accessibility

### Openness

We write JavaScript, CSS and back-end code for simplicity and clarity just so other *developers*, and probably only developer in *our team* can easily read and work on the code.

HTML is always the most public and central part of all our information, it is the *most import thing* to make as simple and intuitive as possible. Our HTML might be downloaded, viewed or hacked around with by *anyone*. They don't need to be a developer by trade. Anyone who knows how to "view source" can read our markup. Anyone who knows how to click "save web page" can hack around it.

### Good writing

I'd like to suggest that anyone who writes professionally, in today's world, should have some understanding of how markup works.

People in more and more areas have to write markup sometimes. Anyone who writes blogs in Wordpress has probably had to edit the raw markup at some point. But also, anyone who writes in any medium that might be converted into markup at any point in the future should be aware of some of the ways it works.

I would therefore posit that using the correct tag to markup your information is *as important as* choosing how to layout your word document (headings, bullet-points etc.).

If you're ever writing markup, go and familiarise yourself with the HTML extensions in HTML5. And if you have something new to markup (e.g. a pull-quote, a code-block or a graph) give it a Google, see what best practice is.

### Accessibility

A tempting attitude to take to writing markup is to focus on the average user, or maybe at least users within the inter-quartile range. If you look at Google Analytics, you will see that almost all visits to our sites are from people with modern, HTML5 & ECMAScript 5 capable browsers. As long as things look good on that setup, it's not *so* important to cover the edge-cases.

I would say that there are likely many flaws in this analysis. One is that maybe instead of hurting 1% of people by not worrying about the edge-cases, we're hurting 50% of the people, 2% of the time. Which, in terms of public opinion, is worse.

For example, if I try to load a website on the train (which I do more often than most, but many people do occasionally), there is a high likelihood that my connection will drop half-way through and I'll get a partially loaded page. At this point, since I will have downloaded the markup first, it is paramount that the markup looks sensible and contains all the relevant information.

Fortunately, there's a simple formula - if you understand the *basic* components for the web and write in them as simply and straightforwardly as you can, first, then most things will just work.

One of the beautiful things about the web is it's actually impossible to predict exactly how people are going to want to use it. But simplicity and directness are your friends.

## Referencing

The Internet is a collection of links. The real genius of HTML is its extremely light referencing system.

Referencing has been a core component of scientific work forever, but HTML and the Internet bring that scientific process to into the commons.

Not only that, but the whole structure of the Internet depends on references. Good linking makes documents more understandable - it's easy to follow a link to find out more about a base concept you don't properly understand.

People follow links to discover new content, but more importantly, search engines use these links to find new content and to categorise it for searching. The quantity, specificity and wording of your links contribute to the strength of the Internet.

This is where an understanding matters not just to people who write in HTML, but anyone who writes content for the Internet.

### Link often

When you're writing, especially if you're explaining a concept, if ever you use a term which you think could be described in more depth, find a link for it. People will thank you.

### Link text

Rather than just adding the full link into the page's text (e.g. "see: www.example.com"), or writing "click here", add the link to a relevant part of your sentence. This is important because search engines will use your link text to help describe what that link is about.

It's also helpful if your link text is not exactly the same as simply the title of the post you're linking to. This is because it's helpful for that page to be described in many different ways, organically, by people linking to it.

### IDs and anchors

Your readers will thank you for specific linking. If the topic you're trying to cover with your link is under a sub-heading half way down the document, see if you can find an anchor which will take them straight there (example.com#heading3).

On the development side, I believe that responsible HTML will contain IDs for this reason. Each heading, sub-heading or useful document section should ideally have an ID set on it, so people can link directly to that section if they need to.

## Thank you

You're not going to do most of what I've said above, most of the time. But I think just keeping it in mind will make a difference. Learning how to write responsibly for the web is a creative and infinite journey. But every time you publish anything, and even better if you make an extra link or find a new more specific markup tag, you're strengthening the Internet. Thank you.