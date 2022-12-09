#!/bin/sh

inputfile=$1
outputfile=$2

echo "Configuring HPC user guides: $2"

stylegreen="<span\ style=\"color:green;font-style:italic\">"
stylered="<span\ style=\"color:red\">"
styleblue="<span\ style=\"color:blue;font-style:bold\">"
styleyellow="<span\ style=\"background-color:yellow\">"
stylenowrap="<span\ style=\"white-space:\ nowrap;\">"
endspan="<\/span>"

imagedir="..\/..\/..\/imgs"
figurestockyard=$imagedir+"\/stockyard-2022.jpg"

sed	\
	-e "s/IMAGEDIR/$imagedir/g" \
	-e "s/FIGURE_STOCKARD/$figurestockyard/g" \
	\
	-e "s/GREEN/$stylegreen/g" \
	-e "s/STYLERED/$stylered/g" \
	-e "s/STYLEBLUE/$styleblue/g" \
	-e "s/YELLOW/$styleyellow/g" \
	-e "s/NOWRAP/$stylenowrap/g" \
	-e "s/ESPAN/$endspan/g" \
	\
	< $inputfile > $outputfile

 
