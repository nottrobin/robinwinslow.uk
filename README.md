# robinwinslow.co.uk

The code for [my blog](https://robinwinslow.co.uk).

This is a Jekyll site hosted for free using [GitHub Pages](https://pages.github.com/) and [Cloudflare free tier](https://www.cloudflare.com/plans/).

I publish this site by simply pushing to my repository, letting [GitHub Pages' default Jekyll build](https://docs.github.com/en/free-pro-team@latest/github/working-with-github-pages/setting-up-a-github-pages-site-with-jekyll) do the rest.

This means I'm limited to what's in [Jekyll](https://jekyllrb.com/), GitHub's [mandatory plugins](https://docs.github.com/en/free-pro-team@latest/github/working-with-github-pages/about-github-pages-and-jekyll#plugins) and [supported plugins](https://pages.github.com/versions/), which works fine for me at the moment.

## Running the site locally

```bash
$ sudo apt-get install ruby-dev # Install Ruby, Gems and development tooling for building gems
$ sudo gem install jekyll  # Install Jekyll
$ sudo gem install jekyll-coffeescript jekyll-default-layout jekyll-gist jekyll-github-metadata jekyll-optional-front-matter jekyll-paginate jekyll-readme-index jekyll-titles-from-headings jekyll-relative-links # Install jekyll and all the default plugins for GH pages
$ sudo gem install jekyll-redirect-from  # Also install jekyll-redirect-from, which is used in this site
$ jekyll serve  # Run the site
```

(If you get errors, you might need to remove `kramdown`, or all of `ruby`, and start again).

Now the site should be running on http://127.0.0.1:4000.

## Usage license

My code and writing are public domain, use them however you wish.
