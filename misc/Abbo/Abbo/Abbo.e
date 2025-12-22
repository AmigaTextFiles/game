-> ABBO 2000 by Jakub Madej / 2012 by sun68
-> Version 0.40 / Compiled with EC 3.3a and CreativE


OPT PREPROCESS,
    OSVERSION=37,
    REG=5,
    LARGE


MODULE 'intuition/intuition',
       'afc/super_picture',
       'afc/reqtooller',
       'intuition/screens',
       'stringfunctions',
       'devices/inputevent',
       'exec/ports',
       'asl','libraries/asl',
       'graphics/gfxmacros',
       'graphics/rastport',
       'tools/easygui',
       'lowlevel','libraries/lowlevel',
       'tools/eaudio',
       'dos','dos/dos'
       ->'cybergraphics','cybergraphics/cybergraphics'


DEF pole[1500]:ARRAY OF LONG                    -> Feldgroesse
DEF step,steplen,                               -> Sounds
    event,eventlen,
    diam,diamlen,
    door,doorlen,
    keyF,keyFlen,
    box,boxlen,
    portalS,portalSlen,
    cannonS,cannonSlen,
    showS,showSlen
DEF abbo[2]:ARRAY OF LONG,klucze,diamenty=4,    -> bewegliche Grafik Objekte
    teleport[2]:ARRAY OF LONG,                  -> [Anzahl der Frames]
    kratka1[3]:ARRAY OF LONG,                   -> Gitter (Grid)
    kratka2[3]:ARRAY OF LONG,
    kratka3[3]:ARRAY OF LONG,
    kratka4[3]:ARRAY OF LONG,
    portal1[2]:ARRAY OF LONG,
    portal2[2]:ARRAY OF LONG,
    portal3[2]:ARRAY OF LONG,
    portal4[2]:ARRAY OF LONG,
    portal5[2]:ARRAY OF LONG,
    portal6[2]:ARRAY OF LONG,
    portal7[2]:ARRAY OF LONG,
    portal8[2]:ARRAY OF LONG,
    cannon1[4]:ARRAY OF LONG,
    cannon2[4]:ARRAY OF LONG,
    cannon3[4]:ARRAY OF LONG,
    cannon4[4]:ARRAY OF LONG,
    monster1[4]:ARRAY OF LONG,
    monster2[4]:ARRAY OF LONG,
    monster3[4]:ARRAY OF LONG,
    monster4[4]:ARRAY OF LONG
DEF win=NIL:PTR TO window,                      -> Vordergrundfenster
    winb=NIL:PTR TO window                      -> Hintergrundfenster
DEF picTlo=NIL:PTR TO super_picture,            -> Bilder
    picEkr=NIL:PTR TO super_picture,
    picAbboD1=NIL:PTR TO super_picture,
    picAbboD2=NIL:PTR TO super_picture,
    picAbboP=NIL:PTR TO super_picture,
    picAbboL=NIL:PTR TO super_picture,
    picAbboG=NIL:PTR TO super_picture,
    picWall=NIL:PTR TO super_picture,
    picKra=NIL:PTR TO super_picture,
    picTele=NIL:PTR TO super_picture,
    picMag=NIL:PTR TO super_picture,
    picKrak=NIL:PTR TO super_picture,
    picPort=NIL:PTR TO super_picture,
    picChm=NIL:PTR TO super_picture,
    picDzP=NIL:PTR TO super_picture,
    picDzL=NIL:PTR TO super_picture,
    picF1=NIL:PTR TO super_picture,
    picF2=NIL:PTR TO super_picture,
    picM1=NIL:PTR TO super_picture,
    picM2=NIL:PTR TO super_picture,
    picKey=NIL:PTR TO super_picture,
    picDoor=NIL:PTR TO super_picture,
    picDia=NIL:PTR TO super_picture
DEF i,j,temp,oldkey
DEF class,code,scr=NIL:PTR TO screen,windowsignal,
    inputevent:PTR TO inputevent,imsg:PTR TO intuimessage,
    filehandle,oldlevel,
    status, buffer[150]:STRING,
    znak,linia,down=1,key,level,levels,gui,textgad,rt=NIL:PTR TO reqtooller
DEF fr=NIL:PTR TO screenmoderequester


#define UNSIGNED(x) ((x) AND $FFFF)


PROC main()

    lowlevelbase:=OpenLibrary('lowlevel.library',0)
    aslbase:=OpenLibrary('asl.library',37)

    select_screen()

    Colour(120,0)

    gui:=guiinitA('',[EQROWS,
                            [BEVEL,[TEXT,'Please wait while loading',NIL,NIL,0]],
                            [COLS,
                            [SPACE],[SPACE],[SPACE],[SPACE],[SPACE],[SPACE],[SPACE],[SPACE],
                            textgad:=[TEXT,'...LOADING NOW',NIL,BEVEL,0],
                            [SPACE],[SPACE],[SPACE],[SPACE],[SPACE],[SPACE],[SPACE],[SPACE]]
                     ],[EG_WTYPE,WTYPE_NOBORDER,EG_SCRN,scr])
    Delay(30)

    NEW picWall.super_picture(FALSE)
    NEW picAbboD1.super_picture(FALSE)
    NEW picAbboD2.super_picture(FALSE)
    NEW picAbboL.super_picture(FALSE)
    NEW picAbboP.super_picture(FALSE)
    NEW picAbboG.super_picture(FALSE)
    NEW picKra.super_picture(FALSE)
    NEW picTele.super_picture(FALSE)
    NEW picMag.super_picture(FALSE)
    NEW picKrak.super_picture(FALSE)
    NEW picTlo.super_picture()
    NEW picPort.super_picture(FALSE)
    NEW picEkr.super_picture(FALSE)
    NEW picChm.super_picture(FALSE)
    NEW picDzL.super_picture(FALSE)
    NEW picDzP.super_picture(FALSE)
    NEW picF1.super_picture(FALSE)
    NEW picF2.super_picture(FALSE)
    NEW picM1.super_picture(FALSE)
    NEW picM2.super_picture(FALSE)
    NEW picKey.super_picture(FALSE)
    NEW picDoor.super_picture(FALSE)
    NEW picDia.super_picture(FALSE)

    settext(gui,textgad,'|                       ')
    setup()                                                 -> Load Sounds
    event,eventlen:=loadRaw('sfx/jingle_for_new_event.raw')
    step,steplen:=loadRaw('sfx/step')
    diam,diamlen:=loadRaw('sfx/diamond')
    door,doorlen:=loadRaw('sfx/door')
    keyF,keyFlen:=loadRaw('sfx/key')
    box,boxlen:=loadRaw('sfx/box')
    portalS,portalSlen:=loadRaw('sfx/teleport')
    cannonS,cannonSlen:=loadRaw('sfx/cannon')
    showS,showSlen:=loadRaw('sfx/show')
    Delay(30)
    settext(gui,textgad,'||                      ')
    picTlo.clear()
    picTlo.dtload('gfx/bkg1.iff')                           -> Load Grafiks (per Datatypes)
    Delay(30)
    settext(gui,textgad,'|||                     ')
    picTlo.paltoscr(scr)                                    -> Setup Screenpalette aus bkg1.iff
    picWall.load('gfx/blok1.iff')
    Delay(30)
    settext(gui,textgad,'||||                    ')
    picAbboD1.load('gfx/abbo/dol1',FALSE,FALSE)
    Delay(30)
    settext(gui,textgad,'|||||                   ')
    picAbboD2.load('gfx/abbo/dol2',FALSE,FALSE)
    Delay(30)
    settext(gui,textgad,'||||||                  ')
    picAbboP.load('gfx/abbo/prawo',FALSE,FALSE)
    Delay(30)
    settext(gui,textgad,'|||||||                 ')
    picAbboL.load('gfx/abbo/lewo',FALSE,FALSE)
    Delay(30)
    settext(gui,textgad,'||||||||                ')
    picAbboG.load('gfx/abbo/gora',FALSE,FALSE)
    Delay(30)
    settext(gui,textgad,'|||||||||               ')
    picKra.load('gfx/blok3.iff',FALSE,FALSE)
    Delay(30)
    settext(gui,textgad,'||||||||||              ')
    picTele.load('gfx/blok5.iff',FALSE,FALSE)
    Delay(30)
    settext(gui,textgad,'|||||||||||             ')
    picMag.load('gfx/blok2.iff',FALSE,FALSE)
    Delay(30)
    settext(gui,textgad,'||||||||||||            ')
    picKrak.load('gfx/blok4.iff',FALSE,FALSE)
    Delay(30)
    settext(gui,textgad,'|||||||||||||           ')
    picPort.load('gfx/blok6.iff',FALSE,FALSE)
    Delay(30)
    settext(gui,textgad,'||||||||||||||          ')
    picChm.load('gfx/blok7.iff',FALSE,FALSE)
    Delay(30)
    settext(gui,textgad,'|||||||||||||||         ')
    picDzP.load('gfx/cannonP.iff',FALSE,FALSE)
    Delay(30)
    settext(gui,textgad,'||||||||||||||||        ')
    picDzL.load('gfx/cannonL.iff',FALSE,FALSE)
    Delay(30)
    settext(gui,textgad,'|||||||||||||||||       ')
    picF1.load('gfx/cannonF1.iff',FALSE,FALSE)
    Delay(30)
    settext(gui,textgad,'||||||||||||||||||      ')
    picF2.load('gfx/cannonF2.iff',FALSE,FALSE)
    Delay(30)
    settext(gui,textgad,'|||||||||||||||||||     ')
    picM1.load('gfx/monst1.iff',FALSE,FALSE)
    Delay(30)
    settext(gui,textgad,'||||||||||||||||||||    ')
    picM2.load('gfx/monst2.iff',FALSE,FALSE)
    Delay(30)
    settext(gui,textgad,'|||||||||||||||||||||   ')
    picKey.load('gfx/blok8.iff',FALSE,FALSE)
    Delay(30)
    settext(gui,textgad,'||||||||||||||||||||||  ')
    picDoor.load('gfx/blok9.iff',FALSE,FALSE)
    Delay(30)
    settext(gui,textgad,'||||||||||||||||||||||| ')
    picDia.load('gfx/blok10.iff',FALSE,FALSE)
    Delay(30)
    settext(gui,textgad,'||||||||||||||||||||||||')
    picEkr.load('gfx/ekran.iff',FALSE,FALSE)

    cleangui(gui)

    winb:=OpenWindowTagList(NIL,[WA_WIDTH,640,WA_INNERHEIGHT,469,
                                 WA_CUSTOMSCREEN,scr,
                                 WA_BORDERLESS,TRUE,
                                 WA_RMBTRAP, TRUE,
                                 WA_TOP,11,
                                 WA_BACKDROP,TRUE,
                                 WA_SCREENTITLE,'Game paused !',
                                 NIL, NIL])

    BltBitMapRastPort(picEkr.bitmap(),0,0,winb.rport,
                                      0,0,
                                      640,469,
                                      $c0)

    win:=OpenWindowTagList(NIL,[WA_WIDTH,600,WA_INNERHEIGHT,360,
                                WA_IDCMP,IDCMP_CLOSEWINDOW+IDCMP_RAWKEY+IDCMP_INTUITICKS,
                                WA_FLAGS,WFLG_ACTIVATE OR WFLG_RMBTRAP,
                                WA_CUSTOMSCREEN,scr,
                                WA_BORDERLESS,TRUE,
                                WA_LEFT,20,
                                WA_TOP,20,
                                WA_BACKDROP,TRUE,
                                WA_SCREENTITLE, 'Abbo 0.40 by Jakub Madej and sun68',
                                NIL, NIL])

    windowsignal:=Shl(1, win.userport.sigbit)
    NEW inputevent
    inputevent.class:=IECLASS_RAWKEY

    start()

ENDPROC

PROC mainproc()

    class:=0
    key:=0
    ->REPEAT
    LOOP

        IF ((key<>$4C) AND (key<>$4D) AND (key<>$4E) AND (key<>$4F) AND (key<>$10)) THEN key:=GetKey()
        IF key=$10 OR key=$45       -> Taste "Q" oder "ESC" zurueck zum Level 0
                level:=0
                start()
        ENDIF
        IF key=$13                  -> Taste "R" Reload Level
                init()
        ENDIF
        IF imsg:=GetMsg(win.userport)
                class:=imsg.class

                                IF class=IDCMP_INTUITICKS

                                        exitLoop(CHAN_LEFT1+CHAN_LEFT2+CHAN_RIGHT1+CHAN_RIGHT2)


                                        FOR i:=249 TO 254
                                                SetColour(scr,i,1+Rnd(254),1+Rnd(254),1+Rnd(254))
                                        ENDFOR

        /* Routinen für die Bewegung der Monster */
i:=0
        IF monster1[0]=1
                IF monster1[3]=2
                        IF getpole(monster1[1],monster1[2]+1)=0
                                monster1[2]:=monster1[2]+1
                                BltBitMapRastPort(picTlo.bitmap(),monster1[1]*12,(monster1[2]-1)*12,win.rport,
                                        (win.borderleft+(monster1[1]*12)),(win.bordertop+((monster1[2]-1)*12)),
                                        12,12,
                                        $c0)
                                BltBitMapRastPort(IF Rnd(2)=0 THEN picM1.bitmap() ELSE picM2.bitmap(),0,0,win.rport,
                                        (win.borderleft+(monster1[1]*12)),(win.bordertop+(monster1[2]*12)),
                                        12,12,
                                        $c0)
                                setpole(monster1[1],monster1[2]-1,0)
                                setpole(monster1[1],monster1[2],8)
                        ELSE
                                IF monster1[3]=2
                                        i:=1
                                        monster1[3]:=8
                                ENDIF
                        ENDIF
                ENDIF
                IF ((monster1[3]=8) AND (i=0))
                        IF getpole(monster1[1],monster1[2]-1)=0
                                monster1[2]:=monster1[2]-1
                                BltBitMapRastPort(picTlo.bitmap(),monster1[1]*12,(monster1[2]+1)*12,win.rport,
                                        (win.borderleft+(monster1[1]*12)),(win.bordertop+((monster1[2]+1)*12)),
                                        12,12,
                                        $c0)
                                BltBitMapRastPort(IF Rnd(2)=0 THEN picM1.bitmap() ELSE picM2.bitmap(),0,0,win.rport,
                                        (win.borderleft+(monster1[1]*12)),(win.bordertop+(monster1[2]*12)),
                                        12,12,
                                        $c0)
                                setpole(monster1[1],monster1[2]+1,0)
                                setpole(monster1[1],monster1[2],8)
                        ELSE
                                monster1[3]:=2
                        ENDIF
                ENDIF
        ENDIF
