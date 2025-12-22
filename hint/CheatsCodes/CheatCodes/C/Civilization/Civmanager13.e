/* Monitors a civilisation save in RAM:, and copies it to it's home
   path when it is saved by civ. */

/* Version 1.1 changes:

 * Now reads initial directory from tooltypes

 * Makes civassigns from tooltypes (hackily by executing c:ASSIGN !)

 * No need for a script

 * First shift selected, or toolmanager dropped file is used as

   the game save file!

 * File includes a version string

*/

/* Version 1.2 Changes 

 * Now a commodity - Can be quit/supsended for CX_Exchange

 * Gives Option To Delete the files on exit

 * Compatabile with version command

 * Creates Icons For Saved Files

*/

/* Version 1.3 Changes

 * Now creates assigns internally without executing C:Assign

*/

OPT OSVERSION=37

MODULE 'ReqTools','libraries/reqtools','utility/tagitem','Dos/Dos',
       'dos/notify','workbench/startup','workbench/workbench','icon',
       'commodities','libraries/commodities','exec/ports'


CONST SVEFILESIZE=37869
CONST MAPFILESIZE=64000
CONST RW_ERR=-1


ENUM ER_NONE,ER_OPEN,ER_READ,ER_WRITE,ER_NOSIG,ER_MEM,ER_NONOTIFY,ER_CIVLOAD,
     ER_OPENLIB,ER_MSGPORT,ER_BROKER,ER_ASSIGN,ER_FONT,ER_LOCK

RAISE ER_OPEN IF Open()=NIL
RAISE ER_READ IF Read()=RW_ERR
RAISE ER_WRITE IF Write()=RW_ERR
RAISE ER_MEM IF New()=NIL
RAISE ER_NOSIG IF AllocSignal()=RW_ERR
RAISE ER_NONOTIFY IF StartNotify()=0
RAISE ER_CIVLOAD IF Execute()=0
RAISE ER_OPENLIB IF OpenLibrary()=0
RAISE ER_MSGPORT IF CreateMsgPort()=0
RAISE ER_BROKER IF CxBroker()=0
RAISE ER_ASSIGN IF AssignLock()=0
RAISE ER_FONT IF AssignAdd()=0
RAISE ER_LOCK IF Lock()=0

DEF quitstring[30]:STRING
DEF filename[256]:STRING
DEF defdir[256]:STRING
DEF civdir[256]:STRING
DEF fontdir[256]:STRING

/* Commodity Stuff */

DEF broker:PTR TO newbroker
DEF messport:PTR TO mp
DEF brokerobj=0,cxsigbit


