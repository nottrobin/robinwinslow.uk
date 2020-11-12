---
title: Don't ever commit binary files to Git! Or what to do if you do.
date: 2013-06-11 00:00:00 Z
tags:
- dev
- back-end
- git
description: Why you shouldn't commit binary files to a distributed version control
  system - and how you can remove them completely if you do.
image_url: https://assets.ubuntu.com/v1/7e800a30-Don+t+ever+commit+binary+files+to+Git+Or+what+to+do+if+you+do+.png?w=230&h=160&mode=fill&bg=0000
layout: post
---

Git is a great [distributed version control system](http://en.wikipedia.org/wiki/Distributed_revision_control). It's fantastically for easily storing changed to *text files* wherever you are, and then easily copying them up to a server or servers or sharing them with your friends locally.

## Avoid binary files

"Text files" is the key here. It easily lets you see textual changes. But this function is useless for binary data. Data about changes in binary files just makes the commits impossible to read.

There is another very good reason for keeping binary files out of your repository: They are usually much bigger. Images, videos and compiled binaries are all much bigger than text files. If you commit them to your repository, the size of your repository will become much larger.

This matters not because storage is expensive - it's not. It matter because the point of using a *distributed* VCS is that it makes it cheap and easy to *clone and navigate*. You want to be able to spin up a new machine and copy the repository as quickly as possible. You want to be able to switch branches as quickly as possible. If you commit any significant number of binary files you will see all of these tasks slow down considerably.

It's important to *never commit binary files* because once you've commit them they are *in the repository history* and are very annoying to remove. You can delete the files from the *current version* of the project - but they'll remain in the repository history, meaning that the overall repository size will still be large.

## How you can fix it

You can totally remove large files from the repository only by *rewriting history*. This is extremely dangerous because it will overwrite all commits since files were added, producing a completely different version of the revision history.

If you have shared your repository with anyone, or stored it anywhere else (like [Github](https://github.com)) you must make sure that *all versions of these repositories* get updated to your new version before anyone tries to add any new work on top. This can be a huge ball-ache.

However, if you **understand the risks** you can rewrite history using a [fantastic script](https://gist.github.com/nottrobin/5758221) I found on [David Underhill's blog](http://dound.com/2009/04/git-forever-remove-files-or-folders-from-history/). It first uses `git filter-branch` to remove the files from the commits, and then deletes the relevant caches of the files.

Make sure you've committed all your work and have a backup copy of your up-to-date repository somewhere. Then do the following:

``` bash
# Get hold of the script
$ wget -O- https://gist.github.com/nottrobin/5758221/raw/ff740b4ac3b8ab80d40e3598ec461400dce42b5d/git-prune | sudo tee -a /usr/bin/git-prune-files
$ sudo chmod +x /usr/bin/git-prune-files

# Change to your project directory
$ cd ~/projects/my-git-project

# Remove the relevant files
$ git-prune-files static/images
```

This might take a while and should give you an output something like this:

```
...
rm 'static/images/9419.jpg'
rm 'static/images/9420.jpg'
rm 'static/images/9421.jpg'
Rewrite 325bfc6a34e33a9d4ef4b19ec88b52dfdc3f1e74 (9421/9421)
Ref 'refs/heads/master' was rewritten
Counting objects: 22041, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (21761/21761), done.
Writing objects: 100% (22041/22041), done.
Total 22041 (delta 15312), reused 5817 (delta 0)
```

Now make *absolutely sure* this version of the repository replaces *all copies* of your repository *immediately*.