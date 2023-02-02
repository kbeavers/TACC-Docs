<p><span style="font-size:225%; font-weight:bold;">Arm MAP Profiler at TACC</span><br>
<i>Last update: May 08, 2020</i></p>

:markdown
	[Arm MAP](https://developer.arm.com/tools-and-software/server-and-hpc/debug-and-profile/arm-forge/arm-map) is a profiler for parallel, multithreaded or single threaded C, C++, Fortran and F90 codes. MAP provides in-depth runtime analysis and bottleneck pinpointing to the source code line. MAP is available on all TACC compute resources. Use the MAP Profiler with the [DDT Debugger](/tutorials/ddt) to develop and analyze your HPC applications. 

#env
	:markdown
		# [Set up Profiling Environment](#env)

		Before running MAP, the application code must be compiled with the "`-g`" option as shown below:

		<pre class="cmd-line">login1$ <b>mpif90 -g mycode.f90</b></pre>

		or

		<pre class="cmd-line">login1$ <b>mpiCC -g mycode.c</b></pre>

		Leave in any optimization flags to ensure that optimization is still enabled.  If there were no other optimization flags, add the "`-O2`" flag.  Otherwise, the "`-g`" flag by itself will drop the default optimization from "`-O2`" to "`-O0`".
		
		Follow these steps to set up your profiling environment on Frontera, Stampede2, Lonestar5 and other TACC compute resources.

		1. **Enable X11 forwarding**. To use the MAP GUI, ensure that X11 forwarding is enabled when you ssh to the TACC system. Use the "`-X`" option on the ssh command line if X11 forwarding is not enabled in your ssh client by default.

			<pre class="cmd-line">localhost$ <b>ssh -X <i>username</i>@stampede2.tacc.utexas.edu</b></pre>

		1. **Load the appropriate MAP module on the remote system** along with any other modules needed to run the application:

			<pre class="cmd-line">
			$ <b>module load map_skx <i>mymodule1 mymodule2</i></b>	# on Stampede2 load "map_skx"
			$ <b>module load map <i>mymodule1 mymodule2</i></b>       # on all other resources load "map"</pre>

		1. **Start the profiler.**

			<pre class="cmd-line">$ <b>map myprogram</b></pre>
		
			If this error message appears...
		
			<pre class="cmd-line">map: cannot connect to X server</pre>

			...then X11 forwarding was not enabled or the system may not have local X11 support. If logging in with the "`-X`" flag doesn't fix the problem, please contact the [help desk](https://portal.tacc.utexas.edu/tacc-consulting/-/consult/tickets/create) for assistance.

		1. **Click the "Profile a Program" button in the "arm FORGE" window if the "Run" window did not open**.

			<img alt="image3" src="/documents/10157/1396078/image3.png/b634ea1a-90f7-43c2-8ad0-f791fdbf421d?t=1587676425000" style="height: 483px; width: 800px; border-width: 1px; border-style: solid;" />

		1. **Specify the executable path, command-line arguments, and processor count in the "Run" window**. Once set, the values persist from one session to the next.

			<img alt="image8" src="/documents/10157/1396078/image8.png/f96c283f-fbed-452f-9c56-ed095b1638cf?t=1587677794210" style="height: 583px; width: 400px; border-width: 1px; border-style: solid;" />

		1. **Select each of the "Change" buttons in this window, and adjust the job parameters, as follows:**

			* With the "Options" change button, set the MPI Implementation to either "Intel MPI" or "mvapich2", depending on which MPI software stack you used to compile your program. Click OK.

				<img alt="image9" src="/documents/10157/1396078/image9.png/e36f8e04-b88c-478e-a879-26f6501670e3?t=1587677836873" style="width: 600px; border-width: 1px; border-style: solid; height: 387px;" />

			* In the "Queue Submission Parameters" window, fill in all the following fields:

				<table border="1" cellpadding="3"> <tr>
				<th> Queue
				<td> default queue is "<code>skx-dev</code>" for Stampede2, and "`development`" for other systems
				</tr><tr>
				<th> Time
				<td> (hh:mm:ss)
				</tr><tr>
				<th> Project
				<td> Allocation/Project to charge the batch job to</table>
		
				<p>You must set the Project field to a valid project id. When you login, a list of the projects associated with your account and the corresponding balance should appear. The "Cores per node" setting controls how many MPI tasks will run on each node. For example, if you wanted to run with 4 MPI tasks per node and 4 OpenMP threads per task, this would be set to "4way". Click OK, and you will return to the "Run" window.

				<img alt="image7" src="/documents/10157/1396078/image7.png/ea408894-1a13-4681-9242-01354cf167bd?t=1587676511000" style="height: 258px; width: 300px; border-width: 1px; border-style: solid;" />
		
		1. **Back in the "Run" window, set the total number of tasks you will need in the "Number of processes" box and the number of nodes you will be requesting**. If you are running an OpenMP program, set the number of OpenMP threads also.

			<img alt="image8" src="/documents/10157/1396078/image8.png/f96c283f-fbed-452f-9c56-ed095b1638cf?t=1587677794210" style="height: 583px; width: 400px; border-width: 1px; border-style: solid;" />

		1. **Finally, click "Submit"**. A submitted status box will appear.

			<img alt="image4" src="/documents/10157/1396078/image4.png/5e01c4a7-64c4-4792-a1a1-b45060ec4c90?t=1587676448000" style="height: 348px; width: 800px; border-width: 1px; border-style: solid;" />
	
#running
	:markdown
		# [Running MAP](#running)
		
		Once your job is launched by the SLURM scheduler and starts to run, the MAP window will switch to show stdout/stderr.  At this point, you can also stop execution of the program to analyze the collected profiling data.
		
		<img alt="image10" src="/documents/10157/1396078/image10.png/c3d08039-2374-4332-82d9-963eb174716f?t=1587677934298" style="height: 491px; width: 800px; border-width: 1px; border-style: solid;" />
		
		After your code completes, MAP will run an analysis of the profiling data collected, and then open the MAP GUI. This screen shows a time progression of the profiled code showing activity, floating point and memory usage. Other timelines, such as IO, MPI, or Lustre, may be added by clicking on the "Metrics" menu.  If you compiled with "`-g`" and MAP can find the source code, a code listing will also be available.  
		
		<img alt="image6" src="/documents/10157/1396078/image6.png/8a00a5f8-4a4a-4e17-b6c6-63dfc563ddd3?t=1587676489000" style="height: 491px; width: 800px; border-width: 1px; border-style: solid;" />

#reverse
	:markdown
		# [MAP with Reverse Connect](#revers)
		
		By starting MAP from a login node you let it use X11 graphics, which can be slow. Using a VNC connection or the visualization portal is faster, but has its own annoyances. Another way to use MAP is through a MAP's Remote Client using "reverse connect". The remote client is a program running entirely on your local machine, and the reverse connection means that the client is contacted by the MAP program on the cluster, rather than the other way around.

		1. **Download and install the [ARM Forge remote client](https://developer.arm.com/tools-and-software/server-and-hpc/downloads/arm-forge)**. The client version and the MAP version on the TACC cluster must correspond. 

		1. **Under "Remote Launch" make a new configuration**:

			<img alt="image1" src="/documents/10157/1396078/image1.png/8bf1609f-6f46-4325-80b1-92c376aa05e1?t=1587676378000" style="width: 300px; border-width: 1px; border-style: solid; height: 73px;" />

		1. **Fill in your login name and the cluster to connect to**, for instance "`stampede2.tacc.utexas.edu`". The remote installation directory is stored in the "`$TACC_MAP_DIR`" environment variable once the module is loaded.  

		1. **Make the connection**; you'll be prompted for your password and two-factor code:

			<img alt="image5" src="/documents/10157/1396078/image5.png/f2c258dd-56b9-416d-88c7-c76825f838c8?t=1587676470000" style="height: 342px; width: 500px; border-width: 1px; border-style: solid;" />

		1. **From any login node, submit a batch job where the ibrun line is replaced by**:

			<pre class="cmd-line">login1$ <b>map --connect -n 123 ./yourprogram</b></pre>

		1. **When your batch job (and therefore your MAP execution) starts, the remote client will ask you to accept the connection**:

			<img alt="image2" src="/documents/10157/1396078/image2.png/8f403a64-55e5-46fa-8d0b-3281e932477b?t=1587676399000" style="height: 174px; width: 400px; border-width: 1px; border-style: solid;" />
		
			**Your MAP session will now use the remote client.**

#refs
	:markdown
		# [References](#refs)
		
		* [DDT Debugger](/tutorials/ddt)
		* [MAP user guide](https://developer.arm.com/docs/101136/2003)
		

