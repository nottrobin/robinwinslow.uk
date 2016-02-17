---
title: "Creating a minimal Python application server for experimenting"
description: "As a web developer, it can be incredibly useful to be able to spin up a quick server to inspect and manipulate raw requests. And if you're used to working in Python, this little script is just the ticket."
tags:
  - dev
  - back-end
layout: post
---

I often find myself wanting to play around with a tiny Python web application
with native Python without installing any extra modules -
the Python developer's equivalent of creating an `index.html` and opening it
in the browser [just to play around with markup][].

For example, today I found myself wanting to inspect how the
[Google API Client Library for Python][] handles requests, and a simple
application server was all I needed.

In these situations, the following minimal WSGI application, using the built-in
[wsgiref library][] is just the ticket:

``` python
from wsgiref.simple_server import make_server


def application(env, start_response):
    """
    A basic WSGI application
    """

    http_status = '200 OK'
    response_headers = [('Content-Type', 'text/html')]
    response_text = "Hello World"

    start_response(http_status, response_headers)
    return [response_text]

if __name__ == "__main__":
    make_server('', 8000, application).serve_forever()
```

Put this in a file - e.g. `wsgi.py` - and run it with:

``` bash
$ python wsgi.py
127.0.0.1 - - [14/Feb/2016 16:22:38] "GET / HTTP/1.1" 200 11
```

(I've also saved this [as a Gist][]).

This provides you with a very raw way of parsing HTTP requests. All the
HTTP variables come in as items in the `env` dictionary:

``` python
def application(env, start_response):
    env['PATH_INFO']     # The requested path (the `/index.html` in `http://example.com/index.html`),
    env['QUERY_STRING']  # Any query parameters (the `foo=bar` in `http://example.com/index.html?foo=bar`).
```

What I often do from here is use [ipdb][] to inspect incoming requests, or
directly manipulate the response headers or content.

Alternatively, if you're looking for something slightly more full-featured
(but still very lightweight) [try Flask][].


[Google API Client Library for Python]: https://developers.google.com/api-client-library/python/ "Google API Client Library for Python"
[wsgiref library]: https://docs.python.org/2/library/wsgiref.html "Python docs: wsgiref — WSGI Utilities and Reference Implementation"
[as a Gist]: https://gist.github.com/nottrobin/8c12c9921aeb885dbe07 "GitHub Gist (nottrobin): Simple WSGI application server"
[ipdb]: https://pypi.python.org/pypi/ipdb "Python package index: ipdb"
[try Flask]: http://flask.pocoo.org/docs/0.10/quickstart/ "Flask: Quickstart"
[just to play around with markup]: http://www.yourhtmlsource.com/myfirstsite/myfirstpage.html "HTML Source HTML Tutorials: My First Page"
