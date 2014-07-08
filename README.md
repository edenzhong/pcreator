pcreator
========

This a tiny project creator base on cmake. It works on windows/Linux/MAC OSX. Only support C/C++ now. 

Usage: 

    pcreator [project name] [path] [language]
  
Then a cross platform C/C++ project will be created. 

If [path] is omitted, "." will be the [path]. 

if [project name] is omitted, "prj" will be the default project name. 

If [language] is omitted, "c" will be the language.

After a project created, you may find a script "build" in the project folder. 

Usage of build:

- build update

    create the make file by cmake. you should run this script everytime you put/remove a source file to/from the project.

- build debug

    build the debug version of the project.

- build release

    build the release version of the project.

- build run

    run the debug version.

- build gdb

    debug the program.

The parameters can be put together. For example:

    build update debug run

This command will update the make file, then build a debug version, and then run the binary code.
The sequence of the parameter is irrelevant. i.e.

    build update debug run

is equal to 

    build run debug update

other usage please read the f***ing source code of "build".
