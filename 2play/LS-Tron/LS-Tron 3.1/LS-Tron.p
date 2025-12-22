PROGRAM LS_Tron;

{$I "LS-Tron.i" }

CONST Version  = "$VER: LS-Tron 3.1 (30.04.96)";
      Ver      = "v 3.1";
      Datum    = "30.04.1996";
      pi       = 3.141592653589793238462643;

      maxPlay  =   6; { Maximale Spieleranzahl }
      maximum  = 500;

{$I "LS-Tron-Types.i" }
{$I "LS-Tron-Const.i" }

VAR MyScreen    : ScreenPtr;
    MyWindow    : WindowPtr;       { System Kram...                     }
    MyRastPort  : RastPortPtr;
    MyProcess   : ProcessPtr;
    RWindow     : WindowPtr;
    GameScreen  : ScreenPtr;
    GameWindow  : WindowPtr;
    GameRP      : RastPortPtr;
    normFont    : TextFontPtr;     { Ein Font                           }
    MyModule    : MMD0Ptr;         { ein MED-Modul                      }
    MyWBMessage : WBStartupPtr;    { Workbenchmessage                   }
    TitelWindow : WindowPtr;       { Für Titelbild                      }
    TitelScreen : ScreenPtr;       {  "      "                          }

    NormColours,black : ColourArray;
    Backcolours       : BackArray;
    Ende        : BOOLEAN;         { ???                                }
    TBase       : TronBasePtr;
    MouseClear  : MouseCArrayPtr;  { Für Mausausblendung beim Spiel     }
    MouseData   : MouseArrayPtr;   { Für eigene Maus                    }

FUNCTION WBStart : BOOLEAN; { Wurde das Programm von der WB aus gestartet?}

  BEGIN
    IF MyProcess<>NIL THEN WBStart:=(MyProcess^.pr_Tasknum=0)
                      ELSE WBStart:=TRUE; { Falls nicht feststellbar... }
  END;

PROCEDURE DelMouse(aWindow : WindowPtr); { Mauszeiger unsichtbar machen }

  BEGIN
    ClearPointer(aWindow);
    SetPointer(aWindow,MouseClear,1,16,-2,-2);
  END;

