Thu Dec  8 12:16:55 CST 2022
Thu Jan 19 11:55:45 CST 2023

This is a page for fiddling and styling.

# [Let's test some nested h1 headings](#top)  { #top } 

## Images

I use image tags < figure > and < figcaption >.  See example here: <https://portal.tacc.utexas.edu/user-guides/stampede2#programming-knl-memorymodes>

<figure><img src="../imgs/louis.jpg" width="50%">
<figcaption>Louis</figcaption></figure>


## Code Examples

See <a href="/code-examples">Fiddling: Code Examples</a>.

## H2 is here


Reference style links I get 10 times more traffic from [Google] [1] than from
[Yahoo] [2] or [MSN] [3].

  [1]: http://google.com/        "Google"
  [2]: http://search.yahoo.com/  "Yahoo Search"
  [3]: http://search.msn.com/    "MSN Search"


Doe this alias work [Stampede2][STAMPEDE2UG] louis  
Please [submit a ticket] [BUTTER]

[BUTTER]: http://portal.tacc.utexas.edu


<span style="font-style:italic; color:green;background:yellow">I'm within an inline-styled &lt;span&gt;</span>

<mark>I'm within a &lt;mark&gt;</mark>

include text under here

{% include 'aliases.md' %}

This is [an example] [foo] reference-style link.

   [foo]: http://example.com/  "Optional Title Here"
   [foo]: http://example.com/  'Optional Title Here'
   [foo]: http://example.com/  (Optional Title Here)

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


