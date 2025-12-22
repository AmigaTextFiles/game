{ Player.i }

{$I "Joystick.i" }

{ Funktionen :
   - BitTest (Bit gesetzt oder nicht? )
   - Joystick1 ( Joystickport )
   - Joystick2 ( Mausport     )

      Rückgabewerte :

        0 - nichts
        1 - oben
        2 - unten
        4 - links
        8 - rechts
       16 - Feuer
}

PROCEDURE Warte; { Nach Ende des Spiels warten }

  VAR IntMSG : IntuiMessagePtr;

  BEGIN
    Delay(50);
    REPEAT
      IntMSG:=ADDRESS(WaitPort(GameWindow^.UserPort));
      IntMSG:=ADDRESS(GetMSG(GameWindow^.UserPort));
      IF intMSG<>NIL THEN ReplyMSG(ADDRESS(IntMSG));
    UNTIL  (IntMSG^.Class=Mousebuttons_f) OR
          ((IntMSG^.Class=RawKey_F      ) AND
           (IntMSG^.Code=F10            ));
  END;

PROCEDURE WaitEsc(ID : BYTE); { Warten, falls jemand entkommen ist. }

  VAR IntMSG       : IntuiMessagePtr;
      SpielerNr    : STRING;
      Zahl,cosinus : SHORT;
      Q,Time       : BOOLEAN;
      x,MinX,MaxX  : SHORT;

  BEGIN
    spielerNr:=ALLOCSTRING(40);

    IF Sprache=Deutsch THEN StrCpy(SpielerNr,"Entkommen : ")
                       ELSE strCpy(SpielerNr,"Escaped : "  );
    StrCat(spielerNr,TBase^.players[id].name);

    x:=160-(LENGTH(SpielerNr) DIV 2);
    MinX:=x-2;
    MaxX:=320-X;

    cosinus:=ROUND(COS(zahl/40*pi)*20);

    zahl:=20;
    Q:=FALSE;
    time:=FALSE;

    REPEAT
      Delay(1);

      SetAPen(GameRP,9);
      RectFill(GameRP,MinX,38+cosinus,MaxX,48+cosinus);

      cosinus:=ROUND(COS(zahl/40*pi)*20);

      SetAPen(GameRP,8);
      RectFill(GameRP,MinX,38+cosinus,MaxX,48+cosinus);
      DrawSBox(GameRP,MinX,38+cosinus,MaxX,48+cosinus);

      Print(GameRP,x,46+cosinus,spielerNr,id+1);

      inc(Zahl);
      IF zahl=60 THEN BEGIN
                        zahl:=0;
                        Time:=TRUE;
                      END;

      intMSG:=NIL;
      IntMSG:=ADDRESS(GetMSG(GameWindow^.UserPort));

      IF IntMSG<>NIL THEN BEGIN
                            q:= (IntMSG^.Class=Mousebuttons_f) OR
                               ((IntMSG^.Class=RawKey_F      ) AND
                                (IntMSG^.Code =F10           ));
                            ReplyMSG(ADDRESS(IntMSG));
                          END;
    UNTIL Q AND Time;
    FreeString(SpielerNr);
  END;

PROCEDURE Bremsen(Laenge : BYTE); { Bremsung sobald Spieler ausscheiden... }

  VAR zahl     : BYTE;
      Variable : SHORT;
      Test     : BYTE;

  BEGIN
    IF Laenge>0 THEN
       BEGIN
         FOR zahl:=1 TO Laenge DO
           BEGIN
             FOR variable:=1 TO 110 DO Test:=1;
           END;
       END;
  END;

