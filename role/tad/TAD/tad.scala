V3.0

MOUSE on
FKEYS on
INTERACTIVE on

EVENT Start
BLANK 640 512 4 lace hires 0
TABS 100 200 300 400 500
MARGINS on 32 607
PALETTE 000 fff ccc 999 666 32c800 bdf 9bd 78a fd0 f90 f54 d00 68f 56c 084
FONT FuturaB.font 20
COLOR 1 0 7 4 3 84 1 7 0 1 2 2 4 3 1
ATTRIBUTES 3D edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 150 128 "THE"
FONT FuturaB.font 64
ATTRIBUTES 3D edge center 
STYLE 0 3 4 3 6 1 1 57 
TEXT 207 94 "ANGEL"
FONT FuturaB.font 20
ATTRIBUTES 3D edge 
STYLE 0 3 4 3 6 1 1 21 
TEXT 454 132 "OF"
FONT FuturaB.font 120
COLOR 0 1 7 12 12 0 0 7 0 0 0 0 0 0 0
ATTRIBUTES 3D edge center 
STYLE 0 3 4 3 6 1 1 105
TEXT 126 158 "DEATH"
FONT FuturaB.font 20
COLOR 0 1 7 9 10 0 0 7 0 0 0 0 0 0 0
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXT 62 430 "Start game"
ATTRIBUTES edge 
TEXT 280 432 "Instructions"
TEXT 494 432 "Credits"
FONT FuturaB.font 12
COLOR 12 8 9 9 10 0 12 7 0 12 11 11 0 11 12
ATTRIBUTES remap 
STYLE 0 3 4 3 6 1 1 11 
TEXT 610 494 "v1.2"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 4 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 50 416 198 460  SET guard 0  SET phone 0  SET carkeys 0  SET taselli 0  SET tnt -1  SET poker 0  SET drugrun1 0  SET drugrun2 0  SET drugrun3 0  SET bullets 0  SET bathroom 0  SET gambler 0  SET proposition 0  SET hunted 0  SET money 0  SET score 0  SET max 67  SET beer 0  SET hooker 0  SET vest 0  SET package1 0  SET package2 0  SET highroller 0  SET banana 0  GOTO "Intro #1"
BUTTON position 266 418 415 464  SET guard 0  SET phone 0  SET carkeys 0  GOTO Instructions
BUTTON position 472 422 593 462  SET guard 0  SET phone 0  SET carkeys 0  GOTO Credits
PAUSE -1
END

EVENT Suite
PICTURE "TAD:bedroom.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 30 30 "Suite"
FONT FuturaB.font 16
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 30 64 "This is your suite, your homebase. The bed is comfy and there"
TEXT 30 82 "are two nightstands beside it. A painting is hanging on the wall behind"
TEXT 30 100 "the bed. A bathroom is located on the opposite side of the room.  "
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 12 11 13 14 15
BUTTON position 229 425 409 508  IF bathroom=1 GOTO Lounge  IF 1=1 GOTO "Suite - Can`t leave"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 10 9 11 12 13 14 15
BUTTON position 122 310 189 359  IF phone=0 GOTO "Suite - Answer phone - Taselli"  IF phone=2 GOTO "Suite - Answer phone - Bonds"  IF 1=1 GOTO "Suite - Answer phone - no one"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
SELECT replace 0 1 2 3 4 15 6 7 8 10 9 11 12 13 14 5
BUTTON position 52 371 106 427  IF carkeys=0 GOTO "Suite - Get key"  IF carkeys=1 GOTO "Generic - Not now"
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 14 13 15
BUTTON position 560 282 600 430  IF bathroom=1 GOTO "Suite - Freshen up"  IF 1=1 GOTO "Suite - Get dressed"
PAUSE -1
END

EVENT Lounge
PICTURE "TAD:lounge.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 0 7 7 7 13 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
BRUSH 251 279 "TAD:guy1.iff"
FONT FuturaB.font 20
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 21 
TEXT 30 30 "Lounge"
FONT FuturaB.font 16
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 30 64 "This is the lounge, it`s connected to your suite, the"
TEXT 30 82 "gambling room and the lobby. A tough looking guy is standing guard "
TEXT 30 100 "outside the gambling room."
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 10 9 11 12 13 14 15
BUTTON position 121 227 201 338  IF proposition=1 GOTO "Lounge - Phone rings"  IF 1=1 GOTO Suite
BUTTON position 301 227 377 340  IF taselli=4&poker=0 GOTO "Gambling room - Secret room"  IF guard=1 GOTO "Gambling room"  IF 1=1 GOTO "Generic - Locked door"
SELECT replace 0 1 2 2 4 5 6 7 8 9 10 12 11 13 14 15
BUTTON position 1 253 70 441  GOTO "Hotel lobby"
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 12 15
BUTTON position 240 273 289 366  GOTO "Lounge - Guard"
PAUSE -1
END

EVENT "Gambling room"
PICTURE "TAD:gamblingroom.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 12 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 30 30 "Gambling room"
FONT FuturaB.font 16
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 30 64 "The room is buzzing with activity. People are playing both craps"
TEXT 30 82 "and poker in here. Both at very high stakes."
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 12 11 13 14 15
BUTTON position 239 427 397 506  IF poker=1&proposition=0 GOTO "Gambling room - Proposition"  IF 1=1 GOTO Lounge
SELECT replace 0 1 2 3 4 15 6 7 8 9 10 11 12 13 14 5
BUTTON position 106 314 275 427  IF money>=100 GOTO "Gambling room - Choice"  IF 1=1 GOTO "Gambling room - Not now"  IF 1=1 GOTO "Gambling room - Not now"
SELECT replace 0 1 2 3 4 5 6 7 8 9 9 11 12 13 14 15
BUTTON position 288 254 348 334  IF taselli=4 GOTO "Secret room"  IF 1=1 GOTO "Generic - Locked door"
SELECT replace 0 1 2 3 4 15 6 7 8 9 10 11 12 13 14 5
BUTTON position 362 300 490 388  GOTO "Gambling room - Not now"
PAUSE -1
END

EVENT "Secret room"
PICTURE "TAD:secretroom.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 30 30 "Secret room"
FONT FuturaB.font 16
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 30 64 "This is the secret gambling room. Only selected people are allowed"
TEXT 30 82 "here. In here the stakes are very high."
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 12 11 13 14 15
BUTTON position 237 429 397 506  IF poker=1&proposition=0 GOTO "Gambling room - Proposition"  IF 1=1 GOTO "Gambling room"  GOTO "Gambling room"
SELECT replace 0 1 2 3 4 15 6 7 8 9 10 11 12 13 14 5
BUTTON position 216 336 402 426  IF poker=0 GOTO "Gambling room - Playing poker"  IF 1=1 GOTO "Gambling room - Not now"
SELECT replace 1 1 2 3 4 5 6 7 8 9 10 12 11 13 14 15
BUTTON position 242 468 248 468  IF poker=1&proposition=0 GOTO "Gambling room - Proposition"  IF 1=1 GOTO "Gambling room"  GOTO "Gambling room"
PAUSE -1
END

