Readme.md for sample-scripts

These are starter scripts for autotooling C++ and C
projects on Linux. (Fedora 25 tested)

They create two directories and compile a hello world
program to get things started. The source code resides
in the subdir "src" and the Makefile.am file is where
new files may be added.

easy-auto.sh is for C++.

easy-auto-c.sh is for C.

Simply follow the conventions in Makefile.am to add new files. Here is
an example where ex10.1a.cc is added.

bin_PROGRAMS=hello ex10.1a
hello_SOURCES=hello.cc
ex10_1a_SOURCES=ex10.1a.cc

Then run make to compile.

