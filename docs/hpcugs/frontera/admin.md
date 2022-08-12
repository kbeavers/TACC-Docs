# Account Administration

<!-- p class="introtext">Discuss account status, account configuration.</p -->

## Setting up Your Account

### Check your Allocation Status

**You must be added to a Frontera allocation in order to have access/login to Frontera.** The ability to log on to the TACC User Portal does NOT signify access to Frontera or any TACC resource. Submit Frontera allocations requests via [TACC's Resource Allocation System](https://tacc-submit.xras.xsede.org/). Continue to [manage your allocation's users](https://portal.tacc.utexas.edu/projects-and-allocations#) via the TACC User Portal. 

### Multi-Factor Authentication

Access to all TACC systems now requires Multi-Factor Authentication (MFA). You can create an MFA pairing on the TACC User Portal. After login on the portal, go to your account profile (Home->Account Profile), then click the "Manage" button under "Multi-Factor Authentication" on the right side of the page. See [Multi-Factor Authentication at TACC](http://portal.tacc.utexas.edu/tutorials/multifactor-authentication) for further information. 

### Password Management

Use your TACC User Portal password for direct logins to TACC resources. You can change your TACC password through the [TACC User Portal](http://portal.tacc.utexas.edu/). Log into the portal, then select "Change Password" under the "HOME" tab. If you've forgotten your password, go to the [TACC User Portal](http://portal.tacc.utexas.edu/) home page and select "Password Reset" under the Home tab.


## Access the System

### Secure Shell (SSH)

The "`ssh`" command (SSH protocol) is the standard way to connect to Frontera. SSH also includes support for the file transfer utilities `scp` and `sftp`. [Wikipedia](https://en.wikipedia.org/wiki/Secure_Shell) is a good source of information on SSH. SSH is available within Linux and from the terminal app in the Mac OS. If you are using Windows, you will need an SSH client that supports the SSH-2 protocol: e.g. [Bitvise](http://www.bitvise.com), [OpenSSH](http://www.openssh.com), [PuTTY](http://www.putty.org), or [SecureCRT](https://www.vandyke.com/products/securecrt/). Initiate a session using the `ssh` command or the equivalent; from the Linux command line the launch command looks like this:

<pre class="cmd-line">localhost$ <b>ssh <i>username</i>@frontera.tacc.utexas.edu</b></pre>

The above command will rotate connections across all available login nodes, `login1-login4`, and route your connection to one of them. To connect to a specific login node, use its full domain name:

<pre class="cmd-line">localhost$ <b>ssh <i>username</i>@login2.frontera.tacc.utexas.edu</b></pre>

To connect with X11 support on Frontera (usually required for applications with graphical user interfaces), use the <span style="white-space: nowrap;">"`-X`"</span> or <span style="white-space: nowrap;">"`-Y`"</span> switch:

<pre class="cmd-line">localhost$ <b>ssh -X <i>username</i>@frontera.tacc.utexas.edu</b></pre>

To report a connection problem, execute the `ssh` command with the "`-vvv`" option and include the verbose output when submitting a help ticket.

**Do not run the "`ssh-keygen`" command on Frontera.** This command will create and configure a key pair that will interfere with the execution of job scripts in the batch system. If you do this by mistake, you can recover by renaming or deleting the `.ssh` directory located in your home directory; the system will automatically generate a new one for you when you next log into Frontera.

1. execute "`mv .ssh dot.ssh.old`" 
1. log out
1. log into Frontera again

After logging in again the system will generate a properly configured key pair.

Regardless of your research workflow, <b>you’ll need to master Linux basics</b> and a Linux-based text editor (e.g. `emacs`, `nano`, `gedit`, or `vi/vim`) to use the system properly. However, this user guide does not address these topics. There are numerous resources in a variety of formats that are available to help you learn Linux, including some listed on the <a href="https://portal.tacc.utexas.edu/training/course-materials">TACC</a> and training sites. If you encounter a term or concept in this user guide that is new to you, a quick internet search should help you resolve the matter quickly.

## Configuring Your Account

### Linux Shell

The default login shell for your user account is Bash. To determine your current login shell, execute: 

<pre class="cmd-line">$ <b>echo $SHELL</b></pre>

If you'd like to change your login shell to `csh`, `sh`, `tcsh`, or `zsh`, submit a ticket through the [TACC](http://portal.tacc.utexas.edu/) portal. The `chsh` ("change shell") command will not work on TACC systems. 

When you start a shell on Frontera, system-level startup files initialize your account-level environment and aliases before the system sources your own user-level startup scripts. You can use these startup scripts to customize your shell by defining your own environment variables, aliases, and functions. These scripts (e.g. `.profile` and `.bashrc`) are generally hidden files: so-called dotfiles that begin with a period, visible when you execute: <span style="white-space: nowrap;">`ls -a`</span>.

Before editing your startup files, however, it's worth taking the time to understand the basics of how your shell manages startup. Bash startup behavior is very different from the simpler `csh` behavior, for example. The Bash startup sequence varies depending on how you start the shell (e.g. using `ssh` to open a login shell, executing the `bash` command to begin an interactive shell, or launching a script to start a non-interactive shell). Moreover, Bash does not automatically source your `.bashrc` when you start a login shell by using `ssh` to connect to a node. Unless you have specialized needs, however, this is undoubtedly more flexibility than you want: you will probably want your environment to be the same regardless of how you start the shell. The easiest way to achieve this is to execute <span style="white-space: nowrap;">`source ~/.bashrc`</span> from your `.profile`, then put all your customizations in `.bashrc`. The system-generated default startup scripts demonstrate this approach. We recommend that you use these default files as templates.

For more information see the [Bash Users' Startup Files: Quick Start Guide](https://portal.tacc.utexas.edu/tutorials/bashquickstart) and other online resources that explain shell startup. To recover the originals that appear in a newly created account, execute <span style="white-space: nowrap;">`/usr/local/startup_scripts/install_default_scripts`</span>.

### Environment Variables

Your environment includes the environment variables and functions defined in your current shell: those initialized by the system, those you define or modify in your account-level startup scripts, and those defined or modified by the [modules](#using-modules-to-manage-your-environment) that you load to configure your software environment. Be sure to distinguish between an environment variable's name (e.g. `HISTSIZE`) and its value (`$HISTSIZE`). Understand as well that a sub-shell (e.g. a script) inherits environment variables from its parent, but does not inherit ordinary shell variables or aliases. Use `export` (in Bash) or `setenv` (in `csh`) to define an environment variable.

Execute the `env` command to see the environment variables that define the way your shell and child shells behave. 

Pipe the results of `env` into `grep` to focus on specific environment variables. For example, to see all environment variables that contain the string GIT (in all caps), execute:

<pre class="cmd-line">$ <b>env | grep GIT</b></pre>

The environment variables `PATH` and `LD_LIBRARY_PATH` are especially important. `PATH` is a colon-separated list of directory paths that determines where the system looks for your executables. `LD_LIBRARY_PATH` is a similar list that determines where the system looks for shared libraries.

### Account-Level Diagnostics

TACC's `sanitytool` module loads an account-level diagnostic package that detects common account-level issues and often walks you through the fixes. You should certainly run the package's `sanitycheck` utility when you encounter unexpected behavior. You may also want to run `sanitycheck` periodically as preventive maintenance. To run `sanitytool`'s account-level diagnostics, execute the following commands:

<pre class="cmd-line">login1$ <b>module load sanitytool</b>
login1$ <b>sanitycheck</b></pre>

Execute `module help sanitytool` for more information.

### Using Modules to Manage your Environment

[Lmod](https://www.tacc.utexas.edu/research-development/tacc-projects/lmod), a module system developed and maintained at TACC, makes it easy to manage your environment so you have access to the software packages and versions that you need to conduct your research. This is especially important on a system like Frontera that serves thousands of users with an enormous range of needs. Loading a module amounts to choosing a specific package from among available alternatives:

<pre class="cmd-line">
$ <b>module load intel</b>          # load the default Intel compiler v19.0.4
$ <b>module load intel/18.0.5</b>   # load a specific version of the Intel compiler</pre>
</pre>

A module does its job by defining or modifying environment variables (and sometimes aliases and functions). For example, a module may prepend appropriate paths to `$PATH` and `$LD_LIBRARY_PATH` so that the system can find the executables and libraries associated with a given software package. The module creates the illusion that the system is installing software for your personal use. Unloading a module reverses these changes and creates the illusion that the system just uninstalled the software:

<pre class="cmd-line">$ <b>module load   ddt</b>  # defines DDT-related env vars; modifies others
$ <b>module unload ddt</b>  # undoes changes made by load</pre>

The module system does more, however. When you load a given module, the module system can automatically replace or deactivate modules to ensure the packages you have loaded are compatible with each other. In the example below, the module system automatically unloads one compiler when you load another, and replaces Intel-compatible versions of IMPI and FFTW3 with versions compatible with gcc:

<pre class="cmd-line">
$ <b>module load intel</b>  # load default version of Intel compiler
$ <b>module load fftw3</b>  # load default version of fftw3
$ <b>module load gcc</b>    # change compiler

Lmod is automatically replacing "intel/19.0.4" with "gcc/9.1.0".

Inactive Modules:
  1) python2

Due to MODULEPATH changes, the following have been reloaded:
  1) fftw3/3.3.8     2) impi/19.0.4</pre>

On Frontera, modules generally adhere to a TACC naming convention when defining environment variables that are helpful for building and running software. For example, the `papi` module defines `TACC_PAPI_BIN` (the path to PAPI executables), `TACC_PAPI_LIB` (the path to PAPI libraries), `TACC_PAPI_INC` (the path to PAPI include files), and `TACC_PAPI_DIR` (top-level PAPI directory). After loading a module, here are some easy ways to observe its effects:

<pre class="cmd-line">$ <b>module show papi</b>   # see what this module does to your environment
$ <b>env | grep PAPI</b>    # see env vars that contain the string PAPI
$ <b>env | grep -i papi</b> # case-insensitive search for 'papi' in environment</pre>

To see the modules you currently have loaded:

<pre class="cmd-line">$ <b>module list</b></pre>

To see all modules that you can load right now because they are compatible with the currently loaded modules:

<pre class="cmd-line">$ <b>module avail</b></pre>

To see all installed modules, even if they are not currently available because they are incompatible with your currently loaded modules:

<pre class="cmd-line">$ <b>module spider</b>   # list all modules, even those not available to load</pre>

To filter your search:

<pre class="cmd-line">
$ <b>module spider slep</b>             # all modules with names containing 'slep'
$ <b>module spider sundials/2.5.1</b>   # additional details on a specific module</pre>

Among other things, the latter command will tell you which modules you need to load before the module is available to load. You might also search for modules that are tagged with a keyword related to your needs (though your success here depends on the diligence of the module writers). For example:

<pre class="cmd-line">
$ <b>module keyword performance</b></pre>

You can save a collection of modules as a personal default collection that will load every time you log into Frontera. To do so, load the modules you want in your collection, then execute:

<pre class="cmd-line">
$ <b>module save</b>    # save the currently loaded collection of modules </pre>

Two commands make it easy to return to a known, reproducible state:

<pre class="cmd-line">
$ <b>module reset</b>   # load the system default collection of modules
$ <b>module restore</b> # load your personal default collection of modules</pre>

On TACC systems, the command `module reset` is equivalent to `module purge; module load TACC`. It's a safer, easier way to get to a known baseline state than issuing the two commands separately.

Help text is available for both individual modules and the module system itself:

<pre class="cmd-line">
$ <b>module help swr</b>     # show help text for software package swr
$ <b>module help</b>         # show help text for the module system itself</pre>

See [Lmod's online documentation](http://lmod.readthedocs.org) for more extensive documentation. The online documentation addresses the basics in more detail, but also covers several topics beyond the scope of the help text (e.g. writing and using your own module files).

It's safe to execute module commands in job scripts. In fact, this is a good way to write self-documenting, portable job scripts that produce reproducible results. If you use <span style="white-space: nowrap;">`module save`</span> to define a personal default module collection, it's rarely necessary to execute module commands in shell startup scripts, and it can be tricky to do so safely. If you do wish to put module commands in your startup scripts, see Frontera's default startup scripts for a safe way to do so.

![Frontera Assembly](img/img-fronteralaura.png)    
Frontera Assembly
