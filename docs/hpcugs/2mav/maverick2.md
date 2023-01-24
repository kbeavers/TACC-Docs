<script>
function showhideserial() {
	var div = document.getElementById("serial");
	if (div.style.display == "block") {
		document.getElementById("img-serial").src = "../../../imgs/small-right-arrow.png";
		div.style.display = "none";
	} else {
		div.style.display = "block";
		document.getElementById("img-serial").src = "../../../imgs/small-down-arrow.png";
	}
}

function showhidempi() {
	var div = document.getElementById("mpi");
	if (div.style.display == "block") {
		document.getElementById("img-mpi").src = "../../../imgs/small-right-arrow.png";
		div.style.display = "none";
	} else {
		div.style.display = "block";
		document.getElementById("img-mpi").src = "../../../imgs/small-down-arrow.png";
	}
}

function showhideopenmp() {
	var div = document.getElementById("openmp");
	if (div.style.display == "block") {
		document.getElementById("img-openmp").src = "../../../imgs/small-right-arrow.png";
		div.style.display = "none";
	} else {
		div.style.display = "block";
		document.getElementById("img-openmp").src = "../../../imgs/small-down-arrow.png";
	}
}

function showhidehybrid() {
	var div = document.getElementById("hybrid");
	if (div.style.display == "block") {
		document.getElementById("img-hybrid").src = "../../../imgs/small-right-arrow.png";
		div.style.display = "none";
	} else {
		div.style.display = "block";
		document.getElementById("img-hybrid").src = "../../../imgs/small-down-arrow.png";
	}
}

