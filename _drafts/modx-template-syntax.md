---
layout: post
title: "MODX template syntax"
description: "A quick summary of the template syntax in MODX"
---

I just started doing some volunteer work for the [Young Greens website](http://younggreens.greenparty.org.uk/). The back-end for the new site will be managed in [MODX](http://modx.com/), a CMS I've never used before. Therefore I'm going to blog my learning as I go.

MODX templates are not the easiest to work out.

http://rtfm.modx.com/revolution/2.x/making-sites-with-modx/structuring-your-site/resources

[[*templateVariable?argument1=value1 &argument2=value2]]

[[*resourceField]] - (see http://rtfm.modx.com/revolution/2.x/making-sites-with-modx/structuring-your-site/resources)

[[!snippet? &arg1=val1 &arg2=val2]]

[[$chunk? arg1=val1 &arg2=val2]]

[[~<page_id>]] = URL for page