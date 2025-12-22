; ESCAPE FROM JOVI
;
; Written by O.Wagner
;            Landsberge 5
;            4322 Sprockhövel 2
;            West Germany
;
; This program is SHAREWARE!
; It may be copied for any
; purpose (except selling), as
; long as the copying license
; is included. 
; If you like this program, please
; send a donation (about 10,-DM, $8)
; to the author. Include a disk to 
; obtain new levels, instructions
; and tools to create your own!
; If these donation will cover my
; expenses, I will release more
; programms on this way!


; This source is for the SEKA assembler!

rp1=$55dc0
rp2=$55ec0

; Lib-Offsets

; Dos
Open= -30
Close= -36
Read= -42
Write= -48

; Exec
AllocAbs= -204
OldOpenLib= -408

; Gfx
InitBitmap= -390
InitRastPort= -198
Move= -240
RectFill= -306
SetAPen= -342
SetBPen= -348
SetDrMd= -354
Text= -60
WaitTOF= -270
Draw= -246
CopInit= 50

 move.l 4.w,a6
 lea $50000,a1
 move.l #$20000,d0
 jsr AllocAbs(a6)
 lea dosname,a1
 jsr OldOpenLib(a6)
 move.l d0,dosbase
 lea gfxname,a1
 jsr OldOpenLib(a6)
 move.l d0,gfxbase

; load data
 bsr.L loaddat
 bsr.l loadhi

; grafix setup
 bsr.L initrps
 bsr.l initpf
 move.l CopInit(a6),gfxsave
 move.l #clist,CopInit(a6)
 
; some sound setup
 move.l #svoid,d0
 move.l d0,$dff0a0
 move.l d0,$dff0b0
 move.l d0,$dff0c0
 move.l d0,$dff0d0
 moveq #1,d0
 move d0,$dff0a4
 move d0,$dff0b4
 move d0,$dff0c4
 move d0,$dff0d4
 move #$800f,$dff096

mainloop:
 bsr.l start_muzak
 bsr.L introtitle
 bsr.l stop_muzak
 move.w #$800f,$dff096
 move.l #clist,CopInit(a6)

 move.b #-1,ships
 btst #6,$bfe001
 beq.s cheat
 move.b #3,ships
cheat:
 clr.w score
 clr.b level
 move.b #145,maxfuel
 move.b #99,maxtime
 bsr.L cls
leveloop:
 lea rp1,a1
 moveq #1,d0
 jsr SetAPen(a6)
 lea pleasewait,a0
 moveq #115,d0
 move d0,d1
 bsr.l print
 bsr.l viewscore
 move.b level,d0
 bsr.l loadlevel 
gameloop:
 move #1070,d0
 bsr.l gotoline
 bsr.l fadein
 move.b #130,$56001
 bsr.l spriteon
 move.b maxfuel,fuel
 move.l #1070*1024,ypos
 move.l #260*1024,xpos
 clr xspe
 clr yspe
 move.b maxtime,time
 bsr.L viewscore
 bsr.l viewships
 bsr.l viewhi
 bsr.l viewtime
 bsr.l viewfuel
 move.b #50,tcount
 move #%11010011010,$dff098
 move $dff00e,d0
maingameloop:
 jsr WaitTOF(a6)
 subq.b #1,rcount
 bne.s mgl99
 rol #1,$56012
 move.b #6,rcount
mgl99:
 subq.b #1,tcount
 bne.s mgl1
 subq.b #1,time
 beq.L crash
 move.b #50,tcount
mgl1: 
 clr.l d1
 clr d7
 tst.b fuel
 beq.L mgl6 ; no fuel left
 bsr.l joyask
 move d0,d7
 bne.s mgls
 bsr.L soff
 bra.s mgl6
mgls:
 move.l #$5f000,$dff0d0
 move #1486/2,$dff0d4
 move #415,$dff0d6
 move #35,$dff0d8
 move.l #$5f000,$dff0c0
 move #1486/2,$dff0c4
 move #451,$dff0c6
 move #29,$dff0c8
 
 subq.b #1,fuelc
 bne.s mgl6
 subq.b #1,fuel
 move.b #20,fuelc
mgl6:
 move d7,d0
 btst #2,d0
 beq.s mgl2
 sub #15,yspe
mgl2:
 btst #3,d0
 beq.s mgl4
 add #14,yspe
mgl4:
 addq #5,yspe
 move yspe,d1
 bmi.s mgl3
 add.l d1,ypos
 bra.s mgl5
mgl3:
 neg d1
 sub.l d1,ypos
mgl5:
 btst #0,d0
 beq.s mgl7
 sub #14,xspe
mgl7:
 btst #1,d0
 beq.s mgl8
 add #14,xspe
mgl8:
 clr.l d1
 move xspe,d1
 bpl.s mgl9
 neg d1
 sub.l d1,xpos
 bra.s mgl10
mgl9:
 add.l d1,xpos

mgl10:
 move.l xpos,d1
 asr.l #8,d1
 asr.l #2,d1
 bclr #0,$56003
 btst #0,d1
 beq.s mgl11
 bset #0,$56003
mgl11: 
 asr #1,d1
 move.b d1,$56001

 move.l ypos,d0
 asr.l #8,d0
 asr.l #2,d0
 move.l d0,d7
 bsr.l gotoline  
 cmp #50,d7
 ble.L youmadeit 
 move $dff00e,d0
 and #%100010,d0
 bne.s crash
 bsr.l viewfuel
 bsr.l viewtime
 bra.L maingameloop 

