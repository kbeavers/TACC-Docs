# Lonestar6 User Guide
<span style="font-size:90%;"><i>Last update: November 11, 2022</i></span></p>


## Notices

* **Lonestar6 has a [new queue, `vm-small`](#queues), for jobs requiring only a subset of a node's cores.** (11/11/2022) 
* **Lonestar6 will transition from the early user phase into production on Tuesday, January 11, 2022.** For our researchers who currently have access to Lonestar6, we will start charging usage against your allocation. (01/06/2002)
* TACC has transitioned to a new allocations management system for Lonestar6, and there are new Project Names. See [Sharing Project Files on TACC Systems](https://portal.tacc.utexas.edu/tutorials/sharing-project-files) to learn about managing file permissions across projects. 
* **All users: read the [Good Conduct](#conduct) section.** Lonestar6 is a shared resource and your actions can impact other users. (10/18/2021) 
* You may now **[subscribe](https://portal.tacc.utexas.edu/news/subscribe) to [Lonestar6 User News](https://portal.tacc.utexas.edu/user-news/-/news/Lonestar6)**. Stay up-to-date on Lonestar6's status, scheduled maintenances and other notifications. (10/14/2021) 


## Introduction to Lonestar6

Lonestar6 provides a balanced set of resources to support simulation, data analysis, visualization, and machine learning.  It is the next system in TACC's Lonestar series of high performance computing systems that are deployed specifically to support Texas researchers. Lonestar6 is funded through collaboration with TACC, the University of Texas System, Texas A&amp;M University, Texas Tech University, and the University of North Texas, as well as a number of research centers and faculty at UT-Austin, including the Oden Institute for Computational Engineering &amp; Sciences and the Center for Space Research.

The system employs Dell Servers with  AMD's highly performant Epyc Milan processor, Mellanox's HDR Infiniband technology, and 8 PB of BeeGFS based storage on Dell storage hardware.  Additionally, Lonestar6 supports GPU nodes utilizing NVIDIA's Ampere A100 GPUs to support machine learning workflows and other GPU-enabled applications.  Lonestar6 will continue to support the TACC HPC environment, providing numerical libraries, parallel applications, programming tools, and performance monitoring capabilities to the user community.

### Lonestar6 Allocations

Lonestar6 is available to researchers from all University of Texas System institutions and to our partners, Texas A&amp;M University, Texas Tech University and University of North Texas.

UT System Researchers may submit allocation requests for compute time on Lonestar6 via TACC's new [Texas Resource Allocation System](https://tacc-submit.xras.xsede.org) (TxRAS).  Consult the [TACC Allocations Overview](https://portal.tacc.utexas.edu/allocations-overview) page for details.  

Researchers at our partner institutions may submit allocation requests through the links below.

* [Texas A&amp;M University](https://hprc.tamu.edu/user_services/new_user_information.html)
* [Texas Tech University](https://www.depts.ttu.edu/hpcc/about/services.php)
* [University of North Texas](https://research.unt.edu/research-services/research-computing)


<img alt="Lonestar6" src="../../../imgs/6lonestar/lonestar6-1.jpg" style="width: 800px; height: 670px; border-width: 1px; border-style: solid;" /> 
<p class="image-caption">Lonestar6: Dielectric liquid coolant cabinet</p>

## System Architecture

All Lonestar6 nodes run Rocky 8.4 and are managed with batch services through native Slurm 20.11.8. Global storage areas are supported by an NFS file system (`$HOME`), a BeeGFS parallel file system (`$SCRATCH`), and a Lustre parallel file system (`$WORK`). Inter-node communication is supported by a Mellanox HDF Infiniband network. Also, the TACC Ranch tape archival system is available from Lonestar6.

The system is composed of 560 compute nodes and 32 GPU nodes.  The compute nodes are housed in 4 dielectric liquid coolant cabinets and ten air-cooled racks.  The air cooled racks also contain the 32 GPU nodes.  Each node has two AMD EPYC 7763 64-core processors (Milan) and 256 GB of DDR4 memory. Twenty-four of the compute nodes are reserved for development and are accessible interactively for up to two hours. Each GPU node also contains two AMD EPYC 7763 64-core processes and three NVIDIA A100 GPUs each with 40 GB of high bandwidth memory (HBM2).


### Compute Nodes

Lonestar6 hosts 560 compute nodes with 5 TFlops of peak performance per node and 256 GB of DRAM.

Table 1. Compute Node Specifications

header 1 | header 2
---	| ---
CPU: | 2x AMD EPYC 7763 64-Core Processor ("Milan")
Total cores per node: &nbsp; | 128 cores on two sockets (64 cores / socket )
Hardware threads per core: &nbsp; | 1 per core 
Hardware threads per node: &nbsp; | 128 x 1 = 128
Clock rate: &nbsp; | 2.45 GHz (Boost up to 3.5 GHz)
RAM: &nbsp; | 256 GB (3200 MT/s) DDR4
Cache: &nbsp; | 32KB L1 data cache per core<br>512KB L2 per core<br>32 MB L3 per core complex<br>(1 core complex contains 8 cores)<br>256 MB L3 total (8 core complexes )<br>Each socket can cache up to 288 MB<br>(sum of L2 and L3 capacity)
Local storage:&nbsp; | 144GB /tmp partition on a 288GB SSD.

### Login Nodes

Lonestar6's three login nodes, `login1`, `login2`, and `login3`, contain the same hardware and are configured similarly to the compute nodes. However, since these nodes are shared, limits are enforced on memory usage and number of processes. Please use the login nodes only for file management, compilation, and data movement. Any and all computing should be done within a batch job or an [interactive session](http://portal.tacc.utexas.edu/software/idev) on the compute nodes.

### `vm-small` Queue Nodes

Lonestar6 hosts 28 `vm-small` compute nodes running on 4 physical hosts.

[Table 1.5. "`vm-small` Compute Node Specifications](#table15)

header 1 | header 2
---	| ---
CPU: &nbsp; | <b>1/4th</b> of an AMD EPYC 7763 64-Core Processor ("Milan")
Total cores per VM: &nbsp; | 16 cores
Hardware threads per core: &nbsp; | 1 per core 
Hardware threads per VM: &nbsp; | 16 x 1 = 16
Clock rate: &nbsp; | 2.45 GHz (Boost up to 3.5 GHz)
RAM: &nbsp; | 32 GB (3200 <b>shared</b> MT/s) DDR4
Cache: &nbsp; | <b>Shared caches with all other VMs.</b><br>32KB L1 data cache per core<br>512KB L2 per core<br>32 MB L3 per core complex<br>(1 core complex contains 8 cores)<br>64 MB L3 total (2 core complexes)
Local storage:&nbsp; | 112G <code>/tmp</code> partition



### GPU Nodes

Lonestar6 hosts **32** GPU nodes that are configured identically to the compute nodes with the addition of 3 NVIDIA A100 GPUs.  Each A100 gpu has a peak performance of 9.7 TFlops in double precision and 312 TFlops in FP16 precision using the Tensor Cores.

[Table 2. GPU Node Specifications](#table2)

header 1 | header 2
---	| ---
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

### Network

The interconnect is based on Mellanox HDR technology with full HDR (200 Gb/s) connectivity between the switches and the compute nodes. A fat tree topology employing sixteen core switches connects the compute nodes and the `$SCRATCH` file systems. There is an oversubscription of 24/16.


## Managing Files on Lonestar6

### Table 3. Lonestar6 File Systems

 File System | Quota | Key Features
 --- | --- |
<code>$HOME</code> | 10 GB | 200,000 files<br><b>Not intended for parallel or high-intensity file operations.</b><br>NFS file system<br>Backed up regularly.<br>Overall capacity 7 TB<br>Not purged.
<code>$WORK</code> | 1 TB<br>3,000,000 files<br>Across all TACC systems | <b>Not intended for high-intensity file operations or jobs involving very large files.</b><br>Lustre file system<br>On the Global Shared File System that is mounted on most TACC systems.<br>See Stockyard system description for more information.<br>Defaults: 1 stripe, 1MB stripe size<br>Not backed up.<br>Not purged.
<code>$SCRATCH</code> | none | Overall capacity 8 PB<br>Defaults: 4 targets, 512 KB chunk size<br>Not backed up<br><b>Files are subject to purge if access time* is more than 10 days old.</b><sup><a href="#sup1">&#42;</a></sup>
<code>/tmp</code> | on nodes | 288 GB Data purged at the end of each job.<br>Access is local to the node.<br>Data in /tmp is not shared across nodes.

&#42;The operating system updates a file's access time when that file is modified on a login or compute node. Reading or executing a file/script on a login node does not update the access time, but reading or executing on a compute node does update the access time. This approach helps us distinguish between routine management tasks <span style="white-space: nowrap;">(e.g. `tar`, `scp`)</span> and production use. Use the command <span style="white-space: nowrap;">`ls -ul`</span> to view access times.

#### Scratch Purge Policy

!!! important
	The <code>$SCRATCH</code> file system, as its name indicates, is a temporary storage space.  Files that have not been accessed&#42; in ten days are subject to purge.  Deliberately modifying file access time (using any method, tool, or program) for the purpose of circumventing purge policies is prohibited.</p>


### Navigating the Shared File Systems

Lonestar6 mounts three Lustre file systems that are shared across all nodes: the home, work, and scratch file systems. Lonestar6's startup mechanisms define corresponding account-level environment variables `$HOME`, `$SCRATCH` and `$WORK` that store the paths to directories that you own on each of these file systems. Consult the [Lonestar6 File Systems](#table3) table above for the basic characteristics of these file systems, <!--"File Operations: I/O Performance" for advice on performance issues,--> and the [Good Conduct](#conduct) sections for guidance on file system etiquette.

Lonestar6's home and scratch file systems are mounted only on Lonestar6, but the work file system mounted on Lonestar6 is the Global Shared File System hosted on Stockyard. This is the same work file system that is currently available on Frontera, Stampede2 and most other TACC resources.

The `$STOCKYARD` environment variable points to the highest-level directory that you own on the Global Shared File System. The definition of the `$STOCKYARD` environment variable is of course account-specific, but you will see the same value on all TACC systems that provide access to the Global Shared File System (see [Table 3](#table3)). This directory is an excellent place to store files you want to access regularly from multiple TACC resources. 

[Figure. Stockyard Global File System](#stockyard)

<img alt="Stockyard 2022" src="../../../imgs/stockyard-2022.jpg">
<p class="image-caption">Stockyard 2022</p>
Account-level directories on the <code>/work</code> file system (Global Shared File System hosted on Stockyard). Example for fictitious user `bjones`. All directories usable from all systems. Sub-directories (e.g. `stampede2`, `frontera`) exist only when you have allocations on the associated system.

Your account-specific `$WORK` environment variable varies from system to system and is a subdirectory of `$STOCKYARD` (Figure 3). The subdirectory name corresponds to the associated TACC resource. The `$WORK` environment variable on Lonestar6 points to the `$STOCKYARD/ls6` subdirectory, a convenient location for files you use and jobs you run on Lonestar6. Remember, however, that all subdirectories contained in your `$STOCKYARD` directory are available to you from any system that mounts the file system. If you have accounts on both Lonestar6 and Stampede2, for example, the `$STOCKYARD/ls6` directory is available from your Stampede2 account, and `$STOCKYARD/stampede2` directory is available from your Lonestar6 account. Your quota and reported usage on the Global Shared File System reflects **all files** that you own on Stockyard, regardless of their actual location on the file system.

Note that resource-specific subdirectories of `$STOCKYARD` are simply convenient ways to manage your resource-specific files. You have access to any such subdirectory from any TACC resources. If you are logged into Lonestar6, for example, executing the alias `cdw` (equivalent to <span style="white-space: nowrap;">`cd $WORK`</span>) will take you to the resource-specific subdirectory `$STOCKYARD/ls6`. But you can access this directory from other TACC systems as well by executing <span style="white-space: nowrap;">`cd $STOCKYARD/ls6`</span>. These commands allow you to share files across TACC systems. In fact, several convenient account-level aliases make it even easier to navigate across the directories you own in the shared file systems:

Table 4. Built-in Account Level Aliases

### Table 3. Built-in Account Level Aliases

Alias | Command
---- | ----
<code>cd</code> or <code>cdh</code> | <code>cd $HOME</code>
<code>cdw</code> | <code>cd $WORK</code>
<code>cds</code> | <code>cd $SCRATCH</code>
<code>cdy</code> or <code>cdg</code> | <code>cd $STOCKYARD</code>


### Transferring your Files

#### Transferring Files with `scp`

You can transfer files between Lonestar6 and Linux-based systems using either [`scp`](http://linux.com/learn/intro-to-linux/2017/2/how-securely-transfer-files-between-servers-scp) or [`rsync`](http://linux.com/learn/get-know-rsync). Both `scp` and `rsync` are available in the Mac Terminal app. Windows SSH clients typically include `scp`-based file transfer capabilities.

The Linux `scp` (secure copy) utility is a component of the OpenSSH suite. Assuming your Lonestar6 username is `bjones`, a simple `scp` transfer that pushes a file named `myfile` from your local Linux system to Lonestar6 `$HOME` would look like this:

<pre class="cmd-line">localhost$ <b>scp ./myfile bjones@ls6.tacc.utexas.edu:  # note colon after net address</b></pre>

You can use wildcards, but you need to be careful about when and where you want wildcard expansion to occur. For example, to push all files ending in `.txt` from the current directory on your local machine to `/work/01234/bjones/scripts` on Lonestar6:

<pre class="cmd-line">localhost$ <b>scp &#42;.txt bjones@ls6.tacc.utexas.edu:/work/01234/bjones/ls6</b></pre>

To delay wildcard expansion until reaching Lonestar6, use a backslash (`\`) as an escape character before the wildcard. For example, to pull all files ending in `.txt` from `/work/01234/bjones/scripts` on Lonestar6 to the current directory on your local system:

<pre class="cmd-line">localhost$ <b>scp bjones@ls6.tacc.utexas.edu:/work/01234/bjones/ls6/\*.txt .</b></pre>

You can of course use shell or environment variables in your calls to `scp`. For example:

<pre class="cmd-line">
localhost$ <b>destdir="/work/01234/bjones/ls6/data"</b>
localhost$ <b>scp ./myfile bjones@ls6.tacc.utexas.edu:$destdir</b></pre>

You can also issue `scp` commands on your local client that use Lonestar6 environment variables like `$HOME`, `$WORK`, and `$SCRATCH`. To do so, use a backslash (`\`) as an escape character before the `$`; this ensures that expansion occurs after establishing the connection to Lonestar6:

<!-- pre class="cmd-line">localhost$ <b>scp ./myfile bjones@ls6.tacc.utexas.edu:\$WORK/data   # Note backslash</b></pre -->
<pre class="cmd-line">localhost$ <b>scp ./myfile bjones@ls6.tacc.utexas.edu:\$SCRATCH/data   # Note backslash</b></pre>

Avoid using `scp` for recursive transfers of directories that contain nested directories of many small files:

<!-- pre class="cmd-line">localhost$ <s>scp -r ./mydata     bjones@ls6.tacc.utexas.edu:\$WORK</s>  # DON'T DO THIS</pre -->
<pre class="cmd-line">localhost$ <s>scp -r ./mydata     bjones@ls6.tacc.utexas.edu:\$SCRATCH</s>  # DON'T DO THIS</pre>

Instead, use `tar` to create an archive of the directory, then transfer the directory as a single file:

<pre class="cmd-line">
localhost$ <b>tar cvf ./mydata.tar mydata                                  # create archive</b>
<!--localhost$ <b>scp     ./mydata.tar bjones@ls6.tacc.utexas.edu:\$SCRATCH  # transfer archive</b></pre>-->
localhost$ <b>scp     ./mydata.tar bjones@ls6.tacc.utexas.edu:\$WORK  # transfer archive</b></pre>

#### Transferring Files with `rsync`

The `rsync` (remote synchronization) utility is a great way to synchronize files that you maintain on more than one system: when you transfer files using `rsync`, the utility copies only the changed portions of individual files. As a result, `rsync` is especially efficient when you only need to update a small fraction of a large dataset. The basic syntax is similar to `scp`:

<!-- pre class="cmd-line">
localhost$ <b>rsync       mybigfile bjones@ls6.tacc.utexas.edu:\$WORK/data</b>
localhost$ <b>rsync -avtr mybigdir  bjones@ls6.tacc.utexas.edu:\$WORK/data</b></pre -->

<pre class="cmd-line">
localhost$ <b>rsync       mybigfile bjones@ls6.tacc.utexas.edu:\$SCRATCH/data</b>
localhost$ <b>rsync -avtr mybigdir  bjones@ls6.tacc.utexas.edu:\$SCRATCH/data</b></pre>

The options on the second transfer are typical and appropriate when synching a directory: this is a <span style="white-space: nowrap;">recursive update (`-r`)</span> with verbose (`-v`) feedback; the synchronization preserves <span style="white-space: nowrap;">time stamps (`-t`)</span> as well as symbolic links and other meta-data (`-a`). Because `rsync` only transfers changes, recursive updates with `rsync` may be less demanding than an equivalent recursive transfer with `scp`.


### Sharing Files with Collaborators

If you wish to share files and data with collaborators in your project, see [Sharing Project Files on TACC Systems](http://portal.tacc.utexas.edu/tutorials/sharing-project-files) for step-by-step instructions. Project managers or delegates can use Unix group permissions and commands to create read-only or read-write shared workspaces that function as data repositories and provide a common work area to all project members.

<img alt="Lonestar6" src="../../../imgs/6lonestar/lonestar6-3.jpg" style="width: 800px; height: 524px; border-width: 1px; border-style: solid;" />
<p class="image-caption">Lonestar6: Stockyard File System</p>
## Access the System

### Secure Shell (SSH)

The "`ssh`" command (SSH protocol) is the standard way to connect to Lonestar6 (**`ls6.tacc.utexas.edu`**). SSH also includes support for the file transfer utilities `scp` and `sftp`. [Wikipedia](https://en.wikipedia.org/wiki/Secure_Shell) is a good source of information on SSH. SSH is available within Linux and from the terminal app in the Mac OS. If you are using Windows, you will need an SSH client that supports the SSH-2 protocol: e.g. [Bitvise](http://www.bitvise.com), [OpenSSH](http://www.openssh.com), [PuTTY](http://www.putty.org), or [SecureCRT](https://www.vandyke.com/products/securecrt/). Initiate a session using the `ssh` command or the equivalent; from the Linux command line the launch command looks like this:

<pre class="cmd-line">localhost$ <b>ssh <i>username</i>@ls6.tacc.utexas.edu</b></pre>

The above command will rotate connections across all available login nodes, `login1-login3`, and route your connection to one of them. To connect to a specific login node, use its full domain name:

<pre class="cmd-line">localhost$ <b>ssh <i>username</i>@login2.ls6.tacc.utexas.edu</b></pre>

To connect with X11 support on Lonestar6 (usually required for applications with graphical user interfaces), use the <span style="white-space: nowrap;">"`-X`"</span> or <span style="white-space: nowrap;">"`-Y`"</span> switch:

<pre class="cmd-line">localhost$ <b>ssh -X <i>username</i>@ls6.tacc.utexas.edu</b></pre>

To report a connection problem, execute the `ssh` command with the "`-vvv`" option and include the verbose output when submitting a help ticket.
**Do not run the "`ssh-keygen`" command on Lonestar6.** This command will create and configure a key pair that will interfere with the execution of job scripts in the batch system. If you do this by mistake, you can recover by renaming or deleting the `.ssh` directory located in your home directory; the system will automatically generate a new one for you when you next log into Lonestar6.

1. execute "`mv .ssh dot.ssh.old`" 
1. log out
1. log into Lonestar6 again

After logging in again the system will generate a properly configured key pair.

Regardless of your research workflow, <b>you'll need to master Linux basics</b> and a Linux-based text editor (e.g. `emacs`, `nano`, `gedit`, or `vi/vim`) to use the system properly. However, this user guide does not address these topics. There are numerous resources in a variety of formats that are available to help you learn Linux, including some listed on the <a href="https://portal.tacc.utexas.edu/training/course-materials">TACC</a> and training sites. If you encounter a term or concept in this user guide that is new to you, a quick internet search should help you resolve the matter quickly.

## Account Administration

### Check your Allocation Status

**You must be added to a Lonestar6 allocation in order to have access/login to Lonestar6.** The ability to log on to the TACC User Portal does NOT signify access to Lonestar6 or any TACC resource. Submit Lonestar6 allocations requests via [TACC's Resource Allocation System](https://tacc-submit.xras.xsede.org/). Continue to [manage your allocation's users](https://portal.tacc.utexas.edu/projects-and-allocations#) via the TACC User Portal. 

### Multi-Factor Authentication

Access to all TACC systems now requires Multi-Factor Authentication (MFA). You can create an MFA pairing on the TACC User Portal. After login on the portal, go to your account profile (Home->Account Profile), then click the "Manage" button under "Multi-Factor Authentication" on the right side of the page. See [Multi-Factor Authentication at TACC][TACCMFA] for further information. 

### Password Management

Use your TACC User Portal password for direct logins to TACC resources. You can change your TACC password through the [TACC User Portal][TACCUSERPORTAL]. Log into the portal, then select "Change Password" under the "HOME" tab. If you've forgotten your password, go to the [TACC User Portal](http://portal.tacc.utexas.edu/) home page and select "Password Reset" under the Home tab.

<img alt="Lonestar6" src="../../../imgs/6lonestar/lonestar6-2.jpg" style="width: 800px; height: 524px; border-width: 1px; border-style: solid;" />
<p class="image-caption">Lonestar6 IMAGE2</p>


### Linux Shell

The default login shell for your user account is Bash. To determine your current login shell, execute: 

<pre class="cmd-line">$ <b>echo $SHELL</b></pre>

If you'd like to change your login shell to `csh`, `sh`, `tcsh`, or `zsh`, submit a ticket through the [TACC](http://portal.tacc.utexas.edu/) portal. The `chsh` ("change shell") command will not work on TACC systems. 

When you start a shell on Lonestar6, system-level startup files initialize your account-level environment and aliases before the system sources your own user-level startup scripts. You can use these startup scripts to customize your shell by defining your own environment variables, aliases, and functions. These scripts (e.g. `.profile` and `.bashrc`) are generally hidden files: so-called dotfiles that begin with a period, visible when you execute: <span style="white-space: nowrap;">`ls -a`</span>.

Before editing your startup files, however, it's worth taking the time to understand the basics of how your shell manages startup. Bash startup behavior is very different from the simpler `csh` behavior, for example. The Bash startup sequence varies depending on how you start the shell (e.g. using `ssh` to open a login shell, executing the `bash` command to begin an interactive shell, or launching a script to start a non-interactive shell). Moreover, Bash does not automatically source your `.bashrc` when you start a login shell by using `ssh` to connect to a node. Unless you have specialized needs, however, this is undoubtedly more flexibility than you want: you will probably want your environment to be the same regardless of how you start the shell. The easiest way to achieve this is to execute <span style="white-space: nowrap;">`source ~/.bashrc`</span> from your `.profile`, then put all your customizations in `.bashrc`. The system-generated default startup scripts demonstrate this approach. We recommend that you use these default files as templates.

For more information see the [Bash Users' Startup Files: Quick Start Guide][TACCBASHQUICKSTART] and other online resources that explain shell startup. To recover the originals that appear in a newly created account, execute <span style="white-space: nowrap;">`/usr/local/startup_scripts/install_default_scripts`</span>.

### Environment Variables

Your environment includes the environment variables and functions defined in your current shell: those initialized by the system, those you define or modify in your account-level startup scripts, and those defined or modified by the [modules](#using-modules-to-manage-your-environment) that you load to configure your software environment. Be sure to distinguish between an environment variable's name (e.g. `HISTSIZE`) and its value (`$HISTSIZE`). Understand as well that a sub-shell (e.g. a script) inherits environment variables from its parent, but does not inherit ordinary shell variables or aliases. Use `export` (in Bash) or `setenv` (in `csh`) to define an environment variable.

Execute the `env` command to see the environment variables that define the way your shell and child shells behave. 

Pipe the results of `env` into `grep` to focus on specific environment variables. For example, to see all environment variables that contain the string GIT (in all caps), execute:

<pre class="cmd-line">$ <b>env | grep GIT</b></pre>

The environment variables `PATH` and `LD_LIBRARY_PATH` are especially important. `PATH` is a colon-separated list of directory paths that determines where the system looks for your executables. `LD_LIBRARY_PATH` is a similar list that determines where the system looks for shared libraries.

### Account-Level Diagnostics

TACC's `sanitytool` module loads an account-level diagnostic package that detects common account-level issues and often walks you through the fixes. You should certainly run the package's `sanitycheck` utility when you encounter unexpected behavior. You may also want to run `sanitycheck` periodically as preventive maintenance. To run `sanitytool`'s account-level diagnostics, execute the following commands:

<pre class="cmd-line">login1$ <b>module load sanitytool</b>
login1$ <b>sanitycheck</b></pre>

Execute `module help sanitytool` for more information.

### Using Modules to Manage your Environment

[Lmod](https://www.tacc.utexas.edu/research-development/tacc-projects/lmod), a module system developed and maintained at TACC, makes it easy to manage your environment so you have access to the software packages and versions that you need to conduct your research. This is especially important on a system like Lonestar6 that serves thousands of users with an enormous range of needs. Loading a module amounts to choosing a specific package from among available alternatives:

<pre class="cmd-line">
$ <b>module load intel</b>          # load the default Intel compiler v19.1.14
$ <b>module load intel/19.1.1</b>   # load a specific version of the Intel compiler</pre>
</pre>

A module does its job by defining or modifying environment variables (and sometimes aliases and functions). For example, a module may prepend appropriate paths to `$PATH` and `$LD_LIBRARY_PATH` so that the system can find the executables and libraries associated with a given software package. The module creates the illusion that the system is installing software for your personal use. Unloading a module reverses these changes and creates the illusion that the system just uninstalled the software:

<pre class="cmd-line">$ <b>module load   netcdf</b>  # defines DDT-related env vars; modifies others
$ <b>module unload netcdf</b>  # undoes changes made by load</pre>

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

On Lonestar6, modules generally adhere to a TACC naming convention when defining environment variables that are helpful for building and running software. For example, the `papi` module defines `TACC_PAPI_BIN` (the path to PAPI executables), `TACC_PAPI_LIB` (the path to PAPI libraries), `TACC_PAPI_INC` (the path to PAPI include files), and `TACC_PAPI_DIR` (top-level PAPI directory). After loading a module, here are some easy ways to observe its effects:

<pre class="cmd-line">$ <b>module show netcdf</b>   # see what this module does to your environment
$ <b>env | grep NETCDF</b>    # see env vars that contain the string PAPI
$ <b>env | grep -i netcdf</b> # case-insensitive search for 'papi' in environment</pre>

To see the modules you currently have loaded:

<pre class="cmd-line">$ <b>module list</b></pre>

To see all modules that you can load right now because they are compatible with the currently loaded modules:

<pre class="cmd-line">$ <b>module avail</b></pre>

To see all installed modules, even if they are not currently available because they are incompatible with your currently loaded modules:

<pre class="cmd-line">$ <b>module spider</b>   # list all modules, even those not available to load</pre>

To filter your search:

<pre class="cmd-line">
$ <b>module spider netcdf</b>             # all modules with names containing 'slep'
$ <b>module spider netcdf/3.6.3</b>       # additional details on a specific module</pre>

Among other things, the latter command will tell you which modules you need to load before the module is available to load. You might also search for modules that are tagged with a keyword related to your needs (though your success here depends on the diligence of the module writers). For example:
<pre class="cmd-line">$ <b>module keyword performance</b></pre>

You can save a collection of modules as a personal default collection that will load every time you log into Lonestar6. To do so, load the modules you want in your collection, then execute:

<pre class="cmd-line">$ <b>module save</b>    # save the currently loaded collection of modules </pre>

Two commands make it easy to return to a known, reproducible state:

<pre class="cmd-line">$ <b>module reset</b>   # load the system default collection of modules
$ <b>module restore</b> # load your personal default collection of modules</pre>

On TACC systems, the command `module reset` is equivalent to `module purge; module load TACC`. It's a safer, easier way to get to a known baseline state than issuing the two commands separately.

Help text is available for both individual modules and the module system itself:

<pre class="cmd-line">$ <b>module help swr</b>     # show help text for software package swr
$ <b>module help</b>         # show help text for the module system itself</pre>

See [Lmod's online documentation](http://lmod.readthedocs.org) for more extensive documentation. The online documentation addresses the basics in more detail, but also covers several topics beyond the scope of the help text (e.g. writing and using your own module files).

It's safe to execute module commands in job scripts. In fact, this is a good way to write self-documenting, portable job scripts that produce reproducible results. If you use <span style="white-space: nowrap;">`module save`</span> to define a personal default module collection, it's rarely necessary to execute module commands in shell startup scripts, and it can be tricky to do so safely. If you do wish to put module commands in your startup scripts, see Lonestar6's default startup scripts for a safe way to do so.

## Building Software

The phrase "building software" is a common way to describe the process of producing a machine-readable executable file from source files written in C, Fortran, or some other programming language. In its simplest form, building software involves a simple, one-line call or short shell script that invokes a compiler. More typically, the process leverages the power of <a href="http://www.gnu.org/software/make/manual/make.html">makefiles</a>, so you can change a line or two in the source code, then rebuild in a systematic way only the components affected by the change. Increasingly, however, the build process is a sophisticated multi-step automated workflow managed by a special framework like <a href="http://www.gnu.org/software/automake/manual/html_node/Autotools-Introduction.html">autotools</a> or <a href="http://cmake.org"><code>cmake</code></a>, intended to achieve a repeatable, maintainable, portable mechanism for installing software across a wide range of target platforms.</p>

### The Basics of Building Software

This section of the user guide does nothing more than introduce the big ideas with simple one-line examples. You will undoubtedly want to explore these concepts more deeply using online resources. You will quickly outgrow the examples here. We recommend that you master the basics of makefiles as quickly as possible: even the simplest computational research project will benefit enormously from the power and flexibility of a makefile-based build process.

### Intel Compilers

Intel is the recommended and default compiler suite on Lonestar6. Each Intel module also gives you direct access to `mkl` without loading an `mkl` module; see [Intel MKL](#the-intel-math-kernel-library-mkl) for more information. Here are simple examples that use the Intel compiler to build an executable from source code:

Compiling a code that uses OpenMP would look like this:

<pre class="cmd-line">
$ <b>icc -qopenmp mycode.c -o myexe</b>  # OpenMP</pre>

See the published Intel documentation, available both [online](http://software.intel.com/en-us/intel-software-technical-documentation) and in `${TACC_INTEL_DIR}/documentation`, for information on optimization flags and other Intel compiler options.

### GNU Compilers

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

### Compiling and Linking as Separate Steps

Building an executable requires two separate steps: (1) compiling (generating a binary object file associated with each source file); and (2) linking (combining those object files into a single executable file that also specifies the libraries that executable needs). The examples in the previous section accomplish these two steps in a single call to the compiler. When building more sophisticated applications or libraries, however, it is often necessary or helpful to accomplish these two steps separately.

Use the `-c` ("compile") flag to produce object files from source files:

<pre class="cmd-line">
$ <b>icc -c main.c calc.c results.c</b>
</pre>

Barring errors, this command will produce object files `main.o`, `calc.o`, and `results.o`. Syntax for other compilers Intel and GNU compilers is similar.

You can now link the object files to produce an executable file:

<pre class="cmd-line">
$ <b>icc main.o calc.o results.o -o myexe</b></pre>

The compiler calls a linker utility (usually `/bin/ld`) to accomplish this task. Again, syntax for other compilers is similar.

### Include and Library Paths

Software often depends on pre-compiled binaries called libraries. When this is true, compiling usually requires using the `-I` option to specify paths to so-called header or include files that define interfaces to the procedures and data in those libraries. Similarly, linking often requires using the `-L` option to specify paths to the libraries themselves. Typical compile and link lines might look like this:

<pre class="cmd-line">
$ <b>icc        -c main.c -I${WORK}/mylib/inc -I${TACC_HDF5_INC}</b>                  # compile
$ <b>icc main.o -o myexe  -L${WORK}/mylib/lib -L${TACC_HDF5_LIB} -lmylib -lhdf5</b>   # link
</pre>

On Lonestar6, both the `hdf5` and `phdf5` modules define the environment variables `$TACC_HDF5_INC` and `$TACC_HDF5_LIB`. Other module files define similar environment variables; see [Using Modules](#admin-modules) for more information.

The details of the linking process vary, and order sometimes matters. Much depends on the type of library: static (`.a` suffix; library's binary code becomes part of executable image at link time) versus dynamically-linked shared (.so suffix; library's binary code is not part of executable; it's located and loaded into memory at run time). The link line can use rpath to store in the executable an explicit path to a shared library. In general, however, the `LD_LIBRARY_PATH` environment variable specifies the search path for dynamic libraries. For software installed at the system-level, TACC's modules generally modify `LD_LIBRARY_PATH` automatically. To see whether and how an executable named `myexe` resolves dependencies on dynamically linked libraries, execute `ldd myexe`.

A separate section below addresses the [Intel Math Kernel Library](#the-intel-math-kernel-library-mkl) (MKL).

### Compiling and Linking MPI Programs

Intel MPI (module `impi`) and MVAPICH2 (module `mvapich2`) are the two MPI libraries available on Lonestar6. After loading an `impi` or `mvapich2` module, compile and/or link using an mpi wrapper (`mpicc`, `mpicxx`, `mpif90`) in place of the compiler:

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


### Building Third-Party Software

You can discover already installed software using TACC's [Software Search](https://www.tacc.utexas.edu/systems/software) tool or execute `module spider` or `module avail` on the command-line.

You're welcome to download third-party research software and install it in your own account. In most cases you'll want to download the source code and build the software so it's compatible with the Lonestar6 software environment. You can't use yum or any other installation process that requires elevated privileges, but this is almost never necessary. The key is to specify an installation directory for which you have write permissions. Details vary; you should consult the package's documentation and be prepared to experiment. When using the famous [three-step autotools](http://www.gnu.org/software/automake/manual/html_node/Autotools-Introduction.html) build process, the standard approach is to use the `PREFIX` environment variable to specify a non-default, user-owned installation directory at the time you execute `configure` or `make`:

<pre class="cmd-line">
$ <b>export INSTALLDIR=$WORK/apps/t3pio</b>
$ <b>./configure --prefix=$INSTALLDIR</b>
$ <b>make</b>
$ <b>make install</b>
</pre>

Other languages, frameworks, and build systems generally have equivalent mechanisms for installing software in user space. In most cases a web search like "Python Linux install local" will get you the information you need.

In Python, a local install will resemble one of the following examples:

<pre class="cmd-line">
$ <b>pip3 install netCDF4      --user</b>                  # install netCDF4 package to $HOME/.local
$ <b>python3 setup.py install --user</b>                   # install to $HOME/.local
$ <b>pip3 install netCDF4     --prefix=$INSTALLDIR</b>     # custom location; add to PYTHONPATH
</pre>

Similarly in R:

<pre class="cmd-line">
$ <b>module load Rstats</b>            # load TACC's default R
$ <b>R</b>                             # launch R
> <b>install.packages('devtools')</b>  # R will prompt for install location
</pre>

You may, of course, need to customize the build process in other ways. It's likely, for example, that you'll need to edit a `makefile` or other build artifacts to specify Lonestar6-specific [include and library paths](#include-and-library-paths) or other compiler settings. A good way to proceed is to write a shell script that implements the entire process: definitions of environment variables, module commands, and calls to the build utilities. Include `echo` statements with appropriate diagnostics. Run the script until you encounter an error. Research and fix the current problem. Document your experience in the script itself; including dead-ends, alternatives, and lessons learned. Re-run the script to get to the next error, then repeat until done. When you're finished, you'll have a repeatable process that you can archive until it's time to update the software or move to a new machine.

If you wish to share a software package with collaborators, you may need to modify file permissions. See [Sharing Files with Collaborators](http://portal.tacc.utexas.edu/tutorials/sharing-project-files) for more information.

/Intel MKL
= File.read "../../include/lonestar6-mkl.html"

## Launching Applications

The primary purpose of your job script is to launch your research application. How you do so depends on several factors, especially (1) the type of application (e.g. MPI, OpenMP, serial), and (2) what you're trying to accomplish (e.g. launch a single instance, complete several steps in a workflow, run several applications simultaneously within the same job). While there are many possibilities, your own job script will probably include a launch line that is a variation of one of the examples described in this section.</p>

### Launching One Serial Application

To launch a serial application, simply call the executable. Specify the path to the executable in either the PATH environment variable or in the call to the executable itself:

<pre class="job-script">
myprogram								# executable in a directory listed in $PATH
$SCRATCH/apps/mydir/myprogram			# explicit full path to executable
./myprogram								# executable in current directory
./myprogram -m -k 6 input1				# executable with notional input options</pre>

### Parametric Sweep / HTC jobs

Consult the [Launcher at TACC](/software/launcher) documentation for instructions on running parameter sweep and other High Throughput Computing workflows.


### Launching One Multi-Threaded Application

Launch a threaded application the same way. Be sure to specify the number of threads. Note that the default OpenMP thread count is 1.

<pre class="job-script">
export OMP_NUM_THREADS=128   	# 128 total OpenMP threads (1 per core)
./myprogram</pre>

### Launching One MPI Application

To launch an MPI application, use the TACC-specific MPI launcher `ibrun`, which is a Lonestar6-aware replacement for generic MPI launchers like `mpirun` and `mpiexec`. In most cases the only arguments you need are the name of your executable followed by any arguments your executable needs. When you call `ibrun` without other arguments, your Slurm `#SBATCH` directives will determine the number of ranks (MPI tasks) and number of nodes on which your program runs.

<pre class="job-script">
#SBATCH -N 4				
#SBATCH -n 512

# ibrun uses the $SBATCH directives to properly allocate nodes and tasks
ibrun ./myprogram				
</pre>

To use `ibrun` interactively, say within an `idev` session, you can specify:

<pre class="cmd-line">
login1$ <b>idev -N 2 -n 100 </b>				
c309-005$ <b>ibrun ./myprogram</b>
</pre>

### Launching One Hybrid (MPI+Threads) Application

When launching a single application you generally don't need to worry about affinity: both Intel MPI and MVAPICH2 will distribute and pin tasks and threads in a sensible way.

<pre class="job-script">
export OMP_NUM_THREADS=8    # 8 OpenMP threads per MPI rank
ibrun ./myprogram           # use ibrun instead of mpirun or mpiexec</pre>

As a practical guideline, the product of `$OMP_NUM_THREADS` and the maximum number of MPI processes per node should not be greater than total number of cores available per node (128 cores in the `development`/`normal`/`large` [queues](#queues)).


### More Than One Serial Application in the Same Job

TACC's `launcher` utility provides an easy way to launch more than one serial application in a single job. This is a great way to engage in a popular form of High Throughput Computing: running parameter sweeps (one serial application against many different input datasets) on several nodes simultaneously. The launcher utility will execute your specified list of independent serial commands, distributing the tasks evenly, pinning them to specific cores, and scheduling them to keep cores busy. Execute <span style="white-space: nowrap;">`module load launcher`</span> followed by <span style="white-space: nowrap;">`module help launcher`</span> for more information.

### MPI Applications One at a Time

To run one MPI application after another (or any sequence of commands one at a time), simply list them in your job script in the order in which you'd like them to execute. When one application/command completes, the next one will begin.

<pre class="job-script">
./preprocess.sh
ibrun ./myprogram input1    # runs after preprocess.sh completes
ibrun ./myprogram input2    # runs after previous MPI app completes
</pre>

### More Than One MPI Application Running Concurrently

To run more than one MPI application simultaneously in the same job, you need to do several things:

* use ampersands to launch each instance in the background;
* include a wait command to pause the job script until the background tasks complete;
* use `ibrun`'s `-n` and `-o` switches to specify task counts and hostlist offsets respectively; and
* include a call to the `task_affinity` script in your `ibrun` launch line.

If, for example, you use `#SBATCH` directives to request N=4 nodes and n=256 total MPI tasks, Slurm will generate a hostfile with 256 entries (64 entries for each of 4 nodes). The `-n` and `-o` switches, which must be used together, determine which hostfile entries ibrun uses to launch a given application; execute `ibrun --help` for more information. Don't forget the ampersands ("&") to launch the jobs in the background, and the `wait` command to pause the script until the background tasks complete:

<pre class="job-script">
# 128 tasks; offset by  0 entries in hostfile.
ibrun -n 128 -o  0 task_affinity ./myprogram input1 &   

# 128 tasks; offset by 128 entries in hostfile.
ibrun -n 128 -o 128 task_affinity ./myprogram input2 &   

# Required; else script will exit immediately.
wait
</pre>

The `task_affinity` script manages task placement and memory pinning when you call ibrun with the `-n`, `-o` switches (it's not necessary under any other circumstances). 

### More than One OpenMP Application Running Concurrently

You can also run more than one OpenMP application simultaneously on a single node, but you will need to distribute and pin OpenMP threads appropriately. The most portable way to do this is with OpenMP Affinity.

An OpenMP executable sequentially assigns its `N` forked threads (thread number `0,...N-1`) at a parallel region to the sequence of "places" listed in the `$OMP_PLACES` environment variable. Each place is specified within braces ({}). The sequence "`{0,1},{2,3},{4,5}`" has three places, and OpenMP thread numbers `0`, `1`, and `2` are assigned to the processor ids (proc-ids) `0,1` and `2,3` and `4,5`, respectively. The hardware assigned to the proc-ids can be found in the `/proc/cpuinfo` file.

The sequence of proc-ids on socket 0 and socket 1 are sequentially numbered.  

On socket 0:

<pre class="syntax">0,1,2,...,62,63 </pre>

and on socket 1:

<pre class="syntax">64,65,...,126,127</pre>

Note, hardware threads are not enabled on Lonestar6.  So, there are no core ids greater than 127.

The proc-id mapping to the cores for Milan is:

<pre class="syntax">
|------- Socket 0 ------------|-------- Socket 1 -------------|
#   0   1   2,..., 61, 62, 63 |  0   1   2,...,  61,  62,  63 |
0   0   1   2,..., 61, 62, 63 | 64  65  66,..., 125, 126, 127 |</pre>

Hence, to bind OpenMP threads to a sequence of 3 cores on each socket, the places would be:

<pre class="job-script">
socket 0:  export OMP_PLACES="{0},{1},{2}"
socket 1:  export OMP_PLACES="{64},{65},{66}"</pre>

Under the NUMA covers, each AMD chip is actually composed of 8 "chiplets" which share a 32 MB L3 cache.  To place each thread on its own chiplet for an 8 thread OpenMP program, you would use this command:

<pre class="job-script">
socket 0:  export OMP_PLACES="{0},{8},{16},{24},{32},{40},{48},{56}"
socket 1:  export OMP_PLACES="{64},{72},{80},{88},{96},{104},{112},{120}"</pre>

Interval notation can be used to express a sequence of places. The syntax is: {proc-ids},N,S, where N is the number of places to create from the base place ({proc-ids}) with a stride of S. Hence the above sequences could have been written:

<pre class="job-script">
socket 0:  export OMP_PLACES="{0},8,8"
socket 1:  export OMP_PLACES="{64},8,8"</pre>

In the example below two OpenMP programs are executed on a single node, each using 64 threads. The first program uses the cores on socket 0. It is put in the background, using the ampersand (&amp;) character at the end of the line, so that the job script execution can continue to the second OpenMP program execution, which uses the cores on socket 1. It, too, is put in the background, and the job execution waits for both to finish with the wait command at the end.

<pre class="job-script">
export OMP_NUM_THREADS=64
env OMP_PLACES="{0},64,1" ./omp.exe &    #execution on socket 0 cores
env OMP_PLACES="{64},64,1" ./omp.exe &   #execution on socket 1 cores
wait</pre>

## Running Jobs on Lonestar6

This section provides an overview of how compute jobs are charged to allocations and describes the **S**imple **L**inux **U**tility for **R**esource **M**anagement (Slurm) batch environment, Lonestar6 queue structure, lists basic Slurm job control and monitoring commands along with options.

{% include 'include/jobaccounting.md' %}

### Production Queues

Lonestar6's new queue, "`vm-small`" is designed for users who only need a subset of a node's entire 128 cores in the "normal" queue.  Run your jobs in this queue if your job requires 16 cores or less and needs less than 29 GB of memory.  If your job is memory bandwidth dependent, your performance may decrease since your job will be possibly sharing memory bandwidth with other jobs.  

The jobs in this queue consume 1/7 the resources of a full node.  Jobs are charged accordingly at .143 SUs per node hour.

Table. Lonestar6 Production Queues

!!! warning
	**Queue limits are subject to change without notice.**

%th Queue Name
| Min/Max Nodes per Job<br /> (assoc'd cores)&#42;
| Max Job Duration
| Max Nodes<br> per User
| Max Jobs<br> per User
| Charge Rate<br /><span style="white-space: nowrap;">(per node-hour)</span>
			%tr(align="center")
%td <code>normal</code>
| 1/64 nodes<br>(8192 cores)
| 48 hours 
| 96 
| 15 
| 1 SU
			%tr(align="center")
%td <code>large</code><sup>&#42;</sup>
| 65/256 nodes<br>(65536 cores)
| 48 hours 
| 256 
| 1 
| 1 SU
			%tr(align="center")
%td <code>development</code>
| 4 nodes<br>(512 cores)
| 2 hours 
| 6 
| 1 
| 1 SU
			%tr(align="center")
%td <code>gpu-a100</code>
| 4 nodes<br>(512 cores)
| 48 hours 
| 6 
| 2 
| 4 SUs
			%tr(align="center")
%td <code>vm-small</code><sup>&#42;&#42;</sup>
| 1/1 node<br>(16 cores)
| 48 hours 
| 4
| 4
| 0.143 SU
		

&#42; Access to the `large` queue is restricted. To request more nodes than are available in the normal queue, submit a consulting (help desk) ticket through the TACC User Portal. Include in your request reasonable evidence of your readiness to run under the conditions you're requesting. In most cases this should include your own strong or weak scaling results from Lonestar6.

&#42;&#42; The `vm-small` queue contains virtual nodes with fewer resources (cores) than the nodes in the other queues.


## Sample Job Scripts

### Serial Codes

**Run all serial jobs in the `normal` queue.**  

Serial codes should request 1 node (`#SBATCH -N 1`) with 1 task (`#SBATCH -n 1`). Consult the [Launcher at TACC](https://portal.tacc.utexas.edu/software/launcher) documentation to run multiple serial executables at one time.

<pre class="job-script">
#!/bin/bash
#----------------------------------------------------
# Sample Slurm job script
#   for TACC Lonestar6 AMD Milan nodes
#
#   *** Serial Job in Normal Queue***
# 
# Last revised: October 22, 2021
#
# Notes:
#
#  -- Copy/edit this script as desired.  Launch by executing
#     "sbatch milan.serial.slurm" on a Lonestar6 login node.
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
#SBATCH -p normal          # Queue (partition) name
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
./myprogram         # Do not use ibrun or any other MPI launcher</pre>

### MPI Jobs

This job script requests 4 nodes (`#SBATCH -N 4`) and 32 tasks (`#SBATCH -n 32`), for 8 MPI rasks per node.  

<pre class="job-script">
#!/bin/bash
#----------------------------------------------------
# Sample Slurm job script
#   for TACC Lonestar6 AMD Milan nodes
#
#   *** MPI Job in Normal Queue ***
# 
# Last revised: October 22, 2021
#
# Notes:
#
#   -- Launch this script by executing
#      "sbatch milan.mpi.slurm" on a Lonestar6 login node.
#
#   -- Use ibrun to launch MPI codes on TACC systems.
#      Do NOT use mpirun or mpiexec.
#
#   -- Max recommended MPI ranks per Milan node: 128
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
ibrun ./myprogram         # Use ibrun instead of mpirun or mpiexec</pre>


### Hybrid (MPI + OpenMP) Job

This script requests 10 nodes (`#SBATCH -N 10`) and 40 tasks (`#SBATCH -n 40`).  

<pre class="job-script">
#!/bin/bash
#----------------------------------------------------
# Example Slurm job script
# for TACC Lonestar6 AMD Milan nodes
#
#   *** Hybrid Job in Normal Queue ***
# 
#       This sample script specifies:
#         10 nodes (capital N)
#         40 total MPI tasks (lower case n); this is 4 tasks/node
#         <span style="color:red">14 OpenMP threads per MPI task (56 threads per node)</span>
#
# Last revised: October 22, 2021
#
# Notes:
#
#   -- Launch this script by executing
#      "sbatch milan.hybrid.slurm" on Lonestar6 login node.
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
ibrun ./myprogram         # Use ibrun instead of mpirun or mpiexec</pre>


### OpenMP Jobs

**Run all OpenMP jobs in the `normal` queue.**  

<pre class="job-script">
#!/bin/bash
#----------------------------------------------------
# Sample Slurm job script
#   for TACC Lonestar6 AMD Milan nodes
#
#   *** OpenMP Job in Normal Queue ***
# 
# Last revised: October 22, 2021
#
# Notes:
#
#   -- Launch this script by executing
#   -- Copy/edit this script as desired.  Launch by executing
#      "sbatch milan.openmp.slurm" on a Lonestar6 login node.
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
#SBATCH -p normal          # Queue (partition) name
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
./myprogram         # Do not use ibrun or any other MPI launcher</pre>


### Customizing your Job Script 

Copy and customize the following scripts to specify and refine your job's requirements.</p>

* specify the maximum run time with the `-t` option. 
* specify number of nodes needed with the `-N` option
* specify tasks per node with the `-n` option
* specify the project to be charged with the `-A` option.

In general, the fewer resources (nodes) you specify in your batch script, the less time your job will wait in the queue. See [4. Request Only the Resources You Need](#conduct-resources) in the [Good Conduct](#conduct) section. 

Consult [Table 6](/user-guides/stampede2#table6) in the [Stampede2 User Guide](/user-guides/stampede2) for a listing of common Slurm `#SBATCH` options.

## Job Management

In this section, we present several Slurm commands and other utilities that are available to help you plan and track your job submissions as well as check the status of the Slurm queues.

When interpreting queue and job status, remember that **Lonestar6 doesn't operate on a first-come-first-served basis**. Instead, the sophisticated, tunable algorithms built into Slurm attempt to keep the system busy, while scheduling jobs in a way that is as fair as possible to everyone. At times this means leaving nodes idle ("draining the queue") to make room for a large job that would otherwise never run. It also means considering each user's "fair share", scheduling jobs so that those who haven't run jobs recently may have a slightly higher priority than those who have.

### Monitoring Queue Status

#### TACC's `qlimits` command

To display resource limits for the Lonestar queues, execute: STTYLERED`qlimits`</span>. The result is real-time data; the corresponding information in this document's [table of Lonestar6 queues](#running-queues) may lag behind the actual configuration that the `qlimits` utility displays.

#### Slurm's `sinfo` command

Slurm's `sinfo` command allows you to monitor the status of the queues. If you execute `sinfo` without arguments, you'll see a list of every node in the system together with its status. To skip the node list and produce a tight, alphabetized summary of the available queues and their status, execute:

<pre class="cmd-line">login1$ <b>sinfo -S+P -o "%18P %8a %20F"</b>    # compact summary of queue status</pre>

An excerpt from this command's output might look like this:

<pre class="cmd-line"><span style="color:red">
login1$ <b>sinfo -S+P -o "%18P %8a %20F"</b>
PARTITION          AVAIL    NODES(A/I/O/T)    
development        up       0/8/0/8
v100               up       44/43/1/96          
v100-lm            up       0/8/0/8</span></pre>
	
The `AVAIL` column displays the overall status of each queue (up or down), while the column labeled `NODES(A/I/O/T)` shows the number of nodes in each of several states ("**A**llocated", "**I**dle", "**O**ffline", and "**T**otal"). Execute `man sinfo` for more information. Use caution when reading the generic documentation, however: some available fields are not meaningful or are misleading on Lonestar6 (e.g. `TIMELIMIT`, displayed using the `%l` option).

### Monitoring Job Status

#### Slurm's `squeue` command

Slurm's `squeue` command allows you to monitor jobs in the queues, whether pending (waiting) or currently running:

<pre class="cmd-line">
login1$ <b>squeue</b>             # show all jobs in all queues
login1$ <b>squeue -u bjones</b>   # show all jobs owned by bjones
login1$ <b>man squeue</b>         # more info</pre>

An excerpt from the default output might look like this:

<pre class="cmd-line"><span style="color:red">
 JOBID   PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
25781 development idv72397   bjones CG       9:36      2 c001-011,012
25918 development ppm_4828   bjones PD       0:00     20 (Resources)
25915 development MV2-test    siliu PD       0:00     14 (Priority)
25589        v100   aatest slindsey PD       0:00      8 (Dependency)
25949 development psdns_la sniffjck PD       0:00      2 (Priority)
25618        v100   SP256U   connor PD       0:00      1 (Dependency)
25944        v100  MoTi_hi   wchung  R      35:13      1 c005-003
25945        v100 WTi_hi_e   wchung  R      27:11      1 c006-001
25606        v100   trainA   jackhu  R   23:28:28      1 c008-012</span>
</pre>

The column labeled `ST` displays each job's status: 

* `PD` means "Pending" (waiting); 
* `R`  means "Running";
* `CG` means "Completing" (cleaning up after exiting the job script).

Pending jobs appear in order of decreasing priority. The last column includes a nodelist for running/completing jobs, or a reason for pending jobs. If you submit a job before a scheduled system maintenance period, and the job cannot complete before the maintenance begins, your job will run when the maintenance/reservation concludes. The `squeue` command will report `ReqNodeNotAvailable` ("Required Node Not Available"). The job will remain in the `PD` state until Lonestar6 returns to production.

The default format for `squeue` now reports total nodes associated with a job rather than cores, tasks, or hardware threads. One reason for this change is clarity: the operating system sees each compute node's 56 hardware threads as "processors", and output based on that information can be ambiguous or otherwise difficult to interpret. 

The default format lists all nodes assigned to displayed jobs; this can make the output difficult to read. A handy variation that suppresses the nodelist is:

<pre class="cmd-line">login1$ <b>squeue -o "%.10i %.12P %.12j %.9u %.2t %.9M %.6D"</b>  # suppress nodelist</pre>

The `--start` option displays job start times, including very rough estimates for the expected start times of some pending jobs that are relatively high in the queue:

<pre class="cmd-line">login1$ <b>squeue --start -j 167635</b>     # display estimated start time for job 167635</pre>

#### TACC's `showq` utility

TACC's `showq` utility mimics a tool that originated in the PBS project, and serves as a popular alternative to the Slurm `squeue` command:

<pre class="cmd-line">
login1$ <b>showq</b>                 # show all jobs; default format
login1$ <b>showq -u</b>              # show your own jobs
login1$ <b>showq -U bjones</b>       # show jobs associated with user bjones
login1$ <b>showq -h</b>              # more info</pre>

The output groups jobs in four categories: `ACTIVE`, `WAITING`, `BLOCKED`, and `COMPLETING/ERRORED`. A `BLOCKED` job is one that cannot yet run due to temporary circumstances (e.g. a pending maintenance or other large reservation.).

If your waiting job cannot complete before a maintenance/reservation begins, `showq` will display its state as `**WaitNod**` ("Waiting for Nodes"). The job will remain in this state until Lonestar6 returns to production.

The default format for `showq` now reports total nodes associated with a job rather than cores, tasks, or hardware threads. One reason for this change is clarity: the operating system sees each compute node's 112 hardware threads as "processors", and output based on that information can be ambiguous or otherwise difficult to interpret.

### Other Job Management Commands

 `scancel`, `scontrol`, and `sacct`

**It's not possible to add resources to a job (e.g. allow more time)** once you've submitted the job to the queue.

To **cancel** a pending or running job, first determine its jobid, then use `scancel`:

<pre class="cmd-line">
login1$ <b>squeue -u bjones</b>    # one way to determine jobid
 JOBID   PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
170361        v100   spec12   bjones PD       0:00     32 (Resources)
login1$ <b>scancel 170361</b>      # cancel job</pre>

For **detailed information** about the configuration of a specific job, use `scontrol`:

<pre class="cmd-line">login1$ <b>scontrol show job=170361</b></pre>

To view some **accounting data** associated with your own jobs, use `sacct`:

<pre class="cmd-line">login1$ <b>sacct --starttime 2019-06-01</b>  # show jobs that started on or after this date</pre>

### Dependent Jobs using `sbatch`

You can use `sbatch` to help manage workflows that involve multiple steps: the `--dependency` option allows you to launch jobs that depend on the completion (or successful completion) of another job. For example you could use this technique to split into three jobs a workflow that requires you to (1) compile on a single node; then (2) compute on 40 nodes; then finally (3) post-process your results using 4 nodes. 

<pre class="cmd-line">login1$ <b>sbatch --dependency=afterok:173210 myjobscript</b></pre>

For more information see the [Slurm online documentation](http://www.schedmd.com). Note that you can use `$SLURM_JOBID` from one job to find the jobid you'll need to construct the `sbatch` launch line for a subsequent one. But also remember that you can't use `sbatch` to submit a job from a compute node.

## Visualization and Virtual Network Computing (VNC) Sessions

Lonestar6 uses AMD's Milan processors for all visualization and rendering operations. We use the Intel OpenSWR library to render raster graphics with OpenGL, and the Intel OSPRay framework for ray traced images inside visualization software. OpenSWR can be loaded by executing "`module load swr`".

Lonestar6 currently has no separate visualization queue. All visualization apps are available on all nodes. VNC and DCV sessions are available on any queue, either through the command line or via the [TACC Visualization Portal](https://vis.tacc.utexas.edu/). We recommend submitting to Lonestar6's `development` queue for interactive sessions. If you are interested in an application that is not yet available, please submit a help desk ticket.

### Remote Desktop Access

Remote desktop access to Lonestar6 is formed through a DCV or VNC connection to one or more compute nodes. Users must first connect to a Lonestar6 login node (see [Accessing the System](#access) and submit a special interactive batch job that:

* allocates a set of Lonestar6 compute nodes
* starts a `dcvserver` or `vncserver` remote desktop process on the first allocated node
* sets up a tunnel through the login node to the dcvserver or vncserver access port

Once the remote desktop process is running on the compute node and a tunnel through the login node is created, an output message identifies the access port for connecting a remote desktop viewer. A remote desktop viewer application is run on the user's remote system and presents the desktop to the user.

**Note**: If this is your first time connecting to Lonestar6 using VNC, you must run `vncpasswd` to create a password for your VNC servers. This should NOT be your login password! This mechanism only deters unauthorized connections; it is not fully secure, as only the first eight characters of the password are saved. All VNC connections are tunneled through SSH for extra security, as described below.

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


	Consult [Table 6](/user-guides/stampede2#table6) in the [Stampede2 User Guide](/user-guides/stampede2) for a listing of common Slurm `#SBATCH` options.

	All arguments after the job script name are sent to the vncserver command. For example, to set the desktop resolution to 1440x900, use:

	<pre class="cmd-line">login1$ <b>sbatch /share/doc/slurm/job.vnc -geometry 1440x900</b></pre>

	The "`vnc.job`" script starts a `vncserver` process and writes to the output file, "`vncserver.out`" in the job submission directory, with the connect port for the vncviewer. 

	Note that the DCV viewer adjusts desktop resolution to your browser or DCV client, so desktop resolution does not need to be specified.

	Watch for the "To connect" message at the end of the output file, or watch the output stream in a separate window with the commands:

	<pre class="cmd-line">
	login1$ <b>touch vncserver.out ; tail -f vncserver.out</b>
	login1$ <b>touch dcvserver.out ; tail -f dcvserver.out</b></pre>

	The lightweight window manager, `xfce`, is the default DCV and VNC desktop and is recommended for remote performance. Gnome is available; to use gnome, open the "`~/.vnc/xstartup`" file (created after your first VNC session) and replace "`startxfce4`" with "`gnome-session`". Note that gnome may lag over slow internet connections.<p>&nbsp;</p>

1. Create an SSH Tunnel to Lonestar6

	DCV connections are encrypted via TLS and are secure. For VNC connections, TACC requires users to create an SSH tunnel from the local system to the Lonestar6 login node to assure that the connection is secure. The tunnels created for the VNC job operate only on the `localhost` interface, so you must use `localhost` in the port forward argument, not the Lonestar6 hostname. On a Unix or Linux system, execute the following command once the port has been opened on the Lonestar6 login node:

	<pre class="cmd-line">localhost$ <b>ssh -f -N -L <i>xxxx</i>:localhost:<i>yyyy</i> <i>username</i>@ls6.tacc.utexas.edu</b></pre>

	where:

	* <code><i>yyyy</i></code> is the port number given by the vncserver batch job
	* <code><i>xxxx</i></code> is a port on the remote system. Generally, the port number specified on the Lonestar6 login node, <code><i>yyyy</i></code>, is a good choice to use on your local system as well
	* `-f` instructs SSH to only forward ports, not to execute a remote command
	* `-N` puts the ssh command into the background after connecting
	* `-L` forwards the port   

	On Windows systems find the menu in the Windows SSH client where tunnels can be specified, and enter the local and remote ports as required, then ssh to Lonestar6.  <p>&nbsp;</p>


1. Connecting the vncviewer

	Once the SSH tunnel has been established, use a [VNC client](https://en.wikipedia.org/wiki/Virtual_Network_Computing) to connect to the local port you created, which will then be tunneled to your VNC server on Lonestar6. Connect to localhost:*xxxx*, where *xxxx* is the local port you used for your tunnel. In the examples above, we would connect the VNC client to <code>localhost::<i>xxxx</i></code>. (Some VNC clients accept <code>localhost:<i>xxxx</i></code>).

	We recommend the [TigerVNC](http://sourceforge.net/projects/tigervnc) VNC Client, a platform independent client/server application.

	Once the desktop has been established, two initial xterm windows are presented (which may be overlapping). One, which is white-on-black, manages the lifetime of the VNC server process. Killing this window (typically by typing "`exit`" or "`ctrl-D`" at the prompt) will cause the vncserver to terminate and the original batch job to end. Because of this, we recommend that this window not be used for other purposes; it is just too easy to accidentally kill it and terminate the session.

	The other xterm window is black-on-white, and can be used to start both serial programs running on the node hosting the vncserver process, or parallel jobs running across the set of cores associated with the original batch job. Additional xterm windows can be created using the window-manager left-button menu.

### Running Applications on the Remote Desktop

From an interactive desktop, applications can be run from icons or from xterm command prompts. Two special cases arise: running parallel applications, and running applications that use OpenGL.

### Running Parallel Applications from the Desktop

Parallel applications are run on the desktop using the same ibrun wrapper described above (see Running). The command:

<pre class="cmd-line">c301-001$ <b>ibrun <i>ibrunoptions</i> application applicationoptions</b></pre>

will run application on the associated nodes, as modified by the ibrun options.

### Running OpenGL/X Applications On The Desktop

Lonestar6 uses the OpenSWR OpenGL library to perform efficient rendering. At present, the compute nodes on Lonestar6 do not support native X instances. All windowing environments should use a DCV desktop launched via the job script in `/share/doc/slurm/job.dcv`, a VNC desktop launched via the job script in `/share/doc/slurm/job.vnc` or using the TACC Vis portal.

`swr`: To access the accelerated OpenSWR OpenGL library, it is necessary to use the `swr` module to point to the `swr` OpenGL implementation and configure the number of threads to allocate to rendering.

<pre class="cmd-line">
c301-001$ <b>module load swr</b>
c301-001$ <b>swr <i>options</i> application application-args</b></pre>

