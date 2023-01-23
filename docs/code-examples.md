# Syntax Highlighting

<style>:is(h1, h2, h3, h4, h5, h6) > b { text-decoration: underline; font-weight: inherit; }</style>

## `class="cmd-line"`

### Simple Mark<b>up</b> [^1]

<pre class="cmd-line">login1$ <strong>module load kitten</strong></pre>

### Via Mark<b>down</b> [^2]

``` { .bash .cmd-line }
login1$ module load kitten
```

### Complex Mark<b>up</b> [^3]

<pre class="cmd-line"><code class="language-bash hljs">login1$ <strong>module load kitten</strong></code></pre>

## `class="job-script"`

### Simple Mark<b>up</b> [^1]

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

### Via Mark<b>down</b> [^2]

``` { .bash .job-script }
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

ibrun gmx_mpi mdrun -s topol.tpr -o traj.trr -c confout.gro -e ener.edr -g md.log
```

### Complex Mark<b>up</b> [^3]

<pre class="job-script">
<code class="language-bash hljs">#!/bin/bash
#SBATCH -J myjob              # job name
#SBATCH -e myjob.%j.err       # error file name
#SBATCH -o myjob.%j.out       # output file name
#SBATCH -N 2                  # request 2 nodes
#SBATCH -n 96                 # request 2x48=96 MPI tasks
#SBATCH -p skx-normal         # designate queue
#SBATCH -t 24:00:00           # designate max run time
#SBATCH -A myproject          # charge job to myproject
module load gromacs/2022.1

ibrun gmx_mpi mdrun -s topol.tpr -o traj.trr -c confout.gro -e ener.edr -g md.log</code></pre>

[^1]: **Drawbacks**: No syntax highlighting. Instead, review relevant "Complex Markup" or "Via Markdown" syntax.
[^2]: **Benefits**: Programatically consistent. **Drawbacks**: No internal markup (e.g. `<code>something <strong>bold</strong>`).
[^3]: **Benefits**: Follows the [WHATWG standard example](https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-code-element).
