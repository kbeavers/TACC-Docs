# <code>idev</code>: (Interactive Development) User Guide
*Last update: August 12, 2018*


## [Introduction](#intro) { #intro }

**The need for interactive access to compute nodes**: While large HPC systems are excellent resources for running production work, they are not configured for development. Often developers use departmental systems, or patiently submit a sequence of jobs to validate code changes. This can be particularly frustrating to new users, who want to "kick the tires", port applications and debug codes on supercomputers.

What most users need for development is interactive access to a set of compute nodes, in order to quickly compile, run and validate MPI or other applications multiple times in rapid succession. To help users with their code development, TACC has created an app that will do that, by allowing users to acquire a set of compute nodes for interactive access. The app is called `idev`, for **I**nteractive **DEV**elopment.

The `idev` utility creates an interactive development environment from the user's login window. In the `idev` window the user is connected directly to a compute node from which the user can launch MPI-compiled executables directly (with the `ibrun` command). 

## [How it works](#works) { #works }
The `idev` command submits a batch job that creates a copy of the batch environment and then goes to sleep. After the job begins, `idev` acquires a copy of the batch environment, SSH&#39;s to the master node, and then re-creates the batch environment. The SSH command allows X11 tunneling for setting up a display back to the user&#39;s laptop for debugging.

## [How to use `idev`](#how) { #how }
On any TACC system execute:
<pre class="cmd-line">
login4.stampede(5)$ <b>idev <i>options</i></b></pre>

If this is your first time launching `idev` and you have multiple accounts, `idev` will prompt you for the account and then save your selection as the default interactive account; otherwise, it will automatically use your only account. It will then begin to initiate your first `idev` session. Enjoy.

It is necessary for `idev` to gain access to compute nodes through the batch system; that is the normal mode for acquiring resources on a supercomputer (and at TACC). Hence the user must wait for the `idev` request to be accepted through the batch system. Fortunately, at TACC there is a &quot;development&quot; queue on each TACC system; `idev`&#39;s default setting uses this queue, and it is often a short wait for `idev` to acquire the nodes and allow interactive input. `idev` reports its progress every 4 seconds. Below is an example of `idev`&#39;s progress in setting up a session:
<pre class="cmd-line">
login1$ <b>idev</b>

Defaults file    : ~/.idevrc
Default  queue   : development
System           : Stampede
-----------------------------------------------------------------
--             Welcome to the Stampede Supercomputer
-----------------------------------------------------------------
...
After your idev job begins to run, a command prompt will appear,
and you can begin your interactive development session.
We will report the status every 4 seconds: (qw=queue wait, r=running).

job status: qw
job status: qw (5 more times)
job status: r
--> Job is now running on masternode= c301-202...OK
--> Sleeping for 7 seconds...OK
--> Checking to make sure your job has initialized an env for you....OK
--> Creating interactive terminal session (login) on master node c301-202.</pre>

Note the prompt, "`c301-202%`", in the above session. It is your interactive compute-node prompt. You can test the "`ibrun`" command by executing "`ibrun date`" which will return `date`'s output from each core of your session. You can begin immediately launching MPI applications with "`ibrun myapp`". On the compute nodes in some queues, compiler access is not available.  In this case **compile on the login node in another window**.

By default only a single node is requested for 30 minutes. However, you can change the limits with command line options, using syntax similar to the request specifications used in a job script. The syntax is conveniently described in the `idev` help display:

<pre class="cmd-line">
login1$ <b>idev -help</b>
...
OPTION ARGUMENTS         DESCRIPTION
-A     account_name      sets account name (default: in .idevrc)
-m     minutes           sets time in minutes (default: 30)
-p     queue_name        sets queue to named queue (default: -p development)
-r     resource_name     sets hardware
-t     hh:mm:ss          sets time to hh:mm:ss (default: 00:30:00)
-help      [--help     ] displays (this) help message
-v         [--version  ] output version information and exit
...  
</pre>

Options may be used in any order. Only a subset of the options is presented above.  The "`-r`" option may be used on any system to request a specific resource (e.g. requesting a specific set of nodes).

## [Compiling](#compiling) { #compiling }

On the old Stampede1 system, compiling on compute nodes is only supported on the development nodes. When using a queue other than `development`, we suggest opening two login windows, and using one for compilations and the other for starting an `idev` interaction session for running executions.

## [Future](#future) { #future }
If you have ideas for enhancing `idev` with new features, please submit a ticket at <https://portal.tacc.utexas.edu/>

*Last update: February 3, 2017*

