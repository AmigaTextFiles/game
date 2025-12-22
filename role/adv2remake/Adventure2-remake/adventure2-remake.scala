V3.0

MOUSE on
FKEYS on
INTERACTIVE on

EVENT Start
SOUND play adv2remake:files/that-old-amiga-sound.mod volume 64 pan 0 period 350 loops -1
BLANK 640 512 4 lace hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 d60 fb0 080 58b 53c a2b f3b
FONT FuturaB.font 64
COLOR 1 6 7 3 4 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES 3D edge remap center
STYLE 0 3 4 3 6 1 1 57 7 1 32 0 0 0 1 0 0 0 0
TEXTWIPE xword speed 6
TEXT 112 22 "Adventure 2 " pause 1
COLOR 6 1 7 3 4 0 6 7 0 6 5 5 6 6 6
ATTRIBUTES 3D edge center
TEXT 188 108 "Remake"
FONT FuturaB.font 32
COLOR 1 7 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap center
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 320 78 ""
FONT FuturaB.font 20
COLOR 1 5 7 3 4 0 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE bob east easeout speed 6
TEXT 80 364 "Coding & gfx by QuantumCodeMonk.itch.io" pause 3
ATTRIBUTES edge center
TEXTWIPE bob west easeout speed 6
TEXT 94 392 "Music by MisthaLu, IndieGameMusic.com"
TEXTWIPE bob north easeout speed 6
TEXT 171 456 "Press mousebutton to start"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 4 2 636 508  SET hatch 0  SET storagedoor 0  SET jar 0  SET slime 0  SET spacesuit 0  SET tools 0  SET wires 0  SET oxygentank 0  SET battery 0  SET escapehatch 0  SET rope 0  SET trap 0  SET berries 0  SET magazine 0  SET ring 0  SET dollarbill 0  SET whistle 0  SET orderform 0  SET beast 0  SET portal 0  SET dog 0  SET robot 0  SET c4 0  GOTO Intro
PAUSE -1
END

EVENT Intro
PICTURE adv2remake:files/big-popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 78 62 "While you were asleep in the cryopod, your "
ATTRIBUTES edge
TEXT 78 84 "spaceship malfunctioned, and was taken "
TEXT 78 106 "aboard some sort of space freighter. "
COLOR 1 6 7 7 7 0 1 7 0 1 2 3 5 4 1
TEXT 78 128 ""
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
TEXT 78 150 "They probably thought you were space "
TEXT 78 172 "debris. The ship rattles and lands with a "
TEXT 78 194 "bang. "
COLOR 1 6 7 7 7 0 1 7 0 1 2 3 5 4 1
TEXT 78 216 ""
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
TEXT 78 238 "You wake up and climb out of the cryopod..."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 4 2 636 508  GOTO "Pod room"
PAUSE -1
END

EVENT Engineroom
PICTURE adv2remake:files/engineroom.iff
TABS 100 200 300 400 500
MARGINS off 32 607
FONT FuturaB.font 32
COLOR 5 4 0 0 0 14 5 0 0 5 2 2 4 3 5
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 2 2 "Engineroom"
FONT FuturaB.font 20
COLOR 1 4 0 0 0 14 1 0 0 1 2 2 4 3 1
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 0 34 "A big and bulky reactor is located against one of the "
ATTRIBUTES edge
TEXT 0 56 "walls. The reactor is silent and dark. "
FONT FuturaB.font 16
COLOR 2 0 0 0 0 14 2 0 0 2 1 2 4 3 2
ATTRIBUTES remap
STYLE 0 3 4 3 6 1 1 17 2 1 32 0 0 0 1 0 0 0 0
TEXT 372 130 ""
FONT FuturaB.font 32
COLOR 5 4 0 0 0 14 5 0 0 5 2 2 4 3 5
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXT 98 152 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 2 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 524 170 612 416  IF "slime = 1" GOTO "You pour the slime"  IF slime=0 GOTO "The door is locked"
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 270 420 468 488  IF hatch=1 GOTO "Ship with open door"  IF hatch=0 GOTO Ship
SELECT replace 0 1 4 3 2 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 410 270 446 384  IF oxygentank=1 GOTO "You fill up the empty oxygentank"  IF oxygentank=0 GOTO "Nothing happens!"  IF oxygentank=2 GOTO "You can`t!"
SELECT replace 0 1 2 3 2 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 120 140 196 226  IF wires=1 GOTO "You fix the fusebox"  IF wires=0 GOTO "Nothing happens!"  IF wires=2 GOTO "You can`t!"
BUTTON position 254 190 374 396  IF battery=1 GOTO "You replace the battery"  IF battery=0 GOTO "Nothing happens!"  IF battery=2 GOTO "You can`t!"
PAUSE -1
END

