/ Si Liu, Susan Lindsey
/ http://portal.tacc.utexas.edu/software/openfoam
<p><span style="font-size:225%; font-weight:bold;">OpenFOAM at TACC</span><br>
<span style="font-size:90%"><i>Last update: April 14, 2020</i></span></p>

%table(cellspacing="3" cellpadding="3")
	%tr
		%td <img alt="OpenFOAM logo" src="/documents/10157/1667013/OpenFOAM+logo/5471be11-5685-45ef-bac2-728e237cbceb?t=1538752988000" style="height: 75px; width: 75px;" />
		%td The <a href="https://www.openfoam.org">OpenFOAM</a> (**O**pen **F**ield **O**peration and **M**anipulation) Toolbox is a free, open source Computational Fluid Dynamics (CFD) software package providing an extensive range of features, from solving complex fluid flows involving chemical reactions, turbulence and heat transfer, to solid dynamics and electromagnetics.


#running
	:markdown
		# [Running OpenFOAM on Frontera and Stampede2](#running)

		TACC staff has built and installed OpenFOAM 7.0 on both [Stampede2](/user-guides/stampede2) and [Frontera](/user-guides/frontera) compute resources. The Stampede2 executable is built with intel/18.0.2 and impi/18.0.2, while the Frontera executable is built with intel/19.0.5 and impi/19.0.5. Follow the steps below to set up the environment and run an OpenFOAM tutorial example.

#running-compenv
	:markdown
		## [Set Up the Computing Environment](#running-compenv)

		Set up the proper computing environment by loading the latest OpenFoam module:

		<pre class="cmd-line">login1$ <b>module load openfoam/7.0</b></pre>

		OpenFOAM places its [cases](https://cfd.direct/openfoam/user-guide/cases/) in the directory defined by the `$FOAM_RUN` environment variable.  TACC staff suggests using your `$SCRATCH` file space to run OpenFOAM cases.  The following commands set this environment variable and create the `$FOAM_RUN` directory in the user's `$SCRATCH` directory.

		<pre class="cmd-line">
		login1$ <b>export FOAM_RUN=$SCRATCH/My_OpenFOAM/7.0/run</b>
		login1$ <b>mkdir -p $FOAM_RUN</b></pre>

#tutorials
	:markdown
		# [Run Tutorials](#tutorials)

		<p class="portlet-msg-alert">Do NOT run the following commands on the login nodes.<br>You may either <a href="/user-guides/stampede2/#submitting-batch-jobs-with-sbatch">submit a batch job</a>, or start an interactive session using TACC's <a href="/software/idev">`idev`</a> utility.</p>

		The following demonstrates running the OpenFOAM's [Lid-driven Cavity Flow](https://cfd.direct/openfoam/user-guide/v7-cavity/#x5-40002.1) test case involving isothermal, incompressible flow in a two-dimensional square domain.

		* Copy OpenFOAM's tutorials into the OpenFOAM work directory created above, then change to the cavity case directory:

			<pre class="cmd-line">
			login1$ <b>idev</b>
			...
			c557-804$ <b>cp -r $FOAM_TUTORIALS $FOAM_RUN </b>
			c557-804$ <b>cd $FOAM_RUN/tutorials/incompressible/icoFoam/cavity/cavity</b></pre>

		* Use the pre-processing tool, **`blockMesh`**, to generate the mesh.  Then run the **`icoFoam`** solver.  

			<pre class="cmd-line">
			c557-804$ <b>blockMesh</b>
			c557-804$ <b>icoFoam</b>
			c557-804$ <b>exit</b>
			login1$</pre>

#references
	:markdown
		# [References](#references)

		* [OpenFOAM user guide](https://www.openfoam.org/resources/)
		* [Working with Modules](/web/tup/software/modules)
		* [OpenFOAM and ParaView](https://cfd.direct/openfoam/features/)
