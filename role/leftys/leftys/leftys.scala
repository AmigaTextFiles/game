V3.0

MOUSE on
FKEYS on
INTERACTIVE on

EVENT "Blank Screen"
BLANK 724 284 4 hires 7
TABS 115 215 315 415 515
MARGINS off 49 674
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
FONT FuturaB.font 32
COLOR 1 7 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
TEXT 63 16 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 7 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position -2 -2 642 514  GOTO Start
PAUSE 0.040
END

EVENT Start
PICTURE "LEFTYS:start.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 7 7 4 3 14 1 7 0 1 2 2 4 3 1
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 106 245 "Start"
TEXT 321 245 "About"
TEXT 556 245 "Credits"
FONT FuturaB.font 96
COLOR 1 0 2 3 4 0 1 7 0 1 2 2 4 3 1
ATTRIBUTES 3D edge 
STYLE 0 3 4 3 6 1 1 84 
TEXT 564 172 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 7 2 3 4 5 6 1 8 9 10 11 12 13 14 5
BUTTON position 78 240 186 267  SET money 25  SET score 0  SET max 89  SET password 0  SET ring 0  SET rose 0  SET tooth 0  SET hammer 0  SET remote 0  SET whiskey 0  SET larry 0  SET act 1  SET sally 0  SET others 0  SET stairs 0  SET roger 0  SET notebook 0  SET woman 0  SET candy 0  SET police 0  SET drunk 0  SET letter 0  SET pills 0  SET casefile 0  SET voicemail 0  SET equipment 0  SET keith 0  SET board 0  GOTO "Chapter 1"
SELECT replace 0 7 2 3 4 5 6 1 8 9 10 11 12 13 14 15
BUTTON position 296 237 410 268  GOTO About
SELECT replace 0 7 2 3 4 5 6 1 8 9 10 11 12 13 14 5
BUTTON position 536 234 648 265  GOTO Credits
PAUSE -1
END

EVENT "Lytton Police department"
PICTURE "LEFTYS:department.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 7 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 17 
TEXTWIPE dump speed 1
BRUSH 471 195 "LEFTYS:cop-car-side.iff"
BRUSH 145 191 "LEFTYS:cop-car-side.iff"
BRUSH 173 224 "LEFTYS:cop-car-side.iff"
FONT FuturaB.font 16
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 17 
TEXT 24 10 "Lytton Police department"
ATTRIBUTES edge 
TEXT 22 27 "The Lytton Police department sits under gray skies, its windows glowing warmly "
TEXT 22 45 "against the approaching darkness. Several patrol cars are parked in neat rows, "
TEXT 22 63 "their radios crackling with occasional dispatch calls."
FONT FuturaB.font 12
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
TEXT 598 255 "Money: $!money"
TEXT 598 269 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 6 4 5 3 7 8 9 10 11 13 12 14 15
BUTTON position -6 138 116 227  GOTO Corridor
SELECT replace 0 4 2 3 1 5 6 7 8 8 10 11 12 13 14 15
BUTTON position 470 195 706 250  IF casefile=1&voicemail=1&equipment=1 GOTO "Chapter 2"  IF 1=1 GOTO "Generic - Not yet"
PAUSE -1
END

EVENT Corridor
PICTURE "LEFTYS:corridor.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 7 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 17 
TEXTWIPE dump speed 1
BRUSH 392 198 "LEFTYS:sonny.iff"
FONT FuturaB.font 16
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 17 
TEXT 24 10 "Police station corridor"
ATTRIBUTES edge 
TEXT 22 27 "The familiar hallway of Lytton PD buzzes with end-of-shift activity. "
TEXT 22 45 "Officers chat by the bulletin board while the coffee machine gurgles in "
TEXT 22 63 "the background."
FONT FuturaB.font 12
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
TEXT 598 255 "Money: $!money"
TEXT 598 269 "Score: !score of !max"
FONT FuturaB.font 16
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
TEXT 188 71 ""
TEXT 380 71 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 304 258 418 279  GOTO "Lytton Police department"
SELECT replace 0 1 2 3 4 5 6 7 8 9 11 10 12 13 14 15
BUTTON position 196 194 240 255  GOTO "Sonny's office"
BUTTON position 490 194 524 252  GOTO "Briefing room"
SELECT replace 0 1 2 3 4 5 6 7 8 8 10 11 12 13 15 14
BUTTON position 384 195 442 255  IF casefile=1 GOTO "Corridor - Talk to Keith #1"  IF 1=1 GOTO "Generic - Not yet"
SELECT replace 0 1 2 3 6 5 6 7 8 8 10 11 12 13 14 15
BUTTON position 256 185 315 220  IF board=0 GOTO "Corridor - Examine bulletin board"  IF 1=1 GOTO "Generic - You can't"
PAUSE -1
END

EVENT "Briefing room"
PICTURE "LEFTYS:briefingroom.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 7 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 17 
TEXTWIPE dump speed 1
BRUSH 408 197 "LEFTYS:sonny.iff"
FONT FuturaB.font 16
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 17 
TEXT 24 10 "Briefing room"
ATTRIBUTES edge 
TEXT 22 27 "A windowless room with flourescent lightning illuminates a large table "
TEXT 22 45 "covered with case files and a projector screen showing crime statistics. "
FONT FuturaB.font 12
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
TEXT 598 255 "Money: $!money"
TEXT 598 269 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 11 10 12 13 14 15
BUTTON position 192 195 242 250  GOTO Corridor
SELECT replace 0 1 2 3 4 5 6 7 8 8 10 11 12 13 15 15
BUTTON position 400 194 458 255  IF casefile=0 GOTO "Briefing room - Talk to Dooley #1"  IF 1=1 GOTO "Generic - You can't"
PAUSE -1
END

EVENT "Sonny's office"
PICTURE "LEFTYS:office.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 16
COLOR 1 4 7 7 7 15 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 17 
TEXTWIPE dump speed 1
TEXT 24 10 "Sonny's office"
ATTRIBUTES edge 
TEXT 22 27 "Your small but organized office contains a desk covered with "
TEXT 22 45 "paperwork, filing cabinets, and a window overlooking the parking lot."
TEXT 22 63 "A photo of the police academy graduation hangs on the wall. "
FONT FuturaB.font 12
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
TEXT 598 255 "Money: $!money"
TEXT 598 269 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 11 10 12 13 14 15
BUTTON position 492 196 526 253  GOTO Corridor
BUTTON position 302 224 434 246  GOTO "Sonny's office - Examine desk"
PAUSE -1
END

EVENT Sidewalk
PICTURE "LEFTYS:sidewalk.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 16
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 17 
TEXTWIPE dump speed 1
TEXT 24 10 "Sidewalk"
ATTRIBUTES edge 
TEXT 22 27 "The neon sign of Lefty's Bar flickers erratically, casting eerie shadows on the"
TEXT 22 45 "cracked sidewalk. Through the smudged windows, you can see the dim outline "
TEXT 22 63 "of patrons nursing their drinks in the smokey interior."
FONT FuturaB.font 12
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
TEXT 598 255 "Money: $!money"
TEXT 598 269 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 8 10 11 12 13 14 15
BUTTON position 278 164 412 230  GOTO Bar
SELECT replace 0 1 2 3 4 5 6 7 9 8 10 11 12 13 15 14
BUTTON position 634 150 723 249  GOTO Alley
SELECT replace 0 1 2 3 4 5 6 3 8 8 10 10 12 13 14 15
BUTTON position 206 180 252 207  GOTO "Sidewalk - Examine taxi sign"
SELECT replace 0 14 2 3 4 5 6 7 8 8 10 11 12 13 1 15
BUTTON position 284 128 464 160  GOTO "Sidewalk - Examine bar sign"
BUTTON position 446 168 600 210  GOTO "Sidewalk - Examine windows"
SELECT replace 0 2 2 3 4 5 6 7 8 8 10 11 13 13 14 15
BUTTON position 484 90 554 124  GOTO "Generic - Nothing of interest"
SELECT replace 0 2 2 3 4 5 6 7 8 9 11 11 12 13 14 15
BUTTON position 310 90 382 125  GOTO "Generic - Nothing of interest"
SELECT replace 0 2 2 3 4 5 6 7 8 9 10 11 12 13 15 15
BUTTON position 140 89 214 126  GOTO "Generic - Nothing of interest"
SELECT replace 15 1 2 3 4 5 6 6 8 8 10 11 12 13 15 14
BUTTON position 30 148 90 231  GOTO "Sidewalk - Examine dark alley"
PAUSE -1
END