PROC main() HANDLE

  DEF iconfile,iconbuf,buflen=0		/* Icon IO */
  DEF iconname[256]:STRING
  DEF quitprog,sig,active		/* program */
  DEF msg,msgtype,msgid			/* commodity */
  DEF notifysig,notifysigbit,task	/* notify */
  DEF nreq:PTR TO notifyrequest
  DEF lck

  /* Set the default AMOS_System path if no arguments */

  quitstring := 'Quit CivMangaer'
  cxbase := OpenLibrary('commodities.library',37)

  /* Initiailize as a commodity */

  broker:=[NB_VERSION,0,'CivManager','Civilization Game-Save Manager V1.2','©1994 Paul Hickman (ph@doc.ic.ac.uk)',
           NBU_UNIQUE OR NBU_NOTIFY,0,0,0,0]:newbroker
  messport := CreateMsgPort()
  broker.port := messport
  brokerobj := CxBroker(broker,0)
  cxsigbit := Shl(1,messport.sigbit)
  ActivateCxObj(brokerobj,1)
  
  /* Locate File */

  getwbargs()

  /* Make civilisations assigns for it */

  lck := Lock(civdir,ACCESS_READ)
  AssignLock('CIV1',lck)
  lck := Lock(civdir,ACCESS_READ)
  AssignLock('CIV2',lck)
  lck := Lock(civdir,ACCESS_READ)
  AssignLock('CIV3',lck)
  lck := Lock(civdir,ACCESS_READ)
  AssignLock('CIV4',lck)
 
  IF fontdir=''
    StrCopy(fontdir,civdir,ALL)
    StrAdd(fontdir,'/fonts',ALL)
  ENDIF

  lck := Lock(fontdir,ACCESS_READ)
  AssignAdd('FONTS',lck) 

  /* Now load file, if it exists */

  IF FileLength(filename) <> -1
    IF FileLength(filename) = 101869
      copytoram(filename)
    ELSE
      request('\s is not a CivManager Save File',quitstring,NIL)
      CleanUp(20)
    ENDIF
  ENDIF

  /* Load Icon File */

  StrCopy(iconname,civdir,ALL)
  StrAdd(iconname,'/DefSaveIcon.info',ALL)
  IF (buflen := FileLength(iconname)) <> -1
    iconfile := Open(iconname,MODE_OLDFILE)
    iconbuf := New(buflen)
    Read(iconfile,iconbuf,buflen)
    Close(iconfile)
  ENDIF
  StrCopy(iconname,filename,ALL)
  StrAdd(iconname,'.info',ALL)

  /* Setup notifier */

  nreq:=New(SIZEOF notifyrequest)     /* memory is cleared */
  notifysigbit:=AllocSignal(-1)       /* we want to be signalled */
  task:=FindTask(0)
  nreq.name:='RAM:CIVIL0.SVE'         /* fill in structure */
  nreq.flags:=NRF_SEND_SIGNAL
  nreq.port:=task                     /* union port/task */
  nreq.signalnum:=notifysigbit

  notifysig:=Shl(1,notifysigbit)
  active:=TRUE
  StartNotify(nreq)

  /* Load Civilization */

  Execute('run CIV1:CivilizationAGA',NIL,NIL)

  /* Monitor File Loop */

  REPEAT

    /* Wait for civilisation to	save the game, or a commodities
       signal to occur */

    sig := Wait(notifysig OR cxsigbit OR SIGBREAKF_CTRL_C)

    IF (sig AND notifysig)
      /* Signal was a file modification */
      IF active
        Delay(50)	     /* Wait 1 second to ensure writing
				is completed from civilization */
        IF (quitprog := FileLength('RAM:CIVIL0.SVE')) <> -1 
          copyfromram(filename)
          IF buflen
            /* If the default icon was successfully read */
            iconfile := Open(iconname,MODE_NEWFILE)
            Write(iconfile,iconbuf,buflen)
            Close(iconfile)
          ENDIF
        ENDIF
      ENDIF
    ELSE
      /* Signal was from commodities */
      WHILE msg := GetMsg(messport)
        msgtype:=CxMsgType(msg)
        msgid:=CxMsgID(msg)
        ReplyMsg(msg)
        IF msgtype = CXM_COMMAND
          SELECT msgid
            CASE CXCMD_DISABLE   
              active:=FALSE
              ActivateCxObj(brokerobj,0)
            CASE  CXCMD_ENABLE
              active:=TRUE
              ActivateCxObj(brokerobj,1)
            CASE CXCMD_KILL
              quitprog:=-1
            CASE CXCMD_UNIQUE
              quitprog:=-1
            ENDSELECT
        ENDIF
      ENDWHILE
      IF (sig AND SIGBREAKF_CTRL_C)
        quitprog := -1
      ENDIF
    ENDIF
  UNTIL quitprog = -1

  FreeSignal(notifysigbit)
  DeleteCxObjAll(brokerobj)
  WHILE (msg:=GetMsg(messport))
    ReplyMsg(msg)
  ENDWHILE
  DeleteMsgPort(messport)

  IF request('Thank you for using CivManager V1.3\nBy Paul Hickman (ph@doc.ic.ac.uk)\n\nShall I delete the files in RAM:\nBefore Quitting?','  Yes  |  No  ',NIL)

    DeleteFile('RAM:CIVIL0.SVE')
    DeleteFile('RAM:CIVIL0.MAP')
  
  ENDIF

EXCEPT

IF sig<>-1 THEN FreeSignal(notifysigbit)

IF brokerobj
  DeleteCxObjAll(brokerobj)
  WHILE (msg:=GetMsg(messport))
    ReplyMsg(msg)
  ENDWHILE
  DeleteMsgPort(messport)
ENDIF

SELECT exception
  CASE ER_OPEN;      request('Error: Could Not Open A File',quitstring,NIL)
  CASE ER_READ;      request('Error: Could Not Read A File',quitstring,NIL)
  CASE ER_WRITE;     request('Error: Could Not Write To A File',quitstring,NIL)
  CASE ER_MEM;       request('Error: Out Of Memory Error',quitstring,NIL)
  CASE ER_NOSIG;     request('Error: Could Not Allocate Signal Bit',quitstring,NIL)
  CASE ER_NONOTIFY;  request('Error: Cannot watch \aRAM:CIVIL0.SVE\a',quitstring,NIL)
  CASE ER_CIVLOAD;   request('Error: Could Not Load Civilization',quitstring,NIL)
  CASE ER_OPENLIB;   request('Error: Could Not Open Required Libraries',quitstring,NIL) 
  CASE ER_MSGPORT;   request('Error: Could Not Create A Message Port',quitstring,NIL)
  CASE ER_BROKER;    /* Not an error - this is "run twice" quitting the 2nd copy */
  CASE ER_LOCK;      request('Error: Could Not Lock Directory',quitstring,NIL)
  CASE ER_ASSIGN;    request('Error: Could Not Assign CIV?:',quitstring,NIL)
  CASE ER_FONT;      request('Error: Could Not Assign FONTS:',quitstring,NIL)
  DEFAULT;           request('Error: An IO Error Has Occured',quitstring,NIL)
ENDSELECT

ENDPROC

