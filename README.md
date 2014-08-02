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

To connect to your new cluster, run
```
./sshmaster.sh
```

To remove the cluster, similarly, you run

```
./unmake_cluster.sh mpimaster mpislave dima.com mpiclusterkey
```
