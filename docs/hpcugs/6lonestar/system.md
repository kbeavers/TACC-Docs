#system
	:markdown
		# [System Architecture](#system)

		All Lonestar6 nodes run Rocky 8.4 and are managed with batch services through native Slurm 20.11.8. Global storage areas are supported by an NFS file system (`$HOME`), a BeeGFS parallel file system (`$SCRATCH`), and a Lustre parallel file system (`$WORK`). Inter-node communication is supported by a Mellanox HDF Infiniband network. Also, the TACC Ranch tape archival system is available from Lonestar6.

		The system is composed of 560 compute nodes and 32 GPU nodes.  The compute nodes are housed in 4 dielectric liquid coolant cabinets and ten air-cooled racks.  The air cooled racks also contain the 32 GPU nodes.  Each node has two AMD EPYC 7763 64-core processors (Milan) and 256 GB of DDR4 memory. Twenty-four of the compute nodes are reserved for development and are accessible interactively for up to two hours. Each GPU node also contains two AMD EPYC 7763 64-core processes and three NVIDIA A100 GPUs each with 40 GB of high bandwidth memory (HBM2).


#system-compute
	:markdown
		## [Compute Nodes](#system-compute)

		Lonestar6 hosts 560 compute nodes with 5 TFlops of peak performance per node and 256 GB of DRAM.

#table1
	:markdown
		[Table 1. Compute Node Specifications](#table1)

%table(border="1" cellpadding="3" cellspacing="5")
	%tr
		%td(nowrap align="right") CPU: &nbsp;
		%td 2x AMD EPYC 7763 64-Core Processor ("Milan")
	%tr
		%td(nowrap align="right") Total cores per node: &nbsp;
		%td 128 cores on two sockets (64 cores / socket )
	%tr
		%td(nowrap align="right") Hardware threads per core: &nbsp;
		%td 1 per core 
	%tr
		%td(nowrap align="right") Hardware threads per node: &nbsp;
		%td 128 x 1 = 128
	%tr
		%td(nowrap align="right") Clock rate: &nbsp;
		%td 2.45 GHz (Boost up to 3.5 GHz)
	%tr
		%td(nowrap align="right") RAM: &nbsp;
		%td 256 GB (3200 MT/s) DDR4
	%tr
		%td(nowrap align="right") Cache: &nbsp;
		%td 32KB L1 data cache per core<br>512KB L2 per core<br>32 MB L3 per core complex<br>(1 core complex contains 8 cores)<br>256 MB L3 total (8 core complexes )<br>Each socket can cache up to 288 MB<br>(sum of L2 and L3 capacity)
	%tr
		%td(nowrap align="right") Local storage:&nbsp; 
		%td 144GB /tmp partition on a 288GB SSD.

#system-login
	:markdown
		## [Login Nodes](#system-login)

		Lonestar6's three login nodes, `login1`, `login2`, and `login3`, contain the same hardware and are configured similarly to the compute nodes. However, since these nodes are shared, limits are enforced on memory usage and number of processes. Please use the login nodes only for file management, compilation, and data movement. Any and all computing should be done within a batch job or an [interactive session](http://portal.tacc.utexas.edu/software/idev) on the compute nodes.

#system-vmsmall
	:markdown
		## [`vm-small` Queue Nodes](#system-vmsmall)

		Lonestar6 hosts 28 `vm-small` compute nodes running on 4 physical hosts.
		
#table15
	:markdown
		[Table 1.5. "`vm-small` Compute Node Specifications](#table15)

%table(border="1" cellpadding="3" cellspacing="5")
	%tr
		%td(nowrap align="right") CPU: &nbsp;
		%td <b>1/4th</b> of an AMD EPYC 7763 64-Core Processor ("Milan")
	%tr
		%td(nowrap align="right") Total cores per VM: &nbsp;
		%td 16 cores
	%tr
		%td(nowrap align="right") Hardware threads per core: &nbsp;
		%td 1 per core 
	%tr
		%td(nowrap align="right") Hardware threads per VM: &nbsp;
		%td 16 x 1 = 16
	%tr
		%td(nowrap align="right") Clock rate: &nbsp;
		%td 2.45 GHz (Boost up to 3.5 GHz)
	%tr
		%td(nowrap align="right") RAM: &nbsp;
		%td 32 GB (3200 <b>shared</b> MT/s) DDR4
	%tr
		%td(nowrap align="right") Cache: &nbsp;
		%td <b>Shared caches with all other VMs.</b><br>32KB L1 data cache per core<br>512KB L2 per core<br>32 MB L3 per core complex<br>(1 core complex contains 8 cores)<br>64 MB L3 total (2 core complexes)
	%tr
		%td(nowrap align="right") Local storage:&nbsp; 
		%td 112G <code>/tmp</code> partition



#system-gpu
	:markdown
		## [GPU Nodes](#system-gpu)

		Lonestar6 hosts **32** GPU nodes that are configured identically to the compute nodes with the addition of 3 NVIDIA A100 GPUs.  Each A100 gpu has a peak performance of 9.7 TFlops in double precision and 312 TFlops in FP16 precision using the Tensor Cores.

#table2
	:markdown
		[Table 2. GPU Node Specifications](#table2)

%table(border="1" cellpadding="3" cellspacing="5")
	%tr
		%td(nowrap align="right") GPU:&nbsp;
		%td 3x NVIDIA A100 PCIE 40GB<br>(1 per socket )<br>gpu0:   socket 0<br>gpu1:   socket1<br>gpu2:   socket1
	%tr
		%td(nowrap align="right") GPU Memory:&nbsp;
		%td 40 GB HBM2
	%tr
		%td(nowrap align="right") CPU: &nbsp;
		%td 2x AMD EPYC 7763 64-Core Processor ("Milan")
	%tr
		%td(nowrap align="right") Total cores per node: &nbsp;
		%td 128 cores on two sockets (64 cores / socket )
	%tr
		%td(nowrap align="right") Hardware threads per core: &nbsp;
		%td 1 per core 
	%tr
		%td(nowrap align="right") Hardware threads per node: &nbsp;
		%td 128 x 1 = 128
	%tr
		%td(nowrap align="right") Clock rate: &nbsp;
		%td 2.45 GHz
	%tr
		%td(nowrap align="right") RAM: &nbsp;
		%td 256 GB
	%tr
		%td(nowrap align="right") Cache: &nbsp;
		%td 32KB L1 data cache per core<br>512KB L2 per core<br>32 MB L3 per core complex<br>(1 core complex contains 8 cores)<br>256 MB L3 total (8 core complexes )<br>Each socket can cache up to 288 MB<br>(sum of L2 and L3 capacity)
	%tr
		%td(nowrap align="right") Local storage: &nbsp; 
		%td 144GB /tmp partition on a 288GB SSD.

#system-network
	:markdown
		## [Network](#system-network)

		The interconnect is based on Mellanox HDR technology with full HDR (200 Gb/s) connectivity between the switches and the compute nodes. A fat tree topology employing sixteen core switches connects the compute nodes and the `$SCRATCH` file systems. There is an oversubscription of 24/16.


