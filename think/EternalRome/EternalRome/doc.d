                              ETERNAL ROME                     1. März 1992

              Programmierung und Copyright : Sven Hartrumpf, MXMII



                              Dokumentation


Inhaltsverzeichnis


Einführung                     1

I.   Grundlagen                3
II.  Steuerphase               6
III. Seephase                  8
IV.  Landbwegungsphase        10
V.   Landkampfphase           11
VI.  Belagerungsphase         12



Einführung

ETERNAL ROME ist ein extrem komplexes Strategiespiel, das die wichtigsten
und interessantesten Perioden des Römischen Reiches in zahlreichen
Szenarien simuliert.  Die Simulation umfaßt militärische, diplomatische,
politische, ökonomische und soziale Faktoren und Probleme.

Meine Absicht war es, eine Simulation zu schreiben, die sehr realistisch
und historisch genau ist, aber trotzdem einfach und schnell zu spielen ist.
Diese Simulation ermöglicht interessierten Personen, sich mit einer Periode
der Geschichte vertraut zu machen, die die meisten Grundlagen unserer
modernen Kultur und Zivilisation legte.

Die meisten Szenarien können von zwei Spielern gespielt werden.  Das Spiel
eignet sich aber auch hervorragend für Solitaire-Partien und historisch-
strategische Studien.  Wie fast alle Spiele dieser Art, macht das Spiel um
so mehr Spaß, je mehr Spieler beteiligt sind.  Aber ich habe für alle
Szenarien, die normalerweise für 3, 4 oder sogar 5 Spieler ausgelegt sind,
eine oder mehrere Versionen für weniger Spieler entwickelt.

Ich hoffe, daß Hobby-Strategen, historisch Interessierte und alle Menschen,
die das inspirierende und unterhaltende Spiel mit anderen lieben, ETERNAL
ROME als "ihr" Spiel liebgewinnen.


























                                - 2 -


Es gibt zwei Versionen von ETERNAL ROME:  eine Tryware-Version 1.x und eine
professionelle Version 2.x.  Die Tryware-Version darf frei kopiert werden,
solange das Originalprogramm zusammen mit dieser Original-Dokumentation
verbreitet wird.  Ich erlaube hiermit, die Tryware-Version des Programmes
in der oben beschriebenen Art auch in andere Public-Domain-Reihen (aber nur
solche die wirklich public domain sind) aufzunehmen.  Die Tryware-Version
hat keine Fileoperatione.  Deshalb kann man Szenarien weder speichern noch
laden.  Man sollte die Tryware-Version benutzen, um entscheiden zu können,
ob die professionelle Version den relativ niedrigen Preis wert ist.  Die
Tryware-Version ist auf das Szenario "Octavius und Antonius" für zwei
Spieler beschränkt.

Falls Sie die Tryware-Version überzeugt hat, können Sie die komplette
professionelle Version kaufen.  Die professionelle Version ist nicht Freeware,
ist urheberrechtlich geschützt und darf nicht kopiert oder weitergegeben
werden.  Dagegen zu verstoßen ist sowohl illegal als auch unmoralisch.
Wenn Sie die professionelle Version kaufen, werden Sie ein registrierter
Benutzer.  Die professionelle Version beinhaltet fünf Szenarien.  Zusätzlich
kann man zwei Szenario-Disketten (Alpha und Beta) kaufen, die jeweils 10
neue Szenarien beinhalten.  Die meisten Szenarien werden in mehreren
Versionen für verschiedene Spielerzahlen geliefert.  Man kann
Szenario-Disketten nur kaufen, wenn man ein registrierter Benutzer von
ETERNAL ROME ist.

                 Währung       USA ($)   GB (£)    Deutschland (DM)
Produkt

ETERNAL ROME 2.1,              39,00     22,00     59,00
professionelle Version

Szenario-Diskette Alpha        19,00     11,00     29,00

Szenario-Diskette Beta         19,00     11,00     29,00

ETERNAL ROME 2.1               66,00     38,00     99,00
plus Szenario-Disketten
Alpha und Beta      (man spart 11,00      6,00     18,00)

Ich muß leider immer für        6,00      3,00      6,00
Porto und Versand berechnen:






Schicken Sie ihre Bestellungen (außerhalb Deutschlands nur Vorkasse, innerhalb
Deutschlands auch per Nachnahme), Vorschläge und Kommentare an:


                 S. Hartrumpf
                 Die Rappenwiesen 41 b
                 6380 Bad Homburg
                 GERMANY





                              Keine Haftung

Ich übernehme keinerlei Haftung für Schäden (einschließlich verlorene
Gewinne, Gelder oder andere spezielle Folgeschäden, die aus der
Benutzung oder der Unfähigkeit, ETERNAL ROME zu benutzen, entstehen). 
Dies umfaßt u.a.  Verlust von Daten oder Fehler in der Zusammenarbeit
mit anderen Programmen.



                                - 3 -


I. Grundlagen

Man kann das Spiel ohne Argumente starten (EternalRome, der Stack sollte
mindestens 20000 Byte groß sein), aber man kann auch drei Parameter über
das CLI/SHELL angeben.  Der erste Parameter enthält die Breite, der zweite
die Höhe des Fensters von ETERNAL ROME in Punkten.  Falls der dritte
(optionale) Parameter gleich 'i' ist, wird der Interlace-Modus benutzt.
Falls keine Parameter angegeben werden, hat das Hauptfenster 640*200 Punkte
ohne Interlace.  Ich empfehle eine Fenstergröße von 730*280 (oder 564 bei
Interlace) für alle, die den PAL-Modus verwenden können (ggf.  muß man für
diese Werte die Voreinstellungen für die Größe und Lage des
Workbench-Screen ändern).

