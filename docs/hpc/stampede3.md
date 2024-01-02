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

You are welcome to download third-party research software and install it in your own account. In most cases you'll want to download the source code and build the software so it's compatible with the Stampede3 software environment. You can't use yum or any other installation process that requires elevated privileges, but this is almost never necessary. The key is to specify an installation directory for which you have write permissions. Details vary; you should consult the package's documentation and be prepared to experiment. When using the famous three-step autotools build process, the standard approach is to use the `PREFIX` environment variable to specify a non-default, user-owned installation directory at the time you execute `configure` or `make`:

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

### [Intel oneAPI Math Kernel Library (MKL)](#mkl) { #mkl }

The [Intel oneAPI Math Kernel Library](http://software.intel.com/intel-mkl) (MKL) is a collection of highly optimized functions implementing some of the most important mathematical kernels used in computational science, including standardized interfaces to:

* [BLAS](http://netlib.org/blas) (Basic Linear Algebra Subroutines), a collection of low-level matrix and vector operations like matrix-matrix multiplication
* [LAPACK](http://netlib.org/lapack) (Linear Algebra PACKage), which includes higher-level linear algebra algorithms like Gaussian Elimination
* FFT (Fast Fourier Transform), including interfaces based on [FFTW](http://fftw.org) (Fastest Fourier Transform in the West)
* [ScaLAPACK](http://netlib.org/scalapack) (Scalable LAPACK), [BLACS](http://netlib.org/blacs) (Basic Linear Algebra Communication Subprograms), Cluster FFT, and other functionality that provide block-based distributed memory (multi-node) versions of selected [LAPACK](https://software.intel.com/en-us/mkl-developer-reference-c-lapack-routines), [BLAS](https://software.intel.com/en-us/mkl-developer-reference-c-blas-and-sparse-blas-routines), and [FFT](https://software.intel.com/en-us/mkl-developer-reference-c-fft-functions) algorithms;
* [Vector Mathematics](http://software.intel.com/en-us/node/521751) (VM) functions that implement highly optimized and vectorized versions of special functions like sine and square root.

#### [MKL with Intel C, C++, and Fortran Compilers](#mkl-intel) { #mkl-intel }

There is no MKL module for the Intel compilers because you don't need one: the Intel compilers have built-in support for MKL. Unless you have specialized needs, there is no need to specify include paths and libraries explicitly. Instead, using MKL with the Intel modules requires nothing more than compiling and linking with the `-mkl` option.; e.g.

	$ icx -qmkl mycode.c
	$ ifx -qmkl mycode.c

The `-qmkl` switch is an abbreviated form of `-qmkl=parallel`, which links your code to the threaded version of MKL. To link to the unthreaded version, use `-qmkl=sequential`. A third option, `-qmkl=cluster`, which also links to the unthreaded libraries, is necessary and appropriate only when using ScaLAPACK or other distributed memory packages. For additional information, including advanced linking options, see the MKL documentation and Intel MKL Link Line Advisor.

#### [MKL with GNU C, C++, and Fortran Compilers](#mkl-gnu) { #mkl-gnu }

When using a GNU compiler, load the MKL module before compiling or running your code, then specify explicitly the MKL libraries, library paths, and include paths your application needs. Consult the Intel MKL Link Line Advisor for details. A typical compile/link process on a TACC system will look like this:

	$ module load gcc
	$ module load mkl                         # available/needed only for GNU compilers
	$ gcc -fopenmp -I$MKLROOT/include         \
	         -Wl,-L${MKLROOT}/lib/intel64     \
	         -lmkl_intel_lp64 -lmkl_core      \
	         -lmkl_gnu_thread -lpthread       \
	         -lm -ldl mycode.c

For your convenience the `mkl` module file also provides alternative TACC-defined variables like `$TACC_MKL_INCLUDE` (equivalent to `$MKLROOT/include`). For more information:

	$ module help mkl 

#### [Using MKL as BLAS/LAPACK with Third-Party Software](#mkl-thirdparty) { #mkl-thirdparty }

When your third-party software requires BLAS or LAPACK, you can use MKL to supply this functionality. Replace generic instructions that include link options like `-lblas` or `-llapack` with the simpler MKL approach described above. There is no need to download and install alternatives like OpenBLAS.

#### [Using MKL as BLAS/LAPACK with TACC's MATLAB, Python, and R Modules](#mkl-tacc) { #mkl-tacc }

TACC's MATLAB, Python, and R modules all use threaded (parallel) MKL as their underlying BLAS/LAPACK library. These means that even serial codes written in MATLAB, Python, or R may benefit from MKL's thread-based parallelism. This requires no action on your part other than specifying an appropriate max thread count for MKL; see the section below for more information.

#### [Controlling Threading in MKL](#mkl-threading) { #mkl-threading }

Any code that calls MKL functions can potentially benefit from MKL's thread-based parallelism; this is true even if your code is not otherwise a parallel application. If you are linking to the threaded MKL (using `-qmkl`, `-qmkl=parallel`, or the equivalent explicit link line), you need only specify an appropriate value for the max number of threads available to MKL. You can do this with either of the two environment variables `$MKL_NUM_THREADS` or `$OMP_NUM_THREADS`. The environment variable `$MKL_NUM_THREADS` specifies the max number of threads available to each instance of MKL, and has no effect on non-MKL code. If `$MKL_NUM_THREADS` is undefined, MKL uses `$OMP_NUM_THREADS` to determine the max number of threads available to MKL functions. In either case, MKL will attempt to choose an optimal thread count less than or equal to the specified value. Note that `$OMP_NUM_THREADS` defaults to 1 on TACC systems; if you use the default value you will get no thread-based parallelism from MKL.

If you are running a single serial, unthreaded application (or an unthreaded MPI code involving a single MPI task per node) it is usually best to give MKL as much flexibility as possible by setting the max thread count to the total number of hardware threads on the node (96 on SKX, 160 on ICX, 112 on SPR). Of course things are more complicated if you are running more than one process on a node: e.g. multiple serial processes, threaded applications, hybrid MPI-threaded applications, or pure MPI codes running more than one MPI rank per node. See <http://software.intel.com/en-us/articles/recommended-settings-for-calling-intel-mkl-routines-from-multi-threaded-applications> and related Intel resources for examples of how to manage threading when calling MKL from multiple processes.

#### [Using ScaLAPACK, Cluster FFT, and Other MKL Cluster Capabilities](#mkl-othercapabilities) { #mkl-othercapabilities }

MKL References

* [Intel oneAPI Math Kernel Library Link Line Advisor](https://www.intel.com/content/www/us/en/developer/tools/oneapi/onemkl-link-line-advisor.html)
* [Working with the Intel® oneAPI Math Kernel Library Cluster Software](https://www.intel.com/content/www/us/en/docs/onemkl/developer-guide-linux/2023-0/working-with-onemkl-cluster-software.html)

## [Running Jobs](#running)

{% include 'include/stampede2-jobaccounting.md' %}

Slurm Job Scheduler
Stampede3's job scheduler is the Slurm Workload Manager. Slurm commands enable you to submit, manage, monitor, and control your jobs.
Slurm Partitions (Queues)
Currently available queues include those in Stampede3 Production Queues. 

#### Table 5. Production Queues { #table5 }

Queue Name   | Node Type | Max Nodes per Job<br>(assoc'd cores)* | Max Duration | Max Jobs in Queue* | Charge Rate<br>(per node-hour)
--           | --        | --                                    | --           | --                 |  
skx-dev      | SKX       | 4 nodes<br>(192 cores)*               | 2 hrs        | 1 *                | 1 SU
skx-normal   | SKX       | 128 nodes<br>(6,144 cores) *          | 48 hrs       | 20 *               | 1 SU
skx-large ** | SKX       | 384 nodes<br>(18,432 cores) *         | 48 hrs       | 3 *                | 1 SU
icx-normal   | ICX       | 40 nodes<br>(3,200 cores) *           | 48 hrs       | 20 *               | 1.67 SU
spr-normal   | SPR       | 100 nodes<br>(11,200 cores) *         | 48 hrs       | 20 *               | 3 SU
pvc          | PVC       | 5 nodes<br>(20 PVCs) *                | 48 hrs       | 20 *               | 5 SU

* Queues and limits are subject to change without notice. Execute qlimits on Stampede3 for real-time information regarding limits on available queues. See Monitoring Jobs and Queues for additional information.
** To request more nodes than are available in the skx-normal queue, submit a consulting (help desk) ticket. Include in your request reasonable evidence of your readiness to run under the conditions you're requesting. In most cases this should include your own strong or weak scaling results from Stampede3.

### [Submitting Batch Jobs with sbatch]()

Use Slurm's sbatch command to submit a batch job to one of the Stampede3 queues:

	login1$ sbatch myjobscript

Here myjobscript is the name of a text file containing #SBATCH directives and shell commands that describe the particulars of the job you are submitting. The details of your job script's contents depend on the type of job you intend to run.

In your job script you (1) use #SBATCH directives to request computing resources (e.g. 10 nodes for 2 hrs); and then (2) use shell commands to specify what work you're going to do once your job begins. There are many possibilities: you might elect to launch a single application, or you might want to accomplish several steps in a workflow. You may even choose to launch more than one application at the same time. The details will vary, and there are many possibilities. But your own job script will probably include at least one launch line that is a variation of one of the examples described here.

Your job will run in the environment it inherits at submission time; this environment includes the modules you have loaded and the current working directory. In most cases you should run your applications(s) after loading the same modules that you used to build them. You can of course use your job submission script to modify this environment by defining new environment variables; changing the values of existing environment variables; loading or unloading modules; changing directory; or specifying relative or absolute paths to files. Do not use the Slurm --export option to manage your job's environment: doing so can interfere with the way the system propagates the inherited environment.

The Common sbatch Options table below describes some of the most common sbatch command options. Slurm directives begin with #SBATCH; most have a short form (e.g. -N) and a long form (e.g. --nodes). You can pass options to sbatch using either the command line or job script; most users find that the job script is the easier approach. The first line of your job script must specify the interpreter that will parse non-Slurm commands; in most cases #!/bin/bash or #!/bin/csh is the right choice. Avoid #!/bin/sh (its startup behavior can lead to subtle problems on Stampede3), and do not include comments or any other characters on this first line. All #SBATCH directives must precede all shell commands. Note also that certain #SBATCH options or combinations of options are mandatory, while others are not available on Stampede3.

#### [Table X. Common sbatch Options](#tablex)

Option | Argument | Comments
--- | --- | ---
-p  | queue_name | Submits to queue (partition) designated by queue_name
-J  | job_name   | Job Name
-N  | total_nodes | Required. Define the resources you need by specifying either:<br>(1) -N and -n; or<br>(2) -N and –ntasks-per-node.
-n  | total_tasks | This is total MPI tasks in this job. See -N above for a good way to use this option. When using this option in a non-MPI job, it is usually best to set it to the same value as -N.
–ntasks-per-node
or
–tasks-per-node
tasks_per_node
This is MPI tasks per node. See -N above for a good way to use this option. When using this option in a non-MPI job, it is usually best to set –ntasks-per-node to 1.
-t
hh:mm:ss
Required. Wall clock time for job.
–mail-user=
email_address
Specify the email address to use for notifications. Use with the –mail-type= flag below.
–mail-type=
begin, end, fail, or all
Specify when user notifications are to be sent (one option per line).
-o
output_file
Direct job standard output to output_file (without -e option error goes to this file)
-e
error_file
Direct job error output to error_file
-d=
afterok:jobid
Specifies a dependency: this run will start only after the specified job (jobid) successfully finishes
-A
projectid
Charge job to the specified project/allocation number. This option is only necessary for logins associated with multiple projects.
-a
or
–array
N/A
Not available. Use the launcher module for parameter sweeps and other collections of related serial jobs.
–mem
N/A
Not available. If you attempt to use this option, the scheduler will not accept your job.
–export=
N/A
Avoid this option on Stampede3. Using it is rarely necessary and can interfere with the way the system propagates your environment.

By default, Slurm writes all console output to a file named slurm-%j.out, where %j is the numerical job ID. To specify a different filename use the -o option. To save stdout (standard out) and stderr (standard error) to separate files, specify both -o and -e.

## [Programming and Performance](#programming)

Programming for performance is a broad and rich topic. While there are no shortcuts, there are certainly some basic principles that are worth considering any time you write or modify code.

### [Timing and Profiling](#programming-timing)

Measure performance and experiment with both compiler and runtime options. This will help you gain insight into issues and opportunities, as well as recognize the performance impact of code changes and temporary system conditions.

Measuring performance can be as simple as prepending the shell keyword `time` or the command `perf stat` to your launch line. Both are simple to use and require no code changes. Typical calls look like this:

	$ perf stat ./a.out    # report basic performance stats for a.out
	$ time ./a.out         # report the time required to execute a.out
	$ time ibrun ./a.out   # time an MPI code
	$ ibrun time ./a.out   # crude timings for each MPI task (no rank info)

As your needs evolve you can add timing intrinsics to your source code to time specific loops or other sections of code. There are many such intrinsics available; some popular choices include [`gettimeofday`](https://man7.org/linux/man-pages/man2/gettimeofday.2.html), [`MPI_Wtime`](https://www.mpich.org/static/docs/v3.2/www3/MPI_Wtime.html) and [`omp_get_wtime`](https://www.openmp.org/spec-html/5.0/openmpsu160.html). The resolution and overhead associated with each of these timers is on the order of a microsecond.

It can be helpful to compare results with different compiler and runtime options: e.g. with and without vectorization, threading, or Lustre striping. You may also want to learn to use profiling tools like Intel VTune Amplifier (`module load vtune`) or GNU `gprof`.

### [Data Locality](#performance-datalocality)

Appreciate the high cost (performance penalty) of moving data from one node to another, from disk to memory, and even from memory to cache. Write your code to keep data as close to the computation as possible: e.g. in memory when needed, and on the node that needs it. This means keeping in mind the capacity and characteristics of each level of the memory hierarchy when designing your code and planning your simulations. 

When possible, best practice also calls for so-called "stride 1 access" - looping through large, contiguous blocks of data, touching items that are adjacent in memory as the loop proceeds. The goal here is to use "nearby" data that is already in cache rather than going back to main memory (a cache miss) in every loop iteration.

To achieve stride 1 access you need to understand how your program stores its data. Here C and C++ are different than (in fact the opposite of) Fortran. C and C++ are row-major: they store 2d arrays a row at a time, so elements `a[3][4]` and `a[3][5]` are adjacent in memory. Fortran, on the other hand, is column-major: it stores a column at a time, so elements `a(4,3)` and `a(5,3)` are adjacent in memory. Loops that achieve stride 1 access in the two languages look like this:

<table border="1">
<tr><th>Fortran example</th><th>C example</th></tr>
<tr><td><pre>
real*8 :: a(m,n), b(m,n), c(m,n)
 ...
! inner loop strides through col i
do i=1,n
  do j=1,m
    a(j,i)=b(j,i)+c(j,i)
  end do
end do
</pre>
</td><td><pre>
double a[m][n], b[m][n], c[m][n];
 ...
// inner loop strides through row i
for (i=0;i<m;i++){
  for (j=0;j<n;j++){
    a[i][j]=b[i][j]+c[i][j];
  }
}</pre></td></tr></table>

### [Vectorization](#programming-vectorization)

Give the compiler a chance to produce efficient, vectorized code. The compiler can do this best when your inner loops are simple (e.g. no complex logic and a straightforward matrix update like the ones in the examples above), long (many iterations), and avoid complex data structures (e.g. objects). See Intel's note on Programming Guidelines for Vectorization for a nice summary of the factors that affect the compiler's ability to vectorize loops.

It's often worthwhile to generate optimization and vectorization reports when using the Intel compiler. This will allow you to see exactly what the compiler did and did not do with each loop, together with reasons why.

The literature on optimization is vast. Some places to begin a systematic study of optimization on Intel processors include: Intel's Modern Code resources; and the Intel Optimization Reference Manual.

### [Programming and Performance: SPR, ICX, and SKX](#programming-nodes)

**Clock Speed**: The published nominal clock speed of the Stampede3 SPR processors is 1.9 GHz, for the SKX processors it is 2.1GHz, and for the ICX processors it is 2.3GHz. But actual clock speed varies widely: it depends on the vector instruction set, number of active cores, and other factors affecting power requirements and temperature limits. At one extreme, a single serial application using the AVX2 instruction set may run at frequencies approaching 3.7GHz, because it's running on a single core (in fact a single hardware thread). At the other extreme, a large, fully-threaded MKL `dgemm` (a highly vectorized routine in which all cores operate at nearly full throttle) may run at 1.9 GHz.

**Vector Optimization and AVX2**: In some cases, using the AVX2 instruction set may produce better performance than AVX512. This is largely because cores can run at higher clock speeds when executing AVX2 code. To compile for AVX2, replace the multi-architecture flags described above with the single flag `-xCORE-AVX2`. When you use this flag you will be able to build and run on any Stampede3 node.

**Vector Optimization and 512-Bit ZMM Registers**. If your code can take advantage of wide 512-bit vector registers, you may want to try compiling for with (for example):

	-xCORE-AVX512 -qopt-zmm-usage=high

The `qopt-zmm-usage` flag affects the algorithms the compiler uses to decide whether to vectorize a given loop with AVX51 intrinsics (wide 512-bit registers) or AVX2 code (256-bit registers). When the flag is set to `-qopt-zmm-usage=low` (the default when compiling for SPR, ICX, and SKX using CORE-AVX512), the compiler will choose AVX2 code more often; this may or may not be the optimal approach for your application.  See the recent Intel white paper, the compiler documentation, the compiler man pages, and the notes above for more information.

**Task Affinity**: If you run one MPI application at a time, the ibrun MPI launcher will spread each node's tasks evenly across an SPR, ICX, or SKX node's two sockets, with consecutive tasks occupying the same socket when possible.

**Hardware Thread Numbering**. Execute `lscpu` or `lstopo` on SPR, ICX, or SKX nodes to see the numbering scheme for cores. Note that core numbers alternate between the sockets on SKX and ICX nodes: even numbered cores are on NUMA node 0, while odd numbered cores are on NUMA node 1. 

**Tuning the Performance Scaled Messaging (PSM2) Library**. When running on SKX with MVAPICH2, setting the environment variable `PSM2_KASSIST_MODE` to the value `none` may or may not improve performance. For more information see the MVAPICH2 User Guide. Do not use this environment variable with IMPI; doing so may degrade performance. The ibrun launcher will eventually control this environment variable automatically.

### [File Operations: I/O Performance](#programming-io)

This section includes general advice intended to help you achieve good performance during file operations. <!-- See TACC Training material for additional information on I/O performance. -->

**Follow the advice in [TACC Good Conduct Guide](basics/conduct) to avoid stressing the file system**.

**Aggregate file operations**: Open and close files once. Read and write large, contiguous blocks of data at a time; this requires understanding how a given programming language uses memory to store arrays.

**Be smart about your general strategy**: When possible avoid an I/O strategy that requires each process to access its own files; such strategies don't scale well and are likely to stress a parallel file system. A better approach is to use a single process to read and write files. Even better is genuinely parallel MPI-based I/O.

**Use parallel I/O libraries**: Leave the details to a high performance package like MPI-IO (built into MPI itself), parallel HDF5 (`module load phdf5`), and parallel netCDF (`module load pnetcdf`).

When using the Intel Fortran compiler, compile with the `-assume buffered_io` flag. Equivalently, set the environment variable `FORT_BUFFERED=TRUE`. Doing otherwise can dramatically slow down access to variable length unformatted files. More generally, direct access in Fortran is typically faster than sequential access, and accessing a binary file is faster than ASCII.

# [References](#refs) { #refs }

* [Bash Users’ Startup Files: Quick Start Guide](TACCBASHQUICKSTART)
* idev documentation
* GNU documentation
* Intel software documentation
* Lmod’s online documentation
* [Multi-Factor Authentication at TACC](../../tutorials/mfa)
* [Sharing Project Files on TACC Systems](../../tutorials/sharingprojectfiles)
* Slurm online documentation
* TACC Analysis Portal
* Stockyard (TACC's Global Shared File System)

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