EVENT Alley
PICTURE "LEFTYS:alley.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 7 7 7 7 15 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 17 
TEXTWIPE dump speed 1
BRUSH 506 185 "LEFTYS:larry.iff"
FONT FuturaB.font 16
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 17 
TEXT 24 10 "Alley"
ATTRIBUTES edge 
TEXT 22 27 "The narrow alley behind Lefty's Bar reeks of stale beer and broken dreams. "
TEXT 22 45 "A dented trash can sits beneath a grimy window, while discarded bottles crunch "
TEXT 22 63 "under your feet."
FONT FuturaB.font 12
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
TEXT 598 255 "Money: $!money"
TEXT 598 269 "Score: !score of !max"
FONT FuturaB.font 16
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
TEXT 180 86 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 15 1 2 3 4 5 6 6 8 9 10 11 12 13 14 0
BUTTON position 30 145 104 245  GOTO Sidewalk
SELECT replace 15 1 2 3 4 5 6 6 8 9 10 11 12 13 15 0
BUTTON position 166 181 304 234  IF hammer=0 GOTO "Alley - Examine dumpster #1"  IF 1=1 GOTO "Alley - Examine dumpster #2"
SELECT replace 15 1 2 3 4 5 6 6 8 9 10 11 12 13 15 15
BUTTON position 202 87 280 128  GOTO "Alley - Examine top window"
BUTTON position 388 88 462 130  GOTO "Alley - Examine top window"
SELECT replace 15 3 2 3 4 5 6 6 8 9 10 11 12 13 14 0
BUTTON position 500 181 550 243  IF act=4 GOTO "Alley - Talk to Larry #2"  IF 1=1 GOTO "Alley - Talk to Larry #1"
SELECT replace 15 1 2 3 4 5 6 6 8 9 10 11 12 13 15 15
BUTTON position 384 163 470 207  IF hammer=0 GOTO "Alley - Examine lower window"  IF pills=0 GOTO "Alley - Smash window"  IF 1=1 GOTO "Generic - Nothing of interest"
PAUSE -1
END

EVENT Bar
PICTURE "LEFTYS:bar.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 16
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 17 
TEXTWIPE dump speed 1
TEXT 24 10 "Bar"
ATTRIBUTES edge 
TEXT 22 27 "Cigarette smoke hangs thick in the air as a motley crew of regulars hunches over "
TEXT 22 45 "their drinks at scarred wooden tables. Behind the bar, Lefty wipes down glasses "
TEXT 22 63 "with a dirty rag, his eyes constantly scanning the room like a nervous predator."
FONT FuturaB.font 12
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
TEXT 598 255 "Money: $!money"
TEXT 598 269 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 13 12 14 15
BUTTON position 190 172 238 206  IF woman=2 GOTO "Hallway - With Roger"  IF 1=1 GOTO Hallway
SELECT replace 0 1 2 3 4 5 6 7 8 8 10 11 13 12 14 15
BUTTON position 588 178 618 235  IF stairs=1 GOTO Backroom  IF password=2 GOTO "Backroom - Blocked stairs"  IF password=1&sally=1&others=1&ring=1&act=2 GOTO "Chapter 3"  IF password=1 GOTO "Bar - Open door"  IF 1=1 GOTO "Bar - Examine door"
SELECT replace 0 1 2 3 4 5 6 6 8 9 10 11 13 12 14 15
BUTTON position 276 250 446 281  GOTO Sidewalk
SELECT replace 15 7 2 3 4 5 6 1 8 9 10 11 13 12 14 0
BUTTON position 122 188 172 226  GOTO "Bar - Examine jukebox"
SELECT replace 14 1 2 5 4 3 6 7 8 9 10 11 13 12 0 15
BUTTON position 484 166 520 192  IF act=5 GOTO "Bar - Talk to Lefty #2"  IF 1=1 GOTO "Bar - Talk to Lefty #1"
PAUSE -1
END

EVENT Hallway
PICTURE "LEFTYS:hallway.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 16
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 17 
TEXTWIPE dump speed 1
TEXT 24 10 "Hallway"
ATTRIBUTES edge 
TEXT 22 27 "A dimly lit corridor stretches between the bar and back rooms, its peeling wallpaper"
TEXT 22 45 "decorated with faded photographs of forgotten local celebrities. The floorboards "
TEXT 22 63 "creak ominously with each step, as if the building itself is whispering secrets."
FONT FuturaB.font 12
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
TEXT 598 255 "Money: $!money"
TEXT 598 269 "Score: !score of !max"
FONT FuturaB.font 16
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
TEXT 132 91 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 6 8 9 10 11 12 12 14 15
BUTTON position 272 249 442 282  GOTO Bar
SELECT replace 0 1 2 3 4 5 6 6 8 8 10 11 12 12 14 15
BUTTON position 500 176 532 235  GOTO Bathroom
SELECT replace 0 7 2 3 4 5 6 1 8 9 10 11 12 12 14 15
BUTTON position 440 188 500 225  IF remote=0&whiskey=1 GOTO "Hallway - Give whiskey"  IF whiskey=0 GOTO "Hallway - Talk to drunk #1"  IF 1=1 GOTO "Hallway - Talk to drunk #2"
BUTTON position 212 199 258 227  IF rose=0 GOTO "Hallway - Take rose"  IF 1=1 GOTO "Hallway - Examine table"
PAUSE -1
END

EVENT "Hallway - With Roger"
PICTURE "LEFTYS:hallway.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 7 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 17 
TEXTWIPE dump speed 1
BRUSH 284 170 "LEFTYS:roger.iff"
FONT FuturaB.font 16
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 17 
TEXT 24 10 "Hallway"
ATTRIBUTES edge 
TEXT 22 27 "A dimly lit corridor stretches between the bar and back rooms, its peeling wallpaper"
TEXT 22 45 "decorated with faded photographs of forgotten local celebrities. The floorboards "
TEXT 22 63 "creak ominously with each step, as if the building itself is whispering secrets."
FONT FuturaB.font 12
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
TEXT 598 255 "Money: $!money"
TEXT 598 269 "Score: !score of !max"
FONT FuturaB.font 16
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
TEXT 132 91 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 6 8 9 10 11 12 12 14 15
BUTTON position 272 249 442 282  GOTO Bar
SELECT replace 0 1 2 3 4 5 6 6 8 8 10 11 12 12 14 15
BUTTON position 500 176 532 235  GOTO Bathroom
SELECT replace 0 7 2 3 4 5 6 1 8 9 10 11 12 12 14 15
BUTTON position 440 188 500 225  GOTO "Hallway - Talk to drunk #2"
BUTTON position 212 199 258 227  IF rose=0 GOTO "Hallway - Take rose"  IF 1=1 GOTO "Hallway - Examine table"
SELECT replace 0 5 2 3 4 1 6 7 8 9 10 11 12 13 14 15
BUTTON position 278 166 330 227  IF roger=1&ring=2&candy=1&notebook=1&letter=1 GOTO "Hallway - Talk to Roger #2"  IF 1=1 GOTO "Hallway - Talk to Roger #1"
PAUSE -1
END

EVENT Bathroom
PICTURE "LEFTYS:bathroom.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 16
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 17 
TEXTWIPE dump speed 1
TEXT 24 10 "Bathroom"
ATTRIBUTES edge 
TEXT 22 27 "The cramped bathroom smells of cheap disinfectant that barely masks more "
TEXT 22 45 "unpleasant odors. Graffiti covers the walls like a chaotic diary of the bar's seedier "
TEXT 22 63 "patrons, while a single bare bulb casts harsh shadows over the cracked  mirror."
FONT FuturaB.font 12
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
TEXT 598 255 "Money: $!money"
TEXT 598 269 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 8 10 11 12 13 14 15
BUTTON position 204 197 240 252  IF act=3&notebook=1&letter=1 GOTO "Chapter 4"  IF woman=2 GOTO "Hallway - With Roger"  IF 1=1 GOTO Hallway
SELECT replace 0 5 2 3 4 1 6 7 8 8 10 11 12 13 14 15
BUTTON position 500 205 550 240  IF ring=1&tooth=0 GOTO "Bathroom - Find tooth"  IF ring=0 GOTO "Bathroom - Find ring"  IF 1=1 GOTO "Bathroom - Examine sink"
SELECT replace 0 3 2 1 4 5 6 7 8 8 10 11 12 13 14 15
BUTTON position 322 195 414 241  IF roger=1&woman=2&notebook=0 GOTO "Bathroom - Examine toilet #2"  IF 1=1 GOTO "Bathroom - Examine toilet #1"
SELECT replace 0 7 2 3 4 5 6 1 8 8 10 11 12 13 14 15
BUTTON position 464 176 518 203  IF password=0 GOTO "Bathroom - Examine wall #1"  IF 1=1 GOTO "Bathroom - Examine wall #2"
SELECT replace 0 1 2 3 4 5 6 1 8 8 10 11 12 13 14 15
BUTTON position 190 170 248 196  GOTO "Bathroom - Examine wall #3"
PAUSE -1
END

