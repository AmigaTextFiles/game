/*
                                Colour Lines
                            by Álmos Rajnai, 2000
			    
  LICENSE: This file is part of Colour Lines.
  Colour Lines is published under the terms of the GNU GPL License v2
  Please see readme.txt file for details.
*/

 MODULE 'intuition/screens', 'intuition/intuition',
        'exec/memory','utility/tagitem',
        'graphics/rastport','graphics/gfx','graphics/modeid',
        'iff','libraries/iff','dos/dos',
        'ReqTools','libraries/reqtools',
        'player610'

 ENUM ERR_NONE=0,ERR_SCREEN,ERR_WIN,ERR_IFFLIB,ERR_IFFPIC,
      ERR_REQLIB,ERR_KICK,ERR_FILE,ERR_SCRMODEREQ,ERR_CFG
 
 CONST TABLEX=88,TABLEY=28,DELAY=4,JOKERX=261,JOKERY=142

 DEF ballbmp[10]:ARRAY OF bitmap, sballbmp[10]:ARRAY OF bitmap, vballbmp[10]:ARRAY OF bitmap,
     backbmp:bitmap, backgroundbmp:bitmap, startbmp:bitmap, quitbmp:bitmap,
     start2bmp:bitmap, quit2bmp:bitmap,
     startscreenbmp:bitmap, nomusicbmp:bitmap, nojokerbmp:bitmap,
     noexchangebmp:bitmap,
     musicbmp:bitmap, jokerbmp:bitmap, exchangebmp:bitmap,

     scr:PTR TO screen,win:PTR TO window, colortable[16]:ARRAY OF INT,
     startpalette[16]:ARRAY OF INT,
     iffhand=NIL,tableemptyx[82]:LIST,tableemptyy[82]:LIST,
     table[82]:ARRAY OF CHAR, step, ds:datestamp,
     stepx[200]:ARRAY, stepy[200]:ARRAY, stepcnt,
     startx, starty, endx, endy, change,

     gad_quit:PTR TO gadget, gad_restart:PTR TO gadget,
     gad_music:PTR TO gadget, gad_joker:PTR TO gadget,
     gad_exchange:PTR TO gadget, gad_start:PTR TO gadget,
     gad_quit2:PTR TO gadget,

     img_music:image,img_nomusic:image,img_joker:image,img_nojoker:image,
     img_exchange:image,img_noexchange:image,
     img_start:image, img_start2:image, img_quit:image, img_quit2:image,


     displayid,scrmodereq:PTR TO rtscreenmoderequester,modidstr[20]:STRING,
     fh, pmusic, changeenabled, jokerenabled, musicenabled

 OBJECT scoreobj
   name[10]:ARRAY OF CHAR
   score:LONG
 ENDOBJECT