PROCEDURE MyExit(Identify : BYTE); { Spieler kaputt, aber wer und wat nu }

  PROCEDURE Reichweite; { Vielleicht ist jemand zu nah an der Explosion gewesen}

    VAR help   : BYTE;
        x0,y0,r: INTEGER;

    BEGIN
      FOR help:=1 TO TBase^.player DO
        IF TBase^.players[help].Ok THEN
           WITH TBase^ DO
             BEGIN
               x0:=players[help].x-players[identify].x; { Satz des Phytagoras}
               y0:=players[help].y-players[identify].y;
               r:=x0*x0+y0*y0;
               IF r<226 THEN MyExit(help);
             END;
    END;

  FUNCTION Pl_Vorne(EinSpieler : SpielerPtr) : BYTE; { Wer war im Weg ?}

    BEGIN
      pl_Vorne:=readpixel(gameRP,einspieler^.x+einspieler^.mx,
                                 einspieler^.y+einspieler^.my)-1;
    END;

  PROCEDURE Explodiere; { ? - Sicherlich gibt es schönere Methoden. }
                        { Diese ist dafür sehr schnell.             }

    VAR posx,posy,zahl : SHORT;

    BEGIN
      WITH TBase^.players[identify] DO
        BEGIN
          SetAPen(GameRP,9);

          Move(GameRP,x-5,y  );
          Draw(GameRP,x+5,y  );

          Move(GameRP,x  ,y-5);
          Draw(GameRP,x  ,y+5);


          Move(GameRP,x+2,y-3);
          Draw(GameRP,x+2,y+3);

          Move(GameRP,x-2,y-3);
          Draw(GameRP,x-2,y+3);


          Move(GameRP,x+3,y+2);
          Draw(GameRP,x-3,y+2);

          Move(GameRP,x+3,y-2);
          Draw(GameRP,x-3,y-2);

          SetAPen(GameRP,identify+1);
          FOR zahl:=1 TO 7 DO
           BEGIN
            REPEAT
              posx:=RangeRandom(14)-7;
              posy:=RangeRandom(14)-7;
            UNTIL SQR(posx)+SQR(posy)<50;

            WritePixel(GameRP,x+posx,y+posy);
           END;
        END;
    END;

  VAR hindernis : BYTE;
                        { Was da so alles erledigt werden muß... }
  BEGIN
    IF TBase^.Remain>1 THEN
     BEGIN
       hindernis:=Pl_Vorne(ADR(TBase^.players[identify]));
       TBase^.players[identify].ok:=FALSE;             { Spieler kaputt }
       IF (hindernis<>identify) AND (hindernis>0) AND (hindernis<=maxplay) THEN
          IF TBase^.players[hindernis].ok THEN
             inc(TBase^.players[hindernis].hits);      { Eventuell Hits erhöhen }
       IF hindernis=-1 THEN
          BEGIN
            TBase^.QuitGame:=TRUE;
            TBase^.First:=identify;
          END
         ELSE BEGIN
                TBase^.remain:=TBase^.Remain-1;
                CASE TBase^.remain OF { Anzahl der Überlebenden }
                  1 : BEGIN                     { = 1 }
                        TBase^.Quitgame:=TRUE;  { =>Spiel zuende }
                        TBase^.secnd:=Identify; { Zerstörter = 2.  }
                        FOR hindernis:=1 TO TBase^.Player DO
                          IF TBase^.players[hindernis].ok THEN
                             TBase^.first:=hindernis; { Überlebender = 1. }
                      END;
                  2 : BEGIN                     { = 2 }
                        TBase^.third:=Identify; { => Zerstörter = 3. }
                        Reichweite;
                      END;
                 ELSE Reichweite; { Ansonsten Pech gehabt }
                END;

                Explodiere;
              END;
     END;
  END;

PROCEDURE Mauere(ID : BYTE); { Letzten Punkt löschen      }
                             { und ersten Punkt speichern }

  BEGIN
    IF TBase^.max_length>0 THEN
       WITH TBase^ DO
         WITH Players[ID] DO
           BEGIN
             With strich[pos] DO
               IF ReadPixel(GameRP,x,y)=id+1 THEN
                  IF x>0 THEN
                     BEGIN
                       SetAPen(GameRP,9);
                       Writepixel(GameRP,x,y);
                     END;

             strich[pos].x:=x;
             strich[pos].y:=y;

             inc(pos);
             IF pos>max_Length THEN pos:=1;
           END;
  END;

PROCEDURE Loesche_Striche;  { Die Striche kaputter Spieler löschen }

  VAR Hilfe : SHORT;

  BEGIN
    With TBase^ DO
      IF max_length>0 THEN
         FOR hilfe:=1 TO player DO
           IF NOT players[hilfe].ok THEN
              WITH players[hilfe] DO
                BEGIN
                  WITH Strich[pos] DO
                    IF (ReadPixel(GameRP,x,y)=id+1) THEN
                       BEGIN
                         IF x>0 THEN
                            BEGIN
                              SetAPen(GameRP,9);
                              Writepixel(GameRP,x,y);
                            END;

                         Strich[pos].x:=0;
                       END;

                  inc(pos);
                  IF pos>max_Length THEN pos:=1;
                END;
  END;

{======= Here it starts... ============}

FUNCTION vorne_frei(EinSpieler : SpielerPtr) : BOOLEAN; { gehts vor ? }

  VAR Farbe : INTEGER;

  BEGIN
    Farbe:=readpixel(GameRP,einspieler^.x+einspieler^.mx,
                            einspieler^.y+einspieler^.my);
    Farbe:=Farbe MOD 16;
    vorne_Frei:=(Farbe=9);
  END;

