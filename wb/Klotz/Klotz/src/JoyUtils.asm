*
*    $VER: JoyUtils.asm 0.11 (21.10.93)
*			0.10 (8.10.93)
*			0.8 (7.9.93) (Mehr als nen Monat nix dran getan)
*

TestFire
*
*   Feuerknopfabfrage
*
*   =>	d0  : fire = -1
    push    a0-a2/d1-d5

    lea     $dff000,a0	; Customchips für 2. Feuerknopf
    lea     $bfe001,a1	; CIA	      für 1.	  "

    lea     FireStatus(a4),a2
*   0(a2)   B vorher
*   1(a2)   C vorher
*   2(a2)   Signal reached main
*   4(a2).w Feuer: B 1, C -1

    btst.b  #7,(a1)
    seq     d4		; Feuerknopf 1 gedrückt
    move.w  $16(a0),d1
    moveq   #14,d0
    btst    d0,d1
    seq     d5		; Feuerknopf 2 gedrückt
; Tastenabfrage (2.4.96)
    tst.l   ArgUseKeys(a4)
    beq     .skipthis
;*   Pause nur mit aktiven Fenster durch Tastendruck zu verlassen
;    tst.b   IsSetup(a4)
;    bne     .weiter
;    tst.b   IsPause(a4)
;    beq     .weiter
;.weiter0
;    copy.l  IntBase,a0
;    move.l  ib_ActiveWindow(a0),a0
;    copy.l  CWindow,a1
;    cmpa.l  a1,a0
;    bne     .skipthis
.weiter
    move.b  $c00(a1),d0          ; Keycode
    ror.b   #1,d0
    not.b   d0
    reloc.b d0,CKey
;    copy.b  CKey,d0

    cmp.b   KeyRotL(a4),d0
    bne     .skip2
    or.b    #-1,d4
.skip2
    cmp.b   KeyRotR(a4),d0
    bne     .skip3
    or.b    #-1,d5
.skip3
* no pause support
;    cmp.b   KeyPause(a4),d0
;    bne     .skipthis
;.ispause
;    on.b    IsPause
;    bra     l21
.skipthis

    moveq   #0,D2
* 'Tschuldigung für den folgenden Spaghetti-Code
*  ( in C sah' das (nicht) viel übersichtlicher aus)
*
    tst.b   D4
    beq     l2
l1
    tst.b   0(a2)
    bne     l5
l4
    st	    0(a2)
    moveq   #-1,D2
    sf	    2(a2)
    bra     l6
l5
    tst.b   2(a2)
    bne     l8
l7
    moveq   #-1,D2
l8
l9
l6
    bra     l3
l2
    sf	    0(a2)
    tst.b   D5
    beq     l11
l10
    tst.b   1(a2)
    bne     l14
l13
    st	    1(a2)
    moveq   #-1,D2
    sf	    2(a2)
    bra     l15
l14
    tst.b   2(a2)
    bne     l17
l16
    moveq   #-1,D2
l17
l18
l15
    bra     l12
l11
    sf	    1(a2)
l12
l3
    move.l  D2,D0
    beq     l20
    ext.w   d4
    neg.b   d5
    ext.w   d5
    add.w   d4,d5
    beq     l21
    move.w  d5,4(a2)
l20
    pop     d1-d5/a0-a2
    rts
l21
    moveq   #0,d0
    bra     l20
 loc.w FireStatus
*    dc.b    0,0
 loc.w FirePressed
*    dc.b    0,0
 loc.w Fire
*    dc.w    0
*    cnop    0,4
TestJoy
*
* Routine wird vom Interrupt aufgerufen
*
*   =>	d0 : keine Bewegung=0 joy bewegt=-1 joy noch immer bewegt=1
*
    push    a0-a2/d1-d4
    sf	    d1
    moveq   #0,d4
    lea     $dff000,a0
;    move.b  $bfec01,d3  ; Keycode
;    ror.b   #1,d3
;    not.b   d3
    copy.b  CKey,d3
;    on.b    CKey	  ;  auf $ff setzen
.CheckLeft
    move.w  $C(a0),d2
    btst    #9,d2
    bne     .isleft
    tst.l   ArgUseKeys(a4)
    beq     .CheckRight
    cmp.b   KeyMovL(a4),d3         ; Cursor left
    bne     .CheckRight
.isleft
    subq.w  #1,d4
    bra     .CheckDown
.CheckRight
    btst    #1,d2
    bne     .isright
    tst.l   ArgUseKeys(a4)
    beq     .CheckDown
    cmp.b   KeyMovR(a4),d3         ; Cursor right
    bne     .CheckDown
.isright
    st	    d1
    addq.w  #1,d4
.CheckDown
    tst.l   ArgUseKeys(a4)
    beq     .skip
    cmp.b   KeyMovD(a4),d3
    bne     .skip
    st	    d3
    bra     .cont
.skip
    btst    #0,d2
    sne     d3
    eor.b   d1,d3
.cont
    lea     DownStick(a4),a2
    tst.b   d3
    sne     (a2)
.CheckEnd
    tst.w   d4
    beq     .TestQDrop
    lea     QDrop(a4),a0
    clr.b   (a0)
    lea     StickX(a4),a1
    cmp.w   (a1),d4
    bne     .JoyHasChanged
.JoyIsOld
    moveq   #1,d0
    bra     .JoyEnd
.NothingHappened
    moveq   #0,d0
.JoyEnd
    pop     a0-a2/d1-d4
    rts
.TestQDrop
    lea     DownStick(a4),a2
    tst.b   (a2)
    beq     .NothingHappened
    lea     StickX(a4),a0
    clr.w   (a0)
    lea     QDrop(a4),a0
    tst.b   (a0)
    bne     .JoyIsOld
    st	    (a0)
    moveq   #-1,d0
    bra     .JoyEnd
.JoyHasChanged
    move.w  d4,(a1)
    moveq   #-1,d0
    bra     .JoyEnd
* private data
 loc.b DownStick  ; dc.b 0
* public data
 loc.b QDrop   ;dc.b 0
 loc.w StickX  ;dc.w 0