PROC main() HANDLE

 DEF nextballs[4]:ARRAY,myimsg:intuimessage, a, b, x, y, i, exit,
     score, putballs, quit, restart, joker

 iffbase:=NIL
 iffhand:=NIL
 reqtoolsbase:=NIL
 scrmodereq:=NIL
 fh:=NIL
 pmusic:=NIL
 win:=NIL
 scr:=NIL
 changeenabled:=FALSE
 jokerenabled:=FALSE
 musicenabled:=TRUE

 IF Not(KickVersion(37)) THEN Raise(ERR_KICK)

 IF (iffbase:=OpenLibrary('iff.library',23))=NIL THEN Raise(ERR_IFFLIB)
 IF (reqtoolsbase:=OpenLibrary('reqtools.library',37))=NIL THEN Raise(ERR_REQLIB)

 FOR a:=0 TO 7
      loadfile(ListItem(['ball1.iff','ball2.iff','ball3.iff','ball4.iff',
                        'ball5.iff','ball6.iff','ball7.iff','ballj.iff'],a),
                        ballbmp[a],16,16)
      loadfile(ListItem(['sball1.iff','sball2.iff','sball3.iff','sball4.iff',
                        'sball5.iff','sball6.iff','sball7.iff','sballj.iff'],a),
                        sballbmp[a],16,16)
      loadfile(ListItem(['vsball1.iff','vsball2.iff','vsball3.iff','vsball4.iff',
                        'vsball5.iff','vsball6.iff','vsball7.iff','vsballj.iff'],a),
                        vballbmp[a],16,16)
 ENDFOR

 loadfile('startscreen.iff',startscreenbmp,320,200)
 loadfile('nomusic.iff',nomusicbmp,32,34)
 prepareimage(img_nomusic,nomusicbmp,32,34)
 loadfile('music.iff',musicbmp,32,34)
 prepareimage(img_music,musicbmp,32,34)
 loadfile('nojoker.iff',nojokerbmp,32,26)
 prepareimage(img_nojoker,nojokerbmp,32,26)
 loadfile('joker.iff',jokerbmp,32,26)
 prepareimage(img_joker,jokerbmp,32,26)
 loadfile('noexchange.iff',noexchangebmp,48,30)
 prepareimage(img_noexchange,noexchangebmp,48,30)
 loadfile('exchange.iff',exchangebmp,48,30)
 prepareimage(img_exchange,exchangebmp,48,30)
 loadfile('start.iff',startbmp,70,25)
 prepareimage(img_start,startbmp,70,25)
 loadfile('start2.iff',start2bmp,70,25)
 prepareimage(img_start2,start2bmp,70,25)
 loadfile('quit.iff',quitbmp,70,34)
 prepareimage(img_quit,quitbmp,70,34)
 loadfile('quit2.iff',quit2bmp,70,34)
 prepareimage(img_quit2,quit2bmp,70,34)

 FOR i:=0 TO 15 DO startpalette[i]:=colortable[i]

 loadfile('rect.iff',backbmp,16,16)
 loadfile('wall.iff',ballbmp[9],16,16)
 loadfile('swall.iff',sballbmp[9],16,16)
 loadfile('vwall.iff',vballbmp[9],16,16)
 loadfile('bg.iff',backgroundbmp,320,200)

 CopyMem(backbmp,ballbmp[8],SIZEOF bitmap)

 /* Play screen gads */

 gad_quit:=[NIL, 13, 89, 55, 13,
               0,
               Or(GACT_IMMEDIATE,GACT_RELVERIFY),
               GTYP_BOOLGADGET,
               NIL, NIL,
               NIL,NIL,NIL,
               0,
               NIL]:gadget

 gad_restart:=[gad_quit, 13, 113, 55, 13,
               0,
               Or(GACT_IMMEDIATE,GACT_RELVERIFY),
               GTYP_BOOLGADGET,
               NIL, NIL,
               NIL,NIL,NIL,
               0,
               NIL]:gadget

 /* Start screen gads */

 gad_start:=[NIL, 0, 165, 70, 25,
               Or(GFLG_GADGHIMAGE,GFLG_GADGIMAGE),
               Or(GACT_IMMEDIATE,GACT_RELVERIFY),
               GTYP_BOOLGADGET,
               img_start,img_start2,
               NIL,NIL,NIL,
               0,
               NIL]:gadget

 gad_music:=[gad_start, 114, 160, 32, 34,
               Or(Or(GFLG_GADGHIMAGE,GFLG_GADGIMAGE),(IF musicenabled THEN 0 ELSE GFLG_SELECTED)),
               Or(Or(GACT_IMMEDIATE,GACT_TOGGLESELECT),GACT_RELVERIFY),
               GTYP_BOOLGADGET,
               img_music,img_nomusic,
               NIL,NIL,NIL,
               0,
               NIL]:gadget

 gad_joker:=[gad_music, 158, 164, 32, 26,
               Or(Or(GFLG_GADGHIMAGE,GFLG_GADGIMAGE),(IF jokerenabled THEN GFLG_SELECTED ELSE 0)),
               Or(GACT_IMMEDIATE,GACT_TOGGLESELECT),
               GTYP_BOOLGADGET,
               img_nojoker,img_joker,
               NIL,NIL,NIL,
               0,
               NIL]:gadget

 gad_exchange:=[gad_joker, 190, 160, 48, 30,
               Or(Or(GFLG_GADGHIMAGE,GFLG_GADGIMAGE),(IF changeenabled THEN GFLG_SELECTED ELSE 0)),
               Or(GACT_IMMEDIATE,GACT_TOGGLESELECT),
               GTYP_BOOLGADGET,
               img_noexchange,img_exchange,
               NIL,NIL,NIL,
               0,
               NIL]:gadget

 gad_quit2:=[gad_exchange, 250, 162, 70, 34,
               Or(GFLG_GADGHIMAGE,GFLG_GADGIMAGE),
               Or(GACT_IMMEDIATE,GACT_RELVERIFY),
               GTYP_BOOLGADGET,
               img_quit,img_quit2,
               NIL,NIL,NIL,
               0,
               NIL]:gadget

 b:='PROGDIR:data/lines.mod'
 IF (a:=FileLength(b))<1 THEN Raise(ERR_FILE)
 IF (fh:=Open(b,OLDFILE))=NIL THEN Raise(ERR_FILE)
 IF (pmusic:=NewM(a,MEMF_CHIP))=NIL THEN Raise("MEM")
 IF (Read(fh,pmusic,a)<>a) THEN Raise(ERR_FILE)
 Close(fh)
 fh:=NIL

 b:='PROGDIR:lines.cfg'

 IF (fh:=Open(b,OLDFILE))=NIL

   displayid:=LORES_KEY

   IF (scrmodereq:=RtAllocRequestA(RT_SCREENMODEREQ,NIL))=NIL THEN Raise(ERR_SCRMODEREQ)

   IF (RtScreenModeRequestA(scrmodereq,'Please select screenmode',[
        RTSC_MINHEIGHT,200,
        RTSC_MINWIDTH,320,
        RTSC_MINDEPTH,4,
        RTSC_MAXDEPTH,8,
        TAG_DONE]))
     displayid:=scrmodereq.displayid
   ELSE
     IF KickVersion(39)
       displayid:=BestModeIDA([BIDTAG_NOMINALWIDTH,320,
                               BIDTAG_NOMINALWIDTH,200,
                               BIDTAG_DEPTH,4,
                               BIDTAG_DIPFMUSTNOTHAVE,0,
                               TAG_DONE])
     ENDIF
   ENDIF

   IF (fh:=Open(b,NEWFILE))<>NIL
     fh:=SetStdOut(fh)
     WriteF('\d\n',displayid)
     fh:=SetStdOut(fh)
     Close(fh)
     fh:=NIL
   ENDIF
 ELSE
    IF (ReadStr(fh,modidstr)) THEN Raise(ERR_CFG)
    Close(fh)
    fh:=NIL
    displayid:=Val(modidstr,NIL)
 ENDIF

 IF (scr:=OpenS(320,200,4,0,NIL,
     [SA_QUIET,TRUE,
      SA_SHOWTITLE,FALSE,
      SA_DISPLAYID,displayid,
      SA_PUBNAME,'Colour Lines screen',
      TAG_DONE]))=NIL THEN Raise(ERR_SCREEN)

 IF (win:=OpenW(0,0,320,200,Or(Or(IDCMP_MOUSEBUTTONS,IDCMP_GADGETUP),IDCMP_VANILLAKEY),0,NIL,scr,CUSTOMSCREEN,NIL,
     [WA_RMBTRAP,TRUE,
      WA_ACTIVATE,TRUE,
      WA_BORDERLESS,TRUE,
      WA_BACKDROP,TRUE,
      WA_GADGETS,NIL,
      TAG_DONE]))=NIL THEN Raise(ERR_WIN)

 SetStdRast(win.rport)
 DateStamp(ds)
 Rnd(-(ds.tick*ds.days+ds.minute))
 SetTopaz()
 IF pmusic AND musicenabled
   p61_Play(pmusic)
   p61_SetVolumeFade(1)
 ENDIF

                              /* Main cycle */
