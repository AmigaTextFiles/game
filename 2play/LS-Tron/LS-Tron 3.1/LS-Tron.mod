EXTERNAL;

{ LS-Tron.mod }

CONST hex : ARRAY[0..15] OF STRING = ("0","1","2","3","4","5","6","7",
                                      "8","9","a","b","c","d","e","f");

      Schraegstrich = "/";

{$I "include:exec/libraries.i"               }
{$I "include:exec/memory.i"                  }
{$I "include:libraries/dosextens.i"          }
{$I "include:utils/random.i"                 }
{$I "include:libraries/medplayer.i"          }
{$I "include:graphics/Text.i"                }
{$I "include:libraries/diskfont.i"           }
{$I "include:Intuition/Intuition.i"          }
{$I "include:Libraries/ReqTools.i"           }
{$I "include:Utils/StringLib.i"              }
{$I "include:Graphics/Graphics.i"            }
{$I "include:Graphics/Pens.i"                }
{$I "include:Utils/Parameters.i"             }


PROCEDURE FileRequest(Titel,dir,datei : STRING);

  VAR dummy   : STRING;
      filer   : RTFileRequesterPtr;
      MeinTag : ReqTagListPtr;
      xyz     : INTEGER;

  BEGIN
    New(MeinTag);
    dummy:=AllocString(255);
    strcpy(datei,"");

    filer:=NIL;
    filer:=ADDRESS(rtAllocRequestA(rt_FileReq,NIL));

    If Filer<>NIL THEN
       BEGIN
         MeinTag^[0].ti_Tag:=RTFI_DIR;
         MeinTag^[0].ti_Data:=INTEGER(Dir);
         MeinTag^[1].ti_Tag:=Tag_End;
         xyz:=RTChangeReqAttrA(ADDRESS(filer),MeinTag);

         xyz:=rtFileRequestA(filer,datei,Titel,NIL);
         IF xyz<>0 THEN BEGIN
                          StrCpy(dir,Filer^.Dir);

                          StrCpy(dummy,datei);
                          StrCpy(datei,filer^.Dir);
                          IF (datei[StrLen(datei)-1]<>Schraegstrich[0]) AND
                             (StrLen(datei)>0) THEN
                             StrCat(datei,"/");
                          StrCat(datei,dummy);
                        END
                   ELSE StrCpy(datei,"");
       END;
    xyz:=rtFreeRequest(filer);
    Dispose(MeinTag);
    FreeString(dummy);
  END;

PROCEDURE Show(Meldung : STRING);

  VAR Code : INTEGER;

  BEGIN
    Code:=rtEZRequestA(meldung,"Ok",NIL,NIL,NIL);
  END;

FUNCTION Ask(Meldung : STRING) : BOOLEAN;   { Requester aufrufen   }

  VAR Code : INTEGER;

  BEGIN
    Code:=rtEZRequestA(meldung,"Ja!Ja!|NEIN!",NIL,NIL,NIL);
    ask:=code<>0;
  END;

FUNCTION AskEnglish(Meldung : STRING) : BOOLEAN;   { Requester aufrufen   }

  VAR Code : INTEGER;

  BEGIN
    Code:=rtEZRequestA(meldung,"Yes!|No!",NIL,NIL,NIL);
    askEnglish:=code<>0;
  END;

FUNCTION Choose(meldung,wahl1,wahl2,wahl3 : STRING) : BYTE;

  VAR s : STRING;

  BEGIN
    s:=ALLOCSTRING(255);

    strcpy(s,wahl1);
    strcat(s,"|");
    strCat(s,wahl2);
    strcat(s,"|");
    strCat(s,Wahl3);

    Choose:=rtEZRequestA(meldung,s,NIL,NIL,NIL);

    FreeString(s);
  END;

PROCEDURE MakeString(myVar : INTEGER;VAR s : STRING); { Integer => String }

  VAR x : SHORT;

  BEGIN
    x:=IntToStr(s,MyVar);
  END;

