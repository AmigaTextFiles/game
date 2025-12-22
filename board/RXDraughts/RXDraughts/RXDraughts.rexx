/* RXDraughts 2.3 ©2003 Michael Trebilcock

   Changes since 2.2 (* = finished):

*  - Brain would not promote pieces while thinking ahead, making it
     more stupid in the middle of a game. This bug fix is not very
     noticeable, but now it remains the same smartness constantly.
*  - Brain continued jumping after a non-king reached the end of
     the board, this bug only showed itself in the thinking routines
     and was not visibly noticeable.
   - Imminent danger is top priority. High difficulty levels will
     not make the computer stupid. It probably won't make it
     any smarter either.
*  - If the computers piece is promoted while thinking ahead, that
     adds a good point, making getting kings more of a priority.
     Also adds a bad point if the opponent gets a king, making it
     less likely to make a move that opens up a path for the
     opponent to get a king.
   - Computer is much quicker when only 1 jump is available.

     Brain is no longer experimental. It works fine.
     Randomness is still a major part when moving the opponents
     pieces while thinking ahead. I may add some averaging function to
     add a "guess which way opponent would move it's piece" routine.
     This would decrease randomness without slowing down the game.

   - Flip board function added. Damn that pissed me off playing
     top-down instead of bottom-up as Player 2.
   - Huffing support finally added.
   - Optional sound effects.
*  - No more debug computer output for increased speed.
*  - Optimizations to the brain. Not noticeable (Noticable speed-up
     is only due to the debug output gone, and what a difference!).

   RXDraughts is now complete.

   Known bugs:
   - In theory you could do a circle jump and end up jumping to a
     piece you've already been to in that same jump.
     That is against the rules, but hasn't been fixed because
     it's prodigiously improbable.

*/

/* Configuration */
Huff   = "0"             /* 0 = Forced jumping, 1 = Huffing enabled */
Delay  = "0"             /* Slow down the computer (50 = 1 sec) */
Theme  = "StarGate256"   /* Example: StarGate */
Auto   = "1"             /* Automatically moves piece from one click */
Diff   = "4"             /* Difficulty level against the computer */
/* End Configuration */

Signal On Halt
Signal On Break_C

Libs="rexxtricks.library rexxdossupport.library rexxsupport.library rexxreqtools.library"

DO i=1 TO Words(Libs)
 IF ~Exists("LIBS:"Word(Libs,i)) THEN DO
  SAY Word(Libs,i) "not found in LIBS:"
  Exit
 End
 ELSE Call AddLib(Word(Libs,i),"0","-30","0")
End

Play="B"

DO i=1 TO 8
 Let=d2c(64+i)
 Let.Let=i
 Let.i=Let
End

DO i=1 TO 32
 P.i=""
End

DO i=1 TO 12
 P.i="w"
End

DO i=21 TO 32
 P.i="b"
End

PosX="w";PosX.PosX="0 241"
PosX="W";PosX.PosX="241 0"
PosX="b";PosX.PosX="241 241"
PosX="B";PosX.PosX="482 0"
PosX="";PosX.PosX="0 0"

Call NewGame()

Text="Human VS Human"
IF Opt="2" THEN Text="Human VS Computer"
IF Opt="3" THEN Text="Computer VS Computer"
IF Opt="4" THEN Text="Human VS Human (TCP/IP)"

IF TFile~="" THEN DO
 IF ~Open(File,TFile,"R") THEN DO
  SAY "Unable to open "TFile
  Exit
 End
 DO i=1 TO 32
  P.i=ReadLn(File)
 End
 Call Close(File)
End

