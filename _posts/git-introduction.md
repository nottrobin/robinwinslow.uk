Git introduction
===

Basic usage
---

After installing git you should have a program called `git bash`. This provides a unix-like terminal using MinGW/MSys. This command-line is the purest way to manage Git in windows, and is how you should manage it. Here are some example commands:

``` bash
$ git config --global user.name "Robin Winslow (nottRobin)"         # set your Git username
$ git config --global user.email robin.winslowmorris@hillarys.co.uk # set your email address

$ cd /c/inetpub/wwwroot/ # change to project directory
$ mkdir myproject        # create new project directory
$ cd myproject           # change to your project directory

$ git init               # initialise git repository this directory (create .git subdirectory)
Initialized empty Git repository in c:/inetpub/wwwroot/myproject/.git/
$ touch README.md        # create initial readme file
$ git add README.md      # stage the file to be committed
$ git status             # check the file has been staged
# On branch master
...
#       new file:   README.md
...

$ git commit -m 'Initial commit' # make the initial commit
$ git remote add origin git@git.assembla.com:my-project.git # add a blank remote repository to push to
$ git push origin master         # push your changes

$ git pull -u origin master                          # make sure we have the latest version of the code
$ git checkout -b feature-40-product-import-from-sap # create new feature branch to work on
.. do some development ..
$ git config --global push.default = current         # always push to a remote version of the current branch
$ git push                                           # create the new branch on origin remote
```

Learn
---

It is worth investing time in learning Git. Version control is here to stay, and Git is the latest and greatest VCS system out there and is continuing to grow. The majority of the future projects you work on will probably be using it.

You should read as much of the Git Book as you can (though we've probably covered Chapter 1 already), particularly chapters 3: Git Branching, 5: Distributed Git and 6: Git Tools.

Because Git is so widely used, it is extremely googleable. If you have any question at all, it's probably been asked before on Stack Overflow or the like.

Tips
---

### Speeding up command-line

`git bash` command-line can be fairly slow. You can fix this by changing the way the bash-prompt is generated:

First, create a `.bashrc` file and check where it is located:

``` bash
$ touch ~/.bashrc # don't forget the dot
$ echo ~/.bashrc # "~" signifies your home directory
/h/.bashrc # For example. Your home directory might be elsewhere
```

Now open that `.bashrc` file in your editor and add:

``` bash
export PS1='$ '
```

This is a very simple prompt that should be a lot quicker for Git to generate.

### Git aliases

You can use Git aliases to create short commands to often used commands. Here are some I've created:

``` bash
$ git config --global alias.s "status -sb" # Short status, including branch information
$ git s
## Initial commit on master
A  README.md

$ git config --global alias.cloner "clone --recursive" # clone a repository including all submodules
$ git cloner git@git.assembla.com:my-project.git # clone my-project and get submodules

$ git config --global alias.graph "log --all --graph --decorate --oneline -n30" # a coloured graph of the commit history
$ git graph # try it. looks complex at first, but quite useful
```

### Strategy

Git is extremely flexible and can be used in a myriad different ways. Therefore we need a strategy. Please read Git strategy.