EVENT "Engineroom with open door"
PICTURE adv2remake:files/engineroom-with-open-door.iff
TABS 100 200 300 400 500
MARGINS off 32 607
FONT FuturaB.font 32
COLOR 5 4 0 0 0 0 5 0 0 5 2 2 4 3 5
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 2 2 "Engineroom"
FONT FuturaB.font 20
COLOR 1 4 0 0 0 0 1 0 0 1 2 2 4 3 1
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 0 34 "A big and bulky reactor is located against one of the "
ATTRIBUTES edge
TEXT 0 56 "walls. The reactor is silent and dark. "
FONT FuturaB.font 16
COLOR 2 0 0 0 0 0 2 0 0 2 1 2 4 3 2
ATTRIBUTES remap
STYLE 0 3 4 3 6 1 1 17 2 1 32 0 0 0 1 0 0 0 0
TEXT 372 130 ""
FONT FuturaB.font 32
COLOR 5 4 0 0 0 0 5 0 0 5 2 2 4 3 5
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXT 98 152 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 518 170 612 416  GOTO Storage
BUTTON position 270 418 468 488  IF hatch=1 GOTO "Ship with open door"  IF hatch=0 GOTO Ship  GOTO Ship
SELECT replace 0 1 4 3 2 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 408 266 446 384  IF oxygentank=1 GOTO "You fill up the empty oxygentank"  IF oxygentank=0 GOTO "Nothing happens!"  IF oxygentank=2 GOTO "You can`t!"
SELECT replace 0 1 2 3 2 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 120 142 198 226  IF wires=1 GOTO "You fix the fusebox"  IF wires=0 GOTO "Nothing happens!"  IF wires=2 GOTO "You can`t!"
BUTTON position 254 190 370 396  IF battery=1 GOTO "You replace the battery"  IF battery=0 GOTO "Nothing happens!"  IF battery=2 GOTO "You can`t!"
PAUSE -1
END

EVENT Ship
PICTURE adv2remake:files/ship.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 1 4 7 7 7 0 1 7 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 6 6 "Ship"
FONT FuturaB.font 20
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 6 42 "This is the main corridor in the ship. A hatch is located "
ATTRIBUTES edge
TEXT 6 64 "on the west wall."
FONT FuturaB.font 8
COLOR 2 7 7 7 7 0 2 7 0 2 1 2 4 3 2
ATTRIBUTES remap
STYLE 0 3 4 3 6 1 1 10 1 1 32 0 0 0 1 0 0 0 0
TEXT 98 286 "Open"
MARK replace 12 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 12 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 88 270 134 308  SET hatch 1  GOTO "The door is open (ship)"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 3 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 142 200 224 398  GOTO "The door is closed"
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 530 190 622 428  GOTO Cockpit
BUTTON position 320 214 440 366  IF storagedoor=1 GOTO "Engineroom with open door"  IF storagedoor=0 GOTO Engineroom
BUTTON position 276 450 476 512  GOTO "Pod room"
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 136 230 140 230  IF a=1 GOTO "Middle corridor"  GOTO Ship
PAUSE -1
RETURN
END

EVENT "Ship with open door"
PICTURE adv2remake:files/ship-with-open-door.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 1 4 7 7 7 14 1 7 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 6 6 "Ship"
FONT FuturaB.font 20
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 6 42 "This is the main corridor in the ship."
FONT FuturaB.font 8
COLOR 2 7 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES remap
STYLE 0 3 4 3 6 1 1 10 1 1 32 0 0 0 1 0 0 0 0
TEXT 98 286 "Open"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 12 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 88 270 128 308  GOTO "Nothing happens!"
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 5 13 14 15
BUTTON position 138 200 240 406  GOTO "Middle corridor"
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 530 190 622 428  GOTO Cockpit
BUTTON position 320 214 440 366  IF storagedoor=1 GOTO "Engineroom with open door"  IF storagedoor=0 GOTO Engineroom
BUTTON position 256 448 476 512  GOTO "Pod room"
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 136 230 140 230  IF a=1 GOTO "Middle corridor"  GOTO Ship
PAUSE -1
RETURN
END

EVENT Cockpit
PICTURE adv2remake:files/cockpit.iff
TABS 100 200 300 400 500
MARGINS off 32 607
FONT FuturaB.font 32
COLOR 1 4 0 0 0 14 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 2 2 "Cockpit"
FONT FuturaB.font 20
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 2 34 "There\\`s a big dashboard here."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 130 154 230 418  IF hatch=1 GOTO "Ship with open door"  IF hatch=0 GOTO Ship
SELECT replace 0 0 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 480 128 630 440  IF wires<2 GOTO "No power in essential systems"  IF battery<2 GOTO "The reactor is offline"  IF oxygentank<2 GOTO "Life support is low on oxygen"  IF battery=2 GOTO "You press the startbutton" RETURN
PAUSE -1
END

EVENT "Pod room"
PICTURE adv2remake:files/podroom.iff
TABS 100 200 300 400 500
MARGINS off 32 607
FONT FuturaB.font 32
COLOR 1 4 0 0 0 0 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 4 6 "Pod room"
FONT FuturaB.font 20
ATTRIBUTES edge
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 3 40 "The room is full of cryopods."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 336 214 422 364  IF hatch=1 GOTO "Ship with open door"  IF hatch=0 GOTO Ship
PAUSE -1
END

EVENT Storage
PICTURE adv2remake:files/storage.iff
TABS 100 200 300 400 500
MARGINS off 32 607
FONT FuturaB.font 32
COLOR 1 4 0 0 0 14 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 3 2 "Storage"
FONT FuturaB.font 20
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 2 36 "There are a few spacesuits and a toolbox here."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 150 184 226 416  IF storagedoor=1 GOTO "Engineroom with open door"  IF slime=1 NEXT  IF slime=0 GOTO Engineroom
SELECT replace 0 1 3 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 252 180 516 368  IF spacesuit=0 GOTO "You pick up a spacesuit"  IF spacesuit=1 GOTO "You can`t!"
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 1 15
BUTTON position 518 360 592 422  IF tools=0 GOTO "You pick up some tools"  IF tools=1 GOTO "You can`t!"
PAUSE -1
END

