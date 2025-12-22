OPT PREPROCESS

MODULE 'intuition/intuition','intuition/screens'
MODULE 'graphics/gfx','graphics/rastport'
MODULE 'dos/dos'
MODULE '*kiss_files'

#define PROGRAMNAME 'showcel'
#define PROGRAMVERSION '1.0'
#define PROGRAMDATE '13.09.98'

#define pcint(var) (Shl((var AND $00FF),8) OR Shr((var AND $FF00),8))

ENUM ERR_NONE,ERR_OPENFILE,ERR_READFILE,ERR_OPENWIN

OBJECT kisscel
  name:PTR TO CHAR
  width:INT
  height:INT
  xoffset:INT
  yoffset:INT
  image:PTR TO CHAR
ENDOBJECT


DEF cel:PTR TO kisscel

PROC main() HANDLE
  DEF i
  init_readargs()
  loadcel('Work:Gry/Kiss/Ami/AMI.CEL')
  displaycel()
EXCEPT
  IF exception=ERR_NONE THEN RETURN
  PrintF('Error: \d\n',exception)
ENDPROC

PROC init_readargs()
  -> started from WB
  IF wbmessage
  -> started from CLI!
  ELSE
  ENDIF
ENDPROC

PROC loadcel(filename)
  DEF fh=0
  DEF fileid,kissheader:PTR TO kiss_celfileheader,rawheader:PTR TO kiss_rawcelfileheader
  IF (fh:=Open(filename,MODE_OLDFILE))=NIL THEN Throw(ERR_OPENFILE,filename)
  IF Read(fh,fileid,4)<4 THEN Throw(ERR_READFILE,filename)
  PrintF('Read OK!\n')
  cel:=FastNew(SIZEOF kisscel)
  IF ^fileid=KISS_ID
    Seek(fh,0,OFFSET_BEGINNING)
    kissheader:=FastNew(SIZEOF kiss_celfileheader)
    IF Read(fh,kissheader,SIZEOF kiss_celfileheader)<SIZEOF kiss_celfileheader THEN Throw(ERR_READFILE,filename)
    cel.width:=pcint(kissheader.width)
    cel.height:=pcint(kissheader.height)
    cel.xoffset:=pcint(kissheader.xoffset)
    cel.yoffset:=pcint(kissheader.yoffset)
    cel.image:=FastNew(cel.width*cel.height)
    IF (Read(fh,cel.image,cel.width*cel.height)<(cel.width*cel.height)) THEN Throw(ERR_READFILE,filename)
  ELSE
    Seek(fh,0,OFFSET_BEGINNING)
    rawheader:=FastNew(SIZEOF kiss_rawcelfileheader)
    IF Read(fh,rawheader,SIZEOF kiss_rawcelfileheader)<SIZEOF kiss_rawcelfileheader THEN Throw(ERR_READFILE,filename)
    cel.width:=pcint(rawheader.width)
    cel.height:=pcint(rawheader.height)
    cel.xoffset:=0
    cel.yoffset:=0
    cel.image:=FastNew(cel.width*cel.height)
    Read(fh,cel.image,cel.width*cel.height) -><(cel.width*cel.height)) THEN Throw(ERR_READFILE,filename)
  ENDIF
  Close(fh)
  PrintF('Cel width: \d\nCel height \d\n',cel.width,cel.height)
ENDPROC

PROC displaycel()
  DEF win:PTR TO window,scr:PTR TO screen
  DEF tmprp:PTR TO rastport,count,row,line,x,y
  scr:=LockPubScreen(NIL)
  UnlockPubScreen(NIL,scr)
  IF (win:=OpenWindowTagList(NIL,[
    WA_LEFT,160,
    WA_TOP,120,
    WA_WIDTH,scr.wborleft+cel.width+scr.wborright+1,
    WA_HEIGHT,scr.wbortop+scr.barheight+cel.height+scr.wborbottom,
    WA_TITLE,'Test!',
    WA_IDCMP,IDCMP_CLOSEWINDOW,
    WA_FLAGS,WFLG_ACTIVATE OR WFLG_CLOSEGADGET,
   NIL]))=NIL THEN Raise(ERR_OPENWIN)

  x:=scr.wborleft
  y:=scr.barheight+1
  -> init tmp rastport
  tmprp:=FastNew(SIZEOF rastport)
  InitRastPort(tmprp)
  tmprp.layer:=NIL
  tmprp.bitmap:=AllocBitMap(cel.width,1,1,NIL,NIL)
  -> render whole image (even width)
  IF Odd(cel.width)=FALSE
    WritePixelArray8(win.rport,x,y,x+cel.width-1,y+cel.height-1,cel.image,tmprp)
  ELSE
    row:=cel.image
    FOR line:=0 TO cel.height-1
      WritePixelLine8(win.rport,x,y+line,cel.width,row,tmprp)
      row:=row+cel.width
    ENDFOR
  ENDIF
  -> free memory
  FreeBitMap(tmprp.bitmap)
  FastDispose(tmprp,SIZEOF rastport)

  PrintF('Wait!\n')
  WaitIMessage(win)
  PrintF('End!\n')
  Delay(50)
  CloseWindow(win)
ENDPROC

programversion:
CHAR '$VER: ',PROGRAMNAME,32,PROGRAMVERSION,32,'(',PROGRAMDATE,')',0
