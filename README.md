softlayer-mpicluster
====================

This is a set of scripts to create simplest MPI cluster on SoftLayer.
I intentionally did not use any software orchestration tools (Chef, Puppet, etc) to demonstrate 
what is minimally required for making a cluster.

At this point, this is a fully working, albeit somewhat hacked together, set of scripts.

Ensure you have the SoftLayer API installed on your machine, then issue the git pull.

To create a new cluster, run
```
./make_cluster.sh mpimaster mpislave dima.com 4 mpiclusterkey
```

where mpimaster is the hostname for the master node
mpislave is the base hostname for the slave nodes (actual hostnames will be mpislave1, mipslave2...)
4 is the number of the slave nodes
mpiclusterkey is the unique name that the script should use for this cluster. Note that it'll create the key with this name on the local disk and also insert it into SL, so that the new machines will be provisioned with it.

The structure of the code is not complicated.  It first creates the key, then uses this key to kick off provisioning for the master and slave nodes.  Once all nodes are provisions, it starts installing software running setup_nodes.sh script. the setup_node.sh script contains common elements that needs to be done on all nodes.  setup_nodes.sh, towards the end, adds some operations that are specific to master or slave nodes.

To connect to the master node of your new cluster, run
```
./sshmaster.sh
```
The file mpi_hosts contains the list of slave nodes.  In the current configuration, the master node is not added to this file.  To run something now, you can do for instance

```
mpirun -hostfile mpi_hosts -n 4 /bin/hostname
```

To remove the cluster, similarly, you run

```
./unmake_cluster.sh mpimaster mpislave dima.com mpiclusterkey
```
