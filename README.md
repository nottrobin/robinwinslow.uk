robin | blog
====================

This is all the code behind my blog.

The blog is hosted at http://robinwinslow.co.uk.

It uses [Jekyll](https://github.com/mojombo/jekyll) static site generator, and is hosted as a [Heroku](https://www.heroku.com/) app.

Local testing
---

You'll need to have [Ruby](http://www.ruby-lang.org/en/), [Bundler](http://gembundler.com/), [Rake](http://rake.rubyforge.org/) and [Foreman](http://theforeman.org/) installed.

``` bash
$ bundle install
$ rake assets:precompile
$ foreman start
```

Now browse to [localhost:5000](http://localhost:5000).
