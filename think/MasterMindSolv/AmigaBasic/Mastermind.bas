SCREEN 1,320,256,4,1
WINDOW 2,"",,0,1

PALETTE 0,.2,.2,.2
PALETTE 1,.6,.6,.6
PALETTE 2,0,0,0
PALETTE 3,1,1,1
PALETTE 4,1,0,0
PALETTE 5,1,1,0
PALETTE 6,0,1,0
PALETTE 7,0,1,1
PALETTE 8,0,0,1
PALETTE 9,1,0,1

DEFINT a-z
RANDOMIZE TIMER
DIM posib(1295,3)           'hier werden alllle möglichkeiten abgelegt
DIM code(3),steck(3)        'hier dir zu ratende kombi und das was gesteckt wurde
DIM free1(3),free2(3)       'das sind boolsche felder zur bewertung

anz=0                       'alle kombinationen ablegen (was fuer ein aufwand!)
FOR i=0 TO 5                '(kominationen im weiteren kombis genannt)
  FOR j=0 TO 5
    FOR k=0 TO 5
      FOR l=0 TO 5
        posib(anz,0)=i
        posib(anz,1)=j
        posib(anz,2)=k
        posib(anz,3)=l
        anz=anz+1
      NEXT
    NEXT
  NEXT
NEXT

n=INT(RND*anz)            'zu ratende kombi ausdenken (eine der 1296=anz möglichen)
FOR i=0 TO 3
  code(i)=posib(n,i)                                  'abspeichern
  LINE(i*20+10,10)-STEP(15,10),code(i)+4,bf           'hinmalen
  LINE(i*20+10,10)-STEP(15,10),1,b
NEXT

FOR j=1 TO 14                   'so oft darf geraten werden
  n=INT(RND*anz)                'eine der !noch! möglichen kombis wählen
  FOR i=0 TO 3
    steck(i)=posib(n,i)                                    'abspeichern
    LINE(i*20+10,j*15+20)-STEP(15,10),steck(i)+4,bf        'hinmalen
    LINE(i*20+10,j*15+20)-STEP(15,10),1,b
  NEXT
  
  b=0                           'bewertung initialisieren b=black, w=weiß
  w=0
  FOR i=0 TO 3
    IF code(i)=steck(i) THEN    'falls völlig korrekt
      b=b+1                     'blacker stift
      free1(i)=1                'felder sperren
      free2(i)=1
    ELSE
      free1(i)=0                'sonst felder freigeben
      free2(i)=0
    END IF
  NEXT
  FOR i=0 TO 3
    FOR k=0 TO 3
      IF free1(i)=0 AND free2(k)=0 THEN  'falls noch frei
        IF code(i)=steck(k) THEN         'und falls farbe richtig, pos falsch
          w=w+1                          'weißer stift
          free1(i)=1                     'felder sperren
          free2(k)=1
        END IF
      END IF
    NEXT
  NEXT  
  
  FOR i=1 TO b
    LINE(i*10+100,j*15+20)-STEP(5,10),2,bf    'blacke stifte malen
    LINE(i*10+100,j*15+20)-STEP(5,10),1,b
  NEXT
  FOR i=1+b TO w+b
    LINE(i*10+100,j*15+20)-STEP(5,10),3,bf    'weiße stifte malen
    LINE(i*10+100,j*15+20)-STEP(5,10),1,b
  NEXT
  IF b=4 THEN END                             'wenn alles richtig: ENDE
  
  z=0                                         'z ist die anzahl der später zu streichenden kombis
  LINE(10,240)-STEP(100,2),2,bf               'fuellanzeige vorbereiten
  FOR l=0 TO anz-1                            'alle kombis werden mit der eingabe verglichen und bewertet, bei gleicher bewertung bleiben sie im rennen ansonsten werden sie rausgeschmissen
    LINE(10,240)-STEP((l+1)*100\anz,2),3,bf   'fuellung anzeigen
    ll=l-z
    bb=0
    ww=0
    FOR i=0 TO 3
      IF steck(i)=posib(ll,i) THEN
        bb=bb+1                               'bewertung fuer black
        free1(i)=1
        free2(i)=1
      ELSE
        free1(i)=0
        free2(i)=0
      END IF
    NEXT
    IF b=bb THEN                              'und falls nötig noch fuer weiß
      FOR i=0 TO 3
        FOR k=0 TO 3
          IF free1(i)=0 AND free2(k)=0 THEN
            IF steck(i)=posib(ll,k) THEN
              ww=ww+1
              free1(i)=1
              free2(k)=1
            END IF
          END IF
        NEXT
      NEXT
      IF w<>ww THEN                      'wenn eine der beiden bewertungen
        z=z+1                            'nicht mit der obigen uebereinstimmt
        FOR i=0 TO 3                     'wird die kombi entfernt (mit der 
          posib(ll,i)=posib(anz-z,i)     'letzten noch gueltigen ueber-
        NEXT                             'schrieben)
      END IF
    ELSE
      z=z+1
      FOR i=0 TO 3
        posib(ll,i)=posib(anz-z,i)
      NEXT
    END IF
  NEXT
  anz=anz-z      'die anzahl der noch verbleibenden kombis wird aktualisiert
NEXT
