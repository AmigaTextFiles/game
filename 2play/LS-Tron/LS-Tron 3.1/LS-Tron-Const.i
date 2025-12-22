{ LS-Tron-Constant.i }

CONST F1       = $50;
      F2       = $51;
      F3       = $52;
      F4       = $53;
      F5       = $54;
      F6       = $55;
      F7       = $56;
      F8       = $57;
      F9       = $58;
      F10      = $59;

      Turbo    =   5;
      VeryFast =   4;
      Fast     =   3;  { Konstanten für SpeedArray (s.u.)}
      SMedium  =   2;
      Slow     =   1;
      verySlow =   0;

      suicide  =   5;
      VeryHard =   4;
      Hard     =   3;
      Medium   =   2;  { Konstanten für LevelArray (s.u.)}
      Easy     =   1;
      VeryEasy =   0;

      Tasten   =   0;
      Joy1     =   1;  { Konstanten für Steuerung }
      Joy2     =   2;

      hellgrau =   0;
      weiss    =   1;
      gruen    =   2;
      gelb     =   3;
      tuerkis  =   4;
      blau     =   5;
      rot      =   6;
      lila     =   7;
      schwarz  =   8;
      sdgrau   =  10;
      dgrau    =  11;
      mgrau    =  12;
      orange   =  13;
      dtuerkis =  14;
      gruen2   =  15;

      Deutsch  =   1;
      English  =   2;

      Error_No_Screen      =  1;
      Error_No_Window      =  2;
      Error_No_Chipmem     =  3;
      Error_No_Process     =  4;
      Error_No_Sourcedir   =  5;
      Error_No_WBMessage   =  6;
      Error_in_Configfile  =  7;
      Error_in_Filelist    =  8;
      Error_Not_All_Open   =  9;
      Error_No_Mem         = 10;
      Error_No_Grafics     = 21;
      Error_No_Reqtools    = 22;
      Error_No_Diskfont    = 23;
      Error_No_LS_Font     = 30;
      Error_Iff_Noerr      = 50;
      Error_Iff_NoMem      = 51;
      Error_Iff_Openscreen = 52;
      Error_Iff_Openwindow = 53;
      Error_Iff_Open       = 54;
      Error_Iff_WrongIff   = 55;
      Error_Iff_ReadWrite  = 56;

      MausDaten : MouseArray = (0,0,  { Für den eigenen, ganz persönlichen }
                  %0011111111111100,%0000000000000000,        { Mauszeiger }
                  %0010101111110100,%0000101111110000,
                  %0010101001001100,%0000101001001000,
                  %0010101111001100,%0000101111001000,
                  %0010100011001100,%0000100011001000,
                  %0010111111110100,%0000111111110000,
                  %0011111111111100,%0000000000000000,
                  %0000000000000000,%0001111111111000,
                  %1111111111111111,%0000000000000000,
                  %1111111111000011,%0000000000111100,
                  %1111011111111111,%0000100000000000,
                  %1111111111111111,%0000000000000000,
                        0,0);

    Koord1 : Koord = (-2,11, -2,-1,102,-1);     { Koordinaten für Borders }
    Koord2 : Koord = (-2,11,102,11,102,-1);
    Koord3 : Koord = (-2,11, -2,-1,102,-1);
    Koord4 : Koord = (-2,11,102,11,102,-1);

    Bora2:Border = (0,0,1,8,5,3,NIL,NIL);       { Borders für die Gadgets }
    Bora1:Border = (0,0,8,1,5,3,NIL,NIL);
    Borb2:Border = (0,0,8,1,5,3,NIL,NIL);
    Borb1:Border = (0,0,1,8,5,3,NIL,NIL);

    Int1 : IntuiText = (1,0,0,35,1,NIL,"Start"     ,NIL); { Intuitexts für }
    Int2 : IntuiText = (1,0,0,36,1,NIL,"Info"      ,NIL); { Na???          }
    Int3 : IntuiText = (1,0,0,23,1,NIL,"Highscore" ,NIL);
    Int4 : IntuiText = (1,0,0,18,1,NIL,"Optionen 1",NIL);
    Int5 : IntuiText = (1,0,0,18,1,NIL,"Optionen 2",NIL); { RICHTIG!!!     }
    Int6 : IntuiText = (8,0,0,37,1,NIL,"Ende"      ,NIL); { Die Gadgets    }

    GermanMain : ARRAY[1..6] OF STRING =
                  ("Start",
                   "Info",
                   "Highscore",
                   "Optionen 1",
                   "Optionen 2",
                   "Ende");

    EnglishMain : ARRAY[1..6] OF STRING =
                  ("Start",
                   "Info",
                   "Highscore",
                   " Options 1 ",
                   " Options 2 ",
                   "Quit");

    Gad10  : Gadget = (NIL,246,205,101,11,GadghImage,RelVerify,{die Gadgets }
                      BOOLGADGET,NIL,NIL,NIL,0,NIL,10,NIL);
    Gad05  : Gadget = (NIL,246,185,101,11,GadghImage,RelVerify,
                      BOOLGADGET,NIL,NIL,NIL,0,NIL, 5,NIL);
    Gad04  : Gadget = (NIL,246,165,101,11,GadghImage,RelVerify,
                      BOOLGADGET,NIL,NIL,NIL,0,NIL, 4,NIL);
    Gad03  : Gadget = (NIL,246,145,101,11,GadghImage,RelVerify,
                      BOOLGADGET,NIL,NIL,NIL,0,NIL, 3,NIL);
    Gad02  : Gadget = (NIL,246,125,101,11,GadghImage,RelVerify,
                      BOOLGADGET,NIL,NIL,NIL,0,NIL, 2,NIL);
    Gad01  : Gadget = (NIL,246,105,101,11,GadghImage,RelVerify,
                     BOOLGADGET,NIL,NIL,NIL,0,NIL, 1,NIL);

    nFont : TextAttr = ("ls.font", 8,FS_NORMAL ,FPF_DISKFONT);
                       { ein Font für den eigenen Stil... }

    LSScript : ARRAY[1..28] OF ARRAY[1..9] OF SHORT =   { Hiermit wird der }
               ((11,11,11,11,11,11,11,11,11),           { Schriftzug im    }
                (11, 5, 5, 5, 5, 5, 5, 5,11),           { Hauptmenü gemalt.}
                (11,14,11,11,15,15,15,15,11),
                (11,14,11,11,15,11,11,15,11),
                (11,14,11,11,15,11,11,15,11),
                (11,14,15,15,15,11,11,15,11),
                (11,11,11,11,11,11,11,11,11),
                (11,11,11,11, 4,11,11,11,11),
                (11,11,11,11, 4,11,11,11,11),
                (11,11,11,11, 4,11,11,11,11),
                (11,11,11,11,11,11,11,11,11),
                (11,11,11,11,11,11,11, 6,11),
                (11,11,11,11,11,11,11, 6,11),
                (11, 6, 6, 6, 6, 6, 6, 6,11),
                (11,11,11,11,11,11,11, 6,11),
                (11, 3, 3, 3, 3, 3, 3,13,11),
                (11,11,11, 3, 3,11,11, 3,11),
                (11, 3, 3,11, 3,11,11, 3,11),
                (11,11, 5, 5, 5,15,15,11,11),
                (11, 5,11,11,11,11,11, 5,11),
                (11, 5,11,11,11,11,11, 5,11),
                (11,11, 5, 5, 5, 5, 5,11,11),
                (11, 4, 4, 4, 4, 4, 4, 4,11),
                (11,11,11,11,11, 4, 4,11,11),
                (11,11,11, 4, 4,11,11,11,11),
                (11, 4, 4,11,11,11,11,11,11),
                (11, 4, 4, 4, 4, 4, 4, 4,11),
                (11,11,11,11,11,11,11,11,11));

      SpeedArray : BigArray = (5,4,3,2,1,0);       { Geschwindigkeitsdaten }
      LevelArray : Bigarray = (0,25,50,100,200,50);{ Hindernisse für Levels}
