robin | blog
====================

This is all the code behind [my blog](http://robinwinslow.co.uk).

It uses [Jekyll](https://github.com/mojombo/jekyll) static site generator, and is hosted as a [Heroku](https://www.heroku.com/) app.

Running the site locally
---

First you'll need to have [Ruby](http://www.ruby-lang.org/en/), [Bundler](http://gembundler.com/), [Rake](http://rake.rubyforge.org/) and [Foreman](http://theforeman.org/) installed.

Then you can build and run the site as follows:

``` bash
# Install dependencies - you only need to do this once
$ bundle install

# Build the static site - do this every time something changes
$ rake

# Run the server
$ foreman start
```

Now browse to [localhost:5000](http://localhost:5000).
