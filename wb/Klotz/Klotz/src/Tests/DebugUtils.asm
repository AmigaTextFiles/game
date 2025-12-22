*
*   $VER: DebugUtils.asm 1.2 (9.10.94)
*			 1.0 (17.7.93)
*

CreateOut
*
*  Öffne Fenster für Debugging
*
    push    all
    CDOS    Output
    move.l  d0,d1
    beq     .needwin
    CALL    IsInteractive
    tst.l   d0
    bne     .ende
.needwin
    lea     DebugWin(pc),a0
    move.l  a0,d1
    move.l  #MODE_OLDFILE,d2
    CALL    Open
    move.l  d0,d1
    beq     .ende		Kein Fenster, schnief !
    CALL    SelectOutput
    move.l  d0,d1
    beq     .ende
    CALL    Close
.ende
    pop     all
    rts
LongOut
*
*   => 4(sp) Zahl zum Ausgeben
*
    link    a5,#0
    push    d0-d3/a0-a2/a6
    lea     8(a5),a1
    lea     FmtHex(pc),a0
OutCont
    move.l  a0,d1
    move.l  a1,d2
    CDOS    VPrintf
    tst.l   d0
    bpl     .outok
    clra.l  a0			    Fehler beim Ausgeben
    CINT    DisplayBeep 	    ( 9.10.94)
.outok
    pop     d0-d3/a0-a2/a6
    move.l  4(a5),8(a5)
    unlk    a5
    addq.l  #4,sp
    rts
StringOut
    link    a5,#0
    push    d0-d3/a0-a2/a6
    lea     8(a5),a1
    lea     FmtStr(pc),a0
    bra     OutCont
FmtHex	 dc.b	'$%08lx',10,0
FmtStr	 dc.b	'%s',10,0
DebugWin dc.b	'CON:10/10/600/100/Debug Output/AUTO/CLOSE/WAIT',0
    cnop    0,4

