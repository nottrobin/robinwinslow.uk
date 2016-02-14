---
title: "A quick simple Python application server for playing around"
description: "If you're a python developer, it's incredibly useful to ."
tags:
  - dev
  - back-end
layout: post
---

I often find myself wanting to play around with a tiny Python web application -
the Python developer's equivalent of creating an `index.html`and opening it
in the browser just to play around with markup.

For example, today I found myself wanting to try out the
Google API Client Library for Python, and a simple application server was all
I needed.

In these situations, the following minimal WSGI application, using the built-in
[wsgiref library][] is just the ticket:

``` python
from wsgiref.simple_server import make_server

def application(env, start_response):
    start_response('200 OK', [('Content-Type','text/html')])
    return ["Hello World"]

make_server('', 8000, application).serve_forever()
```

Put this in a file - e.g. `wsgi.py` - and run it with:

``` bash
$ python wsgi.py
127.0.0.1 - - [14/Feb/2016 16:22:38] "GET / HTTP/1.1" 200 11
```

(I've also saved this [as a Gist][]).


[API Client Library for Python]: https://developers.google.com/api-client-library/python/ "Google API Client Library for Python"
[wsgiref library]: https://docs.python.org/2/library/wsgiref.html "Python docs: wsgiref — WSGI Utilities and Reference Implementation"
[as a Gist]: https://gist.github.com/nottrobin/8c12c9921aeb885dbe07 "GitHub Gist (nottrobin): Simple WSGI application server"
