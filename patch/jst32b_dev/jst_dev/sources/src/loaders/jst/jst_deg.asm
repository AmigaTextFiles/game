; *** JOTD HD Startup utility library
; *** Copyright Jean-Francois Fabre 1996-1998
; 
; *** Sprite degrade part Copyright Bert Jahn 1996

; *** degrader part. Other parts are not distributed

; If you use this source (or parts), I'd appreciate
; that you credit me about it. Thanks
;
	; *** For link with C programs

;;	XDEF	_C_Degrade
;;	XDEF	_C_Enhance

;;	XDEF	_Enhance
;;	XDEF	_Degrade
;;	XDEF	_DegradeCpu
;;	XDEF	_DegradeGfx

;;	XDEF	_FlushCachesSys

;;	XDEF	_Kick37Test
;;	XDEF	_KickVerTest

RESET_CIA_CODE:MACRO

ResetCIAs:
	move.b  #$c0,$bfd200            ;reinit CIAs
	move.b  #$ff,$bfd300            ;for
	move.b  #$03,$bfe201            ;KB
;	move.b  #$7f,$bfec01
	move.b  #$00,$bfee01
	move.b  #$88,$bfed01

	tst.b	$bfdd00			; acknowledge CIA-B Timer A interrupt
	tst.b	$bfed01			; acknowledge CIA-A interrupts

	bsr	AckKeyboard

	rts

AckKeyboard:
	bset	#$06,$BFEE01
	move.l	D0,-(A7)
	moveq.l	#1,D0
	IFD	HDSTARTUP
	bsr	RelFun_BeamDelay
	ENDC
	move.l	(A7)+,D0
	bclr	#$06,$BFEE01
	rts
	ENDM

	IFND	HDSTARTUP

	; *** this code is on its own (which is the case :-) )
	
_SysBase = 4

	include	"libs.i"
	include	"jst_macros.i"

	ENDC


; *** Restore degraded things: Display, Caches, VBR...

; internal use (in InGameExitAbs)

;;_C_Enhance:
;;_Enhance:
AbsFun_Enhance:
	STORE_REGS

	tst.b	degraded_cpu
	beq	skipec$

	move.l	oldcacheset(pc),D0
	moveq.l	#-1,D1
	bsr	EnaCaches

	move.l	oldvbr(pc),D0
	bsr	SetVBR

skipec$
	tst.b	degraded_gfx
	beq	exit$

	move.l	_SysBase,A6
	JSRLIB	Disable

	move.l	_GfxBase,D0
	beq	1$

	lea	$DFF000,A5
	move.l	my_copinit(PC),cop1lc(a5) ; adresse du début de la liste

	move.l	D0,A6

	bsr	EnhanceBandWidth

	move.l	my_actiview(PC),D0
	beq	1$
	move.l	D0,A1

	JSRLIB	LoadView
	JSRLIB	WaitTOF
	JSRLIB	WaitTOF

1$
	move.l	_SysBase,A6
	JSRLIB	Enable

	move.l	_IntuitionBase,D0
	beq	skip$
	move.l	D0,A6
	move.l	TheScreen,D0
	beq	skip$

	bsr	EnhanceSprites

	move.l	TheScreen,D0
	move.l	D0,A0
	move.l	TheScreen,A0
	JSRLIB	CloseScreen

	bsr	CloseIntuiLib
skip$
	bsr	CloseGFXLib
exit$

	RESTORE_REGS
	rts

DegradeBandWidth:
	STORE_REGS
	clr.b	degraded_bdw
	move.l	(_GfxBase),a6
	cmp.l	#39,(LIB_VERSION,a6)
	blo	gfxold$
	btst	#GFXB_AA_ALICE,(gb_ChipRevBits0,a6)
	beq	noaga$
	move.b	(gb_MemType,a6),oldbandwidth
	move.b	#BANDWIDTH_1X,(gb_MemType,a6)	;auf ECS Wert setzen
	move.l	#SETCHIPREV_A,D0
	JSRLIB	SetChipRev
	move.l	D0,oldchiprev
	st	degraded_bdw
noaga$
gfxold$
	RESTORE_REGS
	rts

EnhanceBandWidth:
	STORE_REGS
	tst.b	degraded_bdw
	beq	exit$

	move.l	(_GfxBase),a6

	move.l	oldchiprev,D0
	JSRLIB	SetChipRev

	move.b	oldbandwidth,(gb_MemType,a6)
	clr.b	degraded_bdw
exit$

	RESTORE_REGS
	rts

AbsFun_DegradeCpu:
_DegradeCpu:
	movem.l	D0/D1,-(sp)
	bsr	GetVBR
	move.l	D0,oldvbr
	bsr	ZeroVBR
	movem.l	(sp)+,D0/D1
	bsr	DisCaches
	move.l	D0,oldcacheset
	move.b	#$00,$DE0000		; DTack (A3000/A4000 users)
	st.b	degraded_cpu
	rts

