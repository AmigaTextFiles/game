OPT LARGE

MODULE 'amigalib/ports',
       'amigalib/io',                                       
       'devices/gameport',
       'devices/inputevent',
       'devices/timer',
       'devices/audio',
       'exec/execbase',
       'exec/io',
       'exec/nodes',
       'exec/ports',
       'exec/memory',
       'exec/devices',
       'graphics/view',
       'intuition/intuition',
       'intuition/screens',
       'gadtools',
       'eaudio',
       'graphics/text',
       'libraries/gadtools',
       'intuition/gadgetclass',
       'graphics/modeid',
       'mousepointer',
       'devices/input',
       'tools/file',
       'iff',
       'libraries/iff',
       'graphics/rastport'

      
-> GADGET & ERROR ENUMERATIONS

ENUM ERR_NONE, ERR_DEV, ERR_DEV2, ERR_SCREEN, ERR_ACTIVE, ERR_GAD, 
     ERR_WINDOW, ERR_FILE, ERR_IO, ERR_PORT, MYGAD_BUTTON, ERR_AUPORT,
     ERR_AUIO, ERR_DEV3, ERR_AUDIO, TEM, 
     MYGAD_CYCLE, ERR_KICK, ERR_LIB, MYGAD_SLIDER, MYGAD_SLIDER2, 
     MYGAD_SLIDER3, ERR_VIS, ERR_DEVTI, ERR_DEVIN, ERR_ACPORT, ERR_TIPORT, 
     ERR_INPORT, ERR_TIIO, ERR_INIO, MYGAD_BUTTON6, MYGAD5_BUTTON2, 
     MYGAD5_BUTTON, MYGAD_BUTTON2, MYGAD2_SLIDER, MYGAD_BUTTON3, MYGAD_BUTTON4, 
     MYGAD_BUTTON5, MYGAD2_CHECKBOX, MYGAD2_CHECKBOX2, MYGAD2_CHECKBOX3, 
     MYGAD2_CHECKBOX4, MYGAD2_CHECKBOX5, MYGAD2_BUTTON, MYGAD2_BUTTON2, MYGAD3_CYCLE, 
     MYGAD3_CYCLE2, MYGAD3_CYCLE3, MYGAD3_CYCLE4, MYGAD3_BUTTON, 
     MYGAD3_BUTTON2, MYGAD4_BUTTON, MYGAD4_BUTTON2, MYGAD3_STRING, 
     MYGAD3_STRING2, MYGAD3_STRING3, MYGAD3_STRING4, MYGAD4_BUTTON3, 
     MYGAD4_BUTTON4, MYGAD4_BUTTON5, MYGAD4_BUTTON6

-> END GADGET & ERROR ENUMERATIONS

DEF abutton, abutton2, acycle, abutton3, abutton4, abutton5, speed1=0,
    bcheckbox, bcheckbox2, bcheckbox3, bslider, bcheckbox4, bcheckbox5,
    bbutton, bbutton2, ccycle4, ccycle, ccycle3, ccycle2, cbutton, cbutton2,
    errmessage[200]:STRING, dbutton, dbutton2, dslider2, dslider3, 
    slider_levela, slider_levelb, slider_levelc, mywin4=NIL:PTR TO window, 
    gad4 , dbutton3, dbutton4, dbutton5, dbutton6, cstring:PTR TO gadget, 
    cstring2=NIL:PTR TO gadget, cstring3:PTR TO gadget, cstring4:PTR TO gadget, 
    gad5, ebutton2:PTR TO gadget, ebutton:PTR TO gadget, terminated5=FALSE, 
    wcheat=0, who, limspeed1=0, limspeed2=0, limspeed3=0, limspeed4=0, 
    movex, movey, limspeedc1=0, limspeedc2=0, limspeedc3=0, limspeedc4=0, 
    movex2, movey2, blocked5, newgame=TRUE , joy1loop=TRUE, 
    joy2loop=TRUE, open_devin=FALSE, restoremouse=TRUE, joy3loop=TRUE, 
    joy4loop=TRUE, playcount=0, e[4]:ARRAY, exec:PTR TO execbase, vi,
    topborder,quit=0, screen=NIL:PTR TO screen, topaz80, gamepicmem=NIL,
    terminated, terminated2, terminated3, terminated4, mainwin=NIL:PTR TO window,
    mywin=NIL:PTR TO window, start1=FALSE, myreq:requester, samplec=NIL:PTR TO LONG,
    sampled=NIL:PTR TO LONG, samplei=NIL:PTR TO LONG, samplend, sampleni,
    swooshy=TRUE, sliderb_level=70,
    samplenc, shineBorder, shadowBorder, hiddenclosed=TRUE, movementx, grey, 
    movementy, movementx3, movementy3, shineBorderC, shadowBorderC, bee, 
    playon=FALSE, pausewin, play1control=0, play2control=1, play3control=2,
    play4control=3, noterminate3=0, obstacles=TRUE, accelaration=1, wrap=TRUE, 
    blocks=FALSE, playerno=0, not_finished, tname1[7]:STRING, tname2[7]:STRING,
    tname3[7]:STRING, tname4[7]:STRING, name1[7]:STRING, name2[7]:STRING,  
    name3[7]:STRING, name4[7]:STRING, joy1=1, joy2=4, joy3=3, joy4=2, joy,
    controller_type_addr1, controller_type_addr2, play1=0, play2=0, play3=0,
    play4=0, x1=194, y1=221, x2=40, y2=167, x3=106, y3=47, x4=275, y4=83,
    cx1=194, cy1=221, cx2=40, cy2=167, cx3=106, cy3=47, cx4=275, cy4=83,
    cway1=1, cway2=2, cway3=3, cway4=4, tempy1, tempy2, tempx1, tempx2, die1=TRUE,  
    cdie1=FALSE, cloop1=0, cloop2=10, cloop3=17, cloop4=25, cloop, die2=TRUE, 
    diel, x, y, speed, die3=FALSE , cdie2=FALSE, cdie3=TRUE, cdie4=FALSE,
    die4=TRUE, speed3=0, speed4=0, speed2=0, chipx, chipy, rndchip,
    obhity1, obhity2,
    col1r=255, col1g=255, col1b=255, col2r=255, col2g=255, col2b=165, col3r=165, 
    col3g=255, col3b=165, col4r=255, col4g=180, col4b=180, sactive, 
    timerio=NIL:PTR TO timerequest, timermp=NIL:PTR TO mp, howlong, 
    howlong2, mouserequest=NIL:PTR TO iostd, lport=NIL:PTR TO mp,
    game_io_msg=NIL:PTR TO iostd, game_msg_port=NIL, open_dev=FALSE,
    game_io_msgm=NIL:PTR TO iostd,game_msg_portm=NIL,open_devm=FALSE,
    open_devti=FALSE, hidden:PTR TO window, mywinch:PTR TO window,
    stupid=69, clever, audiomp=NIL:PTR TO mp, audioio=NIL:PTR TO ioaudio,
    open_devau=FALSE, bob=0, audioprob:PTR TO unit, samplen, 
    sample=NIL:PTR TO LONG, return=0, iffinram, ct[256]:ARRAY OF INT,
    mdwin=NIL:PTR TO window, chiplen1, chiplen2, chip1data, chip2data, chip1mem=NIL, chip2mem=NIL, chip1, chip2


CONST JOY_X_DELTA=1, JOY_Y_DELTA=1, TIMEOUT_SECONDS=0, SLIDER_MIN=0, 
      SLIDER_MAX=255

 RAISE ERR_SCREEN IF OpenS()=NIL
 RAISE ERR_WINDOW IF OpenW()=NIL
 RAISE ERR_LIB IF OpenLibrary()=NIL
 RAISE ERR_GAD  IF CreateGadgetA()=NIL
 RAISE ERR_VIS IF GetVisualInfoA()=NIL
 RAISE TEM     IF AllocMem()=NIL

PROC resetdefs()
   x1:=194 ;   y1:=221 
   x2:=40  ;   y2:=167
   x3:=106 ;   y3:=47
   x4:=275 ;   y4:=83
  cx1:=194 ;  cy1:=221 
  cx2:=40  ;  cy2:=167
  cx3:=106 ;  cy3:=47
  cx4:=275 ;  cy4:=83
  cway1:=1 
  cway2:=2 
  cway3:=3
  cway4:=4
  speed1:=0
  speed2:=0
  speed3:=0
  speed4:=0
  start1:=FALSE
  newgame:=TRUE
  joy1loop:=TRUE
  joy2loop:=TRUE
  joy3loop:=TRUE
  joy4loop:=TRUE
  playcount:=0
  cloop1:=0
  cloop2:=10
  cloop3:=17
  cloop4:=25
  limspeed1:=0
  limspeed2:=0
  limspeed3:=0
  limspeed4:=0
  limspeedc1:=0
  limspeedc2:=0
  limspeedc3:=0
  limspeedc4:=0

ENDPROC                         

PROC main() HANDLE
  DEF pub_screen_font:PTR TO textattr, opened_font, portlock, 
      actport=NIL:PTR TO mp, kickversion=37
StringF(tname1,'Jam') 
StringF(tname2,'Custard')
StringF(tname3,'Syrup')
StringF(tname4,'Treacle')

   IF KickVersion(kickversion)=FALSE THEN Raise(ERR_KICK)
  portlock:=FindPort('LightSpeed.Active')
  IF portlock<>0 THEN Raise(ERR_ACTIVE)

IF NIL=(actport:=createPort('LightSpeed.Active', 0)) THEN Raise(ERR_ACPORT)
IF NIL=(timermp:=createPort('LightSpeed-Timer',0)) THEN Raise(ERR_TIPORT)
IF NIL=(timerio:=createExtIO(timermp, SIZEOF timerequest)) THEN Raise(ERR_TIIO)
IF (OpenDevice('timer.device', UNIT_WAITUNTIL, timerio, 0))<>0 THEN Raise(ERR_DEVTI) ELSE open_devti:=TRUE
IF NIL=(lport:=createPort('LightSpeed-Input',0)) THEN Raise(ERR_INPORT)
IF NIL=(mouserequest:=CreateIORequest(lport, SIZEOF iostd)) THEN Raise(ERR_INIO)
IF (OpenDevice('input.device', 0, mouserequest,0))<>0 THEN Raise(ERR_DEVIN) ELSE open_devin:=TRUE
IF NIL=(game_msg_port:=createPort('LightSpeed.GamePort', 0)) THEN Raise(ERR_PORT)
IF NIL=(game_io_msg:=createExtIO(game_msg_port, SIZEOF iostd)) THEN Raise(ERR_IO)
IF (OpenDevice('gameport.device', 1, game_io_msg, 0))<>0 THEN Raise(ERR_DEV) ELSE open_dev:=TRUE
IF NIL=(game_msg_portm:=createPort('LightSpeed.GamePort-Mouse', 0)) THEN Raise(ERR_PORT)
IF NIL=(game_io_msgm:=createExtIO(game_msg_portm, SIZEOF iostd)) THEN Raise(ERR_IO)
IF (OpenDevice('gameport.device', 0, game_io_msgm, 0))<>0 THEN Raise(ERR_DEV2) ELSE open_devm:=TRUE
IF NIL=(audiomp:=createPort('LightSpeed-Audio',0)) THEN Raise(ERR_AUPORT)
IF NIL=(audioio:=CreateIORequest(audiomp, SIZEOF ioaudio)) THEN Raise(ERR_AUIO)
IF (OpenDevice('audio.device',0, audioio, NIL))<>0 THEN Raise(ERR_DEV3) ELSE open_devau:=TRUE 
initaudio()
gadtoolsbase:=OpenLibrary('gadtools.library', 37)
iffbase:=OpenLibrary('iff.library', 22)
setup()
decrypt()
        pub_screen_font:=['topaz.font',8,0,65]:textattr
        opened_font:=OpenFont(pub_screen_font)
 screen:=OpenS(320,256,6,NIL,'LightSpeed2',[SA_BEHIND, TRUE, SA_PENS, [-1]:INT, SA_FONT, pub_screen_font, NIL])
mainwin:=OpenW(0,11,320,245,NIL, WFLG_BORDERLESS OR WFLG_ACTIVATE, NIL, screen,$F,NIL,NIL)
SetTopaz(8)

chip1:=[$FFFFFFFF, $FFFFFE00, $FFFF81C7, $FFFFFA00, $FFFF9C7F, $FFFFC400, $FFFFB8FF, $FFFF8600, $FFFFB1FF, $400, $FFFFA3FE, $200, $FFFF87FC, $800, $FFFFCFF8, $1A00, $FFFFDFF0, $3C00, $FFFFFFE0, $7600, $FFFFBFC0, $FFFFE400, $FFFFBF81, $FFFFC200, $FFFFBF03, $FFFF8800, $FFFFFE07, $1A00, $FFFFFC0E, $3800, $FFFFF81C, $7200, $FFFFF038, $FFFFE000, $FFFFE071, $FFFFC200, $FFFFC0E3, $FFFF8000, $FFFFC1C7, $200, $FFFFC38E, $0, $FFFFB8E0, $200, $5555, $5400, $FFFFAAAA, $FFFFAA00, $7FC0, $FFFFE000, $FFFFFC00, $200, $7800, $0, $FFFFF000, $200, $6000, $400, $FFFFC000, $600, $4000, $400, $FFFFC000, $600, $4000, $C00, $FFFF8000, $1E00, $0, $3800, $FFFF8000, $7A00, $0, $FFFFF800, $FFFF8001, $FFFFFE00, $3, $FFFFF400, $FFFFC007, $FFFFE600, $400F, $FFFFC400, $FFFFC01F, $FFFF8E00, $3F, $1C00, $FFFF807E, $3E00, $7E3, $FFFFFC00, $FFFFAAAA, $FFFFAA00, $FFFFAAAA, $FFFFAA00, $3F, $0, $FFFF83F8, $200, $7F0, $0, $FFFF8FE0, $200, $1FC0, $0, $FFFFBF80, $200, $3F00, $0, $FFFFBE00, $200, $3C00, $0, $FFFFF800, $200, $7000, $400, $FFFFE000, $600, $4000, $400, $FFFFC000, $200, $4000, $800, $FFFF8000, $1A00, $0, $3800, $FFFF8000, $7200, $0, $FFFFE000, $FFFF8001, $FFFFC200, $1C, $0, $FFFFAAAA, $FFFFAA00, $FFFFAAAA, $FFFFAA00, $0, $FFFFE400, $FFFF8000, $3E00, $0, $7C00, $FFFF8000, $FFFFFE00, $1, $FFFFFC00, $FFFF8003, $FFFFFE00, $7, $FFFFFC00, $FFFF800F, $FFFFFE00, $1F, $FFFFFC00, $FFFF803F, $FFFFFE00, $7F, $FFFFFC00, $FFFF80FF, $FFFFFE00, $1FF, $FFFFFC00, $FFFF83FF, $FFFFFA00, $7FF, $FFFFF800, $FFFFCFFF, $FFFFFA00, $5FFF, $FFFFF800, $FFFFFFFF, $FFFFF200, $3FFF, $FFFFE000, $FFFFBFFF, $FFFFC200, $7FFC, $0, $FFFFAAAA, $FFFFAA00, $FFFFAAAA, $FFFFAA00, $7FFF, $1C00, $FFFFFFFF, $FFFFFE00, $7FFF, $FFFFFC00, $FFFFFFFF, $FFFFFE00, $7FFF, $FFFFFC00, $FFFFFFFF, $FFFFFE00, $7FFF, $FFFFFC00, $FFFFFFFF, $FFFFFE00, $7FFF, $FFFFFC00, $FFFFFFFF, $FFFFFE00, $7FFF, $FFFFFC00, $FFFFFFFF, $FFFFFE00, $7FFF, $FFFFFC00, $FFFFFFFF, $FFFFFE00, $7FFF, $FFFFFC00, $FFFFBFFF, $FFFFFE00, $3FFF, $FFFFFC00, $FFFFBFFF, $FFFFFE00, $7FFF, $FFFFFC00, $FFFFFFFF, $FFFFFE00, $7FFF, $FFFFFC00, $FFFFAAAA, $FFFFAA00, $FFFFAAAA, $FFFFAA00, $7FFF, $FFFFE400, $FFFFFFF8, $3E00, $7FF0, $7C00, $FFFFFFE0, $FFFFFE00, $7FC1, $FFFFFC00, $FFFFFF83, $FFFFFE00, $7F07, $FFFFFC00, $FFFFFE0F, $FFFFFE00, $7C1F, $FFFFFC00, $FFFFF83F, $FFFFFE00, $707F, $FFFFFC00, $FFFFE0FF, $FFFFFE00, $41FF, $FFFFFC00, $FFFFC3FF, $FFFFFA00, $47FF, $FFFFF800, $FFFFCFFF, $FFFFFA00, $5FFF, $FFFFF800, $FFFFFFFF, $FFFFF200, $3FFF, $FFFFE000, $FFFFBFFF, $FFFFC200, $7FFC, $0, $FFFFAAAA, $FFFFAA00]:INT

chip2:=[$FFFFFFFF, $FFFFFE00, $FFFFFE38, $FFFFE600, $FFFFEDBF, $C00, $FFFFC93E, $E00, $FFFFDB7E, $1C00, $FFFFD27C, $1A00, $FFFFF6FC, $3000, $FFFFA4F8, $3200, $FFFFADF8, $6000, $FFFF89F0, $6600, $FFFFDBF0, $FFFFCC00, $FFFFD3E0, $FFFFCE00, $FFFFF7E1, $FFFF9C00, $FFFFA7C1, $FFFF9E00, $FFFFAFC3, $3800, $FFFF8F83, $3200, $FFFFDF86, $7000, $FFFFDF06, $6600, $FFFFFF0C, $FFFFE400, $FFFFBE0C, $FFFFCE00, $FFFFBE19, $FFFFCC00, $FFFFC71C, $7E00, $5555, $5400, $FFFFAAAA, $FFFFAA00, $1F8, $1800, $FFFF9C70, $FFFFFE00, $38F1, $FFFFFC00, $FFFFB8E1, $FFFFFE00, $31E3, $FFFFF800, $FFFFB1C3, $FFFFF200, $63C7, $FFFFF000, $FFFFE387, $FFFFE200, $478F, $FFFFE000, $FFFFC70F, $FFFFC200, $4F1F, $FFFFC000, $FFFFCE1F, $FFFF8200, $1E3F, $FFFF8000, $FFFF9C3F, $600, $3C7F, $C00, $FFFFB87E, $E00, $38FE, $1C00, $FFFFB0FC, $1E00, $71FC, $3C00, $FFFFE1F8, $3E00, $3F03, $FFFFFC00, $FFFFAAAA, $FFFFAA00, $FFFFAAAA, $FFFFAA00, $7, $FFFFF800, $FFFF83F0, $200, $7F0, $0, $FFFF87E0, $200, $FE0, $400, $FFFF8FC0, $E00, $1FC0, $C00, $FFFF9F80, $1E00, $3F80, $1C00, $FFFFBF00, $3E00, $3F00, $3C00, $FFFFBE00, $7E00, $7E00, $7C00, $FFFFFC00, $FFFFFE00, $7C00, $FFFFFC00, $FFFFF801, $FFFFFE00, $7801, $FFFFFC00, $FFFFF003, $FFFFFE00, $7003, $FFFFFC00, $FFFFE007, $FFFFFE00, $FF, $FFFFFC00, $FFFFAAAA, $FFFFAA00, $FFFFAAAA, $FFFFAA00, $0, $400, $FFFF800F, $FFFFFE00, $F, $FFFFFC00, $FFFF801F, $FFFFFE00, $1F, $FFFFFC00, $FFFF803F, $FFFFFE00, $3F, $FFFFFC00, $FFFF807F, $FFFFFE00, $7F, $FFFFFC00, $FFFF80FF, $FFFFFE00, $FF, $FFFFFC00, $FFFF81FF, $FFFFFE00, $1FF, $FFFFFC00, $FFFF83FF, $FFFFFE00, $3FF, $FFFFFC00, $FFFF87FF, $FFFFFE00, $7FF, $FFFFFC00, $FFFF8FFF, $FFFFFE00, $FFF, $FFFFFC00, $FFFF9FFF, $FFFFFE00, $7FFF, $FFFFFC00, $FFFFAAAA, $FFFFAA00, $FFFFAAAA, $FFFFAA00, $0, $0, $FFFF8000, $200, $0, $0, $FFFF8000, $200, $0, $0, $FFFF8000, $200, $0, $0, $FFFF8000, $200, $0, $0, $FFFF8000, $200, $0, $0, $FFFF8000, $200, $0, $0, $FFFF8000, $200, $0, $0, $FFFF8000, $200, $0, $0, $FFFF8000, $200, $0, $0, $FFFF8000, $200, $0, $0, $FFFFAAAA, $FFFFAA00, $FFFFAAAA, $FFFFAA00, $7FFF, $FFFFFC00, $FFFFFFFF, $FFFFFE00, $7FFF, $FFFFFC00, $FFFFFFFF, $FFFFFE00, $7FFF, $FFFFFC00, $FFFFFFFF, $FFFFFE00, $7FFF, $FFFFFC00, $FFFFFFFF, $FFFFFE00, $7FFF, $FFFFFC00, $FFFFFFFF, $FFFFFE00, $7FFF, $FFFFFC00, $FFFFFFFF, $FFFFFE00, $7FFF, $FFFFFC00, $FFFFFFFF, $FFFFFE00, $7FFF, $FFFFFC00, $FFFFFFFF, $FFFFFE00, $7FFF, $FFFFFC00, $FFFFFFFF, $FFFFFE00, $7FFF, $FFFFFC00, $FFFFFFFF, $FFFFFE00, $7FFF, $FFFFFC00, $FFFFAAAA, $FFFFAA00]:INT


chiplen1:=ListMax(chip1)
chip1mem:=AllocMem(chiplen1, MEMF_CHIP)
CopyMem(chip1, chip1mem, chiplen1)
chiplen2:=ListMax(chip2)
chip2mem:=AllocMem(chiplen2, MEMF_CHIP)
CopyMem(chip2, chip2mem, chiplen2)

chip1data:=[0, 0, 23, 23, 6, chip1mem, 63, 0, NIL]:image 
chip2data:=[0, 0, 23, 23, 6, chip2mem, 63, 0, NIL]:image

gamepicmem:=AllocMem(54330, MEMF_CHIP)
CopyMem({gamepic}, gamepicmem, 54330)
iffinram:=AllocMem(59966, MEMF_CHIP)
CopyMem({mainpic}, iffinram, 59966)
setcols()
IfFL_DecodePic(iffinram,screen+184)
intrnd()

IF FileLength('PROGDIR:light.prefs')>-1 THEN loadprefs()
ScreenToFront(screen)
ShowTitle(screen, TRUE)
playData(sample,samplen,4500000,CHAN_LEFT1+CHAN_RIGHT1+CHAN_LEFT2+CHAN_RIGHT2,64)
    WaitTOF()
    exitLoop(CHAN_LEFT1+CHAN_RIGHT1+CHAN_LEFT2+CHAN_RIGHT2)
 gadtoolsWindow(0)
 IF quit=0
         begingame()
 ENDIF

