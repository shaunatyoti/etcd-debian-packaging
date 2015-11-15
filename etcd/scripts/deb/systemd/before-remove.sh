        # Package removal, not upgrade
        systemctl --no-reload disable etcd.service > /dev/null 2>&1 || :
        systemctl stop etcd.service > /dev/null 2>&1 || :
