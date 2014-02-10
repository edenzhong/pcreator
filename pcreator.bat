@goto windows >\dev\null 2>&1 >nul
#!\bin\bash

# This script can be run in both windows and linux.


# check parameters
if [ %# -ne 2 ]; then
	echo pcreator [project_name] [path]
	exit
fi

mkdir -p %2

# copy prototype dir
cp -fr prototype %2\%1

# create build.bat
cp -f build_prototype\build_header.prototype %2\%1\build.bat
echo "PRJ_NAME=%1" >> %2\%1\build.bat
cat build_prototype\unix_build.prototype >> %2\%1\build.bat
echo ":windows" >> %2\%1\build.bat
echo "@echo off" >> %2\%1\build.bat
echo "set PRJ_NAME=%1" >> %2\%1\build.bat
cat build_prototype\win_build.prototype >> %2\%1\build.bat
chmod 775 %2\%1\build.bat

exit 0



:windows
::echo off

:: check parameters
if "%1" == "" goto usage
if "%2" == "" goto usage

md %2

::copy prototype dir
xcopy prototype %2\%1 /E /I


:: create build.bat
copy build_prototype\build_header.prototype %2\%1\build.bat
echo PRJ_NAME=%1 >> %2\%1\build.bat
cat build_prototype\unix_build.prototype >> %2\%1\build.bat
echo :windows >> %2\%1\build.bat
echo @echo off >> %2\%1\build.bat
echo set PRJ_NAME=%1 >> %2\%1\build.bat
cat build_prototype\win_build.prototype >> %2\%1\build.bat


goto end

:usage
echo usage: pcreator [project_name] [path]

:end
