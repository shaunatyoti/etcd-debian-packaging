#!/bin/bash

ETCD_VERSION=${ETCD_VERSION:-2.3.7}
REV=${REV:-1}

rm -f etcd/builds/etcd_$ETCD_VERSION_amd64.deb
rm -rf etcd/source/etcd-v$ETCD_VERSION

mkdir -p etcd/builds
mkdir -p etcd/source
mkdir -p etcd/downloads

cd etcd/downloads

if [ -f etcd-v$ETCD_VERSION-linux-amd64.tar.gz ]; then
  echo "already have the download ..."
else
  wget https://github.com/coreos/etcd/releases/download/v$ETCD_VERSION/etcd-v$ETCD_VERSION-linux-amd64.tar.gz
fi

cd ../source
tar zxf ../downloads/etcd-v$ETCD_VERSION-linux-amd64.tar.gz
cd ../..

# systemd version
fpm -s dir -n "etcd" \
-p etcd/builds \
-C etcd \
-v $ETCD_VERSION-$REV \
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
source/etcd-v$ETCD_VERSION-linux-amd64/etcd=/usr/bin/etcd \
source/etcd-v$ETCD_VERSION-linux-amd64/etcdctl=/usr/bin/etcdctl \
services/systemd/etcd.service=/lib/systemd/system/etcd.service \
config/systemd/etcd.conf=/etc/etcd/etcd.conf