Zuerst werde ich die grundlegenden Kontrollelemente der Computer-
Simulation beschreiben.  ETERNAL ROME benutzt ein flexibles
Informations-System, das Fenster-orientiert arbeitet.  Man kann die
Simulation sehr komfortabel während aller Phasen ausschließlich mit der
Maus steuern (Ausnahme, wenn man einen neuen File-Namen zum Speichern eines
Szenarios angeben will).  Wenn man in ein Hexagon (im Folgenden werde ich
die übliche Abkürzung Hex/Hexes verwenden) mit der Maus klickt, wird ein
Informations-Fenster geöffnet, das alle interessanten Informationen über
dieses Hex enthält.  Da die Einsicht eines Spielers in die militärischen
Angelegenheiten seiner Gegner streng begrenzt ist auf die Hexes, wo er
selbst Truppen oder Flotten kontrolliert, wird man in Hexes, in denen man
keine Truppen hat, nur über die Position, nicht aber über die Stärke
gegnerischer Einheiten informiert.  Die Spieler können aber in
gegenseitigem Einvernehmen diese Beschränkung aufheben, indem sie den
Menüpunkt 'Intelligence' im 'Options'-Menü benutzen.

Jedes Informations-Fenster kann durch Klicken in die linke obere Ecke
geschlossen werden.  Wenn ein Fenster weitere Eingaben oder Ausgaben
erwartet, kann es nicht geschlossen werden.  Wenn man das Hauptfenster mit
der Karte schließt, wird nachgefragt, ob man wirklich die Simulation
verlassen will.  Falls man dies bestätigt, wird die Simulation sofort
beendet.  Man kann alle Informations-Fenster auf einmal schließen, indem
man den Menüpunkt 'Clear display' im 'Utilities'-Menü anwählt.
Informationen werden normalerweise weiß gedruckt.  Aber in den meisten
Fenstern gibt es auch blauen Text.  Wenn man in solchen Text klickt, erhält
man Informationen, die das Objekt betreffen, welches der angeklickte Text
repräsentiert.  Sie werden dieses sehr trickreiche und mächtige
Informations-System schnell verstehen.

Nach dem Start des Spiels, sieht man eine geographische Karte, die alle
Gebiete in Europa, Asien und Afrika beinhaltet, die jemals zum Römischen
Reich (Imperium Romanum) gehörten, und alle Gebiete seiner größten Feinde.
In der Titelzeile werden wichtige Informationen in der folgenden
Reihenfolge angezeigt:  der Name der aktuellen Phase, der Name der Macht,
die am Zug ist, das aktuelle Datum und der Kommunikations-Status.  Wenn ein
'*' vor dem Datum steht, ist es Winter und alle Bewegungskosten sind höher
als im Sommer.  Es gibt einige Provinzen, in denen der Winter so warm ist,
daß sie die Bewegungen nicht erschweren.  Von Mai bis Oktober herrscht
immer Sommer, von Dezember bis März immer Winter, April und November können
Sommer- oder Wintermonate sein (der Computer bestimmt per Zufallszahl, ob
Winter oder Sommer herrscht).

Die letzte Information in der Titelzeile, der Kommunikations- Status, ist
sehr wichtig, da der Computer dort anzeigt, welche Eingaben er vom Benutzer
erwartet, z.B.  falls der Status "Select two fleets" lautet, erwartet der
Computer vom Spieler, daß er ein Informations-Fenster über die Flotte, die
der Spieler auswählen will öffnet (nur nötig, wenn noch nicht ein solches
Fenster geöffnet wurde), und erwartet dann, daß das Fenster der gewünschten
Flotte aktiviert wird, indem der Spieler in dieses Fenster klickt (dabei
vermeide man das Anklicken von blauem Text, weil man andernfalls
Informationen erhält, die man gar nicht will).





                                - 4 -


Aktivierte und inaktivierte Fenster werden von Intuition wie folgt
unterschieden:  ein aktiviertes Fenster hat eine normale (d.h.  leicht zu
lesende) Titelzeile, während die Titelzeile eines inaktivierten Fensters
schwer lesbar ("ghosted") erscheint.  Programme wie AutoPoint, die
Mausklicks automatisch bei Erreichen eines Fensters erzeugen, sollte man
nicht benutzen, während man ETERNAL ROME benutzt.  Aber zurück zu dem
gegebenen Beispiel.  Wenn man eine Flotte wie oben angegeben ausgewählt hat,
ändert sich der Status und es wird 'Select one fleet' als neuer Status
angezeigt.  Dann muß man wie oben beschrieben eine zweite Flotte auswählen.

Man kann eine Aktion immer unterbrechen und somit den Status-Text in der
Titelzeile des Hauptfensters löschen, indem man den Menüpunkt 'Quit action'
im Menü 'Utilities' anwählt.  Der Computer ändert den Status-Text nicht,
wenn Sie ein Objekt des verlangten Typs anwählen, das aber nicht für die
aktuelle Operation benutzt werden kann.  In den meisten Fällen werden Sie
sofort verstehen, warum Ihre Eingabe nicht akzeptiert wird (z.B.  ist es
vernünftig, daß der Computer Ihnen nicht erlaubt, die Position oder
Zusammensetzung feindlicher Armeen oder Flotten zu ändern u.ä.), aber in
seltenen Fällen werden Sie einen Blick in diese Dokumentation werfen
müssen, um Ihren Fehler zu verstehen.  Der Computer versucht immer,
unsinnige oder verbotene Eingaben zurückzuweisen.

Die Karte ist in Provinzen untergliedert.  Provinzgrenzen sind weiß
gezeichnet.  Jede Provinz besteht aus mehreren Hexes.  Ein Hex hat eine
durchschnittliche Breite von 70 km.  Die Farbe und manchmal auch das Muster
des Hexes zeigt den überwiegenden Landschaftstyp an.  Um die verschiedenen
Landschaftstypen zu identifizieren, werfen Sie einen Blick auf die folgende
Tabelle:

Farbe       Landschaftstyp      Farbe       Lanschaftstyp

weiß        freie Ebene         braun       gebirgig
grün        Wald                blau        seichtes Meer
dunkelgrün  Sumpf               dunkelblau  tiefes Meer
gelb        Wüste

Die ersten fünf Landschaftstypen können nur zu Land betreten werden,
während die letzten beiden nur zur See betreten werden können.  Aber es
gibt auch gemischte Hexes, da der Verlauf von Meeresküsten weit entfernt
von einer hexagonalen Form ist.  Diese gemischten Hexes sind in Hellblau,
das seichtes Merr repräsentiert, und in der Farbe des vorherrschenden
Landschaftstyps horizontal gestreift.