WHILE quit=0
terminated:=FALSE
resetdefs()
terminated5:=FALSE
onMousePointer(hidden)
scorecard()
IF playon=TRUE
begingame()
playon:=FALSE
ELSE
SetStdRast(hidden.rport)
Box(0,0,319,255,0)
setcols()
CloseW(hidden)
hiddenclosed:=TRUE 
play1:=0
play2:=0
play3:=0
play4:=0
  gadtoolsWindow(1)
IF quit<>0
hiddenclosed:=TRUE 
JUMP term
ENDIF
         begingame()
ENDIF
ENDWHILE
term:

 EXCEPT DO
  IF hiddenclosed=FALSE THEN CloseW(hidden)
  IF opened_font THEN CloseFont(opened_font)
  IF gadtoolsbase THEN CloseLibrary(gadtoolsbase)
  IF iffbase THEN CloseLibrary(iffbase)
  IF iffinram THEN FreeMem(iffinram, 59966)
  IF gamepicmem THEN FreeMem(gamepicmem, 54330)
  IF chip1mem THEN FreeMem(chip1mem, chiplen1)
  IF chip2mem THEN FreeMem(chip2mem, chiplen2)
  IF mainwin THEN CloseW(mainwin)
  IF screen THEN CloseS(screen)
  IF actport THEN deletePort(actport)
  IF open_devti THEN CloseDevice(timerio)
  IF timerio THEN deleteExtIO(timerio)
  IF timermp THEN deletePort(timermp)
  IF restoremouse=FALSE THEN instmouse()
  IF open_devin THEN CloseDevice(mouserequest)
  IF mouserequest THEN DeleteIORequest(mouserequest)
  IF lport THEN deletePort(lport)    
  IF open_dev THEN CloseDevice(game_io_msg)
  IF game_io_msg THEN deleteExtIO(game_io_msg)
  IF game_msg_port THEN deletePort(game_msg_port)
  IF open_devm THEN CloseDevice(game_io_msgm)
  IF game_io_msgm THEN deleteExtIO(game_io_msgm)
  IF game_msg_portm THEN deletePort(game_msg_portm)
  IF sample THEN FreeMem(sample, 12760)
  IF samplec THEN FreeMem(samplec, 3900)
  IF sampled THEN FreeMem(sampled, 3121)
  IF samplei THEN FreeMem(samplei, 9536)
  IF open_devau THEN cleanupaudio()
  IF open_devau THEN CloseDevice(audioio)
  IF audioio THEN DeleteIORequest(audioio)
  IF audiomp THEN deletePort(audiomp)
   
 IF exception
  SELECT exception
   CASE "MEM" ;     request('out of memory',0,'')
   CASE TEM ;       request('out of memory',0,'')
   CASE "^C";       request('User ***Break',0,'')        
   CASE ERR_DEV;    request('could not open gameport device, unit:1',0,'')
   CASE ERR_DEV2;   request('could not open gameport device, unit:0',0,'')
   CASE ERR_DEV3;   request('could not open/allocate the audio device',0,'')
   CASE ERR_DEVTI;  request('could not open timer device, UNIT_MICROHZ',0,'')
   CASE ERR_DEVIN;  request('could not open input device, unit:0',0,'')
   CASE ERR_IO;     request('could not create gameport I/O',0,'')
   CASE ERR_TIIO;   request('could not create timer I/O',0,'')
   CASE ERR_INIO;   request('could not create input I/O',0,'')
   CASE ERR_PORT;   request('could not create gameport port',0,'')
   CASE ERR_ACPORT; request('could not create LightSpeed.Active port',0,'')
   CASE ERR_TIPORT; request('could not create LightSpeed.Timer port',0,'')
   CASE ERR_INPORT; request('could not create LightSpeed.Input port',0,'')
   CASE ERR_SCREEN; request('could not create a screen',0,'')
   CASE ERR_AUDIO;  request('audio prob',0,'')
   CASE ERR_WINDOW; request('could not create a window',0,'')
   CASE ERR_GAD;    request('could not create the gadgets',0,'')
   CASE ERR_VIS;    request('could not get the visual info',0,'')
   CASE ERR_ACTIVE; request('LightSpeed2 already active',0,'')
   CASE ERR_LIB;    request('could not open Gadtools Library V.37',0,'')
   CASE ERR_KICK;   REPEAT ; kickversion:=kickversion-1 ; UNTIL KickVersion(kickversion)=TRUE ;  WriteF('\nLightSpeed2 needs at least Kickstart version 37 to run:\nyou have Kickstart version \d\n\nMaybe its time to upgrade :-)\n\n',kickversion) ; WriteF('Error: returncode 236\n') ; return:=236
   CASE 18766;      request('Error Loading Data Files\n\n (File Read Protected?)',0,'')
   CASE "OPEN";     StringF(errmessage,'could not open file \s', IF exceptioninfo THEN exceptioninfo ELSE '') ; request(errmessage,0,'')
   DEFAULT 
      IF exception<10000
            StringF(errmessage,'Program Caused Error: \d',exception)
            request(errmessage,0,'')
      ELSE
            e[4]:=0
            ^e:=exception
            WHILE e[]=0 DO e++
                IF exceptioninfo<1000
                     StringF(errmessage,'Error: "\s" [\d]',exceptioninfo)
                ELSE
                     StringF(errmessage,'Error: "\s" [\h]',exceptioninfo)
                ENDIF
                     request(errmessage,0,'') 
      ENDIF
ENDSELECT
 ENDIF
ENDPROC return

PROC setcols2()
SetColour(screen,0,170,170,170)
SetColour(screen,1,0,0,0)
SetColour(screen,2,255,255,255)
SetColour(screen,3,100,100,100)
SetColour(screen,4,255,255,255)
SetColour(screen,5,255,255,165)
SetColour(screen,6,165,255,165)
SetColour(screen,7,255,180,180)
SetColour(screen,8,0,0,220)
SetColour(screen,9,0,0,212)
SetColour(screen,10,0,0,206)
SetColour(screen,11,0,0,198)
SetColour(screen,12,0,0,191)
SetColour(screen,13,0,0,184)
SetColour(screen,14,0,0,177)
SetColour(screen,15,0,0,169)
SetColour(screen,16,0,0,163)
SetColour(screen,17,76,35,83)
SetColour(screen,18,48,7,76)
SetColour(screen,19,101,62,90)
SetColour(screen,20,0,0,134)
SetColour(screen,21,0,0,127)
SetColour(screen,22,0,0,120)
SetColour(screen,23,0,0,112)
SetColour(screen,24,0,0,106)
SetColour(screen,25,0,0,98)
SetColour(screen,26,0,0,91)
SetColour(screen,27,0,0,84)
SetColour(screen,28,0,0,77)
SetColour(screen,29,0,0,69)
SetColour(screen,30,0,0,63)
SetColour(screen,31,0,0,55)
SetColour(screen,32,131,74,194)
SetColour(screen,33,120,70,182)
SetColour(screen,34,110,68,171)
SetColour(screen,35,99,65,158)
SetColour(screen,36,88,62,147)
SetColour(screen,37,79,58,135)
SetColour(screen,38,73,56,120)
SetColour(screen,39,69,55,110)
SetColour(screen,40,66,55,103)
SetColour(screen,41,65,54,96)
SetColour(screen,42,67,51,90)
SetColour(screen,43,75,47,74)
SetColour(screen,44,79,42,59)
SetColour(screen,45,90,35,40)
SetColour(screen,46,98,31,23)
SetColour(screen,47,106,25,7)
SetColour(screen,48,0,0,141)
SetColour(screen,49,97,57,89)
SetColour(screen,50,94,53,88)
SetColour(screen,51,88,47,86)
SetColour(screen,52,84,44,85)
SetColour(screen,53,79,39,83)
SetColour(screen,54,0,0,155)
SetColour(screen,55,73,32,83)
SetColour(screen,56,73,30,85)
SetColour(screen,57,68,26,84)
SetColour(screen,58,62,21,80)
SetColour(screen,59,56,15,78)
SetColour(screen,60,53,11,77)
SetColour(screen,61,0,0,149)
SetColour(screen,62,143,94,87)
SetColour(screen,63,163,130,95)
ENDPROC

PROC setcols()
DEF grey=4
FOR grey:=0 TO 63
SetColour(screen, grey, 170, 170, 170)
ENDFOR
SetColour(screen,0,170,170,170)
SetColour(screen,1,0,0,0)
SetColour(screen,2,255,255,255)
SetColour(screen,3,110,110,110)
SetColour(screen,4,255,255,255)
SetColour(screen,5,255,255,165)
SetColour(screen,6,165,255,165)
SetColour(screen,7,255,180,180)
SetColour(screen,8,0,0,220)
SetColour(screen,9,0,0,212)
SetColour(screen,10,0,0,206)
SetColour(screen,11,0,0,198)
SetColour(screen,12,0,0,191)
SetColour(screen,13,0,0,184)
SetColour(screen,14,0,0,177)
SetColour(screen,15,0,0,169)
SetColour(screen,16,0,0,163)
SetColour(screen,17,144,84,198)
SetColour(screen,18,89,66,132)
SetColour(screen,19,209,107,255)
SetColour(screen,20,0,0,134)
SetColour(screen,21,0,0,127)
SetColour(screen,22,0,0,120)
SetColour(screen,23,0,0,112)
SetColour(screen,24,0,0,106)
SetColour(screen,25,0,0,98)
SetColour(screen,26,0,0,91)
SetColour(screen,27,0,0,84)
SetColour(screen,28,0,0,77)
SetColour(screen,29,0,0,69)
SetColour(screen,30,0,0,63)
SetColour(screen,31,0,0,55)
SetColour(screen,32,0,0,141)
SetColour(screen,33,196,102,255)
SetColour(screen,34,183,98,248)
SetColour(screen,35,171,94,231)
SetColour(screen,36,157,89,215)
SetColour(screen,37,0,0,155)
SetColour(screen,38,131,79,182)
SetColour(screen,39,119,75,165)
SetColour(screen,40,106,70,149)
SetColour(screen,41,0,0,149)
SetColour(screen,42,255,160,232)
SetColour(screen,43,244,136,198)
SetColour(screen,44,230,128,187)
SetColour(screen,45,217,120,175)
SetColour(screen,46,202,112,163)
SetColour(screen,47,188,103,152)
SetColour(screen,48,173,96,140)
SetColour(screen,49,167,89,139)
SetColour(screen,50,161,83,139)
SetColour(screen,51,155,76,138)
SetColour(screen,52,147,70,138)
SetColour(screen,53,142,64,136)
SetColour(screen,54,135,57,136)
SetColour(screen,55,130,51,135)
SetColour(screen,56,123,44,135)
SetColour(screen,57,118,37,134)
SetColour(screen,58,110,32,134)
SetColour(screen,59,105,25,133)
SetColour(screen,60,98,19,133)
SetColour(screen,61,92,12,132)
SetColour(screen,62,157,94,87)
SetColour(screen,63,179,130,95)
ENDPROC

PROC intrnd()
DEF div
timerio.io.command:=TR_GETSYSTIME
DoIO(timerio)
howlong:=timerio.time.secs
timerio.io.command:=TR_GETSYSTIME
DoIO(timerio)
howlong2:=timerio.time.secs
div:=howlong*2
howlong:=howlong-div
Rnd(howlong)
ENDPROC

PROC setlines()
SetColour(screen,4,col1r,col1g,col1b)
SetColour(screen,5,col2r,col2g,col2b)
SetColour(screen,6,col3r,col3g,col3b)
SetColour(screen,7,col4r,col4g,col4b)
ENDPROC

PROC gadtoolsWindow(access) HANDLE
  DEF font=NIL, glist=NIL, projItem, menus, menu1, menutitle, menustrip:PTR
TO menu, left=0,
      my_gads[7]:ARRAY OF LONG, mysc=NIL:PTR TO screen
  topaz80:=['topaz.font', 8, 0, 0]:textattr
  font:=OpenFont(topaz80)
  vi:=GetVisualInfoA(screen, [NIL])

  topborder:=mysc.wbortop+screen.font.ysize+1

  createAllGadgets({glist}, vi, topborder, my_gads)

  mywin:=OpenW(154, 126,141,97,IDCMP_MENUPICK OR IDCMP_VANILLAKEY OR IDCMP_REFRESHWINDOW OR BUTTONIDCMP OR IDCMP_CLOSEWINDOW OR IDCMP_GADGETDOWN OR IDCMP_GADGETUP, WFLG_NEWLOOKMENUS OR WFLG_CLOSEGADGET OR WFLG_ACTIVATE, 'Options', screen, $F, glist, NIL)
SetTopaz(8)

  menu1:=[NIL, 0, 0, 90, 10,
          ITEMTEXT OR COMMSEQ OR ITEMENABLED OR HIGHCOMP, 0,
          [1, 2, RP_JAM2, 3, 1, topaz80, 'About', NIL]:intuitext,
          NIL, "A", NIL, NIL]:menuitem

  menu1:=[menu1, 0, 11, 90, 10,
          ITEMTEXT OR COMMSEQ OR ITEMENABLED OR HIGHCOMP, 0,
          [1, 2, RP_JAM2, 3, 1, topaz80, 'Quit', NIL]:intuitext,
          NIL, "Q", NIL, NIL]:menuitem
  
 menutitle:='About'

  menustrip:=[NIL, left, 0,
              TextLength(mywin.wscreen.rastport, menutitle, 10),
              10, MENUENABLED, menutitle, menu1, 0, 0, 0, 0]:menu

  left:=left+menustrip.width

  SetMenuStrip(mywin, menustrip)


  process_window_events(mywin, my_gads)

 EXCEPT DO  
  ClearMenuStrip(mywin)
  IF mywin THEN CloseW(mywin)
  FreeGadgets(glist)
  IF vi THEN FreeVisualInfo(vi)
  IF font THEN CloseFont(font)
  ReThrow()
ENDPROC

PROC handleGadgetEvent(win, gad:PTR TO gadget, code,
                       my_gads:PTR TO LONG)
  DEF id
  id:=gad.gadgetid

  SELECT id
  CASE MYGAD_CYCLE
  playerno:=playerno+1
  IF playerno=5 THEN playerno:=0
CASE MYGAD_BUTTON
terminated:=TRUE
  CASE MYGAD_BUTTON4
  colourcontrol()
terminated4:=FALSE
  CASE MYGAD_BUTTON2
  playercontrol()
terminated3:=FALSE
  CASE MYGAD_BUTTON5
  gameprefs()
terminated2:=FALSE
ENDSELECT
ENDPROC

PROC about()
DEF build:PTR TO window, buildmsg, buildcode, endrequest1=FALSE, endrequest2=FALSE,
buildgad:PTR TO gadget
ghostgadgets()


build:=BuildEasyRequestArgs(mywin,[20,0,'LightSpeed2','Coded in AmigaE by Micro Design:\n\nRichard West              (code)\nDaniel Pimley   (graphics/sound)\n\n    This program is FREEWARE\n\n       Copyright © 1998\nDaniel Pimley and Richard West', 'OK'],0,NIL)


SetStdRast(build.rport)
REPEAT
Line(141,114,148,114,1)
buildmsg:=WaitIMessage(build)
buildcode:=MsgCode()
IF (buildcode=30224) OR (buildcode=111) OR (buildcode=79) OR (buildcode=26582) THEN endrequest1:=TRUE
UNTIL endrequest1=TRUE
SetStdRast(mywin.rport)    
FreeSysRequest(build)
unghostgadgets()
ENDPROC                                                              

PROC handleVanillaKey(win, code, my_gads:PTR TO LONG)
SELECT code
CASE -2048
terminated:=TRUE
quit:=9
CASE -2016
about()
ENDSELECT
  SELECT "z" OF code
CASE "x", "X"
  playerno:=playerno+1
  IF playerno=5 THEN playerno:=0
Gt_SetGadgetAttrsA(acycle,win,NIL,[GTCY_ACTIVE, playerno, GA_DISABLED, FALSE, NIL])
CASE "b", "B"
terminated:=TRUE
CASE "p", "P"
playercontrol()
terminated3:=FALSE
CASE "c", "C"
colourcontrol()
terminated4:=FALSE
CASE "a", "A"
about()
CASE "g", "G"
gameprefs()
terminated2:=FALSE
CASE "q", "Q"
terminated:=TRUE
quit:=9
  ENDSELECT
ENDPROC

PROC createAllGadgets(glistptr:PTR TO LONG, vi, topborder, my_gads:PTR TO LONG)  
DEF gad, ng:PTR TO newgadget
  gad:=CreateContext(glistptr)

   ng:=[140, (20+topborder), 200, 12, '', topaz80,
        NIL, NIL, vi, 0]:newgadget


  ng.leftedge   := 8
  ng.topedge    := 15
  ng.width      := 125
  ng.height     := 12
  ng.gadgettext := '_x:        '
  ng.gadgetid   :=MYGAD_CYCLE
  ng.flags      :=PLACETEXT_IN
  acycle:=CreateGadgetA(CYCLE_KIND, gad, ng, [GT_UNDERSCORE, "_", GTCY_LABELS, ['  1 Player ', '  2 Players', '  3 Players', '  4 Players', 'Demo', NIL],GTCY_ACTIVE, playerno, NIL])

  ng.leftedge   := 8
  ng.topedge    := 31
  ng.width      := 125
  ng.height     := 12
  ng.gadgettext := '_Begin Game'
  ng.gadgetid   := MYGAD_BUTTON
  ng.flags      := 0
  abutton:=CreateGadgetA(BUTTON_KIND, acycle, ng, [GT_UNDERSCORE, "_"])

  ng.leftedge   := 8
  ng.topedge    := 47
  ng.width      := 125
  ng.height     := 12
  ng.gadgettext := '_Player Control'
  ng.gadgetid   := MYGAD_BUTTON2
  ng.flags      := 0
  abutton2:=CreateGadgetA(BUTTON_KIND, abutton, ng, [GT_UNDERSCORE, "_"])

  ng.leftedge   := 8
  ng.topedge    := 63
  ng.width      := 125
  ng.height     := 12 
  ng.gadgettext := '_Colour Control'
  ng.gadgetid   := MYGAD_BUTTON4
  ng.flags      := 0
  abutton3:=CreateGadgetA(BUTTON_KIND, abutton2, ng, [GT_UNDERSCORE, "_"])

  ng.leftedge   := 8
  ng.topedge    := 79
  ng.width      := 125
  ng.height     := 12
  ng.gadgettext := '_Game Prefs'
  ng.gadgetid   := MYGAD_BUTTON5
  ng.flags      := 0
  abutton4:=CreateGadgetA(BUTTON_KIND, abutton3, ng, [GT_UNDERSCORE, "_"])

ENDPROC(gad)

PROC process_window_events(mywin:PTR TO window, my_gads:PTR TO LONG)
  DEF imsg:PTR TO intuimessage, imsgClass, imsgCode, gad
DEF build:PTR TO window, buildmsg, buildcode, endrequest3=FALSE,
buildgad:PTR TO gadget

  REPEAT
    Wait(Shl(1, mywin.userport.sigbit))
    WHILE (terminated=FALSE) AND (imsg:=Gt_GetIMsg(mywin.userport))
      gad:=imsg.iaddress
 
      imsgClass:=imsg.class
      imsgCode:=imsg.code

      Gt_ReplyIMsg(imsg)

      SELECT imsgClass
      CASE IDCMP_GADGETDOWN
        handleGadgetEvent(mywin, gad, imsgCode, my_gads)
      CASE IDCMP_MOUSEMOVE
        handleGadgetEvent(mywin, gad, imsgCode, my_gads)
      CASE IDCMP_GADGETUP
        handleGadgetEvent(mywin, gad, imsgCode, my_gads)
      CASE IDCMP_CLOSEWINDOW
        quit:=9
        terminated:=TRUE
      CASE IDCMP_VANILLAKEY
        handleVanillaKey(mywin, imsgCode, my_gads)
      CASE IDCMP_REFRESHWINDOW
        Gt_BeginRefresh(mywin)
        Gt_EndRefresh(mywin, TRUE)
      CASE 256
        handleVanillaKey(mywin, imsgCode, my_gads)
      ENDSELECT


    ENDWHILE
  UNTIL terminated
ENDPROC

PROC gameprefs() HANDLE
  DEF glist2=NIL, mywin2=NIL, my_gads2[6]:ARRAY OF LONG

ghostgadgets()
  createAllGadgets2({glist2}, vi, topborder, my_gads2)
  mywin2:=OpenW(17,85,282,97,IDCMP_VANILLAKEY OR IDCMP_REFRESHWINDOW OR BUTTONIDCMP OR IDCMP_GADGETDOWN OR IDCMP_GADGETUP OR SLIDERIDCMP, WFLG_ACTIVATE OR WFLG_DRAGBAR, 'Game Prefs', screen, $F, glist2, NIL)
Line(266,69,273,69,1)
Colour(1)
TextF(8,53,'CPU Turning:')
Gt_RefreshWindow(mywin2, NIL)
SetTopaz(8)
  process_window_events2(mywin2, my_gads2)

EXCEPT DO
  IF mywin2 THEN CloseW(mywin2)
  FreeGadgets(glist2)
  ReThrow()
unghostgadgets()
stupid:=sliderb_level
ENDPROC