FUNCTION rechts_frei(einspieler : SpielerPtr) : BOOLEAN; { rechts frei ? }

  VAR Farbe : INTEGER;

  BEGIN
    Farbe:=readpixel(GameRP,einspieler^.x-einspieler^.my,
                            einspieler^.y+einspieler^.mx);
    Farbe:=Farbe MOD 16;
    rechts_Frei:=(Farbe=9);
  END;

FUNCTION links_frei(einspieler : SpielerPtr) : BOOLEAN; { links frei ? }

  VAR Farbe : INTEGER;

  BEGIN
    Farbe:=ReadPixel(GameRP,einspieler^.x+einspieler^.my,
                            einspieler^.y-einspieler^.mx);
    Farbe:=Farbe MOD 16;
    links_Frei:=(Farbe=9);
  END;

FUNCTION Vorne_Links_frei(Einspieler : SpielerPtr) : BOOLEAN;

  VAR Farbe : INTEGER;

  BEGIN
    WITH Einspieler^ DO
      Farbe:=ReadPixel(GameRP,x+mx+my,y+my-mx);

    Farbe:=Farbe MOD 16;
    Vorne_Links_Frei:=(Farbe=9);
  END;

FUNCTION Vorne_Rechts_frei(Einspieler : SpielerPtr) : BOOLEAN;

  VAR Farbe : INTEGER;

  BEGIN
    WITH Einspieler^ DO
      Farbe:=ReadPixel(GameRP,x+mx-my,y+my+mx);

    Farbe:=Farbe MOD 16;
    Vorne_Rechts_Frei:=(Farbe=9);
  END;

PROCEDURE drehe_links(einspieler : SpielerPtr); { drehen }

  VAR hilfe : SHORT;

  BEGIN
    inc(einspieler^.left);

    hilfe:=-einspieler^.mx;
    einspieler^.mx:=einspieler^.my;
    einspieler^.my:=hilfe;
  END;

PROCEDURE drehe_rechts(einspieler : SpielerPtr); { andersrum drehen }

  VAR hilfe : SHORT;

  BEGIN
    einspieler^.left:=Einspieler^.left-1;

    hilfe:=einspieler^.mx;
    einspieler^.mx:=-einspieler^.my;
    einspieler^.my:=hilfe;
  END;

PROCEDURE Vor(aspieler : SpielerPtr); { VORWÄRTS }

  BEGIN
    IF NOT vorne_frei(aSpieler) THEN MyExit(aspieler^.ID)
       ELSE With ASpieler^ DO
            BEGIN
              mauere(ID);

              SetAPen(GameRP,ID+1);

              x:=x+mx;
              y:=y+my;

              WritePixel(GameRP,x,y);
            END;
  END;

{======= Here it ends... ============}

PROCEDURE Male_Stein;   { Hindernisse malen... }

  VAR x,y,color : SHORT;

  BEGIN
    x    :=RangeRandom(295)+11; { Position und Art auswürfeln }
    y    :=RangeRandom(220)+11;
    color:=RangeRandom(  2)+10;

    CASE RangeRandom(17) OF
      0,
      1,
      2,
      3,
      4,
      5 : BEGIN
            SetAPen(GameRP,10);
            Move(GameRP,x  ,y+3);
            Draw(GameRP,x+3,y+3);
            Draw(GameRP,x+3,y  );

            SetAPen(GameRP,12);
            Draw(GameRP,x  ,y  );
            Draw(GameRP,x  ,y+3);

            SetAPen(GameRP,11);
            RectFill(GameRP,x+1,y+1,x+2,y+2);
          END;
      6,
      7,
      8,
      9 : BEGIN
            SetAPen(GameRP,color);
            Move(GameRP,x  ,y+3);
            Draw(GameRP,x+3,y+3);
            Draw(GameRP,x+3,y  );
            Draw(GameRP,x  ,y  );
            Draw(GameRP,x  ,y+3);
          END;
     10,
     11 : BEGIN
            IF x=306 THEN x:=305;
            IF y=231 THEN y:=230;

            SetAPen(GameRP,color);
            DrawCircle(GameRP,x+2,y+2,2);
          END;
     12,
     13 : BEGIN
            SetAPen(GameRP,color);
            RectFill(GameRP,x,y,x+3,y+3);
          END;
     14 : BEGIN
            IF color=12 THEN color:=11;
            IF x=306 THEN x:=305;
            IF y=231 THEN y:=230;

            SetAPen(GameRP,color+1);
            Move(GameRP,x+1,y+4);
            Draw(GameRP,x+4,y+4);
            Draw(GameRP,x+4,y+1);
            Draw(GameRP,x+1,y+1);
            Draw(GameRP,x+1,y+4);

            SetAPen(GameRP,color);
            Move(GameRP,x  ,y+3);
            Draw(GameRP,x+3,y+3);
            Draw(GameRP,x+3,y  );
            Draw(GameRP,x  ,y  );
            Draw(GameRP,x  ,y+3);
          END;
     15 : BEGIN
            IF color=10 THEN color:=11;
            IF x=306 THEN x:=305;
            IF y=231 THEN y:=230;

            SetAPen(GameRP,color-1);
            Move(GameRP,x+1,y+4);
            Draw(GameRP,x+4,y+4);
            Draw(GameRP,x+4,y+1);
            Draw(GameRP,x+1,y+1);
            Draw(GameRP,x+1,y+4);

            SetAPen(GameRP,color);
            Move(GameRP,x  ,y+3);
            Draw(GameRP,x+3,y+3);
            Draw(GameRP,x+3,y  );
            Draw(GameRP,x  ,y  );
            Draw(GameRP,x  ,y+3);
          END;
     ELSE BEGIN
            IF x=306 THEN x:=305;
            IF y=231 THEN y:=230;

            SetAPen(GameRP,color);
            DrawCircle(GameRP,x+2,y+2,2);
            IF color<12 THEN SetAPen(GameRP,color+1)
                        ELSE SetAPen(GameRP,12 );
            RectFill(GameRP,x+1,y+1,x+3,y+3);
          END;
    END;
  END;

