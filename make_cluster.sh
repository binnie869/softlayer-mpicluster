#!/bin/bash

globals_fn="globals"


if [ $# -ne 5 ] ; then
 echo " Usage: make_cluster.sh master_hostname base_slave_hostname domain num_slaves keyname"
 exit 1
fi

mhname=$1
slbhname=$2
dmn=$3
num=$4
kname=$5

echo `date` make_cluster starting... 

echo `date` make_cluster creating key...  
./create_key.sh $kname

echo `date` make_cluster provisioning master...
./provision_master.sh $mhname $dmn $kname &

echo `date` make_cluster provisioning slaves...
./provision_slaves.sh $num $slbhname $dmn $kname &

echo `date` make_cluster waiting for all to provision.. 
wait

echo `date` make_cluster setting up nodes... 
./setup_nodes.sh $kname

echo "KEYNAME=$kname" >> $globals_fn

echo `date` make_cluster all done! 
