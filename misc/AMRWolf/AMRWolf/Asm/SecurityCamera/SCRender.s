Render

        tst.l   depthcue(a3)
        beq     RenderNoDC
        bra     MainLoopDC
DoneDC
        move.l  lray(a4),d0
        addq    #1,d0
        move.l  d0,lray(a4)
        cmp.l   #127,d0
        ble     MainLoop

        bra     RenderingDone

MainLoopDC
        move.l  -(a2),d0
        beq     DoneDC
        btst    #23,d0
        bne     DoneDC

        move.l  lscale(a4),st
        divu    d0,st
        ext.l   st

        move.l  #64,so
        move.l  itexture(a3),source

        btst    #31,d0
        beq     .wall
        move.l  objectbank(a3),source
        bclr    #22,d0
        bne     TreatAsNMEDC
.wall
        swap.w  d0
        moveq   #0,column
        move.b  d0,column

        and.l   #$1f00,d0
        lsl.l   #5,d0           ; for 64 should be 5
        add.l   d0,source

        move.l  lray(a4),xpos
        move.l  iscreen(a3),screen

        asl.l   #7,column       ; for 64 was 7
        add.l   column,source

        move.l  xpos,scr
        lsr.w   #5,scr
        lsl.w   #2,scr
        lsl.w   #2,xpos
        adda.l  xpos,screen
        adda.l  scr,screen
        adda.l  #114,screen

        cmp.l   #$fff,st
        bgt     DoneDC

        bsr     Scale

        bra     MainLoopDC

Scale
        moveq   #64,depth
        sub.w   st,depth
        bmi     ScaleNoDC
        and.l   #$f8,depth
        lsl.l   #5,depth
        move.l  shadetable(a3),a5
        adda.l  depth,a5
        move.l  depth,-(a7)
        move.l  #$40,so
        lsl.l   #8,so
        lsl.l   #2,so
        divu    st,so    ; ad=16384*(s-1)/d
        ext.l   so
        lsl.l   #6,so   ; was 4
        move.l  #8192,b
        move.l  st,c
        sub.l   #85,c
        bmi     .skipc
        move.l  #$40,b
        lsl.l   #8,b
        mulu    c,b
        divu    st,b
        ext.l   b
        lsl.l   #6,b            ; was 4
        add.l   #32768,b        ; was 8192
        moveq   #84,st
        moveq   #0,pix
        bra     .scaleloop
.skipc
        moveq   #85,c
        sub.b   st,c
        lsr.b   #2,c
        muls    #_bytesperrow,c
        adda.l  c,screen
        subq    #1,st
        moveq   #0,pix
.scaleloop
        move.l  b,c
        swap    c
;        lsr.l   #8,c
;        lsr.l   #6,c
        move.w  (source,c.w*2),pix
        beq     .dontplot

        moveq   #0,scr
        move.b  pix,scr
        move.b  (a5,scr.w),scr
        ror.l   #8,pix
        move.b  (a5,pix.w),pix
        rol.l   #8,pix
        move.b  scr,pix

.setpix
        move.w  pix,(screen)
.dontplot
        lea     _bytesperrow(screen),screen
        add.l   so,b
        dbf     st,.scaleloop
        addq    #4,a7
        rts

TreatAsNMEDC
        move.l  nmeimagebank(a3),source

        swap.w  d0
        moveq   #0,column
        move.b  d0,column

        and.l   #$1f00,d0
        lsl.l   #6,d0           ; for 64 should be 5
        add.l   d0,source

        move.l  lray(a4),xpos
        move.l  iscreen(a3),screen

        asl.l   #8,column       ; for 64 was 7
        add.l   column,source

        move.l  xpos,scr
        lsr.w   #5,scr
        lsl.w   #2,scr
        lsl.w   #2,xpos
        adda.l  xpos,screen
        adda.l  scr,screen
        adda.l  #114,screen

        cmp.l   #$fff,st
        bgt     DoneDC

        bsr     ScaleNMEDC

        bra     MainLoopDC

ScaleNMEDC
        moveq   #64,depth
        sub.w   st,depth
        bmi     ScaleNMENoDC
        and.l   #$f8,depth
        lsl.l   #5,depth
        move.l  shadetable(a3),a5
        adda.l  depth,a5
        move.l  depth,-(a7)
        move.l  #$80,so
        lsl.l   #8,so
        lsl.l   #2,so
        divu    st,so    ; ad=16384*(s-1)/d
        ext.l   so
        lsl.l   #6,so   ; was 4
        move.l  #8192,b
        move.l  st,c
        sub.l   #85,c
        bmi     .skipc
        move.l  #$80,b
        lsl.l   #8,b
        mulu    c,b
        divu    st,b
        ext.l   b
        lsl.l   #6,b            ; was 4
        add.l   #32768,b        ; was 8192
        moveq   #84,st
        moveq   #0,pix
        bra     .scaleloop
