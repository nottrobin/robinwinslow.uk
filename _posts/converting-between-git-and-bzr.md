---
layout: post
title: "Using Git within Canonical, and converting projects between Git and Bazaar"
description: "In my team, we often work in both git and bzr version control systems. This is a little guide about managing both together."
tags:
    - front-end
    - back-end
    - dev
    - canonical
---

Here in the [design team](http://design.canonical.com/team/) we wok on projects in both Launchpad (mostly as [canonical-webmonkeys](https://launchpad.net/~canonical-webmonkeys)) and Github (as [UbuntuDesign](https://github.com/ubuntudesign)). This means that we have some projects using [Bazaar](http://en.wikipedia.org/wiki/GNU_Bazaar), some using [Git](http://git-scm.com/) (the respective [version control systems](http://en.wikipedia.org/wiki/Revision_control) for the two hosts), and some projects using both.

This means we quite often end up coverting our projects from Bazaar to Git or vice-versa. Fortunately, this actually really easy.

Converting between Git and Bazaar
===

To convert revision history between Git and Bazaar, we will use their respective [fast](http://wiki.bazaar.canonical.com/BzrFastImport)-[import](https://www.kernel.org/pub/software/scm/git/docs/git-fast-import.html) features.

Install `bzr-fastimport`
---

In either case, you need the `fastimport` plugin for Bazaar, which installs both `bzr fast-import` and `bzr fast-export`:

``` bash
sudo apt-get install bzr-fastimport
```

Git to Bazaar
---

To convert a Bazaar branch to Git, first open a Bazaar branch for your project and do the following:

``` bash
git init                                        # Initialise a new git repo
bzr fast-export --plain . | git fast-import     # Import Bazaar history into Git
```

Now you should have all the revision history for that Bazaar branch in Git:

``` bash
git log  # Check your revision history is in Git
```

(I got this solution off [Astrofloyd's blog](http://astrofloyd.wordpress.com/2012/09/06/convert-bzr-to-git/).)

Bazaar to Git
---

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

(I got this solution off [the Bazaar wiki](http://wiki.bazaar.canonical.com/Scenarios/ConvertFromGit).)

Working in Git but duplicating to Bazaar
===

Something we've been doing a fair bit is doing our actual work in Git, but regularly copying the revision history to Bazaar. Here's how:

Create ignore files for both systems
---

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

Create your repository first in Git, then copy to Bazaar
---

As Git is the main system we'll be working in, you should create this first:

``` bash
git init
git add .
git commit -m "Project's genesis"
git push <your-remote-host>
```

Now copy history to the Bazaar repo in the `bzr-repo` folder:

``` bash
bzr init-repo bzr-repo                                       # Create a new Bazaar repository tree
git fast-export -M --all | (cd bzr-repo; bzr fast-import -)  # Export Git history into Bazaar
cd bzr-repo/trunk                                            # Open the "trunk" branch (equivalent of "master")
bzr log | less                                               # Check your revision history is in Bazaar
bzr push lp:<example-project>                                # Push your Bazaar history to Launchpad
cd ../..                                                     # Back to the original project folder
```

Updating the Bazaar repo
---

After you've made a few more commits to your Git repository, you should be able to follow the above steps again to update the Bazaar repository with the new commits.

Only have one person update Launchpad
---

One gotcha with the above method is that, if someone else updates the Bazaar repository, Launchpad will consider the Bazaar history to have changed, and you will need to `--overwrite` the remote Bazaar repository to push again, which is a dangerous operation. To be on the safe side, keep only one person responsible for copying the revision history to Bazaar.

The Bazaar synchroniser
===

We've created a [rudimentary server project](https://github.com/ubuntudesign/bzr-sync) to synchronise Git projects to Bazaar whenever we commit to Github by setting up a [Webhook](https://help.github.com/articles/about-webhooks/) for our Github projects to ping a URL of the form:

```
https://sync-server.example.com/?token={secret-token}&git_url={url-of-github-repo}&bzr_url=lp:~{launchpad-branch-location}
```
