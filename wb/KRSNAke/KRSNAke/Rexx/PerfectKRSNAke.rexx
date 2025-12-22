/*
 * $VER: PerfectKRSNAke.rexx 1.003 (22 Feb 1996) by Petter E. Stokke
 *
 *  This ARexx script plays a game that should score 1023 points
 *  (but is very dull to watch...)
 *
 *  As KRSNAke is a real-time game, ARexx can have trouble keeping
 *  up with it. Because of that, you may find that this script
 *  crashes the snake a lot on your machine. If that happens, you
 *  should fiddle around with the safety variable and the snake
 *  speed until it works fine. The current settings are tuned for
 *  my 68030/50MHz running MULTISCAN:Productivity, 6 bitplanes.
 *
 * $HISTORY:
 *
 * 22 Feb 1996 : 001.003 :  Improved intelligence a little
 * 26 Jan 1996 : 001.002 :  Updated for v1.16 arexx port
 * 20 Sep 1995 : 001.001 :  Initial revision
 *
 */

OPTIONS RESULTS
ADDRESS KRSNAKE


safety = 6      /* Min 2, Max 31 ! */
SET SPEED 1     /* Min 1, Max  9 ! */
NEWGAME


/* Go to starting position */

UP
WAIT UNTIL Y 1
LEFT
WAIT UNTIL X 0
UP
RIGHT

score = 0

/* Main loop */

DO WHILE score<1023

    sequence = 0
    dangerlevel = 2
    DO WHILE sequence<15
        GET FRUIT X
        fruitx = result
        GET FRUIT Y
        fruitlevel = result % 2
        dist = safety
        IF fruitlevel = sequence THEN dist = fruitx
        IF dist < safety THEN dist = safety
        CHECK 1 dangerlevel
        IF result > 0 THEN dist = 31
        WAIT UNTIL X dist
        DOWN
        LEFT
        WAIT UNTIL X 1
        DOWN
        RIGHT
        sequence = sequence+1
        dangerlevel = dangerlevel+2
        GET PLAYING
        IF result = 0 THEN EXIT
    END

    /* return to starting position */

    WAIT UNTIL X 31
    DOWN
    LEFT
    WAIT UNTIL X 0
    UP
    WAIT UNTIL Y 0
    RIGHT

    GET LENGTH
    score = result
    IF score > 700 THEN safety = 31

END

