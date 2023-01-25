:markdown

	# Assessing and Optimizing Data Transfer Performance or A realists guide to the internet.

%section#intro
	:markdown
		## [Introduction](#intro)

		This tutorial will help you to understand the data transfer process as a whole, and to set appropriate expectations for data transfer performance based on the capabilities of the systems and networks involved. This document will also help you to understand when advanced transfer mechanisms such as GridFTP are important and how to best utilize those mechanisms. Topics such as configuration and use of specialized high-performance transfer mechanisms are beyond the scope of this tutorial - rather, we focus here on understanding what performance level is necessary and achievable and which tools one should use to achieve the necessary transfer performance.

%section#concepts
	:markdown
		## [Key Concepts and Fundamentals](#concepts)

		The key concept in setting goals for data transfer performance is the "total time to transfer", which represents the entirety of the time taken from deciding one wants to transfer data from one place to another to the time that the transfer is successfully completed. This concept allows one to take a holistic view of transfer time and complexity, including the time to setup, monitor, and confirm that a transfer is done, rather than focusing narrowly on instantaneous transfer performance. It also neatly represents the most important consideration in assessing data transfers, which is how long one is spending waiting on data movement rather than doing the work that data is meant to enable. When one considers the total time taken to setup and execute a transfer, it can become more obvious that it may make more sense to utilize a simpler and slower transfer mechanism, and thereby to save the time required in learning a new tool or managing data transfers, as opposed to utilizing a more complex tool that may be capable of greater bandwidth utilization but requires that you spend hours or days learning and using the tool.

		The other fundamental concept to understand in assessing data transfer performance is the fact that the total transfer performance will never exceed that of the slowest component involved in the transfer, including the storage devices at each end of the transfer, the network interfaces on each end, and the intervening network paths and components. It is also important to understand that many of these components may be shared with other users and other activity, for example a campus network connection will in most cases be shared with thousands of students and/or faculty accessing web pages, streaming video, and transferring data. Similarly, the file systems at a supercomputing center such as TACC may be executing many data transfers for many different users simultaneously. Thus, even using a network such as Internet2 that is capable of moving many gigabits per second, or a high-performance file system like that on Stampede which is capable of reading and writing many gigabytes per second, you are unlikely to achieve these "peak" levels of performance on a regular basis when transferring data.

		If you are transferring data from a laptop or desktop system located in your home or office, the slowest component in the data transfer is likely to be either your system hard drive, or more likely, the network connection to your laptop or desktop. Many network connections in faculty offices, and all wireless networks, have a maximum performance of less than 100 megabytes per second, or even 10 megabytes per second. It is important that you understand the capabilities of your local networks and systems, either by speaking to your local IT staff or by performing benchmarking yourself, if you wish to gain an accurate understanding of what kind of data transfer performance you should expect. Many speed tests are available that can give you a quick estimate of the available bandwidth to your system - consult your ISP or local IT for the recommended test for your network, or perform some web searches and try a couple different tests to get a sense of the likely available bandwidth for network transfers.


<table><tbody><tr><td>Device
</td><td>Peak single client Throughput
</td><td>Typical single client throughput
</td></tr><tr><td>Laptop Hard Drive
</td><td>  
</td><td>  
</td></tr><tr><td>Wireless 
</td><td>  
</td><td>  
</td></tr><tr><td>Typical Office Wired Network
</td><td>  
</td><td>  
</td></tr><tr><td>Cable network
</td><td>  
</td><td>  
</td></tr><tr><td>Campus Network
</td><td>  
</td><td>  
</td></tr><tr><td>Shared File System
</td><td>  
</td><td>  
</td></tr></tbody></table>

%section#performance
	:markdown
		## [Assessing Data Transfer Performance](#performance)

		To determine the expected total time to transfer, you should assess the actual performance achieved with a given tool on a subset of your data, and then scale the time taken based on the total amount of data or number of files you must transfer. Different methods may be necessary to assess performance based on the nature of your data.

		When transferring large numbers of files and/or large amounts of data, the individual transfer performance of a single file or group of files may or may not be indicative of the overall transfer performance. This is due to the fact that transferring small files requires a relatively large amount of overhead in setting up connections and tearing them down after the transfer, and that various forms of file transfer may have different ways of handling these connection creation and destruction processes. 

		If your overall transfer task consists of transferring several large (>1GB) files, you can assess transfer performance by transferring one of these files and looking at the time taken to derive a transfer rate per second. For example, if transferring a single 1GB file from TACC Stampede to Gordon takes 60 seconds, the transfer rate is 16.6MB/sec, and transferring 2TB would take around 33 hours. If instead you have a large number of small files to transfer, you may choose to transfer 100 or 1000 files and base your scaling on the number of files rather than the number of bytes. 

		In general, if your scaling estimates suggest that your total transfer can be completed in less than 24 hours, additional effort spent on optimization of transfer performance is unlikely to be of overall benefit in terms of the total time to transfer.

%section#optimizing
	:markdown
		## [Optimizing Data Transfer Performance](#optimizing)

		As with assessing data transfer performance, the optimizations you should apply will vary based on the nature of the data to be transferred. For transfers that consist of large numbers of small files, there are two simple optimizations that will help achieve better transfer performance depending on the tools involved. The GridFTP/Globus Online utilities, iRODS, and some other transfer tools support bundling of small files into a single transfer, e.g. without creating and destroying connections for each individual file. If this feature is available, enabling it will significantly improve transfer performance for small files.

		In addition to bundling small files together into a single transfer, you may get additional transfer performance for many small files by launching parallel transfer operations; consider breaking up your overall transfer by subdirectory and running a separate transfer command for each subdirectory, and if you can run each transfer command on a separate node you may get additional performance improvements. Parallel transfer operations will provide the most benefit on busy networks, and you will gain the most benefit from parallelizing transfers across nodes (e.g. using multiple nodes to complete an overall transfer of a set of files and directories) as opposed to parallelizing transfers on a single node (e.g. using multiple network streams to complete a single transfer of one or more files.

		For large file transfers, the most effective optimizations will be those that increase the quantity of data being read from disk and pushed over the network in a given stretch, often referred to as the block or buffer size. On modern systems, you can usually benefit from choosing values up to 16MB or more for this setting - if separate values can be selected for the disk read size and the TCP buffer size, you may need to experiment to find the optimal combination but 16MB is likely to be a good setting for most configurations.

		These three optimizations are by far the most effective at improving transfer performance, and can be used either individually or together to improve transfer performance if necessary. 

%section#conclusions
	:markdown
		## [Conclusions](#conclusions)

		Data transfer is a component of an overall workflow involving data movement, data transformation, computation and analysis steps. and the most important thing about data transfer is that it gets your data where you need it to be at the time when you need it there for your workflow purposes. When planning for your workflow, consider the order of data transfer and try to minimize the amount of extraneous data you transfer, and to transfer the most important elements or those which are required for initial workflow steps first. Make sure you understand what performance levels you can expect before you begin working on optimization, and have clear targets in mind for both performance and the overall time to complete your transfer activities. Once you know what you need to achieve in terms of time and performance, and what is possible, you will be equipped to utilize the tools available to you in terms of parallelization, file bundling, and buffering in order to ensure that you can complete your work in a timely fashion.

		*Last update: February 26, 2015*
