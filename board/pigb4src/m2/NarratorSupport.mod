IMPLEMENTATION MODULE NarratorSupport;

(*$ DEFINE Test:=FALSE *)
(*$ DEFINE Test0:=FALSE *)
(*$ DEFINE Chks:=TRUE *)
(*$ DEFINE True:=TRUE *) (* For at kunne enable/disable kommenterede procs *)

(*$ LongAlign:=TRUE StackParms:=TRUE CStrings:=TRUE LargeVars:=FALSE *)
(*$ IF Chks *)
  (*$ Volatile:=FALSE StackChk:=TRUE RangeChk:=TRUE OverflowChk:=TRUE
  NilChk:=TRUE EntryClear:=TRUE CaseChk:=TRUE ReturnChk:=TRUE *)
(*$ ELSE *)
  (*$ Volatile:=TRUE StackChk:=FALSE RangeChk:=FALSE OverflowChk:=FALSE
  NilChk:=FALSE EntryClear:=FALSE CaseChk:=FALSE ReturnChk:=FALSE *)
(*$ ENDIF *)

(* --------------------------------------------------------------------------
 * BASED ON Narrator Device routines in ROM Kernal Manual by  Rob Peck
 *
 * M2Amiga Modula-2 adaptation by Anthony Bryant
 * -------------------------------------------------------------------------*)
 
FROM SYSTEM IMPORT
 ADR,ADDRESS,LONGSET;
 
FROM Narrator IMPORT
 narratorName,phonErr,noWrite,male,female,natural,robotic,IONarrator,
 IONarratorPtr,Mouth,MouthPtr,minRate,maxRate,minPitch,maxPitch,minFreq,
 maxFreq,minVol,maxVol;
 
FROM ExecD IMPORT
 MsgPortPtr, write, read;

FROM ExecL IMPORT
 OpenDevice, CloseDevice, DoIO, SendIO;
 
FROM ExecSupport IMPORT
 CreatePort, DeletePort, CreateExtIO, DeleteExtIO;

VAR  (* global *)
   voicePort,mouthPort: MsgPortPtr; 
   voiceRequest: IONarratorPtr;
   mouthRequest: MouthPtr;
   audChanMasks: ARRAY [0..3] OF SHORTCARD; (* channel masks *)
   
(* PrepareNarrator - Open Narrator Device and initialize a Narrator IORequest
 * block with defaults or if there was a problem, return error code (or zero 
 * if success)   [see DEFINITION MODULE Narrator for possible error codes]
 *) 
