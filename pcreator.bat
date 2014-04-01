echo off

echo usage: pcreator [project_name] [path]

set tpath=.
set tprj=prj

:: check parameters
if "%1" == "" goto check_prj_end
set tprj=%1
:check_prj_end

if "%2" == "" goto check_path_end
set tpath=%2
:check_path_end

echo %tpath%
echo %tprj%

mkdir %tpath%

::copy prototype dir
xcopy prototype %tpath%\%tprj% /E /I


:: create build for unix
echo #!/bin/bash>%tpath%\%tprj%\build
echo PRJ_NAME=%tprj%>> %tpath%\%tprj%\build
type build_prototype\unix_build.prototype >> %tpath%\%tprj%\build


:: create build.bat
echo @echo off> %tpath%\%tprj%\build.bat
echo set PRJ_NAME=%tprj%>> %tpath%\%tprj%\build.bat
type build_prototype\win_build.prototype >> %tpath%\%tprj%\build.bat


goto :EOF