Grundsätzlich kann man sich von jedem Hex in sechs Richtungen bewegen.  Aber
wenn man sich zur See bewegt, muß das Hex zur See passierbar sein, und wenn
man sich zu Land bewegt, muß das Hex zu Land passierbar sein.  Wie alle
Regeln sollten Sie diese Regel kennen, aber wenn Sie diese oder eine andere
Regel mal vergessen, macht dies nichts, denn der Computer erlaubt
niemandem, eine Regel zu verletzen.  Daher hilft der Computer Ihnen große
Probleme und Dispute zu vermeiden, die durch (un)absichtliches Verletzen
von Regeln entstehen.  Es gibt Verbindungen zwischen Hexes, die nach
dieser allgemeinen Regel passierbar sein sollten, es aber nicht sind.  Die
Grenze zwischen Hexes, zwischen denen keine Verbindung existiert, ist
schwarz gezeichnet.  In den meisten Fällen repräsentieren diese schwarzen
Linien Gebirge, die nicht von einer Armee passiert werden können.  Zwischen
manchen Hexes, die Land und See umfassen, besteht keine Verbindung zu Land
(zu Wasser), da sie nicht direkt zu Land (zu Wasser) verbunden sind.  In der
Karte sind unverbundene Meer-Hexes nicht gekennzeichnet.  Man darf nicht
Provinzen betreten, die zu Anfang eines Szenarios keiner Macht zugeordnet
waren.  Es gibt sieben Meerengen, die von Landeinheiten mit zusätzlichen
Bewegungspunkten passiert werden können, ohne Schiffe benutzen zu müssen:
der Bosporus und der Hellespont mit 4, die Straße von Gibraltar mit 12, der
Ärmelkanal mit 16, die Straße von Messina mit 4, der Golf von Patras mit 8
und die Straße zwischen dem Schwarzen Meer und dem Asowschen Meer mit 4
zusätzlichen Bewegungspunkten.




                                - 5 -


Sie können den Ausschnitt und den Maßstab der Karte ändern, indem sie die
drei Schiebebalken am rechten und unteren Rand des Karten-Fensters
benutzen.  Der rechte, vertikale Schiebebalken bewegt den sichtbaren
Ausschnitt der Karte nach oben (Norden) und unten (Süden), der untere
horizontale Schiebebalken bewegt dem sichtbaren Ausschnitt der Karte nach
links (Westen) und nach rechts (Osten).  Der obere horizontale
Schiebebalken verändert den Maßstab der Karte:  Nach links werden die Hexes
kleiner, nach rechts größer.  Der Computer vergrößert und verkleinert immer
relativ zur Kartenmitte.

Die Karte zeigt die Namen (oder die ersten Buchstaben der Namen) der
wichtigsten Städte (maximal eine Stadt pro Hex); falls der Name einer
Stadt sich während der abgedeckten Zeitperiode änderte (z.B.  Byzantium -
Constantinopolis), wird der bekanntere antike Name benutzt.  Die meisten
Provinzen haben mehrere Städte und eine Hauptstadt.  Die Namen von
Hauptstädten werden groß geschrieben.  Die Existenz und Bedeutung einer
Stadt kann sich von Szenario zu Szenario ändern.  Dies spiegelt die
historische Entwicklung im antiken Stadtleben wider, das ein zentraler
Aspekt des Römischen Reiches war.  Deshalb hängt der Besitz einer Provinz
vom Besitz ihrer Städte ab.  Eine Macht (s.u.) kontrolliert solange eine
Provinz, wie sie die Hauptstadt kontrolliert.  Eine Macht gewinnt die
Kontrolle über eine Provinz, wenn sie die Hauptstadt und mindestens die
Hälfte der übrigen Städte kontrolliert.

Eine Macht ist eine politische Fraktion, die in einem Szenario simuliert
wird.  Eine Macht kann Städte und Provinzen kontrollieren, Landeinheiten
und Flotten bewegen und rekrutieren, Provinzen besteuern und vieles weitere
mehr, das im folgenden beschrieben wird.  Jeder Spieler kontrolliert eine
oder mehrere Mächte und versucht, seine Siegesbedingungen zu erfüllen, die
man erfahren kann, wenn man den Menüpunkt 'Victory info' im Menü
'Diplomacy' anwählt.  Der Computer zeigt dann in diesem Informationsfenster
auch, welche der Bedingungen erfüllt sind und welche noch nicht.

Es gibt sieben verschiedene Arten von Mächten, die sich darin
unterscheiden, daß sie groß oder klein, zivilisiert oder barbarisch,
neutrale Staaten oder Klientelstaaten sind:

1. Römische Macht (immer eine große und zivilisierte Macht)
2. große zivilisierte Macht (aber keine römische Macht)
3. große barbarische Macht
4. kleine zivilisierte neutrale Macht
5. kleine barbarische neutrale Macht
6. kleine zivilisierte Klientelmacht
7. kleine barbarische Klientelmacht

