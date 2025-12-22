/*****************************************************/
/**** 3D_Core World Editor Version 1.20  24/14/97 ****/
/****  Copyright (c) Jonathan Gregory 1995-1997   ****/
/*****************************************************/

/* NOTE - Version info set in initialise() */

OPT PREPROCESS                      /* Allow use of macros */
OPT LARGE

/****************/
/*** Includes ***/
/****************/

MODULE   'tools/EasyGUI_Orig',      /* Setup Modules to include */
         'tools/constructors',
         'graphics/view',
         'graphics/text',
         'graphics/rastport',
         'intuition/intuition',
         'intuition/screens',
         'intuition/gadgetclass',
         'utility/tagitem',
         'diskfont',
         'dos',
         'dos/dos',
         'exec/ports',
         'exec/lists',
         'exec/nodes',
         'exec/memory',
         'gadtools',
         'libraries/gadtools',
         'asl',
         'libraries/asl'

/*****************/
/*** Constants ***/
/*****************/

CONST DEFSCRMODE  =  V_HIRES OR V_LACE
CONST MAPWINIDCMP =  IDCMP_GADGETDOWN OR IDCMP_GADGETUP OR IDCMP_INTUITICKS OR IDCMP_MOUSEBUTTONS OR IDCMP_MENUPICK
CONST DRAGIDCMP   =  IDCMP_INTUITICKS OR IDCMP_MOUSEBUTTONS
CONST MAPWINSIZE  =  400
CONST VSCRLID     =  2000
CONST HSCRLID     =  2001
CONST NULGADID    =  2999
CONST OBDFCOUNT   =  10                              /* Max No. of ObjDef's in LineDef */


CONST MAXCOORD    =  32768                           /* Must not be > than 16 bit !!   */
CONST MAXZOOM     =  100
CONST MINZOOM     =  1
CONST MAXALT      =  20000
CONST MINALT      = -20000
CONST MAXHEAD     =  1023
CONST MINHEAD     =  0
CONST MAXSIZE     =  32767
CONST MINSIZE     =  1
CONST MAXCRAD     =  32767
CONST MINCRAD     =  0
CONST MINOBID     =  $FFFFFFFF
CONST MAXOBID     =  $7FFFFFFF

CONST MINWID      =  1
CONST MAXWID      =  10000
CONST MINDEP      =  1
CONST MAXDEP      =  10000
CONST MINFLR      = -10000
CONST MAXFLR      =  10000
CONST MINCEIL     = -10000
CONST MAXCEIL     =  10000

CONST OBJDEFMAGIC = $4F424446                      /* Magic Disk File ID's             */
CONST WOBJMAGIC   = $574F424A
CONST LINDEFMAGIC = $4C4E4446

ENUM GREY,BLACK,WHITE,BLUE,RED,GREEN,BLUE,ORANGE   /* Enumerate Colours                */ 

ENUM WE_MODE_ADD,WE_MODE_DEL,WE_MODE_EDIT          /* Enumerate WorldEd Modes          */

ENUM WE_TYPE_OBJ,WE_TYPE_COL                       /* Enumerate WorldEd Edit Types     */

ENUM  MNUNEW=100, MNUOPEN, MNUSAVE, MNUABOUT, MNULNOPEN, MNULNSTAT
CONST MNUSTART= 100
CONST MNUEND  = 150

CONST ASLWIDTH=320, ASLHEIGHT=400, ASLLEFTEDGE=20, ASLTOPEDGE=20, PATHLEN=120

/*********************/
/*** Define Macros ***/
/*********************/

#define UNSIGNED(x) (x AND $FFFF)

/*****************************/
/*** Structure Definitions ***/
/*****************************/

/* Note the following structure is a generic disk file header */

OBJECT header                       /*** WObject Disk File Header ***/
  magic,                            /*     File Magic ID Number     */
  wobcount,                         /*      File WObject Count      */
  colcount                          /*      File ColArea Count      */
ENDOBJECT

OBJECT obdfheader                   /*** ObjDef File Header Info ***/
  magic,                            /*     File Magic ID Number    */
  count                             /*  Number of ObjDefs in File  */
ENDOBJECT

OBJECT objdef                       /***   Base Object Definition    ***/
  id,                               /*   Object Definition ID Number   */
  name[16]:ARRAY OF CHAR,           /*   Object Definition Name 15+1   */
  size:INT,                         /*    Basic Object Size (Scale)    */
  frames:INT,                       /*      Number of anim frames      */
  views:INT,                        /*     Number of Views 1/8/16      */
  fdelay:INT,                       /*  Anim Frame Delay in V-Blanks   */
  flags,                            /*     Object definition Flags     */
  imgid[32]:ARRAY OF LONG           /*     Chunky Image ID's Array     */
ENDOBJECT

OBJECT wobject                      /***   World Object Definition   ***/
  x,y,                              /*   Object World X and Y Coords   */
  height,                           /* Objects Height Within the World */
  heading,                          /*  Heading 0-359 Degrees (UWORD)  */
  size,                             /* Object Size For Scaling (UWORD) */
  radius,                           /* Objects Collsion Radius (UWORD) */
  speed,                            /* Current Speed of Object (UWORD) */
  obid,                             /* Object Type/ID (LONG)           */
  objdef[4]:ARRAY OF LONG           /* Array of Object Definition ID's */
ENDOBJECT

OBJECT status                       /***     Interface Status Structure     ***/
  mode,                             /*          Current editing mode          */
  edtype,                           /*       Current Type Being Edited        */
  zoom,                             /*       Current zoom setting 1-100       */
  x,y,                              /*  Current Map Top Left Co-ord Settings  */
  wx,wy,                            /*  Current Object World Co-ord Settings  */
  wid,dep,flr,ceil,                 /*    Current Collision Zone Settings     */
  alt,head,size,crad,               /* Current Alt,Head,Size,Radius Settings  */
  obid,pass                         /* Current Object ID & Passable Settings  */
  actscroll:PTR TO gadget,          /* Pointer to active (down) scroll gadget */
  mcyc,                             /* Edit mode cycle gadget E-list pointer  */
  tcyc,                             /* Edit type cycle gadget E-list pointer  */
  zint,                             /*   Zoom integer gadget E-list pointer   */
  zsld,                             /*   Zoom slide gadget E-List pointer     */
  mxint,myint,                      /* Map X,Y Co-ord gadget E-List Pointers  */
  wxint,wyint,                      /* Obj X,Y Co-ord gadget E-List Pointers  */
  widint,depint,flrint,ceilint,     /*  Collison zone gadget E-List Pointers  */
  altint,headint,sizeint,           /* Misc Object Related Gadget E-List Ptrs */
  cradint,obidint,passchk           /* Misc Object Related Gadget E-List Ptrs */
  obdfstr[4]:ARRAY OF LONG,         /*    Pointer to ObjDef Gadget E-Lists    */
  obdfbut[4]:ARRAY OF LONG,         /*  Ptr to ObjDef Button Gadget E-Lists   */
  obdfid[4]:ARRAY OF LONG,          /*       Current Select ObjDef ID's       */
  defcount,defptr:PTR TO objdef,    /* Number of ObjDefs & Array base pointer */
  deflist:PTR TO lh,                /* Pointer to Def's List Header (execlst) */
  woblist:PTR TO lh,                /* Pointer to wobject List Header (exec)  */
  linelist:PTR TO lh,               /* Pointer to linedef List Header (exec)  */
  collist:PTR TO lh,                /* Pointer to colarea List Header (exec)  */
  actwobj:PTR TO wobject,           /*        Pointer to active wobject       */
  actcol:PTR TO colarea,            /*        Pointer to active colarea       */
  mouse,                            /*   Current mouse select button status   */
  mousesx,mousesy,                  /* Start Co-ords of Down-Drag-Release Op  */
  mouseex,mouseey,                  /*  End Co-ords of Down-Drag-Release Op   */
  mousecount                        /*   Mouse drag draw op's counter/flag    */
ENDOBJECT

OBJECT defitem                      /*** Exec List Version of ObjDef Array  ***/
  node:ln,                          /*             Exec list node             */
  id,                               /*          Object Definition ID          */
  name[16]:ARRAY OF CHAR            /*     Object Definition Name String      */
ENDOBJECT

OBJECT wobitem                      /*** Exec List Version of WObject data  ***/
  node:ln,                          /*             Exec list node             */
  wob:wobject,                      /*         World Object Structure         */
  select                            /*     Internal group selection data      */
ENDOBJECT

/*
OBJECT linedef                      /***   Basic Line Drawing  Definition   ***/
  name[16]:ARRAY OF CHAR,           /*        Name of line Definition         */
  spacing,                          /*   Spacing between succesive objects    */
  height,                           /*    Object Height Within the World      */
  heading,                          /*         Heading 0-359 Degrees          */
  size,                             /*        Object Size For Scaling         */
  radius,                           /*        Object Collision Radius         */
  id,                               /*   Type/ID of LineDef derived Objects   */
  objdef[16]:ARRAY OF LONG          /*    Array of Object Definition ID's     */
ENDOBJECT

OBJECT lineitem                     /***   Exec List Version of Line Def.   ***/
  node:ln,                          /*             Exec list node             */ 
  ldf:linedef                       /*       Line Definition Structure        */
ENDOBJECT
*/

OBJECT colarea                      /***   Basic Collision Area Structure   ***/
  x,y,                              /*        Co-ords of Collision Box        */
  width,depth,                      /*      Width/Depth of Collision Box      */
  floor,ceil,                       /*     Floor/Ceiling of Collision Box     */
  id                                /*  ID Number Allocated to Collision Box  */
ENDOBJECT

OBJECT colitem                      /*** Exec List Version of Collision Box ***/
  node:ln                           /*             Exec List Node             */
  col:colarea,                      /*        Actual colarea Structure        */
  select                            /*        Extended Selection Info         */
ENDOBJECT

OBJECT guiwork                      /***  Structure for GUI info transfer   ***/
  str:PTR TO CHAR,
  val
ENDOBJECT

OBJECT screenmode                   /***  Screen mode from selectscreen()   ***/
  mode,                             /*             Screen mode ID             */
  width,                            /*         Screen width selected          */
  height,                           /*         Screen height selected         */
  depth,                            /*         Screen depth selected          */
  minwidth,                         /*         Minimum width allowable        */
  minheight,                        /*         Minimum height allowable       */
  mindepth,                         /*         Minimum depth allowable        */
  gads                              /* True if Width,Height & Depth gads req. */
ENDOBJECT

OBJECT linedef                     /*** Line Def File Structure ***/
  magic,                            /*     File Magic ID Number    */
  space,                            /*      Object Seperation      */
  obdfid[OBDFCOUNT]:ARRAY OF LONG   /*     Array of ObjDef ID's    */
ENDOBJECT

/*******************/
/*** Global Data ***/
/*******************/

DEF stitle,abouttitle

DEF diskfontbase=NIL                 /* diskfont.library base pointer  */

DEF scrn=NIL:PTR TO screen           /* Screen pointer                 */
DEF visinfo=NIL                      /* Pointer to Visual Info         */
DEF fontattr=NIL:PTR TO textattr     /* Pointer to fontattr            */
DEF font=NIL                         /* Pointer to font                */
DEF filereq=NIL:PTR TO filerequester /* Pointer to FileRequester       */
DEF linereq=NIL:PTR TO filerequester /* Pointer to Line FileRequester  */
DEF linedef=NIL:PTR TO linedef       /* Currently Loaded LineDef Ptr   */

DEF bdwin=NIL:PTR TO window          /* Pointer to backdrop window     */
DEF mapwin=NIL:PTR TO window         /* Pointer to map window          */
DEF mapsig=NIL                       /* Map Window Port Signal Mask    */
DEF congh=NIL:PTR TO guihandle       /* GUI Handle for control window  */
DEF menustrip=NIL                    /* Pointer to menustrip           */

DEF vscrl=NIL:PTR TO gadget          /* Pointer Vertical Scroller      */
DEF vimg =NIL:PTR TO image           /* Vert scroller image            */
DEF vinfo=NIL:PTR TO propinfo        /* Vert scroller propinfo         */
                                     
DEF hscrl=NIL:PTR TO gadget          /* Pointer to Horizontal Scroller */
DEF himg =NIL:PTR TO image           /* Horiz scroller image           */
DEF hinfo=NIL:PTR TO propinfo        /* Horiz scroller propinfo        */

DEF nulinfo=NIL:PTR TO boolinfo      /* Null gadget stuff !!!!!!       */
DEF nulgad =NIL:PTR TO gadget

DEF stat=NIL:PTR TO status           /* Pointer to interface status    */

DEF s0[15]:STRING,s1[15]:STRING      /* Current contents of string gadgets */
DEF s2[15]:STRING,s3[15]:STRING      /* Updated Automativally by Gadgets   */

DEF os0[15]:STRING,os1[15]:STRING    /* What should be in string gadgets   */
DEF os2[15]:STRING,os3[15]:STRING    /* used to reset after manual change  */

DEF tantab[89]:ARRAY OF LONG         /* Tangents Table Space */

/*******************/
/**** Main line ****/
/*******************/

PROC main() HANDLE
   DEF ret

   ret:=initialise()
   IF ret=0 THEN waitevent()

EXCEPT DO
   cleanup()
   ReThrow()
ENDPROC

/********************/
/**** Initialise ****/
/********************/

/* Returns 0 on success, otherwise 1 */

PROC initialise()
  DEF ret

  stitle:='World Editor v1.12'                           /*** Set Version Strings  ***/

  abouttitle:='        3DCore - World Editor   \n'+
              '          v1.12  24/04/1997     \n'+
              'Copyright (c) Jonathan Gregory 1995-97'

  diskfontbase:=OpenLibrary('diskfont.library',37)       /* Open any required Libs   */
  IF diskfontbase=NIL                                    /* Report if failed to open */
    WriteF('Requires diskfont.library v37 or higher\n')
    RETURN 1
  ENDIF

  gadtoolsbase:=OpenLibrary('gadtools.library',0)        /* Open Gadtools Library    */
  IF gadtoolsbase=NIL                                    /* Report if failed to open */
    WriteF('Failed to open GadTools library\n')
    RETURN 1
  ENDIF

  aslbase:=OpenLibrary('asl.library',37)
  IF aslbase=NIL
    WriteF('Requires Asl.Library v37 or higher\n')
    RETURN 1
  ENDIF

  ret:=buildscreen()                                     /* Build Screen & Setup Windows    */
  IF ret=0 THEN ret:=loadobjdefs(1)                      /* Load ObjDefs & Conv to ExecList */
  IF ret=0 THEN ret:=initmisc()                          /* Init Misc resources             */
  IF ret=0
    stat.woblist :=newlist()                             /* Allocate new list headers       */
    stat.linelist:=newlist()
    stat.collist :=newlist()
    stat.actwobj :=NIL
    stat.actcol  :=NIL
  ENDIF
ENDPROC ret

/***************************************/
/**** Display Screen Mode Requester ****/
/***************************************/

