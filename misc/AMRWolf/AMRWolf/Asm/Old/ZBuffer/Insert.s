*-Revision Header-*************************************************************
*                                                                             *
*    Project:                                             _____       ____    *
*                                                        /    |\    /|    \   *
*    Version: 1.0                                       /     | \  / |     \  *
*                                                      /      |  \/  |     /  *
*       File:                                         /-------|      |-----   *
*                                                    /        |      |     \  *
*     Author: Alastair M. Robinson                  /         |      |      \ *
*                                                                             *
****Revision: 0000                                                   © - 1995 *
*                                                                             *
*******************************************************************************
*            *                                                                *
*    Date    *                            Comment                             *
*            *                                                                *
*******************************************************************************
*            *                                                                *
* 05.03.1996 * Created to allow insertion of enemies into the raylist after   *
*            * the main castine has been done.                                *
*            *                                                                *
****************************************************************-RevisionTail-*

Stub
        move.l  #$201,d0
        bsr     InsertItem
        rts

InsertItem
        lea     List(pc),a0
.loop
        move.l  (a0)+,d1
        beq     .foundposition
        cmp.w   d0,d1
        blt     .loop
.foundposition
        suba.l  #4,a0
.loop2
        move.l  d0,(a0)+
        move.l  d1,d0
        move.l  (a0),d1
        tst.l   d1
        beq     .done
        bra     .loop2

.done
        move.l  d0,(a0)+
        rts

List
        dc.l    $100,$200,$300,$400,$600,0,0,0,0,0,0,0,0,0,0,0

