# ParaView at TACC
*Last update: Aug 8, 2024*

ParaView is an open-source, multi-platform data analysis and visualization application. ParaView users can quickly build visualizations to analyze their data using qualitative and quantitative techniques. The data exploration can be done interactively in 3D or programmatically using ParaView's batch processing capabilities.

ParaView was developed to analyze extremely large datasets using distributed memory computing resources. It can be run on supercomputers to analyze datasets of petascale size as well as on laptops for smaller data, has become an integral tool in many national laboratories, universities and industry, and has won several awards related to high performance computation.

## Installations { #installations } 

ParaView is currently installed on TACC's Stampede3, Lonestar6 and Frontera resources.  

### Table 1. ParaView Modules per TACC Resource { #table1 }

Resource | Versions Installed | Module requirements
-- | -- | --
Frontera | 5.10.0<br>5.8.1 | `gcc/9` `impi` `qt5` `swr` `oneapi_rk` `paraview`<br>`qt5` `swr` `ospray` `intel/19` `impi` `paraview`
Stampede3 | 5.12.0 | `paraview`
Lonestar6 | 5.10.0 | `intel/19.1.1` `impi/19.0.9` `swr/21.2.5`  `qt5/5.14.2` `oneapi_rk/2021.4.0` `paraview`


## Running ParaView GUI On A Compute-Node Desktop

First, use the TACC Analysis Portal to allocate one (or more) compute nodes and run a desktop: https://tap.tacc.utexas.edu/jobs/   Although you can choose to use either VNC or DCV to provide the desktop, DCV is preferred but has a limited number of licenses available.

IMAGE

Select your desired options, and press Submit.   Eventually the job will run, allocate the specified nodes and tasks, and provide a means to connect to it in a separate browser tab.   There you will see a desktop.   In the terminal window on that desktop:
 Load the modules (see table above)
c442-001$ module load {module list}
Run Paraview GUI
	On Frontera and Lonestar6 compute nodes:
		c442-001$ swr -p 1 paraview 
	On Stampede3, Frontera and Lonestar6 compute nodes:
c442-001$ paraview 

And the Paraview GUI will appear on the desktop.
We do not use GPUs to run Paraview on Frontera, Stampede3 or Lonestar6.  On Frontera and Lonestar6 we use the swr wrapper that enables Paraview to take advantage of Intel's many-core OpenSWR rendering library.  The -p 1 arguments inform OpenSWR that paraview is running serially and should have access to all available cores for rendering.  On Stampede3 this is not necessary.

### Running ParaView In Parallel

To run Paraview in parallel, you must first start your VNC or DCV desktop with more than one tasks, running on one or more nodes.  This is easily done on the TACC vis portal:

IMAGE

Then start Paraview as above.    Once the GUI appears, File->connect… opens the Choose Server Configuration dialog.   The auto configuration will cause Paraview to launch a parallel server using one server process on each task allocated above.   In this case the available cores will be meted out to the server processes based on the number of tasks running on each node.
Notes on Paraview in Parallel
Note that running Paraview with an excessive number of nodes and/or processes is often detrimental to overall performance.

There are several issues to understand. First, there's limited bandwidth into each node; having lots of processors trying to load data in parallel through one data path causes all sorts of congestion. Generally, 4-6 processes per node maximizes the bandwidth onto the node; beyond this, total bandwidth falls off and way beyond this (which 48 processes/node is) it can look like its hung.  In one user's case, 2 nodes 8 processes loads the data in about a second whereas one node, one process loads in 3-4 seconds or so.  The difference rises with the size of the datasets.

Second, lots of processes will only help in one aspect of the overall problem: geometry processing. But, again, it's not without overhead. PV relies on spatial decomposition for parallel processing. In order to get the right answer at inter-partition boundaries, it must maintain 'ghost zones' - regions of actual overlap between the partitions. When the data is partitioned into lots of small chunks, as it is in our user's case, the portion of overlap rises, causing it to do significantly more work.

Next, when the data is distributed, a final image is created by having each process render its local data, then compositing (with depth) to resolve a single image that's correct with respect to all the data. This adds quite a significant overhead to the rendering process, which is engaged whenever you move the viewpoint - which in interactive use happens way more often than, say, computing a new isosurface.

Finally, our large-scale systems (Stampede3, Lonestar6 and Frontera) do not use GPUs for rendering. On Lonestar6 and Frontera we use a software rendering library which is optimized to run on lots of cores and to use the full SIMD architecture of each. When there are lots of processes on each node, the number of cores available to each for rendering is small. Even if we did use GPUs, though, again - lots of processors per node would cause contention for the GPU resources and would still require compositing.
While we wish there was a magic way to optimize Paraview in parallel,  there's not.  The best balance depends on the amount of data being read, the amount of geometry processing required, and the number of rendered frames per timestep that will be needed.  We generally advise users that the big win of running Paraview in parallel is that you get the aggregate bandwidth into memory and the aggregate total memory.  A useful rule of thumb is to use enough nodes to acquire maybe 4x the in-memory size of the input data, and hope that the high-water mark (remember, as you pass your data through PV filters, the intermediate data all increases Paraview's total memory footprint) and then allocate no more than 4-8 processes per node.
Running ParaView In Batch Mode
Paraview can also be run in batch mode, generally from an idev session or launched using a job script and sbatch.    In this case you use Paraview through Python; Paraview includes the pvbatch executable to do so.   The only difference in the required module stack is that you load the paraview-osmesa module rather than paraview so that it can run without a connection to a desktop.

To run pvbatch serially or in parallel using idev, start a idev session:

	login2.stampede2(1001)$ idev -N [nNodes] -n {nTasks} -A {allocation} -p {queue}
	… lots of stuff…
	Last login: Tue Apr  5 13:58:01 2022 from login2.stampede2.tacc.utexas.edu
TACC Stampede2 System
Provisioned on 24-May-2017 at 11:49
 
c455-003[knl](1001)$ module load impi qt5 swr oneapi_rk paraview-osmesa

At that compute-node prompt you can run pvbatch and give it your Python script.   As an example, if your Python script is tt.y containing:

	from paraview.simple import *
	Sphere()
	Show()
	SaveScreenshot("tt.png")

Then you can run it.  On Frontera and Lonestar6 we use the swr wrapper; on Stampede3 this is not necessary.

```cmd-line
c455-003[knl](1004)$ ibrun [swr] pvbatch tt.py 
TACC:  Starting up job 9553190 
TACC:  Starting parallel tasks... 
…ignore messages…
TACC:  Shutdown complete. Exiting. 
```

The scary looking text that emerges can be ignored.
This will create a file named 'tt.png' containing an image of a sphere:

IMAGE


## Notes from the Vis Team { #notes } 

While one can write one's own Paraview/Python script by hand, it is often convenient to create a visualization using the Paraview GUI then run it in batch mode.   To do so, save your Paraview state as a Python script, then modify the script (by hand) to write images or save data as required.   For more information see https://www.paraview.org/Wiki/ParaView/Python_Scripting

You can also modify this script to, for example, take command line arguments to vary input and output file names etc.   It is also convenient to modify this script to iterate through datasets.



