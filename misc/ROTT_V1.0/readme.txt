Short:        Amiga Port of Rise of the Triad ECS/AGA/RTG
Author:       jimako123@gmail.com (lantus360)
Uploader:     jimako123 gmail com (lantus360)
Type:         game/misc
Version:      1.0.0
Architecture: m68k-amigaos >= 3.1.0
Distribution: Aminet





Rise of the Triad - Version 1.0.0



Rise of the Triad: Dark War (abbreviated as ROTT) is a first-person shooter video
game that was first released in 1994 as shareware and developed by Apogee Software
(formerly 3D Realms). The members of the development team involved referred to
themselves as "The Developers of Incredible Power". The player can choose one of five
different characters to play as, each bearing unique attributes such as height, speed,
and endurance.

This port was made possible by using the open source ROTT Icculus code found
at https://icculus.org/rott/



Minimum Requirements:

- Any Amiga that can at least run EHB mode
- OS3.1
- 68030 CPU
- At least 16Meg of FAST memory
- 20Meg HDD space


Recommended Requirements for Optimal Performance:

- Amiga A1200/A4000 with fast HDD transfer rates
- OS3.9 with Boing Bag 2 or higher installed
- 68060/50Mhz or higher
- AGA or RTG graphics
- 32Meg FAST Memory or higher


Usage:

In order for the game to run on the Amiga, I've had to patch the Registered WAD
file to convert VOC audio -> RAW and MIDI to MUS files. I initially wrote a VOC
audio -> raw decoder but it used up too many CPU cycles.


1) Extract files to a folder of your choice.

2) You will need a copy of the commercial WAD file and associated files. This is
the Registered V1.3 files.

	DARKWAR.WAD
	DARKWAR.RTL
	DARKWAR.RTC

pay attention to the MD5 Checksum of these files. They should be:

	DARKWAR.WAD - e7bc1e06e6fa141e6601e64169f24697
	DARKWAR.RTL - 93a91694e7c3dec45b72708fe5914b37
	DARKWAR.RTC - 2823fe5baa07fa2a5a05df3af0cf8265

I found a copy on GOG.COM for $2.99. Worth every cent :)


You can still run the game with an un-patched WAD or shareware files but there
wont be any sound. If you want to play it this way use the NOSOUND argument.

3) If you have the correct WAD file, you need to apply the DARKWAR.IPS patch
using LunarIPS.exe supplied running on a Windows machine. You could also try AmiIPS
on the Amiga but this is untested and probably wont work. Once you are patched 
everything is good to go.

	After Patch MD5
	
	DARKWAR.WAD - d0cff9a45d127c7d4230bcd667e2d865


4) Place RTL, RTC and patched WAD file in your ROTT folder if you havent already

5) Double click on the ROTT.EXE and play!


ToolTypes and Command Line:

The following Icon tooltypes are available:


NOSOUND		- Disables sound/music. Will provide a small FPS boost
AGA		- AGA mode at 320x200 This is enabled by default
EHB		- Extra Half Brite mode at 320x200.
CGX		- RTG mode at 320x200
INDIVISION	- Indivision ECS Chunky mode (not currently implemented)
NTSC		- NTSC mode. Default is PAL.



you can use these ToolTypes via command line. ie

	rott.exe NOSOUND AGA NTSC 
	
will launch the game with no sound/music in AGA screenmode and NTSC

using commandline will override your ToolType settings.



Notes and Bugs:



* I've tried to make this port available to everyone who has an Amiga with
at least an 030 accelerator. 020 may work also but dont expect miracles
* I haven't tested on any hardware lower than an 060 outside of WinUAE.
Framerates may not be great on a real 030 setup. However in game settings
you can adjust graphics settings to compensate. I have some hardware due
soon and will look at 030 performance.
* I've played through the first episode but no further. There may be bugs/crashes.
* Indivision ECS support will be coming - as soon as my hardware arrives .
This should help those with lesser processors.
* There is no joystick support yet. I will look at adding this to a future build.
* Source Code has been provided and can be compiled via AmiDevCpp