EVENT "Middle corridor"
PICTURE adv2remake:files/me-corridor.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 1 4 0 0 0 1 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 0 12 "Middle corridor"
FONT FuturaB.font 20
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 0 46 "There`s a hole in the wall where your spaceship has"
ATTRIBUTES edge
TEXT 0 68 "crashed."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 516 142 630 408  GOTO "Ship with open door"
BUTTON position 334 204 450 364  GOTO "Upper corridor"
BUTTON position 290 440 470 508  IF slime=0 GOTO "Lower corridor"  IF slime=1 GOTO "Lower corridor without slime" RETURN
PAUSE -1
END

EVENT "Lower corridor"
PICTURE adv2remake:files/le-corridor.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 1 4 0 0 0 14 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 4 2 "Lower corridor"
FONT FuturaB.font 20
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 2 34 "There`s some slime on the floor."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 312 224 430 364  GOTO "Middle corridor"
BUTTON position 120 176 228 422  GOTO "Another lower corridor"
SELECT replace 0 1 2 3 2 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 452 360 542 422  IF jar=1 GOTO "You fill the jar with slime"  IF jar=0 GOTO "You can`t, corrosive slime" RETURN
PAUSE -1
END

EVENT "Lower corridor without slime"
PICTURE adv2remake:files/le-corridor-without-slime.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 1 4 0 0 0 14 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 4 2 "Lower corridor"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 312 224 430 372  GOTO "Middle corridor"
BUTTON position 120 176 222 410  GOTO "Another lower corridor"
PAUSE -1
END

EVENT "Upper corridor"
PICTURE adv2remake:files/ue-corridor.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 1 4 0 0 0 14 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 2 0 "Upper corridor"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 118 136 218 416  GOTO "Another upper corridor"
BUTTON position 316 214 432 370  IF jar=1 GOTO "Utility room 2 without jar"  IF jar=0 GOTO "Utility room 2" RETURN
BUTTON position 294 428 468 498  GOTO "Middle corridor"
SELECT replace 0 1 2 3 2 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 528 176 602 422  GOTO "The door is locked"
PAUSE -1
END

EVENT "Utility room"
PICTURE adv2remake:files/utilityroom.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 1 4 0 0 0 14 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 2 2 "Utility room"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 2 13 14 15
BUTTON position 292 220 432 378  GOTO "Another lower corridor"
SELECT replace 0 1 2 3 2 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 522 282 556 396  IF oxygentank=0 GOTO "You pick up the oxygentank"  IF oxygentank=1 GOTO "You can`t!"
SELECT replace 0 1 3 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 140 328 240 424  IF c4=0 GOTO "You pick up C4"  IF c4=1 GOTO "You can`t!"
PAUSE -1
END

EVENT "Utility room 2"
PICTURE adv2remake:files/utilityroom2.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 1 4 0 0 0 14 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 2 0 "Utility room"
FONT FuturaB.font 20
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 2 34 "A shelf is mounted on one wall. An empty jar is on the "
ATTRIBUTES edge
TEXT 2 56 "shelf."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 278 420 484 494  GOTO "Upper corridor"
SELECT replace 0 1 2 3 2 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 122 164 194 248  GOTO "You pick up the jar"
PAUSE -1
END

EVENT "Utility room 2 without jar"
PICTURE adv2remake:files/utilityroom2-without-jar.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 1 4 0 0 0 14 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 2 0 "Utility room"
FONT FuturaB.font 20
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 2 34 "A shelf is mounted on one wall."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 278 418 484 494  GOTO "Upper corridor"
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position -1 32 596 54  GOTO "Upper corridor"
PAUSE -1
END

EVENT "Another upper corridor"
PICTURE adv2remake:files/uw-corridor.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 1 4 0 0 0 14 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 0 10 "Another upper corridor"
FONT FuturaB.font 20
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 0 46 "On the wall you spot a fusebox."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 514 166 604 406  GOTO "Upper corridor"
BUTTON position 266 412 480 498  IF robot=1 GOTO "Another middle corridor with robot"  IF robot=0 GOTO "Another middle corridor" RETURN
SELECT replace 0 1 2 3 2 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 126 150 208 234  IF wires=1 GOTO "You can`t!"  IF tools=1 GOTO "You remove some wires"  IF tools=0 GOTO "You can`t!"  GOTO "Upper corridor"
PAUSE -1
END

EVENT "Another lower corridor"
PICTURE adv2remake:files/lw-corridor.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 1 4 0 0 0 0 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 2 4 "Another lower corridor"
FONT FuturaB.font 16
COLOR 2 0 0 0 0 0 2 0 0 2 1 2 4 3 2
COLOR 2 0 0 0 0 0 2 0 0 2 1 2 4 3 2ATTRIBUTES none
STYLE 0 3 4 3 6 1 1 17 2 1 32 0 0 0 1 0 0 0 0
TEXT 584 296 ""
FONT FuturaB.font 20
COLOR 1 4 0 0 0 0 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 4 42 "The exit south is blocked by a gas cloud. A gas pipe "
ATTRIBUTES edge
TEXT 4 64 "nearby is leaking. The gas could be dangerous."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 322 214 440 364  IF robot=1 GOTO "Another middle corridor with robot"  IF robot=0 GOTO "Another middle corridor" RETURN
BUTTON position 514 168 616 422  IF slime=1 GOTO "Lower corridor without slime"  IF slime=0 GOTO "Lower corridor" RETURN
BUTTON position 232 396 496 502  IF spacesuit=0 GOTO "You can`t, lethal gas"  IF spacesuit=1 GOTO "Utility room"
PAUSE -1
END

