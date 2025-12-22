MODULE Global;

(*---------------------------------------------------------------------------
** Copyright © 1992-1996 by Lars Düning  -  All rights reserved.
** Permission granted for non-commercial use.
**---------------------------------------------------------------------------
** Various globally accessed variables and functions.
**---------------------------------------------------------------------------
** Oberon: Amiga-Oberon v3.20, F. Siebert / A+L AG
**---------------------------------------------------------------------------
** 10-Oct-93 [lars]
** 15-Nov-93 [lars] inLine, writeOccured, pos added.
** 02-Jan-96 [lars] currentCon moved here from DosHandlFront
**---------------------------------------------------------------------------
*)

(* GarbageCollector- SmallCode SmallData *)

IMPORT
  (* $IF Debug *) Debug, (* $END *)
  Dos, Exec, ExecSupport, OberonLib, Requests, SYSTEM;

(*-------------------------------------------------------------------------*)

CONST
  Version   = "\o$VER: PlayMud 1.9 (01.05.96)";
  version  *= "1.9";
  revision *= "[lars-960501]";

  MaxLineLen* = 256; (* Max length of line read *)

VAR
  frontend   *: INTEGER;     (* Type of Frontend to use *)
  verbosity  *: INTEGER;     (* Verbosity level *)
  noEcho     *: BOOLEAN;     (* Don't repeat input lines *)
  curCon     *: BOOLEAN;     (* Current console was explicitely requested *)
  currentCon *: BOOLEAN;     (* Current console used *)
  conName    *: Exec.STRING; (* Name of console (stream) to open *)
  mudName    *: Exec.STRING; (* Portname of the LPmud, default is 8888 *)
  aeNode     *: LONGINT;     (* Node number invocing us *)
  result     *: INTEGER;     (* The result value upon program termination *)
  line       *: ARRAY MaxLineLen OF CHAR; (* last line read by FrontEnd *)
  readPort   *: Exec.MsgPortPtr;  (* The (reply)port for data from the user. *)
  readSig    *: SHORTINT;         (* Signal raised on new data from the user *)

    (* Used by the frontends *)
  inLine       *: ARRAY MaxLineLen OF CHAR; (* Line buffer *)
  pos          *: INTEGER;
  writeOccured *: BOOLEAN; (* did output clutter our input ? *)

CONST
  (* Verbosity levels *)
  quiet   *= 0;  (* No output except for fatal errors *)
  normal  *= 1;  (* Normal output *)
  verbose *= 2;  (* Verbose output *)
  debug   *= 3;  (* Debugging output *)

  (* Implemented frontends *)
  dosHandler *= 0;  (* Access through interactive DOS handler or console window *)
  amiExpress *= 1;  (* PlayMud runs as AmiExpress door *)

(*-------------------------------------------------------------------------*)
(* $CopyArrays- *)
PROCEDURE PutMsg * (      msg : Exec.MessagePtr
                   ; portName : ARRAY OF CHAR
                   ) : BOOLEAN;

(* Safely put a message to a named global port.
** Return success.
*)

VAR
  port : Exec.MsgPortPtr;
BEGIN
  Exec.Forbid();
  port := Exec.FindPort(portName);
  IF port # NIL THEN Exec.PutMsg (port, msg); END;
  Exec.Permit();
  RETURN (port # NIL);
END PutMsg;

(*-------------------------------------------------------------------------*)

BEGIN
  SYSTEM.SETREG(0, SYSTEM.ADR(Version));  (* So it gets linked in *)
  frontend   := dosHandler;
  verbosity  := normal;
  conName    := "";
  mudName    := "8888";
  noEcho     := FALSE;
  curCon     := FALSE;
  currentCon := FALSE;
  result     := Dos.ok;

  readPort := ExecSupport.CreatePort ("", 0);
  Requests.Assert (readPort # NIL, "Can't open replyport for frontend.");
  readSig := readPort.sigBit;

  pos := -1; inLine[MaxLineLen-1] := 0X;
  writeOccured := FALSE;
CLOSE
  IF readPort # NIL THEN ExecSupport.DeletePort(readPort); END;
  OberonLib.Result := result;
END Global.

(***************************************************************************)
