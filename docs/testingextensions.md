Thu Dec  8 12:16:55 CST 2022
Thu Jan 19 11:55:45 CST 2023

This is a page for fiddling and styling.

# [Let's test some nested h1 headings](#top)  { #top } 

## Images

I use image tags < figure > and < figcaption >.  See example here: <https://portal.tacc.utexas.edu/user-guides/stampede2#programming-knl-memorymodes>

<figure><img src="../imgs/louis.jpg" width="50%">
<figcaption>Louis</figcaption></figure>


## Code examples
This is class="cmd-line" , just courier-class.  I would prefer code not be in red.
See example here:  <https://portal.tacc.utexas.edu/user-guides/stampede2#using-modules>

<pre class="cmd-line">login1$ <b>module load kitten</b></pre>


This is "class="job-script"

<pre class="job-script">
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


## H2 is here


Reference style links I get 10 times more traffic from [Google] [1] than from
[Yahoo] [2] or [MSN] [3].

  [1]: http://google.com/        "Google"
  [2]: http://search.yahoo.com/  "Yahoo Search"
  [3]: http://search.msn.com/    "MSN Search"


Doe this alias work [Stampede2][STAMPEDE2UG] louis  
Please [submit a ticket] [BUTTER]

[BUTTER]: http://portal.tacc.utexas.edu

<span style="font-style:italic; color:green;background:yellow">I'm within a span</span>

include text under here

{% include 'aliases.md' %}

This is [an example] [foo] reference-style link.

   [foo]: http://example.com/  "Optional Title Here"
   [foo]: http://example.com/  'Optional Title Here'
   [foo]: http://example.com/  (Optional Title Here)




how do I highlight? styles - do I need to run this through a script? - yup

### H3 is h3re

#### h4 is here

##### h5 is here

##### another h5  is here

###### h6 is here

## `admonition` extension

I use "attention", "note", "warning" the most

!!! important
	Admonition type: important
	See example: <https://portal.tacc.utexas.edu/user-guides/stampede2#files-striping>

!!! attention "pay attention"
	attention box

!!! caution
    Caution box the title will be automatically capitalized.

!!! error
	Admonition type: error

!!! note
	Admonition type: note

!!! tip
	Admonition type: tip

!!! warning
	Admonition type: warning


[CREATETICKET]: http://example.com/  "Optional Title Here"

## `attr_list`

| set on td    | set on em   |
|--------------|-------------|
| *a* { .foo } | *b*{ .foo } |


