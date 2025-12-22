*-Revision Header-*************************************************************
*                                                                             *
*    Project: Wolfenstein Clone                           _____       ____    *
*                                                        /    |\    /|    \   *
*    Version: 1.0                                       /     | \  / |     \  *
*                                                      /      |  \/  |     /  *
*       File: DoHMeter.s                              /-------|      |-----   *
*                                                    /        |      |     \  *
*     Author: Alastair M. Robinson                  /         |      |      \ *
*                                                                             *
****Revision: 0037                                                   © - 1996 *
*                                                                             *
*******************************************************************************
*            *                                                                *
*    Date    *                            Comment                             *
*            *                                                                *
*******************************************************************************
*            *                                                                *
* 22.03.1996 * File created to overlay the health and ammo displays on the    *
*            * Copper Screen.                                                 *
*            *                                                                *
*            *                                                                *
****************************************************************-RevisionTail-*

c       equr    d7
y       equr    d6
bank    equr    d5
col     equr    d4
scr0    equr    d0
scr1    equr    d1
dest    equr    a0
source  equr    a1
source2 equr    a2

_bytesperrow=536

        ; Procedure _DoHMeter[screen,hgfx]

DoHMeter

;        illegal

        move.l  4(a3),dest
        lea     114(dest),dest
        move.w  #$42f,264+21*_bytesperrow(dest)
        move.w  #$42f,264+22*_bytesperrow(dest)
        move.w  #$42f,248+24*_bytesperrow(dest)
        move.w  #$42f,252+24*_bytesperrow(dest)
        move.w  #$42f,272+24*_bytesperrow(dest)
        move.w  #$42f,276+24*_bytesperrow(dest)
        move.w  #$42f,264+26*_bytesperrow(dest)
        move.w  #$42f,264+27*_bytesperrow(dest)
        move.l  (a3),source
        lea     3000(source),source
        lea     1450(source),source2
        moveq   #24,c
.mainloop
        adda.l  #_bytesperrow,dest

        moveq   #28,col
        moveq   #2,scr1
.colloop
        move.w  (source)+,scr0
        beq     .dontfill1
        move.w  scr0,(dest,scr1*4)
.dontfill1
        move.w  (source2)+,scr0
        beq     .dontfill2
        move.w  scr0,396(dest,scr1*4)
.dontfill2
        addq    #1,scr1
        dbf     col,.colloop

        dbf     c,.mainloop

        rts

