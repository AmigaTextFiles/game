/******************************************/
/*                                        */
/* Initiative Pool Manager  v1.00 (Amiga) */
/*                                        */
/*   Copyright (c) J.Gregory 21/04/1998   */
/*                                        */
/*    Uses Text plugin by Ali Graham      */
/*                                        */
/******************************************/

/* The text plugin has been modified to allow contents
   to be changed after creation.  Thr initial contents
   must however be the widest intended content. Hence
   all of the 'MMM's in the source below.
*/

OPT PREPROCESS, OSVERSION=37

MODULE 'tools/easygui',
       'tools/constructors',
       'easyplugins/text2',
       'plugins/ticker',
       'exec/nodes',
       'exec/lists',
       'graphics/text',
       'intuition/intuition',
       'dos/dos',
       'utility',
       'utility/tagitem',
       'diskfont'

/*****************/
/*** Constants ***/
/*****************/

CONST MAX_UNITS=400
ENUM  UNIT_WAIT,UNIT_MOVE,UNIT_DEAD

/*****************************/
/*** Structure Definitions ***/
/*****************************/

OBJECT unitdata
  status
  id
  flag
  prefix[2]:ARRAY OF CHAR
ENDOBJECT

OBJECT unititem                     /*** Exec List Version of units array  ***/
  node:ln,                          /*            Exec list node             */
  id,                               /*          Array index number           */
  name[16]:ARRAY OF CHAR            /*         Text Details String           */
ENDOBJECT

/*******************/
/*** Global Data ***/
/*******************/

DEF mgh=NIL:PTR TO guihandle
DEF text_a:PTR TO text_plugin
DEF totunits,current,lastn=-1,log=TRUE
DEF unitlist=NIL:PTR TO lh
DEF last[10]:STRING,dispstr[80]:STRING
DEF units[MAX_UNITS]:ARRAY OF unitdata

/*********************/
/*** Main Function ***/
/*********************/

PROC main() HANDLE
    DEF tim =NIL:PTR TO ticker
    DEF ta  =NIL:PTR TO textattr
    DEF font=NIL:PTR TO LONG
    DEF ret

    IF (utilitybase :=OpenLibrary('utility.library', 37))=NIL THEN Raise("utlb")
    IF (diskfontbase:=OpenLibrary('diskfont.library',37))=NIL THEN Raise("dlib")

    ta:=['CGTriumvirate.font', 50, 0, 0]:textattr
    font:=OpenDiskFont(ta)
    IF font=NIL THEN Raise("font")

    IF readdata() THEN Raise("load")

    NEW tim
    NEW text_a.text([PLA_Text_Text, 'MMMMMMMMMMMMM',
                     PLA_Text_Justification, PLV_Text_JustifyCenter,
                     PLA_Text_Font, ta,
                     TAG_DONE])

    mgh:=guiinitA('Initiative Pool Manager',
             [ROWS,
                 [PLUGIN, 1, text_a],
                 [BAR],
                 [COLS,
                    [CHECK,   {logtog},    'Log',log,TRUE],
                    [SBUTTON, {nexthit},   '  Next  '],
                    [SBUTTON, {unitslist}, ' Status '],
                    [SBUTTON, 0,           '  Quit  ']
                    ],
                 [PLUGIN, {tiktoc}, tim]
                 ])

    text_a.set(PLA_Text_Text, 'Hit Next')

    ret:=1
    WHILE ret<>0
      Wait(mgh.sig)
      ret:=guimessage(mgh)
      IF ret=0                                                   /* Verify Exit */
        ret:=butrequest('InitPool Request','Quit, Are you sure ?',' Quit |Cancel')
        IF ret=0 THEN ret:=-1 ELSE ret:=0
      ENDIF
    ENDWHILE

EXCEPT DO
    SELECT exception
      CASE "load"
        WriteF('Units data file load failure\n')
      CASE "font"
        WriteF('CGTriumvirate font open failed\n')
      CASE "utlb"
        WriteF('Utility.library open failure\n')
      CASE "dlib"
        WriteF('Diskfont.library open failure\n')
    ENDSELECT

    IF mgh<>NIL THEN cleangui(mgh)

    END text_a
    END tim

    IF font THEN CloseFont(font)

    IF diskfontbase THEN CloseLibrary(diskfontbase)
    IF utilitybase  THEN CloseLibrary(utilitybase)
ENDPROC


/*********************************/
/*** Display Warning Requester ***/
/*********************************/

/* Require intuition/intuition.m */

