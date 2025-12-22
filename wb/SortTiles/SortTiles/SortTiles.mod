MODULE SortTiles;

IMPORT
       y:SYSTEM,
       g:Graphics,
       d:Dos,
       e:Exec,
       fs:FileSystem,
       Random,
       mt:MathTrans,
       gt:GadTools,
       I:Intuition,
       conv:Conversions,
       io,
       wb:Workbench,
       ic:Icon,
       ol:OberonLib,
       u:Utility;

TYPE
     strg=ARRAY 100 OF CHAR;
     MsgT=ARRAY 4 OF strg;

CONST
     Messies=MsgT("SortTiles","Lets get faster....","Click to start",
     "Game Over");



TYPE TileT=ARRAY 5 OF INTEGER;
     TileA=ARRAY 5 OF TileT;
     TSet =ARRAY 5 OF INTEGER;
     CSet =ARRAY 6 OF INTEGER;
     NmSt =ARRAY 7 OF INTEGER;
     NmSs =ARRAY 10 OF NmSt;

CONST
     Tiles=TileA(
              0 , 1, 5,10,15,
              2 , 3, 4, 9,14,
              6 , 7,11,12,17,
              8 ,13,18,19,24,
              16,20,21,22,23
              );

     Nums =NmSs(
              1,1,1,0,1,1,1,
              0,0,1,0,0,1,0,
              1,0,1,1,1,0,1,
              1,0,1,1,0,1,1,
              0,1,1,1,0,1,0,
              1,1,0,1,0,1,1,
              1,1,0,1,1,1,1,
              1,0,1,0,0,1,0,
              1,1,1,1,1,1,1,
              1,1,1,1,0,1,1);



VAR
     Scr:I.ScreenPtr;
     Win:I.WindowPtr;
     helpname:strg;
     iwx,iwy,iwh,iww:INTEGER;
     wx,wy,wh,ww:INTEGER;
     ox,oy,sx,sy:INTEGER;
     sets:ARRAY 5 OF TSet;
     Colors:CSet;
     scor,bonus,tims,timf,tim,timo,ns,nc:INTEGER;
     high,Smsg,Smsgo:INTEGER;

PROCEDURE OpenWindow;
BEGIN;
Win:=I.OpenWindowTagsA(NIL,I.waInnerWidth,iww,I.waInnerHeight,iwh,
 I.waLeft,iwx,I.waTop,iwy,
 I.waTitle,y.ADR("SortTiles"),
 I.waIDCMP,LONGSET{I.closeWindow,I.newSize,I.mouseButtons,
    I.intuiTicks,I.inactiveWindow},
 I.waFlags,LONGSET{I.windowDepth,I.windowDrag,I.windowSizing,
    I.windowClose,I.activate,I.reportMouse,I.rmbTrap},
 I.waMaxWidth,2048,I.waMaxHeight,2048,
 I.waMinWidth,120,I.waMinHeight,40,
 u.done);
END OpenWindow;

PROCEDURE UpdMsg;
BEGIN;
IF Smsg#Smsgo THEN
 Smsgo:=Smsg;
 I.SetWindowTitles(Win,y.ADR(Messies[Smsg]),-1);
END;
END UpdMsg;

PROCEDURE CalcWin;
BEGIN;
ox:=Win.borderLeft;
oy:=Win.borderTop;
wx:=Win.leftEdge;
wy:=Win.topEdge;
ww:=Win.width-Win.borderLeft-Win.borderRight;
wh:=Win.height-Win.borderTop-Win.borderBottom;
sx:=ww DIV 31;
sy:=wh DIV 13;
END CalcWin;

PROCEDURE Save;
VAR f:fs.File;
BEGIN;
CalcWin;
iwx:=wx;iwy:=wy;
iww:=ww;iwh:=wh;
IF fs.Open(f,"ENVARC:SortTiles.prefs",TRUE) THEN
 IF fs.Write(f,iwx) THEN END;
 IF fs.Write(f,iwy) THEN END;
 IF fs.Write(f,iww) THEN END;
 IF fs.Write(f,iwh) THEN END;
 IF fs.Write(f,high) THEN END;
 IF fs.Close(f) THEN END;
END;
END Save;

PROCEDURE Load;
VAR f:fs.File;
BEGIN;
IF fs.Open(f,"ENVARC:SortTiles.prefs",FALSE) THEN
 IF fs.Read(f,iwx) THEN END;
 IF fs.Read(f,iwy) THEN END;
 IF fs.Read(f,iww) THEN END;
 IF fs.Read(f,iwh) THEN END;
 IF fs.Read(f,high) THEN END;
 IF fs.Close(f) THEN END;
END;
END Load;

PROCEDURE GetToolTypes;
VAR This:d.ProcessPtr;
    wbm:wb.WBStartupPtr;
    sptr:e.STRPTR;
    MyIcon:wb.DiskObjectPtr;
    OCurrentDir:d.FileLockPtr;
    li:LONGINT;
BEGIN;
This:=y.VAL(d.ProcessPtr,ol.Me);
IF ol.wbStarted THEN
 wbm:=ol.wbenchMsg;
 OCurrentDir:=This.currentDir;
 y.SETREG(0,d.CurrentDir(wbm.argList[0].lock));
 MyIcon := ic.GetDiskObject(wbm.argList[0].name^);
 y.SETREG(0,d.CurrentDir(OCurrentDir));
 IF MyIcon#NIL THEN
  sptr := ic.FindToolType(MyIcon.toolTypes,"HELPFILE");
  IF sptr#NIL THEN COPY(sptr^,helpname);END;
  sptr := ic.FindToolType(MyIcon.toolTypes,"COL1");
  IF sptr#NIL THEN IF conv.StringToInt(sptr^,li) THEN Colors[1]:=SHORT(li);END;END;
  sptr := ic.FindToolType(MyIcon.toolTypes,"COL2");
  IF sptr#NIL THEN IF conv.StringToInt(sptr^,li) THEN Colors[2]:=SHORT(li);END;END;
  sptr := ic.FindToolType(MyIcon.toolTypes,"COL3");
  IF sptr#NIL THEN IF conv.StringToInt(sptr^,li) THEN Colors[3]:=SHORT(li);END;END;
  sptr := ic.FindToolType(MyIcon.toolTypes,"COL4");
  IF sptr#NIL THEN IF conv.StringToInt(sptr^,li) THEN Colors[4]:=SHORT(li);END;END;
  sptr := ic.FindToolType(MyIcon.toolTypes,"COL5");
  IF sptr#NIL THEN IF conv.StringToInt(sptr^,li) THEN Colors[5]:=SHORT(li);END;END;
  ic.FreeDiskObject(MyIcon);
 END;
END;
END GetToolTypes;

PROCEDURE Init;
VAR n,m:INTEGER;
BEGIN;
iwx:=0;iwy:=0;iwh:=130;iww:=310;high:=0;
Colors:=CSet(0,1,2,3,4,5);
helpname:="PROGDIR:SortTiles.shortdoc";
GetToolTypes;
Load;
OpenWindow;
FOR n:=0 TO 4 DO FOR m:=0 TO 4 DO sets[n,m]:=-1;END;END;
sx:=10;sy:=10;
ox:=10;oy:=10;
nc:=2;ns:=2;
timf:=30;bonus:=5;
CalcWin;
END Init;

 PROCEDURE RenderNum(c,n,x,y,p:INTEGER);
 BEGIN;
  g.SetAPen(Win.rPort,c);
  IF Nums[n,0]=1 THEN
   g.Move(Win.rPort,x+ox+(13+p*2)*sx,y+oy+9*sy);
   g.Draw(Win.rPort,x+ox+(14+p*2)*sx,y+oy+9*sy);
  END;
  IF Nums[n,1]=1 THEN
   g.Move(Win.rPort,x+ox+(13+p*2)*sx,y+oy+9*sy);
   g.Draw(Win.rPort,x+ox+(13+p*2)*sx,y+oy+10*sy);
  END;
  IF Nums[n,2]=1 THEN
   g.Move(Win.rPort,x+ox+(14+p*2)*sx,y+oy+9*sy);
   g.Draw(Win.rPort,x+ox+(14+p*2)*sx,y+oy+10*sy);
  END;
  IF Nums[n,3]=1 THEN
   g.Move(Win.rPort,x+ox+(13+p*2)*sx,y+oy+10*sy);
   g.Draw(Win.rPort,x+ox+(14+p*2)*sx,y+oy+10*sy);
  END;
  IF Nums[n,4]=1 THEN
   g.Move(Win.rPort,x+ox+(13+p*2)*sx,y+oy+10*sy);
   g.Draw(Win.rPort,x+ox+(13+p*2)*sx,y+oy+11*sy);
  END;
  IF Nums[n,5]=1 THEN
   g.Move(Win.rPort,x+ox+(14+p*2)*sx,y+oy+10*sy);
   g.Draw(Win.rPort,x+ox+(14+p*2)*sx,y+oy+11*sy);
  END;
  IF Nums[n,6]=1 THEN
   g.Move(Win.rPort,x+ox+(13+p*2)*sx,y+oy+11*sy);
   g.Draw(Win.rPort,x+ox+(14+p*2)*sx,y+oy+11*sy);
  END;
 END RenderNum;

PROCEDURE RenderBorders;
VAR n:INTEGER;
BEGIN;
FOR n:=0 TO 4 DO
 g.SetAPen(Win.rPort,2);
 g.Move(Win.rPort,ox+(n*6+1)*sx-1,oy+6*sy-1);
 g.Draw(Win.rPort,ox+(n*6+1)*sx-1,oy+sy-1);
 g.Draw(Win.rPort,ox+(n*6+6)*sx-1,oy+sy-1);
 g.SetAPen(Win.rPort,1);
 g.Move(Win.rPort,ox+(n*6+1)*sx,oy+6*sy);
 g.Draw(Win.rPort,ox+(n*6+6)*sx,oy+6*sy);
 g.Draw(Win.rPort,ox+(n*6+6)*sx,oy+sy);
END;
 g.SetAPen(Win.rPort,1);
 g.Move(Win.rPort,ox+sx-1,oy+12*sy-1);
 g.Draw(Win.rPort,ox+sx-1,oy+7*sy-1);
 g.Draw(Win.rPort,ox+6*sx-1,oy+7*sy-1);
 g.SetAPen(Win.rPort,2);
 g.Move(Win.rPort,ox+sx,oy+12*sy);
 g.Draw(Win.rPort,ox+6*sx,oy+12*sy);
 g.Draw(Win.rPort,ox+6*sx,oy+7*sy);
 g.SetAPen(Win.rPort,2);
 g.Move(Win.rPort,ox+13*sx-1,oy+8*sy-1);
 g.Draw(Win.rPort,ox+13*sx-1,oy+7*sy-1);
 g.Draw(Win.rPort,ox+30*sx-1,oy+7*sy-1);
 g.SetAPen(Win.rPort,1);
 g.Move(Win.rPort,ox+13*sx,oy+8*sy-1);
 g.Draw(Win.rPort,ox+30*sx,oy+8*sy-1);
 g.Draw(Win.rPort,ox+30*sx,oy+7*sy);

g.SetAPen(Win.rPort,2);
g.DrawEllipse(Win.rPort,ox-1+7*sx+sx*5 DIV 2,oy-1+7*sy+sy*5 DIV 2,sx*5 DIV 2,sy*5 DIV 2);
g.SetAPen(Win.rPort,1);
g.DrawEllipse(Win.rPort,1+ox+7*sx+sx*5 DIV 2,1+oy+7*sy+sy*5 DIV 2,sx*5 DIV 2,sy*5 DIV 2);
g.SetAPen(Win.rPort,3);
g.DrawEllipse(Win.rPort,ox+7*sx+sx*5 DIV 2,oy+7*sy+sy*5 DIV 2,sx*5 DIV 2,sy*5 DIV 2);
END RenderBorders;

PROCEDURE RenderTile(n,c,x,y:INTEGER);
VAR px,py,cn:INTEGER;
BEGIN;
g.SetAPen(Win.rPort,Colors[c+1]);
FOR cn:=0 TO 4 DO
 px:=Tiles[n,cn] MOD 5 * sx;
 py:=Tiles[n,cn] DIV 5 * sy;
 g.RectFill(Win.rPort,ox+px+x,oy+py+y,ox+px+x+sx-1,oy+py+y+sy-1);
END;
END RenderTile;

PROCEDURE RenderBonus;
VAR n:INTEGER;
BEGIN;
g.SetAPen(Win.rPort,3);
FOR n:=1 TO 17 DO
 IF bonus<n THEN g.SetAPen(Win.rPort,0);END;
 g.RectFill(Win.rPort,ox+(12+n)*sx,oy+7*sy,ox+(13+n)*sx-2,oy+8*sy-2);
END;
END RenderBonus;

PROCEDURE RenderTiles;
VAR n,m,c:INTEGER;
BEGIN;
FOR n:=0 TO 4 DO
 FOR m:=0 TO 4 DO
  c:=sets[n,m];
  RenderTile(m,c,sx+(sx*6)*n,sy);
 END;
END;
END RenderTiles;

PROCEDURE RenderNext;
BEGIN;
 RenderTile(0,-1,sx,sy*7);
 RenderTile(1,-1,sx,sy*7);
 RenderTile(2,-1,sx,sy*7);
 RenderTile(3,-1,sx,sy*7);
 RenderTile(4,-1,sx,sy*7);
 RenderTile(ns,nc,sx,sy*7);
END RenderNext;

PROCEDURE NewTile;
VAR n,m:INTEGER;
    cn:ARRAY 5 OF INTEGER;
BEGIN;
nc:=Random.RND(5);
ns:=Random.RND(5);
IF Random.RND(100)<50 THEN
 FOR n:=0 TO 4 DO cn[n]:=0;END;
 FOR n:=0 TO 4 DO
  FOR m:=0 TO 4 DO
   IF sets[m,n]#-1 THEN INC(cn[n]);END;
  END;
 END;
 m:=0;
 FOR n:=1 TO 4 DO
  IF cn[n]<cn[m] THEN m:=n;END;
 END;
 ns:=m;
END;
RenderNext;
END NewTile;

PROCEDURE RenderClock;
BEGIN;
g.SetAPen(Win.rPort,0);
g.Move(Win.rPort,ox-1+7*sx+sx*5 DIV 2,oy-1+7*sy+sy*5 DIV 2);
g.Draw(Win.rPort,ox-1+7*sx+sx*5 DIV 2+SHORT(ENTIER(mt.Cos(0.0031415*timo)*sx*1.5)),oy-1+7*sy+sy*5 DIV 2+SHORT(ENTIER(mt.Sin(0.0031415*timo)*sx*1.5)));
g.Move(Win.rPort,ox+1+7*sx+sx*5 DIV 2,oy+1+7*sy+sy*5 DIV 2);
g.Draw(Win.rPort,ox+1+7*sx+sx*5 DIV 2+SHORT(ENTIER(mt.Cos(0.0031415*timo)*sx*1.5)),oy+1+7*sy+sy*5 DIV 2+SHORT(ENTIER(mt.Sin(0.0031415*timo)*sx*1.5)));
g.Move(Win.rPort,ox+7*sx+sx*5 DIV 2,oy+7*sy+sy*5 DIV 2);
g.Draw(Win.rPort,ox+7*sx+sx*5 DIV 2+SHORT(ENTIER(mt.Cos(0.0031415*timo)*sx*1.5)),oy+7*sy+sy*5 DIV 2+SHORT(ENTIER(mt.Sin(0.0031415*timo)*sx*1.5)));
g.SetAPen(Win.rPort,2);
g.Move(Win.rPort,ox-1+7*sx+sx*5 DIV 2,oy-1+7*sy+sy*5 DIV 2);
g.Draw(Win.rPort,ox-1+7*sx+sx*5 DIV 2+SHORT(ENTIER(mt.Cos(0.0031415*tim)*sx*1.5)),oy-1+7*sy+sy*5 DIV 2+SHORT(ENTIER(mt.Sin(0.0031415*tim)*sx*1.5)));
g.SetAPen(Win.rPort,1);
g.Move(Win.rPort,ox+1+7*sx+sx*5 DIV 2,oy+1+7*sy+sy*5 DIV 2);
g.Draw(Win.rPort,ox+1+7*sx+sx*5 DIV 2+SHORT(ENTIER(mt.Cos(0.0031415*tim)*sx*1.5)),oy+1+7*sy+sy*5 DIV 2+SHORT(ENTIER(mt.Sin(0.0031415*tim)*sx*1.5)));
g.SetAPen(Win.rPort,3);
g.Move(Win.rPort,ox+7*sx+sx*5 DIV 2,oy+7*sy+sy*5 DIV 2);
g.Draw(Win.rPort,ox+7*sx+sx*5 DIV 2+SHORT(ENTIER(mt.Cos(0.0031415*tim)*sx*1.5)),oy+7*sy+sy*5 DIV 2+SHORT(ENTIER(mt.Sin(0.0031415*tim)*sx*1.5)));
END RenderClock;

PROCEDURE RenderHScor;
VAR n,m,t:INTEGER;
BEGIN;
 t:=high;
 g.SetAPen(Win.rPort,0);
 g.RectFill(Win.rPort,ox+23*sx-1,oy+9*sy-1,ox+30*sx+1,oy+11*sy+1);
 FOR n:=0 TO 3 DO
  m:=t MOD 10;
  RenderNum(2,m,-1,-1,8-n);
  RenderNum(1,m,1,1,8-n);
  RenderNum(0,m,0,0,8-n);
  t:=t DIV 10;
 END;
END RenderHScor;

PROCEDURE RenderScor;
VAR n,m,t:INTEGER;
BEGIN;
 t:=scor;
 g.SetAPen(Win.rPort,0);
 g.RectFill(Win.rPort,ox+13*sx-1,oy+9*sy-1,ox+20*sx+1,oy+11*sy+1);
 FOR n:=0 TO 3 DO
  m:=t MOD 10;
  RenderNum(2,m,-1,-1,3-n);
  RenderNum(1,m,1,1,3-n);
  RenderNum(3,m,0,0,3-n);
  t:=t DIV 10;
 END;
END RenderScor;

PROCEDURE RedrawWin;
BEGIN;
CalcWin;
g.SetAPen(Win.rPort,0);
g.RectFill(Win.rPort,ox,oy,Win.width-Win.borderRight-1,Win.height-Win.borderBottom-1);
RenderBorders;
RenderTiles;
RenderNext;
RenderBonus;
RenderScor;
RenderHScor;
END RedrawWin;

PROCEDURE ShowHelp;
VAR f:fs.File;
    t:strg;
BEGIN;
IF fs.Open(f,helpname,FALSE) THEN
 WHILE fs.ReadString(f,t) DO
  io.WriteString(t);io.WriteLn;
 END;
 IF fs.Close(f) THEN END;
END;
END ShowHelp;

PROCEDURE Loop;
VAR ims,ims2:I.IntuiMessagePtr;
    quit,over,al:BOOLEAN;
    xp,yp,id,k:INTEGER;
BEGIN;
quit:=FALSE;over:=TRUE;
WHILE ~quit DO
Smsg:=2;UpdMsg;
RenderHScor;
WHILE (~quit)AND(over) DO
 ims:=e.GetMsg(Win.userPort)(I.IntuiMessagePtr);
 IF ims=NIL THEN
  e.WaitPort(Win.userPort);
 ELSE
  IF I.closeWindow IN ims.class THEN quit:=TRUE;END;
  IF I.newSize IN ims.class THEN RedrawWin;END;
  IF I.mouseButtons IN ims.class THEN over:=FALSE;END;
  e.ReplyMsg(ims);
 END;
END;
FOR k:=0 TO 4 DO FOR id:=0 TO 4 DO sets[id,k]:=-1;END;END;
timf:=30;bonus:=5;
CalcWin;
NewTile;
tim:=1500;timo:=1500;scor:=0;
Smsg:=0;Smsgo:=-1;
RedrawWin;
WHILE (~quit)AND(~over) DO
 id:=-1;
 ims:=e.GetMsg(Win.userPort)(I.IntuiMessagePtr);
 IF ims=NIL THEN
  e.WaitPort(Win.userPort);
 ELSE
  IF I.closeWindow IN ims.class THEN quit:=TRUE;END;
  IF I.newSize IN ims.class THEN RedrawWin;END;
  IF I.inactiveWindow IN ims.class THEN
   I.SetWindowTitles(Win,y.ADR("Paused..."),-1);
   Smsgo:=-1;
   CalcWin;
       g.SetAPen(Win.rPort,0);
       g.RectFill(Win.rPort,ox,oy,Win.width-Win.borderRight-1,Win.height-Win.borderBottom-1);
       RenderBorders;
       RenderBonus;
       RenderHScor;
       RenderScor;
   al:=FALSE;
   REPEAT;
    ims2:=e.GetMsg(Win.userPort)(I.IntuiMessagePtr);
    IF ims2=NIL THEN
     e.WaitPort(Win.userPort);
    ELSE
     IF I.mouseButtons IN ims2.class THEN al:=TRUE; END;
     IF I.closeWindow IN ims2.class THEN al:=TRUE;quit:=TRUE;END;
     IF I.newSize IN ims2.class THEN CalcWin;
       g.SetAPen(Win.rPort,0);
       g.RectFill(Win.rPort,ox,oy,Win.width-Win.borderRight-1,Win.height-Win.borderBottom-1);
       RenderBorders;
       RenderBonus;
       RenderHScor;
       RenderScor;
     END;
     e.ReplyMsg(ims2);
    END;
   UNTIL al;
   RedrawWin;
  END;
  IF I.intuiTicks IN ims.class THEN
   timo:=tim;tim:=tim+timf;
   RenderClock;
   IF tim>3500 THEN
    timo:=tim;tim:=1500;
    RenderClock;
    DEC(bonus);
    RenderBonus;
    NewTile;
    IF bonus<1 THEN over:=TRUE;Smsg:=3;IF scor>high THEN high:=scor;END;END;
   END;
  END;
  UpdMsg;
  IF I.mouseButtons IN ims.class THEN
   IF (ims.code=233) THEN
    ShowHelp;
   END;
   IF (ims.code=232)AND(ims.mouseX>ox) THEN
    xp:=(ims.mouseX-ox) DIV sx;
    yp:=(ims.mouseY-oy) DIV sy;
    IF (yp>0)AND(yp<6) THEN
     IF (xp MOD 6 >0) AND (xp <30) THEN
      id:=xp DIV 6;
      IF sets[id,ns]=-1 THEN
       IF (scor>50)AND(timf<110) THEN Smsg:=1;INC(timf);END;
       IF timf=110 THEN Smsg:=0;END;
       INC(scor);
       RenderScor;
       sets[id,ns]:=nc;
       timo:=tim;tim:=1500;
       RenderClock;
       al:=TRUE;
       FOR k:=0 TO 4 DO
        IF sets[id,k]=-1 THEN al:=FALSE;END;
       END;
       IF al THEN
        IF (sets[id,0]=sets[id,1])AND
           (sets[id,0]=sets[id,2])AND
           (sets[id,0]=sets[id,3])AND
           (sets[id,0]=sets[id,4])AND
           (bonus<17)
         THEN
         INC(bonus);
        END;
        FOR k:=0 TO 4 DO sets[id,k]:=-1;END;
       END;
       RenderTiles;
       RenderBonus;
       NewTile;
      END;
     END;
    END;
   END;
  END;
  e.ReplyMsg(ims);
 END;
END;
END;
Save;
END Loop;



BEGIN;
Init;ns:=0;nc:=-1;
RedrawWin;
Loop;
CLOSE;
I.CloseWindow(Win);
END SortTiles.

