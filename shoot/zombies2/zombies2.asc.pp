;-----------------------------------------------------------------
;
;ZZZZZZZZ   OOOOOO   M      M  BBBBBBB   III  EEEEEEEE   SSSSSS
;      Z   O      O  MM    MM  B      B   I   E         S      S
;     Z    O      O  M M  M M  B      B   I   E         S
;    Z     O      O  M  MM  M  BBBBBBB    I   EEEEE      SSSSSS
;   Z      O      O  M      M  B      B   I   E                S
;  Z       O      O  M      M  B      B   I   E                S
; Z        O      O  M      M  B      B   I   E         S      S
;ZZZZZZZZ   OOOOOO   M      M  BBBBBBB   III  EEEEEEEE   SSSSSS
;
;                              22222222
; Written By                          2      AGA ONLY!!!
;   Paul Andrews                      2     (BUY A 1200!)
;                              22222222
;    In                        2
;   Blitz ][                   2
;    (shock horror!!)          22222222
;
;
;
;Release Version Of source code - Rude bits and cheat modes hidden
;-----------------------------------------------------------------


WBStartup
rad.f=Pi/180
;------------------------------------------------------------
.inittypes

NEWTYPE.coor
    x.w
    y.w
End NEWTYPE

NEWTYPE .dribble
    go.w
    x.q
    y.q
    life.w
End NEWTYPE

NEWTYPE .blood
    go.w
    life.w
    x.q
    y.q
    vx.q
    vy.q
    bot.w
    do.w
End NEWTYPE

NEWTYPE .zombie
    here.w
    x.q     ;top left
    y.w
    w.w
    h.w
    vx.q
    hits.q
    typ.w   ;type..
    tim.w
    fr.w    ;current frame
    spd.w   ;frame count speed
    cnt.w
End NEWTYPE

;------------------------------------------------------------
.initmacs

Runerrsoff

Function.w getred{num.w,copaddr.l}

    UNLK a4
    MOVEM.l a0-a2,-(a7)
    MOVE.l  d1,a0       ;a0=coplist type
    MOVE.l  8(a0),a1    ;start of colours (106,..,180,...)
    MOVE.w  38(a0),d2   ;length of 1 bank (hi/lo)
    MOVE.w  d2,d3       ;keep for later
    MOVE.w  d0,d1       ;num
    LSR.w   #5,d1       ;bank #
    MULU    d1,d2       ;offset to correct bank
    ADD.l   d2,a1       ;start of correct bank (106,..,180,..)
    AND.w   #31,d0      ;colour in this bank
    MOVE.l  a1,a2
    ADDQ.l  #4,a1       ;hi bank colour 0 (skip 106)
    LSR.w   #1,d3       ;half a bank
    ADD.w   d3,a2       ;lo bank start
    ADDQ.l  #4,a2       ;lo bank colour 0 (skip 106)
    LSL.w   #2,d0       ;offset to colour..
    ADD.w   d0,a1       ;colour hi
    ADD.w   d0,a2       ;colour lo

    MOVEQ   #0,d0
    MOVE.w  2(a1),d0    ;hi
    MOVEQ   #0,d1
    MOVE.w  2(a2),d1    ;lo

    AND.w   #$0f00,d0
    AND.w   #$0f00,d1
    LSR.w   #4,d0
    LSR.w   #8,d1
    OR.w    d1,d0


    MOVEM.l (a7)+,a0-a2
    RTS
End Function
;-----------------
Function.w getgreen{num.w,copaddr.l}

    UNLK a4
    MOVEM.l a0-a2,-(a7)
    MOVE.l  d1,a0       ;a0=coplist type
    MOVE.l  8(a0),a1    ;start of colours (106,..,180,...)
    MOVE.w  38(a0),d2   ;length of 1 bank (hi/lo)
    MOVE.w  d2,d3       ;keep for later
    MOVE.w  d0,d1       ;num
    LSR.w   #5,d1       ;bank #
    MULU    d1,d2       ;offset to correct bank
    ADD.l   d2,a1       ;start of correct bank (106,..,180,..)
    AND.w   #31,d0      ;colour in this bank
    MOVE.l  a1,a2
    ADDQ.l  #4,a1       ;hi bank colour 0 (skip 106)
    LSR.w   #1,d3       ;half a bank
    ADD.w   d3,a2       ;lo bank start
    ADDQ.l  #4,a2       ;lo bank colour 0 (skip 106)
    LSL.w   #2,d0       ;offset to colour..
    ADD.w   d0,a1       ;colour hi
    ADD.w   d0,a2       ;colour lo

    MOVEQ   #0,d0
    MOVE.w  2(a1),d0    ;hi
    MOVEQ   #0,d1
    MOVE.w  2(a2),d1    ;lo

    AND.w   #$00f0,d0
    AND.w   #$00f0,d1
    LSR.w   #4,d1
    OR.w    d1,d0

    MOVEM.l (a7)+,a0-a2
    RTS
End Function
;-----------------
Function.w getblue{num.w,copaddr.l}

    UNLK a4
    MOVEM.l a0-a2,-(a7)
    MOVE.l  d1,a0       ;a0=coplist type
    MOVE.l  8(a0),a1    ;start of colours (106,..,180,...)
    MOVE.w  38(a0),d2   ;length of 1 bank (hi/lo)
    MOVE.w  d2,d3       ;keep for later
    MOVE.w  d0,d1       ;num
    LSR.w   #5,d1       ;bank #
    MULU    d1,d2       ;offset to correct bank
    ADD.l   d2,a1       ;start of correct bank (106,..,180,..)
    AND.w   #31,d0      ;colour in this bank
    MOVE.l  a1,a2
    ADDQ.l  #4,a1       ;hi bank colour 0 (skip 106)
    LSR.w   #1,d3       ;half a bank
    ADD.w   d3,a2       ;lo bank start
    ADDQ.l  #4,a2       ;lo bank colour 0 (skip 106)
    LSL.w   #2,d0       ;offset to colour..
    ADD.w   d0,a1       ;colour hi
    ADD.w   d0,a2       ;colour lo

    MOVEQ   #0,d0
    MOVE.w  2(a1),d0    ;hi
    MOVEQ   #0,d1
    MOVE.w  2(a2),d1    ;lo

    AND.w   #$000f,d0
    AND.w   #$000f,d1
    LSL.w   #4,d0
    OR.w    d1,d0

    MOVEM.l (a7)+,a0-a2
    RTS
End Function
;-----------------
Statement setrgb{num.w,copaddr.l,r.w,g.w,b.w}

    UNLK a4
    MOVEM.l d5-d7/a0-a2,-(a7)

    MOVE.w  d2,d5
    MOVE.w  d3,d6
    MOVE.w  d4,d7       ;save rgb..

    MOVE.l  d1,a0       ;a0=coplist type
    MOVE.l  8(a0),a1    ;start of colours (106,..,180,...)
    MOVE.w  38(a0),d2   ;length of 1 bank (hi/lo)
    MOVE.w  d2,d3       ;keep for later
    MOVE.w  d0,d1       ;num
    LSR.w   #5,d1       ;bank #
    MULU    d1,d2       ;offset to correct bank
    ADD.l   d2,a1       ;start of correct bank (106,..,180,..)
    AND.w   #31,d0      ;colour in this bank
    MOVE.l  a1,a2
    ADDQ.l  #4,a1       ;hi bank colour 0 (skip 106)
    LSR.w   #1,d3       ;half a bank
    ADD.w   d3,a2       ;lo bank start
    ADDQ.l  #4,a2       ;lo bank colour 0 (skip 106)
    LSL.w   #2,d0       ;offset to colour..
    ADD.w   d0,a1       ;colour hi
    ADD.w   d0,a2       ;colour lo

    MOVEQ   #0,d0
    MOVEQ   #0,d1

    MOVE.w  d5,d2       ;red
    AND.w   #$f0,d2     ;hi part
    MOVE.w  d5,d3
    AND.w   #$f,d3      ;lo part
    LSL.w   #4,d2
    LSL.w   #8,d3
    OR.w    d2,d0
    OR.w    d3,d1

    MOVE.w  d6,d2       ;green
    AND.w   #$f0,d2     ;hi part
    MOVE.w  d6,d3
    AND.w   #$f,d3      ;lo part
    LSL.w   #4,d3
    OR.w    d2,d0
    OR.w    d3,d1

    MOVE.w  d7,d2       ;blue
    AND.w   #$f0,d2     ;hi part
    MOVE.w  d7,d3
    AND.w   #$f,d3      ;lo part
    LSR.w   #4,d2
    OR.w    d2,d0
    OR.w    d3,d1

    MOVE.w  d0,2(a1)    ;hi
    MOVE.w  d1,2(a2)    ;lo


    MOVEM.l (a7)+,d5-d7/a0-a2
    RTS
End Statement
;-----------------
Function.w  getkey{}

    MOVEQ   #0,d0
    MOVE.b  $bfec01,d0
    NOT.b   d0
    ROR.b   #1,d0

    RTS
End Function
;-----------------

Statement ReadJoy32{}

    LEA $bfe001,a0
    LEA $dff016,a1

    MOVE.w  porty,d0

    TST.w   d0
    BEQ     readjoy0

readjoy1:
    MOVEM.l d2-d4,-(a7)
    MOVEQ   #0,d0
    MOVEQ   #7,d3
    MOVE    #$4000,d4

    BSET    d3,$200(a0)
    BCLR    d3,(a0)
    MOVE    #$2000,$dff034
    MOVEQ   #6,d1
loop0:
    TST.b   (a0)
    TST.b   (a0)
    TST.b   (a0)
    TST.b   (a0)
    TST.b   (a0)
    TST.b   (a0)
    TST.b   (a0)
    TST.b   (a0)
    MOVE    (a1),d2
    BSET    d3,(a0)
    BCLR    d3,(a0)
    AND     d4,d2
    BNE     skip0
    BSET    d1,d0
skip0:
    DBF     d1,loop0
    MOVE    #0,$dff034
    BCLR    d3,$200(a0)
    ADD     d0,d0
    SWAP    d0

    MOVE    $dff00c,d1
    MOVE    d1,d0
    LSR     #1,d0
    EOR     d0,d1
    AND     #$101,d1
    AND     #$101,d0
    ROR.b   #1,d0
    ROR.b   #1,d1
    LSR     #7,d0
    LSR     #5,d1
    OR      d1,d0
    MOVE.l  d0,joystatus1
    MOVEM.l (a7)+,d2-d4
    RTS
readjoy0:
    MOVEM.l d2-d4,-(a7)
    MOVEQ   #6,d3
    MOVE    #$400,d4

    BSET    d3,$200(a0)
    BCLR    d3,(a0)
    MOVE    #$200,$dff034
    MOVEQ   #6,d1
loop:
    TST.b   (a0)
    TST.b   (a0)
    TST.b   (a0)
    TST.b   (a0)
    TST.b   (a0)
    TST.b   (a0)
    TST.b   (a0)
    TST.b   (a0)
    MOVE    (a1),d2
    BSET    d3,(a0)
    BCLR    d3,(a0)
    AND     d4,d2
    BNE     skip
    BSET    d1,d0
skip:
    DBF     d1,loop
    MOVE    #0,$dff034
    BCLR    d3,$200(a0)
    ADD     d0,d0
    SWAP    d0

    MOVE    $dff00a,d1
    MOVE    d1,d0
    LSR     #1,d0
    EOR     d0,d1
    AND     #$101,d1
    AND     #$101,d0
    ROR.b   #1,d1
    ROR.b   #1,d0
    LSR     #5,d1
    LSR     #7,d0
    OR      d1,d0
    MOVE.l  d0,joystatus
    MOVEM.l (a7)+,d2-d4
    RTS

porty:   Dc.w    1

End Statement
;----------------
Statement GetJoy32{}
    MOVE.l  joystatus1,d7   ;d0/d1/d2/d3

doitgj32:
    MOVEQ   #1,d2
    MOVEQ   #1,d3
    MOVEQ   #1,d4

    BTST    #22,d7      ;red button
    BEQ     nored
    MOVEQ   #0,d2
nored:
    BTST    #23,d7      ;blue? - (grn=20/yel=21)
    BEQ     noblue
    MOVEQ   #0,d3
noblue:
    BTST    #20,d7      ;grn? - (grn=20/yel=21)
    BEQ     nogrn
    MOVEQ   #0,d4
nogrn:

    MOVEQ   #0,d0
    MOVEQ   #0,d1

    BTST    #0,d7   ;right?
    BEQ     nori
    MOVE.w  #1,d0
nori:
    BTST    #1,d7   ;left?
    BEQ     nole
    MOVE.w  #-1,d0
nole:
    BTST    #2,d7   ;down?
    BEQ     nodn
    MOVE.w  #1,d1
nodn:
    BTST    #3,d7   ;up?
    BEQ     noup
    MOVE.w  #-1,d1
noup:

    MOVE.w  d0,xjoy
    MOVE.w  d1,yjoy
    MOVE.w  d2,rbut
    MOVE.w  d3,bbut
    MOVE.w  d4,gbut


    RTS

joystatus:   Dc.l    0   ;up down fire etc
joystatus1:  Dc.l    0
joyport:     Dc.w    1   ;port #

xjoy:        Dc.w    0
yjoy:        Dc.w    0
rbut:        Dc.w    0
bbut:        Dc.w    0
gbut:        Dc.w    0

End Statement
;-----------------
Function.w getjoyx{}
    MOVE.w  xjoy,d0
    RTS
End Function
;-----------------
Function.w getjoyy{}
    MOVE.w  yjoy,d0
    RTS
End Function
;-----------------
Function.w getjb{}
    MOVEQ   #0,d0
    TST.w   rbut
    BNE     norb
    MOVEQ   #1,d0
norb:
    TST.w   bbut
    BNE.w   nobb
    MOVEQ   #2,d0
nobb:
    TST.w   gbut
    BNE.w   nogg
    MOVEQ   #3,d0
nogg:
    RTS

End Function
;-----------------

;Runerrson

;------------------------------------------------------------
.initvars

Dim polly.coor(3,5)
Dim pollyd.coor(5)
Dim melt.w(320)
Dim melty.q(320)

Dim hiscore.l(10)
Dim hiname$(10)

hiname$(1)="BOB"
hiname$(2)="PAUL"
hiname$(3)="ZOMB1"
hiname$(4)="ZOMB2"
hiname$(5)="ZOMB3"
hiname$(6)="ZOMB4"
hiname$(7)="ZOMB5"
hiname$(8)="ZOMB6"

hiscore(1)=83205950
hiscore(2)=13765825
hiscore(3)=250000
hiscore(4)=100000
hiscore(5)=50000
hiscore(6)=40000
hiscore(7)=20000
hiscore(8)=10000

Dim zomb.zombie(11)
Dim spray.blood(60)
Dim drib.dribble(50)
Dim drib2.dribble(50)

Dim ebar.w(8)
ebar(0)=17
ebar(1)=17
ebar(2)=16
ebar(3)=23
ebar(4)=22
ebar(5)=21
ebar(6)=9
ebar(7)=10
ebar(8)=11

INCLUDE "zNumberInc.bb"

hit.q=0
ti.l=0
count.l=0
;------------------------------------------------------------
.initdisplay

BitMap 4,320+64,256+32,7
BitMap 5,320+64,256+32,7

BitMap 6,320+64,256+32,7    ;spare!!

BitPlanesBitMap 4,0,%0111111    ;main 6 planes ...
BitPlanesBitMap 5,1,%0111111
BitPlanesBitMap 4,2,%1000000    ;overlay red...
BitPlanesBitMap 5,3,%1000000

tp.l=$10000+$3000+$400+$7

InitCopList 0,44,256,tp,8,128,0

Buffer 0,60000
Buffer 1,60000

InitCopList 1,44,256,0,0,0,0
;------------------------------------------------------------
.loadstuff

gameon=0

LoadBlitzFont 0,"zombie.font"

LoadShape 0,"pointer.iff"
GetaSprite 0,0
LoadShape 898,"II.IFF"

LoadBitMap 0,"titlescreen.iff",0    ;title screen palette
CopyBitMap 4,5
CopyBitMap 4,6
;LoadPalette 1,"titlescreen.iff"
LoadPalette 4,"titlescreen.iff"

LoadSound 0,"chaingun.sfx"
LoadSound 1,"reload.sfx"

For l=1 To 11
    LoadSound 4+l,"die"+Str$(l)+".sfx"  ;5-15
Next
For l=1 To 8
    LoadSound 19+l,"splat"+Str$(l)+".sfx"  ;20-27
Next

For l=1 To 4
    LoadSound 29+l,"rico"+Str$(l)+".sfx"  ;30-33
Next

LoadSound 2,"missile.sfx"
LoadSound 3,"explosion.sfx"

LoadShapes 900,"font16.shp"

LoadShapes 700,"powerups.shp"
LoadShapes 800,"blooddrop.shp"
LoadShapes 810,"bloodsplat.shp"
LoadShapes 820,"bodyparts.shp"
LoadShapes 840,"bloodsplat2.shp"
LoadShapes 850,"smoke.shp"      ;850-856
LoadShapes 860,"explosion.shp"  ;860-879

LoadShapes 0,"zombies.shp"

LoadMedModule 0,"zombie2.mod"

LoadPalette 5,"backdrop1.iff"

BLITZ
BlitzKeys On
CreateDisplay 0
DisplayBitMap 0,4
DisplayPalette 0,0
copaddr.l=Addr CopList(0)

players=1
cheat=0

Mouse On
;MouseII On
MouseArea 0,0,320,200
;MouseAreaII 0,0,320,200

SetInt 5
    Gosub DoInt
End SetInt

BitMapOutput 0
Use BitMap 0

db=0

;--------------------------------------------------------------------
Statement blitprint{x,y,t$}

    If t$<>""
        For l=1 To Len(t$)
            a$=Mid$(t$,l,1)
            a$=UCase$(a$)
            If a$=>"A" AND a$<="Z"
                bn=Asc(a$)-Asc("A")
            EndIf
            If a$=>"0" AND a$<="9"
                bn=Asc(a$)-Asc("0")+26
            EndIf

            Blit 900+bn,x,y
            x+ShapeWidth(900+bn)+2

        Next
    EndIf
End Statement
;--------------------------------------------------------------------
Statement cblitprint{y,t$}

    If t$<>""
        ww=0
        For l=1 To Len(t$)
            a$=Mid$(t$,l,1)
            a$=UCase$(a$)
            If a$=>"A" AND a$<="Z"
                bn=Asc(a$)-Asc("A")
            EndIf
            If a$=>"0" AND a$<="9"
                bn=Asc(a$)-Asc("0")+26
            EndIf
            If a$=" " Then bn=0

            ww+ShapeWidth(900+bn)+2
        Next

        x=(320-ww)/2

        For l=1 To Len(t$)
            a$=Mid$(t$,l,1)
            a$=UCase$(a$)
            If a$=>"A" AND a$<="Z"
                bn=Asc(a$)-Asc("A")
            EndIf
            If a$=>"0" AND a$<="9"
                bn=Asc(a$)-Asc("0")+26
            EndIf
            If a$=" "
                bn=0
            Else
                Blit 900+bn,x,y
            EndIf
            x+ShapeWidth(900+bn)+2
        Next

    EndIf

End Statement
;--------------------------------------------------------------------
;Goto initgame
;--------------------------------------------------------------------
.frontend

MouseArea 0,0,320,200

StartMedModule 0
SetMedVolume 64
music=1

For l=64 To 127
    AGAPalRGB 4,l,100,100,100
Next
AGAPalRGB 4,65,101,102,103

dofe:

Use BitMap 4
Cls
Scroll 0,0,320,256,0,0,6
Use BitMap 5
Cls
Scroll 0,0,320,256,0,0,6

DisplayPalette 0,4
VWait 35
Gosub dotitlescale

For l=1 To 260
    VWait
    If Joyb(0)<>0 OR Joyb(1)<>0
        Pop For
        fade=6
        Goto initgame
    EndIf
Next
Gosub meltscreen
fade=6
While fade<>0
    VWait
Wend
If startgame=1 Then Goto initgame


Gosub creditspage
If startgame=1 Then Goto initgame

Gosub howtopage
If startgame=1 Then Goto initgame

DisplayPalette 0,0
Gosub drawhitable
If startgame=1 Then Goto initgame

plasma=1
plascol.q=Rnd(1)
plccc=0
For lll=0 To 450
    VWait
    If Joyb(0)<>0 OR Joyb(1)<>0 Then startgame=1:Pop For:Goto opik
Next

opik:
plasma=0
fadered=8
While fadered<>0
    VWait
Wend
fade=8
While fade<>0
    VWait
Wend
If startgame=1 Then Goto initgame

Goto dofe

;--------------------------------------------------------------------
.initgame

control=0       ;mouse!!
If Joyb(1)<>0 Then control=1    ;crappy joypad!!! SUX SUX SUX!!

gameon=0

nextpow.w=Int(Rnd(10))MOD 5

While fade<>0
    VWait
Wend

music=0:VWait 2
StopMed

clips1=5        ;how many machine gun clips?
numperclip1=200
bullets1=200     ;how many bullets in this clip??
loaded1=0       ;reloaded??
missiles1=0
grenades1=0

gunpower1.q=.5

clips2=5        ;how many machine gun clips?
numperclip2=150
bullets2=0     ;how many bullets in this clip??
loaded2=0       ;reloaded??

level=0

energy1=16
energy2=16
score1.l=0
score2.l=0
nextfree.l=100000


numperfect.q=0

If cheat=1
    level=15
    clips1=500
    gren