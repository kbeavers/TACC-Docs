<style>.help{box-sizing:border-box}.help *,.help *:before,.help *:after{box-sizing:inherit}.row{margin-bottom:10px;margin-left:-15px;margin-right:-15px}.row:before,.row:after{content:" ";display:table}.row:after{clear:both}[class*="col-"]{box-sizing:border-box;float:left;position:relative;min-height:1px;padding-left:15px;padding-right:15px}.col-1-5{width:20%}.col-2-5{width:40%}.col-3-5{width:60%}.col-4-5{width:80%}.col-1-4{width:25%}.col-1-3{width:33.3%}.col-1-2,.col-2-4{width:50%}.col-2-3{width:66.7%}.col-3-4{width:75%}.col-1-1{width:100%}article.help{font-size:1.25em;line-height:1.2em}.text-center{text-align:center}figure{display:block;margin-bottom:20px;line-height:1.42857143;border:1px solid #ddd;border-radius:4px;padding:4px;text-align:center}figcaption{font-weight:bold}.lead{font-size:1.7em;line-height:1.4;font-weight:300}.embed-responsive{position:relative;display:block;height:0;padding:0;overflow:hidden}.embed-responsive-16by9{padding-bottom:56.25%}.embed-responsive .embed-responsive-item,.embed-responsive embed,.embed-responsive iframe,.embed-responsive object,.embed-responsive video{position:absolute;top:0;bottom:0;left:0;width:100%;height:100%;border:0}</style>
/ Si Liu, Wenyang Zhang, Susan Lindsey
/ https://portal.tacc.utexas.edu/software/ansys
<span style="font-size:225%; font-weight:bold;">ANSYS at TACC</span><br>
<span style="font-size:90%"><i>Last update: March 8, 2022</i></span><br>


%table(cellspacing="3" cellpadding="5")
	%tr
		%td <img alt="ANSYS logo" src="/documents/10157/1667013/ansys-logo-new.png/7097cb16-1554-412f-856b-714d70de262f?t=1595002409050" style="width: 125px; height: 50px;" />
		%td ANSYS offers a comprehensive software suite that spans the entire range of physics, providing access to virtually any field of engineering simulation that a design process requires. ANSYS sofware is used to simulate computer models of structures, electronics, or machine components for analyzing strength, toughness, elasticity, temperature distribution, electromagnetism, fluid flow, and other attributes.

#top
	:markdown
		ANSYS is installed at TACC and is currently installed on TACC's [Frontera](https://fronteraweb.tacc.utexas.edu/user-guide), [Lonestar6](/user-guides/lonestar6) and [Stampede2](/user-guides/stampede2) resources. 

#licenses
	:markdown
		# [ANSYS Licenses](#licenses)

		TACC's current ANSYS license allows TACC users to access ANSYS for **non-commercial**, **academic** use. If you would like access to ANSYS, [submit a help desk ticket](https://portal.tacc.utexas.edu/tacc-consulting/-/consult/tickets/create) through the [TACC User Portal](https://portal.tacc.utexas.edu/). Include in your ticket your institutional affiliation and a brief statement confirming that you will use ANSYS only for **non-commercial**, **academic** purposes. If you are affiliated with the University of Texas, include your academic department in your help desk ticket.

		If you have your own ANSYS licenses or would like to install your own copy, you are allowed to do so.

#installations
	:markdown
		# [ANSYS Installations](#installations)

		ANSYS is currently installed under `/home1/apps/ANSYS` on TACC's Frontera and Stampede2, and `/scratch/tacc/apps/ANSYS` on TACC's Lonestar6 resources. Installations on Frontera and Stampede2 include the main components: Structures, Fluids, Electronics and LS-Dyna. However, installations on Lonestar6 only include Structures, Fluids and LS-Dyna. Electronics is not included since it is not supported on LS6’s operating system. All packages are installed under the default locations based on the ANSYS naming convention. Table 


#table1
	:markdown
		[Table 1. ANSYS Installations at TACC](#table1)

%table(border="1" cellpadding="5" cellspacing="3")
	%tr
		%td
		%th ANSYS Version
		%th Components
		%th Location
	%tr
		%td Frontera
		%td 2021R2
		%td Structures, Fluids, Electronics, LS-Dyna
		%td <code>/home1/apps/ANSYS/2021R2/v212</code><br><code>/home1/apps/ANSYS/2021R2/AnsysEM21.2</code>
	%tr
		%td Stampede2
		%td 2021R2
		%td Structures, Fluids, Electronics, LS-Dyna
		%td <code>/home1/apps/ANSYS/2021R2/v212</code><br><code>/home1/apps/ANSYS/2021R2/AnsysEM21.2</code>
	%tr
		%td Lonestar6
		%td 2022R1
		%td Structures, Fluids, LS-Dyna
		%td <code>/scratch/tacc/apps/ANSYS/2022R1/v221</code>

#running
	:markdown
		# [Running ANSYS](#running)

#running-interactive
	:markdown
		## [Interactive Mode](#running-interactive)

		ANSYS can be launched with the ANSYS GUI used in interactive mode. Use the [TACC Vis Portal](https://vis.tacc.utexas.edu/) or create a VNC session following the directions in the [Remote Desktop Access](https://portal.tacc.utexas.edu/user-guides/stampede2#vis-remote) section.

		<p class="portlet-msg-alert">Do NOT launch ANSYS, or any other codes, on the login nodes.</p>

		ANSYS is managed under [Lmod](https://lmod.readthedocs.io/en/latest/) Environmental Module System on TACC resources. Within the VNC session, load the ANSYS module with the following command:

		<pre class="cmd-line">$ <b>module load ansys</b></pre>
		
		You can always get the help information using the module's &quot;<b>`help`</b>&quot; command:

		<pre class="cmd-line">$ <b>module help ansys</b></pre>

		Launch the ANSYS GUI within the VNC session:

		<pre class="cmd-line">$ <b>/home1/apps/ANSYS/2021R2/v212/ansys/bin/launcher212</b></pre>

%figure
	<img alt="ANSYS1" src="/documents/10157/1667013/ANSYS-1.png/c6fe1061-e8eb-467d-94cb-302fba50ec18?t=1638564405000" style="width: 700px; height: 588px; border-width: 1px; border-style: solid;" />
	%figcaption
		Figure 1. Commands to run Ansys Mechanical Ansys Parametric Design Language (APDL) jobs


#running-batch
	:markdown
		## [Batch Mode](#running-batch)

		You can also submit your ANSYS job to the batch nodes (compute nodes) on TACC resources. To do so, first make sure that the ANSYS module has been loaded, and then launch your ANSYS programs as shown in the sample Frontera job script below.

		<pre class="job-script">
		#!/bin/bash
		#SBATCH -J ansysjob              # job name
		#SBATCH -e ansysjob.%j.err       # error file name 
		#SBATCH -o ansysjob.%j.out       # output file name 
		#SBATCH -N 1                     # request 1 node
		#SBATCH -n 56                    # request 56 cores 
		#SBATCH -t 01:00:00              # designate max run time 
		#SBATCH -A myproject             # charge job to myproject 
		#SBATCH -p normal                # designate queue 
		
		module load ansys
		# STYLEBLUEYour-ANSYS-COMMAND-HEREESPAN
		# Define your working directory
		MY_JOB_DIR = /scratch1/01234/joe/Ansys_test
		
		# Run ANSYS Job
		&quot;/home1/apps/ANSYS/v201/ansys/bin/mapdl&quot; \
				-p ansys -dis -mpi INTELMPI -np 56 -lch    \
				-dir &quot;STYLEBLUE$MY_JOB_DIRESPAN&quot; \
				-j &quot;Ansys_test&quot; -s read -l en-us -b \
				&lt; &quot;STYLEBLUE$MY_JOB_DIR/Ansys_test_input.txtESPAN&quot; &gt; &quot;STYLEBLUE$MY_JOB_DIR/Ansys_test_output.outESPAN&quot;</pre>

		To obtain the correct STYLEBLUE`Your-ANSYS-COMMAND-HERE`ESPAN, launch the ANSYS GUI used in interactive mode. Here, we use the ANSYS Mechanical APDL as an example. After entering the correct *Working directory*, *Job Name*, *Input File*, *Output File*, and *Number of Processors*, you can click Tools and then Display Command Line to get the complete command to run ANSYS jobs in batch mode. No "`ibrun`" or "`mpirun`" command is needed for running ANSYS jobs.

		Other ANSYS binaries, e.g. Aqwa, CFX, Fluent, can be found at `/home1/apps/ANSYS/2021R2/v212`. 
			
#table2
	:markdown
		[Table 2. ANSYS Binaries Location](#table2)

%table(border="1" cellpadding="5" cellspacing="3")
	%tr
		%th(align="right") Aqwa: 
		%td /home1/apps/ANSYS/2021R2/v212/aqwa/bin/linx64
	%tr
		%th(align="right") Autodyn: 
		%td /home1/apps/ANSYS/2021R2/v212/autodyn/bin
	%tr
		%th(align="right") CFX: 
		%td /home1/apps/ANSYS/2021R2/v212/CFX/bin
	%tr
		%th(align="right") Electronics: 
		%td /home1/apps/ANSYS/2021R2/v212/Electronics/Linux64
	%tr
		%th(align="right") Fluent: 
		%td /home1/apps/ANSYS/2021R2/v212/fluent/bin
	%tr
		%th(align="right") Icepak: 
		%td /home1/apps/ANSYS/2021R2/v212/Icepak/bin
	%tr
		%th(align="right") LS-Dyna: 
		%td /home1/apps/ANSYS/2021R2/v212/ansys/bin


			
:markdown
	<p>In the figure below, the small window on top displays the command to run an ANSYS Mechanical job through the command line, which corresponds to the information (i.e., Working directory, Job Name, Input File, Output File) entered on the bottom.

%figure
	<img alt="ANSYS" src="/documents/10157/1667013/ANSYS-2/bfa7efd0-14ba-4ef0-aeb4-bfab740f7969?t=1638564447000" style="width: 700px; height: 588px; border-width: 1px; border-style: solid;" /></p>
	%figcaption
		Figure 2. Ansys Mechanical Ansys Parametric Design Language (APDL) Product Launcher 
		

:markdown
	Submit the job to the Slurm scheduler in the standard way. Consult each resource's "Running Jobs" section in the respective user guide.

#table3
	:markdown
		[Table 3. User Guides - Running Jobs](#table3)

%table(border="1" cellpadding="3")
	%tr 
		%td Frontera
		%td <code>login1$ <b>sbatch myjobscript</b></code>
		%td <a href="https://fronteraweb.tacc.utexas.edu/user-guide/running/">Running Jobs on Frontera</a>
	%tr
		%td Stampede2</td>
		%td <code>login1$ <b>sbatch myjobscript</b><code>
		%td <a href="https://portal.tacc.utexas.edu/user-guides/stampede2#running">Running Jobs on Stampede2</a>
	%tr
		%td Lonestar6</td>
		%td <code>login1$ <b>sbatch myjobscript</b><code>
		%td <a href="https://portal.tacc.utexas.edu/user-guides/lonestar6#running">Running Jobs on Lonestar6</a>

#refs
	:markdown
		# [References](#refs)


		* [Remote Desktop Access at TACC](/tutorials/remote-desktop-access)
		* ANSYS is a commercial package. If you have further scientific or technical questions, <a href="https://support.ansys.com/portal/site/AnsysCustomerPortal">contact ANSYS support</a> directly.
		* [TACC Software](/software)

