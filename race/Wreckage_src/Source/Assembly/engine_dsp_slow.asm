;a0 holds address of sound
;a1 address of target sound
;d4 filter frequency

	MOVE.w	#128	,d7
	MOVE.l	#0	,d0
	
_dsp_loop1:
	MOVE.b	-1(a0,d0.l)	,d1
	EXT.w	d1
	MOVE.b	(a0,d0.l)	,d2
	EXT.w	d2
	MOVE.b	1(a0,d0.l)	,d3
	EXT.w	d3
	
	ADD.w	d1	,d3
	
	ASR.w	#1	,d3
	SUB.w	d3	,d2
	MULS.w	d4	,d2
	ASR.w	#7	,d2
	ADD.w	d3	,d2
	
		

	CMP.w	#127	,d2
	BGT	_adjust_positive
	CMP.w	#-128	,d2
	BLT	_adjust_negative
	BRA	_dsp_loop2

_adjust_positive:
	MOVE.b	#127	,d2
	BRA	_dsp_loop2

_adjust_negative:
	MOVE.b	#-128	,d2

_dsp_loop2:
	
	MOVE.b	d2	,(a1,d0.l)
	ADDI.l	#1	,d0
	SUBQ.w	#1	,d7
	BGT	_dsp_loop1

	