i:=0
        IF monster2[0]=1
                IF monster2[3]=2
                        IF getpole(monster2[1],monster2[2]+1)=0
                                monster2[2]:=monster2[2]+1
                                BltBitMapRastPort(picTlo.bitmap(),monster2[1]*12,(monster2[2]-1)*12,win.rport,
                                        (win.borderleft+(monster2[1]*12)),(win.bordertop+((monster2[2]-1)*12)),
                                        12,12,
                                        $c0)
                                BltBitMapRastPort(IF Rnd(2)=0 THEN picM1.bitmap() ELSE picM2.bitmap(),0,0,win.rport,
                                        (win.borderleft+(monster2[1]*12)),(win.bordertop+(monster2[2]*12)),
                                        12,12,
                                        $c0)
                                setpole(monster2[1],monster2[2]-1,0)
                                setpole(monster2[1],monster2[2],8)
                        ELSE
                                IF monster2[3]=2
                                        i:=1
                                        monster2[3]:=8
                                ENDIF
                        ENDIF
                ENDIF
                IF ((monster2[3]=8) AND (i=0))
                        IF getpole(monster2[1],monster2[2]-1)=0
                                monster2[2]:=monster2[2]-1
                                BltBitMapRastPort(picTlo.bitmap(),monster2[1]*12,(monster2[2]+1)*12,win.rport,
                                        (win.borderleft+(monster2[1]*12)),(win.bordertop+((monster2[2]+1)*12)),
                                        12,12,
                                        $c0)
                                BltBitMapRastPort(IF Rnd(2)=0 THEN picM1.bitmap() ELSE picM2.bitmap(),0,0,win.rport,
                                        (win.borderleft+(monster2[1]*12)),(win.bordertop+(monster2[2]*12)),
                                        12,12,
                                        $c0)
                                setpole(monster2[1],monster2[2]+1,0)
                                setpole(monster2[1],monster2[2],8)
                        ELSE
                                monster2[3]:=2
                        ENDIF
                ENDIF
        ENDIF
i:=0
        IF monster3[0]=1
                IF monster3[3]=2
                        IF getpole(monster3[1],monster3[2]+1)=0
                                monster3[2]:=monster3[2]+1
                                BltBitMapRastPort(picTlo.bitmap(),monster3[1]*12,(monster3[2]-1)*12,win.rport,
                                        (win.borderleft+(monster3[1]*12)),(win.bordertop+((monster3[2]-1)*12)),
                                        12,12,
                                        $c0)
                                BltBitMapRastPort(IF Rnd(2)=0 THEN picM1.bitmap() ELSE picM2.bitmap(),0,0,win.rport,
                                        (win.borderleft+(monster3[1]*12)),(win.bordertop+(monster3[2]*12)),
                                        12,12,
                                        $c0)
                                setpole(monster3[1],monster3[2]-1,0)
                                setpole(monster3[1],monster3[2],8)
                        ELSE
                                IF monster3[3]=2
                                        i:=1
                                        monster3[3]:=8
                                ENDIF
                        ENDIF
                ENDIF
                IF ((monster3[3]=8) AND (i=0))
                        IF getpole(monster3[1],monster3[2]-1)=0
                                monster3[2]:=monster3[2]-1
                                BltBitMapRastPort(picTlo.bitmap(),monster3[1]*12,(monster3[2]+1)*12,win.rport,
                                        (win.borderleft+(monster3[1]*12)),(win.bordertop+((monster3[2]+1)*12)),
                                        12,12,
                                        $c0)
                                BltBitMapRastPort(IF Rnd(2)=0 THEN picM1.bitmap() ELSE picM2.bitmap(),0,0,win.rport,
                                        (win.borderleft+(monster3[1]*12)),(win.bordertop+(monster3[2]*12)),
                                        12,12,
                                        $c0)
                                setpole(monster3[1],monster3[2]+1,0)
                                setpole(monster3[1],monster3[2],8)
                        ELSE
                                monster3[3]:=2
                        ENDIF
                ENDIF
        ENDIF
