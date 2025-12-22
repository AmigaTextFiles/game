
; Variables to import from AMOSPro:
; _PlayerX,_PlayerY,_SinTheta,_CosTheta,_DoorFrame,_AnimFrame,MapPtr,ListPtr

        machine 68020
        opt     d+

modulusmask     =       $ffffff00

sintheta        equ     20
costheta        equ     16
map     equ     4
list    equ     0
xp      equ     28
yp      equ     24
doorframe       equ     12
animframe       equ     8
trig        equr    d7
xi      equr    d6
yi      equr    d5
scr0    equr    d4
scr1    equr    d3
scr2    equr    d2
scr3    equr    d1
scr4    equr    d0

mapptr  equr    a0
listptr equr    a1

Stub
;        illegal
        move.l  a3,-(a7)
        move.l  sintheta(a3),d0
        move.w  d0,trig     ;16384 sin theta
        swap.w  trig
        move.l  costheta(a3),d0
        move.w  d0,trig     ;16384 cos theta

        move.l  map(a3),mapptr
        move.l  list(a3),listptr

CastTest
        swap    trig            ; Sine
        move.l  yp(a3),yi
        and.l   #modulusmask,yi

        tst.w   trig
        beq     .skipyintercepts
        bmi     .sinless
        add.l   #256,yi
.sinless

.yintloop
        tst.w   trig
        bpl     .sinlessagain
        add.l   #512,yi
.sinlessagain
        sub.l   #256,yi

        move.l  yp(a3),xi
        sub.l   yi,xi
        swap.w  trig            ; cosine
        muls    trig,xi
        tst.l   xi
        bmi     .xineg
        add.l   #16384,xi
.xineg
        sub.l   #8192,xi
        swap.w  trig            ; sine
        divs    trig,xi
        bvs     .skipyintercepts
        ext.l   xi
        add.l   xp(a3),xi

        ; At this point we have the x and y coordinate of the intercept
        ; with a horizontal (east to west) line.

        move.l  xi,scr0
        asr.l   #8,scr0
        tst.l   scr0
        bmi     .skipyintercepts
        cmp.l   #127,scr0
        bge     .skipyintercepts
        move.l  yi,scr1
        asr.l   #8,scr1
        tst.w   trig            ; sine
        bmi     .dontalteragain
        subq    #1,scr1
.dontalteragain
        tst.l   scr1
        bmi     .skipyintercepts
        cmp.l   #127,scr1
        bge     .skipyintercepts
        asl.l   #7,scr1
        add.l   scr1,scr0
        ; Scr0 now contains an offset into the map data for the current cell.

        move.w  (mapptr,scr0*2),scr0
        ; and now it contains the contents of that cell.

        tst.l   scr0
        beq     .yintloop

        move.l  xi,scr1
        and.l   #$ff,scr1       ;Texture column.

        btst    #5,scr0         ;Is this cell a door?
        beq     .yinodoor

        move.l  doorframe(a3),scr2
        asl.l   #4,scr2
        sub.l   scr2,scr1
        bpl     .yinodoor
        bra     .yintloop       ; Map is treated as clear if ray has missed an
                                ; opening door.

.yinodoor

        clr.l   scr2            ; scr2 will be used for the distance to point of
                                ; intersection.

        btst    #7,scr0         ; Does this cell contain an object?
        beq     .yinotfacingplayer

        move.l  xi,scr3
        and.l   #modulusmask,scr3
        add.l   #$80,scr3
        move.l  yi,scr4
        and.l   #modulusmask,scr4
        add.l   #$80,scr4
                                ; scr3 and 4 now contain the coordinates of
                                ; this cell's centre.
        sub.l   xp(a3),scr3
        sub.l   yp(a3),scr4
        swap.w  trig
        move.l  scr3,-(a7)
        muls    trig,scr3       ; cosine
        move.l  scr3,scr2
        move.l  (a7)+,scr3
        move.l  scr4,-(a7)
        muls    trig,scr4       ; cosine
        move.l  scr4,scr1
        neg.l   scr1
        move.l  (a7)+,scr4

        swap.w  trig
        muls    trig,scr4       ; sine
        sub.l   scr4,scr2
        muls    trig,scr3
        sub.l   scr3,scr1
        asr.l   #8,scr1
        asr.l   #6,scr1
        asr.l   #8,scr2
        asr.l   #6,scr2
        add.l   #$80,scr1
                                ; Scr2 now contains distance, and scr1 contains
                                ; the texture column.
        tst.l   scr1
        bmi     .yintloop
        cmp.l   #$100,scr1
        bge     .yintloop
        bra     .yiddone

.yinotfacingplayer
        move.w  trig,scr4
        bpl     .yidontnegsin
        neg.w   scr4
.yidontnegsin
        cmp.w   #4096,scr4
        blt     .yiusecos

        move.l  yi,scr2
        sub.l   yp(a3),scr2
        lsl.l   #8,scr2
        lsl.l   #6,scr2
        divs    trig,scr2       ; sine
        ext.l   scr2
                                ; Scr2 now contains distance, calculated from
                                ; y difference and sine.
        bra     .yiddone
.yiusecos
        move.l  xi,scr2
        sub.l   xp(a3),scr2
        lsl.l   #8,scr2
        lsl.l   #6,scr2
        swap.w  trig
        divs    trig,scr2       ; cosine
        swap.w  trig
        ext.l   scr2
                                ; Scr2 now contains distance, calculated from
                                ; x difference and cosine.
.yiddone
        tst.l   scr0
        beq     .yintloop

        tst.l   scr2
        bpl     .yidontnegd

        neg.l   scr2

.yidontnegd
        move.l  scr0,scr3
        subq    #1,scr3
        and.l   #31,scr3        ; Scr3 contains the texture number.

        btst    #4,scr0
        beq     .yidontanimate
        add.l   animframe(a3),scr3
.yidontanimate

        btst    #6,scr0
        bne     .yidontterminate
        bset    #5,scr3

.yidontterminate

        tst.l   scr2
        beq     .yidontaddtolist

        and.l   #32767,scr2
        move.l  scr3,scr4
        lsl.l   #8,scr4
        move.b  scr1,scr4
        swap.w  scr4
        move.w  scr2,scr4
        move.l  scr4,(listptr)+

.yidontaddtolist
        btst    #6,scr0
        bne     .yintloop

.skipyintercepts
        clr.l   (listptr)+

        move.l  (a7)+,a3
        rts

