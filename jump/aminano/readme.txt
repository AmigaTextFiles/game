
NANOTECH -- VERSION 2.6 -- BY SEAN LANE FULLER
a first-person textured 3d platform game with source code.

------------------------------ THE STORY ---------------------------------

  The people of Earth have been at peace for many years ... a peace
ensured by a superpowerful spacestation that is controlled by an
advanced artificial intelligence.  The peace may shortly end because
the space stations computers have become infected with a virus and
it is now threatening several major superpowers.  Their only hope
is a remotely controlled nanobot that has been lying dormant within
the space station's computer.  You must pilot the nanobot to the
computer's central core and destroy the virus.

------------------------- SYSTEM REQUIREMENTS ----------------------------

IBM PC Compatable >= 33 Mhz 486DX
DOS >=5.0
>=4Mb
>=1.5 MB Disk
>=VGA graphics
Soundblaster compatable sound board optional

------------------------  STANDARD DISCLAIMER  ----------------------------

In no event will the author be liable for any damages, including any lost
profits, lost savings or other incidental or consequential loss or damages
arising out of the use or of the inability to use this program -- even if
the author has been advised of the possibility of such damages.  The author
will in no event be held liable for direct, indirect, or incidental damages
resulting from the omission of any part of this product, including this
document.  The author makes no warranties, either expressed or implied,
respecting the software, its quality, performance, merchantability, or
fitness for any particular purpose.

"NanoTech" is copyright Sean Lane Fuller 1995.

"NanoTech" is freeware in the public domain and may be distributed
freely following the GNU Public License and the following
if all of the following rules are applied:

   1. No fees are to be collected from the distribution or use of this
      software, except for reasonable shipping and handling.
   2. The program and associated files may be distributed in a
      modified form as long as credit is given to Sean Lane Fuller
      in the distribution.
   3. If "NanoTech" or a modified version of it is distributed
      in CDROM or floppy disk format for profit, you are required
      to send a free copy to me.

---------------------------  CONTACT INFORMATION -------------------------

Sean Lane Fuller
124 Autumn Lane
Tullahoma, TN 37388
615-393-4550

email: fuller@edge.net
web  : http://edge.edge.net/~fuller/

If there are any oversights or errors in the documentation or any part of
this game please feel free to let me know.

If you have the time please send me a postcard.  I'm not working for
money, only for the enjoyment of others.  A postcard would let me know
that I should continue to write games like NanoTech and give me a
nice feeling about it.  Thanks!

I welcome constructive criticism and comments.

----------------------------  RELEASE NOTES  ------------------------------
Release 2.6 - October, 1996 - fixed 486 problem, 256x256 textures,
fixed texture overflow problem (with slight speed sacrifice)

Release 2.5 - September, 1996 - faster, cleaned up a bit,
added GPL comments, now releasing it with source code for
everything but the sound.

Release 2.4 - September, 1996 - faster (floor drawing is twice as fast),
removed tunnel, support for medium (640x400) and high (1024x768) resolution,
better textures, all texture mapping now perspective corrected.

Release 2.3 - September, 1996 - faster, better tunnel, -fastest, -edit,
a few map changes

Release 2.2 - July, 1996 - A few fixes, better tunnel,
-nosound, -nomusic, -tunnel, -nostars, -notextures

Release 2.0 - July, 1996 - Finally got perspective correct texture
mapping, a background, using Varmit Audio Tools, using dos4gw,
switched to watcom compiler

Release 1.0 - November, 1995 - I'm finally going to release the game.
I believe it still needs work (and more levels), but it is quite playable.
I feel pretty good about switching to MOD music.  Faster.  I sure wish
I had a Watcom compiler (for inlining assembler routines and optimization).

Release 0.x - July, 1995 -  Never saw the light of day and was only used
for beta testing on a few different machines.  It used MIDI music, which
didn't work well for me.  Used mode X graphics.

-----------------------------  INSTRUCTIONS --------------------------------

Uncompress the game into a new directory (ex: c:\ntech).  Then cd to
that directory and type "ntech" and then press <enter>.  If you want
to quit the game press <escape>.  If you want to restart on a level
then type ntech followed by the level you want to start on (ex: "ntech 5").
Give yourself a while to get the timing right to jump between platforms
in 3d.  You can also use -nosound and -nomusic if you don't have a
Sound Blaster compatible sound card, if you are having trouble, or
if you are on a slower computer.  If you want, you can also use -nostars
to make it even faster.  And, last but not least, you can turn off
textures using -notextures to increase the speed even more.  If you
have a really fast computer, then you can use the -mediumres, or
the -highres options.  These options put the game in 640x400, and
1024x768 modes respectively.  You must have super VGA to use these modes.

so, on a slow computer use:
      ntech -fastest

