---
title: 'An awesome in-site user feedback tool - with Github integration'
description: 'How I discovered the Uservoice in-site feedback widget, and integrated it with Github Issues using Zapier'
layout: post
tags:
    - dev
    - front-end
    - UX
    - canonical
---

I was just entering an expense on [Splitwise](http://splitwise.com/)
and I noticed a subtle little widget in the bottom of the screen saying "Feedback".
"Aha!" thinks me. "This is exactly the sort of thing all websites should do".
So I click it and find out it's made by [Uservoice](https://Uservoice.com/).

Websites need user-feedback. They need it all the time.
So we need to be constantly offering users the opportunity to tell us what they think,
but also not annoy users by bugging them all the time,
and somehow try to avoid getting 50 of the same issue being submitted.

Well done Uservoice
===

I think Uservoice got this exactly right.
You get a subtle link appear on the side of the site saying one word - "feedback".
You probably noticed it, instantly know what it is there for, and it's easy to ignore if you want.

When you click it, you get given a list of current suggestions on the left that you can vote on,
or you can submit your own suggestion on the right. It's perfect.

The feedback link is totally customisable, and easy to include in your site with a simple Javascript snippet.

I use the service on this very site (look to the right).
Please click it to see Uservoice in action and please leave me some feedback :).

The missing link - Github Issues integration
===

Immediately I thought "where will these suggestions be stored?"
because I was already managing [my own list of ideas](https://github.com/nottrobin/robinwinslow.uk/issues) in
[Github Issues](https://github.com/blog/831-issues-2-0-the-next-generation) (augmented with [Huboard](http://huboard.com/))
and I didn't like the idea of having to maintain two lists, or manually copy issues between the two.

Someone had [already suggested integration](http://feedback.Uservoice.com/forums/1-general-feedback/suggestions/2967034-integrate-with-github-s-issue-tracking)
to Uservoice, but it turns out there's already a slick [solution with Zapier](https://zapier.com/zapbook/github/Uservoice/).

[Zapier](https://zapier.com/) is an integration service - for linking various different APIs.
And they already have built-in support for linking Uservoice to Github Issues.

But how much does it cost?
===

For this website I certainly can't afford to pay for either service.
So it's a good thing that both [Zapier](https://zapier.com/app/settings/plans) and [Uservoice](https://www.uservoice.com/plans/)
follow a  similar model to other modern digital projects like [Heroku](http://heroku.com/).
That is - it's **free for light or personal use**, but when you want to scale it you have to start paying.

Which suits me just fine.
