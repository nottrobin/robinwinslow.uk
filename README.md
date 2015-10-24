robin | blog
===

This is all the code behind [my blog](https://robinwinslow.uk).

It uses [Jekyll](https://github.com/mojombo/jekyll) static site generator, and is hosted as a [Heroku](https://www.heroku.com/) app.

Running the site locally
---

### Install dependencies

``` bash
$ sudo apt-get install ruby-dev # Install Ruby and Gems
$ gem install bundler           # Install bundler
$ bundle install                # Install project dependencies
```

### Build the site (do this whenever something changes)

``` bash
$ bundle exec rake              # Build the static site
```

### Run the site

``` bash
$ bundle exec rackup -p 9254    # Run the server
```

Now browse to [127.0.0.1:9254](http://127.0.0.1:9254).

Publishing to robinwinslow.uk
---

``` bash
rm -rf _site
git submodule update --init
cd _site
git add -A .
git commit -m 'Some changes'
git push # Publish!
```
