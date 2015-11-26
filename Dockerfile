FROM andyshinn/alpine-abuild
ENV PACKAGER_PRIVKEY  /package/packagist.rsa
ENV PACKAGER Made.com <packagist@made.com>
VOLUME /packages
