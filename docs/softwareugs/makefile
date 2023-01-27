HAML	=	/usr/local/bin/md
SRC	=	\
	abaqussrc.md \
	ansyssrc.md \
	alphafoldsrc.md \
	cdtoolssrc.md \
	gaussiansrc.md \
	gromacssrc.md \
	idevsrc.md \
	irodssrc.md

OBJS	=	\
	abaqus.md \
	ansys.md \
	alphafold.md \
	cdtools.md \
	gaussian.md \
	gromacs.md \
	idev.md \
	irods.md


all:	$(OBJS)

abaqus.md:	abaqussrc.md
	./configurestrings.sh abaqussrc.md abaqus.md 

ansys.md: ansyssrc.md
	./configurestrings.sh ansyssrc.md ansys.md 

alphafold.md: alphafoldsrc.md
	./configurestrings.sh alphafoldsrc.md alphafold.md 

cdtools.md: cdtoolssrc.md
	./configurestrings.sh cdtoolssrc.md cdtools.md 

gaussian.md:	gaussiansrc.md
	./configurestrings.sh gaussiansrc.md gaussian.md 

gromacs.md:	gromacssrc.md
	./configurestrings.sh gromacssrc.md gromacs.md 

idev.md:	idevsrc.md
	./configurestrings.sh idevsrc.md idev.md 

irods.md:	irodssrc.md
	./configurestrings.sh irodssrc.md irods.md 



# ugh makefile in progress...
#gromacs:	gromacssrc.md
#	filename="`echo "gromacssrc" | sed -e "s/src//g"` + ".md""
#	echo $filename
#	./configurestrings.sh gromacssrc.md $filename 



.SUFFIXES:	.md .html

