ùúùúÿö7ÿö7ÿö7ÿö7ÿö7ÿö7ÿö7ÿö7ÿö7; GADGETS

; 1 - standard - x,y,sx,sy,text,image1,image2,$80000000
; 2 - value    - x,y,sx,sy,value,minimum,maximum,$80000000
; 3 - switch   - x,y,sx,sy,default,gadget1,gadget2,...,gadgetn,0,$80000000
; 4 - nop      - x,y,sx,sy,$80000000
; 5 - text     - x,y,textstruct,$80000000
; 6 - select   - x,y,sx,sy,select,text,$80000000
; 7 - text     - x,y,textaddr

; TEXTSTRUCT

; color,x,y,'xxx SOME TEXT xxx',0

g_minx:	dc.l	0
g_miny:	dc.l	0
g_maxx:	dc.l	0
g_maxy:	dc.l	0

minxtemp:	dc.l	0
minytemp:	dc.l	0
maxxtemp:	dc.l	0
maxytemp:	dc.l	0

	even

; a0 - gadlist
; d0 - min. x
; d1 - min. y
; d2 - max. x
; d3 - max. y

drawscrollgad:

	move.l	d0,g_minx
	move.l	d1,g_miny
	move.l	d2,g_maxx
	move.l	d3,g_maxy
	bsr.s	gad_draw
	rts

; a0 - gadlist

drawgadgets:
	clr.l	g_minx
	clr.l	g_miny
	move.l	#10000,g_maxx
	move.l	#10000,g_maxy
gad_draw:
	move.l	#0,lastbutton
;	move.b	#1,lastbaton
	bsr.w	message
	movem.l	d0-d7/a0-a6,-(sp)
dgloop:
	move.l	(a0),d0		; d0 - gadtype
	tst.l	d0
	beq.s	dgend
	bsr.s	drawgadget
	bsr.s	nextgadget
	bra.s	dgloop
dgend:
	movem.l	(sp)+,d0-d7/a0-a6
	rts

; a0 - gadget
; a0 - next gadget

nextgadget:
	move.l	d0,-(sp)
seloop:
	move.l	(a0)+,d0
	cmp.l	#$80000000,d0
	bne.s	seloop
	move.l	(sp)+,d0
	rts

; a0 - gadget

drawgadget:
	bsr.w	specgad
	beq.s	drawalways
	move.l	g_miny,d3
	move.l	g_maxy,d5
	cmp.l	8(a0),d3
	bgt.s	drawg_end
	cmp.l	8(a0),d5
	ble.s	drawg_end
drawalways:
	move.l	(A0)+,d0
	subq	#1,d0
	beq.W	dgonoff
	subq	#1,d0
	beq.W	dgval
	subq	#1,d0
	beq.s	dgswitch
	subq	#1,d0
	beq.s	dgnop
	subq	#1,d0
	beq.s	dgtextonly
	subq	#1,d0
	beq.s	dgselect
	subq	#1,d0
	beq.s	dgtext
drawg_end:
	rts

dgswitch:
	movem.l	d0-d7/a0-a6,-(sp)
	movem.l	(a0)+,d0-d3
	bsr.w	ramka
	move.l	(a0)+,a0
	bsr.w	showtextstruct
	movem.l	(sp)+,d0-d7/a0-a6
	rts
dgnop:
	movem.l	d0-d7/a0-a6,-(sp)
	movem.l	(a0)+,d0-d3
	bsr.w	ramka
	movem.l	(sp)+,d0-d7/a0-a6
	rts

dgtext:
	movem.l	d0-d7/a0-a6,-(sp)
	movem.l	(a0)+,d0-d1
	move.l	(a0)+,a0
	movem.l	d0-d1,-(sp)
	moveq	#1,d0
	bsr.w	setcolor
	movem.l	(sp)+,d0-d1
	add.l	#6,d0
	bsr.w	analysetext
	bsr.w	showtext
	movem.l	(sp)+,d0-d7/a0-a6
	rts

dgtextonly:
	movem.l	d0-d7/a0-a6,-(sp)
	movem.l	(a0)+,d0-d1
	move.l	(a0)+,a0
	bsr.w	showtextstruct
	movem.l	(sp)+,d0-d7/a0-a6
	rts

dgselect
	movem.l	d0-d7/a0-a6,-(sp)
	movem.l	(a0)+,d0-d3
	bsr.w	ramka
	move.l	(a0)+,d4
	tst.l	d4
	beq.s	nosel
	bsr.w	invborder
nosel:	move.l	(a0)+,a0
	bsr.w	showtextstruct
	movem.l	(sp)+,d0-d7/a0-a6
	rts

dgval:
	movem.l	d0-d7/a0-a6,-(sp)
	movem.l	(a0)+,d0-d3
	bsr.w	ramka
	add.l	#1,d0
	add.l	#1,d1
	add.l	#-2,d2
	add.l	#-2,d3
	bsr.w	invborder
	move.l	(a0)+,d4
	bsr.s	showvalue
	movem.l	(sp)+,d0-d7/a0-a6
	rts

clearvaltext:
	movem.l	a1/d0,-(sp)
	lea	g_valtext,a1
	moveq	#7,d0
clvallopa:
	move.b	#' ',(a1)+
	dbf	d0,clvallopa
	movem.l	(sp)+,a1/d0
	rts

; d0,d1,d2,d3 - x,y,sx,sy
; d4 - value

showvalue:
	movem.l	d0-d7/a0-a6,-(sp)
	movem.l	d0-d1,-(sp)	
	move.l	#0,d0
	bsr.w	setdrmode
	ext.l	d2
	asr.l	#3,d2
	ext.l	d4
	move.l	d4,d0
	bsr.s	clearvaltext
	lea	valbuf,a0
	bsr.w	liczbadoascii
	lea	g_valtext,a1
	move.l	d2,d0
	bsr.w	valcopy
	lea	g_val,a0
	movem.l	(sp)+,d0-d1
	bsr.s	showtextstruct
	movem.l	(sp)+,d0-d7/a0-a6
	rts

dgonoff:
	movem.l	d0-d7/a0-a6,-(sp)
	cmp.l	#0,16(a0)
	beq.s	notext
	bsr.s	showtextgad
	bra.s	dgonoffend
notext:
	movem.l	(a0)+,d2-d6
	move.l	(a0)+,a0
	clr.l	d0
	clr.l	d1
	bsr.w	rysuj
dgonoffend:
	movem.l	(sp)+,d0-d7/a0-a6
	rts

; a0 - text structure
; d0 - x
; d1 - y

showtextstruct:
	movem.l	d0-d7/a0-a6,-(sp)
	movem.l	d0-d1,-(sp)
	move.b	(a0)+,d0
	ext.w	d0
	ext.l	d0
	bsr.w	setcolor
	movem.l	(sp)+,d0-d1
	move.b	(a0)+,d2
	move.b	(a0)+,d3
	ext.w	d2
	ext.w	d3
	ext.l	d2
	ext.l	d3
	add.l	d2,d0
	add.l	d3,d1
	bsr.s	analysetext
	bsr.w	showtext
	movem.l	(sp)+,d0-d7/a0-a6
	rts