EVENT "Backroom - Blocked stairs"
PICTURE "LEFTYS:backroom.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 7 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 17 
TEXTWIPE dump speed 1
BRUSH 445 177 "LEFTYS:dude.iff"
FONT FuturaB.font 16
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 17 
TEXT 24 10 "Backroom"
ATTRIBUTES edge 
TEXT 22 27 "Lefty's private office doubles as a storage room, with boxes of liquor stacked "
TEXT 22 45 "against wood-paneled walls. A flickering TV sits in the corner while a burly guard "
TEXT 22 63 "blocks the stairway to the upper floor, his arms crossed menacingly."
FONT FuturaB.font 12
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
TEXT 598 255 "Money: $!money"
TEXT 598 269 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 8 10 11 12 13 14 15
BUTTON position 188 179 226 235  GOTO Bar
SELECT replace 0 7 2 3 4 5 6 6 9 8 10 11 12 13 14 15
BUTTON position 436 175 502 235  GOTO "Backroom - Talk to guard"
SELECT replace 0 1 2 3 4 5 6 9 7 7 10 11 12 13 14 15
BUTTON position 338 225 392 249  IF remote=1 GOTO "Backroom - Examine TV #2"  IF 1=1 GOTO "Backroom - Examine TV #1"
SELECT replace 0 1 2 3 4 5 6 7 8 8 10 11 12 13 14 15
BUTTON position 510 170 544 209  GOTO "Backroom - Examine window"
SELECT replace 0 1 2 3 4 5 6 7 10 9 8 11 12 13 14 15
BUTTON position 242 189 278 215  GOTO "Backroom - Examine boxes"
PAUSE -1
END

EVENT Backroom
PICTURE "LEFTYS:backroom.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 7 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 17 
TEXTWIPE dump speed 1
BRUSH 383 191 "LEFTYS:dude.iff"
FONT FuturaB.font 16
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 17 
TEXT 24 10 "Backroom"
ATTRIBUTES edge 
TEXT 22 27 "Lefty's private office doubles as a storage room, with boxes of liquor stacked "
TEXT 22 45 "against wood-paneled walls. A flickering TV sits in the corner while a burly guard "
TEXT 22 63 "blocks the stairway to the upper floor, his arms crossed menacingly."
FONT FuturaB.font 12
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
TEXT 598 255 "Money: $!money"
TEXT 598 269 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 8 10 11 12 13 14 15
BUTTON position 188 179 226 235  GOTO Bar
SELECT replace 0 7 2 3 4 5 6 6 9 8 10 11 12 13 14 15
BUTTON position 436 175 502 235  GOTO Bedroom
SELECT replace 0 1 2 3 4 5 6 9 7 7 10 11 12 13 14 15
BUTTON position 338 189 430 249  GOTO "Backroom - Examine TV #3"
SELECT replace 0 1 2 3 4 5 6 7 8 8 10 11 12 13 14 15
BUTTON position 510 170 544 209  GOTO "Backroom - Examine window"
SELECT replace 0 1 2 3 4 5 6 7 10 9 8 11 12 13 14 15
BUTTON position 238 190 280 215  GOTO "Backroom - Examine boxes"
PAUSE -1
END

EVENT Bedroom
PICTURE "LEFTYS:bedroom.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 7 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 17 
TEXTWIPE dump speed 1
BRUSH 216 202 "LEFTYS:girl1.iff"
FONT FuturaB.font 16
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 17 
TEXT 24 10 "Bedroom"
ATTRIBUTES edge 
TEXT 22 27 "The upstairs room serves as Lefty's private quarters, furnished with a rumpled bed "
TEXT 22 45 "and a small table laden with suspicious trinkets. A dirty window overlooks the alley "
TEXT 22 63 "below, offering both a view of the street and a potential escape route."
FONT FuturaB.font 12
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
TEXT 598 255 "Money: $!money"
TEXT 598 269 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 6 6 7 9 8 10 11 12 13 15 15
BUTTON position 284 186 444 212  GOTO Backroom
SELECT replace 15 1 2 3 4 5 6 1 9 8 10 11 12 13 14 15
BUTTON position 502 169 544 209  GOTO "Bedroom - Examine window"
SELECT replace 0 1 2 3 4 6 6 7 9 8 10 11 12 13 15 15
BUTTON position 206 199 266 257  GOTO "Bedroom - Talk to woman"
BUTTON position 488 212 544 250  IF candy=0 GOTO "Bedroom - Find candy"  IF 1=1 GOTO "Generic - Nothing of interest"
PAUSE -1
END

EVENT "Chapter 1"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 21 696 257
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 70 33 "Chapter 1 - Briefing"
ATTRIBUTES edge 
TEXT 70 49 ""
TEXT 70 65 "It's been a quiet month until the missing persons reports started coming in. "
TEXT 70 81 "Three people, all last seen at the same seedy dive bar in Lost Wages. "
TEXT 70 97 "As a detective, you know that coincidences like this usually aren't"
TEXT 70 113 "coincidences at all."
TEXT 70 129 ""
TEXT 70 145 "Your name is Sonny Bonds, and you've been a cop long enough to "
TEXT 70 161 "recognize when something doesn't smell right. Tonight, you're going to"
TEXT 70 177 "find out what's really happening at Lefty's Bar - and why people who go"
TEXT 70 193 "there seem to have a habit of disappearing."
TEXT 70 209 ""
TEXT 70 225 "Little do you know that someone has been waiting for you to take this case."
TEXT 70 241 "Someone with a very long memory and an old score to settle. "
TEXT 70 257 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position -2 0 728 284  GOTO "Lytton Police department"
PAUSE -1
END

EVENT "Chapter 2"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 21 696 257
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 70 33 "Chapter 2 - Taking the bait"
ATTRIBUTES edge 
TEXT 70 49 ""
TEXT 70 65 "You drive through the darkening streets of the city, rain beginning"
TEXT 70 81 "to spatter the windshield. The neon lights of Lefty's Bar flicker in the"
TEXT 70 97 "distance like a beacon in the night."
TEXT 70 113 ""
COLOR 9 2 7 7 7 0 9 7 0 9 8 8 9 8 9
TEXT 70 129 "- \"\Time to see what secrets that dive bar is hiding,\"\ "
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
TEXT 500 128 "you mutter, grabbing"
TEXT 72 146 "your badge and notepad."
TEXT 72 162 ""
TEXT 72 178 "You step out into the wet night... "
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position -2 0 728 284  SET act 2  SET score score+5  GOTO Sidewalk
PAUSE -1
END

EVENT "Chapter 3"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 21 696 257
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 70 33 "Chapter 3 - The trap tightens"
ATTRIBUTES edge 
TEXT 70 65 "The pieces are starting to come together. The graffiti, the ring, "
TEXT 70 81 "the nervous bartender - something's definitely not right at Lefty's."
TEXT 70 97 ""
TEXT 70 113 "You've learned the password to get into the back room. Time to dig "
TEXT 70 129 "deeper and see what Lefty's really hiding behind that locked door."
TEXT 70 145 ""
TEXT 70 161 "As a cop, you know when to follow procedure... and when to bend "
TEXT 70 177 "the rules to get results."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 22 0 723 280  SET act 3  SET score score+5 RETURN
PAUSE -1
END

EVENT "Chapter 4"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 21 696 257
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 70 33 "Chapter 4 - Truth and deception"
ATTRIBUTES edge 
TEXT 70 65 "You're in deep now. The back room, the guard, the mysterious "
TEXT 70 81 "upstairs - this is bigger than just missing persons."
TEXT 70 97 ""
TEXT 70 113 "Every good cop knows that solid evidence makes or breaks a case. "
TEXT 70 129 "Time to find the proof you need to bring down whatever operation "
TEXT 70 145 "Lefty's running."
TEXT 70 161 ""
TEXT 70 177 "But you'll have to be careful. One wrong move and you could blow "
TEXT 70 193 "the whole investigation..."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET act 4  SET score score+5  GOTO "Hallway - With Roger"
PAUSE -1
END

