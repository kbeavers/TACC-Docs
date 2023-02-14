# Quantum Espresso at TACC
*Last update: May 19, 2020*


<img alt="Quantum Espresso logo" src="../../imgs/software/qe-logo.png" style="width: 75px;" />
Quantum Espresso (QE) is an integrated suite of open-source codes for electronic-structure calculations and materials modeling at the nanoscale. Quantum Espresso (op<b>E</b>n-<b>S</b>ource <b>P</b>ackage for <b>R</b>esearch in <b>E</b>lectronic <b>S</b>tructure, <b>S</b>imulation, and <b>O</b>ptimization) is based on density-functional theory, plane waves, and pseudopotentials.  

## [Installations](#installations) { #installations }

The latest QE stable release is installed on TACC's [Stampede2][STAMPEDE2UG], [Lonestar6][LONESTAR6UG] and [Frontera][FRONTERAUG] systems. Use `module` commands to load the latest installed version by default, and to list all installed versions.  

<pre class="cmd-line">
$ <b>module load qe</b>
$ <b>module spider qe</b></pre>

You can find extensive documentation for each QE component in the respective Doc directory, for example:

<pre class="cmd-line">
$ <b>cd $TACC_QE_DIR/PW/Doc</b>		# explore PWscf documentation</pre>

## [Running Quantum Espresso Jobs](#running) { #running }

Quantum Espresso executables have many optional command line arguments described in the [user manual](http://www.quantum-espresso.org/resources/users-manual). QE users may run with their default settings usually with no problem. QE contains many packages and executables and `pw.x` is the most popular. **We strongly recommend you refer to the [QE manual](http://www.quantum-espresso.org/resources/users-manual) to learn how to construct input files, and learn the correct and optimal way to run your codes**.

Use the following job scripts for Quantum Espresso runs on Stampede2 and Frontera. To configure a script for Lonestar5, vary the <span style="white-space: nowrap;">`-N`</span> and <span style="white-space: nowrap;">`-n`</span> directives.

### [Sample Job Script: QE on Frontera](#jobscript-frontera) { #jobscript-frontera }

The script below submits a Quantum Espresso job to Frontera's normal queue (CLX compute nodes), requesting 4 nodes and 224 tasks for a maximum of 4 hours. Refer to Frontera's [Running Jobs][FRONTERAUGRUNNING] section for more Slurm options.

``` { .bash .job-script }
#!/bin/bash 
#SBATCH -J qe                               # define the job name
#SBATCH -o qe.%j.out                        # define stdout & stderr output files 
#SBATCH -e qe.%j.err 
#SBATCH -N 4                                # request 4 nodes 
#SBATCH -n 224                              # 224 total tasks = 56 tasks/node
#SBATCH -p normal                           # submit to "normal" queue 
#SBATCH -t 4:00:00                          # run for 4 hours max 
#SBATCH -A <i>projectname</i>

module load qe/6.4.1                        # setup environment
ibrun pw.x -input qeinput > qe_test.out     # launch job
```

### [Sample Job Script: QE on Stampede2](#jobscript-stampede2) { #jobscript-stampede2 }

The script below submits a Quantum Espresso job to Stampede2's `normal` queue (KNL compute nodes), requesting 4 nodes and 256 tasks for a maximum of 4 hours. Refer to Stampede2's [Running Jobs][STAMPEDE2UGRUNNING] section for more Slurm options. 

``` { .bash .job-script }
#!/bin/bash 
#SBATCH -J qe          						# define the job name
#SBATCH -o qe.%j.out    					# define stdout & stderr output files 
#SBATCH -e qe.%j.err 
#SBATCH -N 4         						# request 4 nodes 
#SBATCH -n 256								# 256 total tasks = 64 tasks/node
#SBATCH -p normal     						# submit to <code>normal</code> queue 
#SBATCH -t 4:00:00       					# run for 4 hours max 
#SBATCH -A <i>projectname</i>

module load qe/6.2.1						# setup environment
ibrun pw.x -input qeinput > qe_test.out	    # launch job
```

## [References](#refs) { #refs }

* [Quantum Espresso home page](http://www.quantum-espresso.org/)
* [Quantum Espresso User Manual](http://www.quantum-espresso.org/resources/users-manual)


{% include 'aliases.md' %}
