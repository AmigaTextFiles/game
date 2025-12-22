
											 CROSSFIRE II  Demo V1.03
											by Dreamworlds Development
									 (c) 2003 Andreas Magerl, ATC&TCP


Welcome to CrossfireII Demo. Please start the Prefs program first, change the options
to whatever suits your taste and save the config. The game won't start otherwise.
Pay attention to choose the Graphics system "ChunkyPPC fullscreen". Although it's
called PPC it works on 68k processors, too, and it's much faster than the AmigaOS
functions.

Once in the game you can directly start creating a pilot and playing the campaign mode.
The standard control is the joystick in gameport but you can change it to anything you
want in the "Options -> Player Options" menu. Switching weapons is performed by
tipping back shortly or by a seperate key.

Controls:

Type           Forward   Backward   Turn Left   Turn Right   Fire       Switch Weapons

Keyboard 1     RShift    RAlt       NP 1        NP 5         '-'        NP 6
Keyboard 2     Ctrl      LShift     LAlt        LAmiga       Tab        Space
Keyboard 3     Cursor Up CDown      CLeft       CRight       LAlt       LShift
Joystick 1-4   Up        Down       Left        Right        Fire       N.A.
Joypad 1-2     Up        Down       Left        Right        Red Button Yellow Button


There is also a control type called "Custom Control". Use this to adapt any
control (keyboard, joysticks, joypads) to your needs. When choosing "Custom Control"
the line "Redefine Controls" becomes selectable. Selecting it brings another menu
to sight. Choose your preferred type of controller and define keys or buttons for
every possible action.

The line "switch weapons with ..." lets you choose wether you want to switch weapons
by tipping back, by a seperate key or by both.

There are many more options but they're mostly self explanatory. Try it out, it doesn't
hurt :-))



Although this program was tested carefully there still might arise some problems
that actually aren't our fault. We attached a list of frequently asked questions
where (hopefully) most of the questions are already answered. Please read there
first whether your problem is already known. If you still have problems with
any aspect of the game, please contact me at thomas@dreamworlds.de. We'll
publish further problems and their solutions at our website www.dreamworlds.de
or at the ATC&TCP support forum "www.amigafuture.de/forum/viewforum.php?f=10".

Thomas Schulze, Dreamworlds Development




**** Frequently Asked Questions:

Graphical problems:

Q: I'm running the game on MorphOS and I do just hear the music but see no
	 picture. What's wrong with it?

A: ChunkyPPC has some problems when running on MorphOS. Please run the Prefs Program
	 and choose "Graphics system: AmigaOS" there. This avoids using ChunkyPPC but uses
	 Cybergraphics calls instead.


Q: I see strange gfx errors when playing the game in HiColor. I have a normal
	 Amiga.

A: In this case you might try "Graphics system: AmigaOS", too. But be warned: The
	 Cybergraphics functions that are used instead of ChunkyPPC are SLOW! On a Pegasos
	 or AmigaOne this doesn't matter but normal Amigas are already at their limits when
	 playing Crossfire II. So don't use the compatible graphics system unless you really
	 have to.


Q: Instead of a 320x240 screenmode it asks me for an 640x480 mode. But the game doesn't
	 look any better now. What the heck do you think higher resolutions are thought for?

A: This mainly happens on Amithlon systems. Amithlon doesn't offer a 320x240 screenmode
	 (at least my test system didn't have one) so we implemented a special gfx function
	 which zooms the whole screen to a bigger resolution.


Q: But why don't you simply support bigger resolutions then? It would look way better
	 if you'd do so.

A: A simple test: Press "Cancel" if it asks you for an 320x240 resolution. Another
	 requester will pop up asking for an 640x480 mode. Choose one and you'll see how
	 your Amiga could cope with such an resolution. At least my A4000/PPC couldn't cope
	 with it. And this way the graphics are just zoomed to fit the screen! It would cost
	 way more processor power if the whole frame with all its transparency and blending
	 effects had to be rendered in this resolution.

	 To summarize it: No way. Not on existing Amiga hardware.



Problems concerning the Prefs program:

Q: I can't start the Prefs program, it says something about "muimaster.library".
	 What's that?

A: MUI is an alternative Graphical User Interface (GUI) and the Prefs program
	 is based on it. This message says you dont have installed MUI. You can find
	 a demo version of MUI in the "External" directory which is enough to use
	 the Prefs program.


Q: I get a requester telling me "Cannot open window ...". What does it wan't to
	 tell me by this?

A: The size needed for the Prefs window is bigger than what your present screenmode
	 offers. There's simply no space on screen.

	 Solution:  a) Switch to a larger resolution.
							b) Click on the Prefs icon, choose "Icon -> Information" from the
								 Workbench menu and edit the line "(SHOWLOGO=on|off|auto)" to
								 "SHOWLOGO=off" (without parenthesis!) there.
								 This suppresses the CrossfireII-logo and such the window fits
								 even at 640x480 screens.



Speed issues:

Q: The Animations seem to be slower as planned and the sound breaks every few
	 seconds. That's not as planned, is it?

A: No, it isnt. This might be because your CD-ROM isn't fast enough. Solution:
	 Do a full install.


Q: I've done a full install but it doesn't change!

A: There might be several reasons:
		* Your hard disc is fragmented too much. Solution: Defrag it.
		 The only program I knew to do this was ReOrg but there might be others.

		* Your hard disc bandwith is too low. It should at least manage to reach
		 1MB per second, the more the better. I've seen IDE HDs wrong configured that
		 made 0.3 MB/s at top. No chance this way.


Q: How do I configure it right?

A: Don't ask me. I'm not an expert in this issue.


Q: Not just the animations but everything in the game looks slow. I can even see the
	 screen updating line per line from the top to the bottom! Is this due to my ZorroII
	 gfx board?

A: Well guessed. ZorroII has a max bandwith of 1MB/s. You can simply calculate that
	 this restricts everything down to 15fps. And in this case the game hasn't moved a
	 single ship yet!

	 Solution: Play it on an AGA screen. Run the Prefs Programm, click on "Flush Screenmodes"
	 and the game will ask you for a new resolution next time you run it. Choose a PAL or NTSC
	 resolution then.


Q: I run the game in HiColor at my 68k Processor and in constrast to what you told
	 everywhere it's well playable! But it CRAWLS everytime something fades in or out!
	 What does happen there?

A: At 8Bit screenmodes you can achieve color changes like fading or the screen flash of
	 bigger explosions simply by manipulating some color registers. HiColor modes aren't
	 like that, there you don't have a palette. If you want the screen to be darker, for
	 example, you have to reacalculate every single pixel on screen. This needs much
	 processor power, even an 060 can't cope with this job.

	 Solution: Switch off "Screen Fading" and "Screen Flash" in the Misc. Options menu.



Input problems:

Q: There seems to be a joystick button switched to autofire or similar but this happens
	 even if no controller is connected at the joy port at all. Do you guys have mixed up
	 something?

A: Nope. That's a bug inside the lowlevel.library. On faster processors it has problems
	 determining what type of controller is connected to the port. To the game this looks
	 like a button is pressed continuous. We've put a small tool in the "External"
	 directory called "SetJoyPort" which overrides this detection. Use it if you have
	 problems using your joystick / gamepad / whatsoever.

	 The usage of this tool is explained in the readme inside the archive.
