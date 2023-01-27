/ http://portal.tacc.utexas.edu/software/launcher
<p><span style="font-size:225%; font-weight:bold;">Launcher/Launcher-GPU at TACC</span><br>
<span style="font-size:90%"><i>Last update: June 23, 2021</i></span></p>

#intro
	:markdown
		# [Introduction](#intro)

		Launcher is a framework for running large collections of serial or multithreaded applications known as High Throughput Computing (HTC), as a single multinode parallel job on batch-scheduled High Performance Computing (HPC) systems. Launcher can be used to perform simple, data parallel, high throughput computing (HTC) workflows on clusters, massively parallel processor (MPP) systems, workgroups of computers, and personal machines.  

		With Launcher and Launcher GPU, users can create their own miniature high-throughput subsystem inside one parallel job with one or multinodes. Along with the standard Slurm job script, a user creates a Launcher/Launcher-GPU file containing a sequential list of the command lines as individual jobs. The cores designated to run the jobs will take on the tasks until all listed jobs are complete. This request-based method helps reduce the unnecessary overhead for job management and improve the overall performance for large-scale runs. Launcher also helps users perform process binding on multicore architectures automatically for better performance.

#launcher
	:markdown
		# [Launcher](#launcher)

#launcher-serial
	:markdown
		## [Serial Jobs](#launcher-serial)

		Users can submit a Launcher job by creating a SLURM job script, in this example, "`runserial.bash`". 

#launcher-serial-jobscript
	:markdown
		### [Sample Job Script](#launcher-serial-jobscript)

		<pre class="job-script">
		#!/bin/bash
		#SBATCH -J launcher-test            # job name
		#SBATCH -o launcher.o%j             # output and error file name (%j expands to SLURM jobID)
		#SBATCH -N 1                        # number of nodes requested
		#SBATCH -n 32                       # total number of tasks to run in parallel
		#SBATCH -p development              # queue (partition) 
		#SBATCH -t 00:30:00                 # run time (hh:mm:ss) 
		#SBATCH -A P-12345                  # Allocation name to charge job against

		module load launcher

		export LAUNCHER_WORKDIR=/scratch/01234/joe/tests
		export LAUNCHER_JOB_FILE=helloworld 

		${LAUNCHER_DIR}/paramrun</pre>

		Then submit the job script:

		<pre class="cmd-line">login1$ <b>sbatch runserial.bash</b></pre>

		This job will run 32 tasks in parallel (`-n 32`) on 1 compute node (`-N 1`).  

		Sometimes, users may want to use more tasks than what a single node can provide.  Take 60 tasks as an example. Since there are only 48 cores on one SKX node on Stampede2, `-N` must be 2 or larger. 

		Users may also want to use fewer cores than what can be provided on each node due to memory concern. In that case, users just need to increase the number of nodes (`-N`) as needed while the total tasks running in parallel (`-n`) remains the same. For example, `-n 32` and `-N 4` means 32 tasks running simultaneously on 4 nodes, that is, 8 tasks will run on each node. 

#jobfiles-serial-jobfiles
	:markdown
		### [Sample Job Files](#jobfiles-serial-jobfiles)

		Prepare a Launcher job file that contains all the serial jobs you plan to run simultaneously. In the simple example of `helloworld`, each command line is a serial job, and the same job will run 5 times.

		<pre class="file">
		echo "Hello, World!"
		echo "Hello, World!"
		echo "Hello, World!"
		echo "Hello, World!"
		echo "Hello, World!"</pre>

		Users can connect several command lines into one job using Unix's "`&&`" or "`;`" operators. For example,

		<pre class="file">
		hostname && date && echo "Hello, World!" 
		hostname && date && echo "Hello, World!" 
		hostname && date && echo "Hello, World!" 
		hostname && date && echo "Hello, World!" 
		hostname && date && echo "Hello, World!"</pre>

		Two useful parameters of Launcher are `$LAUNCHER_JID` and `$LAUNCHER_TSK_ID`. `$LAUNCHER_JID` is the rank of the jobs listed in the job file. `$LAUNCHER_TSK_ID` is the rank of the tasks (`-n`) running simultaneously. These two parameters will help users identify their jobs from results and where the jobs were running.  For example, users can incorporate them into their command lines:

		<pre class="file">
		echo "Hello, World! from job $LAUNCHER_JID running on task $LAUNCHER_TSK_ID" >> output-$LAUNCHER_TSK_ID
		echo "Hello, World! from job $LAUNCHER_JID running on task $LAUNCHER_TSK_ID" >> output-$LAUNCHER_TSK_ID
		echo "Hello, World! from job $LAUNCHER_JID running on task $LAUNCHER_TSK_ID" >> output-$LAUNCHER_TSK_ID
		echo "Hello, World! from job $LAUNCHER_JID running on task $LAUNCHER_TSK_ID" >> output-$LAUNCHER_TSK_ID
		echo "Hello, World! from job $LAUNCHER_JID running on task $LAUNCHER_TSK_ID" >> output-$LAUNCHER_TSK_ID</pre>


