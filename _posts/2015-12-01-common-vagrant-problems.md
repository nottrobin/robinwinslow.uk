---
title: Common Vagrant problems
description: Some common issues that I've found with setting up Vagrant boxes
layout: post
tags:
  - dev
---

I wrote this as a draft ages ago, and I haven't really quality-checked it. I'm publishing it as I have decided to make a more concerted effort not to filter myself on my blog, and publish my drafts.

---

Vagrant seems like a great idea - just checkout a project, type "vagrant up", and immediately you're good to go.

In practice, managing Vagrant environments requires a fairly significant learning curve.

## Multiple technologies

First you should realised that Vagrant itself actually does very little of the leg-work. It brings together a number of technologies:

 - A linux distrubution (often Ubuntu) as the operating system for the base box
 - VirtualBox to manage the virtual machine
 - Chef or Puppet as the provisioner for the base box

Therefore to be able to debug Vagrant environments it is very useful to know as much as possible about each of these.

## VirtualBox issues

### VT-x not available

When you try to start up the box, you may get the error:

```
VT-x/AMD-V hardware acceleration is not available on your system
```

or

```
VT-x/AMD-V hardware acceleration has been enabled, but is not operational.
```

To fix this you need to [reboot into the BIOS settings](http://www.betaarchive.com/forum/viewtopic.php?t=22067) and enable VT-x.
Unfortunately as computer BIOSes vary immensely, I can't help you out with where to find the setting.

## Chef server issues

### Client node name exists

```
Client node name already exists (UPDATE THIS TO THE REAL ERROR MESSAGE)
```

This means you need to either change the name you're trying to use:

```
chef.node_name = "#{ENV['USER']}-new-key-26"
```

or delete existing key from the server (probably hosted at [opscode](manage.opscode.com/clients)).

### 401 Unauthorized

You may get this error when Chef is trying to install a new piece of software or something similar.

This is such a common error that Opscode have a [dedicated page about it](http://wiki.opscode.com/display/chef/Common+Errors).

The simplest fix is probably, once again, to use a completely new client name:

```
chef.node_name = "#{ENV['USER']}-unique-key-27"
```
