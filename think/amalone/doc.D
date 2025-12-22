Dokumentation von aMalone
=========================

Spielregel
----------
In einem Zug können 1, 2, oder 3 eigene Kugeln bewegt werden zu angrenzenden
Feldern des Spielbretts. Zwei oder drei zu bewegen Kugeln sollen neben
einander liegen auf einer geraden Linie. Die Kugeln können in 6 Richtungen
bewegt werden, aber nur innerhalb dem Spielbrett. Außerdem kann ein Zug
mit 2 oder 3 Kugeln einen oder zwei Kugeln des Gegners wegstoßen. Die Kugeln
des Gegners sollen auch auf der geraden Linie liegen und benachbart sein.
Die Anzahl der stoßenden Kugeln soll höher sein als die Anzahl der Kugeln des
Gegners, also 2 zu 1, 3 zu 1, oder 3 zu 2. Der äußerste Kugel soll zu
einem freien Feld gestoßen werden, oder außerhalb dem Spielbrett. Der
Spieler, der 6 Kugeln des Gegners aus dem Spielbrett stoßt, gewinnt.

Notierung
---------
Eine Notierung ist definiert für die Züge. Damit wird es möglich eine
Partie auf Diskette zu speichern, und danach wieder zu laden. Zuerst wird
die Notierung der Felder erklärt. Das Brett hat 61 Felder, nämlich das
Zentrum und 6 Gruppen von je 10 Felder. Jede Gruppe stimmt überein mit
einer Seite des sechseckigen Bretts. Die Gruppen/Seiten heißen A, B, C, D,
E, F. Das Zentrum heißt GG. Der Schwarzspieler sitzt vor Gruppe A, und
der Weißspieler vor Gruppe D. Die Folge der Gruppen ist gegen den
Drehrichtung der Uhr. Auf dem Bildschirm hat jede Gruppe des Spielbretts
eine eigene Farbe. Die Felder einer Gruppe haben die Nummer 0, 1, .. , 9.
Die Nummer steigt vom Zentrum zu der Seite, und von links zu rechts. Also,
die Felder heißen :

          E6  D9  D8  D7  D6

        E7  E3  D5  D4  D3  C9

      E8  E4  E1  D2  D1  C5  C8

    E9  E5  E2  E0  D0  C2  C4  C7

  F6  F3  F1  F0  GG  C0  C1  C3  C6

    F7  F4  F2  A0  B0  B2  B5  B9

      F8  F5  A1  A2  B1  B4  B8

        F9  A3  A4  A5  B3  B7

          A6  A7  A8  A9  B6

Die Notierung eines Zuges ist wie folgt: <n><f1>-<f2><x>
<n>  = die Anzahl der eigenen Kugeln, nämlich '1', '2', '3'
<f1> = das Feld der Kopfkugel einer Reihe
<f2> = das Feld wo die Kopfkugel hin geht
<x>  = 'l' wenn die Reihe nach links schiebt
     = 'r' wenn die Reihe nach rechts schiebt
     = '+' wenn eine Kugel des Gegners aus dem Spielbrett gestoßen wird
     = leer, wenn die Reihe gerade aus schiebt, und keine Kugel aus dem
       Brett stoßt
Beispiele :
- Schwarze Kugel auf B0 schiebt zu GG => 1B0-GG
- Schwarze Kugeln auf A0, A1, A3 schieben zu F0, F2, F5 => 3A0-F0l
- Schwarze Kugeln auf GG, B0 schieben zu D0, C0 => 2GG-D0r
- Schwarze Kugeln auf E2, F0, A0 stoßen zwei Weiße Kugeln auf E4, E7
  => 3E2-E4+

Stellung aufsetzen
------------------
Das Lämpchen steht neben dem Spieler, der den ersten Zug macht. Beim
Drücken auf die linke Maustaste über einem Feld erscheint eine Kugel mit
der Farbe dieses Spielers. Wenn schon eine solche Kugel auf dem Feld stand,
dann wird das Feld gelehrt. Beim Drücken auf die rechte Maustaste
erscheint eine Kugel mit der Farbe des Gegners.

Hilfe
-----
In der Datei 'help.L' steht die Name der Datei die von der Hilfsfunktion im
Programm gezeigt wird, z.B. 'help.doc.D'.

Programmstart
-------------
Programm aMalone kann mann starten durch Anklicken des Icons. Normal hat
das Programm einen Puffer für 512 Halbzüge, oder 256 ganze Züge. Sollte
dieser Puffer nicht ausreichen, speichere dann zuerst die Partie auf
Diskette. Starte darauf das Programm im CLI mit der Anzahl der Halbzüge
als Argument, z.B. : aMalone 1024


Ich wünsche Ihnen viel Vergnügen mit dem Spiel aMalone. Ich rate Ihnen zum
Kaufen des originellen Spiels (abalone), weil es Spaß macht die Kugeln über
das Spielbrett zu schieben.
