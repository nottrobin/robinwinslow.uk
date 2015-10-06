---
layout: post
title: First experiences with x1 carbon
---

Initial stuff
===

My laptop came with Windows 8, which was interesting. I've never used Windows 8 before, and at first it was very confusing. I can see what they're trying to do, and overall it's not a terrible OS, but that's for another post.

I always intended to install Ubuntu, and use it as my primary OS on my new carbon, so I only stayed in Windows 8 long enough to download the 28-hour-old Ubuntu 13.04 (Raring Ringtail) and create a bootable USB drive from it. 

Even during that time, I came across a few annoyances:
- How do I open things in Windows 8?
- The touchpad was difficult to use
- Function key where control key should be

Ubuntu
===

Ubuntu was simple to install, as we've come to expect by now. I'm struggling to remember what my initial difficulties were.

Difficulties
---

- Chrome - "Dependency is not satisfiable: libudev0 (>=147)"
  Solution - http://launchpadlibrarian.net/119461136/libudev0_175-0ubuntu13_amd64.deb
- Battery life
  Solution - https://wiki.ubuntu.com/Kernel/PowerManagement/PowerSavingTweaks

Tweaks
---

### gnome-shell

** write seperate article about my gnome-shell setup **
- I installed [maximus](link). I like to usually work with my applications maximised, and preferably on a different desktop so I can slide between them.
- A bunch of extensions

The first thing I did was install gnome-shell. I'd not used it before, it was recommended to me by a friend. I was blown away. It is absolutely awesome. Here are some advantages:

- Completely replaces start-menu-style app menus with search
  Now if you want to open "sublime" you type "subl" -> [enter]
- Minimal
  The standard screen shows just one thin top-bar, and that's it (I removed even this)
- Customisable
  There is a website of extensions that are as simple to install as you could possible imagine. And most extensions exist
- Window management
  Out of the box, gnome-shell enables easy shortcuts for maximising or tiling windows
- Sensible desktop management
  gnome-shell always gives you one more desktop than you're currently using. To start with you have 2. If you use the second one, a third appears &c.

Software
---

- Chrome-beta
- Skype
- Steam
- Virtualbox

### Development

git; python-devtools; gunicorn; flask; bundler; sublime;

Still to sort out
===
- Make sure battery life is optimal - DONE!
- Work out how to dual-boot windows 8
- Make it so when I open a new app it opens full-screen in a new desktop
- Brightness keys don't work to start with
- Microphone mute - DONE!
