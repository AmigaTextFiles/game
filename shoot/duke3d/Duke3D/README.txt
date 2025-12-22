Release: Build 17.5
Date: 5/12/2003 12:41pm PST

The homepage for this port is:
http://www.rancidmeat.com/project.php3?id=1

The official irc channel for this port is:
irc.homelan.com #DukeNukem

-dave

Special Thanks to Adrian "JimCamel" Clark, and Ahmed Rasool for contributing
new console variables and commands.

---------------------
Build notes:
---------------------
Build 17.5 Bug fixes
* Fixed the ugly bug where "JoystickAnalogScale" was not being save in the config.
* Added a joystick value debug cvar. "DebugJoystick 1"

Build 17
* New Windows help file version of the docs
* Added "TransConsole" CVAR
* Added validation to "Level" command for the 1.5 data
* Fixed WinMidi to allow users to change which midi device is used via duke3d.cfg. 
  ->Change the "MusicDevice" variable to match your device. Most users will want this setting:
    "MusicDevice = 0"
* Added command line option for fullscreen. "-fullscreen"
* Joystick support! And the addition of a Joystick+Mouse configuration. 
  ->Please read the duke3d_w32.chm for more information. (the input section)


Build 16
* Integrated fixed sound code from kode54. (yay 48000hz!)
* Fixed crash on Area51 demo.
* Added many console variables
* Fixed duke3d.cfg handling of negative numbers. 
  ->(bug would cause duke not to run if there negative numbers in the duke3d.cfg)
* Added new autoexec.cfg system. This will allow you to auto-run commands in the 
  console at startup. One main reason for this is to allow folks to run "classic"
  mode without needing to type that into the console everytime they run the game.
* Added transparency to the console. (Thanks for the tip Cyborg)


Build 15
* Fixed a small console rendering bug. (caused by different resolutions)

Build 14
* Added brand new drop down console.
  ->Read console.txt for information.

Build 13
* Fixed demo playback for 1.4 demos (I hope)
* Integrated new Icculus networking changes. 
  ->Updated networking.txt 
* Integrated several other Icculus fixes. (for case-insensitivity etc.)

Build 12
* Fixed the demo playback for the original demo (Atomic Edition)
  ->(Thanks to Andy Hill)
* Updated the duke3d.cfg default keyboard config to be a little less goofy.
* Integrated a few small Icculus port updates.

Build 11
* Integrates the lastest Icculus changes
* Currently not using the latest networking code off the Icculus CVS.
  -> It's broken on win32, so I didn't integrate it.
  -> I need to look into that. For now net play between
  -> two players works in this build.
* Added some player maps tht I and a friend worked on back in 
  -> the day. Also included some maps we used to play frequently.

Build 10
* Integrated new Audiolib-based sound system. 
  Fixes the sound lag issues
  Fixes the sound pitch issue
  Fixes the sound cutting out issue.
  Kudos to Icculus.org

Build 9
* Improved VOC sampling.
* TCP/IP networked games 
  -Not optimized for internet play.
  -Lan games work pretty well though.

Build 8
* Can load .GRP files for Shareware, 1.3, and Atomic Edition
  So no more need for extracting the data files first. The .GRP is all you need.

Build 7
* Odd movement of some platforms in the game(ie. secret rocket launcher E1L1) is fixed.
* New Icculus code merged.

Build 6
* Sounds now cache after being played once. This fixes the sound lag bug.
  I'm going to look into having all sounds simply pre-cache upon level load. (maybe)
* Integrated the latest Icculus cvs code.
* I left the win_midi code in since there are some bugs with the midi playpack
  in the SDL port.
* Fixed the crash on exit bug in scriplib(Thanks to Icculus)

---------------------
HOWTO get it running:
---------------------

1. copy your duke3d.grp into the "bin" directory.
2. run duke3d_w32.exe

Hint: you can run custom maps like so:
duke3d_w32.exe -map spaceprt.map

Networked play using TCP/IP:
read the networking.txt doc.


-------------------------------
HOWTO get the source compiling:
-------------------------------

There are Visual Studio 6.0 and 7.0(.NET) projects avaiable.

You need the SDL lib and the SDL_mixer lib. They must be unzip
to the same directory level. 
For Example:

proj/
    duke3d_w32/
    SDL-1.2.5/
    SDL_mixer-1.2.5/

The other option is to change the source include, and lib 
include paths to match your SDL installation.

Basically I assume you know how to use Visual Studio.. So I hope you do.


------
Links:
------

libSDL                    
  - http://www.libsdl.org
SDL_mixer                 
  - http://www.libsdl.org/projects/SDL_mixer/
Icculus Duke3d Linux port 
  - http://icculus.org/duke3d/
Another win32 port:
  - http://www.shacknews.com/ja.zz?id=7144651