PROC copytoram(fromname) HANDLE
  /* Copy the file */

  DEF buffer,infile,outfile

  infile := Open(fromname,MODE_OLDFILE)
  outfile := Open('ram:CIVIL0.map',MODE_NEWFILE)
  buffer := New(MAPFILESIZE)
  
  Read(infile,buffer,MAPFILESIZE)
  Write(outfile,buffer,MAPFILESIZE)
  Close(outfile)
  
  outfile := Open('ram:CIVIL0.sve',MODE_NEWFILE)
  Read(infile,buffer,SVEFILESIZE) 
  Write(outfile,buffer,SVEFILESIZE) 
  Close(outfile)

  Close(infile)
  Dispose(buffer)

EXCEPT
  
 Raise(exception)

ENDPROC


PROC copyfromram(toname) HANDLE
  /* Copy the file */

  DEF buffer,infile,outfile

  outfile := Open(toname,MODE_NEWFILE)
  infile := Open('ram:CIVIL0.map',MODE_OLDFILE)
  buffer := New(MAPFILESIZE)
  
  Read(infile,buffer,MAPFILESIZE)
  Write(outfile,buffer,MAPFILESIZE)
  Close(infile)

  infile := Open('ram:CIVIL0.sve',MODE_OLDFILE)
  Read(infile,buffer,SVEFILESIZE)
  Write(outfile,buffer,SVEFILESIZE)
  Close(outfile)

  Close(infile)
  Dispose(buffer)

EXCEPT

Raise(exception)

ENDPROC


PROC filereq(defdir,dirbuf) HANDLE

  CONST FILEREQ=0,REQINFO=1

  DEF filebuf[120]:STRING
  DEF req:PTR TO rtfilerequester
  DEF tempstr[1]:STRING

  reqtoolsbase:=OpenLibrary('reqtools.library',37)

  /* Setup the requester */

  IF req:=RtAllocRequestA(FILEREQ,0)
    filebuf := 'Save.Civil'
    RtChangeReqAttrA(req,[RTFI_DIR,defdir,RTFI_MATCHPAT,'#?.Civil',TAG_DONE])
    RtFileRequestA(req,filebuf,'Select A CivManger Game File',[RTFI_FLAGS,FREQF_PATGAD,TAG_DONE])

    /* combine the directory & filename */

    StrCopy(dirbuf,req.dir,ALL)
    RtFreeRequest(req)
    RightStr(tempstr,dirbuf,1)
    IF StrCmp(tempstr,':',1)=FALSE THEN StrAdd(dirbuf,'/',ALL)
    StrAdd(dirbuf,filebuf,ALL)

  ENDIF

  CloseLibrary(reqtoolsbase)


EXCEPT

Raise(exception)

ENDPROC 

PROC request(body,gadgets,args)
ENDPROC EasyRequestArgs(0,[20,0,'Civilization Manager V1.3',body,gadgets],0,args)

PROC getwbargs() HANDLE

  /* Variables for reading tooltypes & arguments */

  DEF wb:PTR TO wbstartup
  DEF args:PTR TO wbarg
  DEF dobj:PTR TO diskobject
  DEF typtr,toolarray
  DEF olddir=NIL

  /* Variables to hold results */


  IF wbmessage=NIL				/* we got from cli */
    WriteF('Civmanger V1.3 must be run from the workbench.\n\n')
  ELSE						/* from wb */
    wb:=wbmessage
    args:=wb.arglist
    iconbase:=OpenLibrary('icon.library',37)

    /* Read the actual program icon, for tooltypes */

    IF ((args.lock>0) AND (args.name>0))
    olddir := CurrentDir(args.lock)
    ENDIF
 
    IF dobj:=GetDiskObject(args.name)
      toolarray := dobj.tooltypes

      /* Read Tooltypes here */

      IF typtr:=FindToolType(toolarray,'DIR')
        StrCopy(defdir,typtr,ALL)
      ENDIF

      IF typtr:=FindToolType(toolarray,'CIV')
        StrCopy(civdir,typtr,ALL)
      ENDIF

      IF typtr:=FindToolType(toolarray,'FONTS')
        StrCopy(fontdir,typtr,ALL)
      ENDIF

      IF olddir THEN CurrentDir(olddir)
        FreeDiskObject(dobj)
      ENDIF
 
      /* Now read the first argument's lock */

      IF wb.numargs >= 2
        IF (args[1].lock>0) AND (StrLen(args[1].name)>0)

          NameFromLock(args[1].lock,filename,256)
          SetStr(filename,StrLen(filename))
          IF filename[EstrLen(filename)-1]<>":"
          StrAdd(filename,'/',ALL)
        ENDIF
        StrAdd(filename,args[1].name,ALL)
      ELSE
        request('You must select a FILE icon as\nan argument to Civmanager, or\nrun it without arguments.\n',quitstring,[])
      ENDIF 
    ELSE
      filereq(defdir,filename)
    ENDIF

    CloseLibrary(iconbase)
  ENDIF


EXCEPT
  Raise(exception)
ENDPROC

CHAR '$VER: Civmanager V1.3 ©1994 Paul Hickman',0