pcreator
========

A tiny project creator base on cmake. It works on windows/Linux/MAC OSX. Only support C/C++ now. 
Usage: 
  pcreator [project name] [path]. 
  
Then a cross platform C/C++ project will be created.

After a project created, you may find a script "build" in the project folder. 
Usage of build:
  build update
    create the make file by cmake. you should run this script everytime you put a new source file to the project.
  build debug
    build the debug version of the project.
  build release
    build the release version of the project.
  build run
    run the debug version.
  build gdb
    debug the program.

other usage please read the f***ing source code of "build".
