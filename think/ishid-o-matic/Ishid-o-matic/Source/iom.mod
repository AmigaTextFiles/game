(*------------------------------------------------------------------------
    Project	: Ishid-O-matic
    Module	: IOM.mod
    Author	: Robert Brandner (rb)
    Address	: Schillerstr. 3 / A-8280 Fürstenfeld / AUSTRIA / EUROPE
    Copyright	: © 1992 by Robert Brandner, all rights reserved
    Language	: Modula-II (M2Amiga V4.0d)
    History	: 03-Feb-92 : Laden der Grafikdaten
    History	: 10-Feb-92 : Fast fertig, Gadgets eingebaut ...
    History	: 25-Feb-92 : Noch immer nicht ganz fertig
------------------------------------------------------------------------*)

(*$ StackChk    := FALSE *) 	(* alles aus, für mehr Geschwindigkeit	*)
(*$ RangeChk    := FALSE *)
(*$ OverflowChk := FALSE *)
(*$ ReturnChk   := FALSE *)
(*$ LongAlign   := FALSE *) 	(* make this TRUE for MC680x0, x>=1 	*)
(*$ Volatile	:= FALSE *)
(*$ LargeVars   := FALSE *)
(*$ StackParms  := FALSE *)

MODULE IOM;

FROM PointerData IMPORT NormPtrData,SinglePtrData,TwoPtrData;
FROM iomsound IMPORT StoneClick,StartBackgroundSound,SwitchBackSound;
FROM Conversions IMPORT ValToStr;
FROM InputEvent IMPORT upPrefix;
FROM SYSTEM IMPORT ADR, ADDRESS, ASSEMBLE, LONGSET, CAST;
IMPORT Arts, I:IntuitionD, IL:IntuitionL, G:GraphicsD, GL:GraphicsL,
       E:ExecD, EL:ExecL, FS:FileSystem,DosL,DosD;
FROM FontSupport IMPORT OpenFont,CloseFont;
FROM IFFIO IMPORT LoadILBM,LoadBrush;
FROM IntuiSupport IMPORT OpenScr,OpenWin,MakeBoolGad,MakeStrGad;
FROM RandomNumber IMPORT RND,PutSeed;
FROM String IMPORT Length,Copy;

(*------------------------------------------------------------------------
    Unsere globalen Konstanten:
------------------------------------------------------------------------*)

CONST
  ESCCODE=197;
  HELPCODE=223;
  TCODE=148;
  MCODE=183;
  UCODE=150;
  RCODE=147;
  SCODE=161;
  STITLE="Ishid-O-matic - © 1992 Avalon Unlimited";
  WFLAGS=I.WindowFlagSet{I.borderless,I.activate,I.rmbTrap,I.reportMouse,
  			 I.backDrop};
  GRAPHICSNAME="gfx";

  PLY1ID=1; PLY2ID=2;				(* Gadget IDs		*)
  TOURID=3; SOUNDID=4;
  CREDID=5; HISCID=6;
  QUITID=99;

  TNEWID=1; TCONTID=2;
  TCANCID=QUITID;

  H1ID=1; H2ID=2; H3ID=3; H4ID=4; H5ID=5; H6ID=6; H7ID=QUITID;
  HISCORENAME="IOM_highscores";
  TOURNAMENTNAME="IOM_tournament";
  NAMEID=1;
  NAMELEN=25;

  SPECIALCOLORS=LONGSET{20,22,26,27,29,30,31};
  ALLCOLORS=LONGSET{0..31};
  FADERATE=8;

  SINGLE=0;		(* Werte für type für ShowHiScores und HiScore	*)
  TWOPLY=1;
  TOUR  =2;

TYPE
  HiScoreEntry=RECORD
	         name : ARRAY[0..NAMELEN-1] OF CHAR;
	         score,quads:LONGINT;
	         stonesleft,helps:SHORTINT;
	       END;
  TileStack=ARRAY[0..71] OF SHORTINT;

(*------------------------------------------------------------------------
    Unsere globalen Variablen:
------------------------------------------------------------------------*)

VAR
  ourtask	: DosD.ProcessPtr;
  scr 		: I.ScreenPtr;
  bbm		: G.BitMap;		(* Backup-BitMap		*)
  rp		: G.RastPortPtr;
  win		: I.WindowPtr;
  gbm		: G.BitMap;		(* Graphics-Bitmap 		*)
  fnt		: G.TextFontPtr;
  gok		: BOOLEAN;
  i,j		: INTEGER;
  rs,gs,bs	: ARRAY[0..31] OF INTEGER;	(* Startfarbe bei Fade	*)
  r0,g0,b0	: INTEGER;			(* RGB des Hintergrunds *)
  rt,gt,bt 	: ARRAY[0..31] OF INTEGER;	(* Differenzen der RGBs	*)
  tcols		: ARRAY[0..5],[0..2] OF INTEGER;(* Farben der Steine	*)
  g		: ARRAY[0..6] OF I.Gadget;	(* für SelectMenü	*)
  tg		: ARRAY[0..2] OF I.Gadget;	(* für Tournament-Req	*)
  hg		: ARRAY[0..6] OF I.Gadget;	(* für Help-Requester	*)
  score,quad	: ARRAY[0..1] OF LONGINT;
  helps		: ARRAY[0..1] OF SHORTINT;
  player	: SHORTINT;
  stack		: TileStack;			(* Steinstapel		*)
  tourstack	: TileStack;			(* ditto für Tournament *)
  stackpos,
  lastpos	: INTEGER;
  field		: ARRAY[0..11],[0..7] OF SHORTINT;	(* Spielfeld	*)
		  (* leere Felder auf -1 setzen!!! *)
  values	: ARRAY[0..1],[1..4] OF INTEGER; (* Punkte für 1 - 4Way	*)
  intournament,
  restart	: BOOLEAN;
  movetab	: ARRAY[0..71] OF RECORD
  			            x,y  : SHORTINT;
  			            score,quad : ARRAY[0..1] OF LONGINT;
  			          END;

  scstr	   : ARRAY[0..2],[0..9] OF ARRAY[0..5] OF CHAR;
  qustr	   : ARRAY[0..2],[0..9] OF ARRAY[0..1] OF CHAR;
  ststr	   : ARRAY[0..2],[0..9] OF ARRAY[0..1] OF CHAR;
  hiscores : ARRAY[0..2],[0..9] OF HiScoreEntry;
  namegad  : I.Gadget;
  namestr,
  undo     : ARRAY[0..NAMELEN+2] OF CHAR;
  nameinfo : I.StringInfo;
  gpos     : INTEGER;
  soundstate : SHORTINT;

(*------------------------------------------------------------------------
    Buffert aktuellen Screeninhalt in Backup-Bitmap
------------------------------------------------------------------------*)

PROCEDURE BackupScreen;

  VAR
    act : LONGCARD;

  BEGIN
    act:=GL.BltBitMap(ADR(scr^.bitMap),0,0,
    		      ADR(bbm),0,0,
    		      320,200,0C0H,0FFH,NIL);
  END BackupScreen;

(*------------------------------------------------------------------------
    Schreibt Backup-Buffer wieder in den Screen
------------------------------------------------------------------------*)

