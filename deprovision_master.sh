#!/bin/sh

globals_fn="globals"
globals_fn_classic="globals.classic"
master_fn="master.txt"


if [ $# -ne 2 ] ; then
echo " Usage: deprovision_master.sh base_hostname domain"
exit 1
fi


hname=$1
dmn=$2

echo `date` 'deprovision_master starting'


for i in `sl cci list --format=raw |grep "${hname}.${dmn}" | cut -d " " -f1`
do
  echo `date` "deprovision_master canceling node $i"
  sl cci cancel $i --really
done

rm $master_fn 
mv $globals_fn_classic $globals_fn

echo `date` 'deprovision_slaves done'