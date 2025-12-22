1941 Extreme Deluxe MorphOS by HunoPPC version 1.1.1 Final Release

Authors:
--------
Original Engine by Concept, Studio-grey/badblocks
MorphOS Code and bonus by HunoPPC
Additional MorphOS/Efika options by HunoPPC and _DaNi_
 
OS4 and MorphOS ports by Hugues Nouvel HunoPPC.
http://www.clubevolution4.com/HunoPortSDL/

HunoPPC ported and improved the KETM (Kill Everything That Moves) engine from OS4
version to MorphOS and this new release has a new name: 1941 Extreme DELUXE MorphOS 
and the version jumped to 1.1.1 Final release now!
This is the MorphOS adaption of the KETM engine by studio-grey/badblocks, fast
paced tyrian style 2D shooter. 


SYSTEM REQUERIMENTS:
--------------------
MorphOS 1.4.x or 2.x
MorphOS Compatible Machine
PowerSDL 14.x or above
128Mb RAM for Low Graphics Mode
160MB RAM for High Graphics Mode
Joypad 


NOTES:
------
Efika 5k2 machines need to be enable "Lowram", disable "Preload GFX"
and disable "Arcade Borders" for speed up on Efika 5K2
G3/G4 CPU´s with 256Mb work under "High Backdrops" by default
You can edit "Config file" with any editor located at default dir


Final Version 1.1.1 
-------------------
Remove option Efika, now is LOWRAM (is for all low ram machine)
Added new logo for loading LOWRAM config
Fix highscore on option: SAVE YOUR SCORE, now is correct and didn't write a old superior score
Fix a justification of NAME on the score
Button for looping as now "B" by default
Added looping Bomb on HOW TO PLAY animation
Fix level 5 (sprites)
Fix level 7 (backgrouds)
Change on menu difficulty EASY/MEDIUM/HARD to EASY/NORMAL/HARD
Added sound effects to: Loading; logo LOWRAM; NoMoreLooping
Fix information of selector Bonus Looping
Fix bpanel3 and bpanel4
Fix background final level (level9)
Updated prefs on 1941Deluxe.cfg
New feature:
-Sound: 0 disable (default) 1 enable
-level: (choice your level) 1 Level 1 (default); 2 Level 2; 3 Level 3; 4 Level 4; 5 Level 5; 6 Level 6; 7 Level 7; 8 Level 8; 9 Level 9
-Preload GFX (Preloading a data GFX on Ram, disable this option slowed gameplay) : 0 disable 1 enable (default)
-LowRam (For machine with low RAM), enable this function: 0 disable (default) 1 enable
-Fullscreen: 0 disable (default) 1 enable
-Joystick: 0 disable 1 enable (default)
-KeyUp: 0 UP (default); 1 A; 2 B; 3 C; 4 D; 5 E; 6 F; 7 G; 8 H; 9 I; 10 J; 11 K; 12 L; 13 M; 14 N; 15 O; 16 P; 17 Q; 18 R; 19 S; 20 T; 
 21 U; 22 V; 23 W; 24 X; 25 Y; 26 Z
-KeyDown: 0 DOWN (default); 1 A; 2 B; 3 C; 4 D; 5 E; 6 F; 7 G; 8 H; 9 I; 10 J; 11 K; 12 L; 13 M; 14 N; 15 O; 16 P; 17 Q; 18 R; 19 S; 
 20 T; 21 U; 22 V; 23 W; 24 X; 25 Y; 26 Z
-KeyLeft: 0 LEFT (default); 1 A; 2 B; 3 C; 4 D; 5 E; 6 F; 7 G; 8 H; 9 I; 10 J; 11 K; 12 L; 13 M; 14 N; 15 O; 16 P; 17 Q; 18 R; 19 S; 
 20 T; 21 U; 22 V; 23 W; 24 X; 25 Y; 26 Z
-KeyRight: 0 RIGHT (default); 1 A; 2 B; 3 C; 4 D; 5 E; 6 F; 7 G; 8 H; 9 I; 10 J; 11 K; 12 L; 13 M; 14 N; 15 O; 16 P; 17 Q; 18 R; 19 S; 
 20 T; 21 U; 22 V; 23 W; 24 X; 25 Y; 26 Z
-KeyFire: 0 LCTRL (default); 1 LALT; 2 LSHIFT; 3 W; 4 X; 5 C; 6 V; 7 B; 8 N; 9 RALT; 10 RCTRL, 11 RSHIFT
-KeyLooping: 0 B (default); 1 SPACE; 2 A; 3 RETURN; 4 C; 5 D; 6 E; 7 F; 8 G; 9 H; 10 I; 11 J; 12 K; 13 L; 14 M; 15 N; 16 O; 17 P; 18 Q; 
 19 R; 20 S; 21 T; 22 U; 23 V; 24 W; 25 X; 26 Y; 27 Z
-KeyEscape: 0 ESCAPE (default); 1 F1; 2 F2; 3 F3; 4 F4; 5 F5; 6 F6; 7 F7; 8 F8; 9 F9; 10 F10; 11 F11; 12 F12; 13 Q; 14 A; 15 P
Added backgrounds High and low for option LowRam (0 is for High backgounds and 1 is for Low Backgounds) 
big thanks at Sergio Campillo aka "_DaNi_" for support at this option
Added levelsHigh and levelsLow (Backgrouds High WIDTH 640, Backgounds Low WIDTH 480)
Added new dual border for LowRam option and now Backgrounds are on 480
Button B as Key temporisation for NoMoreLooping alert
Now weapon is not decrease (reduce) with action looping
Added button B for looping Bomb on all animation How To Play
Fix alpha on sprites
Fix boat on level 5 (low and high)
Fix white line on final animation
Score as now fixed on quit game ("..." is for no letter), rewriting a code.
Fix for intensive CPU usage with the new Border for the LowRam option
Fix timer for the NoMoreLooping alert
Fix center bonus Bomb and bomb2
Add loopsBomb and loopsBomb2 owner looping the code.
Fix center explode on looping
Fix save new score on the highscore.dat data
Added sprite and counter for Energy of BOSS
Added new font for the counter of BOSS, font03.png
Optimised a render and blit of borders for speed up frames
Added enlarge backgrounds (640) for LowRam and now as little image
Added sound ALERT COUNTER BOSS for activate a counter of BOSS
Now a dual borders is on a 1941Deluxe.cfg on it possible active this on High and low levels
	

For the future:
--------
* Sources released as SVN for all contribution and improvement of my work with
other developper's

Thanks:
-------
My Wife "Claire" and children "Matthis and Sorh?nn" to allow me time to
develop.
All Betatesters and all Amiga and MorphOS users

Bugreports for MorphOS:
----------------------
NOUVEL (HunoPPC) Hugues
nouvel.hugues@orange.fr
http://clubevolution4.com/HunoPortSDL
