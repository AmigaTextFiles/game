 CLS
 SCREEN 1,640,256,4,2
 WINDOW 3,"Mini-Logik V1.0",(0,0)-(631,241),16,1
 PALETTE 0,.3,0,.8
 PALETTE 1,1,1,1
 PALETTE 2,.6,.6,.6
 PALETTE 3,.3,.3,.3
 PALETTE 4,0,0,0
 PALETTE 5,.6,0,0
 PALETTE 6,0,.6,0
 PALETTE 7,0,0,.6
 PALETTE 8,.6,0,.6
 PALETTE 9,.6,.6,0
 PALETTE 10,0,.6,.6
 PALETTE 11,.6,.3,.4
 PALETTE 12,.4,.2,.2
 PALETTE 13,.5,.5,.5
anfang:
 CLS
 GOSUB spielfeld
 x=100:y=100
 r=5:f=4
 FOR t= 6 TO 1 STEP -1
 LOCATE 27-t*3,30:PRINT t
 NEXT t
 FOR u= 0 TO 5
 y=67+u*24
 FOR t= 1 TO 4
 x=252+t*22
 GOSUB kreis
 NEXT t
 NEXT u
 f=2
 FOR u=0 TO 5
 y=65+u*24
 y1=72+u*24
 FOR t=1 TO 2
 x=180+t*22
 GOSUB kreis
 NEXT t
 FOR t=1 TO 2
 x=180+t*22:y=y1
 GOSUB kreis
 NEXT t
 NEXT u
 r=6:GOSUB feld
 FOR t= 0 TO 6
 y=65+t*15:x=400:f=t+5
 GOSUB kreis
 NEXT t
 x=0:y=3*21:f=13:GOSUB feld1
 LOCATE 10,7:PRINT "OK."
 x=0:y=4*21:f=2:GOSUB feld1
 LOCATE 12,7:PRINT "Stein löschen!
 x=41:y=21:f=2:GOSUB feld1
 LOCATE 2,6:PRINT "Start"
 x=3*41:y=21:GOSUB feld1
 LOCATE 2,15:PRINT "Neustart"
 x=5*41:y=21:GOSUB feld1
 LOCATE 2,26:PRINT "über..."
 LOCATE 10,58:PRINT "Status:"
 LOCATE 16,58:PRINT "Zeit:"
 flag=0:reihe=5
 REM ***** Programm-Beginn *******
abfrage1:
 LOCATE 11,58:PRINT a$
abfrage:
 v=MOUSE(0)
 IF flag1=1 THEN GOSUB zeit
 IF MOUSE(0)=0 THEN abfrage
 y=MOUSE(2):IF y<43 THEN ende
 x=MOUSE(1):IF x<50 THEN loeschen
 IF flag=1 THEN auswahl
 IF flag=2 THEN setzen
 IF flag=3 THEN loeschen1
 GOTO abfrage
 
startfrage:
 n=21:m=41:GOSUB position
 IF z=1 AND s=1 THEN start
 GOTO abfrage
start:
 a$="Stein wählen!     "
 RANDOMIZE TIMER
 zt=TIMER:flag1=1:flag=1
 REM farbwahl
 FOR t=1 TO 4
 a(t)=INT(7*RND(2)+1)
 NEXT t
 v=MOUSE(0)
 GOTO abfrage1
 
auswahl:
 z=INT((MOUSE(2))/15)
 stein=z-3
 IF stein>7 OR stein<1 THEN abfrage
 a$="Stein setzen!     "
 flag=2:v=MOUSE(0)
 GOTO abfrage1
 
setzen:
 IF posstone=4 THEN abfrage
 s=INT(MOUSE(1)/24)
 nummer=s-10
 IF nummer<1 OR nummer>4 THEN abfrage
 IF b(nummer)<>0 THEN abfrage
 b(nummer)=stein
 x=252+nummer*22:y=67+reihe*24:f=stein+4
 r=6:GOSUB kreis
 posstone=posstone+1:flag=1
 IF posstone=4 THEN f=2:x=0:y=3*21:GOSUB feld1
 a$="Stein wählen!     ":v=MOUSE(0)
 GOTO abfrage1

