; *** Frenetic HD Loader v1.1
; *** Written by Keith Krellwitz (kkrellwi@nmu.edu)
; *** Support for original and trainer by Codetapper/Action (codetapper@hotmail.com)

	MACHINE	68000

	include	"jst.i"

	HD_PARAMS	"Disk.",STD_DISK_SIZE,2

_loader:
	RELOC_MOVEL	D0,trainer

	Mac_printf	"Frenetic HD Loader v1.1"
	Mac_printf	"Programmed by Keith Krellwitz & Jeff 1997"
	NEWLINE
	Mac_printf	"Support for original and trainer by Codetapper/Action in 2000"
	Mac_printf	"During the game, press Help to toggle infinite lives!"

	tst.l	D0
	beq	notrain
	NEWLINE
	Mac_printf	"Trainer activated"
notrain:
	JSRABS	LoadDisks

	move.l	#CACRF_CopyBack,D1
	moveq.l	#0,D0
	JSRABS	Degrade

	GO_SUPERVISOR
	SAVE_OSDATA	$80000

	LEA		$0007F000,A7
	MOVE	#$14,SR
	JSRGEN	FreezeAll
	BSET	#$01,$00BFE001

	move.l	#$0,d0
	move.l	#$0,d3
	lea		$a498,a0
	move.l	#$3e8,d1				;offset
	move.l	#$14,d2					;length
	JSRGEN  ReadRobSectors
	PATCHUSRJMP	$a5ba,jumper1
	JSRGEN	FlushCachesHard
	jmp		$a4a0
jumper1:
	move.l	#$8394687,$71674
	PATCHGENJMP	$70b68,ReadRobSectors
	PATCHUSRJMP	$70b16,jumper2
	JSRGEN	FlushCachesHard
	jmp		$70ad6

jumper2:
	PATCHUSRJMP	$62646,loadtracks
	PATCHUSRJMP	$625ee,jumper3
	bsr 	swap
	JSRGEN	FlushCachesHard
	jmp		$65000

jumper3:
	move.l	a0,-(sp)
	bsr	loadtracks

	lea	$4000,a0		;At this stage, detect version

	cmp.l	#$48e7ffff,(a0)		;Original game
	beq	_original

	cmp.l	#$000003f3,(a0)		;Vince/Tristar packed (crack)
	beq	_crack

	JSRGEN	InGameExit		;Unknown version, quit!

;======================================================================

_original:
	PATCHUSRJMP	$4178,_reloc	;Only works on ORIGINAL!
	JSRGEN	FlushCachesHard
	move.l	(sp)+,a0
	jmp	$4000.w

_reloc:	move.b	(a0)+,(a1)+		;Routine on stack to relocate to $4000
	subq.l	#1,d0
	bne.b	_reloc
.clr:	clr.b	(a1)+
	subq.l	#1,d1
	bne.b	.clr
	movem.l	(sp)+,d0-d7/a0-a6

	bsr	jumper4		;Crack game, add quit key, beam wait
	jmp	$4000

_crack:
	PATCHUSRJMP	$423e,_crackfx
	JSRGEN	FlushCachesHard
	move.l	(sp)+,a0
	jmp	$4020.w			;It's a miracle $4000 ever worked!

_crackfx:
	bsr	jumper4		;Crack game (overkill!), add quit key, beam wait
	jmp	(a2)

jumper4:
	move.l	a0,-(sp)

	lea	$42f4,a0		;Patch RNC protection :)
	move.l	#$28bcad44,(a0)+
	move.l	#$ba136000,(a0)+
	move.w	#$08c4,(a0)+
		
	lea	$4d8e,a0		;Send final protection to Valhalla :)
	move.l	#$28bcad44,(a0)+	;Hey diddily de,
	move.l	#$ba136000,(a0)+	;a crackers life for me :)
	move.w	#$08c4,(a0)+

	PATCHUSRJMP	$27450,loadtracks
	move.w	#$c000,$9a(a4)
	PATCHUSRJSR	$af9c,KbInt

	PATCHUSRJMP	$100.W,BeamWait

	RELOC_TSTL	trainer
	beq	skip$
	eor.w	#$647f,$6724			;Setup infinite lives

skip$
	JSRGEN	GoECS
	JSRGEN	FlushCachesHard
	move.l	(sp)+,a0
	rts

BeamWait:
	divu.w	#$28,D0
	swap	D0
	clr.w	D0
	swap	D0
	JSRGEN	BeamDelay
	rts

loadtracks:
	move.l	disknum(pc),d0
	JSRGEN ReadRobSectors

	cmp.l	#$51C8FFFE,$156A6
	bne.b	skip
	move.l	#$4EB80100,D0
	move.l	D0,$156A6
	move.l	D0,$156B4
	move.l	D0,$15BCC
	move.l	D0,$15BF8
skip:
	JSRGEN	FlushCachesHard
	moveq.l	#0,D0
	rts

swap:
	STORE_REGS
	lea	disknum(pc),a0
	move.l	(a0),d0
	eor.b	#$1,d0
	move.l	d0,(a0)
	RESTORE_REGS
	rts

KbInt:
	move.b	d0,$af50
	cmp.b 	#$59,d0				; f10	
	bne	noquit
	JSRGEN	InGameExit
noquit:	cmp.b	#$5f,d0
	bne	_NoTrainer
	cmp.w	#$479,$6724
	bne	_NoFlash
	move.w	#$fff,$dff180
_NoFlash:
	eor.w	#$647f,$6724		;$479 = no trainer, $6006 = trainer
_NoTrainer:
	rts

disknum:
	dc.l	0
trainer:
	dc.l	0

