 CLS
 DIM a(60)
 SCREEN 1,640,256,4,2
 WINDOW 3,,(0,0)-(631,241),16,1
 PALETTE 0,.3,0,.8
 PALETTE 1,.6,.6,.6
 PALETTE 2,1,1,1
 PALETTE 3,.3,.3,.3
 PALETTE 4,0,0,0
 PALETTE 5,.6,0,0
 PALETTE 6,0,.6,0
 PALETTE 7,0,0,.6
 PALETTE 8,.6,0,.6
 PALETTE 9,.6,.6,0
 PALETTE 10,.8,0,.3
 PALETTE 11,.54,.3,.9
anfang:
 FOR t=1 TO 60:a(t)=0:NEXT t
 FOR t=1 TO 5
 FOR u=1 TO 5
 b(t,u)=0
 NEXT u
 NEXT t
 z=0:s=0:flag2=0:flag=0:flag1=0:k=0:v=MOUSE(0)
 x=0:y=0
 CLS
 f=11
 FOR t=0 TO 14
 x=t*41
 GOSUB loeschfeld1
 NEXT t
 y=21
 FOR t=0 TO 9
 x=t*41
 GOSUB loeschfeld1
 NEXT t
 y=0
 FOR t=0 TO 4
 x=t*41:f=t+5
 GOSUB feld
 GOSUB dquadrat
 NEXT t
 FOR t=0 TO 4
 x=5*41+t*41:f=t+5
 GOSUB feld
 GOSUB quadrat
 NEXT t
 FOR t=0 TO 4
 x=10*41+t*41:f=t+5
 GOSUB feld
 GOSUB kreis
 NEXT t
 y=21
 FOR t=0 TO 4
 x=t*41:f=t+5
 GOSUB feld
 GOSUB kreuz
 NEXT t
 FOR t=0 TO 4
 x=5*41+t*41:f=t+5
 GOSUB feld
 GOSUB dreieck
 NEXT t:f=10
 FOR u= 4 TO 8
 FOR t= 5 TO 9
 x=t*41:y=u*21
 GOSUB loeschfeld1
 NEXT t:NEXT u
 x=0:y=4*21:GOSUB feld:LOCATE 12,9:PRINT "Stein setzen!"
 x=0:y=5*21:GOSUB feld:LOCATE 15,9:PRINT "Stein löschen!"
 x=0:y=7*21:GOSUB feld:LOCATE 20,9:PRINT "Über Algovario"
 x=0:y=8*21:GOSUB feld:LOCATE 23,9:PRINT "ENDE!"
 x=0:y=9*21:GOSUB feld:LOCATE 26,9:PRINT "Neustart"
 x=5*41-1:y=3*21+7:q=5:GOSUB textfenster
 LOCATE 13,55:PRINT "Zeit:"
 x=11*41-21:y=4*21+10:q=3:GOSUB textfenster
 a$=" Willkommen zu Algovario!"
 
 
 REM ******** game-begin **************
abfrage:
 LOCATE 10,27:PRINT a$
 IF k=25 AND flag2=0 THEN testen

abfrage1:
 IF flag1=1 THEN GOSUB zeit
 IF MOUSE (0)=0 THEN abfrage1
 z=INT(MOUSE(2)/21):s=INT(MOUSE(1)/41)
 IF z=4 AND s=0 AND flag1=0 THEN flag1=1:zt=TIMER
 IF z=4 AND s=0 THEN a$="      Stein wählen!      ":flag=1:GOTO abfrage
 IF z=5 AND s=0 THEN a$="      Stein löschen!     ":flag=2:GOTO abfrage
 IF z=7 AND s=0 THEN GOTO ueberfen
 IF z=8 AND s=0 THEN SYSTEM
 IF z=9 AND s=0 THEN anfang
 IF flag=1 THEN steinwaehlen
 IF flag=2 THEN steinloeschen
 IF flag=3 THEN steinsetzen
 GOTO abfrage
 
