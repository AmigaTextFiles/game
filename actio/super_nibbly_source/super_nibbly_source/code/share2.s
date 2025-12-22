	incdir	"p1:include/"
	include "exec/types.i"
	include	"exec/memory.i"
	include	"exec/tasks.i"
	include "exec/exec_lib.i"
	include "libraries/dos_lib.i"


LEVEL = 0


cop1lc:		equ	$80
copjmp1:	equ	$88
diwstrt:	equ	$8e
diwstop:	equ	$90
ddfstrt:	equ	$92
ddfstop:	equ	$94
dmacon:		equ	$96
bpl1pth:	equ	$e0
bpl1ptl:	equ	$e2
bpl2pth:	equ	$e4
bpl2ptl:	equ	$e6
bpl3pth:	equ	$e8
bpl3ptl:	equ	$ea
bpl4pth:	equ	$ec
bpl4ptl:	equ	$ee
bpl5pth:	equ	$f0
bpl5ptl:	equ	$f2
bpl6pth:	equ	$f4
bpl6ptl:	equ	$f6
bplcon0:	equ	$100
bplcon1:	equ	$102
bplcon2:	equ	$104
bpl1mod:	equ	$108
bpl2mod:	equ	$10a
spr0pt:		equ	$120
spr1pt:		equ	$124
spr2pt:		equ	$128
spr3pt:		equ	$12c
spr4pt:		equ	$130
spr5pt:		equ	$134
spr6pt:		equ	$138
spr7pt:		equ	$13c
color00:	equ	$180
ciaapra:	equ	$bfe001
clear:	  	equ	$10002
startlist:	equ	38
bltcon0:	equ	$40
bltcon1:	equ	$42
bltafwm:	equ	$44
bltalwm:	equ	$46
bltsize:	equ	$58
bltamod:	equ	$64
bltbmod:	equ	$62
bltcmod:	equ	$60
bltdmod:	equ	$66
bltapth:	equ	$50
bltbpth:	equ	$4c	
bltcpth:	equ	$48
bltdpth:	equ	$54
dmaconr:	equ	$02


j:
* startup.i

* Startup-Code fuer Assembler-Programme. Recht frei nach dem
* Beispiel im ROM-Kernel-Manual Libraries and Devices, aber so
* geschrieben, dass als Include-File brauchbar und auf das 
* wirklich notwendige reduziert
* -----------------------------------------------------------


	movem.l	 d0/a0,-(sp)		;rette Kommandozeile
	clr.l	 _WBenchMsg		;sicherheitshalber

* Teste, von wo wir gestartet wurden
* ----------------------------------
	sub.l	 a1,a1			;a1=0 = eigener Task
	CALLEXEC FindTask		;wo sind wir?
	move.l	 d0,a4			;Adresse retten

	tst.l	 $AC(a4)                ;Laufen wir unter WB?
	beq.s	 fromWorkbench		;wenn so

* Wir wurden vom CLI gestartet
* ----------------------------
	movem.l	 (sp)+,d0/a0		;Parms Kommandozeile holen
	bra	 run    		;und starten

* Wir wurden von  Workbench gestartet
* -----------------------------------
fromWorkbench
	lea	 $5C(a4),a0
	CALLEXEC WaitPort		;Warte auf Start-Message
	lea	 $5C(a4),a0  		;sie ist da
	CALLEXEC GetMsg			;hole sie
	move.l	 d0,_WBenchMsg		;immer Msg sichern!

	movem.l	 (sp)+,d0/a0		;bringe Stack i.O.


run	bsr.s	 begin			;rufe unser Programm auf

	move.l	 d0,-(sp)		;rette seinen Return-Code

	tst.l	 _WBenchMsg             ;gibt's eine WB-Message
	beq.s	 _exit			;nein: dann war's CLI

	CALLEXEC Forbid			;keine Unterbrechung jetzt
	move.l	 _WBenchMsg(pc),a1	;hole die Message
	CALLEXEC ReplyMsg		;und gib sie zurueck
	CALLEXEC Permit

