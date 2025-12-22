*-Revision Header-*************************************************************
*                                                                             *
*    Project: Wolfenstein Clone                           _____       ____    *
*                                                        /    |\    /|    \   *
*    Version: 1.0                                       /     | \  / |     \  *
*                                                      /      |  \/  |     /  *
*       File: MakeCopperList.s                        /-------|      |-----   *
*                                                    /        |      |     \  *
*     Author: Alastair M. Robinson                  /         |      |      \ *
*                                                                             *
****Revision: 0001                                                   © - 1995 *
*                                                                             *
*******************************************************************************
*            *                                                                *
*    Date    *                            Comment                             *
*            *                                                                *
*******************************************************************************
*            *                                                                *
* 01.01.1996 * This revision header added.                                    *
*            *                                                                *
****************************************************************-RevisionTail-*

        MACHINE 68020

c       equr    d7
y       equr    d6
bank    equr    d5
col     equr    d4
scr     equr    d0
dest    equr    a0

MakeCopperList
        move.l  (a3),dest
        moveq   #43,c
        moveq   #39,y
.mainloop
        moveq   #1,scr
        swap    scr
        bfins   y,scr{0:8}
        move.w  #$fffe,scr
        move.l  scr,(dest)+
        move.l  #$10c8011,(dest)+

        moveq   #3,bank
.bankloop
        moveq   #3,scr
        sub.l   bank,scr
        lsl.l   #8,scr
        lsl.l   #5,scr
        add.l   #$1060c40,scr
        move.l  scr,(dest)+

        moveq   #31,col
.colloop
        moveq   #31,scr
        sub.l   col,scr
        add.l   scr,scr
        add.l   #$180,scr
        swap    scr
        move.l  scr,(dest)+
        dbf     col,.colloop
        dbf     bank,.bankloop

        addq    #3,y

        moveq   #1,scr
        swap    scr
        bfins   y,scr{0:8}
        move.w  #$fffe,scr
        move.l  scr,(dest)+
        move.l  #$10c0011,(dest)+

        moveq   #3,bank
.bankloop2
        moveq   #7,scr
        sub.l   bank,scr
        lsl.l   #8,scr
        lsl.l   #5,scr
        add.l   #$1060c40,scr
        move.l  scr,(dest)+

        moveq   #31,col
.colloop2
        moveq   #31,scr
        sub.l   col,scr
        add.l   scr,scr
        add.l   #$180,scr
        swap    scr
        move.l  scr,(dest)+
        dbf     col,.colloop2
        dbf     bank,.bankloop2

        addq    #3,y

        dbf     c,.mainloop

        move.l  #$fffffffe,(dest)+

        rts