ueberfen:
 dzeit=zeit:v=MOUSE(0)
 WINDOW 4,"Algovario",(0,0)-(631,241),0,1
 WINDOW OUTPUT 4
 FOR t=0 TO 14:x=t*41:y=0:f=INT(11*RND(2)+5)
 GOSUB quadrat
 NEXT t
 PRINT 
 PRINT 
 PRINT 
 PRINT 
 PRINT "                                Algovario V1.0"
 PRINT "                                --------------"
 PRINT 
 PRINT " Ein Spiel von Steffen Clemenz."
 PRINT "                          C1993"
 PRINT 
 PRINT 
 PRINT " Sinn des Spieles:"
 PRINT " -----------------"
 PRINT " Der Sinn des Spieles besteht darin, die 25 kleinen Quadrate so auf "
 PRINT " der Spielfläche zu ordnen, daß jede der fünf Farben und Formen in  "
 PRINT " den waagerechten und senkrechten Reihen sowie den Diagonalen "
 PRINT " einmal erscheint."
 PRINT
 PRINT "                             *** Ich wünsche ihnen viel Spaß! *** "
 PRINT 
 PRINT 
 PRINT 
 PRINT 
 PRINT 
 PRINT "                              Zurück zum Spiel"
 FOR t=0 TO 14:x=t*41:y=210:f=INT(11*RND(2)+5)
 GOSUB quadrat
 NEXT t
 x=7*41:y=8*21:GOSUB feld
a:   
 IF MOUSE(0)=0 THEN a
 z=INT(MOUSE(2)/21):s=INT(MOUSE(1)/41)
 IF z=8 AND s=7 THEN a1
 GOTO a
a1:
 WINDOW CLOSE 4
 v=MOUSE(0)
 zt=TIMER
 GOTO abfrage
 
steinwaehlen:
 v=MOUSE(0)
 IF z>1 THEN abfrage1
 IF z=1 AND s>9 THEN abfrage1
 IF z=0 THEN stein=(INT(s/5)+1)*10
 IF z=1 THEN stein=(INT(s/5)+4)*10
 IF stein>59 THEN abfrage1
 f=(s-INT(s/5)*5):stein=stein+f
 IF a(stein)=1 THEN abfrage1
 flag=3:z1=z:s1=s:a$="      Stein setzen!      "
 v=MOUSE(0)
 GOTO abfrage

steinsetzen:
 v=MOUSE(0)
 IF z>3 AND z<9 THEN r1
 GOTO abfrage1
r1:
 IF s>4 AND s<10 THEN r2
 GOTO abfrage1
r2:
 d=s-4:d1=z-3:IF b(d,d1)<>0 THEN abfrage1
 b(d,d1)=stein:a(stein)=1:k=k+1
 x=s*41:y=z*21:j=INT(stein/10):f=(stein-j*10)+5
 GOSUB feld
 ON j GOSUB dquadrat,quadrat,kreis,kreuz,dreieck
 x=s1*41:y=z1*21
 f=11:GOSUB loeschfeld1
 flag=1:a$="      Stein wählen!      "
 v=MOUSE(0)
 GOTO abfrage

steinloeschen:
 IF z>3 AND z<9 THEN r3
 GOTO abfrage1
r3:
 IF s>4 AND s<10 THEN r4
 GOTO abfrage1
r4:
 d=s-4:d1=z-3:IF b(d,d1)=0 THEN abfrage1
 stein=b(d,d1):b(d,d1)=0:a(stein)=0:k=k-1
 x=s*41:y=z*21:f=10:GOSUB loeschfeld1
 j=INT(stein/10):f=(stein-j*10)
 IF j<4 THEN x=(j-1)*5*41+f*41:y=0
 IF j>3 THEN x=(j-4)*5*41+f*41:y=21
 f=f+5:GOSUB feld
 ON j GOSUB dquadrat,quadrat,kreis,kreuz,dreieck
 flag=1:a$="      Stein wählen!      "
 v=MOUSE(0):flag2=0
 GOTO abfrage
 
