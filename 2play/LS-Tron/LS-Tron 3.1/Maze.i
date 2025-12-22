{ Maze.i }

{$I-}

PROCEDURE Load_Maze;

  CONST Err_Loesche_Length   =   1;
        Err_Comment_2_Long   =   2;
        Err_File_2_short     =   3;
        Err_No_New_Paragraph =   4;
        Err_Element_2_Long   =   5;
        Err_File_Not_Complete=   6;
        Err_No_Mem           =   7;
        Err_File_Err         =   8;

        Err_Line_Length      =  20;
        Err_Line_2_often     =  21;
        Err_No_Line_Mem      =  22;
        Err_Wrong_Coord      =  23;

        Err_Spieler_Length   =  30;
        Err_Spieler_num      =  31;
        Err_Spieler_posX     =  32;
        Err_spieler_posY     =  33;
        Err_Spieler_DirX     =  34;
        Err_Spieler_DirY     =  35;

        Err_Level_Length     =  40;
        Err_Wrong_Level      =  41;

  PROCEDURE Get_Errorstring(ErrNum : INTEGER;VAR errStr : String);

    BEGIN
      IF Sprache=Deutsch THEN
         BEGIN
           CASE ErrNum OF
              0 : StrCpy(ErrStr,"Kein Fehler!");
              1 : StrCpy(errStr,"In #Loesche ist nur Länge 1 erlaubt!");
              2 : StrCpy(errStr,"Zu große Anzahl für Zeilen in Kommentar angegeben!");
              3 : StrCpy(errStr,"Datei zu kurz!");
              4 : StrCpy(errStr,"Neuer Abschnitt (#) erwartet!");
              5 : StrCpy(errStr,"Fehler in Zeile ???: Zu große Zeilenzahl angegeben!");
              6 : StrCpy(errStr,"Datei konnte nicht vollständig geladen werden!");
              7 : StrCpy(errStr,"Nicht genug Speicher vorhanden!");
              8 : StrCpy(errStr,"Fehler in der Datei!");

             20 : StrCpy(errStr,"Die Länge von #Linien muß durch 5 teilbar sein!");
             21 : StrCpy(errStr,"Der Abschnitt #Linien darf nur einmal pro Maze benutzt werden!");
             22 : StrCpy(errStr,"Zu wenig Speicher für #Linien vorhanden!");
             23 : StrCpy(errStr,"Wert ist nicht im richtigen Bereich!\nFarbe : 1-4\nX-Koordinate : 11-309\nY-Koordinate : 11-245");

             30 : StrCpy(errStr,"In #Spieler ist nur Länge 5 erlaubt!");
             31 : StrCpy(errStr,"In #Spieler muß ein Spieler von 1-6 angegeben werden!");
             32 : StrCpy(errStr,"In #Spieler muß die X-Position zwischen 10 und 310 liegen!");
             33 : StrCpy(errStr,"In #Spieler muß die Y-Position zwischen 10 und 235 liegen!");
             34 : StrCpy(errStr,"In #Spieler muß die X-Bewegung -1,0 oder 1 sein!");
             35 : StrCpy(errStr,"In #Spieler muß die Y-Bewegung -1,0 oder 1 sein!");

             40 : StrCpy(errStr,"In #Level ist nur Länge 1 erlaubt!");
             41 : StrCpy(errStr,"In #Level darf nur ein Wert von 0-5 stehen!");
            ELSE StrCpy(ErrStr,"Unbekannter Fehler!");
           END;
         END
        ELSE
         BEGIN
           CASE ErrNum OF
              0 : StrCpy(ErrStr,"No Error!");
              1 : StrCpy(errStr,"#Delete must have a length of 1!");
              2 : StrCpy(errStr,"#Comment cannot be longer than the file!");
              3 : StrCpy(errStr,"File to short!");
              4 : StrCpy(errStr,"New paragraph (#) expected!");
              5 : StrCpy(errStr,"Error in line ???: To big number of lines entered!");
              6 : StrCpy(errStr,"Unable to load the complete maze!");
              7 : StrCpy(errStr,"Not enough memory");
              8 : StrCpy(errStr,"Error in file!");

             20 : StrCpy(errStr,"Length of #Linien must be a number, \nwhich can be divided by 5!");
             21 : StrCpy(errStr,"#Lines mustn't appear more than one time in a maze-file!");
             22 : StrCpy(errStr,"Not enough memory for #Linien!");
             23 : StrCpy(errStr,"Value to big or to small!\nColour : 1-4\nX-Coord : 11-309\nY-Coord : 11-245");

             30 : StrCpy(errStr,"#Spieler must have a length of 5!");
             31 : StrCpy(errStr,"In #Player the playernumber must be 1-6!");
             32 : StrCpy(errStr,"In #Player the X-Coord must be 10-310");
             33 : StrCpy(errStr,"In #Player the Y-Coord must be 10-235");
             34 : StrCpy(errStr,"In #Player the X-Movement must be -1, 0 or 1!");
             35 : StrCpy(errStr,"In #Player the Y-Movement must be -1, 0 or 1!");

             40 : StrCpy(errStr,"#Level must have a length of one line!");
             41 : StrCpy(errStr,"In #Level only values between 0 and 5 inclusively are allowed!");
            ELSE StrCpy(ErrStr,"Unknown Error!");
           END;
         END;
    END;

  PROCEDURE UnLoad_Maze;

    VAR x : BYTE;

    BEGIN
      WITH TBase^ DO
        BEGIN
          Use_Maze:=FALSE;
          Maze_Loaded:=FALSE;
        END;

      WITH TBase^.MyMaze DO
        BEGIN
          Loeschen:=TRUE;
          IF LineNum>0 THEN
             FreeMem(ADDRESS(Linien),LineNum*SizeOf(Linie));
          LineNum:=0;
          FOR x:=1 TO maxplay DO
            players[x].ist_geladen:=FALSE;
        END;
    END;

  PROCEDURE Lade;

    PROCEDURE Error(error : INTEGER);

      VAR s : STRING;

      BEGIN
        s:=ALLOCSTRING(150);
        Get_Errorstring(error,s);

        IF error<>0 THEN
           BEGIN
             SetColours(TRUE);
             Show(s);
             ResetColours(TRUE);
           END;

        FreeString(s);

        WITH TBase^.MyMaze DO
          BEGIN
            Loeschen:=TRUE;
            IF Linien<>NIL THEN
               BEGIN
                 FreeMem(linien,SizeOf(Linie)*linenum);
                 Linien:=NIL;
                 LineNum:=0;
               END;
          END;

        TBase^.Use_Maze:=FALSE;
        TBase^.Maze_Loaded:=FALSE;
      END;

    FUNCTION CheckFile : INTEGER;

      VAR x,y   : INTEGER;
          zeile : STRING;
          t     : TEXT;

      BEGIN
        x:=0;
        y:=0;
        zeile:=ALLOCSTRING(255);

        Reset(t,TBase^.MyMaze.MazeName);

        READLN(t,zeile);
        x:=IOResult;
        IF NOT StrIEq(zeile,"#LS-Tron Maze") THEN x:=-1;

        WHILE (NOT EOF(t)) AND (x=0) DO
          BEGIN
            READLN(t,zeile);
            x:=IOResult;
            inc(y);
          END;
        Close(t);

        FreeString(zeile);
        IF x>=0 THEN Checkfile:=y
                ELSE Checkfile:=x;
      END;

    VAR fehler : INTEGER;
        Datei  : ^ARRAY[1..2] OF STRING;

    PROCEDURE FreeStrings(max : INTEGER);

      VAR x : INTEGER;

      BEGIN
        FOR x:=1 TO max DO
          FreeString(Datei^[x]);
      END;

    FUNCTION AllocStrings : BOOLEAN;

      VAR x : INTEGER;

      BEGIN
        FOR x:=1 TO fehler DO
          Datei^[x]:=NIL;

        x:=0;

        REPEAT
          inc(x);
          Datei^[x]:=AllocString(255);
        UNTIL (Datei^[x]=NIL) OR (x=fehler);

        IF Datei^[x]=NIL THEN FreeStrings(x-1);

        AllocStrings:=(Datei^[x]<>NIL);
      END;

    FUNCTION LeseStrings : BOOLEAN;

      VAR t   : TEXT;
          Ok  : BOOLEAN;
          x,y : INTEGER;

      BEGIN
        Reset(t,TBase^.MyMaze.MazeName);
        x:=0;
        y:=0;

        READLN(t,Datei^[1]);
        x:=IOResult;

        WHILE NOT EOF(t) AND (x=0) AND (y<fehler) DO
          BEGIN
            inc(y);
            READLN(t,Datei^[y]);
            x:=IOResult;
          END;

        Ok:=TRUE;
        IF y<Fehler   THEN Ok:=FALSE;
        IF x<>0       THEN Ok:=FALSE;
        IF NOT EOF(t) THEN Ok:=FALSE;

        Close(t);

        LeseStrings:=Ok;
      END;

    PROCEDURE Lese(maximum : INTEGER);

      VAR Zaehler : INTEGER;
          ende    : BOOLEAN;

      PROCEDURE MyError(zeile,error : INTEGER);

        VAR st,st2 : STRING;

        BEGIN
          st:=AllocString(255);
          st2:=AllocString(150);

          Get_Errorstring(error,st2);

          IF Sprache=Deutsch THEN StrCpy(st,"Fehler in Zeile ")
                             ELSE StrCpy(st,"Error in Line ");

          AddString(st,zeile);
          StrCat(st,":\n");

          StrCat(st,st2);

          FreeString(st2);

          SetColours(TRUE);
          Show(st);
          ResetColours(TRUE);

          WITH TBase^.MyMaze DO
            BEGIN
              Loeschen:=TRUE;
              IF Linien<>NIL THEN
                 BEGIN
                   FreeMem(linien,SizeOf(Linie)*linenum);
                   Linien:=NIL;
                   LineNum:=0;
                 END;
            END;

          TBase^.Use_Maze:=FALSE;
          TBase^.Maze_Loaded:=FALSE;
          ende:=TRUE;

          FreeString(st);
        END;

      PROCEDURE Bearbeite;

        PROCEDURE Springe;

          VAR x : INTEGER;

          BEGIN
            inc(zaehler);
            x:=Str2Int(Datei^[zaehler]);
            zaehler:=zaehler+x;
          END;

        PROCEDURE Load_Lines;

          VAR x      : INTEGER;
              weiter : BOOLEAN;

          BEGIN
            inc(zaehler);
            IF Str2Int(Datei^[zaehler]) MOD 5<>0 THEN MyError(zaehler,Err_Line_Length)
                                                 ELSE
               BEGIN
                 WITH TBase^.MyMaze DO
                   BEGIN
                     IF LineNum>0 THEN MyError(zaehler-1,Err_Line_2_often)
                       ELSE
                        BEGIN
                          LineNum:=Str2Int(Datei^[zaehler]) DIV 5;

                          Linien:=NIL;
                          Linien:=AllocMem(LineNum*SizeOf(Linie),MEMF_PUBLIC);
                          IF Linien=NIL THEN Error(Err_No_Line_Mem)
                                        ELSE
                             BEGIN
                               x:=1;
                               weiter:=TRUE;
                               WHILE (x<=LineNum) AND weiter DO
                                 BEGIN
                                   WITH Linien^[x] DO
                                     BEGIN
                                       inc(zaehler);
                                       colour:=Str2Int(Datei^[zaehler]);
                                       CASE Colour OF
                                         0 : colour:=1;
                                         1 : colour:=12;
                                         2 : colour:=11;
                                         3 : colour:=10;
                                        ELSE Weiter:=FALSE;
                                       END;
                                       IF weiter THEN
                                          BEGIN
                                            inc(zaehler);
                                            x1:=Str2Int(Datei^[zaehler]);
                                            IF (x1<11) OR (x1>309) THEN Weiter:=FALSE;
                                          END;
                                       IF weiter THEN
                                          BEGIN
                                            inc(zaehler);
                                            y1:=Str2Int(Datei^[zaehler]);
                                            IF (y1<11) OR (y1>245) THEN Weiter:=FALSE;
                                          END;
                                       IF weiter THEN
                                          BEGIN
                                            inc(zaehler);
                                            x2:=Str2Int(Datei^[zaehler]);
                                            IF (x2<11) OR (x2>309) THEN Weiter:=FALSE;
                                          END;
                                       IF weiter THEN
                                          BEGIN
                                            inc(zaehler);
                                            y2:=Str2Int(Datei^[zaehler]);
                                            IF (y2<11) OR (y2>245) THEN Weiter:=FALSE;
                                          END;
                                     END;
                                   inc(x);
                                 END;
                               IF NOT Weiter THEN MyError(zaehler,Err_Wrong_Coord);
                             END;
                        END;
                   END;
               END;
          END;

        PROCEDURE Set_Player;

          VAR spieler,x,y,mx,my : SHORT;

          BEGIN
            inc(zaehler);
            IF Str2Int(Datei^[zaehler])<>5 THEN MyError(zaehler,Err_Spieler_Length)
                                           ELSE
             BEGIN
               Spieler:=Str2Int(Datei^[zaehler+1]);
               x      :=Str2Int(Datei^[zaehler+2]);
               y      :=Str2Int(Datei^[zaehler+3]);
               mx     :=Str2Int(Datei^[zaehler+4]);
               my     :=Str2Int(Datei^[zaehler+5]);

               IF (spieler<1) OR (spieler>maxplay) THEN MyError(zaehler+1,Err_Spieler_Num)
                                                   ELSE
                BEGIN
                  IF (x<11) OR (x>309) THEN MyError(zaehler+2,Err_Spieler_PosX)
                                       ELSE
                   BEGIN
                     IF (y<11) OR (y>234) THEN MyError(zaehler+3,Err_Spieler_PosY)
                                          ELSE
                      BEGIN
                        IF (ABS(mx)>1) THEN MyError(zaehler+4,Err_Spieler_DirX)
                                       ELSE
                         BEGIN
                           IF (ABS(my)>1) THEN MyError(zaehler+5,Err_Spieler_DirY)
                                          ELSE
                            BEGIN
                              WITH TBase^.MyMaze.Players[spieler] DO
                                BEGIN
                                  Ist_geladen:=TRUE;
                                  pos.x      :=x   ;
                                  pos.y      :=y   ;
                                  Bewegung.x :=mx  ;
                                  Bewegung.y :=my  ;
                                END;
                            END;
                         END;
                      END;
                   END;
                END;
             END;
            zaehler:=zaehler+5;
          END;

        PROCEDURE Set_Level;

          VAR Level : SHORT;

          BEGIN
            inc(zaehler);
            IF Str2Int(Datei^[zaehler])<>1 THEN MyError(zaehler,Err_Level_Length)
                                           ELSE
               BEGIN
                 inc(zaehler);
                 level:=Str2Int(Datei^[zaehler]);
                 IF (Level<VeryEasy) OR
                    (Level>suicide ) THEN MyError(zaehler,Err_Wrong_Level)
                                     ELSE TBase^.Level:=Level;
               END;
          END;

        PROCEDURE Set_Loesche;

          BEGIN
            inc(zaehler);
            IF Str2Int(Datei^[zaehler])<>1 THEN MyError(zaehler,Err_Loesche_Length)
                                           ELSE
               BEGIN
                 inc(zaehler);
                 IF StrIEq(Datei^[zaehler],"Ja") THEN
                    TBase^.MyMaze.Loeschen:=TRUE
                   ELSE
                    IF StrIEq(Datei^[zaehler],"Yes") THEN
                       TBase^.MyMaze.Loeschen:=TRUE
                      ELSE
                       TBase^.MyMaze.Loeschen:=FALSE;
               END;
          END;

        PROCEDURE Set_Comment;

          VAR x,y : INTEGER;

          BEGIN
            inc(zaehler);
            x:=Str2Int(Datei^[zaehler]);
            IF x+zaehler<=maximum THEN
               BEGIN
                 SetColours(TRUE);
                 FOR y:=1 TO x DO
                 Show(Datei^[zaehler+y]);
                 ResetColours(TRUE);
               END
              ELSE MyError(zaehler,Err_Comment_2_Long);

            zaehler:=zaehler+x;
          END;

        BEGIN
          IF maximum-zaehler>1 THEN
           BEGIN
             IF StrIEq(Datei^[zaehler],"#Linien") THEN Load_Lines
              ELSE
              IF StrIEq(Datei^[zaehler],"#Spieler") THEN Set_Player
               ELSE
               IF StrIEq(Datei^[zaehler],"#Level") THEN Set_Level
                ELSE
                IF StrIEq(Datei^[zaehler],"#Lösche") THEN Set_Loesche
                 ELSE
                 IF StrIEq(Datei^[zaehler],"#Kommentar") THEN Set_Comment
                  ELSE
                  IF StrIEq(Datei^[zaehler],"#Lines") THEN Load_Lines
                   ELSE
                   IF StrIEq(Datei^[zaehler],"#Player") THEN Set_Player
                    ELSE
                    IF StrIEq(Datei^[zaehler],"#Delete") THEN Set_Loesche
                     ELSE
                     IF StrIEq(Datei^[zaehler],"#Comment") THEN Set_Comment
                      ELSE Springe;
           END
           ELSE MyError(zaehler,Err_File_2_Short);
        END;

      VAR oldMax : INTEGER;

      BEGIN
        oldMax:=maximum;

        WHILE StrLen(Datei^[maximum])=0 DO
          maximum:=maximum-1;

        Zaehler:=0;
        ende:=FALSE;
        REPEAT
          inc(zaehler);
          IF StrNEq(Datei^[zaehler],"#",1) THEN Bearbeite
                                           ELSE MyError(zaehler,Err_No_New_Paragraph);
        UNTIL (Zaehler>=Maximum) OR ende;
        IF zaehler>OldMax THEN Error(Err_Element_2_Long);
      END;

    BEGIN
      WITH TBase^ DO
        BEGIN
          Use_Maze:=TRUE;
          Maze_Loaded:=TRUE;
        END;

      SetColours(TRUE);
      WITH TBase^.MyMaze DO
        FileRequest("Lade Labyrinth",MazeDir,MazeName);
      ResetColours(TRUE);

      IF StrLen(TBase^.MyMaze.MazeDir)+1>=StrLen(TBase^.MyMaze.MazeName) THEN Error(0)
                                                                         ELSE
         BEGIN
           Fehler:=CheckFile;
           IF Fehler<=0 THEN Error(Err_File_Not_Complete)
                        ELSE
             BEGIN
                Datei:=NIL;
                Datei:=AllocMem(fehler*SizeOf(STRING),MEMF_PUBLIC);
                IF Datei=NIL THEN Error(Err_No_Mem)
                             ELSE
                   BEGIN
                     IF NOT AllocStrings THEN Error(Err_No_Mem)
                                         ELSE
                        BEGIN
                          IF NOT LeseStrings THEN Error(Err_File_Err)
                                             ELSE Lese(fehler);
                          FreeStrings(fehler);
                        END;
                     FreeMem(Datei,fehler*SizeOf(String));
                   END;
             END;
         END;

      IF TBase^.Maze_Loaded THEN
         BEGIN
           IF Sprache=Deutsch THEN Show("Labyrinth erfolgreich geladen!")
                              ELSE Show("Maze has been loaded succesfully!");
         END;
    END;

  FUNCTION Sicherheitsabfrage : BOOLEAN;

    BEGIN
      IF Sprache=Deutsch THEN
         Sicherheitsabfrage:=Ask("Geladenes Labyrinth geht verloren!")
        ELSE
         Sicherheitsabfrage:=Ask("Current Maze will be lost!");
    END;

  BEGIN
    IF TBase^.Maze_loaded THEN
       BEGIN
         SetColours(TRUE);
         IF Sicherheitsabfrage THEN
            BEGIN
              Unload_Maze;

              Lade;
            END;
         ResetColours(TRUE);
       END
      ELSE Lade;
  END;

{$I+}
