
Llamatron Update (Release #3) - by David Kinder
-----------------------------------------------

Introduction
------------

One of my favourite games on the Amiga is Jeff Minters shareware release
Llamatron, but it doesnt run under Kickstart 2.0 or higher. A bit of
experimentation showed that it was the loader programs (LLAMA and LLAMA512)
that were at fault. Thus I have written my own replacements.

Note that the main game files (TRON512 and TRON1MEG) are required but not
included. These are in the original Llamatron distribution.

Use on ECS Amigas
-----------------

Make a copy of your Llamatron disk, then replace the files LLAMA and
LLAMA512 with the copies in the ECS directory. These loaders also run from
Workbench, so you can start Llamatron from the included icons (taken from an
Amiga Computing coverdisk).

Llamatrons initial sound sample sometimes did not play properly on my A1200.
This has been fixed by issuing a CMD_RESET to the audio.device.

Use on AGA Amigas
-----------------

On my stock A1200, I found that occasionally these loaders would corrupt the
display. When I added a 68030 board, this corruption occured almost always.
The reason for this is not clear, but it can be fixed using KillAGA (by
Jolyon Ralph), so is probably related to the way Llamatron sets up its
display.

In the AGA directory are Llama, KillAGA and a script Llamatron, which calls
Llama via KillAGA. Copy all these files to wherever you keep Llamatron and
double click on the icon. A script is not included for the 512K machine as
all AGA Amigas have at least 2 Megabytes of memory.

The icons for KillAGA and Llama are not neccessary in this case; they are
included simply to help in copying.

Contact
-------

If you want to contact me about these loaders, send email to

	kinder@teaching.physics.ox.ac.uk
or	dkinder@physics.ox.ac.uk

History
-------

Release #2:

This release corrects a problem on Amigas with the VBR set to an address
other than 0x00000000. Thanks to Thomas Baetzler, who pointed this out
to me.

Release #3:

Removed an Enforcer hit. Updated distribution to separate ECS and AGA
machines.

Final Note
----------

Support shareware! If you didnt send money to Jeff for Llamatron because it
doesnt run on your new machine, youve no excuse now. If enough people
support shareware we might see more games of this quality released in this
way.