showtextgad:
	movem.l	d0-d7/a0-a6,-(sp)
	movem.l	(a0)+,d0-d3
	bsr.w	ramka
	move.l	(a0)+,a0
	bsr.s	showtextstruct
	movem.l	(sp)+,d0-d7/a0-a6
	rts

analysetext:
	movem.l	a0/d0,-(sp)
	clr.l	d2
atloop:
	move.b	(a0)+,d0
	tst.b	d0
	beq.s	atend
	cmp.b	#10,d0
	beq.s	atend
	addq.l	#1,d2
	bra.s	atloop
atend:	movem.l	(sp)+,a0/d0
	rts

gadtext:
	bsr.w	dogadget
	cmp.l	#0,a0
	beq.s	nogadtext
	move.l	20(a0),a0
nogadtext:
	rts

; a0 - gadlist
; d0 - abs. pos
; d1 - line feed
; d2 - line move

calcgadpos:
	movem.l	a0/d0-d2,-(sp)
calcgadloop:
	move.l	(a0),d3
	tst.l	d3
	beq.s	calcgadend
	move.l	8(a0),d3
	add.l	d0,d3
	muls	d1,d3
	add.l	d2,d3
	move.l	d3,8(a0)
	bsr.w	nextgadget
	bra.s	calcgadloop
calcgadend:
	movem.l	(sp)+,a0/d0-d2
	rts

; a0 - gadlist

g_scrolldown:
	move.l	a0,-(sp)
	move.l	g_miny,d3
	move.l	g_maxy,d5
g_scrolluptestloop:
	move.l	#0,d2
	bsr.w	specgad
	beq.s	g_scrollhere
	movem.l	(a0)+,d0-d2
	tst.l	d0
	beq.s	g_scrollend
g_scrollhere:
	bsr.w	nextgadget
	cmp.l	d2,d5
	bgt.s	g_scrolluptestloop
	move.l	(sp),a0
	move.l	scrollspeed,d1
	neg.l	d1
	bsr.s	g_doscroll

g_scrollend:
	move.l	(sp)+,a0
	rts

g_scrollup:
	move.l	a0,-(sp)
	move.l	g_miny,d3
	move.l	g_maxy,d5
g_scrolldowntestloop:
	movem.l	(a0)+,d0-d2
	tst.l	d0
	beq.s	g_scrollend
	bsr.w	nextgadget
	cmp.l	d2,d3
	ble.s	g_scrolldowntestloop
	move.l	(sp),a0
	move.l	scrollspeed,d1
	bsr.s	g_doscroll
	bra.s	g_scrollend

; d0 - mask

setwrmask:
	move.l	a0,-(sp)
	move.l	rastport,a0
	move.b	d0,24(a0)
	move.l	(sp)+,a0
	rts

; a0 - gadlist
; d1 - dy

g_doscroll:
	move.b	scrmask,d0
	bsr.b	setwrmask
	move.l	d1,-(sp)
	move.l	d1,d7
	moveq	#-2,d1
	tst.w	d7
	bpl.s	g_doscrplus
	moveq	#2,d1
	neg.w	d7
g_doscrplus:
	asr.w	#1,d7
	sub.w	#2,d7
	moveq	#0,d0
	move.l	g_minx,d2
	move.l	g_miny,d3
	move.l	g_maxx,d4
	move.l	g_maxy,d5
g_doscrollloop:
	bsr.w	scroll
	bsr.w	wfnp
	dbf	d7,g_doscrollloop
	bsr.w	scroll
	move.l	(sp)+,d1

g_movegadpositions:
	move.l	(a0),d0
	beq.s	g_doscrollend
	bsr.w	specgad
	beq.s	g_doscrollhere
	move.l	8(a0),d0
	add.l	d1,8(a0)
	cmp.l	d3,d0
	blt.s	g_gaddraw
	cmp.l	d5,d0
	bgt.s	g_gaddraw
g_doscrollhere:
	bsr.w	nextgadget
	bra.s	g_movegadpositions
g_doscrollend:
	move.b	#$ff,d0
	bsr.b	setwrmask
	rts

g_gaddraw:
	bsr.w	drawgadget
	bra.s	g_doscrollhere

; a0 - gadlist

; a0 - gadaddr

dogadget:
	movem.l	d0-d7/a1-a6,-(sp)
	move.l	a0,actualgadgetlist
	bsr.w	gad_keys
	tst.b	mousebutton
	bne.s	nobutton
	tst.b	lastbaton
	bpl.s	dogaddal
	bsr.w	cursoff
dogaddal:
	move.l	a0,-(sp)
	move.l	window,a0
	move.w	108(a0),d0
	move.w	110(a0),d1
	move.l	(sp)+,a0
	ext.l	d0
	ext.l	d1
	bsr.w	clickdetect
	tst.b	d0
	beq.s	dgnogad
	move.b	#1,mousebutton
	tst.b	lastbaton
	bpl.W	dgaction
	move.l	a0,lastbutton
	bsr.s	gadgetdown
	movem.l	(sp)+,d0-d7/a1-a6
	rts
nobutton:
	tst.b	lastbaton
	bmi.W	pressed
dgnogad:
	tst.l	lastbutton
	beq.s	reallynogad
	move.l	lastbutton,a0
	moveq	#3,d1
	move.l	(a0),d0
	bsr.s	gadfunctions
reallynogad:
	suba.l	a0,a0
	clr.l	lastbutton
	movem.l	(sp)+,d0-d7/a1-a6
	rts

gadgetdown:
	move.l	(a0),d0
	move.l	#1,d1
	bsr.s	gadfunctions
	suba.l	a0,a0
	rts

; d0 - no
; d1 - function

gadfunctions:
	movem.l	d0-d2/a1/a6,-(sp)
	lea	gadfunctable,a1
func_loop:
	move.l	(a1),d2
	tst.l	d2
	beq.s	func_end
	cmp.l	d2,d0
	beq.s	func_yeah
	adda.l	#4*5,a1
	bra.s	func_loop
func_yeah:
	asl.l	#2,d1
	move.l	(a1,d1.w),a6
	jsr	(a6)
func_end:
	movem.l	(sp)+,d0-d2/a1/a6
	rts

gad_nop:
	suba.l	a0,a0
	rts

cursoff:
	tst.b	stringflag
	beq.s	cursoffend
	clr.b	stringflag
	move.l	a0,-(sp)
	move.l	valadr,a0
	bsr.w	drawgadget
	move.l	(sp)+,a0
cursoffend:
	rts

valgadcalc:
	movem.l	d0-d7/a0-a6,-(sp)
	lea	g_valtext,a0
	bsr.w	asciidoliczba
	move.l	valadr,a0
	move.l	d0,20(a0)
	cmp.l	24(a0),d0
	blt.s	writemin
	cmp.l	28(a0),d0
	bgt.s	writemax
	movem.l	(sp)+,d0-d7/a0-a6
	rts

writemin:
	move.l	24(a0),20(a0)
	bsr.w	flash
	movem.l	(sp)+,d0-d7/a0-a6
	rts	
writemax:
	move.l	28(a0),20(a0)
	bsr.w	flash
	movem.l	(sp)+,d0-d7/a0-a6
	rts

