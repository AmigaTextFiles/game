*-Revision Header-*************************************************************
*                                                                             *
*    Project: Wolfenstein Clone                           _____       ____    *
*                                                        /    |\    /|    \   *
*    Version: 1.0                                       /     | \  / |     \  *
*                                                      /      |  \/  |     /  *
*       File: DoGround.s                              /-------|      |-----   *
*                                                    /        |      |     \  *
*     Author: Alastair M. Robinson                  /         |      |      \ *
*                                                                             *
****Revision: 0250                                                   © - 1996 *
*                                                                             *
*******************************************************************************
*            *                                                                *
*    Date    *                            Comment                             *
*            *                                                                *
*******************************************************************************
*            *                                                                *
* 01.01.1996 * File created.                                                  *
*            *                                                                *
* 31.03.1996 * Pixel referencing routines replaced, freeing two registers.    *
*            * Rotation is now done incrementally for each row.               *
*            *                                                                *
****************************************************************-RevisionTail-*

;        MACHINE 68020

_bytesperrow=536

scr2    equr    d2
scr1    equr    d1
scr0    equr    d0
dest    equr    a1
source  equr    a0

_itrig=0
_in=4
_itheta=8
_idest=12
_iimage=16
_ix=20
_iy=24
_idcue=28
_iprec=32

localdatasize=-20
ldcoffset=-20
tsin=-16
tcos=-12
ycos=-8
ysin=-4


        ; Procedure _FillCopScreen[prec,dcue,y,x,source,dest,r,n,trig]

DoGroundPlane

        ;illegal

        link    a4,#localdatasize

        move.l  _idest(a3),dest
        add.l   #100+37*_bytesperrow,dest
        move.l  _iimage(a3),source

        tst.l   _idcue(a3)
        beq     ClearGroundPlane

        move.l  _itrig(a3),a2
        move.l  _itheta(a3),d0
        add.l   d0,d0
        add.l   d0,d0
        move.l  (a2,d0*8),d1
        move.l  d1,d2
        swap    d2
        move.l  _in(a3),d0
        muls    d0,d1
        muls    d0,d2
        asr.l   #5,d1   ; shifting 5 bits assumes n is never > 32
        ext.l   d1
        move.l  d1,tcos(a4)
        asr.l   #5,d2
        ext.l   d2
        move.l  d2,tsin(a4)

        move.l  _iprec(a3),a2

        moveq   #47,d6
.mainloop
        move.l  d6,d1
        and.b   #60,d1
        lsl.w   #8,d1
        move.l  d1,ldcoffset(a4)

        move.l  (a2,d6*8),d1
        move.l  tsin(a4),d0
        move.l  d0,d4
        muls    d1,d0
        move.l  d0,ysin(a4)
        move.l  tcos(a4),d0
        move.l  d0,d5
        muls    d1,d0
        move.l  d0,ycos(a4)

        move.l  4(a2,d6*8),d3
        move.l  d3,d2
        muls    d3,d5
        move.l  d5,d3
        asr.l   #6,d3
        neg.l   d3
        muls    d2,d4
        move.l  d4,d2
        asr.l   #6,d2
        neg.l   d2

        adda.l  #12,dest

        moveq   #30,d7
        swap    d6
        move.w  #3,d6
.bankloop
        addq.l  #4,dest
.xloop
        addq.l  #2,dest

        add.l   d2,d4
        add.l   d3,d5

        move.l  d5,d1
        move.l  ycos(a4),d0
        add.l   ysin(a4),d1
        sub.l   d4,d0
        asr.l   #8,d0
        add.l   _ix(a3),d0
        asr.w   #6,d0
        asr.l   #8,d1
        add.l   _iy(a3),d1
        asr.w   #6,d1
        and.w   #31,d0
        and.w   #31,d1
        lsl.w   #5,d1
        add.w   d1,d0

        move.w  (source,d0.w*2),d1
        beq     .skip
        add.l   ldcoffset(a4),d0

        move.w  (source,d0.w*2),(dest)
.skip
        lea     2(dest),dest
        dbf     d7,.xloop
        moveq   #31,d7
        dbf     d6,.bankloop

        swap    d6
        dbf     d6,.mainloop

        unlk    a4

        rts

ClearGroundPlane

        unlk    a4

        rts



