MODULE FrontEnd;

(*---------------------------------------------------------------------------
** Copyright © 1992-1996 by Lars Düning  -  All rights reserved.
** Permission granted for non-commercial use.
**---------------------------------------------------------------------------
** Interfacing layer between PlayMud and the user io.
**---------------------------------------------------------------------------
** Oberon: Amiga-Oberon v3.201, F. Siebert / A+L AG
**---------------------------------------------------------------------------
** 12-Oct-93 [lars]
** 12-Nov-93 [lars] Added AmiExpressFront.
** 25-Feb-94 [lars] The frontend may now return several signals.
**---------------------------------------------------------------------------
*)

(* GarbageCollector- SmallCode SmallData *)

IMPORT
  (* $IF Debug *) Debug, (* $END *)
  g:Global, dh:DosHndlFront, ae:AmiExpressFront;

(*-------------------------------------------------------------------------*)
PROCEDURE Open * () : BOOLEAN;

(* Open the frontend to the user *)

BEGIN
  CASE g.frontend OF
  | g.dosHandler:
      IF g.curCon THEN
        IF ~dh.OpenCurrent()  THEN
          RETURN FALSE;
        END;
      ELSIF ~dh.Open(g.conName) THEN
        RETURN FALSE;
      END;
      RETURN TRUE;
  | g.amiExpress:
      RETURN ae.Open(g.aeNode);
  END;
  RETURN FALSE;
END Open;

(*-------------------------------------------------------------------------*)
PROCEDURE Close * ();

(* Closes any open console stream *)

BEGIN
  CASE g.frontend OF
  | g.dosHandler : dh.Close();
  | g.amiExpress : ae.Close();
  ELSE
  END;
END Close;

(*-------------------------------------------------------------------------*)
PROCEDURE FrontendSig * () : LONGSET;

(* Return the signals which are set if e.g. a message arrives from the user.
** Return {} for no signal.
*)

BEGIN
  CASE g.frontend OF
  | g.dosHandler : RETURN dh.FrontendSig();
  | g.amiExpress : RETURN ae.FrontendSig();
  END;
  RETURN LONGSET{};
END FrontendSig;

(*-------------------------------------------------------------------------*)
PROCEDURE HandleYourSig * (signals : LONGSET; VAR abort : BOOLEAN);

(* If PlayMud got one or more 'signals', it calls this functions and leaves it
** to us to handle the signal.
** If an aborting condition is detected, 'abort' is to be set to TRUE,
** else is mustn't be changed.
*)

BEGIN
  CASE g.frontend OF
  | g.dosHandler : dh.HandleYourSig(signals, abort);
  | g.amiExpress : ae.HandleYourSig(signals, abort);
  END;
END HandleYourSig;

(*-------------------------------------------------------------------------*)
PROCEDURE WriteString * (text : ARRAY OF CHAR); (* $CopyArrays- *)

(* Write a null-terminated string to the user *)

BEGIN
  CASE g.frontend OF
  | g.dosHandler : dh.WriteString(text);
  | g.amiExpress : ae.WriteString(text);
  END;
END WriteString;

(*-------------------------------------------------------------------------*)
PROCEDURE PutString * (text : ARRAY OF CHAR; len : LONGINT); (* $CopyArrays- *)

(* Write a string of given length to the user *)

BEGIN
  CASE g.frontend OF
  | g.dosHandler : dh.PutString(text, len);
  | g.amiExpress : ae.PutString(text, len);
  END;
END PutString;

(*-------------------------------------------------------------------------*)
PROCEDURE QueueRead * ();

(* Send out one read request to initiate asynchronous reads.
** Upon return of that request to readPort, readSig has to be set.
*)

BEGIN
  CASE g.frontend OF
  | g.dosHandler : dh.QueueRead(NIL);
  | g.amiExpress : ae.QueueRead(NIL);
  END;
END QueueRead;

(*-------------------------------------------------------------------------*)
PROCEDURE ReadChar * () : BOOLEAN;

(* Reads in a received ReadRequest and queues up a new one.
** If the request completed a line, it will be copied in to g.line.
** If necessary, this line will be echoed.
** Returns condition "line completed".
*)

BEGIN
  CASE g.frontend OF
  | g.dosHandler : RETURN dh.ReadChar();
  | g.amiExpress : RETURN ae.ReadChar();
  END;
  RETURN FALSE;
END ReadChar;

(*-------------------------------------------------------------------------*)

CLOSE
  Close();
END FrontEnd.

(***************************************************************************)
