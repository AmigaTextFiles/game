/*
** PlayFKiss - KiSS player for Amiga
**
** Orginally written by Chad Randall (crandall@msen.com).
** Since version 2.07 developed by Michal Durys (misha@femina.com.pl).
**
*/

OPT LARGE
OPT PREPROCESS
OPT OSVERSION=37

MODULE 'dos/dos','dos/dosextens','dos/notify','dos/dosextens','dos/dosasl'
MODULE 'exec/memory','exec/lists','exec/nodes'
MODULE 'graphics/rastport','graphics/gfx','graphics/text','graphics/scale',
  'graphics/view','graphics/gfxbase','graphics/clip','graphics/layers',
  'graphics/displayinfo','graphics/regions'
MODULE 'intuition/intuition','intuition/screens','intuition/gadgetclass',
  'intuition/screens','intuition/pointerclass',
  'intuition/classes','intuition/icclass','intuition/imageclass',
  'intuition/cghooks'

MODULE 'asl','libraries/asl'
MODULE 'cybergraphics','cybergraphics/cybergraphics'
MODULE 'picasso96api','libraries/picasso96'
MODULE 'datatypes','datatypes/datatypes','datatypes/datatypesclass',
  'datatypes/soundclass','datatypes/pictureclass'
MODULE 'devices/inputevent'
MODULE 'keymap'
MODULE 'iffparse','libraries/iffparse'
MODULE 'gadtools','libraries/gadtools'
MODULE 'layers'
MODULE 'muimaster','libraries/mui','mui/muiextra'
MODULE 'rexxsyslib','rexx/rexxio','rexx/rxslib','rexx/errors','rexx/storage'
MODULE 'utility','utility/tagitem','utility/date','utility/hooks'
MODULE 'xpk','libraries/xpk'
MODULE 'workbench/workbench','workbench/startup'

MODULE 'amigalib/lists'
MODULE 'tools/boopsi','tools/installhook'

MODULE 'mod/lists'
MODULE 'mod/filenames'
MODULE 'mod/bitmaps'
MODULE 'mod/menus'
MODULE 'mod/gadgets'
MODULE 'mod/rexx'
MODULE 'mod/ports'
MODULE 'mod/packer'

MODULE 'afc/parser','afc/dirlist'
MODULE 'tools/mstring','tools/magicbits'

-> kiss modules
->MODULE '*kissimage'
MODULE '*ikglogo'
MODULE '*PlayFKiss_prefs'
MODULE '*PlayFKiss_gfx'
MODULE '*PlayFKiss_locale'

-> debug functions
->#define DEBUG
#ifdef DEBUG
#define dbgname(name) dbgprocname:=name
#define dbg(text,arg) WriteF('\s: '+text,dbgprocname,arg)
#define qdbg(text) WriteF('\s: '+text+'\n',dbgprocname)
#endif
#ifndef DEBUG
#define dbgname(name)
#define dbg(text,args)
#define qdbg(text)
#endif
#define DBG_DONE 'Done!'

-> some optional flags
#define OPT_NOARGSCHECK           -> procedures don't check for wrong arguments
#ifdef OPT_NOARGSCHECK
#define checkarg(variable) IF variable=NIL THEN RETURN
#endif
#ifndef OPT_NOARGSCHECK
#define checkarg(variable)
#endif
->#define OPT_SHOWSTATS           -> calculate and show time statics

-> these macros are used to allocate and dispose memory with exception handling
#define savememalloc(ptr,size) IF (ptr:=FastNew(size))=NIL THEN Throw(ERR_NOMEM,[size,MEMF_ANY])
#ifndef DEBUG
#define savememfree(ptr,size) FastDispose(ptr,size)
#endif
#ifdef DEBUG
#define savememfree(ptr,size) IF ptr THEN FastDispose(ptr,size) ELSE Throw(ERR_NULLMEMPOINER,[size])
#endif

-> program defines
#define PROGRAMNAME 'PlayFKiss'
#define PROGRAMDATE '22.3.99'
#define PROGRAMVERSION '2.08'
#define VIEWERVERSION 3

#define OPTION_ON {txt_option_on}
#define OPTION_OFF {txt_option_off}

#define addidnotify(obj,attrib,val,id) domethod(obj,[MUIM_Notify,attrib,val,ap_main,2,MUIM_Application_ReturnID,id])
#define addbutnotify(obj,id) addidnotify(obj,MUIA_Pressed,FALSE,id)
#define bigger(a,max) IF (a<max) THEN max ELSE a
#define smaller(a,min) IF (a>min) THEN min ELSE a

-> error ids
ENUM ERR_NONE,ERR_NOLIB,ERR_MUIAPP,ERR_OPENSCREEN,ERR_OPENWINDOW,
     ERR_CREATEMENU,ERR_NOCNFFILE,ERR_NOMEM="MEM",ERR_NULLMEMPOINER

ENUM ID_ABOUT=22,ID_PLAY,ID_FILE,ID_RESETPOS,ID_UNDOPOS,ID_EFIX,ID_ESTORE,
     ID_ERESETFIX,ID_EUNFIX,ID_EMAXFIX,ID_ECOFFX,ID_ECOFFY,
     ID_EBACK,ID_EFORWARD,ID_EHIDE,ID_ECSET,
     ID_POPEN,ID_PMODE,ID_PSPEED,
     ID_PENFORCE,ID_PFOLLOW,ID_PELASTIC,ID_PWORKBENCH,ID_PCYBER,
     ID_PUPDATE,ID_PPOINTER,
     ID_PSAVE,ID_PUSE,ID_REVEAL,
     ID_OKAY

ENUM MAXOBJS=800,MAXOBJS_1,MAXOBJS_2
ENUM MAXCELS=1000,MAXCELS_1,MAXCELS_2
ENUM HORIZ_GID=1,VERT_GID,LEFT_GID,RIGHT_GID,UP_GID,DOWN_GID

ENUM CMAP_SHOW=0,CMAP_HIDE,CMAP_GRAB
ENUM MENU_NONE=0,MENU_QUIT,MENU_REDRAW,MENU_ABOUT,MENU_PREFS,MENU_CLOSE,
            MENU_SAVE,MENU_SAVEALL,MENU_REVEAL,
            MENU_OBJWIN,MENU_RESETOBJ,MENU_UNFIXOBJ,MENU_UNDO,MENU_REFIXOBJ,
            MENU_MOVEBACK,MENU_MOVEFORWARD,
            MENU_SAVESCREEN,MENU_PATROL,MENU_RESETSET,
            MENU_SET0,MENU_SET1,MENU_SET2,MENU_SET3,MENU_SET4,
            MENU_SET5,MENU_SET6,MENU_SET7,MENU_SET8,MENU_SET9,
            MENU_CSET0,MENU_CSET1,MENU_CSET2,MENU_CSET3,MENU_CSET4,
            MENU_CSET5,MENU_CSET6,MENU_CSET7,MENU_CSET8,MENU_CSET9
ENUM QUIT_NONE=0,QUIT_QUIT,QUIT_CLOSE

ENUM GH_MAIN,GH_PREFS,GH_EDITOR

ENUM REG_OBJ=0,REG_CEL,REG_NONE

ENUM EV_UNKNOWN=0,EV_INIT,EV_BEGIN,EV_END,EV_VERSION,EV_ALARM,EV_CATCH,EV_UNFIX,EV_FIXCATCH,EV_SET,EV_COL,EV_DROP,EV_PRESS,EV_RELEASE,EV_FIXDROP
ENUM CO_UNKNOWN=0,CO_TIMER,CO_RANDOMTIMER,CO_MAP,CO_UNMAP,CO_ALTMAP,CO_SOUND,CO_MOVE,CO_MOVETO,CO_MOVERANDX,CO_MOVERANDY,CO_MOVETORAND,CO_CHANGECOL,CO_CHANGESET,CO_DEBUG,CO_NOTIFY,CO_NOP,CO_IFFIXED,CO_IFMAPPED,CO_IFNOTFIXED,CO_IFNOTMAPPED

CONST FILE_MARK_CELL=$20,FILE_MARK_PALET=$10
CONST   GS1_MAX_COLOR=16,GS2_MAX_COLOR=256,GS3_MAX_COLOR=256,GS4_MAX_COLOR=256

OBJECT event
  ln:ln
  commands:lh
  type:LONG
  obj:LONG
  cel:PTR TO CHAR
  counter:LONG
  trigger:CHAR
ENDOBJECT

OBJECT command
  ln:ln
  type:LONG
  obj:LONG
  cel:PTR TO CHAR
  x,y:LONG
  sound:LONG
ENDOBJECT

OBJECT cel PUBLIC
  realname:PTR TO CHAR
  comment:PTR TO CHAR
  w:INT
  h:INT
  ox:INT
  oy:INT
  sets[11]:ARRAY
  buf:PTR TO CHAR
  obuf:PTR TO CHAR
  obj:INT
  fix:LONG
  palet_num:CHAR
  mapped:CHAR
  bit_per_pixel:CHAR
->  imbuf:PTR TO imbuf
->  mask:PTR TO imbuf
  mask:PTR TO CHAR
ENDOBJECT

OBJECT obj PUBLIC
    number:LONG
    comment:PTR TO CHAR
    numcels:LONG
    fix:LONG
    oldfix:LONG
    lastx,lasty:INT
    rubx,ruby:INT
    x[11]:ARRAY OF INT
    y[11]:ARRAY OF INT
    ux[11]:ARRAY OF INT
    uy[11]:ARRAY OF INT
ENDOBJECT

OBJECT paleto
    name:PTR TO CHAR
    format:CHAR
    palet_num:CHAR
    bit_per_pixel:CHAR
    color_num:INT
->  pb[10]:ARRAY OF INT
    color[18]:ARRAY OF LONG
ENDOBJECT
OBJECT listnodes;lh:lh;ENDOBJECT

OBJECT listent
    num,name,size,pal,sets,comment,obj
ENDOBJECT

-> this object holds global data of PFK
OBJECT kissapp
  -> resources
  hscroller:PTR TO object
  -> others
  prefs:PTR TO pfkprefs
  chunkybuf:PTR TO CHAR           -> this is our graphics chunky buffer
ENDOBJECT

DEF ka:kissapp

DEF cat:PTR TO catalog_PlayFKiss

DEF palet[20]:ARRAY OF paleto
DEF mode,palset=0

DEF animspeed=100,usebounds=FALSE,usehand=FALSE
DEF tanimspeed=100,tusebounds=FALSE,tusehand=FALSE
DEF useregions=REG_OBJ,tuseregions
DEF usefollow=FALSE,tusefollow
DEF usesnap=FALSE,tusesnap
DEF usenasty=FALSE,tusenasty
DEF usecgfx=FALSE
DEF usewb=TRUE,tusewb,onwb=FALSE

DEF objs[MAXOBJS_2]:LIST
DEF cels[MAXCELS_2]:LIST

DEF horizgadget:PTR TO object
DEF vertgadget:PTR TO object
DEF leftgadget:PTR TO object,rightgadget:PTR TO object
DEF upgadget:PTR TO object,downgadget:PTR TO object
DEF offx=0,offy=0

DEF rexxport,rexxsigbit,rexxname[150]:STRING
DEF rexxhand:PTR TO rexx_handle
DEF oldafile[500]:STRING

DEF sizeimage:PTR TO image,leftimage:PTR TO image,rightimage:PTR TO image
DEF upimage:PTR TO image,downimage:PTR TO image

DEF modeid=69632,tmodeid
DEF screenos=0,tscreenos
DEF screenas=TRUE,tscreenas

DEF apens[260]:LIST,bgpen=-1

DEF inputevent:PTR TO inputevent

DEF pb[12]:LIST

DEF envw=640,envh=480
DEF backcolor=0

DEF fkissfound=0

DEF hand1,hand2,hand3,hand4
DEF hbm1:PTR TO bitmap,hbm2:PTR TO bitmap,hbm3:PTR TO bitmap,hbm4:PTR TO bitmap

DEF linenum=1
DEF lastobj=0:PTR TO obj,lastcel=0:PTR TO cel

DEF events,commands

DEF win:PTR TO window
DEF scr:PTR TO screen,depth
DEF dri:PTR TO drawinfo
DEF vis,cm,vp:PTR TO viewport,rp:PTR TO rastport
DEF menu

DEF filereq=0:PTR TO filerequester

DEF dhook:PTR TO hook
DEF conhook:PTR TO hook
DEF deshook:PTR TO hook

DEF eventlist:PTR TO lh

DEF lastseconds,lastmicros
#ifdef OPT_SHOWSTATS
DEF se1,se2,se3,se4,se5,se6,se7,se8
DEF mi1,mi2,mi3,mi4,mi5,mi6,mi7,mi8
DEF em1,em2,em3,em4,em5,elapse
#endif

DEF temprp=0:PTR TO rastport
DEF tempbitmap=0:PTR TO bitmap

DEF ofilename[500]:STRING
DEF smr=NIL:PTR TO screenmoderequester

DEF curset=-1,curpal=0

DEF curcel:PTR TO cel,curobj:PTR TO obj,catchobj:PTR TO obj

->DEF dragbuf:PTR TO imbuf,maskbuf:PTR TO imbuf
DEF olddragx,olddragy,dragox,dragoy,dragx,dragy

DEF region=0:PTR TO region
DEF rminx,rminy,rmaxx,rmaxy

DEF setloaded=0

DEF afname[500]:STRING
DEF totmem=0

DEF continue,stepon

DEF ap_main,wi_prefs,wi_main,wi_edit,wi_reveal,wi_output,wi_about
DEF ap_signal,muiresult

DEF g_status,g_filename,g_file,g_listview,g_list
DEF g_objs,g_cels,g_events,g_actions,g_colors,g_memory
DEF g_errors,g_errorlist
DEF g_play,g_prefs,g_about,g_quit

DEF g_modename,g_getmode,g_pspeed,
        g_penforce,g_pfollow,g_pelastic,g_pworkbench,g_pcyber,
        g_pupdate,g_ppointer,
        g_psave,g_puse,g_pcancel

DEF g_reveallist,g_revealview

DEF g_eobj,g_ecels,g_ewidth,g_eheight,g_ex,g_ey,g_resetpos,g_undopos
DEF g_efix,g_estore,g_eresetfix,g_eunfix,g_emaxfix
DEF g_ecel,g_ename,g_ecwidth,g_echeight,g_ecoffx,g_ecoffy
DEF g_efor,g_eback,g_ehide,g_ecset

DEF g_about_okay
DEF g_outputlist

DEF drawchunky=NIL   -> this global variable is a pointer to a procedure used to draw chunky data
DEF p96ri:PTR TO p96RenderInfo  -> Picasso96 render info

