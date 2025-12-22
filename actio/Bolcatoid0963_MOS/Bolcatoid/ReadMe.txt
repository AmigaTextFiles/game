====================================================
=                                                  =
=   JBB's BOLCATOiD v0.963 MorphOS-SDL 16/11/2004  =
=                                                  =
====================================================

Description:
------------
- first game ported to Morphos, in roughly 1 week
- (originally developped for GP32, won second price at the ADIC2003 competition)
- 25 levels, Highscore management, plenty of accumulative bonuses!
- Hint: Try to pickup the falling bricks for more points! (can combo up to 90pts)

what's new in v0.96:
--------------------
- 640x480 hires mode! (with improved gfx)
- Options screen (prefs saved with hiscore) with loads of options
- proportional speed to frame rate (as the game can get slow on G3 in 640x480) 
- v0.963 most of the bugfixes reported to date 9inc broken audio on latest SDL)

Technical Details:
------------------
- Gfx, Design, Code & Sfx : JBB!  Music from... Jester!
- C (90%), with a little bit of C++ here and there
- Using the SDL library
- 8 bit palette mode (256 colour) for sprites, on 16 bit screenmode.
- over 100fps on G3-600Mhz in 320x240 (locked at 60Hz for playability).

Misc keys:
----------
- Left MouseButton starts the game, and fire weapons
- Mouse movement controls the base
- ESC quits the curent game, then the program.
- P Pauses the game (or click outside the window)

Requirements:
-------------
- PegasosI or II, G3 or G4, Morphos1.4 or higher
- PowerSDL library (recent, if possible > v8.0)
- Graphic card able to support 320x240-16/24bit or 640x480-16/24bit (G4 advised)

Left to do & known issued:
--------------------------
- Speed issues with VGA mode (on G3), lag on clicks and keystrokes
- Self configurable music (you can replace the tune.mod for now)
- MUI Configuration options (needed? not sure anymore)
- Real truecolor with alpha shadows (wow!)
- Fix the last bugs, better AI of monsters etc...

PowerSDL:
---------
version 8.0 and superior adapted by Ilkka Lehtoranta
based on SDL 1.2.7 (c) 1997-2004 Sam Lantiga
Original MoirphOS port by Gabriele Greco
Sources can be obtained from ilkleht@isoveli.org

Bolcatoid Contact:
------------------
To contact me, and give feedback:  bolcatoid@freeuk.com
Or JBB on AmigaImpact & MorphZone forums.
Or visit my website: http://home.freeuk.net/bolcatoid

Note this program is FREEWARE! Yeppe! :) 

Enjoy!
JBB
