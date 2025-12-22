                                                               
                   /~\\\\                                      
                   |    |                                      
                   |    |                                      
                   | -- |                                      
                  (  OO  )                                     
                                                               
                   |  ] |                                      
                   |    |                                      
                   | -- |                                      
                   |    |                                      
-------------oOOo---\--/---oOOo--------------------------------
                                                               
                                                               
   J.Kluever@amtrash.comlink.de                                
   J.Kluever@ithh.zer.sub.org                                                            
                                                               
---------------------------------------------------------------
                                                               
                                                               



		Informationen über neue Battle Isle Level
      -----------------------------------------


		!! Version 1.0 !!   vom 16-05-94



Dieses README besteht aus folgenden Kapiteln :

	- Einleitung
	- Daten zum Programm `Battle Field Creator`
	- Aufbau der Battle Isle Level
	- Installation der neuen Maps (Spielfelder)
	- Probleme beim Umkopieren der Maps bei BI und Data Disk 1
	- Batchfile zum problemlosen Umkopieren
	- Batchfile bei Moon
	- Plazierung der erstellten Level
	- Ein eigenes Brett ?
	- Besitzer des BFC
	- Abschlussbesprechung




	- Einleitung



Liebe Battle Isle Spieler



Mit dem `Battle Field Creator` folgend BFC genannt erhalten wir
Hex-Feld Krieger ein hervorragendes Programm das sich durch seine 
grafische Oberfläche auszeichnet und uns die Gelegenheit gibt,
neue Spielflächen zu erstellen und zu erobern. 
Für alle Spieler die diesen Editor nicht besitzen, folgt hier eine
kleine Beschreibung, wie die neuen Level gehandhabt werden.
Die Autoren dieses Textes haben ihre Arbeit freiwillig und ohne 
kommerziellen Anspruch nach bestem Wissen getätigt.
Es besteht natürlich zu keiner Zeit und aus keinem Grund ein 
rechtlicher Anspruch für den Fall das mal etwas schiefgeht, das
Programm Battle Isle abstürzt oder das die Platte neu validiert wird
oder etwas ähnliches.
Die Autoren lehnen im Voraus alle Schadensansprüche ab.

Nach diesen unfreundlichen Zeilen nun aber ab in die Welt von 
Battle Isle mit neuen Welten. 


Joerg Kluever       Dirk Nowak
  
---------------------------------------------------------------


	- Daten zum Programm `Battle Field Creator`

Der Battle Field Creator ist eine kommerzielle Software der Firma
`The Software Society` die in Ladengeschäften leider nicht erhältlich
ist. Sie kann telefonisch bestellt werden unter :

               The Software Society 
               Schwarzachstrasse 41
               88214 Ravensburg
               Tel.: 0751/67806 


-----------------------------------------------------------------


	- Aufbau der Battle Isle Level
    
     ( Dieser Text stammt von Dirk Nowak, Hamburg )


Ein BI-Level besteht aus 3 bzw. 4 Files. Dies gilt nur für BI Normal
und die Data Disk 1 (Wueste, ab sofort DD1).

Die Beschreibung bezieht sich momentan auf die jeweiligen Disketten 
Versionen (analog dazu Festplattenversionen).

Das Einspieler Level
--------------------
Das Einspieler Level besteht aus 4 Files:

	.. COM
	.. FIN
	.. SHP
	.. PMP

Das COM File legt den Computerspieler und auch das Passwort fest.
Das heisst, das numerisch kleinste COM File ist das erste Einspieler
Level. Für NORMAL  gilt also:
   
   16.COM
   16.FIN
   16.SHP
   16.PMP

bilden das erste Einspieler Level mit dem Passwort  `CONRA` (NORMAL)
                                                     
Analog dazu gilt: 
   
	23.COM
	23.FIN
	23.SHP
	23.PMP

bilden das beispielsweise das 8. Level              `VESUV` (NORMAL)
									                         

Bei der DD1 gibt es aber nur 8 Zweispieler Level 
demnach gilt bei DD1 :


   08.COM
   08.FIN
   08.SHP
   08.PMP

bilden das erste Einspieler Level mit dem Passwort  `BLOCK` (DD1)
Von da aus kann wohl jeder selber zählen, es gibt bei
der DD1 24 Einzelspieler Karten.


Die Levelcodes der Battle Isle Saga sollten jedem hinreichend
bekannt sein. 

Auf die Files FIN, SHP und PMP wird hier nicht weiter eingegangen,
da sie durch den Battle Field Creator erzeugt werden.

 
!!!Wichtig!!!

Es ist zwingend notwendig ALLE 4 Files zusammen im MAP-Verzeichnis
zu ersetzen (siehe -Installation der neuen Maps)


Das Zweispieler Level
---------------------

Das Zweispieler Level besteht aus 3 Files.

Es fehlt lediglich das COM File da ein Computergegner anscheinend
nicht vorhanden ist. Die Passwort Information befindet sich hier
im SHP File.
 
Das erste Zweispieler Level ist demnach die numerisch kleinste
Dreier File Gruppe ohne COM File.

	
Für Normal und DD1 gilt also:

	00.FIN
	00.SHP
	00.PMP

bilden das erste Zweispieler Level mit dem Passwort `FIRST` (Normal)
                                                    `Clock` (DD1)




