<script type="text/javascript">
function showhide() {
var div = document.getElementById("revisions");
if (div.style.display == "block") 
{
document.getElementById("img-arrow").src = SMALLRIGHTARROW;
div.style.display = "none";
}
else 
{
div.style.display = "block";
document.getElementById("img-arrow").src = SMALLDOWNARROW;
}
}
</script>

## [Revision History](#history) { #history }

"Last Update" at the top of this document is the date of the most recent change to this document. This revision history is a list of non-trivial updates; it excludes routine items such as corrected typos and minor format changes.
 
<a href="javascript:showhide()"><img src=SMALLRIGHTARROW id="img-arrow">Click to view</a>

<div id="revisions" style="display:none">

* 09/14/22 XSEDE project ends. Replace Globus with Grid Community Toolkit.
* 03/07/22 Intel Ice Lake nodes introduced.  New `icx-normal` queue.
* 04/24/18 Changes to Table 1 and Table 5 associated with new `long` queue.
* 04/03/18 Stampede1 decommissioned; removed/revised references to Stampede1 as appropriate.
* 03/26/18 Corrected and relocated material on `qopt-zmm-usage`.
* 02/23/18 New functionality associated with `task_affinity`, `tacc_affinity`, and `mem_affinity` (scripts related to MPI task pinning and KNL memory management).
* 11/30/17 Initial release supporting Phase 2 (SKX).
* 08/02/17 Removed references and links to Stampede2 Transition Guide (now deprecated).
* 06/12/17 Initial public release.
</div>