IF Opt="4" THEN DO
 IF Plr="1" THEN DO
  SAY "Attemping to connect to "IP" on port 998..."
  DO UNTIL Open(TCP,"TCP:"IP"/998","R")
   Call Delay(50)
  End
  SAY "Connected, sending info.."
  DO i=1 TO 32
   Call WriteLn(TCP,P.i)
  End
  Call WriteLn(TCP,Play)
  Call WriteLn(TCP,Huff)
  Call WriteLn(TCP,Auto)
  Call Close(TCP)
  SAY "Sent, starting game."
 End
 ELSE DO
  SAY "Waiting for player one..."
  Call Delete("T:Board.tmp")
  ADDRESS COMMAND "Run >NIL: Copy TCP:998 T:Board.tmp"
  DO UNTIL Open(File,"T:Board.tmp","R")
   Call Delay(50)
  End
  SAY "Player one connected, receiving info.."
  DO i=1 TO 32
   P.i=ReadLn(File)
  End
  Play=ReadLn(File)
  Huff=ReadLn(File)
  Auto=ReadLn(File)
  Call Close(File)
  SAY "Info received, starting game."
 End
 Opt="1"
End

Call GUI()

DO UNTIL End="1"
 Error="0";Jump="0"
 King="0"
 IF Opt="2"&Play="W"|Opt="3" THEN DO
  Call FMove2()
  Jump="0"
  IF End~="1"&CJump~="1" THEN DO
   Good="-99";Bad="99"
   DO i=1 TO Words(Pieces)
    Piece=Word(Pieces,i)
    IF TJP.Piece~="" THEN Count=Words(TJP.Piece)
    ELSE Count=Words(TP.Piece)
    DO a=1 TO Count
     IF Good.Piece.Count>Good-1&Bad.Piece.Count<Bad THEN DO
      OptPiece=Piece
      OptCount=Count
      Bad=Bad.Piece.Count
      Good=Good.Piece.Count
     End
    End
   End
   Num3=OptPiece
   Count=OptCount
   IF TJP.Num3~="" THEN DO
    Jump="1"
    Num4=Word(TJP.Num3,Count)
    Parse Var Num4 TheSq"/"GNum2"/"Num4
   End
   ELSE IF TP.Num3~="" THEN Num4=Word(TP.Num3,Count)
  End
  Let4=0
  IF Play="W"&Num4>28&Num4<33 THEN Let4=8
  IF Play="B"&Num4>0&Num4<5 THEN Let4=1
  IF CJump="1"&Jump="0" THEN DO
   CJump="0";Error="1"
   Call Switch()
  End
 End
 ELSE DO
  IF CJump~="2" THEN DO
   IF Plr="1"&Play="W"|Plr="2"&Play="B" THEN DO
    SAY "Waiting for opponent to make a move.."
    ADDRESS COMMAND "Copy TCP:998 T:RXDMove.tmp"
    Call Open(File,"T:RXDMove.tmp","R")
    Move=ReadLn(File)
    Call Close(File)
   End
   ELSE DO
    Call FMove()
    IF CJump="1"&Jump="0" THEN DO
     Call Send(TMove)
     Call Switch()
     CJump="0"
     IF Opt="1"&Plr="" THEN Call FMove()
     ELSE Error="1"
    End
    Jump="0"
    IF CJump="1"&Words(TJP.Num4)>1 THEN Call ToPipe('ID 'MG' gt="Choose a path to continue jumping"')
    IF CJump="1"&Words(TJP.Num4)="1" THEN DO
     Parse Var TJP.Num4 TheSq"/"GNum2"/"Num4
     Call Grid2(Num4);Move=Move" "Let.Let""Num
    End
    ELSE IF End~="1"&Error="0" THEN Call GMove(1)
   End
  End
  Move=Strip(Move,," ")
  IF Move="EOF" THEN Call Break_C()
  Let=Left(Move,1);Num=SubStr(Move,2,1)
  Let2=SubStr(Move,4,1);Num2=SubStr(Move,5,1)
  Let3=Let.Let;Let4=Let.Let2
 End
 IF End="1" THEN Error="1"
 IF Error="0"&Opt="1"|Error="0"&Opt="2"&Play="B" THEN DO
  Call Grid(Let3 Num);Num3=GNum2
  Call Grid(Let4 Num2);Num4=GNum2
  IF Upper(P.Num3)=P.Num3 THEN King="1"
  Squares=Compress(Translate(Num-Num2,"","-"))
  Lets=Compress(Translate(Let3-Let4,"","-"))
  SELECT
   WHEN Play="B"&Upper(P.Num3)="W"|Play="W"&Upper(P.Num3)="B" THEN DO
    Call ToPipe('ID 'MG' gt="You cannot move the other players piece"')
    Error="1"
   End
   WHEN P.Num3="" THEN DO
    Call ToPipe('ID 'MG' gt="You cannot move a blank square"')
    Error="1"
   End
   WHEN Play="B"&Let4-Let3>0&King="0"|Play="W"&Let3-Let4>0&King="0" THEN DO
    Call ToPipe('ID 'MG' gt="Only kings can move backwards"')
    Error="1"
   End
   WHEN P.Num4~="" THEN DO
    Call ToPipe('ID 'MG' gt="You must move to a vacant square"')
    Error="1"
   End
   WHEN Squares>1|Lets>1|Num=Num2|Let=Let2 THEN DO
    IF Play="B" THEN DO
     IF Num2=Num-2|Num2=Num+2 THEN IF Let4=Let3-2|Let4=Let3+2 THEN Jump="1"
     IF Let4=Let3+2&King="0" THEN Error="1"
    End
    IF Play="W" THEN DO
     IF Num2=Num-2|Num2=Num+2 THEN IF Let4=Let3+2|Let4=Let3-2 THEN Jump="1"
     IF Let4=Let3-2&King="0" THEN Error="1"
    End
    IF Jump="0" THEN DO
     IF Error="1" THEN Call ToPipe('ID 'MG' gt="Only kings can jump backwards"')
     ELSE Call ToPipe('ID 'MG' gt="Moves are diagonally one square"')
     Error="1"
    End
    ELSE DO
     IF Error="0" THEN DO
      IF Let4-Let3>0 THEN Let5=Let3+1
      ELSE Let5=Let3-1
      IF Num2=Num-2 THEN Call Grid(Let5 Num-1)
      IF Num2=Num+2 THEN Call Grid(Let5 Num+1)
      IF Play="W"&Upper(P.GNum2)="W"|Play="B"&Upper(P.GNum2)="B" THEN DO
       Call ToPipe('ID 'MG' gt="You cannot jump over your own piece"')
       Error="1"
      End
      IF P.GNum2="" THEN DO
       Call ToPipe('ID 'MG' gt="You cannot jump over a blank square"')
       Error="1"
      End
     End
    End
   End
   OTHERWISE NOP
  End
 End
 IF Plr="" THEN Play.Player=Play
 IF Jump="0"&ValidJps~=""&Huff="0"&Play=Play.Player THEN DO
  IF Error="0" THEN Call ToPipe('ID 'MG' gt="You must jump!"')
  Error="1"
 End
 IF Error="0" THEN DO
  CJump="0"
  IF Jump="1" THEN DO
   P.GNum2=""
   IF Huff="0"|Opt="2"&Play="W"|Opt="3" THEN IF Play.Player=Play THEN CJump="1"
   Parse Var Move M1" "Move
   IF Words(Move)>1 THEN CJump="2"
   IF Play="B"&Let4=1&King="0"|Play="W"&Let4=8&King="0" THEN CJump="0"
  End
  Call Grid2(Num3);Let=Word(Let,1);GLet=Let.Let""Num
  Call Grid2(Num4);Let=Word(Let,1);GLet2=Let.Let""Num
  Move2=GLet GLet2
  IF TMove="" THEN TMove=GLet" "
  TMove=TMove""GLet2" "
  Piece=P.Num3;P.Num3=""
  P.Num4=Piece
  IF Play="B"&Let4=1|Play="W"&Let4=8 THEN P.Num4=Upper(Piece)
  IF CJump="0" THEN DO
   Call Send(TMove)
   Call Switch()
  End
  Call GMove()
  IF Opt="3" THEN Call Delay(Delay)
 End
 ELSE IF CJump="2" THEN DO
  Call Switch()
  Call ToPipe('ID 'MG' gt="Invalid multiple jump"')
  CJump="0";Error="1"
 End
