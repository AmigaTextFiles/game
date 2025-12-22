@DATABASE Tabellen.inc
@NODE Tabellen

Tabellenteil
============

Alarmstufen
-----------
Die Flotten im Orbit können sich in diversen Alarmzuständen 
befinden:

Alarmstufe       Info
-------------------------------------------------------------------
A                Flotte greift nur an, wenn sie angegriffen wird
B                Flotte greift automatisch Kriegsschiffe an
C                Flotte greift automatisch jedes fremde Schiff an
D                Flotte greift automatisch feindliche PDs an

Ligaplaneten sind meistens in Stufe A, währenddessen 
Imperatorplaneten jeden Eindringlich sofort bekämpfen. 


Boden-Orbit-Ionenkanone (benötigt Raumschiffkatalog 3)
-----------------------
Festinstallierte Kanone zum Schutz des Planeten. Zum Bau wird 
keine Fabrik benötigt. 
Angriff:  1 schwere Ionenkanone: 5 (siehe Waffem der Deaktivierung)
Panzerung:   10
Kosten:      50 CR
lauf.Kosten: 1 CR/R
ES:          7
Abkürzung:   BI


Boden-Orbit-Laserkanone
-----------------------
Gleich wie die Ionenkanone, aber mit einer Laserkanone.
Angriff:     4
Panzerung:   10
Kosten:      40 CR
lauf.Kosten: 4 CR/R
ES:          7
Abkürzung:   BO


Planeten
--------
ES    Ertrag    Infos
--------------------------------------------------------------
1     250       Planet beherbergt kein intelligentes Leben
2-3   500-750   Kulturen, die sich auf einer niedrigen 
                Entwicklungsstufe stehen
4-6   1000-1500 normal entwickelte Kulturen, die allerdings
                die Raumfahrt noch nicht beherrschen,
                trotzdem können solche Völker gegen die
                Unterjochung teilweise rebellieren
7     1750      Kulturen, die die Raumfahrt beherrschen, ab 7
                ist auch das Bauen von diversen Raumschiffen
                möglich
8     2000      ab 8 kann man im allgemeinen alle Schiffe bauen

Anmerkung: Die Erträge beziehen sich auf Imperatoren. Für 
andere gilt:   
- Imperator:                       250CR pro ES
- Heilsbringer:                    250CR pro ES
- Eroberer:                        250CR pro ES
- Syndikate:                       200CR pro ES
- Mitglied in der Neuen Republik:  125CR pro ES


Raumschiffe
-----------
Name                Angriff          ES  Kosten  lauf.Kosten    H
                    I      Panzerung  I     I        I   Werftk.I
                    I      I   Abk.   I     I        I   I      I
-----------------------------------------------------------------
Raumjäger
-----------
A-Wing Starfighter  8(1)   5   AW     7     40       1    400   Y
B-Wing Starfighter  5(1)   12  BW     7     60       1    600   Y
X-Wing Starfighter  9(1)   5   XW1    7     70       1    800   Y
Y-Wing Starfighter  8(1)   7   YW1    7     40       1    450   Y
TIE Starfighter     5(1)   0   T      7     10       1    150   N
TIE/ln Starfighter  8(1)   0   TL     7     20       1    150   N
TIE Interceptor     9(1)   0   TI     7     50       1    550   N
  
Kampfschiffe
------------
Corellian Corvette  12(6)  10  CC     7    510       3   2080   Y 
Escort Frigate      6 (4)  16  EF     7    450       4   1800   Y
Victory Class Destr.4(40)  20  VCSD   7    500       5   2000   Y
Imp.Star Destroyer  11(60) 30  ICSD   8   3000       5   6000   Y
Mon Calamari 
 Star Cruiser       6(48)  20  MC    8  2000         5   4000   Y

Angriff: Angriffstärke der Hauptwaffe (Anzahl der Waffensysteme)
Panzerung: Stärke des Schutzschildes
Kosten: Preis (CR)
laufende Kosten (CR)
ES: Entwicklungstufe eines Planeten, ab welcher solche Schiffe gebaut werden können.
Werftkosten: Kosten der Werft (CR)

Alle Schiffe können 10LJ pro Spielrunde reisen.


Raumschiffkapazitäten
---------------------
Während des Ruamflugs können die Kampfschiffe mehrere Jäger 
mitnehmen:
-Corellian Corvette      : 12
-Escort Frigate          : 12
-MonCalamari Starcruiser : 72
-Victory Class Destroyer : 24
-Imperial Stardestroyer  : 84


Aufklärungsdroid
----------------
Dieser Droid ist einsetzbar um die militärische Stärke und ES 
eines einzelnen Planeten zu erfahren. Auf dem Planeten 
angekommen sendet er automatisch die Informationen. Verfügt 
der Planet über Abwehrwaffen, so wird der Droide vernichtet. 
Wenn der Spieler Glück hat kann der Roboter vorher noch die 
Infos absetzen. Er ist 20LJ pro Runde schnell, besitzt aber 
keine Panzerung. 
Kosten:         40CR
laufende Kosten: 2CR 
Weftkosten:    320CR

Es wird vorausgesetzt, daß man die Schiffe kennt, darum wurde 
hier auf eine nähere Beschreibung verzichtet. 


Werften
-------
Nicht jeder Spielercharakter verfügt über die Pläne von 
bestimmten Raumschifftypen. Wer welche Schiffe bauen kann:

