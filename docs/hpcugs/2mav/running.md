## Running Jobs on the Maverick2 Compute Nodes

o blurb
ead "../../include/maverick2-jobaccounting.html"

### Slurm Job Scheduler

Maverick2 employs the [Slurm Workload Manager](http://schedmd.com) job scheduler.  Slurm commands enable you to submit, manage, monitor, and control your jobs.  

The [Stampede2 User Guide](/user-guides/stampede2) discusses Slurm extensively.  See the following sections for detailed information:

* [Submitting Jobs with `sbatch`](/user-guides/stampede2#running-sbatch)
* [Common `sbatch` options](/user-guides/stampede2#table6)
* [Launching Applications](/user-guides/stampede2#launching-applications)

### Slurm Partitions (Queues)

**Queues and limits are subject to change without notice.** 

Execute "`qlimits`" on MACHINENAME for real-time information regarding limits on available queues.

See Stampede2's [Monitoring Jobs and Queues](/user-guides/stampede2#monitoring) section for additional information.

[Table 6. Maverick2 Production Queues](#table6)

%table(border="1" cellpadding="3")
	%tr(align="center")
		%th(align="center") Queue Name<br>(available nodes)
		%th(align="center") Max Nodes per Job<br /> (assoc'd cores) 
		%th(align="center") Max Duration 
		%th(align="center") Max Jobs in Queue 
		%th(align="center") Charge Rate<br /> (per node-hour) 

	%tr(align="center")
		%td <code>gtx</code><br>(24 nodes)
		%td 4 nodes<br /> (64 cores)
		%td 24 hours
		%td 4
		%td 1 SU
	
	%tr(align="center")
		%td <code>v100</code><br>(4 nodes)
		%td 4 nodes<br>(192 cores)
		%td 24 hours
		%td 4
		%td 1 SU

	%tr(align="center")
		%td <code>p100</code><br>(3 nodes)
		%td 3 nodes<br /> (144 cores)
		%td 24 hours
		%td 4
		%td 1 SU


<!-- ## [Sample Maverick2 Job Scripts](#running-sbatch-jobscripts) STYLEREDComing Soon.ESPAN -->

