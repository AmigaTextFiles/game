MODULE AmiExpressFront;

(*---------------------------------------------------------------------------
** Copyright © 1993-1996 by Lars Düning  -  All rights reserved.
** Permission granted for non-commercial use.
**---------------------------------------------------------------------------
** A simple string oriented interface to AmiExpress for PlayMud, featuring
** asynchronous reads.
**
** This module builds upon various informations gathered from freely
** distributed add-ons to AmiExpress.
** I don't have AmiExpress on my own, and therefore can't neither
** guarantee the functionality of this module, nor do exhaustive debugging
** sessions.
**---------------------------------------------------------------------------
** Oberon: Amiga-Oberon v3.20, F. Siebert / A+L AG
**---------------------------------------------------------------------------
** 12-Nov-92 [lars]
** 25-Feb-94 [lars] FrontEnd now accepts more than one signal.
**---------------------------------------------------------------------------
*)

(* GarbageCollector- SmallCode SmallData *)

IMPORT
  (* $IF Debug *) Debug, (* $END *)
  g:Global, StringConv,
  d:Dos, e:Exec, ExecSupport,
  io, ol:OberonLib, str:Strings, s:SYSTEM;

(*-------------------------------------------------------------------------*)

CONST
  AEMaxChars = 200;  (* Max number of characters per message *)

TYPE
  JHMessagePtr = UNTRACED POINTER TO JHMessage;

  JHMessage = STRUCT
    (msg: e.Message);
    string : ARRAY AEMaxChars OF CHAR;  (* info buffer *)
    data   : LONGINT;                   (* read/write, result indicator *)
    command : LONGINT;                  (* Command code sent *)
    nodeID  : LONGINT;                  (* reserved *)
    lineNum : LONGINT;                  (* reserved *)
    signal  : LONGSET;                  (* reserved *)
    task    : d.ProcessPtr;             (* current nodes task address;
                                        ** used just by the BB_GETTASK command *)
  END;

CONST (* Command codes *)
  aeRegister =   1;  (* Register with AmiExpress node *)
  aeShutdown =   2;  (* Unlink from AmiExpress node *)
  aeWrite    =   3;  (* Write message to user *)
  aePM       =   5;  (* Request input from user *)
  aeHK       =   6;  (* Request input from user *)
  aeTimeOut  = 125;  (* Set/Query the door timeout *)
  aeStatus   = 129;  (* Query the node status *)

(*-------------------------------------------------------------------------*)

VAR
  aePortName   : e.STRING;      (* Name of our AExpress port *)
  replyPort    : e.MsgPortPtr;  (* Replyport for synchronous messages to AExpress *)
  frontendSig  : SHORTINT;      (* Signal number for 'frontend signals' *)
  jhmsg        : JHMessagePtr;  (* Message used for sync io *)
  gotCR        : BOOLEAN;

(*-------------------------------------------------------------------------*)
PROCEDURE ReuseMessage ( msg : JHMessagePtr
                       ; port : e.MsgPortPtr
                       ; command : LONGINT
                       );
BEGIN
  IF msg # NIL THEN
    msg.msg.node.type := e.message;
    msg.msg.length := s.SIZE(JHMessage);
    msg.msg.replyPort := port;
    msg.command := command;
    msg.string[0] := 0X;
  END;
END ReuseMessage;

(*-------------------------------------------------------------------------*)
PROCEDURE CreateMessage ( port : e.MsgPortPtr
                        ; command : LONGINT
                        ) : JHMessagePtr;
VAR
  msg : JHMessagePtr;
BEGIN
  NEW(msg);
  ReuseMessage(msg, port, command);
  RETURN msg;
END CreateMessage;

(*-------------------------------------------------------------------------*)
PROCEDURE SyncIO ( msg : JHMessagePtr ) : BOOLEAN;

(* Send the given message to AmiExpress and wait for its reply.
** If the PutMsg() failed, FALSE is returned, else TRUE.
*)

VAR
  rmsg : e.MessagePtr;
BEGIN
  IF ~g.PutMsg(msg, aePortName) THEN RETURN FALSE; END;
  WHILE TRUE DO
    e.WaitPort(replyPort);
    REPEAT
      rmsg := e.GetMsg(replyPort);
      IF rmsg = msg THEN RETURN TRUE; END;
    UNTIL rmsg = NIL;
  END;