maincyc:

 LoadRGB4(scr.viewport,startpalette,16)
 putbmp(startscreenbmp,0,0,0,0,320,200)

 AddGList(win,gad_quit2,0,-1,NIL)
 RefreshGList(win.firstgadget,win,NIL,-1)

 quit:=FALSE

                        /* Startscreen job begins */

 REPEAT
   waitmessage(win.userport,myimsg)
   IF (myimsg.class=IDCMP_GADGETUP)
     a:=myimsg.iaddress
     IF a=gad_quit2 THEN Raise(ERR_NONE)
     IF a=gad_start THEN quit:=TRUE
     IF a=gad_music 
       IF And(gad_music.flags,GFLG_SELECTED)
         p61_SetVolumeFade(-1)
         p61_WaitFade()
         p61_Stop()
         musicenabled:=FALSE
       ELSE
         p61_Play(pmusic)
         p61_SetVolumeFade(1)
         musicenabled:=TRUE
       ENDIF
     ENDIF
   ENDIF
 UNTIL quit

 jokerenabled:=(IF And(gad_joker.flags,GFLG_SELECTED) THEN TRUE ELSE FALSE)
 changeenabled:=(IF And(gad_exchange.flags,GFLG_SELECTED) THEN TRUE ELSE FALSE)
 musicenabled:=(IF And(gad_music.flags,GFLG_SELECTED) THEN TRUE ELSE FALSE)

 RemoveGList(win,win.firstgadget,-1)

                             /* Game playing */

 LoadRGB4(scr.viewport,colortable,16)
 putbmp(backgroundbmp,0,0,0,0,320,200)

 AddGList(win,gad_restart,0,-1,NIL)

 SetList(tableemptyx,0)
 SetList(tableemptyy,0)

 FOR x:=0 TO 8
   FOR y:=0 TO 8
      putbmp(backbmp,x,y,TABLEX,TABLEY)
      table[y*9+x]:=8
      ListAdd(tableemptyx,[x])
      ListAdd(tableemptyy,[y])
   ENDFOR
 ENDFOR

 exit:=FALSE
 score:=0
 IF jokerenabled THEN joker:=3 ELSE joker:=0
 putballs:=TRUE
 quit:=restart:=FALSE

 FOR i:=1 TO 3
   IF changeenabled THEN nextballs[i]:=Rnd(8) ELSE nextballs[i]:=Rnd(7)
   IF (nextballs[i]=7) THEN nextballs[i]:=9
   putbmp(ballbmp[nextballs[i]],0,i-1,272,70)
 ENDFOR

 a:=3

 REPEAT

   Colour(1)
   TextF(8,75,'\d[8]',score)
   TextF(278,152,'\d[2]',joker)

   IF putballs

     a:=ListLen(tableemptyx)
     IF a>3 THEN a:=3
     FOR i:=1 TO a
       b:=Rnd(ListLen(tableemptyx))
       putbmp(vballbmp[nextballs[i]],ListItem(tableemptyx,b),ListItem(tableemptyy,b),TABLEX,TABLEY)
       Delay(DELAY)
       putbmp(sballbmp[nextballs[i]],ListItem(tableemptyx,b),ListItem(tableemptyy,b),TABLEX,TABLEY)
       Delay(DELAY)
       putbmp(ballbmp[nextballs[i]],ListItem(tableemptyx,b),ListItem(tableemptyy,b),TABLEX,TABLEY)
       Delay(DELAY)
       table[ListItem(tableemptyy,b)*9+ListItem(tableemptyx,b)]:=nextballs[i]
       listdelete(tableemptyx,b)
       listdelete(tableemptyy,b)
       findmatch()
     ENDFOR

     IF (a:=ListLen(tableemptyx))=0 THEN exit:=TRUE
     IF a>3 THEN a:=3
     FOR i:=1 TO 3
       IF i<=a
         IF changeenabled THEN nextballs[i]:=Rnd(8) ELSE nextballs[i]:=Rnd(7)
         IF (nextballs[i]=7) THEN nextballs[i]:=9
       ELSE
         nextballs[i]:=8
       ENDIF
       putbmp(ballbmp[nextballs[i]],0,i-1,272,70)
     ENDFOR
   ENDIF

   putballs:=TRUE
   step:=FALSE

   IF Not(exit)

     REPEAT

       REPEAT

          waitmessage(win.userport,myimsg)
          IF (myimsg.class=IDCMP_MOUSEBUTTONS) AND (myimsg.code=SELECTDOWN)
             x:=myimsg.mousex
             y:=myimsg.mousey
             IF (x>=JOKERX) AND (x<=JOKERX+16) AND (y>=JOKERY) AND (y<=JOKERY+16) AND (joker<>0)
               x:=100
             ELSE
               x:=(x-TABLEX)/16
               y:=(y-TABLEY)/16
               IF (x<0) OR (x>8) OR (y<0) OR (y>8) OR (table[y*9+x]=8)
                 x:=200
                 DisplayBeep(NIL)
               ENDIF
             ENDIF
          ELSE
             IF (myimsg.class=IDCMP_GADGETUP)
               IF areyousure()
                 a:=myimsg.iaddress
                 SELECT a
                   CASE gad_quit; quit:=TRUE
                   CASE gad_restart; restart:=TRUE
                 ENDSELECT
                 exit:=TRUE
                 step:=TRUE
               ENDIF
             ENDIF
             x:=200
          ENDIF

       UNTIL (x<>200) OR (exit)

 getdest:

       startx:=x
       starty:=y

       IF Not(exit)
         IF startx=100
           putbmp(sballbmp[7],0,0,JOKERX,JOKERY)
         ELSE
           putbmp(sballbmp[table[starty*9+startx]],startx,starty,TABLEX,TABLEY)
         ENDIF

         REPEAT
            change:=FALSE
            waitmessage(win.userport,myimsg)
            IF (myimsg.class=IDCMP_MOUSEBUTTONS) AND (myimsg.code=SELECTDOWN)
              x:=myimsg.mousex
              y:=myimsg.mousey
              IF (x>=JOKERX) AND (x<=JOKERX+16) AND (y>=JOKERY) AND (y<=JOKERY+16) AND (joker<>0)
                x:=100
              ELSE
                x:=(x-TABLEX)/16
                y:=(y-TABLEY)/16
                IF (x<0) OR (x>8) OR (y<0) OR (y>8)
                  x:=200
                  DisplayBeep(NIL)
                ENDIF
              ENDIF
            ELSE
             IF (myimsg.class=IDCMP_MOUSEBUTTONS) AND (myimsg.code=MENUDOWN) AND changeenabled
               x:=myimsg.mousex
               y:=myimsg.mousey
               x:=(x-TABLEX)/16
               y:=(y-TABLEY)/16
               IF (x<0) OR (x>8) OR (y<0) OR (y>8) OR (table[y*9+x]=8)
                 x:=200
                 DisplayBeep(NIL)
               ELSE
                 change:=TRUE
               ENDIF
             ELSE
              IF (myimsg.class=IDCMP_GADGETUP)
                IF areyousure()
                  a:=myimsg.iaddress
                  SELECT a
                    CASE gad_quit; quit:=TRUE
                    CASE gad_restart; restart:=TRUE
                  ENDSELECT
                  exit:=TRUE
                  step:=TRUE
                ENDIF
              ENDIF
               x:=200
            ENDIF
          ENDIF

         UNTIL (x<>200) OR (exit)
         
         IF (table[y*9+x]<>8) AND Not(change)
           IF (startx=100)
             putbmp(ballbmp[7],0,0,JOKERX,JOKERY)
           ELSE
             putbmp(ballbmp[table[starty*9+startx]],startx,starty,TABLEX,TABLEY)
           ENDIF
           JUMP getdest
         ENDIF

         endx:=x
         endy:=y

       ENDIF

       IF (x<>200)
         IF (startx=100)
           putbmp(ballbmp[7],0,0,JOKERX,JOKERY)
           putbmp(vballbmp[7],endx,endy,TABLEX,TABLEY)
           Delay(DELAY)
           putbmp(sballbmp[7],endx,endy,TABLEX,TABLEY)
           Delay(DELAY)
           putbmp(ballbmp[7],endx,endy,TABLEX,TABLEY)
           Delay(DELAY)
           joker:=joker-1
           table[endy*9+endx]:=7
           FOR a:=0 TO ListLen(tableemptyx)-1
             EXIT ((ListItem(tableemptyx,a)=endx) AND (ListItem(tableemptyy,a)=endy))
           ENDFOR

           listdelete(tableemptyx,a)
           listdelete(tableemptyy,a)
           step:=TRUE
           x:=findmatch()
           IF x>4
             IF (x>6) AND jokerenabled THEN joker:=joker+1
             x:=x-5
             x:=x*x*2+10
             score:=score+x
             putballs:=FALSE
           ENDIF
         ELSE
           IF change
             a:=table[starty*9+startx]
             b:=table[endy*9+endx]
             putbmp(sballbmp[a],startx,starty,TABLEX,TABLEY)
             putbmp(sballbmp[b],endx,endy,TABLEX,TABLEY)
             Delay(DELAY/2)
             putbmp(vballbmp[a],startx,starty,TABLEX,TABLEY)
             putbmp(vballbmp[b],endx,endy,TABLEX,TABLEY)
             Delay(DELAY/2)
             table[starty*9+startx]:=b
             table[endy*9+endx]:=a
             putbmp(vballbmp[b],startx,starty,TABLEX,TABLEY)
             putbmp(vballbmp[a],endx,endy,TABLEX,TABLEY)
             Delay(DELAY/2)
             putbmp(sballbmp[b],startx,starty,TABLEX,TABLEY)
             putbmp(sballbmp[a],endx,endy,TABLEX,TABLEY)
             Delay(DELAY/2)
             putbmp(ballbmp[b],startx,starty,TABLEX,TABLEY)
             putbmp(ballbmp[a],endx,endy,TABLEX,TABLEY)
             Delay(DELAY/2)
             step:=TRUE
             x:=findmatch()
             IF x>4
               IF (x>6) AND jokerenabled THEN joker:=joker+1
               x:=x-5
               x:=x*x*2+10
               score:=score+x
               putballs:=FALSE
             ENDIF
           ELSE
             IF findwayentry(startx,starty)
               a:=table[starty*9+startx]
               table[endy*9+endx]:=a
               table[starty*9+startx]:=8
               FOR i:=0 TO stepcnt-2
                 putbmp(ballbmp[8],stepx[i],stepy[i],TABLEX,TABLEY)
                 putbmp(ballbmp[a],stepx[i+1],stepy[i+1],TABLEX,TABLEY)
                 Delay(DELAY/2)
               ENDFOR

               FOR a:=0 TO ListLen(tableemptyx)-1
                 EXIT ((ListItem(tableemptyx,a)=endx) AND (ListItem(tableemptyy,a)=endy))
               ENDFOR

               listdelete(tableemptyx,a)
               listdelete(tableemptyy,a)
               ListAdd(tableemptyx,[startx])
               ListAdd(tableemptyy,[starty])
               step:=TRUE
               x:=findmatch()
               IF x>4
                 IF (x>6) AND jokerenabled THEN joker:=joker+1
                 x:=x-5
                 x:=x*x*2+10
                 score:=score+x
                 putballs:=FALSE
               ENDIF
             ELSE
               putbmp(ballbmp[table[starty*9+startx]],startx,starty,TABLEX,TABLEY)
               DisplayBeep(NIL)
             ENDIF
           ENDIF
         ENDIF
       ENDIF

     UNTIL step

   ENDIF

 UNTIL (exit) OR (ListLen(tableemptyx)=0)

 hiscore(score)

 RemoveGList(win,win.firstgadget,-1)

 IF restart THEN JUMP maincyc

 IF Not(quit) THEN JUMP maincyc

                                 /* Done */

 EXCEPT DO

 IF pmusic
   p61_SetVolumeFade(-1)
   p61_WaitFade()
   p61_Stop()
 ENDIF

 IF win THEN CloseW(win)
 IF scr THEN CloseS(scr)

 IF scrmodereq THEN RtFreeRequest(scrmodereq)
 IF iffhand THEN IfFL_CloseIFF(iffhand)
 IF fh THEN Close(fh)
 IF iffbase THEN CloseLibrary(iffbase)
 IF reqtoolsbase THEN CloseLibrary(reqtoolsbase)

 IF exception="MEM"
   WriteF('Error: cannot allocate memory\n')
 ELSE
   SELECT exception
     CASE ERR_SCREEN; WriteF('Error: cannot open screen\n')
     CASE ERR_WIN;    WriteF('Error: cannot window screen\n')
     CASE ERR_IFFLIB; WriteF('Error: cannot open IFF.library v23\n')
     CASE ERR_REQLIB; WriteF('Error: cannot open reqtools.library v37\n')
     CASE ERR_IFFPIC; WriteF('Error: cannot open IFF picture\n')
     CASE ERR_KICK;   WriteF('Error: program needs at least Kickstart 2.04\n')
     CASE ERR_FILE;   WriteF('Error: cannot read a file\n')
     CASE ERR_CFG;    WriteF('Error: cannot read lines.cfg\n')
     CASE ERR_SCRMODEREQ; WriteF('Error: cannot allocate screenmode requester\n')
   ENDSELECT
 ENDIF

