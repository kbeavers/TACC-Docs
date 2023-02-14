# NAMD at TACC
*Last update: November 30, 2021*

	
<img alt="NAMD logo" src="../../imgs/software/namd-logo.jpg" style="width:40%;">
<a href="http://www.ks.uiuc.edu/Research/namd/">NAMD</a> <b>Na</b>noscale <b>M</b>olecular <b>D</b>ynamics program, is a parallel molecular dynamics code designed for high-performance simulation of large biomolecular systems. Based on Charm++ parallel objects, NAMD scales to hundreds of cores for typical simulations and beyond 500,000 cores for the largest simulations. NAMD uses the popular molecular graphics program VMD for simulation setup and trajectory analysis, but is also file-compatible with AMBER, CHARMM, and X-PLOR. NAMD can perform geometry optimization, molecular dynamics simulations, chemical and conformational free energy calculations, enhanced sampling via replica exchange. It also supports Tcl based scripting and steering forces.  

## [Installations](#installations) { #installations }

NAMD is currently installed on TACC's [Frontera][FRONTERAUG], [Stampede2][STAMPEDE2UG], and [Lonestar6][LONESTAR6UG] compute resources.  NAMD is managed under the module system on TACC resources. Read the following instructions carefully. NAMD performance is particularly sensitive to its configuration.  Try running benchmarks with different configurations to find your optimal NAMD set up. You can initiate interactive [`idev`][TACCIDEV] debugging sessions on all systems.

## [Running on Frontera](#running-frontera) { #running-frontera }

The recommended and latest installed NAMD version is 2.14 on Frontera. Users are welcome to install different NAMD versions in their own directories.

<pre class="cmd-line">login1$ module load namd/2.14</pre>

### [Job Scripts: NAMD on Frontera](#running-frontera-jobscript) { #running-frontera-jobscript }

!!! note
	TACC staff recommends that users attempt runs with 4 tasks per node and 8 tasks per node (scales better at large number of nodes) and then pick the configuration that provides the best performance.

4 tasks per node:
<pre class="job-script">
#SBATCH -J test         # Job Name
#SBATCH -o test.o%j
#SBATCH -N 2            # Total number of nodes
#SBATCH -n 8            # Total number of mpi tasks
#SBATCH -p normal       # Queue (partition) name 
#SBATCH -t 24:00:00     # Run time (hh:mm:ss) - 24 hours

module load namd/2.14
ibrun namd2 +ppn 13 \
			+pemap 2-26:2,30-54:2,3-27:2,31-55:2 \
			+commap 0,28,1,29 input &amp;&gt; output</pre>


8 tasks per node:
<pre class="job-script">
#SBATCH -J test         # Job Name
#SBATCH -o test.o%j
#SBATCH -N 12           # Total number of nodes
#SBATCH -n 96           # Total number of mpi tasks
#SBATCH -p normal       # Queue (partition) name -- skx-normal, skx-dev, etc.
#SBATCH -t 24:00:00     # Run time (hh:mm:ss) - 24 hours

module load namd/2.14
ibrun namd2 +ppn 6 \
			+pemap 2-12:2,16-26:2,30-40:2,44-54:2,3-13:2,17-27:2,31-41:2,45-55:2\
			+commap 0,14,28,42,1,15,29,43 input &amp;&gt; output</pre>

