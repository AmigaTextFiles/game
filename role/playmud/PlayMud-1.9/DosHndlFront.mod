MODULE DosHndlFront;

(*---------------------------------------------------------------------------
** Copyright © 1992-1996 by Lars Düning  -  All rights reserved.
** Permission granted for non-commercial use.
**---------------------------------------------------------------------------
** A simple string oriented interface to a(ny) stream handler for PlayMud,
** featuring asynchronous reads.
** When using as console, it's most useful with ConMan in non-blocking mode.
**---------------------------------------------------------------------------
** Oberon: Amiga-Oberon v3.00, F. Siebert / A+L AG
**---------------------------------------------------------------------------
** 10-May-92 [lars]
** 02-Apr-93 [lars] adapted for Oberon 3.00
** 03-May-93 [lars] Nonexistance of CNN: generates no requester anymore.
** 06-Sep-93 [lars] The current console can be opened explicitely.
** 10-Oct-93 [lars] Source reorganisation.
** 12-Nov-93 [lars] Added some sensitivity of g.verbosity
** 25-Feb-94 [lars] Writes weren't asynchronous, now they are.
** 02-Jan-96 [lars] currentCon moved into Global
** 01-May-96 [lars] CNN: is no longer tried.
**                  Added attribute "/CLOSE" to default CON: console.
**---------------------------------------------------------------------------
*)

(* GarbageCollector- SmallCode SmallData *)

IMPORT
  (* $IF Debug *) Debug, (* $END *)
  g:Global,
  d:Dos, e:Exec, ExecSupport, i:Intuition,
  io, ol:OberonLib, str:Strings, s:SYSTEM;

(*-------------------------------------------------------------------------*)

TYPE
  String = UNTRACED POINTER TO ARRAY OF CHAR;

  WritePacketPtr = UNTRACED POINTER TO WritePacket;
  WritePacket = STRUCT
    (pkt : d.StandardPacket)
    txt : String;
  END;

VAR
  con          : d.FileHandlePtr;
  window       : i.WindowPtr;   (* Pointer to Console Window if any *)
  replyPort    : e.MsgPortPtr;  (* Replyport for synchronous messages to AExpress *)
  winSig       : SHORTINT;      (* Signal from window *)

(*-------------------------------------------------------------------------*)
PROCEDURE ReUseStdPacket ( packet : d.StandardPacketPtr;
                           port : e.MsgPortPtr; type : LONGINT;
                           arg1, arg2, arg3 : LONGINT
                          );
BEGIN
  IF packet # NIL THEN
    packet.msg.node.name := s.ADR(packet.pkt);
    packet.msg.replyPort := port;
    packet.pkt.link := s.VAL(e.MessagePtr, packet);
    packet.pkt.port := packet.msg.replyPort;
    packet.pkt.type := type;
    packet.pkt.arg1 := arg1;
    packet.pkt.arg2 := arg2;
    packet.pkt.arg3 := arg3;
  END;
END ReUseStdPacket;

(*-------------------------------------------------------------------------*)
PROCEDURE CreateStdPacket (port : e.MsgPortPtr; type : LONGINT;
                           arg1, arg2, arg3 : LONGINT
                          ) : d.StandardPacketPtr;
VAR
  packet : d.StandardPacketPtr;
BEGIN
  NEW (packet);
  ReUseStdPacket (packet, port, type, arg1, arg2, arg3);
  RETURN packet;
END CreateStdPacket;

(*-------------------------------------------------------------------------*)
PROCEDURE GetConInfo;

(* Get the console info from the opened console stream.
*)

VAR
  reply : e.MessagePtr;
  packet : d.StandardPacketPtr;
  iData : d.InfoDataPtr;
  iDataB : BPOINTER TO d.InfoData;