PROC selectscreen(sm:PTR TO screenmode)
  DEF smr:PTR TO screenmoderequester
  DEF res=0

  smr:=AllocAslRequest(ASL_SCREENMODEREQUEST,
                      [ASL_HAIL,                   'The Screen Mode requester',
                       ASL_HEIGHT,                 ASLHEIGHT,
                       ASL_WIDTH,                  ASLWIDTH,
                       ASL_LEFTEDGE,               ASLLEFTEDGE,
                       ASL_TOPEDGE,                ASLTOPEDGE,
                       ASL_OKTEXT,                 'Okay',
                       ASL_CANCELTEXT,             'Cancel',
                       ASLSM_INITIALDISPLAYID,     sm.mode,
                       ASLSM_INITIALDISPLAYWIDTH,  sm.width,
                       ASLSM_INITIALDISPLAYHEIGHT, sm.height,
                       ASLSM_INITIALDISPLAYDEPTH,  sm.depth,
                       ASLSM_MINWIDTH,             sm.minwidth,
                       ASLSM_MINHEIGHT,            sm.minheight,
                       ASLSM_MINDEPTH,             sm.mindepth,
                       ASLSM_DOWIDTH,              sm.gads,
                       ASLSM_DOHEIGHT,             sm.gads,
                       ASLSM_DODEPTH,              sm.gads,
                       NIL])

  IF smr 
    res:=AslRequest(smr, NIL)
    IF res
       sm.mode  :=smr.displayid
       sm.width :=smr.displaywidth
       sm.height:=smr.displayheight
       sm.depth :=smr.displaydepth
    ENDIF
    FreeAslRequest(smr)
  ENDIF

ENDPROC res

/**********************************/
/**** Load & Save screen prefs ****/
/**********************************/

PROC loadscreenprefs(sm)
  DEF handle

  handle:=Open('ENVARC:WorldED_Screen.prefs',OLDFILE)
  IF handle
    Read(handle,sm,SIZEOF screenmode)
    Close(handle)
  ENDIF
ENDPROC

PROC savescreenprefs(sm)
  DEF handle

  handle:=Open('ENVARC:WorldED_Screen.prefs',NEWFILE)
  IF handle
    Write(handle,sm,SIZEOF screenmode)
    Close(handle)
  ENDIF
ENDPROC

/******************************/
/**** Build Screen Display ****/
/******************************/

/* Returns 0 on success, otherwise 1 */

PROC buildscreen()
  DEF mwtitle,top,tags[40]:ARRAY OF LONG
  DEF mcyc,tcyc,zint,zsld,mxint,myint,wxint,wyint,menus
  DEF widint,depint,flrint,ceilint
  DEF obdf0,obdf1,obdf2,obdf3,obdfb0,obdfb1,obdfb2,obdfb3
  DEF alt,head,size,crad,obid,pass
  DEF sm:PTR TO screenmode,win:PTR TO window,res

  stat:=NEW [0,1,0,0,0,0,0,0,512]:status            /* Intialise program status structure */

  fontattr:=['Courier.font',13,0,0]:textattr                        /* Setup font attribs */
  font:=OpenDiskFont(fontattr)                                      /* Open disk font     */
  IF font=0                                                         /* If failed report   */
     WriteF('Could not open \s !!\n',fontattr.name)
     RETURN 1
  ENDIF

  sm:=NEW [DEFSCRMODE,640,480,3,640,480,3,TRUE]:screenmode          /* Allocate screenmode */
  loadscreenprefs(sm)
  res:=selectscreen(sm)                                             /* Put up requester    */
  IF res=NIL THEN RETURN 1                                          /* If cancel exit      */
  savescreenprefs(sm)

  tags:=[SA_WIDTH,sm.width,    SA_HEIGHT,sm.height,                 /* Setup Screen Tags   */
         SA_DEPTH,sm.depth,    SA_PENS,[-1],
         SA_DISPLAYID,sm.mode, SA_TITLE,stitle,
         SA_FONT, fontattr,
         TAG_END,NIL]

  scrn:=OpenScreenTagList(NIL,tags)                                 /* Open Screen         */
  IF scrn=0                                                         /* If failed - report  */
     WriteF('Could not open screen !!\n')
     RETURN 1
  ENDIF

  SetColour(scrn,RED   ,255,0,0)                                    /* Set Pen 4 to Red    */
  SetColour(scrn,GREEN ,0,255,0)                                    /* Set Pen 5 to Green  */
  SetColour(scrn,BLUE  ,0,0,255)                                    /* Set Pen 6 to Blue   */
  SetColour(scrn,ORANGE,255,128,0)                                  /* Set Pen 7 to Orange */

  top:=scrn.barheight+1
  tags:=[WA_LEFT,0, WA_TOP,(scrn.barheight)+2,              /* Setup Backdrop Window Tags  */
        WA_CUSTOMSCREEN,scrn, WA_SMARTREFRESH,TRUE,
        WA_WIDTH,sm.width, WA_HEIGHT,sm.height-top,
        WA_BACKDROP,TRUE, WA_BORDERLESS,TRUE,
        TAG_END,NIL]
  bdwin:=OpenWindowTagList(NIL,tags)

  IF bdwin=NIL                                                       /* If failed - report */
     WriteF('Could not open backdrop window !!\n')
     RETURN 1
  ENDIF
  drawbackdropwin()                                                       /* Draw backdrop */

  FastDisposeList(sm)                                               /* Dispose screenmode  */

  top:=scrn.wbortop+scrn.font.ysize+2                                 /* Calc top position */
  NEW vimg,himg                                                       /* Initialise Images */

  vinfo:=NEW [PROPNEWLOOK OR AUTOKNOB OR FREEVERT,                    /* Build Scrollers   */
              0,0,-1,MAXBODY]:propinfo

  hinfo:=NEW [PROPNEWLOOK OR AUTOKNOB OR FREEHORIZ,
              0,0,MAXBODY,-1]:propinfo

  vscrl:=NEW [NIL,-10,top,8,-top-13,                           /* Next,x,y,w,h             */
    GFLG_RELRIGHT OR GFLG_RELHEIGHT,                           /* Gadget flags             */
    GACT_RELVERIFY OR GACT_IMMEDIATE OR GACT_RIGHTBORDER,      /* Activation flags         */
    GTYP_PROPGADGET OR GTYP_GZZGADGET,                         /* Gadget type (prop)       */
    vimg,NIL,NIL,NIL,                                          /* Render x 2, text & RFU   */
    vinfo,VSCRLID]:gadget                                      /* Propinfo, ID & User Data */

  hscrl:=NEW [vscrl,3,-10,-16,8,                               /* Next,x,y,w,h             */
    GFLG_RELBOTTOM OR GFLG_RELWIDTH,                           /* Gadget flags             */
    GACT_RELVERIFY OR GACT_IMMEDIATE OR GACT_BOTTOMBORDER,     /* Activation flags         */
    GTYP_PROPGADGET OR GTYP_GZZGADGET,                         /* Gadget type (prop)       */
    himg,NIL,NIL,NIL,                                          /* Render x 2, text & RFU   */
    hinfo,HSCRLID]:gadget                                      /* Propinfo, ID & User Data */

  nulinfo:=NEW [BOOLMASK]                                      /* Setup null border gadget */
  nulgad:=NEW[hscrl,-13,-13,4,4,                               /* Used to size borders !!! */
    GFLG_RELBOTTOM OR GFLG_RELRIGHT,
    GACT_BOTTOMBORDER OR GACT_RIGHTBORDER,
    GTYP_BOOLGADGET OR GTYP_GZZGADGET,
    NIL,NIL,NIL,NIL,nulinfo,NULGADID]:gadget

 mwtitle:='Map View'                                                 /* Setup Title String */
 tags:=[WA_LEFT,0, WA_TOP,(scrn.barheight)+2,                        /* Setup Window Tags  */
        WA_INNERWIDTH,MAPWINSIZE, WA_INNERHEIGHT,MAPWINSIZE,
        WA_CUSTOMSCREEN,scrn, WA_SMARTREFRESH,TRUE,
        WA_TITLE,mwtitle, WA_DRAGBAR,TRUE, WA_DEPTHGADGET,TRUE,
        WA_GIMMEZEROZERO,TRUE, WA_IDCMP,MAPWINIDCMP,
        WA_GADGETS,nulgad, WA_NEWLOOKMENUS,TRUE, TAG_END,NIL]

  mapwin:=OpenWindowTagList(NIL,tags)                                /* Open Map Window    */
  IF mapwin=0                                                        /* If failed - report */
     WriteF('Could not open map window !!\n')
     RETURN 1
  ENDIF
  mapsig:=Shl(1,mapwin.userport.sigbit)                              /* Build signal mask  */

  menus:=[NM_TITLE, 0, 'Project',     0, 0, 0, 0,                  /* Setup New Menu stuff */
           NM_ITEM, 0, 'New',       'N', 0, 0, MNUNEW,
           NM_ITEM, 0, 'Open...',   'O', 0, 0, MNUOPEN,
           NM_ITEM, 0, 'Save...',   'S', 0, 0, MNUSAVE,
           NM_ITEM, 0, 'About',     'A', 0, 0, MNUABOUT,
           NM_ITEM, 0, NM_BARLABEL,   0, 0, 0, 0,
           NM_ITEM, 0, 'Quit',      'Q', 0, 0, 0,
          NM_TITLE, 0, 'LineDefs',    0, 0, 0, 0,
           NM_ITEM, 0, 'Open...',   'L', 0, 0, MNULNOPEN,
           NM_ITEM, 0, 'Status',    'I', 0, 0, MNULNSTAT,
            NM_END, 0, NIL,           0, 0, 0, 0]:newmenu

  visinfo:=GetVisualInfoA(scrn, [NIL])                           /* Attach menus to mapwin */
  IF visinfo<>NIL
    menustrip:=CreateMenusA(menus,[GTMN_FRONTPEN,1, TAG_END,NIL])
    IF menustrip<>NIL
      IF LayoutMenusA(menustrip, visinfo, [NIL])
        IF SetMenuStrip(mapwin, menustrip)=FALSE
          WriteF('Could not attach menus to map windows !!\n')
          RETURN 1
        ENDIF
      ENDIF
    ENDIF
  ENDIF

  stat.mode  :=WE_MODE_ADD                                     /* Set intial gadget values */
  stat.edtype:=0
  stat.zoom  :=MINZOOM
  stat.x     :=0
  stat.y     :=0
  stat.wx    :=0
  stat.wy    :=0
  stat.wid   :=0
  stat.dep   :=0
  stat.flr   :=-20
  stat.ceil  :=20
  stat.alt   :=0
  stat.head  :=0
  stat.size  :=512
  stat.crad  :=0
  stat.obid  :=0
  stat.pass  :=FALSE

  congh:=guiinit('Control Panel',                                    /* Build Control GUI  */
                  [ROWS,
                    mcyc:=[CYCLE,{modehdlr},'Edit Mode',['Add','Delete','Edit',NIL],stat.mode],
                    tcyc:=[CYCLE,{typehdlr},'Edit Type',['Objects','Col Boxes',NIL],stat.edtype],
                    [COLS,
                      zint:=[INTEGER,{zinthdlr},'Zoom',MINZOOM,4],
                      zsld:=[SLIDE,{zslidehdlr},'',0,MINZOOM,MAXZOOM,MINZOOM,9,'']
                    ],
                    [COLS,
                      mxint:=[INTEGER,{mxinthdlr},'MapX',stat.x,5],
                      myint:=[INTEGER,{myinthdlr},'MapY',stat.y,5]
                    ],
                    [BAR],
                    [COLS,
                      wxint:=[INTEGER,{wxinthdlr},'ObjX',stat.wx,5],
                      wyint:=[INTEGER,{wyinthdlr},'ObjY',stat.wy,5]
                    ],
                    [COLS,
                      widint:=[INTEGER,{widinthdlr},'Wid ',stat.wid,5],
                      depint:=[INTEGER,{depinthdlr},'Dep ',stat.dep,5]
                    ],
                    [COLS,
                      flrint :=[INTEGER,{flrinthdlr} ,'Flr ',stat.flr, 5],
                      ceilint:=[INTEGER,{ceilinthdlr},'Ceil',stat.ceil,5]
                    ],
                    [COLS,
                      alt :=[INTEGER,{altinthdlr},'Alt ', stat.alt, 5],
                      head:=[INTEGER,{headinthdlr},'Head',stat.head,5]
                    ],
                    [COLS,
                      size:=[INTEGER,{sizeinthdlr},'Size',stat.size,5],
                      crad:=[INTEGER,{cradinthdlr},'Rad ',stat.crad,5]
                    ],
                    [COLS,
                      obid:=[INTEGER,{obidinthdlr},'ID #',stat.obid,5],
                      pass:=[CHECK,{passchkhdlr},'Passable',stat.pass,TRUE]
                    ],
                    [COLS,
                      obdf0 :=[STR,{obdfstrhdlr0},'DefA',s0,15,11],
                      obdfb0:=[BUTTON,{obdfbuthdlr0},'>>']
                    ],
                    [COLS,
                      obdf1 :=[STR,{obdfstrhdlr1},'DefB',s1,15,11],
                      obdfb1:=[BUTTON,{obdfbuthdlr1},'>>']
                    ],
                    [COLS,
                      obdf2 :=[STR,{obdfstrhdlr2},'DefC',s2,15,11],
                      obdfb2:=[BUTTON,{obdfbuthdlr2},'>>']
                    ],
                    [COLS,
                      obdf3 :=[STR,{obdfstrhdlr3},'DefD',s3,15,11],
                      obdfb3:=[BUTTON,{obdfbuthdlr3},'>>']
                    ],
                    [BAR],
                    [COLS,
                      [BUTTON,{updbuthdlr},' Update '],
                      [BUTTON,{clrbuthdlr},' Clear  ']
                    ]
                  ],stat,scrn,NIL,menus)

  IF congh=NIL
    WriteF('Could not open Control Panel Window\n')
    RETURN 1
  ENDIF

  win:=congh.wnd
  WindowLimits(win,win.width,win.height,win.width,win.height);

  stat.mcyc   :=mcyc       /* Store gadget E-List pointers */
  stat.tcyc   :=tcyc
  stat.zint   :=zint
  stat.zsld   :=zsld
  stat.mxint  :=mxint
  stat.myint  :=myint

  stat.wxint  :=wxint
  stat.wyint  :=wyint

  stat.widint :=widint
  stat.depint :=depint
  stat.flrint :=flrint
  stat.ceilint:=ceilint

  stat.altint :=alt
  stat.headint:=head
  stat.sizeint:=size
  stat.cradint:=crad
  stat.obidint:=obid
  stat.passchk:=pass

  stat.obdfstr[0]:=obdf0
  stat.obdfstr[1]:=obdf1
  stat.obdfstr[2]:=obdf2
  stat.obdfstr[3]:=obdf3
  stat.obdfbut[0]:=obdfb0
  stat.obdfbut[1]:=obdfb1
  stat.obdfbut[2]:=obdfb2
  stat.obdfbut[3]:=obdfb3

  disablegadgets(0)

  filereq:=AllocAslRequest(ASL_FILEREQUEST,                           /* Map FileRequester */
                     [ASL_HAIL,       'W.E. FileRequester',
                      ASL_HEIGHT,     ASLHEIGHT,
                      ASL_WIDTH,      ASLWIDTH,
                      ASL_LEFTEDGE,   ASLLEFTEDGE,
                      ASL_TOPEDGE,    ASLTOPEDGE,
                      ASL_OKTEXT,     '  OK  ',
                      ASL_CANCELTEXT, 'Cancel',
                      ASL_FILE,       '',
                      ASL_DIR,        '',
                      ASL_WINDOW,     mapwin,
                      ASL_FUNCFLAGS,  FILF_NEWIDCMP OR FILF_PATGAD,
                      ASL_PATTERN,    '~(#?.info)',
                      TAG_END,        NIL])

  linereq:=AllocAslRequest(ASL_FILEREQUEST,                      /* LineDef FileRequester  */
                     [ASL_HAIL,       'W.E. FileRequester',
                      ASL_HEIGHT,     ASLHEIGHT,
                      ASL_WIDTH,      ASLWIDTH,
                      ASL_LEFTEDGE,   ASLLEFTEDGE,
                      ASL_TOPEDGE,    ASLTOPEDGE,
                      ASL_OKTEXT,     '  OK  ',
                      ASL_CANCELTEXT, 'Cancel',
                      ASL_FILE,       '',
                      ASL_DIR,        '',
                      ASL_WINDOW,     mapwin,
                      ASL_FUNCFLAGS,  FILF_NEWIDCMP OR FILF_PATGAD,
                      ASL_PATTERN,    '~(#?.info)',
                      TAG_END,        NIL])

  IF filereq=NIL OR linereq=NIL                                  /* Check Requester Allocated */
    WriteF('Could not allocate file requester\n');
    RETURN 1
  ENDIF