For very large simulations, users may want to use compressed structures. See the [NAMD wiki: NamdMemoryReduction](https://www.ks.uiuc.edu/Research/namd/wiki/index.cgi?NamdMemoryReduction) to prepare your compressed input files and set up your input files. In this case use the `namd2_memopt` executable instead of `namd2`: 

compressed input files
<pre class="job-script">ibrun namd2_memopt +ppn 6 \
	 			+pemap 2-12:2,16-26:2,30-40:2,44-54:2,3-13:2,17-27:2,31-41:2,45-55:2 \
	 			+commap 0,14,28,42,1,15,29,43 input &amp;&gt; output</pre>


## [Running on Stampede2](#running-stampede2) { #running-stampede2 }

As of this date, the recommended and latest version is 2.14 . Users are welcome to install different NAMD versions in their own directories. See [Building Third Party Software][STAMPEDE2UGBUILDING] in the Stampede2 User Guide. 

### [Job Script: NAMD on Stampede2's KNL Nodes](#jobscript-stampede2-knl) { #jobscript-stampede2-knl }

!!! tip
	TACC staff recommends assigning 13 tasks per node for NAMD jobs running on Stampede2's KNL compute nodes. 

This job script requests 1 node and 4 MPI tasks: 4 tasks/node. 

<pre class="job-script">
#SBATCH -J test         # Job Name
#SBATCH -o test.o%j
#SBATCH -N 1            # Request 1 node
#SBATCH -n 4            # and 4 MPI tasks
#SBATCH -p normal       # Queue (partition) name -- normal, development, etc.
#SBATCH -t 24:00:00     # Run time (hh:mm:ss) - 24 hours

module load namd/2.14
ibrun namd2_knl +ppn 32 \
				+pemap 0-63+68 \
				+commap 64-67 input &amp;&gt; output</pre>


To run the same job on more than one node, vary the `-N` and `n` `#SBATCH` directives. This job script requests 3 nodes and 39 MPI tasks: 13 tasks/node. 

<pre class="job-script">
#SBATCH -J mynamd       # Set job name
#SBATCH -o mynamd.o%j
#SBATCH -N 3            # Request 3 nodes
#SBATCH -n 39           # Request 39 MPI tasks; 13 tasks per node
#SBATCH -p normal       # Submit to the normal queue
#SBATCH -t 24:00:00     # Set max run time of 24 hours

module load namd/2.14
ibrun namd2_knl +ppn 8 \
				+pemap 0-51+68 \
				+commap 52-67 input &amp;&gt; output</pre>

As well as the Slurm `#SBATCH` directives (`-N` and `-n`), try varying the [affinity](http://www.ks.uiuc.edu/Research/namd/2.12/ug/node89.html) settings to determine the optimal performance of your job. You can try both settings then use the optimal one. If your system is small or the number of nodes are large, you can try:

4 tasks per node:
<pre class="job-script">ibrun namd2_knl +ppn 16 +pemap 0-63 +commap 64-67</pre> 

13 tasks per node:
<pre class="job-script">ibrun namd2_knl +ppn 4 +pemap 0-51 +commap 52-67</pre>

### [Job Script: NAMD on Stampede2's SKX Nodes](#jobscript-stampede2-skx) { #jobscript-stampede2-skx }

!!! tip
	TACC staff recommends assigning 4 tasks per node for jobs running on Stampede2's SKX compute nodes. 

<pre class="job-script">
#SBATCH -J test         # Job Name
#SBATCH -o test.o%j
#SBATCH -N 2            # Total number of nodes
#SBATCH -n 8            # Total number of mpi tasks
#SBATCH -p skx-normal   # Queue (partition) name -- skx-normal, skx-dev, etc.
#SBATCH -t 24:00:00     # Run time (hh:mm:ss) - 24 hours

module load namd/2.14
ibrun namd2_skx +ppn 11 \
				+pemap 2-22:2,26-46:2,3-23:2,27-47:2 \
				+commap 0,24,1,25 input &amp;&gt; output</pre>

You may also try other [affinity](http://www.ks.uiuc.edu/Research/namd/2.14/ug/node88.html) settings as in these examples for varying number of tasks per node.

6 tasks per node:
<pre class="job-script">ibrun namd2_skx +ppn 7 \
				+pemap 2-14:2,18-30:2,34-46:2,3-15:2,19-31:2,35-47:2 \
				+commap 0,16,32,1,17,33 input &amp;&gt; output  </pre>

2 tasks per node:
<pre class="job-script">ibrun namd2_skx +ppn 23 \
				+pemap 2-47:2,3-47:2 \
				+commap 0,1 input &amp;&gt; output</pre>

1 task per node:
<pre class="job-script">ibrun namd2_skx +ppn 47 \
				+pemap 2-47:2,1-47:2 \
				+commap 0 input &amp;&gt; output</pre>


## [Running NAMD on Lonestar6](#running-lonestar6) { #running-lonestar6 }

NAMD ver2.14 is installed on Lonestar6 as this version provides best performance. Feel free to install your own newer version locally. 

<pre class="cmd-line">
login1$ <b>module load namd/2.14</b></pre>

### [Job Script: NAMD on Lonestar6](#running-lonestar6-jobscript) { #running-lonestar6-jobscript }

!!! tip
	TACC staff recommends assigning 4 tasks per node for NAMD jobs running on Lonestar6's compute nodes.

The following Lonestar6 job script requests 2 node and 8 MPI tasks. To run the same job on more nodes, vary the `-N` and `-n` Slurm directives, **ensuring the value of `n` is four times the value of `N`**.  

<pre class="job-script">
#!/bin/bash
#SBATCH -J test   		# Job Name
#SBATCH -o test.o%j
#SBATCH -N 2      		# Total number of nodes
#SBATCH -n 8      		# Total number of mpi tasks
#SBATCH -p normal 		# Queue name
#SBATCH -t 24:00:00 	# Run time (hh:mm:ss) - 24 hours

module load namd/2.14
ibrun namd2 +ppn 31 \
			+pemap 1-31,33-63,65-95,97-127 \
			+commap 0,32,64,96 input &amp;> output</pre>

## [References](#refs) { #refs }

* [NAMD](http://www.ks.uiuc.edu/Research/namd/) website
* [NAMD 2.14 User Guide](http://www.ks.uiuc.edu/Research/namd/2.14/ug/)

{% include 'aliases.md' %}
