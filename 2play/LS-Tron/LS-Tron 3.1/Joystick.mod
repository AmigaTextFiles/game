EXTERNAL;

FUNCTION Joystick1 : BYTE;

  BEGIN
   {$A
        clr.l  d0
        clr.l  d1
        clr.l  d2

        move.w $dff00c,d1
        btst   #9,d1                 ;links
        beq.s  StickA
        bset   #2,d0
    StickA:
        btst   #1,d1                 ;rechts
        beq.s  StickB
        bset   #3,d0
    StickB:
        move.b d0,d2
        lsr.b  #2,d2
        btst   #8,d1                 ;oben
        beq.s  StickC
        bset   #0,d0
    StickC:
        btst   #0,d1                 ;unten
        beq.s  StickD
        bset   #1,d0
    StickD:
        btst   #7,$bfe001            ;Feuer
        bne.s  StickE
        bset   #4,d0
    StickE:
        eor.b  d2,d0
   }
  END;

FUNCTION Joystick2 : BYTE;

  BEGIN
   {$A
        clr.l  d0                   ;Register löschen
        clr.l  d1
        clr.l  d2

        move.w $dff00a,d1           ;Adresse holen
        btst   #9,d1                ;links???
        beq.s  MausA                ;Wenn nicht überspringen
        bset   #2,d0                ;Bit 2 setzen
    MausA:                          ;Sprungmarke
        btst   #1,d1                ;rechts???
        beq.s  MausB                ;Wenn nicht überspringen
        bset   #3,d0                ;Bit 3 setzen
    MausB:                          ;Sprungmarke
        move.b d0,d2                ;Register d0 nach d2 kopieren
        lsr.b  #2,d2                ;
        btst   #8,d1                ;oben???
        beq.s  MausC                ;Wenn nicht überspringen
        bset   #0,d0                ;Bit 0 setzen
    MausC:                          ;Sprungmarke
        btst   #0,d1                ;unten???
        beq.s  MausD                ;Wenn nicht überspringen
        bset   #1,d0                ;Bit 1 setzen
    MausD:                          ;Sprungmarke
        btst   #6,$bfe001           ;Feuer???
        bne.s  MausE                ;Wenn nicht überspringen
        bset   #4,d0                ;Bit 4 setzen
    MausE:                          ;Sprungmarke
        eor.b  d2,d0                ;
   }
  END;

FUNCTION BitTest(Wert,Bit : INTEGER) : BOOLEAN;

  BEGIN
   {$A
     clr.l  d0

     link   a5,#0
     move.l 8(a5),d1
     move.l 12(a5),d2
     unlk   a5

     btst   d1,d2
     beq.s  Nein
     move.b #-1,d0
    Nein:
   }
  END;