testen:
 a$="   Prüfe auf Fehler...   "
 LOCATE 10,27:PRINT a$
 FOR n= 1 TO 5
 FOR u= 1 TO 4
 stein=b(n,u):j=INT(stein/10):f=(stein-j*10)
 stein2=b(u,n):j2=INT(stein2/10):f2=(stein2-j*10)
 FOR t= u+1 TO 5
 stein1=b(n,t)
 j1=INT(stein1/10):f1=(stein1-j*10)
 stein3=b(t,n)
 j3=INT(stein3/10):f3=(stein3-j*10)
 IF j=j1 THEN fehler
 IF j2=j3 THEN fehler
 IF f=f1 THEN fehler
 IF f2=f3 THEN fehler
 NEXT t
 NEXT u
 NEXT n
 FOR t=1 TO 2000:NEXT t
 a$="Ok. Das Spiel ist gelöst!"
 LOCATE 10,27:PRINT a$
ast:
 v=MOUSE(0)
 IF MOUSE(0)=0 THEN ast
 z=INT(MOUSE(2)/21):s=INT(MOUSE(1)/41)
 IF z=9 AND s=0 THEN anfang
 GOTO ast

fehler:
 a$="       Fehler !!!!       " 
 LOCATE 10,27:PRINT a$
 flag2=1:GOTO abfrage
 
zeit:
 zeit=INT(TIMER-zt)+dzeit
 LOCATE 13,60:PRINT USING "######";zeit
 RETURN
auswahl:
textfenster:
 LINE (x,y)-(x+q*41,y+10),1,b
 RETURN 
loeschfeld1:
 LINE (x,y)-(x+41,y+21),f,bf
 LINE (x,y)-(x+41,y+21),4,b
 RETURN 
loeschfeld2:
 LINE (x+1,y+1)-(x+39,y+19),10,bf
 RETURN
feld:
 LINE (x+1,y+1)-(x+39,y+20),1,bf
 LINE -(x+39,y+1),3
 LINE -(x+1,y+1),2
 LINE -(x+1,y+20),2
 LINE -(x+39,y+20),3
 RETURN
dquadrat:
 LINE (x+20,y+2)-(x+38,y+10),f
 LINE -(x+20,y+18),f
 LINE -(x+2,y+10),f
 LINE -(x+20,y+2),f
 PAINT (x+20,y+10),f
 LINE (x+20,y+2)-(x+38,y+10),4
 LINE -(x+20,y+18),4
 LINE -(x+2,y+10),4
 LINE -(x+20,y+2),4
 RETURN
quadrat:
 LINE (x+4,y+4)-(x+36,y+16),f,bf
 LINE (x+4,y+4)-(x+36,y+16),4,b
 RETURN
kreis:
 CIRCLE (x+20,y+10),15,f
 PAINT (x+20,y+10),f
 CIRCLE (x+20,y+10),15,4
 RETURN
kreuz:
 LINE (x+17,y+2)-(x+23,y+2),f
 LINE -(x+23,y+8),f
 LINE -(x+38,y+8),f
 LINE -(x+38,y+12),f
 LINE -(x+23,y+12),f
 LINE -(x+23,y+18),f
 LINE -(x+17,y+18),f
 LINE -(x+17,y+12),f
 LINE -(x+2,y+12),f
 LINE -(x+2,y+8),f
 LINE -(x+17,y+8),f
 LINE -(x+17,y+2),f
 PAINT (x+20,y+10),f
 LINE (x+17,y+2)-(x+23,y+2),4
 LINE -(x+23,y+8),4
 LINE -(x+38,y+8),4
 LINE -(x+38,y+12),4
 LINE -(x+23,y+12),4
 LINE -(x+23,y+18),4
 LINE -(x+17,y+18),4
 LINE -(x+17,y+12),4
 LINE -(x+2,y+12),4
 LINE -(x+2,y+8),4
 LINE -(x+17,y+8),4
 LINE -(x+17,y+2),4
 RETURN 
dreieck:
 LINE (x+20,y+2)-(x+36,y+18),f
 LINE -(x+4,y+18),f
 LINE -(x+20,y+2),f
 PAINT (x+20,y+10),f
 LINE (x+20,y+2)-(x+36,y+18),4
 LINE -(x+4,y+18),4
 LINE -(x+20,y+2),4
 RETURN   
 
 