PROCEDURE DrawGameField; { Erst Spielfeld malen }

  PROCEDURE Loesche_Startzone;

    VAR zahl,MinX,MinY,MaxX,MaxY : SHORT;

    BEGIN
      MinX:=640;
      MinY:=256;
      MaxX:=0;
      MaxY:=0;

      FOR zahl:=1 TO TBase^.Player DO
        WITH TBase^.Players[zahl] DO
        BEGIN
          IF MinX>x THEN MinX:=x;
          IF MinY>y THEN MinY:=y;
          IF MaxX<x THEN MaxX:=x;
          IF MaxY<y THEN MaxY:=y;
        END;

      SetAPen(GameRP,9);
      Rectfill(GameRP,MinX,MinY,MaxX,MaxY);
    END;

  VAR hilfe : SHORT;

  BEGIN
    SetAPen(GameRP,0);
    RectFill(GameRP,0,0,319,245);

    SetAPen(GameRP,1);
    Line(GameRP,0,0,319,0);

    SetAPen(GameRP,9);
    RectFill(GameRP,10,10,310,235);
    DrawCBox(GameRP,10,10,310,235,10,1);

    SetAPen(GameRP,10);

    WritePixel(GameRP,11,130);

    WritePixel(GameRP,177,11);

    SetAPen(GameRP,1);

    WritePixel(GameRP,125,234);

    WritePixel(GameRP,309,90);

    FOR Hilfe:=1 TO LevelArray[TBase^.level] DO { Hindernisse malen }
      BEGIN
        Male_Stein;
      END;

    { Grundstriche malen }
    IF TBase^.Use_Maze THEN
       BEGIN
         WITH TBase^.MyMaze DO
           FOR Hilfe:=1 TO LineNum DO
             WITH linien^[Hilfe] DO
               BEGIN
                 SetAPen(GameRP,colour);
                 Move(GameRP,x1,y1);
                 Draw(GameRP,x2,y2);
               END;
       END
      ELSE
       BEGIN
         SetAPen(GameRP,RangeRandom(2)+10);

         Move(GameRP,50, 60);
         Draw(GameRP,50,180);

         Move(GameRP,270, 60);
         Draw(GameRP,270,180);
       END;

    IF NOT TBase^.Use_Maze OR TBase^.MyMaze.Loeschen THEN
       Loesche_Startzone;

    FOR Hilfe:=1 TO MaxPlay DO BEGIN { Anfangspositionen malen }
                                 IF TBase^.players[Hilfe].ok THEN
                                    BEGIN
                                      SetAPen(GameRP,
                                            TBase^.Players[Hilfe].ID+1);
                                      WritePixel(GameRP,
                                               TBase^.Players[Hilfe].x,
                                               TBase^.Players[Hilfe].y);
                                    END;
                               END;
  END;

  PROCEDURE Lobe; { ? }

    VAR Punkte : BYTE;

    PROCEDURE Verteile_Punkte; { ? }

      VAR help1,lebende : BYTE;

      BEGIN
        FOR help1:=1 TO TBase^.player DO WITH TBase^.players[help1] DO
            score:=score+3*hits; { 3 Pts für jeden aktiv zerstörten Gegner }

        IF TBase^.remain=1 THEN
           BEGIN
             WITH TBase^.players[TBase^.first] DO { 1. = 15 Pts }
               Score:=Score+15;
             WITH TBase^.players[TBase^.secnd] DO { 2. = 10 Pts }
               Score:=Score+10;
             WITH TBase^.players[TBase^.third] DO { 3. =  5 Pts }
               Score:=Score+5;
           END
        ELSE IF TBase^.first>0 THEN
                BEGIN
                  WITH TBase^.players[TBase^.first] DO
                    score:=score+20;{ Entkommen = 20 Pts}
                END
               ELSE
                BEGIN
                  Lebende:=0;
                  FOR Help1:=1 TO TBase^.Player DO
                    IF TBase^.Players[help1].Ok THEN inc(lebende);

                  CASE Lebende OF
                    2 : BEGIN
                          Punkte:=12;
                          WITH TBase^.Players[TBase^.third] DO
                            Score:=score+5;
                        END;
                    3 : Punkte:=10;
                    4 : Punkte:= 8;
                    5 : Punkte:= 6;
                    6 : Punkte:= 5;
                  END;

                  FOR Help1:=1 TO TBase^.Player DO
                    WITH TBase^.Players[Help1] DO
                      BEGIN
                        IF Ok THEN Score:=Score+Punkte;
                      END;
                END;
      END;

    VAR sHelp,kills : SHORT;
        sString     : STRING;

    BEGIN                       { und alles auf dem Bildschirm ausgeben }
      sString:=ALLOCSTRING(40);
      Verteile_Punkte;
      IF TBase^.remain=1 THEN { wenn keiner entkommen ist... }
         BEGIN
           SetAPen(GameRP,8);
           RectFill(GameRP,74,28,245,38);
           DrawSBox(GameRP,74,28,245,38);
           IF Sprache=Deutsch THEN StrCpy(sString,"Sieger : ")
                              ELSE StrCpy(sString,"Winner : ");
           StrCat(sString,TBase^.players[TBase^.First].name);
           Print(GameRP,160-(LENGTH(sString) DIV 2),36,sString,TBase^.first+1);

           SetAPen(GameRP,8);
           RectFill(GameRP,74,48,245,58);
           DrawSBox(GameRP,74,48,245,58);
           IF Sprache=Deutsch THEN StrCpy(sString,"Zweiter : ")
                              ELSE StrCpy(sString,"Second : ");
           StrCat(sString,TBase^.players[TBase^.Secnd].name);
           Print(GameRP,160-(LENGTH(sString) DIV 2),56,sString,TBase^.secnd+1);

           If TBase^.Player>2 THEN
              BEGIN
                SetAPen(GameRP,8);
                RectFill(GameRP,74,68,245,78);
                DrawSBox(GameRP,74,68,245,78);

                IF Sprache=Deutsch THEN StrCpy(sString,"Dritter : ")
                                   ELSE StrCpy(sString,"Third : "  );
                StrCat(sString,TBase^.players[TBase^.third].name);
                Print(GameRP,160 -(LENGTH(sString) DIV 2),76,sString,TBase^.Third+1);
              END;
         END
        ELSE IF TBase^.First=0 THEN
                BEGIN
                  SetAPen(GameRP,8);
                  RectFill(GameRP,74,28,245,38);
                  DrawSBox(GameRP,74,28,245,38);
                  IF Sprache=Deutsch THEN StrCpy(sString,"Überlebensbonus : ")
                                     ELSE StrCpy(sString,"Survival bonus : " );
                  AddString(sString,punkte);
                  Print(GameRP,160-(LENGTH(sString) DIV 2),36,sString,12);

                  IF TBase^.Third>0 THEN
                     BEGIN
                       SetAPen(GameRP,8);
                       RectFill(GameRP,74,68,245,78);
                       DrawSBox(GameRP,74,68,245,78);

                       IF Sprache=Deutsch THEN StrCpy(sString,"Dritter : ")
                                          ELSE StrCpy(sString,"Third : "  );
                       StrCat(sString,TBase^.players[TBase^.third].name);
                       Print(GameRP,160 -(LENGTH(sString) DIV 2),76,sString,TBase^.Third+1);
                     END;
                END;

      kills:=0;                   { Erledigte zählen }
      FOR SHelp:=1 TO MaxPlay DO
        BEGIN
          Kills:=kills+TBase^.players[sHelp].hits;
        END;

      IF Kills>0 THEN { Nur anzeigen, wenn mindestens einer erwischt wurde }
         BEGIN
           SetAPen(GameRP,8);
           RectFill(GameRP,78,90,242,210);
           DrawSBox(GameRP,78,90,242,210);
           IF Sprache=Deutsch THEN Print(GameRP,133,106,"Erledigt",1)
                              ELSE Print(GameRP,139,106,"Killed"  ,1);

           FOR sHelp:=1 TO maxplay DO
             BEGIN
                StrCpy(sString,TBase^.players[sHelp].name);
                Print(GameRP,88,106+15*shelp,sString,sHelp+1);

                StrCpy(sString,":  ");
                 AddString(sString,TBase^.players[shelp].hits);
                Print(GameRP,204,106+15*shelp,sString,sHelp+1);
             END;
         END;

      FreeString(sString);
    END;

