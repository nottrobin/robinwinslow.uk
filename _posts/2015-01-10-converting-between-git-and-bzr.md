---
title: Converting projects between Git and Bazaar
date: 2015-01-10 00:00:00 Z
tags:
- front-end
- back-end
- dev
- canonical
description: In my team, we often work in both git and bzr version control systems.
  This is a little guide about managing both together.
image_url: https://assets.ubuntu.com/v1/9b885339-bzr+to+git.png?w=230&h=160&mode=fill&bg=0000
layout: post
---

Here in the [design team](http://design.canonical.com/team/) we use both [Bazaar](http://en.wikipedia.org/wiki/GNU_Bazaar) and [Git](http://git-scm.com/) to keep track our projects' hostory.

We quite often end up coverting our projects from Bazaar to Git or vice-versa. Here are some tips on how to do that.

## Converting between Git and Bazaar

To convert revision history between Git and Bazaar, we will use their respective [fast](http://wiki.bazaar.canonical.com/BzrFastImport)-[import](https://www.kernel.org/pub/software/scm/git/docs/git-fast-import.html) features.

### Install `bzr-fastimport`

In either case, you need the `fastimport` plugin for Bazaar, which installs both `bzr fast-import` and `bzr fast-export`:

``` bash
cd ~/.bazaar/plugins
bzr branch lp:bzr-fastimport fastimport
```

### Git to Bazaar

To convert a Bazaar branch to Git, open a Bazaar branch of your project and do the following:

``` bash
git init                                        # Initialise a new git repo
bzr fast-export --plain . | git fast-import     # Import Bazaar history into Git
```

Now you should have all the revision history for that Bazaar branch in Git:

``` bash
git log  # Check your revision history is in Git
```

<small>(From [Astrofloyd's blog](http://astrofloyd.wordpress.com/2012/09/06/convert-bzr-to-git/))</small>

### Bazaar to Git

Converting from Bazaar to Git is slightly different. Because Bazaar stores branches in sub-folders, while Git stores branches all in the same directory, when you convert a Git repository to Bazaar, it will create a directory tree for the branches:

``` bash
bzr init-repo bzr-repo                                       # Create a new Bazaar repository tree
git fast-export -M --all | (cd bzr-repo; bzr fast-import -)  # Export Git history into Bazaar
```

`bzr-repo` will now contain a folder for each branch that was in your Git repository. You're probably most interested in `trunk`, which will be at `bzr-repo/trunk`, or perhaps `bzr-repo/trunk.remote`:

``` bash
cd bzr-repo/trunk  # Open the "trunk" branch (equivalent of "master")
bzr log | less     # Check your revision history is in Bazaar
```

<small>(From [the Bazaar wiki](http://wiki.bazaar.canonical.com/Scenarios/ConvertFromGit))</small>

## Keeping a project in both Git and Bazaar

You may wish to keep a project in both Git and Bazaar.

### Create ignore files for both systems

As your project may be used in either Git or Bazaar, you should create practically duplicate [`.gitignore`](https://help.github.com/articles/ignoring-files) and `.bzrignore` files, the only difference being that the `.bzrignore` should ignore the `.git` directory, and the `.gitignore` should ignore the `.bzr` directory. You should also make sure you ignore the `bzr-repo` directory - e.g.:

``` bash
$ cat .gitignore
.bzr/
.sass-cache/
bzr-repo/
*.pyc
$ cat .bzrignore
.git/
.sass-cache/
bzr-repo/
*.pyc
```

And keep both ignore files in all versions of the project.

### Only work in one repository

It is not practical to be doing your actual work in both systems, because converting from one to the other will overwrite any history in the destination repository. For this reason you need to choose to do all your work in either Git or Bazaar, and then regularly convert it to the other using the above conversion instructions.

(Originally published [on design.canonical.com][design-version])

[design-version]: http://design.canonical.com/2015/01/converting-projects-between-git-and-bazaar/ "ubuntu design: Converting projects between Git and Bazaar"