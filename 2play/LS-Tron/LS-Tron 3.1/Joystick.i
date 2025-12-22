{ Joystick.i }

 { Werte von Joystick1 und Joystick2 :
      0 - nichts
      1 - oben
      2 - unten
      4 - links
      8 - rechts
     16 - Feuer
 }


FUNCTION Joystick1 : BYTE;
  EXTERNAL;

FUNCTION Joystick2 : BYTE;
  EXTERNAL;

FUNCTION BitTest(Wert,Bit : INTEGER) : BOOLEAN;
  EXTERNAL;