PROC createAllGadgets2(glistptr:PTR TO LONG, vi, topborder,
                      my_gads:PTR TO LONG)
  DEF gad2, ng:PTR TO newgadget
  gad2:=CreateContext(glistptr)

  ng:=[140, (20+topborder), 200, 12, '_Volume:   ', topaz80,
        NIL, NG_HIGHLABEL, vi, 0]:newgadget


  ng.leftedge   := 48
  ng.topedge    := 15
  ng.width      := 80
  ng.height     := 12
  ng.gadgettext := '_Fire'
  ng.gadgetid   :=MYGAD2_CHECKBOX
  ng.flags      :=PLACETEXT_LEFT
  bcheckbox:=CreateGadgetA(CYCLE_KIND, gad2, ng, [GT_UNDERSCORE, "_", GTCY_LABELS, ['None', 'Speed', 'Shield', NIL],GTCY_ACTIVE, accelaration, NIL])

  ng.leftedge   := 248
  ng.topedge    := 15
  ng.gadgettext := 'Dying _Lines'
  ng.gadgetid   := MYGAD2_CHECKBOX3
  ng.flags      := 0
  bcheckbox2:=CreateGadgetA(CHECKBOX_KIND, bcheckbox, ng, [GT_UNDERSCORE, "_", GTCB_CHECKED, blocks])

  ng.leftedge   := 102
  ng.topedge    := 30
  ng.gadgettext := '_Obstacles'
  ng.gadgetid   := MYGAD2_CHECKBOX2
  ng.flags      := 0
  bcheckbox3:=CreateGadgetA(CHECKBOX_KIND, bcheckbox2, ng, [GT_UNDERSCORE, "_", GTCB_CHECKED, obstacles])

  ng.leftedge   := 248
  ng.topedge    := 30
  ng.gadgettext := 'Screen _Wrap'
  ng.gadgetid   := MYGAD2_CHECKBOX4
  ng.flags      := 0
  bcheckbox4:=CreateGadgetA(CHECKBOX_KIND, bcheckbox3, ng, [GT_UNDERSCORE, "_", GTCB_CHECKED, wrap])

  ng.leftedge   := 248
  ng.topedge    := 45
  ng.gadgettext := 'Swoos_hes'
  ng.gadgetid   := MYGAD2_CHECKBOX5
  ng.flags      := 0
  bcheckbox5:=CreateGadgetA(CHECKBOX_KIND, bcheckbox4, ng, [GT_UNDERSCORE, "_", GTCB_CHECKED, swooshy])

  ng.leftedge   := 8
  ng.topedge    := 76
  ng.width      := 129
  ng.height     := 15
  ng.gadgettext := '_Save'
  ng.gadgetid   := MYGAD2_BUTTON
  ng.flags      := 0
  bbutton:=CreateGadgetA(BUTTON_KIND, bcheckbox5, ng, [GT_UNDERSCORE, "_"])

  ng.leftedge   := 145
  ng.topedge    := 76
  ng.width      := 129
  ng.height     := 15
  ng.gadgettext := '_Use'
  ng.gadgetid   := MYGAD2_BUTTON2
  ng.flags      := 0
  bbutton2:=CreateGadgetA(BUTTON_KIND, bbutton, ng, [GT_UNDERSCORE, "_"])

  ng.leftedge   := 39
  ng.topedge    := 60
  ng.width      := 204
  ng.height     := 12
  ng.gadgettext := '_T/t'
  ng.gadgetid   := MYGAD2_SLIDER
  ng.flags      := PLACETEXT_RIGHT
  bslider:=CreateGadgetA(SLIDER_KIND, bbutton2, ng,
                                    [GTSL_MIN,         20,
                                     GTSL_MAX,         100,
                                     GTSL_LEVEL,       sliderb_level,
                                     GTSL_LEVELFORMAT, '\d[3]',
                                     GTSL_MAXLEVELLEN, 10,
                                     GA_DISABLED,      FALSE,
                                     GT_UNDERSCORE,    "_",
                                     NIL])

ENDPROC(gad2)

PROC process_window_events2(mywin2:PTR TO window, my_gads2:PTR TO LONG)
  DEF imsg:PTR TO intuimessage, imsgClass, imsgCode, gad2

  REPEAT
    Wait(Shl(1, mywin2.userport.sigbit))
    WHILE (terminated2=FALSE) AND (imsg:=Gt_GetIMsg(mywin2.userport))
      gad2:=imsg.iaddress

      imsgClass:=imsg.class
      imsgCode:=imsg.code

      Gt_ReplyIMsg(imsg)

      SELECT imsgClass
      CASE IDCMP_GADGETDOWN
        handleGadgetEvent2(mywin2, gad2, imsgCode, my_gads2)
      CASE IDCMP_MOUSEMOVE
        handleGadgetEvent2(mywin2, gad2, imsgCode, my_gads2)
      CASE IDCMP_GADGETUP
        handleGadgetEvent2(mywin2, gad2, imsgCode, my_gads2)
      CASE IDCMP_VANILLAKEY
        handleVanillaKey2(mywin2, imsgCode, my_gads2)
      CASE IDCMP_REFRESHWINDOW
        Gt_BeginRefresh(mywin2)
        Gt_EndRefresh(mywin2, TRUE)
      ENDSELECT
    ENDWHILE
  UNTIL terminated2
ENDPROC

PROC handleGadgetEvent2(win, gad:PTR TO gadget, code,
                       my_gads:PTR TO LONG)
  DEF id
  id:=gad.gadgetid
  SELECT id
  CASE MYGAD2_CHECKBOX2
  IF obstacles=TRUE THEN obstacles:=FALSE ELSE obstacles:=TRUE
  CASE MYGAD2_CHECKBOX
  accelaration:=accelaration+1 ; IF accelaration=3 THEN accelaration:=0
  CASE MYGAD2_CHECKBOX4
  IF wrap=TRUE THEN wrap:=FALSE ELSE wrap:=TRUE
  CASE MYGAD2_CHECKBOX5
  IF swooshy=FALSE THEN swooshy:=TRUE ELSE swooshy:=FALSE
  CASE MYGAD2_CHECKBOX3
  IF blocks=TRUE THEN blocks:=FALSE ELSE blocks:=TRUE
  CASE MYGAD2_SLIDER
    sliderb_level:=code
  CASE MYGAD2_BUTTON
stupid:=sliderb_level
  saveprefs()
  terminated2:=TRUE
  CASE MYGAD2_BUTTON2
stupid:=sliderb_level
  terminated2:=TRUE

ENDSELECT
ENDPROC

PROC handleVanillaKey2(win, code, my_gads:PTR TO LONG)
  SELECT "z" OF code
CASE "o", "O"
IF obstacles=TRUE THEN obstacles:=FALSE ELSE obstacles:=TRUE
IF obstacles=FALSE
Gt_SetGadgetAttrsA(bcheckbox3,win,NIL,[GTCB_CHECKED,FALSE])
ELSE
Gt_SetGadgetAttrsA(bcheckbox3,win,NIL,[GTCB_CHECKED,TRUE])
ENDIF
CASE "f", "F"
accelaration:=accelaration+1 ; IF accelaration=3 THEN accelaration:=0
Gt_SetGadgetAttrsA(bcheckbox,win,NIL,[GTCY_ACTIVE, accelaration])
CASE "w", "W"
IF wrap=TRUE THEN wrap:=FALSE ELSE wrap:=TRUE
IF wrap=FALSE
Gt_SetGadgetAttrsA(bcheckbox4,win,NIL,[GTCB_CHECKED,FALSE])
ELSE
Gt_SetGadgetAttrsA(bcheckbox4,win,NIL,[GTCB_CHECKED,TRUE])
ENDIF
CASE "h", "H"
IF swooshy=FALSE THEN swooshy:=TRUE ELSE swooshy:=FALSE
IF swooshy=FALSE
Gt_SetGadgetAttrsA(bcheckbox5,win,NIL,[GTCB_CHECKED,FALSE])
ELSE
Gt_SetGadgetAttrsA(bcheckbox5,win,NIL,[GTCB_CHECKED,TRUE])
ENDIF
CASE "l", "L"
IF blocks=TRUE THEN blocks:=FALSE ELSE blocks:=TRUE
IF blocks=0
Gt_SetGadgetAttrsA(bcheckbox2,win,NIL,[GTCB_CHECKED,FALSE])
ELSE
Gt_SetGadgetAttrsA(bcheckbox2,win,NIL,[GTCB_CHECKED,TRUE])
ENDIF

  CASE "T"
IF sliderb_level<100 THEN sliderb_level:=sliderb_level+1
    Gt_SetGadgetAttrsA(bslider, win, NIL,
                      [GTSL_LEVEL, sliderb_level, NIL])

  CASE "t"
IF sliderb_level>20 THEN sliderb_level:=sliderb_level-1    
Gt_SetGadgetAttrsA(bslider, win, NIL,
                      [GTSL_LEVEL, sliderb_level, NIL])


CASE "s", "S"
stupid:=sliderb_level
saveprefs()
  terminated2:=TRUE
CASE "u", "U"
stupid:=sliderb_level
terminated2:=TRUE
  ENDSELECT
ENDPROC

PROC playercontrol() HANDLE
  DEF glist3=NIL, mywin3=NIL, my_gads3[16]:ARRAY OF LONG

ghostgadgets()

createAllGadgets3({glist3}, vi, topborder, my_gads3)
  mywin3:=OpenW(0,26,320,100,STRINGIDCMP OR IDCMP_VANILLAKEY OR IDCMP_REFRESHWINDOW OR IDCMP_GADGETDOWN OR IDCMP_GADGETUP, WFLG_ACTIVATE OR WFLG_DRAGBAR, 'Player Control', screen, $F, glist3, NIL)
SetTopaz(8)

  process_window_events3(mywin3, my_gads3)

EXCEPT DO  
IF mywin3 THEN CloseW(mywin3)
  FreeGadgets(glist3)

  ReThrow()
unghostgadgets()
ENDPROC

PROC createAllGadgets3(glistptr:PTR TO LONG, vi, topborder,
                      my_gads:PTR TO LONG)
  DEF gad3, ng:PTR TO newgadget
  gad3:=CreateContext(glistptr)

  ng:=[140, (20+topborder), 200, 12, '_Volume:   ', topaz80,
       NIL, NG_HIGHLABEL, vi, 0]:newgadget


  ng.leftedge   := 72
  ng.topedge    := 15
  ng.width      := 110
  ng.height     := 12
  ng.gadgettext := 'P_ort #2'
  ng.gadgetid   :=MYGAD3_CYCLE
  ng.flags      := 0
  ccycle:=CreateGadgetA(CYCLE_KIND, gad3, ng, [GTCY_ACTIVE, play1control, GT_UNDERSCORE, "_", GTCY_LABELS, ['Player 1', 'Player 2', 'Player 3', 'Player 4', NIL],NIL])

  ng.leftedge   := 72
  ng.topedge    := 31
  ng.width      := 110
  ng.height     := 12
  ng.gadgettext := 'Po_rt #1'
  ng.gadgetid   :=MYGAD3_CYCLE2
  ng.flags      := 0
  ccycle2:=CreateGadgetA(CYCLE_KIND, ccycle, ng, [GTCY_ACTIVE, play2control, GT_UNDERSCORE, "_", GTCY_LABELS, ['Player 1', 'Player 2', 'Player 3', 'Player 4', NIL],NIL])

  ng.leftedge   := 72
  ng.topedge    := 47
  ng.width      := 110
  ng.height     := 12
  ng.gadgettext := '_Cursors'
  ng.gadgetid   :=MYGAD3_CYCLE3
  ng.flags      := 0
  ccycle3:=CreateGadgetA(CYCLE_KIND, ccycle2, ng, [GTCY_ACTIVE, play3control, GT_UNDERSCORE, "_", GTCY_LABELS, ['Player 1', 'Player 2', 'Player 3', 'Player 4', NIL], NIL])

  ng.leftedge   := 72
  ng.topedge    := 63
  ng.width      := 110
  ng.height     := 12
  ng.gadgettext := '_Q-A-Z-X'
  ng.gadgetid   :=MYGAD3_CYCLE4
  ng.flags      := 0
  ccycle4:=CreateGadgetA(CYCLE_KIND, ccycle3, ng, [GTCY_ACTIVE, play4control, GT_UNDERSCORE, "_", GTCY_LABELS, ['Player 1', 'Player 2', 'Player 3', 'Player 4', NIL], NIL])

  ng.leftedge   := 8
  ng.topedge    := 79
  ng.width      :=150
  ng.height     := 15
  ng.gadgettext := '_Save'
  ng.gadgetid   := MYGAD3_BUTTON
  ng.flags      := 0
  cbutton:=CreateGadgetA(BUTTON_KIND, ccycle4, ng, [GA_DISABLED, FALSE, GT_UNDERSCORE, "_", NIL])

  ng.leftedge   := 162
  ng.topedge    := 79
  ng.width      := 150
  ng.height     := 15
  ng.gadgettext := '_Use'
  ng.gadgetid   := MYGAD3_BUTTON2
  ng.flags      := 0
  cbutton2:=CreateGadgetA(BUTTON_KIND, cbutton, ng, [GA_DISABLED, FALSE, GT_UNDERSCORE, "_", NIL])

  ng.leftedge   := 236
  ng.topedge    := 15
  ng.width      := 76
  ng.height     := 12
  ng.gadgettext := '_Name:'
  ng.gadgetid   :=MYGAD3_STRING
  ng.flags      := 0
  cstring:=CreateGadgetA(STRING_KIND, cbutton2, ng, [GTST_STRING, tname1, GTST_MAXCHARS, 7, GT_UNDERSCORE, "_", NIL])

  ng.leftedge   := 236
  ng.topedge    := 31
  ng.width      := 76
  ng.height     := 12
  ng.gadgettext := 'N_ame:'
  ng.gadgetid   :=MYGAD3_STRING2
  ng.flags      := 0
  cstring2:=CreateGadgetA(STRING_KIND, cstring, ng, [GTST_STRING, tname2, GTST_MAXCHARS, 7, GT_UNDERSCORE, "_", NIL])

  ng.leftedge   := 236
  ng.topedge    := 47
  ng.width      := 76
  ng.height     := 12
  ng.gadgettext := 'Na_me:'
  ng.gadgetid   :=MYGAD3_STRING3
  ng.flags      := 0
  cstring3:=CreateGadgetA(STRING_KIND, cstring2, ng, [GTST_STRING, tname3, GTST_MAXCHARS, 7, GT_UNDERSCORE, "_", NIL])


  ng.leftedge   := 236
  ng.topedge    := 63
  ng.width      := 76
  ng.height     := 12
  ng.gadgettext := 'Nam_e:'
  ng.gadgetid   :=MYGAD3_STRING4
  ng.flags      := 0
  cstring4:=CreateGadgetA(STRING_KIND, cstring3, ng, [GTST_STRING, tname4, GTST_MAXCHARS, 7, GT_UNDERSCORE, "_", NIL])


ENDPROC(gad3)

PROC process_window_events3(mywin3:PTR TO window, my_gads3:PTR TO LONG)
  DEF imsg:PTR TO intuimessage, imsgClass, imsgCode, gad3:PTR TO gadget,
  gadgetid

  REPEAT
    Wait(Shl(1, mywin3.userport.sigbit))
    WHILE (terminated3=FALSE) AND (imsg:=Gt_GetIMsg(mywin3.userport))
      gad3:=imsg.iaddress
      gadgetid:=gad3.gadgetid
      imsgClass:=imsg.class
      imsgCode:=imsg.code

      Gt_ReplyIMsg(imsg)

      SELECT imsgClass
      CASE IDCMP_GADGETDOWN
        handleGadgetEvent3(mywin3, gad3, imsgCode, my_gads3)
      CASE IDCMP_GADGETUP
        handleGadgetEvent3(mywin3, gad3, imsgCode, my_gads3)
      CASE IDCMP_VANILLAKEY
        handleVanillaKey3(mywin3, imsgCode, my_gads3)
      CASE IDCMP_REFRESHWINDOW
        Gt_BeginRefresh(mywin3)
        Gt_EndRefresh(mywin3, TRUE)
      ENDSELECT

IF noterminate3=5
Gt_SetGadgetAttrsA(cbutton2,mywin3,cbutton2,[GA_DISABLED, TRUE])
Gt_SetGadgetAttrsA(cbutton,mywin3,cbutton,[GA_DISABLED, TRUE])
ELSE
Gt_SetGadgetAttrsA(cbutton,mywin3,cbutton,[GA_DISABLED, FALSE])
Gt_SetGadgetAttrsA(cbutton2,mywin3,cbutton2,[GA_DISABLED, FALSE])
ENDIF       
         
    ENDWHILE
  UNTIL terminated3
ENDPROC

PROC handleGadgetEvent3(win, gad:PTR TO gadget, code,
                       my_gads:PTR TO LONG)
  DEF id

  id:=gad.gadgetid

  SELECT id
CASE MYGAD3_STRING
  StringF(tname1,'\s', cstring.specialinfo::stringinfo.buffer)

CASE MYGAD3_STRING2
  StringF(tname2,'\s', cstring2.specialinfo::stringinfo.buffer)

CASE MYGAD3_STRING3
  StringF(tname3,'\s', cstring3.specialinfo::stringinfo.buffer)

CASE MYGAD3_STRING4
  StringF(tname4,'\s', cstring4.specialinfo::stringinfo.buffer)

CASE MYGAD3_CYCLE
play1control:=play1control+1
IF play1control=4 THEN play1control:=0
CASE MYGAD3_CYCLE2
play2control:=play2control+1
IF play2control=4 THEN play2control:=0
CASE MYGAD3_CYCLE3
play3control:=play3control+1
IF play3control=4 THEN play3control:=0
CASE MYGAD3_CYCLE4
play4control:=play4control+1
IF play4control=4 THEN play4control:=0
  CASE MYGAD3_BUTTON
saveprefs()
  terminated3:=TRUE
   CASE MYGAD3_BUTTON2
  terminated3:=TRUE
ENDSELECT

IF (play1control=play2control) OR (play1control=play3control) OR (play1control=play4control) OR (play2control=play3control) OR (play4control=play2control) OR (play3control=play4control) THEN noterminate3:=5 ELSE noterminate3:=0
ENDPROC

PROC handleVanillaKey3(win, code, my_gads:PTR TO LONG)
  SELECT "z" OF code
CASE "o", "O"
play1control:=play1control+1
IF play1control=4 THEN play1control:=0
IF play1control=0 THEN Gt_SetGadgetAttrsA(ccycle,win,NIL,[GA_DISABLED, FALSE, GTCY_ACTIVE, 0])
IF play1control=1 THEN Gt_SetGadgetAttrsA(ccycle,win,NIL,[GA_DISABLED, FALSE, GTCY_ACTIVE, 1])
IF play1control=2 THEN Gt_SetGadgetAttrsA(ccycle,win,NIL,[GA_DISABLED, FALSE, GTCY_ACTIVE, 2])
IF play1control=3 THEN Gt_SetGadgetAttrsA(ccycle,win,NIL,[GA_DISABLED, FALSE, GTCY_ACTIVE, 3])
IF (play1control=play2control) OR (play1control=play2control) OR (play1control=play3control) OR (play1control=play4control) OR (play2control=play3control) OR (play4control=play2control) OR (play3control=play4control) THEN noterminate3:=5 ELSE noterminate3:=0
CASE "r", "R"
play2control:=play2control+1
IF play2control=4 THEN play2control:=0
IF play2control=0 THEN Gt_SetGadgetAttrsA(ccycle2,win,NIL,[GA_DISABLED, FALSE, GTCY_ACTIVE, 0])
IF play2control=1 THEN Gt_SetGadgetAttrsA(ccycle2,win,NIL,[GA_DISABLED, FALSE, GTCY_ACTIVE, 1])
IF play2control=2 THEN Gt_SetGadgetAttrsA(ccycle2,win,NIL,[GA_DISABLED, FALSE, GTCY_ACTIVE, 2])
IF play2control=3 THEN Gt_SetGadgetAttrsA(ccycle2,win,NIL,[GA_DISABLED, FALSE, GTCY_ACTIVE, 3])
IF (play1control=play2control) OR (play1control=play2control) OR (play1control=play3control) OR (play1control=play4control) OR (play2control=play3control) OR (play4control=play2control) OR (play3control=play4control) THEN noterminate3:=5 ELSE noterminate3:=0
CASE "c", "C"
play3control:=play3control+1
IF play3control=4 THEN play3control:=0
IF play3control=0 THEN Gt_SetGadgetAttrsA(ccycle3,win,NIL,[GA_DISABLED, FALSE, GTCY_ACTIVE, 0])
IF play3control=1 THEN Gt_SetGadgetAttrsA(ccycle3,win,NIL,[GA_DISABLED, FALSE, GTCY_ACTIVE, 1])
IF play3control=2 THEN Gt_SetGadgetAttrsA(ccycle3,win,NIL,[GA_DISABLED, FALSE, GTCY_ACTIVE, 2])
IF play3control=3 THEN Gt_SetGadgetAttrsA(ccycle3,win,NIL,[GA_DISABLED, FALSE, GTCY_ACTIVE, 3])
IF (play1control=play2control) OR (play1control=play2control) OR (play1control=play3control) OR (play1control=play4control) OR (play2control=play3control) OR (play4control=play2control) OR (play3control=play4control) THEN noterminate3:=5 ELSE noterminate3:=0
CASE "q", "Q"
play4control:=play4control+1
IF play4control=4 THEN play4control:=0
IF play4control=0 THEN Gt_SetGadgetAttrsA(ccycle4,win,NIL,[GA_DISABLED, FALSE, GTCY_ACTIVE, 0])
IF play4control=1 THEN Gt_SetGadgetAttrsA(ccycle4,win,NIL,[GA_DISABLED, FALSE, GTCY_ACTIVE, 1])
IF play4control=2 THEN Gt_SetGadgetAttrsA(ccycle4,win,NIL,[GA_DISABLED, FALSE, GTCY_ACTIVE, 2])
IF play4control=3 THEN Gt_SetGadgetAttrsA(ccycle4,win,NIL,[GA_DISABLED, FALSE, GTCY_ACTIVE, 3])
IF (play1control=play2control) OR (play1control=play2control) OR (play1control=play3control) OR (play1control=play4control) OR (play2control=play3control) OR (play4control=play2control) OR (play3control=play4control) THEN noterminate3:=5 ELSE noterminate3:=0
CASE "s", "S"
IF noterminate3=0
  terminated3:=TRUE
saveprefs()
ENDIF
CASE "u", "U"
IF noterminate3=0 THEN terminated3:=TRUE
CASE "n", "N"
ActivateGadget(cstring,win,NIL)
CASE "a", "A"
ActivateGadget(cstring2,win,NIL)
CASE "m", "M"
ActivateGadget(cstring3,win,NIL)
CASE "e", "E"
ActivateGadget(cstring4,win,NIL)
  ENDSELECT
ENDPROC

PROC colourcontrol() HANDLE
  DEF glist4=NIL, my_gads4[9]:ARRAY OF LONG
sactive:=1
slider_levela:=col1r
slider_levelb:=col1g
slider_levelc:=col1b
ghostgadgets()

createAllGadgets4({glist4}, vi, topborder, my_gads4)  
mywin4:=OpenW(71,35,178,137,IDCMP_VANILLAKEY OR IDCMP_REFRESHWINDOW OR BUTTONIDCMP OR IDCMP_GADGETDOWN OR IDCMP_GADGETUP OR SLIDERIDCMP, WFLG_ACTIVATE OR WFLG_DRAGBAR, 'Colour Control', screen, $F, glist4, NIL)
SetTopaz(8) 
Gt_RefreshWindow(mywin4, NIL)
setlines()
drawcols()
 process_window_events4(mywin4, my_gads4)

EXCEPT DO  
IF mywin4 THEN CloseW(mywin4)
  FreeGadgets(glist4)
  ReThrow()
unghostgadgets()
ENDPROC

