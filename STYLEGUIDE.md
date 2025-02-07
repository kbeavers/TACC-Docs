# TACC Technical Documentation Style Guide
*Last update: Feb 4, 2025*

# Point of View / Voice

Employ the second-person "you" addressing the user in a familiar voice. This is not consistent across TACC user guides, though later guides do employ this voice.

# All Links

All links are anchored \- accessibility (cite ref?)  
All links must be anchors

# Last Modified Date

Only amend for significant content updates, not formatting or typos. At top of document, hand-marked.    
Format dates: June 2, 2022.  
*Last updated: Month day, year*

# Tables

“Table X. Description” must be anchor’d

All figures styled with \<figure\> and \<figcaption\> 

Figure X. Description \- all anchor’d

Include “References” at the end of each doc

Include Award numbers of grants \- do this in intro sections of funded resources

Start linking to “Cite TACC” or “Acknowledge TACC”

# Punctuation

* Use serial comma  
* Use old-school two spaces after each period.  It helps with readability.  And I like it.

# Numbers

* Use en dash (instead of hyphen) for ranges.  

# Units

Express Storage/Memory capacity:

* 123GB not 123 GB

# Technical Terms

Much as I want to do “filesystem” I don’t think we’re there yet, hence separate words:

* “file spaces” not “filespaces”  
* “file systems” not “filesystems”  
* “work space” not “workspace”

# Style

* Use quotation marks around Unix command names on their first mention; drop quotation marks thereafter e.g.   
  “Use the “taccinfo” command to see your allocations.  taccinfo will display your current balances”  
* Acronyms / initials \- spell it out once, then introduce the acronym.  Use acronym thereafter.  
  “Consult the TACC User Portal (TUP) for further info.”  
* Follow Chicago’s guidelines regarding the treatment of numbers as words and numerals.

# Formatting

* Employ headline-style capitalization in section headings.
# Code Styles

The colors are hue variations of UT and TACC logo colors: I wish

* Job script  
  * Slurm directive  
    \#SBATCH \-N 10 \-n 40

* Command line examples \- Always denote proper login prompt and bold text the user actually inputs.  
  * Login node  
    login1$ **date**  
  * Local host / laptop  
    localhost$ **date**  
  * Compute node

  	c455-301$ **date**

  * Indeterminate / doesn’t matter  
    $ **date**  
      
      
* Syntax / grammar / code examples  
  * Syntax  
      
  * Code   
    // inner loop strides through row i  
    for (i=0;i\<m;i++){  
      for (j=0;j\<n;j++){  
        a\[i\]\[j\]=b\[i\]\[j\]+c\[i\]\[j\];  
      }  
      
* Code snippets (less than one line)  
  * Html: \<code\>any cource code or command line\</code\>  
  * Markdown: \`any source code or command line\`

