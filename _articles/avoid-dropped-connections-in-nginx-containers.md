---
date: 2019-11-18
title: 'Avoiding dropped connections in nginx containers with "STOPSIGNAL SIGQUIT"'
description: 'By default, Nginx will terminate abruptly when stopped. This can easily lead to dropped connections in production services. SIGQUIT is the answer.'
layout: post
---

*Update: The default used in the official nginx docker image was changed from SIGTERM to SIGQUIT [in November 2020](https://github.com/nginxinc/docker-nginx/commit/3fb70ddd7094c1fdd50cc83d432643dc10ab6243), so this should no longer be an issue for Docker or Kubernetes users.*

[nginx](https://www.nginx.com/resources/wiki/) is a very popular web server.

It may have just become the _most_ popular web server, with 33% market share [according to the October 2019 Netcraft survey](https://news.netcraft.com/archives/2019/10/24/october-2019-web-server-survey.html). This may be in large part thanks to the [growth in Kubernetes adoption](https://dzone.com/articles/survey-reveals-rapid-growth-in-kubernetes-usage-se), as most Kubernetes installations use nginx as the [default ingress controller](https://github.com/kubernetes/ingress-nginx).

Unsurprisingly, its use _within_ [Kubernetes configurations](https://kubernetes.io/) is just as popular, with [33k public projects](https://github.com/search?q=%22containers%3A%22+%22image%3A+nginx%22+filename%3A*.yaml&type=Code) on GitHub using [the nginx image](https://hub.docker.com/_/nginx) in configs, and [at least as many](https://github.com/search?q=filename%3ADockerfile+%28%22ENTRYPOINT+nginx%22+OR+%22CMD+nginx%22%29&type=Code) running it in their own [Docker](https://docs.docker.com/install/) images.

We run nginx in the docker images for our [15 static websites](https://github.com/search?p=1&q=topic%3Awebsite+org%3Acanonical-web-and-design+%22CMD+nginx%22&type=Code) running on our team’s [Charmed Kubernetes](https://ubuntu.com/kubernetes) cluster.


## Closing connections in usn.ubuntu.com

About 2 years ago [we noticed](https://github.com/canonical-web-and-design/deployment-configs/pull/62) a problem in downloads of [our database of Ubuntu Security Notices](https://usn.ubuntu.com/usn-db/database-all.pickle.bz2), with clients having their connections reset during the download.

This may have had a few causes, but one very likely culprit was Kubernetes restarting or replacing containers. This may happen during normal running of the service, as Kubernetes reschedules pods to respond to load, but will also happen every time we release a new version of the site.


## The trouble with SIGTERM and nginx

When we release a new version of a site to Kubernetes, we first build and push a new image to the registry, then we ask Kubernetes to gradually roll out new containers based off the new image.

Kubernetes will gradually switch over to the new containers, removing the old ones as it goes. It does this using the same mechanism as `[docker stop](https://docs.docker.com/engine/reference/commandline/stop/)` - it will send a SIGTERM [signal](https://en.wikipedia.org/wiki/Signal_(IPC)#POSIX_signals) to the container, allow 30 seconds for it to stop gracefully, then send SIGKILL. It expects SIGTERM to result in a graceful shutdown:

> “It’s important that your application handle termination gracefully so that there is minimal impact on the end user and the time-to-recovery is as fast as possible!
>
> In practice, this means your application needs to handle the SIGTERM message and begin shutting down when it receives it. This means saving all data that needs to be saved, closing down network connections, finishing any work that is left, and other similar tasks.”

*From [Kubernetes best practices: terminating with grace](https://cloud.google.com/blog/products/gcp/kubernetes-best-practices-terminating-with-grace) by Sandeep Dinesh*

Unfortunately, this isn’t what happens when nginx receives a TERM signal:

> “The master process supports the following signals:
> 
>     TERM, INT    fast shutdown
>     QUIT        graceful shutdown”

*From the “[Controlling nginx](http://nginx.org/en/docs/control.html)” documentation*

What that “fast shutdown” means is that any open connections will be immediately closed. So if Kubernetes sends SIGTERM to my running containers, anyone with an open connection to those containers will see their connection break.

We can illustrate this using [a Dockerfile](https://gist.github.com/nottrobin/60d949fd41c99b8c77fb23f614b126f8) which simply uses nginx to proxy to `[httpbin.org](https://httpbin.org/)/delay/10`. When we stop the container, we can see the container exit within less than a second, and the `curl` exit with “Empty reply from server”:

    $ docker build -t delay-image .
    ...
    Successfully tagged delay-image:latest
 
    $ docker run --rm --name delay-ctnr --detach --publish 80:80 delay-image
    E5F6789...

    $ curl -I localhost 2>&1 | egrep 'curl:|HTTP' &
    [1] 14531

    $ /usr/bin/time --format '%E' docker stop delay-ctnr
    curl: (52) Empty reply from server
    delay-ctnr
    0:00.56

## SIGQUIT to the rescue

What we need instead is to send a SIGQUIT signal to ask nginx to perform a graceful shutdown, where it will wait for open connections to close before quitting.

If we  [add “STOPSIGNAL SIGQUIT” to the Dockerfile](https://gist.github.com/nottrobin/79087f07efab61f013c6e7e519a96ad8) then we can instead see curl exit gracefully with a [successful 200 response](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#2xx_Success), and `docker stop` wait (in this case, for 8.51 seconds) until it’s done so:

    $ docker build -t delay-image .
    ...
    Successfully tagged delay-image:latest

    $ docker run --rm --name delay-ctnr --detach --publish 80:80 delay-image
    A1B2C3D4...

    $ curl -I localhost 2>&1 | egrep 'curl:|HTTP' &
    [1] 14533

    $ /usr/bin/time --format '%E' docker stop delay-ctnr
    HTTP/1.1 200 OK
    delay-ctnr
    0:08.51

Bear in mind that `docker kill` will only wait 10 seconds, and Kubernetes will only wait 30, before killing the container with `SIGKILL`. So if you might need longer than that to close connections then you may need to increase the grace period.

An exception to this rule is if you are relying on unix sockets in your nginx config. In this case, SIGQUIT will [fail to close the sockets](https://trac.nginx.org/nginx/ticket/753) properly, resulting in [containers potentially not restarting correctly](https://github.com/nginxinc/docker-nginx/issues/167). So if you’re using sockets, be careful with SIGQUIT.


## Why isn’t this default?

I can’t find any reference to why nginx made the decision not to treat SIGTERM more gracefully, as a graceful termination seems to be the norm with SIGTERM.

> The SIGTERM signal is sent to a process to request its **termination**. [...] This allows the process to perform nice termination releasing resources and saving state if appropriate.

*From [Wikipedia: Signal (IPC)](https://en.wikipedia.org/w/index.php?title=Signal_(IPC)&oldid=924696609)*

~What is a shame is that the Dockerfile for the default nginx Docker image [explicitly uses](https://github.com/nginxinc/docker-nginx/blob/fe97d699daae7e04f916771ac520f7cf25ab2b27/mainline/buster/Dockerfile#L101) `STOPSIGNAL SIGTERM`, meaning that anyone using the default image (and anyone copying it) will get this connection closing issue.~

~They have made the decision to use SIGTERM rather than SIGQUIT [because of the issue with sockets](https://github.com/nginxinc/docker-nginx/issues/167). But if you’re not using sockets, you should definitely use SIGQUIT instead.~

*Edit: Since November 2020, the official docker image now uses SIGQUIT, so termination should now be graceful in Docker and Kubernetes.*

*(This was [originally published on the Ubuntu blog](https://ubuntu.com/blog/avoiding-dropped-connections-in-nginx-containers-with-stopsignal-sigquit))*