EVENT "Another middle corridor"
PICTURE adv2remake:files/mw-corridor.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 1 4 0 0 0 14 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 0 0 "Another middle corridor"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 302 206 426 366  GOTO "Another upper corridor"
BUTTON position 262 416 468 502  GOTO "Another lower corridor"
SELECT replace 0 1 2 3 2 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 148 168 226 400  IF c4=1 GOTO "You throw a stick of C4"  IF c4=0 GOTO "The door is locked" RETURN
PAUSE -1
END

EVENT "Another middle corridor with robot"
PICTURE adv2remake:files/mw-corridor-with-robot.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 1 4 0 0 0 14 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 0 0 "Another middle corridor"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 302 206 426 366  GOTO "Another upper corridor"
BUTTON position 300 418 434 502  GOTO "Another lower corridor"
SELECT replace 0 1 2 3 2 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 148 168 228 342  GOTO "The door is locked"
SELECT replace 0 1 3 2 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 212 348 294 432  IF battery=1 GOTO "Nothing happens!"  IF tools=0 GOTO "You can`t!"  IF battery=0 GOTO "You remove the battery" RETURN
PAUSE -1
END

EVENT Escapepod
PICTURE adv2remake:files/escapepod.iff
TABS 100 200 300 400 500
MARGINS off 32 607
FONT FuturaB.font 32
COLOR 1 4 0 0 0 0 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 2 2 "Escapepod"
FONT FuturaB.font 20
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 0 42 "There\\`s a big dashboard here."
FONT FuturaB.font 8
COLOR 2 0 0 0 0 0 2 0 0 2 1 2 4 3 2
ATTRIBUTES remap
STYLE 0 3 4 3 6 1 1 10 1 1 32 0 0 0 1 0 0 0 0
TEXT 112 254 "Open"
FONT FuturaB.font 16
STYLE 0 3 4 3 6 1 1 17 2 1 32 0 0 0 1 0 0 0 0
TEXT 64 38 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 2 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 144 166 226 418  GOTO "The door is closed"
SELECT replace 0 0 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 484 134 628 406  GOTO "Nothing happens!"
SELECT replace 12 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 102 222 142 286  SET escapehatch 1  GOTO "The door is open (escapepod)"
PAUSE -1
END

EVENT "Escapepod with open door"
PICTURE adv2remake:files/escapepod-with-opendoor.iff
TABS 100 200 300 400 500
MARGINS off 32 607
FONT FuturaB.font 32
COLOR 1 4 0 0 0 14 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 2 2 "Escapepod"
FONT FuturaB.font 20
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 0 42 "There\\`s a big dashboard here."
FONT FuturaB.font 8
COLOR 2 0 0 0 0 14 2 0 0 2 1 2 4 3 2
ATTRIBUTES remap
STYLE 0 3 4 3 6 1 1 10 1 1 32 0 0 0 1 0 0 0 0
TEXT 114 252 "Open"
FONT FuturaB.font 16
STYLE 0 3 4 3 6 1 1 17 2 1 32 0 0 0 1 0 0 0 0
TEXT 64 38 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 144 154 230 418  GOTO "Western path"
SELECT replace 0 0 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 484 126 628 406  GOTO "Nothing happens!"
SELECT replace 12 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 102 222 142 288  GOTO "Nothing happens!"
PAUSE -1
END

EVENT "Western path"
PICTURE adv2remake:files/w-path.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 1 4 7 7 7 14 1 7 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 6 6 "Western path"
FONT FuturaB.font 20
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 4 42 "The path leads to the east. Your escapepod is to the "
ATTRIBUTES edge
TEXT 4 64 "north."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 136 230 140 230
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 2 13 14 15
BUTTON position 330 220 448 370  GOTO "Escapepod with open door"
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 554 326 646 484  IF whistle=1 GOTO "Eastern path with whistle"  IF whistle=0 GOTO "Eastern path" RETURN
PAUSE -1
RETURN
END

EVENT "Eastern path"
PICTURE adv2remake:files/e-path.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 1 4 7 7 7 14 1 7 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 6 6 "Eastern path"
FONT FuturaB.font 20
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 4 40 "The path leads to the west. To the east you can see "
ATTRIBUTES edge
TEXT 4 62 "a parking lot. A branch is hanging low over the path."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 136 230 140 230
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 110 342 258 476  GOTO "Western path"
BUTTON position 548 342 640 468  GOTO Parking
SELECT replace 0 1 2 3 4 5 6 7 8 9 1 11 12 13 14 15
BUTTON position 288 114 446 366  IF rope=1 GOTO "You tie the rope"  IF "whistle=1 & trap=0" GOTO "Beast escapes"  IF "whistle=1 & trap=1" GOTO "Beast caught"  IF rope=0 GOTO "Nothing happens!"  IF rope=2 GOTO "Nothing happens!"
PAUSE -1
RETURN
END