PROC placecel(cel:PTR TO cel,x,y,ex,ey,ew,eh)
  DEF a1:PTR TO CHAR,a2:PTR TO CHAR
  DEF sx,sy,dx,dy,bb,cc
  DEF rw,rh

  IF (ex<0)
    ew:=ew+ex
    ex:=0
  ENDIF
  IF (ey<0)
    eh:=eh+ey
    ey:=0
  ENDIF
  IF ((ew+ex)>envw) THEN ew:=envw-ex
  IF ((ey+eh)>envh) THEN eh:=envh-ey

  rw:=cel.w           -> Width of cel memblock to copy
  rh:=cel.h
  sx:=0                   -> Top-left corner of source cel memblock
  sy:=0
  dx:=x+cel.ox    -> Top-left corner in gbuf to place cel
  dy:=y+cel.oy

  IF (dx<=ex)
    sx:=(ex-dx)
    rw:=rw-sx
    dx:=ex
  ENDIF
  IF (dy<=ey)
    sy:=(ey-dy)
    rh:=rh-sy
    dy:=ey
  ENDIF
  bb:=ex+ew
  cc:=dx+rw
  IF ((cc-1)>=bb)
    rw:=rw-(cc-bb)+1
  ENDIF
  bb:=ey+eh
  cc:=dy+rh
  IF ((cc-1)>=bb)
    rh:=rh-(cc-bb)+1
  ENDIF
  a1:=cel.buf+(cel.w*sy)+sx
  a2:=ka.chunkybuf+(dy*envw)+dx
  rw:=rw-1
  rh:=rh-1

  IF rw>=0
    IF rh>=0
      bb:=cel.w
      MOVEM   A0-A2/D0-D7,-(A7)       -> E seems to use a few of these variables. :(
      MOVE.L  rh,D1           -> outside loop (height)
      MOVE.L  bb,D5           -> celwidth
      MOVE.L  envw,D6         -> environment width
      MOVE.L  rw,D7           -> real width to copy
      MOVEQ   #0,D0           -> D4 is used with bytes
      MOVE.L  a1,D2           -> these point to left side of cel,env
      MOVE.L  a2,D3

loopt:
      MOVE.L  D7,D0           -> inside loop (width)
      MOVE.L  D2,A1           -> grab left side of cel,env
      MOVE.L  D3,A2

loopi:
      MOVE.B  (A1)+,D4    -> get source byte
      BEQ.S   zerobyte    -> if zero, skip
      MOVE.B  D4,(A2)     -> else store it

zerobyte:
      ADDA.L  #1,A2       -> inc storage pointer by one
      DBRA.S  D0,loopi    -> finish inside loop
      ADD.L   D5,D2       -> point to one line below current
      ADD.L   D6,D3
      DBRA.S  D1,loopt    -> finish outside loop
      MOVEM   (A7)+,A0-A2/D0-D7
    ENDIF
  ENDIF
ENDPROC

/*
PROC placecel(cel:PTR TO cel,x,y,ex,ey,ew,eh)
  DEF realcelwidth,realcelheight
  DEF countx,county -> horizontal and vertical loops counters
  DEF imagebuf:PTR TO CHAR,imagebufoff=0
  DEF celbufoff=0
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='placecel()'
  WriteF('placecel($\h,\d,\d,\d,\d,\d,\d)\n',cel,x,y,ex,ey,ew,eh)
#endif
  checkarg(cel)
  dbg('cel.w=\d\n',cel.w)
  dbg('cel.h=\d\n',cel.h)

  IF ex<0
    ew:=ew+ex
    ex:=0
  ENDIF
  IF ey<0
    eh:=eh+ey
    ey:=0
  ENDIF
  IF ((ew+ex)>envw) THEN ew:=envw-ex
  IF ((ey+eh)>envh) THEN eh:=envh-ey

  imagebuf:=ka.chunkybuf
  realcelwidth:=cel.w           -> Width of cel memblock to copy
  realcelheight:=cel.h
  imagebufoff:=(y*envw)+x
  celbufoff:=(cel.oy*cel.w)+cel.ox
->  a1:=cel.buf+(cel.w*sy)+sx
->  a2:=gbuf+(dy*envw)+dx
  /*
  ** Now the real fun starts. Here we copy cel image to our chunky
  ** buffer.
  */
  dbg('real cel w: \d\n',realcelwidth)
  dbg('real cel h: \d\n',realcelheight)
  dbg('modulo: \d\n',imagebufmod)
  -> examine real width
  IF realcelwidth>0
    -> examine real height
    IF realcelheight>0
      -> this loops copies all displayed lines from cel buffer
      FOR county:=0 TO realcelheight-1
        -> copy one line from cel buffer to image buffer
        FOR countx:=0 TO realcelwidth-1
          imagebuf[imagebufoff]:=cel.buf[celbufoff+countx]
          INC imagebufoff
        ENDFOR
        -> set image buffer offset to the nect line
        imagebufoff:=imagebufoff+envw
        celbufoff:=celbufoff+cel.w
      ENDFOR
    ENDIF
  ENDIF
ENDPROC
*/

/*
** Ta wersja prawie dziaîa, trzeba pomodziê w wewnëtrznej pëtli
PROC placecel(cel:PTR TO cel,x,y,ex,ey,ew,eh)
  DEF a1:PTR TO CHAR,a2:PTR TO CHAR
  DEF sx,sy,dx,dy,bb,cc
  DEF rw,rh
  DEF countx,county,celmask

  IF (ex<0)
    ew:=ew+ex
    ex:=0
  ENDIF
  IF (ey<0)
    eh:=eh+ey
    ey:=0
  ENDIF
  IF ((ew+ex)>envw) THEN ew:=envw-ex
  IF ((ey+eh)>envh) THEN eh:=envh-ey

  rw:=cel.w           -> Width of cel memblock to copy
  rh:=cel.h
  sx:=0                   -> Top-left corner of source cel memblock
  sy:=0
  dx:=x+cel.ox    -> Top-left corner in chunky buffer to place cel
  dy:=y+cel.oy

  IF (dx<=ex)
    sx:=(ex-dx)
    rw:=rw-sx
    dx:=ex
  ENDIF
  IF (dy<=ey)
    sy:=(ey-dy)
    rh:=rh-sy
    dy:=ey
  ENDIF
  bb:=ex+ew
  cc:=dx+rw
  IF ((cc-1)>=bb)
    rw:=rw-(cc-bb)+1
  ENDIF
  bb:=ey+eh
  cc:=dy+rh
  IF ((cc-1)>=bb)
    rh:=rh-(cc-bb)+1
  ENDIF
  a1:=cel.buf+(cel.w*sy)+sx
  a2:=ka.chunkybuf+(dy*envw)+dx
  rw:=rw-1
  rh:=rh-1

  IF rw>=0
    IF rh>=0
/*
      FOR county:=0 TO rh
        FOR countx:=0 TO rw
          a2[countx]:=a1[countx]
        ENDFOR
        a1:=a1+cel.w
        a2:=a2+envw
      ENDFOR
*/
      bb:=cel.w
      rw:=rw/4
      celmask:=cel.mask
      MOVEM   A0-A3/D0-D7,-(A7)       -> E seems to use a few of these variables. :(
      MOVE.L  rh,D1           -> outside loop (height)
      MOVE.L  bb,D5           -> celwidth
      MOVE.L  envw,D6         -> environment width
      MOVE.L  rw,D7           -> real width to copy
      MOVEQ   #0,D0           -> D4 is used with bytes
      MOVE.L  a1,D2           -> these point to left side of cel,env
      MOVE.L  a2,D3
      MOVE.L  celmask,A3

loopt:
      MOVE.L  D7,D0           -> inside loop (width)
      MOVE.L  D2,A1           -> grab left side of cel,env
      MOVE.L  D3,A2

loopi:
      MOVE.L  (A3)+,D4
      AND.L   D4,(A2)
      MOVE.L  (A1)+,D4
      OR.L    D4,(A2)+
zerobyte:
      DBRA.S  D0,loopi    -> finish inside loop
      ADD.L   D5,D2       -> point to one line below current
      ADD.L   D6,D3
      DBRA.S  D1,loopt    -> finish outside loop
      MOVEM   (A7)+,A0-A3/D0-D7

    ENDIF
  ENDIF
ENDPROC
*/


programversion:
CHAR '$VER: ',PROGRAMNAME,' ',PROGRAMVERSION,' (',PROGRAMDATE,')',0

PROC parseargs()
  DEF rdarg=0,args[10]:LIST,i
  DEF wb:PTR TO wbstartup /* startup message from Workbench */
  DEF wbargs:PTR TO wbarg   /* argument list struct.  We get a passed project */
  DEF wbdir[500]:STRING
  DEF olddir
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='parseargs()'
#endif

  /* Clear argument table */
  FOR i:=0 TO 9 DO args[i]:=NIL
  IF wbmessage=NIL
    rdarg:=ReadArgs('FILE',args,0)
    IF rdarg
      IF args[0]<>0
        StrCopy(ofilename,args[0],ALL)
      ENDIF
    ENDIF
  ELSE
    wb:=wbmessage
    wbargs:=wb.arglist
    wbargs:=wbargs+SIZEOF wbarg
    IF wb.numargs>1
      olddir:=CurrentDir(wbargs.lock)
      GetCurrentDirName(wbdir,250)
      StrCopy(ofilename,wbdir,ALL)
      eaddpart(ofilename,wbargs.name,499)
      CurrentDir(olddir)
    ENDIF
  ENDIF
ENDPROC

PROC init_libs()
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='init_libs()'
#endif
  -> locale library and catalog is opened first to allow PFK say anything to user
  localebase:=OpenLibrary('locale.library',0)
  NEW cat.create()
  cat.open()
  -> rest of the libraries
  IF (muimasterbase:=OpenLibrary(MUIMASTER_NAME,MUIMASTER_VMIN))=NIL THEN Throw(ERR_NOLIB,['muimaster',MUIMASTER_VMIN])
  IF (rexxsysbase:=OpenLibrary('rexxsyslib.library',0))=NIL THEN Throw(ERR_NOLIB,['rexxsyslib',0])
  IF (iffparsebase:=OpenLibrary('iffparse.library',37))=0 THEN Throw(ERR_NOLIB,['iffparse',37])
  IF (keymapbase:=OpenLibrary('keymap.library',37))=0 THEN Throw(ERR_NOLIB,['keymap',37])
  IF (utilitybase:=OpenLibrary('utility.library',37))=0 THEN Throw(ERR_NOLIB,['utility',37])
  IF (gadtoolsbase:=OpenLibrary('gadtools.library',37))=0 THEN Throw(ERR_NOLIB,['gadtools',37])
  IF (aslbase:=OpenLibrary('asl.library',37))=0 THEN Throw(ERR_NOLIB,['asl',37])
  IF (layersbase:=OpenLibrary('layers.library',39))=0 THEN Throw(ERR_NOLIB,['layers',39])
  IF (datatypesbase:=OpenLibrary('datatypes.library',39))=0 THEN Throw(ERR_NOLIB,['datatypes',39])
  xpkbase:=OpenLibrary('xpkmaster.library',2)
  pi96base:=OpenLibrary(P96NAME,2)
  cybergfxbase:=OpenLibrary('cybergraphics.library',40)
  qdbg(DBG_DONE)
ENDPROC

PROC end_libs()
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='end_libs()'
#endif
  IF muimasterbase THEN CloseLibrary(muimasterbase)
  IF rexxsysbase THEN CloseLibrary(rexxsysbase)
  IF iffparsebase THEN CloseLibrary(iffparsebase)
  IF keymapbase THEN CloseLibrary(keymapbase)
  IF utilitybase THEN CloseLibrary(utilitybase)
  IF gadtoolsbase THEN CloseLibrary(gadtoolsbase)
  IF aslbase THEN CloseLibrary(aslbase)
  IF layersbase THEN CloseLibrary(layersbase)
  IF datatypesbase THEN CloseLibrary(datatypesbase)
  IF xpkbase THEN CloseLibrary(xpkbase)
  IF pi96base THEN CloseLibrary(pi96base)
  IF cybergfxbase THEN CloseLibrary(cybergfxbase)
  IF localebase THEN CloseLibrary(localebase)
  IF cat THEN END cat
  qdbg(DBG_DONE)
ENDPROC

-> other initialization stuff
PROC init_others()
  DEF i
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='init_others()'
#endif

  NEW palet[16]
  NEW temprp;InitRastPort(temprp)
  NEW eventlist;newList(eventlist)
  NEW inputevent
  region:=NewRegion()

  -> create and install MUI hooks
  savememalloc(dhook,SIZEOF hook)
  installhook(dhook,{disphook})
  savememalloc(deshook,SIZEOF hook)
  installhook(deshook,{destructhook})
  savememalloc(conhook,SIZEOF hook)
  installhook(conhook,{constructhook})

  FOR i:=0 TO 15 DO palet[i].name:=String(500)
  FOR i:=1 TO 255 DO apens[i]:=-1
  apens[0]:=0
  bgpen:=-1
ENDPROC

PROC end_others()
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='end_others()'
#endif
  IF region THEN DisposeRegion(region)
ENDPROC

PROC main() HANDLE
  DEF i,goon
  DEF dumstr[100]:STRING
  DEF errormessage:PTR TO CHAR,errorinfo:PTR TO LONG
  DEF progdirlock,progdirname[128]:STRING

  -> we need kickstart 3.0 or better
  IF KickVersion(39)=FALSE
    WriteF('This program needs Kickstart 3.0 to work.\nUpgrade or rest in peace ;)\n')
    CleanUp(20)
  ENDIF

  -> open required libraries and stuff
  init_libs()
  init_pointers()
  init_others()

  loadprefs('ENV:playfkiss.prefs')

  -> obtain program's directory name
  progdirlock:=GetProgramDir()
  NameFromLock(progdirlock,progdirname,128)

  ap_main:=ApplicationObject,
    MUIA_Application_Author,        'Chad Randall and Michal Durys',
    MUIA_Application_Base,          'PLAYFKISS',
    MUIA_Application_Title,         PROGRAMNAME,
    MUIA_Application_Version,       {programversion},
    MUIA_Application_Copyright,     cat.msgAppCopyright.getstr(),
    MUIA_Application_Description,   cat.msgAppDescription.getstr(),
->    MUIA_Application_UseCommodities,'FALSE',
    MUIA_Application_UseRexx,       FALSE,

    SubWindow,wi_main:=WindowObject,
      MUIA_Window_Title,cat.msgLoaderWindowTitle.getstr(),
      MUIA_Window_ID,"MAIN",
      MUIA_Window_NoMenus,MUI_TRUE,
      WindowContents,VGroup,
        Child,VGroup,
          Child,HGroup,
            Child,ColGroup(2),
              Child,Label1(cat.msgLoaderStatus.getstr()),
              Child,g_status:=GaugeObject,
                MUIA_ShortHelp,cat.msgLoaderStatusHelp.getstr(),
                MUIA_Gauge_Horiz,MUI_TRUE,
                MUIA_Gauge_InfoText,cat.msgStatusHello.getstr(),
                GaugeFrame,
              End,
              Child, KeyLabel2(cat.msgLoaderSet.getstr(),"k"),
              Child,g_filename:=PopaslObject,
                MUIA_ShortHelp,cat.msgLoaderSetHelp.getstr(),
                MUIA_Popstring_String,g_file:=KeyString(progdirname,256,"k"),
                MUIA_Popstring_Button,PopButton(MUII_PopFile),
                MUIA_CycleChain,1,
                ASLFR_TITLETEXT,cat.msgRequestTitleSelectCNFFile.getstr(),
                ASLFR_INITIALPATTERN,'(#?.CNF|#?.LHA|#?.LZH|#?.LZX)',
                ASLFR_DOPATTERNS,MUI_TRUE,
              End,
            End,
/*
            Child,BodychunkObject,
              InputListFrame,
              MUIA_HorizDisappear,2,
              MUIA_FixWidth,IKGLOGO_WIDTH,
              MUIA_FixHeight,IKGLOGO_HEIGHT,
              MUIA_Bitmap_Width,IKGLOGO_WIDTH,
              MUIA_Bitmap_Height,IKGLOGO_HEIGHT,
              MUIA_Bodychunk_Depth,IKGLOGO_DEPTH,
              MUIA_Bodychunk_Body,{ikglogo_body},
              MUIA_Bodychunk_Compression,IKGLOGO_COMPRESSION,
              MUIA_Bitmap_SourceColors,{ikglogo_colors},
            End,
*/
          End,
          Child,VGroup,
            MUIA_VertDisappear,2,
            MUIA_Weight, 20000,
            Child,g_listview:=ListviewObject,
              MUIA_Listview_Input,FALSE,
              MUIA_ShortHelp,cat.msgLoaderSetInfoHelp.getstr(),
              MUIA_Listview_List,g_list:=ListObject,
                ReadListFrame,
                MUIA_List_ConstructHook,conhook,
                MUIA_List_DestructHook,deshook,
                MUIA_List_Title,MUI_TRUE,
                MUIA_List_DisplayHook,dhook,
                MUIA_List_Format,'MIW=1 MAW=1,MIW=90 MAW=100,MIW=1 MAW=1,MIW=1 MAW=1,MIW=1 MAW=1,MIW=1 MAW=1,MIW=1 MAW=1',
              End,
            End,
          End,
          Child,VGroup,
            GroupFrame,
            MUIA_ShortHelp,cat.msgLoaderSetInfoHelp.getstr(),
            MUIA_VertDisappear,3,
              Child,ColGroup(3),
                Child,ColGroup(2),
                  Child,Label(cat.msgLoaderSetStatsObjects.getstr()),
                  Child,g_objs:=TextObject,MUIA_Text_Contents,'1024',End,
                  Child,Label(cat.msgLoaderSetStatsCels.getstr()),
                  Child,g_cels:=TextObject,MUIA_Text_Contents,'1024',End,
                End,
                Child,ColGroup(2),
                  Child,Label(cat.msgLoaderSetStatsEvents.getstr()),
                  Child,g_events:=TextObject,MUIA_Text_Contents,'64738',End,
                  Child,Label(cat.msgLoaderSetStatsActions.getstr()),
                  Child,g_actions:=TextObject,MUIA_Text_Contents,'64738',End,
                End,
                Child,ColGroup(2),
                  Child,Label(cat.msgLoaderSetStatsColors.getstr()),
                  Child,g_colors:=TextObject,MUIA_Text_Contents,'256',End,
                  Child,Label(cat.msgLoaderSetStatsMemory.getstr()),
                  Child,g_memory:=TextObject,MUIA_Text_Contents,'2000000',End,
                End,
              End,
            End,
            Child,VGroup,
              MUIA_VertDisappear,1,
              Child,g_errors:=ListviewObject,
                MUIA_Listview_Input,FALSE,
                MUIA_Weight,2,
                MUIA_ShortHelp,cat.msgLoaderErrorlistHelp.getstr(),
                MUIA_Listview_List,g_errorlist:=ListObject,
                  ReadListFrame,
                  MUIA_List_ConstructHook,MUIV_List_ConstructHook_String,
                  MUIA_List_DestructHook,MUIV_List_DestructHook_String,
                  MUIA_List_Title,cat.msgLoaderErrorlist.getstr(),
                End,
              End,
            End,
            Child,RectangleObject,
              MUIA_Rectangle_HBar,MUI_TRUE,
              MUIA_Weight,0,
            End,
            Child,HGroup,
              Child,g_play:=TextObject,
                ButtonFrame,
                MUIA_Text_Contents,cat.msgLoaderPlay.getstr(),
                MUIA_Text_PreParse,'\ec',
                MUIA_Text_HiChar,"p",
                MUIA_ControlChar,"p",
                MUIA_CycleChain,1,
                MUIA_InputMode,MUIV_InputMode_RelVerify,
                MUIA_Background,MUII_ButtonBack,
                MUIA_ShortHelp,cat.msgLoaderPlayHelp.getstr(),
              End,
              Child,g_prefs:=TextObject,
                ButtonFrame,
                MUIA_Text_Contents,cat.msgLoaderPrefs.getstr(),
                MUIA_Text_PreParse,'\ec',
                MUIA_Text_HiChar,"r",
                MUIA_ControlChar,"r",
                MUIA_CycleChain,1,
                MUIA_InputMode,MUIV_InputMode_RelVerify,
                MUIA_Background,MUII_ButtonBack,
                MUIA_ShortHelp,cat.msgLoaderPrefsHelp.getstr(),
              End,
              Child,g_about:=TextObject,
                ButtonFrame,
                MUIA_Text_Contents,cat.msgLoaderAbout.getstr(),
                MUIA_Text_PreParse,'\ec',
                MUIA_Text_HiChar,"a",
                MUIA_ControlChar,"a",
                MUIA_CycleChain,1,
                MUIA_InputMode,MUIV_InputMode_RelVerify,
                MUIA_Background,MUII_ButtonBack,
                MUIA_ShortHelp,cat.msgLoaderAboutHelp.getstr(),
              End,
              Child,g_quit:=TextObject,
                ButtonFrame,
                MUIA_Text_Contents,cat.msgLoaderQuit.getstr(),
                MUIA_Text_PreParse,'\ec',
                MUIA_Text_HiChar,"q",
                MUIA_ControlChar,"q",
                MUIA_CycleChain,1,
                MUIA_InputMode,MUIV_InputMode_RelVerify,
                MUIA_Background,MUII_ButtonBack,
                MUIA_ShortHelp,cat.msgLoaderQuitHelp.getstr(),
              End,
            End,
          End,
        End,
      End,

        SubWindow,wi_edit:=WindowObject,
            MUIA_Window_Title,cat.msgEditWindowTitle.getstr(),
            MUIA_Window_ID,"EDIT",
            WindowContents,RegisterGroup([cat.msgEditObjectPage.getstr(),cat.msgEditCelPage.getstr(),0]),
                Child,HGroup,
                    Child,RectangleObject,
                        MUIA_Weight,5,
                    End,
                    Child,VGroup,
                        Child,ColGroup(4),
                            MUIA_ShortHelp,cat.msgEditObjectStatics.getstr(),
                            Child,ColGroup(2),
                                Child,Label(cat.msgEditObjectNumber.getstr()),
                                Child,g_eobj:=TextObject,MUIA_Text_Contents,'1024',End,
                                Child,Label(cat.msgEditObjectWidth.getstr()),
                                Child,g_ewidth:=TextObject,MUIA_Text_Contents,'1024',End,
                                Child,Label(cat.msgEditObjectXPos.getstr()),
                                Child,g_ex:=TextObject,MUIA_Text_Contents,'1024',End,
                            End,
                            Child,ColGroup(2),
                                Child,Label(cat.msgEditObjectCelNumber.getstr()),
                                Child,g_ecels:=TextObject,MUIA_Text_Contents,'1024',End,
                                Child,Label(cat.msgEditObjectHeight.getstr()),
                                Child,g_eheight:=TextObject,MUIA_Text_Contents,'1024',End,
                                Child,Label(cat.msgEditObjectYPos.getstr()),
                                Child,g_ey:=TextObject,MUIA_Text_Contents,'1024',End,
                            End,
                        End,
                        Child,HGroup,
                            Child,g_resetpos:=SimpleButton(cat.msgEditObjectResetPosition.getstr()),
                            Child,g_undopos:=SimpleButton(cat.msgEditObjectUndoPosition.getstr()),
                        End,
                        Child,HGroup,
                            Child,g_efix:=StringObject,
                                MUIA_String_Accept,'0123456789',
                                MUIA_String_Integer,0,
                                MUIA_ShortHelp,cat.msgEditObjectFixValueHelp.getstr(),
                                StringFrame,
                            End,
                            Child,g_estore:=SimpleButton(cat.msgEditObjectStore.getstr()),
                        End,
                        Child,HGroup,
                            Child,g_eresetfix:=SimpleButton(cat.msgEditObjectReset.getstr()),
                            Child,g_eunfix:=SimpleButton(cat.msgEditObjectUnfix.getstr()),
                            Child,g_emaxfix:=SimpleButton(cat.msgEditObjectMax.getstr()),
                        End,
                    End,
                    Child,RectangleObject,
                        MUIA_Weight,5,
                    End,
                End,
                Child,VGroup,
                    Child,ColGroup(2),
                        Child,Label(cat.msgEditCelCel.getstr()),
                        Child,g_ecel:=TextObject,MUIA_Text_Contents,'1024',End,
                        Child,KeyLabel(cat.msgEditCelColorSet.getstr(),"s"),
                        Child,g_ecset:=SliderObject,
                            MUIA_Numeric_Max,15,
                            MUIA_Numeric_Value,15,
               MUIA_ControlChar,"s",
                        End,
                        Child,Label(cat.msgEditCelName.getstr()),
                        Child,g_ename:=TextObject,MUIA_Text_Contents,'NONAMEYET.CEL',End,
                    End,
                    Child,ColGroup(4),
                        Child,KeyLabel(cat.msgEditCelYOffset.getstr(),"x"),
                        Child,g_ecoffx:=NumericbuttonObject,
                            MUIA_Numeric_Max,640,
                            MUIA_ControlChar,"x",
                        End,
                        Child,KeyLabel(cat.msgEditCelYOffset.getstr(),"y"),
                        Child,g_ecoffy:=NumericbuttonObject,
                            MUIA_Numeric_Max,640,
                            MUIA_ControlChar,"y",
                        End,
                        Child,Label(cat.msgEditCelWidth.getstr()),
                        Child,g_ecwidth:=TextObject,MUIA_Text_Contents,'1024',End,
                        Child,Label(cat.msgEditCelWidth.getstr()),
                        Child,g_echeight:=TextObject,MUIA_Text_Contents,'1024',End,
                        
                    End,
                    Child,HGroup,
                        Child,g_efor:=KeyButton(cat.msgEditCelForwards.getstr(),"f"),
                        Child,g_eback:=KeyButton(cat.msgEditCelBackwards.getstr(),"b"),
                        Child,g_ehide:=KeyButton(cat.msgEditCelHide.getstr(),"h"),
                    End,
                End,
            End,
        End,
                
        SubWindow,wi_about:=WindowObject,
            MUIA_Window_Title,cat.msgAboutWindowTitle.getstr(),
            MUIA_Window_ID,"ABBA",
            MUIA_Window_SizeGadget,FALSE,
            WindowContents,VGroup,
                MUIA_Background,MUII_RequesterBack,
                Child,HGroup,
                    Child,HSpace(0),
/*
                    Child,BodychunkObject,
                        MUIA_FixWidth,IKGLOGO_WIDTH,
                        MUIA_FixHeight,IKGLOGO_HEIGHT,
                        MUIA_Bitmap_Width,IKGLOGO_WIDTH,
                        MUIA_Bitmap_Height,IKGLOGO_HEIGHT,
                        MUIA_Bodychunk_Depth,IKGLOGO_DEPTH,
                        MUIA_Bodychunk_Body,{ikglogo_body},
                        MUIA_Bodychunk_Compression,IKGLOGO_COMPRESSION,
                        MUIA_Bitmap_SourceColors,{ikglogo_colors},
                    End,
                    Child,HSpace(0),
*/
                End,
                Child,TextObject,
                  GroupFrame,
->                  MUIA_Background,MUII_SHADOW,
                  MUIA_Text_Contents,{programabouttext},
                  MUIA_ShortHelp,cat.msgAboutListviewHelp.getstr(),
                End,
                Child,g_about_okay:=KeyButton(cat.msgAboutOk.getstr(),"o"),
            End,
        End,

        SubWindow,wi_prefs:=WindowObject,
            MUIA_Window_Title,cat.msgPrefsWindowTitle.getstr(),
            MUIA_Window_ID,"PREF",
            WindowContents,VGroup,
                Child, ColGroup(2),
                    Child, KeyLabel1(cat.msgPrefsScreenMode.getstr(),"m"),
                    Child, HGroup,MUIA_Group_Spacing,0,
                        Child,g_modename:=TextObject,
                            TextFrame,
                            MUIA_Background,MUII_TextBack,
                        End,
                        Child,g_getmode:=ImageObject,
                            MUIA_Image_Spec,MUII_PopUp,
                            MUIA_Image_FreeVert,MUI_TRUE,
                            MUIA_InputMode,MUIV_InputMode_RelVerify,
                            MUIA_ControlChar,"m",
                            ImageButtonFrame,
                        End,
                    End,

                    Child, KeyLabel1(cat.msgPrefsAnimationSpeed.getstr(),"a"),
                    Child, g_pspeed:=SliderObject,
                        MUIA_Numeric_Min,0,
                        MUIA_Numeric_Max,50,
                        MUIA_Numeric_Value,0,
                        MUIA_ControlChar,"a",
                        MUIA_ShortHelp,cat.msgPrefsAnimationSpeedHelp.getstr(),
                    End,
                End,
                Child, ColGroup(2),
                    Child, ColGroup(3),
                        Child, HSpace(0),
                        Child, KeyLabel1(cat.msgPrefsEnforceBounds.getstr(),"e"),
                        Child, g_penforce:=KeyCheckMark(FALSE,"e"),
                        Child, HSpace(0),
                        Child, KeyLabel1(cat.msgPrefsFollowMouse.getstr(),"f"),
                        Child, g_pfollow:=KeyCheckMark(FALSE,"f"),
                        Child, HSpace(0),
                        Child, KeyLabel1(cat.msgPrefsElasticFix.getstr(),"x"),
                        Child, g_pelastic:=KeyCheckMark(FALSE,"x"),
                    End,
                    Child, ColGroup(3),
                        Child,HSpace(0),
                        Child,KeyLabel1(cat.msgPrefsWBWindow.getstr(),"w"),
                        Child,g_pworkbench:=KeyCheckMark(FALSE,"w"),
                        Child,HSpace(0),
                        Child,KeyLabel1(cat.msgPrefsUseRTG.getstr(),"y"),
                        Child,g_pcyber:=KeyCheckMark(FALSE,"y"),
                    End,
                End,
                Child, ColGroup(4),
                    Child,KeyLabel2(cat.msgPrefsUpdate.getstr(),"d"),
                    Child,g_pupdate:=KeyCycle([cat.msgPrefsUpdateObjectRegions.getstr(),cat.msgPrefsUpdateCelRegions.getstr(),cat.msgPrefsUpdateSimpleSquare.getstr(),TAG_END],"d"),
                    Child,KeyLabel2(cat.msgPrefsPointer.getstr(),"p"),
                    Child,g_ppointer:=KeyCycle([cat.msgPrefsPointerSystem.getstr(),cat.msgPrefsPointerHand.getstr(),cat.msgPrefsPointerBlank.getstr(),TAG_END],"p"),
                End,
                Child, RectangleObject,
                    MUIA_Rectangle_HBar,MUI_TRUE,
                    MUIA_Weight,0,
                End,
                Child, HGroup,
                    Child, g_psave:=SimpleButton(cat.msgPrefsSave.getstr()),
                    Child, g_puse:=SimpleButton(cat.msgPrefsUse.getstr()),
                    Child, g_pcancel:=SimpleButton(cat.msgPrefsCancel.getstr()),
                End,
            End,
        End,
        SubWindow,wi_reveal:=WindowObject,
            MUIA_Window_Title,'Reveal',
            MUIA_Window_ID,"SHOW",
            WindowContents,VGroup,
                Child, RectangleObject,
                    MUIA_Rectangle_HBar,MUI_TRUE,
                    MUIA_Rectangle_BarTitle,'Reveal which cel?',
                    MUIA_Weight,0,
                End,
                Child,g_revealview:=ListviewObject,
                    MUIA_Listview_Input,MUI_TRUE,
                    MUIA_Listview_List,g_reveallist:=ListObject,
                        InputListFrame,
                        MUIA_List_ConstructHook,MUIV_List_ConstructHook_String,
                        MUIA_List_DestructHook,MUIV_List_DestructHook_String,
                    End,
                End,
            End,
        End,

        SubWindow,wi_output:=WindowObject,
            MUIA_Window_Title,cat.msgOutputWindowTitle.getstr(),
            MUIA_Window_ID,"OUT",
            WindowContents,VGroup,
                Child,g_outputlist:=ListviewObject,
->                    MUIA_Listview_Input,MUI_TRUE,
                    MUIA_Listview_List,ListObject,
                        InputListFrame,
                        MUIA_List_ConstructHook,MUIV_List_ConstructHook_String,
                        MUIA_List_DestructHook,MUIV_List_DestructHook_String,
                    End,
                End,
            End,
        End,
    End -> End main

    
    IF ap_main=0 THEN Raise(ERR_MUIAPP)

    getscreenname()

    domethod(g_prefs,[MUIM_Notify,MUIA_Pressed,FALSE,wi_prefs,3,MUIM_Set,MUIA_Window_Open,MUI_TRUE])
    domethod(g_about,[MUIM_Notify,MUIA_Pressed,FALSE,ap_main,2,MUIM_Application_ReturnID,ID_ABOUT])
    domethod(g_play,[MUIM_Notify,MUIA_Pressed,FALSE,ap_main,2,MUIM_Application_ReturnID,ID_PLAY])
    domethod(g_file,[MUIM_Notify,MUIA_String_Acknowledge,MUIV_EveryTime,ap_main,2,MUIM_Application_ReturnID,ID_FILE])
    domethod(g_quit,[MUIM_Notify,MUIA_Pressed,FALSE,ap_main,2,MUIM_Application_ReturnID,MUIV_Application_ReturnID_Quit])

    domethod(g_revealview,[MUIM_Notify,MUIA_Listview_DoubleClick,MUI_TRUE,ap_main,2,MUIM_Application_ReturnID,ID_REVEAL])

    addbutnotify(g_resetpos,ID_RESETPOS)
    addbutnotify(g_undopos,ID_UNDOPOS)
    addidnotify(g_efix,MUIA_String_Acknowledge,MUIV_EveryTime,ID_EFIX)
    addbutnotify(g_estore,ID_ESTORE)
    addbutnotify(g_eresetfix,ID_ERESETFIX)
    addbutnotify(g_eunfix,ID_EUNFIX)
    addbutnotify(g_emaxfix,ID_EMAXFIX)
    addidnotify(g_ecset,MUIA_Numeric_Value,MUIV_EveryTime,ID_ECSET)
    addidnotify(g_ecoffx,MUIA_Numeric_Value,MUIV_EveryTime,ID_ECOFFX)
    addidnotify(g_ecoffy,MUIA_Numeric_Value,MUIV_EveryTime,ID_ECOFFY)
    addbutnotify(g_eback,ID_EBACK)
    addbutnotify(g_efor,ID_EFORWARD)
    addbutnotify(g_ehide,ID_EHIDE)

    addidnotify(wi_prefs,MUIA_Window_Open,MUI_TRUE,ID_POPEN)
    addbutnotify(g_getmode,ID_PMODE)
    addidnotify(g_pspeed,MUIA_Numeric_Value,MUIV_EveryTime,ID_PSPEED)
    addidnotify(g_penforce,MUIA_Selected,MUIV_EveryTime,ID_PENFORCE)
    addidnotify(g_pfollow,MUIA_Selected,MUIV_EveryTime,ID_PFOLLOW)
    addidnotify(g_pelastic,MUIA_Selected,MUIV_EveryTime,ID_PELASTIC)
    addidnotify(g_pworkbench,MUIA_Selected,MUIV_EveryTime,ID_PWORKBENCH)
    addidnotify(g_pcyber,MUIA_Selected,MUIV_EveryTime,ID_PCYBER)
    addidnotify(g_pupdate,MUIA_Cycle_Active,MUIV_EveryTime,ID_PUPDATE)
    addidnotify(g_ppointer,MUIA_Cycle_Active,MUIV_EveryTime,ID_PPOINTER)

    domethod(g_pcancel,[MUIM_Notify,MUIA_Pressed,FALSE,wi_prefs,3,MUIM_Set,MUIA_Window_Open,FALSE])
    addidnotify(g_psave,MUIA_Pressed,FALSE,ID_PSAVE)
    addidnotify(g_puse,MUIA_Pressed,FALSE,ID_PUSE)

    domethod(wi_main,[MUIM_Notify,MUIA_Window_CloseRequest,MUI_TRUE,ap_main,2,MUIM_Application_ReturnID,MUIV_Application_ReturnID_Quit])
    domethod(wi_prefs,[MUIM_Notify,MUIA_Window_CloseRequest,MUI_TRUE,wi_prefs,3,MUIM_Set,MUIA_Window_Open,FALSE])
    domethod(wi_edit,[MUIM_Notify,MUIA_Window_CloseRequest,MUI_TRUE,wi_edit,3,MUIM_Set,MUIA_Window_Open,FALSE])
    domethod(wi_reveal,[MUIM_Notify,MUIA_Window_CloseRequest,MUI_TRUE,wi_reveal,3,MUIM_Set,MUIA_Window_Open,FALSE])
    domethod(wi_output,[MUIM_Notify,MUIA_Window_CloseRequest,MUI_TRUE,wi_output,3,MUIM_Set,MUIA_Window_Open,FALSE])

    domethod(wi_about,[MUIM_Notify,MUIA_Window_CloseRequest,MUI_TRUE,wi_about,3,MUIM_Set,MUIA_Window_Open,FALSE])
    domethod(g_about_okay,[MUIM_Notify,MUIA_Pressed,FALSE,wi_about,3,MUIM_Set,MUIA_Window_Open,FALSE])

    set(g_resetpos,MUIA_ShortHelp,'Resets object to initial coordinates.')
    set(g_undopos,MUIA_ShortHelp,'Undos last object movement.')
    set(g_estore,MUIA_ShortHelp,'Stores current fix value as default.')
    set(g_eresetfix,MUIA_ShortHelp,'Resets current object fix value to default.')
    set(g_eunfix,MUIA_ShortHelp,'Sets current object fix value to 0.')
    set(g_emaxfix,MUIA_ShortHelp,'Sets current object fix value to 32768.')

    smr:=AllocAslRequest(ASL_SCREENMODEREQUEST,[ASLSM_PUBSCREENNAME,'Workbench',ASLSM_DODEPTH,FALSE,ASLSM_DOWIDTH,FALSE,ASLSM_DOHEIGHT,FALSE,ASLSM_DOOVERSCANTYPE,TRUE,ASLSM_DOAUTOSCROLL,TRUE,NIL])
    filereq:=AllocAslRequest(ASL_FILEREQUEST,[ASLSM_PUBSCREENNAME,'Workbench',ASLFR_INITIALPATTERN,'(#?.CNF|#?.LHA|#?.LZH|#?.LZX)',TAG_END]:LONG)
    FOR i:=0 TO MAXOBJS DO objs[i]:=NIL
    FOR i:=0 TO MAXCELS DO cels[i]:=NIL
    StrCopy(afname,progdirname)
    StrCopy(ofilename,progdirname)
    parseargs()
    goon:=QUIT_CLOSE
    WHILE goon=QUIT_CLOSE
        setloaded:=0
        IF loadcnf()=4
            IF setloaded
                prekiss()
                tempbitmap:=AllocBitMap(1024,1,8,BMF_CLEAR,scr.rastport.bitmap)
                temprp.bitmap:=tempbitmap
                ready()
                goon:=playkiss()
                postkiss()
            ENDIF
        ELSE
            goon:=QUIT_QUIT
        ENDIF
        IF StrLen(afname)
            splitname(afname,ofilename,dumstr)
        ENDIF
        IF (StrLen(ofilename)>0) THEN StrAdd(ofilename,'/')
    ENDWHILE
EXCEPT DO
  IF exception>ERR_NONE
    errormessage:=String(256)
    errorinfo:=exceptioninfo
    /*
    ** This section below is responsible for showing information about
    ** error that had occured. exceptioninfo in most cases is a pointer
    ** to a list of informations about error.
    */
    SELECT exception
    -> errorinfo:=[name,version]
    CASE ERR_NOLIB
      IF errorinfo[1]=0
        StringF(errormessage,'Missing \s.library!',errorinfo[0])
      ELSE
        StringF(errormessage,cat.msgErrorNoLibraryVersion.getstr(),errorinfo[1],errorinfo[0])
      ENDIF
    -> errorinfo:=[width,height,depth]
    CASE ERR_OPENSCREEN
      StringF(errormessage,cat.msgErrorOpenScreen.getstr(),errorinfo[1],errorinfo[0],errorinfo[2])
    -> errorinfo:=[width,height,flags,idcmp]
    CASE ERR_OPENWINDOW
      StringF(errormessage,cat.msgErrorOpenWindow.getstr(),errorinfo[0],errorinfo[1],errorinfo[2],errorinfo[3])
    -> errorinfo:=NIL
    CASE ERR_MUIAPP
      StrCopy(errormessage,cat.msgErrorNoMUIApplication.getstr())
    -> errorinfo:=NIL
    CASE ERR_CREATEMENU
      StrCopy(errormessage,cat.msgErrorCreateMenu.getstr())
    -> Default error message
    DEFAULT
      StringF(errormessage,'Unknown exception!\nError: \d\nInfo: \d',exception,exceptioninfo)
    ENDSELECT
    reporterror(errormessage,exception)
  ENDIF
/*
    SELECT exception
    CASE 0;NOP
    CASE "MEM";err('Not enough memory.')
    CASE "VIS";err('Can\t obtain visual structure.')
    CASE "file";err('File error.')
    CASE "err";err('Misc. error?')
    ENDSELECT
*/
  postkiss()
  freecels()
  freeobjs()
  freepals()
  freeevents()
  IF smr THEN FreeAslRequest(smr)
  IF filereq THEN FreeAslRequest(filereq)
  IF tempbitmap THEN FreeBitMap(tempbitmap)

  IF ap_main THEN Mui_DisposeObject(ap_main)

  end_others()
  end_pointers()
  end_libs()
ENDPROC

PROC reporterror(message,errnum)
  DEF reqtitle[20]:STRING
  StringF(reqtitle,PROGRAMNAME+' Error #\d',errnum)
  IF muimasterbase
    Mui_RequestA(ap_main,wi_main,0,reqtitle,'OK',message,NIL)
  ELSE
    EasyRequestArgs(NIL,[SIZEOF easystruct,0,reqtitle,message,'OK'],0,NIL)
  ENDIF
ENDPROC

PROC init_pointers()
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='init_pointers()'
#endif
  NEW hbm1,hbm2,hbm3,hbm4
  hbm1.bytesperrow:=2
  hbm1.rows:=15
  hbm1.depth:=2
  hbm1.planes[0]:={hand1dataa}
  hbm1.planes[1]:={hand1datab}
  hbm2.bytesperrow:=2
  hbm2.rows:=15
  hbm2.depth:=2
  hbm2.planes[0]:={hand2dataa}
  hbm2.planes[1]:={hand2datab}
  hbm3.bytesperrow:=2
  hbm3.rows:=1
  hbm3.depth:=2
  hbm3.planes[0]:={hand3dataa}
  hbm3.planes[1]:={hand3datab}
  hbm4.bytesperrow:=2
  hbm4.rows:=15
  hbm4.depth:=2
  hbm4.planes[0]:={hand4dataa}
  hbm4.planes[1]:={hand4datab}
  hand1:=NewObjectA(NIL,'pointerclass',[POINTERA_BITMAP,hbm1,
                            POINTERA_XOFFSET,-1,
                            POINTERA_YOFFSET,-1,
                            POINTERA_XRESOLUTION,POINTERXRESN_SCREENRES,
                            POINTERA_YRESOLUTION,POINTERYRESN_SCREENRESASPECT,
                            NIL,NIL])
  hand2:=NewObjectA(NIL,'pointerclass',[POINTERA_BITMAP,hbm2,
                            POINTERA_XOFFSET,-3,
                            POINTERA_YOFFSET,-3,
                            POINTERA_XRESOLUTION,POINTERXRESN_SCREENRES,
                            POINTERA_YRESOLUTION,POINTERYRESN_SCREENRESASPECT,
                            NIL,NIL])
  hand3:=NewObjectA(NIL,'pointerclass',[POINTERA_BITMAP,hbm3,
                            POINTERA_XRESOLUTION,POINTERXRESN_HIRES,
                            POINTERA_YRESOLUTION,POINTERYRESN_HIGH,
                            POINTERA_XOFFSET,0,
                            POINTERA_YOFFSET,0,
                            NIL,NIL])
  hand4:=NewObjectA(NIL,'pointerclass',[POINTERA_BITMAP,hbm4,
                            POINTERA_XRESOLUTION,POINTERXRESN_SCREENRES,
                            POINTERA_YRESOLUTION,POINTERYRESN_SCREENRESASPECT,
                            POINTERA_XOFFSET,-6,
                            POINTERA_YOFFSET,-6,
                            NIL,NIL])
ENDPROC

PROC end_pointers()
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='end_pointers()'
#endif
  IF hand1 THEN DisposeObject(hand1)
  IF hand2 THEN DisposeObject(hand2)
  IF hand3 THEN DisposeObject(hand3)
  IF hand4 THEN DisposeObject(hand4)
ENDPROC

PROC changeset(newset)
    DEF ev=0
    IF (curset=newset) THEN RETURN
    ev:=findeventtype(EV_SET,newset)
    curset:=newset
    changepal(pb[curset])
    IF ev
        runcommands(ev)
    ENDIF
    check(menu,MENU_SET0,FALSE)
    check(menu,MENU_SET1,FALSE)
    check(menu,MENU_SET2,FALSE)
    check(menu,MENU_SET3,FALSE)
    check(menu,MENU_SET4,FALSE)
    check(menu,MENU_SET5,FALSE)
    check(menu,MENU_SET6,FALSE)
    check(menu,MENU_SET7,FALSE)
    check(menu,MENU_SET8,FALSE)
    check(menu,MENU_SET9,FALSE)
    SELECT curset
        CASE 0;check(menu,MENU_SET0,TRUE)
        CASE 1;check(menu,MENU_SET1,TRUE)
        CASE 2;check(menu,MENU_SET2,TRUE)
        CASE 3;check(menu,MENU_SET3,TRUE)
        CASE 4;check(menu,MENU_SET4,TRUE)
        CASE 5;check(menu,MENU_SET5,TRUE)
        CASE 6;check(menu,MENU_SET6,TRUE)
        CASE 7;check(menu,MENU_SET7,TRUE)
        CASE 8;check(menu,MENU_SET8,TRUE)
        CASE 9;check(menu,MENU_SET9,TRUE)
    ENDSELECT
ENDPROC

PROC changepal(newpal)
  DEF event=NIL
  -> check if this set uses col event
  event:=findeventtype(EV_COL,newpal)
  -> if so, then execute commands connected with this event
  IF event THEN runcommands(event)
  check(menu,MENU_CSET0,FALSE)
  check(menu,MENU_CSET1,FALSE)
  check(menu,MENU_CSET2,FALSE)
  check(menu,MENU_CSET3,FALSE)
  check(menu,MENU_CSET4,FALSE)
  check(menu,MENU_CSET5,FALSE)
  check(menu,MENU_CSET6,FALSE)
  check(menu,MENU_CSET7,FALSE)
  check(menu,MENU_CSET8,FALSE)
  check(menu,MENU_CSET9,FALSE)
  curpal:=Bounds(newpal,0,9)
  SELECT curpal
    CASE 0;check(menu,MENU_CSET0,TRUE)
    CASE 1;check(menu,MENU_CSET1,TRUE)
    CASE 2;check(menu,MENU_CSET2,TRUE)
    CASE 3;check(menu,MENU_CSET3,TRUE)
    CASE 4;check(menu,MENU_CSET4,TRUE)
    CASE 5;check(menu,MENU_CSET5,TRUE)
    CASE 6;check(menu,MENU_CSET6,TRUE)
    CASE 7;check(menu,MENU_CSET7,TRUE)
    CASE 8;check(menu,MENU_CSET8,TRUE)
    CASE 9;check(menu,MENU_CSET9,TRUE)
  ENDSELECT
  updatecolors()
ENDPROC

PROC moveback() -> celnum:=celnul-1
  DEF cn=-1,i
  DEF cel:PTR TO cel
  DEF swapcel:PTR TO cel
  IF lastcel
    IF lastobj
      FOR i:=0 TO MAXCELS
        cel:=cels[i]
        IF cel=lastcel
          cn:=i
        ENDIF
      ENDFOR
    ENDIF
  ENDIF
  IF cn>0
    swapcel:=cels[cn-1]
    IF swapcel
      i:=cels[cn-1]
      cels[cn-1]:=cels[cn]
      cels[cn]:=i
      prechange()
      orcel(lastcel,lastobj)
      postchange()
      updateobjwin()
      updatereveal()
    ENDIF
  ENDIF
ENDPROC

PROC moveforward()  -> celnum:=celnum+1
  DEF cn=-1,i
  DEF cel:PTR TO cel
  DEF swapcel:PTR TO cel
  prechange()
  IF lastcel
    IF lastobj
      FOR i:=0 TO MAXCELS
        cel:=cels[i]
        IF cel=lastcel
          cn:=i
        ENDIF
      ENDFOR
    ENDIF
  ENDIF
  IF cn>-1
    IF cn<MAXCELS
      swapcel:=cels[cn+1]
      IF swapcel
        i:=cels[cn+1]
        cels[cn+1]:=cels[cn]
        cels[cn]:=i
        prechange()
        orcel(lastcel,lastobj)
        postchange()
        updateobjwin()
        updatereveal()
      ENDIF
    ENDIF
  ENDIF
ENDPROC

PROC hidecel()
  IF lastcel=NIL THEN RETURN
  lastcel.setset(curset,0)
  prechange()
  orcel(lastcel,lastobj)
  postchange()
  updateobjwin()
ENDPROC

PROC openobjwin()
  set(wi_edit,MUIA_Window_Open,MUI_TRUE)
  updateobjwin()
ENDPROC

PROC setslidefix(val)
  IF lastobj=NIL THEN RETURN
  lastobj.setfix(val)
ENDPROC

PROC updateobjwin()
  DEF w=0,h=0,i,cel:PTR TO cel
  DEF cn=-1
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='updateobjwin()'
#endif
  IF lastobj
    IF lastcel
      FOR i:=MAXCELS TO 0 STEP -1
        cel:=cels[i]
        IF cel
          IF (cel=lastcel)
            cn:=MAXCELS-i
          ENDIF
        ELSE
          i:=-1
        ENDIF
      ENDFOR
      setn(g_eobj,lastobj.number)
      setn(g_ecels,lastobj.countmembers())
      setn(g_ewidth,lastobj.width())
      setn(g_eheight,lastobj.height())
      setn(g_ex,lastobj.x[curset])
      setn(g_ey,lastobj.y[curset])
      set(g_efix,MUIA_String_Integer,lastobj.fix)
      setn(g_ecel,cn)
      w:=IF (lastcel.bit_per_pixel=4) THEN 15 ELSE 0
      set(g_ecset,MUIA_Numeric_Max,w)
      set(g_ecset,MUIA_Numeric_Value,lastcel.palet_num)
      set(g_ename,MUIA_Text_Contents,lastcel.realname)
      set(g_ecoffx,MUIA_Numeric_Value,lastcel.ox)
      set(g_ecoffy,MUIA_Numeric_Value,lastcel.oy)
      setn(g_ecwidth,lastcel.w)
      setn(g_echeight,lastcel.h)
    ENDIF
  ENDIF
/*
    IF objh
            setnum(objh,celnnum,cn)
            settext(objh,celntext,lastcel.realname)
            setnum(objh,celxtext,lastcel.ox)
            setnum(objh,celytext,lastcel.oy)
            setnum(objh,celwtext,lastcel.w)
            setnum(objh,celhtext,lastcel.h)
        ELSE
            setnum(objh,objwtext,-1)
            setnum(objh,objhtext,-1)
            setnum(objh,objmtext,-1)
            setinteger(objh,objftext,0)
            setnum(objh,objntext,-1)
            setnum(objh,objxtext,-1)
            setnum(objh,objytext,-1)

            setnum(objh,celnnum,-1)
            settext(objh,celntext,'N/A')
            setnum(objh,celxtext,-1)
            setnum(objh,celytext,-1)
            setnum(objh,celwtext,-1)
            setnum(objh,celhtext,-1)
        ENDIF
    ENDIF
*/
ENDPROC

PROC prekiss()
  DEF res=0
  openscr()
ENDPROC res

PROC updatereveal()
  DEF cel:PTR TO cel,i
  DEF tmpstr[500]:STRING
  domethod(g_reveallist,[MUIM_List_Clear])
  FOR i:=MAXCELS TO 0 STEP -1
    IF cels[i]
      cel:=cels[i]
      StringF(tmpstr,'#\d[4] "\s"',MAXCELS-i,cel.realname)
      domethod(g_reveallist,[MUIM_List_InsertSingle,tmpstr,MUIV_List_Insert_Bottom])
    ENDIF
  ENDFOR
ENDPROC

->PROC revealp(a,val) IS revealpick:=val

PROC revealordinal(ii)
  DEF cel:PTR TO cel
  DEF obj:PTR TO obj
  ii:=MAXCELS-ii
  cel:=cels[ii]
  IF cel=NIL THEN RETURN
  obj:=objs[cel.obj]
  IF obj=NIL THEN RETURN
  cel.setset(curset,1)
  prechange()
  orcel(cel,obj)
  postchange()
  updateobjwin()
ENDPROC

PROC reveal()
 set(wi_reveal,MUIA_Window_Open,MUI_TRUE)
ENDPROC

PROC playkiss()
    DEF cel:PTR TO cel,obj:PTR TO obj
    DEF mes:PTR TO intuimessage,quit=QUIT_NONE
    DEF class,code,item:PTR TO menuitem
    DEF select
    DEF rrre
    DEF sig,oldtop,w,h
    DEF event:PTR TO event

    curset:=-1
    lastcel:=0;lastobj:=0;curobj:=0;curcel:=0;catchobj:=0
    lastseconds:=0
    lastmicros:=0
    -> these events are alway triggered at the beginning
    runevent(EV_INIT,0,0)
    runevent(EV_BEGIN,0,0)
    changeset(0)
    -> if viewer version is equal or greater than required version
    IF event:=findeventtype(EV_VERSION,-1,-1)
      IF VIEWERVERSION>=event.obj THEN runevent(EV_VERSION,0,0)
    ENDIF
    rrre:=-1
    WHILE quit=QUIT_NONE
        muiresult:=domethod(ap_main,[MUIM_Application_Input,{ap_signal}])
        muiresult:=handlemui(muiresult)
        SELECT muiresult
        ENDSELECT
        IF ap_signal
            sig:=Wait(-1)
        ENDIF
        IF (sig AND SIGBREAKF_CTRL_C) THEN quit:=QUIT_QUIT
        WHILE (mes:=GetMsg(win.userport))
            class:=mes.class
            SELECT class
            CASE IDCMP_CLOSEWINDOW
                quit:=QUIT_QUIT
            CASE IDCMP_NEWSIZE
                win_resize()
            CASE IDCMP_IDCMPUPDATE
                code:=GetTagData(GA_ID,0,mes.iaddress)
                SELECT code
                    CASE HORIZ_GID
                        win_scroll()
                    CASE VERT_GID
                        win_scroll()
                    CASE LEFT_GID
                        GetAttr(PGA_TOP,horizgadget,{oldtop})
                        w:=win.width-win.borderleft-win.borderright
                        h:=win.height-win.bordertop-win.borderbottom
                        IF oldtop>0
                            updateprop(win,horizgadget,PGA_TOP,oldtop-1)
                          GetAttr(PGA_TOP,horizgadget,{offx})
                          updatelistbuffered(offx,offy,w,h)
                        ENDIF
                    CASE RIGHT_GID
                        GetAttr(PGA_TOP,horizgadget,{oldtop})
                        w:=win.width-win.borderleft-win.borderright
                        h:=win.height-win.bordertop-win.borderbottom
                        IF oldtop<(envw-w)
                            updateprop(win,horizgadget,PGA_TOP,oldtop+1)
                          GetAttr(PGA_TOP,horizgadget,{offx})
                          updatelistbuffered(offx,offy,w,h)
                        ENDIF
                    CASE UP_GID
                        GetAttr(PGA_TOP,vertgadget,{oldtop})
                        w:=win.width-win.borderleft-win.borderright
                        h:=win.height-win.bordertop-win.borderbottom
                        IF oldtop>0
                            updateprop(win,vertgadget,PGA_TOP,oldtop-1)
                          GetAttr(PGA_TOP,vertgadget,{offy})
                          updatelistbuffered(offx,offy,w,h)
                        ENDIF
                    CASE DOWN_GID
                        GetAttr(PGA_TOP,vertgadget,{oldtop})
                        w:=win.width-win.borderleft-win.borderright
                        h:=win.height-win.bordertop-win.borderbottom
                        IF oldtop<(envh-h)
                            updateprop(win,vertgadget,PGA_TOP,oldtop+1)
                          GetAttr(PGA_TOP,vertgadget,{offy})
                          updatelistbuffered(offx,offy,w,h)
                        ENDIF
                ENDSELECT
            CASE IDCMP_MENUVERIFY
                ClearPointer(win)
                dropobj(olddragx+dragox,olddragy+dragoy)
            CASE IDCMP_MENUPICK
                code:=mes.code
                WHILE code<>MENUNULL
                    IF (item:=ItemAddress(menu,code))
                        select:=Long(item+34)
                        SELECT select
                        CASE MENU_ABOUT
                            aboutme()
                        CASE MENU_REDRAW
                            updatelist()
                        CASE MENU_QUIT
                            quit:=QUIT_QUIT
                        CASE MENU_PREFS;set(wi_prefs,MUIA_Window_Open,MUI_TRUE)
                        CASE MENU_OBJWIN;openobjwin()
                        CASE MENU_CLOSE;quit:=QUIT_CLOSE
                        CASE MENU_SET0;changeset(0)
                        CASE MENU_SET1;changeset(1)
                        CASE MENU_SET2;changeset(2)
                        CASE MENU_SET3;changeset(3)
                        CASE MENU_SET4;changeset(4)
                        CASE MENU_SET5;changeset(5)
                        CASE MENU_SET6;changeset(6)
                        CASE MENU_SET7;changeset(7)
                        CASE MENU_SET8;changeset(8)
                        CASE MENU_SET9;changeset(9)
                        CASE MENU_CSET0;changepal(0)
                        CASE MENU_CSET1;changepal(1)
                        CASE MENU_CSET2;changepal(2)
                        CASE MENU_CSET3;changepal(3)
                        CASE MENU_CSET4;changepal(4)
                        CASE MENU_CSET5;changepal(5)
                        CASE MENU_CSET6;changepal(6)
                        CASE MENU_CSET7;changepal(7)
                        CASE MENU_CSET8;changepal(8)
                        CASE MENU_CSET9;changepal(9)
                        CASE MENU_RESETOBJ;resetcur()
                        CASE MENU_UNFIXOBJ;unfixcur()
                        CASE MENU_REFIXOBJ;refixcur()
                        CASE MENU_UNDO;undo()
                        CASE MENU_SAVE;appendcoords(afname)
                        CASE MENU_SAVEALL;saveall(afname)
                        CASE MENU_REVEAL;reveal()
                        CASE MENU_MOVEBACK;moveback()
                        CASE MENU_MOVEFORWARD;moveforward()
                        CASE MENU_SAVESCREEN;savescreen(afname)
                        CASE MENU_PATROL;patrol()
                        CASE MENU_RESETSET;resetset()
                        ENDSELECT
                        code:=item.nextselect
                    ELSE
                        code:=MENUNULL
                    ENDIF
                ENDWHILE
                handme()
            CASE IDCMP_VANILLAKEY
                select:=mes.code
                SELECT select
                CASE "0";changepal(0)
                CASE "1";changepal(1)
                CASE "2";changepal(2)
                CASE "3";changepal(3)
                CASE "4";changepal(4)
                CASE "5";changepal(5)
                CASE "6";changepal(6)
                CASE "7";changepal(7)
                CASE "8";changepal(8)
                CASE "9";changepal(9)
                CASE 27;quit:=QUIT_QUIT
                CASE "-";moveback()
                CASE "=";moveforward()
                CASE "+";moveforward()
                CASE "f";unfixcur()
                CASE "F";refixcur()
                CASE "u";undo()
                CASE "w";openobjwin()
#ifdef OPT_SHOWSTATS
                CASE "Z";showstats()
#endif
                ENDSELECT
->      WriteF('V \d \h\n',mes.code,mes.code)
            CASE IDCMP_RAWKEY
                select:=mes.code
                SELECT select
                CASE 76;moveobjrel(0,-1)
                CASE 77;moveobjrel(0,1)
                CASE 78;moveobjrel(1,0)
                CASE 79;moveobjrel(-1,0)
                CASE 80;changeset(0)
                CASE 81;changeset(1)
                CASE 82;changeset(2)
                CASE 83;changeset(3)
                CASE 84;changeset(4)
                CASE 85;changeset(5)
                CASE 86;changeset(6)
                CASE 87;changeset(7)
                CASE 88;changeset(8)
                CASE 89;changeset(9)
                ENDSELECT
->      WriteF('R \d \h\n',mes.code,mes.code)
            CASE IDCMP_MOUSEBUTTONS
                IF mes.code=MENUDOWN
                    noreportmousemoves(win)
                    dropobj(olddragx+dragox,olddragy+dragoy)
                ENDIF
                IF mes.code=SELECTUP
                    noreportmousemoves(win)
                    handme()
                    dropobj(mes.mousex,mes.mousey)
                ENDIF
                IF mes.code=SELECTDOWN
                    cel,obj:=findobj(mes.mousex-win.borderleft+offx,mes.mousey-win.bordertop+offy)
                    IF obj>=0
                        lastobj:=obj
                        lastcel:=cel
                        lastobj.remember(curset)
                    ENDIF
                    curobj:=0
                    curcel:=0
                    catchobj:=0
                    IF ((cel>=0) AND (obj>=0))
                        IF obj.fix=1
                            obj.setfix(0)
                        ELSE
                            IF (obj.fix>1)
                                obj.setfix(Max(obj.fix-1,0))
                                IF (obj.fix<(obj.oldfix-1)) THEN IF (runevent(EV_FIXCATCH,obj,cel)) THEN catchobj:=obj
                                SetWindowPointerA(win,[WA_POINTER,hand4,WA_POINTERDELAY,FALSE,NIL,NIL])
                            ENDIF
                        ENDIF
                        IF (runevent(EV_PRESS,obj,cel)) THEN catchobj:=obj
                        IF ((obj.fix<=0) OR ((usesnap<>FALSE) AND (obj.fix<6)))
                            IF obj.fix=0
                                IF (runevent(EV_CATCH,obj,cel)) THEN catchobj:=obj
                            ENDIF
                            curobj:=obj;curcel:=cel
                            dragx:=obj.x[curset]
                            dragy:=obj.y[curset]
                            olddragx:=dragx
                            olddragy:=dragy
                            dragox:=mes.mousex-dragx
                            dragoy:=mes.mousey-dragy
                            reportmousemoves(win)
                            grabme()
                            pickupobj()
                        ENDIF
                    ENDIF
                    updateobjwin()
                ENDIF
            CASE IDCMP_INTUITICKS
                IF curobj=0
                    dectimers(mes.seconds,mes.micros)
                    lastseconds:=mes.seconds
                    lastmicros:=mes.micros
                ELSE
                    curobj.move((IF usefollow THEN mes.mousex ELSE win.mousex)-dragox,(IF usefollow THEN mes.mousey ELSE win.mousey)-dragoy,TRUE)
                ENDIF
            CASE IDCMP_MOUSEMOVE
                IF curobj
                    curobj.move((IF usefollow THEN mes.mousex ELSE win.mousex)-dragox,(IF usefollow THEN mes.mousey ELSE win.mousey)-dragoy,TRUE)
                ENDIF               
            ENDSELECT
            ReplyMsg(mes)
        ENDWHILE
    ENDWHILE
    runevent(EV_END,0,0)
ENDPROC quit

PROC patrol()
    DEF i,obj:PTR TO obj,eb
    eb:=usebounds
    usebounds:=TRUE
    busy()
    prechange()
    FOR i:=0 TO MAXOBJS
        obj:=objs[i]
        IF obj
            obj.movequick(obj.x[curset],obj.y[curset])
        ENDIF
    ENDFOR
    postchange()
    ready()
    usebounds:=eb
ENDPROC

PROC resetset()
    DEF i,obj:PTR TO obj,eb
    eb:=EasyRequestArgs(win,[20,0,'RESET ALL DATA','Selecting "Proceed" will loose all changes.',
        'Proceed|Cancel'],0,0)
    IF eb
        busy()
        prechange()
        FOR i:=0 TO MAXOBJS
            obj:=objs[i]
            IF obj
                obj.movequick(obj.ux[curset],obj.uy[curset])
                obj.setfix(obj.oldfix)
            ENDIF
        ENDFOR
        postchange()
        ready()
    ENDIF
ENDPROC

PROC unfixcur()
  IF lastobj=NIL THEN RETURN
  lastobj.setfix(0)
  updateobjwin()
ENDPROC

PROC refixcur() IS resetfixcur()

PROC storefixcur()
  IF lastobj=NIL THEN RETURN
  lastobj.oldfix:=lastobj.fix
  updateobjwin()
ENDPROC

PROC maxfixcur()
  IF lastobj=NIL THEN RETURN
  lastobj.setfix(32768)
  updateobjwin()
ENDPROC

PROC resetfixcur()
  IF lastobj=NIL THEN RETURN
  lastobj.setfix(lastobj.oldfix)
  updateobjwin()
ENDPROC

PROC resetcur()
  IF lastobj=NIL THEN RETURN
  lastobj.remember(curset)
  lastobj.forcemove(lastobj.ux[curset],lastobj.uy[curset],TRUE)
ENDPROC

PROC pickupobj()
    DEF cel:PTR TO cel
    DEF obj:PTR TO obj
    DEF i
    IF curobj
        prechange()
        curobj.remember(curset)
        FOR i:=MAXCELS TO 0 STEP -1
            cel:=cels[i]
            IF cel
                IF cel.sets[curset]
                    IF (cel.obj>=0)
                        obj:=objs[cel.obj]
                        IF (obj)
                            IF (obj=curobj)
                                IF cel.mapped=CMAP_SHOW
                                    cel.mapped:=CMAP_GRAB
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ELSE
                i:=-1
            ENDIF
        ENDFOR
    ENDIF
ENDPROC

PROC dropobj(x,y)
    DEF cel:PTR TO cel
    DEF obj:PTR TO obj
    DEF i
    IF curobj
        prechange()
        runevent(EV_RELEASE,curobj,curcel)
        IF curobj.fix=0
            runevent(EV_DROP,curobj,curcel)
        ELSE
            runevent(EV_FIXDROP,curobj,curcel)
        ENDIF
        IF curobj.fix>0
            curobj.move(curobj.rubx,curobj.ruby,FALSE)
        ELSE
            curobj.move(x-dragox,y-dragoy,FALSE)
        ENDIF
        FOR i:=MAXCELS TO 0 STEP -1
            cel:=cels[i]
            IF cel
                IF (cel.obj>=0)
                    obj:=objs[cel.obj]
                    IF (obj)
                        IF (obj=curobj)
                            IF cel.mapped<>CMAP_HIDE
                                cel.mapped:=CMAP_SHOW
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ELSE
                i:=-1
            ENDIF
        ENDFOR
        postchange()
        IF (catchobj=curobj) THEN catchobj:=0
        curobj:=0
        curcel:=0
        dragox:=0
        dragoy:=0
    ENDIF
    IF catchobj
        runevent(EV_RELEASE,catchobj,cel)
        IF catchobj.fix=0
            runevent(EV_DROP,catchobj,cel)
        ELSE
            runevent(EV_FIXDROP,catchobj,cel)
        ENDIF
        catchobj:=0
    ENDIF
    updateobjwin()
ENDPROC

PROC undo()
  DEF x,y
  IF lastobj=NIL THEN RETURN
  lastobj.undopos()
ENDPROC

-> Find object at given position
PROC findobj(x,y)
  DEF i
  DEF obj:PTR TO obj,cel:PTR TO cel
  FOR i:=MAXCELS TO 0 STEP -1
    cel:=cels[i]
    IF cel
      IF (cel.sets[curset])
        IF (cel.mapped=CMAP_SHOW)
          IF cel.buf
            obj:=objs[cel.obj]
            IF obj
              IF x>=(obj.x[curset]+cel.ox)
                IF y>=(obj.y[curset]+cel.oy)
                  IF x<(obj.x[curset]+cel.ox+cel.w)
                    IF y<(obj.y[curset]+cel.oy+cel.h)
                      IF cel.buf[(x-(obj.x[curset]+cel.ox))+((y-(obj.y[curset]+cel.oy))*cel.w)]
->                          IF ReadPixel(cel.mask.rast,x-(obj.x[curset]+cel.ox),y-(obj.y[curset]+cel.oy))
                        RETURN cel,obj
                      ENDIF
                    ENDIF
                  ENDIF
                ENDIF
              ENDIF
            ENDIF
          ENDIF
        ENDIF
      ENDIF
    ENDIF
  ENDFOR
ENDPROC -1,-1

PROC altmapcel(nu)
  DEF cel:PTR TO cel
  cel:=cels[nu]
  IF cel=NIL THEN RETURN
  IF cel.mapped=CMAP_SHOW
    cel.mapped:=CMAP_HIDE
    erasecel(cel)
  ELSE
    cel.mapped:=CMAP_SHOW
    drawcel(cel)
  ENDIF
ENDPROC

PROC mapcel(nu)
  DEF cel:PTR TO cel
  cel:=cels[nu]
  IF cel=NIL THEN RETURN
  IF cel.mapped<>CMAP_SHOW
    cel.mapped:=CMAP_SHOW
    drawcel(cel)
  ENDIF
ENDPROC

PROC unmapcel(nu)
  DEF cel:PTR TO cel
  cel:=cels[nu]
  IF cel=NIL THEN RETURN
  IF cel.mapped<>CMAP_HIDE
    cel.mapped:=CMAP_HIDE
    erasecel(cel)
  ENDIF
ENDPROC

PROC prechange() IS clear()

PROC clear()
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='clear()'
#endif
  ClearRegion(region)
  rminx:=64000;rminy:=64000;rmaxx:=0;rmaxy:=0
  qdbg(DBG_DONE)
ENDPROC

PROC orrect(x1,y1,x2,y2)
  IF useregions=REG_NONE
    rminx:=Min(rminx,x1)
    rminy:=Min(rminy,y1)
    rmaxx:=Max(rmaxx,x2)
    rmaxy:=Max(rmaxy,y2)
  ELSE
    OrRectRegion(region,[x1,y1,x2,y2]:rectangle)
  ENDIF
ENDPROC

PROC postchange()
  DEF cregion:PTR TO regionrectangle
  DEF x1,y1
  DEF bounds:PTR TO rectangle
#ifdef OPT_SHOWSTATS
  CurrentTime({se5},{mi5})
#endif
  IF useregions=REG_NONE
    updatelistbuffered(rminx,rminy,rmaxx-rminx+1,rmaxy-rminy+1,TRUE)
  ELSE
    cregion:=region.regionrectangle
    IF region.bounds
      x1:=region.bounds.minx
      y1:=region.bounds.miny
      WHILE cregion
        bounds:=cregion.bounds
        updatelistbuffered(x1+bounds.minx,y1+bounds.miny,bounds.maxx-bounds.minx+1,bounds.maxy-bounds.miny+1,TRUE)
        cregion:=cregion.next
      ENDWHILE
    ENDIF
  ENDIF
  clear()
#ifdef OPT_SHOWSTATS
  CurrentTime({se6},{mi6})
  em4:=em4+(Div(mics(se5,se6,mi5,mi6),10))
#endif
ENDPROC

PROC orcel(cel:PTR TO cel,obj:PTR TO obj,flag=FALSE)
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='orcel()'
#endif
  dbg('obj #\d\n',obj.number)
  dbg('cel "\s"\n',cel.realname)
  checkarg(obj)
  checkarg(cel)

  IF flag=FALSE
    IF useregions=REG_OBJ
      orrect(obj.x[curset],obj.y[curset],obj.x[curset]+obj.width(),obj.y[curset]+obj.height())
    ENDIF
  ELSE
    orrect(obj.x[curset]+cel.ox,obj.y[curset]+cel.oy,obj.x[curset]+cel.ox+cel.w,obj.y[curset]+cel.oy+cel.h)
  ENDIF
->  qdbg(DBG_DONE)
ENDPROC

-> Erase cel from play display
PROC erasecel(cel:PTR TO cel)
  DEF obj:PTR TO obj
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='erasecel()'
#endif
  dbg('Cel: "\s"\n',cel.realname)
  checkarg(cel)
  obj:=objs[cel.obj]
  IF obj THEN orcel(cel,obj)
ENDPROC

PROC drawcel(cel:PTR TO cel)
  DEF obj:PTR TO obj
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='drawcel()'
#endif
  dbg('Cel=$\h\n',cel)
  checkarg(cel)
  obj:=objs[cel.obj]
  checkarg(obj)
  orcel(cel,obj)
ENDPROC

PROC updatelistbuffered(x,y,w,h,flag=FALSE) HANDLE
  DEF cel:PTR TO cel,obj:PTR TO obj
  DEF obx,oby
  DEF qox,qoy
  DEF a,i,yy,xx,b,c
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='updatelistbuffered()'
#endif
  dbg('Arg x:    \d\n',x)
  dbg('Arg y:    \d\n',y)
  dbg('Arg w:    \d\n',w)
  dbg('Arg h:    \d\n',h)
  dbg('Arg flag: \s\n',IF flag THEN 'TRUE' ELSE 'FALSE' )

  IF (x<0)
    w:=w+x
    x:=0
  ENDIF
  IF (y<0)
    h:=h+y
    y:=0
  ENDIF
  IF ((w+x)>envw) THEN w:=envw-x
  IF ((y+h)>envh) THEN h:=envh-y

  IF ((w>0) AND (h>0))
    xx:=x+w-1
    yy:=y+h-1
#ifdef OPT_SHOWSTATS
    CurrentTime({se1},{mi1})
#endif
    IF onwb
      a:=ka.chunkybuf+(envw*y)+x
      b:=yy-y
      c:=xx-x
      MOVE.L  a,A0
      MOVE.L  a,A1
      MOVE.L  envw,D3
      MOVE.L  bgpen,D4
      MOVE.L  c,D2
      MOVE.L  b,D1
csloop4:
      MOVE.L  D2,D0
csloop3:
      MOVE.B  D4,(A0)+
      DBRA.S  D0,csloop3
      ADDA.L  D3,A1
      MOVE.L  A1,A0
      DBRA.S  D1,csloop4
    ELSE
      a:=ka.chunkybuf+(envw*y)+x
      b:=yy-y
      c:=xx-x
      MOVE.L  a,A0
      MOVE.L  a,A1
      MOVE.L  envw,D3
      MOVE.L  c,D2
      MOVE.L  b,D1
csloop2:
      MOVE.L  D2,D0
csloop1:
      MOVE.B  #0,(A0)+
      DBRA.S  D0,csloop1
      ADDA.L  D3,A1
      MOVE.L  A1,A0
      DBRA.S  D1,csloop2
    ENDIF
#ifdef OPT_SHOWSTATS
    CurrentTime({se2},{mi2})
#endif
    FOR i:=0 TO MAXCELS
      cel:=cels[i]
      IF (cel)
        IF (cel.sets[curset])
          IF (cel.buf)
            IF ((cel.mapped=CMAP_SHOW) OR ((cel.mapped=CMAP_GRAB) AND (flag<>0)))
              obj:=objs[cel.obj]
              IF (obj)
                obx:=obj.x[curset]
                oby:=obj.y[curset]
                qox:=cel.ox
                qoy:=cel.oy
                IF ((qox+obx)<=(x+w-1))
                  IF ((qoy+oby)<=(y+h-1))
                    IF ((qox+obx+cel.w-1)>=x)
                      IF ((qoy+oby+cel.h-1)>=y)
                        dbg('placecel cel "\s"\n',cel.realname)
                        placecel(cel,obx,oby,x,y,w,h)
                      ENDIF
                    ENDIF
                  ENDIF
                ENDIF
              ENDIF
            ENDIF
          ENDIF
        ENDIF
      ENDIF
    ENDFOR
#ifdef OPT_SHOWSTATS
    CurrentTime({se3},{mi3})
#endif
    drawchunky(x-offx,y-offy,w,h,x,y,rp,ka.chunkybuf)
#ifdef OPT_SHOWSTATS
    CurrentTime({se4},{mi4})
    elapse:=elapse+1
    em1:=em1+(Div(mics(se1,se2,mi1,mi2),10))
    em2:=em2+(Div(mics(se2,se3,mi2,mi3),10))
    em3:=em3+(Div(mics(se3,se4,mi3,mi4),10))
#endif
  ENDIF
  qdbg(DBG_DONE)
EXCEPT
  WriteF('No memory!\n')
  updatelist()
ENDPROC

#ifdef OPT_SHOWSTATS
PROC showstats()
  WriteF('\n')
  WriteF('Total seconds for  clear: \d\n',Div(em1,100))
  WriteF('Total seconds for  place: \d\n',Div(em2,100))
  WriteF('Total seconds for update: \d\n',Div(em3,100))
  WriteF('Total seconds for   post: \d\n',Div(em4,100))
  WriteF('Total seconds for action: \d\n',Div(em5,100))
ENDPROC
#endif

PROC updatelist()
  busy()
  prechange()
  orrect(0,0,envw-1,envh-1)
  postchange()
  ready()
ENDPROC

PROC unmapobj(objn)
  DEF obj:PTR TO obj,cel:PTR TO cel,i
  obj:=objs[objn]
  IF obj=NIL THEN RETURN
  FOR i:=MAXCELS TO 0 STEP -1
    cel:=cels[i]
    IF cel
      IF cel.obj=objn
        cel.mapped:=CMAP_HIDE
      ENDIF
    ELSE
      i:=-1
    ENDIF
  ENDFOR
  updateobj(obj,objn)
ENDPROC

PROC mapobj(objn)
  DEF obj:PTR TO obj,cel:PTR TO cel,i
  obj:=objs[objn]
  IF obj=NIL THEN RETURN
  FOR i:=MAXCELS TO 0 STEP -1
    cel:=cels[i]
    IF cel
      IF cel.obj=objn
        cel.mapped:=CMAP_SHOW
      ENDIF
    ELSE
      i:=-1
    ENDIF
  ENDFOR
  updateobj(obj,objn)
ENDPROC

PROC altmapobj(objn)
    DEF obj:PTR TO obj,cel:PTR TO cel,i
    FOR i:=MAXCELS TO 0 STEP -1
        cel:=cels[i]
        IF cel
            IF cel.obj=objn
                altmapcel(i)
            ENDIF
        ELSE
            i:=-1
        ENDIF
    ENDFOR
ENDPROC

PROC updateobj(obj:PTR TO obj,objn)
  DEF cel:PTR TO cel
  DEF i
  DEF x=60000,y=60000,w=0,h=0
  checkarg(obj)
  FOR i:=MAXCELS TO 0 STEP -1
    cel:=cels[i]
    IF cel
      IF cel.obj=objn
        IF cel.sets[curset]
          orcel(cel,obj,TRUE)
        ENDIF
      ENDIF
    ELSE
      i:=-1
    ENDIF
  ENDFOR
ENDPROC

PROC playsound(co:PTR TO command)
  checkarg(co)
  IF co.sound THEN DoDTMethodA(co.sound,NIL,NIL,[DTM_TRIGGER,NIL,STM_PLAY,NIL])
ENDPROC

PROC runcommands(ev:PTR TO event)
  DEF co:PTR TO command
  DEF next2
  DEF type,cel:PTR TO cel
  DEF newev:PTR TO event
  DEF obj:PTR TO obj
->  DEF newx,newy                 -> these make some calculations more clear
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='runcommands()'
#endif
  dbg('ev.type \s\n',ListItem(['EV_UNKNOWN','EV_INIT','EV_BEGIN','EV_END','EV_ALARM','EV_CATCH','EV_UNFIX','EV_FIXCATCH','EV_SET','EV_COL','EV_DROP','EV_PRESS','EV_RELEASE','EV_FIXDROP'],ev.type))
  dbg('ev.obj \d\n',ev.obj)
  dbg('ev.cel "\s"\n',ev.cel)
  dbg('ev.cel $\h\n',ev.cel)
  prechange()
#ifdef OPT_SHOWSTATS
  CurrentTime({se7},{mi7})
#endif
  co:=ev.commands.head
  REPEAT
    next2:=co.ln.succ
    IF next2
      type:=co.type
      SELECT type
      CASE CO_SOUND
        playsound(co)
      CASE CO_UNMAP
        IF co.obj=-1
          cel:=findnamedcel(co.cel)
          IF cel>-1
            unmapcel(cel)
          ENDIF
        ELSE
          unmapobj(co.obj)
        ENDIF
      CASE CO_MAP
        IF co.obj=-1
          cel:=findnamedcel(co.cel)
          IF cel>-1
            mapcel(cel)
          ENDIF
        ELSE
          mapobj(co.obj)
        ENDIF
      CASE CO_ALTMAP
        IF co.obj=-1
          cel:=findnamedcel(co.cel)
          IF cel>-1
            altmapcel(cel)
          ENDIF
        ELSE
          altmapobj(co.obj)
        ENDIF
      CASE CO_TIMER
        newev:=findeventtype(EV_ALARM,co.x)
        IF newev THEN newev.counter:=co.y
      CASE CO_RANDOMTIMER
        newev:=findeventtype(EV_ALARM,co.obj)
        IF newev THEN newev.counter:=rndrange(co.x,co.y)
      CASE CO_MOVE
        IF co.obj=-1
          cel:=findnamedcel(co.cel)
          IF cel>-1
->            movecel(cel)
          ENDIF
        ELSE
          obj:=objs[co.obj]
          IF obj
            IF curobj=NIL
              dragox:=0;dragoy:=0
              obj.forcemove(obj.x[curset]+co.x,obj.y[curset]+co.y,FALSE)
            ENDIF
          ENDIF
        ENDIF
      CASE CO_MOVETO
        IF co.obj=-1
          cel:=findnamedcel(co.cel)
          IF cel>-1
->                      movecel(cel)
          ENDIF
        ELSE
          obj:=objs[co.obj]
          IF obj
            IF curobj=NIL
              dragox:=0;dragoy:=0
              obj.forcemove(Bounds(0,co.x,envw),Bounds(0,co.y,envh),FALSE)
            ENDIF
          ENDIF
        ENDIF
      -> new commands
      CASE CO_MOVERANDX
        qdbg('Execute moverandx()')
        IF co.obj<>-1
          obj:=objs[co.obj]
          IF obj
            IF curobj=NIL
              dragox:=0;dragoy:=0
              obj.forcemove(obj.x[curset]+rndrange(co.x,co.y),obj.y[curset],FALSE)
            ENDIF
          ENDIF
        ENDIF
      CASE CO_MOVERANDY
        qdbg('Execute moverandy()')
        IF co.obj<>-1
          obj:=objs[co.obj]
          IF obj
            IF curobj=NIL
              dragox:=0;dragoy:=0
              obj.forcemove(obj.x[curset],obj.y[curset]+rndrange(co.x,co.y),FALSE)
            ENDIF
          ENDIF
        ENDIF
      -> movetorand(#obj)
      CASE CO_MOVETORAND
        qdbg('Execute movetorand()')
        IF co.obj<>-1
          obj:=objs[co.obj]
          IF obj
            IF curobj=NIL
              obj.forcemove(rndrange(0,envw),rndrange(0,envh),FALSE)
            ENDIF
          ENDIF
        ENDIF
      -> iffixed(#obj,timer,value)
      CASE CO_IFFIXED
        IF co.obj<>-1
          obj:=objs[co.obj]
          IF obj
            IF obj.fix>0
              newev:=findeventtype(EV_ALARM,co.x)
              IF newev THEN newev.counter:=co.y
            ENDIF
          ENDIF
        ENDIF
      -> ifnotfixed(#obj,timer,value)
      CASE CO_IFNOTFIXED
        IF co.obj<>-1
          obj:=objs[co.obj]
          IF obj
            IF obj.fix=0
              newev:=findeventtype(EV_ALARM,co.x)
              IF newev THEN newev.counter:=co.y
            ENDIF
          ENDIF
        ENDIF
      -> ifmapped("cel",timer,value)
      CASE CO_IFMAPPED
        IF co.cel
          cel:=findnamedcel(co.cel)
          IF cel.mapped=CMAP_SHOW
            newev:=findeventtype(EV_ALARM,co.x)
            IF newev THEN newev.counter:=co.y
          ENDIF
        ENDIF
      -> ifmapped("cel",timer,value)
      CASE CO_IFNOTMAPPED
        IF co.cel
          cel:=findnamedcel(co.cel)
          IF cel.mapped=CMAP_HIDE
            newev:=findeventtype(EV_ALARM,co.x)
            IF newev THEN newev.counter:=co.y
          ENDIF
        ENDIF
      -> changeset(setnum)
      CASE CO_CHANGESET
        dbg('changeset(\d)\n',co.x)
        changeset(co.x)
      -> changecol(colnum)
      CASE CO_CHANGECOL
        dbg('changecol(\d)\n',co.x)
        changepal(co.x)
      -> debug("message")
      -> message to print is stored in a cel field of event object
      CASE CO_DEBUG
        dbg('debug("\s")\n',co.cel)
        IF co.cel
          qdbg('Execute debug()')
          domethod(g_outputlist,[MUIM_List_InsertSingle,co.cel,MUIV_List_Insert_Bottom])
          set(wi_output,MUIA_Window_Open,MUI_TRUE)
        ENDIF
      -> notify("message")
      -> message to print is stored en cel field of event object
      CASE CO_NOTIFY
        dbg('notify("\s")\n',co.cel)
        IF co.cel
          qdbg('Execute notify()')
          domethod(g_outputlist,[MUIM_List_InsertSingle,co.cel,MUIV_List_Insert_Bottom])
          set(wi_output,MUIA_Window_Open,MUI_TRUE)
        ENDIF
      CASE CO_NOP
        NOP
      ENDSELECT
    ENDIF
    co:=next2
  UNTIL next2=0
#ifdef OPT_SHOWSTATS
  CurrentTime({se8},{mi8})
  em5:=em5+(Div(mics(se7,se8,mi7,mi8),10))
#endif
  postchange()
ENDPROC

-> move object relative to current position
PROC moveobjrel(ox,oy)
  IF lastobj=NIL THEN RETURN
  IF lastcel=NIL THEN RETURN
  IF lastobj.fix THEN RETURN
  dragox:=0;dragoy:=0
  prechange()
  orcel(lastcel,lastobj)
  lastobj.forcemove(lastobj.x[curset]+ox,lastobj.y[curset]+oy,FALSE)
  orcel(lastcel,lastobj)
  postchange()
ENDPROC

PROC mics(a1,a2,b1,b2)
  DEF decc
  IF b1<b2
    decc:=Mul((a2-a1),1000000)+(b2-b1)
  ELSE
    decc:=Mul((a2-a1),1000000)-(b1-b2)
  ENDIF
ENDPROC decc

-> decrase timers
PROC dectimers(nsec,nmic)
  DEF ev:PTR TO event
  DEF next1
  DEF decc
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='dectimers()'
#endif
  IF lastseconds=0 THEN RETURN
  decc:=mics(lastseconds,nsec,lastmicros,nmic)
  decc:=Mul(decc,(animspeed/10))
  decc:=Div(Min(decc,10000000),10000)
  ev:=eventlist
  REPEAT
    next1:=ev.ln.succ
    IF next1
      IF ev.type=EV_ALARM
        ev.trigger:=FALSE
        IF ev.counter>0
          dbg('alarm #\d\n',ev.obj)
          dbg('counter \d\n',ev.counter)
          ev.counter:=Max(ev.counter-decc,0)
          dbg('trigger: \s\n',IF ev.counter=0 THEN 'Y' ELSE 'N')
          IF ev.counter=0 THEN ev.trigger:=1
        ENDIF
      ENDIF
    ENDIF
    ev:=next1
  UNTIL next1=0
  ev:=eventlist
  REPEAT
    next1:=ev.ln.succ
    IF (next1)
      IF ev.type=EV_ALARM
        IF ev.trigger=1
          ev.trigger:=0
          dbg('alarm #\d\n',ev.obj)
          runcommands(ev)
        ENDIF
      ENDIF
    ENDIF
    ev:=next1
  UNTIL next1=0
ENDPROC

PROC postkiss()
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='postkiss()'
#endif
  closescr()
  qdbg(DBG_DONE)
ENDPROC

PROC updatecolors()
    DEF i,pn=0,t
    DEF uf:PTR TO LONG
    DEF cel:PTR TO cel
    DEF r,g,b,p
    IF onwb
        busy()
        FOR i:=1 TO 255
            IF apens[i]>=0
                ReleasePen(cm,apens[i])
                apens[i]:=-1
            ENDIF
        ENDFOR
        IF (bgpen>=0) THEN ReleasePen(cm,bgpen);bgpen:=-1
        FOR i:=0 TO 15
            IF (palet[i].color[curpal]<>0)
                FOR t:=0 TO (palet[i].color_num-1)
                    r:=(Long(palet[i].color[curpal]+(t*12)))
                    g:=(Long(palet[i].color[curpal]+(t*12)+4))
                    b:=(Long(palet[i].color[curpal]+(t*12)+8))
                    IF pn>0 
                        apens[pn]:=ObtainBestPenA(cm,r,g,b,[OBP_PRECISION,PRECISION_EXACT])
                        IF apens[pn]=0
                            REPEAT
                                IF apens[pn]>=0 THEN ReleasePen(cm,apens[pn])
                                r:=r+$01010101
                                g:=g+$01010101
                                b:=b+$01010101
                                apens[pn]:=ObtainBestPenA(cm,r,g,b,[OBP_PRECISION,PRECISION_EXACT,TAG_END])
                            UNTIL (apens[pn]>0)
                        ENDIF
                        IF apens[pn]=-1 THEN apens[pn]:=pn
                    ELSE
                        bgpen:=ObtainBestPenA(cm,r,g,b,[OBP_PRECISION,PRECISION_GUI])
                    ENDIF
                    pn:=pn+1;IF pn>255 THEN pn:=255
                ENDFOR
            ENDIF
        ENDFOR
        FOR i:=0 TO MAXCELS
            cel:=cels[i]
            IF cel
                cel.recolor()
            ENDIF
        ENDFOR
        ready()
        updatelist()
    ELSE
        savememalloc(uf,4096)
        FOR i:=0 TO 15
            IF (palet[i].color[curpal]<>0)
                FOR t:=0 TO (palet[i].color_num-1)
                    uf[pn*3]:=(Long(palet[i].color[curpal]+(t*12)))
                    uf[pn*3+1]:=(Long(palet[i].color[curpal]+(t*12)+4))
                    uf[pn*3+2]:=(Long(palet[i].color[curpal]+(t*12)+8))
                    ObtainPen(cm,pn,255,255,255,PENF_EXCLUSIVE)
                    SetRGB32CM(cm,pn,uf[pn*3],uf[pn*3+1],uf[pn*3+2])
                    INC pn
                    IF pn>255 THEN pn:=255
                ENDFOR
            ENDIF
        ENDFOR
        RethinkDisplay()
        RemakeDisplay()
        savememfree(uf,4096)
        updatelist()
    ENDIF
ENDPROC

PROC findcolor(r1,g1,b1)
  DEF score,pick,news,r,g,b,i,t,pn=0
  score:=1000000;pick:=0
  FOR i:=0 TO 15
    IF (palet[i].color[curpal]<>0)
      FOR t:=0 TO (palet[i].color_num-1)
        r:=(Long(palet[i].color[curpal]+(t*12)))
        g:=(Long(palet[i].color[curpal]+(t*12)+4))
        b:=(Long(palet[i].color[curpal]+(t*12)+8))
        r:=long2byte(r)
        g:=long2byte(g)
        b:=long2byte(b)
        r:=Abs(r-r1)
        g:=Abs(g-g1)
        b:=Abs(b-b1)
        news:=(r*r)+(g*g)+(b*b)
        IF (news<score)
          pick:=pn
          score:=news
        ENDIF
        pn:=pn+1;IF pn>255 THEN pn:=255
      ENDFOR
    ENDIF
  ENDFOR
ENDPROC pick

PROC savecoords(newfh)
    DEF obj:PTR TO obj
    DEF cel:PTR TO cel
    DEF zz,zzz,t,tt,i,ii
    DEF string[500]:STRING
    IF newfh
        FOR i:=0 TO 9
            StringF(string,'\n$\d[1]',pb[i])
            Write(newfh,string,StrLen(string))
            ii:=0
            FOR t:=0 TO MAXCELS
                cel:=cels[t]
                IF cel
                    IF (cel.sets[i])
                        ii:=Max(ii,cel.obj)
                    ENDIF
                ENDIF
            ENDFOR
            FOR t:=0 TO ii STEP 16
                FOR tt:=t TO Min(t+15,ii)
                    zz:=-11
                    FOR zzz:=0 TO MAXCELS
                        cel:=cels[zzz]
                        IF cel
                            IF cel.sets[i]
                                IF (cel.obj=tt)
                                    obj:=objs[cel.obj]
                                    IF obj
                                        zz:=zzz
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDFOR
                    IF zz>=0
                        StringF(string,' \d,\d',obj.x[i],obj.y[i])
                        Write(newfh,string,StrLen(string))
                    ELSE
                        Write(newfh,' *',2)
                    ENDIF
                ENDFOR
                Write(newfh,'\n',1)
            ENDFOR
            Write(newfh,'\n',1)
        ENDFOR
        Write(newfh,'\n;This .cnf file was saved by'+PROGRAMNAME+' '+PROGRAMVERSION+'for Amiga Computers.',STRLEN)
    ENDIF
ENDPROC

PROC saveall(cname)
  DEF dir[500]:STRING
  DEF file[500]:STRING
  DEF string[500]:STRING
  DEF filename[500]:STRING
  DEF ii=0,i
  DEF oldfh,newfh
  DEF oldout
  DEF obj:PTR TO obj
  DEF cel:PTR TO cel
  DEF event:PTR TO event
  DEF com:PTR TO command
  DEF next1,next2
  DEF select
  DEF rc

  StrCopy(filename,cname,ALL)
  splitname(filename,dir,file)
  rc:=AslRequest(filereq,[ASL_HAIL,cat.msgRequestTitleSaveCNFFileAs.getstr(),
   ASL_FILE,file,
   ASL_DIR,dir,
   ASL_OKTEXT,cat.msgRequestButtonSave.getstr(),
   ASLFR_SCREEN,scr,
   ASLFR_DOPATTERNS,TRUE,
   ASLFR_DOSAVEMODE,TRUE,
   FILF_NEWIDCMP,TRUE,TAG_END])
  IF rc=FALSE THEN RETURN

  StrCopy(string,filename,ALL)
  StrCopy(filename,filereq.drawer,ALL)
  eaddpart(filename,filereq.file,490)
  oldfh:=Open(filename,MODE_OLDFILE)
  newfh:=1
  IF oldfh
    Close(oldfh)
    rc:=EasyRequestArgs(win,[20,0,PROGRAMNAME,cat.msgRequestCNFFileExsists.getstr(),cat.msgRequestButtonYesNo.getstr()],0,0)
    IF rc=0 THEN RETURN
  ENDIF
        IF newfh
            newfh:=Open(filename,MODE_NEWFILE)
            IF newfh
                busy()
                oldout:=SetStdOut(newfh)
                WriteF(';\n;This file was written by \s \s for Amiga Computers\n;\n',PROGRAMNAME,PROGRAMVERSION)
                FOR i:=0 TO 15
                    IF StrLen(palet[i].name)
                        splitname(palet[i].name,dir,file)
                        WriteF('%\s\n',file)
                    ENDIF
                ENDFOR
                WriteF('(\d,\d)  ;Environment dimensions\n',envw,envh)
                WriteF('[0  ;Border color\n\n')
                FOR i:=MAXCELS TO 0 STEP -1
                    cel:=cels[i]
                    IF cel
                        obj:=objs[cel.obj]
                        IF obj
                            WriteF('#\d',cel.obj)
                            IF obj.fix
                                WriteF('.\d ',obj.fix)
                            ELSE
                                WriteF('     ')
                            ENDIF
                            WriteF('\s  *\d  :',cel.realname,cel.palet_num)
                            FOR ii:=0 TO 9
                                IF cel.sets[ii]
                                    WriteF('\d ',ii)
                                ELSE
                                    WriteF('  ')
                                ENDIF
                            ENDFOR
                            WriteF('  ;\s\n',cel.comment)
                        ENDIF
                    ENDIF
                ENDFOR
                IF (fkissfound)
                    WriteF(';\n;\n;FKISS stuff follows:\n;\n@EventHandler()\n;\n')
                    event:=eventlist.head
                    REPEAT
                        next1:=event.ln.succ
                        IF (next1)
                            select:=event.type
                            SELECT select
                            CASE EV_INIT
                                WriteF(';@initialize()\n')
                            CASE EV_BEGIN
                                WriteF(';@begin()\n')
                            CASE EV_END
                                WriteF(';@end()\n')
                            CASE EV_ALARM
                                WriteF(';@alarm(\d)\n',event.obj)
                            CASE EV_CATCH
                                IF event.obj>-1
                                    WriteF(';@catch(#\d)\n',event.obj)
                                ELSE
                                    WriteF(';@catch("\s")\n',event.cel)
                                ENDIF
                            CASE EV_UNFIX
                                IF event.obj>-1
                                    WriteF(';@unfix(#\d)\n',event.obj)
                                ELSE
                                    WriteF(';@unfix("\s")\n',event.cel)
                                ENDIF
                            CASE EV_FIXCATCH
                                IF event.obj>-1
                                    WriteF(';@fixcatch(#\d)\n',event.obj)
                                ELSE
                                    WriteF(';@fixcatch("\s")\n',event.cel)
                                ENDIF
                            CASE EV_SET
                                WriteF(';@set(\d)\n',event.obj)
                            CASE EV_COL
                                WriteF(';@col(\d)\n',event.obj)
                            CASE EV_DROP
                                IF event.obj>-1
                                    WriteF(';@drop(#\d)\n',event.obj)
                                ELSE
                                    WriteF(';@drop("\s")\n',event.cel)
                                ENDIF
                            ENDSELECT
                            com:=event.commands.head
                            REPEAT
                                next2:=com.ln.succ
                                IF (next2)
                                    select:=com.type
                                    SELECT select
                                    CASE CO_TIMER
                                        WriteF(';@timer(\d,\d)\n',com.x,com.y)
                                    CASE CO_MAP
                                        IF com.obj>-1
                                            WriteF(';@map(#\d)\n',com.obj)
                                        ELSE
                                            WriteF(';@map("\s")\n',com.cel)
                                        ENDIF
                                    CASE CO_UNMAP
                                        IF com.obj>-1
                                            WriteF(';@unmap(#\d)\n',com.obj)
                                        ELSE
                                            WriteF(';@unmap("\s")\n',com.cel)
                                        ENDIF
                                    CASE CO_SOUND
                                        WriteF(';@sound("\s")\n',com.sound)
                                    CASE CO_MOVE
                                        IF com.obj>-1
                                            WriteF(';@move(#\d,\d,\d)\n',com.obj,com.x,com.y)
                                        ELSE
                                            WriteF(';@move("\s",\d,\d)\n',com.cel,com.x,com.y)
                                        ENDIF
                                    CASE CO_MOVETO
                                        IF com.obj>-1
                                            WriteF(';@moveto(#\d,\d,\d)\n',com.obj,com.x,com.y)
                                        ELSE
                                            WriteF(';@moveto("\s",\d,\d)\n',com.cel,com.x,com.y)
                                        ENDIF
                                    CASE CO_ALTMAP
                                        IF com.obj>-1
                                            WriteF(';@altmap(#\d)\n',com.obj)
                                        ELSE
                                            WriteF(';@altmap("\s")\n',com.cel)
                                        ENDIF
                                    CASE CO_NOP
                                        WriteF(';@nop()\n')
                                    ENDSELECT
                                ENDIF
                                com:=next2
                            UNTIL next2=0
                        ENDIF
                        event:=next1
                        WriteF(';\n')
                    UNTIL next1=0
                ENDIF
                WriteF('\n;\n;coordinates follow:\n;\n')
                SetStdOut(oldout)
                savecoords(newfh)
                Close(newfh)
                ready()
            ENDIF
        ENDIF
ENDPROC

PROC appendcoords(cname)
    DEF dir[500]:STRING
    DEF file[500]:STRING
    DEF string[500]:STRING
    DEF filename[500]:STRING
    DEF ii=0
    DEF oldfh,newfh
    DEF bufptr,filebuf,filelen
    StrCopy(filename,cname,ALL)
    splitname(filename,dir,file)
    WbenchToFront()
    ii:=AslRequest(filereq,[ASL_HAIL,'Append to which .CNF file?',
                ASL_OKTEXT,'Save',ASL_FILE,file,ASL_DIR,dir,
                ASLFR_DOPATTERNS,TRUE,ASLFR_DOSAVEMODE,TRUE,FILF_NEWIDCMP,TRUE,NIL,NIL])
    IF onwb=0 THEN WbenchToBack()
    IF ii
        StrCopy(string,filename,ALL)
        StrCopy(filename,filereq.drawer,ALL)
        eaddpart(filename,filereq.file,490)
        oldfh:=Open(filename,MODE_OLDFILE)
        newfh:=1
        IF oldfh
            Close(oldfh)
            newfh:=EasyRequestArgs(win,[20,0,'Confirm overwrite!',
                'File exists.\nDo you wish to overwrite?',
                'Overwrite|Cancel'],0,0)
        ENDIF
        IF newfh
            busy()
            filelen:=FileLength(string)
            IF (filelen>0)
                filebuf:=New(filelen)
                oldfh:=Open(string,MODE_OLDFILE)
                IF oldfh
                    Read(oldfh,filebuf,filelen)
                    Close(oldfh)
                    bufptr:=filebuf
                    WHILE ((((Char(bufptr)<>10) OR (Char(bufptr)<>13)) AND (Char(bufptr+1)<>"$")) AND (bufptr<=(filebuf+filelen)))
                        bufptr:=bufptr+1
                    ENDWHILE
                    newfh:=Open(filename,MODE_NEWFILE)
                    IF newfh
                        Write(newfh,filebuf,(bufptr-filebuf+1))
                        savecoords(newfh)
                        Close(newfh)
                    ENDIF
                ENDIF
                Dispose(filebuf)
            ENDIF
            ready()
        ENDIF
    ENDIF
ENDPROC

PROC savescreen(cname)
    DEF dir[500]:STRING
    DEF file[500]:STRING
    DEF string[500]:STRING
    DEF filename[500]:STRING
    DEF ii=0
    DEF imbuf:PTR TO imbuf

    StrCopy(filename,cname,ALL)
    splitname(filename,dir,file)
    StrAdd(file,'.IFF')
    WbenchToFront()
    ii:=AslRequest(filereq,[ASL_HAIL,'Save Screen as',
                ASL_OKTEXT,'Save',ASL_FILE,file,ASL_DIR,dir,
                ASLFR_DOPATTERNS,TRUE,ASLFR_DOSAVEMODE,TRUE,FILF_NEWIDCMP,TRUE,NIL,NIL])
    IF onwb=0 THEN WbenchToBack()
    IF ii
        busy()
        StrCopy(string,filename,ALL)
        StrCopy(filename,filereq.drawer,ALL)
        eaddpart(filename,filereq.file,490)
        NEW imbuf.new(envw,envh,depth)
        IF imbuf.bmap
            ClipBlit(rp,0,0,imbuf.rast,0,0,envw,envh,192)
            saveclip(filename,imbuf.bmap,vp,envw,envh,0)
            END imbuf
        ENDIF
        ready()
    ENDIF
ENDPROC

PROC saveclip(unitnumber,mom:PTR TO bitmap,vp:PTR TO viewport,width,height,yoffset) HANDLE
    DEF ierror,rlen
    DEF table=0,llen
    DEF bmhd=NIL:PTR TO bitmapheader
    DEF planedata[10]:LIST,cm
    DEF iff=0:PTR TO iffhandle
    DEF dang,dumb

    cm:=vp.colormap
    savememalloc(bmhd,SIZEOF bitmapheader)
    rlen:=(((width+15)/16))*2
    bmhd.width:=width
    bmhd.height:=height
    bmhd.left:=0
    bmhd.top:=0
    bmhd.depth:=mom.depth
    bmhd.masking:=0
    bmhd.compression:=1
    bmhd.transparent:=0
    bmhd.xaspect:=1         -> change these later?
    bmhd.yaspect:=1
    bmhd.pagewidth:=0
    bmhd.pageheight:=0

    iff:=AllocIFF()
    IF unitnumber<255
        iff.stream:=OpenClipboard(unitnumber)
        IF (iff.stream)
            InitIFFasClip(iff)
        ELSE            
            Raise("NOOP")
        ENDIF
    ELSE
        iff.stream:=Open(unitnumber,MODE_NEWFILE)
        IF (iff.stream)
            InitIFFasDOS(iff)
        ELSE
            Raise("NOOP")
        ENDIF
    ENDIF
    IF (ierror:=OpenIFF(iff,IFFF_WRITE)) THEN Raise("NOOP")
    PushChunk(iff,"ILBM","FORM",IFFSIZE_UNKNOWN)
    PushChunk(iff,"ILBM","ANNO",IFFSIZE_UNKNOWN)
    WriteChunkBytes(iff,'Written by '+PROGRAMNAME+' '+PROGRAMNAME,STRLEN)
    PopChunk(iff)
    PushChunk(iff,"ILBM","BMHD",SIZEOF bitmapheader)
    WriteChunkBytes(iff,bmhd,SIZEOF bitmapheader)   
    PopChunk(iff)
    PushChunk(iff,"ILBM","CAMG",4)
    WriteChunkBytes(iff,[modeid]:LONG,4)    
    PopChunk(iff)
    PushChunk(iff,"ILBM","CMAP",IFFSIZE_UNKNOWN)
    table:=New(5000)
    FOR dang:=0 TO (Shl(1,bmhd.depth)-1)
        GetRGB32(cm,dang,3,table)
        WriteChunkBytes(iff,(table),1)
        WriteChunkBytes(iff,(table+4),1)
        WriteChunkBytes(iff,(table+8),1)
    ENDFOR
    PopChunk(iff)
    IF (bmhd.depth)
        FOR dumb:=1 TO 8
            planedata[dumb]:=Long(mom+4+(4*dumb))+(rlen*yoffset)
        ENDFOR
        PushChunk(iff,"ILBM","BODY",IFFSIZE_UNKNOWN)
        FOR dang:=0 TO height-1
            FOR dumb:=1 TO bmhd.depth
                llen:=pack_rlen(planedata[dumb]+(dang*mom.bytesperrow),table,rlen,4990)
                IF llen>0
                    WriteChunkBytes(iff,table,llen-1)
                ELSE
                    WriteF('runlength packing error!\n')
                ENDIF
            ENDFOR
        ENDFOR
        PopChunk(iff)
    ENDIF
    PopChunk(iff)
    Raise("NONE")
EXCEPT
    freeiff(iff,unitnumber)
    IF table THEN Dispose(table)
    savememfree(bmhd,SIZEOF bitmapheader)
    IF (exception<>"NONE") THEN RETURN -1
ENDPROC 0

PROC freeiff(iff:PTR TO iffhandle,unit)
  checkarg(iff)
  CloseIFF(iff)
  IF (iff.stream)
    IF unit<100 THEN CloseClipboard(iff.stream) ELSE Close(iff.stream)
  ENDIF
  FreeIFF(iff)
ENDPROC

PROC win_resize()
  DEF w,h
  w:=win.width-win.borderleft-win.borderright
  h:=win.height-win.bordertop-win.borderbottom
  updateprop(win,horizgadget,PGA_VISIBLE,w)
  updateprop(win,vertgadget,PGA_VISIBLE,h)
  drawchunky(offx,offy,w,h,0,0,win.rport,ka.chunkybuf)
ENDPROC

PROC win_scroll()
  DEF w,h,oldoffx,oldoffy,deltax,deltay
  DEF scrollx=0,scrolly=0,scrollw=0,scrollh=0
  DEF redrawx=0,redrawy=0,redraww=0,redrawh=0
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='win_scroll()'
#endif
  w:=win.width-win.borderleft-win.borderright
  h:=win.height-win.bordertop-win.borderbottom
->  updateprop(win,horizgadget,PGA_VISIBLE,w)
->  updateprop(win,vertgadget,PGA_VISIBLE,h)
  dbg('old offx: \d\n',offx)
  dbg('old offy: \d\n',offy)
  oldoffx:=offx
  oldoffy:=offy
  GetAttr(PGA_TOP,horizgadget,{offx})
  GetAttr(PGA_TOP,vertgadget,{offy})
  deltax:=offx-oldoffx
  deltay:=offy-oldoffy
  IF ((deltax=0) AND (deltay=0)) THEN RETURN
  dbg('new offx: \d\n',offx)
  dbg('new offy: \d\n',offy)
  dbg('new w: \d\n',w)
  dbg('new h: \d\n',h)
  dbg('deltax: \d\n',deltax)
  dbg('deltay: \d\n',deltay)
/*
  PrintF('old offx: \d\n',oldoffx)
  PrintF('old offy: \d\n',oldoffy)
  PrintF('new offx: \d\n',offx)
  PrintF('new offy: \d\n',offy)
  PrintF('deltax: \d\n',deltax)
  PrintF('deltay: \d\n',deltay)
*/
  IF deltax>0 -> bar was pulled right, so we scroll from right to left
    scrollx:=deltax
    scrollw:=w-deltax
  ELSE
    scrollx:=0
    scrollw:=w-Abs(deltax)
  ENDIF
  IF deltay>=0
    scrolly:=deltay
    scrollh:=h-deltay
  ELSE
    scrolly:=0
    scrollh:=h-deltay
  ENDIF
->  PrintF('Scroll (\d,\d) by \d\n',scrollx,scrollx+scrollw,deltax)
->  ScrollRaster(win.rport,deltax,deltay,scrollx,scrolly,scrollx+scrollw,scrollh)
->  SetAPen(rp,7)
->  RectFill(rp,scrollx,0,scrollx+scrollw,h)

  IF deltax
  IF deltax>0
    redrawx:=scrollw
    redraww:=deltax
  ELSE
    redrawx:=0
    redraww:=Abs(deltax)
  ENDIF
  ENDIF
->  PrintF('Redraw (\d,\d) from \d\n',redrawx,redraww,offx)
->  Pi96WritePixelArray(p96ri,offx,0,rp,redrawx,0,redraww,h)
->  SetAPen(rp,3)
->  RectFill(rp,redrawx,0,redrawx+redraww,h)

  drawchunky(offx,offy,w,h,0,0,win.rport,ka.chunkybuf) -> this works, but redraws whole area
ENDPROC

PROC openscr()
  DEF wbscr:PTR TO screen,addon=0
  DEF pens:PTR TO INT
  DEF resolution,topborder,sf:PTR TO textattr,w,h,bw,bh,rw,rh,gw,gh,gap
  DEF apptitle:PTR TO CHAR
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='openscr()'
#endif

  savememalloc(pens,100)
  wbscr:=LockPubScreen('Workbench')

  -> create application title
  dbg('ofilename: "\s"\n',ofilename)
  dbg('afname: "\s"\n',afname)
  dbg('oldafile: "\s"\n',oldafile)
  apptitle:=String(60)
  StringF(apptitle,PROGRAMNAME+' '+PROGRAMVERSION+' - \s',afname)
  IF wbscr
    addon:=wbscr.barheight+1
    UnlockPubScreen(0,wbscr)
  ENDIF
  pens[DETAILPEN]:=findcolor(255,255,255)
  pens[BLOCKPEN]:=findcolor(0,0,0)
  pens[SHINEPEN]:=findcolor(255,255,255)
  pens[SHADOWPEN]:=findcolor(0,0,0)
  pens[FILLPEN]:=findcolor(0,128,255)
  pens[FILLTEXTPEN]:=findcolor(255,255,255)
  pens[BACKGROUNDPEN]:=findcolor(164,164,164)
  pens[TEXTPEN]:=findcolor(0,0,0)
  IF pens[TEXTPEN]=pens[BACKGROUNDPEN] THEN pens[TEXTPEN]:=findcolor(255,255,255)
  pens[HIGHLIGHTTEXTPEN]:=findcolor(196,128,32)
  pens[BARDETAILPEN]:=findcolor(0,0,0)
  pens[BARBLOCKPEN]:=findcolor(255,255,255)
  pens[BARTRIMPEN]:=findcolor(0,0,0)

    IF usewb
        onwb:=TRUE
        scr:=LockPubScreen('Workbench')
        depth:=scr.rastport.bitmap.depth
    dri:=GetScreenDrawInfo(scr)
    IF dri
      sizeimage:=newimageobject(SIZEIMAGE,dri,scr)
            leftimage:=newimageobject(LEFTIMAGE,dri,scr)
      rightimage:=newimageobject(RIGHTIMAGE,dri,scr)
      upimage:=newimageobject(UPIMAGE,dri,scr)
      downimage:=newimageobject(DOWNIMAGE,dri,scr)
    ELSE
        Raise("SCR")
    ENDIF
    ELSE
        onwb:=FALSE
        depth:=retdepth(mode)
        scr:=OpenScreenTagList(NIL,[SA_LIKEWORKBENCH,TRUE,
            SA_DEPTH,depth,
            SA_TITLE,apptitle,
            SA_COLORMAPENTRIES,256,
            SA_FULLPALETTE,FALSE,
            SA_WIDTH,envw,
            SA_HEIGHT,envh+addon,
            SA_INTERLEAVED,TRUE,
            SA_AUTOSCROLL,screenas,
            SA_OVERSCAN,screenos,
            SA_PENS,pens,
            IF (modeid>0) THEN SA_DISPLAYID ELSE $80000000,
                modeid,
            NIL,NIL])
        IF scr=NIL THEN Throw(ERR_OPENSCREEN,[envw,envh+addon,depth])
    ENDIF

  IF (vis:=GetVisualInfoA(scr,NIL))=0 THEN Raise("VIS")
  IF (menu:=CreateMenusA([NM_TITLE,0,cat.msgMenuProject.getstr(),'-',0,0,0,
                                                    NM_ITEM,0,cat.msgMenuProjectEditWindow.getstr(),'W',0,0,MENU_OBJWIN,
                                                    NM_ITEM,0,cat.msgMenuProjectPrefs.getstr(),'P',0,0,MENU_PREFS,
                                                    NM_ITEM,0,NM_BARLABEL,0,0,0,0,
                                                    NM_ITEM,0,cat.msgMenuProjectAppendCoords.getstr(),'A',0,0,MENU_SAVE,
                                                    NM_ITEM,0,cat.msgMenuProjectSaveAll.getstr(),'S',0,0,MENU_SAVEALL,
                                                    NM_ITEM,0,cat.msgMenuProjectClose.getstr(),'C',0,0,MENU_CLOSE,
                                                    NM_ITEM,0,NM_BARLABEL,0,0,0,0,
                                                    NM_ITEM,0,cat.msgMenuProjectRedrawScreen.getstr(),'R',0,0,MENU_REDRAW,
                                                    NM_ITEM,0,cat.msgMenuProjectSaveScreen.getstr(),'E',0,0,MENU_SAVESCREEN,
                                                    NM_ITEM,0,NM_BARLABEL,0,0,0,0,
                                                    NM_ITEM,0,cat.msgMenuProjectAbout.getstr(),'?',0,0,MENU_ABOUT,
                                                    NM_ITEM,0,NM_BARLABEL,0,0,0,0,
                                                    NM_ITEM,0,cat.msgMenuProjectQuit.getstr(),'Q',0,0,MENU_QUIT,
                                                    NM_TITLE,0,cat.msgMenuEdit.getstr(),0,0,0,0,
                                                    NM_ITEM,0,cat.msgMenuEditUndo.getstr(),'Z',0,0,MENU_UNDO,
                                                    NM_ITEM,0,cat.msgMenuEditReset.getstr(),'T',0,0,MENU_RESETOBJ,
                                                    NM_ITEM,0,NM_BARLABEL,0,0,0,0,
                                                    NM_ITEM,0,cat.msgMenuEditUnfix.getstr(),'U',0,0,MENU_UNFIXOBJ,
                                                    NM_ITEM,0,cat.msgMenuEditRefix.getstr(),'I',0,0,MENU_REFIXOBJ,
                                                    NM_ITEM,0,NM_BARLABEL,0,0,0,0,
                                                    NM_ITEM,0,cat.msgMenuEditMoveCelForward.getstr(),'+',NM_COMMANDSTRING,0,MENU_MOVEFORWARD,
                                                    NM_ITEM,0,cat.msgMenuEditMoveCelBack.getstr(),'-',NM_COMMANDSTRING,0,MENU_MOVEBACK,
                                                    NM_ITEM,0,NM_BARLABEL,0,0,0,0,
                                                    NM_ITEM,0,cat.msgMenuEditRevealCel.getstr(),'.',0,0,MENU_REVEAL,
                                                    NM_ITEM,0,cat.msgMenuEditPatrolBounds.getstr(),0,0,0,MENU_PATROL,
                                                    NM_ITEM,0,NM_BARLABEL,0,0,0,0,
                                                    NM_ITEM,0,cat.msgMenuEditReset.getstr(),0,0,0,MENU_RESETSET,
                                                    NM_TITLE,0,cat.msgMenuItem.getstr(),0,0,0,0,
                                                    NM_ITEM,0,cat.msgMenuItemSet.getstr(),0,0             ,0,0,
                                                    NM_SUB,0,'Set #0      ','F1',NM_COMMANDSTRING OR CHECKIT,%1111111110,MENU_SET0,
                                                    NM_SUB,0,'Set #1','F2',NM_COMMANDSTRING OR CHECKIT,%1111111101,MENU_SET1,
                                                    NM_SUB,0,'Set #2','F3',NM_COMMANDSTRING OR CHECKIT,%1111111011,MENU_SET2,
                                                    NM_SUB,0,'Set #3','F4',NM_COMMANDSTRING OR CHECKIT,%1111110111,MENU_SET3,
                                                    NM_SUB,0,'Set #4','F5',NM_COMMANDSTRING OR CHECKIT,%1111101111,MENU_SET4,
                                                    NM_SUB,0,'Set #5','F6',NM_COMMANDSTRING OR CHECKIT,%1111011111,MENU_SET5,
                                                    NM_SUB,0,'Set #6','F7',NM_COMMANDSTRING OR CHECKIT,%1110111111,MENU_SET6,
                                                    NM_SUB,0,'Set #7','F8',NM_COMMANDSTRING OR CHECKIT,%1101111111,MENU_SET7,
                                                    NM_SUB,0,'Set #8','F9',NM_COMMANDSTRING OR CHECKIT,%1011111111,MENU_SET8,
                                                    NM_SUB,0,'Set #9','F10',NM_COMMANDSTRING OR CHECKIT,%0111111111,MENU_SET9,
                                                    NM_ITEM,0,cat.msgMenuItemColor.getstr(),0,0               ,0,0,
                                                    NM_SUB,0,'Set #0      ','1',NM_COMMANDSTRING OR CHECKIT,%1111111110,MENU_CSET0,
                                                    NM_SUB,0,'Set #1','2',NM_COMMANDSTRING OR CHECKIT,%1111111101,MENU_CSET1,
                                                    NM_SUB,0,'Set #2','3',NM_COMMANDSTRING OR CHECKIT,%1111111011,MENU_CSET2,
                                                    NM_SUB,0,'Set #3','4',NM_COMMANDSTRING OR CHECKIT,%1111110111,MENU_CSET3,
                                                    NM_SUB,0,'Set #4','5',NM_COMMANDSTRING OR CHECKIT,%1111101111,MENU_CSET4,
                                                    NM_SUB,0,'Set #5','6',NM_COMMANDSTRING OR CHECKIT,%1111011111,MENU_CSET5,
                                                    NM_SUB,0,'Set #6','7',NM_COMMANDSTRING OR CHECKIT,%1110111111,MENU_CSET6,
                                                    NM_SUB,0,'Set #7','8',NM_COMMANDSTRING OR CHECKIT,%1101111111,MENU_CSET7,
                                                    NM_SUB,0,'Set #8','9',NM_COMMANDSTRING OR CHECKIT,%1011111111,MENU_CSET8,
                                                    NM_SUB,0,'Set #9','10',NM_COMMANDSTRING OR CHECKIT,%0111111111,MENU_CSET9,
                                                    NM_END,0,'End','x',0,0,0]:newmenu,NIL))=NIL THEN Raise(ERR_CREATEMENU)
    LayoutMenusA(menu,vis,[GTMN_NEWLOOKMENUS,TRUE,NIL,NIL])
    IF (onwb)
        IF sizeimage=0 THEN Raise("SCR")
      resolution:=sysisize(scr)
      sf:=scr.font
      topborder:=scr.wbortop+sf.ysize+1
      w:=sizeimage.width
      h:=sizeimage.height
      bw:=IF resolution=SYSISIZE_LOWRES THEN 1 ELSE 2
      bh:=IF resolution=SYSISIZE_HIRES THEN 2 ELSE 1
      rw:=IF resolution=SYSISIZE_HIRES THEN 3 ELSE 2
      rh:=IF resolution=SYSISIZE_HIRES THEN 2 ELSE 1
      gh:=Max(leftimage.height,h)
      gh:=Max(rightimage.height,gh)
      gw:=Max(upimage.width,w)
      gw:=Max(downimage.width,gw)
      gap:=1
      horizgadget:=newpropobject(FREEHORIZ,
        [GA_LEFT,rw+gap,
         GA_RELBOTTOM,bh-gh+2,
         GA_RELWIDTH,(-gw)-gap-leftimage.width-rightimage.width-rw-rw,
         GA_HEIGHT,gh-bh-bh-2,
         GA_BOTTOMBORDER,TRUE,
         GA_ID,HORIZ_GID,
         PGA_TOTAL,envw,
         PGA_VISIBLE,envw,
         GA_GZZGADGET,TRUE,
         NIL],dri)
      vertgadget:=newpropobject(FREEVERT,
        [GA_RELRIGHT,bw-gw+3,
         GA_TOP,topborder+rh,
         GA_WIDTH,gw-bw-bw-4,
         GA_RELHEIGHT,(-topborder)-h-upimage.height-downimage.height-rh-rh,
         GA_RIGHTBORDER,TRUE,
         GA_PREVIOUS,horizgadget,
         GA_ID,VERT_GID,
         PGA_TOTAL,envh,
         PGA_VISIBLE,envh,
         GA_GZZGADGET,TRUE,
         NIL],dri)
      leftgadget:=newbuttonobject(leftimage,
        [GA_RELRIGHT,(1)-leftimage.width-rightimage.width-gw,
         GA_RELBOTTOM,(1)-leftimage.height,
         GA_BOTTOMBORDER,TRUE,
         GA_PREVIOUS,vertgadget,
         GA_ID,LEFT_GID,
         GA_GZZGADGET,TRUE,
         NIL])
      rightgadget:=newbuttonobject(rightimage,
        [GA_RELRIGHT,(1)-rightimage.width-gw,
         GA_RELBOTTOM,(1)-rightimage.height,
         GA_BOTTOMBORDER,TRUE,
         GA_PREVIOUS,leftgadget,
         GA_ID,RIGHT_GID,
         GA_GZZGADGET,TRUE,
         NIL])
      upgadget:=newbuttonobject(upimage,
        [GA_RELRIGHT,(1)-upimage.width,
         GA_RELBOTTOM,(1)-upimage.height-downimage.height-h,
         GA_RIGHTBORDER,TRUE,
         GA_PREVIOUS,rightgadget,
         GA_ID,UP_GID,
         GA_GZZGADGET,TRUE,
         NIL])
      downgadget:=newbuttonobject(downimage,
        [GA_RELRIGHT,(1)-downimage.width,
         GA_RELBOTTOM,(1)-downimage.height-h,
         GA_RIGHTBORDER,TRUE,
         GA_PREVIOUS,upgadget,
         GA_ID,DOWN_GID,
         GA_GZZGADGET,TRUE,
         NIL])
->      IF downgadget=0 THEN Raise("WIN")
      -> open window on Workbench screen
        win:=OpenWindowTagList(0,[
            WA_INNERWIDTH,envw,
            WA_INNERHEIGHT,envh,
            WA_GADGETS,horizgadget,
            WA_TOP,scr.barheight+1,
            WA_LEFT,0,
            WA_FLAGS,WFLG_ACTIVATE OR WFLG_SIMPLE_REFRESH  OR WFLG_GIMMEZEROZERO
                    OR WFLG_DRAGBAR OR WFLG_DEPTHGADGET OR  WFLG_SIZEGADGET OR WFLG_CLOSEGADGET,
            WA_SIZEBRIGHT,TRUE,
            WA_SIZEBBOTTOM,TRUE,
            WA_AUTOADJUST,TRUE,
            WA_BORDERLESS,FALSE,
            WA_BACKDROP,FALSE,
            WA_CUSTOMSCREEN,scr,
            WA_NEWLOOKMENUS,TRUE,
            WA_POINTER,hand1,
            WA_IDCMP,IDCMP_MENUPICK OR IDCMP_MOUSEBUTTONS OR IDCMP_INTUITICKS OR IDCMP_MENUVERIFY OR IDCMP_MOUSEMOVE OR IDCMP_VANILLAKEY OR IDCMP_RAWKEY OR IDCMP_NEWSIZE OR IDCMP_CLOSEWINDOW OR IDCMP_REFRESHWINDOW OR IDCMP_IDCMPUPDATE,
            WA_MINWIDTH,96,
            WA_MINHEIGHT,64,
            WA_TITLE,apptitle,
            WA_SCREENTITLE,PROGRAMNAME,
            NIL,NIL])
        IF win=NIL THEN Throw(ERR_OPENWINDOW,[envw,envh,WFLG_ACTIVATE OR WFLG_SMART_REFRESH  OR WFLG_GIMMEZEROZERO OR WFLG_DRAGBAR OR WFLG_DEPTHGADGET OR  WFLG_SIZEGADGET OR WFLG_CLOSEGADGET,IDCMP_MENUPICK OR IDCMP_MOUSEBUTTONS OR IDCMP_INTUITICKS OR IDCMP_MENUVERIFY OR IDCMP_MOUSEMOVE OR IDCMP_VANILLAKEY OR IDCMP_RAWKEY OR IDCMP_NEWSIZE OR IDCMP_CLOSEWINDOW OR IDCMP_REFRESHWINDOW OR IDCMP_IDCMPUPDATE])
    ELSE
        win:=OpenWindowTagList(0,[WA_WIDTH,scr.width,WA_HEIGHT,scr.height-scr.barheight-1,
            WA_TOP,scr.barheight+1,WA_LEFT,0,
            WA_FLAGS,WFLG_ACTIVATE OR WFLG_SMART_REFRESH,
            WA_BORDERLESS,TRUE,
            WA_BACKDROP,TRUE,
            WA_CUSTOMSCREEN,scr,
            WA_NEWLOOKMENUS,TRUE,
            WA_POINTER,hand1,
            WA_IDCMP,IDCMP_MENUPICK OR IDCMP_MOUSEBUTTONS OR IDCMP_INTUITICKS OR IDCMP_MENUVERIFY OR IDCMP_MOUSEMOVE OR IDCMP_VANILLAKEY OR IDCMP_RAWKEY,
            NIL,NIL])
        IF win=NIL THEN Throw(ERR_OPENWINDOW,[scr.width,scr.height-scr.barheight-1,WFLG_ACTIVATE OR WFLG_SMART_REFRESH,IDCMP_MENUPICK OR IDCMP_MOUSEBUTTONS OR IDCMP_INTUITICKS OR IDCMP_MENUVERIFY OR IDCMP_MOUSEMOVE OR IDCMP_VANILLAKEY OR IDCMP_RAWKEY])
    ENDIF
  w:=win.width-win.borderleft-win.borderright
  h:=win.height-win.bordertop-win.borderbottom
  updateprop(win,horizgadget,PGA_VISIBLE,w)
  updateprop(win,vertgadget,PGA_VISIBLE,h)
  GetAttr(PGA_TOP,horizgadget,{offx})
  GetAttr(PGA_TOP,vertgadget,{offy})

  SetMouseQueue(win,1)
  SetMenuStrip(win,menu)
  vp:=scr.viewport
  cm:=vp.colormap
  rp:=win.rport
  IF onwb=FALSE
    IF (retdepth(mode)<5)
      SetRGB32(vp,17,byte2long(160),byte2long(160),byte2long(160))
      SetRGB32(vp,18,0,0,0)
      SetRGB32(vp,19,$FFFFFFFF,$FFFFFFFF,$FFFFFFFF)
    ENDIF
  ENDIF
  ka.chunkybuf:=New((envw*envh)+(envw*10))
  init_video(scr)
  savememfree(pens,100)
  set(wi_edit,MUIA_Window_Screen,scr)
  set(wi_about,MUIA_Window_Screen,scr)
  set(wi_reveal,MUIA_Window_Screen,scr)
  set(wi_prefs,MUIA_Window_Screen,scr)
  set(wi_output,MUIA_Window_Screen,scr)
ENDPROC

-> prepare drawing environmant
PROC init_video(scr:PTR TO screen)
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='init_video()'
#endif
  -> by default we use standard graphics functions
  drawchunky:=NIL
  -> first we try to use Picasso96
  IF pi96base
    -> check if our screen's bitmap is a P96 one
    IF Pi96GetBitMapAttr(scr.rastport.bitmap,P96BMA_ISP96)
      drawchunky:={drawchunky_p96}
      -> allocate RenderInfo structure if it doesn't exists
      IF p96ri=NIL
        savememalloc(p96ri,SIZEOF p96RenderInfo)
        p96ri.memory:=ka.chunkybuf
        p96ri.bytesperrow:=envw
        p96ri.pad:=NIL
        p96ri.rgbformat:=RGBFB_CLUT
      ENDIF
      qdbg('Using P96 draw routines')
    ENDIF
  ELSEIF cybergfxbase
    IF IsCyberModeID(modeid) THEN drawchunky:={drawchunky_cgx}
    qdbg('Using CGX draw routines')
  ENDIF
  -> fall to standard draw routines
  IF drawchunky=NIL
    drawchunky:={drawchunky_ami}
    qdbg('Using standard draw routines')
  ENDIF
ENDPROC

PROC drawchunky_p96(srcx,srcy,width,height,destx,desty,rp:PTR TO rastport,array:PTR TO CHAR) IS Pi96WritePixelArray(p96ri,srcx,srcy,rp,destx,desty,width,height)
PROC drawchunky_cgx(srcx,srcy,width,height,destx,desty,rp:PTR TO rastport,array:PTR TO CHAR) IS WritePixelArray(ka.chunkybuf,srcx,srcy,envw,rp,destx,desty,width,height,RECTFMT_LUT8)
PROC drawchunky_ami(srcx,srcy,width,height,destx,desty,rp:PTR TO rastport,array:PTR TO CHAR)
  DEF i,t
  -> t points to the first pixel of chunky area to draw inside our chunky buffer
  t:=ka.chunkybuf+(srcy*envw)+srcx
  FOR i:=srcy TO srcy+height-1
    WritePixelLine8(rp,srcx,i,width,t,temprp)
    -> proceed to the next line
    t:=t+envw
  ENDFOR
ENDPROC

PROC closescr()
  DEF i
  set(wi_prefs,MUIA_Window_Open,FALSE)
  set(wi_prefs,MUIA_Window_Screen,0)
  set(wi_edit,MUIA_Window_Open,FALSE)
  set(wi_edit,MUIA_Window_Screen,0)
  set(wi_about,MUIA_Window_Open,FALSE)
  set(wi_about,MUIA_Window_Screen,0)
  set(wi_reveal,MUIA_Window_Open,FALSE)
  set(wi_reveal,MUIA_Window_Screen,0)
  set(wi_output,MUIA_Window_Open,FALSE)
  set(wi_output,MUIA_Window_Screen,0)
  IF win
    CloseWindow(win)
    IF horizgadget THEN DisposeObject(horizgadget);horizgadget:=0
    IF vertgadget THEN DisposeObject(vertgadget);vertgadget:=0
    IF leftgadget THEN DisposeObject(leftgadget);leftgadget:=0
    IF rightgadget THEN DisposeObject(rightgadget);rightgadget:=0
    IF upgadget THEN DisposeObject(upgadget);upgadget:=0
    IF downgadget THEN DisposeObject(downgadget);downgadget:=0
    win:=0
  ENDIF
  IF vis THEN FreeVisualInfo(vis) ; vis:=0
  FOR i:=1 TO 255
    IF apens[i]>=0 THEN ReleasePen(cm,apens[i])
    apens[i]:=-1
  ENDFOR
  IF bgpen>=0 THEN ReleasePen(cm,bgpen) ; bgpen:=-1
  IF scr
    IF dri THEN FreeScreenDrawInfo(scr,dri);dri:=0
    IF onwb
      IF sizeimage THEN DisposeObject(sizeimage);sizeimage:=0
      IF leftimage THEN DisposeObject(leftimage);leftimage:=0
      IF rightimage THEN DisposeObject(rightimage);rightimage:=0
      IF upimage THEN DisposeObject(upimage);upimage:=0
      IF downimage THEN DisposeObject(downimage);downimage:=0
      UnlockPubScreen(0,scr)
    ELSE
      CloseScreen(scr)
    ENDIF
    scr:=0
    cm:=0
  ENDIF
  IF ka.chunkybuf THEN Dispose(ka.chunkybuf);ka.chunkybuf:=0
  WbenchToFront()
ENDPROC

PROC freeevents()
    DEF event:PTR TO event
    DEF com:PTR TO command
    DEF next1,next2
    event:=eventlist.head
    REPEAT
        next1:=event.ln.succ
        IF (next1)
            com:=event.commands.head
            REPEAT
                next2:=com.ln.succ
                IF (next2)
                    Remove(com)
                    IF com.cel THEN DisposeLink(com.cel)
                    IF com.sound THEN DisposeDTObject(com.sound)
                    END com
                ENDIF
                com:=next2
            UNTIL next2=0
            Remove(event)
            IF event.cel THEN DisposeLink(event.cel)
            END event
        ENDIF
        event:=next1
    UNTIL next1=0
ENDPROC

PROC freepals()
  DEF i
  FOR i:=0 TO 15 DO StrCopy(palet[i].name,'')
ENDPROC

PROC loadcnf() HANDLE
  DEF fh=0
  DEF fib=0:PTR TO fileinfoblock
  DEF lock=0
  DEF buf=0:PTR TO CHAR
  DEF dir[500]:STRING,fi[500]:STRING
  DEF lha[50]:STRING
  DEF fileloaded=0
  DEF isarc=FALSE
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='loadcnf()'
#endif

  dbg('afname: \s\n',afname)
  dbg('ofilename: \s\n',ofilename)
  set(wi_main,MUIA_Window_Open,TRUE)
  set(wi_main,MUIA_Window_ActiveObject,g_file)
    IF StrLen(ofilename) THEN StrCopy(afname,ofilename)
    set(g_status,MUIA_Gauge_Current,0)
    set(g_status,MUIA_Gauge_Max,1)
    set(g_status,MUIA_Gauge_InfoText,cat.msgStatusSelectCNFFile.getstr())
    set(g_file,MUIA_String_Contents,ofilename)
    IF (fib:=AllocDosObject(DOS_FIB,0))=0 THEN Raise("err")
    continue:=0
    fileloaded:=0
    set(g_play,MUIA_Disabled,MUI_TRUE)
    REPEAT
        IF StrLen(afname)
            splitname(afname,dir,fi)
            RightStr(lha,fi,4)
            IF stricmp('.lha',lha,4)
                dearc(afname,0)
                isarc:=TRUE
            ELSEIF stricmp('.lzh',lha,4)
                dearc(afname,0)
                isarc:=TRUE
            ELSEIF stricmp('.lzx',lha,4)
                dearc(afname,1)
                isarc:=TRUE
            ELSE
                isarc:=0
            ENDIF
            dbg('Archive: \s\n',IF isarc THEN 'Y' ELSE 'N')
            IF (lock:=Lock(afname,SHARED_LOCK))
                Examine(lock,fib)
                IF (fh:=Open(afname,MODE_OLDFILE))
                    IF (buf:=New(fib.size+32))
                        Read(fh,buf,fib.size)
                        domethod(g_list,[MUIM_List_Clear])
                        domethod(g_errorlist,[MUIM_List_Clear])
                        splitname(afname,dir,fi)
                        parsecnf(buf,fib.size,dir)
                        Close(fh);fh:=0
                        fileloaded:=TRUE
                        Dispose(buf);buf:=0
                        set(g_play,MUIA_Disabled,FALSE)
                    ENDIF
                ENDIF
                UnLock(lock);lock:=0
            ENDIF
        ENDIF
        continue:=0
        WHILE continue=0
            stepon:=0
            muiresult:=domethod(ap_main,[MUIM_Application_Input,{ap_signal}])
            muiresult:=handlemui(muiresult)
            IF ap_signal
                Wait(ap_signal)
            ENDIF
            IF (muiresult=MUIV_Application_ReturnID_Quit) THEN continue:=5
            IF (muiresult=ID_PLAY) THEN continue:=4
            IF stepon THEN continue:=1
        ENDWHILE
    UNTIL continue>3
    qdbg(DBG_DONE)
EXCEPT DO
    IF isarc THEN cleanuparc()
    IF fib THEN FreeDosObject(DOS_FIB,fib)
    IF lock THEN UnLock(lock)
    IF buf THEN Dispose(buf)
    domethod(g_list,[MUIM_List_Clear])
    domethod(g_errorlist,[MUIM_List_Clear])
    set(wi_main,MUIA_Window_Open,FALSE)
    IF fh THEN Close(fh)
    IF exception="Egui" THEN ReThrow()
    IF exception="bigg" THEN ReThrow()
    IF exception="file" THEN RETURN "file"
ENDPROC continue

PROC getscreenname()
  DEF buf:PTR TO nameinfo
  DEF modestring[400]:STRING
  IF (buf:=New(MODENAMELENGTH))
    IF GetDisplayInfoData(0,buf,1000,DTAG_NAME,tmodeid)
      StrCopy(modestring,buf.name)
      set(g_modename,MUIA_Text_Contents,modestring)
    ENDIF
  Dispose(buf)
  ENDIF
ENDPROC

PROC loadprefs(name)
    DEF buffy:PTR TO LONG,fh
    buffy:=New(800)
    fh:=Open(name,MODE_OLDFILE)
    IF fh
        Read(fh,buffy,100)
        Close(fh)
        modeid:=buffy[0]
        screenos:=buffy[1]
        screenas:=buffy[2]
        animspeed:=buffy[3]
        usebounds:=buffy[4]
        usehand:=buffy[5]
        usefollow:=buffy[7]
        usesnap:=buffy[8]
        usenasty:=buffy[9]
        useregions:=buffy[10]
        usewb:=buffy[11]
    ENDIF
    Dispose(buffy)
ENDPROC
/*
PROC loadprefs(name)
  DEF fh,filelen,buffer
  DEF rdargs
->  DEf par=NIL:PTR TO parser
  -> open file
  fh:=Open(name,MODE_OLDFILE)
  IF fh=NIL THEN RETURN
  -> get its lenght
  Seek(fh,0,OFFSET_END)
  filelen:=Seek(fh,0,OFFSET_BEGINNING)
  -> allocate buffer
  savememalloc(buffer,filelen)
  -> read file into buffer
  Read(fh,buffer,filelen)
  -> change EOLs to spaces
  mStrMap(buffer,[10,32]:CHAR,1)
->  NEW par.parser()
->  par.parse('MODEID/K,OVERSCAN/K/N,AUTOSCROLL/K,ANIMSPEED/K/N,',buffer)
  PrintF('modeid \s\nanimspped \d\n',par.arg(0),par.arg(2))
  FastDispose(buffer,filelen)
  Close(fh)
ENDPROC
*/

PROC saveprefs(name)
  DEF buffy:PTR TO LONG,fh
  savememalloc(buffy,100)
  buffy[0]:=modeid
  buffy[1]:=screenos
  buffy[2]:=screenas
  buffy[3]:=animspeed
  buffy[4]:=usebounds
  buffy[5]:=usehand
  buffy[7]:=usefollow
  buffy[8]:=usesnap
  buffy[9]:=usenasty
  buffy[10]:=useregions
  buffy[11]:=usewb
  fh:=Open(name,MODE_NEWFILE)
  IF fh
    Write(fh,buffy,100)
    Close(fh)
  ENDIF
  savememfree(buffy,100)
ENDPROC
/*
PROC saveprefs(name)
  DEF tempstr[64]:STRING,fh=NIL
  fh:=Open(name,MODE_NEWFILE)
  IF fh
    StringF(tempstr,'MODEID     = \d\n',modeid)
    Write(fh,tempstr,StrLen(tempstr))
    StringF(tempstr,'OVERSCAN   = \d\n',screenos)
    Write(fh,tempstr,StrLen(tempstr))
    StringF(tempstr,'ANIMSPEED  = \d\n',animspeed)
    Write(fh,tempstr,StrLen(tempstr))
    StringF(tempstr,'AUTOSCROLL = \s\n',IF screenas THEN OPTION_ON ELSE OPTION_OFF)
    Write(fh,tempstr,StrLen(tempstr))
    StringF(tempstr,'USEBOUNDS  = \s\n',IF usebounds THEN OPTION_ON ELSE OPTION_OFF)
    Write(fh,tempstr,StrLen(tempstr))
    StringF(tempstr,'USEHAND    = \s\n',IF usehand THEN OPTION_ON ELSE OPTION_OFF)
    Write(fh,tempstr,StrLen(tempstr))
    StringF(tempstr,'USEFOLLOW  = \s\n',IF usefollow THEN OPTION_ON ELSE OPTION_OFF)
    Write(fh,tempstr,StrLen(tempstr))
    StringF(tempstr,'USESNAP    = \s\n',IF usesnap THEN OPTION_ON ELSE OPTION_OFF)
    Write(fh,tempstr,StrLen(tempstr))
    StringF(tempstr,'USENASTY   = \s\n',IF usenasty THEN OPTION_ON ELSE OPTION_OFF)
    Write(fh,tempstr,StrLen(tempstr))
    StringF(tempstr,'USEREGIONS = \s\n',IF useregions THEN OPTION_ON ELSE OPTION_OFF)
    Write(fh,tempstr,StrLen(tempstr))
    StringF(tempstr,'USEWB      = \s\n',IF usewb THEN OPTION_ON ELSE OPTION_OFF)
    Write(fh,tempstr,StrLen(tempstr))
    Close(fh)
  ENDIF
ENDPROC
*/

PROC prefs()
    DEF a
    tmodeid:=modeid
    tscreenos:=screenos
    tscreenas:=screenas
    tanimspeed:=animspeed
    tusebounds:=usebounds
    tusehand:=usehand
    tuseregions:=useregions
    tusefollow:=usefollow
    tusesnap:=usesnap
    tusenasty:=usenasty
    tusewb:=usewb
    getscreenname()
    a:=(tanimspeed/10)
    set(g_pspeed,MUIA_Slider_Level,a)
    set(g_penforce,MUIA_Selected,tusebounds)
    set(g_pfollow,MUIA_Selected,tusefollow)
    set(g_pelastic,MUIA_Selected,tusesnap)
    set(g_pworkbench,MUIA_Selected,tusewb)
    set(g_pcyber,MUIA_Selected,tusenasty)
    set(g_pupdate,MUIA_Cycle_Active,tuseregions)
    set(g_ppointer,MUIA_Cycle_Active,tusehand)
    set(wi_prefs,MUIA_Window_Screen,scr)
  set(wi_prefs,MUIA_Window_Open,MUI_TRUE)
ENDPROC

PROC getsmr()
    DEF ret
    busy()
    ret:=AslRequest(smr,
     [IF scr THEN ASLSM_SCREEN ELSE ASLSM_PUBSCREENNAME,IF scr THEN scr ELSE 'Workbench',
        ASLSM_DOOVERSCANTYPE,TRUE,
        ASLSM_DOAUTOSCROLL,TRUE,
        ASLSM_INITIALDISPLAYID,tmodeid,
        ASLSM_INITIALOVERSCANTYPE,tscreenos,
        ASLSM_INITIALAUTOSCROLL,tscreenas,
        NIL])
    IF ret
        tmodeid:=smr.displayid
        tscreenas:=smr.autoscroll
        tscreenos:=smr.overscantype
    ENDIF
    ready()
ENDPROC

PROC getfile()
  DEF buffe
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='getfile()'
#endif
  get(g_file,MUIA_String_Acknowledge,{buffe})
  StrCopy(afname,buffe)
  stepon:=1
  dbg('file: "\s"\n',afname)
ENDPROC

->PROC loadstr() IS stepon:=1

PROC parsecnf(buf:PTR TO CHAR,lof,dirname) HANDLE
    DEF mark=0,smark,omark,result
    DEF objn,fixval
    DEF lc
    DEF numstr[12]:STRING
    DEF celname[100]:STRING,cel:PTR TO cel
    DEF obj:PTR TO obj
    DEF i,t:PTR TO LONG
    DEF tmpstr[500]:STRING
    DEF cset=-1,ccel=-1
    DEF celsetfound,celpalfound
    DEF w,h
    DEF aa
    DEF acurobj=0:PTR TO event
    DEF curc,tcels
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='parsecnf()'
#endif

    linenum:=1
    events:=0
    setn(g_events,events)
    commands:=0
    setn(g_actions,commands)
    setn(g_events,0)
    setn(g_actions,0)
    setn(g_objs,0)
    setn(g_cels,0)
    setn(g_colors,0)
    setn(g_memory,0)
    palset:=0
    totmem:=0
    mode:=0
    fkissfound:=0
    freecels()
    freeobjs()
    freepals()
    freeevents()
    FOR i:=0 TO 9 DO pb[i]:=0

    set(g_status,MUIA_Gauge_Current,0)
    set(g_status,MUIA_Gauge_Max,1)
    set(g_status,MUIA_Gauge_InfoText,cat.msgStatusParsingCNFFile.getstr())

    envw:=448
    envh:=320

    set(wi_main,MUIA_Window_Sleep,MUI_TRUE)
    REPEAT
        lc:=buf[mark]
        SELECT lc
        CASE "$"
            smark:=mark+1
            INC cset
            ccel:=-1
            smark,result:=scan_value(buf,smark,numstr,lof)
            IF result=0
                StrToLong(numstr,{i})
                pb[cset]:=i
                ccel:=parsesetline(buf,smark+1,lof,cset,ccel)
            ELSE
                egerr()
            ENDIF
        CASE " "
            IF cset>=0
                ccel:=parsesetline(buf,mark+1,lof,cset,ccel)
            ENDIF
        CASE ";"
            IF buf[mark+1]="@"
                IF stricmp('EventHandler',buf+mark+2,12)
                    fkissfound:=TRUE
                ENDIF
                IF fkissfound
                    mark,acurobj:=parsefkiss(buf,mark+2,lof,acurobj,dirname)
                ENDIF
            ENDIF
        CASE "%"
            StrCopy(celname,'')
            scan_string(buf,mark+1,celname,lof)
            IF celname
                load_palet(dirname,celname)
                palset:=palset+1
                setn(g_colors,palset*16)
            ENDIF
        CASE "["
            smark:=mark+1
            smark,result:=scan_value(buf,smark,numstr,lof)
            IF result=0
                StrToLong(numstr,{backcolor})
            ELSE
                backcolor:=0
            ENDIF
        CASE "("
            smark:=mark+1
            smark,result:=scan_value(buf,smark,numstr,lof)
            IF result=0
                StrToLong(numstr,{envw})
                envw:=((envw+31)/32)*32
                smark,result:=scan_value(buf,smark+1,numstr,lof)
                IF result=0
                    StrToLong(numstr,{envh})
                ELSE
                    egerr()
                ENDIF
            ELSE
                egerr()
            ENDIF
        CASE "#"
            cel:=0
            fixval:=0
            StrCopy(celname,'')
            smark:=mark+1
            StrCopy(numstr,'')
            smark,result:=scan_value(buf,smark,numstr,lof)
            IF result=0
                StrToLong(numstr,{objn})
                IF buf[smark]="."
                    smark:=smark+1
                    StrCopy(numstr,'')
                    smark,result:=scan_value(buf,smark,numstr,lof)
                    IF result=0
                        StrToLong(numstr,{fixval})
                    ELSE
                        egerr()
                    ENDIF
                ENDIF
                smark:=scan_nonspace(buf,smark,lof)
                smark:=scan_string(buf,smark,celname,lof)

                IF (StrLen(celname))
                    cel:=alloccel()
                    IF (cel)
                        cel.realname(celname)
                        cel.setobj(objn)
                        cel.fix:=fixval
                        obj:=allocobj(objn)
                        obj.fix:=Max(fixval,obj.fix)
                        obj.oldfix:=obj.fix

                        FOR i:=0 TO 9 DO cel.setset(i,1)

                        celsetfound:=FALSE;celpalfound:=FALSE
                        omark:=smark
                        WHILE ((buf[smark]<>10) AND (buf[smark]<>13) AND (smark<lof) AND (buf[smark]<>";"))
                            IF ((buf[smark]="*") AND (celpalfound=FALSE))
                                celpalfound:=TRUE
                                smark:=smark+1
                                smark,result:=scan_value(buf,smark,numstr,lof)
                                IF result=0
                                    StrToLong(numstr,{i})
                                    cel.setpalette(i)
                                ELSE
                                    egerr()
                                ENDIF
                            ENDIF
                            IF ((buf[smark]=":") AND (celsetfound=FALSE))
                                celsetfound:=TRUE
                                FOR i:=0 TO 9 DO cel.setset(i,0)
                                smark:=smark+1
                                WHILE ((buf[smark]<>10) AND (buf[smark]<>13) AND (smark<lof) AND (buf[smark]<>";"))
                                    StrCopy(numstr,buf+smark,1)
                                    IF ((buf[smark]>="0") AND (buf[smark]<="9"))
                                        StrToLong(numstr,{i})
                                        cel.setset(i,1)
                                    ENDIF
                                    smark:=smark+1
                                ENDWHILE
                                smark:=smark-1
                            ENDIF
                            smark:=smark+1
                        ENDWHILE
                        i:=omark
                        smark:=i
                        WHILE ((buf[i]<>10) AND (buf[i]<>13))
                            IF buf[i]=";"
                                smark:=i
                            ENDIF
                            INC i
                        ENDWHILE
                        IF (smark<(i-1))
                            StrCopy(tmpstr,buf+smark+1,i-smark-1)
                            cel.comment(tmpstr)
                        ELSE
                            cel.comment('-')
                        ENDIF
                    ENDIF
                ELSE
                    egerr()
                ENDIF
            ELSE
                egerr()
            ENDIF
        ENDSELECT
        mark:=seekcrlf(buf,mark,lof);linenum:=linenum+1
        domethod(ap_main,[MUIM_Application_Input,{ap_signal}])
    UNTIL (mark>=lof)
    set(g_status,MUIA_Gauge_InfoText,cat.msgStatusLoadingCelFiles.getstr())
    tcels:=countcels()
    curc:=0
    setn(g_cels,countcels())
    setn(g_objs,countobjs())
    setn(g_events,events)
    setn(g_actions,commands)
    t:=List(MAXCELS)
    FOR i:=MAXCELS TO 0 STEP -1
        cel:=cels[i]
        IF cel
            setloaded:=TRUE
            IF ((i/3)=((i+2)/3))
                set(g_status,MUIA_Gauge_Current,curc)
                set(g_status,MUIA_Gauge_Max,tcels)
            ENDIF
            curc:=curc+1
            w,h:=cel.load(dirname)
            IF w>0 AND h>0
                totmem:=totmem+(w*h)
                IF usewb THEN totmem:=totmem+(w*h)
            ELSE
                nofileerr(celname)
            ENDIF
        ENDIF
        domethod(ap_main,[MUIM_Application_Input,{ap_signal}])
    ENDFOR
    aa:=0
    FOR i:=MAXCELS TO 0 STEP -1
        IF cels[i]
            t[aa]:=i
            INC aa
        ENDIF
    ENDFOR
    updatereveal()
    set(g_list,MUIA_List_Format,'MIW=1 MAW=1,MIW=90 MAW=100,MIW=1 MAW=1,MIW=1 MAW=1,MIW=1 MAW=1,MIW=1 MAW=1,MIW=1 MAW=1')
    domethod(g_list,[MUIM_List_Insert,t,-1,MUIV_List_Insert_Bottom])
    FastDisposeList(t)
    set(g_list,MUIA_List_Format,'D=6 P=\er BAR,D=10,D=10,D=10,,BAR,')
    setn(g_memory,totmem)
    set(g_status,MUIA_Gauge_Current,0)
    set(g_status,MUIA_Gauge_Max,1)
    set(g_status,MUIA_Gauge_InfoText,'Ready!')
    set(wi_main,MUIA_Window_Sleep,FALSE)
EXCEPT DO
    NOP
ENDPROC

PROC allocstring(str)
  DEF f
  f:=String(StrLen(str))
  IF f THEN StrCopy(f,str)
ENDPROC f

-> This is converted from a procedure. Macros are faster.
#define deallocstring(str) IF str THEN DisposeLink(str)

PROC destructhook(rqhook,pool,p:PTR TO listent) -> a0,a2,a1
  checkarg(p)
  deallocstring(p.num)
  deallocstring(p.name)
  deallocstring(p.size)
  deallocstring(p.pal)
  deallocstring(p.sets)
  deallocstring(p.comment)
  deallocstring(p.obj)
  savememfree(p,SIZEOF listent)
ENDPROC
PROC constructhook(rqhook,pool,i)
  DEF cel:PTR TO cel
  DEF pp:PTR TO listent
  DEF s[100]:STRING
  cel:=cels[i]
  IF cel=NIL THEN RETURN
  savememalloc(pp,SIZEOF listent)
  StringF(s,'\d',MAXCELS-i)
  pp.num:=allocstring(s)
  StringF(s,'\s',cel.realname)
  pp.name:=allocstring(s)
  StringF(s,'\d x \d',cel.w,cel.h)
  pp.size:=allocstring(s)
  StringF(s,'\d',cel.palet_num)
  pp.pal:=allocstring(s)
  StringF(s,'[\d\d\d\d\d\d\d\d\d\d]',cel.sets[0],cel.sets[1],cel.sets[2],cel.sets[3],cel.sets[4],cel.sets[5],cel.sets[6],cel.sets[7],cel.sets[8],cel.sets[9])
  pp.sets:=allocstring(s)
  StringF(s,':\s',cel.comment)
  pp.comment:=allocstring(s)
  StringF(s,'\d',cel.obj)
  pp.obj:=allocstring(s)
ENDPROC pp

PROC disphook(rqhook,array:PTR TO LONG,p:PTR TO listent)
  IF p
    array[0]:=p.num
    array[1]:=p.name
    array[2]:=p.obj
    array[3]:=p.size
    array[4]:=p.pal
    array[5]:=p.sets
    array[6]:=p.comment
  ELSE
    array[0]:=cat.msgLoaderSetInfoNumber.getstr()
    array[1]:=cat.msgLoaderSetInfoName.getstr()
    array[2]:=cat.msgLoaderSetInfoObjectNumber.getstr()
    array[3]:=cat.msgLoaderSetInfoSize.getstr()
    array[4]:=cat.msgLoaderSetInfoPalette.getstr()
    array[5]:=cat.msgLoaderSetInfoSets.getstr()
    array[6]:=cat.msgLoaderSetInfoComment.getstr()
  ENDIF
ENDPROC 0

-> return random value from given range
PROC rndrange(a,b)
  DEF min,max,ret
  -> find smaller value
  IF a>b
    min:=b
    max:=a
  ELSE
    min:=a
    max:=b
  ENDIF
  -> initialize random seed
  Rnd(-VbeamPos()*6783)
  -> and finally compute our random value
  ret:=Rnd(max-min)+min
ENDPROC ret

PROC parsefkiss(buf:PTR TO CHAR,mark,lof,bcurobj,dirname)
    DEF m,x,y
    DEF com:PTR TO command
    DEF eol=0
    DEF lol=0
    DEF ce
    DEF cmpstr[100]:STRING
    DEF numb,num[100]:STRING
    DEF soundstr[1000]:STRING

    DEF foundcel[100]:STRING,foundobj
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='parsefikiss()'
#endif

    lol:=findlol(buf,mark)
    m:=mark
    ce:=bcurobj

    IF lol>mark
        REPEAT
            StrCopy(cmpstr,buf+m,80)
->            dbg('Parse: "\s"\n',cmpstr)
            StrCopy(foundcel,'')
            IF stricmp(cmpstr,'initialize',STRLEN)  -> >> INITIALIZE event
                qdbg('Found event initialize()')
                ce:=makeevent(EV_INIT,-1,0)
                m:=findchar(buf,m,")")
            ENDIF
            IF stricmp(cmpstr,'begin',STRLEN)        -> >>  BEGIN event
                qdbg('Found event begin()')
                ce:=makeevent(EV_BEGIN,-1,0)
                m:=findchar(buf,m,")")
            ENDIF
            IF stricmp(cmpstr,'end',STRLEN)          -> >>  END event
                qdbg('Found event end()')
                ce:=makeevent(EV_END,-1,0)
                m:=findchar(buf,m,")")
            ENDIF
            IF stricmp(cmpstr,'alarm(',STRLEN)       -> >>  ALARM event
                MidStr(num,cmpstr,6,20)
                StrToLong(num,{numb})
                ce:=makeevent(EV_ALARM,numb,0)
                m:=findchar(buf,m,")")
            ENDIF
            IF stricmp(cmpstr,'set(',STRLEN)     -> >>  SET event
                MidStr(num,cmpstr,4,20)
                StrToLong(num,{numb})
                ce:=makeevent(EV_SET,numb,0)
                m:=findchar(buf,m,")")
            ENDIF
            -> col(number)
            IF stricmp(cmpstr,'col(',STRLEN)
                MidStr(num,cmpstr,4,20)
                StrToLong(num,{numb})
                ce:=makeevent(EV_COL,numb,0)
                m:=findchar(buf,m,")")
            ENDIF
            IF stricmp(cmpstr,'catch(',STRLEN)       -> >>  CATCH event
                foundobj:=parseparas(buf,m+6,foundcel)
                IF foundobj<>-1
                    ce:=makeevent(EV_CATCH,foundobj,0)
                ELSE
                    ce:=makeevent(EV_CATCH,-1,foundcel)
                ENDIF
                m:=findchar(buf,m,")")
            ENDIF
            IF stricmp(cmpstr,'fixcatch(',STRLEN)        -> >>  FIXCATCH event
                foundobj:=parseparas(buf,m+9,foundcel)
                IF foundobj<>-1
                    ce:=makeevent(EV_FIXCATCH,foundobj,0)
                ELSE
                    ce:=makeevent(EV_FIXCATCH,-1,foundcel)
                ENDIF
                m:=findchar(buf,m,")")
            ENDIF
            IF stricmp(cmpstr,'press(',STRLEN)       -> >>  PRESS event
                foundobj:=parseparas(buf,m+6,foundcel)
                IF foundobj<>-1
                    ce:=makeevent(EV_PRESS,foundobj,0)
                ELSE
                    ce:=makeevent(EV_PRESS,-1,foundcel)
                ENDIF
                m:=findchar(buf,m,")")
            ENDIF
            IF stricmp(cmpstr,'drop(',STRLEN)        -> >>  DROP event
                foundobj:=parseparas(buf,m+5,foundcel)
                IF foundobj<>-1
                    ce:=makeevent(EV_DROP,foundobj,0)
                ELSE
                    ce:=makeevent(EV_DROP,-1,foundcel)
                ENDIF
                m:=findchar(buf,m,")")
            ENDIF
            IF stricmp(cmpstr,'fixdrop(',STRLEN)     -> >>  FIXDROP event
                foundobj:=parseparas(buf,m+5,foundcel)
                IF foundobj<>-1
                    ce:=makeevent(EV_FIXDROP,foundobj,0)
                ELSE
                    ce:=makeevent(EV_FIXDROP,-1,foundcel)
                ENDIF
                m:=findchar(buf,m,")")
            ENDIF
            IF stricmp(cmpstr,'release(',STRLEN)     -> >>  RELEASE event
                foundobj:=parseparas(buf,m+8,foundcel)
                IF foundobj<>-1
                    ce:=makeevent(EV_RELEASE,foundobj,0)
                ELSE
                    ce:=makeevent(EV_RELEASE,-1,foundcel)
                ENDIF
                m:=findchar(buf,m,")")
            ENDIF
            IF stricmp(cmpstr,'unfix(',STRLEN)       -> >>  UNFIX event
                foundobj:=parseparas(buf,m+6,foundcel)
                IF foundobj<>-1
                    ce:=makeevent(EV_UNFIX,foundobj,0)
                ELSE
                    ce:=makeevent(EV_UNFIX,-1,foundcel)
                ENDIF
                m:=findchar(buf,m,")")
            ENDIF
            -> version(set_version_number)
            IF stricmp(cmpstr,'version(',STRLEN)
                MidStr(num,cmpstr,8,20)
                StrToLong(num,{numb})
                ce:=makeevent(EV_VERSION,numb,0)
                m:=findchar(buf,m,")")
            ENDIF
            /*-----------------------------------------------------------*/
            /*                           Commands                        */
            /*-----------------------------------------------------------*/
            IF stricmp(cmpstr,'timer(',STRLEN)       -> >>  TIMER command
                x,y:=parsecoords(buf,m+STRLEN)
                addcommand(ce,CO_TIMER,0,0,x,y)
                m:=findchar(buf,m,")")
            ENDIF
/*
            -> randomtimer(timer,min,max)
            IF stricmp(cmpstr,'randomtimer(',STRLEN)       -> >>  RANDOMTIMER command
                PrintF('\s[STRLEN+8]\n)',cmpstr)
                foundobj:=parseparas(buf,m+STRLEN,foundcel)
                x,y:=parsecoords(buf,m+1)
                PrintF('randomtimer(\d,\d,\d\n)',foundobj,x,y)
                addcommand(ce,CO_RANDOMTIMER,foundobj,NIL,x,y)
                m:=findchar(buf,m,")")
            ENDIF
*/
            IF stricmp(cmpstr,'move(',STRLEN)        -> >>  MOVE command
                foundobj:=parseparas(buf,m+STRLEN,foundcel)
                m:=findchar(buf,m,",")
                x,y:=parsecoords(buf,m+1)
                IF foundobj<>-1
                    addcommand(ce,CO_MOVE,foundobj,0,x,y)
                ELSE
                    addcommand(ce,CO_MOVE,-1,foundcel,x,y)
                ENDIF
                m:=findchar(buf,m,")")
            ENDIF
            IF stricmp(cmpstr,'moveto(',STRLEN)        -> >>  MOVETO command
                foundobj:=parseparas(buf,m+STRLEN,foundcel)
                m:=findchar(buf,m,",")
                x,y:=parsecoords(buf,m+1)
                IF foundobj<>-1
                    addcommand(ce,CO_MOVETO,foundobj,0,x,y)
                ELSE
                    addcommand(ce,CO_MOVETO,-1,foundcel,x,y)
                ENDIF
                m:=findchar(buf,m,")")
            ENDIF

            -> moverandy(#obj,min,max)
            IF stricmp(cmpstr,'moverandx(',STRLEN)
                foundobj:=parseparas(buf,m+STRLEN,foundcel)
                m:=findchar(buf,m,",")
                x,y:=parsecoords(buf,m+1)
                IF foundobj<>-1
->                    dbg('Add moverandx(#\d)\n',foundobj)
->                    dbg('min=\d\n',x)
->                    dbg('max=\d\n',y)
                    addcommand(ce,CO_MOVERANDX,foundobj,NIL,x,y)
                ENDIF
                m:=findchar(buf,m,")")
            ENDIF
            -> moverandy(#obj,min,max)
            IF stricmp(cmpstr,'moverandy(',STRLEN)     -> >>  MOVERANDY command
                foundobj:=parseparas(buf,m+STRLEN,foundcel)
                m:=findchar(buf,m,",")
                x,y:=parsecoords(buf,m+1)
                IF foundobj<>-1
                    addcommand(ce,CO_MOVERANDY,foundobj,NIL,x,y)
                ENDIF
                m:=findchar(buf,m,")")
            ENDIF
            -> movetorand(#obj)
            IF stricmp(cmpstr,'movetorand(',STRLEN)
                foundobj:=parseparas(buf,m+STRLEN,foundcel)
                IF foundobj<>-1
                    addcommand(ce,CO_MOVETORAND,foundobj,NIL)
                ENDIF
                m:=findchar(buf,m,")")
            ENDIF
            IF stricmp(cmpstr,'altmap(',STRLEN)      -> >>  ALTMAP command
                foundobj:=parseparas(buf,m+STRLEN,foundcel)
                IF foundobj<>-1
                    addcommand(ce,CO_ALTMAP,foundobj,0)
                ELSE
                    addcommand(ce,CO_ALTMAP,-1,foundcel)
                ENDIF
                m:=findchar(buf,m,")")
            ENDIF
            IF stricmp(cmpstr,'unmap(',STRLEN)       -> >>  UNMAP command
                foundobj:=parseparas(buf,m+STRLEN,foundcel)
                IF foundobj<>-1
                    addcommand(ce,CO_UNMAP,foundobj,0)
                ELSE
                    addcommand(ce,CO_UNMAP,-1,foundcel)
                ENDIF
                m:=findchar(buf,m,")")
            ENDIF
            IF stricmp(cmpstr,'map(',STRLEN)     -> >>  MAP command
                foundobj:=parseparas(buf,m+STRLEN,foundcel)
                IF foundobj<>-1
                    addcommand(ce,CO_MAP,foundobj,0)
                ELSE
                    addcommand(ce,CO_MAP,-1,foundcel)
                ENDIF
                m:=findchar(buf,m,")")
            ENDIF
            IF stricmp(cmpstr,'sound(',STRLEN)       -> >>  SOUND command
                foundobj:=parseparas(buf,m+STRLEN,foundcel)
                IF foundcel<>-1
                    com:=addcommand(ce,CO_SOUND,-1,foundcel)
                    IF com
                        StrCopy(soundstr,dirname)
                        eaddpart(soundstr,com.cel,990)
                        com.sound:=NewDTObjectA(soundstr,[DTA_GROUPID,GID_SOUND,DTA_SOURCETYPE,DTST_FILE,NIL])
                    ENDIF                   
                ENDIF
                m:=findchar(buf,m,")")
            ENDIF

            -> iffixed(#obj,timer,value)
            IF stricmp(cmpstr,'iffixed(',STRLEN)
                foundobj:=parseparas(buf,m+STRLEN,foundcel)
                m:=findchar(buf,m,",")
                x,y:=parsecoords(buf,m+1)
                IF foundobj<>-1 THEN addcommand(ce,CO_IFFIXED,foundobj,0,x,y)
                m:=findchar(buf,m,")")
            ENDIF
            -> ifnotfixed(#obj,timer,value)
            IF stricmp(cmpstr,'ifnotfixed(',STRLEN)
                foundobj:=parseparas(buf,m+STRLEN,foundcel)
                m:=findchar(buf,m,",")
                x,y:=parsecoords(buf,m+1)
                IF foundobj<>-1 THEN addcommand(ce,CO_IFNOTFIXED,foundobj,0,x,y)
                m:=findchar(buf,m,")")
            ENDIF
            -> ifmapped("cel",timer,value)
            IF stricmp(cmpstr,'ifmapped(',STRLEN)
                foundobj:=parseparas(buf,m+STRLEN,foundcel)
                m:=findchar(buf,m,",")
                x,y:=parsecoords(buf,m+1)
                IF foundcel THEN addcommand(ce,CO_IFMAPPED,-1,foundcel,x,y)
                m:=findchar(buf,m,")")
            ENDIF
            -> ifnotmapped("cel",timer,value)
            IF stricmp(cmpstr,'ifnotmapped(',STRLEN)
                foundobj:=parseparas(buf,m+STRLEN,foundcel)
                m:=findchar(buf,m,",")
                x,y:=parsecoords(buf,m+1)
                IF foundcel THEN addcommand(ce,CO_IFNOTMAPPED,-1,foundcel,x,y)
                m:=findchar(buf,m,")")
            ENDIF
            -> changeset(setnumber)
            IF stricmp(cmpstr,'changeset(',STRLEN)
                x:=parsecoords(buf,m+STRLEN)
                addcommand(ce,CO_CHANGESET,0,0,x)
                m:=findchar(buf,m,")")
            ENDIF
            -> changecol(colnumber)
            IF stricmp(cmpstr,'changecol(',STRLEN)
                x:=parsecoords(buf,m+STRLEN)
                addcommand(ce,CO_CHANGESET,0,0,x)
                m:=findchar(buf,m,")")
            ENDIF
            -> debug("message")
            IF stricmp(cmpstr,'debug(',STRLEN)
                qdbg('Found command debug()')
                foundobj:=parseparas(buf,m+STRLEN,foundcel)
                dbg('Object: \s\n',foundobj)
                dbg('Object: \s\n',foundcel)
                IF foundcel
                    dbg('Add debug("\s")\n',foundcel)
                    addcommand(ce,CO_DEBUG,-1,foundcel)
                ENDIF
                m:=findchar(buf,m,")")
            ENDIF
            -> notify("message")
            IF stricmp(cmpstr,'notify(',STRLEN)
                qdbg('Found command notify()')
                foundobj:=parseparas(buf,m+STRLEN,foundcel)
                IF foundcel
                    dbg('Add notify("\s")\n',foundcel)
                    addcommand(ce,CO_NOTIFY,-1,foundcel)
                ENDIF
                m:=findchar(buf,m,")")
            ENDIF

            -> nop()
            IF stricmp(cmpstr,'nop(',STRLEN)
                addcommand(ce,CO_NOP,-1,NIL)
                m:=findchar(buf,m,")")
            ENDIF
            INC m
        UNTIL ((eol<>0) OR (m>=lof) OR (m>=lol))
    ENDIF
ENDPROC m,ce

PROC parseparas(buf:PTR TO CHAR,mark,str)
    DEF m
    DEF lc
    DEF hey[100]:STRING,hv
    m:=mark
    IF buf[m]=34
        lc:=findchar(buf,m+1,34)
        MidStr(str,buf,m+1,lc-m-1)
        RETURN -1
    ELSE
        IF buf[m]="#"
            lc:=findchar(buf,m+1,"#")
            MidStr(hey,buf,m+1,lc-m-1)
            StrToLong(hey,{hv})
            RETURN hv
        ELSE
            egerr()
        ENDIF
    ENDIF
ENDPROC

PROC parsecoords(buf:PTR TO CHAR,mark)
  DEF x=0,y=0,m,s=0
  DEF st[100]:STRING
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='parsecoords()'
#endif
  m:=mark
  s:=InStr(buf,',',mark)
  IF s>mark
    MidStr(st,buf,mark,s-mark)
    StrToLong(st,{x})
    MidStr(st,buf,s+1)
    StrToLong(st,{y})
  ENDIF
ENDPROC x,y

PROC findchar(buf:PTR TO CHAR,mark,char)
  WHILE (buf[mark]<>char) DO INC mark
ENDPROC mark

PROC makeevent(type,obj,cel)
  DEF ev=0:PTR TO event
  NEW ev
  ev.obj:=obj
  ev.type:=type
  ev.counter:=0
  IF cel
    ev.cel:=String(StrLen(cel))
    StrCopy(ev.cel,cel)
  ENDIF
  newList(ev.commands)
  AddTail(eventlist,ev)
  INC events
ENDPROC ev

PROC addcommand(ev:PTR TO event,type,obj,cel,x=0,y=0)
  DEF co:PTR TO command
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='addcommand()'
#endif
->  dbg('type \d\n',type)
->  dbg('object #\d\n',obj)
->  dbg('cel "\s"\n',cel)
  checkarg(ev)
  NEW co
  co.obj:=obj
  co.type:=type
  co.x:=x
  co.y:=y
  IF cel
    co.cel:=String(StrLen(cel))
->    dbg('co.cel: $\h\n',co.cel)
    StrCopy(co.cel,cel)
->    dbg('Cel: \s\n',co.cel)
  ENDIF
  AddTail(ev.commands,co)
  INC commands
ENDPROC co

PROC findeventtype(type,obj=-1,cel=-1)
  DEF ev:PTR TO event,next
  DEF str1[500]:STRING
  DEF str2[500]:STRING
  ev:=eventlist.head
  REPEAT
    next:=ev.ln.succ
    IF next
      IF ev.type=type
        IF obj=-1
          IF ev.cel>0
            IF cel>0
              StrCopy(str1,ev.cel)
              StrCopy(str2,cel)
              UpperStr(str1)
              UpperStr(str2)
              IF StrCmp(str1,str2)THEN RETURN ev
            ENDIF
          ELSE
            IF cel=-1 THEN RETURN ev
          ENDIF
        ELSE
          IF obj=ev.obj THEN RETURN ev
        ENDIF
      ENDIF
    ENDIF
    ev:=next
  UNTIL next=0
ENDPROC 0

PROC findnamedcel(name)
    DEF i,cel:PTR TO cel
    DEF str1[200]:STRING,str2[200]:STRING
    StrCopy(str1,name,ALL)
    UpperStr(str1)
    FOR i:=MAXCELS TO 0 STEP -1
        cel:=cels[i]
        IF cel
            StrCopy(str2,cel.realname,ALL)
            UpperStr(str2)
            IF StrCmp(str1,str2)
                RETURN i
            ENDIF
        ELSE
            RETURN 0
        ENDIF
    ENDFOR
ENDPROC 0

PROC findlol(buf:PTR TO CHAR,mark)
  DEF m
  m:=mark
  WHILE ((buf[m]<>10) AND (buf[m]<>13) AND (buf[m]<>";")) DO INC m
ENDPROC m

PROC load_palet(dir,fn)
    DEF fh
    DEF buf:PTR TO CHAR
    DEF p,c,r,g,b,loop
    DEF name[500]:STRING
    DEF byte_l,byte_h
    DEF buffer:PTR TO CHAR,lof
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='load_palet()'
#endif
    StrCopy(name,dir)
    AddPart(name,fn,490)
    dbg('file: \s\n',name)
    fh:=Open(name,MODE_OLDFILE)
    IF fh
        StrCopy(palet[palset].name,name)
        lof:=FileLength(name)
        IF lof>0
            IF (buffer:=New(lof))
                Read(fh,buffer,lof)
                buf:=buffer
                IF Long(buffer)="KiSS"
                    IF buf[4]=FILE_MARK_PALET
                        palet[palset].color_num:=buf[9]*256+buf[8]
                        IF (palet[palset].color_num>16)
                            mode:=16
                        ELSE
                            mode:=Bounds(mode+1,1,16)
                        ENDIF
                        palet[palset].palet_num:=buf[11]*256+buf[10]
                        palet[palset].bit_per_pixel:=buf[5]
                    ENDIF
                    buf:=buf+32
                ELSE
                    palet[palset].color_num:=GS1_MAX_COLOR
                    palet[palset].palet_num:=10
                    palet[palset].bit_per_pixel:=12
                    mode:=Bounds(mode+1,1,16)
                ENDIF
                p:=0
                WHILE (p<palet[palset].palet_num)
                    palet[palset].color[p]:=New(12*palet[palset].color_num+50)
                    c:=0
                    WHILE (c<palet[palset].color_num)
                        IF palet[palset].bit_per_pixel=12
                            byte_l:=buf[0]
                            byte_h:=buf[1]
                            buf:=buf+2
                            r:=((byte_l/$10) AND $F)*$1111
                            g:=(byte_h AND $F)*$1111
                            b:=(byte_l AND $F)*$1111
                            r:=(Shl(Shl(r,8),8) OR r)
                            g:=(Shl(Shl(g,8),8) OR g)
                            b:=(Shl(Shl(b,8),8) OR b)
                        ENDIF
                        IF palet[palset].bit_per_pixel=24
                            r:=buf[0]
                            g:=buf[1]
                            b:=buf[2]
                            buf:=buf+3
                            FOR loop:=0 TO 2
                                r:=Shl(r,8) OR r
                                g:=Shl(g,8) OR g
                                b:=Shl(b,8) OR b
                            ENDFOR
                        ENDIF
                        PutLong(palet[palset].color[p]+(12*c),r)
                        PutLong(palet[palset].color[p]+(12*c)+4,g)
                        PutLong(palet[palset].color[p]+(12*c)+8,b)
                        c:=c+1
                    ENDWHILE
                p:=p+1
                ENDWHILE
            ENDIF
        ENDIF
        Close(fh)
    ELSE
        set(g_status,MUIA_Gauge_Current,0)
        set(g_status,MUIA_Gauge_Max,1)
        domethod(g_errorlist,[MUIM_List_InsertSingle,'Missing a .kcf file!',MUIV_List_Insert_Bottom])
        DisplayBeep(0)
    ENDIF
->    qdbg(DBG_DONE)
ENDPROC

PROC parsesetline(buf:PTR TO CHAR,m,lof,cs,co) HANDLE
    DEF xxx,yyy
    DEF oldco
    DEF mmm
    DEF res
    DEF nstr[10]:STRING
    DEF obj:PTR TO obj
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='parsesetline()'
#endif
    oldco:=co
    WHILE ((buf[m]<>13) AND (buf[m]<>10) AND (buf[m+1]<>13) AND (buf[m+1]<>10) AND (buf[m-1]<>13) AND (buf[m-1]<>10) AND (m<lof))
        m:=scan_nonspace(buf,m,lof)
        IF m>=lof THEN Raise(0)
        StrCopy(nstr,'')
        IF buf[m]="*"
            INC m
            INC co
        ELSE
            mmm:=m
            m,res:=scan_value(buf,m,nstr,lof)
            IF m=mmm
                INC m
            ELSE
                IF res=0
                    StrToLong(nstr,{xxx})
                    IF buf[m]=","
                        INC m
                        StrCopy(nstr,'')
                        m,res:=scan_value(buf,m,nstr,lof)
                        IF res=0
                            StrToLong(nstr,{yyy})
                            INC co
                            obj:=objs[co]
                            IF obj
                                obj.setx(cs,xxx)
                                obj.sety(cs,yyy)
                                obj.setux(cs,xxx)
                                obj.setuy(cs,yyy)
                            ENDIF
                        ELSE
                            egerr()
                            Raise(0)
                        ENDIF
                    ELSE
                        egerr()
                        Raise(0)
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
        IF ((buf[m]=13) OR (buf[m]=10)) THEN m:=lof+100
    ENDWHILE
    RETURN co
EXCEPT
    NOP
ENDPROC -1

PROC retdepth(m)
  SELECT m
    CASE 0;RETURN 4
    CASE 1;RETURN 4
    CASE 2;RETURN 5
    CASE 3;RETURN 6
    CASE 4;RETURN 6
    CASE 5;RETURN 7
    CASE 6;RETURN 7
    CASE 7;RETURN 7
    CASE 8;RETURN 7
  ENDSELECT
ENDPROC 8

/*
cbuf:
    LONG    $90909090,$90909090,$90909090,              $00000000,$00000000,$00000000,
                $FFFFFFFF,$FFFFFFFF,$FFFFFFFF,              $40404040,$80808080,$A0A0A0A0,
                $80808080,$80808080,$80808080,              $B0B0B0B0,$B0B0B0B0,$B0B0B0B0,
                $B0B0B0B0,$90909090,$A0A0A0A0,              $FFFFFFFF,$A8A8A8A8,$98989898
*/

PROC busy()
    IF win
        SetWindowPointerA(win,[WA_BUSYPOINTER,TRUE,WA_POINTERDELAY,TRUE,NIL,NIL])
    ENDIF
    set(wi_main,MUIA_Window_Sleep,MUI_TRUE)
    set(wi_prefs,MUIA_Window_Sleep,MUI_TRUE)
    set(wi_edit,MUIA_Window_Sleep,MUI_TRUE)
    set(wi_about,MUIA_Window_Sleep,MUI_TRUE)
ENDPROC
PROC ready()
    IF win
        SetWindowPointerA(win,[WA_BUSYPOINTER,FALSE,WA_POINTERDELAY,FALSE,NIL,NIL])
        handme()
    ENDIF
    set(wi_main,MUIA_Window_Sleep,FALSE)
    set(wi_prefs,MUIA_Window_Sleep,FALSE)
    set(wi_edit,MUIA_Window_Sleep,FALSE)
    set(wi_about,MUIA_Window_Sleep,FALSE)
ENDPROC

PROC reportmousemoves(win:PTR TO window)
  Forbid()
  win.flags:=win.flags OR WFLG_REPORTMOUSE
  Permit()
ENDPROC

PROC noreportmousemoves(win:PTR TO window)
  DEF flag
  Forbid()
  flag:=win.flags
  IF (flag AND WFLG_REPORTMOUSE) THEN flag:=flag-WFLG_REPORTMOUSE
  win.flags:=flag
  Permit()
ENDPROC

PROC handme()
  IF usehand=1
    SetWindowPointerA(win,[WA_POINTER,hand1,WA_POINTERDELAY,FALSE,NIL,NIL])
  ELSE
    ClearPointer(win)
  ENDIF
ENDPROC

PROC grabme()
  IF usehand=1
    SetWindowPointerA(win,[WA_POINTER,hand2,WA_POINTERDELAY,FALSE,NIL,NIL])
  ELSE
    IF usehand=2
      SetWindowPointerA(win,[WA_POINTER,hand3,WA_POINTERDELAY,FALSE,NIL,NIL])
    ELSE
      ClearPointer(win)
    ENDIF
  ENDIF
ENDPROC


/*********************************************************************
***********             **********************************************
***********  I/O Stuff  **********************************************
***********             **********************************************
*********************************************************************/

PROC seekcrlf(buf:PTR TO CHAR,mark,lof)
  WHILE ((buf[mark]<>13) AND (buf[mark]<>10) AND (mark<lof)) DO INC mark
  INC mark
  IF ((buf[mark]=10) OR (buf[mark]=13)) THEN INC mark
ENDPROC mark

PROC scan_value(buf:PTR TO CHAR,m,str,lof)
  DEF result=TRUE
  DEF mm,byte
  DEF dstr[10]:STRING
  StrCopy(dstr,'0',1)
  StrCopy(str,'')
  mm:=m
  byte:=buf[m]
  WHILE ((((byte>="0") AND (byte<="9")) OR (byte="-")) AND (m<lof))
    PutChar(dstr,byte)
    StrAdd(str,dstr,1)
    INC m
    byte:=buf[m]
  ENDWHILE
  IF m<>mm
    mm:=m
    result:=FALSE
  ELSE
    result:=TRUE
  ENDIF
ENDPROC mm,result

PROC scan_nonspace(buf:PTR TO CHAR,m,lof)
  WHILE (((buf[m]=9) OR (buf[m]=" ")) AND (lof>m)) DO INC m
ENDPROC m

PROC scan_string(buf:PTR TO CHAR,m,str,lof)
  DEF dstr[10]:STRING
  StrCopy(dstr,'0',1)
  WHILE ((buf[m]<>9) AND (buf[m]<>" ") AND (buf[m]<>13) AND (buf[m]<>10) AND lof>m)
    PutChar(dstr,buf[m])
    StrAdd(str,dstr,1)
    INC m
  ENDWHILE
ENDPROC m

PROC nofileerr(ss)
  DEF statusstr[500]:STRING
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='nofileerr()'
#endif
  StringF(statusstr,'Bad File/Not Found: "\s"',ss)
  dbg('File error: \s\n',ss)
  domethod(g_errorlist,[MUIM_List_InsertSingle,statusstr,MUIV_List_Insert_Bottom])
ENDPROC

PROC egerr()
  DEF statusstr[500]:STRING
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='egerr()'
#endif
  StringF(statusstr,'?Syntax Error:Line #\d',linenum)
  dbg('Syntax error in line \d\n',linenum)
  domethod(g_errorlist,[MUIM_List_InsertSingle,statusstr,MUIV_List_Insert_Bottom])
ENDPROC

PROC aboutme()
  set(wi_about,MUIA_Window_Open,MUI_TRUE)
ENDPROC

PROC stricmp(str1,str2,len) IS IF Strnicmp(str1,str2,len)=0 THEN TRUE ELSE FALSE

PROC runevent(event,obj:PTR TO obj,cel:PTR TO cel)
  DEF ev=0,res=0
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='runevent()'
#endif
  dbg('event \d\n',event)
  dbg('obj \d\n',IF obj THEN obj.number ELSE -1)
  dbg('cel \s\n',IF cel THEN cel.realname ELSE '""')
  IF obj
    ev:=findeventtype(event,obj.number)
    IF ev
      runcommands(ev)
      res:=TRUE
    ENDIF
  ENDIF
  IF cel
    IF res=FALSE
      ev:=findeventtype(event,-1,cel.realname)
      IF ev
        runcommands(ev)
        res:=TRUE
      ENDIF
    ENDIF
  ENDIF
  IF ((res=FALSE) AND (obj=0) AND (cel=0))
    ev:=findeventtype(event)
    IF ev
      runcommands(ev)
      res:=TRUE
    ENDIF
  ENDIF
ENDPROC res


/*********************************************************************
***********              *********************************************
***********  LIST Stuff  *********************************************
***********              *********************************************
*********************************************************************/

PROC alloccel()
  DEF cel:PTR TO cel
  DEF ordinal
  NEW cel.new()
  IF cel
    ordinal:=findemptycel()
    IF ordinal<>-1
      cels[ordinal]:=cel
    ELSE
      END cel
      cel:=-1
    ENDIF
  ELSE
    cel:=-1
  ENDIF
ENDPROC cel

PROC allocobj(objn)
  DEF obj:PTR TO obj
  NEW obj.new(objn)
  IF obj
    IF objs[objn]
      END obj
      obj:=objs[objn]
    ELSE
      objs[objn]:=obj
    ENDIF
  ELSE
    obj:=-1
  ENDIF
ENDPROC obj

PROC findemptycel()
  DEF i
  FOR i:=MAXCELS TO 0 STEP -1 DO IF cels[i]=0 THEN RETURN i
ENDPROC -1

PROC countcels()
  DEF i,count=0
  FOR i:=MAXCELS TO 0 STEP -1 DO IF cels[i] THEN INC count
ENDPROC count

PROC countobjs()
  DEF i,count=0
  FOR i:=MAXOBJS TO 0 STEP -1 DO IF objs[i] THEN INC count
ENDPROC count

PROC freecels()
  DEF i
  FOR i:=MAXCELS TO 0 STEP -1
    IF cels[i]
      freecel(cels[i])
      cels[i]:=0
    ENDIF
  ENDFOR
ENDPROC

PROC freeobjs()
  DEF i
  FOR i:=MAXOBJS TO 0 STEP -1
    IF objs[i]
      freeobj(objs[i])
      objs[i]:=0
    ENDIF
  ENDFOR
ENDPROC

PROC freecel(cel:PTR TO cel)
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='freecel()'
#endif
->  dbg('cel "\s"\n',cel.realname)
  checkarg(cel)
  END cel
ENDPROC

PROC freeobj(obj:PTR TO obj)
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='freeobj()'
#endif
->  dbg('obj #\d\n',obj.number)
  checkarg(obj)
  END obj
ENDPROC

/*********************************************************************
***********             **********************************************
***********  OOP Stuff  **********************************************
***********             **********************************************
*********************************************************************/


PROC new() OF listnodes IS newList(self.lh)
PROC head() OF listnodes IS self.lh
PROC end() OF listnodes
    DEF node:PTR TO ln
    DEF next=0
    IF isempty(self)=0
        node:=self.lh.head
        WHILE (node)
            next:=node.succ
            IF next
                Remove(node)
                DisposeLink(node.name)
                END node
            ENDIF
            node:=next
        ENDWHILE
    ENDIF
ENDPROC
PROC add(name) OF listnodes
    DEF node:PTR TO ln
    DEF str
    NEW node
    str:=String(StrLen(name))
    StrCopy(str,name)
    node.name:=str
    AddTail(self.lh,node)
ENDPROC node

PROC end() OF obj
ENDPROC

PROC end() OF cel
  IF self.realname THEN DisposeLink(self.realname)
  IF self.comment THEN DisposeLink(self.comment)
  IF self.buf THEN Dispose(self.buf)
  IF self.obuf THEN Dispose(self.buf)
->  IF self.mask THEN Dispose(self.mask)
ENDPROC

PROC realname(name) OF cel
  DEF str
  str:=String(StrLen(name))
  StrCopy(str,name)
  IF self.realname THEN DisposeLink(self.realname)
  self.realname:=str
ENDPROC

PROC comment(name) OF cel
  DEF str
  str:=String(StrLen(name))
  StrCopy(str,name)
  IF self.comment THEN DisposeLink(self.comment)
  self.comment:=str
ENDPROC

PROC setw(x) OF cel;self.w:=x;ENDPROC
PROC seth(x) OF cel;self.h:=x;ENDPROC
PROC setox(x) OF cel;self.ox:=x;ENDPROC
PROC setoy(x) OF cel;self.oy:=x;ENDPROC
PROC setpalette(x) OF cel;self.palet_num:=x;ENDPROC
PROC setset(aset,flag) OF cel;self.sets[aset]:=flag;ENDPROC
PROC setobj(x) OF cel;self.obj:=x;ENDPROC
PROC new() OF cel
    self.mapped:=CMAP_SHOW
ENDPROC
PROC new(x) OF obj; self.number:=x;ENDPROC

PROC setx(aset,x) OF obj
    self.x[aset]:=x
ENDPROC
PROC sety(aset,y) OF obj
    self.y[aset]:=y
ENDPROC
PROC setux(aset,x) OF obj
    self.ux[aset]:=x
ENDPROC
PROC setuy(aset,y) OF obj
    self.uy[aset]:=y
ENDPROC

PROC remember(aset) OF obj
  self.lastx:=self.x[aset]
  self.lasty:=self.y[aset]
  self.rubx:=self.x[aset]
  self.ruby:=self.y[aset]
ENDPROC

PROC undopos() OF obj
  DEF x,y
  x:=self.lastx;y:=self.lasty
  self.remember(curset)
  self.forcemove(x,y,TRUE)
ENDPROC

PROC forcemove(x,y,flag) OF obj
  IF (((self.x[curset]<>x) OR (self.y[curset]<>y)) OR (flag=TRUE))
    IF flag THEN prechange()
    self.movequick(x,y)
    IF flag THEN postchange()
  ENDIF
ENDPROC

PROC move(x,y,flag) OF obj
  DEF nx,ny,dif
  IF (self.fix>0)
    dif:=Bounds(6-self.fix,0,5)
    nx:=Bounds(x,self.rubx-dif,self.rubx+dif)
    ny:=Bounds(y,self.ruby-dif,self.ruby+dif)
  ELSE
    nx:=x;ny:=y
  ENDIF
  self.forcemove(nx,ny,flag)
ENDPROC

PROC movequick(x,y) OF obj
  DEF cel:PTR TO cel
  DEF obj:PTR TO obj
  DEF i
  IF usebounds
    x:=Max(0,Min(x,envw-self.width()))
    y:=Max(0,Min(y,envh-self.height()))
  ENDIF
  FOR i:=MAXCELS TO 0 STEP -1
    cel:=cels[i]
    IF cel
      IF (cel.obj>=0)
        obj:=objs[cel.obj]
        IF (obj)
          IF (obj=self)
            IF cel.mapped<>CMAP_HIDE THEN orcel(cel,obj,TRUE)
          ENDIF
        ENDIF
      ENDIF
    ELSE
      i:=-1
    ENDIF
  ENDFOR
  self.setx(curset,x)
  self.sety(curset,y)
  FOR i:=MAXCELS TO 0 STEP -1
    cel:=cels[i]
    IF cel
      IF (cel.obj>=0)
        obj:=objs[cel.obj]
        IF (obj)
          IF (obj=self)
            IF cel.mapped<>CMAP_HIDE THEN orcel(cel,obj,TRUE)
          ENDIF
        ENDIF
      ENDIF
    ELSE
      i:=-1
    ENDIF
  ENDFOR
ENDPROC

-> calculate object's width
PROC width() OF obj
  DEF w=0,i,cel:PTR TO cel
  FOR i:=MAXCELS TO 0 STEP -1
    cel:=cels[i]
    IF cel
      IF cel.obj=self.number THEN w:=Max(w,cel.ox+cel.w)
    ELSE
      i:=-1
    ENDIF
  ENDFOR
ENDPROC w

-> calculate object's height
PROC height() OF obj
  DEF h=0,i,cel:PTR TO cel
  FOR i:=MAXCELS TO 0 STEP -1
    cel:=cels[i]
    IF cel
      IF cel.obj=self.number THEN h:=Max(h,cel.oy+cel.h)
    ELSE
      i:=-1
    ENDIF
  ENDFOR
ENDPROC h

PROC recolor() OF cel
  DEF y,a=0,w
  w:=(self.w*self.h)
  IF ((usewb<>0) OR (onwb<>0))
    IF self.obuf=0
      self.obuf:=New((self.w*self.h)+64)
      CopyMem(self.buf,self.obuf,(self.w*self.h))
    ENDIF
  ENDIF
  FOR y:=1 TO w
    self.buf[a]:=apens[self.obuf[a]]
    INC a
  ENDFOR
ENDPROC

PROC load(dir) OF cel HANDLE
  DEF name[500]:STRING
  DEF w=-1,h=-1,x,y
  DEF fh=0,filelen
->  DEF fib=0:PTR TO fileinfoblock
  DEF buf=0:PTR TO CHAR
  DEF nbuf=0:PTR TO CHAR
  DEF tbuf=0:PTR TO CHAR
  DEF p1:PTR TO CHAR,p2:PTR TO CHAR,t3
  DEF leftedge=0
->DEF xfib:PTR TO xpkfib
  DEF xbuf=0,xbuflen=0
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='cel.load()'
#endif
->  NEW xfib
  tbuf:=FastNew(10)
  StrCopy(name,dir)
  eaddpart(name,self.realname,490)
  dbg('file: \s\n',name)
  IF self.buf THEN Dispose(self.buf);self.buf:=NIL
  IF self.obuf THEN Dispose(self.obuf);self.obuf:=NIL
->  IF self.mask THEN Dispose(self.mask);self.mask:=NIL
  IF (filelen:=FileLength(name))=NIL THEN Raise("file")
  IF (fh:=Open(name,MODE_OLDFILE))=0 THEN Raise("file")
  -> load cel data to buffer (XPK support)
  IF xpkbase
    Read(fh,tbuf,4)
    Seek(fh,0,OFFSET_BEGINNING)
    IF ((tbuf[0]="X") AND (tbuf[1]="P") AND (tbuf[2]="K"))
      XpkUnpack([XPK_InName,name,XPK_GetOutBuf,{xbuf},XPK_GetOutBufLen,{xbuflen},TAG_END]:LONG)
      IF ((xbuf<>0) AND (xbuflen>0))
        IF (buf:=New(xbuflen+32))
          CopyMem(xbuf,buf,xbuflen)
          filelen:=xbuflen-XPK_MARGIN
        ENDIF
        FreeMem(xbuf,xbuflen)
        IF buf=0 THEN Raise("MEM")
      ELSE
        IF (buf:=New(filelen+32))=0 THEN Raise("MEM")
        Read(fh,buf,filelen)
      ENDIF
    ELSE
      IF (buf:=New(filelen+32))=0 THEN Raise("MEM")
      Read(fh,buf,filelen)
    ENDIF
  ELSE
    IF (buf:=New(filelen+32))=0 THEN Raise("MEM")
    Read(fh,buf,filelen)
  ENDIF

  IF Long(buf)="KiSS"
    IF (buf[4]=FILE_MARK_CELL)
      self.setw(buf[9]*256+buf[8])
      self.seth(buf[11]*256+buf[10])
      self.setox(buf[13]*256+buf[12])
      self.setoy(buf[15]*256+buf[14])
      self.bit_per_pixel:=buf[5]
      nbuf:=buf+32
    ENDIF
  ELSE
    self.setw(buf[1]*256+buf[0])
    self.seth(buf[3]*256+buf[2])
    self.setox(0)
    self.setoy(0)
    self.bit_per_pixel:=4
    w:=self.w
    h:=self.h
    IF ((w/2)<>(w+1/2)) THEN INC w
    w:=w/2
    IF (((w*h)+4)=filelen) THEN nbuf:=buf+4
  ENDIF
  IF nbuf
    IF self.bit_per_pixel=4
      self.w:=((self.w+1)/2)*2
      leftedge:=TRUE
    ENDIF
    w:=self.w
    h:=self.h
    self.buf:=New((w*h)+64)
    IF usewb THEN self.obuf:=New((w*h)+64)
    IF (self.buf)
      IF self.bit_per_pixel=4
        p1:=nbuf
        p2:=self.buf
        t3:=16*self.palet_num
        FOR y:=0 TO self.h-1
          FOR x:=0 TO self.w-1 STEP 2
            p2[0]:=(p1[0] AND $F0/$10)
            IF p2[0]>0 THEN p2[0]:=p2[0]+t3
            p2[1]:=(p1[0] AND $F)
            IF p2[1]>0 THEN p2[1]:=p2[1]+t3
            p1:=p1+1
            p2:=p2+2
          ENDFOR
        ENDFOR
      ELSE
        CopyMem(nbuf,self.buf,w*h)
        IF self.palet_num>0
          p2:=self.buf
          FOR y:=self.buf TO self.buf+(w*h)-1
            IF p2[y]>0
              p2[y]:=(p2[y]+(16*self.palet_num))
            ENDIF
          ENDFOR
        ENDIF
      ENDIF
      IF usewb THEN CopyMem(self.buf,self.obuf,(w*h))
    ELSE
      w:=-1
    ENDIF
  ENDIF
  -> allocate memory for image mask
/*
  self.mask:=New(self.w*self.h)
  IF self.mask=NIL THEN Raise("MEM")
  -> create mask
  FOR x:=0 TO (self.w*self.h)-1
    IF self.buf[x]=0 THEN self.mask[x]:=$FF
  ENDFOR
*/
EXCEPT DO
->  END xfib
  IF tbuf THEN FastDispose(tbuf,10)
  IF buf THEN Dispose(buf)
  IF fh THEN Close(fh)
ENDPROC w,h

PROC setfix(val) OF obj
  IF val=0
    IF self.fix>0
      IF (runevent(EV_UNFIX,self,0)) THEN catchobj:=self
    ENDIF
  ENDIF
  self.fix:=Bounds(val,0,32768)
ENDPROC

PROC countmembers() OF obj
  DEF cel:PTR TO cel,i,mem=0
  FOR i:=MAXCELS TO 0 STEP -1
    cel:=cels[i]
    IF cel
      IF self.number=cel.obj THEN INC mem
    ELSE
      i:=-1
    ENDIF
  ENDFOR
ENDPROC mem

PROC dearc(file,type)
    DEF a=0,l,rxdirname[500]:STRING,rxcommand[1000]:STRING
    DEF stat,result2
    set(g_status,MUIA_Gauge_InfoText,cat.msgStatusUncompressingKissSet.getstr())
    Forbid()
    REPEAT
        INC a
        StringF(rexxname,'PlayFKISS.\d',a)
    UNTIL (FindPort(rexxname)=0)
    rexxport,rexxsigbit:=createPort(rexxname,0)
    rexxsigbit:=Shl(1,rexxsigbit)
    Permit()
    a:=0
    REPEAT
        StringF(rxdirname,'T:pkt\d',a)
        l:=CreateDir(rxdirname)
        INC a
    UNTIL l
    UnLock(l)
    IF type=0
        StringF(rxcommand,'"ADDRESS COMMAND ''lha e -m \s >NIL: <NIL: \s/''"',file,rxdirname)
    ELSE
        StringF(rxcommand,'"ADDRESS COMMAND ''lzx x -m "\s" >NIL: <NIL: \s/''"',file,rxdirname)
    ENDIF
    sendRexxMsg('REXX',rxcommand,0,RXFB_STRING,rexxport,rexxname,0)
    a:=0
    WHILE (unconfirmed>0) AND (a<100)
        REPEAT
            rexxhand,stat,result2:=handleRexxMsg(rexxport)
            IF (rexxhand)
                replyRexxMsg(rexxhand)
                IF unconfirmed=0 THEN a:=100
            ENDIF
            Delay(25)
            INC a
            IF stat=RXTYPE_REPLY
                IF (rexxhand) THEN rexxerror(rexxhand,result2)
            ENDIF
            l:=(a AND %11)
            SELECT l
            CASE 0;set(g_status,MUIA_Gauge_InfoText,'Uncompressing Kiss set... |')
            CASE 1;set(g_status,MUIA_Gauge_InfoText,'Uncompressing Kiss set... /')
            CASE 2;set(g_status,MUIA_Gauge_InfoText,'Uncompressing Kiss set... -')
            CASE 3;set(g_status,MUIA_Gauge_InfoText,'Uncompressing Kiss set... \\')
            ENDSELECT
        UNTIL ((stat=RXTYPE_NOMSG) OR (a>100))
    ENDWHILE
    IF unconfirmed>0 THEN reporterror('REXX command failed!',"MISC")
    StrCopy(oldafile,afname)
    StrCopy(afname,rxdirname)
    discovercnffile(afname)
    deletePort(rexxport)
ENDPROC

-> find cnf files inside given directory and select one
PROC discovercnffile(dir)
  DEF dl:PTR TO dirlist,i,files[256]:STRING
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='discovercnffile()'
#endif
  dbg('Dir: \s\n',dir)
  -> scan directory
  NEW dl.dirlist()
  dl.setattrs([DIRTAG_COMPLETEPATH,FALSE,NIL])
  dl.setdir(dir)
  dl.read(FALSE,TRUE,'#?.cnf')
  -> if there are no cnf files inside the archive
  IF dl.empty()
    qdbg('No CNF file found!')
    reporterror(cat.msgErrorNoCNFFiles.getstr(),ERR_NOCNFFILE)
    RETURN
  -> there's only one cnf file
  ELSEIF dl.numitems()=1
    dl.first()
    eaddpart(afname,dl.obj(),490)
    dbg('One file found: \s\n',dl.obj())
  -> there're multiple cnf files
  ELSE
    -> sort list
    dl.sort()
    dl.first()
    FOR i:=1 TO dl.numitems()
      dbg('File "\s"\n',dl.obj())
      StrAdd(files,dl.obj())
      IF dl.succ() THEN StrAdd(files,'|',1)
    ENDFOR
    i:=EasyRequestArgs(win,[20,0,cat.msgRequestTitleSelectCNFFile.getstr(),cat.msgRequestMultipleCNFFiles.getstr(),files],0,0)
    dbg('selected: \d\n',i)
    -> the rightmost gadget has always number 0
    IF i=0 THEN i:=dl.numitems()
    -> set position on selected item
    dl.item(i-1)
    eaddpart(afname,dl.obj(),490)
    dbg('result: \s\n',dl.obj())
  ENDIF
  END dl
ENDPROC

PROC rexxerror(level,errnum)
    DEF body[4000]:STRING
    DEF errptr:PTR TO nexxstr

    /* ErrorMsg() is not documented (becuase it returns a code in A0 ??) */
    MOVE.L  rexxsysbase,A6
    MOVE.L  errnum,D0
    JSR         -96(A6)     /* ErrorMsg() */
    MOVE.L  A0,errptr

    StringF(body,'An AREXX error occured while dearcing.\n\nError Level: \d\nError \d: \s',level,errnum,errptr.buff)
    reporterror(body,"AREX")
ENDPROC

-> Delete temporary directory
PROC cleanuparc()
  DEF d[256]:STRING,f[256]:STRING
  DEF dl:PTR TO dirlist
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='cleanuparc()'
#endif
  splitname(afname,d,f)
  dbg('Dir: \s\n',d)
  dbg('File: \s\n',f)
  IF StrLen(d)=0 THEN RETURN
  -> scan directory
  NEW dl.dirlist()
  dl.setattrs([DIRTAG_COMPLETEPATH,TRUE,NIL])
  dl.setdir(d)
  dl.read(FALSE,TRUE)
  dl.first()
  -> delete files
  set(g_status,MUIA_Gauge_InfoText,cat.msgStatusDeletingTemporaryFiles.getstr())
  REPEAT
    dbg('delete "\s"\n',dl.obj())
    DeleteFile(dl.obj())
  UNTIL dl.succ()=FALSE
  END dl
  -> delete temporary directory
  dbg('delete "\s"\n',d)
  DeleteFile(d)
  -> restore paths
  splitname(oldafile,ofilename,f)
  StrCopy(afname,oldafile)
  dbg('ofilename "\s"\n',ofilename)
  dbg('afname "\s"\n',afname)
ENDPROC

PROC setn(obj,val)
  DEF num[50]:STRING
#ifdef DEBUG
  DEF dbgprocname
  dbgprocname:='setn()'
#endif
  checkarg(obj)
  StringF(num,'\d',val)
  set(obj,MUIA_Text_Contents,num)
ENDPROC

PROC handlemui(muiresult)
    DEF a
    SELECT muiresult
        CASE ID_ABOUT;aboutme()
        CASE ID_FILE;getfile()
        CASE ID_RESETPOS;resetcur()
        CASE ID_EFIX
            get(g_efix,MUIA_String_Integer,{a})
            a:=Bounds(a,0,32768)
            set(g_efix,MUIA_String_Integer,a)
            setslidefix(a)
        CASE ID_UNDOPOS;undo()
        CASE ID_ESTORE;storefixcur()
        CASE ID_ERESETFIX;refixcur()
        CASE ID_EUNFIX;unfixcur()
        CASE ID_EMAXFIX;maxfixcur()
        CASE ID_ECSET
            get(g_ecset,MUIA_Numeric_Value,{a})
            changecolorpal(a)
        CASE ID_ECOFFX
            get(g_ecoffx,MUIA_Numeric_Value,{a})
            IF ((lastcel<>0) AND (lastobj<>0))
                prechange()
                orcel(lastcel,lastobj)
                lastcel.setox(a)
                orcel(lastcel,lastobj)
                postchange()
            ENDIF
        CASE ID_ECOFFY
            get(g_ecoffy,MUIA_Numeric_Value,{a})
            IF ((lastcel<>0) AND (lastobj<>0))
                prechange()
                orcel(lastcel,lastobj)
                lastcel.setoy(a)
                orcel(lastcel,lastobj)
                postchange()
            ENDIF
        CASE ID_EBACK;moveback()
        CASE ID_EFORWARD;moveforward()
        CASE ID_EHIDE;hidecel()
        CASE ID_POPEN;prefs()
        CASE ID_PMODE;getsmr();getscreenname()
        CASE ID_PSPEED
            get(g_pspeed,MUIA_Numeric_Value,{tanimspeed})
            tanimspeed:=tanimspeed*10
        CASE ID_PENFORCE;get(g_penforce,MUIA_Selected,{tusebounds})
        CASE ID_PFOLLOW;get(g_pfollow,MUIA_Selected,{tusefollow})
        CASE ID_PELASTIC;get(g_pelastic,MUIA_Selected,{tusesnap})
        CASE ID_PWORKBENCH;get(g_pworkbench,MUIA_Selected,{tusewb})
        CASE ID_PCYBER;get(g_pcyber,MUIA_Selected,{tusenasty})
        CASE ID_PUPDATE;get(g_pupdate,MUIA_Cycle_Active,{tuseregions})
        CASE ID_PPOINTER;get(g_ppointer,MUIA_Cycle_Active,{tusehand})

->      CASE ID_P;get(g_p,MUIA_Selected,{})
        CASE ID_REVEAL
            get(g_reveallist,MUIA_List_Active,{a})
            revealordinal(a)
        CASE ID_PUSE
            modeid:=tmodeid
            screenos:=tscreenos
            screenas:=tscreenas
            animspeed:=tanimspeed
            usebounds:=tusebounds
            usehand:=tusehand
            useregions:=tuseregions
            usefollow:=tusefollow
            usesnap:=tusesnap
            usenasty:=tusenasty
            usewb:=tusewb
            saveprefs('ENV:PlayFKISS.prefs')
            set(wi_prefs,MUIA_Window_Open,FALSE)
        CASE ID_PSAVE
            modeid:=tmodeid
            screenos:=tscreenos
            screenas:=tscreenas
            animspeed:=tanimspeed
            usebounds:=tusebounds
            usehand:=tusehand
            useregions:=tuseregions
            usefollow:=tusefollow
            usesnap:=tusesnap
            usenasty:=tusenasty
            usewb:=tusewb
            saveprefs('ENV:PlayFKISS.prefs')
            saveprefs('ENVARC:PlayFKISS.prefs')
            set(wi_prefs,MUIA_Window_Open,FALSE)
    ENDSELECT
ENDPROC muiresult

PROC changecolorpal(np)
  DEF x,y,p1:PTR TO CHAR
  IF lastcel=NIL THEN RETURN
  IF np<>lastcel.palet_num
    IF lastcel.bit_per_pixel=4
      IF onwb THEN lastcel.recolor()  -> guarantees a obuf
      p1:=lastcel.buf
      IF onwb THEN p1:=lastcel.obuf
      IF p1
        FOR y:=0 TO lastcel.h-1
          FOR x:=0 TO lastcel.w-1 DO IF p1[x]>0 THEN p1[x]:=((p1[x] AND $F)+(16*np))
          p1:=p1+lastcel.w
        ENDFOR
      ENDIF
      lastcel.palet_num:=np
      IF onwb THEN lastcel.recolor()
      prechange()
      orcel(lastcel,lastobj)
      postchange()
    ENDIF
  ENDIF
ENDPROC

programabouttext:
CHAR '\ec',PROGRAMNAME,'\n'
CHAR 'Version ',PROGRAMVERSION,' (',PROGRAMDATE,')\n\n'
CHAR 'Originally written by Chad Randall (crandall@msen.com).\nNow developed by Michal Durys (misha@femina.com.pl).\n\nVisit support site at:\nhttp://www.femina.com.pl/kiss/\n\nThis is an International Kiss Guild program.\n\nPUBLIC DOMAIN\nDistribute Freely',0

/*
txt_option_on:
CHAR 'Y',0
txt_option_off:
CHAR 'N',0
*/
