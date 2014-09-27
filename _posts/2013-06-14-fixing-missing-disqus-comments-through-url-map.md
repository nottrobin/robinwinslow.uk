---
layout: post
title: "Fixing missing Disqus comments though the URL map tool"
description: "I spent a while working out why comments stopped showing up on my blog posts. I eventually discovered the cause and worked out how to fix it through the Disqus URL map tool."
tags:
    - blogging
    - dev
---

I noticed the other day that [Disqus](http://disqus.com/) comments that were appearing on my site stopped showing up. Articles that had had 2 or 3 comments had started saying "no comments".

Minor URL changes
===

After looking into it for a while, and googling a little bit, I realised that the reason was because I had made a [slight change to the way my URLs are structured](https://github.com/nottrobin/robinwinslow.co.uk/commit/3255ec30f3ae1f7faa13c942e4a5e9db07290a6e). For example:

```
https://robinwinslow.co.uk/2013/02/18/optimal-font-size.html -> https://robinwinslow.co.uk/2013/02/18/optimal-font-size/
```

I had very carefully made sure all the old URLs [redirected properly to the new ones](https://github.com/nottrobin/robinwinslow.co.uk/commit/af062d575f0b15e54027a2c3df0697162bb312b0).

The problem
===

Disqus didn't care that I'd taken all this care to create redirects. All it knew was that people had commented on an article at `../optimal-font-size.html` and now they were asking to see comments at `../optimal-font-size/` (with a `/` in place of `.html`), which isn't the same thing at all, apparently.

Incidentally I think that this was a bit shit of Disqus - they should use 301 Permanent redirects to link URLs automatically to avoid this issue.

Solution outline
===

Disqus, to their credit, [created a tool called "URL map"](http://blog.disqus.com/post/870654196/migrate-your-threads-by-uploading-a-url-map).

You can find the tool inside your Disqus admin area under [Discussions -> Tools](http://robin-blog.disqus.com/admin/discussions/migrate/) and use it to replace old incorrect URLs with the new ones.

Solution details
===

When you go to your [Disqus admin area](http://disqus.com/admin/moderate/) (filtered by site, if you like), you can click ["Discussions"](http://robin-blog.disqus.com/admin/discussions/) and then ["Tools"](http://robin-blog.disqus.com/admin/discussions/migrate/) and then "Start URL mapper".

Download existing URLs in CSV format
---

Now you can **download the CSV** of your existing URLs by clicking "you can download a CSV here". This is definitely a good idea.

Open it up in your favourite text editor. It will look just like a list of URLs:

```
https://robinwinslow.co.uk/2013/05/31/installing-symfony-2-by-creating-a-github-fork.html
https://robinwinslow.co.uk/2013/05/30/why-i-love-the-internet.html
https://robin-blog.herokuapp.com/2013/05/29/ease-magento-development-with-bootstrapped-scripts.html
...
```

You want to edit it to add in replacement URLs, so it looks something like this:

```
https://robinwinslow.co.uk/2013/05/31/installing-symfony-2-by-creating-a-github-fork.html, https://robinwinslow.co.uk/2013/05/31/installing-symfony-2-by-creating-a-github-fork/
https://robinwinslow.co.uk/2013/05/30/why-i-love-the-internet.html, https://robinwinslow.co.uk/2013/05/30/why-i-love-the-internet/
https://robin-blog.herokuapp.com/2013/05/29/ease-magento-development-with-bootstrapped-scripts.html, https://robinwinslow.co.uk/2013/05/29/ease-magento-development-with-bootstrapped-scripts/
...
```

Make it easier using regex in sublime
---

I edited it using [sublime text](http://www.sublimetext.com/) - a fantastic editor, which support [regular expressions](http://en.wikipedia.org/wiki/Regular_expressions). I used the following find and replace statement to transform the file into what I wanted it to be:

```
^(http://[^/]+)([^ .\n]+[^/.\n])/?(.html)?[^\n]*$
\1\2\3, https://robinwinslow.co.uk\2/
```

Which made it so much easier. If your requirements are similar to mine you can probably manage to copy this and tweak it slightly yourself. If they're different, you'll have to [learn regex](http://www.regular-expressions.info/tutorial.html) to use this solution if you don't already know it.

Upload the file
---

Now I uploaded the file back to Disqus through [the URL map tool](http://robin-blog.disqus.com/admin/discussions/migrate/), waited a few minutes, and voila! My old comments showed up under my new URLs!

As the tool will tell you, the only way to check this is to check if the missing comments start showing up again.
