;a0 holds address of sound
;a1 address of target sound
;d4 filter frequency

	MOVE.l	#1	,d0
	SUB.w	d5	,d7
	ASL.w	#1	,d7
	EXT.l	d5
	ADD.l	d5	,a0
	ADD.l	d5	,a1

_dsp_loop1:
	MOVE.b	(a0)	,d1
	EXT.w	d1
	MOVE.b   1(a0)	,d2
	EXT.w	d2
	MOVE.b	2(a0)	,d3
	EXT.w	d3
	ADD.l	#14	,a0

	ADD.w	d1	,d3
	ASR.w	#1	,d3
	SUB.w	d3	,d2
	MULS.w	d4	,d2
	
	CLR.w	d2
	SWAP	d2
	
	ADD.w	d3	,d2
	
;	ASR.w	#1	,d2
	MOVE.b	d2	,(a1)
	ADD.l	#16	,a1
	
	SUBI.w	#8	,d7
	BGT	_dsp_loop1

	