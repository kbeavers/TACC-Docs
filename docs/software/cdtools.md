# CDTools at TACC
*Last update: April 1, 2022*

Leveraging each node's `/tmp` directory space can effectively minimize the I/O load on the global Lustre file system and can also improve the performance of I/O work. Due to its limited size, the `/tmp` space is appropriate for executables/binaries, frequently-used object files, and small size common files, e.g. the global configuration files or the initial/pre-processed data files. 

Collect-Distribute (CDTools) has been designed and developed to distribute files or directories to or from the `/tmp` directory. In CDTools, `distribute.bash` can be used to copy/clone the binaries and frequently accessed input files to the local `/tmp` space on each compute node when a job starts, and `collect.bash` can be used to collect output files and log files back to `$WORK` or `$SCRATCH` before a job finishes. 

## [Using CD Tools](#setup) { #setup }

CDTools is currently installed on TACC's Frontera and Stampede2 resources.  

### [1. Initialize CD Tools Environment Variable](#setup-1) { #setup-1 }

To set up CDTools on Frontera or Stampede2 system, initialize these environment variables:

<pre class="cmd-line">
$ <b>export CDTools=/home1/apps/CDTools/1.1  # for Frontera or Stampede2</b>
$ <b>export PATH=${PATH}:${CDTools}/bin</b></pre>

### [2. Distribute Files to Each Node's `/tmp` Space](#setup-2) { #setup-2 }

Distribute your files/directories to the local `/tmp` space of each compute node allotted for your job:

<pre class="cmd-line">$ <b>distribute.bash ${SCRATCH}/inputfile #put the full path of your input file here</b></pre>
or
<pre class="cmd-line">$ <b>distribute.bash ${SCRATCH}/inputdir #put the full path of the directory of your input files here </b></pre>

If you `ssh` to those compute nodes after running the above command, you would find an identical copy of your input file or directory in the `/tmp` directory on each node.

### [3. Collect your Output Files](#setup-3) { #setup-3 }

Once your job completes, collect the job output files from the `/tmp` space of each node:

<pre class="cmd-line">$ <b>collect.bash /tmp/outputdir ${SCRATCH}/output_collected</b></pre>
or                                        
<pre class="cmd-line">$ <b>collect.bash /tmp/outputfile ${SCRATCH}/output_collected</b></pre>

You will obtain a list of output files or directories copied back to your target directories in `$SCRATCH`. These output files or directories have been appended with an underscore and a number that indicates the rank of compute nodes. For example, given a job run on four nodes: files `outputfile_0`, `outputfile_1`, "`outputfile_2` and "`outputfile_3` will all be placed in the "`/output_collected` directory.


## [Notes](#notes) { #notes }

* This tool should work for both batch mode and interactive mode. An example job script can be found in `${CDTools}/test`.
* When using the tool, users should test their workflow with CDTools before any productive runs to make sure required files are successfully distributed and collected.
* Users should still understand and respect the `/tmp` limit and other I/O rules when using it.


