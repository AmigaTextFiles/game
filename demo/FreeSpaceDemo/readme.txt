@database readme.txt
@wordwrap
@node main "readme.txt"
	
	==================================
	Descent: FreeSpace - The Great War
	   Readme for Demo version 1.00
	==================================

For more documentation on the FreeSpace demo, please see
the additional online documentation at:
   http://www.volition-inc.com/FSdemo.html

For information concerning the Amiga-Version, please have
a look at
   http://www.hyperion-entertainment.com/_amiga/freespace_game.html

   or

   http://www.haage-partner.de/freespace

For general Freespace for AmigaOS Feedback, please email to:
   SteffenH@hyperion-entertainment.com

Minimum System requirements are:

PowerPC 603e 160 MHz and Graphics Card (does not need to be a 3D Card,
though it looks better on a 3D Card, and runs faster)

or

68060 and Permedia 2 or Voodoo 3 based 3D Graphics Card

64 MB RAM (at least 48 MB RAM free)

or

32 MB RAM (at least 24.5 MB RAM free) and VMM installed (VMM only runs
with Freespace using the 68k Version, and the Audio Streaming has to
be disabled if used with VMM - both Music and Voices)

PowerPC users need to have WarpUP V4+ (powerpc.library V16.1 recommended)
installed. Users using 3D Hardware need to have Warp3D V4.x installed.
The latest WarpUP and Warp3D Binaries are included with the full version,
and also with our Demo CD.

-----------------
Table of Contents
-----------------
1. The FreeSpace Launcher
	1a. Play FreeSpace
	1b. Setup
	1c. View Readme
	1d. Hyperion Webpage
	1e. Quit

2. Playing FreeSpace
	2a. Pilot Registration
	2b. The Flight Deck
	2c. Barracks
	2d. Options
	2e. Ready Room
	2f. Gameplay Items

3. Gameplay Items
	3a. Demo Missions
	3b. Hornet Missiles
	3c. Comm Menu
	3d. Additional HUD info
	3e. Capital Ships

4. Demo Feedback

5. Troubleshooting

6. Contacting Tech Support

7. FreeSpace Web Links

8. Credits

9. Legal Stuff


-------------------------
1. The FreeSpace Launcher
-------------------------
The Launcher is used to control your hardware acceleration settings,
as well as viewing this Readme and contacting the FreeSpace web
page at Hyperion Entertainment.

1a. Play FreeSpace
  Press this to launch FreeSpace.

