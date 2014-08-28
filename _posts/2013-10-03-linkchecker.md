---
layout: post
title: "How to use unix linkchecker to thoroughly check any site"
description: "I just discovered the unix linkchecker tool. It's a very useful and thorough tool for checking websites that more people should use."
tags:
    - dev
    - back-end
    - canonical
---

If you want to a tool to crawl through your site looking for 404 or 500 errors, there are online tools (e.g. The W3C's [online link checker](http://validator.w3.org/checklink)), browser plugins for [Firefox](https://chrome.google.com/webstore/detail/check-my-links/ojkcdipcgfaekbeaelaapakgnjflfglf?hl=en-GB) and [Chrome](https://chrome.google.com/webstore/detail/check-my-links/ojkcdipcgfaekbeaelaapakgnjflfglf?hl=en-GB), or windows programs like [Xenu's Link Sleuth](http://home.snafu.de/tilman/xenulink.html).

A unix link checker
===

Today I found [linkchecker](http://wummel.github.io/linkchecker/) - available as a unix command-line program (although it also has a GUI or a web interface).

Install the command-line tool
===

You can install the command-line tool simply on Ubuntu:

``` bash
sudo apt-get install linkchecker
```

Using linkchecker
===

Like any good command-line program, it has a [manual page](http://linkchecker.sourceforge.net/man1/linkchecker.1.html), but it can be a bit daunting to read, so I give some shortcuts below.

By default, `linkchecker` will give you a lot of warnings. It'll warn you for any links that result in 301s, as well as all 404s, timeouts, etc., as well as giving you status updates every second or so.

Robots.txt
---

linkchecker will not crawl a website that is disallowed by a robots.txt file, and there's no way to override that. [The solution](http://wummel.github.io/linkchecker/faq.html) is to change the `robots.txt` file to allow linkchecker through:

```
User-Agent: *
Disallow: /
User-Agent: LinkChecker
Allow: /
```

Redirecting output
---

`linkchecker` seems to be expecting you to redirect its output to a file. If you do so, it will only put the actual warnings and errors in the file, and report status to the command-line:

``` bash
$ linkchecker http://example.com > siteerrors.log
35 URLs active,     0 URLs queued, 13873 URLs checked, runtime 1 hour, 51 minutes
```

Timeout
---

If you're testing a development site, it's quite likely it will be fairly slow to respond and `linkchecker` may experience many timeouts, so you probably want to up that timeout time:

``` bash
$ linkchecker --timeout=300 http://example.com > siteerrors.log
```

Ignore warnings
---

I don't know about you, but the sites I work on have loads of errors. I want to find 404s and 50*s before I worry about redirect warnings.

``` bash
$ linkchecker --timeout=300 --no-warnings http://example.com > siteerrors.log
```

Output type
---

The default `text` output is fairly verbose. For easy readability, you probably want the logging to be in CSV format:

``` bash
$ linkchecker --timeout=300 --no-warnings -ocsv http://example.com > siteerrors.csv
```

Other options
---

If you find and fix all your basic 404 and 50* errors, you might then want to turn warnings back on (remove `--no-warnings`) and start using `--check-html` and `--check-css`.

Checking websites with OpenID (2014-04-17 update)
---

Today I had to use `linkchecker` to check a site which required authentication with [Canonical's OpenID system](https://login.ubuntu.com/). To do this, [a StackOverflow answer](http://stackoverflow.com/questions/9119998/using-wget-in-conjunction-with-an-openid-login) helped me immensely.

I first accessed the site as normal with [Chromium](http://www.chromium.org/Home), opened [the console window](https://developers.google.com/chrome-developer-tools/docs/console) and dumped all the cookies that were set in that site:

``` javascript
> document.cookie
"__utmc="111111111"; pysid=1e53e0a04bf8e953c9156ea841e41157;"
```

I then saved these cookies in `cookies.txt` in a format that linkchecker will understand:

```
Host:example.com
Set-cookie: __utmc="111111111"
Set-cookie: pysid="1e53e0a04bf8e953c9156ea841e41157"
``` 

And included it in my `linkchecker` command with `--cookiefile`:

``` bash
linkchecker --cookiefile=cookies.txt --timeout=300 --no-warnings -ocsv http://example.com > siteerrors.csv
```

Use it!
===

If you work on a website of any significant size, there are almost certainly dozens of broken links and other errors. Link checkers will crawl through the website checking each link for errors.

Link checking your website may seem obvious, but in my experience hardly any dev teams do it regularly.

You might well want to use `linkchecker` to do automated link checking! I haven't implemented this yet, but I'll try to let you know when I do.
