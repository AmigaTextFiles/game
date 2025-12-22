MODULE NICtoPGN; (* 1.1c*)

  (*$ Volatile:=TRUE StackChk:=FALSE RangeChk:=FALSE OverflowChk:=FALSE
  NilChk:=FALSE EntryClear:=FALSE CaseChk:=FALSE ReturnChk:=FALSE *)

FROM SYSTEM IMPORT
  ADR;
FROM W IMPORT
  WRITE,WRITELN,s,l,READs;
FROM String IMPORT
  Length, Occurs, CopyPart, Copy, Concat, ConcatChar, Compare;
FROM FileSystem IMPORT
  FileMode, FileModeSet, File, Lookup, Close, ReadBytes, ReadChar,
  ReadByteBlock, Response, WriteChar, WriteBytes;
FROM FileSystemSupport IMPORT
  ReadString, WriteString;
FROM Arts IMPORT
  Assert;
FROM ReqSupport IMPORT
  SimpleFileRequester;

(* FileSupport: ReadString, WriteString *)
(* ReadString strips evt. trailing CR's (used in IBM PCs TEXT files) *)

(*
PROCEDURE ReadString(VAR f:File; VAR st:ARRAY OF CHAR);
VAR
  p:INTEGER;
BEGIN
  p:=0;
  REPEAT
    ReadChar(f,st[p]);
    INC(p);
  UNTIL f.eof OR (st[p-1]=12C) OR (p>HIGH(st)) OR (f.res<>done);
  IF (st[p-1]=12C) OR (p>HIGH(st)) THEN DEC(p) END;
  IF (p>0) & (st[p-1]=15C) THEN DEC(p); END;
  st[p]:=0C;
END ReadString;

PROCEDURE WriteString(VAR f:File; st:ARRAY OF CHAR);
VAR
  Actual:LONGINT;
BEGIN
  WriteBytes(f,ADR(st),Length(st),Actual);
  WriteChar(f,12C);
END WriteString;
*)

(* pgn EXAMPLE:
[Event "FIDE World Championship"]   |    [Event "?"]
[Site "New York City, NY USA"]      |    
[Date "1992.08.31"]                 |    [Date "1992.??.??"]
[Round "4.1.2"]                     |    [Round "22"]
[White "Tal, Mikhail N."]           |
[Black "Lasker, Emmanuel"]          |
[Result "*"]                        |    [Result "1/2-1/2"]

Supp. tag names:

WhiteTitle, BlackTitle: String values such as "FM", "IM", and "GM";
WhiteElo, BlackElo: Integer values; these are used for FIDE Elo ratings.
WhiteUSCF, BlackUSCF: 
EventDate: the starting date of the Event
EventSponsor:
Section: this is used for the playing section of a tournament 
     (e.g.,"Open" or "Reserve").
Stage: A string; this is used for the stage of a multistage event
     (e.g.,"Preliminary" or "Semifinal").
Board: An integer; this identifies the board number in a team event.
Opening: A string; this is used for the traditional opening name.
Variation: this is used to further refine the Opening tag.
SubVariation: this is used to further refine the Variation tag. 
ECO: String of the form "XDD/DD" where the "X" is a letter from "A" to "E" and
     the "D" positions are digits; this is used for an opening designation from the
     five volume _Encyclopedia of Chess Openings_.
NIC: A string; this is used for an opening designation from the _New in Chess_
     database.
Annotator: A name or names in the format of the player name tags; this
     identifies the annotator of the game.
Time: A time-of-day value in the form "HH:MM:SS"; similar to the Date tag
     except that it denotes the local clock time (hours, minutes, and seconds) of
     the start of the game.  Note that colons, not periods, are used for internal
     separators for the Time value.
*)

CONST
  Event=1;
  Site=2;
  Date=3;
  Round=4;
  White=5;
  Black=6;
  Result=7;
  NIC=8;
  Source=9;
  WhiteTitle=10;
  BlackTitle=11;
  WhiteElo=12;
  BlackElo=13;
  Info=14;
  Annotator=15;
  FirstFree=16;
  DpMax=120;
  BufSize=32768;

TYPE
  STR255=ARRAY[0..155] OF CHAR;

VAR
  WHITE,TagLoad,WRAP:BOOLEAN;
  T:ARRAY[1..40] OF STR255;
  D:ARRAY[1..DpMax] OF STR255;
  Tp,Dp:CARDINAL;
  navn1,navn2,si,sh,su,s2,name,dir:STR255;
  ind,ud:File;
  ch:CHAR;
  n:INTEGER;
  Games:LONGINT;

PROCEDURE WriteGame;
BEGIN
(* WRITELN(s('WriteGame')); *)
  IF Tp>0 THEN
(* WRITELN(s('WriteGame.WT ')+l(Tp)); *)
    INC(Games);
    FOR n:=1 TO Tp DO
      IF Length(T[n])>0 THEN
        WriteString(ud,T[n]);
(*WRITELN(s('UD: ')+s(T[n])); *)
      END;
    END;
    WriteChar(ud,12C);
  END;
  IF Dp>0 THEN
(* WRITELN(s('WriteGame.WD ')+l(Dp)); *)
    FOR n:=1 TO Dp DO
      IF Length(D[n])>0 THEN
        WriteString(ud,D[n]);
(* WRITELN(s('UD: ')+s(D[n])); *)
      END;
    END;
    WriteChar(ud,12C);
  END;
  IF (Games>0) & (Games MOD 100 = 0) THEN
    WRITELN(l(Games));
  END;
END WriteGame;

PROCEDURE InitGame;
BEGIN
(* WRITELN(s('InitGame')); *)
  WriteGame;
  T[Event] :='[Event "?"]';
  T[Site]  :='[Site "?"]';
  T[Date]  :='[Date "????.??.??"]';
  T[Round] :='[Round "?"]';
  T[White] :='[White "?"]';
  T[Black] :='[Black "?"]';
  T[Result]:='[Result "*"]';
  FOR Tp:=NIC TO FirstFree DO
    T[Tp]:='';
  END;
  Tp:=FirstFree;
  Dp:=0;
  TagLoad:=TRUE;
END InitGame;

PROCEDURE Place(VAR st:STR255; token:ARRAY OF CHAR; tp:CARDINAL);
BEGIN
  IF Occurs(st,0,token,TRUE)=1 THEN
(* WRITELN(s('PlaceOccurs ')+s(token)+s(' ')+l(tp)); *)
    IF tp=0 THEN
      T[Tp]:=st;
      INC(Tp);
      T[Tp]:='';
    ELSE
      T[tp]:=st;
    END;
  END;
END Place;

PROCEDURE LocaleChars(VAR su:STR255);
VAR
  n:INTEGER;
BEGIN
  n:=0;
  WHILE su[n]<>0C DO
    CASE su[n] OF
    | 'D' : su[n]:='Q';
    | 'L' : su[n]:='B';
    | 'S' : su[n]:='N';
    | 'T' : su[n]:='R';
    ELSE
    END;
    INC(n);
  END;
END LocaleChars;

PROCEDURE SpaceAfter(VAR su:STR255);
VAR
  s:STR255;
  n,nu:INTEGER;
BEGIN
  nu:=-1;
  n:=nu;
  REPEAT
    INC(n);
    INC(nu);
    s[n]:=su[nu];
    IF (s[n]='.') & ((n=0) OR (s[n-1]>='0') & (s[n-1]<='9')) THEN
      INC(n);
      s[n]:=' ';
    END;
  UNTIL su[nu]=0C;
  Copy(su,s);
END SpaceAfter;

PROCEDURE Handle(VAR su,si:STR255; token:STR255; CASESENSITIVE:BOOLEAN);
VAR
  sh:STR255;
  lt:INTEGER;
  YEAR:BOOLEAN;
BEGIN
  IF Occurs(si,0,token,CASESENSITIVE)=0 THEN
(* WRITELN(s('Handle.Occurs')); *)
    su:='[';
    lt:=Length(token);
    IF Compare(token,'Keycode: ')=0 THEN 
      InitGame;
      token:='NIC ';
    END;
    IF Compare(token,'Source: ')=0 THEN 
      token:='Source ';
    END;
    IF Compare(token,'Round: ')=0 THEN 
      token:='Round ';
    END;
    IF Compare(token,'Info: ')=0 THEN 
      token:='Info ';
    END;
    IF Compare(token,'Annotator: ')=0 THEN 
      token:='Annotator ';
    END;
    IF Compare(token,'White: ')=0 THEN 
      token:='White ';
      WHITE:=TRUE;
    END;
    IF Compare(token,'Black: ')=0 THEN 
      token:='Black ';
      WHITE:=FALSE;
    END;
    IF Compare(token,'Place: ')=0 THEN 
      token:='Site ';
    END;
    IF Compare(token,'Title: ')=0 THEN 
      IF WHITE THEN
        token:='WhiteTitle ';
      ELSE
        token:='BlackTitle ';
      END;
    END;
    IF Compare(token,'Elo: ')=0 THEN 
      IF WHITE THEN
        token:='WhiteElo ';
      ELSE
        token:='BlackElo ';
      END;
    END;
    YEAR:= Compare(token,'Year: ')=0;
    IF YEAR THEN 
      token:='Date ';
    END;
    Concat(su,token);
    ConcatChar(su,'"');
    CopyPart(sh,si,lt,999);
    IF Occurs(sh,0,'Not Classed',CASESENSITIVE)=0 THEN
      sh:='?';
    END;
    Concat(su,sh);
    IF YEAR THEN
      Concat(su,'.??.??');
    END;
    Concat(su,'"]');
  END;
END Handle;

VAR
  Fnr:=INTEGER{0};

PROCEDURE WWF;
BEGIN
  INC(Fnr);
  IF Fnr=1 THEN
    WRITELN(s('I cannot read the print file (wrong fileformat)!'));
    WRITELN(s(''));
    WRITELN(s('Example of a correct NICbase3 print file (.PRN):'));
    WRITELN(s(''));
    WRITELN(s('Keycode: CK 1.2.7'));
    WRITELN(s('Source: M'));
    WRITELN(s('White: Alekhine,Alexander'));
    WRITELN(s('Black: Feigin,Movsa'));
    WRITELN(s('Place: Kemeri  Round: 6  Year: 1937'));
    WRITELN(s('1.c4 c6 2.e4 d5 3.exd5 cxd5 4.cxd5 Sf6 5.Lb5+ Sbd7 6.Sc3 g6'));
    WRITELN(s('7.Sf3 Lg7 8.d6 exd6 9.O-O O-O 10.d4 h6 11.Lf4 Sb6 12.Dd2 a6'));
    WRITELN(s('13.Ld3 Kh7 14.h3 Le6 15.Tfe1 Dd7 16.Lh2 Sfd5 17.Se2 Tfd8'));
    WRITELN(s('18.Sf4 Lf5 19.Sxd5 Sxd5 20.Lc4 Le6 21.a4 Tac8 22.Lb3 Dc7'));
    WRITELN(s('23.a5 Dd7 24.La4 De7 25.Lg3 Tc7 26.Lb3 Dd7 27.Lh4 Tb8'));
    WRITELN(s('28.La4 Dc8 29.Tac1 Tc4 30.Lg3 Lf8 31.h4 Sf6 32.Lb3 Txc1'));
    WRITELN(s('33.Txc1 Dd7 34.d5 Lf5 35.Db4 Le4 36.Dd4 Df5 37.Sd2 Lxd5'));
    WRITELN(s('38.Lxd5 Sxd5 39.Se4 Lg7 40.Sxd6 De6 41.Dd2 Sf6 42.Dc2 b6'));
    WRITELN(s('43.Dc7 Sd7 44.Sxf7 Tf8 45.Sd8 Df6 46.Td1'));
    WRITELN(s('                           1-0    '));
    WRITELN(s(''));
  END;
END WWF;

(*
PROCEDURE PGNINFO;
BEGIN
  WRITELN(s('[Event "?"]'));
  WRITELN(s('[Site "St Petersburg"]'));
  WRITELN(s('[Date "1913.??.??"]'));
  WRITELN(s('[Round "1"]'));
  WRITELN(s('[White "Alekhine, Alexander"]'));
  WRITELN(s('[Black "Duras, Oldrich"]'));
  WRITELN(s('[Result "1-0"]'));
  WRITELN(s(''));
  WRITELN(s('1. e4 e5 2. Nf3 Nc6 3. Bb5 a6 4. Ba4 Nf6 5. Qe2 b5 6. Bb3 Bc5 7. a4 Rb8 8. axb5'));
  WRITELN(s('axb5 9. d3 d6 10. Be3 Bg4 11. h3 Bh5 12. Nbd2 O-O 13. O-O Nd4 14. Bxd4 Bxf3 15.'));
  WRITELN(s('Nxf3 exd4 16. e5 Qe7 17. Rfe1 Rbe8 18. Qd2 dxe5 19. Rxe5 Qd6 20. Qg5 Rxe5 21.'));
  WRITELN(s('Nxe5 Qb6 22. g4 Bd6 23. Nxf7 Rxf7 24. Qf5 g6 25. Qe6 Kg7 26. Qxf7+ Kh6 27. Be6'));
  WRITELN(s('1-0'));
  WRITELN(s(''));
END PGNINFO;
*)

BEGIN
  WRITELN(s('NICtoPGN v1.1c                    (c) Egon Bech Madsen, DEN'));
  WRITELN(s(''));
  WRITELN(s('This is a utility to convert CHESS games from NICBASE3 .PRN files to'));
  WRITELN(s('the standard chess-game fileformat, PGN.'));
  WRITELN(s(''));
  WRITELN(s('First make a printfile from NICBASE3 of the wanted games. Be'));
  WRITELN(s('shure to select FIDE-SHORT format, and use the international'));
  WRITELN(s('piece-letters (NBRQK KQRBNP) to be fully compatible (only the danish'));
  WRITELN(s('pieces (SLTD) will automatically be converted to the international (NBRQ).'));
  WRITELN(s(''));
  WRITELN(s('Then use this ShareWare utility.'));
  IF SimpleFileRequester('OPEN NICBASE3 SHORTFIDE.PRN file, name:',name,navn1,dir) THEN
    Lookup(ind,navn1,BufSize,FALSE);
    Concat(name,'.pgn');
    IF SimpleFileRequester('CONVERT TO pgn file, name:',name,navn2,dir) THEN
      Lookup(ud,navn2,BufSize,TRUE);
      IF NOT ind.eof THEN
        WRITELN(s(''));
        WRITELN(s('Converting ')+s(navn1)+s(' to ')+s(navn2)+s(' ...'));
        WRAP:=FALSE;
        WHITE:=TRUE;
        TagLoad:=TRUE;
        Tp:=0;
        Dp:=0;
        Games:=0;
        REPEAT
          IF WRAP THEN
            si:=s2;
            WRAP:=FALSE;
          ELSE
            ReadString(ind,si);
          END;
          n:=Occurs(si,0,'  Round: ',TRUE);
          WRAP:= n>=0;
          IF WRAP THEN
            CopyPart(s2,si,n+2,999);
            si[n]:=0C;
          ELSE
            n:=Occurs(si,0,'  Year: ',TRUE);
            WRAP:= n>=0;
            IF WRAP THEN
              CopyPart(s2,si,n+2,999);
              si[n]:=0C;
            ELSE
              n:=Occurs(si,0,'  Title: ',TRUE);
              WRAP:= n>=0;
              IF WRAP THEN
                CopyPart(s2,si,n+2,999);
                si[n]:=0C;
              ELSE
                n:=Occurs(si,0,'  Elo: ',TRUE);
                WRAP:= n>=0;
                IF WRAP THEN
                  CopyPart(s2,si,n+2,999);
                  si[n]:=0C;
                ELSE
                END;
              END;
            END;
          END;
          Copy(su,si);
          Handle(su,si,'Keycode: ',TRUE); (* OK *)
          Handle(su,si,'Source: ',TRUE);  (* OK *)
          Handle(su,si,'White: ',TRUE);   (* OK *)
    
          Handle(su,si,'Title: ',TRUE);   (* OK *)
          Handle(su,si,'Elo: ',TRUE);     (* OK *)
    
          Handle(su,si,'Black: ',TRUE);   (* OK *)
          Handle(su,si,'Place: ',TRUE);   (* ->Site (Event), OK *)
          Handle(su,si,'Round: ',TRUE);   (* OK *)
          Handle(su,si,'Year: ',TRUE);    (* ->Date, OK *)
          Handle(su,si,'Info: ',TRUE);     (* OK *)
          Handle(su,si,'Annotator: ',TRUE);(* OK *)
          IF Occurs(su,0,'1.',TRUE)=0 THEN
    (* WRITELN(s('Tag=FALSE')); *)
            TagLoad:=FALSE;
          END;
          IF TagLoad THEN
    (* WRITELN(s('Main.TagLoad,place')); *)
            Place(su,'NIC ',NIC);
            Place(su,'Source ',Source);
            Place(su,'White ',White);
            Place(su,'WhiteTitle ',WhiteTitle);
            Place(su,'WhiteElo ',WhiteElo);
            Place(su,'Black ',Black);
            Place(su,'BlackTitle ',BlackTitle);
            Place(su,'BlackElo ',BlackElo);
            Place(su,'Site ',Site);
            Place(su,'Round ',Round);
            Place(su,'Date ',Date);
            Place(su,'Info ',Info);
            Place(su,'Annotator ',Annotator);
          ELSE
            INC(Dp);
            IF Occurs(su,0,' 1-0',TRUE)>=0 THEN
              T[Result]:='[Result "1-0"]';
              su:=' 1-0';
              TagLoad:=TRUE;
            END;
            IF Occurs(su,0,' 0-1',TRUE)>=0 THEN
              T[Result]:='[Result "0-1"]';
              su:=' 0-1';
              TagLoad:=TRUE;
            END;
            IF Occurs(su,0,' 1/2',TRUE)>=0 THEN
              T[Result]:='[Result "1/2-1/2"]';
              su:=' 1/2-1/2';
              TagLoad:=TRUE;
            END;
    (* IF TagLoad THEN WRITELN(s('Tag=TRUE')); END; *)
            IF Dp>DpMax THEN
              WWF;
            ELSE
              SpaceAfter(su);
              IF TagLoad THEN
                DEC(Dp);
                Concat(D[Dp],su);
              ELSE
                LocaleChars(su);
                Copy(D[Dp],su);
              END;
            END;
          END;
  (* WRITELN(s(su)); *)
        UNTIL ind.eof;
        InitGame;
      END;
      Close(ud);
    END;  
    Close(ind);
    WRITE(l(Games)+s(' NIC-BASE3 .PRN chess-games converted to PGN format.'));
  END;
END NICtoPGN.

