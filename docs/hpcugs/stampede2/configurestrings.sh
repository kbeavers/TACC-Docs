#!/bin/sh

if [ "$1" = "t" ]
then
	echo "building Stampede2 user guide for TACC"
	title="<h1\>Stampede2\ User\ Guide<\/h1\>"

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


elif [ "$1" = "x" ] 
then
	echo "building Stampede2 user guide for XSEDE"
	title="<h1\>Stampede\ 2\ User\ Guide<\/h1\>"

	# common variables
	hostname="stampede2.tacc.xsede.org"
	userportal="<a\ href=\"https:\/\/portal.xsede.org\">XSEDE\ User\ Portal<\/a>"
	stampede1ug="http:\/\/portal.xsede.org\/tacc-stampede"
	stampede2ug="http:\/\/portal.xsede.org\/tacc-stampede2"
	ranchug="https:\/\/portal.xsede.org\/tacc-ranch"

	#revision history arrows
	revhistoryrightarrow="\"\/documents\/10308\/0\/small-right-arrow.png\/a9ed7d76-796c-4b08-b7bd-a59452bf0da1?t=1480702749000\""
	revhistorydownarrow="\"\/documents\/10308\/0\/small-down-arrow.png\/3f6dbc1d-4bc5-4903-9f7f-ec9926d7d1eb?t=1480702747000\""

	#XSEDE images
	logincomputenodes="<img src=\"broken\">"
	stockyard="<img src=\"broken\">"
	knlmemorymodes="<img src=\"broken\">"
	knlclustermodes="<img src=\"broken\">"


	stampedepano="<img\ alt=\"Stampede2\"\ src=\"\/documents\/10308\/1748604\/S2_with_paintjob.jpg\/e47fab7e-972f-449e-9713-b589c6d633c3?t=1515525989000\"\ style=\"height:\ 445px;\ width:\ 600px;\ border-width:\ 1px;\ border-style:\ solid;\">"

	logincomputenodes="<img\ src=\"\/documents\/10308\/1748604\/Login+to+compute+nodes.jpg\/ccd9bd1c-b4cf-4641-b4a3-1989086acb90?t=1515525988000\"\ style=\"height:\ 277px;\ width:\ 600px;\"\ \/>"

	# stockyard="<img\ src=\"\/documents\/10308\/1748604\/work-small.png\/2133205c-8545-4890-bf8a-cf5fe5e32f5f?t=1515525990000\"\ style=\"height:\ 112px;\ width:\ 600px;\"\ \/>"
	stockyard="<img\ src=\"\/documents\/10308\/0\/Stockyard+2022\/258b47cd-0511-4bc4-9377-e53a502f60c8?t=1647884902359\"\ style=\"width:\ 600px;\ height:\ 129px;\"\/>"


	knlmemorymodes="<img\ alt=\"KNL\ Memory\ Modes\"\ src=\"\/documents\/10308\/1748604\/KNL+Memory+Modes.png\/e123ecf1-ded3-41fe-87c7-c1ffd72bac3f?t=1515529369778\"\ style=\"height:\ 128px;\ width:\ 600px;\ border-width:\ 1px;\ border-style:\ solid;\"\ \/>"
		
	knlclustermodes="<img\ alt=\"KNL\ Cluster\ Modes\"\ src=\"\/documents\/10308\/1748604\/KNL+Cluster+Modes.png\/b0edef5e-4a16-4b4a-bad9-fad96d4d9543?t=1515529355512\"\ style=\"height:\ 206px;\ width:\ 600px;\ border-width:\ 1px;\ border-style:\ solid;\"\ \/>"

else
	echo "invalid command line argument"
	exit 1
fi

inputfile=$2
outputfile=$3

taccuserportal="http:\/\/portal.tacc.utexas.edu\/"
xsedeuserportal="http:\/\/portal.xsede.org\/"
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

 
