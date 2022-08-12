<span style="font-size:225%; font-weight:bold;">MACHINENAME User Guide</span><br>
<i>Last update: March 22, 2022</i> 

# [Notices](#notices)

* **All users: refer to updated [Remote Desktop Access](#remote-desktop-access) instructions.** (07/20/2021)
* All users: read [Managing I/O on TACC Resources](http://portal.tacc.utexas.edu/tutorials/managingio). TACC Staff have put forth new file system and job submission guidelines. (01/09/21)
* Maverick2 is TACC's dedicated Deep Learning Machine.  Allocation requests must include a justification explaining your need for this resource. 
* Maverick2 does not support any Visualization applications. 
* Maverick2 does not mount a `/scratch` (`$SCRATCH`) file system.


# [Introduction](#intro)

Maverick2 is an extension to TACC's services to support GPU accelerated Machine Learning and Deep Learning research workloads. The power of this system is in its multiple GPUs per node and it is mostly intended to support workloads that are better supported with a dense cluster of GPUs and little CPU compute. The system is designed to support model training via GPU powered frameworks that can take advantage of the 4 GPUs in a node. In addition to the 96 1080-TI Nvidia GPU cards, a limited number of Pascal 100 and Volta 100 cards are available to support any workloads that cannot be done in the smaller memory footprints of the primary GPU cards. The system software supports Tensorflow and Caffe and can also be augmented to run other frameworks. 

<figure><img alt="" src="../img/trailofhorses.jpg" style="width: 600px; border-width: 1px; border-style: solid; height: 360px;" /><figcaption><font size=-2>Figure 1. Edward Blein - Trail of Horses</font></figcaption></figure>

