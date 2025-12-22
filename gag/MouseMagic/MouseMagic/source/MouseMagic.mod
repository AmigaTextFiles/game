(****************************************************************************
**									   **
**  ##     ##  #####  ##   ##  ##### #####  #   #  ##   ### ###  ###       **
**  ###   ### ##   ## ##   ## ##     ##     ## ## #  # #     #  #          **
**  #### #### ##   ## ##   ##  ####  ####   # # # #### #  #  #  #          **
**  ## ### ## ##   ## ##   ##     ## ##     #   # #  #  ### ###  ###       **
**  ##  #  ##  #####   #####  #####  #####                                 **
**									   **
**  written by: Robert Brandner/Schillerstr.3/A-8280 Fürstenfeld/AUSTRIA   **
**									   **
**  This program is written in Modula-II using the compiler M2Amiga V3.3d  **
**									   **
****************************************************************************)

MODULE MouseMagic;

IMPORT Intuition;
FROM Intuition IMPORT IntuitionBasePtr, WindowPtr, IDCMPFlags, IntuiMessagePtr,
     ModifyIDCMP, IDCMPFlagSet;
FROM Graphics IMPORT GetSprite, FreeSprite, ChangeSprite, SimpleSprite,
     MoveSprite;
FROM Exec IMPORT AllocMem, MemReqSet, MemReqs, FreeMem, CopyMem, GetMsg,
     ReplyMsg;
FROM SYSTEM IMPORT ADR, ADDRESS, INLINE;
FROM Dos IMPORT Delay;
FROM Arts IMPORT Error;
FROM Windows IMPORT OpenWindow, CloseWindow, WinGad, WinGadSet;

(* PointerHeight maximal 40: *)

CONST PSIZE = 2*2*(2+40);

VAR sprite : ARRAY[0..6] OF SimpleSprite;
    num : ARRAY[0..6] OF INTEGER;
    mem : ARRAY[0..6] OF ADDRESS;
    msg : IntuiMessagePtr;
    w : WindowPtr;
    ib : IntuitionBasePtr;
    i : INTEGER;
    cl : IDCMPFlagSet;
    end : BOOLEAN;
    x, y : ARRAY[0..6] OF INTEGER;

BEGIN
  OpenWindow(w,350,0,150,10,"Mouse",WinGadSet{closing,moving,arranging});
  IF w=NIL THEN Error(ADR("No window..."), NIL) END;
  ModifyIDCMP(w, IDCMPFlagSet{closeWindow});
  ib := ADR(Intuition);
  FOR i := 0 TO 6 DO
    num[i] := GetSprite(ADR(sprite[i]), -1);
    IF num[i]#-1 THEN
      sprite[i].height := ib^.aPtrHeight;
      mem[i] := AllocMem(PSIZE, MemReqSet{chip, memClear});
      IF mem[i]=NIL THEN

        (* Kein Speicher -> Sprite wieder freigeben: *)

        num[i] := -1;
        FreeSprite(num[i])
      ELSE

        (* Gleiche Grafik und Position wie Mauszeiger: *)

        CopyMem(ib^.aPointer, mem[i], (ib^.aPtrHeight)*4+4);
        ChangeSprite(NIL, ADR(sprite[i]), mem[i]);
        x[i] := ib^.mouseX/2-256+INTEGER(ib^.aXOffset);
        y[i] := ib^.mouseY/2-256+INTEGER(ib^.aYOffset);
      END
    END;
  END;
  IF num[0]=-1 THEN Error(ADR("No Sprite free"),
                          ADR("So program has no use anyhow")) END;

  LOOP
    msg := GetMsg(w^.userPort);
    IF msg#NIL THEN
      cl :=msg^.class;
      ReplyMsg(msg);
      IF closeWindow IN cl THEN EXIT END;
    END;
    FOR i := 5 TO 0 BY -1 DO

      (* Alle Positionen um eins weiterreichen, und Grafik aktualisieren. *)

      x[i+1] := x[i]; y[i+1] := y[i];
      IF num[i+1]#-1 THEN
        CopyMem(ib^.aPointer, mem[i+1], (ib^.aPtrHeight)*4+4);
        sprite[i+1].height := ib^.aPtrHeight;
        ChangeSprite(NIL, ADR(sprite[i+1]), mem[i+1]);
      END;
    END;

    (* Für erstes Sprite die Position und Grafik aktualisieren. *)

    x[0] := ib^.mouseX/2-256+INTEGER(ib^.aXOffset);
    IF ib^.aYOffset=0 THEN
      y[0] := ib^.mouseY/2
    ELSE
      y[0] := ib^.mouseY/2-256+INTEGER(ib^.aYOffset)
    END;
    CopyMem(ib^.aPointer, mem[0], (ib^.aPtrHeight)*4+4);
    sprite[0].height := ib^.aPtrHeight;
    ChangeSprite(NIL, ADR(sprite[0]), mem[0]);

    (* Warten damit die Sprites etwas auseinander liegen. *)

    Delay(1);

    (* Alle Sprites an neuer Position darstellen. *)

    FOR i := 0 TO 6 DO
      IF num[i]#-1 THEN
        MoveSprite(NIL, ADR(sprite[i]), x[i], y[i]);
      END;
    END;
  END;

 (* Belegte Sprites und Speicher freigeben. *)

  CloseWindow(w);
  FOR i := 0 TO 6 DO
    IF num[i]#-1 THEN
      FreeSprite(num[i]);
      FreeMem(mem[i], PSIZE);
    END
  END
END MouseMagic.
