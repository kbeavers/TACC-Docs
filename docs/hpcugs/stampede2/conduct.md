## [Using Stampede2](#conduct) { #conduct }

Stampede2 nodes run Red Hat Enterprise Linux 7. Regardless of your research workflow, **you’ll need to master Linux basics** and a Linux-based text editor (e.g. `emacs`, `nano`, `gedit`, or `vi/vim`) to use the system properly. This user guide does not address these topics, however. There are numerous resources in a variety of formats that are available to help you learn Linux, including some listed on the [TACC](https://portal.tacc.utexas.edu/training/course-materials) training sites. If you encounter a term or concept in this user guide that is new to you, a quick internet search should help you resolve the matter quickly.

### [Configuring Your Account](#conduct-account) { #conduct-account }

#### [Linux Shell](#conduct-account-shell) { #conduct-account-shell }

The default login shell for your user account is Bash.  To determine your current login shell, execute: 

<pre class="cmd-line">$ <b>echo $SHELL</b></pre>

If you'd like to change your login shell to `csh`, `sh`, `tcsh`, or `zsh`, submit a ticket through the [TACC User Portal][TACCUSERPORTAL]. The "`chsh`" ("change shell") command will not work on TACC systems. 

When you start a shell on Stampede2, system-level startup files initialize your account-level environment and aliases before the system sources your own user-level startup scripts. You can use these startup scripts to customize your shell by defining your own environment variables, aliases, and functions. These scripts (e.g. `.profile` and `.bashrc`) are generally hidden files: so-called dotfiles that begin with a period, visible when you execute: NOWRAP"`ls -a`"ESPAN.

Before editing your startup files, however, it's worth taking the time to understand the basics of how your shell manages startup. Bash startup behavior is very different from the simpler `csh` behavior, for example. The Bash startup sequence varies depending on how you start the shell (e.g. using `ssh` to open a login shell, executing the "`bash`" command to begin an interactive shell, or launching a script to start a non-interactive shell). Moreover, Bash does not automatically source your `.bashrc` when you start a login shell by using  `ssh` to connect to a node. Unless you have specialized needs, however, this is undoubtedly more flexibility than you want: you will probably want your environment to be the same regardless of how you start the shell. The easiest way to achieve this is to execute NOWRAP"`source ~/.bashrc`"ESPAN from your "`.profile`", then put all your customizations in "`.bashrc`".  The system-generated default startup scripts demonstrate this approach. We recommend that you use these default files as templates.

For more information see the [Bash Users' Startup Files: Quick Start Guide][TACCBASHQUICKSTARTGUIDE] and other online resources that explain shell startup. To recover the originals that appear in a newly created account, execute NOWRAP"`/usr/local/startup_scripts/install_default_scripts`"ESPAN.

#### [Environment Variables](#conduct-account-envvars) { #conduct-account-envvars }

Your environment includes the environment variables and functions defined in your current shell: those initialized by the system, those you define or modify in your account-level startup scripts, and those defined or modified by the [modules](#conduct-modules) that you load to configure your software environment. Be sure to distinguish between an environment variable's name (e.g. `HISTSIZE`) and its value (`$HISTSIZE`). Understand as well that a sub-shell (e.g. a script) inherits environment variables from its parent, but does not inherit ordinary shell variables or aliases. Use `export` (in Bash) or `setenv` (in `csh`) to define an environment variable.

Execute the "`env`" command to see the environment variables that define the way your shell and child shells behave. 

Pipe the results of `env` into `grep` to focus on specific environment variables. For example, to see all environment variables that contain the string GIT (in all caps), execute:

<pre class="cmd-line">$ <b>env | grep GIT</b></pre>

The environment variables `PATH` and `LD_LIBRARY_PATH` are especially important. `PATH` is a colon-separated list of directory paths that determines where the system looks for your executables. `LD_LIBRARY_PATH` is a similar list that determines where the system looks for shared libraries.

#### [Account-Level Diagnostics](#conduct-account-diagnostics) { #conduct-account-diagnostics }

TACC's `sanitytool` module loads an account-level diagnostic package that detects common account-level issues and often walks you through the fixes. You should certainly run the package's `sanitycheck` utility when you encounter unexpected behavior. You may also want to run `sanitycheck` periodically as preventive maintenance. To run `sanitytool`'s account-level diagnostics, execute the following commands:

<pre class="cmd-line">
login1$ <b>module load sanitytool</b>
login1$ <b>sanitycheck</b></pre>

Execute "`module help sanitytool`" for more information.

### [Accessing the Compute Nodes](#conduct-computenodes) { #conduct-computenodes }

You connect to Stampede2 through one of four "front-end" login nodes. The login nodes are shared resources: at any given time, there are many users logged into each of these login nodes, each preparing to access the "back-end" compute nodes ([Figure 2. Login and Compute Nodes](#figure2)). What you do on the login nodes affects other users directly because you are competing for the same memory and processing power. This is the reason you should not run your applications on the login nodes or otherwise abuse them. Think of the login nodes as a prep area where you can manage files and compile code before accessing the compute nodes to perform research computations. See [Good Conduct](#conduct-conduct) for more information. 

**You can use your command-line prompt, or the "`hostname`" command, to tell you whether you are on a login node or a compute node**. The default prompt, or any custom prompt containing "`\h`", displays the short form of the hostname (e.g. `c401-064`). The hostname for a Stampede2 login node begins with the string "`login`" (e.g. `login2.stampede2.tacc.utexas.edu`), while compute node hostnames begin with the character "`c`" (e.g. `c401-064.stampede2.tacc.utexas.edu`). Note that the default prompts on the compute nodes include the node type (`knl`, `skx` or `icx`) as well. The environment variable `TACC_NODE_TYPE`, defined only on the compute nodes, also displays the node type. The simplified prompts in the User Guide examples are shorter than Stampede2's actual default prompts.

While some workflows, tools, and applications hide the details, there are three basic ways to access the compute nodes:

1.	[Submit a **batch job** using the `sbatch` command](#running-sbatch). This directs the scheduler to run the job unattended when there are resources available. Until your batch job begins it will wait in a [queue](#running-queues). You do not need to remain connected while the job is waiting or executing. See [Running Jobs](#running) for more information. Note that the scheduler does not start jobs on a first come, first served basis; it juggles many variables to keep the machine busy while balancing the competing needs of all users. The best way to minimize wait time is to request only the resources you really need: the scheduler will have an easier time finding a slot for the two hours you need than for the 48 hours you unnecessarily request.
2.	Begin an [**interactive session** using `idev` or `srun`](#running-idev). This will log you into a compute node and give you a command prompt there, where you can issue commands and run code as if you were doing so on your personal machine. An interactive session is a great way to develop, test, and debug code. When you request an interactive session, the scheduler submits a job on your behalf. You will need to remain logged in until the interactive session begins.
3.	Begin an [interactive session using **`ssh`**](#running-ssh) to connect to a compute node on which you are already running a job. This is a good way to open a second window into a node so that you can monitor a job while it runs.

Be sure to request computing resources that are consistent with the type of application(s) you are running:

* A **serial** (non-parallel) application can only make use of a single core on a single node, and will only see that node's memory.
* A threaded program (e.g. one that uses **OpenMP**) employs a shared memory programming model and is also restricted to a single node, but the program's individual threads can run on multiple cores on that node. 
* An **MPI** (Message Passing Interface) program can exploit the distributed computing power of multiple nodes: it launches multiple copies of its executable (MPI **tasks**, each assigned unique IDs called **ranks**) that can communicate with each other across the network. The tasks on a given node, however, can only directly access the memory on that node. Depending on the program's memory requirements, it may not be possible to run a task on every core of every node assigned to your job. If it appears that your MPI job is running out of memory, try  launching it with fewer tasks per node to increase the amount of memory available to individual tasks.
* A popular type of **parameter sweep** (sometimes called **high throughput computing**) involves submitting a job that simultaneously runs many copies of one serial or threaded application, each with its own input parameters ("Single Program Multiple Data", or SPMD). The "`launcher`" tool is designed to make it easy to submit this type of job. For more information:

<pre class="cmd-line">
$ <b>module load launcher</b>
$ <b>module help launcher</b></pre>

<figure>
FIGURE-LOGINCOMPUTENODES
<figcaption>Figure 2. Login and compute nodes</figcaption></figure>

### [Using Modules to Manage your Environment](#conduct-modules) { #conduct-modules }

Lmod, a module system developed and maintained at TACC, makes it easy to manage your environment so you have access to the software packages and versions that you need to conduct your research. This is especially important on a system like Stampede2 that serves thousands of users with an enormous range of needs. Loading a module amounts to choosing a specific package from among available alternatives:

<pre class="cmd-line">
$ <b>module load intel</b>          # load the default Intel compiler
$ <b>module load intel/17.0.4</b>   # load a specific version of Intel compiler</pre>

A module does its job by defining or modifying environment variables (and sometimes aliases and functions). For example, a module may prepend appropriate paths to `$PATH` and `$LD_LIBRARY_PATH` so that the system can find the executables and libraries associated with a given software package. The module creates the illusion that the system is installing software for your personal use. Unloading a module reverses these changes and creates the illusion that the system just uninstalled the software:

<pre class="cmd-line">
$ <b>module load   ddt</b>  # defines DDT-related env vars; modifies others
$ <b>module unload ddt</b>  # undoes changes made by load</pre>

The module system does more, however. When you load a given module, the module system can automatically replace or deactivate modules to ensure the packages you have loaded are compatible with each other. In the example below, the module system automatically unloads one compiler when you load another, and replaces Intel-compatible versions of IMPI and PETSc with versions compatible with gcc:

<pre class="cmd-line">
$ <b>module load intel</b>  # load default version of Intel compiler
$ <b>module load petsc</b>  # load default version of PETSc
$ <b>module load gcc</b>    # change compiler

Lmod is automatically replacing "intel/17.0.4" with "gcc/7.1.0".

Due to MODULEPATH changes, the following have been reloaded:
1) impi/17.0.3     2) petsc/3.7</pre>

On Stampede2, modules generally adhere to a TACC naming convention when defining environment variables that are helpful for building and running software. For example, the "`papi`" module defines `TACC_PAPI_BIN` (the path to PAPI executables), `TACC_PAPI_LIB` (the path to PAPI libraries), `TACC_PAPI_INC` (the path to PAPI include files), and `TACC_PAPI_DIR` (top-level PAPI directory). After loading a module, here are some easy ways to observe its effects:

<pre class="cmd-line">
$ <b>module show papi</b>   # see what this module does to your environment
$ <b>env | grep PAPI</b>    # see env vars that contain the string PAPI
$ <b>env | grep -i papi</b> # case-insensitive search for 'papi' in environment</pre>

To see the modules you currently have loaded:

<pre class="cmd-line">
$ <b>module list</b></pre>

To see all modules that you can load right now because they are compatible with the currently loaded modules:

<pre class="cmd-line">
$ <b>module avail</b></pre>

To see all installed modules, even if they are not currently available because they are incompatible with your currently loaded modules:

<pre class="cmd-line">
$ <b>module spider</b>   # list all modules, even those not available to load</pre>

To filter your search:

<pre class="cmd-line">
$ <b>module spider slep</b>             # all modules with names containing 'slep'
$ <b>module spider sundials/2.5.0</b>   # additional details on a specific module</pre>

Among other things, the latter command will tell you which modules you need to load before the module is available to load. You might also search for modules that are tagged with a keyword related to your needs (though your success here depends on the diligence of the module writers). For example:

<pre class="cmd-line">
$ <b>module keyword performance</b></pre>

You can save a collection of modules as a personal default collection that will load every time you log into Stampede2. To do so, load the modules you want in your collection, then execute:

<pre class="cmd-line">
$ <b>module save</b>    # save the currently loaded collection of modules </pre>

Two commands make it easy to return to a known, reproducible state:

<pre class="cmd-line">
$ <b>module reset</b>   # load the system default collection of modules
$ <b>module restore</b> # load your personal default collection of modules</pre>

On TACC systems, the command "`module reset`" is equivalent to "`module purge; module load TACC`". It's a safer, easier way to get to a known baseline state than issuing the two commands separately.

Help text is available for both individual modules and the module system itself:

<pre class="cmd-line">
$ <b>module help swr</b>     # show help text for software package swr
$ <b>module help</b>         # show help text for the module system itself</pre>

See [Lmod's online documentation](http://lmod.readthedocs.org) for more extensive documentation. The online documentation addresses the basics in more detail, but also covers several topics beyond the scope of the help text (e.g. writing and using your own module files).

It's safe to execute module commands in job scripts. In fact, this is a good way to write self-documenting, portable job scripts that produce reproducible results. If you use NOWRAP"`module save`"ESPAN to define a personal default module collection, it's rarely necessary to execute module commands in shell startup scripts, and it can be tricky to do so safely. If you do wish to put module commands in your startup scripts, see Stampede2's default startup scripts for a safe way to do so.

