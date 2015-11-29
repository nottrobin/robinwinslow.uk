Django behind a proxy: Fixing absolute URLs
===

I recently tried to setup OpenID for one of our sites to support authentication with [`login.ubuntu.com`][], and it took me much longer than I'd anticipated because our site is behind a [reverse-proxy][].

My problem
---

I was trying to setup OpenID with the [django-openid-auth plugin][]. Normally our sites don't include absolute links (`https://example.com/hello-world`) back to themselves, because relative URLs (`/hello-world`) work perfectly well, so normally Django doesn't need to know the domain name that it's hosted it.

However, when authenticating with OpenID, our website needs to send the user off to `login.ubuntu.com` with a [callback url][] so that once they're successfully authenticed they can be directed back to our site. This means that the `django-openid-auth` needs to ask Django for an absolute URL to send off to the authenticator (e.g. `https://example.com/openid/complete`).

The problem with proxies
---

In our setup, the Django app is served with a light [Gunicorn server][] behind an [Apache][] front-end which handles HTTPS negotiation:

```
User <-> Apache <-> Gunicorn (Django)
```

(There's actually an additional [HAProxy load-balancer][] in between, which I thought was complicating matters, but it turns out HAProxy was just passing through requests absolutely untouched and so was irrelevant to the problem.)

Apache was setup as a [reverse-proxy][] to Django, meaning that the user only ever talks to Apache, and Apache goes off to get the response from Django itself, with Django's local network IP address - e.g. `10.0.0.3`.

It turns out this is the problem. Because Apache, and not the user directly, is making the request to Django, Django sees the request come in at `http://10.0.0.3/openid/login` rather than `https://example.com/openid/login`. This meant that `django-openid-auth` was generating and sending the wrong callback URL of `http://10.0.0.3/openid/complete` to `login.ubuntu.com`.

How Django generates absolute URLs
---

`django-openid-auth` uses [`HttpRequest.build_absolute_uri`][] which in turn uses [`HttpRequest.get_host`][] to retrieve the domain. `get_host` then normally uses the `HTTP_HOST` header to generate the URL, or if it doesn't exist, it uses the request URL (e.g.: `http://10.0.0.3/openid/login`).

However, after inspecting [the code for `get_host`][] I discovered that if and only if `settings.USE_X_FORWARDED_HOST` is `True` then Django will look for the `X-Forwarded-Host` header first to generate this URL. This is the key to the solution.

Solving the problem - Apache
---

In our Apache config, we were initially using [mod_rewrite][] to forward requests to Django.

``` conf
RewriteEngine On
RewriteRule ^/?(.*)$ http://10.0.0.3/$1 [P,L]
```

However, when proxying with this method Apache2 doesn't send the `X_Forwarded_Host` header that we need. So we changed it to use `mod_proxy`:

``` conf
ProxyPass / http://10.0.0.3/
ProxyPassReverse / http://10.0.0.3/
```

This then means that Apache will send three headers to Django: `X-Forwarded-For`, `X-Forwarded-Host` and `X-Forwarded-Server`, which will contain the information for the original request.

In our case the Apache frontend used HTTPS protocol, whereas Django was only using so we had to pass that through as well by manually setting Apache to pass an `X-Forwarded-Proto` to Django. Our eventual config changes looked like this:

``` conf
<VirtualHost *:443>
    ...
    RequestHeader set X-Forwarded-Proto 'https' env=HTTPS

    ProxyPass / http://10.0.0.3/
    ProxyPassReverse / http://10.0.0.3/
    ...
</VirtualHost>
```

This meant that Apache now passes through all the information Django needs to properly build absolute URLs, we just need to make Django parse them properly.

Solving the problem - Django
---

By default, Django ignores all `X-Forwarded` headers. As mentioned earlier, you can set `get_host` to read the `X-Forwarded-Host` header by setting `USE_X_FORWARDED_HOST = True`, but we also needed one more setting to get HTTPS to work. These are the settings we added to our Django `settings.py`:

``` python
# Setup support for proxy headers
USE_X_FORWARDED_HOST = True
SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')
```

After changing all these settings, we now have Apache passing all the relevant information (`X-Forwarded-Host`, `X-Forwarded-Proto`) so that Django is now able to successfully generate absolute URLs, and `django-openid-auth` now works a charm.

[reverse-proxy]: https://en.wikipedia.org/wiki/Reverse_proxy
[`login.ubuntu.com`]: https://login.ubuntu.com/
[django-openid-auth plugin]: https://launchpad.net/django-openid-auth
[callback url]: http://stackoverflow.com/questions/23347056/what-is-a-callback-url-in-relation-to-an-api
[Gunicorn server]: http://gunicorn.org/
[Apache]: https://en.wikipedia.org/wiki/Apache_HTTP_Server
[HAProxy load-balancer]: http://www.haproxy.org/
[mod_rewrite]: http://httpd.apache.org/docs/current/mod/mod_rewrite.html
[`HttpRequest.build_absolute_uri`]: https://docs.djangoproject.com/en/1.8/ref/request-response/#django.http.HttpRequest.build_absolute_uri
[`HttpRequest.get_host`]: https://docs.djangoproject.com/en/1.8/ref/request-response/#django.http.HttpRequest.get_host
[the code for `get_host`]: https://github.com/django/django/blob/1.7.9/django/http/request.py#L62