ENDPROC 0

/**********************************/
/*** Draw in Background Imagery ***/
/**********************************/

PROC drawbackdropwin()
  DEF bdimage:image,bdidata,n,m,acr,dwn,x,y

  bdidata:=copyListToChip([
    $FFFBCBFD,$FF7FFEFF,$C000FBFF,$FFFFFFFF,
    $FDFFC000,$EFEEF7FD,$DFFBB7FF,$C000EF99,
    $EDF3FF6A,$4BFFC000,$FFEDFFED,$FFA96DFF,
    $C000FFF5,$6FFF7A97,$97FF8000,$FFFA9FFE,
    $FF6BDFFF,$C000F7ED,$DFFFFFA7,$FFFFC000,
    $FEBFFDF7,$F5DBFFFF,$C000FF75,$FFEFBFFF,
    $FFFFC000,$FFEFBFFF,$7EFFFFFF,$C000DEFD,
    $FBAADDFF,$FFFFC000,$BBFEBFFF,$EFFFFFFF,
    $8000EF7D,$FFEBDFFF,$FFFFC000,$FDFFBBBE,
    $FFFFFFFF,$C000FFBF,$F77DFFFF,$FEFF8000,
    $FFF6AFEE,$FFFFFFFF,$C000FFDF,$7755FFFF,
    $FDFF4000,$F7FDAEBB,$FFFFFFFF,$C000FFBE,
    $DDF7FFFF,$FFFFC000,$FEFFFEBB,$FFFFBFF6,
    $C000FFFF,$BB6EFFFF,$FFFFC000,$FD7ED6FD,
    $FFFFFFFF,$C000FFEB,$7EDFFFFF,$FFFFC000,
    $BFFFFBBF,$FDFFFFFF,$8000DFD6,$FEBFFFFF,
    $FFFFC000,$FFDFFFEF,$FFFF7FFF,$4000BFFF,
    $FFDDFFFF,$FFFFC000,$FED7D7F6,$FFFFFFBF,
    $C000DFDD,$FFDB7DDF,$FEFFC000,$FFFBBEED,
    $FFFFFFFF,$4000DFD7,$575EFFFF,$FDFFC000,
    $BF7EFF75,$FBFFFFFF,$C000FBF5,$FFEFEFFF,
    $FFFFC000,$EFFEFF77,$FFFFFFFF,$C000DEBF,
    $DEFFFFFF,$FFFFC000,$FFFEFB7F,$FFFFFFFF,
    $C000BDFB,$5DFDFFFF,$FFFF8000,$FFFDABEF,
    $FFFFFFFF,$C000DFBE,$F7F5FFFF,$FFFFC000,
    $BF7FDFEB,$FFFFFFFF,$C000BFFF,$FFEF7FFF,
    $FFFB4000,$EBDFF7DF,$FFFFFFED,$C000AAFE,
    $EFBFFFFF,$FFF74000,$5D5F5F76,$FFFFFFAA,
    $8000F5D7,$7BFBFDFF,$FEEFC000,$D55DB6B7,
    $FFFFEE9B,$C000FABE,$EBFEFFFF,$BAF7C000,
    $F6DFB7BD,$7FFEFF5F,$40007BFB,$D6EFFFFB,
    $FEFFC000,$BFF6DDD7,$F7EDFBFF,$8000DCFF,
    $EE7FFFB7,$FF7E4000,$F3FFDFF7,$7E7F7DE9,
    $4000EFF5,$FFF7FABE,$BBEFC000,$7FFFFFFB,
    $FFDDEEAB,$00007FFB,$FB2DBEFC,$FED48000,
    $FBF7ED7F,$EF7FEF5E,$C000FD6B,$FFFFFEEA,
    $BFFF0000,$FC95FFFF,$EEFFBF7F,$C000DBFB,
    $FB7FAFFF,$FFFFC000,$FDF7E5FF,$FAEFFBAB,
    $8000EBEA,$9FFFFDDF,$F77F4000,$E7BDDFFF,
    $F7BEFBFA,$C000F77D,$7FDFBBF5,$2FFFC000,
    $FFF7FFFF,$FFFDE7EF,$C000F5EF,$FFFFDF76,
    $FB9F8000,$ABFFFFFF,$BFEBFF7D,$8000BFFF,
    $FFFFFFFF,$FFBBC000,$DFFFFFFF,$FFEDFBFF,
    $C0003FFD,$FFFFBAD5,$F77BC000,$FFFFFFEF,
    $FF7DFEDF,$C000FFFF,$FEFFFDFB,$FDD7C000,
    $FFFFFFFF,$FF7EBB5B,$C000FFFD,$FFFFFEFF,
    $7777C000,$FFFFFFFF,$EDDFFEEE,$C000FFFF,
    $FFFFFF7B,$577DC000,$FFFFFDFF,$FFDD5EEF,
    $C000FFFF,$DFEFFFBF,$EDDDC000,$FFFFFFFF,
    $FD7FDBAE,$C0007FFF,$FFFDFFEE,$BBBFC000,
    $FFFF7FFF,$BDFDF75F,$C000FFFF,$FFFFFFFF,
    $BFFFC000,$7FFFFF77,$F77DDFD5,$C000FFFF,
    $FFFFEFD7,$FBBBC000,$FEFFFFFF,$BD7FF76F,
    $C0007BFF,$FFFFFFEB,$FFBFC000,$FFFFFFFF,
    $EAF7DF7F,$C000F7FF,$FFFFDFDF,$BFFFC000,
    $7FFFFFFF,$FBFEFFFF,$C000FFFF,$FFFFBFFB,
    $EBEBC000,$FFF7FFFF,$F7FEBF7E,$C000FFFF,
    $FFDFAFFA,$F6FD4000,$7FFFFFFF,$FFFB6B7D,
    $C000F7FF,$FFFFFD7F,$F5FBC000,$FFFFFFFF,
    $F7FEAFD7,$C000FFFF,$FFFFFFEF,$FD6FC000,
    $7FFFFFDF,$FFFFFFDF,$C000FFBF,$FFFBFFDF,
    $FD5FC000,$FEFFFFEE,$BFFFFDEF,$4000FFFF,
    $FFBF7DFD,$FBBFC000,$FFFFFE6F,$FBFFFF5B,
    $C000FFFF,$F9D5BFE6,$FDED4000,$FFFFE757,
    $FEBFEFBB,$C000FFFF,$BABDF7AF,$FDDF4000,
    $FFFEF5AB,$FD76FFEB,$8000FDFB,$FEFAFF5F,
    $7DD6C000,$F7EF7FF6,$DABCFBEF,$C0007FB7,
    $DF6FEEFB,$7FDFC000,$FFD7BDFF,$FFF6FFDF,
    $C000FBFA,$AFE5EFFF,$DF7FC000,$EEEB7FFA,
    $DFEFF57F,$4000392D,$FDBBFF1E,$FAFE8000,
    /* Plane 1 */
    $57F1C3B5,$6F7FFCEC,$000051BF,$5EFDFEDA,
    $D9728000,$85C4E5D9,$8B7327C8,$80004608,
    $E4E1FF20,$01224000,$5549BFC5,$5A884C95,
    $000055A0,$45BE7203,$00200000,$56A00FFA,
    $7D238545,$40008149,$5D5ED783,$20288000,
    $541555E3,$F0C89515,$00002E20,$ADAF2FBA,
    $48A08000,$A2450BEA,$5C61220A,$40000CA8,
    $B00A9994,$89520000,$00B41BB5,$CE491449,
    $00004228,$AA434922,$A2A20000,$28AD1114,
    $E4480808,$8000A515,$22281289,$54550000,
    $53A00544,$88522040,$00004A06,$22005288,
    $888A0000,$A1B80411,$44425454,$4000250C,
    $88A18895,$11024000,$A874A811,$2A4804A0,
    $0000554B,$12044115,$12104000,$20280068,
    $AAA0A8AA,$8000A942,$540D0015,$02220000,
    $0D295115,$A8A05555,$00008484,$74152215,
    $20800000,$2A869544,$88A20A2A,$00001255,
    $56895514,$52908000,$140282A0,$204A080A,
    $40008488,$AA820880,$A4084000,$2A911448,
    $511510A2,$00008482,$02048840,$A80A4000,
    $12145620,$212A0155,$000010A0,$B2458111,
    $54408000,$42945622,$C4444A14,$4000841A,
    $886B12AA,$91528000,$2894522A,$A4102452,
    $000008A0,$08A88AAA,$92840000,$A9290145,
    $50408851,$40000508,$42C08A2A,$45150000,
    $942A9541,$20821041,$C0001A4A,$CB441554,
    $AAAA0000,$C28AA287,$88422200,$80000044,
    $451A5295,$54E64000,$18140A20,$29488100,
    $0000A182,$11528022,$2E4B8000,$80092021,
    $5509440A,$C000F03C,$82941054,$10A28000,
    $A48F2128,$2A827E16,$000032D1,$C4468051,
    $D46EC000,$1AF49882,$A28951B5,$0000C86F,
    $CE250826,$F6340000,$A1F595E2,$223219C0,
    $000067B4,$FF73501C,$A8A58000,$3EEBDBA9,
    $1D484602,$00006BF3,$7225B6FC,$FC900000,
    $79B3A43C,$0E2AC64C,$8000D442,$FFE96A62,
    $3FBE0000,$F801DB64,$04EF1A77,$C00099FB,
    $721104BD,$FFDD8000,$D5A3C044,$504FD103,
    $000062E0,$09115085,$737B0000,$C31D844A,
    $2514AB58,$C000E778,$090111A0,$26F74000,
    $76A25294,$4AA803CF,$C000B1EA,$24228A20,
    $E30D0000,$02C08954,$0A423939,$0000BF2A,
    $A4012BD5,$A533C000,$9A401154,$A440D29D,
    $80001928,$AAA41080,$A253C000,$60422002,
    $9228B409,$40008A95,$54445850,$A8850000,
    $52200229,$22341001,$80008888,$A8849456,
    $22228000,$A2544552,$40895444,$00001522,
    $10092A12,$02288000,$A05148A0,$A4900445,
    $40005509,$0085350D,$48888000,$81444A20,
    $A02A8104,$00002A29,$22882944,$110D8000,
    $81441455,$0868A215,$0000AA2A,$41004955,
    $16954000,$08808A22,$A2288A80,$8000A255,
    $54110202,$D1110000,$080822A8,$102B2205,
    $80002055,$54054A41,$552A8000,$52820151,
    $40428A1D,$00000028,$AA2A0115,$1B528000,
    $22952080,$9154556A,$80001242,$55551491,
    $41014000,$A8A08808,$82D41274,$00008505,
    $22820220,$24280000,$10A22914,$49504048,
    $80004228,$84A2A816,$A1310000,$41455114,
    $41240482,$80002A28,$0A82A545,$48428000,
    $08854809,$D495750E,$8000A210,$A292BA85,
    $A8054000,$54051444,$1655288A,$00002052,
    $221E59A8,$D12A8000,$8AA94845,$71A15A01,
    $40002102,$208116C4,$28880000,$94554205,
    $DC16C511,$00004290,$1098A307,$688A0000,
    $9444E002,$F864D581,$00004052,$ACD0561E,
    $78800000,$21063EE4,$90186945,$400004A3,
    $8A26C4F2,$7F870000,$52852956,$DFE4AB95,
    $400023B0,$0DC0CABF,$CE7A8000,$084256D0,
    $4FC6B06E,$00003809,$F93BFE1C,$F2BE0000,
    /* Plane 2 */
    $0A8A0948,$92124832,$40002248,$E5128965,
    $24800000,$08080060,$14000162,$00008091,
    $49028248,$48888000,$260044A8,$B1010000,
    $000048C5,$0A440814,$12890000,$00101114,
    $A6414010,$00002280,$88812004,$89020000,
    $08084855,$25900040,$40004441,$13441049,
    $220A0000,$09082011,$28A408A0,$00008041,
    $01304480,$20008000,$1228350A,$82224144,
    $00000441,$00809088,$08108000,$41182228,
    $22012242,$00003002,$80008024,$00000000,
    $05440A88,$25008915,$00002090,$40010022,
    $20200000,$02010822,$11080100,$80009018,
    $0104A220,$94240000,$24A25420,$80021000,
    $40002010,$00481440,$41450000,$88448201,
    $000A0400,$00000200,$28984940,$50888000,
    $14521002,$80090000,$00000100,$C2208840,
    $0A2A4000,$900A288A,$22082080,$000004A0,
    $82000045,$00020000,$40040144,$89009210,
    $80000D11,$5410200A,$00420000,$90400081,
    $04404408,$00000204,$04082112,$00A28000,
    $0820A440,$80005400,$00004104,$290A0444,
    $01144000,$04208040,$91114041,$00001014,
    $12264000,$24100000,$82408010,$09548148,
    $80001012,$11412000,$08210000,$0C800008,
    $02124104,$00009014,$A5A12080,$10404000,
    $02080000,$8A294512,$40002091,$568A0000,
    $00000000,$08044011,$2148AA49,$40002290,
    $02008420,$01000000,$00011044,$00022422,
    $00004444,$42212888,$80854000,$101004C2,
    $00200814,$0000428A,$20284482,$22450000,
    $10018200,$0010A400,$40005168,$108B2502,
    $88B50000,$04024400,$00262202,$000010B4,
    $8852A201,$08480000,$C2824A80,$08583080,
    $40000841,$12A50002,$024A0000,$53356410,
    $AA908800,$00001080,$00080848,$44448000,
    $A245494A,$44452910,$00002809,$12300488,
    $04550000,$90906481,$4052B548,$80000241,
    $81040A4A,$01024000,$A9440411,$0000A22A,
    $00008108,$90442912,$A4004000,$24280100,
    $800812B2,$00008221,$240802C0,$01498000,
    $A9440041,$10114404,$00000080,$89080C44,
    $31120000,$A92A2001,$11008240,$80000400,
    $015440A2,$08190000,$14892400,$0908A122,
    $40002000,$00050000,$00010000,$8528A944,
    $24515892,$80001000,$00109102,$01000000,
    $00894882,$08582212,$8000A220,$02104000,
    $04400000,$08011000,$0912A008,$800040A8,
    $44A24040,$04410000,$0A020008,$09081008,
    $00000050,$12026014,$81410000,$25010088,
    $08410808,$40000084,$48208208,$22248000,
    $28100100,$10A10002,$80000081,$14252228,
    $2B480000,$22242000,$00010001,$00000800,
    $05444484,$A2204000,$A0A28801,$0812804A,
    $80000200,$00902080,$2A020000,$0028A404,
    $00250828,$8000A482,$00808A60,$05850000,
    $00002A2A,$2008A010,$00004892,$80000122,
    $02420000,$0202224A,$24802828,$80001020,
    $08080088,$80800000,$42088041,$24220211,
    $000000A2,$22080000,$40404000,$14100841,
    $224C0905,$00008082,$80100802,$A0088000,
    $22102282,$A5202A44,$40000804,$0800506A,
    $80120000,$4050408A,$09005140,$00008900,
    $84242091,$00050000,$20041002,$A2443410,
    $00008450,$81500800,$81400000,$01000402,
    $A4AA0802,$80002805,$20204400,$C1100000,
    $00904509,$21122942,$00009001,$10200808,
    $10048000,$024A4942,$42A4D288,$00002000,
    $040A0820,$01128000,$899290A1,$64924C40,
    $00000040,$06800544,$91150000,$A4092022,
    $92094450,$00001120,$94908808,$20448000])
  
  bdimage:=[0, 0,             /* LeftEdge, TopEdge     */
          66, 112, 3,         /* Width, Height, Depth  */
          bdidata,            /* ImageData             */
          $0007, $0000,       /* PlanePick, PlaneOnOff */
          NIL                 /* NextImage             */
          ]:image

  acr:=Div(bdwin.width,66)
  dwn:=Div(bdwin.height,111)
  FOR n:=0 TO acr
    FOR m:=0 TO dwn
      x:=Mul(n,66)
      y:=Mul(m,111)
      DrawImage(bdwin.rport, bdimage, x ,y)
    ENDFOR
  ENDFOR

  Dispose(bdidata)
