About OpenJazz
--------------

OpenJazz is a free, open-source version of the classic Jazz JackrabbitTM games.
OpenJazz can be compiled on a wide range of operating systems, including
Windows 98/Me/XP and Linux. To play, you will need the files from one of the
original games. 

With the demise of DOS-based operating systems, it has become necessary to use
emulators to play old DOS games. Jazz JackrabbitTM deserves more - and would
benefit greatly from new features.
OpenJazz was started on the 23rd of August, 2005, by Alister Thomson.
Academic pressures put the project on hold until late December 2005. The source
code was released on the 25th, and the first version with a degree of
playability was released on the 15th of January. Since then, a variety of ports
have been released by other people. 

About Jazz JackrabbitTM
-----------------------

Jazz JackrabbitTM is a PC platform game. Produced by Epic Games (then Epic
MegaGames), it was first released in 1994. The fast-paced, colourful gameplay
proved popular, and the game won PC Format's Arcade Game of the Year award.
Many people still recall the shareware versions. 

The shareware releases are available at Haze's Hideout:
http://www.dutchfurs.com/~haze/blog/files.php?cat=files&dir=files/pc/shareware

Installing OpenJazz for Amiga 
You will need two things:

  1. An existing installation of a Jazz Jackrabbit game.
  2. OpenJazz for Amiga.

openjazz.000 and OpenJazz must be in the same directory. 
You can place them in your Jazz JackrabbitTM directory, and OpenJazz will be
ready to run. You can also run it from another directory using your Jazz
JackrabbitTM directory as a command-line option. 

FAQ
---

I start the program, and a window appears and then immediately disappears?

The program produces a file called stdout.txt, which contains a list of the
files OpenJazz has tried to read. Do they exist? OpenJazz requires the
files from any of the following games: Jazz Jackrabbit, Jazz Jackrabbit CD,
Jazz Jackrabbit Shareware Edition, Jazz Jackrabbit Christmas Edition, or
Jazz Jackrabbit: Holiday Hare 1995. OpenJazz will not work with any of the
Jazz Jackrabbit 2 games. 

All of the files listed in stdout.txt exist, but the same thing happens?

OpenJazz is at an early stage of development and may not work on your
machine. Sorry. 

What are the controls?

Enter to choose a menu option, escape to go back to the previous menu. 
Left & right arrows to move left & right. Right Ctrl to change weapon. 
Under Windows, Alt Gr (Right Alt) to jump and space to shoot. 
Under Linux, Space to jump and Left Alt to shoot. 

The physics don't feel right?

They probably never will. There is no way of knowing how physics were
implemented in the original game, so the physics in OpenJazz are pure
guesswork.

_____ doesn't work?

OpenJazz is far from complete. Many features do not work, or work
incorrectly. At this stage, there is no point in even reporting it. 

I want to compile it myself. What do I need to know?

You will need to link to SDL. Under Amiga, you will also need to link
in SDLmain.

If you want music, things get complicated. You'll need to link to
libmodplug - unfortunately, this is only available for Linux. And even
that will have to be modified slightly - lines 376 and 409 in sndmix.cpp
should not be commented out. 
