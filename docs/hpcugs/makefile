
all:	include lonestar6 maverick2 stampede2 


include:
	echo "====== Building includes ======"
	cd ../include; make;

corral: FORCE
	echo "====== Building Corral ======"
	cd corral; make;

maverick2: FORCE
	echo "====== Building Maverick2 ======"
	cd 2mav; make;

lonestar6: FORCE
	echo "====== Building Lonestar6  ======"
	cd 6lonestar; make; 

stampede2: FORCE
	echo "====== Building Stampede2 ======"
	cd stampede2; make;

FORCE:	
