#overview
	:markdown
		# [System Overview](#overview)

		Maverick2 hosts the following GPUs: 24 nodes each with 4 NVidia GTX 1080 Ti GPUs running in a Broadwell based compute node; four nodes each with two of NVidia V100s GPUs running in a Skylake based Dell R740 based node; and three nodes each with two NVidia P100s GPUs running in a Skylake based Dell R740 node.

#overview-computenodes
	:markdown
		## [GTX Compute Nodes](#overview-computenodes)

		Maverick2 hosts 24 GTX compute nodes. One GTX node is reserved for staff use, leaving 23 nodes available for general use.

#table1
	:markdown
		[Table 1. Maverick2 GTX Compute Node Specifications](#table1)

	%table(border="1" cellpadding="3")
		%tr 
			%td(align="right") Model:
			%td Super Micro X10DRG-Q Motherboard
		%tr 
			%td(align="right") Processor:
			%td Intel(R) Xeon(R) CPU E5-2620 v4
		%tr 
			%td(align="right") Total processors per node:
			%td 2
		%tr 
			%td(align="right") Total cores per processor:
			%td 8
		%tr 
			%td(align="right") Total cores per node:
			%td 16
		%tr 
			%td(align="right") Hardware threads per core:
			%td 2
		%tr 
			%td(align="right") Hardware threads per node:
			%td 32
		%tr 
			%td(align="right") Clock rate:
			%td 2.10GHz
		%tr 
			%td(align="right") RAM:
			%td 128 GB
		%tr 
			%td(align="right") L1/L2/L3 Cache:
			%td 512KiB / 2MiB / 20 MiB
		%tr 
			%td(align="right") Local storage:
			%td 150.0 GB (~60 GB free)
		%tr 
			%td(align="right") GPUs:
			%td 4 x NVidia 1080-TI GPUs
 
#overview-computenodes
	:markdown
		## [V100 Compute Nodes](#overview-computenodes)

		Maverick2 has 4 V100 compute nodes.

#table2
	:markdown
		[Table 2. Maverick2 V100 Compute Node Specifications](#table2)

	%table(border="1" cellpadding="3")
		%tr 
			%td(align="right") Model:
			%td Dell PowerEdge R740
		%tr 
			%td(align="right") Processor:
			%td Xeon(R) Platinum 8160 CPU @ 2.10GHz
		%tr 
			%td(align="right") Total processors per node:
			%td 2
		%tr 
			%td(align="right") Total cores per processor:
			%td 24
		%tr 
			%td(align="right") Total cores per node:
			%td 48
		%tr 
			%td(align="right") Hardware threads per core:
			%td 2
		%tr 
			%td(align="right") Hardware threads per node:
			%td 96
		%tr 
			%td(align="right") Clock rate:
			%td 2.10GHz
		%tr 
			%td(align="right") RAM:
			%td 192 GB
		%tr 
			%td(align="right") L1/L2/L3 Cache:
			%td 1536KiB / 24576KiB / 33792KiB
		%tr 
			%td(align="right") Local storage:
			%td 119.5 GB (~32 GB free)
		%tr 
			%td(align="right") GPUs:
			%td 2 NVidia  V100 adapters
 
#overview-v100
	:markdown
		## [P100 Compute Nodes](#overview-v100)

		Maverick2 has 3 P100 nodes.

#table3
	:markdown
		[Table 3. Maverick2 P100 Compute Node Specifications](#table3)

	%table(border="1" cellpadding="3")
		%tr 
			%td(align="right") Model:
			%td Dell PowerEdge R740
		%tr 
			%td(align="right") Processor:
			%td Xeon(R) Platinum 8160 CPU @ 2.10GHz
		%tr 
			%td(align="right") Total processors per node:
			%td 2
		%tr 
			%td(align="right") Total cores per processor:
			%td 24
		%tr 
			%td(align="right") Total cores per node:
			%td 48
		%tr 
			%td(align="right") Hardware threads per core:
			%td 2
		%tr 
			%td(align="right") Hardware threads per node:
			%td 96
		%tr 
			%td(align="right") Clock rate:
			%td 2.10GHz
		%tr 
			%td(align="right") RAM:
			%td 192 GB
		%tr 
			%td(align="right") L1/L2/L3 Cache:
			%td 1536KiB / 24576KiB / 33792KiB
		%tr 
			%td(align="right") Local storage:
			%td 119.5 GB (~32 GB free)
		%tr 
			%td(align="right") GPUs:
			%td 2 NVidia P100 adapters
	
	#overview-loginnodes
		:markdown
			## [Login Nodes](#overview-loginnodes)

			Maverick2 hosts a single login node:

			* Dual Socket
			* Intel Xeon CPU E5-2660 v3 (Haswell) @ 2.60GHz: 10 cores/socket (20 cores/node)
			* 128 GB DDR4-2133 (8 x 16GB dual rank x4 DIMMS)
			* Hyperthreading Disabled

#overview-network
	:markdown
		## [Network](#overview-network)

		* Mellanox FDR Infiniband MT27500 Family ConnectX-3 Adapter
		* up to 10/40/56Gbps bandwidth and a sub-microsecond low latency
		* Fat Tree Interconnect
		* Intel Ethernet Controller I350 IEEE 802.3 1Gbps Adapter

#overview-filesystems
	:markdown
		## [File Systems](#overview-filesystems)

		Maverick2 mounts two shared Lustre file systems on which each user has corresponding account-specific directories [`$HOME` and `$WORK`](#files-filesystems). **Unlike most TACC resources, Maverick2 does not mount a `/scratch` file system.**  Both the `/home` and `/work` file systems are available from all Maverick2 nodes; the [Stockyard-hosted `/work` file system](https://www.tacc.utexas.edu/systems/stockyard) is available on other TACC systems as well. A Lustre file system looks and acts like a single logical hard disk, but is actually a sophisticated integrated system involving many physical drives (dozens of physical drives for `$HOME` and thousands for `$WORK`).

		<p class="portlet-msg-info">See <a href="#files">Managing Your Files</a> section below and consult the <a href="/user-guides/stampede2#using-citizenship-filesystems">Shared Lustre File Systems</a> section in the <a href="/user-guides/stampede2">Stampede2 User Guide</a> for best practices. </p>


#figure2
	:markdown
		<figure>
		<img alt="" src="/documents/10157/1181317/Maverick2+cooling+system/fbef2f24-4252-4d5f-857e-73c138ff6a0e?t=1592320888902" style="width: 800px; height: 524px; border-width: 1px; border-style: solid;" />
		<figcaption><font size=-2>Figure 2. Maverick2 Immersion Cooling System</font></figcaption>
		</figure>

