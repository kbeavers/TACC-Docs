# Stampede3 User Guide 

*Last update: December 18, 2023*

## [Notices](#notices) { #notices }

*This user guide is in progress and will be updated as the system is configured.*

Stampede3 Updated Timeline
*All dates subject to change based on hardware availability and condition.*   

January 2024 - Stampede3 file system available for data migration   
February 2024 - Early user period for Stampede3   
March 2024 - Stampede3 in full production   

## [Introduction](#intro) { #intro }

The National Science Foundation (NSF) has generously awarded the University of Texas at Austin funds for TACC's Stampede3 system ([Award Abstract # 2320757](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2320757)).  

### [Allocations](#intro-allocations) { #intro-allocations }

**New Allocations**: You may now submit new allocation requests for Stampede3 via [ACCESS](https://allocations.access-ci.org/). Additional allocation opportunities may also be available in the future. (11/28/2023)


## [System Architecture](#system) { #system }

### [SPR Compute Nodes](#system-spr) { #system-spr }

Stampede3 hosts 560 Sapphire Rapids HBM nodes with 112 cores each.  Each SPR node provides a performance increase of 2 - 3x over the SKX nodes due to increased core count and greatly increased memory bandwidth.  The available memory bandwidth per core increases by a factor of 3.5x.  Applications that were starved for memory bandwidth should exhibit improved performance close to 3x. 

#### [Table 1. SPR Specifications](#table1) { #table1 }

Specification | Value 
--- | ---
CPU: | Intel Xeon CPU MAX 9480 (“Sapphire Rapids HBM”)
Total cores per node: | 112 cores on two sockets (2x 56 cores)
Hardware threads per core: | 1
Hardware threads per node: | 2x56 = 112
Clock rate: | 1.9GHz
Memory: | 128 GB HBM 2e
Cache: | 48 KB L1 data cache per core; 1MB L2 per core; 112.5 MB L3 per socket. Each socket can cache up to 168.5 MB (sum of L2 and L3 capacity).
Local storage: | 150 GB /tmp partition

### [PVC Compute Nodes](#system-pvc) { #system-pvc }

Stampede3 hosts 20 nodes with four Intel Data Center GPU Max 1550s (PVC) each.  Each PVC GPU has 128 GB of HBM2e and 128 Xe cores providing a peak performance of 4x 52 FP64 TFLOPS per node for scientific workflows and 4x 832 BF16 TFLOPS for ML workflows. 

### [SKX Compute Nodes](#system-skx)  { #system-skx }

Stampede3 hosts 1,060 SKX compute nodes.

#### [Table 2. SKX Specifications](#table2) { #table2 }

Specification | Value
--- | ---
Model: | Intel Xeon Platinum 8160 (“Skylake”)
Total cores per SKX node: | 48 cores on two sockets (24 cores/socket)
Hardware threads per core: | 2
Hardware threads per node: | 48 x 2 = 96
Clock rate: | 2.1GHz nominal (1.4-3.7GHz depending on instruction set and number of active cores)
RAM: | 192GB (2.67GHz) DDR4
Cache: | 32 KB L1 data cache per core; 1 MB L2 per core; 33 MB L3 per socket. Each socket can cache up to 57 MB (sum of L2 and L3 capacity).
Local storage: | 90 GB /tmp 

### [ICX Compute Nodes](#system-icx) { #system-icx }

Stampede3 hosts 224 ICX compute nodes.

#### [Table 3. ICX Specifications](#table3) { #table3 }

Specification | Value
--- | ---
Model: | Intel Xeon Platinum 8380 (“Ice Lake”)
Total cores per ICX node: | 80 cores on two sockets (40 cores/socket)
Hardware threads per core: | 2
Hardware threads per node: | 80 x 2 = 160
Clock rate: | 2.3 GHz nominal (3.4GHz max frequency depending on instruction set and number of active cores)
RAM: | 256GB (3.2 GHz) DDR4
Cache: | 48KB L1 data cache per core; 1.25 MB L2 per core; 60 MB L3 per socket. Each socket can cache up to 110 MB (sum of L2 and L3 capacity)
Local storage: | 200 GB /tmp partition

#### [Table 4. PVC Specifications](#table4) { #table4 }

Specification | Value
--- | ---
GPU: | 4x Intel Data Center GPU Max 1550s (“Ponte Vecchio)
GPU Memory: | 128 GB HBM 2e
CPU: | Intel Xeon CPU MAX 8480 (“Sapphire Rapids”)
Total cores per node: | 112 cores on two sockets (2x 56 cores)
Hardware threads per core: | 1
Hardware threads per node: | 2x56 = 112
Clock rate: | 2.0 GHz
Memory: | 512 GB DDR5
Cache: | 48 KB L1 data cache per core; 1MB L2 per core; 112.5 MB L3 per socket. Each socket can cache up to 168.5 MB (sum of L2 and L3 capacity).
Local storage: | 150 GB /tmp partition

### [Login Nodes](#system-login) { #system-login }

The Stampede3 login nodes are Intel Xeon Platinum 8468 (SPR) nodes, each with 96 cores on two sockets (48 cores/socket) with 250 GB of DDR. 

### [Network](#network) { #system-network }

The interconnect is a 100Gb/sec Omni-Path (OPA) network with a fat tree topology. There is one leaf switch for each 28-node half rack, each with 20 leaf-to-core uplinks (28/20 oversubscription) for the SKX nodes.  The ICX and SKX nodes are fully connected.  The SPR and PVC nodes are fully connected with a fat tree topology with no oversubscription. 

The SPR and PVC networks will be upgraded to use Cornelis' CN5000 Omni-Path technology in 2024.  The backbone network will also be upgrade. 

### [File Systems](#system-filesystems) { #system-filesystems }
 
Stampede3 will use a shared VAST filesystem for the `$HOME` and `$SCRATCH` directories.  As with Stampede2, the `$WORK` lustre filesystem will also be mounted. Each file system is available from all Stampede3 nodes; the Stockyard-hosted work file system is available on most other TACC HPC systems as well. See Navigating the Shared File Systems for detailed information as well as the Good Conduct file system guidelines.

#### [Table 5. File Systems](#table5) { #table5 }

File System | Quota | Key Features
--- | --- | ---
$HOME | 15 GB, 300,000 files | Not intended for parallel or high−intensity file operations. <br> Backed up regularly. | Not purged.  
$WORK | 1 TB, 3,000,000 files across all TACC systems<br>Not intended for parallel or high−intensity file operations.<br>See [Stockyard system description](#xxx) for more information. | Not backed up. | Not purged.
$SCRATCH | no quota<br>Overall capacity ~10 PB. | Not backed up.<br>Files are subject to purge if access time* is more than 10 days old. See TACC's [Scratch File System Purge Policy](#scratchpolicy) below.

{% include 'include/scratchpolicy.md' %}

## [Accessing the System](#access) { #access }

Access to all TACC systems requires Multi-Factor Authentication (MFA). You can create an MFA pairing on the TACC User Portal. After login on the portal, go to your account profile (Home->Account Profile), then click the "Manage" button under "Multi-Factor Authentication" on the right side of the page. See [Multi-Factor Authentication at TACC](../../basics/mfa) for further information.

### [Secure Shell (SSH)](#access-ssh) { #access-ssh }

SDL The `ssh` command (SSH protocol) is the standard way to connect to Stampede3. SSH also includes support for the file transfer utilities scp and sftp. Wikipedia is a good source of information on SSH. SSH is available within Linux and from the terminal app in the Mac OS. If you are using Windows, you will need an SSH client that supports the SSH-2 protocol: e.g. Bitvise, OpenSSH, PuTTY, or SecureCRT. Initiate a session using the ssh command or the equivalent; from the Linux command line the launch command looks like this:

	localhost$ ssh myusername@stampede3.tacc.utexas.edu

The above command will rotate connections across all available login nodes and route your connection to one of them. To connect to a specific login node, use its full domain name:

	localhost$ ssh myusername@login2.stampede3.tacc.utexas.edu

To connect with X11 support on Stampede3 (usually required for applications with graphical user interfaces), use the -X or -Y switch:

	localhost$ ssh -X myusername@stampede3.tacc.utexas.edu

SDL Use your TACC password for direct logins to TACC resources. You can change your TACC password through the [TACC User Portal][TACCUSERPORTAL]. Log into the portal, then select "Change Password" under the "HOME" tab. If you've forgotten your password, go to the [TACC User Portal][TACCUSERPORTAL] home page and select "Password Reset" under the Home tab.

To report a connection problem, execute the `ssh` command with the `-vvv` option and include this command's verbose output when submitting a help ticket.

Do not run the `ssh-keygen` command on Stampede3. This command will create and configure a key pair that will interfere with the execution of job scripts in the batch system.  If you do this by mistake, you can recover by renaming or deleting the `.ssh` directory located in your home directory; the system will automatically generate a new pair for you when you next log into Stampede3.

1. execute `mv .ssh dot.ssh.old`
1. log out
1. log into Stampede3 again

After logging in again, the system will generate a properly configured key SSH pair.


## [Managing Your Files](#files) { #files }

Stampede3 mounts three file systems that are shared across all nodes: the home, work, and scratch file systems. Stampede3's startup mechanisms define corresponding account-level environment variables `$HOME`, `$SCRATCH`, and `$WORK` that store the paths to directories that you own on each of these file systems. Consult the Stampede3 File Systems table for the basic characteristics of these file systems, File Operations: I/O Performance for advice on performance issues, and Good Conduct for tips on file system etiquette.

### [Navigating the Shared File Systems](#files-filesystems) { #files-filesystems }

Stampede3's `/home` and `/scratch` file systems are mounted only on Stampede3, but the work file system mounted on Stampede3 is the Global Shared File System hosted on [Stockyard](xxx). Stockyard is the same work file system that is currently available on Frontera, Lonestar6, and several other TACC resources.

The `$STOCKYARD` environment variable points to the highest-level directory that you own on the Global Shared File System. The definition of the `$STOCKYARD` environment variable is of course account-specific, but you will see the same value on all TACC systems that provide access to the Global Shared File System. This directory is an excellent place to store files you want to access regularly from multiple TACC resources.

Your account-specific `$WORK` environment variable varies from system to system and is a sub-directory of `$STOCKYARD` (Figure 3). The sub-directory name corresponds to the associated TACC resource. The `$WORK` environment variable on Stampede3 points to the `$STOCKYARD/stampede3` subdirectory, a convenient location for files you use and jobs you run on Stampede3. Remember, however, that all subdirectories contained in your `$STOCKYARD` directory are available to you from any system that mounts the file system. If you have accounts on both Stampede3 and Frontera, for example, the `$STOCKYARD/stampede3` directory is available from your Frontera account, and `$STOCKYARD/frontera` is available from your Stampede3 account.

!!! note Your quota and reported usage on the Global Shared File System reflects all files that you own on Stockyard, regardless of their actual location on the file system.

See the example for fictitious user bjones in the figure below. All directories are accessible from all systems, however a given sub-directory (e.g. lonestar6, frontera) will exist only if you have an allocation on that system. [Figure X](xxx) below illustrates account-level directories on the `$WORK` file system (Global Shared File System hosted on Stockyard). Example for fictitious user bjones. All directories usable from all systems. Sub-directories (e.g. lonestar6, frontera) exist only when you have allocations on the associated system.

<figure><img src="../imgs/stockyard-2022.jpg">
<figcaption>Stockyard 2022</figcaption></figure>

Note that resource-specific sub-directories of `$STOCKYARD` are nothing more than convenient ways to manage your resource-specific files. You have access to any such sub-directory from any TACC resources. If you are logged into Stampede3, for example, executing the alias cdw (equivalent to cd `$WORK`) will take you to the resource-specific sub-directory `$STOCKYARD/stampede3`. But you can access this directory from other TACC systems as well by executing cd `$STOCKYARD/stampede3`. These commands allow you to share files across TACC systems. In fact, several convenient account-level aliases make it even easier to navigate across the directories you own in the shared file systems:

### [Table X. Built-in Account Level Aliases](#tablex) { #tablex }

Alias | Command
--- | ---
`cd` or `cdh` | `cd $HOME`
`cdw` | `cd $WORK`
`cds` | `cd $SCRATCH`
`cdy` or `cdg` | `cd $STOCKYARD`


### [Sharing Files with Collaborators](#files-sharing) { #files-sharing }

If you wish to share files and data with collaborators in your project, see [Sharing Project Files on TACC Systems](../../tutorials/sharingprojectfiles) for step-by-step instructions. Project managers or delegates can use Unix group permissions and commands to create read-only or read-write shared workspaces that function as data repositories and provide a common work area to all project members.

## [Building Software](#building) { #building }

The phrase "building software" is a common way to describe the process of producing a machine-readable executable file from source files written in C, Fortran, or some other programming language. In its simplest form, building software involves a simple, one-line call or short shell script that invokes a compiler. More typically, the process leverages the power of makefiles, so you can change a line or two in the source code, then rebuild in a systematic way only the components affected by the change. Increasingly, however, the build process is a sophisticated multi-step automated workflow managed by a special framework like autotools or cmake, intended to achieve a repeatable, maintainable, portable mechanism for installing software across a wide range of target platforms.

### [Basics of Building Software](#building-basics) { #building-basics }

This section of the user guide does nothing more than introduce the big ideas with simple one-line examples. You will undoubtedly want to explore these concepts more deeply using online resources. You will quickly outgrow the examples here. We recommend that you master the basics of makefiles as quickly as possible: even the simplest computational research project will benefit enormously from the power and flexibility of a makefile-based build process.

### [Intel Compilers](#building-intel) { #building-intel }

Intel is the recommended and default compiler suite on Stampede3. Each Intel module also gives you direct access to mkl without loading an mkl module; see Intel MKL for more information. 

!!! note
	The latest Intel distribution uses the OneAPI compilers which have different names than the traditional Intel compilers:

	Classic	| OneAPI
	---     | ---
	icc     | icx
	icpc    | icpx
	ifort   | ifx

Here are simple examples that use the Intel compiler to build an executable from source code:

	$ icx mycode.c                    # C source file; executable a.out
	$ icx main.c calc.c analyze.c     # multiple source files
	$ icx mycode.c     -o myexe       # C source file; executable myexe
	$ icpx mycode.cpp  -o myexe       # C++ source file
	$ ifx mycode.f90 -o myexe         # Fortran90 source file

Compiling a code that uses OpenMP would look like this:

	$ icx -qopenmp mycode.c -o myexe  # OpenMP

See the published Intel documentation, available both online and in `${TACC_INTEL_DIR}/documentation`, for information on optimization flags and other Intel compiler options.

### [GNU Compilers](#building-gnu) { #building-gnu }

The GNU foundation maintains a number of high quality compilers, including a compiler for C (gcc), C++ (g++), and Fortran (gfortran). The gcc compiler is the foundation underneath all three, and the term "gcc" often means the suite of these three GNU compilers.

Load a gcc module to access a recent version of the GNU compiler suite. Avoid using the GNU compilers that are available without a gcc module — those will be older versions based on the "system gcc" that comes as part of the Linux distribution.

Here are simple examples that use the GNU compilers to produce an executable from source code:

	$ gcc mycode.c                    # C source file; executable a.out
	$ gcc mycode.c          -o myexe  # C source file; executable myexe
	$ g++ mycode.cpp        -o myexe  # C++ source file
	$ gfortran mycode.f90   -o myexe  # Fortran90 source file
	$ gcc -fopenmp mycode.c -o myexe  # OpenMP; GNU flag is different than Intel

Note that some compiler options are the same for both Intel and GNU (e.g. `-o`), while others are different (e.g. `-qopenmp` vs `-fopenmp`). Many options are available in one compiler suite but not the other. See the online GNU documentation for information on optimization flags and other GNU compiler options.

### [Compiling and Linking as Separate Steps](#buildings-steps) { #buildings-steps }

Building an executable requires two separate steps: (1) compiling (generating a binary object file associated with each source file); and (2) linking (combining those object files into a single executable file that also specifies the libraries that executable needs). The examples in the previous section accomplish these two steps in a single call to the compiler. When building more sophisticated applications or libraries, however, it is often necessary or helpful to accomplish these two steps separately.

Use the `-c` ("compile") flag to produce object files from source files:

	$ icx -c main.c calc.c results.c

Barring errors, this command will produce object files main.o, calc.o, and results.o. Syntax for other compilers Intel and GNU compilers is similar.

You can now link the object files to produce an executable file:

	$ icx main.o calc.o results.o -o myexe

The compiler calls a linker utility (usually `/bin/ld`) to accomplish this task. Again, syntax for other compilers is similar.

### [Include and Library Paths](#building-paths) { #building-paths }

Software often depends on pre-compiled binaries called libraries. When this is true, compiling usually requires using the `-I` option to specify paths to so-called header or include files that define interfaces to the procedures and data in those libraries. Similarly, linking often requires using the `-L` option to specify paths to the libraries themselves. Typical compile and link lines might look like this:

	$ icx        -c main.c -I${WORK}/mylib/inc -I${TACC_HDF5_INC}                  # compile
	$ icx main.o -o myexe  -L${WORK}/mylib/lib -L${TACC_HDF5_LIB} -lmylib -lhdf5   # link

On Stampede3, both the hdf5 and phdf5 modules define the environment variables `$TACC_HDF5_INC` and `$TACC_HDF5_LIB`. Other module files define similar environment variables; see Using Modules to Manage Your Environment for more information.

The details of the linking process vary, and order sometimes matters. Much depends on the type of library: static (.a suffix; library's binary code becomes part of executable image at link time) versus dynamically-linked shared (.so suffix; library's binary code is not part of executable; it's located and loaded into memory at run time). The link line can use rpath to store in the executable an explicit path to a shared library. In general, however, the `$LD_LIBRARY_PATH` environment variable specifies the search path for dynamic libraries. For software installed at the system-level, TACC's modules generally modify `LD_LIBRARY_PATH` automatically. To see whether and how an executable named myexe resolves dependencies on dynamically linked libraries, execute ldd myexe.

Consult the [Intel Math Kernel Library]() (MKL) section below.

### [Compiling and Linking MPI Programs](#building-mpi) { #building-mpi }

Intel MPI (module impi) and MVAPICH2 (module mvapich2) are the two MPI libraries available on Stampede3. After loading an impi or mvapich2 module, compile and/or link using an mpi wrapper (`mpicc`, `mpicxx`, `mpif90`) in place of the compiler:

	$ mpicc    mycode.c   -o myexe   # C source, full build
	$ mpicc    -c mycode.c           # C source, compile without linking
	$ mpicxx   mycode.cpp -o myexe   # C++ source, full build
	$ mpif90   mycode.f90 -o myexe   # Fortran source, full build

These wrappers call the compiler with the options, include paths, and libraries necessary to produce an MPI executable using the MPI module you're using. To see the effect of a given wrapper, call it with the `-show` option:

	$ mpicc -show  # Show compile line generated by call to mpicc; similarly for other wrappers

### [Building Third-Party Software in Your Own Account](#building-thirdparty) { #building-thirdparty }

You're welcome to download third-party research software and install it in your own account. In most cases you'll want to download the source code and build the software so it's compatible with the Stampede3 software environment. You can't use yum or any other installation process that requires elevated privileges, but this is almost never necessary. The key is to specify an installation directory for which you have write permissions. Details vary; you should consult the package's documentation and be prepared to experiment. When using the famous three-step autotools build process, the standard approach is to use the PREFIX environment variable to specify a non-default, user-owned installation directory at the time you execute configure or make:

	$ export INSTALLDIR=$WORK/apps/t3pio
	$ ./configure --prefix=$INSTALLDIR
	$ make
	$ make install

Other languages, frameworks, and build systems generally have equivalent mechanisms for installing software in user space. In most cases a web search like "Python Linux install local" will get you the information you need.

In Python, a local install will resemble one of the following examples:

	$ pip install netCDF4     --user                    # install netCDF4 package to $HOME/.local
	$ python setup.py install --user                    # install to $HOME/.local
	$ pip install netCDF4     --prefix=$INSTALLDIR      # custom location; add to PYTHONPATH

Similarly in R:

	$ module load Rstats            # load TACC's default R
	$ R                             # launch R
	> install.packages('devtools')  # R will prompt for install location

You may, of course, need to customize the build process in other ways. It's likely, for example, that you'll need to edit a makefile or other build artifacts to specify Stampede3-specific include and library paths or other compiler settings. A good way to proceed is to write a shell script that implements the entire process: definitions of environment variables, module commands, and calls to the build utilities. Include echo statements with appropriate diagnostics. Run the script until you encounter an error. Research and fix the current problem. Document your experience in the script itself; including dead-ends, alternatives, and lessons learned. Re-run the script to get to the next error, then repeat until done. When you're finished, you'll have a repeatable process that you can archive until it's time to update the software or move to a new machine.

If you wish to share a software package with collaborators, you may need to modify file permissions. See [Sharing Files with Collaborators](../../tutorials/sharingprojectfiles) for more information.

<!-- { % include 'include/stampede3-mkl.md' % } -->

### [Building for Performance on Stampede3](#building-performance) { #building-performance }

#### [Compiler](#building-performance-compiler) { #building-performance-compiler }

When building software on Stampede3, we recommend using the most recent Intel compiler and Intel MPI library available on Stampede3. The most recent versions may be newer than the defaults. Execute module spider intel and module spider impi to see what's installed. When loading these modules you may need to specify version numbers explicitly (e.g. module load intel/24.0 and module load impi/21.11).

#### [Architecture-Specific Flags](#building-performance-archflags) { #building-performance-archflags }

To compile for for all the CPU platforms, include `-xCORE-AVX512` as a build option. The `-x` switch allows you to specify a target architecture.  The `-xCORE-AVX512` is a common subset of Intel's Advanced Vector Extensions 512-bit instruction set that is supported on SPR, ICX, and SKX.  There are some additional 512 bit optimizations implemented for machine learning on Sapphire Rapids.  Besides all other appropriate compiler options, you should also consider specifying an optimization level using the `-O` flag:

	$ icc   -xCORE-AVX512  -O3 mycode.c   -o myexe         # will run only on KNL

Similarly, to build for SKX or ICX, specify the CORE-AVX512 instruction set, which is native to SKX and ICX:

	$ ifort -xCORE-AVX512 -O3 mycode.f90 -o myexe         # will run on SKX or ICX

It's best to avoid building with `-xHost` (a flag that means "optimize for the architecture on which I'm compiling now"). The login nodes are SPR nodes.  Using `-xHost` might include AVX512 instructions that are only supported on SPR nodes. 

Don't skip the `-x` flag in a build: the default is the very old SSE2 (Pentium 4) instruction set. On Stampede3, the module files for the Intel compilers define the environment variable `$TACC_VEC_FLAGS` that stores the recommended architecture flag described above. This can simplify your builds:

	$ echo $TACC_VEC_FLAGS                         
	-xCORE-AVX512
	$ icc $TACC_VEC_FLAGS -O3 mycode.c -o myexe

If you use GNU compilers, see GNU x86 Options for information regarding support for SPR, ICX and SKX. 

[HELPDESK]: https://tacc.utexas.edu/about/help/ "Help Desk"
[CREATETICKET]: https://tacc.utexas.edu/about/help/ "Create Support Ticket"
[TACCUSERPORTAL]: https://tacc.utexas.edu/portal/login "TACC Portal login"
[TACCPORTALLOGIN]: https://tacc.utexas.edu/portal/login "TACC Portal login"
[TACCUSAGEPOLICY]: https://tacc.utexas.edu/use-tacc/user-policies/ "TACC Usage Policy"
[TACCALLOCATIONS]: https://tacc.utexas.edu/use-tacc/allocations/ "TACC Allocations"
[TACCSUBSCRIBE]: https://accounts.tacc.utexas.edu/subscriptions "Subscribe to News"
[TACCDASHBOARD]: https://tacc.utexas.edu/portal/dashboard "TACC Dashboard"

[TACCANALYSISPORTAL]: http://tap.tacc.utexas.edu "TACC Analysis Portal"

[TACCLMOD]: https://lmod.readthedocs.io/en/latest/ "Lmod"
[DOWNLOADCYBERDUCK]: https://cyberduck.io/download/ "Download Cyberduck"


[TACCREMOTEDESKTOPACCESS]: https://docs.tacc.utexas.edu/tutorials/remotedesktopaccess "TACC Remote Desktop Access"
[TACCSHARINGPROJECTFILES]: https://docs.tacc.utexas.edu/tutorials/sharingprojectfiles "Sharing Project Files"
[TACCBASHQUICKSTART]: https://docs.tacc.utexas.edu/tutorials/bashstartup "Bash Quick Start Guide"
[TACCACCESSCONTROLLISTS]: https://docs.tacc.utexas.edu/tutorials/acls "Access Control Lists"
[TACCMFA]: https://docs.tacc.utexas.edu/basics/mfa "Multi-Factor Authentication at TACC""