ende:
 z=INT(MOUSE(2)/21):s=INT(MOUSE(1)/41)
 v=MOUSE(0)
 IF z=1 AND s=1 THEN startfrage
 IF z=1 AND s=3 THEN neustart 
 IF z=1 AND s=5 THEN ueber
 GOTO abfrage
  
neustart:
 z=0:s=0:v=MOUSE(0)
 FOR t=1 TO 4:b(t)=0:c(t)=0:NEXT t
 flag=0:flag1=0:a$=""
 posstone=0:v=MOUSE(0)
 GOTO anfang

loeschen:
 z=INT(MOUSE(2)/21):s=INT(MOUSE(1)/41)
 v=MOUSE(0)
 IF z=3 AND s=0 THEN ok
 IF z=4 AND s=0 THEN flag=3:a$="Stein löschen!"
 GOTO abfrage1
 
loeschen1:
 z=INT(MOUSE(2)/21):s=INT(MOUSE(1)/41)
 v=MOUSE(0)
 IF z=4 AND s=0 THEN GOTO abfrage
 s=INT(MOUSE(1)/24)
 nummer=s-10
 IF nummer<1 OR nummer>4 THEN a$="Stein wählen!   ":flag=1:GOTO abfrage1
 IF b(nummer)=0 THEN a$="Stein wählen!   ":flag=1:GOTO abfrage1
 y=67+reihe*24:x=252+nummer*22:GOSUB kreis1
 flag=1:b(nummer)=0:a$="Stein wählen!    "
 posstone=posstone-1:v=MOUSE(0)
 GOTO abfrage1
 
ok:
 IF posstone<>4 THEN abfrage
 reihe=reihe-1:d=1:dk=0
 FOR t=1 TO 4
 d(t)=a(t)
 NEXT t
 FOR t= 1 TO 4
 IF b(t)=0 THEN weiter1
 IF a(t)=b(t) THEN pz=pz+5:d(t)=0:b(t)=0:c(d)=4:d=d+1
weiter1:
 NEXT t
 FOR t= 1 TO 4
 p=a(t):IF d(t)=0 THEN raus 
 FOR u= 1 TO 4 
 IF b(u)=0 THEN weiter
 IF b(u)=p AND u<>t THEN pz=pz+2:b(u)=0:c(d)=1:d=d+1:GOTO raus                                 
weiter:
 NEXT u
raus:
 NEXT t
 y=65+(reihe+1)*24
 FOR t=1 TO 2
 IF c(t)=0 THEN w
 f=c(t):x=180+t*22
 GOSUB kreis
w:
 NEXT t
 y=72+(reihe+1)*24
 FOR t=3 TO 4
 IF c(t)=0 THEN w1
 f=c(t):x=180+(t-2)*22
 GOSUB kreis
w1:
 NEXT t
 zu=0
 FOR t= 1 TO 4
 IF c(t)=4 THEN zu=zu+1
 NEXT t
 f=3:x=0:y=3*21:GOSUB feld1
 IF zu=4 THEN kl=1:GOTO vorbei
 IF reihe=-1 THEN vorbei 
 z=0:s=1:v=MOUSE(0):posstone=0
 a$="Stein wählen!     "
 FOR t=1 TO 4:b(t)=0:c(t)=0:NEXT t
 GOTO abfrage1

vorbei:
 FOR t=1 TO 4:
 y=48:x=252+t*22:f=a(t)+4:r=6
 GOSUB kreis
 NEXT t
 IF kl=0 THEN punkte=0:GOTO again
 punkte=pz*((reihe+2)*2)+800-zeit
again:
 LOCATE 21,58:PRINT "Punkte:";punkte
 v=MOUSE(0):pz=0
