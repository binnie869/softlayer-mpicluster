#!/bin/sh

slaves_fn="slaves.txt"
mpihosts_fn="mpi_hosts"

# provisions the master node
if [ $# -ne 4 ] ; then
echo " Usage: provision_slaves.sh num base_hostname domain keyname"
exit 1
fi

num=$1
hname=$2
dmn=$3
kname=$4

currentTime=$(date)
before=$(date +%s)

echo `date` .. starting to provision $num slaves

for j in `seq 1 $num`; do
 ./provision_slave.sh  ${hname}${j} $dmn $kname &
done

echo `date` kicked off... now waiting...
wait

after=$(date +%s)
delta="$(expr $after - $before)"
echo `date` ... all slaves done in $delta

# the slaves wrote the slaves file.  Now, we need to update mpi_hosts
cp -p $slaves_fn $mpihosts_fn