ENDPROC

PROC waitmessage(port, msg:PTR TO intuimessage)

DEF myimsg

  IF (myimsg:=GetMsg(port))=NIL
    REPEAT
      WaitPort(port)
    UNTIL ((myimsg:=GetMsg(port))<>NIL)
  ENDIF
  CopyMem(myimsg,msg,SIZEOF intuimessage)
  ReplyMsg(myimsg)
  IF (msg.class=IDCMP_VANILLAKEY) AND (msg.code=27) THEN Raise(ERR_NONE)

ENDPROC

PROC loadfile(name,bm:PTR TO bitmap,w,h)
  DEF planes,ptr,i,j,fn[200]:STRING,q

  StrCopy(fn,'PROGDIR:data/')
  StrAdd(fn,name)

  i,j:=Mod(w,16)
  q:=(IF i<>0 THEN (j+1)*16 ELSE w)

  IF (iffhand:=IfFL_OpenIFF(fn,IFFL_MODE_READ))=NIL THEN Raise(ERR_IFFPIC)
  InitBitMap(bm,4,w,h)
  planes:=NewM(4*q*h/8,MEMF_CHIP)

  ptr:=bm.planes
  FOR i:=0 TO 3
    PutLong(i*4+ptr,q*h/8*i+planes)
  ENDFOR
  IF (IfFL_DecodePic(iffhand,bm))=FALSE THEN Raise(ERR_IFFPIC)
  IF IfFL_GetColorTab(iffhand,colortable)<>16 THEN Raise(ERR_IFFPIC)

  IfFL_CloseIFF(iffhand)
  iffhand:=NIL

