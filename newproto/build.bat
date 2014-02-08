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

# handle actions
if [ $TO_UPDATE -eq 1 ] ; then
	echo "to update cmake"
	cd debug
	cmake -DCMAKE_BUILD_TYPE=Debug -DPRJ_NAME=$PRJ_NAME ..
	cd ../release
	cmake -DCMAKE_BUILD_TYPE=Release -DPRJ_NAME=$PRJ_NAME ..
	cd ..
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
	if [ $BUILD_TYPE == "nil" ] ; then
		cd debug # default run the debug version
	fi
	$PRJ_NAME
fi

if [ $RUN_DEBUG == "debug" ];then
	echo "to debug"
	if [ $BUILD_TYPE == "nil" ] ; then
		cd debug # default run the debug version
	fi
	gdb $PRJ_NAME
fi

if [ $TO_TEST == 1 ] ; then
	echo "run unit test"
	if [ $BUILD_TYPE == "nil" ] ; then
		cd debug # default run the debug version
	fi
	${PRJ_NAME}_test
fi





exit 0

:windows
@echo off
set PRJ_NAME=exe
set BUILD_TYPE=nil
set RUN_DEBUG=nil
set TO_TEST=0
set TO_UPDATE=0

:: parse arg
:parse_arg
if "%1" == "" goto end_parse_arg
if "%1" == "debug" set BUILD_TYPE="debug"
if "%1" == "release" set BUILD_TYPE="release"
if "%1" == "update" set TO_UPDATE=1
if "%1" == "run" set RUN_DEBUG="run"
if "%1" == "gdb" set RUN_DEBUG="debug"
if "%1" == "test" set TO_TEST=1
shift
goto parse_arg
:end_parse_arg

:: handle action
if %TO_UPDATE% == 1 goto to_update
:end_update

if %BUILD_TYPE% == "debug" goto make_debug
:end_make_debug

if %BUILD_TYPE% == "release" goto make_release
:end_make_release

if %RUN_DEBUG% == "run" goto run_exe
:end_run_exe

if %RUN_DEBUG% == "debug" goto debug_exe
:end_debug_exe

if %TO_TEST% == 1 goto to_test
:end_test

goto end_build

:to_update
if not exist debug md debug
cd debug
cmake -DCMAKE_BUILD_TYPE=Debug -DPRJ_NAME=$PRJ_NAME ..
cd ..
if not exist release md release
cd release
cmake -DCMAKE_BUILD_TYPE=Release -DPRJ_NAME=$PRJ_NAME ..
cd ..
goto end_update

:make_debug
cd debug
make
goto end_make_debug

:make_release
cd release
make
goto end_make_release

:run_exe
if %BUILD_TYPE% == nil cd debug :: default run debug
%PRJ_NAME%
:end_run_exe

:debug_exe
if %BUILD_TYPE% == nil cd debug :: default run debug
::gdb %PRJ_NAME%
echo Not implement.
:end_debug_exe

:to_test
if %BUILD_TYPE% == nil cd debug :: default test debug
%PRJ_NAME%_test
:end_to_test

:end_build