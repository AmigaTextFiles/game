; ifne 0
;  __
; //_)
;//__) WARE presents
;
; $VER: Colors.asm 0.3 (15.2.97) fehler in try7
;		   0.2 (25.7.95)
;	Colors for Klotz
; endc

BIT32 macro
; \1 : dreg, d0 Hilfsregister
 move.b  \1,d0
 lsl.w	 #8,\1
 add.b	 d0,\1
 move.w  \1,d0
 swap	 \1
 add.w	 d0,\1
 endm

GetPens
* => a1 : Public Screen
*
 push	 all
 copy.l  GfxBase,a6
 cmpi.w  #39,LIB_VERSION(a6)            ; Geht's überhaupt ?
 blt	 penexit
 move.l  sc_ViewPort+vp_ColorMap(a1),a3
 reloc.l a3,Colormap
 beq	 penexit			; Keine Farbtabelle ?
 move.b  sc_BitMap+bm_Depth(a1),d0      ; Wieviele Farben sind's denn ?
 cmpi.b  #4,d0
 beq	 try7				; Versuch's mit s/w- Rändern
 cmpi.b  #5,d0
 blt	 penexit
 tst.l	 ArgsGB(a4)
 beq.s	 .std
 lea	FarbenGB(pc),a2
 bra.s	 .endif
.std
 lea	 Farben(pc),a2
.endif
 lea	 Pens(a4),a5
 moveq	 #0,d4
.for
 move.b  (a2)+,d1  ; r
 BIT32	 d1
 move.b  (a2)+,d2  ; g
 BIT32	 d2
 move.b  (a2)+,d3  ; b
 BIT32	 d3
 move.l  a3,a0
 lea	 PenTagList(pc),a1
 CALL	 ObtainBestPenA
 tst.l	 d0
 bmi	 no_pens_left
 move.b  d0,(a5)+
 addq.w  #1,d4
 cmpi.b  #3*7,d4
 ble	 .for
 on.b	 IsColor
penexit
 pop	 all
 rts
no_pens_left7
 move.l  d4,d0
 add.l	 d0,d0
 add.l	 d4,d0
 move.l  d0,d4
no_pens_left
 move.l  d4,d0
 subq.l  #1,d0
 bsr	 FreePens
 cmpi.b  #7,d4
 bgt	 try7
 bra	 penexit
try7
* Nur mittlere Farben benutzen
 on.b	 IsColor7
 tst.l	 ArgsGB(a4)
 beq.s	 .std
 lea	 FarbenGB+3(pc),a2
 bra.s	 .endif
.std
 lea	 Farben+3(pc),a2
.endif
 lea	 Pens+1(a4),a5
 moveq	 #0,d4
.for
 move.b  (a2),d1   ; r
 BIT32	 d1
 move.b  1(a2),d2  ; g
 BIT32	 d2
 move.b  2(a2),d3  ; b
 BIT32	 d3
 move.l  a3,a0
 lea	 PenTagList(pc),a1
 CALL	 ObtainBestPenA
 tst.l	 d0
 bmi	 no_pens_left7
 move.b  d0,(a5)
 move.b  #2,-1(a5)
 move.b  #1,1(a5)
 lea	 3(a5),a5
 lea	 3*3(a2),a2
 addq.w  #1,d4
 cmpi.b  #7,d4
 blt	 .for		; oops war ble
 on.b	 IsColor
 bra	 penexit

FreePens
* d0 : # pens
 push	 d2/a2/a3/a6
 move.l  d0,d2
 subq.l  #1,d2	    ; für dbra
 lea	 Pens(a4),a2
 copy.l  Colormap,a3
 copy.l  GfxBase,a6
.for
 move.b  (a2)+,d0
 tst.b	 IsColor7(a4)
 beq	 .noskip
 move.w  d2,d1
 divu	 #3,d1
 swap	 d1
 cmpi.b  #1,d1
 bne	 .skip
.noskip
 move.l  a3,a0
 CALL	 ReleasePen
