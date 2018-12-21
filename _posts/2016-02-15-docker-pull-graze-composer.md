---
title: "docker pull graze/composer"
date: 2016-02-15T12:02:11.000Z
author: Sam Parkinson
---

We've just released a public Docker image for [composer](https://getcomposer.org), a popular dependency management tool for PHP.

Get it now with `docker pull graze/composer`, or check it out on the [Docker Hub](https://hub.docker.com/r/graze/composer/).

To share cache and authentication with your host you can use the following configuration:

```prettyprint lang-bash
~$ docker run --rm -it \
     -v $(pwd):/usr/src/app \
     -v ~/.composer:/root/.composer \
     -v ~/.ssh/id_rsa:/root/.ssh/id_rsa:ro \
     -v ~/.ssh/known_hosts:/root/.ssh/known_hosts:ro \
     graze/composer
```

Previously we've been using the semi-official image [composer/composer](https://hub.docker.com/r/composer/composer/), but have found it to be too large and infrequently updated, important when security issues like the latest [cache injection vulnerability](http://flyingmana.de/blog_en/2016/02/14/composer_cache_injection_vulnerability_cve_2015_8371.html) are found.

The image comes in at just over 88 MB, based off Alpine 3.3, and is built daily using a [hook.io](https://hook.io/) "microservice".