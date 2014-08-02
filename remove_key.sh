#!/bin/sh


if [ $# -ne 1 ] ; then
echo " Usage: remove_key.sh unique_keyname"
exit 1
fi

kname=$1

echo `date` remove_key starting with keyname $kname

rm $kname $kname.pub

sl sshkey remove $kname --really

if [ $? -eq 0 ]; then
 echo `date` remove_key ... removed key $kname in SL and on disk
else
 echo `date` 'remove_key failed :('
fi
