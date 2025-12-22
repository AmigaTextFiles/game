    EINLEITUNG
    ==========
WatchIt ist die Implementation eines Spiels daß in Holland bekannt ist mit
dem Namen 'Onderuit'.  Das ursprüngliche Spiel spielt man mit richtige
Räder die befestigt sind an beiden Seiten eines senkrechten Bretts.  Also,
ein Spieler kann die gegnerischen Kugeln nicht sehen.  Aber, nach
gründlicher Untersuchung der Lochstellen in jedem Rad und mit ein gutes
Gedächtnis, sollte es möglich sein die vollständige Lage zu wissen.  Für
einen Computer ist das sehr einfach.  Deshalb ist das Spiel implementiert
mit vollständiger Kenntnis mit Bezug auf den Gegner.


    SPIELREGELN
    ===========
Am Anfang befinden sich alle 10 Kugel in den Löcher an der Obenseite.  Der
Zweck des Spiels ist um alle eigene Kugel so schnell wie möglich zu die
Löcher an der Untenseite zu transportieren.  Der Spieler, der dies zuerst
gelingt gewinnt die Partie, und das Spiel ist dan zugleich zu Ende.
Ein Kugel kann in ein Loch eines Rads fallen, und da auch wieder aus
fallen.  Durch Drehen der Räder kann man die Kugel immer ein Rad weiter
nach unten transportieren.  Weil die Räder an der Vorderseite und an der
Hinterseite an einander "festsitzen", kann man den Gegner helfen oder
entgegenarbeiten.  Man darf reihum ein Rad hin und zurück drehen nach
eigenem Wunsch.  Es ist aber verboten ein Rad zu drehen, das der Gegner in
der vorigen Reihe gedreht hat.  Eine Ausnahme zu diesem Regel handelt sich
um das unterste Rad mit den 5 Löcher:  man darf immer dieses Rad drehen,
wenn man damit die Partie beendet.
Die Zahlen auf den Kugeln haben in dieser Version keine Bedeutung.  Man
darf die Kugel in beliebiger Folge in den untersten Löchern stecken.


    INSTALLATION
    ============
Zu WatchIt gehören die folgende Dateien :
  WatchIt.info  WorkBench icon
  screen.iff    user interface Schirm
  help.txt.D    Hilftext in Deutsch
  help.txt.E    Hilftext in English
  help.txt.N    Hilftext in Holländisch
  help.txt      Kopie von help.txt.N
Man kann das Programm starten mit dem WorkBench Icon oder vom CLI aus.
Folgende CLI Optionen sind möglich :

  -h<Tiefe>   setze die Tiefe der Historiepuffer (512)
  -m<Anzahl>  setze die Anzahl Züge für die Berechnungen (10000)

Der Zügenzähler in der Bildschirmmitte zeigt die heutigen Tiefe des
Historiepuffers. Wenn eine Partie länger als 512 Züge dauert, dann ist
es notwendig den Historiepuffer zu vergrößeren. Speichere dazu zuerst
die Partie; starte das Programm von neuem mit zum Beispiel Option -h1024;
und lade danach die Partie wieder.
Als Betriebssytem benötigt man OS 2.04.


    BEDIENUNG
    =========
