To install Shaq-Fu to your HD you will require a 2MB chip ram machine.
Just doubleclick on the INSTALL_SHAQ icon or run INSTALL_SHAQ from
the CLI.

The installer will ask you where you wish to put the game, the installer
will create a drawer called 'ShaqFu' in this path and install the game
there. Do not use assigns or disk names in this path, you *MUST*
use the LOGICAL DEVICE NAME and it's full path, not assigns or volume names.

E.g. if your system has a HD partition DH0, with the name WorkBench: and
     an assign to the games drawer  Assign GAMES: DH0:Games

DH0:Games               is OK
WorkBench:Games         is NOT OK (WorkBench: is the volume name)
GAMES:                  is NOT OK (GAMES: is an assign)

Enter each disk as it is asked for, and the job's done. Have Phun!!!

NB. Although the game is HD installed, you will need to have a disk in DF0:
Any disk will do, it dosn't need to be a Shaq-Fu game disk. I couldn't be
arsed to take out the disk change & disk protection routines, even though
they serve no useful purpose any more. Don't worry, you won't keep getting
diskchange messages, it just accesses DF0: for a second every now and again.

Testing was positive on an A1200 2MB an A1200 2MB chip & 4MB fast, although
disabling the CPU cache was required on the fast ram machine. Negative 
results were experienced on a 68EC030 with 15 MB of fast ram, I am working
on this however.

CaTLorD/LSD Dec 1994 - Merry Christmas