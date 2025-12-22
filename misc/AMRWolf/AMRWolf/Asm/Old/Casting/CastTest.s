
; Variables to import from AMOSPro:
; _PlayerX,_PlayerY,_SinTheta,_CosTheta,_DoorFrame,_AnimFrame

        machine 68020
        opt     d+

modulusmask     =       $ffffff00

xp      equ     -4
yp      equ     -8
doorframe       equ     -12
animframe       equ     -16
trig        equr    d7
xi      equr    d6
yi      equr    d5
scr0    equr    d4
scr1    equr    d3
scr2    equr    d2
scr3    equr    d1
scr4    equr    d0

mapptr  equr    a0
listptr equr    a1

Stub
        link    a5,#-16
        move.l  #$280,xp(a5)
        move.l  #$280,yp(a5)
        move.l  #0,doorframe(a5)
        move.l  #0,animframe(a5)
        move.w  #11585,trig     ;16384 sin theta
        swap.w  trig
        move.w  #11585,trig     ;16384 cos theta

        lea     MapData(pc),mapptr
        lea     ListData(pc),listptr

CastTest
        move.l  xp(a5),xi
        and.l   #modulusmask,xi

        tst.w   trig
        beq     .skipxintercepts
        bpl     .cosgreater
        add.l   #256,xi
.cosgreater

.xintloop
        tst.w   trig
        bmi     .cosless
        add.l   #512,xi
.cosless
        sub.l   #256,xi

        move.l  xp(a5),yi
        sub.l   xi,yi
        swap.w  trig            ;sine
        muls    trig,yi
        tst.l   yi
        bmi     .yineg
        add.l   #16384,yi
.yineg
        sub.l   #8192,yi
        swap.w  trig            ;cosine
        divs    trig,yi
        ext.l   yi
        add.l   yp(a5),yi

        ; At this point we have the x and y coordinate of the intercept
        ; with a vertical (north to south) line.

        move.l  xi,scr0
        asr.l   #8,scr0
        tst.w   trig            ;cosine
        bpl     .dontalter
        subq    #1,scr0
.dontalter
        tst.l   scr0
        bmi     .skipxintercepts
        cmp.l   #127,scr0
        bge     .skipxintercepts
        move.l  yi,scr1
        asr.l   #8,scr1
        tst.l   scr1
        bmi     .skipxintercepts
        cmp.l   #127,scr1
        bge     .skipxintercepts
        asl.l   #7,scr1
        add.l   scr1,scr0
        ; Scr0 now contains an offset into the map data for the current cell.

        move.w  (mapptr,scr0*2),scr0
        ; and now it contains the contents of that cell.

        move.l  yi,scr1
        and.l   #$ff,scr1       ;Texture column.

        btst    #5,scr0         ;Is this cell a door?
        beq     .xinodoor

        move.l  doorframe(a5),scr2
        asl.l   #4,scr2
        sub.l   scr2,scr1
        bpl     .xinodoor
        bra     .xintloop       ; Map is treated as clear if ray has missed an
                                ; opening door.

.xinodoor
        tst.l   scr0
        beq     .xintloop

        clr.l   scr2            ; scr2 will be used for the distance to point of
                                ; intersection.

        btst    #7,scr0         ; Does this cell contain an object?
        beq     .xinotfacingplayer

        move.l  xi,scr3
        and.l   #modulusmask,scr3
        add.l   #$80,scr3
        move.l  yi,scr4
        and.l   #modulusmask,scr4
        add.l   #$80,scr4
                                ; scr3 and 4 now contain the coordinates of
                                ; this cell's centre.
        sub.l   xp(a5),scr3
        sub.l   yp(a5),scr4
        muls    trig,scr3       ; cosine
        move.l  scr3,scr2
        divs    trig,scr3       ; cosine
        ext.l   scr3
        muls    trig,scr4       ; cosine
        move.l  scr4,scr1
        neg.l   scr1
        divs    trig,scr4       ; cosine
        ext.l   scr4

        swap.w  trig
        muls    trig,scr4       ; sine
        sub.l   scr4,scr2
        muls    trig,scr3
        swap.w  trig
        sub.l   scr3,scr1
        asr.l   #8,scr1
        asr.l   #6,scr1
        asr.l   #8,scr2
        asr.l   #6,scr2
        add.l   #$40,scr1
                                ; Scr2 now contains distance, and scr1 contains
                                ; the texture column.
        tst.l   scr1
        bmi     .xintloop
        cmp.l   #$80,scr1
        bge     .xintloop
        bra     .xiddone

.xinotfacingplayer
        move.l  trig,scr4
        bpl     .xidontnegcos
        neg.l   scr4
.xidontnegcos
        cmp.l   #2048,scr4
        bgt     .xiusecos

        move.l  yi,scr2
        sub.l   yp(a5),scr2
        lsl.l   #8,scr2
        lsl.l   #6,scr2
        swap.w  trig
        divs    trig,scr2       ; sine
        swap.w  trig
        ext.l   scr2
                                ; Scr2 now contains distance, calculated from
                                ; y difference and sine.
        bra     .xiddone
.xiusecos
        move.l  xi,scr2
        sub.l   xp(a5),scr2
        lsl.l   #8,scr2
        lsl.l   #6,scr2
        divs.l  trig,scr2       ; cosine
        ext.l   scr2
                                ; Scr2 now contains distance, calculated from
                                ; x difference and cosine.
.xiddone
        tst.l   scr0
        beq     .xintloop

        tst.l   scr2
        bpl     .xidontnegd

        neg.l   scr2

.xidontnegd
        move.l  scr0,scr3
        subq    #1,scr3
        and.l   #31,scr3        ; Scr3 contains the texture number.

        btst    #4,scr0
        beq     .xidontanimate
        add.l   animframe(a5),scr3
.xidontanimate

        btst    #6,scr0
        bne     .xidontterminate
        bset    #6,scr3

.xidontterminate

        tst.l   scr2
        beq     .xidontaddtolist

        and.l   #32767,scr2
        move.l  scr3,scr4
        lsl.l   #8,scr4
        move.b  scr1,scr4
        swap.w  scr4
        move.w  scr2,scr4
        move.l  scr4,(listptr)+

.xidontaddtolist
        btst    #6,scr0
        bne     .xintloop

.skipxintercepts
        clr.l   (listptr)+

        unlk    a5
        rts


ListData
        dcb.b   64,0
MapData
        dcb.b   32768,0