Man kann ein Rad drehen wenn man mit der Maus darauf drückt.  Wenn man auf
der Rechtenseite drückt, dann dreht das Rad rechtsum.  Und, wenn man auf
der Linkenseite drückt, dann dreht das Rad linksum.  Das Rad dreht solange
man den Mausknopf eindrückt.  Aber, das Rad hält an wenn ein Loch genau auf
eine Öffnung eines benachbarten Rads stößt.  Das ist geschickt zum
Aufziehen oder Abliefern einer Kugel.  Man muß dann den Mausknopf loslassen
und wieder eindrücken um weiter zu drehen.  Wenn man einmal ein Rad gedreht
hat, dan verschwindet das senkrechte, schwarze Strichelchen in der
Radmitte.  Das Rad daß der Gegner in der vorigen Reihe gedreht hat,
herkennt man an dem Blauen Kreuz in der Radmitte.  Das Ende der Reihe gibt
mann zu erkennen durch Drücken mit der Mause auf die Hälfte des Gegners.
Das Lämpchen neben den Spielernamen zeigt, wer am Zug ist.  Die Bedienung
der (Sub)menüs ist :

   Project        Algemeine Kontrolle.
     New game     Starte eine neue Partie.
     Save game    Speichere eine Partie.
     Load game    Lade eine Partie.
     Help         Zeige den Hilftext.
     Quit         Beende das Programm.

   Move           Gehe einige Züge weiter oder zurück.
     Begin        Gehe zum Anfang der Partie.  Das ist geschickt zum
                  Durchlaufen der ganzen Partie.
     Back-1       Gehe einen Zug zurück.
     Back-2       Gehe zwei Züge zurück.
     Forward      Gehe einen Zug weiter. Das ist nur möglich wenn man
                  zuerst einige Züge zurück gegangen hat.
     End          Gehe zu den letzten Zug.
     Compute      Der Computer berechnet einen Zug; dies is nützlich wenn
                  eigentlich einer menschlichen Spieler ziehen soll.

   Players        Zeige die Spieler.
     Player 1     Zeige Spieler 1.
       Human      Spiele selber für Spieler 1.
       Name       Gebe den Name an, und spiele selber für Spieler 1.
       Amiga      Der Computer spielt für Spieler 1.
     Player 2     Zeige Spieler 2.
       Human      analogisch wie 'Player 1'
       Name       analogisch wie 'Player 1'
       Amiga      analogisch wie 'Player 1'

   Profile        Bestimme die Computereinstellungen zum Berechnen eines
                  Zuges.
     Level        Bestimme das Schwierigkeitsniveau zwischen 1 und 9.
                  Dieses Niveau gleicht die Suchtiefe der Zügen, worauf
                  der Computer seinen Zug basiert.
     Selectivity  Suche selektiv zu den besten Zug: für jedes Rad werden
                  nur die 3 beste Möglichkeiten weiter verarbeitet.
                  Im Falle 'none' werden all Möglichkeiten untersucht.
                  Im Falle einer Zahl 'x' wird selektiv gesucht auf den 
                  niedrigsten 'x' Suchtiefes. Bei einer Selektivität von
                  '4' (die Standardselektivität) und Schwierigkeitsniveau
                  '4' wird selektiv gesucht auf jede Suchtiefe.  Bei einer
                  Selektivität von zum Beispiel '3' werden auf die höchste
                  Suchtiefe alle Züge verarbeitet, und auf die 3 niedrige
                  Suchtiefes findet die Selektivität statt.
     Search move  Suche zu den optimalen Zug laut 3 Möglichkeiten :
       first      Wähle den besten Zug, der vorn in der Reihe steht.
       ties       Wenn mehrere beste Züge in der Reihe stehen, dann wähle
                  einen beliebigen dieser Züge.
       random     Wähle einen beliebigen guten Zug.
     Player 1     Bestimme das Profil für Spieler 1.
       snap       Fixiere die heutige Einstellungen 'Level', 'Selectivity',
                  und 'Search move' für Spieler 1.
       free       Gib das fixierte Profil frei: nutze das heutige Profil.
     Player 2     Bestimme das Profil für Spieler 1.
       snap       analogisch wie 'Player 1'
       free       analogisch wie 'Player 1'




  COPYRIGHTS
  ==========
Programm WatchIt ist ©opyright by Tis Veugen, Februar 1995.
Verteilung für nicht-kommerzielle Zwecke ist gestattet.
                       __
            ________  / /
            \__  __/ / /
Tis Veugen     \ \  / /
Schubertlaan 2  \ \/ /
5583 XW Waalre   \__/
Die Niederlande