crash:
 bsr.l bumm
 bsr.l viewtime
 bsr.l spriteoff
 bsr.L fadeout

 subq.b #1,ships
 bsr.L viewships
 tst.b ships
 bne.L gameloop
 bsr.l dohiscore
 lea rp1,a1
 moveq #1,d0
 jsr SetDrMd(a6)
 moveq #1,d0
 jsr SetAPen(a6)
 moveq #0,d0
 jsr SetBPen(a6)
 lea gameovert,a0
 move #115,d0
 move #115,d1
 bsr.l print
 moveq #85,d3
gameoverw2:
 jsr WaitTOF(a6)
 dbf d3,gameoverw2
 bra.L mainloop
youmadeit:
 bsr.l soff
 lea rp1,a1
 moveq #1,d0 
 jsr SetDrMd(a6)
 moveq #3,d0
 jsr SetAPen(a6)
 moveq #0,d0
 jsr SetBPen(a6)
 lea ymit,a0
 move #102,d0
 move #80,d1
 bsr.l print
 clr.l d0
 clr.l d1
 move.b fuel,d0
 move.b time,d1
 add d0,d1
 moveq #0,d0
 move.b level,d0
 addq.b #1,d0
 mulu d0,d1
 add d1,score
 addq.b #1,level
 bsr.L spriteoff
 bra.L leveloop
xpos: dc.l 160*1024
ypos: dc.l 1070*1024
xspe: dc.w 0
yspe: dc.w 0
 
ymit: dc.b "YOU MADE IT!",0
gameovert: dc.b "GAME OVER",0
even
score: dc.w 0
ships: dc.b 0
level: dc.b 0
fuel: dc.b 200
maxfuel: dc.b 145
fuelc: dc.b 10
time: dc.b 99
maxtime: dc.b 99
tcount: dc.b 50
rcount: dc.b 5

pleasewait:
 dc.b "GET READY",0
even
dosname:
 dc.b "dos.library",0
dosbase:
 dc.l "WWS"
gfxname:
 dc.b "graphics.library",0,"!"
gfxsave:
 dc.l "WWS"
gfxbase:
 dc.l "WWS"
clist:
 dc.w $00e0,$0005,$00e2,$0000
 dc.w $00e4,$0006,$00e6
add1:
 dc.w $000
 dc.w $00e8,$0005,$00ea,8000
 dc.w $00ec,$0006,$00ee
add2:
 dc.w $000
 dc.w $00f0,$0005,$00f2,16000

 dc.w $0120,$0005,$0122
spadd:
 dc.w $6000


 dc.w $0100,%101011000000000
 dc.w $0102,0
 dc.w $0092,$0038,$0094,$00d0
 dc.w $008e,$2c81,$0090,$f4c1

 dc.w $0180,0
 dc.w $0182,$0f00
 dc.w $0184,$0555
 dc.w $0186,$0777
 dc.w $0188,$0999
 dc.w $018a,$0bbb
 dc.w $018c,$0ddd
 dc.w $018e,$0

 dc.w $01a2
spcol:
 dc.w $04a4

 dc.w $0196
pf2clr:
 dc.w $0c80

 dc.w $3701,$ff00,$0182,$0d00
 dc.w $3a01,$ff00,$0182,$0a00
 dc.w $4001,$ff00,$0182,$0f00
 dc.w $4b01,$ff00,$0182,$0d00
 dc.w $4f01,$ff00,$0182,$0a00

 dc.w $5501,$ff00,$0182,$0565
 dc.w $6501,$ff00,$0182,$0fff
 dc.w $6d01,$ff00,$0182,$0565

 dc.w $7401,$ff00,$0182,$004e
 dc.w $7d01,$ff00,$0182,$004b
 dc.w $8001,$ff00,$0182,$0048

 dc.w $8601,$ff00,$0182,$00f5
 dc.w $9201,$ff00,$0182,$00e5
 dc.w $9c01,$ff00,$0182,$00d4
 dc.w $a601,$ff00,$0182,$00c4
 dc.w $b001,$ff00,$0182,$00b3

 dc.w $c001,$ff00,$0182,$0c40
 dc.w $e001,$ff00,$0182,$0fff

 dc.w $ffff,$fffe

spritedat:
 dc.w $a085,$aa00
 dc.w %0000001111000000,0
 dc.w %0001111001111000,0
 dc.w %0011111111111100,0
 dc.w %1111111111111111,%1110111011101110
 dc.w %1111111111111111,0
 dc.w %0111111111111110,0
 dc.w %0001000000001000,0
 dc.w %0001000000001000,0
 dc.w %0010100000010100,%0001000000001000
 dc.w %0111110000111110,0
 dc.l 0
gotoline: ; line -> d0
 mulu #40,d0
 move d0,add1
 move d0,add2
 rts

spriteon:
 move.w #$6000,spadd
 move $dff00e,scorebuff
 rts
spriteoff:
 move.w #$6040,spadd
 rts

initrps:
 lea spritedat,a0
 lea $56000,a1
 moveq #10,d0