Schiff  Werft  Erb.  Hbr.  Imp.  NeR.  OdM.  Syn.  TechLevel
------------------------------------------------------------
A9      TIY    -     -     x     -     -     -     3
AS      AS     -     -     x     -     -     -     3
AT      AT     -     -     x     -     -     -     2
AW      AW     -     -     -     x     -     -     2
BF      BF     x     x     -     -     x     x     1
BI      keine  x     x     x     x     x     x     1
BO      keine  x     x     x     x     x     x     1
BW      BW     x     -     -     x     x     -     1
CCC     CCC    x     x     x     -     -     x     1
CC      CCY    x     -     -     x     x     x     1
CG      CG     -     -     -     x     x     x     1
CS      CS     -     -     -     -     -     x     2
CT      CT     -     -     -     -     -     x     1      
DCC     DCC    x     x     x     x     x     x     1
DS1     keine  -     -     x     -     -     -     2
DS2     keine  -     -     x     -     -     -     2
DSPT    keine  x     x     x     x     x     x     2
EC      EC     x     x     x     -     -     x     2
EF      EFY    x     x     x     x     x     x     1
ES      ES     -     -     x     -     -     x     2
EW      EW     -     -     -     x     -     -     3
F       F      -     -     -     x     -     -     3
FS      FS     x     x     x     x     x     x     1
H       H      x     x     -     -     x     -     2
I7      I7     -     -     x     x     -     x     3
ICC     -     -     x     -     -     -     3
ICSD    ICSD   x     x     x     -     -     x     2
ICV     ICV    x     x     x     x     x     x     2
IPV     IPV    -     -     x     x     -     -     2
LCF     LCF    -     -     x     -     -     -     2
LMCS    LMCS   -     -     -     x     -     -     2
LS      LS     x     x     x     -     -     x     2
MCC     CCY    -     -     -     x     -     -     2
MCS     MCS    -     -     -     x     -     -     2
MEF     MCY    -     -     x     x     -     -     3
RAF     RAF    -     -     -     x     x     -     2
RCC     BCY    -     x     -     x     x     x     1
RZT     ZY     -     -     -     x     -     -     1
SAB     SAB    -     -     x     -     -     -     3
SAG     SAG    -     -     x     -     -     -     3
SB      SB     x     x     x     x     x     x     1
SC1SD   keine  -     -     x     -     -     -     2
SC2SD   keine  -     -     x     -     -     -     3
SCC     BCY    -     x     -     x     x     x     1
SG      SG     -     -     x     -     -     x     3
SLF     SLF    x     x     x     x     x     x     1
SS1     keine  x     x     x     x     x     x     2
SS2     keine  x     x     x     x     x     x     2
SS3     keine  x     x     x     x     x     x     2
SS4     keine  x     x     x     x     x     x     2
STT     STT    x     -     x     -     -     x     2
T       TY     x     x     x     -     x     x     1
TA      TA     -     -     x     -     -     -     3
TB      TBY    -     -     x     -     -     -     2
TD      TD     -     -     x     -     -     -     3
TE      TY     x     -     x     -     x     x     1
TF      TY     x     x     x     -     x     -     1
TG      TBY    -     -     x     -     -     -     1
TI      TIY    -     -     x     -     -     x     2
TL      TY     x     x     x     -     x     x     1
TR      TY     -     -     x     -     -     -     1
TV      TBY    -     -     x     -     -     -     2
TX      TY     x     x     x     -     x     x     1
TZ      TBY    -     -     x     -     -     -     1
VCSD    VCSD   x     x     x     x     x     x     1
WS      keine  x     x     x     x     x     x     1
XW1     XWY    -     -     -     x     -     -     2
XW2     XWY    -     -     -     x     -     -     2
YW1     YWY    x     x     -     x     x     x     1
YW1     YWY    x     x     -     x     x     x     1
Z       ZY     x     x     -     -     x     x     1
ZH      ZY     x     x     -     x     x     x     1

Schiff:Raumschifftyp
Werft : Werfttyp, in der das genannte Schiff gebaut werden kann
Erb.  : Eroberer
Hbr.  : Heilsbringer
Imp.  : Imperium
NeR.  : Neue Republik
Syn.  : Syndikate

Anmerkung: Rebellen und Söldner können zwar keine Planeten 
erobern, aber trotzdem Werften auf anderen Planeten bauen, 
vorausgesetzt der Herrscher über diese Welt hat nichts dagegen. 
Es gilt das Wissen des Herrschers. Pro Planet kann man nur 10 
Werften errichten. Dies mag wenig erscheinen, aber zu dem 
Betreiben einer Raumschiffabrik bedraf es schließlich auf 
Rohstoffe und Arbeiter. Nach Eroberung eines Planeten können 
natürlich alle vorhandenen Werften genutzt werden. Diese 
Übersicht gilt nur für den Bau.   


Tech-Level
----------
Im Gegenzusatz zur ES, welche die Entwicklung des einzelnen 
Planeten anzeigt, gilt der Tech-Level für den Spieler. Er weist 
auf seinen wissenschaftlichen Stand hin. Dies ist beim Bau 
von Raumschiffen notwendig.

Tech-Level   Bedeutung
1            Raumschiffe, die vor den 3Filmen eingeführt wurden,
             z.B. der TIE-Fighter oder B-Wing
2            Raumschiffe, die während den Filmen eingeführt wurden,
             z.B. der A-Wing oder der TIE-Interceptor
3            Raumschiffe, die nach den Filmen eingeführt wurden,
             z.B. der TIE-Defender oder der E-Wing


Wolkenstadt
-----------
Um einen Gasplaneten zu besiedeln oder kolonisieren ist es 
nötig, über der Oberfläche des Planeten eine Wolkenstadt zu 
errichten. 
Ansschaffungskosten: 1000CR
laufende Kosten:       40CR/R
Abkürzung:             WI


Spiel und Dokumentation:     Patrick Henz
Grafiken:                    Beate Richter
zusätzliche Raumschiffdaten: Ronny Krauß
Greetings to:                Jörg Weissinger

 
@ENDNODE


  



