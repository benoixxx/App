#!/bin/bash

set -e # Add directives to exit on error (-e)
set -u # Add directives to consider uninitialized variables as an error      

TARGET="x86_64"
BUILD_TYPE="Debug"
BUILD_ROOT="$HOME/dev/build/$TARGET"
LOCAL_ROOT="$HOME/dev/local/$TARGET"
CLEAN_BUILD_DIR=false

while [[ $# -gt 0 ]]
do
	ARG="$1"
	case $ARG in
	-c)
		CLEAN_BUILD_DIR=true
		;;
	-d)
		BUILD_TYPE="Debug"
		;;
	-r)
		BUILD_TYPE="Release"
		;;
	--help)
		echo -e "\nusage: $0 [-cdr]"
	    echo -e "  -c      clean build dir & local dir"
	    echo -e "  -d      create project in debug mode (default)"
	    echo -e "  -r      create project in release mode"
    	exit 1
		;;
	esac
	shift
done
 
CURRENTPATH=$PWD


rm -rf $LOCAL_ROOT
mkdir -p $LOCAL_ROOT



PROJECT_NAME=`basename $PWD`
	
BUILD_DIR="$BUILD_ROOT/$PROJECT_NAME"
rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR

cd $BUILD_DIR 
cmake -DCMAKE_BUILD_TYPE:STRING=$BUILD_TYPE \
      -DCMAKE_INSTALL_PREFIX:PATH=$LOCAL_ROOT \
      $CURRENTPATH

[[ $? -ne 0 ]] && exit 1
#make -j8
#make install


cd $CURRENTPATH