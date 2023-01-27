/ Si Liu
/ http://portal.tacc.utexas.edu/software/matlab
<span style="font-size:225%; font-weight:bold;">MATLAB at TACC</span><br>
<span style="font-size:90%"><i>Last update: January 15, 2020</i></span>

:markdown
	<p>[Mathwork's](https://www.mathworks.com/) MATLAB is installed and supported at TACC and is available on the following TACC resources: [Frontera](https://fronteraweb.tacc.utexas.edu/user-guide), [Stampede2](http://portal.tacc.utexas.edu/user-guides/stampede2), LONESTARUSERGUIDE, and [Maverick2](/user-guides/maverick2).  

#license
	:markdown
		# [MATLAB Licenses](#license)

		MathWork's agreement with the University of Texas now allows TACC and XSEDE users to access MATLAB for **non-commercial**, **academic** use. If you would like access to MATLAB submit a help desk ticket through either the [TACC](/tacc-consulting/-/consult/tickets/create) or [XSEDE](https://www.xsede.org/group/xup/help-desk) portal. Include in your ticket your institutional affiliation and a brief statement confirming that you will use MATLAB only for **non-commercial**, **academic** purposes. If you are affiliated with the University of Texas, include your academic department in your help desk ticket.
 
		If you have your own network licenses for toolboxes that are not available through the University of Texas, we can help you configure these licenses on TACC systems. Again, submit a help desk ticket for assistance.

#interactive
	:markdown
		# [Running MATLAB in Interactive Mode](#interactive)

		MATLAB is normally launched with the MATLAB Desktop UI and used in interactive mode. Create a VNC session following the directions in the [Remote Desktop Access](https://portal.tacc.utexas.edu/user-guides/stampede2#vis-remote) section.  
		

		MATLAB is managed under modules on the TACC resources. Before you launch MATLAB load the MATLAB module with the following command:
		<pre class="cmd-line">login1$ <b>module load matlab</b></pre>
		You can always get the MATLAB help information by typing the following module help command.
		<pre class="cmd-line">login1$ <b>module help matlab</b></pre>

		The following figure shows how MATLAB is launched inside the VNC session.

#figure1
	:markdown
		[Figure 1. MATLAB launched in a VNC session](#figure1)

		<img alt="" src="/documents/10157/0/MATLAB+VNC+screenshot/df18b1dd-7955-4ca5-bf67-2ff9ef88d56e?t=1401225985423" style="width: 675px; height: 428px;" />

		**IMPORTANT**: Do NOT launch MATLAB on the login nodes. This may fail and, more importantly, it will prevent other users from doing their work, as your execution will take up too many cycles on the shared login node. Using MATLAB on the login nodes is considered system abuse, and will be treated as such.  See TACC [usage policies](USAGEPOLICY).
 
#batch
	:markdown
		# [Running MATLAB in Batch Mode](#batch)

		You can also submit your MATLAB job to the batch nodes (compute nodes) on the TACC resources, e.g. Frontera, Stampede2, Lonestar5, or Maverick2. To do so, first make sure that the MATLAB module has been loaded, and then launch "`matlab`" with the NOWRAP"`-nodesktop -nodisplay -nosplash`"ESPAN option as shown in the sample Stampede2 job script below.

#example1
	:markdown
		[Example 1. Sample MATLAB job script to run on Stampede2](#example1)

		<pre class="job-script">
		#!/bin/bash
		#SBATCH -J matlabjob              # job name
		#SBATCH -e matlabjob.%j.err       # error file name 
		#SBATCH -o matlabjob.%j.out       # output file name 
		#SBATCH -N 1                      # request 1 node
		#SBATCH -n 16                     # request all 16 cores 
		#SBATCH -t 01:00:00               # designate max run time 
		#SBATCH -A myproject              # charge job to myproject 
		#SBATCH -p skx-normal             # designate queue 

		module load matlab
		matlab -nodesktop -nodisplay -nosplash &lt; mymatlabprog.m</pre>

		Then submit the job to the scheduler in the standard way. See the Running Jobs section in the respective user guides

	%table(border="1" cellpadding="3")
		%tr
			%th Frontera
			%td(nowrap) <code>login1$ <b>sbatch myjobscript</b></code>
			%td <a href="https://fronteraweb.tacc.utexas.edu/user-guide/running/">Running jobs on Frontera</a>
		%tr
			%th Stampede2
			%td(nowrap) <code>login1$ <b>sbatch myjobscript</b></code>
			%td <a href="https://portal.tacc.utexas.edu/user-guides/stampede2#running">Running jobs on Stampede2</a>
		%tr
			%th Lonestar5 
			%td(nowrap) <code>login1$ <b>sbatch myjobscript</b></code>
			%td <a href="https://portal.tacc.utexas.edu/user-guides/lonestar5#running">Running jobs on Lonestar5</a>
		%tr
			%th Maverick2 
			%td(nowrap) <code>login1$ <b>sbatch myjobscript</b></code>
			%td <a href="https://portal.tacc.utexas.edu/user-guides/maverick2#running">Running jobs on Maverick2</a>

#parallelmatlab
	:markdown
		# [Parallel MATLAB](#parallelmatlab)

		The parallel computing toolbox is available on the TACC resources as well.  Our MathWorks Total Academic Headcount (TAH) license for the UT-Austin campus does not include MATLAB Distributed Computing Server. Therefore, multi-node parallel operations are not supported.

		The following two examples demonstrate parallel operations using the "`parfor`" and "`matlabpool`" functions. Here are the basic examples.

#example2
	:markdown
		[Example 2. MATLAB `parfor`](#example2)
		<pre>
		Mat=zeros(100,1);
		parfor i = 1:100
		&nbsp;&nbsp;&nbsp;&nbsp;Mat(i) = i*i;
		end</pre>

#example3
	:markdown
		[Example 3. MATLAB `matlabpool`](#example3)

		<pre>
		if (matlabpool('size') ) == 0 
		&nbsp;&nbsp;&nbsp;&nbsp;matlabpool(12);
		else
		&nbsp;&nbsp;&nbsp;&nbsp;matlabpool close;
		&nbsp;&nbsp;&nbsp;&nbsp;matlabpool(12);
		end</pre>

		Consult the [MATLAB Parallel Toolbox](https://www.mathworks.com/products/parallel-computing.html) documentation for detailed descriptions and advanced features.

#toolbox
	:markdown
		# [MATLAB Toolboxes](#toolbox)

		MATLAB, Simulink, and a lot of MATLAB toolboxes are available on the TACC resources.  Listed below is the complete set of Toolboxes on the TACC resources:

	%table(cellpadding="5" cellspacing="5" width="100%")
		%tr
			%td(valign="top") Aerospace Blockset<br>Aerospace Toolbox<br>Bioinformatics Toolbox<br>Communications System Toolbox<br>Computer Vision System Toolbox<br>Control System Toolbox<br>Curve Fitting Toolbox<br>DSP System Toolbox<br>Database Toolbox<br>Econometrics Toolbox<br>Embedded Coder<br>Financial Instruments Toolbox<br>Financial Toolbox<br>Fixed-Point Designer

			%td(valign="top") Fuzzy Logic Toolbox <br>Global Optimization Toolbox <br>HDL Verifier <br>Image Acquisition Toolbox <br>Image Processing Toolbox <br>Instrument Control Toolbox <br>LTE System Toolbox <br>MATLAB Coder <br>MATLAB Compiler <br>MATLAB Compiler SDK <br>MATLAB Report Generator <br>Mapping Toolbox <br>Model Predictive Control Toolbox <br>Neural Network Toolbox

			%td(valign="top") Optimization Toolbox <br>Parallel Computing Toolbox <br>Partial Differential Equation Toolbox <br>Phased Array System Toolbox <br>RF Blockset <br>RF Toolbox <br>Robust Control Toolbox <br>Signal Processing Toolbox <br>SimBiology <br>Simscape <br>Simscape Driveline <br>Simscape Electronics <br>Simscape Fluids <br>Simscape Multibody

			%td(valign="top") Simscape Power Systems <br>Simulink <br>Simulink Check <br>Simulink Coder <br>Simulink Control Design <br>Simulink Coverage <br>Simulink Design Optimization                          <br>Simulink Requirements <br>Stateflow <br>Statistics and Machine Learning Toolbox <br>Symbolic Math Toolbox <br>System Identification Toolbox <br>WLAN System Toolbox <br>Wavelet Toolbox


	:markdown
		To see a complete list of MATLAB, Simulink, and MATLAB Toolboxes and their version information, type the "`ver`" command at the MATLAB prompt

		<pre>>> ver</pre>

#references
	:markdown
		# [Mathworks References](#references)

		Mathworks has an excellent collection of documentation, videos and webinars.

		* [Parallel Computing Overview](https://www.mathworks.com/products/parallel-computing.html)
		* [Parallel Computing Coding Examples](https://www.mathworks.com/products/parallel-computing/code-examples.html)
		* [Parallel Computing Documentation](https://www.mathworks.com/help/distcomp/index.html)
		* [Parallel Computing Tutorials](https://www.mathworks.com/videos/series/parallel-and-gpu-computing-tutorials-97719.html)
		* [Parallel Computing Videos](https://www.mathworks.com/products/parallel-computing/videos.html)
		* [Parallel Computing Webinars](https://www.mathworks.com/products/parallel-computing/webinars.html)

#help
	:markdown
		# [Help](#help)
 
		MATLAB is a commercial product of MathWorks. Please solicit help from Mathworks regarding MATLAB code. If you need any further assistance related to access issues or running issues, contact TACC via the [XSEDE User Portal](https://portal.xsede.org) if you are an XSEDE user.  All other users request help via the <a href="https://portal.tacc.utexas.edu">TACC User Portal</a>. 

