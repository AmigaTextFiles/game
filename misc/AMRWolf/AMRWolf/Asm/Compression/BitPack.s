*-Revision Header-*************************************************************
*                                                                             *
*    Project: Wolfenstein Clone                           _____       ____    *
*                                                        /    |\    /|    \   *
*    Version: 1.0                                       /     | \  / |     \  *
*                                                      /      |  \/  |     /  *
*       File: BitPack.s                               /-------|      |-----   *
*                                                    /        |      |     \  *
*     Author: Alastair M. Robinson                  /         |      |      \ *
*                                                                             *
****Revision: 0019                                                   © - 1995 *
*                                                                             *
*******************************************************************************
*            *                                                                *
*    Date    *                            Comment                             *
*            *                                                                *
*******************************************************************************
*            *                                                                *
* 30.01.1996 * Created to reduce words with only 9 bits used into a byte      *
*            * for later compression.                                         *
* 05.01.1996 * Strategy changed!  Compression will now take place before this *
*            * encoding.  This is because the map data will have more RLE     *
*            * redundancy before this operation than it will afterwards, but  *
*            * the gain of this method is constant!                           *
*            *                                                                *
****************************************************************-RevisionTail-*

        machine 68020
        opt     d+

source  equr    a0
dest    equr    a1
count1  equr    d7
count2  equr    d6
scratch equr    d0
data    equr    d1
store   equr    d2
bcount  equr    d5

EncodeMap
        lea     Source(pc),source
        lea     Dest(pc),dest

        moveq   #(SourceEnd-Source)-2,count1
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

ReCreate
        lea     Dest(pc),source
        lea     Recreate(pc),dest

        moveq   #(SourceEnd-Source)-2,count1
        lsr.l   #1,count1

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
        rts


Source
        dc.w    256,255,120,127,500,511,350,100,255
        dc.w    0,0,0,0,0,0,0,0,0,0,0
        dc.w    256,255,120,127,500,511,350,100,255
SourceEnd
Dest
        dcb.b   60,0
DestEnd
Recreate
        dcb.b   150,0
RecreateEnd

