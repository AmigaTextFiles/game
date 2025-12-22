Quick 'n Dirty Temptris Instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
By Jason Hildebrand
August 12, 1996


LICENSING:

There is NOOOOOOOOOOO licensing.  This game is free.
Have fun.

If you really like it, mention it to me, and I'll try to improve
it.  I'd like to add modem-link support, highscores, etc.
I didn't really want to release it this early, but I'll be gone in
Germany for the next year with no computer, so it's either now or
1997.

My email address is:   jdhildeb@napier.uwaterloo.ca

REQUIREMENTS:

WB2.0, dunno about other stuff.  Hopefully it works.
Email me if otherwise, and I'll do something about it when I can
(possibly in 1997, possibly sooner - who knows?)


INSTALLATION:

You'll need to uninstall the archive, and
then make sure that you have at least version 38
of reqtools.library in your libs: directory.

That should do it (don't you love the confidence that
I show in that statement?)


PLAYING THE GAME:

Start the game from the Workbench or the CLI.
Press space to skip the title screen if you want.
Choose a game mode:

	Solo - one player 
	Duet - two player co-operative mode
	Speed Duel - each time you get a double, triple, or Tetris, you
		     slow down and your opponent speeds up
	Line Duel  - each time you get a double, triple, or Tetris, you
		     give some lines to your opponent
	Double Duel - Speed Duel and Line Duel combined
	Tandem - two separate games (simultaneously)

You can map the keys for each player.
Choose "Player n Settings".  
You will see five icons on the screen: Left, Right, Rotate, Down, Drop.
As each icon is highlighted, press a key to use for that action.

After you have done this, use the Left/Right keys that you have just
defined to adjust the speed of your keys (i.e. how fast can you move
sideways and rotate).  Press the Down key (again, the one you just
defined) to exit back to the menu.

You can press ESC to abort the game.

SETTINGS:

When Temptris starts up, it looks for a file called "default.settings".
This file contains the key definitions, the key delays, the name of 
the current sound kit (see below) and the preferred game mode.

You can choose "Save Settings" to either overwrite the default settings,
or create another settings file.

Use load settings to load a settings file.


SOUND KITS:

A sound kit is a short text file listing game events and
corresponding filenames of IFF sound samples.
You can make your own.  Follow the example of the given kits
(starwars.kit and default.kit).
If you specify the same sound file for more than one event,
the game recognizes this and only loads it once.
You can omit some of the events if you don't want sounds
played for those events.

From within the game you can choose "Change sound kit" to change
to a different sound kit.  


Enjoy.

