<style>.help{box-sizing:border-box}.help *,.help *:before,.help *:after{box-sizing:inherit}.row{margin-bottom:10px;margin-left:-15px;margin-right:-15px}.row:before,.row:after{content:" ";display:table}.row:after{clear:both}[class*="col-"]{box-sizing:border-box;float:left;position:relative;min-height:1px;padding-left:15px;padding-right:15px}.col-1-5{width:20%}.col-2-5{width:40%}.col-3-5{width:60%}.col-4-5{width:80%}.col-1-4{width:25%}.col-1-3{width:33.3%}.col-1-2,.col-2-4{width:50%}.col-2-3{width:66.7%}.col-3-4{width:75%}.col-1-1{width:100%}article.help{font-size:1.25em;line-height:1.2em}.text-center{text-align:center}figure{display:block;margin-bottom:20px;line-height:1.42857143;border:1px solid #ddd;border-radius:4px;padding:4px;text-align:center}figcaption{font-weight:bold}.lead{font-size:1.7em;line-height:1.4;font-weight:300}.embed-responsive{position:relative;display:block;height:0;padding:0;overflow:hidden}.embed-responsive-16by9{padding-bottom:56.25%}.embed-responsive .embed-responsive-item,.embed-responsive embed,.embed-responsive iframe,.embed-responsive object,.embed-responsive video{position:absolute;top:0;bottom:0;left:0;width:100%;height:100%;border:0}</style>

# Maverick2 User Guide
<i>Last update: August 24, 2022</i> 

## Notices

* **All users: refer to updated [Remote Desktop Access](#remote-desktop-access) instructions.** (07/20/2021)
* All users: read [Managing I/O on TACC Resources](http://portal.tacc.utexas.edu/tutorials/managingio). TACC Staff have put forth new file system and job submission guidelines. (01/09/21)
* Maverick2 is TACC's dedicated Deep Learning Machine.  Allocation requests must include a justification explaining your need for this resource. 
* Maverick2 does not support any Visualization applications. 
* Maverick2 does not mount a `/scratch` (`$SCRATCH`) file system.


## Introduction

Maverick2 is an extension to TACC's services to support GPU accelerated Machine Learning and Deep Learning research workloads. The power of this system is in its multiple GPUs per node and it is mostly intended to support workloads that are better supported with a dense cluster of GPUs and little CPU compute. The system is designed to support model training via GPU powered frameworks that can take advantage of the 4 GPUs in a node. In addition to the 96 1080-TI Nvidia GPU cards, a limited number of Pascal 100 and Volta 100 cards are available to support any workloads that cannot be done in the smaller memory footprints of the primary GPU cards. The system software supports Tensorflow and Caffe and can also be augmented to run other frameworks. 

<img alt="" src="../../../imgs/2mav/trailofhorses.jpg" style="width: 600px; border-width: 1px; border-style: solid; height: 360px;" />
<p class="image-caption">Figure 1. Edward Blein - Trail of Horses</p>

