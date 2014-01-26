@goto windows >/dev/null 2>&1 >nul
#!/bin/bash

# This script can be run in both windows and linux.


# check parameters
if [ $# -ne 2 ]; then
	echo pcreator [project_name] [path]
	exit
fi

mkdir -p $2

# copy prototype dir
cp -fr prototype $2/$1

# create update for debug
echo "cmake -DCMAKE_BUILD_TYPE=Debug -DPRJ_NAME=$1 ../src">>$2/$1/debug/update.bat
echo "exit 0">>$2/$1/debug/update.bat
echo ":windows">>$2/$1/debug/update.bat
echo cmake -DCMAKE_BUILD_TYPE=Debug -DPRJ_NAME=$1 ..\\src>>$2/$1/debug/update.bat
chmod 775 $2/$1/debug/update.bat

#create update for release
echo "cmake -DCMAKE_BUILD_TYPE=Release -DPRJ_NAME=$1 ../src">>$2/$1/release/update.bat
echo "exit 0">>$2/$1/release/update.bat
echo ":windows">>$2/$1/release/update.bat
echo cmake -DCMAKE_BUILD_TYPE=Release -DPRJ_NAME=$1 ..\\src>>$2/$1/release/update.bat
chmod 775 $2/$1/release/update.bat

exit 0



:windows
echo off

:: check parameters
if "%1" == "" goto usage
if "%2" == "" goto usage

md %2

::copy prototype dir
xcopy prototype %2\%1 /E /I


::create windows update.bat
echo cmake -DCMAKE_BUILD_TYPE=Debug -DPRJ_NAME=%1 ..\src>%2\%1\debug\update.bat
echo cmake -DCMAKE_BUILD_TYPE=Release -DPRJ_NAME=%1 ..\src>%2\%1\release\update.bat
::create linux update 
echo cmake -DCMAKE_BUILD_TYPE=Debug -DPRJ_NAME=%1 ../src>%2\%1\debug\update
echo cmake -DCMAKE_BUILD_TYPE=Release -DPRJ_NAME=%1 ../src>%2\%1\release\update


goto end

:usage
echo usage: pcreator [project_name] [path]

:end