PROCEDURE AddString(VAR s : STRING;x : SHORT); { Integer an String hängen }

  VAR help : STRING;

  BEGIN
    help:=AllocString(20);
    makeString(x,help);
    StrCat(s,help);
    FreeString(help);
  END;

FUNCTION IncAddress(x : ADDRESS;zahl : INTEGER) : ADDRESS;

  BEGIN
    IncAddress:=ADDRESS(INTEGER(x)+zahl);
  END;

FUNCTION Str2Int(s : STRING) : INTEGER;

  VAR vorzeichen : BOOLEAN;
      zaehler    : INTEGER;
      zahl       : INTEGER;

  BEGIN
    Vorzeichen:=(StrNEq(s,"+",1) OR StrNEq(s,"-",1));

    IF vorzeichen THEN zaehler:=1
                  ELSE zaehler:=0;
    zahl:=0;

    WHILE (zaehler<StrLen(s)) DO
      BEGIN
        zahl:=zahl*10+ORD(s[zaehler])-48;
        inc(zaehler);
      END;

    IF Vorzeichen THEN
       IF StrNEq(s,"-",1) THEN zahl:=-zahl;

    Str2Int:=zahl;
  END;

PROCEDURE Byte2Hex(zahl : BYTE;VAR s : STRING);

  VAR upper : BYTE;

  BEGIN
    upper:=zahl SHR 4;
    zahl:=zahl AND $0f;

    StrCpy(s,"$");
    StrCat(s,Hex[upper]);
    StrCat(s,Hex[zahl]);
  END;

PROCEDURE Code2String(zahl : BYTE;VAR s : STRING);

  CONST zeichen = "`1234567890ß`\\  QWERTZUIOPÜ+    ASDFGHJKLÖÄ#    <YXCVBNM,.-";

  BEGIN
    zahl:=zahl AND $7f;

    IF ((zahl>= 0) AND (zahl<=13)) OR
       ((zahl>=16) AND (zahl<=27)) OR
       ((zahl>=32) AND (zahl<=43)) OR
       ((zahl>=48) AND (zahl<=58)) THEN
       BEGIN
         s[0]:=zeichen[zahl];
         s[1]:=CHR(0);
       END
      ELSE IF (zahl>=80) AND (zahl<=89) THEN
              BEGIN
                StrCpy(s,"F");
                Addstring(s,zahl-79);
              END
             ELSE
              CASE zahl OF
               $1d : StrCpy(s,"(1)"); { Zahlen im Nummernblock }
               $1e : StrCpy(s,"(2)");
               $1f : StrCpy(s,"(3)");
               $2d : StrCpy(s,"(4)");
               $2e : StrCpy(s,"(5)");
               $2f : StrCpy(s,"(6)");
               $3d : StrCpy(s,"(7)");
               $3e : StrCpy(s,"(8)");
               $3f : StrCpy(s,"(9)");

                60 : StrCpy(s,"(.)");
                64 : StrCpy(s,"Space");
                65 : StrCpy(s,"Backspace");
                66 : StrCpy(s,"Tab");
                67 : StrCpy(s,"Enter");
                68 : StrCpy(s,"Return");
                69 : StrCpy(s,"Escape");
                70 : StrCpy(s,"Delete");

                74 : StrCpy(s,"(-)");

                76 : StrCpy(s,"Cursor hoch");
                77 : StrCpy(s,"Cursor runter");
                78 : StrCpy(s,"Cursor rechts");
                79 : StrCpy(s,"Cursor links");
                  { Funktionstasten }

                90 : StrCpy(s,"([)");
                91 : StrCpy(s,"(])");
                92 : StrCpy(s,"(/)");
                93 : StrCpy(s,"(*)");
                94 : StrCpy(s,"(+)");
                95 : StrCpy(s,"Help");
                96 : StrCpy(s,"Shift links");
                97 : StrCpy(s,"Shift rechts");
                98 : StrCpy(s,"Caps Lock");
                99 : StrCpy(s,"Ctrl");
               100 : StrCpy(s,"Alt links");
               101 : StrCpy(s,"Alt rechts");
               102 : StrCpy(s,"Amiga links");
               103 : StrCpy(s,"Amiga rechts");
               ELSE Byte2Hex(zahl,s);
              END;
  END;