Große Mächte haben stets ihre eigene Zugphase, kleine Mächte dagegen
niemals.  Wenn ein Spieler mehr als eine große Macht in einem Szenario
kontrolliert, dann ist dies in der Szenariobeschreibung (Menüpunkt 'About
scenario' im Menü 'Utilities') angegeben und/oder die Information über
Siegesbedingungen (s.u.) erwähnt Bedingungen für mehr als eine große Macht
und wieviele dieser Mächte ihre Siegesbedingungen erfüllen müssen.  Wenn
Spieler eine Allianz schließen, haben alle alliierten Spieler nur eine
gemeinsame Zugphase während der letzten Zugphase der alliierten Spieler.

Kleine Mächte können aktive oder inaktive Kleintelstaaten oder aktive oder
inaktive neutrale Staaten sein.

Wenn eine kleine Macht ein Klientelstaat ist, macht der Staat, der der
Patron des Klientelstaats ist (immer eine große Macht), alle Aktionen für
den Klientelstaat währen seiner eigenen Zugphase.  Einheiten der
Patronalmacht dürfen durch die Provinzen des Klientelstaates ziehen und im
Kampf werden sie als verbündet betrachtet.  Aber eine große Macht erhält
normalerweise keine Steuern von den Provinzen seiner Kleintelstaaten.  Wenn
ein Klientelstaat inaktiv ist, dürfen seine Truppen weder sich bewegen noch
angreifen.  Ein inaktiver Staat (sowohl ein neutraler Staat als auch ein
Klientelstaat) wird aktiv, wenn ein Feind in sein Land einfällt.



                                - 6 -


Ein inaktiver neutraler Staat beeinflußt das Spiel erst, wenn er aktiviert
wird.  Dann wird er von der Macht kontrolliert, dessen Interessen am
wenigsten mit denen des neutralen Staates verknüpft sind.  Diese Macht ist
die große Macht, dessen Provinzen und Landeinheiten am weitesten von denen
des neutralen Staates entfernt sind.  Jeden Monat wird die kontrollierende
Macht während der Steuerphase vom Computer erneut bestimmt.

Jede Macht kann Einheiten kontrollieren.  Eine Einheit ist eine bestimmte
Zahl von Soldaten eines Typs. Es gibt 11 verschiedene Einheitstypen:

 Name                     Land See  Bew. Sta. Anzahl

 Legion I                  24   12   20   4   (4000)  Stärkewerte der
 Legion II                 20   10   20   4   (4000)  Legionen werden
 Legion III                16    8   20   4   (4000)  nach 290 n. Chr. halbiert
 Civilized Infantry I      20   10   18   4   (4000)
 Civilized Infantry II     16    8   18   4   (4000)
 Barbarian Infantry        20   10   16   4   (4000)
 Light Infantry             4    4   24   1   (1200)
 Archers                    4    4   24   1   (1200)
 Heavy Cavalry             30    0   32   8   (1000 + 1000 Pferde)
 Light Cavalry              6    0   32   2   (1500 + 1500 Pferde)
 Horse Archers              6    0   32   2   (1500 + 1500 Pferde)

 Leader                              32   0   Die Person des Generals und
                                              sein Stab.

Die Zahlen, die den Namen der Einheitstypen folgen, zeigen den Stärkewert
zu Land, den Stärkewert zur See, die Bewegungspunkte und den Stapelwert
(zeigt den Platzbedarf der Einheit an - wichtig für Transporte mit Flotten)
des Einheitstyps an.

Eine Armee ist eine Zahl von Einheiten, die alle Operationen zusammen
ausführen.  Eine Armee kann von Generälen geführt werden.  Jeder General
hat einen Fähigkeitswert für Landoperatioen und einen Fähigkeitswert für
Seeoperationen. Beide Werte sind oft gleich, aber in einigen Fällen
außerordentlicher Fähigkeiten zur See (z.B.  Agrippa) oder zu Land sind sie
unterschiedlich.  Die Fähigkeitswerte sind wichtig für Kämpfe und
Störmanöver.

Eine Flotte ist eine Einheit von 50 Schiffen.  Einheiten von Flotten können
zu einer Flotte zusammengefaßt werden und dann wie eine Einheit kommandiert
werden.  Jede Flotte kann eine Armee transportieren.


II. Steuerphase

Diese Phase ist die allererste Phase in jedem Monat.  Zuerst werden die
Aktivierungsbedingungen für inaktive neutrale Staaten (wenn man den
Menüpunkt 'Activation info' im Menü 'Diplomacy' anwählt, kann man diese
erfahren) überprüft.  In manchen Fällen muß man dazu einen Würfel werfen:
man kann eine wirklichen Würfel benutzen und das Ergebnis durch Anklicken
der entsprechenden Würfelzahl eingeben, oder man kann 'R' ('Random')
anklicken und den Computer damit veranlassen, mit einem Zufallsgenerator
eine Zahl zwischen 1 und 6 zu erzeugen.  Wenn die Macht aktiv wird, wird
die Kontrolle über diesen Staat der im Informationsfenster dieses Staats
angegebenen Macht oder der entferntesten Macht zugewiesen.  Man kann die
entfernteste Macht (s. I.) bestimmen, indem man den Menüpunkt 'Farthest
power' im Menü 'Diplomacy' anwählt.  Die kontrollierende Macht muß die
Einheiten für die aktivierte Macht verteilen, indem sie den Menüpunkt 'Set
up units' im Menü 'Army' anwählt und dann ein Hex innerhalb der Provinzen
der aktivierten Macht auswählt, in dem Einheiten plaziert werden sollen.  Mit
einem speziellen Fenster (s. III.) kann man die aufzustellenden
Einheiten auswählen.  Diesen Vorgang wiederholt der kontrollierende
Spieler, bis alle Einheiten aufgestellt sind.




                                - 7 -


Während der Steuer-Pahse erhalten alle großen, zivilisierten Mächte Steuern
von ihren Provinzen.  Die Steuereinkünfte werden in einem
Informationsfenster aufgelistet.  Jede Macht hat ihre eigene Steuerphase,
bevor die erste Macht ihre übrigen Phasen spielt.  Die Steuern werden im
Schatz gesammelt.  Der Steuerwert einer Provinz ändert sich von Szenario zu
Szenario entsprechend den Veränderungen der wirtschaftlichen Lage der
Provinz.

In  der  Steuerphase kann jede Macht in ihren Provinzen auch neue Einheiten
und  Flotten  mobilisieren.   Man  kann maximal zwei Landeinheiten und zwei
Flotten  pro  Hex mobilisieren.  Falls die mobilisierende Macht zivilisiert
ist  und  Städte  zu Beginn des Szenarios kontrollierte, kann sie Einheiten
nur  in  nicht-belagerten befreundeten Städten rekrutieren.  Flotten können
natürlich  nur  in  Häfen  gebaut  werden.  Ihre Fertigstellung dauert drei
Monate.   Mit  dem  Besitzer  des  Hafens  wechselt  auch  der Besitzer der
Flotten, die dort gebaut werden.

Um Einheiten in einem Hex zu rekrutieren (Menüpunkt 'Recruit units' im Menü
'Army') muß man zuerst dieses Hex anwählen und dann die Namen der zu
rekrutierenden Einheitstypen anklicken.  Neue Einheiten haben nur die
Hälfte der Stärkepunkte alter, erfahrener Einheiten, aber nach Landkämpfen
werden sie zu erfahrenen Einheiten.

Es gibt drei Arten, Einheiten zu rekrutieren:

a) durch Zahlen von Talenten

