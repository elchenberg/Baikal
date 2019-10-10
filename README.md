Baïkal
======

[![Build Status](https://travis-ci.org/sabre-io/Baikal.svg?branch=master)](https://travis-ci.org/sabre-io/Baikal)

This is the source repository for the Baïkal CalDAV and CardDAV server.

Head to [sabre.io/baikal][2] for information about installation, upgrading and troubleshooting.

Upgrading
---------

Please follow [the upgrade instructions][5].

Docker
------

Build and run a standalone Baikal container:

```sh
docker build --tag baikal .
docker run --publish 80:80 --sysctl net.ipv4.ip_unprivileged_port_start=0 baikal
```

Alternatively, build and run the container with a little extra security:

```sh
docker build --build-arg PORT=8080 --tag baikal .
docker run --cap-drop ALL --publish 80:8080 --read-only --security-opt no-new-privileges baikal
```

Go to <http://localhost> to see the result.

The container image is based on the [official `php:7.3-apache-buster` docker image][6] and has SQlite installed. (No MySQL!)

Credits
-------

Bäikal is developed by [Jérôme Schneider][3] from [Net Gusto][3] and [fruux][4].
Many thanks to Daniel Aleksandersen (@zcode) for greatly improving the quality of the project page.

[2]: http://sabre.io/baikal/
[3]: http://netgusto.com/
[4]: https://fruux.com/
[5]: http://sabre.io/baikal/upgrade/
[6]: https://hub.docker.com/_/php