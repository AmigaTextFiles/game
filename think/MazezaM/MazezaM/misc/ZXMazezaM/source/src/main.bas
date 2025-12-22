#ifdef FINAL_BUILD
@START: SAVE "MazezaM 3" CODE 23552,9500: POKE 23659,0
#else
@START: POKE 23659,0
#endif
  REM ***********************
  REM *******         *******
  REM ******* MazezaM *******
  REM *******         *******
  REM ***********************
  REM
  REM   Copyright (C) 2002
  REM    Malcolm  Tyrrell
  REM   tyrrelmr@cs.tcd.ie
  REM
  REM This code may be used
  REM and distributed under
  REM the terms of the GNU
  REM General Public Licence.

#include "constants.bas"

  RANDOMIZE
  RESTORE @MAZEVALUES
  READ nummazes,maxwidth,maxheight
  DIM a$(maxheight,maxwidth)

@MENU: REM ** Menu **
  OUT 254,0: POKE 23624,0
  INK 7: PAPER 0: FLASH 0: BRIGHT 0: OVER 0: INVERSE 0
  PRINT AT 0,0;
  PRINT "\f\f             \f\f             \f\f"
  PRINT "\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f"
  PRINT "\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f"
  PRINT "\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f"
  PRINT "\f\f\f\f\f                      \f\f\f\f\f"
  PRINT "\f\f\f\f\f       ";
  PRINT INK 5;BRIGHT 1;"MazezaM";
  PRINT "        \f\f\f\f\f"
  PRINT "\f\f\f\f\f                      \f\f\f\f\f"
  PRINT "\f\f\f\f\f        ";
  PRINT INK 2;BRIGHT 1;"\*2002";
  PRINT "         \f\f\f\f\f"
  PRINT "\f\f\f\f\f   ";
  PRINT INK 2;BRIGHT 1;"Malcolm Tyrrell";
  PRINT "    \f\f\f\f\f"
  PRINT "\f\f\f\f\f                      \f\f\f\f\f"
  PRINT "\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f"
  PRINT "\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f"
  PRINT "\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f"
  INK 3
  BRIGHT 1
  PRINT "                                "
  PRINT "              ";INVERSE 1;"KEYS";INVERSE 0;"              "
  PRINT "                                "
  PRINT "   LEFT  = ";CHR$(LEFT_KEY);"        UP    = ";CHR$(UP_KEY);"   "
  PRINT "   RIGHT = ";CHR$(RIGHT_KEY);"        DOWN  = ";CHR$(DOWN_KEY);"   "
  PRINT "                                "
  PRINT "        RETRY LEVEL = ";CHR$(RETRY_KEY);"         "
  PRINT "        QUIT GAME   = ";CHR$(QUIT_KEY);"         "
  PRINT "                                "
  PRINT "                                "
  PRINT INK 5; "     Press any key to start     "
@KEYLOOP: IF INKEY$ = "" THEN GO TO @KEYLOOP
  GO SUB @NEWGAME
  GO TO @MENU

@NEWGAME: REM ** new game **
  LET mazeno=1
  LET lives=3

@SETUPMAZE: REM ** set up maze **
  GO SUB @LOADMAZE
  REM ** draw screen **
  INK 7: PAPER 0: FLASH 0: BRIGHT 0: OVER 0: INVERSE 0
  PRINT AT 0,0;"\f\f";
  PRINT INK 5; BRIGHT 1;"* LEVEL  ";
  IF mazeno < 10 THEN PRINT INK 5; BRIGHT 1; "0";
  PRINT INK 5; BRIGHT 1; mazeno;" *";
  PRINT "\f\f";
  PRINT INK 5; BRIGHT 1;"* LIVES  ";
  IF lives < 10 THEN PRINT BRIGHT 1; INK 5; "0";
  PRINT INK 5; BRIGHT 1; lives;" *";
  PRINT "\f\f"
  FOR i=1 TO t
    PRINT "\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f"
  NEXT i
  FOR i=1 TO h
    IF i=lx THEN PRINT "________________"(1 TO l);
    IF i<>lx THEN PRINT "\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f"(1 TO l);
    PRINT INK ROW_COLOUR; BRIGHT 1;a$(i)(1 TO w); INK 7; BRIGHT 0;
    IF i=rx THEN PRINT "________________"(1 TO r)
    IF i<>rx THEN PRINT "\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f"(1 TO r)
  NEXT i
  FOR i=t+h+1 TO 22
    PRINT "\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f"
  NEXT i
  IF LEN n$ = 0 THEN PRINT "\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f": GO TO @SKIPNAME
  PRINT "\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f"(1 TO INT ((28-LEN n$)/2));
  PRINT INK 5; BRIGHT 1;"* ";n$;" *";
  PRINT "\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f\f"(1 TO 28-(INT ((28-LEN n$)/2+LEN n$)));
