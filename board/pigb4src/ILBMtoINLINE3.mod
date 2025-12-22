MODULE ILBMtoINLINE3; (* for M2Amiga V4.0 *)

FROM SYSTEM IMPORT
  ADR,ADDRESS;
FROM String IMPORT
  Length;
FROM FileSystem IMPORT
  File, FileMode, Response, Lookup, Close, ReadChar, ReadBytes,
  WriteBytes, WriteChar, SetPos, GetPos;
FROM W IMPORT
  Buf, FREEBUF, CONCAT, WRITE, WRITELN, READs, s, sf, l, lf, lh;
FROM ReqSupport IMPORT
  SimpleFileRequester;
FROM IntuitionD IMPORT
  Image, ImagePtr, WindowPtr, IDCMPFlagSet, WindowFlags, WindowFlagSet;
FROM IntuitionL IMPORT
  DrawImage, CloseWindow;
FROM QuickIntuition IMPORT
  AddWindow, AFS, GFS, MakeImage;
FROM ILBMread IMPORT
  ReadImageILBM, IFFOkay, badIFF, dosError, cmap;

PROCEDURE WRITEU(n:INTEGER);
BEGIN (* Gemmes i Write Buffer *)
END WRITEU;

PROCEDURE WRITEUD(VAR f:File; n:INTEGER);
VAR
  actual:LONGINT;
BEGIN
  WriteBytes(f,ADR(Buf),Length(Buf),actual);
  WriteChar(f,12C);
  (* WRITELN(0); *)
  FREEBUF;
END WRITEUD;

VAR
  HexOn:BOOLEAN;

PROCEDURE GenerateImage(VAR u:File; img:ImagePtr; navn:ARRAY OF CHAR);
VAR
  ww,p,x,y,n,cols,WPL:CARDINAL;
  off:LONGINT;
  d:POINTER TO ARRAY [0..65535] OF CARDINAL;
BEGIN
  IF HexOn THEN
    WPL:=16;
  ELSE
    WPL:=32;
  END;
  ww:=1+(img^.width-1)/16;
  d:=img^.imageData;
  FREEBUF;
  CONCAT(s('PROCEDURE ')+s(navn)+s(';'));
  WRITEUD(u,s(' (*$ EntryExitCode:=FALSE *) (* planes=')+l(img^.depth)
           +s(' x=')+l(img^.width)
  +s(' y=')+l(img^.height)+s(' *)'));
  cols:=2;
  FOR n:=1 TO img^.depth-1 DO
    cols:=cols*2;
  END;
  FOR n:=0 TO cols-1 DO 
    WRITEUD(u,s('(* RGB Color ')+l(cmap[n].red)+s(',')+l(cmap[n].green)
             +s(',')+l(cmap[n].blue)+s(' *)'));
  END;
  WRITEUD(u,s('BEGIN'));
  FOR p:=0 TO img^.depth-1 DO   
    IF p>0 THEN
      WRITEUD(u,s('(* BITPLANE ')+l(p)+s(' : *)'));
    END;
    off:=LONGINT(p)*LONGINT(ww)*LONGINT(img^.height);
    FOR y:=0 TO img^.height-1 DO
      CONCAT(s('ASSEMBLE(DC.W '));
      FOR x:=0 TO ww-1 DO
        IF x>0 THEN
          IF x MOD WPL=0 THEN
            IF x<ww-1 THEN (* ny linie, hvis flere *)
              WRITEUD(u,s(' END);'));
              CONCAT(s('ASSEMBLE(DC.W '));
            END;
          ELSE
            CONCAT(s(','));
          END;
        END;
        IF HexOn THEN
          CONCAT(s('$')+lh(d^[CARDINAL(off)+x+y*ww],4));
        ELSE
          CONCAT(l(d^[CARDINAL(off)+x+y*ww]));
        END;       
      END;
      WRITEUD(u,s(' END);'));
    END;
  END;
  WRITEUD(u,s('END ')+s(navn)+s(';'));
END GenerateImage;

CONST
  udfil='ram:out.mod';

VAR
  u:File;
  st,ttl,nvn,pth,dir:ARRAY[0..255] OF CHAR;
  wp:WindowPtr;
  i1:ImagePtr;
  x,y:INTEGER;
  Show:BOOLEAN;

BEGIN
  WRITELN(s('ILBMtoM2 v1.2 (12-95)'));
  WRITELN(s('Conversion of ILBM files to INLINE code in IntuitionD.Image format.'));
  WRITELN(s('They are saved/appended in ')+s(udfil)+s(' for M2Amiga v4.x Modula2'));
  WRITELN(0);
  WRITELN(s('Public Domaine, author Egon B. Madsen, Ballerup, Denmark'));
  HexOn:=FALSE;
  ttl:=' Get IFF ';
  dir:='';
  nvn:='';
  Lookup(u,udfil,1024,FALSE);
  IF ~(u.res=done) THEN
    Lookup(u,udfil,1024,TRUE);
  END;
  WRITELN(0);
  WRITELN(s('Reading filename'));
  WHILE SimpleFileRequester(ttl,nvn,pth,dir) DO
    WRITELN(s('Reading IFF ')+s(pth));
    IF ReadImageILBM(pth,i1)=IFFOkay THEN
      x:=i1^.width;
      y:=i1^.height;
      Show:=(x>1) & (x<=640-8) & (y>1) & (y<=256-20);
      IF Show THEN
        WRITELN(s('Showing image in window (because x<633 og y<237)')); 
        AddWindow(wp,ADR('IFF-ILBM TEST'),0,0,x+8,y+20,0,1,IDCMPFlagSet{},
                WindowFlagSet{windowDrag,windowDepth},NIL,NIL,NIL,10,22,-1,-1);
        WRITELN(s('Draws picture'));
        DrawImage(wp^.rPort,i1,4,18);
      END;
      WRITELN(s('Generate from ')+s(nvn)+s(', planes=')+l(i1^.depth)+s(' x=')
             +l(i1^.width)+s(' y=')+l(i1^.height));
      WRITE(s('Press key(s) (return alone=skip, h=hex format, dd=decimal) '));
      READs(st);
      HexOn:=Length(st)=1;
      
      IF Length(st)>0 THEN
        IF HexOn THEN
          WRITELN(s('Generates to ')+s(udfil)+s(' in hexadecimal format ...'));
        ELSE
          WRITELN(s('Generates to ')+s(udfil)+s(' in decimal format ...'));
        END;
        GenerateImage(u,i1,nvn);
(*        Close(u); *)
      END;
      IF Show THEN
        CloseWindow(wp);
      END;
    END;
    WRITELN(0);
    WRITELN(s('Reading filename'));
  END;
  Close(u);
END ILBMtoINLINE3.