PROC createAllGadgets4(glistptr:PTR TO LONG, vi, topborder,
                      my_gads:PTR TO LONG)
  DEF ng:PTR TO newgadget
  gad4:=CreateContext(glistptr)

  ng:=[40, 20, 80, 12, '', topaz80,
       NIL, NIL, vi, 0]:newgadget

  ng.leftedge   := 39
  ng.topedge    := 68
  ng.width      := 100
  ng.height     := 12
  ng.gadgettext := '_R/r'
  ng.gadgetid   := MYGAD_SLIDER
  ng.flags      := PLACETEXT_RIGHT
  gad4:=CreateGadgetA(SLIDER_KIND, gad4, ng,
                                    [GTSL_MIN,         SLIDER_MIN,
                                     GTSL_MAX,         SLIDER_MAX,
                                     GTSL_LEVEL,       slider_levela,
                                     GTSL_LEVELFORMAT, '\d[3]',
                                     GTSL_MAXLEVELLEN, 10,
                                     GA_DISABLED,      FALSE,
                                     GT_UNDERSCORE,    "_",
                                     NIL])

  ng.leftedge   := 39
  ng.topedge    := 84
  ng.width      := 100
  ng.height     := 12
  ng.gadgettext := '_G/g'
  ng.gadgetid   := MYGAD_SLIDER2
  ng.flags      := PLACETEXT_RIGHT
  dslider2:=CreateGadgetA(SLIDER_KIND, gad4, ng,
                                    [GTSL_MIN,         SLIDER_MIN,
                                     GTSL_MAX,         SLIDER_MAX,
                                     GTSL_LEVEL,       slider_levelb,
                                     GTSL_LEVELFORMAT, '\d[3]',
                                     GTSL_MAXLEVELLEN, 10,
                                     GA_DISABLED,      FALSE,
                                     GT_UNDERSCORE,    "_",
                                     NIL])

  ng.leftedge   := 39
  ng.topedge    := 100
  ng.width      := 100
  ng.height     := 12
  ng.gadgettext := '_B/b'
  ng.gadgetid   := MYGAD_SLIDER3
  ng.flags      := PLACETEXT_RIGHT
  dslider3:=CreateGadgetA(SLIDER_KIND, dslider2, ng,
                                    [GTSL_MIN,         SLIDER_MIN,
                                     GTSL_MAX,         SLIDER_MAX,
                                     GTSL_LEVEL,       slider_levelc,
                                     GTSL_LEVELFORMAT, '\d[3]',
                                     GTSL_MAXLEVELLEN, 10,
                                     GA_DISABLED,      FALSE,
                                     GT_UNDERSCORE,    "_",
                                     NIL])

  ng.leftedge   := 8
  ng.topedge    := 116
  ng.width      := 79
  ng.height     := 15
  ng.gadgettext := '_Save'
  ng.gadgetid   := MYGAD4_BUTTON
  ng.flags      := 0
  dbutton:=CreateGadgetA(BUTTON_KIND, dslider3, ng, [GA_DISABLED, FALSE, GT_UNDERSCORE, "_"])

  ng.leftedge   := 91
  ng.topedge    := 116
  ng.width      := 79
  ng.height     := 15
  ng.gadgettext := '_Use'
  ng.gadgetid   := MYGAD4_BUTTON2
  ng.flags      := 0
  dbutton2:=CreateGadgetA(BUTTON_KIND, dbutton, ng, [GA_DISABLED, FALSE, GT_UNDERSCORE, "_"])

  ng.leftedge   := 20
  ng.topedge    := 52
  ng.width      := 21
  ng.height     := 12
  ng.gadgettext := '_1'
  ng.gadgetid   := MYGAD4_BUTTON3
  ng.flags      := 0
  dbutton3:=CreateGadgetA(BUTTON_KIND, dbutton2, ng, [GA_DISABLED, FALSE, GT_UNDERSCORE, "_"])

  ng.leftedge   := 58
  ng.topedge    := 52
  ng.width      := 21
  ng.height     := 12
  ng.gadgettext := '_2'
  ng.gadgetid   := MYGAD4_BUTTON4
  ng.flags      := 0
  dbutton4:=CreateGadgetA(BUTTON_KIND, dbutton3, ng, [GA_DISABLED, FALSE, GT_UNDERSCORE, "_"])

  ng.leftedge   := 98
  ng.topedge    := 52
  ng.width      := 21
  ng.height     := 12
  ng.gadgettext := '_3'
  ng.gadgetid   := MYGAD4_BUTTON5
  ng.flags      := 0
  dbutton5:=CreateGadgetA(BUTTON_KIND, dbutton4, ng, [GA_DISABLED, FALSE, GT_UNDERSCORE, "_"])

  ng.leftedge   := 138
  ng.topedge    := 52
  ng.width      := 21
  ng.height     := 12
  ng.gadgettext := '_4'
  ng.gadgetid   := MYGAD4_BUTTON6
  ng.flags      := 0
  dbutton6:=CreateGadgetA(BUTTON_KIND, dbutton5, ng, [GA_DISABLED, FALSE, GT_UNDERSCORE, "_"])

ENDPROC(gad4)

PROC process_window_events4(mywin4:PTR TO window, my_gads4:PTR TO LONG)

  DEF imsg:PTR TO intuimessage, imsgClass, imsgCode, gad4

  REPEAT
    Wait(Shl(1, mywin4.userport.sigbit))
    WHILE (terminated4=FALSE) AND (imsg:=Gt_GetIMsg(mywin4.userport))
      gad4:=imsg.iaddress

      imsgClass:=imsg.class
      imsgCode:=imsg.code

      Gt_ReplyIMsg(imsg)

      SELECT imsgClass
      CASE IDCMP_GADGETDOWN
        handleGadgetEvent4(mywin4, gad4, imsgCode, my_gads4)
      CASE IDCMP_MOUSEMOVE
        handleGadgetEvent4(mywin4, gad4, imsgCode, my_gads4)
      CASE IDCMP_GADGETUP
        handleGadgetEvent4(mywin4, gad4, imsgCode, my_gads4)
      CASE IDCMP_VANILLAKEY
        handleVanillaKey4(mywin4, imsgCode, my_gads4)
      CASE IDCMP_REFRESHWINDOW
        Gt_BeginRefresh(mywin4)
        Gt_EndRefresh(mywin4, TRUE)
      ENDSELECT
SetColour(screen,4,col1r,col1g,col1b)
SetColour(screen,5,col2r,col2g,col2b)
SetColour(screen,6,col3r,col3g,col3b)
SetColour(screen,7,col4r,col4g,col4b)

 ENDWHILE
  UNTIL terminated4
ENDPROC

PROC handleGadgetEvent4(win, gad:PTR TO gadget, code,
                       my_gads:PTR TO LONG)
  DEF id
IF sactive=1 THEN (col1r:=slider_levela) AND (col1g:=slider_levelb) AND (col1b:=slider_levelc)
IF sactive=2 THEN (col2r:=slider_levela) AND (col2g:=slider_levelb) AND (col2b:=slider_levelc)
IF sactive=3 THEN (col3r:=slider_levela) AND (col3g:=slider_levelb) AND (col3b:=slider_levelc)
IF sactive=4 THEN (col4r:=slider_levela) AND (col4g:=slider_levelb) AND (col4b:=slider_levelc)
  id:=gad.gadgetid
  SELECT id
CASE MYGAD4_BUTTON3
sactive:=1
slider_levela:=col1r
slider_levelb:=col1g
slider_levelc:=col1b
 Gt_SetGadgetAttrsA(gad4, mywin4, NIL, [GTSL_LEVEL, slider_levela, NIL])
 Gt_SetGadgetAttrsA(dslider2, mywin4, NIL, [GTSL_LEVEL, slider_levelb, NIL])
 Gt_SetGadgetAttrsA(dslider3, mywin4, NIL, [GTSL_LEVEL, slider_levelc, NIL])
  DrawBorder(mywin4.rport, shadowBorder, 12, 15)
  DrawBorder(mywin4.rport, shadowBorderC, 52, 15)
  DrawBorder(mywin4.rport, shadowBorderC, 92, 15)
  DrawBorder(mywin4.rport, shadowBorderC, 132, 15)
CASE MYGAD4_BUTTON4
sactive:=2
slider_levela:=col2r
slider_levelb:=col2g
slider_levelc:=col2b
 Gt_SetGadgetAttrsA(gad4, mywin4, NIL, [GTSL_LEVEL, slider_levela, NIL])
 Gt_SetGadgetAttrsA(dslider2, mywin4, NIL, [GTSL_LEVEL, slider_levelb, NIL])
 Gt_SetGadgetAttrsA(dslider3, mywin4, NIL, [GTSL_LEVEL, slider_levelc, NIL])
  DrawBorder(mywin4.rport, shadowBorderC, 12, 15)
  DrawBorder(mywin4.rport, shadowBorder, 52, 15)
  DrawBorder(mywin4.rport, shadowBorderC, 92, 15)
  DrawBorder(mywin4.rport, shadowBorderC, 132, 15)
CASE MYGAD4_BUTTON5
sactive:=3
slider_levela:=col3r
slider_levelb:=col3g
slider_levelc:=col3b
 Gt_SetGadgetAttrsA(gad4, mywin4, NIL, [GTSL_LEVEL, slider_levela, NIL])
 Gt_SetGadgetAttrsA(dslider2, mywin4, NIL, [GTSL_LEVEL, slider_levelb, NIL])
 Gt_SetGadgetAttrsA(dslider3, mywin4, NIL, [GTSL_LEVEL, slider_levelc, NIL])
    DrawBorder(mywin4.rport, shadowBorderC, 12, 15)
  DrawBorder(mywin4.rport, shadowBorderC, 52, 15)
  DrawBorder(mywin4.rport, shadowBorder, 92, 15)
  DrawBorder(mywin4.rport, shadowBorderC, 132, 15)
CASE MYGAD4_BUTTON6
sactive:=4
slider_levela:=col4r
slider_levelb:=col4g
slider_levelc:=col4b
 Gt_SetGadgetAttrsA(gad4, mywin4, NIL, [GTSL_LEVEL, slider_levela, NIL])
 Gt_SetGadgetAttrsA(dslider2, mywin4, NIL, [GTSL_LEVEL, slider_levelb, NIL])
 Gt_SetGadgetAttrsA(dslider3, mywin4, NIL, [GTSL_LEVEL, slider_levelc, NIL])
  
    DrawBorder(mywin4.rport, shadowBorderC, 12, 15)
  DrawBorder(mywin4.rport, shadowBorderC, 52, 15)
  DrawBorder(mywin4.rport, shadowBorderC, 92, 15)
  DrawBorder(mywin4.rport, shadowBorder, 132, 15)

   CASE MYGAD4_BUTTON
saveprefs()
  terminated4:=TRUE
CASE MYGAD4_BUTTON2
  terminated4:=TRUE
  CASE MYGAD_SLIDER
slider_levela:=code
  CASE MYGAD_SLIDER2
slider_levelb:=code
  CASE MYGAD_SLIDER3
    slider_levelc:=code
  ENDSELECT
ENDPROC

PROC handleVanillaKey4(win, code, my_gads:PTR TO LONG)
IF sactive=1 THEN (col1r:=slider_levela) AND (col1g:=slider_levelb) AND (col1b:=slider_levelc)
IF sactive=2 THEN (col2r:=slider_levela) AND (col2g:=slider_levelb) AND (col2b:=slider_levelc)
IF sactive=3 THEN (col3r:=slider_levela) AND (col3g:=slider_levelb) AND (col3b:=slider_levelc)
IF sactive=4 THEN (col4r:=slider_levela) AND (col4g:=slider_levelb) AND (col4b:=slider_levelc)
  SELECT "w" OF code
  CASE "R"
IF slider_levela<255 THEN slider_levela:=slider_levela+1
    Gt_SetGadgetAttrsA(gad4, mywin4, NIL,
                      [GTSL_LEVEL, slider_levela, NIL])

  CASE "r"
IF slider_levela>0 THEN slider_levela:=slider_levela-1    
Gt_SetGadgetAttrsA(gad4, mywin4, NIL,
                      [GTSL_LEVEL, slider_levela, NIL])

  CASE "G"
IF slider_levelb<255 THEN slider_levelb:=slider_levelb+1
    Gt_SetGadgetAttrsA(dslider2, mywin4, NIL,
                      [GTSL_LEVEL, slider_levelb, NIL])

  CASE "g"
IF slider_levelb>0 THEN slider_levelb:=slider_levelb-1    
    Gt_SetGadgetAttrsA(dslider2, mywin4, NIL,
                      [GTSL_LEVEL, slider_levelb, NIL])

  CASE "B"
IF slider_levelc<255 THEN slider_levelc:=slider_levelc+1
    Gt_SetGadgetAttrsA(dslider3, mywin4, NIL,
                      [GTSL_LEVEL, slider_levelc, NIL])
  CASE "b"
IF slider_levelc>0 THEN slider_levelc:=slider_levelc-1    
    Gt_SetGadgetAttrsA(dslider3, mywin4, NIL,
                      [GTSL_LEVEL, slider_levelc, NIL])

CASE "s", "S"
  terminated4:=TRUE
saveprefs()
CASE "u", "U"
terminated4:=TRUE
CASE "1"
sactive:=1
slider_levela:=col1r
slider_levelb:=col1g
slider_levelc:=col1b
 Gt_SetGadgetAttrsA(gad4, mywin4, NIL, [GTSL_LEVEL, slider_levela, NIL])
 Gt_SetGadgetAttrsA(dslider2, mywin4, NIL, [GTSL_LEVEL, slider_levelb, NIL])
 Gt_SetGadgetAttrsA(dslider3, mywin4, NIL, [GTSL_LEVEL, slider_levelc, NIL])
  
    DrawBorder(mywin4.rport, shadowBorder, 12, 15)
  DrawBorder(mywin4.rport, shadowBorderC, 52, 15)
  DrawBorder(mywin4.rport, shadowBorderC, 92, 15)
  DrawBorder(mywin4.rport, shadowBorderC, 132, 15)
CASE "2"
sactive:=2
slider_levela:=col2r
slider_levelb:=col2g
slider_levelc:=col2b
 Gt_SetGadgetAttrsA(gad4, mywin4, NIL, [GTSL_LEVEL, slider_levela, NIL])
 Gt_SetGadgetAttrsA(dslider2, mywin4, NIL, [GTSL_LEVEL, slider_levelb, NIL])
 Gt_SetGadgetAttrsA(dslider3, mywin4, NIL, [GTSL_LEVEL, slider_levelc, NIL])
    DrawBorder(mywin4.rport, shadowBorderC, 12, 15)
  DrawBorder(mywin4.rport, shadowBorder, 52, 15)
  DrawBorder(mywin4.rport, shadowBorderC, 92, 15)
  DrawBorder(mywin4.rport, shadowBorderC, 132, 15)
  
CASE "3"
sactive:=3
slider_levela:=col3r
slider_levelb:=col3g
slider_levelc:=col3b
 Gt_SetGadgetAttrsA(gad4, mywin4, NIL, [GTSL_LEVEL, slider_levela, NIL])
 Gt_SetGadgetAttrsA(dslider2, mywin4, NIL, [GTSL_LEVEL, slider_levelb, NIL])
 Gt_SetGadgetAttrsA(dslider3, mywin4, NIL, [GTSL_LEVEL, slider_levelc, NIL])
  
    DrawBorder(mywin4.rport, shadowBorderC, 12, 15)
  DrawBorder(mywin4.rport, shadowBorderC, 52, 15)
  DrawBorder(mywin4.rport, shadowBorder, 92, 15)
  DrawBorder(mywin4.rport, shadowBorderC, 132, 15)
CASE "4"
sactive:=4
slider_levela:=col4r
slider_levelb:=col4g
slider_levelc:=col4b
 Gt_SetGadgetAttrsA(gad4, mywin4, NIL, [GTSL_LEVEL, slider_levela, NIL])
 Gt_SetGadgetAttrsA(dslider2, mywin4, NIL, [GTSL_LEVEL, slider_levelb, NIL])
 Gt_SetGadgetAttrsA(dslider3, mywin4, NIL, [GTSL_LEVEL, slider_levelc, NIL])
  
    DrawBorder(mywin4.rport, shadowBorderC, 12, 15)
  DrawBorder(mywin4.rport, shadowBorderC, 52, 15)
  DrawBorder(mywin4.rport, shadowBorderC, 92, 15)
  DrawBorder(mywin4.rport, shadowBorder, 132, 15)

  ENDSELECT
ENDPROC

PROC scorecard() HANDLE
  DEF glist5=NIL, mywin5=NIL:PTR TO window, my_gads5[6]:ARRAY OF LONG,
  gad5y1=28, lineloop5, posloop=0,
posfound=4, rank1, rank2, rank3, rank4, play[3]:STRING, 
 p1x1=53, p1x2, p2x1=53, p2x2, p3x1=53, p3x2, p4x1=53, p4x2
  createAllGadgets5({glist5}, vi, topborder, my_gads5)
  mywin5:=OpenW(77,53,164,113,IDCMP_VANILLAKEY OR IDCMP_REFRESHWINDOW OR BUTTONIDCMP OR IDCMP_GADGETDOWN OR IDCMP_GADGETUP, WFLG_ACTIVATE OR WFLG_DRAGBAR, 'Score Card', screen, $F, glist5, NIL)
  SetTopaz(8)
blocked5:=FALSE
FOR lineloop5:=1 TO 4
Line(33,gad5y1+1,33,gad5y1+10,1)
Line(32,gad5y1+1,32,gad5y1+11,1)
Line(32,gad5y1,110,gad5y1,1)
Line(110,gad5y1+1,110,gad5y1+10,2)
Line(111,gad5y1,111,gad5y1+10,2)
Line(33,gad5y1+11,111,gad5y1+11,2)

Line(117,gad5y1+1,117,gad5y1+10,1)
Line(116,gad5y1+1,116,gad5y1+11,1)
Line(116,gad5y1,154,gad5y1,1)
Line(154,gad5y1+1,154,gad5y1+10,2)
Line(155,gad5y1,155,gad5y1+10,2)
Line(117,gad5y1+11,155,gad5y1+11,2)
gad5y1:=gad5y1+16
ENDFOR

Colour(2)
TextF(7,22,'Pos')
TextF(48,22,'Player')
TextF(121,22,'Wins')
Colour(1)
TextF(11,36,'1:')
TextF(11,52,'2:')
TextF(11,68,'3:')
TextF(11,84,'4:')

Colour(3)
REPEAT
IF posloop=play4 THEN (rank4:=posfound) AND (posfound:=posfound-1)
IF posloop=play3 THEN (rank3:=posfound) AND (posfound:=posfound-1)
IF posloop=play2 THEN (rank2:=posfound) AND (posfound:=posfound-1)
IF posloop=play1 THEN (rank1:=posfound) AND (posfound:=posfound-1)
posloop:=posloop+1
UNTIL (posfound=0) OR (posloop=1000)

IF posloop=1000 THEN (blocked5:=TRUE) AND (Gt_SetGadgetAttrsA(ebutton, mywin5, NIL, [GA_DISABLED, TRUE, NIL]))
IF StrLen(name1)=7 THEN p1x1:=45
IF StrLen(name2)=7 THEN p2x1:=45
IF StrLen(name3)=7 THEN p3x1:=45
IF StrLen(name4)=7 THEN p4x1:=45
IF StrLen(name1)=6 THEN p1x1:=49
IF StrLen(name2)=6 THEN p2x1:=49
IF StrLen(name3)=6 THEN p3x1:=49
IF StrLen(name4)=6 THEN p4x1:=49
IF StrLen(name1)=5 THEN p1x1:=53
IF StrLen(name2)=5 THEN p2x1:=53
IF StrLen(name3)=5 THEN p3x1:=53
IF StrLen(name4)=5 THEN p4x1:=53
IF StrLen(name1)=4 THEN p1x1:=57
IF StrLen(name2)=4 THEN p2x1:=57
IF StrLen(name3)=4 THEN p3x1:=57
IF StrLen(name4)=4 THEN p4x1:=57
IF StrLen(name1)=3 THEN p1x1:=61
IF StrLen(name2)=3 THEN p2x1:=61
IF StrLen(name3)=3 THEN p3x1:=61
IF StrLen(name4)=3 THEN p4x1:=61
IF StrLen(name1)=2 THEN p1x1:=65
IF StrLen(name2)=2 THEN p2x1:=65
IF StrLen(name3)=2 THEN p3x1:=65
IF StrLen(name4)=2 THEN p4x1:=65
IF StrLen(name1)=1 THEN p1x1:=69
IF StrLen(name2)=1 THEN p2x1:=69
IF StrLen(name3)=1 THEN p3x1:=69
IF StrLen(name4)=1 THEN p4x1:=69
IF play1<10 THEN p1x2:=132
IF play2<10 THEN p2x2:=132 
IF play3<10 THEN p3x2:=132 
IF play4<10 THEN p4x2:=132
IF (play1>9) AND (play1<100) THEN p1x2:=128
IF (play2>9) AND (play2<100) THEN p2x2:=128
IF (play3>9) AND (play3<100) THEN p3x2:=128
IF (play4>9) AND (play4<100) THEN p4x2:=128
IF (play1>99) THEN p1x2:=124
IF (play2>99) THEN p2x2:=124
IF (play3>99) THEN p3x2:=124
IF (play4>99) THEN p4x2:=124

IF rank1=1 
TextF(p1x1,36,name1)
StringF(play,'\d',play1)
TextF(p1x2,36,play)
ENDIF

IF rank2=1 
TextF(p2x1,36,name2)
StringF(play,'\d',play2)
TextF(p2x2,36,play)
ENDIF

IF rank3=1 
TextF(p3x1,36,name3)
StringF(play,'\d',play3)
TextF(p3x2,36,play)
ENDIF
IF rank4=1 
TextF(p4x1,36,name4)
StringF(play,'\d',play4)
TextF(p4x2,36,play)
ENDIF

IF rank1=2 
TextF(p1x1,52,name1)
StringF(play,'\d',play1)
TextF(p1x2,52,play)
ENDIF
IF rank2=2 
TextF(p2x1,52,name2)
StringF(play,'\d',play2)
TextF(p2x2,52,play)
ENDIF
IF rank3=2 
TextF(p3x1,52,name3)
StringF(play,'\d',play3)
TextF(p3x2,52,play)
ENDIF
IF rank4=2 
TextF(p4x1,52,name4)
StringF(play,'\d',play4)
TextF(p4x2,52,play)
ENDIF

IF rank1=3 
TextF(p1x1,68,name1)
StringF(play,'\d',play1)
TextF(p1x2,68,play)
ENDIF
IF rank2=3 
TextF(p2x1,68,name2)
StringF(play,'\d',play2)
TextF(p2x2,68,play)
ENDIF
IF rank3=3 
TextF(p3x1,68,name3)
StringF(play,'\d',play3)
TextF(p3x2,68,play)
ENDIF
IF rank4=3 
TextF(p4x1,68,name4)
StringF(play,'\d',play4)
TextF(p4x2,68,play)
ENDIF

IF rank1=4 
TextF(p1x1,84,name1)
StringF(play,'\d',play1)
TextF(p1x2,84,play)
ENDIF
IF rank2=4 
TextF(p2x1,84,name2)
StringF(play,'\d',play2)
TextF(p2x2,84,play)
ENDIF
IF rank3=4 
TextF(p3x1,84,name3)
StringF(play,'\d',play3)
TextF(p3x2,84,play)
ENDIF
IF rank4=4 
TextF(p4x1,84,name4)
StringF(play,'\d',play4)
TextF(p4x2,84,play)
ENDIF

  process_window_events5(mywin5, my_gads5)

EXCEPT DO  
IF mywin5 THEN CloseW(mywin5)
  FreeGadgets(glist5)
  ReThrow()
ENDPROC