EVENT "Hotel lobby"
PICTURE "TAD:lobby.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 0 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
BRUSH 191 299 "TAD:guy3.iff"
FONT FuturaB.font 20
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 21 
TEXT 30 30 "Hotel lobby"
FONT FuturaB.font 16
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 30 64 "The lobby is rather empty at the moment. Not much activity going on"
TEXT 30 82 "here."
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 14 9 10 12 11 13 14 15
BUTTON position 479 239 544 373  GOTO Lounge
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 12 11 13 14 15
BUTTON position 247 417 397 514  GOTO "Outside the hotel"
SELECT replace 3 1 2 0 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 270 210 374 352  GOTO "Generic - Not now"
SELECT replace 4 1 2 3 4 5 6 7 14 9 10 11 12 13 14 15
BUTTON position 188 290 224 386  IF package1=0&gambler=2 GOTO "Hotel lobby - Packages"  IF banana=0&package1=2 GOTO "Hotel lobby - Banana"  IF 1=1 GOTO "Hotel lobby - Concierge"
PAUSE -1
END

EVENT "Outside the hotel"
PICTURE "TAD:hotell.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
BRUSH 39 350 "TAD:blue-car-side.iff" size 230 80
BRUSH 223 269 "TAD:guy3.iff"
FONT FuturaB.font 20
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 21 
TEXT 30 30 "Outside the hotel"
FONT FuturaB.font 16
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 30 64 "Your car, a light blue Cadillac, is parked near the hotel. The"
TEXT 30 82 "hotel  entrance is big and flashy."
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 13 14 8 9 10 11 12 13 14 15
BUTTON position 37 357 269 438  IF hunted=1&vest=1 GOTO "Outside hotel - Gunfight #2"  IF hunted=1 GOTO "Outside hotel - Gunfight #1"  IF carkeys=1 GOTO "City map"  IF 1=1 GOTO "Outside hotel - Locked car"
SELECT replace 0 15 2 3 4 5 6 7 8 10 10 11 12 13 14 1
BUTTON position 275 229 371 370  IF gambler<2&carkeys=1 GOTO "Outside hotel - Bamboni #2"  IF taselli=1&bullets>0&drugrun1=3&drugrun2=3&drugrun3=3 GOTO "Outside hotel - Bamboni #1"  IF drugrun1=0&drugrun2=0&drugrun3=0 GOTO "Outside hotel - Lipshitz"  IF 1=1 GOTO "Hotel lobby"
SELECT replace 4 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 214 266 260 352  GOTO "Outside hotel - Concierge"
PAUSE -1
END

EVENT "City map"
PICTURE "TAD:map.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 0 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 30 30 "The city of Lytton"
TEXT 284 116 "Hotel"
ATTRIBUTES edge 
TEXT 434 104 "Wino"
TEXT 434 126 "Willys"
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
TEXT 56 328 "Warehouse"
ATTRIBUTES edge 
TEXT 56 350 "District"
ATTRIBUTES edge remap 
TEXT 76 196 "City park"
ATTRIBUTES edge 
TEXT 310 454 "City jail"
TEXT 436 452 "Cotton cove"
ATTRIBUTES edge remap 
TEXT 290 214 "The"
ATTRIBUTES edge 
TEXT 290 236 " Inn"
FONT FuturaB.font 12
STYLE 0 3 4 3 6 1 1 11 
TEXT 40 78 "1st"
ATTRIBUTES edge remap 
TEXT 114 76 "2nd"
TEXT 190 76 "3rd"
TEXT 264 76 "4th"
ATTRIBUTES edge 
TEXT 340 78 "5th"
TEXT 416 78 "6th"
TEXT 490 78 "7th"
TEXT 566 78 "8th"
TEXT 582 90 "Palm"
TEXT 582 146 "Oak"
TEXT 584 202 "Fig"
TEXT 584 258 "Peach"
TEXT 584 316 "Rose"
TEXT 584 372 "Lilly"
TEXT 582 430 "Poppy"
TEXT 584 482 "River"
FONT FuturaB.font 20
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXT 134 452 "Shop"
FONT FuturaB.font 16
TEXT 482 22 "Wallet: $!money"
TEXT 482 42 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 2 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 269 93 352 149  GOTO "Outside the hotel"
BUTTON position 419 95 501 150  GOTO "In the streets"
BUTTON position 50 318 203 377  GOTO "Old Warehouse District - Outside"
BUTTON position 48 150 199 259  IF drugrun1=2 GOTO "City park"  IF 1=1 GOTO "City park - Empty"
BUTTON position 272 432 423 489  GOTO "Outside City jail"
BUTTON position 426 432 577 489  GOTO "Cotton cove"
BUTTON position 274 208 354 262  IF drugrun3=2 GOTO "Snuggler's Inn"  IF 1=1 GOTO "Snuggler's Inn - Empty"
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 5
BUTTON position 574 232 640 290  IF drugrun1=1&drugrun2=1&drugrun3=1 GOTO Woods  IF 1=1 GOTO "Woods - Empty"
SELECT replace 0 1 2 3 3 5 6 7 8 9 10 11 12 13 14 5
BUTTON position 426 236 504 286  IF bullets=0&taselli>0 GOTO "Crime scene - Bullets"  IF 1=1 GOTO "Crime scene"
SELECT replace 0 2 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 124 434 200 490  GOTO "Guns'n Ammo"
PAUSE -1
END

EVENT "In the streets"
PICTURE "TAD:winowillys.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 0 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
BRUSH 369 346 "TAD:blue-car-side.iff" size 230 80
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
BRUSH 45 333 "TAD:cop-car-side.iff" size 230 80
FONT FuturaB.font 20
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 21 
TEXT 30 30 "In the streets"
FONT FuturaB.font 16
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 30 64 "Wino Willys is not what you would call a classy place, a few cars are"
TEXT 30 82 "parked near the building. A coffee shop is located next door."
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 13 14 8 9 10 11 12 13 14 15
BUTTON position 371 347 597 438  GOTO "City map"
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 12 12 13 14 15
BUTTON position 429 257 481 320  IF gambler=1 GOTO "Wino Willys - Drunk man"  IF 1=1 GOTO "Wino Willys"
SELECT replace 0 1 2 4 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 152 274 204 344  GOTO "Generic - Not now"
SELECT replace 0 1 2 3 4 5 13 14 8 9 10 11 12 13 14 15
BUTTON position 48 338 280 414  IF banana=1 GOTO "In the streets - Police car"  IF 1=1 GOTO "Generic - Not now"
PAUSE -1
END

EVENT "Wino Willys"
PICTURE "TAD:bar.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 0 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
BRUSH 225 299 "TAD:girl1.iff"
BRUSH 265 301 "TAD:girl2.iff"
FONT FuturaB.font 20
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 21 
TEXT 30 30 "Wino Willys cocktail lounge"
FONT FuturaB.font 16
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 30 64 "This place is very rundown, almost filthy. A guy is standing behind the"
TEXT 30 82 "bar ready to take your order. A few other customers are hanging "
TEXT 30 100 "around drinking cheap beer."
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 12 12 14 14 15
BUTTON position 237 419 399 506  GOTO "In the streets"
SELECT replace 0 12 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 220 291 299 380  IF hooker=0 GOTO "Wino Willys - Talk to hooker #1"  IF 1=1 GOTO "Wino Willys - Talk to hooker #2"
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 6 14 15
BUTTON position 400 262 497 321  IF drugrun2=2 GOTO "Wino Willys - Deliver drugs #2"  IF beer=0&money>0 GOTO "Wino Willys - Buy drink"  IF 1=1 GOTO "Wino Willys - Talk"
PAUSE -1
END

