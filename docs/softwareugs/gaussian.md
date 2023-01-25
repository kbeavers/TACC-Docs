<p><span style="font-size:225%; font-weight:bold;">Gaussian at TACC</span><br>
<i>Last update: April 14, 2020</i></p>

#top
	:markdown
		Gaussian is a quantum mechanics package for calculating molecular properties from first principles. From the Gaussian website:

%table(cellspacing="3" cellpadding="3")
	%tr
		%td <img alt="Gaussian logo" src="/documents/10157/1667013/Gaussian+logo/6feb0603-5f03-481b-b125-d48e1c8c1f5d?t=1586873786546" style="height: 75px; width: 75px;" /></td>

		%td <i>Starting from the fundamental laws of quantum mechanics, Gaussian 16 predicts the energies, molecular structures, vibrational frequencies and molecular properties of compounds and reactions in a wide variety of chemical environments. Gaussian 16’s models can be applied to both stable species and compounds which are difficult or impossible to observe experimentally, whether due to their nature (e.g., toxicity, combustibility, radioactivity) or their inherent fleeting nature (e.g., short-lived intermediates and transition structures).</i>

#access
	:markdown
		# [TACC and Gaussian](#access)

		TACC's Gaussian license allows academic users who have signed a Usage Agreement to use the Gaussian software on TACC compute systems. Users do not need to bring their own individual licenses.  Depending on your home institution, gaining access to Gaussian requires that you sign and return one of the following forms:

#access-ut
	:markdown
		* [UT Austin Students, Staff, and Faculty](#access-ut)

			TACC must maintain a physical copy of a [Confidentiality Agreement](/documents/10157/1667013/UT-Gaussian-agreement/38f88d39-3aef-41b7-b839-bf6331e20f0b) for all UT Austin users.  It is easiest to print, sign, and send back this [Confidentiality Agreement](/documents/10157/1667013/UT-Gaussian-agreement/38f88d39-3aef-41b7-b839-bf6331e20f0b) by campus mail to "TACC - Gaussian" at mail code R8700.  Submit a consulting ticket notifying TACC staff that you have mailed the agreement so that we can expect it and easily follow up with you.


#access-other
	:markdown
		* [Other Academic Users](#access-other)

			Please fill out the [Usage Agreement](/documents/10157/1667013/UT+Gaussian+user+agreement/95c13b8a-859d-439e-8dbe-3f2ba2b578b7) and open a consulting ticket with the agreement as an attachment to the ticket.  TACC maintains digital copies of Usage Agreements for all TACC users not from UT Austin. Once you have sent in a signed version of the [required agreement](/documents/10157/1667013/UT+Gaussian+user+agreement/95c13b8a-859d-439e-8dbe-3f2ba2b578b7), TACC staff can open up access to you of the Gaussian module on all systems on which the module is installed.  



#running
	:markdown
		# [Running Gaussian](#running)

		Gaussian 16 is currently installed on TACC's Stampede2, Frontera and Lonestar5 compute resources. Gaussian is accessed via TACC's Lmod module system. Use "`module spider gaussian`" and "`module help gaussian`" to list and explore installed versions. Then, either interactively or via a batch script, load the appropriate module:

		<pre class="cmd-line">login1$ <b>module load gaussian</b></pre>

#script
	:markdown
		## [Sample Job Script](#script)

		The Linda MPI addon is not part of TACC's Gaussian module, so each Gaussian execution cannot use more than one node. In the Gaussian input file, ("`input.conf`" in the example below), set the "`%NProcShared`" variable to the number of CPU cores you wish to use. Do not use the `ibrun` invocation. Gaussian job submission scripts should look something like the following: 

		<pre class="job-script">
		#!/bin/bash
		#SBATCH -J my_job_name # Job Name
		#SBATCH -o output.%j # Output file name (%j expands to jobID)
		#SBATCH -e error.%j # Error file name (%j expands to jobID)
		#SBATCH -N 1 -n 1 # Gaussian only uses one node
		#SBATCH -p normal # Queue name -- normal, development, etc.
		#SBATCH -t 24:00:00 # Run time (hh:mm:ss)
		#SBATCH -A project_account_name  # You can remove this line if you only have one allocation

		module load gaussian

		g16 < input.conf > output.log</pre>

#refs
	:markdown
		# [References](#refs)

		* [Gaussian site](https://gaussian.com)
		* [Gaussian manual](https://gaussian.com/man/)
		* [TACC Software page](https://www.tacc.utexas.edu/systems/software)