PROC createAllGadgets5(glistptr:PTR TO LONG, vi, topborder,
                      my_gads:PTR TO LONG)
  DEF ng:PTR TO newgadget

  gad5:=CreateContext(glistptr)

  ng:=[140, (20+topborder), 200, 12, '_Volume:   ', topaz80,
        NIL, NG_HIGHLABEL, vi, 0]:newgadget

  ng.leftedge   := 8
  ng.topedge    := 92
  ng.width      := 72
  ng.height     := 15
  ng.gadgettext := '_Play'
  ng.gadgetid   := MYGAD5_BUTTON2
  ng.flags      := PLACETEXT_IN
  ebutton:=CreateGadgetA(BUTTON_KIND, gad5, ng, [GA_DISABLED, FALSE, GT_UNDERSCORE, "_"])

  ng.leftedge   := 84
  ng.topedge    := 92
  ng.width      := 72
  ng.height     := 15
  ng.gadgettext := '_Quit'
  ng.gadgetid   := MYGAD5_BUTTON
  ng.flags      := PLACETEXT_IN
  ebutton2:=CreateGadgetA(BUTTON_KIND, ebutton, ng, [GA_DISABLED, FALSE, GT_UNDERSCORE, "_"])

ENDPROC(gad5)

PROC process_window_events5(mywin5:PTR TO window, my_gads5:PTR TO LONG)
  DEF imsg:PTR TO intuimessage, imsgClass, imsgCode, gad5
  REPEAT
    Wait(Shl(1, mywin5.userport.sigbit))
    WHILE (terminated5=FALSE) AND (imsg:=Gt_GetIMsg(mywin5.userport))
      gad5:=imsg.iaddress

      imsgClass:=imsg.class
      imsgCode:=imsg.code

      Gt_ReplyIMsg(imsg)

      SELECT imsgClass
      CASE IDCMP_GADGETDOWN
        handleGadgetEvent5(mywin5, gad5, imsgCode, my_gads5)
      CASE IDCMP_GADGETUP
        handleGadgetEvent5(mywin5, gad5, imsgCode, my_gads5)
      CASE IDCMP_VANILLAKEY
        handleVanillaKey5(mywin5, imsgCode, my_gads5)
      CASE IDCMP_REFRESHWINDOW
        Gt_BeginRefresh(mywin5)
        Gt_EndRefresh(mywin5, TRUE)
      ENDSELECT

 ENDWHILE
  UNTIL terminated5
ENDPROC

PROC handleGadgetEvent5(win, gad:PTR TO gadget, code,
                       my_gads:PTR TO LONG)
  DEF id
  id:=gad.gadgetid
  SELECT id
CASE MYGAD5_BUTTON
terminated5:=TRUE
CASE MYGAD5_BUTTON2
terminated5:=TRUE
playon:=TRUE
ENDSELECT
ENDPROC

PROC handleVanillaKey5(win, code, my_gads:PTR TO LONG)
  SELECT "w" OF code
  CASE "Q", "q"
terminated5:=TRUE
  CASE "P", "p"
IF blocked5=FALSE
terminated5:=TRUE
playon:=TRUE
ENDIF
ENDSELECT
ENDPROC

PROC saveprefs() HANDLE
DEF savedata[500]:STRING,length, csol1r[3]:STRING, csol1g[3]:STRING, csol1b[3]:STRING, csol2r[3]:STRING, csol2g[3]:STRING, csol2b[3]:STRING, csol3r[3]:STRING, csol3g[3]:STRING, csol3b[3]:STRING, csol4r[3]:STRING, csol4g[3]:STRING, csol4b[3]:STRING, cputemp[3]:STRING

StringF(csol1r,'\d',col1r)
StringF(csol1g,'\d',col1g)
StringF(csol1b,'\d',col1b)
StringF(csol2r,'\d',col2r)
StringF(csol2g,'\d',col2g)
StringF(csol2b,'\d',col2b)
StringF(csol3r,'\d',col3r)
StringF(csol3g,'\d',col3g)
StringF(csol3b,'\d',col3b)
StringF(csol4r,'\d',col4r)
StringF(csol4g,'\d',col4g)
StringF(csol4b,'\d',col4b)
StringF(cputemp,'\d',stupid)

StringF(savedata,'Game:\d\d\d\d\nPlayer:\d\d\d\d\nNo:\d\nCol1:\s,\s,\s\nCol2:\s,\s,\s\nCol3:\s,\s,\s\nCol4:\s,\s,\s\nName1:\s\nName2:\s\nName3:\s\nName4:\s\nSwoo:\d\nCpu:\s\n\nLightSpeed2 Copyright © 1998 Micro Design (Richard West & Daniel Pimley)\n\nend.',accelaration,obstacles+2,wrap+2,blocks+2,play1control,play2control,play3control,play4control,playerno, csol1r, csol1g, csol1b, csol2r, csol2g, csol2b, csol3r, csol3g, csol3b, csol4r,  csol4g, csol4b, tname1, tname2, tname3, tname4, swooshy+2, cputemp)

length:=StrLen(savedata)
writefile('PROGDIR:light.prefs',savedata,length)
EXCEPT DO
IF exception
   request(' Could Not Save Prefs File\n\n(Disk/File Write Protected?)',1,'Continue')
ENDIF
ENDPROC

PROC loadprefs()
DEF m,l,n,list,ioerror=0,temp[1]:STRING,a,temppal[4]:STRING,  temppal2[4]:STRING, counta=0,
countb=0, countc, lenplea
m,l:=readfile('PROGDIR:light.prefs')
  n:=countstrings(m,l)
  list:=stringsinfile(m,l,n)
IF StrCmp(m,'Game:',5)=FALSE THEN ioerror:=5
IF Not (StrLen(m)=9) THEN ioerror:=5
IF ioerror=0
MidStr(temp,m,5,1)
accelaration:=Val(temp, NIL)
MidStr(temp,m,6,1)
IF StrCmp(temp,'1',1) THEN obstacles:=TRUE ELSE obstacles:=FALSE
MidStr(temp,m,7,1)
IF StrCmp(temp,'1',1) THEN wrap:=TRUE ELSE wrap:=FALSE
MidStr(temp,m,8,1)
IF StrCmp(temp,'1',1) THEN blocks:=TRUE ELSE blocks:=FALSE
m:=m+10
IF StrCmp(m,'Player:',7)=FALSE THEN JUMP ioerr
IF Not (StrLen(m)=11) THEN JUMP ioerr
MidStr(temp,m,7,1)
play1control:=Val(temp, NIL)
MidStr(temp,m,8,1)
play2control:=Val(temp, NIL)
MidStr(temp,m,9,1)
play3control:=Val(temp, NIL)
MidStr(temp,m,10,1)
play4control:=Val(temp, NIL)
IF (play1control=play2control) OR (play1control=play2control) OR (play1control=play3control) OR (play1control=play4control) OR (play2control=play3control) OR (play4control=play2control) OR (play3control=play4control) THEN JUMP ioerr
m:=m+12

IF StrCmp(m,'No:',3)=FALSE THEN JUMP ioerr
IF Not (StrLen(m)=4) THEN JUMP ioerr
MidStr(temp,m,3,1)
playerno:=Val(temp, NIL)

counta:=0
countb:=0
m:=m+5
IF StrCmp(m,'Col1:',5)=FALSE THEN JUMP ioerr
m:=m+5
counta:=InStr(m,',')
MidStr(temppal,m,0,counta)
col1r:=Val(temppal, NIL)
m:=m+counta+1
counta:=InStr(m,',')
MidStr(temppal,m,0,counta)
col1g:=Val(temppal, NIL)
m:=m+counta+1
counta:=StrLen(m)
MidStr(temppal,m,0,counta)
col1b:=Val(temppal, NIL)
m:=m+counta+1


IF StrCmp(m,'Col2:',5)=FALSE THEN JUMP ioerr
m:=m+5
counta:=InStr(m,',')
MidStr(temppal,m,0,counta)
col2r:=Val(temppal, NIL)
m:=m+counta+1
counta:=InStr(m,',')
MidStr(temppal,m,0,counta)
col2g:=Val(temppal, NIL)
m:=m+counta+1
counta:=StrLen(m)
MidStr(temppal,m,0,counta)
col2b:=Val(temppal, NIL)
m:=m+counta+1

IF StrCmp(m,'Col3:',5)=FALSE THEN JUMP ioerr
m:=m+5
counta:=InStr(m,',')
MidStr(temppal,m,0,counta)
col3r:=Val(temppal, NIL)
m:=m+counta+1
counta:=InStr(m,',')
MidStr(temppal,m,0,counta)
col3g:=Val(temppal, NIL)
m:=m+counta+1
counta:=StrLen(m)
MidStr(temppal,m,0,counta)
col3b:=Val(temppal, NIL)
m:=m+counta+1

IF StrCmp(m,'Col4:',5)=FALSE THEN JUMP ioerr
m:=m+5
counta:=InStr(m,',')
MidStr(temppal,m,0,counta)
col4r:=Val(temppal, NIL)
m:=m+counta+1
counta:=InStr(m,',')
MidStr(temppal,m,0,counta)
col4g:=Val(temppal, NIL)
m:=m+counta+1
counta:=StrLen(m)
MidStr(temppal,m,0,counta)
col4b:=Val(temppal, NIL)
m:=m+counta+1


IF StrCmp(m,'Name1:',6)=FALSE THEN JUMP ioerr
lenplea:=StrLen(m)
IF lenplea>13 THEN JUMP ioerr
MidStr(tname1,m,6,lenplea)
m:=m+lenplea+1
IF StrCmp(m,'Name2:',6)=FALSE THEN JUMP ioerr
lenplea:=StrLen(m)
IF lenplea>13 THEN JUMP ioerr
MidStr(tname2,m,6,lenplea)
m:=m+lenplea+1
IF StrCmp(m,'Name3:',6)=FALSE THEN JUMP ioerr
lenplea:=StrLen(m)
IF lenplea>13 THEN JUMP ioerr
MidStr(tname3,m,6,lenplea)
m:=m+lenplea+1
IF StrCmp(m,'Name4:',6)=FALSE THEN JUMP ioerr
lenplea:=StrLen(m)
IF lenplea>13 THEN JUMP ioerr
MidStr(tname4,m,6,lenplea)
m:=m+lenplea+1
IF StrCmp(m,'Swoo:',5)=FALSE THEN JUMP ioerr
MidStr(temp,m,5,1)
IF StrCmp(temp,'1',ALL)=TRUE THEN swooshy:=TRUE ELSE swooshy:=FALSE
m:=m+7

IF StrCmp(m,'Cpu:',4)=FALSE THEN JUMP ioerr
MidStr(temppal,m,4,StrLen(m))
stupid:=Val(temppal,NIL)
sliderb_level:=stupid

ELSE
ioerr:
col1r:=255 ; col1g:=255 ; col1b:=255
col2r:=255 ; col2g:=255 ; col2b:=165
col3r:=165 ; col3g:=255 ; col3b:=165
col4r:=255 ; col4g:=180 ; col4b:=180
swooshy:=TRUE
stupid:=70
playerno:=0
wrap:=TRUE
obstacles:=TRUE
blocks:=FALSE
accelaration:=1
play1control:=0
play2control:=1
play3control:=2
play4control:=3
StringF(tname1,'Jam') 
StringF(tname2,'Custard')
StringF(tname3,'Syrup')
StringF(tname4,'Treacle')
ENDIF
ENDPROC

PROC ghostgadgets()
InitRequester(myreq)
IF Request(myreq, mywin)
 RETURN TRUE
ELSE
 RETURN FALSE
ENDIF
ENDPROC

PROC unghostgadgets()
EndRequest(myreq, mywin)
ENDPROC

PROC drawcols()
  shineBorder:=[0, 0, 2, 0,
                RP_JAM1, 5, [0,0, 31,0, 31,31, 0,31, 0,0]:INT,
                NIL]:border
  shadowBorder:=[1, 1, 1, 0,
                 RP_JAM1, 5, [0,0, 31,0, 31,31, 0,31, 0,0]:INT,
                 shineBorder]:border
  shineBorderC:=[0, 0, 0, 0,
                RP_JAM1, 5, [0,0, 31,0, 31,31, 0,31, 0,0]:INT,
                NIL]:border
  shadowBorderC:=[1, 1, 0, 0,
                 RP_JAM1, 5, [0,0, 31,0, 31,31, 0,31, 0,0]:INT,
                 shineBorderC]:border

  DrawBorder(mywin4.rport, shadowBorder, 12, 15)

Line(162,77,169,77,1)
Line(162,94,169,94,1)
Line(162,109,169,109,1)


Box(18,21,38,41,1)
Box(58,21,78,41,1)
Box(98,21,118,41,1)
Box(138,21,158,41,1)
Box(23,26,33,36,4)
Box(63,26,73,36,5)
Box(103,26,113,36,6)
Box(143,26,153,36,7)
ENDPROC


PROC killmouse() 
        mouserequest.command:=IND_SETMPORT
        mouserequest.data:=[-1]:CHAR       
        mouserequest.length:=1
        DoIO(mouserequest)
restoremouse:=FALSE
ENDPROC

PROC instmouse() 
        mouserequest.command:=IND_SETMPORT
        mouserequest.data:=[0]:CHAR  
        mouserequest.length:=1
        DoIO(mouserequest)
restoremouse:=TRUE
ENDPROC

PROC gameinitial() 
  DEF joytrigger:gameporttrigger, joytriggerm:gameporttrigger

killmouse()
  exec:=execbase
  game_io_msg.mn.ln.type:=NT_UNKNOWN
  game_io_msgm.mn.ln.type:=NT_UNKNOWN

    set_controller_type(GPCT_ABSJOYSTICK, game_io_msg, 1)
    set_controller_type(GPCT_ABSJOYSTICK, game_io_msgm, 2)

    set_trigger_conditions(joytrigger, game_io_msg)
    set_trigger_conditions(joytriggerm, game_io_msgm)

    flush_buffer(game_io_msg)
    flush_buffer(game_io_msgm)

    processEvents(game_io_msg, game_msg_port, game_io_msgm, game_msg_portm)
    
free_gp_unit(game_io_msg, 1)
free_gp_unit(game_io_msgm, 2)

instmouse()
ENDPROC

PROC check_move(game_event:PTR TO inputevent)
  DEF timeout=FALSE

IF joy1loop=FALSE
  movex:=game_event.x
  movey:=game_event.y
ELSE
joy1loop:=FALSE
ENDIF
IF play1control=0 THEN hmove(movex, movey, 1)
IF play1control=1 THEN hmove(movex, movey, 2)
IF play1control=2 THEN hmove(movex, movey, 3)
IF play1control=3 THEN hmove(movex, movey, 4)
ENDPROC timeout


PROC check_movem(game_event:PTR TO inputevent)
  DEF timeout=FALSE

IF joy2loop=FALSE
  movex2:=game_event.x
  movey2:=game_event.y
ELSE 
joy2loop:=FALSE
ENDIF

IF play2control=0 THEN hmove(movex2, movey2, 1)
IF play2control=1 THEN hmove(movex2, movey2, 2)
IF play2control=2 THEN hmove(movex2, movey2, 3)
IF play2control=3 THEN hmove(movex2, movey2, 4)
ENDPROC timeout


PROC hmove(xmo, ymo, who)

IF who=1 
x:=x1 ; y:=y1 ; joy:=joy1 ; speed:=speed1 ; diel:=die1
ENDIF
IF who=2 
x:=x2 ; y:=y2 ; joy:=joy2 ; speed:=speed2 ; diel:=die2
ENDIF
IF who=3 
x:=x3 ; y:=y3 ; joy:=joy3 ; speed:=speed3 ; diel:=die3
ENDIF
IF who=4 
x:=x4 ; y:=y4 ; joy:=joy4 ; speed:=speed4 ; diel:=die4
ENDIF

IF playcount=4 THEN newgame:=FALSE
playcount:=playcount+1

IF diel=FALSE

IF newgame=FALSE
  IF (xmo=1) AND (ymo=0) AND Not ((joy=3))
      joy:=4
  ENDIF
  IF (xmo=-1) AND (ymo=0) AND Not ((joy=4))
      joy:=3
  ENDIF
  IF (ymo=1) AND (xmo=0) AND Not ((joy=1))
      joy:=2
  ENDIF
  IF (ymo=-1) AND (xmo=0) AND Not ((joy=2))
      joy:=1
  ENDIF
ELSE
IF (xmo=1) AND (ymo=0) THEN joy:=4
IF (xmo=-1) AND (ymo=0) THEN joy:=3
IF (xmo=0) AND (ymo=1) THEN joy:=2
IF (xmo=0) AND (ymo=-1) THEN joy:=1
IF who=1 THEN joy1:=joy
IF who=2 THEN joy2:=joy 
IF who=3 THEN joy3:=joy 
IF who=4 THEN joy4:=joy 
ENDIF


  IF joy=1 THEN y:=y-1
  IF joy=2 THEN y:=y+1
  IF joy=3 THEN x:=x-1
  IF joy=4 THEN x:=x+1

IF wrap=TRUE
  IF x<=4 THEN x:=313
  IF x>=314 THEN x:=5
  IF y<=0 THEN y:=243
  IF y>=244 THEN y:=1
ELSE
  IF (x<=4) OR (x>=314) OR (y<=0) OR (y>=244) 
die(who)
JUMP loopexit
ENDIF
ENDIF

IF speed=0
IF (checkcol(ReadPixel(hidden.rport,x,y)))=TRUE
die(who)
ELSE
  Plot(x,y,who+3)
ENDIF
ELSE
IF accelaration<>0 THEN noise(who)
IF accelaration=1
     IF joy=1 
      IF y-5<1
       tempy1:=y
   REPEAT
        IF (checkcol(ReadPixel(hidden.rport,x,tempy1)))=TRUE
           Line(x,y,x,tempy1+1,who+3)
           die(who) ; JUMP loopexit
          ENDIF
       tempy1:=tempy1-1
      UNTIL tempy1=0
         Line(x,y,x,1,who+3)
        y:=1
     ELSE
       tempy1:=y
      REPEAT
        IF (checkcol(ReadPixel(hidden.rport,x,tempy1)))=TRUE
           Line(x,y,x,tempy1+1,who+3)
           die(who) ; JUMP loopexit
          ENDIF
       tempy1:=tempy1-1
      UNTIL tempy1=(y-6)
      Line(x,y,x,y-5,who+3)
      y:=y-5
      ENDIF
     ENDIF


     IF joy=2 
      IF y+5>243
       tempy1:=y
   REPEAT
        IF (checkcol(ReadPixel(hidden.rport,x,tempy1)))=TRUE
           Line(x,y,x,tempy1-1,who+3)
           die(who) ; JUMP loopexit
          ENDIF
       tempy1:=tempy1+1
      UNTIL tempy1=244
      Line(x,y,x,243,who+3)
      y:=243
      ELSE
       tempy1:=y
      REPEAT
        IF (checkcol(ReadPixel(hidden.rport,x,tempy1)))=TRUE
           Line(x,y,x,tempy1-1,who+3)
           die(who) ; JUMP loopexit
          ENDIF
       tempy1:=tempy1+1
      UNTIL tempy1=(y+6)
      Line(x,y,x,y+5,who+3)
      y:=y+5
      ENDIF
     ENDIF

    IF joy=3
     IF x-5<5
       tempx1:=x
   REPEAT
        IF (checkcol(ReadPixel(hidden.rport,tempx1,y)))=TRUE
             Line(x,y,tempx1+1,y,who+3)
           die(who) ; JUMP loopexit
          ENDIF
       tempx1:=tempx1-1
      UNTIL tempx1=4

     Line(x,y,5,y,who+3)
     x:=5
     ELSE
       tempx1:=x
      REPEAT
        IF (checkcol(ReadPixel(hidden.rport,tempx1,y)))=TRUE
           Line(x,y,tempx1+1,y,who+3)
           die(who) ; JUMP loopexit
          ENDIF
       tempx1:=tempx1-1
      UNTIL tempx1=(x-6)
     Line(x,y,x-5,y,who+3)
     x:=x-5
     ENDIF
    ENDIF

     IF joy=4
      IF x+5>313
       tempx1:=x
   REPEAT
        IF (checkcol(ReadPixel(hidden.rport,tempx1,y)))=TRUE
           Line(x,y,tempx1-1,y,who+3)
           die(who) ; JUMP loopexit
          ENDIF
       tempx1:=tempx1+1
      UNTIL tempx1=314
       Line(x,y,313,y,who+3)
      x:=313
      ELSE
       tempx1:=x
      REPEAT
        IF (checkcol(ReadPixel(hidden.rport,tempx1,y)))=TRUE
           Line(x,y,tempx1-1,y,who+3)
           die(who) ; JUMP loopexit
          ENDIF
       tempx1:=tempx1+1
      UNTIL tempx1=(x+6)
      Line(x,y,x+5,y,who+3) 
      x:=x+5
      ENDIF
    ENDIF
ENDIF

IF accelaration=2
IF joy=4
tempy1:=y
tempy2:=y
obhity1:=FALSE
obhity2:=FALSE

REPEAT
tempy1:=tempy1+1
IF (checkcol(ReadPixel(hidden.rport,x-1,tempy1)))=TRUE THEN obhity1:=TRUE
UNTIL (tempy1=(y+5)) OR (obhity1=TRUE)
IF obhity1=TRUE THEN tempy1:=tempy1-1
REPEAT
tempy2:=tempy2-1
IF (checkcol(ReadPixel(hidden.rport,x-1,tempy2)))=TRUE THEN obhity2:=TRUE
UNTIL (tempy2=(y-5)) OR (obhity2=TRUE)
IF obhity2=TRUE THEN tempy2:=tempy2+1

Line(x-1,tempy1,x-1,tempy2, who+3)
speed:=1
ENDIF

IF joy=3
tempy1:=y
tempy2:=y
obhity1:=FALSE
obhity2:=FALSE

REPEAT
tempy1:=tempy1+1
IF (checkcol(ReadPixel(hidden.rport,x+1,tempy1)))=TRUE THEN obhity1:=TRUE
UNTIL (tempy1=(y+5)) OR (obhity1=TRUE)
IF obhity1=TRUE THEN tempy1:=tempy1-1
REPEAT
tempy2:=tempy2-1
IF (checkcol(ReadPixel(hidden.rport,x+1,tempy2)))=TRUE THEN obhity2:=TRUE
UNTIL (tempy2=(y-5)) OR (obhity2=TRUE)
IF obhity2=TRUE THEN tempy2:=tempy2+1

Line(x+1,tempy1,x+1,tempy2, who+3)
speed:=1


ENDIF

IF joy=1

tempy1:=x
tempy2:=x
obhity1:=FALSE
obhity2:=FALSE

REPEAT
tempy1:=tempy1+1
IF (checkcol(ReadPixel(hidden.rport,tempy1,y+1)))=TRUE THEN obhity1:=TRUE
UNTIL (tempy1=(x+5)) OR (obhity1=TRUE)
IF obhity1=TRUE THEN tempy1:=tempy1-1
REPEAT
tempy2:=tempy2-1
IF (checkcol(ReadPixel(hidden.rport,tempy2,y+1)))=TRUE THEN obhity2:=TRUE
UNTIL (tempy2=(x-5)) OR (obhity2=TRUE)
IF obhity2=TRUE THEN tempy2:=tempy2+1

