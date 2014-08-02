#!/bin/sh

slaves_fn="slaves.txt"
master_fn="master.txt"

# git_dir="softlayer-mpicluster"
gitdir="."

if [ $# -ne 1 ] ; then
echo " Usage: setup_nodes.sh keyname"
exit 1
fi

kname=$1

# sets up sw on all nodes

for i in `cat master.txt` `cat slaves.txt`
do
# if [ ! -z $i ]; then
  echo `date` .. starting to setup node $i
  ./setup_node.sh $i $kname &
# fi

done

echo `date` kicked off setup... now waiting...
wait

echo `date` Now starting nfs on master and slaves.. 

for i in `cat master.txt`
do
 scp -o StrictHostKeyChecking=no -i $kname nfs-master.sh $i:$gitdir
 ssh -o StrictHostKeyChecking=no -i $kname $i "cd $gitdir && ./nfs-master.sh"
done

for i in `cat slaves.txt`
do
 scp -o StrictHostKeyChecking=no -i $kname nfs-minion.sh $i:$gitdir
 ssh -o StrictHostKeyChecking=no -i $kname $i "cd $gitdir && ./nfs-minion.sh"
done


echo `date` ... all done


