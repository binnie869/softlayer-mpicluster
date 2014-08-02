#!/bin/bash

# source globals

globals_fn="globals"
mpihosts_fn="mpi_hosts"

source $globals_fn


if [ $# -ne 2 ] ; then
echo " Usage: setup_node.sh ipaddr keyname"
exit 1
fi

ipaddr=$1
kname=$2


ssh -o StrictHostKeyChecking=no -i $kname $ipaddr "apt-get update && apt-get install -y build-essential openssh-server openssh-client openmpi-bin openmpi-doc libopenmpi-dev nfs-common nfs-kernel-server"
scp -o StrictHostKeyChecking=no -i $kname $globals_fn $ipaddr:$globals_fn
scp -o StrictHostKeyChecking=no -i $kname $mpihosts_fn $ipaddr:$mpihosts_fn


# ssh -o StrictHostKeyChecking=no -i $kname $ipaddr "git clone https://github.com/irifed/softlayer-mpicluster.git"
# configure cluster software
ssh -o StrictHostKeyChecking=no -i $kname $ipaddr "echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config"
ssh -o StrictHostKeyChecking=no -i $kname $ipaddr "adduser --disabled-password --gecos \"\" $USER"

ssh -o StrictHostKeyChecking=no -i $kname $ipaddr "mkdir -m 700 ~${USER}/.ssh"
scp -o StrictHostKeyChecking=no -i $kname $kname $ipaddr:/home/${USER}/.ssh/id_rsa
scp -o StrictHostKeyChecking=no -i $kname $kname.pub $ipaddr:/home/${USER}/.ssh/id_rsa.pub
ssh -o StrictHostKeyChecking=no -i $kname $ipaddr "cat /home/${USER}/.ssh/id_rsa.pub >> /home/${USER}/.ssh/authorized_keys"
ssh -o StrictHostKeyChecking=no -i $kname $ipaddr "chmod 0600 /home/${USER}/.ssh/authorized_keys"
ssh -o StrictHostKeyChecking=no -i $kname $ipaddr "chmod 0600 /home/${USER}/.ssh/id_rsa.pub"

ssh -o StrictHostKeyChecking=no -i $kname $ipaddr "chown -R $USER.$USER /home/${USER}/.ssh"

scp -o StrictHostKeyChecking=no -i $kname $globals_fn ${USER}@${ipaddr}:$globals_fn
scp -o StrictHostKeyChecking=no -i $kname $mpihosts_fn ${USER}@${ipaddr}:$mpihosts_fn


echo `date` ... all done


