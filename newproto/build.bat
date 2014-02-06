@goto windows >/dev/null 2>&1 >nul
#!/bin/bash

# This script can be run in both windows and linux.

PRJ_NAME="exe"

function help()
{
	echo "build.bat [debug|release|run|gdb|test|update|help]"
	echo ""
	echo "debug       : build a debug exectuion."
	echo "release     : build a release execution."
	echo "run         : run the project."
	echo "gdb         : use gdb to debug the project."
	echo "test        : run the test."
	echo "update      : update cmake files. used when new source file or"
	echo "              configuration changed in the project."
	echo "help        : print this help."
	echo ""
	echo "if no option is given, debug will be the default one."
}

BUILD_TYPE="nil"
RUN_DEBUG="nil"
TO_TEST=0
TO_UPDATE=0

if [ x$1 != x ]; then
	for arg in "$@" 
	do
		if [ $arg == "debug" ]; then
			BUILD_TYPE="debug"
		elif [ $arg == "release" ]; then
			BUILD_TYPE="release"
		elif [ $arg == "run" ]; then
			RUN_DEBUG="run"
		elif [ $arg == "gdb" ]; then
			RUN_DEBUG="debug"
		elif [ $arg == "test" ]; then
			TO_TEST=1
		elif [ $arg == "update" ]; then
			TO_UPDATE=1
		else
			help
			exit 1;
		fi
	done
else
	BUILD_TYPE="debug"
fi


if [ $TO_UPDATE -eq 1 ] ; then
	echo "to update cmake"
	cd debug
	cmake -DCMAKE_BUILD_TYPE=Debug -DPRJ_NAME=$PRJ_NAME ..
	cd ../release
	cmake -DCMAKE_BUILD_TYPE=Release -DPRJ_NAME=$PRJ_NAME ..
fi

if [ $BUILD_TYPE == "debug" ] ; then
	echo "to build debug"
	cd debug
	make
fi

if [ $BUILD_TYPE == "release" ] ; then
	echo "to build release"
	cd release
	make
fi

if [ $RUN_DEBUG == "run" ];then
	echo "to run"
fi

if [ $RUN_DEBUG == "debug" ];then
	echo "to debug"
fi

if [ $TO_TEST == 1 ] ; then
	echo "run unit test"
fi





exit 0

:windows