EVENT "Wino Willys - Drunk man"
PICTURE "TAD:bar.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
BRUSH 235 303 "TAD:girl1.iff"
BRUSH 277 307 "TAD:girl2.iff"
BRUSH 483 351 "TAD:guy1.iff"
FONT FuturaB.font 20
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 21 
TEXT 30 30 "Wino Willys cocktail lounge"
FONT FuturaB.font 16
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 30 64 "This place is very rundown, almost filthy. A guy is standing behind the"
TEXT 30 82 "bar ready to take your order. A few other customers are hanging "
TEXT 30 100 "around drinking cheap beer, one of them looks like the guy you are"
TEXT 30 118 "looking for."
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 1 9 10 12 12 14 14 15
BUTTON position 237 429 401 504  GOTO "In the streets"
SELECT replace 0 12 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 226 291 315 384  IF hooker=0 GOTO "Wino Willys - Talk to hooker #1"  IF 1=1 GOTO "Wino Willys - Talk to hooker #2"
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 7 14 15
BUTTON position 412 266 483 317  IF drugrun2=2 GOTO "Wino Willys - Deliver drugs #2"  IF beer=0&money>0 GOTO "Wino Willys - Buy drink"  IF 1=1 GOTO "Wino Willys - Talk"
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 14 13 12 15
BUTTON position 476 347 515 438  GOTO "Wino Willys - Fighting gambler"
PAUSE -1
END

EVENT "Old Warehouse District - Outside"
PICTURE "TAD:junkyard.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 4 7 7 7 12 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
BRUSH 377 332 "TAD:blue-car-side.iff" size 230 80
FONT FuturaB.font 20
STYLE 0 3 4 3 6 1 1 21 
TEXT 30 30 "Old Warehouse District"
FONT FuturaB.font 16
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 30 64 "The area is surrounded by a solid fence."
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 13 14 8 9 10 11 12 13 14 15
BUTTON position 373 329 607 416  GOTO "City map"
SELECT replace 0 1 4 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 247 261 395 330  IF phone=1 GOTO "Old Warehouse District - Inside"  IF 1=1 GOTO "Generic - Locked door"
PAUSE -1
END

EVENT "Old Warehouse District - Inside"
PICTURE "TAD:warehouse.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 30 30 "Old Warehouse District"
FONT FuturaB.font 16
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 30 64 "A lot of old junk is scattered all over the place. Tasellis office is on"
TEXT 30 82 "the other side of the yard."
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 4 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 241 421 401 500  GOTO "Old Warehouse District - Outside"
SELECT replace 0 1 2 3 4 5 6 7 7 9 10 11 12 13 14 15
BUTTON position 431 181 613 286  GOTO "Old Warehouse District - Office"
BUTTON position 35 127 211 284  IF taselli=2&tnt=0 GOTO "Old Warehouse District - Get TNT"  IF 1=1 GOTO "Generic - Locked door"
PAUSE -1
END

EVENT "Old Warehouse District - Office"
PICTURE "TAD:office.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 30 30 "Tasellis office"
FONT FuturaB.font 16
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 30 64 "The officebuilding is old and looks like it will fall apart any second. "
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 4 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 231 421 411 500  GOTO "Old Warehouse District - Inside"
SELECT replace 0 1 2 3 4 5 6 7 7 9 10 11 12 13 14 15
BUTTON position 249 179 608 377  IF taselli=0 GOTO "Old Warehouse District - Taselli"  IF taselli=2&tnt=-1 GOTO "Old Warehouse District - Get key"  IF 1=1 GOTO "Generic - Not now"
PAUSE -1
END

EVENT "Cotton cove"
PICTURE "TAD:cottoncove.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 30 30 "Cotton cove"
FONT FuturaB.font 16
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 30 64 "This is the recreation area for every citizen."
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 3 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 553 251 610 319  GOTO "Cotton cove - River"
BUTTON position 243 415 403 510  GOTO "City map"
BUTTON position 34 250 118 298  GOTO "Generic - Not now"
PAUSE -1
END

EVENT "Cotton cove - River"
PICTURE "TAD:cottoncove-water.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 30 30 "Cotton cove"
FONT FuturaB.font 16
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 30 64 "Some ducks are swimming in the pond nearby."
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 4 4 5 6 7 8 9 10 11 12 14 13 15
BUTTON position 333 267 608 403  IF taselli=3 GOTO "Cotton cove - Dump body"  IF bullets=1 GOTO "Cotton cove - Dump bullets"  IF 1=1 GOTO "Generic - Not now"
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 5
BUTTON position 243 419 397 504  GOTO "Cotton cove"
PAUSE -1
END

EVENT "Outside City jail"
PICTURE "TAD:jail.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
BRUSH 51 356 "TAD:blue-car-side.iff" size 230 80
FONT FuturaB.font 20
STYLE 0 3 4 3 6 1 1 21 
TEXT 30 30 "City jail"
FONT FuturaB.font 16
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 30 64 "In the parking near the jail you can see a police car."
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 21 
BRUSH 317 303 "TAD:cop-car-side.iff" size 230 80
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 13 14 8 9 10 11 12 13 14 15
BUTTON position 45 353 285 428  GOTO "City map"
SELECT replace 0 1 4 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 335 175 467 282  IF tnt=-1&taselli=2 GOTO "City jail - Can't break door"  IF tnt=1 GOTO "City jail - Jailbreak"  IF 1=1 GOTO "Generic - Not now"
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 1 13 14 15
BUTTON position 362 194 362 216  IF tnt=1 NEXT  IF 1=1 GOTO "Generic - Not now"
PAUSE -1
END

EVENT "City park"
PICTURE "TAD:citypark.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 30 30 "City park"
FONT FuturaB.font 16
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 30 64 "The park is green. The only one in sight is a young guy with sneakers,"
TEXT 30 82 "he looks nervous."
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 21 
BRUSH 483 259 "TAD:guy2.iff"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 13 2 3 4 15 6 7 8 9 10 11 12 1 14 5
BUTTON position 446 201 541 350  IF drugrun1=2 GOTO "City park - Deliver drugs #1"  IF 1=1 GOTO "Generic - Not now"
SELECT replace 0 1 2 4 4 15 6 7 8 9 10 11 12 13 14 15
BUTTON position 243 413 399 498  GOTO "City map"
PAUSE -1
END

EVENT "City park - Empty"
PICTURE "TAD:citypark.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 30 30 "City park"
FONT FuturaB.font 16
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 30 64 "The park is green and empty."
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 4 4 15 6 7 8 9 10 11 12 13 14 15
BUTTON position 241 415 401 496  GOTO "City map"
PAUSE -1
END

