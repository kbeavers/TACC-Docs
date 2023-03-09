# ParaView and VisIt at TACC

## ParaView

ParaView is an open-source, multi-platform data analysis and visualization application. ParaView users can quickly build visualizations to analyze their data using qualitative and quantitative techniques. The data exploration can be done interactively in 3D or programmatically using ParaView&rsquo;s batch processing capabilities.

ParaView was developed to analyze extremely large datasets using distributed memory computing resources. It can be run on supercomputers to analyze datasets of petascale size as well as on laptops for smaller data, has become an integral tool in many national laboratories, universities and industry, and has won several awards related to high performance computation.

ParaView is currently installed on TACC&rsquo;s Stampede2 and Frontera resources.  

### Table 1. ParaView Modules per TACC Resource

<table><tr>
<td> Resource</td>
<td> Versions Installed</td>
<td> Module requirements</td></tr>
<tr><td> Frontera</td>
<td> 5.10.0<br>5.8.1</td>
<td>gcc/9 impi qt5 swr oneapi_rk paraview</br>qt5 swr ospray intel/19 impi paraview</td></tr><tr>
<td>Stampede2</td>
<td>5.10.0<br>5.8.1</td>
<td>gcc/9 impi qt5 swr oneapi_rk paraview<br>qt5 swr ospray intel/19 impi paraview</td></tr>
<tr><td>Lonestar6</td>
<td>TBA</td>
<td>TBA</td></tr></table>

### Running ParaView GUI On A Compute-Node Desktop

First, use the TACC Analysis Portal to allocate one (or more) compute nodes and run a desktop: <a href="https://tap.tacc.utexas.edu/jobs/">https://tap.tacc.utexas.edu/jobs/</a>   You can choose to use either VNC or DCV to provide the desktop.

<figure id="figure1"><img alt="paraview-visit-1" src="../../imgs/software/paraview-visit-1.png"><figcaption></figcaption></figure>

Select your desired options, and press Submit.   Eventually the job will run, allocate the specified nodes and tasks, and provide a means to connect to it in a separate browser tab.   There you will see a desktop.   In the terminal window on that desktop:

<ol class="c12 lst-kix_156fc3xne4mk-0 start" start="1">
1. Load the modules (see table above)</ol>

c442-001$ module load {module list}

<ol class="c12 lst-kix_156fc3xne4mk-0" start="2">
1. Run Paraview GUI</ol>

        c442-001$ swr -p 1 paraview 

And the Paraview GUI will appear on the desktop.

We do not use GPUs to run Paraview on either Stampede2 or Lonestar6.  swr is a wrapper that enables Paraview to take advantage of Intel&rsquo;s many-core OpenSWR rendering library.  The -p 1 arguments inform OpenSWR that paraview is running serially and should have access to all available cores for rendering.

### Running ParaView In Parallel

To run Paraview in parallel, you must first start your VNC or DCV desktop with more than one tasks, running on one or more nodes.  This is easily done on the TACC vis portal:

<figure id="figure2"><img alt="paraview-visit-2" src="../../imgs/software/paraview-visit-2.png"><figcaption></figcaption></figure>

Then start Paraview as above.    Once the GUI appears, File-&gt;connect&hellip; opens the Choose Server Configuration dialog.   The auto configuration will cause Paraview to launch a parallel server using one server process on each task allocated above.   In this case the available cores will be meted out to the server processes based on the number of tasks running on each node.

#### Notes on Paraview in Parallel

Note that running Paraview with an excessive number of nodes and/or processes is often detrimental to overall performance.

There are several issues to understand. First, there's limited bandwidth into each node; having lots of processors trying to load data in parallel through one data path causes all sorts of congestion. Generally, I've found that 4-6 processes per node maximizes the bandwidth onto the node; beyond this, total bandwidth falls off and way beyond this (which 48 processes/node is) it can sure look like its hung.  In one user&rsquo;s case, 2 nodes 8 processes loads the data in about a second whereas one node, one process loads in 3-4 seconds or so.  The difference rises with the size of the datasets.

Second, lots of processes will only help in one aspect of the overall problem: geometry processing. But, again, it&rsquo;s not without overhead. PV relies on spatial decomposition for parallel processing. In order to get the right answer at inter-partition boundaries, it must maintain 'ghost zones' - regions of actual overlap between the partitions. When the data is partitioned into lots of little chunks, as it is in our user&rsquo;s case, the portion of overlap rises, causing it to do significantly more work.

Next, when the data is distributed, a final image is created by having each process render its local data, then compositing (with depth) to resolve a single image that&rsquo;s correct with respect to all the data. This adds quite a significant overhead to the rendering process, which is engaged whenever you move the viewpoint - which in interactive use happens way more often than, say, computing a new isosurface.

Finally, in most cases our large-scale systems (Stampede2, Lonestar6 and Frontera) do not use GPUs for rendering. Instead, we use a software rendering library which is optimized to run on lots of cores and to use the full SIMD architecture of each. When there are lots of processes on each node, the number of cores available to each for rendering is small. Even if we did use GPUs, though, again - lots of processors per node would cause contention for the GPU resources and would still require compositing.

