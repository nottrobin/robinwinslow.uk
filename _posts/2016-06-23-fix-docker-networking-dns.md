---
title: Fix Docker's networking DNS config
date: 2016-06-23 00:00:00 Z
tags:
- back-end
- dev
- canonical
description: Within certain networks, docker is unable to resolve DNS correctly. When
  this happens, here's how to fix it.
image_url: https://assets.ubuntu.com/v1/4c8dcce0-Fix+Docker+s+networking+DNS+config.png?w=230&h=160&mode=fill&bg=0000
layout: post
---

Sometimes, [Docker](https://www.docker.com/)'s internet connectivity won't be working properly, which can lead to a number of obscure errors with your applications. In my experience, this is usually because [DNS](http://en.wikipedia.org/wiki/Domain_name_system) lookups are failing in Docker images.

If you *know* it's a DNS problem and you're in a hurry, [jump straight to the system-wide solution](#the-permanent-system-wide-fix).

## Is DNS the problem?

Fortunately it's easy to test Docker's DNS.

First, check that basic internet connectivity is working by pinging a public IP address. It should succeed, giving you output similar to this:

``` bash
$ docker run busybox ping -c 1 192.203.230.10  # Ping a London-based NASA root nameserver
PING 192.203.230.10 (192.203.230.10): 56 data bytes
64 bytes from 192.203.230.10: seq=0 ttl=53 time=113.866 ms

--- 192.203.230.10 ping statistics ---
1 packets transmitted, 1 packets received, 0% packet loss
round-trip min/avg/max = 113.866/113.866/113.866 ms
```

But now try resolving the domain `google.com`:

``` bash
$ docker run busybox nslookup google.com
Server:    8.8.8.8
Address 1: 8.8.8.8
nslookup: can't resolve 'google.com'
```

If it fails as shown above then there is a problem resolving DNS.

## Why?

By default, if Docker can't find a DNS server locally defined in your `/etc/resolv.conf` file, [containers will default](https://docs.docker.com/engine/userguide/networking/configure-dns/) to using [Google's public DNS server](https://developers.google.com/speed/public-dns/), `8.8.8.8`, to resolve DNS.

In some networks, like [Canonical's London office](http://www.canonical.com/about#office-row) network where I work, the administrators intentionally block the use of public DNS servers to encourage people to use the network's own DNS server.

In this case, Docker containers using the default configuration won't be able to resolve DNS, rendering the internet effectively unuseable from within those containers.

I've [filed a bug about this issue](https://github.com/docker/docker/issues/23910), although I don't yet know when or if it might be addressed.

## The quick fix: Overriding Docker's DNS

Fortunately, it's fairly easy to directly run a docker container with a custom DNS server.

### Discover the address of your DNS server

You can find out what network's DNS server from within [Ubuntu](http://www.ubuntu.com/) as follows:

``` bash
$ nmcli dev show | grep 'IP4.DNS'
IP4.DNS[1]:                             10.0.0.2
```

### Run Docker with the new DNS server

To run a docker container with this DNS server, provide the `--dns` flag to the `run` command. For example, let's run the command we used to check if DNS is working:

``` bash
$ docker run --dns 10.0.0.2 busybox nslookup google.com
Server:    10.0.0.2
Address 1: 10.0.0.2
Name:      google.com
Address 1: 2a00:1450:4009:811::200e lhr26s02-in-x200e.1e100.net
Address 2: 216.58.198.174 lhr25s10-in-f14.1e100.net
```

And that's what success looks like.

## The permanent system-wide fix

The above solution is all very well if you're only temporarily inside a restrictive network and you only need to run containers directly.

However, most of the time you'll want this to work by default and keep working on your system, and for any other programs that rely on Docker.

### Update the Docker daemon

To achieve this, you need to change the DNS settings of the Docker daemon. You can set the default options for the docker daemon by creating a [daemon configuration file](https://docs.docker.com/engine/reference/commandline/dockerd/#/daemon-configuration-file) at `/etc/docker/daemon.json`.

You should create this file with the following contents to set two DNS, firstly your network's DNS server, and secondly the Google DNS server to fall back to in case that server isn't available:

`/etc/docker/daemon.json`:

``` json
{
    "dns": ["10.0.0.2", "8.8.8.8"]
}
```

Then restart the docker service:

``` bash
sudo service docker restart
```

### Testing the fix

Now you should be able to ping `google.com` successfully from any Docker container without explicitly overriding the DNS server, e.g.:

``` bash
$ docker run busybox nslookup google.com
Server:    10.0.0.2
Address 1: 10.0.0.2
Name:      google.com
Address 1: 2a00:1450:4009:811::200e lhr26s02-in-x200e.1e100.net
Address 2: 216.58.198.174 lhr25s10-in-f14.1e100.net
```