EVENT "Chapter 5"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 21 696 257
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 70 33 "Chapter 5 - Death angel's gambit"
ATTRIBUTES edge 
TEXT 70 65 "All the pieces of the puzzle are in place. The ring, the notebook, "
TEXT 70 81 "the testimonies - you have everything you need."
TEXT 70 97 ""
TEXT 70 113 "Time to confront Lefty and put an end to his criminal enterprise once "
TEXT 70 129 "and for all."
TEXT 70 145 ""
TEXT 70 161 "This is what police work is all about - protecting the innocent and bringing "
TEXT 70 177 "justice to those who prey on others."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET act 5  SET score score+5  GOTO "Alley - Talk to Larry #2"
PAUSE -1
END

EVENT "Corridor - Examine bulletin board"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "The bulletin board shows typical police station chaos - schedules,"
ATTRIBUTES edge 
TEXT 62 109 "memos, and wanted posters. An urgent notice about escaped"
TEXT 62 125 "prisoners catches your eye, with one photo partially torn away."
TEXT 62 141 "You can still make out facial scars and the initials \"\JB\"\. "
TEXT 62 157 "Jessie Bains has escaped from prison three weeks ago."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET board 1  SET score score+2 RETURN
PAUSE -1
END

EVENT "Corridor - Talk to Keith #1"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 38 77 690 198
COLOR 1 7 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES shadow edge 
STYLE 0 3 4 3 6 1 1 29 
BOX 480 160 670 190
BOX 50 160 240 190
FONT FuturaB.font 16
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "- Hey Sonny! Working late again? I heard Dooley pulled you in for that"
ATTRIBUTES edge 
TEXT 62 109 "missing persons case. Three people from the same bar - that's got to be"
TEXT 62 125 "more than a coincidence, right? "
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
ATTRIBUTES edge remap 
TEXT 70 170 "Ask about case"
TEXT 548 170 "Exit"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 3 2 1 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 50 159 244 194  IF keith=0 GOTO "Corridor - Talk to Keith #2"  IF 1=1 GOTO "Generic - You can't"
BUTTON position 478 159 670 194 RETURN
BUTTON position 57 91 218 109  IF keith=0 GOTO "Corridor - Talk to Keith #2"  IF 1=1 GOTO "Generic - You can't"
PAUSE -1
END

EVENT "Corridor - Talk to Keith #2"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "You ask him about his thoughts about the case."
ATTRIBUTES edge 
TEXT 62 109 ""
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
TEXT 62 125 "- I've been thinking about those disappearances. Lefty's Bar has"
TEXT 62 141 "always been sketchy, but people vanishing? That's a whole"
TEXT 62 157 "different level of trouble."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET keith 1  SET score score+3 RETURN
PAUSE -1
END

EVENT "Sonny's office - Examine desk"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 38 77 690 198
COLOR 1 7 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES shadow edge 
STYLE 0 3 4 3 6 1 1 29 
BOX 265 160 455 190
BOX 480 160 670 190
BOX 50 160 240 190
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "Your desk reflects three years of detective work - organized chaos with "
ATTRIBUTES edge 
TEXT 62 109 "everything having its place. Coffee rings mark the wood where countless"
TEXT 62 125 "late-night case reviews have taken place. "
ATTRIBUTES edge remap 
TEXT 70 170 "Check voicemail"
TEXT 278 170 "Take equipment"
TEXT 548 170 "Exit"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 3 2 1 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 50 159 244 194  IF voicemail=0 GOTO "Sonny's office - Check voicemail"  IF 1=1 GOTO "Generic - You can't"
BUTTON position 264 159 464 193  IF equipment=0 GOTO "Sonny's office - Take equipment"  IF 1=1 GOTO "Generic - You can't"
BUTTON position 478 159 670 194 RETURN
PAUSE -1
END

EVENT "Sonny's office - Check voicemail"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "The machine click and a woman's worried voice fills the smalloffice. "
ATTRIBUTES edge 
TEXT 62 109 "Marie Thompson explains that her sister Sally has been missing for eight "
TEXT 62 125 "days - completely out of character for someone who calls regularly. Her "
TEXT 62 141 "voice breaks as she pleads for help, saying Sally is all the family she has left. "
TEXT 62 157 ""
TEXT 62 173 "The desperation in her tone makes it clear this isn't just routine. "
TEXT 62 189 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET voicemail 1  SET score score+3 RETURN
PAUSE -1
END

EVENT "Sonny's office - Take equipment"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "You gather your essential gear: "
ATTRIBUTES edge 
TEXT 62 109 "badge #1324, standard-issue handcuffs, evidence bags for proper "
TEXT 62 125 "documentation, and your notepad for recording observations. "
TEXT 62 141 ""
TEXT 62 157 "After locking sensitive files in your desk drawer, you're ready for tonight's "
TEXT 62 173 "investigation at Lefty's Bar."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET equipment 1  SET score score+3 RETURN
PAUSE -1
END

EVENT "Briefing room - Talk to Dooley #1"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 38 77 690 198
COLOR 1 7 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES shadow edge 
STYLE 0 3 4 3 6 1 1 29 
BOX 480 160 670 190
BOX 50 160 240 190
FONT FuturaB.font 16
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "- Bonds! About time you got here. We've got a situation that's starting"
ATTRIBUTES edge 
TEXT 62 109 "to smell like trouble. Three missing persons, all connected to the same dive"
TEXT 62 125 "bar. Could be coincidence, could be something worse. "
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
ATTRIBUTES edge remap 
TEXT 70 170 "Ask about case"
TEXT 548 170 "Exit"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 3 2 1 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 50 159 244 194  IF casefile=0 GOTO "Briefing room - Ask about case"  IF 1=1 GOTO "Generic - You can't"
BUTTON position 478 159 670 194 RETURN
PAUSE -1
END

EVENT "Briefing room - Ask about case"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "- Here's what we know. Three separate individuals, all disappeared over "
ATTRIBUTES edge 
TEXT 62 109 "the past two months. Only connection is ther were all last seen at "
TEXT 62 125 "Lefty's Bar in Lost Wages."
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
TEXT 62 141 ""
TEXT 62 157 "He hands you the case files."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET casefile 1  SET score score+3  GOTO "Briefing room"
PAUSE -1
END

EVENT "Sidewalk - Examine taxi sign"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "A sad excuse for a taxi sign dangles from a bent pole like a"
ATTRIBUTES edge 
TEXT 62 109 "defeated flag. The irony isn't lost on you - in this neighborhood even the "
TEXT 62 125 "taxis have given up."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280 RETURN
PAUSE -1
END

EVENT "Sidewalk - Examine bar sign"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "The L in Lefty's keeps flickering. This place has seen better days."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280 RETURN
PAUSE -1
END

EVENT "Sidewalk - Examine windows"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "Too grimy to see much detail, but I can make out several figures"
ATTRIBUTES edge 
TEXT 62 109 "inside."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280 RETURN
PAUSE -1
END

EVENT "Sidewalk - Examine dark alley"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "The alley looks dark, empty and hostile... You parked your squad car here."
TEXT 62 109 "Hopefully it will be there when you need it... hopefully..."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280 RETURN
PAUSE -1
END

EVENT "Hallway - Talk to drunk #1"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 38 77 690 198
COLOR 1 7 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES shadow edge 
STYLE 0 3 4 3 6 1 1 29 
BOX 265 160 455 190
BOX 480 160 670 190
BOX 50 160 240 190
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "A grizzled drunk in tattered clothes sits propped against the wall,"
ATTRIBUTES edge 
TEXT 62 109 "clutching an empty bottle lika a lifeline. Despite his condition, his"
TEXT 62 125 "eyes hold a sharp intelligence that suggests he notices more than"
TEXT 62 141 "people think."
ATTRIBUTES edge remap 
TEXT 70 170 "Show your badge"
TEXT 279 170 "Ask about upstairs"
TEXT 548 170 "Exit"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 3 2 1 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 50 159 244 194  IF drunk=0 GOTO "Hallway - Show badge #1"  IF 1=1 GOTO "Generic - You can't"
BUTTON position 264 159 464 193  IF drunk=1 GOTO "Hallway - Ask about upstairs"  IF 1=1 GOTO "Generic - You can't"
BUTTON position 478 159 670 194 RETURN
PAUSE -1
END

