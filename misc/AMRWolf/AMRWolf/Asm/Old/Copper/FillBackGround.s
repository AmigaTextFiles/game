*-Revision Header-*************************************************************
*                                                                             *
*    Project: Wolfenstein Clone                           _____       ____    *
*                                                        /    |\    /|    \   *
*    Version: 1.0                                       /     | \  / |     \  *
*                                                      /      |  \/  |     /  *
*       File: FillBackground.s                        /-------|      |-----   *
*                                                    /        |      |     \  *
*     Author: Alastair M. Robinson                  /         |      |      \ *
*                                                                             *
****Revision: 0036                                                   © - 1995 *
*                                                                             *
*******************************************************************************
*            *                                                                *
*    Date    *                            Comment                             *
*            *                                                                *
*******************************************************************************
*            *                                                                *
* 01.01.1996 * File created.                                                  *
* 03.01.1996 * Modified to allow a background pattern.                        *
* 06.01.1996 * Size of background changed to allow for increased F.O.V.       *
*            *                                                                *
****************************************************************-RevisionTail-*

        MACHINE 68020

fbc     equr    d7
fby     equr    d6
fbbank  equr    d5
fbcol   equr    d4
fbxpos  equr    d3
fbdir   equr    d2
fboffset equr    d1
fbscr   equr    d0
fbdest  equr    a0
fbsource equr    a1

ClearCopScreen
        move.l  8(a3),fbdest
        adda.l  #100,fbdest
        move.l  4(a3),fbsource
        move.l  #359,fbxpos
        sub.l   (a3),fbxpos
        mulu    #918,fbxpos
        divu    #360,fbxpos
        ext.l   fbxpos

        moveq   #84,fbc
        moveq   #39,fby
.mainloop
        adda.l  #8,fbdest

        move.l  fbxpos,fboffset
        moveq   #2,fbdir

        cmp.l   #458,fbxpos
        ble     .ignore
        move.l  #918,fboffset
        sub.l   fbxpos,fboffset
        moveq   #-2,fbdir

.ignore
        add.l   fboffset,fboffset

        moveq   #3,fbbank
.bankloop
        adda.l  #4,fbdest

        moveq   #31,fbcol
        cmp.b   #3,fbbank
        bne     .colloop
        subq    #1,fbcol
        adda.l  #4,fbdest
.colloop
        add.l   fbdir,fboffset

        cmp.l   #0,fboffset
        bge     .notzero
        moveq   #2,fbdir
        add.l   fbdir,fboffset
.notzero
        cmp.l   #918,fboffset
        bne     .notover
        move.l  #-2,fbdir
        add.l   fbdir,fboffset
.notover
        adda.l  #2,fbdest
        move.w  (fbsource,fboffset),(fbdest)+

        dbf     fbcol,.colloop
        dbf     fbbank,.bankloop

        adda.l  #920,fbsource

        dbf     fbc,.mainloop

        rts

