
MergeLists
;        illegal
        move.l  (a3),a2
        move.l  4(a3),a1
        move.l  8(a3),a0
        move.l  (a0)+,d0
        move.l  (a1)+,d1
.loop

        cmp.w   d0,d1
        beq     .same
        blt     .d1less
.d0less
        tst.w   d0
        beq     .d1less
        move.l  d0,(a2)+
        btst    #29,d0
        bne     .done
        move.l  (a0)+,d0
        bra     .loop

.d1less
        tst.w   d1
        beq     .d0less
        move.l  d1,(a2)+
        btst    #29,d1
        bne     .done
        move.l  (a1)+,d1
        bra     .loop

.same
        move.l  d0,(a2)+
        tst.w   d0
        beq     .done
        btst    #29,d0
        bne     .done
        move.l  d1,(a2)+
        btst    #29,d1
        bne     .done
        move.l  (a0)+,d0
        move.l  (a1)+,d1
        bra     .loop
.done
        move.l  #0,(a2)+
        rts