EVENT "Eastern path with whistle"
PICTURE adv2remake:files/e-path.iff
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 4 7 7 7 0 1 7 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 0 0 0 0 0 0 1 0 0 0 0
TEXTWIPE xword speed 6
BRUSH 33 106 adv2remake:files/whistle.iff
FONT FuturaB.font 32
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 6 6 "Eastern path"
FONT FuturaB.font 20
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 4 40 "The path leads to the west. To the east you can see "
ATTRIBUTES edge
TEXT 4 62 "a parking lot."
FONT FuturaB.font 32
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXT 594 72 ""
FONT FuturaB.font 16
STYLE 0 3 4 3 6 1 1 17 2 1 32 0 0 0 1 0 0 0 0
TEXT 34 226 "Use whistle"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 136 230 140 230
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 110 356 258 476  GOTO "Western path"
BUTTON position 550 342 640 466  GOTO Parking
SELECT replace 0 1 2 3 4 5 6 7 8 9 1 11 12 13 14 15
BUTTON position 288 114 446 366  IF rope=1 GOTO "You tie the rope"  IF rope=0 GOTO "Nothing happens!"  IF rope=2 GOTO "Nothing happens!"
SELECT replace 0 1 2 3 4 5 6 7 8 10 10 11 12 13 14 15
BUTTON position 30 98 130 242  IF beast=1 GOTO "Nothing happens!"  IF "whistle=1 & trap=0" GOTO "Beast escapes"  IF "whistle=1 & trap=1" GOTO "Beast caught"
PAUSE -1
RETURN
END

EVENT Parking
PICTURE adv2remake:files/parking.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 1 4 7 7 7 0 1 7 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 6 6 "Parking"
FONT FuturaB.font 20
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 4 46 "You`re on a parking lot for space shuttles. A path leads "
ATTRIBUTES edge
TEXT 4 68 "to the west, an alley is to the east. To the north you can "
TEXT 4 90 "see a building with a big golden M. "
TEXT 4 112 "It`s `Menhir Burgers`!"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 136 230 140 230
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 112 356 216 454  IF whistle=1 GOTO "Eastern path with whistle"  IF whistle=0 GOTO "Eastern path" RETURN
BUTTON position 560 342 640 464  IF rope>0 GOTO "Alley without rope"  IF rope=0 GOTO Alley RETURN
BUTTON position 482 198 566 336  GOTO "Main hall"
BUTTON position 282 432 388 512  GOTO Swamp
SELECT replace 0 1 2 3 4 5 6 7 14 9 10 11 12 13 14 15
BUTTON position 386 238 426 316  GOTO "Nothing happens!"
PAUSE -1
RETURN
END

EVENT "Main hall"
PICTURE adv2remake:files/mainhall.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 1 4 0 0 0 14 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 2 0 "Main hall"
FONT FuturaB.font 20
ATTRIBUTES edge
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 2 32 "A big table is located in the room, a magazine is laying "
TEXT 2 54 "on the table.The counter is on the far side of the room. "
FONT FuturaB.font 12
COLOR 2 0 0 0 0 14 2 0 0 2 1 2 4 3 2
COLOR 2 0 0 0 0 14 2 0 0 2 1 2 4 3 2ATTRIBUTES none
STYLE 0 3 4 3 6 1 1 11 2 1 32 0 0 0 1 0 0 0 0
TEXT 388 24 ""
FONT FuturaB.font 32
COLOR 1 4 0 0 0 14 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXT 60 350 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 242 424 398 502  GOTO Parking
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 456 488 468 488
BUTTON position 222 164 352 342  GOTO Burgers
SELECT replace 0 1 2 2 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 400 330 550 416  IF magazine=0 GOTO "You pick up the magazine"  IF magazine=1 GOTO "Nothing happens!"
PAUSE -1
END

EVENT Burgers
PICTURE adv2remake:files/burgers.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 1 4 0 0 0 14 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 2 0 "Burgers"
FONT FuturaB.font 20
ATTRIBUTES edge
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 4 34 "The staff looks very busy."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 226 440 484 494  GOTO "Main hall"
BUTTON position 118 108 336 276  IF dollarbill=1 GOTO "You order a meal"  IF dollarbill=0 GOTO "You can`t!"
PAUSE -1
END

EVENT Alley
PICTURE adv2remake:files/alley.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 1 4 0 0 0 14 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 2 0 "Alley"
FONT FuturaB.font 20
ATTRIBUTES edge
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 2 32 "On the lawn next to the blue container is a rope. "
TEXT 2 54 "A vicious dog is here. "
FONT FuturaB.font 12
COLOR 2 0 0 0 0 14 2 0 0 2 1 2 4 3 2
COLOR 2 0 0 0 0 14 2 0 0 2 1 2 4 3 2ATTRIBUTES none
STYLE 0 3 4 3 6 1 1 11 2 1 32 0 0 0 1 0 0 0 0
TEXT 308 20 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 484 424 586 512  GOTO "Dog is blocking path"
BUTTON position 108 348 188 454  GOTO Parking
SELECT replace 0 1 2 3 2 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 346 308 442 358  GOTO "You pick up the rope"
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 386 380 478 498  IF beast=1 GOTO "You release the Beast"  IF dog=1 GOTO "The dog is dead"  IF beast=0 GOTO "You can`t!"
SELECT replace 0 1 2 3 3 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 206 258 342 332  GOTO "Nothing happens!"
PAUSE -1
END

