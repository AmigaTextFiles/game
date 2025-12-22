*-Revision Header-*************************************************************
*                                                                             *
*    Project: Wolfenstein Clone                           _____       ____    *
*                                                        /    |\    /|    \   *
*    Version: 1.0                                       /     | \  / |     \  *
*                                                      /      |  \/  |     /  *
*       File: ScaleColumn.s                           /-------|      |-----   *
*                                                    /        |      |     \  *
*     Author: Alastair M. Robinson                  /         |      |      \ *
*                                                                             *
****Revision: 0031                                                   © - 1995 *
*                                                                             *
*******************************************************************************
*            *                                                                *
*    Date    *                            Comment                             *
*            *                                                                *
*******************************************************************************
*            *                                                                *
* 01.01.1996 * This revision header added.                                    *
*            * Depth Cueing added.
*            *                                                                *
* 04.01.1996 * Some raggedness removed.                                       *
*            *                                                                *
****************************************************************-RevisionTail-*


        ; 100% PC-relative code for inclusion into an AMOS Pro program.
        ; Procedure _ScaleColumn[screen,xpos,size,column,texture]

        ; screen is a pointer to a copper-chunky screen.

        MACHINE 68020
_limit =        85
_texturesize =  64
_texturesizeb=  6
_bytesperrow=536
source  equr    a0
screen  equr    a1
b       equr    d7
column  equr    d7
c       equr    d6
xpos    equr    d6
spt     equr    d5
so      equr    d4
st      equr    d3
pix     equr    d2
depth   equr    d1
scr     equr    d0



Main

Stub
;        movem.l a3-6,-(a7)
;        illegal
        move.l  #_texturesize,so
        move.l  (a3)+,source
        move.l  (a3)+,column
        move.l  (a3)+,st
        move.l  (a3)+,xpos
        move.l  (a3)+,screen

        asl.l   #_texturesizeb+1,column
        add.l   column,source

        move.l  xpos,scr
        lsr.w   #5,scr
        lsl.w   #2,scr
        lsl.w   #2,xpos
        adda.l  xpos,screen
        adda.l  scr,screen
        adda.l  #114,screen

        cmp.l   #$3fff,st
        bgt     .done

        bsr     Scale

;        movem.l (a7)+,a3-6
.done
        rts

Scale
        moveq   #0,b
        moveq   #0,c
        move.l  st,spt
        subq    #1,spt
        cmp.w   #_limit,st
        ble.s   .dontclip

        move.w  st,b
        sub.w   #_limit,b
        lsl.w   #_texturesizeb-2,b
        divu    st,b
        bfextu  b{0:16},c
        ext.l   b
        lsl     #1,b
        ext.l   c
        move.w  #_limit-1,spt
        bra.s   .doneclip
.dontclip

        moveq   #_limit,scr
        sub.l   st,scr
        asr.l   #2,scr
        move.w  scr,depth
        and.w   #3,depth
        lsl.w   #2,so
        lsl.w   #2,st
        add.w   depth,st
        subq    #1,scr
        bmi.s   .doneclip

.loop
        adda.l  #_bytesperrow,screen
        dbf     scr,.loop


.doneclip
        move.w  (source,b),pix
        cmp.w   so,st
        blt.s   ScaleDown

ScaleUp

        add.w   so,c
        cmp.w   c,st
        bgt.s   .dontgetnewpixel
        sub.w   st,c
        addq    #2,b
        move.w  (source,b),pix

.dontgetnewpixel
        tst.w   pix
        beq     .plotskip
        move.w  pix,(screen)
.plotskip
        adda.l  #_bytesperrow,screen
        dbf     spt,ScaleUp

        rts

ScaleDown
        move.l  #_texturesize*4,depth
        sub.w   st,depth
        lsr.l   #_texturesizeb-1,depth
        move.w  (source,b),pix
        beq     .plotskip
        bfextu  pix{20:4},scr
        sub.w   depth,scr
        bpl     .skipred
        moveq   #0,scr
.skipred
        bfins   scr,pix{20:4}
        bfextu  pix{24:4},scr
        sub.w   depth,scr
        bpl     .skipgreen
        moveq   #0,scr
.skipgreen
        bfins   scr,pix{24:4}
        bfextu  pix{28:4},scr
        sub.w   depth,scr
        bpl     .skipblue
        moveq   #0,scr
.skipblue
        bfins   scr,pix{28:4}
        move.w  pix,(screen)
.plotskip
        adda.l  #_bytesperrow,screen
.loop
        addq    #2,b
        add.w   st,c
        cmp.w   c,so
        bgt.s   .loop
        sub.w   so,c
        dbf     spt,ScaleDown

        rts