ENDPROC

PROC listdelete(lst,i)
  DEF lst2,a

  lst2:=List(ListLen(lst)-1)
  ListCopy(lst2,[])
  FOR a:=0 TO ListLen(lst)-1
    IF a<>i THEN ListAdd(lst2,[ListItem(lst,a)])
  ENDFOR

  IF ListLen(lst2)<>0 THEN ListCopy(lst,lst2) ELSE SetList(lst,0)

ENDPROC

PROC findway(actx,acty)
 DEF found, wayx[4]:ARRAY OF LONG, wayy[4]:ARRAY OF LONG,
     dist[4]:ARRAY OF LONG,cha, a, i, x, y

 IF (acty<0) OR (actx<0) OR (acty>8) OR (actx>8) OR (table[acty*9+actx]<>8) THEN RETURN FALSE

 stepx[stepcnt]:=actx
 stepy[stepcnt]:=acty
 stepcnt:=stepcnt+1

 IF (actx=endx) AND (acty=endy) THEN RETURN TRUE

 table[acty*9+actx]:=255

 found:=TRUE

 x:=actx-endx
 y:=acty-endy

 wayx[0]:=actx
 wayy[0]:=acty-1
 a:=(x*x)
 dist[0]:=(y-1)*(y-1)+a
 wayx[1]:=actx
 wayy[1]:=acty+1
 dist[1]:=(y+1)*(y+1)+a
 wayx[2]:=actx-1
 wayy[2]:=acty
 a:=(y*y)
 dist[2]:=(x-1)*(x-1)+a
 wayx[3]:=actx+1
 wayy[3]:=acty
 dist[3]:=(x+1)*(x+1)+a

 REPEAT
  cha:=FALSE
  FOR i:=0 TO 2
    IF dist[i]>dist[i+1]
      a:=wayx[i]
      wayx[i]:=wayx[i+1]
      wayx[i+1]:=a
      a:=wayy[i]
      wayy[i]:=wayy[i+1]
      wayy[i+1]:=a
      a:=dist[i]
      dist[i]:=dist[i+1]
      dist[i+1]:=a
      cha:=TRUE
    ENDIF
  ENDFOR
 UNTIL Not(cha)

 IF Not(findway(wayx[0],wayy[0]))
   IF Not(findway(wayx[1],wayy[1]))
     IF Not(findway(wayx[2],wayy[2]))
       IF Not(findway(wayx[3],wayy[3]))
         found:=FALSE
         stepcnt:=stepcnt-1
       ENDIF
     ENDIF
   ENDIF
 ENDIF

