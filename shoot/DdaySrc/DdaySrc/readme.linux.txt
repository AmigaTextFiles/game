D-DAY LINUX BUILD (4.0)
-----------------------
2002-06-04: pbowens

 Included in the source release are the two OS-dependant g_dll.c source files, as well as the corresponding makefiles. The linux Makefiles should work with most recent versions of gnu make. While the Win32 project files are included in the top directory above src/, linux Makefiles are in the actual src/ directory. This means, in order to compile, you must:

/some/dir/dday% cd src
/some/dir/dday/src% make

 It is not necessary, but is possible, to compile the usa/grm libraries individually, as they are invoked in the root Makefile.

 By default, compiling with debugging symbols is enabled. In order to compile for release, you must manually edit the Makefiles. It should be very straightforward.

 The following platforms are known to work:
	Debian (potato)
	RedHat 7.1, 7.2 (with local 3.21 q2ded build)
	Slackware 8.0

 It seems the libraries will not load under FreeBSD's linux emulation. A bit of tinkering with the source may fix this(?)

 A note on the differences between linux and win32 library handling:

 In Win32, upon map load and team entity spawn, a dynamic team struct is created. In this struct, the team DLL is loaded. This usually occurs twice per a map since two teams are always required for a playable game of D-Day. 

 When trying to port this system to linux, things crashed, and rather unpredictably. After countless hours of headaches, asprin, Mt Dew, and NIN, I finally found a hacked solution. Rather than loading the team dlls per each map load, they are loaded once, and according to their specified team index. Then, in subsequent map loads, all references to the team indexes use the initial loaded libraries. This actually works out quite well, since all the maps I have ever tested on linux use team 0 for usa, and team 1 for grm. Furthermore, I have noticed a lot less lag one the two linux servers tested on. 

 This *could* be a problem with later, user-modified team DLLs. For instance, dday1 is loaded, team 0 is forever usa, and team 1 is forever grm. Then later on in the map cycle, a map with user-modified dlls is loaded. The game will still use the usa library for team 0, and the grm library for team 1.

 I am no expert at library programming and dynamic memory handling, but it is my belief in order to do something in linux like of which is in place in win32, a more advanced solution is necessary. I invite anyone and everyone to take a shot at it-- it may be simpler than I thought. 