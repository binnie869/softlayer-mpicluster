#!/bin/bash

# configure node as NFS master
# requires `mpi_hosts` file with list of hosts to share NFS

source globals

# export /home to NFS 
if [ ! -d /export/$USER ]; then
    mkdir -p /export/$USER
fi
chmod 0777 /export
chmod 0777 /export/$USER
mount --bind /home/$USER /export/$USER

cat >> /etc/fstab << EOF
/home/$USER     /export/$USER   none bind 0 0
EOF

# allow access to exported NFS share to hosts from `mpi_hosts` list
for host in `cat mpi_hosts`; do
cat >> /etc/exports << EOF
/home/$USER $host(rw,sync,no_root_squash,no_subtree_check)
EOF
done

exportfs -a

service nfs-kernel-server restart