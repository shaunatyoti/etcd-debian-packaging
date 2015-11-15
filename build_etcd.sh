#!/bin/bash

# systemd version
fpm -s dir -n "etcd" \
-p etcd/builds \
-C ./etcd -v 2.2.1-1 \
-t deb \
-a amd64 \
-d "dpkg (>= 1.17)" \
--after-install etcd/scripts/deb/systemd/after-install.sh \
--before-install etcd/scripts/deb/systemd/before-install.sh \
--after-remove etcd/scripts/deb/systemd/after-remove.sh \
--before-remove etcd/scripts/deb/systemd/before-remove.sh \
--config-files etc/etcd \
--license "Apache Software License 2.0" \
--maintainer "yoti <noc@yoti.com>" \
--vendor "yoti ltd" \
--description "Etcd binaries and services" \
source/etcd/etcd=/usr/bin/etcd \
source/etcd/etcdctl=/usr/bin/etcdctl \
services/systemd/etcd.service=/lib/systemd/system/etcd.service \
config/systemd/etcd.conf=/etc/etcd/etcd.conf