Line(tempy1,y+1,tempy2,y+1, who+3)
speed:=1
ENDIF

IF joy=2

tempy1:=x
tempy2:=x
obhity1:=FALSE
obhity2:=FALSE

REPEAT
tempy1:=tempy1+1
IF (checkcol(ReadPixel(hidden.rport,tempy1,y-1)))=TRUE THEN obhity1:=TRUE
UNTIL (tempy1=(x+5)) OR (obhity1=TRUE)
IF obhity1=TRUE THEN tempy1:=tempy1-1
REPEAT
tempy2:=tempy2-1
IF (checkcol(ReadPixel(hidden.rport,tempy2,y-1)))=TRUE THEN obhity2:=TRUE
UNTIL (tempy2=(x-5)) OR (obhity2=TRUE)
IF obhity2=TRUE THEN tempy2:=tempy2+1

Line(tempy1,y-1,tempy2,y-1, who+3)
speed:=1
ENDIF

  Plot(x,y,who+3)
ENDIF

speed:=speed-1
ENDIF
ENDIF
loopexit:

IF swooshy=TRUE
IF (who=1) AND (joy1<>joy)
  playData(sampled,samplend,1500000,CHAN_LEFT1,20)
WaitTOF()
exitLoop(CHAN_LEFT1)
ENDIF
IF (who=2) AND (joy2<>joy)
  playData(sampled,samplend,1600000,CHAN_LEFT2,20)
WaitTOF()
exitLoop(CHAN_LEFT2)
ENDIF
IF (who=3) AND (joy3<>joy)
  playData(sampled,samplend,1700000,CHAN_RIGHT1,20)
WaitTOF()
exitLoop(CHAN_RIGHT1)
ENDIF
IF (who=4) AND (joy4<>joy)
  playData(sampled,samplend,1800000,CHAN_RIGHT2,20)
WaitTOF()
exitLoop(CHAN_RIGHT2)
ENDIF
ENDIF

IF who=1 
x1:=x ; y1:=y ; joy1:=joy ; speed1:=speed 
ENDIF
IF who=2 
x2:=x ; y2:=y ; joy2:=joy ; speed2:=speed 
ENDIF
IF who=3 
x3:=x ; y3:=y ; joy3:=joy ; speed3:=speed 
ENDIF
IF who=4 
x4:=x ; y4:=y ; joy4:=joy ; speed4:=speed 
ENDIF

ENDPROC

PROC calccomp()
DEF spec1y, spec1x, spec1rnd=0


IF cdie1=FALSE
options(1)

IF (accelaration=2) AND (limspeedc1<1)
spec1rnd:=Rnd(300)

IF spec1rnd=25
limspeedc1:=100

IF samplei
  playData(samplei,sampleni,150000,CHAN_LEFT1,40)
WaitTOF()
exitLoop(CHAN_LEFT1)
ENDIF
IF cway1=1
tempy1:=cx1
tempy2:=cx1
obhity1:=FALSE
obhity2:=FALSE
REPEAT
tempy1:=tempy1+1
IF (checkcol(ReadPixel(hidden.rport,tempy1,cy1+2)))=TRUE THEN obhity1:=TRUE
UNTIL (tempy1=(cx1+5)) OR (obhity1=TRUE)
IF obhity1=TRUE THEN tempy1:=tempy1-1
REPEAT
tempy2:=tempy2-1
IF (checkcol(ReadPixel(hidden.rport,tempy2,cy1+2)))=TRUE THEN obhity2:=TRUE
UNTIL (tempy2=(cx1-5)) OR (obhity2=TRUE)
IF obhity2=TRUE THEN tempy2:=tempy2+1
Line(tempy1,cy1+2,tempy2,cy1+2, 4)
ENDIF

IF cway1=3
tempy1:=cx1
tempy2:=cx1
obhity1:=FALSE
obhity2:=FALSE
REPEAT
tempy1:=tempy1+1
IF (checkcol(ReadPixel(hidden.rport,tempy1,cy1-2)))=TRUE THEN obhity1:=TRUE
UNTIL (tempy1=(cx1+5)) OR (obhity1=TRUE)
IF obhity1=TRUE THEN tempy1:=tempy1-1
REPEAT
tempy2:=tempy2-1
IF (checkcol(ReadPixel(hidden.rport,tempy2,cy1-2)))=TRUE THEN obhity2:=TRUE
UNTIL (tempy2=(cx1-5)) OR (obhity2=TRUE)
IF obhity2=TRUE THEN tempy2:=tempy2+1
Line(tempy1,cy1-2,tempy2,cy1-2, 4)
ENDIF

IF cway1=2
tempy1:=cy1
tempy2:=cy1
obhity1:=FALSE
obhity2:=FALSE
REPEAT
tempy1:=tempy1+1
IF (checkcol(ReadPixel(hidden.rport,cx1-2,tempy1)))=TRUE THEN obhity1:=TRUE
UNTIL (tempy1=(cy1+5)) OR (obhity1=TRUE)
IF obhity1=TRUE THEN tempy1:=tempy1-1
REPEAT
tempy2:=tempy2-1
IF (checkcol(ReadPixel(hidden.rport,cx1-2,tempy2)))=TRUE THEN obhity2:=TRUE
UNTIL (tempy2=(cy1-5)) OR (obhity2=TRUE)
IF obhity2=TRUE THEN tempy2:=tempy2+1
Line(cx1-2,tempy1,cx1-2,tempy2, 4)
ENDIF

IF cway1=4
tempy1:=cy1
tempy2:=cy1
obhity1:=FALSE
obhity2:=FALSE
REPEAT
tempy1:=tempy1+1
IF (checkcol(ReadPixel(hidden.rport,cx1+2,tempy1)))=TRUE THEN obhity1:=TRUE
UNTIL (tempy1=(cy1+5)) OR (obhity1=TRUE)
IF obhity1=TRUE THEN tempy1:=tempy1-1
REPEAT
tempy2:=tempy2-1
IF (checkcol(ReadPixel(hidden.rport,cx1+2,tempy2)))=TRUE THEN obhity2:=TRUE
UNTIL (tempy2=(cy1-5)) OR (obhity2=TRUE)
IF obhity2=TRUE THEN tempy2:=tempy2+1
Line(cx1+2,tempy1,cx1+2,tempy2, 4)
ENDIF
ENDIF
ELSE
limspeedc1:=limspeedc1-1
ENDIF

spec1rnd:=0
IF (limspeedc1<1) AND (accelaration=1)
spec1rnd:=Rnd(300) 
ELSE
limspeedc1:=limspeedc1-1
ENDIF

IF spec1rnd<>25 
        IF (checkcol(ReadPixel(hidden.rport,cx1,cy1)))=TRUE
            die(1)
           JUMP loopexitc1
          ENDIF
 Plot(cx1,cy1,4)
ELSE
limspeedc1:=100

     IF cway1=1 
      IF cy1-20<1
       spec1y:=cy1
   REPEAT
        IF (checkcol(ReadPixel(hidden.rport,cx1,spec1y)))=TRUE
           Line(cx1,cy1,cx1,spec1y+2,4)
           cy1:=spec1y+1
           JUMP loopexitc1
          ENDIF
       spec1y:=spec1y-1
      UNTIL spec1y=0
         Line(cx1,cy1,cx1,1,4)
        cy1:=1
     ELSE
       spec1y:=cy1
IF samplei
  playData(samplei,sampleni,150000,CHAN_LEFT1,40)
WaitTOF()
exitLoop(CHAN_LEFT1)
ENDIF
      REPEAT
        IF (checkcol(ReadPixel(hidden.rport,cx1,spec1y)))=TRUE
           Line(cx1,cy1,cx1,spec1y+1,4)
           cy1:=spec1y+1
           JUMP loopexitc1
          ENDIF
       spec1y:=spec1y-1
      UNTIL spec1y=(cy1-21)
      Line(cx1,cy1,cx1,cy1-20,4)
      cy1:=cy1-20
      ENDIF
     ENDIF

     IF cway1=2 
      IF cy1+20>243
       spec1y:=cy1
   REPEAT
        IF (checkcol(ReadPixel(hidden.rport,cx1,spec1y)))=TRUE
           Line(cx1,cy1,cx1,spec1y-1,4)
           cy1:=spec1y-1
           JUMP loopexitc1
          ENDIF
       spec1y:=spec1y+1
      UNTIL spec1y=244
      Line(cx1,cy1,cx1,243,4)
      cy1:=243
      ELSE
       spec1y:=cy1
IF samplei
  playData(samplei,sampleni,150000,CHAN_LEFT1,40)
WaitTOF()
exitLoop(CHAN_LEFT1)
ENDIF
      REPEAT
        IF (checkcol(ReadPixel(hidden.rport,cx1,spec1y)))=TRUE
           Line(cx1,cy1,cx1,spec1y-1,4)
                     cy1:=spec1y-1
           JUMP loopexitc1
          ENDIF
       spec1y:=spec1y+1
      UNTIL spec1y=(cy1+21)
      Line(cx1,cy1,cx1,cy1+20,4)
      cy1:=cy1+20
      ENDIF
     ENDIF

    IF cway1=3
     IF cx1-20<5
       spec1x:=cx1
   REPEAT
        IF (checkcol(ReadPixel(hidden.rport,spec1x,cy1)))=TRUE
           Line(cx1,cy1,spec1x+1,cy1,4)
             cx1:=spec1x+1
           JUMP loopexitc1
          ENDIF
       spec1x:=spec1x-1
      UNTIL spec1x=4

     Line(cx1,cy1,5,cy1,4)
     cx1:=5
     ELSE
IF samplei
  playData(samplei,sampleni,150000,CHAN_LEFT1,40)
WaitTOF()
exitLoop(CHAN_LEFT1)
ENDIF
       spec1x:=cx1
      REPEAT
        IF (checkcol(ReadPixel(hidden.rport,spec1x,cy1)))=TRUE
           Line(cx1,cy1,spec1x+1,cy1,4)
           cx1:=spec1x+1
           JUMP loopexitc1
          ENDIF
       spec1x:=spec1x-1
      UNTIL spec1x=(cx1-21)
     Line(cx1,cy1,cx1-20,cy1,4)
     cx1:=cx1-20
     ENDIF
    ENDIF

     IF cway1=4
      IF cx1+20>313
       spec1x:=cx1
   REPEAT
        IF (checkcol(ReadPixel(hidden.rport,spec1x,cy1)))=TRUE
           Line(cx1,cy1,spec1x-1,cy1,4)
           cx1:=spec1x-1
           JUMP loopexitc1
          ENDIF
       spec1x:=spec1x+1
      UNTIL spec1x=314
       Line(cx1,cy1,313,cy1,4)
      cx1:=313
      ELSE
       spec1x:=cx1
IF samplei
  playData(samplei,sampleni,150000,CHAN_LEFT1,40)
WaitTOF()
exitLoop(CHAN_LEFT1)
ENDIF
      REPEAT
        IF (checkcol(ReadPixel(hidden.rport,spec1x,cy1)))=TRUE
          Line(cx1,cy1,spec1x-1,cy1,4)
           cx1:=spec1x-1
           JUMP loopexitc1
          ENDIF
       spec1x:=spec1x+1
      UNTIL spec1x=(cx1+21)
      Line(cx1,cy1,cx1+20,cy1,4) 
      cx1:=cx1+20
      ENDIF
    ENDIF

ENDIF
ENDIF

loopexitc1:


IF cdie2=FALSE
options(2)

IF (accelaration=2) AND (limspeedc2<1)
spec1rnd:=Rnd(300)

IF spec1rnd=25
limspeedc2:=100

IF samplei
  
playData(samplei,sampleni,150000,CHAN_LEFT2,40)
WaitTOF()
exitLoop(CHAN_LEFT2)
ENDIF
IF cway2=1
tempy1:=cx2
tempy2:=cx2
obhity1:=FALSE
obhity2:=FALSE
REPEAT
tempy1:=tempy1+1
IF (checkcol(ReadPixel(hidden.rport,tempy1,cy2+2)))=TRUE THEN obhity1:=TRUE
UNTIL (tempy1=(cx2+5)) OR (obhity1=TRUE)
IF obhity1=TRUE THEN tempy1:=tempy1-1
REPEAT
tempy2:=tempy2-1
IF (checkcol(ReadPixel(hidden.rport,tempy2,cy2+2)))=TRUE THEN obhity2:=TRUE
UNTIL (tempy2=(cx2-5)) OR (obhity2=TRUE)
IF obhity2=TRUE THEN tempy2:=tempy2+1
Line(tempy1,cy2+2,tempy2,cy2+2, 5)
ENDIF

IF cway2=3
tempy1:=cx2
tempy2:=cx2
obhity1:=FALSE
obhity2:=FALSE
REPEAT
tempy1:=tempy1+1
IF (checkcol(ReadPixel(hidden.rport,tempy1,cy2-2)))=TRUE THEN obhity1:=TRUE
UNTIL (tempy1=(cx2+5)) OR (obhity1=TRUE)
IF obhity1=TRUE THEN tempy1:=tempy1-1
REPEAT
tempy2:=tempy2-1
IF (checkcol(ReadPixel(hidden.rport,tempy2,cy2-2)))=TRUE THEN obhity2:=TRUE
UNTIL (tempy2=(cx2-5)) OR (obhity2=TRUE)
IF obhity2=TRUE THEN tempy2:=tempy2+1
Line(tempy1,cy2-2,tempy2,cy2-2, 5)
ENDIF

IF cway2=2
tempy1:=cy2
tempy2:=cy2
obhity1:=FALSE
obhity2:=FALSE
REPEAT
tempy1:=tempy1+1
IF (checkcol(ReadPixel(hidden.rport,cx2-2,tempy1)))=TRUE THEN obhity1:=TRUE
UNTIL (tempy1=(cy2+5)) OR (obhity1=TRUE)
IF obhity1=TRUE THEN tempy1:=tempy1-1
REPEAT
tempy2:=tempy2-1
IF (checkcol(ReadPixel(hidden.rport,cx2-2,tempy2)))=TRUE THEN obhity2:=TRUE
UNTIL (tempy2=(cy2-5)) OR (obhity2=TRUE)
IF obhity2=TRUE THEN tempy2:=tempy2+1
Line(cx2-2,tempy1,cx2-2,tempy2, 5)
ENDIF

IF cway2=4
tempy1:=cy2
tempy2:=cy2
obhity1:=FALSE
obhity2:=FALSE
REPEAT
tempy1:=tempy1+1
IF (checkcol(ReadPixel(hidden.rport,cx2+2,tempy1)))=TRUE THEN obhity1:=TRUE
UNTIL (tempy1=(cy2+5)) OR (obhity1=TRUE)
IF obhity1=TRUE THEN tempy1:=tempy1-1
REPEAT
tempy2:=tempy2-1
IF (checkcol(ReadPixel(hidden.rport,cx2+2,tempy2)))=TRUE THEN obhity2:=TRUE
UNTIL (tempy2=(cy2-5)) OR (obhity2=TRUE)
IF obhity2=TRUE THEN tempy2:=tempy2+1
Line(cx2+2,tempy1,cx2+2,tempy2, 5)
ENDIF
ENDIF
ELSE
limspeedc2:=limspeedc2-1
ENDIF

spec1rnd:=0

IF (limspeedc2<1) AND (accelaration=1)
spec1rnd:=Rnd(300) 
ELSE
limspeedc2:=limspeedc2-1
ENDIF

IF spec1rnd<>25 
        IF (checkcol(ReadPixel(hidden.rport,cx2,cy2)))=TRUE
            die(2)
           JUMP loopexitc2
          ENDIF
 Plot(cx2,cy2,5)
ELSE
limspeedc2:=100

     IF cway2=1 
      IF cy2-20<1
       spec1y:=cy2
   REPEAT
        IF (checkcol(ReadPixel(hidden.rport,cx2,spec1y)))=TRUE
           Line(cx2,cy2,cx2,spec1y+1,5)
           cy2:=spec1y+1            
           JUMP loopexitc2
          ENDIF
       spec1y:=spec1y-1
      UNTIL spec1y=0
         Line(cx2,cy2,cx2,1,5)
        cy2:=1
     ELSE
       spec1y:=cy2
IF samplei

  playData(samplei,sampleni,150000,CHAN_LEFT2,40)
WaitTOF()
exitLoop(CHAN_LEFT2)
ENDIF
      REPEAT
        IF (checkcol(ReadPixel(hidden.rport,cx2,spec1y)))=TRUE
           Line(cx2,cy2,cx2,spec1y+1,5)
           cy2:=spec1y+1
           JUMP loopexitc2
          ENDIF
       spec1y:=spec1y-1
      UNTIL spec1y=(cy2-21)
      Line(cx2,cy2,cx2,cy2-20,5)
      cy2:=cy2-20
      ENDIF
     ENDIF

     IF cway2=2 
      IF cy2+20>243
       spec1y:=cy2
   REPEAT
        IF (checkcol(ReadPixel(hidden.rport,cx2,spec1y)))=TRUE
           Line(cx2,cy2,cx2,spec1y-1,5)
           cy2:=spec1y-1
           JUMP loopexitc1
          ENDIF
       spec1y:=spec1y+1
      UNTIL spec1y=244
      Line(cx2,cy2,cx2,243,5)
      cy2:=243
      ELSE
       spec1y:=cy2
IF samplei

  playData(samplei,sampleni,150000,CHAN_LEFT2,40)
WaitTOF()
exitLoop(CHAN_LEFT2)
ENDIF
      REPEAT
        IF (checkcol(ReadPixel(hidden.rport,cx2,spec1y)))=TRUE
           Line(cx2,cy2,cx2,spec1y-1,5)
           cy2:=spec1y-1
           JUMP loopexitc2
          ENDIF
       spec1y:=spec1y+1
      UNTIL spec1y=(cy2+21)
      Line(cx2,cy2,cx2,cy2+20,5)
      cy2:=cy2+20
      ENDIF
     ENDIF

    IF cway2=3
     IF cx2-20<5
       spec1x:=cx2
   REPEAT
        IF (checkcol(ReadPixel(hidden.rport,spec1x,cy2)))=TRUE
           Line(cx2,cy2,spec1x+1,cy2,5)
           cx2:=spec1x+1
           JUMP loopexitc2
          ENDIF
       spec1x:=spec1x-1
      UNTIL spec1x=4

     Line(cx2,cy2,5,cy2,5)
     cx2:=5
     ELSE
       spec1x:=cx2
IF samplei

  playData(samplei,sampleni,150000,CHAN_LEFT2,40)
WaitTOF()
exitLoop(CHAN_LEFT2)
ENDIF
      REPEAT
        IF (checkcol(ReadPixel(hidden.rport,spec1x,cy2)))=TRUE
           Line(cx2,cy2,spec1x+1,cy2,5)
           cx2:=spec1x+1
           JUMP loopexitc2
          ENDIF
       spec1x:=spec1x-1
      UNTIL spec1x=(cx2-21)
     Line(cx2,cy2,cx2-20,cy2,5)
     cx2:=cx2-20
     ENDIF
    ENDIF

     IF cway2=4
      IF cx2+20>313
       spec1x:=cx2
   REPEAT
        IF (checkcol(ReadPixel(hidden.rport,spec1x,cy2)))=TRUE
           Line(cx2,cy2,spec1x-1,cy2,5)
           cx2:=spec1x-1
           JUMP loopexitc2
          ENDIF
       spec1x:=spec1x+1
      UNTIL spec1x=314
       Line(cx2,cy2,313,cy2,5)
      cx2:=313
      ELSE
       spec1x:=cx2
IF samplei

  playData(samplei,sampleni,150000,CHAN_LEFT2,40)
WaitTOF()
exitLoop(CHAN_LEFT2)
ENDIF
      REPEAT
        IF (checkcol(ReadPixel(hidden.rport,spec1x,cy2)))=TRUE
           Line(cx2,cy2,spec1x-1,cy2,5)
           cx2:=spec1x-1
           JUMP loopexitc2
          ENDIF
       spec1x:=spec1x+1
      UNTIL spec1x=(cx2+21)
      Line(cx2,cy2,cx2+20,cy2,5) 
      cx2:=cx2+20
      ENDIF
    ENDIF

ENDIF
ENDIF

loopexitc2:

IF cdie3=FALSE
options(3)
 
IF (accelaration=2) AND (limspeedc3<1)
spec1rnd:=Rnd(300)

IF spec1rnd=25
limspeedc3:=100

IF samplei

  playData(samplei,sampleni,150000,CHAN_RIGHT1,40)
WaitTOF()
exitLoop(CHAN_RIGHT1)
ENDIF
IF cway3=1
tempy1:=cx3
tempy2:=cx3
obhity1:=FALSE
obhity2:=FALSE
REPEAT
tempy1:=tempy1+1
IF (checkcol(ReadPixel(hidden.rport,tempy1,cy3+2)))=TRUE THEN obhity1:=TRUE
UNTIL (tempy1=(cx3+5)) OR (obhity1=TRUE)
IF obhity1=TRUE THEN tempy1:=tempy1-1
REPEAT
tempy2:=tempy2-1
IF (checkcol(ReadPixel(hidden.rport,tempy2,cy3+2)))=TRUE THEN obhity2:=TRUE
UNTIL (tempy2=(cx3-5)) OR (obhity2=TRUE)
IF obhity2=TRUE THEN tempy2:=tempy2+1
Line(tempy1,cy3+2,tempy2,cy3+2, 6)
ENDIF

IF cway3=3
tempy1:=cx3
tempy2:=cx3
obhity1:=FALSE
obhity2:=FALSE
REPEAT
tempy1:=tempy1+1
IF (checkcol(ReadPixel(hidden.rport,tempy1,cy3-2)))=TRUE THEN obhity1:=TRUE
UNTIL (tempy1=(cx3+5)) OR (obhity1=TRUE)
IF obhity1=TRUE THEN tempy1:=tempy1-1
REPEAT
tempy2:=tempy2-1
IF (checkcol(ReadPixel(hidden.rport,tempy2,cy3-2)))=TRUE THEN obhity2:=TRUE
UNTIL (tempy2=(cx3-5)) OR (obhity2=TRUE)
IF obhity2=TRUE THEN tempy2:=tempy2+1
Line(tempy1,cy3-2,tempy2,cy3-2, 6)
ENDIF

IF cway3=2
tempy1:=cy3
tempy2:=cy3
obhity1:=FALSE
obhity2:=FALSE
REPEAT
tempy1:=tempy1+1
IF (checkcol(ReadPixel(hidden.rport,cx3-2,tempy1)))=TRUE THEN obhity1:=TRUE
UNTIL (tempy1=(cy3+5)) OR (obhity1=TRUE)
IF obhity1=TRUE THEN tempy1:=tempy1-1
REPEAT
tempy2:=tempy2-1
IF (checkcol(ReadPixel(hidden.rport,cx3-2,tempy2)))=TRUE THEN obhity2:=TRUE
UNTIL (tempy2=(cy3-5)) OR (obhity2=TRUE)
IF obhity2=TRUE THEN tempy2:=tempy2+1
Line(cx3-2,tempy1,cx3-2,tempy2, 6)
ENDIF