-> Bei der Data Disk 2 (Moon) fehlt lediglich das PMP File.
   (Warum auch immer)
   
	Die Level bestehen also aus 2 bzw. 3 Files. Der Aufbau der Level
	ist jedoch identisch!

   Zu beachten ist jedoch, daß die Einspieler Level hier mit 
   
   00.COM, SHP und FIN beginnen und die Zweispieler Level ab
   
   24.SHP und FIN (denn ein COM File gibt es auch hier nicht, logisch) 

-------------------------------------------------------------------


	- Installation der Maps

     ( Dieser Text stammt von Dirk Nowak, Hamburg )

Die Installation der Spielfelder ist denkbar einfach

   1. Eine Sicherungskopie der Battle Isle Diskette (die mit den
      Maps natürlich, es ist die zweite).
      (Festplattenbesitzer : Umbenennung des bestehenden Verzeichnisses
      MAP in MAP.OLD, Ein neues Verzeichnis MAP generieren (MAKEDIR MAP)).
   2. Mit einem FileCopy-Programm die neuen Levels  (ALLE FILES!!!)
      in das neue MAP Verzeichnis kopieren. Es ist ratsam bei Erhalt
      von nur EINIGEN neuen Files z.B. 08, 09 und 12 die freibleibenden
      Plätze z.B 10, 11, 13 ...	aus dem originalen MAP Verzeichnis
      (hier MAP.OLD) zu ergänzen, bzw. aufzufüllen.
      !!! WICHTIG !!! Dies verhindert bei Angabe eines falschen
      Passworts einen zugegebener Maßen, harmlosen Absturz.
      Die Files mit der Nummer 00.FIN, 00.SHP und 00.PMP des originalen
      MAP Verzeichnisses sind wichtig und sollten stets vorhanden sein !
      Sollten aus dieser oder einer anderen Quelle Zweispieler Level kommen
      !!! BITTE die FileGruppe 00.XXX unverändert lassen !!! 
   3. Programm starten und die allerorts bekannten Passworte eingeben.
      Siehe hierzu -Aufbau der Battle Isle Level.
   4. Spielen


----------------------------------------------------------------------




	- Probleme beim Umkopieren der Maps bei BI und Data Disk 1


Wer NORMAL und gleichzeitig die DD1 auf einer Festplatte hat, wird fest-
gestellt haben, daß die Files ein Resourcen-Sharing betreiben.
Das heisst, die Map-Files werden je nach dem, welche Version zuletzt
gespielt wurden, umkopiert.
Nun muß bei der Installation natürlich darauf geachtet werden daß das
RICHTIGE MAP-Verzeichnis eingebunden wird.
Profis, die beide Versionen haben, wissen warscheinlich was ich meine.
Abhilfe schafft hier ein Batchfile (siehe Batchfile zum problemlosen
Umkopieren.


!!**** Dieser Text wird ergänzt  ****!!



-----------------------------------------------------------------------


	- Batchfile zum problemlosen Umkopieren



Das Batchfile zum problemlosen Umkopieren existiert bereits und befindet
sich in einer Testphase. Wenn die Tests abgeschlossen sind, wird es
irgendwann ein Teil des Archives.

 

!!**** Dieser Text wird ergänzt  ****!!


-----------------------------------------------------------------------



	- Batchfile bei Moon


!!**** Dieser Text wird ergänzt  ****!!


-----------------------------------------------------------------------




	- Plazierung der erstellten Level


Die Archive werden momentan in dem Brett /FRAS/MINI-BINS gelagert
da habt ihr ja auch dieses hier her.

Der Filename ist jeweils BILevelx.lha
wobei x für die neueste Version steht.
Das erste Archiv ist demnach 

	BILevel1.lha

das zweite

	BILevel2.lha

und so weiter....

Wenn andere auch ihre selbst erstellten Level irgendwie parken wollen,
sollten sie sich einen eigenen Namen ausdenken, oder mir die Levels
zuschicken, ich nehme sie dann ohne Garantie allerdings unter Angabe
des Verfassers mit auf. Beispiel FRED FISH.
Vielleicht gibt es ja einmal ein eigenes Brett. 


-----------------------------------------------------------------------


	- Ein eigenes Brett ?


Ein eigenes Brett wäre vermutlich eine gute Sache, allerdings nur
wenn genug Zuspruch vorhanden ist.
Die Sysopse unter euch oder auch Co-Sysopse sollten sich mal Gedanken 
machen und mir ihre Vorstellungen mitteilen.



-----------------------------------------------------------------------



	- Besitzer des BFC


Stolze Besitzer des BFC sollten sich mal bei mir melden zwecks 
gemeinsamer Tauschgeschäfte oder möglicher Kooperation bei der
Verwaltung dieser schönen Idee.


-----------------------------------------------------------------------


	- Abschlussbesprechung


Zum Abschluss gibt`s nicht viel zu sagen.
Ich hoffe, das alle ein bischen Spass haben und ein paar
vergnügte Stunden an ihren Böcken verbringen, wir hatten 
jedenfalls eine ganze Menge.
Schreibt mir eure Erfahrungen, Gedanken und Wünsche oder auch 
Verbesserungen für die Gestalltung oder die Anleitung.
Als DFÜ Anfänger bekomme ich gerne mal Post.


Also bis bald



     JOERG 
