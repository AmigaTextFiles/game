*-Revision Header-*************************************************************
*                                                                             *
*    Project: Wolfenstein Clone                           _____       ____    *
*                                                        /    |\    /|    \   *
*    Version: 1.0                                       /     | \  / |     \  *
*                                                      /      |  \/  |     /  *
*       File: ClearCopScreen.s                        /-------|      |-----   *
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
* 01.01.1996 * File created.                                                  *
*            *                                                                *
****************************************************************-RevisionTail-*

        MACHINE 68020

c       equr    d7
y       equr    d6
bank    equr    d5
col     equr    d4
scr     equr    d0
dest    equr    a0

ClearCopScreen
        move.l  (a3),dest
        moveq   #84,c
        moveq   #39,y
.mainloop
        adda.l  #8,dest

        moveq   #3,bank
.bankloop
        adda.l  #4,dest

        moveq   #31,col
.colloop
        adda.l  #2,dest
        move.w  #0,(dest)+
        dbf     col,.colloop
        dbf     bank,.bankloop

        dbf     c,.mainloop

        rts

