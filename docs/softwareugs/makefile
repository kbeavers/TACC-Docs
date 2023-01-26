HAML	=	/usr/local/bin/md
SRC	=	\
		gaussian.md \
		gromacssrc.md \
		tensorflow.md \
		vasp.md

# OBJ =	$(SRC:%.md=%.html)

.md.html :
	$(HAML) $< $@


all:	abaqus	

abaqus:	abaqussrc.md
	./configurestrings.sh abaqussrc.md abaqus.md 

# ugh makefile in progress...
gromacs:	gromacssrc.md
	filename="`echo "gromacssrc" | sed -e "s/src//g"` + ".md""
	echo $filename
	./configurestrings.sh gromacssrc.md $filename 



.SUFFIXES:	.md .html

clean:
	cd ../include; make clean
	/bin/rm *.html