AbsFun_DegradeGfx:
_DegradeGfx:
	bsr	OpenGFXLib
	beq	D_Exit

	bsr	OpenIntuiLib
	beq	D_Exit

	move.l	_IntuitionBase,D0
	beq	skip$
	move.l	D0,A6
	sub.l	a0,a0
	lea	ScreenTags,a1
	JSRLIB	OpenScreenTagList
	move.l	d0,TheScreen

	; set sprite to common OCS resolution

	move.l	_GfxBase,A6
	cmp.w	#39,(LIB_VERSION,a6)
	blo	skip$
	bsr	DegradeSprites	
skip$
	IFD	HDSTARTUP
	move.l	_DosBase,A6
	move.l	#20,D1
	JSRLIB	Delay		; wait 2/5 second before launching
	ENDC

	move.l	_GfxBase,A6
	move.l	gb_ActiView(A6),my_actiview
	move.l	gb_copinit(A6),my_copinit
	sub.l	A1,A1
	JSRLIB	LoadView
	JSRLIB	WaitTOF
	JSRLIB	WaitTOF
wav$
	tst.l	(gb_ActiView,a6)
	bne.b	wav$
	JSRLIB	WaitTOF

	bsr	DegradeBandWidth

	IFD	HDSTARTUP
	JSRGEN	ResetDisplay
	ENDC

	lea	$DFF000,A5
	move.w	#$0,(bplcon2,A5)
	move.w	#$0,(bplcon3,A5)
	move.w	#$0,(bpl1mod,A5)
	move.w	#$0,(bpl2mod,A5)


D_Exit:
	st.b	degraded_gfx
	rts

; *** degrade the sprites
; *** thanks to Bert Jahn for the routine!!

DegradeSprites:
	move.l	TheScreen,A0
	move.l	(sc_ViewPort+vp_ColorMap,a0),a0
	clr.l	-(a7)			;TAG_DONE
	clr.l	-(a7)
	move.l	#VTAG_SPRITERESN_GET,-(a7)
	move.l	a7,a1
	move.l	_GfxBase,a6
	JSRLIB	VideoControl
	addq.l	#4,a7
	lea	oldspriteres,a0
	move.l	(a7)+,(a0)
	addq.l	#4,a7
	
	move.l	TheScreen,a0
	move.l	(sc_ViewPort+vp_ColorMap,a0),a0
	clr.l	-(a7)			;TAG_DONE
	move.l	#SPRITERESN_140NS,-(a7)
	move.l	#VTAG_SPRITERESN_SET,-(a7)
	move.l	a7,a1
	JSRLIB	VideoControl
	lea	(12,a7),a7

	move.l	TheScreen,a0
	move.l	_IntuitionBase,a6
	JSRLIB	MakeScreen	;force the changes
	JSRLIB	RethinkDisplay

	st.b	degraded_spr
	rts

EnhanceSprites:
	tst.b	degraded_spr
	beq	exit$

	move.l	_GfxBase,A6
	move.l	TheScreen,a0
	move.l	(sc_ViewPort+vp_ColorMap,a0),a0
	clr.l	-(a7)			;TAG_DONE
	move.l	oldspriteres,-(a7)
	move.l	#VTAG_SPRITERESN_SET,-(a7)
	move.l	a7,a1
	JSRLIB	VideoControl
	lea	(12,a7),a7

	move.l	TheScreen,a0
	move.l	_IntuitionBase,a6
	JSRLIB	MakeScreen	;force the changes

	clr.b	degraded_spr
exit$
	rts

; *** Degrades everything
; in: D0,D1: value and mask for caches control
; (the same format as in CacheControl())

_C_Degrade:
	move.l	4(A7),D0
	move.l	8(A7),D1
_Degrade:
AbsFun_Degrade:
	STORE_REGS

	move.l	D0,user_cacheflags
	move.l	D1,user_cachemask

	bsr	_DegradeCpu		; degrades caches, VBR, dtack
	bsr	_DegradeGfx		; degrades sprites and screen
	bsr	ResetCIAs		; re-init keyboard

	RESTORE_REGS
	rts

DisCaches:
	movem.l	D1-A6,-(sp)

	move.l	D0,D6
	move.l	D1,D7

	bsr	_Kick37Test
	tst.l	D0
	bne	3$		; Don't touch if KS 1.x

	move.l	D6,D0
	move.l	D7,D1

	IFD	HDSTARTUP
	tst.l	leavecaches_flag
	bne	3$		; Don't touch the caches
	tst.l	nocaches_flag
	beq	5$		; Disable ALL caches
	ENDC

	moveq.l	#0,D0
	moveq.l	#-1,D1
