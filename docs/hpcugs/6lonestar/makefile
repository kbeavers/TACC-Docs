LONESTAR6_OBJS	=	\
	notices.md \
	system.md \
	files.md \
	admin.md \
	../../include/lonestar6-conduct.md \
	building.md \
	launching.md \
	running.md \
	scripts.md \
	jobmanagement.md \
	vis.md \
	../../include/lonestar6-help.md 

all:	lonestar6

lonestar6:	$(LONESTAR6_OBJS)
	cat header.html > temp.md
	cat $(LONESTAR6_OBJS) >> temp.md
	 ../configurestrings.sh temp.md lonestar6.md
	/bin/rm temp.md


