IMPLEMENTATION MODULE attackssprites;

(*$R-*) (* range checking OFF *)

FROM header
  IMPORT squaretype;

FROM Memory
  IMPORT   AllocMem, FreeMem, MemReqSet, MemChip, MemClear;

FROM SYSTEM
  IMPORT ADDRESS, LONGWORD;

(**************************************************************************)
PROCEDURE InitPointers() : BOOLEAN;

(*   This procedure starts the ball rolling for the pointer data.  It     *)
(* allocates chip memory for the sprite images, and copies the informa-   *)
(* tion to those locations.  It returns true only if the memory alloca-   *)
(* tions went ok.                                                         *)
(*                                                                        *)
(*   INPUT                                                                *)
(*            n/a                                                         *)
(*                                                                        *)
(*   OUTPUT                                                               *)
(*                                                                        *)
(*            Returns TRUE only if everything is safe to proceed.         *)

VAR
  success : BOOLEAN;
  t : tempspritetype;    (* holds sprite data *)

BEGIN

success := TRUE;

           (* Get the memory for the sprites *)
circle := tempspriteptr(AllocMem (76, MemReqSet{MemChip, MemClear}));
IF circle = NIL THEN
  success := FALSE;
  ELSE
     mypointer[red] := tempspriteptr(AllocMem (76, MemReqSet{MemChip, MemClear}));
     IF mypointer[red] = NIL THEN
        success := FALSE;
        FreeMem (ADDRESS(circle), 76);
        ELSE
           mypointer[blue] := tempspriteptr(AllocMem (76, MemReqSet{MemChip, MemClear}));
           IF mypointer[blue] = NIL THEN
              success := FALSE;
              FreeMem (ADDRESS(circle), 76);
              FreeMem (ADDRESS(mypointer[red]), 76);
              ELSE
                 emptysquare := tempspriteptr(AllocMem (76, MemReqSet{MemChip, MemClear}));
                 IF emptysquare = NIL THEN
                    success := FALSE;
                    FreeMem (ADDRESS(circle), 76);
                    FreeMem (ADDRESS(mypointer[red]), 76);
                    FreeMem (ADDRESS(mypointer[blue]), 76);
                    ELSE
                       blocksquare := tempspriteptr(AllocMem (76, MemReqSet{MemChip, MemClear}));
                       IF blocksquare = NIL THEN
                          success := FALSE;
                          FreeMem (ADDRESS(circle), 76);
                          FreeMem (ADDRESS(mypointer[red]), 76);
                          FreeMem (ADDRESS(mypointer[blue]), 76);
                          FreeMem (ADDRESS(emptysquare), 76);
                          END  (* if blocksquare *)
                    END (* if emptysquare *)
              END; (* if mypointer[blue] *)
        END;  (* if mypointer[red] *)
  END;  (* if circle *)

