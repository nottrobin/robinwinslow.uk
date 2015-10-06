---
layout: post
title: Django quick-start tutorial (Ubuntu)
description: How to get up and running with the python Django framework quickly and easily
---

I'm just learning to use Django 1.6. There is already a very sufficient [official tutorial](https://docs.djangoproject.com/en/1.6/intro/tutorial01/), which I'm currently following, but in the interests of plurality, I'm going to write my take on this quick-start tutorial below:

Scope of this tutorial
---

To keep this tutorial simple, we're going to leave Django configured to use the default [sqlite3](https://sqlite.org/) database. 

Down the line you will want to use a real database, and you might want to use [Python 3.3](https://launchpad.net/ubuntu/+source/python3.3), keep your Django project in a [virtual environment](http://docs.python.org/dev/library/venv.html) or setup [version control](http://git-scm.com/), but to keep this tutorial short and to the point, I'm not going to cover any of these topics here.

Installing
===

First we need to install [pip](https://pypi.python.org/pypi/pip) and the django libraries:

``` bash
$ sudo apt-get install python-pip sqlite3 # Install pip (python package manager) and sqlite (database)
$ sudo pip install Django                 # Install Django
$ python                                  # Check it's installed
>>> import django
>>> django.VERSION
(1, 6, 0, 'final', 0)
```

Create project
===

After install Django, a python admin script should be in your `PATH` called [`django-admin.py`](https://docs.djangoproject.com/en/dev/ref/django-admin/). Use it to create a project:

``` bash
$ django-admin.py startproject myproject # create files for a new project called "myproject"
```

This will create the following project files:

``` bash
$ tree myproject/ # show the file structure in our new project
myproject/
├── manage.py
└── myproject
    ├── __init__.py
    ├── settings.py
    ├── urls.py
    └── wsgi.py
```

[`manage.py`](https://docs.djangoproject.com/en/dev/ref/django-admin/) is similar to `django-admin.py` and we will be using it to do the rest of the setting up for your new project.

Now change into your new project directory:

``` bash
$ cd myproject # change to project directory
```

Create database
===

Database settings are stored in [the `myproject/settings.py` file](https://docs.djangoproject.com/en/1.6/topics/settings/). By default, Django is configured to use [sqlite3](https://sqlite.org/).

You can use `manage.py syncdb` at any time to let Django automatically update your database schema for any new models in your app. Run it now to create the database and the core Django tables:

``` bash
$ python manage.py syncdb # update the database for the app
```

If you're using sqlite, you'll notice that there is now a new file called `db.sqlite3`. This is your database.

``` bash
$ ls -l # if you're in your top project directory
db.sqlite3  djapp  djexperiment  manage.py  polls
```

If you like you can inspect the tables that have just been created:

``` bash
$ sqlite3 db.sqlite3
sqlite> .tables
auth_group                  auth_user_user_permissions
auth_group_permissions      django_admin_log          
auth_permission             django_content_type       
auth_user                   django_session            
auth_user_groups          
```

Create an app
===

In Django, an *app* is a separate concept from a *project*. The *project* we create above could potentially contain many *apps*. We're going to create the "polls" app, just like the [official Django tutorial](https://docs.djangoproject.com/en/1.6/intro/tutorial01/).

So let's create a "polls" app using `manage.py`:

``` bash
$ python manage.py startapp polls
```

This will create an app directory structure as follows:

``` bash
$ tree polls/
polls/
├── admin.py
├── __init__.py
├── models.py
├── __pycache__
│   ├── __init__.cpython-33.pyc
│   └── models.cpython-33.pyc
├── tests.py
└── views.py
```
