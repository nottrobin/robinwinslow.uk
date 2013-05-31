---
layout: post
title: "Installing Symfony 2 by creating a github fork"
description: "How to fork the Symfony 2 standard PHP project and install dependencies locally using Composer on Ubuntu"
tags:
    - development
    - back-end
    - symfony
---

The Symfony 2 [standard project](https://github.com/nottrobin/symfony-standard) suggests that you install it in [one of two ways](https://github.com/nottrobin/symfony-standard/blob/380038dc9ab26dc6791a2772bce4daa1ecd3ee22/README.md):

- Install it using [Composer](http://getcomposer.org/) (which will retrieve the version that's on [packigist](https://packagist.org/))
- Download as an [archive](http://symfony.com/download) from the [symfony website](http://symfony.com/)

However, as I'm a developer, I'm used to using github, and I don't need the code-base to be particularly stable at the moment - I chose a third option:

- Installing from a fork of the Symfony 2 standard project

The danger of forking the actual repository is that it might not be stable. There could be unfixed bugs that aren't in the official releases. The advantage is that it's particularly easy to pull in new changes from the Symfony repository.

The environment
===

I'm doing all this on [Ubuntu](http://www.ubuntu.com/) Raring Ringtail (13.04). This post will almost certainly work in a similar way for any modern debian-based OS, but it will be fairly useless for yum-based OSes, and completely useless for Windows.

Install packages
===

Before we start, you'll need a [github](https://github.com/) account, and you'll need to install [git](http://git-scm.com/), [MySQL](http://www.mysql.com/), [php5-dev](https://launchpad.net/ubuntu/raring/+package/php5-dev), [php5-mysql](https://launchpad.net/ubuntu/raring/+package/php5-mysql), [php5-intl](https://launchpad.net/ubuntu/raring/+package/php5-intl) and [php-apc](https://launchpad.net/ubuntu/raring/+package/php-apc) on your local computer:

``` bash
# Install packages
$ sudo apt-get install git php5-dev mysql-server php5-mysql php5-intl php-apc
```

PHP configuration
===

First let's make sure that `date.timezone` is set. Open php.ini:

``` bash
$ sudo gedit /etc/php5/cli/php.ini
```

Find `date.timezone` (line 876 for me) and make sure it's uncommented and set to a [valid timezone](http://www.php.net/manual/en/timezones.europe.php):

``` ini
[Date]
; ..
date.timezone = Europe/London
```

Symfony also recommends that you set `short_open_tag` to `Off` (at about line 213):

``` ini
short_open_tag = Off
```

And that you configure `xdebug` to allow a high nesting level:

``` bash
# Add to PHP configuration      
$ echo "xdebug.max_nesting_level=250" | sudo tee -a /etc/php5/mods-available/xdebug.ini 
```

Setup MySQL database
===

You'll need a MySQL database ready for symfony to use:

``` bash
$ mysql -u root -p 
# the password will as you set on installation
...
mysql> create database symfony;
mysql> grant all on symfony.* to symfony@localhost identified by 'PASSWORD'; # Set your password to whatever you want or leave it blank
```

Fork the repository
===

[Forking a github repository](https://help.github.com/articles/fork-a-repo) is as easy as clicking the "fork" button. Note down the URL for your repository and clone it and change to the directory, e.g.:

``` bash
$ git clone git@github.com:nottrobin/symfony-standard.git
$ cd symfony-standard
```

Install dependencies and configure
===

Now you'll need `composer` to install dependencies:

``` bash
$ curl -sS https://getcomposer.org/installer | php
$ php composer.phar install
```
When it prompts you for input, you'll probably want to leave most things as default (blank), except the database username and password:

``` bash
Some parameters are missing. Please provide them.
database_driver (pdo_mysql):
database_host (127.0.0.1):
database_port (null):
database_name (symfony):
database_user (root):symfony
database_password (null):PASSWORD
mailer_transport (smtp):
mailer_host (127.0.0.1):
mailer_user (null):
mailer_password (null):
locale (en):en-gb
secret (ThisTokenIsNotSoSecretChangeIt):somesecretkeyorother
```

Now you can commit your [`composer.lock`](http://getcomposer.org/doc/01-basic-usage.md#composer-lock-the-lock-file) into your repository fork to make sure your dependency versions stay reliable:

``` bash
$ git add composer.lock
$ git commit -m 'Add composer.lock: dependency versions'
```

Check everything works
===

Now hopefully if you run the check, you'll see a long list of "OK"s:

``` bash
$ php ./app/check.php
```

```
********************************
*                              *
*  Symfony requirements check  *
*                              *
********************************
... 
 OK       PHP version must be at least 5.3.3 (5.4.9-4ubuntu2 installed)
 OK       PHP version must not be 5.3.16 as Symfony won't work properly with it
 OK       Vendor libraries must be installed
... etc
```

If you get `error`s you must fix them. If you get `warning`s feel free to ignore them.

Run the PHP server
---

If the PHP version listed in the output of `check.php` is at least `5.4` (see above, mine is `5.4.9-4ubuntu2`) then you can run the PHP server. [You can update](http://askubuntu.com/questions/109404/how-do-i-install-latest-php-in-supported-ubuntu-versions-like-5-4-x-in-ubuntu-1) to `5.4` if you don't have it already.

``` bash
$ php ./app/console server:run
```

And then browse to [localhost:8000](http://localhost:8000/).
