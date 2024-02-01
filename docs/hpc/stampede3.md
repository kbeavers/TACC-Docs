# Stampede3 User Guide 

*Last update: February 1, 2024*

## [Notices](#notices) { #notices }

*This user guide is in progress and will be updated as the system is configured.*

### Stampede3 Updated Timeline
**All dates subject to change based on hardware availability and condition.**   

January 2024 - Stampede3 file system available for data migration - Available now   
February 2024 - Early user period for Stampede3 - Available now
March 2024 - Stampede3 in full production   


## [Migrating Data](#migrating) { #migrating }

The Stampede3 login nodes are now available for you to begin moving data between systems.  **If you have an active Stampede3 allocation** then you may begin the data migration process from Stampede2 to Stampede3.  During this migration period Stampede2's `/home` and `/scratch` systems will be temporarily mounted on Stampede3 and will be accessible through the `$HOME_S2` and `$SCRATCH_S2` environment variables respectively.  

!!! warning
	The Stampede2 file mounts are temporary and will be removed once Stampede3 is in full production.

You do not need to migrate data from `$WORK` (Stockyard) as that file system will be automatically mounted on Stampede3.  However, anything in your `$HOME` or `$SCRATCH` directories that you wish to retain will need to be moved.  

!!! important
	Please migrate **only** the data you wish to keep from Stampede2.  

### [Examples](#migrating-examples) { #migrating-examples }

**If you have an active Stampede3 allocation** you can access Stampede3 via `ssh` as you do with other TACC resources.  Use the same password and MFA method as for accessing Stampede2.

``` cmd-line
ssh username@stampede3.tacc.utexas.edu
```
To move your data, we recommend using either the UNIX `cp` or `rsync` utilities.  

To copy a single file from Stampede2 to Stampede3: 

```cmd-line
stampede3$ cp $HOME_S2/filename $HOME
```
or

```cmd-line
stampede3$ rsync -r $HOME_S2/filename $HOME
```

To copy a directory: 

```cmd-line
stampede3$ rsync -r $SCRATCH_S2/dirName $SCRATCH
```
or

```cmd-line
stampede3$ cp -r $SCRATCH_S2/dirName $SCRATCH
```

!!! note
	Currently, there is no Globus endpoint on Stampede3.  We will make an announcement as soon as the endpoint becomes available.


## [Introduction](#intro) { #intro }

The National Science Foundation (NSF) has generously awarded the University of Texas at Austin funds for TACC's Stampede3 system ([Award Abstract # 2320757](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2320757)).  

### [Allocations](#intro-allocations) { #intro-allocations }

Submit all Stampede3 allocations requests through the NSF's [ACCESS](https://allocations.access-ci.org/) project. General information related to allocations, support and operations is available via the ACCESS website <http://access-ci.org>.