End

Call rtezrequest("Game over!")
Call Break_C()
Exit

NewGame:
IF ~Open(PIPE2,"AWNPipe:RXDraughts2/xc","RW") THEN DO
 SAY "Unable to open GUI, please install AWNPipe:"
 Exit
End

TPipe="PIPE2"

Call ToPipe('title "New Game" v m defg')
Call ToPipe('layout gt="Player options" so v')
PG=ToPipe(' radiobutton rl="Two human players|Against the computer|Watch the computer|Online multiplayer"')
Call ToPipe('le')
Call ToPipe('space')
Call ToPipe('layout gt="Load game" so')
Call ToPipe(' layout v b=0')
Call ToPipe('  label gt="Next player"')
Call ToPipe('  space')
PG2=ToPipe('  radiobutton rl="Black|Yellow"')
Call ToPipe(' le')
Call ToPipe(' space')
Call ToPipe(' label gt="File: " ua')
FG=ToPipe(' getfile chl')
Call ToPipe('le')
Call ToPipe('space')
Call ToPipe('layout gt="Online options" so')
Call ToPipe(' layout v b=0')
Call ToPipe('  label gt="Player"')
Call ToPipe('  space')
PG3=ToPipe('  radiobutton rl="One|Two"')
Call ToPipe(' le')
Call ToPipe(' space')
Call ToPipe(' label gt="IP: " ua')
HG=ToPipe(' string lj chl')
Call ToPipe('le')
SG=ToPipe('button gt="Start"')
Call ToPipe('open')
Start="0";Opt="1"
IP="";Play="B"
TFile="";Plr="1"
DO UNTIL Start="1"
 Call ToPipe('con')
 Output=ReadLn(PIPE2)
 Parse Var Output W1" "W2" "W3" 1 "W4
 IF W1="close" THEN Exit
 IF W2=PG THEN Opt=W3+1
 IF W2=PG2 THEN DO
  IF W3="0" THEN Play="B"
  ELSE Play="W"
 End
 IF W2=FG THEN TFile=Strip(Left(W4,Length(W4)-1),,d2c(34))
 IF W2=PG3 THEN Plr=W3+1
 IF W2=HG THEN IP=W3
 IF W2=SG THEN DO
  IF Opt="4"&IP="" THEN Call rtezrequest("You must enter an IP address!")
  ELSE Start="1"
 End
