HAML	=	/usr/local/bin/md
SRC	=	\
	abaqussrc.md \
	ansyssrc.md \
	alphafoldsrc.md

OBJS	=	\
	abaqus \
	ansys \
	alphafold


all:	$(OBJS)

abaqus:	abaqussrc.md
	./configurestrings.sh abaqussrc.md abaqus.md 

ansys: ansyssrc.md
	./configurestrings.sh ansyssrc.md ansys.md 

alphafold: alphafoldsrc.md
	./configurestrings.sh alphafoldsrc.md alphafold.md 

# ugh makefile in progress...
gromacs:	gromacssrc.md
	filename="`echo "gromacssrc" | sed -e "s/src//g"` + ".md""
	echo $filename
	./configurestrings.sh gromacssrc.md $filename 



.SUFFIXES:	.md .html

