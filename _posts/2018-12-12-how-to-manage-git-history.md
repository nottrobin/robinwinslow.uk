---
title: 'How to manage your Git history: Tips for keeping your commits tidy'
date: 2018-12-12 00:00:00 Z
description: A number of techniques I use frequently for maintaining control over
  my Git commit history in my feature branches.
image_url: https://assets.ubuntu.com/v1/8f90595a-20181211_152357.jpg?w=800
layout: post
---

One of the things we’re [currently working
on](https://github.com/canonical-webteam/practices/pull/138) in the web and
design team is a page about writing Git commit messages for our [team practices
website](https://canonical-webteam.github.io/practices/) (I hope to write more
about the practices website itself in the coming days).

As part of that discussion, we jotted down some quick tips for managing your
commit history to tell a neat story with your commit messages, which I’ll share
below.

These are the techniques I’ll discuss below:

* Frequently run `git pull --rebase upstream master`
* Don’t use `git commit --all`
* Make use of `git add --patch {file}`
* Amend previous commits with `git commit --amend --no-edit`
* Reorder commits with `git rebase -i`

I’ll elaborate more on each, and why they’re helpful, below.

### Why change commit history?

Your Git commit history should be clear and descriptive — it should read like a
logical set of steps that explain how the project got to its current state,
where each commit defined one single, small but complete enhancement.

> *Who controls the past controls the future. Who controls the present controls
> the past.*
> 
> *“1984” by George Orwell*

However, when we’re doing the work it is rarely so neat. We might create a new
class in one commit but then 4 commits later realise we need to change the name
of the class, or fix a typo. If you haven’t yet merged your work, it would be
best to update the original commit where you did the original work with the fix,
to tell a simple and clear story.

Bear in mind that this means [rewriting
history](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History), which is
very problematic if the history is shared. Therefore, *you should only do this
while you have complete ownership over the history being rewritten*. For
example, if your commits are still only local to your computer, or if they are
in a feature branch owned by you that hasn’t yet been merged with the central
repository.

![Only rewrite history in spaces you control](https://assets.ubuntu.com/v1/8f90595a-20181211_152357.jpg?w=800)  
*Only rewrite history in places that you fully control*

In [our workflow](https://canonical-webteam.github.io/practices/workflow/github.html),
we do all new work on [feature branches](https://www.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow)
on our own [forks](https://help.github.com/articles/fork-a-repo/) of the central
repository. These feature branches are therefore wholly owned by the person
working on that feature. So in our case, we use the below tips *only* to tidy up
our Git commits in our feature branches before merging our work into the central
repository.

After we’ve rewritten history on one of our feature branches, we may then need
to run `git push --force` to force the remote version of the feature branch to
use our rewritten version of history. But it’s very important to only ever `git
push --force` to *overwrite new work on a feature branch that you wholly
control*.

### Mastering your history

These are some tricks I use for tidying up the Git commit history on my feature
branches as I work, so they tell a neat story.

### Frequently rebasing from `master`

If you work on feature branches, like we do, that are based off a parent branch
(e.g. the `master` branch of the main repository), you want to avoid your branch
getting out of sync with the latest work in the parent branch.

As time goes by, your forked branch where you’re working can become
significantly out of sync with the latest `master` branch. This may mean that
merging your work when you’ve finished might become very tricky. You can avoid
this by frequently running:

``` bash
git pull --rebase upstream master
```

(where `upstream` is the name of the remote pointing to your central repository,
and `master` is your parent branch).

This will grab any new commits from the `master` branch, and then add all the
commits in your feature branch on top of them. This keeps everything in a clear
logical order.

If you can, you should also run `git pull --rebase upstream master` just before
your feature is merged into `master`. This will help the history in `master`
stay chronological, rather than branching too often.

### Commiting files explicitly

Try to avoid using `git commit --all` (or `git commit -a`). This creates a
commit that automatically includes all existing changes for currently tracked
files (it won’t add changes from files that aren’t yet tracked).

By doing this you miss a chance to consider how your work could be logically
grouped into multiple commits. It can also easily lead to errors, because you
might easily accidentally include changes you weren’t aware of, and forget to
include new files that aren’t currently tracked.

Instead, try to get into the habit of checking which files are actually changed
(with `git status`), and then adding files to your commits explicitly:

``` bash
git add {file1} {file2} git commit
```

### Separating changes within the same file

You can explicitly choose which changes to add to a commit with the `--patch`
command:

``` bash
git add --patch {file}
```

This will open an interactive menu for each block of the diff on that file, so
you can choose to add work to the commit bit by bit. This means, for example,
that if you solved one problem at the top of the file and another problem at the
bottom, you can easily add the first change to one commit and the second change
to another.

You can even manually edit the diff to choose what to add line by line, or even
change the diff completely.

### Add changes to the previous commit

If you’ve created a commit already, but then you do more work that should
logically be included in that same commit, you can simply add new work to the
previous commit with:

``` bash
git add {file} git commit --amend --no-edit
```

The `--no-edit` command means you don’t want to change the commit message. You
can also omit this if you want to change the description of the commit.

### Reordering commits with interactive rebasing

Let’s say:

1.  You do some work in `users.js` and you commit it with “Improve user logic”
1.  You do some work in `README.md` and you commit it with “Explain user logic
better in README”
1.  Now you realise you need another fix to your `users.js` work. You want it to be
added to the “Improve user logic” commit, so do this:

``` bash
$ git add users.js
$ git commit -m '... to be rebased'
$ git rebase -i HEAD~3 # Interactively rebase the last 3 commits
```

This will open an editor with these contents:

```
pick 239d4c3 Improve user logic
pick adc7c21 Explain user logic better in README
pick fd4f81b ... to be rebased
```

Now if we reorder our commits to move line 3 to line 2, and replace “pick” with
“squash” (or simply “s”), then it will “squash” the “… to be rebased” commit
into the “Improve user logic” one:

```
pick 239d4c3 Improve user logic
squash fd4f81b ... to be rebased
pick adc7c21 Explain user logic better in README
```

Save and exit, and the commit to “squash” will be combined with the commit above
it, to form a new commit. Another editor window will open for you can edit the
commit message for the new commit:

```
# This is a combination of 2 commits.
# This is the 1st commit message:
Improve user logic
# This is the commit message #2:
... to be rebased
```

In this case we should just delete the second message, save and exit, and
voila!:

```
$ git log
commit b87706ed594c983841857b51923e499988760d41 (HEAD -> master)
Author: Cody Pendant 
Date:   Fri Dec 7 11:05:54 2018 +0000

    Explain user logic better in README

commit da1e9d47073cdc3bf86d3658b2e020c7e37292c0
Author: Cody Pendant 
Date:   Fri Dec 7 11:05:40 2018 +0000

    Improve user logic
```

This process might seem complicated, but once you’ve done it a couple of times,
you’ll see that it actually doesn’t take long. When you get used to it it will
probably only take about 15–20 seconds.

There are of course some cases where commits can’t be neatly re-ordered
(although fewer than you’d think). In these cases, after you perform your
interactive rebase, you’ll get a conflict which you’ll have to resolve in the
normal way. You’ll quickly get a feel for which commits can be reordered and
which can’t, and if you think it’s going to be too much trouble, just don’t
bother starting. Or `git rebase --abort`.

You can also use interactive rebasing to remove commits, or combine multiple
commits into one.

### Go forth and rewrite history (carefully)

Please consider these tricks as tools in your tool-box, to be used where
necessary. Different projects work differently, and so spending time carefully
crafting your commits may or may not be appropriate to your context.

Either way, hopefully these tricks can be useful to help you feel more in
control of your commit history.

Happy committing!

*****

*Originally published at [blog.ubuntu.com](https://blog.ubuntu.com/2018/12/12/tricks-for-keeping-a-tidy-git-commit-history) on December 12, 2018.*