Wenn das Szenario der mobilisierenden Macht diese Art des Rekrutierens
(von römischen Mächten benutzt) zuordnet, muß die Macht soviele Talente
zahlen, wie im Mobilisierungsfenster angegeben sind.  Die Zahl neuer
Einheiten jedes Einheitstyps, die in einer Provinz pro Jahr rekrutiert
werden können, ist beschränkt.  Diese Limits werden im
Mobilisierungsfenster und in Informationsfenstern über Provinzen angegeben.

b) durch Zahlen von Talenten und Verbrauchen von Ersetzungspunkten

Wenn die Macht diesen Weg benutzen muß (oft von nicht-römischen
zivilisierten Staaten benutzt), muß die Macht zusätzlich zu a) soviele
Ersetzungspunkte ausgeben, wie der Stapelwert des Einheitstyps angibt.
Eine Macht erhält alle drei Monate so viele Ersetzungspunkte, wie es ihrer
Ersetzungsrate entspricht.

c) durch Verbrauchen von Ersetzungspunkten

Wenn die Macht diesen Weg benutzen muß (meistens kleine und barbarische
Mächte), muß die Macht keine Talente zahlen.  Zusätzlich zu b) kann sie nur
verlorene Einheiten ersetzen und erhält auch nur dann Ersetzungspunkte,
wenn sie Einheiten verloren hat.

Während der Steuerphase kann jede Macht Talente zu einer alliierten Macht
transferieren, indem sie den Menüpunkt 'Transfer talents' im Menü
'Diplomacy' wählt und dann die Macht anwählt, von dessen Schatz die Talente
abgezogen werden sollen, und die Macht, zu dessen Schatz die Talente
hinzugefügt werden sollen.  Die Zahl der zu transferierenden Talente kann
mit einem Schiebebalken bestimmt werden.  Allierte Mächte kämpfen zusammen,
können eine Belagerung in jeder allierten Stadt annehmen und in jedem
allierten Hafen ankern.  Man schließt eine Allianz, indem man den Menüpunkt
'Declare alliance' im Menü 'Diplomay' anwählt.  Dann muß man die zwei
großen Mächte auswählen, die sich verbünden wollen.  Eine Allianz schließt
immer auch alle Klientelstaaten der große Mächte ein.  Während der
Steuerphase kann eine Allianz von jedem Verbündeten beendet werden.  Dann
wird der alte Zustand der Beziehungen (meistens ein feindlicher)
wiederhergestellt.






                                - 8 -


III. Seephase

Während der Seephase sind alle Operationen mit Flotten erlaubt.  Nur in
dieser Phase werden Informationsfenster über Flotten um sechs Rechtecke,
die die Nummern der Hexes, die an das Hex angrenzen, wo sich die Flotte
momentan befindet, enthalten, erweitert.  Wenn die Nummer blau ist, kann
die Flotte zu diesem Hex kommandiert werden, indem man dieses Rechteck
anklickt, wenn die Nummer weiß ist, kann man dies nicht, weil die beiden
Hexes nicht zur See verbunden sind.  Wenn eine Flotte sich bewegt, muß sie
Bewegungspunkte ausgeben.  In Informationsfenstern über Hexes steht die
Zahl der Bewegungspunkte, die ausgegeben werden müssen, um von diesem Hex
in eine mögliche Richtung zu ziehen, hinter dem Namen des Landschaftstyps.
Falls es zwei Listen von Nummern gibt, dann ist die erste für
Landbewegungen und die zweite für Seebewegungen.  Eine Flotte kann pro
Monat 30 Bewegungspunkte benutzen.  Im Winter sind die Kosten für
Seebewegungen doppelt so hoch wie im Sommer.

Um längere Distanzen auf dem kürzesten Weg (gemessen in Bewegungspunkten)
zurückzulegen, kann man das Menü 'Distance' benutzen:  Zuerst wähle man den
richtigen Menüpunkt ('By sea at winter time' oder 'By sea at summer time').
Dann wähle man wenigstens zwei Hexes.  Wenn man die Wahl der Hexes
abbrechen will, braucht man nur erneut das zuletzt gewählte Hex anwählen
oder den Menüpunkt 'Quit action' im Menü 'Utilities' benutzen.  Nur im
ersten Fall kann der Benutzer sofort eine Flotte auswählen, die dem
berechneten Weg folgt, falls dies möglich ist.  In einem speziellen Fenster
wird die minimale Zahl von Bewegungspunkten, die man braucht, um von einem
Hex zum nächsten zu gelangen, unter den Nummern dieser Hexes angezeigt.
Wenn keine Verbindung existiert, erscheint dort ein Strich.  Am rechten
Rand kann man immer die Gesamtzahl der Bewegungspunkte, die man braucht, um
vom allerersten zum allerletzten Hex zu gelangen.  So kann man einen Weg
beschreiben, indem man zwei oder mehr Hexes auswählt.  Der berechnete Weg
wird in der Karte mit Sternen ('*') markiert.  Wenn man die Option 'Show
path' im Menü 'Options' anschaltet, wird der aktuelle Weg bei jedem
Neuzeichnen der Karte markiert.  Wenn der Computer eine Verbindung zwischen
zwei Hexes erfolgreich berechnet hat, kann man diese Verbindung durch
Anwählen des Menüpunktes 'Follow track' im Menü 'Distance' benutzen.  Wenn
die Jahreszeit der Berechnung mit der Jahreszeit der Simulation übereinstimmt,
kann man eine Flotte wählen, die genügend Bewegungspunkte hat, diese Distanz
zurückzulegen.  Diese Flotte darf nicht blockiert sein; eine Flotte ist
blockiert, wenn sie in einem blockierten Hafen liegt, d.h.  es belagern
mehr Flotten den Hafen, als Flotten in diesem Hafen liegen.  Eine Flotte
kann weder in einen blockierten Hafen einlaufen noch diesen verlassen.

