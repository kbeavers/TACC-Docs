# LAMMPS at TACC
*Last update: June 1, 2022*

LAMMPS is a classical molecular dynamics code developed at Sandia National Laboratories and is available under the GPL license. LAMMPS (**L**arge-scale **A**tomic/**M**olecular **M**assively **P**arallel **S**imulator) makes use of spatial-decomposition techniques to partition the simulation domain and runs in serial or in parallel using MPI.  The code is capable of modeling systems with millions or even billions of particles on a large HPC machine.  A variety of force fields and boundary conditions are provided in LAMMPS which can be used to model atomic, polymeric, biological, metallic, granular, and coarse-grained systems.

## [LAMMPS Installations](#installations) { #installations } 

LAMMPS is installed on the [Stampede2][STAMPEDE2UG], [Lonestar6][LONESTAR6UG] and [Frontera][FRONTERAUG] systems.

As of this date, the default versions are 9Jan20 (Stampede2), 20Sep21 (Lonestar6) and 15Apr20 (Frontera). Users are welcome to install different versions of LAMMPS in their own directories (see [Building Third Party Software][STAMPEDE2UGBUILDING] in the Stampede2 User Guide). <!-- Sample build scripts for each system can be found in the `/work/apps/lammps/shared/` directory. -->

<pre class="cmd-line">
$ <b>module spider lammps</b>		# list installed LAMMPS versions
$ <b>module load lammps</b>			# load default version</pre>

The LAMMPS module defines a set of environment variables for the locations of the LAMMPS home, binaries and more with the prefix `TACC_LAMMPS`. Use the `env` command to display the variables:

<pre class="cmd-line">$ <b>env | grep "TACC_LAMMPS"</b></pre>

Note that each installation's executable name differs. The name of the executable is in the format of `lmp_machine`, where `machine` can be either `stampede`, `lonestar`, or `frontera` depending on the system. The Stampede2 versions 9Jan20 and 16Mar18, use `lmp_knl` and must be submitted to the Stampede2's KNL (not SKX) queues. The LAMMPS GPU executables, `lmp_gpu`, can only be submitted to Frontera's GPU queues.


Frontera | Stampede2 | Lonestar6
--- | --- | ---
<code>lmp_frontera </code> | <code>lmp_stampede </code> | <code>lmp_lonestar </code>
<code>lmp_gpu</code> | <code>lmp_knl</code> | N/A


## [Running LAMMPS in Batch Mode](#running-batch) { #running-batch } 

LAMMPS uses spatial-decomposition techniques to partition the simulation domain into small 3d sub-domains, one of which is assigned to each processor. You will need to set suitable values of `-N` (number of nodes), `-n` (total number of MPI tasks), and `OMP_NUM_THREADS` (number of threads to use in parallel regions) to optimize the performance of your simulation.

### [Sample Job Script: LAMMPS on Stampede2](#running-batch-jobscript) { #running-batch-jobscript } 

Refer to Stampede2's [Running Jobs][STAMPEDE2UGRUNNING] section for more Slurm options. To configure this script for Lonestar6 and Frontera, vary the `-p`, `-N` and `-n` directives.

<pre class="job-script">
&#x23!/bin/bash
&#x23#SBATCH -J test                    # Job Name
&#x23#SBATCH -A <i>myProject</i>               # Your project name 
&#x23#SBATCH -o test.o%j                # Output file name (%j expands to jobID)
&#x23#SBATCH -e test.e%j                # Error file name (%j expands to jobID)
&#x23#SBATCH -N 1                       # Requesting 1 node
&#x23#SBATCH -n 16                      # and 16 tasks
&#x23#SBATCH -p normal                  # Queue name (normal, skx-normal, etc.)
&#x23#SBATCH -t 24:00:00                # Specify 24 hour run time

module load   intel/18.0.2
module load   impi/18.0.2
module load   lammps/9Jan20

export OMP_NUM_THREADS=1   

ibrun lmp_knl -in lammps_input </pre>

## [Example command-line invocations:](#running-batch-examples) { #running-batch-examples } 

* LAMMPS with [USER-OMP](https://lammps.sandia.gov/doc/Packages_details.html#pkg-user-omp) package (e.g. using 2 threads)

	<pre class="job-script">ibrun lmp_stampede -sf omp -pk omp 2 -in lammps_input</pre>

* LAMMPS with [USER-INTEL](https://lammps.sandia.gov/doc/Speed_intel.html) package (e.g. using 2 threads)

	<pre class="job-script">ibrun lmp_stampede -sf intel -pk intel 0 omp 2 -in lammps_input</pre>

* LAMMPS with GPU package (Frontera 15Apr20 only)

	The GPU `lammps` executable is `lmp_gpu`.  On Frontera GPU nodes, you could set `-pk gpu 4` to utilize all four RTX GPUs available on each node. Set the `-n` directive to a value &gt; 1 to let more than one MPI task share one GPU.

	<pre class="job-script">
	&#x23SBATCH -N 1                      # Requesting 1 node
	&#x23SBATCH -n 16                     # and 16 tasks that share 4 GPU
	&#x23SBATCH -p rtx                    # Frontera rtx queue

	&#x23 Use all 4 GPUs
	ibrun lmp_gpu -sf gpu -pk gpu 4 -in lammps_input</pre>

## [Running LAMMPS within `idev`](#running-interactive) { #running-interactive } 

You can also run LAMMPS within an [`idev`][TACCIDEV] session as demonstrated below:

<pre class="cmd-line">
login1$ <b>idev</b>
...
c123-456$ <b>module load lammps </b>
c123-456$ <b>lmp_stampede &lt; lammps_input</b></pre>

Use the `-h` option to print out a list of all supported functions and packages: 

<pre class="cmd-line">c123-456$ <b>lmp_stampede -h</b></pre>

## [References](#refs) { #refs } 

* [LAMMPS Documentation](https://docs.lammps.org/Manual.html)
* [LAMMPS Installation Guide](https://docs.lammps.org/Build.html)

{% include 'aliases.md' %}
