PROGRAM Getem (Input,Output);

{ © By M. Illenseer 1990/1991                                                }
{ Überarbeitete Version 1.0 , 15.9.1991                                      }
{ Erstellt mit Kickpascal V1.1 und V2.0 , thanx to the Himpire !             }
{ Achtung! Vor Compilierung ist auf die Größe des Speichers von Kickpascal   }
{ zu achten ! Es werden wohl mindestens 200 kB benötigt.                     }
{ Einziges Compilerflag sollte 'Stackgröße' sein.                            }
{ Diese Source ist nicht (in vorliegender Form) kompilierfähig unter KP 1.1. }
{ Ab Version KP 2.0 gibts aber jetzt Option Flags, und die setze ich jetzt ! }

{$opt q,s+}  { Nur auf Stackgröße testen }

USES ExecSupport, ExecIO, Intuition, Graphics;
{$incl "intuition/intuitionbase.h","graphics/gfxbase.h" }

{ Werden für die Fonts, IntBase und GfxBase benötigt}

{ Wir haben hier jede Menge Grafik !                }
{ Benutzt werden dabei auch Exec1 und Graphtype.    }
{ Siehe Linker ! Wenn hier viel probiert wird, dann }
{ Pfad richtig einstellen !                         }

{ In GetemSound.m sind Proceduren zum Laden und     }
{ Abspielen eines 8SVX-Sounds. Dieses Module ist    }
{ speziell fuer Getem (um)programmiert, kann aber   }
{ leicht geändert werden .                          }

{$link 'getem:GetemSound.o'}

{Wenn hier die Fehlermeldung kommt, daß das MODUL 'getemsound.m' nicht }
{existiert dann muß GetemSound.m kompiliert und als Objektdatei abge-  }
{speichert werden ! (GetemSound.o) Oder aber der Pfad muß geändert werden. }

{$incl "workbench/startup.h"}

{ Dieses Include brauchen wir, wenn in der Procedure ChkParam die }
{ Startup-Msg benötigt wird. }


TYPE                      { Ein paar Typen kann ich leiden ... }
  GetPlane  = ARRAY[1..90] OF WORD;               { 6*15 = 90 Typ für Getemimage }
  Plane     = ARRAY[1..20] OF WORD;               { Typ für Blockdata  }
  ImgDatTyp = ARRAY[1..14] OF LONG;               { Typ für Imagedata  }
  Spiel     = ARRAY[0..13,0..13] OF WORD;         { Typ für Spielfeld  }
  Level     = ^LevelList;                         { Pointer auf Struktur }
  LevelList = RECORD Lev: ARRAY[0..195] OF CHAR;  { Spielfeld =0..13,0..13=196 Blöcke }
                     Name: String[80];            { Name des Levels }
                     Score: Integer;              { Aktueller Score des Levels  }
                     Next: Level;                 { Zeiger auf nächsten Level  }
              END;

CONST
  VERSION2 = 'Version 1.0 ';                      { Eyh! Nicht ändern ! }
  NoCursor = ''\e'0 p';                           { Cursor abschalten mit WRITE  }
  CLS = ''\e'c '\e'0;0H';                         { ClearScreen  }
  {Debug = 'YES';}          { Klammern löschen, wenn Debug erwünscht, dann   }
                            { erfolgen diverse Ausgaben auf der Console.     }
                            { Also auf dem aktuellem CLI oder in KickPascal. }
                            { ! Achtung ! Nicht von WB möglich ! }

  { Konstanten erleichtern das Leben...  }
  WAIT = TRUE;       { Flag ob auf Messages gewartet werden soll }
  NOWAIT = FALSE;    { oder eben nicht gewartet werden soll}
  NOTHING = -1;      { Wenn keine Message erfolgte }
  START = 1;         { Das Gadget 'start' wurde gedrückt }
  TASTE = 2;         { Es wurde eine Taste gedrueckt }
  TICK = 3;          { Es wurde ein Tick (Zeit) geliefert }
  WINACT = 4;        { Das Window wurde (re)aktiviert }
  WININACT = 5;      { Das Window wurde inaktiviert }
  ICON = 6;          { Das Gadget 'icon' wurde gedrückt }
  Stop = 7;          { Das Gadget 'stop' wurde gedrückt }
  LEFT = 8;          { Die Maus wurde links gedrückt }
  REGO = 9;          { Das Gadget 'rego' wurde gedrückt }
  RIGHT = 11;        { Die Maus wurde rechts gedrückt }
  MIDDLE = 12;       { Die Maus wurde in der Mitte gedrückt !! (Für 3-Tasten-Mäuse) }
  SCOR=12 ;          { Das Gadget 'score' wurde gedrückt }

VAR
  BarHeight,FSize,
  x, y, Q, P,key,s,T,
  time,posX,PosY,
  PX,PY,AnzLev,AktLev : INTEGER;            {  Laufvariablen und Diverse  }
  Score               : LONG;               {  Highscore in LONG!?  }
  Load                : String;             {  Name des Level-Files }
  TStr,TStr1          : String;             {  Temopärer String }
  InitDone,                                 {  Flag für getane Arbeit }
  Ende,Demon,Gamen,GameOn,                  {  Flags für aktuellen Status  }
  NoSound,ScWindow    : BOOLEAN;            {  und Ende des Prog.  }
  HiScore             : Array[1..10] OF INTEGER; {  HiScore Liste  }
  Feld                : Spiel;              {  Feld für Blockmarkierung  }
  Getem,                                    {  GetemImage  }
  Imggad1, Imggad2,                         {  Die diversen Images ... }
  Imggad3, Imggad4,
  Imggad5, Imggad6,
  Imggad7, Imggad8,
  Imggad9, Imggad10   : Image;              {  Start, Stop, ReGo, Score Gadget-Images  }
  Img                 : ARRAY[0..14] OF Image; {  15 Block Images }
  Gad1, Gad2, Gad3,
  Gad4, Gad5          : Gadget;             { Start,Stop,ReGo,Score Gadget }
  IT                  : IntuiText;          { Text Start/Stop Gadget , für GfxText }
  MyFnt               : TextAttr;           { Für IntuiText }
  Cpy,Stufe,First     : Level;              { Kopie, 1. Level und aktueller Level }
  Msg,Mesg            : ^IntuiMessage;      { Signalmessage des Windows }
  IDt1, IDt2,
  IDt3, IDT4,
  IDt5                : ^ImgDatTyp;         { Pointer für Images }
  AktGad              : ^Gadget;            { Pointer für Gadgettyp }
  Win,ScWin           : ^Window;            { Pointer für Windows }
  Con,Con1            : ^Ptr;               { Pointer für Consol-Windows }
  Dat                 : ARRAY [0..14] OF ^Plane; { Pointer für Blockimages }
  MouseDat,BusyMDat   : ^Plane;             { Pointer für Mousezeiger }
  GetDat              : ^GetPlane;          { Pointer für GetemImage }
  rp                  : ^RastPort;          { RastPort des Windows }
  IntBase             : ^IntuitionBase;     { Base der Intuition }
  GfxBase             : ^GraphicsBase;
  OLock               : BPTR;               { Zeiger auf Filestruktur }
  Label TheEnd;       { Tja, eigentlich gehts auch ohne Labels, ist nur
                       schneller mit einem... und hier auch erlaubt !
                       (Wo sind Labels schon erlaubt in Pascal ?)      }

{ Soweit die Variablen, laßt Euch nicht abhalten das Listing durchzulesen !}
{ Fangt am besten mit dem Hauptprogramm an ! Dann erst die Funtionen und    }
{ Proceduren ! Hier sind genug Beispiele für Grafiken dabei ! }

Function  PlaySinit(Filename:String):boolean; Import;
Procedure EndPlay; Import;
Procedure Piep; Import;

{ Diese Funktionen und Proceduren sind im Modul GetemSound.m vereinbart }
{ Ist dieses Modul nicht vorhanden, oder wird Getem umgeschrieben, so}
{ muß auch die Procedure Beep verändert werden (s. Kommentare). }


PROCEDURE Beep(a:INTEGER);
{ a gibt Art des Sounds an, hier sind nur 2 implementiert ... }
{ Also, hier sollte mal ein richtiger Sound hin, wer Lust hat soll es programmieren. }
{ Wichtig ist, das GetemSound nicht zuz lang ist, ca. 1 Sekunde Sound sollte ausreichen. }
BEGIN
  IF NoSound THEN  { Es gibt ein Flag NoSound, welches man hier einsetzen kann. }
                   { Also einen Sound wenn NoSound gesetzt, und einen, wenn }
                   { gelöscht (=FALSE) ! }
     Case a of     { Man kann hier mehrere Sounds abspielen... }

     1: Piep;  { Aus MODUL GetemSound, wenn nicht da, dann ausklammern }
     2: ;      { Hier eine andere Prozedur anhängen, wenn erwünscht }
               { Diese muss im Modul GetemSound.m definiert sein, um 8SVX Files lesen zu können }
     otherwise ;   { Nix ! }
     end
  ELSE
     DisplayBeep(Nil); { Es soll Leute geben, die 'InstallBeep' einsetzen ! }
                       { Dann kommt hier auch ein Sound raus ! }
end;

PROCEDURE  LoadLevels(a,b:INTEGER);
{ Hier wird nun eine externe Datei geladen, die ein paar Levels enthalten sollte. }
{ Es könnte Schwierigkeiten geben, wenn Getem von der Workbench gestartet wird. }
{ Ich habe nicht gewollt, dass man mehrere Level-Files mit Shift-Klick }
{ mit übergibt. Siehe auch 'GetParam' }

VAR fn   : file of char;            { Filehandle (hätte auch File of TEXT sein können)  }
    t,c  : STRING;                  { String bis EoLn }
    L    : array [0..13] of String; { Levelgröße }
    i, j, Anz, z
         : INTEGER;                 { Laufvariablen }
    tmp  : Level;                   { Pointer, Level werden dynamisch }
                                    { gelesen, somit 'unbegrenzt' viele Level möglich ! }
    w    :^Window;                  { Neues Window , für Ladeanzeige }
    it   : IntuiText;               { Lokaler TextPointer }
    r    :^RastPort;                { Pointer auf Window }
    Err  : Boolean;                 { Fehlerflag }
    Leer : String ;                 { Leerstring }

 PROCEDURE Errors(Error:Boolean);
 { Ausgabe von Fehlern: LeseFehler, File nich vorhanden, falsche FileStruktur }
   BEGIN
      it :=  IntuiText(3,0,1,0,0,^Myfnt,Leer,Nil);
      PrintIText(r, ^it,170-StrLen(t)*4,3); { Text löschen }
      t:='Can´t find the Level-File:'+Load;
      IF (StrLen(t)>42) THEN t := Copy(t,1,40)+'..';
      it :=  IntuiText(2,0,1,0,0,^Myfnt,t,Nil);
      PrintIText(r, ^it,170-StrLen(t)*4,3); { Ausgabe von: FILE NOT FOUND }
      Delay(50);                            { Ne Sekunde warten }
      it :=  IntuiText(3,0,1,0,0,^Myfnt,Leer,Nil);
      PrintIText(r, ^it,170-StrLen(t)*4,3);
      IF Error=False THEN Begin
       t:='File-Error #: '+intstr(IOresult); { Ausgabe des DOS-Errors }
       IF (StrLen(t)>42) THEN t := Copy(t,1,40)+'..';
       it :=  IntuiText(2,0,1,0,0,^Myfnt,t,Nil);
       PrintIText(r, ^it,170-StrLen(t)*4,3);
       t:='Making Random-Levels. Read Doc-File!'; { Ausgabe, daß Getem Zufalls-Level baut }
       it :=  IntuiText(3,0,1,0,0,^Myfnt,t,Nil);
       PrintIText(r, ^it,170-StrLen(t)*4,10);
      end
      ELSE
      Begin
       Close(fn); { File zu. Falsches Format. }
       t:=' Wrong Level File Struktur !! '; { Falsche Filestruktur ! }
       it :=  IntuiText(2,0,1,0,0,^Myfnt,t,Nil);
       PrintIText(r, ^it,170-StrLen(t)*4,3);
       t:=' EXIT GAME ! DANGER ! '; { Ausgabe, daß Getem verlassen wird ! }
       it :=  IntuiText(3,0,1,0,0,^Myfnt,t,Nil);
       PrintIText(r, ^it,170-StrLen(t)*4,10);
      end;
      Stufe :=  NIL;                        { Kein Level da! }
      First :=  NIL;                        { Auch kein erster }
      Delay(5*60);                          { 5 sekunden warten }
   END; { errors }


