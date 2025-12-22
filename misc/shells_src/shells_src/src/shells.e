/*
                               Shells gambling game
                            Created by Almos Rajnai, 1996

  LICENSE: This file is part of Shells.
  Shells is published under the terms of the GNU GPL License v2
  Please see readme.txt file for details.
*/

CONST WIDTH=320, HEIGHT=256

MODULE 'intuition/intuition', 'intuition/screens',
    'graphics/rastport','graphics/gfx',
    'tools/scrbuffer','dos/dos','exec/memory',
    '*shellsgui'

ENUM ERR_LEN=1,ERR_NEW,ERR_OPEN,ERR_READ,ERR_KICK,ERR_GUI,ERR_WRITE

RAISE ERR_LEN  IF FileLength()<=0,
      ERR_NEW  IF New()=NIL

DEF bscr, scr=NIL:PTR TO screen,
    win=NIL:PTR TO window,
    filehandle=NIL, filename, leveladd, score, level, showshellers2me

PROC main() HANDLE

DEF myrp:rastport, im:PTR TO intuimessage, ds:datestamp,
    anim1=NIL, -> Right<-> Middle
    anim2=NIL, -> Left <-> Middle
    anim3=NIL, -> Left <-> Right

    anim4=NIL, -> Left   ^
    anim5=NIL, -> Middle ^
    anim6=NIL, -> Right  ^

    anim7=NIL, -> Left   ^ *
    anim8=NIL, -> Middle ^ *
    anim9=NIL, -> Right  ^ *

    p:PTR TO CHAR, bm:bitmap, p2:PTR TO CHAR, view, i,
    r,g,b,pal:PTR TO CHAR,

    goon, ball, pick, x, y, goonstore,
    dontstopthepress

                              /* Initalization */

IF KickVersion(39)=FALSE THEN Raise(ERR_KICK)

intuigraphptr:=AllocMem(4320, MEMF_CLEAR+MEMF_CHIP)

filename:='anim1'
anim1:=load()
filename:='anim2'
anim2:=load()
filename:='anim3'
anim3:=load()

filename:='anim4'
anim4:=load()
filename:='anim5'
anim5:=load()
filename:='anim6'
anim6:=load()

filename:='anim7'
anim7:=load()
filename:='anim8'
anim8:=load()
filename:='anim9'
anim9:=load()

filename:='pal'
pal:=load()

filename:='intuigraph'
load(intuigraphptr)

level:=0
loadbigshellers()
                               /* Main */

showshellers2me:=FALSE

maincycle:

shellsgui(showshellers2me)

showshellers2me:=FALSE

IF succ=FALSE THEN Raise(ERR_GUI)

IF infos=MYGT_QUIT THEN JUMP quit

bscr:=sb_OpenScreen([SA_WIDTH, WIDTH, SA_HEIGHT, HEIGHT, SA_DEPTH, 8,
	SA_QUIET, SA_OVERSCAN, SA_INTERLEAVED, OSCAN_STANDARD,
	SA_AUTOSCROLL, -1, SA_PENS, [-1]:INT, 0], 0);

IF (scr:=sb_GetScreen(bscr))=NIL THEN Raise(ERR_NEW)
CopyMem(scr.rastport, myrp, SIZEOF rastport)
myrp.layer:=0
view:=scr+44
SetStdRast(myrp)
SetTopaz()

p2:=pal

FOR i:=0 TO 255
  r:=Shl(Char(p2++),24)
  g:=Shl(Char(p2++),24)
  b:=Shl(Char(p2++),24)
  SetRGB32(view,i,r,g,b)
ENDFOR

IF
 (win:=OpenWindowTagList(0, [WA_CUSTOMSCREEN, scr, WA_BACKDROP, -1,
 WA_FLAGS, WFLG_BORDERLESS+WFLG_ACTIVATE+WFLG_RMBTRAP,
 WA_IDCMP, IDCMP_VANILLAKEY, 0]))=NIL THEN sb_CloseScreen(bscr) BUT Raise(ERR_NEW)

filename:='basepic'
bm:=sb_NextBuffer(bscr)

MOVEA.L bm,A0
LEA	8(A0),A0
MOVE.L (A0),p2

->p2:=bm.planes[0]
load(p2)

bm:=sb_NextBuffer(bscr)

MOVEA.L bm,A0
LEA	8(A0),A0
MOVE.L (A0),p

->p:=bm.planes[0]

CopyMem(p2,p,WIDTH*HEIGHT)

DateStamp(ds)
Rnd(-ds.tick*ds.minute)         ->to make "real" random seed

leveladd:=1
score:=0