EVENT "Snuggler's Inn"
PICTURE "TAD:inn.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 0 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
BRUSH 427 249 "TAD:guy1.iff"
FONT FuturaB.font 20
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 21 
TEXT 30 30 "Snuggler's Inn"
FONT FuturaB.font 16
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 30 64 "There is an Inn here, it looks sleazy and cheap. A few cars are parked "
TEXT 30 82 "outside the Inn. A young guy is standing in the corner. He looks nervous. "
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 21 
BRUSH 222 332 "TAD:red-car-side.iff" size 230 80
BRUSH 229 362 "TAD:blue-car-side.iff" size 230 80
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 13 14 8 9 10 11 12 13 14 15
BUTTON position 225 373 461 446  GOTO "City map"
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 14 13 12 15
BUTTON position 415 240 465 324  IF drugrun3=2 GOTO "Snuggler's Inn - Deliver drugs #3"  IF 1=1 GOTO "Generic - Not now"
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 11 13 14 15
BUTTON position 502 256 536 378  GOTO "Generic - Locked door"
BUTTON position 278 180 310 230  GOTO "Generic - Locked door"
BUTTON position 408 176 440 228  GOTO "Generic - Locked door"
BUTTON position 504 130 536 234  IF package2=1 GOTO "Snuggler's Inn - Delivery #2"  IF 1=1 GOTO "Generic - Locked door"
PAUSE -1
END

EVENT "Snuggler's Inn - Empty"
PICTURE "TAD:inn.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 1 4 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 30 30 "Snuggler's Inn"
FONT FuturaB.font 16
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 30 64 "There is an Inn here, it looks sleazy and cheap. A few cars are parked "
TEXT 30 82 "outside the Inn."
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 21 
BRUSH 232 330 "TAD:red-car-side.iff" size 230 80
BRUSH 235 364 "TAD:blue-car-side.iff" size 230 80
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 13 14 8 9 10 11 12 13 14 15
BUTTON position 237 371 467 442  GOTO "City map"
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 11 13 14 15
BUTTON position 502 256 538 376  GOTO "Generic - Locked door"
BUTTON position 500 134 534 236  IF package2=1 GOTO "Snuggler's Inn - Delivery #2"  IF 1=1 GOTO "Generic - Locked door"
BUTTON position 408 174 442 228  GOTO "Generic - Locked door"
BUTTON position 274 176 310 230  GOTO "Generic - Locked door"
PAUSE -1
END

EVENT Woods
PICTURE "TAD:woods.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 0 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
BRUSH 326 340 "TAD:truck.iff" size 224 80
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
BRUSH 59 342 "TAD:blue-car-side.iff" size 230 80
FONT FuturaB.font 20
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 21 
TEXT 30 30 "Woods"
FONT FuturaB.font 16
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 30 64 "Your delivery guy is already here with his truck. "
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 13 14 8 9 10 11 12 13 14 15
BUTTON position 57 349 291 430  GOTO "City map"
SELECT replace 0 1 3 4 3 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 320 339 561 420  IF money>=700 GOTO "Woods - Get drugs"  IF 1=1 GOTO "Woods - Not enough money"
PAUSE -1
END

EVENT "Woods - Empty"
PICTURE "TAD:woods.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 0 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
BRUSH 63 336 "TAD:blue-car-side.iff" size 230 80
FONT FuturaB.font 20
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 21 
TEXT 30 30 "Woods"
FONT FuturaB.font 16
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 30 64 "Nobody is here. It`s very silent, only a single bird is is chirping."
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 13 14 8 9 10 11 12 13 14 15
BUTTON position 61 335 297 422  GOTO "City map"
PAUSE -1
END

EVENT "Crime scene - Bullets"
PICTURE "TAD:crimescene.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 0 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
BRUSH 71 328 "TAD:cone.iff"
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
BRUSH 363 338 "TAD:blue-car-side.iff" size 230 80
FONT FuturaB.font 20
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 21 
TEXT 30 30 "Crime scene"
FONT FuturaB.font 16
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 30 64 "The crashed car is not here anymore, and the body has been taken care "
TEXT 30 82 "of by the paramedics. Where can those darn bullets be? "
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 21 
BRUSH 219 328 "TAD:cone.iff"
BRUSH 107 360 "TAD:cone.iff"
BRUSH 177 360 "TAD:cone.iff"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 13 14 8 9 10 11 12 13 14 15
BUTTON position 351 348 609 423  GOTO "City map"
SELECT replace 3 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 110 256 234 356  IF bullets=0 GOTO "Crime scene - Get bullets"
SELECT replace 0 1 2 4 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 426 262 494 346  GOTO "Generic - Locked door"
PAUSE -1
END

EVENT "Crime scene"
PICTURE "TAD:crimescene.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 0 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
BRUSH 69 334 "TAD:cone.iff"
BRUSH 107 356 "TAD:cone.iff"
BRUSH 217 334 "TAD:cone.iff"
BRUSH 181 356 "TAD:cone.iff"
COLOR 1 0 7 7 7 0 1 7 0 1 2 3 5 4 1
BRUSH 357 346 "TAD:blue-car-side.iff" size 230 80
FONT FuturaB.font 20
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 21 
TEXT 30 30 "Crime scene"
FONT FuturaB.font 16
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 30 64 "The crashed car is not here anymore, and the body has been taken care"
TEXT 30 82 "of by the paramedics."
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 13 14 8 9 10 11 12 13 14 15
BUTTON position 355 351 593 414  GOTO "City map"
SELECT replace 0 1 2 4 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 430 262 492 348  GOTO "Generic - Locked door"
SELECT replace 3 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 112 262 224 346  GOTO "Crime scene - Found nothing"
PAUSE -1
END

EVENT "Guns'n Ammo"
PICTURE "TAD:guns-n-ammo.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
COLOR 1 0 7 7 7 14 1 7 0 1 2 3 5 4 1
ATTRIBUTES edge remap 
STYLE 2 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
BRUSH 361 346 "TAD:blue-car-side.iff" size 230 80
FONT FuturaB.font 20
COLOR 1 4 7 7 7 0 1 7 0 1 2 3 5 4 1
STYLE 0 3 4 3 6 1 1 21 
TEXT 30 30 "Guns'n Ammo"
FONT FuturaB.font 16
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 17 
TEXT 30 64 "This is the only place to buy weapons and armour in Lytton... "
TEXT 30 82 "Legally that is."
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 13 14 8 9 10 11 12 13 14 15
BUTTON position 361 351 595 422  GOTO "City map"
SELECT replace 0 1 2 4 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 152 260 214 358  IF vest=0&bullets>0&money>=1500 GOTO "Shop - Choice"  IF vest=0&bullets>0 GOTO "Shop - Not enough money"  IF 1=1 GOTO "Shop - Closed"
BUTTON position 428 262 492 352  IF package1=1 GOTO "Shop - Delivery #1"  IF 1=1 GOTO "Generic - Locked door"
PAUSE -1
END

EVENT "Generic - Locked door"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 0 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You can`t, the door is locked."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510 RETURN
PAUSE -1
END

EVENT "Generic - Not now"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "Not now, maybe later."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510 RETURN
PAUSE -1
END

EVENT "Wino Willys - Deliver drugs #2"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You give the merchandise to the man"
ATTRIBUTES edge 
TEXT 92 182 "behind the bar. He looks at you and hands"
TEXT 92 204 "you a thick envelope of cash, and says:"
COLOR 11 0 7 7 7 0 11 7 0 11 10 11 10 10 11
TEXT 92 248 "- Hi Frank, it`s all there. See you next week.  "
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET drugrun2 3  SET money money+500  SET score score+3 RETURN
PAUSE -1
END

