---
layout: post
title: "Fix Docker's DNS"
description: "Within certain networks, docker is unable to resolve DNS correctly. When this happens, here's how to fix it."
tags:
    - back-end
    - dev
    - canonical
---

[Docker](https://www.docker.com/) is really useful for a great many things - including, but not limited to, [quickly testing older versions of Ubuntu](/2014/08/28/using-docker-to-spin-up-light-ubuntu-containers/). If you've not used it before, why not [try out the online demo](https://docker.com/tryit/)?.

Networking issues
===

Sometimes docker is unable to use the host OS's DNS resolver, resulting in a DNS resolve error within your Docker container:

``` bash
$ sudo docker run -i -t ubuntu /bin/bash  # Start a docker container
root@0cca56c41dfe:/# apt-get update  # Try to Update apt from within the container
Err http://archive.ubuntu.com precise Release.gpg
Temporary failure resolving 'archive.ubuntu.com'  # DNS resolve failure
..
W: Some index files failed to download. They have been ignored, or old ones used instead.
```

How to fix it
===

We can fix this by explicitly telling Docker to use Google's DNS public server (`8.8.8.8`).

However, within some networks (for example, [Canonical](http://www.canonical.com/about)'s London office) all public DNS will be blocked, so we should find and explicitly add the network's DNS server as a backup as well:

Get the address of your current DNS server
---

From the host OS, check the address of the DNS server you're using locally with [`nm-tool`](http://linux.die.net/man/1/nm-tool), e.g.:

``` bash
$ nm-tool
...
  IPv4 Settings:
    Address:         192.168.100.154
    Prefix:          21 (255.255.248.0)
    Gateway:         192.168.100.101

    DNS:             192.168.100.101  # This is my DNS server address
...
```

Add your DNS server as a 2nd DNS server for Docker
---

Now open up the docker config file at `/etc/default/docker`, and update or replace the `DOCKER_OPTS` setting to add Google's DNS server first, but yours as a backup: `--dns 8.8.8.8 --dns=[YOUR-DNS-SERVER]`. E.g.:

``` ini
# /etc/default/docker
# ...
# Use DOCKER_OPTS to modify the daemon startup options.
DOCKER_OPTS="--dns 8.8.8.8 --dns 192.168.100.102"
# Google's DNS first ^, and ours ^ second
```

Restart Docker
---

``` bash
sudo service docker restart
```

Success?
---

Hopefully, all should now be well:

``` bash
$ sudo docker run -i -t ubuntu /bin/bash  # Start a docker container
root@0cca56c41dfe:/# apt-get update  # Try to Update apt from within the container
Get:1 http://archive.ubuntu.com precise Release.gpg [198 B]  # DNS resolves properly
...
```