5$
	move.l	_SysBase,A6
	JSRLIB	CacheControl
	move.l	D0,D7

	move.l	_SysBase,A6
	move.b	AttnFlags+1(A6),D0
	btst	#AFB_68060,D0
	beq	2$

	; *** remove data cache, branch cache, write cache, superscalar mode

	lea	DisCacheSup,A5
	move.l	_SysBase,A6
	JSRLIB	Supervisor
2$
	move.l	D7,D0
	movem.l	(sp)+,D1-A6
	rts

3$
	moveq.l	#0,D0
	bra	2$

EnaCaches:
	movem.l	D1-A6,-(sp)

	IFD	HDSTARTUP
	tst.l	leavecaches_flag
	bne	3$		; Don't touch the caches
	ENDC

	move.l	D0,D7
	bsr	_Kick37Test
	tst.l	D0
	bne	3$		; Don't touch if KS 1.x
	move.l	D7,D0
	move.l	_SysBase,A6
	JSRLIB	CacheControl

	move.l	D0,D7

	move.l	_SysBase,A6
	move.b	AttnFlags+1(A6),D0
	btst	#AFB_68060,D0
	beq	2$

	lea	EnaCacheSup,A5
	move.l	_SysBase,A6
	JSRLIB	Supervisor
2$
	move.l	D7,D0
	movem.l	(sp)+,D1-A6
	rts

3$
	moveq.l	#0,D0
	bra	2$

; *** Disable some '060 caches
; *** Left intact by CacheControl

; internal, only useful (and executed) for 68060 cpus

DisCacheSup:
	movem.l	D1-A6,-(sp)
	MACHINE	68060
	ori.w	#$700,sr
	movec	cacr,D0
	andi.l	#$A0800000,D0
	move.l	D0,old060cacr

	movec	cacr,D0
	move.l	#$A0800000,D1		; mask for specific 68060 caches

	not.l	D1
	and.l	D1,D0
	movec	D0,cacr

	nop

	; *** remove superscalar

	bra	nossh$
	movec	pcr,D0
	move.l	D0,old060pcr
	andi.l	#$04300100,D0
	movec	D0,pcr
nossh$

	; *** flush

	CPUSHA	BC
	movem.l	(sp)+,D1-A6
	MACHINE	68000
	rte

; *** Enable some '060 caches
; *** Left intact by CacheControl

EnaCacheSup:
	MACHINE	68060
	ori.w	#$700,sr
	movec	cacr,D0
	or.l	old060cacr,D0
	movec	D0,cacr

	bra	nossh$
	movec	pcr,D0
	or.l	old060pcr,D0
	movec	D0,pcr
nossh$

	CPUSHA	BC
	MACHINE	68000
	rte

; *** Gets VBR value
; out: D0: VBR value

; VBR is the vector base register (interrupts, traps, exceptions)
; It exists on 68010, 68020, 68030, 68040, 68060
; Most of the games don't like it to be different from zero,
; others are originally HD-Installable :-)
; Called from a 68000, this function will return 0 in any case (no VBR)

GetVBR:
	movem.l	D1-A6,-(sp)
	lea	GetVBRSup,A0
	bsr	OperateVBR
	movem.l	(sp)+,D1-A6
	rts

; *** Sets VBR value
; in: D0: new VBR value

; Called from a 68000, this function will do nothing (no VBR)
; It will do nothing if the LEAVEVBR tooltype is set too (debug)

SetVBR:
	movem.l	D1-A6,-(sp)
	lea	SetVBRSup,A0
	bsr	OperateVBR
	movem.l	(sp)+,D1-A6
	rts
	
; *** Sets VBR to zero
; It will do nothing if the LEAVEVBR tooltype is set (debug)

ZeroVBR:
	movem.l	D1-A6,-(sp)
	moveq.l	#0,D0
	bsr	SetVBR
	movem.l	(sp)+,D1-A6
	rts

; *** VBR operation
; in: A0: supervisor function to call
;     D0: value to pass to the sup function
; out D0: return val of the sup function

; It will do nothing if the LEAVEVBR tooltype is set (debug)


OperateVBR:
	movem.l	D1-D7/A0-A6,-(A7)
	move.l	A0,A5			; supervisor function

	move.l	_SysBase,A6
	move.b	AttnFlags+1(A6),D1
	btst	#AFB_68010,D1		; At least 68010
	beq	error$

	move.l	_SysBase,A6
	JSRLIB	Supervisor
exit$
	movem.l	(A7)+,D1-D7/A0-A6
	rts
error$
	moveq.l	#0,D0
	bra	exit$

; *** Supervisor call to set the VBR

SetVBRSup:
	IFD	HDSTARTUP
	tst.l	leavevbr_flag
	bne	exit$
	ENDC

	MACHINE 68010
	movec	D0,VBR
	MACHINE 68000
