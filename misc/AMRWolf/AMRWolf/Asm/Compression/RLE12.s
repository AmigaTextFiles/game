*-Revision Header-*************************************************************
*                                                                             *
*    Project: Wolfenstein Clone                           _____       ____    *
*                                                        /    |\    /|    \   *
*    Version: 1.0                                       /     | \  / |     \  *
*                                                      /      |  \/  |     /  *
*       File: RLE12.s                                 /-------|      |-----   *
*                                                    /        |      |     \  *
*     Author: Alastair M. Robinson                  /         |      |      \ *
*                                                                             *
****Revision: 0016                                                   © - 1995 *
*                                                                             *
*******************************************************************************
*            *                                                                *
*    Date    *                            Comment                             *
*            *                                                                *
*******************************************************************************
*            *                                                                *
* 23.01.1996 * Created to compress map and texture data.  Uses a variation of *
*            * the RLE system used in IFF pictures.                           *
* 05.02.1996 * Modified to operate on 16-bit words, with only 9 bits used for *
*            * counting, to improve gain in the bit-packing method.           *
*            *                                                                *
****************************************************************-RevisionTail-*

        snmaopt s

data1   equr    d0
data2   equr    d1
count   equr    d2
packlen equr    d3

CompressRLE
        lea     SourceData(pc),a0
        lea     DestData(pc),a1
        lea     (SourceEnd+2)(pc),a2
        move.w  (a0)+,data1
        moveq   #0,packlen

.mainloop
        cmpa.l  a2,a0
        bge     .done

        moveq   #1,count
        move.l  a0,a3
        move.w  (a0)+,data2

        move.w  data1,2(a1)

        cmp.w   data1,data2
        bne     .notredundant

.redundant
        addq    #1,count
        cmpa.l  a2,a0
        bge     .doneredundancy
        move.w  (a0)+,data2
        cmp.w   #2047,count
        beq     .doneredundancy
        cmp.w   data1,data2
        beq     .redundant

.doneredundancy
        bset    #11,count
        move.w  count,(a1)+
        move.w  data1,(a1)+
        addq    #4,packlen
        move.w  data2,data1
        bra     .mainloop

.notredundant
        cmpa.l  a2,a0
        bge     .donenotredundant
        move.w  (a0)+,data1
        exg.l   data1,data2
        cmp.w   data1,data2
        beq     .donenotredundant
        addq    #1,count
        cmp.w   #2047,count
        bne.s   .notredundant
.donenotredundant
        move.w  count,(a1)+
        adda.l  #2,a1
        addq    #4,packlen
        subq    #1,count
        move.l  a3,a0
        bra     .copyentry
.copyloop
        move.w  (a0)+,(a1)+
        addq    #2,packlen
.copyentry
        dbf     count,.copyloop
        adda.l  #2,a0
        bra     .mainloop
.done
        rts


PackedLength
        dc.l    0

SourceData
        dc.w    0,2,1,1,1,2,2,2,2,3,3,4,7,6,5,3,4,4,4,4,4,4,5,5,6,6,6,6
        dcb.w   512,1
SourceEnd

DestData
        dcb.w   1024,0
DestEnd



