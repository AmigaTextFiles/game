                           phonemed von Tis Veugen

 Programm 'phonemed' ist ein Editor für Phonemen.  Das Programm ist eine
Hilfe um Wörter umzuwandlen in phonetischen Texten, die darauf vom Amiga
ausgesprochen werden können.  Ein Phonem ist ein urtümlich Sprachelement,
und wird dargestelt von einer kurzen Zeichenkette.  In [1] gibt es eine
Aufzählung aller möglichen Phonemen.  Jedes Wort kann zergliedert werden in
eine Reihe von Phonemen.  Der phonetischen Text zum Wort ist eine
Zeichenkette von aneinander gereihen Phonemen, die angeboten wird am
sogenannten "narrator.device".  Das Programmieren davon in Assembler wird
erklärt in [2], [3].
 Die Kunst ist ein Wort so in Phonemen umzuwandlen, daß die Aussprache vom
Amiga einer natürlichen Aussprache gleicht.  Das Umwandlen eines Wortes in
seinem phonetischen Text gescheht mit Hilfe der Funktion "Translate()" der
sogenannten "translator.library".  Leider ist diese Funktion nur imstande
englischen Wörter umzuwandlen in Phonemen.  Deshalb spricht das
"narrator.device" besonders englischen Klangen natürlich aus.  Das
Umwandlen deutscher Wörter muß also mit der Hand geschehen.  Das erfordert
einige Fertigkeit, weil die Wörter ausgesprochen werden mit englischen
Klangen.  Programm 'phonemed' ist hierbei eine große Hilfe dank dessen
user-interface.

 Die Bedienung von 'phonemed' gescheht mit dem Maus.  Der obersten Teil des
Bildschirms enthält eine Übersicht der Phonemen zusammen mit einem
Beispielwort, worin das Phonem vorkommt.  Ein Phonem wird durch Anklicken
ausgesprochen so lange der linken Mausknopf eingedrückt bleibt.  Leider
enthält das Narrator-device einen Fehler (?), sodaß einen Guru erscheinen
würde bei Anklicken von "RX" und "LX".
 Der obersten Stringgadget enthält den auszusprechen Text.  Der untersten
Stringgadget enthält den phonetischen Text.  Mit den Gadgets LOAD und SAVE
werden die diesbezüglichen Texten geladen bzw.  gespeichert.  Ein
Filerequester erscheint, dessen Bedienung sehr leicht ist.  Mit Gadget
TRANSLATE wird die Translate-Funktion angerufen um der input Text
umzuwandlen in Phonemen.  Dieser Gadget ist immer wertvol als ersten
Versuch für einen phonetischen Text.  Mit SAY wird der phonetischen Text
ein Mal ausgesprochen.  Mit LOOP wird der phonetischen Text wiederholt
ausgesprochen, bis nochmals der LOOP-Gadget angeklickt wird.

 Die sonstigen Gadgets an der Unterseite des Bildschirms haben den Zweck
die "Stimme" einzustellen :
 rate   = Sprechgeschwindigkeit in Wörter/Minute;
 pitch  = Stimmhöhe;
 volume = Lautstärke;
 freq   = Frequenz in Bytes/Sekunde mitdem das Audiosignal ist aufgebaut;
Durch Anklicken des Textes "rate", usw.  wird der Startwert wiedergestellt.
Mit den zwei Iconen rechtsunten kann man abwechseln zwischen einer normalen
Stimme und einer (monotonen) Robotstimme, bzw.  zwischen einer mänlichen
Stimme oder einer weiblichen Stimme.

[1] "AMIGA ROM Kernel Reference Manual:  Libraries and Devices", Commodore
    Business Machines Inc, Addison Wesley, 1986, ISBN 0-201-11078-4
[2] Amiga MAGAZIN, 10/1992, Seite 75
[3] "Amiga Maschinensprache", Data Becker, 1987, ISBN 3-89011-076-2
