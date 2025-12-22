Crystal Space (V0.05)
---------------------

* WARNING! Many filenames have changed (since V0.02) in this
* distribution! It is best to delete everything (or move it
* to another location) and start all over. The filename
* changes are needed for DOS support.

* NOTE! djgpp.c has been renamed to djgpp.cpp since V0.05.


This is yet another release of Crystal Space. Crystal Space is a
6DOF 3D engine (like Quake) with static colored lighting and
other features. See 'document.txt' for a complete list of
features and some explanation about the algorithms that were
used.

Crystal Space is still very much under development. I would
like to make an Internet project of Crystal Space. Everyone who
feels inclined can contribute to the source. There are several
things that still need to be done. See the 'todo.txt' file
for more information about what is missing and a list of current
known bugs.

Crystal Space is free and should remain free. I may put
Crystal Space under the GNU license. In the mean time consider
everything as copyrighted by me (Jorrit Tyberghein).

[LAWYER MODE ON]

DISCLAIMER! I'm not responsible in any way for any damage
this program may incur on you, your family or your computer.
I think nothing harmful will happen but if it does, the
author (Jorrit Tyberghein) is not responsible!

[LAWYER MODE OFF]

Note that some of the included textures are probably not free.
I'm not sure. I will remove them when someone can confirm that
they are not free. This also means that I'm looking for textures
that ARE free and can be safely included with this program.
All textures beginning with 'my' are mine so those are free.


Credits
-------

Crystal Space has it's first contributor! Many thanks to Murat
Demircioglu <demircio@boun.edu.tr> for providing the first steps
to porting Crystal Space to DOS. His code is present in this
archive.

David N. Arnold <derek_arnold@fuse.net> has enhanced the DOS
port made by Murat. He added C++ classes and VESA support.

Nathaniel Saint Martin <nsaintmartin@mfoptima.fr> enhanced Arnold's
DOS port again so that it works with the Watcom C++ compiler.

Steve Israelson <pfhorte@rogers.wave.ca> suggested a few
enhancements to the inner draw_scanline functions to benifit
processors with many registers (like the PowerPC and 680x0 and
unlike the Pentium). He also removed the need for the loop
counter ('i') in the inner loop.

Installation instructions...
----------------------------

To create Crystal Space from the source you can use one
of the provided makefiles:

	makefile.djg	for the DJGPP/DOS port.
	makefile.lnx	for Linux and X Windows.
	makefile.sol	for Solaris and X Windows.
	makefile.unx	for general Unix and X Windows.

Other platforms will be supported in future.

Edit the makefile and possibly make changes as explained
in the makefile. Then type:

	make -f makefile.???

This should generate a correct executable ('cryst' or
'cryst.exe').


Starting Crystal Space...
-------------------------

Note that if you are running on a X Windows platform you must
remove the line 'XSHM=yes' (or change it to 'no') in 'cryst.cfg'
if your server does not support the Shared Memory Extension.
You can try first with XSHM set to 'yes' (since that is faster)
and change it if it doesn't work (you will get a message like:
'Xlib:  extension "MIT-SHM" missing on display').

When you start Crystal Space for the first time it will generate
a large light.tables file. If that file already exists it will
reuse that. Note that you need to remove this file if you change
something that might alter that table. Some examples of this
are:
	- Adding or removing a texture from the 'world' file
	  (even if it is not used).
	- Changing the definition of the three colors for the
	  color table in the 'cryst.cfg' file.
	- Changing the colormap of one or more of the textures.
If you don't remove 'light.tables' in those cases the colors will
almost certainly be wrong.

Mipmapped textures and static lighting are currently always
computed at startup.

When you start Crystal Space it will automatically load the
file 'world' (commandline arguments would be nice).


Jorrit Tyberghein,

Jorrit.Tyberghein@uz.kuleuven.ac.be


