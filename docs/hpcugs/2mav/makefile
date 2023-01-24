MAVERICK2_OBJS	=	\
		notices.md \
		overview.md \
		access.md \
		conduct-maverick2.md \
		files.md \
		running.md \
		scripts.md \
		vis.md \
		software.md \
		../../include/maverick2-help.md \
		references.md
		
all:	maverick2

maverick2:	$(MAVERICK2_OBJS)
	cat jobscripts.html > temp.md
	cat $(MAVERICK2_OBJS) >> temp.md
	 ../configurestrings.sh temp.md maverick2.md
	/bin/rm temp.md


