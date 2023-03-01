# GROMACS at TACC
*Last update: December 7, 2022*

<img alt="GROMACS logo" src="../../../imgs/software/gromacs-logo.png" style="width:25%;">
<b>GRO</b>ningen <b>MA</b>chine for <b>C</b>hemical <b>S</b>imulations (GROMACS) is a free, open-source, molecular dynamics package. GROMACS can simulate the Newtonian equations of motion for systems with hundreds to millions of particles. GROMACS is primarily designed for biochemical molecules like proteins, lipids and nucleic acids that have a lot of complicated bonded interactions, but since GROMACS is extremely fast at calculating the nonbonded interactions (that usually dominate simulations), many groups are also using it for research on non-biological systems, e.g. polymers.

## [Installations](#installations) { #installations }

GROMACS is currently installed on TACC's [Stampede2][STAMPEDE2UG], [Frontera][FRONTERAUG], and [Lonestar6][LONESTAR6UG] systems. GROMACS is managed under the [Modules][TACCMODULES] system on TACC resources. To run simulations, simply load the module with the following command:

``` cmd-line
login1$ module load gromacs
```

As of this date, the GROMACS versions are 2022.1 on Stampede2, 2019.6 on Frontera, and 2021.3 on Lonestar6. Users are welcome to install different versions of GROMACS in their own directories. See [Building Third Party Software][STAMPEDE2UGBUILDING] in the Stampede2 User Guide. The module file defines the environment variables listed below. Learn more from the module's help file:

``` cmd-line
login1$ module help gromacs
```

### [Table 1. GROMACS Environment Variables](#table1) { #table1 }

Variable | Value
--- | ---
<code>TACC_GROMACS_DIR</code> | GROMACS installation root directory
<code>TACC_GROMACS_BIN</code> | binaries
<code>TACC_GROMACS_DOC</code> | documentation
<code>TACC_GROMACS_LIB</code> | libraries
<code>TACC_GROMACS_INC</code> | include files
<code>GMXLIB</code> | topology file directory

## [Running GROMACS](#running) { #running }


To launch simulation jobs, please use the TACC-specific MPI launcher `ibrun`, which is a TACC-system-aware replacement for generic MPI launchers like `mpirun` and `mpiexec`. The executable, `gmx_mpi`, is the parallel component of GROMACS. It can be invoked in a job script like this:

``` { .bash .job-script }
ibrun gmx_mpi mdrun -s topol.tpr -o traj.trr -c confout.gro -e ener.edr -g md.log
```

In the above command, `gmx_mpi` (single-precision) can be replaced by `gmx_mpi_d` (double-precision) or `gmx_tmpi` (single-precision, single-node thread-MPI). Please refer to the GROMACS manual for more information.

On Stampede2, the executables with a `_knl` postfix should be run on the KNL nodes only in the appropriate queues.

On Frontera and Lonestar6, you may use `gmx_mpi_gpu` instead of `gmx_mpi` to run GROMACS on GPUs nodes. Note that not all GROMACS modules on the TACC systems support GPU acceleration. Consult `module help` to find details about supported functionality.

You can also compile and link your own source code with the GROMACS libraries:

``` cmd-line
login1$ icc -I$TACC_GROMACS_INC test.c -L$TACC_GROMACS_LIB –lgromacs
```

### [Running GROMACS in Batch Mode](#running-batch) { #running-sbatch }

Use Slurm's `sbatch` command to submit a batch job to one of the Stampede2 queues:

``` cmd-line
login1$ sbatch myjobscript
```

Here `myjobscript` is the name of a text file containing `#SBATCH` directives and shell commands that describe the particulars of the job you are submitting. 

### [Frontera Job Scripts](#jobscript-frontera) { #jobscript-frontera }

Here are two job scripts for running the latest version of GROMACS on Frontera.  The first script runs on Frontera's CPUs and the second runs on Frontera's GPUs.

#### [CPU](#jobscript-frontera-cpu) { #jobscript-frontera-cpu }

The following job script requests 4 nodes (56 cores/node) for 24 hours using Frontera CLX compute nodes (`normal` queue).

<pre class="jobs-script">
#!/bin/bash
#SBATCH -J myjob              # job name
#SBATCH -e myjob.%j.err       # error file name 
#SBATCH -o myjob.%j.out       # output file name 
#SBATCH -N 4                  # request 4 nodes
#SBATCH -n 224                # request 4x56=224 MPI tasks 
#SBATCH -p normal             # designate queue 
#SBATCH -t 24:00:00           # designate max run time 
#SBATCH -A myproject          # charge job to myproject 
module load gromacs/2022.1
export OMP_NUM_THREADS=1      # 1 OMP thread per MPI task

ibrun gmx_mpi mdrun -s topol.tpr -o traj.trr -c confout.gro -e ener.edr -g md.log</pre>
 
#### [GPU](#jobscript-frontera-gpu) { #jobscript-frontera-gpu }

The following job script requests 4 RTX GPU nodes on Frontera. The `-gpu_id 0000` directive indicates all four MPI ranks on the same node share the same GPU with id 0. You may use, for example `-gpu_id 0123`, to use all four available GPUs on each RTX node.