EVENT "Hallway - Talk to drunk #2"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "A grizzled drunk in tattered clothes sits propped against the wall,"
ATTRIBUTES edge 
TEXT 62 109 "clutching an empty bottle lika a lifeline. Despite his condition, his"
TEXT 62 125 "eyes hold a sharp intelligence that suggests he notices more than"
TEXT 62 141 "people think."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280 RETURN
PAUSE -1
END

EVENT "Hallway - Show badge #1"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 33 696 170
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 60 49 "You show him your badge."
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
ATTRIBUTES edge 
TEXT 60 65 ""
TEXT 60 81 "- Hey... hey officer... hiccup I seen things man. Weird things happening "
TEXT 60 97 "upstairs. "
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
TEXT 60 113 ""
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
TEXT 60 145 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET drunk 1  SET score score+1 RETURN
PAUSE -1
END

EVENT "Hallway - Ask about upstairs"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 33 696 254
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 49 "You ask him about upstairs."
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
TEXT 60 145 ""
TEXT 62 77 "- Can't get up there without gettin' past the big guy in the backroom. But I "
TEXT 62 93 "got somethin' that might help ya..."
TEXT 62 109 ""
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
TEXT 62 125 "He taps his jacket pocket."
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
TEXT 62 141 ""
TEXT 62 157 "- Nah, my throat's too dry to remember where I put it. One little whiskey"
TEXT 62 173 "and my memory might come back, ya know. "
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
TEXT 30 142 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET drunk 2  SET score score+2 RETURN
PAUSE -1
END

EVENT "Hallway - Give whiskey"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "You give him the whiskey and his eyes light up. "
ATTRIBUTES edge 
TEXT 62 109 ""
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
TEXT 62 125 "-Oh bless ya, officer. Ahhh, that's the stuff. Now where did I put that thing? "
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
TEXT 62 141 ""
TEXT 62 157 "He fumbles in jacket a brief moment and pulls out an old TV-remote."
TEXT 62 173 "You take it and put it in your pocket."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET remote 1  SET score score+3 RETURN
PAUSE -1
END

EVENT "Hallway - Take rose"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "It's a small table with some red roses laying on top of it. "
ATTRIBUTES edge 
TEXT 62 109 ""
TEXT 62 125 "You pick one and put it in your pocket."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET rose 1  SET score score+1 RETURN
PAUSE -1
END

EVENT "Hallway - Examine table"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "It's a small table with some red roses laying on top of it. You already "
ATTRIBUTES edge 
TEXT 62 109 "have a rose so you leave them alone."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280 RETURN
PAUSE -1
END

EVENT "Hallway - Talk to Roger #1"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 38 77 690 198
COLOR 1 7 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES shadow edge 
STYLE 0 3 4 3 6 1 1 29 
BOX 265 160 455 190
BOX 480 160 670 190
BOX 50 160 240 190
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "A nervous, slightly dishelved man in his thirties pushes a janitor's cart with "
ATTRIBUTES edge 
TEXT 62 109 "the dedication of someone who takes his cleaning duties very seriously. "
TEXT 62 125 "His jumpsuit bears various mysterious stains, and his constantly darting "
TEXT 62 141 "eyes suggests he's perpetually expecting an alien invasion.   "
ATTRIBUTES edge remap 
TEXT 70 170 "Show your badge"
TEXT 278 170 "Show ring"
TEXT 548 170 "Exit"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 3 2 1 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 50 159 244 194  IF roger=0 GOTO "Hallway - Show badge #2"  IF 1=1 GOTO "Generic - You can't"
BUTTON position 264 159 464 193  IF ring=1 GOTO "Hallway - Show ring"  IF 1=1 GOTO "Generic - You can't"
BUTTON position 478 159 670 194 RETURN
PAUSE -1
END

EVENT "Hallway - Talk to Roger #2"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 38 77 690 198
COLOR 1 7 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES shadow edge 
STYLE 0 3 4 3 6 1 1 29 
BOX 265 160 455 190
BOX 480 160 670 190
BOX 50 160 240 190
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "A nervous, slightly dishelved man in his thirties pushes a janitor's cart with "
ATTRIBUTES edge 
TEXT 62 109 "the dedication of someone who takes his cleaning duties very seriously. "
TEXT 62 125 "His jumpsuit bears various mysterious stains, and his constantly darting "
TEXT 62 141 "eyes suggests he's perpetually expecting an alien invasion.   "
ATTRIBUTES edge remap 
TEXT 70 170 "Ask about others"
TEXT 278 170 "Ask about police"
TEXT 548 170 "Exit"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 3 2 1 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 50 159 244 194  IF others=1 GOTO "Hallway - Ask about others"  IF 1=1 GOTO "Generic - You can't"
BUTTON position 264 159 464 193  IF police=0 GOTO "Hallway - Ask about police"  IF 1=1 GOTO "Generic - You can't"
BUTTON position 478 159 670 194 RETURN
PAUSE -1
END

EVENT "Hallway - Show badge #2"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "You show him your badge."
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
ATTRIBUTES edge 
TEXT 62 109 ""
TEXT 62 125 "- Oh! A fellow officer! Name's Roger Wilco, Interplanetary"
TEXT 62 141 "Sanitation Engineer."
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
TEXT 62 157 ""
ATTRIBUTES edge remap 
TEXT 84 151 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET roger 1  SET score score+2 RETURN
PAUSE -1
END

EVENT "Hallway - Ask about others"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX -12 80 640 218
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "You ask about the other girls."
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
ATTRIBUTES edge 
TEXT 62 109 ""
TEXT 62 125 "- There's usually four or five girls working here at any time. When"
TEXT 62 141 "one leaves or... disappears... Lefty finds a replacement real"
TEXT 62 157 "quick."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET roger 1  SET score score+2  SET others 2 RETURN
PAUSE -1
END

EVENT "Hallway - Ask about police"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 226
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "You ask about the police."
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
ATTRIBUTES edge 
TEXT 62 109 ""
TEXT 62 125 "- You're not the first cop to sniff around, but others got discouraged"
TEXT 62 141 "real fast. Lefty's got connections, if you know what I mean."
TEXT 62 173 "- That scary guy with scars visited last month. Kept saying"
TEXT 62 189 "something about 'remembering Lytton' and 'payback time'."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET roger 1  SET score score+2  SET police 1 RETURN
PAUSE -1
END

EVENT "Hallway - Show ring"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 265
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "You show him the ring."
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
ATTRIBUTES edge 
TEXT 62 125 "- Holy cosmos! That's Sally's ring! She probably dropped it last week when "
TEXT 62 141 "she came running through here. She never seem scared like the "
TEXT 62 157 "other girls. Always clam, watching, taking notes."
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
TEXT 62 189 "You ask him about Sally."
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
TEXT 62 221 "- Sweet girl, always tipped me when I cleaned the bar area. But last week "
TEXT 62 237 "she came tearing through here like the star generator was gonna blow. "
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET ring 2  SET score score+2 RETURN
PAUSE -1
END

EVENT "Alley - Examine dumpster #1"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "Standard issue dumpster. You notice a rusty hammer half-buried under "
ATTRIBUTES edge 
TEXT 62 109 "some newspapers. "
TEXT 62 125 ""
TEXT 62 141 "You pick it up and put it in your pocket."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET hammer 1  SET score score+2 RETURN
PAUSE -1
END

EVENT "Alley - Examine dumpster #2"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "Standard issue dumpster. You find nothing of interest in the trash."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280 RETURN
PAUSE -1
END

EVENT "Alley - Talk to Larry #1"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 38 77 690 198
COLOR 1 7 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES shadow edge 
STYLE 0 3 4 3 6 1 1 29 
BOX 265 160 455 190
BOX 480 160 670 190
BOX 50 160 240 190
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "A middle-aged man in an ill-fitting polyester leisure suit sits"
ATTRIBUTES edge 
TEXT 62 109 "dejectedly on a wooden crate,  his thinning hair combed over in a"
TEXT 62 125 "futile attempt to hide his baldness."
TEXT 70 170 "Show your badge"
TEXT 278 170 "Ask about Sally"
ATTRIBUTES edge remap 
TEXT 548 170 "Exit"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 3 2 1 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 50 159 246 194  IF larry=0 GOTO "Alley - Show badge"  IF 1=1 GOTO "Generic - You can't"
BUTTON position 478 157 678 194  GOTO Alley
BUTTON position 266 157 452 194  IF larry=1 GOTO "Alley - Ask about Sally #1"  IF 1=1 GOTO "Generic - You can't"
PAUSE -1
END

