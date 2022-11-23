## [Running Jobs on Lonestar6](#running)

This section provides an overview of how compute jobs are charged to allocations and describes the **S**imple **L**inux **U**tility for **R**esource **M**anagement (Slurm) batch environment, Lonestar6 queue structure, lists basic Slurm job control and monitoring commands along with options.

/ Job Accounting
= File.read "../../include/lonestar6-jobaccounting.html"

### [Production Queues](#queues)

Lonestar6's new queue, "`vm-small`" is designed for users who only need a subset of a node's entire 128 cores in the "normal" queue.  Run your jobs in this queue if your job requires 16 cores or less and needs less than 29 GB of memory.  If your job is memory bandwidth dependent, your performance may decrease since your job will be possibly sharing memory bandwidth with other jobs.  

The jobs in this queue consume 1/7 the resources of a full node.  Jobs are charged accordingly at .143 SUs per node hour.

		[Table. Lonestar6 Production Queues](#tablex)

		**Queue limits are subject to change without notice.**

		%table(border="1" cellpadding="3")
			%tr(align="center")
				%th Queue Name
				%th Min/Max Nodes per Job<br /> (assoc'd cores)*
				%th Max Job Duration
				%th Max Nodes<br> per User
				%th Max Jobs<br> per User
				%th Charge Rate<br />NOWRAP(per node-hour)ESPAN
			%tr(align="center")
				%td <code>normal</code>
				%td 1/64 nodes<br>(8192 cores)
				%td 48 hours 
				%td 96 
				%td 15 
				%td 1 SU
			%tr(align="center")
				%td <code>large</code><sup>&#42;</sup>
				%td 65/256 nodes<br>(65536 cores)
				%td 48 hours 
				%td 256 
				%td 1 
				%td 1 SU
			%tr(align="center")
				%td <code>development</code>
				%td 4 nodes<br>(512 cores)
				%td 2 hours 
				%td 6 
				%td 1 
				%td 1 SU
			%tr(align="center")
				%td <code>gpu-a100</code>
				%td 4 nodes<br>(512 cores)
				%td 48 hours 
				%td 6 
				%td 2 
				%td 4 SUs
			%tr(align="center")
				%td <code>vm-small</code><sup>&#42;&#42;</sup>
				%td 1/1 node<br>(16 cores)
				%td 48 hours 
				%td 4
				%td 4
				%td 0.143 SU
		
:markdown

	&#42; Access to the `large` queue is restricted. To request more nodes than are available in the normal queue, submit a consulting (help desk) ticket through the TACC User Portal. Include in your request reasonable evidence of your readiness to run under the conditions you're requesting. In most cases this should include your own strong or weak scaling results from Lonestar6.

	&#42;&#42; The `vm-small` queue contains virtual nodes with fewer resources (cores) than the nodes in the other queues.


