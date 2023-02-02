#!/bin/sh

inputfile=$1
outputfile=$2

echo "Configuring Software user guides: $2"

stylegreen="<span\ style=\"color:green;font-style:italic\">"
stylered="<span\ style=\"color:red\">"
styleblue="<span\ style=\"color:blue;font-style:bold\">"
styleyellow="<span\ style=\"background-color:yellow\">"
stylenowrap="<span\ style=\"white-space:\ nowrap;\">"
endspan="<\/span>"

imagedir="..\/..\/..\/imgs"
pdfdir="..\/..\/pdfs"

sed	\
	-e "s/IMAGEDIR/$imagedir/g" \
	-e "s/PDFDIR/$pdfdir/g" \
	\
	-e "s/GREEN/$stylegreen/g" \
	-e "s/STYLERED/$stylered/g" \
	-e "s/STYLEBLUE/$styleblue/g" \
	-e "s/YELLOW/$styleyellow/g" \
	-e "s/NOWRAP/$stylenowrap/g" \
	-e "s/ESPAN/$endspan/g" \
	\
	< $inputfile > $outputfile

 