PROCEDURE CalcPlayer(einSpieler : SpielerPtr); { Computerspieler berechen }

  FUNCTION V_L_frei : BOOLEAN;

    VAR Farbe : INTEGER;

    BEGIN
      Farbe:=ReadPixel(GameRP,einspieler^.x+einspieler^.mx+einspieler^.my,
                              einspieler^.y+einspieler^.my-einspieler^.mx);

      Farbe:=Farbe MOD 16;
      V_L_Frei:=((Farbe=9) OR (Farbe=0));
    END;

  FUNCTION V_R_frei : BOOLEAN;

    VAR Farbe : INTEGER;

    BEGIN
      Farbe:=ReadPixel(GameRP,einspieler^.x+einspieler^.mx-einspieler^.my,
                              einspieler^.y+einspieler^.my+einspieler^.mx);

      Farbe:=Farbe MOD 16;
      V_R_Frei:=((Farbe=9) OR (Farbe=0));
    END;

  FUNCTION v_frei : BOOLEAN; { gehts vor ? }

    VAR Help : BYTE;

    BEGIN
      Help:=readpixel(GameRP,einspieler^.x+einspieler^.mx,
                             einspieler^.y+einspieler^.my);
      V_Frei:=((Help=9) OR (Help=0));
    END;

  FUNCTION r_frei : BOOLEAN; { rechts frei ? }

    VAR Help : BYTE;

    BEGIN
      Help:=readpixel(GameRP,einspieler^.x-einspieler^.my,
                             einspieler^.y+einspieler^.mx);
      r_Frei:=((Help=9) OR (Help=0));
    END;

  FUNCTION l_frei : BOOLEAN; { links frei ? }

    VAR Help : BYTE;

    BEGIN
      help:=readpixel(GameRP,einspieler^.x+einspieler^.my,
                             einspieler^.y-einspieler^.mx);
      l_Frei:=((Help=9) OR (help=0));
    END;

  PROCEDURE ComputerSchema_1a; { Für KI=0 }

    VAR mx,my : SHORT;

    BEGIN
      mx:=Einspieler^.mx;
      my:=Einspieler^.my;

     IF mx= 1 THEN
        BEGIN
          IF einspieler^.y<128 THEN Drehe_rechts(Einspieler)
                               ELSE Drehe_links (Einspieler);
        END
       ELSE
        BEGIN
          IF mx=-1 THEN
             BEGIN
               IF einspieler^.y<128 THEN Drehe_links (Einspieler)
                                    ELSE Drehe_rechts(Einspieler);
             END
            ELSE
             BEGIN
               IF my= 1 THEN
                  BEGIN
                    IF einspieler^.x<160 THEN Drehe_links (Einspieler)
                                         ELSE Drehe_rechts(Einspieler);
                  END
                 ELSE
                  IF my=-1 THEN
                     BEGIN
                        IF einspieler^.x<160 THEN Drehe_rechts(Einspieler)
                                             ELSE Drehe_links (Einspieler);
                     END;
             END;
        END;
    END;

  PROCEDURE ComputerSchema_1b; { Für KI=1 }

    VAR mx,my : SHORT;

    BEGIN
      mx:=Einspieler^.mx;
      my:=Einspieler^.my;

     IF mx= 1 THEN
        BEGIN
          IF einspieler^.y<128 THEN Drehe_rechts(Einspieler)
                               ELSE Drehe_links (Einspieler);
        END
       ELSE
        BEGIN
          IF mx=-1 THEN
             BEGIN
               IF einspieler^.y<128 THEN Drehe_links (Einspieler)
                                    ELSE Drehe_rechts(Einspieler);
             END
            ELSE
             BEGIN
               IF my= 1 THEN
                  BEGIN
                    IF einspieler^.x<160 THEN Drehe_links (Einspieler)
                                         ELSE Drehe_rechts(Einspieler);
                  END
                 ELSE
                  IF my=-1 THEN
                     BEGIN
                        IF einspieler^.x<160 THEN Drehe_rechts(Einspieler)
                                             ELSE Drehe_links (Einspieler);
                     END;
             END;
        END;
    END;

  PROCEDURE ComputerSchema_2a; { für KI=2 }

    BEGIN
      IF einspieler^.left>0 THEN drehe_rechts(Einspieler)
                            ELSE drehe_links (Einspieler);
    END;

  PROCEDURE ComputerSchema_2b; { für KI=3 }

    BEGIN
      IF einspieler^.left>0 THEN BEGIN
                                   drehe_rechts(Einspieler);
                                   einspieler^.left:=0;
                                 END
                            ELSE BEGIN
                                   drehe_links(Einspieler);
                                   einspieler^.left:=1;
                                 END;
    END;

  VAR vorne,links,rechts : BOOLEAN;

  BEGIN
    IF Einspieler^.Turbo THEN
       IF v_Frei THEN
          IF NOT (V_L_Frei AND V_R_Frei) THEN Vor(Einspieler);

    vorne:=v_Frei;
    links:=l_frei;
    rechts:=r_Frei;

    IF NOT Vorne THEN
       BEGIN
         IF Links AND Rechts THEN CASE Einspieler^.KI OF
                                    0 : ComputerSchema_1a;
                                    1 : ComputerSchema_1b;
                                    2 : ComputerSchema_2a;
                                    3 : ComputerSchema_2b;
                                  END
                             ELSE BEGIN
                                    IF Links  THEN Drehe_Links (Einspieler);
                                    IF rechts THEN Drehe_Rechts(Einspieler);
                                  END;
       END
      ELSE IF Einspieler^.Ausweicher THEN
              IF NOT (V_R_Frei OR V_L_Frei) THEN
                 BEGIN
                   IF links  THEN Drehe_Links (Einspieler);
                   IF rechts THEN Drehe_Rechts(Einspieler);
                 END;
  END;

