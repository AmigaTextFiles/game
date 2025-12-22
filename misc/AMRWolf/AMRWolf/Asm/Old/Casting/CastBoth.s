*-Revision Header-*************************************************************
*                                                                             *
*    Project: Wolfenstein Clone                           _____       ____    *
*                                                        /    |\    /|    \   *
*    Version: 1.0                                       /     | \  / |     \  *
*                                                      /      |  \/  |     /  *
*       File: CastRay.s                               /-------|      |-----   *
*                                                    /        |      |     \  *
*     Author: Alastair M. Robinson                  /         |      |      \ *
*                                                                             *
****Revision: 0005                                                   © - 1995 *
*                                                                             *
*******************************************************************************
*            *                                                                *
*    Date    *                            Comment                             *
*            *                                                                *
*******************************************************************************
*            *                                                                *
* 20.02.1996 *   Handles the number crunching required to cast rays into the  *
*            * world, and detect hits with walls and static objects.          *
*            *   Problem with static objects:  Calculation of centre of block *
*            * doesn't take into account which side we are looking at!        *
*            *   - now fixed.                                                 *
* 21.02.1996 *   Further bug in the object code:  Columns occasionally vanish *
*            * behind the objects.  This turned out to be a bug in the zbuffer*
*            * merging routine, which couldn't cope with two transparent      *
*            * sections at the same distance.  Now fixed!                     *
*            *                                                                *
****************************************************************-RevisionTail-*


; Variables to import from AMOSPro:
; _PlayerX,_PlayerY,_SinTheta,_CosTheta,_DoorFrame,_AnimFrame,MapPtr,List1Ptr,List2Ptr,DestListPtr

        machine 68020
        opt     d+

modulusmask     =       $ffffff00

sintheta        equ     28
costheta        equ     24
map     equ     12
destlist equ     0
list1    equ     4
list2    equ     8
xp      equ     36
yp      equ     32
doorframe       equ     20
animframe       equ     16
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

        move.l  sintheta(a3),d0
        move.w  d0,trig     ;16384 sin theta
        swap.w  trig
        move.l  costheta(a3),d0
        move.w  d0,trig     ;16384 cos theta

        move.l  map(a3),mapptr
        move.l  list1(a3),listptr

CastHoriz
        move.l  xp(a3),xi
        and.l   #modulusmask,xi

        tst.w   trig
        beq     .skipxintercepts
        bpl     .cosgreater
        add.l   #256,xi
.cosgreater

.xintloop
        tst.w   trig
        bmi     .cosless
        add.l   #512,xi
.cosless
        sub.l   #256,xi

        move.l  xp(a3),yi
        sub.l   xi,yi
        swap.w  trig            ;sine
        muls    trig,yi
        tst.l   yi
        bmi     .yineg
        add.l   #16384,yi
.yineg
        sub.l   #8192,yi
        swap.w  trig            ;cosine
        divs    trig,yi
        bvs     .skipxintercepts
        ext.l   yi
        add.l   yp(a3),yi

        ; At this point we have the x and y coordinate of the intercept
        ; with a vertical (north to south) line.

        move.l  xi,scr0
        asr.l   #8,scr0
        tst.w   trig            ;cosine
        bpl     .dontalter
        subq    #1,scr0
.dontalter
        tst.l   scr0
        bmi     .skipxintercepts
        cmp.l   #127,scr0
        bge     .skipxintercepts
        move.l  yi,scr1
        asr.l   #8,scr1
        tst.l   scr1
        bmi     .skipxintercepts
        cmp.l   #127,scr1
        bge     .skipxintercepts
        asl.l   #7,scr1
        add.l   scr1,scr0
        ; Scr0 now contains an offset into the map data for the current cell.

        move.w  (mapptr,scr0*2),scr0
        ; and now it contains the contents of that cell.

        tst.l   scr0
        beq     .xintloop

        move.l  yi,scr1
        and.l   #$ff,scr1       ;Texture column.

        btst    #5,scr0         ;Is this cell a door?
        beq     .xinodoor

        move.l  doorframe(a3),scr2
        asl.l   #4,scr2
        sub.l   scr2,scr1
        bpl     .xinodoor
        bra     .xintloop       ; Map is treated as clear if ray has missed an
                                ; opening door.

