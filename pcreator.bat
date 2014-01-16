@echo off

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