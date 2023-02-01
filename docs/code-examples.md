# Code Examples

[TOC]

<style>:is(h1, h2, h4, h4, h5, h6) > b { text-decoration: underline; font-weight: inherit; }</style>

## Different Ways to Style & Author Code

### Inline Code (`<code>…` or <code>&#96;…&#96;</code>)

The default ReadTheDocs style of `courier` font and red `color` is **not** desirable.

<br />

### Code Block (`<pre>…` or <code>&#96;&#96;&#96;…</code>)

#### Quick Start

<style>
/* To remove space between labels and code blocks */
/* TODO: Evaluate wheteher to make this reusable */
p:has(small) + pre {
    margin-top: calc( -1 * var(--global-space--p-buffer-below));
}
</style>

<small>default</small>

```bash
#!/bin/bash
#SBATCH -J myjob              # job name
module load gromacs/2022.1
ibrun gmx_mpi mdrun -s topol.tpr -o traj.trr -c confout.gro -e ener.edr -g md.log
```

<small>`.cmd-line`</small>

``` { .bash .cmd-line }
#!/bin/bash
#SBATCH -J myjob              # job name
module load gromacs/2022.1
ibrun gmx_mpi mdrun -s topol.tpr -o traj.trr -c confout.gro -e ener.edr -g md.log
```

<small>`.job-script`</small>

``` { .bash .job-script }
#!/bin/bash
#SBATCH -J myjob              # job name
module load gromacs/2022.1
ibrun gmx_mpi mdrun -s topol.tpr -o traj.trr -c confout.gro -e ener.edr -g md.log
```

<small>`.syntax`</small>

``` { .bash .syntax }
#!/bin/bash
#SBATCH -J myjob              # job name
module load gromacs/2022.1
ibrun gmx_mpi mdrun -s topol.tpr -o traj.trr -c confout.gro -e ener.edr -g md.log
```

<br />

#### Command Line (`.cmd-line`)

See [usage example](https://portal.tacc.utexas.edu/user-guides/stampede2#using-modules){ target="_blank" }.

<small>* I.e. <samp>&#96;class="cmd-line"&#96;</samp> produces `class="cmd-line"` which is red using the ReadTheDocs theme.</small>

<details open><summary><h4>Via Mark<b>down</b> <small>(recommended)</small></h4></summary>

Use <code>&#96;&#96;&#96;bash</code>, or—to add a class—use <code>&#96;&#96;&#96; { .bash .cmd-line }</code>.

``` { .ruby .cmd-line }
login1$ module load kitten
```

</details>
<details><summary><h4 class="understate">Simple Mark<b>up</b></h4></summary>

<pre class="cmd-line">login1$ <strong>module load kitten</strong></pre>

</details>
<details><summary><h4 class="understate">Complex Mark<b>up</b></h4></summary>

<pre class="cmd-line"><code class="language-bash hljs">login1$ <strong>module load kitten</strong></code></pre>

</details>

<br />

#### Job Script (`.job-script`)

<details open><summary><h4>Via Mark<b>down</b> <small>(recommended)</small></h4></summary>

Use <code>&#96;&#96;&#96;bash</code>, or—to add a class—use <code>&#96;&#96;&#96; { .bash .job-script }</code>.

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

</details>
<details><summary><h4 class="understate">Simple Mark<b>up</b></h4></summary>

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

</details>
<details><summary><h4 class="understate">Complex Mark<b>up</b></h4></summary>

<pre class="job-script">
<code class="language-bash hljs">
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

ibrun gmx_mpi mdrun -s topol.tpr -o traj.trr -c confout.gro -e ener.edr -g md.log</code></pre>

</details>

<br />

#### Syntax (`.syntax`)

<details open><summary><h4>Via Mark<b>down</b> <small>(recommended)</small></h4></summary>

Use <code>&#96;&#96;&#96;bash</code>, or—to add a class—use <code>&#96;&#96;&#96; { .bash .syntax }</code>.

``` { .bash .syntax }
man [options] -switch -verbose
```

</details>
<details><summary><h4 class="understate">Simple Mark<b>up</b></h4></summary>

<pre class="syntax">man [options] -switch -verbose</pre>

</details>
<details><summary><h4 class="understate">Complex Mark<b>up</b></h4></summary>

<pre class="syntax"><code class="language-bash hljs">man [options] -switch -verbose</code></pre>

</details>

<br />

#### Pros & Cons of Each Way

Simple Markup
:   _Con_: Will not have syntax highlighting.

Via Markdown
:   _Pro_: Programatically consistent.
:   _Con_: Can not add internal markup (e.g. `<code>something <strong>bold</strong></code>`).
:   _Pro_: Follows the [WHATWG standard example](https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-code-element).

Complex Markup
:   _Pro_: Follows the [WHATWG standard example](https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-code-element).

<br />
<br />

## Syntax Highlighting Reference

Syntax
:  [Python-Markdown `fenced_code_blocks`](https://python-markdown.github.io/extensions/fenced_code_blocks)

Languages
:  [Highlight.js: Supported Languages](https://github.com/highlightjs/highlight.js/blob/main/SUPPORTED_LANGUAGES.md#supported-languages)

Themes
:  [Highlight.js: Demo](https://highlightjs.org/static/demo/)

Sample
:  (using `bash`)

```bash
#!/bin/bash

###### CONFIG
ACCEPTED_HOSTS="/root/.hag_accepted.conf"
BE_VERBOSE=false

if [ "$UID" -ne 0 ]
then
echo "Superuser rights required"
exit 2
fi

genApacheConf(){
echo -e "# Host ${HOME_DIR}$1/$2 :"
}

echo '"quoted"' | tr -d \" > text.txt
```