initrps1:
 clr.l $40(a1)
 move.l (a0)+,(a1)+
 dbf d0,initrps1
 lea bm1,a0
 moveq #3,d0
 move #320,d1
 move #200,d2
 jsr InitBitMap(a6)
 lea bm2,a0
 moveq #1,d0
 move #320,d1
 move #1424,d2
 jsr InitBitMap(a6)
 lea rp1,a1
 jsr InitRastPort(a6) 
 move.l #bm1,rp1+4
 lea rp2,a1
 jsr InitRastPort(a6)
 move.l #bm2,rp2+4
 rts
bm1:
 dc.l 0,0,$50000,$50000+8000,$50000+8000
bm2:
 dc.l 0,0,$60000

coltab:
 dc.w $0c80,$0b70,$0a60,$0960,$0850,$0740,$0640,$0530
 dc.w $0320,$0220,$0110,0
fadein:
 lea coltab+22,a0
 lea pf2clr,a1
 moveq #10,d0
fadein1:
 move.w -(a0),(a1)
 move.w #$2fff,d1
fadein2:
 dbf d1,fadein2
 dbf d0,fadein1
 rts
fadeout:
 lea coltab,a0
 lea pf2clr,a1
 moveq #11,d0
fadeout1:
 move.w (a0)+,(a1)
 move.w #$2fff,d1
fadeout2:
 dbf d1,fadeout2
 dbf d0,fadeout1
 rts
 

initpf:
 lea rp2,a1
 moveq #0,d0
 jsr SetAPen(a6)
 moveq #0,d0
 move d0,d1
 move #319,d2
 move #199,d3
 jsr RectFill(a6)
 lea rp2,a1
 moveq #1,d1
 jsr SetAPen(a6)
 moveq #0,d0
 move #1224,d1
 move #319,d2
 move #1423,d3
 jsr RectFill(a6)


print: ; add -> a0, x -> d0, y -> d1
 move.l a3,-(sp)
 move.l a0,a3
 lea rp1,a1
 jsr Move(a6)
 moveq #0,d0
 move.l a3,a0
 lea rp1,a1
print1:
 addq #1,d0
 tst.b (a3)+
 bne.s print1
 subq #1,d0
 move.l (sp)+,a3
 jmp Text(a6)

title:
 lea rp1,a1
 moveq #0,d0
 jsr SetDrMd(a6)
 bsr.L cls
 lea rp1,a1
 moveq #1,d0
 jsr SetAPen(a6)
 lea ttxt1,a0
 moveq #76,d0
 moveq #63,d1
 bsr.s print
 lea rp1,a1
 move #90-16,d0
 move #52,d1
 jsr Move(a6)
 move #236,d0
 move #52,d1
 jsr Draw(a6)
 move #90-16,d0
 move #68,d1
 lea rp1,a1
 jsr Move(a6)
 move #220+16,d0
 move #68,d1
 jsr Draw(a6) 

 lea hinames+48,a5
 lea hiscores+8,a4
 moveq #4,d7
writescores:
 lea rp1,a1
 move #133,d0
 move d7,d1
 mulu #10,d1
 add #100,d1
 move d1,d6
 jsr Move(a6)
 move.l a5,a0
 moveq #12,d0
 jsr Text(a6) 
 move.w (a4),d0
 move #83,d1
 move d6,d2
 bsr.L pscore
 sub.l #12,a5
 sub.l #2,a4
 dbra d7,writescores  
 lea ttxt2,a0
 moveq #40,d0
 move #190,d1
 bsr.L print
 lea ttxt3,a0
 moveq #81,d0
 move #165,d1
 bsr.l print
 lea ttxt4,a0
 moveq #108,d0
 moveq #85,d1
 bsr.l print
 rts

ttxt4:
 dc.b "HALL OF FAME",0
ttxt3:
 dc.b "PRESS FIRE TO START",0
ttxt2:
 dc.b "Written and © 1989 by O.Wagner",0
ttxt1:
dc.b "ESCAPE FROM JOVI III",0
even

hiscores:
 dc.w 500,400,300,200,100
hinames:
 dc.b "Greetinx to:"
 dc.b "Mr&Mrs Byrne"
 dc.b " Ray J.B.F. "
 dc.b " Michael K. "
 dc.b " Thomas W.  "
 dc.b " Jens Sch.  "
 
pscore:
 movem.l d3/d4,-(sp)
 lea scorebuff,a0
 move d0,d3
 divu #10000,d3 
 move d3,d4
 mulu #10000,d3
 sub d3,d0
 add.b #"0",d4
 move.b d4,(a0)+
 move d0,d3
 divu #1000,d3
 move d3,d4
 mulu #1000,d3
 sub d3,d0
 add.b #"0",d4
 move.b d4,(a0)+
 
 move d0,d3
 divu #100,d3
 move d3,d4
 mulu #100,d3
 sub d3,d0
 add.b #"0",d4
 move.b d4,(a0)+
 move d0,d3
 divu #10,d3
 move d3,d4
 mulu #10,d3
 sub d3,d0
 add.b #"0",d4
 move.b d4,(a0)+
 add.b "0",d0
 move.b d4,(a0)
 lea scorebuff,a0
 move d1,d0
 move d2,d1
 bsr.L print
 movem.l (sp)+,d3/d4
 rts
scorebuff:
 dc.b "00000",0

cls:
 lea rp1,a1
 moveq #0,d0
 jsr SetAPen(a6)
 moveq #10,d0
 moveq #50,d1
 move #310,d2
 move #192,d3
 jmp RectFill(a6)

