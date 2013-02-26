---
title: 'Idea: Emulate HTML5'
layout: post
description:
    An introduction to modern CSS best practice concepts, in multiple parts.
    Including CSS preprocessors, grouping of code, selectors best practice (don't use IDs)
tags:
    - CSS
    - front-end
    - development
---

The idea here is to provide a JavaScript library extension (probably for YUI3) that will emulate
browser support for various HTML5 and CSS3 features in browsers that don’t provide it natively,
so developers only have to write HTML5 supported functionality once and let the library take
care of supporting it across all browsers.

Although the idea here will be to emulate functionality as closely as possible, it is likely that
functionality won’t be emulated flawlessly, or be half as efficient as true HTML5 support.
Accuracy of implementation will always be chosen over performance. This means that the more HTML5
fixes you include in a page the more likely it is that unsupported browsers will run slowly.
Therefore it is still strongly recommended that you opt instead for graceful degradation where
possible and only attempt to emulate HTML5 functionality where it is essential to your application.

The following make up a list of HTML5 technologies, and the technology that could provide
sub-optimal immitation functionality in browsers that are missing it.

HTML5
---

 - localstorage & sessionstorage & web SQL db & indexedDB -> js + cookies
 - placeholder -> simple js (include support for HTML5 styling rules?)
 - validation -> js validator ( need to think about how to handle styling similar to styling of HTML5
   validation? Use the same CSS rules? ) - this is going to be like really really tough. Soooo many JS
   validation implementations out there.
 - video -> simple HTML flash…
 - audio -> something similar
 - drag & drop (only needs emulating in Opera)
 - websockets -> various keepalive hacks (needs research)
 - canvas, WebGL?, SVG etc. -> libraries already written to emulate, no?
 - semantic tags -> easy. (JS in IE). Should we provide basic styling (probably not)?
 - progress meters -> JavaScript replacements
 - extra form input types (number, email, data list, etc.) -> javascript replacements
 - microdata, descriptive “rel”, and ARIA attributes -> already full support, but now specified

Unsupportable
---

With most of these, the fact that they only have limited support is not a reason not to implement them,
because they only provide supplementary functionality, not essential functionality.

 - speech input
 - video (without flash)
 - audio (?)
 - endless storage
 - notifications
 - drag and drop from desktop, drag out
 - filesystem api
 - geolocation (can be emulated server-side, with IP address?)
 - device orientation
 - different inputs on mobile devices for “number”, “email”, “uri”, “tel”

CSS3
---

Can we use purely JavaScript to fix certain CSS problems? Reading CSS files for unknown attributes is
pretty difficult to do…

E.g.:

 - curvy corners (including borders?)
 - Background size, multiple backgrounds
 - transparent png
 - drop shadow, rounded corners, reflections, stroke, gradient, HSLA, transparency
 - Generated content? - once again requires ability to search CSS files
 - nth child, first and last?
 - attribute selectors? [name=dfgdfg]
 - hover state (ie6, non-anchor elements)
 - text-overflow
 - columns
 - Transitions, transformations and animations
 - Box model orientation and align

Definitely can’t emulate
---

 - Web fonts