PROCEDURE Code2StringEng(zahl : BYTE;VAR s : STRING);

  CONST zeichen = "`1234567890ß´\\  QWERTYUIOPÜ+    ASDFGHJKLÖÄ#    <ZXCVBNM,.-";

  BEGIN
    zahl:=zahl AND $7f;

    IF ((zahl>= 0) AND (zahl<=13)) OR
       ((zahl>=16) AND (zahl<=27)) OR
       ((zahl>=32) AND (zahl<=43)) OR
       ((zahl>=48) AND (zahl<=58)) THEN
       BEGIN
         s[0]:=zeichen[zahl];
         s[1]:=CHR(0);
       END
      ELSE IF (zahl>=80) AND (zahl<=89) THEN
              BEGIN
                StrCpy(s,"F");
                Addstring(s,zahl-79);
              END
             ELSE
              CASE zahl OF
               $1d : StrCpy(s,"(1)"); { Number on the numberblock }
               $1e : StrCpy(s,"(2)");
               $1f : StrCpy(s,"(3)");
               $2d : StrCpy(s,"(4)");
               $2e : StrCpy(s,"(5)");
               $2f : StrCpy(s,"(6)");
               $3d : StrCpy(s,"(7)");
               $3e : StrCpy(s,"(8)");
               $3f : StrCpy(s,"(9)");

                60 : StrCpy(s,"(.)");
                64 : StrCpy(s,"Space");
                65 : StrCpy(s,"Backspace");
                66 : StrCpy(s,"Tab");
                67 : StrCpy(s,"Enter");
                68 : StrCpy(s,"Return");
                69 : StrCpy(s,"Escape");
                70 : StrCpy(s,"Delete");

                74 : StrCpy(s,"(-)");

                76 : StrCpy(s,"Cursor up");
                77 : StrCpy(s,"Cursor down");
                78 : StrCpy(s,"Cursor right");
                79 : StrCpy(s,"Cursor left");
                  { Funktionstasten }

                90 : StrCpy(s,"([)");
                91 : StrCpy(s,"(])");
                92 : StrCpy(s,"(/)");
                93 : StrCpy(s,"(*)");
                94 : StrCpy(s,"(+)");
                95 : StrCpy(s,"Help");
                96 : StrCpy(s,"Left Shift");
                97 : StrCpy(s,"Right Shift");
                98 : StrCpy(s,"Caps Lock");
                99 : StrCpy(s,"Ctrl");
               100 : StrCpy(s,"Left Alt");
               101 : StrCpy(s,"Right Alt");
               102 : StrCpy(s,"Left Amiga");
               103 : StrCpy(s,"Right Amiga");
               ELSE Byte2Hex(zahl,s);
              END;
  END;

PROCEDURE SetGadget(Gad : GadgetPtr;nextGad,GadRender,SelRender,
                                    GadText : ADDRESS);

  BEGIN
    WITH Gad^ DO
      BEGIN
        NextGadget  :=nextGad;
        GadgetRender:=GadRender;
        SelectRender:=SelRender;
        GadgetText  :=GadText;
      END;
  END;

PROCEDURE SelectGadget(rp : RastPortPtr;Gad : GadgetPtr);

  BEGIN
    IF (Gad^.GadgetRender<>NIL) AND (Gad^.SelectRender<>NIL) THEN
       WITH Gad^ DO
         BEGIN
           DrawBorder(RP,SelectRender,LeftEdge,TopEdge);
           Delay(3);
           DrawBorder(RP,GadgetRender,LeftEdge,TopEdge);
         END;
  END;