introtitle:
 bsr.l spriteoff
 bsr.L title
 moveq #0,d7
 move d7,d0
 bsr.l gotoline
 move #$0c80,pf2clr

wait:
 move d7,d0
 bsr.l gotoline 
 addq #1,d7
 cmp #1199,d7
 beq.s wait2
wait1:
 jsr WaitTOF(a6)
 btst #7,$bfe001
 beq.s waitcont
 bra.s wait
wait2:
 move d7,d0
 bsr.l gotoline
 subq #1,d7
 beq.s wait
 jsr WaitTOF(a6)
 btst #7,$bfe001
 beq.s waitcont
 bra.s wait2
waitcont:
 bsr.s cls
 rts

loadlevel:
 move.b d0,scorebuff
 bsr.L fadeout
 move.b scorebuff,d0
 cmp.b levinmem,d0
 beq.L loadlevelret
loadlevel1:
 move.l dosbase,a6
 move.b d0,levinmem
 ext.w d0
 ext.l d0
 move.l d0,d1
 divu #10,d1
 add.b #"0",d1
 move.b d1,levname+1
loadit:
 divu #10,d0
 swap d0
 add.b #"0",d0
 move.b d0,levname+2
 move.l #levname,d1
 move.l #1005,d2 ; ACCESS_READ
 jsr Open(a6) 
 tst.l d0
 bne.s loadlevel2
 moveq #0,d0 ; now, have to
 clr.b level ; start over
 sub.b #10,maxfuel ; things getting
 sub.b #10,maxtime ; harder...
 addq.b #1,ships
 bra.s loadlevel1
loadlevel2:
 move.l d0,d6
 move.l d6,d1
 move.l #$61f40,d2
 move.l #40960,d3
 jsr Read(a6)
 move.l d6,d1
 jsr Close(a6)
 move.l gfxbase,a6  
 move.l #clist,CopInit(a6)
loadlevelret:
 bra.L cls
levinmem:
 dc.b 0
even
levname:
 dc.b "l00",0
buff:
 dc.w 0 

viewships:
 move.b ships,d0
 add.b #"0",d0
 move.b d0,buff
 move #194,d0
 move #14,d1
 lea rp1,a1
 jsr Move(a6)
 lea buff,a0
 lea rp1,a1
 moveq #1,d0
 jmp Text(a6)

viewhi:
 move hiscores,d0
 move #250,d1
 moveq #14,d2
 bra.L pscore
 
viewfuel:
 lea rp1,a1
 move #33,d1
 move #60,d0
 jsr Move(a6)
 move #33,d1
 moveq #0,d0
 move.b fuel,d0
 add #60,d0
 jsr Draw(a6)
 lea rp1,a1
 moveq #7,d0
 jsr SetAPen(a6)
 move #33,d1
 move #210,d0
 jsr Draw(a6)
 moveq #1,d0
 lea rp1,a1
 jmp SetAPen(a6)
  
viewtime:
 lea rp1,a1
 move #285,d0
 move #36,d1
 jsr Move(a6)
 clr.l d0
 move.b time,d0
 divu #10,d0
 move d0,d1
 mulu #10,d0
 move.b time,d2
 sub d0,d2
 add.b #"0",d1
 move.b d1,buff
 lea buff,a0
 add.b #"0",d2
 move.b d2,buff+1
 moveq #2,d0
 jmp Text(a6) 

viewscore:
 lea rp1,a1
 moveq #2,d0
 jsr SetAPen(a6)
 moveq #7,d0
 jsr SetBPen(a6)
 moveq #1,d0
 jsr SetDrMd(a6)
 move score,d0
 move #73,d1
 move #14,d2
 bra.L pscore

joyask:
 clr.l d0
 movem.l d1-d3,-(sp)
 move.w $dff00c,d1
 btst #9,d1
 beq.s joyask1
 bset #0,d0
joyask1:
 btst #1,d1
 beq.s joyask2
 bset #1,d0
joyask2:
 move d1,d2
 move d1,d3
 and #2,d2
 and #1,d3
 asr #1,d2
 eor d2,d3
 beq.s joyask3
 bset #3,d0
joyask3:
 move d1,d2
 move d1,d3
 and #256,d2
 and #512,d3
 asr #1,d3
 eor d2,d3
 beq.s joyask4
 bset #2,d0
joyask4:
 btst #7,$bfe001
 bne.s joyask5
 bset #7,d0
joyask5:
 movem.l (sp)+,d1-d3
 rts

dohiscore:
 move score,d0
 cmp hiscores+8,d0
 bge.s dohiscore1
 rts
dohiscore1:
 move.l #"    ",hiscon
 move.l #"    ",hiscon+4
 move.l #"    ",hiscon+8
 bsr.L cls
 lea rp1,a1
 moveq #1,d0
 jsr SetAPen(a6)
 moveq #0,d0
 jsr SetDrMd(a6)
 lea shs1,a0
 move #40,d0
 move #78,d1
 bsr.l print
 lea shs2,a0
 move #56,d0
 move #108,d1
 bsr.l print
 lea shs3,a0
 move #56,d0
 move #124,d1
 bsr.l print
 lea shs4,a0
 move #56,d0
 move #140,d1
 bsr.l print 
 lea rp1,a1
 move #105,d0
 move #186,d1
 jsr Move(a6)
 move #207,d0
 move #186,d1
 jsr Draw(a6) 
 moveq #2,d0
 jsr SetDrMd(a6)
 moveq #1,d6
 move d6,d7
 moveq #0,d5
 lea hiscon,a5
 bsr.L drawhiblock