exit$
	rte

; *** Supervisor call to get the VBR

GetVBRSup:
	MACHINE 68010
	movec	VBR,D0
	MACHINE 68000
	rte


; *** open graphics library

OpenGFXLib:
	movem.l	D1-A6,-(sp)
	lea	grname,A1
	move.l	_SysBase,A6
	moveq.l	#0,D0
	JSRLIB	OpenLibrary
	move.l	D0,_GfxBase
	movem.l	(sp)+,D1-A6
	rts

; *** close graphics library

CloseGFXLib:
	movem.l	D0-A6,-(sp)
	move.l	_SysBase,A6
	move.l	_GfxBase,D0
	beq	skip$
	move.l	D0,A1
	JSRLIB	CloseLibrary
	clr.l	_GfxBase
skip$
	movem.l	(sp)+,D0-A6
	rts

; *** open intuition library

OpenIntuiLib:
	movem.l	D1-A6,-(sp)
	lea	intname,A1
	move.l	_SysBase,A6
	moveq.l	#36,D0
	JSRLIB	OpenLibrary
	move.l	D0,_IntuitionBase
	movem.l	(sp)+,D1-A6
	rts

; *** close intuition library

CloseIntuiLib:
	movem.l	D0-A6,-(sp)
	move.l	_SysBase,A6
	move.l	_IntuitionBase,D0
	beq	skip$
	move.l	D0,A1
	JSRLIB	CloseLibrary
	clr.l	_IntuitionBase
skip$
	movem.l	(sp)+,D0-A6
	rts


; *** Flushes the caches

	cnop	0,4
_FlushCachesSys:
AbsFun_FlushCachesSys:
	STORE_REGS
	bsr	_Kick37Test
	tst.l	D0
	bne	2$		; Don't touch if KS 1.x
	moveq.l	#0,D0
	moveq.l	#0,D1
	move.l	_SysBase,A6
	JSRLIB	CacheControl
2$
	RESTORE_REGS
	rts

; *** Test ROM version
; out: D0=0  if KS>36
;      D0!=0 if KS<=36

AbsFun_Kick37Test:
_Kick37Test:
	move.l	#36,D0
	bsr	_KickVerTest
	rts	

; *** Test if ROM version > a given version
; in: D0: kickstart version number
; out:D0=0 newer !=0 older

	cnop	0,4
AbsFun_KickVerTest:
_KickVerTest:
	movem.l	D1/A5/A6,-(sp)

	move.l	_SysBase,A6
	move.w	SoftVer(A6),D1
	cmp.w	D0,D1
	bgt.s	newer$
	movem.l	(sp)+,D1/A5/A6
	moveq.l	#-1,D0
	rts
newer$
	movem.l	(sp)+,D1/A5/A6
	moveq.l	#0,D0
	rts



; *** Reset the CIAs for the keyboard
; *** Thanks to Alain Malek for this piece of code
; (see macro definition)

	IFND	HDSTARTUP
	RESET_CIA_CODE
	ENDC

; ** update system time from battery backed up clock

SetClockLoad:
	STORE_REGS
	moveq.l	#-1,D6

	;; snip (code in the registered version!)

	RESTORE_REGS
	rts

io_request:
	dc.l	0
my_actiview:
	dc.l	0
my_copinit:
	dc.l	0
oldvbr:
	dc.l	0
oldcacheset:
	dc.l	0
old060cacr:
	dc.l	0
old060pcr:
	dc.l	0

cache_value:
	dc.l	0
cache_mask:
	dc.l	0

BattBase:
	dc.l	0
	IFND	HDSTARTUP
_GfxBase:
	dc.l	0
	ENDC

_IntuitionBase:
	dc.l	0

TheScreen:
	dc.l	0

ScreenTags:
		dc.l	SA_DisplayID,135168	; PAL lores
		dc.l	SA_Width,320
		dc.l	SA_Height,200
		dc.l	SA_Depth
		dc.l	2			; 4 colors
		dc.l	SA_Quiet,-1
		dc.l	SA_AutoScroll,0
		dc.l	0,0

oldspriteres:
	dc.l	0
oldbandwidth:
	dc.l	0
oldchiprev:
	dc.l	0

user_cacheflags:
	dc.l	0
user_cachemask:
	dc.l	0

grname:
	dc.b	"graphics.library",0
intname:
	dc.b	"intuition.library",0
timername:
	dc.b	"timer.device",0
battname:
	dc.b	"battclock.resource",0

degraded_bdw:
	dc.b	0
degraded_cpu:
	dc.b	0
degraded_gfx:
	dc.b	0
degraded_spr:
	dc.b	0
degraded_mmu:
	dc.b	0

	cnop	0,4