End
Player=Plr
Play.1="B"
Play.2="W"
IF Opt<4 THEN Plr=""
Call Close(PIPE2)
Return 0

GUI:
Dis="";Num=1
TPipe="PIPE"

IF ~Open(PIPE,"AWNPipe:RXDraughts/xc","RW") THEN DO
 SAY "Unable to open GUI, please install AWNPipe:"
 Exit
End

Call ToPipe('title "RXDraughts ©2003 Michael Trebilcock" v fw fh m defg')
Call ToPipe('layout v b=5 cj weih=0')
Call ToPipe(' label gt="Welcome to RXDraughts 2.3"')
Call ToPipe(' label gt="©2003 Michael Trebilcock"')
Call ToPipe(' label gt=""')
Call ToPipe('le')
Call ToPipe('layout v b=2 weih=0')
MG=ToPipe(' button ro b=0 gt "'Text'"')
Call ToPipe('le')
Call ToPipe('layout b=5')
Call ToPipe(' layout v so weiw=0')
Call ToPipe('  layout v b=0 weih=0')
SG=ToPipe('   button gt="Save Game"')
Call ToPipe('   label gt=""')
Call ToPipe('   label gt=""')
RG=ToPipe('   button gt="Huff"')
Call ToPipe('   label gt=""')
HG=ToPipe('   button gt="Hold"')
QG=ToPipe('   button gt="Quit" c')
Call ToPipe('  le')
Call ToPipe('  layout v b=0')
Call ToPipe('  le')
Call ToPipe(' le')
Call ToPipe(' bitmap fn="Theme/'Theme'/1" anim 0|0|0|0|0|0|0')
Call ToPipe(' layout v b=0')
Call Nums()
Call Buttons()
Call Nums()
Call ToPipe(' le')
Call ToPipe('le')
Call ToPipe('open')
Call Pieces()
Return 0