dohiloop:
 bsr.L joyask
 tst.b d0
 beq.s dohiloop
 move.b d0,scorebuff
 bsr.L drawhiblock
 move.b scorebuff,d0
 btst #0,d0
 beq.s dohiloop1
 subq #1,d6
 bne.s dohiloop1
 moveq #13,d6
dohiloop1:
 btst #1,d0
 beq.s dohiloop2
 addq #1,d6
 cmp #14,d6
 bne.s dohiloop2
 moveq #1,d6
dohiloop2:
 btst #2,d0
 beq.s dohiloop3
 subq #1,d7
 bne.s dohiloop3
 moveq #3,d7
dohiloop3:
 btst #3,d0
 beq.s dohiloop4
 addq #1,d7
 cmp #4,d7
 bne.s dohiloop4
 moveq #1,d7
dohiloop4:
 btst #7,d0
 bne.s dohientry
 bsr.L drawhiblock
dohiwait:
 move #9,d4
dohiloop5:
 jsr WaitTOF(a6)
 dbf d4,dohiloop5
 bra.s dohiloop
dohientry:
 bsr.L drawhiblock
 move d6,d0
 move d7,d1
 subq #1,d0
 subq #1,d1
 mulu #13,d1
 add d1,d0
 lea scht,a0
 move.b (a0,d0),d0
 cmp.b #"~",d0
 beq.s dohirub
 cmp.b #"`",d0
 beq.s dohiend
 cmp.b #12,d5
 beq.L dohiwait 
 move.b d0,(a5,d5)
 addq.b #1,d5
dohiwrite:
 lea rp1,a1
 moveq #1,d0
 jsr SetDrMd(a6)
 moveq #0,d0
 jsr SetBPen(a6)
 moveq #1,d0
 jsr SetAPen(a6)
 move.l a5,a0
 move #108,d0
 move #183,d1
 bsr.l print
 bra.s dohiwait 
 rts
dohirub:
 tst.b d5
 beq.L dohiwait
 subq.b #1,d5
 move.b #" ",(a5,d5)
 bra.L dohiwrite
dohiend:
 move score,d0
 moveq #4,d1
 cmp hiscores+6,d0
 ble.L dohiname
 move hiscores+6,hiscores+8
 move.l hinames+36,hinames+48
 move.l hinames+40,hinames+52
 move.l hinames+44,hinames+56
 moveq #3,d1
 cmp hiscores+4,d0
 ble.L dohiname
 move hiscores+4,hiscores+6
 move.l hinames+24,hinames+36
 move.l hinames+28,hinames+40
 move.l hinames+32,hinames+44
 moveq #2,d1
 cmp hiscores+2,d0
 ble.s dohiname
 move hiscores+2,hiscores+4
 move.l hinames+12,hinames+24
 move.l hinames+16,hinames+28
 move.l hinames+20,hinames+32
 moveq #1,d1
 cmp hiscores,d0
 ble.s dohiname
 move hiscores,hiscores+2 
 move.l hinames,hinames+12
 move.l hinames+4,hinames+16
 move.l hinames+8,hinames+20
 moveq #0,d1
dohiname:
 move d1,d2
 rol #1,d2
 lea hiscores,a0
 move d0,(a0,d2)
 lea hinames,a0
 mulu #12,d1
 move.l hiscon,(a0,d1)
 move.l hiscon+4,4(a0,d1)
 move.l hiscon+8,8(a0,d1)
; now we gonna save the list
 move.l gfxsave,CopInit(a6)
 move.l dosbase,a6
 move.l #hilistname,d1
 move.l #1006,d2 ; ACCESS_WRITE
 jsr Open(a6)
 move.l d0,d7
 beq.s hiret
 move.l d0,d1
 move.l #hiscores,d2
 move.l #70,d3
 jsr -48(a6)
 move.l d7,d1
 jsr Close(a6)
hiret:
 move.l gfxbase,a6
 move.l CopInit(a6),gfxsave
 move.l #clist,CopInit(a6) 
 add #4,a7
 bra.L mainloop
 
hilistname:
 dc.b "EFJ_HiScores",0
 even
drawhiblock:
 lea rp1,a1
 moveq #2,d0
 jsr SetDrMd(a6)
 moveq #16,d1
 mulu d7,d1
 add #84,d1
 move d1,d3
 add #11,d3
 moveq #16,d0
 mulu d6,d0
 add #38,d0
 move d0,d2
 add #11,d2
 lea rp1,a1
 jmp RectFill(a6) 
 rts


scht:
 dc.b "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ~`"
shs1:
 dc.b "NEW HISCORE - ENTER YOUR NAME",0
shs2:
 dc.b "A B C D E F G H I J K L M",0
shs3:
 dc.b "N O P Q R S T U V W X Y Z",0
shs4:
 dc.b "0 1 2 3 4 5 6 7 8 9   « ×",0
even
hiscon:
 dc.b "            ",0 ; yep, 12 !
even
svoid:
 dc.w 0
bumm:
 move.l #$59000,$dff0a0
 move.l #$59000,$dff0b0
 move #19670/2,$dff0a4
 move #19670/2,$dff0b4
 move #580,$dff0a6
 move #579,$dff0b6
 move #65,$dff0a8
 move #65,$dff0b8
 move #$ffff,d0
