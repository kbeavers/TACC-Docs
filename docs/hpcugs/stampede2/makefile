HAML	=	/usr/local/bin/haml
SRC	=	\
		2stampede.haml \
		draft.haml \
		notices.haml \
		intro.haml \
		access.haml \
		using.haml \
		files.haml \
		building.haml \
		running.haml \
		monitoring.haml \
		vis.haml \
		programming.haml \
		references.haml \
		history.haml 

STAMPEDEOBJS =	notices.html intro.html access.html using.html ../../include/stampede2-conduct.html files.html building.html running.html monitoring.html vis.html programming.html ../../include/stampede2-help.html references.html history.html

OBJ =	$(SRC:%.haml=%.html)

all:	include stampede2

.SUFFIXES:	.haml .html

include:
	cd ../../include; make;

stampede2:	$(STAMPEDEOBJS)
	cat header.html > temp.html
	cat $(STAMPEDEOBJS) >> temp.html
	 ./configurestrings.sh t temp.html tstampede2p2.html
	 ./configurestrings.sh x temp.html xstampede2p2.html
	/bin/rm temp.html
	/bin/cp -f ?stampede2p2.html ..


.haml.html:
	$(HAML) $< $@

clean:
	/bin/rm -f $(OBJ) ?stampede2p2.html ../?stampede2p2.html &2> /dev/null

