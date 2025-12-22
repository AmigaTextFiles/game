MODULE PlayMud;

(*---------------------------------------------------------------------------
** Copyright © 1992-1996 by Lars Düning  -  All rights reserved.
** Permission granted for non-commercial use.
**---------------------------------------------------------------------------
** An simple interface to a running AMud.
**
**  CLI-Usage: PlayMud ?
**             PlayMud [<console> | Current] [Port <portname>] [Noecho]
**                     [Quiet|Verbose|Debug]
**  AmiExpress:
**             PlayMud <nodeno>
**
**  Args   : <console>  : Consolename, e.g. 'CON:0/11/640/220'
**           Current    : use the current console
**           <portname> : Portname of LPmud to connect, default is "8888"
**           <nodeno>   : AmiExpress-Node to use.
**  Options: ?       : prints some help
**           Noecho  : lines input won't be echoed if output came in between
**           Quiet   : no messages from the pgm
**           Verbose : more messages from the pgm
**           Debug   : even more messages from the pgm
**
**    Result:  0: ok
**            20: illegal arg or something similar deadly
**
**  WB-Usage: FRONTEND= [DOS|STANDARD|AMIEXPRESS]
**            TYPE= [NOECHO] [QUIET|VERBOSE|DEBUG]
**            CON=  [<console>]
**            PORT= [<portname>]
**
**  Icons may be of type TOOL or (fileless) PROJECT.
**  Errors will cause a DisplayBeep.
**---------------------------------------------------------------------------
**  Oberon: Amiga-Oberon v3.20, F. Siebert / A+L AG
**---------------------------------------------------------------------------
** 10-May-92 [lars]
** 05-Jun-92 [lars] Port argument added
** 22-Oct-92 [lars] Console prompts for RETURN now if driver shuts down.
** 02-Apr-93 [lars] Adapted for Amiga-Oberon 3.00
**                  A 'shutdown' message will be sent on unexpected
**                  termination.
** 03-May-93 [lars] Merged in patches by John Fehr.
** 06-Sep-93 [lars] The current console can be opened explicitely.
** 04-Oct-93 [lars] On shell start, .info-Files are evaluated before
**                  parsing the cli args.
** 10-Oct-93 [lars] Source reorganisation.
** 10-Nov-93 [lars] AmiExpress arguments are parsed.
** 13-Nov-93 [lars] CLI start now searches the icons under the correct name.
** 15-Nov-93 [lars] Title is printed to frontend as well.
** 13-Feb-94 [lars] IAC GA is now properly ignored.
** 25-Feb-94 [lars] The frontend may now raise more than just one signal.
** 19-Nov-94 [lars] ShutdownAll() closes the readPort faster.
** 02-Jan-96 [lars] Shutdown prompt "Press RETURN" is not printed if using
**                  the current console.
**                  echo-off is properly undone on premature ends.
**---------------------------------------------------------------------------
*)

(* GarbageCollector- SmallCode SmallData *)

IMPORT
  (* $IF Debug *) Debug, (* $END *)
  con:FrontEnd, g:Global, sc:StringConv,
  d:Dos, e:Exec, es:ExecSupport, Icon, i:Intuition, wb:Workbench,
  a:Arguments, Break, Conversions, NoGuru, io, ol:OberonLib, str:Strings, s:SYSTEM;

(*-------------------------------------------------------------------------*)

