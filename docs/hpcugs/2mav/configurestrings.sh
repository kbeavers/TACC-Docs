#!/bin/sh

echo "building Maverick2 User Uuide"

#TACC images
logincomputenodes="<p><img\ src=\"\/documents\/10157\/1475729\/Login+to+compute+nodes\/3283b149-527e-4fa3-99b3-c25449d468c5?t=1496615325692\"\ style=\"width:\ 600px;\ height:\ 277px;\">"
stockyard="<img\ alt=\"Stockyard\ Work\ File\ System\"\ src=\"\/documents\/10157\/1181317\/Stockyard+2022\/41b0d037-2cb2-40c3-bda9-781933689898?t=1647883630453\"\ style=\"width:\ 800px;\ height:\ 173px;\"\/>"


revhistoryrightarrow="\"\/documents\/10157\/0\/small-right-arrow.png\/32a37818-3255-40f3-bb33-795fac19a3dd?t=1480440057000\""
revhistorydownarrow="\"\/documents\/10157\/0\/small-down-arrow.png\/05df5954-1484-4c56-8e54-1c2c0eb501dc?t=1480439900000\""

inputfile=$1
outputfile=$2

stylegreen="<span\ style=\"color:green;font-style:italic\">"
stylered="<span\ style=\"color:red\">"
styleyellow="<span\ style=\"background-color:yellow\">"
stylenowrap="<span\ style=\"white-space:\ nowrap;\">"
endspan="<\/span>"

taccuserportal="http:\/\/portal.tacc.utexas.edu\/"
xsedeuserportal="http:\/\/portal.xsede.org\/"
taccusernews="http:\/\/portal.tacc.utexas.edu\/user-news\/"
xsedeusernews="http:\/\/portal.xsede.org\/news\/"
taccinfopath="\/usr\/local\/etc\/taccinfo"

sed	-e "s/GREEN/$stylegreen/g" \
	-e "s/STYLERED/$stylered/g" \
	-e "s/YELLOW/$styleyellow/g" \
	-e "s/NOWRAP/$stylenowrap/g" \
	-e "s/ESPAN/$endspan/g" \
	\
	-e "s/TACCUSERPORTAL/$taccuserportal/g" \
	-e "s/XSEDEUSERPORTAL/$xsedeuserportal/g" \
	-e "s/TACCUSERNEWS/$taccusernews/g" \
	-e "s/XSEDEUSERNEWS/$xsedeusernews/g" \
	-e "s/TACCINFOPATH/$taccinfopath/g" \
	\
	-e "s/FIGURE-STOCKYARD/$stockyard/g" \
	-e "s/FIGURE-LOGINCOMPUTENODES/$logincomputenodes/g" \
	\
	-e "s/SMALLDOWNARROW/$revhistorydownarrow/g" \
	-e "s/SMALLRIGHTARROW/$revhistoryrightarrow/g" \
	\
	-e "s/MACHINENAME/Maverick2/g" \
	\
	< $inputfile > $outputfile

 
#if [ "$1" = "t" ]
#then
#elif [ "$1" = "x" ] 
#then
#	echo "building MACHINENAME user guide for XSEDE"
	#XSEDE images
#	logincomputenodes="<img\ src=\"\/documents\/10308\/1748604\/Login+to+compute+nodes.jpg\/ccd9bd1c-b4cf-4641-b4a3-1989086acb90?t=1515525988000\"\ style=\"height:\ 277px;\ width:\ 600px;\"\ \/>"
#	stockyard="<img\ src=\"\/documents\/10308\/1748604\/work-small.png\/2133205c-8545-4890-bf8a-cf5fe5e32f5f?t=1515525990000\"\ style=\"height:\ 112px;\ width:\ 600px;\"\ \/>"
#	revhistoryrightarrow="\"\/documents\/10308\/0\/small-right-arrow.png\/a9ed7d76-796c-4b08-b7bd-a59452bf0da1?t=1480702749000\""
#	revhistorydownarrow="\"\/documents\/10308\/0\/small-down-arrow.png\/3f6dbc1d-4bc5-4903-9f7f-ec9926d7d1eb?t=1480702747000\""
#else
#	echo "invalid command line argument"
#	exit 1
#fi
