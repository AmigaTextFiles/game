 SCREEN 1,640,256,3,2
 WINDOW 3,"Steckhalma V1.0",(0,0)-(631,241),16,1
 PALETTE 0,.3,0,.8
 PALETTE 1,1,1,1
 PALETTE 2,.6,.6,.6
 PALETTE 3,0,0,0
 PALETTE 4,.8,.8,0
 PALETTE 5,.3,.3,.3
 PALETTE 6,1,0,0
anfang:
 CLS:
 a$="2244422"
 FOR t=1 TO 2
 FOR u=1 TO 7
 a(t,u)=VAL(MID$(a$,u,1))
 a(t+5,u)=a(t,u)
 NEXT u
 NEXT t
 a$="4444444"
 FOR t=3 TO 5
 FOR u=1 TO 7
 a(t,u)=VAL(MID$(a$,u,1))
 NEXT u
 NEXT t
 a(4,4)=3
 GOSUB spielfeld
 FOR t=1 TO 7
 FOR u=1 TO 7
 x=148+u*40:y=36+t*20
 IF a(t,u)=2 THEN weiter
 f=a(t,u):GOSUB kreis
weiter:
 NEXT u
 NEXT t
 x=41:y=21:GOSUB feld
 LOCATE 2,6:PRINT "Start"
 x=13*41:y=21:GOSUB feld
 LOCATE 2,66:PRINT "Neustart!"
 x=41:y=10*21:GOSUB feld
 LOCATE 26,6:PRINT "Fertig"   
 x=13*41:y=10*21:GOSUB feld 
 LOCATE 26,67:PRINT "ueber..."
 LOCATE 4,25:PRINT "Status:"
 a$="":flag=0:flag1=0:flag2=0:ze=0:dzeit=0
 LOCATE 15,67:PRINT "Zeit:"
abfrage1:
 LOCATE 4,33:PRINT a$
 
abfrage:
 v=MOUSE(0) 
 IF flag2=1 THEN ze=ze+1
 IF ze=40 THEN blink
 IF flag1=1 THEN GOSUB zeit
 v=MOUSE(0)
 IF v=0 THEN abfrage
 s=INT((MOUSE(1))/41):z=INT((MOUSE(2))/21)
 IF s=1 AND z=1 AND flag=0 THEN startfrage 
 IF s=13 AND z=1 THEN anfang
 IF s=1 AND z=10 THEN auswertung
 IF s=13 AND z=10 THEN ueber
 IF flag=1 THEN auswahl
 IF flag=2 THEN setzen
 GOTO abfrage

auswertung:
 FOR t= 1 TO 7
 FOR u= 1 TO 7
 IF a(t,u)=4 THEN stein=stein+1
 NEXT u
 NEXT t
 punkte=((28-stein)*(800-zeit-dzeit))/100
 IF punkte<0 THEN punkte=0
 LOCATE 17,67:PRINT "Punkte";punkte;"   " 
b:
 IF MOUSE(0)=0 THEN b
 s=INT((MOUSE(1))/41):z=INT((MOUSE(2))/21)
 IF s=13 AND z=1 THEN anfang
 GOTO b

zeit:
 zeit=INT(TIMER-zt)+dzeit
 LOCATE 15,72:PRINT  USING"#####";zeit
 RETURN
 
startfrage:
 zt=TIMER:flag1=1:flag=1
 a$="Stein wählen!"
 GOTO abfrage1

auswahl:
 s=s-3:z=z-1:v=MOUSE(0)
 IF s<1 OR s>7 THEN bruch
 IF z<1 OR z>7 THEN bruch
 IF a(s,z)=2 THEN bruch
 IF a(s,z)=3 THEN bruch
auswahl1:
 CIRCLE (148+s*40,36+z*20),18,6
 flag=2:flag2=1:an=1:ze=0
 s1=s:z1=z:a$="Stein setzen!"
 v=MOUSE(0)
 GOTO abfrage1
bruch:
 GOTO abfrage
 
blink:
 ze=0
 IF an=1 THEN an=0:f=2:GOTO w
 IF an=0 THEN an=1:f=6
w:
 CIRCLE (148+s1*40,36+z1*20),18,f
 GOTO abfrage
 
setzen:
 s=s-3:z=z-1:v=MOUSE(0)
 IF s<1 OR s>7 THEN abfrage
 IF z<1 OR z>7 THEN abfrage
 IF a(s,z)=2 THEN abfrage
 IF a(s,z)=4 THEN bruch1
 d=(s1-s)/2:d1=(z1-z)/2 
 IF ABS(d)=1 AND d1=0 THEN k2
 IF d=0 AND ABS(d1)=1 THEN k2
 GOTO abfrage
k2:
 IF a(s1-d,z1-d1)=3 THEN abfrage
 a(s1,z1)=3:a(s1-d,z1-d1)=3
 a(s,z)=4
 x=148+s1*40:y=36+z1*20:f=3:GOSUB kreis
 x=148+(s1-d)*40:y=36+(z1-d1)*20:GOSUB kreis
 x=148+s*40:y=36+z*20:f=4:GOSUB kreis
 CIRCLE (148+s1*40,36+z1*20),18,2
 a$="Stein wählen!":flag=1:ze=0:flag2=0
 v=MOUSE(0)
 GOTO abfrage
bruch1:
 CIRCLE (148+s1*40,36+z1*20),18,2
 GOTO auswahl1
 
feld:
 LINE (x,y)-(x+40,y+20),2,bf
 LINE (x,y)-(x+40,y),1
 LINE -(x+40,y+20),5
 LINE -(x,y+20),5
 LINE -(x,y),1
 RETURN
kreis:
 CIRCLE (x,y),15,f
 PAINT (x,y),f
 CIRCLE (x,y),15,3
 RETURN
spielfeld:
 LINE (150,40)-(470,200),2,bf
 LINE (150,40)-(150,200),1
 LINE (149,39)-(149,201),1
 LINE (149,39)-(471,39),1
 LINE (150,40)-(470,40),1
 LINE (470,40)-(470,200),5
 LINE (471,39)-(471,201),5
 LINE (150,200)-(470,200),5
 LINE (149,201)-(471,201),5 
 RETURN
ueber:
 dzeit=zeit:v=MOUSE(0)
 WINDOW 4,"Steckhalma V1.0",(0,0)-(631,241),0,1
 PRINT "                                     Steckhalma V1.0"
 PRINT 
 PRINT 
 PRINT " Ein Spiel von Steffen Clemenz.
 PRINT "                       C xx.01.1993"
 PRINT 
 PRINT 
 PRINT 
 PRINT " Das Spiel:"
 PRINT " Sinn des Spiel ist es am Schluß so wenig wie möglich Figuren übrig zu"
 PRINT  " behalten. "
 PRINT 
 PRINT " Man wählt einen Stein aus und kann mit diesem über einen Stein in der "
 PRINT " waagerechten oder senkrechten auf ein freies Feld springen."
 PRINT " Ist man der Meinung keinen Sprung mehr machen zu können,dann klicke man"
 PRINT " auf das Feld `Fertig`."
 PRINT 
 PRINT 
 PRINT 
 PRINT "                                     Klick zum schließen"
a:
 IF MOUSE(0)=0 THEN a
 WINDOW CLOSE 4
 zt=TIMER:n=MOUSE(1):m=MOUSE(2)
 FOR t=1 TO 7:v=MOUSE(0):NEXT t
 GOTO abfrage
 