EVENT "Alley - Show badge"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 38 77 690 262
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "You show him your badge."
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
ATTRIBUTES edge 
TEXT 62 109 ""
TEXT 62 125 "- Oh, hey there officer! Larry Laffer's the name, love's the game!"
TEXT 62 141 "Well, it WOULD be if I wasn't banned from that joint."
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
TEXT 62 157 ""
TEXT 62 173 "You ask Larry about the ban."
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
TEXT 62 189 ""
TEXT 62 205 "- I was just trying to show Sally my... appreciation. Lefty didn't  like"
TEXT 62 221 "my approach. Said I was 'bothering the merchandise'. What's that"
TEXT 62 237 "supposed to mean?"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET larry 1  GOTO "Alley - Talk to Larry #1"
PAUSE -1
END

EVENT "Alley - Ask about Sally #1"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 38 77 690 265
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "You ask Larry about Sally."
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
ATTRIBUTES edge 
TEXT 62 109 ""
TEXT 62 125 "- Sally's this gorgeous waitress. Haven't seen her in a week though. She "
TEXT 62 141 "used to serve me my usual - a Sex on the beach. Get it?"
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
TEXT 62 157 ""
TEXT 62 173 "You ask Larry about missing people."
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
TEXT 62 189 ""
TEXT 62 205 "- Yeah, I've noticed some regulars disappearing. Thought maybe they "
TEXT 62 221 "found better bars. But three people? That's weird even for this "
TEXT 62 237 "neighborhood."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET larry 2  SET score score+2  GOTO "Alley - Talk to Larry #1"
PAUSE -1
END

EVENT "Alley - Talk to Larry #2"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 38 77 690 198
COLOR 1 7 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES shadow edge 
STYLE 0 3 4 3 6 1 1 29 
BOX 265 160 455 190
BOX 480 160 670 190
BOX 50 160 240 190
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "Larry is still standing in the alley minding his own business. As"
ATTRIBUTES edge 
TEXT 62 109 "usual. "
TEXT 70 170 "Ask about Sally"
TEXT 278 170 "Ask about others"
ATTRIBUTES edge remap 
TEXT 548 170 "Exit"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 3 2 1 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 50 159 246 194  IF sally=2 GOTO "Alley - Ask about Sally #2"  IF 1=1 GOTO "Generic - You can't"
BUTTON position 478 157 678 194  GOTO Alley
BUTTON position 260 159 464 198  IF others=2 GOTO "Alley - Ask about others"  IF 1=1 GOTO "Generic - You can't"
PAUSE -1
END

EVENT "Alley - Ask about Sally #2"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 38 77 690 210
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "You ask Larry about Sally."
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
ATTRIBUTES edge 
TEXT 62 109 ""
TEXT 62 125 "- You know, officer, Sally was so mysterious! Always asking about "
TEXT 62 141 "police procedures and how investigations work. "
TEXT 62 157 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET sally 3  SET score score+3  GOTO "Chapter 5"
PAUSE -1
END

EVENT "Alley - Ask about others"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 38 77 690 263
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "You ask Larry about other girls."
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
ATTRIBUTES edge 
TEXT 62 109 ""
TEXT 62 125 "- Now that you mention it, the waitress here seem to change a lot. and "
TEXT 62 141 "they're always nervous. I figured it was the usual effect of the Larry"
TEXT 62 157 "magnetism."
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
TEXT 62 173 ""
TEXT 62 189 "You ask Larry about suspicious activities."
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
TEXT 62 205 ""
TEXT 62 221 "- I've noticed guys in expensive cars picking up the girls sometimes. Figured"
TEXT 62 237 "they were just giving them rides home. "
TEXT 62 253 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET others 3  SET score score+2  GOTO Alley
PAUSE -1
END

EVENT "Alley - Examine top window"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "That window is on the second floor. Might be useful to remember."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280 RETURN
PAUSE -1
END

EVENT "Alley - Examine lower window"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "You can see a small bottle with some pills on the inside. The window is "
ATTRIBUTES edge 
TEXT 62 109 "locked and can't be opened from the outside. "
TEXT 62 125 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280 RETURN
PAUSE -1
END

EVENT "Alley - Smash window"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "You can see a small bottle with some pills on the inside. The window is "
ATTRIBUTES edge 
TEXT 62 109 "locked and can't be opened from the outside. "
TEXT 62 125 ""
TEXT 62 141 "You use the hammer to smash the window and grab the bottle of pills. "
TEXT 62 157 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET pills 1  SET score score+2 RETURN
PAUSE -1
END

EVENT "Bathroom - Examine sink"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "The porcelain is stained and cracked."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280 RETURN
PAUSE -1
END

EVENT "Bathroom - Find ring"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "A simple gold band sits near the drain, its surface scratched and worn "
ATTRIBUTES edge 
TEXT 62 109 "from years of wear. It looks like a wedding ring, abandoned in haste "
TEXT 62 125 "by someone who left in a hurry."
TEXT 62 141 ""
TEXT 62 157 "You pick it up and put it in your pocket."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 16 1 723 280  SET ring 1  SET score score+1 RETURN
PAUSE -1
END

EVENT "Bathroom - Find tooth"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "A human tooth with a prominent gold filling glints under the harsh "
ATTRIBUTES edge 
TEXT 62 109 "bathroom light. The gold work looks expensive - definitely not your "
TEXT 62 125 "average dental work."
TEXT 62 141 ""
TEXT 62 157 "You pick it up and put it in your pocket."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 16 1 723 280  SET tooth 1  SET score score+1 RETURN
PAUSE -1
END

EVENT "Bathroom - Examine wall #1"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "There's scribble all over the walls. Most of it is illegible scrawl, but"
ATTRIBUTES edge 
TEXT 62 109 "one message stands out clearly: "
TEXT 62 125 ""
COLOR 12 2 7 7 7 0 12 7 0 12 13 13 12 13 12
TEXT 62 141 "\"\Ken sent me\"\"
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
TEXT 62 157 ""
TEXT 62 173 "It's written in fresh ink."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET password 1  SET score score+2 RETURN
PAUSE -1
END

EVENT "Bathroom - Examine wall #2"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "There's scribble all over the walls. You quickly look through it again "
ATTRIBUTES edge 
TEXT 62 109 "but you discover nothing new."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280 RETURN
PAUSE -1
END

EVENT "Bathroom - Examine wall #3"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "There's scribble all over the walls. Most of it is illegible scrawl, but"
ATTRIBUTES edge 
TEXT 62 109 "one message stands out clearly: "
TEXT 62 125 ""
COLOR 12 2 7 7 7 0 12 7 0 12 13 13 12 13 12
TEXT 62 141 "\"\The naked man fears no pickpocket\"\"
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
TEXT 62 157 ""
TEXT 62 173 "It's written in fresh ink."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280 RETURN
PAUSE -1
END

EVENT "Bathroom - Examine toilet #1"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "A cramped stall with a door that barely stays closed and graffiti covering "
ATTRIBUTES edge 
TEXT 62 109 "every available surface. The toilet itself has seen better decades, and "
TEXT 62 125 "the lock hangs loose from repeated abuse."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280 RETURN
PAUSE -1
END

EVENT "Bathroom - Examine toilet #2"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 38 77 690 198
COLOR 1 7 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES shadow edge 
STYLE 0 3 4 3 6 1 1 29 
BOX 480 160 670 190
BOX 50 160 240 190
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "A cramped stall with a door that barely stays closed and graffiti covering "
ATTRIBUTES edge 
TEXT 62 109 "every available surface. The toilet itself has seen better decades, and "
TEXT 62 125 "the lock hangs loose from repeated abuse.  The tank lid is slightly askew, "
TEXT 62 141 "as if someone's been moving it recently."
TEXT 70 170 "Open the lid"
TEXT 548 170 "Exit"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 3 2 1 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 50 159 244 194  GOTO "Bathroom - Find evidence"
BUTTON position 478 159 670 194 RETURN
PAUSE -1
END