BEGIN
  (* Stream opened, now get info about it if ConsoleHandler *)
  window := NIL;
  IF con.type # NIL THEN
    ol.New (iData, SIZE(d.InfoData));
    IF iData # NIL THEN
      iDataB := s.VAL(s.ADDRESS, iData);
      packet := CreateStdPacket (g.readPort, d.diskInfo
                                , s.VAL(LONGINT, iDataB), 0, 0);
      IF packet # NIL THEN
        e.PutMsg (con.type, packet);
        e.WaitPort (g.readPort);
        reply := e.GetMsg(g.readPort);
        IF packet.pkt.res1 # d.DOSFALSE THEN
          window := s.VAL(i.WindowPtr, iData.volumeNode);
        END;
        DISPOSE (packet);
      ELSE
        io.WriteString ("Warning: Not enough mem for console info.\n");
      END;
      DISPOSE (iData);
    ELSE
      io.WriteString ("Warning: Not enough mem for console info.\n");
    END;
  END;
END GetConInfo;

(*-------------------------------------------------------------------------*)
PROCEDURE Open * (stream : ARRAY OF CHAR) : BOOLEAN; (* $CopyArrays- *)

(* Open the named stream for I/O. If no name is given, following defaults
** are tried in given order:
**   CON:0/11/640/225/A-LPmud/CLOSE
** Success is returned.
*)

VAR
  len : LONGINT;
  oldWin : i.WindowPtr;
  me : d.ProcessPtr;

(* To open optional console handlers, use this sequence to suppress
 * requesters:
 *   oldWin := me.windowPtr;
 *   me.windowPtr := s.VAL (i.WindowPtr, -1);  (* suppresses requester *)
 *   con := d.Open ("CNN:/11///AmigaLPmud/c", d.newFile);
 *   me.windowPtr := oldWin;
 *)

BEGIN
  IF con # NIL THEN
    io.WriteString ("Error: Open console already exists.\n");
    RETURN FALSE;
  END;

  replyPort := ExecSupport.CreatePort("", 0);
  IF replyPort = NIL THEN
    io.WriteString("Error: Can't open replyport for console messages.\n");
    RETURN FALSE;
  END;

  g.currentCon := FALSE;
  len := str.Length(stream);
  con := NIL;
  IF len = 0 THEN
    me := s.VAL (d.ProcessPtr, ol.Me);
    con := d.Open ("CON:/11///AmigaLPmud/CLOSE", d.newFile);
    IF con # NIL THEN
      IF g.verbosity # g.quiet THEN
        io.WriteString ("  Console CON:/11///AmigaLPmud/CLOSE \n");
      END;
    ELSE
      io.WriteString ("Error: Can't open any console.\n");
      ExecSupport.DeletePort(replyPort); replyPort := NIL;
      RETURN FALSE;
    END;
  ELSE
    con := d.Open (stream, d.newFile);
    IF con = NIL THEN
      io.WriteString ("Error: Can't open ");
      io.WriteString (stream);
      io.WriteLn;
      ExecSupport.DeletePort(replyPort); replyPort := NIL;
      RETURN FALSE;
    ELSIF g.verbosity # g.quiet THEN
      io.WriteString ("  Console ");
      io.WriteString (stream);
      io.WriteLn;
    END;
  END;
  IF ~d.IsInteractive(con) THEN (* Late, but at last.. *)
    io.WriteString ("Error: Console is not interactive.\n");
    s.SETREG(0, d.Close(con));
    con := NIL;
    ExecSupport.DeletePort(replyPort); replyPort := NIL;
    RETURN FALSE;
  END;

  (* Stream opened, now get info about it if ConsoleHandler *)
  GetConInfo;
  RETURN TRUE;
END Open;

(*-------------------------------------------------------------------------*)
PROCEDURE OpenCurrent * () : BOOLEAN;

(* Open the current console (either Input() or Output()) for I/O.
** Success is returned.
*)

BEGIN
  IF con # NIL THEN
    io.WriteString ("Error: Open console already exists.\n");
    RETURN FALSE;
  END;

  replyPort := ExecSupport.CreatePort("", 0);
  IF replyPort = NIL THEN
    io.WriteString("Error: Can't open replyport for console messages.\n");
    RETURN FALSE;
  END;

  IF d.Input # NIL THEN
    con := d.Input();
    IF g.verbosity # g.quiet THEN
      io.WriteString ("  Console is current input\n");
    END;
  ELSIF d.Output # NIL THEN
    con := d.Input();
    IF g.verbosity # g.quiet THEN
      io.WriteString ("  Console is current output\n");
    END;
  ELSE
    io.WriteString ("Error: No current console.\n");
    ExecSupport.DeletePort(replyPort); replyPort := NIL;
    RETURN FALSE;
  END;
  IF ~d.IsInteractive(con) THEN
    io.WriteString ("Error: Console is not interactive.\n");
    con := NIL;
    ExecSupport.DeletePort(replyPort); replyPort := NIL;
    RETURN FALSE;
  END;

  g.currentCon := TRUE;
  GetConInfo;
  RETURN TRUE;
