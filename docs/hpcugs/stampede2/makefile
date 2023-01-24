SRC =   \
        notices.md \
        intro.md \
        access.md \
        conduct.md \
        files.md \
        building.md \
        running.md \
		scripts.md \
        monitoring.md \
        vis.md \
        programming.md \
        references.md \
		../../include/stampede2-help.md \
        history.md


stampede2:	FORCE $(SRC) 
	cat $(SRC) > temp.md
	../configurestrings.sh temp.md stampede2.md
	/bin/rm temp.md 

outline: $(SRC)
	grep -h "# " $(SRC) > outline.md


FORCE:	
