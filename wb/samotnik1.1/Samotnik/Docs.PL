
          Samotnik 1.1 - Prosta gra logiczna dla Amigi (OS 2.0+)
                         Autor: Michaî Brzozowski


Dystrybucja:

                  RÓBTA CO CHCETA!!! (na wlasne ryzyko)


Wymagania:

  OS 2.0+
  Asl.library v37+


Odpalenie gry:

  a. "dwumlask" myszâ na ikonie (niespodzianka!! ;-))
  b. wklepanie komendy SAMOTNIK w CLI (powinno ruszyê)


Zasady gry:

  Chyba wiëkszoôê ludzi juû je zna, ale spróbujë je pokrótce przedstawiê.

Cel gry:      Zaczynajâc od poczâtkowego ukîadu pionków (plansza po lewej)
              naleûy doprowadziê do ukîadu takiego, jak na prawej planszy.
              Jeôli na planszy po prawej nie ma ûadnych pionków, to znaczy
              ûe na planszy ma zostaê tylko jeden pionek na dowolnym polu.

Zasady ruchu: Pionki mogâ sië poruszaê wyîâcznie przeskakujâc nad innym,
              sâsiednim w pionie lub poziomie pionkiem na znajdujâce sië
              bezpoôrednio za nim wolne pole. Powoduje to znikniëcie
              przeskakiwanego pionka.
              Ruch wykonuje sië klikajâc myszâ na pionku, który chcemy
              ruszyê, a nastëpnie na wolnym polu, na które ma skoczyê.

Obsîuga:

  Nie ma tu co opisywaê: 
    a. Odpalamy grë
    b. Jak nam sië plansza nie podoba, to wciskamy gadûet "New"
       i wybieramy tâ, która nas interesuje
    c. Gramy
    d. Bledne ruchy cofamy przez "Undo"
    e. Jak chcemy spróbowaê jeszcze raz na tej samej planszy, to wciskamy
       gadûet "Restart"
    f. Jak chcemy skoïczyê, to zamykamy okno albo wciskamy "Quit".


Tworzenie wîasnych plansz:

  Plansze do Samotnika to pliki tekstowe z rozszerzeniem .sam, które moûna
dowolnie zmieniaê. Program po uruchomieniu wczytuje plik Standard.sam, i
jeôli go nie znajdzie w aktualnym katalogu, to nie wczyta nic.
Pliki zawierajâpo dwa opisy: sytuacji poczâtkowej i koïcowej. Opis kaûdej
sytuacji zawiera sië w kwadracie 7*7 znaków.

Oznaczenia pól:

  ' ' (spacja) : pole nie naleûy do planszy
  '.' (kropka) : pole naleûy do planszy i jest puste
  '#' (hash)   : pole naleûy do planszy i jest na nim pionek

  Wszystkie pola, które naleûâ do planszy poczâtkowej, muszâ teû naleûeê
do koïcowej!

  Jeûeli zdziaîasz jakâô fajnâ planszë (rozwiâzywalnâ), to przyôlij mi jâ
PROSZË. Jestem takim beztalenciem, ûe sa nie umiem ûadnej wymyôliê
(te doîâczone do gry nie sâ moje).

Kontakt ze mnâ:

  e-mail: mbrzoza@zeus.polsl.gliwice.pl



  Michaî Brzozowski, A.D. 1996

---------------------------------------------------------------------------

HISTORIA:

  Czerwiec 1996  - wersja 1.0. Brak 'undo', nieczuîe na fonty, dostepne
                   'po polskiemu i angielskiemu'.
  Wrzesieï 1996  - wersja 1.1. Jest 'undo', Czuîe na fonty, tylko po
                   angielsku.
                   (Dla niewtajemniczonych:
                    congratulations<=>uôcisk dîoni prezesa Gminnej Spóî-
                   dzielni Drapaczy Tynku Podlaskiego :-)))))