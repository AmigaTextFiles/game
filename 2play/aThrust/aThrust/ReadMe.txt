            aThrust v2.09,   Copyright © 1994,1995 by Carsten Gerlach

Sorry, no english documentation (yet). I'm working on it, but I'm too
lazy to finish it ...
Anyway, the usage of the program is pretty easy. This file contains
some hints for those who don't speak german ;-)

aThrust v2 is a two player gravity shoot 'em up - like Gravity Force,
TurboRAKETTI and others.

But aThrust v2 has some features which other games don't have:

 . 100% system-friendly. aThrust is using the OS and runs on an
   Intuition screen. You could even convert some JPGs or download
   files while playing ;-)

 . it has an realtime two-player-mode via the serial port.

 . two players can use one keyboard (I _hate_ the joystick control
   in other aThrust games).

 . it has a font and size sensitive GUI-frontend

 . lots of extra weapons

 . own screens can be created and used

 . max. screensize is 1024x1024 at 32 colors

 . optional splitscreen/fullscreen mode while playing via modem

 . sound effects

 . amigaguide-documentation (sorry, only german documentation yet)

aThrust is giftware. Send me a gift if you like it.

Disclaimer
~~~~~~~~~~

Copyright (C) 1994,1995 Carsten Gerlach

No program, document, data file or source code from this software
package, neither in whole nor in part, may be included or used in other
software packages unless it is authorized by a written permission from the
author.

No guarantee of any kind is given that the programs described in this
document are 100% reliable. You are using this material on your own
risk.

This software package is freely distributable. It may be put on any
media which is used for the distribution of free software, like Public
Domain disk collections, CDROMs, FTP servers or bulletin board systems.


System requirements & installation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 . aThrust needs at least Kickstart 3.0 (V39) and an 68020 or better.

 . reqtools.library v38 (or better) is required.

 . aThrust screens can use much chip memory. A normal aThrust screen
   needs about 160 KB chip memory. This should not be a problem, because
   most people have at least 1 MB chip memory nowadays (or don't they ? :-)

aThrust has been successfully tested on an A3000 running V40 and on an A1200
running V39. It doesn't produce enforcer hits (well, it shouldn't ;-)

Just copy the file named 'aThrust' in a directory you like.
The subdirectory 'screens' should be in the same directory as the program.

The program can be started by calling it from CLI or from the Workbench.


How to play
~~~~~~~~~~~

Select a screen first (main window, screen-gadget, the get-gadget will open
a reqtools-filerequester). Then press the play-button. aThrust will open
the game screen now.

Use the following keys to control the game:

ESC - break, pause mode

The following keys are default values, they can be redefined:

blue player:
 . left ALT   - left turn
 . left AMIGA - right turn
 . x          - thrust
 . c          - fire
 . v          - set mine (only if extras activated)

green player:
 . right AMIGA - left turn
 . right ALT   - right turn
 . 0 (keypad)  - thrust
 . 2 (keypad)  - fire
 . 3 (keypad)  - set mine

If modemlink is activated, the following keys are used:

 . left ALT    - left turn
 . left AMIGA  - right turn
 . right SHIFT - thrust
 . RETURN      - fire
 . SPACE       - set mine


The statusline displays the follwing information:

Player 1: 9   25  3
          ^   ^   ^ 
          |   |   # of mines left (only if extras activated)
          |   +-- extra time left (only if extras activated)
          +------ # ships left

Sometimes a red extra-sprite appears if extras are activated. Touch it with
your ship to get one of the following attributes:
. back shoot
. triple shoot
. bouncing shoots
. guided shoots
. gravity shoots
. mines
Each attribute lasts 30 seconds.



Author
~~~~~~

Send bugreports, ideas, comments, gifts etc. to:

    Carsten Gerlach
    Falkentaler Steig 95a
    13467 Berlin
    Germany

    Phone: (030) 4049763

    E-Mail: gerlo@lbcmbx.in-berlin.de
