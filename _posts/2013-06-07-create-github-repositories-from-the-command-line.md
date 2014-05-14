---
layout: post
title: "Using Github's API to create repositories from the command-line"
description: "Here's a unix command to create a GitHub repository from the command-line. You can even set it to be a git alias, for even more convenience."
tags:
    - dev
    - back-end
    - git
---

[Git](http://git-scm.com) and [GitHub](https://GitHub.com) are fantastic tools for any kind of project. As soon as you start any piece of text-based work - be it a program, a diary or a novel - it makes sense to keep version control, and to have it backed up online somewhere.

So I'm now getting into the habit of setting up a git repository for the smallest of tasks:

``` bash
$ mkdir ~/projects/canvas-play && cd !#:1 # Make a new project directory 
$ sublime-text index.html # do some playing around with canvas
$ git init # make a repository
$ git add index.html # add my new canvas playing around
$ git commit -m 'Played around with some canvas'
```

That's great. I've got version control. But the real dream is to put that repository online somewhere so I can carry on working if I'm not at my computer, or I could smash my computer against the wall and not have lost my work.

The standard way isn't that difficult. Browse to GitHub, login, click "new repo" or whatever, type a name, copy the URL, then come back to the command-line. It only takes a minute or two, but it's kinda annoying to do that every time. I don't like touching the mouse if I can help it.

Updated solution: Hub
===

After I posted my solution (below) my friend [@timmow](https://twitter.com/timmow) mentioned that there is an existing project that provides a whole bunch of extension commands for Github - including creating repositories and managing pull requests.

It's called ["Hub"](https://github.com/defunkt/hub), and to be honest it might be simpler for you to just use that rather than my solution below.

My solution
===

So I found [this solution on StackOverflow](http://stackoverflow.com/a/10325316/613540) (of course). The following command uses `curl` to talk to the GitHub API to create a repository:

``` bash
# replace USER and REPO with real values
# but *not* the "/user/" in the GitHub URL
$ curl -u 'USER' https://api.github.com/user/repos -d '{"name":"REPO"}'
# you will be prompted for your password
$ git remote add origin git@GitHub.com:USER/REPO.git
```

I decided that I was going to use this *so* often that I should have a shortcut to it, so I made it a git alias:

``` bash
$ git config --global alias.gh-create '!sh -c "curl -u \"nottrobin\" https://api.github.com/user/repos -d \"{\\\"name\\\":\\\"$1\\\"}\" && git remote add origin git@github.com:nottrobin/$1.git" -'
```

Now I can augment my above process for new projects with the following:

``` bash
$ git gh-create canvas-play # create the GitHub repository
$ git push -u origin master # push my repository to GitHub
```

I don't know why, but this gives me a warm fuzzy feeling inside.
