                           aMemory  von  Tis Veugen

Einleitung
==========
 aMemory ist die Implementation eines Spiels daß schon lange Zeit in
verschiedenen Formen im Wohnzimmer gespielt wird.  Das Spiel hat eine große
Menge Karten, worauf je ein schönes Bild steht.  Es gibt genau zwei Karten
für jedes Bild.  Am Anfang werden die Karten abgedeckt in Reihen und
Spalten niedergelegt.  Zwei Spieler dürfen reihum 2 Karten umdrehen.  Der
Zweck ist um Karten mit demselben Bild zu finden.  Im Falle von gleichen
Bildern entfernt der Spieler die Karten, und danach darf er noch einmal.
Wer am Ende die meisten Karten entfernt hat, hat das Spiel gewonnen.
 Mit dem Spiel kann man das Gedächtnis trainieren.  Es hat sich
herausgestellt daß insbesonders Kinder, ab ungefähr 3 Jahren, das Spiel gut
meistern.  Deshalb ist das Programm so gemacht daß sogar kleine Kinder das
Programm bedienen können, und zwar mit dem Joystick.  Für manche Optionen
braucht man die Maus.
 Das Programm hat 2 Bildschirmen, das Menüschirm und das Spielschirm.

Menüschirm
===========
 Der 'Kursor' ist das Clownchen mit den roten Haren und den blinkenden
Augen, das beim Schirmaufbau auf der '1' der linken Spalte mit Ziffern
steht. Das Clownchen kann sowohl mit der Maus, wie auch mit dem Joystick
gesteuert werden. Zuerst wird die Bedienung mit dem Joystick beschrieben.
 Mit dem Joystick kann man das Clownchen nach links, rechts, oben, unten,
oder diagonal bewegen.  Im Allgemeinen bestimmt man eine Wahl durch
drücken auf dem Feuerknopf.  Die zwei Spalten mit Ziffern gehören den
möglichen Spielernamen.  Die Clownchen mit dem orangefarbigen Haren zeigen
die Namen der gewählten Spieler.  Der Spieler mit dem Clownchen in der
ersten Spalte fängt an.  Es ist möglich das Spiel gegen den Amiga zu
spielen.  Wähle dazu den Spieler 'Computer'.

 Rechtsoben kann man das Schwierigkeitsniveau einstellen, eine Zahl
zwischen 0 und 9.  Das hat nur Zweck wenn gegen den Amiga gespielt wird.
Im niedrigsten Niveau "0" vergißt der Komputer die umgedrehten Karten
schnell.  Im höchsten Niveau behaltet der Komputer alles!
 Rechtsunten bestimmt man die Zahl der Karten im Vielfachen von 6 Karten.
Das Spielschirm enthält maximal 54 Karten.
 Mit den zwei Iconen an der Unterseite des Schirms kann man das Spiel
anfangen (links), oder das Programm beenden (rechts).
 Das Programm hat eine Sprachmodul, die unter anderen sagt welcher Spieler
am Zug ist.  Mit dem Icon linksunten kann man die Sprachmodul einschalten
oder ausschalten.
 Der Icon linksoben zeigt ob die Namen im Bildschirmmitte die Spielernamen
vorstellen, oder die Namen der IFF-Dateien mit den Bildern für die Karten.
Im letzten Falle kann man wählen aus welchen IFF-Dateien die Bilder
herkommen.  (Sehe auch 'Konfiguration'.) Die IFF-Dateien mit einem
Clownchen in der zweiten Spalte machen mit.  Wenn bei einem lehren Namen in
der ersten Spalte auf dem Feuerknopf gedrückt wird, dann erscheint ein
File-Requester mit dem man den Namen einer IFF-Datei wählen kann.  Die
bedienung des File-Requesters (mit der Maus) ist einfach.  Bei Anklicken von
"OK" wird die IFF-Datei mit Bildern an der Liste hinzugefügt.  Wenn man
bei einer Dateiname in der ersten Spalte auf dem Feuerknopf drückt, dann
verschwindet die IFF-Datei aus der Liste.
 man kann die Maus und der Joystick durch einander nutzen. Weise mit der
Maus ein Icon oder ein Clownchen an, und drücke auf dem linken Mausknopf.

Spielschirm
===========
 man wählt eine Karte durch Drücken auf dem Feuerknopf.  Ein Spieler
darf eine Karte wählen wenn der großen 'Quadratkursor' die Farben Rot und
Weiß hat.  Wenn der Kursor die Farben Grün und Schwarz hat, dann soll der
Spieler noch einmal auf dem Feuerknopf drücken um weiter zu machen.
 Das Lämpchen vor einem der beiden Spieler zeigt, wer am Zug ist.
Weiterhin sagt die Sprachmodul den Namen der Spieler, der am Zug ist.
 Die gelben Balken mit dem roten Rahmen zeigen grafisch den Spielstand.
Bei einer Spielstandänderung ändern beide(!) Balken.  Derjenige, dessen
Balken zuerst "voll" ist, hat gewonnen.
 Mit dem Icon linksoben kann man zurück zum Menüschirm.  Damit man sich
nicht irrt, muß man zweimal(!) auf dem Feuerknopf drücken.

Auch die folgenden Tasten der Tastatur kann man anwenden:
 Q      : Programmende
 s      : Sprachmodul an/aus
 u      : Joystick nach oben
 d      : Joystick nach unten
 l      : Joystick nach links
 r      : Joystick nach rechts
 space  : Feuerknopf der Joystick
 <n>    : Schwierigkeitsniveau

Konfiguration
=============
 Es gibt 3 Dateien genannt ".files", ".names", ".talks", die das Programm
aMemory konfigurieren.

 Datei ".talks" enthält den Texten die von der Sprachmodul ausgesprochen
werden.  Die Texten sind aufgebaut aus Phonemen, die an das sogenannten
'narrator.device' aangeboten werden.  Die Phonemen sind unter anderen
beschrieben im "AMIGA ROM Kernel Reference Manual: Libraries and Devices".
Das Hilfsprogramm 'phonemed' erleichtert das Zusammenstellen der Phonemen.

 Datei ".names" enthält den Spielernamen und den korrespondierenden
phonetischen Texten.

 Die Bilder auf den Karten sind (in HIRES modus) 64 Pixeln breit und 32
Pixeln hoch.  Deshalb sollen die IFF-Dateien mit den Bildern ein Vielfaches
dieser Breite und dieser Höhe sein.  Die mitgelieferten IFF-Dateien sind
mit DPaintII gezeichnet, und (teils) als Brush gespeichert.  Datei
PICTOS.10.8.IFF ist kein Brush, die sonstigen dagegen wohl.
 Die vollständigen Namen der IFF-Dateien stehen in der Datei ".files" .
Beim Programmstart werden alle Namen aus ".files" gelesen, und werden die
IFF-Dateien zu Bitmaps kopiert.  Weil jedes Bild 1K groß ist, benötigen die
oben genannten IFF-Dateien zusammen 203K.  Das Programm hält an wenn das
chip-RAM nicht ausreicht.