IF cway3=4
tempy1:=cy3
tempy2:=cy3
obhity1:=FALSE
obhity2:=FALSE
REPEAT
tempy1:=tempy1+1
IF (checkcol(ReadPixel(hidden.rport,cx3+2,tempy1)))=TRUE THEN obhity1:=TRUE
UNTIL (tempy1=(cy3+5)) OR (obhity1=TRUE)
IF obhity1=TRUE THEN tempy1:=tempy1-1
REPEAT
tempy2:=tempy2-1
IF (checkcol(ReadPixel(hidden.rport,cx3+2,tempy2)))=TRUE THEN obhity2:=TRUE
UNTIL (tempy2=(cy3-5)) OR (obhity2=TRUE)
IF obhity2=TRUE THEN tempy2:=tempy2+1
Line(cx3+2,tempy1,cx3+2,tempy2, 6)
ENDIF
ENDIF
ELSE
limspeedc3:=limspeedc3-1
ENDIF
spec1rnd:=0

IF (limspeedc3<1) AND (accelaration=1)
spec1rnd:=Rnd(300) 
ELSE
limspeedc3:=limspeedc3-1
ENDIF

IF spec1rnd<>25 
        IF (checkcol(ReadPixel(hidden.rport,cx3,cy3)))=TRUE
            die(3)
           JUMP loopexitc3
          ENDIF
 Plot(cx3,cy3,6)
ELSE
limspeedc3:=100

     IF cway3=1 
      IF cy3-20<1
       spec1y:=cy3
   REPEAT
        IF (checkcol(ReadPixel(hidden.rport,cx3,spec1y)))=TRUE
           Line(cx3,cy3,cx3,spec1y+1,6)
           cy3:=spec1y+1
           JUMP loopexitc3
          ENDIF
       spec1y:=spec1y-1
      UNTIL spec1y=0
         Line(cx3,cy3,cx3,1,6)
        cy3:=1
     ELSE
       spec1y:=cy3
IF samplei

  playData(samplei,sampleni,150000,CHAN_RIGHT1,40)
WaitTOF()
exitLoop(CHAN_RIGHT1)
ENDIF
      REPEAT
        IF (checkcol(ReadPixel(hidden.rport,cx3,spec1y)))=TRUE
           Line(cx3,cy3,cx3,spec1y+1,6)
           cy3:=spec1y+1
           JUMP loopexitc3
          ENDIF
       spec1y:=spec1y-1
      UNTIL spec1y=(cy3-21)
      Line(cx3,cy3,cx3,cy3-20,6)
      cy3:=cy3-20
      ENDIF
     ENDIF

     IF cway3=2 
      IF cy3+20>243
       spec1y:=cy3
   REPEAT
        IF (checkcol(ReadPixel(hidden.rport,cx3,spec1y)))=TRUE
           Line(cx3,cy3,cx3,spec1y-1,6)
           cy3:=spec1y-1
           JUMP loopexitc3
          ENDIF
       spec1y:=spec1y+1
      UNTIL spec1y=244
      Line(cx3,cy3,cx3,243,6)
      cy3:=243
      ELSE
       spec1y:=cy3
IF samplei

  playData(samplei,sampleni,150000,CHAN_RIGHT1,40)
WaitTOF()
exitLoop(CHAN_RIGHT1)
ENDIF
      REPEAT
        IF (checkcol(ReadPixel(hidden.rport,cx3,spec1y)))=TRUE
           Line(cx3,cy3,cx3,spec1y-1,6)
           cy3:=spec1y-1
           JUMP loopexitc3
          ENDIF
       spec1y:=spec1y+1
      UNTIL spec1y=(cy3+21)
      Line(cx3,cy3,cx3,cy3+20,6)
      cy3:=cy3+20
      ENDIF
     ENDIF

    IF cway3=3
     IF cx3-20<5
       spec1x:=cx3
   REPEAT
        IF (checkcol(ReadPixel(hidden.rport,spec1x,cy3)))=TRUE
           Line(cx3,cy3,spec1x+1,cy3,6)
           cx3:=spec1x+1
           JUMP loopexitc3
          ENDIF
       spec1x:=spec1x-1
      UNTIL spec1x=4

     Line(cx3,cy3,5,cy3,6)
     cx3:=5
     ELSE
       spec1x:=cx3
IF samplei

  playData(samplei,sampleni,150000,CHAN_RIGHT1,40)
WaitTOF()
exitLoop(CHAN_RIGHT1)
ENDIF
      REPEAT
        IF (checkcol(ReadPixel(hidden.rport,spec1x,cy3)))=TRUE
           Line(cx3,cy3,spec1x+1,cy3,6)
           cx3:=spec1x+1
           JUMP loopexitc3
          ENDIF
       spec1x:=spec1x-1
      UNTIL spec1x=(cx3-21)
     Line(cx3,cy3,cx3-20,cy3,6)
     cx3:=cx3-20
     ENDIF
    ENDIF

     IF cway3=4
      IF cx3+20>313
       spec1x:=cx3
   REPEAT
        IF (checkcol(ReadPixel(hidden.rport,spec1x,cy3)))=TRUE
           Line(cx3,cy3,spec1x-1,cy3,6)
           cx3:=spec1x-1
           JUMP loopexitc3
          ENDIF
       spec1x:=spec1x+1
      UNTIL spec1x=314
       Line(cx3,cy3,313,cy3,6)
      cx3:=313
      ELSE
       spec1x:=cx3
IF samplei

  playData(samplei,sampleni,150000,CHAN_RIGHT1,40)
WaitTOF()
exitLoop(CHAN_RIGHT1)
ENDIF
      REPEAT
        IF (checkcol(ReadPixel(hidden.rport,spec1x,cy3)))=TRUE
           Line(cx3,cy3,spec1x-1,cy3,6)
           cx3:=spec1x-1
           JUMP loopexitc3
          ENDIF
       spec1x:=spec1x+1
      UNTIL spec1x=(cx3+21)
      Line(cx3,cy3,cx3+20,cy3,6) 
      cx3:=cx3+20
      ENDIF
    ENDIF

ENDIF
ENDIF

loopexitc3:


IF cdie4=FALSE
options(4)
  
IF (accelaration=2) AND (limspeedc4<1)
spec1rnd:=Rnd(300)

IF spec1rnd=25
limspeedc4:=100

IF samplei
  
playData(samplei,sampleni,150000,CHAN_RIGHT2,40)
WaitTOF()
exitLoop(CHAN_RIGHT2)
ENDIF
IF cway4=1
tempy1:=cx4
tempy2:=cx4
obhity1:=FALSE
obhity2:=FALSE
REPEAT
tempy1:=tempy1+1
IF (checkcol(ReadPixel(hidden.rport,tempy1,cy4+2)))=TRUE THEN obhity1:=TRUE
UNTIL (tempy1=(cx4+5)) OR (obhity1=TRUE)
IF obhity1=TRUE THEN tempy1:=tempy1-1
REPEAT
tempy2:=tempy2-1
IF (checkcol(ReadPixel(hidden.rport,tempy2,cy4+2)))=TRUE THEN obhity2:=TRUE
UNTIL (tempy2=(cx4-5)) OR (obhity2=TRUE)
IF obhity2=TRUE THEN tempy2:=tempy2+1
Line(tempy1,cy4+2,tempy2,cy4+2, 7)
ENDIF

IF cway4=3
tempy1:=cx4
tempy2:=cx4
obhity1:=FALSE
obhity2:=FALSE
REPEAT
tempy1:=tempy1+1
IF (checkcol(ReadPixel(hidden.rport,tempy1,cy4-2)))=TRUE THEN obhity1:=TRUE
UNTIL (tempy1=(cx4+5)) OR (obhity1=TRUE)
IF obhity1=TRUE THEN tempy1:=tempy1-1
REPEAT
tempy2:=tempy2-1
IF (checkcol(ReadPixel(hidden.rport,tempy2,cy4-2)))=TRUE THEN obhity2:=TRUE
UNTIL (tempy2=(cx4-5)) OR (obhity2=TRUE)
IF obhity2=TRUE THEN tempy2:=tempy2+1
Line(tempy1,cy4-2,tempy2,cy4-2, 7)
ENDIF

IF cway4=2
tempy1:=cy4
tempy2:=cy4
obhity1:=FALSE
obhity2:=FALSE
REPEAT
tempy1:=tempy1+1
IF (checkcol(ReadPixel(hidden.rport,cx4-2,tempy1)))=TRUE THEN obhity1:=TRUE
UNTIL (tempy1=(cy4+5)) OR (obhity1=TRUE)
IF obhity1=TRUE THEN tempy1:=tempy1-1
REPEAT
tempy2:=tempy2-1
IF (checkcol(ReadPixel(hidden.rport,cx4-2,tempy2)))=TRUE THEN obhity2:=TRUE
UNTIL (tempy2=(cy4-5)) OR (obhity2=TRUE)
IF obhity2=TRUE THEN tempy2:=tempy2+1
Line(cx4-2,tempy1,cx4-2,tempy2, 7)
ENDIF

IF cway4=4
tempy1:=cy4
tempy2:=cy4
obhity1:=FALSE
obhity2:=FALSE
REPEAT
tempy1:=tempy1+1
IF (checkcol(ReadPixel(hidden.rport,cx4+2,tempy1)))=TRUE THEN obhity1:=TRUE
UNTIL (tempy1=(cy4+5)) OR (obhity1=TRUE)
IF obhity1=TRUE THEN tempy1:=tempy1-1
REPEAT
tempy2:=tempy2-1
IF (checkcol(ReadPixel(hidden.rport,cx4+2,tempy2)))=TRUE THEN obhity2:=TRUE
UNTIL (tempy2=(cy4-5)) OR (obhity2=TRUE)
IF obhity2=TRUE THEN tempy2:=tempy2+1
Line(cx4+2,tempy1,cx4+2,tempy2, 7)
ENDIF
ENDIF
ELSE
limspeedc4:=limspeedc4-1
ENDIF
spec1rnd:=0




IF (limspeedc4<1) AND (accelaration=1)
spec1rnd:=Rnd(300) 
ELSE
limspeedc4:=limspeedc4-1

ENDIF

IF spec1rnd<>25 
        IF (checkcol(ReadPixel(hidden.rport,cx4,cy4)))=TRUE
            die(4)
           JUMP loopexitc4
          ENDIF
 Plot(cx4,cy4,7)
ELSE
limspeedc4:=100

     IF cway4=1 
      IF cy4-20<1
       spec1y:=cy4
   REPEAT
        IF (checkcol(ReadPixel(hidden.rport,cx4,spec1y)))=TRUE
           Line(cx4,cy4,cx4,spec1y+1,7)
            cy4:=spec1y+1
           JUMP loopexitc4
          ENDIF
       spec1y:=spec1y-1
      UNTIL spec1y=0
         Line(cx4,cy4,cx4,1,7)
        cy4:=1
     ELSE
       spec1y:=cy4
IF samplei

  playData(samplei,sampleni,150000,CHAN_RIGHT2,40)
WaitTOF()
exitLoop(CHAN_RIGHT2)
ENDIF
      REPEAT
        IF (checkcol(ReadPixel(hidden.rport,cx4,spec1y)))=TRUE
           Line(cx4,cy4,cx4,spec1y+1,7)
           cy4:=spec1y+1  
           JUMP loopexitc4
          ENDIF
       spec1y:=spec1y-1
      UNTIL spec1y=(cy4-21)
      Line(cx4,cy4,cx4,cy4-20,7)
      cy4:=cy4-20
      ENDIF
     ENDIF

     IF cway4=2 
      IF cy4+20>243
       spec1y:=cy4
   REPEAT
        IF (checkcol(ReadPixel(hidden.rport,cx4,spec1y)))=TRUE
           Line(cx4,cy4,cx4,spec1y-1,7)
           cy4:=spec1y-1
           JUMP loopexitc4
          ENDIF
       spec1y:=spec1y+1
      UNTIL spec1y=244
      Line(cx4,cy4,cx4,243,7)
      cy4:=243
      ELSE
       spec1y:=cy4
IF samplei

  playData(samplei,sampleni,150000,CHAN_RIGHT2,40)
WaitTOF()
exitLoop(CHAN_RIGHT2)
ENDIF
      REPEAT
        IF (checkcol(ReadPixel(hidden.rport,cx4,spec1y)))=TRUE
           Line(cx4,cy4,cx4,spec1y-1,7)
           cy4:=spec1y-1
           JUMP loopexitc4
          ENDIF
       spec1y:=spec1y+1
      UNTIL spec1y=(cy4+21)
      Line(cx4,cy4,cx4,cy4+20,7)
      cy4:=cy4+20
      ENDIF
     ENDIF

    IF cway4=3
     IF cx4-20<5
       spec1x:=cx4
   REPEAT
        IF (checkcol(ReadPixel(hidden.rport,spec1x,cy4)))=TRUE
           Line(cx4,cy4,spec1x+1,cy4,7)
           cx4:=spec1x+1
           JUMP loopexitc4
          ENDIF
       spec1x:=spec1x-1
      UNTIL spec1x=4

     Line(cx4,cy4,5,cy4,7)
     cx4:=5
     ELSE
       spec1x:=cx4
IF samplei

  playData(samplei,sampleni,150000,CHAN_RIGHT2,40)
WaitTOF()
exitLoop(CHAN_RIGHT2)
ENDIF
      REPEAT
        IF (checkcol(ReadPixel(hidden.rport,spec1x,cy4)))=TRUE
           Line(cx4,cy4,spec1x+1,cy4,7)
           cx4:=spec1x+1
           JUMP loopexitc4
          ENDIF
       spec1x:=spec1x-1
      UNTIL spec1x=(cx4-21)
     Line(cx4,cy4,cx4-20,cy4,7)
     cx4:=cx4-20
     ENDIF
    ENDIF

     IF cway4=4
      IF cx4+20>313
       spec1x:=cx4
   REPEAT
        IF (checkcol(ReadPixel(hidden.rport,spec1x,cy4)))=TRUE
           Line(cx4,cy4,spec1x-1,cy4,7)
           cx4:=spec1x-1
           JUMP loopexitc4
          ENDIF
       spec1x:=spec1x+1
      UNTIL spec1x=314
       Line(cx4,cy4,313,cy4,7)
      cx4:=313
      ELSE
       spec1x:=cx4
IF samplei

  playData(samplei,sampleni,150000,CHAN_RIGHT2,40)
WaitTOF()
exitLoop(CHAN_RIGHT2)
ENDIF
      REPEAT
        IF (checkcol(ReadPixel(hidden.rport,spec1x,cy4)))=TRUE
           Line(cx4,cy4,spec1x-1,cy4,7)
          cx4:=spec1x-1
           JUMP loopexitc4
          ENDIF
       spec1x:=spec1x+1
      UNTIL spec1x=(cx4+21)
      Line(cx4,cy4,cx4+20,cy4,7) 
      cx4:=cx4+20
      ENDIF
    ENDIF

ENDIF
ENDIF

loopexitc4:

ENDPROC

PROC options(cplay)
DEF decide, rand=0, go=FALSE, cx, cy, dier, cway


IF cplay=1 
cx:=cx1 ; cy:=cy1 ; dier:=1 ; cway:=cway1 ; cloop:=cloop1
ENDIF

IF cplay=2 
cx:=cx2 ; cy:=cy2 ; dier:=2 ; cway:=cway2 ; cloop:=cloop2
ENDIF

IF cplay=3 
cx:=cx3 ; cy:=cy3 ; dier:=3 ; cway:=cway3 ; cloop:=cloop3
ENDIF

IF cplay=4 
cx:=cx4 ; cy:=cy4 ; dier:=4 ; cway:=cway4 ; cloop:=cloop4
ENDIF

IF Not (stupid=9999)
cloop:=cloop+1
ENDIF

IF wrap=TRUE
  IF (cway=4) AND (cx=5) THEN cx:=314
  IF (cway=2) AND (cx=313) THEN cx:=4
  IF (cway=1) AND (cy=1) THEN cy:=244
  IF (cway=3) AND (cy=243) THEN cy:=0
ENDIF
IF cx<6 THEN cloop:=stupid-29
IF cx>313 THEN cloop:=stupid-29
IF cy<3 THEN cloop:=stupid-29
IF cy>243 THEN cloop:=stupid-29

IF cway=2
IF (cloop>stupid) OR (checkcol(ReadPixel(hidden.rport,cx+1,cy))=TRUE) THEN go:=TRUE ELSE cx:=cx+1
ENDIF
IF cway=4
IF (cloop>stupid) OR (checkcol(ReadPixel(hidden.rport,cx-1,cy))=TRUE) THEN go:=TRUE ELSE cx:=cx-1
ENDIF
IF cway=1
IF (cloop>stupid) OR (checkcol(ReadPixel(hidden.rport,cx,cy-1))=TRUE) THEN go:=TRUE ELSE cy:=cy-1
ENDIF
IF cway=3
IF (cloop>stupid) OR (checkcol(ReadPixel(hidden.rport,cx,cy+1))=TRUE) THEN go:=TRUE ELSE cy:=cy+1
ENDIF


IF go=TRUE
IF cloop>stupid THEN cloop:=0 ELSE cloop:=cloop+10
rand:=0

   IF (checkcol(ReadPixel(hidden.rport,cx+1,cy)))=FALSE THEN rand:=rand+1
   IF (checkcol(ReadPixel(hidden.rport,cx-1,cy)))=FALSE THEN rand:=rand+5
   IF (checkcol(ReadPixel(hidden.rport,cx,cy+1)))=FALSE THEN rand:=rand+20
   IF (checkcol(ReadPixel(hidden.rport,cx,cy-1)))=FALSE THEN rand:=rand+55

IF rand=1 THEN (cx:=cx+1) AND (cway:=2)
IF rand=5 THEN (cx:=cx-1) AND (cway:=4)
IF rand=20 THEN (cy:=cy+1) AND (cway:=3)
IF rand=55 THEN (cy:=cy-1) AND (cway:=1)

IF (rand=6) OR (rand=25) OR (rand=75) OR (rand=60) OR (rand=56) OR (rand=21)
decide:=Rnd(2)
IF (decide=0) AND (rand=6) THEN (cx:=cx+1) AND (cway:=2)
IF (decide=1) AND (rand=6) THEN (cx:=cx-1) AND (cway:=4)
IF (decide=0) AND (rand=25) THEN (cx:=cx-1) AND (cway:=4)
IF (decide=1) AND (rand=25) THEN (cy:=cy+1) AND (cway:=3)
IF (decide=0) AND (rand=75) THEN (cy:=cy+1) AND (cway:=1)
IF (decide=1) AND (rand=75) THEN (cy:=cy-1) AND (cway:=3)
IF (decide=0) AND (rand=60) THEN (cx:=cx-1) AND (cway:=4)
IF (decide=1) AND (rand=60) THEN (cy:=cy-1) AND (cway:=1)
IF (decide=0) AND (rand=56) THEN (cx:=cx+1) AND (cway:=2)
IF (decide=1) AND (rand=56) THEN (cy:=cy-1) AND (cway:=1)
IF (decide=0) AND (rand=21) THEN (cy:=cy+1) AND (cway:=3)
IF (decide=1) AND (rand=21) THEN (cx:=cx+1) AND (cway:=2)
ENDIF

IF (rand=26) OR (rand=76) OR (rand=80) OR (rand=61) 
decide:=Rnd(3)
IF (decide=0) AND (rand=26) THEN (cy:=cy+1) AND (cway:=3)
IF (decide=1) AND (rand=26) THEN (cx:=cx-1) AND (cway:=4)
IF (decide=2) AND (rand=26) THEN (cx:=cx+1) AND (cway:=2)
IF (decide=0) AND (rand=76) THEN (cy:=cy-1) AND (cway:=1)
IF (decide=1) AND (rand=76) THEN (cy:=cy+1) AND (cway:=3)
IF (decide=2) AND (rand=76) THEN (cx:=cx+1) AND (cway:=2)
IF (decide=0) AND (rand=80) THEN (cy:=cy+1) AND (cway:=3)
IF (decide=1) AND (rand=80) THEN (cy:=cy-1) AND (cway:=1)
IF (decide=2) AND (rand=80) THEN (cx:=cx-1) AND (cway:=4)
IF (decide=0) AND (rand=61) THEN (cy:=cy-1) AND (cway:=1)
IF (decide=1) AND (rand=61) THEN (cx:=cx-1) AND (cway:=4)
IF (decide=2) AND (rand=61) THEN (cx:=cx+1) AND (cway:=2)
ENDIF                              

IF rand=81
decide:=Rnd(4)
IF decide=0 THEN (cy:=cy+1) AND (cway:=3)
IF decide=1 THEN (cx:=cx-1) AND (cway:=4)
IF decide=2 THEN (cx:=cx+1) AND (cway:=2)
IF decide=3 THEN (cy:=cy-1) AND (cway:=1)
ENDIF

IF rand=0 THEN die(dier)
ENDIF

IF swooshy=TRUE
IF (cplay=1) AND (cway1<>cway)
   playData(sampled,samplend,1500000,CHAN_LEFT1,20)
WaitTOF()
exitLoop(CHAN_LEFT1)
ENDIF
IF (cplay=2) AND (cway2<>cway)
  playData(sampled,samplend,1600000,CHAN_LEFT2,20)
WaitTOF()
exitLoop(CHAN_LEFT2)
ENDIF
IF (cplay=3) AND (cway3<>cway)
  playData(sampled,samplend,1700000,CHAN_RIGHT1,20)
WaitTOF()
exitLoop(CHAN_RIGHT1)
ENDIF
IF (cplay=4) AND (cway4<>cway)
  playData(sampled,samplend,1800000,CHAN_RIGHT2,20)
WaitTOF()
exitLoop(CHAN_RIGHT2)
ENDIF
ENDIF

IF cplay=1 
cx1:=cx ; cy1:=cy ; cway1:=cway ; cloop1:=cloop
ENDIF
IF cplay=2 
cx2:=cx ; cy2:=cy ; cway2:=cway ; cloop2:=cloop
ENDIF
IF cplay=3 
cx3:=cx ; cy3:=cy ; cway3:=cway ; cloop3:=cloop
ENDIF
IF cplay=4 
cx4:=cx ; cy4:=cy ; cway4:=cway ; cloop4:=cloop
ENDIF

ENDPROC

PROC checkcol(colnum)
DEF crash=FALSE

IF colnum=1 THEN crash:=TRUE 
IF colnum=2 THEN crash:=TRUE 
IF colnum=4 THEN crash:=TRUE 
IF colnum=5 THEN crash:=TRUE 
IF colnum=6 THEN crash:=TRUE 
IF colnum=7 THEN crash:=TRUE 
IF colnum=63 THEN crash:=TRUE 
IF colnum=62 THEN crash:=TRUE 

