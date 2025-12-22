*
*   $VER: MathUtils.asm 0.2 (15.8.93)
*
* MatheFunktionen in Utility sichern alle Adress-Register
* und benötigen Base nicht in a6
CALLx macro
    xref _LVO\1
    jsr  _LVO\1(a0)
    endm

LDiv
*   Langwort-Division
*   =>	d0  :	Divident
*	d1  :	Divisor
*   <=	d0  :	Quotient
    push    a0/d1
    bsr     LDivMod
    pop     a0/d1
    rts

LMod
*   Langwort-Modulo
*   =>	d0  :	Divident
*	d1  :	Divisor
*   <=	d0  :	Modulo
    push    a0/d1
    bsr     LDivMod
    move.l  d1,d0
    pop     a0/d1
    rts
LMul
*   Langwort-Muliplikation
*   =>	d0  :	Faktor
*	d1  :	Faktor
*   <=	d0  :	Produkt
    push    a0/d1
    bsr     _FetchBase
    CALLx    UMult32
    pop     a0/d1
    rts

LDivMod
    bsr     _FetchBase
    CALLx    UDivMod32
    rts
_FetchBase
    copy.l  UtlBase,a0
    rts
*
*  FixedMath Versuche (7.10.94)
*
*   Format $xxxxyyyy, wobei xxxx Vorkomma yyyy Nachkomma in HEX
*   Noch keine negativen Werte
*   Alles Schrott ( ungetestet)
*   Na ja, Müll vielleicht
ToFixed
*  => d0.w Integer
*  <= d0.l Fixed
    swap    d0
    move.w  #0,d0   Nachkomma löschen (keine Rundung - dazu Test auf "Negativ")
    rts
FromFixed
*  => d0.l Fixed
*  <= d0.w Integer
    tst.w   d0
    bmi     .addone
    clr.w   d0
    swap    d0
    rts
.addone
    clr.w   d0
    swap    d0
    addq.w  #1,d0
    rts
FixedMul
*   => d0,d1 Fixed
*   <=	d0 : d0*d1
    push    d2-d5
    moveq   #0,d4
    moveq   #0,d5
    move.l  d0,d2
    move.w  d4,d2
    swap    d2		Vorkomma1
    move.l  d1,d3
    move.w  d5,d3
    swap    d3		Vorkomma2
    move.w  d0,d4	Nachkomma1
    move.w  d1,d5	Nachkomma2
    move.l  d3,d1
*	  Zahl1 * V2
    move.l  d3,d1
    bsr     LMul
    move.l  d0,d3
*	  V1	* N2
    move.l  d5,d0
    move.l  d2,d1
    bsr     LMul
    move.l  d0,d2
*	 (N1    * N2) >>16
    move.l  d5,d0
    move.l  d4,d1
    bsr     LMul
    move.l  d0,d4
    move.w  #0,d4
    swap    d4
    add.l   d3,d2
    add.l   d4,d2
    move.l  d2,d0
    pop     d2-d5
    rts
FixedInv
*    Scheint IO zu sein
* => d0 : Fixed
* <= d0 : 1/Fixed ( -1 für Fixed = 0)
*
    move.l  d0,d1
    lsr.l   #8,d1	    ; >>8
    beq.s   .DivDurchNull
    move.l  #$01000000,d0   ; Fixed 1<<8
    bra     LDiv
.DivDurchNull
    moveq   #-1,d0
    rts
FixedDiv
*   => d0,d1
*   <= d0/d1
    push    d0
    move.l  d1,d0
    bsr     FixedInv
    pop     d1
    bra     FixedMul
    ifne 0
FixedPow
*   => d0 : Fixed
*      d1 : Integer
    tst.l   d1
    bgt     .todo
    moveq   #1,d0
    swap    d0
    rts
.todo
    push    d2/d3
    move.l  d1,d3
    subq.l  #1,d3
    move.l  d0,d2
.loop
    move.l  d2,d1
    bsr     FixedMul
    dbra    d3,.loop
    pop     d2/d3
    rts
    endc
