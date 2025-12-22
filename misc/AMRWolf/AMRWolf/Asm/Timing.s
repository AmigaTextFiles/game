DoTimingStuff

        moveq   #0,d0
        moveq   #0,d1
        move.b  animframe+1(a3),d1
        move.b  animframe+3(a3),d0
        move.l  framecount(a3),d2
        add.l   d1,d2
        divu    #3,d2
        move.l  d2,d1
        swap.w  d1
        add.w   d2,d0
        and.w   #7,d0
        move.b  d0,animframe+3(a3)
        move.b  d1,animframe+1(a3)

        move.l  enemylist(a3),a0

.enemyloop
        move.l  (a0),d0
        beq     .enemiesdone
        move.l  4(a0),d3
        btst    #21,d3          ; is this an explosion?
        beq     .notexplosion

        ; ------------------Explosion code-------------
        bfextu  d3{22:4},d0
        bfextu  d3{20:2},d1

        move.l  framecount(a3),d2
        add.l   d1,d2
        divu    #4,d2
        move.l  d2,d1
        swap.w  d1
        ext.l   d1
        add.w   d2,d0
        cmp.w   #15,d0
        bge     .removethisenemy
        and.w   #15,d0
        bfins   d0,d3{22:4}
        bfins   d1,d3{20:2}
        move.l  d3,4(a0)

        cmp.b   #2,d0
        ble     .dontspread
        move.l  (a0),d2
        bsr     .spreadexplosion
.dontspread
        cmp.b   #7,d0
        blt.s   .skipthisenemy

        move.l  map(a3),a1
        move.l  (a0),d0
        move.l  d0,d2
        move.l  d0,d1
        swap.w  d0
        ext.l   d0
        lsr.l   #8,d0
        ext.l   d1
        lsr.l   #8,d1
        lsl.l   #7,d0
        add.l   d1,d0

        move.w  (a1,d0*2),d1
        btst    #8,d1
        beq     .skipnextobject
        bclr    #8,d1
        addq    #1,d1
        move.w  d1,(a1,d0*2)

                        ; This is now general; any object which explodes will
                        ; be replaced half way through the explosion with the
                        ; next object in the list.

.skipnextobject
        move.l  d2,d0
        bra     .skipthisenemy
        ;--------------------End of explosion code----------------

.notexplosion
        btst    #3,14(a0)
        beq     .skipthisenemy
        bfextu  d3{22:4},d0
        bfextu  d3{20:2},d1

        move.l  framecount(a3),d2
        add.l   d1,d2
        divu    #4,d2
        move.l  d2,d1
        swap.w  d1
        ext.l   d1
        add.w   d2,d0
        and.w   #7,d0
        bfins   d0,d3{22:4}
        bfins   d1,d3{20:2}
        move.l  d3,4(a0)

.skipthisenemy
        add.l   #16,a0
        bra     .enemyloop

.removethisenemy
        move.l  a0,a1
.removeloop
        move.l  16(a1),(a1)+
        move.l  16(a1),(a1)+
        move.l  16(a1),(a1)+
        move.l  16(a1),(a1)+
        tst.l   -16(a1)
        bne     .removeloop
        bra     .enemyloop


.spreadexplosion
        movem.l a1/d2,-(a7)
        move.l  explosionqueue(a3),a1
        subq    #4,a1
.findspaceloop
        addq    #4,a1
        tst.l   (a1)
        bne     .findspaceloop

        swap    d2
        lsr.w   #8,d2
        swap    d2
        lsr.w   #8,d2
        addq    #1,d2
        move.l  d2,(a1)+
        subq    #2,d2
        move.l  d2,(a1)+
        addq    #1,d2
        swap    d2
        addq    #1,d2
        swap    d2
        move.l  d2,(a1)+
        swap    d2
        subq    #2,d2
        swap    d2
        move.l  d2,(a1)+

.spreaddone
        movem.l (a7)+,a1/d2
        rts

.enemiesdone