BEGIN
   AnzLev :=0; { Ist klar, erst mal auf Null setzen }
   Err:=False; { Fehlerfalg false = kein Fehler }
   Leer:='                                         '; { Leerstring }
   { Mache kleines Window auf, indem angezeigt wird, das Getem die Levels lädt. }
   W :=  Open_Window(Win^.LeftEdge+30,Win^.TopEdge+140,    { Oben links und rechts , abhängig vom Basisfenster}
                     340,20,                               { Breite Höhe }
                     1,                                    { Farbe }
                     ACTIVEWINDOW,RmbTrap,                 { IDCMP-Flags und Traps}
                     Nil,Nil,                              { ScreenPointer unwichtig...}
                     0,0,0,0);                             { Das hier auch, das Window kann ja nicht bewegt werden...}

   r := w^.RPort; { Setze Window-Pointer }
   TStr:=' Get´em ! '+VERSION2+' A Game by M. Illenseer. LoadWindow';
   SetWindowTitles(w,Nil,TStr);
   SetPointer(w,BusyMDat,8,8,-9,-4);
   SetPointer(win,BusyMDat,8,8,-9,-4);
   { Mehr zu SetWindowTitles und SetPointer siehe Procedure Init }

   t := 'Loading: '+Load; { Intuitext verträgt keine temporären Strings. Load ist File-Name. }
                          { Default ist GETEMLEVELS, kann aber per Parameter angegeben werden. }
   IF (StrLen(t)>42) THEN t := Copy(t,1,40)+'..';  { Jups. String darf nicht zu groß werden... }
   it :=  IntuiText(3,0,1,0,0,^MyFnt,t,Nil);
   PrintIText(r, ^it,170-StrLen(t)*4,3);  { Ausgabe von: Loading: ..LEVELS  }
   Assign(fn, Load);                      { Gutes altes ISO-Pascal... Setze Pointer auf File }
   Reset (fn);                            { Load = Parameter-Name oder einfach 'GetemLevels' }
   IF EOF(fn) or (IOResult<>0) THEN       { Wenn File leer (!) oder sonstiger Fehler }
    Errors(False)
   ELSE                                     { Ok. File gefunden }
   BEGIN
      Buffer(fn, 4000);                     { Neue Puffer-Funktion von KP 2.0X }
      { OHNE DIESE FUNKTION WIRD DIE LADEROUTINE ZUR GEDULDPROBE ! }
      { Wird der Puffer erhöht, ergibt sich kein grosser Geschwindigkeits }
      { Vorteil, und der Stack muss entsprechend erhöht werden ! }
      AnzLev:=1;                            { Also wenigstens 1 Level ! }
      Anz := 0;z := 5;                      { z ist nur ne Laufvariable für die Lade-Kontroll-Punkte }
      New (Stufe);                          { Absolut neue Stufe }
      First :=  Stufe;                      { Baue Struktur auf }
      FOR i :=  0 TO 13 DO                  { Lese 13 (Getem-)Blöcke ein }
      BEGIN
         READLN(fn, c);                     { Jetzt einlesen mit readln, da wird mir schon schl%&*t ! }
         FOR j :=  0 TO 13 DO
            IF c[j+1] IN ['0'..'8'] THEN Stufe^.lev[i+j*14]:=c[j+1]     {  Lese ersten Level in die Ringstruktur ein }
            ELSE Begin Stufe^.lev[i+j*14] := '0'; Err := True; end;
      END;
      READLN(fn,Stufe^.Name);               { Schön, der Level-Name ist auch da ! }
      Stufe^.Score := 0;                    { Natürlich kein Score da ! }
                                            { Eigentlich könnte ja hier ein Readln für einen Score hin}
                                            { Aber das würde eine Speicher-Procedure erfordern...}
      WritePixel(r,5,17);                   { Jeder Punkt ein Level... }
      WHILE not EOF(fn) DO                  { weitermachen bis kein Level mehr da ! }
      BEGIN
         New(tmp);                          { Stufe ist schon voll, deshalb neue Struktur tmp }
         Anz := Anz +2;                     { Mehr Level! }
         FOR i :=  0 TO 13 DO
         BEGIN
            READLN(fn, c);                  { Einlesen einer ganzen Zeile }
            FOR j :=  0 TO 13 DO            { Die ersten 13 Buchstaben interpretieren }
               IF c[j+1] in ['0'..'8'] THEN tmp^.lev[i+j*14] := c[j+1]  {  Lese weitere Level  }
               ELSE Begin Stufe^.lev[i+j*14] := '0'; Err:=True; End;
         END;
         READLN(fn, tmp^.Name);             { Level Name einlesen }
         tmp^.Score := 0;
         WritePixel(r,z+Anz*2,17);          { Ladekontrollpixel }
         IF Anz>165 THEN BEGIN
           z := 6;
           Anz := 2;
         end; { 165= Breite_Fenster*2 }
         Stufe^.Next :=  tmp;
         Stufe :=  tmp;                     { Hops, jetzt Struktur umhängen ! }
         AnzLev := AnzLev +1;               { Noch mehr Levels }
      END; {  WHILE  }
      stufe^.Next :=  First;                { Struktur verlängern und umhängen! }
      Close(fn);                            { File zu! }
      Stufe :=  First;
      Cpy := First;                         { Nach dem letzten Level kommt wieder der Erste ! }
  END; { IF konnte geöffnet werden  }
  If Err=True THEN  { Filestruktur falsch !!! (Blödsinn eingeladen ?)}
   Begin
    Errors(True);             { Fehlerroutine mit Parameter für falsche Filestruktur }
    Delay(25);
    CloseWindow(w);           { Fenster zu }
    OLock:=CurrentDir(OLock); { Zurück ins alte Directory }
    Goto TheEnd;              { Abbruch }
  End;
  NoSound:=Not PlaySinit('GetemSound');     { LadeRoutine für Sound aus MODUL GetemSounds }
  If NoSound then Begin                     { Wow! Endlich ! Ein wenig Sound ! }
   t:='    Could not load SoundFile !       '; { Mist, kein SoundFile da ! }
   it :=  IntuiText(2,0,1,0,0,^Myfnt,t,Nil);
   PrintIText(r, ^it,170-StrLen(t)*4,3);     { Ausgabe daß das Sound-File nicht da ist }
   t:='   Going to use Flash instead...     '; { Wenn 'InstallBeep installiert ist, bekommen wir auch Sound :-) }
   it :=  IntuiText(3,0,1,0,0,^Myfnt,t,Nil);
   PrintIText(r, ^it,170-StrLen(t)*4,10);   { Ausgabe daß das Sound-File nicht da ist }
   Delay(2*50);                             { 2 sekunden warten , damit Msg ausgegeben werden kann }
  end; {NoSound}
  t:='              Game Ready !              ';
  it :=  IntuiText(3,0,1,0,0,^Myfnt,t,Nil);
  PrintIText(r, ^it,170-StrLen(t)*4,10);   { Ausgabe OK! }
  Delay(25); { Anzeigezeit }
  Close_Window(w);                          { Fenster zu }
  SetPointer(win,MouseDat,8,8,-9,-4); { Setze normalen Mousepointer }
  OLock:=CurrentDir(OLock);  { In das alte Direktory zurück gehen }
END; { loadlevels }

PROCEDURE HiPrint;
{ Ausgabe der Highscores. Aufgrund der Ringstruktur der Levels kann ich (noch nicht) den }
{ vorherigen Level-Score nicht ausgeben. Die Lösung mit dem Console-Window ist }
{ nicht schön... aber wie soll ich es sonst machen ? }
Var tp,p,q   :INTEGER;   { Nur ein paar Laufvariablen }
    t        : Level;    { Ein Pointer auf den 1. Level }
     ht,c    :STRING;    { Ein paar strings }

BEGIN
 IF SCWINDOW = TRUE THEN                    { Ist das Fenster für die Scores schon offen ? }
 BEGIN
  c:='               ';                     { Leerstring }
  ht := '                   '+chr(10);      { Leere Zeile mit CR }
  FOR q := 1 TO 10 DO                       { Fenster sozusg. löschen }
   WriteCon(Con1, ht);
  WriteCon(Con1, CLS);                      { und ein CLS hinterherjagen }
  New(t);
  t := Stufe;                               { Kopie anfertigen }
  IF AnzLev<=9 THEN                         { Hamwa mehr als 9 Level ? }
   q:=AnzLev
  ELSE q:=10;                               { Sind mehr als 10 Level da ! }
  For p := 1 to q do                        { Ausgabe aller LevelNamen und Scores }
  BEGIN                                     { Abschneiden der Namen, kann nur 11 Zeichen ausgeben }
   t := Stufe;
   for tp := 1 to p do t := t^.Next;
   IF Length(t^.Name)<20 THEN ht:=t^.Name+Copy(c,1,20-Length(t^.Name))
                         ELSE ht:=Copy(t^.Name,1,20);
   ht := ht+':'+IntStr(t^.Score)+chr(10);   { Namen und Score in String }
   WriteCon(Con1, ht);                      { Ausgabe Level und Score }
  END; { For }
  t:=t^.Next;                               { Umhängen auf nächsten Level }
  IF Length(t^.Name)<20 THEN ht:=t^.Name+Copy(c,1,20-Length(t^.Name))
                        ELSE ht:=Copy(t^.Name,1,20);
  ht := ht+':'+IntStr(t^.Score);
  WriteCon(Con1, ht);
 END; { SCWINDOW da }
END; { HiPrint }

PROCEDURE HILIST;
{ Hier wird geschaut, ob das Fenster für die Sores offen ist, wenn }
{ ja, dann werden die Scores ausgegeben, sonst wird daß Fenster geschlossen. }

VAR t,p,q,r,s:integer;                        { Nur son paar Laufvariablen }
CONST WinX = 216;                           { Fenster soll nich größer als 216 = 26*8sein, kann verändert werden ... }

BEGIN
 IF SCWINDOW = TRUE THEN { Flag gibt an, ob schließen oder öffnen des ScoreWin }
 BEGIN
   SCWINDOW := FALSE;                       { Fenster da, also schließen und Flag negieren }
   CloseConsole(Con1);                      { console zu }
   Close_Window(SCWIN);                     { Fenster zu }
 END { then }
 ELSE
 BEGIN
   SCWINDOW := TRUE;                        { Fenster n. existent, also öffnen }
   q := win^.leftedge; s:=win^.width;       { Abhängig vom Hauptfenster }
   r := win^.wscreen^.width;                { Immer schön ordentlich neben dem Hauptfenster }
                                            { Damit auch unter Dos 2.0 oder unter MegaWB alles läuft }
   IF (q+s>r-WinX+WinX/5) THEN p := q-WinX-5{ links vom Fenster noch Platz ?}
   ELSE p := q+s+5;                         { sonst eben rechts }
   IF p<0 THEN REPEAT p:=p+5 UNTIL p>0;
   IF p+WinX>r THEN REPEAT p:=p-5 UNTIL p+WinX<r;
{$IF DEF Debug } { Zur Kontrolle auf die Console ausgeben }
   Writeln('Sizes: ScoreWin:',p,' Game:',q,' Screen:',r);
{$ENDIF }
   q :=win^.topedge+14;                     { win ist Pointer auf das Haupfenster }
   t := (FSize+1)*11;                       { Ohauer ? Ist der Default-Font zu gross ? Dos 2.0 ? }
   if q+t>s then repeat Dec(q) until (q=0) or (q+t<=s); { Wenn ja Fenster vergrössern ..}
   SCWIN :=  Open_Window(p,q, { Gleiche Höhe wie Hauptfenster }
                         WinX,t,
                         1,
                         GADGETUP,Windowdrag+WindowDepth+RMBTrap, { Kein Resize }
                         Nil,Nil,                                 { RMBTrap, damit kein hässlicher Balken erscheint, wenn }
                         0,0,0,0);                                { jemand R-Mouse drückt }
   { Auf das Fenster ! }
   TStr:=' Get´em ! '+VERSION2+' A Game by M. Illenseer. ScoreWindow ';
   SetWindowTitles(SCWIN,'  Get´em Scores  ',TStr);
   SetPointer(SCWIN,MouseDat,8,8,-9,-4);
   Con1 := OpenConsole(SCWIN);               { als Console öffnen }
   WriteCon(Con1, NoCursor);                 { Cursor löschen }
   HiPrint;                                  { Ausgabe der Scores }
 END; { if scorewin }
END; { Hilist }

PROCEDURE Iconify; Forward;
{ Tja, da in Iconify auch'n Aufruf einer Funktion ist, die noch nicht deklariert ist... }
{ muß ich wohl oder übel zum Forward greifen, ich habe keine Lust alles neu }
{ zu schreiben... }

FUNCTION ChkFeld:Byte;Forward;
{ Gilt auch hier... }


PROCEDURE DrBlk(x,y:INTEGER,z:WORD);
{ Zeichnet einen Getem-Block an der Koordinate x,y ,wobei x,y umgerechnet }
{ werden auf Bildschirmkoordinate, wenn z>0dann wird gezeichnet, sonst  }
{ gelöscht. }
VAR TX,TY:INTEGER;
BEGIN { DrBlk }
 IF (x >= 14) or (x <  0) or (y >= 14) or (y <  0) THEN
 { Erstmal schauen, ob denn hier auch korrekte Werte ankommen... }
   BEGIN
    { Hier stand mal eine Error-Routine... Ist entfallen, da keine Fehler mehr }
    { aufgetreten sind.... und ich habe vergessen WAS hier stand, ich hätte ja }
    { wenigstens ein if def Debug drinlassen können ... :-)  }
   END
  ELSE
   BEGIN
     IF z>0 THEN
         BEGIN { Block malen }              { XOffset=20, YOffSet=40, ImageXSize=21, ImageYSize=11 }
         DrawImage(RP,                      { RastPort auf Window }
                   ^Img[z],                 { Pointer auf zu malendes Image }
                   20+x*21,40+y*11+BarHeight{ x und y umrechnen auf Window }
                  );                        { So einfach ist das... :-) }
         Feld[x,y] :=  z;                   { Und im Array auch setzen... }
       END
     ELSE
       BEGIN { Block löschen }
         IF GAMEON=True THEN BEGIN
          DrawImage(RP,^Img[14],20+x*21,40+y*11+BarHeight);
          Delay(1);
         END;
         DrawImage(RP,^Img[0],20+x*21,40+y*11+BarHeight); { Null-Block }
         Feld[x,y] :=  0; { = gelöscht }
       END
   END
