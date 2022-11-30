HAML	=	/usr/local/bin/haml

.SUFFIXES:	.haml .html

.haml.html :
	$(HAML) $< $@

# haml source files
 SRC	=	acls.haml \
		blas-lapack.haml \
		ddtsrc.haml \
		filesharing.haml \
		globustaccsrc.haml \
		managingio.haml \
		map.haml \
		mfa.haml \
		modules.haml \
		remotedesktopaccess.haml \
		stockyardmigration.haml \
		TAP.haml \
		webaccessirods.haml\
		webaccessacls.haml

OBJ =	$(SRC:%.haml=%.html)

all:	include acls.html blas-lapack.html ddtsrc.html filesharing.html globustaccsrc.html managingio mfa modules.html remotedesktopaccess.html stockyardmigration.html TAP.html webaccessacls.html webaccessirods.html

include:
		cd ../include; make

mfa:	mfa.html
	./configurestrings.sh mfa.html out.html	
	/bin/mv out.html mfa.html

managingio:	managingiosrc.html
	./configurestrings.sh managingiosrc.html managingio.html	
	/bin/rm managingiosrc.html

clean:
	cd ../include; make clean
	/bin/rm -f $(OBJ) 