backtoplay:

  goon:=level+1
  goon:=goon*leveladd+3

  goonstore:=goon

  myrp.bitmap:=sb_NextBuffer(bscr);

  Colour(1)
  TextF(20,20,'Level: \s/\d[2] Score:\d[6]',ListItem(
               ['Novice','Advanced','Expert'],level),leveladd,score)

  myrp.bitmap:=sb_NextBuffer(bscr);  ->for the second bitmap

  Colour(1)
  TextF(20,20,'Level: \s/\d[2] Score:\d[6]',ListItem(
               ['Novice','Advanced','Expert'],level),leveladd,score)

  dontstopthepress:=TRUE

  ball:=Rnd(3)

  SELECT ball
  CASE 0; playanim(anim4,TRUE,anim7)
  CASE 1; playanim(anim5,TRUE,anim8)
  CASE 2; playanim(anim6,TRUE,anim9)
  ENDSELECT

  WHILE goon AND dontstopthepress
    IF (im:=GetMsg(win.userport))
      IF im.class=IDCMP_VANILLAKEY AND im.code=27 THEN dontstopthepress:=FALSE
      ReplyMsg(im)
    ENDIF

    pick:=Rnd(3)

    SELECT pick
    CASE 0
      IF ball=1 THEN ball:=2 ELSE IF ball=2 THEN ball:=1
      playanim(anim1)
    CASE 1
      IF ball=0 THEN ball:=1 ELSE IF ball=1 THEN ball:=0
      playanim(anim2)
    CASE 2
      IF ball=0 THEN ball:=2 ELSE IF ball=2 THEN ball:=0
      playanim(anim3)
    ENDSELECT

    goon--

  ENDWHILE

  IF dontstopthepress=FALSE THEN JUMP getoutofthis

  REPEAT
    WaitLeftMouse(win)
    x:=MouseX(win)
    y:=MouseY(win)

    IF (x>9) AND (x<96) AND (y>99) AND (y<158)
      pick:=0
    ELSEIF (x>101) AND (x<191) AND (y>120) AND (y<176)
      pick:=1
    ELSEIF (x>205) AND (x<311) AND (y>137) AND (y<200)
      pick:=2
    ELSE
      pick:=4
    ENDIF

    leveladd++

  UNTIL pick<>4

  IF ball<>pick
    SELECT pick
    CASE 0; playanim(anim4,TRUE)
    CASE 1; playanim(anim5,TRUE)
    CASE 2; playanim(anim6,TRUE)
    ENDSELECT
  ENDIF

  SELECT ball
  CASE 0; playanim(anim4,TRUE,anim7)
  CASE 1; playanim(anim5,TRUE,anim8)
  CASE 2; playanim(anim6,TRUE,anim9)
  ENDSELECT

IF ball=pick
  score:=score+goonstore
  JUMP backtoplay
ENDIF
                               /* Let's Escape! */
getoutofthis:
IF win THEN CloseWindow(win) BUT win:=NIL
IF scr THEN sb_CloseScreen(bscr) BUT scr:=NIL
shorttoplist()
JUMP maincycle

quit:
savebigshellers()
                               /* Clean up */
EXCEPT DO
  IF win THEN CloseWindow(win)
  IF scr THEN sb_CloseScreen(bscr)
  IF anim1<>NIL THEN Dispose(anim1)
  IF anim2<>NIL THEN Dispose(anim2)
  IF anim3<>NIL THEN Dispose(anim3)
  IF anim4<>NIL THEN Dispose(anim4)
  IF anim5<>NIL THEN Dispose(anim5)
  IF anim6<>NIL THEN Dispose(anim6)
  IF anim7<>NIL THEN Dispose(anim7)
  IF anim8<>NIL THEN Dispose(anim8)
  IF anim9<>NIL THEN Dispose(anim9)
  IF filehandle<>NIL THEN Close(filehandle)
  IF p<>NIL THEN Dispose(p)
  IF bigshellers<>NIL THEN Dispose(bigshellers)
  IF intuigraphptr THEN FreeMem(intuigraphptr,4320)

  /* Report error (if there was one) */
  SELECT exception
  CASE ERR_LEN;   WriteF('Error: "\s" is damaged, or not present\n', filename)
  CASE ERR_NEW;   WriteF('Error: Insufficient memory\n')
  CASE ERR_OPEN;  WriteF('Error: Failed to open "\s"\n', filename)
  CASE ERR_READ;  WriteF('Error: File reading error\n')
  CASE ERR_GUI;   WriteF('Error: Failed to open GUI\n')
  CASE ERR_WRITE; WriteF('Error: Failed to save toplists\n')
  CASE ERR_KICK;  WriteF('Sorry, but this program requires KS 3.0 or higher!')
  ENDSELECT

ENDPROC

        /*** The animatiom player, plays LONG-based animformat  ***
         *** anim is the pointer to animation data,             ***
         *** wait is the state of waiting in the middle of anim ***/

PROC playanim(anim:PTR TO LONG, wait=FALSE, animplus=NIL)

DEF framenum,bm:bitmap,bm2:bitmap,plane:PTR TO LONG, i

bm:=sb_NextBuffer(bscr)
framenum:=0

start:

MOVEA.L bm,A0
LEA	8(A0),A0
MOVE.L (A0),plane

->plane:=bm.planes[0]

MOVEM.L D0/A0-A2,-(A7)
MOVEA.L	anim,A0
MOVEA.L plane,A1
BSR animationplay
CMP.B	#1,D0
BEQ animover
MOVE.L	A0,anim
MOVEM.L	(A7)+,D0/A0-A2