ENDPROC

PROC copyListToChip(data)
  DEF size, mem
  size:=ListLen(data)*SIZEOF LONG
  mem:=NewM(size, MEMF_CHIP)
  CopyMemQuick(data, mem, size)
ENDPROC mem

/*************************************/
/*** Load Object Definitions Array ***/
/*************************************/

/* The error flag 1=output error using WriteF & return error
                  0=just return error

   Returns 0 on success, otherwise 1 */

PROC loadobjdefs(error)
  DEF handle,len,size,hdr:obdfheader,ret=1
  DEF ptr:PTR TO objdef

  handle:=Open('ObjDef.Data',MODE_OLDFILE)                        /* Attempt to Open File    */
  IF handle<>NIL                                                  /* If opened O.K.          */
    len:=Read(handle,hdr,SIZEOF obdfheader)                       /* Attempt to Read Header  */
    IF len=SIZEOF obdfheader                                      /* If read O.K.            */
      IF hdr.magic=OBJDEFMAGIC                                    /* and is of Correct Type  */
        IF (hdr.count>0) AND (hdr.count<1001)                     /* Check ObjDef Count      */
          IF stat.defptr<>NIL THEN Dispose(stat.defptr)           /* Free old ObjDef Data    */
          stat.defcount:=hdr.count                                /* Store New ObjDef Count  */
          size:=Mul(hdr.count,SIZEOF objdef)                      /* Calc RAM for ObjDefs    */
          stat.defptr:=New(size)                                  /* Alloc RAM for ObjDefs   */
          len:=Read(handle,stat.defptr,size)                      /* Attempt to Read ObjDefs */
          IF len=size                                             /* If read O.K.            */
            builddeflist()                                        /* Build defs exec list    */
            ret:=0                                                /* Set Success Flag        */
          ELSE
            IF error=1 THEN WriteF('The file is Truncated\n')     /* File is Truncated       */
            Dispose(stat.defptr)                                  /* Cleanup ObjDef Details  */
            stat.defcount:=NIL
            stat.defptr:=NIL
          ENDIF
        ELSE
          IF error=1 THEN WriteF('ObjDef Count out of Bounds\n')  /* ObjDef Count Wrong      */
        ENDIF
      ELSE
        IF error=1 THEN WriteF('File is not an ObjDef file\n')    /* File Type In-correct    */
      ENDIF
    ELSE
      IF error=1 THEN WriteF('Could not Read file Header\n')      /* Could not read header   */
    ENDIF
    Close(handle)
  ELSE
    IF error=1 THEN WriteF('Failed to Open ObjDef file\n')        /* Could Not Open File     */
  ENDIF
ENDPROC ret

/*******************************************************/
/*** Convert ObjDef Array to ExecList and Free Array ***/
/*******************************************************/

PROC builddeflist()
  DEF n,m,di:PTR TO defitem

  IF stat.deflist=NIL                             /* If no current exec list header */
    stat.deflist:=newlist()                       /* Build new blank list           */
  ELSE
    freedefnodes()                                /* Otherwise kill contents        */
  ENDIF

  FOR n:=0 TO stat.defcount-1                     /* Loop throgh objdef array       */
    di:=New(SIZEOF defitem)                       /* Alloc RAM for new defitem node */
    FOR m:=0 TO 15                                /* Copy name from objdef->defitem */
      di.name[m]:=stat.defptr[n].name[m]
    ENDFOR
    di.id:=stat.defptr[n].id                      /* Copy ID from objdef->defitem   */
    newnode(di.node,di.name,0,0)                  /* Initialise defitem's node      */
    Enqueue(stat.deflist,di.node)                 /* Add node to current list end   */
  ENDFOR
  Dispose(stat.defptr)                            /* Free objdef array (not needed) */
  stat.defptr:=NIL                                /* Clear objdef array base ptr    */
ENDPROC

/*** Free Contents of DefItem Exec List ***/

PROC freedefnodes()
  DEF di:PTR TO defitem,next:PTR TO defitem

  di:=stat.deflist.head
  WHILE di.node.succ<>NIL
    next:=di.node.succ
    Remove(di.node)
    Dispose(di)
    di:=next
  ENDWHILE
ENDPROC

/*****************************/
/**** Init Misc Resources ****/
/*****************************/

/* Returns 0 on success */

PROC initmisc()
  tantab:=[$00000004,$00000008,$0000000D,$00000011,
           $00000016,$0000001A,$0000001F,$00000023,
           $00000028,$0000002D,$00000031,$00000036,
           $0000003B,$0000003F,$00000044,$00000049,
           $0000004E,$00000053,$00000058,$0000005D,
           $00000062,$00000067,$0000006C,$00000071,
           $00000077,$0000007C,$00000082,$00000088,
           $0000008D,$00000093,$00000099,$0000009F,
           $000000A6,$000000AC,$000000B3,$000000B9,
           $000000C0,$000000C8,$000000CF,$000000D6,
           $000000DE,$000000E6,$000000EE,$000000F7,
           $000000FF,$00000109,$00000112,$0000011C,
           $00000126,$00000131,$0000013C,$00000147,
           $00000153,$00000160,$0000016D,$0000017B,
           $0000018A,$00000199,$000001AA,$000001BB,
           $000001CD,$000001E1,$000001F6,$0000020C,
           $00000224,$0000023E,$0000025B,$00000279,
           $0000029A,$000002BF,$000002E7,$00000313,
           $00000345,$0000037C,$000003BB,$00000402,
           $00000454,$000004B4,$00000525,$000005AB,
           $00000650,$0000071D,$00000824,$00000983,
           $00000B6E,$00000E4C,$00001314,$00001CA2,
           $0000394A]
ENDPROC 0

/*****************************/
/**** Cleanup before Exit ****/
/*****************************/

PROC cleanup()
   IF linereq<>NIL             THEN FreeAslRequest(linereq)
   IF filereq<>NIL             THEN FreeAslRequest(filereq)
   IF congh<>NIL               THEN cleangui(congh)
   IF mapwin.menustrip<>NIL    THEN ClearMenuStrip(mapwin)
   IF menustrip<>NIL           THEN FreeMenus(menustrip)
   IF visinfo<>NIL             THEN FreeVisualInfo(visinfo)
   IF mapwin<>NIL       THEN CloseWindow(mapwin)
   IF bdwin<>NIL        THEN CloseWindow(bdwin)
   IF scrn<>NIL         THEN CloseScreen(scrn)
   IF font<>NIL         THEN CloseFont(font)
   IF aslbase<>NIL      THEN CloseLibrary(aslbase)
   IF gadtoolsbase<>NIL THEN CloseLibrary(gadtoolsbase)
   IF diskfontbase<>NIL THEN CloseLibrary(diskfontbase)
ENDPROC

/*************************************************/
/**** Wait on both ports for interface events ****/
/*************************************************/

PROC waitevent()
  DEF sig,ret=-1

  drawall()                                                       /* Do Initial Re-Draw     */

  WHILE ret<>0                                                    /* Loop until return=0    */
    sig:=Wait(mapsig OR congh.sig)                                /* Wait on both ports     */
    IF (sig AND mapsig)    THEN ret:=mapevent()                   /* Handle MapWin events   */
    IF (sig AND congh.sig) THEN ret:=conevent()                   /* Handle EasyGUI events  */

    IF ret=0                                                      /* Verify Exit */
      ret:=butrequest('W.E. Request','Quit, Are you sure ?',' Quit |Cancel')
      IF ret=0 THEN ret:=-1 ELSE ret:=0
    ENDIF

  ENDWHILE
ENDPROC

/**********************************/
/**** Handle Map Window Events ****/
/**********************************/

/* Return >= 0 to force exit

NOTE - IDCMP_MOUSEBUTTONS msg.code = SELECTDOWN,SELECTUP,MENUDOWN or MENUUP
       There are also middle button events.

This routine loops until all messages at port are dealt with
*/

PROC mapevent()
   DEF ret=-1,class,code, iaddr,msg=NIL:PTR TO intuimessage
   DEF gad=NIL:PTR TO gadget,mnu:PTR TO menuitem

   msg:=GetMsg(mapwin.userport)                                /** Get 1st message & store **/
   WHILE msg<>NIL
      class:=msg.class                                         /*     important details     */
      code :=msg.code
      iaddr:=msg.iaddress
      ReplyMsg(msg)                                            /**     Reply to Sender     **/

      SELECT class
      CASE IDCMP_GADGETDOWN                                    /** Handle Gadget Dn Events **/
         gad:=iaddr                                            /* Get Gadget Pointer        */
         stat.actscroll:=gad                                   /* Set Active Scroll Gadget  */
      CASE IDCMP_GADGETUP                                      /** Handle Gadget Up Events **/
         gad:=iaddr                                            /* Get Gadget Pointer        */
         stat.actscroll:=NIL                                   /* Clr Active Scroll Gadget  */
         SELECT gad                                            /* Is it the Vert Scroller?  */
         CASE vscrl                                            /* Update Y Co-ord Gadgets   */
            getvscroller()                                     /* Is it the Horz Scroller?  */
         CASE hscrl                                            /* Update X Co-ord Gadgets   */
            gethscroller()
         ENDSELECT
      CASE IDCMP_MOUSEBUTTONS                                  /** Get Mouse Button Events **/
         clickmodehdlr(code)
      CASE IDCMP_INTUITICKS                                    /** Handle Intuitick Events **/
         IF stat.mouse THEN handledrag()                       /* If mouse down draw stuff  */
         gad:=stat.actscroll                                   /*  Get Current Active Gad   */
         SELECT gad
         CASE vscrl                                            /* If Vertical Update Y Gadg */
            getvscroller()
         CASE hscrl                                            /* If Horiz updates X Gadget */
            gethscroller()
         ENDSELECT
      CASE IDCMP_MENUPICK                                      /**    Handle Menu Event    **/
         code:=UNSIGNED(code)
         WHILE (code<>MENUNULL) AND (ret<>0)                   /*  Loop throgh menu events  */
           mnu:=ItemAddress(menustrip,code)                    /*  Get address of menuitem  */
           code:=UNSIGNED(mnu.nextselect)                      /*  Get next menu selection  */
           ret:=GTMENUITEM_USERDATA(mnu)                       /*  Get menuitems user data  */
           IF ret<>0 THEN menuhandler(ret)                     /*  Call menu event handler  */
         ENDWHILE                                              /* Loop until no more events */
      ENDSELECT
      msg:=GetMsg(mapwin.userport)                             /** Get Next message if any **/
   ENDWHILE
ENDPROC ret

/*******************************************/
/**** Handle Drawing Mouse Drag Details ****/
/*******************************************/

PROC handledrag()
  DEF x,y,dx,dy

  IF stat.mousecount THEN drawdrag()
  x:=mapwin.gzzmousex
  y:=mapwin.gzzmousey
  IF (x>=0) AND (x<MAPWINSIZE) AND (y>=0) AND (y<MAPWINSIZE)
    stat.mouseex:=x
    stat.mouseey:=y
    dx:=Shr(stat.mousesx-x,1)
    dy:=Shr(stat.mousesy-y,1)
    IF dx<0 THEN dx:=0-dx
    IF dy<0 THEN dy:=0-dy
    IF dx+dy>0
      drawdrag()
      stat.mousecount:=1
    ENDIF
  ENDIF
ENDPROC

/***************************************/
/**** Do XOR drawing during drag op ****/
/***************************************/

PROC drawdrag()
  DEF oldrast,mode
  DEF wobj:PTR TO wobject, col:PTR TO colarea
  DEF x1,y1,x2,y2,t,s,type

  mode:=stat.mode
  oldrast:= stdrast                                              /* Store current rastport  */
  stdrast:= mapwin.rport                                         /* Set rastport to mapwin  */
  SetDrMd(stdrast,RP_COMPLEMENT)                                 /* Set complement drawmode */

  IF stat.edtype
    IF stat.mode=WE_MODE_ADD  THEN type:=1
    IF stat.mode=WE_MODE_EDIT THEN type:=3
    IF stat.mode=WE_MODE_DEL  THEN type:=1
  ELSE
    IF stat.mode=WE_MODE_ADD  THEN type:=0
    IF stat.mode=WE_MODE_EDIT THEN type:=2
    IF stat.mode=WE_MODE_DEL  THEN type:=1
  ENDIF

  SELECT type
  CASE 0
    Line(stat.mousesx,stat.mousesy,stat.mouseex,stat.mouseey,ORANGE)           /* Draw line */
  CASE 1
    Line(stat.mousesx,stat.mousesy,stat.mouseex,stat.mousesy,ORANGE)           /* Draw box  */
    Line(stat.mouseex,stat.mousesy,stat.mouseex,stat.mouseey,ORANGE)
    Line(stat.mousesx,stat.mouseey,stat.mouseex,stat.mouseey,ORANGE)
    Line(stat.mousesx,stat.mousesy,stat.mousesx,stat.mouseey,ORANGE)
  CASE 2
    wobj:=stat.actwobj
    IF wobj.radius=0                                     /* Base map size & Color on radius */
      s:=4                                               /* Non collsion object are 4 rad.  */
    ELSEIF wobj.size=0
      s:=wobj.radius
    ELSE
      s:=wobj.radius
    ENDIF
    t:=Div(Div(Shl(MAXCOORD,9),stat.zoom),MAPWINSIZE)           /* Calculate Pixel Divisor  */
    s:=Div(Shl(s,9),t)                                          /* Calculate size           */
    IF s>MAPWINSIZE THEN s:=MAPWINSIZE                          /* Limit size to MAPWINSIZE */
    x2:=stat.mouseex+s                                          /* Calculate Box Dimensions */
    y2:=stat.mouseey+s
    x1:=stat.mouseex-s
    y1:=stat.mouseey-s
    IF (x2>=0) AND (y2>=0) AND (x1<MAPWINSIZE) AND (y1<MAPWINSIZE)  /* If in window draw it */
      Line(x1,y1,x2,y2,ORANGE)
      Line(x1,y2,x2,y1,ORANGE)
    ENDIF
  CASE 3
    col:=stat.actcol
    x1:=stat.mouseex
    y1:=stat.mouseey
    IF (x1>=0) AND (y1>=0) AND (x1<MAPWINSIZE) AND (y1<MAPWINSIZE)  /* If in window draw it */
      t:=Div(Div(Shl(MAXCOORD,9),stat.zoom),MAPWINSIZE)          /* Calculate Pixel Divisor */
      x2:=(Div(Shl(col.width,9),t))+x1                           /* Calc on screen width &  */
      y2:=(Div(Shl(col.depth,9),t))+y1                           /* depth                   */
      Line(x1,y1,x2,y1,ORANGE)                                   /* Draw draggable box      */
      Line(x2,y1,x2,y2,ORANGE)
      Line(x2,y2,x1,y2,ORANGE)
      Line(x1,y2,x1,y1,ORANGE)
    ENDIF
  ENDSELECT
  SetDrMd(stdrast,RP_JAM1)                                       /* Restore old draw mode   */
  stdrast:=oldrast                                               /* Restore old rastport    */
  stat.mousecount:=0                                             /* Clear mouse draw flag   */
