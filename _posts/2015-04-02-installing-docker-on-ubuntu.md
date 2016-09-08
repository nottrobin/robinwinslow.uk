---
title: Getting Docker running on Ubuntu 14.04
layout: post
description: "There are more steps than there should be to get docker running on ubuntu 14.04. I outline them here."
tags:
  - dev
  - back-end
---

Docker is a very neat tool, and there's [a good guide on the Docker website](https://docs.docker.com/installation/ubuntulinux/#installing-docker-on-ubuntu) to installing it in Ubuntu, but I always find it's just slightly more cumbersome than this guide suggests.

So here's a quick guide to all the commands I find I have to run to get it working:

``` bash
sudo apt update && sudo apt install wget  # Install wget just in case you don't have it
wget -qO- https://get.docker.com/ | sh    # Install docker - NB: doesn't actually start the docker service
sudo usermod -aG docker `whoami`          # Add yourself to the docker group
# Now log out and back in again
sudo service docker start                 # Make sure the docker service is running
```

You should now be set to go, unless you're inside a corporate network that doesn't let you use public DNS servers. You can test this with:

``` bash
docker run ubuntu /usr/bin/apt update
```

If the above command produces a connection error, follow [my guide to fix Docker networking](/2016/06/23/fix-docker-networking-dns/).
