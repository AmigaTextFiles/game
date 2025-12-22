FillBackground

        move.l  iscreen(a3),fbdest
        adda.l  #100,fbdest
        move.l  iback(a3),fbsource
        move.l  #1439,fbxpos
        sub.l   playerangle(a3),fbxpos
        asr.l   #2,fbxpos
        mulu    #918,fbxpos
        divu    #360,fbxpos
        ext.l   fbxpos

        moveq   #0,fboffset
        moveq   #127,d7
        lea     TempData(pc),a2
        move.w  fbxpos,fboffset
        moveq   #2,fbdir

        cmp.w   #458,fbxpos
        ble     .ignore
        move.w  #918,fboffset
        sub.w   fbxpos,fboffset
        moveq   #-2,fbdir

.ignore
        add.w   fboffset,fboffset
.precloop

        add.w   fbdir,fboffset

        tst.w   fboffset
        bgt     .notzero
        moveq   #2,fbdir
        add.w   fbdir,fboffset
.notzero
        cmp.w   #918,fboffset
        bne     .notover
        moveq   #-2,fbdir
        add.w   fbdir,fboffset
.notover
        move.w  fboffset,(a2)+
        dbf     d7,.precloop

        moveq   #38,d6

.mainloop
        lea     TempData(pc),a2
        lea     12(fbdest),fbdest

        swap    d6
        move.w  #3,d6
        moveq   #30,d7
.bankloop
        addq.l  #4,fbdest
.xloop
        addq.l  #2,fbdest

        move.w  (a2)+,fboffset
        move.w  (fbsource,fboffset.w),(fbdest)+

        dbf     d7,.xloop
        moveq   #31,d7
        dbf     d6,.bankloop

        swap    d6

        lea     920(fbsource),fbsource
        dbf     d6,.mainloop