i:=0
        IF monster4[0]=1
                IF monster4[3]=2
                        IF getpole(monster4[1],monster4[2]+1)=0
                                monster4[2]:=monster4[2]+1
                                BltBitMapRastPort(picTlo.bitmap(),monster4[1]*12,(monster4[2]-1)*12,win.rport,
                                        (win.borderleft+(monster4[1]*12)),(win.bordertop+((monster4[2]-1)*12)),
                                        12,12,
                                        $c0)
                                BltBitMapRastPort(IF Rnd(2)=0 THEN picM1.bitmap() ELSE picM2.bitmap(),0,0,win.rport,
                                        (win.borderleft+(monster4[1]*12)),(win.bordertop+(monster4[2]*12)),
                                        12,12,
                                        $c0)
                                setpole(monster4[1],monster4[2]-1,0)
                                setpole(monster4[1],monster4[2],8)
                        ELSE
                                IF monster4[3]=2
                                        i:=1
                                        monster4[3]:=8
                                ENDIF
                        ENDIF
                ENDIF
                IF ((monster4[3]=8) AND (i=0))
                        IF getpole(monster4[1],monster4[2]-1)=0
                                monster4[2]:=monster4[2]-1
                                BltBitMapRastPort(picTlo.bitmap(),monster4[1]*12,(monster4[2]+1)*12,win.rport,
                                        (win.borderleft+(monster4[1]*12)),(win.bordertop+((monster4[2]+1)*12)),
                                        12,12,
                                        $c0)
                                BltBitMapRastPort(IF Rnd(2)=0 THEN picM1.bitmap() ELSE picM2.bitmap(),0,0,win.rport,
                                        (win.borderleft+(monster4[1]*12)),(win.bordertop+(monster4[2]*12)),
                                        12,12,
                                        $c0)
                                setpole(monster4[1],monster4[2]+1,0)
                                setpole(monster4[1],monster4[2],8)
                        ELSE
                                monster4[3]:=2
                        ENDIF
                ENDIF
        ENDIF
        IF monster1[0]=2
                i:=Rnd(3)-1
                j:=Rnd(2)
                IF j=0
                        IF getpole(monster1[1]+i,monster1[2])=0
                                monster1[1]:=monster1[1]+i
                                BltBitMapRastPort(picTlo.bitmap(),(monster1[1]-i)*12,(monster1[2])*12,win.rport,
                                        (win.borderleft+((monster1[1]-i)*12)),(win.bordertop+((monster1[2])*12)),
                                        12,12,
                                        $c0)
                                BltBitMapRastPort(IF Rnd(2)=0 THEN picM1.bitmap() ELSE picM2.bitmap(),0,0,win.rport,
                                        (win.borderleft+(monster1[1]*12)),(win.bordertop+(monster1[2]*12)),
                                        12,12,
                                        $c0)
                                setpole(monster1[1]-i,monster1[2],0)
                                setpole(monster1[1],monster1[2],8)
                        ENDIF
                ENDIF
                IF j=1
                        IF getpole(monster1[1],monster1[2]+i)=0
                                monster1[2]:=monster1[2]+i
                                BltBitMapRastPort(picTlo.bitmap(),(monster1[1])*12,(monster1[2]-i)*12,win.rport,
                                        (win.borderleft+((monster1[1])*12)),(win.bordertop+((monster1[2]-i)*12)),
                                        12,12,
                                        $c0)
                                BltBitMapRastPort(IF Rnd(2)=0 THEN picM1.bitmap() ELSE picM2.bitmap(),0,0,win.rport,
                                        (win.borderleft+(monster1[1]*12)),(win.bordertop+(monster1[2]*12)),
                                        12,12,
                                        $c0)
                                setpole(monster1[1],monster1[2]-i,0)
                                setpole(monster1[1],monster1[2],8)
                        ENDIF
                ENDIF
        ENDIF
        IF monster2[0]=2
                i:=Rnd(3)-1
                j:=Rnd(2)
                IF j=0
                        IF getpole(monster2[1]+i,monster2[2])=0
                                monster2[1]:=monster2[1]+i
                                BltBitMapRastPort(picTlo.bitmap(),(monster2[1]-i)*12,(monster2[2])*12,win.rport,
                                        (win.borderleft+((monster2[1]-i)*12)),(win.bordertop+((monster2[2])*12)),
                                        12,12,
                                        $c0)
                                BltBitMapRastPort(IF Rnd(2)=0 THEN picM1.bitmap() ELSE picM2.bitmap(),0,0,win.rport,
                                        (win.borderleft+(monster2[1]*12)),(win.bordertop+(monster2[2]*12)),
                                        12,12,
                                        $c0)
                                setpole(monster2[1]-i,monster2[2],0)
                                setpole(monster2[1],monster2[2],8)
                        ENDIF
                ENDIF
                IF j=1
                        IF getpole(monster2[1],monster2[2]+i)=0
                                monster2[2]:=monster2[2]+i
                                BltBitMapRastPort(picTlo.bitmap(),(monster2[1])*12,(monster2[2]-i)*12,win.rport,
                                        (win.borderleft+((monster2[1])*12)),(win.bordertop+((monster2[2]-i)*12)),
                                        12,12,
                                        $c0)
                                BltBitMapRastPort(IF Rnd(2)=0 THEN picM1.bitmap() ELSE picM2.bitmap(),0,0,win.rport,
                                        (win.borderleft+(monster2[1]*12)),(win.bordertop+(monster2[2]*12)),
                                        12,12,
                                        $c0)
                                setpole(monster2[1],monster2[2]-i,0)
                                setpole(monster2[1],monster2[2],8)
                        ENDIF
                ENDIF
        ENDIF
        IF monster3[0]=2
                i:=Rnd(3)-1
                j:=Rnd(2)
                IF j=0
                        IF getpole(monster3[1]+i,monster3[2])=0
                                monster3[1]:=monster3[1]+i
                                BltBitMapRastPort(picTlo.bitmap(),(monster3[1]-i)*12,(monster3[2])*12,win.rport,
                                        (win.borderleft+((monster3[1]-i)*12)),(win.bordertop+((monster3[2])*12)),
                                        12,12,
                                        $c0)
                                BltBitMapRastPort(IF Rnd(2)=0 THEN picM1.bitmap() ELSE picM2.bitmap(),0,0,win.rport,
                                        (win.borderleft+(monster3[1]*12)),(win.bordertop+(monster3[2]*12)),
                                        12,12,
                                        $c0)
                                setpole(monster3[1]-i,monster3[2],0)
                                setpole(monster3[1],monster3[2],8)
                        ENDIF
                ENDIF
                IF j=1
                        IF getpole(monster3[1],monster3[2]+i)=0
                                monster3[2]:=monster3[2]+i
                                BltBitMapRastPort(picTlo.bitmap(),(monster3[1])*12,(monster3[2]-i)*12,win.rport,
                                        (win.borderleft+((monster3[1])*12)),(win.bordertop+((monster3[2]-i)*12)),
                                        12,12,
                                        $c0)
                                BltBitMapRastPort(IF Rnd(2)=0 THEN picM1.bitmap() ELSE picM2.bitmap(),0,0,win.rport,
                                        (win.borderleft+(monster3[1]*12)),(win.bordertop+(monster3[2]*12)),
                                        12,12,
                                        $c0)
                                setpole(monster3[1],monster3[2]-i,0)
                                setpole(monster3[1],monster3[2],8)
                        ENDIF
                ENDIF
        ENDIF
        IF monster4[0]=2
                i:=Rnd(3)-1
                j:=Rnd(2)
                IF j=0
                        IF getpole(monster4[1]+i,monster4[2])=0
                                monster4[1]:=monster4[1]+i
                                BltBitMapRastPort(picTlo.bitmap(),(monster4[1]-i)*12,(monster4[2])*12,win.rport,
                                        (win.borderleft+((monster4[1]-i)*12)),(win.bordertop+((monster4[2])*12)),
                                        12,12,
                                        $c0)
                                BltBitMapRastPort(IF Rnd(2)=0 THEN picM1.bitmap() ELSE picM2.bitmap(),0,0,win.rport,
                                        (win.borderleft+(monster4[1]*12)),(win.bordertop+(monster4[2]*12)),
                                        12,12,
                                        $c0)
                                setpole(monster4[1]-i,monster4[2],0)
                                setpole(monster4[1],monster4[2],8)
                        ENDIF
                ENDIF
                IF j=1
                        IF getpole(monster4[1],monster4[2]+i)=0
                                monster4[2]:=monster4[2]+i
                                BltBitMapRastPort(picTlo.bitmap(),(monster4[1])*12,(monster4[2]-i)*12,win.rport,
                                        (win.borderleft+((monster4[1])*12)),(win.bordertop+((monster4[2]-i)*12)),
                                        12,12,
                                        $c0)
                                BltBitMapRastPort(IF Rnd(2)=0 THEN picM1.bitmap() ELSE picM2.bitmap(),0,0,win.rport,
                                        (win.borderleft+(monster4[1]*12)),(win.bordertop+(monster4[2]*12)),
                                        12,12,
                                        $c0)
                                setpole(monster4[1],monster4[2]-i,0)
                                setpole(monster4[1],monster4[2],8)
                        ENDIF
                ENDIF
        ENDIF

        /* Routinen für die Kannone */

        IF cannon1[0]<>0
                cannon1[3]:=cannon1[3]+1
                IF cannon1[3]>19 THEN cannon1[3]:=0
                IF cannon1[0]=1
                        i:=0
                        REPEAT
                                REPEAT
                                        i:=i+1
                                UNTIL getpole(cannon1[1]-i,cannon1[2])<>0
                        UNTIL getpole(cannon1[1]-i,cannon1[2])<>-1
                        IF cannon1[3]=10
                                FOR j:=cannon1[1]-i+1 TO cannon1[1]-1
                                BltBitMapRastPort(picTlo.bitmap(),(((j)*12)),(((cannon1[2])*12)),win.rport,
                                        (win.borderleft+((j)*12)),(win.bordertop+((cannon1[2])*12)),
                                        12,12,
                                        $c0)
                                setpole(j,cannon1[2],0)
                                ENDFOR
                        ENDIF
                        IF cannon1[3]<=9
                                FOR j:=cannon1[1]-i+1 TO cannon1[1]-1
                                        IF ((abbo[1]=cannon1[2]) AND (abbo[0]=j)) THEN koniec()
                                BltBitMapRastPort(IF Rnd(2)=0 THEN picF1.bitmap() ELSE picF2.bitmap(),0,0,win.rport,
                                        (win.borderleft+((j)*12)),(win.bordertop+((cannon1[2])*12)),
                                        12,12,
                                        $c0)
                                        playData(cannonS,cannonSlen,10000+Rnd(20000),CHAN_RIGHT1,8)
                                setpole(j,cannon1[2],-1)
                                ENDFOR
                        ENDIF
                ENDIF
                IF cannon1[0]=2
                        i:=0
                        REPEAT
                                REPEAT
                                        i:=i+1
                                UNTIL getpole(cannon1[1]+i,cannon1[2])<>0
                        UNTIL getpole(cannon1[1]+i,cannon1[2])<>-1
                        IF cannon1[3]=10
                                FOR j:=cannon1[1]+1 TO cannon1[1]+i-1
                                BltBitMapRastPort(picTlo.bitmap(),(((j)*12)),(((cannon1[2])*12)),win.rport,
                                        (win.borderleft+((j)*12)),(win.bordertop+((cannon1[2])*12)),
                                        12,12,
                                        $c0)
                                setpole(j,cannon1[2],0)
                                ENDFOR
                        ENDIF
                        IF cannon1[3]<=9
                                FOR j:=cannon1[1]+1 TO cannon1[1]+i-1
                                        IF ((abbo[1]=cannon1[2]) AND (abbo[0]=j)) THEN koniec()
                                BltBitMapRastPort(IF Rnd(2)=0 THEN picF1.bitmap() ELSE picF2.bitmap(),0,0,win.rport,
                                        (win.borderleft+((j)*12)),(win.bordertop+((cannon1[2])*12)),
                                        12,12,
                                        $c0)
                                        playData(cannonS,cannonSlen,10000+Rnd(20000),CHAN_RIGHT1,8)
                                setpole(j,cannon1[2],-1)
                                ENDFOR
                        ENDIF
                ENDIF
        ENDIF
        IF cannon2[0]<>0
                cannon2[3]:=cannon2[3]+1
                IF cannon2[3]>19 THEN cannon2[3]:=0
                IF cannon2[0]=1
                        i:=0
                        REPEAT
                                REPEAT
                                        i:=i+1
                                UNTIL getpole(cannon2[1]-i,cannon2[2])<>0
                        UNTIL getpole(cannon2[1]-i,cannon2[2])<>-1
                        IF cannon2[3]=10
                                FOR j:=cannon2[1]-i+1 TO cannon2[1]-1
                                BltBitMapRastPort(picTlo.bitmap(),(((j)*12)),(((cannon2[2])*12)),win.rport,
                                        (win.borderleft+((j)*12)),(win.bordertop+((cannon2[2])*12)),
                                        12,12,
                                        $c0)
                                setpole(j,cannon2[2],0)
                                ENDFOR
                        ENDIF
                        IF cannon2[3]<=9
                                FOR j:=cannon2[1]-i+1 TO cannon2[1]-1
                                        IF ((abbo[1]=cannon2[2]) AND (abbo[0]=j)) THEN koniec()
                                BltBitMapRastPort(IF Rnd(2)=0 THEN picF1.bitmap() ELSE picF2.bitmap(),0,0,win.rport,
                                        (win.borderleft+((j)*12)),(win.bordertop+((cannon2[2])*12)),
                                        12,12,
                                        $c0)
                                        playData(cannonS,cannonSlen,10000+Rnd(20000),CHAN_RIGHT1,8)
                                setpole(j,cannon2[2],-1)
                                ENDFOR
                        ENDIF
                ENDIF
                IF cannon2[0]=2
                        i:=0
                        REPEAT
                                REPEAT
                                        i:=i+1
                                UNTIL getpole(cannon2[1]+i,cannon2[2])<>0
                        UNTIL getpole(cannon2[1]+i,cannon2[2])<>-1
                        IF cannon2[3]=10
                                FOR j:=cannon2[1]+1 TO cannon2[1]+i-1
                                BltBitMapRastPort(picTlo.bitmap(),(((j)*12)),(((cannon2[2])*12)),win.rport,
                                        (win.borderleft+((j)*12)),(win.bordertop+((cannon2[2])*12)),
                                        12,12,
                                        $c0)
                                setpole(j,cannon2[2],0)
                                ENDFOR
                        ENDIF
                        IF cannon2[3]<=9
                                FOR j:=cannon2[1]+1 TO cannon2[1]+i-1
                                        IF ((abbo[1]=cannon2[2]) AND (abbo[0]=j)) THEN koniec()
                                BltBitMapRastPort(IF Rnd(2)=0 THEN picF1.bitmap() ELSE picF2.bitmap(),0,0,win.rport,
                                        (win.borderleft+((j)*12)),(win.bordertop+((cannon2[2])*12)),
                                        12,12,
                                        $c0)
                                        playData(cannonS,cannonSlen,10000+Rnd(20000),CHAN_RIGHT1,8)
                                setpole(j,cannon2[2],-1)
                                ENDFOR
                        ENDIF
                ENDIF
        ENDIF
        IF cannon3[0]<>0
                cannon3[3]:=cannon3[3]+1
                IF cannon3[3]>19 THEN cannon3[3]:=0
                IF cannon3[0]=1
                        i:=0
                        REPEAT
                                REPEAT
                                        i:=i+1
                                UNTIL getpole(cannon3[1]-i,cannon3[2])<>0
                        UNTIL getpole(cannon3[1]-i,cannon3[2])<>-1
                        IF cannon3[3]=10
                                FOR j:=cannon3[1]-i+1 TO cannon3[1]-1
                                BltBitMapRastPort(picTlo.bitmap(),(((j)*12)),(((cannon3[2])*12)),win.rport,
                                        (win.borderleft+((j)*12)),(win.bordertop+((cannon3[2])*12)),
                                        12,12,
                                        $c0)
                                setpole(j,cannon3[2],0)
                                ENDFOR
                        ENDIF
                        IF cannon3[3]<=9
                                FOR j:=cannon3[1]-i+1 TO cannon3[1]-1
                                        IF ((abbo[1]=cannon3[2]) AND (abbo[0]=j)) THEN koniec()
                                BltBitMapRastPort(IF Rnd(2)=0 THEN picF1.bitmap() ELSE picF2.bitmap(),0,0,win.rport,
                                        (win.borderleft+((j)*12)),(win.bordertop+((cannon3[2])*12)),
                                        12,12,
                                        $c0)
                                        playData(cannonS,cannonSlen,10000+Rnd(20000),CHAN_RIGHT1,8)
                                setpole(j,cannon3[2],-1)
                                ENDFOR
                        ENDIF
                ENDIF
                IF cannon3[0]=2
                        i:=0
                        REPEAT
                                REPEAT
                                        i:=i+1
                                UNTIL getpole(cannon3[1]+i,cannon3[2])<>0
                        UNTIL getpole(cannon3[1]+i,cannon3[2])<>-1
                        IF cannon3[3]=10
                                FOR j:=cannon3[1]+1 TO cannon3[1]+i-1
                                BltBitMapRastPort(picTlo.bitmap(),(((j)*12)),(((cannon3[2])*12)),win.rport,
                                        (win.borderleft+((j)*12)),(win.bordertop+((cannon3[2])*12)),
                                        12,12,
                                        $c0)
                                setpole(j,cannon3[2],0)
                                ENDFOR
                        ENDIF
                        IF cannon3[3]<=9
                                FOR j:=cannon3[1]+1 TO cannon3[1]+i-1
                                        IF ((abbo[1]=cannon3[2]) AND (abbo[0]=j)) THEN koniec()
                                BltBitMapRastPort(IF Rnd(2)=0 THEN picF1.bitmap() ELSE picF2.bitmap(),0,0,win.rport,
                                        (win.borderleft+((j)*12)),(win.bordertop+((cannon3[2])*12)),
                                        12,12,
                                        $c0)
                                        playData(cannonS,cannonSlen,10000+Rnd(20000),CHAN_RIGHT1,8)
                                setpole(j,cannon3[2],-1)
                                ENDFOR
                        ENDIF
                ENDIF
        ENDIF
        IF cannon4[0]<>0
                cannon4[3]:=cannon4[3]+1
                IF cannon4[3]>19 THEN cannon4[3]:=0
                IF cannon4[0]=1
                        i:=0
                        REPEAT
                                REPEAT
                                        i:=i+1
                                UNTIL getpole(cannon4[1]-i,cannon4[2])<>0
                        UNTIL getpole(cannon4[1]-i,cannon4[2])<>-1
                        IF cannon4[3]=10
                                FOR j:=cannon4[1]-i+1 TO cannon4[1]-1
                                BltBitMapRastPort(picTlo.bitmap(),(((j)*12)),(((cannon4[2])*12)),win.rport,
                                        (win.borderleft+((j)*12)),(win.bordertop+((cannon4[2])*12)),
                                        12,12,
                                        $c0)
                                setpole(j,cannon4[2],0)
                                ENDFOR
                        ENDIF
                        IF cannon4[3]<=9
                                FOR j:=cannon4[1]-i+1 TO cannon4[1]-1
                                        IF ((abbo[1]=cannon4[2]) AND (abbo[0]=j)) THEN koniec()
                                BltBitMapRastPort(IF Rnd(2)=0 THEN picF1.bitmap() ELSE picF2.bitmap(),0,0,win.rport,
                                        (win.borderleft+((j)*12)),(win.bordertop+((cannon4[2])*12)),
                                        12,12,
                                        $c0)
                                        playData(cannonS,cannonSlen,10000+Rnd(20000),CHAN_RIGHT1,8)
                                setpole(j,cannon4[2],-1)
                                ENDFOR
                        ENDIF
                ENDIF
                IF cannon4[0]=2
                        i:=0
                        REPEAT
                                REPEAT
                                        i:=i+1
                                UNTIL getpole(cannon4[1]+i,cannon4[2])<>0
                        UNTIL getpole(cannon4[1]+i,cannon4[2])<>-1
                        IF cannon4[3]=10
                                FOR j:=cannon4[1]+1 TO cannon4[1]+i-1
                                BltBitMapRastPort(picTlo.bitmap(),(((j)*12)),(((cannon4[2])*12)),win.rport,
                                        (win.borderleft+((j)*12)),(win.bordertop+((cannon4[2])*12)),
                                        12,12,
                                        $c0)
                                setpole(j,cannon4[2],0)
                                ENDFOR
                        ENDIF
                        IF cannon4[3]<=9
                                FOR j:=cannon4[1]+1 TO cannon4[1]+i-1
                                        IF ((abbo[1]=cannon4[2]) AND (abbo[0]=j)) THEN koniec()
                                BltBitMapRastPort(IF Rnd(2)=0 THEN picF1.bitmap() ELSE picF2.bitmap(),0,0,win.rport,
                                        (win.borderleft+((j)*12)),(win.bordertop+((cannon4[2])*12)),
                                        12,12,
                                        $c0)
                                        playData(cannonS,cannonSlen,10000+Rnd(20000),CHAN_RIGHT1,8)
                                setpole(j,cannon4[2],-1)
                                ENDFOR
                        ENDIF
                ENDIF
        ENDIF

        /* Routinen für die Bewegung der Gitter (kratka) */


                                        IF kratka1[0]<>0
                                                IF kratka1[0]=2
                                                                IF getpole(kratka1[1],kratka1[2]+1)=0
                                                                        playData(box,boxlen,9000,CHAN_LEFT2,64)
                                                                        setpole(kratka1[1],kratka1[2],0)
                                                                        setpole(kratka1[1],kratka1[2]+1,4)
                                                                        kratka1[2]:=kratka1[2]+1
        BltBitMapRastPort(picTlo.bitmap(),((kratka1[1]*12)),(((kratka1[2]-1)*12)),win.rport,
                                        (win.borderleft+(kratka1[1]*12)),(win.bordertop+((kratka1[2]-1)*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picKrak.bitmap(),0,0,win.rport,
                                        (win.borderleft+(kratka1[1]*12)),(win.bordertop+(kratka1[2]*12)),
                                        12,12,
                                        $c0)
                                                                ELSE
                                                                        kratka1[0]:=0
                                                                ENDIF
                                                ENDIF
                                                IF kratka1[0]=8
                                                                IF getpole(kratka1[1],kratka1[2]-1)=0
                                                                        playData(box,boxlen,9000,CHAN_LEFT2,64)
                                                                        setpole(kratka1[1],kratka1[2],0)
                                                                        setpole(kratka1[1],kratka1[2]-1,4)
                                                                        kratka1[2]:=kratka1[2]-1
        BltBitMapRastPort(picTlo.bitmap(),((kratka1[1]*12)),(((kratka1[2]+1)*12)),win.rport,
                                        (win.borderleft+(kratka1[1]*12)),(win.bordertop+((kratka1[2]+1)*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picKrak.bitmap(),0,0,win.rport,
                                        (win.borderleft+(kratka1[1]*12)),(win.bordertop+(kratka1[2]*12)),
                                        12,12,
                                        $c0)
                                                                ELSE
                                                                        kratka1[0]:=0
                                                                ENDIF
                                                ENDIF
                                                IF kratka1[0]=4
                                                                IF getpole(kratka1[1]-1,kratka1[2])=0
                                                                        playData(box,boxlen,9000,CHAN_LEFT2,64)
                                                                        setpole(kratka1[1],kratka1[2],0)
                                                                        setpole(kratka1[1]-1,kratka1[2],4)
                                                                        kratka1[1]:=kratka1[1]-1
        BltBitMapRastPort(picTlo.bitmap(),(((kratka1[1]+1)*12)),(((kratka1[2])*12)),win.rport,
                                        (win.borderleft+((kratka1[1]+1)*12)),(win.bordertop+((kratka1[2])*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picKrak.bitmap(),0,0,win.rport,
                                        (win.borderleft+(kratka1[1]*12)),(win.bordertop+(kratka1[2]*12)),
                                        12,12,
                                        $c0)
                                                                ELSE
                                                                        kratka1[0]:=0
                                                                ENDIF
                                                ENDIF
                                                IF kratka1[0]=6
                                                                IF getpole(kratka1[1]+1,kratka1[2])=0
                                                                        playData(box,boxlen,9000,CHAN_LEFT2,64)
                                                                        setpole(kratka1[1],kratka1[2],0)
                                                                        setpole(kratka1[1]+1,kratka1[2],4)
                                                                        kratka1[1]:=kratka1[1]+1
        BltBitMapRastPort(picTlo.bitmap(),(((kratka1[1]-1)*12)),(((kratka1[2])*12)),win.rport,
                                        (win.borderleft+((kratka1[1]-1)*12)),(win.bordertop+((kratka1[2])*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picKrak.bitmap(),0,0,win.rport,
                                        (win.borderleft+(kratka1[1]*12)),(win.bordertop+(kratka1[2]*12)),
                                        12,12,
                                        $c0)
                                                                ELSE
                                                                        kratka1[0]:=0
                                                                ENDIF
                                                ENDIF
                                        ENDIF

                                        IF kratka2[0]<>0
                                                IF kratka2[0]=2
                                                                IF getpole(kratka2[1],kratka2[2]+1)=0
                                                                        playData(box,boxlen,9000,CHAN_LEFT2,64)
                                                                        setpole(kratka2[1],kratka2[2],0)
                                                                        setpole(kratka2[1],kratka2[2]+1,4)
                                                                        kratka2[2]:=kratka2[2]+1
        BltBitMapRastPort(picTlo.bitmap(),((kratka2[1]*12)),(((kratka2[2]-1)*12)),win.rport,
                                        (win.borderleft+(kratka2[1]*12)),(win.bordertop+((kratka2[2]-1)*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picKrak.bitmap(),0,0,win.rport,
                                        (win.borderleft+(kratka2[1]*12)),(win.bordertop+(kratka2[2]*12)),
                                        12,12,
                                        $c0)
                                                                ELSE
                                                                        kratka2[0]:=0
                                                                ENDIF
                                                ENDIF
                                                IF kratka2[0]=8
                                                                IF getpole(kratka2[1],kratka2[2]-1)=0
                                                                        playData(box,boxlen,9000,CHAN_LEFT2,64)
                                                                        setpole(kratka2[1],kratka2[2],0)
                                                                        setpole(kratka2[1],kratka2[2]-1,4)
                                                                        kratka2[2]:=kratka2[2]-1
        BltBitMapRastPort(picTlo.bitmap(),((kratka2[1]*12)),(((kratka2[2]+1)*12)),win.rport,
                                        (win.borderleft+(kratka2[1]*12)),(win.bordertop+((kratka2[2]+1)*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picKrak.bitmap(),0,0,win.rport,
                                        (win.borderleft+(kratka2[1]*12)),(win.bordertop+(kratka2[2]*12)),
                                        12,12,
                                        $c0)
                                                                ELSE
                                                                        kratka2[0]:=0
                                                                ENDIF
                                                ENDIF
                                                IF kratka2[0]=4
                                                                IF getpole(kratka2[1]-1,kratka2[2])=0
                                                                        playData(box,boxlen,9000,CHAN_LEFT2,64)
                                                                        setpole(kratka2[1],kratka2[2],0)
                                                                        setpole(kratka2[1]-1,kratka2[2],4)
                                                                        kratka2[1]:=kratka2[1]-1
        BltBitMapRastPort(picTlo.bitmap(),(((kratka2[1]+1)*12)),(((kratka2[2])*12)),win.rport,
                                        (win.borderleft+((kratka2[1]+1)*12)),(win.bordertop+((kratka2[2])*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picKrak.bitmap(),0,0,win.rport,
                                        (win.borderleft+(kratka2[1]*12)),(win.bordertop+(kratka2[2]*12)),
                                        12,12,
                                        $c0)
                                                                ELSE
                                                                        kratka2[0]:=0
                                                                ENDIF
                                                ENDIF
                                                IF kratka2[0]=6
                                                                IF getpole(kratka2[1]+1,kratka2[2])=0
                                                                        playData(box,boxlen,9000,CHAN_LEFT2,64)
                                                                        setpole(kratka2[1],kratka2[2],0)
                                                                        setpole(kratka2[1]+1,kratka2[2],4)
                                                                        kratka2[1]:=kratka2[1]+1
        BltBitMapRastPort(picTlo.bitmap(),(((kratka2[1]-1)*12)),(((kratka2[2])*12)),win.rport,
                                        (win.borderleft+((kratka2[1]-1)*12)),(win.bordertop+((kratka2[2])*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picKrak.bitmap(),0,0,win.rport,
                                        (win.borderleft+(kratka2[1]*12)),(win.bordertop+(kratka2[2]*12)),
                                        12,12,
                                        $c0)
                                                                ELSE
                                                                        kratka2[0]:=0
                                                                ENDIF
                                                ENDIF
                                        ENDIF

                                        IF kratka3[0]<>0
                                                IF kratka3[0]=2
                                                                IF getpole(kratka3[1],kratka3[2]+1)=0
                                                                        playData(box,boxlen,9000,CHAN_LEFT2,64)
                                                                        setpole(kratka3[1],kratka3[2],0)
                                                                        setpole(kratka3[1],kratka3[2]+1,4)
                                                                        kratka3[2]:=kratka3[2]+1
        BltBitMapRastPort(picTlo.bitmap(),(win.borderleft+(kratka3[1]*12)),(win.bordertop+((kratka3[2]-1)*12)),win.rport,
                                        (win.borderleft+(kratka3[1]*12)),(win.bordertop+((kratka3[2]-1)*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picKrak.bitmap(),0,0,win.rport,
                                        (win.borderleft+(kratka3[1]*12)),(win.bordertop+(kratka3[2]*12)),
                                        12,12,
                                        $c0)
                                                                ELSE
                                                                        kratka3[0]:=0
                                                                ENDIF
                                                ENDIF
                                                IF kratka3[0]=8
                                                                IF getpole(kratka3[1],kratka3[2]-1)=0
                                                                        playData(box,boxlen,9000,CHAN_LEFT2,64)
                                                                        setpole(kratka3[1],kratka3[2],0)
                                                                        setpole(kratka3[1],kratka3[2]-1,4)
                                                                        kratka3[2]:=kratka3[2]-1
        BltBitMapRastPort(picTlo.bitmap(),(win.borderleft+(kratka3[1]*12)),(win.bordertop+((kratka3[2]+1)*12)),win.rport,
                                        (win.borderleft+(kratka3[1]*12)),(win.bordertop+((kratka3[2]+1)*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picKrak.bitmap(),0,0,win.rport,
                                        (win.borderleft+(kratka3[1]*12)),(win.bordertop+(kratka3[2]*12)),
                                        12,12,
                                        $c0)
                                                                ELSE
                                                                        kratka3[0]:=0
                                                                ENDIF
                                                ENDIF
                                                IF kratka3[0]=4
                                                                IF getpole(kratka3[1]-1,kratka3[2])=0
                                                                        playData(box,boxlen,9000,CHAN_LEFT2,64)
                                                                        setpole(kratka3[1],kratka3[2],0)
                                                                        setpole(kratka3[1]-1,kratka3[2],4)
                                                                        kratka3[1]:=kratka3[1]-1
        BltBitMapRastPort(picTlo.bitmap(),(((kratka3[1]+1)*12)),(((kratka3[2])*12)),win.rport,
                                        (win.borderleft+((kratka3[1]+1)*12)),(win.bordertop+((kratka3[2])*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picKrak.bitmap(),0,0,win.rport,
                                        (win.borderleft+(kratka3[1]*12)),(win.bordertop+(kratka3[2]*12)),
                                        12,12,
                                        $c0)
                                                                ELSE
                                                                        kratka3[0]:=0
                                                                ENDIF
                                                ENDIF
                                                IF kratka3[0]=6
                                                                IF getpole(kratka3[1]+1,kratka3[2])=0
                                                                        playData(box,boxlen,9000,CHAN_LEFT2,64)
                                                                        setpole(kratka3[1],kratka3[2],0)
                                                                        setpole(kratka3[1]+1,kratka3[2],4)
                                                                        kratka3[1]:=kratka3[1]+1
        BltBitMapRastPort(picTlo.bitmap(),(((kratka3[1]-1)*12)),(((kratka3[2])*12)),win.rport,
                                        (win.borderleft+((kratka3[1]-1)*12)),(win.bordertop+((kratka3[2])*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picKrak.bitmap(),0,0,win.rport,
                                        (win.borderleft+(kratka3[1]*12)),(win.bordertop+(kratka3[2]*12)),
                                        12,12,
                                        $c0)
                                                                ELSE
                                                                        kratka3[0]:=0
                                                                ENDIF
                                                ENDIF
                                        ENDIF

                                        IF kratka4[0]<>0
                                                IF kratka4[0]=2
                                                                IF getpole(kratka4[1],kratka4[2]+1)=0
                                                                        playData(box,boxlen,9000,CHAN_LEFT2,64)
                                                                        setpole(kratka4[1],kratka4[2],0)
                                                                        setpole(kratka4[1],kratka4[2]+1,4)
                                                                        kratka4[2]:=kratka4[2]+1
        BltBitMapRastPort(picTlo.bitmap(),((kratka4[1]*12)),(((kratka4[2]-1)*12)),win.rport,
                                        (win.borderleft+(kratka4[1]*12)),(win.bordertop+((kratka4[2]-1)*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picKrak.bitmap(),0,0,win.rport,
                                        (win.borderleft+(kratka4[1]*12)),(win.bordertop+(kratka4[2]*12)),
                                        12,12,
                                        $c0)
                                                                ELSE
                                                                        kratka4[0]:=0
                                                                ENDIF
                                                ENDIF
                                                IF kratka4[0]=8
                                                                IF getpole(kratka4[1],kratka4[2]-1)=0
                                                                        playData(box,boxlen,9000,CHAN_LEFT2,64)
                                                                        setpole(kratka4[1],kratka4[2],0)
                                                                        setpole(kratka4[1],kratka4[2]-1,4)
                                                                        kratka4[2]:=kratka4[2]-1
        BltBitMapRastPort(picTlo.bitmap(),((kratka4[1]*12)),(((kratka4[2]+1)*12)),win.rport,
                                        (win.borderleft+(kratka4[1]*12)),(win.bordertop+((kratka4[2]+1)*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picKrak.bitmap(),0,0,win.rport,
                                        (win.borderleft+(kratka4[1]*12)),(win.bordertop+(kratka4[2]*12)),
                                        12,12,
                                        $c0)
                                                                ELSE
                                                                        kratka4[0]:=0
                                                                ENDIF
                                                ENDIF
                                                IF kratka4[0]=4
                                                                IF getpole(kratka4[1]-1,kratka4[2])=0
                                                                        playData(box,boxlen,9000,CHAN_LEFT2,64)
                                                                        setpole(kratka4[1],kratka4[2],0)
                                                                        setpole(kratka4[1]-1,kratka4[2],4)
                                                                        kratka4[1]:=kratka4[1]-1
        BltBitMapRastPort(picTlo.bitmap(),(((kratka4[1]+1)*12)),(((kratka4[2])*12)),win.rport,
                                        (win.borderleft+((kratka4[1]+1)*12)),(win.bordertop+((kratka4[2])*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picKrak.bitmap(),0,0,win.rport,
                                        (win.borderleft+(kratka4[1]*12)),(win.bordertop+(kratka4[2]*12)),
                                        12,12,
                                        $c0)
                                                                ELSE
                                                                        kratka4[0]:=0
                                                                ENDIF
                                                ENDIF
                                                IF kratka4[0]=6
                                                                IF getpole(kratka4[1]+1,kratka4[2])=0
                                                                        playData(box,boxlen,9000,CHAN_LEFT2,64)
                                                                        setpole(kratka4[1],kratka4[2],0)
                                                                        setpole(kratka4[1]+1,kratka4[2],4)
                                                                        kratka4[1]:=kratka4[1]+1
        BltBitMapRastPort(picTlo.bitmap(),(((kratka4[1]-1)*12)),(((kratka4[2])*12)),win.rport,
                                        (win.borderleft+((kratka4[1]-1)*12)),(win.bordertop+((kratka4[2])*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picKrak.bitmap(),0,0,win.rport,
                                        (win.borderleft+(kratka4[1]*12)),(win.bordertop+(kratka4[2]*12)),
                                        12,12,
                                        $c0)
                                                                ELSE
                                                                        kratka4[0]:=0
                                                                ENDIF
                                                ENDIF
                                        ENDIF
                                        /* Routinen der Tastaturabfrage */

                                                IF oldkey=key
                                                    IF GetKey()=77      -> runter (down)
                                                        dol()
                                                        key:=0
                                                    ENDIF
                                                    IF GetKey()=76      -> hoch (up)
                                                        gora()
                                                        key:=0
                                                    ENDIF
                                                    IF GetKey()=78      -> rechts (right)
                                                        prawo()
                                                        key:=0
                                                    ENDIF
                                                    IF GetKey()=79      -> links (lefth)
                                                       lewo()
                                                       key:=0
                                                    ENDIF
                                                    IF GetKey()=$10     -> Ende (Quit)
                                                       key:=0
                                                       level:=0
                                                       ReplyMsg(imsg)
                                                       start()
                                                    ENDIF
                                                ENDIF
                                                IF key=77 THEN dol()    -> down
                                                IF key=76 THEN gora()   -> up
                                                IF key=78 THEN prawo()  -> right
                                                IF key=79 THEN lewo()   -> lefth
                                                IF key=$10
                                                    level:=0
                                                    ReplyMsg(imsg)
                                                    start()
                                                ENDIF
                                                oldkey:=key
                                                key:=0

                                IF ((getpole(abbo[0]-1,abbo[1])=8) OR (getpole(abbo[0]+1,abbo[1])=8) OR (getpole(abbo[0],abbo[1]-1)=8) OR (getpole(abbo[0],abbo[1]+1)=8)) THEN koniec()

                                Delay(2)
                                ENDIF

                ReplyMsg(imsg)
                code:=0
        ENDIF


    ->UNTIL class=IDCMP_CLOSEWINDOW
    ENDLOOP

    quit()

ENDPROC

PROC setpole(x,y,var)

    pole[(y*50)+x]:=var

ENDPROC

PROC getpole(x,y)
DEF temporary

    temporary:=pole[(y*50)+x]
    IF ((x<0) OR (y<0) OR (x>49) OR (y>29)) THEN temporary:='~'

ENDPROC temporary

PROC dol()                      -> Abbo nach unten

IF down=1
 down:=2
ELSE
 down:=1
ENDIF
stopChannels(CHAN_LEFT1)
 IF ((getpole(abbo[0],abbo[1]+1)=0) AND (abbo[1]<29))
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(IF down=1 THEN picAbboD1.bitmap() ELSE picAbboD2.bitmap(),0,0,win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+((abbo[1]+1)*12)),
                                        12,12,
                                        $c0)
 abbo[1]:=abbo[1]+1
 playData(step,steplen,20000+Rnd(10000),CHAN_LEFT1,64)
 JUMP koniec_dol
 ENDIF
 IF ((getpole(abbo[0],abbo[1]+1)=12) AND (abbo[1]<29))
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(IF down=1 THEN picAbboD1.bitmap() ELSE picAbboD2.bitmap(),0,0,win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+((abbo[1]+1)*12)),
                                        12,12,
                                        $c0)
 abbo[1]:=abbo[1]+1
 playData(step,steplen,20000+Rnd(10000),CHAN_LEFT1,64)
 next_level()
 ENDIF
 IF (getpole(abbo[0],abbo[1]+1)=11)
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(IF down=1 THEN picAbboD1.bitmap() ELSE picAbboD2.bitmap(),0,0,win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+((abbo[1]+1)*12)),
                                        12,12,
                                        $c0)
 abbo[1]:=abbo[1]+1
 stopChannels(CHAN_RIGHT2)
 playData(diam,diamlen,12000,CHAN_RIGHT2,64)
 diamenty:=diamenty-1
 setpole(abbo[0],abbo[1],0)
 IF diamenty=0 THEN show_exit()
 JUMP koniec_dol
 ENDIF
 IF ((getpole(abbo[0],abbo[1]+1)=10) AND (klucze>=1))
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(IF down=1 THEN picAbboD1.bitmap() ELSE picAbboD2.bitmap(),0,0,win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+((abbo[1]+1)*12)),
                                        12,12,
                                        $c0)
 abbo[1]:=abbo[1]+1
 setpole(abbo[0],abbo[1],0)
 stopChannels(CHAN_RIGHT2)
 playData(door,doorlen,17000,CHAN_RIGHT2,64)
 klucze:=klucze-1
 JUMP koniec_dol
 ENDIF
 IF (getpole(abbo[0],abbo[1]+1)=9)
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(IF down=1 THEN picAbboD1.bitmap() ELSE picAbboD2.bitmap(),0,0,win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+((abbo[1]+1)*12)),
                                        12,12,
                                        $c0)
 abbo[1]:=abbo[1]+1
 setpole(abbo[0],abbo[1],0)
 klucze:=klucze+1
 stopChannels(CHAN_RIGHT2)
 playData(keyF,keyFlen,15500,CHAN_RIGHT2,64)
 JUMP koniec_dol
 ENDIF
 IF ((getpole(abbo[0],abbo[1]+1)=2) AND ((abbo[1]+1)<29) AND (getpole(abbo[0],abbo[1]+2)=0))
       BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(IF down=1 THEN picAbboD1.bitmap() ELSE picAbboD2.bitmap(),0,0,win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+((abbo[1]+1)*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picKra.bitmap(),0,0,win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+((abbo[1]+2)*12)),
                                        12,12,
                                        $c0)
 setpole(abbo[0],abbo[1]+1,0)
 setpole(abbo[0],abbo[1]+2,2)
 playData(box,boxlen,9000,CHAN_LEFT1,64)
 abbo[1]:=abbo[1]+1
 JUMP koniec_dol
 ENDIF
 IF ((getpole(abbo[0],abbo[1]+1)=4) AND ((abbo[1]+1)<29) AND (getpole(abbo[0],abbo[1]+2)=0))
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(IF down=1 THEN picAbboD1.bitmap() ELSE picAbboD2.bitmap(),0,0,win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+((abbo[1]+1)*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picKrak.bitmap(),0,0,win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+((abbo[1]+2)*12)),
                                        12,12,
                                        $c0)
 setpole(abbo[0],abbo[1]+1,0)
 setpole(abbo[0],abbo[1]+2,4)
 abbo[1]:=abbo[1]+1
 playData(box,boxlen,9000,CHAN_LEFT1,64)
  IF getpole(abbo[0],abbo[1]+2)=0

   IF kratka1[0]<>0
        IF kratka2[0]<>0
         IF kratka3[0]<>0
          kratka4[0]:=2
          kratka4[1]:=abbo[0]
          kratka4[2]:=abbo[1]+1
 JUMP koniec_dol
         ENDIF
     kratka3[0]:=2
         kratka3[1]:=abbo[0]
         kratka3[2]:=abbo[1]+1
 JUMP koniec_dol
        ENDIF
    kratka2[0]:=2
        kratka2[1]:=abbo[0]
        kratka2[2]:=abbo[1]+1
 JUMP koniec_dol
   ENDIF
   kratka1[0]:=2
   kratka1[1]:=abbo[0]
   kratka1[2]:=abbo[1]+1
 JUMP koniec_dol

  ENDIF
  JUMP koniec_dol

 ENDIF
 IF getpole(abbo[0],abbo[1]+1)=5
  IF ((portal1[0]=(abbo[0])) AND (portal1[1]=(abbo[1]+1)))
        portaluj(1,8)
        check_mag()
        RETURN
  ENDIF
  IF ((portal2[0]=(abbo[0])) AND (portal2[1]=(abbo[1]+1)))
        portaluj(2,8)
        check_mag()
        RETURN
  ENDIF
  IF ((portal3[0]=(abbo[0])) AND (portal3[1]=(abbo[1]+1)))
        portaluj(3,8)
        check_mag()
        RETURN
  ENDIF
  IF ((portal4[0]=(abbo[0])) AND (portal4[1]=(abbo[1]+1)))
        portaluj(4,8)
        check_mag()
        RETURN
  ENDIF
  IF ((portal5[0]=(abbo[0])) AND (portal5[1]=(abbo[1]+1)))
        portaluj(5,8)
        check_mag()
        RETURN
  ENDIF
  IF ((portal6[0]=(abbo[0])) AND (portal6[1]=(abbo[1]+1)))
        portaluj(6,8)
        check_mag()
        RETURN
  ENDIF
  IF ((portal7[0]=(abbo[0])) AND (portal7[1]=(abbo[1]+1)))
        portaluj(7,8)
        check_mag()
        RETURN
  ENDIF
  IF ((portal8[0]=(abbo[0])) AND (portal8[1]=(abbo[1]+1)))
        portaluj(8,8)
        check_mag()
        RETURN
  ENDIF
 ENDIF

 koniec_dol:
 check_mag()
ENDPROC

PROC gora()
stopChannels(CHAN_LEFT1)
 IF ((getpole(abbo[0],abbo[1]-1)=0) AND (abbo[1]>0))
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picAbboG.bitmap(),0,0,win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+((abbo[1]-1)*12)),
                                        12,12,
                                        $c0)
 abbo[1]:=abbo[1]-1
 playData(step,steplen,20000+Rnd(10000),CHAN_LEFT1,64)
 check_mag()
 RETURN
 ENDIF
 IF ((getpole(abbo[0],abbo[1]-1)=12) AND (abbo[1]>0))
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picAbboG.bitmap(),0,0,win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+((abbo[1]-1)*12)),
                                        12,12,
                                        $c0)
 abbo[1]:=abbo[1]-1
 playData(step,steplen,20000+Rnd(10000),CHAN_LEFT1,64)
 next_level()
 ENDIF
 IF (getpole(abbo[0],abbo[1]-1)=11)
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picAbboG.bitmap(),0,0,win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+((abbo[1]-1)*12)),
                                        12,12,
                                        $c0)
 abbo[1]:=abbo[1]-1
 diamenty:=diamenty-1
 stopChannels(CHAN_RIGHT2)
 playData(diam,diamlen,12000,CHAN_RIGHT2,64)
 setpole(abbo[0],abbo[1],0)
 IF diamenty=0 THEN show_exit()
 check_mag()
 RETURN
 ENDIF
 IF ((getpole(abbo[0],abbo[1]-1)=10) AND (klucze>=1))
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picAbboG.bitmap(),0,0,win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+((abbo[1]-1)*12)),
                                        12,12,
                                        $c0)
 abbo[1]:=abbo[1]-1
 setpole(abbo[0],abbo[1],0)
 klucze:=klucze-1
 stopChannels(CHAN_RIGHT2)
 playData(door,doorlen,17000,CHAN_RIGHT2,64)
 check_mag()
 RETURN
 ENDIF
 IF (getpole(abbo[0],abbo[1]-1)=9)
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picAbboG.bitmap(),0,0,win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+((abbo[1]-1)*12)),
                                        12,12,
                                        $c0)
 abbo[1]:=abbo[1]-1
 klucze:=klucze+1
 stopChannels(CHAN_RIGHT2)
 playData(keyF,keyFlen,15500,CHAN_RIGHT2,64)
 setpole(abbo[0],abbo[1],0)
 check_mag()
 RETURN
 ENDIF
 IF ((getpole(abbo[0],abbo[1]-1)=2) AND (abbo[1]-1>0) AND (getpole(abbo[0],abbo[1]-2)=0))
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picAbboG.bitmap(),0,0,win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+((abbo[1]-1)*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picKra.bitmap(),0,0,win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+((abbo[1]-2)*12)),
                                        12,12,
                                        $c0)
 setpole(abbo[0],abbo[1]-1,0)
 setpole(abbo[0],abbo[1]-2,2)
 playData(box,boxlen,9000,CHAN_LEFT1,64)
 abbo[1]:=abbo[1]-1
 ENDIF
 IF ((getpole(abbo[0],abbo[1]-1)=4) AND ((abbo[1]-1)>0) AND (getpole(abbo[0],abbo[1]-2)=0))
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picAbboG.bitmap(),0,0,win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+((abbo[1]-1)*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picKrak.bitmap(),0,0,win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+((abbo[1]-2)*12)),
                                        12,12,
                                        $c0)
 setpole(abbo[0],abbo[1]-1,0)
 setpole(abbo[0],abbo[1]-2,4)
 abbo[1]:=abbo[1]-1
 playData(box,boxlen,9000,CHAN_LEFT1,64)
  IF getpole(abbo[0],abbo[1]-2)=0

   IF kratka1[0]<>0
        IF kratka2[0]<>0
         IF kratka3[0]<>0
          kratka4[0]:=8
          kratka4[1]:=abbo[0]
          kratka4[2]:=abbo[1]-1
         ENDIF
     kratka3[0]:=8
         kratka3[1]:=abbo[0]
         kratka3[2]:=abbo[1]-1
        ENDIF
    kratka2[0]:=8
        kratka2[1]:=abbo[0]
        kratka2[2]:=abbo[1]-1
   ENDIF
   kratka1[0]:=8
   kratka1[1]:=abbo[0]
   kratka1[2]:=abbo[1]-1

 ENDIF
 check_mag()
 RETURN
ENDIF

 IF getpole(abbo[0],abbo[1]-1)=5
  IF ((portal1[0]=(abbo[0])) AND (portal1[1]=(abbo[1]-1)))
        portaluj(1,2)
        check_mag()
        RETURN
  ENDIF
  IF ((portal2[0]=(abbo[0])) AND (portal2[1]=(abbo[1]-1)))
        portaluj(2,2)
        check_mag()
        RETURN
  ENDIF
  IF ((portal3[0]=(abbo[0])) AND (portal3[1]=(abbo[1]-1)))
        portaluj(3,2)
        check_mag()
        RETURN
  ENDIF
  IF ((portal4[0]=(abbo[0])) AND (portal4[1]=(abbo[1]-1)))
        portaluj(4,2)
        check_mag()
        RETURN
  ENDIF
  IF ((portal5[0]=(abbo[0])) AND (portal5[1]=(abbo[1]-1)))
        portaluj(5,2)
        check_mag()
        RETURN
  ENDIF
  IF ((portal6[0]=(abbo[0])) AND (portal6[1]=(abbo[1]-1)))
        portaluj(6,2)
        check_mag()
        RETURN
  ENDIF
  IF ((portal7[0]=(abbo[0])) AND (portal7[1]=(abbo[1]-1)))
        portaluj(7,2)
        check_mag()
        RETURN
  ENDIF
  IF ((portal8[0]=(abbo[0])) AND (portal8[1]=(abbo[1]-1)))
        portaluj(8,2)
        check_mag()
        RETURN
  ENDIF
 ENDIF
 check_mag()
ENDPROC

PROC prawo()
stopChannels(CHAN_LEFT1)
 IF ((getpole(abbo[0]+1,abbo[1])=0) AND (abbo[0]<49))
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picAbboP.bitmap(),0,0,win.rport,
                                        (win.borderleft+((abbo[0]+1)*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
 abbo[0]:=abbo[0]+1
 playData(step,steplen,20000+Rnd(10000),CHAN_LEFT1,64)
 RETURN
 ENDIF
 IF ((getpole(abbo[0]+1,abbo[1])=12) AND (abbo[0]<49))
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picAbboP.bitmap(),0,0,win.rport,
                                        (win.borderleft+((abbo[0]+1)*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
 abbo[0]:=abbo[0]+1
 playData(step,steplen,20000+Rnd(10000),CHAN_LEFT1,64)
 next_level()
 ENDIF
 IF (getpole(abbo[0]+1,abbo[1])=11)
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picAbboP.bitmap(),0,0,win.rport,
                                        (win.borderleft+((abbo[0]+1)*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
 abbo[0]:=abbo[0]+1
 diamenty:=diamenty-1
 stopChannels(CHAN_RIGHT2)
 playData(diam,diamlen,12000,CHAN_RIGHT2,64)
 setpole(abbo[0],abbo[1],0)
 IF diamenty=0 THEN show_exit()
 RETURN
 ENDIF
 IF ((getpole(abbo[0]+1,abbo[1])=10) AND (klucze>=1))
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picAbboP.bitmap(),0,0,win.rport,
                                        (win.borderleft+((abbo[0]+1)*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
 abbo[0]:=abbo[0]+1
 setpole(abbo[0],abbo[1],0)
 klucze:=klucze-1
 stopChannels(CHAN_RIGHT2)
 playData(door,doorlen,17000,CHAN_RIGHT2,64)
 RETURN
 ENDIF
 IF getpole(abbo[0]+1,abbo[1])=9
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picAbboP.bitmap(),0,0,win.rport,
                                        (win.borderleft+((abbo[0]+1)*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
 abbo[0]:=abbo[0]+1
 klucze:=klucze+1
 stopChannels(CHAN_RIGHT2)
 playData(keyF,keyFlen,15500,CHAN_RIGHT2,64)
 setpole(abbo[0],abbo[1],0)
 RETURN
 ENDIF
 IF ((getpole(abbo[0]+1,abbo[1])=2) AND ((abbo[0]+1)<49) AND (getpole(abbo[0]+2,abbo[1])=0))
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picAbboP.bitmap(),0,0,win.rport,
                                        (win.borderleft+((abbo[0]+1)*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picKra.bitmap(),0,0,win.rport,
                                        (win.borderleft+((abbo[0]+2)*12)),(win.bordertop+((abbo[1])*12)),
                                        12,12,
                                        $c0)
 setpole(abbo[0]+1,abbo[1],0)
 setpole(abbo[0]+2,abbo[1],2)
 playData(box,boxlen,9000,CHAN_LEFT1,64)
 abbo[0]:=abbo[0]+1
 ENDIF
 IF ((getpole(abbo[0]+1,abbo[1])=4) AND ((abbo[0]+1)<49) AND (getpole(abbo[0]+2,abbo[1])=0))
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picAbboP.bitmap(),0,0,win.rport,
                                        (win.borderleft+((abbo[0]+1)*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picKrak.bitmap(),0,0,win.rport,
                                        (win.borderleft+((abbo[0]+2)*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
 setpole(abbo[0]+1,abbo[1],0)
 setpole(abbo[0]+2,abbo[1],4)
 abbo[0]:=abbo[0]+1
 playData(box,boxlen,9000,CHAN_LEFT1,64)
  IF getpole(abbo[0]+2,abbo[1])=0

   IF kratka1[0]<>0
        IF kratka2[0]<>0
         IF kratka3[0]<>0
          kratka4[0]:=6
          kratka4[1]:=abbo[0]+1
          kratka4[2]:=abbo[1]
         ENDIF
     kratka3[0]:=6
         kratka3[1]:=abbo[0]+1
         kratka3[2]:=abbo[1]

        ENDIF
    kratka2[0]:=6
        kratka2[1]:=abbo[0]+1
        kratka2[2]:=abbo[1]
   ENDIF
   kratka1[0]:=6
   kratka1[1]:=abbo[0]+1
   kratka1[2]:=abbo[1]

ENDIF
ENDIF
  IF getpole(abbo[0]+1,abbo[1])=5
  IF ((portal1[0]=(abbo[0]+1)) AND (portal1[1]=(abbo[1])))
        portaluj(1,4)
        RETURN
  ENDIF
  IF ((portal2[0]=(abbo[0]+1)) AND (portal2[1]=(abbo[1])))
        portaluj(2,4)
        RETURN
  ENDIF
  IF ((portal3[0]=(abbo[0]+1)) AND (portal3[1]=(abbo[1])))
        portaluj(3,4)
        RETURN
  ENDIF
  IF ((portal4[0]=(abbo[0]+1)) AND (portal4[1]=(abbo[1])))
        portaluj(4,4)
        RETURN
  ENDIF
  IF ((portal5[0]=(abbo[0]+1)) AND (portal5[1]=(abbo[1])))
        portaluj(5,4)
        RETURN
  ENDIF
  IF ((portal6[0]=(abbo[0]+1)) AND (portal6[1]=(abbo[1])))
        portaluj(6,4)
        RETURN
  ENDIF
  IF ((portal7[0]=(abbo[0]+1)) AND (portal7[1]=(abbo[1])))
        portaluj(7,4)
        RETURN
  ENDIF
  IF ((portal8[0]=(abbo[0]+1)) AND (portal8[1]=(abbo[1])))
        portaluj(8,4)
        RETURN
  ENDIF
 ENDIF
ENDPROC

PROC lewo()
stopChannels(CHAN_LEFT1)
 IF ((getpole(abbo[0]-1,abbo[1])=0) AND (abbo[0]>0))
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picAbboL.bitmap(),0,0,win.rport,
                                        (win.borderleft+((abbo[0]-1)*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
 abbo[0]:=abbo[0]-1
 playData(step,steplen,20000+Rnd(10000),CHAN_LEFT1,64)
 RETURN
 ENDIF
 IF ((getpole(abbo[0]-1,abbo[1])=12) AND (abbo[0]>0))
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picAbboL.bitmap(),0,0,win.rport,
                                        (win.borderleft+((abbo[0]-1)*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
 abbo[0]:=abbo[0]-1
 playData(step,steplen,20000+Rnd(10000),CHAN_LEFT1,64)
 next_level()
 ENDIF
 IF (getpole(abbo[0]-1,abbo[1])=11)
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picAbboL.bitmap(),0,0,win.rport,
                                        (win.borderleft+((abbo[0]-1)*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
 abbo[0]:=abbo[0]-1
 diamenty:=diamenty-1
 stopChannels(CHAN_RIGHT2)
 playData(diam,diamlen,12000,CHAN_RIGHT2,64)
 setpole(abbo[0],abbo[1],0)
 IF diamenty=0 THEN show_exit()
 RETURN
 ENDIF
 IF ((getpole(abbo[0]-1,abbo[1])=10) AND (klucze>=1))
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picAbboL.bitmap(),0,0,win.rport,
                                        (win.borderleft+((abbo[0]-1)*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
 abbo[0]:=abbo[0]-1
 setpole(abbo[0],abbo[1],0)
 klucze:=klucze-1
 stopChannels(CHAN_RIGHT2)
 playData(door,doorlen,17000,CHAN_RIGHT2,64)
 RETURN
 ENDIF
 IF getpole(abbo[0]-1,abbo[1])=9
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picAbboL.bitmap(),0,0,win.rport,
                                        (win.borderleft+((abbo[0]-1)*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
 abbo[0]:=abbo[0]-1
 klucze:=klucze+1
 stopChannels(CHAN_RIGHT2)
 playData(keyF,keyFlen,15500,CHAN_RIGHT2,64)
 setpole(abbo[0],abbo[1],0)
 RETURN
 ENDIF
 IF ((getpole(abbo[0]-1,abbo[1])=2) AND ((abbo[0]-1)<49) AND (getpole(abbo[0]-2,abbo[1])=0))
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picAbboL.bitmap(),0,0,win.rport,
                                        (win.borderleft+((abbo[0]-1)*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picKra.bitmap(),0,0,win.rport,
                                        (win.borderleft+((abbo[0]-2)*12)),(win.bordertop+((abbo[1])*12)),
                                        12,12,
                                        $c0)
 setpole(abbo[0]-1,abbo[1],0)
 setpole(abbo[0]-2,abbo[1],2)
 playData(box,boxlen,9000,CHAN_LEFT1,64)
 abbo[0]:=abbo[0]-1
 ENDIF
 IF ((getpole(abbo[0]-1,abbo[1])=4) AND ((abbo[0]-1)>0) AND (getpole(abbo[0]-2,abbo[1])=0))
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picAbboL.bitmap(),0,0,win.rport,
                                        (win.borderleft+((abbo[0]-1)*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
        BltBitMapRastPort(picKrak.bitmap(),0,0,win.rport,
                                        (win.borderleft+((abbo[0]-2)*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
 setpole(abbo[0]-1,abbo[1],0)
 setpole(abbo[0]-2,abbo[1],4)
 abbo[0]:=abbo[0]-1
 playData(box,boxlen,9000,CHAN_LEFT1,64)
  IF getpole(abbo[0]-2,abbo[1])=0

   IF kratka1[0]<>0
        IF kratka2[0]<>0
         IF kratka3[0]<>0
          kratka4[0]:=4
          kratka4[1]:=abbo[0]-1
          kratka4[2]:=abbo[1]
         ENDIF
     kratka3[0]:=4
         kratka3[1]:=abbo[0]-1
         kratka3[2]:=abbo[1]
        ENDIF
    kratka2[0]:=4
        kratka2[1]:=abbo[0]-1
        kratka2[2]:=abbo[1]
   ENDIF
   kratka1[0]:=4
   kratka1[1]:=abbo[0]-1
   kratka1[2]:=abbo[1]

  ENDIF
 ENDIF
  IF getpole(abbo[0]-1,abbo[1])=5
  IF ((portal1[0]=(abbo[0]-1)) AND (portal1[1]=(abbo[1])))
        portaluj(1,6)
        RETURN
  ENDIF
  IF ((portal2[0]=(abbo[0]-1)) AND (portal2[1]=(abbo[1])))
        portaluj(2,6)
        RETURN
  ENDIF
  IF ((portal3[0]=(abbo[0]-1)) AND (portal3[1]=(abbo[1])))
        portaluj(3,6)
        RETURN
  ENDIF
  IF ((portal4[0]=(abbo[0]-1)) AND (portal4[1]=(abbo[1])))
        portaluj(4,6)
        RETURN
  ENDIF
  IF ((portal5[0]=(abbo[0]-1)) AND (portal5[1]=(abbo[1])))
        portaluj(5,6)
        RETURN
  ENDIF
  IF ((portal6[0]=(abbo[0]-1)) AND (portal6[1]=(abbo[1])))
        portaluj(6,6)
        RETURN
  ENDIF
  IF ((portal7[0]=(abbo[0]-1)) AND (portal7[1]=(abbo[1])))
        portaluj(7,6)
        RETURN
  ENDIF
  IF ((portal8[0]=(abbo[0]-1)) AND (portal8[1]=(abbo[1])))
        portaluj(8,6)
        RETURN
  ENDIF
 ENDIF
ENDPROC

PROC process_record(line)
znak:=0
REPEAT
 IF StrCmp(substr(line,znak+1,1),'1')
  setpole(znak,linia,1)
 ENDIF
 IF StrCmp(substr(line,znak+1,1),'2')
  setpole(znak,linia,2)
 ENDIF
 IF StrCmp(substr(line,znak+1,1),'A')
  abbo[0]:=znak
  abbo[1]:=linia
 ENDIF
 IF StrCmp(substr(line,znak+1,1),'T')
  teleport[0]:=znak
  teleport[1]:=linia
 ENDIF
 IF StrCmp(substr(line,znak+1,1),'M')
  setpole(znak,linia,3)
 ENDIF
 IF StrCmp(substr(line,znak+1,1),'4')
  setpole(znak,linia,4)
 ENDIF
 IF StrCmp(substr(line,znak+1,1),'!')
  setpole(znak,linia,5)
  portal1[0]:=znak
  portal1[1]:=linia
 ENDIF
 IF StrCmp(substr(line,znak+1,1),'@')
  setpole(znak,linia,5)
  portal2[0]:=znak
  portal2[1]:=linia
 ENDIF
 IF StrCmp(substr(line,znak+1,1),'#')
  setpole(znak,linia,5)
  portal3[0]:=znak
  portal3[1]:=linia
 ENDIF
 IF StrCmp(substr(line,znak+1,1),'$')
  setpole(znak,linia,5)
  portal4[0]:=znak
  portal4[1]:=linia
 ENDIF
 IF StrCmp(substr(line,znak+1,1),'%')
  setpole(znak,linia,5)
  portal5[0]:=znak
  portal5[1]:=linia
 ENDIF
 IF StrCmp(substr(line,znak+1,1),'^')
  setpole(znak,linia,5)
  portal6[0]:=znak
  portal6[1]:=linia
 ENDIF
 IF StrCmp(substr(line,znak+1,1),'&')
  setpole(znak,linia,5)
  portal7[0]:=znak
  portal7[1]:=linia
 ENDIF
 IF StrCmp(substr(line,znak+1,1),'*')
  setpole(znak,linia,5)
  portal8[0]:=znak
  portal8[1]:=linia
 ENDIF
 IF StrCmp(substr(line,znak+1,1),'<')
  IF cannon1[0]<>0
   IF cannon2[0]<>0
    IF cannon3[0]<>0
     cannon4[0]:=1
         cannon4[1]:=znak
         cannon4[2]:=linia
        ELSE
     cannon3[0]:=1
         cannon3[1]:=znak
         cannon3[2]:=linia
        ENDIF
   ELSE
    cannon2[0]:=1
        cannon2[1]:=znak
        cannon2[2]:=linia
   ENDIF
  ELSE
   cannon1[0]:=1
   cannon1[1]:=znak
   cannon1[2]:=linia
  ENDIF
  setpole(znak,linia,6)
 ENDIF
 IF StrCmp(substr(line,znak+1,1),'>')
  IF cannon1[0]<>0
   IF cannon2[0]<>0
    IF cannon3[0]<>0
     cannon4[0]:=2
         cannon4[1]:=znak
         cannon4[2]:=linia
        ELSE
     cannon3[0]:=2
         cannon3[1]:=znak
         cannon3[2]:=linia
        ENDIF
   ELSE
    cannon2[0]:=2
        cannon2[1]:=znak
        cannon2[2]:=linia
   ENDIF
  ELSE
   cannon1[0]:=2
   cannon1[1]:=znak
   cannon1[2]:=linia
  ENDIF
  setpole(znak,linia,7)
 ENDIF
 IF StrCmp(substr(line,znak+1,1),'°')
  setpole(znak,linia,8)
  IF monster1[0]<>0
   IF monster2[0]<>0
    IF monster3[0]<>0
     monster4[0]:=1
         monster4[1]:=znak
         monster4[2]:=linia
         monster4[3]:=2
        ELSE
     monster3[0]:=1
         monster3[1]:=znak
         monster3[2]:=linia
         monster3[3]:=2
        ENDIF
   ELSE
    monster2[0]:=1
        monster2[1]:=znak
        monster2[2]:=linia
        monster2[3]:=2
   ENDIF
  ELSE
   monster1[0]:=1
   monster1[1]:=znak
   monster1[2]:=linia
   monster1[3]:=2
  ENDIF
 ENDIF
 IF StrCmp(substr(line,znak+1,1),'o')
  setpole(znak,linia,8)
  IF monster1[0]<>0
   IF monster2[0]<>0
    IF monster3[0]<>0
     monster4[0]:=2
         monster4[1]:=znak
         monster4[2]:=linia
         monster4[3]:=2
        ELSE
     monster3[0]:=2
         monster3[1]:=znak
         monster3[2]:=linia
         monster3[3]:=2
        ENDIF
   ELSE
    monster2[0]:=2
        monster2[1]:=znak
        monster2[2]:=linia
        monster2[3]:=2
   ENDIF
  ELSE
   monster1[0]:=2
   monster1[1]:=znak
   monster1[2]:=linia
   monster1[3]:=2
  ENDIF
 ENDIF
 IF StrCmp(substr(line,znak+1,1),'K')
  setpole(znak,linia,9)
 ENDIF
 IF StrCmp(substr(line,znak+1,1),'D')
  setpole(znak,linia,10)
 ENDIF
 IF StrCmp(substr(line,znak+1,1),'d')
  setpole(znak,linia,11)
 ENDIF
 znak:=znak+1
UNTIL znak=50
linia:=linia+1
ENDPROC

PROC check_mag()
DEF i,j,ruch=TRUE

 FOR i:=0 TO 49
  IF (getpole(i,abbo[1])=3)
   IF i>abbo[0]                              -> LEWO
        IF (i-abbo[0])=1 THEN koniec()
    FOR j:=abbo[0]+1 TO i-1
         IF getpole(j,abbo[1])<>0 THEN RETURN
        ENDFOR
         prawo()
         Delay(5)
         check_mag()
   ENDIF
   IF i<abbo[0]                              -> PRAWO
        IF (i-abbo[0])=-1 THEN koniec()
    FOR j:=i+1 TO abbo[0]-1
         IF getpole(j,abbo[1])<>0
          ruch:=FALSE
          RETURN
         ENDIF
        ENDFOR
        IF ruch=TRUE
         lewo()
         Delay(5)
         check_mag()
        ENDIF
   ENDIF
  ENDIF
 ENDFOR

ENDPROC

PROC quit()

    stopChannels(CHAN_LEFT1+CHAN_RIGHT1+CHAN_LEFT2+CHAN_RIGHT2)

    IF win THEN CloseWindow(win)
    IF winb THEN CloseWindow(winb)

    IF picWall
        picWall.clear()             -> Unload Grafiks
        END picWall
        picAbboD1.clear()
        END picAbboD1
        picAbboD2.clear()
        END picAbboD2
        picAbboP.clear()
        END picAbboP
        picAbboL.clear()
        END picAbboL
        picAbboG.clear()
        END picAbboG
        picKra.clear()
        END picKra
        picTele.clear()
        END picTele
        picMag.clear()
        END picMag
        picKrak.clear()
        END picKrak
        picTlo.clear()
        END picTlo
        picPort.clear()
        END picPort
        picEkr.clear()
        END picEkr
        picChm.clear()
        END picChm
        picDzP.clear()
        END picDzP
        picDzL.clear()
        END picDzL
        picF1.clear()
        END picF1
        picF2.clear()
        END picF1
        picM1.clear()
        END picM1
        picM2.clear()
        END picM2
        picKey.clear()
        END picKey
        picDoor.clear()
        END picDoor
        picDia.clear()
        END picDia
    ENDIF
    IF step THEN Dispose(step)       -> Unload Sounds
    IF diam THEN Dispose(diam)
    IF door THEN Dispose(door)
    IF keyF THEN Dispose(keyF)
    IF box THEN Dispose(box)
    IF portalS THEN Dispose(portalS)
    IF cannonS THEN Dispose(cannonS)
    IF showS THEN Dispose(showS)
    IF event THEN Dispose(event)

    IF fr THEN FreeAslRequest(fr)

    IF scr THEN CloseScreen(scr)

    IF lowlevelbase THEN CloseLibrary(lowlevelbase)
    IF aslbase THEN CloseLibrary(aslbase)

    CleanUp(0)

ENDPROC

PROC select_screen()

    fr:=AllocAslRequest(ASL_SCREENMODEREQUEST, [ASLSM_TITLETEXT,'Select 640x480x8 ScreenMode:',
                                                NIL,NIL])
    IF AslRequest(fr,0)
        IF (scr:=OpenScreenTagList(NIL, [SA_DISPLAYID, fr.displayid,
                                         SA_TITLE, 'Abbo Screen',
                                         SA_DEPTH, 8,
                                         SA_WIDTH, 640,
                                         SA_HEIGHT, 480,
                                         SA_PENS,[-1]:INT,
                                         SA_OVERSCAN, OSCAN_STANDARD,
                                         SA_AUTOSCROLL, TRUE,
                                         SA_SYSFONT, 0,
                                         SA_SHOWTITLE, TRUE,
                                         -> SA_QUIET, TRUE,
                                         SA_PUBNAME, 'Abbo Screen',
                                         NIL, NIL]))=NIL

            WriteF('Could not open Screen!\n')
            quit()

        ENDIF
    ELSE
        IF fr THEN FreeAslRequest(fr)       -> Abbruch -> Ende (Quit)
        WriteF('Good Bye...\n')
        quit()

    ENDIF

ENDPROC

PROC portaluj(p,k)
 IF k=2
  IF p=1
   IF getpole(portal2[0],portal2[1]-1)=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal2[0]
    abbo[1]:=portal2[1]-1
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(8)
        check_mag()
   ENDIF
  ENDIF
  IF p=2
   IF getpole(portal1[0],portal1[1]-1)=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal1[0]
    abbo[1]:=portal1[1]-1
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(8)
        check_mag()
   ENDIF
  ENDIF
  IF p=3
   IF getpole(portal4[0],portal4[1]-1)=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal4[0]
    abbo[1]:=portal4[1]-1
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(8)
        check_mag()
   ENDIF
  ENDIF
  IF p=4
   IF getpole(portal3[0],portal3[1]-1)=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal3[0]
    abbo[1]:=portal3[1]-1
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(8)
        check_mag()
   ENDIF
  ENDIF
  IF p=5
   IF getpole(portal6[0],portal6[1]-1)=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal6[0]
    abbo[1]:=portal6[1]-1
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(8)
        check_mag()
   ENDIF
  ENDIF
  IF p=6
   IF getpole(portal5[0],portal5[1]-1)=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal5[0]
    abbo[1]:=portal5[1]-1
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(8)
        check_mag()
   ENDIF
  ENDIF
  IF p=7
   IF getpole(portal8[0],portal8[1]-1)=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal8[0]
    abbo[1]:=portal8[1]-1
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(8)
        check_mag()
   ENDIF
  ENDIF
  IF p=8
   IF getpole(portal7[0],portal7[1]-1)=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal7[0]
    abbo[1]:=portal7[1]-1
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(8)
        check_mag()
   ENDIF
  ENDIF
 ENDIF
 IF k=8
  IF p=1
   IF getpole(portal2[0],portal2[1]-1)=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal2[0]
    abbo[1]:=portal2[1]+1
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(2)
        check_mag()
   ENDIF
  ENDIF
  IF p=2
   IF getpole(portal1[0],portal1[1]+1)=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal1[0]
    abbo[1]:=portal1[1]+1
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(2)
        check_mag()
   ENDIF
  ENDIF
  IF p=3
   IF getpole(portal4[0],portal4[1]+1)=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal4[0]
    abbo[1]:=portal4[1]+1
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(2)
        check_mag()
   ENDIF
  ENDIF
  IF p=4
   IF getpole(portal3[0],portal3[1]+1)=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal3[0]
    abbo[1]:=portal3[1]+1
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(2)
        check_mag()
   ENDIF
  ENDIF
  IF p=5
   IF getpole(portal6[0],portal6[1]+1)=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal6[0]
    abbo[1]:=portal6[1]+1
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(2)
        check_mag()
   ENDIF
  ENDIF
  IF p=6
   IF getpole(portal5[0],portal5[1]+1)=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal5[0]
    abbo[1]:=portal5[1]+1
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(2)
        check_mag()
   ENDIF
  ENDIF
  IF p=7
   IF getpole(portal8[0],portal8[1]+1)=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal8[0]
    abbo[1]:=portal8[1]+1
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(2)
        check_mag()
   ENDIF
  ENDIF
  IF p=8
   IF getpole(portal7[0],portal7[1]+1)=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal7[0]
    abbo[1]:=portal7[1]+1
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(2)
        check_mag()
   ENDIF
  ENDIF
 ENDIF
 IF k=4
  IF p=1
   IF getpole(portal2[0]+1,portal2[1])=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal2[0]+1
    abbo[1]:=portal2[1]
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(6)
        check_mag()
   ENDIF
  ENDIF
  IF p=2
   IF getpole(portal1[0]+1,portal1[1])=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal1[0]+1
    abbo[1]:=portal1[1]
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(6)
        check_mag()
   ENDIF
  ENDIF
  IF p=3
   IF getpole(portal4[0]+1,portal4[1])=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal4[0]+1
    abbo[1]:=portal4[1]
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(6)
        check_mag()
   ENDIF
  ENDIF
  IF p=4
   IF getpole(portal3[0]+1,portal3[1])=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal3[0]+1
    abbo[1]:=portal3[1]
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(6)
        check_mag()
   ENDIF
  ENDIF
  IF p=5
   IF getpole(portal6[0]+1,portal6[1])=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal6[0]+1
    abbo[1]:=portal6[1]
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(6)
        check_mag()
   ENDIF
  ENDIF
  IF p=6
   IF getpole(portal5[0]+1,portal5[1])=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal5[0]+1
    abbo[1]:=portal5[1]
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(6)
        check_mag()
   ENDIF
  ENDIF
  IF p=7
   IF getpole(portal8[0]+1,portal8[1])=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal8[0]+1
    abbo[1]:=portal8[1]
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(6)
        check_mag()
   ENDIF
  ENDIF
  IF p=8
   IF getpole(portal7[0]+1,portal7[1])=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal7[0]+1
    abbo[1]:=portal7[1]
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(6)
        check_mag()
   ENDIF
  ENDIF
 ENDIF
 IF k=6
  IF p=1
   IF getpole(portal2[0]-1,portal2[1])=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal2[0]-1
    abbo[1]:=portal2[1]
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(4)
        check_mag()
   ENDIF
  ENDIF
  IF p=2
   IF getpole(portal1[0]-1,portal1[1])=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal1[0]-1
    abbo[1]:=portal1[1]
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(4)
        check_mag()
   ENDIF
  ENDIF
  IF p=3
   IF getpole(portal4[0]-1,portal4[1])=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal4[0]-1
    abbo[1]:=portal4[1]
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(4)
        check_mag()
   ENDIF
  ENDIF
  IF p=4
   IF getpole(portal3[0]-1,portal3[1])=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal3[0]-1
    abbo[1]:=portal3[1]
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(4)
        check_mag()
   ENDIF
  ENDIF
  IF p=5
   IF getpole(portal6[0]-1,portal6[1])=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal6[0]-1
    abbo[1]:=portal6[1]
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(4)
        check_mag()
   ENDIF
  ENDIF
  IF p=6
   IF getpole(portal5[0]-1,portal5[1])=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal5[0]-1
    abbo[1]:=portal5[1]
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(4)
        check_mag()
   ENDIF
  ENDIF
  IF p=7
   IF getpole(portal8[0]-1,portal8[1])=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal8[0]-1
    abbo[1]:=portal8[1]
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(4)
        check_mag()
   ENDIF
  ENDIF
  IF p=8
   IF getpole(portal7[0]-1,portal7[1])=0
        stopChannels(CHAN_RIGHT2)
        playData(portalS,portalSlen,16500,CHAN_RIGHT2,64)
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboClr()
    abbo[0]:=portal7[0]-1
    abbo[1]:=portal7[1]
        blitChm(abbo[0],abbo[1])
        Delay(1)
    abboBlt(4)
        check_mag()
   ENDIF
  ENDIF
 ENDIF
ENDPROC

PROC abboBlt(k)
        BltBitMapRastPort(IF k=8 THEN picAbboG.bitmap() ELSE IF k=2 THEN picAbboD1.bitmap() ELSE IF k=4 THEN picAbboL.bitmap() ELSE picAbboP.bitmap(),
                                                                                0,0,win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
ENDPROC

PROC abboClr()
        BltBitMapRastPort(picTlo.bitmap(),((abbo[0]*12)),((abbo[1]*12)),win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)
ENDPROC

PROC blitChm(ox,oy)
        BltBitMapRastPort(picChm.bitmap(),0,0,win.rport,
                                        (win.borderleft+(ox*12)),(win.bordertop+(oy*12)),
                                        12,12,
                                        $c0)
ENDPROC

PROC show_exit()
        BltBitMapRastPort(picTele.bitmap(),0,0,win.rport,
                                        (win.borderleft+(teleport[0]*12)),(win.bordertop+(teleport[1]*12)),
                                        12,12,
                                        $c0)
        playData(showS,showSlen,16700,CHAN_LEFT2,64)
        setpole(teleport[0],teleport[1],12)
ENDPROC

PROC init()                             -> Init Level

    stopChannels(CHAN_LEFT1+CHAN_RIGHT1+CHAN_LEFT2+CHAN_RIGHT2)
    FOR i:=0 TO 49
        FOR j:=0 TO 29
            setpole(i,j,0)
        ENDFOR
    ENDFOR
    klucze:=0
    diamenty:=4
    kratka1[0]:=0
    kratka1[1]:=0
    kratka1[2]:=0
    kratka2[0]:=0
    kratka2[1]:=0
    kratka2[2]:=0
    kratka3[0]:=0
    kratka3[1]:=0
    kratka3[2]:=0
    kratka4[0]:=0
    kratka4[1]:=0
    kratka4[2]:=0
    portal1[0]:=0
    portal1[1]:=0
    portal2[0]:=0
    portal2[1]:=0
    portal3[0]:=0
    portal3[1]:=0
    portal4[0]:=0
    portal4[1]:=0
    portal5[0]:=0
    portal5[1]:=0
    portal6[0]:=0
    portal6[1]:=0
    portal7[0]:=0
    portal7[1]:=0
    portal8[0]:=0
    portal8[1]:=0
    cannon1[0]:=0
    cannon1[1]:=0
    cannon1[2]:=0
    cannon1[3]:=0
    cannon2[0]:=0
    cannon2[1]:=0
    cannon2[2]:=0
    cannon2[3]:=0
    cannon3[0]:=0
    cannon3[1]:=0
    cannon3[2]:=0
    cannon3[3]:=0
    cannon4[0]:=0
    cannon4[1]:=0
    cannon4[2]:=0
    cannon4[3]:=0
    monster1[0]:=0
    monster1[1]:=0
    monster1[2]:=0
    monster1[3]:=0
    monster2[0]:=0
    monster2[1]:=0
    monster2[2]:=0
    monster2[3]:=0
    monster3[0]:=0
    monster3[1]:=0
    monster3[2]:=0
    monster3[3]:=0
    monster4[0]:=0
    monster4[1]:=0
    monster4[2]:=0
    monster4[3]:=0
    linia:=0
    loadlevel()
        BltBitMapRastPort(picTlo.bitmap(),0,0,win.rport,
                                        (win.borderleft),(win.bordertop),
                                        600,360,
                                        $c0)

 FOR i:=0 TO 49
   FOR j:=0 TO 29
   temp:=getpole(i,j)
   IF temp=1
        BltBitMapRastPort(picWall.bitmap(),0,0,win.rport,
                                        (win.borderleft+(i*12)),(win.bordertop+(j*12)),
                                        12,12,
                                        $c0)
   ENDIF
   IF temp=2
        BltBitMapRastPort(picKra.bitmap(),0,0,win.rport,
                                        (win.borderleft+(i*12)),(win.bordertop+(j*12)),
                                        12,12,
                                        $c0)
   ENDIF
   IF temp=3
        BltBitMapRastPort(picMag.bitmap(),0,0,win.rport,
                                        (win.borderleft+(i*12)),(win.bordertop+(j*12)),
                                        12,12,
                                        $c0)
   ENDIF
   IF temp=4
        BltBitMapRastPort(picKrak.bitmap(),0,0,win.rport,
                                        (win.borderleft+(i*12)),(win.bordertop+(j*12)),
                                        12,12,
                                        $c0)
   ENDIF
   IF temp=5
        BltBitMapRastPort(picPort.bitmap(),0,0,win.rport,
                                        (win.borderleft+(i*12)),(win.bordertop+(j*12)),
                                        12,12,
                                        $c0)
   ENDIF
   IF temp=6
        BltBitMapRastPort(picDzL.bitmap(),0,0,win.rport,
                                        (win.borderleft+(i*12)),(win.bordertop+(j*12)),
                                        12,12,
                                        $c0)
   ENDIF
   IF temp=7
        BltBitMapRastPort(picDzP.bitmap(),0,0,win.rport,
                                        (win.borderleft+(i*12)),(win.bordertop+(j*12)),
                                        12,12,
                                        $c0)
   ENDIF
   IF temp=9
        BltBitMapRastPort(picKey.bitmap(),0,0,win.rport,
                                        (win.borderleft+(i*12)),(win.bordertop+(j*12)),
                                        12,12,
                                        $c0)
   ENDIF
   IF temp=10
        BltBitMapRastPort(picDoor.bitmap(),0,0,win.rport,
                                        (win.borderleft+(i*12)),(win.bordertop+(j*12)),
                                        12,12,
                                        $c0)
   ENDIF
   IF temp=11
        BltBitMapRastPort(picDia.bitmap(),0,0,win.rport,
                                        (win.borderleft+(i*12)),(win.bordertop+(j*12)),
                                        12,12,
                                        $c0)
   ENDIF
  ENDFOR
 ENDFOR

        BltBitMapRastPort(picAbboD1.bitmap(),0,0,win.rport,
                                        (win.borderleft+(abbo[0]*12)),(win.bordertop+(abbo[1]*12)),
                                        12,12,
                                        $c0)

        playData(event,eventlen,20050,CHAN_RIGHT2+CHAN_LEFT2,32)

ENDPROC

PROC koniec()

    stopChannels(CHAN_LEFT1+CHAN_RIGHT1+CHAN_LEFT2+CHAN_RIGHT2)
    ReplyMsg(imsg)
    init()
    mainproc()

ENDPROC


PROC start()
DEF liczba

    stopChannels(CHAN_LEFT1+CHAN_RIGHT1+CHAN_LEFT2+CHAN_RIGHT2)

    IF oldlevel>9
        picTlo.clear()
        picTlo.dtload('gfx/bkg1.iff')
        picTlo.paltoscr(scr)
    ENDIF

    init()
    class:=0
    key:=0

    LOOP

        IF ((key<>$4C) AND (key<>$4D) AND (key<>$4E) AND (key<>$4F) AND (key<>$10)) THEN key:=GetKey()
        IF key=$10 THEN quit()   -> Taste "Q" oder "Esc" Ende
        IF key=$45 THEN quit()

        IF imsg:=GetMsg(win.userport)
                class:=imsg.class

                                IF class=IDCMP_INTUITICKS

                                        exitLoop(CHAN_LEFT1+CHAN_LEFT2+CHAN_RIGHT1+CHAN_RIGHT2)

                                        FOR i:=249 TO 254
                                                SetColour(scr,i,1+Rnd(254),1+Rnd(254),1+Rnd(254))
                                        ENDFOR

                                        IF GetKey()=$10    -> Taste "Q"
                                           quit()
                                           key:=0
                                        ENDIF

                                                        key:=GetKey()
                                                        IF key=77
                                                                IF ((abbo[0]=23) AND (abbo[1]=14)) THEN SetWindowTitles(win,0,'About Abbo')
                                                                IF ((abbo[0]=6) AND (abbo[1]=14)) THEN SetWindowTitles(win,0,'Start Game')
                                                                IF ((abbo[0]=38) AND (abbo[1]=14)) THEN SetWindowTitles(win,0,'Quit Program')
                                                                dol()
                                                                IF ((abbo[0]=23) AND (abbo[1]=23))
                                                                abboClr()
                                                                abbo[1]:=abbo[1]-1
                                                                stopChannels(CHAN_LEFT1+CHAN_RIGHT1+CHAN_LEFT2+CHAN_RIGHT2)
                                                                NEW rt.reqtooller()
                                                                    rt.setattrs([RT_TITLE, 'About Abbo', RT_WIN,winb,NIL, NIL])
                                                                    rt.req(RTREQ_EASY, [RT_TEXT,'ABBO written in E by Jakub Madej and sun68\nCompilation date: xx.xx.xxxx xx:xx\n--\nThis version of Abbo is Work in Progress (WIP),\nbut it has not got any limitations.\nHowever you can register it by sending me\nan e-mail (your name is required) with\nsome kind of gift (it can be a picture\nsound module or whatever you want).\nYou can also give me text which will\nappear in this window.',RT_GADS,'O.K.',NIL, NIL])
                                                                END rt
                                                                abboBlt(8)
                                                                ENDIF
                                                        ENDIF
                                                        IF key=76
                                                                IF ((abbo[0]=23) AND (abbo[1]=15)) THEN SetWindowTitles(win,0,{version})    ->'Abbo 0.3 by Jakub Madej and sun68')
                                                                IF ((abbo[0]=6) AND (abbo[1]=15)) THEN SetWindowTitles(win,0,{version})     ->'Abbo 0.3 by Jakub Madej and sun68')
                                                                IF ((abbo[0]=38) AND (abbo[1]=15)) THEN SetWindowTitles(win,0,{version})    ->'Abbo 0.3 by Jakub Madej and sun68')
                                                                gora()
                                                        ENDIF
                                                        IF key=79
                                                                lewo()
                                                                IF ((abbo[0]=3) AND (abbo[1]=24))
                                                                abboClr()
                                                                abbo[0]:=abbo[0]+2
                                                                stopChannels(CHAN_LEFT1+CHAN_RIGHT1+CHAN_LEFT2+CHAN_RIGHT2)
                                                                NEW rt.reqtooller()
                                                                    rt.setattrs([RT_TITLE, 'Abbo request', RT_WIN,winb, NIL, NIL])
                                                                    liczba:=rt.req(RTREQ_NUMBER, [RT_MINVAL, 1, RT_MAXVAL, 50, RT_DEFVAL, 1, RT_TEXT, 'Select start level:', RT_GADS, 'Cancel', NIL, NIL])
                                                                    IF liczba<>0
                                                                        level:=rt.get(RT_NUM)
                                                                        oldlevel:=0
                                                                        ReplyMsg(imsg)
                                                                        init()
                                                                        mainproc()
                                                                    ENDIF
                                                                END rt
                                                                abboBlt(4)
                                                                ENDIF
                                                        ENDIF
                                                        IF key=78
                                                                prawo()
                                                                IF ((abbo[0]=46) AND (abbo[1]=24))
                                                                abboClr()
                                                                abbo[0]:=abbo[0]-1
                                                                stopChannels(CHAN_LEFT1+CHAN_RIGHT1+CHAN_LEFT2+CHAN_RIGHT2)
                                                                NEW rt.reqtooller()
                                                                    rt.setattrs([RT_TITLE, 'Abbo request', RT_WIN, winb, NIL, NIL])
                                                                    IF rt.req(RTREQ_EASY, [RT_TEXT, 'Do you really want to quit Abbo ?', RT_GADS, 'Not today|Sure', NIL, NIL])=0 THEN quit()
                                                                END rt
                                                                abboBlt(4)
                                                                ENDIF
                                                        ENDIF
                                                        IF key=16 THEN koniec()
                                                        oldkey:=key
                                                        key:=0

                                IF ((getpole(abbo[0]-1,abbo[1])=8) OR (getpole(abbo[0]+1,abbo[1])=8) OR (getpole(abbo[0],abbo[1]-1)=8) OR (getpole(abbo[0],abbo[1]+1)=8)) THEN koniec()
                                Delay(2)
                                ENDIF

                ReplyMsg(imsg)
                code:=0
        ENDIF

    ->UNTIL class=IDCMP_CLOSEWINDOW
    ENDLOOP

ENDPROC

PROC loadlevel()

DEF sznurek[50]:STRING,sz_pomoc[100]:STRING,pomoc

 SELECT level
   CASE 0
     levels:='levels/main'

   CASE 1
     levels:='levels/level1'
     IF oldlevel>9
       picTlo.clear()
       picTlo.dtload('gfx/bkg1.iff')
     ENDIF

   CASE 2
     levels:='levels/level2'
     IF oldlevel>9
       picTlo.clear()
       picTlo.dtload('gfx/bkg1.iff')
     ENDIF

   CASE 3
     levels:='levels/level3'
     IF oldlevel>9
       picTlo.clear()
       picTlo.dtload('gfx/bkg1.iff')
     ENDIF

   CASE 4
     levels:='levels/level4'
     IF oldlevel>9
       picTlo.clear()
       picTlo.dtload('gfx/bkg1.iff')
     ENDIF

   CASE 5
     levels:='levels/level5'
     IF oldlevel>9
       picTlo.clear()
       picTlo.dtload('gfx/bkg1.iff')
     ENDIF

   CASE 6
     levels:='levels/level6'
     IF oldlevel>9
       picTlo.clear()
       picTlo.dtload('gfx/bkg1.iff')
     ENDIF

   CASE 7
     levels:='levels/level7'
     IF oldlevel>9
       picTlo.clear()
       picTlo.dtload('gfx/bkg1.iff')
     ENDIF

   CASE 8
     levels:='levels/level8'
     IF oldlevel>9
       picTlo.clear()
       picTlo.dtload('gfx/bkg1.iff')
     ENDIF

   CASE 9
     levels:='levels/level9'
     IF oldlevel>9
       picTlo.clear()
       picTlo.dtload('gfx/bkg1.iff')
     ENDIF

   CASE 10
     levels:='levels/level10'
     IF ((oldlevel>19) OR (oldlevel<10))
       picTlo.clear()
       picTlo.dtload('gfx/bkg2.iff')
     ENDIF

   CASE 11
     levels:='levels/level11'
     IF ((oldlevel>19) OR (oldlevel<10))
       picTlo.clear()
       picTlo.dtload('gfx/bkg2.iff')
     ENDIF

   CASE 12
     levels:='levels/level12'
     IF ((oldlevel>19) OR (oldlevel<10))
       picTlo.clear()
       picTlo.dtload('gfx/bkg2.iff')
     ENDIF

   CASE 13
     levels:='levels/level13'
     IF ((oldlevel>19) OR (oldlevel<10))
       picTlo.clear()
       picTlo.dtload('gfx/bkg2.iff')
     ENDIF

   CASE 14
     levels:='levels/level14'
     IF ((oldlevel>19) OR (oldlevel<10))
       picTlo.clear()
       picTlo.dtload('gfx/bkg2.iff')
     ENDIF

   CASE 15
     levels:='levels/level15'
     IF ((oldlevel>19) OR (oldlevel<10))
       picTlo.clear()
       picTlo.dtload('gfx/bkg2.iff')
     ENDIF

   CASE 16
     levels:='levels/level16'
     IF ((oldlevel>19) OR (oldlevel<10))
       picTlo.clear()
       picTlo.dtload('gfx/bkg2.iff')
     ENDIF

   CASE 17
     levels:='levels/level17'
     IF ((oldlevel>19) OR (oldlevel<10))
       picTlo.clear()
       picTlo.dtload('gfx/bkg2.iff')
     ENDIF

   CASE 18
     levels:='levels/level18'
     IF ((oldlevel>19) OR (oldlevel<10))
       picTlo.clear()
       picTlo.dtload('gfx/bkg2.iff')
     ENDIF

   CASE 19
     levels:='levels/level19'
     IF ((oldlevel>19) OR (oldlevel<10))
       picTlo.clear()
       picTlo.dtload('gfx/bkg2.iff')
     ENDIF

   CASE 20
     levels:='levels/level20'
     IF ((oldlevel>29) OR (oldlevel<20))
       picTlo.clear()
       picTlo.dtload('gfx/bkg3.iff')
     ENDIF

   CASE 21
     levels:='levels/level21'
     IF ((oldlevel>29) OR (oldlevel<20))
       picTlo.clear()
       picTlo.dtload('gfx/bkg3.iff')
     ENDIF

   CASE 22
     levels:='levels/level22'
     IF ((oldlevel>29) OR (oldlevel<20))
       picTlo.clear()
       picTlo.dtload('gfx/bkg3.iff')
     ENDIF

   CASE 23
     levels:='levels/level23'
     IF ((oldlevel>29) OR (oldlevel<20))
       picTlo.clear()
       picTlo.dtload('gfx/bkg3.iff')
     ENDIF

   CASE 24
     levels:='levels/level24'
     IF ((oldlevel>29) OR (oldlevel<20))
       picTlo.clear()
       picTlo.dtload('gfx/bkg3.iff')
     ENDIF

   CASE 25
     levels:='levels/level25'
     IF ((oldlevel>29) OR (oldlevel<20))
       picTlo.clear()
       picTlo.dtload('gfx/bkg3.iff')
     ENDIF

   CASE 26
     levels:='levels/level26'
     IF ((oldlevel>29) OR (oldlevel<20))
       picTlo.clear()
       picTlo.dtload('gfx/bkg3.iff')
     ENDIF

   CASE 27
     levels:='levels/level27'
     IF ((oldlevel>29) OR (oldlevel<20))
       picTlo.clear()
       picTlo.dtload('gfx/bkg3.iff')
     ENDIF

   CASE 28
     levels:='levels/level28'
     IF ((oldlevel>29) OR (oldlevel<20))
       picTlo.clear()
       picTlo.dtload('gfx/bkg3.iff')
     ENDIF

   CASE 29
     levels:='levels/level29'
     IF ((oldlevel>29) OR (oldlevel<20))
       picTlo.clear()
       picTlo.dtload('gfx/bkg3.iff')
     ENDIF

   CASE 30
     levels:='levels/level30'
     IF ((oldlevel>39) OR (oldlevel<30))
       picTlo.clear()
       picTlo.dtload('gfx/bkg4.iff')
     ENDIF

   CASE 31
     levels:='levels/level31'
     IF ((oldlevel>39) OR (oldlevel<30))
       picTlo.clear()
       picTlo.dtload('gfx/bkg4.iff')
     ENDIF

   CASE 32
     levels:='levels/level32'
     IF ((oldlevel>39) OR (oldlevel<30))
       picTlo.clear()
       picTlo.dtload('gfx/bkg4.iff')
     ENDIF

   CASE 33
     levels:='levels/level33'
     IF ((oldlevel>39) OR (oldlevel<30))
       picTlo.clear()
       picTlo.dtload('gfx/bkg4.iff')
     ENDIF

   CASE 34
     levels:='levels/level34'
     IF ((oldlevel>39) OR (oldlevel<30))
       picTlo.clear()
       picTlo.dtload('gfx/bkg4.iff')
     ENDIF

   CASE 35
     levels:='levels/level35'
     IF ((oldlevel>39) OR (oldlevel<30))
       picTlo.clear()
       picTlo.dtload('gfx/bkg4.iff')
     ENDIF

   CASE 36
     levels:='levels/level36'
     IF ((oldlevel>39) OR (oldlevel<30))
       picTlo.clear()
       picTlo.dtload('gfx/bkg4.iff')
     ENDIF

   CASE 37
     levels:='levels/level37'
     IF ((oldlevel>39) OR (oldlevel<30))
       picTlo.clear()
       picTlo.dtload('gfx/bkg4.iff')
     ENDIF

   CASE 38
     levels:='levels/level38'
     IF ((oldlevel>39) OR (oldlevel<30))
       picTlo.clear()
       picTlo.dtload('gfx/bkg4.iff')
     ENDIF

   CASE 39
     levels:='levels/level39'
     IF ((oldlevel>39) OR (oldlevel<30))
       picTlo.clear()
       picTlo.dtload('gfx/bkg4.iff')
     ENDIF

   CASE 40
     levels:='levels/level40'
     IF oldlevel<40
       picTlo.clear()
       picTlo.dtload('gfx/bkg5.iff')
     ENDIF

   CASE 41
     levels:='levels/level41'
     IF oldlevel<40
       picTlo.clear()
       picTlo.dtload('gfx/bkg5.iff')
     ENDIF

   CASE 42
     levels:='levels/level42'
     IF oldlevel<40
       picTlo.clear()
       picTlo.dtload('gfx/bkg5.iff')
     ENDIF

   CASE 43
     levels:='levels/level43'
     IF oldlevel<40
       picTlo.clear()
       picTlo.dtload('gfx/bkg5.iff')
     ENDIF

   CASE 44
     levels:='levels/level44'
     IF oldlevel<40
       picTlo.clear()
       picTlo.dtload('gfx/bkg5.iff')
     ENDIF

   CASE 45
     levels:='levels/level45'
     IF oldlevel<40
       picTlo.clear()
       picTlo.dtload('gfx/bkg5.iff')
     ENDIF

   CASE 46
     levels:='levels/level46'
     IF oldlevel<40
       picTlo.clear()
       picTlo.dtload('gfx/bkg5.iff')
     ENDIF

   CASE 47
     levels:='levels/level47'
     IF oldlevel<40
       picTlo.clear()
       picTlo.dtload('gfx/bkg5.iff')
     ENDIF

   CASE 48
     levels:='levels/level48'
     IF oldlevel<40
       picTlo.clear()
       picTlo.dtload('gfx/bkg5.iff')
     ENDIF

   CASE 49
     levels:='levels/level49'
     IF oldlevel<40
       picTlo.clear()
       picTlo.dtload('gfx/bkg5.iff')
     ENDIF

   CASE 50
     levels:='levels/level50'
     IF oldlevel<40
       picTlo.clear()
       picTlo.dtload('gfx/bkg5.iff')
     ENDIF
 ENDSELECT

 oldlevel:=level
 picTlo.paltoscr(scr)

 IF filehandle:=Open(levels, OLDFILE)
    REPEAT
        status:=ReadStr(filehandle, buffer)
        IF buffer[] OR (status<>-1) THEN process_record(buffer)
    UNTIL status=-1
    Close(filehandle)
 ENDIF
 StrCopy(sznurek,'Level ',ALL)
 StrCopy(sz_pomoc,levels,ALL)
 IF level<10
  RightStr(sz_pomoc,sz_pomoc,1)
  pomoc:=sz_pomoc
 ELSE
  RightStr(sz_pomoc,sz_pomoc,2)
  pomoc:=sz_pomoc
 ENDIF
 StrAdd(sznurek,pomoc,ALL)
 IF ((level>0) AND (level<51))
  SetWindowTitles(win,0,sznurek)
  RETURN
 ENDIF
 SetWindowTitles(win,0,{version})   ->'Abbo 0.3 by Jakub Madej and sun68')

ENDPROC

PROC next_level()

    stopChannels(CHAN_LEFT1+CHAN_RIGHT1+CHAN_LEFT2+CHAN_RIGHT2)
    ReplyMsg(imsg)
    ->oldlevel:=level
    level:=level+1
    init()
    mainproc()

ENDPROC

version:
    CHAR '$VER: Abbo 0.40 (18.07.2012) by Jakub Madej and sun68',0