END OpenCurrent;

(*-------------------------------------------------------------------------*)
PROCEDURE Close * ();

(* Closes any open console stream *)

VAR
  msg : e.MessagePtr;
BEGIN
  IF con = NIL THEN RETURN; END;
  IF ~g.currentCon THEN s.SETREG(0, d.Close(con)); END;
  con := NIL; window := NIL; g.currentCon := FALSE; winSig := -1;
  IF g.verbosity # g.quiet THEN io.WriteString ("Console stream closed.\n"); END;
  IF g.readPort = NIL THEN RETURN; END;
  IF g.verbosity # g.quiet THEN io.WriteString ("Collecting left packets..."); END;
  msg := e.GetMsg(replyPort);
  WHILE msg # NIL DO msg := e.GetMsg(replyPort); END;
  ExecSupport.DeletePort(replyPort); replyPort := NIL;
  msg := e.GetMsg(g.readPort);
  WHILE msg # NIL DO msg := e.GetMsg(g.readPort); END;
  (* the mem or our msgs will be automagically freed on programs exit *)
  IF g.verbosity # g.quiet THEN io.WriteString ("done.\n"); END;
END Close;

(*-------------------------------------------------------------------------*)
PROCEDURE FrontendSig * () : LONGSET;

(* Return the signal which is set if a message arrives from the user.
** Return -1 for no signal.
** This also sets the console window to accept closeWindow events.
*)

VAR
  signals : LONGSET;
