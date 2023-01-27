SRC =   \
	notices.md \
	intro.md \
	quickstart.md \
	admin.md \
	portal.md \
	conduct.md \
	system.md \
	files.md \
	transferring.md \
	launching.md \
	running.md \
	scripts.md \
	jobmanagement.md \
	building.md \
	programming.md \
	ml.md \
	vis.md \
	jupyter.md \
	cloud.md \
	containers.md \
	help.md \
	refs.md


frontera:	FORCE $(SRC) 
	cat $(SRC) > temp.md
	../configurestrings.sh temp.md frontera.md
	/bin/rm temp.md 

outline: $(SRC)
	grep -h "# " $(SRC) > outline.md


FORCE:	
