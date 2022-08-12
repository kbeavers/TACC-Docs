#!/bin/sh

# include files for all TUP documentation, mostly HPC guidees

# some defaults
striping="<a\ href=\"\/user-guides\/stampede2#files-striping\">Striping\ Large\ Files\ in\ the\ Stampede2\ User\ Guide<\/a>"
taccinfopath="\/usr\/local\/etc\/taccinfo"

# citizenship - template used in Lonestar6, Longhorn, Frontera & Stampede2. Maverick2 has own citizenship.
# managingio - taccinfo
# help 

if [ "$1" = "lonestar6" ] 
then
	echo "building includes for Lonestar6 user guide"
	machinename="Lonestar6"
	helpoutputfile="lonestar6-help.html"
	citizenshipoutputfile="lonestar6-citizenship.html"
	jobaccountingoutputfile="lonestar6-jobaccounting.html"
	hwthreads="128 on AMD Milan"
	mkloutputfile="lonestar6-mkl.html"

	sed	-e "s/MACHINENAME/$machinename/g" \
		-e "s/TACCINFOPATH/$taccinfopath/g" < jobaccounting.html > $jobaccountingoutputfile
	sed	-e "s/HWTHREADS/$hwthreads/g" < mkl.html > $mkloutputfile
	sed	-e "s/MACHINENAME/$machinename/g" < help.html > $helpoutputfile
	sed	-e "s/MACHINENAME/$machinename/g" \
		-e "s/STRIPING/$striping/g"  < citizenship.html > $citizenshipoutputfile

elif [ "$1" = "stampede2" ] 
then
	echo "building includes for Stampede2 user guide"
	machinename="Stampede2"
	mkloutputfile="stampede2-mkl.html"
	hwthreads="272 on KNL, 96 on SKX, 160 on ICX"
	striping="<a\ href=\"#files-striping\">Striping\ Large\ Files<\/a>"
	helpoutputfile="stampede2-help.html"
	citizenshipoutputfile="stampede2-citizenship.html"
	jobaccountingoutputfile="stampede2-jobaccounting.html"

	sed	-e "s/MACHINENAME/$machinename/g" \
		-e "s/TACCINFOPATH/$taccinfopath/g" < jobaccounting.html > $jobaccountingoutputfile
	sed	-e "s/HWTHREADS/$hwthreads/g" < mkl.html > $mkloutputfile
	sed	-e "s/MACHINENAME/$machinename/g" < help.html > $helpoutputfile
	sed	-e "s/MACHINENAME/$machinename/g" \
		-e "s/STRIPING/$striping/g"  < citizenship.html > $citizenshipoutputfile

elif [ "$1" = "longhorn" ] 
then
	echo "building includes for Longhorn user guide"
	machinename="Longhorn"
	helpoutputfile="longhorn-help.html"
	jobaccountingoutputfile="longhorn-jobaccounting.html"
	citizenshipoutputfile="longhorn-citizenship.html"

	sed	-e "s/MACHINENAME/$machinename/g" \
		-e "s/TACCINFOPATH/$taccinfopath/g" < jobaccounting.html > $jobaccountingoutputfile
	sed	-e "s/MACHINENAME/$machinename/g" < help.html > $helpoutputfile
	sed	-e "s/MACHINENAME/$machinename/g" \
		-e "s/STRIPING/$striping/g"  < citizenship.html > $citizenshipoutputfile

elif [ "$1" = "maverick2" ] 
then
	echo "building includes for Maverick2 user guide"
	machinename="Maverick2"
	helpoutputfile="maverick2-help.html"
	jobaccountingoutputfile="maverick2-jobaccounting.html"

	sed	-e "s/MACHINENAME/$machinename/g" \
		-e "s/TACCINFOPATH/$taccinfopath/g" < jobaccounting.html > $jobaccountingoutputfile
	sed	-e "s/MACHINENAME/$machinename/g" < help.html > $helpoutputfile

# no citizenship section for Ranch
# no taccinfo for Ranch
# no striping for Ranch
elif [ "$1" = "ranch" ] 
then
	echo "building includes for Ranch user guide"
	machinename="Ranch"
	helpoutputfile="ranch-help.html"

	sed	-e "s/MACHINENAME/$machinename/g" < help.html > $helpoutputfile

# this is a bad hack - used for taccinfo, managingio
elif [ "$1" = "defaults" ] 
then
	echo "building defaults"
	sed -e "s/TACCINFOPATH/$taccinfopath/g" < taccinfo.html > tinfo.html
	
### Lonestar5 configuration
elif [ "$1" = "lonestar5" ] 
then
	echo "building includes for Lonestar5 user guide"
	machinename="Lonestar5"
	mkloutputfile="lonestar5-mkl.html"
	hwthreads="48 on the typical Haswell LS5 compute node"
	helpoutputfile="lonestar5-help.html"
	citizenshipoutputfile="lonestar5-citizenship.html"
	jobaccountingoutputfile="lonestar5-jobaccounting.html"

	taccinfopath="\/etc\/tacc\/taccinfo"  

	sed	-e "s/MACHINENAME/$machinename/g" \
		-e "s/TACCINFOPATH/$taccinfopath/g" < jobaccounting.html > $jobaccountingoutputfile
	sed	-e "s/HWTHREADS/$hwthreads/g" < mkl.html > $mkloutputfile
	sed	-e "s/MACHINENAME/$machinename/g" < help.html > $helpoutputfile
	sed	-e "s/MACHINENAME/$machinename/g" \
		-e "s/STRIPING/$striping/g"  < citizenship.html > $citizenshipoutputfile


else
	echo "configurestrings: no such machine"
	exit 1
fi

### Hikari configuration
#
#elif [ "$1" = "hikari" ] 
#then
#	echo "building includes for Hikari user guide"
#	machinename="Hikari"
#	helpoutputfile="hikari-help.html"
#	citizenshipoutputfile="hikari-citizenship.html"
#	sed	-e "s/MACHINENAME/$machinename/g" < help.html > $helpoutputfile
#	sed	-e "s/MACHINENAME/$machinename/g" < citizenship.html > $citizenshipoutputfile

