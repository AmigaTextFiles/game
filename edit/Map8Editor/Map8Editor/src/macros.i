*
* All kinds of macros
*


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
.\@	btst	#6,DMACONR(a6)
	bne.b	.\@
	move.w	#$0400,DMACON(a6)
	endm


	; write a copper wait instruction
	; arguments: vpos,hpos,<ea>
	macro	COPWAIT
	move.l	#((\1)&$ff)<<24|(((\2)&$fe)|1)<<16|$fffe,\3
	endm
