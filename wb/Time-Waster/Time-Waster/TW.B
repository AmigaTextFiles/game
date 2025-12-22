REM
REM  ***********************************************************************
REM  *                                                                     *
REM  *      This is a simple game written in ~ACE Basic Compiler~...       *
REM  *                     (C)2004 B.Walker, G0LCU...                      *
REM  *                                                                     *
REM  ***********************************************************************
REM

REM Setup the standard Workbench window.
  LET version$="$VER: Time-Waster_Version_00.90.86_(C)B.Walker_Date_11-01-2004."
  WINDOW 1,"Time-Waster, ~Q~ or ~q~ to Quit.",(0,0)-(640,200),6
  FONT "topaz.font",8
start:
  COLOR 2,0
  CLS
  LINE (0,160)-(632,160),2
  LINE (0,161)-(632,161),1
  PENUP
  SETXY 196,171
  PRINT "Find the gadget, (if you can)...";
  COLOR 3,0
  PENUP
  SETXY 68,182
  PRINT version$;
  COLOR 1,0
  RANDOMIZE TIMER

REM Set up variables.
  LET a$="(C)2004 B.walker, G0LCU."
  LET b$="                    "
  LET c$="You've got to be a moron to play this."
  LET difficulty=4
  LET x=2
  LET y=1
  LET x1=2
  LET x2=18
  LET y1=1
  LET y2=9
  LET clicksleft=40
  LET clickstaken=0
  LET clicks=0
  LET show=0
  LET display=0
  LET goodcomments=0
  LET badcomments=0

REM Set up the text on the screen.
  LOCATE 3,1
  PRINT "    Somewhere in  this window is  a hidden gadget  that you  have to find."
  PRINT
  PRINT "    Just left click  anywhere in the window and if you are  lucky you will"
  PRINT
  PRINT "    reveal it.  There are  three levels of difficulty and ~HARD~ is almost" 
  PRINT
  PRINT "    impossible,  whereas ~EASY~ is  ridiculously easy.  The number of left" 
  PRINT
  PRINT "    clicks  allowed is  random but  ~HARD~  mode has  the least  number..."
  LOCATE 15,34
  PRINT "Have fun..."

REM Set up random gadget position.
  LOCATE 19,15
  PRINT "Press ~e~ for EASY, ~m~ for MEDIUM or ~h~ for HARD.";
start1:
  LET a$=INKEY$
  IF a$="e" OR a$="E" THEN LET difficulty=4
  IF a$="m" OR a$="M" THEN LET difficulty=2
  IF a$="h" OR a$="H" THEN LET difficulty=1
  IF a$="q" OR a$="Q" THEN GOTO getout1:
  IF a$="?" THEN LET show=1
  IF a$="!" THEN LET display=1
  IF a$="?" OR a$="!" THEN GOTO start1:
  IF a$="" THEN GOTO start1:
  FOR n=1 TO 20
  LOCATE n,1
  PRINT b$;b$;b$;b$;
  NEXT n
  LET x=INT((RND)*631)
  LET y=INT((RND)*160)
  IF x<=18 THEN LET x=18
  IF x>=630 THEN LET x=630
  IF y<=9 THEN LET y=9
  IF y>=159 THEN LET y=159
  IF difficulty=4 AND x<=66 THEN LET x=66
  IF difficulty=2 AND x<=34 THEN LET x=34
  IF difficulty=1 AND x<=18 THEN LET x=18
  IF difficulty=4 AND y<=33 THEN LET y=33
  IF difficulty=2 AND y<=17 THEN LET y=17
  IF difficulty=1 AND y<=9 THEN LET y=9
  IF difficulty=4 THEN LET clicksleft=INT(((RND)*11)+30)
  IF difficulty=2 THEN LET clicksleft=INT(((RND)*11)+20)
  IF difficulty=1 THEN LET clicksleft=INT(((RND)*11)+10)
  IF show=1 AND difficulty=4 THEN LET clicksleft=1
  IF show=1 AND difficulty=2 THEN LET clicksleft=2
  IF show=1 AND difficulty=1 THEN LET clicksleft=4
  IF display=1 AND difficulty=4 THEN LET clicksleft=1
  IF display=1 AND difficulty=2 THEN LET clicksleft=2
  IF display=1 AND difficulty=1 THEN LET clicksleft=4
  LET clickstaken=clicksleft
  LET x1=(x-(16*difficulty))
  LET y1=(y-(8*difficulty))
  LET x2=x
  LET y2=y