PROCEDURE Print(RP : RastPortPtr;x,y : SHORT;Zeile : STRING;colour : SHORT);

   { String ausgeben }

   BEGIN
     SetAPen(RP,colour);
     Move(RP,x,y);
     GText(RP,Zeile,strLen(zeile));
   END;

FUNCTION GetGadgetID(iadr : GadgetPtr) : SHORT; { Gadget identifizieren }

  BEGIN
    GetGadgetID:=iadr^.GadgetID;
  END;

PROCEDURE KillMSGs(UserPort : MsgPortPtr);

  VAR Msg : MessagePtr;

  BEGIN
    Msg:=NIL;
    Msg:=GetMsg(UserPort);
    WHILE Msg<>NIL DO
      BEGIN
        ReplyMsg(Msg);
        Msg:=NIL;
        Msg:=GetMsg(UserPort);
      END;
  END;

PROCEDURE MyCloseWindow(MyWin : WindowPtr); { Fenster schön schließen }

  VAR Msg : MessagePtr;

  BEGIN
    Msg:=NIL;
    Msg:=GetMsg(MyWin^.UserPort);
    WHILE Msg<>NIL DO
      BEGIN
        ReplyMsg(Msg);
        Msg:=NIL;
        Msg:=GetMsg(Mywin^.UserPort);
      END;
    CloseWindow(MyWin);
  END;

PROCEDURE Line(RPort : RastPortPtr;x1,y1,x2,y2 : SHORT); { Linie Malen }

  BEGIN
    Move(RPort,x1,y1);
    Draw(RPort,x2,y2);
  END;

PROCEDURE DrawBox(rp : RastportPtr;x,y,tx,ty : SHORT); { Box malen (3D) }

  BEGIN
    SetAPen(RP,1);
    Line(RP,  x,ty,  x, y);
    Line(RP,  x, y, tx, y);

    SetAPen(RP,8);
    Line(RP,  tx,y+1,  tx,ty);
    Line(RP,tx-1, ty,   x,ty);
  END;

PROCEDURE DrawIBox(rp : RastportPtr;x,y,tx,ty : SHORT); { Box invertiert }

  BEGIN
    SetAPen(RP,8);
    Line(RP,  x,ty,  x, y);
    Line(RP,  x, y, tx, y);

    SetAPen(RP,1);
    Line(RP,  tx,y+1,  tx,ty);
    Line(RP,tx-1, ty,   x,ty);
  END;

PROCEDURE DrawCBox(rp : RastportPtr;x,y,tx,ty,c1,c2 : SHORT); { Box mit Farbenwahl }

  BEGIN
    SetAPen(RP,c1);
    Line(RP,  x,ty,  x, y);
    Line(RP,  x, y, tx, y);

    SetAPen(RP,c2);
    Line(RP,  tx,y+1,  tx,ty);
    Line(RP,tx-1, ty,   x,ty);
  END;

PROCEDURE DrawSBox(rp : RastportPtr;x,y,tx,ty : SHORT); { einfarbige Box }

  BEGIN
    SetAPen(RP,1);

    Move(RP, x, y);
    Draw(RP, x,ty);
    Draw(RP,tx,ty);
    Draw(RP,tx, y);
    Draw(RP, x, y);
  END;

PROCEDURE Draw0Box(rp : RastportPtr;x,y,tx,ty : SHORT); { Box löschen }

  BEGIN
    SetAPen(RP,0);

    Move(RP, x, y);
    Draw(RP, x,ty);
    Draw(RP,tx,ty);
    Draw(RP,tx, y);
    Draw(RP, x, y);
  END;

FUNCTION Hoch(basis,exponent : INTEGER) : INTEGER;

  { Potenzieren ganzer Zahlen }

  VAR ergebnis,zaehler : INTEGER;

  BEGIN
    ergebnis:=1;

    FOR Zaehler:=1 TO exponent DO ergebnis:=ergebnis*basis;

    Hoch:=ergebnis;
  END;