@SKIPNAME: \
    FOR i=0 TO l-1
    PRINT AT t+lx,i;BRIGHT 1;"\a"
    PAUSE ANIMATION_DELAY
    PRINT AT t+lx,i;BRIGHT 0;"_"
  NEXT i
  PRINT AT t+lx,l-1;BRIGHT 0;"\g"
  BRIGHT 1
  GO SUB @MAININIT
  IF lives<0 THEN GO SUB @GAMEOVER : RETURN 
  IF mazeno>nummazes THEN GO SUB @ENDOFGAME : RETURN 
  GO TO @SETUPMAZE

@MAININIT: REM ** main loop init **
  LET k=0
  LET o=0
  LET i=lx
  LET j=1
  PRINT INK 7; AT t+i,l+j-1;"\a"

@MAINLOOP: REM ** main loop **
  LET k=CODE INKEY$
  IF o=k THEN GO TO @MAINLOOP
  LET o=k
  IF k=RIGHT_KEY AND j<w THEN \
    IF a$(i,j+1)=" " THEN \
      PRINT AT t+i,l+j-1;" ":\
      LET j=j+1:\
      PRINT AT t+i,l+j-1; INK 7;"\a":\
      GO TO @MAINLOOP
  IF k=LEFT_KEY AND j>1 THEN \
    IF a$(i,j-1)=" " THEN \
      PRINT AT t+i,l+j-1;" ":\
      LET j=j-1:\
      PRINT AT t+i,l+j-1; INK 7;"\a":\
      GO TO @MAINLOOP
  IF k=RIGHT_KEY AND j<w THEN \
    IF a$(i,w)=" " THEN\
      LET j=j+1:\
      LET a$(i)=" "+a$(i)(1 TO w-1):\
      PRINT AT t+i,l; INK ROW_COLOUR;a$(i)(1 TO w);\
      INK 7; AT t+i,l+j-1;"\a":\
      GO TO @MAINLOOP
  IF k=LEFT_KEY AND j>1 THEN \
    IF a$(i,1)=" " THEN \
      LET j=j-1:\
      LET a$(i)=a$(i)(2 TO w)+" ":\
      PRINT AT t+i,l; INK ROW_COLOUR;a$(i)(1 TO w);\
      INK 7;AT t+i,l+j-1;"\a":\
      GO TO @MAINLOOP
  IF k=DOWN_KEY AND i<h THEN \
    IF a$(i+1,j)=" " THEN \
      PRINT AT t+i,l+j-1;" ":\
      LET i=i+1:\
      PRINT AT t+i,l+j-1; INK 7;"\a":\
      GO TO @MAINLOOP
  IF k=UP_KEY AND i>1 THEN \
    IF a$(i-1,j)=" " THEN \
      PRINT AT t+i,l+j-1;" ":\
      LET i=i-1:\
      PRINT AT t+i,l+j-1; INK 7;"\a":\
      GO TO @MAINLOOP
  IF k=RIGHT_KEY THEN \
    IF i=rx AND j=w THEN \
      PRINT AT t+i,l+j-1;" ":\
      GO TO @ENDOFLEVEL
  IF k=RETRY_KEY THEN \
    PRINT AT t+i-1,l+j-3;INK 7;"ARGH!":\
    LET lives=lives-1: \
    RETURN 
  IF k=QUIT_KEY THEN LET lives=-1: RETURN 
#ifdef DEBUG_KEYS
  IF k=NEXT_KEY THEN LET mazeno=mazeno+1: RETURN
  IF k=PREVIOUS_KEY THEN LET mazeno=mazeno-1: RETURN
  IF k=EXTRALIVES_KEY THEN LET lives=99
#endif
  GO TO @MAINLOOP

@ENDOFLEVEL: REM ** end of level **
  INK 7
  FOR i=l+w TO 31
  PRINT AT t+rx,i;BRIGHT 1;"\a"
  PAUSE ANIMATION_DELAY
  PRINT AT t+rx,i;BRIGHT 0;"_"
  NEXT i
  LET i = INT(RND*6)
  IF i=0 THEN PRINT AT t+rx,24;BRIGHT 1;"Hurray!\a"
  IF i=1 THEN PRINT AT t+rx,24;BRIGHT 1;"Hurrah!\a"
  IF i=2 THEN PRINT AT t+rx,27;BRIGHT 1;"Yes!\a"
  IF i=3 THEN PRINT AT t+rx,25;BRIGHT 1;"Great!\a"
  IF i=4 THEN PRINT AT t+rx,23;BRIGHT 1;"Yee-hah!\a"
  IF i=5 THEN PRINT AT t+rx,27;BRIGHT 1;"Yay!\a"
  PAUSE HURRAY_DELAY
  LET mazeno=mazeno+1
  RETURN 

