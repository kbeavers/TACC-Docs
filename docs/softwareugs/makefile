HAML	=	/usr/local/bin/md
SRC	=	\
		gaussian.md \
		gromacssrc.md \
		tensorflow.md \
		vasp.md

OBJ =	$(SRC:%.md=%.html)

.md.html :
	$(HAML) $< $@


all:	gromacs	


gromacs:	gromacssrc.md
	./configurestrings.sh gromacssrc.md gromacs.md

.SUFFIXES:	.md .html

clean:
	cd ../include; make clean
	/bin/rm *.html

