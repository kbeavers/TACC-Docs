LS6SRC	=	 	\
	notices.md \
	system.md \
	files.md \
	admin.md \
	building.md \
	launching.md \
	running.md \
	scripts.md \
	jobmanagement.md \
	vis.md


lonestar6:	$(LS6SRC)
	cat $(LS6SRC) > temp.md
	../configurestrings.sh temp.md lonestar6.md
	/bin/rm temp.md 


outline: $(LS6SRC)
	grep -h "# " $(LS6SRC) >> outline.haml