.skip
 dbra	 d2,.for
 pop	 d2/a2/a3/a6
 rts
ColorBox3D
*
*  Zeichnet 3D Box mit Punktemuster
*
*  =>	a1: RastPort
*	d0: x
*	d1: y
*	d2: width
*	d3: height
*	d4: color
    push    a2-a3/a6/d2-d6
    move.l  a1,a2
    move.l  d0,d5
    move.l  d1,d6
    subq.w  #1,d2
    subq.w  #1,d3
    move.l  d4,d1
    add.l   d1,d1
    add.l   d1,d4   ;*3
    move.b  Pens+1(a4,d4),d0 ; mittlerer Farbton
    CGFX    SetAPen
    lea     _LVODraw(a6),a3
* SetDrMd ist richtig auf A/BPEN (JAM2) gesetzt
    move.l  d5,d0
    add.l   d5,d2
    addq.w  #1,d0	; nur inneres
    subq.w  #1,d2	; zeichnen
    move.l  d6,d1
    add.l   d6,d3
    addq.w  #1,d1
    subq.w  #1,d3
    move.l  a2,a1
    CALL    RectFill
    addq.w  #1,d2
    addq.w  #1,d3
    move.b  Pens(a4,d4),d0 ; hell
    move.l  a2,a1
    CALL    SetAPen
    move.l  d2,d0	; oben rechts
    move.l  d6,d1
    move.l  a2,a1
    CALL    Move
    move.l  d5,d0
    move.l  d6,d1
    move.l  a2,a1
    jsr     (a3)          ;CALL    Draw
    move.l  d5,d0
    move.l  d3,d1
    move.l  a2,a1
    jsr     (a3)          ;CALL    Draw
    move.b  (Pens+2)(a4,d4),d0 ; dunkel
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
    jsr     (a3)        ; CALL    Draw
    move.l  d2,d0
    move.l  d6,d1
    addq.w  #1,d1
    move.l  a2,a1
    jsr     (a3)         ;CALL    Draw
    pop     a2-a3/a6/d2-d6
    rts

PenTagList:
    dc.l OBP_Precision,PRECISION_EXACT
    dc.l OBP_FailIfBad,-1,TAG_DONE
Farben
 dc.b $BC,$FC,$B8 ;
 dc.b $00,$D7,$00 ;	 grün	       xxx
 dc.b $07,$9B,$00 ;			 x

 dc.b $BA,$BF,$FF ;
 dc.b $40,$40,$FF ;	 blau	      xxx
 dc.b $00,$00,$CB ;		      x

 dc.b $FF,$BA,$FF ;
 dc.b $FF,$40,$FF ;	 violett      xxxx
 dc.b $B5,$00,$B5 ;

 dc.b $FF,$9F,$9F ;
 dc.b $EF,$00,$00 ;	 rot	      xx
 dc.b $B3,$00,$00 ;		      xx

 dc.b $FF,$FF,$FF ;
 dc.b $FF,$AF,$AF ;	 rosa	      xxx
 dc.b $FF,$5F,$5F ;		       x

 dc.b $FF,$C1,$5F ;
 dc.b $FC,$78,$00 ;	 orange       xx
 dc.b $B4,$54,$00 ;		       xx

 dc.b $FC,$FC,$B8 ;
 dc.b $FC,$F4,$00 ;	 gelb		xx
 dc.b $84,$84,$00 ;		       xx

FarbenGB: ; Spielerei
 dc.b 220,200,100
 dc.b 196,175,129
 dc.b 88,80,40
 dc.b 220,200,100
 dc.b 93,67,0
 dc.b 88,80,40
 dc.b 220,200,100
 dc.b 160,133,71
 dc.b 88,80,40
 dc.b 220,200,100
 dc.b 144,115,99
 dc.b 88,80,40
 dc.b 220,200,100
 dc.b 127,97,28
 dc.b 88,80,40
 dc.b 220,200,100
 dc.b 178,154,100
 dc.b 88,80,40
 dc.b 220,200,100
 dc.b 110,82,14
 dc.b 88,80,40
 even