ENDPROC

/********************************************/
/*** Handle Map Window Mouse Click Events ***/
/********************************************/

PROC clickmodehdlr(code)
  DEF x,y,mode

  mode:=stat.mode                                               /* Get current editor mode   */

  SELECT code
  CASE SELECTDOWN                                               /* Handle mouse but. down    */
    x:=mapwin.gzzmousex                                         /* Get Co-ords rel.to GZZwin */
    y:=mapwin.gzzmousey                                         /* Only store if in window   */
    IF (x>=0) AND (x<MAPWINSIZE) AND (y>=0) AND (y<MAPWINSIZE)
      stat.mouse:=1                                             /* Set drag op started flag  */
      stat.mousesx:=x                                           /* Store Co-ords as down pos */
      stat.mousesy:=y
      stat.mouseex:=x
      stat.mouseey:=y
      stat.mousecount:=0                                        /* Init drag draw statusflag */
      SELECT mode
      CASE WE_MODE_EDIT                                         /* Call Edit Mode handler    */
        editdownclick()
      ENDSELECT
    ELSE
      stat.mouse:=0                                             /* Clear draw op flag        */
    ENDIF
  CASE SELECTUP                                                 /* Handle mouse but. release */
    IF stat.mousecount THEN drawdrag()                          /* Undraw drag box if any    */
    SELECT mode
    CASE WE_MODE_ADD                                            /* Call Add Mode Clk handler */
      addupclick()
    CASE WE_MODE_DEL                                            /* Call Del Mode Clk handler */
      delupclick()
    CASE WE_MODE_EDIT                                           /* Call Edit Mode handler    */
      editupclick()
    ENDSELECT
    stat.mouse:=0                                               /* Clear mouse drag op flag  */
  ENDSELECT
ENDPROC

/*****************************************/
/**** Handle add mode mouse up/events ****/
/*****************************************/

PROC addupclick()
  DEF x,y,x1,y1,x2,y2,t
  DEF witem:PTR TO wobitem,citem:PTR TO colitem

  x:=mapwin.gzzmousex                                         /* Get Co-ords rel.to GZZwin */
  y:=mapwin.gzzmousey
  IF (x>=0) AND (x<MAPWINSIZE) AND (y>=0) AND (y<MAPWINSIZE)  /* If inside GZZ window      */
    x2,y2:=screen2map(x,y)                                    /* Map Co-ords of Up Event   */

    IF stat.edtype
      x1,y1:=screen2map(stat.mousesx,stat.mousesy)            /* Map Co-ords of Down Event */
      IF x2<x1                                                /* Ensure co-ords ascending  */
        t:=x1
        x1:=x2
        x2:=t
      ENDIF
      IF y2<y1
        t:=y1
        y1:=y2
        y2:=t
      ENDIF
      IF (x2<=(x1+1)) OR (y2<=(y1+1)) THEN RETURN
      stat.wx:=x1
      stat.wy:=y1
      stat.wid:=x2-x1                                         /* Calculate width & depth   */
      stat.dep:=y2-y1
      setinteger(congh,stat.widint,stat.wid)                  /* Update Width/Depth in GUI */
      setinteger(congh,stat.depint,stat.dep)
      citem:=New(SIZEOF colitem)
      newnode(citem.node,NIL,0,0)
      Enqueue(stat.collist,citem.node)
      gui2col(citem.col)
      SetStdRast(mapwin.rport)
      coldraw(citem.col,0,0)
    ELSE
      IF stat.obdfid[0]=NIL                                   /* Check Gadget Settings     */
        butrequest('Warning','No Primary ObjDef Specified',' OK ')
        RETURN
      ENDIF
      stat.wx:=x2                                             /* Set wobject X,Y Co-ords   */
      stat.wy:=y2
      setinteger(congh,stat.wxint,stat.wx)                    /* Reflect Co-ords in GUI    */
      setinteger(congh,stat.wyint,stat.wy)
      witem:=New(SIZEOF wobitem)                              /* Allocate RAM for wobject  */
      newnode(witem.node,NIL,0,0)                             /* Initialise node structure */
      Enqueue(stat.woblist,witem.node)                        /* Add wobject to exec list  */
      gui2wobj(witem.wob)                                     /* Copy GUI to WObject       */
      SetStdRast(mapwin.rport)                                /* Setup for Mapwin drawing  */
      wobjdraw(witem.wob,0,0)                                   /* Draw in new object        */
    ENDIF
    setinteger(congh,stat.wxint,stat.wx)                      /* Reflect Co-ords in GUI    */
    setinteger(congh,stat.wyint,stat.wy)
  ENDIF
ENDPROC

/*************************************************/
/**** Handle delete mode mouse up/down events ****/
/*************************************************/

PROC delupclick()
  DEF ret,next,x,y,wobx,woby
  DEF item:PTR TO wobitem, citem:PTR TO colitem

  IF stat.mouse                                                 /* Ignore if not drag op    */
    x:=mapwin.gzzmousex
    y:=mapwin.gzzmousey
    IF (x>=0) AND (x<MAPWINSIZE) AND (y>=0) AND (y<MAPWINSIZE)  /* If inside GZZ window     */
      wobx,woby:=screen2map(x,y)
      x,y:=screen2map(stat.mousesx,stat.mousesy)
      IF stat.edtype
        ret:=groupselectclb(wobx,woby,x,y)
        IF ret THEN ret:=butrequest('W.E. Request','Delete Collison Box(s) ?','Delete|Cancel')
        IF ret                                                  /* Check Deletion is O.K.   */
          citem:=stat.collist.head                              /* Get Start of colitem List*/
          WHILE citem.node.succ<>NIL                            /* If Valid colitem         */
            next:=citem.node.succ                               /* Store ptr to next colitem*/
            IF citem.select                                     /* If item selected then .. */
              IF citem.col=stat.actcol THEN stat.actcol:=NIL    /* Clear actcol  if deleted */
              Remove(citem.node)                                /* Remove colbox From List  */
              Dispose(citem.node)                               /* Dispose of Items Memory  */
            ENDIF
            citem:=next
          ENDWHILE
        ENDIF
        IF stat.actcol<>NIL
          col2gui(stat.actcol)                                  /* Update GUI as required   */
        ELSE
          clrbuthdlr(0)
        ENDIF
      ELSE
        ret:=groupselectwob(wobx,woby,x,y)
        IF ret THEN ret:=butrequest('W.E. Request','Delete Object(s) ?','Delete|Cancel')
        IF ret                                                  /* Check Deletion is O.K.   */
          item:=stat.woblist.head                               /* Get Start of wobitem List*/
          WHILE item.node.succ<>NIL                             /* If Valid wobitem         */
            next:=item.node.succ                                /* Store ptr to next wobitem*/
            IF item.select                                      /* If item selected then .. */
              IF item.wob=stat.actwobj THEN stat.actwobj:=NIL   /* Clear actwobj if deleted */
              Remove(item.node)                                 /* Remove Object From List  */
              Dispose(item.node)                                /* Dispose of Items Memory  */
            ENDIF
            item:=next
          ENDWHILE
        ENDIF
        IF stat.actwobj<>NIL
          wobj2gui(stat.actwobj)                                /* Update GUI as required   */
        ELSE
          clrbuthdlr(0)
        ENDIF
      ENDIF
      drawall()                                                 /* Update map display etc.  */
    ENDIF
  ENDIF
ENDPROC

/***********************************************/
/**** Handle edit mode mouse up/down events ****/
/***********************************************/

PROC editdownclick()
  DEF x,y,wobj:PTR TO wobject,col:PTR TO colarea

  x,y:=screen2map(stat.mousesx,stat.mousesy)                  /* Get mouse down coords    */

  IF stat.edtype                                              /*** Handle ColArea Edit  ***/
    col:=findcolcoord(x,y)                                    /* Find colarea at coords   */
    IF col<>NIL                                               /* If object found then     */
      col2gui(col)                                            /* Copy to GUI & Highlight  */
    ELSE
      stat.mouse:=0                                           /* Otherwise cancel drag op */
    ENDIF
  ELSE                                                        /*** Handle Wobject Edit  ***/
    wobj:=findwobjcoord(x,y)                                  /* Find object at coords    */
    IF wobj<>NIL                                              /* If object found then     */
      wobj2gui(wobj)                                          /* Copy to GUI & Highlight  */
    ELSE
      stat.mouse:=0                                           /* Otherwise cancel drag op */
    ENDIF
  ENDIF
ENDPROC

PROC editupclick()
  DEF x,y,dx,dy,wobj:PTR TO wobject,col:PTR TO colarea

  x:=mapwin.gzzmousex                                         /* Get current mouse coords */
  y:=mapwin.gzzmousey
  IF (x>=0) AND (x<MAPWINSIZE) AND (y>=0) AND (y<MAPWINSIZE)  /* Ensure inside GZZ window */
    dx:=Shr(stat.mousesx-x,1)                                 /* Determine distance moved */
    dy:=Shr(stat.mousesy-y,1)
    IF dx<0 THEN dx:=0-dx
    IF dy<0 THEN dy:=0-dy

    IF stat.edtype
      col:=NIL
      IF stat.mouse AND (dx+dy<>0)                            /* If drag op then update   */
        x,y:=screen2map(x,y)                                  /* ColArea to release pos   */
        col:=stat.actcol
        col.x:=x
        col.y:=y
        col2gui(col)
        drawall()
      ELSE                                                    /* If not drag op then find */
        x,y:=screen2map(x,y)                                  /* colarea clicked up over  */
        col:=findcolcoord(x,y)
      ENDIF

    ELSE
      wobj:=NIL
      IF stat.mouse AND (dx+dy<>0)                            /* If drag op then update   */
        x,y:=screen2map(x,y)                                  /* Wobject to release pos   */
        wobj:=stat.actwobj
        wobj.x:=x
        wobj.y:=y
        wobj2gui(wobj)
        drawall()
      ELSE                                                    /* If not drag op then find */
        x,y:=screen2map(x,y)                                  /* object clicked up over   */
        wobj:=findwobjcoord(x,y)
      ENDIF
      IF wobj<>NIL THEN wobj2gui(wobj)                        /* Update object found/moved*/
    ENDIF
  ENDIF
ENDPROC

/***********************************************/
/**** Convert Screen Co-ords to map Co-ords ****/
/***********************************************/

PROC screen2map(scrx,scry)
  DEF mult,mapx,mapy
  mult:=Div(Div(Shl(MAXCOORD,9),stat.zoom),MAPWINSIZE)      /* Calculate Map Co-ords */
  mapx:=Shr(Mul(mult,scrx),9)+stat.x
  mapy:=Shr(Mul(mult,scry),9)+stat.y
ENDPROC mapx,mapy

/****************************/
/**** Handle Menu Events ****/
/****************************/

/* Not needed to handle quit (0) menu events */

PROC menuhandler(event)
  SELECT event
  CASE MNUNEW
    newmap()
  CASE MNUOPEN
    loadrequest()
  CASE MNUSAVE
    saverequest()
  CASE MNUABOUT
    butrequest('About W.E.',abouttitle,' OK ')
  CASE MNULNOPEN
    loadlinerequest()
  CASE MNULNSTAT
    linedefstatus()
  ENDSELECT
ENDPROC

/***************************/
/**** Clear Current Map ****/
/***************************/

PROC newmap()
  DEF ret,r1:requester,r2:requester,active=0

  IF stat.woblist.head.succ<>NIL                                /* If items in list verify */

    ret:=butrequest('Warning','Clear current map ?','  OK  |CANCEL')

    IF ret                                                      /* If verified to clear    */
      IF stat.woblist.head<>NIL THEN freewobjectlist()          /* Free wobject exec list  */
      IF stat.collist.head<>NIL THEN freecolarealist()          /* Free colarea exec list  */
      cleargadgets()                                            /* Clear Wobject gadgets   */
      stat.actwobj:=NIL                                         /* Clear active gadget     */
      drawall()                                                 /* Re-Draw blank map       */
    ENDIF
  ENDIF
ENDPROC

/****************************/
/**** Load Line Def file ****/
/****************************/

PROC loadlinerequest() HANDLE
  DEF ret,active=0,r1:requester,r2:requester
  DEF pathname[PATHLEN]:STRING

  active:=disableinput(r1,r2)                                         /* Dissable Input   */

  ret:=AslRequest(linereq,[ASL_HAIL, 'Select LineDef to Load', NIL])  /* Do Requester     */
  IF ret                                                              /* If Selected file */
    StrCopy(pathname,linereq.drawer)                                  /* Concat dir/file  */
    ret:=AddPart(pathname,linereq.file,PATHLEN)
    IF ret AND pathname[0]<>0 THEN loadlinedef(pathname)              /* Call Load LineDef*/
  ENDIF
EXCEPT DO
  IF active<>0 THEN enableinput(r1,r2)                                /* Re-Enable Input  */
  ReThrow()
ENDPROC

/********************************/
/**** Load Specified LineDef ****/
/********************************/

PROC loadlinedef(pathname)
  DEF handle=NIL,n,len,fail=0

  handle:=Open(pathname,MODE_OLDFILE)                             /* Open LineDef file      */
  IF handle
    IF linedef<>NIL                                               /* Free existing defs     */
      Dispose(linedef)
      linedef:=NIL
    ENDIF
    IF linedef=NIL THEN linedef:=New(SIZEOF linedef)              /* Allocat new Defs       */
    IF linedef=NIL THEN RETURN                                    /* If failed return       */
    len:=Read(handle,linedef,SIZEOF linedef)                      /* Read in LineDef        */
    IF len=SIZEOF linedef
      IF linedef.magic<>LINDEFMAGIC                               /* In-correct Type        */
        butrequest('WorldED','File is not correct type',' OK ')
        fail:=1
      ENDIF
    ELSE
      butrequest('WorldED','File is truncated',' OK ')            /* File Truncated         */
      fail:=1
    ENDIF
    Close(handle)
  ELSE
    butrequest('WorldED','Could not open file',' OK ')            /* Could not open         */
  ENDIF

  IF fail=1                                                       /* Free linedef if failed */
    Dispose(linedef)
    linedef:=NIL
  ENDIF
ENDPROC

/***************************************/
/**** Show LineDef Status Requester ****/
/***************************************/

PROC linedefstatus()
  DEF buffer[512]:STRING,temp[80]:STRING
  DEF n,di:PTR TO defitem

  IF linedef=NIL
    StrCopy(buffer,'No LineDef currently loaded')
  ELSE
    StrCopy(buffer,'LineDef:')
    StrAdd(buffer,linereq.file)
    StrAdd(buffer,'\n')
    StringF(temp,'Spacing:\d\n',linedef.space)
    StrAdd(buffer,temp)
    FOR n:=0 TO OBDFCOUNT-1
      IF linedef.obdfid[n]<>0
        di:=findobjdef(linedef.obdfid[n],NIL)
        IF di<>NIL
          StringF(temp,'\n\d> \s',n,di.name)
          StrAdd(buffer,temp)
        ENDIF
      ENDIF
    ENDFOR
  ENDIF
  butrequest('WorldED LineDef Info',buffer,' OK ')
ENDPROC

/**************************************/
/**** Load Map From Disk Requester ****/
/**************************************/

