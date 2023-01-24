		
all:	corral

CORRALSRC	=	corralsrc.md

corral:	$(CORRALSRC) FORCE
	cat $(CORRALSRC) > temp.md
	 ../configurestrings.sh temp.md corral.md
	/bin/rm temp.md

FORCE:	