END SyncIO;

(*-------------------------------------------------------------------------*)
PROCEDURE Open * (number : LONGINT) : BOOLEAN;

(* Link Playmud as door with AmiExpress, node <number>.
** Success is returned.
*)

TYPE
  LongPtr = UNTRACED POINTER TO LONGINT;
VAR
  lptr : LongPtr;

BEGIN
  IF replyPort # NIL THEN
    io.WriteString("Error: Open link to AmiExpress already exists.\n");
    RETURN FALSE;
  END;

  replyPort := ExecSupport.CreatePort("", 0);
  IF replyPort = NIL THEN
    io.WriteString("Error: Can't open replyport for AmiExpress messages.\n");
    RETURN FALSE;
  END;

  frontendSig := e.AllocSignal(-1);

  IF frontendSig = -1 THEN
    io.WriteString("Error: Can't allocate frontend signal.\n");
    ExecSupport.DeletePort(replyPort); replyPort := NIL;
    RETURN FALSE;
  END;

  (* Compute the portname we have to talk to *)
  StringConv.IntToHex(s.VAL(LONGINT, number), aePortName);
  str.Insert(aePortName, 0, "AEDoorPort");

  (* Register with AmiExpress *)
  IF jhmsg # NIL THEN
    ReuseMessage(jhmsg, replyPort, aeRegister);
  ELSE
    jhmsg := CreateMessage(replyPort, aeRegister);
  END;
  IF jhmsg = NIL THEN
    io.WriteString("Error: Not enough mem for message.\n");
    ExecSupport.DeletePort(replyPort); replyPort := NIL;
    e.FreeSignal(frontendSig); frontendSig := -1;
    RETURN FALSE;
  END;
  IF ~SyncIO(jhmsg) THEN
    io.WriteString("Error: AmiExpress port '");
    io.WriteString(aePortName);
    io.WriteString("' not found.\n");
    DISPOSE(jhmsg); jhmsg := NIL;
    ExecSupport.DeletePort(replyPort); replyPort := NIL;
    e.FreeSignal(frontendSig); frontendSig := -1;
    RETURN FALSE;
  END;

  (* Set timeout *)
  ReuseMessage(jhmsg, replyPort, aeTimeOut);
  lptr := s.VAL(LongPtr, s.ADR(jhmsg.string));
  lptr^ := 1;
  IF ~SyncIO(jhmsg) THEN
    io.WriteString("Error: AmiExpress port '");
    io.WriteString(aePortName);
    io.WriteString("' not found.\n");
    DISPOSE(jhmsg); jhmsg := NIL;
    ExecSupport.DeletePort(replyPort); replyPort := NIL;
    e.FreeSignal(frontendSig); frontendSig := -1;
    RETURN FALSE;
  END;

  IF g.verbosity # g.quiet THEN
    io.WriteString("  AmiExpress ");
    io.WriteString(aePortName);
    io.WriteLn;
  END;

  gotCR := FALSE;
  RETURN TRUE;
END Open;

(*-------------------------------------------------------------------------*)
PROCEDURE Close * ();

(* Closes any open AmiExpress link *)

VAR
  msg : e.MessagePtr;
BEGIN
  IF frontendSig # -1 THEN e.FreeSignal(frontendSig); frontendSig := -1; END;
  IF replyPort = NIL THEN RETURN; END;

  (* Unlink from AmiExpress *)
  msg := CreateMessage(replyPort, aeShutdown);
  IF msg = NIL THEN
    io.WriteString("Error: Not enough mem for shutdown message.\n");
  ELSIF ~SyncIO(msg) THEN
    io.WriteString("Error: AmiExpress port '");
    io.WriteString(aePortName);
    io.WriteString("' not found.\n");
  END;
  DISPOSE(msg);
  IF g.verbosity # g.quiet THEN io.WriteString("Unlinked from AmiExpress.\n"); END;

  IF g.verbosity # g.quiet THEN io.WriteString("Collecting left messages..."); END;

  msg := e.GetMsg(replyPort);
  WHILE msg # NIL DO msg := e.GetMsg(replyPort); END;
  ExecSupport.DeletePort(replyPort); replyPort := NIL;
  IF g.readPort # NIL THEN
    msg := e.GetMsg(g.readPort);
    WHILE msg # NIL DO msg := e.GetMsg(g.readPort); END;
  END;
  (* the mem of our msgs will be automagically freed on programs exit *)
  IF g.verbosity # g.quiet THEN io.WriteString("done.\n"); END;
  IF jhmsg # NIL THEN DISPOSE(jhmsg); jhmsg := NIL; END;