PROC loadrequest() HANDLE
  DEF ret,active=0,r1:requester,r2:requester
  DEF pathname[PATHLEN]:STRING

  active:=disableinput(r1,r2)                                     /* Disable Input    */
  ret:=AslRequest(filereq,[ASL_HAIL, 'Select Map to Load', NIL])  /* Do Requester     */
  IF ret                                                          /* If Selected file */
    StrCopy(pathname,filereq.drawer)                              /* Concat dir/file  */
    ret:=AddPart(pathname,filereq.file,PATHLEN)
    IF ret AND pathname[0]<>0 THEN loadmap(pathname)              /* Call Load Map    */
  ENDIF
EXCEPT DO
  IF active<>0 THEN enableinput(r1,r2)                            /* Re-Enable Input  */
  ReThrow()
ENDPROC

/*********************************/
/**** Load Specified Map File ****/
/*********************************/

PROC loadmap(pathname:PTR TO CHAR) HANDLE
  DEF wob=1,col=1,err=1,handle=NIL,buf=NIL,len,len1,head:header

  handle:=Open(pathname,MODE_OLDFILE)                             /* Open map to load       */
  IF handle<>NIL                                                                       
    len:=Read(handle,head,SIZEOF header)                          /* Read file header       */
    IF len:=SIZEOF header
      IF head.magic=WOBJMAGIC
        IF head.wobcount>0
          len:=Mul(head.wobcount,SIZEOF wobject)                  /* Read all main Wobjects */
          buf:=New(len)
          len1:=Read(handle,buf,len)
          IF len1=len
            wob:=0                                                /* Set success flag       */
            freewobjectlist()                                     /* Free existing wobjects */
            freecolarealist()                                     /* Free existing colareas */
            wobjecttolist(buf,head.wobcount)                      /* Convert to execlist    */
          ENDIF
        ENDIF
        IF head.colcount>0
          len:=Mul(head.colcount, SIZEOF colarea)                 /* Read all main colareas */
          IF buf THEN Dispose(buf)
          buf:=New(len)
          len1:=Read(handle,buf,len)
          IF len1=len
            col:=0                                                /* Set success flag       */
            IF wob THEN freewobjectlist()                         /* Free existing wobjects */
            freecolarealist()                                     /* Free existing colareas */
            colareatolist(buf,head.colcount)                      /* Convert to execlist    */
          ENDIF
        ENDIF
        IF (wob=0) OR (col=0)
          cleargadgets()                                          /* Clear GUI Gadgets      */
          stat.actwobj:=NIL                                       /* Clear active wobject   */
          stat.actcol:=NIL                                        /* Clear active colarea   */
          drawall()                                               /* Re-draw all items      */
          err:=0
        ENDIF
      ENDIF
    ENDIF
  ENDIF

  IF err THEN EasyRequestArgs(mapwin,[SIZEOF easystruct,0,'Warning',
                              'Failed to load file',' OK ']:easystruct,NIL,NIL)
EXCEPT DO
  IF buf    THEN Dispose(buf)
  IF handle THEN Close(handle)
  ReThrow()
ENDPROC

/****************************************************/
/**** Convert Loaded Buffer to wobitem Exec List ****/
/****************************************************/

PROC wobjecttolist(buf:PTR TO wobject,count)
  DEF n,wi:PTR TO wobitem

  FOR n:=0 TO count-1                                       /* Loop through raw Wobjects */
    wi:=New(SIZEOF wobitem)                                 /* Allocate RAM for WobItem  */
    newnode(wi.node,NIL,0,0)                                /* Initialise node structure */
    Enqueue(stat.woblist,wi.node)                           /* Add wobject to exec list  */

    wi.wob.x        :=buf[n].x                              /* Copy Wobject to List Item */
    wi.wob.y        :=buf[n].y
    wi.wob.height   :=buf[n].height
    wi.wob.heading  :=buf[n].heading
    wi.wob.size     :=buf[n].size
    wi.wob.radius   :=buf[n].radius
    wi.wob.speed    :=buf[n].speed
    wi.wob.obid     :=buf[n].obid
    wi.wob.objdef[0]:=buf[n].objdef[0]
    wi.wob.objdef[1]:=buf[n].objdef[1]
    wi.wob.objdef[2]:=buf[n].objdef[2]
    wi.wob.objdef[3]:=buf[n].objdef[3]
  ENDFOR
ENDPROC

/****************************************************/
/**** Convert Loaded Buffer to colarea Exec List ****/
/****************************************************/

PROC colareatolist(buf:PTR TO colarea,count)
  DEF n,ci:PTR TO colitem

  FOR n:=0 TO count-1
    ci:=New(SIZEOF colitem)
    newnode(ci.node,NIL,0,0)
    Enqueue(stat.collist,ci.node)

    ci.col.x    :=buf[n].x
    ci.col.y    :=buf[n].y
    ci.col.width:=buf[n].width
    ci.col.depth:=buf[n].depth
    ci.col.floor:=buf[n].floor
    ci.col.ceil :=buf[n].ceil
    ci.col.id   :=buf[n].id
  ENDFOR
ENDPROC

/***************************************/
/**** Free Contents Of Wobject List ****/
/***************************************/

PROC freewobjectlist()
  DEF wi:PTR TO wobitem,next

  wi:=stat.woblist.head
  WHILE wi.node.succ<>NIL
    next:=wi.node.succ
    Remove(wi.node)
    Dispose(wi)
    wi:=next
  ENDWHILE
ENDPROC

/***************************************/
/**** Free Contents of ColArea List ****/
/***************************************/

PROC freecolarealist()
  DEF ci:PTR TO colitem,next

  ci:=stat.collist.head
  WHILE ci.node.succ<>NIL
    next:=ci.node.succ
    Remove(ci.node)
    Dispose(ci)
    ci:=next
  ENDWHILE
ENDPROC

/*******************************************/
/**** Save Map Using ASL File Requester ****/
/*******************************************/

PROC saverequest() HANDLE
  DEF ret,active=0,r1:requester,r2:requester
  DEF pathname[PATHLEN]:STRING

  active:=disableinput(r1,r2)                                       /* Disable Input     */

  IF (stat.woblist.head.succ=NIL) AND (stat.collist.head.succ=NIL)  /* Anything to save? */
    EasyRequestArgs(mapwin,[SIZEOF easystruct,0,'Warning',
                           'Nothing to Save',' OK ']:easystruct,NIL,NIL)
  ELSE
    ret:=AslRequest(filereq,[ASL_HAIL, 'Select Save Name', NIL])    /* Do Save Requester */
    IF ret                                                          /* If Selected file  */
      StrCopy(pathname,filereq.drawer)                              /* Concat dir/file   */
      ret:=AddPart(pathname,filereq.file,PATHLEN)
      IF ret AND pathname[0]<>0 THEN savemap(pathname)              /* Call Save Map     */
    ENDIF
  ENDIF
EXCEPT DO
  IF active<>0 THEN enableinput(r1,r2)                            /* Re-Enable Input   */
  ReThrow()
ENDPROC

/*************************************/
/**** Save Wobjects Into Map File ****/
/*************************************/

PROC savemap(pathname)
  DEF len,wobcount=0,colcount=0,wobcount1=0,colcount1=0,ret,handle=NIL
  DEF head:header,wi:PTR TO wobitem,ci:PTR TO colitem

  len:=FileLength(pathname)                                       /* Check if file exists   */
  IF len<>-1                                                      /* If Y confirm overwrite */
    ret:=EasyRequestArgs(mapwin,[SIZEOF easystruct,0,'Warning',
                         'File exists - Over write ?','  OK  |CANCEL']:easystruct,
                         NIL,NIL)
    IF ret=0 THEN RETURN                                          /* Exit if cancelled      */
  ENDIF

  wi:=stat.woblist.head                                           /* Count current wobjects */
  WHILE wi.node.succ<>NIL
    wi:=wi.node.succ
    wobcount++
  ENDWHILE

  ci:=stat.collist.head                                           /* Count current colareas */
  WHILE ci.node.succ<>NIL
    ci:=ci.node.succ
    colcount++
  ENDWHILE

  handle:=Open(pathname,MODE_NEWFILE)                             /* Open new file          */
  IF handle<>NIL
    head.magic:=WOBJMAGIC                                         /* Setup file header      */
    head.wobcount:=wobcount
    head.colcount:=colcount
    len:=Write(handle,head,SIZEOF header)                         /* Write file header      */
    IF len=SIZEOF header                                          /* If header OK continue  */

      len:=SIZEOF wobject
      wi :=stat.woblist.head                                      /* Get ptr to 1st Wobject */
      WHILE (wi.node.succ<>NIL) AND (len=SIZEOF wobject)          /* Process all Wobjects   */
        IF wi.wob.radius<=0                                       /* Save non Col WObjects  */
          len:=Write(handle,wi.wob,SIZEOF wobject)                /* Write Current Wobject  */
          IF len=SIZEOF wobject THEN wobcount1++                  /* Increment saved count  */
        ENDIF
        wi:=wi.node.succ                                          /* Move onto next wobject */
      ENDWHILE

      len:=SIZEOF wobject
      wi :=stat.woblist.head                                      /* Get ptr to 1st Wobject */
      WHILE (wi.node.succ<>NIL) AND (len=SIZEOF wobject)          /* Process all Wobjects   */
        IF wi.wob.radius>0                                        /* Save Col WObjects      */
          len:=Write(handle,wi.wob,SIZEOF wobject)                /* Write Current Wobject  */
          IF len=SIZEOF wobject THEN wobcount1++                  /* Increment saved count  */
        ENDIF
        wi:=wi.node.succ                                          /* Move onto next wobject */
      ENDWHILE

      len:=SIZEOF colarea
      ci :=stat.collist.head                                      /* Get ptr to 1sr ColArea */
      WHILE (ci.node.succ<>NIL) AND (len=SIZEOF colarea)          /* Process all ColAreas   */
        len:=Write(handle,ci.col,SIZEOF colarea)                  /* Write Current ColArea  */
        EXIT (len<>SIZEOF colarea)                                /* If failed halt save    */
        colcount1++                                               /* Increment saved count  */
        ci:=ci.node.succ                                          /* Move onto next colarea */
      ENDWHILE

      IF wobcount=wobcount1 AND colcount=colcount1 THEN ret:=0    /* If all saved set O.K.  */
    ENDIF
  ENDIF

  IF handle<>NIL THEN Close(handle)                               /* Close file as required */

  IF ret THEN EasyRequestArgs(mapwin,[SIZEOF easystruct,0,'Warning',
                              'Save Failed !!!!!',' OK ']:easystruct,NIL,NIL)
ENDPROC

/***************************************/
/**** Pass EasyGUI event to EasyGUI ****/
/***************************************/

/* EasyGUI returns a small posative action value, i am using 0 as exit
           & other small integers currently only used for menu events.

   NOTE info must be set to non-zero in EasyGUI call as when set to 0
        some event handlers assume that they have been called from
        another handler so they limit their updates.
*/

PROC conevent()
   DEF ret
   ret:=guimessage(congh)
   IF (ret>=MNUSTART) AND (ret<=MNUEND) THEN menuhandler(ret)
ENDPROC ret

/**************************/
/**** EasyGUI handlers ****/
/**************************/

PROC modehdlr(info,newmode)
  stat.mode:=newmode
ENDPROC

/*** Handle Edit Type Change Events ***/

PROC typehdlr(info,newmode)
  disablegadgets(newmode)
ENDPROC

/*** Handle Zoom Integer Gadget Entry Events ***/

PROC zinthdlr(info,newzoom)
   DEF zoom=0
   IF newzoom > MAXZOOM THEN zoom:=MAXZOOM      /* Check against bounds */
   IF newzoom < MINZOOM THEN zoom:=MINZOOM
   IF zoom <> 0                                 /* If exceeds bounds reset to bound */
      newzoom:=zoom
      setinteger(congh,stat.zint,newzoom)
   ENDIF
   IF stat.zoom <> newzoom                      /* If zoom changed do related updates */
      stat.zoom:=newzoom
      setslide(congh,stat.zsld,newzoom)
      mxinthdlr(0,stat.x)                       /* Use co-ord gad handlers to check bounds */
      myinthdlr(0,stat.y)
      setscrollers()
   ENDIF
ENDPROC

/*** Handle Zoom Slider Events ***/

PROC zslidehdlr(info,newzoom)
   IF stat.zoom <> newzoom                      /* If zoom changed do related updates */
      stat.zoom:=newzoom
      setinteger(congh,stat.zint,newzoom)
      mxinthdlr(0,stat.x)                       /* Use co-ord gad handlers to check bounds */
      myinthdlr(0,stat.y)
      setscrollers()
   ENDIF
ENDPROC

/*** Handle Map X-Coord Gadget Events ***/

PROC mxinthdlr(info,newx)                       /*** if info=0 don't initiate redraw ***/
   DEF x=-1,max
   max:=MAXCOORD-Div(MAXCOORD,stat.zoom)        /* Calculate current maximum X-Coord */
   IF max > 0 THEN max--
   IF newx > max THEN x:=max                    /* Check X Co-ord against bounds */
   IF newx < 0   THEN x:=0
   IF x <> -1 THEN newx:=x                      /* If exceeds bounds reset to bound */
   IF (stat.x <> newx) OR (x <> -1)             /* If X Coord changed do related updates */
      stat.x:=newx
      setinteger(congh,stat.mxint,newx)
      IF info <> 0 THEN setscrollers()
   ENDIF
ENDPROC

/*** Handle Map Y-Coord Gadget Events ***/

PROC myinthdlr(info,newy)                       /*** if info=0 don't initiate redraw ***/
   DEF y=-1,max
   max:=MAXCOORD-Div(MAXCOORD,stat.zoom)        /* Calculate current maximum Y-Coord */
   IF max > 0 THEN max--
   IF newy > max THEN y:=max                    /* Check Y Co-ord against bounds */
   IF newy < 0   THEN y:=0
   IF y <> -1 THEN newy:=y                      /* If exceeded bounds change new y */
   IF (stat.y <> newy) OR (y <> -1)             /* If Y Coord changed do related updates */
      stat.y:=newy
      setinteger(congh,stat.myint,newy)
      IF info <> 0 THEN setscrollers()
   ENDIF
ENDPROC

/*** Width,Depth,Floor,Ceiling Gadget Event Handler ***/

PROC widinthdlr(info,new)
  stat.wid:=Bounds(new,MINWID,MAXWID)
  setinteger(congh,stat.widint,stat.wid)
ENDPROC

PROC depinthdlr(info,new)
  stat.dep:=Bounds(new,MINDEP,MAXDEP)
  setinteger(congh,stat.depint,stat.dep)
ENDPROC

PROC flrinthdlr(info,new)
  stat.flr:=Bounds(new,MINFLR,MAXFLR)
  IF stat.flr > stat.ceil THEN stat.flr:=stat.ceil
  setinteger(congh,stat.flrint,stat.flr)
ENDPROC

PROC ceilinthdlr(info,new)
  stat.ceil:=Bounds(new,MINCEIL,MAXCEIL)
  IF stat.ceil < stat.flr THEN stat.ceil:=stat.flr
  setinteger(congh,stat.ceilint,stat.ceil)
ENDPROC

/*** Altitude,Heading,Size,Radius & Type/ID Gadget Event Handlers ***/

PROC altinthdlr(info,new)
  stat.alt:=Bounds(new,MINALT,MAXALT)
  setinteger(congh,stat.altint,stat.alt)
ENDPROC

PROC headinthdlr(info,new)
  stat.head:=Bounds(new,MINHEAD,MAXHEAD)
  setinteger(congh,stat.headint,stat.head)
ENDPROC

PROC sizeinthdlr(info,new)
  stat.size:=Bounds(new,MINSIZE,MAXSIZE)
  setinteger(congh,stat.sizeint,stat.size)
ENDPROC

