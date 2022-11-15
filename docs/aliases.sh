#!/bin/sh

echo "User Guide Aliases"

stylegreen="<span\ style=\"color:green;font-style:italic\">"
stylered="<span\ style=\"color:red\">"
styleblue="<span\ style=\"color:blue;font-style:bold\">"
styleyellow="<span\ style=\"background-color:yellow\">"
stylenowrap="<span\ style=\"white-space:\ nowrap;\">"
endspan="<\/span>"

imagedir="..\/..\/img\/"

# HPC UGs as of 11/15/2022
# Corral, Frontera, Lonestar6, Longhorn, Maverick2, Ranch, Stampede2

corralug="https:\/\/portal.tacc.utexas.edu\/user-guides\/corral"
fronteraug="https:\/\/frontera-portal.tacc.utexas.edu\/user-guide"
lonestar6ug="https:\/\/portal.tacc.utexas.edu\/user-guides\/lonestar6"
longhorn="https:\/\/portal.tacc.utexas.edu\/user-guides\/longhorn"
maverick2ug="https:\/\/portal.tacc.utexas.edu\/user-guides\/maverick2"
ranchug="https:\/\/portal.tacc.utexas.edu\/user-guides\/ranch"
stallionug="https:\/\/portal.tacc.utexas.edu\/user-guides\/stallion"
stampede2ug="http:\/\/portal.tacc.utexas.edu\/user-guides\/stampede2"

# Software

idevug="http:\/\/portal.tacc.utexas.edu\/software\/idev"

taccuserportal="http:\/\/portal.tacc.utexas.edu\/"
taccusernews="http:\/\/portal.tacc.utexas.edu\/user-news\/"
createticket="http:\/\/portal.tacc.utexas.edu\/tacc-consulting\/-\/consult\/tickets\/create"

# revision history
revhistoryrightarrow="\"\/documents\/10157\/0\/small-right-arrow.png\/32a37818-3255-40f3-bb33-795fac19a3dd?t=1480440057000\""
revhistorydownarrow="\"\/documents\/10157\/0\/small-down-arrow.png\/05df5954-1484-4c56-8e54-1c2c0eb501dc?t=1480439900000\""

sed	\
	-e "s/STYLEGREEN/$stylegreen/g" \
	-e "s/STYLERED/$stylered/g" \
	-e "s/STYLEBLUE/$styleblue/g" \
	-e "s/STYLEYELLOW/$styleyellow/g" \
	-e "s/NOWRAP/$stylenowrap/g" \
	-e "s/ESPAN/$endspan/g" \
	\
	-e "s/IMAGEDIR/$imagedir/g" \
	-e "s/CORRALUG/$corralug/g" \
	-e "s/FRONTERAUG/$fronteraug/g" \
	-e "s/LONESTAR6UG/$lonestar6ug/g" \
	-e "s/LONGHORNUG/$longhornug/g" \
	-e "s/MAVERICK2UG/$maverick2ug/g" \
	-e "s/RANCHUG/$ranchug/g" \
	-e "s/STALLIONUG/$stallionug/g" \
	-e "s/STAMPEDE2UG/$stampede2ug/g" \
	\
	-e "s/TACCUSERPORTAL/$taccuserportal/g" \
	-e "s/TACCUSERNEWS/$taccusernews/g" \
	-e "s/CREATETICKET/$createticket/g" \
	\
	< $inputfile > $outputfile

 
