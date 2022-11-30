<p><span style="font-size:225%; font-weight:bold;">Modules and Lmod</span><br>
<i>Last update: November 19, 2020</i></p>

#compenv
	:markdown
		# [Controlling your Computing Environment](#compenv)

		TACC resources, like all UNIX systems, set up a default environment with the ability to execute additional commands to alter the environment. The default setup is controlled by system and user files that your shell executes before you see the shell prompt.

		On all TACC computers, your environment is controlled with the open source [Modules](http://sourceforge.net/projects/modules) utility. At login, "`module`" commands set up a basic environment for the default compilers, tools, and libraries. For example: the `$PATH`, `$MANPATH`, `$LD_LIBRARY_PATH` variables and directory locations (`$WORK`, `$SCRATCH`, `$HOME`) etc. These environment variables are automatically kept up-to-date when system and application software is upgraded.

		Users that require 3rd party applications, special libraries, and tools for their projects can quickly tailor their environment with only the applications and tools they need. Using Modules to define a specific application environment allows you to keep your environment free from the clutter of all the application environments you don't need.

		Each of the major TACC applications has a modulefile that sets, unsets, appends to, or prepends to environment variables such as `$PATH`, `$LD_LIBRARY_PATH`, `$INCLUDE_PATH`, and `$MANPATH` for the specific application. Each modulefile also sets application-specific functions and aliases. The general format of the module command is:

		<pre class="cmd-line">login1$ <b>module load <i>modulename</i></b></pre>

		where *`modulename`* designates the software package to load. Most package directories are in the system's "`/opt/apps`" directory and each package directory contains subdirectories for specific versions of the package. Once the module is loaded, there are typically three environment variables defined corresponding to the package's root directory, the include path and the library path respectively.

		* <code>$TACC_<i>PACKAGE</i>_DIR</code> 
		* <code>$TACC_<i>PACKAGE</i>_INC</code> 
		* <code>$TACC_<i>PACKAGE</i>_LIB</code> 

		As an example, let us consider the `fftw3` package. The FFTW3 library requires several environment variables for its installation directory, libraries, include files, and documentation. These environment variables can all be set by typing:

		<pre class="cmd-line">login1$ <b>module load fftw3</b></pre>

		The environment variables `$TACC_FFTW3_DIR`, `$TACC_FFTW3_INC`, and `$TACC_FFTW3_LIB` are now set in your environment, and you can use these variables in Makefiles when compiling other software: 

		<pre><b>Sample Makefile line:</b>
		icc -o myfftprogram myfftcode.c -I${TACC_FFTW3_INC} -L${TACC_FFTW3_LIB} -lfftw3</pre>

		To see a list of available modules, a synopsis of a particular modulefile's operations (in this case, fftw3), or a list of currently loaded modules, respectively, execute the following commands:

		<pre class="cmd-line">
		login1$ <b>module avail</b>
		login1$ <b>module help fftw3</b> 
		login1$ <b>module list</b></pre>

		By default, TACC systems load the "`TACC"` module, which loads default compiler (pgi) and the default mpi stack (Mvapich) modules, among others. You are free to change the default compiler and MPI stack either at login via your shell's startup files or through interactive commands.

#modules
	:markdown
		# [Module System](#modules)

		The software environment on TACC resources are powerful but complex. In most cases, we support two main compiler suites (PGI and Intel), and three MPI stacks (Mvapich, Mvapich2, OpenMPI). Since each MPI stack must be built against each of the supported compilers, the result is a 2x3 matrix of compiler/MPI combinations, and a minimum of six different builds of any given higher-level software package (e.g. PETSc) which depends on both the compiler and MPI stack.

		A great deal of this complexity is effectively hidden by the module system. Since you can only have one compiler and one MPI module active at any given time, typing "`module avail`" will only show you the subset of all the available software builds that is actually relevant to your particular compiler/MPI stack combination.

#lmod
	:markdown
		# [Lmod](#lmod)
	
		On October 20, 2009, a new module software package, called [Lmod](https://www.tacc.utexas.edu/research-development/tacc-projects/lmod), was installed on all TACC systems. Lmod has been under development and testing on TACC systems since 2009, and is now the default for all users. Users should notice very little change from the previous module command. The main advantage the new module system provides is automatic reloading of an entire module hierarchy when a single module anywhere in the hierarchy is changed.

		For example, you can now switch from the Intel compiler to the PGI compiler, and any dependent modules, such as the MPI stack, will be automatically reloaded. Under the old module system, to change compilers you had to unload any MPI-dependent libraries such as FFTW2 or PETSc, then unload the MPI library, then unload the compiler, then finally load the new compiler, MPI, and MPI-dependent libraries. This was a time-consuming and error-prone process. Suppose you have just logged in and you have the default compiler (PGI) and MPI stack (Mvapich) loaded. Your program uses the FFT library FFTW2:

		<pre class="cmd-line">login1$ <b>module load fftw2</b></pre>

		Now, suppose that you wish to try the Intel compiler and use the same MPI stack and FFTW2, so you do:

		<pre class="cmd-line">login1$ <b>module swap pgi intel</b>
		Due to MODULEPATH changes the follow modules have been reloaded:  
		1) mvapich 2) fftw2</pre>

		Lmod automatically unloads the pgi versions of Mvapich and fftw2 and loads their intel versions. Not all software combinations exist. For example, there is no version of fftw2 installed for the Intel/Mvapich2 pairing. If you type:

		<pre class="cmd-line">login1$ <b>module swap mvapich mvapich2</b>
		Inactive Modules:  
		1) fftw2</pre>

		This command's output reveals that there is no `fftw2` module for the Intel compiler and the Mvapich2 MPI stack. Now if you switch back to Mvapich:

		<pre class="cmd-line">login1$ <b>module swap mvapich2 mvapich</b>
		Activating Modules:  
		1) fftw2</pre>

		The Lmod module system remembers inactive modules and activates them when the situation allows. 

		For more information on Lmod please see [Lmod: Environmental Modules System](https://www.tacc.utexas.edu/research-development/tacc-projects/lmod).

