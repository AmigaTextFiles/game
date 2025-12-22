*
*   $VER: GfxUtils.asm	0.5 (27.2.95) ( DrawBox3D )
*			0.4 (28.8.93)
*

OSzweinullBorder
*
*   Zeichnet nette Umrahmung
*   ( man kˆnnte auch DrawBevelBox ...)
*
*   =>	a1 : RastPort
*	d0 : xmin
*	d1 : ymin
*	d2 : xmax
*	d3 : ymax
*	d4 : mode
BOX_RECESSED = 0
BOX_RAISED   = 1
BOX_HILIGHT  = 2
*BOX_NOBACK   = 8
    push    d2-d7/a2
    move.l  a1,a2
    push    d0/d1
    moveq   #0,d0
    CGFX    SetAPen
    pop     d0/d1
    move.l  a2,a1
    push    d0/d1
    CALL    RectFill
    pop     d0/d1
    cmpi.b  #BOX_HILIGHT,d4
    bne     .casenext
    push    d0-d3
    subq.w  #2,d0
    subq.w  #1,d1
    addq.w  #2,d2
    addq.w  #1,d3
    moveq   #BOX_RAISED,d4
    move.l  a2,a1
    bsr     OSzweinullBorder
    pop     d0-d3
    moveq   #BOX_RECESSED,d4
    move.l  a2,a1
    bsr     OSzweinullBorder
    bra     .end
.casenext
    cmpi.b  #BOX_RAISED,d4
    bne     .caseelse
    moveq   #2,d6		Farben zuweisen
    moveq   #1,d7		( sp‰tere Version mit Pens ? )
    bra     .selectend
.caseelse
    cmpi.b  #BOX_RECESSED,d4
    bne     .end
    moveq   #1,d6
    moveq   #2,d7
.selectend
    move.w  d0,d4
    move.w  d1,d5
*!!!					!!!
*!!!	Pixel unterer Rand links fehlt	!!! nicht mehr (aber in der Pascal-Version)
*!!!					!!!
    move.l  d6,d0
    move.l  a2,a1
    CALL    SetAPen
    move.w  d2,d0	xe+1
    addq.w  #1,d0
    move.w  d5,d1	y-1
    subq.w  #1,d1
    move.l  a2,a1
    CALL    Move
    move.w  d4,d0	x-2
    subq.w  #2,d0
    move.w  d5,d1
    subq.w  #1,d1	y-1
    move.l  a2,a1
    CALL    Draw
    move.w  d4,d0	x-2
    subq.w  #2,d0
    move.w  d3,d1	ye+1
    addq.w  #1,d1
    move.l  a2,a1
    CALL    Draw
    move.w  d4,d0	x-1
    subq.w  #1,d0
    move.w  d5,d1	y-1
    subq.w  #1,d1
    move.l  a2,a1
    CALL    Move
    move.w  d4,d0	x-1
    subq.w  #1,d0
    move.w  d3,d1	ye
    move.l  a2,a1
    CALL    Draw

    move.l  d7,d0
    move.l  a2,a1
    CALL    SetAPen
    move.w  d2,d0	xe+2
    addq.w  #2,d0
    move.w  d5,d1	y-1
    subq.w  #1,d1
    move.l  a2,a1
    CALL    Move
    move.w  d2,d0	xe+2
    addq.w  #2,d0
    move.w  d3,d1	ye+1
    addq.w  #1,d1
    move.l  a2,a1
    CALL    Draw
    move.w  d4,d0	x-1
    subq.w  #1,d0
    move.w  d3,d1	ye+1
    addq.w  #1,d1
    move.l  a2,a1
    CALL    Draw
    move.w  d2,d0	xe+1
    addq.w  #1,d0
    move.w  d5,d1	y
    move.l  a2,a1
    CALL    Move
    move.w  d2,d0	xe+1
    addq.w  #1,d0
    move.w  d3,d1	ye+1
    addq.w  #1,d1
    move.l  a2,a1
    CALL    Draw
