#!/bin/sh

#change this as needed. This is Hong Kong 02
dc=hkg02
globals_fn="globals"
globals_fn_classic="globals.classic"
master_fn="master.txt"

# provisions the master node
if [ $# -ne 3 ] ; then
echo " Usage: provision_master.sh hostname domain keyname"
exit 1
fi

hname=$1
dmn=$2
kname=$3

currentTime=$(date)
before=$(date +%s)

echo `date` .. starting to provision VM ${hname}.${dmn} in $dc
id=`sl cci create --datacenter=$dc --hostname=$hname --domain=$dmn --cpu=1 --memory=1024 --os=UBUNTU_12_64 --key $kname --hourly --really --wait=86400  --format=raw |grep "^id" |awk '{print $2}'`


echo `date` .. done provisioning VM ${hname}.${dmn} id $id in $dc
after=$(date +%s)
delta="$(expr $after - $before)"
echo `date` ... provisioning done in $delta in $dc
ip=`sl cci detail $id --format=raw |grep "^public_ip" |awk '{print $2}'`

# overwrite the globals file
cp -p $globals_fn $globals_fn_classic
sed -i "s/10.104.15.22/$ip/" $globals_fn

# save the master ip
echo $ip > $master_fn
