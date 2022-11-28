SRC =   \
        notices.md \
        intro.md \
        access.md \
        using.md \
        files.md \
        building.md \
        running.md \
        monitoring.md \
        vis.md \
        programming.md \
        references.md \
        history.md


stampede2:	$(SRC)
	cat $(SRC) > temp.md
	../configurestrings.sh temp.md stampede2.md
	/bin/rm temp.md 

outline: $(SRC)
	grep -h "# " $(SRC) > outline.md

