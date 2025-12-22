Duke Nukem 3D for AmigaOS 3 with WarpOS by Wrangler
---------------------------------------------------

This is a port of the open source Chocolate Duke to WarpOS enabled Amigas.

Installation is very easy: all you need is a .GRP file from the shareware or
full versions of the game (any version should work) and the binary from this
archive in the same directory.  Then run the binary.

If you are using a Blizzard PPC or Cyberstorm PPC, set a bigger stack before
you start the game eg "stack 500000".  Hedeon's version of WarpOS automatically 
resizes the stack for you.

Tested on:
BPPC with Mediator and Radeon 9200
CPPC with CVPPC
Ragnarok with Mediator and Voodoo 3 - very playable at 1024x768

Users have reported this working well on Sonnet 7200 and Killer M1

Notes:
* Set the environment variable NOIXPATHS to 0 to ensure it works properly
* Music works via Timidity
* Multiplayer not tested
* Big thanks to Hedeon for sorting out mouse grabbing and helping to get
support for big endian screen modes working (eg CVPPC).
* And thanks to Dante for the 060 port source which gave helpful hints on 
sorting out many, many endian issues.

Wrangler February 2019