Nums:
Call ToPipe('  layout b=0')
Call ToPipe('   button minw=30 ro b=0 gt=""')
DO i=1 TO 8
 Call ToPipe('   button minw=30 ro b=0 gt="'i'"')
End
Call ToPipe('   button minw=30 ro b=0 gt=""')
Call ToPipe('  le')
Return 0

Buttons:
DO a=1 TO 8
 Top=(a*30)-30+1
 IF Dis="" THEN DO
  Dis=" ro";Dis2=""
 End
 ELSE DO
  Dis="";Dis2=" ro"
 End
 Call ToPipe('  layout b=0')
 Call ToPipe('   button minw=30 minh=30 ro b=0 gt="'Let.a'"')
 GadNum=ToPipe('   button minw=30 minh=30'Dis' b=0 anim 1|'Top'|29|29|0|0|0')
 Call ToPipe('   button minw=30 minh=30'Dis2' b=0 anim 31|'Top'|29|29|0|0|0')
 Call ToPipe('   button minw=30 minh=30'Dis' b=0 anim 61|'Top'|29|29|0|0|0')
 Call ToPipe('   button minw=30 minh=30'Dis2' b=0 anim 91|'Top'|29|29|0|0|0')
 Call ToPipe('   button minw=30 minh=30'Dis' b=0 anim 121|'Top'|29|29|0|0|0')
 Call ToPipe('   button minw=30 minh=30'Dis2' b=0 anim 151|'Top'|29|29|0|0|0')
 Call ToPipe('   button minw=30 minh=30'Dis' b=0 anim 181|'Top'|29|29|0|0|0')
 Call ToPipe('   button minw=30 minh=30'Dis2' b=0 anim 211|'Top'|29|29|0|0|0')
 Call ToPipe('   button minw=30 minh=30 ro b=0 gt="'Let.a'"')
 Call ToPipe('  le')
 IF Dis=" ro" THEN GadNum=GadNum+1
 DO i=1 TO 4
  GP.GadNum=Num
  BP.Num=GadNum
  Num=Num+1
  GadNum=GadNum+2
 End
End
Return 0

Pieces:
DO i=1 TO 32
 PosX=P.i
 PosX=PosX.PosX
 Parse Var PosX PosX1" "PosX2
 Call Grid2(i)
 Top=(Let*30)-30+1+PosX1
 Left=(Num*30)-30+1+PosX2
 Call ToPipe('define bitmap anim 'Left'|'Top'|29|29|0|0|0')
 Call ToPipe('ID 'BP.i' ni=0')
End
Return 0

GMove:
IF Arg(1)="1" THEN DO
 Call ToPipe('ID 0 s=512')
 IF CJump="1" THEN DO
  Num3=Num4
  Move=Move" "
 End
 ELSE DO
  TMove="";Move=""
 End
 Done="";Sel="0"
 Call ToPipe('con')
 DO UNTIL Done="1"
  Output=ReadLn(PIPE)
  Parse Var Output W1" "W2" "W3
  IF W1="close" THEN Call Break_C()
  IF W2=SG THEN Call Save()
  IF W2=HG THEN DO
   IF Sel="0" THEN Sel="1"
   ELSE Sel="0"
   Call ToPipe('ID 'HG' selected='Sel)
  End
  IF W2>24 THEN DO
   Num4=GP.W2
   Call Grid2(Num4)
   Move=Move""Let.Let""Num" "
   IF CJump~="1"&Words(Move)>1&Upper(P.Num4)=Play THEN Move=Let.Let""Num" "
   IF Auto="1"&Words(Move)="1"&Sel="0"&Upper(P.Num4)=Play THEN DO
    IF Huff="0"&Words(TJP.Num4)="1" THEN DO
     Parse Var TJP.Num4 TheSq"/"GNum2"/"Num4
     Call Grid2(Num4)
     Move=Move""Let.Let""Num
    End
    ELSE IF Words(TJP.Num4)="0"&Words(TP.Num4)="1" THEN DO
     Call Grid2(TP.Num4)
     Move=Move""Let.Let""Num
    End
   End
  End
  IF CJump="1"&Pos("/"Num4" ",TJP.Num3)="0" THEN DO
   Call ToPipe('ID 'MG' gt="You cannot jump to that square"')
   Move=Word(Move,1)" "
  End
  ELSE Call ToPipe('ID 'MG' gt="'Move'"')
  IF Words(Move)>1&Sel="0" THEN Done="1"
  ELSE Call ToPipe('con')
 End
 Call ToPipe('ID 0 s=256')