END; { DrBlk }

PROCEDURE ClFeld;
{ Löschprozedur fuer Feld-ARRAY }
VAR x,y:INTEGER;
BEGIN { ClFeld }
  FOR y :=  0 TO 13 DO
   FOR x :=  0 TO 13 DO
    Feld[x,y] :=  0;                        { Wenn 0, dann leer }
END; { ClFeld }

PROCEDURE DrFeld;
{ Male gesamtes Feld }
VAR x,y:INTEGER;
BEGIN { DrFeld }
 FOR y :=  0 TO 13 DO
   FOR x :=  0 TO 13 DO
     BEGIN
       DrBlk(x,y,Feld[x,y]);                { Aufruf Malen eines Blocks }
     END
END;

{$IF DEF Debug }
PROCEDURE WrFeld;
{ Kontrollprozedur für Feld, nur wichtig, wenn Debug gesetzt }
VAR x,y:INTEGER;
      z:STRING;
BEGIN
 Page;   { Bildschirm löschen }
 FOR y :=  0 TO 12 DO
 BEGIN
  FOR x := 0 TO 10 DO
   WRITE(Feld[x,y]);                         { Ausgabe vom Feld }
  WRITELN;
 END
END;
{$ENDIF }

FUNCTION SomethingPressed(quest:BOOLEAN):INTEGER;
{ Abfrage auf Gadgets und Events allgemein. Jedes Gadget wird hier abgefragt, }
{ auch Ticks werden zurückgegeben. Ist quest=TRUE dann wird auf eine Msg }
{ gewartet. Sonst geht das Spiel weiter. Zurückgegeben wird eine Zahl, die }
{ Info über das gedrückte Gadget liefern und auch TastenCodes angibt. }
{ Siehe auch Constantendeklaration. Als Globale Variable gibt Key den Wert }
{ der zuletzt gedrückten Taste aus. }

VAR class,                                  { (Art) Klasse der Message }
    gadid,                                  { ID - Nummer des Gadget }
    gadadd,
    code:INTEGER;                           { Tastendruck }

 BEGIN { SomethingPressed }
     SomethingPressed :=  NOTHING; { Default von -1, damit wenigstens etwas rauskommt }

     IF quest = WAIT THEN Msg :=  Wait_Port(Win^.UserPort); { Warten BIS eine Message kommt, aber kein busy-Wait ! }
     Msg :=  Get_Msg(Win^.UserPort); { Message abfragen, kommt aus dem Window Meldung? }

     IF NOT(Msg = Nil) THEN  { Ne Message da ? }
      BEGIN { Keine Meldung: Msg = NIL }
        Case Msg^.Class OF                  { Class = Was wurde gedrückt ? Geht gut mit Case }
          _CLOSEWINDOW: BEGIN ENDE :=  TRUE; SomethingPressed :=  0 END;
              { Closewindow sollte Spiel beenden }
          GADGETUP,GADGETDOWN: { Ein Gadget wurde gedrückt! (oder wieder losgelassen) }
                BEGIN
                  AktGad :=  Msg^.IAddress; { Pointer auf Addresse von Gadget }
                  Case AktGad^.GadgetID OF  { welches Gadget? Nummer }
                   1: { 1. Gadget = Start }
                        SomethingPressed :=  START;
                   2: { 2. Gadget = ICONIFy  }
                        Somethingpressed :=  ICON;
                   3: { 3. Gadget = Stop }
                        SomethingPressed :=  Stop;
                   4: { 4. Gadget = ReGo  }
                        SomethingPressed :=  REGO;
                   5: { 5. Gadget = Score  }
                        SomethingPressed :=  SCOR;
                  Otherwise; { Nix ansonsten... Mehr hamwa nich }
                  END  {  inneres CASE für Nummer Gadget }
                END;
          RAWKEY: { Also kein gadget, sondern ne Taste }
                BEGIN
                  SomethingPressed :=  Taste;
                  Key :=  Msg^.Code;
                END;
          INTUITICKS: { Keine User-Eingabe, sondern ein SystemTick (=1/50 sekunde }
                BEGIN
                  SomethingPressed :=  TICK;
                END;
          ACTIVEWINDOW: { Wenn das Fenster verlassen wurde, müssen die Gadgets }
                        { re-initialisiert werden. }
                BEGIN
                  RefreshGadgets(Win^.FirstGadget, Win, Nil);
                  SomethingPressed :=  WINACT;
                END;
          INACTIVEWINDOW: { Fenster wird verlassen, Gadgets refreshen }
                BEGIN
                  RefreshGadgets(Win^.FirstGadget, Win, Nil);
                  SomethingPressed :=  WININACT;
                END;
          MOUSEBUTTONS: { Achja, ne Maustaste haben wir auch noch ! }
                IF (Msg^.Code and $80) = 0 THEN    { Hier wird der Code mit $80 ge-and-et , das liefert ne 0 wenn ne Taste gedrückt wurde }
                     BEGIN
                       CASE Msg^.Code OF
                        104: SomethingPressed := LEFT;
                        106: SomethingPressed := MIDDLE; { !!! Mittlere Maustaste ! Wird nicht benötigt}
                        105: SomethingPressed := RIGHT;
                       end;
                     END;
     Otherwise; { Nix. Mehr will ich ja nicht }
    END; {  OF CASE für Was wurde gedrückt? }
    Reply_Msg(Msg);   {Die Message zurueckgeben}
  END; { Not Msg = NIL }
  IF BREAK(1) THEN BEGIN WRITELN('Getem: ** User Break with Ctrl-C!'); Goto TheEnd; End;
  IF BREAK(2) THEN BEGIN WRITELN('Getem: ** User Break with Ctrl-D!'); Goto TheEnd; End;
  { Ach! Hier wird das Label TheEnd benötigt ! Hier wird ein User-Break abge- }
  { fragt. Wenn von Cli aufgerufen, und mit 'Break Task-# [cd]' gestoppt }
 END; { SomethingPressed }

PROCEDURE Ausgabe(t: Str;x,y:INTEGER);
{ gibt den Text "t" im Window-Getem an Position x,y aus  }
VAR it: IntuiText;
BEGIN
   it :=  IntuiText(1,0,1,0,0,^Myfnt,t,Nil);   { Hab ich kein Bock zu erklären }
   PrintIText(RP, ^it, x,y+BarHeight)          { PrintIText = GfxText oder Text, kollidiert mit Pascal-Typ 'TEXT' }
END;


PROCEDURE InitDemo; { Die Demo wird nur ganz am Anfang gebraucht...(vor Laden) }
BEGIN
 ClFeld; { Lösche Feld }
    FOR y :=  1 TO 13 do
      FOR x :=  Random(10) downto 0 Do
        Feld[y,13-x] :=  Random(8);         { Ein Zufallswert 0..7 }
 DrFeld;
END;

PROCEDURE Demo;
Var a,b:integer;
    w:string;
{ Eine kleine Demo der purzelnden Blöcke... }
BEGIN { Demo }
{$IF def debug }   { CONST DEBUG ist ganz oben zu setzen !!! }
   WrFeld;
{$ENDIF } { Dieses debug stammt noch aus den Anfangszeiten, als Getem immer }
           { wieder abschmierte... da die Pointer mal wieder ins Nil zeigten... }
   IF AnzLev=0 THEN
      DrBlk(Random(14),Random(14),Random(8))
      { ^ Diese Zeile macht ne gaaanz einfache Demo ... mir zu doof ! :-) }
   ELSE Begin
    FOR a :=  0 TO 13 do
       FOR b :=   0 TO 13 do
        IF ord(Cpy^.lev[a*14+b])<>10 THEN { Aktueller Level von Cpy wird ausgeben }
          Feld[a,b] :=  ord(Cpy^.lev[a*14+b]) - 48
        ELSE
          Feld[a,b] :=  7;
    DrFeld;
    Ausgabe('                                                ',5,29);
    w :=Copy(Cpy^.Name,1,50); { Aktuellen Levelname ausgeben }
    Ausgabe(w,10,29);
    Cpy:=Cpy^.Next; { Weiterpushen... }
   End; {If}
END; { Demo }

PROCEDURE Helproutine;
{ A little Window with some Hints for the Game }
{ Man drücke 'HELP'-Taste oder gebe Parameter ? an }
VAR w : ^Window; { Windowpointer }
    i,a,b : INTEGER; { Laufvariablen }
    st : STRING; { Ausgabestring }

PROCEDURE pr(t:Str;x,y,col:INTEGER);
{ Unterprocedure zur Ausgabe im Help-fenster }
VAR it: IntuiText;
  BEGIN
    it :=  IntuiText(col,0,1,0,0,^Myfnt,t,Nil);
    PrintIText(W^.RPort, ^it,x,y+BarHeight);
  END;