a1:
 IF MOUSE(0)=0 THEN a1
 z=INT(MOUSE(2)/21):s=INT(MOUSE(1)/41)
 IF z=1 AND s=3 THEN neustart
 v=MOUSE(0)
 GOTO a1
 
zeit:
 zeit=INT(TIMER-zt)+dzeit
 LOCATE 16,65:PRINT  USING"######";zeit
 RETURN
position:
 z=INT(MOUSE(2)/n):s=INT(MOUSE(1)/m)
 RETURN
feld:
 LINE (390,60)-(410,165),12,bf
 RETURN
feld1:
 LINE (x,y)-(x+40,y+20),f,bf
 LINE (x,y)-(x+40,y),1
 LINE -(x+40,y+20),3
 LINE -(x,y+20),3
 LINE -(x,y),1
 RETURN
kreis:
 CIRCLE (x,y),r,f
 PAINT (x,y),f
 CIRCLE (x,y),r,4
 RETURN
kreis1:
 CIRCLE (x,y),6,2
 CIRCLE (x,y),5,4
 PAINT (x,y),4
 RETURN
spielfeld:
 LINE (250,40)-(360,55),2,bf
 LINE (250,40)-(250,55),1
 LINE (249,39)-(249,54),1
 LINE (250,40)-(360,40),1
 LINE (249,39)-(361,39),1
 LINE (180,55)-(360,205),2,bf
 LINE (180,55)-(180,205),1
 LINE (179,54)-(179,206),1
 LINE (180,55)-(250,55),1
 LINE (179,54)-(249,54),1
 LINE (360,40)-(360,205),3
 LINE (361,39)-(361,206),3
 LINE (180,205)-(360,205),3
 LINE (179,206)-(361,206),3
 FOR t=0 TO 4
 y=78+t*24
 LINE (181,y)-(359,y),1
 LINE (181,y+4)-(359,y+4),3
 NEXT t
 RETURN 

ueber:
 dzeit=zeit
 WINDOW 4,"Mini-Logik V1.0",(0,0)-(631,241),0,1
 v=MOUSE(0)
 PRINT "                            Mini-Logik V1.0"
 PRINT 
 PRINT 
 PRINT " Ein Spiel von Steffen Clemenz"
 PRINT "                             C XX.01.1993"
 PRINT 
 PRINT 
 PRINT " Das Spiel:"
 PRINT " Bei dem Spiel geht es darum,die richtige Kombination der Spielsteine"
 PRINT " heraus zufinden. Die einzige Hilfe sind die schwarzen und weißen Steine"
 PRINT " ,die der Computer setzt,um dem Spieler mitzuteilen,ob irgendein Stein"
 PRINT " richtig oder nur an einer falschen Stelle sitzt."
 PRINT " Beendet ist das Spiel,wenn die richtige Kombination herausgefunden ist"
 PRINT " oder man alle 6 Reihen voll hat."
 PRINT 
 PRINT " Die Funktionsweise:"
 PRINT " Starten : Start-Gadget anklicken"
 PRINT "  Status : Anzeige der aktuellen Funktion"
 PRINT " Auswahl : rechts befindet sich ein Feld mit 7 Steinen,aus diesem wählt"
 PRINT "           man einen Stein aus"
 PRINT "  Setzen : rechts neben den Zahlen befindet sich eine vierer Reihe,dort"
 PRINT "           klickt man ein Feld an,um den gewählten Stein abzulegen."
 PRINT "      Ok : anklicken,wenn die vierer Reihe voll ist und man der Meinung"
 PRINT "           ist,daß man die Steine richtig angeordnet hat"
 PRINT " Loeschen: anklicken und entsprechenden Stein löschen!"
 PRINT 
 PRINT 
 PRINT "                           Klick zum schließen!"
a:
 IF MOUSE(0)=0 THEN a
 v=MOUSE(0):WINDOW CLOSE 4
 zt=TIMER
 GOTO abfrage
