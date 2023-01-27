<style>.help{box-sizing:border-box}.help *,.help *:before,.help *:after{box-sizing:inherit}.row{margin-bottom:10px;margin-left:-15px;margin-right:-15px}.row:before,.row:after{content:" ";display:table}.row:after{clear:both}[class*="col-"]{box-sizing:border-box;float:left;position:relative;min-height:1px;padding-left:15px;padding-right:15px}.col-1-5{width:20%}.col-2-5{width:40%}.col-3-5{width:60%}.col-4-5{width:80%}.col-1-4{width:25%}.col-1-3{width:33.3%}.col-1-2,.col-2-4{width:50%}.col-2-3{width:66.7%}.col-3-4{width:75%}.col-1-1{width:100%}article.help{font-size:1.25em;line-height:1.2em}.text-center{text-align:center}figure{display:block;margin-bottom:20px;line-height:1.42857143;border:1px solid #ddd;border-radius:4px;padding:4px;text-align:center}figcaption{font-weight:bold}.lead{font-size:1.7em;line-height:1.4;font-weight:300}.embed-responsive{position:relative;display:block;height:0;padding:0;overflow:hidden}.embed-responsive-16by9{padding-bottom:56.25%}.embed-responsive .embed-responsive-item,.embed-responsive embed,.embed-responsive iframe,.embed-responsive object,.embed-responsive video{position:absolute;top:0;bottom:0;left:0;width:100%;height:100%;border:0}</style>

/ Victor E.
/ https://portal.tacc.utexas.edu/software/tau
<span style="font-size:225%; font-weight:bold;">TAU at TACC</span><br>
<span style="font-size:90%"><i>Last update: September 19, 2018</i></span>

#top
	:markdown
		<p>The University of Oregon's open-source TAU (**T**uning and **A**nalysis **U**tilities) package provides performance evaluation by profiling (reporting global statistics) and tracing (how events in parallel tasks interact in time) your code.  

		Use TAU to gain insight into the performance and behaviour of your code: what routines take the most time, identifying load imbalances in a parallel run. TAU has some overlap in functionality with VTune. The difference lies in the fact that VTune can trace any binary, whereas TAU requires instrumentation. This means that TAU requires recompilation of your code, which may be cumbersome. On the other hand, TAU output is easier to understand since it relates to subroutine names in your code. 

		TAU is installed on all TACC's HPC systems and is controlled through the [Lmod](https://www.tacc.utexas.edu/research-development/tacc-projects/lmod)/module system.  To set up and examine your TAU environment:

		<pre class="cmd-line">
		login1$ <b>module load tau</b>
		login1$ <b>env | grep TAU</b>	#display package-specific environment variables
		login1$ <b>module help tau</b>	#basic operations & features</pre>
#using
	:markdown
		# [Using TAU](#tacc)

		1. [Instrument your code by recompiling with TAU scripts](#instrument)
		2. [Launch your new executable](#launch) either interactively through an `idev` session or through a batch job.
		3. [Process the TAU output](#process)

#instrument
	:markdown
		## [1. Instrumenting your Code](#using-instrument)

		To use TAU, you need to recompile your code using some TAU compiler wrappers (scripts). Behind the scenes these scripts do a source-to-source instrumentation phase, followed by a regular compilation. The TAU compilation scripts are:

		<pre class="cmd-line">
		login1$ <b>tau_f90.sh</b>
		login1$ <b>tau_cc.sh</b>
		login1$ <b>tau_cxx.sh</b></pre>

		These compiler wrappers can be used directly on a command line or within a makefile:

		<pre class="cmd-line">login1$ <b>tau_cc.sh -o myprogram myprogramfile.c</b></pre>

		Use the "`-tau:help`" option after the compiler wrapper command to see useful TAU options.

		For a makefile that works both with and without TAU, use:

		<pre class="makefile">
		ifdef TACC_TAU_DIR
		  FC = tau_f90.sh
		  CC = tau_cc.sh
		  CXX = tau_cxx.sh
		else
		  FC = mpif90
		  CC  = mpicc
		  CXX = mpicxx
		endif
		
		%.o : %.cxx
			${CXX} -c $*.cxx</pre>

		Behind the scenes, compiler wrappers create and execute a simple makefile that includes appropriate makefile options from an include makefile stored in the "`$TAU_MAKEFILE`" variable. Include makefiles are stored in the "`$TACC_TAU_LIB`" directory. The default "`$TAU_MAKEFILE`" value  will provide normal MPI and hybrid (MPI/OpenMP) instrumentation. Set the variable to "`$TACC_TAU_LIB/Makefile.tau-intelomp-icpc-papi-ompt-pdt-openmp`" for pure OpenMP codes.




#launch
	:markdown
		## [2. Running](#launch)

		After instrumentation/compilation you have a regular binary that you can run, with MPI or OpenMP settings as needed. Then, launch an interactive or batch job, using this new binary. Control and configure TAU output with the following environment variables:

	%table(border="1")
		%tr
			%td TAU_PROFILE 	
			%td Set to 1 to turn on profiling (statistics) information.
		%tr
			%td PROFILEDIR 		
			%td Set to the name of a directory; otherwise output goes to the current directory.
		%tr
			%td TAU_TRACE 		
			%td Set to 1 to turn on tracing (timeline) information.
		%tr
			%td TRACEDIR 		
			%td Set to the name of a directory. You can safely use the `PROFILEDIR` value.</pre>


	:markdown
		<p>Set up your environment in a batch script or `idev` session: 

		<pre class="cmd-line">
		login1$ <b>idev</b>
		...
		c455-073[knl]$ <b>cd mytaudir; mkdir -p profiles</b>
		c455-073[knl]$ <b>export PROFILEDIR=`pwd`/profiles</b>
		c455-073[knl]$ <b>ibrun myprogram</b>					#profiling is on by default
		...
		c455-073[knl]$ <b>mkdir -p traces</b>
		c455-073[knl]$ <b>export TRACEDIR=`pwd`/traces</b>
		c455-073[knl]$ <b>export TAU_PROFILE=0 TAU_TRACE=1</b>
		...
		c455-073[knl]$ <b>ibrun myprogram</b>
		</pre>

		<pre class="job-script">
		#SBATCH directives
		...
		export PROFILEDIR=mytaudir/profiles
		export TRACEDIR=mytaudir/traces
		ibrun myprogram
		...
		export TAU_PROFILE=0
		export TAU_TRACE=1
		ibrun myprogram
		</pre>

		Then run your program as normal.  Once execution finishes, you can process and examine the TAU profile and/or tracing output.

#process
	:markdown
		## [3. Process program output](#process)

		After your program runs you can process TAU's output to do two things: view statistics and analyze trace data.  The TAU package includes two visualization tools, ParaProf, and Jumpshot.  See [Remote Desktop Access at TACC](/tutorials/remote-desktop-access.haml) for instructions on setting up visual connections to TACC resources.

		* Display global statistics with TAU's 3D profile browser, ParaProf ([Figure 1.](#figure1)):

			<pre class="cmd-line">
			xterm$ <b>paraprof ${PROFILEDIR}</b></pre>

	%figure
		<img alt="" src="/documents/10157/1181317/TAU+profile+output/d0d1e3d1-76ce-4875-b6df-7fda11a5fe39?t=1528390593851" style="width: 500px; height: 323px;" />
		%figcaption Figure 1. Sample profile output courtesy of <a href="https://hpc.llnl.gov/files/tau01gif">Livermore Computing Center</a>

	:markdown

		* To analyze the trace data,

			1. First, generate the trace data: 

				<pre class="cmd-line">
				login1$ <b>cd ${TRACEDIR}</b>									# change to the directory containing trace files
				login1$ <b>rm -f tau.trc tau.edf</b>							# remove any previous output files
				login1$ <b>tau_treemerge.pl</b>									# merge all the trace files into one directory	
				login1$ <b>tau2slog2 tau.trc tau.edf -o yourprogram.slog2</b>	# create viewable files</pre>

			1. then visualize that data using another TAU package, Jumpshot ([Figure 2.](#figure2)): 

				<pre class="cmd-line">
				xterm$ <b>jumpshot yourprogram.slog2</b></pre>
#figure2
	:markdown
		<figure><img alt="" src="/documents/10157/1181317/TAU+tracing+output/bd930281-ed56-4424-a3b8-9c5bfeb7372a?t=1528390637180" style="width: 500px; height: 393px;" /><figcaption>Figure 2. Sample tracing output courtesy of <a href="http://www.mcs.anl.gov/research/projects/perfvis/pic/js4_timeline_preview_zoomed.png">Argonne National Laboratory</a></figcaption></figure>

	
#refs
	:markdown
		# [References](#refs)

		* [TAU homepage](https://www.cs.uoregon.edu/research/tau/home.php)
		* [TAU beginner's tutorial](http://tau.uoregon.edu/tau.ppt)
		* [ParaProf User's Manual](https://www.cs.uoregon.edu/research/tau/docs/paraprof/)
		* [Jumpshot](https://www.cs.uoregon.edu/research/tau/docs/newguide/bk01ch04s03.html)
		* [`idev`](/software/idev)
		* [Remote Desktop Access at TACC](/tutorials/remote-desktop-access)
		* [TACC Software page](https://www.tacc.utexas.edu/systems/software)