EVENT "Wino Willys - Buy drink"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "The guy looks at you and asks you:"
COLOR 11 0 7 7 7 0 11 7 0 11 10 11 10 10 11
ATTRIBUTES edge 
TEXT 92 204 "- What will it be this time, Frank. "
COLOR 2 0 7 7 7 0 2 7 0 2 1 2 4 3 2
TEXT 92 248 "Before you have time to answer, he "
TEXT 92 270 "hands you a beer."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET beer 1  SET money money-10  SET score score+2 RETURN
PAUSE -1
END

EVENT "Wino Willys - Talk"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "The guy looks at you and asks you:"
COLOR 11 0 7 7 7 0 11 7 0 11 10 11 10 10 11
ATTRIBUTES edge 
TEXT 92 204 "- What will it be this time, Frank. "
COLOR 4 0 7 7 7 0 4 7 0 4 3 3 4 4 4
TEXT 92 248 "- Nothing, you reply."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510 RETURN
PAUSE -1
END

EVENT "Wino Willys - Talk to hooker #1"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You talk to the women and gently reminds"
ATTRIBUTES edge 
TEXT 92 182 "them that in here they  aren't making any "
TEXT 92 204 "money. "
COLOR 11 0 7 7 7 0 11 7 0 11 10 11 10 10 11
TEXT 92 248 "- Get out on the street and make me some"
TEXT 92 270 "money, you tell them."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET score score+3  SET hooker 1 RETURN
PAUSE -1
END

EVENT "Wino Willys - Talk to hooker #2"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "They are working hard for you. "
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510 RETURN
PAUSE -1
END

EVENT "Wino Willys - Fighting gambler"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You find the drunk gambler. You try to talk"
ATTRIBUTES edge 
TEXT 92 182 "to him but he ignores you."
TEXT 92 226 "To show him (and the other guests) that you"
TEXT 92 248 "don`t mess around you grab him and drag"
TEXT 92 270 "him outside. There you mess him up badly."
TEXT 92 314 "You also take the $200 he owes you."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET gambler 2  SET score score+3  SET money money+200  GOTO "In the streets"
PAUSE -1
END

EVENT "In the streets - Police car"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 0 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You stick the banana into the tailpipe and"
ATTRIBUTES edge 
TEXT 92 182 "sneak away."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET banana 2  SET score score+2  GOTO "In the streets"
PAUSE -1
END

EVENT "Lounge - Guard"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "Your bodyguard nods his head and "
ATTRIBUTES edge 
TEXT 92 182 "unlocks the door for you."
COLOR 11 0 7 7 7 0 11 7 0 11 10 11 10 10 11
TEXT 92 226 "- Welcome Boss. How are you?"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 2 636 510  SET guard 1  GOTO Lounge
PAUSE -1
END

EVENT "Hotel lobby - Packages"
PICTURE "TAD:big-popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 80 44 "The concierge stops you and tells you that"
ATTRIBUTES edge 
TEXT 80 66 "a shipment of goods have arrived. "
TEXT 80 88 "He hands you two packages."
COLOR 11 0 7 7 7 0 11 7 0 11 10 11 10 10 11
TEXT 80 132 "- Deliver one to room 108 at Snuggler's Inn"
TEXT 80 154 "and the other to the shop beside "
TEXT 80 176 "Guns'n Ammo. "
COLOR 2 0 7 7 7 0 2 7 0 2 1 2 4 3 2
TEXT 80 220 "You look at him and answer:"
COLOR 4 0 7 7 7 0 4 7 0 4 3 3 4 4 4
TEXT 80 264 " - Thanks man!"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 2 636 510  SET package1 1  SET package2 1  SET score score+2 RETURN
PAUSE -1
END

EVENT "Hotel lobby - Banana"
PICTURE "TAD:big-popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 80 44 "The concierge looks at you and smiles."
COLOR 11 0 7 7 7 0 11 7 0 11 10 11 10 10 11
ATTRIBUTES edge 
TEXT 80 66 ""
TEXT 80 88 "- You look hungry Mr Sloan."
TEXT 80 110 " "
COLOR 2 0 7 7 7 0 2 7 0 2 1 2 4 3 2
TEXT 80 132 "He gives you a banana."
TEXT 80 154 ""
COLOR 4 0 7 7 7 0 4 7 0 4 3 3 4 4 4
TEXT 80 176 "- Thanks man! Appreciate it!"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 2 636 510  SET banana 1  SET score score+1 RETURN
PAUSE -1
END

EVENT "Hotel lobby - Concierge"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You nod your head to the concierge. He "
ATTRIBUTES edge 
TEXT 92 182 "smiles and looks at you."
COLOR 11 0 7 7 7 0 11 7 0 11 10 11 10 10 11
TEXT 92 226 "- Hello, Mr Sloan. Nice weather today."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 2 636 510 RETURN
PAUSE -1
END

EVENT "Lounge - Phone rings"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 90 164 "As you walk into your suite you hear the "
ATTRIBUTES edge 
TEXT 90 186 "phone ring."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET phone 2  GOTO Suite
PAUSE -1
END

EVENT "Outside hotel - Bamboni #1"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "Your associate, Gene Bamboni, approaches"
ATTRIBUTES edge 
TEXT 92 182 "you and tells you that Taselli has been "
TEXT 92 204 "arrested by the police on multiple charges. "
COLOR 11 0 7 7 7 0 11 7 0 11 10 11 10 10 11
TEXT 92 248 "- We tried to bail him out but the police"
TEXT 92 270 "managed to secure a no-bail warrant "
TEXT 92 292 "against him. We need to get him out!                        \
                                                                         \
            Taselli won't be released right now and "
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 2 636 510  SET taselli 2  GOTO "Hotel lobby"
PAUSE -1
END

EVENT "Outside hotel - Bamboni #2"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "Your associate, Gene Bamboni, approaches"
ATTRIBUTES edge 
TEXT 92 182 "you and tells you that one of the guests"
TEXT 92 204 "in the gambling room lost big and skipped"
TEXT 92 226 "from paying. He was rather drunk and"
TEXT 92 248 "probably went to Wino Willys."
COLOR 11 0 7 7 7 0 11 7 0 11 10 11 10 10 11
TEXT 92 292 "- Teach him a lesson!"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 2 636 510  SET gambler 1  GOTO "Hotel lobby"
PAUSE -1
END

EVENT "Outside hotel - Lipshitz"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "Your associate, Otto Lipshitz, approaches "
ATTRIBUTES edge 
TEXT 92 182 "you and informs you that a new delivery "
TEXT 92 204 "of merchandise is available at the usual"
TEXT 92 226 "pickup spot on Peach and 8th. "
TEXT 92 270 "You need to collect it and deliver it to your "
TEXT 92 292 "dealers at the inn, at Wino Willys and the "
TEXT 92 314 "city park."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 2 636 510  SET drugrun1 1  SET drugrun2 1  SET drugrun3 1  GOTO "Hotel lobby"
PAUSE -1
END