EVENT "Bathroom - Find evidence"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 212
COLOR 1 7 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES shadow edge remap 
STYLE 0 3 4 3 6 1 1 17 
BOX 265 160 455 190
BOX 480 160 670 190
BOX 50 160 240 190
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
ATTRIBUTES edge remap 
TEXT 62 93 "You open the lid and inside you find a notebook and a"
ATTRIBUTES edge 
TEXT 62 109 "letter wrapped in waterproof material. "
TEXT 70 170 "Examine notebook"
TEXT 302 170 "Examine letter"
TEXT 548 170 "Exit"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 476 158 674 193  GOTO Bathroom
BUTTON position 50 160 240 191  IF notebook=0 GOTO "Bathroom - Examine notebook"  IF 1=1 GOTO "Generic - You can't"
BUTTON position 264 160 456 191  IF letter=0 GOTO "Bathroom - Examine letter"  IF 1=1 GOTO "Generic - You can't"
PAUSE -1
END

EVENT "Bathroom - Examine notebook"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 212
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 64 92 "Jackpot, this looks like records of some kind - names, dates and dollar "
ATTRIBUTES edge 
TEXT 64 108 "amounts. Sallys name is at the top of the list."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET notebook 1  SET score score+3 RETURN
PAUSE -1
END

EVENT "Bathroom - Examine letter"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 249
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "You open the letter and read it:"
ATTRIBUTES edge 
TEXT 62 109 ""
COLOR 12 2 7 7 7 0 12 7 0 12 13 13 12 13 12
TEXT 62 125 "\"\Lefty - Sally has made contact and planted the evidence as"
TEXT 62 141 "discussed. When Bonds finds the ring and notebook, he'll think he's"
TEXT 62 157 "solving a case. He has no idea he's walking into our trap."
TEXT 62 173 "J.B.\"\"
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
TEXT 62 189 ""
TEXT 62 205 "J.B... Jessie Bains. Sally... she's working for him. This whole"
TEXT 62 221 "investigation has been orchestrated."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET letter 1  SET score score+3 RETURN
PAUSE -1
END

EVENT "Backroom - Examine TV #1"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "An old set with rabbit ears. Currently showing static, but it's"
ATTRIBUTES edge 
TEXT 62 109 "plugged in and ready to go."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280 RETURN
PAUSE -1
END

EVENT "Backroom - Examine TV #2"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 38 77 690 198
COLOR 1 7 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES shadow edge 
STYLE 0 3 4 3 6 1 1 29 
BOX 480 160 670 190
BOX 50 160 240 190
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 17 
TEXT 66 93 "An old set with rabbit ears. Currently showing static, but it's"
ATTRIBUTES edge 
TEXT 62 109 "plugged in and ready to go."
ATTRIBUTES edge remap 
TEXT 70 170 "Use the remote"
TEXT 548 170 "Exit"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 3 2 1 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 50 159 244 194  GOTO "Backroom - Use remote"
BUTTON position 478 159 670 194 RETURN
PAUSE -1
END

EVENT "Backroom - Examine TV #3"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "An old set with rabbit ears. Currently showing some soap opera."
ATTRIBUTES edge 
TEXT 62 109 "The guard is totaly focused on the TV."
TEXT 62 125 ""
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
TEXT 62 141 "- Hey! My show's on! "
TEXT 62 157 "- Oh no, Jessica's about to tell Derek about the baby!"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280 RETURN
PAUSE -1
END

EVENT "Backroom - Show badge"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "You show your badge to the guard."
ATTRIBUTES edge 
TEXT 62 109 ""
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
TEXT 62 125 "- No one goes upstairs without the boss's say-so. That's the rule,"
TEXT 62 141 "and I follow rules."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280 RETURN
PAUSE -1
END

EVENT "Backroom - Ask about TV"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "You ask the guard about the TV."
ATTRIBUTES edge 
TEXT 62 109 ""
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
TEXT 62 125 "- Boss lets me watch my stories during the slow hours. Keeps me"
TEXT 62 141 "alert, ya know?"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280 RETURN
PAUSE -1
END

EVENT "Backroom - Talk to guard"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 38 77 690 198
COLOR 1 7 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES shadow edge 
STYLE 0 3 4 3 6 1 1 29 
BOX 265 160 455 190
BOX 480 160 670 190
BOX 50 160 240 190
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 17 
TEXT 66 93 "A massive man in a cheap suit blocks the stairway like a human"
ATTRIBUTES edge 
TEXT 62 109 "wall. His attention keeps drifting to the TV-screen."
ATTRIBUTES edge remap 
TEXT 66 170 "Show your badge"
TEXT 278 170 "Ask about TV"
TEXT 548 170 "Exit"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 3 2 1 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 50 159 244 194  GOTO "Backroom - Show badge"
BUTTON position 264 159 464 193  GOTO "Backroom - Ask about TV"
BUTTON position 478 159 670 194  GOTO "Backroom - Blocked stairs"
PAUSE -1
END

EVENT "Backroom - Examine window"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "It's a window."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 2 723 280 RETURN
PAUSE -1
END

EVENT "Backroom - Examine boxes"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "Cases of cheap liquor, probably watered down. Nothing suspicious"
ATTRIBUTES edge 
TEXT 62 109 "here."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 2 723 280 RETURN
PAUSE -1
END

EVENT "Backroom - Use remote"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "You remember that old remote you got from the drunk, using it"
ATTRIBUTES edge 
TEXT 62 109 "you change the channel on the TV to some random soap opera."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 2 723 280  SET stairs 1  SET score score+3  GOTO Backroom
PAUSE -1
END

EVENT "Bedroom - Find candy"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "Now that you look closer, there are more items here - makeup, jewelry,"
ATTRIBUTES edge 
TEXT 62 109 "personal effects and a bowl of candy. "
TEXT 62 141 "You take a candy and put it in your pocket."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 2 723 280  SET candy 1  SET score score+1 RETURN
PAUSE -1
END

EVENT "Bedroom - Talk to woman"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 38 77 690 198
COLOR 1 7 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES shadow edge 
STYLE 0 3 4 3 6 1 1 29 
BOX 265 160 455 190
BOX 480 160 670 190
BOX 50 160 240 190
FONT FuturaB.font 16
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "- I don't talk to strangers, honey. You want conversation, you"
ATTRIBUTES edge 
TEXT 62 109 "gotta be a gentleman."
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
ATTRIBUTES edge remap 
TEXT 70 170 "Show your badge"
TEXT 278 170 "Ask about Sally"
TEXT 548 170 "Exit"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 3 2 1 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 50 159 244 194  IF woman=0 GOTO "Bedroom - Show badge"  IF 1=1 GOTO "Generic - You can't"
BUTTON position 264 159 464 193  IF woman=1 GOTO "Bedroom - Ask about Sally"  IF 1=1 GOTO "Generic - You can't"
BUTTON position 478 159 670 194 RETURN
PAUSE -1
END

EVENT "Bedroom - Show badge"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 233
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "You show her your badge."
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
ATTRIBUTES edge 
TEXT 62 109 ""
TEXT 62 125 "- A cop? "
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
TEXT 62 141 ""
TEXT 62 157 "She looks nervous."
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
TEXT 62 173 ""
TEXT 62 189 "- Look, I'm just trying to make a living here. I don't want any"
TEXT 62 205 "trouble with the law."
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
ATTRIBUTES edge remap 
TEXT 288 101 ""
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 2 723 280  SET woman 1  SET score score+3 RETURN
PAUSE -1
END

EVENT "Bedroom - Ask about Sally"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "You ask her about Sally."
COLOR 15 2 7 0 0 0 15 7 0 15 15 0 0 0 15
ATTRIBUTES edge 
TEXT 62 109 ""
TEXT 62 125 "- Sally was my friend. We both got trapped in Lefty's operation. He makes "
TEXT 62 141 "girls work for him by getting them in debt, then won't let them leave until "
TEXT 62 157 "they pay it off."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 2 723 280  SET woman 2  SET score score+3  SET sally 2 RETURN
PAUSE -1
END

EVENT "Bedroom - Examine window"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "It's a window."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280 RETURN
PAUSE -1
END

EVENT "Bar - Examine door"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "It's locked. A voice on the other side of the door says:"
ATTRIBUTES edge 
TEXT 62 109 ""
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
TEXT 62 125 "- What's the password?"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280 RETURN
PAUSE -1
END

EVENT "Bar - Buy whiskey"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "You order a whiskey from the bartender. He pours a drink and"
ATTRIBUTES edge 
TEXT 62 109 "takes the 10 dollar bill from your hand. "
TEXT 62 125 ""
TEXT 62 141 "You take the glass of whiskey."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET whiskey 1  SET money money-10  SET score score+3 RETURN
PAUSE -1
END