PROC butrequest(title:PTR TO CHAR,text:PTR TO CHAR,gad:PTR TO CHAR) HANDLE
  DEF ret,active=0

  blockwin(mgh)
  active:=1

  ret:=EasyRequestArgs(mgh.wnd,[SIZEOF easystruct,0,title,text,gad]:easystruct,
                       NIL,NIL)
EXCEPT DO
  IF active<>0 THEN unblockwin(mgh)
ENDPROC ret

/*****************************/
/*** Read Config Data File ***/
/*****************************/

/* Returns 0 on success */

PROC readdata() HANDLE
  DEF handle=NIL,str,len,err=0
  DEF buffer[128]:ARRAY OF CHAR

  str:=1
  current:=totunits:=0
  last[0]:=0

  handle:=Open('InitPool.txt',MODE_OLDFILE)
  IF handle=NIL THEN Raise("open")

  WHILE str<>NIL
    str:=Fgets(handle,buffer,128)
    IF str<>NIL
      len:=StrLen(str)
      IF (len>=10) AND (str[0]<>";")
        len:=addunits(str)
        IF len<>0
          str:=NIL
          err:=-1
        ENDIF
      ENDIF
    ENDIF
  ENDWHILE

  totunits:=current;
  IF totunits<1 THEN err:=-1
EXCEPT DO
  IF handle<>NIL THEN Close(handle);
ENDPROC err

/**********************************************/
/*** Convert data file line to unit entries ***/
/**********************************************/

/* Returns 0 on success */

PROC addunits(str)
  DEF start,end,n,flag

  str[2]:=0
  str[5]:=0
  str[8]:=0
  start:=Val(str+3,NIL)
  end  :=Val(str+6,NIL)

  IF start<1 THEN RETURN -1
  IF end<start THEN RETURN -1;

  IF (str[9]="Y") OR (str[9]="y") THEN flag:=1 ELSE flag:=0;

  FOR n:=start TO end
    units[current].status   := UNIT_WAIT
    units[current].prefix[0]:= str[0]
    units[current].prefix[1]:= str[1]
    units[current].id       := n
    units[current].flag     := flag
    current:=current+1
    IF current>MAX_UNITS THEN RETURN -1
  ENDFOR

ENDPROC 0


/*********************************/
/*** EasyGUI action procedures ***/
/*********************************/


/****************************/
/*** Handle Ticker Action ***/
/****************************/

PROC tiktoc()
  current:=current+1
  IF current>=totunits THEN current:=0
ENDPROC

/******************************/
/*** Toggle Log Writes Flag ***/
/******************************/

PROC logtog()
  IF log=TRUE THEN log:=FALSE ELSE log:=TRUE
ENDPROC

/******************************/
/*** Handle Next Button Hit ***/
/******************************/

PROC nexthit()
  DEF n,flg,count=0
  DEF str1[10]:STRING

  REPEAT
    count:=count+1

    current:=current+1
    IF current>=totunits THEN current:=0

    IF count>totunits
      /*** End of Round - Set Moved to Waiting ***/
      butrequest('InitPool Request','End of round !!!!','  OK  ')
      flg:=0
      FOR n:=0 TO totunits-1
        IF units[n].status=UNIT_MOVE
          units[n].status:=UNIT_WAIT
          flg:=1
        ENDIF
      ENDFOR
      /*** Handle no remaining live elements ***/
      IF flg=0
        butrequest('InitPool Request','All dead - starting again !!!!','  OK  ')
        FOR n:=0 TO totunits-1
          units[n].status:=UNIT_WAIT
        ENDFOR
      ENDIF
      last[0]:=0
      count:=0
    ENDIF
  UNTIL units[current].status=UNIT_WAIT

  /** Set unit to moved & build ID string for it **/

  units[current].status:=UNIT_MOVE
  n:=current
  IF units[n].flag=0
    StringF(str1,'\c\c\z\d[2]',units[n].prefix[0],units[n].prefix[1],units[n].id)
  ELSE
    StringF(str1,'\c\c \c',units[n].prefix[0],units[n].prefix[1],units[n].id+64)
  ENDIF

  /** Build output string based on if prior move or not **/

  IF last[0]=0
    StringF(dispstr,'Move:\s',str1)
  ELSE
    StringF(dispstr,'Last:\s Move:\s',last,str1)
  ENDIF

  /** Store current ID string as prior string & update display **/

  StrCopy(last,str1)
  lastn:=current
  IF log THEN WriteF('\s\n',dispstr)
  text_a.set(PLA_Text_Text, dispstr)

ENDPROC


/***********************/
/*** Show Units List ***/
/***********************/

