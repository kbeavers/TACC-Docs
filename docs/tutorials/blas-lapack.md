# BLAS and LAPACK at TACC
*Last update: January 20, 2022*


## [BLAS/LAPACK Implementations](#blas) { #blas }

BLAS (Basic Linear Algebra Subprograms) is a set of definitions of common operations on vectors and (dense) matrices. LAPACK is the Linear Algebra Package that builds on BLAS and that offers numerical algorithms such as linear system solving and eigenvalue calculations. The so-called "reference" implementations of BLAS/LAPACK are written in Fortran and can be found on <http://netlib.org>, but in practice you don't want to use them since they have low performance. Instead, TACC offers libraries that conform to the specification, but that achieve high performance. They are typically written in a combination of C and Assembly.

## [Updating your `makefile`](#makefile) { #makefile }

Your makefile may contain "`libblas.a`" or "`-lblas"`. Most Linux distributions indeed have a library by that name, but it will not be tuned for the TACC processor types. Instead, use one of the following libraries.

### [MKL](#mkl) { #mkl }

Intel's Math Kernal Library (MKL) is a high performance implementation of BLAS/LAPACK and several other packages. MKL is installed on TACC's Frontera, Stampede2 and Lonestar6 resources. See each resource's user guide for detailed information on linking the MKL into your code.

* [Frontera](../../hpcugs/frontera/frontera#the-intel-math-kernel-library-mkl)
* [Stampede2](../../hpcugs/stampede2/stampede2#intel-math-kernel-library-mkl)
* [Lonestar6](../../hpcugs/6lonestar/lonestar6#intel-math-kernel-library-mkl)

In general:

* Under the Intel compiler, using BLAS/LAPACK is done through adding the flag "`-mkl`" both at compile and link time.

* Under the GCC compiler, there is a module "`mkl`" that defines the `TACC_MKL_DIR` and `TACC_MKL_LIB` environment variables. What libraries you need depends on your application, but often the following works:

		-L${TACC_MKL_LIB} -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread

* If you are installing PETSc, use the the following options: 

		--with-blas-lapack-dir=${TACC_MKL_DIR}

	This variable is automatically defined when using the Intel compiler. If you are compiling with `gcc`, then you must first load the MKL module:

		module load mkl

* If you are installing software using `cmake`, add this flag (exact flag may differ by package):

		-D LAPACK_LIBRARIES=${TACC_MKL_DIR}/lib/intel64_lin/libmkl_intel_lp64.so;${TACC_MKL_DIR}/lib/intel64_lin/libmkl_core.so
	If paths and library names are separately specified:

		-D LAPACK_LIBRARY_DIRS:PATH="${TACC_MKL_LIB}"
		-D LAPACK_LIBRARY_NAMES:STRING="mkl_intel_lp64;mkl_sequential;mkl_core;pthread"


### [BLIS](#blis) { #blis }

BLIS (BLAS-like Library Instantiation Software Framework) is an open source high performance implementation of BLAS/LAPACK. It can be accessed through a module: "`module load blis`". You will then find the library file in `$TACC_BLIS_LIB`. BLIS extends the BLAS specification; for documentation see <https://github.com/flame/blis>.

### [Reference BLAS/LAPACK](#refs) { #refs }

The reference implementation for BLAS/LAPACK is written in Fortran and is very low performance. However, for debugging purposes it can be useful. You can load it with:

	module load referencelapack

This gives access to the compiled Fortran sources from netlib.org/lapack. When building your program with this library, you either need to use the Fortran compiler as linker, or add "`-lgfortran`" to the link line.


### [Goto Blas and OpenBlas](#goto) { #goto }

Older implementations such as Goto Blas (after former TACC employee Kazushige Goto), and its offshoot, OpenBlas, are no longer maintained and should not be used. Instead, use MKL or BLIS as described above.


<!-- # [BLAS/Lapack on Longhorn](#longhorn)

Longhorn is an IBM system, which comes with IBM's own compilers and numerical libraries. The equivalent of MKL is [ESSL (Engineering and Scientific Software Library)](https://www.ibm.com/support/knowledgecenter/en/SSFHY8/essl_welcome.html). Link ESSL into your code with:

<pre class="cmd-line">login1$ <b>xlc -o myprogram myprogram.c -L/opt/ibmmath/essl/6.2/lib64/ -lessl</b></pre> -->