CONST
    (* Telnet Commands *)

  iac   = 0FFX;  (* interpret as command: *)
  dont  = 0FEX;  (* you are not to use option *)
  do    = 0FDX;  (* please, you use option *)
  wont  = 0FCX;  (* I won't use option *)
  will  = 0FBX;  (* I will use option *)
  ip    = 0F4X;  (* interrupt process--permanently *)
  ga    = 0F9X;  (* you may reverse the line *)

    (* Telnet Options *)

  optEcho         =  01X;  (* echo *)


TYPE
  ConnectMsgP = UNTRACED POINTER TO ConnectMsg;
  DataMsgP    = UNTRACED POINTER TO DataMsg;

  (* Message send to the parse to open a connection.
  ** In portName we send the name of the port we listen to messages from
  ** the parser.
  ** In the replied message, the parser will have put into portName the name
  ** of the port it listens to for messages from us (this is then stored
  ** in hostPort).
  *)
  ConnectMsg = STRUCT
    (msg:e.Message)
    portName : e.STRPTR;
  END;

  (* The messages send between the parser and us. *)
  DataMsg = STRUCT
    (msg:e.Message)
    buffer : e.STRPTR;  (* a pointer to the data buffer *)
    len : LONGINT;      (* the used length within the buffer *)
  END;

VAR
  help   : BOOLEAN;  (* User requested help output *)
  illArg : BOOLEAN;  (* Illegal argument detected *)
  arg    : e.STRING; (* The last argument parsed *)

  connected : BOOLEAN;  (* Connection established *)
  invis     : BOOLEAN;  (* Parser forbid local echo of input *)

  readPort  : e.MsgPortPtr;  (* The port for messages from the parser *)
  portName  : e.STRING;      (* The name of the readPort *)
  replyPort : e.MsgPortPtr;  (* The replyport for our messages *)
  hostPort  : e.STRING;      (* The name of the parser's listening port *)

(*------------------------------------------------------------------------*)
PROCEDURE PrintTitle (tofront : BOOLEAN);

(* Print the title line, either to the shell or to the actual console.
**
** Note: "\[1;33m" : prints bold in fg-color 3
**       "\[0;32m" : prints normal in fg-color 2
**       "\[0;39m" : prints normal as usual
*)

BEGIN
  IF ~tofront THEN
    io.WriteString("\n\[0;32mPlayMud v");
    io.WriteString(g.version);
    io.WriteString("\[0;33m  ");
    io.WriteString(g.revision);
    io.WriteString("\[0;39m  --  (C)opyright 1992-1996 by Lars Düning. Freeware.\n\n");
  ELSIF ~g.currentCon THEN
    con.WriteString("\[0;32mPlayMud v");
    con.WriteString(g.version);
    con.WriteString("\[0;33m  ");
    con.WriteString(g.revision);
    con.WriteString("\[0;39m  --  (C)opyright 1992-1996 by Lars Düning. Freeware.\n\n");
  END;
END PrintTitle;

(*-------------------------------------------------------------------------*)
PROCEDURE SetupAll () : BOOLEAN;

(* SetupAll: creates e.g. our replyPort, etc
**
** Result = FALSE: something went wrong
**        = TRUE : ok
*)

BEGIN
  IF ~con.Open() THEN
    RETURN FALSE;
  END;

  replyPort := es.CreatePort ("", 0);
  IF replyPort = NIL THEN RETURN FALSE; END;
  sc.IntToHex (s.VAL(LONGINT, ol.Me), portName);
  str.Insert (portName, 0, "PlayMud");
  readPort := es.CreatePort (portName, 0);
  IF readPort = NIL THEN RETURN FALSE; END;

  IF g.verbosity # g.quiet THEN io.WriteLn; END;
  IF g.verbosity > g.verbose THEN
    io.WriteString ("Our port: ");
    io.WriteString (portName);
    io.WriteLn;
  END;
  RETURN TRUE;
END SetupAll;

(*-------------------------------------------------------------------------*)
PROCEDURE ShutdownAll;

(* ShutdownAll: macht alles, was SetupAll reservierte, rückgängig
*)

BEGIN
  IF readPort # NIL THEN es.DeletePort (readPort); END;
  con.Close;
  IF replyPort # NIL THEN es.DeletePort (replyPort); END;
END ShutdownAll;

(*-------------------------------------------------------------------------*)
(* $CopyArrays- *)
PROCEDURE Connect ( port, portName : ARRAY OF CHAR) : BOOLEAN;

(* Tries to connect to the host's connection <port>, telling him our
** <portName> of the listening port..
** Host replies with his listening port, which is stored in hostPort.
** Returns success.
*)

VAR
  cmsg, reply : ConnectMsgP;
  sig         : SHORTINT;
  signal      : LONGSET;
BEGIN
  NEW(cmsg);
  IF cmsg = NIL THEN
    con.WriteString ("Not enough mem for ConnectMsg.\n");
    IF g.verbosity # g.quiet THEN
      io.WriteString ("Not enough mem for ConnectMsg.\n");
    END;
    RETURN FALSE;
  END;
  cmsg.msg.node.type := e.message;
  cmsg.msg.length := s.SIZE (ConnectMsg);
  cmsg.msg.replyPort := replyPort;
  cmsg.portName := s.ADR(portName);
  IF ~g.PutMsg (cmsg, port) THEN
    con.WriteString ("Host not found.\n");
    DISPOSE(cmsg);
    RETURN FALSE;
  END;
  sig := replyPort.sigBit;
  LOOP
    signal := e.Wait (LONGSET{d.ctrlE, sig});
    IF sig IN signal THEN
      reply := e.GetMsg (replyPort);
      IF reply # NIL THEN
        e.CopyMem (reply.portName^, hostPort, str.Length(reply.portName^));
        DISPOSE(cmsg);
        IF g.verbosity > g.verbose THEN
          io.WriteString("LPmud port: ");
          io.WriteString(hostPort);
          io.WriteLn;
        END;
        RETURN TRUE;
      END;
    END;
    IF d.ctrlE IN signal THEN
      IF ~g.curCon THEN  con.WriteString ("** User Abort\n"); END;
      io.WriteString ("** User Abort\n");
      RETURN FALSE;
    END;
  END;
  RETURN FALSE;
END Connect;

(*-------------------------------------------------------------------------*)
(* $CopyArrays- *)
PROCEDURE PrintLPmsg (VAR text : ARRAY OF CHAR; len : LONGINT; VAR abort : BOOLEAN);

(* Prints a <text> received from LPmud to the console.
** Handles also echo on/off and connection close.
*)

CONST
  BufLen = 10240;
TYPE
  CP = UNTRACED POINTER TO CHAR;
VAR
  ntext : ARRAY BufLen OF CHAR;
  i, i1, i2 : CP;
  j : INTEGER;
BEGIN
  IF invis THEN con.WriteString ("\[0m"); END;
  i := s.ADR(text); j := 0;
  WHILE len > 0 DO
    i1 := s.VAL(CP,s.VAL(LONGINT, i)+1);
    i2 := s.VAL(CP,s.VAL(LONGINT, i)+2);
    IF (i^ = iac) & (i1^ = ip) THEN (* Prelude to connection close *)
      IF g.verbosity > g.verbose THEN io.WriteString ("[ip] "); END;
      IF invis THEN
        invis := FALSE;
        con.WriteString ("\[0m");
      END;
      i := i1;
      DEC(j); DEC(len, 1);
    ELSIF (i^ = iac) & (i1^ = ga) THEN (* Go ahead, make my day! *)
      IF g.verbosity > g.verbose THEN io.WriteString ("[ga] "); END;
      i := i1;
      DEC(j); DEC(len, 1);
    ELSIF (i^ = iac) & (i2^ = optEcho) THEN
      IF i1^ = will THEN  (* No local echo *)
        IF g.verbosity > g.verbose THEN io.WriteString ("[invis] "); END;
        invis := TRUE;
      ELSIF i1^ = wont THEN (* Local echo *)
        IF g.verbosity > g.verbose THEN io.WriteString ("[vis] "); END;
        con.WriteString ("\[0m");
        invis := FALSE;
      ELSIF  i1^ = do THEN (* Close connection *)
        IF g.verbosity > g.verbose THEN io.WriteString ("[abort] "); END;
        abort := TRUE;
      ELSE
        IF g.verbosity > g.verbose THEN io.WriteString ("[] "); END;
      END;
      i := i2;
      DEC(j); DEC(len,2);
    ELSIF (i^ = iac) & (i1^ = wont) THEN (* partial "Local echo" *)
      IF g.verbosity > g.verbose THEN io.WriteString ("[vis] "); END;
      con.WriteString ("\[0m");
      invis := FALSE;
      i := i1;
      DEC(j); DEC(len, 1);
    ELSE
      ntext[j] := i^;
    END;
    i := s.VAL(CP,s.VAL(LONGINT, i)+1);
    DEC(len); INC(j);
    IF j >= BufLen THEN
      con.PutString (ntext, BufLen);
      j := 0;
    END;
  END;
  IF g.verbosity > g.verbose THEN io.Write (" "); END;
  IF j > 0 THEN con.PutString (ntext, j); END;
  IF abort THEN con.WriteString ("\nConnection closed by host.\n"); connected := FALSE; END;
  IF invis THEN con.WriteString ("\[8m"); END;
END PrintLPmsg;

(*-------------------------------------------------------------------------*)
(* $CopyArrays- *)
PROCEDURE TellLPinput (text : ARRAY OF CHAR);

(* Tell LPmud a line of <text>, return success *)

VAR
  len : LONGINT;
  dmsg : DataMsgP;
BEGIN
  len := str.Length(text)+1;
  NEW(dmsg);
  IF dmsg # NIL THEN
    ol.New (dmsg.buffer, len);
    IF dmsg.buffer = NIL THEN DISPOSE(dmsg); dmsg := NIL; END;
  END;
  IF dmsg = NIL THEN
    con.WriteString ("Failed to send text: not enough mem.\n");
    IF g.verbosity # g.quiet THEN
      io.WriteString ("Not enough mem for DataMsg.\n");
    END;
    RETURN;
  END;
  dmsg.msg.node.type := e.message;
  dmsg.msg.length := s.SIZE (DataMsg);
  dmsg.msg.replyPort := replyPort;
  e.CopyMem (text, dmsg.buffer^,len-1);
  dmsg.buffer^[len-1] := 0X;
  dmsg.len := len-1;
(*
  IF g.verbosity > g.verbose THEN
    io.WriteString ("["); io.WriteInt (dmsg.len,1); io.WriteString ("]`");
    io.WriteString (dmsg.buffer^); io.WriteString ("` ");
  END;
*)
  IF ~g.PutMsg (dmsg, hostPort) THEN
    con.WriteString ("Failed to send text: Host disappeared.\n");
    IF g.verbosity # g.quiet THEN io.WriteString ("Host disappeared.\n"); END;
    RETURN;
  END;
END TellLPinput;

(*-------------------------------------------------------------------------*)
PROCEDURE TellLPshutdown();

(* Send the mud the 'link shutdown' codes. *)

BEGIN                           (* IAC IP  IAC DO  1 *)
  IF connected THEN TellLPinput ("\xFF\xF4\xFF\xFD\x01"); END;
END TellLPshutdown;

(*-------------------------------------------------------------------------*)
PROCEDURE Action();

(* The real main procedure *)

VAR
  abort, prompt : BOOLEAN;
  readSig, replySig : SHORTINT;
  frontendSig : LONGSET;
  signals : LONGSET;
  dmsg : DataMsgP;
BEGIN
  frontendSig := con.FrontendSig();

  PrintTitle(TRUE);
  con.WriteString ("Trying LPmud at port ");
  con.WriteString (g.mudName);
  con.WriteString ("...\n");
  connected := Connect (g.mudName, portName);
  IF ~connected THEN
    IF ~g.curCon THEN con.WriteString ("Connection failed.\n"); END;
    IF g.verbosity # g.quiet THEN io.WriteString ("Connection failed.\n"); END;
    RETURN;
  END;
  con.WriteString ("Connected.\n");
  readSig := readPort.sigBit;
  replySig := replyPort.sigBit;
  con.QueueRead;
  abort := FALSE; prompt := FALSE;
  WHILE ~abort DO
    signals := e.Wait (LONGSET{d.ctrlE, g.readSig, readSig, replySig}+frontendSig);
    IF readSig IN signals THEN (* LPmud tells us something *)
      dmsg := e.GetMsg (readPort);
      WHILE dmsg # NIL DO
        IF g.verbosity > g.verbose THEN io.WriteString ("From "); END;
        PrintLPmsg (dmsg.buffer^, dmsg.len, abort);
        e.ReplyMsg (dmsg);
        dmsg := e.GetMsg (readPort);
      END;
    END;
    IF g.readSig IN signals THEN (* We tell LPmud something - maybe *)
      IF con.ReadChar() THEN
        IF g.verbosity > g.verbose THEN io.WriteString ("To "); END;
        TellLPinput (g.line);
        IF invis THEN con.WriteString ("\[0m"); invis := FALSE; END;
      END;
    END;
      (* If abort is true at this place, the mud driver shut down.
      ** To keep the last messages readable we have to wait for a keypress.
      *)
    IF abort THEN prompt := TRUE; END;
    IF replySig IN signals THEN  (* LPmud replied our message *)
      dmsg := e.GetMsg (replyPort);
      WHILE dmsg # NIL DO
        IF g.verbosity > g.verbose THEN io.WriteString ("Reply "); END;
        DISPOSE(dmsg.buffer);
        DISPOSE(dmsg);
        dmsg := e.GetMsg (replyPort);
      END;
    END;
    IF signals * frontendSig # LONGSET{} THEN
      con.HandleYourSig(signals, abort);
    END;
    IF d.ctrlE IN signals THEN abort := TRUE; END;
  END;

    (* Undo pending echo-off-mode, just in case *)
  IF invis THEN con.WriteString ("\[0m"); invis := FALSE; END;

    (* The mud driver shut down, so prompt for a keypress to keep
    ** the last messages readable. Closing the window also suffices.
    *)
  IF prompt & ~g.currentCon THEN
    abort := FALSE;
    con.WriteString ("\nPress RETURN...");
    WHILE ~abort DO
      signals := e.Wait (LONGSET{d.ctrlE, g.readSig}+frontendSig);
      IF g.readSig IN signals THEN (* some keys had been pressed *)
        IF con.ReadChar() THEN abort := TRUE; END;
      END;
      IF signals * frontendSig # LONGSET{} THEN
        con.HandleYourSig(signals, abort);
      END;
      IF d.ctrlE IN signals THEN abort := TRUE; END;
    END;
  END;

  IF g.verbosity > g.verbose THEN io.WriteString ("\n"); END;
END Action;

(*-------------------------------------------------------------------------*)
PROCEDURE ParseIcon (myIcon : wb.DiskObjectPtr);

(* ParseIcon: analyzes the tools of one single icon
*)

  VAR
    type : e.STRPTR;

BEGIN
  IF myIcon#NIL THEN
    type := Icon.FindToolType(myIcon.toolTypes,"FRONTEND");
    IF type # NIL THEN
      IF Icon.MatchToolValue (type^, "STANDARD")   THEN g.frontend := g.dosHandler; END;
      IF Icon.MatchToolValue (type^, "DOS")        THEN g.frontend := g.dosHandler; END;
      IF Icon.MatchToolValue (type^, "AMIEXPRESS") THEN g.frontend := g.amiExpress; END;
    END;
    type := Icon.FindToolType(myIcon.toolTypes,"TYPE");
    IF type # NIL THEN
      g.noEcho := Icon.MatchToolValue (type^, "NOECHO");
      IF Icon.MatchToolValue (type^, "QUIET")   THEN g.verbosity := g.quiet; END;
      IF Icon.MatchToolValue (type^, "VERBOSE") THEN g.verbosity := g.verbose; END;
      IF Icon.MatchToolValue (type^, "DEBUG")   THEN g.verbosity := g.debug; END;
    END;
    type := Icon.FindToolType(myIcon.toolTypes,"CON");
    IF type # NIL THEN COPY (type^, g.conName); END;
    type := Icon.FindToolType(myIcon.toolTypes,"PORT");
    IF type # NIL THEN COPY (type^, g.mudName); END;
  END;
END ParseIcon;

(*-------------------------------------------------------------------------*)
PROCEDURE ParseWBArgs;

(* ParseWBArgs: analyzes the args given in icons on start from WB
*)

  VAR
    type          : e.STRPTR;
    argNr         : INTEGER;
    me            : d.ProcessPtr;
    wbm           : wb.WBStartupPtr;
    myIcon        : wb.DiskObjectPtr;
    oldCurrentDir : d.FileLockPtr;

  BEGIN
    arg := "";

    me := s.VAL(d.ProcessPtr,ol.Me);

    wbm := ol.wbenchMsg;
    IF wbm.numArgs > 2 THEN illArg := TRUE; RETURN END;
    argNr := SHORT(wbm.numArgs) - 1;

    type := wbm.argList[argNr].name;

    oldCurrentDir := me.currentDir;
    s.SETREG(0,d.CurrentDir(wbm.argList[argNr].lock));
    myIcon := Icon.GetDiskObject(type^);
    s.SETREG(0,d.CurrentDir(oldCurrentDir));

    ParseIcon(myIcon);
    IF myIcon # NIL THEN
      Icon.FreeDiskObject(myIcon);
    END;

    IF g.frontend = g.amiExpress THEN
      arg := "FRONTEND=AMIEXPRESS";
      illArg := TRUE;
    END;
  END ParseWBArgs;

(*------------------------------------------------------------------------*)
(* $CopyArrays- *)
PROCEDURE Compare (str1, str2 : ARRAY OF CHAR) : BOOLEAN;

(* Compare : compares two strings for equalness.
**
**   Each letter will be interpreted as a capital.
*)


  VAR
    i : INTEGER;

  BEGIN
    i := 0;
    WHILE (i < LEN (str1)) AND (i <= LEN (str2)) DO
      IF (str1 [i] = 0X) AND (str2 [i] = 0X) THEN RETURN TRUE; END;
      IF CAP (str1 [i]) # CAP (str2 [i]) THEN RETURN FALSE; END;
      INC (i);
    END;

    RETURN TRUE;
  END Compare;

(*-------------------------------------------------------------------------*)
PROCEDURE ParseCLIArgs;

(* ParseCLIArgs: analyzes the arguments given on the command line.
**   Before that, it looks for PlayMud.info-Dateien in PROGDIR: (2.0 only),
**   MUDBIN: and in the current directory.
*)

VAR
  ix            : INTEGER;
  lx            : LONGINT;
  oldWin        : i.WindowPtr;
  me            : d.ProcessPtr;
  type          : e.STRPTR;
  filepart      : e.STRPTR;
  myIcon        : wb.DiskObjectPtr;
  oldCurrentDir : d.FileLockPtr;
  newDir        : d.FileLockPtr;
  long          : LONGINT;

BEGIN
  (* Check commandline args if help is requested. *)
  illArg := FALSE;
  IF a.NumArgs() >= 1 THEN
    a.GetArg (1, arg);
    IF Compare ("?", arg) THEN
      help := TRUE;
      RETURN;
    END;
  END;

  a.GetArg(0, arg);
  IF e.exec.libNode.version >= 37 THEN
    filepart := d.FilePart(arg);
  ELSE
    lx := str.Length(arg)-1;
    WHILE (lx > 0) & (arg[lx] # "/") & (arg[lx] # ":") DO
      DEC(lx);
    END;
    filepart := s.VAL(e.STRPTR, s.ADR(arg[lx]));
  END;

  me := s.VAL (d.ProcessPtr, ol.Me);
  oldWin := me.windowPtr;
  me.windowPtr := s.VAL(i.WindowPtr, -1);  (* suppresses requester *)
  oldCurrentDir := me.currentDir;

  (* Try PROGDIR:PlayMud.info *)
  IF   (e.exec.libNode.version >= 37)
     & (me.homeDir # NIL)
     & (d.SameLock(me.homeDir, oldCurrentDir) = d.same)
  THEN
    s.SETREG(0,d.CurrentDir(me.homeDir));
    myIcon := Icon.GetDiskObject(filepart^);
    s.SETREG(0,d.CurrentDir(oldCurrentDir));

    ParseIcon(myIcon);
    IF myIcon # NIL THEN
      Icon.FreeDiskObject(myIcon);
    END;
  END;

  (* Try MUDBIN:PlayMud.info *)
  newDir := d.Lock("MUDBIN:", d.sharedLock);
  IF newDir # NIL THEN
    s.SETREG(0,d.CurrentDir(newDir));
    myIcon := Icon.GetDiskObject(filepart^);
    s.SETREG(0,d.CurrentDir(oldCurrentDir));

    ParseIcon(myIcon);
    IF myIcon # NIL THEN
      Icon.FreeDiskObject(myIcon);
    END;
    d.UnLock(newDir);
  END;

  (* Try PlayMud.info *)
  myIcon := Icon.GetDiskObject(filepart^);
  ParseIcon(myIcon);
  IF myIcon # NIL THEN
    Icon.FreeDiskObject(myIcon);
  END;

  me.windowPtr := oldWin;  (* reenable requester *)

  (* Parse Commandline args.
  ** When running for AmiExpress, just one number is allowed.
  *)

  IF g.frontend # g.amiExpress THEN
    IF a.NumArgs() = 0 THEN RETURN END;
    ix := 1;
    REPEAT
      a.GetArg (ix, arg);
      illArg := TRUE;
      IF Compare ("C", arg) OR Compare ("CURRENT", arg)
        THEN g.curCon := TRUE; illArg := FALSE; END;
      IF Compare ("N", arg) OR Compare ("NOECHO", arg)
        THEN g.noEcho := TRUE; illArg := FALSE; END;
      IF Compare ("Q", arg) OR Compare ("QUIET", arg)
        THEN g.verbosity := g.quiet; illArg := FALSE; END;
      IF Compare ("V", arg) OR Compare ("VERBOSE", arg)
        THEN g.verbosity := g.verbose; illArg := FALSE; END;
      IF Compare ("D", arg) OR Compare ("DEBUG"  , arg)
        THEN g.verbosity := g.debug; illArg := FALSE; END;
      IF Compare ("P", arg) OR Compare ("PORT"   , arg) THEN
        INC(ix);
        IF ix <= a.NumArgs() THEN a.GetArg (ix, g.mudName); illArg := FALSE; END;
      END;

      IF illArg THEN COPY(arg, g.conName); illArg := FALSE; END;

      INC (ix);
    UNTIL ix > a.NumArgs();

  ELSE (* frontend = amiExpress *)
    illArg := TRUE;
    IF a.NumArgs() < 1 THEN
      arg := "<no arg given>";
      RETURN;
    END;
    IF a.NumArgs() > 1 THEN
      arg := "<too much args given>";
      RETURN;
    END;
    a.GetArg(1, arg);
    illArg := ~Conversions.StrToInt(arg, g.aeNode, 10);
  END;

END ParseCLIArgs;

(*------------------------------------------------------------------------*)
PROCEDURE PrintHelp;

(* Print the help.
*)

BEGIN
  io.WriteString ("  CLI-Usage: PlayMud ?\n");
  io.WriteString ("             PlayMud [<console> | Current] [Port <portname>] [Noecho]\n");
  io.WriteString ("                     [Quiet|Verbose|Debug]\n");
  io.WriteLn;
  io.WriteString ("  Args   : <console>  : Consolename, e.g. 'CON:0/11/640/220'\n");
  io.WriteString ("           Current    : use the current console\n");
  io.WriteString ("           <portname> : Portname of LPmud to connect, default is '8888'\n");
  io.WriteString ("  Options: ?       : prints this help\n");
  io.WriteString ("           Noecho  : lines input won't be echoed if output came in between\n");
  io.WriteString ("           Quiet   : no messages from the pgm\n");
  io.WriteString ("           Verbose : more messages from the pgm\n");
  io.WriteString ("           Debug   : even more messages from the pgm\n");
  io.WriteLn;
  io.WriteString ("  WB-Usage: FRONTEND= [DOS|STANDARD|AMIEXPRESS]\n");
  io.WriteString ("            TYPE=     [NOECHO] [QUIET|VERBOSE|DEBUG]\n");
  io.WriteString ("            CON=      [<console>]\n");
  io.WriteString ("            PORT=     [<portname>]\n");
  io.WriteLn;
  io.WriteString ("  Icons may be of type TOOL or (fileless) PROJECT.\n");
  io.WriteString ("  Errors will cause a DisplayBeep.\n");
  io.WriteLn;
  io.WriteString ("  Iconfiles will also be evaluated when running from shell, prior to parsing\n");
  io.WriteString ("  the commandline arguments.\n");
  io.WriteLn;
END PrintHelp;

(*-------------------------------------------------------------------------*)

BEGIN
  connected := FALSE; invis := FALSE;
  help := FALSE; illArg := FALSE;

  IF ol.wbStarted THEN ParseWBArgs
                  ELSE ParseCLIArgs
  END;

  IF illArg THEN
    g.result := d.fail;
    io.WriteString ("PlayMud: Illegal argument '");
    io.WriteString (arg);
    io.WriteString ("'\n");
  ELSE
    IF g.verbosity # g.quiet THEN PrintTitle(FALSE); END;
    IF help THEN
      PrintHelp;
    ELSE
      IF ~SetupAll() THEN
        g.result := d.fail;
        io.WriteString ("PlayMud: Can't perform setup.\n");
      END;
      Action;
    END;
  END;

  IF ol.wbStarted & (g.result >= d.warn) THEN
    i.DisplayBeep (NIL);
  END;
CLOSE
  TellLPshutdown();
  ShutdownAll;
END PlayMud.

(*=========================================================================*)