PROCEDURE OpenGameDisplay;

  PROCEDURE SetGameColours; { Farben einstellen }

    VAR MyColours, Colours : ColourArray;
        Hilfe,help : BYTE;

    BEGIN
      FOR hilfe:=0 TO 19 DO SetRGB4(ADDRESS(GameScreen^.SViewPort),hilfe,
                                            NormColours[hilfe].r,
                                            NormColours[hilfe].g,
                                            NormColours[hilfe].b);

      WITH TBase^ DO
        SetRGB4(ADR(GameScreen^.SViewPort),9,
                    BackColours[BackColour].r,
                    BackColours[BackColour].g,
                    BackColours[BackColour].b);
    END;

  CONST gNewWindow  : NewWindow = (0,10,320,246,0,0,RawKey_F+MouseButtons_F,
                                   SMART_Refresh+RMBTrap+BORDERLESS,NIL,
                                   NIL,NIL,NIL,NIL,320,226,320,226,
                                   CUSTOMSCREEN_F);

        gNewScreen  : NewScreen = (0,0,320,256,4,8,1,0,CUSTOMSCREEN_F+
                                   ScreenBehind_F,NIL,
                                   "LS-Tron - Spielfeldbildschirm",
                                   NIL,NIL);

  BEGIN
    gamescreen:=NIL;
    GameWindow:=NIL;

    GNewScreen.font:=ADR(NFont);
    GameScreen:=OpenScreen(ADR(gNewScreen));
    IF GameScreen=NIL THEN CleanExit(Error_No_Screen);

    gNewWindow.screen:=gameScreen;
    GameWindow:=OpenWindow(ADR(gNewWindow));
    IF gameWindow=NIL THEN CleanExit(Error_No_Window);

    GameRP:=ADDRESS(GameWindow^.RPort);
    SetBPen(GameRP,8);

    SetGameColours;
    DelMouse(GameWindow);

    ActivateWindow(GameWindow);
    ScreenToFront(GameScreen);
  END;

