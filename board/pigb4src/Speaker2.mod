MODULE Speaker;
(*$ DEFINE Test:=FALSE *)
(*$ LongAlign:=TRUE StackParms:=TRUE CStrings:=TRUE LargeVars:=FALSE *)
(*$ IF Test *)
  (*$ Volatile:=FALSE StackChk:=TRUE RangeChk:=TRUE OverflowChk:=TRUE
  NilChk:=TRUE EntryClear:=TRUE CaseChk:=TRUE ReturnChk:=TRUE *)
(*$ ELSE *)
  (*$ Volatile:=TRUE StackChk:=FALSE RangeChk:=FALSE OverflowChk:=FALSE
  NilChk:=FALSE EntryClear:=FALSE CaseChk:=FALSE ReturnChk:=FALSE *)
(*$ ENDIF *)

FROM SYSTEM IMPORT
  ADR, ADDRESS;
FROM ExecD IMPORT 
  Message, MessagePtr, MsgPort, MsgPortPtr;
FROM ExecL IMPORT 
  PutMsg, GetMsg, ReplyMsg, WaitPort;
FROM ExecSupport IMPORT
  CreatePort, DeletePort;
FROM String IMPORT
  Length;
FROM NarratorSupport IMPORT
  PrepareNarrator, CloseNarrator, SetVoiceParams, Say;
    (* parameters: rate,pitch,mode,sex,vol,freq                 *)
    (* SetVoiceParams(-1,-1,-1,-1,-1,-1);  change no parameters *)
    (* IF Say('GUHDAE1, MEHD DAY.',17) THEN END;                *)

TYPE
  STRING=ARRAY[0..80] OF CHAR;
  STRPTR=POINTER TO STRING;

VAR
  mdls    : MessagePtr;
  mp      : MsgPortPtr;
  lnNavn  : STRING;
  stp     : STRPTR;
  error   : INTEGER;
BEGIN
  error:=PrepareNarrator();
  IF error=0 THEN
    mp:=CreatePort(ADR("Speaker"),0);         (* meddelelsesport *)
    IF mp<>NIL THEN
      REPEAT   (* hent næste meddelelse der er i mp *)
        WaitPort(mp);               (* vent på svar i mp *)
        mdls:=GetMsg(mp);           (* hent svar i mp *)
        stp:=STRPTR(mdls^.node.name);    (* lnName der er af typen ADDRESS kon-*)
                                         (* verteres til en POINTER TO STRING  *)
        IF stp<>NIL THEN 
          IF Say(stp,Length(stp^))=0 THEN END;
        END;
        ReplyMsg(mdls);    (* svarer, lægges i sp *)
      UNTIL stp=NIL;
      DeletePort(mp);
    END;
    CloseNarrator;
  END;
END Speaker.
