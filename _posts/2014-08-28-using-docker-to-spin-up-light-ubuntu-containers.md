---
layout: post
title: "Using Docker to spin up light Ubuntu containers"
description: "Docker is really useful for quickly trying things on different versions of Ubuntu. Here's how."
tags:
    - back-end
    - dev
---

[Docker](https://www.docker.com/) is a fantastic tool for running [virtual images](https://registry.hub.docker.com/) and managing light [Linux containers](https://linuxcontainers.org/) extremely quickly.

One thing this has been very useful for in my job [at Canonical](http://design.canonical.com/author/nottrobin/) is quickly running older versions of Ubuntu - for example to test how to install specific packages on [Precise](http://en.wikipedia.org/wiki/List_of_Ubuntu_releases#Ubuntu_12.04_LTS_.28Precise_Pangolin.29) when I'm running [Trusty](http://en.wikipedia.org/wiki/List_of_Ubuntu_releases#Ubuntu_14.04_LTS_.28Trusty_Tahr.29).

Installing Docker
===

The simplest way to [install Docker](DOCKER_INSTALL_PAGE) on Ubuntu is using the automatic script:

``` bash
curl -sSL https://get.docker.io/ubuntu/ | sudo sh
```

You may then want to authorise your user to run Docker directly (as opposed to using `sudo`) by adding yourself to the `docker` group:

``` bash
sudo gpasswd -a [YOUR-USERNAME] docker
```

You need to log out and back in again before this will take effect.

Spinning up an old version of Ubuntu
===

With docker installed, you should be able to run it as follows. The below example is for Ubuntu Precise, but you can replace "precise" with any [available ubuntu version](https://registry.hub.docker.com/_/ubuntu/):

``` bash
mkdir share  # Shared folder with docker image
docker run -v `pwd`/share:/share -i -t ubuntu:precise /bin/bash  # Run ubuntu, with a shared folder
root@cba49fae35ce:/#  # We're in!
```

There are some import things to note:

- This is a very stripped-down operating system. You are logged in as the root user, your home directory is the filesystem root (`/`), and very few packages are installed. Almost always, the first thing you'll want to run is `apt-get update`. You'll then almost certainly need to install a few packages before this instance will be of any use.
- Every time you run the above command it will spin up a new instance of the Ubuntu image *from scratch*. If you log out, retrieving your current instance in that same state is complicated. So don't logout until you're done. Or learn about [managing Docker containers](https://docs.docker.com/userguide/usingdocker/).
- In some cases, Docker will be unable to resolve DNS correctly, meaning that `apt-get update` will fail. In this case, follow [the guide to fix DNS](/2014/08/27/fix-docker-networking/).