#multithreaded
	:markdown
		## [Multithreaded Jobs](#multithreaded)

		Users can also use Launcher to submit multithreaded jobs in parallel, such as OpenMP jobs. A Launcher job script for running several OpenMP jobs is shown below.

#launcher-multithreaded-jobscript
	:markdown
		### [Sample Job Script](#launcher-multithreaded-jobscript)

		<pre class="job-script">
		#!/bin/bash
		#SBATCH -J launcher-test            # job name
		#SBATCH -o launcher.o%j             # output and error file name (%j expands to jobID)
		#SBATCH -N 2                        # number of nodes requested
		#SBATCH -n 16                       # total number of tasks to run in parallel
		#SBATCH -p development              # queue (partition) 
		#SBATCH -t 00:30:00                 # run time (hh:mm:ss) 
		#SBATCH -A A-ccsc                   # Allocation name to charge job against
		
		module load launcher

		export OMP_NUM_THREADS=6

		export LAUNCHER_WORKDIR=/scratch1/01234/joe/tests
		export LAUNCHER_JOB_FILE=hello_openmp 

		${LAUNCHER_DIR}/paramrun</pre>

#launcher-multithreaded-jobfile
	:markdown
		### [Sample Job File](#launcher-multithreaded-jobscript)

		"`hello_openmp`" is the job file that contains all the OpenMP jobs you plan to run simultaneously. 

		<pre class="file">
		./openMP1.exe
		./openMP2.exe
		./openMP3.exe
		./openMP4.exe
		./openMP5.exe
		./openMP6.exe</pre>

		In this example, users can use Launcher to run 16 tasks in parallel (`-n 16`) on 2 nodes (`-N 2`), that is, 16 tasks/2 nodes= 8 tasks per node. For each single OpenMP run, `$OMP_NUM_THREADS` sets the maximum number of threads to be 6.

		Therefore, the total core number required for the entire job is 16 tasks * 6 core/task = 96 cores.  96 cores/2 nodes=48 cores will be used per node. When specifying the parameters, users need to make sure that the number of cores required on each node does not exceed the maximal number of cores existed on the node (for example, 48 cores per SKX node). 

		See more Launcher examples in `${TACC_LAUNCHER_DIR}/extras/examples`. 

#launchergpu
	:markdown
		# [Launcher GPU](#launchergpu)

		Launcher-GPU is a newly developed tool based on Launcher, which supports running a huge collection of GPU jobs with GPUs on one or multiple compute nodes. The current version of Launcher-GPU works for Nvidia GPU resources. Users only need to list a desired number of their command lines as individual GPU jobs in the Launcher job file. The GPUs designated to run the jobs will take on the tasks until all listed jobs are complete.  

	#launchergpu-jobscript
		:markdown
			## [Sample Job Script](#launchergpu-jobscript)

			Users can submit a Launcher-GPU job by creating a SLURM job script, for example, "`rungpu.bash`". 

			<pre class="job-script">
			#!/bin/bash
			#SBATCH -J launchergpu           	# job name
			#SBATCH -o launchergpu.o%j       	# output and error file name (%j expands to jobID)
			#SBATCH -N 4               		    # number of nodes requested
			#SBATCH -n 16              		    # total number of tasks to run in parallel
			#SBATCH -p rtx    			        # queue (partition) 
			#SBATCH -t 02:30:00        		    # run time (hh:mm:ss) 
			#SBATCH -A P-12345		            # Allocation name to charge job against

			module load launcher_gpu
			export LAUNCHER_WORKDIR=/scratch1/01234/joe/tests 
			export LAUNCHER_JOB_FILE= helloworld-gpu

			${LAUNCHER_DIR}/paramrun</pre>

			Then submit the job script:
			<pre class="cmd-line">login1$ <b>sbatch rungpu.bash</b></pre>

			This job will run 16 tasks in parallel ("`-n 16`") on 4 GPU nodes ("`-N 4`").  

			When assigning the value of "`N`" and "`n`", note that `n/N` must equal the number of GPUs available per node on the resource. In the above example, `n/N` is 16/4 = 4 GPUs/node, which corresponds to the 4 RTX GPUs on each GPU node of the Frontera system.   

	#launchergpu-jobfile
		:markdown
			## [Sample Job File](#launchergpu-jobfile)

			Prepare a Launcher-GPU job file that lists all the jobs you plan to run on the GPU nodes simultaneously. In the simple example of `helloworld-gpu`, each command line runs with a dedicated GPU, and the similar jobs will run 10 times.

			<u>Job file: `hello_openmp`</u>
			<pre class="file">
			./ProgGPU1
			./ProgGPU2
			./ProgGPU3
			...
			./ProgGPU9
			./ProgGPU10</pre>

#notes
	:markdown
		# [Notes](#notes)

		* Do not use Launcher to run Matlab, ANSYS, or Mathematica jobs in parallel. Instead use each package's native mechanisms to run parallel jobs.
		* Launcher does not support MPI jobs. <!-- Please use PyLauncher for bundling MPI jobs.--> 
		* Pay attention to the memory usage and I/O operations, as running a set of jobs with Launcher can easily use extensive memory and [generate heavy I/O workload](/tutorials/managingio). Generating heavy I/O workload may also cause a temporary account suspension.
		
