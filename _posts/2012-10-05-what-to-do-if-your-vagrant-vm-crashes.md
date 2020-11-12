---
title: What to do if your Vagrant VM crashes
date: 2012-10-05 00:00:00 Z
tags:
- dev
- devops
description: If your Vagrant machine crashed and when you force kill it, vagrant forgets
  about its existence - here's how to fix that.
image_url: https://assets.ubuntu.com/v1/c75facf7-What+to+do+if+your+Vagrant+VM+crashes.png?h=160
layout: post
---

My vagrant VM crashed. I tried typing `vagrant halt` but it just tried to "gracefully" shut down the machine,
and stayed like that, for a long time.

What I did was open up the VirtualBox Manager and power off the machine manually.

However, now when I tried to start my VM again, it started trying to import a new base box to create the virtual
machine from scratch, which was not what I wanted. I guess it must have not saved the UUID of my VM back to the
`.vagrant`. Here's what I had to do to fix that.

## 1. Get VBoxManage running

I needed to use the `vboxmanage` command to find the UUID of the existing virtual machine I wanted to associate
with my vagrant directory. To do this I added the path containing `vboxmanage.exe` to my `PATH` variable, in my
case this was `C:\Program Files\Oracle\VirtualBox`.

## 2. Find the UUID of my virtual machine

I ran `vboxmanage list vms` to list all VMs by UUID.

```
"vagrant_1349442014" {00b9a111-b18b-4609-becd-f0b77eecab17}
"vagrant_1349448525" {758d639c-e9ad-48ed-bccb-b4ae423c52ef}
```

And copied the UUID of the one I wanted: `00b9a111-b18b-4609-becd-f0b77eecab17`

## 3. Update my .vagrant file

```
vim .vagrant
```

And update it with my new UUID:

```
{"active":{"default":"00b9a111-b18b-4609-becd-f0b77eecab17"}}
```

## 4. Start vagrant again

```
vagrant up
```

Voila!