TYPE IFFTitles = (BMHD_f,CMAP_f,CAMG_f,BODY_f);

     BMHD = RECORD
              width,
              height      : SHORT;
              depth       : BYTE;
              left,
              top         : SHORT;
              masking     : BYTE;
              transCol    : SHORT;
              xAspect,
              yAspect     : BYTE;
              scrnWidth,
              scrnHeight  : SHORT;
            END;

     CMAP = RECORD
              colorcnt    : SHORT;
              red,
              green,
              blue        : ARRAY [0..255] OF BYTE;
            END;

     CAMG = RECORD
              viewType    : INTEGER;
            END;

     IFFInfoType = RECORD
                     IFFBMHD  : BMHD;
                     IFFCMAP  : CMAP;
                     IFFCAMG  : CAMG;
                     IFFTitle : IFFTitles;
                   END;

     IFFInfoTypePtr = ^IFFInfoType;


      { IFFErrors }

CONST iffNoErr            = 0;
      iffOutOfMem         = 1;
      iffOpenScreenfailed = 2;
      iffOpenWindowFailed = 3;
      iffOpenFailed       = 4;
      iffWrongIff         = 5;
      iffReadWriteFailed  = 6;

      { IFFError-Strings }

CONST IFFErrorStrings : ARRAY [iffNoErr..iffReadWriteFailed] OF String =
                        ("Kein Fehler",
                         "Nicht genug Speicher!",
                         "Fehler bei Openscreen!",
                         "Fehler bei Openwindow!",
                         "Konnte Datei nicht öffnen!",
                         "Fahlsches IFF-Format!",
                         "Schreib-/Lese-Fehler!");


