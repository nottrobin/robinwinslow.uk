---
title: "How to use Linux Containers with LXD 2, and why you might want to"
---

[Linux Containers (LXC)](https://linuxcontainers.org/) effectively spin up
mini virtual operating systems inside Linux, except that they're much more
light-weight, and therefore much quicker, than true [virtual machines][].

[LXD][] is a new system-wide daemon which improves performance & security,
and also offers an improve interface for the `lxc` command.

You may want to skip straight to [Installing LXD][] or [How to use LXD][].

## tl;dr summary

Once you've [installed LXD][install], create a new container and open a bash
terminal with:

```bash
lxc launch ubuntu:16.04 xenial  # Download 16.04 image and start the container
lxc exec xenial -- bash         # Run and attach to a bash terminal in the container
```

## Why are containers so useful?

As containers are like lighter virtual machines, you can use them for very much
the same things, but do them _much_ faster:

- Install & run things in a different version of Linux than is installed locally
- Run a software project within a predictable context for development (e.g. many
  people currently use [Vagrant][] for this)
- Test that things still work in a clean install of your operating system

Also, as containers are phenomenally faster (they can take less than one
second to start) and use much less resources, they also bring with them new
possibilities:

- Run many containers side-by-side, to test out large networks of interconnected services
- Run each individual process in its own container with encapsulated
  dependencies (rather than whole software projects)

## Installing LXD

If you're running `14.04` ("trusty") or 15.10 ("wily"), first install this PPA
(if you're running `16.04` ("xenial") you should skip this step):

```bash
sudo add-apt-repository ppa:ubuntu-lxc/lxd-stable  # Add the LXD official PPA
sudo apt update        # Update apt sources to include new PPA packages
sudo apt dist-upgrade  # Ensure existing packages are up-to-date with the new PPA
```

Now install LXD, and add yourself to the `lxd` group:

```bash
sudo apt install lxd
newgrp lxd
```

### Initialising LXD

Now initialise LXD, with a `dir` backend and an LXD bridge:

```bash
$ sudo lxd init
Name of the storage backend to use (dir or zfs): dir
Would you like LXD to be available over the network (yes/no)? no
Do you want to configure the LXD bridge (yes/no)? yes
```

Now the "Package configuration" will open and ask you to configure LXD.
If you're unsure about any of the questions, just select the default option by
pressing `<enter>`.

[[official installation guide][install]]

## How to use LXD

At the time of writing the latest version of LXD is `2.0.0`.
LXD is evolving fast, and things may change in subsequent versions.

### Quickly start a container

To download and start a container running [Ubuntu 16.04][], simply run:

```bash
lxc launch ubuntu:16.04 xenial  # We're naming this container "xenial", but you could choose any name you like
```

It will take a while the first time as it has to download the OS image, but to
create subsequent containers from the same image should only take a matter of
seconds.

Once it's finished, check it's running:

```bash
$ lxc list
+--------+---------+------+------+------------+-----------+
|  NAME  |  STATE  | IPV4 | IPV6 |    TYPE    | SNAPSHOTS |
+--------+---------+------+------+------------+-----------+
| xenial | RUNNING |      |      | PERSISTENT | 0         |
+--------+---------+------+------+------------+-----------+
```

### Running commands

To run a command in our new container, use the `lxc exec` command. The command
will run as the `root` user, in the `/root` directory inside the container.

You can run any command that you would normally run in a Linux system,
but the most immediately useful command to run is `bash`, which will drop you
into a bash shell inside the container:

```bash
$ lxc exec xenial -- bash
root@xenial:~# echo "hello from inside the container!"
hello from inside the container!
root@xenial:~#
```

### Networking

If you [initialised LXD earlier](#initialising-lxd) with a network bridge,
your container should already have an IP address which you can connect to
directly:

```bash
$ lxc exec xenial -- ifconfig | grep "inet addr"  # Find the IP address
          inet addr:10.95.60.183  Bcast:10.95.60.255  Mask:255.255.255.0
$ ping 10.95.60.183  # Check we can see that IP address
64 bytes from 10.95.60.183: icmp_seq=1 ttl=64 time=0.134 ms
```

You can use this IP address for accessing any servers that you run in your
container. If you need to use different network settings, simply run `lxd init`
again.

### Sharing folders

You can share folders with your container as "devices". The syntax is:

```bash
lxc config device add {container-name} {device-name} disk source={full-path-to-folder} path={path-inside-container}
```

So if we want to create a `share` directory and share it with the container at `/media/share`:

```bash
mkdir share  # Create a new "share" directory
touch share/hello  # Create a "hello" file inside the directory
lxc config device add xenial shareddir disk source=`pwd`/share path=/media/share  # Share it with the container
```

Now let's check the device is set up and that we can see it inside the container:

```bash
$ lxc config device list xenial  # List all devices in the container
root: disk
shareddir: disk
$ lxc exec xenial -- ls -l /media/share
total 0
-rw-rw-r-- 1 nobody nogroup 0 May 16 16:55 hello
```

##### Gaining write access to shared folders

You'll notice that the file inside `/media/share` in the container is owned by
`nobody:nogroup`. This is true of the directory as well, and means that root
can't actually edit or create files inside the shared directory:

```bash
$ lxc exec xenial -- touch /media/share/hello
touch: cannot touch '/media/share/hello': Permission denied
```

This is because the permissions inside the container are exactly the same as
in the host system - as in the directory is still owned by _your user_. The
container runs as an unprivileged user and so doesn't have access to your user's
things.

To fix this, we can extend the permissions on the share directory to give the
container's user access to it. Let's look at the permissions it has currently:

```bash
$ getfacl share
## file: share
## owner: {your-user}
## group: {your-user}
user::rwx
group::rwx
other::r-x
```

First we need to find the user ID of the container's user:

```bash
$ ls -ld /var/lib/lxd/containers/xenial/rootfs
drwxr-xr-x 22 165536 165536 4096 May 17 17:18 /var/lib/lxd/containers/xenial/rootfs
## Here the user ID is 165536
```

Then we can add extra permissions for this user and the LXD user with `setfacl`:

```bash
$ setfacl -Rm user:lxd:rwx,default:user:lxd:rwx,user:165536:rwx,default:user:165536:rwx share
$ getfacl share  # Check permissions again
## file: share
## owner: {your-user}
## group: {your-user}
user::rwx
user:lxd:rwx
user:165536:rwx
group::rwx
mask::rwx
other::r-x
default:user::rwx
default:user:lxd:rwx
default:user:165536:rwx
default:group::rwx
default:mask::rwx
default:other::r-x
```

You should now be able to create and edit files in the shared folder from
within the container:

```bash
$ lxc exec xenial -- touch /media/share/hello-again
$ ls share
hello  hello-again
```

### Privileged containers

We can also make containers "privileged", which sets the root user inside the
container to be the same as the root user on the host system.

This would have been a way to solve the shared folders problem above, but it
is unsafe (and in that case unnecessary), as it means that programs inside
the container can escape into root on the host system in some circumstances.

First, note that the `rootfs` directory in your container is currently owned by
an unprivileged user:

```bash
$ ls -ld /var/lib/lxd/containers/xenial/rootfs
drwxr-xr-x 22 165536 165536 4096 May 17 17:18 /var/lib/lxd/containers/xenial/rootfs
```

To make the container privileged:

```bash
lxc config set xenial security.privileged true
```

And note that the `rootfs` owner is now `root` in the host:

```bash
$ ls -ld /var/lib/lxd/containers/xenial/rootfs
drwxr-xr-x 22 root root 4096 May 17 17:18 /var/lib/lxd/containers/xenial/rootfs
```

[Read more about unprivileged vs privileged containers][stgraber-unpriv]

### Launching other images

In the command we ran earlier:

```bash
lxc launch ubuntu:16.04 xenial
```

"ubuntu" is the name of a remote image list and "16.04" is the alias of an
image from that list.

To find other images, there are several list commands:

```bash
lxc remote list               # See what other remotes are available
lxc image list ubuntu:        # List all images in the "ubuntu" remote
lxc image alias list ubuntu:  # List every alias in the "ubuntu" remote
lxc image alias list images:  # List every alias in the "images" remote
```

From the last command, we can see that there's an image available in the
"images" remote with the alias "alpine/edge/amd64", so we could choose to
launch an alpine container in the same way:

```bash
lxc launch images:alpine/edge/amd64 alpine  # We're naming this container "alpine", but you could choose any name you like
```

[lxd]: https://linuxcontainers.org/lxd/ "Linux Containers: What's LXD?"
[virtual machines]: https://en.wikipedia.org/wiki/Virtual_machine "Virtual machines"
[vagrant]: https://www.vagrantup.com/ "Vagrant homepage"
[how to use lxd]: #how-to-use-lxd
[install]: https://linuxcontainers.org/lxd/getting-started-cli/ "Installing LXD and the command line tool"
[ubuntu 16.04]: ""
[install other remotes]: https://linuxcontainers.org/lxd/getting-started-cli/#importing-some-images "LXD official documentation: Importing some images"
[stgraber-unpriv]: https://www.stgraber.org/2014/01/17/lxc-1-0-unprivileged-containers/ "LXC 1.0: Unprivileged containers [7/10] - Introduction to unprivileged containers"
