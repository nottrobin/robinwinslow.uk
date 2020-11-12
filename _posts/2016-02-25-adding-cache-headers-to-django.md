---
title: 'Django HTTP headers: Controlling caching on cn.ubuntu.com'
date: 2016-02-25 00:00:00 Z
tags:
- dev
description: As optimising web performance becomes more and more important, it's becoming
  essential to carefully manage your caching headers. But Django doesn't make it hat
  easy.
image_url: https://assets.ubuntu.com/v1/5f9dc6c0-Django+HTTP+headers+Controlling+caching+on+cn+ubuntu+com.jpeg?h=160
layout: post
---

<small>Also published [on design.canonical.com](http://design.canonical.com/).</small>

It's becoming [more and more important][pagespeed-caching] for websites to carefully consider
how their [resources are cached][heroku-caching] in users' browsers. Get the caching wrong,
and you either end up with a woefully slow experience for the user, or a very
strange looking website as users are left with stale CSS files and images.

Or often both.

For our [China site](http://cn.ubuntu.com), we've decided that the HTML pages
should be cached for 5 minutes, and the CSS and JavaScript can be cached for a
year - as every time we update them we [change the URL][].

## Caching headers in Django

Telling the browser how long to cache a resource is done with one of two headers:

- `Cache-Control`: In HTTP/1.1, this can set the maximum age before a resource should be re-downloaded.
- `Expires`: In the older HTTP/1.0 standard, this sets the date and time that a resource becomes outdated and should be refreshed.

To control these headers in Django is less simple than you might think. If you're
happy to use the [cache framework][] then it will take care of these headers
for you, but as we have a separate [Squid cache][] in front of our application,
this was a more heavyweight solution than we needed.

Modifying HTML responses using View classes
---

In our case, all of our HTML pages are served with an extended version of
the [TemplateView class][]:

``` python
from django.views.generic.base import TemplateView

class OurTemplateView(TemplateView):
    # Setup our custom template data
```

To add headers, we need to modify the [`HTTPResponse`][], which we can intercept
by extending the `render_to_response` method.

Django also provides [`patch_response_headers`][] a handy helper function to generate our caching headers for us
and attach them to the response:

``` python
class OurTemplateView(TemplateView):
  def render_to_response(self, context, **response_kwargs):
      # Get response from parent TemplateView class
      response = super(CmsTemplateFinder, self).render_to_response(
          context, **response_kwargs
      )

      # Add Cache-Control and Expires headers
      patch_response_headers(response, cache_timeout=300)

      # Return response
      return response
```

And now we can see our extra caching headers in the HTTP response:

``` bash
$ curl -I cn.ubuntu.com
...
Date: Fri, 12 Feb 2016 22:48:38 GMT
Expires: Fri, 12 Feb 2016 22:53:35 GMT
Last-Modified: Fri, 12 Feb 2016 22:48:35 GMT
Cache-Control: max-age=300
```

Browsers and proxies will now cache the HTML pages for 5 minutes.

Controlling caching for static files
---

Django [recommends][] serving static files separately from the rest of your
application.

However, for simplicity and dev-prod parity we've been using [DJ-Static][] to
serve static files with the Django WSGI app, as [introduced by Kenneth Reitz][].
This was also, at the time we implemented it, the method recommended by Heroku
for managing static files in Django.

However, as it turns out DJ-Static doesn't offer any control over caching
headers. And Heroku [now recommend][] using [WhiteNoise][] instead.

Serving static files with WhiteNoise is pretty simple (as it was with DJ-Static):

``` python
# myapp/settings.py
STATIC_ROOT = 'static'
STATIC_URL = '/static/'

# myapp/wsgi.py
from django.core.wsgi import get_wsgi_application
from whitenoise.django import DjangoWhiteNoise

application = DjangoWhiteNoise(get_wsgi_application())
```

WhiteNoise will add a `Cache-Control` header, although it doesn't
support set the older `Expires` header. By default, the `Cache-Control` header
is initially set to no caching:

``` bash
$ curl -I localhost:8000/static/css/styles.css?v=d5d2934
...
Cache-Control: public, max-age=0
```

We wanted our static files to be cached for a year, so we set the
`WHITENOISE_MAX_AGE` setting in `settings.py`:

``` python
# myapp/settings.py
WHITENOISE_MAX_AGE = 31557600
```

This will set the `max-age` in the `Cache-Control` header to achieve the
browser caching we're looking for:

``` bash
$ curl -I http://cn.ubuntu.com/static/css/styles.css?v=d5d2934
...
Cache-Control: public, max-age=31557600
```

Now we have control
---

[Leveraging browser caching][pagespeed-caching] is an invaluable tool in performance, and so
understanding how we can control the user's cache with Django is very helpful.

Hopefully I've demonstrated some ways that this can be achieved, which we've
just implemented on [cn.ubuntu.com](http://cn.ubuntu.com).


[cache framework]: https://docs.djangoproject.com/en/1.9/topics/cache/ "Django’s cache framework"
[Squid cache]: http://www.squid-cache.org/ "Squid: Optimising Web Delivery"
[TemplateView class]: https://docs.djangoproject.com/es/1.9/ref/class-based-views/base/#templateview "Django base views: TemplateView"
[`HTTPResponse`]: https://docs.djangoproject.com/en/1.9/ref/request-response/#httpresponse-objects "Django request and response objects: HttpResponse objects"
[`patch_response_headers`]: https://docs.djangoproject.com/en/1.9/ref/utils/#django.utils.cache.patch_response_headers "Django Utils: django.utils.cache.patch_response_headers"
[recommends]: https://docs.djangoproject.com/en/1.9/howto/static-files/deployment/ "Django: Deploying static files"
[introduced by Kenneth Reitz]: http://www.kennethreitz.org/essays/introducing-dj-static "Introducing DJ-Static"
[DJ-Static]: https://github.com/kennethreitz/dj-static "Github: DJ-Static"
[WhiteNoise]: http://whitenoise.evans.io/en/stable/ "WhiteNoise: Radically simplified static file serving for Python web apps"
[heroku-caching]: https://devcenter.heroku.com/articles/increasing-application-performance-with-http-cache-headers "Heroku: Increasing Application Performance with HTTP Cache Headers"
[pagespeed-caching]: https://developers.google.com/speed/docs/insights/LeverageBrowserCaching "PageSpeed Insights: Leverage Browser Caching"
[change the URL]: https://github.com/ubuntudesign/django-versioned-static-url "UbuntuDesign on GitHub: Django versioned static"
[now recommend]: https://devcenter.heroku.com/articles/django-assets "Heroku: Django and Static Assets"
