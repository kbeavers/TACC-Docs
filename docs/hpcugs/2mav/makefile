MAVERICK2_OBJS	=	\
		notices.md \
		overview.md \
		access.md \
		conduct-maverick2.md \
		files.md \
		running.md \
		vis.md \
		software.md \
		references.md
		
all:	maverick2

.SUFFIXES:	.haml .html

maverick2:	$(MAVERICK2_OBJS)
	cat $(MAVERICK2_OBJS) > temp.md
	 ./configurestrings.sh temp.md maverick2.md
	/bin/rm temp.md

clean:
	/bin/rm -f $(OBJ) maverick2.md &2> /dev/null

