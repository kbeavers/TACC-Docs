<span style="font-size:225%; font-weight:bold;">Remote Desktop Access via DCV and VNC Connections</span><br>
<i>Last update: December 05, 2019</i>
  
#top
	:markdown
		<p>Establishing a remote desktop connection from one system to another allows the desktop on the remote computer (TACC resources) to be displayed on the local system (your desktop). For HPC purposes remote desktops are used for [visualization applications](/user-guides/stampede2#vis) and other [graphics-library enabled applications](/software/ddt).  

#methods
	:markdown
		# [Remote Desktop Methods](#methods)
	
		TACC provides three methods of setting up a remote desktop:

		1. **VNC connection**: A (**V**irtual **N**etwork **C**omputing) VNC connection allows you to harness TACC resources' compute or visualization nodes to display an image on your own desktop display. After logging on, submit a special interactive batch job that:

			* allocates one or more compute <!-- or visualization (Maverick)--> nodes
			* starts a `vncserver` process on the first allocated node
			* sets up an SSH tunnel through the login node to the vncserver access port

			Once the `vncserver` process is running on the compute node and a tunnel through the login node is created, the job script writes the connection port to the job output file, `vncserver.out`. Then, connect the VNC viewer application to that port. The remote system's desktop is then presented.  
		1. **TACC Vis Portal**: Available to Frontera and Stampede2 users, the [TACC Vis Portal](http://vis.tacc.utexas.edu) provides an easy-to-use web interface to submit a VNC job script.

		1. **DCV connection**: **D**esktop **C**loud **V**isualization (DCV) traffic is encrypted using Transport Layer Security (TLS) through your web browser, obviating the need to create a separate SSH tunnel. A DCV connection is easier to set up than a VNC connection, however TACC is limited to the number of concurrent DCV licenses. Stampede2 and Frontera are currently the only TACC resources allowing DCV connections. The DCV job script writes connection information to a file, `dcvserver.out`. You can connect to a DCV session with any modern web browswer.



#visportal
	:markdown
		# [TACC Vis Portal](#visportal)

		Connect to the TACC Vis Portal at <https://vis.tacc.utexas.edu>. Any user with an allocation on Frontera or Stampede2 may use the portal.  


#figure0
	.row
		.col-1-1
			%figure
				<img alt="TACC Vis Portal" src="/documents/10157/1647285/TACCVisPortal.png/53f26c8a-2114-4db9-8b28-6a9e6b5d9d7b?t=1542041397296" style="height: 500px; width: 800px;" />  
				%figcaption 
					Figure 0. TACC Visualization Portal

#jobscripts
	:markdown
		# [DCV & VNC at TACC](#jobscripts)

		TACC resources [Frontera](https://fronteraweb.tacc.utexas.edu/user-guide), [Stampede2](/user-guides/stampede2), [Lonestar5](/user-guides/lonestar5), and [Maverick2](/user-guides/maverick2) all offer remote desktop capabilities via a VNC (Virtual Network Computing) connection. Frontera and Stampede2 also provide remote desktop access through a DCV (Desktop Cloud Visualization) connection to one or more nodes.  

		TACC has a limited number of DCV licenses available, so concurrent DCV sessions may be limited. TACC has provided two DCV job scripts for two different scenarios:

		* `/share/doc/slurm/job.dcv2vnc` 	- request a DCV session, if none is available, then a VNC session is submitted
		* `/share/doc/slurm/job.dcv`		- request a DCV session, if none is available, then exit

		You can modify or overwrite script defaults with `sbatch` command-line options:

		* "<code>-t <i>hours:minutes:seconds</i></code>" modify the job runtime 
		* "<code>-A <i>projectname</i></code>" specify the project/allocation to be charged 
		* "<code>-N <i>nodes</i></code>" specify number of nodes needed  
		* "<code>-p <i>partition</i></code>" specify an alternate queue 

		See more `sbatch` options in the [Stampede2 User Guide: Common `sbatch` Options](/user-guides/stampede2#table6)

#table1
	:markdown
		## [Table 1. Job Scripts](#table1)

	%table(border="1" cellpadding="3")
		%tr
			%th System
			%th Connection Type
			%th Script Location
			%th Description of Default Behavior

		%tr
			%th(rowspan="3") Frontera
			%td(align="center") DCV
			%td <code>/share/doc/slurm/job.dcv</code>
			%td Requests a DCV session, if no license is available then the job exits.<br> Requests 1 node for 2 hours in Frontera's <code>development</code> queue

		%tr
			%td(align="center") DCV
			%td(nowrap) <code>/share/doc/slurm/job.dcv2vnc</code>
			%td Requests a DCV session, but if no DCV licenses are available then a VNC session is submitted.<br>Requests 1 node for 2 hours Frontera's <code>development</code> queue

		%tr
			%td(align="center") VNC
			%td <code>/share/doc/slurm/job.vnc</code>
			%td Requests 1 node for 2 hours in Frontera's <code>development</code> queue

		%tr
			%th(rowspan="3") Stampede2
			%td(align="center") DCV
			%td <code>/share/doc/slurm/job.dcv</code>
			%td Requests a DCV session, if no license is available then the job exits.<br>Requests 1 node for 2 hours in Stampede2's <a href="/user-guides/stampede2#running-queues"><code>skx-dev</code></a> queue
		
		%tr
			%td(align="center") DCV
			%td(nowrap) <code>/share/doc/slurm/job.dcv2vnc</code>
			%td Request a DCV session, tried to launch a DCV session but if none is available then a VNC session is submitted.<br>Requests 1 node for 2 hours Stampede2's the <a href="/user-guides/stampede2#running-queues"><code>skx-dev</code></a> queue
		%tr
			%td(align="center") VNC
			%td <code>/share/doc/slurm/job.vnc</code>
			%td Requests 1 node for 2 hours in Stampede2's <a href="/user-guides/stampede2#running-queues"><code>skx-dev</code></a> queue
		%tr
			%th(nowrap) Lonestar5
			%td(align="center") VNC
			%td <code>/share/doc/slurm/job.vnc</code>
			%td Requests 1 node for 2 hours in Lonestar5's <a href="/user-guides/lonestar5#running-queues"><code>development</code></a> queue.
		%tr
			%th Maverick2
			%td(align="center") VNC
			%td <code>/share/doc/slurm/job.vnc</code>
			%td Requests 1 node, with 68 MPI tasks, for 4 hours in Maverick2's <a href="/user-guides/maverick2#running-queues"><code>gtx</code></a> queue.

#dcv
	:markdown
		# [Start a DCV Session](#dcv)

		Both Frontera and Stampede2 allow DCV connections. Follow the steps below to start an interactive DCV session on either resource. The command-line examples below demonstrate creating a session on Stampede2. You can follow the same steps to establish a session on Frontera.
    
		1. **Connect to Stampede2 or Frontera in your usual manner**, e.g.:

			<pre class="cmd-line">
			login1$ <b>ssh -l <i>username</i> stampede2.tacc.utexas.edu</b>

		1. **Submit one of two standard job scripts.** If you submit the `job.dcv2vnc` script, then either a DCV or VNC session is created. The following instructions demonstrate submitting the `job.dcv` script.  

			Copy into your home directory, then edit either of the job scripts listed above to include your project allocation:

			<pre class="job-script">#SBATCH -A <i>projectname</i></pre>

			or you can provide the allocation number on the command line as an argument to the `sbatch` command:

			<pre class="syntax">
			sbatch -A <i>projectname</i> /share/doc/slurm/job.dcv
			sbatch -A <i>projectname</i> /share/doc/slurm/job.dcv2vnc</pre>

			In the following example we also override the time option, requesting one hour instead of the script's default of two hours.

			<pre class="cmd-line">
			login4(689)$ <b>sbatch -A <i>projectname</i> -t 01:00:00 /share/doc/slurm/job.dcv</b>
			...
			--> Verifying access to desired queue (skx-dev)...OK
			--> Verifying job request is within current queue limits...OK
			--> Checking available allocation (TG-123456)...OK
			Submitted batch job STYLEBLUE1965942ESPAN</pre>
			
		1. **Poll the queue, waiting till the job runs...**

			You can poll the job's status with the "`squeue`" command, waiting till the submitted job actually runs, or by waiting for the job output file, (`dcvserver.out` or `vncserver.out` depending on the connection type and job script submitted), to appear in the submission directory.  

			<pre class="cmd-line">
			login4(690)$ <b>squeue -u slindsey</b>
			  JOBID   PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
			1965942     skx-dev dcvserve slindsey  STYLEBLUERESPAN       0:16      1 c506-082</pre>

			If your job could not acquire a DCV license and launched a VNC session instead, jump to step 3 of the [VNC connection instructions](#vnc) below.

		1. **Display the contents of the job output file to extract the web URL.**

			Once the DCV job starts running, a file called `dcvserver.out` will be created in the submission directory.  

			<pre class="cmd-line">
			login4(691)$ <b>cat dcvserver.out</b>
			TACC: job 1965942 execution at: Tue Aug 21 14:25:54 CDT 2018
			TACC: running on node c506-082
			TACC: local (compute node) DCV port is 8443
			TACC: got login node DCV port 18606
			TACC: Created reverse ports on Stampede2 logins
			TACC: Your DCV session is now running!
			TACC: To connect to your DCV session, please point a modern web browser to:
			TACC:          STYLEBLUEhttps://stampede2.tacc.utexas.edu:18606ESPAN</pre>


		1. **Load this generated URL in your favorite browser and then authenticate using your Stampede2 or Frontera password**. 

	.row
		.col-1-1
			%figure
				<img alt="" src="/documents/10157/1647285/DCV1.png/56b72b62-3782-4951-8b62-7e39fb4e708a?t=1534881499000" style="width: 800px; height: 360px;" /> 
				%figcaption 
					Figure 1. Authenticate with your Stampede2 password.

	:markdown
		6. **Start your graphics-enabled application.** Once the desktop is generated ([Figure 2.](#figure2)), you can launch your applications. Here we run a simple visualization program, `glxgears`. ([Figure 3.](#figure3))

			**Note:** The "Terminal" button at the bottom of the DCV window creates a terminal **without `ibrun` support**. To create an xterm with full `ibrun` support, type "`xterm &`" in the initial xterm window.

#figure2
	.row
		.col-1-1
			%figure
				<img alt="" src="/documents/10157/1647285/DCV2.png/1159b27c-63bd-46c8-b430-7b335aad96ce?t=1534881747000" style="width: 800px; height: 480px;" />
				%figcaption 
					Figure 2. DCV Desktop in Chrome Browser
#figure3
	.row
		.col-1-1
			%figure
				<img alt="" src="/documents/10157/1647285/DCV3.png/4a011f2a-8eb4-48c8-82c1-37b19ba91cda?t=1534881856000" style="width: 800px; height: 480px;" />
				%figcaption 
					Figure 3. Run a visualization application

	:markdown
		7. Once you've completed your work and closed the browser window, remember to kill the job you submitted in Step 2.
		
			<pre class="cmd-line">
			login4(692)$ <b>scancel 1965942</b>
			login4(693)$ <b>exit</b></pre>

#vnc
	:markdown
		# [Start a VNC Session](#vnc)

		Follow the steps below to start an interactive session.

		**Note**: If this is your first time connecting to a resource, you must run `vncpasswd` to create a password for your VNC servers. This should NOT be your login password! This mechanism only deters unauthorized connections; it is not fully secure, as only the first eight characters of the password are saved. All VNC connections are tunneled through SSH for extra security, as described below.

		1. **Connect to the TACC resource in your usual manner, e.g.:**

			<pre class="cmd-line">login1$ <b>ssh -l slindsey ls5.tacc.utexas.edu</b></pre>

		1. **Submit the standard job script**, `job.vnc`, see [Table 1.](#table1).  

			TACC has provided a VNC job script (`/share/doc/slurm/job.vnc`) that requests one node in the [`development` queue](#running-queues) for two hours.

			<pre class="cmd-line">login1$ <b>sbatch /share/doc/slurm/job.vnc</b></pre>

			All arguments after the job script name are sent to the `vncserver` command. For example, to set the desktop resolution to 1440x900, use:

			<pre class="cmd-line">login1$ <b>sbatch /share/doc/slurm/job.vnc -geometry 1440x900</b></pre>

		1. **Poll and wait till the job runs...**

			<pre class="cmd-line">
			login1$ <b>squeue -u slindsey</b>
			&nbsp;&nbsp;JOBID   PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
			1974882 development vncserve slindsey  STYLEBLUERESPAN       0:16      1 c455-084</pre>

		1. **Display the job's output file, `vncserver.out`, to extract the port connection number:**

			The "`job.vnc`" script starts a vncserver process and writes the connect port for the vncviewer to the output file, "`vncserver.out`" in the job submission directory. 

			The lightweight window manager, `xfce`, is the default VNC desktop and is recommended for remote performance. Gnome is available; to use gnome, open the "`~/.vnc/xstartup`" file (created after your first VNC session) and replace "`startxfce4`" with "`gnome-session`". Note that gnome may lag over slow internet connections.

		1. **Create an SSH Tunnel to Stampede2**

			TACC requires users to create an SSH tunnel from the local system to the Stampede2 login node to assure that the connection is secure. On a Unix or Linux system, execute the following command once the port has been opened on the Stampede2 login node:

			In a new local terminal window, create the SSH tunnel:

			<pre class="cmd-line">
			localhost$ <b>ssh -f -N -L <i>xxxx</i>:STAMPEDEHOSTNAME:<i>yyyy</i> \
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;username@STAMPEDEHOSTNAME</b></pre>

			where

			*  "<code><i>yyyy</i></code>" is the port number given by the vncserver batch job 
			*  "<code><i>xxxx</i></code>" is a port on the remote system. Generally, the port number specified on the Stampede2 login node, <code><i>yyyy</i></code>, is a good choice to use on your local system as well 
			*  "`-f`" instructs SSH to only forward ports, not to execute a remote command 
			*  "`-N`" puts the `ssh` command into the background after connecting 
			*  "`-L`" forwards the port 

			On Windows systems find the menu in the Windows SSH client where tunnels can be specified, and enter the local and remote ports as required, then `ssh` to Stampede2.

		1. **Connect the VNC viewer**

			Once the SSH tunnel has been established, use a [VNC client](https://en.wikipedia.org/wiki/Virtual_Network_Computing) to connect to the local port you created, which will then be tunneled to your VNC server on Stampede2. Connect to <code>localhost:<i>xxxx</i></code>, where <code><i>xxxx</i></code> is the local port you used for your tunnel. In the examples above, we would connect the VNC client to <code>localhost::<i>xxxx</i></code>. (Some VNC clients accept <code>localhost:<i>xxxx</i></code>).

			<p class="portlet-msg-info">TACC staff recommends the [TigerVNC](http://sourceforge.net/projects/tigervnc/) VNC Client, a platform independent client/server application.</p>

		
#figure4
	.row
		.col-1-1
			%figure
				<img alt="" src="/documents/10157/1647285/VNC1.png/29ddb44e-041a-409b-9295-5f14eced9a7d?t=1535044016783" style="width: 800px; height: 661px;" /> 
				%figcaption 
					Figure 4. Connect the VNC client to the local port created in step 5.

	:markdown
		6. Once the desktop is generated (Figure 5.), you can start your graphics-enabled application. Here we run a simple visualization program, `glxgears`. (Figure 6.)

#figure5
	.row
		.col-1-1
			%figure
				<img alt="" src="/documents/10157/1647285/VNC2.png/0b0fa2a2-e678-4040-ad54-a381cf49cbef?t=1535044017822" style="width: 800px; height: 661px;" /> 
				%figcaption 
					Figure 5. VNC Desktop
#figure6
	.row
		.col-1-1
			%figure
				<img alt="" src="/documents/10157/1647285/VNC3.png/365b2a01-e06a-4ab5-b6e9-a7eeb60b9644?t=1535044017373" style="width: 800px; height: 661px;" /> 
				%figcaption 
					Figure 6. Run a Visualization Application

	:markdown
		Once the desktop has been established an initial xterm window appears. (Figure 5.) This window manages the lifetime of the VNC server process. Killing this window (typically by typing "`exit`" or "`ctrl-D`" at the prompt) will cause the vncserver to terminate and the original batch job to end. 


	:markdown
		7. Once you've completed your work and closed the browser window, remember to kill the job you submitted in Step 2.
		
			<pre class="cmd-line">
			login4(692)$ <b>scancel 1974882</b>
			login4(693)$ <b>exit</b></pre>

#vncsession
	:markdown
		## [Sample VNC session](#vncsession)  

#vncwindow1
	:markdown
		### [Window 1](#vncwindow1)

		Submit a VNC job for user `slindsey`.

		<pre class="cmd-line">
		localhost$ <b>ssh slindsey@stampede2.tacc.utexas.edu</b>
		&nbsp;...
		login4(804)$ <b>sbatch -A TG-123456 -t 01:00:00 /share/doc/slur m/job.vnc</b>
		&nbsp;...
		&nbsp;--> Verifying access to desired queue (development)...OK
		&nbsp;--> Verifying job request is within current queue limits...OK
		&nbsp;--> Checking available allocation (UserServStaff)...OK
		Submitted batch job STYLEBLUE1974882ESPAN
		login4(805)$ <b>squeue -u slindsey</b>
		&nbsp;&nbsp;JOBID   PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
		1974882 development vncserve slindsey  R       0:16      1 c455-084
		login4(806)$ <b>cat vncserver.out</b> 
		job execution at: Wed Aug 22 15:43:46 CDT 2018
		running on node c455-084
		using default VNC server /bin/vncserver
		memory limit set to 93767542 kilobytes
		set wayness to 
		got VNC display :1
		local (compute node) VNC port is 5901
		got login node VNC port 18455
		Created reverse ports on Stampede2 logins
		Your VNC server is now running!
		To connect via VNC client:  STYLEBLUESSH tunnel port 18455 to stampede2.tacc.utexas.edu:18455ESPAN
		STYLEBLUEThen connect to localhost::18455ESPAN
		login4(807)$ <b>scancel 1974882</b>
		login4(808)$ <b>squeue -u slindsey</b>
		JOBID   PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
		login4(809)$ <b>exit</b>
		logout
		Connection to stampede2.tacc.utexas.edu closed.
		bash-3.2$ <b>exit</b></pre>

#vncwindow2
	:markdown
		### [Window 2](#vncwindow2)

		Create the SSH tunnel from your local machine to Stampede2

		<pre class="cmd-line">
		localhost$ <b>ssh -f -N -L 18455:stampede2.tacc.utexas.edu:18455 slindsey@stampede2.tacc.utexas.edu</b>
		&nbsp;...
		Password:
		TACC Token Code:
		localhost$</pre>

#running
	:markdown
		# [Running Apps on the Desktop](#running)

		From an interactive desktop, applications can be run from icons or from `xterm` command prompts. 

		See the [Stampede2 User Guide Visualization](/user-guides/stampede2#vis) and [Frontera User Guide Visualization](https://fronteraweb.tacc.utexas.edu/user-guide/vis/) sections for details on running parallel applications on the desktop.

#help
	:markdown
/		# [Help](#help)

		