END Close;

(*-------------------------------------------------------------------------*)
PROCEDURE FrontendSig * () : LONGSET;

(* Return the signal which is set if a message arrives from the user.
** For AmiExpress, the IO routines set the signal if a loss of carrier
** is detected.
** Return {} for no signal.
*)

BEGIN
  IF frontendSig # -1 THEN
    RETURN LONGSET{frontendSig};
  END;
  RETURN LONGSET{};
END FrontendSig;

(*-------------------------------------------------------------------------*)
PROCEDURE HandleYourSig * (signals : LONGSET; VAR abort : BOOLEAN);

(* If PlayMud got 'signals' (= a signal from the console window),
** it calls this functions and leaves it to us to handle the signal.
** If an aborting condition is detected, 'abort' is to be set to TRUE,
** else is mustn't be changed.
** For AmiExpress a set signal always signals a loss of carrier, and
** thus aborts the session.
*)

BEGIN
  IF (frontendSig # -1) & (frontendSig IN signals) THEN
    s.SETREG(0, e.SetSignal(LONGSET{}, LONGSET{frontendSig})); (* Just in case *)
    abort := TRUE;
  END;
END HandleYourSig;

(*-------------------------------------------------------------------------*)
PROCEDURE PutString * (text : ARRAY OF CHAR; len : LONGINT); (* $CopyArrays- *)

(* Write a string of given length to user *)

  VAR
    start  : LONGINT;
    actlen : LONGINT;
BEGIN
  IF replyPort = NIL THEN RETURN; END;
  start := 0;
  WHILE start < len DO
    actlen := len-start;
    IF actlen >= AEMaxChars THEN
      actlen := AEMaxChars-1;
    END;
    ReuseMessage(jhmsg, replyPort, aeWrite);
    str.Cut(text, start, actlen, jhmsg.string);
    jhmsg.string[actlen] := 0X;
    IF ~SyncIO(jhmsg) & (frontendSig # -1) THEN  (* Uh-oh! *)
      e.Signal(s.VAL(d.ProcessPtr, ol.Me), LONGSET{frontendSig});
      RETURN;
    END;
    INC(start, actlen);
  END;
  IF (len > 0) & (g.pos > 0) THEN g.writeOccured := TRUE; END;
END PutString;

(*-------------------------------------------------------------------------*)
PROCEDURE Write (ch : CHAR; echo : BOOLEAN);

(* Write a single character to console
** If <echo> is TRUE, the output is just the echo of a key input, so
** g.writeOccured is not changed.
*)

BEGIN
  IF (replyPort = NIL) OR (ch = 0X) THEN RETURN; END;
  ReuseMessage(jhmsg, replyPort, aeWrite);
  jhmsg.string[0] := ch;
  jhmsg.string[1] := 0X;
  IF ~SyncIO(jhmsg) & (frontendSig # -1) THEN  (* Uh-oh! *)
    e.Signal(s.VAL(d.ProcessPtr, ol.Me), LONGSET{frontendSig});
  END;
  IF ~echo & (g.pos > 0) THEN g.writeOccured := TRUE; END;
END Write;

(*-------------------------------------------------------------------------*)
PROCEDURE WriteString * (text : ARRAY OF CHAR); (* $CopyArrays- *)

(* Write a null-terminated string to console *)

BEGIN
  PutString(text, str.Length(text));
END WriteString;

(*-------------------------------------------------------------------------*)
PROCEDURE QueueRead * (msg : JHMessagePtr);

(* Sends one read request for one character to console.
** If a message is to be reused, it may be given, else NIL.
** This fun must be called directly after Open() once to initiate reads !
*)

BEGIN
  IF replyPort = NIL THEN RETURN; END;
  IF msg # NIL THEN
    ReuseMessage(msg, g.readPort, aeHK);
  ELSE
    msg := CreateMessage(g.readPort, aeHK);
  END;
  IF msg # NIL THEN
    msg.data := AEMaxChars-2;
    (* We have to clear the string field by hand since AExpress does not
    ** always put a trailing 0 after the string returned. :-(
    *)
    msg.string[0] := 0X;
    e.CopyMemAPTR(s.ADR(msg.string), s.VAL(s.ADDRESS, s.VAL(LONGINT, s.ADR(msg.string))+1)
                 , AEMaxChars-1);
    IF ~g.PutMsg(msg, aePortName) THEN  (* Uh-oh! *)
      IF frontendSig # -1 THEN
        e.Signal(s.VAL(d.ProcessPtr, ol.Me), LONGSET{frontendSig});
      END;
      DISPOSE(msg);
    END;
  ELSE
    io.WriteString("Error: Not enough mem for message.\n");
  END;
END QueueRead;

(*-------------------------------------------------------------------------*)
PROCEDURE ReadChar * () : BOOLEAN;

(* Reads in a received ReadRequest and queues up a new one.
** If the request completed a line, it will be copied in to g.line.
** If necessary, this line will be echoed.
** Returns condition "line completed".
*)

VAR
  msg     : JHMessagePtr;
  rc      : BOOLEAN;
  timeout : BOOLEAN;
  wrOccTmp: BOOLEAN;
BEGIN
  IF replyPort = NIL THEN RETURN FALSE; END;
  rc := FALSE;
  timeout := FALSE;

  msg := e.GetMsg(g.readPort);
  IF msg = NIL THEN
    IF g.verbosity > g.verbose THEN
      io.WriteString("Warning: No message arrived.\n");
    END;
    RETURN FALSE;
  END;

  IF msg.data = -1 THEN (* User maybe got lost *)
    ReuseMessage(jhmsg, replyPort, aeStatus);
    IF   ~SyncIO(jhmsg)
       OR ( (jhmsg.string[0] = "O") & (jhmsg.string[1] = "F"))
    THEN
      IF g.verbosity > g.normal THEN
        io.WriteString("Lost carrier.\n");
      END;
      IF frontendSig # -1 THEN
        e.Signal(s.VAL(d.ProcessPtr, ol.Me), LONGSET{frontendSig});
      END;
      DISPOSE(msg);
      RETURN FALSE;
    END;
    msg.string[0] := 0X;
    timeout := TRUE;
  END;

  IF ~timeout & gotCR & (msg.string[0] = "\n") THEN
    msg.string[0] := 0X;
  END;

  IF msg.string[0] # 0X THEN
    gotCR := FALSE;
    CASE msg.string[0] OF
    | "\n", "\r", 1CX:
      Write("\n", TRUE);
      g.inLine[g.pos] := "\n";
      g.inLine[g.pos+1] := 0X;
      IF g.writeOccured & ~g.noEcho THEN
        WriteString("\n"); WriteString(g.inLine);
      END;
      COPY(g.inLine, g.line);
      g.pos := 0;
      g.inLine[0] := 0X;
      g.writeOccured := FALSE;
      gotCR := msg.string[0] = "\r";
      rc := TRUE;
    | "\b":
      IF g.pos > 0 THEN
        DEC(g.pos);
        wrOccTmp := g.writeOccured;
        WriteString("\b \b");
        IF g.pos = 0 THEN g.writeOccured := FALSE;
                     ELSE g.writeOccured := wrOccTmp;
        END;
      END;
    ELSE
      Write(msg.string[0], TRUE);
      g.inLine[g.pos] := msg.string[0];
      IF g.pos < g.MaxLineLen-2 THEN INC(g.pos); END;
    END;
  END;

  QueueRead(msg);
  RETURN rc;
END ReadChar;

(*-------------------------------------------------------------------------*)

BEGIN
  replyPort := NIL; frontendSig := -1;
  aePortName := "";
  jhmsg := NIL;
CLOSE
  IF replyPort # NIL THEN ExecSupport.DeletePort(replyPort); END;
  IF frontendSig # -1 THEN e.FreeSignal(frontendSig); END;
  IF jhmsg # NIL THEN DISPOSE(jhmsg); END;
END AmiExpressFront.

(***************************************************************************)