EVENT "Outside hotel - Locked car"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 0 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You can`t. Your car is locked and your keys "
ATTRIBUTES edge 
TEXT 92 182 "are where you left them. In the nightstand,"
TEXT 92 204 "beside your bed."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510 RETURN
PAUSE -1
END

EVENT "Outside hotel - Concierge"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "He smiles at you and says:"
COLOR 11 0 7 7 7 0 11 7 0 11 10 11 10 10 11
ATTRIBUTES edge 
TEXT 92 204 "- Hello, Mr Sloan."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510 RETURN
PAUSE -1
END

EVENT "Outside hotel - Gunfight #1"
PICTURE "TAD:big-popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 80 40 "Just as you are about to jump into your car,"
ATTRIBUTES edge 
TEXT 80 62 "Bonds rushes towards you waiving his gun "
TEXT 80 84 "and screaming:"
COLOR 11 0 7 7 7 0 11 7 0 11 10 11 10 10 11
TEXT 80 128 "- FREEZE!"
COLOR 2 0 7 7 7 0 2 7 0 2 1 2 4 3 2
TEXT 80 172 "You reach for you gun but it's too late. You "
TEXT 80 194 "catch two bullets with your body and fall to "
TEXT 80 216 "the ground, seriously wounded."
TEXT 80 260 "Within seconds two policecars arrive at"
TEXT 80 282 "high speed and the area is crowded with"
TEXT 80 304 "armed police officers."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  GOTO "Game over #2"
PAUSE -1
END

EVENT "Outside hotel - Gunfight #2"
PICTURE "TAD:big-popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 80 40 "Just as you are about to jump into your car,"
ATTRIBUTES edge 
TEXT 80 62 "Bonds rushes towards you waiving his gun "
TEXT 80 84 "and screaming:"
COLOR 11 0 7 7 7 0 11 7 0 11 10 11 10 10 11
TEXT 80 128 "- FREEZE!"
COLOR 2 0 7 7 7 0 2 7 0 2 1 2 4 3 2
TEXT 80 172 "You reach for you gun and pull the trigger"
TEXT 80 194 "rapidly twice. You manage to hit Bonds in "
TEXT 80 216 "the leg, he takes cover behind a car."
TEXT 80 260 "He fires a few bullets from his cover and "
TEXT 80 282 "a lucky shot hits you in the gut. Thank god"
TEXT 80 304 "you are wearing a bullet proof vest."
TEXT 80 348 "Before another police officer arrives at the"
TEXT 80 370 "hotel you get in your car and drive away."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET score score+2  GOTO "Game over #1"
PAUSE -1
END

EVENT "Suite - Answer phone - Taselli"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You pickup the phone."
COLOR 11 0 7 7 7 0 11 7 0 11 10 11 10 10 11
ATTRIBUTES edge 
TEXT 92 204 "- Hi boss, it`s me, Taselli. Meet me in my "
TEXT 92 226 "office down in the Old Warehouse District"
TEXT 92 248 "as soon as you can. I have good news!"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET phone 1  SET score score+2 RETURN
PAUSE -1
END

EVENT "Suite - Answer phone - Bonds"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You pickup the phone."
COLOR 11 0 7 7 7 0 11 7 0 11 10 11 10 10 11
ATTRIBUTES edge 
TEXT 92 204 "- Boss! Banksten is an undercover cop! His"
TEXT 92 226 "real name is Sonny Bonds. GET OUT!"
COLOR 2 0 7 7 7 0 2 7 0 2 1 2 4 3 2
TEXT 92 270 "Your only chance is to leave town. You run"
TEXT 92 292 "as fast as you can to your car."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET hunted 1  SET phone 3  SET score score+2 RETURN
PAUSE -1
END

EVENT "Suite - Answer phone - no one"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You pickup the phone..."
COLOR 2 0 7 7 7 0 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge 
TEXT 92 204 "Beeeeeep... No one is there."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510 RETURN
PAUSE -1
END

EVENT "Suite - Get key"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You open the drawer on the nightstand "
ATTRIBUTES edge 
TEXT 92 182 "and take your wallet and the keys to"
TEXT 92 204 "your car."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET carkeys 1  SET score score+1  SET money money+400 RETURN
PAUSE -1
END

EVENT "Suite - Can`t leave"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You can`t leave your suite without your "
ATTRIBUTES edge 
TEXT 92 182 "clothes, and you should also brush"
TEXT 92 204 "your teeth."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510 RETURN
PAUSE -1
END

EVENT "Suite - Get dressed"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You enter the bathroom and brush your"
ATTRIBUTES edge 
TEXT 92 182 "teeth. You also get dressed."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET bathroom 1  SET score score+1 RETURN
PAUSE -1
END

EVENT "Suite - Freshen up"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You enter the bathroom and freshen up."
ATTRIBUTES edge 
TEXT 92 182 "Now you`re ready to rumble!"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510 RETURN
PAUSE -1
END

EVENT "Gambling room - Not now"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 90 164 "You dont`t have time to play poker right"
ATTRIBUTES edge 
TEXT 90 186 "now. Maybe later."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510 RETURN
PAUSE -1
END

EVENT "Gambling room - Secret room"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 90 164 "Gene and Otto are looking for you. A"
ATTRIBUTES edge 
TEXT 90 186 "highstake pokergame is about to start in"
TEXT 90 208 "the backroom. "
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  GOTO "Gambling room"
PAUSE -1
END

EVENT "Gambling room - Playing poker"
PICTURE "TAD:big-popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 86 38 "You join the game, Otto and Gene are "
ATTRIBUTES edge 
TEXT 86 60 "already in the game."
TEXT 86 104 "Another guy also joins in. He introduces "
TEXT 86 126 "himself: "
COLOR 11 0 7 7 7 0 11 7 0 11 10 11 10 10 11
TEXT 86 170 "- Hi, I'm Jimmy Lee Banksten."
COLOR 2 0 7 7 7 0 2 7 0 2 1 2 4 3 2
TEXT 86 214 "You play for some time and manage to "
TEXT 86 236 "earn $300."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET poker 1  SET score score+5  SET money money+300 RETURN
PAUSE -1
END

EVENT "Gambling room - Choice"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 88 150 "This is the craps table. You bet $100 and "
TEXT 88 172 "you can win $200."
TEXT 88 222 "Would you like to play?"
FONT FuturaB.font 16
STYLE 0 3 4 3 6 1 1 17 
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
COLOR 12 0 7 3 4 0 12 7 0 12 11 11 0 11 12
ATTRIBUTES 3D edge 
STYLE 0 3 4 3 6 1 1 21 
BOX 432 266 528 326
COLOR 15 0 7 3 4 0 15 7 0 15 5 5 15 15 15
BOX 112 272 208 328
FONT FuturaB.font 20
COLOR 3 0 7 3 4 0 3 7 0 3 1 2 4 4 3
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 21 
TEXT 138 292 "YES"
COLOR 3 0 7 7 7 0 3 7 0 3 1 2 4 4 3
TEXT 466 290 "NO"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 5
BUTTON position 98 266 222 338  SET game random(1,10,time('S'))  IF game>6&highroller=0&money>=1800 GOTO "Gambling room - High roller"  IF game>6 GOTO "Gambling room - Win"  IF 1=1 GOTO "Gambling room - Loose"
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 11 13 14 15
BUTTON position 420 256 542 338  GOTO "Gambling room"
PAUSE -1
END

