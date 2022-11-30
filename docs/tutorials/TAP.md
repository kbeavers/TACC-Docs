// Paul Navratil, Craig Janssen, Susan Lindsey
// https://portal.tacc.utexas.edu/???
<style type="text/css">.help{box-sizing:border-box}.help *,.help *:before,.help *:after{box-sizing:inherit}.row{margin-bottom:10px;margin-left:-15px;margin-right:-15px}.row:before,.row:after{content:" ";display:table}.row:after{clear:both}[class*="col-"]{box-sizing:border-box;float:left;position:relative;min-height:1px;padding-left:15px;padding-right:15px}.col-1-5{width:20%}.col-2-5{width:40%}.col-3-5{width:60%}.col-4-5{width:80%}.col-1-4{width:25%}.col-1-3{width:33.3%}.col-1-2,.col-2-4{width:50%}.col-2-3{width:66.7%}.col-3-4{width:75%}.col-1-1{width:100%}article.help{font-size:1.25em;line-height:1.2em}.text-center{text-align:center}figure{display:block;margin-bottom:20px;line-height:1.42857143;border:1px solid #ddd;border-radius:4px;padding:4px;text-align:center}figcaption{font-weight:bold}.lead{font-size:1.7em;line-height:1.4;font-weight:300}.embed-responsive{position:relative;display:block;height:0;padding:0;overflow:hidden}.embed-responsive-16by9{padding-bottom:56.25%}.embed-responsive .embed-responsive-item,.embed-responsive embed,.embed-responsive iframe,.embed-responsive object,.embed-responsive video{position:absolute;top:0;bottom:0;left:0;width:100%;height:100%;border:0}</style>

<span style="font-size:225%; font-weight:bold;">TACC Analysis Portal User Guide</span><br>
<span style="font-size:90%"><i>Last update: January 4, 2021</i></span></p>

:markdown
	The [TACC Analysis Portal](https://tap.tacc.utexas.edu) (TAP) provides simplified access to interactive sessions on TACC large-scale computing resources. TAP targets users who want the convenience of web-based portal access while maintaining control over low-level job behavior.  

	Any user with an allocation on one of TACC's HPC Systems, e.g. Frontera, Stampede2, Lonestar6, has access to the TACC Analysis Portal.  TAP-Supported applications include:

	* DCV remote desktop
	* VNC remote desktop
	* Jupyter Notebook
	* RStudio


#access
	:markdown
		# [Accessing the Analysis Portal](#access)

		The [TACC Analysis Portal](https://tap.tacc.utexas.edu) is available to users with an allocation on any TACC HPC resource. Log in to TAP using the same username and password that you use to access the TACC User Portal. Once you've logged in you'll be directed to the Home Screen where you can being scheduling jobs.

	%figure
		<img alt="" src="/documents/10157/2062516/1TAP+home/b3bdfbc1-79a8-45c6-b60c-b07ab8af32a1?t=1641269623374" style="width: 700px; height: 415px; border-width: 1px; border-style: solid;" /><br />
		%figcaption 
			Figure 1. TAP Home Screen

#jobmanagement
	:markdown
		# [Job Management](#jobmanagement)

		Submit, end and resubmit jobs on the TACC Analysis Portal.

#jobmanagement-submit
	:markdown
		## [Submitting a Job using TAP](#jobmanagement-submit)

		A TACC Analysis Portal job requires the following inputs:  <span style="background-color:#FF7F00; color:#FFFFFF; font-size:120%">(&nbsp;1&nbsp;)</span>

		* **System:** where the job will run. The system selector drop-down will contain the TAP-supported TACC systems where you have an allocation. The system must be selected first, as the values of the other selectors are determined by the selected system.  
		* **Application:** which application the job will run. The application selector will contain the applications available on the selected system.  
		* **Project:** which project allocation to bill for the job run. The project selector will contain the projects associated with your account on the selected system.  
		* **Queue:** which system queue will receive the job. The queue selector will contain the TAP-supported queues on the selected system.  
		* **Nodes:** the number of nodes the job will occupy. We recommend leaving this setting at 1 unless you know you need more nodes. This is equivalent to the "`-N`" option in Slurm.  
		* **Tasks:** the number of MPI tasks the job will use. We recommend leaving this setting at 1 unless you know you need more tasks. This is equivalent to the "`-n`" option in Slurm.  

		A TAP job also accepts these additional optional inputs:  <span style="width:20px; background-color:#FF7F00; color:#FFFFFF; font-size:120%">(&nbsp;2&nbsp;)</span>

		* **Time Limit:** how long the job will run. If left blank, the job will use the TAP default runtime of 2 hours.  
		* **Reservation:** the reservation in which to run the job. If you have a reservation on the selected system and want the job to run within that reservation, specify the name here.  
		* **VNC Desktop Resolution:** desktop resolution for a VNC job. If this is left blank, a VNC job will use the default resolution of 1024x768.  

		After specifying the job inputs, select the **Submit** <span style="width:20px; background-color:#FF7F00; color:#FFFFFF; font-size:120%">(&nbsp;8&nbsp;)</span> &nbsp;button, and your job will be submitted to the remote system. After submitting the job, you will be automatically redirected to the job status page. You can get back to this page from the **Status** <span style="width:20px; background-color:#FF7F00; color:#FFFFFF; font-size:120%">(&nbsp;3&nbsp;)</span> &nbsp;button. If the job is already running on the system, click the **Connect** <span style="width:20px; background-color:#FF7F00; color:#FFFFFF; font-size:120%">(&nbsp;5&nbsp;)</span>&nbsp; button from the Home Screen or Job status to connect to your application.

	%figure
		<img alt="" src="/documents/10157/2062516/2TAP+job+status/4f7552fd-1303-4427-9124-04adbe769666?t=1641269662697" style="width: 700px; border-width: 1px; border-style: solid; height: 424px;" /><br />
		%figcaption 
			Figure 2. Job Status

	:markdown
		Click the "Check Status" button to update the page with the latest job status. The diagnostic information will include an estimated start time for the job if Slurm is able to provide one. Jobs submitted to development queues typically start running more quickly than jobs submitted to other queues. 


#jobmanagement-end
	:markdown
		## [Ending a Submitted Job](#jobmanagement-end)

		When you are finished with your job, you can end your job using the **End** <span style="width:20px; background-color:#FF7F00; color:#FFFFFF; font-size:120%">(&nbsp;4&nbsp;)</span>&nbsp; button on the TAP Home Screen page or on the Job Status page. Note that closing the browser window will not end the job. Also note that if you end the job from within the application (for example, pressing "Enter" in the red xterm in a DCV or VNC job), TAP will still show the job as running until you check status for the job, click "End Job" within TAP, or the requested end time of the job is reached.

#jobmanagement-resubmit
	:markdown
		## [Resubmitting a Past Job](#jobmanagement-resubmit)

		You can resubmit a past job using the **Resubmit** <span style="width:20px; background-color:#FF7F00; color:#FFFFFF; font-size:120%">(&nbsp;7&nbsp;)</span>&nbsp;  button from the Home Screen page. The job will be submitted with the same inputs used for the past job, including any optional inputs. Select **Details**  <span style="width:20px; background-color:#FF7F00; color:#FFFFFF; font-size:120%">(&nbsp;6&nbsp;)</span>&nbsp;  to see the inputs that were specified for the past job.

	%figure
		<img alt="" src="/documents/10157/2062516/3TAP+job+details/79b1dd59-0b89-4c71-ad4d-07adf0880fc0?t=1641269700237" style="width: 400px; height: 424px; border-width: 1px; border-style: solid;" /><br />

		%figcaption 
			Figure 3. TAP Job Details

#utilities
	:markdown
		# [Utilities](#utilities)

		TAP provides certain useful diagnostic and logistic utilities on the Utilities page. Access the Utilities page by selecting the **Utilities**  <span style="width:20px; background-color:#FF7F00; color:#FFFFFF; font-size:120%">(&nbsp;9&nbsp;)</span>&nbsp;  button on the Home Screen page.

	%figure
		<img alt="" src="/documents/10157/2062516/4TAP+utilities/58ba250e-000b-4027-ba0c-3e2d60733647?t=1641269741435" style="width: 700px; height: 458px; border-width: 1px; border-style: solid;" /><br />
		%figcaption 
			Figure 4. TAP Utilities


#utilities-status
	:markdown
		## [Obtaining TACC Account Status](#utilities-status)

		The Status section provides system information and diagnostics. "Check TACC Info" will show account balances and filesystem usage for the selected system. "Run Sanity Tool" performs a series of sanity checks to catch common account issues that can impact TAP jobs (for example, being over filesystem quota on your `$HOME` directory).
		Configuring Jupyter Notebook

		The Utilities section provides access to several common actions related to Jupyter Notebooks. "Use Python3" sets the TACC Python3 module as part of your default modules so that TAP will use Python3 for Jupyter Notebooks. If you want to use a non-default Python installation, such as Conda, you will need to install it yourself via the system command line. TAP will use the first "jupyter-notebook" command in your `$PATH`, so make sure that the command "which jupyter-notebook" returns the Jupyter Notebook you want to use. Conda install typically configures your environment so that Conda is first on your `$PATH`.

		"Link `$WORK` from `$HOME`" and "Link `$SCRATCH` from `$HOME`" create symbolic links in your `$HOME` directory so that you can access `$WORK` and `$SCRATCH` from within a Jupyter Notebook. TAP launches Jupyter Notebooks from within your `$HOME` directory, so these other file systems are not reachable without such a linking mechanism. The links will show up as "WORK" and "SCRATCH" in the Jupyter file browser. You only need to create these links once and they will remain available for all future jobs.

#utilities-fullscreen
	:markdown
		## [Setting a Remote Desktop to Full Screen Mode](#utilities-fullscreen)

		Both DCV and VNC support full-screen mode. DCV will automatically adjust the desktop resolution to use the full screen, whereas VNC will keep the original desktop resolution within the full-screen view.

		In DCV, click the Fullscreen button in the upper left corner of the DCV desktop.

	%figure
		<img alt="" src="/documents/10157/2062516/5TAP+DCV+full+screen/67d7edcd-d45f-41dc-9a7f-95feb9ccbcee?t=1641269778979" style="width: 700px; height: 459px;  border-width: 1px; border-style: solid;" /><br />
		%figcaption 
			Figure 5. DCV Full Screen


	:markdown
		In VNC, open the control bar on the left side of the screen, then click the Fullscreen button.

	%figure
		<img alt="" src="/documents/10157/2062516/6TAP+VNC+full+screen/6b9e4e98-77fb-477b-80c6-6ad4e75026b5?t=1641269820796" style="width: 700px; height: 431px; border-width: 1px; border-style: solid;" /><br />
		%figcaption 
			Figure 6. VNC Full Screen

#troubleshooting
	:markdown
		# [Troubleshooting](#troubleshooting)

#troubleshooting-noallocation
	:markdown
		## [No Allocation Available](#troubleshooting-noallocation)

		If TAP cannot find an allocation for your account on a supported system, you will see the message below. If the issue persists, [create a ticket](SUBMITTICKET) in the TACC Consulting System.

	%figure
		<img alt="" src="/documents/10157/2062516/7TAP+no+allocation/94ede378-1047-4eca-92f1-6ea030623a0c?t=1641269862505" style="width: 700px; height: 426px; border-width: 1px; border-style: solid;"/><br />
		%figcaption 
			Figure 7. TAP Error: No Allocation


#troubleshooting-pending
	:markdown
		## [Job Submission returns PENDING](#troubleshooting-pending)

		If the job does not start immediately, TAP will load a status page with some diagnostic information. If the job status is "PENDING", the job was successfully submitted and has not yet started running. If Slurm can predict when the job will start, that information will be in the `squeue --start` output in the message window. Clicking the "Check Status" button will update the job status. When the job has started, TAP will show a "Connect" button.
		
	%figure
		<img alt="" src="/documents/10157/2062516/8TAP+pending/b55ef439-fa21-4572-ab7d-0ce9c44a9719?t=1641270133216" style="width: 700px; height: 406px; border-width: 1px; border-style: solid;" /><br />
		%figcaption 
			Figure 8. TAP Error: PENDING  


#troubleshooting-error
	:markdown
		## [Job Submission returns ERROR](#troubleshooting-error)

		If the TAP status page shows that the job status is "ERROR", then there was an issue with the Slurm submission, and the message box will contain details. If you have difficulty interpreting the error message or resolving the issue, please create a ticket in the TACC Consulting System and include the TAP message.

	%figure
		<img alt="" src="/documents/10157/2062516/9TAP+error/fab8f493-f5f0-45f2-abee-a8cd96b28d1b?t=1641270167682" style="width: 700px; height: 444px; border-width: 1px; border-style: solid;" /><br />
		%figcaption 
			Figure 9. TAP "Error"