EVENT "Alley without rope"
PICTURE adv2remake:files/alley-no-rope.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 1 4 0 0 0 14 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 2 0 "Alley"
FONT FuturaB.font 20
ATTRIBUTES edge
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 0 32 "A vicious dog is here. "
FONT FuturaB.font 12
COLOR 2 0 0 0 0 14 2 0 0 2 1 2 4 3 2
COLOR 2 0 0 0 0 14 2 0 0 2 1 2 4 3 2ATTRIBUTES none
STYLE 0 3 4 3 6 1 1 11 2 1 32 0 0 0 1 0 0 0 0
TEXT 308 20 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 484 416 582 512  IF dog=0 GOTO "Dog is blocking path"  IF dog=1 GOTO Forest
BUTTON position 104 348 188 454  GOTO Parking
BUTTON position 386 380 478 498  IF beast=1 GOTO "You release the Beast"  IF dog=1 GOTO "The dog is dead"  IF beast=0 GOTO "You can`t!"
SELECT replace 0 1 2 3 3 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 206 260 342 332  GOTO "Nothing happens!"
PAUSE -1
END

EVENT Swamp
PICTURE adv2remake:files/swamp.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 1 4 0 0 0 14 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 2 0 "Swamp"
FONT FuturaB.font 20
ATTRIBUTES edge
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 2 36 "A small bush is growing on one side of the swamp. "
TEXT 2 58 "The Swampmonster is here."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 346 406 508 508  IF berries=1 GOTO Clearing  IF berries=0 GOTO "Swampmonster is blocking the path"
BUTTON position 308 172 456 304  SET berries 0  GOTO Parking
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 11 13 14 15
BUTTON position 140 252 210 434  GOTO "You pick some berries"
PAUSE -1
END

EVENT Clearing
PICTURE adv2remake:files/clearing.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 1 4 0 0 0 14 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 2 0 "Clearing"
FONT FuturaB.font 20
ATTRIBUTES edge
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 2 36 "A mailbox is here."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 306 186 444 290  GOTO Swamp
SELECT replace 0 1 2 2 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 164 282 258 396  IF orderform=1 GOTO "You put the orderform in the mailbox"  IF orderform=0 GOTO "Nothing happens!"
PAUSE -1
END

EVENT Forest
PICTURE adv2remake:files/forest.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 1 4 0 0 0 14 1 0 0 1 2 2 4 3 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 29 4 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 2 0 "Forest"
FONT FuturaB.font 20
ATTRIBUTES edge
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 0 34 "A giant glowing portal is here."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 296 174 442 298  GOTO "Alley without rope"
SELECT replace 0 10 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 494 254 634 426  IF portal=1 GOTO "The end"  IF ring=1 GOTO "You unlock the portal"  IF ring=0 GOTO "Nothing happens!"
PAUSE -1
END

EVENT "The end"
PICTURE adv2remake:files/big-popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 48
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap center
STYLE 0 3 4 3 6 1 1 43 5 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 227 228 "The end"
FONT FuturaB.font 20
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXT 90 54 "You made it, you have completed "
ATTRIBUTES edge
TEXT 90 76 "your quest!"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 2 638 510 EXIT
PAUSE -1
END

EVENT "The door is closed"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 106 182 "You can`t, the door is closed."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 4 4 634 506 RETURN
PAUSE -1
RETURN
END

EVENT "The door is locked"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 106 182 "You can`t, the door is locked."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 6 4 636 504 RETURN
PAUSE -1
RETURN
END

EVENT "The door is open (escapepod)"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 122 184 "The door is open."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 4 2 636 504  GOTO "Escapepod with open door"
PAUSE -1
RETURN
END

EVENT "The door is open (ship)"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 112 176 "The door is open."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 4 2 636 504  GOTO "Ship with open door"
PAUSE -1
RETURN
END

EVENT "You can`t!"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 128 192 "You can`t!"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 2 0 632 504 RETURN
PAUSE -1
RETURN
END

EVENT "You can`t, lethal gas"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 128 192 "You can`t, the gas would probably "
ATTRIBUTES edge
TEXT 128 214 "kill you!"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 2 0 632 504 RETURN
PAUSE -1
RETURN
END

EVENT "You can`t, corrosive slime"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 128 192 "You shouldn`t, the slime smells funny "
ATTRIBUTES edge
TEXT 128 214 "and is probably very corrosive!"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 2 0 632 504 RETURN
PAUSE -1
RETURN
END

EVENT "Nothing happens!"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 124 196 "Nothing happens!"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 -2 634 508 RETURN
PAUSE -1
RETURN
END

EVENT "The reactor is offline"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 108 186 "You try to start your ship but nothing"
ATTRIBUTES edge
TEXT 108 208 "happens! "
TEXT 108 230 ""
COLOR 11 4 7 7 7 14 11 7 0 11 10 11 10 10 11
TEXT 108 252 "Error: Reactor is offline."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 6 0 632 510 RETURN
PAUSE -1
RETURN
END

EVENT "Life support is low on oxygen"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 124 186 "You try to start your ship but nothing "
ATTRIBUTES edge
TEXT 124 208 "happens!"
TEXT 124 230 " "
COLOR 11 4 7 7 7 14 11 7 0 11 10 11 10 10 11
TEXT 124 252 "Error: Life support is low on oxygen."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 8 636 506 RETURN
PAUSE -1
RETURN
END

EVENT "No power in essential systems"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 132 182 "You try to start your ship but "
ATTRIBUTES edge
TEXT 132 204 "nothing happens!"
TEXT 132 226 ""
COLOR 11 4 7 7 7 14 11 7 0 11 10 11 10 10 11
TEXT 132 248 "Error: Essential systems are low"
TEXT 132 270 "on power."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 4 6 636 504 RETURN
PAUSE -1
RETURN
END

