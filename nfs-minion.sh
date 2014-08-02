#!/bin/bash

# configure node as NFS minion (mount NFS share from NFS master)
#
# set -x; for host in `sl vs list | grep mpinode | awk '{print $6}'`; do scp -i ~/.ssh/sftlyr -o StrictHostKeyChecking=no minion.sh root@$host:minion.sh ; done

source globals

mount $MASTER_IP:/home/$USER /home/$USER

cat >> /etc/fstab << EOF
$MASTER_IP:/home/$USER    /home/$USER   nfs auto,noatime,nolock,bg,nfsvers=4,intr,tcp,actimeo=1800 0 0
EOF