bumm1:
 move d0,$dff1a2
 dbf d0,bumm1
 move #1,$dff0a4
 move #1,$dff0b4
 move.l #svoid,$dff0a0
 move.l #svoid,$dff0b0
soff:
 move #1,$dff0c4
 move #1,$dff0d4
 move.l #svoid,$dff0c0
 move.l #svoid,$dff0d0
 rts

loadhi:
 move.l dosbase,a6
 move.l #hilistname,d1
 move.l #1005,d2
 jsr Open(a6)
 move.l d0,d7
 beq.s loadhiret
 move.l #hiscores,d2
 move.l d0,d1
 move.l #70,d3
 jsr Read(a6)
 move.l d7,d1
 jsr Close(a6)
loadhiret:
 move.l gfxbase,a6
 rts

loaddat:
 move.l dosbase,a6
 move.l #datname,d1
 move.l #1005,d2
 jsr Open(a6)
 move.l d0,d7
 move.l #$50000,d2
 move.l d0,d1
 move.l d2,d3
 jsr Read(a6)
 move.l d7,d1
 jmp Close(a6)
datname:
 dc.b "EFJ_data",0

even
; mucke

start_muzak:
mt_init:lea     mt_data(pc),a0
        add.l   #$01d8,a0
        move.l  #$0080,d0
        moveq   #$00,d1
mt_init1:
        move.l  d1,d2
        subq.w  #1,d0
mt_init2:
        move.b  (a0)+,d1
        cmp.b   d2,d1
        bgt.s   mt_init1
        dbf     d0,mt_init2
        addq.b  #1,d2

mt_init3:
        lea     mt_data(pc),a0
        lea     mt_sample1(pc),a1
        asl.l   #$08,d2
        asl.l   #$02,d2
        add.l   #$0258,d2
        add.l   a0,d2
        moveq   #$0e,d0
mt_init4:
        move.l  d2,(a1)+
        moveq   #$00,d1
        move.w  42(a0),d1
        asl.l   #1,d1
        add.l   d1,d2
        add.l   #$1e,a0
        dbf     d0,mt_init4

        lea     mt_sample1(pc),a0
        moveq   #$00,d0
mt_clear:
        move.l  (a0,d0),a1
        clr.l   (a1)
        addq.l  #4,d0
        cmp.l   #$3c,d0
        bne.s   mt_clear

        move.b  mt_data+$1d6,mt_maxpart+1

        OpenResource=   -30-468

        movem.l d1-d7/a0-a6,-(sp)
	move.l 4.w,a6
        lea     CiaaResource(pc),a1     ;'ciaa.resource'
        moveq   #0,d0                   ;Version egal
        jsr     OpenResource(a6)        ;OpenResource()
        move.l  d0,CiaaBase             ;Resource Base speichern
        move.l  d0,a6
        bsr     PlayDisable             ;Sound DMA abschalten
        lea     Interrupt(pc),a1        ;Sound Interupt Structure
        moveq   #0,d0                   ;TimerA
        jsr     -6(A6)                  ;installieren
        move.l  d0,d5                   ;ergebnis speichern
        bsr     PlayEnable              ;Player erlauben
        bsr     InitTimer               ;Timer starten
        moveq   #0,d0                   ;Ergebnisregister loeschen
EndStart:
        tst.l   d5                      ;ergebnis von Resource
        sne     d0                      ;ergebnis in d0 setzen
        movem.l (SP)+,d1-d7/a0-a6
        rts

;---------------------------------------------------------------------------

stop_muzak:
        movem.l d1-d7/a0-a6,-(SP)
        move.l  CiaaBase(pc),a6         ;Zeiger auf Ciaa Resource
        lea     Interrupt(pc),a1        ;Zeiger auf Int. Strukture
        moveq   #0,d0                   ;Timer A
        jsr     -12(A6)                 ;Interupt entfernen
        bsr     PlayDisable             ;Player sperren
        moveq   #0,d0                   ;Alles Ok
        movem.l (SP)+,d1-d7/a0-a6
        rts
;---------------------------------------------------------------------------

Interrupt:
        dc.l    0                       ;letzter Node
        dc.l    0                       ;nächster Node
        dc.b    2                       ;Node Type = Interrupt
        dc.b    0                       ;Priorität
        dc.l    InterruptName           ;Name
        dc.l    0                       ;Zeiger auf Daten
        dc.l    IntCode                 ;Interrupt Routine

;-------------------------------------------------------------------

InitTimer:
        move.b  #%10000001,$bfee01      ;Timer starten
        lea     DelayValue(pc),a1
        move.b  1(a1),$bfe401           ;Timer A low
        move.b  0(a1),$bfe501           ;Timer A high
        rts

;--------------------------------------------------------------------

PlayEnable:
        lea     $dff000,a0              ;AMIGA
        move.w  #-1,PlayLock            ;player zulassen
        clr     $a8(A0)                 ;Alle Voloumenregs. auf 0
        clr     $b8(A0)
        clr     $c8(a0)
        clr     $d8(a0)
        clr.l   mt_partnrplay
        clr.l   mt_partnote             ;zeiger auf pos
        clr.l   mt_partpoint            ;zeiger innehalb des pattern
        rts
;----------------------------------------------------------------------

