
CYBER-MAN  (c) COPYRIGHT 1993 by FABIO "MAVERICK" BIZZETTI

This game runs on all OCS/ECS/AGA Amigas with at least 1MB of RAM. Once you
have launched it you can't quit to the OS anymore (you must reboot). Be aware!
The file CyberMan.exe can be ran from the hard disk, and requires at least
2MB of RAM. The file CyberMan.DMS is the trackloader version, and runs on all
Amigas with at least 1MB of RAM (you need to use the enclosed DMS utility
to produce the game's disk). The file CyberMan.ADF is the same 1MB version
of before, and can be used on all UAE emulators (for the Amiga itself, with
or without PowerPC CPU, for Unix systems and for many other personal computers
that are so stupid that won't notice that this game talks just about them..).

This is the first game I developed on my Amiga, I started developing it in
late 1991 just as "programming exercise", to make some experience. I am much
fond of the game PacMania, and I always loved my Amiga in a special way.
So I decided to make a full 3D version of PacMania, but with computers as
protagonists. Read below for a description of each one of them.

You find enclosed also the source of the game, it's 100% assembly. I started
to code it using only the assembler that came with the Action Replay III, it
may seem a big work (and it was..), but this is the way that many coders used
to work. I then got a good assembler, AsmOne, and disassembled the routines I
wrote with the Action Replay III, added comments (sorry, many are in Italian),
added more code. The sources are there to look at (to check the AI routines,
for example.. or the 3D engine), but don't ask me instructions on how to
assemble them because it's not a simple thing to explain... =) Just as hint,
the main game code is GAME.S, it uses two "libraries" (just binary files with
PC relative code), one is the 3D engine (CYBER_DRAW.S) and the other is the
game and AI engine (CYBER_INT.S).
For my second game, Virtual Karting (this one was commercial), I created a
game OS and a programming language (with compiler), called H.L.A. ("High
Level Assembly") that made coding life *much* easier.. that's what you want
to do after you've coded a whole game (and before a Vic20 emulator :-) )
using almost only the Action Replay III assembler and binary load/save
functions.

NOTE: The levels on the game are 5, the "secret" levels are:
1) exiting from the first level and going towards the second (there are
   signs on the road to drive you), you can notice a "open" part on the right,
   if you enter in it, there is a VERY big C= Commodore logo, maybe too much
   big to be identified.
2) there is a very big "CYBER-MAN" logo too, near Level 4 and Level 5.
They aren't playable, they are just some areas to explore.

-----------------------------------------------------------------------------
| AMIGA RULEZ!!  AMIGA RULEZ!!  AMIGA RULEZ!!  AMIGA RULEZ!!  AMIGA RULEZ!! |
-----------------------------------------------------------------------------
                   CYBER-MAN     (game description)

   This is a 3D game in which you come into a fantasy computer dimension.
   The scenario is the fanciful AMIGALAND where a crime has just happened.
   The 5 AMIGA rivals called "Empty Inside", "Mackintosh", "JoyPad",
   "STupid" and "Pitagoras" have been raiding in the land and kidnapped
   our AMIGA. There are 5 levels in AMIGALAND: "StrangerTown", "Funky Town",
   "ElectriCity", "HeartBeat City", "Paradise City" and some secret areas.
   To rescue AMIGA you have to eat all of "Paradise City" pills.
   You, CYBER-MAN, come into the land at "StrangerTown" and once you have
   managed to get out of it (eating all level's pills), you can go everywhere
   you want.
   There are 3 kind of competitions:
     1> The highest Score.
     2> The lowest Time to rescue AMIGA.
     3> The highest (Score/Time) ratio.
   You must eat all pills to open the exit door of a level.
   There are also 5 "SuperPills" per level; when you eat one of them,
   the screen will be white for 10 seconds and if you collide with an
   enemy you will considerably increase your score.
   There are also 14 kinds of BONUS. Depending on which level you are,
   the energy is falling slowly or quickly, to oppose that you can eat
   pills or wait for energy BONUS.
   If an enemy is in front of you, press the fire button and you will
   jump. If you want to accelerate, just move your joystick ahead.
   If you collide with one enemy and you aren't under the effect of
   "SuperPill" or "Angel", the screen will be red and your energy will
   fall rapidly. If you run out of energy, you will be captured by your
   rivals and the game will be over.
   REMEMBER who are the rivals!
-----------------------------------------------------------------------------
| AMIGA RULEZ!!  AMIGA RULEZ!!  AMIGA RULEZ!!  AMIGA RULEZ!!  AMIGA RULEZ!! |
-----------------------------------------------------------------------------

  . green  -PILL            (to finish level/to preserve energy)

 ( ) red   -SUPERPILL       (10 second of safe high scoring opportunity)

BONUS:      you find them,whenever they appear,near this signal -->  (?)
             (you will ear a SOUND whenever a BONUS appears)          |
                                                                      |
                                                                      |

  (+)      -FULL ENERGY     (the ENERGY becomes full)


  (^)      -SCREGY            (blue: 5000 points and a few of ENERGY)
                              (green: 10000 points and more ENERGY)
                              (violet: 20000 points and a lot of ENERGY)

  (!)      -STOP            (your enemy will be stopped for 16 seconds)


  (5)      -NO TUBE         (5 secs of screen fault; a few of extra score)


  [5]      -NO CUBE         (5 secs of screen fault; a lot of extra score)


   ^ green -MORE SPEED      (your speed will be increased)


   ^ red   -LESS SPEED      (your speed will be decreased)


  [] red   -LONGER JUMP     (your jump will be longer)


  [] green -SHORTER JUMP    (your jump will be shorter)


 ( ) violet   -ANGEL or DEVIL  (randomly ANGEL or DEVIL)
                            (If you are lucky you will take ANGEL, that is
                             20 seconds of invulnerability. You will ear an
                             agreeable sound during the effect of ANGEL)
                            (But if you are unlucky you will take DEVIL, that
                             is 10 seconds of rapidly exhausting energy.
                             You will ear a disagreeable sound during the
                             effect of DEVIL)

-----------------------------------------------------------------------------
| AMIGA RULEZ!!  AMIGA RULEZ!!  AMIGA RULEZ!!  AMIGA RULEZ!!  AMIGA RULEZ!! |
-----------------------------------------------------------------------------
KEYs:

ESC        = GAME OVER
SPACE      = TOGGLE PAUSE/UNPAUSE
F5         = NOT INTERLACED SCREEN (DEFAULT)
F6         = INTERLACED SCREEN
RETURN     = TOGGLE WIREFRAME/FILLED TUBES (WIREFRAME GIVES BETTER FRAMERATE)
CURS UP    = INCREASE THE DISTANCE OF VIEW (GIVES WORSE FRAMERATE)
CURS DOWN  = DECREASE THE DISTANCE OF VIEW (GIVES BETTER FRAMERATE)

Cheat mode keys:  (HIT THIS KEY MANY TIMES RAPIDLY)
DEL        = END LEVEL, THE EXIT DOOR IS OPEN (you can't do a record).
HELP       = RESTORE ENERGY, BUT HALVE THE SCORE AND ADDS 60 secs TO TIME.

P.S.
You can do a record only if you save the AMIGA, that is to end the LEVEL 5.

-----------------------------------------------------------------------------
| AMIGA RULEZ!!  AMIGA RULEZ!!  AMIGA RULEZ!!  AMIGA RULEZ!!  AMIGA RULEZ!! |
-----------------------------------------------------------------------------

        TECHNICAL NOTES about "CYBER-MAN"

100% Assembly Language highly optimized programming.
Full PAL OverScan, 352x278 resolution.
Super SMOOTH 3D screen drawing (whereas the screen size and number of polygons)
Compatible with all AMIGA models.
Fully intensive BLITTER usage (and all DMA channels).
No disk access once loaded.
Enemies controlled by artificial intelligence routines.

*** ABOUT THE ARTIFICIAL INTELLIGENCE ROUTINEs ***
These are the product of some studies I did about neurons and insect's society.
Each enemy has its own "temperament" and "instincts" reflecting how I think
about the computer it represents, and every one has its social behaviour.
NOTE:I limited the efficiency of their brain because in play-testing they were
    too strong and organized. I also limited their eyes, their view is FRONT,
    LEFT and RIGHT, they don't see through objects. So they aren't too strong.
    This routine is the state of the art in MC68000's opimizing code. Each
    ghost evalues the stimols from the "external" world with its temperament
    and makes instinctive decisions, then considers how to relate himself to
    his allies. This routine works 50 times per second, so only an extremely
    optimized code doesn't slow the action.
**** When a ghost is "aggressive" it doubles its speed (as you can do moving
     the joystick ahead) whenever it sees you.

Empty Inside    - (It is the parody of PC's "Intel Inside" propaganda)
                  This ghost is the most dangerous of all. Its temperament
                  can be defined as "social". It follows you and calls
                  all the others (with its authority). If it doesn't
                  see you, it tries to organize the group against you.
                  When you are under the effect of "SuperPill", it tries
                  to scatter the group and run away.
                  "Empty Inside" is aggressive from level 3, "ElectriCity".

Mackintosh      - (It represents the Apple Macintosh computer)
                  This ghost can be considered a "snob". It hates the help
                  of others and will follow you only if it doesn't see any
                  other doing the same. It is an "antisocial" character.
                  When you are under the effect of "SuperPill", it simply
                  avoids the others but doesn't run away from you.
                  "Mackintosh" is aggressive from level 4, "HeartBeat City".

JoyPad          - (It represents SNES,PC-ENGINE,NEO GEO,MEGADRIVE)
                  This ghost doesn't care about others, it is antisocial.
                  It only looks for you.
                  When you are under the effect of "SuperPill", it runs away.
                  "JoyPad" is aggressive from level 5, "Paradise City".

STupid          - (Also called "SynTax error", represents the ST computer)
                  It can be considered coward. If there are others in the
                  area, it prefers to avoid the contact with you, turning
                  left or right. When you are under the effect of "SuperPill",
                  it stupidly tries to oppose the "Emtpy Inside" scattering
                  action. "STupid" is aggressive from level 2, "Funky Town".

Pythagoras      - (It represents the Acorn Archimedes computer)
                  I appreciate this system, so in my game it isn't too much
                  bad. It is simply completely blind and it wanders in the
                  level, also if you are under the effect of "SuperPill".
                  But it can involuntarily be followed by "Empty Inside" or
                  "STupid",so watch your radar!
                  "Pitagoras" is never aggressive.

-----------------------------------------------------------------------------
| AMIGA RULEZ!!  AMIGA RULEZ!!  AMIGA RULEZ!!  AMIGA RULEZ!!  AMIGA RULEZ!! |
-----------------------------------------------------------------------------

(c) 1993 by Fabio Bizzetti