.skipc
        moveq   #85,c
        sub.b   st,c
        lsr.b   #2,c
        muls    #_bytesperrow,c
        adda.l  c,screen
        subq    #1,st
        moveq   #0,pix
.scaleloop
        move.l  b,c
        swap    c
;        lsr.l   #8,c
;        lsr.l   #6,c
        move.w  (source,c.w*2),pix
        beq     .dontplot

        moveq   #0,scr
        move.b  pix,scr
        move.b  (a5,scr.w),scr
        ror.l   #8,pix
        move.b  (a5,pix.w),pix
        rol.l   #8,pix
        move.b  scr,pix

.setpix
        move.w  pix,(screen)
.dontplot
        lea     _bytesperrow(screen),screen
        add.l   so,b
        dbf     st,.scaleloop
        addq    #4,a7
        rts

RenderNoDC
        bra     MainLoopNoDC
DoneNoDC
        move.l  lray(a4),d0
        addq    #1,d0
        move.l  d0,lray(a4)
        cmp.l   #127,d0
        ble     MainLoop

        bra     RenderingDone

MainLoopNoDC
        move.l  -(a2),d0
        beq     DoneNoDC
        btst    #23,d0
        bne     DoneNoDC

        move.l  lscale(a4),st
        divu    d0,st
        ext.l   st

        move.l  itexture(a3),source

        btst    #31,d0
        beq     .wall
        move.l  objectbank(a3),source
        bclr    #22,d0
        bne     TreatAsNME
.wall

        swap.w  d0
        moveq   #0,column
        move.b  d0,column

        and.l   #$1f00,d0
        lsl.l   #5,d0           ; for 64 use 5
        add.l   d0,source

        move.l  lray(a4),xpos
        move.l  iscreen(a3),screen

        asl.l   #7,column       ; for 64 use 7
        add.l   column,source

        move.l  xpos,scr
        lsr.w   #5,scr
        lsl.w   #2,scr
        lsl.w   #2,xpos
        adda.l  xpos,screen
        adda.l  scr,screen
        adda.l  #114,screen

        cmp.l   #$3fff,st
        bgt     DoneNoDC

        bsr     ScaleNoDC

        bra     MainLoopNoDC

ScaleNoDC
        move.l  #$40,so
        lsl.l   #8,so
        lsl.l   #2,so
        divu    st,so   ; ad=16384*(s-1)/d
        ext.l   so
        lsl.l   #6,so   ;was 4
        move.l  #8192,b
        move.l  st,c
        sub.l   #85,c
        bmi     .skipc
        move.l  #$40,b
        lsl.l   #8,b
        mulu    c,b
        divu    st,b
        ext.l   b
        lsl.l   #6,b    ;was 4
        add.l   #32768,b ;was 8192
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
        swap    c
;        lsr.l   #8,c
;        lsr.l   #6,c
        move.w  (source,c*2),pix
        beq     .dontplot
        move.w  pix,(screen)
.dontplot
        lea     _bytesperrow(screen),screen
        add.l   so,b
        dbf     st,.scaleloop
        rts

TreatAsNME
        move.l  nmeimagebank(a3),source

        swap.w  d0
        moveq   #0,column
        move.b  d0,column

        and.l   #$1f00,d0
        lsl.l   #6,d0           ; for 64 use 5
        add.l   d0,source

        move.l  lray(a4),xpos
        move.l  iscreen(a3),screen

        asl.l   #8,column       ; for 64 use 7
        add.l   column,source

        move.l  xpos,scr
        lsr.w   #5,scr
        lsl.w   #2,scr
        lsl.w   #2,xpos
        adda.l  xpos,screen
        adda.l  scr,screen
        adda.l  #114,screen

        cmp.l   #$3fff,st
        bgt     DoneNoDC

        bsr     ScaleNMENoDC

        bra     MainLoopNoDC

ScaleNMENoDC
        move.l  #$80,so
        lsl.l   #8,so
        lsl.l   #2,so
        divu    st,so   ; ad=16384*(s-1)/d
        ext.l   so
        lsl.l   #6,so   ;was 4
        move.l  #8192,b
        move.l  st,c
        sub.l   #85,c
        bmi     .skipc
        move.l  #$80,b
        lsl.l   #8,b
        mulu    c,b
        divu    st,b
        ext.l   b
        lsl.l   #6,b    ;was 4
        add.l   #32768,b ;was 8192
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
        swap    c
;        lsr.l   #8,c
;        lsr.l   #6,c
        move.w  (source,c*2),pix
        beq     .dontplot
        move.w  pix,(screen)
.dontplot
        lea     _bytesperrow(screen),screen
        add.l   so,b
        dbf     st,.scaleloop
        rts


