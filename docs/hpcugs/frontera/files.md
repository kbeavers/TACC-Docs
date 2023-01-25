## [Managing Files on Frontera](#files)

<p class="introtext">Frontera mounts three Lustre file systems that are shared across all nodes: the home, work, and scratch file systems. Frontera also contains a fourth file system, <code>FLASH</code>, supporting applications with very high bandwidth or IOPS requirements.</p>


### [File Systems](#files-filesystems)

Frontera's startup mechanisms define corresponding account-level environment variables <code>$HOME</code>, <code>$SCRATCH</code> and <code>$WORK</code><!--,and <code>$FASTIO</code>--> that store the paths to directories that you own on each of these file systems. Consult the <a href="#table-2-frontera-file-systems">Frontera File Systems</a> table below for the basic characteristics of these file systems, <!--"File Operations: I/O Performance" for advice on performance issues,--> and the <a href="../conduct">Good Conduct</a> sections for guidance on file system etiquette.</p>

#### [Table 2. Frontera File Systems](#table2)

File System | Quota | Key Features
-------     | ------- | -------
`$HOME`	    | 25GB, 400,000 files          | **Not intended for parallel or high-intensity file operations**.<br>Backed up regularly.<br>Defaults: 1 stripe, 1MB stripe size.<br> Not purged. |
`$WORK`	    | 1TB, 3,000,000 files across all TACC systems,<br>regardless of where on the file system the files reside. | **Not intended for high-intensity file operations or jobs involving very large files.**<br>On the Global Shared File System that is mounted on most TACC systems.<br>Defaults: 1 stripe, 1MB stripe size.<br>Not backed up.<br> Not purged.
`$SCRATCH`  | no quota	 |  Overall capacity 44 PB.<br>Defaults: 1 stripe, 1MB stripe size.<br>Not backed up.<br>Decomposed into three separate file systems, `scratch1`, `scratch2`, and `scratch3` described below.<br>**Files are [subject to purge](#scratch-purge-policy) if access time&#42; is more than 10 days old**.  

All new projects are assigned to `/scratch1` as their default `$SCRATCH` file system.  After running on Frontera, TACC staff may reassign users and projects to `/scratch2` or `/scratch3` depending on the resources required by their workflow.  The `/scratch3` file system employs twice as many OST's offering twice the available I/O bandwidth of `/scratch1` and `/scratch2`.  Frontera's three `$SCRATCH` file systems are further described below:

#### [Table 2a. Scratch File Systems](#table2a)

File System | Characteristics	| Purpose |
---         | ---               | ---     |
`/scratch1` | Size:	 10.6 PB <br>OSTs:	16 <br>Bandwidth: 60 GB/s  | Default scratch file system.
`/scratch2` | Size:	 10.6 PB <br>OSTs:	16 <br>Bandwidth: 60 GB/s  | Designated for workflows with intensive I/O operations.
`/scratch3` | Size:	 21.2 PB <br>OSTs:	32 <br>Bandwidth: 120 GB/s | Designated for workflows with large scale parallel I/O operations.

### [Scratch Purge Policy](#scratchpurgepolicy)

<p class="portlet-msg-info">The <code>$SCRATCH</code> file system, as its name indicates, is a temporary storage space.  Files that have not been accessed&#42; in ten days are subject to purge.  Deliberately modifying file access time (using any method, tool, or program) for the purpose of circumventing purge policies is prohibited.</p>

&#42;The operating system updates a file's access time when that file is modified on a login or compute node or any time that file is read. Reading or executing a file/script will update the access time.  Use the <span style="white-space: nowrap;">"`ls -ul`"</span> command to view access times.



### [Navigating the Shared File Systems](#files-navigating)

Frontera's `/home` and `/scratch` file systems are mounted only on Frontera, but the work file system mounted on Frontera is the Global Shared File System hosted on [Stockyard](https://www.tacc.utexas.edu/systems/stockyard). Stockyard is the same work file system that is currently available on Stampede2, Lonestar5, and several other TACC resources. 

The `$STOCKYARD` environment variable points to the highest-level directory that you own on the Global Shared File System. The definition of the `$STOCKYARD` environment variable is of course account-specific, but you will see the same value on all TACC systems that provide access to the Global Shared File System. This directory is an excellent place to store files you want to access regularly from multiple TACC resources.

Your account-specific `$WORK` environment variable varies from system to system and is a sub-directory of `$STOCKYARD` ([Figure 3](#figure-3-stockyard-file-system)). The sub-directory name corresponds to the associated TACC resource. The `$WORK` environment variable on Frontera points to the `$STOCKYARD/stampede2` subdirectory, a convenient location for files you use and jobs you run on Frontera. Remember, however, that all subdirectories contained in your `$STOCKYARD` directory are available to you from any system that mounts the file system. If you have accounts on both Frontera and Stampede2, for example, the `$STOCKYARD/frontera` directory is available from your Stampede2 account, and `$STOCKYARD/stampede2` is available from your Frontera account. 

<p class="portlet-msg-alert">Your quota and reported usage on the Global Shared File System reflects all files that you own on Stockyard, regardless of their actual location on the file system.</p>

See the example for fictitious user `bjones` in the figure below. All directories are accessible from all systems, however a given sub-directory (e.g. `lonestar5`, `stampede2`) will exist **only** if you have an allocation on that system.

#### [Figure 3. Stockyard File System](#figure3)
<img alt="Stockyard File System" src="IMAGEDIR/stockyard-2022.jpg"> 

**Figure 3.** Account-level directories on the work file system (Global Shared File System hosted on Stockyard). Example for fictitious user `bjones`. All directories usable from all systems. Sub-directories (e.g. `lonestar5`, `stampede2`) exist only if you have allocations on the associated system.

Note that resource-specific subdirectories of `$STOCKYARD` are simply convenient ways to manage your resource-specific files. You have access to any such subdirectory from any TACC resources. If you are logged into Frontera, for example, executing the alias `cdw` (equivalent to <span style="white-space: nowrap;">`cd $WORK`</span>) will take you to the resource-specific subdirectory `$STOCKYARD/frontera`. But you can access this directory from other TACC systems as well by executing <span style="white-space: nowrap;">`cd $STOCKYARD/frontera`</span>. These commands allow you to share files across TACC systems. In fact, several convenient account-level aliases make it even easier to navigate across the directories you own in the shared file systems:

#### [Table 3. Built-in Account Level Aliases](#table3)

Alias | Command
---- | ----
<code>cd</code> or <code>cdh</code> | <code>cd $HOME</code>
<code>cdw</code> | <code>cd $WORK</code>
<code>cds</code> | <code>cd $SCRATCH</code>
<code>cdy</code> or <code>cdg</code> | <code>cd $STOCKYARD</code>


<p> &nbsp;</p> 

### [Striping Large Files](#files-striping)

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

