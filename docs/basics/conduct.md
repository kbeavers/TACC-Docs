# [Good Conduct on TACC's HPC Systems](#conduct) { #conduct }
Last Update: 03/02/2023 in progress

**You share Frontera with many, sometimes hundreds, of other users**, and what you do on the system affects others. All users must follow a set of good practices which entail limiting activities that may impact the system for other users. Exercise good conduct to ensure that your activity does not adversely impact the system and the research community with whom you share it.

TACC staff has developed the following guidelines to good conduct on MACHINENAME. Please familiarize yourself especially with the first two mandates. The next sections discuss best practices on [limiting and minimizing I/O activity](#conduct-io) and [file transfers](#conduct-filesystems). And finally, we provide [job submission tips](#conduct-jobs) when constructing job scripts to help minimize wait times in the queues.  

## [Do Not Run Jobs on the Login Nodes](#conduct-loginnodes) { #conduct-loginnodes }

Each HPC resource's login nodes are shared among all users. Numerous users may be logged on at one time accessing the file systems. Hundreds of jobs may be running on all compute nodes, with hundreds more queued up to run. The login nodes provide an interface to the "back-end" compute nodes. 

MACHINENAME's few login nodes are shared among all users. Dozens, (sometimes hundreds) of users may be logged on at one time accessing the file systems. Think of the login nodes as a prep area, where users may edit and manage files, compile code, perform file management, issue transfers, submit new and track existing batch jobs etc. The login nodes provide an interface to the "back-end" compute nodes. 

Think of the login nodes as a prep area, where users may edit and manage files, compile code, perform file management, issue transfers, submit new and track existing batch jobs etc. 

The compute nodes are where actual computations occur and where research is done. All batch jobs and executables, as well as development and debugging sessions, must be run on the compute nodes. To access compute nodes on TACC resources, one must either [submit a job to a batch queue](#running-sbatch) or initiate an interactive session using the [`idev`](#running-idev) utility. 

A single user running computationally expensive or disk intensive task/s will negatively impact performance for other users. Running jobs on the login nodes is one of the fastest routes to account suspension. Instead, run on the compute nodes via an interactive session ([`idev`][TACCIDEV]) or by submitting a batch job.

!!! important
	Do not run jobs or perform intensive computational activity on the login nodes or the shared file systems.  Your account may be suspended if your jobs are impacting other users.

* **Do not launch too many simultaneous processes;** while it's fine to compile on a login node, a command like "<span style="white-space: nowrap;">`make -j 16`</span>" (which compiles on 16 cores) may impact other users.

	DO THIS: build and submit a batch job. All batch jobs run on the compute nodes.

	```cmd-line
	login1$ make mytarget
	login1$ sbatch myjobscript
	```

	DO NOT DO THIS: invoke multiple build sessions, or run an executable on a login node.

	```cmd-line
	login1$ make -j 12		# do not run intense builds/compilations on a login node
	login1$ ./myprogram		# do not run programs on a login node
	```

* **That script you wrote to poll job status should probably do so once every few minutes rather than several times a second.**



The compute nodes are where actual computations occur and where research is done. Hundreds of jobs may be running on all compute nodes, with hundreds more queued up to run. All batch jobs and executables, as well as development and debugging sessions, must be run on the compute nodes. To access compute nodes on TACC resources, one must either [submit a job to a batch queue](#running-sbatch) or initiate an interactive session using the [`idev`][TACCIDEV] utility. 

<figure id="figure-logincomputenodes">
<img src="../../imgs/login-compute-nodes.jpg">
<figcaption>Figure 2. Login and compute nodes</figcaption></figure>

A single user running computationally expensive or disk intensive task/s will negatively impact performance for other users. Running jobs on the login nodes is one of the fastest routes to account suspension. Instead, run on the compute nodes via an interactive session ([`idev`][TACCIDEV]) or by [submitting a batch job](#running).

!!! caution
	Do not run jobs or perform intensive computational activity on the login nodes or the shared file systems.<br>Your account may be suspended and you will lose access to the queues if your jobs are impacting other users.


### [Dos &amp; Don'ts on the Login Nodes](#conduct-loginnodes-examples) { #conduct-loginnodes-examples }

* **Do not run research applications on the login nodes;** this includes frameworks like MATLAB and R, as well as computationally or I/O intensive Python scripts. If you need interactive access, use the `idev` utility or Slurm's `srun` to schedule one or more compute nodes.

	DO THIS: Start an interactive session on a compute node and run Matlab.

	```cmd-line
	login1$ idev
	nid00181$ matlab
	```

	DO NOT DO THIS: Run Matlab or other software packages on a login node

	```cmd-line
	login1$ matlab
	```

* **Do not launch too many simultaneous processes;** while it's fine to compile on a login node, a command like <span style="white-space: nowrap;">`make -j 16`</span> (which compiles on 16 cores) may impact other users.

	DO THIS: build and submit a batch job. All batch jobs run on the compute nodes.

	```cmd-line
	login1$ make mytarget
	login1$ sbatch myjobscript
	```

	DO NOT DO THIS: Invoke intense build/compilation sessions.

	``` cmd-line
	login1$ make -j 12
	```

	DO NOT DO THIS: Run an executable on a login node.

	```cmd-line
	login1$ ./myprogram
	```

* **That script you wrote to poll job status should probably do so once every few minutes rather than several times a second.**


## [Do Not Stress the Shared File Systems](#conduct-filesystems) { #conduct-filesystems }

TACC resources, with a few exceptions, mount three file systems: `/home`, `/work` and `/scratch`. Please follow each file system's recommended usage.

The TACC Global Shared File System, Stockyard, is mounted on most TACC HPC resources as the `/work` (`$WORK`) directory. This file system is accessible to all TACC users, and therefore experiences a lot of I/O activity (reading and writing to disk, opening and closing files) as users run their jobs, read and generate data including intermediate and checkpointing files. As TACC adds more users, the stress on the `$WORK` file system is increasing to the extent that TACC staff is now recommending new job submission guidelines in order to reduce stress and I/O on Stockyard. 

**TACC staff now recommends that you run your jobs out of the `$SCRATCH` file system instead of the global `$WORK` file system.** 

To run your jobs out `$SCRATCH`:

* Copy or move all job input files to `$SCRATCH` 
* Make sure your job script directs all output to `$SCRATCH`  
* Once your job is finished, move your output files to `$WORK` to avoid any data purges.

!!! tip
	Compute nodes should not reference `$WORK` unless it's to stage data in/out only before/after jobs.

Consider that `$HOME` and `$WORK` are for storage and keeping track of important items. Actual job activity, reading and writing to disk, should be offloaded to your resource's `$SCRATCH` file system (see [Table. File System Usage Recommendations](#table-file-system-usage-recommendations). You can start a job from anywhere but the actual work of the job should occur only on the `$SCRATCH` partition. You can save original items to `$HOME` or `$WORK` so that you can copy them over to `$SCRATCH` if you need to re-generate results.


The next two sections discuss best practices on [limiting and minimizing I/O activity](#conduct-io) and [file transfers](#conduct-filesystems). And finally, we provide [job submission tips](#conduct-jobs) when constructing job scripts to help minimize wait times in the queues.  


### [More File System Tips](#conduct-filesystems-tips) { #conduct-filesystems-tips }

* **Don't run jobs in your `$HOME` directory.** The `$HOME` file system is for routine file management, not parallel jobs.

* **Watch all your [file system quotas](#files).** If you're near your quota in `$WORK` and your job is repeatedly trying (and failing) to write to `$WORK`, you will stress that file system. If you're near your quota in `$HOME`, jobs run on any file system may fail, because all jobs write some data to the hidden `$HOME/.slurm` directory.

* **Avoid storing many small files in a single directory, and avoid workflows that require many small files**. A few hundred files in a single directory is probably fine; tens of thousands is almost certainly too many. If you must use many small files, group them in separate directories of manageable size.

* TACC resources, with a few exceptions, mount three file systems: `/home`, `/work` and `/scratch`. **Please follow each file system's recommended usage.**



## [Limit File Transfers](#conduct-filetransfers) { #conduct-filetransfers }

In order to not stress both internal and external networks:

* **Avoid too many simultaneous file transfers**. You share the network bandwidth with other users; don't use more than your fair share. Two or three concurrent `scp` sessions is probably fine. Twenty is probably not.

* **Avoid recursive file transfers**, especially those involving many small files. Create a tar archive before transfers. This is especially true when transferring files to or from [Ranch](../../hpc/ranch).

* When creating or transferring large files to Stockyard (`$WORK`), be sure to stripe the receiving directories. See STRIPING for more information.





### [File System Usage Recommendations](#table-file-system-usage-recommendations) { table-file-system-usage-recommendations }

File System | Best Storage Practices | Best Activities
--- | --- | ---
<code>$HOME</code> | cron jobs<br>small scripts<br>environment settings | compiling, editing
<code>$WORK</code> | store software installations<br> original datasets that can't be reproduced<br> job scripts and templates | staging datasets
<code>$SCRATCH</code> | <b>Temporary Storage</b><br>I/O files<br>job files<br>temporary datasets | all job I/O activity<br>see TACC's <a href="#scratchpurgepolicy">Scratch File System Purge Policy</a>.

Maverick2 does not have a Scratch file system.


<!-- The TACC Global Shared File System, Stockyard, is mounted on most TACC HPC resources as the `/work` (`$WORK`) directory. This file system is accessible to all TACC users, and therefore experiences a lot of I/O activity (reading and writing to disk, opening and closing files) as users run their jobs, read and generate data including intermediate and checkpointing files. As TACC adds more users, the stress on the `$WORK` file system is increasing to the extent that TACC staff is now recommending new job submission guidelines in order to reduce stress and I/O on Stockyard. -->

<!-- TACC staff now recommends that you run your jobs out of your resource's `$SCRATCH` file system instead of the global `$WORK` file system. To run your jobs out `$SCRATCH` -->

<!-- * Copy or move all job input files to `$SCRATCH` -->
<!-- * Make sure your job script directs all output to `$SCRATCH`  -->

<!-- Consider that `$HOME` and `$WORK` are for storage and keeping track of important items. Actual job activity, reading and writing to disk, should be offloaded to your resource's `$SCRATCH` file system (see [Table 1.](#table1). You can start a job from anywhere but the actual work of the job should occur only on the `$SCRATCH` partition. You can save original items to `$HOME` or `$WORK` so that you can copy them over to `$SCRATCH` if you need to re-generate results.  -->

<!-- * **Run I/O intensive jobs in `$SCRATCH` rather than `$WORK`.** If you stress `$WORK`, you affect every user on every TACC system. Significant I/O might include reading/writing 100+ GBs to checkpoint/restart files, running with 4096+ MPI tasks all reading/writing individual files, but is not limited to just those two cases. **If you stress `$WORK`, you affect every user on every TACC system.** -->

<!-- <p class="portlet-msg-alert">Compute nodes should not reference `$WORK` unless it's to stage data in/out only before/after jobs.</p> -->

A few other file system tips:

* **Don't run jobs in your `$HOME` directory.** The `$HOME` file system is for routine file management, not parallel jobs.

* **Avoid storing many small files in a single directory, and avoid workflows that require many small files**. A few hundred files in a single directory is probably fine; tens of thousands is almost certainly too many. If you must use many small files, group them in separate directories of manageable size.

* **Watch all your [file system quotas](#files).** If you're near your quota in `$WORK` and your job is repeatedly trying (and failing) to write to `$WORK`, you will stress that file system. If you're near your quota in `$HOME`, jobs run on any file system may fail, because all jobs write some data to the hidden `$HOME/.slurm` directory.



## [Limit Input/Output (I/O) Activity](#conduct-io) { #conduct-io }

In addition to the file system tips above, it's important that your jobs limit all I/O activity. This section focuses on ways to avoid causing problems on each resources' shared file systems. 

* **Limit I/O intensive sessions** (lots of reads and writes to disk, rapidly opening or closing many files)

* **Avoid opening and closing files repeatedly** in tight loops. Every open/close operation on the file system requires interaction with the MetaData Service (MDS). The MDS acts as a gatekeeper for access to files on Lustre's parallel file system. Overloading the MDS will affect other users on the system. If possible, open files once at the beginning of your program/workflow, then close them at the end.

* **Don't get greedy.** If you know or suspect your workflow is I/O intensive, don't submit a pile of simultaneous jobs. Writing restart/snapshot files can stress the file system; avoid doing so too frequently. Also, use the `hdf5` or `netcdf` libraries to generate a single restart file in parallel, rather than generating files from each process separately.

!!! important
	If you know your jobs will require significant I/O, please submit a support ticket and an HPC consultant will work with you. See also [Managing I/O on TACC Resources][TACCMANAGINGIO] for additional information.


## [File Transfer Guidelines](#conduct-transfers) { #conduct-transfers }

In order to not stress both internal and external networks, be mindful of the following guidelines:

* When creating or transferring **large files** to Stockyard (`$WORK`) or the `$SCRATCH` file systems, **be sure to stripe the receiving directories appropriately**. See STRIPING for more information.

* **Avoid too many simultaneous file transfers**. You share the network bandwidth with other users; don't use more than your fair share. Two or three concurrent `scp` sessions is probably fine. Twenty is probably not.

* **Avoid recursive file transfers**, especially those involving many small files. Create a tar archive before transfers. This is especially true when transferring files to or from [Ranch][RANCHUG].


## [Job Submission Tips](#conduct-jobs) { #conduct-jobs }

* **Request Only the Resources You Need** Make sure your job scripts request only the resources that are needed for that job. Don't ask for more time or more nodes than you really need. The scheduler will have an easier time finding a slot for a job requesting 2 nodes for 2 hours, than for a job requesting 4 nodes for 24 hours. This means shorter queue waits times for you and everybody else.

* **Test your submission scripts.** Start small: make sure everything works on 2 nodes before you try 20. Work out submission bugs and kinks with 5 minute jobs that won't wait long in the queue and involve short, simple substitutes for your real workload: simple test problems; <span style="white-space: nowrap;">`hello world`</span> codes; one-liners like <span style="white-space: nowrap;">`ibrun hostname`</span>; or an `ldd` on your executable.

* **Respect memory limits and other system constraints.** If your application needs more memory than is available, your job will fail, and may leave nodes in unusable states. Use TACC's [Remora][TACCREMORA] tool to monitor your application's needs. 

{% include 'aliases.md' %}

