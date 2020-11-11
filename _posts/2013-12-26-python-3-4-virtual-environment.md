---
title: Using a virtual environment with Python 3.4
date: 2013-12-26 00:00:00 Z
tags:
- dev
- back-end
description: I recently started learning Python and Django, and so I've been working
  out how to setup a good virtual environment. Here's how to do it the native way
  in Python 3.4.
image_url: https://assets.ubuntu.com/v1/d4f10591-python+virtualenv.png?w=230&h=160&mode=fill&bg=0000
layout: post
---

I've been learning Python recently. I had a choice between learning Python 2.7 or Python 3, and I chose the latter. It may be true that many people still work in Python 2.7, but I thought I should start off as up-to-date as possible.

This meant that I had to work out how to set up a virtual environment without virtualenv.

(Hopefully Python 3.3 [will finally be the default version](https://wiki.ubuntu.com/Python/3) of Python in Ubuntu 14.04 LTS.)

## What is virtualenv?

[Virtualenv](https://pypi.python.org/pypi/virtualenv) is a Python package that will setup a "virtual" python environment in a specific directory.

This virtual environment will keep your python version and modules separate from the system's Python installation:

``` bash
$ virtualenv env            # create new environment in "env" folder
$ source env/bin/activate   # Active "env"
(env) $ which pip           # "pip" is now inside "env" folder
env/bin/pip
(env) /project$ deactivate  # Deactivate env
/project$ which pip         # "pip" is back to default
/usr/bin/pip
```

This means that you can keep a fixed python environment fixed for a specific project regardless of whether the wider system changes. Virtual environments complement [`requirements files`](http://www.deploydjango.com/django_project_structure/index.html#step-2-define-your-requirements).

When "env" is active, `pip install somemodule` will install "somemodule" into `env/lib/pythonx.x/site-packages` directory instead of the system's normal python path.

This means that you can install exactly the modules you need for your current project and no more:

``` bash
$ source env/bin/activate               # Activate a new environment
(env) $ pip freeze                      # No output - clean environment
(env) $ pip install -r requirements.txt # Install project dependencies
```

## Python 3 and pyvenv

Virtualenv [doesn't play nicely](http://askubuntu.com/questions/279959/how-to-create-a-virtualenv-with-python3-3-in-ubuntu) with Python 3, so it's best not to try to use it.

### pyvenv-3.3

Fortunately, python 3.3 (the current version of the [Ubuntu python3 package](http://packages.ubuntu.com/saucy/python3)) actually has a native virtual environment manager called `pyvenv`.

Unfortunately, the resulting environment [doesn't include pip](http://stackoverflow.com/questions/17982032/pyvenv-pip-not-installing-into-local-site-packages). You can install pip into your virtual environment, but it's all rather clunky.

### pyvenv-3.4

Python 3.4's version of `pyvenv` [*will*](http://docs.python.org/dev/library/venv.html) include `pip`, making management of virtual environments simple again, and now *native*.

The downside here is that Python 3.4 is still in beta, and I can't find a PPA to install it through `apt-get` (the easy way).

## Building Python 3.4 from source

Fortunately, building [Python 3.4.0-b1](http://www.python.org/getit/releases/3.4.0/) from source was simple on Ubuntu 13.10:

``` bash
$ sudo apt-get install build-essential # Make sure we have build tools
$ wget http://www.python.org/ftp/python/3.4.0/Python-3.4.0b1.tgz # download
$ tar -xzf Python-3.4.0b1.tgz          # unzip
$ cd Python-3.4.0b1/                   # open directory
$ ./configure                          # configure for this system
$ make                                 # build
$ sudo make install                    # install to /usr/local/
```

You should now find you have a few new binaries (in `/usr/local/bin`) including `python3.4`, `pydoc3.4` and `pyvenv-3.4`.

## Using pyvenv-3.4

Now that `pyvenv-3.4` is installed, here's how you might use it to setup a Django environment and a django project:

``` bash
$ pyvenv-3.4 djenv          # create django virtual env
$ source djenv/bin/activate # activate it
(djenv) $ which pip         # check pip points to the right place
/home/me/djenv/bin/pip
(djenv) $ pip freeze        # check our environment is clean (no output)
(djenv) $ pip install django django-extensions     # install django dependencies
(djenv) $ pip freeze        # see our installed dependencies
Django==1.6.1
django-extensions==1.2.5
six==1.4.1
(djenv) $ django-admin.py startproject newproject  # create new django project
(djenv) $ pip freeze > newproject/requirements.txt # save dependencies into project
```

## The future

While all the above setup isn't *that* hard, I'm hoping that by 2015 we might see Python 3.4 become stable and become the default version of Python in Ubuntu 14.10.

After that, I guess the next thing would be for someone to create something similar to [virtualenv wrapper](http://virtualenvwrapper.readthedocs.org/en/latest/) for `pyvenv`.