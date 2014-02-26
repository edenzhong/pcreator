echo off

:: check parameters
if "%1" == "" goto usage
if "%2" == "" goto usage

mkdir %2

::copy prototype dir
xcopy prototype %2\%1 /E /I


:: create build for unix
echo #!/bin/bash>%2\%1\build
echo PRJ_NAME=%1>> %2\%1\build
type build_prototype\unix_build.prototype >> %2\%1\build


:: create build.bat
echo @echo off> %2\%1\build.bat
echo set PRJ_NAME=%1>> %2\%1\build.bat
type build_prototype\win_build.prototype >> %2\%1\build.bat


goto :EOF

:usage
echo usage: pcreator [project_name] [path]
goto :EOF