End
ELSE DO
 Let=SubStr(GLet,1,1)
 Top=(Let.Let*30)-30+1
 Left=(SubStr(GLet,2,1)*30)-30+1
 Call ToPipe('define bitmap anim 'Left'|'Top'|29|29|0|0|0')
 Call ToPipe('ID 'BP.Num3' ni=0')
 IF Jump="1" THEN DO
  Call Grid2(GNum2)
  Top=(Let*30)-30+1
  Left=(Num*30)-30+1
  Call ToPipe('define bitmap anim 'Left'|'Top'|29|29|0|0|0')
  Call ToPipe('ID 'BP.GNum2' ni=0')
 End
 PosX=P.Num4
 PosX=PosX.PosX
 Parse Var PosX PosX1" "PosX2
 Let=SubStr(GLet2,1,1)
 Top=(Let.Let*30)-30+1+PosX1
 Left=(SubStr(GLet2,2,1)*30)-30+1+PosX2
 Call ToPipe('define bitmap anim 'Left'|'Top'|29|29|0|0|0')
 Call ToPipe('ID 'BP.Num4' ni=0')
End
Return 0

FMove2:
Layout=""
DO i=1 TO 32
 Piece=P.i
 IF Piece="" THEN Piece="*"
 Layout=Layout""Piece" "
End
Play3=Play
Call FMove()
IF CJump="1"&ValidJps=""|End="1" THEN Return 0
IF ValidJps~="" THEN Pieces=ValidJps
ELSE Pieces=ValidSqs
DO a=1 TO Words(Pieces)
 IF CJump="1" THEN Piece3=Num4
 ELSE Piece3=Word(Pieces,a)
 Piece4=Piece3
 IF TJP.Piece3~="" THEN Amount=Words(TJP.Piece3)
 ELSE Amount=Words(TP.Piece3)
 DO Count=1 TO Amount
  Bad.Piece4.Count="0"
  Good.Piece4.Count="0"
  DO Times=1 TO Diff
   Call ToPipe('ID 'MG' gt="(Thinking) 'a'/'Words(Pieces)' 'Count'/'Amount' 'Times'"')
   IF TJP.Piece3~="" THEN DO
    CJump="1"
    IF Piece3=Piece4 THEN Rnd=Count
    ELSE Rnd=Rand(1,Words(TJP.Piece3))
    Num4=Word(TJP.Piece3,Rnd)
    Parse Var Num4 TheSq"/"GNum2"/"Num4
    IF Play=Play3 THEN Good.Piece4.Count=Good.Piece4.Count+1
    ELSE Bad.Piece4.Count=Bad.Piece4.Count+1
   End
   ELSE DO
    IF Piece3=Piece4 THEN Rnd=Count
    ELSE Rnd=Rand(1,Words(TP.Piece3))
    Num4=Word(TP.Piece3,Rnd)
   End
   TPiece=P.Piece3
   P.Piece3=""
   IF TJP.Piece3~="" THEN P.GNum2=""
   P.Num4=TPiece
   IF Play="W"&Num4>28&Num4<33 THEN Let4=8
   IF Play="B"&Num4>0&Num4<5 THEN Let4=1
   IF Play="B"&Let4=1|Play="W"&Let4=8 THEN DO
    P.Num4=Upper(TPiece)
    IF Play=Play3 THEN Good.Piece4.Count=Good.Piece4.Count+1
    ELSE Bad.Piece4.Count=Bad.Piece4.Count+1
   End
   IF Play="B"&Let4=1&King="0"|Play="W"&Let4=8&King="0" THEN CJump="0"
   IF CJump="0" THEN DO
    IF Play="B" THEN Play="W"
    ELSE Play="B"
   End
   Call FMove()
   IF End="1" THEN DO
    IF Play=Play3 THEN Bad.Piece4.Count=Bad.Piece4.Count+1
    ELSE Good.Piece4.Count=Good.Piece4.Count+1
    IF Count~=Amount THEN Count=Amount-1
    Times=Diff
   End
   IF CJump="1"&ValidJps="" THEN DO
    CJump="0"
    IF Play="B" THEN Play="W"
    ELSE Play="B"
    Call FMove()
    IF End="1" THEN DO
     IF Play=Play3 THEN Bad.Piece4.Count=Bad.Piece4.Count+1
     ELSE Good.Piece4.Count=Good.Piece4.Count+1
     IF Count~=Amount THEN Count=Amount-1
     Times=Diff
    End
   End
   IF ValidJps~="" THEN DO
    Amount2=Words(ValidJps)
    IF CJump="1" THEN Minus=Amount2
    ELSE Minus="0"
    IF Play=Play3 THEN Good.Piece4.Count=Good.Piece4.Count+Amount2-Minus
    ELSE Bad.Piece4.Count=Bad.Piece4.Count+Amount2-Minus
    IF CJump="1" THEN Piece3=Num4
    ELSE Piece3=Word(ValidJps,Rand(1,Words(ValidJps)))
   End
   ELSE IF ValidSqs~="" THEN Piece3=Word(ValidSqs,Rand(1,Words(ValidSqs)))
  End
  DO i=1 TO Words(Layout)
   Piece=Word(Layout,i)
   IF Piece="*" THEN Piece=""
   P.i=Piece
  End
  End="0";Play=Play3 
  CJump="0";Piece3=Piece4
  Call FMove()
 End
 DO i=1 TO Words(Layout)
  Piece=Word(Layout,i)
  IF Piece="*" THEN Piece=""
  P.i=Piece
 End
 End="0";Play=Play3
 CJump="0"
 Call FMove()