_exit
	move.l	 (sp)+,d0		;hole Return-Code
	rts				;das war's

_WBenchMsg	 ds.l	1

	cnop	 0,2


begin:
;Open Dos Library
	move.w	#32,$dff1dc
	move.w	#0,quit
        move.l  4,a6
        lea     dosname,a1
	move.l	#0,d0
        jsr     _LVOOpenLibrary(a6)
        tst.l   d0
        beq     xnodos
        move.l  d0,dosbase


	move.l	#$dff000,a5
	bsr	newcopper

	lea	adresse,a0
	move.l	#clist,d0
	move.w	#7,d2
.insert5
	rol.l	#4,d0
	move.b	d0,d1
	and.b	#$f,d1
	add.b	#48,d1
	move.b	d1,(a0)+
	dbra	d2,.insert5

	lea	adresse4,a0
	move.l	#clist,d0
	move.w	#7,d2
.insert
	rol.l	#4,d0
	move.b	d0,d1
	and.b	#$f,d1
	add.b	#48,d1
	move.b	d1,(a0)+
	dbra	d2,.insert

	move.l	dosbase,a6
	move.l	#copyright,d1
	move.l	#0,d2
	move.l	#0,d3
	jsr	_LVOExecute(a6)

.gettitel
	move.l	dosbase,a6
	move.l	#mytitel,d1
	move.l	#0,d2
	move.l	#0,d3
	jsr	_LVOExecute(a6)

	bsr	ingame

	move.l	sharemem,a0
	cmp.w	#1,(a0)
	beq	.gettitel

	cmp.w	#3,(a0)
	beq	.quit2dos

	move.l	dosbase,a6
	move.l	#endpart,d1
	move.l	#0,d2
	move.l	#0,d3
	jsr	_LVOExecute(a6)

.quit2dos:

;mtas:	btst	#6,$bfe001
;	bne	mtas

	bsr	oldcopper

	move.l  dosbase,a1
        move.l  4,a6
	jsr	_LVOCloseLibrary(a6)
xnodos:
	move.l	#0,d0
	rts
	

error:
	move.l	#$10000,d0
erloop:
	move.w	#$f00,$dff180
	sub.l	#1,d0
	bne	erloop
	rts

oldcopper:
	lea	gfxname,a1
	move.l	4.w,a6
	jsr	_LVOOpenLibrary(a6)
	tst.l	d0
	beq	nogfx
	move.l	d0,gfxlib

	move.l	#$dff000,a5
	move.w	#$03c0,dmacon(a5)
	move.l	gfxlib,a4
	move.l	startlist(a4),cop1lc(a5)
	clr.w	copjmp1(a5)
	move.w	#$83c0,dmacon(a5)

	move.l	4.w,a6
	move.l	gfxlib,a1
	jsr	_LVOCloseLibrary(a6)

nogfx:
	rts

newcopper:
	move.w	#$03c0,dmacon(a5)
	move.l	#clist,cop1lc(a5)
	clr.w	copjmp1(a5)
	move.w	#$83c0,dmacon(a5)
	move.l	#0,$dff144
	rts


gfxlib:	dc.l	0

	 even
gfxname: dc.b	"graphics.library",0
	 cnop 0,2


copyright:	dc.b    "p2:nibbly/copyright.exe $"
adresse4:	dc.b	0,0,0,0,0,0,0,0
		dc.b	0
		even
mytitel:	dc.b    "p2:nibbly/titel.exe $"
adresse:	dc.b	0,0,0,0,0,0,0,0
		dc.b	0
		even
endpart:	dc.b    "p2:nibbly/endpart.exe JT"
        	even


;****************************************************************
;*  I N G A M E
;****************************************************************

ingame:
	lea	adresse2,a0
	move.l	#mysharemem,d0
	move.w	#7,d2
.insert2
	rol.l	#4,d0
	move.b	d0,d1
	and.b	#$f,d1
	add.b	#48,d1
	move.b	d1,(a0)+
	dbra	d2,.insert2

	lea	adresse3,a0
	move.l	#mysharemem,d0
	move.w	#7,d2