on a computer with no sound card use:
      ntech -nosound

on a 133 MHz pentium with a sound card use:
      ntech -highres

Controls:      F1 ............ display help screen
               up arrow ...... move forward
               down arrow .... move backward
               left arrow .... turn left
               right arrow ... turn right
               page up ....... look up
               page down ..... look down
               spacebar ...... jump
               escape ........ quit to DOS
               o ............. options toggle menu

Instructions:  Try to collide with the spinning sphere to exit a level.  The
               cubes are switches and landing on one will toggle platforms.
               The objective is just to get through all the levels.
               You cannot die.  There is no time limit.  The goal is
               just to have fun!

The "-ccpp" switch will show you the number of clock cycles per
pixel used when rendering the sbuffer (after you press "l").

------------------------ CREATING YOUR OWN LEVELS ---------------------------

The game has a built-in level editor if you start it with the -edit option
followed by a level number (for ex: ntech -edit 4).  This will automatically
set -nosound, -nostars, and -nointro.  It also disables spacebar as
the jump key.  Instead you use the u key to move up and the d key
to move down.  And it also disables collision detection.  To toggle collision
detection and gravity when in editing mode use the g key.

Pressing 'a' will let you add objects and pressing <tab> will allow you
to modify the object in front of you.

To create a new level start with a world file like 000.wld and copy
it to a new level number like 999.wld then start nanotech with
"ntech 999" to go directly to that level.  To insert the level in the
game you will have to renumber the files by renaming them and then
rename your new level to a number you opened up.  This kind of sucks,
but it is the way I created the game.  Its a lot easier to just add
it as a level number 1 higher than the ones that come with the game.

The name of the song that will be played during the level is on the
second line of the .wld file.

If the first line of the .wld file starts with a 'b' then the lighting
will fade on and off in the level.

Pressing 'l' will bring up a dynamic location and frames per second
display.  Pressing 'c' will bring up a directional compass.
Pressing 'i' will display statistics such as the number of facets
and objects and the current level.

The background and ending pictures are stored in 256 color 320x200 PCX format.
Use an editor like PC Paintbrush to edit the PCX files.  I started by
rendering with the POV ray tracer.

The music is stored in MOD or ST3 format.  You can use a tracker like
Scream Tracker 3 to edit the music and DigiPlayer to edit the samples.

The sound effects are stored in WAV format without compression at
8000 samples per second.  I used wrec that was included with my Sound
Blaster to create these files.  I also dynamically add echo to them
during the game.

------------------------------ COMPILING ----------------------------------

The code was written using Watcom C++ 10.6.  You will also need
to get a copy of Varmint's Audio Tools by Eric Jorgensen & Bryan Wilkins.
You will need the PMODE version of their library.

-------------------------------- CREDITS ----------------------------------

I learned a lot of 3d graphics concepts from "High-resolution Computer
Graphics Using C" by Ian O. Angell.  I also played around a lot with Rend386
and XSharp several years ago.  They both taught me a lot about speeding up
my graphics routines.  XSharp was published in Dr. Dobbs Journal
by Michael Abrash (I think), and Rend386 was written by Dave Stampe
and Bernie Roehl.  I also used the concept of an S buffer from
Michael Abrash.  I read about it in a description of the algorithms
used in Quake and found some sample code on the web.

Thanks to the participants in comp.graphics.algorithms,
comp.sys.ibm.pc.demos, and rec.games.programmer.

Thanks to John DiCamillo for his wonderful tale of writing a 3d first
person perspective game engine and level editor.

Thanks to Sami Tammilehto for writing DigiPlayer and Scream Tracker.
Thanks to the POV-Ray team (Chris Young, coordinator).

I got my disclaimer from a game called Board War.  It was written
by a friend of mine, Mike Cozart.  His war simulation game is
pretty cool.  Take a look at it (BWxx.ZIP) if you get a chance.

I used Varmint's Audio Tools version 0.6.
VAT was written by Eric Jorgensen and based on ideas and a bit of code from
Peter Sprenger's library called SOUNDX.  Eric has since expanded and improved
greatly on the code.

-------------- PLANS --------------------------------

I'm considering adding the following features to NanoTech.

* elevator-like platforms
* more levels
* better music
* time limit?
* nanorobot energy and damage?
* ???

------------------------- THOUGHTS --------------------------------

Sure hope somebody gets a little enjoyment out of this game.  The
graphics routines are the product of several years of work.
I wish somebody had a free, good, fast, easy to use 3d graphics library
that I could use because I would really like to concentrate on
Artificially Intelligent critters instead.  I just kind of got side tracked.
I am releasing the code so that others won't have to figure it
all out for themselves.  I'm always happy to hear from others
about computer game programming.

                           Sean Lane Fuller <fuller@edge.net>

