---
title: Loading fonts as Data URLs for performance
date: 2013-06-20 00:00:00 Z
tags:
- front-end
- dev
- fonts
- canonical
description: Including your fonts inside your CSS files as Data URLs can help with
  performance
image_url: https://assets.ubuntu.com/v1/ab52723e-Loading+fonts+as+Data+URLs+for+performance.png?w=230&h=160&mode=fill&bg=0000
layout: post
---

With the advent of [web fonts](https://en.wikipedia.org/wiki/Web_typography#Web_fonts) (e.g. from [Google Fonts](https://www.google.com/fonts/)), thankfully web designers are no longer tied to a limited set of "web safe" fonts.

## Fonts and performance

However, there is a potential performance hit with this. You will need to link your CSS files to the font files. The problem here isn't so much the size of the font file (they are typically under 100 KB), it's more that each new HTTP request that a page makes [effects performance](http://developer.yahoo.com/performance/rules.html)

Also, when loading web fonts externally you will sometimes see a flicker where the page loads initially with the default browser fonts, and then the new fonts are downloaded and applied afterwards. This flicker can look quite unprofessional.

## Font formats and IE8

If you want to support Internet Explorer 8 or older, you unfortunately need to include your fonts in two formats: [WOFF](https://en.wikipedia.org/wiki/Woff) and [EOT](https://en.wikipedia.org/wiki/Embedded_OpenType).

However, if you're willing to drop IE8 support (and [reap the benefits](/2013/02/28/time-to-say-goodbye-to-ie8/)), or to simply serve the browser default font to IE8, then you can provide your fonts in WOFF only, which is supported by [all other relevant browsers](http://caniuse.com/#search=woff).

## Data URLs

So [Data URLs](http://dataurl.net/#about), if you haven't heard of them, are a way of encoding binary data as a valid URL string. This means the data can be included directly inside HTML or CSS files. They are fantastically easy to create by simply dragging your binary file into the [Data URL Creator](http://dataurl.net/#dataurlmaker).

Data URLs are likely to be a bit larger than the binary file would have been. In my experience they tend to be about 20% larger. So the larger the file you're dealing with the less practical it becomes to encode the file as a URL. However, for sub-100k web fonts this difference is not so important.

So using Data URLs, you can include your font directly in your CSS like so:

``` css
/* http://www.google.com/webfonts/specimen/Lato */
@font-face {
    font-family: 'Lato light';
    font-style: normal;
    font-weight: 300;
    src: local('Lato Light'), url('data:application/x-font-woff;base64,d09GRg...BQAAAAB'), format('woff');
}
```

(For example, [here's what I use for this very site](https://github.com/nottrobin/robinwinslow.uk/blob/master/_assets/stylesheets/global.scss#L345))

This will now mean that your web pages will only have to download one CSS file, rather than a CSS file and a bunch of font files, which will help performance. Personally I think it's also neat not to have to create a special directory for font files. Keeping it all in one place (CSS) just seems nice and neat to me.

## A word about caching

Whether the above suggestion is actually a good idea will depend on how often your CSS changes. Hopefully you'll be merging your CSS files into one file already to reduce HTTP requests. This of course means that whenever that merged CSS file changes, your users will have to download the whole file again to see your changes.

If your fonts were downloaded as separate files, rather than being included in your CSS, then the fonts may well be cached even if the CSS has changed. However, if you include your fonts inside your CSS files as suggested above, this will mean that whenever your CSS changes a much larger CSS file will have to be downloaded each time. Including your fonts inside your CSS is likely to double the size of your CSS file.

This is a complex decision, but to give you some rough advice I'd say - if you CSS changes more than a couple of times a month then keep your fonts as separate files. If it's less often (as it is with this site) then it's probably worth including them inside the CSS as Data URLs.

If you have a different opinion on this, please let me know in the comments.