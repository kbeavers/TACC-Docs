# Vista User Guide 
*Last update: August 01, 2024*

<!-- 
## Notices { #notices }

Sign up for news.
-->

## Introduction { #intro }

<!-- Please [reference TACC](https://tacc.utexas.edu/about/citing-tacc/) when providing any citations.   -->

Vista is funded by the National Science Foundation (NSF) via a supplement to the Computing for the Endless Frontier award, [Award Abstreact #1818253](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1818253).  Vista expands the Frontera project's support of Machine Learning and GPU-enabled applications with a system based on NVIDIA Grace Hopper architecture and provides a path to more power efficient computing with NVIDIA's Grace Grace ARM CPUs. 

The Grace Hopper Superchip introduces a novel architecture that combines the GPU and CPU in one module.  This technology removes the bottleneck of the PCIe bus by connecting the CPU and GPU directly with NVLINK and exposing the CPU and GPU memory space as separate NUMA nodes.  This allows the programmer to easily access CPU or GPU memory from either device.  This greatly reduces the programming complexity of GPU programs while providing increased bandwidth and reduced latency between CPU and GPU.  

The Grace Superchip connects two 72 core Grace CPUs using the same NVLINK technology used in the Grace Hopper Superchip to provide 144 ARM cores in 2 NUMA nodes.  Using LPDDR memory, each Superchip offers over 850 GiB/s of memory bandwidth and up to 7 TFlops of double precision performance. 

<!-- 
### Allocations { #intro-allocations }

*Coming soon*.
-->



## System Architecture { #system }

### Grace Grace Compute Nodes { #system-gg }

Vista hosts 256 "Grace Grace” (GG) nodes with 144 cores each. Each GG node provides a performance increase of 1.5 - 2x over the Stampede3's CLX nodes due to increased core count and increased memory bandwidth.  Each GG node provides over 7 TFlops of double precision performance and 850 GiB/s of memory bandwidth.


#### Table 1. GG Specifications { #table1 }

Specification | Value 
--- | ---
CPU: | NVIDIA Grace CPU Superchip
Total cores per node: | 144 cores on two sockets (2 x 72 cores)
Hardware threads per core: | 1
Hardware threads per node: | 2x72 = 144
Clock rate: | 3.4 GHz
Memory: | 237 GB LPDDR
Cache: | 64 KB L1 data cache per core; 1MB L2 per core; 114 MB L3 per socket.<br>Each socket can cache up to 186 MB (sum of L2 and L3 capacity).
Local storage: | 286 GB `/tmp` partition

### Grace Hopper Compute Nodes { #system-gh }

Vista hosts 600 Grace Hopper (GH) nodes. Each GH node has one H100 GPU with 96 GB of HBM3 memory and one Grace CPU with 116 GB of LPDDR memory. The GH node provides 34 TFlops of FP64 performance and 1979 TFlops of FP16 performance for ML workflows on the H100 chip.


#### Table 2. GH Specifications { #table2 }

Specification                | Value 
---                          | ---
GPU:                         | NVIDIA H100 GPU 
GPU Memory:                  | 96 GB HBM 3
CPU:                         | NVIDIA Grace CPU
Total cores per node:        | 72 cores on one socket
Hardware threads per core:   | 1
Hardware threads per node:   | 1x48 = 72
Clock rate:                  | 3.1 GHz
Memory:                      | 116 GB DDR5
Cache:                       | 64 KB L1 data cache per core; 1MB L2 per core; 114 MB L3 per socket.<br>Each socket can cache up to 186 MB (sum of L2 and L3 capacity).
Local storage:               | 286 GB `/tmp` partition

### Login Nodes { #system-login }

The Vista login nodes are NVIDIA Grace Grace (GG) nodes, each with 144 cores on two sockets (72 cores/socket) with 237 GB of LPDDR.

### Network { #system-network }

The interconnect is based on Mellanox NDR technology with full NDR (400 Gb/s) connectivity between the switches and the GH GPU nodes and with NDR200 (200 Gb/s) connectivity to the GG compute nodes. A fat tree topology connects the compute nodes and the GPU nodes within separate trees.  Both sets of nodes are connected with NDR to the `$HOME` and `$SCRATCH` file systems. 

### File Systems { #system-filesystems }

Vista will use a shared VAST file system for the `$HOME` and `$SCRATCH` directories. 

!!! important
	Vista's `$HOME` and `$SCRATCH` file systems are NOT Lustre file systems and do not support setting a stripe count or stripe size. 

As with Stampede3, the `$WORK` file system will also be mounted.  Unlike `$HOME` and `$SCRATCH`, the `$WORK` file system is a Lustre file system and supports Lustre's `lfs` commands. All three file systems, `$HOME`, `$SCRATCH`, and `$WORK` are available from all Vista nodes. The `/tmp` partition is also available to users but is local to each node. The `$WORK` file system is available on most other TACC HPC systems as well.


#### Table 3. File Systems { #table3 }

File System | Type | Quota | Key Features
---         | -- | ---   | ---
`$HOME` | VAST   | 23 GB, 500,000 files | Not intended for parallel or high−intensity file operations.<br>Backed up regularly.
`$WORK` | Lustre | 1 TB, 3,000,000 files across all TACC systems<br>Not intended for parallel or high−intensity file operations.<br>See [Stockyard system description](#xxx) for more information. | Not backed up. | Not purged.
`$SCRATCH` | VAST | no quota<br>Overall capacity ~10 PB. | Not backed up.<br>Files are subject to purge if access time* is more than 10 days old. See TACC's [Scratch File System Purge Policy](#scratchpolicy) below.

{% include 'include/scratchpolicy.md' %}


## Running Jobs { #running }

<!-- % include 'include/vista-jobaccounting.md' % -->

<!-- ### Slurm Job Scheduler { #running-slurm } -->

### Slurm Partitions (Queues) { #queues }

Vista's job scheduler is the Slurm Workload Manager. Slurm commands enable you to submit, manage, monitor, and control your jobs.  See the [Job Management](#jobmanagement) section below for further information. 

!!! important
    **Queue limits are subject to change without notice.**  
    TACC Staff will occasionally adjust the QOS settings in order to ensure fair scheduling for the entire user community.  
    Use TACC's `qlimits` utility to see the latest queue configurations.


#### Table 4. Production Queues { #table4 }

Queue Name     | Node Type     | Max Nodes per Job<br>(assoc'd cores) | Max Duration | Max Jobs in Queue | Charge Rate<br>(per node-hour)
--             | --            | --                                   | --           | --                |  
`gg`           | Grace/Grace   | 32 nodes<br>(4608 cores)             | 48 hrs       | 20                | 0.33 SU
`gg-4k`        | Grace/Grace   | 8 nodes<br>(4608 cores)              | 48 hrs       | 20                | 0.33 SU
`gh`           | Grace/Hopper  | 64 nodes<br>(4608 cores/64 gpus)     | 48 hrs       | 20                | 1 SUs
`gh-4k`        | Grace/Hopper  | 8 nodes<br>(576 cores)               | 48 hrs       | 20                | 1 SU


<!-- SDL 05/07 no skx-large yet
**&#42; To request more nodes than are available in the skx-normal queue, submit a consulting (help desk) ticket. Include in your request reasonable evidence of your readiness to run under the conditions you're requesting. In most cases this should include your own strong or weak scaling results from Vista.** -->

### Submitting Batch Jobs with `sbatch` { #running-sbatch }

Use Slurm's `sbatch` command to submit a batch job to one of the Vista queues:

```cmd-line
login1$ sbatch myjobscript
```

Where `myjobscript` is the name of a text file containing `#SBATCH` directives and shell commands that describe the particulars of the job you are submitting. The details of your job script's contents depend on the type of job you intend to run.

In your job script you (1) use `#SBATCH` directives to request computing resources (e.g. 10 nodes for 2 hrs); and then (2) use shell commands to specify what work you're going to do once your job begins. There are many possibilities: you might elect to launch a single application, or you might want to accomplish several steps in a workflow. You may even choose to launch more than one application at the same time. The details will vary, and there are many possibilities. But your own job script will probably include at least one launch line that is a variation of one of the examples described here.

Your job will run in the environment it inherits at submission time; this environment includes the modules you have loaded and the current working directory. In most cases you should run your applications(s) after loading the same modules that you used to build them. You can of course use your job submission script to modify this environment by defining new environment variables; changing the values of existing environment variables; loading or unloading modules; changing directory; or specifying relative or absolute paths to files. **Do not** use the Slurm `--export` option to manage your job's environment: doing so can interfere with the way the system propagates the inherited environment.

[Table 8.](#table8) below describes some of the most common `sbatch` command options. Slurm directives begin with `#SBATCH`; most have a short form (e.g. `-N`) and a long form (e.g. `--nodes`). You can pass options to `sbatch` using either the command line or job script; most users find that the job script is the easier approach. The first line of your job script must specify the interpreter that will parse non-Slurm commands; in most cases `#!/bin/bash` or `#!/bin/csh` is the right choice. Avoid `#!/bin/sh` (its startup behavior can lead to subtle problems on Vista), and do not include comments or any other characters on this first line. All `#SBATCH` directives must precede all shell commands. Note also that certain `#SBATCH` options or combinations of options are mandatory, while others are not available on Vista.

By default, Slurm writes all console output to a file named "`slurm-%j.out`", where `%j` is the numerical job ID. To specify a different filename use the `-o` option. To save `stdout` (standard out) and `stderr` (standard error) to separate files, specify both `-o` and `-e` options.

!!! tip
	The maximum runtime for any individual job is 48 hours.  However, if you have good checkpointing implemented, you can easily chain jobs such that the outputs of one job are the inputs of the next, effectively running indefinitely for as long as needed.  See Slurm's `-d` option.

#### Table 8. Common `sbatch` Options { #table8 }

Option | Argument | Comments
--- | --- | ---
`-A`  | *projectid* | Charge job to the specified project/allocation number. This option is only necessary for logins associated with multiple projects.
`-a`<br>or<br>`-array` | N/A | Not available. See tip below.
`-d=` | afterok:*jobid* | Specifies a dependency: this run will start only after the specified job (jobid) successfully finishes
`-export=` | N/A | Avoid this option on Vista. Using it is rarely necessary and can interfere with the way the system propagates your environment.
`-p`  | *queue_name* | Submits to queue (partition) designated by queue_name
`-J`  | *job_name*   | Job Name
`-N`  | *total_nodes* | Required. Define the resources you need by specifying either:<br>(1) `-N` and `-n`; or<br>(2) `-N` and `-ntasks-per-node`.
`-n`  | *total_tasks* | This is total MPI tasks in this job. See `-N` above for a good way to use this option. When using this option in a non-MPI job, it is usually best to set it to the same value as `-N`.
`-ntasks-per-node`<br>or<br>`-tasks-per-node` | tasks_per_node | This is MPI tasks per node. See `-N` above for a good way to use this option. When using this option in a non-MPI job, it is usually best to set `-ntasks-per-node` to 1.
`-t`  | *hh:mm:ss* | Required. Wall clock time for job.
`-mail-type=` | `begin`, `end`, `fail`, or `all` | Specify when user notifications are to be sent (one option per line).
`-mail-user=` | *email_address* | Specify the email address to use for notifications. Use with the `-mail-type=` flag above.
`-o`  | *output_file* | Direct job standard output to output_file (without `-e` option error goes to this file)
`-e`  | *error_file* | Direct job error output to error_file
`-mem`  | N/A | Not available. If you attempt to use this option, the scheduler will not accept your job.

!!!tip
	TACC does not support Slurm's `-array` option.  Instead, use TACC's [PyLauncher](../../software/pylauncher) utility for parameter sweeps and other collections of related serial jobs.

### NVIDIA Performance Library

## NVIDIA Performance Libraries {nvpl}

The [NVIDIA Performance Libraries (NVPL)](https://docs.nvidia.com/nvpl/) are a collection of high-performance mathematical libraries optimized for the NVIDIA Grace Armv9.0 architecture. These CPU-only libraries are for standard C and Fortran mathematical APIs allowing HPC applications to achieve maximum performance on the Grace platform. The collection includes:

* [NVPL BLAS Documentation](https://docs.nvidia.com/nvpl/_static/blas/index.html)
* [NVPL FFT Documentation](https://docs.nvidia.com/nvpl/_static/fft/index.html)
* [NVPL LAPACK Documentation](https://docs.nvidia.com/nvpl/_static/lapack/index.html)
* [NVPL RAND Documentation](https://docs.nvidia.com/nvpl/_static/rand/index.html)
* [NVPL ScaLAPACK Documentation](https://docs.nvidia.com/nvpl/_static/scalapack/index.html)
* [NVPL Sparse Documentation](https://docs.nvidia.com/nvpl/_static/sparse/index.html)
* [NVPL Tensor Documentation](https://docs.nvidia.com/nvpl/_static/tensor/index.html)

Consult the above documents for the details of each library and its API for building and linking codes. The libraries work with both NVHPC and GCC compilers, as well as their corresponding MPI wrappers. All libraries support the OpenMP runtime libraries. Refer to individual libraries documentation for details and API extensions supporting nested parallelism.

**Example**: A compile/link process on Vista may look like the following:
This links the code against the NVPL FFT library using the GNU `g++` compiler. 
The features in NVPL FFT are still evolving, please pay close attention and follow the latest NVPL FFT document. 

```cmd-line
$ module load nvpl
$ g++ mycode.cpp -I$TACC_NVPL_DIR}/include \
		-L$TACC_NVPL_DIR}/lib \
		-lnvpl_fftw \
		-o myprogram
```

**Example**: This links the code against the NVPL OpenMP threaded BLAS, LAPACK, and SCALAPACK libraries of 32 bit integer interface using the NVHPC mpif90 wrapper. The cluster capability of BLAS from current NVPL release from NVHPC SDK-24.5 includes openmpi3,4,5 and mpich, choose the one that matches the MPI version in mpif90. 


```cmd-line
$ module load nvpl            
$ mpif90 -mp -I$TACC_NVPL_DIR}/include  \
       -L${TACC_NVPL_DIR}/lib   \
       -lnvpl_blas_lp64_gomp   \
       -lnvpl_lapack_lp64_gomp  \
      -lnvpl_blacs_lp64_openmpi5 \
      -lnvpl_scalapack_lp64   \
       mycode.f90
```


When linking using NVHPC compiler, convenient flags `-Mnvpl` and `-Mscalapackare` provided. As the behavior of these flags may change during active development, please refer to the latest <https://docs.nvidia.com/hpc-sdk//compilers/hpc-compilers-user-guide/index.html%23lib-use-lapack-blas-ffts>NVHPC compiler guide</a>for more details. 

#### Using NVPL as BLAS/LAPACK with Third-Party Software

When your third-party software requires BLAS or LAPACK, we recommend that you use NVPL to supply this functionality. Replace generic instructions that include link options like -lblas or -llapack with the NVPL approach described above. Generally there is no need to download and install alternatives like OpenBLAS. However, since the NVPL is a relatively new math library suite targeting the aarch64, its interoperability to other softwares with a special 32 or 64 bit integer interface, or OpenMP runting support are not fully tested yet. If you have issues with NVPL and alternative BLAS, LAPACK libraries are needed, the OpenBLAS based ones are available as a part of NVHPC compiler libraries. 

#### Controlling Threading in NVPL

All NVPL libraries support the both GCC and NVHPC OpenMP runtime libraries. See individual libraries documentation for details and API extensions supporting nested parallelism. NVPL Libraries do not explicitly link any particular OpenMP runtime, they rely on runtime loading of the OpenMP library as determined by the application and environment. Applications linked to NVPL should always use at runtime the same OpenMP distribution the application was compiled with. Mixing OpenMP distributions from compile-time to runtime may result in anomalous performance.  Please note that the default lib linked with -Mnvpl flag is single threaded as of NVHPC 24.5, -mpflag is needed to linked with the threaded version. 
	

NVIDIA HPC modules provide a libgomp.sosymlink to libnvomp.so. This symlink will be on LD_LIBRARY_PATHif NVHPC environment modules are loaded. Use (https://man7.org/linux/man-pages/man1/ldd.1.html) <a https://man7.org/linux/man-pages/man1/ldd.1.html>ldd</a>to ensure that applications built with GCC do not accidentally load libgomp.sosymlink from HPC SDK due to LD_LIBRARY_PATH. Use libnvomp.soif and only-if the application was built with NVHPC compilers.
	

`$OMP_NUM_THREADS` defaults to 1 on TACC systems. If you use the default value you will get no thread-based parallelism from NVPL. Setting the environment variable $OMP_NUM_THREADS to control the number of threads for optimal performance.
	

#### Using NVPL with other MATLAB, PYTHON and R

TACC MATLAB, Python and R modules need BLAS and LAPACK and other math libraries for performance. How to use NVPL with them is under investigation. We will update.
[HELPDESK]: https://tacc.utexas.edu/about/help/ "Help Desk"
[CREATETICKET]: https://tacc.utexas.edu/about/help/ "Create Support Ticket"
[SUBMITTICKET]: https://tacc.utexas.edu/about/help/ "Submit Support Ticket"
[TACCUSERPORTAL]: https://tacc.utexas.edu/portal/login "TACC Portal login"
[TACCPORTALLOGIN]: https://tacc.utexas.edu/portal/login "TACC Portal login"
[TACCUSAGEPOLICY]: https://tacc.utexas.edu/use-tacc/user-policies/ "TACC Usage Policy"
[TACCALLOCATIONS]: https://tacc.utexas.edu/use-tacc/allocations/ "TACC Allocations"
[TACCSUBSCRIBE]: https://accounts.tacc.utexas.edu/subscriptions "Subscribe to News"
[TACCDASHBOARD]: https://tacc.utexas.edu/portal/dashboard "TACC Dashboard"
[TACCPROJECTS]: https://tacc.utexas.edu/portal/projects "Projects & Allocations"


[TACCANALYSISPORTAL]: http://tap.tacc.utexas.edu "TACC Analysis Portal"

[TACCLMOD]: https://lmod.readthedocs.io/en/latest/ "Lmod"
[DOWNLOADCYBERDUCK]: https://cyberduck.io/download/ "Download Cyberduck"


[TACCREMOTEDESKTOPACCESS]: https://docs.tacc.utexas.edu/tutorials/remotedesktopaccess "TACC Remote Desktop Access"
[TACCSHARINGPROJECTFILES]: https://docs.tacc.utexas.edu/tutorials/sharingprojectfiles "Sharing Project Files"
[TACCBASHQUICKSTART]: https://docs.tacc.utexas.edu/tutorials/bashstartup "Bash Quick Start Guide"
[TACCACCESSCONTROLLISTS]: https://docs.tacc.utexas.edu/tutorials/acls "Access Control Lists"
[TACCMFA]: https://docs.tacc.utexas.edu/basics/mfa "Multi-Factor Authentication at TACC""
[TACCIDEV]: https://docs.tacc.utexas.edu/software/idev "idev at TACC""


