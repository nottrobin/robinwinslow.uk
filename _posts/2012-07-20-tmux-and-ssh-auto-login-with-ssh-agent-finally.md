---
title: TMUX and SSH auto-login with ssh-agent (finally!)
description: The steps necessary to get TMUX ssh-agent correctly configured. 
layout: post
tags:
  - unix
  - dev
  - back-end
---
 
I finally got this working, so I thought I'd blog about it.

Here's what I wanted to achieve:

 - I log in to my unix system via SSH
 - [tmux](http://tmux.sourceforge.net/), my terminal multiplexer, starts up automatically
 - I can then SSH between my environments <strong>without</strong> typing in a password every time.

This is harder than you might think, as it requires several things to work together. After reading [through](http://spin.atomicobject.com/2012/01/28/less-perplexing-terminal-multiplexing-with-tmux/) loads [of](http://superuser.com/questions/237822/how-can-i-get-ssh-agent-working-over-ssh-and-in-tmux-on-os-x) blog [posts](http://www.opsbs.com/2011/04/terminal-multiplexing-with-ssh-agent-my-tmux-setup/) I worked out how to do it:

 - A password-less private key setup in your .ssh/ directory (e.g. ~/.ssh/id_dsa)
 - The public key added to the authorised_keys for each destination box
 - An ssh-agent environment running to automatically forward your keys for SSH connection.
 - Make sure you don't spawn a new ssh-agent each time you log in, as you'll end up with hundreds of orphaned processes.
 
It was the last step I was struggling with. To setup the first two steps [follow the guide here](http://www.thegeekstuff.com/2008/11/3-steps-to-perform-ssh-login-without-password-using-ssh-keygen-ssh-copy-id/).

However, if you then don't do the final step, it will always ask for a passphrase for your key whenever you try to SSH:

```
[rwmorris@dev:~] $ ssh qa
Enter passphrase for key '/home/rwmorris/.ssh/id_dsa.pub':
```

For step 3 you need your tmux session to be aware of the ssh-agent environment, which isn't too hard.

The problem in step for is that, stupidly, ssh-agent processes persist even if you log out of your terminal, and then if you spawn a new one when you log in again you end up with hundreds of orphaned processes and the sysadmins get upset.

The solution to that is to make sure you start you ssh-agent with the "-a" option to specify the socket it should use, and then make sure you store the process ID (PID) somewhere. That way you can re-set the $SSH_AUTH_SOCK and $SSH_AGENT_PID environment variables to the correct values when you login again, and everything will work.

1: Fire up the ssh-agent process before you run your tmux session, making sure you only start a new one if there isn't an existing one already.

``` bash
# ~/.bashrc

if [ -z "$TMUX" ]; then
    # we're not in a tmux session
    
    if [ ! -z "$SSH_TTY" ]; then
        # We logged in via SSH
        
        # if ssh auth variable is missing
        if [ -z "$SSH_AUTH_SOCK" ]; then
            export SSH_AUTH_SOCK="$HOME/.ssh/.auth_socket"
        fi

        # if socket is available create the new auth session
        if [ ! -S "$SSH_AUTH_SOCK" ]; then
            `ssh-agent -a $SSH_AUTH_SOCK` &gt; /dev/null 2&gt;&amp;1
            echo $SSH_AGENT_PID &gt; $HOME/.ssh/.auth_pid
        fi

        # if agent isn't defined, recreate it from pid file
        if [ -z $SSH_AGENT_PID ]; then
            export SSH_AGENT_PID=`cat $HOME/.ssh/.auth_pid`
        fi

        # Add all default keys to ssh auth
        ssh-add 2>/dev/null

        # start tmux
        tmux attach
    fi
fi
```

2: Make sure tmux is configured to pass through appropriate environment variables so it can find the socket for your ssh-agent session:

``` bash
# ~/.tmux.conf
set -g update-environment -r
```

And win. Sorry it's not more simple. You'd think a lot of this would be the default use-case so it would just work out of the box, but sadly that's not the way the unix world works. 