BEGIN { Kein Kommentar }
  a :=  Win^.LeftEdge;b :=  Win^.TopEdge;
  w :=  Open_Window(25,25,410,200+BarHeight,1,_CLOSEWINDOW+RAWKEY,
       WINDOWDRAG+WINDOWCLOSE+ACTIVATE+WINDOWDEPTH+RMBTRAP,Nil,Nil,0,0,0,0);
  TStr:=' Get´em ! '+VERSION2+' A Game by M. Illenseer. HelpWindow';
  SetWindowTitles(w,'    Get´em - Help & Hints',TStr);
  SetPointer(w,BusyMDat,8,8,-9,-4);
  SetPointer(win,BusyMDat,8,8,-9,-4);
  FOR i :=  1 TO 18 do
  DrawImage(W^.RPort,^Img[Random(12)+1],i*20,185+BarHeight);
  { Ab hier nun Ausgabe.. sieht kompliziert aus .. }
  st :=  VERSION2; pr(st,6,2,1);
  st :=  'Amiga-Version made by Markus Illenseer. ';pr(st,6,11,2);
  st :=  'Well, all you have to do is to move the small';pr(st,5,20,1);
  st :=  'boxes together, to disappear them automagically. ';pr(st,5,30,1);
  st :=  'The problem: Mostly there are only 2 or 4 boxes' ;pr(st,5,40,1);
  st :=  'of same type, but sometimes there are 3 boxes ';pr(st,5,50,1);
  st :=  'to be disappear... So, have a look at right, there';pr(st,5,60,1);
  st :=  'is a list of all pieces during a level. You must';pr(st,5,70,1);
  st :=  'use the mouse to select the box to move. The ';pr(st,5,80,1);
  st :=  'boxes move only left and right.';pr(st,5,90,1);
  st :=  'Remember, that you can disappear 3 boxes at the';pr(st,5,100,1);
  st :=  'same time! You finish a level, if theres is no';pr(st,5,110,1);
  st :=  'more box. Have care with falling boxes, they';pr(st,5,120,1);
  st :=  'allways fall straight down. In this Version,';pr(st,5,130,1);
  st :=  'there is no limit of time. Use the ReGo-Knob!';pr(st,5,140,1);
  st :=  'Have luck & fun ! Try "Getem -?" for more Docs! ';pr(st,5,150,3);
  st :=  'EMail me, when you want to get Updates or Hints:';pr(st,5,160,2);
      pr(' markus@TechFak.Uni-Bielefeld.de ',6,170,3);
  REPEAT { Somethingpresed ist nicht gut hier, da neues Fenster... }
      Msg :=  Wait_Port(w^.UserPort); { KEIN Busy Loop ! }
      IF Msg<>Nil THEN
        BEGIN
          Msg :=  Get_Msg(w^.UserPort);
          Reply_Msg(Msg)
        END;
  UNTIL (Msg^.class = _CLOSEWINDOW) OR (Msg^.Code in [69,95]) or (Break(1)) or (Break(2));
  Close_Window(W);
  SetPointer(win,MouseDat,8,8,-9,-4);
END;

PROCEDURE InterKey;
{ Interpretiere Keyboardinput in Window, war mal länger in den Anfangszeiten ... }
BEGIN
{$IF Def Debug }
 WRITELN(" Key: ",key);
{$ENDIF }
 IF key = 23 THEN iconify;     { 'i'-Taste }
 IF key = 95 THEN Helproutine; { HELP-Taste }
 IF key = 69 THEN ;            { ESC - Taste }
END;

FUNCTION ChkFeld;
{ Prüft Feld bzw. Level , und gibt 1 zurück, wenn alles leer }
{ 3 für beendet, aber noch nicht alle verschwunden  }
{ 2 für beendet, aber Feld nicht leer (D.h. ReGo ist angesagt :-) }
VAR a,b,c,d,e,s:INTEGER;f:BOOLEAN;
BEGIN
 c :=  0;f :=  FALSE;s :=  0;
 FOR a :=  0 TO 13 DO FOR b :=  0 TO 13 do
  IF (Feld[a,b]<>0)AND(Feld[a,b]<>7) THEN c :=  c+1;
 IF (c = 0) THEN
   { Wenn diese Zahl geändert wird, dann ist der Level einfacher...! }
   { Schummeln gilt nicht !  :-) }
 BEGIN
    ChkFeld :=  1 { Feld leer ! }
 END
 ELSE
 BEGIN
  FOR a :=  0 TO 12 do
   FOR b :=  0 TO 12 do
    BEGIN { Test auf Nachbarn }
       e :=  Feld[a,b];
       IF (e<>0)AND(e <  7)AND(e = Feld[a+1,b]) THEN { Rechts }
       BEGIN
        DrBlk(a,b,0); { Lösche Block an aktueller Stelle }
        DrBlk(a+1,b,0); { Und den Nachbarn auch .. }
        f :=  TRUE;
        s :=  s+1;
       END;
       IF (e<>0)AND(e <  7)AND(e = Feld[a,b+1]) THEN { Unten }
       BEGIN
        DrBlk(a,b,0);
        DrBlk(a,b+1,0);
        f :=  TRUE;
        s :=  s+1;
       END;
    END;
  FOR b :=  0 TO 12 do
    BEGIN { Test auf Nachbarn }
       e :=  Feld[13,b];
       IF (e<>0)AND(e <  7)AND(e = Feld[13,b+1]) THEN { Unten,ganz rechts }
       BEGIN
        DrBlk(13,b,0);
        DrBlk(13,b+1,0);
        f :=  TRUE;
        s :=  s+1;
       END;
    END;
  FOR a :=  0 TO 12 do
    BEGIN { Test auf Nachbarn }
       e :=  Feld[a,13];
       IF (e<>0)AND(e <  7)AND(e = Feld[a+1,13]) THEN { Rechts,ganz unten }
       BEGIN
        DrBlk(a,13,0);
        DrBlk(a+1,13,0);
        f :=  TRUE;
        s :=  s+1;
       END;
    END;
  { IF s = 1 THEN Begin Beep(2);s :=  0 END;} { Nur sinnvoll, wenn ein 2. Soundmodul existiert }
  FOR a :=  0 TO 13 DO { Let them purzel ! }
   FOR b :=  0 TO 12 do
     IF (Feld[a,b]<>0)AND(Feld[a,b] <  7) THEN
      IF Feld[a,b+1] = 0 THEN
      BEGIN
       d :=  Feld[a,b];e :=  b;
       REPEAT
        DrBlk(a,e,0); { An aktueller Position löschen }
        DrBlk(a,e+1,d); { Und einen tiefer neu malen.. er ist gefallen ! }
        f :=  TRUE;
        s :=  s+1;
        Delay(1);       { Fallverzögerung } { Kann verändert werden... }
        e :=  e+1;
       UNTIL (e >= 13) or (Feld[a,e]<>0)OR(Feld[a,e]<>7);
      END;
 {IF s=1 THEN Beep(2); } { Nur wenn ein 2. Sound installiert wird, sinnvoll }
  ChkFeld :=  2; { Beendet, aber Feld nicht leer }
 END; { IF }
 IF f = TRUE THEN ChkFeld :=  3; { Noch nicht beendet }
END;

PROCEDURE PrScr;
{ Ausgabe aller möglichen Sachen. So die Zeit, die Anzahl der Blöcke. }
VAR a,b:INTEGER;c:ARRAY[0..13] OF INTEGER;t:STRING;
BEGIN
 FOR a := 0 to 13 DO c[a] := 0;
 FOR a :=  0 TO 13 do
  FOR b :=  0 TO 13 do
   c[Feld[a,b]] :=  c[Feld[a,b]]+1; { Zähle Blöcke eines jeden Typs }
 FOR a :=  1 TO 6 do
  BEGIN
   t :=  Intstr(c[a])+' ';
   Ausgabe(t,358,95+a*11); { Anzahl Blöcke des Typs c[a] (max 6) }
  END;
 t:=IntStr(Time div 600)+':'; {Time wird durch Ticks (=1/10 s !) gezählt }
 IF ((Time mod 600) div 10) < 10 THEN  { Minutengrenze erreicht ? }
  t := t+'0'+IntStr((Time mod 600) div 10)+' ' { Nein, also '0' vorweg }
 ELSE
  t := t+IntStr((Time mod 600)div 10)+' '; { Ja }
 Ausgabe(t,330,184); { Zeit }
END;

PROCEDURE InitLevel;
{ Zok! Neuer Level ! Natürlich nur, wenn Level existent, sonst Zufall-Level }
VAR a,b:INTEGER;
    w:string;
BEGIN
 IF Stufe = NIL THEN { Oh! Kein Level da ?! Kann nur passieren, wenn File nicht gefunden, oder aber falsches File..}
 BEGIN
    ClFeld;
    FOR a :=  1 TO 13 do
      FOR b :=  Random(10) downto 0 Do
        Feld[a,13-b] :=  Random(8); { Zufall Blöcke, die 8 nicht ändern ! }
    DrFeld;
    Ausgabe('                                                 ',5,29);
    w :='Random-Level. Maybe unsolvable !'; { Zufallslevel !}
    Ausgabe(w,10,29);
    HiPrint;
    WHILE a = 3 DO a :=  ChkFeld;
    a :=  3;
    WHILE a = 3 DO a :=  ChkFeld;
 END { No level file }
 ELSE
 BEGIN
    FOR a :=  0 TO 13 do
       FOR b :=   0 TO 13 do
        IF ord(Stufe^.lev[a*14+b])<>10 THEN
        { Wenn jemand ein Quatsch als Level-File genommen hat... }
          Feld[a,b] :=  ord(Stufe^.lev[a*14+b]) - 48
        ELSE
          Feld[a,b] :=  7;
        { ..dann wird eben eine Mauer genommen. }
    DrFeld;
    Ausgabe('                                                 ',5,29);
    w :=Copy(Stufe^.Name,1,50); {Level-Name .. }
    Ausgabe(w,10,29);
    a :=  3;
    HiPrint;  { Ausgabe Scores falls vorhanden }
    WHILE a = 3 DO a :=  ChkFeld;
 END; { Level file }

 Time :=  0; { Zeit pro Level }
END; {  initLevel  }

PROCEDURE FunScroll;
{ Ein paar Gfx-Gags zur Show .. }
Var a,b,c:integer;

BEGIN
 SetBPen(rp,0);
 SetAPen(rp,1);
 b:=Random(12);
 CASE b OF
 1 :
  For a:=1 to 25 Do Begin {Nach rechts rausscrollen }
   ScrollRaster(rp,4,0,295,BarHeight,295+99,BarHeight+16);
   Delay(1);
  end;
 2 :
  For a:=1 to 25 Do Begin { Nach links rausscrollen }
   ScrollRaster(rp,-4,0,295,BarHeight,295+99,BarHeight+16);
   Delay(1);
  end;
 3:
  For a:=1 to 16 Do Begin { Nach unten rausscrollen }
   ScrollRaster(rp,0,1,295,BarHeight,295+99,BarHeight+16);
   Delay(1);
  end;
 4:
  For a:=1 to 18 Do Begin {Nach unten rausscrollen }
   ScrollRaster(rp,0,-1,295,BarHeight,295+99,BarHeight+16);
   Delay(1);
  end;
 5 :
  For a:=1 to 25 do Begin { In der Mitte zusammenscrollen }
   ScrollRaster(rp,4,0,295,BarHeight,(295+99+295) div 2,BarHeight+16);
   ScrollRaster(rp,-4,0,(295+295+99) div 2,BarHeight,295+99,BarHeight+16);
   Delay(1);
  end;
 6 :
  For a:=1 to 25 do Begin { Zwei Hälften nach aussen scrollen }
   ScrollRaster(rp,-4,0,295,BarHeight,(295+99+295) div 2,BarHeight+16);
   ScrollRaster(rp,4,0,(295+295+99) div 2,BarHeight,295+99,BarHeight+16);
   Delay(1);
  end;
 7 :
  Begin          { 1000 Punkte malen }
   SetAPen(rp,2);
   For a:=1 to 99 * 16 DO
    WritePixel(rp,295+Random(99),BarHeight+Random(16));
  End;
 8 :
  Begin          { Ein paar schwarze Flecken erzeugen }
   SetAPen(rp,1);
   For a:=1 to 20 do begin
    c:=Random(89);
    RectFill(rp,295+c,BarHeight,295+c+Random(10),BarHeight+Random(16));
    IF a mod 2=0 THEN Delay(1);
   end;
  end;
 9 :
  For a:=1 to 25 Do Begin { nach unten rechts rausscrollen }
   ScrollRaster(rp,4,1,295,BarHeight,295+99,BarHeight+16);
   Delay(1);
  end;
 0 :
  For a:=1 to 25 Do Begin { nach oben links rausscrollen }
   ScrollRaster(rp,-4,-1,295,BarHeight,295+99,BarHeight+16);
   Delay(1);
  end;
 10 :
  Begin { Kreise malen .. }
   b:=Random(78)+295+10; c:=BarHeight+6;
   SetAPen(RP,3);
   DrawEllipse(RP,b,c,6,6);
   For a:=6 downto 0 Do Begin
    Delay(1);
    SetAPen(RP,0);
    DrawEllipse(RP,b,c,a+1,a+1);
    SetAPen(RP,3);
    DrawEllipse(RP,b,c,a,a);
   End;
   SetAPen(RP,0);
   WritePixel(RP,b,c);
  end;
 11 :
  Begin { Floh im Spielfeld }
   GameOn := True;
   c:=Random(13);
   For a:=1 to 13 do Begin
    b:=random(13);
    DrBlk(a,b,c);
    DrBlk(a,b,0);
   End;
   GameOn := False;
  End;
 Otherwise ; { Nothing }
 END;

 SetAPen(rp,0); { Alten Zustand herstellen }
 RectFill(rp,296,BarHeight,295+99,BarHeight+16);
 SetAPen(rp,1); { Altes Image malen }
 RectFill(rp,296,BarHeight+2,295+99,BarHeight+16);   { Schatten Getem-Image }
 SetAPen(rp,2);
 DrawImage(RP,^Getem,295,BarHeight);                 { Getem-Image }
