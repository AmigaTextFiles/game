*-Revision Header-*************************************************************
*                                                                             *
*    Project: Wolfenstein Clone                           _____       ____    *
*                                                        /    |\    /|    \   *
*    Version: 1.0                                       /     | \  / |     \  *
*                                                      /      |  \/  |     /  *
*       File: DoHMap.s                                /-------|      |-----   *
*                                                    /        |      |     \  *
*     Author: Alastair M. Robinson                  /         |      |      \ *
*                                                                             *
****Revision: 0087                                                   © - 1996 *
*                                                                             *
*******************************************************************************
*            *                                                                *
*    Date    *                            Comment                             *
*            *                                                                *
*******************************************************************************
*            *                                                                *
* 22.03.1996 * File created to display a heads-up map on the copper screen    *                                                 *
*            *                                                                *
*            *                                                                *
****************************************************************-RevisionTail-*

c       equr    d7
col     equr    d6
scr0    equr    d0
scr1    equr    d1
scr2    equr    d2
mapx    equr    d3
mapy    equr    d4
trig    equr    d5
dest    equr    a0
source  equr    a1
ascr    equr    a2

_bytesperrow=536

imap=0
iscreen=4
iy=8
ix=12
itrig=16
itheta=20
iscale=24

ldatasize=-8
ysin=-4
ycos=-8

        ; Procedure _DoHMeter[scale,angle,trig,x,y,screen,map]

DoHMeter

;        illegal

        link    a4,#ldatasize

        move.l  iscreen(a3),dest
        lea     114+54*_bytesperrow(dest),dest
        move.l  imap(a3),source

        move.l  itrig(a3),ascr
        move.l  itheta(a3),scr0
        lsl.l   #3,scr0
        move.l  (ascr,scr0*4),trig

        move.l  iscale(a3),scr0
        move.l  scr0,scr1
        swap.w  trig
        muls    trig,scr0
        asr.l   #8,scr0
;        asr.l   #4,scr0
        move.w  scr0,trig
        swap.w  trig
        muls    trig,scr1
        asr.l   #8,scr1
;        asr.l   #4,scr1
        move.w  scr1,trig

        swap.w  trig

        moveq   #29,c
        moveq   #-15,mapy
.mainloop

        move.l  mapy,scr0
        move.l  scr0,scr1
        muls    trig,scr1
        swap.w  trig
        muls    trig,scr0
        swap.w  trig
        move.l  scr0,ysin(a4)
        move.l  scr1,ycos(a4)

        adda.l  #_bytesperrow,dest

        moveq   #29,col
        moveq   #1,scr1
        moveq   #-15,mapx
.colloop
        move.l  mapx,scr0

        move.l  scr0,scr2
        muls    trig,scr0
        sub.l   ysin(a4),scr0
        asr.l   #8,scr0
        add.l   ix(a3),scr0
        bmi     .dontfill1
        asr.l   #8,scr0

        swap.w  trig
        muls    trig,scr2
        add.l   ycos(a4),scr2
        swap.w  trig

        asr.l   #8,scr2
        add.l   iy(a3),scr2
        bmi     .dontfill1
        asr.l   #8,scr2

        lsl.l   #7,scr2
        add.l   scr0,scr2

        move.w  (source,scr2*2),scr0
        beq     .dontfill1
        btst    #8,scr0
        bne     .dontfill1
        move.w  #$dc2,scr1
        btst    #7,scr0
        beq     .notobject
        move.w  #$5,scr1
.notobject
        swap.w  scr1
        move.w  64(dest,mapx*4),scr1
        move.w  scr1,scr0
        lsr.w   #8,scr0
        swap.w  scr1
        move.w  scr1,scr2
        lsr.w   #8,scr2
        add.w   scr0,scr2
        lsr.w   #1,scr2
        move.b  scr2,64(dest,mapx*4)

        move.w  scr1,scr2
        and.w   #$f,scr1
        and.w   #$f0,scr2
        swap.w  scr1
        move.w  scr1,scr0
        and.w   #$f,scr1
        and.w   #$f0,scr0
        add.w   scr2,scr0
        lsr.w   #1,scr0
        and.b   #$f0,scr0
        move.b  scr0,65(dest,mapx*4)

.dontfill1
        addq.l  #1,mapx
        dbf     col,.colloop

        addq.l  #1,mapy

        dbf     c,.mainloop

        move.l  iscreen(a3),dest
        lea     114+69*_bytesperrow(dest),dest
        move.w  #$44f,_bytesperrow+60(dest)
        move.w  #$44f,2*_bytesperrow+64(dest)
        move.w  #$44f,64(dest)
        move.w  #$44f,_bytesperrow+68(dest)

        unlk    a4

        rts

