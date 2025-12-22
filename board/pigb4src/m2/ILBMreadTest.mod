MODULE ILBMreadTest; (* for M2Amiga V4.0 *)

FROM SYSTEM IMPORT
  ADR;
FROM ILBMread IMPORT
   ReadImageILBM, IFFOkay;
FROM W IMPORT 
  WRITE, WRITELN, READs, s, l, lf;
FROM ReqSupport IMPORT
  SimpleFileRequester;
FROM IntuitionD IMPORT
  Image, ImagePtr, WindowPtr, IDCMPFlagSet, WindowFlags, WindowFlagSet;
FROM IntuitionL IMPORT
  DrawImage, CloseWindow;
FROM QuickIntuition IMPORT
  AddWindow, AFS, GFS, MakeImage;

VAR
  st,ttl,nvn,pth,dir:ARRAY[0..79] OF CHAR;
  wp:WindowPtr;
  i1:ImagePtr;
  x,y,d:INTEGER;
  Show:BOOLEAN;

BEGIN
  WRITELN(s('Visning af (mindre) ILBM filer.'));
  ttl:=' Hent IFF ';
  dir:='HO:';
  nvn:='';
  WRITELN(s('Indlæser filnavn'));
  WHILE SimpleFileRequester(ttl,nvn,pth,dir) DO
    WRITELN(s('Læser IFF ')+s(pth));
    IF ReadImageILBM(pth,i1)=IFFOkay THEN 
      WRITELN(s('Læst.'));
      x:=i1^.width;
      y:=i1^.height;
      d:=i1^.depth;
(*
      i1^.planePick:=255;
      i1^.planeOnOff:=0;
*)
      WRITELN(s('X=')+l(x)+s(' ,Y=')+l(y)+s(' Planes=')+l(d)
             +s(' pick=')+l(i1^.planePick)+s(' OnOff=')+l(i1^.planeOnOff));
      Show:=(x>1) & (x<=640-8) & (y>1) & (y<=256-24);
      IF Show THEN
        WRITELN(s('Viser image i vindue (da x<=632 og y<=232)')); 
        AddWindow(wp,ADR('IFF-ILBM TEST'),0,0,x+8,y+24,0,1,IDCMPFlagSet{},
                WindowFlagSet{windowDrag,windowDepth},NIL,NIL,NIL,10,22,-1,-1);
        WRITELN(s('Tegner billede'));
        DrawImage(wp^.rPort,i1,4,20);
        WRITE(s('Tast retur'));
        READs(st);
        CloseWindow(wp);
      END;
    END;
    WRITELN(s('Indlæser næste filnavn'));
  END;
END ILBMreadTest.
