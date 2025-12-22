// Hier habe ich mal sämtliche Definitionen untergebracht, weil ich im eigentlichem Main-Source
// nicht mehr durchgeshen habe
// @1998 Dreamworlds Development / Stefan Schulze / Thomas Schulze 

  // Timing-Konstante

  #define Timing 3

  // Definitionen der Grafikbank

  #define BlFighter (GfxTab)      // blauer Fighter
  #define GrFighter (GfxTab+15)   // grüner Fighter
  #define BlBomber (GfxTab+30)    // blauer Bomber
  #define GrBomber (GfxTab+39)    // grüner Bomber
  #define ExploFr1 (GfxTab+48)    // Explosion Frame 1
  #define ExploFr2 (GfxTab+372)   // Explosion Frame 2
  #define ExploFr3 (GfxTab+696)   // Explosion Frame 3
  #define ExploFr4 (GfxTab+1020)  // Explosion Frame 4
  #define SmokeFr1 (GfxTab+1344)  // Rauch Frame 1
  #define SmokeFr2 (GfxTab+1353)  // Rauch Frame 2
  #define SmokeFr3 (GfxTab+1362)  // Rauch Frame 3
  #define SmokeFr4 (GfxTab+1387)  // Rauch Frame 4
  #define SmokeFr5 (GfxTab+1436)  // Rauch Frame 5
  #define Mauer (GfxTab+1485)     // Steinwand
  #define BlLaser (GfxTab+1521)   // Laserkanone des blauen Spielers
  #define GrLaser (GfxTab+1557)   // Laserkanone des grünen Spielers
  #define Schild (GfxTab+1593)    // Schildgenerator
  #define BlEnerg (GfxTab+1629)   // Energiezufuhr des blauen Spielers
  #define GrEnerg (GfxTab+1665)   // Energiezufuhr des grünen Spielers
  #define EnergZahl (GfxTab+1701) // Offsets der Zahlen für die Energieanzeige
  #define NormalZahl (GfxTab+2701)// Offsets der normalen Zahlen für die Raumeranzeige
  #define AktivZahl (GfxTab+3701) // Offsets der aktiven Zahlen für die Raumeranzeige
  #define BefehlZahl (GfxTab+4701)// Offsets der befehlierten Zahlen für die Raumeranzeige
  #define BlWinner (GfxTab+5701)  // Schriftzug Winner in Blau
  #define GrWinner (GfxTab+7758)  // Schriftzug Winner in Grün
  #define BlLooser (GfxTab+6755)  // Schriftzug Looser in Blau
  #define GrLooser (GfxTab+8812)  // Schriftzug Looser in Grün
  #define DrawGame (GfxTab+9815)  // Schriftzug DrawGame (unentschieden)

  // Objektdefinitionen  (für struct Objekt.Typ)

  #define Frei 0
  #define Funke 1
  #define Explosion 2
  #define Rauch 3

  // Fliegerdefinitionen  (für struct Raumer.Typ)

  #define Tot 0
  #define Fighter 1
  #define SFighter 2
  #define Bomber 3
  #define SBomber 4

  // Befehldefinitionen (für struct Raumer.Befehl)

  #define Nichts 0
  #define Heimwaerts 1
  #define Anhalten 2
  #define Umweg 3         // Nur für Heimwaerts, falls direkter Weg versperrt ist

  // Frontendefinitionen  (für struct Raumer.Seite)

  #define Gruen 0
  #define Blau 1

  // Standartlebensdauer eines Objekts (für struct Objekt.MaxZeit)

  #define LBStFunken 14
  #define LBStExplo 7
  #define LBStSmoke 6

  // Definition der Explosionsgrößen

  #define Mini 5
  #define Winzig 1
  #define Mittel 2
  #define Gross 3
  #define GeradezuUnglaublich 4

  // Bombengrößen (struct Bombe.Typ)

  #define BoNormal 1
  #define BoSuper 2

  // LaserDefs

  #define LA_Normal 1              // Typen
  #define LA_Stark 2
  #define LA_DaNormal 3            // Anim-Dauer
  #define LA_DaStark 4

  // Laser-Stationen-Defs

  #define LS_MaxEnergie 80         // Maximale Energie
  #define LS_SchussEntf 120        // Maximale Schussreichweite
  #define LS_kaputt 30             // Grenze, bis zu der die LS noch funktioniert

  // Definitionen für AHI-Quatsch

  #define CHANNELS   4             // Anzahl der Kanäle
  #define MAXSAMPLES 8             // Max. Anzahl der Samples
  #define INT_FREQ   50            // ?????????? :}

  // Sample-Definitionen

  #define SND_StatLaser SmpID[0]   // Sample: Stationslaser
  #define SND_BombExplo SmpID[1]   // Sample: Bombenexplosionen
  #define SND_RaumerExplo SmpID[2] // Sample: Fliegerexplosionen (und anders)
  #define SND_FightLaser SmpID[3]  // Sample: Fighterlaser
  #define SND_SFightLaser SmpID[4] // Sample: Laser des Superfighters
  #define SND_BombShot SmpID[5]    // Sample: Abschuss einer Bombe
  #define SND_Schaf SmpID[6]       // Sample: MÄÄÄÄÄÄÄÄÄÄH!
  #define SND_Knaller SmpID[7]     // Sample: Startsample

  // ------------------------------------------------------------------------------------------------

