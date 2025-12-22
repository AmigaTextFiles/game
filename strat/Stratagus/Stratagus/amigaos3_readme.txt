Stratagus port for AmigaOS 3 with WarpOS
----------------------------------------

Stratagus is an open source game engine for real-time strategy games.
There are many projects, like Invasion - Battle of Survival, which use
Stratagus.  Also WarCraft 2 can be played through the Wargus mod.

This archive includes Invasion - Battle of Survival game for Stratagus
and Wargus (plus support tools (wartool) to extract COPYRIGHTED WarCraft 2
data from ORIGINAL DOS WarCraft 2 CD-ROM).

When depacking Stratagus.lha, use parameter -a to preserve file
attributes.  Otherwise you may need to fix the them manually.

Requirements
------------

1. You need an Amiga with OS 3+ (tested on 3.9) with a PPC - the faster,
the better.

2. WarpOS installed.  This build is designed for Hedeon's version of WarpOS
(github.com/Sakura-IT/SonnetAmiga).  It does work on Blizzard PPCs and
Cyberstorm PPCs but even my 330MHz CSPPC plays Wargus too slow to be
enjoyable.

3. You will likely need a file system that can cope with long filenames
eg SFS, especially with Wargus.



Play
----

To play Invasion, click its icon.

To play Wargus, click Prepare_WarCraft2_Data first.  You will likely get
many file not found errors - this is normal! If you have the expansion disk
you can use the same script to install that after the main game.  If the
script completes without serious errors, click Play_Wargus.


Release 3
---------

Quick update to make use of the latest SDL library which brings:
- Better mouse handling.  Hit Ctrl-G in game if playing in a window to
   grab or ungrab the mouse.
- Game colours now sorted out on big endian graphics modes

Release 2
---------

This version brings the following changes compared to Release 1:
- Multiplayer support!
- Fixed: proper identification if there is no CD-ROM drive
- Fixed: install script errors
- Fixed: other bugs

Multiplayer
-----------

Additional requirements for multiplayer:
- Make sure your TCP/IP stack is running before starting the game
- You need to know the IP address of the computer that is going to be the
game server.  You can still play via the server.
- Make sure that ports 6660-6669 are open for UDP traffic.  This is
especially important if you use Genesis which usually blocks all ports by
default.
- Someone to play against!  This could be another Amiga otherwise builds of
Stratagus for other OSs are available here (sourceforge.net/projects/
stratagus/files/Oldfiles).  Be sure to pick one dated 2004-07-02 to get a
matching version.


Credits and thanks
------------------

To Grelbfarlk and Hedeon for the convertsound script, the original source,
toolchain, bug-squishing and tons of other help!

To the creator of the AmigaOS 4 conversion of Stratagus for the icons and
a previous version of this readme.




Wrangler, November 2018
