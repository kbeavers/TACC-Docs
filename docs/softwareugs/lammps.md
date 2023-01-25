/ Albert Lu, Susan Lindsey
/ https://portal.tacc.utexas.edu/software/lammps
<span style="font-size:225%; font-weight:bold;">LAMMPS at TACC</span><br>
<span style="font-size:90%"><i>Last update: June 1, 2022</i></span>

#top
	:markdown
		<p>LAMMPS is a classical molecular dynamics code developed at Sandia National Laboratories and is available under the GPL license. LAMMPS (**L**arge-scale **A**tomic/**M**olecular **M**assively **P**arallel **S**imulator) makes use of spatial-decomposition techniques to partition the simulation domain and runs in serial or in parallel using MPI.  The code is capable of modeling systems with millions or even billions of particles on a large HPC machine.  A variety of force fields and boundary conditions are provided in LAMMPS which can be used to model atomic, polymeric, biological, metallic, granular, and coarse-grained systems.

#installations
	:markdown
		# [LAMMPS Installations](#installations)

		LAMMPS is installed on the [Stampede2](/user-guides/stampede2), [Lonestar6](/user-guides/lonestar6) and [Frontera](https://frontera-portal.tacc.utexas.edu/user-guide/) systems.

		As of this date, the default versions are 9Jan20 (Stampede2), 20Sep21 (Lonestar6) and 15Apr20 (Frontera). Users are welcome to install different versions of LAMMPS in their own directories (see [Building Third Party Software](/user-guides/stampede2#building-thirdparty) in the Stampede2 User Guide). <!-- Sample build scripts for each system can be found in the "`/work/apps/lammps/shared/`" directory. -->


		<pre class="cmd-line">
		$ <b>module spider lammps</b>		# list installed LAMMPS versions
		$ <b>module load lammps</b>			# load default version</pre>

#running
	:markdown
		# [Running LAMMPS](#running)

		The LAMMPS module defines a set of environment variables for the locations of the LAMMPS home, binaries and more with the prefix "`TACC_LAMMPS`". Use the "`env`" command to display the variables:

		<pre class="cmd-line">$ <b>env | grep "TACC_LAMMPS"</b></pre>

		Note that each installation's executable name differs. The name of the executable is in the format of "`lmp_machine`", where "`machine`" can be either "`stampede`", "`lonestar`", or "`frontera`" depending on the system. The Stampede2 versions 9Jan20 and 16Mar18, use "`lmp_knl`" and must be submitted to the Stampede2's KNL (not SKX) queues. The LAMMPS GPU executables, "`lmp_gpu`", can only be submitted to Frontera's GPU queues.


%table(border="1" cellpadding="3" cellspacing="3")
	%tr
		%td
		%th Frontera
		%th Stampede2
		%th Lonestar6
	%tr
		%th(rowspan="2") Executable
		%td <code>lmp_frontera </code>
		%td <code>lmp_stampede </code>
		%td <code>lmp_lonestar </code>
	%tr
		%td <code>lmp_gpu</code>
		%td <code>lmp_knl</code>
		%td N/A


#running-batch
	:markdown
		## [Running LAMMPS in Batch Mode](#running-batch)

		LAMMPS uses spatial-decomposition techniques to partition the simulation domain into small 3d sub-domains, one of which is assigned to each processor. You will need to set suitable values of "`-N`" (number of nodes), "`-n`" (total number of MPI tasks), and `OMP_NUM_THREADS` (number of threads to use in parallel regions) to optimize the performance of your simulation.

#running-batch-jobscript
	:markdown
		### [Sample Job Script: LAMMPS on Stampede2](#running-batch-jobscript)

		Refer to Stampede2's [Running Jobs](/user-guides/stampede2#running-sbatch) section for more Slurm options. To configure this script for Lonestar6 and Frontera, vary the "`-p`", "`-N`" and "`-n`" directives.

		<pre class="job-script">
		#!/bin/bash
		#SBATCH -J test                    # Job Name
		#SBATCH -A <i>myProject</i>               # Your project name 
		#SBATCH -o test.o%j                # Output file name (%j expands to jobID)
		#SBATCH -e test.e%j                # Error file name (%j expands to jobID)
		#SBATCH -N 1                       # Requesting 1 node
		#SBATCH -n 16                      # and 16 tasks
		#SBATCH -p normal                  # Queue name (normal, skx-normal, etc.)
		#SBATCH -t 24:00:00                # Specify 24 hour run time

		module load   intel/18.0.2
		module load   impi/18.0.2
		module load   lammps/9Jan20

		export OMP_NUM_THREADS=1   

		ibrun lmp_knl -in lammps_input </pre>

#running-batch-examples
	:markdown
		### [Example command-line invocations:](#running-batch-examples)

		* LAMMPS with [USER-OMP](https://lammps.sandia.gov/doc/Packages_details.html#pkg-user-omp) package (e.g. using 2 threads)

			<pre class="job-script">ibrun lmp_stampede -sf omp -pk omp 2 -in lammps_input</pre>

		* LAMMPS with [USER-INTEL](https://lammps.sandia.gov/doc/Speed_intel.html) package (e.g. using 2 threads)

			<pre class="job-script">ibrun lmp_stampede -sf intel -pk intel 0 omp 2 -in lammps_input</pre>

		* LAMMPS with GPU package (Frontera 15Apr20 only)

			The GPU `lammps` executable is "`lmp_gpu`".  On Frontera GPU nodes, you could set "`-pk gpu 4`" to utilize all four RTX GPUs available on each node. Set the "`-n`" directive to a value &gt; 1 to let more than one MPI task share one GPU.

			<pre class="job-script">	
			#SBATCH -N 1                      # Requesting 1 node
			#SBATCH -n 16                     # and 16 tasks that share 4 GPU
			#SBATCH -p rtx                    # Frontera rtx queue

			# Use all 4 GPUs
			ibrun lmp_gpu -sf gpu -pk gpu 4 -in lammps_input </pre>

#running-interactive
	:markdown
		## [Running LAMMPS within `idev`](#running-interactive)

		You can also run LAMMPS within an [`idev`](/software/idev) session as demonstrated below:

		<pre class="cmd-line">
		login1$ <b>idev</b>
		...
		c123-456$ <b>module load lammps </b>
		c123-456$ <b>lmp_stampede &lt; lammps_input</b></pre>

		Use the "`-h`" option to print out a list of all supported functions and packages: 

		<pre class="cmd-line">c123-456$ <b>lmp_stampede -h</b></pre>

#refs
	:markdown
		# [References](#refs)

		* [LAMMPS Documentation](https://docs.lammps.org/Manual.html)
		* [LAMMPS Installation Guide](https://docs.lammps.org/Build.html)
		* [TACC Software page](http://portal.tacc.utexas.edu/software)
		

