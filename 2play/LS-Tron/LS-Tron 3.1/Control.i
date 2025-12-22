{ "control.i" }

PROCEDURE SetControls;

  CONST CGad11  : Gadget    = (NIL, 21, 34,169, 62,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,10,NIL);
        CGad12  : Gadget    = (NIL,171, 34,319, 62,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,11,NIL);
        CGad13  : Gadget    = (NIL,321, 34,469, 62,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,12,NIL);
        CGad14  : Gadget    = (NIL,471, 34,619, 62,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,13,NIL);

        CGad21  : Gadget    = (NIL, 21, 64,169, 92,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,20,NIL);
        CGad22  : Gadget    = (NIL,171, 64,319, 92,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,21,NIL);
        CGad23  : Gadget    = (NIL,321, 64,469, 92,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,22,NIL);
        CGad24  : Gadget    = (NIL,471, 64,619, 92,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,23,NIL);

        CGad31  : Gadget    = (NIL, 21, 94,169,122,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,30,NIL);
        CGad32  : Gadget    = (NIL,171, 94,319,122,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,31,NIL);
        CGad33  : Gadget    = (NIL,321, 94,469,122,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,32,NIL);
        CGad34  : Gadget    = (NIL,471, 94,619,122,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,33,NIL);

        CGad41  : Gadget    = (NIL, 21,124,169,152,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,40,NIL);
        CGad42  : Gadget    = (NIL,171,124,319,152,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,41,NIL);
        CGad43  : Gadget    = (NIL,321,124,469,152,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,42,NIL);
        CGad44  : Gadget    = (NIL,471,124,619,152,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,43,NIL);

        CGad51  : Gadget    = (NIL, 21,154,169,182,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,50,NIL);
        CGad52  : Gadget    = (NIL,171,154,319,182,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,51,NIL);
        CGad53  : Gadget    = (NIL,321,154,469,182,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,52,NIL);
        CGad54  : Gadget    = (NIL,471,154,619,182,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,53,NIL);

        CGad61  : Gadget    = (NIL, 21,184,169,212,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,60,NIL);
        CGad62  : Gadget    = (NIL,171,184,319,212,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,61,NIL);
        CGad63  : Gadget    = (NIL,321,184,469,212,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,62,NIL);
        CGad64  : Gadget    = (NIL,471,184,619,212,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,63,NIL);

        QuitGad : Gadget    = (NIL,246,214,394,242,GadghNone,
                               RelVerify,BOOLGADGET,NIL,NIL,NIL,
                               0,NIL,0,NIL);

  VAR cWindow   : WindowPtr;
      cRastPort : RastPortPtr;
      cMSG      : IntuiMessagePtr;
      Joy1Used,
      Joy2Used  : BOOLEAN;

  FUNCTION NotUsed(code : BYTE) : BOOLEAN;

    VAR zaehler : BYTE;
        ergebnis: BOOLEAN;

    BEGIN
      code:=code AND $7f;

      ergebnis:=TRUE;

      IF Code=F10 THEN ergebnis:=FALSE; {  ? F10 ?  }
      IF Code=$45 THEN ergebnis:=FALSE; {  Escape   }
      IF Code=$19 THEN ergebnis:=FALSE; { Taste "P" }

      FOR zaehler:=1 TO maxplay DO
        BEGIN
          WITH TBase^.players[zaehler].plcontrol DO
            BEGIN
              If (links        =code) OR
                 (rechts       =code) OR
                 (vorne AND $7f=code) THEN
                 ergebnis:=FALSE;
            END;
        END;

      NotUsed:=ergebnis;
    END;

  PROCEDURE GetPosition(VAR x,y : SHORT;nummer,element : BYTE);

    CONST abstand = 22;
          platz   = 30;

    BEGIN
      IF nummer=maxplay+1 THEN
         BEGIN
           x:=320;
           y:=232;
         END
        ELSE
         BEGIN
           CASE element OF
             0 : x:= 95;
             1 : x:=245;
             2 : x:=395;
             3 : x:=545;
           END;
           y:=abstand+platz*nummer;
         END;
    END;

  PROCEDURE WriteControl(nummer,element,farbe : BYTE);

    VAR meinString : STRING;
        x,y        : SHORT;

    BEGIN
      meinString:=ALLOCSTRING(20);

      GetPosition(x,y,nummer,element);

      WITH TBase^.players[nummer] DO
        CASE element OF
          0 : BEGIN
                StrCpy(Meinstring,name);
              END;
          1 : BEGIN
                IF Sprache=Deutsch THEN
                   CASE steuerung OF
                     Tasten : Code2String(plcontrol.links,MeinString);
                     Joy1   : StrCpy(Meinstring,"Links 1");
                     Joy2   : StrCpy(Meinstring,"Links 2");
                   END
                  ELSE
                   CASE steuerung OF
                     Tasten : Code2StringEng(plcontrol.links,MeinString);
                     Joy1   : StrCpy(Meinstring,"Left 1");
                     Joy2   : StrCpy(Meinstring,"Left 2");
                   END
              END;
          2 : BEGIN
                IF Sprache=Deutsch THEN
                   CASE steuerung OF
                     Tasten : Code2String(plcontrol.rechts,MeinString);
                     Joy1   : StrCpy(Meinstring,"Rechts 1");
                     Joy2   : StrCpy(Meinstring,"Rechts 2");
                   END
                  ELSE
                   CASE steuerung OF
                     Tasten : Code2StringEng(plcontrol.rechts,MeinString);
                     Joy1   : StrCpy(Meinstring,"Right 1");
                     Joy2   : StrCpy(Meinstring,"Right 2");
                   END;
              END;
          3 : BEGIN
                IF Sprache=Deutsch THEN
                   CASE steuerung OF
                     Tasten : Code2String(plcontrol.vorne AND $7f,MeinString);
                     Joy1   : StrCpy(Meinstring,"Feuer 1");
                     Joy2   : StrCpy(Meinstring,"Feuer 2");
                   END
                  ELSE
                   CASE steuerung OF
                     Tasten : Code2StringEng(plcontrol.vorne AND $7f,MeinString);
                     Joy1   : StrCpy(Meinstring,"Fire 1");
                     Joy2   : StrCpy(Meinstring,"Fire 2");
                   END;
              END;
        END;

      Print(cRastPort,x-48,y,"                  ",0);
      Print(cRastPort,x-(Length(Meinstring) DIV 2),y,Meinstring,farbe);

      Freestring(MeinString);
    END;

  PROCEDURE Normal(nummer,element : BYTE);

    BEGIN
      IF Nummer=maxplay+1 THEN
         BEGIN
           IF Sprache=Deutsch THEN Print(cRastPort,308,230,"Ende",8)
                              ELSE Print(cRastPort,308,230,"Quit",8);
         END
        ELSE WriteControl(nummer,element,8);
    END;

  PROCEDURE Mark(nummer,element : BYTE);

    BEGIN
      IF Nummer=maxplay+1 THEN
         BEGIN
           IF Sprache=Deutsch THEN Print(cRastPort,308,230,"Ende",1)
                              ELSE Print(cRastPort,308,230,"Quit",1);
         END
        ELSE  WriteControl(nummer,element,1);
    END;

  PROCEDURE WriteControls(nummer : BYTE);

    VAR x : BYTE;

    BEGIN
      FOR x:=0 TO 3 DO
        WriteControl(nummer,x,8);
    END;

  PROCEDURE HighlightBox(nummer,element : BYTE);

    VAR x,y : SHORT;

    BEGIN
      GetPosition(x,y,nummer,element);

      DrawIBox(cRastPort,x-74,y-18,x+74,y+10);

      SetAPen(cRastPort,10);
      RectFill(cRastPort,x-73,y-17,x+73,y+9);
    END;

  PROCEDURE UnHighlightBox(nummer,element : BYTE);

    VAR x,y : SHORT;

    BEGIN
      GetPosition(x,y,nummer,element);

      DrawBox(cRastPort,x-74,y-18,x+74,y+10);

      SetAPen(cRastPort,0);
      RectFill(cRastPort,x-73,y-17,x+73,y+9);
    END;

  PROCEDURE ReadControl(nummer,element : BYTE);

    VAR x,y  : SHORT;
        sMSG : IntuiMessagePtr;

    BEGIN
      GetPosition(x,y,nummer,element);

      IF element = 0 THEN
         BEGIN
           HighlightBox(nummer,element);

           WITH TBase^.players[nummer] DO
             BEGIN
               CASE steuerung OF
                 Tasten : BEGIN
                            IF NOT Joy1Used THEN
                               BEGIN
                                 steuerung:=joy1;
                                 Joy1Used:=TRUE;
                               END
                              ELSE
                               IF NOT Joy2Used THEN
                                  BEGIN
                                    steuerung:=Joy2;
                                    Joy2used:=TRUE;
                                  END;
                          END;
                 Joy1   : BEGIN
                            Joy1Used:=FALSE;
                            IF NOT Joy2Used THEN
                               BEGIN
                                 steuerung:=Joy2;
                                 Joy2Used:=TRUE;
                               END
                              ELSE
                               BEGIN
                                 Steuerung:=Tasten;
                               END;
                          END;
                 Joy2   : BEGIN
                            Joy2Used:=FALSE;
                            steuerung:=Tasten;
                          END;
               END;
             END;

           UnhighlightBox(nummer,element);
           WriteControls(nummer);
         END
        ELSE
         IF TBase^.players[nummer].steuerung=Tasten THEN
            BEGIN
              HighlightBox(nummer,element);

              sMSG:=NIL;
              sMSG:=ADDRESS(WaitPort(cWindow^.UserPort));
              sMsg:=ADDRESS(GetMsg(cWindow^.UserPort));
              IF sMSg<>NIL THEN ReplyMsg(ADDRESS(sMsg));

              sMsg:=NIL;
              REPEAT
                IF sMSg<>NIL THEN ReplyMsg(ADDRESS(sMsg));
                sMSG:=NIL;
                sMSG:=ADDRESS(WaitPort(cWindow^.UserPort));
                sMsg:=ADDRESS(GetMsg(cWindow^.UserPort));
              UNTIL sMsg^.class=RawKey_F;

              IF sMsg<>NIL THEN
                 BEGIN
                   IF sMsg^.class=Rawkey_f THEN
                      IF NotUsed(sMSG^.Code) THEN
                         WITH TBase^.players[nummer].plcontrol DO
                           BEGIN
                             CASE element OF
                               1 : links :=sMsg^.code AND $7f;
                               2 : rechts:=sMsg^.code AND $7f;
                               3 : vorne :=sMsg^.code OR  $80;
                             END;
                           END;
                   ReplyMSG(ADDRESS(sMsg));
                 END;

              UnhighlightBox(nummer,element);
            END;

      KillMSGs(cWindow^.Userport);
    END;

  PROCEDURE COpen;

    PROCEDURE DrawBoxes;

      BEGIN
        DrawBox(cRastPort, 21,  4,169, 32);
        DrawBox(cRastPort, 21, 34,169, 62);
        DrawBox(cRastPort, 21, 64,169, 92);
        DrawBox(cRastPort, 21, 94,169,122);
        DrawBox(cRastPort, 21,124,169,152);
        DrawBox(cRastPort, 21,154,169,182);
        DrawBox(cRastPort, 21,184,169,212);

        DrawBox(cRastPort,171,  4,319, 32);
        DrawBox(cRastPort,171, 34,319, 62);
        DrawBox(cRastPort,171, 64,319, 92);
        DrawBox(cRastPort,171, 94,319,122);
        DrawBox(cRastPort,171,124,319,152);
        DrawBox(cRastPort,171,154,319,182);
        DrawBox(cRastPort,171,184,319,212);

        DrawBox(cRastPort,321,  4,469, 32);
        DrawBox(cRastPort,321, 34,469, 62);
        DrawBox(cRastPort,321, 64,469, 92);
        DrawBox(cRastPort,321, 94,469,122);
        DrawBox(cRastPort,321,124,469,152);
        DrawBox(cRastPort,321,154,469,182);
        DrawBox(cRastPort,321,184,469,212);

        DrawBox(cRastPort,471,  4,619, 32);
        DrawBox(cRastPort,471, 34,619, 62);
        DrawBox(cRastPort,471, 64,619, 92);
        DrawBox(cRastPort,471, 94,619,122);
        DrawBox(cRastPort,471,124,619,152);
        DrawBox(cRastPort,471,154,619,182);
        DrawBox(cRastPort,471,184,619,212);

        DrawBox(cRastPort,246,214,394,242);
      END;

    CONST cNewWindow : NewWindow = (0,10,640,246,0,0,RawKey_F+GadgetDown_f+
                                    Gadgetup_f,SMART_Refresh+ACTIVATE+
                                    RMBTrap+Borderless,NIL,NIL,NIL,NIL,NIL,
                                    640,246,640,246,CUSTOMSCREEN_F);

    PROCEDURE InitGadgets;

      BEGIN
        SetGadget(ADR(CGad11),NIL        ,NIL,NIL,NIL);
        SetGadget(ADR(CGad12),ADR(CGad11),NIL,NIL,NIL);
        SetGadget(ADR(CGad13),ADR(CGad12),NIL,NIL,NIL);
        SetGadget(ADR(CGad14),ADR(CGad13),NIL,NIL,NIL);

        SetGadget(ADR(CGad21),ADR(CGad14),NIL,NIL,NIL);
        SetGadget(ADR(CGad22),ADR(CGad21),NIL,NIL,NIL);
        SetGadget(ADR(CGad23),ADR(CGad22),NIL,NIL,NIL);
        SetGadget(ADR(CGad24),ADR(CGad23),NIL,NIL,NIL);

        SetGadget(ADR(CGad31),ADR(CGad24),NIL,NIL,NIL);
        SetGadget(ADR(CGad32),ADR(CGad31),NIL,NIL,NIL);
        SetGadget(ADR(CGad33),ADR(CGad32),NIL,NIL,NIL);
        SetGadget(ADR(CGad34),ADR(CGad33),NIL,NIL,NIL);

        SetGadget(ADR(CGad41),ADR(CGad34),NIL,NIL,NIL);
        SetGadget(ADR(CGad42),ADR(CGad41),NIL,NIL,NIL);
        SetGadget(ADR(CGad43),ADR(CGad42),NIL,NIL,NIL);
        SetGadget(ADR(CGad44),ADR(CGad43),NIL,NIL,NIL);

        SetGadget(ADR(CGad51),ADR(CGad44),NIL,NIL,NIL);
        SetGadget(ADR(CGad52),ADR(CGad51),NIL,NIL,NIL);
        SetGadget(ADR(CGad53),ADR(CGad52),NIL,NIL,NIL);
        SetGadget(ADR(CGad54),ADR(CGad53),NIL,NIL,NIL);

        SetGadget(ADR(CGad61),ADR(CGad54),NIL,NIL,NIL);
        SetGadget(ADR(CGad62),ADR(CGad61),NIL,NIL,NIL);
        SetGadget(ADR(CGad63),ADR(CGad62),NIL,NIL,NIL);
        SetGadget(ADR(CGad64),ADR(CGad63),NIL,NIL,NIL);

        SetGadget(ADR(QuitGad),ADR(CGad64),NIL,NIL,NIL);

        cNewWindow.FirstGadget:=ADR(QuitGad);
      END;

    BEGIN
      InitGadgets;

      cNewWindow.screen:=MyScreen;     { Fenster öffnen }
      cWindow:=NIL;
      cWindow:=OpenWindow(ADR(cNewWindow));
      IF cWindow=NIL THEN CleanExit(Error_No_Window);
      cRastPort:=cWindow^.RPort;

      ViewMouse(cWindow);               { Mauszeiger einstellen }

      SetAPen(cRastPort,1);
      Line(cRastPort,0,0,639,0);
      DrawIBox(cRastPort,0,1,639,245);
      DrawIBox(cRastPort,1,1,638,245);
      Draw0Box(cRastPort,2,2,637,244);
      Draw0Box(cRastPort,3,3,636,243);

      DrawBoxes;
    END;

  VAR x,y,code       : SHORT;
      element,nummer : BYTE;

  BEGIN
    COpen;

    GetPosition(x,y,0,0);
    Print(cRastPort,x-15,y,"Name",8);

    GetPosition(x,y,0,1);
    IF Sprache=Deutsch THEN Print(cRastPort,x-15,y,"links",8)
                       ELSE Print(cRastPort,x-12,y,"left",8);

    GetPosition(x,y,0,2);
    IF Sprache=Deutsch THEN Print(cRastPort,x-18,y,"rechts",8)
                       ELSE Print(cRastPort,x-15,y,"right",8);

    GetPosition(x,y,0,3);
    IF Sprache=Deutsch THEN Print(cRastPort,x-15,y,"vorne",8)
                       ELSE Print(cRastPort,x-21,y,"forward",8);

    Joy1Used:=FALSE;
    Joy2Used:=FALSE;

    FOR nummer:=1 TO maxplay DO
      BEGIN
        IF TBase^.players[nummer].steuerung=Joy1 THEN Joy1Used:=TRUE;
        IF TBase^.players[nummer].steuerung=Joy2 THEN Joy2Used:=TRUE;
        WriteControls(nummer);
      END;

    IF Sprache=Deutsch THEN Print(cRastPort,308,230,"Ende",8)
                       ELSE Print(cRastPort,308,230,"Quit",8);

    element:=1;
    nummer:=1;
    Mark(nummer,element);

    REPEAT
      code:=0;
      cMSG:=NIL;
      cMSG:=ADDRESS(WaitPort(cWindow^.UserPort));
      cMSG:=ADDRESS(GetMSG  (cWindow^.UserPort));

      IF cMSG<>NIL THEN
         BEGIN
           IF (cMsg^.Class=Rawkey_f    ) OR
              (cMsg^.Class=Gadgetup_f  ) OR
              (cMsg^.Class=GadgetDown_f) THEN
              BEGIN
                IF cMsg^.Class=RawKey_f THEN
                   BEGIN
                     code:=cMSG^.Code;
                   END
                  ELSE
                   BEGIN
                     Code:=GetGadgetID(cMsg^.IAddress);

                     IF Code>0 THEN
                        BEGIN
                          Normal(nummer,element);

                          nummer :=Code DIV 10;
                          element:=Code MOD 10;

                          Mark(nummer,element);
                        END
                       ELSE
                        BEGIN
                          nummer:=maxplay+1;
                        END;

                     Code:=68;
                   END;

                CASE code OF
                  76 : BEGIN
                         IF nummer>1 THEN
                            BEGIN
                              Normal(nummer,element);
                              nummer:=nummer-1;
                              Mark(nummer,element);
                            END;
                       END;
                  77 : BEGIN
                         IF nummer<maxplay+1 THEN
                            BEGIN
                              Normal(nummer,element);
                              inc(nummer);
                              Mark(nummer,element);
                            END
                       END;
                  78 : BEGIN
                         IF element<3 THEN
                            BEGIN
                              Normal(nummer,element);
                              inc(element);
                              Mark(nummer,element);
                            END;
                       END;
                  79 : BEGIN
                         IF element>0 THEN
                            BEGIN
                              Normal(nummer,element);
                              element:=element-1;
                              Mark(nummer,element);
                            END;
                       END;
                  67,
                  68 : BEGIN
                         IF nummer=Maxplay+1 THEN
                            BEGIN
                              HighlightBox(nummer,element);
                              SetBPen(cRastPort,10);
                              Mark(nummer,element);

                              code:=F10;
                              Delay(10);

                              UnHighlightBox(nummer,element);
                              SetBPen(cRastPort,0);
                              Mark(nummer,element);
                            END
                           ELSE
                            BEGIN
                              ReadControl(nummer,element);
                              Mark(nummer,element);
                            END;
                       END;
                 ELSE;
                END;
              END;
           ReplyMsg(ADDRESS(cMSG));
         END;

    UNTIL (code=F10);

    CloseWindow(cWindow);
  END;
