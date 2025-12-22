{ Init.i }

{$I "Extra.i"   }

PROCEDURE Init; { Alles zurücksetzen }

  PROCEDURE Info;

    CONST sNewWindow : NewWindow = (0,10,640,246,0,0,RawKey_F+
                                    MouseButtons_F,SMART_Refresh+
                                    ACTIVATE+RMBTrap+Borderless,NIL,
                                    NIL,NIL,NIL,NIL,640,246,640,246,
                                    CUSTOMSCREEN_F);

    VAR sWindow   : WindowPtr;
        sRastPort : RastPortPtr;

    PROCEDURE ClearPage;   { Fensterinhalt löschen }

      BEGIN
        SetAPen(sRastPort,0);
        RectFill(sRastPort,4,4,635,241);
      END;

    PROCEDURE WaitClick; { Auf MSG warten }

      VAR sMsg : IntuiMessagePtr;

      BEGIN
        sMsg:=NIL;
        sMsg:=ADDRESS(GetMsg(sWindow^.UserPort));
        WHILE sMsg<>NIL DO
          BEGIN
            ReplyMsg(ADDRESS(sMsg));
            sMsg:=NIL;
            sMsg:=ADDRESS(GetMsg(sWindow^.UserPort));
          END;

        REPEAT
          sMSG:=NIL;
          sMSG:=ADDRESS(WaitPort(sWindow^.UserPort));
          sMSG:=ADDRESS(GetMSG(  sWindow^.UserPort));
        UNTIL sMSG<>NIL;
        ReplyMSG(ADDRESS(sMSG));
      END;

    PROCEDURE Page1; { Erste Infoseite zeigen }

      BEGIN

        Print(sRastPort,197, 20,"L     SSSSS       TTTTT RRRRR  OOO  N   N",8);
        Print(sRastPort,197, 28,"L     S             T   R   R O   O NN  N",8);
        Print(sRastPort,197, 36,"L     SSSSS -----   T   RRRRR O   O N N N",8);
        Print(sRastPort,197, 44,"L         S         T   R  R  O   O N  NN",8);
        Print(sRastPort,197, 52,"LLLLL SSSSS         T   R   R  OOO  N   N",8);

        Print(sRastPort,293, 68,"Version 3",8);

        IF Sprache=Deutsch THEN Print(sRastPort,150,120,"Programm:",8)
                           ELSE Print(sRastPort,150,120,"Program:" ,8);
        Print(sRastPort,160,136,"Dennis Müller",8);

        IF Sprache=Deutsch THEN
           Print(sRastPort,150,170,"Dankeschöns gehen an:",8)
          ELSE
           Print(sRastPort,150,170,"Thanx 2:"             ,8);

        Print(sRastPort,160,186,"Andreas 'Wurzelsepp' Neumann",8);
        Print(sRastPort,160,194,"'Diesel' Bernd Künnen"       ,8);
        Print(sRastPort,160,202,"Maximilian von Fürstenberg"  ,8);
        Print(sRastPort,160,210,"Jens Meyer"                  ,8);
        Print(sRastPort,160,218,"Thomas Müller"               ,8);
      END;

    BEGIN
      sNewWindow.screen:=MyScreen; { Fenster öffnen }
      sWindow:=NIL;
      sWindow:=OpenWindow(ADR(sNewWindow));
      IF sWindow=NIL THEN CleanExit(Error_No_Window);

      ViewMouse(sWindow);          { Mauszeiger einstellen }
      sRastPort:=sWindow^.RPort;

      SetAPen(sRastPort,1);
      Line(sRastPort,0,0,639,0);
      DrawIBox(sRastPort,0,1,639,245);
      DrawIBox(sRastPort,1,1,638,245);
      Draw0Box(sRastPort,2,2,637,244);
      Draw0Box(sRastPort,3,3,636,243);

      Page1;
      WaitClick;

      ClearPointer(SWindow);
      MyCloseWindow(sWindow);          { Und Ende }
      ActivateWindow(myWindow);
    END;

  PROCEDURE SetLoadedPlayers;

    VAR shorthelp : BYTE;

    BEGIN
      WITH TBase^.MyMaze DO
        FOR ShortHelp:=1 TO Maxplay DO
          IF players[shorthelp].ist_geladen THEN
             BEGIN
               TBase^.players[shorthelp].x :=players[shorthelp].pos.x;
               TBase^.players[shorthelp].y :=players[shorthelp].pos.y;
               TBase^.players[shorthelp].mx:=players[shorthelp].bewegung.x;
               TBase^.players[shorthelp].my:=players[shorthelp].bewegung.y;
             END;
    END;

  PROCEDURE Init_Base; { Tronbase einstellen }

    VAR ShortHelp : BYTE;

    BEGIN
      WITH TBase^ DO
        BEGIN
          QuitGame:=FALSE;  { Spiel erstmal nicht beenden               }

          remain:=player;   { Folgen des letzten Spiels beseitigen und  }
                            { Optionen beachten.                        }

          first:=0;
          secnd:=0;         { Sieger erstmal löschen => Gleichberechtigung }
          third:=0;

          FOR Shorthelp:=1 TO Maxplay DO      { Alle Spieler durchgehen }
              BEGIN
                WITH players[shorthelp] DO
                  BEGIN
                    destroyed:=FALSE;         { Ohne Spiel keiner zerstört }
                    lastleft:=FALSE;          { etc.                       }
                    lastright:=FALSE;

                    FOR pos:=1 TO max_Length DO { Werte für Spurverfolgung }
                      WITH strich[pos] DO       { zurückstellen            }
                        BEGIN
                          x:=0;
                          y:=0;
                        END;
                    pos:=1;                     {}
                    ok:=(shorthelp<=Player);    { Spieler, die mitspielen, }
                                                { sind in Ordnung          }
                    complayer:=(Shorthelp>human);{Eventuell Computerspieler}

                    hits:=0;                     { Treffer löschen         }
                    left:=RangeRandom(1);        { Nur für Computerspieler }
                    Turbo:=(RangeRandom(5)=0);   {          "              }
                    KI:=RangeRandom(3);          {          "              }
                    Ausweicher:=RangeRandom(5)>0;{          "              }
                    ID:=ShortHelp;               { Spieler Identifier      }
                  END;
              END;

          FOR Shorthelp:=1 TO (maxPlay DIV 2) DO { 2. Durchlauf }
              BEGIN
                WITH Players[2*ShortHelp-1] DO
                  BEGIN
                    x:=101+shorthelp;            { Startposition festlegen }
                    y:=shortHelp*15+94;
                    mx:=1;                       { Startrichtung einstellen}
                    my:=0;
                  END;

                WITH Players[2*ShortHelp] DO     { Und die restlichen Spieler }
                  BEGIN
                    x:=201+shorthelp;            { Starten weiter rechts }
                    y:=shortHelp*15+95;
                    mx:=-1;                      { und in die andere Richtung}
                    my:=0;
                  END;
              END;
        END;
    END;

  FUNCTION ReactMSG(MyMSG : IntuiMessagePtr) : BOOLEAN;

    { Immernoch der User }

    PROCEDURE Neu; { Highscoreliste löschen }

      VAR help : BYTE;

      BEGIN
        FOR help:=1 TO maxplay DO TBase^.players[help].score:=0;
      END;

    PROCEDURE Options; { Optionenmenü }

      CONST aNewWindow : NewWindow = (0,10,640,246,0,0,RawKey_F+Gadgetup_f+
                                      GadgetDown_F,SMART_Refresh+ACTIVATE+
                                      RMBTrap+Borderless,NIL,NIL,NIL,NIL,
                                      NIL,640,246,640,246,CUSTOMSCREEN_F);

            OptGad01    : Gadget    = (NIL,180, 18,151, 11,GadghImage,
                                       RelVerify,BOOLGADGET,NIL,NIL,NIL,
                                       0,NIL, 1,NIL);
            OptGad02    : Gadget    = (NIL,180, 43,151, 11,GadghImage,
                                       RelVerify,BOOLGADGET,NIL,NIL,NIL,
                                       0,NIL, 2,NIL);
            OptGad03    : Gadget    = (NIL,180, 68,151, 11,GadghImage,
                                       RelVerify,BOOLGADGET,NIL,NIL,NIL,
                                       0,NIL, 3,NIL);
            OptGad04    : Gadget    = (NIL,180, 93,151, 11,GadghImage,
                                       RelVerify,BOOLGADGET,NIL,NIL,NIL,
                                       0,NIL, 4,NIL);
            OptGad05    : Gadget    = (NIL,180,118,151, 11,GadghImage,
                                       RelVerify,BOOLGADGET,NIL,NIL,NIL,
                                       0,NIL, 5,NIL);
            OptGad06    : Gadget    = (NIL,180,143,151, 11,GadghImage,
                                       RelVerify,BOOLGADGET,NIL,NIL,NIL,
                                       0,NIL, 6,NIL);
            OptGad07    : Gadget    = (NIL,180,168,151, 11,GadghImage,
                                       RelVerify,BOOLGADGET,NIL,NIL,NIL,
                                       0,NIL, 7,NIL);
            OptGad10    : Gadget    = (NIL,180,198,151, 11,GadghImage,
                                       RelVerify,BOOLGADGET,NIL,NIL,NIL,
                                       0,NIL,10,NIL);

            OptKoord1   : Koord     = ( 0,11,  0, 0,151, 0);
            OptKoord2   : Koord     = ( 0,11,151,11,151, 0);
            OptKoord3   : Koord     = ( 0,11,  0, 0,151, 0);
            OptKoord4   : Koord     = ( 0,11,151,11,151, 0);

            OptBora2    : Border    = (0,0,1,8,5,3,NIL,NIL);
            OptBora1    : Border    = (0,0,8,1,5,3,NIL,NIL);
            OptBorb2    : Border    = (0,0,8,1,5,3,NIL,NIL);
            OptBorb1    : Border    = (0,0,1,8,5,3,NIL,NIL);

      VAR aWindow    : WindowPtr;        { Systemkram... }
          aRastPort  : RastPortPtr;
          aIntMSG    : IntuiMessagePtr;
          MyEnd      : BOOLEAN;          { Ende???       }
          old_human,
          old_Level,
          old_speed,
          old_player,
          old_length : SHORT;            { Für Überprüfung von Änderungen }
          MyString   : STRING;           { Für diverses... }

      PROCEDURE KillBox(PosX,PosY : SHORT); { Box vom Bildschirm löschen }

        CONST x0    = 376;
              y0    =  19;
              seite =   8;

        VAR MyX,MyY : SHORT;

        BEGIN
          CASE PosY OF
            1 : MyY:=y0+  0;
            2 : MyY:=y0+ 25;
            3 : MyY:=y0+ 50;
            4 : MyY:=y0+ 75;
            5 : MyY:=y0+100;
            6 : MyY:=y0+125;
            7 : MyY:=y0+150;
          END;

          myX:=x0+2*Seite*(PosX-1);

          SetAPen(aRastPort,0);
          RectFill(aRastport,MyX,MyY,MyX+2*seite-1,MyY+Seite-1);
        END;

      PROCEDURE NormalBox(x,y : SHORT); { Kasten malen }

        CONST x0    = 376;
              y0    =  19;
              seite =   8;

        VAR MyX,MyY : SHORT;

        BEGIN
          CASE y OF
            1 : MyY:=y0+  0;
            2 : MyY:=y0+ 25;
            3 : MyY:=y0+ 50;
            4 : MyY:=y0+ 75;
            5 : MyY:=y0+100;
            6 : MyY:=y0+125;
            7 : MyY:=y0+150;
          END;

          myX:=x0+2*Seite*(x-1);

          SetAPen(aRastPort,schwarz);
          Line(aRastPort,MyX          ,MyY+seite-1,
                         MyX+2*seite-1,MyY+seite-1);
          Draw(aRastPort,MyX+2*seite-1,MyY        );
          Line(aRastPort,MyX+2*seite-2,MyY+seite-1,
                         MyX+2*seite-2,MyY        );

          SetAPen(aRastPort,mgrau);
          Line(aRastPort,MyX          ,MyY+seite-1,
                         MyX          ,MyY        );
          Draw(aRastPort,MyX+2*seite-2,MyY        );
          Line(aRastPort,MyX        +1,MyY+seite-2,
                         MyX        +1,MyY        );
        END;

      PROCEDURE EmptyBox(x,y : SHORT); { Leeren Kasten malen }

        CONST x0    = 376;
              y0    =  19;
              seite =   8;

        VAR MyX,MyY : SHORT;

        BEGIN
          NormalBox(x,y);

          CASE y OF
            1 : MyY:=y0+  0;
            2 : MyY:=y0+ 25;
            3 : MyY:=y0+ 50;
            4 : MyY:=y0+ 75;
            5 : MyY:=y0+100;
            6 : MyY:=y0+125;
            7 : MyY:=y0+150;
          END;

          myX:=x0+2*Seite*(x-1);

          SetAPen(aRastPort,0);
          RectFill(aRastport,MyX+2,MyY+1,MyX+2*seite-3,MyY+Seite-2);
        END;

      PROCEDURE FullBox(x,y : SHORT); { Blauen Kasten malen }

        CONST x0    = 376;
              y0    =  19;
              seite =   8;

        VAR MyX,MyY : SHORT;

        BEGIN
          NormalBox(x,y);

          CASE y OF
            1 : MyY:=y0+  0;
            2 : MyY:=y0+ 25;
            3 : MyY:=y0+ 50;
            4 : MyY:=y0+ 75;
            5 : MyY:=y0+100;
            6 : MyY:=y0+125;
            7 : MyY:=y0+150;
          END;

          myX:=x0+2*Seite*(x-1);

          SetAPen(aRastPort,5);
          RectFill(aRastport,MyX+2,MyY+1,MyX+2*seite-3,MyY+Seite-2);
        END;

      PROCEDURE WriteLevel;              { Level ausgeben }

        VAR x : SHORT;

        BEGIN
          FOR x:=0 TO TBase^.Level DO
            FullBox(x+1,1);

          FOR x:=Tbase^.Level+1 TO suicide DO
            EmptyBox(x+1,1);
        END;

      PROCEDURE WriteSpeed;              { Geschwindigkeit ausgeben }

        VAR x : SHORT;

        BEGIN
          FOR x:=0 TO TBase^.speed DO
            FullBox(x+1,2);

          FOR x:=Tbase^.speed+1 TO Turbo DO
            EmptyBox(x+1,2);
        END;

      PROCEDURE WritePlayer;             { Spieleranzahl ausgeben }

        VAR x : SHORT;

        BEGIN
          FOR x:=1 TO TBase^.player DO
            FullBox(x,3);

          FOR x:=Tbase^.player+1 TO Maxplay DO
            EmptyBox(x,3);
        END;

      PROCEDURE WriteHuman;              { Anzahl der menschlichen S. ausg.}

        VAR x : SHORT;

        BEGIN
          FOR x:=1 TO TBase^.human DO
            FullBox(x,4);

          FOR x:=Tbase^.human+1 TO maxplay DO
            EmptyBox(x,4);
        END;

      PROCEDURE WriteColour;             { Hintergrundfarbe ändern }

        BEGIN
          WITH TBase^ DO
            BEGIN
              SetRGB4(ADR(MyScreen^.SViewPort),9,
                      BackColours[BackColour].r,
                      BackColours[BackColour].g,
                      BackColours[BackColour].b);
            END;
        END;

      PROCEDURE WriteLength;             { Strichlänge ausgeben }

        VAR x : SHORT;

        BEGIN
          IF TBase^.Max_Length>0 THEN
             BEGIN
               FOR x:=1 TO TBase^.Max_Length DIV 50 DO
                 FullBox(x,6);

               FOR x:=(TBase^.Max_Length DIV 50)+1 TO 10 DO
                 EmptyBox(x,6);
             END
            ELSE
             BEGIN
               FOR x:=1 TO 10 DO
                 Killbox(x,6);
               IF Sprache=Deutsch THEN Print(aRastPort,377,151,"Aus",1)
                                  ELSE Print(aRastPort,377,151,"Off",1);
             END;
        END;

      PROCEDURE WriteLanguage;

        BEGIN
          SetAPen(aRastPort,0);
          RectFill(aRastPort,370,170,470,177);
          IF Sprache=Deutsch THEN Print(aRastPort,376,176,"Deutsch",1)
                             ELSE Print(aRastPort,376,176,"English",1);
        END;

      PROCEDURE Draw_Menu;

        BEGIN
          IF Sprache=Deutsch THEN
             BEGIN
               Print(aRastPort,241, 26,     "Level"     ,1);{ Optionenmenü }
               Print(aRastPort,211, 51,"Geschwindigkeit",1);{ vorbereiten  }
               Print(aRastPort,235, 76,    "Spieler"    ,1);
               Print(aRastPort,226,101,   "Mitspieler"  ,1);
               Print(aRastPort,235,126,    " Farbe "    ,1);
               Print(aRastPort,214,151,"Spurverfolgung" ,1);
               Print(aRastPort,229,176,    " Sprache "  ,1);
               Print(aRastPort,244,206,      "Ende"     ,8);
             END
            ELSE
             BEGIN
               Print(aRastPort,241, 26,     "Level"     ,1);
               Print(aRastPort,211, 51,"     Speed     ",1);
               Print(aRastPort,235, 76,    "Players"    ,1);
               Print(aRastPort,223,101,  "   Human   "  ,1);
               Print(aRastPort,238,126,    "Colour"     ,1);
               Print(aRastPort,214,151," Tracktracing " ,1);
               Print(aRastPort,232,176,    "Language"   ,1);
               Print(aRastPort,244,206,     "Quit"      ,8);
             END;

          WriteLevel;                      { Optionen ausgeben }
          WriteSpeed;
          WritePlayer;
          WriteHuman;

          SetAPen(aRastPort,9);
          RectFill(aRastPort,376,118,535,128);

          WriteColour;
          WriteLength;
          WriteLanguage;
        END;

      FUNCTION CalcMSG(sMSG : IntuiMessagePtr) : BOOLEAN;

        {und noch mal User}

        VAR myHelp : SHORT;
            MyKey  : SHORT;

        BEGIN
          IF (sMSG^.Class=RawKey_F    ) OR
             (sMSG^.Class=GadgetUp_F  ) OR
             (sMSG^.Class=GadgetDown_F) THEN
             BEGIN
               IF sMSG^.Class=RawKey_F THEN
                  BEGIN
                    MyKey:=sMSG^.Code;

                    CASE MyKey OF
                      F1 : SelectGadget(aRastPort,ADR(OptGad01));
                      F2 : SelectGadget(aRastPort,ADR(OptGad02));
                      F3 : SelectGadget(aRastPort,ADR(OptGad03));
                      F4 : SelectGadget(aRastPort,ADR(OptGad04));
                      F5 : SelectGadget(aRastPort,ADR(OptGad05));
                      F6 : SelectGadget(aRastPort,ADR(OptGad06));
                      F7 : SelectGadget(aRastPort,ADR(OptGad07));
                      F10: SelectGadget(aRastPort,ADR(OptGad10));
                     ELSE;
                    END;
                  END
                 ELSE MyKey:=F1+GetGadgetID(sMsg^.IAddress)-1;
                        { Gadgetnummern in Tastaturcodes umwandeln }

               CASE MyKey OF
                $50 : BEGIN { F1 gedrückt? - Level erhöhen }
                        TBase^.Level:=(TBase^.Level+1) MOD 6;
                        WriteLevel;
                        CalcMSG:=FALSE;
                      END;
                $51 : BEGIN { F2 gedrückt? - Geschwindigkeit erhöhen }
                        TBase^.Speed:=(TBase^.Speed+1) MOD 6;
                        WriteSpeed;
                        CalcMSG:=FALSE;
                      END;
                $52 : BEGIN { F3 gedrückt - Anzahl der Spieler erhöhen }
                        TBase^.player:=TBase^.player+1;
                        IF TBase^.player>maxplay THEN TBase^.player:=TBase^.human;
                        IF TBase^.player<2 THEN TBase^.player:=2;
                        TBase^.remain:=TBase^.player;
                        FOR MyHelp:=1 TO maxplay DO
                            TBase^.players[myHelp].ok:=(MyHelp<=TBase^.player);

                        WritePlayer;

                        CalcMSG:=FALSE;
                      END;
                $53 : BEGIN { F4 - Anzahl der (über-)menschlichen Spieler }
                        TBase^.human:=TBase^.human+1;
                        IF TBase^.human>TBase^.player THEN TBase^.human:=0;
                        FOR MyHelp:=1 TO maxplay DO
                          TBase^.players[myhelp].complayer:=(MyHelp>TBase^.Human);

                        WriteHuman;

                        CalcMSG:=FALSE;
                      END;
                $54 : BEGIN { F5 - Farben verändern }
                        WITH TBase^ DO
                          BEGIN
                            backColour:=(Backcolour MOD 4)+1;

                            WriteColour;
                          END;
                        CalcMSG:=FALSE;
                      END;
                $55 : BEGIN { F6 - Strichlänge verändern }
                        TBase^.max_Length:=TBase^.max_Length+50;
                        IF TBase^.max_Length>maximum THEN TBase^.max_Length:=0;

                        WriteLength;

                        CalcMSG:=FALSE;
                      END;
                $56 : BEGIN
                        IF Sprache=Deutsch THEN TBase^.Sprache:=CHR(69)
                                           ELSE TBase^.Sprache:=CHR(68);
                        Draw_Menu;
                        Sprache_Hauptmenue;

                        CalcMSG:=FALSE;
                      END;
                $59 : CalcMSG:=TRUE; { F10 und raus }
                ELSE CalcMSG:=FALSE;
               END; { Ende von Case }
             END;
        END; { Ende der Prozedur }

      PROCEDURE OpenOptionsDisplay;

        BEGIN
          OptBora2.xy:=ADR(OptKoord2);
          OptBora1.xy:=ADR(OptKoord1);
          OptBora1.NextBorder:=ADR(OptBora2);

          OptBorb2.xy:=ADR(OptKoord4);
          OptBorb1.xy:=ADR(OptKoord3);
          OptBorb1.NextBorder:=ADR(OptBorb2);

          SetGadget(ADR(OptGad10),NIL          ,ADR(OptBora1),ADR(OptBorb1),NIL);
          SetGadget(ADR(OptGad07),ADR(OptGad10),ADR(OptBora1),ADR(OptBorb1),NIL);
          SetGadget(ADR(OptGad06),ADR(OptGad07),ADR(OptBora1),ADR(OptBorb1),NIL);
          SetGadget(ADR(OptGad05),ADR(OptGad06),ADR(OptBora1),ADR(OptBorb1),NIL);
          SetGadget(ADR(OptGad04),ADR(OptGad05),ADR(OptBora1),ADR(OptBorb1),NIL);
          SetGadget(ADR(OptGad03),ADR(OptGad04),ADR(OptBora1),ADR(OptBorb1),NIL);
          SetGadget(ADR(OptGad02),ADR(OptGad03),ADR(OptBora1),ADR(OptBorb1),NIL);
          SetGadget(ADR(OptGad01),ADR(OptGad02),ADR(OptBora1),ADR(OptBorb1),NIL);

          aNewWindow.firstGadget:=ADR(OptGad01);
          aNewWindow.screen:=MyScreen;     { Fenster öffnen }
          aWindow:=NIL;
          aWindow:=OpenWindow(ADR(ANewWindow));
          IF aWindow=NIL THEN CleanExit(Error_No_Window);
          aRastPort:=aWindow^.RPort;

          ViewMouse(aWindow);               { Mauszeiger einstellen }

          SetAPen(aRastPort,1);
          Line(aRastPort,0,0,639,0);
          DrawIBox(aRastPort,0,1,639,245);
          DrawIBox(aRastPort,1,1,638,245);
          Draw0Box(aRastPort,2,2,637,244);
          Draw0Box(aRastPort,3,3,636,243);
        END;

      BEGIN { Öffnen }
        myString:=AllocString(255);

        old_human :=TBase^.human;        { Alte Einstellungen merken }
        old_player:=TBase^.player;
        old_Level :=TBase^.level;
        old_Speed :=TBase^.Speed;
        old_Length:=TBase^.Max_Length;

        OpenOptionsDisplay;
        Draw_Menu;

        REPEAT
          aIntMSG:=NIL; { User will was ? }
          aIntMSG:=ADDRESS(WaitPort(aWindow^.UserPort));
          aIntMSG:=ADDRESS(GetMSG(aWindow^.USERPort));
          IF aIntMSG<>NIL THEN BEGIN
                                 MyEnd:=CalcMSG(aIntMSG); { MSG bearbeiten }
                                 ReplyMSG(ADDRESS(aIntMSG));
                               END;
        UNTIL MyEnd;

        REPEAT
          aIntMSG:=NIL; { User will noch was ? Zu spät. }
          aIntMSG:=ADDRESS(GetMSG(aWindow^.USERPort));
          IF aIntMSG<>NIL THEN BEGIN
                                 ReplyMSG(ADDRESS(aIntMSG));
                               END;
        UNTIL aIntMSG=NIL;

        IF NOT ((old_human =TBase^.human     )  AND
                (old_player=TBase^.player    )  AND
                (old_Level =TBase^.level     )  AND
                (old_Speed =TBase^.Speed     )  AND
                (old_Length=TBase^.Max_Length)) THEN Neu; { Wenn etwas     }
                                                          { geändert wurde,}
                                                          { Highscore      }
                                                          { löschen.       }

        ClearPointer(AWindow);
        MyCloseWindow(aWindow); { Fenster schließen und umschalten }
        ActivateWindow(MyWindow);

        FreeString(MyString);
      END;

    PROCEDURE HighScore; { highscoreliste zeigen }

      CONST HighGad    : Gadget    = (NIL,267,190,101,11,GadghImage,
                                      RelVerify,BOOLGADGET,NIL,NIL,NIL,
                                      0,NIL, 1,NIL);
            OkGad      : Gadget    = (NIL,267,210,101,11,GadghImage,
                                      RelVerify,BOOLGADGET,NIL,NIL,NIL,
                                      0,NIL,10,NIL);

            HighInt    : IntuiText = (1,0,0,41,1,NIL,"Neu",NIL);
            eHighInt   : IntuiText = (1,0,0,41,1,NIL,"New",NIL);
            OkInt      : IntuiText = (8,0,0,44,1,NIL,"Ok" ,NIL);

            sNewWindow : NewWindow = (0,10,640,246,0,0,MouseButtons_f+
                                      GadgetDown_f+GadgetUp_f+RawKey_F,
                                      SMART_Refresh+ACTIVATE+RMBTrap+
                                      Borderless,NIL,NIL,NIL,NIL,NIL,
                                      640,246,640,246,CUSTOMSCREEN_F);

      VAR sWindow   : WindowPtr;
          sRastPort : RastPortPtr;
          sMSG      : IntuiMessagePtr;

      PROCEDURE Draw_Highscore;

        TYPE mitspieler = RECORD
                            punkte,
                            nummer : SHORT;
                          END;
             Table      = ARRAY[1..6] OF mitSpieler;

        PROCEDURE SortScores(VAR myTable : Table);

          PROCEDURE Vertausche(y : SHORT); { Liste sortieren }

            VAR variable : mitSpieler;

            BEGIN
              variable    :=myTable[y];
              mytable[y]  :=mytable[y+1];
              mytable[y+1]:=variable;
            END;

          VAR sortiere : BOOLEAN;
              x        : SHORT;

          BEGIN
            sortiere:=TRUE;
            WHILE sortiere DO { Solange sortieren bis nicht mehr sortiert wird}
              BEGIN
                sortiere:=FALSE;
                FOR x:=1 TO maxplay-1 DO
                  IF mytable[x].punkte<mytable[x+1].punkte THEN
                     BEGIN
                       Vertausche(x);
                       sortiere:=TRUE;
                     END;
              END;
          END;

        VAR highscore : Table;
            help      : SHORT;
            myString  : STRING;
            abstand   : BYTE;

        BEGIN
          FOR help:=1 TO maxplay DO    { Wichtige Daten ermitteln }
            BEGIN
              WITH HighScore[help] DO
                BEGIN
                  nummer:=help;
                  punkte:=TBase^.players[help].score;
                END;
            END;

          SortScores(HighScore);      { Sortieren }

          SetAPen(sRastPort,0);
          RectFill(sRastPort,180,40,630,180);

          abstand:=10*(maxplay-TBase^.player)+46; { Abstand vom oberen Rand }

          myString:=AllocString(20);

          FOR help:=1 TO TBase^.player DO   { Ausgeben }
            BEGIN
              WITH highscore[help] DO
                BEGIN
                  makeString(help,MyString);
                  StrCat(myString,".");
                  Print(sRastPort,188,abstand+20*help,mystring,nummer+1);

                  Print(sRastPort,212,abstand+20*help,TBase^.players[nummer].name,nummer+1);

                  Makestring(punkte,myString);
                  Print(sRastPort,418-LENGTH(MyString),abstand+20*help,MyString,nummer+1);
                 END;
            END;

          FreeString(myString);
        END;

      FUNCTION Reaction(OneMsg : IntuiMessagePtr) : BOOLEAN;

        VAR Beende : BOOLEAN;

        BEGIN
          Beende:=FALSE;
          IF OneMSG<>NIL THEN
             BEGIN
               IF OneMSG^.Class=GadgetUp_F THEN
                  CASE GetGadgetID(OneMSG^.IAddress) OF
                    1 : BEGIN
                          Neu;
                          Draw_Highscore;
                        END;
                   10 : Beende:=TRUE;
                  END;

               IF (OneMSG^.Class=Rawkey_F) THEN
                  CASE OneMSG^.Code OF
                    F1 : BEGIN
                           Neu;
                           Draw_Highscore;
                         END;
                   F10 : Beende:=TRUE;
                   ELSE;
                  END;

               ReplyMSG(ADDRESS(OneMsg));
             END;

          Reaction:=Beende;
        END;

      BEGIN
        SNewWindow.Screen:=MyScreen;

        SetGadget(ADR(OkGad),NIL,ADR(Bora1),ADR(Borb1),ADR(OkInt));
        IF Sprache=Deutsch THEN
           SetGadget(ADR(HighGad),ADR(OkGad),ADR(Bora1),ADR(Borb1),ADR( highInt))
          ELSE
           SetGadget(ADR(HighGad),ADR(OkGad),ADR(Bora1),ADR(Borb1),ADR(ehighInt));

        SNewWindow.firstgadget:=ADR(HighGad);

        sWindow:=NIL;
        sWindow:=OpenWindow(ADR(sNewWindow));
        IF sWindow=NIL THEN CleanExit(Error_No_Window);

        ViewMouse(sWindow);
        sRastPort:=sWindow^.RPort;

        SetAPen(sRastPort,1);
        Line(sRastPort,0,0,639,0);

        DrawIBox(sRastPort,0,1,639,245);
        DrawIBox(sRastPort,1,1,638,245);

        Draw0Box(sRastPort,2,2,637,244);
        Draw0Box(sRastPort,3,3,636,243);

        DrawBox(sRastPort,274,18,358,29);
        Print(sRastPort,289,26,"Highscore",1);

        Draw_Highscore;

        REPEAT
          sMsg:=NIL;
          sMSG:=ADDRESS(WaitPort(sWindow^.UserPort));
          sMSG:=ADDRESS(GetMSG(  sWindow^.UserPort));
        UNTIL Reaction(sMsg);

        ClearPointer(sWindow);
        MyCloseWindow(sWindow);     { und Ende }
        ActivateWindow(myWindow);
      END;

    VAR MyNummer : SHORT;
        MyBool   : BOOLEAN;

    BEGIN { Weiter mit ReactMSG-Main }
      MyBool:=FALSE;
      IF (MyMSG^.Class=Gadgetup_F) OR (MyMSG^.Class=GadgetDown_f) OR
         (MyMSG^.Class=Rawkey_F)   THEN
         BEGIN
           IF MyMSG^.Class=RawKey_F THEN
              BEGIN
                CASE MyMSG^.Code OF
                  $43,
                  $44,
                  F1  : BEGIN
                          MyNummer:=1;
                          SelectGadget(MyRastPort,ADR(Gad01));
                        END;
                  F2  : BEGIN
                          MyNummer:=2;
                          SelectGadget(MyRastPort,ADR(Gad02));
                        END;
                  F3  : BEGIN
                          MyNummer:=3;
                          SelectGadget(MyRastPort,ADR(Gad03));
                        END;
                  F4  : BEGIN
                          MyNummer:=4;
                          SelectGadget(MyRastPort,ADR(Gad04));
                        END;
                  F5  : BEGIN
                          MyNummer:=5;
                          SelectGadget(MyRastPort,ADR(Gad05));
                        END;
                  F10 : BEGIN
                          MyNummer:=10;
                          SelectGadget(MyRastPort,ADR(Gad10));
                        END;
                  $21 : BEGIN
                          IF MyModule<>NIL THEN
                             BEGIN
                               IF TBase^.Sound THEN BEGIN
                                                      StopPlayer;
                                                      TBase^.sound:=FALSE;
                                                    END
                                               ELSE BEGIN
                                                      PlayModule(MyModule);
                                                      TBase^.sound:=TRUE;
                                                    END;
                             END;
                        END;
                 ELSE;
                END;
              END
             ELSE MyNummer:=GetGadgetID(MyMSG^.IAddress);

           CASE MyNummer OF
            1 : BEGIN
                  Ende:=FALSE;    { Gadget 1 = Start }
                  MyBool:=TRUE;
                END;
            2 : Info;           { Gadget 2 }
            3 : HighScore;      { ... }
            4 : Options;
            5 : Extra;
           10 : BEGIN
                  SetColours(FALSE);
                  IF sprache=Deutsch THEN Ende:=Ask("Wirklich beenden???")   { Requester aufrufen }
                                     ELSE Ende:=AskEnglish("Really quit???");

                  ResetColours(FALSE);
                  MyBool:=Ende;
                END;
           END;
         END;

      ReactMSG:=MyBool;
    END;

  VAR Start    : BOOLEAN;
      MyIntMSG : IntuiMessagePtr;

  BEGIN { Init-Main }
    Init_Base;

    Activatewindow(MyWindow);

    Ende:=FALSE;
    REPEAT
      KillMSGs(MyWindow^.UserPort);

      MyIntMSG:=ADDRESS(WaitPort(MyWindow^.UserPort));
      MyIntMSG:=ADDRESS(GetMSG(MyWindow^.UserPort));
      IF MyIntMSG<>NIL THEN BEGIN
                              Start:=ReactMSG(MyIntMSG);
                              ReplyMSG(ADDRESS(MyIntMSG));
                            END;
    UNTIL Start;

    DelMouse(MyWindow);

    IF TBase^.Use_Maze THEN SetLoadedPlayers;
  END;

{ Init Ende }

PROCEDURE Init1st; { Erstes Init - nur bei Neustart }

  VAR ShortHelp : SHORT;

  PROCEDURE Init_Control;

    { Spieler 1 und 2 brauchen keine Tasten, da Joysticks, werden hier aber}
    {  trotzdem gesetzt...                                                 }

    PROCEDURE SetControl(aControl : ControlPtr;a,b,c : SHORT);

      BEGIN
        WITH aControl^ DO
          BEGIN
            links:=a;
            rechts:=b;
            vorne:=c;
          END;
      END;

    BEGIN
      WITH TBase^ DO
        BEGIN
          players[1].Steuerung:=Joy1;
          players[2].Steuerung:=Joy2;
          players[3].Steuerung:=Tasten;
          players[4].Steuerung:=Tasten;
          players[5].Steuerung:=Tasten;
          players[6].Steuerung:=Tasten;

          SetControl(ADR(players[1].plcontrol), 50, 52,179);{ xvc          }
          SetControl(ADR(players[2].plcontrol), 54, 56,183);{ n,m          }

          SetControl(ADR(players[3].plcontrol), 79, 78,204);{ Cursortasten }
          SetControl(ADR(players[4].plcontrol),100,102, 96);{ links Alt,Shift,C=}
          SetControl(ADR(players[5].plcontrol),103,101, 97);{ rechts Alt,Shift,Amiga }
          SetControl(ADR(players[6].plControl), 67, 74,222);{ Enter,-,+    }
        END;
    END;

  PROCEDURE Init_Maze;

    VAR x : BYTE;

    BEGIN
      WITH TBase^ DO
        BEGIN
          Maze_loaded:=FALSE;
          Use_Maze:=FALSE;
          WITH MyMaze DO
            BEGIN
              StrCat(MyMaze.MazeDir,"Mazes");
              StrCpy(MyMaze.MazeName,"");
              FOR x:=1 TO maxplay DO
                players[x].ist_geladen:=FALSE;
              Loeschen:=TRUE;
            END;
        END;
    END;

  BEGIN
    Selfseed;

    With TBase^ DO
      BEGIN
        FOR ShortHelp:=1 TO MaxPlay DO { Grundeinstellungen             }
          BEGIN                        { Eigenschaften wurden schon bei }
            WITH players[shorthelp] DO { Typendefinition erwähnt...     }
              BEGIN
                ok:=TRUE;
                Complayer:=(ShortHelp>human);
                score:=0;
              END;
          END;
      END;
    Init_Control;
    Init_Maze;
    ScreenToFront(MyScreen);

    SetSColours;
    ViewMouse(MyWindow);

    Init;
  END;
