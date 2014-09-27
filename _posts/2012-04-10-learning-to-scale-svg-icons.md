---
title: Learning to scale SVG icons
description: Some examples of how to mitigate issues with managing SVG icons in mark-up.
layout: post
tags:
  - dev
  - front-end
---
 
I had this idea to make my homepage actually just an index of all my online profiles - a link to Facebook, a link to Github, a link to this Tumblr blog etc. - Partly to comply with the [relMeAuth microformat](http://microformats.org/wiki/RelMeAuth).

It seems to me a good way to do this would be to have really big icons. Everyone recognises the Facebook "F", or the Twitter bird. So I went in search of really big Icons.

Then I remembered about SVG.

SVG, for those who don't know, stands for "[Scalable Vector Graphic](http://en.wikipedia.org/wiki/Scalable_Vector_Graphics)", and is a format for describing images in terms of paths rather than pixels, meaning that the definition of an image will be exactly the same no matter how big it is. E.g.:

``` html
<svg xmlns="http://www.w3.org/2000/svg" version="1.1">
  <circle cx="100" cy="50" r="40" stroke="black" stroke-width="2" fill="red" />
</svg>
```
(stolen from the [w3schools.com](http://www.w3schools.com/svg/default.asp) tutorial)

This would be ideal for large icons, because you would never lose
quality no matter how big they were, and also I could allow the images
to scale perfectly to fit your screen size. And you can put SVG code
[directly in an HTML5 document](http://www.tutorialspoint.com/html5/html5_svg.htm) without having to have a separate
file.

After a bit of a search I discovered [someone who had already done
this](http://nikalyuk.in/) with his homepage (although he hadn't used the awesome scaling
power of the images), providing most of the icons I would need myself.
So I duly stole them.

I had a bit of trouble trying to work out how to actually change the
size of the SVG within an HTML5 document, but [stackoverflow came to the
rescue](http://stackoverflow.com/questions/8515524/how-do-i-scale-an-svg-polygon-in-ems). My conclusion was that every SVG element should have a
"viewBox" defined, but that they should \*never\* explicitly define the
"width" or "height":

``` html
<!doctype html>
<html>
    <body>
        <svg viewBox="0 0 100 100">...</svg>
    </body>
</html>`
```

So now I can scale my SVG based on the CSS rules, which might say
something like:

``` css
svg {width:30%;}
```

And everything will be fine. *satisfied sigh*.