IF success THEN
  t[0] := LONGWORD(000000000H);           (* the circle *)
  t[1] := LONGWORD(007E007E0H);             (* 01 is the light color *)
  t[2] := LONGWORD(01EF81918H);             (* 11 is the dark color *)
  t[3] := LONGWORD(0323C2DC4H);             (* 10 is the regular color *)
  t[4] := LONGWORD(069CE57F2H);
  t[5] := LONGWORD(067FE5FA2H);
  t[6] := LONGWORD(0C7FBBD25H);
  t[7] := LONGWORD(0DFFFBCA1H);
  t[8] := LONGWORD(0DFB7B249H);
  t[9] := LONGWORD(0DFFDAD03H);
  t[10] := LONGWORD(0DFE7A819H);
  t[11] := LONGWORD(0FF6B8495H);
  t[12] := LONGWORD(07FE3401FH);
  t[13] := LONGWORD(07ED6412AH);
  t[14] := LONGWORD(03B4E24B6H);
  t[15] := LONGWORD(01E7C19BCH);
  t[16] := LONGWORD(007F007F0H);
  t[17] := LONGWORD(000000000H);
  t[18] := LONGWORD(000000000H);
  circle^ := t;

  t[0] := LONGWORD(000000000H);           (* the red pointer *)
  t[1] := LONGWORD(001FE01FEH);
  t[2] := LONGWORD(0FFFFFF03H);
  t[3] := LONGWORD(0FFFF81F1H);
  t[4] := LONGWORD(07FFF7FE1H);
  t[5] := LONGWORD(007FF0421H);
  t[6] := LONGWORD(007FF07C1H);
  t[7] := LONGWORD(003FF0221H);
  t[8] := LONGWORD(003FF03C3H);
  t[9] := LONGWORD(001FE013EH);
  t[10] := LONGWORD(001E001E0H);
  t[11] := LONGWORD(000000000H);
  t[12] := LONGWORD(000000000H);
  mypointer[red]^ := t;

  t[0] := LONGWORD(000000000H);           (* the blue pointer *)
  t[1] := LONGWORD(07F807F80H);
  t[2] := LONGWORD(0C0FFFFFFH);
  t[3] := LONGWORD(08F81FFFFH);
  t[4] := LONGWORD(087FEFFFEH);
  t[5] := LONGWORD(08420FFE0H);
  t[6] := LONGWORD(083E0FFE0H);
  t[7] := LONGWORD(08440FFC0H);
  t[8] := LONGWORD(0C3C0FFC0H);
  t[9] := LONGWORD(07C807F80H);
  t[10] := LONGWORD(007800780H);
  t[11] := LONGWORD(000000000H);
  t[12] := LONGWORD(000000000H);
  mypointer[blue]^ := t;

  t[0] := LONGWORD(000000000H);           (* the empty square *)
  t[1] := LONGWORD(0FFFFFFFFH);           (* O1 is grey and 11 is black *)
  t[2] := LONGWORD(08001FFFFH);
  t[3] := LONGWORD(08001FFFFH);
  t[4] := LONGWORD(08001FFFFH);
  t[5] := LONGWORD(08001FFFFH);
  t[6] := LONGWORD(08001FFFFH);
  t[7] := LONGWORD(08001FFFFH);
  t[8] := LONGWORD(08001FFFFH);
  t[9] := LONGWORD(08001FFFFH);
  t[10] := LONGWORD(08001FFFFH);
  t[11] := LONGWORD(08001FFFFH);
  t[12] := LONGWORD(08001FFFFH);
  t[13] := LONGWORD(08001FFFFH);
  t[14] := LONGWORD(08001FFFFH);
  t[15] := LONGWORD(0FFFFFFFFH);
  t[16] := LONGWORD(000000000H);
  t[17] := LONGWORD(000000000H);
  emptysquare^ := t;

  t[0] := LONGWORD(000000000H);             (* the block square *)
  t[1] := LONGWORD(00000FFFFH);             (* O1 is lt grey and *)
  t[2] := LONGWORD(00000FFFFH);             (* 10 is medium grey *)
  t[3] := LONGWORD(03FFFC003H);             (* 11 is dark grey *)
  t[4] := LONGWORD(03FFFC003H);
  t[5] := LONGWORD(03FFFC003H);
  t[6] := LONGWORD(03FFFC003H);
  t[7] := LONGWORD(03FFFC003H);
  t[8] := LONGWORD(03FFFC003H);
  t[9] := LONGWORD(03FFFC003H);
  t[10] := LONGWORD(03FFFC003H);
  t[11] := LONGWORD(03FFFC003H);
  t[12] := LONGWORD(03FFFC003H);
  t[13] := LONGWORD(03FFFC003H);
  t[14] := LONGWORD(03FFFC003H);
  t[15] := LONGWORD(07FFFFFFFH);
  t[16] := LONGWORD(0FFFFFFFFH);
  t[17] := LONGWORD(000000000H);
  t[18] := LONGWORD(000000000H);
  blocksquare^ := t;

  END; (* if success *)

  RETURN success;
END InitPointers;


(***************************************************************)

END attackssprites.
