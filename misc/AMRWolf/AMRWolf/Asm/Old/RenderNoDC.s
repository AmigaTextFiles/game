RenderNoDC
        bra     .mainloop
.done
        move.l  lray(a4),d0
        addq    #1,d0
        move.l  d0,lray(a4)
        cmp.l   #127,d0
        ble     MainLoop

.mainloop
        move.l  -(a2),d0
        beq     .done

        move.l  lscale(a4),st
        divu    d0,st
        ext.l   st

        move.l  itexture(a3),source

        btst    #31,d0
        beq     .wall
        move.l  objectbank(a3),source
.wall

        swap.w  d0
        moveq   #0,column
        move.b  d0,column
        lsr.b   #2,column

        and.l   #$1f00,d0
        lsl.l   #5,d0
        add.l   d0,source

        move.l  lray(a4),xpos
        move.l  iscreen(a3),screen

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

        bsr     ScaleNoDC

        bra     .mainloop

ScaleNoDC
        moveq   #$40,so
        lsl.l   #8,so
        lsl.l   #2,so
        divu    st,so    ; ad=16384*(s-1)/d
        ext.l   so
        lsl.l   #4,so
        move.l  #8192,b
        move.l  st,c
        sub.l   #85,c
        bmi     .skipc
        move.l  #$40,b
        lsl.l   #8,b
        mulu    c,b
        divu    st,b
        ext.l   b
        lsl.l   #4,b
        add.l   #8192,b
        moveq   #84,st
        bra     .scaleloop
.skipc
        moveq   #85,c
        sub.b   st,c
        lsr.b   #2,c
        muls    #_bytesperrow,c
        adda.l  c,screen
        subq    #1,st
.scaleloop
        move.l  b,c
        lsr.l   #8,c
        lsr.l   #6,c
        move.w  (source,c*2),pix
        beq     .dontplot
        move.w  pix,(screen)
.dontplot
        lea     _bytesperrow(screen),screen
        add.l   so,b
        dbf     st,.scaleloop
        rts


