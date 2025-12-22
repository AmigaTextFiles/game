IMPLEMENTATION MODULE ILBMread; (* for M2Amiga V4.0 *)

(*$ DEFINE Test:=FALSE *)
(*$ DEFINE Test0:=FALSE *)
(*$ DEFINE Chks:=FALSE *)
(*$ DEFINE True:=TRUE *) (* For at kunne enable/disable kommenterede procs *)

(*$ LongAlign:=FALSE StackParms:=TRUE CStrings:=TRUE LargeVars:=TRUE *)
(*$ IF Chks *)
  (*$ Volatile:=FALSE StackChk:=TRUE RangeChk:=TRUE OverflowChk:=TRUE
  NilChk:=TRUE EntryClear:=TRUE CaseChk:=TRUE ReturnChk:=TRUE *)
(*$ ELSE *)
  (*$ Volatile:=TRUE StackChk:=FALSE RangeChk:=FALSE OverflowChk:=FALSE
  NilChk:=FALSE EntryClear:=FALSE CaseChk:=FALSE ReturnChk:=FALSE *)
(*$ ENDIF *)

(*
 10-95 window adjusted
 10-95 now only IFF FORM-ILBM BMHD,CMAP,BODY is read (else use ILBMread2)
 10-95 ByteRun1 stops when a word-sized line is generated
*)

FROM SYSTEM IMPORT
  SHIFT,ADR,ADDRESS,BITSET,ASSEMBLE;

FROM FileSystem IMPORT
  File, Response, Lookup, Close, ReadChar, ReadBytes,
  SetPos, GetPos;

(*$ IF Test *)
FROM W IMPORT 
  WRITE, WRITELN, READs, s, l, lf;
(*$ ENDIF *)

FROM Heap IMPORT
  AllocMem, Deallocate;

FROM GraphicsD IMPORT
  ViewModeSet;

FROM IntuitionD IMPORT
  ImagePtr;

FROM QuickIntuition IMPORT
  MakeImage;

