{ LS-Tron.i }

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
  EXTERNAL;

PROCEDURE Show(Meldung : STRING);
  EXTERNAL;

FUNCTION Ask(Meldung : STRING) : BOOLEAN;   { Requester aufrufen   }
  EXTERNAL;

FUNCTION AskEnglish(Meldung : STRING) : BOOLEAN;   { Requester aufrufen   }
  EXTERNAL;

FUNCTION Choose(meldung,wahl1,wahl2,wahl3 : STRING) : BYTE;
  EXTERNAL;

PROCEDURE MakeString(myVar : INTEGER;VAR s : STRING); { Integer => String }
  EXTERNAL;

PROCEDURE AddString(VAR s : STRING;x : SHORT); { Integer an String hängen }
  EXTERNAL;

FUNCTION IncAddress(x : ADDRESS;zahl : INTEGER) : ADDRESS;
  EXTERNAL;

FUNCTION Str2Int(s : STRING) : INTEGER;
  EXTERNAL;

PROCEDURE Byte2Hex(zahl : BYTE;VAR s : STRING);
  EXTERNAL;

PROCEDURE Code2String(zahl : BYTE;VAR s : STRING);
  EXTERNAL;

PROCEDURE Code2StringEng(zahl : BYTE;VAR s : STRING);
  EXTERNAL;

PROCEDURE SetGadget(Gad : GadgetPtr;nextGad,GadRender,SelRender,
                                    GadText : ADDRESS);
  EXTERNAL;

PROCEDURE SelectGadget(rp : RastPortPtr;Gad : GadgetPtr);
  EXTERNAL;

PROCEDURE Print(RP : RastPortPtr;x,y : SHORT;Zeile : STRING;colour : SHORT);
  EXTERNAL;

FUNCTION GetGadgetID(iadr : GadgetPtr) : SHORT; { Gadget identifizieren }
  EXTERNAL;

PROCEDURE KillMSGs(UserPort : MsgPortPtr);
  EXTERNAL;

PROCEDURE MyCloseWindow(MyWin : WindowPtr); { Fenster schön schließen }
  EXTERNAL;

PROCEDURE Line(RPort : RastPortPtr;x1,y1,x2,y2 : SHORT); { Linie Malen }
  EXTERNAL;

PROCEDURE DrawBox(rp : RastportPtr;x,y,tx,ty : SHORT); { Box malen (3D) }
  EXTERNAL;

PROCEDURE DrawIBox(rp : RastportPtr;x,y,tx,ty : SHORT); { Box invertiert }
  EXTERNAL;

PROCEDURE DrawCBox(rp : RastportPtr;x,y,tx,ty,c1,c2 : SHORT); { Box mit Farbenwahl }
  EXTERNAL;

PROCEDURE DrawSBox(rp : RastportPtr;x,y,tx,ty : SHORT); { einfarbige Box }
  EXTERNAL;

PROCEDURE Draw0Box(rp : RastportPtr;x,y,tx,ty : SHORT); { Box löschen }
  EXTERNAL;

FUNCTION Hoch(basis,exponent : INTEGER) : INTEGER;
  EXTERNAL;


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
  EXTERNAL;