While we wish there was a magic way to optimize Paraview in parallel,  there's not.  The best balance depends on the amount of data being read, the amount of geometry processing required, and the number of rendered frames per timestep that will be needed.  We generally advise users that the big win of running Paraview in parallel is that you get the aggregate bandwidth into memory and the aggregate total memory.  A useful rule of thumb is to use enough nodes to acquire maybe 4x the in-memory size of the input data, and hope that the high-water mark (remember, as you pass your data through PV filters, the intermediate data all increases Paraview's total memory footprint) and then allocate no more than 4-8 processes per node.

### Running ParaView In Batch Mode

Paraview can also be run in batch mode, generally from an idev session or launched using a job script and sbatch.    In this case you use Paraview through Python; Paraview includes the pvbatch executable to do so.   The only difference in the required module stack is that you load the paraview-osmesa module rather than paraview so that it can run without a connection to a desktop.

To run pvbatch serially or in parallel using idev, start a idev session:

        login2.stampede2(1001)$ idev -N [nNodes] -n {nTasks} -A {allocation} -p {queue}

        &hellip; lots of stuff&hellip;

        Last login: Tue Apr  5 13:58:01 2022 from login2.stampede2.tacc.utexas.edu

TACC Stampede2 System

Provisioned on 24-May-2017 at 11:49

 

c455-003[knl](1001)$ module load impi qt5 swr oneapi_rk paraview-osmesa



At that compute-node prompt you can run pvbatch and give it your Python script.   As an example, if your Python script is tt.y containing:

        from paraview.simple import *

        Sphere()

        Show()

        SaveScreenshot(&ldquo;tt.png&rdquo;)

Then you can run it:

c455-003[knl](1004)$ ibrun swr pvbatch tt.py

TACC:  Starting up job 9553190 

TACC:  Starting parallel tasks... 

&hellip;ignore messages&hellip;

TACC:  Shutdown complete. Exiting. 

The scary looking text that emerges can be ignored.

This will create a file named &lsquo;tt.png&rsquo; containing an image of a sphere:

<figure id="figure3"><img alt="paraview-visit-3.png" src="../../imgs/software/paraview-visit-3.png"><figcaption></figcaption></figure>

#### Notes from the Vis Team

While one can write one&rsquo;s own Paraview/Python script by hand, it is often convenient to create a visualization using the Paraview GUI then run it in batch mode.   To do so, save your Paraview state as a Python script, then modify the script (by hand) to write images or save data as required.   For more information see <a href="https://www.paraview.org/Wiki/ParaView/Python_Scripting">https://www.paraview.org/Wiki/ParaView/Python_Scripting</a>

You can also modify this script to, for example, take command line arguments to vary input and output file names etc.   It is also convenient to modify this script to iterate through datasets.

## VisIt 

Parallel VisIt is an Open Source, interactive, scalable, visualization, animation and analysis tool. Users can quickly generate visualizations, animate them through time, manipulate them with a variety of operators and mathematical expressions, and save the resulting images and animations for presentations. VisIt contains a rich set of visualization features to enable users to view a wide variety of data including scalar and vector fields defined on two- and three-dimensional (2D and 3D) structured, adaptive and unstructured meshes. Owing to its customizable plugin design, VisIt is capable of visualizing data from over 120 different scientific data formats.

VisIt is installed on TACC&rsquo;s Frontera, Stampede2, and Lonestar6 resources. The environment required to run VisIt on each of these resources is slightly different. The user will use the module command to load the required environment for VisIt. 

Table 2. VisIt Modules per TACC Resource

<table><tr><td colspan="1" rowspan="1">

Resource</td><td colspan="1" rowspan="1">

Versions Installed</td><td colspan="1" rowspan="1">

Module requirements</td></tr><tr><td colspan="1" rowspan="1">

Frontera</td><td colspan="1" rowspan="1">

2.13.2, 3.0.1, 3.1.2**</td><td colspan="1" rowspan="1">

intel/19, impi, swr*, qt5*, VisIt</td></tr><tr><td colspan="1" rowspan="1">

Stampede2</td><td colspan="1" rowspan="1">

2.13.0, 2.13.2, 3.2.1**</td><td colspan="1" rowspan="1">

intel/18, impi, swr*, VisIt</td></tr><tr><td colspan="1" rowspan="1">

Lonestar6</td><td colspan="1" rowspan="1">

3.3.0**</td><td colspan="1" rowspan="1">

gcc, impi, VisIt</td></tr></table>

*Environment managed by VisIt module

**Default VisIt version on resource

The table above summarizes the version of VisIt installed and the modules required to run it on each TACC resource. All the modules listed for a particular resource must be loaded for VisIt to run correctly. The VisIt module itself manages loading and unloading of certain dependencies on certain resources. Modules that are automatically loaded by the VisIt module are marked with an * in Table 2. There is no need to explicitly load  modules managed by VisIt. 