putcursor:
	move.l	4(a0),d0
	move.l	8(a0),d1
	move.l	12(a0),d4
	move.l	16(a0),d5
	add.l	d0,d4
	add.l	d1,d5
	add.l	#2,d0
	add.l	#2,d1
	sub.l	#2,d4
	sub.l	#2,d5
	move.l	d0,cursminx
	move.l	d4,cursmaxx
	sub.l	#8,cursmaxx
	move.l	cursmaxx,strlen
	sub.l	d0,strlen
	move.l	strlen,d6
	asr.l	#3,d6
	move.l	d6,strlen
	move.l	window,a1
	move.w	108(a1),d2
	move.w	110(a1),d3
	ext.l	d2
	ext.l	d3
	cmp.l	d0,d2
	blt.W	putend
	cmp.l	d1,d3
	blt.W	putend
	cmp.l	d4,d2
	bge.W	putend
	cmp.l	d5,d3
	bge.W	putend
	sub.l	d2,d0
	sub.l	d3,d1
	neg.l	d0
	neg.l	d1
	and.l	#$fffffff8,d0
	and.l	#$fffffff8,d1
	move.l	d0,d6
	asr.l	#3,d6
	move.l	d6,curspos
	add.l	#2,d0
	add.l	#2,d1
	add.l	4(a0),d0
	add.l	8(a0),d1
	move.l	a0,valadr
	move.l	20(a0),val
	move.l	24(a0),valmin
	move.l	28(a0),valmax
	lea	cursorbmp,a0
	move.l	d0,cursx
	move.l	d1,cursy
	move.b	#1,stringflag

	move.l	valadr,a0
	move.l	12(a0),d2
	sub.l	#4,d2
	asr.l	#3,d2
	bsr.w	clearvaltext
	lea	valbuf,a0
	move.l	val,d0
	bsr.w	liczbadoascii
	lea	g_valtext,a1
	move.l	d2,d0
	bsr.w	valcopy

	move.l	strlen,d7
	lea	g_valtext,a1
	clr.l	d0
pc_charcalc:
	cmp.b	#' ',(a1)+
	beq.s	pc_nchar
	addq	#1,d0
	dbf	d7,pc_charcalc
pc_nchar:
	move.l	d0,howmanychars
	move.l	curspos,d1
pc_putverify
	cmp.l	d1,d0
	bge.s	putOK
	subq.l	#1,d1
	sub.l	#8,cursx
	bra.s	pc_putverify

putOK:
	move.l	d1,curspos
	bsr.w	drawcursor
putend:
	suba.l	a0,a0
	rts

gad_keys:
	tst.b	stringflag
	beq.s	gad_keysend
	cmp.w	#'0',key
	blt.s	gadk_end
	cmp.w	#'9',key
	bgt.s	gadk_end
	bra.s	insval
gadk_end:
	cmp.w	#79,rawkey
	beq.W	cursleft
	cmp.w	#78,rawkey
	beq.W	cursright
	cmp.w	#8,key
	beq.W	k_backspace
	cmp.w	#127,key
	beq.W	k_delete
	cmp.w	#13,key
	beq.B	k_ENTER
	cmp.w	#0,key
	beq.s	k_nokey
	bsr.w	flash
k_nokey:
	cmp.w	#0,rawkey
	beq.s	k_norawkey
	bsr.w	flash
k_norawkey:
gad_keysend:
	rts


k_ENTER:
	bsr.w	valgadcalc
	bsr.w	cursoff
	rts

insval:
	movem.l	a0/d0-d5,-(sp)
	move.l	curspos,d0
	move.w	key,d2
	move.l	strlen,d1
	cmp.l	howmanychars,d1
	beq.s	insend
	add.l	#1,howmanychars
	lea	g_valtext,a0
	bsr.w	inschar
	moveq	#-8,d0
	moveq	#0,d1
	move.l	cursmaxx,d4
	move.l	cursy,d3
	move.l	cursx,d2
	move.l	d3,d5
	addq	#6,d5
	addq	#4,d2
	add.l	#4+8,d4
	bsr.w	scroll
	add.l	#1,curspos
	move.l	cursx,d0
	move.l	cursy,d1
	moveq	#1,d2
	lea	g_lettertext,a0
	move.b	key+1,(A0)
	lea	g_letter,a0
	bsr.w	showtextstruct
	add.l	#8,cursx
	movem.l	(sp)+,a0/d0-d5
	rts

insend:
	bsr.w	flash
	movem.l	(sp)+,a0/d0-d5
	rts

k_backspace:
	cmp.l	#0,curspos
	beq.s	curs_nomove
	movem.l	d0-d7/a0-a6,-(sp)
	sub.l	#1,curspos
	move.l	curspos,d0
	moveq	#6,d1
	lea	g_valtext,a0
	bsr.w	delchar
	moveq	#8,d0
	moveq	#0,d1
	move.l	cursmaxx,d4
	sub.l	#8,cursx
	move.l	cursx,d2
	move.l	cursy,d3
	move.l	d3,d5
	addq	#6,d5
	addq	#4,d2
	add.l	#4+8,d4
	bsr.w	scroll
	sub.l	#1,howmanychars
	movem.l	(sp)+,d0-d7/a0-a6
	rts
	
curs_nomove:
	bsr.w	flash
	rts

k_delete:
	cmp.l	#0,howmanychars
	beq.s	curs_nomove
	movem.l	d0-d7/a0-a6,-(sp)
	moveq	#8,d0
	moveq	#0,d1
	move.l	cursmaxx,d4
	move.l	cursy,d3
	move.l	cursx,d2
	move.l	d3,d5
	addq	#6,d5
	addq	#4,d2
	add.l	#4+8,d4
	bsr.w	scroll
	bsr.w	drawcursor
	move.l	curspos,d0
	moveq	#6,d1
	lea	g_valtext,a0
	bsr.s	delchar
	sub.l	#1,howmanychars
	movem.l	(sp)+,d0-d7/a0-a6
	rts

; a0 - string
; d0 - char number
; d1 - len

delchar:
	movem.l	a1/d2,-(sp)
	moveq	#-1,d2
	move.l	a0,a1
	sub.w	#2,d1
delcharloop:
	addq	#1,d2
	cmp.w	d2,d0
	beq.s	delcharloop
	move.b	(a0,d2.w),(a1)+
	dbf	d1,delcharloop
	move.b	#' ',(a1)+
	movem.l	(sp)+,a1/d2
	rts

; a0 - string
; d0 - char number
; d1 - len
; d2 - char

inschar:
	MOVEM.L	a0-a1/d0-d2,-(sp)
	move.l	a0,a1
	subq	#1,d1
	cmp.w	d1,d0
	beq.s	ins_ert
inscharloop:
	move.b	0(a0,d1.w),1(a0,d1.w)
	subq	#1,d1
	cmp.w	d1,d0
	bne.s	inscharloop
	move.b	0(a0,d1.w),1(a0,d1.w)
ins_ert:
	move.b	d2,(a0,d1.w)
	MOVEM.L	(sp)+,a0-a1/d0-d2
	rts


; d0,d1 - dx,dy
; d2,d3 - minx, miny
; d4,d5 - maxx, maxy
cursright:
	movem.l	d0-d7/a0-a6,-(sp)
	tst.b	stringflag
	beq.W	cursend

	move.l	curspos,d0
	cmp.l	howmanychars,d0
	beq.w	cursmoveend
	clr.l	d0
	clr.l	d1
	move.l	cursx,d2
	cmp.l	cursmaxx,d2
	bge.W	cursmoveend
	add.l	#8,cursx
	move.l	cursy,d3
	moveq	#16,d4
	moveq	#7,d5
	move.l	#%01011010,d6
	lea	cursormovebmp,a0
	bsr.w	rysop
	add.l	#1,curspos
	movem.l	(sp)+,d0-d7/a0-a6
	rts