PlayDisable:
        lea     $dff000,a0              ;AMIGA
        clr.w   PlayLock                ;player sperren
        clr     $a8(a0)                 ;volumen auf 0
        clr     $b8(a0)
        clr     $c8(a0)
        clr     $d8(a0)
        move.w  #$f,$96(A0)             ;dma sperren
        rts

;---------------------------------------------------------------------

IntCode:
        movem.l d1-d7/a0-a6,-(sp)
        bsr     PlaySong                ;Note spielen
        movem.l (sp)+,d1-d7/a0-a6
        moveq   #0,d0                   ;kein Fehler
        rts

;----------------------------------------------------------------------

DelayValue:
        dc.w    14320
PlayLock:
        dc.w    0
CiaaBase:
        dc.l    0
InterruptName:
        dc      "Olli's Int",0
CiaaResource:
        dc      "ciaa.resource",0

even

PlaySong:
mt_music:
        addq.l  #1,mt_counter
mt_cool:cmp.l   #6,mt_counter
        bne.s   mt_notsix
        clr.l   mt_counter
        bra     mt_rout2

mt_notsix:
        lea     mt_aud1temp(pc),a6
        tst.b   3(a6)
        beq.s   mt_arp1
        lea     $dff0a0,a5
        bsr.s   mt_arprout
mt_arp1:lea     mt_aud2temp(pc),a6
        tst.b   3(a6)
        beq.s   mt_arp2
        lea     $dff0b0,a5
        bsr.s   mt_arprout
mt_arp2:lea     mt_aud3temp(pc),a6
        tst.b   3(a6)
        beq.s   mt_arp3
        lea     $dff0c0,a5
        bsr.s   mt_arprout
mt_arp3:lea     mt_aud4temp(pc),a6
        tst.b   3(a6)
        beq.s   mt_arp4
        lea     $dff0d0,a5
        bra.s   mt_arprout
mt_arp4:rts

mt_arprout:
        move.b  2(a6),d0
        and.b   #$0f,d0
        tst.b   d0
        beq.s   mt_arpegrt
        cmp.b   #1,d0
        beq.s   mt_portup
        cmp.b   #2,d0
        beq.s   mt_portdwn
        rts

mt_portup:
        moveq   #$00,d0
        move.b  3(a6),d0
        sub.w   d0,22(a6)
        cmp.w   #$71,22(a6)
        bpl.s   mt_ok1
        move.w  #$71,22(a6)
mt_ok1: move.w  22(a6),6(a5)
        rts

mt_portdwn:
        moveq   #$00,d0
        move.b  3(a6),d0
        add.w   d0,22(a6)
        cmp.w   #$358,22(a6)
        bmi.s   mt_ok2
        move.w  #$358,22(a6)
mt_ok2: move.w  22(a6),6(a5)
        rts

mt_arpegrt:
        cmp.l   #1,mt_counter
        beq.s   mt_loop2
        cmp.l   #2,mt_counter
        beq.s   mt_loop3
        cmp.l   #3,mt_counter
        beq.s   mt_loop4
        cmp.l   #4,mt_counter
        beq.s   mt_loop2
        cmp.l   #5,mt_counter
        beq.s   mt_loop3
        rts

mt_loop2:
        moveq   #$00,d0
        move.b  3(a6),d0
        lsr.b   #4,d0
        bra.s   mt_cont
mt_loop3:
        moveq   #$00,d0
        move.b  3(a6),d0
        and.b   #$0f,d0
        bra.s   mt_cont
mt_loop4:
        move.w  16(a6),d2
        bra.s   mt_endpart
mt_cont:
        asl.w   #1,d0
        moveq   #$00,d1
        move.w  16(a6),d1
        lea     mt_arpeggio(pc),a0
mt_loop5:
        move.w  (a0,d0),d2
        cmp.w   (a0),d1
        beq.s   mt_endpart
        addq.l  #2,a0
        bra.s   mt_loop5
mt_endpart:
        move.w  d2,6(a5)
        rts

mt_rout2:
        lea     mt_data(pc),a0
        move.l  a0,a3
        add.l   #$0c,a3
        move.l  a0,a2
        add.l   #$1d8,a2
        add.l   #$258,a0
        move.l  mt_partnrplay,d0
        moveq   #$00,d1
        move.b  (a2,d0),d1
        asl.l   #$08,d1
        asl.l   #$02,d1
        add.l   mt_partnote,d1
        move.l  d1,mt_partpoint
        clr.w   mt_dmacon

        lea     $dff0a0,a5
        lea     mt_aud1temp(pc),a6
        bsr     mt_playit
        lea     $dff0b0,a5
        lea     mt_aud2temp(pc),a6
        bsr     mt_playit
        lea     $dff0c0,a5
        lea     mt_aud3temp(pc),a6
        bsr     mt_playit
        lea     $dff0d0,a5
        lea     mt_aud4temp(pc),a6
        bsr     mt_playit
        move.w  #$01f4,d0
mt_rls: dbf     d0,mt_rls

        move.w  #$8000,d0
        or.w    mt_dmacon,d0
        move.w  d0,$dff096

        lea     mt_aud4temp(pc),a6
        cmp.w   #1,14(a6)
        bne.s   mt_voice3
        move.l  10(a6),$dff0d0
        move.w  #1,$dff0d4