1b. Setup
  Under Setup, you'll see tabs for Video, Warp3D, Audio, Joystick, Speed
  and network (network settings will be ignored for the Demo version, as
  the Demo version does not include Networking Support). On quitting
  the Setup the options are saved into the File Freespace.prefs. Alternatively
  using the menu you can quit the setup without saving.

  Video - If you have a 3D accelerator, select Warp3D, else select Software.
  Ignore the Movie playback options. Only the full version of Freespace comes
  with ingame Movies. Ignore the subspace setting. This only is relevant for
  the full version of Freespace. Set the ChunkyPPC options as required.
  Double- and Triple-Buffering will make the Software Renderer play smoother,
  in case your WB Emulation supports it. WB Window Display will enable you
  to play Freespace (in Software Rendering) on the Workbench. With the
  PIP Option you can play (again only in Software Rendering) on a PIP Display,
  if your Graphics Card supports this. With "Use rtgmaster" you can use the
  rtgmaster.library (if installed) for the Screenmode Requester instead of
  the asl.library requester (only in Software Rendering). "Use AGA" can be
  used to play on AGA (note that Freespace requires a Graphics Card, as the
  AGA Display is probably too slow), clear all Screenmodes clears all screenmode
  requester settings again, and last but not least you can play Freespace
  in Software Rendering on a Pubscreen.

  Warp3D - CloseWorkBench defines if you want to close your workbench while
  playing. This can save some Video Memory. Use a Window can be used to play in
  a Workbench Window. Number of Buffers defines the
  number of Double/Triplebuffers to be used (3 is the normal case).
  Minimum Bitdepth is the minimum bitdepth to be used (16 is normal, for
  some Graphics Boards it is 15). Hide mouse pointer defines if you want
  to hide the Workbench mousepointer (recommended). CanBlendOneOne and
  NoBlendOneOne set the Blending options, best ignore these options.
  NoChromaTest should be enabled normally, same as to NoAlphaTexture (especially
  the Voodoo 3 needs this option). Restrict Texture Width/Height
  should be either set to none or 256 normally (256 can provide performance
  advantages, especially on Permedia 2 based hardware). Please note that
  the Virge Chipset is not supported by Freespace. Permedia 2 and Voodoo 3
  are both supported, though.

  Audio - Allows you to choose between "AHI" and "Paula" and the AHI Unit to be used. Paula
  will be a bit faster, but AHI will have a bit higher quality. Soundboards
  are supported through AHI. Audio Streaming can be disabled for slow
  Amigas, but if your Amiga is fast enough, enable it, then you get
  very impressive background music. Audio Streaming can be en/disabled
  seperately for Music and Voices. CD ROM Settings can be ignored for the demo.
  
  Joystick - Allows you to change/setup the joystick used by
  FreeSpace. You can choose between CD 32 Pad, PSX Port Playstation Controller
  Adaptor and PC Joystick (the same sort of adaptor like used by
  ADescent is supported, note that there are different adaptors, not
  all of them are supported). You can also calibrate a PC Joystick (if
  present) on this page. The tool CalibTool is found in the Archive.

  Speed - This setting determines what default Detail Level is
  used in FreeSpace when new pilots are created.  You may manually
  change this default if you wish, but it may adversely effect your
  gameplay speed. Note that "Low" Detail does not look pretty.

  Network - Ignored for the Demo version

  Memory - Here you can set the Caches. Low Caches will make the game
  require less memory - too low Caches might crash the game. If you have
  enough memory (at least 64 MB RAM), use 20 MB for the Graphics, 3 MB
  for the Sound, and 8 MB for the textures. More Cache does not make
  any difference. Scale Textures and Low Memory Option can save some
  more memory (scale textures also speeds up a bit), at the cost of
  image quality. Please note, that Scale textures is not yet running
  100% stable in the demo version, it will be fixed in the full version.

  Note that the 68k version of Freespace supports Virtual Memory using
  the program "VMM". Detailed installation instructions are included
  in the file VMM_readme.txt. If you use the 68k version with VMM you
  should still have at least 24.5 MB free memory, or the game will run
  too slow. Also you should disable the Audio Streaming or the game might
  not run at all.

1c. View Readme - Views this file.

1d. Hyperion Webpage - This will take you to our Webpage where you can
	read further information about Freespace and other projects. Please note
  that this requires that you have installed openurl.library.

1e. Quit - Exits the launcher without running FreeSpace.


--------------------
2. Playing FreeSpace
--------------------

2a.  Pilot Registration

  As you enter the game, you will be required to create a Pilot.  This
  Pilot will store your Demo combat statistics as well as your
  settings for Options, Controls Config, and HUD Config.  You may
  also change your active Pilot in the Barracks screen.

  Multiplayer and Multiplayer Pilots are not available in the demo.

2b. The Flight Deck
  This is essentially the FreeSpace Main Menu.  Press F1 to receive
  a help overlay outlining the different areas.

  In the demo, you may use your mouse to proceed to the Ready Room,
  Barracks, Options Screen, or Exit.  The Tech and Campaign Rooms are
  not available in the demo.

2c. Barracks
  This room allows you to change your currently selected Pilot, and
  to view their combat statistics.  You are also able to change the
  pilot image used by each pilot.

  Viewing Service Medals is not available in the demo.