Requesting and managing allocations will require creating a username and password on this site. These credentials do not have to be the same as those used to access the TACC User Portal and TACC resources. Principal Investigators (PIs) and their allocation managers will be able to add/remove users to/from their allocations and submit requests to renew, supplement, extend, etc. their allocations. PIs attempting to manage an allocation via the [TACC User Portal](https://tacc.utexas.edu/portal/dashboard) will be redirected to the ACCESS website.

## [System Architecture](#system) { #system }

### [Sapphire Rapids Compute Nodes](#system-spr) { #system-spr }

Stampede3 hosts 560 "Sapphire Rapids" HBM (SPR) nodes with 112 cores each.  Each SPR node provides a performance increase of 2 - 3x over the SKX nodes due to increased core count and greatly increased memory bandwidth.  The available memory bandwidth per core increases by a factor of 3.5x.  Applications that were starved for memory bandwidth should exhibit improved performance close to 3x. 

#### [Table 1. SPR Specifications](#table1) { #table1 }

Specification | Value 
--- | ---
CPU: | Intel Xeon CPU MAX 9480 ("Sapphire Rapids HBM")
Total cores per node: | 112 cores on two sockets (2x 56 cores)
Hardware threads per core: | 1
Hardware threads per node: | 2x56 = 112
Clock rate: | 1.9GHz
Memory: | 128 GB HBM 2e
Cache: | 48 KB L1 data cache per core; 1MB L2 per core; 112.5 MB L3 per socket. Each socket can cache up to 168.5 MB (sum of L2 and L3 capacity).
Local storage: | 150 GB /tmp partition

### [Ponte Vecchio Compute Nodes](#system-pvc) { #system-pvc }

Stampede3 hosts 20 nodes with four Intel Data Center GPU Max 1550s "Ponte Vecchio" (PVC) each.  Each PVC GPU has 128 GB of HBM2e and 128 Xe cores providing a peak performance of 4x 52 FP64 TFLOPS per node for scientific workflows and 4x 832 BF16 TFLOPS for ML workflows. 

#### [Table 2. PVC Specifications](#table2) { #table2 }

Specification | Value
--- | ---
GPU: | 4x Intel Data Center GPU Max 1550s ("Ponte Vecchio)
GPU Memory: | 128 GB HBM 2e
CPU: | Intel Xeon CPU MAX 8480 ("Sapphire Rapids")
Total cores per node: | 112 cores on two sockets (2x 56 cores)
Hardware threads per core: | 1
Hardware threads per node: | 2x56 = 112
Clock rate: | 2.0 GHz
Memory: | 512 GB DDR5
Cache: | 48 KB L1 data cache per core; 1MB L2 per core; 112.5 MB L3 per socket. Each socket can cache up to 168.5 MB (sum of L2 and L3 capacity).
Local storage: | 150 GB /tmp partition

### [Skylake Compute Nodes](#system-skx)  { #system-skx }

Stampede3 hosts 1,060 "Skylake" (SKX) compute nodes.

#### [Table 3. SKX Specifications](#table3) { #table3 }

Specification | Value
--- | ---
Model: | Intel Xeon Platinum 8160 ("Skylake")
Total cores per SKX node: | 48 cores on two sockets (24 cores/socket)
Hardware threads per core: | 2
Hardware threads per node: | 48 x 2 = 96
Clock rate: | 2.1GHz nominal (1.4-3.7GHz depending on instruction set and number of active cores)
RAM: | 192GB (2.67GHz) DDR4
Cache: | 32 KB L1 data cache per core; 1 MB L2 per core; 33 MB L3 per socket. Each socket can cache up to 57 MB (sum of L2 and L3 capacity).
Local storage: | 90 GB /tmp 

### [ICX Compute Nodes](#system-icx) { #system-icx }

Stampede3 hosts 224 "Ice Lake" (ICX) compute nodes.

#### [Table 4. ICX Specifications](#table4) { #table4 }

Specification | Value
--- | ---
Model: | Intel Xeon Platinum 8380 ("Ice Lake")
Total cores per ICX node: | 80 cores on two sockets (40 cores/socket)
Hardware threads per core: | 2
Hardware threads per node: | 80 x 2 = 160
Clock rate: | 2.3 GHz nominal (3.4GHz max frequency depending on instruction set and number of active cores)
RAM: | 256GB (3.2 GHz) DDR4
Cache: | 48KB L1 data cache per core; 1.25 MB L2 per core; 60 MB L3 per socket. Each socket can cache up to 110 MB (sum of L2 and L3 capacity)
Local storage: | 200 GB /tmp partition

### [Login Nodes](#system-login) { #system-login }

The Stampede3 login nodes are Intel Xeon Platinum 8468 "Sapphire Rapids" (SPR) nodes, each with 96 cores on two sockets (48 cores/socket) with 250 GB of DDR. 

### [Network](#network) { #system-network }

The interconnect is a 100Gb/sec Omni-Path (OPA) network with a fat tree topology. There is one leaf switch for each 28-node half rack, each with 20 leaf-to-core uplinks (28/20 oversubscription) for the SKX nodes.  The ICX and SKX nodes are fully connected.  The SPR and PVC nodes are fully connected with a fat tree topology with no oversubscription. 

The SPR and PVC networks will be upgraded to use Cornelis' CN5000 Omni-Path technology in 2024.  The backbone network will also be upgraded. 

### [File Systems](#system-filesystems) { #system-filesystems }
 
Stampede3 will use a shared VAST filesystem for the `$HOME` and `$SCRATCH` directories.  As with Stampede2, the `$WORK` lustre filesystem will also be mounted. Each file system is available from all Stampede3 nodes; the Stockyard-hosted work file system is available on most other TACC HPC systems as well. <!-- See Navigating the Shared File Systems for detailed information as well as the Good Conduct file system guidelines. -->

#### [Table 5. File Systems](#table5) { #table5 }

File System | Quota | Key Features
--- | --- | ---
`$HOME` | 15 GB, 300,000 files | Not intended for parallel or high−intensity file operations. <br> Backed up regularly. | Not purged.  
`$WORK` | 1 TB, 3,000,000 files across all TACC systems<br>Not intended for parallel or high−intensity file operations.<br>See [Stockyard system description](#xxx) for more information. | Not backed up. | Not purged.
`$SCRATCH` | no quota<br>Overall capacity ~10 PB. | Not backed up.<br>Files are subject to purge if access time* is more than 10 days old. See TACC's [Scratch File System Purge Policy](#scratchpolicy) below.

<!-- {% include 'include/scratchpolicy.md' %} -->

## [Accessing the System](#access) { #access }

Access to all TACC systems requires Multi-Factor Authentication (MFA). You can create an MFA pairing under "Manage Account" in the TACC Portal.  See [Multi-Factor Authentication at TACC](../../basics/mfa) for further information.

!!! important
	You will be able to log on to Stampede3 **only if** you have an allocation on Stampede3, otherwise your password will be rejected.  
	Monitor your projects &amp; allocations the via the [TACC Portal](https://tacc.utexas.edu/portal/projects).

### [Secure Shell (SSH)](#access-ssh) { #access-ssh }

The `ssh` command (Secure Shell, or SSH protocol) is the standard way to connect to Stampede3 and initiate a login session. SSH also includes support for the UNIX file transfer utilities `scp` and `sftp`.  These commands are available within Linux and the Terminal application within Mac OS. If you are using Windows, you will need a modern terminal application such as [Windows Terminal](https://apps.microsoft.com/detail/9N0DX20HK701?hl=en-US&gl=US), [MobaXterm](https://mobaxterm.mobatek.net/) or [Cyberduck](https://cyberduck.io/download/).  

Initiate an SSH session using the `ssh` command or the equivalent: 

	localhost$ ssh myusername@stampede3.tacc.utexas.edu

The above command will rotate connections across all available login nodes and route your connection to one of them. To connect to a specific login node, use its full domain name:

	localhost$ ssh myusername@login2.stampede3.tacc.utexas.edu

To connect with X11 support on Stampede3 (usually required for applications with graphical user interfaces), use the `-X` or `-Y` option:

	localhost$ ssh -X myusername@stampede3.tacc.utexas.edu

Use your TACC portal password for direct logins to TACC resources. You can change or reset your TACC password via the [TACC Portal][TACCUSERPORTAL] under "Manage Account".  To report a connection problem, execute the `ssh` command with the `-vvv` option and include this command's verbose output when submitting a help ticket.

Do not run the `ssh-keygen` command on Stampede3. This command will create and configure a key pair that will interfere with the execution of job scripts in the batch system.  If you do this by mistake, you can recover by renaming or deleting the `.ssh` directory located in your home directory; the system will automatically generate a new pair for you when you next log into Stampede3.

1. execute `mv .ssh dot.ssh.old`
1. log out
1. log into Stampede3 again

After logging in again, the system will generate a properly configured key SSH pair.

## [Account Administration](#admin)

This section explores ways to configure and manage your Linux account on Stampede3.  Stampede3 nodes run Rocky Linux. Regardless of your research workflow, you'll likely need to master Linux command-line basics along with a Linux-based text editor (e.g. `emacs`, `nano`, `gedit`, or `vi`/`vim`) to use the system properly. If you encounter a term or concept in this user guide that is new to you, a quick internet search should help you resolve the matter quickly.

### [Allocation Status](#admin-allocation)

If your password is rejected while attempting to log in, it's possible your account or project has not been added to a Stampede3 allocation.  You can list and manage your allocations via the [TACC Portal](https://tacc.utexas.edu/portal/projects).  

### [Linux Shell](#admin-linux)

The default login shell for your user account is Bash. To determine your current login shell, examine the contents of the `$SHELL` environment variable: 

	$ echo $SHELL

!!! tip
	If you'd like to change your login shell to `csh`, `tcsh`, or `zsh`, [submit a help ticket][HELPDESK]. 
	The `chsh` ("change shell") command will not work on TACC systems.

When you start a shell on Stampede3, system-level startup files initialize your account-level environment and aliases before the system sources your own user-level startup scripts. You can use these startup scripts to customize your shell by defining your own environment variables, aliases, and functions. These scripts (e.g. `.profile` and `.bashrc`) are generally hidden files: so-called "dotfiles" that begin with a period, visible when you execute: `ls -a`.

Before editing your startup files, however, it's worth taking the time to understand the basics of how your shell manages startup. Bash startup behavior is very different from the simpler `csh` behavior, for example. The Bash startup sequence varies depending on how you start the shell (e.g. using `ssh` to open a login shell, executing the `bash` command to begin an interactive shell, or launching a script to start a non-interactive shell). Moreover, Bash does not automatically source your `.bashrc` file when you start a login shell by using `ssh` to connect to a node. Unless you have specialized needs, however, this is undoubtedly more flexibility than you want: you will probably want your environment to be the same regardless of how you start the shell. The easiest way to achieve this is to execute `source ~/.bashrc` from your `.profile`, then put all your customizations in your `.bashrc` file. The system-generated default startup scripts demonstrate this approach. We recommend that you use these default files as templates.

For more information see the [Bash Users' Startup Files: Quick Start Guide][TACCBASHQUICKSTART] and other online resources that explain shell startup. To recover the originals that appear in a newly created account, execute `/usr/local/startup_scripts/install_default_scripts`.

### [Diagnostics](#admin-diagnostics)

TACC's `sanitytool` module loads an account-level diagnostic package that detects common account-level issues and often walks you through the fixes. You should certainly run the package's `sanitycheck` utility when you encounter unexpected behavior. You may also want to run `sanitycheck` periodically as preventive maintenance. To run `sanitytool`'s account-level diagnostics, execute the following commands:

	login1$ module load sanitytool
	login1$ sanitycheck

Execute `module help sanitytool` for more information.

### [Environment Variables](#admin-envvars)

Your environment includes the environment variables and functions defined in your current shell: those initialized by the system, those you define or modify in your account-level startup scripts, and those defined or modified by the modules that you load to configure your software environment. Be sure to distinguish between an environment variable's name (e.g. `HISTSIZE`) and its value (`$HISTSIZE`). Understand as well that a sub-shell (e.g. a script) inherits environment variables from its parent, but does not inherit ordinary shell variables or aliases. Use `export` (in Bash) or `setenv` (in `csh`) to define an environment variable.

Execute the `env` command to see the environment variables that define the way your shell and child shells behave.
Pipe the results of `env` into `grep` to focus on specific environment variables. For example, to see all environment variables that contain the string GIT (in all caps), execute:

	$ env | grep GIT

The environment variables `PATH` and `LD_LIBRARY_PATH` are especially important. The `PATH` is a colon-separated list of directory paths that determines where the system looks for your executables.  The `LD_LIBRARY_PATH` environment variable is a similar list that determines where the system looks for shared libraries.


### [Using Modules](#admin-modules)

Lmod, a module system developed and maintained at TACC, makes it easy to manage your environment so you have access to the software packages and versions that you need to using your research. This is especially important on a system like Stampede3 that serves thousands of users with an enormous range of needs and software. Loading a module amounts to choosing a specific package from among available alternatives:

	$ module load intel          # load the default Intel compiler
	$ module load intel/24.0.0   # load a specific version of Intel compiler

A module does its job by defining or modifying environment variables (and sometimes aliases and functions). For example, a module may prepend appropriate paths to `$PATH` and `$LD_LIBRARY_PATH` so that the system can find the executables and libraries associated with a given software package. The module creates the illusion that the system is installing software for your personal use. Unloading a module reverses these changes and creates the illusion that the system just uninstalled the software:

	$ module load   ddt  # defines DDT-related env vars; modifies others
	$ module unload ddt  # undoes changes made by load

The module system does more, however. When you load a given module, the module system can automatically replace or deactivate modules to ensure the packages you have loaded are compatible with each other. In the example below, the module system automatically unloads one compiler when you load another, and replaces Intel-compatible versions of IMPI and PETSc with versions compatible with `gcc`:

	$ module load intel  # load default version of Intel compiler
	$ module load petsc  # load default version of PETSc
	$ module load gcc    # change compiler
	
	Lmod is automatically replacing "intel/24.0.0" with "gcc/13.2.0".
	
	Due to MODULEPATH changes, the following have been reloaded:
	1) impi/21.11     2) petsc/3.8

!!! tip
	See [Lmod's documentation](https://lmod.readthedocs.io/en/latest/) for extensive information. The online documentation addresses the basics in more detail, but also covers several topics beyond the scope of the help text (e.g. writing and using your own module files).

On Stampede3, modules generally adhere to a TACC naming convention when defining environment variables that are helpful for building and running software. For example, the papi module defines `TACC_PAPI_BIN` (the path to PAPI executables), `TACC_PAPI_LIB` (the path to PAPI libraries), `TACC_PAPI_INC` (the path to PAPI include files), and `TACC_PAPI_DIR` (top-level PAPI directory). After loading a module, here are some easy ways to observe its effects:

	$ module show papi   # see what this module does to your environment
	$ env | grep PAPI    # see env vars that contain the string PAPI
	$ env | grep -i papi # case-insensitive search for 'papi' in environment

To see the modules you currently have loaded:

	$ module list

To see all modules that you can load right now because they are compatible with the currently loaded modules:

	$ module avail

To see all installed modules, even if they are not currently available because they are incompatible with your currently loaded modules:

	$ module spider                  # list all modules, even those not available to load

To filter your search:

	$ module spider slep             # all modules with names containing 'slep'
	$ module spider sundials/2.5.0   # additional details on a specific module

Among other things, the latter command will tell you which modules you need to load before the module is available to load. You might also search for modules that are tagged with a keyword related to your needs (though your success here depends on the diligence of the module writers). For example:

	$ module keyword performance

You can save a collection of modules as a personal default collection that will load every time you log into Stampede3. To do so, load the modules you want in your collection, then execute:

	$ module save            # save the currently loaded collection of modules

Two commands make it easy to return to a known, reproducible state:

	$ module reset           # load the system default collection of modules
	$ module restore         # load your personal default collection of modules

On TACC systems, the command `module reset` is equivalent to `module purge; module load` TACC. It's a safer, easier way to get to a known baseline state than issuing the two commands separately.

Help text is available for both individual modules and the module system itself:

	$ module help swr        # show help text for software package swr
	$ module help            # show help text for the module system itself


It's safe to execute module commands in job scripts. In fact, this is a good way to write self-documenting, portable job scripts that produce reproducible results.  If you use `module save` to define a personal default module collection, it's rarely necessary to execute module commands in shell startup scripts, and it can be tricky to do so safely. If you do wish to put module commands in your startup scripts, see Stampede3's default startup scripts in `/usr/local/startup_scripts` for a safe way to do so.

### [TACC Tips](#admin-tips)

TACC Staff has amassed a database of helpful tips for our users.  Access these tips via the `tacc_tips` module and `showTip` command as demonstrated below:

	$ module load tacc_tips
	$ showTip

	Tip 131   (See "module help tacc_tips" for features or how to disable)

   		Use Ctrl+E to go the end of the command line.

## [Running Jobs](#running)

{% include 'include/stampede3-jobaccounting.md' %}

<!-- ### [Slurm Job Scheduler](#running-slurm) { #running-slurm } -->


### [Slurm Partitions (Queues)](#queues) { #queues }

Stampede3's job scheduler is the Slurm Workload Manager. Slurm commands enable you to submit, manage, monitor, and control your jobs.  <!-- See the [Job Management]()  section below for further information. -->

**Queues and limits are subject to change without notice.** Execute `qlimits` on Stampede3 for real-time information regarding limits on available queues.  <!-- See Monitoring Jobs and Queues for additional information. -->

<!-- till things stabilize 
#### [Table X. Production Queues](#tablex) { #tablex }

Queue Name   | Node Type | Max Nodes per Job<br>(assoc'd cores) | Max Duration | Max Jobs in Queue | Charge Rate<br>(per node-hour)
--           | --        | --                                   | --           | --                |  
skx-dev      | SKX       | 4 nodes<br>(192 cores)               | 2 hrs        | 1                 | 1 SU
skx-normal   | SKX       | 128 nodes<br>(6,144 cores)           | 48 hrs       | 20                | 1 SU
skx-large&#42;  | SKX       | 384 nodes<br>(18,432 cores)          | 48 hrs       | 3                 | 1 SU
icx-normal   | ICX       | 40 nodes<br>(3,200 cores)            | 48 hrs       | 20                | 1.67 SU
spr-normal   | SPR       | 100 nodes<br>(11,200 cores)          | 48 hrs       | 20                | 3 SU
pvc          | PVC       | 5 nodes<br>(20 PVCs)                 | 48 hrs       | 20                | 5 SU 
-->

Current queue/partition limits on TACC's stampede3 system as of February 1, 2024:
	
	Name             MinNode  MaxNode     MaxWall  MaxNodePU  MaxJobsPU   MaxSubmit
	icx                    1       16  1-00:00:00         24          4          20
	skx                    1       32  1-00:00:00         48          4          20
	skx-dev                1        4    02:00:00          6          1           3


<!-- **&#42; To request more nodes than are available in the skx-normal queue, submit a consulting (help desk) ticket. Include in your request reasonable evidence of your readiness to run under the conditions you're requesting. In most cases this should include your own strong or weak scaling results from Stampede3.** -->

<!-- 
### [Submitting Batch Jobs with sbatch]()

Use Slurm's sbatch command to submit a batch job to one of the Stampede3 queues:

	login1$ sbatch myjobscript

Here myjobscript is the name of a text file containing `#SBATCH` directives and shell commands that describe the particulars of the job you are submitting. The details of your job script's contents depend on the type of job you intend to run.

In your job script you (1) use `#SBATCH` directives to request computing resources (e.g. 10 nodes for 2 hrs); and then (2) use shell commands to specify what work you're going to do once your job begins. There are many possibilities: you might elect to launch a single application, or you might want to accomplish several steps in a workflow. You may even choose to launch more than one application at the same time. The details will vary, and there are many possibilities. But your own job script will probably include at least one launch line that is a variation of one of the examples described here.

Your job will run in the environment it inherits at submission time; this environment includes the modules you have loaded and the current working directory. In most cases you should run your applications(s) after loading the same modules that you used to build them. You can of course use your job submission script to modify this environment by defining new environment variables; changing the values of existing environment variables; loading or unloading modules; changing directory; or specifying relative or absolute paths to files. **Do not** use the Slurm `--export` option to manage your job's environment: doing so can interfere with the way the system propagates the inherited environment.

The Common `sbatch` Options table below describes some of the most common sbatch command options. Slurm directives begin with `#SBATCH`; most have a short form (e.g. `-N`) and a long form (e.g. `--nodes`). You can pass options to sbatch using either the command line or job script; most users find that the job script is the easier approach. The first line of your job script must specify the interpreter that will parse non-Slurm commands; in most cases #!/bin/bash or #!/bin/csh is the right choice. Avoid `#!/bin/sh` (its startup behavior can lead to subtle problems on Stampede3), and do not include comments or any other characters on this first line. All `#SBATCH` directives must precede all shell commands. Note also that certain `#SBATCH` options or combinations of options are mandatory, while others are not available on Stampede3.
-->
<!-- 
#### [Table X. Common sbatch Options](#tablex)

Option | Argument | Comments
--- | --- | ---
`-p`  | queue_name | Submits to queue (partition) designated by queue_name
`-J`  | job_name   | Job Name
`-N`  | total_nodes | Required. Define the resources you need by specifying either:<br>(1) `-N` and `-n`; or<br>(2) `-N` and `-ntasks-per-node`.
`-n`  | total_tasks | This is total MPI tasks in this job. See `-N` above for a good way to use this option. When using this option in a non-MPI job, it is usually best to set it to the same value as `-N`.
`-ntasks-per-node`<br>or<br>`-tasks-per-node` | tasks_per_node | This is MPI tasks per node. See `-N` above for a good way to use this option. When using this option in a non-MPI job, it is usually best to set `-ntasks-per-node` to 1.
`-t  | hh:mm:ss | Required. Wall clock time for job.
`-mail-user=` | email_address | Specify the email address to use for notifications. Use with the `-mail-type=` flag below.
`-mail-type=` | begin, end, fail, or all | Specify when user notifications are to be sent (one option per line).
`-o`  | output_file | Direct job standard output to output_file (without `-e` option error goes to this file)
`-e`  | error_file | Direct job error output to error_file
`-d=` | afterok:jobid | Specifies a dependency: this run will start only after the specified job (jobid) successfully finishes
`-A`  | projectid | Charge job to the specified project/allocation number. This option is only necessary for logins associated with multiple projects.
`-a`<br>or<br>`-array` | N/A | Not available. Use the launcher module for parameter sweeps and other collections of related serial jobs.
`-mem`  | N/A | Not available. If you attempt to use this option, the scheduler will not accept your job.
`-export=` | N/A | Avoid this option on Stampede3. Using it is rarely necessary and can interfere with the way the system propagates your environment.

By default, Slurm writes all console output to a file named "slurm-%j.out", where `%j` is the numerical job ID. To specify a different filename use the `-o` option. To save `stdout` (standard out) and `stderr` (standard error) to separate files, specify both `-o` and `-e` options.
-->
[HELPDESK]: https://tacc.utexas.edu/about/help/ "Help Desk"
[CREATETICKET]: https://tacc.utexas.edu/about/help/ "Create Support Ticket"
[SUBMITTICKET]: https://tacc.utexas.edu/about/help/ "Submit Support Ticket"
[TACCUSERPORTAL]: https://tacc.utexas.edu/portal/login "TACC Portal login"
[TACCPORTALLOGIN]: https://tacc.utexas.edu/portal/login "TACC Portal login"
[TACCUSAGEPOLICY]: https://tacc.utexas.edu/use-tacc/user-policies/ "TACC Usage Policy"
[TACCALLOCATIONS]: https://tacc.utexas.edu/use-tacc/allocations/ "TACC Allocations"
[TACCSUBSCRIBE]: https://accounts.tacc.utexas.edu/subscriptions "Subscribe to News"
[TACCDASHBOARD]: https://tacc.utexas.edu/portal/dashboard "TACC Dashboard"

[TACCANALYSISPORTAL]: http://tap.tacc.utexas.edu "TACC Analysis Portal"

[TACCLMOD]: https://lmod.readthedocs.io/en/latest/ "Lmod"
[DOWNLOADCYBERDUCK]: https://cyberduck.io/download/ "Download Cyberduck"


[TACCREMOTEDESKTOPACCESS]: https://docs.tacc.utexas.edu/tutorials/remotedesktopaccess "TACC Remote Desktop Access"
[TACCSHARINGPROJECTFILES]: https://docs.tacc.utexas.edu/tutorials/sharingprojectfiles "Sharing Project Files"
[TACCBASHQUICKSTART]: https://docs.tacc.utexas.edu/tutorials/bashstartup "Bash Quick Start Guide"
[TACCACCESSCONTROLLISTS]: https://docs.tacc.utexas.edu/tutorials/acls "Access Control Lists"
[TACCMFA]: https://docs.tacc.utexas.edu/basics/mfa "Multi-Factor Authentication at TACC""


