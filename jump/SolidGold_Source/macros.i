*
* All kinds of macros
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*


	; version
	macro	GAME_VERSION
	dc.b	"V0.1"
	endm


	; skips the following instruction word
	macro	SKIPW
	dc.w	$0c40
	endm

	; skips the following two instruction words
	macro	SKIPL
	dc.w	$0c80
	endm


	; wait until the blitter is ready
	macro	WAITBLIT
	move.w	#$8400,DMACON(a6)
.\@:	btst	#6,DMACONR(a6)
	bne.b	.\@
	move.w	#$0400,DMACON(a6)
	endm


	; write a copper wait instruction
	; arguments: vpos,hpos,<ea>
	macro	COPWAIT
	move.l	#((\1)&$ff)<<24|(((\2)&$fe)|1)<<16|$fffe,\3
	endm


	; list macros

	; remove node from list: node-An(destroyed),scratch-An
	macro	REMOVE
	move.l	(\1)+,\2
	move.l	(\1),\1
	move.l	\2,(\1)
	move.l	\1,4(\2)
	endm

	; remove head node: list-An,scratch-An,node-Dn,empty-label
	macro	REMHEAD
	move.l	(\1),\2
	move.l	(\2),\3
	beq	\4
	move.l	\3,(\1)
	exg	\3,\2
	move.l	\1,4(\2)
	endm

	; add node to list head: list-An(destroyed),node-An,scratch-Dn
	macro	ADDHEAD
	move.l	(\1),\3
	move.l	\2,(\1)
	movem.l	\3/\1,(\2)
	move.l	\3,\1
	move.l	\2,4(\1)
	endm

	; add node to list tail: list(destroyed)-An,node-An,scratch-Dn
	macro	ADDTAIL
	addq.l	#4,\1
	move.l	4(\1),\3
	move.l	\2,4(\1)
	exg	\3,\1
	movem.l	\3/\1,(\2)
	move.l	\2,(\1)
	endm
