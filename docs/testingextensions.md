Wed Jan 25 12:46:03 CST 2023

# fiddling and styling.

## Styles I use

### details and summary tags


See: <https://docs.tacc.utexas.edu/hpcugs/stampede2/stampede2/#jobscripts>

<details><summary>Cheesy example - click on arrow to expand</summary>
I'm not a big fan of this arrow. <br> 
Can we add some margin/whitespace at the bottom?  <br>
Also, markdown doesn't work within these tags?
</details>


### Images

I use image tags < figure > and < figcaption >.  

See real life example here: <https://portal.tacc.utexas.edu/user-guides/stampede2#programming-knl-memorymodes>

and demonstrated here
<figure><img src="../imgs/louis.jpg" width="50%">
<figcaption>Louis</figcaption></figure>


### Code Examples

See <a href="/code-examples">Fiddling: Code Examples</a>.

### Need a style called "introtext"

Only used in Frontera User Guide.  See: .... and I just realized it's disappeared from Frontera.

p class="introtext" - it's just a larger font, used as introductory text.  

See <https://frontera-portal.tacc.utexas.edu/user-guide/running/>.  The first sentences, prior to "Job Accounting" should be displayed in a larger than normal font.

### Reference style links 

all aliases are stored in 'aliases.md'

{% include 'aliases.md' %}

Doe this alias work [Stampede2][STAMPEDE2UG]?   

Submit a [ticket][TACCUSERPORTAL] via TUP.

[TACCUSERPORTAL]: http://portal.tacc.utexas.edu



<mark>I'm within a &lt;mark&gt;</mark>

can you < mark > with a color other than <mark>yellow</mark>?  Pink or cyan?

include text under here



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



## `attr_list`

| set on td    | set on em   |
|--------------|-------------|
| *a* { .foo } | *b*{ .foo } |


