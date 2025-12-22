QUAKE PLAYER 0.96    -   7.5Mb of free FAST memory and FPU required!
-----------------

- Fixed Bug looping tracks in cd.device.
- Fixed palette corruption if F1 or other binding is used on About Screen.
- Fixed GFX corruption in both sides of the scoreboard in window/translation mode, when window width>320 pixels.
- Fixed cd.device cleanup routine.
- Real AGA Double/Triple buffering routines added.
- Experminental P96 and CGFX Double Buffering routines added for testing purposes.
- Generic RTG copy routine added (OS 3.1 needed).
- Fixed the number of rendered pages after de-selection of double buffered modes, causing slowdown on non double buffered routines.
- Added new parameter '-french' enabling an AZERTY keyboard.
- * key acts as Pause like on PC


WHAT IS IT
----------
This is a non-playable demo of Quake Amiga. It is much more than a slideshow, so it's called 
the Quake Player. It allows you to view Quake demos, both the ones found in the game, as well 
as a vast number of demos from Internet.

QUAKE PLAYER ACTUALLY RENDERS THE WHOLE GAMEPLAY IN REAL TIME AS IF YOU WERE PLAYING THE GAME !!!
Thus, the speed you see here is the actual speed you will be getting in the game.

Note1: Game speed over Internet will depend on the quality of your connection!
Note2: Gameplay will seem slightly smoother when watching demos than when actually 
       controlling the game because there is no eye-hand interaction involved.
Note3: On CPU less than 060 you should reduce the screen size to ~50% (options menu)


OPTIONS
-------

All the options from the game are available in Quake Player. Press ESC, and use regular 
PC-like options, or Amiga-style menus. First time you press ESC it will take some time 
to load and display the menu. Next time it it loads it from buffer and displays faster.

Feel free to set resolution, sound and other options.
Obviously, starting the game, choosing maps, etc. will not give any results.


RUNNING DEFAULT QUAKE DEMOS
---------------------------

To play 3 default Quake demos in a loop, from CLI type: 

       QUAKEPLAYER -NOCDAUDIO -NOLAN

Alternatively, try QUAKEPLAYER -NOCDAUDIO -NOSOUND -NOLAN
(consult text files in this dir for more info)

IF YOU HAVE ONLY 8Mb OF FAST RAM:
1. Remove everything from WBStartup to have at least 7.5Mb free
2. Run player from CLI with    QUAKEPLAYER -MINMEMORY


CONSOLE
-------

To invoke a console, press ~ key (upper left corner of the keyboard).
Console.html file included in this directory is taken from the Net, and gives a 
detailed explanation of all the Quake console commands. Experiment!


RUNNING OTHER DEMOS
-------------------

To run any other Quake demos, simply copy them to your ID1 directory.
It should have .dem extension, so if you downloaded camper.dem you can play it from 
Quake console by typing    PLAYDEMO CAMPER
(see below for explanation of console)


RUNNING DEMOS FROM QUAKE CONVERSIONS
------------------------------------

If you want to install a Quake conversion and would like to see its demo(s):

1. Create a directory inside Quake direcory, and name it whatever you like (ie. test)
2. Unpack the conversion to that directory
3. Run quake player by typing:  QUAKEPLAYER -GAME TEST


LIMITATION
----------

- Quake player can only play demos from the first Quake episode.
  (Therefore, qdq100 or similar will not work)
- Quake player will only play demos if it can find .pak file for them.


CONTACT
-------

Technical questions:    support@pxlcomputers.com
General clickBOOM info: info@clickboom.com  or  clickboom.com  web site

QUAKE IS (C) 1996,1997 ID SOFTWARE, INC. ALL RIGHTS RESERVED.
AMIGA CONVERSION (C) 1998 PXL COMPUTERS, INC. AND CLICKBOOM.