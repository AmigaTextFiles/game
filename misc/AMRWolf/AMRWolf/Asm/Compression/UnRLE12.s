*-Revision Header-*************************************************************
*                                                                             *
*    Project: Wolfenstein Clone                           _____       ____    *
*                                                        /    |\    /|    \   *
*    Version: 1.0                                       /     | \  / |     \  *
*                                                      /      |  \/  |     /  *
*       File: UnRLE.s                                 /-------|      |-----   *
*                                                    /        |      |     \  *
*     Author: Alastair M. Robinson                  /         |      |      \ *
*                                                                             *
****Revision: 0004                                                   © - 1995 *
*                                                                             *
*******************************************************************************
*            *                                                                *
*    Date    *                            Comment                             *
*            *                                                                *
*******************************************************************************
*            *                                                                *
* 23.01.1996 * Created to allow decompressing of maps and textures.           *
* 05.02.1996 * Modified to support 9-bit codes in 16-bit words.               *
*            *                                                                *
****************************************************************-RevisionTail-*
        opt     d+

DeCompressRLE
        lea     SourceData(pc),a0
        lea     DestData(pc),a1
        lea     SourceEnd(pc),a2

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

SourceData
        dc.w    $102,1 , $106,3 , 2,1,5 , $103,8
SourceEnd

DestData
        dcb.w   64,0
DestEnd