drawcursor:
	clr.l	d0
	clr.l	d1
	move.l	cursx,d2
	move.l	cursy,d3
	moveq	#8,d4
	moveq	#7,d5
	move.l	#%01011010,d6
	lea	cursorbmp,a0
	bsr.w	rysop
	rts

cursleft:
	movem.l	d0-d7/a0-a6,-(sp)
	tst.b	stringflag
	beq.s	cursend

	clr.l	d0
	clr.l	d1
	move.l	cursx,d2
	cmp.l	cursminx,d2
	ble.s	cursmoveend
	sub.l	#8,d2
	sub.l	#8,cursx
	move.l	cursy,d3
	moveq	#16,d4
	moveq	#7,d5
	move.l	#%01011010,d6
	lea	cursormovebmp,a0
	bsr.w	rysop
	sub.l	#1,curspos
	movem.l	(sp)+,d0-d7/a0-a6
	rts
cursmoveend:
	bsr.w	flash
cursend:
	movem.l	(sp)+,d0-d7/a0-a6
	rts

invertonoff:
	cmp.b	#1,invonoff
	beq.s	noinvonoff
	move.b	#1,invonoff
	bsr.w	invertgad
noinvonoff:
	move.l	actualgadgetlist,a0
	move.l	lastbutton,a1
	move.l	24(a1),a1
	cmp.l	#g_up,a1
	beq.W	g_scrollup
	cmp.l	#g_down,a1
	beq.W	g_scrolldown
	suba.l	a0,a0
	rts

normalfr:
	move.l	(a0)+,d0
	movem.l	(a0)+,d0-d3
	bsr.w	normborder
	rts
invertfr:
	move.l	(a0)+,d0
	movem.l	(a0)+,d0-d3
	bsr.w	invborder
	rts

switchgad:
	move.l	(a0)+,d0
	movem.l	(a0)+,d0-d3
	bsr.w	ramka
	move.l	(a0)+,a1
	move.l	a0,-(sp)
swi_loop:
	move.l	(a0)+,a2
	cmp.l	a1,a2
	bne.s	swi_loop
	move.l	(a0)+,a0
	cmp.l	#0,a0
	beq.s	swi_restart
	move.l	(sp)+,a1
	move.l	a0,-(a1)
	bsr.w	showtextstruct
	suba.l	a0,a0
	rts
swi_restart:
	move.l	(sp)+,a1
	move.l	(a1),a0
	move.l	(a1),-(a1)
	bsr.w	showtextstruct
	suba.l	a0,a0
	rts

selgad:
	bsr.w	normalgad
	rts

dgaction:
	cmp.l	lastbutton,a0
	bne.s	noaction
	move.l	#4,d1
	move.l	(a0),d0
	bsr.w	gadfunctions
	movem.l	(sp)+,d0-d7/a1-a6
	rts
noaction:
	suba.l	a0,a0
	movem.l	(sp)+,d0-d7/a1-a6
	rts

pressed:
	move.b	#1,mousebutton
	move.l	window,a0
	move.w	108(a0),d0
	move.w	110(a0),d1
	ext.l	d0
	ext.l	d1
	move.l	lastbutton,a0
	bsr.w	clickdetect
	move.l	a0,a1
	move.l	lastbutton,a0
	cmp.l	a0,a1
	bne.s	holdnogad
	move.l	(a0),d0
	move.l	#2,d1
	bsr.w	gadfunctions
	movem.l	(sp)+,d0-d7/a1-a6
	suba.l	a0,a0
	rts
holdnogad:
	move.l	(a0),d0
	move.l	#3,d1
	bsr.w	gadfunctions
	suba.l	a0,a0
	movem.l	(sp)+,d0-d7/a1-a6
	rts

invertgad:
	movem.l	d0-d7/a0-a6,-(sp)
	cmp.l	#0,20(a0)
	bne.s	invertframe
	clr.l	d0
	clr.l	d1
	move.l	04(a0),d2
	move.l	08(a0),d3
	move.l	12(a0),d4
	move.l	16(a0),d5
	move.l	28(a0),a0
	bsr.w	rysuj
	movem.l	(sp)+,d0-d7/a0-a6
	rts
invertframe:
	move.l	04(a0),d0
	move.l	08(a0),d1
	move.l	12(a0),d2
	move.l	16(a0),d3
	bsr.w	invborder
	movem.l	(sp)+,d0-d7/a0-a6
	rts

normalgad:
	movem.l	d0-d7/a0-a6,-(sp)
	clr.b	invonoff
	cmp.l	#0,20(a0)
	bne.s	normframe
	clr.l	d0
	clr.l	d1
	move.l	04(a0),d2
	move.l	08(a0),d3
	move.l	12(a0),d4
	move.l	16(a0),d5
	move.l	24(a0),a0
	bsr.w	rysuj
	movem.l	(sp)+,d0-d7/a0-a6
	rts
normframe:
	move.l	04(a0),d0
	move.l	08(a0),d1
	move.l	12(a0),d2
	move.l	16(a0),d3
	bsr.w	normborder
	movem.l	(sp)+,d0-d7/a0-a6
	rts

; a0 - gadget

; Z = 1 when it's the special gadget
; Z = 0 when it isn't

specgad:
	movem.l	d0/a1-a2,-(sp)
	lea	specialgadgets,a1
sgloop:
	move.l	(a1)+,a2
	move.l	(a1)+,d0
	beq.s	sgend
	cmp.l	(a0,d0.w),a2
	bne.s	sgloop
	movem.l	(sp)+,d0/a1-a2
	tst.b	sg_zero
	rts
sgend:
	movem.l	(sp)+,d0/a1-a2
	tst.b	sg_jeden
	rts

sg_zero:
	dc.b	0
sg_jeden:
	dc.b	1

; a0 - gadlist
; d0,d1 - x,y

; d0 - 0:False  1:True
; a0 - gadget

clickdetect:
	movem.l	d2-d6/a3-a4,-(sp)
	suba.l	a3,a3
cdloop:
	tst.l	(a0)
	beq.s	cdend
	bsr.b	specgad
	beq.s	cdhere
	move.l	g_miny,d3
	move.l	g_maxy,d5
	cmp.l	d1,d3
	bgt.s	cdnex
	cmp.l	d1,d5
	ble.s	cdnex
cdhere:
	move.l	a0,a4
	movem.l	(a0)+,d2-d6
	suba.l	#20,a0
	tst.l	d2
	beq.s	cdend
	bsr.w	nextgadget
	cmp.l	#5,d2
	beq.s	cdloop
	cmp.l	#7,d2
	beq.s	cdloop
	add.l	d3,d5
	add.l	d4,d6
	cmp.l	d3,d0
	blt.s	cdloop
	cmp.l	d4,d1
	blt.s	cdloop
	cmp.l	d5,d0
	bgt.s	cdloop
	cmp.l	d6,d1
	bgt.s	cdloop

	cmp.l	#4,d2
	beq.s	gadnop

	move.l	a4,a0
	move.l	#1,a3
