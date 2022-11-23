HAML	=	/usr/local/bin/haml

SRC	=	 	notices.haml system.haml files.haml admin.haml building.haml launching.haml running.haml scripts.haml jobmanagement.haml vis.haml append.haml
LS6OBJS	=	notices.html system.html files.html admin.html ../../include/lonestar6-conduct.html building.html launching.html running.html scripts.html jobmanagement.html vis.html ../../include/lonestar6-help.html append.html

OBJ =	$(SRC:%.haml=%.html)

all:	include ls6.html

.SUFFIXES:	.haml .html

include:
	cd ../../include; make

ls6.html: $(LS6OBJS)
	cat css.html > temp.html
	cat jscripts.html >> temp.html
	cat $(LS6OBJS) >> temp.html
	./configurestrings.sh temp.html ls6.html
	/bin/rm temp.html 
	/bin/cp -p ls6.html ..

.haml.html :
	$(HAML) $< $@

clean:
#	cd ../../include; make clean
	/bin/rm -f $(LS6OBJS) ls6.html ../ls6.html &2> /dev/null

outline: $(SRC)
	grep -h "# " $(SRC) >> outline.haml