@GAMEOVER: REM ** game over **
  PRINT AT 12,11;FLASH 1;BRIGHT 1; INK 7;"GAME OVER!"
  FOR i = 1 TO GAMEOVER_LOOPDELAY:NEXT i
  RETURN

@ENDOFGAME: REM ** end of game **
  INK 7: BRIGHT 0
  PRINT AT 0,0;"      \f\f                        "
  PRINT "\f\f\f\f\f\f\f\f                        "
  PRINT "\f\f\f\f\f\f\f\f                        "
  PRINT "\f\f\f\f\f\f\f\f                        "
  PRINT "\f\f\f\f\f\f\f\f         ";BRIGHT 1;"You have       "
  PRINT "\f\f\f\f\f\f\f\f         ";BRIGHT 1;"escaped.       "
  PRINT "\f\f\f\f\f\f\f\f                        "
  PRINT "\f\f\f\f\f\f\f\f        ";BRIGHT 1;FLASH 1;"WELL DONE!";FLASH 0;"      "
  PRINT "\f\f\f\f\f\f\f\f                        "
  PRINT "\f\f\f\f\f\f\f\f                        "
  PRINT "\f\f\f\f\f\f\f\f                        "
  PRINT "\f\f\f\f\f\f\f\f                        "
  PRINT "\f\f\f\f\f\f\f\f                        "
  PRINT "________                        "
  PRINT "\f\f\f\f\f\f\f\f";BRIGHT 1;INK 2;"\c\d\e";INK 4;INVERSE 1;"\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i"
  PRINT "\f\f\f\f\f\f\f\f   ";BRIGHT 1;INK 4;INVERSE 1;"\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i"
  PRINT "\f\f\f\f\f\f\f\f";BRIGHT 1;INK 1;"_ _";INVERSE 1;INK 4;"\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i"
  PRINT "\f\f\f\f\f\f\f\f";BRIGHT 1;INK 1;INVERSE 1;"\h\h\h";INK 4;"\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i"
  PRINT "\f\f\f\f\f\f\f\f";BRIGHT 1;INK 1;INVERSE 1;"\h\h\h";INK 4;"\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i"
  PRINT "\f\f\f\f\f\f\f\f";BRIGHT 1;INK 1;INVERSE 1;"\h\h\h";INK 4;"\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i"
  PRINT "\f\f\f\f\f\f\f\f";BRIGHT 1;INK 1;INVERSE 1;"\h\h\h";INK 4;"\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i"
  PRINT "\f\f\f\f\f\f\f\f";BRIGHT 1;INK 1;INVERSE 1;"\h\h\h";INK 4;"\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i"
  PRINT "\f\f\f\f\f\f\f\f";BRIGHT 1;INK 1;INVERSE 1;"\h\h\h";INK 4;"\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i"
  PRINT "\f\f\f\f\f\f\f\f";BRIGHT 1;INK 1;INVERSE 1;"\h\h\h";INK 4;"\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i\i"
  FOR i=0 TO 31
    IF i < 19 OR i > 21 THEN PRINT AT 13,i;BRIGHT 1;"\a"
    IF i >= 19 AND i <= 21 THEN PRINT AT 12,i;BRIGHT 1;"\a"
    PAUSE ENDANIMATION_DELAY
    IF i = 20 THEN PRINT AT 11,18;BRIGHT 1;"Hurray!"
    IF i = 24 THEN PRINT AT 11,18;"       "
    IF i < 8 THEN PRINT AT 13,i;BRIGHT 0;"_"
    IF (i >= 8 AND i < 19) OR i > 21 THEN PRINT AT 13,i;" "
    IF i >= 19 AND i <= 21 THEN PRINT AT 12,i;" "
  NEXT i
@KEYLOOP2: IF INKEY$ = "" THEN GO TO @KEYLOOP2
  RETURN

@LOADMAZE: REM ** load mazes **
  RESTORE 2+@MAZEDATA +4*(mazeno-1)
  READ n$,c$,w,h,lx,rx
  FOR i = 1 TO h
    READ a$(i)
  NEXT i
  LET l=INT ((32-w)/2)
  LET t=INT ((24-h)/2)
  LET r=32-l-w
  RETURN 
 
#include <levels.bas>
