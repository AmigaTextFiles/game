*
*   $VER: Stein 1.0  (2.5.97)  I felt like doing it.
*	  Stein 0.17 (30.8.95) Neues Datenformat
*	  Stein 0.16 (15.9.93) Heut'ist (nicht mehr) Vollmond.
*				 Heut'ist schon(nicht mehr) Neumond.

* Einige Konstanten
SPINUP	    = 2
SPINDOWN    = 0
SPINLEFT    = 1
SPINRIGHT   = 3

CheckPosMove
*
*   =>	a0  :	Stein
*	d0  :	Spalte
*	d1  :	Zeile
*	d2  :	Drehung
*   <=	d0  :	Fehler = -1
*
    push    a0-a2/d1-d7
    bsr     FetchSImage
    cmpi.b  #1,d0
    blt.s   .ohNo
    move.b  d0,d3
    add.b   2(a2),d3
    subq.b  #1,d3
    cmpi.b  #10,d3
    bgt.s   .ohNo

    move.b  d1,d3
    sub.b   3(a2),d3
    addq.b  #1,d3
    cmpi.b  #1,d3
    blt.s   .ohNo

    bsr.s   CheckFeld
    tst.b   d0
    bne.s   .ohNo
    moveq   #0,d0
.exit
    pop     a0-a2/d1-d7
    rts
.ohNo
    moveq   #-1,d0
    bra.s   .exit

CheckPosDrop
*
*   =>	a0  :	Stein
*	d0  :	Spalte
*	d1  :	Zeile
*	d2  :	Drehung
*   <=	d0  :	Fehler = -1
*
    push    a0-a2/d1-d7
    bsr     FetchSImage
    move.w  d0,d4
    move.w  d1,d5
    move.b  d1,d3
    sub.b   3(a2),d3
    addq.b  #1,d3
    cmpi.b  #1,d3
    blt.s   .ohNo

    bsr.s   CheckFeld
    bne.s   .ohNo
    moveq   #0,d0
.exit
    pop     a0-a2/d1-d7
    rts
.ohNo
    moveq   #-1,d0
    bra.s   .exit

CheckFeld
*   Überprüfe, ob Feld belegt
*   =>	a0  :	SteinFeld
*	a2  :	SteinImage
*	d0,d1:	Spalte/Zeile
*
*   <=	d0  :	-1 wenn belegt
    push    a0-a2/d1-d7
    move.b  (a0),d7
    move.w  d0,d5
    move.w  d1,d6
    moveq   #0,d4
.neueZeile
    moveq   #0,d3
.neuerPunkt
    rol.b   #1,d7
    bcc.s   .keinPunkt
    move.w  d5,d0
    add.w   d3,d0
    move.w  d6,d1
    sub.w   d4,d1

    bsr.s   GetFeld
    tst.b   d0
    bne.s   .ohNo
.keinPunkt
    addq.w  #1,d3
    cmp.b   2(a2),d3
    blt.s   .neuerPunkt
    addq.w  #1,d4
    cmp.b   3(a2),d4
    blt.s   .neueZeile

    moveq   #0,d0
.exit
    pop     a0-a2/d1-d7
    rts
.ohNo
    moveq   #1,d0
    bra.s   .exit

SetFeld
*  Belege Feld
*
*   =>	a0  :	Stein
*	d0  :	Spalte
*	d1  :	Zeile
*	d2  :	Drehung
    push    all
    bsr     FetchSImage
    move.w  d0,d5
    move.w  d1,d6
    move.b  (a0),d7
    addq.b  #1,d2
    moveq   #0,d4
.neueZeile
    moveq   #0,d3
.neuerPunkt
    rol.b   #1,d7
    bcc.s   .keinPunkt
    move.w  d5,d0
    add.w   d3,d0
    move.w  d6,d1
    sub.w   d4,d1
    bsr.s   GetFeld
    move.b  d2,(a0)
.keinPunkt
    addq.w  #1,d3
    cmp.b   2(a2),d3
    blt.s   .neuerPunkt
    addq.w  #1,d4
    cmp.b   3(a2),d4
    blt.s   .neueZeile
.exit
    pop     all
    rts
