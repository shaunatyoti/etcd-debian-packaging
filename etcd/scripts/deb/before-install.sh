getent group etcd >/dev/null || groupadd -r etcd
getent passwd etcd >/dev/null || useradd -r -g etcd -d /var/etcd \
  -s /sbin/nologin -c "etcd user" etcd

mkdir -p -m 755 /var/etcd/default.etcd
chown -R etcd /var/etcd
chgrp -R etcd /var/etcd