Starting the VisIt user interface on TACC resources is very similar to starting Paraview. The user should follow the procedure for starting a remote desktop described in the Paraview documentation [above](). 

Once a remote desktop is running the user will start the VisIt user interface by typing commands into a shell window on that desktop. The commands required are summarized in the table below. The column labeled &ldquo;Load Modules&rdquo; contains commands required to load the environment on the particular resource. The column labeled &ldquo;Run VisIt&rdquo; contains the command required to launch the user interface. In both columns the text &ldquo;c442-001$&rdquo; is simply the command prompt in the shell window. 

### Table 3. Running VisIt

<table>
<tr>
<th>Resource</td>
<th>Load Modules</td>
<th>Run VisIt</td>
</tr><tr>
<td>Frontera</td>
<td><code>c442-001$ module load intel<br>c442-001$ module load impi<br>c442-001$ module load visit</code></td>
<td><code>c442-001$ swr -p 1 visit</code></td>
</tr><tr>
<td> Stampede2</td>
<td> c442-001$ module load intel<br>c442-001$ module load impi<br>c442-001$ module load visit<br>c442-001$ export GALLIUM_DRIVER=swr</td>
<td>c442-001$ visit</td>
</tr><tr>
<td>Lonestar6</td>
<td>c442-001$ module load gcc<br>c442-001$ module load impi<br>c442-001$ module load visit</td>
<td>c442-001$ visit</td></tr></table>

Consider starting VisIt on Stampede2 as an example. The user should load the intel, impi, and visit modules as indicated by the commands in the Table 3. In addition the user should set the GALLIUM_DRIVER to a value of swr (export GALLIUM_DRIVER=swr). Once that is done the user types the visit command at the command prompt as shown in Table 3. The user interface should appear on the desktop.

It is beyond the scope of this document to describe how to utilize VisIt for analysis once it is started. There is a great deal of online information available on that topic. The user is directed to <a href="https://visit-dav.github.io/visit-website/index.html">The VisIt Github Page</a>, <a href="https://visit-sphinx-github-user-manual.readthedocs.io/en/develop/index.html">VisIt User Guide</a>, and <a href="https://visit-dav.github.io/visit-website/pdfs/GettingDataIntoVisIt2.0.0.pdf?%23page%3D1">Getting Data Into VisIt</a> for more information on using VisIt. We do provide the following notes related to specifics of using VisIt on TACC resources. 

#### Notes: 

* The module load command will load the most recent version of a module if no version number is specified. 
* Loading the compiler family (intel, gcc) will modify the currently loaded mpi family as necessary. 
* Launching VisIt on Frontera requires the use of the swr prepend. The argument -p n specifies the number of mpi tasks (n=1 in this case) per node that VisIt will use. This flag is used by the software renderer to determine the number of threads used by the swr software renderer. The number of rendering cores = cores per node / n. 
* The total number of mpi ranks used by VisIt is determined by the characteristics of the resource requested when the remote desktop was started. VisIt will start a parallel engine consisting of n total mpi ranks distributed across N nodes where the values of N and n correspond to the number of nodes and procs requested by the remote desktop startup procedure. 
* The parallel analysis engine is launched after the user selects a plot type and presses the draw button. At that time VisIt will present the user with a dialog with controls to select either a parallel or serial engine. Parallel is default. There are also controls in that dialog to select the number of Nodes and processes. These values have no effect. Changing the number of nodes in the dialog will not change the number of nodes in the analysis due to the fact that the resource is allocated during startup of the remote desktop. 
* VisIt can be used in batch mode via a python interpreter. See the <a href="https://visit-sphinx-github-user-manual.readthedocs.io/en/develop/python_scripting/index.html">scripting section</a> of the VisIt User Guide for more information. 

#### Preparing Data for Parallel Visit

VisIt reads <a href="https://github.com/visit-dav/visit/tree/develop/src/databases">nearly 150 data formats</a>. Except in some limited circumstances (particle or rectilinear meshes in ADIOS, basic netCDF, Pixie, OpenPMD and a few other formats), VisIt piggy-backs its parallel processing off of whatever static parallel decomposition is used by the data producer. This means that VisIt expects the data to be explicitly partitioned into independent subsets (typically distributed over multiple files) at the time of input. Additionally, VisIt supports a metadata file (with a .visit extension) that lists multiple data files of any supported format that hold subsets of a larger logical dataset. VisIt also supports a &ldquo;brick of values (bov)&rdquo; format which supports a simple specification for the static decomposition to use to load data defined on rectilinear meshes. For more information on importing data into VisIt, see <a href="https://visit-dav.github.io/visit-website/pdfs/GettingDataIntoVisIt2.0.0.pdf">Getting Data Into VisIt</a>.

## Help 

To get answers to questions about using Paraview or VisIt on TACC resources please [create a support ticket][HELPDESK] with TACC consulting via the [TACC User Portal][TACCUSERPORTAL].


{% include 'aliases.md' %}