#ifndef TILT

  #define TILT TRUE

  // Struktur für Objektmanagement

  struct Objekt {
      UBYTE Typ;        // Typ des Objekts (Frei/Funke/Explosion/Rauch)
      LONG Zeit;        // noch verbleibende Lebenszeit
      LONG MaxZeit;     // maximale Lebenszeit (dadurch wird dann das akt. Frame berechnet)
      LONG RealX;       // X-Koordinate in 256steln eines Pixels
      LONG RealY;       // Y-Koordinate in 256steln eines Pixels
      LONG KursX;       // Der Kurs in X-Richtung in 256steln eines Pixels
      LONG KursY;       // Der Kurs in Y-Richtung in 256steln eines Pixels
      LONG Pause;       // Wartezeit in Schritten bis zum Ausbruch
  };

  // Struktur zur Verwaltung aller bewegbaren Übeltäter

  struct Raumer {
      UBYTE Typ;        // Typ des Raumes (Tot/Fighter/SFighter/Bomber/SBomber)
      UBYTE Seite;      // Welcher Mannschaft gehört er an (Gruen/Blau)
      UBYTE Befehl;     // Befehl des Raumers (Nichts, Heimwaerts, Anhalten, Umweg)
      UBYTE GerAktiv;   // Wurde er gerade eben aktiviert/deaktiviert (wegen Pause, sonst -> Zu schnelles Drücken)
      UBYTE GerBall;    // Hat der gerade geballert? (Pause bis zum nächsten Schuss)
      LONG Energie;     // aktuelle Energie des Raumers (0-MaxEnergie)
      LONG MaxEnergie;  // maximale Energie des Raumers
      LONG RealX;       // X-Koordinate des Raumers (in 256steln eines Pixels)
      LONG RealY;       // Y-Koordinate des Raumers (ebenfalls. Logo, oder?)
      LONG KursX;       // Kurs in X-Richtung (in 256steln eines Pixels)
      LONG KursY;       // Kurs in Y-Richtung (in 256steln eines Pixels)
      BOOL Aktiv;       // Ist der Fliescher gerade aktiviert (also lenkbar)?
      BOOL Raucher;     // Liegt das Rind gerade im Sterben? (also explodiert gleich)
      BOOL Ballern;     // Kann der noch bombatisieren? (gilt nur für (S)Bomber, bei Fighter immer TRUE)
  };

  struct Bombe {
      UBYTE Typ;          // Typ der Bombe (Nix/Normal/Dick)
      UBYTE Dauer;        // Lebensdauer in Schritten
      UBYTE Seite;        // Welche Seite hat die Bombe abgefeuert
      LONG  RealX;        // X-Koordinate in 256steln eines Pixels
      LONG  RealY;        // Y-Koordinate in 256steln eines Pixels
      LONG  KursX;        // X-Kurs in 256steln eines Pixels
      LONG  KursY;        // Y-Kurs in 256steln eines Pixels
  };

  struct Laser {
    LONG Typ;            // Stärke
    LONG Frame;          // Aktuelles Frame
    LONG StartX;          // Startpunkt - X-Koordinate
    LONG StartY;          // Startpunkt - Y-Koordinate
    LONG ZielX;           // Zielpunkt - X-Koordinate
    LONG ZielY;           // Zielpunkt - Y-Koordinate
  };

  struct LaserSt {
    LONG RealX;           // X-Position
    LONG RealY;           // Y-Position
    LONG Energie;         // Was die Station noch aushält
    LONG Pause;           // Pause bis zum nächsten Schuss
  };
#endif
