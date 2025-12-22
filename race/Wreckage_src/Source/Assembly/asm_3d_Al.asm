  	CLR.w d0
_asm3d_1:
	MOVE.b	(a0)+	,d0	;app
	MOVE.l 	(a1)+	,d1	;x
	MOVE.l 	(a2)+	,d2     	;z
	MOVE.l 	(a3)+	,d3     	;y
	
	TST.b	d0
	BEQ	_asm3d_2
	
;	ASR.l 	#8	,d3	
;	ASR.l	#8	,d3
	CLR.w	d3
	SWAP	d3
	EXT.l	d3
	TST.l 	d3
	BLE 	_asm3d_2
	
	DIVS.l	d3	,d1
	ASL.l 	#7	,d1
	DIVS.l	d3	,d2
	ASL.l	#7	,d2
	BRA	_asm3d_2a
	
		
_asm3d_2:
	CLR.w d0
_asm3d_2a:
	MOVE.l 	d1	,(a4)+	;sx
 	MOVE.l 	d2	,(a4)+    	;sy
  	MOVE.w 	d0	,(a4)+    	;app
  	SUBQ.l 	#1	,d7       	;points-1
  	BGT 	_asm3d_1       	;until points<=0