ENDPROC found

PROC findwayentry(actx,acty)
 DEF found,x,y,wayx[4]:ARRAY OF LONG, wayy[4]:ARRAY OF LONG, 
     dist[4]:ARRAY OF LONG,cha, a, i

 stepx[0]:=actx
 stepy[0]:=acty
 stepcnt:=1

 found:=TRUE

 x:=actx-endx
 y:=acty-endy

 wayx[0]:=actx
 wayy[0]:=acty-1
 a:=(x*x)
 dist[0]:=(y-1)*(y-1)+a
 wayx[1]:=actx
 wayy[1]:=acty+1
 dist[1]:=(y+1)*(y+1)+a
 wayx[2]:=actx-1
 wayy[2]:=acty
 a:=(y*y)
 dist[2]:=(x-1)*(x-1)+a
 wayx[3]:=actx+1
 wayy[3]:=acty
 dist[3]:=(x+1)*(x+1)+a

 REPEAT
  cha:=FALSE
  FOR i:=0 TO 2
    IF dist[i]>dist[i+1]
      a:=wayx[i]
      wayx[i]:=wayx[i+1]
      wayx[i+1]:=a
      a:=wayy[i]
      wayy[i]:=wayy[i+1]
      wayy[i+1]:=a
      a:=dist[i]
      dist[i]:=dist[i+1]
      dist[i+1]:=a
      cha:=TRUE
    ENDIF
  ENDFOR
 UNTIL Not(cha)

 IF Not(findway(wayx[0],wayy[0]))
   IF Not(findway(wayx[1],wayy[1]))
     IF Not(findway(wayx[2],wayy[2]))
       IF Not(findway(wayx[3],wayy[3]))
         found:=FALSE
       ENDIF
     ENDIF
   ENDIF
 ENDIF

 FOR x:=0 TO 8
   FOR y:=0 TO 8
     IF table[y*9+x]=255 THEN table[y*9+x]:=8
   ENDFOR
 ENDFOR