EVENT "Swampmonster is blocking the path"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 86 174 "You can`t, the swampmonster is blocking "
ATTRIBUTES edge
TEXT 86 196 "the path."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 6 0 634 508 RETURN
PAUSE -1
RETURN
END

EVENT "Dog is blocking path"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 100 180 "You can`t, the vicious dog is blocking "
ATTRIBUTES edge
TEXT 100 202 "the path."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 2 0 636 508 RETURN
PAUSE -1
RETURN
END

EVENT "You pick it up"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 102 184 "You pick it up."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 4 -2 636 502 RETURN
PAUSE -1
RETURN
END

EVENT "You press the startbutton"
PICTURE adv2remake:files/big-popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 76 56 "You press the startbutton on the dashboard "
ATTRIBUTES edge
TEXT 76 78 "and the ship takes of. "
COLOR 1 5 7 7 7 14 1 7 0 1 2 3 5 4 1
TEXT 14 74 ""
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
TEXT 76 124 "You cruise in space for a few hours until "
TEXT 76 146 "you run out of fuel. "
TEXT 76 168 ""
TEXT 76 190 "Luckily you happen to run into a small "
TEXT 76 212 "planetoid where you land safely."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 0 638 510  GOTO Escapepod
PAUSE -1
RETURN
END

EVENT "You fill the jar with slime"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 5 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 0 0 0 0 0 0 1 0 0 0 0
TEXTWIPE xword speed 6
BRUSH 91 213 adv2remake:files/jar-with-slime.iff
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 90 164 "You fill the jar with slime."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 0 636 510  SET slime 1  GOTO "Lower corridor without slime"
PAUSE -1
RETURN
END

EVENT "You pour the slime"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 82 168 "You pour the slime on the doors locking "
ATTRIBUTES edge
TEXT 82 190 "mechanism. "
TEXT 82 212 ""
TEXT 82 234 "It melts and the door opens."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 0 636 510  SET storagedoor 1  GOTO "Engineroom with open door"
PAUSE -1
RETURN
END

EVENT "You fill up the empty oxygentank"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 92 174 "You fill up the empty oxygentank."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 0 636 510  SET oxygentank 2 RETURN
PAUSE -1
RETURN
END

EVENT "You fix the fusebox"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 94 172 "You fix the fusebox using the wires."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 0 636 510  SET wires 2 RETURN
PAUSE -1
RETURN
END

EVENT "You replace the battery"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 94 174 "You replace the battery in the reactor."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 0 636 510  SET battery 2 RETURN
PAUSE -1
RETURN
END

EVENT "You tie the rope"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 90 178 "You tie the rope to the branch and "
ATTRIBUTES edge
TEXT 90 200 "make a trap."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 0 636 510  SET trap 1  SET rope 2 RETURN
PAUSE -1
RETURN
END

EVENT "You remove some wires"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 5 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 0 0 0 0 0 0 1 0 0 0 0
TEXTWIPE xword speed 6
BRUSH 79 217 adv2remake:files/wires.iff
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 90 164 "You use the tools to remove some wires "
ATTRIBUTES edge
TEXT 90 186 "from the fusebox."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 0 636 510  SET wires 1 RETURN
PAUSE -1
RETURN
END

EVENT "You pick some berries"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 86 162 "You pick some berries from the bush "
ATTRIBUTES edge
TEXT 86 184 "and smear them onto your body."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 0 636 510  SET berries 1 RETURN
PAUSE -1
RETURN
END

EVENT "You pick up the magazine"
PICTURE adv2remake:files/big-popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 5 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 0 0 0 0 0 0 1 0 0 0 0
TEXTWIPE xword speed 6
BRUSH 78 227 adv2remake:files/dollarbill.iff size 185 109
BRUSH 263 220 adv2remake:files/orderform.iff size 139 165
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 72 44 "You pick up the magazine. When you open "
ATTRIBUTES edge
TEXT 72 66 "it something falls out."
TEXT 72 88 "It`s a dollar bill and an orderform for a "
TEXT 72 110 "whistle."
TEXT 70 152 "The whistle is a mating whistle for the "
TEXT 70 174 "Rabbit Terror Beast."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 0 636 510  SET magazine 1  SET dollarbill 1  SET orderform 1 RETURN
PAUSE -1
RETURN
END

EVENT "You pick up the rope"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 5 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 0 0 0 0 0 0 1 0 0 0 0
TEXTWIPE xword speed 6
BRUSH 81 214 adv2remake:files/rope.iff
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 94 158 "You pick up the rope."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 0 636 510  SET rope 1  GOTO "Alley without rope"
PAUSE -1
RETURN
END

EVENT "You pick up a spacesuit"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 5 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 0 0 0 0 0 0 1 0 0 0 0
TEXTWIPE xword speed 6
BRUSH 98 183 adv2remake:files/spacesuit.iff
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 94 152 "You pick up a spacesuit and put it on."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 0 636 510  SET spacesuit 1 RETURN
PAUSE -1
RETURN
END

EVENT "You pick up some tools"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 5 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 0 0 0 0 0 0 1 0 0 0 0
TEXTWIPE xword speed 6
BRUSH 74 212 adv2remake:files/screwdriver.iff
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 88 156 "You pick up some tools."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 0 636 510  SET tools 1 RETURN
PAUSE -1
RETURN
END

EVENT "You pick up the jar"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 92 164 "You pick up the jar."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 0 636 510  SET jar 1  GOTO "Utility room 2 without jar"
PAUSE -1
RETURN
END

