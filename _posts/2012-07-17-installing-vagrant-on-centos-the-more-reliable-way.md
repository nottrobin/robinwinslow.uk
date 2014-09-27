---
title: Installing Vagrant on CentOS - the more reliable way
description: Vagrant installation on CentOS is a tad unreliable. Installing with Ruby Gems is the answer.
layout: post
tags:
  - dev
  - devops
---
 
I've been playing around with [Vagrant](http://vagrantup.com/) lately. It's a "virtualized development tool" - a tool for quickly configuring and spinning up virtual machines for a software project.

Its real strength is that the Vagrant configuration files can be easily committed to a project's repository, allowing anyone who then checks out the project (assuming they have Vagrant installed) to quickly and reliably spin up a virtual machine pre-configured with all the project's dependencies.

If you want you can [skip to the solution](#the-solution).

The problem
===

The Vagrant website doesn't give you very much detail about how to install it. There is a [download page](http://downloads.vagrantup.com/tags/v1.0.3) with a list of packages for different systems, but when I tried to install this package on CentOS it gave me some sort of Ruby related error (I have zero experience with Ruby).

``` bash
$ wget http://files.vagrantup.com/packages/eb590aa3d936ac71cbf9c64cf207f148ddfc000a/vagrant_1.0.3_x86_64.rpm
$ sudo rpm -i vagrant_1.0.3_x86_64.rpm
$ /opt/vagrant/bin/vagrant
/opt/vagrant/bin/../embedded/bin/ruby: /lib64/libc.so.6: version `GLIBC_2.6' not found (required by /opt/vagrant/embedded/bin/../lib/libruby.so.1.9)
```

I [asked the internet](https://www.google.co.uk/search?sugexp=chrome,mod=9&amp;sourceid=chrome&amp;ie=UTF-8&amp;q=install+vagrant+on+centos) how to install Vagrant on CentOS but it wasn't very helpful. Eventually I found a blog post on [how to setup Vagrant on Ubuntu](http://www.dejonghenico.be/blog/detail/setup-vagrant-and-a-small-quick-start) which gave me my answer, so I thought I'd share it with you.

The solution
===

You need to install Vagrant through Ruby Gems. Thankfully it really is pretty simple:

``` bash
$ sudo yum install ruby
...
$ sudo yum install rubygems
...
$ sudo gem update --system
...
$ sudo gem install vagrant
```

On my system this installed Vagrant to:

```
/usr/local/bin/vagrant 
```
