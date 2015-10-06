---
title: Introduction to PostgreSQL (for MySQL users)
---

I decided to use PostgreSQL for the latest app I'm writing just to try it out. I've been hearing about it for years, obviously, but I only first tried it out for a few minutes a month or so ago, and now is the first time I'm actually using it.

I'm going to write this as I go, from zero knowledge, so apologies if I get some stuff wrong.

Installation
===

I'm using Ubuntu, so I install PostgreSQL as follows:

``` bash
sudo apt-get install postgresql
```

You can check it's installed as follows:

``` bash
robin@ubuntu$ sudo -u postgres psql  # Open database as "postgres" system user
psql (9.1.10)
Type "help" for help.

postgres=# 
```

Server commands
===

PostgreSQL provides *command-line wrappers* for common server commands, so it's much more commonly administered from the command-line:

``` bash
$ psql [database] [user] # open database (opens user database by default)
$ createuser user        # create a database user
$ createdb database      # create a database
```

The basic `psql` command will attempt to open a database with the name of the current user, or fail. This is different from the basic `mysql` which will open the MySQL prompt without a database selected.

Databases and users
===

Unlike MySQL, PostgreSQL users are tied to system users, and users are expected to have a database with the same name. When you install PostgreSQL, a `postgres` system user, database user and database will be created.

Only the `postgres` system user can log as the `postgres` database user:

``` bash
robin@ubuntu$ psql postgres postgres  # try to login to "postgres" user & db - fails
psql: FATAL:  Peer authentication failed for user "postgres"
robin@ubuntu$ sudo su postgres        # switch to postgres user
postgres@ubuntu$ psql                 # psql will successfully login to "postgres" database by default
postgres=#
```

Note that by default a system user with the same name as a database user can login without a password, which simplifies account management somewhat.

Set yourself up as a PostgreSQL admin
===

It's just more convenient of your user can administer postgres, so you're not having to type `sudo -u postgres` all the time.

Let's create a database and database user with admin privileges for our current user:

``` bash
robin@ubuntu$ sudo -u postgres createuser --superuser robin  # create a database user for myself
robin@ubuntu$ sudo -u postgres createdb robin                # create a database for myself
robin@ubuntu$ psql                                           # I can now login to my database as me
robin=#
```

Creating a database for your app
===

The most convenient way to manage an app is to create 