TYPE

  (* A BitMapHeader is stored in a BMHD chunk *)
  BitMapHeader=RECORD
    w, h: CARDINAL;	(* width and height in pixels of raster *)
    x, y: INTEGER;	(* top left corner position *)
    nPlanes: SHORTCARD;	(* number of bit planes *)
    masking: SHORTCARD;      (* Choice of masking technique - may be more in the future *)
    compression: SHORTCARD;  (* Choice of compression algorithm - may be more in the future *)                          
    pad1: SHORTCARD; 	(* pad byte unused *)
    transparentColor: CARDINAL;	 (* color of background/border *)
    xAspect, yAspect: SHORTCARD;
    pageWidth, pageHeight: INTEGER;
  END;
  BitMapHeaderPtr=POINTER TO BitMapHeader;

  (* A Point2D is stored in a GRAB chunk *)
  Point2D=RECORD
    x, y: INTEGER;  (* relative pixel coordinates *)
  END;
  Point2DPtr=POINTER TO Point2D;

  (* A DestMerge is stored in a DEST chunk *)
  DestMerge=RECORD
    depth: SHORTCARD;         (* # bitplanes in source *)
    pad1: SHORTCARD;	
    planePick: CARDINAL;  (* how to scatter source bitplanes into dest *)
    planeOnOff: CARDINAL; (* default bitplane data for planePick *) 
    planeMask: CARDINAL;  (* selects which bitplanes to store into *)
  END;
  DestMergePtr=POINTER TO DestMerge;

  (* A SpritePrecedence is stored in a SPRT chunk *)
  SpritePrecedence = CARDINAL;
  SpritePrecedencePtr=POINTER TO SpritePrecedence;

  (* A C-A ViewPort mode - HAM or DualPlayfield - is stored in a CAMG chunk *)
  CamgChunk=RECORD
    padding: INTEGER; (* reserved by C-A; store 0 here *)
    viewModes: ViewModeSet;
  END;
  CamgChunkPtr=POINTER TO CamgChunk;
   
  (* Color Cycling Range and Timing may optionally be stored in a CCRT chunk *)
  CcrtChunk=RECORD
    direction: INTEGER;     (* 1=forward, -1=backward, or 0=no cycling *)
    start,end: SHORTCARD;        (* lower and upper color registers selected *)
    seconds: LONGINT;       (* seconds between changing colors *)
    microseconds: LONGINT;  (* microsecs between cycles *)
    pad: INTEGER;           (* reserved by C-A; store 0 here *)
  END;
  CcrtChunkPtr=POINTER TO CcrtChunk;
   
  (* Color Register Range - shading or cycling - is stored in a CRNG chunk *)
  CRange=RECORD
    pad1: INTEGER;     (* reserved by C-A; store 0 here *)
    rate: INTEGER;     (* cycling rate: 60/sec=16384, 30/sec=8192, 1/sec=273 *)
    flags: BITSET;     (* bit0 set = active, bit1 set = reverse *)
    low, high: SHORTCARD;   (* lower and upper color registers used *)
  END;
  CRangePtr=POINTER TO CRange;

CONST

  PROP=SHIFT(ORD('P'),24)+SHIFT(ORD('R'),16)+SHIFT(ORD('O'),8)+ORD('P');
  LIST=SHIFT(ORD('L'),24)+SHIFT(ORD('I'),16)+SHIFT(ORD('S'),8)+ORD('T');
  CAT =SHIFT(ORD('C'),24)+SHIFT(ORD('A'),16)+SHIFT(ORD('T'),8)+ORD(' ');
  FORM=SHIFT(ORD('F'),24)+SHIFT(ORD('O'),16)+SHIFT(ORD('R'),8)+ORD('M');
  ILBM=SHIFT(ORD('I'),24)+SHIFT(ORD('L'),16)+SHIFT(ORD('B'),8)+ORD('M');
  BMHD=SHIFT(ORD('B'),24)+SHIFT(ORD('M'),16)+SHIFT(ORD('H'),8)+ORD('D');
  BODY=SHIFT(ORD('B'),24)+SHIFT(ORD('O'),16)+SHIFT(ORD('D'),8)+ORD('Y');
  CMAP=SHIFT(ORD('C'),24)+SHIFT(ORD('M'),16)+SHIFT(ORD('A'),8)+ORD('P');
  GRAB=SHIFT(ORD('G'),24)+SHIFT(ORD('R'),16)+SHIFT(ORD('A'),8)+ORD('B');
  DEST=SHIFT(ORD('D'),24)+SHIFT(ORD('E'),16)+SHIFT(ORD('S'),8)+ORD('T');
  SPRT=SHIFT(ORD('S'),24)+SHIFT(ORD('P'),16)+SHIFT(ORD('R'),8)+ORD('T');
  CAMG=SHIFT(ORD('C'),24)+SHIFT(ORD('A'),16)+SHIFT(ORD('M'),8)+ORD('G');
  CCRT=SHIFT(ORD('C'),24)+SHIFT(ORD('C'),16)+SHIFT(ORD('R'),8)+ORD('T');
  CRNG=SHIFT(ORD('C'),24)+SHIFT(ORD('R'),16)+SHIFT(ORD('N'),8)+ORD('G');
  AUTH=SHIFT(ORD('A'),24)+SHIFT(ORD('U'),16)+SHIFT(ORD('T'),8)+ORD('H');
  CHRS=SHIFT(ORD('C'),24)+SHIFT(ORD('H'),16)+SHIFT(ORD('R'),8)+ORD('S');
  CPYR=SHIFT(ORD('('),24)+SHIFT(ORD('c'),16)+SHIFT(ORD(')'),8)+ORD(' ');
  ANNO=SHIFT(ORD('A'),24)+SHIFT(ORD('N'),16)+SHIFT(ORD('N'),8)+ORD('O');
  NAME=SHIFT(ORD('N'),24)+SHIFT(ORD('A'),16)+SHIFT(ORD('M'),8)+ORD('E');
  TEXT=SHIFT(ORD('T'),24)+SHIFT(ORD('E'),16)+SHIFT(ORD('X'),8)+ORD('T');
  FONS=SHIFT(ORD('F'),24)+SHIFT(ORD('O'),16)+SHIFT(ORD('N'),8)+ORD('S');
  SVX8=SHIFT(ORD('8'),24)+SHIFT(ORD('S'),16)+SHIFT(ORD('V'),8)+ORD('X');
  FTXT=SHIFT(ORD('F'),24)+SHIFT(ORD('T'),16)+SHIFT(ORD('X'),8)+ORD('T');
  WORD=SHIFT(ORD('W'),24)+SHIFT(ORD('O'),16)+SHIFT(ORD('R'),8)+ORD('D');
  FONT=SHIFT(ORD('F'),24)+SHIFT(ORD('O'),16)+SHIFT(ORD('N'),8)+ORD('T');
  COLR=SHIFT(ORD('C'),24)+SHIFT(ORD('O'),16)+SHIFT(ORD('L'),8)+ORD('R');
  DOC =SHIFT(ORD('D'),24)+SHIFT(ORD('O'),16)+SHIFT(ORD('C'),8)+ORD(' ');
  HEAD=SHIFT(ORD('H'),24)+SHIFT(ORD('E'),16)+SHIFT(ORD('A'),8)+ORD('D');
  FOOT=SHIFT(ORD('F'),24)+SHIFT(ORD('O'),16)+SHIFT(ORD('O'),8)+ORD('T');
  PCTS=SHIFT(ORD('P'),24)+SHIFT(ORD('C'),16)+SHIFT(ORD('T'),8)+ORD('S');
  PARA=SHIFT(ORD('P'),24)+SHIFT(ORD('A'),16)+SHIFT(ORD('R'),8)+ORD('A');
  TABS=SHIFT(ORD('T'),24)+SHIFT(ORD('A'),16)+SHIFT(ORD('B'),8)+ORD('S');
  PAGE=SHIFT(ORD('P'),24)+SHIFT(ORD('A'),16)+SHIFT(ORD('G'),8)+ORD('E');
  FSCC=SHIFT(ORD('F'),24)+SHIFT(ORD('S'),16)+SHIFT(ORD('C'),8)+ORD('C');
  PINF=SHIFT(ORD('P'),24)+SHIFT(ORD('I'),16)+SHIFT(ORD('N'),8)+ORD('F');
  PDEF=SHIFT(ORD('P'),24)+SHIFT(ORD('D'),16)+SHIFT(ORD('E'),8)+ORD('F');
  VHDR=SHIFT(ORD('V'),24)+SHIFT(ORD('H'),16)+SHIFT(ORD('D'),8)+ORD('R');
  ATAK=SHIFT(ORD('A'),24)+SHIFT(ORD('T'),16)+SHIFT(ORD('A'),8)+ORD('K');
  RLSE=SHIFT(ORD('R'),24)+SHIFT(ORD('L'),16)+SHIFT(ORD('S'),8)+ORD('E');

  mskNone=0; mskHasMask = 1; mskHasTransparentColor = 2; mskLasso = 3;
  cmpNone=0; cmpByteRun1= 1;
  sizeofColorRegister = 3; (* use this instead of SIZE(ColorRegister) *)
  maxAmDepth = 6;  (* maximum number of Amiga bitplanes 6=HAM  *)
  maxSrcPlanes = 16+1;  (* maximum planes plus mask allowed *)

PROCEDURE ReadChunkID(VAR f:File):LONGINT;
VAR
  ID,Actual:LONGINT;
BEGIN
  ReadBytes(f,ADR(ID),4,Actual);
  RETURN(ID);
END ReadChunkID;

PROCEDURE ReadChunkLength(VAR f:File):LONGINT;
VAR
  Lngth,Actual:LONGINT;
BEGIN
  ReadBytes(f,ADR(Lngth),4,Actual);
  RETURN(Lngth);
END ReadChunkLength;

PROCEDURE ReadDUMM(VAR f:File; VAR fl:LONGINT):INTEGER;
VAR
  pos,cl:LONGINT;
BEGIN
  cl:=ReadChunkLength(f);
  GetPos(f,pos);
  IF ODD(cl) THEN INC(cl) END;
  fl:=fl-cl-8;
  SetPos(f,pos+cl);
  RETURN(0);
END ReadDUMM;

VAR
  bmhd:BitMapHeader;

PROCEDURE ReadBMHD(VAR f:File; VAR fl:LONGINT):INTEGER;
VAR
  cl,Actual:LONGINT;
BEGIN
  cl:=ReadChunkLength(f);
  ReadBytes(f,ADR(bmhd),SIZE(bmhd),Actual);
  fl:=fl-Actual-8;
(*$ IF Test *)
WRITELN(s('ReadBMHD'));
(*$ ENDIF *)
  RETURN(0);
END ReadBMHD;

PROCEDURE ReadCMAP(VAR f:File; VAR fl:LONGINT):INTEGER;
VAR
  cl,Actual:LONGINT;
BEGIN
  cl:=ReadChunkLength(f);
  ReadBytes(f,ADR(cmap),cl,Actual);
  fl:=fl-Actual-8;
(*$ IF Test *)
WRITELN(s('ReadCMAP'));
(*$ ENDIF *)
  RETURN(0);
END ReadCMAP;

VAR
  body:ARRAY[0..8] OF ADDRESS;

PROCEDURE ReadBODY(VAR f:File; VAR fl:LONGINT):INTEGER;
TYPE
  PT=POINTER TO ARRAY[0..65535] OF CHAR;
  BUFFER=ARRAY[0..255] OF SHORTCARD;
VAR
  cl,Actual,rs,ofl,tst:LONGINT;
  ch:CHAR;
  n,nn,l,max,bb,wb,wr,it,Err:INTEGER;
  pt:PT;
  Buf:BUFFER;
  pBuf:POINTER TO BUFFER;
  pBody:ADDRESS;
BEGIN
(*$ IF Test *)
WRITELN(s('ReadBODY'));
(*$ ENDIF *)
  Err:=IFFOkay;
  cl:=ReadChunkLength(f);
  bb:=1+(bmhd.w-1) DIV 8;       (* bytes bred *)
  wb:=(bb+1) DIV 2;             (* words bred *)
  rs:=LONGINT(wb)*2*INTEGER(bmhd.h);
  AllocMem(body[0],rs*SHORTINT(bmhd.nPlanes),TRUE);
  IF body[0]=NIL THEN
    RETURN(allocErr);
  END;
  FOR n:=1 TO SHORTINT(bmhd.nPlanes)-1 DO
    body[n]:=body[n-1]+rs;
  END;
  FOR l:=0 TO INTEGER(bmhd.h)-1 DO (* l=linienr, wb=WidthBytes/2 *)
    FOR n:=0 TO SHORTINT(bmhd.nPlanes)-1 DO
      IF SHORTINT(bmhd.compression)=cmpNone THEN
        ReadBytes(f,ADDRESS(LONGINT(body[n])+l*wb*2),wb*2,Actual); 
        IF Actual=0 THEN
          Err:=badIFF;
        END;
        fl:=fl-Actual;
      ELSIF SHORTINT(bmhd.compression)=cmpByteRun1 THEN
(*$ IF Test *)
WRITELN(s('ByteRun1'));
(*$ ENDIF *)
        tst:=LONGINT(body[n])+l*wb*2;
        pt:=ADDRESS(tst);
        wr:=0;
        ofl:=fl;
        max:=200;
        REPEAT
          DEC(max);
          ReadChar(f,ch);
          DEC(fl);
          nn:=INTEGER(ch);
          IF nn<128 THEN
            INC(nn);
            ReadBytes(f,ADDRESS(tst+wr),nn,Actual);
            IF Actual<nn THEN Err:=badIFF; END;
            wr:=wr+nn;
            fl:=fl-Actual;
          ELSE
            nn:=257-nn;
            ReadChar(f,ch);
            DEC(fl);
            FOR it:=1 TO nn DO 
              pt^[wr]:=ch;
              INC(wr);
            END;
          END;
        UNTIL (wr>=wb*2) OR (max=0) OR (Err=badIFF);
      ELSE
        Err:=badFORM; 
      END;
    END;
  END;
  IF ODD(fl) THEN ReadChar(f,ch); DEC(fl); END;
  fl:=fl-8;
  RETURN(Err);
END ReadBODY;

PROCEDURE ReadILBM(VAR f:File; VAR fl:LONGINT):INTEGER;
VAR
  Err:INTEGER;
  ID:LONGINT;
BEGIN
(*$ IF Test *)
WRITELN(s('ReadILBM'));
(*$ ENDIF *)
  REPEAT
    ID:=ReadChunkID(f);
    IF    ID=BMHD THEN Err:=ReadBMHD(f,fl);
    ELSIF ID=BODY THEN Err:=ReadBODY(f,fl);
    ELSIF ID=CMAP THEN Err:=ReadCMAP(f,fl);
    ELSE               Err:=ReadDUMM(f,fl);
    END;
    IF Err<>0 THEN RETURN(Err) END;
  UNTIL fl<1;
  RETURN(IFFOkay);
END ReadILBM;

PROCEDURE ReadFORM(VAR f:File; VAR fp:LONGINT):INTEGER;
VAR
  Err:INTEGER;
  ID,fl:LONGINT;
BEGIN
  fl:=ReadChunkLength(f)-4;
  fp:=fp-fl-4;
  ID:=ReadChunkID(f);       (* AUTH,CHRS,(c) ,ANNO,NAME,TEXT *)
(* BMHD,CMAP,GRAP,DEST,SPRT,CAMG,CCRT,CRNG,BODY,  DPPV,DGVW,BHSM,BHCP,BHBA,  3DCM,3DPA *)
  IF ID=ILBM THEN Err:=ReadILBM(f,fl);
  ELSE            Err:=badIFF;
  END;
  RETURN(Err);
END ReadFORM;

PROCEDURE ReadIFF(VAR f:File):INTEGER;
VAR
  ID,fl:LONGINT;
BEGIN
  ID:=ReadChunkID(f);
  fl:=0;
  IF    ID=FORM THEN RETURN(ReadFORM(f,fl));
  ELSE               RETURN(badIFF);
  END;
END ReadIFF;

PROCEDURE ReadImageILBM(pth:ARRAY OF CHAR; VAR imageptr:ImagePtr):INTEGER;
VAR
  f:File;
  res:INTEGER;
BEGIN
  Lookup(f,pth, 512, FALSE);
  IF (f.res=done) THEN
    res:=ReadIFF(f);
    Close(f);
    IF res=IFFOkay THEN
      imageptr:=MakeImage(bmhd.w,bmhd.h,SHORTINT(bmhd.nPlanes)+100,body[0]);
    END;
  ELSE
    res:=dosError;
  END;
  RETURN(res);
END ReadImageILBM;

END ILBMread.
