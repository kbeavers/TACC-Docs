HAML=	/usr/local/bin/haml

SRC	=	scratchpolicy.haml mkl.haml taccinfo.haml citizenship.haml help.haml jobaccounting.haml
OBJ =	$(SRC:%.haml=%.html)

all:	includes 

.SUFFIXES:	.haml .html

includes:	$(OBJ)
	./configurestrings.sh lonestar6
	./configurestrings.sh stampede2
	./configurestrings.sh longhorn
	./configurestrings.sh maverick2
	./configurestrings.sh ranch
	./configurestrings.sh defaults
	./configurestrings.sh lonestar5

.haml.html :
	$(HAML) $< $@

clean:
	/bin/rm -f $(OBJ) *.html &2> /dev/null

