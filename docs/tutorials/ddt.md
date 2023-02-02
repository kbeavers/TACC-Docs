<p><span style="font-size:225%; font-weight:bold;">Arm DDT Debugger at TACC</span><br>
<i>Last update: May 18, 2020</i></p>

:markdown
	[Arm DDT](https://www.arm.com/products/development-tools/server-and-hpc/forge/ddt) is a symbolic, parallel debugger providing graphical debugging of C, C++ and Fortran threaded and parallel codes (MPI, OpenMP, and Pthreads applications). DDT is available on all TACC compute resources. Use the DDT Debugger with the [MAP Profiler](/tutorials/map) to develop and analyze your HPC applications.

#env
	:markdown
		# [Set up Debugging Environment](#env)

		Before running any debugger, the application code must be compiled with the "`-g`" and "`-O0`" options as shown below:

		<pre class="cmd-line">login1$ <b>mpif90 -g -O0 mycode.f90</b></pre>

		or

		<pre class="cmd-line">login1$ <b>mpiCC -g -O0 mycode.c</b></pre>

		Follow these steps to set up your debugging environment on Frontera, Stampede2, Lonestar5 and other TACC compute resources.

		1. **Enable X11 forwarding**. To use the DDT GUI, ensure that X11 forwarding is enabled when you `ssh` to the TACC system. Use the "`-X`" option on the `ssh` command line if X11 forwarding is not enabled in your SSH client by default.

			<pre class="cmd-line">localhost$ <b>ssh -X <i>username</i>@stampede2.tacc.utexas.edu</b></pre>

		1. **Load the DDT module on the remote system along with any other modules needed to run the application**:

			<pre class="cmd-line">$ <b>module load ddt <i>mymodule1 mymodule2</i></b></pre>

			NOTE: On Stampede2, there are 2 DDT modules, `ddt_skx` and `ddt_knl`, because the KNL's require a different license.

			<pre class="cmd-line">$ <b>module load ddt_knl <i>mymodule1 mymodule2</i> # for KNL nodes</b></pre>
			or
			<pre class="cmd-line">$ <b>module load ddt_skx <i>mymodule1 mymodule2</i> # for SKX nodes</b></pre>

		1. **Start the debugger**:

			<pre class="cmd-line">$ <b>ddt myprogram</b></pre>

			If this error message appears...

			<pre class="cmd-line">ddt: cannot connect to X server</pre>

			...then X11 forwarding was not enabled (Step 1.) or the system may not have local X11 support. If logging in with the "`-X`" flag doesn't fix the problem, please [contact the help desk]() for assistance.

		1. **Click the "Run and Debug a Program" button in the "DDT - Welcome" window**:

			<img src="/documents/10157/1396078/ddt-armforge.png/21f8e169-04f2-4d5a-b9e5-349688b6bf16?t=1587911107729" style="height: 487px; width: 800px; border-width: 1px; border-style: solid;" />

		1. This displays the "Run" window, where you **specify the executable path, command-line arguments, and processor count**. Once set, these values remain from one session to the next.
  
			<img src="/documents/10157/1396078/ddt-queuesubmission.png/699185e3-6bad-4b24-b495-aba592fea3b1?t=1587911226948" style="height: 497px; width: 400px; border-width: 1px; border-style: solid;" />

		1. **Select each of the "Change" buttons in this window, and adjust the job parameters**.
   
			* With the "Options" change button, set the MPI Implementation to either "Intel MPI" or "MVAPICH 2i", depending on which MPI software stack you used to compile your program. Click OK.
  
				<img src="/documents/10157/1396078/ddt-systemsettings.png/5fb8c103-b94c-4f1d-ade7-5dd66af23657?t=1587911300582" style="width: 600px; border-width: 1px; border-style: solid; height: 435px;" />
   
			* In the "Queue Submission Parameters" window, fill in the following fields:

				<table border="1" cellpadding="3">
				<tr><th>Queue</th><td>default queue is "<code>skx-dev</code>" for Stampede2, and "<code>development</code>" for other systems</td></tr>
				<tr><th>Time</th><td>(hh:mm:ss)</td></tr>
				<tr><th>Project</th><td>Allocation/Project to charge the batch job to</td></tr></table>
	  
				<p>You must set the Project field to a valid project id. When you login, a list of the projects associated with your account and the corresponding balance should appear. Click OK, and you'll return to the "Run" window.

				<img alt="" src="/documents/10157/1396078/ddt-queue.png/730354a8-1956-4832-b73d-cb6d1fedfae1?t=1587911209949" style="width: 300px; height: 258px; border-width: 1px; border-style: solid;" />
      
		1. Back in the "Run" window, **set the number of tasks you will need in the "Number of processes" box and the number of nodes you will be requesting**. If you are debugging an OpenMP program, set the number of OpenMP threads also.
  
			<img alt="" src="/documents/10157/1396078/ddt-queuesubmission.png/699185e3-6bad-4b24-b495-aba592fea3b1?t=1587911227000" style="width: 400px; height: 497px; border-width: 1px; border-style: solid;" />
      
		1. **Finally, click "Submit"**. A submitted status box will appear:

			<img src="/documents/10157/1396078/ddt-jobsubmitted.png/bd7495e0-1716-4247-ae72-ce72b63f4671?t=1587911154000" style="height: 346px; width: 700px; border-width: 1px; border-style: solid;" />
  

#running
	:markdown
		# [Running DDT](#running)

		Once your job is launched by the SLURM scheduler and starts to run, the DDT GUI will fill up with a code listing, stack trace, local variables and a project file list. Double click on line numbers to set breakpoints, and then click on the play symbol (>) in the upper left corner to start the run.
  
		<img alt="" src="/documents/10157/1396078/ddt-mainwindow.png/7065b684-6d6b-4f61-ac22-2880c2fecd88?t=1587911183809" style="width: 800px; height: 485px; border-width: 1px; border-style: solid;" />

#reverse
	:markdown
		# [DDT with Reverse Connect](#reverse)

		By starting DDT from a login node you let it use X11 graphics, which can be slow. Using a VNC connection or the visualization portal is faster, but has its own annoyances. Another way to use DDT is through DDT's Remote Client using "reverse connect". The remote client is a program running entirely on your local machine, and the reverse connection means that the client is contacted by the DDT program on the cluster, rather than the other way around.

		1. **[Download and install a remote client](https://developer.arm.com/tools-and-software/server-and-hpc/downloads/arm-forge). Get the latest client available**.

		1. **Under "Remote Launch" make a new configuration**:

			<img src="/documents/10157/1396078/ddt-remotelaunch.png/9ffa5e9c-f80e-4a8a-9409-a7ad175b7538?t=1587911248501" style="height: 73px; width: 300px; border-width: 1px; border-style: solid;" />

			Fill in your login name and the cluster to connect to, for instance "`stampede2.tacc.utexas.edu`". The remote installation directory is stored in the "`$TACC_DDT_DIR`" environment variable after the module is loaded.

		1. **Make the connection; you'll be promped for your password and two-factor code**:
  
			<img src="/documents/10157/1396078/ddt-connectremotehost.png/d14fcd38-3f94-4c02-a1f5-015b719c485d?t=1587911131119" style="width: 500px; height: 309px; border-width: 1px; border-style: solid;" />

		1. **From any login node, submit a batch job where the "`ibrun`" line is replaced by**:
		
			<pre class="cmd-line">$ <b>ddt --connect -n $SLURM_NPROCS ./yourprogram</b></pre>

		1. **When your batch job (and therefore your DDT execution) starts, the remote client will ask you to accept the connection**:

			<img src="/documents/10157/1396078/ddt-reverseconnect.png/6777dcc1-7800-4742-9084-6f27004d2006?t=1587911280333" style="width: 300px; height: 127px; border-width: 1px; border-style: solid;" />

			**Your DDT session will now use the remote client.**

#refs
	:markdown
		# [References](#refs)

		* [DDT User Guide](https://developer.arm.com/docs/101136/2003/ddt)
		* [MAP Profiler](/tutorials/map)
		* Presentation: [Debugging at TACC](https://www.tacc.utexas.edu/documents/13601/897815/1a-Debugging.pdf) (`gdb`, DDT & Eclipse)


