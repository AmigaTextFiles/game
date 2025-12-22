MODULE NoMem;

IMPORT
    I:Intuition,
    y:SYSTEM,
    u:Utility,
    g:Graphics,
    d:Dos,
    io,
    Break,
    e:Exec;

VAR
    wn:I.WindowPtr;
    to,ac:LONGINT;
    n,m:INTEGER;

BEGIN;
wn:=I.OpenWindowTagsA(NIL,I.waInnerHeight,15,I.waInnerWidth,100,
 I.waTitle,y.ADR("MemoMile"),
 I.waFlags,LONGSET{I.activate,I.windowDrag,I.windowDepth},u.done);
REPEAT;
to:=e.AvailMem(LONGSET{e.total});
ac:=e.AvailMem(LONGSET{});
n:=SHORT(ac*100 DIV to);
g.SetAPen(wn.rPort,3);
FOR m:=0 TO n-1 DO
 g.Move(wn.rPort,wn.borderLeft+m,wn.borderTop);
 g.Draw(wn.rPort,wn.borderLeft+m,wn.borderTop+14);
END;
g.SetAPen(wn.rPort,0);
FOR m:=n TO 99 DO
 g.Move(wn.rPort,wn.borderLeft+m,wn.borderTop);
 g.Draw(wn.rPort,wn.borderLeft+m,wn.borderTop+14);
END;
IF n>3 THEN
IF e.AllocMem(16384,LONGSET{})#NIL THEN END;
END;
d.Delay(30);
UNTIL FALSE;
CLOSE
I.CloseWindow(wn);
END NoMem.