BEGIN
  winSig := -1;
  IF (con # NIL) & (window # NIL) THEN
   IF window.userPort = NIL THEN signals := LONGSET{i.closeWindow};
    ELSE
      signals := window.idcmpFlags;
      INCL(signals, i.closeWindow);
    END;
    i.OldModifyIDCMP (window, signals);
    IF window.userPort # NIL THEN
      winSig := window.userPort.sigBit;
    END;
  END;
  signals := LONGSET{};
  IF winSig # -1 THEN
    INCL(signals, winSig);
  END;
  IF replyPort # NIL THEN
    INCL(signals, replyPort.sigBit);
  END;
  RETURN signals;
END FrontendSig;

(*-------------------------------------------------------------------------*)
PROCEDURE HandleYourSig * (signals : LONGSET; VAR abort : BOOLEAN);

(* If PlayMud got a 'FrontendSig' (= a signal from the console window),
** it calls this functions and leaves it to us to handle the signal.
** If an aborting condition is detected, 'abort' is to be set to TRUE,
** else is mustn't be changed.
*)

VAR
  winMsg : i.IntuiMessagePtr;
  pkt : WritePacketPtr;
BEGIN
  IF (con # NIL) & (window # NIL) & (winSig # -1) & (winSig IN signals) THEN
    winMsg := e.GetMsg (window.userPort);
    WHILE winMsg # NIL DO
      IF i.closeWindow IN winMsg.class THEN abort := TRUE; END;
      e.ReplyMsg(winMsg);
      winMsg := e.GetMsg (window.userPort);
    END;
  END;
  IF (replyPort # NIL) & (replyPort.sigBit IN signals) THEN
    pkt := e.GetMsg(replyPort);
    WHILE pkt # NIL DO
      IF g.verbosity > g.verbose THEN io.WriteString("ConReply "); END;
      DISPOSE(pkt.txt);
      DISPOSE(pkt);
      pkt := e.GetMsg(replyPort);
    END;
  END;
END HandleYourSig;

(*-------------------------------------------------------------------------*)
PROCEDURE Write (ch : CHAR);

(* Write a single character to console *)

VAR
  packet : WritePacketPtr;
  txt    : String;
BEGIN
  IF con = NIL THEN RETURN; END;
  NEW(packet);
  IF packet = NIL THEN
    io.WriteString("Error: Not enough mem for packet - character discarded.\n");
    RETURN;
  END;
  NEW(txt, 2);
  IF txt = NIL THEN
    io.WriteString("Error: Not enough mem for string - character discarded.\n");
    DISPOSE(packet);
    RETURN;
  END;
  packet.txt := txt;
  ReUseStdPacket(packet, replyPort, d.write, con.arg1, s.ADR(packet.txt[0]), 1);
  packet.txt[0] := ch;
  packet.txt[1] := 0X;
  e.PutMsg(con.type, packet);
  IF g.verbosity > g.verbose THEN io.WriteString("ToCon "); END;
  IF g.pos > 0 THEN g.writeOccured := TRUE; END;
END Write;

(*-------------------------------------------------------------------------*)
PROCEDURE PutString * (text : ARRAY OF CHAR; len : LONGINT); (* $CopyArrays- *)

(* Write a string of given length to console *)

VAR
  txt : String;
  packet : WritePacketPtr;
BEGIN
  IF con = NIL THEN RETURN; END;
  NEW(packet);
  IF packet = NIL THEN
    io.WriteString("Error: Not enough mem for packet - text discarded.\n");
    RETURN;
  END;
  NEW(txt, len+1);
  IF txt = NIL THEN
    io.WriteString("Error: Not enough mem for string - text discarded.\n");
    DISPOSE(packet);
    RETURN;
  END;
  packet.txt := txt;
  ReUseStdPacket(packet, replyPort, d.write, con.arg1, s.ADR(packet.txt[0]), len);
  str.Cut(text, 0, len, packet.txt^);
  packet.txt[len] := 0X;
  e.PutMsg(con.type, packet);
  IF g.verbosity > g.verbose THEN io.WriteString("ToCon "); END;
  IF g.pos > 0 THEN g.writeOccured := TRUE; END;
END PutString;

(*-------------------------------------------------------------------------*)
PROCEDURE WriteString * (text : ARRAY OF CHAR); (* $CopyArrays- *)

(* Write a null-terminated string to console *)

BEGIN
  PutString(text, str.Length(text));
END WriteString;

(*-------------------------------------------------------------------------*)
PROCEDURE QueueRead * (packet : d.StandardPacketPtr);

(* Sends one read request for one character to console.
** If a packet is to be reused, it may be given, else NIL.
** As buffer, g.inLine[++g.pos] is given.
** This fun must be called directly after Open() once to initiate reads !
*)

BEGIN
  IF con = NIL THEN RETURN; END;
  IF g.pos < g.MaxLineLen-3 THEN INC(g.pos); END;
  IF packet # NIL THEN
    ReUseStdPacket (packet, g.readPort, d.read, con.arg1, s.ADR(g.inLine[g.pos]), 1);
  ELSE
    packet := CreateStdPacket (g.readPort,d.read, con.arg1,s.ADR(g.inLine[g.pos]),1);
  END;
  IF packet # NIL THEN e.PutMsg (con.type, packet);
  ELSE io.WriteString ("Error: Not enough mem for packet.\n");
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
  packet : d.StandardPacketPtr;
  rc     : BOOLEAN;
BEGIN
  IF con = NIL THEN RETURN FALSE; END;
  rc := FALSE;
  packet := e.GetMsg(g.readPort);
  IF packet = NIL THEN
    IF g.verbosity > g.verbose THEN
      io.WriteString ("Warning: No packet arrived.\n");
    END;
    RETURN FALSE;
  END;

  IF packet.pkt.res1 = 1 THEN
    CASE g.inLine[g.pos] OF "\n", 1CX, 0X :
      g.inLine[g.pos+1] := 0X;
      IF g.writeOccured & ~g.noEcho THEN
        WriteString ("\n"); WriteString (g.inLine);
      END;
      COPY(g.inLine, g.line); g.pos := -1;
      g.writeOccured := FALSE;
      rc := TRUE;
    ELSE
    END;
  END;
  QueueRead(packet);
  RETURN rc;
END ReadChar;

(*-------------------------------------------------------------------------*)

BEGIN
  window := NIL;
  replyPort := NIL;
  winSig := -1;
CLOSE
  IF replyPort # NIL THEN ExecSupport.DeletePort(replyPort); END;
END DosHndlFront.

(*=========================================================================*)
