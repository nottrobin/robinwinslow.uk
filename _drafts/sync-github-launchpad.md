---
layout: post
title: "Auto-syncing revision history from Github to Launchpad"
description: "To help us keep our Git and Bazaar histories in sync, we wrote an open-source web-service project to help us."
tags:
    - front-end
    - back-end
    - dev
    - canonical
---

In the [design team](http://design.canonical.com/team/) we keep some projects in [Launchpad](https://launchpad.net/) (as [canonical-webmonkeys](https://launchpad.net/~canonical-webmonkeys)), and some project in [Github](https://github.com/) (as [UbuntuDesign](https://github.com/ubuntudesign))), meaning we [work in both Bazaar and Git](LINK!!!!!!). 

The need to synchronise Github to Launchpad
===

Some of our Github projects need to be also stored in Launchpad, as some of our systems only have access to Launchpad repositories.

Initally we were [converting these projects manually](LINK!!!!!!) at regular intervals, but this quickly became too cumbersome.

The Bazaar synchroniser
===

To manage this we created a simple [web-service project to synchronise Git projects to Bazaar](https://github.com/ubuntudesign/bzr-sync). This script basically automates the techniques described in [our previous article](LINK!!!!!!) to pull down the Github repository, convert it to Bazaar and push it up to Launchpad at a specified location.

It's a simple Python [WSGI](http://en.wikipedia.org/wiki/Web_Server_Gateway_Interface) app which can be run directly or through a server that understands WSGI like [gunicorn](http://gunicorn.org/).

Setting up the server
---

Here's a guide to setting up our `bzr-sync` project on a server somewhere to sync Github to Launchpad.

### System dependencies

Install necessary system dependencies:

``` bash
sudo apt install git bzr python-pip
```

### User permissions

First off, you'll have to make sure you set up a user on whichever server is to run this service which has read access to your Github projects and write access to your Launchpad projects:

``` bash
sudo adduser bzr-sync  # Create new bzr-sync user
sudo su bzr-sync       # Change to bzr-sync user
ssh-keygen             # Create new RSA key
cat ~/.ssh/id_rsa.pub  # Add this public key to Github and Launchpad
# Now check we can clone your github projects properly
git clone git@github.com:example/example-project
rm -r example-project  # Once we've tested this, delete the project again
# And check we can branch and push to launchpad projects
bzr branch lp:example-project  # Branch a project
cd example-project             # Change to its directory
bzr push :parent               # Check pushing works
rm example-project             # Cleanup
```

### Cloning the project

Then you should clone [the project](https://github.com/ubuntudesign/bzr-sync) and install dependencies. We placed it at `/srv/bzr-sync` but you can put it anywhere:

``` bash
# Clone the repository, and make it owned by our user (bzr-sync)
sudo git clone git@github.com:ubuntudesign/bzr-sync.git /srv/bzr-sync
sudo chown -R bzr-sync:bzr-sync /srv/bzr-sync
# Install python dependencies
sudo pip install -r /srv/bzr-sync/requirements.txt
```

### Preparing gunicorn

We should serve this over HTTPS, so our `auth_token` will remain secret. This means you'll need a SSL certificate keyfile and certfile. You should get one from a certificate authority, but for testing you could just generate a self-signed-certificate.

Put your certificate files somewhere accessible (like `/srv/bzr-sync/certs/`), and then test out running your server with `gunicorn`:

``` bash
gunicorn --keyfile /srv/bzr-sync/ubuntu.qa.key --certfile /srv/bzr-sync/ubuntu.qa.cert --pythonpath /srv/bzr-sync --bind 0.0.0.0:9052 wsgi:application
```

### Try out the sync server

You should now be able to synchronise a Github repository with Launchpad by pointing your browser at:

```
https://{server-domain}/?token={secret-token}&git_url={url-of-github-repository}&bzr_url=lp:{launchpad-branch-location}
```

You should be able to see the progress of the conversion as command-line output from the above `gunicorn` command.

### Add upstart job

Rather than running the server directly, we can setup an upstart job to manage running the process. This way the bzr-sync service will restart if the server restarts.

Here's an example of an upstart job, which we placed at `/etc/init/bzr-sync.conf`:

``` bash
# /etc/init/bzr-sync.conf

# A WSGI application
# to sync a github repository to a launchpad one

description "BZR sync"

start on runlevel [2345]
stop on runlevel [016]

respawn

exec start-stop-daemon --start -c bzr-sync --exec /usr/bin/gunicorn -- --keyfile /srv/bzr-sync/certs/bzr-sync.key --certfile /srv/bzr-sync/certs/bzr-sync.cert --pythonpath /srv/bzr-sync --bind 0.0.0.0:9052 wsgi:application
```

You can now start the bzr-sync server as a service:

``` bash
sudo start bzr-sync
```

And output will be logged to `/etc/upstart/bzr-sync.log`.

Setting up Github projects
---

Now to use this sync server to automatically synchronise your Github projects to Launchpad, you simply need to add a [post-commit webhook](https://github.com/blog/1778-webhooks-level-up) to ping a URL of the form:

```
https://{server-domain}/?token={secret-token}&git_url={url-of-github-repository}&bzr_url=lp:{launchpad-branch-location}
```

![Creating a webhook](http://i.imgur.com/b9ylshF.png)

In your repository settings, select "Webhooks and Services", then "Add webhook", and enter the following information:

- **Payload URL**: https://{server-domain}/?token={secret-token}&git_url={url-of-github-repository}&bzr_url=lp:{launchpad-branch-location}
- **Content type**: "application/json"
- **Secret**: -leave blank-
- Select **Just the push event**
- Tick **Active**

![Saving a webhook](http://i.imgur.com/AIGTTRr.png)

**NB**: Notice the `Disable SSL verification` button. By default, the hook will only work if your server has a *valid* certificate. If you are testing with a self-signed one then you'll need to disable this SSL verification.

Now whenever you commit to your Github repository, Github should ping the URL, and the server should synchronise your repository into Launchpad.
