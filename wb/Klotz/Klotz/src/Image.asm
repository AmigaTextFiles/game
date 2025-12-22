*
* $VER: Image.asm   0.15 (18.3.98) wieder images(layout)
*		    0.14 (24.7.95) mehr farben
*		    0.13 (27.2.95) Keine Images mehr
*		    0.12 (15.9.93)
*

WeissBlauKLOTZ	    equ 0
SchwarzBlauKLOTZ    equ 1
GrauBlauKLOTZ	    equ 2
GrauKLOTZ	    equ 3
BlauKLOTZ	    equ 4
SchwarzGrauKLOTZ    equ 5
WeissGrauKLOTZ	    equ 6
* ImageFarben
ImageFarben
 dc.l $00020003
 dc.l $00010003
 dc.l $00000003
 dc.l $00000000
 dc.l $00030003
 dc.l $00010000
 dc.l $00020000

PutKlotz
*  Setzt einen Klotz an die (hoffentlich) richtige Stelle
*  ALLE REGISTER BLEIBEN ERHALTEN
*   =>	a1  :	RastPort ( in a1, weil Standard für GfxLib )
*	d0  :	Spalte( 1 links  10 rechts)
*	d1  :	Zeile ( 18 oben  1 unten )
*	d2  :	FarbFlag
    push    d0-d4/a0-a1
    bsr     GetCoords
    ifne NEEDFORSPEED
* Optimierung: Klotz in Bitmap zwischenspeichern
    tst.b   IsImage(a4)
    beq.s   EinsprungNX
    push    d5/d6/a6
    move.w  d0,d2
    move.w  d1,d3
    moveq   #0,d0
    moveq   #0,d1
    copy.l  CImage,a0
    copy.l  CRastPort,a1
    copy.w  SteinWidth,d4	;  Weite
    copy.w  SteinHeight,d5	;  Höhe
    move.b  #$C0,d6		;  Minterm = Kopieren
    CGFX    BltBitMapRastPort
    pop     d5/d6/a6
    bra.s   exitput
    endc
EinsprungNX
    tst.b   IsColor(a4)
    beq.s   .noColor
    move.l  d2,d4
    copy.w  SteinWidth,d2	;  Weite
    copy.w  SteinHeight,d3	;  Höhe
    bsr     ColorBox3D
    bra.s   .exitput
.noColor
    lsl.l   #2,d2
    move.l  ImageFarben(pc,d2),d4
    copy.w  SteinWidth,d2	;  Weite
    copy.w  SteinHeight,d3	;  Höhe
    bsr     DrawBox3D
.exitput
    ifne NEEDFORSPEED
    tst.b   IsImage(a4)
    beq.s   exitput
    copy.l  CRastPort,a0
    move.l  rp_BitMap(a0),a0
    push    d5-d7
    move.w  d2,d4
    move.w  d3,d5
    moveq   #0,d2
    moveq   #0,d3
    move.b  #$c0,d6
    st	    d7
    copy.l  CImage,a1
    CGFX    BltBitMap
    on.b    IsImage
    pop     d5-d7/a6
    endc
exitput
    pop     d0-d4/a0-a1
    rts

PutNXKlotz
*   Setzt Klotz ins Next-Feld
*   ALLE REGISTER BLEIBEN ERHALTEN
*   =>	a1  :	RastPort
*	d0  :	Spalte	( 0 .. 3 )
*	d1  :	Zeile	( 3 .. 0 )
    push    d0-d4/a0-a1
    move.l  a1,a0
    push    d3
    lsl.w   #4,d0
    moveq   #90,d3
    add.w   d3,d0
    add.w   d3,d0
    subq.b  #3,d1
    neg.b   d1
    tst.b   IsLace(a4)
    beq.s   .nolace
    lsl.w   #4,d1
    bra.s   .endif
.nolace
    lsl.w   #3,d1
.endif
    moveq   #116,d3
    add.w   d3,d1
    pop     d3
    GZZ
    bra   EinsprungNX

GetCoords
*   =>	d0  :	Zeile
*	d1  :	Spalte
*   <=	d0  :	x
*	d1  :	y
    subi.b  #18,d1
    neg.b   d1
    mulu.w  SteinHeight(a4),d1
    addq.w  #4,d1	       yy=(18-y)*8+4
    subq.b  #1,d0
    mulu.w  SteinWidth(a4),d0
    addi.w  #10,d0		xx=(x-1)*16+10=x*16-6
    GZZ
    rts

DelKlotz
*   löscht Kasten
*   ALLE REGISTER BLEIBEN ERHALTEN
*   =>	a1  :	RastPort
*	d0  :	Spalte (s.o.)
*	d1  :	Zeile  ( "  )
    push    d0-d3/a0-a1/a6
    bsr.s   GetCoords
    move.w  d0,d2
    move.w  d1,d3
    add.w   SteinWidth(a4),d2       plus Weite -1
    subq.w  #1,d2
    add.w   SteinHeight(a4),d3      plus Höhe -1
    subq.w  #1,d3
    CGFX    EraseRect
    pop     d0-d3/a0-a1/a6
    rts
HiLiteLines
*
*   Volle Zeilen hervorheben (mit Complement) > 2* aufrufen
*   =>	d1  :	Bitset volle Zeilen, Bits 1..18
*
    push    d0-d5/a0-a1

    move.l  d1,d5
    moveq   #18,d4
    moveq   #0,d0   ; Oberes Wort löschen
    moveq   #0,d1
.loop
    btst    d4,d5
    beq.s   .weiter

    move.w  d4,d1   ; Zeilenende bestimmen
    subq.w  #1,d1   ; Zeile -1
    moveq   #11,d0  ; letzte Spalte +1 (=11)
    bsr.s   GetCoords ; keine Koordinatenüberprüfung
    subq.w  #1,d0   ; und wieder x-1,y-1
    subq.w  #1,d1
    move.l  d0,d2
    move.l  d1,d3

    move.w  d4,d1   ; Zeilenanfang bestimmen
    moveq   #1,d0
    bsr.s   GetCoords

    copy.l  CRastPort,a1
    bsr     InvertBox
.weiter
    subq.b  #1,d4
    bgt.s   .loop
    pop     d0-d5/a0-a1
    rts

