
-------------------------------------------------------------
 
  *** AROS version *** 
  
  please, if joystick and/or sound doesn't work, mail me !
  contact@amigang.fr

--------------------------------------------------------------



1941 Extreme deluxe by HunoPPC version 1.0

Authors:
--------
concept / studio-grey/badblocks
Code and bonus : HunoPPC 

OS4 port by Hugues Nouvel HunoPPC.
http://www.clubevolution4.com/HunoPortSDL/

Aros port by Tito of Amigang
mel : contact@amigang.fr
www : www.amigang.fr

HunoPPC as ported and add Bonus to KETM (Kill Everything That Moves), this new version as a new name :1941 Extreme DELUXE AOS4 and the version pass at 0.98 Beta 2. 
This is a AMIGAOS4 adoption of the KETM engine by studio-grey/badblocks, fast paced tyrian style 2D shooter. 

Version 0.99 beta 1: 
The changelog of this version is:
* Added explosions when plane is hit
* Added explosions at ship
* Increased the transparency level during the invinsibility period
* New enemy (GROUNDER) and objects BGPANEL/BGPANEL2 added.
*objects BGPANEL/BGPANEL1/BGPANEL2/BGPANEL3/BGPANEL4/BGPANEL5/BGPANEL6/BGPANEL7/BGPANEL8/BGPANEL9 added with 2 new speed
* Added all sprites to "pre-loader" about that caused minor hickups during the initial run of the levels
* Slightly changed AI and attacking patterns of some enemies
* Changed the shield size for the plane to smaller and more realistic size...
* 36 enemies with unique attack patterns and adjusting hostility
* 6 secondary weapons (rockets, laser, bomb, rotating shield) 
* 8 levels (+1 end) with different environments real scrolling with bgpanel + new music & bosses
* 8 boss added 
* sound effect at boss added
* added Hyperspace; Alert Goodluck and alert Boss in the engine 
* added Sprites at score; lives and weapon
* added Enemy Space at the engine
* added new anims to the sprites
* added new weapon and bonus
* added Save your score and Fullscreen/window after escape 
* Fix save score.
* New menu for saving score with a plane sprite.
* Fix new warning
* fix loadlevel on amigaos4
* fix freesurface on the engine
* fix menu anim and select on the engine
* fix sound engine with .mod module
* Added 29 sounds effects weapons and voxel
* Written a new core audio with no limitation of sound 
* Added the ending/bonus level.
* High scores are saved now
* Added in-game messages fade-out
* Better difficulty settings (the game is made easier on "EASY" setting
* Removed some debugging stuff 
* added cache on loading for all image
* Fix crash collision on boss 7
* Fix Pause lock on change window/fullscreen
* Fix speed animation on menu
*add DEL and OK sprite on the menu savescore 
*Change key for validate  ENTER=>SPACE
* Add speed x1 add plane now

Version 1.0:
* Added all prefs on 1941Deluxe.cfg
  >New feature:
    -Sound: 0 disable (default) 1 enable
    -level: (choice your level) 1 Level 1 (default); 2 Level 2; 3 Level 3; 4 Level 4; 5 Level 5; 6 Level 6; 7 Level 7; 8 Level 8; 9 Level 9
    -Preload GFX (For machine with low RAM, disable this function): 0 disable 1 enable (default) 
    -Fullscreen: 0 disable (default) 1 enable 
    -Joystick: 0 disable 1 enable (default)
    -KeyUp: 0 UP (default); 1 A; 2 B; 3 C; 4 D; 5 E; 6 F; 7 G; 8 H; 9 I; 10 J; 11 K; 12 L; 13 M; 14 N; 15 O; 16 P; 17 Q; 18 R; 19 S; 20 T; 21 U; 22 V; 23 W; 24 X; 25 Y; 26 Z
    -KeyDown: 0 DOWN (default); 1 A; 2 B; 3 C; 4 D; 5 E; 6 F; 7 G; 8 H; 9 I; 10 J; 11 K; 12 L; 13 M; 14 N; 15 O; 16 P; 17 Q; 18 R; 19 S; 20 T; 21 U; 22 V; 23 W; 24 X; 25 Y; 26 Z
    -KeyLeft: 0 LEFT (default); 1 A; 2 B; 3 C; 4 D; 5 E; 6 F; 7 G; 8 H; 9 I; 10 J; 11 K; 12 L; 13 M; 14 N; 15 O; 16 P; 17 Q; 18 R; 19 S; 20 T; 21 U; 22 V; 23 W; 24 X; 25 Y; 26 Z 
    -KeyRight: 0 RIGHT (default); 1 A; 2 B; 3 C; 4 D; 5 E; 6 F; 7 G; 8 H; 9 I; 10 J; 11 K; 12 L; 13 M; 14 N; 15 O; 16 P; 17 Q; 18 R; 19 S; 20 T; 21 U; 22 V; 23 W; 24 X; 25 Y; 26 Z
    -KeyFire: 0 LCTRL (default); 1 LALT; 2 LSHIFT; 3 W; 4 X; 5 C; 6 V; 7 B; 8 N; 9 RALT; 10 RCTRL, 11 RSHIFT
    -KeyValidate: 0 RETURN (default); 1 SPACE; 2 A; 3 B; 4 C; 5 D; 6 E; 7 F; 8 G; 9 H; 10 I; 11 J; 12 K; 13 L; 14 M; 15 N; 16 O; 17 P; 18 Q; 19 R; 20 S; 21 T; 22 U; 23 V; 24 W; 25 X; 26 Y; 27 Z 
    -KeyEscape: 0 ESCAPE (default); 1 F1; 2 F2; 3 F3; 4 F4; 5 F5; 6 F6; 7 F7; 8 F8; 9 F9; 10 F10; 11 F11; 12 F12; 13 Q; 14 A 
* Fix problem SPACE keyboard 
* Added new Anim with my logo
* Added new intro 1941 on start game
* Fix intensive usage CPU
* Fix load all ressource
* Fix liberation ressources
* Fix problem with AZERTY keyboard (on native SDL default is QUERTY), no use SDL_UNICODE because it  use 5% of CPU for conversions and on Amiga 5% of CPU is very important, i have fixed this with a simple hack, testing key SDLK_q return SDLK_a ;o) etc... 
* Added remove Bonus SHIELD and Bonus SHIELDSPECIAL on loading final BOSS (is very difficult, now no tips for Dead BOSS with this bonus ;o)
* Added 15 new sounds effects
* Added 1up sprite for explode your plane and unload 1 life (for easy visual)
* Added looping after explode plane for good effect for game, delay added after looping for escape bullet of enemy (your plane is locked during looping).
* Added looping sound
* Added 3 explode anims for plane
* Added How to play on the menu with new anim for this function
* Fix loading anim on starting game (speed up now with anim) 

On the future:
* Sources released as SVN for all contribution and evolution of my work with other developper's


NOTES:
- Tested on AmigaOS 4.1 on AmigaOne G3 / G4 and SAM EP440 667 Mhz and SAM Flex 800 Mhz

Thanks:
My Wife "Claire" and children "Matthis and Sorhënn" to me allow time to develop 
Hyperion Entertainment  -  For the development of Amiga OS 4.0 and 4.1
ACube for my SAM EP440 and Flex
French Amigans
My all betatester's
and the AMIGA community

Bugreports for AmigaOS 4x at
NOUVEL (HunoPPC) Hugues
nouvel.hugues()orange.fr
http://clubevolution4.com/