END; { FunScroll }

PROCEDURE Game;
{ Diese Prozedur steuert den Ablauf des Spiels, d.h. verarbeitet Eingabe und }
{ steuert die Ausgabe. }

VAR chk:byte; { Flag für Feldzustand }
    D,F,Button:BOOLEAN; { Flags für Levelzustand }
    FeldCopy,Feldicfy:Spiel; { Kopien des aktuellen Spielzustand }
BEGIN
 GameOn := False;
 OffGadget(^Gad1,win,NIL); { Gadgets schalten ..}
 OnGadget(^Gad3,win,NIL);  { Wenn gespielt wird, kann nur 'Stop', 'ReGo' und 'Score' gedrückt werden }
 OnGadget(^Gad4,win,NIL);
 Stufe :=  First;          { 1. Level }
 InitLevel;
 FeldCopy :=  Feld;
 FeldIcfy :=  Feld;        { Nach De-Iconifizierung letzten Spielzustand herstellen !}
 Button :=  FALSE;D :=  FALSE;F :=  FALSE;
 PX :=  -1;PY :=  -1;P :=  0;  { PX = MousePointerX .. }
 REPEAT { Game }
  Q :=  SomethingPressed(WAIT);   { Q wie Query }
  IF (Q = LEFT)OR(Q = RIGHT) THEN
   BEGIN
     Button :=  TRUE;
     PosX :=  (Win^.MouseX-20) div 21; { Offset zur Maus wird berechnet }
     PosY :=  (Win^.MouseY-40-BarHeight) div 11;
     IF  (PosX <  14)AND(PosX >= 0)AND(PosY <  14)AND(PosY >= 0) THEN { Im Bereich ? }
      BEGIN
       IF (Feld[PosX,PosY]<>0) and (Feld[PosX,PosY]<>7) THEN
        BEGIN  { Auch wirklich Block da ? }
         IF D = FALSE THEN  { Ist Gerade ein Blockpaar gelöscht worden ? }
         BEGIN
           DrBlk(PX,PY,P-7); { Dann darf kein Block erneut gesetzt werden ! }
           P :=  Feld[PosX,PosY];
           PX :=  PosX;PY :=  PosY;
           IF P <  7 THEN P :=  P+7;
           DrBlk(PX,PY,P); { Andere Farbe }
         END
         ELSE { D = TRUE }
         BEGIN
           D :=  FALSE;
           P :=  Feld[PosX,PosY];
           PX :=  PosX;PY :=  PosY;
           IF P <  7 THEN P :=  P+7;
           DrBlk(PX,PY,P); { Andere Farbe }
         END { IF D }
        END;
      END;
   END;
   IF (Button) and (d = FALSE) THEN { Mousebutton ? }
    BEGIN
       Button :=  FALSE;
       IF (Q = LEFT) THEN { Links gedrückt }
        BEGIN
         IF (PX>0)THEN
         IF (Feld[PX-1,PY] = 0) THEN { Kann ich nach links bewegen ? }
          BEGIN
           GameOn := True;
           DrBlk(PX,PY,0); { Löschen }
           GameOn := False;
           DrBlk(PX-1,PY,P); { Neu an neuer Stelle }
           PX :=  PX-1;
          END; { Kann LEFT }
        END; { Left }
       IF (Q = RIGHT) THEN { Rechts gedrückt }
        BEGIN
         IF (PX <  13) and (PX >= 0) THEN
         IF (Feld[PX+1,PY] = 0) THEN { Kann ich nach Rechts bewegen ? }
          BEGIN
           GameON := True;
           DrBlk(PX,PY,0); { Löschen }
           GameON := False;
           DrBlk(PX+1,PY,P); { Neu an neuer Stelle }
           PX :=  PX+1;
          END; { Kann RIGHT }
        END; { RIGHT ? }
      END; { Button ? }
     {  Now check IF it can fall ...  }

     IF (PX<>-1)AND(D = FALSE) THEN { Wenn Mouse bewegt, und Block bewegt }
     REPEAT
      IF (PY <  13) THEN
       IF Feld[PX,PY+1] = 0 THEN { Kann der aktuelle Block nach unten fallen ? }
       BEGIN
        GameON := True;
        DrBlk(PX,PY,0); { Ja ! }
        GameOn := False;
        PY :=  PY+1;
        DrBlk(PX,PY,P);
        Delay(1);      { Fallverzögerung möglichst schnell, damit auch bei }
                       { Multitasking noch gut. Aber eben eine Verzögerung! }
       END
       ELSE F :=  TRUE;
     {  Now check IF same types come together.... }
      IF (PX <  13) THEN IF Feld[PX+1,PY] = P-7 THEN BEGIN DrBlk(PX,PY,0);DrBlk(PX+1,PY,0); Beep(1);D :=  TRUE; END;
      IF (PX>0) THEN IF Feld[PX-1,PY] = P-7 THEN BEGIN DrBlk(PX,PY,0);DrBlk(PX-1,PY,0); Beep(1);D :=  TRUE; END;
      IF (PY <  13) THEN IF Feld[PX,PY+1] = P-7 THEN BEGIN DrBlk(PX,PY,0);DrBlk(PX,PY+1,0); Beep(1);D :=  TRUE; END;
      IF (PY>0) THEN IF Feld[PX,PY-1] = P-7 THEN BEGIN DrBlk(PX,PY,0);DrBlk(PX+1,PY-1,0); Beep(1);D :=  TRUE; END;
      { schön kompakt, damit ich auch ja verwirre... }
     UNTIL (PY >= 13) or (D = TRUE) or (F = TRUE);

     IF (Q = TASTE)OR(Q = LEFT)OR(Q = RIGHT) THEN
      REPEAT Chk :=  ChkFeld UNTIL Chk<>3;
     IF (Chk = 1) THEN { Q :=  7; Alle schon runtergepurzelt heute ? }
     BEGIN
        If Time<>0 THEN Score := Trunc(360000/Time)  { Score berechnen, abhängig von Zeit }
                   ELSE Score :=0;  { Score ! }
        If Score> Stufe^.Score then Stufe^.Score := Score; { Neuer HiScore ? }
        Stufe :=  Stufe^.Next;
        { Level umhängen, eins weiter.. (Da Ringstruktur, kommt nach dem letzten immer wieder der 1. Level !}
        Inc(AktLev);
        If AktLev>AnzLev then AktLev:=1;
        InitLevel; {  Level geschafft  = > Nächsten Malen  }
        FeldCopy :=  Feld;Feldicfy :=  Feld;
        Chk :=  0;
     END;
     F :=  FALSE;
     IF Q = TICK THEN INC(time);
     PrScr; { Ausgabe des Scores etc.  }
     IF Q = REGO THEN { Restart } { Armer Kerl! Hat den Level vergeigt! :-) }
      BEGIN { Defaultwerte setzen, Zeit läuft weiter !! }
       Feld :=  FeldCopy;
       DrFeld;
       Button :=  FALSE;D :=  FALSE;F :=  FALSE;
       PX :=  -1;PY :=  -1;P :=  0;
      END;
     IF (Q = ICON) or (key = 23) THEN { IconIFy } { Flups! Der Boss gekommen ? }
      BEGIN
       iconIFy;
       Button :=  FALSE;D :=  FALSE;F :=  FALSE;
       PX :=  -1;PY :=  -1;P :=  0;
       OffGadget(^Gad1,win,NIL);  { Gadgets wieder herstellen }
       OnGadget(^Gad3,win,NIL);
       OnGadget(^Gad4,win,NIL);
      END;
     IF Q = SCOR THEN {  Show HighScores  }
      Begin HILIST; End;
     IF (Q = WININACT) and (BREAK(1) or BREAK(2)) THEN Goto TheEnd;

 UNTIL (Q in [STOP,0]) or (key=69); { Ende ? }
 OnGadget(^Gad1,win,NIL);   { Gadgets in Non-Spiel Zustand umschalten }
 OffGadget(^Gad3,win,NIL);
 OffGadget(^Gad4,win,NIL);
 GameOn := False;
END;

PROCEDURE Init(a,b:WORD);
{ a,b sind Top und LeftEdge des Haupt-Fensters}
{ Init deklariert alle Gadgets, Images und Fenster }
{ ACHTUNG! Die meisten Variablen GLOBAL, sonst Konflikte mit Hauptprogramm möglich }
{ Das betrifft vorallem die Strukturen von Gadgets und Windows ! }

VAR i : WORD;                   { Laufvariable }
   TxFnt,TxFnt2 : ^TextFont;    { FontStrukturen fuer SystemDefaultFont und eigenen Font }
   Lock : ^Long;                { Pointer für Sperren der Intuitionbase }

BEGIN { Init }

IF InitDone=FALSE THEN BEGIN

  Lock:=LockIBase(0); { Sperre IntuitionBase zur gefahrlosen Betrachtung derselben }
  BarHeight:=IntBase^.ActiveScreen^.WBorTop; { Unter Dos 2.0 kann die Höhe des Rahmens varieren ! }
  TxFnt := OpenFont(Intbase^.ActiveScreen^.Font);
  UnLockIBase(Lock);

  BarHeight := BarHeight+TxFnt^.tf_YSize;
  CloseFont(TxFnt);
  TxFnt2:=GfxBase^.DefaultFont;
  FSize:=TxFnt2^.tf_YSize;
  IF (FSize>10) THEN BEGIN
   MyFnt.ta_name := "topaz.font";
   MyFnt.ta_YSize := 8;
   MyFnt.ta_Style:=0;
   MyFnt.ta_Flags:=0;
  END;

  BarHeight := BarHeight+2;

