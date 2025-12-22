Readme for AmigaDuke - AmigaOS 4.0 version

This version is based on the Amiga 68k 0.3 version from Dante/Oxyron port which can be found here:
http://www.neoscientists.org/~dante/

This version works on AmigaOS 4.0 and on Amiga Classic (ppc), AmigaOne and microA1 hardware.
Comments and bugreports please send to glquake@libero.it
Updates will be available on the http://www.soft3dev.net web site.

Ciao

Massimiliano Tretene, S o f t 3

Installation:
-------------

	- install the game from your cd on a pc, then copy the whole
	  duke3d-directory to your amiga

	- unpack the archive with the executable into this directory

	- set a assign "duke3d:" to this directory

	- start it from cli with a stack of 16384 bytes minimum!!!
	  If you forget to increase the stacksize, your system will crash!

	- enjoy :)


Requirements:
-------------

	- Duke Nukem 3D ATOMIC EDITION, older versions won't work!!! Have a
	  look at www.3drealms.com or try your luck at Amazon, or Ebay...

	- Amiga with PPC cpu and AmigaOS 4.0

	- 32 MB free Fastram

	- AHI

	- Picasso96


Remarks:
--------

The configuration of sound, keys etc. is inside of "duke3d.cfg". To change it,
you have to use a Editor who DON'T changes the MS/DOS-Format of this file!!!
CygnusED i.E. is a good choice.
Theres no midi-playback certainly, so let the MIDI-Device at 13, this means
"no music".
Sound only works in 16bit now, so please don't change.

Hm, in short: DON'T change anything in the config, except the Screenmode!!!

It's possible to use the AmigaSetup utility included which is an AOS4 port of the original 68k utility at:
http://www.neoscientists.org/~dante/ (source code included)


Hints:
------

	- to get the framerate, type inside a running game "dnrate"

	- if loading is slow, and/or the game oftens hangs while loading, try
	  to add some buffers. For example, type in cli
	  "addbuffers duke3d: 2048" before you start the game.

Tested on:
----------
        - Amiga 4000 604/180Mhz and CVPPC

        - AmigaOne SE G3/600Mhz and Voodoo 3

        - microA1 G3/800 Mhz and Radeon 7000

        - AmigaOne XE G3/800 Mhz and Radeon 7500

        - AmigaOne XE G4/933 Mhz and Radeon 9100


Missing Features:
-----------------

	- no network
	- no midi music
	- you can't exchange saved games with ones from the x86-versions
