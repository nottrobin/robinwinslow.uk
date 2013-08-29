Basic styling
===

I have created my own set of basic style rules for how a document should look.

- View [this document in the basic styling][basic-styling-basic]
- Read [the CSS][github-basic-css]

Font
---

I don't set the absolute text size, as the appropriate text size will vary depending on the device. I do, however, make the text slightly bigger than the default, as I think most font-size defaults tend to be a bit too small:

``` css
html {
    font-size: 1.2rem;
}
```

I set the basic font to be sans-serif, as I think sans-serif fonts tend to be more readable. I also prefer to use "open sans" if it's available in the page, as it's prettier than most default sans-serif fonts:

``` css
html {
    font-family: 'open sans', sans-serif;
}
```

Note: Open sans won't work if you haven't included it in the page - the basic stylesheet won't include it for you to keep it lightweight.

Line-length and page-width
---

For a basic document, standard browsers will fill all the available space with text. This means that on devices with large screens, each line is uncomfortably long. 

Therefore, my basic stylesheet will instead limit all text containing elements to roughly 15-17 words per line, or the width of the screen for smaller screens.

``` css
h1, h2, h3, h4, p, nav {
    max-width: 43rem;
}
```

Central text
---

Standard browsers will align a default document to the left of the window, with a small amount of padding. I think that it's a more common approach is to put the document in the centre of the page.

I've also padded all text from the edge of the page by 1em.

``` css
h1, h2, h3, h4, p, nav {
    margin-left: auto;
    margin-right: auto;
    padding-left: 1rem;
    padding-right: 1rem;
}
```

Spacing
---

I think it looks neatest to have all text elements worry about the spacing above them, so that the spacing above an element is relative to the size of its text:

``` css
h1, h2, h3, h4, p {
    padding-top: 1rem;
}
```

Container elements are then left to worry about bottom padding:

``` css
section, main {
    padding-bottom: 1.5em;
}
header, footer {
    padding-bottom: 1em;
}
```

Header and footer
---

To distinguish the header and footer from the rest of the document I've simply given them bottom and top borders respectively:

``` css
header {
    border-bottom: 1px solid #666;
}
footer {
    border-top: 1px solid #666;
}
```

Navigations
---

I've chosen to present navigation lists as horizontal, space-separated lists. This should be recognisable as a navigation to anyone:

``` css
nav ul {
    overflow: hidden;
    margin: 0;
    padding: 0;
}
nav li {
    float: left;
    display: block;
    padding: 1em 1em 0 0;
}
nav li:last-child {
    padding-right: 0;
}
```

Lists
---

All the standard browsers style lists in a fairly intuitive way so I haven't changed the default list styling.