#refs
	:markdown
		# [References](#refs)

		* [Launcher: Large-Scale HTC ON HPC Systems](https://www.tacc.utexas.edu/research-development/tacc-software/the-launcher)
		* [Github:TACC/Launcher](https://github.com/TACC/launcher)
		* [Cornell Virtual Workshop: TACC Launcher](https://cvw.cac.cornell.edu/slurm/runtime_notmpi_launcher)
		* [TACC Software page](https://www.tacc.utexas.edu/systems/software)
		* [Managing I/O at TACC](https://portal.tacc.utexas.edu/tutorials/managingio)


/ From ticket: https://consult.tacc.utexas.edu/Ticket/Display.html?id=59363
/ You should request a -n number that matches the number of lines in your jobfile. So in this example you gave me 8 lines so you would want to request:

/ -N 1
/ -n 8

/ This would allow all the tasks to run simultaneously. You should also change -N to make sure you have enough cores to handle whatever -n you have requested. So if your job file has 120 lines you would want to do:
/ -N 2
/ -n 120

/ -N 1 and -n 1 are used for serial jobs because you only want the one core assigned to the task. However, because launcher is handling many serial jobs all at once you want to increase the number of cores you are using to match the number of serial jobs you are executing.

/ So if your jobfile has 200 lines in it then you will need 200 cores. Each KNL node has 68 cores on it and each SKX node has 48 cores on it. So if you are using the KNL (normal) nodes you would need at least 3 nodes to run the 200 line job file, and if you were using the SKX (skx-normal) nodes you would need at least 5 nodes to run the 200 line job file.

/ For the KNL nodes we usually reommend that you use only 64 of the 68 cores available for memory reasons.

/ If your -n number is too big for the number of cores available in the -N number you selected then the job will not submit and indicate that you are not requesting resources properly. Essentially, you want to count the number of lines in your jobfile, you then want to set -n to that number. You will then calculate how many -N nodes you will need in order to accommodate that number of -n cores.
 

#running
	:markdown
//		# [Using Launcher](#running)

//		To use launcher on TACC systems like Stampede or Lonestar5, you need to:

//		1. Load the launcher module:

//			<pre class="cmd-line">login1$ <b>module load launcher</b></pre>

//		1. Create a launcher job file, "`paramrun`". Each line in this file is a separate command-line task to be distributed across all requested cores in your job script with the "`#SBATCH -n`" directive. A trivial example job file might look like this:

//			<pre class="file">
//			echo "Hello, World! from job $LAUNCHER_JID running on task $LAUNCHER_TSK_ID"
//			echo "Hello, World! from job $LAUNCHER_JID running on task $LAUNCHER_TSK_ID"
//			echo "Hello, World! from job $LAUNCHER_JID running on task $LAUNCHER_TSK_ID"
//			echo "Hello, World! from job $LAUNCHER_JID running on task $LAUNCHER_TSK_ID"</pre>

		
#using-parametersweep
	:markdown
//		# [Parameter Sweep Example](#using-parametersweep)

//		Perform a simple parameter sweep varying radial inputs from 1 to 360

//		<pre class="job-script">
//		$SCRATCH/myprogram 1
//		$SCRATCH/myprogram 2
//		$SCRATCH/myprogram 3
//		$SCRATCH/myprogram 4
//		$SCRATCH/myprogram 5
//		$SCRATCH/myprogram 6
//		$SCRATCH/myprogram 7
//		$SCRATCH/myprogram 8</pre>

//		Construct a Slurm batch script containing launcher commands and varying the following commands and directives as needed. 

//		* Set two environment variables in your job script:

//			1. `$LAUNCHER_JOB_FILE` : file containing the jobs to run in your parametric submission, e.g., "`paramrun`".
//			1. `$LAUNCHER_WORKDIR`  : directory where the launcher will execute, e.g. "`$SCRATCH`". All relative paths will resolve to this directory.

//		* Set the "`SBATCH -n`" directive to **the number of lines contained in your launcher job file**. 


#jobscript
	:markdown
//		## [Sample Launcher Job Script](#jobscript)

//		The following job script requeests 64 tasks across 4 nodes in Stampede2's `normal` queeue. 

//		<pre class="job-script">
//		#!/bin/bash
//		#SBATCH -J launcher-job		    # Job name
//		#SBATCH -o launcher-job.o%j		# Name of stdout output file
//		#SBATCH -e launcher-job.e%j		# Name of stderr error file
//		#SBATCH -p normal			    # Queue (partition) name
//		#SBATCH -N 4				    # number of nodes requested
//		#SBATCH -n 64				    # total number of tasks requested
//		#SBATCH -t 00:30:00			    # run time (hh:mm:ss) 
//		#SBATCH -A myproject			
	
//		module load launcher
//		export LAUNCHER_WORKDIR=my-launcher-job-dir
//		export LAUNCHER_JOB_FILE=my-launcher-job-file
	
//		$LAUNCHER_DIR/paramrun</pre>

