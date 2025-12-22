	IFND	MACROS_I
MACROS_I	SET	1

;************************************************
;*
;* WAITV
;*
;* wait for vertical beam position
;*
;* d0.w is beam position
;*
;************************************************

WAITV	MACRO

	movem.l	d0/a0,-(sp)
	lea	$dff004,a0
.Rastx\@	move.l	(a0),d0		;33222222222211111111110000000000	
				;10987654321098765432109876543210
				;fiiiiiiilxxxxvvvvvvvvvvvhhhhhhhh
				;             1
				;             09876543210           
	lsr.l	#8,d0		;00000000fiiiiiiilxxxxvvvvvvvvvvv
	and	#$7ff,d0
        cmp	\1,d0
	bne.s	.Rastx\@
	movem.l	(sp)+,d0/a0

	ENDM
	
;************************************************
;*
;* WAITVMAX
;*
;* wait for vertical max beam position
;*
;* d0.w is beam position
;*
;************************************************

WAITVMAX	MACRO

	movem.l	d0/a0,-(sp)
	lea	$dff004,a0
.RastMx\@	
	move.l	(a0),d0						
	lsr.l	#8,d0		
	and	#$7ff,d0
        cmp	\1,d0
	bgt.s	.RastMx\@
	movem.l	(sp)+,d0/a0

	ENDM	
	
		
;************************************************
;*
;* WAITVMIN
;*
;* wait for vertical min beam position
;*
;* d0.w is beam position
;*
;************************************************

WAITVMIN	MACRO

	movem.l	d0/a0,-(sp)
	lea	$dff004,a0
.RastMx\@	
	move.l	(a0),d0						
	lsr.l	#8,d0		
	and	#$7ff,d0
        cmp	\1,d0
	blt.s	.RastMx\@
	movem.l	(sp)+,d0/a0

	ENDM	
	
;************************************************
;*
;* GETVd0
;*
;* wait for vertical beam position
;*
;* d0.l is beam position
;*
;************************************************	
	
GETVd0	MACRO

	move.l	$dff004,d0
	lsr.l	#8,d0
	and.l	#$7ff,d0
	
	ENDM	
	
;************************************************
;*
;* DEBC
;*
;* set COLOR0 if DEBUG is defined
;*
;************************************************
	
DEBC	MACRO
	IFD	DEBUG
	move	\1,$dff180
	ENDIF
	ENDM	
	
;************************************************
;*
;* MULUC
;*
;* mulu const
;*
;* capture some values mostly used in code
;*
;* \1 = const word value
;* \2 = second factor and dest
;* \3 = temp reg
;*
;************************************************

MULUC	MACRO
	IFEQ	(\1-40)
	move	\2,\3	;4
	lsl	#5,\2	;16 = 6+2*5
	lsl	#3,\3 	;12 = 6+2*3
	add	\3,\2	;4 -> 36
	ELSE
	IFEQ	(\1-14)
	move	\2,\3	;4
	lsl	#4,\2	;14 = 6+2*4
	sub	\3,\2	;4
	sub	\3,\2	;4 -> 26
	ELSE
	ECHO	"can't optimize mulu #\1,\2"
	MULU	#\1,\2
	ENDC
	ENDC
	ENDM
	