EVENT "Gambling room - Win"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 88 150 "You sit down at the table and buy into the"
TEXT 88 172 "game with $100."
FONT FuturaB.font 32
COLOR 5 0 7 7 7 0 5 7 0 5 5 5 15 15 5
STYLE 0 3 4 3 6 1 1 29 
TEXT 86 250 "You win $200! "
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET money money+200 RETURN
PAUSE -1
END

EVENT "Gambling room - High roller"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 88 150 "You sit down at the table and buy into the"
TEXT 88 172 "game with $100."
TEXT 90 306 "You are indeed a highroller!"
FONT FuturaB.font 32
COLOR 5 0 7 7 7 0 5 7 0 5 5 5 15 15 5
STYLE 0 3 4 3 6 1 1 29 
TEXT 86 250 "You win $200! "
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET money money+200  SET highroller 1  SET score score+3 RETURN
PAUSE -1
END

EVENT "Gambling room - Loose"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 88 150 "You sit down at the table and buy into the"
TEXT 88 172 "game with $100."
FONT FuturaB.font 32
COLOR 11 0 7 7 7 0 11 7 0 11 10 11 10 10 11
STYLE 0 3 4 3 6 1 1 29 
TEXT 88 254 "You loose $100! "
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET money money-100  IF money>=100 GOTO "Gambling room - Choice"  IF 1=1 GOTO "Gambling room"
PAUSE -1
END

EVENT "Gambling room - Proposition"
PICTURE "TAD:big-popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 0 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 72 38 "Before you leave the room you decide that"
ATTRIBUTES edge 
TEXT 72 60 "Banksten might be your new business "
TEXT 72 82 "associate. You ask him if he's looking "
TEXT 72 104 "for work:"
COLOR 11 0 7 7 7 0 11 7 0 11 10 11 10 10 11
TEXT 72 148 "- Yes, I do, he replies."
COLOR 4 0 7 7 7 0 4 7 0 4 3 3 4 4 4
TEXT 72 192 "- Come to my suite for a drink and a business"
TEXT 72 214 "proposition."
COLOR 11 0 7 7 7 0 11 7 0 11 10 11 10 10 11
TEXT 72 258 "- Ok, I'll be there in a few minutes, he replies."
COLOR 2 0 7 7 7 0 2 7 0 2 1 2 4 3 2
TEXT 72 302 "You leave the room."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET proposition 1  SET score score+1  GOTO "Gambling room"
PAUSE -1
END

EVENT "Old Warehouse District - Taselli"
PICTURE "TAD:big-popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 74 28 "You enter the shed and Taselli is sitting"
ATTRIBUTES edge 
TEXT 74 50 "at a desk."
COLOR 11 0 7 7 7 0 11 7 0 11 10 11 10 10 11
TEXT 74 94 "- Hey boss! I`ve iced Jose Martinez and Lonny"
TEXT 74 116 "West for ya. Lonny was driving his car on "
TEXT 74 138 "Peach and 6th, he never new what hit him."
TEXT 74 160 "Unfortunatelly I might have left a few bullets"
TEXT 74 182 "at the crime scene."
COLOR 2 0 7 7 7 0 2 7 0 2 1 2 4 3 2
TEXT 74 226 "You look at him and answer:"
COLOR 4 0 7 7 7 0 4 7 0 4 3 3 4 4 4
TEXT 74 270 "- Excellent news. Just what we need to take"
TEXT 74 292 "control of this city. I`\\ll take care of the bullets."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET taselli 1  SET score score+1 RETURN
PAUSE -1
END

EVENT "Old Warehouse District - Get TNT"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You find a crate with TNT. You open it"
ATTRIBUTES edge 
TEXT 92 182 "carefully and grab a few sticks of TNT."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET tnt 1  SET score score+1 RETURN
PAUSE -1
END

EVENT "Old Warehouse District - Get key"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You fetch the key to the locked shed, where"
ATTRIBUTES edge 
TEXT 92 182 "the explosives are kept."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET tnt 0  SET score score+1 RETURN
PAUSE -1
END

EVENT "Crime scene - Get bullets"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You search the crime scene and after a few"
ATTRIBUTES edge 
TEXT 92 182 "minutes you find what you are looking for, "
TEXT 92 204 "the bullets. You grab them quickly and put "
TEXT 92 226 "them in your pocket."
TEXT 92 248 ""
TEXT 92 270 "You should get rid of the evidence."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET bullets 1  SET score score+1  GOTO "Crime scene"
PAUSE -1
END

EVENT "Crime scene - Found nothing"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You search the crime scene a few minutes"
ATTRIBUTES edge 
TEXT 92 182 "and you find nothing."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510 RETURN
PAUSE -1
END

EVENT "Shop - Delivery #1"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "A young woman opens the door. You"
ATTRIBUTES edge 
TEXT 92 182 "give her the package, she hands you"
TEXT 92 204 "$50."
COLOR 5 0 7 7 7 0 5 7 0 5 5 5 15 15 5
TEXT 92 248 "Delivery completed!"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET package1 2  SET score score+2  SET money money+50 RETURN
PAUSE -1
END

EVENT "Shop - Closed"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "It's a Guns'n Ammo shop, it's closed."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510 RETURN
PAUSE -1
END

EVENT "Shop - Choice"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 88 150 "You enter the Guns'n Ammo shop. They"
TEXT 88 172 "have a sweet deal on bullet proof vests."
TEXT 88 194 "You find one made out of kevlar for $1500."
TEXT -236 80 "                                                            \
                                        "
TEXT 88 238 "Would you like to buy it?"
FONT FuturaB.font 16
STYLE 0 3 4 3 6 1 1 17 
TEXT 482 462 "Wallet: $!money"
TEXT 482 482 "Score: !score of !max"
COLOR 12 0 7 3 4 0 12 7 0 12 11 11 0 11 12
ATTRIBUTES 3D edge 
STYLE 0 3 4 3 6 1 1 21 
BOX 432 266 528 326
COLOR 15 0 7 3 4 0 15 7 0 15 5 5 15 15 15
BOX 112 272 208 328
FONT FuturaB.font 20
COLOR 3 0 7 3 4 0 3 7 0 3 1 2 4 4 3
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 21 
TEXT 138 292 "YES"
COLOR 3 0 7 7 7 0 3 7 0 3 1 2 4 4 3
TEXT 466 290 "NO"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 5
BUTTON position 98 266 222 338  GOTO "Shop - Buy vest"
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 11 13 14 15
BUTTON position 420 256 542 338  GOTO "Shop - Browse"
PAUSE -1
END

EVENT "Shop - Buy vest"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You buy the bullet proof vest for $1500."
ATTRIBUTES edge 
TEXT 92 204 "You put it on right away. Better safe than"
TEXT 92 226 "sorry."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET vest 1  SET score score+5  SET money money-1500  GOTO "Guns'n Ammo"
PAUSE -1
END

EVENT "Shop - Browse"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 0 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You decide that you don't need a bullet"
ATTRIBUTES edge 
TEXT 92 182 "proof vest."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  GOTO "Guns'n Ammo"
PAUSE -1
END

EVENT "Shop - Not enough money"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You enter the guns'n ammo shop. "
ATTRIBUTES edge 
TEXT 92 182 "You find a bullet proof vest for $1500, but"
TEXT 92 204 "you don't have that much money."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510 RETURN
PAUSE -1
END