cdend:
	move.l	a3,d0
	movem.l	(sp)+,d2-d6/a3-a4
	rts

gadnop:	move.b	#1,mousebutton
	bra.s	cdloop

cdnex:	bsr.w	nextgadget
	bra.s	cdloop

drag:	dc.w	0

message:
	movem.l	d0-d7/a0-a6,-(sp)
	clr.w	drag
	clr.w	key
	clr.w	rawkey
	move.b	#1,mousebutton
	move.l	window,a0
	move.l	86(a0),a0
	move.l	4,a6
	jsr	-372(a6)
	tst.l	d0
	beq.w	nm
	move.l	d0,a1

	move.l	20(a1),d2
	move.w	24(a1),code
	cmp.l	#$200000,d2
	bne.s	nokey
	move.w	24(a1),key
nokey:
	cmp.l	#1024,d2
	bne.s	norawkey
	move.w	24(a1),rawkey
norawkey:
	move.l	4,a6
	jsr	-378(a6)

	cmp.l	#$2000000,d2
	bne.s	nodr
	move.w	#1,drag
nODR:
	cmp.w	#8,d2
	bne.s	nomousebutton
	move.b	#0,mousebutton
	move.b	#1,lastbaton
	cmp.w	#$68,code
	bne.s	nomousebutton
	move.b	#-1,lastbaton
nomousebutton:
	cmp.w	#512,d2
	bne.s	nm
	lea	quittext,a0
	lea	yesnogad,a1
	moveq	#1,d0
	bsr.w	request
	cmp.l	#g_reqyes,a0
	beq.b	end
nm:
	movem.l	(sp)+,d0-d7/a0-a6
	rts

koniec:	rts

powrot:	move.l	stack,sp
	rts

end:	move.l	stack,sp
	bsr.W	close

quit:	move.l	wbmsg,d2
	beq.s	nowb
	move.l	4,a6
	jsr	-132(a6)
	move.l	d2,a1
	move.l	4,a6
	jsr	-378(a6)
nowb:
;	bsr.w	dmaoff
	clr.l	d0
	rts

wf:
	movem.l	d0-d7/a0-a6,-(sp)
;	bsr.w	pointer
wfnopo:
;	bsr.w	wyswietlacz
	move.l	gfxbase,a6
	jsr	-270(a6)
;	bsr.w	normsample
	movem.l	(sp)+,d0-d7/a0-a6

	rts

wfnp:
	movem.l	d0-d7/a0-a6,-(sp)
	bra.s	wfnopo	

normborder:
	movem.l	d0-d7/a0-a6,-(sp)
	move.b	#2,col1
	move.b	#1,col2
	move.b	#0,clr
	bra.s	ramere

invborder:
	movem.l	d0-d7/a0-a6,-(sp)
	move.b	#1,col1
	move.b	#2,col2
	move.b	#0,clr
	bra.s	ramere

ramka:
	movem.l	d0-d7/a0-a6,-(sp)
	move.b	#2,col1
	move.b	#1,col2
	move.b	#1,clr

ramere:
	lea	tab1,a0

	add.w	addy,d1
	addq.l	#4,d0
	move.w	d0,tu1
	move.w	d1,tam1
	move.w	d0,tu2
	move.w	d1,tam2
	sub.w	addy,d1
	subq.l	#4,d0

	move.w	#0,(a0)+
	move.w	d3,(a0)+
	move.w	#0,(a0)+
	move.w	#0,(a0)+
	move.w	d2,(a0)+
	move.w	#0,(a0)+

	move.w	d2,(a0)+
	move.w	#0,(a0)+
	move.w	d2,(a0)+
	move.w	d3,(a0)+
	move.w	#0,(a0)+
	move.w	d3,(a0)+

	move.l	d2,d4
	move.l	d3,d5
	move.l	d0,d2
	move.l	d1,d3

	tst.b	clr
	beq.s	noclr

	lea	panel,a0
	clr.l	d0
	clr.l	d1
	move.l	rastport,a1
	move.l	#0,d6
	move.l	gfxbase,a6
	bsr.w	putbitmap

noclr:
	lea	poleramka,a1
	moveq	#0,d0
	moveq	#0,d1
	move.l	rastport,a0
	move.l	intbase,a6
	jsr	-108(a6)

	movem.l	(sp)+,d0-d7/a0-a6
	rts

poleramka:
tu1:	dc.w	0
tam1:	dc.w	0
col1:	dc.b	2,0
	dc.b	0
	dc.b	3
	dc.l	tab1
	dc.l	poleramka2
poleramka2:
tu2:	dc.w	0
tam2:	dc.w	0
col2:	dc.b	1,0
	dc.b	0
	dc.b	3
	dc.l	tab2
	dc.l	0

tab1:
	blk.w	6
tab2:
	blk.w	6

setcolor:
	movem.l	d1-d7/a0-a6,-(sp)
	move.l	actscreen,a1
	cmp.b	#1,$bd(a1)
	bne.s	sts_norm
	tst.b	d0
	beq.s	sts_norm
	moveq	#1,d0
sts_norm:
	move.l	gfxbase,a6
	move.l	rastport,a1
	jsr	-342(a6)	
	movem.l	(sp)+,d1-d7/a0-a6
	rts

setsoftstyle:
	movem.l	d2-d7/a0-a6,-(sp)
	move.l	gfxbase,a6
	move.l	rastport,a1
	jsr	-90(a6)	
	movem.l	(sp)+,d2-d7/a0-a6
	rts

setdrmode:
	movem.l	d1-d7/a0-a6,-(sp)
	move.l	gfxbase,a6
	move.l	rastport,a1
	jsr	-354(a6)	
	movem.l	(sp)+,d1-d7/a0-a6
	rts

showtext:
	movem.l	d0-d7/a0-a6,-(sp)
	movem.l	a0/d2,-(sp)
	add.w	addy,d1
	move.l	gfxbase,a6
	move.l	rastport,a1
	jsr	-240(a6)
	movem.l	(sp)+,a0/d2
	move.l	d2,d0
	move.l	gfxbase,a6
	move.l	rastport,a1
	jsr	-60(a6)
	movem.l	(sp)+,d0-d7/a0-a6
	rts

g_val:
	dc.b	1,5,7
g_valtext:
	dc.b	'        ',0

valbuf:
	blk.b	6,32

; d0 - liczba
; a0 - bufor

liczbadoascii:
	movem.l	d0-d7/a0-a6,-(sp)
	clr.w	znaczniczek
	move.l	a0,a1
	move.l	d0,d1
	lea	dzielonko,a3
	moveq.l	#5,d0
	move.b	#' ',(a1)
	cmp.l	#99999,d1
	ble.s	wlproc2
	move.b	#'1',(a1)
wlproc2:
	add.l	#1,a1
	subq	#1,d0
c_loop2:
	move.l	d1,d2
	move.l	(a3)+,d3
	divu	d3,d2
	ext.l	d2
	tst.w	d2
	bne.s	nz2
	tst.w	znaczniczek
	bne.s	nz2
	move.b	#' ',(a1)+
	dbf	d0,c_loop2
	movem.l	(sp)+,d0-d7/a0-a6
	rts

