/ Authors
/ http://portal.tacc.utexas.edu/software/remora
<span style="font-size:225%; font-weight:bold;">Remora - Resource Monitoring for Remote Applications</span><br>
<span style="font-size:90%"><i>Last update: August 21, 2019</i></span>
<p>&nbsp;</p>

#top
	:markdown
		REMORA stands for **RE**source **MO**nitoring for **R**emote **A**pplications. Remora provides a simple interface to gather important system utilization data while running on HPC systems. Remora monitors almost all user activities and provides per-node and per-job resource usage data for users. These collected data can be used to improve code performance or detect unusual issues. The reports can help users achieve a better understanding of their applications with total-run average resource usages and resource-usage timelines. This information can provide the first-level of information for improving codes.

		REMORA uses shell scripts as a framework, includes external tools, and accesses `/sys` and `/proc` files for kernel data. It reports a brief summary at the end of the run.  Timeline reports from  records taken during an application run, are included in text files, labeled by the content and node name, in a "`remora_*jobid*`" subdirectory.  The text files contain timeline information on memory, CPU loads, network traffic, IO load, NUMA memory, power, and temperature. More comprehensive Google timeline plots and graphs are created in html files, and can be downloaded and opened on the user’s laptop.


#running
	:markdown
		# [Running Remora](#running)

		Remora is installed on all TACC compute resources. You can use remora interatively on a compute node via an idev session or in a batch job as shown below. 

#running-interactively
	:markdown
		## [Interactively](#running-interactively)

		<!-- get an copute node -->
		<pre class="cmd-line">
		login1$ <b>idev</b>
		c123-456$ <b>module load remora</b>
		c123-456$ <b>remora myserialcode <i>args</i></b></pre>

#running-batch
	:markdown
		## [Remora in Job Scripts](#running-batch)

		Modify your batch script and include 'remora' before your script, executable, or MPI launcher within your script as shown below:

		<pre class="job-script">
		#!/bin/bash
		#SBATCH -J myjob           		# Job name
		#SBATCH -oe myjob.o%j      		# Name of stdout/stderr output file
		#SBATCH -p normal          		# Queue (partition) name
		#SBATCH -N 1               		# Total # of nodes (must be 1 for serial)
		#SBATCH -n 16              		# Total # of mpi tasks (should be 1 for serial)
		#SBATCH -t 01:00:00        		# Run time (hh:mm:ss)
		#SBATCH -A <i>myproject</i>     		# Allocation name (req'd if you have more than 1)

		<b>module load remora 
		remora ibrun ./my_parallel_job	# or "remora ./serial_job" if running a serial job</b></pre>


#options
	:markdown
		# [Remora Options](#options)

		Users can configure REMORA to achieve the amount of detail that they want and perform the analysis of the results at any point in time. For short runs (less than several minutes) the environment variable `$REMORA_PERIOD` can be set to 1 to take snapshots ever second, instead of using the default 10 seconds. For longer executions set `$REMORA_PERIOD` to a larger value.

		* `$REMORA_PERIOD` - Interval in seconds between data record snapshots, default = 10 (sec)
		* `$REMORA_TMPDIR`
			* FS for local data collection;
			* use `/tmp` for long runs – less overhead 
		* `$REMORA_MODE`
			* FULL (default): cpu, memory, network, luster ..
			* BASIC: cpu, memory
			* MONITOR:  real-time reporting


#output
	:markdown
		# [Remora Output](#output)

		Remora will generate a summary report as shown below at the end of each job.

		<img alt="" src="/documents/10157/1181317/remora-html.png/1a9cf091-c1c4-492a-aa08-4dbc15933627?t=1566489218446" style="width: 310px; height: 416px;" />
 
		Remora will generate a series of files in the running directory like this.  
 
		<img alt="" src="/documents/10157/1181317/Remora+summary/4c5db663-1cc7-4483-8810-d2cad4cbca06?t=1559066516000" style="width: 300px; height: 703px;" />


#refs
	:markdown
		# [References](#refs)

		Remora is an open-source project. You can find more detailed information about it from the published paper or remora's github repository.

		* [Remora GitHub Repository](https://github.com/TACC/remora)
		* [REMORA: A Resource Monitoring Tool for Everyone](https://dl.acm.org/citation.cfm?id=2834999)


