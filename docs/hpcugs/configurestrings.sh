#!/bin/sh

inputfile=$1
outputfile=$2

echo "Configuring HPC user guides: $2"

# old stuff

# common variables
hostname="stampede2.tacc.utexas.edu"
userportal="<a\ href=\"https:\/\/portal.tacc.utexas.edu\">TACC\ User\ Portal<\/a>"

# revision history
revhistoryrightarrow="\"\/documents\/10157\/0\/small-right-arrow.png\/32a37818-3255-40f3-bb33-795fac19a3dd?t=1480440057000\""
revhistorydownarrow="\"\/documents\/10157\/0\/small-down-arrow.png\/05df5954-1484-4c56-8e54-1c2c0eb501dc?t=1480439900000\""
#revhistoryrightarrow="\/Users\/slindsey\/dev\/small-right-arrow.png"
#revhistorydownarrow="\/Users\/slindsey\/dev\/small-down-arrow.png"

stampede1ug="http:\/\/portal.tacc.utexas.edu\/user-guides\/stampede"
stampede2ug="http:\/\/portal.tacc.utexas.edu\/user-guides\/stampede2"
ranchug="https:\/\/portal.tacc.utexas.edu\/user-guides\/ranch"


# images

stampedepano="<img\ src=\"\/documents\/10157\/1475729\/S2_with_paintjob.jpg\/3729b4fb-4fe8-4130-aec5-d95b1852a84b?t=1501774382263\"\ style=\"width:\ 800px;\ height:\ 593px;\"\ \/><\/p>"
logincomputenodes="<p><img\ src=\"\/documents\/10157\/1475729\/Login+to+compute+nodes\/3283b149-527e-4fa3-99b3-c25449d468c5?t=1496615325692\"\ style=\"width:\ 600px;\ height:\ 277px;\">"
# stockyard="<img\ src=\"\/documents\/10157\/1475729\/work-small.png\/3614e8bb-6a9b-463d-bad8-5e6908197101?t=1512082334284\"\ style=\"width:\ 800px;\ height:\ 150px;\">"
# stockyard="<img\ alt=\"Stockyard\ Work\ file\ system\"\ src=\"\/documents\/10157\/1181317\/Stockyard+filesystem+updated\/8c7e3389-573c-4e12-9636-bf0856f3a389?t=1555952835748\"\ style=\"width:\ 800px;\ height:\ 184px;\"\/>"
stockyard="<img\ alt=\"Stockyard\ Work\ File\ System\"\ src=\"\/documents\/10157\/1181317\/Stockyard+2022\/41b0d037-2cb2-40c3-bda9-781933689898?t=1647883630453\"\ style=\"width:\ 800px;\ height:\ 173px;\"\/>"
knlmemorymodes="<p><img\ alt=\"KNL\ Memory\ Modes\"\ src=\"\/documents\/10157\/1334612\/KNL+Memory+Modes.png\/f19c64b8-6007-4a08-a6f3-80cabf9a2c20\"\ style=\"width:\ 800px;\ height:\ 171px;\"\ \/>"
knlclustermodes="<p><img\ alt=\"KNL\ Cluster\ Modes\"\ src=\"\/documents\/10157\/1334612\/KNL+Cluster+Modes.png\/142c5092-c736-48ea-a3cc-f3d9d3f43647\"\ style=\"width:\ 800px;\ height:\ 274px;\"\ \/>"

taccusernews="http:\/\/portal.tacc.utexas.edu\/user-news\/"
xsedeusernews="http:\/\/portal.xsede.org\/news\/"
taccinfopath="\/usr\/local\/etc\/taccinfo"

stylegreen="<span\ style=\"color:green;font-style:italic\">"
stylered="<span\ style=\"color:red\">"
styleyellow="<span\ style=\"background-color:yellow\">"
stylenowrap="<span\ style=\"white-space:\ nowrap;\">"
endspan="<\/span>"


sed	-e "s/USERGUIDETITLE/$title/" \
	-e "s/STAMPEDEHOSTNAME/$hostname/g" \
	-e "s/STAMPEDE1/$stampede1ug/g" \
	-e "s/STAMPEDE2/$stampede2ug/g" \
	\
    -e "s/MACHINENAME/Stampede2/g" \
	\
	-e "s/GREEN/$stylegreen/g" \
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
	-e "s/RANCHUSERGUIDE/$ranchug/g" \
	\
	-e "s/FIGURE-STAMPEDEPANO/$stampedepano/g" \
	-e "s/FIGURE-STOCKYARD/$stockyard/g" \
	-e "s/FIGURE-KNLMEMORYMODES/$knlmemorymodes/g" \
	-e "s/FIGURE-KNLCLUSTERMODES/$knlclustermodes/g" \
	-e "s/FIGURE-LOGINCOMPUTENODES/$logincomputenodes/g" \
	\
	-e "s/FIGURE-STAMPEDEZEUSNODEDIAGRAM/$zeusnodediagram/g" \
	-e "s/FIGURE-STAMPEDENODE/$stampedenode/g" \
	-e "s/FIGURE-INTELCOPROCESSOR/$intelcoprocessor/g" \
	-e "s/FIGURE-INTERCONNECT/$interconnect/g" \
	-e "s/FIGURE-KMPAFFINITY/$kmpaffinity/g" \
	\
	-e "s/SMALLDOWNARROW/$revhistorydownarrow/g" \
	-e "s/SMALLRIGHTARROW/$revhistoryrightarrow/g" \
	< $inputfile > $outputfile

 
# revision history
revhistoryrightarrow="\"\/documents\/10157\/0\/small-right-arrow.png\/32a37818-3255-40f3-bb33-795fac19a3dd?t=1480440057000\""
revhistorydownarrow="\"\/documents\/10157\/0\/small-down-arrow.png\/05df5954-1484-4c56-8e54-1c2c0eb501dc?t=1480439900000\""

stylegreen="<span\ style=\"color:green;font-style:italic\">"
stylered="<span\ style=\"color:red\">"
styleblue="<span\ style=\"color:blue;font-style:bold\">"
styleyellow="<span\ style=\"background-color:yellow\">"
stylenowrap="<span\ style=\"white-space:\ nowrap;\">"
endspan="<\/span>"

imagedir="..\/..\/..\/imgs"
figurestockyard=$imagedir+"\/stockyard-2022.jpg"

sed	-e "s/USERGUIDETITLE/$title/" \
	\
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
	-e "s/SMALLDOWNARROW/$revhistorydownarrow/g" \
	-e "s/SMALLRIGHTARROW/$revhistoryrightarrow/g" \
    -e "s/SUBMITTICKET/$submitticket/g" \
	< $inputfile > $outputfile

 
