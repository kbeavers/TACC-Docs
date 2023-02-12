# Frontera User Guide
<span style="font-size:90%;"><i>Last update: September 15, 2022</i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="https://frontera-portal.tacc.utexas.edu/user-guide/docs/user-guide.pdf">Download PDF <i class="fa fa-file-pdf-o"></i></a></span> editing 01/24/2023

## [Status Updates and Notices](#notices) { #notices }

* **All users: refer to updated [Remote Desktop Access](#remote-desktop-access) instructions.** (07/21/2021)
* **New Queue: A new queue: "`small`" has been created specifically for one and two node jobs**. Jobs of one or two nodes that will run for up to 48 hours should be submitted to this new [`small` queue](#frontera-production-queues).  The `normal` queue now has a lower limit of three nodes for all jobs. These new limits will improve the turnaround time for all jobs in the `normal` and `small` queues. (03-30-21) 
* **Frontera has new [large memory nodes](#large-memory-nodes)**, accessible via the [`nvdimm` queue](#frontera-production-queues). (04/03/20)
* Users now have access to additional [Frontera User Portal](#portal) functionality. **Log in the portal to access your [dashboard](https://frontera-portal.tacc.utexas.edu/workbench/dashboard) and other features.** (03-25-20)
* TACC Staff have put forth new file system and job submission guidelines. **All users: read [Managing I/O on TACC Resources][TACCMANAGINGIO].** (01/09/20)
* **Frontera's [GPU](#gpu-nodes) queues, `rtx` and `rtx-dev` are now open.** See [Frontera's production queues](#frontera-production-queues) for more information. Execute [`qlimits`](#taccs-qlimits-command) to display Frontera's queue configurations and charge rates. (12/07/19)
*  **The [TACC Analysis Portal][TACCANALYSISPORTAL] now supports Frontera job submission for VNC and DCV remote desktops as well as Jupyter Notebook sessions.** We recommend submitting to the `development queue` for fastest turn-around. (12/05/2019)
* **Frontera's `flex` queue is now open.** Jobs in this queue are charged a lower rate (.8 SUs) but are pre-emptable after a guaranteed runtime of at least one hour. (10/30/2019) 
* Please run all your jobs out of the `$SCRATCH` filesystem, instead of `$WORK`, to preserve the stability of the system. (10/10/2019)
* You may now **[subscribe](https://portal.tacc.utexas.edu/news/subscribe) to [Frontera User News](https://portal.tacc.utexas.edu/user-news/-/news/Frontera)**. Stay up-to-date on Frontera's status, scheduled maintenances and other notifications. (10/10/2019) 
* **All users: read the [Good Conduct](#conduct) section.** Frontera is a shared resource and your actions can impact other users. (10/10/2019) 


<figure id="figure1"><img alt="Frontera Art" src="../../imgs/frontera/frontera-art.jpg">
<figcaption></figcaption></figure>

