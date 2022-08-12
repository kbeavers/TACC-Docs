HAML	=	/usr/local/bin/haml
FRONTERA_SRC	=	\
		index.md \
		intro.md \
		quickstart.md \
		admin.md \
		portal.md \
		citizenship.md \
		files.md \
		launching.md \
		running.md \
		scripts.md \
		jobmanagement.md \
		building.md \
		programming.md \
		vis.md \
		system.md \
		cloud.md \
		containers.md \
		help.md \
		refs.md


# FRONTERA_OBJS =	index.md intro.md quickstart.md admin.md portal.md citizenship.md files.md launching.md running.md scripts.md jobmanagement.md building.md programming.md vis.md system.md cloud.md containers.md help.md refs.md

# OBJ =	$(SRC:%.haml=%.html)

all:	frontera

# .SUFFIXES:	.haml .html

#frontera:	$(FRONTERA_SRC)
frontera:	
#	cat jobscripts.html > temp.html
	cat $(FRONTERA_SRC) >> frontera.md
#	 ./configurestrings.sh temp.html frontera.md
#	/bin/rm temp.html
#	/bin/cp -f maverick2.html ..


.haml.html:
	$(HAML) $< $@

clean:
	/bin/rm -f $(OBJ) maverick2.html &2> /dev/null

