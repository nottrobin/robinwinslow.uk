---
layout: post
title: "PHP best practices"
description: "A bunch of best practices for PHP which I wrote back in 2012"
tags:
    - dev
    - back-end
---

The following are a set of best practices for coding in PHP specifically. This is meant to compliment and extend the [general programming principles](/2014/01/08/general-coding-guidelines/).

- Read through [PHP The Right Way](http://www.phptherightway.com/), which contains so many point of best practice. Particularly useful for their advice on security and caching.
- Try to stay on [the latest version of PHP](http://www.php.net/downloads.php), and upgrade early when new versions come out.
- Use PHP coding standards from [the FIG](https://github.com/php-fig/fig-standards), [PSR-0](https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-0.md), [PSR-1](https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-1-basic-coding-standard.md) and [PSR-2](https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-2-coding-style-guide.md) to inform your use of syntax, class names, namespacing and file structures
- Where you can write [DocBlox](http://docs.docblox-project.org/for-users/anatomy-of-a-docblock.html) before class, function and method declarations specifying at least the author name
- Use elements of the [SPL](http://php.net/manual/en/book.spl.php) wherever possible, particularly for [exceptions](http://php.net/manual/en/spl.exceptions.php)
- Code to an [interface](http://php.net/manual/en/language.oop5.interfaces.php)
- Try to use [Composr](http://getcomposer.org/doc/00-intro.md) and [Packagist](http://packagist.org/) for dependency management
- Try to use [xdebug remote](http://xdebug.org/docs/remote) (if you can set it up) rather than doing var_dump or print_r debugging
- Remember, PHP is a product of the [free software community](http://en.wikipedia.org/wiki/Free_software_community). Try to [be a good citizen](https://www.gov.uk/designprinciples#tenth) by open sourcing your own code or contributing back to existing open projects