PROCEDURE PrepareNarrator(): LONGINT;
 VAR
   error: LONGINT;

 BEGIN
   error:= -1; (* assume failure ! *)
   	
   voicePort:= CreatePort(0,0);
   IF (voicePort = NIL) THEN RETURN (error); END; (* error during CreatePort *)

   voiceRequest:= IONarratorPtr(CreateExtIO(voicePort,SIZE(IONarrator)));
   IF (voiceRequest = NIL) THEN
      DeletePort(voicePort); RETURN (error);      (* error during CreateExtIO *)
   END;
    
   (* now set up channel masks *)
   audChanMasks[0]:=  3; audChanMasks[1]:= 5; 
   audChanMasks[2]:= 10; audChanMasks[3]:= 12;
   
   voiceRequest^.chMasks:= ADR(audChanMasks);
   voiceRequest^.nmMasks:= 4;
     
   (* open device and initialize with defaults - defPitch, defRate, etc *)
    	
   OpenDevice(ADR(narratorName), 0, voiceRequest, LONGSET{});
   error:= LONGINT(voiceRequest^.message.error);
    
   IF (error # 0) THEN                         (* error during OpenDevice *)
	DeleteExtIO(voiceRequest);
	DeletePort(voicePort);
   END;
    
   RETURN (error);  (* should be zero, indicating success ! *)
 END PrepareNarrator;



(* CloseNarrator - Close Narrator Device and free structures.
 *)
PROCEDURE CloseNarrator();
 BEGIN
 
   IF (voiceRequest # NIL) THEN
       CloseDevice(voiceRequest);
       DeleteExtIO(voiceRequest);
   END;
    
   IF (voicePort # NIL) THEN
       DeletePort(voicePort);
   END;
    
 END CloseNarrator;



(* SetVoiceParams - change default parameters .. (-1) if no change
 *                  otherwise parameter is checked for min/max bounds
 *)
PROCEDURE SetVoiceParams(rate, pitch, mode, sex, vol, freq: INTEGER);
 BEGIN
  IF (voiceRequest # NIL) THEN (* proceed *)
 
   IF (rate >= minRate) AND (rate <= maxRate) THEN
      voiceRequest^.rate:= CARDINAL(rate); (* a new rate *)
   END;
   IF (pitch >= minPitch) AND (pitch <= maxPitch) THEN
      voiceRequest^.pitch:= CARDINAL(pitch);   (* a new pitch *)
   END;
   IF (mode = natural) OR (mode = robotic) THEN
      voiceRequest^.mode:= CARDINAL(mode);   (* a new mode *)
   END;
   IF (sex = male) OR (sex = female) THEN
      voiceRequest^.sex:= CARDINAL(sex); (* a new sex ? *)
   END;
   IF (vol >= minVol) AND (vol <= maxVol) THEN
      voiceRequest^.volume:= CARDINAL(vol); (* set a new volume *)
   END;
   IF (freq >= minFreq) AND (freq <= maxFreq) THEN
      voiceRequest^.sampFreq:= CARDINAL(freq); (* set a new sample frequency *)
   END;
   
  END; (* IF *)
 END SetVoiceParams;


(* Say - after translation, say these phoneme codes
 *)
PROCEDURE Say(outPhonemes: ADDRESS; outLen: LONGINT): LONGINT;
 VAR
   error: LONGINT;
   
 BEGIN
 error:= -1; (* assume failure *)
 IF (voiceRequest # NIL) THEN (* proceed *)
 
   WITH voiceRequest^.message DO
     data:= ADDRESS(outPhonemes);  (* phonemes to say *)
     length:= LONGCARD(outLen);
     command:= write;  (* CMD_WRITE *)
   END;
   
   DoIO(voiceRequest);        (* post request to narrator device *)
   error:= LONGINT(voiceRequest^.message.error);
   
   (* check the io_Error field for a phoneme error (ND_PhonErr  -20) and 
    * if so, then io_Actual field is the position where the error occured
    *)
   IF (error = phonErr) THEN 
     error:= LONGINT(voiceRequest^.message.actual); (* send position instead *)
    END;
   
 END; (* IF *)
 
 RETURN (error);   (* should be zero, else check Narrator error code *)
 END Say;


(* PrepareMouth - initialize a Mouth IORequest block with defaults 
 * AFTER preparing Narrator device !!! or if there was a problem, 
 * return error code (or zero if success)   
 * [see DEFINITION MODULE Narrator for possible error codes]
 *) 
PROCEDURE PrepareMouth(): LONGINT;
 VAR
   error: LONGINT;
 BEGIN
   error:= -1; (* assume failure ! *)
   IF voiceRequest = NIL THEN  RETURN (error); END;
   	
   mouthPort:= CreatePort(0,0);
   IF (mouthPort = NIL) THEN RETURN (error); END; (* error during CreatePort *)

   mouthRequest:= MouthPtr(CreateExtIO(mouthPort,SIZE(Mouth)));
   IF (mouthRequest = NIL) THEN
      DeletePort(mouthPort); RETURN (error);      (* error during CreateExtIO *)
   END;
   
   (* Set up the parameters for the read-message to the Narrator device *)
   (* tell narrator for whose speech a mouth is to be generated *)
   mouthRequest^.voice.message.device:= voiceRequest^.message.device;
   mouthRequest^.voice.message.unit:= voiceRequest^.message.unit;
   mouthRequest^.width:= 0;  
   mouthRequest^.height:= 0;  (* initial mouth parameters *)
   mouthRequest^.voice.message.command:= read;  (* CMD_READ *)
   mouthRequest^.voice.message.error:= 0;	
   
   (* Send an asynchronous write request to the device *)
   voiceRequest^.mouths:= 1; (* ask that mouths be calculated during speech *)
   SendIO(voiceRequest);
   error:= LONGINT(voiceRequest^.message.error);
  
   RETURN (error);  (* should be zero, indicating success ! *)
 END PrepareMouth;



(* CloseMouth - Close Mouth and free structures BEFORE Closing Narrator device!
 *)
PROCEDURE CloseMouth();
 BEGIN
   IF (mouthRequest # NIL) THEN
       DeleteExtIO(mouthRequest);
   END;
   IF (mouthPort # NIL) THEN
       DeletePort(mouthPort);
   END;
 END CloseMouth;


(* ReadMouth - keep sending reads until it comes back saying "no write in 
 * progress" then pass control to your own drawMouth() procedure
 *)
PROCEDURE ReadMouth(drawMouth: PROC);
VAR
   error: LONGINT;
BEGIN
   error:= 0;
   WHILE (error # noWrite) DO
     (* put task to sleep waiting for a different mouth shape or 
      * return of the message block with the error field showing ND_NoWrite
      * in process.
      *)  
     DoIO(mouthRequest);  (* post request to narrator device *)
     error:= LONGINT(mouthRequest^.voice.message.error);
   
     drawMouth();  (* user's own unique routine *)
   END;
END ReadMouth;   

END NarratorSupport.imp