nz2:	move.w	#1,znaczniczek
	mulu	d2,d3
	add.l	#48,d2
	move.b	d2,(a1)+
	sub.l	d3,d1
	dbf	d0,c_loop2
	movem.l	(sp)+,d0-d7/a0-a6
	rts

; a0 - valbuf
; a1 - dest
; d0 - count

; Dosuwa do lewej

valcopy:
	movem.l	d0-d2/a0-a1,-(sp)
	move.b	#' ',d2
valcop_here:
	move.w	d0,d1
	ext.l	d0
	subq.l	#6,d0
	sub.l	d0,a0
	sub.w	#1,d1
valcopyloop:
	move.b	(a0)+,d0
	cmp.b	d2,d0
	beq.s	val_nwrt
	move.b	d0,(a1)+
	dbf	d1,valcopyloop
	cmp.b	#' ',-(a1)
	bne.s	noinszero
	move.b	#'0',(a1)
	bra.s	noinszero
val_nwrt:
	dbf	d1,valcopyloop
	move.b	#'0',(a1)
noinszero:
	movem.l	(sp)+,d0-d2/a0-a1
	rts

; a0 - valbuf
; a1 - dest
; d0 - count

; Dosuwa do prawej

valcopy2:
	movem.l	d0-d2/a0-a1,-(sp)
	move.b	#255,d2
	bra.s	valcop_here

opt_error:
	bsr.w	flash
	rts

; *****************************************************
; *** a0 - obiekt
; *** d0 - move x
; *** d1 - move y
; *** d2 - x
; *** d3 - y
; *** d4 - size x
; *** d5 - size y
; *****************************************************
rysuj:
	move.l	#%11001100,d6

; *****************************************************
; *** d6 - operation
; *****************************************************

rysop:
	bsr.s	bitmapcreate
rysdal:	movem.l	d0-d7/a0-a6,-(sp)
	lea	bitmapstruct,a0
	move.l	rastport,a1
	move.l	gfxbase,a6
	bsr.w	putbitmap
	movem.l	(sp)+,d0-d7/a0-a6
	rts

rysnob:
	move.l	#%11001100,d6
	bra.s	rysdal

bitmapcreate:
	movem.l	a0/d4-d6,-(sp)
	move.w	d4,d6
	add.w	#15,d6
	asr.w	#3,d6
	and.w	#$fffe,d6
	move.w	d6,szer
	move.w	d5,wys
	move.l	a0,adres1b
	mulu	d5,d6
	ext.l	d6
	add.l	d6,a0
	move.l	a0,adres2b
	movem.l	(sp)+,a0/d4-d6
	rts

lastbaton:
	dc.b	1

	even

specialgadgets:
	dc.l	g_ok,20,g_use,20,g_save,20,g_up,24,g_down,24
	dc.l	g_retry,20,g_cancel,20,g_quit,20
	dc.l	g_reqyes,20,g_reqno,20
	dc.l	0,0

cursminx:
	dc.l	0
cursmaxx:
	dc.l	0
cursx:	dc.l	0
cursy:	dc.l	0
stringflag:
	dc.b	0

	even

g_letter:
	dc.b	1,6-2,8-2

g_lettertext:
	dc.b	0,0

	even

valadr:
	dc.l	0
val:
	dc.l	0
valmin:
	dc.l	0
valmax:
	dc.l	0
curspos:
	dc.l	0	; pozycja kursora w string'u (0 - strlen)
strlen:
	dc.l	0	; iloôê znaków w string'u-1
howmanychars:
	dc.l	0	; ile znaków<>" " w string'u

gadfunctable:
	dc.l	3,invertfr,invertfr,normalfr,switchgad
	dc.l	1,invertgad,invertonoff,normalgad,selgad
	dc.l	2,putcursor,gad_nop,gad_nop,gad_nop
	dc.l	0

bitmapstruct:
szer:	dc.w	2
wys:	dc.w	8
	dc.b	0
	dc.b	2
	dc.w	0
adres1b:
	dc.l	0
adres2b:
	dc.l	0

okgad:	dc.l	1,0,0,2*8+4,10,g_ok,0,0,$80000000
	dc.l	0

firestat:
	dc.w	0

wbmsg:	dc.l	0
stack:	dc.l	0

quittext:
	dc.b	'Do you really want to quit ?',10
	dc.b	0

yesnogad:
	dc.l	1,0,0,3*8+4,10,g_reqyes,0,0,$80000000
	dc.l	1,0,0,2*8+4,10,g_reqno,0,0,$80000000
	dc.l	0

g_reqyes:
	dc.b	1,6,8,'YES',0
g_reqno:
	dc.b	1,6,8,'NO',0

	even

rawkey:	dc.w	0

key:	dc.w	0

mousebutton:
	dc.w	1

actualgadgetlist:
	dc.l	0

lastbutton:
	dc.l	0

scrollspeed:
	dc.l	12
scrmask:
	dc.b	$ff
invonoff:
	dc.b	0

rastport:
	dc.l	0
window:
	dc.l	0

; d0,d1 - dx,dy
; d2,d3 - minx, miny
; d4,d5 - maxx, maxy

scroll:
	movem.l	d0-d7/a0-a6,-(sp)
	add.w	addy,d5
	add.w	addy,d3
	move.l	rastport,a1
	move.l	gfxbase,a6
	jsr	-396(a6)
	movem.l	(sp)+,d0-d7/a0-a6
	rts

; a0 - ascii
; d0 - liczba

asciidoliczba:
	movem.l	a1/d1-d2,-(sp)
asloop:
	move.b	(a0)+,d0
	tst.b	d0
	beq.s	aserr
	cmp.b	#',',d0
	beq.s	aserr
	cmp.b	#'0',d0
	blt.s	asloop
	cmp.b	#'9',d0
	bgt.s	asloop
	suba.l	#1,a0
asloop2:
	move.b	(a0)+,d0
	tst.b	d0
	beq.s	aslicz
	cmp.b	#'0',d0
	blt.s	aslicz
	cmp.b	#'9',d0
	bgt.s	aslicz
	bra.s	asloop2
aslicz:	move.l	a0,-(sp)
	suba.l	#1,a0
	lea	mnozonko,a1
	clr.l	d0
	clr.l	d1
asconv:
	move.b	-(a0),d1
	cmp.b	#'-',d1
	beq.s	ascneg
	sub.b	#'0',d1
	tst.b	d1
	bmi.s	ascend
	cmp.b	#10,d1
	bge.s	ascend
	move.l	(a1)+,d2
	ext.w	d1
	ext.l	d1
	mulu	d1,d2
	add.l	d2,d0
	bra.s	asconv
ascend:	move.l	(sp)+,a0
asend:	movem.l	(sp)+,a1/d1-d2
	rts
aserr:	move.l	#$80000000,d0
	movem.l	(sp)+,a1/d1-d2
	rts
	
ascneg:	neg.l	d0
	bra.s	ascend

flash:
	movem.l	d0-d7/a0-a6,-(sp)
	move.l	intbase,a6
	suba.l	a0,a0
	jsr	-96(a6)
	movem.l	(sp)+,d0-d7/a0-a6
flend:	rts