.end
    pop     d2-d7/a2
    rts
PunkteMuster
*
*   Zeichnet Punkte-Muster
*   ( APen ist danach hin )
*   =>	a1  :	RastPort
*	d0,d1:	(xmin,ymin)
*	d2,d3:	(xmax,ymax)
*	d4  :	Farbe
    push    a2/a6
    move.l  a1,a2
    lea     Pattern1(pc),a0
    move.l  a0,rp_AreaPtrn(a1)
    move.b  #Pat1Size,rp_AreaPtSz(a1)
    push    d0/d1
    move.w  d4,d0
    CGFX    SetAPen
    pop     d0/d1
    move.l  a2,a1
    CALL    RectFill
    lea     Pattern2(pc),a0
    move.l  a0,rp_AreaPtrn(a2)
    move.b  #Pat2Size,rp_AreaPtSz(a2)
    pop     a2/a6
    rts
*
Pattern1    dc.l $aaaa5555
Pat1Size    = 1
Pattern2    dc.w $ffff
Pat2Size    = 0
    cnop    0,4
InvertBox
*   Invertiert Box
*
*   =>	a1  :	RastPort
*	d0  :	xmin
*	d1  :	ymin
*	d2  :	xmax
*	d3  :	ymax
*  ALLE REGISTER BLEIBEN ERHALTEN
    push    d0-d1/a0-a2/a6
    move.l  a1,a2

    push    d0/d1
    moveq   #RP_COMPLEMENT!RP_JAM2,d0
    CGFX    SetDrMd
    pop     d0/d1

    move.l  a2,a1
    CALL    RectFill
    moveq   #RP_JAM2,d0
    move.l  a2,a1
    CALL    SetDrMd
    pop     d0-d1/a0-a2/a6
    rts
DrawBox3D
*
*  Zeichnet 3D Box mit Punktemuster
*
*  =>	a1: RastPort
*	d0: x
*	d1: y
*	d2: width
*	d3: height
*	d4: colors ( high BPen low APen )
    push    a2-a3/a6/d2-d6
    move.l  a1,a2
    move.l  d0,d5
    move.l  d1,d6
    subq.w  #1,d2
    subq.w  #1,d3
    move.l  d4,d0
    swap    d0
    CGFX    SetBPen
* SetDrMd ist richtig auf A/BPEN (JAM2) gesetzt
    move.l  d5,d0
    addq.w  #1,d0	; nur inneres
    add.l   d5,d2
    subq.w  #1,d2	; zeichnen
    move.l  d6,d1
    addq.w  #1,d1
    add.l   d6,d3
    subq.w  #1,d3
    move.l  a2,a1
    bsr     PunkteMuster
    addq.w  #1,d2
    addq.w  #1,d3
    moveq   #2,d0	; weiﬂ
    move.l  a2,a1
    CALL    SetAPen
    move.l  d2,d0	; oben rechts
    move.l  d6,d1
    move.l  a2,a1
    CALL    Move
    move.l  d5,d0
    move.l  d6,d1
    move.l  a2,a1
    CALL    Draw
    move.l  d5,d0
    move.l  d3,d1
    move.l  a2,a1
    CALL    Draw
    moveq   #1,d0	; schwarz
    move.l  a2,a1
    CALL    SetAPen
    move.l  d5,d0
    addq.w  #1,d0
    move.l  d3,d1
    move.l  a2,a1	; unten links
    CALL    Move
    move.l  d2,d0
    move.l  d3,d1
    move.l  a2,a1
    CALL    Draw
    move.l  d2,d0
    move.l  d6,d1
    addq.w  #1,d1
    move.l  a2,a1
    CALL    Draw
    moveq   #0,d0   ; BPen auf Grau
    move.l  a2,a1
    CALL    SetBPen
    pop     a2-a3/a6/d2-d6
    rts