REM --------------------------------------------------------------------------
REM These are the optional cheat facilities.
  IF display=1 THEN GADGET 255,ON,"",(x1,y1)-(x2,y2),BUTTON,1,"topaz.font",8,0
  SLEEP FOR 0.1
  IF display=1 THEN GADGET CLOSE 255
REM --------------------------------------------------------------------------

  GADGET 255,ON,"",(x1,y1)-(x2,y2),BUTTON,3,"topaz.font",8,0

REM --------------------------------------------------------------------------
REM These are the main cheat facilities.
  IF show=1 THEN PENUP
  IF show=1 THEN SETXY 196,171
  IF show=1 THEN PRINT "X position =";INT((x1+x2)/2);CHR$(8);", Y position =";INT((y1+y2)/2);CHR$(8);".    ";
REM --------------------------------------------------------------------------

  SLEEP FOR 1
  PENUP
  SETXY 196,171
  PRINT "    You have";clicksleft;"attempts left.          ";

mainloop:
  LET a$=INKEY$
  IF a$="q" OR a$="Q" THEN GOTO getout:
  LET x=MOUSE(1)
  LET y=MOUSE(2)
  IF MOUSE(0)=-1 THEN GOTO nextclick:
  GOTO mainloop:
nextclick:
  SLEEP FOR 0.25
  IF x>=x1 AND x<=x2 AND y>=y1 AND y<=y2 THEN GOTO replay:
  LET clicksleft=clicksleft-1
  PENUP
  SETXY 196,171
  PRINT "    You have";clicksleft;"attempts left.          ";
  IF clicksleft<=0 THEN GOTO replay:
  GOTO mainloop:

replay:
  GADGET CLOSE 255
  CLS
  GADGET 255,ON,"",(x1,y1)-(x2,y2),BUTTON,1,"topaz.font",8,0
  SLEEP FOR 2
  GADGET CLOSE 255
  CLS
  IF clicksleft>=1 THEN GOSUB goodcomment:
  IF clicksleft<1 THEN GOSUB badcomment:
  LOCATE 12,32
  PRINT "Rerun Game, (Y/N).";
  LOCATE 19,23
  PRINT c$;
replay1:
  LET a$=INKEY$
  IF a$="y" OR a$="Y" THEN GOTO start:
  IF a$="n" OR a$="N" OR a$="q" OR a$="Q" THEN GOTO getout1:
  GOTO replay1:

goodcomment:
  LET clicks=(clickstaken-clicksleft+1)
  BEEP
  FONT "topaz.font",16
  COLOR 3,0
  LOCATE 2,15
  PRINT "Winner... :)";
  FONT "topaz.font",8
  COLOR 1,0
  LOCATE 17,21
  PRINT "(You took";clicks;"attempts to find the gadget.)"
  LET goodcomments=INT((RND)*11)
  IF goodcomments=1 THEN LET c$="   Think you are smart arse eh!."
  IF goodcomments=2 THEN LET c$="OK wise guy, try again if you dare."
  IF goodcomments=3 THEN LET c$="Think you are bloody good don't you."
  IF goodcomments=4 THEN LET c$="   Try ~HARD~ mode for a change."
  IF goodcomments=5 THEN LET c$=" Well, your luck is in, try again."
  IF goodcomments=6 THEN LET c$=" Well done, you are getting better."
  IF goodcomments=7 THEN LET c$=" You cheated, you have hacked me!."
  IF goodcomments=8 THEN LET c$="             Well done."
  IF goodcomments=9 THEN LET c$="I don't believe it, you've succeeded."
  IF goodcomments=10 THEN LET c$="         Congratulations."
  RETURN

badcomment:
  FONT "topaz.font",16
  COLOR 3,0
  LOCATE 2,15
  PRINT "Loser.... :(";
  FONT "topaz.font",8
  COLOR 1,0
  LET badcomments=INT((RND)*11)
  IF badcomments=1 THEN LET c$="       Doh!... What an idiot."
  IF badcomments=2 THEN LET c$=" You are bloody useless, try again."
  IF badcomments=3 THEN LET c$="And you thought you were a smart arse."
  IF badcomments=4 THEN LET c$="      Ha!... You're hopeless."
  IF badcomments=5 THEN LET c$="If at first you don't succeed try again."
  IF badcomments=6 THEN LET c$="You're the worst one I've come across."
  IF badcomments=7 THEN LET c$="You've only got to find a bloody square."
  IF badcomments=8 THEN LET c$="      Ahh... Never mind loser."
  IF badcomments=9 THEN LET c$="     I'd give up if I were you."
  IF badcomments=10 THEN LET c$="       How can you be so crap."
  RETURN

getout:
  GADGET CLOSE 255
getout1:
  WINDOW CLOSE 1
  END
