# Code Examples

[TOC]

<style>:is(h1, h2, h4, h4, h5, h6) > b { text-decoration: underline; font-weight: inherit; }</style>

## Different Ways to Style & Author Code

### Inline Code

The default ReadTheDocs style of `courier` font and red `color` is **not** desirable.

### Code Block

#### Command Line

<details open><summary><h4>Via Markdown <small>(recommended)</small></h4></summary>

Use <code>&#96;&#96;&#96;cmd-line</code>.

```cmd-line
login1$ module load kitten
```

</details>
<details><summary><h4 class="understate">Manual HTML</h4></summary>

<pre class="cmd-line"><code>login1$ <strong>module load <em>kitten</em></strong></code></pre>

</details>
<details><summary><h4 class="understate">Manual HTML (Outdated)</h4></summary>

<pre class="cmd-line">login1$ <strong>module load <em>kitten</em></strong></pre>

</details>

<br />

#### Job Script

<details open><summary><h4>Via Mark<b>down</b> <small>(recommended)</small></h4></summary>

Use <code>&#96;&#96;&#96;job-script</code>.

```job-script
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
<details><summary><h4 class="understate">Manual HTML</h4></summary>

<pre class="job-script">
<code>#!/bin/bash
#SBATCH -J myjob              # job name
#SBATCH -e myjob.%j.err       # error file name
#SBATCH -o myjob.%j.out       # output file name
#SBATCH -N 2                  # request 2 nodes
#SBATCH -n 96                 # request 2x48=96 MPI tasks
#SBATCH -p skx-normal         # designate queue
#SBATCH -t 24:00:00           # designate max run time
#SBATCH -A myproject          # charge job to myproject
<strong>module load <em>gromacs/2022.1</em></strong>

ibrun gmx_mpi mdrun -s topol.tpr -o traj.trr -c confout.gro -e ener.edr -g md.log</code></pre>

</details>
<details><summary><h4 class="understate">Manual HTML (Outdated)</h4></summary>

<pre class="job-script">#!/bin/bash
#SBATCH -J myjob              # job name
#SBATCH -e myjob.%j.err       # error file name
#SBATCH -o myjob.%j.out       # output file name
#SBATCH -N 2                  # request 2 nodes
#SBATCH -n 96                 # request 2x48=96 MPI tasks
#SBATCH -p skx-normal         # designate queue
#SBATCH -t 24:00:00           # designate max run time
#SBATCH -A myproject          # charge job to myproject
<strong>module load <em>gromacs/2022.1</em></strong>

ibrun gmx_mpi mdrun -s topol.tpr -o traj.trr -c confout.gro -e ener.edr -g md.log</pre>

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