Eine Flotteneinheit kann Landtruppen mit maximalem Stapelwert von vier
transportieren.  Man kann Truppen einladen, wenn man den Menüpunkt 'Embark
units' im Menü 'Fleet' wählt und dann die Flotte, die die Einheiten
transportieren soll, auswählt.  Danach sieht man einen Kasten, in dem alle
Armeen der selben Macht im selben Hex wie die gewählte Flotte angezeigt
werden.  Man klickt eine Armee davon an und es erscheint ein Fenster, in
dem man Einheiten von Land zur Flotte (und umgekehrt) mit Schiebebalken
bewegen kann.  Wenn man eine General von einer Seite zur anderen bewegen
will, muß man seinen Namen anklicken.  Die Stärkewerte jeder Armee (die
übliche Reihenfolge ist:  Stärke zu Land, Stärke zur See, Stapelwert)
werden in der ersten Zeile angezeigt und ändern sich, wenn man Einheiten
von einer Seite zur anderen bewegt.  Es gibt zahlreiche Situationen, die
eine ähnliche Eingabe erfordern.

Wenn während des Einladens die Farbe der Stärkewerte der eingeladenen Armee
von Grün nach Weiß wechselt, ist die transportierende Flotte überladen, und
man muß diesen Fehler beheben, indem man Einheiten wieder zurückbewegt.
Wenn man das Rechteck mit dem Schriftzug 'OK' anklickt, werden die
Veränderungen gültig; wenn man dagegen den Schriftzug 'Quit' anklickt,
werden die Veränderungen nicht übernommen.  Wenn man in einem Hex mit einem
befreundeten Hafen Truppen auf Flotten aufnimmt, geht der Computer davon
aus, daß man den Hafen dazu benutzt und deshalb nur zwei statt sonst sechs
Bewegungspunkte verbraucht.



                                - 9 -


Man kann Truppen für zwei Bewegungspunkte in einem befreundeten Hafen
ausladen, sogar wenn dieser belagert wird, solange er nicht blockiert wird,
(Menüpunkt 'Disembark to port' im Menü 'Fleet'), oder man kann für sechs
Bewegungspunkte Truppen an der Küste ausladen (Menüpunkt 'Disembark units'
im Menü 'Fleet').  Wenn das Küstenhex nicht befreundet ist, braucht man
dazu einen General, dessen Fähigkeitswert für Seeoperationen größer gleich
zwei ist, weil es sehr schwierig ist, in ein feindliches Gebiet vom Meer aus
einzufallen.  Da nur einige Generäle in wenigen Szenarien einen
Fähigkeitswert für Seeoperationen von zwei haben, kann man diese Regel auf
Generäle mit Fähigkeitswert für Seeoperationen von eins ausweiten (Menüpunkt
'Amphibic invasion' im Menü 'Options'), um die Simulation schneller und
interessanter zu machen.  Die Bewegungserlaubnis der ausgeladenen Armee
wird für diesen Monat proportional zu den Bewegungskosten der
transportierenden Flotte reduziert, z.B:  wenn die Flotte 12 von 30
Bewegungspunkten benutzt, wird die normale Bewegungserlaubnis einer Armee
aus Legionen (20 Punkte) um (12/30)*20=8 Punkte auf 12 Punkte reduziert.
Eine Flotte braucht genug Bewegungspunkte, um Truppen ein- oder auszuladen
oder um sich zu bewegen.

Eine Flotte kann geteilt werden (Menüpunkt 'Split fleet'), Einheiten und
Flotten können zwischen zwei Flotten, die der selben Macht angehören, im
selben Hex sind und den gleichen Status haben, ausgetauscht werden
(Menüpunkt 'Exchange fleets') oder alle Flotten, die der selben Macht
angehören, im selben Hex sind und den gleichen Status haben, können
zusammengefaßt werden (Menüpunkt 'Concentrate').  Man darf aber keine
Flotte überladen.  Jede Flotte muß spätestens am Ende jedes zweiten Monats
einen Hafen anlaufen.  Wenn eine Flotte diese Bedingung nicht erfüllt, wird
sie als untergegangen betrachtet.  Wenn eine Flotte um eine oder mehr
Flotteneinheiten reduziert wird, werden möglicherweise auch Landeinheiten
entfernt, die nicht mehr transportiert werden können.  Eine Flotte, die
einen Hafen belagert (Menüpunkt 'Lay siege' im Menü 'Fleet'), muß diese
Bedingung nicht erfüllen.  Am Ende der Belagerungsphase ankert jede Flotte,
die sich in einem Hex mit einem befreundeten freien Hafen befindet,
in diesem Hafen.

