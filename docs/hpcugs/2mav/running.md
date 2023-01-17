## [Running Jobs on the Maverick2 Compute Nodes](#running) { #running}

/taccinfo blurb
= File.read "../../include/maverick2-jobaccounting.html"

### [Slurm Job Scheduler](#running-slurm) { #running-slurm }

Maverick2 employs the [Slurm Workload Manager](http://schedmd.com) job scheduler.  Slurm commands enable you to submit, manage, monitor, and control your jobs.  

The [Stampede2 User Guide](/user-guides/stampede2) discusses Slurm extensively.  See the following sections for detailed information:

* [Submitting Jobs with `sbatch`](/user-guides/stampede2#running-sbatch)
* [Common `sbatch` options](/user-guides/stampede2#table6)
* [Launching Applications](/user-guides/stampede2#launching-applications)

### [Slurm Partitions (Queues)](#running-queues) { #running-queues }

**Queues and limits are subject to change without notice.** 

Execute "`qlimits`" on MACHINENAME for real-time information regarding limits on available queues.

See Stampede2's [Monitoring Jobs and Queues](/user-guides/stampede2#monitoring) section for additional information.

[Table 6. Maverick2 Production Queues](#table6) { #table6 }

Queue Name<br>(available nodes) | Max Nodes per Job<br /> (assoc'd cores)  | Max Duration  | Max Jobs in Queue  | Charge Rate<br /> (per node-hour) 
--- | --- | --- | --- | ---
<code>gtx</code><br>(24 nodes) | 4 nodes<br /> (64 cores) | 24 hours | 4 | 1 SU
<code>v100</code><br>(4 nodes) | 4 nodes<br>(192 cores) | 24 hours | 4 | 1 SU
<code>p100</code><br>(3 nodes) | 3 nodes<br /> (144 cores) | 24 hours | 4 | 1 SU