ENDPROC found

PROC findmatch()
 DEF total, ntable[81]:ARRAY, x, y, a, i, j, b

 FOR x:=0 TO 80
   ntable[x]:=FALSE
 ENDFOR

 FOR x:=0 TO 8
   FOR y:=0 TO 8
     a:=table[y*9+x]
     IF a<>8
       i:=1
       j:=a
       WHILE (x+i<9) AND ((b:=table[y*9+x+i])<>8) AND (b<>9)
         IF (j=7) THEN j:=b
         EXIT (b<>j) AND (b<>7)
         i:=i+1
       ENDWHILE
       IF i>4
         FOR j:=0 TO i-1
            ntable[y*9+x+j]:=TRUE
         ENDFOR
       ENDIF

       i:=1
       j:=a
       WHILE (y+i<9) AND ((b:=table[(y+i)*9+x])<>8) AND (b<>9)
         IF (j=7) THEN j:=b
         EXIT (b<>j) AND (b<>7)
         i:=i+1
       ENDWHILE
       IF i>4
         FOR j:=0 TO i-1
           ntable[(y+j)*9+x]:=TRUE
         ENDFOR
       ENDIF

       i:=1
       j:=a
       WHILE (x+i<9) AND (y+i<9) AND ((b:=table[(y+i)*9+x+i])<>8) AND (b<>9)
         IF (j=7) THEN j:=b
         EXIT (b<>j) AND (b<>7)
         i:=i+1
       ENDWHILE
       IF i>4
         FOR j:=0 TO i-1
           ntable[(y+j)*9+x+j]:=TRUE
         ENDFOR
       ENDIF

       i:=1
       j:=a
       WHILE (x-i>-1) AND (y+i<9) AND ((b:=table[(y+i)*9+x-i])<>8) AND (b<>9)
         IF (j=7) THEN j:=b
         EXIT (b<>j) AND (b<>7)
         i:=i+1
       ENDWHILE
       IF i>4
         FOR j:=0 TO i-1
           ntable[(y+j)*9+x-j]:=TRUE
         ENDFOR
       ENDIF
     ENDIF

   ENDFOR
 ENDFOR

 total:=0

 FOR x:=0 TO 8
   FOR y:=0 TO 8
     IF (ntable[y*9+x])
       putbmp(sballbmp[table[y*9+x]],x,y,TABLEX,TABLEY)
     ENDIF
   ENDFOR
 ENDFOR
 Delay(DELAY)

 FOR x:=0 TO 8
   FOR y:=0 TO 8
     IF (ntable[y*9+x])
       putbmp(vballbmp[table[y*9+x]],x,y,TABLEX,TABLEY)
     ENDIF
   ENDFOR
 ENDFOR
 Delay(DELAY)

 FOR x:=0 TO 8
   FOR y:=0 TO 8
     IF (ntable[y*9+x])
       total:=total+1
       putbmp(ballbmp[8],x,y,TABLEX,TABLEY)
       ListAdd(tableemptyx,[x])
       ListAdd(tableemptyy,[y])
       table[y*9+x]:=8
     ENDIF
   ENDFOR
 ENDFOR