EVENT "Bar - Talk to Lefty #1"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 38 77 690 198
COLOR 1 7 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES shadow edge 
STYLE 0 3 4 3 6 1 1 29 
BOX 265 160 455 190
BOX 480 160 670 190
BOX 50 160 240 190
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "The bartender is a heavyset man whose perpetually sweaty face"
ATTRIBUTES edge 
TEXT 62 109 "and darting eyes give him the look of someone who's always"
TEXT 62 125 "expecting trouble. His expensive watch seems out of place with his"
TEXT 62 141 "grimy apron, hinting at income sources beyond just slinging drinks."
TEXT 62 157 ""
TEXT 66 170 "Show your badge"
TEXT 278 170 "Order a whiskey"
ATTRIBUTES edge remap 
TEXT 548 170 "Exit"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 3 2 1 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 50 159 244 194  IF larry=2 GOTO "Bar - Show badge"  IF 1=1 GOTO "Generic - Not yet"
BUTTON position 264 159 464 193  IF drunk=2&whiskey=0&money>=10 GOTO "Bar - Buy whiskey"  IF 1=1 GOTO "Generic - You can't"
BUTTON position 478 159 670 194  GOTO Bar
PAUSE -1
END

EVENT "Bar - Talk to Lefty #2"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 38 77 690 198
COLOR 1 7 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES shadow edge 
STYLE 0 3 4 3 6 1 1 29 
BOX 480 160 670 190
BOX 50 160 240 190
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "Lefty is standing behind the bar, mixing drinks. He looks very"
ATTRIBUTES edge 
TEXT 62 109 "nervous."
TEXT 70 170 "Arrest Lefty"
ATTRIBUTES edge remap 
TEXT 548 170 "Exit"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 3 2 1 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 50 159 244 194  GOTO "Bar - Arrest Lefty"
BUTTON position 478 159 670 194 RETURN
PAUSE -1
END

EVENT "Bar - Show badge"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 38 77 690 198
COLOR 1 7 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES shadow edge 
STYLE 0 3 4 3 6 1 1 29 
BOX 265 160 455 190
BOX 480 160 670 190
BOX 50 160 240 190
FONT FuturaB.font 16
COLOR 8 2 7 7 7 0 8 7 0 8 9 9 9 9 8
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "- Police business, Mister. I'm investigating some missing"
ATTRIBUTES edge 
TEXT 62 109 "persons reports."
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
TEXT 62 125 "- Missing persons? Officer, this is a respectable establishment. I'm "
TEXT 62 141 "the owner, the name is Lefty."
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
TEXT 70 170 "Ask about Sally"
TEXT 278 170 "Ask about others"
ATTRIBUTES edge remap 
TEXT 548 170 "Exit"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 3 2 1 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 50 159 248 194  IF sally=0 GOTO "Bar - Ask about Sally"  IF 1=1 GOTO "Generic - You can't"
BUTTON position 262 158 462 196  IF others=0 GOTO "Bar - Ask about missing persons"  IF 1=1 GOTO "Generic - You can't"
BUTTON position 478 160 676 195  GOTO Bar
PAUSE -1
END

EVENT "Bar - Ask about Sally"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "You ask Lefty about Sally."
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
ATTRIBUTES edge 
TEXT 62 125 "- Sally? Nice girl, worked here for a while. Quit about a week ago."
TEXT 62 141 "Didn't give notice - just stopped showing up. You know how these"
TEXT 62 157 "young girls are."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET sally 1  SET score score+3 RETURN
PAUSE -1
END

EVENT "Bar - Ask about missing persons"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "You ask Lefty about other missing persons."
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
ATTRIBUTES edge 
TEXT 62 125 "- Look, officer, I run a bar, not a babysitting service. Adults make"
TEXT 62 141 "their own choices about where to go and what to do."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET others 1  SET score score+3 RETURN
PAUSE -1
END

EVENT "Bar - Examine jukebox"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "An ancient Wurlitzer jukebox stands silent in the corner, its colorful lights "
ATTRIBUTES edge 
TEXT 62 109 "long since burned out. A handwritten "
COLOR 8 2 7 7 7 0 8 7 0 8 9 9 9 9 8
TEXT 370 108 "\"\OUT OF ORDER\"\ "
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
TEXT 508 107 "sign is taped to "
TEXT 60 126 "the cracked glass, though you suspect it's been broken for years."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280 RETURN
PAUSE -1
END

EVENT "Bar - Arrest Lefty"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 21 696 257
FONT FuturaB.font 16
COLOR 8 2 7 7 7 0 8 7 0 8 9 9 9 9 8
STYLE 0 3 4 3 6 1 1 17 
TEXT 70 33 "- Lefty Miller, you're under arrest for operating a prostitution"
ATTRIBUTES edge 
TEXT 70 49 "ring, human trafficking, and conspiracy."
TEXT 70 65 "You have the right to remain silent. Anything you say can and"
TEXT 70 81 "will be used against you in a court of law."
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
TEXT 70 113 "You handcuff Lefty."
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
TEXT 70 145 "- You think this is over? I've got lawyers, connections. I'll be out in"
TEXT 70 161 "24 hours. "
TEXT 70 177 "- Arresting me won't save you! Jessie's out there, and he's just"
TEXT 70 193 "getting started. - We'll see about that. The DA takes human trafficking very"
TEXT 70 209 "seriously."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  GOTO "Game over"
PAUSE -1
END

EVENT "Bar - Open door"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 248
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "It's locked. A voice on the other side of the door says:"
COLOR 15 2 7 7 7 0 15 7 0 15 15 0 0 0 15
ATTRIBUTES edge 
TEXT 62 125 "- What's the password?"
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
TEXT 62 157 "You remember the grafitti in the bathroom and answer rapidly:"
COLOR 8 2 7 7 7 0 8 7 0 8 9 9 9 9 8
TEXT 62 189 "- Ken sent me!"
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
TEXT 62 221 "The door opens..."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  SET password 2  GOTO "Backroom - Blocked stairs"
PAUSE -1
END

EVENT "Generic - Nothing of interest"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "You see nothing of interest."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280 RETURN
PAUSE -1
END

EVENT "Generic - You can't"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "You can't!"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280 RETURN
PAUSE -1
END

EVENT "Generic - Not yet"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 80 696 201
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 62 93 "Not yet!"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280 RETURN
PAUSE -1
END

EVENT About
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 21 696 257
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 70 33 "LEFTY'S: STIRED, NOT SOLVED -  A Sierra-Style Adventure"
ATTRIBUTES edge 
TEXT 70 49 ""
TEXT 70 65 "Step into the shoes of Officer Sonny Bonds in this classic point-and-click "
TEXT 70 81 "adventure that pays homage to the golden age of Sierra Entertainment. "
TEXT 70 97 "When missing persons reports start piling up around the notorious "
TEXT 70 113 "Lefty's Bar, it's up to you to uncover the seedy truth behind the "
TEXT 70 129 "establishment's criminal operations."
TEXT 70 145 ""
TEXT 70 161 "Solve puzzles, gather evidence, and navigate the criminal underworld "
TEXT 70 177 "as you work to bring justice to those who prey on the innocent."
TEXT 70 193 ""
TEXT 70 209 "Will you crack the case and expose Lefty's illegal empire, or will the "
TEXT 70 225 "shadows of corruption consume another good cop?"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  GOTO Start
PAUSE -1
END

EVENT Credits
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 21 696 162
FONT FuturaB.font 16
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
STYLE 0 3 4 3 6 1 1 17 
TEXT 76 36 "Inspired by the games \"\Leisure Suit Larry in the land of the lounge lizards\"\"
ATTRIBUTES edge 
TEXT 76 52 "and \"\Police Quest\"\ by Sierra On-Line."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  GOTO Start
PAUSE -1
END

EVENT "Game over"
BLANK 724 284 4 hires 7
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 038 fff ccc aaa 888 666 444 000 c00 a22 d60 fb0 080 093 58b 53c
COLOR 1 5 7 7 7 53 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
BOX 44 21 696 257
FONT FuturaB.font 32
COLOR 7 4 7 7 7 0 7 7 0 7 7 7 7 7 7
TEXT 286 60 "Game over"
FONT FuturaB.font 20
COLOR 7 2 7 7 7 0 7 7 0 7 7 7 7 7 7
TEXT 117 127 "Money: $!money"
TEXT 117 149 "Score: !score of !max"
ATTRIBUTES edge 
TEXT 117 169 ""
COLOR 12 7 7 7 7 0 12 7 0 12 13 13 12 13 12
TEXT 117 189 "Overall rating: Crime does not pay!"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 30 0 723 280  GOTO Start
PAUSE -1
END

