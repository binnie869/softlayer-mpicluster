#!/bin/bash

if [ $# -ne 4 ] ; then
 echo " Usage: unmake_cluster.sh master_hostname base_slave_hostname domain keyname"
 exit 1
fi

mhname=$1
slbhname=$2
dmn=$3
kname=$4

echo `date` unmake_cluster starting... 

echo `date` unmake_cluster removing key...  
./remove_key.sh $kname

echo `date` unmake_cluster deprovisioning master...
./deprovision_master.sh $mhname $dmn

echo `date` unmake_cluster deprovisioning slaves...
./deprovision_slaves.sh $slbhname $dmn

echo `date` unmake_cluster all done! 
