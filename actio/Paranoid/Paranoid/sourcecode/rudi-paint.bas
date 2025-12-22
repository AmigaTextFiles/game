CLEAR ,35000&,4789
CHDIR ":basicdemos"
LIBRARY"graphics.library"
CHDIR ":rudi-paint"
SCREEN 2,320,256,5,1
WINDOW 3,"Rudi-Paint",,17,2
MENU 1,0,1,"Bild"
MENU 1,1,1,"Löschen"
MENU 1,2,1,"Farbe"
MENU 1,3,1,"Grösse"
MENU 1,4,1,"Laden"
MENU 1,5,1,"Speichern"
MENU 1,6,1,"Beenden"
MENU 1,7,1,"Info"
REM --------------------------------------
MENU 2,0,1,"Modus"
MENU 2,1,2,"  Punkte"
MENU 2,2,1,"  Linie"
MENU 2,3,1,"  Ellipse"
MENU 2,4,1,"  Rechteck"
MENU 2,5,1,"  Fllen"
REM ------------------------------------
MENU 3,0,1,"Pinsel"
MENU 3,1,2,"  Normal"
MENU 3,2,1,"  Fett"
REM ------------------------------------
MENU 4,0,1,"Allgemein"
MENU 4,1,1,"Messer"
MENU 4,2,1,"Kopierer"
MENU 4,3,1,"Spiegel"
MENU 4,4,1,"Text"
REM ------------------------------------
GOTO vmain:
com:
CALL SetDrMd (WINDOW(8),2)
RETURN
norm:
CALL SetDrMd (WINDOW(8),1)
RETURN
SUB gadget(text$,back) STATIC
WINDOW 4,"",(0,0)-(250,50),0,2
PRINT:PRINT text$
LOCATE 5,10:PRINT "JA":LOCATE 5,20:PRINT "NEIN"
LINE (68,28)-(95,43),1,b
LINE (150,28)-(186,43),1,b
gloop:
IF MOUSE (0)=0 THEN gloop
IF MOUSE (1)>67 AND MOUSE(1)<96 AND MOUSE(2)>27 AND MOUSE(2)<44 THEN 
back=1:GOTO gloop1 
END IF
IF MOUSE (1)>149 AND MOUSE(1)<187 AND MOUSE(2)>27 AND MOUSE(2)<44 THEN 
back=0:GOTO gloop1 
END IF
GOTO gloop
gloop1:
WINDOW CLOSE 4 
WINDOW OUTPUT 3
END SUB
REM ----------------------------------------------
vmain:
jumper=1:pinsel=1:kreisf=.88:tiefe=5
main:
x=MENU(0):y=MENU(1):REM  -             -                   -     -
IF x=1 THEN ON y GOSUB bildcut,farbe,pref,laden,speichern,halt,info
REM:                     -     -    -     -   -
IF x=2 THEN ON y GOSUB punkt,linie,kreis,rec,fill
REM                      -     -
IF x=3 THEN ON y GOSUB normal,fett
REM                     -      
IF x=4 THEN ON y GOSUB cut,move,effect,text
IF MOUSE(0)<>0 THEN ON jumper GOSUB punkt,linie,kreis,rec,fill
GOTO main
bildcut:
t$="Sind Sie sicher?":CALL gadget(t$,a):IF a=0 THEN RETURN
CLS:RETURN:REM----------------- 
halt:
a=2:t$="Sind Sie sicher ?":CALL gadget (t$,a):IF a=0 THEN BEEP:RETURN
WINDOW CLOSE 4:SCREEN CLOSE 2:LIBRARY CLOSE:END:REM -----------------
pref: a=2:t$="Das Bild wird gelöscht."+CHR$(13)+"Sind Sie sicher?"
CALL gadget (t$,a):IF a=0 THEN BEEP:RETURN
pref1:start=1:CLS:INPUT "Tiefe";tiefe
IF tiefe<1 OR tiefe>5 THEN BEEP:GOTO pref1  
pref2:a=1:t$="Interlace ein?":CALL gadget(t$,a) 
b=a:FOR t=1 TO 50:a=MOUSE(0):a=MOUSE(1):a=MOUSE(2):NEXT:a=MOUSE(1):a=MOUSE(2)
a=1:t$="Volle Breite?":CALL gadget(t$,a)
FOR t=1 TO 50:c=MOUSE(0):c=MOUSE(1):c=MOUSE(2):NEXT:c=MOUSE(1):c=MOUSE(2)
mode=0:IF b=1 THEN mode=2
mode=mode+a+1
IF (mode=2 AND tiefe>3) OR (mode=3 AND tiefe>3) OR (mode=4 AND tiefe>1) THEN
GOTO pref2
END IF
bride=320:IF a=1 THEN bride=640
high=256:IF b=1 THEN high=512
IF bride=640 AND high=256 THEN kreisf=.44
IF bride=640 AND high=512 THEN kreisf=.88
IF bride=320 AND high=256 THEN kreisf=.88
IF bride=320 AND high=512 THEN kreisf=1.6
WINDOW CLOSE 3:SCREEN CLOSE 2:SCREEN 2,bride,high,tiefe,mode
WINDOW 3,"Rudi-Paint",(0,0)-(bride/2+bride/4,high/4+high/2),17:RETURN
info:WINDOW 4,"Info",(100,100)-(208,150),0,2:REM ------------------
PRINT:PRINT" Rudi Paint!":PRINT"Public Domain":PRINT"Programmed by"
PRINT"Felix Wente":PRINT" Press Space"
WHILE INKEY$<>" ":WEND:WINDOW CLOSE 4:WINDOW OUTPUT 3:RETURN
punkt:REM -------------------------------------
farbe=1:IF x<>0 THEN
FOR t=1 TO 1000:NEXT:s=MOUSE(0)
MENU 2,jumper,1:MENU 2,1,2:jumper=1
RETURN
END IF
PSET(MOUSE(1),MOUSE(2)),farbe
WHILE MOUSE(0)=-1
a=MOUSE(1):b=MOUSE(2)
PSET (a,b),farbe
WEND:RETURN
linie:farbe=1:REM --------------------------------
IF x<>0 THEN
FOR t=1 TO 1000:NEXT:s=MOUSE(0)
MENU 2,jumper,1:MENU 2,2,2:jumper=2
RETURN
END IF
a=MOUSE(1):b=MOUSE(2)
PSET(a,b),farbe
WHILE MOUSE(0)=-1:
c=MOUSE(1):d=MOUSE(2)
GOSUB com:LINE(a,b)-(c,d),1:LINE(a,b)-(c,d),1:GOSUB norm:WEND
c=MOUSE(1):d=MOUSE(2):FOR t=0 TO pinsel-1
LINE (a+t,b)-(c+t,d),farbe
NEXT
FOR t=1 TO 1000:NEXT:s=MOUSE(0)
RETURN
rec:farbe=1:REM --------------------------------
IF x<>0 THEN
FOR t=1 TO 1000:NEXT:s=MOUSE(0) 
MENU 2,jumper,1:MENU 2,4,2:jumper=4
RETURN
END IF
a=MOUSE(1):b=MOUSE(2)
PSET(a,b),farbe
WHILE MOUSE(0)=-1:
c=MOUSE(1):d=MOUSE(2)
GOSUB com:LINE(a,b)-(c,d),1,b:LINE(a,b)-(c,d),1,b:GOSUB norm:WEND
c=MOUSE(1):d=MOUSE(2):FOR t=0 TO pinsel-1
LINE (a+t,b+t)-(c+t,d+t),farbe,b
NEXT
FOR t=1 TO 1000:NEXT:s=MOUSE(0)
RETURN
kreis:farbe=1:REM --------------------------------
IF x<>0 THEN
FOR t=1 TO 1000:NEXT:s=MOUSE(0)
MENU 2,jumper,1:MENU 2,3,2:jumper=3
RETURN
END IF
a=MOUSE(1):b=MOUSE(2)
PSET(a,b),farbe
WHILE MOUSE(0)=-1
c=MOUSE(1):d=MOUSE(2)
GOSUB com:CIRCLE (a,b),SQR(ABS(a-c)^2+ABS(b-d)^2),1,,,kreisf
CIRCLE (a,b),SQR(ABS(a-c)^2+ABS(b-d)^2),1,,,kreisf:GOSUB norm:
WEND
c=MOUSE(1):d=MOUSE(2):FOR t=0 TO pinsel-1 STEP .25
CIRCLE (a,b),SQR(ABS(a-c)^2+ABS(b-d)^2)+t,farbe,,,kreisf
NEXT
FOR t=1 TO 1000:NEXT:s=MOUSE(0)
RETURN
fill:REM -------------------------------------
farbe=1:IF x<>0 THEN
FOR t=1 TO 1000:NEXT:s=MOUSE(0)
MENU 2,jumper,1:MENU 2,5,2:jumper=5
RETURN
END IF
PAINT(MOUSE(1),MOUSE(2)),farbe,1:
FOR t=1 TO 1000:NEXT:s=MOUSE(0):RETURN    
normal:pinsel=1:MENU 3,1,2:MENU 3,2,1:RETURN:REM ---------
fett:pinsel=3:MENU 3,2,2:MENU 3,1,1:RETURN:REM  --------------
cut:
FOR t=1 TO 1000:NEXT:s=MOUSE(0)    
WHILE MOUSE(0)=0:WEND
a=MOUSE(1):b=MOUSE(2)
WHILE MOUSE(0)=-1
c=MOUSE(1):d=MOUSE(2)
GOSUB com:LINE (a,b)-(c,d),1,b:LINE (a,b)-(c,d),1,b:GOSUB norm
WEND
c=MOUSE(1):d=MOUSE(2)
LINE (a,b)-(c,d),0,bf:FOR t=1 TO 1000:NEXT:s=MOUSE(0):RETURN    
move:REM -------------------------------------------
FOR t=1 TO 1000:NEXT:s=MOUSE(0)    
WHILE MOUSE(0)=0:WEND
a=MOUSE(1):b=MOUSE(2)
WHILE MOUSE(0)=-1
c=MOUSE(1):d=MOUSE(2)
GOSUB com:LINE (a,b)-(c,d),1,b:LINE (a,b)-(c,d),1,b:GOSUB norm
WEND
c=MOUSE(1):d=MOUSE(2)
e=INT(ABS(d-b+1)*(ABS(c-a)+16)*tiefe/16)+30
DIM p%(e)
GET (a,b)-(c,d),p%
FOR t=1 TO 1000:NEXT:s=MOUSE(0)
moveloop:
WHILE MOUSE(0)=0
a=MOUSE(1):b=MOUSE(2)
GOSUB com:PUT (a,b),p%:PUT (a,b),p%:GOSUB norm:
WEND
PUT (MOUSE(1),MOUSE(2)),p%,OR
FOR t=1 TO 800:NEXT:s=MOUSE(0)
IF MOUSE(0)=0 THEN moveloop
FOR t=1 TO 1000:NEXT:s=MOUSE(0):ERASE p%:RETURN
text:
FOR t=1 TO 1000:NEXT:s=MOUSE(0)
WHILE MOUSE(0)=0:WEND
x=INT(MOUSE(1)/8):y=INT(MOUSE(2)/8)
t$=""
a=x:b=y
GOSUB com:
tloop1:
c$=INKEY$:IF c$="" THEN LOCATE b,a:PRINT"_":LOCATE b,a:PRINT"_":GOTO tloop1
IF c$=CHR$(13) THEN tloop
IF c$=CHR$(8) THEN 
a=a-1:LOCATE b,a:PRINT b$:LOCATE b,a
IF a=1 THEN BEEP:GOTO tloop1
GOTO tloop1
END IF
t$=t$+c$
LOCATE b,a:a=a+1:IF a>=75 THEN BEEP:GOTO tloop1
PRINT c$;
b$=c$
GOTO tloop1
tloop:
RETURN





















 