2d. Options
  This screen allows you to change various global settings used in
  FreeSpace.  Use it to adjust your Sound, Music, and Voice volume
  levels, as well as adjust your Gamma setting.

  NOTE on GAMMA: You cannot change the Gamma setting on the Amiga Version.

  Multi - Multiplayer options are not available in the demo

  Detail - This screen allows you to adjust the various detail
  level settings for FreeSpace.  It is recommended that you use the
  default Preset Level chosen for you at install time.  If you wish
  to change the current setting, use the Preset buttons on the right
  side of the screen.  The Custom button will allow you to modify
  individual settings.

  Controls Config - Here you may configure your controls and key
  bindings to better suit your preferences.  A list of functions
  appears on the left, and their corresponding key/button bindings
  appear on the right.  At the top you'll see four categories
  of game functions.

  To change a binding, simply double-click on the appropriate line,
  and press the new key/button.  If two functions reference the same
  key/button, it will create a conflict.  Pressing Clear Conflict
  will remove the original binding in favor of the new one.

  You're required to resolve all conflicts before leaving the
  Controls Config screen.

  HUD Config - FreeSpace has a highly configurable HUD (Heads-Up
  Display).  This screen allows you to turn individual parts of the
  HUD on and off.  Certain gauges may be set to "popup" mode as well.
  This will cause the gauge to display briefly when its status
  changes, but will otherwise not be shown.

  For a full explanation of each gauge, please visit the Online
  Demo Documentation at http://www.volition-inc.com/FSdemo.html

2e. Ready Room
  This door will take you straight to Briefing, and then into the
  missions.  Ship Selection and Weapons Loadout are not available
  in the demo.

  Briefing - This screen gives you an overview of the upcoming
  mission, and delivers your orders.  Each Briefing is arranged
  in stages, which can be navigated using the arrow buttons on
  the bottom of the map display.

  The text for each stage appears at the bottom, and will also
  be read to you by your commanding officer.

  If this is your first time playing FreeSpace, you will begin
  in a training mission.  It is STRONGLY recommended that you
  complete the training mission before proceeding to the combat
  missions.  Training will familiarize you with different parts
  of the HUD display, and the basics of flight and combat.

  NOTE:  Several more training missions are included in the full
  release of FreeSpace.  They provide an easy-to-use way of learning
  basic controls as well as more advanced techniques.

  The last stage in the Briefing will show you your Objectives.
  Primary Objectives are very important to the mission's success.
  If you fail one or more Primary Objectives, you may be forced to
  replay the mission before continuing.  Secondary Objectives are
  less important, but it is always wise to complete them.

  Press Commit to accept your orders and begin the first Training
  mission.  Your instructor will take you through the basics and
  you will then be able to fly your first two combat missions.



-----------------
3. Gameplay Items
-----------------

3a. Demo Missions
  There are four missions included in this Demo.  Mission one is
  training, and will familiarize you with the basic combat
  controls.  Mission two is an escort mission where you protect
  a damaged cruiser.  Depending on how well you protect that
  cruiser, you will then proceed to one of two additional
  missions.  The main difference being that if you performed
  well, you will be granted use of the Hornet swarm missiles for
  the following mission.

3b. Hornet Missiles
  If you've received permission to use the Hornets, you will
  notice that their target locking behavior is different from
  the MX-50's.  Unlike the heat-seeking MX-50's, the Hornets
  require an "aspect" lock.  To gain aspect lock, arm your
  Hornets and try to keep your target centered in your reticle.
  The Aspect Diamond indicator will chase it around the screen,
  attempting to gain aspect lock.  The more your target jinks
  around, the longer lock will take.  Once you gain lock,
  fire away!

3c. Comm Menu
  Comm Menu - You should familiarize yourself with the Comm
  Menu in the game (default key 'C').  With this menu you can order
  wingmen to attack or protect a target, cover you from enemy fire,
  or leave the battle area.  You may also use the Comm Menu to
  request Rearming/Repairing from a Support ship.

3d. Additional HUD info
  For additional information on the HUD system displayed in the
  FreeSpace demo, please visit the following site:
    http://www.volition-inc.com/FSdemo.html

3e. Capital ships
  There are no capital ships in the Demo version of FreeSpace.
  The GTC Orff is a cruiser/frigate level ship,
  measuring about 250 meters in length.  The full release version
  of FreeSpace contains capital-level ships like the Orion and
  the Typhon, measuring 10 times bigger than the Orff!


----------------
4. Demo Feedback
----------------
One reason to do a game demo is to get player feedback from
all over the Earth.  Tell us what you think of the game!
Simply contact us at one of the email addresses below:

General feedback, comments & bug reports:
  SteffenH@hyperion-entertainment.com

Technical questions/problems
  SteffenH@hyperion-entertainment.com
  (Also see section 3 below)

Non-technical questions:
  SteffenH@hyperion-entertainment.com

------------------
5. Troubleshooting
------------------
If you do not find the answers to your problems in this section,
please refer to section 6 on contacting Hyperion Entertainment Customer Service.

Common Questions & Answers

Q: I do not get sound. I have a PPC.

A: Install the powerpc.library V16.1, which is available either in the WarpUP V5.1
   Archive (included on the full version CD) or in the OS 3.9 Boingbag (can also
   be used if you do not have OS 3.9). Then you get sound.

Q: I have a 68k. The menu screen is quite slow.

A: Well, the 68k CPU has it's limits. At least the game is fast
   in-game on a 060 :)

Q:	The game crashes after the Hyperion-Intro (I am using Picasso 96). This
 	of course only applies for the full game, for the demo there is no intro.

A:	Until recently the rtg.library had a bug which caused this effect.
	Get the latest version of Picasso96 and everything will be fine,
	the rtg.library bug is fixed in the latest version.

Q:	I cannot configure (in-game) my mouse/joystick properly.

A:	The full version of the game adds more options for the mouse/joystick.
		This will include sensitivity settings.

Q:	I am using the Warp3D Renderer, but the engine fire and explosions
    do look strange, with black boxes around them.

A:	Freespace requires Warp3D V4.2. Older versions have this effect. Install
		Warp3D V4.2 which you can download at http://www.hyperion-entertainment.com.
    The full version will include the latest Warp3D on the CD.

Q:	I set up the Joystick in the GUI, but still I cannot control the game
    using my Joystick.

A:	You should also configure the joystick functions in the control options
		of Freespace.

Q:	Freespace crashes, if I start it from shell.

A:	Freespace requires a lot of stack. Either start it from the GUI, or use
		400000 Stack.

Q:  Does Freespace run on an Emulator like Amithlon or AmigaXL ?

A:	We do not have such a system ourselves, so we can provide no support for
    Freespace being emulated on x86. However some of our Beta-testers tried
    the game on both Emulations and confirmed that it runs on them.

-------------------------------
6. Contacting Technical Support
-------------------------------

Hyperion Entertainment Customer Service for Freespace

E-Mail: SteffenH@hyperion-entertainment.com

World Wide Web: http://www.hyperion-entertainment.com

Write to:

        Haage&Partner Computer GmbH
        Schlossborner Weg 7
        61479 Glasshuetten
        Germany

----------------------
7. FreeSpace Web Links
----------------------

If you're interested in FreeSpace-related web
sites and information, here are some great places
to start.

Volition, Inc. homepage
  http://www.volition-inc.com

Parallax Online
  http://www.parallaxonline.com

Interplay Productions
  http://www.interplay.com

Hyperion Entertainment Homepage
	http://www.hyperion-entertainment.com

FreeSpace Command
  http://freespace.questgate.net

Terran Tactical Database
  http://freespace.logicquest.com

Descent Network FreeSpace page
  http://www.descent-freespace.com

Strobe
  http://www.sentry-tech.com/arsentia/strobe

Descent: FreeSpace - Central Intelligence
  http://home.ica.net/~wave/descent

Descent: FreeSpace webring homepage
  http://www.geocities.com/~genshepd/freespace/webring

FreeSpace HQ
  http://www.free-space.com


----------
8. Credits
----------
FreeSpace Demo developed by Volition, Inc.
for Interplay Productions
Amiga Port by Hyperion Entertainment
Published by Haage&Partner Computer GmbH

Volition, Inc.
--------------
Original Design
   Adam Pletcher & team

Programming
   John Slagel
   Mark Allender
   Mike Kulas
   Alan Lawrance
   Jason Hoffoss
   Dave Baranec
   Dave Andsager
   Sandeep Shekar

Art
   Adam Pletcher
   Jasen Whiteside
   Frank Capezzutto III
   Peter Han
   Mike Comet
   Mitri Vanichtheeranont

