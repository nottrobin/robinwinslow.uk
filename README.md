robin | blog
===

This is all the code behind [my blog](http://robinwinslow.co.uk).

It uses [Jekyll](https://github.com/mojombo/jekyll) static site generator, and is hosted as a [Heroku](https://www.heroku.com/) app.

Running the site locally
---

Here's how to setup your system to run this project from scratch.

### Install dependencies

First you'll need to have [Ruby](http://www.ruby-lang.org/en/) and [Bundler](http://gembundler.com/) installed:

``` bash
$ sudo apt-get install ruby-dev # Install Ruby and Gems
$ gem install bundler           # Install bundler
$ bundle install                # Install project dependencies
```

### Build the site (do this whenever something changes)

``` bash
$ bundle exec rake # Build the static site
```

### Run the site

``` bash
$ bundle exec rackup -p 9254 # Run the server
```

Now browse to [127.0.0.1:9254](http://127.0.0.1:9254).
