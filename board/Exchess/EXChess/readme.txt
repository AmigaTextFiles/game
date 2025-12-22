EXchess v2.45 by Dan Homan, dch@vlbi.astro.brandeis.edu

=> For updates see:
    http://www.astro.brandeis.edu/BRAG/people/dch/chess.html

This program is freeware, distributed under the GNU public
license.  I ask only that you e-mail me your impressions/suggestions
so that I may improve future versions.

Analyze mode in xboard/winboard now work with EXchess!

See the search.par file to modify how EXchess thinks!

Notes on Win95/NT console version.
 - This version has a serviceable text interface or it can be run with
   Tim Mann's Winboard.

 - To run it with Winboard, you need to execute the command:

   winboard -fcp "c:\directory\EXchess xb"

   The new versions (4.0) of Winboard and Xboard do not need the "xb". 

 - EXchess will look for the opening book and search.par files in the 
   same directory as the executable and then in the working directory.
   You should not need to put a copy of the book in the Winboard
   directory.

 - To run EXchess in text mode, just type "EXchess" in the EXchess 
   directory

 - There is an additional command line option "hash", you can set the
   hash size in megabytes like

   EXchess hash 4      (for a 4 megabyte hash file, for example)

   If this option is used with winboard, use the line

   winboard -fcp "c:\directory\EXchess xb hash 4"

   The default hash size is about 6 megabytes.  The size of the
   hash table may also be changed from within the program.

   Note: Don't set the hash table size too large.  Doing so may
   cause swapping to the hard disk and slow the program down considerably.
   One half the available RAM is a good maximum guideline.

 - Help is available by typing "help" at the command prompt.

 - The file "wac.epd" is a testsuite and can be run by the "testsuite"
   command.

 - The 'build' command lets you make your own opening book out of a pgn
   text file.  It requires about 2.5 times the size of the pgn file in 
   temporary storage space on the disk.  The 'build' command can currently
   handle pgn files up to 150 MBytes in size... To use a larger file, you
   will need to modify some definitions in book.cpp and recompile.

Notes on the 32 bit DOS version.

 - A dpmi extender is included.

 - Help is available by typing "help" at the command prompt.

 - A mouse is required.

 - The hash command line option also works with this version.

Notes on the source code version.  
 - The source code is not as well commented as I would like it to
   be, but that will change with time.

 - Code is C++, but I make little use of the OOP features of C++.  This
   will change in future versions.  

 - This will produce a console (text) version that is compatitable
   with xboard (on unix) and winboard (on win95/NT).  Notes on the
   console version (given above) apply.

 - Once compiled (see notes below) you will need to build your 
   own book from a pgn file using the "build" command.  This
   is very easy.  I've provided an pgn file on my homepage, but
   you can put together your own, if you like.  

 - This should compile on almost any system with a C++ compiler.  There
   are compiler switches in "define.h" to select various systems.

   #define BORLAND  1      // Selects a win95/NT compiler if set to 1 
                           //  this should work with MSVC and others as
                           //  well
   #define DEC      0      // Set to 1 for certain DEC Unix systems, not
                           //  all will need it - some other unixes may
                           //  need this if there are errors in "book.cpp"
   #define UNIX     0      // Set to 1 for all Unix systems 

 - This should compile without further modifications, but if 
   further modifications are needed, the above variables will mark
   all of the system dependant stuff in the source code, so you can
   track down the necessary changes.

   NOTE:  I did have one problem on our old Ultrix system where I needed
   to add the lines 

   #undef SIG_IGN
   #define SIG_IGN ((void (*)(int))( 1))

   at the end of the #includes in main.cpp.  I have not seen this
   problem anywhere else.

 - On our unix system here at the lab, I compile using the command
   line...

   cxx -o EXchess *.cpp -O4 -inline speed -om -non_shared -lm

   Your command line and compiler options will likely be different.

 - I don't have much time to support the source code version, but
   please let me know if you successfully get this to compile on a
   system.  