Mission Design
   Sandeep Shekar
   Duncan McPherson
   Brad Johnson
   Jim Boone

Audio
   Dan Wentz


Interplay
---------
Executive Producer
   Trish Wright

Producer
   Jim Boone

Director of Quality Assurance
   Chad Allison
     
QA Managers
   Colin Totman
   Steve Victory

IS Manager
   Frank Pimentel

QA IS Technicians
   Bill Delk
   Chris Peak
     
QA Project Supervisor
   Jeremy Ray
     
Testers
   Chad Nicholas
   Chris English
   Ian Wall
   Austin Coulson
   Rafael Lopez
   Dennis Presnell
   Rodney Smith
   Edward Hyland

Director of Compatibility
   Phuong Nguyen
   
Compatibility Technicians
   Louie Iturzaeta
   Derek Gibbs
   John Parker
   Marc Duran

Special Thanks
   Kyle Shubel

Amiga Port
----------

Programming
	 Steffen Haeuser
   Jarmo Laakkonen
   Mathias Roslund

Additional Programming
   Hans-Joerg Frieden (3D Hardware Renderer)
   Martin McKenzie (GUI)

Testers
   Alkis Tsapanidis
   Fabio Trotta
   Christian Michael
   Timothy De Groote
   Ben Yoris
   Martin Steigerwald
   Alexander Bramm
   Siegfried Podesser
   Steffen Beil
   Martin McKenzie
   Kai Mache	

--------------
9. Legal Stuff
--------------

SOFTWARE USE LIMITATIONS AND LIMITED LICENSE

This special 4-mission preview version of 
Descent: FreeSpace - The Great War (the Software) is 
intended solely for your personal noncommercial home 
entertainment use. You may not decompile, reverse 
engineer, or disassemble the Software, except as 
permitted by law. Interplay Productions and
Volition, Inc. retain all rights and title in the 
Software including all intellectual property rights 
embodied therein and derivatives thereof. You are 
granted a revocable, nonassignable limited license 
to create derivative works of this Software solely 
for your own personal noncommercial home 
entertainment use and may publicly display such 
derivative works to the extent specifically 
authorized by Interplay in writing. A copy of this 
authorization, if any, will be provided on 
Interplay's World Wide Web site, located at 
http://www.interplay.com, or by contacting the legal
department Interplay Productions in the US at 
(949) 553-6655. The Software, including, without 
limitation, all code, data structures, characters, 
images, sounds, text, screens, game play, derivative
works and all other elements of the Software may not
be copied (except as provided below), resold, 
rented, leased, distributed (electronically or 
otherwise), used on pay-per-play, coin-op or other 
for-charge basis, or for any commercial purpose. 
You may make copies of the Software for your 
personal noncommercial home entertainment use and 
to give to friends and acquaintances on a no cost 
noncommercial basis. This limited right to copy 
the Software expressly excludes any copying or 
distribution of the Software on a commercial 
basis, including, without limitation, bundling the
product with any other product or service and any 
give away of the Software in connection with 
another product or service. Any permissions granted 
herein are provided on a temporary basis and can 
be withdrawn by Interplay Productions at any time.
All rights not expressly granted are reserved. 

Acceptance of License Terms. By downloading or 
acquiring and then retaining this Software, you 
assent to the terms and restrictions of this limited 
license. If you acquired the Software and do not 
accept the terms of this limited license, you must 
return the Software together with all packaging, 
manuals and other material contained therein to 
the store where you acquired the Software for a full 
refund and if you downloaded the Software, you must 
delete it.



Copyright Information
---------------------

Descent: FreeSpace - The Great War Demo
(and release version) (c) 1998 by Volition, Inc.
All rights reserved.   Portions (c) 1998 Interplay
Productions.  All rights reserved.
Descent, Descent: FreeSpace - The Great War, Interplay,
the Interplay Logo, and "By Gamers. For Gamers." are
trademarks of Interplay Productions. Windows(r) 95 is a
registered trademark of Microsoft Corporation. All
rights reserved.  Exclusively licensed and distributed 
by Interplay Productions.  All other trademarks are 
the property of their respective owners.


----

@endnode