End
Return 0

FMove:
IF CJump="1" THEN TheSqs=Num4
ELSE DO
 IF Play="B" THEN Colour="black"
 ELSE Colour="white"
 TheSqs=""
 DO i=1 TO 32
  IF Play="B"&Upper(P.i)="B"|Play="W"&Upper(P.i)="W" THEN TheSqs=TheSqs""i" "
 End
 IF TheSqs="" THEN End="1"
End
Words=Words(TheSqs)
ValidSqs="";ValidJps=""
IF End~="1" THEN DO i=1 TO Words
 TheSq=Word(TheSqs,i)
 King="0"
 IF Upper(P.TheSq)=P.TheSq THEN King="1"
 Call Grid2(TheSq)
 Call Grid(Let+1 Num-1);NextSq=GNum2
 Call Grid(Let+1 Num+1);NextSq2=GNum2
 Call Grid(Let+2 Num-2);NextSq3=GNum2
 Call Grid(Let+2 Num+2);NextSq4=GNum2
 Call Grid(Let-1 Num-1);NextSq5=GNum2
 Call Grid(Let-1 Num+1);NextSq6=GNum2
 Call Grid(Let-2 Num-2);NextSq7=GNum2
 Call Grid(Let-2 Num+2);NextSq8=GNum2
 TP.TheSq="";TJP.TheSq=""
 IF Play="W" THEN DO
  Play2="B"
  Piece=King;Piece2="1"
 End
 ELSE DO
  Play2="W"
  Piece="1";Piece2=King
 End
 IF Upper(P.NextSq)=Play2&P.NextSq3=""&King=Piece THEN TJP.TheSq=TJP.TheSq""TheSq"/"NextSq"/"NextSq3" "
 IF Upper(P.NextSq2)=Play2&P.NextSq4=""&King=Piece THEN TJP.TheSq=TJP.TheSq""TheSq"/"NextSq2"/"NextSq4" "
 IF Upper(P.NextSq5)=Play2&P.NextSq7=""&King=Piece2 THEN TJP.TheSq=TJP.TheSq""TheSq"/"NextSq5"/"NextSq7" "
 IF Upper(P.NextSq6)=Play2&P.NextSq8=""&King=Piece2 THEN TJP.TheSq=TJP.TheSq""TheSq"/"NextSq6"/"NextSq8" "
 IF P.NextSq=""&King=Piece THEN TP.TheSq=TP.TheSq""NextSq" "
 IF P.NextSq2=""&King=Piece THEN TP.TheSq=TP.TheSq""NextSq2" "
 IF P.NextSq5=""&King=Piece2 THEN TP.TheSq=TP.TheSq""NextSq5" "
 IF P.NextSq6=""&King=Piece2 THEN TP.TheSq=TP.TheSq""NextSq6" "
 IF TP.TheSq~="" THEN ValidSqs=ValidSqs""TheSq" "
 IF TJP.TheSq~="" THEN DO
  Jump="1"
  ValidJps=ValidJps""TheSq" "
 End
