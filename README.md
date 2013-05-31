robin | blog
====================

This is all the code behind my blog.

The blog is hosted at http://robinwinslow.co.uk.

It uses [Jekyll](https://github.com/mojombo/jekyll) static site generator,
and is hosted using as a [Heroku](https://www.heroku.com/) app.

Local testing
---

``` bash
$ bundle install
$ rake assets:precompile
$ foreman start
```

Now browse to http://localhost:5000