PROC cradinthdlr(info,new)
  stat.crad:=Bounds(new,MINCRAD,MAXCRAD)
  setinteger(congh,stat.cradint,stat.crad)
ENDPROC

PROC obidinthdlr(info,new)
  stat.obid:=Bounds(new,MINOBID,MAXOBID)
  setinteger(congh,stat.obidint,stat.obid)
ENDPROC

PROC passchkhdlr(info,checked)
  stat.pass:=checked
ENDPROC

/*** Handle Object World X-Coord Events ***/

PROC wxinthdlr(info,newx)
  stat.wx:=Bounds(newx,0,MAXCOORD-1)
  setinteger(congh,stat.wxint,stat.wx)
ENDPROC

/*** Handle Object World Y-Coors Events ***/

PROC wyinthdlr(info,newy)
  stat.wy:=Bounds(newy,0,MAXCOORD-1)
  setinteger(congh,stat.wyint,stat.wy)
ENDPROC

/*** Handle Object Definition 0 Gadgets ***/

PROC obdfstrhdlr0() IS setstr(congh,stat.obdfstr[0],os0)
PROC obdfbuthdlr0() IS selectobjdef(0)

/*** Handle Object Definition 1 Gadgets ***/

PROC obdfstrhdlr1() IS setstr(congh,stat.obdfstr[1],os1)
PROC obdfbuthdlr1() IS selectobjdef(1)

/*** Handle Object Definition 2 Gadgets ***/

PROC obdfstrhdlr2() IS setstr(congh,stat.obdfstr[2],os2)
PROC obdfbuthdlr2() IS selectobjdef(2)

/*** Handle Object Definition 3 Gadgets ***/

PROC obdfstrhdlr3() IS setstr(congh,stat.obdfstr[3],os3)
PROC obdfbuthdlr3() IS selectobjdef(3)

/*** Handle Update GUI to Active WObject Button ***/

PROC updbuthdlr()
  IF stat.edtype
    IF stat.actcol<>NIL
      coldraw(stat.actcol,1,0)                                    /* Un-draw current active */
      gui2col(stat.actcol)                                        /* Update & Re-draw it    */
    ELSE
      butrequest('Warning','No Col Box Selected\nCant Update !!!!',' OK ')
    ENDIF
  ELSE
    IF stat.obdfid[0]=NIL                                         /* Check ObjDef Settings  */
      butrequest('Warning','No Primary ObjDef Specified',' OK ')
      RETURN
    ENDIF
    IF stat.actwobj<>NIL
      wobjdraw(stat.actwobj,1,0)                                  /* Un-draw current active */
      gui2wobj(stat.actwobj)                                      /* Update & Re-draw it    */
    ELSE
      butrequest('Warning','No Object Selected\nCant Update !!!!',' OK ')
    ENDIF
  ENDIF
ENDPROC

/*** Handle Clear Current Active WObject Button ***/

/* If info is 0 the not called from GUI so requester no displayed */

PROC clrbuthdlr(info)
  DEF ret
  IF info
    ret:=butrequest('W.E. Request','Clear Gadgets ?','  OK  |CANCEL')
    IF ret=0 THEN RETURN
  ENDIF
  IF stat.edtype
    IF stat.actcol<>NIL
      setactcol(NIL)                                     /* Set Active to NIL (Un-draw old) */
      stat.actcol:=NIL                                   /* Clear active object pointers    */
    ENDIF
  ELSE
    IF stat.actwobj<>NIL
      setactwobj(NIL)                                    /* Set Active to NIL (Un-draw old) */
      stat.actwobj:=NIL                                  /* Clear active object pointers    */
    ENDIF
  ENDIF                                                                             
  cleargadgets()
ENDPROC

/***************************************************/
/*** Dissable Gadgets Based on Type Being Edited ***/
/***************************************************/

PROC disablegadgets(edtype)
  DEF gadg,n

  stat.edtype:=edtype
  gadg:=findgadget(congh,stat.widint)
  Gt_SetGadgetAttrsA(gadg, congh.wnd, NIL, [GA_DISABLED, edtype-1, NIL])
  gadg:=findgadget(congh,stat.depint)
  Gt_SetGadgetAttrsA(gadg, congh.wnd, NIL, [GA_DISABLED, edtype-1, NIL])
  gadg:=findgadget(congh,stat.flrint)
  Gt_SetGadgetAttrsA(gadg, congh.wnd, NIL, [GA_DISABLED, edtype-1, NIL])
  gadg:=findgadget(congh,stat.ceilint)
  Gt_SetGadgetAttrsA(gadg, congh.wnd, NIL, [GA_DISABLED, edtype-1, NIL])

  gadg:=findgadget(congh,stat.altint)
  Gt_SetGadgetAttrsA(gadg, congh.wnd, NIL, [GA_DISABLED, edtype, NIL])
  gadg:=findgadget(congh,stat.headint)
  Gt_SetGadgetAttrsA(gadg, congh.wnd, NIL, [GA_DISABLED, edtype, NIL])
  gadg:=findgadget(congh,stat.sizeint)
  Gt_SetGadgetAttrsA(gadg, congh.wnd, NIL, [GA_DISABLED, edtype, NIL])
  gadg:=findgadget(congh,stat.cradint)
  Gt_SetGadgetAttrsA(gadg, congh.wnd, NIL, [GA_DISABLED, edtype, NIL])
  gadg:=findgadget(congh,stat.passchk)
  Gt_SetGadgetAttrsA(gadg, congh.wnd, NIL, [GA_DISABLED, edtype, NIL])

  FOR n:=0 TO 3
    gadg:=findgadget(congh,stat.obdfstr[n])
    Gt_SetGadgetAttrsA(gadg, congh.wnd, NIL, [GA_DISABLED, edtype, NIL])
    gadg:=findgadget(congh,stat.obdfbut[n])
    Gt_SetGadgetAttrsA(gadg, congh.wnd, NIL, [GA_DISABLED, edtype, NIL])
  ENDFOR
ENDPROC

/********************************************/
/**** Clear Gadgets in GUI & Stat copies ****/
/********************************************/

PROC cleargadgets()
  stat.wx  :=0                                    /* Clear Interface Buffers & Gadgets */
  stat.wy  :=0

  IF stat.edtype
    stat.wid :=0
    stat.dep :=0
    stat.flr :=0
    stat.ceil:=0
  ELSE
    stat.alt :=0
    stat.head:=0
    stat.size:=512
    stat.crad:=0
    stat.obid:=0
    stat.pass:=FALSE
    stat.obdfid[0]:=0
    stat.obdfid[1]:=0
    stat.obdfid[2]:=0
    stat.obdfid[3]:=0
  ENDIF
  stat2gui()
ENDPROC

PROC stat2gui()
  setinteger(congh,stat.wxint,stat.wx)
  setinteger(congh,stat.wyint,stat.wy)

  IF stat.edtype
    setinteger(congh,stat.widint,stat.wid)
    setinteger(congh,stat.depint,stat.dep)
    setinteger(congh,stat.flrint,stat.flr)
    setinteger(congh,stat.ceilint,stat.ceil)
  ELSE
    setinteger(congh,stat.altint,stat.alt)
    setinteger(congh,stat.headint,stat.head)
    setinteger(congh,stat.sizeint,stat.size)
    setinteger(congh,stat.cradint,stat.crad)
    setinteger(congh,stat.obidint,stat.obid)
    setcheck(congh,stat.passchk,stat.pass)
    StrCopy(os0,'')
    setstr(congh,stat.obdfstr[0],os0)
    StrCopy(os1,'')
    setstr(congh,stat.obdfstr[1],os1)
    StrCopy(os2,'')
    setstr(congh,stat.obdfstr[2],os2)
    StrCopy(os3,'')
    setstr(congh,stat.obdfstr[3],os3)
  ENDIF
ENDPROC

/*************************************************************/
/*** Set Map Window Scroller Gadgets to Current GUI status ***/
/*************************************************************/

PROC setscrollers()
DEF xpot,ypot,bod,rng,x,y

   bod :=Div(MAXBODY+1,stat.zoom)-1                         /* Calculate Body Value */

   rng :=Shr(MAXCOORD,7)                                    /* Calculate co-ord range */
   rng :=rng-Div(rng,stat.zoom)                             /* Scaled down by >>7     */
   IF rng = 0 THEN rng:=1

   x:=Shl(stat.x,2)+1                                       /* Scale down co-ords >>7 and */
   y:=Shl(stat.y,2)+1                                       /* increase precision <<9     */

   xpot:=Div(x,rng)                                         /* Calc pot as fraction of 1024 */
   IF xpot = 0 THEN xpot:=1                                 /* Check against minimum        */
   xpot:=Shr(Mul((MAXBODY+1),xpot),9)-1                     /* Multiply pot val by fraction */

   ypot:=Div(y,rng)                                         /* Calc pot as fraction of 1024 */
   IF ypot = 0 THEN ypot:=1                                 /* Check against minimum        */
   ypot:=Shr(Mul((MAXBODY+1),ypot),9)-1                     /* Multiply pot val by fraction */

   NewModifyProp(hscrl,mapwin,NIL,hinfo.flags,xpot,0,bod,MAXBODY,1) /* Update Vert Scroller */
   NewModifyProp(vscrl,mapwin,NIL,vinfo.flags,0,ypot,MAXBODY,bod,1) /* Update Horz Scroller */

   drawall()                                                        /* Re-draw map window */
ENDPROC

/************************************************/
/*** Get Scroller Gadger Setting & Update GUI ***/
/************************************************/

PROC getvscroller()                                /*** Update Y Co-ord Gadget  ***/
   DEF rng,newp,newy
   newp:=Shr(UNSIGNED(vinfo.vertpot),6)            /* Get Current Pot Position    */
   rng :=MAXCOORD-Div(MAXCOORD,stat.zoom)+50       /* Calc Current Y Co-ord range */
   IF rng=0 THEN rng:=1
   newy:=Shr(Mul(rng,newp),10)                     /* Calc Current (new) Y Co-ord */
   IF newy<>stat.y                                 /* If y Position Changed do :- */
     myinthdlr(0,newy)                             /* Update Y Integer Gadget     */
     drawall()                                     /* Re-draw Map Window          */
   ENDIF
ENDPROC

PROC gethscroller()                                /*** Update X Co-ord Gadget  ***/
   DEF rng,newp,newx
   newp:=Shr(UNSIGNED(hinfo.horizpot),6)           /* Get Current Pot Position    */
   rng :=MAXCOORD-Div(MAXCOORD,stat.zoom)+50       /* Calc Current X Co-ord range */
   IF rng=0 THEN rng:=1
   newx:=Shr(Mul(rng,newp),10)                     /* Calc Current (new) Y Co-ord */
   IF newx<>stat.x                                 /* If x Position Changed do :- */
     mxinthdlr(0,newx)                             /* Update Y Integer Gadget     */
     drawall()                                     /* Re-draw Map Window          */
   ENDIF
ENDPROC

/**********************************************************/
/*** Block & Un-Block Messages to Map & Control Windows ***/
/**********************************************************/

/* Parameters - Pointers to two un-init'd requester structures

   disableinput returns 1 for setting active flag
   enableinput  returns 0 for clearing active flag
*/

PROC disableinput(req1,req2)
  InitRequester(req1)                 /* Initialise Requester Structures */
  InitRequester(req2)
  Request(req1,congh.wnd)             /* Block Input to Windows */
  Request(req2,mapwin)
ENDPROC 1

PROC enableinput(req1,req2)
  EndRequest(req2,mapwin)             /* Enable Input to Windows */
  EndRequest(req1,congh.wnd)
ENDPROC 0

/*************************************************/
/*** Pick ObjDef from list to apply to WObject ***/
/*************************************************/

/* Defnum = definition slot on WObject to be set */

PROC selectobjdef(defnum) HANDLE
  DEF active=0,ret=-1,req1:requester,req2:requester
  DEF defstr[16]:STRING,gh=NIL:PTR TO guihandle
  DEF work:guiwork

  work.str:=defstr                                /* Record E-String pointer */

  active:=disableinput(req1,req2)                 /* Disable Window Input */

  gh:=guiinit('Select Definition',                /* Build EasyGUI Interface */
              [ROWS,            
                [LISTV,{getdefsel},'Definitions',15,6,stat.deflist,1,0,0],
                [COLS,
                  [BUTTON,1,'  OK  '],
                  [BUTTON,2,'CLEAR'],
                  [BUTTON,0,'CANCEL']
                ]
              ],work,scrn)

  WHILE ret<0                                     /* Loop Until OK or Cancel Hit */
    Wait(gh.sig)                                  /* Wait for IDCMP message      */
    ret:=guimessage(gh)                           /* Pass message to EasyGUI     */
    IF defstr[0]<>0 THEN ret:=3                   /* If Str Select String Hit    */
  ENDWHILE

  IF gh THEN cleangui(gh)                         /* If open close down GUI */
  IF active THEN active:=enableinput(req1,req2)   /* Re-Enable Window Input */

  IF ret=2
    StrCopy(defstr,'')                            /* If Clear hit - Clear String */
    work.val:=0                                   /* Clear ID number of ObjDef   */
  ENDIF
  IF ret>1                                        /* If Item Selected or Cleared */
    stat.obdfid[defnum]:=work.val                 /* Store Selected objdef's ID  */
    SELECT defnum                                 /* Set required String Gadget  */
    CASE 0
      StrCopy(os0,defstr)
      setstr(congh,stat.obdfstr[0],os0)
    CASE 1
      StrCopy(os1,defstr)
      setstr(congh,stat.obdfstr[1],os1)
    CASE 2
      StrCopy(os2,defstr)
      setstr(congh,stat.obdfstr[2],os2)
    CASE 3
      StrCopy(os3,defstr)
      setstr(congh,stat.obdfstr[3],os3)
    ENDSELECT
  ENDIF
EXCEPT
  IF gh THEN cleangui(gh)                         /* If open close down GUI */
  IF active THEN enableinput(req1,req2)           /* Re-Enable Window Input */
  IF exception > 0 THEN Raise(exception)          /* On except call base exception handler */
  ReThrow()
ENDPROC

/*** Record Selected Definition name in Info E-String ***/

PROC getdefsel(info:PTR TO guiwork,selnum)
  DEF node:PTR TO ln,count=0
  DEF item:PTR TO defitem

  node:=stat.deflist.head                         /* Get pointer to 1st node  */
  WHILE (node.succ<>NIL) AND (count<selnum)       /* Loop until selected item */
    node:=node.succ                               /* Move to next node        */
    count++                                       /* Increment node counter   */
  ENDWHILE
  item:=node                                      /* Convert to defitem ptr   */
  StrCopy(info.str,node.name)                     /* Store name from node     */
  info.val:=item.id                               /* Store ID from node       */
ENDPROC

/*********************************/
/*** Display Warning Requester ***/
/*********************************/

PROC butrequest(title:PTR TO CHAR,text:PTR TO CHAR,gad:PTR TO CHAR) HANDLE
  DEF active=0,ret,req1:requester,req2:requester

  active:=disableinput(req1,req2)

  ret:=EasyRequestArgs(mapwin,
                      [SIZEOF easystruct,0,title,text,gad]:easystruct,
                      NIL,NIL)
EXCEPT DO
  IF active THEN enableinput(req1,req2)
  ReThrow()
ENDPROC ret

/***************************************************/
/*** Transfer Data Between WObject/ColArea & GUI ***/
/***************************************************/

PROC gui2wobj(wobj:PTR TO wobject)
  wobj.x      :=stat.wx
  wobj.y      :=stat.wy
  wobj.height :=stat.alt
  wobj.heading:=stat.head
  wobj.size   :=stat.size
  wobj.radius :=stat.crad
  IF stat.pass THEN wobj.radius:=0-wobj.radius
  wobj.obid   :=stat.obid
  wobj.objdef[0]:=stat.obdfid[0]
  wobj.objdef[1]:=stat.obdfid[1]
  wobj.objdef[2]:=stat.obdfid[2]
  wobj.objdef[3]:=stat.obdfid[3]
  setactwobj(wobj)