End
IF CJump~="1"&End~="1"&ValidSqs=""&ValidJps="" THEN End="1"
Return 0

Grid:
Parse Arg GLet" "GNum
IF GLet<1|GLet>8|GNum<1|GNum>8 THEN GNum2="."
ELSE DO
 GNum2=GNum/2
 IF Right(GNum2,2)=".5" THEN GNum2=GNum2+0.5
 Parse Var GNum2 GNum2"."Decimal
 GNum2=(GLet*4-4)+GNum2
End
Return 0

Grid2:
Let=Arg(1)
Let=Let/4+1
Parse Var Let Let"."Dec
IF Dec="25" THEN Num="1"
IF Dec="5" THEN Num="3"
IF Dec="75" THEN Num="5"
IF Dec="" THEN DO
 Let=Let-1
 Num="7"
End
IF Pos(".",Let/2)>0 THEN Num=Num+1
Return 0

Send:
IF Plr="1"&Play="B"|Plr="2"&Play="W" THEN DO
 i=0;Sent="0"
 DO UNTIL i="5"|Sent="1"
  IF ~Open(TCP,"TCP:"IP"/998","W") THEN Call Delay(50)
  ELSE DO;Call WriteLn(TCP,Arg(1));Sent="1";End
  i=i+1
 End
 Call Close(TCP)
 SAY i "Attempt(s)"
 IF Sent="0" THEN DO
  SAY "Unable to send move.."
  Call Save()
  Call Break_C()
 End
End
Return 0

Save:
Call ToPipe('ID 'MG' gt="Save Game"')
TFile=rtfilerequest("","","RXDraughts","Save")
IF rtresult="0" THEN Return 0
IF ~Open(File,TFile,"W") THEN DO
 SAY "Unable to open "TFile
End
ELSE DO
 DO i=1 TO 32
  Call WriteLn(File,P.i)
 End
 Call Close(File)
 SAY "Game saved.."
End
Return 0

Switch:
IF Play="B" THEN Play="W"
ELSE Play="B"
IF Play="B" THEN Call ToPipe('ID 'MG' gt="Next: Black  Last move: 'Move2'"')
ELSE Call ToPipe('ID 'MG' gt="Next: White  Last move: 'Move2'"')
Return 0

ToPipe:
Call WriteLn(TPipe,Arg(1))
Output=ReadLn(TPipe)
Parse Var Output W1" "Word2" "W3
IF Word(Output,1)="close" THEN Call Break_C()
Return Word2

Halt:
Break_C:
IF Opt="4"&Plr="2" THEN DO
 Call Open(TCP,"TCP:localhost/998","R")
 Call Close(TCP)
End
IF Move="EOF" THEN SAY "Opponent has quit the game.."
IF Plr="1"&Play="B"|Plr="2"&Play="W" THEN IF Open(TCP,"TCP:"IP"/998","W") THEN Call WriteLn(TCP,"EOF")
SAY "***Break"
Call Close(TPipe)
Exit