EVENT "You pick up the oxygentank"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 5 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 0 0 0 0 0 0 1 0 0 0 0
TEXTWIPE xword speed 6
BRUSH 97 204 adv2remake:files/oxygentank.iff size 47 130
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 92 156 "You pick up the oxygentank."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 0 636 510  SET oxygentank 1 RETURN
PAUSE -1
RETURN
END

EVENT "You remove the battery"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 5 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 0 0 0 0 0 0 1 0 0 0 0
TEXTWIPE xword speed 6
BRUSH 72 204 adv2remake:files/battery.iff
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 80 158 "You use the tools to remove the battery "
ATTRIBUTES edge
TEXT 80 180 "from the cleaningrobot."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 0 636 510  SET battery 1 RETURN
PAUSE -1
RETURN
END

EVENT "You pick up C4"
PICTURE adv2remake:files/big-popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 0 0 0 0 0 0 1 0 0 0 0
TEXTWIPE xword speed 6
BRUSH 94 167 adv2remake:files/c4.iff
FONT FuturaB.font 20
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 82 44 "You pick up a stick of C4 from the crate. "
ATTRIBUTES edge
TEXT 82 66 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 0 636 510  SET c4 1 RETURN
PAUSE -1
RETURN
END

EVENT "You order a meal"
PICTURE adv2remake:files/big-popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 5 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 0 0 0 0 0 0 1 0 0 0 0
TEXTWIPE xword speed 6
BRUSH 107 228 adv2remake:files/ring.iff
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 94 54 "You order a `Menhir Fun Meal` and pay "
ATTRIBUTES edge
TEXT 94 76 "with the dollar bill you found previously."
TEXT 94 98 ""
TEXT 94 120 "You discover a ring in your meal."
TEXT 454 202 ""
ATTRIBUTES edge remap
TEXT 528 64 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 0 636 510  SET ring 1  SET dollarbill 0 RETURN
PAUSE -1
RETURN
END

EVENT "You put the orderform in the mailbox"
PICTURE adv2remake:files/big-popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 5 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 0 0 0 0 0 0 1 0 0 0 0
TEXTWIPE xword speed 6
BRUSH 95 234 adv2remake:files/whistle.iff size 124 114
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 80 52 "You put the orderform in the mailbox... "
ATTRIBUTES edge
TEXT 80 100 "A soft humming is comming from the "
TEXT 82 126 "mailbox. You examine the mailbox again "
TEXT 80 154 "and you find a whistle."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 0 636 510  SET whistle 1  SET orderform 0  GOTO Clearing
PAUSE -1
RETURN
END

EVENT "You unlock the portal"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 90 170 "You unlock the portal using the ring."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 0 636 510  SET portal 1  SET ring 0  GOTO Forest
PAUSE -1
RETURN
END

EVENT "You release the Beast"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 86 154 "You release the Rabbit Terror Beast on "
ATTRIBUTES edge
TEXT 86 176 " the dog. "
TEXT 86 198 ""
TEXT 86 220 "It devours the dog within 2 seconds."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 0 636 510  SET dog 1  SET beast 0 RETURN
PAUSE -1
RETURN
END

EVENT "The dog is dead"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 90 168 "The dog is dead. "
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 0 636 510 RETURN
PAUSE -1
RETURN
END

EVENT "Beast caught"
PICTURE adv2remake:files/big-popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 5 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 0 0 0 0 0 0 1 0 0 0 0
TEXTWIPE xword speed 6
BRUSH 96 199 adv2remake:files/beast.iff size 134 175
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 74 44 "You blow the whistle and wait.  "
ATTRIBUTES edge
TEXT 74 66 "A Rabbit Terror Beast appears on the path. "
TEXT 74 88 ""
TEXT 74 110 "It gets caught  in the trap. "
TEXT 74 132 ""
TEXT 74 154 "You remove it from the trap and put it "
TEXT 74 176 "in your pocket."
COLOR 2 7 7 7 7 14 2 7 0 2 1 2 5 4 2
ATTRIBUTES center
TEXT 319 140 ""
COLOR 1 5 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge
TEXT 488 78 ""
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
TEXT 420 50 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position -2 0 636 510  SET beast 1  SET whistle 0  GOTO "Eastern path"
PAUSE -1
RETURN
END

EVENT "Beast escapes"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 82 150 "You blow the whistle and wait. "
ATTRIBUTES edge
TEXT 82 172 "A Rabbit Terror Beast appears on the path. "
TEXT 82 194 ""
TEXT 82 216 "It quickly  ecapes into the forest. "
TEXT 82 238 ""
TEXT 82 260 "If you only had some sort of trap."
ATTRIBUTES edge remap
TEXT 434 174 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position -2 2 638 510 RETURN
PAUSE -1
RETURN
END

EVENT "You throw a stick of C4"
PICTURE adv2remake:files/popup.iff
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap
STYLE 0 3 4 3 6 1 1 21 3 1 32 0 0 0 1 0 0 0 0
TEXTWIPE dump speed 1
TEXT 82 150 "You throw a stick of C4 into the small"
ATTRIBUTES edge
TEXT 82 172 "opening and wait."
TEXT 82 194 ""
TEXT 82 216 "You hear a loud bang ond smoke pours "
TEXT 82 238 "out of the opening. Followed by a "
TEXT 82 260 "cleaning robot. "
TEXT 82 282 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position -2 2 638 510  SET robot 1  SET c4 0  GOTO "Another middle corridor with robot"
PAUSE -1
RETURN
END
