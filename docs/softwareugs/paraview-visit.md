/ ParaView: Greg Abram  
/ VisIt: Dave Semeraro   
/ Susan Lindsey
/ http://portal.tacc.utexas.edu/software/paraview-visit  
<p><span style="font-size:225%; font-weight:bold;">ParaView and VisIt at TACC</span><br>
<span style="font-size:90%"><i>Last update: Janauary 12, 2023</i></span></p>

#top
	:markdown
		TACC supports Paraview and Visit to visualize datasets that represent potentially many variables defined over some spatial/temporal domain.  Such data arises often in HPC computations, including climate and weather modeling, cosmology, engineering etc.

		Typically, such datsets include a discretization of the computational domain as a set of vertices in 1, 2, or dimensional space (optionally including time as a fourth dimension) and a set of cells that link the vertices into space-filling elements.  Data consists of scalar, vector or tensor values defined either at the vertices and interpolated in cells incident on the vertices, or defined on cells and considered to be constant within each cell.

		Paraview and VisIt are quite similar.  Both are based on the same computational library (VTK - the Visualization Toolkit) and are able to process a wide range of input formats.  Both are scriptable via Python, and both parallelize over many nodes to provide the necessary computational power, I/O bandwidth and memory space necessary to process extremely large datasets.  


#paraview
	:markdown
		# [ParaView](#paraview)

		<!-- <img alt="ParaView logo" src="/documents/10157/1667013/paraview-logo-2.png/0de54a14-69d2-4de2-a352-d360d7454ffb?t=1673381838464" style="height: 75px; " />-->
		ParaView is an open-source, multi-platform data analysis and visualization application. ParaView users can quickly build visualizations to analyze their data using qualitative and quantitative techniques. The data exploration can be done interactively in 3D or programmatically using ParaView's batch processing capabilities.
		
		ParaView was developed to analyze extremely large datasets using distributed memory computing resources. It can be run on supercomputers to analyze datasets of petascale size as well as on laptops for smaller data, has become an integral tool in many national laboratories, universities and industry, and has won several awards related to high performance computation.
		
		ParaView is currently installed on TACC's Lonestar6, Stampede2 and Frontera resources.  Consult the table below for the modules needed on each resource.
		
