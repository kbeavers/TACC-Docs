# TAU at TACC
*Last update: September 19, 2018*

The University of Oregon's open-source TAU (**T**uning and **A**nalysis **U**tilities) package provides performance evaluation by profiling (reporting global statistics) and tracing (how events in parallel tasks interact in time) your code.  

Use TAU to gain insight into the performance and behaviour of your code: what routines take the most time, identifying load imbalances in a parallel run. TAU has some overlap in functionality with VTune. The difference lies in the fact that VTune can trace any binary, whereas TAU requires instrumentation. This means that TAU requires recompilation of your code, which may be cumbersome. On the other hand, TAU output is easier to understand since it relates to subroutine names in your code. 

TAU is installed on all TACC's HPC systems and is controlled through the [Lmod](https://www.tacc.utexas.edu/research-development/tacc-projects/lmod)/module system.  To set up and examine your TAU environment:

<pre class="cmd-line">
login1$ <b>module load tau</b>
login1$ <b>env | grep TAU</b>	#display package-specific environment variables
login1$ <b>module help tau</b>	#basic operations & features</pre>

## [Using TAU](#tacc) { #tacc }

1. [Instrument your code by recompiling with TAU scripts](#instrument)
2. [Launch your new executable](#launch) either interactively through an `idev` session or through a batch job.
3. [Process the TAU output](#process)

### [1. Instrumenting your Code](#using-instrument) { #using-instrument }

To use TAU, you need to recompile your code using some TAU compiler wrappers (scripts). Behind the scenes these scripts do a source-to-source instrumentation phase, followed by a regular compilation. The TAU compilation scripts are:

<pre class="cmd-line">
login1$ <b>tau_f90.sh</b>
login1$ <b>tau_cc.sh</b>
login1$ <b>tau_cxx.sh</b></pre>

These compiler wrappers can be used directly on a command line or within a makefile:

<pre class="cmd-line">login1$ <b>tau_cc.sh -o myprogram myprogramfile.c</b></pre>

Use the `-tau:help` option after the compiler wrapper command to see useful TAU options.

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

Behind the scenes, compiler wrappers create and execute a simple makefile that includes appropriate makefile options from an include makefile stored in the `$TAU_MAKEFILE` variable. Include makefiles are stored in the `$TACC_TAU_LIB` directory. The default `$TAU_MAKEFILE` value  will provide normal MPI and hybrid (MPI/OpenMP) instrumentation. Set the variable to `$TACC_TAU_LIB/Makefile.tau-intelomp-icpc-papi-ompt-pdt-openmp` for pure OpenMP codes.




### [2. Running](#launch) { #launch }

After instrumentation/compilation you have a regular binary that you can run, with MPI or OpenMP settings as needed. Then, launch an interactive or batch job, using this new binary. Control and configure TAU output with the following environment variables:

Environment Variable | Description
--- | ---
`TAU_PROFILE` 	| Set to 1 to turn on profiling (statistics) information.
`PROFILEDIR` 		| Set to the name of a directory; otherwise output goes to the current directory.
`TAU_TRACE` 		| Set to 1 to turn on tracing (timeline) information.
`TRACEDIR` 		| Set to the name of a directory. You can safely use the `PROFILEDIR` value.</pre>


Set up your environment in a batch script or `idev` session: 

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
&#35;SBATCH directives
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


### [3. Process program output](#process) { #process }

After your program runs you can process TAU's output to do two things: view statistics and analyze trace data.  The TAU package includes two visualization tools, ParaProf, and Jumpshot.  See [Remote Desktop Access at TACC][TACCREMOTEDESKTOPACCESS] for instructions on setting up visual connections to TACC resources.

* Display global statistics with TAU's 3D profile browser, ParaProf ([Figure 1.](#figure1)):

	<pre class="cmd-line">
	xterm$ <b>paraprof ${PROFILEDIR}</b></pre>

	<figure id="figure1">
	<img alt="" src="../../imgs/software/TAU-1.gif">
	<figcaption>Figure 1. Sample profile output courtesy of Livermore Computing Center</figcaption></figure>


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

		<figure id="figure2"><img alt="" src="../../imgs/software/TAU-2.png">
		<figcaption>Figure 2. Sample tracing output courtesy of <a href="http://www.mcs.anl.gov/research/projects/perfvis/pic/js4_timeline_preview_zoomed.png">Argonne National Laboratory</a></figcaption></figure>


## [References](#refs) { #refs }

* [TAU homepage](https://www.cs.uoregon.edu/research/tau/home.php)
* [TAU beginner's tutorial](http://tau.uoregon.edu/tau.ppt)
* [ParaProf User's Manual](https://www.cs.uoregon.edu/research/tau/docs/paraprof/)
* [Jumpshot](https://www.cs.uoregon.edu/research/tau/docs/newguide/bk01ch04s03.html)
* [`idev`][TACCIDEV]
* [Remote Desktop Access at TACC][TACCREMOTEDESKTOPACCESS]

{% include 'aliases.md' %}


