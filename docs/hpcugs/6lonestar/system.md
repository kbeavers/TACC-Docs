## [System Architecture](#system) { #system }

All Lonestar6 nodes run Rocky 8.4 and are managed with batch services through native Slurm 20.11.8. Global storage areas are supported by an NFS file system (`$HOME`), a BeeGFS parallel file system (`$SCRATCH`), and a Lustre parallel file system (`$WORK`). Inter-node communication is supported by a Mellanox HDF Infiniband network. Also, the TACC Ranch tape archival system is available from Lonestar6.

The system is composed of 560 compute nodes and 32 GPU nodes.  The compute nodes are housed in 4 dielectric liquid coolant cabinets and ten air-cooled racks.  The air cooled racks also contain the 32 GPU nodes.  Each node has two AMD EPYC 7763 64-core processors (Milan) and 256 GB of DDR4 memory. Twenty-four of the compute nodes are reserved for development and are accessible interactively for up to two hours. Each GPU node also contains two AMD EPYC 7763 64-core processes and three NVIDIA A100 GPUs each with 40 GB of high bandwidth memory (HBM2).


### [Compute Nodes](#system-compute) { #system-compute }

Lonestar6 hosts 560 compute nodes with 5 TFlops of peak performance per node and 256 GB of DRAM.

#### [Table 1. Compute Node Specifications](#table1) { #table1 }

Specification | Value
--- | ---
CPU: &nbsp; | 2x AMD EPYC 7763 64-Core Processor ("Milan")
Total cores per node: &nbsp; | 128 cores on two sockets (64 cores / socket )
Hardware threads per core: &nbsp; | 1 per core 
Hardware threads per node: &nbsp; | 128 x 1 = 128
Clock rate: &nbsp; | 2.45 GHz (Boost up to 3.5 GHz)
RAM: &nbsp; | 256 GB (3200 MT/s) DDR4
Cache: &nbsp; | 32KB L1 data cache per core<br>512KB L2 per core<br>32 MB L3 per core complex<br>(1 core complex contains 8 cores)<br>256 MB L3 total (8 core complexes )<br>Each socket can cache up to 288 MB<br>(sum of L2 and L3 capacity)
Local storage:&nbsp; | 144GB /tmp partition on a 288GB SSD.

### [Login Nodes](#system-login) { #system-login }

Lonestar6's three login nodes, `login1`, `login2`, and `login3`, contain the same hardware and are configured similarly to the compute nodes. However, since these nodes are shared, limits are enforced on memory usage and number of processes. Please use the login nodes only for file management, compilation, and data movement. Any and all computing should be done within a batch job or an [interactive session](http://portal.tacc.utexas.edu/software/idev) on the compute nodes.

### [`vm-small` Queue Nodes](#system-vmsmall) { #system-vmsmall }

Lonestar6 hosts 28 `vm-small` compute nodes running on 4 physical hosts.

#### [Table 1.5. "`vm-small` Compute Node Specifications](#table15) { #table15 }

Specification | Value
--- | ---
CPU: &nbsp; | <b>1/4th</b> of an AMD EPYC 7763 64-Core Processor ("Milan")
Total cores per VM: &nbsp; | 16 cores
Hardware threads per core: &nbsp; | 1 per core 
Hardware threads per VM: &nbsp; | 16 x 1 = 16
Clock rate: &nbsp; | 2.45 GHz (Boost up to 3.5 GHz)
RAM: &nbsp; | 32 GB (3200 <b>shared</b> MT/s) DDR4
Cache: &nbsp; | <b>Shared caches with all other VMs.</b><br>32KB L1 data cache per core<br>512KB L2 per core<br>32 MB L3 per core complex<br>(1 core complex contains 8 cores)<br>64 MB L3 total (2 core complexes)
Local storage:&nbsp; | 112G <code>/tmp</code> partition


### [GPU Nodes](#system-gpu) { #system-gpu }

Lonestar6 hosts **32** GPU nodes that are configured identically to the compute nodes with the addition of 3 NVIDIA A100 GPUs.  Each A100 gpu has a peak performance of 9.7 TFlops in double precision and 312 TFlops in FP16 precision using the Tensor Cores.

#### [Table 2. GPU Node Specifications](#table2) { #table2 }


Specification | Value
--- | ---
GPU:&nbsp; | 3x NVIDIA A100 PCIE 40GB<br>(1 per socket )<br>gpu0:   socket 0<br>gpu1:   socket1<br>gpu2:   socket1
GPU Memory:&nbsp; | 40 GB HBM2
CPU: &nbsp; | 2x AMD EPYC 7763 64-Core Processor ("Milan")
Total cores per node: &nbsp; | 128 cores on two sockets (64 cores / socket )
Hardware threads per core: &nbsp; | 1 per core 
Hardware threads per node: &nbsp; | 128 x 1 = 128
Clock rate: &nbsp; | 2.45 GHz
RAM: &nbsp; | 256 GB
Cache: &nbsp; | 32KB L1 data cache per core<br>512KB L2 per core<br>32 MB L3 per core complex<br>(1 core complex contains 8 cores)<br>256 MB L3 total (8 core complexes )<br>Each socket can cache up to 288 MB<br>(sum of L2 and L3 capacity)
Local storage: &nbsp; | 144GB /tmp partition on a 288GB SSD.

### [Network](#system-network) { #system-network }

The interconnect is based on Mellanox HDR technology with full HDR (200 Gb/s) connectivity between the switches and the compute nodes. A fat tree topology employing sixteen core switches connects the compute nodes and the `$SCRATCH` file systems. There is an oversubscription of 24/16.