.xinodoor

        clr.l   scr2            ; scr2 will be used for the distance to point of
                                ; intersection.

        btst    #7,scr0         ; Does this cell contain an object?
        beq     .xinotfacingplayer

        move.l  xi,scr3
        and.l   #modulusmask,scr3
        add.l   #$80,scr3
        move.l  yi,scr4
        and.l   #modulusmask,scr4
        add.l   #$80,scr4
        tst.w   trig            ;cosine
        bpl     .obdontalter
        sub.l   #$100,scr3
.obdontalter
                                ; scr3 and 4 now contain the coordinates of
                                ; this cell's centre.
        sub.l   xp(a3),scr3
        sub.l   yp(a3),scr4
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
        swap.w  trig
        sub.l   scr3,scr1
        asr.l   #8,scr1
        asr.l   #6,scr1
        asr.l   #8,scr2
        asr.l   #6,scr2
        add.l   #$80,scr1
                                ; Scr2 now contains distance, and scr1 contains
                                ; the texture column.
        tst.l   scr1
        bmi     .xintloop
        cmp.l   #$100,scr1
        bge     .xintloop
        bra     .xiddone

.xinotfacingplayer
        move.w  trig,scr4
        bpl     .xidontnegcos
        neg.w   scr4
.xidontnegcos
        cmp.w   #4096,scr4
        bgt     .xiusecos

        move.l  yi,scr2
        sub.l   yp(a3),scr2
        lsl.l   #8,scr2
        lsl.l   #6,scr2
        swap.w  trig
        divs    trig,scr2       ; sine
        swap.w  trig
        ext.l   scr2
                                ; Scr2 now contains distance, calculated from
                                ; y difference and sine.
        bra     .xiddone
.xiusecos
        move.l  xi,scr2
        sub.l   xp(a3),scr2
        lsl.l   #8,scr2
        lsl.l   #6,scr2
        divs    trig,scr2       ; cosine
        ext.l   scr2
                                ; Scr2 now contains distance, calculated from
                                ; x difference and cosine.
.xiddone
        tst.l   scr0
        beq     .xintloop

        tst.l   scr2
        bpl     .xidontnegd

        neg.l   scr2

.xidontnegd
        move.l  scr0,scr3
        subq    #1,scr3
        and.l   #31,scr3        ; Scr3 contains the texture number.

        btst    #4,scr0
        beq     .xidontanimate
        add.l   animframe(a3),scr3
.xidontanimate

        btst    #6,scr0
        bne     .xidontterminate
        bset    #5,scr3

.xidontterminate

        tst.l   scr2
        beq     .xidontaddtolist

        and.l   #32767,scr2
        move.l  scr3,scr4
        lsl.l   #8,scr4
        move.b  scr1,scr4
        swap.w  scr4
        move.w  scr2,scr4
        move.l  scr4,(listptr)+

.xidontaddtolist
        btst    #6,scr0
        bne     .xintloop

.skipxintercepts
        clr.l   (listptr)+

CastVert
        move.l  list2(a3),listptr
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
        tst.w   trig            ; sine
        bmi     .obdontalteragain
        sub.l   #$100,scr4
.obdontalteragain
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


MergeLists
        move.l  destlist(a3),a2
        move.l  list1(a3),a1
        move.l  list2(a3),a0
        move.l  (a0)+,d0
        move.l  (a1)+,d1
.loop

        cmp.w   d0,d1
        beq     .same
        blt     .d1less
.d0less
        tst.w   d0
        beq     .d1less
        move.l  d0,(a2)+
        btst    #29,d0
        bne     .done
        move.l  (a0)+,d0
        bra     .loop

.d1less
        tst.w   d1
        beq     .d0less
        move.l  d1,(a2)+
        btst    #29,d1
        bne     .done
        move.l  (a1)+,d1
        bra     .loop

.same
        move.l  d0,(a2)+
        tst.w   d0
        beq     .done
        btst    #29,d0
        bne     .done
        move.l  d1,(a2)+
        btst    #29,d1
        bne     .done
        move.l  (a0)+,d0
        move.l  (a1)+,d1
        bra     .loop
.done
        move.l  #0,(a2)+
        rts



