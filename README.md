# robinwinslow.co.uk

The code for [my blog](https://robinwinslow.co.uk).

This is a Jekyll site hosted for free using [GitHub Pages](https://pages.github.com/) and [Cloudflare free tier](https://www.cloudflare.com/plans/).

I publish this site by simply pushing to my repository, letting [GitHub Pages' default Jekyll build](https://docs.github.com/en/free-pro-team@latest/github/working-with-github-pages/setting-up-a-github-pages-site-with-jekyll) do the rest.

This means I'm limited to what's in [Jekyll](https://jekyllrb.com/), GitHub's [mandatory plugins](https://docs.github.com/en/free-pro-team@latest/github/working-with-github-pages/about-github-pages-and-jekyll#plugins) and [supported plugins](https://pages.github.com/versions/), which works fine for me at the moment.

## Running the site locally

```bash
$ sudo apt-get install ruby-dev # Install Ruby and Gems
$ sudo gem install jekyll jekyll-redirect-from  # Install Jekyll and just one plugin
$ jekyll serve
```

Now the site should be running on http://127.0.0.1:4000.

## License

My code and writing are public domain, use them however you wish.
