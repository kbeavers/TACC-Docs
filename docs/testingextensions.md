November 18, 16:39pm

# Let's test some nested headings - here's h1

## H2 is here

I get 10 times more traffic from [Google] [1] than from
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




how do I highlight? styles - do I need to run this through a script?

markdown macros?


### H3 is h3re


#### h4 is here

##### h5 is here

##### another h5  is here

###### h6 is here

## another h2

## `abbr` 

The HTML specification is maintained by the W3C.  Login in to TUP

*[HTML]: Hyper Text Markup Language
*[W3C]:  World Wide Web Consortium

## `attr_list`

| set on td    | set on em   |
|--------------|-------------|
| *a* { .foo } | *b*{ .foo } |


## `admonition` extension

rST suggests the following “types”: attention, caution, danger, error, hint, important, note, tip, and warning; however, you’re free to use whatever you want.

!!! attention "pay attention"
	attention box

!!! caution
    Caution box the title will be automatically capitalized.

!!! danger highlight blink "Don't try this at home"
	danger box. This should blink

!!! error
	Admonition type: error

!!! hint
	Admonition type: hint

!!! important
	Admonition type: important

!!! note
	Admonition type: note

!!! tip
	Admonition type: tip

!!! warning
	Admonition type: warning


[CREATETICKET]: http://example.com/  "Optional Title Here"

