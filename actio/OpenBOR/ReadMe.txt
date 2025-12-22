OpenBOR - 68k port for Classic Amigas - V1.0.1
==============================================

Ported to the Amiga in 2017 by MVG (Modern Vintage Gamer)


Whats New?
==========

- added CD32 gamepad compability
- jumpattack no longer forces jumpattack2
- removed 68030 restriction. good luck with that 030 owners.
- better system shutdown. should no longer leak memory.



Requirements
============

- A fast Amiga with AGA or RTG. 68060 + RTG/Vampire 2 Recommended !
- 32Mb of RAM. Recommended 128 Mb


Installation
============

- Install anywhere on your Amiga. 
- You need OpenBOR PAK files. They go in the PAK subfolder

There are 3 executables to choose from:

- OpenBOR. Use this if you have AGA/RTG and a 68030 or higher Amiga with an FPU.
- OpenBOR-NoFPU. Use this if you have AGA/RTG and a 68030 or higher Amiga without an FPU.
- OpenBOR-Vampire. Use this if you have a Vampire 2.
			
Usage
=====

Please either provide a game .PAK file or an extracted PAK archive and place it 
in /PAKS

NOTE : It is STRONGLY recommended that you extract PAK files into subfolders and 
load that way.Some .PAK files can take more than 3-5 minutes to load. 

I have included files to extract .PAK files in the distribution under /tools. 
These run on a Windows PC


To extract a PAK file run the following commandline

paxplode <name of .pak file>

This will create a file called 'data' with the extracted contents inside it. 
Create a folder for the game under PAKS and move the contents of 'data' 
underneath that subfolder.

In other words - PAKS/<name of game>/data is a valid path.

OpenBOR by default will look for a directory called 'BOR' under PAK,
however you can specify what PAK file you want to load by the following 
commandline arguments:

OpenBOR <path of PAK file or directory>

The following examples are valid :

OpenBOR paks/GoldenAxe/	     * will load the extracted PAK in GoldenAxe/ (recommended)
OpenBOR paks/GoldenAxe.PAK   * will load the GoldenAxe.PAK file (slow)
OpenBOR paks/GoldenAxe/ -cgx *same as the above but will switch to RTG mode instead of AGA.


If someone wants to code a nice front end for this it would be much appreciated :) :)


Controls
========

You need a 2 button gamepad/joystick. Plug in Port 2

Up	- Move Up
Down	- Move Down
Left	- Move Left
Right	- Move Right
Fire 1 	- Attack
Fire 2 	- Jump
Both Fire 1 + Fire2 - Special Move



Return - Pause

F10 - Quit to Workbench


Only Player 1 is supported in this release.



Performance

===========

- A4000 with Warp Engine 68040/40 and AGA (C2P) - Around 05-10  FPS
- A4000 with Warp Engine 68040/40 and RTG 	- Around 10-18  FPS
- A1200 with Blizzard 1260@50Mhz and AGA (C2P) 	- Around 17-20  FPS
- A600 with Vampire 2 with Gold 2.5 Core 	- Around 60-100 FPS


Issues
======
- Quiting (F10) sometimes will crash
- For AGA, OpenBOR needs to allocate a 320x240 screenmode. You need a PAL monitor
entry in prefs screenmode that matches this resolution otherwise the engine will
crash.
- Only 1 Player works.
- Probably lots of other stuff.

Source Code
===========

is available on my github - https://github.com/lantus/openbor

Contact Me
==========



Email    : info@modernvintagegamer.com

YouTube  : http://www.youtube.com/ModernVintageGamer

Twitter  : @ModernVintageG

FaceBook : ModernVintageGamer



Credits and Thanks
==================
Amiga Fans everywhere !



