# Stampede2 User Guide
<i>Last update: September 16, 2022</i> <span style="font-size:90%;">see <a href="#history">revision history</a></span>    xx
  
## [Notices](#notices) { #notices }

 
* **The XSEDE project concluded formal operations as an NSF-funded project on August 31, 2022**.  Similar services are now operated through NSF's follow-on program, Advanced Cyberinfrastructure Coordination Ecosystem: Services &amp; Support, or ACCESS.  Find out more at the [ACCESS website](http://access-ci.org). (09/01/2022)
* **Stampede2 has deployed 240 Intel "Ice Lake" (ICX) compute nodes, replacing 448 KNL compute nodes.**  Each ICX processor has 80 cores on 2 sockets (40 cores/socket). Hyperthreading is enabled: there are two hardware threads per core, for a total of 80 x 2 = 160 hardware threads per node. See [ICX Compute Node](#table2a) specifications, new [ICX job scripts](#job-scripts), and the new [`icx-normal` queue](#queues) for more information. (03/09/22)
* **All users: refer to updated [Remote Desktop Access](#remote-desktop-access) instructions.** (07/20/2021)
* All users: read [Managing I/O on TACC Resources][TACCMANAGINGIO]. TACC Staff have put forth new file system and job submission guidelines. (01/09/20)
* **The Intel 18 compiler has replaced Intel 17 as the default compiler on Stampede2.** The Intel 17 compiler and software stack are still available to those who load the appropriate modules explicitly.  See [Intel 18 to Become New Default Compiler on Stampede2](https://portal.tacc.utexas.edu/user-guides/stampede2/intel) for more information.  (02/26/19)
* **In order to balance queue wait times, the charge rate for all [KNL queues](#queues) has been adjusted to 0.8 SUs per node-hour.** The charge rate for the SKX queues remains at 1 SU.  (01/14/19)
* **Stampede2's Knights Landing (KNL) compute nodes each have 68 cores**, and each core has 4 hardware threads. But it may not be a good idea to use all 272 hardware threads simultaneously, and it's certainly not the first thing you should try. In most cases it's best to specify no more than 64-68 MPI tasks or independent processes per node, and 1-2 threads/core. See [Best Known Practices...](#programming-knl-bestpractices) for more information.
* **Stampede2's Skylake (SKX) compute nodes each have 48 cores** on two sockets (24 cores/socket). Hyperthreading is enabled: there are two hardware threads per core, for a total of 48 x 2 = 96 hardware threads per node. See [Table 2](#table2) for more information. Note that SKX nodes have their own [queues](#running-queues). 


<figure><img alt="Stampede2" src="IMAGEDIR/stampede2/Stampede2.jpg"><figcaption>Figure 1. Stampede2 System</figcaption></figure>
