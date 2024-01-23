# Stampede3 User Guide 

*Last update: January 23, 2024*

## [Notices](#notices) { #notices }

*This user guide is in progress and will be updated as the system is configured.*

### Stampede3 Updated Timeline
**All dates subject to change based on hardware availability and condition.**   

January 2024 - Stampede3 file system available for data migration - Available now   
February 2024 - Early user period for Stampede3   
March 2024 - Stampede3 in full production   


## [Migrating Data](#migrating) { #migrating }

The Stampede3 login nodes are now available for you to begin moving data between systems.  **If you have an active Stampede3 allocation** then you may begin the data migration process from Stampede2 to Stampede3.  During this migration period Stampede2's `/home` and `/scratch` systems will be temporarily mounted on Stampede3 and will be accessible through the `$HOME_S2` and `$SCRATCH_S2` environment variables respectively.  

You do not need to migrate data from `$WORK` (Stockyard) as that file system will be automatically mounted on Stampede3.  However, anything in your `$HOME` or `$SCRATCH` directories that you wish to retain will need to be moved.  

!!! important
	Please migrate **only** the data you wish to keep from Stampede2.  

### [Examples](#migrating-examples) { #migrating-examples }

**If you have an active Stampede3 allocation** you can access Stampede3 via `ssh` as you do with other TACC resources.  Use the same password and MFA method as for accessing Stampede2.

``` cmd-line
ssh username@stampede3.tacc.utexas.edu
```
To move your data, we recommend using either the UNIX `cp` or `rsync` utilities.  

To copy a single file from Stampede2 to Stampede3: 

```cmd-line
stampede3$ cp $HOME_S2/filename $HOME
```
or

```cmd-line
stampede3$ rsync -r $HOME_S2/filename $HOME
```

To copy a directory: 

```cmd-line
stampede3$ rsync -r $SCRATCH_S2/dirName $SCRATCH
```
or

```cmd-line
stampede3$ cp -r $SCRATCH_S2/dirName $SCRATCH
```

!!! note
	Currently, there is no Globus endpoint on Stampede3.  We will make an announcement as soon as the endpoint becomes available.


## [Introduction](#intro) { #intro }

The National Science Foundation (NSF) has generously awarded the University of Texas at Austin funds for TACC's Stampede3 system ([Award Abstract # 2320757](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2320757)).  

### [Allocations](#intro-allocations) { #intro-allocations }

**New Allocations**: You may now submit new allocation requests for Stampede3 via [ACCESS](https://allocations.access-ci.org/). Additional allocation opportunities may also be available in the future. 
