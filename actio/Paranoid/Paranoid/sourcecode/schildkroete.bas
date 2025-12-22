'Der Tanz der Schildkroete Programm:Felix Wente
CLEAR 20000,20000
INPUT "Durchgangsnummer";endebene
INPUT "Änderungswinkel";winkel
INPUT "Anzahl der Elemente eines Schrittes";schrittzahl
PRINT "Möglich ist:vor,links,rechts"
DIM elemente (schrittzahl),n(endebene+1)
FOR t=0 TO schrittzahl-1
PRINT "Element Nummer:";t+1:INPUT a$ 
IF a$="links" THEN elemente(t)=90
IF a$="rechts" THEN elemente(t)=-90
IF a$="vor" THEN vorschritte=vorschritte+1
NEXT t
'schrittlaengenberechnung
schrittlaenge=SQR(2*(312/INT((360/winkel)/2+.5))^2)/vorschritte
'screen mit Auflösung von 640x512 Punkten!
SCREEN 1,640,512,1,4:WINDOW 2,"",,0,1
'setup
xstart=320-schrittlaenge:ystart=350:CALL setze (xstart,ystart)
FOR laufen=1 TO 360/winkel
GOSUB zeichnen
drehe (winkel)
NEXT
END
zeichnen:
ebene=1:laenge=schrittlaenge
rekursion:
n(ebene)=0
schleife:
drehe elemente(n(ebene))
IF ebene=endebene THEN
gehe laenge
ELSE 
ebene=ebene+1:laenge=laenge/vorschritte
GOSUB rekursion
ebene=ebene-1:laenge=laenge*vorschritte  
END IF
drehe (elemente(n(ebene))*-1)
IF n(ebene)<schrittzahl-1 THEN n(ebene)=n(ebene)+1:GOTO schleife
RETURN
'Turtlegrafik,programmiert in Anlehnung an Turtlegrafik in AMIGA 10/87
SUB drehe(x) STATIC:SHARED twinkel:twinkel=twinkel-x:END SUB
SUB setze(x,y) STATIC:SHARED xturtle,yturtle:xturtle=x:yturtle=y:END SUB
SUB swinkel(x) STATIC:SHARED twinkel:twinkel=x:END SUB
SUB gehe(schritte) STATIC
SHARED xturtle,yturtle,twinkel
p=.01745329#:neuy=(SIN(twinkel*p))*schritte
neux=(COS(twinkel*p))*schritte
LINE (xturtle,yturtle)-(xturtle+neux,yturtle+neuy)
xturtle=xturtle+neux:yturtle=yturtle+neuy
END SUB
 
