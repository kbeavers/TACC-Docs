<!--- / Hang Liu, Susan Lindsey	http://portal.tacc.utexas.edu/software/vasp  --->

# VASP at TACC
<span style="font-size:90%"><i>Last update: April 27, 2022</i></span></p>


<!-- <img alt="VASP logo" src="IMAGEDIR/img/VASP-logo.png" style="width: 75px; height: 41px;">-->
<img alt="VASP logo" src="../../img/VASP-logo.png" style="width: 75px; height: 41px;">
<b>V</b>ienna <b>A</b>b initio <b>S</b>imulation <b>P</b>ackage (VASP) is a computer program for atomic scale materials modelling, e.g. electronic structure calculations and quantum-mechanical molecular dynamics, from first principles.

## TACC and VASP Licenses

VASP requires an individual license. TACC's HPC support license allows us to install only the compiled VASP executables and grant the access to licensed users who have accounts on our systems. We are not allowed to share source code.  

If you have your own license and want to use your own compilation, you may [install it in your own account](/user-guides/stampede2#building-basics-thirdparty). If you wish to use TACC's installed version, then TACC will have to verify your license. [Submit a support ticket](https://portal.tacc.utexas.edu/tacc-consulting/-/consult/tickets/create) and include the following information: your **full** name, affiliated institution, and your TACC user name along with the license number or a scanned PDF of the license. TACC will notify you once the license is confirmed. 

### Installations

The latest stable release of VASP is installed on [Stampede2](/user-guides/stampede2), [Lonestar6](/user-guides/lonestar6) and [Frontera](https://frontera-portal.tacc.utexas.edu/user-guide/) systems. Note that you will be unable to load any VASP module until your license is confirmed.

Use the "[`module`](https://lmod.readthedocs.io/en/latest/)" commands to explore other VASP installations, for example: 

<pre class="cmd-line">
login1$ <b>module spider vasp</b>
login1$ <b>module spider vasp/6.3.0</b></pre>

Then, either interactively or via a batch script, load the appropriate module: 

<pre class="cmd-line">login1$ <b>module load vasp/6.3.0</b></pre>

## Running VASP Jobs

TACC staff recently presented "[VASP on Frontera and Stampede2](https://learn.tacc.utexas.edu/mod/page/view.php?id=100)", detailing how to build and run VASP, and troubleshoot run time issues on TACC systems. Check out the recorded webinar and accompanying slides. 

Modify the following sample job scripts for VASP jobs on Stampede2, Lonestar6 and Frontera. 

### Sample Job Script: VASP on Lonestar6

The script below submits a VASP job to Lonestar6's normal queue ( Milan compute nodes), requesting 2 nodes and 256 tasks for a maximum of 4 hours. Refer to lonestar6's Running Jobs section for more Slurm options.

<pre class="job-script">
#!/bin/bash 
#SBATCH -J vasp          
#SBATCH -o vasp.%j.out     
#SBATCH -e vasp.%j.err 
#SBATCH -n 256         
#SBATCH -N 2 
#SBATCH -p normal      
#SBATCH -t 4:00:00        
#SBATCH -A projectnumber

module load vasp/5.4.4.pl2
ibrun vasp_std > vasp_test.out</pre>

### Sample Job Script: VASP on Frontera

The script below submits a VASP job to [Frontera's normal queue](https://frontera-portal.tacc.utexas.edu/user-guide/running/#table-5-frontera-production-queues) (CLX compute nodes), requesting 4 nodes and 224 tasks for a maximum of 4 hours. Refer to Frontera's [Running Jobs](https://frontera-portal.tacc.utexas.edu/user-guide#running) section for more Slurm options.

<pre class="job-script">
#!/bin/bash 
#SBATCH -J vasp          
#SBATCH -o vasp.%j.out     
#SBATCH -e vasp.%j.err 
#SBATCH -n 224         
#SBATCH -N 4 
#SBATCH -p normal      
#SBATCH -t 4:00:00        
#SBATCH -A <i>projectnumber</i>

module load vasp/5.4.4.pl2
ibrun vasp_std > vasp_test.out</pre>


### Sample Job Script: VASP on Stampede2

The script below requests 4 nodes and 256 tasks, for a maximum of four hours in Stampede2's `normal` queue (KNL compute nodes). See the [Stampede2 User Guide: Common `sbatch` Options](/user-guides/stampede2#running-sbatch) for more about job options.  

<pre class="job-script">
#!/bin/bash 
#SBATCH -J vasp          
#SBATCH -o vasp.%j.out     
#SBATCH -e vasp.%j.err 
#SBATCH -n 256         
#SBATCH -N 4 
#SBATCH -p normal      
#SBATCH -t 4:00:00        
#SBATCH -A <i>projectnumber</i>

module load vasp/5.4.4.p12
ibrun vasp_std > vasp_test.out</pre>

## References

* [HPC Application Tutorial: VASP on Frontera and Stampede2](https://learn.tacc.utexas.edu/mod/page/view.php?id=100) (March 2020)
* [The VASP Site](https://www.vasp.at/) home
* [The VASP Manual](https://www.vasp.at/wiki/index.php/The_VASP_Manual)
* [TACC Software page](https://www.tacc.utexas.edu/systems/software)