EVENT "Woods - Get drugs"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You get the merchandise and load it in your"
TEXT 92 182 "car. You pay the man."
COLOR 11 0 7 7 7 0 11 7 0 11 10 11 10 10 11
TEXT 92 226 "- Nice to do business with you, mr Sloan."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET drugrun1 2  SET drugrun2 2  SET drugrun3 2  SET money money-700  SET score score+5  GOTO "Woods - Empty"
PAUSE -1
END

EVENT "Woods - Not enough money"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 0 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You don't have enough money to pay"
TEXT 92 182 "for the merchandise. You need $700, you"
TEXT 92 204 "only have $!money."
TEXT 92 248 "Earn some more cash!"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510 RETURN
PAUSE -1
END

EVENT "City jail - Jailbreak"
PICTURE "TAD:big-popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 82 40 "Using the TNT you blow up the door at the"
ATTRIBUTES edge 
TEXT 82 62 "city jail. Your goons runs in, locates Taselli"
TEXT 82 84 "and get him out of there."
TEXT 82 128 "The risk of him getting caught again is too "
TEXT 82 150 "high, and if caught he might snitch."
TEXT 82 172 "So you decide to remove that problem by"
TEXT 82 194 "eliminating him right now. "
TEXT 82 238 "As soon as he gets into the getaway car you"
TEXT 82 260 "pull your gun and put a bullet in the back of "
TEXT 82 282 "his head. Problem solved!"
TEXT 82 326 "Now you need a place to dump his body. "
TEXT 82 348 "You tell the driver to go to Cotton Cove."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET taselli 3  SET tnt 2  SET score score+5 RETURN
PAUSE -1
END

EVENT "City jail - Can't break door"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You can't bust the door open, it's too"
ATTRIBUTES edge 
TEXT 92 182 "robust. You need explosives. "
TEXT 92 226 "You remember that Taselli used to keep "
TEXT 92 248 "some TNT at the warehouse. "
TEXT 92 270 "Perhaps it's still there.  "
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510 RETURN
PAUSE -1
END

EVENT "City park - Deliver drugs #1"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You give the merchandise to the dealer,"
ATTRIBUTES edge 
TEXT 92 182 "and he hands you a big wad of cash."
COLOR 11 0 7 7 7 0 11 7 0 11 10 11 10 10 11
TEXT 92 226 "- Thanks, mr Sloan."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET drugrun1 3  SET money money+500  SET score score+3  GOTO "City park - Empty"
PAUSE -1
END

EVENT "Snuggler's Inn - Deliver drugs #3"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 0 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You give the merchandise to the dealer."
ATTRIBUTES edge 
TEXT 92 182 "He hands you some cash and stutters:"
COLOR 11 0 7 7 7 0 11 7 0 11 10 11 10 10 11
TEXT 92 226 "- Thank you mr Sloan. Same time next "
TEXT 92 248 "week?"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET drugrun3 3  SET money money+500  SET score score+3  GOTO "Snuggler's Inn - Empty"
PAUSE -1
END

EVENT "Snuggler's Inn - Delivery #2"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 0 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "An older man opens the door. You give"
ATTRIBUTES edge 
TEXT 92 182 "him the package, he hands you ¤$50."
COLOR 5 0 7 7 7 0 5 7 0 5 5 5 15 15 5
TEXT 92 226 "Delivery completed!"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET package2 2  SET score score+2  SET money money+50 RETURN
PAUSE -1
END

EVENT "Cotton cove - Dump body"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You dump the dead body in the water."
ATTRIBUTES edge 
TEXT 92 182 "Hopefully it`ll sink to the bottom."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET taselli 4  SET score score+4 RETURN
PAUSE -1
END

EVENT "Cotton cove - Dump bullets"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 92 160 "You throw the bullets into the water."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  SET bullets 2  SET score score+1 RETURN
PAUSE -1
END

EVENT "Intro #1"
PICTURE "TAD:big-popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 70 30 "You`re Jessie Bains, a drug-dealer and "
ATTRIBUTES edge 
TEXT 70 52 "card shark with the intention to take "
TEXT 70 74 "control of the city of Lytton. "
COLOR 2 0 7 7 7 0 2 7 0 2 1 2 4 3 2
TEXT 70 118 "You`re in your suite at the Hotel Delphoria."
TEXT 70 140 "This is your permanent residence and you"
TEXT 70 162 "go by the alias \"\Frank Sloan\"\. As a gambler,"
TEXT 70 184 "you began financing your drug-related"
TEXT 70 206 "operations by running an illegal gambling"
TEXT 70 228 "hall at this hotel."
TEXT 70 272 "Your number one, Jason Taselli, is running "
TEXT 70 294 "the daily business. "
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  GOTO "Intro #2"
PAUSE -1
END

EVENT "Intro #2"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 82 156 "The phone rings and wake you up."
TEXT 82 200 "Maybe it`s Tasselli breaking the news that "
TEXT 82 222 "the competition has been reduced in "
TEXT 82 244 "numbers."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  GOTO Suite
PAUSE -1
END

EVENT Instructions
PICTURE "TAD:big-popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 80 40 "This game is based on Police Quest 1, and "
ATTRIBUTES edge 
TEXT 80 62 "you play the role of Jessie Bains, the "
TEXT 80 84 "antagonist in the original game."
TEXT 80 128 "You objective is to take control over the "
TEXT 80 150 "city within the following areas:"
TEXT 80 172 " "
TEXT 80 194 "- Drug trafficing"
TEXT 80 216 "- Illegal gambling"
TEXT 80 238 "- Prostitution  "
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510 RETURN
PAUSE -1
END

EVENT Credits
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 20
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
STYLE 0 3 4 3 6 1 1 21 
TEXTWIPE dump speed 1
TEXT 84 170 "Based on Police Quest 1 by Sierra On-Line."
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510 RETURN
PAUSE -1
END

EVENT "Game over #1"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap center 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
TEXT 232 146 "Game over"
FONT FuturaB.font 20
COLOR 5 0 7 7 7 0 5 7 0 5 5 5 15 15 5
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 21 
TEXT 124 270 "Overall rating: Crime does pay!"
COLOR 2 0 7 7 7 0 2 7 0 2 1 2 4 3 2
TEXT 126 206 "Money: $!money"
TEXT 126 228 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  GOTO Start
PAUSE -1
END

EVENT "Game over #2"
PICTURE "TAD:popup.iff"
TABS 100 200 300 400 500
MARGINS on 32 607
FONT FuturaB.font 32
COLOR 2 0 7 7 7 14 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap center 
STYLE 0 3 4 3 6 1 1 29 
TEXTWIPE dump speed 1
TEXT 232 146 "Game over"
FONT FuturaB.font 20
COLOR 11 0 7 7 7 0 11 7 0 11 10 11 10 10 11
ATTRIBUTES edge 
STYLE 0 3 4 3 6 1 1 21 
TEXT 124 270 "Overall rating: Crime does not pay!"
COLOR 2 0 7 7 7 0 2 7 0 2 1 2 4 3 2
ATTRIBUTES edge remap 
TEXT 126 206 "Money: $!money"
TEXT 126 228 "Score: !score of !max"
MARK replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
SELECT replace 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
BUTTON position 0 4 636 510  GOTO Start
PAUSE -1
END