<pre class="jobs-script">
#!/bin/bash
#SBATCH -J myjob      	      # job name
#SBATCH -e myjob.%j.err       # error file name
#SBATCH -o myjob.%j.out   	  # output file name
#SBATCH -N 4              	  # request 4 nodes
#SBATCH -n 16              	  # request 4x4=16 MPI tasks
#SBATCH -p rtx  	          # designate queue
#SBATCH -t 24:00:00       	  # designate max run time
#SBATCH -A myproject      	  # charge job to myproject
module load gromacs/2022.1
export OMP_NUM_THREADS=4      # 4 OMP threads per MPI task

# Case 1: all 4 MPI tasks on the same node share a GPU with id '0'
ibrun gmx_mpi_gpu mdrun -s topol.tpr -o traj.trr -c confout.gro -e ener.edr -g md.log -gpu_id 0000

# Case 2: the 4 MPI tasks on the same node run on GPU 0, 1, 2, and 3 respectively
ibrun gmx_mpi_gpu mdrun -s topol.tpr -o traj.trr -c confout.gro -e ener.edr -g md.log -gpu_id 0123</pre>

### [Stampede2 Job Script](#jobscript-stampede2) { #jobscript-stampede2 }

The following job script requests 2 nodes (48 cores/node) for 24 hours using Stampede2's Skylake compute nodes (skx-normal queue).

<pre class="jobs-script">
#!/bin/bash
#SBATCH -J myjob              # job name
#SBATCH -e myjob.%j.err       # error file name 
#SBATCH -o myjob.%j.out       # output file name 
#SBATCH -N 2                  # request 2 nodes
#SBATCH -n 96                 # request 2x48=96 MPI tasks 
#SBATCH -p skx-normal         # designate queue 
#SBATCH -t 24:00:00           # designate max run time 
#SBATCH -A myproject          # charge job to myproject 
module load gromacs/2022.1

ibrun gmx_mpi mdrun -s topol.tpr -o traj.trr -c confout.gro -e ener.edr -g md.log</pre>
 
NOTE: To run on Stampede2's KNL nodes, substitute `gmx_mpi` with one of the following executables: `gmx_mpi_knl`, `gmx_tmpi_knl`, or `gmx_mpi_d_knl`.


### [Lonestar6 Job Scripts](#running-lonestar6) { #jobscript-lonestar6 }

Here are two job scripts for running the latest version of GROMACS on Lonestar6.  The first script runs on Lonestar6's CPUs and the second runs on Lonestar6's GPUs.

#### [CPU](#running-lonestar6-cpu) { #jobscript-lonestar6-cpu }

The following job script requests 4 nodes (128 cores/node) for 24 hours using Lonestar6 AMD EPYC CPU nodes (`normal` queue).

``` { .bash .job-script }
#!/bin/bash
#SBATCH -J myjob              # job name
#SBATCH -e myjob.%j.err       # error file name 
#SBATCH -o myjob.%j.out       # output file name 
#SBATCH -N 4                  # request 4 nodes
#SBATCH -n 512                # request 4x128=512 MPI tasks 
#SBATCH -p normal             # designate queue 
#SBATCH -t 24:00:00           # designate max run time 
#SBATCH -A myproject          # charge job to myproject 

module load gromacs/2022.1
export OMP_NUM_THREADS=1      # 1 OMP thread per MPI task
ibrun gmx_mpi mdrun -s topol.tpr -o traj.trr -c confout.gro -e ener.edr -g md.log
```
 
#### [GPU](#running-lonestar6-gpu) { #jobscript-lonestar6-gpu }

The following job script requests two [A100 GPU nodes on Lonestar6](../../hpc/lonestar6#queues). The `-gpu_id 000` directive indicates all three MPI ranks on the same node share the same GPU with id 0.  You may use, for example `-gpu_id 012`, to use all three available GPUs on each A100 GPU node.

``` { .bash .job-script }
#!/bin/bash
#SBATCH -J myjob      	     # job name
#SBATCH -e myjob.%j.err      # error file name
#SBATCH -o myjob.%j.out      # output file name
#SBATCH -N 2              	 # request 2 nodes
#SBATCH -n 6              	 # request 2x3=6 MPI tasks
#SBATCH -p gpu-a100  	     # designate queue
#SBATCH -t 24:00:00       	 # designate max run time
#SBATCH -A myproject      	 # charge job to myproject

module load gromacs/2022.1
export OMP_NUM_THREADS=4     # 4 OMP threads per MPI task 

# Case 1: all 3 MPI tasks on the same node share a GPU with id '0'
ibrun gmx_mpi_gpu mdrun -s topol.tpr -o traj.trr -c confout.gro -e ener.edr -g md.log -gpu_id 000

# Case 2: the 3 MPI tasks on the same node run on GPU 0, 1, and 2 respectively
ibrun gmx_mpi_gpu mdrun -s topol.tpr -o traj.trr -c confout.gro -e ener.edr -g md.log -gpu_id 012
```

## [References](#refs)

* [GROMACS Home](http://www.gromacs.org/)
* [GROMACS Documentation](https://manual.gromacs.org/)
* [GROMACS acceleration and parallelization](https://manual.gromacs.org/documentation/current/user-guide/mdrun-performance.html)

{% include 'aliases.md' %}
