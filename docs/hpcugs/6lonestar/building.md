#building
	:markdown
		# [Building Software](#building)

		The phrase "building software" is a common way to describe the process of producing a machine-readable executable file from source files written in C, Fortran, or some other programming language. In its simplest form, building software involves a simple, one-line call or short shell script that invokes a compiler. More typically, the process leverages the power of <a href="http://www.gnu.org/software/make/manual/make.html">makefiles</a>, so you can change a line or two in the source code, then rebuild in a systematic way only the components affected by the change. Increasingly, however, the build process is a sophisticated multi-step automated workflow managed by a special framework like <a href="http://www.gnu.org/software/automake/manual/html_node/Autotools-Introduction.html">autotools</a> or <a href="http://cmake.org"><code>cmake</code></a>, intended to achieve a repeatable, maintainable, portable mechanism for installing software across a wide range of target platforms.</p>

#building-basics
	:markdown
		## [The Basics of Building Software](#building-basics)

		This section of the user guide does nothing more than introduce the big ideas with simple one-line examples. You will undoubtedly want to explore these concepts more deeply using online resources. You will quickly outgrow the examples here. We recommend that you master the basics of makefiles as quickly as possible: even the simplest computational research project will benefit enormously from the power and flexibility of a makefile-based build process.

#building-intelcompiler
	:markdown
		## [Intel Compilers](#building-intelcompiler)

		Intel is the recommended and default compiler suite on Lonestar6. Each Intel module also gives you direct access to `mkl` without loading an `mkl` module; see [Intel MKL](#the-intel-math-kernel-library-mkl) for more information. Here are simple examples that use the Intel compiler to build an executable from source code:

		Compiling a code that uses OpenMP would look like this:

		<pre class="cmd-line">
		$ <b>icc -qopenmp mycode.c -o myexe</b>  # OpenMP</pre>

		See the published Intel documentation, available both [online](http://software.intel.com/en-us/intel-software-technical-documentation) and in `${TACC_INTEL_DIR}/documentation`, for information on optimization flags and other Intel compiler options.

#building-gnucompilers
	:markdown
		## [GNU Compilers](#building-gnucompilers)

		The GNU foundation maintains a number of high quality compilers, including a compiler for C (`gcc`), C++ (`g++`), and Fortran (`gfortran`). The `gcc` compiler is the foundation underneath all three, and the term `gcc` often means the suite of these three GNU compilers.

		Load a `gcc` module to access a recent version of the GNU compiler suite. Avoid using the GNU compilers that are available without a `gcc` module &mdash; those will be older versions based on the "system gcc" that comes as part of the Linux distribution.

		Here are simple examples that use the GNU compilers to produce an executable from source code:

		<pre class="cmd-line">
		$ <b>gcc mycode.c</b>                    # C source file; executable a.out
		$ <b>gcc mycode.c          -o myexe</b>  # C source file; executable myexe
		$ <b>g++ mycode.cpp        -o myexe</b>  # C++ source file
		$ <b>gfortran mycode.f90   -o myexe</b>  # Fortran90 source file
		$ <b>gcc -fopenmp mycode.c -o myexe</b>  # OpenMP; GNU flag is different than Intel
		</pre>

		Note that some compiler options are the same for both Intel and GNU <span style="white-space: nowrap;">(e.g. `-o`)</span>, while others are different (e.g. `-qopenmp` vs `-fopenmp`). Many options are available in one compiler suite but not the other. See the [online GNU documentation](https://gcc.gnu.org/onlinedocs/) for information on optimization flags and other GNU compiler options.

#building-compiling
	:markdown
		## [Compiling and Linking as Separate Steps](#building-compiling)

		Building an executable requires two separate steps: (1) compiling (generating a binary object file associated with each source file); and (2) linking (combining those object files into a single executable file that also specifies the libraries that executable needs). The examples in the previous section accomplish these two steps in a single call to the compiler. When building more sophisticated applications or libraries, however, it is often necessary or helpful to accomplish these two steps separately.

		Use the `-c` ("compile") flag to produce object files from source files:

		<pre class="cmd-line">
		$ <b>icc -c main.c calc.c results.c</b>
		</pre>

		Barring errors, this command will produce object files `main.o`, `calc.o`, and `results.o`. Syntax for other compilers Intel and GNU compilers is similar.

		You can now link the object files to produce an executable file:

		<pre class="cmd-line">
		$ <b>icc main.o calc.o results.o -o myexe</b></pre>

		The compiler calls a linker utility (usually `/bin/ld`) to accomplish this task. Again, syntax for other compilers is similar.

#building-include
	:markdown
		## [Include and Library Paths](#building-include)

		Software often depends on pre-compiled binaries called libraries. When this is true, compiling usually requires using the `-I` option to specify paths to so-called header or include files that define interfaces to the procedures and data in those libraries. Similarly, linking often requires using the `-L` option to specify paths to the libraries themselves. Typical compile and link lines might look like this:

		<pre class="cmd-line">
		$ <b>icc        -c main.c -I${WORK}/mylib/inc -I${TACC_HDF5_INC}</b>                  # compile
		$ <b>icc main.o -o myexe  -L${WORK}/mylib/lib -L${TACC_HDF5_LIB} -lmylib -lhdf5</b>   # link
		</pre>

		On Lonestar6, both the `hdf5` and `phdf5` modules define the environment variables `$TACC_HDF5_INC` and `$TACC_HDF5_LIB`. Other module files define similar environment variables; see [Using Modules](#admin-modules) for more information.

		The details of the linking process vary, and order sometimes matters. Much depends on the type of library: static (`.a` suffix; library's binary code becomes part of executable image at link time) versus dynamically-linked shared (.so suffix; library's binary code is not part of executable; it's located and loaded into memory at run time). The link line can use rpath to store in the executable an explicit path to a shared library. In general, however, the `LD_LIBRARY_PATH` environment variable specifies the search path for dynamic libraries. For software installed at the system-level, TACC's modules generally modify `LD_LIBRARY_PATH` automatically. To see whether and how an executable named `myexe` resolves dependencies on dynamically linked libraries, execute `ldd myexe`.

		A separate section below addresses the [Intel Math Kernel Library](#the-intel-math-kernel-library-mkl) (MKL).

#building-mpi
	:markdown
		## [Compiling and Linking MPI Programs](#building-mpi)

		Intel MPI (module `impi`) and MVAPICH2 (module `mvapich2`) are the two MPI libraries available on Lonestar6. After loading an `impi` or `mvapich2` module, compile and/or link using an mpi wrapper (`mpicc`, `mpicxx`, `mpif90`) in place of the compiler:

		<pre class="cmd-line">
		$ <b>mpicc    mycode.c   -o myexe</b>   # C source, full build
		$ <b>mpicc -c mycode.c</b>              # C source, compile without linking
		$ <b>mpicxx   mycode.cpp -o myexe</b>   # C++ source, full build
		$ <b>mpif90   mycode.f90 -o myexe</b>   # Fortran source, full build
		</pre>

		These wrappers call the compiler with the options, include paths, and libraries necessary to produce an MPI executable using the MPI module you're using. To see the effect of a given wrapper, call it with the `-show` option:

		<pre class="cmd-line">
		$ <b>mpicc -show</b>  # Show compile line generated by call to mpicc; similarly for other wrappers
		</pre>


#building-thirdparty
	:markdown
		## [Building Third-Party Software](#building-thirdparty)

		You can discover already installed software using TACC's [Software Search](https://www.tacc.utexas.edu/systems/software) tool or execute `module spider` or `module avail` on the command-line.

		You're welcome to download third-party research software and install it in your own account. In most cases you'll want to download the source code and build the software so it's compatible with the Lonestar6 software environment. You can't use yum or any other installation process that requires elevated privileges, but this is almost never necessary. The key is to specify an installation directory for which you have write permissions. Details vary; you should consult the package's documentation and be prepared to experiment. When using the famous [three-step autotools](http://www.gnu.org/software/automake/manual/html_node/Autotools-Introduction.html) build process, the standard approach is to use the `PREFIX` environment variable to specify a non-default, user-owned installation directory at the time you execute `configure` or `make`:

		<pre class="cmd-line">
		$ <b>export INSTALLDIR=$WORK/apps/t3pio</b>
		$ <b>./configure --prefix=$INSTALLDIR</b>
		$ <b>make</b>
		$ <b>make install</b>
		</pre>

		Other languages, frameworks, and build systems generally have equivalent mechanisms for installing software in user space. In most cases a web search like "Python Linux install local" will get you the information you need.

		In Python, a local install will resemble one of the following examples:

		<pre class="cmd-line">
		$ <b>pip3 install netCDF4      --user</b>                  # install netCDF4 package to $HOME/.local
		$ <b>python3 setup.py install --user</b>                   # install to $HOME/.local
		$ <b>pip3 install netCDF4     --prefix=$INSTALLDIR</b>     # custom location; add to PYTHONPATH
		</pre>

		Similarly in R:

		<pre class="cmd-line">
		$ <b>module load Rstats</b>            # load TACC's default R
		$ <b>R</b>                             # launch R
		> <b>install.packages('devtools')</b>  # R will prompt for install location
		</pre>
 
		You may, of course, need to customize the build process in other ways. It's likely, for example, that you'll need to edit a `makefile` or other build artifacts to specify Lonestar6-specific [include and library paths](#include-and-library-paths) or other compiler settings. A good way to proceed is to write a shell script that implements the entire process: definitions of environment variables, module commands, and calls to the build utilities. Include `echo` statements with appropriate diagnostics. Run the script until you encounter an error. Research and fix the current problem. Document your experience in the script itself; including dead-ends, alternatives, and lessons learned. Re-run the script to get to the next error, then repeat until done. When you're finished, you'll have a repeatable process that you can archive until it's time to update the software or move to a new machine.

		If you wish to share a software package with collaborators, you may need to modify file permissions. See [Sharing Files with Collaborators](http://portal.tacc.utexas.edu/tutorials/sharing-project-files) for more information.

/Intel MKL
= File.read "../../include/lonestar6-mkl.html"