ENDPROC total

PROC putbmp(bmp:PTR TO bitmap,x,y,ox,oy,w=16,h=16)

 BltBitMap(bmp,0,0,win.rport.bitmap,x*16+ox,y*16+oy,w,h,$c0,$ff,NIL)

ENDPROC

PROC hiscore(sc)
DEF arr[5]:ARRAY OF scoreobj, fh, a, dummy, i, scrtxt[200]:STRING,
    fn[200]:STRING

  dummy:='Dummy Boy'
  StrCopy(fn,'PROGDIR:hiscore')
  IF jokerenabled THEN StrAdd(fn,'j')
  IF changeenabled THEN StrAdd(fn,'e')

  IF (fh:=Open(fn,MODE_OLDFILE))=NIL
    FOR a:=0 TO 4
      AstrCopy(arr[a].name,dummy,StrLen(dummy)+1)
      arr[a].score:=0
    ENDFOR
  ELSE
    FOR a:=0 TO 4
      Read(fh,arr[a],SIZEOF scoreobj)
    ENDFOR
  ENDIF
  
  FOR a:=0 TO 4 DO EXIT (sc>arr[a].score)
  
  IF a<>5
     IF a<>4
       FOR i:=4 TO a+1 STEP -1
         arr[i].score:=arr[i-1].score
         AstrCopy(arr[i].name,arr[i-1].name,StrLen(arr[i-1].name)+1)
       ENDFOR
     ENDIF
     arr[a].score:=sc
     AstrCopy(arr[a].name,'',1)
     StringF(scrtxt,'Your score is: \d\nYour position in the\nHall Of Fame is: \d',sc,a+1)

     RtGetStringA(arr[a].name,10,'High Score!',NIL,
                  [RTGS_TEXTFMT,scrtxt,
                   RT_SCREEN,scr,
                   RTGS_GADFMT,NIL,
                   TAG_DONE])
  ENDIF
  
  Close(fh)

  IF (fh:=Open(fn,MODE_NEWFILE))=NIL
    DisplayBeep(NIL)
    RETURN
  ENDIF

  FOR a:=0 TO 4
    Write(fh,arr[a],SIZEOF scoreobj)
  ENDFOR

  Close(fh)

  StringF(scrtxt,'\s[10] ... \d[6]\n'+
                 '\s[10] ... \d[6]\n'+
                 '\s[10] ... \d[6]\n'+
                 '\s[10] ... \d[6]\n'+
                 '\s[10] ... \d[6]\n',
                 arr[0].name,arr[0].score,
                 arr[1].name,arr[1].score,
                 arr[2].name,arr[2].score,
                 arr[3].name,arr[3].score,
                 arr[4].name,arr[4].score)

  RtEZRequestA(scrtxt,'Great!',0,0,
               [RT_SCREEN,scr,
                RTEZ_REQTITLE,'Hall Of Fame',
                TAG_DONE])


ENDPROC

PROC areyousure() IS RtEZRequestA('Do you really want\nabadon this game?','Go ahead|Not yet',0,0,
               [RT_SCREEN,scr,
                RTEZ_REQTITLE,'Colour Lines',
                TAG_DONE])

PROC prepareimage(img:PTR TO image, bmp:PTR TO bitmap, w, h)

 img.leftedge:=0
 img.topedge:=0
 img.width:=w
 img.height:=h
 img.depth:=4
 img.imagedata:=bmp.planes[0]
 img.planepick:=%1111
 img.planeonoff:=0
 img.nextimage:=NIL

ENDPROC
