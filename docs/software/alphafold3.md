# AlphaFold3 at TACC
*Last update: March 7, 2025*


<table cellpadding="5" cellspacing="5"><tr>
<td> <img alt="AlphaFold logo" src="../imgs/alphafold3-logo.png"></td><td>
AlphaFold3 is a deep-learning tool capable of predicting the joint structure of complexes including proteins, nucleic acids, small molecules, ions and modified residues developed by DeepMind (Google). In November 2024, the developers made the <a href="https://github.com/deepmind/alphafold">source code available on Github</a> and published a <a href="https://www.nature.com/articles/s41586-024-07487-w">Nature paper</a> (<a href="https://static-content.springer.com/esm/art%3A10.1038%2Fs41586-024-07487-w/MediaObjects/41586_2024_7487_MOESM1_ESM.pdf">supplementary information</a>) describing the method. In addition to the software, AlphaFold3 depends on ~253 GB of databases and model parameters. Researchers interested in making protein structure predictions with AlphaFold3 are encouraged to follow the guide below, and use the databases that have been prepared.</td></tr></table>

## Installations at TACC { #installations } 

!!! important
    To run AlphaFold3 on TACC Systems, you *must* obtain the model parameters directly from Google by completing <a href="https://docs.google.com/forms/d/e/1FAIpQLSfWZAgo1aYk0O4MuAXZj8xRQ8DafeFJnldNOnh_13qAx2ceZw/viewform"> this form.     
	See Google's [AlphaFold 3 Model Parameters Terms of Use](https://github.com/google-deepmind/alphafold3/blob/main/WEIGHTS_TERMS_OF_USE.md)
    
### Table 1. Installations at TACC { #table1 }

System | What's Available
-- | --
Lonestar6 | AlphaFold3: v3.0.1<br> Data: `/scratch/tacc/apps/bio/alphafold3/3.0.1/data`<br>Examples: `/scratch/tacc/apps/bio/alphafold3/3.0.1/examples`<br> Module: `/scratch/tacc/apps/bio/alphafold3/modulefiles`