END;

  { Main Window öffnen }
  Win :=  Open_Window(a,b,         { Offset zu 0,0 }
                      400,200+Barheight, { Maximale Größe }
                      1,           { Farbe 0, normal blau ? }
                      _CLOSEWINDOW+{ Abfrage auf CloseGadget }
                      GADGETUP+    { Abfrage auf GadgetDruck }
                      GADGETDOWN+  { und natürlich loslassen }
                      INTUITICKS+  { Ticks sollen auch abgefragt werden }
                      ACTIVEWINDOW+{ Ebenso wenn Fenster aktiviert wird }
                      INACTIVEWINDOW+ { Oder inaktiviert wird. }
                      RAWKEY+      { Tasten- und }
                      MOUSEBUTTONS { Mauesedrücke werden verlangt! }
                     ,WINDOWDRAG+  { Fenster darf verschoben werden }
                      WINDOWDEPTH+ { und nach hinten gedrückt werden }
                      WINDOWCLOSE+ { und geschlossen werden }
                      ACTIVATE+    { und aktiviert werden }
                      RMBTRAP,     { die rechte Maustaste wird anders abgefragt. }
                                   { Kein Menue !! }
                      '',          { Noch kein Text, wird unten gemacht ! }
                      Nil          { Pointer auf keinen Screen. Standard ist WB }
                      ,0,0,0,0);   { Kann nicht verkleinert werden... }

  rp :=  Win^.RPort; { RastPort-Zeiger auf window }
  SetAPen(rp,2);     { Nehme 3. Farbe }
  TStr1:='   Get´em '+VERSION2+' By M.Illenseer ©`90    ';
  TStr:=' Get´em ! '+VERSION2+' A Game by M. Illenseer. Programmed with Kickpascal 2.0 MainWindow';
  SetWindowTitles(win,TStr1,TStr);
       {  Hey! Wer diese Zeilen ^^ ändert macht sich Strafbar!! }
       {  Ich verweise auf die Dokumentation ! }

IF InitDone=False THEN BEGIN

  MouseDat := Ptr( Alloc_Mem(SizeOf(Plane),2 ));
  { Die Plane der Mouse braucht Speicher im Chip-Mem, die Daten für sie }
  { müßen mit 2 Nullen anfangen und beendet werden ... }
  MouseDat^:= Plane( 0,0,
                 %0000110000010000,%0000100000011000,
                 %0000011000100000,%0000010000110000,
                 %0000001101000000,%0000001001100000,
                 %0000000110000000,%0000000111000000,
                 %0000000111000000,%0000000110000000,
                 %0000001001100000,%0000001101000000,
                 %0000010000110000,%0000011000100000,
                 %0000100000011000,%0000110000010000,
                 0,0);
  { Sehr interessant ! Hier wird ein Mousezeiger für Getem definiert !}
  { Und zwar nur für das aktuelle Fenster ! (win) Die Daten sind in Planes}
  { aufgeteilt. Da es auf der Standard-WB deren nur 4 gibt, definiere ich }
  { 2 Planes. Die Farben kommen durch die verknüpfung dieser 2 Planes }
  { zustande: Farbe 0 : kein Plane gesetzt. Farbe 1 : Plane 1 gesetzt }
  { Farbe 2 : Plane 2 gesetzt und Farbe 3 : Beide Planes gesetzt. }
  { Die Planes kommen nacheinander dran, deshalb oben auch nebeneinander ... }
  { Änderungen sollten einfach sein... }

  { SetPointer(win,MouseDat,8,8,-9,-4); }
  { Befehl ist nach unten verlegt worden .. }
  { 8,8 setzt die Höhe und Breite der Mouse (obwohl eigentlich 16x8 groß !)}
  { Bitte beachten: Mouse darf in x-Richtung 16 nicht überschreiten ! }
  { -9,-4 setzt den Hot-Spot der Mouse (! Negativ zu 0,0 ganz links oben )}

  BusyMDat := Ptr( Alloc_Mem(SizeOf(Plane),2 ));
  { UhrZeiger.. 'Busy'-State }
  BusyMDat^:= Plane( 0,0,
                 %0000001110000000,%0000000000000000,
                 %0000110101100000,%0000001110000000,
                 %0001000100010000,%0000111111100000,
                 %0010000100001000,%0001111111110000,
                 %0010000100001000,%0001111111110000,
                 %0001000010010000,%0000111111100000,
                 %0000110001100000,%0000001110000000,
                 %0000001110000000,%0000000000000000,
                 0,0);

  {  Speicher für Getemblöcke reservieren:  }
  GetDat :=  Ptr( Alloc_Mem(SizeOf(GetPlane), 2) );   {  2 = "MEMF_CHIP"  }
  {  Bild initialisieren:  }
  GetDat^ :=  GetPlane { Mein schönes Logo ! }
  (%0000000000000000,%0000000000000000,%0000000000000000,%0000000000000000, %0000000000000000, %0000000000000000,
   %0000011111110000,%0111111111111100,%1111111111111110,%0000000111000000, %0111111111111100, %0111100000011110,
   %0011111111111100,%0111111111111100,%1111111111111110,%0000000111000000, %0111111111111100, %0111110000111110,
   %0111100000011110,%0111000000000000,%0000011100000000,%0000011100000000, %0111000000000000, %0111111001111110,
   %0110000000000110,%0111000000000000,%0000011100000000,%0000011100000000, %0111000000000000, %0111011111101110,
   %1110000000000000,%0111000000000000,%0000011100000000,%0000111000000000, %0111000000000000, %0111001111001110,
   %1110000000000000,%0111111110000000,%0000011100000000,%0000000000000000, %0111111110000000, %0111000110001110,
   %1110000001111110,%0111111110000000,%0000011100000000,%0000000000000000, %0111111110000000, %0111000000001110,
   %1110000000111110,%0111000000000000,%0000011100000000,%0000000000000000, %0111000000000000, %0111000000001110,
   %0110000000000110,%0111000000000000,%0000011100000000,%0000000000000000, %0111000000000000, %0111000000001110,
   %0111100000011110,%0111000000000000,%0000011100000000,%0000000000000000, %0111000000000000, %0111000000001110,
   %0011111111111110,%0111111111111100,%0000011100000000,%0000000000000000, %0111111111111100, %0111000000001110,
   %0000011111110110,%0111111111111100,%0000011100000000,%0000000000000000, %0111111111111100, %0111000000001110,
   %0000000000000000,%0000000000000000,%0000000000000000,%0000000000000000, %0000000000000000, %0000000000000000,
   %1111111111111111,%1111111111111111,%1111111111111111,%1111111111111111, %1111111111111111, %1111111111111111);

  {  Image-Struktur  }
  Getem :=  Image(0,0,  {  keine Verschiebung  }
             96,      {  Breite  }
             15,      {  Höhe  }
             1,       {  nur eine Plane  }
             GetDat,  {  Bilddaten  }
             1,2,     {  weißes Bild, schwarzer Hintergrund  }
             Nil);    {  kein weiteres Image  }
  Q :=  2;P :=  1; { wer diese Farbenkobination nicht mag, soll sie ändern }
  FOR i :=  0 TO 14 DO Dat[i] :=  Ptr( Alloc_Mem(SizeOf(Plane), 2) );
             {  2 = "MEMF_CHIP"  }

  Dat[0]^ :=  Plane(%0000000000000000,%0000000000000000, { Leeres Bild, zum schneller löschen }
                 %0000000000000000,%0000000000000000, { Und als Hintergrund }
                 %0000000000000000,%0000000000000000,
                 %0000000000000000,%0000000000000000,
                 %0000000000000000,%0000000000000000,
                 %0000000000000000,%0000000000000000,
                 %0000000000000000,%0000000000000000,
                 %0000000000000000,%0000000000000000,
                 %0000000000000000,%0000000000000000,
                 %0000000000000000,%0000000000000000);
  Dat[7] :=  Dat[0];
  Dat[1]^ :=  Plane(%0000000000000000,%0000000000000000, { Das ist der Getemblock ! }
                    %0111111111111111,%1110000000000000,    {  Quadrat  }
                    %0111000111111111,%1110000000000000,
                    %0111001111111111,%1110000000000000,
                    %0111011111111111,%1010000000000000,
                    %0111111111111111,%0010000000000000,
                    %0111111111111111,%0010000000000000,
                    %0111111111111111,%0010000000000000,
                    %0111111111110000,%0010000000000000,
                    %0111111111111111,%1110000000000000);
  Dat[8] :=  Dat[1];                     {^}
  Dat[2]^ :=  Plane(%0000000000000000,%0000000000000000, {  Kreuz  }
                    %0011110000000011,%1100000000000000,
                    %0000111100001111,%0000000000000000,
                    %0000001111111100,%0000000000000000,
                    %0000000011110000,%0000000000000000,
                    %0000001111111100,%0000000000000000,
                    %0000111100001111,%0000000000000000,
                    %0011110000000011,%1000000000000000,
                    %1111000000000001,%1100000000000000,
                    %1110000000000000,%1110000000000000);
  Dat[9] :=  Dat[2];
  Dat[3]^ :=  Plane(%0000000001100000,%0000000000000000, {  Dreieck  }
                    %0000000011110000,%0000000000000000,
                    %0000000111111000,%0000000000000000,
                    %0000001111111100,%0000000000000000,
                    %0000011111111110,%0000000000000000,
                    %0000111111111011,%0000000000000000,
                    %0001111111111101,%1000000000000000,
                    %0011111111111110,%1100000000000000,
                    %0111111111111000,%1110000000000000,
                    %1111111111111111,%1111000000000000);
  Dat[10] :=  Dat[3];
  Dat[4]^ :=  Plane(%0000000000000000,%0000000000000000, {  Kreis  }
                    %0000000000000000,%0000000000000000,
                    %0000000111111000,%0000000000000000,
                    %0000011111111110,%0000000000000000,
                    %0001111111111111,%1000000000000000,
                    %0011110011111111,%1100000000000000,
                    %0011111111111111,%1100000000000000,
                    %0001111111111111,%1000000000000000,
                    %0000011111111110,%0000000000000000,
                    %0000000111111000,%0000000000000000);
  Dat[11] :=  Dat[4];
  Dat[5]^ :=  Plane(%0011111110111111,%1000000000000000, {  Muster  }
                    %0011111110111111,%1000000000000000,
                    %0011111110000111,%1000000000000000,
                    %0011111110110111,%1000000000000000,
                    %0011111110110000,%0000000000000000,
                    %0000000000110111,%1000000000000000,
                    %0011011111110111,%1000000000000000,
                    %0011000000000111,%1000000000000000,
                    %0011111111011111,%1000000000000000,
                    %0011111111011111,%1000000000000000);
  Dat[12] :=  Dat[5];
  Dat[6]^ :=  Plane(%0011111111111111,%1100000000000000, {  Muster  }
                    %0001111001111111,%1000000000000000,
                    %0000011011111110,%0000000000000000,
                    %0000001111111100,%0000000000000000,
                    %0000000001110000,%0000000000000000,
                    %0000000111111100,%0000000000000000,
                    %0000011011111111,%0000000000000000,
                    %0000110111111111,%1000000000000000,
                    %0011100011111111,%1110000000000000,
                    %0111111111111111,%1111000000000000);
  Dat[13] :=  Dat[6];
  Dat[14]^ := Plane(%0100110011001000,%1000000000000000, {  Muster  }
                    %0010001010110001,%0000000000000000,
                    %0001010000110010,%0000000000000000,
                    %0000100101101000,%0000000000000000,
                    %0001010110100000,%0000000000000000,
                    %0010101101000100,%0000000000000000,
                    %0100000000100010,%0000000000000000,
                    %1011111110010000,%0000000000000000,
                    %0000010110001000,%1100000000000000,
                    %0000100001000000,%0010000000000000);

  FOR i :=  0 TO 6 DO      { Alle 6 Bilder init.  }
    Img[i] :=  Image(0,0,     {  keine Verschiebung  }
                  20,      {  Breite  }
                  10,      {  Höhe  }
                  1,       {  nur eine Plane  }
               Dat[i],     {  Bilddaten  }
                  2,1,     {  Bildfarbe,  Hintergrundfarbe  }
                  Nil);    {  kein weiteres Image  }
  Img[14] :=  Image(0,0,20,10,1,Dat[14],2,1,Nil); { Explosion }
  FOR i :=  7 TO 13 do
    Img[i] :=  Image(0,0,20,10,1,Dat[i],1,2,Nil);



   Gad1 :=  Gadget(NIL,           {  Gadget-Struktur: Nachfolger ist Gad2 }
                20,BarHeight,        {  Position  }
                32,14,         {  Größe  }
                GADGHCOMP+GADGHIMAGE+GADGIMAGE,    {  Gadget hat Bild  }
                RELVERIFY, {  Activation Flags  }
                BOOLGADGET,    {  Typ  }
                ^Imggad1,         {  Zeiger auf Imagestruktur = Start }
                ^Imggad2,         {  Select-Image = Stop }
                Nil,         {  Zeiger auf Text  }
                0, Nil, 1, 0); {  Nummer 1  }
   IDt1 :=  Ptr(Alloc_Mem(SizeOf(ImgDatTyp),2));
   IDt1^ :=  ImgDatTyp(%11111111111111111111111111111111,
                       %10001111000000000000000000000001,
                       %10111111100110000000000000001101,
                       %11100001100110000000000000001101,
                       %11100000001111000000000000011111,
                       %10110000001111000000000000011111,
                       %10011000000110000000000000001101,
                       %10001100000110000111100101101101,
                       %10000110000110001101100111101101,
                       %10000011000110011001100110001101,
                       %11100011000110011001100110001101,
                       %10111110000110001101100110001101,
                       %10011100000011000110110110000111,
                       %11111111111111111111111111111111);

   Imggad1 :=  Image(0,0,32,14,1,IDt1,1,1,Nil);
   Imggad2 :=  Image(0,0,32,14,1,IDt1,1,3,Nil);

   Gad2 :=  Gadget(NIL,           {  Gadget-Struktur  }
                25,BarHeight-(Barheight div 2)-6, {  Position  }
                26,10,         {  Größe  }
                GADGIMAGE+GADGHCOMP+GADGHIMAGE,    { Gadget hat Bild  }
                RELVERIFY, {  Activation Flags  }
                BOOLGADGET,    {  Typ  }
                ^Imggad3,      {  Zeiger auf Imagestruktur = Icon }
                ^Imggad4,      {  kein 2. Bild }
                NIL,         {  kein Text  }
                0, Nil, 2, 0); {  Nummer 2  }
   IDt2 :=  Ptr(Alloc_Mem(SizeOf(ImgDatTyp),2));
   IDt2^ :=  ImgDatTyp(%11111111111111111111111111000000,
                       %10000000000000000000000001000000,
                       %10111001110011110010010001000000,
                       %10010001000011010011010001000000,
                       %10010001000010010011010001000000,
                       %10010001000010010010110001000000,
                       %10010001000010010010110001000000,
                       %10111001110011110010010001000000,
                       %10000000000000000000000001000000,
                       %11111111111111111111111111000000,
                       %00000000000000000000000000000000,
                       %00000000000000000000000000000000,
                       %00000000000000000000000000000000,
                       %00000000000000000000000000000000);


   Imggad3 :=  Image(0,0,26,10,1,IDt2,1,1,Nil);
   Imggad4 :=  Image(0,0,26,10,1,IDt2,1,3,Nil);

   Gad3 :=  Gadget(NIL,           {  Gadget-Struktur: Nachfolger ist Gad2 }
                60,BarHeight,        {  Position  }
                32,14,         {  Größe  }
                GADGHCOMP+GADGHIMAGE+GADGIMAGE,    {  Gadget hat Bild  }
                RELVERIFY, {  Activation Flags  }
                BOOLGADGET,    {  Typ  }
                ^Imggad5,         {  Zeiger auf Imagestruktur = Start }
                ^Imggad6,         {  Select-Image = Stop }
                Nil, { ^Tex2, }         {  Zeiger auf Text  }
                0, Nil, 3, 0); {  Nummer 3  }
   IDt3 :=  Ptr(Alloc_Mem(SizeOf(ImgDatTyp),2));
   IDt3^ :=  ImgDatTyp(%11111111111111111111111111111111,
                       %10001111000000000000000000000001,
                       %10111111100110000000000000000001,
                       %11100001100110000000000000000001,
                       %11100000001111000000000000000001,
                       %10110000001111000000000000000001,
                       %10011000000110000000000000000001,
                       %10001100000110000111000111110001,
                       %10000110000110001101100110011001,
                       %10000011000110011000110110001101,
                       %11100011000110011000110110011001,
                       %10111110000110001101100111100001,
                       %10011100000011000111100110000001,
                       %11111111111111111111111111111111);

   Imggad5 :=  Image(0,0,32,14,1,IDt3,1,1,Nil);
   Imggad6 :=  Image(0,0,32,14,1,IDt3,1,3,Nil);

   Gad4 :=  Gadget(NIL,           {  Gadget-Struktur: Nachfolger ist Gad2 }
                100,BarHeight,        {  Position  }
                32,14,         {  Größe  }
                GADGHCOMP+GADGHIMAGE+GADGIMAGE,    {  Gadget hat Bild  }
                RELVERIFY, {  Activation Flags  }
                BOOLGADGET,    {  Typ  }
                ^Imggad7,         {  Zeiger auf Imagestruktur = Start }
                ^Imggad8,         {  Select-Image = Stop }
                Nil,          {  Zeiger auf Text  }
                0, Nil, 4, 0); {  Nummer 4  }
   IDt4 :=  Ptr(Alloc_Mem(SizeOf(ImgDatTyp),2));
   IDt4^ :=  ImgDatTyp(%11111111111111111111111111111111,
                    %10111110000000000001110000000001,
                    %10111111000000000111111000000001,
                    %10110001100000001100001100000001,
                    %10110000110000001100000000000001,
                    %10110001100000001100000000000001,
                    %10111110000011001100000000011001,
                    %10111100000111101100000001100111,
                    %10110110001100101100000001100111,
                    %10110011001111101100011101100111,
                    %10110001101100001100001101100111,
                    %10110001100110000110011101100111,
                    %10110001100011100011111100011001,
                    %11111111111111111111111111111111);

   Imggad7 :=  Image(0,0,32,14,1,IDt4,1,1,Nil);
   Imggad8 :=  Image(0,0,32,14,1,IDt4,1,3,Nil);

   Gad5 :=  Gadget(NIL,           {  Gadget-Struktur: Nachfolger ist Gad2 }
                140,BarHeight,        {  Position  }
                32,14,         {  Größe  }
                GADGHCOMP+GADGHIMAGE+GADGIMAGE,    {  Gadget hat Bild  }
                RELVERIFY, {  Activation Flags  }
                BOOLGADGET,    {  Typ  }
                ^Imggad9,         {  Zeiger auf Imagestruktur = Start }
                ^Imggad10,        {  Select-Image = Stop }
                NIL,              {  Zeiger auf Text  }
                0, Nil, 5, 0); {  Nummer 5  }
   IDt5 :=  Ptr(Alloc_Mem(SizeOf(ImgDatTyp),2));
 IDt5^:=  ImgDatTyp(%11111111111111111111111111111111,
                    %10001111000000000000000000000001,
                    %10111111100000000000000000000001,
                    %11100001100000000000000000000001,
                    %11100000000000000000000000000001,
                    %10110000000000000000000000000001,
                    %10011000000000000000000000000001,
                    %10001100001110011110010011001111,
                    %10000110011000110011011011011011,
                    %10000011011000110011011110011111,
                    %11100011011000110011011100011001,
                    %10111110011000110011011000001101,
                    %10011100001110011110011000000111,
                    %11111111111111111111111111111111);

   Imggad9 :=  Image(0,0,32,14,1,IDt5,1,1,Nil);
   Imggad10:=  Image(0,0,32,14,1,IDt5,1,3,Nil);