cursormovebmp:
	dc.w	%1111111111111111
	dc.w	%1111111111111111
	dc.w	%1111111111111111
	dc.w	%1111111111111111
	dc.w	%1111111111111111
	dc.w	%1111111111111111
	dc.w	%1111111111111111
	dc.w	%1111111111111111

	dc.w	%1111111111111111
	dc.w	%1111111111111111
	dc.w	%1111111111111111
	dc.w	%1111111111111111
	dc.w	%1111111111111111
	dc.w	%1111111111111111
	dc.w	%1111111111111111
	dc.w	%1111111111111111

cursorbmp:
	dc.w	%1111111100000000
	dc.w	%1111111100000000
	dc.w	%1111111100000000
	dc.w	%1111111100000000
	dc.w	%1111111100000000
	dc.w	%1111111100000000
	dc.w	%1111111100000000
	dc.w	%1111111100000000

	dc.w	%1111111100000000
	dc.w	%1111111100000000
	dc.w	%1111111100000000
	dc.w	%1111111100000000
	dc.w	%1111111100000000
	dc.w	%1111111100000000
	dc.w	%1111111100000000
	dc.w	%1111111100000000
	
g_up:
	incbin	"up.raw"
g_down:
	incbin	"down.raw"
g_uppressed:
	incbin	"uppressed.raw"
g_downpressed:
	incbin	"downpressed.raw"

; a0 - text
; a1 - gadgets
; d0 - height

; a0 - gadtext

request:
	movem.l	d0-d7/a1-a6,-(sp)
	move.l	scrollspeed,scrolltemp
	move.l	g_minx,minxtemp
	move.l	g_miny,minytemp
	move.l	g_maxx,maxxtemp
	move.l	g_maxy,maxytemp
	move.b	#1,scrmask
	move.l	#8,scrollspeed
	asl.l	#3,d0
	move.l	a0,-(sp)
	lea	defwindow,a0
	bsr.w	storewindow

	move.w	#-1,win_x
	move.w	#-1,win_y
	add.w	#3,d0
	move.w	d0,win_sizey
	move.l	#$20000+$2+$4+$2000,win_flags
	move.l	#$8+$200000,win_idcmpflags
	move.l	#tit_req,win_title

	move.l	(sp)+,a0
	move.l	d0,-(sp)
	bsr.w	maxchars
	asl.w	#3,d0
	add.w	#8+8+8+8,d0
	move.w	d0,win_sizex
	add.w	#32,win_sizey
	bsr.w	openwindow

	move.l	a1,-(sp)
	lea	reqgads,a1
	move.l	#2+8,d0
reqgloop:
	move.l	#7,(a1)+
	move.l	#2+8,(a1)+
	move.l	d0,(a1)+
	move.l	a0,(a1)+
	move.l	#$80000000,(a1)+
	add.l	#8,d0
reqgtloop:
	move.b	(a0)+,d1
	beq.s	reqgend
	cmp.b	#10,d1
	bne.s	reqgtloop
	bra.s	reqgloop
reqgend:
	move.l	(sp)+,a0
	move.l	#8,d0
	move.w	win_sizex,d1
	ext.l	d1
	sub.l	#16+8,d1
	move.w	win_sizey,d2
	sub.w	#16+8+8,d2
	ext.l	d2
	bsr.w	spreadgads
	move.l	#0,(a1)+
	lea	reqgads,a0
	moveq.l	#4,d0
	move.w	addy,d1
	ext.l	d1
	add.l	#2,d1
	move.w	win_sizex,d2
	sub.l	#6,d2
	move.l	(sp)+,d3
	sub.l	#9,d1
	bsr.w	drawscrollgad
reqwfg:	bsr.w	message
	bsr.w	wfnp
	lea	reqgads,a0
	bsr.w	gadtext
	cmp.l	#0,a0
	beq.s	reqwfg
	move.l	a0,-(sp)
	lea	reqgads,a0
	bsr.w	gadtext
	bsr.w	closewindow
	lea	defwindow,a0
	bsr.w	restorewindow
	move.l	(sp)+,a0
	move.l	scrolltemp,scrollspeed
	move.l	minxtemp,g_minx
	move.l	minytemp,g_miny
	move.l	maxxtemp,g_maxx
	move.l	maxytemp,g_maxy
	move.b	#$ff,scrmask
	movem.l	(sp)+,d0-d7/a1-a6
	rts

; a0 - srcgads
; a1 - destgads
; d0 - addx
; d1 - sizex
; d2 - posy

spreadgads:
	movem.l	d0-d7/a2-a6,-(sp)
	move.l	a0,-(sp)
	move.l	12(a0),d3
	asr.l	#1,d3
	add.l	d3,d0
	sub.l	d3,d1
	clr.l	d7
sprlop:	bsr.w	nextgadget
	tst.l	(a0)
	beq.s	sprlopend
	addq	#1,d7
	move.l	12(a0),d3
	bra.s	sprlop
sprlopend:
	asr.l	#1,d3
	sub.l	d3,d1
	cmp.l	#0,d7
	bne.s	sprnozero
	move.l	#2,d7
	divu	d7,d1
	ext.l	d1
	add.l	d1,d0
	bra.s	sphere
sprnozero:
	divu	d7,d1
	ext.l	d1
sphere:
	move.l	(sp)+,a0

	clr.l	d4
sprloop:
	move.l	(a0)+,d3
	beq.s	sprend
	move.l	d3,(a1)+
	move.l	(a0)+,d5
	move.l	(a0)+,d6
	move.l	(a0)+,d5
	move.l	(a0)+,d6
	move.l	d4,(a1)
	add.l	d0,(a1)
	asr.l	#1,d5
	sub.l	d5,(a1)+
	asl.l	#1,d5
	add.l	d1,d4
	move.l	d2,(a1)+
	move.l	d5,(a1)+
	move.l	d6,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	move.l	(a0)+,(a1)+
	bra.s	sprloop
sprend:
	movem.l	(sp)+,d0-d7/a2-a6
	rts

; a0 - src
; a1 - dest
; d0 - count

movenulltext:
	movem.l	a0/a1/d0,-(sp)
	subq	#1,d0
movetloop:
	move.b	(a0)+,(a1)
	tst.b	(a1)
	beq.s	movetdone
	cmp.b	#10,(a1)+
	beq.s	movetdone
	dbf	d0,movetloop
	move.b	#0,(a1)+
movetdone:
	movem.l	(sp)+,a0/a1/d0
	rts

close:
	move.l	intbase,a6
	move.l	window,a0
	jsr	-72(a6)

;	bsr.w	closescreen

clint:
;	bsr.w	MyCloseDevice
;	bsr.w	deallocate
;	bsr.w	closescreen

deverr:
	move.l	intbase,a1
	move.l	4,a6
	jsr	-414(a6)

	move.l	dosbase,a1
	move.l	4,a6
	jsr	-414(a6)

	move.l	gfxbase,a1
	move.l	4,a6
	jsr	-414(a6)

	rts

error:
	move.l	stack,sp
	bsr.w	flash
	bsr.s	clint
	bra.W	quit

gfxbase:
	dc.l	0
clr:	dc.b	0

	even

