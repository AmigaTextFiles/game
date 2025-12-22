; Crazy Sue II mods unpacker
	include	lvo/exec_lib.i
	include	lvo/dos_lib.i
	include	dos/dos.i

samps_size=56754
buf_size=19600

	section	1,code

	move.l	4.w,a6
	lea	dosname(pc),a1
	moveq	#33,d0
	jsr	_LVOOpenLibrary(a6)
	tst.l	d0
	beq	.quit

	move.l	d0,a6		; A6 = DOSBASE
	lea	dest,a5		; A5 = DEST
	lea	samps,a4	; A4 = SAMPS
	lea	mus,a3		; A3 = MUS

	moveq	#6-1,d7		; loop 6 times...

	moveq	#0,d6
.next	lea	offsets(pc),a1
	move.w	sizes-offsets(a1,d6.w),d5	; get unpacked size
	move.l	a3,a0
	adda.w	(a1,d6.w),a0


	addq.l	#2,d6		; get next packed music address
	move.l	a5,a1		; and unpack address
	bsr.s	unpack		; and then unpack

	lea	modname(pc),a0
	addq.b	#1,15(a0)	; next name (blah2.1, blah2.2, ...)
	move.l	a0,d1
	move.l	#MODE_NEWFILE,d2
	jsr	_LVOOpen(a6)	; create new file
	move.l	d0,d4
	beq.s	.done		; skip save if we can't write

	move.l	d4,d1
	move.l	a5,d2
	move.l	d5,d3
	jsr	_LVOWrite(a6)	; save unpacked music

	move.l	d4,d1
	move.l	a4,d2
	move.l	#samps_size,d3
	jsr	_LVOWrite(a6)	; save samples

	move.l	d4,d1
	jsr	_LVOClose(a6)	; close file
.done	dbra	d7,.next

	move.l	a6,a1
	move.l	4.w,a6
	jsr	_LVOCloseLibrary(a6)
.quit	moveq	#0,d0
	rts

;---------------------------------

; bytekiller unpacker

unpack	movem.l	d0-d7/a0-a6,-(sp)
	move.l	(a0),d1
	adda.l	d1,a0
	movea.l	-(a0),a2
	adda.l	a1,a2
	move.l	-(a0),d5
	move.l	-(a0),d0
	eor.l	d0,d5
1$	lsr.l	#1,d0
	bne.s	2$
	bsr.l	15$
2$	blo.s	9$
	moveq	#8,d1
	moveq	#1,d3
	lsr.l	#1,d0
	bne.s	3$
	bsr.l	15$
3$	blo.s	11$
	moveq	#3,d1
	clr.w	d4
4$	bsr.l	16$
	move.w	d2,d3
	add.w	d4,d3
5$	moveq	#7,d1
6$	lsr.l	#1,d0
	bne.s	7$
	bsr.l	15$
7$	roxl.l	#1,d2
	dbra	d1,6$
	move.b	d2,-(a2)
	dbra	d3,5$
	bra.s	13$

8$	moveq	#8,d1
	moveq	#8,d4
	bra.s	4$

9$	moveq	#2,d1
	jsr	16$.l
	cmp.b	#2,d2
	blt.s	10$
	cmp.b	#3,d2
	beq.s	8$
	moveq	#8,d1
	bsr.l	16$
	move.w	d2,d3
	move.w	#12,d1
	bra.s	11$

10$	move.w	#9,d1
	add.w	d2,d1
	addq.w	#2,d2
	move.w	d2,d3
11$	bsr.l	16$
12$	subq.w	#1,a2
	move.b	0(a2,d2.w),(a2)
	dbra	d3,12$
13$	cmpa.l	a2,a1
	blt.l	1$
14$	movem.l	(sp)+,d0-d7/a0-a6
	rts

15$	move.l	-(a0),d0
	eor.l	d0,d5
	move.w	#$10,ccr
	roxr.l	#1,d0
	rts

16$	subq.w	#1,d1
	clr.w	d2
17$	lsr.l	#1,d0
	bne.s	18$
	move.l	-(a0),d0
	eor.l	d0,d5
	move.w	#$10,ccr
	roxr.l	#1,d0
18$	roxl.l	#1,d2
	dbra	d1,17$
	rts

;---------------------------------
; CONTENTS OF SONGS.DAT FILE
;	offset	unpacked size	filename
;	$0000	16444		mod.crazy-sue2.5
;	$102C	4156		mod.crazy-sue2.2
;	$156C	19516		mod.crazy-sue2.3
;	$2960	17468		mod.crazy-sue2.4
;	$37F4	16444		mod.crazy-sue2.1
;	$4508	3132		mod.crazy-sue2.6

offsets	dc.w	$37F4, $102C, $156C, $2960, $0000, $4508
sizes	dc.w	16444, 4156,  19516, 17468, 16444, 3132

dosname	dc.b	'dos.library',0
modname	dc.b	'mod.crazy-sue2.0',0

	section	2,data
mus	incbin	songs.dat
samps	incbin	samps.dat

	section	3,bss
dest	ds.b	buf_size
