---
title: Prepare for when Ubuntu freezes
description: "I just discovered this one neat trick to free up RAM in Ubuntu even when my mouse and keyboard stop responding."
layout: post
tags:
  - dev
  - personal
  - canonical
---

(Also posted [on design.canonical.com][aa27f6b4])

I routinely have at least 20 tabs open in Chrome, 10 files open in
[Atom][e107dbd4] (my editor of choice) and I'm often running virtual machines
as well. This means my poor little [X1 Carbon][fbd87bd9] often runs out of
memory, at which point Ubuntu completely freezes up, preventing me from doing
anything at all.

Just a few days ago I had written a long post which I lost completely when my
system froze, because Atom [doesn't yet][ea6f49f0] recover documents after
crashes.

If this sounds at all familiar to you, **I now have a solution**! (Although
it didn't save me in this case because it needs to be enabled first - see
below.)

# oom_kill

The [magic SysRq key][95cedafa] can run a bunch of kernel-level commands.
One of these commands is called `oom_kill`. OOM stands for "Out of memory",
so `oom_kill` will kill the process taking up the most memory, to free some up.
In most cases this should unfreeze [Ubuntu][7b2ffc42].

You can run `oom_kill` from the keyboard with the following shortcut:

```
# Kill the process taking up the most memory
alt + SysRq + f
```

Except that this is disabled by default on Ubuntu:

# Enabling SysRq functions

For [security reasons][a957abbb], SysRq keyboard functions are disabled by
default. To [enable them][55eb561d], change the value in the file
`/etc/sysctl.d/10-magic-sysrq.conf` to `1`:

```
# /etc/sysctl.d/10-magic-sysrq.conf
kernel.sysrq = 1
```

And to enable the new config run:

``` bash
sudo sysctl --system
```

# SysRq shortcut for the Thinkpad X1

Most laptops don't have a physical `SysRq` key. Instead they offer a keyboard
combination to emulate the key. On my Thinkpad, this is `fn + s`. However, there's
a quirk that the `SysRq` key is only "pressed" when you release.

So to run `oom_kill` on a Thinkpad, after enabling it, do the following:

- Press and hold `alt`
- To emulate `SysRq`, press `fn` and `s` keys together, then release them  (keep holding `alt`)
- Press `f`

This will kill the most expensive process (usually the browser tab running
`inbox.google.com` in my case), and freeup some memory.

Now, if your computer ever freezes up, you can just do this, and hopefully fix
it.

  [55eb561d]: http://askubuntu.com/questions/11002/alt-sysrq-reisub-doesnt-reboot-my-laptop/11194#11194 "Stack Overflow: Alt + sysrq + REISUB doesn't reboot my laptop"
  [7b2ffc42]: http://www.ubuntu.com/ "Ubuntu"
  [e107dbd4]: https://atom.io/ "Atom: A hackable text editor"
  [fbd87bd9]: http://shop.lenovo.com/gb/en/laptops/thinkpad/x-series/x1-carbon/ "Thinkpad X1 Carbon"
  [ea6f49f0]: https://github.com/atom/atom/issues/4161 "Feature Request: add crash restore"
  [95cedafa]: https://en.wikipedia.org/wiki/Magic_SysRq_key "Wikipedia: Magic SysRq key"
  [a957abbb]: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/194676 "SysRq should be limited by default like openSUSE"
  [aa27f6b4]: http://design.canonical.com/2015/09/prepare-for-when-ubuntu-freezes/ "Ubuntu Design: Prepare for when Ubuntu freezes"
