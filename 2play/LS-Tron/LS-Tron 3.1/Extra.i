{ Extra.i }

{$I "Control.i" }

PROCEDURE SetColours(all : BOOLEAN);   { Farben für Requester ändern }

  BEGIN
    SetRGB4(ADDRESS(MyScreen^.SViewPort),2,$0,$0,$0);
    IF all THEN SetRGB4(ADDRESS(MyScreen^.SViewPort),3,$0,$0,$F);
  END;

PROCEDURE ResetColours(all : BOOLEAN); { Farben zurücksetzen     }

  BEGIN
    WITH NormColours[2] DO
      SetRGB4(ADDRESS(MyScreen^.SViewPort),2,r,g,b);
    IF all THEN
       WITH NormColours[3] DO
         SetRGB4(ADDRESS(MyScreen^.SViewPort),3,r,g,b);
  END;

PROCEDURE Extra;

  VAR sWindow   : WindowPtr;
      sRastPort : RastPortPtr;

  CONST ExInt1 : IntuiText = (1,0,0,35,1,NIL,"Namen"       ,NIL);
        ExInt2 : IntuiText = (1,0,0,23,1,NIL,"Steuerung"   ,NIL);
        ExInt3 : IntuiText = (1,0,0,23,1,NIL,"Lade Maze"   ,NIL);
        ExInt4 : IntuiText = (1,0,0,17,1,NIL,"Maze an/aus" ,NIL);
        ExInt5 : IntuiText = (1,0,0,14,1,NIL,"Sound an/aus",NIL);
        ExInt6 : IntuiText = (1,0,0,23,1,NIL,"Speichern"   ,NIL);
        ExInt7 : IntuiText = (8,0,0,37,1,NIL,"Ende"        ,NIL);

        EInt1  : IntuiText = (1,0,0,35,1,NIL,"Names"       ,NIL);
        EInt2  : IntuiText = (1,0,0,26,1,NIL,"Steering"    ,NIL);
        EInt3  : IntuiText = (1,0,0,23,1,NIL,"Load Maze"   ,NIL);
        EInt4  : IntuiText = (1,0,0,17,1,NIL,"Maze on/off" ,NIL);
        EInt5  : IntuiText = (1,0,0,14,1,NIL,"Sound on/off",NIL);
        EInt6  : IntuiText = (1,0,0,14,1,NIL,"Save options",NIL);
        EInt7  : IntuiText = (8,0,0,37,1,NIL,"Quit"        ,NIL);

        EGad7  : Gadget = (NIL,250,200,101,11,GadghImage,RelVerify,
                           BOOLGADGET,NIL,NIL,NIL,0,NIL,7,NIL);
        EGad6  : Gadget = (NIL,250,175,101,11,GadghImage,RelVerify,
                           BOOLGADGET,NIL,NIL,NIL,0,NIL,6,NIL);
        EGad5  : Gadget = (NIL,250,150,101,11,GadghImage+Selected,
                           RelVerify+Toggleselect,
                           BOOLGADGET,NIL,NIL,NIL,0,NIL,5,NIL);
        EGad4  : Gadget = (NIL,250,125,101,11,GadghImage+Selected,
                           RelVerify+Toggleselect,
                           BOOLGADGET,NIL,NIL,NIL,0,NIL,4,NIL);
        EGad3  : Gadget = (NIL,250,100,101,11,GadghImage,RelVerify,
                           BOOLGADGET,NIL,NIL,NIL,0,NIL,3,NIL);
        EGad2  : Gadget = (NIL,250, 75,101,11,GadghImage,RelVerify,
                           BOOLGADGET,NIL,NIL,NIL,0,NIL,2,NIL);
        EGad1  : Gadget = (NIL,250, 50,101,11,GadghImage,RelVerify,
                           BOOLGADGET,NIL,NIL,NIL,0,NIL,1,NIL);

  PROCEDURE Edit_Names; { Namen eingeben }

    { Es werden 6 Stringgadgets benötigt... }

    CONST MyGad1     : Gadget    = (NIL,306, 60,116,11,GadghNONE,
                                    RelVerify+GadGimmediate,StrGADGET,
                                    NIL,NIL,NIL,0,NIL,1,NIL);
          MyGad2     : Gadget    = (NIL,306, 80,116,11,GadghNONE,
                                    RelVerify+GadGimmediate,StrGADGET,
                                    NIL,NIL,NIL,0,NIL,2,NIL);
          MyGad3     : Gadget    = (NIL,306,100,116,11,GadghNONE,
                                    RelVerify+GadGimmediate,StrGADGET,
                                    NIL,NIL,NIL,0,NIL,3,NIL);
          MyGad4     : Gadget    = (NIL,306,120,116,11,GadghNone,
                                    RelVerify+GadGimmediate,StrGADGET,
                                    NIL,NIL,NIL,0,NIL,4,NIL);
          MyGad5     : Gadget    = (NIL,306,140,116,11,GadghNone,
                                    RelVerify+GadGimmediate,StrGADGET,
                                    NIL,NIL,NIL,0,NIL,5,NIL);
          MyGad6     : Gadget    = (NIL,306,160,116,11,GadghNone,
                                    RelVerify+GadGimmediate,StrGADGET,
                                    NIL,NIL,NIL,0,NIL,6,NIL);
          OkGad      : Gadget    = (NIL,267,200,101,11,GadghImage,
                                    RelVerify,BOOLGADGET,NIL,NIL,NIL,
                                    0,NIL,10,NIL);

          MyInt1    : IntuiText = (2,0,0,-72,1,NIL,"Spieler 1:",NIL);
          MyInt2    : IntuiText = (3,0,0,-72,1,NIL,"Spieler 2:",NIL);
          MyInt3    : IntuiText = (4,0,0,-72,1,NIL,"Spieler 3:",NIL);
          MyInt4    : IntuiText = (5,0,0,-72,1,NIL,"Spieler 4:",NIL);
          MyInt5    : IntuiText = (6,0,0,-72,1,NIL,"Spieler 5:",NIL);
          MyInt6    : IntuiText = (7,0,0,-72,1,NIL,"Spieler 6:",NIL);

          MyEInt1   : IntuiText = (2,0,0,-66,1,NIL, "Player 1:",NIL);
          MyEInt2   : IntuiText = (3,0,0,-66,1,NIL, "Player 2:",NIL);
          MyEInt3   : IntuiText = (4,0,0,-66,1,NIL, "Player 3:",NIL);
          MyEInt4   : IntuiText = (5,0,0,-66,1,NIL, "Player 4:",NIL);
          MyEInt5   : IntuiText = (6,0,0,-66,1,NIL, "Player 5:",NIL);
          MyEInt6   : IntuiText = (7,0,0,-66,1,NIL, "Player 6:",NIL);

          OkInt     : IntuiText = (8,0,0, 44,1,NIL,"Ok",NIL);

          StrInfo1  : StringInfo = (NIL,NIL,0,19,1,1,0,0,0,0,NIL,0,NIL);
          StrInfo2  : StringInfo = (NIL,NIL,0,19,1,1,0,0,0,0,NIL,0,NIL);
          StrInfo3  : StringInfo = (NIL,NIL,0,19,1,1,0,0,0,0,NIL,0,NIL);
          StrInfo4  : StringInfo = (NIL,NIL,0,19,1,1,0,0,0,0,NIL,0,NIL);
          StrInfo5  : StringInfo = (NIL,NIL,0,19,1,1,0,0,0,0,NIL,0,NIL);
          StrInfo6  : StringInfo = (NIL,NIL,0,19,1,1,0,0,0,0,NIL,0,NIL);

          sNewWindow : NewWindow = (0,10,640,246,0,0,GadgetDown_f+Rawkey_F+
                                    GadgetUp_f,SMART_Refresh+ACTIVATE+
                                    RMBTrap+Borderless,NIL,NIL,NIL,NIL,
                                    NIL,640,246,640,246,CUSTOMSCREEN_F);

    VAR sWindow : WindowPtr;
        IntMsg  : IntuiMessagePtr;
        sRP     : RastPortPtr;
        Code    : INTEGER;
        Dongle  : BOOLEAN;

    BEGIN
      StrInfo1.Buffer:=TBase^.players[1].name;  { Alles einstellen  }
      StrInfo2.Buffer:=TBase^.players[2].name;
      StrInfo3.Buffer:=TBase^.players[3].name;
      StrInfo4.Buffer:=TBase^.players[4].name;
      StrInfo5.Buffer:=TBase^.players[5].name;
      StrInfo6.Buffer:=TBase^.players[6].name;

      SetGadget(ADR(OkGad),NIL,ADR(BorA1),ADR(BorB1),ADR(OkInt));

      IF Sprache=Deutsch THEN
         BEGIN
           MyGad1.GadgetText:=ADR(MyInt1);
           MyGad2.GadgetText:=ADR(MyInt2);
           MyGad3.GadgetText:=ADR(MyInt3);
           MyGad4.GadgetText:=ADR(MyInt4);
           MyGad5.GadgetText:=ADR(MyInt5);
           MyGad6.GadgetText:=ADR(MyInt6);
         END
        ELSE
         BEGIN
           MyGad1.GadgetText:=ADR(MyEInt1);
           MyGad2.GadgetText:=ADR(MyEInt2);
           MyGad3.GadgetText:=ADR(MyEInt3);
           MyGad4.GadgetText:=ADR(MyEInt4);
           MyGad5.GadgetText:=ADR(MyEInt5);
           MyGad6.GadgetText:=ADR(MyEInt6);
         END;

      WITH MyGad6 DO
        BEGIN
          SpecialInfo:=ADR(StrInfo6);
          NextGadget :=ADR(OkGad);
        END;
      WITH MyGad5 DO
        BEGIN
          SpecialInfo:=ADR(StrInfo5);
          NextGadget :=ADR(MyGad6);
        END;
      WITH MyGad4 DO
        BEGIN
          SpecialInfo:=ADR(StrInfo4);
          NextGadget :=ADR(MyGad5);
        END;
      WITH MyGad3 DO
        BEGIN
          SpecialInfo:=ADR(StrInfo3);
          NextGadget :=ADR(MyGad4);
        END;
      WITH MyGad2 DO
        BEGIN
          NextGadget :=ADR(MyGad3);
          SpecialInfo:=ADR(StrInfo2);
        END;
      WITH MyGad1 DO
        BEGIN
          NextGadget :=ADR(MyGad2);
          SpecialInfo:=ADR(StrInfo1);
        END;

      sNewWindow.screen     :=MyScreen;
      sNewWindow.FirstGadget:=ADR(MyGad1);

      sWindow:=NIL;
      sWindow:=OpenWindow(ADR(sNewWindow));  { Endlich das Fenster öffnen}
      IF sWindow<>NIL THEN
         BEGIN
           ViewMouse(sWindow);

           sRP:=sWindow^.RPort;

           SetAPen(sRP,1);
           Line(sRP,0,0,639,0);
           DrawIBox(sRP,0,1,639,245);
           DrawIBox(sRP,1,1,638,245);
           Draw0Box(sRP,2,2,637,244);
           Draw0Box(sRP,3,3,636,243);

           DrawBox(sRP,303, 58,421, 69);
           DrawBox(sRP,303, 78,421, 89);
           DrawBox(sRP,303, 98,421,109);
           DrawBox(sRP,303,118,421,129);
           DrawBox(sRP,303,138,421,149);
           DrawBox(sRP,303,158,421,169);

           IntMsg:=NIL;
           Code:=-1;

           Dongle:=ActivateGadget(ADR(MyGad1),SWindow,NIL);

           REPEAT  { Auf MSGs Warten und entsprechend reagieren }
             IF IntMsg<>NIL THEN ReplyMsg(ADDRESS(IntMsg));
             intMSG:=ADDRESS(WaitPort(sWindow^.UserPort));
             intMsg:=ADDRESS(GetMSG  (sWindow^.UserPort));
             IF (intMSG^.class=Gadgetup_F) OR (intMsg^.class=GadgetDown_F) THEN
                Code:=GetGadgetID(IntMSG^.IADDRESS);
             IF IntMSG^.Class=RawKey_F THEN
                BEGIN
                  Code:=IntMSG^.Code;
                  IF (Code>=F1) AND (code<=F6) THEN Code:=Code-F1
                     ELSE IF Code=F10 THEN BEGIN
                                             code:=10;
                                             SelectGadget(sRP,ADR(OkGad));
                                           END
                                      ELSE code:=$ff;
                END;
             CASE Code OF
               0   : Dongle:=ActivateGadget(ADR(MyGad1),SWindow,NIL);
               1   : Dongle:=ActivateGadget(ADR(MyGad2),SWindow,NIL);
               2   : Dongle:=ActivateGadget(ADR(MyGad3),SWindow,NIL);
               3   : Dongle:=ActivateGadget(ADR(MyGad4),SWindow,NIL);
               4   : Dongle:=ActivateGadget(ADR(MyGad5),SWindow,NIL);
               5   : Dongle:=ActivateGadget(ADR(MyGad6),SWindow,NIL);
              ELSE;
             END;
           UNTIL code=10;
           ReplyMSG(ADDRESS(intMsg));

           ClearPointer(sWindow);

           MyCloseWindow(SWindow);
         END;
    END;

  {$I "Maze.i" }

  PROCEDURE Switch_Sound;

    BEGIN
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

  PROCEDURE Save_Config;

    VAR datei     : TEXT;
        dateiname : STRING;
        fehler,x  : INTEGER;

    BEGIN
      dateiname:=ALLOCSTRING(255);

      Strcpy(Dateiname,TBase^.TronDir);
      StrCat(dateiname,"LS-Tron.config");

      fehler:=0;

     {$I-}
      Rewrite(Datei,Dateiname);
      Fehler:=IOResult;

      WITH TBase^ DO
        BEGIN
          IF Fehler=0 THEN
             BEGIN
               WRITELN(datei,Sprache);
               Fehler:=IOResult;
             END;

          IF fehler=0 THEN
             BEGIN
               WRITELN(datei,max_length);
               Fehler:=IOResult;
             END;

          IF fehler=0 THEN
             BEGIN
               WRITELN(datei,player);
               fehler:=IOResult;
             END;
          IF fehler=0 THEN
             BEGIN
               WRITELN(datei,speed);
               fehler:=IOResult;
             END;
          IF fehler=0 THEN
             BEGIN
               WRITELN(datei,level);
               fehler:=IOResult;
             END;
          IF fehler=0 THEN
             BEGIN
               WRITELN(datei,human);
               fehler:=IOResult;
             END;
          IF fehler=0 THEN
             BEGIN
               WRITELN(datei,backcolour);
               fehler:=IOResult;
             END;
        END;

      IF Fehler=0 THEN
         BEGIN
           FOR x:=0 To 19 DO
             BEGIN
               IF Fehler=0 THEN
                  BEGIN
                    WRITELN(datei,Normcolours[x].r);
                    fehler:=IOResult;
                  END;
               IF Fehler=0 THEN
                  BEGIN
                    WRITELN(datei,Normcolours[x].g);
                    fehler:=IOResult;
                  END;
               IF Fehler=0 THEN
                  BEGIN
                    WRITELN(datei,Normcolours[x].b);
                    fehler:=IOResult;
                  END;
             END;

           FOR x:=1 To 4 DO
             IF Fehler=0 THEN
                BEGIN
                  WRITELN(datei,Backcolours[x].r);
                  fehler:=IOResult;
                  IF Fehler=0 THEN
                     BEGIN
                       WRITELN(datei,Backcolours[x].g);
                       fehler:=IOResult;
                       IF Fehler=0 THEN
                          BEGIN
                            WRITELN(datei,Backcolours[x].b);
                            fehler:=IOResult;
                          END;
                     END;
                END;
         END;

      IF Sprache=Deutsch THEN
         BEGIN
           IF Fehler=0 THEN Show("Konfiguration erfolgreich gespeichert.")
                       ELSE Show("Fehler beim Speichern der Konfigurationsdatei aufgetreten!|Datei konnte nicht gespeichert werden!");
         END
        ELSE
         BEGIN
           IF Fehler=0 THEN Show("Configuration has been succesfully saved.")
                       ELSE Show("Error while saving Configuration! File not saved!");
         END;

      Close(datei);

     {$I+}

      FreeString(dateiname);
    END;

  FUNCTION ReactMsg(MyMsg : IntuiMessagePtr) : BOOLEAN;

    VAR MyNummer : SHORT;
        MyBool   : BOOLEAN;

    BEGIN { Weiter mit ReactMSG-Main }
      MyBool:=FALSE;

      IF (MyMSG^.Class=Gadgetup_F) OR (MyMSG^.Class=GadgetDown_f) OR
         (MyMSG^.Class=Rawkey_F) THEN
         BEGIN
           IF MyMSG^.Class=Rawkey_F THEN
              BEGIN
                CASE MyMSG^.Code OF
                  F1 : BEGIN
                         MyNummer:=1;
                         SelectGadget(sRastPort,ADR(EGad1));
                       END;
                  F2 : BEGIN
                         MyNummer:=2;
                         SelectGadget(sRastPort,ADR(EGad2));
                       END;
                  F3 : BEGIN
                         MyNummer:=3;
                         SelectGadget(sRastPort,ADR(EGad3));
                       END;
                  F4 : IF TBase^.Maze_Loaded THEN
                          BEGIN
                            MyNummer:=4;
                            IF TBase^.Use_Maze THEN
                               BEGIN
                                 EGad4.flags:=(EGad4.flags OR SELECTED)-SELECTED;
                                 DrawBorder(sRastPort,ADR(Bora1),250,125);
                               END
                              ELSE
                               BEGIN
                                 EGad4.flags:=EGad4.flags OR SELECTED;
                                 DrawBorder(sRastPort,ADR(Borb1),250,125);
                               END;
                          END;
                  F5 : IF MyModule<>NIL THEN
                          BEGIN
                            MyNummer:=5;
                            IF TBase^.Sound THEN
                               BEGIN
                                 EGad5.flags:=EGad5.flags AND (NOT SELECTED);
                                 DrawBorder(sRastPort,ADR(Bora1),250,150);
                               END
                              ELSE
                               BEGIN
                                 EGad5.flags:=EGad5.flags OR SELECTED;
                                 DrawBorder(sRastPort,ADR(Borb1),250,150);
                               END;
                          END;
                  F6 : BEGIN
                         MyNummer:=6;
                         SelectGadget(sRastPort,ADR(EGad6));
                       END;
                  F10 : BEGIN
                         MyNummer:=7;
                         SelectGadget(sRastPort,ADR(EGad7));
                       END;
                 ELSE;
                END;
              END
             ELSE MyNummer:=GetGadgetID(MyMSG^.IAddress);

           CASE MyNummer OF
            1 : Edit_Names;
            2 : SetControls;
            3 : Load_Maze;
            4 : BEGIN
                  WITH TBase^ DO
                      IF Maze_Loaded THEN Use_Maze:=NOT Use_Maze
                                     ELSE Use_Maze:=FALSE;
                END;
            5 : Switch_Sound;
            6 : Save_Config;
            7 : MyBool:=TRUE;
           END;
         END;

      ReactMSG:=MyBool;
    END;

  PROCEDURE XOpen;

    CONST sNewWindow : NewWindow = (0,10,640,246,0,0,RawKey_f+GadgetDown_f+
                                    Gadgetup_f,SMART_Refresh+RMBTrap+
                                    BORDERLESS,NIL,NIL,NIL,NIL,NIL,
                                    640,246,640,246,CUSTOMSCREEN_F);

    BEGIN
      IF Sprache=Deutsch THEN
         BEGIN
           SetGadget(ADR(EGad7),NIL       ,ADR(Bora1),ADR(Borb1),ADR(ExInt7));
           SetGadget(ADR(EGad6),ADR(EGad7),ADR(Bora1),ADR(Borb1),ADR(ExInt6));
           SetGadget(ADR(EGad5),ADR(EGad6),ADR(Bora1),ADR(Borb1),ADR(ExInt5));
           SetGadget(ADR(EGad4),ADR(EGad5),ADR(Bora1),ADR(Borb1),ADR(ExInt4));
           SetGadget(ADR(EGad3),ADR(EGad4),ADR(Bora1),ADR(Borb1),ADR(ExInt3));
           SetGadget(ADR(EGad2),ADR(EGad3),ADR(Bora1),ADR(Borb1),ADR(ExInt2));
           SetGadget(ADR(EGad1),ADR(EGad2),ADR(Bora1),ADR(Borb1),ADR(ExInt1));
         END
        ELSE
         BEGIN
           SetGadget(ADR(EGad7),NIL       ,ADR(Bora1),ADR(Borb1),ADR(EInt7));
           SetGadget(ADR(EGad6),ADR(EGad7),ADR(Bora1),ADR(Borb1),ADR(EInt6));
           SetGadget(ADR(EGad5),ADR(EGad6),ADR(Bora1),ADR(Borb1),ADR(EInt5));
           SetGadget(ADR(EGad4),ADR(EGad5),ADR(Bora1),ADR(Borb1),ADR(EInt4));
           SetGadget(ADR(EGad3),ADR(EGad4),ADR(Bora1),ADR(Borb1),ADR(EInt3));
           SetGadget(ADR(EGad2),ADR(EGad3),ADR(Bora1),ADR(Borb1),ADR(EInt2));
           SetGadget(ADR(EGad1),ADR(EGad2),ADR(Bora1),ADR(Borb1),ADR(EInt1));
         END;

      sNewWindow.Screen:=MyScreen;
      sNewWindow.FirstGadget:=ADR(EGad1);

      sWindow:=NIL;
      sWindow:=OpenWindow(ADR(sNewWindow));
      IF sWindow=NIL THEN CleanExit(Error_No_Window);

      ViewMouse(sWindow);

      sRastPort:=ADDRESS(sWindow^.RPort);
    END;

  VAR Beenden  : BOOLEAN;
      sIntMSG  : IntuiMessagePtr;

  BEGIN
    XOpen;

    SetAPen(sRastPort,1);
    Line(sRastPort,0,0,639,0);
    DrawIBox(sRastPort,0,1,639,245);
    DrawIBox(sRastPort,1,1,638,245);
    Draw0Box(sRastPort,2,2,637,244);
    Draw0Box(sRastPort,3,3,636,243);

    beenden:=FALSE;
    REPEAT
      KillMSGs(sWindow^.UserPort);

      ActivateWindow(sWindow);

      IF MyModule=NIL THEN OffGadget(ADR(EGad5),sWindow,NIL)
                      ELSE OnGadget (ADR(EGad5),sWindow,NIL);

      IF TBase^.Maze_Loaded THEN OnGadget (ADR(EGad4),sWindow,NIL)
                            ELSE OffGadget(ADR(EGad4),sWindow,NIL);

      sIntMSG:=ADDRESS(WaitPort(sWindow^.UserPort));
      sIntMSG:=ADDRESS(GetMSG  (sWindow^.UserPort));
      IF sIntMSG<>NIL THEN BEGIN
                             beenden:=ReactMSG(sIntMSG);
                             ReplyMSG(ADDRESS(sIntMSG));
                           END;
    UNTIL beenden;

    ClearPointer(sWindow);
    MyCloseWindow(sWindow);

    ActivateWindow(MyWindow);
  END;