.insert3
	rol.l	#4,d0
	move.b	d0,d1
	and.b	#$f,d1
	add.b	#48,d1
	move.b	d1,(a0)+
	dbra	d2,.insert3


	move.l	#mysharemem,sharemem


;Open Dos Library
        move.l  4,a6
        lea     dosname,a1
	move.l	#0,d0
        jsr     _LVOOpenLibrary(a6)
        tst.l   d0
        beq     nodos
        move.l  d0,dosbase

	
	move.l	sharemem,a0
	move.l	#clist,24(a0)

	move.l	#15,8(a0)	;Signalnummer eintragen

	move.w	#2,4(a0)	;Mapstatus
	move.w	#LEVEL,6(a0)	;Starting Level
	move.w	#1,2(a0)	;Ingamestatus 
	move.l	#0,d0

	move.l	#0,a1
	move.l	4.w,a6
	jsr	_LVOFindTask(a6)
	move.l	sharemem,a0
	move.l	d0,20(a0)


	move.l	dosbase,a6
	move.l	#file1,d1
	move.l	#0,d2
	move.l	#0,d3
	jsr	_LVOExecute(a6)

	bsr	waitsig

	move.l	dosbase,a6
	move.l	#20,d1
	jsr	_LVODelay(a6)

	move.l	dosbase,a6
	move.l	#file2,d1
	move.l	#0,d2
	move.l	#0,d3
	jsr	_LVOExecute(a6)

	bsr	waitsig

	move.l	dosbase,a6
	move.l	#20,d1
	jsr	_LVODelay(a6)

	bsr	mapsig
	

waitmouse:
	bsr	waitsig

	move.l	sharemem,a0
	move.w	#0,4(a0)
	move.w	#0,2(a0)

	bsr	mapsig
	bsr	ingsig

	move.l	#20,d1
	move.l	dosbase,a6
	jsr	_LVODelay(a6)


kein_signal
	move.l  dosbase,a1
        move.l  4,a6
	jsr	_LVOCloseLibrary(a6)

nodos:
exit:
	move.l	#0,d0
	rts

nomemory
	move.l	#-1,d0
	rts	


waitsig:
	move.l	sharemem,a0	
	move.l	8(a0),d1
	move.l	#1,d0
	lsl.l	d1,d0
	move.l	4.w,a6
	jsr	-318(a6)	;wait
	rts


mapsig:	
	move.l	sharemem,a0
	move.l	12(a0),a1
	move.l	8(a0),d1
	move.l	#1,d0
	lsl.l	d1,d0
	move.l	4.w,a6
	jsr	-324(a6)	;signal
	rts

ingsig:	
	move.l	sharemem,a0
	move.l	16(a0),a1
	move.l	8(a0),d1
	move.l	#1,d0
	lsl.l	d1,d0
	move.l	4.w,a6
	jsr	-324(a6)	;signal
	rts


file1:		dc.b    "run <nil: >nil: p2:nibbly/ingame.exe $"
adresse2:	dc.b	0,0,0,0,0,0,0,0
		dc.b	0
        	even

file2:		dc.b    "run <nil: >nil: p2:nibbly/map.exe $"
adresse3:	dc.b	0,0,0,0,0,0,0,0
		dc.b	0
        	even


sharemem:	dc.l	0
dosbase: 	dc.l    0
dosname:	dc.b    "dos.library",0
        	even
savedata:	dc.l	0
dataspace:	dcb.l	20,0

quit:		dc.w	0

mysharemem:	dcb.l	32,0

		SECTION Daten,DATA_C

	even

clist:	dc.w	$0001,$ff00,dmacon,$0100,bplcon0,$0000
	dc.w	bplcon1,0,bplcon2,0
	dc.w	$180,$0
	dc.w	$1dc,$020
	dc.w	$3801,$ff00,dmacon,$8100,$ed01,$ff00
	dc.w	bplcon0,0000,$ffff,$fffe
		
	 even
ende:


