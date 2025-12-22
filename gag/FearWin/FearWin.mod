MODULE FearWin;

IMPORT
       I:Intuition,
       d:Dos,
       Break,
       NoGuru,
       y:SYSTEM,
       io;

VAR
       scr:I.ScreenPtr;
       win:I.WindowPtr;

PROCEDURE DoWin1(win:I.WindowPtr);
VAR sw,sh,ww,wh,wx,wy,nx,ny,tx,ty,mx,my:LONGINT;
    ds,dk:LONGINT;
BEGIN;
ww:=win.width;wh:=win.height;
mx:=win.wScreen.mouseX;
my:=win.wScreen.mouseY;
wx:=win.leftEdge;
wy:=win.topEdge;
IF (mx>wx)AND(mx<wx+ww)AND(my>wy)AND(my<wy+wh) THEN
sw:=win.wScreen.width;
sh:=win.wScreen.height;
 IF (sw*3>ww*4)OR(sh*3>wh*4) THEN
  ww:=ww DIV 2;
  wh:=wh DIV 2;
  wx:=win.leftEdge+ww;
  wy:=win.topEdge+wh;
  nx:=0;ny:=0;dk:=0;
  tx:=ww+2;ty:=wh+2;ds:=(tx-mx)*(tx-mx)+(ty-my)*(ty-my);
  IF ds>dk THEN nx:=tx;ny:=ty;dk:=ds;END;
  tx:=sw-ww-2;ty:=wh+2;ds:=(tx-mx)*(tx-mx)+(ty-my)*(ty-my);
  IF ds>dk THEN nx:=tx;ny:=ty;dk:=ds;END;
  tx:=ww+2;ty:=sh-wh-2;ds:=(tx-mx)*(tx-mx)+(ty-my)*(ty-my);
  IF ds>dk THEN nx:=tx;ny:=ty;dk:=ds;END;
  tx:=sw-ww-2;ty:=sh-wh-2;ds:=(tx-mx)*(tx-mx)+(ty-my)*(ty-my);
  IF ds>dk THEN nx:=tx;ny:=ty;dk:=ds;END;
  I.MoveWindow(win,nx-wx,ny-wy);
 END;
END;
END DoWin1;

PROCEDURE DoScreen;
VAR win:I.WindowPtr;
BEGIN;
win:=scr.firstWindow;
REPEAT;
 DoWin1(win);
 win:=win.nextWindow;
UNTIL win=NIL;
END DoScreen;

VAR n:INTEGER;
BEGIN;
scr:=I.LockPubScreen(NIL);
REPEAT;
DoScreen;
d.Delay(10);
UNTIL FALSE;
CLOSE
I.UnlockPubScreen(NIL,scr);
END FearWin.

