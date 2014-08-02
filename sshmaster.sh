#!/bin/bash

source globals

# if [ $# -ne 1 ] ; then
# echo " Usage: sshmaster.sh keyname"
# exit 1
# fi

# kname=$1

ssh -o StrictHostKeyChecking=no -i $KEYNAME -l $USER $MASTER_IP