END; {IF InitDone}

   SetPointer(win,MouseDat,8,8,-9,-4); { MausPointer MainWindow }

   SetAPen(rp,1);
   RectFill(rp,20,BarHeight+1,19+37,16+BarHeight); { Schatten für Gadgets }
   RectFill(rp,60,Barheight+1,60+37,16+Barheight);
   RectFill(rp,100,Barheight+1,100+37,16+Barheight);
   RectFill(rp,140,Barheight+1,140+37,16+Barheight);
   SetAPen(rp,3);
   RectFill(rp,19,Barheight-1,19+33,14+Barheight); { Untergrund für Gadgets }
   RectFill(rp,59,Barheight-1,60+33,14+Barheight);
   RectFill(rp,99,Barheight-1,100+33,14+Barheight);
   RectFill(rp,139,Barheight-1,140+33,14+Barheight);
   SetAPen(rp,2);
   AddGadget(Win, ^Gad1, Nil);  { Gadgets setzen }
   AddGadget(Win, ^Gad2, Nil);
   AddGadget(Win, ^Gad3, Nil);
   AddGadget(Win, ^Gad4, Nil);
   AddGadget(Win, ^Gad5, Nil);
   OffGadget(^Gad3,win,NIL);
   OffGadget(^Gad4,win,NIL);

   RefreshGadgets(Win^.FirstGadget, Win, Nil);
   SetAPen(rp,1);
   RectFill(rp,328,106+BarHeight,356,171+Barheight+2); { Schatten für Boxes }
   RectFill(rp,296,BarHeight+2,295+99,BarHeight+16);   { Schatten Getem-Image }
   SetAPen(rp,2);
   RectFill(rp,327,98+BarHeight-2,352,171+Barheight);  { Untergrund Boxes }
   DrawImage(RP,^Getem,295,BarHeight);                 { Getem-Image }
   DrawImage(rp,^Img[1],330,105+BarHeight);
   DrawImage(rp,^Img[2],330,116+BarHeight);
   DrawImage(rp,^Img[3],330,127+BarHeight);
   DrawImage(rp,^Img[4],330,138+BarHeight);
   DrawImage(rp,^Img[5],330,149+BarHeight);
   DrawImage(rp,^Img[6],330,160+BarHeight);
   Ausgabe("Boxes:",327,95);
   Ausgabe("Time:",327,175);
   SetAPen(rp,1);
   RectFill(rp,17,38+BarHeight+3,319+2,193+BarHeight+3); { Schatten Spielfeld }
   SetAPen(rp,2);
   RectFill(rp,16,38+BarHeight,316,193+BarHeight); { Untergrund Spielfeld }
END; { Init }


PROCEDURE Iconify;
{ Wenn der Boss kommt... Damit wird das Fenster ganz klein ! }
{ Hier erspare ich mir die Erklärungen, das ist nicht sauber programmiert ...}
VAR ww:^Window;
    a,b:INTEGER;
    Sc:Boolean;
BEGIN
 a :=  win^.leftedge;            { Merke Position des Fensters }
 b :=  win^.topedge;
 Close_Window(win);              { Ach so geht das ! }
 IF ScWindow THEN Begin HiList; sc := True; End Else Sc:=False;
 ww :=  Open_Window(a,b,84,Barheight-2,1,GADGETUP+GADGETDOWN+ACTIVEWINDOW+INACTIVEWINDOW+RAWKEY
       ,WINDOWDRAG+ACTIVATE+RMBTRAP,NIL,Nil,0,0,0,0);
 win :=  ww;                     { !!! Damit SomeThingPressed geht!! }
 SetAPen(ww^.RPort,3);
 IT :=  IntuiText(1,3,1,0,0,^MyFnt,'Get    ´em',Nil);
 AddGadget(ww, ^Gad2, Nil);  { 'Icon' }
 key :=0;
 REPEAT
   RectFill(ww^.RPort,2,2,82,BarHeight-4);
   PrintIText(ww^.RPort,^it,2,1);
   RefreshGadgets(ww^.FirstGadget,ww,Nil);
   Q :=  Somethingpressed(WAIT);
   IF (key in [69,23]) THEN Q :=  6;
 UNTIL (Q = 6);
 key :=  0;
 Close_Window(ww);
 Init(a,b); { Und neu aufmachen }
 DrFeld;
 IF Sc then HiList;
END; { Iconify }