PROCEDURE ViewMouse(aWindow : WindowPtr); { Mauszeiger darstellen }

  BEGIN
    ClearPointer(aWindow);
    SetPointer(aWindow,MouseData,12,16,-2,0);
  END; { fön nich' ?!? }

FUNCTION Length(s : STRING) : SHORT; { Länge eines Strings in Pixeln }

  BEGIN
    Length:=TextLength(MyRastPort,s,strLen(s));
  END;

FUNCTION Sprache : BYTE;

  BEGIN
    CASE ORD(TBase^.Sprache) OF
      68 : Sprache:=Deutsch;
      69 : Sprache:=English;
     ELSE  Sprache:=English;
    END;
  END;

PROCEDURE CloseAll; { Alles schließen }

  PROCEDURE SetColoursDown; { Farben schwärzen }

    VAR MyColours : ColourArray;
        Hilfe     : BYTE;

    BEGIN
      CopyMem(ADR(NormColours),ADR(MyColours),SIZEOF(ColourArray));

      WHILE mycolours[1].r>0 DO
        BEGIN
          FOR Hilfe:=0 TO 19 DO
            BEGIN
              SetRGB4(ADR(MyScreen^.SViewPort),hilfe,
                                 MyColours[hilfe].r,
                                 MyColours[hilfe].g,
                                 MyColours[hilfe].b);

            WITH mycolours[hilfe] DO
              BEGIN
                IF r>0 THEN r:=r-1;
                IF g>0 THEN g:=g-1;
                IF b>0 THEN b:=b-1;
              END;
            END;
        END;
    END;

  PROCEDURE FreeTBase;

    VAR zahl : BYTE;

    BEGIN
      WITH TBase^ DO
        BEGIN
          FreeString(TronDir);
          FreeString(MyMaze.MazeDir);
          FreeString(MyMaze.MazeName);
          WITH MyMaze DO
            IF Linien<>NIL THEN FreeMem(Linien,SizeOf(Linie)*LineNum);
          FOR zahl:=1 TO maxplay DO
            FreeString(players[zahl].Name);
        END;

      Dispose(TBase);
    END;

  BEGIN { Was ist denn so alles offen }
    IF TBase^.Sound THEN DimOffPlayer(20);

    FreeTBase;

    IF MyScreen     <>NIL THEN SetColoursDown;
    IF MyModule     <>NIL THEN Delay(50);

    IF GameWindow   <>NIL THEN BEGIN
                                 ClearPointer (GameWindow);
                                 MyCloseWindow(GameWindow);
                               END;
    IF MyWindow     <>NIL THEN BEGIN
                                 ClearPointer (MyWindow  );
                                 MyCloseWindow(MyWindow  );
                                 myProcess^.pr_WindowPtr:=RWindow;
                               END;

    IF MouseData    <>NIL THEN FreeMem(MouseData ,SizeOf(mousearray ));
    IF MouseClear   <>NIL THEN FreeMem(MouseClear,SizeOf(mouseCarray));

    IF MyScreen     <>NIL THEN CloseScreen(MyScreen  );
    IF GameScreen   <>NIL THEN CloseScreen(GameScreen);

    IF normFont     <>NIL THEN CloseFont(NormFont);

    IF TitelWindow  <>NIL THEN MyCloseWindow(TitelWindow);
    IF TitelScreen  <>NIL THEN CloseScreen(TitelScreen);

    IF gfxBase      <>NIL THEN CloseLibrary(LibraryPtr(gfxBase      ));
    IF Rtbase       <>NIL THEN CloseLibrary(LibraryPtr(rtbase       ));
    IF diskfontbase <>NIL THEN CloseLibrary(LibraryPtr(diskfontbase ));

    IF MyModule     <>NIL THEN BEGIN
                                 FreePlayer;
                                 UnloadModule(MyModule);
                               END;
    IF MedPlayerBase<>NIL THEN CloseLibrary(LibraryPtr(MEDPlayerBase));

  END; { Nilismus Error... }

PROCEDURE CleanExit(error : INTEGER); { Fehler ausgeben und Tschüß }

  PROCEDURE WriteError(Err : INTEGER);

    BEGIN
      WRITE("\n");
      CASE Err OF
        4 : WRITE("Couldn`t find own processpointer!");
        5 : WRITE("Couldn`t find the LS-Tron sourcedirectory!");
        6 : WRITE("There was no WBMessage!");
        7 : WRITE("Couldn`t read the configurationfile!");
       ELSE CASE Sprache OF
              Deutsch : CASE Err OF
                           1 : WRITE("Konnte Screen nicht öffnen!");
                           2 : WRITE("Konnte Fenster nicht öffnen!");
                           3 : WRITE("Nicht genug Chip-Mem vorhanden!");
                           8 : WRITE("\nDateiliste nicht vollständig!");
                           9 : WRITE("Es konnten nicht alle Screens und Fenster geöffnet werden!");
                          10 : WRITE("Nicht genug Speicher vorhanden!");
                          21 : WRITE("Konnte die Grafics.library nicht öffnen!");
                          22 : WRITE("Konnte die Reqtools.library nicht öffnen!");
                          23 : WRITE("Konnte die Diskfont.library nicht öffnen!");
                          30 : WRITE("Konnte den LS.font nicht öffnen!");
                          50 : WRITE("?");
                          51 : WRITE("Nicht genug Speicher!");
                          52 : WRITE("Konnte Screen nicht öffnen!");
                          53 : WRITE("Konnte Fenster nicht öffnen!");
                          54 : WRITE("Konnte Datei nicht öffnen!");
                          55 : WRITE("Das Titelbild enthält ein falsches IFF-Format!");
                          56 : WRITE("Schreib-/Lese-Fehler!");
                         ELSE WRITE("Unbekannte Fehlernummer : ",err);
                        END;
             ELSE CASE Err OF
                     1 : WRITE("Couldn't open screen!");
                     2 : WRITE("Couldn't open window!");
                     3 : WRITE("Not enough Chip-Mem!");
                     8 : WRITE("\nThere are files missing!");
                     9 : WRITE("Couldn't open all screens and windows!");
                    10 : WRITE("Not enough memory!");
                    21 : WRITE("Couldn't open grafics.library!");
                    22 : WRITE("Couldn't open reqtools.library!");
                    23 : WRITE("Couldn't open diskfont.library!");
                    30 : WRITE("Couldn't open LS.font!");
                    50 : WRITE("?");
                    51 : WRITE("Not enough memory!");
                    52 : WRITE("Couldn't open screen!");
                    53 : WRITE("Couldn't open window!");
                    54 : WRITE("Couldn't open file!");
                    55 : WRITE("The title-picture consists of a wrong IFF-format!");
                    56 : WRITE("Read-/Write-Error!");
                   ELSE WRITE("Unknown errornumber : ",Err);
                  END;
            END;
      END;

      WRITE("\n\n[ p");
    END;

  BEGIN
    CloseAll;
    WriteError(error);
    IF MyProcess<>NIL THEN BEGIN
                             IF WBStart THEN Delay(250);
                           END
                      ELSE Delay(250);
    EXIT(0);
  END;

PROCEDURE SetSColours; { Farben einstellen }

  VAR MyColours, Colours : ColourArray;
      Hilfe,help : BYTE;

  BEGIN
    CopyMem(ADR(Black      ),ADR(  Colours),SIZEOF(ColourArray));
    CopyMem(ADR(NormColours),ADR(MyColours),SizeOF(ColourArray));
    FOR help:=0 TO 15 DO
      BEGIN
        FOR Hilfe:=0 TO 19 DO
          BEGIN
            SetRGB4(ADDRESS(MyScreen^.SViewPort),hilfe,
                                Colours[hilfe].r,
                                Colours[hilfe].g,
                                Colours[hilfe].b);

            IF 14-help<mycolours[hilfe].r THEN { Farbwerte solange erhöhen,}
               inc(colours[hilfe].r);
            IF 14-help<mycolours[hilfe].g THEN { bis der richtige Wert     }
               inc(colours[hilfe].g);
            IF 14-help<mycolours[hilfe].b THEN { erreicht ist.             }
               inc(colours[hilfe].b);
          END;
      END;
  END;

PROCEDURE Sprache_Hauptmenue;

  BEGIN
    IF ORD(TBase^.Sprache)=68 THEN
       BEGIN
         Print(MyRastPort,281,113,GermanMain[1],1);
         Print(MyRastPort,282,133,GermanMain[2],1);
         Print(MyRastPort,269,153,GermanMain[3],1);
         Print(MyRastPort,264,173,GermanMain[4],1);
         Print(MyRastPort,264,193,GermanMain[5],1);
         Print(MyRastPort,283,213,GermanMain[6],8);
       END
      ELSE
       BEGIN
         Print(MyRastPort,281,113,EnglishMain[1],1);
         Print(MyRastPort,282,133,EnglishMain[2],1);
         Print(MyRastPort,269,153,EnglishMain[3],1);
         Print(MyRastPort,263,173,EnglishMain[4],1);
         Print(MyRastPort,263,193,EnglishMain[5],1);
         Print(MyRastPort,283,213,EnglishMain[6],8);
       END;
  END;

PROCEDURE OpenAll; { Alles öffnen }

  PROCEDURE GetProcessPtr; { Pointer auf eigenes Programm holen }

    BEGIN
      MyProcess:=ProcessPtr(FindTask(NIL)); { Prozessfenster umstellen }
      IF myProcess=NIL THEN CleanExit(Error_No_Process);
    END;

  PROCEDURE GetMyDir;

    FUNCTION SearchTree(Kind : BPTR;VAR DirName : STRING) : BOOLEAN;

      { Pfadnamen rekursiv bis zum Devicenamen ermitteln }

      VAR Elter : BPTR;
          Ok    : BOOLEAN;
          MyFib : FileInfoBlockPtr;

      BEGIN
        ok:=TRUE;

        MyFib:=NIL;
        New(MyFib);
        IF MyFib=NIL THEN Ok:=FALSE;

        IF Ok THEN
           BEGIN
             Elter:=NIL;
             Elter:=ParentDir(Kind);
             IF Elter<>NIL THEN Ok:=SearchTree(Elter,DirName);

             IF Ok THEN
                BEGIN
                  Ok:=Examine(Kind,MyFib);
                  IF Ok THEN BEGIN
                               StrCat(DirName,ADR(MyFib^.fib_FileName));
                               IF Elter=NIL THEN StrCat(DirName,":")
                                            ELSE StrCat(DirName,"/");
                             END;
                END;
           END;

        IF MyFib<>NIL THEN Dispose(MyFib);
        IF Elter<>NIL THEN Unlock(Elter);

        SearchTree:=Ok;
      END;

    PROCEDURE CliStart;

     { Verzeichnissnamen ausgehend von der Dosstruktur ermitteln }

      BEGIN
        IF NOT SearchTree(MyProcess^.pr_CurrentDir,TBase^.TronDir) THEN
           CleanExit(Error_No_Sourcedir);
      END;

    PROCEDURE Workbenchstart;

     { Ein dickes Danke an Wurzelsepp für diesen Code }

      BEGIN
        IF MyWBMessage=NIL THEN CleanExit(Error_No_WBMessage);

        WITH MyWBMessage^.sm_Arglist^[1] DO
          IF NOT SearchTree(wa_lock,TBase^.TronDir) THEN
             CleanExit(Error_No_Sourcedir);
      END;

    BEGIN
      MyWBMessage:=GetStartupMsg;

      IF WBStart THEN WorkbenchStart
                 ELSE CliStart;

      StrCpy(TBase^.MyMaze.MazeDir,TBase^.TronDir);
    END;

  PROCEDURE Load_Options; { engl: Load = Laden , Option = Option }

    VAR farbe      : BYTE;
        CFile      : TEXT;
        ConfigName : STRING;

    PROCEDURE Opt_Exit;

      BEGIN
       {$I-}
        Close(CFile);
       {$I+}

        FreeString(ConfigName);

        CleanExit(Error_in_Configfile);
      END;

    PROCEDURE Check_Options;

      BEGIN
        WITH TBase^ DO
          BEGIN
            IF (max_length MOD 50<>0) THEN
               max_length:=(Max_length DIV 50)*50;
            IF Max_Length<0   THEN Max_Length:=0;
            IF Max_Length>500 THEN Max_Length:=500;

            IF Player<2 THEN player:=2;
            IF player>6 THEN player:=6;

            IF speed<0 THEN speed:=0;
            IF speed>5 THEN speed:=5;

            IF level<0 THEN level:=0;
            IF level>5 THEN level:=5;

            IF human>player THEN human:=player;
            IF Human<0      THEN human:=0;

            IF Backcolour<1 THEN Backcolour:=0;
            IF backcolour>4 THEN Backcolour:=3;
          END;
      END;

    VAR Zeile : STRING;

    BEGIN
      ConfigName:=ALLOCSTRING(255);
      StrCpy(ConfigName,TBase^.TronDir);
      StrCat(ConfigName,"LS-Tron.config");

     {$I-}
      Reset(CFile,ConfigName); { Konfig-Datei suchen }
      IF IoResult<>0 THEN
         Opt_Exit;

      WITH TBase^ DO
        BEGIN
          Zeile:=AllocString(255);
          READLN(CFile,zeile);
          Sprache:=Zeile[0];
          FreeString(Zeile);
          IF IOResult<>0 THEN Opt_Exit;

          Sprache:=ToUpper(Sprache);
          IF NOT IsAlpha(Sprache) THEN Opt_Exit;

          READLN(CFile,max_length);
          IF IOResult<>0 THEN Opt_Exit;

          READLN(CFile,player);
          IF IOResult<>0 THEN Opt_Exit;

          READLN(CFile,speed);
          IF IOResult<>0 THEN Opt_Exit;

          READLN(CFile,level);
          IF IOResult<>0 THEN Opt_Exit;

          READLN(CFile,human);
          IF IOResult<>0 THEN Opt_Exit;

          READLN(CFile,Backcolour);
          IF IOResult<>0 THEN Opt_Exit;
        END;

      FOR farbe:=0 TO 19 DO         { Alle Farben laden (incl. Mausfarben) }
        WITH normcolours[farbe] DO
          BEGIN
            READLN(CFile,r);
            IF IoResult<>0 THEN Opt_Exit;
            READLN(CFile,g);
            IF IoResult<>0 THEN Opt_Exit;
            READLN(CFile,b);
            IF IoResult<>0 THEN Opt_Exit;
          END;

      FOR farbe:=1 TO 4 DO              { Hintergrundfarben laden }
        WITH backcolours[farbe] DO
          BEGIN
            READLN(CFile,r);
            IF IoResult<>0 THEN Opt_Exit;
            READLN(CFile,g);
            IF IoResult<>0 THEN Opt_Exit;
            READLN(CFile,b);
            IF IoResult<>0 THEN Opt_Exit;
          END;

      Close(CFile);
     {$I+}

      FreeString(ConfigName);

      Check_Options;
    END;

  PROCEDURE InitMouse; { Mausdaten bereitmachen & Speicher organisieren }

    VAR zahl : BYTE;

    BEGIN
      MouseClear:=ADDRESS(ALLOCMEM(SizeOf(MouseCArray),MEMF_CHIP));
      IF MouseClear=NIL THEN CleanExit(Error_No_Chipmem);

      FOR zahl:=0 TO 5 DO MouseClear^[zahl]:=0;

      MouseData:=ADDRESS(ALLOCMEM(SizeOf(MouseArray),MEMF_CHIP));
      IF MouseData=NIL THEN CleanExit(Error_No_Chipmem);
      CopyMem(ADR(MausDaten),ADDRESS(MouseData),SIZEOF(MouseArray));
    END;

  PROCEDURE SetBlackColours; { Farben:=schwarz; }

    VAR Hilfe : INTEGER;

    BEGIN
      FOR Hilfe:=0 TO 19 DO
        BEGIN
          SetRGB4(ADDRESS(MyScreen^.SViewPort),hilfe,0,0,0);
        END;
    END;

  PROCEDURE PlaySound; { ? }

    VAR SongName : STRING;
        zaehler  : BYTE;

    BEGIN
      TBase^.Sound:=FALSE;

      SongName:=ALLOCSTRING(255);               { Songnamen herausfinden }
      zaehler:=1;
      REPEAT
        GetParam(zaehler,SongName);             { Kann User wählen...    }
        zaehler:=zaehler+1;
      UNTIL (Songname^=CHR(0)) OR StrnIEq(SongName,"-l",2);

      IF SongName^=CHR(0) THEN
         BEGIN
           StrCpy(SongName,TBase^.TronDir);
           StrCat(SongName,"Med.LS-Tron");
         END
        ELSE
         BEGIN
           zaehler:=-1;
           REPEAT
             inc(zaehler);
             SongName[zaehler]:=SongName[zaehler+2];
           UNTIL SongName[zaehler]=CHR(0);
         END;

      IF GetPlayer(0)=0 THEN
         BEGIN
           MyModule:=LoadModule(SongName); { Modul laden }

           IF MyModule<>NIL THEN            { Modul abspielen }
              BEGIN
                PlayModule(MyModule);
                TBase^.Sound:=TRUE;
              END
             ELSE
              BEGIN
                FreePlayer;
                CloseLibrary(LibraryPtr(MedPlayerBase));
                MedPlayerBase:=NIL;
              END;
         END
        ELSE
         BEGIN
           CloseLibrary(LibraryPtr(MedPlayerBase));
           MedPlayerBase:=NIL;
         END;

      FreeString(SongName);
    END;

  PROCEDURE DrawText; { ? }

    PROCEDURE EmptyBox(PosX,PosY : SHORT);

      CONST x0    =   0;
            y0    =   1;
            seite =   8;

      VAR MyX,MyY : SHORT;

      BEGIN
        MyX:=x0+seite*2*PosX;
        MyY:=y0+seite*  PosY;

        SetAPen(MyRastPort,schwarz);
        Line(MyRastPort,MyX          ,MyY+seite-1,
                        MyX+2*seite-1,MyY+seite-1);
        Draw(MyRastPort,MyX+2*seite-1,MyY        );
        Line(MyRastPort,MyX+2*seite-2,MyY+seite-1,
                        MyX+2*seite-2,MyY        );

        SetAPen(MyRastPort,mgrau);
        Line(MyRastPort,MyX          ,MyY+seite-1,
                        MyX        +1,MyY        );
        Draw(MyRastPort,MyX+2*seite-2,MyY        );
        Line(MyRastPort,MyX        +1,MyY+seite-2,
                        MyX        +1,MyY        );
      END;

    PROCEDURE MiniBox(PosX,PosY,c : SHORT);

      CONST x0    =  80;
            y0    =   1;
            seite =   8;

      VAR MyX,MyY : SHORT;

      BEGIN
        IF c=11 THEN c:=0;

        MyX:=x0+seite*2*PosX;
        MyY:=y0+seite*  PosY;

        SetAPen(MyRastPort,schwarz);
        Line(MyRastPort,MyX          ,MyY+seite-1,
                        MyX+2*seite-1,MyY+seite-1);
        Line(MyRastPort,MyX+2*seite-1,MyY+seite-1,
                        MyX+2*seite-1,MyY        );
        Line(MyRastPort,MyX+2*seite-2,MyY+seite-1,
                        MyX+2*seite-2,MyY        );

        SetAPen(MyRastPort,mgrau);
        Line(MyRastPort,MyX          ,MyY+seite-1,
                        MyX          ,MyY        );
        Line(MyRastPort,MyX        +1,MyY+seite-2,
                        MyX        +1,MyY        );
        Line(MyRastPort,MyX        +1,MyY        ,
                        MyX+2*seite-2,MyY        );

        SetAPen(MyRastPort,c);
        RectFill(MyRastPort,MyX+2,MyY+1,MyX+2*seite-3,MyY+seite-2);
      END;

    VAR MyData : ADDRESS;
        x,y    : SHORT;

    BEGIN
      SetAPen(MyRastPort,8);
      SetBPen(MyRastPort,0);

      FOR x:=0 TO 39 DO
        FOR y:=0 TO 29 DO
          IF (x<14) OR (x>22) OR
             (y<12) OR (y>27) THEN EmptyBox(x,y);

      FOR x:=1 TO 28 DO
          FOR y:=1 TO 9 DO                   { "LS-Tron" schreiben }
              MiniBox(x,y,LSScript[x,10-y]);

      DrawBox(MyRastPort,225,97,366,224);
      DrawBox(MyRastPort,224,97,367,224);
      SetFont(MyRastPort,NormFont);

      SetAPen(MyRastPort,1);
      Line(MyRastPort,0,0,639,0);

      Sprache_Hauptmenue;
    END;

  PROCEDURE InitGadgets; { Gadgets vorbereiten }

    BEGIN
      Bora2.xy:=ADR(Koord2);
      Bora1.xy:=ADR(Koord1);
      Bora1.NextBorder:=ADR(Bora2);

      Borb2.xy:=ADR(Koord4);
      Borb1.xy:=ADR(Koord3);
      Borb1.NextBorder:=ADR(Borb2);

      SetGadget(ADR(Gad10),NIL       ,ADR(Bora1),ADR(Borb1),NIL);
      SetGadget(ADR(Gad05),ADR(Gad10),ADR(Bora1),ADR(Borb1),NIL);
      SetGadget(ADR(Gad04),ADR(Gad05),ADR(Bora1),ADR(Borb1),NIL);
      SetGadget(ADR(Gad03),ADR(Gad04),ADR(Bora1),ADR(Borb1),NIL);
      SetGadget(ADR(Gad02),ADR(Gad03),ADR(Bora1),ADR(Borb1),NIL);
      SetGadget(ADR(Gad01),ADR(Gad02),ADR(Bora1),ADR(Borb1),NIL);
    END;

         { Fenster & Screens : nervig wie notwendig... }

  CONST MyNewWindow : NewWindow = (0,10,640,246,0,0,RawKey_f+GadgetDown_f+
                                   Gadgetup_f,SMART_Refresh+RMBTrap+
                                   BORDERLESS,NIL,NIL,NIL,NIL,NIL,
                                   640,246,640,246,CUSTOMSCREEN_F);

        MyNewScreen : NewScreen = (0,0,640,256,4,8,1,HIRES,CUSTOMSCREEN_F+
                                   ScreenBehind_F,NIL,
                                   "LS-Tron - Programmbildschirm",
                                   NIL,NIL);

  PROCEDURE SetAllNil; { Für Fehlerabfang }

    BEGIN
      MyScreen     :=NIL;
      GameScreen   :=NIL;
      TitelScreen  :=NIL;
      MyWindow     :=NIL;
      gameWindow   :=NIL;
      TitelWindow  :=NIL;
      GfxBase      :=NIL;
      diskfontbase :=NIL;
      normFont     :=NIL;
      medplayerbase:=NIL;
      RTBase       :=NIL;
      MouseData    :=NIL;
      MouseClear   :=NIL;
      MyWBMessage  :=NIL;
      MyProcess    :=NIL;
    END;

  PROCEDURE AllocTBase; { Speicher für TBase holen...WICHTIG!!! }

    VAR zahl : BYTE;

    BEGIN
      New(TBase);
      WITH TBase^ DO
        BEGIN
          TronDir:=ALLOCSTRING(255);
          MyMaze.MazeDir:=ALLOCSTRING(255);
          MyMaze.MazeName:=ALLOCSTRING(255);
          MyMaze.linien:=NIL;
          MyMaze.LineNum:=0;
          FOR zahl:=1 TO maxplay DO
              BEGIN
                players[zahl].name:=ALLOCSTRING(20);
                StrCpy(Players[zahl].name,"Spieler ");
                AddString(Players[zahl].name,zahl);
              END;
        END;
    END;

  PROCEDURE OpenLibs; { Libraries öffnen... }

    BEGIN
      gfxBase:=Openlibrary("graphics.library",0);
      IF gfxBase=NIL THEN CleanExit(Error_No_Grafics);

      rtbase:=ADDRESS(OpenLibrary("reqtools.library",38));
      IF rtbase=NIL THEN CleanExit(Error_No_Reqtools);

      MEDPlayerBase:=OpenLibrary(medname,0);
      IF medplayerbase<>NIL THEN PlaySound;

      diskfontbase:=OpenLibrary("diskfont.library",0);
      IF Diskfontbase=NIL THEN CleanExit(Error_No_Diskfont);
    END;

  FUNCTION OpenDisplay : BOOLEAN; { Screens und Windows öffnen, }
                                  { Farben einstellen           }
                                  { usw.                        }

    VAR ok : BOOLEAN;

    BEGIN
      Ok:=FALSE;

      myNewScreen.font:=ADR(NFont);
      myScreen:=OpenScreen(ADR(MyNewScreen));
      IF MyScreen<>NIL THEN
         BEGIN
           SetBlackColours;

           InitGadgets;
           MyNewWindow.Screen:=MyScreen;
           MyNewWindow.FirstGadget:=ADR(Gad01);
           MyWindow:=OpenWindow(ADR(MyNewWindow));
           IF MyWindow<>NIL THEN
              BEGIN
                MyRastPort:=ADDRESS(MyWindow^.RPort);

                DelMouse(MyWindow);

                DrawText;

                Ok:=TRUE;
              END;
         END;

      IF NOT Ok THEN
         BEGIN
           IF MyWindow    <>NIL THEN MyCloseWindow(MyWindow  );
           IF MyScreen    <>NIL THEN CloseScreen  (MyScreen  );

           MyWindow  :=NIL;
           MyScreen  :=NIL;
         END;

      OpenDisplay:=Ok;
    END;

  PROCEDURE SetProcessWindow; { Bezugswindow für Proggie umstellen }

    BEGIN
      RWindow:=ADDRESS(MyProcess^.pr_WindowPtr);
      myProcess^.pr_WindowPtr:=MyWindow;
    END;

  PROCEDURE OpenLSFont; { Schöneren Zeichensatz laden }

    BEGIN
      NormFont:=OpenFont(ADR(NFont));
      IF NormFont=NIL THEN
         BEGIN
           NormFont:=OpenDiskFont(ADR(NFONT));
           IF normFont=NIL THEN CleanExit(Error_No_LS_font);
         END;
    END;

  PROCEDURE ClosePic;

    BEGIN
      IF WaitPort(TitelWindow^.Userport)=NIL THEN;

      MyCloseWindow(TitelWindow);
      CloseScreen(TitelScreen);

      TitelWindow:=NIL;
      TitelScreen:=NIL;
    END;

  PROCEDURE CheckFiles; { Überprüfen ob alle Dateien noch vorhanden sind }

    VAR Didntfindallfiles : BOOLEAN;

    FUNCTION FoundFile(Name : STRING) : BOOLEAN; { Nach einer Datei suchen }

      VAR MyLock   : ADDRESS;
          Found    : BOOLEAN;
          fileName : STRING;

      BEGIN
        FileName:=ALLOCSTRING(255);

        StrCpy(FileName,TBase^.TronDir);
        StrCat(FileName,Name);

        MyLock:=NIL;
        MyLock:=Lock(FileName,ACCESS_READ);

        Found:=(MyLock<>NIL);

        Unlock(MyLock);

        FreeString(FileName);

        foundfile:=Found;
      END;

    PROCEDURE NotFound(s : STRING); { Nicht gefunden - FEHLER UND ENDE }

      BEGIN
        Didntfindallfiles:=TRUE;
        IF Sprache=Deutsch THEN WRITE("Konnte Datei ",s," nicht finden!\n")
                           ELSE WRITE("Couldn't find file ",s,"!\n");
      END;

    BEGIN
      DidntFindAllFiles:=FALSE;

      IF NOT FoundFile("Control.i"        ) THEN NotFound("Control.i"     );
      IF NOT FoundFile("Control.i.info"   ) THEN NotFound("Control.i.info");
      IF NOT FoundFile("Extra.i"          ) THEN NotFound("Extra.i"       );
      IF NOT FoundFile("Extra.i.info"     ) THEN NotFound("Extra.i.info"  );
      IF NOT FoundFile("Init.i"           ) THEN NotFound("Init.i"        );
      IF NOT FoundFile("Init.i.info"      ) THEN NotFound("Init.i.info"   );
      IF NOT FoundFile("Installation"     ) THEN NotFound("Installation"  );
      IF NOT FoundFile("Installation.info") THEN NotFound("Installation.info");
      IF NOT FoundFile("Joystick.i"       ) THEN NotFound("Joystick.i"    );
      IF NOT FoundFile("Joystick.i.info"  ) THEN NotFound("Joystick.i.info");
      IF NOT FoundFile("Joystick.mod"     ) THEN NotFound("Joystick.mod"  );
      IF NOT FoundFile("Joystick.mod.info") THEN NotFound("Joystick.mod.info");
      IF NOT FoundFile("Joystick.o"       ) THEN NotFound("Joystick.o"    );
      IF NOT FoundFile("Joystick.o.info"  ) THEN NotFound("Joystick.o.info");
      IF NOT FoundFile("LS-Tron"          ) THEN NotFound("LS-Tron"       );
      IF NOT FoundFile("LS-Tron.config"   ) THEN NotFound("LS-Tron.config");
      IF NOT FoundFile("LS-Tron-Const.i"  ) THEN NotFound("LS-Tron-Const.i");
      IF NOT FoundFile("LS-Tron-Const.i.info") THEN NotFound("LS-Tron-Const.i.info");
      IF NOT FoundFile("LS-Tron.doc"      ) THEN NotFound("LS-Tron.doc"   );
      IF NOT FoundFile("LS-Tron.doc.info" ) THEN NotFound("LS-Tron.doc.info");
      IF NOT FoundFile("LS-Tron.dok"      ) THEN NotFound("LS-Tron.dok"   );
      IF NOT FoundFile("LS-Tron.dok.info" ) THEN NotFound("LS-Tron.dok.info");
      IF NOT FoundFile("LS-Tron.i"        ) THEN NotFound("LS-Tron.i"     );
      IF NOT FoundFile("LS-Tron.i.info"   ) THEN NotFound("LS-Tron.i.info");
      IF NOT FoundFile("LS-Tron.info"     ) THEN NotFound("LS-Tron.info"  );
      IF NOT FoundFile("LS-Tron.mod"      ) THEN NotFound("LS-Tron.mod"   );
      IF NOT FoundFile("LS-Tron.mod.info" ) THEN NotFound("LS-Tron.mod.info");
      IF NOT FoundFile("LS-Tron.o"        ) THEN NotFound("LS-Tron.o"     );
      IF NOT FoundFile("LS-Tron.o.info"   ) THEN NotFound("LS-Tron.o.info");
      IF NOT FoundFile("LS-Tron.p"        ) THEN NotFound("LS-Tron.p"     );
      IF NOT FoundFile("LS-Tron.p.info"   ) THEN NotFound("LS-Tron.p.info");
      IF NOT FoundFile("LS-Tron.Title"    ) THEN NotFound("LS-Tron.Title" );
      IF NOT FoundFile("LS-Tron-Types.i"  ) THEN NotFound("LS-Tron-Types.i");
      IF NOT FoundFile("LS-Tron-Types.i.info") THEN NotFound("LS-Tron-Types.i.info");
      IF NOT FoundFile("Maze.i"           ) THEN NotFound("Maze.i"        );
      IF NOT FoundFile("Maze.i.info"      ) THEN NotFound("Maze.i.info"   );
      IF NOT FoundFile("Mazes"            ) THEN NotFound("Mazes"         );
      IF NOT FoundFile("Mazes.info"       ) THEN NotFound("Mazes.info"    );
      IF NOT FoundFile("Player.i"         ) THEN NotFound("Player.i"      );
      IF NOT FoundFile("Player.i.info"    ) THEN NotFound("Player.i.info" );

      IF NOT FoundFile("Mazes/Tron1.maze" ) THEN NotFound("Tron1.maze"    );
      IF NOT FoundFile("Mazes/Tron2.maze" ) THEN NotFound("Tron2.maze"    );
      IF NOT FoundFile("Mazes/Tron3.maze" ) THEN NotFound("Tron3.maze"    );
      IF NOT FoundFile("Mazes/Tron4.maze" ) THEN NotFound("Tron4.maze"    );
      IF NOT FoundFile("Mazes/Fun.maze"   ) THEN NotFound("Fun.maze"      );

      IF DidntFindAllFiles THEN
         BEGIN
           Delay(100);
           CleanExit(Error_in_Filelist);
         END;
    END;

  PROCEDURE ViewIff(VAR PicScreen : ScreenPtr;VAR PicWindow : WindowPtr);

    VAR PicName : STRING;
        Error   : BYTE;

    BEGIN
      PicName:=NIL;
      PicName:=ALLOCSTRING(255);
      IF PicName=NIL THEN CleanExit(Error_No_Mem);

      StrCpy(PicName,TBase^.TronDir);
      StrCat(PicName,"LS-Tron.Title");

      Error:=ReadILBM(picname,PicScreen,PicWindow);

      FreeString(picname);

      IF Error<>IFFNoErr THEN CleanExit(Error+50);
    END;

  PROCEDURE WaitWithIff(VAR PicScreen : ScreenPtr;VAR PicWindow : WindowPtr;
                        VAR ToScreen  : ScreenPtr;VAR ToWindow  : WindowPtr);

    BEGIN
      IF WaitPort(PicWindow^.Userport)=NIL THEN;

      ScreenToFront(ToScreen);
      ActivateWindow(ToWindow);

      MyCloseWindow(PicWindow);
      CloseScreen(PicScreen);

      PicWindow:=NIL;
      PicScreen:=NIL;
    END;

  FUNCTION Develop : BOOLEAN;

    VAR s    : STRING;
        Dev  : BOOLEAN;
        Zahl : INTEGER;

    BEGIN
      s:=ALLOCSTRING(255);
      StrCpy(s," ");
      zahl:=1;
      Dev:=FALSE;

      WHILE s^<>CHR(0) DO
        BEGIN
          GetParam(zahl,s);
          inc(zahl);
          IF StrIEq(s,"-dev") THEN dev:=TRUE;
        END;

      FreeString(s);
      Develop:=Dev;
    END;

  BEGIN { Jetzt alles öffnen und überprüfen ob Offen | Keine weitere Doku }
    SetAllNil;

    AllocTBase;

    GetProcessPtr;

    GetMyDir;

    Load_Options;

    OpenLibs;

    InitMouse;

    ViewIff(TitelScreen,TitelWindow);

    DelMouse(TitelWindow);

    IF NOT Develop THEN CheckFiles;

    OpenLSFont;

    IF OpenDisplay THEN
       BEGIN
         SetProcessWindow;
         ViewMouse(MyWindow);

         ClearPointer(TitelWindow);

         WaitWithIff(TitelScreen,TitelWindow,MyScreen,Mywindow);
       END
      ELSE
       BEGIN
         ClosePic;

         IF NOT OpenDisplay THEN CleanExit(Error_Not_All_Open);

         SetProcessWindow;
         ViewMouse(MyWindow);
       END;
  END;

{$I "Player.i" }
{$I "Init.i"   }

PROCEDURE Hauptprogramm; { Kurz nich ? }

  BEGIN
    WHILE NOT Ende DO
      BEGIN
        Play;
        Init;
      END;
  END;

PROCEDURE Copyright; {???}

  BEGIN
    WRITE("[1m[4mLS-Tron[0m [3m",ver,"\n\n");
    WRITE("[0m© 1994-1996 by [1mDennis Müller[0m (",datum,").\n");
    WRITE("This game is freeware.\n");
    WRITE("All rights reserved.\n\n");
  END;

PROCEDURE KillCursor;

  BEGIN
    WRITE("[0 p");
  END;

PROCEDURE ViewCursor;

  BEGIN
    WRITE("[ p");
  END;

BEGIN             { Das eigentliche Hauptprogramm... }
  KillCursor;
  Copyright;
  OpenAll;
  Init1st;
  Hauptprogramm;
  CloseAll;
  ViewCursor;
END.
