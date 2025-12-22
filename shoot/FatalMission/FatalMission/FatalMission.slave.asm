; Fatal Mission loader

	include	whdload.i
	include	whdmacros.i
	include	lvo/exec_lib.i

base	SLAVE_HEADER
	dc.w	10,0			; whdload version required, flags
	dc.l	$80000,0		; basemem, 0
	dc.w	start-base,0,0		; slave code, dir, dontcache
	dc.b	0,$59			; debugkey, quitkey
expmem	dc.l	$4b000			; 4A014 needed :(
	dc.w	name-base,copy-base,info-base
name	dc.b	'Fatal Mission',0
copy	dc.b	'1991 Robin Burrows <rburrows@bigfoot.com>',0
info	dc.b	'HD-installed by Kyzer <kyzer@4u.net>',0
	cnop	0,4
resload	dc.l	0
tags	dc.l	WHDLTAG_CUSTOM1_GET
trainer	dc.l	0,TAG_DONE

start	move.l	a0,a6
	lea	resload(pc),a0
	move.l	a6,(a0)

	lea	tags(pc),a0
	jsr	resload_Control(a6)

	; install fake exec
	lea	$400.w,a1
	move.l	a1,4.w
	patch	_LVOAllocMem(a1),.alloc   ; only called twice, chip and fast
	patch	_LVOOpenLibrary(a1),.open ; only to get gfxbase for shutdown
	ret	_LVOFreeMem(a1)
	ret	_LVOCloseLibrary(a1)

	; load and relocate FM1 into fastmem
	lea	fm(pc),a0
	move.l	expmem(pc),a1
	jsr	resload_LoadFile(a6)
	tst.l	d0
	beq.s	.fail
	move.l	expmem(pc),a0
	suba.l	a1,a1
	jsr	resload_Relocate(a6)
	tst.l	d0
	beq.s	.fail

	; load hiscores
	lea	hisc(pc),a0
	move.l	expmem(pc),a1
	patchs	$aca(a1),.hisc	; add hiscore save patch
	add.l	#$44f6c,a1
	jsr	resload_LoadFile(a6)

	; cheats / run game
	move.l	expmem(pc),a0
	move.l	trainer(pc),d0
	beq.s	.nocht
	move.w	#$4e71,d0
	move.w	d0,$1176(a0)	; end of game DIED test
	move.w	d0,$1aa2(a0)	; enemy collision player 1
	move.w	d0,$1b90(a0)	; enemy collision player 2
	move.w	d0,$1d34(a0)	; scenery collision player 1
	move.w	d0,$1df8(a0)	; scenery collision player 2
.nocht	jsr	$72(a0)		; run game

.fail	move.w	#$7fff,_custom+intena
	pea	TDREASON_OK.w
	move.l	resload(pc),-(sp)
	addq.l	#resload_Abort,(sp)
	rts

.alloc	move.l	expmem(pc),d0
	add.l	#$45000,d0
	btst.b	#1,d1
	beq.s	.fast
.open	move.l	#$400,d0
.fast	rts

.hisc	move.w	#$7fff,intena(a6)	; the instruction we overwrote
	movem.l	d0-d1/a0-a2,-(sp)
	lea	hisc(pc),a0
	move.l	expmem(pc),a1
	add.l	#$44f6c,a1
	move.l	resload(pc),a2
	moveq	#112,d0
	jsr	resload_SaveFile(a2)
	movem.l	(sp)+,d0-d1/a0-a2
	rts

fm	dc.b	"FM1",0
hisc	dc.b	"FM1.hisc",0