PROCEDURE RestoreScreen;

  VAR
    act : LONGCARD;

  BEGIN
    GL.WaitTOF();			     (* Damit's nicht flackert 	*)
    act:=GL.BltBitMap(ADR(bbm),0,0,
    		      ADR(scr^.bitMap),0,0,
    		      320,200,0C0H,0FFH,NIL);
  END RestoreScreen;

(*------------------------------------------------------------------------
    Zeichnet Rahmen von x0,y0 bis x1,y1 mit Farbe lucol links und oben,
    rdcol rechts und unten.
------------------------------------------------------------------------*)

PROCEDURE Frame(x0,y0,x1,y1,lucol,rdcol:INTEGER);
  BEGIN
    GL.SetAPen(rp,lucol);
    GL.Move(rp,x0,y1); GL.Draw(rp,x0,y0); GL.Draw(rp,x1,y0);
    GL.SetAPen(rp,rdcol);
    GL.Draw(rp,x1,y1); GL.Draw(rp,x0,y1);
  END Frame;

(*------------------------------------------------------------------------
    Schreibt txt mit Schatten.
------------------------------------------------------------------------*)

PROCEDURE PrintShadow(x,y:INTEGER;
		      txt:ARRAY OF CHAR;
		      l,col:INTEGER);

  BEGIN
    GL.SetDrMd(rp,G.jam1);
    GL.SetAPen(rp,0);
    GL.RectFill(rp,x,y-6,x+7*l+1,y+2);		(* Löscht Platz.	*)
    GL.SetAPen(rp,21);				(* Schreibt Schatten	*)
    GL.Move(rp,x+1,y+1);
    GL.Text(rp,ADR(txt),l);
    GL.SetAPen(rp,col);				(* Schreibt txt		*)
    GL.Move(rp,x,y);
    GL.Text(rp,ADR(txt),l);
  END PrintShadow;

(*------------------------------------------------------------------------
    Wartet auf Maus oder Tastendruck, und gibt den Code der Taste,
    oder die Mauskoordinaten zurück.
------------------------------------------------------------------------*)

PROCEDURE GetMsg(VAR x,y:INTEGER;
                 VAR key:CARDINAL;
                 VAR gid:INTEGER);

  VAR
    msg	: I.IntuiMessagePtr;
    hlp : POINTER TO I.Gadget;

  BEGIN
    key:=0;
    gid:=0;
    LOOP
      EL.WaitPort(win^.userPort);
      msg:=EL.GetMsg(win^.userPort);
      EL.ReplyMsg(msg);
      IF (I.mouseButtons IN msg^.class) AND	(* Gibt Mauskoordinaten	*)
         (msg^.code=I.selectDown) THEN		(* nur bei Drücken zur.	*)
        x:=msg^.mouseX;
        y:=msg^.mouseY;
        EXIT;
      ELSIF (I.rawKey IN msg^.class) AND	(* Gibt Tastencode nur	*)
            (msg^.code>upPrefix) THEN		(* beim Loslassen zurück*)
        key:=msg^.code;
        EXIT;
      ELSIF (I.gadgetUp IN msg^.class) THEN
        hlp:=msg^.iAddress;			(* liest Gadget ID aus	*)
        gid:=hlp^.gadgetID;
        EXIT;
      END;
    END;
  END GetMsg;

(*------------------------------------------------------------------------
    Wartet auf eine Taste, oder Mausclick
------------------------------------------------------------------------*)

PROCEDURE WaitForKey;

  VAR
    x,y,gid : INTEGER;
    key     : CARDINAL;

  BEGIN
    GetMsg(x,y,key,gid);
  END WaitForKey;

(*------------------------------------------------------------------------
    Enthält Farbtabelle für den Screen.
------------------------------------------------------------------------*)

PROCEDURE ColorTable; (*$ EntryExitCode:=FALSE *)

  BEGIN
    ASSEMBLE(DC.W $DB8,$F85,$D00,$800,$7E7,$0A0,$060,$0AF
             DC.W $15F,$138,$D7D,$D0D,$708,$FD8,$EA0,$A70
             DC.W $FFF,$F00,$000,$FDA,$CA7,$A85,$A85,$ADE
             DC.W $0CC,$087,$444,$666,$888,$FFF,$000,$888
             END);
  END ColorTable;

(*------------------------------------------------------------------------
    Splittet einen Farbwert in seine RGB Anteile
------------------------------------------------------------------------*)

PROCEDURE SplitRGB(col:LONGINT; VAR r,g,b:INTEGER);

  BEGIN
    r:=col DIV 0100H;
    g:=(col MOD 100H) DIV 010H;
    b:=col MOD 010H;
  END SplitRGB;

(*------------------------------------------------------------------------
    Spaltet Code in Farbe und Symbol.
------------------------------------------------------------------------*)

PROCEDURE Decode(code:SHORTINT; VAR col,sym:INTEGER);

  BEGIN
    col:=code DIV 6;		(* berechnet Farbteil des Codes		*)
    sym:=code MOD 6;		(* berechnet Symbolteil des Codes	*)
  END Decode;

(*------------------------------------------------------------------------
    Blendet ein Bild weich ein (die Farben die in colors gesetzt sind)
------------------------------------------------------------------------*)

PROCEDURE FadeIn(colors:LONGSET;rate:INTEGER);

  VAR
    i,j,r,g,b:INTEGER;

  BEGIN
    FOR i:=1 TO rate DO
      FOR j:=1 TO 31 DO
        IF j IN colors THEN		(* ist Farbe gesetzt?		*)
          r:=rs[j]+(i*rt[j])/rate;	(* berechnet die neuen Farben	*)
          g:=gs[j]+(i*gt[j])/rate;
          b:=bs[j]+(i*bt[j])/rate;
          GL.SetRGB4(ADR(scr^.viewPort),j,r,g,b);
        END;
      END;
    END;
  END FadeIn;

(*------------------------------------------------------------------------
    Blendet ein Bild weich aus (die Farben die in colors gesetzt sind)
------------------------------------------------------------------------*)

PROCEDURE FadeOut(colors:LONGSET;rate:INTEGER);

  VAR
    i,j,r,g,b:INTEGER;

  BEGIN
    FOR i:=(rate-1) TO 0 BY -1 DO
      FOR j:=1 TO 31 DO
        IF j IN colors THEN		(* ist Farbe gesetzt		*)
          r:=rs[j]+(i*rt[j])/rate;	(* berechnet die neuen Farben	*)
          g:=gs[j]+(i*gt[j])/rate;
          b:=bs[j]+(i*bt[j])/rate;
          GL.SetRGB4(ADR(scr^.viewPort),j,r,g,b);
        END;
      END;
    END;
  END FadeOut;

(*------------------------------------------------------------------------
    Blittet von Bitmap sbm nach scr^.bitMap
------------------------------------------------------------------------*)

PROCEDURE MyBlit(srcx,srcy,destx,desty,width,height:INTEGER);

  VAR act : LONGCARD;

  BEGIN
    act:=GL.BltBitMap(ADR(gbm),srcx,srcy,
    		      ADR(scr^.bitMap),destx,desty,
    		      width,height,0C0H,0FFH,NIL);
  END MyBlit;

(*------------------------------------------------------------------------
    Schaltet Sound um
------------------------------------------------------------------------*)

PROCEDURE ShowSound;

  BEGIN
    CASE soundstate OF
    | 0 : PrintShadow(209,110,"MUSIC  ",7,16);
    | 1 : PrintShadow(209,110,"EFFECTS",7,16);
    | 2 : PrintShadow(209,110,"SILENCE",7,16);
    ELSE;
    END;
  END ShowSound;

(*------------------------------------------------------------------------
    Zeigt Stein am TouchStone.
------------------------------------------------------------------------*)

PROCEDURE ShowOnTouchstone(code:SHORTINT;stackpos:INTEGER);

  VAR
    col,sym,x,y	: INTEGER;

  BEGIN
    Decode(code,col,sym);		(* bestimmt Farbe und Symbol	*)
    GL.SetRGB4(ADR(scr^.viewPort),20,r0,g0,b0);
    GL.SetRGB4(ADR(scr^.viewPort),22,r0,g0,b0);
    GL.SetRGB4(ADR(scr^.viewPort),26,r0,g0,b0);
    GL.SetRGB4(ADR(scr^.viewPort),27,r0,g0,b0);
    GL.SetRGB4(ADR(scr^.viewPort),29,r0,g0,b0);
    GL.SetRGB4(ADR(scr^.viewPort),30,r0,g0,b0);
    GL.SetRGB4(ADR(scr^.viewPort),31,r0,g0,b0);

    (*--- Dem Spezialstein die aktuelle Farbe verpassen ----------------*)

    rt[20]:=rt[tcols[col,0]];
    gt[20]:=gt[tcols[col,0]];
    bt[20]:=bt[tcols[col,0]];
    rt[26]:=rt[tcols[col,1]];
    gt[26]:=gt[tcols[col,1]];
    bt[26]:=bt[tcols[col,1]];
    rt[27]:=rt[tcols[col,2]];
    gt[27]:=gt[tcols[col,2]];
    bt[27]:=bt[tcols[col,2]];

    x:=254+((stackpos-6) MOD 6)*10;	(* berechnet Pos. des kleinen 	*)
    y:=81+((stackpos-6) DIV 6)*8;	(* Steins (rechts unten)	*)
    GL.SetAPen(rp,0);
    GL.RectFill(rp,x,y,x+6,y+6);	    (* löscht kleinen Stein	*)
    GL.SetAPen(rp,22);			    (* zeichnet Schatten	*)
    GL.RectFill(rp,274,46,292,64);	    (* des Steins		*)
    MyBlit(120,sym*20,273,45,19,19);        (* blittet Specialstein	*)
    FadeIn(SPECIALCOLORS,20);		    (* einblenden (WHOW!)	*)
    GL.SetAPen(rp,21);			    (* zeichnet Schatten	*)
    GL.RectFill(rp,274,46,292,64);	    (* des Steins richtig	*)
    MyBlit(col*20,sym*20,273,45,19,19);     (* blittet den richtigen St.*)
  END ShowOnTouchstone;

(*------------------------------------------------------------------------
    Löscht Touchstone
------------------------------------------------------------------------*)

PROCEDURE ClearTouchstone;

  BEGIN
    MyBlit(242,74,250,34,65,41);
  END ClearTouchstone;

(*------------------------------------------------------------------------
    Zeigt Auswahlmenü auf Screen
------------------------------------------------------------------------*)

PROCEDURE ShowSelectScreen;

  BEGIN
    FadeOut(ALLCOLORS,FADERATE);
    IL.SetPointer(win,ADR(NormPtrData),9,16,0,0);
    GL.SetRast(rp,0);
    MyBlit(0,120,0,0,320,20);
    MyBlit(0,140,0,180,320,20);
    Frame(0,21,319,178,19,21);
    PrintShadow(115,40,"AVALON UnLtd.",13,8);
    PrintShadow(103,54,"proudly presents",16,13);
    MyBlit(143,36,85,63,151,17);
    MyBlit(151,81,34,104,9,9);
    PrintShadow(45,110,"SINGLE PLAYER",13,16);
    MyBlit(160,81,34,114,9,9);
    PrintShadow(45,120,"TWO PLAYERS",11,16);
    MyBlit(169,81,34,124,9,9);
    PrintShadow(45,130,"TOURNAMENT",10,16);
    MyBlit(178,81,198,104,9,9);
    ShowSound;
    MyBlit(187,81,198,114,9,9);
    PrintShadow(209,120,"CREDITS",7,16);
    MyBlit(196,81,198,124,9,9);
    PrintShadow(209,130,"HIGH SCORES",11,16);
    MyBlit(205,81,126,151,9,9);
    PrintShadow(137,157,"QUIT OUT",8,16);
    FadeIn(ALLCOLORS,FADERATE);
  END ShowSelectScreen;

(*------------------------------------------------------------------------
    Zeigt Credits-Screen
------------------------------------------------------------------------*)

PROCEDURE Credits;

  BEGIN
    FadeOut(ALLCOLORS,FADERATE);
    GL.SetAPen(rp,0);
    GL.RectFill(rp,2,82,317,174);
    PrintShadow(13,97,"Program,",8,16);
    PrintShadow(13,107,"Graphics,",9,16);
    PrintShadow(13,117,"Sound ...............",21,16);
    PrintShadow(166,117,"Robert Brandner",15,8);
    PrintShadow(13,136,"Music composed by ...",21,16);
    PrintShadow(166,136,"Johann Sebastian Bach",21,8);
    PrintShadow(13,155,"Thanx to ............",21,16);
    PrintShadow(166,155,"Teijo Kinnunen (MED)",20,8);
    PrintShadow(76,165,"............",12,16);
    PrintShadow(166,165,"Christian Stiens",16,8);
    FadeIn(ALLCOLORS,FADERATE);
    WaitForKey;
  END Credits;

(*------------------------------------------------------------------------
    Zeigt Spiel-Screen
------------------------------------------------------------------------*)

PROCEDURE ShowPlayScreen;

  VAR
    i,x,y : INTEGER;

  BEGIN
    FadeOut(ALLCOLORS,FADERATE);
    GL.SetRast(rp,0);
    Frame(0,0,319,199,19,21);
    Frame(4,4,314,29,21,19);
    Frame(4,33,246,195,21,19);
    Frame(250,78,314,170,21,19);
    MyBlit(242,74,250,34,65,41);	(* Touchstone			*)
    MyBlit(143,36,84,9,151,17);		(* Titel			*)
    MyBlit(142,81,55,19,8,8);
    MyBlit(142,81,288,19,8,8);
    MyBlit(140,102,252,177,61,17);	(* Avalon Logo			*)
    PrintShadow(8,15,"PLAYER ONE",10,8);
    PrintShadow(241,15,"PLAYER TWO",10,8);
    GL.SetAPen(rp,21);
    GL.RectFill(rp,5,34,245,194);
    GL.SetAPen(rp,0);
    GL.RectFill(rp,25,54,225,174);
    GL.SetAPen(rp,18);
    FOR i:=0 TO 8 DO
      GL.Move(rp,5,34+i*20);
      GL.Draw(rp,245,34+i*20);
    END;
    FOR i:=0 TO 12 DO
      GL.Move(rp,5+i*20,34);
      GL.Draw(rp,5+i*20,194);
    END;
    FOR i:=6 TO 71 DO
      x:=254+((i-6) MOD 6)*10;		(* berechnet Pos. des kleinen 	*)
      y:=81+((i-6) DIV 6)*8;		(* Steins (rechts unten)	*)
      MyBlit(214,81,x,y,7,7);
    END;
    PrintShadow(8,25,"     0",6,16);  	(* zeigt Punkte an	*)
    PrintShadow(64,25," 0",2,16);     	(* zeigt Quads an	*)
    PrintShadow(241,25,"     0",6,16);  	(* zeigt Punkte an	*)
    PrintShadow(297,25," 0",2,16);     	(* zeigt Quads an	*)
    FadeIn(ALLCOLORS,FADERATE);
  END ShowPlayScreen;

(*------------------------------------------------------------------------
   Zeigt Steine im Stack an. (Hilfsfunktion)
------------------------------------------------------------------------*)

PROCEDURE ShowTiles(stack:TileStack; stackpos:INTEGER);

  VAR
    i,x,y,col,sym : INTEGER;

  BEGIN
    BackupScreen;
    GL.SetAPen(rp,0);
    GL.RectFill(rp,74,35,176,193);
    Frame(74,35,176,193,19,21);
    Frame(78,39,172,189,21,19);
    FOR i:=stackpos+1 TO 71 DO
      Decode(stack[i],col,sym);
      x:=83+(i MOD 6)*15;
      y:=31+(i DIV 6)*13;
      GL.SetAPen(rp,21);
      GL.RectFill(rp,x+1,y+1,x+11,y+11);	(* zeichnet Schatten	*)
      MyBlit(139+col*11+(sym DIV 3)*66,	        (* blittet kleinen 	*)
             (sym MOD 3)*11,x,y,11,11);		(* Stein		*)
    END;
    WaitForKey;
    RestoreScreen;
  END ShowTiles;

(*------------------------------------------------------------------------
    Erzeugt Requester für Helpfunktionen
------------------------------------------------------------------------*)

PROCEDURE ShowHelpRequest;

  BEGIN
    GL.SetAPen(rp,0);
    GL.RectFill(rp,36,47,281,151);
    Frame(36,47,281,151,19,21);
    Frame(40,52,277,147,21,19);
    PrintShadow(143,65,"HELP!",5,8);
    PrintShadow(54,77,  "Do you want help about possible",31,16);
    PrintShadow(47,87, "moves, the following tiles or do",32,16);
    PrintShadow(47,97, "you want to restart this stack? ",32,16);
    PrintShadow(47,107,"You can also undo or redo moves.",32,16);
    PrintShadow(58,126,"MOVES",5,16);
    PrintShadow(109,126,"TILES",5,16);
    PrintShadow(160,126,"RESTART",7,16);
    PrintShadow(58,138,"UNDO",4,16);
    PrintShadow(109,138,"REDO",4,16);
    PrintShadow(160,138,"END GAME",8,16);
    PrintShadow(229,126,"CANCEL",6,16);
    IF NOT intournament THEN
      MyBlit(160,81,47,120,9,9);
      MyBlit(160,81,98,120,9,9);
      MyBlit(160,81,47,132,9,9);
      MyBlit(160,81,98,132,9,9);
    ELSE
      MyBlit(159,71,46,119,10,10);
      MyBlit(159,71,97,119,10,10);
      MyBlit(159,71,46,131,10,10);
      MyBlit(159,71,97,131,10,10);
    END;
    MyBlit(151,81,149,120,9,9);
    MyBlit(151,81,149,132,9,9);
    MyBlit(205,81,218,120,9,9);
  END ShowHelpRequest;


(*------------------------------------------------------------------------
    Erzeugt Maske für Tournament-Requester
------------------------------------------------------------------------*)

PROCEDURE ShowTourScreen;

  BEGIN
    GL.SetAPen(rp,0);
    GL.RectFill(rp,1,85,318,177);
    Frame(54,87,264,166,19,21);
    Frame(58,91,260,162,21,19);
    PrintShadow(124,104,"TOURNAMENT",10,8);
    PrintShadow(65,116, "Do you want to continue the",27,16);
    PrintShadow(76,126, "current tournament or to",24,16);
    PrintShadow(104,136,"start a new one?",16,16);
    PrintShadow(76,153,"NEW",3,16);
    PrintShadow(127,153,"CONTINUE",8,16);
    PrintShadow(213,153,"CANCEL",6,16);
    MyBlit(151,81,65,147,9,9);
    MyBlit(160,81,116,147,9,9);
    MyBlit(205,81,202,147,9,9);
  END ShowTourScreen;

(*------------------------------------------------------------------------
    Prozedur für diverese Messages
------------------------------------------------------------------------*)

PROCEDURE Message(title,body1,body2:ARRAY OF CHAR);

  VAR
    len : INTEGER;

  BEGIN
    BackupScreen;
    GL.SetAPen(rp,0);
    GL.RectFill(rp,64,74,253,125);
    Frame(64,74,253,125,19,21);
    Frame(68,78,249,121,21,19);
    len:=Length(title);
    PrintShadow((320-len*7)/2,91,title,len,12);
    PrintShadow(82,103,body1,Length(body1),16);
    PrintShadow(75,113,body2,Length(body2),16);
    WaitForKey;
    RestoreScreen;
  END Message;

(*------------------------------------------------------------------------
    Zeigt alle möglichen Zugpositionen.
------------------------------------------------------------------------*)

PROCEDURE ShowPossibleMoves;
  BEGIN
    FadeIn(LONGSET{20,22},50);		(* fadet ganz langsam ein	*)
    DosL.Delay(50);			(* wartet kurz			*)
    FadeOut(LONGSET{20,22},50);		(* und fadet wieder aus		*)
    rs[22]:=r0; gs[22]:=g0; bs[22]:=b0;	(* setzt Farben wieder zurück	*)
    rt[22]:=rt[21];
    gt[22]:=gt[21];
    bt[22]:=bt[21];
    rt[20]:=rt[0];
    gt[20]:=gt[0];
    bt[20]:=bt[0];
  END ShowPossibleMoves;

(*------------------------------------------------------------------------
    Initialisiert Tabelle
------------------------------------------------------------------------*)

PROCEDURE InitHiScoreTable(n:INTEGER);

  VAR
    i	: INTEGER;

  BEGIN
    FOR i:=0 TO 9 DO
      hiscores[n,i].name:="........................";
      hiscores[n,i].score:=100-(i MOD 10)*10;
      hiscores[n,i].quads:=3-(i DIV 3);
      hiscores[n,i].helps:=0;
      hiscores[n,i].stonesleft:=i*4;
    END;
  END InitHiScoreTable;

(*------------------------------------------------------------------------
    Lädt HiScores
------------------------------------------------------------------------*)

PROCEDURE LoadHiScores;

  VAR
    f	: FS.File;
    n,i	: INTEGER;
    err : BOOLEAN;
    act	: LONGINT;

  BEGIN
    FS.Lookup(f,HISCORENAME,512,FALSE);
    IF f.res#FS.done THEN			(* nicht geöffnet ?!	*)
      FOR n:=0 TO 2 DO
        InitHiScoreTable(n);
      END;
    ELSE
      FOR n:=0 TO 2 DO
        FOR i:=0 TO 9 DO
          FS.ReadByteBlock(f,hiscores[n,i]);
        END;
      END;
      FS.Close(f);
    END;
    FOR n:=0 TO 2 DO
      FOR i:=0 TO 9 DO
        WITH hiscores[n,i] DO
          ValToStr(score,FALSE,scstr[n,i],10,6,' ',err);
          ValToStr(quads,FALSE,qustr[n,i],10,2,' ',err);
          ValToStr(stonesleft,FALSE,ststr[n,i],10,2,' ',err);
        END;
      END;
    END;
  END LoadHiScores;

(*------------------------------------------------------------------------
    Speichert HiScores
------------------------------------------------------------------------*)

PROCEDURE SaveHiScores;

  VAR
    f	: FS.File;
    i,n	: INTEGER;
    act	: LONGINT;

  BEGIN
    FS.Lookup(f,HISCORENAME,512,TRUE);
    IF f.res=FS.done THEN
      FOR n:=0 TO 2 DO
        FOR i:=0 TO 9 DO
          FS.WriteByteBlock(f,hiscores[n,i]);
        END;
      END;
      FS.Close(f);
    END;
  END SaveHiScores;

(*------------------------------------------------------------------------
    Lädt aktuellen Tournament-Stack, falls vorhanden
------------------------------------------------------------------------*)

PROCEDURE LoadTournament(VAR tourstack:TileStack);

  VAR
    f	: FS.File;
    act	: LONGINT;

  BEGIN
    FS.Lookup(f,TOURNAMENTNAME,512,FALSE);
    IF f.res=FS.done THEN
      FS.ReadBytes(f,ADR(tourstack[0]),72,act);
      FS.Close(f);
    ELSE
      tourstack[0]:=-1;		(* Kennung, daß nichts geladen ist!	*)
    END;
  END LoadTournament;

(*------------------------------------------------------------------------
    Speichert aktuellen Tournament-Stack, falls vorhanden
------------------------------------------------------------------------*)

PROCEDURE SaveTournament(tourstack:TileStack);

  VAR
    f	: FS.File;
    act	: LONGINT;

  BEGIN
    IF tourstack[0]#-1 THEN	(* Nur wenn in tourstack was steht!	*)
      FS.Lookup(f,TOURNAMENTNAME,512,TRUE);
      IF f.res=FS.done THEN
        FS.WriteBytes(f,ADR(tourstack[0]),72,act);
 	FS.Close(f);
      END;
    END;
  END SaveTournament;

(*------------------------------------------------------------------------
    Zeigt das Highscoretabellen-Grundgerüst
------------------------------------------------------------------------*)

PROCEDURE HiScoreBackground(title:ARRAY OF CHAR);

  VAR
    len	: INTEGER;
    pos : ARRAY[0..1] OF CHAR;
    i   : INTEGER;
    err : BOOLEAN;

  BEGIN
    len:=Length(title);
    GL.SetRast(rp,0);
    MyBlit(0,120,0,0,320,20);
    MyBlit(0,140,0,180,320,20);
    Frame(0,21,319,178,19,21);
    MyBlit(140,55,79,25,160,16);	(* blittet Titel		*)
    PrintShadow((320-len*7)/2,54,title,len,8);
    Frame(7,62,312,171,21,19);
    FOR i:=0 TO 9 DO
      ValToStr((i+1),FALSE,pos,10,2,' ',err);
      PrintShadow(11,74+10*i,pos,2,12);		(* Position		*)
      PrintShadow(25,74+10*i,".",1,12);
      MyBlit(142,81,257,68+i*10,8,8);		(* Quad-Zeichen		*)
      MyBlit(214,81,285,68+i*10,7,7);		(* Stein-Zeichen	*)
    END;
  END HiScoreBackground;

(*------------------------------------------------------------------------
    Zeigt die Highscoretabellen
------------------------------------------------------------------------*)

PROCEDURE ShowHiScores(type : INTEGER);

  VAR
    str   : ARRAY[0..3] OF CHAR;
    err   : BOOLEAN;
    i,x,y : INTEGER;
    place : ARRAY[0..0] OF CHAR;
    helpw : INTEGER;

  BEGIN
    CASE type OF
    | SINGLE : HiScoreBackground("SINGLE PLAYERS");
    | TWOPLY : HiScoreBackground("TWO PLAYERS");
    | TOUR   : HiScoreBackground("TOURNAMENT");
    ELSE;
    END;
    FOR i:=0 TO 9 DO			(* gibt die Hiscores aus	*)
      y:=74+i*10;
      WITH hiscores[type,i] DO
        PrintShadow(36,y,name,Length(name),8);
        PrintShadow(210,y,scstr[type,i],6,16);
        PrintShadow(266,y,qustr[type,i],2,16);
        IF helps=0 THEN
          PrintShadow(294,y,ststr[type,i],2,16);
        ELSE
          GL.SetAPen(rp,0);
          GL.RectFill(rp,284,y-6,308,y+2);
	  CASE helps OF
	  | 1..5 : helpw:=19;
	  | 6..15: helpw:=21;
	  ELSE
	    helpw:=23;
	  END;
	  MyBlit(209,95,285,y-7,helpw,9);
	END;
      END;
    END;
  END ShowHiScores;

(*------------------------------------------------------------------------
    Stellt fest ob der Spieler in die HiScoreListe kommt und
    wenn, dann liest es seinen Namen ein, und trägt ihn ein.
    Ergebnis ist TRUE, wenn er in der HiScoreListe.
------------------------------------------------------------------------*)

PROCEDURE HiScore(score,quads:LONGINT;
		  helps,stonesleft:SHORTINT;
		  type:INTEGER);

  VAR
    pos,j,i,
    x,y,gid,
    helpw	: INTEGER;
    place   	: ARRAY[0..0] OF CHAR;
    key		: CARDINAL;
    err		: BOOLEAN;

  BEGIN
    pos:=0;
    WHILE (pos<10) AND				(* sucht Position 	*)
          (hiscores[type,pos].score>score) DO	(* in HiScoreListe	*)
      INC(pos);
    END;
    IF pos>9 THEN RETURN; END;			(* kein HiScore!	*)

    (*--- HiScoreTabelle -----------------------------------------------*)

    FadeOut(ALLCOLORS,FADERATE);
    ShowHiScores(type);
    FadeIn(ALLCOLORS,FADERATE);

    (*--- Nach unten/hinten verschieben --------------------------------*)

    FOR j:=9 TO pos+1 BY -1 DO			(* verschiebt andere	*)
      hiscores[type,j]:=hiscores[type,j-1];	(* nach hinten		*)
    END;
    hiscores[type,pos].name[0]:=CHAR(0);
    hiscores[type,pos].score:=score;		(* trägt die neuen	*)
    hiscores[type,pos].quads:=quads;		(* Werte ein		*)
    hiscores[type,pos].helps:=helps;
    hiscores[type,pos].stonesleft:=stonesleft;
    WITH hiscores[type,pos] DO
      ValToStr(score,FALSE,scstr[type,pos],10,6,' ',err);
      ValToStr(quads,FALSE,qustr[type,pos],10,2,' ',err);
      ValToStr(stonesleft,FALSE,ststr[type,pos],10,2,' ',err);
    END;

    FOR i:=0 TO 9 DO
      GL.ScrollRaster(rp,0,-1,33,74+pos*10-7,311,166);
      DosL.Delay(2);
    END;

    (*--- Namen eingeben -----------------------------------------------*)

    MyBlit(142,81,257,68+pos*10,8,8);		(* Quad-Zeichen		*)
    MyBlit(214,81,285,68+pos*10,7,7);		(* Stein-Zeichen	*)
    y:=74+pos*10;
    WITH hiscores[type,pos] DO			(* gibt zuerst Score	*)
      PrintShadow(210,y,scstr[type,pos],6,2);	(* etc. in rot aus	*)
      PrintShadow(266,y,qustr[type,pos],2,2);
      IF helps=0 THEN
        PrintShadow(294,y,ststr[type,pos],2,2);
      ELSE
        GL.SetAPen(rp,0);
        GL.RectFill(rp,284,y-6,308,y+2);
        CASE helps OF
        | 1..5 : helpw:=19;
        | 6..15: helpw:=21;
        ELSE
          helpw:=23;
        END;
        MyBlit(209,95,285,y-7,helpw,9);
      END;
    END;
    GL.SetRGB4(ADR(win^.wScreen^.viewPort),1,15,0,0); (* TextGadFarbe	*)
    namestr[0]:=CHAR(0);
    namegad.topEdge:=74+pos*10-6;

    gpos:=IL.AddGList(win,ADR(namegad),0,1,NIL);

    IL.RefreshGadgets(ADR(namegad),win,NIL);
    REPEAT UNTIL IL.ActivateGadget(ADR(namegad),win,NIL);
    REPEAT
      GetMsg(x,y,key,gid);		(* wartet auf RETURN Taste 	*)
    UNTIL key#0;
    gpos:=IL.RemoveGList(win,ADR(namegad),1);
    Copy(hiscores[type,pos].name,namestr);
    y:=74+pos*10;
    WITH hiscores[type,pos] DO			(* gibt Text etc. in	*)
      PrintShadow(36,y,namestr,Length(namestr),8);
      PrintShadow(210,y,scstr[type,pos],6,16);
      PrintShadow(266,y,qustr[type,pos],2,16);
      IF helps=0 THEN
        PrintShadow(294,y,ststr[type,pos],2,16);
      END;
    END;
    GL.SetRGB4(ADR(win^.wScreen^.viewPort),1,15,8,5);
    SaveHiScores;
    WaitForKey;
  END HiScore;


(*------------------------------------------------------------------------
    Erzeugt Gadgetlisten für den SelectScreen und Tournament
------------------------------------------------------------------------*)

PROCEDURE MakeGadgets;

  VAR
    i	: INTEGER;

  BEGIN

    MakeStrGad(namegad,36,0,180,11,NAMEID,ADR(namestr),NAMELEN);

    (*--- Gadgets für SelectScreen -------------------------------------*)

    MakeBoolGad(g[0],34,104,8,8,PLY1ID);
    MakeBoolGad(g[1],34,114,8,8,PLY2ID);
    MakeBoolGad(g[2],34,124,8,8,TOURID);
    MakeBoolGad(g[3],198,104,8,8,SOUNDID);
    MakeBoolGad(g[4],198,114,8,8,CREDID);
    MakeBoolGad(g[5],198,124,8,8,HISCID);
    MakeBoolGad(g[6],126,151,8,8,QUITID);
    FOR i:=0 TO 5 DO
      g[i].nextGadget:=ADR(g[i+1]);
      g[i].flags:=I.GadgetFlagSet{I.gadgHBox,I.gadgHImage}; (* = none 	*)
    END;
    g[6].nextGadget:=NIL;
    g[6].flags:=I.GadgetFlagSet{I.gadgHBox,I.gadgHImage};   (* = none 	*)

    (*--- Gadgets für Tournament-Requester -----------------------------*)

    MakeBoolGad(tg[0],65,147,8,8,TNEWID);
    MakeBoolGad(tg[1],116,147,8,8,TCONTID);
    MakeBoolGad(tg[2],202,147,8,8,TCANCID);
    FOR i:=0 TO 1 DO
      tg[i].nextGadget:=ADR(tg[i+1]);
      tg[i].flags:=I.GadgetFlagSet{I.gadgHBox,I.gadgHImage}; (* = none 	*)
    END;
    tg[2].nextGadget:=NIL;
    tg[2].flags:=I.GadgetFlagSet{I.gadgHBox,I.gadgHImage};   (* = none 	*)

    (*--- Gadgets für Help-Requester -----------------------------------*)

    MakeBoolGad(hg[0],47,120,8,8,H1ID);
    MakeBoolGad(hg[1],98,120,8,8,H2ID);
    MakeBoolGad(hg[2],149,120,8,8,H3ID);
    MakeBoolGad(hg[3],47,132,8,8,H4ID);
    MakeBoolGad(hg[4],98,132,8,8,H5ID);
    MakeBoolGad(hg[5],149,132,8,8,H6ID);
    MakeBoolGad(hg[6],218,120,8,8,H7ID);

    FOR i:=0 TO 5 DO
      hg[i].nextGadget:=ADR(hg[i+1]);
      hg[i].flags:=I.GadgetFlagSet{I.gadgHBox,I.gadgHImage}; (* = none 	*)
    END;
    hg[6].nextGadget:=NIL;
    hg[6].flags:=I.GadgetFlagSet{I.gadgHBox,I.gadgHImage};   (* = none 	*)
  END MakeGadgets;

(*------------------------------------------------------------------------
    Zeigt an, wenn ein Quad geschafft wurde (in NewScore aufrufen)
------------------------------------------------------------------------*)

PROCEDURE FlashQuad(x,y:INTEGER);

  VAR
    a,b,i	: INTEGER;

  BEGIN
    a:=5+x*20;
    b:=34+y*20;
    GL.SetRGB4(ADR(scr^.viewPort),30,0,0,0);
    rs[30]:=0; gs[30]:=0; bs[30]:=0;
    rt[30]:=15; gt[30]:=15; bt[30]:=15;
    GL.SetAPen(rp,30);
    GL.Move(rp,a,b-20);
    GL.Draw(rp,a+20,b-20);
    GL.Draw(rp,a+20,b+40);
    GL.Draw(rp,a,b+40);
    GL.Draw(rp,a,b-20);

    GL.Move(rp,a-20,b);
    GL.Draw(rp,a+40,b);
    GL.Draw(rp,a+40,b+20);
    GL.Draw(rp,a-20,b+20);
    GL.Draw(rp,a-20,b);
    FadeIn(LONGSET{30},150);		(* fadet ganz langsam ein	*)
    DosL.Delay(15);			(* wartet kurz			*)
    FadeOut(LONGSET{30},150);		(* und fadet wieder aus		*)
    GL.SetAPen(rp,18);
    GL.Move(rp,a,b-20);
    GL.Draw(rp,a+20,b-20);
    GL.Draw(rp,a+20,b+40);
    GL.Draw(rp,a,b+40);
    GL.Draw(rp,a,b-20);
    GL.Move(rp,a-20,b);
    GL.Draw(rp,a+40,b);
    GL.Draw(rp,a+40,b+20);
    GL.Draw(rp,a-20,b+20);
    GL.Draw(rp,a-20,b);

    rs[30]:=r0; gs[30]:=g0; bs[30]:=b0;
    rt[30]:=0-r0; gt[30]:=0-g0; bt[30]:=0-b0;
  END FlashQuad;

(*------------------------------------------------------------------------
    Berechnet neuen Punktestand für einen Spieler, und zeigt ihn an.
------------------------------------------------------------------------*)

PROCEDURE NewScore(x,y,player,num:INTEGER);

  VAR
    i 	: INTEGER;
    str : ARRAY[0..5] OF CHAR;
    err : BOOLEAN;

  BEGIN
    INC(score[player],values[player,num]);
    IF num=4 THEN 			(* 4 Way!	 		*)
      FlashQuad(x,y);
      FOR i:=1 TO 4 DO			(* Ab jetzt zählt alles doppelt *)
        values[player,i]:=values[player,i]*2;
      END;
      INC(quad[player]);
      CASE quad[player] OF		(* vergibt Boni für Quads	*)
      | 1 : INC(score[player],25);
      | 2 : INC(score[player],50);
      | 3 : INC(score[player],100);
      | 4 : INC(score[player],200);
      | 5 : INC(score[player],400);
      | 6 : INC(score[player],600);
      | 7 : INC(score[player],800);
      | 8 : INC(score[player],1000);
      | 9 : INC(score[player],5000);
      |10 : INC(score[player],10000);
      |11 : INC(score[player],25000);
      |12 : INC(score[player],50000);
      ELSE
        INC(score[player],100000);
      END;
      ValToStr(quad[player],FALSE,str,10,2,' ',err);
      PrintShadow(64+player*233,25,str,2,16);     (* zeigt Quads an	*)
    END;
    ValToStr(score[player],FALSE,str,10,6,' ',err);
    PrintShadow(8+player*233,25,str,6,16);	(* zeigt Punkte an	*)
  END NewScore;

(*------------------------------------------------------------------------
    Setzt Stein code an Pos. x,y im Array und in der Grafik.
------------------------------------------------------------------------*)

PROCEDURE PutTile(code,x,y:INTEGER);

  VAR
    col,
    sym	: INTEGER;

  BEGIN
    Decode(code,col,sym);		(* holt Farbe und Symbol	*)
    field[x,y]:=code;			(* setzt Stein im Array		*)
    GL.WaitTOF();			(* damit's nicht flackert	*)
    MyBlit(col*20,sym*20,		(* blittet den Stein 		*)
           6+x*20,35+y*20,19,19);
  END PutTile;

(*------------------------------------------------------------------------
    Erzeugt in stack eine Liste mit zufällig geordneten Steinen, wobei
    die ersten 6 sich in Farbe und Symbol unterscheiden (Startsteine).
------------------------------------------------------------------------*)

PROCEDURE CreateTileStack(VAR stack:TileStack);

  CONST
    TIMES=11;

  VAR
    stcol,stsym	: ARRAY[0..5] OF BOOLEAN;
    used	: ARRAY[0..35] OF BOOLEAN;
    i,j,col,sym,
    code,a,b,c	: INTEGER;
    istart	: BOOLEAN;
    pos		: INTEGER;
    hstack	: ARRAY[0..1] OF TileStack;
    actstack,k	: INTEGER;

  BEGIN
    FOR i:=0 TO 71 DO				(* initialisiert Stack	*)
      stack[i]:=-1;
      hstack[0,i]:=-1;
      hstack[1,i]:=-1;
    END;
    FOR i:=0 TO 35 DO used[i]:=FALSE; END;	(* und Merktafel	*)

    (*--- Zuerst wählen wir die 6 Anfangssteine ------------------------*)

    FOR i:=0 TO 5 DO			(* markiert alle Farben und	*)
      stcol[i]:=FALSE; stsym[i]:=FALSE;	(* Symbole als unbenutzt.	*)
    END;

    FOR i:=0 TO 5 DO			(* Für die 6 Anfangssteine	*)
      REPEAT				(* sucht noch unbenutzte Farbe	*)
        col:=RND(6);
      UNTIL NOT stcol[col];
      stcol[col]:=TRUE;			(* markiert sie als benutzt	*)
      REPEAT				(* sucht noch unbenutztes Symb.	*)
        sym:=RND(6);
      UNTIL NOT stsym[sym];
      stsym[sym]:=TRUE;			(* markiert es als benutzt	*)

      stack[i]:=col*6+sym;		(* schreibt Steincode in Stapel	*)
      used[col*6+sym]:=TRUE;
    END;

    (*--- Zuerst geordnet hinschreiben ---------------------------------*)

    pos:=6;
    actstack:=0;
    FOR i:=0 TO 35 DO
      IF NOT used[i] THEN		(* nur unbenutzte Steine	*)
        hstack[0,pos]:=i;
        INC(pos);
      END;
      hstack[0,36+i]:=i;
    END;

    (*--- TIMES mal mischen --------------------------------------------*)

    FOR k:=1 TO TIMES DO
      PutSeed(GL.VBeamPos()*RND(16383)*GL.VBeamPos());

      actstack:=1-actstack;

      FOR i:=6 TO 71 DO hstack[actstack,i]:=-1; END;

      FOR i:=6 TO 71 DO
        pos:=6+RND(66);				(* wählt Platz		*)
        WHILE (hstack[actstack,pos]#-1) DO 	(* überspringt belegte	*)
          INC(pos);				(* Plätze		*)
          IF pos=72 THEN pos:=6; END;
        END;
        hstack[actstack,pos]:=hstack[1-actstack,i];
      END;
    END;
    FOR i:=6 TO 71 DO
      stack[i]:=hstack[actstack,i];
    END;
  END CreateTileStack;

(*------------------------------------------------------------------------
    Zählt wieviele Nachbarn in Farbe und/oder Symbol übereinstimmen.
    Für CheckOkay und Punkteberechnung.
------------------------------------------------------------------------*)

PROCEDURE Count(code,x,y:INTEGER;
                VAR cols,syms:INTEGER;
                VAR num:INTEGER;	(* # Nachbarn	*)
		VAR check:BOOLEAN);

  VAR
    col,sym,
    hcol,hsym	: INTEGER;

  BEGIN
    Decode(code,col,sym);	(* bestimmt Farbe und Symbol des Steins	*)
    cols:=0; syms:=0;		(* Zahl übereinstimmender Farben und S.	*)
    check:=TRUE;
    num:=0;

    (*--- linkes Nachbarfeld testen ------------------------------------*)

    IF (x>0) AND		(* gibt es ein linkes Nachbarfeld?	*)
       (field[x-1,y]>=0) THEN	(* liegt ein Stein drauf?		*)
      INC(num);			(* ja!					*)
      Decode(field[x-1,y],hcol,hsym);
      IF hcol=col THEN		(* stimmt Farbe überein?		*)
        INC(cols);		(* ja, dann Zähler erhöhen		*)
      END;
      IF hsym=sym THEN		(* stimmt Symbol überein?		*)
        INC(syms);		(* ja, dann Zähler erhöhen		*)
      END;
      IF (hcol#col) AND (hsym#sym) THEN
        check:=FALSE; RETURN;
      END;
    END;

    (*--- oberes Nachbarfeld testen ------------------------------------*)

    IF (y>0) AND (field[x,y-1]>=0) THEN
      INC(num);
      Decode(field[x,y-1],hcol,hsym);
      IF hcol=col THEN INC(cols); END;
      IF hsym=sym THEN INC(syms); END;
      IF (hcol#col) AND (hsym#sym) THEN
        check:=FALSE; RETURN;
      END;
    END;

    (*--- rechtes Nachbarfeld testen -----------------------------------*)

    IF (x<11) AND (field[x+1,y]>=0) THEN
      INC(num);
      Decode(field[x+1,y],hcol,hsym);
      IF hcol=col THEN INC(cols); END;
      IF hsym=sym THEN INC(syms); END;
      IF (hcol#col) AND (hsym#sym) THEN
        check:=FALSE; RETURN;
      END;
    END;

    (*--- unteres Nachbarfeld testen -----------------------------------*)

    IF (y<7) AND (field[x,y+1]>=0) THEN
      INC(num);
      Decode(field[x,y+1],hcol,hsym);
      IF hcol=col THEN INC(cols); END;
      IF hsym=sym THEN INC(syms); END;
      IF (hcol#col) AND (hsym#sym) THEN
        check:=FALSE; RETURN;
      END;
    END;
  END Count;

(*------------------------------------------------------------------------
    Überprüft, ob Stein code an Stelle x,y abgelegt werden darf.
    Nämlich nur dann, wenn
    a) NUR Steine benachbart sind, die in Farbe/Symbol übereinstimmen
    b) mindest. 1 Nachbar vorhanden ist
    c) wenn sich die Anzahl der Farben und die Anzahl der Symbole
       höchstens um 1 unterscheiden.
------------------------------------------------------------------------*)

PROCEDURE CheckOkay(code,x,y:INTEGER; VAR num:INTEGER):BOOLEAN;

  VAR
    check	: BOOLEAN;
    cols,syms	: INTEGER;

  BEGIN
    IF field[x,y]#-1 THEN	(* Ist Feld noch frei?			*)
      RETURN FALSE;		(* wenn nicht dann nicht okay!		*)
    END;

    Count(code,x,y,cols,syms,num,check);
    RETURN (check AND (num>0) AND (ABS(cols-syms)<2));
  END CheckOkay;

(*------------------------------------------------------------------------
    Stellt fest, ob noch ein Zug möglich ist.
------------------------------------------------------------------------*)

PROCEDURE MovePossible(code:SHORTINT):BOOLEAN;

  VAR
    i,j,d1 : INTEGER;

  BEGIN
    FOR i:=0 TO 11 DO
      FOR j:=0 TO 7 DO
        IF CheckOkay(code,i,j,d1) THEN	(* Testet, ob Zug möglich  	*)
          RETURN TRUE;			(* ja! fertig			*)
        END;
      END;
    END;
    RETURN FALSE;			(* kein Zug mehr möglich!	*)
  END MovePossible;

(*------------------------------------------------------------------------
    Zeigt restliche Steine an
------------------------------------------------------------------------*)

PROCEDURE HelpTiles;

  BEGIN
    IF NOT intournament THEN
      INC(helps[0],1);		(* für beide, da es ja beiden hilft!	*)
      INC(helps[1],1);		(* und im SingleMode stört's auch nicht *)
      ShowTiles(stack,stackpos);
    ELSE
      Message("SORRY, NO HELP!",
    	      "There is no help avail-",
      	      "able in tournament mode!");

    END;
  END HelpTiles;

(*------------------------------------------------------------------------
    Zeigt alle möglichen Züge an.
------------------------------------------------------------------------*)

PROCEDURE HelpPossibleMoves(code:INTEGER);

  VAR
    x,y,
    num,
    a,b,count : INTEGER;

  BEGIN
    IF intournament THEN
      Message("SORRY, NO HELP!",
      	      "There is no help avail-",
      	      "able in tournament mode!");
    ELSE
      count:=0;
      INC(helps[player],1);
      GL.SetRGB4(ADR(scr^.viewPort),20,r0,g0,b0); (* für normale Felder	*)
      GL.SetRGB4(ADR(scr^.viewPort),22,10,8,5);	(* für Randfelder	*)
      rs[22]:=10; gs[22]:=8; bs[22]:=5;	(* Andere Anfangsfarben setzen	*)
      rs[20]:=r0; gs[20]:=g0; bs[20]:=b0;
      rt[20]:=15-rs[20]; gt[20]:=15-gs[20]; bt[20]:=15-bs[20];
      rt[22]:=15-rs[22]; gt[22]:=15-gs[22]; bt[22]:=15-bs[22];
      FOR x:=0 TO 11 DO
        FOR y:=0 TO 7 DO
          IF CheckOkay(code,x,y,num) THEN
            INC(count);
            IF (x=0) OR (y=0) OR (x=11) OR (y=7) THEN
	      GL.SetAPen(rp,22);
            ELSE
              GL.SetAPen(rp,20);
            END;
            a:=6+x*20;
            b:=35+y*20;
            GL.RectFill(rp,a,b,a+18,b+18);
          END;
        END;
      END;
      IF count=0 THEN
	 Message("NO MORE MOVES!",
          	 "Sorry, but there are no",
  		 "more moves possible!");
        RETURN;
      END;
      ShowPossibleMoves;
      FOR x:=0 TO 11 DO
        FOR y:=0 TO 7 DO
          IF CheckOkay(code,x,y,num) THEN
            IF (x=0) OR (y=0) OR (x=11) OR (y=7) THEN
	      GL.SetAPen(rp,21);
            ELSE
              GL.SetAPen(rp,0);
            END;
            a:=6+x*20;
            b:=35+y*20;
            GL.RectFill(rp,a,b,a+18,b+18);
          END;
        END;
      END;
    END;
  END HelpPossibleMoves;

(*------------------------------------------------------------------------
    Undo Funktion
------------------------------------------------------------------------*)

PROCEDURE Undo(two:BOOLEAN):BOOLEAN;

  VAR
    x,y	: INTEGER;
    err : BOOLEAN;
    str : ARRAY[0..5] OF CHAR;

  BEGIN
    IF intournament THEN
      Message("SORRY, NO HELP!",
      	      "There is no help avail-",
      	      "able in tournament mode!");
      RETURN FALSE;
    ELSIF stackpos<=6 THEN
      RETURN FALSE;
    ELSE
      INC(helps[player]);			(* Hilfezähler erhöhen *)

      (*--- aktuellen Stein zurücklegen ---*)

      ClearTouchstone;
      MyBlit(214,81,254+((stackpos-6) MOD 6)*10,
      	     81+((stackpos-6) DIV 6)*8,7,7);

      (*--- vorigen Stein vom Brett nehmen ---*)

      DEC(stackpos);
      x:=movetab[stackpos].x;
      y:=movetab[stackpos].y;
      field[x,y]:=-1;
      IF (x=0) OR (x=11) OR (y=0) OR (y=7) THEN
        GL.SetAPen(rp,21);
      ELSE
        GL.SetAPen(rp,0);
      END;
      GL.RectFill(rp,6+x*20,35+y*20,6+x*20+18,35+y*20+18);
      score[0]:=movetab[stackpos-1].score[0];
      score[1]:=movetab[stackpos-1].score[1];
      IF quad[0]>movetab[stackpos-1].quad[0] THEN
        FOR i:=1 TO 4 DO
          values[0,i]:=values[0,i]/2;
        END;
      END;
      IF quad[1]>movetab[stackpos-1].quad[1] THEN
        FOR i:=1 TO 4 DO
          values[1,i]:=values[1,i]/2;
        END;
      END;
      quad[0]:=movetab[stackpos-1].quad[0];
      quad[1]:=movetab[stackpos-1].quad[1];

      ValToStr(quad[player],FALSE,str,10,2,' ',err);
      PrintShadow(64+player*233,25,str,2,16);     (* zeigt Quads an	*)
      ValToStr(score[player],FALSE,str,10,6,' ',err);
      PrintShadow(8+player*233,25,str,6,16);	(* zeigt Punkte an	*)

      IF two THEN
        player:=1-player;
      END;
      RETURN TRUE;
    END;
  END Undo;

(*------------------------------------------------------------------------
    Redo Funktion
------------------------------------------------------------------------*)

PROCEDURE Redo(two:BOOLEAN):BOOLEAN;

  VAR
    x,y	: INTEGER;
    err : BOOLEAN;
    str : ARRAY[0..5] OF CHAR;

  BEGIN
    IF intournament THEN
      Message("SORRY, NO HELP!",
      	      "There is no help avail-",
      	      "able in tournament mode!");
      RETURN FALSE;
    ELSIF stackpos>=lastpos THEN
      RETURN FALSE;
    ELSE
      INC(helps[player]);
      ClearTouchstone;
      StoneClick;
      PutTile(stack[stackpos],movetab[stackpos].x,movetab[stackpos].y);
      score[0]:=movetab[stackpos].score[0];
      score[1]:=movetab[stackpos].score[1];
      IF quad[0]<movetab[stackpos].quad[0] THEN
        FOR i:=1 TO 4 DO
          values[0,i]:=values[0,i]*2;
        END;
      END;
      IF quad[1]<movetab[stackpos].quad[1] THEN
        FOR i:=1 TO 4 DO
          values[1,i]:=values[1,i]*2;
        END;
      END;
      quad[0]:=movetab[stackpos].quad[0];
      quad[1]:=movetab[stackpos].quad[1];

      ValToStr(quad[player],FALSE,str,10,2,' ',err);
      PrintShadow(64+player*233,25,str,2,16);     (* zeigt Quads an	*)
      ValToStr(score[player],FALSE,str,10,6,' ',err);
      PrintShadow(8+player*233,25,str,6,16);	(* zeigt Punkte an	*)

      IF two THEN
        player:=1-player;
      END;
      INC(stackpos);
      RETURN TRUE;
    END;
  END Redo;

(*------------------------------------------------------------------------
    Helpfunktionen während der Spielens.
    Ruft andere Prozeduren auf, die auch direkt über Tasten auf-
    gerufen werden können! (M=Moves, T=Tiles, U=Undo R=Redo ESC=Quit)
------------------------------------------------------------------------*)

PROCEDURE HelpRequest(two:BOOLEAN; VAR quit,exit:BOOLEAN);

  VAR
    x,y,gid,i	: INTEGER;
    key		: CARDINAL;

  BEGIN
    BackupScreen;
    ShowHelpRequest;
    gpos:=IL.AddGList(win,ADR(hg[0]),0,7,NIL);
    LOOP
      GetMsg(x,y,key,gid);
      CASE gid OF
      | H1ID	: IF NOT intournament THEN
                    gpos:=IL.RemoveGList(win,ADR(hg[0]),7);
      		    RestoreScreen;
      		    HelpPossibleMoves(stack[stackpos]);
      		    EXIT;
      		  END;
      | H2ID	: IF NOT intournament THEN
        	    gpos:=IL.RemoveGList(win,ADR(hg[0]),7);
      		    RestoreScreen;
      		    HelpTiles;
      		    EXIT;
      		  END;
      | H3ID	: gpos:=IL.RemoveGList(win,ADR(hg[0]),7);
      	  	  RestoreScreen;
		  restart:=TRUE;
      		  exit:=TRUE;
      		  EXIT;
      | H4ID	: IF NOT intournament THEN
                    gpos:=IL.RemoveGList(win,ADR(hg[0]),7);
		    RestoreScreen;
      		    exit:=Undo(two);
      		    EXIT;
      		  END;
      | H5ID	: IF NOT intournament THEN
      		    gpos:=IL.RemoveGList(win,ADR(hg[0]),7);
		    RestoreScreen;
		    exit:=Redo(two);
		    EXIT;
		  END;
      | H6ID	: gpos:=IL.RemoveGList(win,ADR(hg[0]),7);
      		  RestoreScreen;
      		  quit:=TRUE;
      		  EXIT;
      | H7ID	: gpos:=IL.RemoveGList(win,ADR(hg[0]),7);
		  RestoreScreen;
		  EXIT;
      ELSE;
      END;
    END;
  END HelpRequest;

(*------------------------------------------------------------------------
    Spielen
------------------------------------------------------------------------*)

PROCEDURE PlayIt(two:BOOLEAN);

  VAR
    i,j,mx,my,
    x,y,num,
    gid		: INTEGER;
    key		: CARDINAL;
    quit,exit	: BOOLEAN;

  PROCEDURE OneMove;
    BEGIN
      REPEAT
        GetMsg(mx,my,key,gid);
        IF (key=0) THEN			(* Maus geklickt?		*)
          x:=(mx-5) DIV 20;		(* rechnet Koordinaten in	*)
          y:=(my-34) DIV 20;		(* Feldindizes um		*)
        ELSE
          CASE key OF
          | ESCCODE  : quit:=TRUE;
          		RETURN;		(* Spiel abbrechen		*)
          | HELPCODE : HelpRequest(two,quit,exit);
                       IF quit OR exit THEN
                         RETURN;
                       END;
          | TCODE    : HelpTiles;
          | MCODE    : HelpPossibleMoves(stack[stackpos]);
          | UCODE    : IF Undo(two) THEN RETURN; END;
          | RCODE    : IF Redo(two) THEN RETURN; END;
          | SCODE    : SwitchBackSound;
		       soundstate:=(soundstate+1) MOD 3;
          ELSE;
          END;
        END;
      UNTIL (key=0) AND (x>=0) AND (x<=11) AND
            (y>=0) AND (y<=7) AND
            CheckOkay(stack[stackpos],x,y,num);
      ClearTouchstone;
      StoneClick;			(* spielt Click-Sound		*)
      PutTile(stack[stackpos],x,y);	(* legt Stein aufs Brett	*)
      NewScore(x,y,player,num);		(* berechnet und zeigt Punkte	*)
      IF two THEN			(* bei 2 Spielern, wechseln	*)
        player:=1-player;
        IF player=0 THEN
          IL.SetPointer(win,ADR(SinglePtrData),9,16,0,0);
        ELSE
          IL.SetPointer(win,ADR(TwoPtrData),9,16,0,0);
        END;
      END;
      movetab[stackpos].x:=x;
      movetab[stackpos].y:=y;
      movetab[stackpos].score[0]:=score[0];
      movetab[stackpos].score[1]:=score[1];
      movetab[stackpos].quad[0]:=quad[0];
      movetab[stackpos].quad[1]:=quad[1];
      INC(stackpos);			(* nimmt nächsten Stein		*)
      lastpos:=stackpos;
    END OneMove;

  BEGIN
    REPEAT
      FOR i:=0 TO 1 DO
        values[i,1]:=1;
        values[i,2]:=2;
        values[i,3]:=4;
        values[i,4]:=8;
        score[i]:=0;
        quad[i]:=0;
        helps[i]:=0;
      END;
      quit:=FALSE;
      exit:=FALSE;
      restart:=FALSE;
      player:=0;
      FOR i:=0 TO 11 DO			(* Spielfeld initialisieren	*)
        FOR j:=0 TO 7 DO
          field[i,j]:=-1;
        END;
      END;

      ShowPlayScreen;

      PutTile(stack[0],0,0);
      PutTile(stack[1],11,0);
      PutTile(stack[2],6,3);
      PutTile(stack[3],5,4);
      PutTile(stack[4],0,7);
      PutTile(stack[5],11,7);

      movetab[5].score[0]:=0;
      movetab[5].quad[0]:=0;
      movetab[5].score[1]:=0;
      movetab[5].quad[1]:=0;

      stackpos:=6;
      lastpos:=6;

      WHILE ~quit AND ~restart DO
        IF stackpos<72 THEN
          ShowOnTouchstone(stack[stackpos],stackpos);
          IF NOT MovePossible(stack[stackpos]) THEN
            Message("NO MORE MOVES!",
            	     "Sorry, but there are no",
  		     "more moves possible!");
          END;
        ELSE
          Message("NO MORE TILES!",
          	  "Great! You finished the",
          	  "complete stack!");
        END;
        OneMove;
      END;

    UNTIL ~restart OR quit;

    IF stackpos=72 THEN			(* vergibt Sonderbonus für	*)
      INC(score[0],1000);		(* (fast) geleerten Stapel...	*)
      INC(score[1],1000);
    ELSIF stackpos=71 THEN
      INC(score[0],500);
      INC(score[1],500);
    ELSIF stackpos=70 THEN
      INC(score[0],100);
      INC(score[1],100);
    END;
  END PlayIt;

(*------------------------------------------------------------------------
    Tournament (ein wenig Brimborium, dann eventuell Aufruf von PlayIt)
------------------------------------------------------------------------*)

PROCEDURE Tournament;

  VAR
    x,y,gid	: INTEGER;
    key		: CARDINAL;

  BEGIN
    BackupScreen;
    ShowTourScreen;
    gpos:=IL.AddGList(win,ADR(tg[0]),0,3,NIL);
    LOOP
      GetMsg(x,y,key,gid);
      CASE gid OF
      | TNEWID : gpos:=IL.RemoveGList(win,ADR(tg[0]),3);
      		 InitHiScoreTable(TOUR);	(* Hiscore Reset	*)
		 CreateTileStack(tourstack);
		 SaveTournament(tourstack);
		 EXIT;
      | TCONTID: gpos:=IL.RemoveGList(win,ADR(tg[0]),3);
      		 IF tourstack[0]=-1 THEN	(* wenn nicht vorhanden	*)
                   InitHiScoreTable(TOUR);	(* HiScore Reset	*)
      		   CreateTileStack(tourstack);	(* erzeugt TourStack	*)
  		   SaveTournament(tourstack);
      		 END;
		 EXIT;
      | TCANCID: gpos:=IL.RemoveGList(win,ADR(tg[0]),3);
      		 RestoreScreen;
		 RETURN;
      ELSE;
      END;
    END;
    stack:=tourstack;
    restart:=TRUE;
    PlayIt(FALSE);			(* Spielen			*)
    HiScore(score[0],quad[0],helps[0],72-stackpos,TOUR);
    ShowSelectScreen;			(* SelectScreen wieder aufbauen	*)
  END Tournament;

(*------------------------------------------------------------------------
    Wertet Eingaben im Selectmenü aus, und ruft andere Prozeduren.
------------------------------------------------------------------------*)

PROCEDURE MenuSelect;

  VAR
    x,y : INTEGER;
    key : CARDINAL;
    gid	: INTEGER;

  BEGIN
    ShowSelectScreen;
    gpos:=IL.AddGList(win,ADR(g[0]),0,7,NIL);
    LOOP
      GetMsg(x,y,key,gid);
      CASE gid OF
      | PLY1ID  : gpos:=IL.RemoveGList(win,ADR(g[0]),7);
       		  CreateTileStack(stack);
       		  intournament:=FALSE;
       		  restart:=TRUE;
       		  PlayIt(FALSE);
                  HiScore(score[0],quad[0],helps[0],72-stackpos,SINGLE);
       		  ShowSelectScreen;
                  gpos:=IL.AddGList(win,ADR(g[0]),0,7,NIL);
      | PLY2ID  : gpos:=IL.RemoveGList(win,ADR(g[0]),7);
      		  CreateTileStack(stack);
       		  intournament:=FALSE;
       		  restart:=TRUE;
                  IL.SetPointer(win,ADR(SinglePtrData),9,16,0,0);
      		  PlayIt(TRUE);
                  IL.SetPointer(win,ADR(SinglePtrData),9,16,0,0);
                  HiScore(score[0],quad[0],helps[0],72-stackpos,TWOPLY);
	          IL.SetPointer(win,ADR(TwoPtrData),9,16,0,0);
                  HiScore(score[1],quad[1],helps[1],72-stackpos,TWOPLY);
      		  ShowSelectScreen;
      		  gpos:=IL.AddGList(win,ADR(g[0]),0,7,NIL);
      | TOURID  : gpos:=IL.RemoveGList(win,ADR(g[0]),7);
       		  intournament:=TRUE;
      		  Tournament;
      		  gpos:=IL.AddGList(win,ADR(g[0]),0,7,NIL);
      | SOUNDID : SwitchBackSound;
		  soundstate:=(soundstate+1) MOD 3;
		  ShowSound;
      | CREDID  : gpos:=IL.RemoveGList(win,ADR(g[0]),7);
      		  Credits;
      		  ShowSelectScreen;
      		  gpos:=IL.AddGList(win,ADR(g[0]),0,7,NIL);
      | HISCID  : gpos:=IL.RemoveGList(win,ADR(g[0]),7);
       		  FadeOut(ALLCOLORS,FADERATE);
      		  ShowHiScores(0);
      		  FadeIn(ALLCOLORS,FADERATE);
		  WaitForKey;
		  FadeOut(ALLCOLORS,FADERATE);
      		  ShowHiScores(1);
      		  FadeIn(ALLCOLORS,FADERATE);
		  WaitForKey;
		  FadeOut(ALLCOLORS,FADERATE);
      		  ShowHiScores(2);
      		  FadeIn(ALLCOLORS,FADERATE);
		  WaitForKey;
      		  ShowSelectScreen;
      		  gpos:=IL.AddGList(win,ADR(g[0]),0,7,NIL);
      | QUITID  : EXIT;
      ELSE;
      END;
    END;
    SaveHiScores;		(* speichert aktuelle Hiscoretabelle	*)
    SaveTournament(tourstack);
    FadeOut(ALLCOLORS,FADERATE);		(* blendet Screen aus	*)
  END MenuSelect;

(*------------------------------------------------------------------------
    Das Ishid-O-matic Hauptprogramm.
------------------------------------------------------------------------*)

BEGIN
  LoadHiScores;					(* lädt Hiscoretabelle	*)
  LoadTournament(tourstack);
  tcols[0,0]:=1; tcols[0,1]:=2; tcols[0,2]:=3;
  tcols[1,0]:=4; tcols[1,1]:=5; tcols[1,2]:=6;
  tcols[2,0]:=7; tcols[2,1]:=8; tcols[2,2]:=9;
  tcols[3,0]:=10;tcols[3,1]:=11;tcols[3,2]:=12;
  tcols[4,0]:=13;tcols[4,1]:=14;tcols[4,2]:=15;
  tcols[5,0]:=23;tcols[5,1]:=24;tcols[5,2]:=25;

  fnt:=OpenFont("NarrowPenguin.font",8);
  Arts.Assert(fnt#NIL,ADR("OpenFont failed!"));

  GL.InitBitMap(bbm,5,320,200);
  FOR i:=0 TO 4 DO
    bbm.planes[i]:=EL.AllocMem(8000,E.MemReqSet{E.chip,E.public});
    Arts.Assert(bbm.planes[i]#NIL,ADR("Not enough chipmem!"));
  END;

  gok:=LoadBrush(GRAPHICSNAME,gbm);			(* Lädt Grafik	*)
  Arts.Assert(gok, ADR("LoadBrush failed!"));

  scr:=OpenScr(STITLE,320,200,5,FALSE);
  Arts.Assert(scr#NIL, ADR("OpenScr failed!"));
  rp:=ADR(scr^.rastPort);
  GL.SetFont(rp,fnt);
  win:=OpenWin("",0,0,320,200,scr,WFLAGS);
  Arts.Assert(win#NIL, ADR("OpenWin failed!"));
  GL.LoadRGB4(ADR(scr^.viewPort),ADR(ColorTable),32);	(* Setzt Farben *)
  GL.SetRast(rp,0);				(* löscht Titelzeile	*)

  ourtask:=CAST(DosD.ProcessPtr,Arts.thisTask); (* Systemrequester auf  *)
  ourtask^.windowPtr:=win;			(* unseren Screen     	*)

  IF IL.CloseWorkBench() THEN END;
  StartBackgroundSound;
  soundstate:=0;

  SplitRGB(GL.GetRGB4(scr^.viewPort.colorMap,0),r0,g0,b0);

  FOR i:=0 TO 31 DO
    rs[i]:=r0;
    gs[i]:=g0;
    bs[i]:=b0;
    SplitRGB(GL.GetRGB4(scr^.viewPort.colorMap,i),rt[i],gt[i],bt[i]);
    rt[i]:=rt[i]-r0;		(* berechnet				*)
    gt[i]:=gt[i]-g0;		(* Differenzen der Farbanteile		*)
    bt[i]:=bt[i]-b0;		(* zum Hintergrund.			*)
  END;

  IL.ModifyIDCMP(win,I.IDCMPFlagSet{I.rawKey,I.mouseButtons,
                                    I.gadgetUp});
  MakeGadgets;			 (* macht die Gadgets für SelectScreen	*)
  MenuSelect;
CLOSE
  IF IL.OpenWorkBench()#NIL THEN END;
  ourtask^.windowPtr:=NIL;
  FOR i:=0 TO 4 DO
    IF bbm.planes[i]#NIL THEN
      EL.FreeMem(bbm.planes[i],bbm.bytesPerRow*bbm.rows);
    END;
  END;

  IF fnt#NIL THEN CloseFont(fnt) END;
  IF gok THEN
    FOR i:=0 TO 4 DO
      IF gbm.planes[i]#NIL THEN
        EL.FreeMem(gbm.planes[i],gbm.bytesPerRow*gbm.rows);
      END;
    END;
  END;
  IF IL.OpenWorkBench()#NIL THEN END;
END IOM.
