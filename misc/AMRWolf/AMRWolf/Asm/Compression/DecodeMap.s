*-Revision Header-*************************************************************
*                                                                             *
*    Project: Wolfenstein Clone                           _____       ____    *
*                                                        /    |\    /|    \   *
*    Version: 1.0                                       /     | \  / |     \  *
*                                                      /      |  \/  |     /  *
*       File: DecodeMap.s                                        /-------|      |-----   *
*                                                    /        |      |     \  *
*     Author: Alastair M. Robinson                  /         |      |      \ *
*                                                                             *
****Revision: 0008                                                   © - 1996 *
*                                                                             *
*******************************************************************************
*            *                                                                *
*    Date    *                            Comment                             *
*            *                                                                *
*******************************************************************************
*            *                                                                *
* 06.02.1996 * Created to decode map data created with EncodeMap.s            *
*            *                                                                *
****************************************************************-RevisionTail-*
        machine 68020

;       Definitions for unbitpack.
source  equr    a0
dest    equr    a1
count1  equr    d7
count2  equr    d6
scratch equr    d0
data    equr    d1
store   equr    d2
bcount  equr    d5


ReCreate
        move.l  4(a3),source
        move.l  (a3),dest
        move.l  (source)+,count1
        lsr.l   #1,count1
        subq    #1,count1

        moveq   #16,bcount
        move.b  (source)+,data
.loop
        lsl.l   #8,data
        move.b  (source)+,data
        bfextu  data{bcount:9},scratch
        move.w  scratch,(dest)+
        addq    #1,bcount
        cmp     #24,bcount
        bne     .dontreset

        move.b  (source)+,data
        moveq   #16,bcount
.dontreset
        dbf     count1,.loop

.done

DeCompressRLE
        movea.l dest,a2
        move.l  (a3),a0
        move.l  4(a3),a1

.mainloop
        cmpa.l  a2,a0
        bge     .done
        moveq   #0,d0
        move.w  (a0)+,d0
        btst    #8,d0
        beq     .straight

        bclr    #8,d0
        subq    #1,d0
        move.w  (a0)+,d1
.reptloop
        move.w  d1,(a1)+
        dbf     d0,.reptloop
        bra     .mainloop

.straight
        subq    #1,d0
.straightloop
        move.w  (a0)+,(a1)+
        dbf     d0,.straightloop
        bra     .mainloop

.done
        rts