PROC unitslist() HANDLE
  DEF active=0,ret=-1
  DEF gh=NIL:PTR TO guihandle


  blockwin(mgh)                                    /* Disable Window Input */
  active:=1

  buildunitlist()                                  /* Build elements list */

  gh:=guiinitA('InitPool',                         /* Build EasyGUI Interface */
              [ROWS,
                [LISTV,{unitsel},'Elements List',10,8,unitlist,FALSE,TRUE,NIL],
                [COLS,
                  [SBUTTON,0,' DONE ']
                ]
              ],NIL)

  WHILE ret<>0                                    /* Loop Until OK or Cancel Hit */
    Wait(gh.sig)                                  /* Wait for IDCMP message      */
    ret:=guimessage(gh)                           /* Pass message to EasyGUI     */
  ENDWHILE

EXCEPT DO
  IF gh THEN cleangui(gh)                         /* If open close down GUI */
  IF unitlist THEN freeunitlist()                 /* Free units list */
  IF active THEN unblockwin(mgh)                   /* Re-Enable Window Input */
ENDPROC

/**********************************/
/*** Handle List Item Selection ***/
/**********************************/

PROC unitsel(qual,data,info,sel)
  DEF str[10]:STRING,str1[80]:STRING
  DEF flags[3]:ARRAY OF LONG
  DEF ret,oldstate,newstate

  info:=info  /* Stop silly not used messages */
  qual:=qual
  data:=data

  flags[0]:='WAIT'
  flags[1]:='MOVE'
  flags[2]:='DEAD'

  oldstate:=units[sel].status
  oldstate:=flags[oldstate]
     
  IF units[sel].flag=1
    StringF(str,'\c\c \c',units[sel].prefix[0],units[sel].prefix[1],units[sel].id+64)
  ELSE
    StringF(str,'\c\c\z\d[2]',units[sel].prefix[0],units[sel].prefix[1],units[sel].id)
  ENDIF
  StringF(str1,'Change \s from \s to:',str,oldstate)
  
  ret:=butrequest('InitPool Request',str1,' Dead |Waiting| Moved |Cancel')
  SELECT ret
    CASE 0
      newstate:=-1
    CASE 1
      newstate:=UNIT_DEAD
    CASE 2
      newstate:=UNIT_WAIT
    CASE 3
      newstate:=UNIT_MOVE
  ENDSELECT

  IF newstate>=0
    units[sel].status:=newstate
    newstate:=flags[newstate]
    IF log=TRUE THEN WriteF('\s=\s from \s\n',str,newstate,oldstate)
    quitgui()
  ENDIF

ENDPROC


/*******************************************************/
/*** Convert ObjDef Array to ExecList and Free Array ***/
/*******************************************************/

PROC buildunitlist()
  DEF n,m,state,ui:PTR TO unititem
  DEF str[16]:STRING,flags[3]:ARRAY OF LONG

  flags[0]:='WAIT'
  flags[1]:='MOVE'
  flags[2]:='DEAD'

  IF unitlist<>NIL THEN freeunitlist()
  unitlist:=newlist()

  FOR n:=0 TO totunits-1                       /* Loop throgh units array        */
    ui:=New(SIZEOF unititem)                   /* Alloc RAM for new item node    */

    state:=units[n].status
    state:=flags[state]
    IF units[n].flag<>1                                /* Build Unit info string */
      StringF(str,'\s     \c\c\z\d[2]',state,
                                   units[n].prefix[0],
                                   units[n].prefix[1],
                                   units[n].id)
    ELSE
      StringF(str,'\s     \c\c \c',state,
                               units[n].prefix[0],
                               units[n].prefix[1],
                               units[n].id+64)
    ENDIF

    m:=0                                             /* Copy info string to node */
    WHILE str[m]<>0
      ui.name[m]:=str[m]
      m:=m+1
    ENDWHILE
    ui.name[m]:=0

    ui.id:=n                                           /* Copy index ti id filed */
    newnode(ui.node,ui.name,0,0)                  /* Initialise unit item's node */
    Enqueue(unitlist,ui.node)                    /* Add node to current list end */
  ENDFOR

ENDPROC

/*******************************************/
/*** Free Contents of unititem Exec List ***/
/*******************************************/

PROC freeunitlist()
  DEF ui:PTR TO unititem,next:PTR TO unititem

  ui:=unitlist.head
  WHILE ui.node.succ<>NIL
    next:=ui.node.succ
    Remove(ui.node)
    Dispose(ui)
    ui:=next
  ENDWHILE

  unitlist:=NIL
ENDPROC


