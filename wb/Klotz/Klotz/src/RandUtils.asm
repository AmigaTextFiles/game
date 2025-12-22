;
; $VER: RandUtils.asm	0.13 (5.1.97) SAS-multiplikativer Kongruenzgenerator
;			0.12 ( 20.9.93 )
;

 bloc RSeed,8

Randomize
*
* Setze Zufallssaat mit Uhr
*
    push    a0-a2/a6/d0-d1
    lea     RSeed(a4),a0
    lea     4(a0),a1
    move.l  a0,a2
    CINT    CurrentTime
    move.l  4(a2),d0

    IFD     RNDBG
    move.l  d0,-(sp)
    bsr     LongOut
    ENDC

    swap    d0
    add.l   d0,(a2)          Sekunden plus Micros
    pop     a0-a2/a6/d0-d1
    rts
*   Auch eine Art, etwas auszudokumentieren
    IFNE  0

FastRand
* ( aus c.lib)
*
*   <=	d0.l:	(pseudo-)Zufallszahl
*  !!! Von wegen Zufallszahl ... Absolut unbrauchbar !!!
*   Na ja ... schon besser
    push    a6
    CGFX    VBeamPos
    move.l  d0,d1
    lea     RSeed(a4),a0        [plus (0 .. 511)]
    move.l  (a0),d0
    rol.l   #1,d0		Mal sehn...
    bhi     .noexor
    eori.l  #$1d872b41,d0
.noexor
    swap    d0
    add.w   d1,d0
    move.l  d0,(a0)
    pop     a6
    rts
    ENDC
Random
*
* Andere Zufallszahlen
*
*   <= d0.l Zufallszahl aus [0 .. 999999]
    push    d1-d3
    copy.l  RSeed,d0
    move.l  d0,d2
    moveq   #98,d1
    bsr     LMul
    move.l  #10000,d1
    bsr     LMod
    moveq   #100,d1
    bsr     LMul
    move.l  d0,d3
    move.l  d2,d0
    moveq   #21,d1
    bsr     LMul
    add.l   d3,d0
    addi.l  #211327,d0
    move.l  #1000000,d1
    bsr     LMod
    reloc.l d0,RSeed
    pop     d1-d3
    rts
    ifne 0
Random2
    push    a0/d1
    copy.l  RSeed,d0
    bpl     .noneg
    neg.l   d0
    add.l   #1,d0
.noneg
    move.l  #397204094,d1
    copy.l  UtlBase,a0
    CALLx   UMult64
    add.l   d1,d1
    tst.l   d0
    bpl     .skip
    addq.l  #1,d1
    bclr    #31,d0
.skip
    add.l   d1,d0
    bpl     .skip2
    addq.l  #1,d0
    bclr    #31,d0
.skip2
    reloc.l d0,RSeed
    pop     a0/d1
    rts
    endc
RangeRand
*   Zufallszahl aus Bereich
*   =>	d0  :	Wert
*   <=	d0  :	( 0 .. Wert )
; Na das sieht schon besser aus
    push    d1-d2
    move.l  d0,d2
    addq.l  #1,d2	    Range+1
    bsr     Random
    addq.l  #1,d0
    move.l  d2,d1
    bsr     LMod	    Rest bei Div durch Range+1, also [0..Range]
    pop     d1-d2
    rts