ENDPROC

PROC gui2col(col:PTR TO colarea)
  col.x    :=stat.wx
  col.y    :=stat.wy
  col.width:=stat.wid
  col.depth:=stat.dep
  col.floor:=stat.flr
  col.ceil :=stat.ceil
  col.id   :=stat.obid
  setactcol(col)
ENDPROC

PROC wobj2gui(wobj:PTR TO wobject)
  DEF n, di:PTR TO defitem

  stat.wx  :=wobj.x
  stat.wy  :=wobj.y
  stat.alt :=wobj.height
  stat.head:=wobj.heading
  stat.size:=wobj.size
  stat.crad:=wobj.radius
  stat.obid:=wobj.obid
  stat.pass:=FALSE

  IF wobj.radius<=0
    stat.pass:=TRUE
    stat.crad:=0-stat.crad
  ENDIF

  stat.obdfid[0]:=wobj.objdef[0]
  stat.obdfid[1]:=wobj.objdef[1]
  stat.obdfid[2]:=wobj.objdef[2]
  stat.obdfid[3]:=wobj.objdef[3]

  setinteger(congh,stat.wxint,stat.wx)
  setinteger(congh,stat.wyint,stat.wy)
  setinteger(congh,stat.altint,stat.alt)
  setinteger(congh,stat.headint,stat.head)
  setinteger(congh,stat.sizeint,stat.size)
  setinteger(congh,stat.cradint,stat.crad)
  setinteger(congh,stat.obidint,stat.obid)
  setcheck(congh,stat.passchk,stat.pass)

  IF stat.obdfid[0]<>0 THEN di:=findobjdef(stat.obdfid[0],NIL) ELSE di:=NIL
  IF di<>NIL THEN StrCopy(os0,di.name) ELSE StrCopy(os0,'')
  setstr(congh,stat.obdfstr[0],os0)

  IF stat.obdfid[1]<>0 THEN di:=findobjdef(stat.obdfid[1],NIL) ELSE di:=NIL
  IF di<>NIL THEN StrCopy(os1,di.name) ELSE StrCopy(os1,'')
  setstr(congh,stat.obdfstr[1],os1)

  IF stat.obdfid[2]<>0 THEN di:=findobjdef(stat.obdfid[2],NIL) ELSE di:=NIL
  IF di<>NIL THEN StrCopy(os2,di.name) ELSE StrCopy(os2,'')
  setstr(congh,stat.obdfstr[2],os2)

  IF stat.obdfid[3]<>0 THEN di:=findobjdef(stat.obdfid[3],NIL) ELSE di:=NIL
  IF di<>NIL THEN StrCopy(os3,di.name) ELSE StrCopy(os3,'')
  setstr(congh,stat.obdfstr[3],os3)

  setactwobj(wobj)
ENDPROC

PROC col2gui(col:PTR TO colarea)
  stat.wx  :=col.x
  stat.wy  :=col.y
  stat.wid :=col.width
  stat.dep :=col.depth
  stat.flr :=col.floor
  stat.ceil:=col.ceil
  stat.obid:=col.id

  setinteger(congh,stat.wxint,stat.wx)
  setinteger(congh,stat.wyint,stat.wy)
  setinteger(congh,stat.widint,stat.wid)
  setinteger(congh,stat.depint,stat.dep)
  setinteger(congh,stat.flrint,stat.flr)
  setinteger(congh,stat.ceilint,stat.ceil)
  setinteger(congh,stat.obidint,stat.obid)

  setactcol(col)
ENDPROC

/******************************************/
/*** Set Current Active WObject/ColArea ***/
/******************************************/

/* Pointer to WObject to make active or NIL if clearing active */

PROC setactwobj(newwobj:PTR TO wobject)
  DEF oldwobj:PTR TO wobject
  oldwobj:=stat.actwobj                     /* Get previous active wobject */
  stat.actwobj:=newwobj                     /* Set new active wobject      */
  SetStdRast(mapwin.rport)                  /* Setup for Mapwin drawing    */
  IF oldwobj<>NIL THEN wobjdraw(oldwobj,0,0)  /* Redraw affect wobjects      */
  IF newwobj<>NIL THEN wobjdraw(newwobj,0,0)
ENDPROC

/* Pointer to ColArea to make active of NIL if clearing active */ 

PROC setactcol(newcol:PTR TO colarea)
  DEF oldcol:PTR TO colarea
  oldcol:=stat.actcol
  stat.actcol:=newcol
  SetStdRast(mapwin.rport)
  IF oldcol<>NIL THEN coldraw(oldcol,0,0)
  IF newcol<>NIL THEN coldraw(newcol,0,0)
ENDPROC

/***********************************************/
/*** Find Object Definition using Name or ID ***/
/***********************************************/

/* If fill in one of params and leave other as NIL
   Returns pointer to defitem or NIL
*/

PROC findobjdef(id,str)
  DEF di:PTR TO defitem,ret=NIL
  di:=stat.deflist
  WHILE di.node.succ<>NIL
    IF (id<>0) AND (id=di.id) THEN ret:=di
    IF (str[0]<>0) AND StrCmp(str,di.name) THEN ret:=di
    di:=di.node.succ
  ENDWHILE
ENDPROC ret

/******************************************/
/*** Find Wobject Base on World Co-ords ***/
/******************************************/

/* Parameters - world x,y co-ords
   Returns    - Pointer to 1st wobject found to be under these co-ords
                otherwise NIL returned.
*/

PROC findwobjcoord(x,y)
  DEF x1,x2,y1,y2,sz,wi:PTR TO wobitem

  wi:=stat.woblist.head                                                /* Find First Item   */
  WHILE wi.node.succ<>NIL                                              /* If not blank      */
    sz:=wi.wob.radius                                                  /* Get size of item  */
    IF sz<0 THEN sz:=0-sz                                              /* If negative flip+ */
    IF sz<4 THEN sz:=4                                                 /* Bound to minimum  */
    x1:=wi.wob.x-sz                                                    /* Calculate hot box */
    x2:=wi.wob.x+sz
    y1:=wi.wob.y-sz
    y2:=wi.wob.y+sz
    IF (x>=x1) AND (x<=x2) AND (y>=y1) AND (y<=y2) THEN RETURN wi.wob  /* return wob if hit */
    wi:=wi.node.succ                                                   /* Get next item     */
  ENDWHILE
ENDPROC NIL

/*******************************************/
/*** Find ColArea Based on World Co-ords ***/
/*******************************************/

/* Parameters - world x,y co-ords
   Returns    - Pointer to 1st colarea found to be under these co-ords
                otherwise NIL returned.
*/

PROC findcolcoord(x,y)
  DEF x1,y1,x2,y2,col:PTR TO colitem

  col:=stat.collist.head                                               /* Find First Item   */
  WHILE col.node.succ<>NIL                                             /* If not  blank     */
    x1:=col.col.x                                                      /* Get co-ords       */
    y1:=col.col.y
    x2:=x1+col.col.width
    y2:=y1+col.col.depth
    IF (x>=x1) AND (x<=x2) AND (y>=y1) AND (y<=y2) THEN RETURN col.col /* return col if hit */
    col:=col.node.succ                                                 /* get next item     */
  ENDWHILE
ENDPROC NIL

/*************************************/
/*** Draw in wobject(s)/colarea(s) ***/
/*************************************/

/* NOTE - Shifts are to maintain precision */

PROC drawall()
  DEF pixdiv
  DEF wob:PTR TO wobitem
  DEF col:PTR TO colitem
  SetStdRast(mapwin.rport)                            /* Setup for Mapwin drawing   */
  Box(0,0,MAPWINSIZE,MAPWINSIZE,0)                    /* Clear Map Window           */

  pixdiv:=Div(Div(Shl(MAXCOORD,9),stat.zoom),MAPWINSIZE)

  griddraw(pixdiv)                                    /* Draw in Grid               */

  wob:=stat.woblist.head                              /* Get Start of wobitem List  */
  WHILE wob.node.succ<>NIL                            /* If Valid wobitem           */
    wobjdraw(wob.wob,0,pixdiv)                        /* Draw it in Map Window      */
    wob.select:=0                                     /* Clear group selection info */
    wob:=wob.node.succ                                /* Get Next wobitem           */
  ENDWHILE

  col:=stat.collist.head                              /* Get Start of colitem list  */
  WHILE col.node.succ<>NIL                            /* If Valid colitem           */
    coldraw(col.col,0,pixdiv)                         /* Draw it in mapwindow       */
    col.select:=0                                     /* Clear group selection info */
    col:=col.node.succ                                /* Get Next colitem           */
  ENDWHILE
ENDPROC


PROC griddraw(pixdiv)
  DEF sx,sy,scrx,scry

  sx:=Shl(Shr(stat.x,8)+1,8)
  sy:=Shl(Shr(stat.y,8)+1,8)

  scrx:=Div(Shl((sx - stat.x),9),pixdiv)
  WHILE scrx < MAPWINSIZE
    Line(scrx,0,scrx,MAPWINSIZE-1,GREEN)
    sx:=sx+256
    scrx:=Div(Shl((sx - stat.x),9),pixdiv)
  ENDWHILE

  scry:=Div(Shl((sy - stat.y),9),pixdiv)
  WHILE scry < MAPWINSIZE
    Line(0,scry,MAPWINSIZE-1,scry,GREEN)
    sy:=sy+256
    scry:=Div(Shl((sy - stat.y),9),pixdiv)
  ENDWHILE

ENDPROC


/* If colovr is non zero then colour is over ridden to col-1
   otherwise is based on attributes of wobject/colarea

   If pixdiv is set this value is used instead of calculating
   it again. Speeds up drawall().
*/

PROC wobjdraw(wobj:PTR TO wobject,colovr,pixdiv)
  DEF x,y,t,s,x1,y1,x2,y2,col,sz

  IF wobj.radius<=0                                   /* Base map size & Color on radius */
    col:=WHITE
    sz:=0-wobj.radius
  ELSE
    col:=BLACK
    sz:=wobj.radius
  ENDIF
  IF sz<4 THEN sz:=4

  IF wobj=stat.actwobj THEN col:=RED                  /* If Active Object Draw Red */
  IF colovr>0 THEN col:=colovr-1

  IF pixdiv<>0
    t:=pixdiv                                         /* Use passed Pixel Divisor  */
  ELSE
    t:=Div(Div(Shl(MAXCOORD,9),stat.zoom),MAPWINSIZE) /* Calculate Pixel Divisor   */
  ENDIF

  x:=Div(Shl((wobj.x - stat.x),9),t)                  /* Calc Window X,Y Co-ords   */
  y:=Div(Shl((wobj.y - stat.y),9),t)
  s:=Div(Shl(sz,9),t)                                 /* Calc size from C-Radius   */
  IF s>MAPWINSIZE THEN s:=MAPWINSIZE                  /* Limit s to MAPWINSIZE     */
  x2:=x+s                                             /* Calculate Box Dimensions  */
  y2:=y+s
  x1:=x-s
  y1:=y-s
  IF (x2>=0) AND (y2>=0) AND (x1<MAPWINSIZE) AND (y1<MAPWINSIZE) /* If in window draw it */
    Line(x1,y1,x2,y2,col)
    Line(x1,y2,x2,y1,col)
  ENDIF
ENDPROC

PROC coldraw(col:PTR TO colarea,colovr,pixdiv)
  DEF t,x1,y1,x2,y2,colr

  colr:=BLUE
  IF col=stat.actcol THEN colr:=RED                   /* If Active ColArea Draw Red */
  IF colovr>0 THEN colr:=colovr-1

  x1:=col.x
  y1:=col.y
  x2:=x1+col.width
  y2:=y1+col.depth

  IF pixdiv<>0
    t:=pixdiv                                         /* Use passed Pixel Divisor */
  ELSE
    t:=Div(Div(Shl(MAXCOORD,9),stat.zoom),MAPWINSIZE) /* Calculate Pixel Divisor  */
  ENDIF

  x1:=Div(Shl((x1 - stat.x),9),t)                     /* Calc Window X,Y Co-ords  */
  y1:=Div(Shl((y1 - stat.y),9),t)
  x2:=Div(Shl((x2 - stat.x),9),t)
  y2:=Div(Shl((y2 - stat.y),9),t)

  Line(x1,y1,x2,y1,colr)
  Line(x2,y1,x2,y2,colr)
  Line(x2,y2,x1,y2,colr)
  Line(x1,y2,x1,y1,colr)
ENDPROC

/**********************************/
/**** Select multiple wobjects ****/
/**********************************/

/* Sets selected flag on all wobjects within
   world co-ord rectangle specified

   Re-draws selected display to reflect selection status.

   To clear group select info call drawall()

   NOTE - Returns number of selected items
*/

PROC groupselectwob(x1,y1,x2,y2)
  DEF wob:PTR TO wobitem,x,y,oldact,count

  IF x2<x1                                            /* Ensure coords ordered O.K.*/
    x:=x2
    x2:=x1
    x1:=x
  ENDIF
  IF y2<y1
    y:=y2
    y2:=y1
    y1:=y
  ENDIF
  oldact:=stat.actwobj                                /* Store current active obj  */
  stat.actwobj:=NIL                                   /* Clear current active obj  */
  count:=0                                            /* Initialise selected count */
  wob:=stat.woblist.head                              /* Get Start of wobitem List */
  WHILE wob.node.succ<>NIL                            /* If Valid wobitem          */
    x:=wob.wob.x
    y:=wob.wob.y
    IF (x>=x1) AND (x<=x2) AND (y>=y1) AND (y<=y2)    /* If in rectangle select    */
      wob.select:=1
      wobjdraw(wob.wob,RED+1,0)
      count:=count+1
    ELSE                                              /* Otherwise de-select       */
      wob.select:=0
      wobjdraw(wob.wob,0,0)
    ENDIF
    wob:=wob.node.succ                                /* Get Next wobitem          */
  ENDWHILE
  stat.actwobj:=oldact                                /* Restore current active obj*/
ENDPROC count

/*****************************************/
/**** Select Multiple Collision Boxes ****/
/*****************************************/

/* Returns number of selected collision boxes */

PROC groupselectclb(x1,y1,x2,y2)
  DEF col:PTR TO colitem,x3,y3,x4,y4,oldact,count

  IF x2<x1                                              /* Ensure coords ordered O.K.*/
    x3:=x2
    x2:=x1
    x1:=x3
  ENDIF
  IF y2<y1
    y3:=y2
    y2:=y1
    y1:=y3
  ENDIF
  oldact:=stat.actcol                                   /* Store current active colbox */
  stat.actcol:=NIL                                      /* Clear current active colbox */
  count:=0                                              /* Initialise selected count   */
  col:=stat.collist.head                                /* Get Start of colitem List   */
  WHILE col.node.succ<>NIL                              /* If Valid colitem            */
    x3:=col.col.x
    y3:=col.col.y
    x4:=x3+col.col.width
    y4:=y3+col.col.depth
    IF (x3>=x1) AND (x4<=x2) AND (y3>=y1) AND (y4<=y2)  /* If in rectangle select      */
      col.select:=1
      coldraw(col.col,RED+1,0)
      count:=count+1
    ELSE                                                /* Otherwise de-select         */
      col.select:=0
      coldraw(col.col,0,0)
    ENDIF
    col:=col.node.succ                                  /* Get Next colitem            */
  ENDWHILE
  stat.actcol:=oldact                                   /* Restore current active cbox */
ENDPROC count