#table1
	:markdown
		[Table 1. ParaView Modules per TACC Resource](#table1)

%table(border="1" cellspacing="5" cellpadding="3")
	%tr
		%th Resource
		%th Versions Installed
		%th Module Requirements
	%tr
		%td Frontera
		%td 5.10.0<br>5.8.1
		%td <code>gcc/9 impi qt5 swr oneapi_rk paraview<br>qt5 swr ospray intel/19 impi paraview</code>
	%tr
		%td Stampede2
		%td 5.10.0<br>5.8.1
		%td <code>gcc/9 impi qt5 swr oneapi_rk paraview<br>qt5 swr ospray intel/19 impi paraview</code>
	%tr
		%td Lonestar6
		%td 5.10.0 
		%td <code>intel impi swr/21.2.5 qt5/5.14.2 oneapi_rk</code>
		
#paraview-gui
	:markdown
		## [Running ParaView GUI On A Compute-Node Desktop](#paraview-gui)

		Login to the [TACC Analysis Portal](https://tap.tacc.utexas.edu/) to allocate one (or more) compute nodes and run a desktop: <a href="https://tap.tacc.utexas.edu/jobs/">https://tap.tacc.utexas.edu/jobs/</a>.  You may opt for either a VNC or DCV connection to provide the desktop.

		<img alt="" src="/documents/10157/1181317/paraview-1.png/a71ac02e-a78a-419c-bfbd-7b21382dd8ab?t=1673382461761"></p>

		Select your desired options, and press Submit. Eventually the job will run, allocate the specified nodes and tasks, and provide a means to connect to it in a separate browser tab. There you will see a desktop. In the terminal window on that desktop:

		1.  Load the appropriate modules (see table above)

			<pre class="cmd-line">c442-001$ <b>module load <i>module list</i></b></pre>

		1. Run Paraview GUI

			<pre class="cmd-line">c442-001$ <b>swr -p 1 paraview</b></pre>

			where:

			* "`swr`" is a wrapper that enables Paraview to take advantage of Intel's many-core OpenSWR rendering library.  
			* The "`-p 1`" arguments inform OpenSWR that paraview is running serially and should have access to all available cores for rendering.

		And the Paraview GUI will appear on the desktop.

		**We do not use GPUs to run Paraview on either Stampede2 or Lonestar6**.  

#paraview-gui-parallel
	:markdown
		## [Running ParaView In Parallel](#paraview-gui-parallel)

		To run Paraview in parallel, you must first start your VNC or DCV desktop with more than one tasks, running on one or more nodes.  This is easily done on the TACC's Analysis Portal:
		
		<img alt="" src="/documents/10157/1181317/paraview-2.png/1996b98f-d087-4ada-a4ba-ae38f16dedb0?t=1673382519785"></p>

		Then start Paraview as above.  Once the GUI appears, "File-&gt;connect&hellip;" opens the Choose Server Configuration dialog.  The auto configuration will cause Paraview to launch a parallel server using one server process on each task allocated above.  In this case the available cores will be meted out to the server processes based on the number of tasks running on each node.

#paraview-gui-parallel-notes
	:markdown
		### [Notes on Paraview in Parallel](#paraview-gui-parallel-notes)

		Note that running Paraview with an excessive number of nodes and/or processes is often detrimental to overall performance.
		
		There are several issues to understand. First, there's limited bandwidth into each node; having lots of processors trying to load data in parallel through one data path causes all sorts of congestion. Generally, I've found that 4-6 processes per node maximizes the bandwidth onto the node; beyond this, total bandwidth falls off and way beyond this (which 48 processes/node is) it can sure look like its hung.  In one user's case, 2 nodes 8 processes loads the data in about a second whereas one node, one process loads in 3-4 seconds or so.  The difference rises with the size of the datasets.
		
		Second, lots of processes will only help in one aspect of the overall problem: geometry processing. But, again, it's not without overhead. PV relies on spatial decomposition for parallel processing. In order to get the right answer at inter-partition boundaries, it must maintain "ghost zones" - regions of actual overlap between the partitions. When the data is partitioned into lots of little chunks, as it is in our user's case, the portion of overlap rises, causing it to do significantly more work.
		
		Next, when the data is distributed, a final image is created by having each process render its local data, then compositing (with depth) to resolve a single image that's correct with respect to all the data. This adds quite a significant overhead to the rendering process, which is engaged whenever you move the viewpoint - which in interactive use happens way more often than, say, computing a new isosurface.
		
		Finally, in most cases our large-scale systems (Stampede2, Lonestar6 and Frontera) do not use GPUs for rendering. Instead, we use a software rendering library which is optimized to run on lots of cores and to use the full SIMD architecture of each. When there are lots of processes on each node, the number of cores available to each for rendering is small. Even if we did use GPUs, though, again - lots of processors per node would cause contention for the GPU resources and would still require compositing.

		While we wish there was a magic way to optimize Paraview in parallel,  there's not.  The best balance depends on the amount of data being read, the amount of geometry processing required, and the number of rendered frames per timestep that will be needed.  We generally advise users that the big win of running Paraview in parallel is that you get the aggregate bandwidth into memory and the aggregate total memory.  A useful rule of thumb is to use enough nodes to acquire maybe 4x the in-memory size of the input data, and hope that the high-water mark (remember, as you pass your data through PV filters, the intermediate data all increases Paraview's total memory footprint) and then allocate no more than 4-8 processes per node.

#paraview-batch
	:markdown
		## [Running ParaView In Batch Mode](#paraview-batch)

		Paraview can also be run in batch mode, generally from within an `idev` session or launched using a job script and `sbatch`.  In this case you use Paraview through Python; Paraview includes the "`pvbatch`" executable to do so.  The only difference in the required module stack is that you load the `paraview-osmesa` module rather than `paraview` so that it can run without a connection to a desktop.

#paraview-batch-idev
	:markdown
		### [Within an `idev` Section](#paraview-batch-idev)

		To run `pvbatch` serially or in parallel using idev, start a idev session:
		
		<pre class="cmd-line">
		login2.stampede2(1001)$ <b>idev -N <i>nNodes</i> -n <i>nTasks</i> -A <i>allocation</i> -p <i>queue</i></b>
		lots of stuff&hellip;
		Last login: Tue Apr  5 13:58:01 2022 from login2.stampede2.tacc.utexas.edu
		TACC Stampede2 System
		Provisioned on 24-May-2017 at 11:49
		 
		c455-003[knl](1001)$ <b>module load impi qt5 swr oneapi_rk paraview-osmesa</b></pre>
		
		At that compute-node prompt you can run `pvbatch` and give it your Python script.  As an example, if your Python script is tt.y containing:
		
		<pre class="syntax">
		from paraview.simple import *
		Sphere()
		Show()
		SaveScreenshot(&ldquo;tt.png&rdquo;)</pre>
		
		Then you can run it:
		
		<pre class="cmd-line">c455-003[knl](1004)$ <b>ibrun swr pvbatch tt.py</b>
		TACC:  Starting up job 9553190 
		TACC:  Starting parallel tasks... 
		...ignore messages...
		TACC:  Shutdown complete. Exiting. </pre>
		
		The scary looking text that emerges can be ignored.
		This will create a file named "`tt.png`" containing an image of a sphere:
		
		<img alt="" src="/documents/10157/1181317/paraview-3.png/43f8ddd6-f4af-499d-a843-71e431b6af18?t=1673382569884" style="width: 100px; height: 100px;" /></p>

#paraview-batch-jobscript
	:markdown
		### [Using a Job Script](#paraview-batch-idev)

		The same thing can be done in batch mode by submitting the following job file to the scheduler:

		<pre class="cmd-line">
		#!/bin/bash
		#
		#SBATCH -J myjob
		#SBATCH -o myjob.o%j       # Name of stdout output file
		#SBATCH -e myjob.e%j       # Name of stderr error file
		#SBATCH -p partitionname
		#SBATCH -N nnodes
		#SBATCH -n ntasks
		#SBATCH -t 01:30:00
		#SBATCH -A myproject

		module load gcc/9 impi qt5 swr oneapi_rk paraview-osmesa
		ibrun swr pvbatch tt.py</pre>

		
#paraview-batch-notes
	:markdown
		### [Notes on Paraview in Batch](#paraview-batch-notes)

		While one can write one's own Paraview/Python script by hand, it is often convenient to create a visualization using the Paraview GUI then run it in batch mode.  To do so, save your Paraview state as a Python script, then modify the script (by hand) to write images or save data as required.  For more information see <https://www.paraview.org/Wiki/ParaView/Python_Scripting>.
		
		You can also modify this script to, for example, take command line arguments to vary input and output file names etc.  It is also convenient to modify this script to iterate throuth datasets.

		
#visit
	:markdown
		# [VisIt ](#visit)

		Parallel VisIt is an Open Source, interactive, scalable, visualization, animation and analysis tool. Users can quickly generate visualizations, animate them through time, manipulate them with a variety of operators and mathematical expressions, and save the resulting images and animations for presentations. VisIt contains a rich set of visualization features to enable users to view a wide variety of data including scalar and vector fields defined on two- and three-dimensional (2D and 3D) structured, adaptive and unstructured meshes. Owing to its customizable plugin design, VisIt is capable of visualizing data from over 120 different scientific data formats.

		[VisIt](https://wci.llnl.gov/simulation/computer-codes/visit/manuals) was compiled under the Intel compiler and the mvapich2 and MPI stacks.

		After connecting to a VNC server on Stampede2, as described <a href="#h.jbs8hglnee6r">here</a>, load the VisIt module at the beginning of your interactive session before launching the Visit application:

		<pre class="cmd-line">
		c442-001$ <b>module load swr visit</b>
		c442-001$ <b>swr visit</b></pre>

		VisIt first loads a dataset and presents a dialog allowing for selecting either a serial or parallel engine. Select the parallel engine. Note that this dialog will also present options for the number of processes to start and the number of nodes to use; these options are actually ignored in favor of the options specified when the VNC server job was started.

#visit-prep
	:markdown
		## [Preparing Data for Parallel Visit](#visit-prep)

		VisIt reads [nearly 150 data formats](https://github.com/visit-dav/visit/tree/develop/src/databases). Except in some limited circumstances (particle or rectilinear meshes in ADIOS, basic netCDF, Pixie, OpenPMD and a few other formats), VisIt piggy-backs its parallel processing off of whatever static parallel decomposition is used by the data producer. This means that VisIt expects the data to be explicitly partitioned into independent subsets (typically distributed over multiple files) at the time of input. Additionally, VisIt supports a metadata file (with a .visit extension) that lists multiple data files of any supported format that hold subsets of a larger logical dataset. VisIt also supports a "brick of values (bov)" format which supports a simple specification for the static decomposition to use to load data defined on rectilinear meshes. For more information on importing data into VisIt, see [Getting Data Into VisIt](https://visit-dav.github.io/visit-website/pdfs/GettingDataIntoVisIt2.0.0.pdf).


#refs
	:markdown
		# [References](#refs)

		* [TACC Analysis Portal](https://portal.tacc.utexas.edu/tutorials/tap)