FUNCTION ReadILBM(    name     : String;
                  VAR myscreen : ScreenPtr;
                  VAR mywindow : WindowPtr) : BYTE;

  VAR IFFInfo        : IFFInfoType;
      IFFError       : BYTE;
      Compression,
      MaskPlane,
      contload       : BOOLEAN;
      LineLength,
      LineWidth,
      i,j,k,length,
      PictureLength  : INTEGER;
      PictureBuffer,
      WorkBuffer,
      HeaderBuffer   : ADDRESS;
      TextBuffer     : STRING;
      LONGBuffer     : ^ARRAY [0..63] OF INTEGER;
      SHORTBuffer    : ^ARRAY [0..127] OF SHORT;
      BYTEBuffer     : ^ARRAY [0..255] OF BYTE;
      IFFHandle      : FileHandle;
      IFFBitMap      : BitMapPtr;


  PROCEDURE BufSkip(VAR bufptr : Address ;bytes : INTEGER);

    BEGIN
      bufptr:=Address(Integer(bufptr)+bytes);
    END;

  PROCEDURE IFFOpenScreen;

    VAR nuscreen : NewScreen;
        nuwindow : NewWindow;
        i        : INTEGER;

    BEGIN
      WITH NuScreen DO
      BEGIN
        width :=IFFInfo.IFFBMHD.scrnWidth;
        IF width <IFFInfo.IFFBMHD.width  THEN width :=IFFInfo.IFFBMHD.width;

        height:=IFFInfo.IFFBMHD.scrnHeight;
        IF height<IFFInfo.IFFBMHD.height THEN height:=IFFInfo.IFFBMHD.height;

        leftEdge:=IFFInfo.IFFBMHD.left;
        topEdge :=IFFInfo.IFFBMHD.top;

        depth:=IFFInfo.IFFBMHD.depth;
        viewModes:=0;
        IF width >=640 THEN ViewModes:=ViewModes OR HIRES;
        IF height>=400 THEN ViewModes:=ViewModes OR LACE;

        WITH IFFInfo.IFFCAMG DO
          ViewModes:=ViewModes OR ViewType;

        IF ((depth=6) OR (depth=8)) AND (ViewModes=0) THEN
        IF (IFFInfo.IFFCMAP.colorcnt=Hoch(2,depth-2)) THEN

        ViewModes:=HAM;

        IF ((ViewModes AND HAM)=HAM) AND
           (IFFInfo.IFFCMAP.colorcnt>Hoch(2,depth-2)) THEN
        IFFInfo.IFFCMAP.colorcnt:=Hoch(2,depth-2);

        detailPen:=0;
        blockPen:=0;
        stype:=CUSTOMSCREEN_f+SCREENQUIET_f+SCREENBEHIND_f;
        font:=NIL;
        defaultTitle:=NIL;
        gadgets:=NIL;
        customBitMap:=NIL;
      END;

    myscreen:=OpenScreen(ADR(nuscreen));
    IF myscreen=NIL THEN IFFError:=iffOpenScreenfailed
                    ELSE
       BEGIN
         WITH IFFInfo.IFFCMAP DO
           BEGIN
             FOR i:=0 TO (colorCnt-1) DO
               SetRGB4(ADR(myscreen^.SViewPort),i,red  [i] SHR 4,
                                                  green[i] SHR 4,
                                                  blue [i] SHR 4);
           END;

         WITH nuwindow DO
           BEGIN
             leftEdge:=0;
             topEdge:=0;
             width:=IFFInfo.IFFBMHD.width;
             height:=IFFInfo.IFFBMHD.height;
             detailPen:=1;
             blockPen:=0;
             idcmpFlags:=MOUSEBUTTONS_f;
             flags:=BORDERLESS+NOCAREREFRESH+RMBTRAP;
             firstGadget:=NIL;
             checkMark:=NIL;
             title:=NIL;
             screen:=myscreen;
             bitMap:=NIL;
             wtype:=CUSTOMSCREEN_F;
           END;

         mywindow:=OpenWindow(ADR(nuwindow));
         IF mywindow=NIL THEN
            BEGIN
              CloseScreen(myscreen);
              myscreen:=NIL;
              IFFError:=iffOpenWindowFailed;
            END;
       END;
    END;

  PROCEDURE ReadQuick(mto : ADDRESS;Count : SHORT;fake : BOOLEAN);

    BEGIN
      IF fake=FALSE THEN
         CopyMem(WorkBuffer,mto,Count);
      BufSkip(WorkBuffer,Count);
    END;

  PROCEDURE ReadSlow(Destination : ADDRESS;Count : SHORT);

    VAR kk,
        scrRow,
        bCnt    : INTEGER;
        inCode  : BYTE;
        ToPtr   : ^ARRAY [0..9999] OF BYTE;
        DPtr    : ^ARRAY [0..254] OF BYTE;
        RQBuf   : BYTE;
        j,jto   : SHORT;

    BEGIN
      ToPtr:=Destination;
      bCnt:=0;
      WHILE bCnt<Count DO
        BEGIN
          DPtr:=WorkBuffer;
          inCode:=DPtr^[0];
          BufSkip(WorkBuffer,1);
          IF inCode<128 THEN
             BEGIN
               CopyMem(WorkBuffer,Address(Integer(Destination)+bCnt),inCode+1);
               BufSkip(WorkBuffer,inCode+1);
               Inc(bCnt,inCode+1);
             END
            ELSE
             IF inCode>128 THEN
                BEGIN
                  DPtr:=WorkBuffer;
                  RQBuf:=DPTr^[0];
                  BufSkip(WorkBuffer,1);

                  jTo:=bCnt+256-inCode;
                  FOR j:=bCnt TO jto DO
                    ToPtr^[j]:=RQBuf;
                  Inc(bCnt,257-inCode);
                END;
        END;
    END;

  PROCEDURE CheckILBM;

    BEGIN
      IF StrNEq(TextBuffer,"FORM",4)=FALSE THEN
         IFFError:=iffOpenFailed;

      IF (StrNEq(TextBuffer,"FORM",4)=TRUE) AND
         (StrNEq(Address(Integer(TextBuffer)+8),"ILBM",4)=FALSE) THEN
         IFFError:=iffWrongIFF;
    END;

  PROCEDURE SetzeStartwerte;

    BEGIN
      IFFInfo.IFFTitle:=IFFTitles(0);
      IFFError:=iffnoErr;
      myscreen:=NIL;
      mywindow:=NIL;
      PictureBuffer:=NIL;
      PictureLength:=0;
      contload:=FALSE;
      IFFHandle:=NIL;
    END;

  PROCEDURE ReadBMHD;

    BEGIN
      IFFInfo.IFFTitle:=IFFInfo.IFFTitle OR BMHD_f;
      LONGBuffer:=WorkBuffer;
      BufSkip(WorkBuffer,4);
      j:=LONGBuffer^[0];
      SHORTBuffer:=WorkBuffer;
      BYTEBuffer:=WorkBuffer;
      BufSkip(WorkBuffer,j);
      WITH IFFInfo.IFFBMHD DO
        BEGIN
          width:=SHORTBuffer^[0];
          height:=SHORTBuffer^[1];
          left:=SHORTBuffer^[2];
          top:=SHORTBuffer^[3];
          depth:=BYTEBuffer^[8];
          masking:=BYTEBuffer^[9];
          MaskPlane:=(masking=1);
          Compression:=(ByteBuffer^[10]=1);
          transCol:=SHORTBuffer^[6];
          xAspect:=BYTEBuffer^[14];
          yAspect:=BYTEBuffer^[15];
          scrnWidth:=SHORTBuffer^[8];
          scrnHeight:=SHORTBuffer^[9];
        END;
    END;

  PROCEDURE ReadCMAP;

    BEGIN
      IFFInfo.IFFTitle:=IFFInfo.IFFTitle OR CMAP_f;
      LONGBuffer:=WorkBuffer;
      BufSkip(WorkBuffer,4);
      i:=LONGBuffer^[0];
      BYTEBuffer:=WorkBuffer;
      BufSkip(WorkBuffer,i);
      WITH IFFInfo.IFFCMAP DO
         BEGIN
          colorcnt:=i DIV 3;
           j:=0;
           FOR k:=0 TO colorcnt-1 DO
             BEGIN
               red[k]:=BYTEBuffer^[j];
               green[k]:=BYTEBuffer^[j+1];
               blue[k]:=BYTEBuffer^[j+2];
               Inc(j,3);
             END;
         END;
    END;

  PROCEDURE ReadCAMG;

    BEGIN
      IFFInfo.IFFTitle:=IFFInfo.IFFTitle OR CAMG_f;
      LONGBuffer:=WorkBuffer;
      BufSkip(WorkBuffer,8);
      IFFInfo.IFFCAMG.viewType:=LONGBuffer^[1];
    END;

  PROCEDURE ReadBODY;

     BEGIN
      IFFInfo.IFFTitle:=IFFInfo.IFFTitle OR BODY_f;

      IFFOpenScreen;

      IF IFFError=iffNoErr THEN
         BEGIN
           BufSkip(WorkBuffer,4);

           IFFBitMap:=myscreen^.SRastPort.BitMap;
           LineLength:=RASSIZE(IFFInfo.IFFBMHD.width,1);
           LineWidth:=IFFBitMap^.BytesPerRow;

           IF Compression THEN
              BEGIN
                FOR i:=0 TO (IFFInfo.IFFBMHD.height-1) DO
                  FOR j:=0 TO (IFFBitMap^.Depth-1) DO
                    ReadSlow(Address(Integer(IFFBitMap^.Planes[j])+
                            (LineWidth*i)),LineLength);
              END
             ELSE
              BEGIN
                FOR i:=0 TO (IFFInfo.IFFBMHD.height-1) DO
                  FOR j:=0 TO (IFFBitMap^.Depth-1) DO
                    ReadQuick(Address(Integer(IFFBitMap^.Planes[j])+(LineWidth*i)),
                LineLength,FALSE);
                IF MaskPlane THEN
                   ReadQuick(NIL,LineLength,TRUE);
              END;

         END;
      contload:=FALSE;
    END;

  BEGIN
    SetzeStartwerte;

    IFFHandle:=DOSOpen(Name,MODE_OLDFILE);            { Bilddatei öffnen   }
    IF IFFHandle=NIL THEN IFFError:=iffOpenfailed     { Bei Fehler Abbruch }
                     ELSE                             { sonst weiter       }
      BEGIN
        HeaderBuffer:=AllocMem(12,MEMF_CLEAR+MEMF_PUBLIC);{ Speicher holen }
        IF HeaderBuffer<>NIL THEN
          BEGIN
            length:=DOSRead(IFFHandle,HeaderBuffer,12);{Die Ersten 12 Byte }
            IF length<>12 THEN IFFError:=iffReadWriteFailed;       { holen }
            TEXTBuffer:=HeaderBuffer;
            LONGBuffer:=HeaderBuffer;
            CheckILBM;                            { Überprüfen ob IFF-ILBM }

            PictureLength:=LONGBuffer^[1]-4;
            FreeMem(HeaderBuffer,12);          { Speicher wieder freigeben }

            IF IFFError=iffNoErr THEN                   { Wenn kein Fehler }
              BEGIN

                PictureBuffer:=AllocMem(PictureLength,MEMF_CLEAR+MEMF_PUBLIC);
                                                       { Weiterer Speicher }
                IF PictureBuffer=NIL THEN IFFError:=iffOutofmem
                                     ELSE
                  BEGIN
                    length:=DOSRead(IFFHandle,PictureBuffer,PictureLength);
                    IF IFFHandle<>NIL THEN    { Bild in den Speicher holen }
                      BEGIN
                        DOSClose(IFFHandle);             { Datei schließen }
                        IFFHandle:=NIL;
                      END;
                    IF length<>PictureLength THEN IFFError:=iffReadWritefailed
                                          ELSE contload:=TRUE;
                    WorkBuffer:=PictureBuffer;     { Laden fertig und ende }
                  END;
              END;
          END;
      END;

    IF contload THEN
      BEGIN
        WHILE (IFFError=iffNoErr) AND (contload) DO { Solange kein Fehler }
          BEGIN                                     { und noch Daten da   }
            TextBuffer:=WorkBuffer;
            BufSkip(WorkBuffer,4);

            IF StrNEq(TextBuffer,"BMHD",4) THEN
               ReadBMHD;

            IF StrNEq(TextBuffer,"CMAP",4) THEN
               ReadCMAP;

            IF StrNEq(TextBuffer,"CAMG",4) THEN
               ReadCAMG;

            IF StrNEq(TextBuffer,"BODY",4) THEN
               ReadBODY;

            IF NOT StrNEq(TextBuffer,"CMAP",4) AND
               NOT StrNEq(TextBuffer,"BODY",4) AND
               NOT StrNEq(TextBuffer,"CAMG",4) AND
               NOT StrNEq(TextBuffer,"BMHD",4) THEN
               BEGIN
                 LONGBuffer:=WorkBuffer;
                 BufSkip(WorkBuffer,4);
                 i:=LONGBuffer^[0];
                 BufSkip(WorkBuffer,i);
               END;
          END;
      END;

    IF IFFHandle<>NIL THEN DOSClose(IFFHandle);
    IF PictureBuffer<>NIL THEN FreeMem(PictureBuffer,PictureLength);
    IF IFFError<>iffNoErr THEN
       BEGIN
         IF mywindow<>NIL THEN MyCloseWindow(mywindow);
         IF myscreen<>NIL THEN CloseScreen(myscreen);
         mywindow:=NIL;
         myscreen:=NIL;
       END
      ELSE
       BEGIN
         ScreenToFront(MyScreen);
         ActivateWindow(Mywindow);
       END;

    ReadILBM:=iffError;
  END;