PROCEDURE ChkParam;
{ Prüfe auf Parameter... Naturlich nur wenn von CLI aufgerufen... }
VAR  s      :STRING; { Parameterstring }
     l,q    :LONG;   { Parameterstring-länge }
     a,b    :INTEGER;{ Laufvariablen }
     WStart :p_WBStartup; { Zeiger auf Startup-Message der WB }

 PROCEDURE Hilfe; { Ausgabe von text, wenn von CLI mit Paramter ? }
 Var s:string;
 BEGIN
  WRITELN(chr($9b),'3m',chr($9b),'33m',VERSION2);
  WRITELN('A Game by Markus Illenseer .',chr($9b),'32m');
  WRITELN;
  WRITELN('This Game is, up to this Version: ',VERSION2,' completely moved into the Public-Domain !');
  WRITELN('You can do with the Game whatever you want, if you include');
  WRITELN('my Name and the Doc-File !');
  WRITELN('All Rights for this Version reserved by Markus Illenseer, Germany.');
  WRITELN(chr($9b),'31m','IF you want any Update or Hint, use EMail:',chr($9b),'33m');
  WRITELN(chr($9b),'0m',' Domain:  markus@techfak.uni-bielefeld.de',chr($9b),'31m');
  WRITELN;
  WRITELN('The target of this Game is to let disappear all the small boxes.');
  WRITELN('To move a box, move the Mousepointer on it, then hit LEFT or RIGHT');
  WRITELN('Mousebutton. The Box will be hilited and moved to the side');
  WRITELN('you hit it. The boxes can only be moved to left and right.');
  WRITELN('Now you can move the hilited box with other Mousebutton without being');
  WRITELN('on the box with the Mousepointer.');
  WRITELN('As you will see, the boxes are falling straight downwards, if');
  WRITELN('there is no other box or wall (Solid Pieces) below them.');
  WRITELN('While falling, the box is looking left, right and (!) downwards for a box,');
  WRITELN('which is of the same type. If found, the matching boxes will disappear.');
  WRITELN;
  WRITELN(chr($9b),'33m','PRESS RETURN TO CONTINUE',chr($9b),'31m');
  Readln(s);
  WRITELN('The Problem is, that sometimes there are boxes of each type in');
  WRITELN('an odd number. Then you have to try to eliminate 3 boxes at the');
  WRITELN('time. (It´s easy !) Have a look at right, there is always');
  WRITELN('a list of the numbers of each type. There you can find the');
  WRITELN('odd types...');
  WRITELN;
  WRITELN('At ANY time, you can use the ICONify Gadget at the top.');
  WRITELN('This causes the window to be shrinked and moved to the left top.');
  WRITELN('Don´t bother, use ICON again to re-enter the Game.');
  WRITELN('It´s a sort of BOSS-Key!' );
  WRITELN;
  WRITELN('The Restart (ReGo)-Gadget is for trying the same Level once again');
  WRITELN;
  WRITELN('Stop the Game with STOP-Gadget.');
  WRITELN;
  WRITELN('Quit Game with Close-Gadget or hit ´ESC´ at any time.');
  WRITELN;
  WRITELN('Hit´n HELP-Key to get short help. ');
  WRITELN('Good luck, and much fun !');
  WRITELN;
  WRITELN(chr($9b),'33m','USAGE: ',chr($9b),'32m','Getem [-? -F LevelFile]',chr($9b),'31m');
  WRITELN('       -? to show this List.');
  WRITELN('       -F LevelFile (Optional Get´em LevelFile). ');
  WRITELN;
  WRITE(chr($9b),0,'m');
  Ende :=  TRUE;
 END;

BEGIN { ChkParam }
{ Bekannte Parameter : '-?' '-F' }
 Load:='GetemLevels'; { Default Filename }
 IF FromWB=false THEN BEGIN { Kickpascal funktion,die angibt, ob von WB gestartet }
  s :=  Parameterstr;
  l :=  Parameterlen;
  FOR b := 1 to Length(s) DO s[b] := Upcase(s[b]);
  a :=  pos('?',s); { Hilfe erbeten ? }
  IF (a<>0) THEN Hilfe;
  a :=  pos('F',s); { optionaler Filename für Levelfile ? }
  IF (a<>0)AND(a<StrLen(s)) THEN BEGIN  { Parse Filenamen für Levels }
   IF s[a+1]=' ' THEN BEGIN { Suche nur, wenn ein Blank zwischen -f und Namen }
     b := a+2;Load := '';
     REPEAT { Lade Zeichen für Zeichen }
      Load := Load+s[b];
      b := b+1;
     UNTIL (b>=Length(s))OR(s[b]=' '); { Bis Blank gefunden, oder Ende erreicht }
   END;
  END;
  WHILE Load[1]=' ' DO { Lösche führende Blanks, sollte aber nicht vorkommen }
   Load := Copy(Load,2,StrLen(Load));
 END { Not FromWB }
 ELSE
 Begin { FromWB }
  WStart:=StartupMessage; { Kopiere die WB-Startup-Message }
  IF WStart^.sm_NumArgs < 2 THEN BEGIN { Wenn nur 1 Argument, dann wurde kein Parameter mit 'Shift-Click' übergeben }
   Load:='GetemLevels'; { DefaultFilename setzen }
    OLock:=CurrentDir(WStart^.sm_ArgList^[1].wa_Lock); { In das Direktory gehen, von wo aus Getem gestartet (WB !) wurde }
  END
  ELSE { Getem wurde mit Parameter aufgerufen ( 'Shift-Click' ) }
      WITH WStart^.sm_ArgList^[2] DO { Wir interpretieren die Argumentenliste }
        BEGIN
          { Als Datei wird das 2. Argument angenommen. Falls noch}
          { mehr Icons aktiviert sind,durch "Shift-Klick",       }
          { werden diese ignoriert.                              }
          Load := wa_Name; { Siehe auch Struktur WB-Startupmessage ! }
          { Nur reiner Name ohne Pfad! Deshalb müssen wir den Lock ausführen }
          OLock := CurrentDir( wa_Lock );
          { CurrentDir macht nix anderes als ein 'CD' im CLI ! }
        END;
 End;
 IF Load = '' THEN Load := 'GetemLevels'; { wenn nur Parameter f eingegeben, dann Default für Level }
END;


{ ############################################################################### }

 BEGIN { ***************************** MAIN ****************************** }
  ENDE :=  FALSE;  { Falg für Spielende, reguläres Spielende }
  Demon := TRUE;   { Ist mal wieder Demo-Zeit ? }
  Gamen :=  FALSE; { Flag fuer Demo und ENDE setzen }
  PosX := 0;PosY := 0; { Mausposition }
  time := 1; { Zeitzähler }
  key := 0;  { Beinhält letzten Tastendruck }
  PX :=  -1;PY :=  -1;
  P :=  0;
  ScWindow := FALSE; { Kein ScoreWindow geöffnet }
  AktLev:=1; { Der Aktive Level ist der 1. }
  InitDone := False; { Die InitProzedur noch nicht durchlaufen }
  GameOn := False; { Wir sind noch nicht mitten im Spiel }
  ChkParam; { Parameter überprüfen und interpretieren }
  FOR P := 1 to 10 DO HiScore[p] := 0;

  OpenLib(IntBase,'intuition.library',0);
      { öffne Intuition für Zeichenbefehle }
  OpenLib(GfxBase,'graphics.library',0);

  IF not ENDE THEN
  BEGIN
   PX := 10; PY := 10;
   Init(PX,PY);  { Alle Fenster öffnen, Gadgets initialisieren }
   InitDone:=True;
   InitDemo; { Feld init. }
   DrFeld; { Feld malen }
   LoadLevels(PX,PY);  { Level laden }
   REPEAT { Endlosschleife, bis Ende }
    s :=  SomethingPressed(WAIT);
    IF s = START THEN
     BEGIN
       Gamen :=  NOT Gamen; { Inverse... }
     END;
    IF Gamen THEN { Spiel starten }
      BEGIN
       NoSound := NOT NoSound;
       Game;
       Gamen :=  NOT Gamen;
       NoSound := NOT NoSound;
      END; { Spiel starten }
    IF s = TASTE THEN InterKey; { Z.B Help ? }
    IF key = 69 THEN Ende :=  TRUE; { Jemand hat ESC gedrückt }
    IF s = TICK THEN INC(time); { Intuitick bekommen }
    IF s = WININACT THEN { Wenn Fenster nicht aktiv, dann warten bis wieder aktiv }
             REPEAT
              T:=SomethingPressed(WAIT);
              IF BREAK(1) or BREAK(2) THEN BEGIN ENDE:=True; T:=-77; END;
             UNTIL (T=WINACT) or (T=-77);
    IF s = ICON THEN { Iconify }
              Iconify;
    IF s = SCOR THEN {  Show HighScores  }
              begin HILIST; end;
    IF Anzlev >0 THEN Begin IF (s = TICK) and (time/60=time div 60) THEN Demo End { Nur Demo laufen lassen }
    ELSE IF (s = TICK) THEN Demo;
    IF Time/35=Time div 35 then FunScroll;
   UNTIL (ENDE = TRUE); { Spielende ! }
TheEnd: { Der berüchtigte Label :-) }
  IF SCWINDOW THEN  Close_Window(SCWIN);
  IF Not NoSound THEN EndPlay; {Schliesst Audio-Device, MODUL GetemSound }
  Close_Window(Win);{Fenster zu}
  CloseLib(IntBase);{Nix Intuition mehr}
  CloseLib(GfxBase);{Nix Grafik.. }
{  Eigentlich muß man hier den Speicher für die Images freigeben... }
{  Macht aber Run-Time Lib von Kickpascal, bei Umsetzung auf C beachten !  }
 END;
END. { *** Main *** }

{$opt t0,i0,b0,s0,a0                                                         }
{ Optionen wieder einschalten auf Default                                    }

{ *** Credits ***
 Tja. Soweit so gut. Ich hoffe hier ein paar neue Ideen geliefert zu haben.
 Eine Optimierung habe ich nicht vor. Das Spiel ist schnell genug.

 Wer will kann Sound zufügen, die Images verändern, das Ganze auf einem
 eigenen Screen laufen lassen, mit mehr Farben und schöneren Images oder
 Sprites. Oder Fahrstühle und Falltüren ausdenken. Oder, oder...
 Vorsicht mit den Images und den Gadgets. Wird hier was falsch gemacht
 so kann es zum Guru kommen. Das macht Spaß! :-(
                                               Kopf 90° links drehen!
 Dringend benötigt werden neue Levels. Meine Beigefügten sind mir langsam
 zu öde... Wie es geht, steht im Doc-File.
 Zum Schluß noch, wie man mich erreichen kann, und wo das Copyright liegt:

 EMAIL: (Geht janz fix!)
        markus@TechFak.Uni-Bielefeld.DE


 Snail-MAIL: (Schneckenpost) (Bin Schreibmuffel ... )
        Markus Illenseer
        Große Kurfürstenstr. 1
        D-4800 Bielefeld 1
        Germany

 © by Markus Illenseer 1990,1991.
    Die Source ist als Public-Domain freigegeben. Sie darf verändert
    und kopiert werden, solange mein Name und die Dokumentation
    enthalten bleibt. Mit dieser Source, mit dem daraus resultierenden,
    lauffähigen Programm und mit dem SoundFile darf KEIN Profit
    erwirtschaftet werden ! Dies gilt insbesondere für sogenannte
    PD/FD und PW Händler !!

    Portierungen auf andere Systeme sind erlaubt.
    (Sogar erwünscht! Ich bereite gerade eine Portierung für X11 vor. )
    Ich erbitte aber Kopien von Portierungen auf Fremdsysteme!  :-)
    Und auch Kopien von veränderter Source ...

 Kickpascal ® ist eingetragenes Warenzeichen der Maxon-GmBH ®
 Kickpascal is a product of the Himpire.

 Ganz zum Schluß: Gruß an  Himpel: Der Compiler ist gut! :-)
                            Massa: Danke für die Tips !
                           Medusa: Hatte die Idee mit größeren Blöcken...
                             Nick: Er wollte immer neue Levels schreiben...
                          StefanB: Half bei der WB 2.0 fähigen Version.
                           Richie: Wollte unbedingt Special-Effects ..
 }