IF (blocks=TRUE) AND (colnum=4) AND (cdie1=TRUE) AND (die1=TRUE) THEN crash:=FALSE
IF (blocks=TRUE) AND (colnum=5) AND (cdie2=TRUE) AND (die2=TRUE) THEN crash:=FALSE
IF (blocks=TRUE) AND (colnum=6) AND (cdie3=TRUE) AND (die3=TRUE) THEN crash:=FALSE
IF (blocks=TRUE) AND (colnum=7) AND (cdie4=TRUE) AND (die4=TRUE) THEN crash:=FALSE
ENDPROC crash

PROC send_read_request(game_event, game_io_msg:PTR TO iostd)
  game_io_msg.command:=GPD_READEVENT
  game_io_msg.flags:=0
  game_io_msg.data:=game_event
  game_io_msg.length:=SIZEOF inputevent
  SendIO(game_io_msg)  -> Asynchronous - message will return later

ENDPROC

PROC processEvents(game_io_msg:PTR TO iostd, game_msg_port:PTR TO mp, game_io_msgm:PTR TO iostd, game_msg_portm:PTR TO mp)
  DEF timeout, timeouts, button_count, code, code2, 
      game_event:inputevent,  
      game_eventm:inputevent

  DEF imsg:PTR TO intuimessage, imsgClass, imsgCode, gad

  timeouts:=0
  button_count:=0
  not_finished:=TRUE

  WHILE not_finished
imsg:=Gt_GetIMsg(hidden.userport)  
    gad:=imsg.iaddress
      imsgClass:=imsg.class
      imsgCode:=imsg.code
      Gt_ReplyIMsg(imsg)

    send_read_request(game_event, game_io_msg)
    send_read_request(game_eventm, game_io_msgm)
    
    WaitPort(game_msg_port)
    WaitPort(game_msg_portm)

WHILE ((NIL<>GetMsg(game_msg_port))) AND ((NIL<>GetMsg(game_msg_portm)))
      timeout:=FALSE
      code:=game_event.code
      code2:=game_eventm.code

      SELECT code
      CASE IECODE_NOBUTTON
        IF start1=TRUE
        timeout:=check_move(game_event)
        button_count:=0
        ENDIF
      CASE IECODE_LBUTTON
          IF start1=FALSE 
          start1:=TRUE
          ELSE
IF limspeed1=0
IF accelaration=1 THEN limspeed1:=40
IF accelaration=2 THEN limspeed1:=80
          IF accelaration<>0

IF play1control=0 THEN speed1:=4
IF play1control=1 THEN speed2:=4
IF play1control=2 THEN speed3:=4
IF play1control=3 THEN speed4:=4
ENDIF
ENDIF
ENDIF
      DEFAULT
      ENDSELECT

      SELECT code2
      CASE IECODE_NOBUTTON
        IF start1=TRUE
        timeout:=check_movem(game_eventm)
        button_count:=0
        ENDIF
      CASE IECODE_LBUTTON
          IF start1=FALSE 
          start1:=TRUE
          ELSE
IF limspeed2=0
IF accelaration=1 THEN limspeed2:=40
IF accelaration=2 THEN limspeed2:=80
          IF accelaration<>0
IF play2control=0 THEN speed1:=4
IF play2control=1 THEN speed2:=4
IF play2control=2 THEN speed3:=4
IF play2control=3 THEN speed4:=4
ENDIF
ENDIF
          ENDIF
      DEFAULT
      ENDSELECT

      IF timeout
        INC timeouts
      ELSE
        timeouts:=0
      ENDIF

IF imsgCode=95
REPEAT
ActivateWindow(hidden)
imsg:=Gt_GetIMsg(hidden.userport)  
    gad:=imsg.iaddress
      imsgClass:=imsg.class
      imsgCode:=imsg.code
      Gt_ReplyIMsg(imsg)
UNTIL (imsgCode=95) OR (imsgCode=69)
stdrast:=hidden.rport
SetStdRast(hidden.rport)
ENDIF

IF start1=TRUE
IF joy3loop=FALSE
IF imsgCode=76 THEN (movementx:=0) AND (movementy:=-1)
IF imsgCode=77 THEN (movementx:=0) AND (movementy:=1)
IF imsgCode=78 THEN (movementx:=1) AND (movementy:=0)
IF imsgCode=79 THEN (movementx:=-1) AND (movementy:=0)
ELSE
joy3loop:=FALSE
ENDIF
ENDIF

IF accelaration<>0
IF (limspeed3=0) AND (imsgCode=97)
IF accelaration=1 THEN limspeed3:=40
IF accelaration=2 THEN limspeed3:=80


IF play3control=0 THEN speed1:=4
IF play3control=1 THEN speed2:=4
IF play3control=2 THEN speed3:=4
IF play3control=3 THEN speed4:=4
ENDIF
ENDIF

IF (start1=FALSE) AND (imsgCode=97) THEN (start1:=TRUE)  AND (speed3:=0) AND (speed4:=0) AND (speed2:=0) AND (speed1:=0)

IF imsgCode=69 THEN not_finished:=FALSE

IF start1=TRUE 
IF play3control=0 THEN hmove(movementx, movementy, 1)
IF play3control=1 THEN hmove(movementx, movementy, 2)
IF play3control=2 THEN hmove(movementx, movementy, 3)
IF play3control=3 THEN hmove(movementx, movementy, 4)
ENDIF

IF start1=TRUE
IF joy4loop=FALSE
IF imsgCode=49 THEN (movementx3:=-1) AND (movementy3:=0)
IF imsgCode=50 THEN (movementx3:=1) AND (movementy3:=0)
IF imsgCode=32 THEN (movementx3:=0) AND (movementy3:=1)
IF imsgCode=16 THEN (movementx3:=0) AND (movementy3:=-1)
ELSE
joy4loop:=FALSE
ENDIF
ENDIF

IF accelaration<>0
IF (limspeed4=0) AND (imsgCode=64)
IF accelaration=1 THEN limspeed4:=40
IF accelaration=2 THEN limspeed4:=80

IF play4control=0 THEN speed1:=4
IF play4control=1 THEN speed2:=4
IF play4control=2 THEN speed3:=4
IF play4control=3 THEN speed4:=4
ENDIF
ENDIF
IF (start1=FALSE) AND (imsgCode=64) THEN (start1:=TRUE) AND (speed3:=0) AND (speed4:=0) AND (speed2:=0) AND (speed1:=0)

IF imsgCode=69 THEN not_finished:=FALSE

IF start1=TRUE 
IF play4control=0 THEN hmove(movementx3, movementy3, 1)
IF play4control=1 THEN hmove(movementx3, movementy3, 2)
IF play4control=2 THEN hmove(movementx3, movementy3, 3)
IF play4control=3 THEN hmove(movementx3, movementy3, 4)
ENDIF

ActivateWindow(hidden)
IF limspeed1>0 THEN limspeed1:=limspeed1-1
IF limspeed2>0 THEN limspeed2:=limspeed2-1
IF limspeed3>0 THEN limspeed3:=limspeed3-1
IF limspeed4>0 THEN limspeed4:=limspeed4-1
IF start1=TRUE THEN calccomp()
  ENDWHILE
  ENDWHILE
ENDPROC

PROC noise(whichnoise)
IF (samplei) AND (whichnoise=1)

  playData(samplei,sampleni,150000,CHAN_LEFT1,40)
WaitTOF()
exitLoop(CHAN_LEFT1)
ENDIF

IF (samplei) AND (whichnoise=2)

playData(samplei,sampleni,150000,CHAN_LEFT2,40)
WaitTOF()
exitLoop(CHAN_LEFT2)
ENDIF

IF (samplei) AND (whichnoise=3)

  playData(samplei,sampleni,150000,CHAN_RIGHT1,40)
WaitTOF()
exitLoop(CHAN_RIGHT1)
ENDIF

IF (samplei) AND (whichnoise=4)

  playData(samplei,sampleni,150000,CHAN_RIGHT2,40)
WaitTOF()
exitLoop(CHAN_RIGHT2)
ENDIF
ENDPROC

PROC set_controller_type(type, game_io_msg:PTR TO iostd, no)
    controller_type_addr1:=[0]:CHAR
    controller_type_addr2:=[0]:CHAR

IF no=1
  game_io_msg.command:=GPD_ASKCTYPE  
  game_io_msg.flags:=IOF_QUICK
  game_io_msg.data:=controller_type_addr1  
  game_io_msg.length:=1
  DoIO(game_io_msg)
ENDIF

IF no=2
  game_io_msg.command:=GPD_ASKCTYPE  
  game_io_msg.flags:=IOF_QUICK
  game_io_msg.data:=controller_type_addr2  
  game_io_msg.length:=1
  DoIO(game_io_msg)
ENDIF

    game_io_msg.command:=GPD_SETCTYPE
    game_io_msg.flags:=IOF_QUICK
    game_io_msg.data:=[type]:CHAR
    game_io_msg.length:=1
    DoIO(game_io_msg)

ENDPROC 

PROC set_trigger_conditions(gpt:PTR TO gameporttrigger,
                            game_io_msg:PTR TO iostd)
  gpt.keys:=GPTF_UPKEYS OR GPTF_DOWNKEYS
  gpt.xdelta:=JOY_X_DELTA
  gpt.ydelta:=JOY_Y_DELTA
  gpt.timeout:=1

  game_io_msg.command:=GPD_SETTRIGGER
  game_io_msg.flags:=IOF_QUICK
  game_io_msg.data:=gpt
  game_io_msg.length:=SIZEOF gameporttrigger
  DoIO(game_io_msg)

ENDPROC

PROC flush_buffer(game_io_msg:PTR TO iostd)
  game_io_msg.command:=CMD_CLEAR
  game_io_msg.flags:=IOF_QUICK
  game_io_msg.data:=NIL
  game_io_msg.length:=0
  DoIO(game_io_msg)
ENDPROC

PROC free_gp_unit(game_io_msg:PTR TO iostd, no)

IF no=1
  game_io_msg.command:=GPD_SETCTYPE
  game_io_msg.flags:=IOF_QUICK
  game_io_msg.data:=controller_type_addr1  
  game_io_msg.length:=1;
  DoIO(game_io_msg)
ENDIF
IF no=2
  game_io_msg.command:=GPD_SETCTYPE
  game_io_msg.flags:=IOF_QUICK
   game_io_msg.data:=controller_type_addr2  
     game_io_msg.length:=1;
  DoIO(game_io_msg)
ENDIF

ENDPROC

PROC begingame()
DEF pos0=FALSE, pos1=FALSE, pos2=FALSE, pos3=FALSE, pos4=FALSE, pos5=FALSE, pos6=FALSE, pos7=FALSE, pos8=FALSE, pos9=FALSE, pos10=FALSE, pos11=FALSE, pos12=FALSE, pos13=FALSE, pos14=FALSE, pos15=FALSE,
nochips, whichchip, poschip, posx, posy, badnum=TRUE, a[5]:STRING

IF playerno=0 
die1:=FALSE ; die2:=TRUE ; die3:=TRUE ; die4:=TRUE ; cdie1:=TRUE ; cdie2:=FALSE ; cdie3:=FALSE ; cdie4:=FALSE
ENDIF 
IF playerno=1 
die1:=FALSE ; die2:=FALSE ; die3:=TRUE ; die4:=TRUE ; cdie1:=TRUE ; cdie2:=TRUE ; cdie3:=FALSE ; cdie4:=FALSE
ENDIF 
IF playerno=2 
die1:=FALSE ; die2:=FALSE ; die3:=FALSE ; die4:=TRUE ; cdie1:=TRUE ; cdie2:=TRUE ; cdie3:=TRUE ; cdie4:=FALSE
ENDIF 
IF playerno=3 
die1:=FALSE ; die2:=FALSE ; die3:=FALSE ; die4:=FALSE ; cdie1:=TRUE ; cdie2:=TRUE ; cdie3:=TRUE ; cdie4:=TRUE
ENDIF 
IF playerno=4
die1:=TRUE ; die2:=TRUE ; die3:=TRUE ; die4:=TRUE ; cdie1:=FALSE ; cdie2:=FALSE ; cdie3:=FALSE ; cdie4:=FALSE ; start1:=TRUE
ENDIF 
IF play1control=0 THEN (movex:=0) AND (movey:=-1)
IF play1control=1 THEN (movex:=1) AND (movey:=0)
IF play1control=2 THEN (movex:=0) AND (movey:=1)
IF play1control=3 THEN (movex:=-1) AND (movey:=0)
IF play2control=0 THEN (movex2:=0) AND (movey2:=-1)
IF play2control=1 THEN (movex2:=1) AND (movey2:=0)
IF play2control=2 THEN (movex2:=0) AND (movey2:=1)
IF play2control=3 THEN (movex2:=-1) AND (movey2:=0)
IF play3control=0 THEN (movementx:=0) AND (movementy:=-1)
IF play3control=1 THEN (movementx:=1) AND (movementy:=0)
IF play3control=2 THEN (movementx:=0) AND (movementy:=1)
IF play3control=3 THEN (movementx:=-1) AND (movementy:=0)
IF play4control=0 THEN (movementx3:=0) AND (movementy3:=-1)
IF play4control=1 THEN (movementx3:=1) AND (movementy3:=0)
IF play4control=2 THEN (movementx3:=0) AND (movementy3:=1)
IF play4control=3 THEN (movementx3:=-1) AND (movementy3:=0)

IF play1control=0 THEN StringF(name1,'\s',tname1)
IF play1control=1 THEN StringF(name2,'\s',tname1)
IF play1control=2 THEN StringF(name3,'\s',tname1)
IF play1control=3 THEN StringF(name4,'\s',tname1)
IF play2control=0 THEN StringF(name1,'\s',tname2)
IF play2control=1 THEN StringF(name2,'\s',tname2)
IF play2control=2 THEN StringF(name3,'\s',tname2)
IF play2control=3 THEN StringF(name4,'\s',tname2)
IF play3control=0 THEN StringF(name1,'\s',tname3)
IF play3control=1 THEN StringF(name2,'\s',tname3)
IF play3control=2 THEN StringF(name3,'\s',tname3)
IF play3control=3 THEN StringF(name4,'\s',tname3)
IF play4control=0 THEN StringF(name1,'\s',tname4)
IF play4control=1 THEN StringF(name2,'\s',tname4)
IF play4control=2 THEN StringF(name3,'\s',tname4)
IF play4control=3 THEN StringF(name4,'\s',tname4)


IF hiddenclosed=TRUE
hidden:=OpenW(0,11,320,245,IDCMP_RAWKEY, WFLG_BORDERLESS OR WFLG_ACTIVATE, NIL, screen,$F,NIL,NIL)
hiddenclosed:=FALSE
ELSE
SetStdRast(hidden.rport)
ENDIF
setcols2()
IfFL_DecodePic(gamepicmem,screen+184)
ShowTitle(screen, TRUE)
offMousePointer(hidden)
SetTopaz(8)
setlines()
Line(4,0,314,0,2)
Line(4,244,314,244,2)
Line(4,0,4,244,2)
Line(314,0,314,244,2)


Box(193,221,195,223,4)
Box(38,166,40,168,5)
Box(105,45,107,47,6)
Box(275,82,277,84,7)

IF obstacles=TRUE
nochips:=Rnd(16)
REPEAT
whichchip:=Rnd(2)
poschip:=Rnd(16)

IF (pos0=FALSE) AND (poschip=0)
posx:=36
posy:=31
pos0:=TRUE
badnum:=FALSE
ENDIF

IF (pos1=FALSE) AND (poschip=1)
posx:=38
posy:=91
pos1:=TRUE
badnum:=FALSE
ENDIF

IF (pos2=FALSE) AND (poschip=2)
posx:=45
posy:=212
pos2:=TRUE
badnum:=FALSE
ENDIF

IF (pos3=FALSE) AND (poschip=3) 
posx:=135
posy:=47
pos3:=TRUE
badnum:=FALSE
ENDIF

IF (pos4=FALSE) AND (poschip=4)
posx:=100
posy:=111
pos4:=TRUE
badnum:=FALSE
ENDIF

IF (pos5=FALSE) AND (poschip=5)
posx:=95
posy:=169
pos5:=TRUE
badnum:=FALSE
ENDIF

IF (pos6=FALSE) AND (poschip=6) 
posx:=97
posy:=210
pos6:=TRUE
badnum:=FALSE
ENDIF

IF (pos7=FALSE) AND (poschip=7) 
posx:=144
posy:=107
pos7:=TRUE
badnum:=FALSE
ENDIF

IF (pos8=FALSE) AND (poschip=8)
posx:=186
posy:=87
pos8:=TRUE
badnum:=FALSE
ENDIF

IF (pos9=FALSE) AND (poschip=9) 
posx:=169
posy:=141
pos9:=TRUE
badnum:=FALSE
ENDIF

IF (pos10=FALSE) AND (poschip=10)
posx:=208
posy:=216
pos10:=TRUE
badnum:=FALSE
ENDIF

IF (pos11=FALSE) AND (poschip=11)
posx:=234
posy:=161
pos11:=TRUE
badnum:=FALSE
ENDIF

IF (pos12=FALSE) AND (poschip=12)
posx:=271
posy:=207
pos12:=TRUE
badnum:=FALSE
ENDIF

IF (pos13=FALSE) AND (poschip=13)
posx:=279
posy:=141
pos13:=TRUE
badnum:=FALSE
ENDIF

IF (pos14=FALSE) AND (poschip=14)
posx:=234
posy:=21
pos14:=TRUE
badnum:=FALSE
ENDIF

IF (pos15=FALSE) AND (poschip=15)
posx:=280
posy:=38
pos15:=TRUE
badnum:=FALSE
ENDIF

IF badnum=FALSE
nochips:=nochips-1
IF whichchip=0 THEN DrawImage(hidden.rport, chip1data, posx,posy)
IF whichchip=1 THEN DrawImage(hidden.rport, chip2data, posx,posy)
badnum:=TRUE
ENDIF

UNTIL nochips=-1
ENDIF

gameinitial()
ENDPROC

PROC die(player)
IF Not ((die1+die2+die3+die4+cdie1+cdie2+cdie3+cdie4)=-8) 

IF (samplec) AND (player=1)
clearaudio(1)
  playData(samplec,samplenc,4500000,CHAN_LEFT1,64)
WaitTOF()
exitLoop(CHAN_LEFT1)
ENDIF

IF (samplec) AND (player=2)
clearaudio(2)
  playData(samplec,samplenc,4500000,CHAN_LEFT2,64)
WaitTOF()
exitLoop(CHAN_LEFT2)
ENDIF

IF (samplec) AND (player=3)
clearaudio(3)
  playData(samplec,samplenc,4500000,CHAN_RIGHT1,64)
WaitTOF()
exitLoop(CHAN_RIGHT1)
ENDIF

IF (samplec) AND (player=4)
clearaudio(4)
  playData(samplec,samplenc,4500000,CHAN_RIGHT2,64)
WaitTOF()
exitLoop(CHAN_RIGHT2)
ENDIF

IF player=1
IF blocks=TRUE THEN SetColour(screen,4,0,0,127) ELSE SetColour(screen,4,0,0,0)
die1:=TRUE
cdie1:=TRUE
ENDIF
IF player=2
IF blocks=TRUE THEN SetColour(screen,5,0,0,127) ELSE SetColour(screen,5,0,0,0)
die2:=TRUE
cdie2:=TRUE
ENDIF
IF player=3
IF blocks=TRUE THEN SetColour(screen,6,0,0,127) ELSE SetColour(screen,6,0,0,0)
die3:=TRUE
cdie3:=TRUE
ENDIF
IF player=4
IF blocks=TRUE THEN SetColour(screen,7,0,0,127) ELSE SetColour(screen,7,0,0,0)
die4:=TRUE
cdie4:=TRUE
ENDIF
IF (die1+die2+die3+die4+cdie1+cdie2+cdie3+cdie4)=-7 
IF (cdie1=FALSE) OR (die1=FALSE) THEN play1:=play1+1
IF (cdie2=FALSE) OR (die2=FALSE) THEN play2:=play2+1
IF (cdie3=FALSE) OR (die3=FALSE) THEN play3:=play3+1
IF (cdie4=FALSE) OR (die4=FALSE) THEN play4:=play4+1
die1:=TRUE ; die2:=TRUE ; die3:=TRUE ; die4:=TRUE ; cdie1:=TRUE ; cdie2:=TRUE ; cdie3:=TRUE ; cdie4:=TRUE
not_finished:=FALSE
Delay(50)
ENDIF
ENDIF
ENDPROC

PROC decrypt() HANDLE

samplec:=AllocMem(3900, MEMF_CHIP)
CopyMem({data}, samplec, 3900)
samplenc:=3900

sample:=AllocMem(12760, MEMF_CHIP)
CopyMem({data}+3900, sample, 12760)
samplen:=12760

sampled:=AllocMem(3121, MEMF_CHIP)
CopyMem({data}+3900+12760, sampled, 3121)
samplend:=3121

samplei:=AllocMem(9536, MEMF_CHIP)
CopyMem({data}+3900+12760+3120, samplei, 9536)
sampleni:=9536

EXCEPT DO
ReThrow()
ENDPROC

PROC request(body,no,end)

IF no=0
EasyRequestArgs(0,[20,0,'LightSpeed2',body,'Terminate'],0,NIL)
ELSE
EasyRequestArgs(0,[20,0,'LightSpeed2',body,end],0,NIL)
ENDIF
ENDPROC 

PROC initaudio() HANDLE
DEF len=NIL:PTR TO ln, men=NIL:PTR TO mn, iow=NIL:PTR TO iostd, 
message:PTR TO ioaudio, waveptr:PTR TO INT, errors

  men:=audioio
  men.replyport:=audiomp
  len:=audioio
  len.pri:=127
  iow:=audioio
  audioio.allockey:= 0
  iow.command := ADCMD_ALLOCATE
  iow.flags := ADIOF_NOWAIT
  audioio.data := [15]:CHAR
  audioio.length := 30000
  beginIO(audioio)

IF iow.unit<>15 THEN Raise(ERR_DEV3)

bob:=audioio.allockey
EXCEPT DO
ReThrow()
ENDPROC

PROC cleanupaudio()
DEF iow=NIL:PTR TO iostd

  iow:=audioio
  iow.command := ADCMD_FREE
  audioio.allockey :=bob
  audioio.data := [15]:CHAR
  audioio.length := 30000
  beginIO (audioio)

ENDPROC

PROC clearaudio(audiochan)
DEF pow=NIL:PTR TO iostd, datafora
IF audiochan=1 THEN datafora:=2
IF audiochan=2 THEN datafora:=4
IF audiochan=3 THEN datafora:=1
IF audiochan=4 THEN datafora:=8

  pow:=audioio
  pow.command := CMD_RESET
  audioio.allockey :=bob
  audioio.data := [datafora]:CHAR
  audioio.length := 30000
  beginIO (audioio)

ENDPROC



verstag: CHAR 0, '$VER: LightSpeed 2.1 - Copyright © 1998 Micro Design (05.02.99)',NIL

mainpic: INCBIN 'light.iff'
gamepic: INCBIN 'fadetile.iff'
data: INCBIN 'light.dat'
 



 
