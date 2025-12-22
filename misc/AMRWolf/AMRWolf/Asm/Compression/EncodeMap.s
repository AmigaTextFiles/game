*-Revision Header-*************************************************************
*                                                                             *
*    Project: Wolfenstein Clone                           _____       ____    *
*                                                        /    |\    /|    \   *
*    Version: 1.0                                       /     | \  / |     \  *
*                                                      /      |  \/  |     /  *
*       File: EncodeMap.s                             /-------|      |-----   *
*                                                    /        |      |     \  *
*     Author: Alastair M. Robinson                  /         |      |      \ *
*                                                                             *
****Revision: 0011                                                   © - 1996 *
*                                                                             *
*******************************************************************************
*            *                                                                *
*    Date    *                            Comment                             *
*            *                                                                *
*******************************************************************************
*            *                                                                *
* 05.02.1996 * Created to reduce the amount of disk space used by maps.       *
*            * Uses a mixture of bit packing and run-length encoding.         *
*            *                                                                *
****************************************************************-RevisionTail-*

        machine 68020

;       RLE definitions
data1   equr    d0
data2   equr    d1
count   equr    d2
packlen equr    d3

;       BitPack definitions
source  equr    a0
dest    equr    a1
count1  equr    d7
count2  equr    d6
scratch equr    d0
data    equr    d1
store   equr    d2
bcount  equr    d5

;       Procedure _EncodeMap[source,dest,length]

EncodeMap

CompressRLE
        move.l  a3,-(a7)
        move.l  (a3),a2
        move.l  4(a3),a1
        move.l  8(a3),a0
        adda.l  a0,a2

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
        cmp.w   #255,count
        beq     .doneredundancy
        cmp.w   data1,data2
        beq     .redundant

.doneredundancy
        bset    #8,count
        move.w  count,(a1)+
        move.w  data1,(a1)+
        addq    #4,packlen
        move.w  data2,data1
        bra     .mainloop

.notredundant
        cmpa.l  a2,a0
        bge     .donenotredundant
        move.w  (a0)+,data1
        exg.w   data1,data2
        cmp.w   data1,data2
        beq     .donenotredundant
        addq    #1,count
        cmp.w   #255,count
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

BitPack
        move.l  (a7)+,a3
        move.l  4(a3),source
        move.l  8(a3),dest

        move.l  packlen,(dest)+
        move.l  packlen,count1
        subq    #2,count1
        lsr.l   #1,count1

        moveq   #14,bcount
        moveq   #0,data
.loop1
        move.w  (source)+,scratch
        or.w    scratch,data
        lsl.l   #8,data
        add.l   data,data
        bfextu  data{bcount:8},scratch
        move.b  scratch,(dest)+
        subq    #1,bcount

        cmp.l   #5,bcount
        bne     .dontreset

        moveq   #14,bcount
        bfextu  data{bcount:8},scratch
        move.b  scratch,(dest)+
        subq    #1,bcount
.dontreset
        dbf     count1,.loop1
.done
        lsl.l   #8,data
        add.l   data,data
        bfextu  data{bcount:8},scratch
        move.b  scratch,(dest)+

        move.l  8(a3),source
        suba.l  source,dest
        move.l  dest,d0

        rts

SourceData
        dc.w    511,256,255,255,255,255,127,64,63,32,32,32,32,16,15,8,8,8,8,0
SourceEnd

DestData
        dcb.w   128,0
DestEnd




