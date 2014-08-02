#!/bin/sh

slaves_fn="slaves.txt"
mpihosts_fn="mpi_hosts"


if [ $# -ne 2 ] ; then
echo " Usage: deprovision_slaves.sh base_hostname domain"
exit 1
fi


hname=$1
dmn=$2

echo `date` 'deprovision_slaves starting'


for i in `sl cci list --format=raw |grep ${hname} |grep ${dmn} | cut -d " " -f1`
do
  echo `date` "deprovision_slaves canceling node $i"
  sl cci cancel $i --really
done

rm $slaves_fn $mpihosts_fn

echo `date` 'deprovision_slaves done'