Eine Flotte kann eine gegnerische Flotte angreifen (Menüpunkt 'Attack
fleet').  Der Angreifer muß die angreifende und die anzugreifende Flotte
auswählen.  Die Aufrechnung der Stärkewerte wird in einem speziellem
Fenster angezeigt.  Der Fähigkeitswert für Seeoperationen des besten
angreifenden Generals wird zu dem Ergebnis eines Würfelwurfs addiert, der
des besten verteidigenden Generals subtrahiert.  Daher ist es günstig für
den Angreifer, eine hohe Zahl zu würfeln.  Da die Moral der Soldaten sehr
wichtig ist, wird jeweils ein Punkt addiert/subtrahiert für 50 Punkte
Unterschied im Moralwert.  Ich werde nicht den kompletten Algorithmus zur
Berechnung des Ausgangs von Schlachten angeben, weil man selbst
herausfinden sollte, unter welchen Bedingungen man eine entscheidende
Schlacht wagen kann.  Die Seite, die mehr Flotten verloren hat, ist der
Verlierer und muß sich zu einem nicht-blockierten befreundeten Hafen
zurückziehen, der nicht mehr als 10 Bewegungspunkte von dem Hex entfernt
ist, wo der Kampf stattgefunden hat.  Mögliche Häfen werden dem Verlierer
angeboten.  Wenn keine Rückzugsmöglichkeit besteht, verliert der Verlierer
eine weitere Flotteneinheit und bleibt in dem Hex, wo er geschlagen wurde.
Eine Flotte darf pro Monat nur einmal angreifen.  Die Moralwerte der
beteiligten Mächte werden verändert.  Mit einer Einheit verliert die Macht
soviele Moralpunkte, wie der Stapelwert der verlorenen Einheit angibt; die
eliminierende Seite erhält die entsprechende Anzahl an Moralpunkten.  Der
Moralwert eines Generals, der nur den Namen seiner Macht und eine Nummer
trägt, ist eins plus seinen Fähigkeitswert für Landoperationen, der
Moralwert von Generälen mit Namen wird verdoppelt, der für Imperatoren
sogar mit 10 multipliziert.









                                - 10 -


Wenn der Moralwert einer Macht Null erreicht, löst sich die Macht auf.
Eine kleine Macht wird zu einem inaktiven Klientelstaat der Macht, die ihre
Auflösung verursacht hat, falls es diese gibt, sonst wird sie zu einer
kleinen neutralen Macht, deren Einheiten in ihre Provinzen zurückkehren.
Wenn eine nicht-römische Großmacht zerfällt, wird diese eine inaktive
kleine neutrale Macht.  Wenn eine römische Macht zerbricht, muß ihr
Imperator, wenn er noch im Spiel ist, abtreten.  Jede ihrer Provinzen
schließt sich der römischen Macht an, die die größte militärische Macht in
der Provinz hat oder die nächste Provinz kontrolliert.  Eine einzelne Stadt
fällt der Macht zu, die die Hauptstadt der Provinz oder die Mehrzahl der
Städte in dieser Provinz kontrolliert.  Wenn irgendeine Berechnung zu einem
Gleichstand zwischen mehreren Mächten führt, wird die Macht mit dem
höchsten Moralwert bevorzugt.  Armeen und Flotteneinheiten werden in ihrer
Stärke halbiert und schließen sich der Macht an, die die Provinz, in der
sie sich befinden, oder die nächste Provinz kontrolliert.

Die einzige Möglichkeit, auf die Aktionen des am Zug befindlichen Spielers
zu reagieren, ist, sich bewegende Armeen oder Flotten zu stören.  Wenn man
ein Störmanöver gegen Flotten versucht (Menüpunkt 'Intercept fleet' im Menü
'Fleet'), muß man die zu störende Flotte anwählen.  Diese Flotte darf sich
nicht in tiefer See befinden, da dort Operationen sehr schwierig sind und
die genaue Position einer Flotte in einem so großen Gebiet nicht bestimmt
werden kann.  Nachdem man eine Flotte ausgesucht hat, werden alle Flotten,
in befreundeten und nicht-belagerten Häfen im Umkreis von sechs
Bewegungspunkten relativ zur Position der zu störenden Flotte in einem
Fenster angezeigt.  Der Besitzer kann seinen Flotten befehlen, ein
Störmanöver zu versuchen, indem er sie anklickt.  Ein Störmanöver ist aber
nur erfolgreich, wenn die gewürfelte Zahl mindestens so groß ist wie die
Distanz zwischen der störenden und der gestörten Flotte.  Daher beträgt die
maximale Reichweite von Störmanövern sechs Bewegungspunkte.  Wenn keine
weiteren Flotten mehr stören wollen und mindestens eine Flotte erfolgreich
gestört hat, kommt es sofort zum Seegefecht, bei dem die gestörte Flotte
der Verteidiger ist.  Eine gestörte Flotte darf sich während dieses Monats
nicht weiter bewegen.


IV. Landbewegungsphase

Landbewegungen und Seebewegungen sind sehr ähnlich.

Eine sich bewegende Armee kann gestört werden (Menüpunkt 'Intercept army'),
außer wenn sie sich in einer Stadt, auf einer Flotte oder in einem
Wüsten-Hex befindet.  Wenn man diesen Menüpunkt und die zu störende Armee
gewählt hat, werden alle Armeen, die stören könnten (d.h.  alle im Umkreis
der maximalen Reichweite von Störmanövern) und von einem General geführt
werden, in einem Fenster angezeigt (vgl.  Seephase).  Die maximale
Reichweite einer Armee für ein Störmanöver beträgt sechs (höchste
Würfelzahl) plus den höchsten Fähigkeitswert für Landoperationen ihrer
Generäle.  Wenn nur Kavallerie zu stören versucht, erhöht sich die
Reichweite um drei.  Der Spieler, der zu stören versucht, muß einmal
würfeln.  Wenn die gewürfelte Zahl plus die genannten Modifikationen
mindestens so groß ist wie die Distanz zwischen den beiden Armeen, ist das
Störmanöver erfolgreich. Die gestörte Armee darf sich nicht weiter bewegen
und ist der Verteidiger in dem Landkampf, der während der folgenden
Landkampfphase automatisch gestartet wird.  Eine Armee kann nicht-belagerte
Einheiten überrennen (Menüpunkt 'Overrun' im Menü 'Army'), wenn die Stärke
der angreifenden schweren Kavallerie mindestens fünfmal größer ist als die
gesamte Stärke der Verteidiger.  Wenn es gelingt, den Gegner zu überrennen,
wird dieser völlig entfernt.  Wenn die Verteidiger eine befreundete Stadt
in ihrem Hex haben, wird davon ausgegangen, daß sie sich dorthin
zurückziehen, und können nicht überrannt werden.








                                - 11 -


V. Land Combat Phase

Am Anfang dieser Phase werden alle Kämpfe, die aus Störmanövern
resultieren, simuliert.  Danach kann man Armeen befehlen anzugreifen
(Menüpunkt 'Attack' im Menü 'Army').  Nachdem man die angreifende Armee
ausgewählt hat, werden alle gegnerischen Armeen im selben Hex in einem
Fenster angezeigt.  Wenn in dem Hex eine gegnerische Stadt existiert, wird
auch diese angezeigt.  Man wählt die anzugreifende Armee oder Stadt aus.
Wenn eine angegriffene Armee eine befreundete nicht-belagerte Stadt in
diesem Hex hat, darf sie sich in die Stadt zurückziehen und damit eine
Belagerung annehmen.  Die verteidigende Armee kann aber auch versuchen,
sich in ein benachbartes Hex zurückzuziehen, außer wenn die Stärke
feindlicher Einheiten in diesem Hex plus die Stärke feindlicher Einheiten,
die von diesem Hex aus angegriffen haben, mindestens ein Viertel der Stärke
der sich zurückziehenden Armee beträgt.  Wenn sich eine Macht zurückzieht,
wird ihr Moralwert um fünf reduziert.  Wenn angegriffene Einheiten
zurückbleiben, kommt es zur Landschlacht.  Der Computer berechnet die
gesamten Stärkewerte.  Stärkewerte von Einheiten in einer Stadt werden
verdoppelt.  Wenn die Stadt von Barbaren angegriffen wird, oder wenn die
Stadt in einer Provinz liegt, in der Holz rar und deshalb der Bau von
Belagerungsmaschinen fast unmöglich ist, werden die Stärkewerte der
Verteidiger sogar verdreifacht.  Der Befestigungswert einer angegriffenen
Stadt wird hinzuaddiert.  Der Fähigkeitswert für Landoperationen des besten
angreifenden Generals wird zu dem Ergebnis eines Würfelwurfs addiert, der
des besten verteidigenden Generals subtrahiert.  Weitere Modifikationen
werden im Informationsfenster angezeigt (vgl.  Seekampf).  Der Computer
bestimmt die Verluste, die verlierende Seite und zufällig die
Einheiten, die entfernt werden müssen.  Wenn alle Einheiten einer Armee
entfernt worden sind, werden ihre Generäle gefangengenommen.  Es kann das
plötzliche Ende einer Macht sein, wenn der Imperator oder König
gefangengenommen wird.  Wenn es mögliche Nachfolger gibt, folgen diese in
der Reihenfolge nach, die die Nummer nach den Fähigkeitswerten im
Informationsfenster über Armeen anzeigt.  Wenn keine Nachfolger mehr
vorhanden sind, erreicht der Moralwert der zugehörigen Macht den Wert Null,
und die Macht zerfällt.  Die Moralwerte der an einem Landkampf beteiligten
Mächte werden wie bei Seeschlachten verändert.  Es können so viele
Stärkepunkte unerfahrener Einheiten, die an einem Landkampf teilnehmen, zu
erfahrenen Einheiten gemacht werden, wie die gegnerische Seite stark war;
ihr Stärkewert verdoppelt sich dann.






























                                - 12 -


VI. Belagerungsphase

In der Belagerungsphase wird bei jeder Stadt, die der ziehende Spieler seit
mindestens einem Monat belagert, überpüft, ob eine belagerte Einheit
wegen der Dauer und der Umstände der Belagerung verloren geht oder nicht.
Jede Stadt hat einen Belagerungswert, der anzeigt, wie hart die Belagerung
ihre Verteidigungsfähigkeit angegriffen hat.  Dieser Wert ist gleich der
Zahl der Belagerungsmonate, aber niemals größer als sechs.  Wenn es Winter
ist, oder die Stadt in der Wüste liegt, oder die Provinz, zu der die Stadt
gehört, geplündert ist, wird dieser Wert um zwei erhöht.  Wenn die Provinz,
in der die Stadt liegt, nicht zivilisiert ist, erhöht sich der Wert um
eins. Nicht-blockierte Häfen können zwei abziehen, da Häfen viel einfacher
versorgt werden können, solange sie vom Meer aus erreichbar sind.  Alle
Modifikationen werden vom Computer zum Belagerungswert hinzugerechnet.  Der
belagernde Spieler würfelt einmal.  Wenn die gewürfelte Zahl kleiner als
der modifizierte Belagerungswert ist, wird eine Einheit von den belagerten
Armeen/Flotten entfernt.  Der Computer entfernt eine Einheit entsprechend
der folgenden Prioritätenliste:  schwere Kavallerie, leichte Kavallerie,
Flotteneinheiten, schwere Infanterie und zuletzt leichte Infanterie.  Wenn
keine Einheiten mehr zu entfernen sind, wird der Befestigungwert der Stadt
um eins erniedrigt (diese Änderung ist nur vorübergehend, der urspüngliche
Befestigungswert wird nach dem Ende der Belagerung wiederhergestellt).
Wenn der Befestigungswert der belagerten Stadt Null erreicht, hat die
Belagerung Erfolg gehabt und die eroberte Stadt wird nun dem Belagerer
zugerechnet.  Wenn die Stärke der belagernden Einheiten weniger als ein
Viertel der unveränderten Stärke der belagerten Einheiten beträgt, endet
die Belagerung mit einem Mißerfolg für die Belagerer.  Während der
Belagerungsphase kann eine Macht eine Provinz plündern, wenn sie die nicht-
belagerte Hauptstadt der Provinz mit schwerer Infanterie oder Kavallerie
kontrolliert (Menüpunkt 'Plunder' im Menü 'Army').  Die plündernde Macht
erhält den 10-fachen Steuerwert der Provinz.  Für sechs Monate darf niemand
mehr in dieser Provinz Steuern erheben oder Einheiten rekrutieren, und der
Verteidigungswert von Städten in dieser Provinz wird vorübergehend gleich
Null.  Wenn eine Macht eine Provinz plündert, die sie schon zu Anfang des
Szenarios kontrollierte, darf sie zusätzlich nie mehr dort rekrutieren und
erhält nach Ablauf von sechs Monaten nur 50% der normalen Steuereinkünfte
von dieser Provinz.  Barbarische Mächte bekommen so viele Moralpunkte, wie
es dem Steuerwert der von ihnen geplünderten Provinz entspricht.  Der
Moralwert der Macht, die die geplünderte Provinz zu Anfang des Szenarios
kontrollierte, wird um 50% des Steuerwerts der Provinz reduziert.