mt_voice3:
        lea     mt_aud3temp(pc),a6
        cmp.w   #1,14(a6)
        bne.s   mt_voice2
        move.l  10(a6),$dff0c0
        move.w  #1,$dff0c4
mt_voice2:
        lea     mt_aud2temp(pc),a6
        cmp.w   #1,14(a6)
        bne.s   mt_voice1
        move.l  10(a6),$dff0b0
        move.w  #1,$dff0b4
mt_voice1:
        lea     mt_aud1temp(pc),a6
        cmp.w   #1,14(a6)
        bne.s   mt_voice0
        move.l  10(a6),$dff0a0
        move.w  #1,$dff0a4
mt_voice0:
        move.l  mt_partnote,d0
        add.l   #$10,d0
        move.l  d0,mt_partnote
        cmp.l   #$400,d0
        bne.s   mt_stop
mt_higher:
        clr.l   mt_partnote
        addq.l  #1,mt_partnrplay
        moveq   #$00,d0
        move.w  mt_maxpart,d0
        move.l  mt_partnrplay,d1
        cmp.l   d0,d1
        bne.s   mt_stop
        clr.l   mt_partnrplay

mt_stop:tst.w   mt_status
        beq.s   mt_stop2
        clr.w   mt_status
        bra.s   mt_higher
mt_stop2:
        rts

mt_playit:
        move.l  (a0,d1),(a6)
        addq.l  #4,d1
        moveq   #$00,d2
        move.b  2(a6),d2
        and.b   #$f0,d2
        lsr.b   #4,d2
        tst.b   d2
        beq.s   mt_nosamplechange

        moveq   #$00,d3
        lea     mt_samples(pc),a1
        move.l  d2,d4
        asl.l   #2,d2
        mulu    #$1e,d4
        move.l  (a1,d2),4(a6)
        move.w  (a3,d4),8(a6)
        move.w  2(a3,d4),18(a6)
        move.w  4(a3,d4),d3
        tst.w   d3
        beq.s   mt_displace
        move.l  4(a6),d2
        add.l   d3,d2
        move.l  d2,4(a6)
        move.l  d2,10(a6)
        move.w  6(a3,d4),8(a6)
        move.w  6(a3,d4),14(a6)
        move.w  18(a6),8(a5)
        bra.s   mt_nosamplechange

mt_displace:
        move.l  4(a6),d2
        add.l   d3,d2
        move.l  d2,10(a6)
        move.w  6(a3,d4),14(a6)
        move.w  18(a6),8(a5)
mt_nosamplechange:
        tst.w   (a6)
        beq.s   mt_retrout
        move.w  (a6),16(a6)
        move.w  20(a6),$dff096
        move.l  4(a6),(a5)
        move.w  8(a6),4(a5)
        move.w  (a6),6(a5)
        move.w  20(a6),d0
        or.w    d0,mt_dmacon

mt_retrout:
        tst.w   (a6)
        beq.s   mt_nonewper
        move.w  (a6),22(a6)

mt_nonewper:
        move.b  2(a6),d0
        and.b   #$0f,d0
        cmp.b   #11,d0
        beq.s   mt_posjmp
        cmp.b   #12,d0
        beq.s   mt_setvol
        cmp.b   #13,d0
        beq.s   mt_break
        cmp.b   #14,d0
        beq.s   mt_setfil
        cmp.b   #15,d0
        beq.s   mt_setspeed
        rts

mt_posjmp:
        not.w   mt_status
        moveq   #$00,d0
        move.b  3(a6),d0
        subq.b  #$01,d0
        move.l  d0,mt_partnrplay
        rts

mt_setvol:
        move.b  3(a6),8(a5)
        rts

mt_break:
        not.w   mt_status
        rts

mt_setfil:
        moveq   #$00,d0
        move.b  3(a6),d0
        and.b   #$01,d0
        rol.b   #$01,d0
        and.b   #$fd,$bfe001
        or.b    d0,$bfe001
        rts

mt_setspeed:
        move.b  3(a6),d0
        and.b   #$0f,d0
        beq.s   mt_back
        clr.l   mt_counter
        move.b  d0,mt_cool+5
mt_back:rts

mt_aud1temp:
        blk.w   10,0
        dc.w    $0001
        blk.w   2,0
mt_aud2temp:
        blk.w   10,0
        dc.w    $0002
        blk.w   2,0
mt_aud3temp:
        blk.w   10,0
        dc.w    $0004
        blk.w   2,0
mt_aud4temp:
        blk.w   10,0
        dc.w    $0008
        blk.w   2,0
mt_partnote:    dc.l    0
mt_partnrplay:  dc.l    0
mt_counter:     dc.l    0
mt_partpoint:   dc.l    0
mt_samples:dc.l 0
mt_sample1:blk.l 15,0
mt_maxpart:dc.w $0000
mt_dmacon:dc.w  $0000
mt_status:dc.w  $0000

mt_arpeggio:
dc.w $0358,$0328,$02fa,$02d0,$02a6,$0280,$025c
dc.w $023a,$021a,$01fc,$01e0,$01c5,$01ac,$0194,$017d
dc.w $0168,$0153,$0140,$012e,$011d,$010d,$00fe,$00f0
dc.w $00e2,$00d6,$00ca,$00be,$00b4,$00aa,$00a0,$0097
dc.w $008f,$0087,$007f,$0078,$0071,$0000,$0000,$0000

mt_data:blk.b   39144,0