openwindow:
	movem.l	d0-d3/a0,-(sp)

	move.w	win_sizey,d0
	move.w	win_sizex,d1
	move.w	win_y,d2
	move.w	win_x,d3

	move.w	#1,win_sizex
	move.w	#1,win_sizey
	move.w	#1,win_y
	move.w	#1,win_x

	bsr.w	open_window
	bsr.w	closewindow

	add.w	addy,d0
	move.w	d0,win_sizey
	move.w	d1,win_sizex
	move.w	d2,win_y
	move.w	d3,win_x

	move.w	win_y,d0
	move.l	actscreen,a0
	move.b	$bd(a0),d1
	cmp.b	minbit,d1
	blt.W	error
	tst.w	d0
	bpl.s	nocentery
	move.w	$e(a0),d1
	move.w	win_sizey,d0
	asr.w	#1,d0
	asr.w	#1,d1
	sub.w	d0,d1
	move.w	d1,win_y
nocentery:
	move.w	win_y,d0
	move.w	$e(a0),d1
	add.w	win_sizey,d0
	cmp.w	d0,d1
	bge.s	nomove
	sub.w	win_sizey,d1
	move.w	d1,win_y

nomove:
	move.w	win_x,d0
	tst.w	d0
	bpl.s	nocenterx
	move.w	$c(a0),d1
	move.w	win_sizex,d0
	asr.w	#1,d0
	asr.w	#1,d1
	sub.w	d0,d1
	move.w	d1,win_x
nocenterx:
	move.w	win_x,d0
	move.w	$c(a0),d1
	add.w	win_sizex,d0
	cmp.w	d0,d1
	bge.s	nomove2
	sub.w	win_sizex,d1
	move.w	d1,win_x
nomove2:
	bsr.s	open_window

	move.w	d2,win_y
	move.w	d3,win_x

	movem.l	(sp)+,d0-d3/a0
	rts

open_window:
	movem.l	d0-d7/a0-a6,-(sp)
ow_retry:
	move.l	intbase,a6
	lea	newwindow,a0
	jsr	-204(a6)
	move.l	d0,window
	tst.l	d0
	beq.W	winerr

	move.l	window,a0
	move.l	$2e(a0),actscreen

	move.l	window,a0
	move.l	$32(a0),a0
	move.l	a0,rastport

	lea	textattr,a0
	move.l	gfxbase,a6
	jsr	-72(a6)
	tst.l	d0
	beq.W	error

	move.l	gfxbase,a6
	move.l	d0,a0	
	move.l	rastport,a1
	jsr	-66(a6)

	move.l	actscreen,a0
	move.l	$28(a0),a0
	move.w	4(a0),addy
	add.w	#3,addy

	movem.l	(sp)+,d0-d7/a0-a6
	rts

winerr:
;	cmp.l	#tit_req,win_title
;	beq.L	requesterror
;	lea	winerrtext,a0
;	lea	retryquitgad,a1
;	move.l	#2,d0
;	bsr.w	request
;	cmp.l	#g_retry,a0
;	beq.L	ow_retry
	
;requesterror:
	lea	defwindow,a0
	bsr.w	restorewindow
	bra.w	error

closewindow:
	movem.l	d0-d7/a0-a6,-(sp)
	move.l	intbase,a6
	move.l	window,a0
	jsr	-72(a6)
	movem.l	(sp)+,d0-d7/a0-a6
	rts

newwindow:
win_x:	dc.w	-1
win_y:	dc.w	-1
win_sizex:
	dc.w	463
win_sizey:
	dc.w	189
	dc.b	0
	dc.b	1
win_idcmpflags:
	dc.l	512+8+$2000000+$200000+$400
win_flags:
	dc.l	2+4+8+$10000
	dc.l	0
	dc.l	0
win_title:
	dc.l	WINNAME
win_screen:
	dc.l	0
	dc.l	0
win_minsizex:
	dc.w	0
win_minsizey:
	dc.w	0
win_maxsizex:
	dc.w	463
win_maxsizey:
	dc.w	10
win_type:
	dc.w	1

addy:	dc.w	0

winname:
	dc.b	'MiniArcanoid v1.0. All work done by PP/Termos.    ',0
	even
panel:

putbitmap:
	add.w	#4,d2
	add.w	addy,d3
	jsr	-606(a6)
	rts

intbase:	dc.l	0
actscreen:	dc.l	0
znaczniczek:	dc.w	0

dzielonko:
	dc.l	10000,1000,100,10,1
g_use:
	dc.b	1,6,8,'USE',0
g_save:
	dc.b	1,6,8,'SAVE',0
g_ok:	dc.b	1,6,8,'OK',0
g_cancel:
	dc.b	1,6,8,'CANCEL',0

	even

retryquitgad:
	dc.l	1,0,0,5*8+4,10,g_retry,0,0,$80000000
	dc.l	1,0,0,4*8+4,10,g_quit,0,0,$80000000
	dc.l	0

g_quit:
	dc.b	1,6,8,'QUIT',0
g_retry:
	dc.b	1,6,8,'RETRY',0

	even

mnozonko:
	dc.l	1,10,100,1000,10000

scrolltemp:
	dc.l	0

defwindow:
	blk.l	60
	
reqwindow:
	blk.l	60
	
; a0 - adres

storewindow:
	movem.l	d0-d7/a0-a6,-(sp)
	add.l	#60,a0
	move.l	rastport,a1
	move.l	window,a2
	move.l	win_title,a3
	move.l	win_flags,a4
	move.l	win_idcmpflags,a5
	move.l	win_type,a6
	move.w	win_x,d0
	move.w	win_y,d1
	move.w	win_sizex,d2
	move.w	win_sizey,d3
	move.w	win_minsizex,d4
	move.w	win_minsizey,d5
	move.w	win_maxsizex,d6
	move.w	win_maxsizey,d7
	movem.l	d0-d7/a0-a6,-(a0)
;	bsr.w	clearpointer
	movem.l	(sp)+,d0-d7/a0-a6
	rts

restorewindow:
	movem.l	d0-d7/a0-a6,-(sp)
	movem.l	(a0)+,d0-d7/a0-a6
	move.l	a1,rastport
	move.l	a2,window
	move.l	a3,win_title
	move.l	a4,win_flags
	move.l	a5,win_idcmpflags
	move.l	a6,win_type
	move.w	d0,win_x
	move.w	d1,win_y
	move.w	d2,win_sizex
	move.w	d3,win_sizey
	move.w	d4,win_minsizex
	move.w	d5,win_minsizey
	move.w	d6,win_maxsizex
	move.w	d7,win_maxsizey
	movem.l	(sp)+,d0-d7/a0-a6
	rts

tit_req:
	dc.b	'Info...',0
	even
	
; IN
; a0 - text

; OUT
; d0 - maximum chars in line

maxchars:
	movem.l	d1-d2/a0,-(sp)
	clr.l	d0
	clr.l	d2
maxnext:
	cmp.l	d0,d2
	ble.s	nomax
	move.l	d2,d0
nomax:
	clr.l	d2
maxloop:
	move.b	(a0)+,d1
	beq.s	maxend
	cmp.b	#10,d1
	beq.s	maxnext
	addq	#1,d2
	bra.s	maxloop
maxend:	movem.l	(sp)+,d1-d2/a0
	rts

dosbase:
	dc.l	0
minbit:
	dc.b	1

	even

textattr:
	dc.l	topazfont
	dc.w	8
	dc.b	0
	dc.b	0

topazfont:
	dc.b	'topaz.font',0

	even

code:	dc.w	0

; *****************************************

	section	free,bss_c

reqgads:
	ds.l	5*50