PROCEDURE CloseGameDisplay;

  BEGIN
    ActivateWindow(MyWindow);
    ScreenToFront(MyScreen);

    ClearPointer(GameWindow);

    CloseWindow(GameWindow);
    CloseScreen(GameScreen);

    GameWindow:=NIL;
    GameScreen:=NIL;
    GameRP    :=NIL;
  END;

PROCEDURE Play; { Endlich spielen }

  VAR PlNumber,
      Bremser  : BYTE;

  PROCEDURE Reagiere_auf_MSGs;

    VAR aIntMSG : IntuiMessagePtr;

    PROCEDURE DecodeMSG; { Was will der User denn? }

      PROCEDURE Pause; { ??? }

        VAR sMSG : IntuiMessagePtr;

        BEGIN
          sMSG:=NIL;
          REPEAT
            IF sMSG<>NIL THEN ReplyMsg(ADDRESS(sMSG));
            sMSG:=NIL;
            SMSG:=ADDRESS(WaitPort(Gamewindow^.UserPort));
            sMSG:=ADDRESS(GetMSG(GameWindow^.UserPort));
          UNTIL (sMsg^.Code=$19) AND (sMSG^.Class=RawKey_F);
          ReplyMSG(ADDRESS(sMSG));
        END;

      VAR Hilfe, code : SHORT;

      BEGIN
        IF aIntMSG^.Class=RawKey_F THEN
          WITH TBase^ DO
            BEGIN
              Code:=aIntMSG^.Code;

              IF Code=F1  THEN Bremser:=0;     {   F1    }
              IF Code=$19 THEN Pause;          {   "P"   }
              IF Code=$45 THEN QuitGame:=TRUE; { Escape? }
              IF Code=F10 THEN BEGIN           {   F10   }
                                 Unentschieden:=TRUE;
                                 Quitgame:=TRUE;
                               END;

              FOR Hilfe:=1 TO human DO
                IF players[hilfe].Steuerung=Tasten THEN
                   WITH players[hilfe].plControl DO
                     BEGIN
                       IF Code=links  THEN
                          drehe_links (ADR(players[hilfe]));

                       IF Code=rechts THEN
                          drehe_rechts(ADR(players[hilfe]));

                       IF Code=vorne  THEN
                          IF TBase^.players[hilfe].Ok THEN
                             vor         (ADR(players[hilfe]));
                     END;
            END;
      END;

    PROCEDURE CalcJoy; { Joysticksteuerung...}
                       { Die Variablen lastleft und lastright verhindern }
                       { doppelte Reaktion auf eine Joystickbewegung     }

      VAR Eingabe,hilfe : BYTE;

      BEGIN
        WITH TBase^ DO
          BEGIN
            FOR hilfe:=1 TO Human DO
              WITH players[hilfe] DO
                BEGIN
                  IF Steuerung=Joy1 THEN
                     IF ok AND NOT complayer THEN
                        BEGIN
                          Eingabe:=Joystick1;

                          IF bittest(Eingabe,2) THEN
                             BEGIN
                               IF NOT lastleft THEN
                                  drehe_links (ADR(players[hilfe]));
                               lastleft:=TRUE;
                             END
                            ELSE lastleft:=FALSE;

                          IF bittest(Eingabe,3) THEN
                             BEGIN
                               IF NOT lastright THEN
                                  drehe_rechts(ADR(players[hilfe]));
                               lastright:=TRUE;
                             END
                            ELSE lastright:=FALSE;

                          IF bittest(Eingabe,4) THEN vor(ADR(players[hilfe]));
                        END;

                  IF Steuerung=Joy2 THEN
                     IF ok AND NOT complayer THEN
                        BEGIN
                          Eingabe:=Joystick2;

                          IF bittest(Eingabe,2) THEN
                             BEGIN
                               IF NOT lastleft THEN
                                  drehe_links (ADR(players[hilfe]));
                               lastleft:=TRUE;
                             END
                            ELSE lastleft:=FALSE;

                          IF bittest(Eingabe,3) THEN
                             BEGIN
                               IF NOT lastright THEN
                                  drehe_rechts(ADR(players[hilfe]));
                               lastright:=TRUE;
                             END
                            ELSE lastright:=FALSE;

                          IF bittest(Eingabe,4) THEN vor(ADR(players[hilfe]));
                        END;
                END;
          END;
      END;

    BEGIN
      REPEAT
        aIntMSG:=NIL;
        aIntMSG:=ADDRESS(GetMSG(GameWindow^.UserPort));
        IF aIntMSG<>NIL THEN BEGIN { Der User (schon wieder?)}
                               DecodeMSG;
                               ReplyMSG(ADDRESS(aIntMSG));
                              END;
      UNTIL aIntMSG=NIL; { bis User fertig }
      CalcJoy;
    END;

  BEGIN
    OpenGameDisplay;

    DrawGameField;

    Bremser:=SpeedArray[TBase^.Speed];

    TBase^.QuitGame:=FALSE; { Noch nicht beenden }
    TBase^.Unentschieden:=FALSE;

    WITH TBase^ DO
      REPEAT
        Reagiere_auf_MSGs;

        FOR plNumber:=1 TO player DO
            BEGIN
              IF players[plnumber].comPlayer AND
                 players[PlNumber].ok THEN { Computer berechnen und vorwärts }
                   CalcPlayer(ADR(players[PLNumber]));
              IF players[plNumber].ok THEN
                 vor(ADR(players[PLNumber]));
            END;

        Loesche_Striche;
        IF level=5 THEN Male_Stein;

        Delay(Bremser); { Warten }

        Bremsen(player-remain);

      UNTIL QuitGame; { bis Spiel zuende }

    IF (TBase^.first>0      ) OR
       (TBase^.Unentschieden) THEN Lobe;{ Sieger ausgeben }

    ViewMouse(gameWindow);
    ViewMouse(MyWindow);

    IF (TBase^.first >0) AND
       (TBase^.first <7) AND
       (TBase^.remain>1) THEN WaitEsc(TBase^.first)
                         ELSE Warte;

    CloseGameDisplay;
  END;

{ Play Ende ===============================================================}
