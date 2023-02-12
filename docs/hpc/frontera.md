# Frontera User Guide
<span style="font-size:90%;"><i>Last update: September 15, 2022</i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="https://frontera-portal.tacc.utexas.edu/user-guide/docs/user-guide.pdf">Download PDF <i class="fa fa-file-pdf-o"></i></a></span> editing 01/24/2023

## [Status Updates and Notices](#notices) { #notices }

* **All users: refer to updated [Remote Desktop Access](#remote-desktop-access) instructions.** (07/21/2021)
* **New Queue: A new queue: "`small`" has been created specifically for one and two node jobs**. Jobs of one or two nodes that will run for up to 48 hours should be submitted to this new [`small` queue](#frontera-production-queues).  The `normal` queue now has a lower limit of three nodes for all jobs. These new limits will improve the turnaround time for all jobs in the `normal` and `small` queues. (03-30-21) 
* **Frontera has new [large memory nodes](#large-memory-nodes)**, accessible via the [`nvdimm` queue](#frontera-production-queues). (04/03/20)
* Users now have access to additional [Frontera User Portal](#portal) functionality. **Log in the portal to access your [dashboard](https://frontera-portal.tacc.utexas.edu/workbench/dashboard) and other features.** (03-25-20)
* TACC Staff have put forth new file system and job submission guidelines. **All users: read [Managing I/O on TACC Resources][TACCMANAGINGIO].** (01/09/20)
* **Frontera's [GPU](#gpu-nodes) queues, `rtx` and `rtx-dev` are now open.** See [Frontera's production queues](#frontera-production-queues) for more information. Execute [`qlimits`](#taccs-qlimits-command) to display Frontera's queue configurations and charge rates. (12/07/19)
*  **The [TACC Analysis Portal][TACCANALYSISPORTAL] now supports Frontera job submission for VNC and DCV remote desktops as well as Jupyter Notebook sessions.** We recommend submitting to the `development queue` for fastest turn-around. (12/05/2019)
* **Frontera's `flex` queue is now open.** Jobs in this queue are charged a lower rate (.8 SUs) but are pre-emptable after a guaranteed runtime of at least one hour. (10/30/2019) 
* Please run all your jobs out of the `$SCRATCH` filesystem, instead of `$WORK`, to preserve the stability of the system. (10/10/2019)
* You may now **[subscribe](https://portal.tacc.utexas.edu/news/subscribe) to [Frontera User News](https://portal.tacc.utexas.edu/user-news/-/news/Frontera)**. Stay up-to-date on Frontera's status, scheduled maintenances and other notifications. (10/10/2019) 
* **All users: read the [Good Conduct](#conduct) section.** Frontera is a shared resource and your actions can impact other users. (10/10/2019) 


<figure id="figure1"><img alt="Frontera Art" src="../../imgs/frontera/frontera-art.jpg">
<figcaption></figcaption></figure>

## [Introduction to Frontera](#intro) { #intro } 

Frontera is funded by the National Science Foundation (NSF) through award #1818253, [Computing for the Endless Frontier](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1818253). It is the largest cluster dedicated to open science in the United States and is the Texas Advanced Computing Center's latest flagship system. Frontera enters production in early summer 2019, building on the successes of the Stampede1 and Stampede2 systems.  

Frontera provides a balanced set of capabilities that supports both capability and capacity simulation, data-intensive science, visualization, and data analysis, as well as emerging applications in AI and deep learning. Blue Waters and other cyberinfrastructure users in the open science community will find a familiar programming model and tools in a system that is productive today while serving as a bridge to the exascale future.  

The design is anchored by Intel's top-of-the-line (at deployment) Xeon processor, Cascade Lake © (CLX). With a higher clock rate than other recent HPC processors, Intel's CLX processor delivers effective performance in the most commonly used and accessible programming model used in science applications today. Frontera's multi-tier storage system is designed to enable science at unprecedented scales with nearly 60 PB of Lustre-based storage, including 3 PB of flash storage for data-driven science applications that depend upon fast access to large amounts of data.  

Frontera is also breaking new ground in its support for science applications. During the first six months of operation the system will provide support for users to run jobs using [containers](#containers), immediately making tens of thousands of container-ready applications accessible on Frontera without the need for users to find and build their own versions.  

Following the initial CPU-only rollout, the system will also provide users with access to the latest accelerator cards from NVIDIA with outstanding single-precision support especially targeted for machine-learning workloads. Later this summer a separate system will enter production to provide users with access to the latest double-precision HPC cards from NVIDIA, designed to serve more "traditional" science and engineering simulation needs.   

Frontera's design also includes a totally new integration with web services, and provides users with new options for data storage and access to emerging computer technologies. The award includes an innovative partnership with the three major commercial cloud providers, Google, Amazon and Microsoft, to provide users with additional high-integrity storage, sustainable archive options, and to keep the project regularly refreshed with novel computing technologies. 

## [Quickstart for Experienced Users](#quickstart) { #quickstart }

<p class="introtext">Experienced HPC/TACC users will be very familiar with many of the topics presented in this guide. Here we'll highlight some sections for a quick start on Frontera.</p>

* Log into the [TACC User Portal](http://portal.tacc.utexas.edu) to confirm that [you've been added to a Frontera allocation](https://portal.tacc.utexas.edu/projects-and-allocations#). Then, connect via SSH to `frontera.tacc.utexas.edu`.
* Review the TACC info box displayed at login for your allocation availability and SU balances.
* Read the [Good Conduct](../conduct) section. Frontera is a **shared** resource and this section covers practices and etiquette to keep your account in good standing and keep Frontera's systems running smoothly for all users.
* Consult the [Frontera File Systems](../files) and [Frontera Production Queues](../running#frontera-production-queues) tables. These should be near identical to the structure used on other TACC systems but there are a few minor changes you will want to take note of. 
* Copy and modify any of the [Sample Job Scripts](../scripts) for your own use. These scripts will also be helpful to show you how to modify any Jobs Scripts you are bringing over from other TACC systems so that they run efficiently on Frontera. 
* Review the [default modules with "`module list`"](../admin/#using-modules-to-manage-your-environment). Make any changes needed for your code. 
* Start small. Run any jobs from other systems on a smaller scale in order to test the performance of your code on Frontera. You may find your code needs to be altered or recompiled in order to perform well and at scale on the new system. 

## [Account Administration](#admin) { #admin }

<!-- p class="introtext">Discuss account status, account configuration.</p -->

### [Setting up Your Account](#admin-account) { #admin-account }

#### [Check your Allocation Status](#admin-account-allocation) { #admin-account-allocation }

**You must be added to a Frontera allocation in order to have access/login to Frontera.** The ability to log on to the TACC User Portal does NOT signify access to Frontera or any TACC resource. Submit Frontera allocations requests via [TACC's Resource Allocation System](https://tacc-submit.xras.org/). Continue to [manage your allocation's users](https://portal.tacc.utexas.edu/projects-and-allocations#) via the TACC User Portal. 

#### [Multi-Factor Authentication](#admin-account-mfa) { #admin-account-mfa }

Access to all TACC systems now requires Multi-Factor Authentication (MFA). You can create an MFA pairing on the TACC User Portal. After login on the portal, go to your account profile (Home->Account Profile), then click the "Manage" button under "Multi-Factor Authentication" on the right side of the page. See [Multi-Factor Authentication at TACC][TACCMFA] for further information. 

#### [Password Management](#admin-account-password) { #admin-account-password }

Use your TACC User Portal password for direct logins to TACC resources. You can change your TACC password through the [TACC User Portal][TACCUSERPORTAL]. Log into the portal, then select "Change Password" under the "HOME" tab. If you've forgotten your password, go to the [TACC User Portal](http://portal.tacc.utexas.edu/) home page and select "Password Reset" under the Home tab.


### [Access the System](#admin-access) { #admin-access }

#### [Secure Shell (SSH)](#admin-access-ssh)

The "`ssh`" command (SSH protocol) is the standard way to connect to Frontera. SSH also includes support for the file transfer utilities `scp` and `sftp`. [Wikipedia](https://en.wikipedia.org/wiki/Secure_Shell) is a good source of information on SSH. SSH is available within Linux and from the terminal app in the Mac OS. If you are using Windows, you will need an SSH client that supports the SSH-2 protocol: e.g. [Bitvise](http://www.bitvise.com), [OpenSSH](http://www.openssh.com), [PuTTY](http://www.putty.org), or [SecureCRT](https://www.vandyke.com/products/securecrt/). Initiate a session using the `ssh` command or the equivalent; from the Linux command line the launch command looks like this:

<pre class="cmd-line">localhost$ <b>ssh <i>username</i>@frontera.tacc.utexas.edu</b></pre>

The above command will rotate connections across all available login nodes, `login1-login4`, and route your connection to one of them. To connect to a specific login node, use its full domain name:

<pre class="cmd-line">localhost$ <b>ssh <i>username</i>@login2.frontera.tacc.utexas.edu</b></pre>

To connect with X11 support on Frontera (usually required for applications with graphical user interfaces), use the <span style="white-space: nowrap;">"`-X`"</span> or <span style="white-space: nowrap;">"`-Y`"</span> switch:

<pre class="cmd-line">localhost$ <b>ssh -X <i>username</i>@frontera.tacc.utexas.edu</b></pre>

To report a connection problem, execute the `ssh` command with the "`-vvv`" option and include the verbose output when submitting a help ticket.

**Do not run the "`ssh-keygen`" command on Frontera.** This command will create and configure a key pair that will interfere with the execution of job scripts in the batch system. If you do this by mistake, you can recover by renaming or deleting the `.ssh` directory located in your home directory; the system will automatically generate a new one for you when you next log into Frontera.

1. execute "`mv .ssh dot.ssh.old`" 
1. log out
1. log into Frontera again

After logging in again the system will generate a properly configured key pair.

Regardless of your research workflow, <b>you’ll need to master Linux basics</b> and a Linux-based text editor (e.g. `emacs`, `nano`, `gedit`, or `vi/vim`) to use the system properly. However, this user guide does not address these topics. There are numerous resources in a variety of formats that are available to help you learn Linux, including some listed on the <a href="https://portal.tacc.utexas.edu/training/course-materials">TACC</a> and training sites. If you encounter a term or concept in this user guide that is new to you, a quick internet search should help you resolve the matter quickly.

### [Configuring Your Account](#admin-configuring) { #admin-configuring }

#### [Linux Shell](#admin-configuring-shell) { #admin-configuring-shell }

The default login shell for your user account is Bash. To determine your current login shell, execute: 

<pre class="cmd-line">$ <b>echo $SHELL</b></pre>

If you'd like to change your login shell to `csh`, `sh`, `tcsh`, or `zsh`, submit a ticket through the [TACC](http://portal.tacc.utexas.edu/) portal. The `chsh` ("change shell") command will not work on TACC systems. 

When you start a shell on Frontera, system-level startup files initialize your account-level environment and aliases before the system sources your own user-level startup scripts. You can use these startup scripts to customize your shell by defining your own environment variables, aliases, and functions. These scripts (e.g. `.profile` and `.bashrc`) are generally hidden files: so-called dotfiles that begin with a period, visible when you execute: <span style="white-space: nowrap;">`ls -a`</span>.

Before editing your startup files, however, it's worth taking the time to understand the basics of how your shell manages startup. Bash startup behavior is very different from the simpler `csh` behavior, for example. The Bash startup sequence varies depending on how you start the shell (e.g. using `ssh` to open a login shell, executing the `bash` command to begin an interactive shell, or launching a script to start a non-interactive shell). Moreover, Bash does not automatically source your `.bashrc` when you start a login shell by using `ssh` to connect to a node. Unless you have specialized needs, however, this is undoubtedly more flexibility than you want: you will probably want your environment to be the same regardless of how you start the shell. The easiest way to achieve this is to execute <span style="white-space: nowrap;">`source ~/.bashrc`</span> from your `.profile`, then put all your customizations in `.bashrc`. The system-generated default startup scripts demonstrate this approach. We recommend that you use these default files as templates.

For more information see the [Bash Users' Startup Files: Quick Start Guide][TACCBASHQUICKSTART] and other online resources that explain shell startup. To recover the originals that appear in a newly created account, execute <span style="white-space: nowrap;">`/usr/local/startup_scripts/install_default_scripts`</span>.

#### [Environment Variables](#admin-configuring-envvars) { #admin-configuring-envvars }

Your environment includes the environment variables and functions defined in your current shell: those initialized by the system, those you define or modify in your account-level startup scripts, and those defined or modified by the [modules](#using-modules-to-manage-your-environment) that you load to configure your software environment. Be sure to distinguish between an environment variable's name (e.g. `HISTSIZE`) and its value (`$HISTSIZE`). Understand as well that a sub-shell (e.g. a script) inherits environment variables from its parent, but does not inherit ordinary shell variables or aliases. Use `export` (in Bash) or `setenv` (in `csh`) to define an environment variable.

Execute the `env` command to see the environment variables that define the way your shell and child shells behave. 

Pipe the results of `env` into `grep` to focus on specific environment variables. For example, to see all environment variables that contain the string GIT (in all caps), execute:

<pre class="cmd-line">$ <b>env | grep GIT</b></pre>

The environment variables `PATH` and `LD_LIBRARY_PATH` are especially important. `PATH` is a colon-separated list of directory paths that determines where the system looks for your executables. `LD_LIBRARY_PATH` is a similar list that determines where the system looks for shared libraries.

#### [Account-Level Diagnostics](#admin-configuring-diagnostics) { #admin-configuring-diagnostics }

TACC's `sanitytool` module loads an account-level diagnostic package that detects common account-level issues and often walks you through the fixes. You should certainly run the package's `sanitycheck` utility when you encounter unexpected behavior. You may also want to run `sanitycheck` periodically as preventive maintenance. To run `sanitytool`'s account-level diagnostics, execute the following commands:

<pre class="cmd-line">login1$ <b>module load sanitytool</b>
login1$ <b>sanitycheck</b></pre>

Execute `module help sanitytool` for more information.

#### [Using Modules to Manage your Environment](#admin-configuring-modules) { #admin-configuring-modules }

[Lmod](https://www.tacc.utexas.edu/research-development/tacc-projects/lmod), a module system developed and maintained at TACC, makes it easy to manage your environment so you have access to the software packages and versions that you need to conduct your research. This is especially important on a system like Frontera that serves thousands of users with an enormous range of needs. Loading a module amounts to choosing a specific package from among available alternatives:

<pre class="cmd-line">
$ <b>module load intel</b>          # load the default Intel compiler v19.0.4
$ <b>module load intel/18.0.5</b>   # load a specific version of the Intel compiler</pre>
</pre>

A module does its job by defining or modifying environment variables (and sometimes aliases and functions). For example, a module may prepend appropriate paths to `$PATH` and `$LD_LIBRARY_PATH` so that the system can find the executables and libraries associated with a given software package. The module creates the illusion that the system is installing software for your personal use. Unloading a module reverses these changes and creates the illusion that the system just uninstalled the software:

<pre class="cmd-line">$ <b>module load   ddt</b>  # defines DDT-related env vars; modifies others
$ <b>module unload ddt</b>  # undoes changes made by load</pre>

The module system does more, however. When you load a given module, the module system can automatically replace or deactivate modules to ensure the packages you have loaded are compatible with each other. In the example below, the module system automatically unloads one compiler when you load another, and replaces Intel-compatible versions of IMPI and FFTW3 with versions compatible with gcc:

<pre class="cmd-line">
$ <b>module load intel</b>  # load default version of Intel compiler
$ <b>module load fftw3</b>  # load default version of fftw3
$ <b>module load gcc</b>    # change compiler

Lmod is automatically replacing "intel/19.0.4" with "gcc/9.1.0".

Inactive Modules:
  1) python2

Due to MODULEPATH changes, the following have been reloaded:
  1) fftw3/3.3.8     2) impi/19.0.4</pre>

On Frontera, modules generally adhere to a TACC naming convention when defining environment variables that are helpful for building and running software. For example, the `papi` module defines `TACC_PAPI_BIN` (the path to PAPI executables), `TACC_PAPI_LIB` (the path to PAPI libraries), `TACC_PAPI_INC` (the path to PAPI include files), and `TACC_PAPI_DIR` (top-level PAPI directory). After loading a module, here are some easy ways to observe its effects:

<pre class="cmd-line">$ <b>module show papi</b>   # see what this module does to your environment
$ <b>env | grep PAPI</b>    # see env vars that contain the string PAPI
$ <b>env | grep -i papi</b> # case-insensitive search for 'papi' in environment</pre>

To see the modules you currently have loaded:

<pre class="cmd-line">$ <b>module list</b></pre>

To see all modules that you can load right now because they are compatible with the currently loaded modules:

<pre class="cmd-line">$ <b>module avail</b></pre>

To see all installed modules, even if they are not currently available because they are incompatible with your currently loaded modules:

<pre class="cmd-line">$ <b>module spider</b>   # list all modules, even those not available to load</pre>

To filter your search:

<pre class="cmd-line">
$ <b>module spider slep</b>             # all modules with names containing 'slep'
$ <b>module spider sundials/2.5.1</b>   # additional details on a specific module</pre>

Among other things, the latter command will tell you which modules you need to load before the module is available to load. You might also search for modules that are tagged with a keyword related to your needs (though your success here depends on the diligence of the module writers). For example:

<pre class="cmd-line">
$ <b>module keyword performance</b></pre>

You can save a collection of modules as a personal default collection that will load every time you log into Frontera. To do so, load the modules you want in your collection, then execute:

<pre class="cmd-line">
$ <b>module save</b>    # save the currently loaded collection of modules </pre>

Two commands make it easy to return to a known, reproducible state:

<pre class="cmd-line">
$ <b>module reset</b>   # load the system default collection of modules
$ <b>module restore</b> # load your personal default collection of modules</pre>

On TACC systems, the command `module reset` is equivalent to `module purge; module load TACC`. It's a safer, easier way to get to a known baseline state than issuing the two commands separately.

Help text is available for both individual modules and the module system itself:

<pre class="cmd-line">
$ <b>module help swr</b>     # show help text for software package swr
$ <b>module help</b>         # show help text for the module system itself</pre>

See [Lmod's online documentation](http://lmod.readthedocs.org) for more extensive documentation. The online documentation addresses the basics in more detail, but also covers several topics beyond the scope of the help text (e.g. writing and using your own module files).

It's safe to execute module commands in job scripts. In fact, this is a good way to write self-documenting, portable job scripts that produce reproducible results. If you use <span style="white-space: nowrap;">`module save`</span> to define a personal default module collection, it's rarely necessary to execute module commands in shell startup scripts, and it can be tricky to do so safely. If you do wish to put module commands in your startup scripts, see Frontera's default startup scripts for a safe way to do so.

## [Frontera User Portal](#portal) { #portal }

<!-- p class="introtext">The Frontera project team is pleased to announce the release of new <a href="https://frontera-portal.tacc.utexas.edu/workbench/dashboard">Dashboard</a> functionality within the Frontera User Portal. Upon login, click on your name in the upper right corner to access your Frontera dashboard and account settings. </p -->

<p class="introtext">Explore the Frontera User Portal's <a href="https://frontera-portal.tacc.utexas.edu/workbench/dashboard">Dashboard</a> functionality. Upon logging into the portal, click on your name in the upper right corner to access your Frontera dashboard and account settings. </p>


The Frontera Dashboard displays provides an snapshot of your Frontera status and environement: 
 
* System status
* Your jobs' status - running, queued, etc.
* Create and manage your support tickets
* Navigation to additional information
 
The navigation menu currently enables you access to additional information.
 
* Data Files: manage the contents of your Frontera `/home` directory
* Applications: Jupyter and the TACC Visualization Portal
* Allocations: allocation management and your active and expired projects and allocations
 
## [Good Conduct on Frontera](#conduct) { #conduct }

<p class="introtext"><b>You share Frontera with many, sometimes hundreds, of other users</b>, and what you do on the system affects others. All users must follow a set of good practices which entail limiting activities that may impact the system for other users. Exercise good conduct to ensure that your activity does not adversely impact the system and the research community with whom you share it. </p>

TACC staff has developed the following guidelines to good conduct on Frontera. Please familiarize yourself especially with the first two mandates. The next sections discuss best practices on [limiting and minimizing I/O activity](#limit-inputoutput-io-activity) and [file transfers](#limit-file-transfers). And finally, we provide [job submission tips](#job-submission-tips) when constructing job scripts to help minimize wait times in the queues.  

* [Do Not Run Jobs on the Login Nodes](#do-not-run-jobs-on-the-login-nodes)
* [Do Not Stress the File Systems](#do-not-stress-the-shared-file-systems)
* [Limit Input/Output (I/O) Activity](#limit-inputoutput-io-activity)
* [File Transfer Guideliones](#file-transfer-guidelines)
* [Job Submission Tips](#job-submission-tips)

### [Do Not Run Jobs on the Login Nodes](#conduct-loginnodes) { #conduct-loginnodes }

Frontera's few login nodes are shared among all users. Dozens, (sometimes hundreds) of users may be logged on at one time accessing the file systems. Think of the login nodes as a prep area, where users may edit and manage files, compile code, perform file management, issue transfers, submit new and track existing batch jobs etc. The login nodes provide an interface to the "back-end" compute nodes. 

The compute nodes are where actual computations occur and where research is done. Hundreds of jobs may be running on all compute nodes, with hundreds more queued up to run. All batch jobs and executables, as well as development and debugging sessions, must be run on the compute nodes. To access compute nodes on TACC resources, one must either [submit a job to a batch queue](../running#sbatch) or initiate an interactive session using the [`idev`](https://portal.tacc.utexas.edu/software/idev) utility. 

A single user running computationally expensive or disk intensive task/s will negatively impact performance for other users. Running jobs on the login nodes is one of the fastest routes to account suspension. Instead, run on the compute nodes via an interactive session ([`idev`](https://portal.tacc.utexas.edu/software/idev) or by [submitting a batch job](../running).

<p class="portlet-msg-alert">Do not run jobs or perform intensive computational activity on the login nodes or the shared file systems.<br>Your account may be suspended and you will lose access to the queues if your jobs are impacting other users.</p> 

#### [Dos &amp; Don'ts on the Login Nodes](#conduct-loginnodes-examples) { #conduct-loginnodes-examples }

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
		
	DO NOT DO THIS: Invoke multiple build sessions.
	
	<pre class="cmd-line">login1$ <s><b>make -j 12</b></s></pre>

	DO NOT DO THIS: Run an executable on a login node.
	
	<pre class="cmd-line">
	login1$ <s><b>./myprogram</b></s></pre>

* **That script you wrote to poll job status should probably do so once every few minutes rather than several times a second.**


### [Do Not Stress the Shared File Systems](#conduct-filesystems) { #conduct-filesystems }

The TACC Global Shared File System, Stockyard, is mounted on most TACC HPC resources as the `/work` (`$WORK`) directory. This file system is accessible to all TACC users, and therefore experiences a lot of I/O activity (reading and writing to disk, opening and closing files) as users run their jobs, read and generate data including intermediate and checkpointing files. As TACC adds more users, the stress on the `$WORK` file system is increasing to the extent that TACC staff is now recommending new job submission guidelines in order to reduce stress and I/O on Stockyard. 

**TACC staff now recommends that you run your jobs out of the `$SCRATCH` file system instead of the global `$WORK` file system.** 

To run your jobs out `$SCRATCH`:

* Copy or move all job input files to `$SCRATCH` 
* Make sure your job script directs all output to `$SCRATCH`  
* Once your job is finished, move your output files to `$WORK` to avoid any data purges.

<p class="portlet-msg-alert">Compute nodes should not reference <code>$WORK</code> unless it's to stage data in or out, and only before or after jobs.</p> 

Consider that `$HOME` and `$WORK` are for storage and keeping track of important items. Actual job activity, reading and writing to disk, should be offloaded to your resource's `$SCRATCH` file system (see [File System Usage Recommendations](#table-file-system-usage-recommendations). You can start a job from anywhere but the actual work of the job should occur only on the `$SCRATCH` partition. You can save original items to `$HOME` or `$WORK` so that you can copy them over to `$SCRATCH` if you need to re-generate results.


#### [More File System Tips](#conduct-filesystems-tips) { #conduct-filesystems-tips }

* **Don't run jobs in your `$HOME` directory.** The `$HOME` file system is for routine file management, not parallel jobs.

* **Watch all your [file system quotas](../files).** If you're near your quota in `$WORK` and your job is repeatedly trying (and failing) to write to `$WORK`, you will stress that file system. If you're near your quota in `$HOME`, jobs run on any file system may fail, because all jobs write some data to the hidden `$HOME/.slurm` directory.

* **Avoid storing many small files in a single directory, and avoid workflows that require many small files**. A few hundred files in a single directory is probably fine; tens of thousands is almost certainly too many. If you must use many small files, group them in separate directories of manageable size.

* TACC resources, with a few exceptions, mount three file systems: `/home`, `/work` and `/scratch`. **Please follow each file system's recommended usage.**

#### [File System Usage Recommendations](#conduct-filesystems-usage) { #conduct-filesystems-usgae }

| File System | Best Storage Practices | Best Activities
| --          | --                     | --
| <code>$HOME</code> | cron jobs<br>small scripts<br>environment settings | compiling, editing
| <code>$WORK</code> | store software installations<br> original datasets that can't be reproduced<br> job scripts and templates | staging datasets
| <code>$SCRATCH</code> | <b>Temporary Storage</b><br>I/O files<br>job files<br>temporary datasets | all job I/O activity<br>see TACC's <a href="../files#scratchpolicy">Scratch File System Purge Policy</a>.


### [Limit Input/Output (I/O) Activity](#conduct-io) { #conduct-io }

In addition to the file system tips above, it's important that your jobs limit all I/O activity. This section focuses on ways to avoid causing problems on each resources' shared file systems. 

* **Limit I/O intensive sessions** (lots of reads and writes to disk, rapidly opening or closing many files)

* **Avoid opening and closing files repeatedly** in tight loops. Every open/close operation on the file system requires interaction with the MetaData Service (MDS). The MDS acts as a gatekeeper for access to files on Lustre's parallel file system. Overloading the MDS will affect other users on the system. If possible, open files once at the beginning of your program/workflow, then close them at the end.

* **Don't get greedy.** If you know or suspect your workflow is I/O intensive, don't submit a pile of simultaneous jobs. Writing restart/snapshot files can stress the file system; avoid doing so too frequently. Also, use the `hdf5` or `netcdf` libraries to generate a single restart file in parallel, rather than generating files from each process separately.

<p class="portlet-msg-alert">If you know your jobs will require significant I/O, please submit a support ticket and an HPC consultant will work with you. See also <a href="https://portal.tacc.utexas.edu/tutorials/managingio">Managing I/O on TACC Resources</a> for additional information.</p>

### [File Transfer Guidelines](#conduct-transfers) { #conduct-transfers }

In order to not stress both internal and external networks, be mindful of the following guidelines:

* When creating or transferring **large files** to Stockyard (`$WORK`) or the `$SCRATCH` file systems, **be sure to stripe the receiving directories appropriately**. See STRIPING for more information.

* **Avoid too many simultaneous file transfers**. You share the network bandwidth with other users; don't use more than your fair share. Two or three concurrent `scp` sessions is probably fine. Twenty is probably not.

* **Avoid recursive file transfers**, especially those involving many small files. Create a tar archive before transfers. This is especially true when transferring files to or from [Ranch][RANCHUG].



### [Job Submission Tips](#conduct-jobs) { #conduct-jobs }

* **Request Only the Resources You Need** Make sure your job scripts request only the resources that are needed for that job. Don't ask for more time or more nodes than you really need. The scheduler will have an easier time finding a slot for a job requesting 2 nodes for 2 hours, than for a job requesting 4 nodes for 24 hours. This means shorter queue waits times for you and everybody else.

* **Test your submission scripts.** Start small: make sure everything works on 2 nodes before you try 20. Work out submission bugs and kinks with 5 minute jobs that won't wait long in the queue and involve short, simple substitutes for your real workload: simple test problems; <span style="white-space: nowrap;">`hello world`</span> codes; one-liners like <span style="white-space: nowrap;">`ibrun hostname`</span>; or an `ldd` on your executable.

* **Respect memory limits and other system constraints.** If your application needs more memory than is available, your job will fail, and may leave nodes in unusable states. Use TACC's [Remora](https://portal.tacc.utexas.edu/software/remora) tool to monitor your application's needs. 

## [System Architecture](#system) { # }

<p class="introtext">Frontera has two computing subsystems, a primary computing system focused on double precision performance, and a second subsystem focused on single precision streaming-memory computing. Frontera also has multiple storage systems, as well as interfaces to cloud and archive systems, and a set of application nodes for hosting virtual servers.</p>

<figure id="figurex">
<img src="../../imgs/frontera/Ecosystem-Graphic.png" style="width:800px">
<figcaption></figcaption></figure>

### [Cascade Lake (CLX) Compute Nodes](#system) { # }

Frontera hosts 8,368 Cascade Lake (CLX) compute nodes contained in 101 racks. 

#### [Table 4. CLX Specifications](#system) { # }

Model       | Intel Xeon Platinum 8280 ("Cascade Lake")
----------- | ------------
Total cores per CLX node: | 56 cores on two sockets (28 cores/socket)
Hardware threads per core: | 1 <span style="color:red">*Hyperthreading is not currently enabled on Frontera*</span>
Clock rate: | 2.7GHz nominal 
RAM:        | 192GB (2933 MT/s) DDR4
Cache: | 32KB L1 data cache per core;<br>1MB L2 per core;<br>38.5 MB L3 per socket.<br>Each socket can cache up to 66.5 MB (sum of L2 and L3 capacity).
Local storage: | 144GB /tmp partition on a 240GB SSD.

### [Large Memory Nodes](#system) { # }

Frontera hosts 16 large memory nodes featuring 2.1TB of Optane memory. Access these nodes via the [`nvdimm` queue](../running#frontera-production-queues).

#### [Table 5. Large Memory Nodes ](#system) { # }

Model | Intel Xeon Platinum 8280M ("Cascade Lake")
----------- | ------------
Total cores per CLX node:	| 112 cores on four sockets (28 cores/socket)
Hardware threads per core:	| 1 <span style="color:red">*Hyperthreading is not currently enabled on Frontera*</span>
Clock rate:	| 2.7GHz nominal
Memory:	| **2.1 TB NVDIMM**
Cache:	| 32KB L1 data cache per core;<br> 1MB L2 per core;<br> 38.5 MB L3 per socket.<br>384 GB DDR4 RAM configured as an L4 cache<br>Each socket can cache up to 66.5 MB (sum of L2 and L3 capacity).
Local storage: | 144GB /tmp partition on a 240GB SSD<br> 4x 833 GB /mnt/fsdax[0,1,2,3] partitions on NVDIMM<br> 3.2 TB usable local storage

### [GPU Nodes](#system) { # }

Frontera hosts 90 GPU nodes contained in 4 Green Revolution Cooling ICEraQ racks. Access these nodes via the [`rtx` and `rtx-dev` queues](../running#frontera-production-queues).

#### [Table 6. Frontera GPU node specifications](#system) { # }

Feature                          | Specifications
------------------------         | ------------------------------------
Accelerators:                    | 4 NVIDIA Quadro RTX 5000 / node
CUDA Parallel Processing Cores:  | 3072 / card
NVIDIA Tensor Cores:             | 384 / card
GPU Memory:                      | 16GB GDDR6 / card
CPUs:                            | 2 Intel Xeon E5-2620 v4 (“Broadwell”)
RAM:                             | 128GB (2133 MT/s) DDR4
Local storage:                   | 144GB /tmp partition on a 240GB SSD.

### [Login Nodes](#system) { # }

Frontera's four login nodes are Intel Xeon Platinum 8280 ("Cascade Lake") nodes with 56 cores and 192 GB of RAM. The login nodes are configured similarly to the compute nodes. However, since these nodes are shared, limits are enforced on memory usage and number of processes. Please use the login node for file management, compilation, and data movement. Any computing should be done within a batch job or an interactive session on compute nodes.

### [Network](#system) { # }

The interconnect is based on Mellanox HDR technology with full HDR (200 Gb/s) connectivity between the switches and HDR100 (100 Gb/s) connectivity to the compute nodes. A fat tree topology employing six core switches connects the compute nodes and the `$HOME` and `$SCRATCH` filesystems. There are two 40-port leaf switches in each rack. Half of the nodes in a rack (44) connect to 22 downlinks of a leaf switch as pairs of HDR100 (100 Gb/s) links into HDR200 (200 Gb/s) ports of the leaf switch. The other 18 ports are uplinks to the six cores switches. The disparity in the number of uplinks and downlinks creates an oversubscription of 22/18.


## [Managing Files on Frontera](#files) { #files }

Frontera mounts three Lustre file systems that are shared across all nodes: the home, work, and scratch file systems. Frontera also contains a fourth file system, <code>FLASH</code>, supporting applications with very high bandwidth or IOPS requirements.


### [File Systems](#files-filesystems) { #files-filesystems } 

Frontera's startup mechanisms define corresponding account-level environment variables <code>$HOME</code>, <code>$SCRATCH</code> and <code>$WORK</code><!--,and <code>$FASTIO</code>--> that store the paths to directories that you own on each of these file systems. Consult the <a href="#table-2-frontera-file-systems">Frontera File Systems</a> table below for the basic characteristics of these file systems, <!--"File Operations: I/O Performance" for advice on performance issues,--> and the <a href="../conduct">Good Conduct</a> sections for guidance on file system etiquette.</p>

#### [Table 2. Frontera File Systems](#table2) { #table2 } 

File System | Quota | Key Features
-------     | ------- | -------
`$HOME`	    | 25GB, 400,000 files          | **Not intended for parallel or high-intensity file operations**.<br>Backed up regularly.<br>Defaults: 1 stripe, 1MB stripe size.<br> Not purged. |
`$WORK`	    | 1TB, 3,000,000 files across all TACC systems,<br>regardless of where on the file system the files reside. | **Not intended for high-intensity file operations or jobs involving very large files.**<br>On the Global Shared File System that is mounted on most TACC systems.<br>Defaults: 1 stripe, 1MB stripe size.<br>Not backed up.<br> Not purged.
`$SCRATCH`  | no quota	 |  Overall capacity 44 PB.<br>Defaults: 1 stripe, 1MB stripe size.<br>Not backed up.<br>Decomposed into three separate file systems, `scratch1`, `scratch2`, and `scratch3` described below.<br>**Files are [subject to purge](#scratch-purge-policy) if access time&#42; is more than 10 days old**.  

All new projects are assigned to `/scratch1` as their default `$SCRATCH` file system.  After running on Frontera, TACC staff may reassign users and projects to `/scratch2` or `/scratch3` depending on the resources required by their workflow.  The `/scratch3` file system employs twice as many OST's offering twice the available I/O bandwidth of `/scratch1` and `/scratch2`.  Frontera's three `$SCRATCH` file systems are further described below:

#### [Table 2a. Scratch File Systems](#table2a) { #table2a } 

File System | Characteristics	| Purpose |
---         | ---               | ---     |
`/scratch1` | Size:	 10.6 PB <br>OSTs:	16 <br>Bandwidth: 60 GB/s  | Default scratch file system.
`/scratch2` | Size:	 10.6 PB <br>OSTs:	16 <br>Bandwidth: 60 GB/s  | Designated for workflows with intensive I/O operations.
`/scratch3` | Size:	 21.2 PB <br>OSTs:	32 <br>Bandwidth: 120 GB/s | Designated for workflows with large scale parallel I/O operations.

### [Scratch Purge Policy](#scratchpurgepolicy) { #scratchpurgepolicy } 

<p class="portlet-msg-info">The <code>$SCRATCH</code> file system, as its name indicates, is a temporary storage space.  Files that have not been accessed&#42; in ten days are subject to purge.  Deliberately modifying file access time (using any method, tool, or program) for the purpose of circumventing purge policies is prohibited.</p>

&#42;The operating system updates a file's access time when that file is modified on a login or compute node or any time that file is read. Reading or executing a file/script will update the access time.  Use the <span style="white-space: nowrap;">"`ls -ul`"</span> command to view access times.



### [Navigating the Shared File Systems](#files-navigating) { #files-navigating } 

Frontera's `/home` and `/scratch` file systems are mounted only on Frontera, but the work file system mounted on Frontera is the Global Shared File System hosted on [Stockyard](https://www.tacc.utexas.edu/systems/stockyard). Stockyard is the same work file system that is currently available on Stampede2, Lonestar5, and several other TACC resources. 

The `$STOCKYARD` environment variable points to the highest-level directory that you own on the Global Shared File System. The definition of the `$STOCKYARD` environment variable is of course account-specific, but you will see the same value on all TACC systems that provide access to the Global Shared File System. This directory is an excellent place to store files you want to access regularly from multiple TACC resources.

Your account-specific `$WORK` environment variable varies from system to system and is a sub-directory of `$STOCKYARD` ([Figure 3](#figure-3-stockyard-file-system)). The sub-directory name corresponds to the associated TACC resource. The `$WORK` environment variable on Frontera points to the `$STOCKYARD/stampede2` subdirectory, a convenient location for files you use and jobs you run on Frontera. Remember, however, that all subdirectories contained in your `$STOCKYARD` directory are available to you from any system that mounts the file system. If you have accounts on both Frontera and Stampede2, for example, the `$STOCKYARD/frontera` directory is available from your Stampede2 account, and `$STOCKYARD/stampede2` is available from your Frontera account. 

<p class="portlet-msg-alert">Your quota and reported usage on the Global Shared File System reflects all files that you own on Stockyard, regardless of their actual location on the file system.</p>

See the example for fictitious user `bjones` in the figure below. All directories are accessible from all systems, however a given sub-directory (e.g. `lonestar5`, `stampede2`) will exist **only** if you have an allocation on that system.

#### [Figure 3. Stockyard File System](#figure3) { #figure3 } 
<figure id="figure3"><img alt="Stockyard File System" src="../../imgs/stockyard-2022.jpg"> 
<figcaption></figcaption></figure>

**Figure 3.** Account-level directories on the work file system (Global Shared File System hosted on Stockyard). Example for fictitious user `bjones`. All directories usable from all systems. Sub-directories (e.g. `lonestar5`, `stampede2`) exist only if you have allocations on the associated system.

Note that resource-specific subdirectories of `$STOCKYARD` are simply convenient ways to manage your resource-specific files. You have access to any such subdirectory from any TACC resources. If you are logged into Frontera, for example, executing the alias `cdw` (equivalent to <span style="white-space: nowrap;">`cd $WORK`</span>) will take you to the resource-specific subdirectory `$STOCKYARD/frontera`. But you can access this directory from other TACC systems as well by executing <span style="white-space: nowrap;">`cd $STOCKYARD/frontera`</span>. These commands allow you to share files across TACC systems. In fact, several convenient account-level aliases make it even easier to navigate across the directories you own in the shared file systems:

#### [Table 3. Built-in Account Level Aliases](#table3) { #table3 } 

Alias | Command
---- | ----
<code>cd</code> or <code>cdh</code> | <code>cd $HOME</code>
<code>cdw</code> | <code>cd $WORK</code>
<code>cds</code> | <code>cd $SCRATCH</code>
<code>cdy</code> or <code>cdg</code> | <code>cd $STOCKYARD</code>


<p> &nbsp;</p> 

### [Striping Large Files](#files-striping) { #files-striping } 

Frontera's Lustre file systems look and act like a single logical hard disk, but are actually sophisticated integrated systems involving many physical drives. Lustre can **stripe** (distribute) large files over several physical disks, making it possible to deliver the high performance needed to service input/output (I/O) requests from hundreds of users across thousands of nodes. Object Storage Targets (OSTs) manage the file system's spinning disks: a file with 16 stripes, for example, is distributed across 16 OSTs. One designated Meta-Data Server (MDS) tracks the OSTs assigned to a file, as well as the file's descriptive data.

<p class="portlet-msg-alert">Before transferring to, or creating large files on Frontera, be sure to set an appropriate default stripe count on the receiving directory.</p>

While the `$WORK` file system has hundreds of OSTs, Frontera's scratch system has far fewer. Therefore, the recommended stripe counts when transferring or creating large files depends on the file's destination. 

* **Transferring to `$WORK`**: A good rule of thumb is to allow at least one stripe for each 100GB in the file. For example, to set the default stripe count on the current directory to 30 (a plausible stripe count for a directory receiving a file approaching 3TB in size), execute:

	<pre class="cmd-line">$ <b>lfs setstripe -c 30 $PWD</b></pre>

* **Transferring to Frontera's `$SCRATCH` file system**: The rule of thumb still applies, but limit the stripe count to no more than 16 since Frontera's `$SCRATCH` file system is served by far fewer OSTs. 

	<pre class="cmd-line">$ <b>lfs setstripe -c 16 $PWD</b></pre>

Note that an "`lfs setstripe`" command always sets both stripe count and stripe size, even if you explicitly specify only one or the other. Since the example above does not explicitly specify stripe size, the command will set the stripe size on the directory to Frontera's system default (1MB). In general there's no need to customize stripe size when creating or transferring files.

Remember that it's not possible to change the striping on a file that already exists. Moreover, the "`mv`" command has no effect on a file's striping if the source and destination directories are on the same file system. You can, of course, use the "`cp`" command to create a second copy with different striping; to do so, copy the file to a directory with the intended stripe parameters.

You can check the stripe count of a file using the "`lfs getstripe`" command:

<pre class="cmd-line">$ <b>lfs getstripe <i>myfile</i></b></pre>

## [Transferring your Files](#transferring) { #transferring } 

There are several transfer mechanism for data to Frontera, some of which depend on where and how the data are to be stored.  Please review the following transfer mechanisms.

### [Windows Users](#transferring-windows) { #transferring-windows } 

TACC staff recommends the open-source [Cyberduck](https://cyberduck.io/) utility for both Windows and Mac users that do not already have a preferred tool.

<img alt="cyberduck logo" src="../../imgs/frontera/transferring-cyberduck.png"> [Download Cyberduck](https://cyberduck.io/download/)

Click on the "Open Connection" button in the top right corner of the Cyberduck window to open a connection configuration window (as shown below) transfer mechanism, and type in the server name "**`frontera.tacc.utexas.edu`**". Add your username and password in the spaces provided, and if the "more options" area is not shown click the small triangle or button to expand the window; this will allow you to enter the path to your project area so that when Cyberduck opens the connection you will immediately see your data. Then click the "Connect" button to open your connection.

Once connected, you can navigate through your remote file hierarchy using familiar graphical navigation techniques. You may also drag-and-drop files into and out of the Cyberduck window to transfer files to and from Frontera.

<!-- IMAGE3 -->

### [Grid Community Toolkit](#transferring-gct) { #transferring-gct } 

The Grid Community Toolkit (GCT) is an open-source fork of the [Globus Toolkit](http://toolkit.globus.org/toolkit) and was created in response to the [end-of-support](https://github.com/globus/globus-toolkit/blob/globus_6_branch/support-changes.md) of the Globus Toolkit in January 2018.  

Frontera has one Grid Community Toolkit endpoint. All users may authenticate using the CILogon myproxy authentication. See [Using Grid Community Toolkit at TACC][TACCGRIDCOMMUNITYTOOLKIT] for detailed information.  

### [SSH Utilities: `scp` & `rsync`](#transferring-ssh) { #transferring-ssh } 

The `scp` and `rsync` commands are standard UNIX data transfer mechanisms used to transfer moderate size files and data collections between systems. These applications use a single thread to transfer each file one at a time. The `scp` and `rsync` utilities are typically the best methods when transferring Gigabytes of data.  For larger data transfers, parallel data transfer mechanisms, e.g., Grid Community Toolkit, can often improve total throughput and reliability.

You can transfer files between Frontera and Linux-based systems using either [`scp`](http://linux.com/learn/intro-to-linux/2017/2/how-securely-transfer-files-between-servers-scp) or [`rsync`](http://linux.com/learn/get-know-rsync). Both `scp` and `rsync` are available in the Mac Terminal app. Windows SSH clients, such as Cyberduck and [Filezilla](https://filezilla-project.org/), typically include `scp`-based file transfer capabilities.

#### [Transferring Files with **`scp`**](#transferring-scp) { #transferring-scp } 

Data transfer from any Linux system can be accomplished using the `scp` utility to copy data to and from the login node. A file can be copied from your local system to the remote server by using the command:

<pre class="cmd-line">localhost% <b>scp <i>filename</i> \
<i>TACC-username</i>@frontera.tacc.utexas.edu:<i>/path/to/project/directory</i></b></pre>

Consult the `scp` man pages for more information:

<pre class="cmd-line">login1$ <b>man scp</b></pre>


The Linux `scp` (secure copy) utility is a component of the OpenSSH suite. Assuming your Frontera username is `bjones`, a simple `scp` transfer that pushes a file named `myfile` from your local Linux system to Frontera `$HOME` would look like this:

<pre class="cmd-line">localhost$ <b>scp ./myfile bjones@frontera.tacc.utexas.edu:  # note colon after net address</b></pre>

You can use wildcards, but you need to be careful about when and where you want wildcard expansion to occur. For example, to push all files ending in `.txt` from the current directory on your local machine to `/work/01234/bjones/scripts` on Frontera:

<pre class="cmd-line">localhost$ <b>scp &#42;.txt bjones@frontera.tacc.utexas.edu:/work/01234/bjones/frontera</b></pre>

To delay wildcard expansion until reaching Frontera, use a backslash (`\`) as an escape character before the wildcard. For example, to pull all files ending in `.txt` from `/work/01234/bjones/scripts` on Frontera to the current directory on your local system:

<pre class="cmd-line">localhost$ <b>scp bjones@frontera.tacc.utexas.edu:/work/01234/bjones/frontera/\*.txt .</b></pre>

You can of course use shell or environment variables in your calls to `scp`. For example:

<pre class="cmd-line">
localhost$ <b>destdir="/work/01234/bjones/frontera/data"</b>
localhost$ <b>scp ./myfile bjones@frontera.tacc.utexas.edu:$destdir</b></pre>

You can also issue `scp` commands on your local client that use Frontera environment variables like `$HOME`, `$WORK`, and `$SCRATCH`. To do so, use a backslash (`\`) as an escape character before the `$`; this ensures that expansion occurs after establishing the connection to Frontera:

<pre class="cmd-line">localhost$ <b>scp ./myfile bjones@frontera.tacc.utexas.edu:\$WORK/data   # Note backslash</b></pre>

Avoid using `scp` for recursive transfers of directories that contain nested directories of many small files:

<pre class="cmd-line">localhost$ <s>scp -r ./mydata     bjones@frontera.tacc.utexas.edu:\$WORK</s>  # DON'T DO THIS</pre>

Instead, use `tar` to create an archive of the directory, then transfer the directory as a single file:

<pre class="cmd-line">
localhost$ <b>tar cvf ./mydata.tar mydata                                  # create archive</b>
localhost$ <b>scp     ./mydata.tar bjones@frontera.tacc.utexas.edu:\$WORK  # transfer archive</b></pre>

#### [Transferring Files with `rsync`](#transferring-rsync) { #transferring-rsync } 

The `rsync` (remote synchronization) utility is a great way to synchronize files that you maintain on more than one system: when you transfer files using `rsync`, the utility copies only the changed portions of individual files. As a result, `rsync` is especially efficient when you only need to update a small fraction of a large dataset. The basic syntax is similar to `scp`:

<pre class="cmd-line">
localhost$ <b>rsync       mybigfile bjones@frontera.tacc.utexas.edu:\$WORK/data</b>
localhost$ <b>rsync -avtr mybigdir  bjones@frontera.tacc.utexas.edu:\$WORK/data</b></pre>

The options on the second transfer are typical and appropriate when synching a directory: this is a <span style="white-space: nowrap;">recursive update (`-r`)</span> with verbose (`-v`) feedback; the synchronization preserves <span style="white-space: nowrap;">time stamps (`-t`)</span> as well as symbolic links and other meta-data (`-a`). Because `rsync` only transfers changes, recursive updates with `rsync` may be less demanding than an equivalent recursive transfer with `scp`.

See [Good Conduct](../conduct) for additional important advice about striping the receiving directory when transferring large files; watching your quota on `$HOME` and `$WORK`; and limiting the number of simultaneous transfers. Remember also that `$STOCKYARD` (and your `$WORK` directory on each TACC resource) is available from several other TACC systems: there's no need for `scp` when both the source and destination involve subdirectories of `$STOCKYARD`. 

The `rsync` command is another way to keep your data up to date. In contrast to `scp`, `rsync` transfers only the actual changed parts of a file (instead of transferring an entire file). Hence, this selective method of data transfer can be much more efficient than scp. The following example demonstrates usage of the `rsync` command for transferring a file named "`myfile.c`" from its current location on Stampede to Frontera's `$DATA` directory.

<pre class="cmd-line">login1$ <b>rsync myfile.c \
<i>TACC-username</i>@frontera.tacc.utexas.edu:/data/01698/<i>TACC-username</i>/data</b></pre>

An entire directory can be transferred from source to destination by using `rsync` as well. For directory transfers the options "`-avtr`" will transfer the files recursively ("`-r`" option) along with the modification times ("`-t`" option) and in the archive mode ("`-a`" option) to preserve symbolic links, devices, attributes, permissions, ownerships, etc. The "`-v`" option (verbose) increases the amount of information displayed during any transfer. The following example demonstrates the usage of the "`-avtr`" options for transferring a directory named "`gauss`" from the present working directory on Stampede to a directory named "`data`" in the $WORK file system on Frontera.

<pre class="cmd-line">login1$ <b>rsync -avtr ./gauss \
<i>TACC-username</i>@frontera.tacc.utexas.edu:/data/01698/<i>TACC-username</i>/data</b></pre>

For more `rsync` options and command details, run the command "`rsync -h`" or:

<pre class="cmd-line">login1$ <b>man rsync</b></pre>

When executing multiple instantiations of `scp` or `rsync`, please limit your transfers to no more than 2-3 processes at a time.

### [Sharing Files with Collaborators](#transferring-sharing) { #transferring-sharing } 

If you wish to share files and data with collaborators in your project, see [Sharing Project Files on TACC Systems][TACCSHARINGPROJECTFILES] for step-by-step instructions. Project managers or delegates can use Unix group permissions and commands to create read-only or read-write shared workspaces that function as data repositories and provide a common work area to all project members.

## [Launching Applications](#launching)

<p class="introtext">The primary purpose of your job script is to launch your research application. How you do so depends on several factors, especially (1) the type of application (e.g. MPI, OpenMP, serial), and (2) what you're trying to accomplish (e.g. launch a single instance, complete several steps in a workflow, run several applications simultaneously within the same job). While there are many possibilities, your own job script will probably include a launch line that is a variation of one of the examples described in this section.</p>

### [Launching One Serial Application](#launching-serial)

To launch a serial application, simply call the executable. Specify the path to the executable in either the PATH environment variable or in the call to the executable itself:
	
<pre class="job-script">
myprogram                   			# executable in a directory listed in $PATH
$SCRATCH/apps/myprov/myprogram 			# explicit full path to executable
./myprogram                 			# executable in current directory
./myprogram -m -k 6 input1  			# executable with notional input options
</pre>

### [Launching One Multi-Threaded Application](#launching-multithreaded)

Launch a threaded application the same way. Be sure to specify the number of threads. Note that the default OpenMP thread count is 1.

<pre class="job-script">
export OMP_NUM_THREADS=56   	# 56 total OpenMP threads (1 per CLX core)
./myprogram
</pre>

### [Launching One MPI Application](#launching-mpi)

To launch an MPI application, use the TACC-specific MPI launcher `ibrun`, which is a Frontera-aware replacement for generic MPI launchers like `mpirun` and `mpiexec`. In most cases the only arguments you need are the name of your executable followed by any arguments your executable needs. When you call `ibrun` without other arguments, your Slurm `#SBATCH` directives will determine the number of ranks (MPI tasks) and number of nodes on which your program runs.

<pre class="job-script">
#SBATCH -N 5				
#SBATCH -n 200
ibrun ./myprogram				# ibrun uses the $SBATCH directives to properly allocate nodes and tasks
</pre>

To use `ibrun` interactively, say within an `idev` session, you can specify:

<pre class="cmd-line">
login1$ <b>idev -N 2 -n 100 </b>				
c123-456$ <b>ibrun ./myprogram</b>	   # ibrun uses idev's arguments to properly allocate nodes and tasks</b>
</pre>

### [Launching One Hybrid (MPI+Threads) Application](#launching-hybrid)

<!-- span style="color:red">Hyperthreading is not currently enabled on Frontera.</span> -->

When launching a single application you generally don't need to worry about affinity: both Intel MPI and MVAPICH2 will distribute and pin tasks and threads in a sensible way.

<pre class="job-script">
export OMP_NUM_THREADS=8    # 8 OpenMP threads per MPI rank
ibrun ./myprogram           # use ibrun instead of mpirun or mpiexec</pre>

As a practical guideline, the product of `$OMP_NUM_THREADS` and the maximum number of MPI processes per node should not be greater than total number of cores available per node (56 cores in the development/small/normal/large/flex [queues](../running#frontera-production-queues).


### [More Than One Serial Application in the Same Job](#launching-multiserial)

TACC's `launcher` utility provides an easy way to launch more than one serial application in a single job. This is a great way to engage in a popular form of High Throughput Computing: running parameter sweeps (one serial application against many different input datasets) on several nodes simultaneously. The launcher utility will execute your specified list of independent serial commands, distributing the tasks evenly, pinning them to specific cores, and scheduling them to keep cores busy. Execute <span style="white-space: nowrap;">`module load launcher`</span> followed by <span style="white-space: nowrap;">`module help launcher`</span> for more information.

### [MPI Applications One at a Time](#launching-mpisequential)

To run one MPI application after another (or any sequence of commands one at a time), simply list them in your job script in the order in which you'd like them to execute. When one application/command completes, the next one will begin.

<pre class="job-script">
module load git
module list
./preprocess.sh
ibrun ./myprogram input1    # runs after preprocess.sh completes
ibrun ./myprogram input2    # runs after previous MPI app completes
</pre>

### [More than One MPI Application Running Concurrently](#launching-mpiconcurrent)

To run more than one MPI application simultaneously in the same job, you need to do several things:

* use ampersands to launch each instance in the background;
* include a wait command to pause the job script until the background tasks complete;
* use `ibrun`'s `-n` and `-o` switches to specify task counts and hostlist offsets respectively; and
* include a call to the `task_affinity` script in your `ibrun` launch line.

If, for example, you use `#SBATCH` directives to request N=4 nodes and n=112 total MPI tasks, Slurm will generate a hostfile with 112 entries (28 entries for each of 4 nodes). The `-n` and `-o` switches, which must be used together, determine which hostfile entries ibrun uses to launch a given application; execute `ibrun --help` for more information. Don't forget the ampersands ("&") to launch the jobs in the background, and the `wait` command to pause the script until the background tasks complete:

<pre class="job-script">
ibrun -n 56 -o  0 task_affinity ./myprogram input1 &    # 56 tasks; offset by  0 entries in hostfile.
ibrun -n 56 -o 56 task_affinity ./myprogram input2 &    # 56 tasks; offset by 56 entries in hostfile.
wait                                                    # Required; else script will exit immediately.
</pre>

The `task_affinity` script manages task placement and memory pinning when you call ibrun with the `-n`, `-o` switches (it's not necessary under any other circumstances). 

### [More than One OpenMP Application Running Concurrently](#launching-multimpiconcurrent)

<!-- span style="color:red">Hyperthreading is not currently enabled on Frontera.</span> -->
 
You can also run more than one OpenMP application simultaneously on a single node, but you will need to distribute and pin OpenMP threads appropriately.  The most portable way to do this is with OpenMP Affinity.
 
An OpenMP executable sequentially assigns its N forked threads (thread number 0,...N-1) at a parallel region to the sequence of "places" listed in the `OMP_PLACES` environment variable.  Each place is specified within braces ({}}. The sequence "{0,1},{2,3},{4,5}" has three places, and OpenMP thread numbers 0, 1, and 2 are assigned to the processor ids (proc-ids) 0,1 and 2,3 and 4,5, respectively. The hardware assigned to the proc-ids can be found in the /proc/cpuinfo file.
 
On CLX nodes the sequence of proc-ids on socket 0 are even:

<pre>0,2,4,...,108, 110 </pre>

and on socket 1 they are oddly numbered:

<pre>1,3,5,...,109,111 </pre>

Note, there are 56 cores on CLX, and since hyperthreading is turned on, the list of processors (proc-ids) goes from 0 to 111.  
 
Specifically, the proc-id mapping to the cores for CLX is:

<pre>
|------- Socket 0 ------------|-------- Socket 1 ---------|
#   0   1   2,..., 25, 26, 27 |  0   1   2,..., 25, 26, 27
0   0   2   4,..., 50, 52, 54 |  1   3   5,..., 51, 53, 55
1  56  58  60,...,106,108,110 | 57  59  61,...,107,109,111</pre>

Hence, to bind OpenMP threads to a sequence of 3 cores on these systems, the places would be:
 
<pre class="job-script">
CLX socket 0:  export OMP_PLACES="{0,56},{2,58},{4,60}"
CLX socket 1:  export OMP_PLACES="{1,57},{3,59},{5,61}"</pre>
 
Interval notation can be used to express a sequences of places.  The syntax is: {proc-ids},N,S, where N is the number of places to create from the base place ({proc-ids}) with a stride of S.  Hence the above sequences could have been written:
 
<pre class="job-script">
CLX socket 0:  export OMP_PLACES="{0,56},3,2"
CLX socket 1:  export OMP_PLACES="{1,57},3,2"</pre>
 
In the example below two OpenMP programs are executed on a single node, each using 28 threads. The first program uses the cores on socket 0.  It is put in the background, using the ampersand (&) character at the end of the line, so that the job script execution can continue to the second OpenMP program execution, which uses the cores on socket 1.  It, too, is put in the background, and the job execution waits for both to finish with the wait command at the end.
 
<pre class="job-script">
export OMP_NUM_THREADS=28
env OMP_PLACES="{0,56},28,2" ./omp.exe &   #execution on socket 0 cores
env OMP_PLACES="{1,57},28,2" ./omp.exe &   #execution on socket 1 cores
wait</pre>

## [Running Jobs on the Compute Nodes](#running) { #running }

<p class="introtext">Frontera's job scheduler is the <a href="http://schedmd.com">Slurm Workload Manager</a>. Slurm commands enable you to submit, manage, monitor, and control your jobs. Jobs submitted to the scheduler are queued, then run on the compute nodes. Each job consumes Service Units (SUs) which are then charged to your allocation.</p>


### [Job Accounting](#running-jobaccounting) { #running-jobaccounting } 

Like all TACC systems, Frontera's accounting system is based on node-hours: one unadjusted Service Unit (SU) represents a single compute node used for one hour (a node-hour). For any given job, the total cost in SUs is the use of one compute node for one hour of wall clock time plus any additional charges for the use of specialized queues, e.g. Frontera's `flex` queue, Stampede2's `development` queue, and Longhorn's `v100` queue.  The [queue charge rates](#table-5-frontera-production-queues) are determined by the supply and demand for that particular queue or type of node used.  

<span style="white-space: nowrap;"><b>Frontera SUs billed = (# nodes) x (job duration in wall clock hours) x (charge rate per node-hour)</b></span>

The Slurm scheduler tracks and charges for usage to a granularity of a few seconds of wall clock time. **The system charges only for the resources you actually use, not those you request.** If your job finishes early and exits properly, Slurm will release the nodes back into the pool of available nodes. Your job will only be charged for as long as you are using the nodes.

<p class="portlet-msg-info">TACC does not implement node-sharing on any compute resource. Each Frontera node can be assigned to only one user at a time; hence a complete node is dedicated to a user's job and accrues wall-clock time for all the node's cores whether or not all cores are used.</p>

**Tip**: Your queue wait times will be less if you request only the time you need: the scheduler will have a much easier time finding a slot for the 2 hours you really need than say, for the 12 hours requested in your job script. 

Principal Investigators can monitor allocation usage via the [TACC User Portal](https://portal.tacc.utexas.edu) under ["Allocations->Projects and Allocations"](https://portal.tacc.utexas.edu/projects-and-allocations). Be aware that the figures shown on the portal may lag behind the most recent usage. Projects and allocation balances are also displayed upon command-line login.

<p class="portlet-msg-info">To display a summary of your TACC project balances and disk quotas at any time, execute:<br><br><code>login1$ <b>/usr/local/etc/taccinfo</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;# Generally more current than balances displayed on the portals.</code></pre></p>  

### [Requesting Resources ](#running-requesting) { #running-requesting } 

Be sure to request computing resources e.g., number of nodes, number of tasks per node, max time per job, that are consistent with the type of application(s) you are running:

* A **serial** (non-parallel) application can only make use of a single core on a single node, and will only see that node's memory.
* A threaded program (e.g. one that uses **OpenMP**) employs a shared memory programming model and is also restricted to a single node, but the program's individual threads can run on multiple cores on that node. 
* An **MPI** (Message Passing Interface) program can exploit the distributed computing power of multiple nodes: it launches multiple copies of its executable (MPI **tasks**, each assigned unique IDs called **ranks**) that can communicate with each other across the network. The tasks on a given node, however, can only directly access the memory on that node. Depending on the program's memory requirements, it may not be possible to run a task on every core of every node assigned to your job. If it appears that your MPI job is running out of memory, try launching it with fewer tasks per node to increase the amount of memory available to individual tasks.
* A popular type of **parameter sweep** (sometimes called **high throughput computing**) involves submitting a job that simultaneously runs many copies of one serial or threaded application, each with its own input parameters ("Single Program Multiple Data", or SPMD). The `launcher` tool is designed to make it easy to submit this type of job. For more information:

<pre class="cmd-line">
$ <b>module load launcher</b>
$ <b>module help launcher</b>
</pre>

### [Frontera Production Queues](#running-queues)  { #running-queues } { #queues }

Frontera's Slurm partitions (queues), maximum node limits and charge rates are summarized in the table below. **Queues and limits are subject to change without notice.** Execute `qlimits` on Frontera for real-time information regarding limits on available queues. See [Job Accounting](#job-accounting) to learn how jobs are charged to your allocation.

Frontera's newest queue, `small`, has been created specifically for one and two node jobs. Jobs of one or two nodes that will run for up to 48 hours should be submitted to this new `small` queue. The `normal` queue now has a lower limit of three nodes for all jobs. 

The `nvdimm` queue features 16 [large-memory (2.1TB) nodes](../system#large-memory-nodes). Access to this queue is not restricted, however jobs in this queue are charged at twice the rate of the `normal`, `development` and `large`  queues. 

Frontera's `flex` queue offers users a low cost queue for lower priority/node count jobs and jobs running software with checkpointing capabilities. Jobs in the `flex` queue are scheduled with lower priority and are also eligible for preemption after running for one hour.  That is, if other jobs in the other queues are currently waiting for nodes and there are jobs running in the `flex` queue, the Slurm scheduler will cancel any jobs in the `flex` queue that have run more than one hour in order to give resources back to the higher priority jobs. Any job started in the `flex` queue is guaranteed to run for at least an hour (assuming the requested wallclock time was >= 1 hour). If there remain no outstanding requests from other queues, then these jobs will continue to run until they hit their wallclock requested time. This flexibility in runtime is rewarded by a reduced charge rate of .8 SUs/hour. Also, the max total node count for one user with many jobs in the flex queue is 6400 nodes.


#### [Table 5. Frontera Production Queues](#table5) { #table5 } 
Queue status as of March 14, 2022.   
**Queues and limits are subject to change without notice.** 

Users are limited to a maximum of 50 running and 200 pending jobs in all queues at one time. 
 

| Queue Name  | Max Nodes per Job<br>(assoc'd cores) | Pre-empt<br>Exempt Time | Max Job Duration | Max Nodes per User | Max Jobs per User  | Charge Rate<br>per node-hour 
| ------                        | -----                         | ----  | ----     | ----       | ----     | ----
| <code>flex&#42;</code>        | 128 nodes<br>(7,168 cores)    | 1 hour | 48 hrs  | 6400 nodes | 15 jobs | .8 Service Units (SUs) 
| <code>development</code>      | 40 nodes<br>(2,240 cores)     | N/A | 2 hrs       | 40 nodes   |   1 job   | 1 SU 
| <code>normal</code>           | 3-512 nodes<br>(28,672 cores)   | N/A | 48 hrs      | 1836 nodes | 100 jobs  | 1 SU   
| <code>large&#42;&#42;</code>  | 513-2048 nodes<br>(114,688 cores) | N/A | 48 hrs  | 4096 nodes |   1 job  | 1 SU
| <code>rtx</code>              | 22 nodes                       | N/A | 48 hrs     | 22 nodes   |  15 jobs  | 3 SUs
| <code>rtx-dev</code>          | 2 nodes                        | N/A | 2 hrs      | 2          |   1 jobs  | 3 SUs
| <code>nvdimm</code>           | 4 nodes                        | N/A   | 48 hrs   | 8  nodes   |   2 jobs  | 2 SUs 
| <code>small</code>            | 2 nodes                       | N/A | 48 hrs     | 24 nodes | 20  jobs | 1 SU


   
<p>&nbsp;</p>
&#42; **Jobs in the `flex` queue are charged less than jobs in other queues but are eligible for preemption after running for more than one hour.**  
&#42;&#42; **Access to the large queue is restricted**. To request more nodes than are available in the `normal` queue, submit a consulting (help desk) ticket through the [TACC User Portal](http://portal.tacc.utexas.edu/). Include in your request reasonable evidence of your readiness to run under the conditions you're requesting. In most cases this should include your own strong or weak scaling results from Frontera.



### [Accessing the Compute Nodes](#running-computenodes) { #running-computenodes } 

 The login nodes are shared resources: at any given time, there are many users logged into each of these login nodes, each preparing to access the "back-end" compute nodes (Figure 2. Login and Compute Nodes). What you do on the login nodes affects other users directly because you are competing for the same resources: memory and processing power. This is the reason you should not run your applications on the login nodes or otherwise abuse them. Think of the login nodes as a prep area where you can manage files and compile code before accessing the compute nodes to perform research computations. See [Good Conduct](../conduct) for more information.

#### [Figure 2. Login and Compute Nodes](#figure2) { #figure2 } 
<figure id="figure2"><img alt="[Figure 2. Login and Compute Nodes" src="../../imgs/login-compute-nodes.jpg">
<figcaption></figcaption></figure>

You can use your command-line prompt, or the `hostname` command, to discern whether you are on a login node or a compute node. The default prompt, or any custom prompt containing `\h`, displays the short form of the hostname <span style="white-space: nowrap;">(e.g. `c401-064`)</span>. The hostname for a Frontera login node begins with the string `login` (e.g. `login2.frontera.tacc.utexas.edu`), while compute node hostnames begin with the character `c` <span style="white-space: nowrap;">(e.g. `c401-064.frontera.tacc.utexas.edu`)</span>. 

While some workflows, tools, and applications hide the details, there are three basic ways to access the compute nodes:

1.	[Submit a **batch job** using the `sbatch` command](#submitting-batch-jobs-with-sbatch). This directs the scheduler to run the job unattended when there are resources available. Until your batch job begins it will wait in a [queue](#table-5-frontera-production-queues). You do not need to remain connected while the job is waiting or executing. Note that the scheduler does not start jobs on a first come, first served basis; it juggles many variables to keep the machine busy while balancing the competing needs of all users. The best way to minimize wait time is to request only the resources you really need: the scheduler will have an easier time finding a slot for the two hours you need than for the 24 hours you unnecessarily request.

1.	Begin an [interactive session using **`ssh`**](#interactive-sessions-using-ssh) to connect to a compute node on which you are already running a job. This is a good way to open a second window into a node so that you can monitor a job while it runs.

1.	Begin an [**interactive session** using `idev` or `srun`](#interactive-sessions-with-idev-and-srun). This will log you into a compute node and give you a command prompt there, where you can issue commands and run code as if you were doing so on your personal machine. An interactive session is a great way to develop, test, and debug code. Both the `srun` and `idev` commands submit a new batch job on your behalf, providing interactive access once the job starts. You will need to remain logged in until the interactive session begins.


### [Submitting Batch Jobs with `sbatch`](#running-sbatch) { #running-sbatch } 

Use Slurm's `sbatch` command to submit a batch job to one of the Frontera queues:

<pre class="cmd-line">
login1$ <b>sbatch myjobscript</b>
</pre>

Here `myjobscript` is the name of a text file containing `#SBATCH` directives and shell commands that describe the particulars of the job you are submitting. The details of your job script's contents depend on the type of job you intend to run. 

In each job script: 

1. use `#SBATCH` directives to request computing resources (e.g. 10 nodes for 2 hrs); 
2. then, list shell commands to specify what work you're going to do once your job begins. 

There are many possibilities: you might elect to launch a single application, or you might want to accomplish several steps in a workflow. You may even choose to launch more than one application at the same time. The details will vary, and there are many possibilities. But your own job script will probably include at least one launch line that is a variation of one of the examples described here.

<p class="msg-info"><a href="../scripts">See the customizable job script examples</a>.</p>

Your job will run in the environment it inherits at submission time; this environment includes the modules you have loaded and the current working directory. In most cases you should **run your application(s) after loading the same modules that you used to build them**. You can of course use your job submission script to modify this environment by defining new environment variables; changing the values of existing environment variables; loading or unloading modules; changing directory; or specifying relative or absolute paths to files. **Do not use the Slurm <span style="white-space: nowrap;">`--export`</span> option to manage your job's environment**: doing so can interfere with the way the system propagates the inherited environment.

Consult the [Common `sbatch` Options table](#table-6-common-sbatch-options) below describes some of the most common `sbatch` command options. Slurm directives begin with `#SBATCH`; most have a short form (e.g. <span style="white-space: nowrap;">`-N`</span>) and a long form (e.g. <span style="white-space: nowrap;">`--nodes`</span>). You can pass options to `sbatch` using either the command line or job script; most users find that the job script is the easier approach. The first line of your job script must specify the interpreter that will parse non-Slurm commands; in most cases <span style="white-space: nowrap;">`#!/bin/bash`</span> or <span style="white-space: nowrap;">`#!/bin/csh`</span> is the right choice. Avoid <span style="white-space: nowrap;">`#!/bin/sh`</span> (its startup behavior can lead to subtle problems on Frontera), and do not include comments or any other characters on this first line. All `#SBATCH` directives must precede all shell commands. Note also that certain `#SBATCH` options or combinations of options are mandatory, while others are not available on Frontera.


#### [Table 6. Common <code>sbatch</code> Options](#-table6) { #table6 } 

| Option | Argument | Comments |
| --- | --- | -- |
<code>-p</code> | <i>queue_name</i> | Submits to queue (partition) designated by <i>queue_name</i>
<code>-J</code> | <i>job_name</i> | Job Name
<code>-N</code> | <i>total_nodes</i> | Required. Define the resources you need by specifying either:<br>(1) "<code>-N</code>" and "<code>-n</code>"; or<br>(2) "<code>-N</code>" and "<code>--ntasks-per-node</code>". 
<code>-n</code> | <i>total_tasks</i> | This is total MPI tasks in this job. See "<code>-N</code>" above for a good way to use this option. When using this option in a non-MPI job, it is usually best to set it to the same value as "<code>-N</code>".
<span style="white-space: nowrap;"><code>--ntasks-per-node</code></span><br>or<br><code>--tasks-per-node</code></td> | <i>tasks_per_node</i> | This is MPI tasks per node. See "<code>-N</code>" above for a good way to use this option. When using this option in a non-MPI job, it is usually best to set <code>--ntasks-per-node</code> to 1.
<code>-t</code> | <i>hh:mm:ss</i> | Required. Wall clock time for job.
<span style="white-space: nowrap;"><code>--mail-user=</code></span> | <i>email_address</i> | Specify the email address to use for notifications.
<code>--mail-type=</code> | <code>begin</code>, <code>end</code>, <code>fail</code>, or <code>all</code> | Specify when user notifications are to be sent (one option per line).
<code>-o</code> | <i>output_file</i> | Direct job standard output to <i>output_file</i> (without <code>-e</code> option error goes to this file)
<code>-e</code> | <i>error_file</i> | Direct job error output to <i>error_file</i>
<code>--dependency=</code> | <i>jobid</i> | Specifies a dependency: this run will start only after the specified job (<i>jobid</i>) successfully finishes
<code>-A</code> | <i>projectnumber</i> | Charge job to the specified project/allocation number. This option is only necessary for logins associated with multiple projects.   
<code>-a</code><br>or<br><code>--array</code> | N/A | Not available. Use the <code>launcher</code> module for parameter sweeps and other collections of related serial jobs.
<code>--mem</code> | N/A | Not available. If you attempt to use this option, the scheduler will not accept your job.
<code>--export=</code> | N/A | Avoid this option on Frontera. Using it is rarely necessary and can interfere with the way the system propagates your environment.

By default, Slurm writes all console output to a file named <span style="white-space: nowrap;">`slurm-%j.out`</span>, where `%j` is the numerical job ID. To specify a different filename use the <span style="white-space: nowrap;">`-o`</span> option. To save `stdout` (standard out) and `stderr` (standard error) to separate files, specify both <span style="white-space: nowrap;">`-o`</span> and <span style="white-space: nowrap;">`-e`</span>.


### [Interactive Sessions with `idev` and `srun`](#running-interactive) { #running-interactive } 

TACC's own `idev` utility is the best way to begin an interactive session on one or more compute nodes. `idev` submits a batch script requesting access to a compute node. Once the scheduler allocates a compute node, you are then automatically ssh'd to that node where you can begin any compute-intensive jobs.  

To launch a thirty-minute session on a single node in the `development` queue, simply execute:

<pre class="cmd-line">
login1$ <b>idev</b>
</pre>

You'll then see output that includes the following excerpts:

<pre class="cmd-line">
...
-----------------------------------------------------------------
		Welcome to the Frontera Supercomputer          
-----------------------------------------------------------------
...

-> After your idev job begins to run, a command prompt will appear,
-> and you can begin your interactive development session. 
-> We will report the job status every 4 seconds: (PD=pending, R=running).

->job status:  PD
->job status:  PD
...
c123-456$
</pre>

The `job status` messages indicate that your interactive session is waiting in the queue. When your session begins, you'll see a command prompt on a compute node (in this case, the node with hostname `c449-001`). If this is the first time you launch `idev`, you may be prompted to choose a default project and a default number of tasks per node for future `idev` sessions.

For command-line options and other information, execute `idev --help`. It's easy to tailor your submission request (e.g. shorter or longer duration) using Slurm-like syntax:

<pre class="cmd-line">
login1$ <b>idev -p normal -N 2 -n 8 -m 150</b> # normal queue, 2 nodes, 8 total tasks, 150 minutes
</pre>

You can also launch an interactive session with Slurm's srun command, though there's no clear reason to prefer srun to idev. A typical launch line would look like this:

<pre class="cmd-line">
login1$ <b>srun --pty -N 2 -n 8 -t 2:30:00 -p normal /bin/bash -l</b> # same conditions as above
</pre>

Consult the [`idev`](http://portal.tacc.utexas.edu/software/idev) documentation for further details.

### [Interactive Sessions using SSH](#running-ssh) { #running-ssh } 

If you have a batch job or interactive session running on a compute node, you "own the node": you can connect via `ssh` to open a new interactive session on that node. This is an especially convenient way to monitor your applications' progress. One particularly helpful example: login to a compute node that you own, execute `top`, then press the "1" key to see a display that allows you to monitor thread ("CPU") and memory use.

There are many ways to determine the nodes on which you are running a job, including feedback messages following your `sbatch` submission, the compute node command prompt in an `idev` session, and the `squeue` or `showq` utilities. The sequence of identifying your compute node then connecting to it would look like this:


<pre class="cmd-line">
login1$ <b>squeue -u bjones</b>
 JOBID       PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
858811     development idv46796   bjones  R       0:39      1 c448-004
1ogin1$ ssh c448-004
...
C448-004$
</pre>


### [Slurm Environment Variables](#running-slurmenvvars) { #running-slurmenvvars } 

Be sure to distinguish between internal Slurm replacement symbols (e.g. `%j` described above) and Linux environment variables defined by Slurm (e.g. `SLURM_JOBID`). Execute <span style="white-space: nowrap;">`env | grep SLURM`</span> from within your job script to see the full list of Slurm environment variables and their values. You can use Slurm replacement symbols like `%j` only to construct a Slurm filename pattern; they are not meaningful to your Linux shell. Conversely, you can use Slurm environment variables in the shell portion of your job script but not in an `#SBATCH` directive. For example, the following directive will not work the way you might think:

<pre class="job-script">
<s>#SBATCH -o myMPI.o${SLURM_JOB_ID}</s>   # incorrect
</pre>

Instead, use the following directive:

<pre class="job-script">
#SBATCH -o myMPI.o%j     # "%j" expands to your job's numerical job ID
</pre>

Similarly, you cannot use paths like `$WORK` or `$SCRATCH` in an `#SBATCH` directive.

For more information on this and other matters related to Slurm job submission, see the [Slurm online documentation](https://slurm.schedmd.com/sbatch.html); the man pages for both Slurm itself (<span style="white-space: nowrap;">`man slurm`</span>) and its individual commands (e.g. <span style="white-space: nowrap;">`man sbatch`</span>); as well as numerous other online resources.


## [Sample Job Scripts](#jobscripts)

<p class="introtext">Copy and customize the following jobs scripts by specifying and refining your job's requirements.</p>

* specify the maximum run time with the `-t` option. 
* specify number of nodes needed with the `-N` option
* specify tasks per node with the `-n` option
* specify the project to be charged with the `-A` option.

Consult [Table 6](#table-6-common-sbatch-options) for a listing of common Slurm `#SBATCH` options.

### [Serial Jobs](#jobscripts-serial)

Serial codes should request 1 node (`#SBATCH -N 1`) with 1 task (`#SBATCH -n 1`). **Run all serial jobs in the `small` queue.**  Consult the [Launcher at TACC](https://portal.tacc.utexas.edu/software/launcher) documentation to run multiple serial executables at one time.


<pre class="job-script">
#!/bin/bash
#----------------------------------------------------
# Sample Slurm job script
#   for TACC Frontera CLX nodes
#
#   *** Serial Job in Small Queue***
# 
# Last revised: 22 June 2021
#
# Notes:
#
#  -- Copy/edit this script as desired.  Launch by executing
#     "sbatch clx.serial.slurm" on a Frontera login node.
#
#  -- Serial codes run on a single node (upper case N = 1).
#       A serial code ignores the value of lower case n,
#       but slurm needs a plausible value to schedule the job.
#
#  -- Use TACC's launcher utility to run multiple serial 
#       executables at the same time, execute "module load launcher" 
#       followed by "module help launcher".
#----------------------------------------------------

#SBATCH -J myjob           # Job name
#SBATCH -o myjob.o%j       # Name of stdout output file
#SBATCH -e myjob.e%j       # Name of stderr error file
#SBATCH -p small           # Queue (partition) name
#SBATCH -N 1               # Total # of nodes (must be 1 for serial)
#SBATCH -n 1               # Total # of mpi tasks (should be 1 for serial)
#SBATCH -t 01:30:00        # Run time (hh:mm:ss)
#SBATCH --mail-type=all    # Send email at begin and end of job
#SBATCH -A <i>myproject</i>       # Project/Allocation name (req'd if you have more than 1)
#SBATCH --mail-user=<i>username</i>@tacc.utexas.edu

# Any other commands must follow all #SBATCH directives...
module list
pwd
date

# Launch serial code...
./myprogram         # Do not use ibrun or any other MPI launcher

</pre>

### [MPI Jobs](#jobscripts-mpi)

This script requests 4 nodes (`#SBATCH -N 4`) and 32 tasks (`#SBATCH -n 32`), for 8 MPI rasks per node.  If your job requires only one or two nodes, submit the job to the `small` queue instead of the `normal` queue.

<pre class="job-script">
#!/bin/bash
#----------------------------------------------------
# Sample Slurm job script
#   for TACC Frontera CLX nodes
#
#   *** MPI Job in Normal Queue ***
# 
# Last revised: 20 May 2019
#
# Notes:
#
#   -- Launch this script by executing
#      "sbatch clx.mpi.slurm" on a Frontera login node.
#
#   -- Use ibrun to launch MPI codes on TACC systems.
#      Do NOT use mpirun or mpiexec.
#
#   -- Max recommended MPI ranks per CLX node: 56
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
#SBATCH --mail-type=all    # Send email at begin and end of job
#SBATCH -A <i>myproject</i>       # Project/Allocation name (req'd if you have more than 1)
#SBATCH --mail-user=<i>username</i>@tacc.utexas.edu

# Any other commands must follow all #SBATCH directives...
module list
pwd
date

# Launch MPI code... 
ibrun ./myprogram         # Use ibrun instead of mpirun or mpiexec

</pre>

### [OpenMP Jobs](#jobscripts-openmp)

<!-- span style="color:red">**Hyperthreading is not currently enabled on Frontera**</span> -->
**Run all OpenMP jobs in the `small` queue.**  

<pre class="job-script">
#!/bin/bash
#----------------------------------------------------
# Sample Slurm job script
#   for TACC Frontera CLX nodes
#
#   *** OpenMP Job in Small Queue ***
# 
# Last revised: July 6, 2021
#
# Notes:
#
#   -- Launch this script by executing
#   -- Copy/edit this script as desired.  Launch by executing
#      "sbatch clx.openmp.slurm" on a Frontera login node.
#
#   -- OpenMP codes run on a single node (upper case N = 1).
#        OpenMP ignores the value of lower case n,
#        but slurm needs a plausible value to schedule the job.
#
#   -- Default value of OMP_NUM_THREADS is 1; be sure to change it!
#
#   -- Increase thread count gradually while looking for optimal setting.
#        If there is sufficient memory available, the optimal setting
#        is often 56 (1 thread per core) but may be higher.

#----------------------------------------------------

#SBATCH -J myjob           # Job name
#SBATCH -o myjob.o%j       # Name of stdout output file
#SBATCH -e myjob.e%j       # Name of stderr error file
#SBATCH -p small           # Queue (partition) name
#SBATCH -N 1               # Total # of nodes (must be 1 for OpenMP)
#SBATCH -n 1               # Total # of mpi tasks (should be 1 for OpenMP)
#SBATCH -t 01:30:00        # Run time (hh:mm:ss)
#SBATCH --mail-type=all    # Send email at begin and end of job
#SBATCH --mail-user=<i>username</i>@tacc.utexas.edu
#SBATCH -A <i>myproject</i>       # Project/Allocation name (req'd if you have more than 1)

# Any other commands must follow all #SBATCH directives...
module list
pwd
date

# Set thread count (default value is 1)...
export OMP_NUM_THREADS=56   # this is 1 thread/core; may want to start lower

# Launch OpenMP code...
./myprogram         # Do not use ibrun or any other MPI launcher

</pre>

### [Hybrid (MPI + OpenMP) Job](#jobscripts-hybrid)

<!-- span style="color:red">**Hyperthreading is not currently enabled on Frontera**</span> -->  
This script requests 10 nodes (`#SBATCH -N 10`) and 40 tasks (`#SBATCH -n 40`).  If your job requires only one or two nodes, submit the job to the `small` queue instead of the `normal` queue.

<pre class="job-script">
#!/bin/bash
#----------------------------------------------------
# Example Slurm job script
# for TACC Frontera CLX nodes
#
#   *** Hybrid Job in Normal Queue ***
# 
#       This sample script specifies:
#         10 nodes (capital N)
#         40 total MPI tasks (lower case n); this is 4 tasks/node
#         14 OpenMP threads per MPI task (56 threads per node)
#
# Last revised: 20 May 2019
#
# Notes:
#
#   -- Launch this script by executing
#      "sbatch clx.hybrid.slurm" on Frontera login node.
#
#   -- Use ibrun to launch MPI codes on TACC systems.
#      Do NOT use mpirun or mpiexec.
#
#   -- In most cases it's best to keep
#      ( MPI ranks per node ) x ( threads per rank )
#      to a number no more than 56 (total cores).
#
#   -- If you're running out of memory, try running
#      fewer tasks and/or threads per node to give each 
#      process access to more memory.
#
#   -- IMPI does sensible process pinning by default.
#
#----------------------------------------------------

#SBATCH -J myjob           # Job name
#SBATCH -o myjob.o%j       # Name of stdout output file
#SBATCH -e myjob.e%j       # Name of stderr error file
#SBATCH -p normal          # Queue (partition) name
#SBATCH -N 10              # Total # of nodes 
#SBATCH -n 40              # Total # of mpi tasks
#SBATCH -t 01:30:00        # Run time (hh:mm:ss)
#SBATCH --mail-type=all    # Send email at begin and end of job
#SBATCH -A <i>myproject</i>       # Project/Allocation name (req'd if you have more than 1)
#SBATCH --mail-user=<i>username</i>@tacc.utexas.edu

# Any other commands must follow all #SBATCH directives...
module list
pwd
date

# Set thread count (default value is 1)...
export OMP_NUM_THREADS=14

# Launch MPI code... 
ibrun ./myprogram         # Use ibrun instead of mpirun or mpiexec

</pre>

### [Parametric Sweep / HTC jobs](#jobscripts-htc)

Consult the [Launcher at TACC](https://portal.tacc.utexas.edu/software/launcher) documentation for instructions on running parameter sweep and other High Throughput Computing workflows.

## [Job Management](#monitoring) { #monitoring }

<p class="introtext">In this section, we present several Slurm commands and other utilities that are available to help you plan and track your job submissions as well as check the status of the Slurm queues.</p>

When interpreting queue and job status, remember that **Frontera doesn't operate on a first-come-first-served basis**. Instead, the sophisticated, tunable algorithms built into Slurm attempt to keep the system busy, while scheduling jobs in a way that is as fair as possible to everyone. At times this means leaving nodes idle ("draining the queue") to make room for a large job that would otherwise never run. It also means considering each user's "fair share", scheduling jobs so that those who haven't run jobs recently may have a slightly higher priority than those who have.

### [Monitoring Queue Status with `sinfo` and `qlimits`](#monitoring-queues) { #monitoring-queues }

#### [TACC's `qlimits` command](#monitoring-queues-qlimits) { #monitoring-queues-qlimits }

To display resource limits for the Frontera queues, execute: `qlimits`. The result is real-time data; the corresponding information in this document's [table of Frontera queues](../running#frontera-production-queues) may lag behind the actual configuration that the `qlimits` utility displays.

#### [Slurm's `sinfo` command](#monitoring-queues-sinfo) { #monitoring-queues-sinfo }

Slurm's `sinfo` command allows you to monitor the status of the queues. If you execute `sinfo` without arguments, you'll see a list of every node in the system together with its status. To skip the node list and produce a tight, alphabetized summary of the available queues and their status, execute:

<pre class="cmd-line">login1$ <b>sinfo -S+P -o "%18P %8a %20F"</b>    # compact summary of queue status</pre>

An excerpt from this command's output might look like this:

<pre class="cmd-line">
login1$ <b>sinfo -S+P -o "%18P %8a %20F"</b>
PARTITION          AVAIL    NODES(A/I/O/T)
debug              up       1757/4419/776/6952
development&#42;       up       85/153/114/352
large              up       1691/112/485/2288
normal             up       1691/112/485/2288</pre>
			
The `AVAIL` column displays the overall status of each queue (up or down), while the column labeled `NODES(A/I/O/T)` shows the number of nodes in each of several states ("**A**llocated", "**I**dle", "**O**ffline", and "**T**otal"). Execute `man sinfo` for more information. Use caution when reading the generic documentation, however: some available fields are not meaningful or are misleading on Frontera (e.g. `TIMELIMIT`, displayed using the `%l` option).

### [Monitoring Job Status](#monitoring-jobs) { #monitoring-jobs }

#### [Slurm's `squeue` command](#monitoring-jobs-squeue) { #monitoring-jobs-squeue }

Slurm's `squeue` command allows you to monitor jobs in the queues, whether pending (waiting) or currently running:

<pre class="cmd-line">
login1$ <b>squeue</b>             # show all jobs in all queues
login1$ <b>squeue -u bjones</b>   # show all jobs owned by bjones
login1$ <b>man squeue</b>         # more info</pre>

An excerpt from the default output might look like this:

<pre class="cmd-line">
 JOBID   PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
25781       debug idv72397   bjones CG       9:36      2 c190-131,c191-092
25918       debug ppm_4828   bjones PD       0:00   4828 (Resources)
25915       debug MV2-test    siliu PD       0:00   4200 (Priority)
25940      normal     SWMF   xtwang PD       0:00     18 (Nodes required for job are DOWN, DRAINED or reserved for jobs in higher priority partitions)
25589      normal   aatest slindsey PD       0:00      8 (Dependency)
25949       debug psdns_la sniffjck PD       0:00    256 (Priority)
25942      normal     WRF2 sniffjck PD       0:00    128 (Nodes required for job are DOWN, DRAINED or reserved for jobs in higher priority partitions)
25618      normal   SP256U   connor PD       0:00      1 (Dependency)
25944      normal  MoTi_hi   wchung  R      35:13      1 c112-203
25945      normal WTi_hi_e   wchung  R      27:11      1 c113-131
25606      normal   trainA   jackhu  R   23:28:28      1 c119-152
</pre>
<!-- pre class="cmd-line">
 JOBID   PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
170361      normal   spec12   bjones PD       0:00     32 (Resources)
170356      normal    mal2d slindsey PD       0:00     30 (Priority)
170204      normal   rr2-a2 tg123456 PD       0:00      1 (Dependency)
170250 development idv59074  aturing  R      29:30      1 c455-044
169669      normal  04-99a1  aturing CG    2:47:47      1 c425-003</pre> -->

The column labeled `ST` displays each job's status: 

* `PD` means "Pending" (waiting); 
* `R`  means "Running";
* `CG` means "Completing" (cleaning up after exiting the job script).

Pending jobs appear in order of decreasing priority. The last column includes a nodelist for running/completing jobs, or a reason for pending jobs. If you submit a job before a scheduled system maintenance period, and the job cannot complete before the maintenance begins, your job will run when the maintenance/reservation concludes. The `squeue` command will report `ReqNodeNotAvailable` ("Required Node Not Available"). The job will remain in the `PD` state until Frontera returns to production.

The default format for `squeue` now reports total nodes associated with a job rather than cores, tasks, or hardware threads. One reason for this change is clarity: the operating system sees each compute node's 56 hardware threads as "processors", and output based on that information can be ambiguous or otherwise difficult to interpret. 

The default format lists all nodes assigned to displayed jobs; this can make the output difficult to read. A handy variation that suppresses the nodelist is:

<pre class="cmd-line">login1$ <b>squeue -o "%.10i %.12P %.12j %.9u %.2t %.9M %.6D"</b>  # suppress nodelist</pre>

The `--start` option displays job start times, including very rough estimates for the expected start times of some pending jobs that are relatively high in the queue:

<pre class="cmd-line">login1$ <b>squeue --start -j 167635</b>     # display estimated start time for job 167635</pre>

#### [TACC's `showq` utility](#monitoring-jobs-showq) { #monitoring-jobs-showq }

TACC's `showq` utility mimics a tool that originated in the PBS project, and serves as a popular alternative to the Slurm `squeue` command:

<pre class="cmd-line">
login1$ <b>showq</b>                 # show all jobs; default format
login1$ <b>showq -u</b>              # show your own jobs
login1$ <b>showq -U bjones</b>       # show jobs associated with user bjones
login1$ <b>showq -h</b>              # more info</pre>

The output groups jobs in four categories: `ACTIVE`, `WAITING`, `BLOCKED`, and `COMPLETING/ERRORED`. A `BLOCKED` job is one that cannot yet run due to temporary circumstances (e.g. a pending maintenance or other large reservation.).

If your waiting job cannot complete before a maintenance/reservation begins, `showq` will display its state as `**WaitNod**` ("Waiting for Nodes"). The job will remain in this state until Frontera returns to production.

The default format for `showq` now reports total nodes associated with a job rather than cores, tasks, or hardware threads. One reason for this change is clarity: the operating system sees each compute node's 56 hardware threads as "processors", and output based on that information can be ambiguous or otherwise difficult to interpret.

**It is not possible to add resources to a job (e.g. allow more time)** once you've submitted the job to the queue.

To **cancel** a pending or running job, first determine its jobid, then use `scancel`:

<pre class="cmd-line">
login1$ <b>squeue -u bjones</b>    # one way to determine jobid
   JOBID   PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
  170361      normal   spec12   bjones PD       0:00     32 (Resources)
login1$ <b>scancel 170361</b>      # cancel job</pre>

For **detailed information** about the configuration of a specific job, use `scontrol`:

<pre class="cmd-line">login1$ <b>scontrol show job=170361</b></pre>

To view some **accounting data** associated with your own jobs, use `sacct`:

<pre class="cmd-line">login1$ <b>sacct --starttime 2019-06-01</b>  # show jobs that started on or after this date</pre>

### [Dependent Jobs using `sbatch`](#monitoring-dependent) { #monitoring-dependent }

You can use `sbatch` to help manage workflows that involve multiple steps: the `--dependency` option allows you to launch jobs that depend on the completion (or successful completion) of another job. For example you could use this technique to split into three jobs a workflow that requires you to (1) compile on a single node; then (2) compute on 40 nodes; then finally (3) post-process your results using 4 nodes. 

<pre class="cmd-line">login1$ <b>sbatch --dependency=afterok:173210 myjobscript</b></pre>

For more information see the [Slurm online documentation](http://www.schedmd.com). Note that you can use `$SLURM_JOBID` from one job to find the jobid you'll need to construct the `sbatch` launch line for a subsequent one. But also remember that you can't use `sbatch` to submit a job from a compute node.

## [Building Software](#building)

<p class="introtext">The phrase "building software" is a common way to describe the process of producing a machine-readable executable file from source files written in C, Fortran, or some other programming language. In its simplest form, building software involves a simple, one-line call or short shell script that invokes a compiler. More typically, the process leverages the power of <a href="http://www.gnu.org/software/make/manual/make.html">makefiles</a>, so you can change a line or two in the source code, then rebuild in a systematic way only the components affected by the change. Increasingly, however, the build process is a sophisticated multi-step automated workflow managed by a special framework like <a href="http://www.gnu.org/software/automake/manual/html_node/Autotools-Introduction.html">autotools</a> or <a href="http://cmake.org"><code>cmake</code></a>, intended to achieve a repeatable, maintainable, portable mechanism for installing software across a wide range of target platforms.</p>

### [The Basics of Building Software](#building-basics)

This section of the user guide does nothing more than introduce the big ideas with simple one-line examples. You will undoubtedly want to explore these concepts more deeply using online resources. You will quickly outgrow the examples here. We recommend that you master the basics of makefiles as quickly as possible: even the simplest computational research project will benefit enormously from the power and flexibility of a makefile-based build process.

#### [Intel Compilers](#building-basics-intel)

Intel is the recommended and default compiler suite on Frontera. Each Intel module also gives you direct access to `mkl` without loading an `mkl` module; see [Intel MKL](#the-intel-math-kernel-library-mkl) for more information. Here are simple examples that use the Intel compiler to build an executable from source code:


Compiling a code that uses OpenMP would look like this:

<pre class="cmd-line">
$ <b>icc -qopenmp mycode.c -o myexe</b>  # OpenMP
</pre>

See the published Intel documentation, available both [online](http://software.intel.com/en-us/intel-software-technical-documentation) and in `${TACC_INTEL_DIR}/documentation`, for information on optimization flags and other Intel compiler options.

#### [GNU Compilers](#building-basics-gnu)

The GNU foundation maintains a number of high quality compilers, including a compiler for C (`gcc`), C++ (`g++`), and Fortran (`gfortran`). The `gcc` compiler is the foundation underneath all three, and the term `gcc` often means the suite of these three GNU compilers.

Load a `gcc` module to access a recent version of the GNU compiler suite. Avoid using the GNU compilers that are available without a `gcc` module &mdash; those will be older versions based on the "system gcc" that comes as part of the Linux distribution.

Here are simple examples that use the GNU compilers to produce an executable from source code:

<pre class="cmd-line">
$ <b>gcc mycode.c</b>                    # C source file; executable a.out
$ <b>gcc mycode.c          -o myexe</b>  # C source file; executable myexe
$ <b>g++ mycode.cpp        -o myexe</b>  # C++ source file
$ <b>gfortran mycode.f90   -o myexe</b>  # Fortran90 source file
$ <b>gcc -fopenmp mycode.c -o myexe</b>  # OpenMP; GNU flag is different than Intel
</pre>

Note that some compiler options are the same for both Intel and GNU <span style="white-space: nowrap;">(e.g. `-o`)</span>, while others are different (e.g. `-qopenmp` vs `-fopenmp`). Many options are available in one compiler suite but not the other. See the [online GNU documentation](https://gcc.gnu.org/onlinedocs/) for information on optimization flags and other GNU compiler options.

#### [Compiling and Linking as Separate Steps](#building-basics-steps)

Building an executable requires two separate steps: (1) compiling (generating a binary object file associated with each source file); and (2) linking (combining those object files into a single executable file that also specifies the libraries that executable needs). The examples in the previous section accomplish these two steps in a single call to the compiler. When building more sophisticated applications or libraries, however, it is often necessary or helpful to accomplish these two steps separately.

Use the `-c` ("compile") flag to produce object files from source files:

<pre class="cmd-line">
$ <b>icc -c main.c calc.c results.c</b>
</pre>

Barring errors, this command will produce object files `main.o`, `calc.o`, and `results.o`. Syntax for other compilers Intel and GNU compilers is similar.

You can now link the object files to produce an executable file:

<pre class="cmd-line">
$ <b>icc main.o calc.o results.o -o myexe</b>
</pre>

The compiler calls a linker utility (usually `/bin/ld`) to accomplish this task. Again, syntax for other compilers is similar.

#### [Include and Library Paths](#building-basics-paths)

Software often depends on pre-compiled binaries called libraries. When this is true, compiling usually requires using the `-I` option to specify paths to so-called header or include files that define interfaces to the procedures and data in those libraries. Similarly, linking often requires using the `-L` option to specify paths to the libraries themselves. Typical compile and link lines might look like this:

<pre class="cmd-line">
$ <b>icc        -c main.c -I${WORK}/mylib/inc -I${TACC_HDF5_INC}</b>                  # compile
$ <b>icc main.o -o myexe  -L${WORK}/mylib/lib -L${TACC_HDF5_LIB} -lmylib -lhdf5</b>   # link
</pre>

On Frontera, both the `hdf5` and `phdf5` modules define the environment variables `$TACC_HDF5_INC` and `$TACC_HDF5_LIB`. Other module files define similar environment variables; see [Using Modules](../admin#using-modules-to-manage-your-environment) for more information.

The details of the linking process vary, and order sometimes matters. Much depends on the type of library: static (`.a` suffix; library's binary code becomes part of executable image at link time) versus dynamically-linked shared (.so suffix; library's binary code is not part of executable; it's located and loaded into memory at run time). The link line can use rpath to store in the executable an explicit path to a shared library. In general, however, the `LD_LIBRARY_PATH` environment variable specifies the search path for dynamic libraries. For software installed at the system-level, TACC's modules generally modify `LD_LIBRARY_PATH` automatically. To see whether and how an executable named `myexe` resolves dependencies on dynamically linked libraries, execute `ldd myexe`.

A separate section below addresses the [Intel Math Kernel Library](#the-intel-math-kernel-library-mkl) (MKL).

#### [Compiling and Linking MPI Programs](#building-basics-mpi)

Intel MPI (module `impi`) and MVAPICH2 (module `mvapich2`) are the two MPI libraries available on Frontera. After loading an `impi` or `mvapich2` module, compile and/or link using an mpi wrapper (`mpicc`, `mpicxx`, `mpif90`) in place of the compiler:

<pre class="cmd-line">
$ <b>mpicc    mycode.c   -o myexe</b>   # C source, full build
$ <b>mpicc -c mycode.c</b>              # C source, compile without linking
$ <b>mpicxx   mycode.cpp -o myexe</b>   # C++ source, full build
$ <b>mpif90   mycode.f90 -o myexe</b>   # Fortran source, full build
</pre>

These wrappers call the compiler with the options, include paths, and libraries necessary to produce an MPI executable using the MPI module you're using. To see the effect of a given wrapper, call it with the `-show` option:

<pre class="cmd-line">
$ <b>mpicc -show</b>  # Show compile line generated by call to mpicc; similarly for other wrappers
</pre>


#### [Building Third-Party Software](#building-basics-thirdparty)

You can discover already installed software using TACC's [Software Search](https://www.tacc.utexas.edu/systems/software) tool or execute `module spider` or `module avail` on the command-line.

You're welcome to download third-party research software and install it in your own account. In most cases you'll want to download the source code and build the software so it's compatible with the Frontera software environment. You can't use yum or any other installation process that requires elevated privileges, but this is almost never necessary. The key is to specify an installation directory for which you have write permissions. Details vary; you should consult the package's documentation and be prepared to experiment. When using the famous [three-step autotools](http://www.gnu.org/software/automake/manual/html_node/Autotools-Introduction.html) build process, the standard approach is to use the `PREFIX` environment variable to specify a non-default, user-owned installation directory at the time you execute `configure` or `make`:

<pre class="cmd-line">
$ <b>export INSTALLDIR=$WORK/apps/t3pio</b>
$ <b>./configure --prefix=$INSTALLDIR</b>
$ <b>make</b>
$ <b>make install</b>
</pre>

Other languages, frameworks, and build systems generally have equivalent mechanisms for installing software in user space. In most cases a web search like "Python Linux install local" will get you the information you need.

In Python, a local install will resemble one of the following examples:

<pre class="cmd-line">
$ <b>pip install netCDF4      --user</b>                   # install netCDF4 package to $HOME/.local
$ <b>python3 setup.py install --user</b>                   # install to $HOME/.local
$ <b>pip3 install netCDF4     --prefix=$INSTALLDIR</b>     # custom location; add to PYTHONPATH
</pre>

Similarly in R:

<pre class="cmd-line">
$ <b>module load Rstats</b>            # load TACC's default R
$ <b>R</b>                             # launch R
> <b>install.packages('devtools')</b>  # R will prompt for install location
</pre>
 
You may, of course, need to customize the build process in other ways. It's likely, for example, that you'll need to edit a `makefile` or other build artifacts to specify Frontera-specific [include and library paths](#include-and-library-paths) or other compiler settings. A good way to proceed is to write a shell script that implements the entire process: definitions of environment variables, module commands, and calls to the build utilities. Include `echo` statements with appropriate diagnostics. Run the script until you encounter an error. Research and fix the current problem. Document your experience in the script itself; including dead-ends, alternatives, and lessons learned. Re-run the script to get to the next error, then repeat until done. When you're finished, you'll have a repeatable process that you can archive until it's time to update the software or move to a new machine.

If you wish to share a software package with collaborators, you may need to modify file permissions. See [Sharing Files with Collaborators][TACCSHARINGPROJECTFILES] for more information.

### [The Intel Math Kernel Library (MKL)](#building-mkl)

The [Intel Math Kernel Library](http://software.intel.com/intel-mkl) (MKL) is a collection of highly optimized functions implementing some of the most important mathematical kernels used in computational science, including standardized interfaces to:

* [BLAS](http://netlib.org/blas) (Basic Linear Algebra Subroutines), a collection of low-level matrix and vector operations like matrix-matrix multiplication 
* [LAPACK](http://netlib.org/lapack) (Linear Algebra PACKage), which includes higher-level linear algebra algorithms like Gaussian Elimination
* FFT (Fast Fourier Transform), including interfaces based on [FFTW](http://fftw.org) (Fastest Fourier Transform in the West)
* [ScaLAPACK](http://netlib.org/scalapack) (Scalable LAPACK), [BLACS](http://netlib.org/blacs) (Basic Linear Algebra Communication Subprograms), Cluster FFT, and other functionality that provide block-based distributed memory (multi-node) versions of selected [LAPACK](https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines), [BLAS](https://software.intel.com/en-us/mkl-developer-reference-c-blas-and-sparse-blas-routines), and [FFT](https://software.intel.com/en-us/mkl-developer-reference-c-fft-functions) algorithms;
* [Vector Mathematics](http://software.intel.com/en-us/node/521751) (VM) functions that implement highly optimized and vectorized versions of special functions like sine and square root.

#### [MKL with Intel Compilers](#building-mkl-intel)

There is no MKL module for the Intel compilers because you don't need one: the Intel compilers have built-in support for MKL. Unless you have specialized needs, there is no need to specify include paths and libraries explicitly. Instead, using MKL with the Intel modules requires nothing more than compiling and linking with the <span style="white-space: nowrap;">`-mkl`</span> option.; e.g.

<pre class="cmd-line">
$ <b>icc   -mkl mycode.c</b>
$ <b>ifort -mkl mycode.c</b></pre>

The `-mkl` switch is an abbreviated form of <span style="white-space: nowrap;">`-mkl=parallel`</span>, which links your code to the threaded version of MKL. To link to the unthreaded version, use <span style="white-space: nowrap;">`-mkl=sequential`</span>. A third option, <span style="white-space: nowrap;">`-mkl=cluster`</span>, which also links to the unthreaded libraries, is necessary and appropriate only when using ScaLAPACK or other distributed memory packages. For additional information, including advanced linking options, see Intel's [MKL documentation](http://software.intel.com/intel-mkl) and [Intel MKL Link Line Advisor](http://software.intel.com/en-us/articles/intel-mkl-link-line-advisor).


#### [MKL with GNU Compilers](#building-mkl-gnu)

When using a GNU compiler, load the MKL module before compiling or running your code, then specify explicitly the MKL libraries, library paths, and include paths your application needs. Consult the [Intel MKL Link Line Advisor](http://software.intel.com/en-us/articles/intel-mkl-link-line-advisor) for details. A typical compile/link process on a TACC system will look like this:

<pre class="cmd-line">
$ <b>module load gcc</b>
$ <b>module load mkl</b>                         # available/needed only for GNU compilers
$ <b>gcc -fopenmp -I$MKLROOT/include         \
		 -Wl,-L${MKLROOT}/lib/intel64     \
		 -lmkl_intel_lp64 -lmkl_core      \
		 -lmkl_gnu_thread -lpthread       \
		 -lm -ldl mycode.c</b>
</pre>

For your convenience the `mkl` module file also provides alternative TACC-defined variables like `$TACC_MKL_INCLUDE` (equivalent to `$MKLROOT/include`). Execute `module help mkl` for more information.

#### [MKL with BLAS/LAPACK and Third-Party Software](#building-mkl-thirdparty)

When your third-party software requires BLAS or LAPACK, you can use MKL to supply this functionality. Replace generic instructions that include link options like <span style="white-space: nowrap;">`-lblas`</span> or <span style="white-space: nowrap;">`-llapack`</span> with the simpler MKL approach described above. There is no need to download and install alternatives like OpenBLAS.

#### [MKL with BLAS/LAPACK and TACC's MATLAB, Python, and R Modules](#building-mkl-blas)

TACC's MATLAB, Python, and R modules all use threaded (parallel) MKL as their underlying BLAS/LAPACK library. These means that even serial codes written in MATLAB, Python, or R may benefit from MKL's thread-based parallelism. This requires no action on your part other than specifying an appropriate max thread count for MKL. 

#### [Controlling Threading in MKL](#building-mkl-threading)

Any code that calls MKL functions can potentially benefit from MKL's thread-based parallelism; this is true even if your code is not otherwise a parallel application. If you are linking to the threaded MKL (using <span style="white-space: nowrap;">`-mkl`</span>, <span style="white-space: nowrap;">`-mkl=parallel`</span>, or the equivalent explicit link line), you need only specify an appropriate value for the max number of threads available to MKL. You can do this with either of the two environment variables `MKL_NUM_THREADS` or `OMP_NUM_THREADS`. The environment variable `MKL_NUM_THREADS` specifies the max number of threads available to each instance of MKL, and has no effect on non-MKL code. If `MKL_NUM_THREADS` is undefined, MKL uses `OMP_NUM_THREADS` to determine the max number of threads available to MKL functions. In either case, MKL will attempt to choose an optimal thread count less than or equal to the specified value. Note that `OMP_NUM_THREADS` defaults to 1 on TACC systems; if you use the default value you will get no thread-based parallelism from MKL.

If you are running a single serial, unthreaded application (or an unthreaded MPI code involving a single MPI task per node) it is usually best to give MKL as much flexibility as possible by setting the max thread count to the total number of hardware threads on the node (56 on CLX). Of course things are more complicated if you are running more than one process on a node: e.g. multiple serial processes, threaded applications, hybrid MPI-threaded applications, or pure MPI codes running more than one MPI rank per node. See [Settings for Calling Intel® Math Kernel Library Routines from Multi-Threaded Applications](http://software.intel.com/en-us/articles/recommended-settings-for-calling-intel-mkl-routines-from-multi-threaded-applications) and related Intel resources for examples of how to manage threading when calling MKL from multiple processes. 

#### [Using ScaLAPACK, Cluster FFT, and Other MKL Cluster Capabilities](#building-mkl-cluster)

See [Working with the Intel Math Kernel Library Cluster Software](https://software.intel.com/en-us/mkl-linux-developer-guide-working-with-the-intel-math-kernel-library-cluster-software) and [Intel MKL Link Line Advisor](http://software.intel.com/en-us/articles/intel-mkl-link-line-advisor) for information on linking to the MKL cluster components.
		
### [Building for Performance on Frontera](#building-performance)

#### [Recommended Compiler](#building-performance-compiler)

When building software on Frontera, we recommend using the Intel compiler and Intel MPI stack. This will be the default in the early user period, but may change if we determine one of the other MPI stacks provides superior performance. 

#### [Architecture-Specific Flags](#building-performance-flags)

To compile for CLX only, include `-xCORE-AVX512` as a build option. The `-x` switch allows you to specify a target architecture. The CLX chips, as well as the Skylake chips (SKX) on Stampede2, support Intel's latest instruction set, CORE-AVX512. You should also consider specifying an optimization level using the `-O` flag:

<pre class="cmd-line">
$ <b>icc   -xCORE-AVX512  -O3 mycode.c   -o myexe</b>         # will run only on CLX/SKX
$ <b>ifort  -xCORE-AVX512 -O3 mycode.f90 -o myexe</b>         # will run only on CLX/SKX
</pre>

It's best to avoid building with `-xHost` (a flag that means "optimize for the architecture on which I'm compiling now"). Although this will work on Frontera, since the Frontera login nodes are all CLX nodes, if you build on another system, your binary will be based on whatever architecture you built upon. This may not be the same as the architecture on which you will be running.

Also, you should not use the `-fast` flag for the Intel compiler. This flag sets the following options:

<p class="syntax">-ipo -O3 -no-prec-div -static -fp-model fast=2 -xHost</p>

Frontera software libraries, including the MPI libraries, are installed as shared libraries in most cases. The `-static` flag included in `-fast` will cause the compile to fail at the link stage. If you’d like to use the other flags, you’ll have to include each option individually.

For information on the performance implications of your choice of build flags, see the sections on Programming and Performance for CLX.

If you use GNU compilers, see GNU x86 Options for information regarding support for CLX. 

## [Programming and Performance](#programming) { #programming } 

### [Programming and Performance: General](#programming-general) { #programming-general } 
<p class="introtext">Programming for performance is a broad and rich topic. While there are no shortcuts, there are certainly some basic principles that are worth considering any time you write or modify code.</p>


#### [Timing and Profiling](#programming-general-profiling) { #programming-general-profiling } 

**Measure performance and experiment with both compiler and runtime options.** This will help you gain insight into issues and opportunities, as well as recognize the performance impact of code changes and temporary system conditions.

Measuring performance can be as simple as prepending the shell keyword `time` or the command `perf stat` to your launch line. Both are simple to use and require no code changes. Typical calls look like this:

<pre class="cmd-line">
$ <b>perf stat ./a.out</b>    # report basic performance stats for a.out
$ <b>time ./a.out</b>         # report the time required to execute a.out
$ <b>time ibrun ./a.out</b>   # time an MPI code
$ <b>ibrun time ./a.out</b>   # crude timings for each MPI task (no rank info)</pre>

As your needs evolve you can add timing intrinsics to your source code to time specific loops or other sections of code. There are many such intrinsics available; some popular choices include [`gettimeofday`](http://man7.org/linux/man-pages/man2/gettimeofday.2.html), [`MPI_Wtime`](https://www.mpich.org/static/docs/v3.2/www3/MPI_Wtime.html) and [`omp_get_wtime`](https://www.openmp.org/spec-html/5.0/openmpsu160.html). The resolution and overhead associated with each of these timers is on the order of a microsecond.

It can be helpful to compare results with different compiler and runtime options: e.g. with and without [vectorization](http://software.intel.com/en-us/fortran-compiler-18.0-developer-guide-and-reference-vec-qvec), [threading](../launching#launching-one-multi-threaded-application), or [Lustre striping](../files#striping-large-files). You may also want to learn to use profiling tools like [Intel VTune Amplifier](http://software.intel.com/en-us/intel-vtune-amplifier-xe) <span style="white-space: nowrap;">(`module load vtune`)</span> or GNU [`gprof`](http://sourceware.org/binutils/docs/gprof/).

#### [Data Locality](#programming-general-datalocality) { #programming-general-datalocality } 

**Appreciate the high cost (performance penalty) of moving data from one node to another**, from disk to RAM, and even from RAM to cache. Write your code to keep data as close to the computation as possible: e.g. in RAM when needed, and on the node that needs it. This means keeping in mind the capacity and characteristics of each level of the memory hierarchy when designing your code and planning your simulations. 

When possible, best practice also calls for so-called "stride 1 access" -- looping through large, contiguous blocks of data, touching items that are adjacent in memory as the loop proceeds. The goal here is to use "nearby" data that is already in cache rather than going back to main memory (a cache miss) in every loop iteration.

To achieve stride 1 access you need to understand how your program stores its data. Here C and C++ are different than (in fact the opposite of) Fortran. C and C++ are row-major: they store 2d arrays a row at a time, so elements `a[3][4]` and `a[3][5]` are adjacent in memory. Fortran, on the other hand, is column-major: it stores a column at a time, so elements `a(4,3)` and `a(5,3)` are adjacent in memory. Loops that achieve stride 1 access in the two languages look like this:

<table border="1" cellspacing="3" cellpadding="3">
<tr><th>Fortran example</th><th>C example</th></tr>
<tr><td>
<pre class="syntax">
real&42;8 :: a(m,n), b(m,n), c(m,n)
&nbsp;...
&#33; inner loop strides through col i
do i=1,n
&nbsp;&nbsp;do j=1,m
&nbsp;&nbsp;&nbsp;&nbsp;a(j,i)=b(j,i)+c(j,i)
&nbsp;&nbsp;end do
end do</pre>
</td>
<td><pre class="syntax">
double a[m][n], b[m][n], c[m][n];
&nbsp;...
&#47;&#47; inner loop strides through row i
for (i=0;i&lt;m;i++){
&nbsp;&nbsp;for (j=0;j&lt;n;j++){
&nbsp;&nbsp;&nbsp;&nbsp;a[i][j]=b[i][j]+c[i][j];
&nbsp;&nbsp;}
}</pre>
</td></tr>
</table>


#### [Vectorization](#programming-vectorization) { #programming-vectorization } 

**Give the compiler a chance to produce efficient, [vectorized](http://software.intel.com/en-us/articles/vectorization-essential) code**. The compiler can do this best when your inner loops are simple (e.g. no complex logic and a straightforward matrix update like the ones in the examples above), long (many iterations), and avoid complex data structures (e.g. objects). See Intel's note on [Programming Guidelines for Vectorization](http://software.intel.com/en-us/node/522571) for a nice summary of the factors that affect the compiler's ability to vectorize loops.

It's often worthwhile to generate [optimization and vectorization reports](http://software.intel.com/en-us/articles/getting-the-most-out-of-your-intel-compiler-with-the-new-optimization-reports) when using the Intel compiler. This will allow you to see exactly what the compiler did and did not do with each loop, together with reasons why.

#### [Learning More](#programming-more) { #programming-more } 

The literature on optimization is vast. Some places to begin a systematic study of optimization on Intel processors include: Intel's [Modern Code](http://software.intel.com/en-us/modern-code) resources; the [Intel Optimization Reference Manual](http://intel.com/content/www/us/en/architecture-and-technology/64-ia-32-architectures-optimization-manual); and [TACC training materials](https://learn.tacc.utexas.edu/course/).

### [Programming and Performance: CLX](#programming-clx) { #programming-clx } 

<!-- span style="color:red">**Hyperthreading.** Hyperthreading is not enabled on Frontera.</span> It is rarely a good idea to use 96 hardware threads simultaneously**, and it's certainly not the first thing you should try. In most cases it's best to specify no more than 48 MPI tasks or independent processes per node, and 1-2 threads/core. One exception is worth noting: when calling threaded MKL from a serial code, it's safe to set `OMP_NUM_THREADS` or `MKL_NUM_THREADS` to 96. This is because MKL will choose an appropriate thread count less than or equal to the value you specify. See [Controlling Threading in MKL](#mkl-threading) for more information.  In any case remember that the default value of `OMP_NUM_THREADS` is 1.-->

**Clock Speed.** The published nominal clock speed of the Frontera CLX processors is 2.7GHz. But [actual clock speed varies widely](https://www.intel.com/content/www/us/en/architecture-and-technology/turbo-boost/turbo-boost-technology.html): it depends on the vector instruction set, number of active cores, and other factors affecting power requirements and temperature limits. At one extreme, a single serial application using the `AVX2` instruction set may run at frequencies approaching 3.7GHz, because it's running on a single core (in fact a single hardware thread). At the other extreme, a large, fully-threaded MKL `dgemm` (a highly vectorized routine in which all cores operate at nearly full throttle) may run at 2.4GHz.

**Vector Optimization and `AVX2`.** In some cases, using the `AVX2` instruction set may produce better performance than `AVX512`. This is largely because cores can run at higher clock speeds when executing `AVX2` code. To compile for `AVX2`, replace the [multi-architecture flags](../building/#architecture-specific-flags) described above with the single flag <span style="white-space: nowrap;">`-xCORE-AVX2`</span>. When you use this flag you will be able to build and run on any Frontera node.

**Vector Optimization and 512-Bit ZMM Registers.** If your code can take advantage of wide 512-bit vector registers, you may want to try [compiling for CLX](../building#recommended-compiler) with (for example):

<pre class="syntax">-xCORE-AVX512 -qopt-zmm-usage=high</pre>

The <span style="white-space: nowrap;">`qopt-zmm-usage`</span> flag affects the algorithms the compiler uses to decide whether to vectorize a given loop with 512 intrinsics (wide 512-bit registers) or `AVX2` code (256-bit registers). When the flag is set to <span style="white-space: nowrap;">`-qopt-zmm-usage=low`</span> (the default when compiling for the CLX using <span style="white-space: nowrap;">`CORE-AVX512`)</span>, the compiler will choose `AVX2` code more often; this may or may not be the optimal approach for your application. The <span style="white-space: nowrap;">`qopt-zmm-usage`</span> flag is available only on Intel compilers newer than 17.0.4. Do not use [`$TACC_VEC_FLAGS`](../building#architecture-specific-flags) when specifying <span style="white-space: nowrap;">`qopt-zmm-usage`</span>. This is because `$TACC_VEC_FLAGS` specifies <span style="white-space: nowrap;">`CORE-AVX2`</span> as the base architecture, and the compiler will ignore <span style="white-space: nowrap;">`qopt-zmm-usage`</span> unless the base target is a variant of `AVX512`. See the recent [Intel white paper](https://software.intel.com/en-us/articles/tuning-simd-vectorization-when-targeting-intel-xeon-processor-scalable-family), the [compiler documentation](https://software.intel.com/en-us/cpp-compiler-18.0-developer-guide-and-reference-qopt-zmm-usage-qopt-zmm-usage), the compiler man pages, and the notes above for more information.

**Task Affinity.** If you run one MPI application at a time, the `ibrun` MPI launcher will spread each node's tasks evenly across an CLX node's two sockets, with consecutive tasks occupying the same socket when possible.

**Core Numbering.** Execute "`lscpu`" or "`lstopo`" on a CLX node to see the numbering scheme for socket cores. Note that core numbers alternate between the sockets: even numbered cores are on socket 0 (NUMA node 0), while odd numbered cores are on socket 1 (NUMA node 1).<!-- 06/10/2019 hyperthreading not enabled Furthermore, the two hardware threads on a given core have thread numbers that differ by exactly 48 (e.g. threads 3 and 51 are on the same core). -->


### [File Operations: I/O Performance](#programming-fileio) { #programming-fileio } 

This section includes general advice intended to help you achieve good performance during file operations. See [Navigating the Shared File Systems](../files#navigating-the-shared-filesystems) for a brief overview of Frontera's Lustre file systems and the concept of striping. See [TACC Training material](https://learn.tacc.utexas.edu/) for additional information on I/O performance.

**Follow the advice in [Good Conduct](../conduct#do-not-stress-the-shared-lustre-file-systems)** to avoid stressing the file system.

**Stripe for performance**. If your application writes large files using MPI-based parallel I/O (including [MPI-IO](http://mpi-forum.org/docs/mpi-3.1/mpi31-report.pdf), [parallel HDF5](https://support.hdfgroup.org/HDF5/PHDF5/), and [parallel netCDF](https://www.unidata.ucar.edu/software/netcdf/docs/parallel_io.html), you should experiment with stripe counts larger than the default values (2 stripes on `$SCRATCH`, 1 stripe on `$WORK`). See [Striping Large Files](../files/#striping-large-files) for the simplest way to set the stripe count on the directory in which you will create new output files. You may also want to try larger stripe sizes up to 16MB or even 32MB; execute `man lfs` for more information. If you write many small files you should probably leave the stripe count at its default value, especially if you write each file from a single process. Note that it's not possible to change the stripe parameters on files that already exist. This means that you should make decisions about striping when you *create* input files, not when you read them.

**Aggregate file operations**. Open and close files once. Read and write large, contiguous blocks of data at a time; this requires understanding how a given programming language uses memory to [store arrays](#data-locality).

**Be smart about your general strategy**. When possible avoid an I/O strategy that requires each process to access its own files; such strategies don't scale well and are likely to stress a Lustre file system. A better approach is to use a single process to read and write files. Even better is genuinely parallel MPI-based I/O.

**Use parallel I/O libraries**. Leave the details to a high performance package like [MPI-IO](http://mpi-forum.org/docs/mpi-3.1/mpi31-report.pdf) (built into MPI itself), [parallel HDF5](https://support.hdfgroup.org/HDF5/PHDF5/) <span style="white-space: nowrap;">(`module load phdf5`)</span>, and [parallel netCDF](https://www.unidata.ucar.edu/software/netcdf/docs/parallel_io.html) <span style="white-space: nowrap;">(`module load pnetcdf`)</span>.

When using the Intel Fortran compiler, **compile with [`-assume buffered_io`](https://software.intel.com/en-us/fortran-compiler-18.0-developer-guide-and-reference-assume)**. Equivalently, set the environment variable [`FORT_BUFFERED=TRUE`](https://software.intel.com/en-us/node/680054). Doing otherwise can dramatically slow down access to variable length unformatted files. More generally, direct access in Fortran is typically faster than sequential access, and accessing a binary file is faster than ASCII.

## [Machine Learning on Frontera](#ml) { #ml }

Frontera is well equipped to provide researchers with the latest in Machine Learning frameworks, PyTorch and Tensorflow. We recommend using the Python virtual environment to manage machine learning packages.

### [Running PyTorch ](#ml-pytorch) { #ml-pytorch }

1. Request a single compute node in Frontera's `rtx-dev` queue using the [`idev`](https://portal.tacc.utexas.edu/software/idev) utility:

	<pre class="cmd-line">login2.frontera$ <b>idev -N 1 -n 1 -p rtx-dev -t 02:00:00</b></pre>

1. Create a Python virtual environment

	<pre class="cmd-line">c123-456$ <b>python3 -m venv /path/to/virtual-env</b>  # (e.g., $SCRATCH/python-envs/test)</pre>

1. Activate the Python virtual environment

	<pre class="cmd-line">c123-456$ <b>source /path/to/virtual-env/bin/activate</b></pre>

1. Install PyTorch 

	<pre class="cmd-line">c123-456$ <b>pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113</b></pre>

#### [Single-Node](#ml-pytorch-single) { #ml-pytorch-single }

1. Download the benchmark:

	<pre class="cmd-line">
	c123-456$ <b>cd $SCRATCH</b>
	c123-456$ <b>git clone https://github.com/gpauloski/kfac-pytorch.git</b>
	c123-456$ <b>cd kfac-pytorch</b>
	c123-456$ <b>git checkout tags/v0.3.2</b>
	c123-456$ <b>pip3 install -e .</b>
	c123-456$ <b>pip3 install torchinfo tqdm Pillow</b>
	c123-456$ <b>export LD_LIBRARY_PATH=/usr/lib64:$LD_LIBRARY_PATH</b></pre>

1. Run the benchmark on one node (4 GPUs):

	<pre class="cmd-line">c123-456$ <b>python3 -m torch.distributed.launch --nproc_per_node=4 examples/torch_cifar10_resnet.py --kfac-update-freq 0</b></pre>

#### [Multi-Node](#ml-pytorch-multi) { #ml-pytorch-multi }

1. Request two nodes in the `rtx-dev` queue using the [`idev`](https://portal.tacc.utexas.edu/software/idev) utility:

	<pre class="cmd-line">login2.frontera$ <b>idev -N 2 -n 2 -p rtx-dev -t 02:00:00</b></pre>

1. Go to the benchmark directory:

	<pre class="cmd-line">c123-456$ <b>cd $SCRATCH/kfac-pytorch</b></pre>

1. Create a script called "`run.sh`". This script needs two parameters, the hostname of the master node and the number of nodes.

	<pre class="job-script">
	&#35;!/bin/bash

	HOST=$1
	NODES=$2
	LOCAL_RANK=${PMI_RANK}

	python3 -m torch.distributed.launch --nproc_per_node=4 --nnodes=$NODES --node_rank=${LOCAL_RANK} --master_addr=$HOST \
	   examples/torch_cifar10_resnet.py --kfac-update-freq 0</pre>


1. Run multi-gpu training:
	
	<pre class="cmd-line">c123-456$ <b>ibrun -np 2 ./run.sh c123-456 2</b></pre>


### [Running Tensorflow ](#ml-tensorflow) { #ml-tensorflow }

Follow these instructions to install and run TensorFlow benchmarks on Frontera RTX. Frontera RTX runs TensorFlow 2.8.0 with Python 3.8.2. Frontera supports CUDA/10.1, CUDA/11.0, and CUDA/11.1. By default, we use CUDA/11.3. Select the appropriate CUDA version for your TensorFlow version.

1. Request a single compute node in Frontera's `rtx-dev` queue using the [`idev`](https://portal.tacc.utexas.edu/software/idev) utility:

	<pre class="cmd-line">login2.frontera$ <b>idev -N 1 -n 1 -p rtx-dev -t 02:00:00</b></pre>

1. Create a Python virtual environment:

	<pre class="cmd-line">c123-456$ <b>python3 -m venv /path/to/virtual-env</b> # e.g., $SCRATCH/python-envs/test</pre>

1. Activate the Python virtual environment:

	<pre class="cmd-line">c123-456$ <b>source /path/to/virtual-env/bin/activate</b></pre>

1. Install TensorFlow and Horovod

	<pre class="cmd-line">
	c123-456$ <b>module load cuda/11.3 cudnn nccl</b>
	c123-456$ <b>pip3 install tensorflow-gpu==2.8.2</b></pre>

	We suggest installing Horovod version 0.25.0. If you wish to install other versions of Horovod, please submit a support ticket with the subject "Request for Horovod" and TACC staff will provide special instructions.

	<pre class="cmd-line">c123-456$ <b>HOROVOD_CUDA_HOME=$TACC_CUDA_DIR HOROVOD_NCCL_HOME=$TACC_NCCL_DIR CC=gcc \
    	HOROVOD_GPU_ALLREDUCE=NCCL HOROVOD_GPU_BROADCAST=NCCL HOROVOD_WITH_TENSORFLOW=1 pip3 install horovod==0.25.0</b></pre>

#### [Single-Node](#ml-tensorflow-single) { ml-tensorflow-single }

1. Download the tensorflow benchmark to your $SCRATCH directory, then check out the branch that matches your tensorflow version.

	<pre class="cmd-line">
	c123-456$ <b>cds; git clone https://github.com/tensorflow/benchmarks.git</b>
	c123-456$ <b>cd benchmarks</b> 
	c123-456$ <b>git checkout 51d647f</b>     # master head as of 08/18/2022</pre>

1. Activate the Python virtual environment

	<pre class="cmd-line">c123-456$ <b>source /path/to/virtual-env/bin/activate</b></pre>

1. Benchmark the performance with synthetic dataset on 1 GPU

	<pre class="cmd-line">
	c123-456$ <b>cd scripts/tf_cnn_benchmarks</b>
	c123-456$ <b>python3 tf_cnn_benchmarks.py --num_gpus=1 --model resnet50 --batch_size 32 --num_batches 200</b></pre>

1. Benchmark the performance with synthetic dataset on 4 GPUs

<pre class="cmd-line">
c123-456$ <b>cd scripts/tf_cnn_benchmarks</b>
c123-456$ <b>ibrun -np 4 python3 tf_cnn_benchmarks.py --variable_update=horovod --num_gpus=1 \
    --model resnet50 --batch_size 32 --num_batches 200 --allow_growth=True</b></pre>

#### [Multi-Node](#ml-tensorflow-multi) { #ml-tensorflow-multi }

*Coming Soon*
## [Visualization and Virtual Network Computing (VNC) Sessions](#vis)

<p class="introtext">Frontera uses Intel's Cascade Lake (CLX) processors for all visualization and rendering operations. We use the Intel OpenSWR library to render raster graphics with OpenGL, and the Intel OSPRay framework for ray traced images inside visualization software. OpenSWR can be loaded by executing "<code>module load swr</code>".</p>

Frontera currently has no separate visualization queue. All visualization apps are available on all nodes. VNC and DCV sessions are available on any queue, either through the command line or via the [TACC Visualization Portal](https://vis.tacc.utexas.edu/). We recommend submitting to Frontera's `development` queue for interactive sessions. If you are interested in an application that is not yet available, please submit a help desk ticket through the Frontera Portal.

### [emote Desktop Access](#vis)

Remote desktop access to Frontera is formed through a DCV or VNC connection to one or more compute nodes. Users must first connect to a Frontera login node (see [Accessing the System](../admin/#access-the-system) and submit a special interactive batch job that:


* allocates a set of Frontera compute nodes
* starts a `dcvserver` or `vncserver` remote desktop process on the first allocated node
* sets up a tunnel through the login node to the dcvserver or vncserver access port

Once the remote desktop process is running on the compute node and a tunnel through the login node is created, an output message identifies the access port for connecting a remote desktop viewer. A remote desktop viewer application is run on the user's remote system and presents the desktop to the user.

**Note**: If this is your first time connecting to Frontera using VNC, you must run `vncpasswd` to create a password for your VNC servers. This should NOT be your login password! This mechanism only deters unauthorized connections; it is not fully secure, as only the first eight characters of the password are saved. All VNC connections are tunneled through SSH for extra security, as described below.

Follow the steps below to start an interactive session.

1. Start a Remote Desktop

	TACC has provided a DCV job script (`/share/doc/slurm/job.dcv`), a VNC job script (`/share/doc/slurm/job.vnc`) and a combined job script that prefers DCV and fails over to VNC if a DCV license is not available (`/share/doc/slurm/job.dcv2vnc`). Each script requests one node in the development queue for two hours, creating a remote desktop session, either [DCV](https://aws.amazon.com/hpc/dcv) or [VNC](https://en.wikipedia.org/wiki/VNC).

	<pre class="cmd-line">
	login1$ <b>sbatch /share/doc/slurm/job.vnc</b>
	login1$ <b>sbatch /share/doc/slurm/job.dcv</b>
	login1$ <b>sbatch /share/doc/slurm/job.dcv2vnc</b></pre>

	You may modify or overwrite script defaults with sbatch command-line options (note: the command options must come between `sbatch` and the script):

	* <code>-t <i>hours:minutes:seconds</i></code> modify the job runtime
	* <code>-A <i>projectnumber</i></code> specify the project/allocation to be charged
	* <code>-N <i>nodes</i></code> specify number of nodes needed
	* <code>-p <i>partition</i></code> specify an alternate queue   


	See [Table 6.](../running/#table-6-common-sbatch-options) for more `sbatch` options.

	All arguments after the job script name are sent to the vncserver command. For example, to set the desktop resolution to 1440x900, use:

	<pre class="cmd-line">login1$ <b>sbatch /share/doc/slurm/job.vnc -geometry 1440x900</b></pre>

	The "`vnc.job`" script starts a `vncserver` process and writes to the output file, "`vncserver.out`" in the job submission directory, with the connect port for the vncviewer. 

	Note that the DCV viewer adjusts desktop resolution to your browser or DCV client, so desktop resolution does not need to be specified.

	Watch for the "To connect" message at the end of the output file, or watch the output stream in a separate window with the commands:

	<pre class="cmd-line">
	login1$ <b>touch vncserver.out ; tail -f vncserver.out</b>
	login1$ <b>touch dcvserver.out ; tail -f dcvserver.out</b></pre>

	The lightweight window manager, `xfce`, is the default DCV and VNC desktop and is recommended for remote performance. Gnome is available; to use gnome, open the "`~/.vnc/xstartup`" file (created after your first VNC session) and replace "`startxfce4`" with "`gnome-session`". Note that gnome may lag over slow internet connections.<p>&nbsp;</p>

1. Create an SSH Tunnel to Frontera

	DCV connections are encrypted via TLS and are secure. For VNC connections, TACC requires users to create an SSH tunnel from the local system to the Frontera login node to assure that the connection is secure. The tunnels created for the VNC job operate only on the `localhost` interface, so you must use `localhost` in the port forward argument, not the Frontera hostname. On a Unix or Linux system, execute the following command once the port has been opened on the Frontera login node:

	<pre class="cmd-line">localhost$ <b>ssh -f -N -L <i>xxxx</i>:localhost:<i>yyyy</i> <i>username</i>@frontera.tacc.utexas.edu</b></pre>

	where:

	* <code><i>yyyy</i></code> is the port number given by the vncserver batch job
	* <code><i>xxxx</i></code> is a port on the remote system. Generally, the port number specified on the Frontera login node, <code><i>yyyy</i></code>, is a good choice to use on your local system as well
	* `-f` instructs SSH to only forward ports, not to execute a remote command
	* `-N` puts the ssh command into the background after connecting
	* `-L` forwards the port   

	On Windows systems find the menu in the Windows SSH client where tunnels can be specified, and enter the local and remote ports as required, then ssh to Frontera.  <p>&nbsp;</p>


1. Connecting the vncviewer

	Once the SSH tunnel has been established, use a [VNC client](https://en.wikipedia.org/wiki/Virtual_Network_Computing) to connect to the local port you created, which will then be tunneled to your VNC server on Frontera. Connect to localhost:*xxxx*, where *xxxx* is the local port you used for your tunnel. In the examples above, we would connect the VNC client to <code>localhost::<i>xxxx</i></code>. (Some VNC clients accept <code>localhost:<i>xxxx</i></code>).

	We recommend the [TigerVNC](http://sourceforge.net/projects/tigervnc) VNC Client, a platform independent client/server application.

	Once the desktop has been established, two initial xterm windows are presented (which may be overlapping). One, which is white-on-black, manages the lifetime of the VNC server process. Killing this window (typically by typing "`exit`" or "`ctrl-D`" at the prompt) will cause the vncserver to terminate and the original batch job to end. Because of this, we recommend that this window not be used for other purposes; it is just too easy to accidentally kill it and terminate the session.

	The other xterm window is black-on-white, and can be used to start both serial programs running on the node hosting the vncserver process, or parallel jobs running across the set of cores associated with the original batch job. Additional xterm windows can be created using the window-manager left-button menu.

### [unning Applications on the Remote Desktop](#vis)

From an interactive desktop, applications can be run from icons or from xterm command prompts. Two special cases arise: running parallel applications, and running applications that use OpenGL.

### [unning Parallel Applications from the Desktop](#vis)

Parallel applications are run on the desktop using the same ibrun wrapper described above (see Running). The command:

<pre class="cmd-line">c101-001$ <b>ibrun <i>ibrunoptions</i> application applicationoptions</b></pre>

will run application on the associated nodes, as modified by the ibrun options.

### [unning OpenGL/X Applications On The Desktop](#vis)

Frontera uses the OpenSWR OpenGL library to perform efficient rendering. At present, the compute nodes on Frontera do not support native X instances. All windowing environments should use a DCV desktop launched via the job script in `/share/doc/slurm/job.dcv`, a VNC desktop launched via the job script in `/share/doc/slurm/job.vnc` or using the TACC Vis portal.

`swr`: To access the accelerated OpenSWR OpenGL library, it is necessary to use the `swr` module to point to the `swr` OpenGL implementation and configure the number of threads to allocate to rendering.

<pre class="cmd-line">
c101-001$ <b>module load swr</b>
c101-001$ <b>swr <i>options</i> application application-args</b></pre>

### [arallel VisIt on Frontera](#vis)

[VisIt](https://wci.llnl.gov/simulation/computer-codes/visit) was compiled under the Intel compiler and the mvapich2 and MPI stacks.

After connecting to a VNC server on Frontera, as described above, load the VisIt module at the beginning of your interactive session before launching the VisIt application:

<pre class="cmd-line">
c101-001$ <b>module load swr visit</b>
c101-001$ <b>swr visit</b></pre>

VisIt first loads a dataset and presents a dialog allowing for selecting either a serial or parallel engine. Select the parallel engine. Note that this dialog will also present options for the number of processes to start and the number of nodes to use; these options are actually ignored in favor of the options specified when the VNC server job was started.

#### [reparing Data for Parallel Visit](#vis)

VisIt reads [nearly 150 data formats](https://github.com/visit-dav/visit/tree/develop/src/databases). Except in some limited circumstances (particle or rectilinear meshes in ADIOS, basic netCDF, Pixie, OpenPMD and a few other formats), VisIt piggy-backs its parallel processing off of whatever static parallel decomposition is used by the data producer. This means that VisIt expects the data to be explicitly partitioned into independent subsets (typically distributed over multiple files) at the time of input. Additionally, VisIt supports a metadata file (with a `.visit` extension) that lists multiple data files of any supported format that hold subsets of a larger logical dataset. VisIt also supports a "brick of values (`bov)`" format which supports a simple specification for the static decomposition to use to load data defined on rectilinear meshes. For more information on importing data into VisIt, see [Getting Data Into VisIt](https://visit-dav.github.io/visit-website/pdfs/GettingDataIntoVisIt2.0.0.pdf?#page=97).

### [arallel ParaView on Frontera](#vis)

After connecting to a VNC server on Frontera, as described above, do the following:

1. Set up your environment with the necessary modules. Load the `swr`, `qt5`, `ospray`, and `paraview` modules <b>in this order</b>:

	<pre class="cmd-line">c101-001$ <b>module load swr qt5 ospray paraview</b></pre>

1. Launch ParaView:

	<pre class="cmd-line">c101-001$ <b>swr -p 1 paraview [<i>paraview client options</i>]</b></pre>

1. Click the "Connect" button, or select File -&gt; Connect

1. Select the "auto" configuration, then press "Connect". In the Paraview Output Messages window, you'll see what appears to be an 'lmod' error, but can be ignored. Then you'll see the parallel servers being spawned and the connection established.
## [Jupyter](#jupyter) { #jupyter }

See the [Transferring Files](../transferring) section to learn how to transfer your datasets to Frontera, prior to starting a Jupyter session.

### [Launch a Jupyter session](#jupyter-launch) { #jupyter-launch }

You can launch a Jupyter session via the Frontera User Portal.

1. Login to the [Frontera User Portal](https://frontera-portal.tacc.utexas.edu/login) and Select "My Dashboard" under your account name pulldown:

	<figure id="figure1"><img alt="Login to the Frontera Portal" src="../../imgs/frontera/jupyter-selectDashboard.png">
	<figcaption></figcaption></figure>

1. From the workbench dashboard, click "Applications" in the left nav, then click "Data Processing" and select "Frontera HPC Jupyter":   

	<figure id="figure1"><img alt="Select Jupyter Notebook" src="../../imgs/frontera/jupyter-selectJupyter.png">
	<figcaption></figcaption></figure>
	<figure id="figure2"><img alt="Figure 2. Select Jupyter Notebook" src="../../imgs/frontera/jupyter-selectDashboard.png">
	<figcaption></figcaption></figure>

1. Fill out and submit the form:    

	* **User email**: you'll be be notiifed at this address once the application is running.

	* **Queue**: select which Frontera queue to use to submit the job to. Like any job, this will impact what hardware (and thus, what resources) are available to the Jupyter application.   See Frontera Queues.

	* **Maximum Job Runtime** like all jobs, this will be enforced by Slurm, so your job will be killed at this time. On the other hand, the shorter you request, the faster it will start up (typically).

	* **Job name**: this is the portal/Tapis name for the job and will be used in the notifications indicating the job has started, etc. This is just for bookkeeping so the user knows what job is being referred to.  


	<figure id="figure3"><img alt="Figure 3. Submit session request form" src="../../imgs/frontera/jupyter-fillForm.png">
	<figcaption></figcaption></figure>

1. Submitting the form initiates a request to the Slurm scheduler to reserve a compute node for a specified time.  In the example above, `bjones` requests a two-hour Jupyter session in Frontera's `small` queue on a single node.  **Depending upon Frontera's load, Slurm may take several minutes to several hours** to fulfill the node request.  Once Slurm allocate time for the job, you'll be automatically notified at the given email address with instructions and a password on how to connect to the session.

	<figure id="figure4"><img alt="Figure 4. Notification email" src="../../imgs/frontera/jupyter-email.png">
	<figcaption></figcaption></figure>


1. Navigate to the URL specified in the email, enter your password specified in the email,  and begin your session.


### [References](#jupyter-refs) { #jupyter-refs }

* [Jupyter Documentation](https://jupyter-notebook.readthedocs.io/en/stable/notebook.html)


## [Cloud Services Integration](#cloudservices) { #cloudservices }

<p class="introtext">Frontera's design includes a totally new integration with cloud services, providing users with new options for data storage and access to emerging computing technologies. </p>

For projects utilizing data of exceptional importance - such as may result from an especially difficult physical experiment or a long-running simulation that is impractical to repeat - users have access to a cloud-based storage mirror that provides protection beyond the level already provided with TACC's redundant archive storage system. This capability relies upon the storage solutions of our cloud partners Microsoft, Google, and Amazon. For users who need this level of data protection, we provide storage capacity during the term of Frontera's operation by awarding credits for users to store data with our cloud partners. 

Users may access emerging computational capabilities (such as Tensor processors) that run on specially-designated processors at Google, Microsoft, and Amazon. This allows us to regularly refresh the project with novel computing technologies, while providing a real-world platform for users to explore the future of their science applications.

### [Google Cloud Platform](#cloudservices-google) { #cloudservices-google }

TACC now offers Frontera users access to Google Cloud Platform.

#### [Request Access](#cloudservices-google-requestaccess) { #cloudservices-google-requestaccess }

Please [create a support ticket](https://portal.tacc.utexas.edu/tacc-consulting/-/consult/tickets/create) requesting access to TACC Frontera's Google Cloud Platform. Do not proceed with the following steps until an admin has responded and configured your account appropriately.


1. Install

	Follow these detailed instructions to install the Google Cloud SDK on Linux platforms: [Installing Google Cloud SDK](https://cloud.google.com/sdk/docs/install#linux).

1. Download and extract

	<pre class="cmd-line">
	login1$ <b>curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-335.0.0-linux-x86_64.tar.gz</b>
	login1$ <b>tar -xzf google-cloud-sdk-335.0.0-linux-x86_64.tar.gz</b></pre>

1. Authenticate and configure

	<pre class="cmd-line">login1$ <b>./google-cloud-sdk/bin/gcloud auth login</b></pre>

	* You'll be presented a URL to paste into a browser; Log in using the appropriate Google account. 
	* You'll then be presented an authentication string. Copy and paste this string when promped with: "Enter verification code:".  
	* Configure the CLI for the correct project. For Frontera, use "`ut-tacc-np-sandbox-1`".

		<pre class="cmd-line">login1$ <b>./google-cloud-sdk/bin/gcloud config set project ut-tacc-np-sandbox-1</b></pre>

#### [Storage basics](#cloudservices-google-storage) { #cloudservices-google-storage }

Learn the basic `gsutil` commands: [Quickstart: Using the `gsutil` tool](https://cloud.google.com/storage/docs/quickstart-gsutil)

**Example: list storage elements:**

<pre class="cmd-line">login1$ <b>./google-cloud-sdk/bin/gsutil ls</b></pre>

### [Amazon Web Services (AWS)](#cloudservices-amazon) { #cloudservices-amazon }

TACC now offers Frontera users access to Amazon Web Services. 

#### [Request Access](#cloudservices-amazon-requestaccess) { #cloudservices-amazon-requestaccess }

Please [create a support ticket](https://portal.tacc.utexas.edu/tacc-consulting/-/consult/tickets/create) requesting access to TACC Frontera's Amazon Web Services. Do not proceed with the following steps until an admin has responded and configured your account appropriately.

#### [Log In to the Console](#cloudservices-amazon-login) { #cloudservices-amazon-login }

If you are a new user then you should have received an email "Welcome to Amazon Web Services" containing a temporary password. Follow the instructions below to set up your AWS account.

Log in to the [Amazon Web Services Console](https://console.aws.amazon.com) with the following information: 

* Enter "203416866386" in the "Account ID" field 
* Enter your [Frontera User Portal](https://frontera-portal.tacc.utexas.edu/) ID in the "IAM user name" field.
* New users enter the temporary password contained in your welcome email, then reset your password.  
	<figure id="login"><img alt="AWS-login" src="../../imgs/frontera/AWS-login.png"> 
	<figcaption></figcaption></figure>

#### [Add MFA](#cloudservices-amazon-mfa) { #cloudservices-amazon-mfa }

Follow these instructions to enable MFA on your account. **Do not navigate away from the MFA window during the pairing process, or else your account may be left in an unstable state.** 

1. From the top menu "<i>username</i>@2034-1686-6386", select "My Security Credentials"  
	<figure id="securitycredentials"><img alt="AWS-securitycredentials" src="../../imgs/frontera/AWS-securitycredentials.png"> 
	<figcaption></figcaption></figure>

1. Click on the "Assign MFA device" button in the "Multi-factor authentication (MFA)" section. Then, select the "Virtual MFA device" option and click "Continue".  
	<figure id="managemfadevice"><img alt="AWS-managemfadevice" src="../../imgs/frontera/AWS-managemfadevice.png"> 
	<figcaption></figcaption></figure>

1. Choose an Authentication method. Scroll down to see a list of free options. Many TACC users employ Duo Mobile or Google Authenticator. Open the authenticator app of your choice, scan the displayed QR code to add the account, then input the MFA codes as directed. 
	<figure id="mfaapplications"><img alt="AWS-mfaapplications" src="../../imgs/frontera/AWS-mfaapplications.png"> 
	<figcaption></figcaption></figure>

1. Once the pairing process is completed, sign out and then log back in. **You will not be able to successfully proceed to the next step without doing so.**

#### [Add CLI and API access key](#cloudservices-amazon-keys) { #cloudservices-amazon-keys }

<p class="msg-alert"><i>NOTE:</i> You must set up MFA and use it to log in to the AWS console prior to viewing or editing your access keys.</p>

1. Once again, select "My Security Credentials" from the top menu, then click the "Create access key" button in the "Access keys for CLI, SDK, & API access" section.  
	<figure id="accesskeyavailable"><img alt="AWS-accesskeyavailable" src="../../imgs/frontera/AWS-accesskeyavailable.png"> 
	<figcaption></figcaption></figure>

1. Install CLI: Follow the instructions at <https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html>.
1. For more info see [Managing Access Keys for IAM Users](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html)

#### [All Set](#cloudservices-amazon-allset) { #cloudservices-amazon-allset }

Now that your account is set up, you have access to the AWS S3 functionality. See the full documentation at <https://docs.aws.amazon.com/s3/index.html>.


### [Microsoft's Azure Cloud Service](#cloudservices-azure) { #cloudservices-azure }

Frontera's cloud service integration begins with Microsoft's Azure Service. 

#### [Request Access](#cloudservices-azure-requestaccess) { #cloudservices-azure-requestaccess }

Please [submit a support ticket](https://portal.tacc.utexas.edu/tacc-consulting/-/consult/tickets/create) and a TACC admin will grant you access to the [Microsoft Azure Portal](http://portal.azure.com). Do not proceed with the following steps until an admin has responded and configured your account appropriately.

#### [Create a Storage Group and Account](#cloudservices-azure-storage) { #cloudservices-azure-storage }

Once you've been given access, and before uploading files to Azure, you must first create a storage group and storage account. These are one time steps.


1. Navigate to the [Microsoft Azure Portal](https://portal.azure.com) and login with your TACC User Portal account.  
	<figure id="figure1"><img border="1" alt="Azure Portal Home" src="../../imgs/frontera/image01.png"> 
	<figcaption></figcaption></figure>

1. Click "Storage accounts". You should see a screen like the following:  
	<figure id="figure2"><img border="1" alt="" src="../../imgs/frontera/image02.png"> 
	<figcaption></figcaption></figure>

1. Click "Add". This should bring up the following form:  
	<figure id="figure3"><img border="1" alt="" src="../../imgs/frontera/image03.png"> 
	<figcaption></figcaption></figure>

1. Fill in the form to create a storage account. 

	* Make sure the Subscription field is populated with a subscription.

	* Click "Create new" Resource group if no resource group is populated.

		* Enter a name for the new resource group.

	* Enter a Storage account name

	* Click Review+create to submit the form and run the audit.
		<figure id="figure4"><img border="1" alt="" src="../../imgs/frontera/image04.png"> 
	<figcaption></figcaption></figure>


1. Once Validation has completed, confirm that you see a green "Validation passed" message (see screenshot below), review the account details and click "Create" to actually create the storage account.
	<figure id="figure5"><img border="1" alt="" src="../../imgs/frontera/image05.png"> 
	<figcaption></figcaption></figure>

1. You will see a screen that says "Your deployment is underway..."; this will take a few minutes. 
	<figure id="figure6"><img border="1" alt="" src="../../imgs/frontera/image06.png"> 
	<figcaption></figcaption></figure>

1. Eventually it should say "Your deployment is complete".
	<figure id="figure7"><img border="1" alt="" src="../../imgs/frontera/image07.png"> 
	<figcaption></figcaption></figure>


#### [Retrieve Account Access Keys](#cloudservices-azure-keys) { #cloudservices-azure-keys }

1. Go to Home -&gt; Storage accounts; You should see a list of your storage account similar to the following:
	<figure id="figure7"><img border="1" alt="" src="../../imgs/frontera/image08.png"> 
	<figcaption></figcaption></figure>


1. Select the storage account you created in part 1). This should bring up an overview screen for the storage account which should look similar to:
	<figure id="figure7"><img border="1" alt="" src="../../imgs/frontera/image09.png"> 
	<figcaption></figcaption></figure>

1. Click "Access keys" under settings. This will bring up a page with details about the access keys. <!-- ![image10](/img/image10.png)  <p>&nbsp;</p> 1. --> Copy the key to your clipboard.


#### [Install the Azure Client for CLI Access](#cloudservices-azure-cli) { #cloudservices-azure-cli }

To install on Frontera in your home directory using Python, this should be sufficient:

<p class="cmd-line">login1$ <b>curl -L https://aka.ms/InstallAzureCli | bash</b></p>

We recommend creating a "`~/azure`" subdirectory to put everything in. It will ask where to install. Change to this new subdirectory. For example:

<pre class="cmd-line">===&gt; In what directory would you like to place the install? (leave blank to use &#39;/home1/01983/mpackard/lib/azure-cli&#39;): 
<b>/home1/01983/mpackard/azure/lib/azurecli</b>

===&gt; In what directory would you like to place the &#39;az&#39; executable? (leave blank to use &#39;/home1/01983/mpackard/bin&#39;): 
<b>/home1/01983/mpackard/azure/bin</b></pre>

More client options here: <https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest>


#### [Upload a File](#cloudservices-azure-upload) { #cloudservices-azure-upload }

1. Login with the Azure CLI and follow the steps to open a web browser and enter the access code from above.

	<pre class="cmd-line">login1$ <b>az login</b></pre>

1. List your storage accounts:

	<pre class="cmd-line">login1$ <b>az storage account list</b>
	[
  	  {
		"accessTier": "Hot",
		"azureFilesIdentityBasedAuthentication": null,
		"creationTime": "2019-12-18T20:50:00.430872+00:00",
		"customDomain": null,
		"enableHttpsTrafficOnly": true,
		"encryption": {
	  	"keySource": "Microsoft.Storage",
	  	"keyVaultProperties": null,
	  	"services": {
			"blob": {
		  	"enabled": true,
		  	"lastEnabledTime": "2019-12-18T20:50:00.493366+00:00"
			},
			"file": {
		  	"enabled": true,
		  	"lastEnabledTime": "2019-12-18T20:50:00.493366+00:00"
			},
			"queue": null,
			"table": null
	  	  }
		},
	"failoverInProgress": null,
		"geoReplicationStats": null,
		"id": "/subscriptions/616968b2-af18-4791-999a-ccd06539a2b3/resourceGroups/joe_group/providers/Microsoft.Storage/storageAccounts/joe1",
		"identity": null,
		"isHnsEnabled": null,
		"kind": "StorageV2",
		"largeFileSharesState": null,
		"lastGeoFailoverTime": null,
		"location": "eastus",
		"name": "joe1",
		"networkRuleSet": {
	  	  "bypass": "AzureServices",
	  	  "defaultAction": "Allow",
	  	  "ipRules": [],
	  	  "virtualNetworkRules": []
		  },
		"primaryEndpoints": {
	  	  "blob": "https://joe1.blob.core.windows.net/",
	  	  "dfs": "https://joe1.dfs.core.windows.net/",
	  	  "file": "https://joe1.file.core.windows.net/",
	  	  "queue": "https://joe1.queue.core.windows.net/",
	  	  "table": "https://joe1.table.core.windows.net/",
	  	  "web": "https://joe1.z13.web.core.windows.net/"
		  },
		"primaryLocation": "eastus",
		"provisioningState": "Succeeded",
		"resourceGroup": "joe_group",
		"secondaryEndpoints": {
	  	  "blob": "https://joe1-secondary.blob.core.windows.net/",
	  	  "dfs": "https://joe1-secondary.dfs.core.windows.net/",
	  	  "file": null,
	  	  "queue": "https://joe1-secondary.queue.core.windows.net/",
	  	  "table": "https://joe1-secondary.table.core.windows.net/",
	  	  "web": "https://joe1-secondary.z13.web.core.windows.net/"
		  },
		"secondaryLocation": "westus",
		"sku": {
	  	  "capabilities": null,
	  	  "kind": null,
	  	  "locations": null,
	  	  "name": "Standard_RAGRS",
	  	  "resourceType": null,
	  	  "restrictions": null,
	  	  "tier": "Standard"
		  },
		"statusOfPrimary": "available",
		"statusOfSecondary": "available",
		"tags": {},
		"type": "Microsoft.Storage/storageAccounts"
  	  }
	]</pre>
	
	
1. List your storage containers within the account
	
	<pre class="cmd-line">login1$ <b>az storage container list --account-name slindsey \<br>--account-key eSwqAlwh9kSxj07Stz9YKws9GWecICkLE9OUMm/kA2YAlKBCn2AzoBOOdL+7EbLNX+OEBqNjpGKsyo04p4Jmrwsl</b>
	
	[
  	  {
		"metadata": null,
		"name": "container1",
		"properties": {
	  	  "etag": "\"0x8D783FF62DA8FC6\"",
	  	  "hasImmutabilityPolicy": "false",
	  	  "hasLegalHold": "false",
	  	  "lastModified": "2019-12-18T21:15:19+00:00",
	  	  "lease": {
			"duration": null,
			"state": null,
			"status": null
	  	    },
	  	  "leaseDuration": null,
	  	  "leaseState": "available",
	  	  "leaseStatus": "unlocked",
	  	  "publicAccess": null
		}
  	  }
	]</pre>
	
2. Create a new container (if needed) for your file

	<pre class="cmd-line">login1$ <b>az storage container create --name container1 \
		--account-name <i>slindsey</i> --account-key <i>reallylongstringofrandomcharacters</i></b>
	{
		"created": true
	}</pre>

3. Upload a file

	<pre class="cmd-line">
	login1$ <b>az storage blob upload --container-name container1 --file foo.txt --name foo.txt \
		--account-name <i>slindsey</i> --account-key <i>reallylongstringofrandomcharacters</i></b>
	Alive[################################################################]  100.000
	Finished[#############################################################]  100.0000%
	{
	"etag": "\"0x8D783FFAD095DE0\"",
	"lastModified": "2019-12-18T21:17:23+00:00"
	}</pre>

4. List your "blobs"

	<pre class="cmd-line">
	login1$ <b>az storage blob list --container-name container1 --output table \
		--account-name <i>slindsey</i> --account-key <i>reallylongstringofrandomcharacters</i></b>
	Name	 Blob Type	  Blob Tier	   Length	 Content Type	 Last Modified			  Snapshot
	-------  -----------  -----------  --------  --------------  -------------------------  ----------
	foo.txt  BlockBlob	  Hot		   10		 text/plain	     2019-12-18T21:17:23+00:00</pre>

5. Download your file:

	<pre class="cmd-line">
	login1$ <b>az storage blob download --container-name container1 --name foo.txt --file a_new_foo.txt --output table \
		--account-name <i>slindsey</i> --account-key <i>reallylongstringofrandomcharacters</i></b>
	Alive[################################################################]  100.000
	Finished[#############################################################]  100.0000%
	Name	 Blob Type	  Blob Tier	   Length	 Content Type	 Last Modified			  Snapshot
	-------  -----------  -----------  --------  --------------  -------------------------  ----------  
	foo.txt  BlockBlob	               10		 text/plain	     2019-12-18T21:17:23</pre>

6. The file shows up with the new name:

	<pre class="cmd-line">bash-5.0# <b>ls -l </b>
	total 64
	-rw-r--r--	1 root	 root			10 Dec 18 21:20 a_new_foo.txt
	bash-5.0# <b>cat a_new_foo.txt </b>
	Hi Azure!</pre>

## [Containers](#containers) { #containers }

Frontera provides seamless, integrated support for the use of Singularity containers (both custom containers made by users and containers from standard repositories). The use of containers greatly enhances the number of people who contribute to the Frontera software base, promotes portability with other resources, and greatly expands the supported software catalog beyond that found on TACC's other HPC systems.

Frontera supports application containers from any specification-compliant science community (e.g. Biocontainers, with over 3,000 containers and counting, and the Nvidia GPU Cloud Library), opening this important resource for a wide range of new applications and new science communities. To make the experience seamless, our implementation injects mount points and environment variables into the container to match the HPC system environment – the `$SCRATCH`, `$WORK`, and `$HOME` filesystems all are identical to what users see natively on any Frontera node. 

<! -- SDL -->
<!-- See the [Containers@TACC](../docs/containers-at-tacc.pdf) documentation for detailed information.-->
## [Help Desk](#help) { #help }


<p class="introtext"> <a href="https://portal.tacc.utexas.edu/consulting/overview">TACC Consulting</a> operates from 8am to 5pm CST, Monday through Friday, except for holidays.</p>

You can [submit a help desk ticket](https://portal.tacc.utexas.edu/tacc-consulting/-/consult/tickets/create) at any time via the TACC User Portal with &quot;Frontera&quot; in the Resource field. Help the consulting staff help you by following these best practices when submitting tickets. 

### [Best Practices aka Help Us Help You](#help-bestpractices)

* **Do your homework** before submitting a help desk ticket. What does the user guide and other documentation say? Search the internet for key phrases in your error logs; that's probably what the consultants answering your ticket are going to do. What have you changed since the last time your job succeeded?

* **Describe your issue as precisely and completely as you can:** what you did, what happened, verbatim error messages, other meaningful output. When appropriate, include the information a consultant would need to find your artifacts and understand your workflow: e.g. the directory containing your build and/or job script; the modules you were using; relevant job numbers; and recent changes in your workflow that could affect or explain the behavior you're observing.

* **Subscribe to [Frontera User News](https://portal.tacc.utexas.edu/user-news/-/news/Frontera).** This is the best way to keep abreast of maintenance schedules, system outages, and other general interest items.

* **Have realistic expectations.** Consultants can address system issues and answer questions about Frontera. But they can't teach parallel programming in a ticket, and may know nothing about the package you downloaded. They may offer general advice that will help you build, debug, optimize, or modify your code, but you shouldn't expect them to do these things for you.

* **Be patient.** It may take a business day for a consultant to get back to you, especially if your issue is complex. It might take an exchange or two before you and the consultant are on the same page. If the admins disable your account, it's not punitive. When the file system is in danger of crashing, or a login node hangs, they don't have time to notify you before taking action.

## [References](#rfs) { #refs }


* [Multi-Factor Authentication at TACC][TACCMFA]
* [Bash Users' Startup Files: Quick Start Guide][TACCBASHQUICKSTART]
* [Sharing Project Files on TACC Systems][TACCSHARINGPROJECTFILES]
* [`idev` documentation][TACCIDEV]
* [Lmod's online documentation](http://lmod.readthedocs.org)
* [TACC Usage Policy](http://portal.tacc.utexas.edu/tacc-usage-policy)


{% include 'aliases.md' %}
