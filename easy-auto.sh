#!/bin/bash
#easy-auto.sh A setup script for using autotools in C++
#Version 0.1
#Input a directory name, version and email address or use defaults below.
mydir="mydir";
myver="0.1";
mybug="bugs@fixit.com";
if [ $1 ];then mydir=$1; echo "Dir = $mydir";           fi
if [ $2 ];then myver=$2; echo "Version = $myver";       fi
if [ $3 ];then mybug=$3; echo "Email address = $mybug"; fi
if ! [[ -d $mydir ]];then
    echo "Creating $mydir ,etc.";mkdir $mydir
    (cd $mydir; mkdir src;\
     touch README;\
     echo "SUBDIRS=src" > Makefile.am;\
     echo "dist_doc_DATA=README" >> Makefile.am;)
    (cd $mydir/src;\
     echo -e "#include <iostream> \n int main(){ \n std::cout<<\"Hello World! \"<<std::endl; \n }" > hello.cc;\
     echo -e "bin_PROGRAMS=hello \nhello_SOURCES=hello.cc" > Makefile.am;)
    (cd $mydir; autoscan;\
     sed -e 's/FULL-PACKAGE-NAME/'$mydir'/' -e 's/VERSION/'$myver'/'\
	 -e 's/BUG-REPORT-ADDRESS/'$mybug'/' configure.scan > configure.tmp;)
    #Add automake line
    s1="AC_CONFIG_HEADERS([config.h])"
    s2="AM_INIT_AUTOMAKE([ -Wall -Werror foreign ])"
    (cd $mydir;\
     cat configure.tmp | while read l;do \
	 if [ "$l" == "$s1" ];then echo "$s1"; echo "$s2"; \
	 else echo "$l"; fi; done >configure.ac )
    (cd $mydir; autoreconf -vi;\
     ./configure;\
     make;\
     src/hello;\
     rm ./configure.tmp)
fi