</script>
<style>.help{box-sizing:border-box}.help *,.help *:before,.help *:after{box-sizing:inherit}.row{margin-bottom:10px;margin-left:-15px;margin-right:-15px}.row:before,.row:after{content:" ";display:table}.row:after{clear:both}[class*="col-"]{box-sizing:border-box;float:left;position:relative;min-height:1px;padding-left:15px;padding-right:15px}.col-1-5{width:20%}.col-2-5{width:40%}.col-3-5{width:60%}.col-4-5{width:80%}.col-1-4{width:25%}.col-1-3{width:33.3%}.col-1-2,.col-2-4{width:50%}.col-2-3{width:66.7%}.col-3-4{width:75%}.col-1-1{width:100%}article.help{font-size:1.25em;line-height:1.2em}.text-center{text-align:center}figure{display:block;margin-bottom:20px;line-height:1.42857143;border:1px solid #ddd;border-radius:4px;padding:4px;text-align:center}figcaption{font-weight:bold}.lead{font-size:1.7em;line-height:1.4;font-weight:300}.embed-responsive{position:relative;display:block;height:0;padding:0;overflow:hidden}.embed-responsive-16by9{padding-bottom:56.25%}.embed-responsive .embed-responsive-item,.embed-responsive embed,.embed-responsive iframe,.embed-responsive object,.embed-responsive video{position:absolute;top:0;bottom:0;left:0;width:100%;height:100%;border:0}</style>

# Maverick2 User Guide
<i>Last update: August 24, 2022</i> editing 01/18/2023

## [Notices](#notices) { #notices }

* **All users: refer to updated [Remote Desktop Access](#remote-desktop-access) instructions.** (07/20/2021)
* All users: read [Managing I/O on TACC Resources][TACCMANAGINGIO]. TACC Staff have put forth new file system and job submission guidelines. (01/09/21)
* Maverick2 is TACC's dedicated Deep Learning Machine.  Allocation requests must include a justification explaining your need for this resource. 
* Maverick2 does not support any Visualization applications. 
* Maverick2 does not mount a `/scratch` (`$SCRATCH`) file system.


## [Introduction](#intro) { #intro }

Maverick2 is an extension to TACC's services to support GPU accelerated Machine Learning and Deep Learning research workloads. The power of this system is in its multiple GPUs per node and it is mostly intended to support workloads that are better supported with a dense cluster of GPUs and little CPU compute. The system is designed to support model training via GPU powered frameworks that can take advantage of the 4 GPUs in a node. In addition to the 96 1080-TI Nvidia GPU cards, a limited number of Pascal 100 and Volta 100 cards are available to support any workloads that cannot be done in the smaller memory footprints of the primary GPU cards. The system software supports Tensorflow and Caffe and can also be augmented to run other frameworks. 

<figure>
<img alt="" src="../../../imgs/2mav/trailofhorses.jpg" style="width: 600px; border-width: 1px; border-style: solid; height: 360px;" />
<figcaption><font size=-2>Figure 1. Edward Blein - Trail of Horses</font></figcaption></figure>

## [System Overview](#overview) { #overview }

Maverick2 hosts the following GPUs: 24 nodes each with 4 NVidia GTX 1080 Ti GPUs running in a Broadwell based compute node; four nodes each with two of NVidia V100s GPUs running in a Skylake based Dell R740 based node; and three nodes each with two NVidia P100s GPUs running in a Skylake based Dell R740 node.

### [GTX Compute Nodes](#overview-computenodes) { #overview-computenodes }

Maverick2 hosts 24 GTX compute nodes. One GTX node is reserved for staff use, leaving 23 nodes available for general use.

Table 1. Maverick2 GTX Compute Node Specifications

Specification | Value
--- | ---
Model: | Super Micro X10DRG-Q Motherboard
Processor: | Intel(R) Xeon(R) CPU E5-2620 v4
Total processors per node: | 2
Total cores per processor: | 8
Total cores per node: | 16
Hardware threads per core: | 2
Hardware threads per node: | 32
Clock rate: | 2.10GHz
RAM: | 128 GB
L1/L2/L3 Cache: | 512KiB / 2MiB / 20 MiB
Local storage: | 150.0 GB (~60 GB free)
GPUs: | 4 x NVidia 1080-TI GPUs

### [V100 Compute Nodes](#overview-v100) { #overview-v100 }

Maverick2 has 4 V100 compute nodes.

Table 2. Maverick2 V100 Compute Node Specifications

Specification | Value
--- | ---
Model: | Dell PowerEdge R740
Processor: | Xeon(R) Platinum 8160 CPU @ 2.10GHz
Total processors per node: | 2
Total cores per processor: | 24
Total cores per node: | 48
Hardware threads per core: | 2
Hardware threads per node: | 96
Clock rate: | 2.10GHz
RAM: | 192 GB
L1/L2/L3 Cache: | 1536KiB / 24576KiB / 33792KiB
Local storage: | 119.5 GB (~32 GB free)
GPUs: | 2 NVidia  V100 adapters

### [P100 Compute Nodes](#overview-p100) { #overview-p100 }

Maverick2 has 3 P100 nodes.

Table 3. Maverick2 P100 Compute Node Specifications

Specification | Value
--- | ---
Model: | Dell PowerEdge R740
Processor: | Xeon(R) Platinum 8160 CPU @ 2.10GHz
Total processors per node: | 2
Total cores per processor: | 24
Total cores per node: | 48
Hardware threads per core: | 2
Hardware threads per node: | 96
Clock rate: | 2.10GHz
RAM: | 192 GB
L1/L2/L3 Cache: | 1536KiB / 24576KiB / 33792KiB
Local storage: | 119.5 GB (~32 GB free)
GPUs: | 2 NVidia P100 adapters

### [Login Nodes](#overview-loginnodes) { #overview-loginnodes }

Maverick2 hosts a single login node:

* Dual Socket
* Intel Xeon CPU E5-2660 v3 (Haswell) @ 2.60GHz: 10 cores/socket (20 cores/node)
* 128 GB DDR4-2133 (8 x 16GB dual rank x4 DIMMS)
* Hyperthreading Disabled

### [Network](#overview-network) { #overview-network }

* Mellanox FDR Infiniband MT27500 Family ConnectX-3 Adapter
* up to 10/40/56Gbps bandwidth and a sub-microsecond low latency
* Fat Tree Interconnect
* Intel Ethernet Controller I350 IEEE 802.3 1Gbps Adapter

### [File Systems](#overview-filesystems) { #overview-filesystems }

Maverick2 mounts two shared Lustre file systems on which each user has corresponding account-specific directories [`$HOME` and `$WORK`](#files-filesystems). **Unlike most TACC resources, Maverick2 does not mount a `/scratch` file system.**  Both the `/home` and `/work` file systems are available from all Maverick2 nodes; the [Stockyard-hosted `/work` file system](https://www.tacc.utexas.edu/systems/stockyard) is available on other TACC systems as well. A Lustre file system looks and acts like a single logical hard disk, but is actually a sophisticated integrated system involving many physical drives (dozens of physical drives for `$HOME` and thousands for `$WORK`).

<!-- p class="portlet-msg-info">See <a href="#files">Managing Your Files</a> section below and consult the <a href="/user-guides/stampede2#using-citizenship-filesystems">Shared Lustre File Systems</a> section in the <a href="/user-guides/stampede2">Stampede2 User Guide</a> for best practices. </p> -->


<figure>
<img alt="" src="../../../imgs/2mav/cooling-system.jpg" style="width: 800px; height: 524px; border-width: 1px; border-style: solid;" />
<figcaption><font size=-2>Figure 2. Maverick2 Immersion Cooling System</font></figcaption>
</figure>

## [Accessing the System](#access) { #access }

Access to all TACC systems now requires Multi-Factor Authentication (MFA). You can create an MFA pairing on the TACC User Portal. After login on the portal, go to your account profile (Home->Account Profile), then click the "Manage" button under "Multi-Factor Authentication" on the right side of the page. See [Multi-Factor Authentication at TACC][TACCMFA] for further information. 

### [Secure Shell (SSH)](#access-ssh) { #access-ssh }

The "`ssh`" command (SSH protocol) is the standard way to connect to Maverick2. SSH also includes support for the file transfer utilities `scp` and `sftp`. [Wikipedia](https://en.wikipedia.org/wiki/Secure_Shell) is a good source of information on SSH. SSH is available within Linux and from the terminal app in the Mac OS. If you are using Windows, you will need an SSH client that supports the SSH-2 protocol: e.g. [Bitvise](https://www.bitvise.com), [OpenSSH](http://www.openssh.com), [PuTTY](https://www.putty.org), or [SecureCRT](https://www.vandyke.com/products/securecrt/). Initiate a session using the `ssh` command or the equivalent; from the Linux command line the launch command looks like this:

<pre class="cmd-line">localhost$ <b>ssh <i>username</i>@maverick2.tacc.utexas.edu</b></pre>

Use your TUP password for direct logins to Maverick2. **Only users with an allocation on Maverick2 may log on.** You can change your TACC password through the [TACC User Portal][TACCUSERPORTAL]. Log into the portal, then select "Change Password" under the "HOME" tab. If you've forgotten your password, go to the [TACC User Portal][TACCUSERPORTAL] home page and select "Password Reset" under the Home tab.

To report a connection problem, execute the `ssh` command with the <span style="white-space: nowrap;">"`-vvv`"</span> option and include the verbose output when submitting a help ticket.


## [Good Conduct](#conduct) { #conduct }

**You share Maverick2 with many, sometimes hundreds, of other users**, and what you do on the system affects others. All users must follow a set of good practices which entail limiting activities that may impact the system for other users. Exercise good conduct to ensure that your activity does not adversely impact the system and the research community with whom you share it. 

TACC staff has developed the following guidelines to good conduct on Maverick2. Please familiarize yourself especially with the first two mandates:

* [Do Not Run Jobs on the Login Nodes](#conduct-loginnodes)
* [Do Not Stress the File Systems](#conduct-filesystems)


The next two sections discuss best practices on [limiting and minimizing I/O activity](#conduct-io) and [file transfers](#conduct-filesystems). And finally, we provide [job submission tips](#conduct-jobs) when constructing job scripts to help minimize wait times in the queues.  

### [Do Not Run Jobs on the Login Nodes](#conduct-loginnodes) { #conduct-loginnodes }

Maverick2's login node is shared among all users. Numerous users may be logged on at one time accessing the file systems. Hundreds of jobs may be running on all compute nodes, with hundreds more queued up to run. The login nodes provide an interface to the "back-end" compute nodes. 

Think of the login nodes as a prep area, where users may edit and manage files, compile code, perform file management, issue transfers, submit new and track existing batch jobs etc. 

The compute nodes are where actual computations occur and where research is done. All batch jobs and executables, as well as development and debugging sessions, must be run on the compute nodes. To access compute nodes on TACC resources, one must either [submit a job to a batch queue](#running-sbatch) or initiate an interactive session using the [`idev`](#running-idev) utility. 

A single user running computationally expensive or disk intensive task/s will negatively impact performance for other users. Running jobs on the login nodes is one of the fastest routes to account suspension. Instead, run on the compute nodes via an interactive session ([`idev`][TACCIDEV]) or by submitting a batch job.

!!! important
	Do not run jobs or perform intensive computational activity on the login nodes or the shared file systems.  Your account may be suspended if your jobs are impacting other users.

* **Do not run research applications on the login nodes;** this includes frameworks like MATLAB and R, as well as computationally or I/O intensive Python scripts. If you need interactive access, use the `idev` utility or Slurm's `srun` to schedule one or more compute nodes.

	DO THIS: Start an interactive session on a compute node and run Matlab.

	<pre class="cmd-line">
	login1$ <b>idev</b>
	nid00181$ <b>matlab</b></pre>

	DO NOT DO THIS: Run Matlab or other software packages on a login node

	<pre class="cmd-line"><s>login1$ <b>matlab</b></s></pre>

* **Do not launch too many simultaneous processes;** while it's fine to compile on a login node, a command like "<span style="white-space: nowrap;">`make -j 16`</span>" (which compiles on 16 cores) may impact other users.

	DO THIS: build and submit a batch job. All batch jobs run on the compute nodes.

	<pre class="cmd-line">
	login1$ <b>make <i>mytarget</i></b>
	login1$ <b>sbatch <i>myjobscript</i></b></pre>

	DO NOT DO THIS: invoke multiple build sessions, run an executable on a login node.

	<pre class="cmd-line">
	<s>login1$ <b>make -j 12</b>
	login1$ <b>./myprogram</b></s></pre>

* **That script you wrote to poll job status should probably do so once every few minutes rather than several times a second.**



### [Do Not Stress the Shared File Systems](#conduct-filesystems) { #conduct-filesystems }

TACC resources, with a few exceptions, mount three file systems: `/home`, `/work` and `/scratch`. Please follow each file system's recommended usage.

#### [File System Usage Recommendations](#table-file-system-usage-recommendations) { #table-file-system-usage-recommendations }

File System | Best Storage Practices | Best Activities
--- | --- | ---
<code>$HOME</code> | cron jobs<br>small scripts<br>environment settings | compiling, editing
<code>$WORK</code> | software installations<br> original datasets that can't be reproduced<br> job scripts and templates | staging datasets


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


### [Limit Input/Output (I/O) Activity](#conduct-io) { #conduct-io }

In addition to the file system tips above, it's important that your jobs limit all I/O activity. This section focuses on ways to avoid causing problems on each resources' shared file systems. 

* **Limit I/O intensive sessions** (lots of reads and writes to disk, rapidly opening or closing many files)

* **Avoid opening and closing files repeatedly** in tight loops. Every open/close operation on the file system requires interaction with the MetaData Service (MDS). The MDS acts as a gatekeeper for access to files on Lustre's parallel file system. Overloading the MDS will affect other users on the system. If possible, open files once at the beginning of your program/workflow, then close them at the end.

* **Don't get greedy.** If you know or suspect your workflow is I/O intensive, don't submit a pile of simultaneous jobs. Writing restart/snapshot files can stress the file system; avoid doing so too frequently. Also, use the `hdf5` or `netcdf` libraries to generate a single restart file in parallel, rather than generating files from each process separately.

!!! important
	If you know your jobs will require significant I/O, please submit a support ticket and an HPC consultant will work with you. See also [Managing I/O on TACC Resources][TACCMANAGINGIO] for additional information.

### [Limit File Transfers](#conduct-filetransfers) { #conduct-filetransfers }

In order to not stress both internal and external networks:

* **Avoid too many simultaneous file transfers**. You share the network bandwidth with other users; don't use more than your fair share. Two or three concurrent `scp` sessions is probably fine. Twenty is probably not.

* **Avoid recursive file transfers**, especially those involving many small files. Create a tar archive before transfers. This is especially true when transferring files to or from [Ranch][RANCH].

* When creating or transferring large files to Stockyard (`$WORK`), be sure to stripe the receiving directories. See STRIPING for more information.

### [Job Submission Tips](#conduct-jobs) { #conduct-jobs }

* **Request Only the Resources You Need** Make sure your job scripts request only the resources that are needed for that job. Don't ask for more time or more nodes than you really need. The scheduler will have an easier time finding a slot for a job requesting 2 nodes for 2 hours, than for a job requesting 4 nodes for 24 hours. This means shorter queue waits times for you and everybody else.

* **Test your submission scripts.** Start small: make sure everything works on 2 nodes before you try 20. Work out submission bugs and kinks with 5 minute jobs that won't wait long in the queue and involve short, simple substitutes for your real workload: simple test problems; <span style="white-space: nowrap;">`hello world`</span> codes; one-liners like <span style="white-space: nowrap;">`ibrun hostname`</span>; or an `ldd` on your executable.

* **Respect memory limits and other system constraints.** If your application needs more memory than is available, your job will fail, and may leave nodes in unusable states. Use TACC's [Remora][TACCREMORA] tool to monitor your application's needs. 

## [Managing Your Files](#files) { #files }

Maverick2 mounts two Lustre file systems that are shared across all nodes: the home and work file systems. Maverick2's startup mechanisms define corresponding account-level environment variables, `$HOME` and `$WORK`, that store the paths to directories that you own on each of these file systems. Maverick2's home file system is mounted only on Maverick2, but the work file system mounted on Maverick2 is the Global Shared File System hosted on [Stockyard](https://www.tacc.utexas.edu/systems/stockyard). This is the same work file system that is currently available on Stampede2, Frontera, Lonestar6, and several other TACC resources.

Table 4. Maverick2 File Systems

File System | Quota | Key Features
--- | --- | ---
<code>$HOME</code> | 10GB, 200,000 files | <b>Not intended for parallel or high-intensity file operations.</b><br>Backed up regularly.<br>Overall capacity ~1PB. NFS-mounted. Two Meta-Data Servers (MDS), four Object Storage Targets (OSTs).<br>Defaults: 1 stripe, 1MB stripe size.<br>Not purged.</br>
<code>$WORK</code> | 1TB, 3,000,000 files across all TACC systems,<br>regardless of where on the file system the files reside.  | <b>Not intended for high-intensity file operations or jobs involving very large files.</b><br>On the Global Shared File System that is mounted on most TACC systems.<br>See <a href="https://www.tacc.utexas.edu/systems/stockyard">Stockyard system description</a> for more information.<br>Defaults: 1 stripe, 1MB stripe size<br>Not backed up.<br>Not purged.</br>
<code>$SCRATCH</code> | <b>N/A</b> | <b>Maverick2 does not mount a scratch file system.</b>

The `$STOCKYARD` environment variable points to the highest-level directory that you own on the Global Shared File System. The definition of the `$STOCKYARD` environment variable is of course account-specific, but you will see the same value on all TACC systems that provide access to the Global Shared File System (see [Figure 3](#figure3)). This directory is an excellent place to store files you want to access regularly from multiple TACC resources.

### [Navigating the Shared File Systems](#files-navigating) { #files-navigating }

Your account-specific `$WORK` environment variable varies from system to system and (except for the decommissioned Stampede1 system) is a sub-directory of `$STOCKYARD` ([Figure 3](#figure3)). The sub-directory name corresponds to the associated TACC resource. The `$WORK` environment variable on Maverick2 points to the `$STOCKYARD/maverick2` subdirectory, a convenient location for files you use and jobs you run on Maverick2. Remember, however, that all subdirectories contained in your `$STOCKYARD` directory are available to you from any system that mounts the file system. If you have accounts on both Maverick2 and Stampede2, for example, the `$STOCKYARD/maverick2` directory is available from your Stampede2 account, and `$STOCKYARD/stampede2` is available from your Maverick2 account. Your quota and reported usage on the Global Shared File System reflects all files that you own on Stockyard, regardless of their actual location on the file system.

<figure>
<img src="../../../imgs/stockyard-2022.jpg">
<figcaption>**Figure 3.** Account-level directories on the work file system (Global Shared File System hosted on Stockyard). Example for fictitious user `bjones`. All directories usable from all systems. Sub-directories (e.g. `frontera`, `maverick2`) exist only when you have allocations on the associated system.
</figcaption></figure>

Note that resource-specific <span style="white-space: nowrap;">sub-directories</span> of `$STOCKYARD` are nothing more than convenient ways to manage your <span style="white-space: nowrap;">resource-specific</span> files. You have access to any such <span style="white-space: nowrap;">sub-directory</span> from any TACC resources. If you are logged into Maverick2, for example, executing the alias `cdw` (equivalent to <span style="white-space: nowrap;">"`cd $WORK`"</span>) will take you to the <span style="white-space: nowrap;">resource-specific</span> <span style="white-space: nowrap;">sub-directory</span> `$STOCKYARD/maverick2`. But you can access this directory from other TACC systems as well by executing <span style="white-space: nowrap;">"`cd $STOCKYARD/maverick2`"</span>. These commands allow you to share files across TACC systems. In fact, several convenient <span style="white-space: nowrap;">account-level</span> aliases make it even easier to navigate across the directories you own in the shared file systems:

#### [Table 5. Built-in Account Level Aliases](#table5) { #table5 }

Alias | Command
--- | ---
<code>cd</code> or <code>cdh</code> | <code>cd $HOME</code>
<code>cdw</code> | <code>cd $WORK</code>
<code>cdy</code> or <code>cdg</code> | <code>cd $STOCKYARD</code>


### [Transferring Files Using `scp` and `rsync`](#transferring-scp) { #transferring-scp }

You can transfer files between Maverick2 and Linux-based systems using either [`scp`](http://linux.com/learn/intro-to-linux/2017/2/how-securely-transfer-files-between-servers-scp) or [`rsync`](http://linux.com/learn/get-know-rsync). Both `scp` and `rsync` are available in the Mac Terminal app. Windows [ssh clients](http://portal.tacc.utexas.edu/user-guides/stampede2#secure-shell-ssh) typically include `scp`-based file transfer capabilities.

The Linux `scp` (secure copy) utility is a component of the OpenSSH suite. Assuming your Maverick2 username is `bjones`, a simple `scp` transfer that pushes a file named "`myfile`" from your local Linux system to Maverick2 `$HOME` would look like this:

<pre class="cmd-line">localhost$ <b>scp ./myfile bjones@maverick2.tacc.utexas.edu:</b>  # note colon after net address</pre>

You can use wildcards, but you need to be careful about when and where you want wildcard expansion to occur. For example, to push all files ending in "`.txt`" from the current directory on your local machine to `/work/01234/bjones/scripts` on Maverick2:

<pre class="cmd-line">localhost$ <b>scp *.txt bjones@maverick2.tacc.utexas.edu:/work/01234/bjones/maverick2</b></pre>

To delay wildcard expansion until reaching Maverick2, use a backslash ("`\`") as an escape character before the wildcard. For example, to pull all files ending in "`.txt`" from `/work/01234/bjones/scripts` on Maverick2 to the current directory on your local system:

<pre class="cmd-line">localhost$ <b>scp bjones@maverick2.tacc.utexas.edu:/work/01234/bjones/maverick2/\*.txt .</b></pre>

You can of course use shell or environment variables in your calls to `scp`. For example:

<pre class="cmd-line">
localhost$ <b>destdir="/work/01234/bjones/maverick2/data"</b>
localhost$ <b>scp ./myfile bjones@maverick2.tacc.utexas.edu:$destdir</b></pre>

You can also issue `scp` commands on your local client that use Maverick2 environment variables like `$HOME` and `$WORK`. To do so, use a backslash ("`\`") as an escape character before the "`$`"; this ensures that expansion occurs after establishing the connection to Maverick2:

<pre class="cmd-line">localhost$ <b>scp ./myfile bjones@maverick2.tacc.utexas.edu:\$WORK/data</b>   # Note backslash</pre>

Avoid using `scp` for recursive ("`-r`") transfers of directories that contain nested directories of many small files:

<pre class="cmd-line">localhost$ <s><b>scp -r  ./mydata     bjones@maverick2.tacc.utexas.edu:\$WORK</b></s>  # DON'T DO THIS</pre>

Instead, use `tar` to create an archive of the directory, then transfer the directory as a single file:

<pre class="cmd-line">
localhost$ <b>tar cvf ./mydata.tar mydata</b>                                   # create archive
localhost$ <b>scp     ./mydata.tar bjones@maverick2.tacc.utexas.edu:\$WORK</b>  # transfer archive</pre>

The `rsync` (remote synchronization) utility is a great way to synchronize files that you maintain on more than one system: when you transfer files using `rsync`, the utility copies only the changed portions of individual files. As a result, `rsync` is especially efficient when you only need to update a small fraction of a large dataset. The basic syntax is similar to `scp`:

<pre class="cmd-line">
localhost$ <b>rsync       mybigfile bjones@maverick2.tacc.utexas.edu:\$WORK/data</b>
localhost$ <b>rsync -avtr mybigdir  bjones@maverick2.tacc.utexas.edu:\$WORK/data</b></pre>

The options on the second transfer are typical and appropriate when synching a directory: this is a recursive update ("`-r`") with verbose ("`-v`") feedback; the synchronization preserves time stamps ("`-t`") as well as symbolic links and other meta-data ("`-a`"). Because `rsync` only transfers changes, recursive updates with `rsync` may be less demanding than an equivalent recursive transfer with `scp`.

See [Good Conduct](#conduct) for additional important advice about striping the receiving directory when transferring large files; watching your quota on `$HOME` and `$WORK`; and limiting the number of simultaneous transfers. Remember also that `$STOCKYARD` (and your `$WORK` directory on each TACC resource) is available from several other TACC systems: there's no need for `scp` when both the source and destination involve sub-directories of `$STOCKYARD`. See [Managing Your Files](#files) for more information about transfers on `$STOCKYARD`.


### [Sharing Files with Collaborators](#files-sharing) { #files-sharing }

If you wish to share files and data with collaborators in your project, see [Sharing Project Files on TACC Systems](http://portal.tacc.utexas.edu/tutorials/sharing-project-files) for step-by-step instructions. Project managers or delegates can use Unix group permissions and commands to create read-only or read-write shared workspaces that function as data repositories and provide a common work area to all project members.

### [Notes on Small Files Under Lustre](#files-smallfiles) { #files-smallfiles }

The Stockyard/`$WORK` file system is a Lustre file system which is optimized for large scale reads and writes. As some workloads, such as image classification, leverage using multiple small files, we advise users not work directly on `$WORK` with these workloads. Users should have their jobs copy these files to `/tmp` on the compute node, compute against the `/tmp` data, store their results on the `$WORK` file system, and clean up `/tmp`. We are currently working on solutions to expand the 60 GB `/tmp` capacity. 

### [Striping Large Files](#files-striping) { #files-striping }

Lustre can **stripe** (distribute) large files over several physical disks, making it possible to deliver the high performance needed to service input/output (I/O) requests from hundreds of users across thousands of nodes. Object Storage Targets (OSTs) manage the file system's spinning disks: a file with 20 stripes, for example, is distributed across 20 OSTs. One designated Meta-Data Server (MDS) tracks the OSTs assigned to a file, as well as the file's descriptive data.

Before transferring large files to Maverick2, or creating new large files, be sure to set an appropriate default stripe count on the receiving directory. To avoid exceeding your fair share of any given OST, a good rule of thumb is to allow at least one stripe for each 100GB in the file. For example, to set the default stripe count on the current directory to 30 (a plausible stripe count for a directory receiving a file approaching 3TB in size), execute:

<pre class="cmd-line">$ <b>lfs setstripe -c 30 $PWD</b></pre>

Note that an "`lfs setstripe`" command always sets both stripe count and stripe size, even if you explicitly specify only one or the other. Since the example above does not explicitly specify stripe size, the command will set the stripe size on the directory to Maverick2's system default (1MB). In general there's no need to customize stripe size when creating or transferring files.

Remember that it's not possible to change the striping on a file that already exists. Moreover, the "`mv`" command has no effect on a file's striping if the source and destination directories are on the same file system. You can, of course, use the "`cp`" command to create a second copy with different striping; to do so, copy the file to a directory with the intended stripe parameters.



## [Running Jobs on the Maverick2 Compute Nodes](#running) { #running}

<!-- /taccinfo blurb
= File.read "../../include/maverick2-jobaccounting.html" -->

{% include 'include/maverick2-jobaccounting.md' %}

### [Slurm Job Scheduler](#running-slurm) { #running-slurm }

Maverick2 employs the [Slurm Workload Manager](http://schedmd.com) job scheduler.  Slurm commands enable you to submit, manage, monitor, and control your jobs.  

The [Stampede2 User Guide][STAMPEDE2UG] discusses Slurm extensively.  See the following sections for detailed information:

* [Submitting Jobs with `sbatch`](http://portal.tacc.utexas.edu/user-guides/stampede2#running-sbatch)
* [Common `sbatch` options](http://portal.tacc.utexas.edu/user-guides/stampede2#table6)
* [Launching Applications](http://portal.tacc.utexas.edu/user-guides/stampede2#launching-applications)

### [Slurm Partitions (Queues)](#running-queues) { #running-queues }

**Queues and limits are subject to change without notice.** 

Execute "`qlimits`" on Maverick2 for real-time information regarding limits on available queues.

See Stampede2's [Monitoring Jobs and Queues](http://portal.tacc.utexas.edu/user-guides/stampede2#monitoring) section for additional information.

#### [Table 6. Maverick2 Production Queues](#table6) { #table6 }

Queue Name<br>(available nodes) | Max Nodes per Job<br /> (assoc'd cores)  | Max Duration  | Max Jobs in Queue  | Charge Rate<br /> (per node-hour) 
--- | --- | --- | --- | ---
<code>gtx</code><br>(24 nodes) | 4 nodes<br /> (64 cores) | 24 hours | 4 | 1 SU
<code>v100</code><br>(4 nodes) | 4 nodes<br>(192 cores) | 24 hours | 4 | 1 SU
<code>p100</code><br>(3 nodes) | 3 nodes<br /> (144 cores) | 24 hours | 4 | 1 SU


## [Job Scripts](#scripts)  { #scripts }

<details><summary>Serial Job in Normal Queue</summary>

``` { .bash .job-script }
#!/bin/bash
#----------------------------------------------------
# Sample Slurm job script for TACC MACHINENAME nodes
#
#   *** Serial Job in Normal Queue ***
# 
# Last revised: XX Oct 2018
#
# Notes:
#
#   -- Copy/edit this script as desired.  Launch by executing
#      "sbatch maverick2.serial.slurm" on a MACHINENAME login node.
#
#   -- Serial codes run on a single node (upper case N = 1).
#        A serial code ignores the value of lower case n,
#        but slurm needs a plausible value to schedule the job.
#
#   -- For a good way to run multiple serial executables at the
#        same time, execute "module load launcher" followed
#        by "module help launcher".

#----------------------------------------------------

#SBATCH -J myjob           # Job name
#SBATCH -o myjob.o%j       # Name of stdout output file
#SBATCH -e myjob.e%j       # Name of stderr error file
#SBATCH -p normal          # Queue (partition) name
#SBATCH -N 1               # Total # of nodes (must be 1 for serial)
#SBATCH -n 1               # Total # of mpi tasks (should be 1 for serial)
#SBATCH -t 01:30:00        # Run time (hh:mm:ss)
#SBATCH --mail-user=username@tacc.utexas.edu
#SBATCH --mail-type=all    # Send email at begin and end of job
#SBATCH -A myproject       # Allocation name (req'd if you have more than 1)

# Other commands must follow all #SBATCH directives...

module list
pwd
date

# Launch serial code...

./mycode.exe         # Do not use ibrun or any other MPI launcher

# ---------------------------------------------------```
```

</details>
<details><summary>MPI Job in Normal Queue</summary>

``` { .bash .job-script }
#!/bin/bash
#----------------------------------------------------
# Sample Slurm job script for TACC MACHINENAME nodes
#
#   *** MPI Job in Normal Queue ***
# 
# Last revised: XX Oct 2018
#
# Notes:
#
#   -- Launch this script by executing
#      "sbatch maverick2.mpi.slurm" on MACHINENAME login node.
#
#   -- Use ibrun to launch MPI codes on TACC systems.
#      Do not use mpirun or mpiexec.
#
#   -- Max recommended MPI tasks per KNL node: 64-68
#      (start small, increase gradually).
#
#   -- If you're running out of memory, try running
#      fewer tasks per node to give each task more memory.
#
#----------------------------------------------------

#SBATCH -J myjob           # Job name
#SBATCH -o myjob.o%j       # Name of stdout output file
#SBATCH -e myjob.e%j       # Name of stderr error file
#SBATCH -p normal          # Queue (partition) name
#SBATCH -N 4               # Total # of nodes 
#SBATCH -n 32              # Total # of mpi tasks
#SBATCH -t 01:30:00        # Run time (hh:mm:ss)
#SBATCH --mail-user=username@tacc.utexas.edu
#SBATCH --mail-type=all    # Send email at begin and end of job
#SBATCH -A myproject       # Allocation name (req'd if you have more than 1)

# Other commands must follow all #SBATCH directives...

module list
pwd
date

# Launch MPI code... 

ibrun ./mycode.exe         # Use ibrun instead of mpirun or mpiexec

# ---------------------------------------------------```
```

</details>
<details><summary>OpenMP Job in Normal Queue</summary>

``` { .bash .job-script }
#!/bin/bash
#----------------------------------------------------
# Sample Slurm job script for TACC MACHINENAME nodes
#
#   *** OpenMP Job in Normal Queue ***
# 
# Last revised: XX Oct 2018
#
# Notes:
#
#   -- Launch this script by executing
#   -- Copy/edit this script as desired.  Launch by executing
#      "sbatch maverick2.openmp.slurm" on a MACHINENAME login node.
#
#   -- OpenMP codes run on a single node (upper case N = 1).
#        OpenMP ignores the value of lower case n,
#        but slurm needs a plausible value to schedule the job.
#
#   -- Default value of OMP_NUM_THREADS is 1; be sure to change it!
#
#   -- Increase thread count gradually while looking for optimal setting.
#        If there is sufficient memory available, the optimal setting
#        is often 68 (1 thread per core) or 136 (2 threads per core).

#----------------------------------------------------

#SBATCH -J myjob           # Job name
#SBATCH -o myjob.o%j       # Name of stdout output file
#SBATCH -e myjob.e%j       # Name of stderr error file
#SBATCH -p normal          # Queue (partition) name
#SBATCH -N 1               # Total # of nodes (must be 1 for OpenMP)
#SBATCH -n 1               # Total # of mpi tasks (should be 1 for OpenMP)
#SBATCH -t 01:30:00        # Run time (hh:mm:ss)
#SBATCH --mail-user=username@tacc.utexas.edu
#SBATCH --mail-type=all    # Send email at begin and end of job
#SBATCH -A myproject       # Allocation name (req'd if you have more than 1)

# Other commands must follow all #SBATCH directives...

module list
pwd
date

# Set thread count (default value is 1)...

export OMP_NUM_THREADS=34

# Launch OpenMP code...

./mycode.exe         # Do not use ibrun or any other MPI launcher

# ---------------------------------------------------```
```

</details>
<details><summary>Hybrid Job in Normal Queue</summary>

``` { .bash .job-script }
#!/bin/bash
#----------------------------------------------------
# Example Slurm job script for TACC MACHINENAME nodes
#
#   *** Hybrid Job in Normal Queue ***
# 
#       This sample script specifies:
#         10 nodes (capital N)
#         40 total MPI tasks (lower case n); this is 4 tasks/node
#         16 OpenMP threads per MPI task (64 threads per node)
#
# Last revised: XX Oct 2018
#
# Notes:
#
#   -- Launch this script by executing
#      "sbatch maverick2.hybrid.slurm" on MACHINENAME login node.
#
#   -- Use ibrun to launch MPI codes on TACC systems.
#      Do not use mpirun or mpiexec.
#
#   -- In most cases it's best to specify no more 
#      than 64-68 MPI ranks or independent processes 
#      per node, and 1-2 threads/core. 
#
#   -- If you're running out of memory, try running
#      fewer tasks and/or threads per node to give each 
#      process access to more memory.
#
#   -- IMPI and MVAPICH2 both do sensible process pinning by default.
#
#----------------------------------------------------

#SBATCH -J myjob           # Job name
#SBATCH -o myjob.o%j       # Name of stdout output file
#SBATCH -e myjob.e%j       # Name of stderr error file
#SBATCH -p normal          # Queue (partition) name
#SBATCH -N 10              # Total # of nodes 
#SBATCH -n 40              # Total # of mpi tasks
#SBATCH -t 01:30:00        # Run time (hh:mm:ss)
#SBATCH --mail-user=username@tacc.utexas.edu
#SBATCH --mail-type=all    # Send email at begin and end of job
#SBATCH -A myproject       # Allocation name (req'd if you have more than 1)

# Other commands must follow all #SBATCH directives...

module list
pwd
date

# Set thread count (default value is 1)...

export OMP_NUM_THREADS=16

# Launch MPI code... 

ibrun ./mycode.exe         # Use ibrun instead of mpirun or mpiexec

# ---------------------------------------------------```
```

</details>

Your job will run in the environment it inherits at submission time; this environment includes the modules you have loaded and the current working directory. In most cases you should **run your applications(s) after loading the same modules that you used to build them**.  You can of course use your job submission script to modify this environment by defining new environment variables; changing the values of existing environment variables; loading or unloading modules; changing directory; or specifying relative or absolute paths to files. **Do not use the Slurm <span style="white-space: nowrap;">"`--export`"</span> option to manage your job's environment**: doing so can interfere with the way the system propagates the inherited environment.

## [Remote Desktop Access](#remote-desktop-access)

Remote desktop access to Maverick2 is formed through a VNC connection to one or more visualization nodes. Users must first connect to a Maverick2 login node (see System Access) and submit a special interactive batch job that:

*  allocates a set of Maverick2 visualization nodes 
*  starts a vncserver process on the first allocated node 
*  sets up a tunnel through the login node to the vncserver access port 

Once the vncserver process is running on the visualization node and a tunnel through the login node is created, an output message identifies the access port for connecting a VNC viewer. A VNC viewer application is run on the user's remote system and presents the desktop to the user.

Note: If this is your first time connecting to Maverick2, you must run `vncpasswd` to create a password for your VNC servers. This should NOT be your login password! This mechanism only deters unauthorized connections; it is not fully secure, as only the first eight characters of the password are saved. All VNC connections are tunneled through SSH for extra security, as described below.

Follow the steps below to start an interactive session.

1. Start a Remote Desktop 

	TACC has provided a VNC job script (`/share/doc/slurm/job.vnc`) that requests one node in the [`development` queue](#running-queues) for two hours, creating a [VNC](https://en.wikipedia.org/wiki/VNC) session.

	<pre class="cmd-line">login1$ <b>sbatch /share/doc/slurm/job.vnc</b></pre>

	You may modify or overwrite script defaults with `sbatch` command-line options:

	*  "<code>-t <i>hours:minutes:seconds</i></code>" modify the job runtime 
	*  "<code>-A <i>projectnumber</i></code>" specify the project/allocation to be charged 
	*  "<code>-N <i>nodes</i></code>" specify number of nodes needed 
	*  "<code>-p <i>partition</i></code>" specify an alternate queue. 

	<!-- See more `sbatch` options in the [Common `sbatch` Options](#table6) -->

	All arguments after the job script name are sent to the vncserver command. For example, to set the desktop resolution to 1440x900, use:

	<pre class="cmd-line">login1$ <b>sbatch /share/doc/slurm/job.vnc -geometry 1440x900</b></pre>

	The "`vnc.job`" script starts a vncserver process and writes to the output file, "`vncserver.out`" in the job submission directory, with the connect port for the vncviewer. Watch for the "To connect via VNC client" message at the end of the output file, or watch the output stream in a separate window with the commands:

	<pre class="cmd-line">login1$ <b>touch vncserver.out ; tail -f vncserver.out</b></pre>

	The lightweight window manager, `xfce`, is the default VNC desktop and is recommended for remote performance. Gnome is available; to use gnome, open the "`~/.vnc/xstartup`" file (created after your first VNC session) and replace "`startxfce4`" with "`gnome-session`". Note that gnome may lag over slow internet connections.

1. Create an SSH Tunnel to Maverick2 

	TACC requires users to create an SSH tunnel from the local system to the Maverick2 login node to assure that the connection is secure.   The tunnels created for the VNC job operate only on the `localhost` interface, so you must use `localhost` in the port forward argument, not the Maverick2 hostname.  On a Unix or Linux system, execute the following command once the port has been opened on the Maverick2 login node:

	<pre class="cmd-line">
	localhost$ <b>ssh -f -N -L <i>xxxx</i>:localhost:<i>yyyy</i> <i>username</i>@maverick2.tacc.utexas.edu</b></pre>

	where:

	*  "<code><i>yyyy</i></code>" is the port number given by the vncserver batch job 
	*  "<code><i>xxxx</i></code>" is a port on the remote system. Generally, the port number specified on the Maverick2 login node, <code><i>yyyy</i></code>, is a good choice to use on your local system as well 
	*  "`-f`" instructs SSH to only forward ports, not to execute a remote command 
	*  "`-N`" puts the `ssh` command into the background after connecting 
	*  "`-L`" forwards the port 

	On Windows systems find the menu in the Windows SSH client where tunnels can be specified, and enter the local and remote ports as required, then `ssh` to Maverick2.

1. Connecting vncviewer 

	Once the SSH tunnel has been established, use a [VNC client](https://en.wikipedia.org/wiki/Virtual_Network_Computing) to connect to the local port you created, which will then be tunneled to your VNC server on Maverick2. Connect to <code>localhost:<i>xxxx</i></code>, where <code><i>xxxx</i></code> is the local port you used for your tunnel. In the examples above, we would connect the VNC client to <code>localhost::<i>xxxx</i></code>. (Some VNC clients accept <code>localhost:<i>xxxx</i></code>).

	We recommend the [TigerVNC](http://sourceforge.net/projects/tigervnc/) VNC Client, a platform independent client/server application.

	Once the desktop has been established, two initial xterm windows are presented (which may be overlapping). One, which is white-on-black, manages the lifetime of the VNC server process. Killing this window (typically by typing "`exit`" or "`ctrl-D`" at the prompt) will cause the vncserver to terminate and the original batch job to end. Because of this, we recommend that this window not be used for other purposes; it is just too easy to accidentally kill it and terminate the session.

	The other xterm window is black-on-white, and can be used to start both serial programs running on the node hosting the vncserver process, or parallel jobs running across the set of cores associated with the original batch job. Additional xterm windows can be created using the window-manager left-button menu.


## [Software on Maverick2](#software) { #software }

As of January 17, 2023, the following software modules are currently installed on Maverick2. You can discover already installed software using TACC's [Software Search](https://www.tacc.utexas.edu/systems/software) tool or via "`module`" commands e.g., "`module spider`", "`module avail`" to retrieve the most up-to-date listing.

<pre class="cmd-line">login1$ <b>module avail</b>

-------------------- /opt/apps/intel18/impi18_0/modulefiles --------------------
   boost/1.66                     phdf5/1.10.4   (D)
   fftw3/3.3.6                    pnetcdf/1.8.1
   parallel-netcdf/4.3.3.1        python2/2.7.16 (L,D)
   parallel-netcdf/4.6.2   (D)    python3/3.7.0  (D)
   phdf5/1.8.16

------------------------ /opt/apps/intel18/modulefiles -------------------------
   hdf5/1.8.16        mkl-dnn/0.18.1    netcdf/4.3.3.1        python3/3.7.0
   hdf5/1.10.4 (D)    nco/4.6.9         netcdf/4.6.2   (D)    udunits/2.2.25
   impi/18.0.2 (L)    ncview/2.1.7      python2/2.7.16

---------------------------- /opt/apps/modulefiles -----------------------------
   TACC          (L)      git/2.24.1       (L)      mcr/9.6
   autotools/1.2 (L)      hwloc/1.11.2              mcr/9.9                (D)
   cmake/3.8.2            idev/1.5.5                ncl_ncarg/6.3.0
   cmake/3.10.2           intel/16.0.3              nvhpc/21.3.0
   cmake/3.16.1  (L,D)    intel/17.0.4              ooops/1.3
   cuda/10.0     (g)      intel/18.0.2     (L,D)    sanitytool/2.0
   cuda/10.1     (g)      launcher_gpu/1.0          settarg
   cuda/11.0     (g)      lmod                      swr/18.3.3
   cuda/11.3     (g,D)    mathematica/12.0          tacc-singularity/3.7.2
   gcc/5.4.0              matlab/2018b              tacc_tips/0.5
   gcc/6.3.0              matlab/2019a              xalt/2.9.6             (L)
   gcc/7.1.0              matlab/2020b     (D)
   gcc/7.3.0     (D)      mcr/9.5

  Where:
   D:  Default Module
   L:  Module is loaded
   g:  built for GPU</pre>

At this time, with the limited size of the local disks on Maverick2, we are keeping the number of packages supported to a reduced size to accommodate the work done on this system that is not possible or practical on other TACC systems.

Users must provide their own license for commercial packages. TACC will work on a best effort level with any commercial vendors to support that software on the system, but make no guarantee that licences can migrate to our systems or can be supported within the support framework at TACC.

You are welcome to install packages in your own `$HOME` or `$WORK` directories. No super-user privileges are needed, simply use the "`--prefix`" option when configuring then making the package.

### [Deep Learning Packages](#software-ml) { #software-ml }

See: [Tensorflow at TACC][TACCTENSORFLOW]


See the [Remote Desktop Access at TACC][TACCREMOTEDESKTOPACCESS] tutorial to set up a VNC or DCV connection.

### [Building Software](#software-building) { #software-building }

Like Stampede2, Maverick2's default programming environment is based on the Intel compiler and Intel MPI library.  For compiling MPI codes, the familiar commands "`mpicc`", "`mpicxx`", "`mpif90`" and "`mpif77`" are available. Also, the compilers "`icc`", "`icpc`", and "`ifort`" are directly accessible. To access the most recent versions of GCC, load the `gcc` module.

You're welcome to download third-party research software and install it in your own account. Consult the [Stampede2 User Guide][STAMPEDE2UG] for detailed information on [building software](http://portal.tacc.utexas.edu/user-guides/stampede2#building).  

## [Help Desk](#help) { #help }

[TACC Consulting](https://portal.tacc.utexas.edu/consulting/overview) operates from 8am to 5pm CST, Monday through Friday, except for holidays. You can [submit a help desk ticket](https://portal.tacc.utexas.edu/tacc-consulting/-/consult/tickets/create) at any time via the TACC User Portal with &quot;Maverick2&quot; in the Resource field. Help the consulting staff help you by following these best practices when submitting tickets. 

* **Do your homework** before submitting a help desk ticket. What does the user guide and other documentation say? Search the internet for key phrases in your error logs; that's probably what the consultants answering your ticket are going to do. What have you changed since the last time your job succeeded?

* **Describe your issue as precisely and completely as you can:** what you did, what happened, verbatim error messages, other meaningful output. When appropriate, include the information a consultant would need to find your artifacts and understand your workflow: e.g. the directory containing your build and/or job script; the modules you were using; relevant job numbers; and recent changes in your workflow that could affect or explain the behavior you're observing.

* **Subscribe to [Maverick2 User News](https://portal.tacc.utexas.edu/user-news/-/news/Maverick2).** This is the best way to keep abreast of maintenance schedules, system outages, and other general interest items.

* **Have realistic expectations.** Consultants can address system issues and answer questions about Maverick2. But they can't teach parallel programming in a ticket, and may know nothing about the package you downloaded. They may offer general advice that will help you build, debug, optimize, or modify your code, but you shouldn't expect them to do these things for you.

* **Be patient.** It may take a business day for a consultant to get back to you, especially if your issue is complex. It might take an exchange or two before you and the consultant are on the same page. If the admins disable your account, it's not punitive. When the file system is in danger of crashing, or a login node hangs, they don't have time to notify you before taking action.

<figure>
<img alt="A Maverick" src="../../../imgs/2mav/bw-manandhorses.jpg" style="width: 700px; height: 394px; border-width: 1px; border-style: solid;" />
<figcaption><font size=-2>Figure 4. Person and Horse</font>
</figcaption>
</figure>

## [References](#refs) { #refs }

* [`idev` documentation][TACCIDEV]
* [Tensorflow at TACC][TACCTENSORFLOW]
* [TACC Analysis Portal][TACCANALYSISPORTAL]
* [Multi-Factor Authentication at TACC][TACCMFA]

{% include 'aliases.md' %}
