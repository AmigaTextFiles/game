=====================================================
=                                                   =
=   JBB's BOLCATAXIAN v1.01 MorphOS-SDL 26/11/2005  =
=                                                   =
=====================================================

Description:
------------
- second game ported to Morphos, in roughly 1 week
- (originally developped for GP32, won first price at the ADIC2004 competition)
- introductionary demo with 5 levels
- Highscore management,accumulative weapons and bonuses, big bosses etc.
- Options screen allowing to change controlsm music, sfx and fullscreen mode.

Requirements:
-------------
- PegasosI or II, G3 or G4, Morphos1.4 or higher
- PowerSDL library (recent, if possible)
- Graphic card able to support 320x240-8bit or windowed mode.
- You might need to create a special screenmode (specs above) to run.

Technical Details:
------------------
- Gfx, Design, Code, Muisc & Sfx : JBB! 
- Coded in C, using MorphED and Gcc, SDL and SDL_mixer libraries.
- 8 bit palette mode (256 colour) for optimium speed.
- locked at 60Hz on G3-600Mhz (for playability).

History:
--------
- Added more details in the error printf for screen opening.
- Added fullscreen option remembered at launch.

Controls:
----------
- Press Space to start a game.
- O to call the option screen from the main menu.
- ESC quits the curent game, then the program.
- P Pauses the game (or click outside the window)
- Cursor keys to control the ship
- Depending on configuration, SPACE to fire, N to upgrade and RETURN to loop.

Left to do & known issued:
--------------------------
- Self configurable music (you can replace the tune.mod for now)
- MUI Configuration options (needed? not sure anymore)
- Real truecolor with alpha shadows (wow!)
- Fix the last bugs, better AI, better bosses, more levels, more weapons!

PowerSDL:
---------
version 8.0 and superior adapted by Ilkka Lehtoranta
based on SDL 1.2.7 (c) 1997-2005 Sam Lantiga
Original MorphOS port by Gabriele Greco
Sources can be obtained from ilkleht@isoveli.org

Special Thanks:
---------------
- GavinB for help in intial setup, AlexS, ChrisS, JamesB for beta testing.
- Team17 for their lovely Meteor bitmap in ProjectX which heavily inspired mines!

Bolcatoid Contact:
------------------
To contact me, and give feedback:  bolcatoid@freeuk.com
Or JBB on AmigaImpact & MorphZone forums.
Or visit my website: http://home.freeuk.net/bolcatoid

Note this program is FREEWARE! Yeppe! :) 

Enjoy!
JBB