GetFeld
*   Gibt Speicherpufferposition zurück ( whaui-whaui was für'n Wort !)
*   =>	d0  :	Spalte
*	d1  :	Zeile
*   <=	a0  :	SPP(s.o.)
*	d0  :	Inhalt von SPP
    push    d1-d2
    moveq   #31,d2
    and.l   d2,d0
    and.l   d2,d1

    subq.w  #1,d0
    subq.w  #1,d1

    move.w  d1,d2	d1*10=d1<<3+d1+d1
    lsl.w   #3,d1
    add.w   d2,d1
    add.w   d2,d1
    add.w   d0,d1
    copy.l  SpielFeld,a0
    lea     0(a0,d1),a0
    move.b  (a0),d0
    ext.w   d0
    pop     d1-d2
    rts
; wie wär's mit Alloc ?    Your wish is my command.
 loc.l SpielFeld
*    dc.l 0

CheckLines
*   Prüfe auf volle Zeilen
*
*   <=	d0  :	Anzahl voller Zeilen oder -1 wenn Game over
*	d1  :	Bitset volle Zeilen
    push    d2-d5/a0-a2
    moveq   #19,d1
    moveq   #1,d2
.check
    move.w  d2,d0
    bsr.s   GetFeld
    tst.b   d0
    bne.s   .Line19Used
    addq.b  #1,d2
    cmpi.b  #10,d2
    bls.s   .check

    moveq   #1,d1   Zeilenzähler
    moveq   #0,d3   Zeilen voll
    moveq   #0,d5   Zeilennr. ( ähnlich PlanePick) mit gesetzten Bits
.doline
    moveq   #1,d2   Spaltenzähler
.dopunkt
    move.w  d2,d0
    bsr.s   GetFeld
    beq.s   .nextline
.nextpunkt
    addq.w  #1,d2
    cmpi.b  #10,d2
    bls.s   .dopunkt
    addq.w  #1,d3
    bset    d1,d5
    pea     -9(a0)
.nextline
    addq.w  #1,d1
    cmpi.b  #18,d1
    bls.s   .doline

    move.w  d3,d4
    tst.b   d3
    beq.s   .exit
    subq.w  #1,d3
    moveq   #10,d0
    moveq   #18,d1
    bsr.s   GetFeld
    move.l  a0,a2
.loop
    move.l  (sp)+,a0
.copyloop
    move.w  10(a0),(a0)
    addq.l  #2,a0
    cmp.l   a2,a0
    blt.s   .copyloop
    dbra    d3,.loop

.exit
    move.w  d4,d0
    move.w  d5,d1
    pop     d2-d5/a0-a2
    rts
.Line19Used
    moveq   #-1,d4
    bra     .exit
 bloc FeldMatrix,200
InitFeld
*
*   Speicher anfordern
*
    lea     FeldMatrix(a4),a0
    reloc.l a0,SpielFeld
CleanUpFeld
*
*   Speicher freigeben
*
    rts
AufbauFeld
*   Feldaufbau aus DatenFeld
*
    push    d0-d3/a0-a1
    copy.l  CRastPort,a1
    moveq   #1,d1
.loop
    moveq   #1,d3
.loop2
    move.w  d3,d0
    bsr     GetFeld
    tst.b   d0
    beq.s   .clear
    move.w  d0,d2
    subq.w  #1,d2
    move.w  d3,d0
    bsr     PutKlotz
    bra.s   .next2
.clear
    move.w  d3,d0
    bsr     DelKlotz
.next2
    addq.w  #1,d3
    cmpi.b  #10,d3
    bls.s   .loop2
    addq.w  #1,d1
    cmpi.b  #18,d1
    bls.s   .loop
    pop     d0-d3/a0-a1
    rts

SetStein
*   Setze Stein
*   =>	a0 : Stein
*	d0 : Spalte
*	d1 : Zeile
*	d2 : Drehung
    push    d0-d7/a0-a3
    lea     PutKlotz(pc),a3
    bra.s   SetClearStein
ClearStein
*   Lösche Stein (vielleicht noch gemeinsame U-Routine für Set & Clear ?)
*   =>	a0 : Stein
*	d0 : Spalte
*	d1 : Zeile
*	d2 : Drehung
    push    d0-d7/a0-a3
    lea     DelKlotz(pc),a3
SetClearStein
* hier ist sie (mit zwei Jahren Verspätung )
    bsr     FetchSImage
    move.b  (a0),d7
    move.w  d0,d5
    move.w  d1,d6
    moveq   #0,d4
.neueZeile
    moveq   #0,d3
.neuerPunkt
*    rol.b   #1,d7
    add.b   d7,d7
    bcc.s   .keinPunkt
    move.w  d5,d0
    add.w   d3,d0
    move.w  d6,d1
    sub.w   d4,d1

    cmpi.b  #1,d1
    blt.s   .keinPunkt
    cmpi.b  #18,d1
    bgt.s   .keinPunkt

    copy.l  CRastPort,a1
    jsr     (a3)
.keinPunkt
    addq.w  #1,d3
    cmp.b   2(a2),d3
    blt.s   .neuerPunkt
    addq.w  #1,d4
    cmp.b   3(a2),d4
    blt.s   .neueZeile
.ohNo
    pop     d0-d7/a0-a3
    rts

SetNXStein
*  Next-Feld Verwaltung
*   =>	a0 : Stein
*
    push    all
    move.l  a0,a2
    lea     NXBorders,a1
    move.w  (a1)+,d0
    move.w  (a1)+,d1
    move.w  (a1)+,d2
    move.w  (a1)+,d3
*    copy.l  TSize,d5
*    add.l   d5,d1
*    add.l   d5,d3
    GZZ
    GZZ2
    moveq   #BOX_RECESSED,d4
    copy.l  CRastPort,a1
    bsr     OSzweinullBorder		    ; erst löschen
    move.l  a2,a0
    moveq   #0,d0
    moveq   #3,d1
    moveq   #SPINDOWN,d2
    bsr     FetchSImage
    move.b  (a0),d7
    move.w  d0,d5
    move.w  d1,d6
    moveq   #0,d4
.neueZeile
    moveq   #0,d3
.neuerPunkt
    rol.b   #1,d7
    bcc     .keinPunkt
    move.w  d5,d0
    add.w   d3,d0
    move.w  d6,d1
    sub.w   d4,d1

    copy.l  CRastPort,a1
    bsr     PutNXKlotz
.keinPunkt
    addq.w  #1,d3
    cmp.b   2(a2),d3
    blt     .neuerPunkt
    addq.w  #1,d4
    cmp.b   3(a2),d4
    blt     .neueZeile

    pop     all
    rts
FetchSImage
*   holt SteinImage
*   =>	a0  :	Stein
*	d0,d1,d2 : s.o.
*   <=	a0  :	Steinfeld
*	a2  :	SImage
*	d0,d1:	+Offset
*	d2  :	Farbe
    andi.w  #3,d2
    add.w   d2,d2
    move.w  0(a0,d2),d2         SteinImage
    lea     0(a0,d2),a2
    move.b  8(a0),d2            Neue Farbe
    tst.b   IsBW(a4)
    beq.s   .notoneplane
    andi.b   #1,d2
.notoneplane
    lea     4(a2),a0
    add.b   0(a2),d0        Left addieren
    ext.w   d0
    sub.b   1(a2),d1        Top  subtrahieren
    ext.w   d1
    rts
GetSteinAdr
*   Stein-Adresse
*   =>	d0  :	Steinnummer 0..6
*   <=	a0,d0:	 Stein-Struktur
*
    push    d1
    moveq   #7,d1
    and.l   d1,d0
    move.l  d0,d1
    lsl.l   #3,d0
    add.l   d1,d0
    add.l   d1,d0
    lea     Steine(pc,d0),a0
    move.l  a0,d0
    pop     d1
    rts
* Daten
Steine
*
*   Struct Stein {
*	PTR  SteinImage[4] relativer Ptr (zum Anfang der Struktur)
*	BYTE Farbe }
*
*
*   SteinImage0: unten
*	      1: links
*	      2: oben
*	      3: rechts
*   Struct SteinImage { UBYTE Left,Top,width,height; BITS Steinfeld[width,height] }
*

*Klotz
Stein0
    dc.w Image00-Stein0
    dc.w Image00-Stein0
    dc.w Image00-Stein0
    dc.w Image00-Stein0
    dc.b GrauKLOTZ
    even
* Stange
Stein1
    dc.w Image10-Stein1
    dc.w Image11-Stein1
    dc.w Image10-Stein1
    dc.w Image11-Stein1
    dc.b GrauBlauKLOTZ
    even
* T-Stück
Stein2
    dc.w Image20-Stein2
    dc.w Image21-Stein2
    dc.w Image22-Stein2
    dc.w Image23-Stein2
    dc.b BlauKLOTZ
    even
* L-Stück
Stein3
    dc.w Image30-Stein3
    dc.w Image31-Stein3
    dc.w Image32-Stein3
    dc.w Image33-Stein3
    dc.b SchwarzBlauKLOTZ
    even
* L-invers-Stück
Stein4
    dc.w Image40-Stein4
    dc.w Image41-Stein4
    dc.w Image42-Stein4
    dc.w Image43-Stein4
    dc.b WeissBlauKLOTZ
    even
* Z-Stück
Stein5
    dc.w Image50-Stein5
    dc.w Image51-Stein5
    dc.w Image50-Stein5
    dc.w Image51-Stein5
    dc.b SchwarzGrauKLOTZ
    even
* Z-invers-Stück
Stein6
    dc.w Image60-Stein6
    dc.w Image61-Stein6
    dc.w Image60-Stein6
    dc.w Image61-Stein6
    dc.b WeissGrauKLOTZ
    even
Image00
    dc.b 1,1,2,2
    dc.b %11110000
Image10
    dc.b 0,1,4,1
    dc.b %11110000
Image11
    dc.b 1,0,1,4
    dc.b %11110000
Image20
    dc.b 0,1,3,2
    dc.b %11101000
Image21
    dc.b 0,0,2,3
    dc.b %01110100
Image22
    dc.b 0,0,3,2
    dc.b %01011100
Image23
    dc.b 1,0,2,3
    dc.b %10111000
Image30
    dc.b 0,1,3,2
    dc.b %11110000
Image31
    dc.b 1,0,2,3
    dc.b %11010100
Image32
    dc.b 0,0,3,2
    dc.b %00111100
Image33
    dc.b 0,0,2,3
    dc.b %10101100
Image40
    dc.b 0,1,3,2
    dc.b %11100100
Image41
    dc.b 0,0,2,3
    dc.b %01011100
Image42
    dc.b 0,0,3,2
    dc.b %10011100
Image43
    dc.b 1,0,2,3
    dc.b %11101000
Image50
    dc.b 0,1,3,2
    dc.b %11001100
Image51
    dc.b 0,1,2,3
    dc.b %01111000
Image60
    dc.b 0,1,3,2
    dc.b %01111000
Image61
    dc.b 0,0,2,3
    dc.b %10110100

    EVEN
