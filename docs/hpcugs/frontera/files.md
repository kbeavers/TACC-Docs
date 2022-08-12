# Managing Files on Frontera

<p class="introtext">Frontera mounts three Lustre file systems that are shared across all nodes: the home, work, and scratch file systems. Frontera also contains a fourth file system, <code>FLASH</code>, supporting applications with very high bandwidth or IOPS requirements.</p>


## File Systems 

Frontera's startup mechanisms define corresponding account-level environment variables <code>$HOME</code>, <code>$SCRATCH</code> and <code>$WORK</code><!--,and <code>$FASTIO</code>--> that store the paths to directories that you own on each of these file systems. Consult the <a href="#table-2-frontera-file-systems">Frontera File Systems</a> table below for the basic characteristics of these file systems, <!--"File Operations: I/O Performance" for advice on performance issues,--> and the <a href="../citizenship">Good Citizenship</a> sections for guidance on file system etiquette.</p>

### Table 2. Frontera File Systems

File System | Quota | Key Features
-------     | ------- | -------
`$HOME`	    | 25GB, 400,000 files          | **Not intended for parallel or high-intensity file operations**.<br>Backed up regularly.<br>Defaults: 1 stripe, 1MB stripe size.<br> Not purged. |
`$WORK`	    | 1TB, 3,000,000 files across all TACC systems,<br>regardless of where on the file system the files reside. | **Not intended for high-intensity file operations or jobs involving very large files.**<br>On the Global Shared File System that is mounted on most TACC systems.<br>Defaults: 1 stripe, 1MB stripe size.<br>Not backed up.<br> Not purged.
`$SCRATCH`  | no quota	 |  Overall capacity 44 PB.<br>Defaults: 1 stripe, 1MB stripe size.<br>Not backed up.<br>Decomposed into three separate file systems, `scratch1`, `scratch2`, and `scratch3` described below.<br>**Files are [subject to purge](#scratch-purge-policy) if access time&#42; is more than 10 days old**.  

All new projects are assigned to `/scratch1` as their default `$SCRATCH` file system.  After running on Frontera, TACC staff may reassign users and projects to `/scratch2` or `/scratch3` depending on the resources required by their workflow.  The `/scratch3` file system employs twice as many OST's offering twice the available I/O bandwidth of `/scratch1` and `/scratch2`.  Frontera's three `$SCRATCH` file systems are further described below:

### Table 2a. Scratch File Systems

File System | Characteristics	| Purpose |
---         | ---               | ---     |
`/scratch1` | Size:	 10.6 PB <br>OSTs:	16 <br>Bandwidth: 60 GB/s  | Default scratch file system.
`/scratch2` | Size:	 10.6 PB <br>OSTs:	16 <br>Bandwidth: 60 GB/s  | Designated for workflows with intensive I/O operations.
`/scratch3` | Size:	 21.2 PB <br>OSTs:	32 <br>Bandwidth: 120 GB/s | Designated for workflows with large scale parallel I/O operations.

## Scratch Purge Policy

<p class="portlet-msg-info">The <code>$SCRATCH</code> file system, as its name indicates, is a temporary storage space.  Files that have not been accessed&#42; in ten days are subject to purge.  Deliberately modifying file access time (using any method, tool, or program) for the purpose of circumventing purge policies is prohibited.</p>

&#42;The operating system updates a file's access time when that file is modified on a login or compute node or any time that file is read. Reading or executing a file/script will update the access time.  Use the <span style="white-space: nowrap;">"`ls -ul`"</span> command to view access times.



## Navigating the Shared File Systems

Frontera's `/home` and `/scratch` file systems are mounted only on Frontera, but the work file system mounted on Frontera is the Global Shared File System hosted on [Stockyard](https://www.tacc.utexas.edu/systems/stockyard). Stockyard is the same work file system that is currently available on Stampede2, Lonestar5, and several other TACC resources. 

The `$STOCKYARD` environment variable points to the highest-level directory that you own on the Global Shared File System. The definition of the `$STOCKYARD` environment variable is of course account-specific, but you will see the same value on all TACC systems that provide access to the Global Shared File System. This directory is an excellent place to store files you want to access regularly from multiple TACC resources.

Your account-specific `$WORK` environment variable varies from system to system and is a sub-directory of `$STOCKYARD` ([Figure 3](#figure-3-stockyard-file-system)). The sub-directory name corresponds to the associated TACC resource. The `$WORK` environment variable on Frontera points to the `$STOCKYARD/stampede2` subdirectory, a convenient location for files you use and jobs you run on Frontera. Remember, however, that all subdirectories contained in your `$STOCKYARD` directory are available to you from any system that mounts the file system. If you have accounts on both Frontera and Stampede2, for example, the `$STOCKYARD/frontera` directory is available from your Stampede2 account, and `$STOCKYARD/stampede2` is available from your Frontera account. 

<p class="portlet-msg-alert">Your quota and reported usage on the Global Shared File System reflects all files that you own on Stockyard, regardless of their actual location on the file system.</p>

See the example for fictitious user `bjones` in the figure below. All directories are accessible from all systems, however a given sub-directory (e.g. `lonestar5`, `stampede2`) will exist **only** if you have an allocation on that system.

### Figure 3. Stockyard File System
![Stockyard File System](img/Stockyard2022.jpg)  

**Figure 3.** Account-level directories on the work file system (Global Shared File System hosted on Stockyard). Example for fictitious user `bjones`. All directories usable from all systems. Sub-directories (e.g. `lonestar5`, `stampede2`) exist only if you have allocations on the associated system.

Note that resource-specific subdirectories of `$STOCKYARD` are simply convenient ways to manage your resource-specific files. You have access to any such subdirectory from any TACC resources. If you are logged into Frontera, for example, executing the alias `cdw` (equivalent to <span style="white-space: nowrap;">`cd $WORK`</span>) will take you to the resource-specific subdirectory `$STOCKYARD/frontera`. But you can access this directory from other TACC systems as well by executing <span style="white-space: nowrap;">`cd $STOCKYARD/frontera`</span>. These commands allow you to share files across TACC systems. In fact, several convenient account-level aliases make it even easier to navigate across the directories you own in the shared file systems:

### Table 3. Built-in Account Level Aliases

Alias | Command
---- | ----
<code>cd</code> or <code>cdh</code> | <code>cd $HOME</code>
<code>cdw</code> | <code>cd $WORK</code>
<code>cds</code> | <code>cd $SCRATCH</code>
<code>cdy</code> or <code>cdg</code> | <code>cd $STOCKYARD</code>


<p> &nbsp;</p> 

## Striping Large Files

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

## Transferring your Files

### Transferring Files with Globus

Frontera has two Globus endpoints. One endpoint uses XSede myproxy authentication and the other uses CILogon myproxy authentication. See [Using Globus at TACC](http://portal.tacc.utexas.edu/tutorials/globus) for detailed information. 

### Transferring Files with `scp`

You can transfer files between Frontera and Linux-based systems using either [`scp`](http://linux.com/learn/intro-to-linux/2017/2/how-securely-transfer-files-between-servers-scp) or [`rsync`](http://linux.com/learn/get-know-rsync). Both `scp` and `rsync` are available in the Mac Terminal app. Windows SSH clients typically include `scp`-based file transfer capabilities.

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

### Transferring Files with `rsync`

The `rsync` (remote synchronization) utility is a great way to synchronize files that you maintain on more than one system: when you transfer files using `rsync`, the utility copies only the changed portions of individual files. As a result, `rsync` is especially efficient when you only need to update a small fraction of a large dataset. The basic syntax is similar to `scp`:

<pre class="cmd-line">
localhost$ <b>rsync       mybigfile bjones@frontera.tacc.utexas.edu:\$WORK/data</b>
localhost$ <b>rsync -avtr mybigdir  bjones@frontera.tacc.utexas.edu:\$WORK/data</b></pre>

The options on the second transfer are typical and appropriate when synching a directory: this is a <span style="white-space: nowrap;">recursive update (`-r`)</span> with verbose (`-v`) feedback; the synchronization preserves <span style="white-space: nowrap;">time stamps (`-t`)</span> as well as symbolic links and other meta-data (`-a`). Because `rsync` only transfers changes, recursive updates with `rsync` may be less demanding than an equivalent recursive transfer with `scp`.

See [Good Citizenship](../citizenship) for additional important advice about striping the receiving directory when transferring large files; watching your quota on `$HOME` and `$WORK`; and limiting the number of simultaneous transfers. Remember also that `$STOCKYARD` (and your `$WORK` directory on each TACC resource) is available from several other TACC systems: there's no need for `scp` when both the source and destination involve subdirectories of `$STOCKYARD`. 

## Sharing Files with Collaborators

If you wish to share files and data with collaborators in your project, see [Sharing Project Files on TACC Systems](http://portal.tacc.utexas.edu/tutorials/sharing-project-files) for step-by-step instructions. Project managers or delegates can use Unix group permissions and commands to create read-only or read-write shared workspaces that function as data repositories and provide a common work area to all project members.

