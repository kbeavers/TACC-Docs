		
all:	ranch

RANCHSRC	=	ranchsrc.md

ranch:	$(RANCHSRC)
	cat $(RANCHSRC) > temp.md
	 ../configurestrings.sh temp.md ranch.md
	/bin/rm temp.md

