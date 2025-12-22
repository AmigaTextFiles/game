{ LS-Tron-Types.i }

TYPE SmallArray = ARRAY[0..4] OF SHORT;
     BigArray = ARRAY[0..5] OF SHORT;
     MouseCArray = ARRAY[0..5] OF SHORT;
     MouseCArrayPtr = ^MouseCArray;
     MouseArray = ARRAY[1..28] OF SHORT;
     MouseArrayPtr = ^MouseArray;

     Control     = RECORD
                     links,
                     rechts,
                     vorne : SHORT;
                   END;
     controlPtr  = ^Control;

     Koord       = ARRAY[1..6] OF SHORT;

     Position    = RECORD
                     x,y : SHORT;
                   END;

     Strichschen = ARRAY[1..maximum] OF Position;

     ControlAray = ARRAY[1..maxPlay] OF Control;

     ColourArray = ARRAY[0..19] OF RECORD
                                     r,g,b : BYTE; { Rot-,Grün- & Blau-Werte}
                                   END;

     BackArray   = ARRAY[1..4] OF RECORD
                                    r,g,b : BYTE;
                                  END;

     linie = RECORD
               colour,
               x1,y1,
               x2,y2  : SHORT;
             END;

     Maze    = RECORD
                 MazeDir,
                 MazeName : STRING;
                 Loeschen : BOOLEAN;
                 Players  : ARRAY[1..maxplay] OF RECORD
                                                   Ist_geladen  : BOOLEAN;
                                                   Pos,Bewegung : Position;
                                                 END;
                 LineNum  : INTEGER;
                 Linien   : ^ARRAY[1..2] OF Linie;
               END;
     MazePtr = ^Maze;

     Spieler = RECORD
                 x,y,                 { Position                          }
                 mx,my,               { Bewegung (x+y)                    }
                 Score     : SHORT;   { Punkte für Sieg etc.              }
                 Strich    : Strichschen; { Wo waren wir denn mal?        }
                 Pos       : SHORT;   { Welcher Pixel soll verschwinden?  }
                 Hits      : BYTE;    { Anzahl der Gegner, die er zerstört}
                                      { hat.                              }
                 Name      : STRING;  { Name des Spielers                 }
                 Ausweicher,          { Für Computergegner                }
                 Lastleft,            { Variablen für Fehlerabfang bei    }
                 Lastright : BOOLEAN; { Joystickbenutzung                 }
                 Left      : SHORT;   { Wie ist das Verhältnis links zu r.}
                 KI        : BYTE;    { Welche Bewegungsmethode nutzt er? }
                 Turbo,               { Compi hat Turbolader?             }
                 Ok,                  { Spieler in Ordnung?               }
                 Destroyed,           { Zu nah an einer Explosion?        }
                 Complayer : BOOLEAN; { Computerspieler?                  }
                 PlControl : Control; { Tasten zur Steuerung              }
                 Steuerung : BYTE;    { Welche Art von Steuerung          }
                 ID        : BYTE;    { Spielernummer                     }
               END;
     SpielerPtr = ^Spieler;

     TronBase = RECORD
                  TronDir    : STRING;{ Verzeichnis in dem LS-Tron        }
                                      { sich befindet                     }
                  player,             { gesammte Spieleranzahl            }
                  remain,             { Spieleranzahl (noch übrig)        }
                  human,              { menschliche Spieler               }
                  Speed,              { Geschwindigkeit                   }
                  level,
                  Third,secnd,first,  { 1., 2., 3.Platz                   }
                  max_Length : SHORT; { maximale Strichlänge(0=Aus)       }
                  Players    : ARRAY[1..maxPlay] OF Spieler;{ Spielerdaten}
                  sprache    : CHAR;  { ???                               }
                  BackColour : BYTE;  { Hintergrundfarbe                  }
                  MyMaze     : Maze;  { Labyrinth-Verzeichnis und -Datei  }
                  Maze_Loaded,        { Labyrinth-Datei geladen?          }
                  Use_Maze,           { Soll Labyrinth benutzt werden?    }
                  sound,              { Sound geladen und abgespielt?     }
                  Unentschieden,      { Wurde ein Spiel o. Sieger beendet?}
                  Quitgame   : BOOLEAN; { Spiel abbrechen?                }
                END;
      TronBasePtr = ^TronBase;