IF (animplus<>NIL) AND (framenum<>0)

  MOVEA.L bm2,A0
  LEA	8(A0),A0
  MOVE.L (A0),plane

->  plane:=bm.planes[0]

  MOVEM.L D0/A0-A2,-(A7)
  MOVEA.L animplus,A0
  MOVEA.L plane,A1
  BSR animationplay
  MOVE.L  A0,animplus
  MOVEM.L (A7)+,D0/A0-A2
ENDIF

IF animplus<>NIL

  MOVEA.L bm,A0
  LEA	8(A0),A0
  MOVE.L (A0),plane

->  plane:=bm.planes[0]

  MOVEM.L D0/A0-A2,-(A7)
  MOVEA.L animplus,A0
  MOVEA.L plane,A1
  BSR animationplay
  MOVE.L  A0,animplus
  MOVEM.L (A7)+,D0/A0-A2
ENDIF

bm2:=bm
bm:=sb_NextBuffer(bscr)

i:=0
WHILE i<>(2-level)
  WaitTOF()
  i++
ENDWHILE

framenum++

IF wait AND framenum=5 THEN FOR i:=1 TO 30 DO WaitTOF()

JUMP start

->This is the main play routine:

animationplay:

MOVEA.L  (A0)+,A2
CMPA.L	#$ffffffff,A2
BEQ     anim_frameover
CMPA.L  #$fffffffe,A2
BEQ	anim_animover
ADDA.L	A1,A2
MOVE.L	(A0)+,D0
SUBQ.L	#1,D0
copycyc:
MOVE.L	(A0)+,(A2)+
DBF	D0,copycyc
BRA     animationplay

anim_frameover:
MOVEQ	#0,D0
RTS

anim_animover:
MOVEQ	#1,D0
RTS

animover:
MOVEM.L	(A7)+,D0/A0-A2

sb_NextBuffer(bscr)

ENDPROC

        /*** The loader subroutine, load files into memory           ***
         *** if p not given, then it allocates memory for files,     ***
         *** else p shows the load address (needed for basepic load) ***/

PROC load(p=NIL)

DEF len

len:=FileLength(filename)
IF p=NIL THEN p:=New(len-8)
IF (filehandle:=Open(filename,OLDFILE))=NIL THEN Raise(ERR_OPEN)
IF 8<>Read(filehandle,p,8) THEN Raise(ERR_READ)
IF ((Long(p)<>"PALE") OR (Long(p+4)<>"TTE ")) AND
   ((Long(p)<>"ANIM") OR (Long(p+4)<>"LONG")) AND
   ((Long(p)<>"INTU") OR (Long(p+4)<>"IPIC")) AND
   ((Long(p)<>"ANIM") OR (Long(p+4)<>"PIC ")) THEN Raise(ERR_LEN)
IF len-8<>Read(filehandle,p,len-8) THEN Raise(ERR_READ)
Close(filehandle)
filehandle:=NIL
ENDPROC p

PROC loadbigshellers()

filename:='Shells.toplists'
bigshellers:=New(225+60) -> stringlength*5 elemnt*3 list+longlength*5...

IF (filehandle:=Open(filename,OLDFILE))<>NIL
   IF 225+60<>Read(filehandle,bigshellers,225+60) THEN Raise(ERR_READ)
   Close(filehandle)
   filehandle:=NIL
ENDIF

ENDPROC

PROC savebigshellers()

filename:='Shells.toplists'
IF (filehandle:=Open(filename,NEWFILE))=NIL THEN Raise(ERR_OPEN)
IF 225+60<>Write(filehandle,bigshellers,225+60) THEN Raise(ERR_WRITE)
Close(filehandle)
filehandle:=NIL

ENDPROC

PROC shorttoplist()

DEF i, changescore:LONG,
    myname[15]:ARRAY OF CHAR, myscore:LONG, notchanged, 
    pickname:PTR TO CHAR, pickscore:PTR TO LONG

myscore:=score
StrCopy(myname,'')
notchanged:=TRUE

pickname:=level*75+bigshellers       ->15*5 char/level
pickscore:=level*20+bigshellers+225  ->4*5 byte/level+225 char

FOR i:=1 TO 5
  IF ^pickscore<myscore
    IF notchanged THEN notchanged:=FALSE BUT getname(myname)
    changescore:=^pickscore
    ^pickscore:=myscore
    myscore:=changescore
    changestring(pickname,myname)
  ENDIF
  pickscore:=pickscore+4
  pickname:=pickname+15
  IF notchanged=FALSE THEN showshellers2me:=TRUE
ENDFOR

ENDPROC

PROC changestring(s1:PTR TO CHAR, s2:PTR TO CHAR)

 MOVEM.L D0-D1/A0-A2,-(A7)
 MOVEA.L s1,A0
 MOVEA.L s2,A1
 MOVEQ #14,D0
cyc:
 MOVE.B (A0),D1
 MOVE.B (A1),(A0)+
 MOVE.B D1,(A1)+
 DBF D0,cyc
 MOVEM.L (A7)+,D0-D1/A0-A2

ENDPROC

