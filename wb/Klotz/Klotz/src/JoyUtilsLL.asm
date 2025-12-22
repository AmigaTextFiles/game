*
*   $VER: JoyUtilsLL.asm 0.5 (16.1.97) Ende mit << >>
*			 0.4 (23.12.95)
*			 0.3 (24.8.95) Tastatur-Steuerung
*			 0.2 (5.8.95)
*		LowLevel-support
*  by __
*    //_)
*   //__) WARE (of mad programmer :-)
JOYPORT equ 1

 include 'libraries/lowlevel.i'
* include 'intuition/intuitionbase.i'
*ib_ActiveWindow EQU 52
CLEV macro
    copy.l  LowLevelBase,a6
    CALL    \1
    endm
GETTYPE macro
    rol.l   #4,\1
    and.w   #$f,\1
    endm


InitJoy
* => d0 : 0 ok
    lea     LowLevelName(pc),a1
    moveq   #40,d0
    CSYS    OpenLibrary
    reloc.l d0,LowLevelBase
    beq     nolllib
    move.l  d0,a6
    moveq   #JOYPORT,d0
    CALL    ReadJoyPort
    move.l  d0,d1
    GETTYPE d1
    beq     ExitJoy
    moveq   #0,d0
    rts
ExitJoy
    copy.l  LowLevelBase,a6
    move.l  a6,a1
    CSYS    CloseLibrary
nolllib
    moveq   #-1,d0
    rts

 loc.b	StatusRed
 loc.b	StatusBlue
 loc.b	FirePressed
 loc.b	PressedBlue
 loc.w	Fire

TestFire
*
    push    a0-a2/a6/d1-d5
    moveq   #JOYPORT,d0
    CLEV    ReadJoyPort
    move.l  #JPF_BUTTON_FORWARD|JPF_BUTTON_REVERSE|JPF_BUTTON_YELLOW,d1
    move.l  d1,d2
    and.l   d0,d1
    cmp.l   d1,d2
    bne.s   skip0
quickexit
* << und >> sind gedrückt -> Tschüß
    move.l  #SIGBREAKF_CTRL_C,d0
    copy.l  OwnTask,a1
    CSYS    Signal
    bra     l21
skip0
    moveq   #JPB_BUTTON_RED,d1
    btst    d1,d0
    sne     d4
    moveq   #JPB_BUTTON_BLUE,d1
    btst    d1,d0
    sne     d5
    moveq   #JPB_BUTTON_GREEN,d1
    btst    d1,d0
    beq.s   .skip1
    or.b    #-1,d5
.skip1
    moveq   #JPB_BUTTON_PLAY,d1
    btst    d1,d0
    bne     .ispause
    tst.l   ArgUseKeys(a4)
    beq.s   .skipthis
*   Pause nur mit aktiven Fenster durch Tastendruck zu verlassen
    tst.b   IsSetup(a4)
    bne.s   .weiter
    tst.b   IsPause(a4)
    beq.s   .weiter
.weiter0
    copy.l  IntBase,a0
    move.l  ib_ActiveWindow(a0),a0
    copy.l  CWindow,a1
    cmpa.l  a1,a0
    bne     .skipthis
.weiter
    CALL    GetKey
    cmpi.b  #$45,d0	 ; Ende mit ESC
    beq.s   quickexit
    cmp.b   KeyRotL(a4),d0
    bne.s   .skip2
    or.b    #-1,d4
.skip2
    cmp.b   KeyRotR(a4),d0
    bne.s   .skip3
    or.b    #-1,d5
.skip3
    cmp.b   KeyPause(a4),d0
    bne.s   .skipthis
.ispause
    on.b    IsPause
    bra     l21
.skipthis
.nopause
    lea     StatusRed(a4),a2
    moveq   #0,D2
* 'Tschuldigung für den folgenden Spaghetti-Code
*  ( in C sah' das (nicht) viel übersichtlicher aus)
*
    tst.b   D4
    beq.s   l2
l1
    tst.b   0(a2)
    bne.s   l5
l4
    st	    0(a2)
    moveq   #-1,D2
    sf	    2(a2)
    bra.s   l6
l5
    tst.b   2(a2)
    bne.s   l8
l7
    moveq   #-1,D2
l8
l9
l6
    bra     l3
l2
    sf	    0(a2)
    tst.b   D5
    beq.s   l11
l10
    tst.b   1(a2)
    bne.s   l14
l13
    st	    1(a2)
    moveq   #-1,D2
    sf	    2(a2)
    bra.s   l15
l14
    tst.b   2(a2)
    bne.s   l17
l16
    moveq   #-1,D2
l17
l18
l15
    bra.s   l12
l11
    sf	    1(a2)
l12
l3
    move.l  D2,D0
    beq.s   l20
    ext.w   d4
    neg.b   d5
    ext.w   d5
    add.w   d4,d5
    beq.s   l21
    move.w  d5,4(a2)
l20
    pop     d1-d5/a0-a2/a6
    rts
l21
    moveq   #0,d0
    bra.s   l20

TestJoy
    push    a0-a2/a6/d1-d4
    moveq   #0,d4
    moveq   #JOYPORT,d0
    CLEV    ReadJoyPort
    move.l  d0,d2
    CALL    GetKey
    move.w  d0,d3

    sf	    d1
    moveq   #0,d4
.CheckLeft
    moveq   #JPB_JOY_LEFT,d0
    btst.l  d0,d2
    bne.s   .isleft
    tst.l   ArgUseKeys(a4)
    beq.s   .CheckRight
    cmp.b   KeyMovL(a4),d3         ; Cursor left
    bne.s   .CheckRight
.isleft
    subq.w  #1,d4
    bra.s   .CheckDown
.CheckRight
    moveq   #JPB_JOY_RIGHT,d0
    btst.l  d0,d2
    bne     .isright
    tst.l   ArgUseKeys(a4)
    beq.s   .CheckDown
    cmp.b   KeyMovR(a4),d3         ; Cursor right
    bne.s   .CheckDown
.isright
    st	    d1
    addq.w  #1,d4
.CheckDown
    tst.l   ArgUseKeys(a4)
    beq.s   .skip
    cmp.b   KeyMovD(a4),d3
    bne.s   .skip
    st	    d3
    bra.s   .cont
.skip
    moveq   #JPB_JOY_DOWN,d0
    btst.l  d0,d2
    sne     d3
.cont
    lea     DownStick(a4),a2
    tst.b   d3
    sne     (a2)
.CheckEnd
    tst.w   d4
    beq.s   .TestQDrop
    lea     QDrop(a4),a0
    clr.b   (a0)
    lea     StickX(a4),a1
    cmp.w   (a1),d4
    bne.s   .JoyHasChanged
.JoyIsOld
    moveq   #1,d0
    bra.s   .JoyEnd
.NothingHappened
    moveq   #0,d0
.JoyEnd
    pop     a0-a2/a6/d1-d4
    rts
.TestQDrop
    lea     DownStick(a4),a2
    tst.b   (a2)
    beq.s   .NothingHappened
    lea     StickX(a4),a0
    clr.w   (a0)
    lea     QDrop(a4),a0
    tst.b   (a0)
    bne.s   .JoyIsOld
    st	    (a0)
    moveq   #-1,d0
    bra.s   .JoyEnd
.JoyHasChanged
    move.w  d4,(a1)
    moveq   #-1,d0
    bra.s     .JoyEnd
* private data
 loc.b DownStick  ; dc.b 0
* public data
 loc.b QDrop   ;dc.b 0
 loc.w StickX  ;dc.w 0

