;c2p by Noe / Venus Art 5 pass cpu,for 040 cpu

;3 functions must be provided:
; C2P_Init
; C2P_CleanUp
; C2P_Do
;

; this in plugin module, cannot be started as any other program
        moveq   #0,d0
        rts

; Do not change this:

        dc.b    "C2P",0                 ;module id, MUST BE 'C2P'!!!
        dc.l    C2P_Init                ; pointer to init routine
        dc.l    C2P_CleanUp             ;pointer to de-init routine
        dc.l    C2P_Do                  ;pointer to main c2p function
        dc.l    0

        cnop    0,4
C2P_Init
; Here you can do all initializations needed by yours c2p
; In:
;  d0.l SCREENWIDTH
;  d1.l SCREENHEIGHT
; Out:
;  0  - something went wrong
;  1  - Init ok, C2P supports every resolution
;  2  - Init ok, C2P supports only 320x200 resolution.

        moveq   #2,d0
        rts

        cnop    0,4
C2P_CleanUp
; Here you should clean all things you have made in C2P_Init 
; (like freeing memory, etc.)
; This module does nothing here... ;)
        rts

;some usefull macros

MOVE_HI_nBITS2	MACRO	; data1, data2
			; data3, data4
			; mask, shift
		and.l	\5,\1
		and.l	\5,\2
		and.l	\5,\3
		and.l	\5,\4
		lsr.l	#\6,\2
		lsr.l	#\6,\4
		or.l	\2,\1
		or.l	\4,\3
		ENDM

MERGE_nBITS2	MACRO	; data1, data2, temp12,
			; data3, data4, temp34,
			; mask, shift
		move.l	\2,\3			; 2
		move.l	\5,\6			; 2
		lsr.l	#\8,\3			; 4
		lsr.l	#\8,\6			; 4
		eor.l	\1,\3			; 2
		eor.l	\4,\6			; 2
		and.l	\7,\3			; 2
		and.l	\7,\6			; 2
		eor.l	\3,\1			; 2
		eor.l	\6,\4			; 2
	IFEQ	\8-1
		add.l	\3,\3			; 2
		add.l	\6,\6			; 2
	ELSE
		lsl.l	#\8,\3			; 4
		lsl.l	#\8,\6			; 4
	ENDC
		eor.l	\3,\2			; 2
		eor.l	\6,\5			; 2
		ENDM				; = 32/36

MERGE_WORD2	MACRO	; data1, data2, temp12
			; data3, data4, temp34
		move.l	\2,\3			; 2
		move.l	\5,\6			; 2
		move.w	\1,\2			; 2
		move.w	\4,\5			; 2
		swap	\2			; 4
		swap	\5			; 4
		move.w	\2,\1			; 2
		move.w	\5,\4			; 2
		move.w	\3,\2			; 2
		move.w	\6,\5			; 2
		ENDM				; = 24

MOVE_LO_nBITS2	MACRO	; data1, data2
			; data3, data4
			; mask, shift
		and.l	\5,\1
		and.l	\5,\2
		and.l	\5,\3
		and.l	\5,\4
	IFEQ	\6-1
		add.l	\2,\1
		add.l	\4,\3
	ELSE
		lsl.l	#\6,\1
		lsl.l	#\6,\3
	ENDC
		or.l	\2,\1
		or.l	\4,\3
		ENDM

;hardcoded screen resolution.
;It is possible to patch this routine to use other resolution than 320x200
; but it requires selfmodyfing code.

WIDTH		EQU	320
HEIGHT		EQU	200
WIDTH_B		EQU	WIDTH>>3

        cnop    0,4
C2P_Do
;Core c2p routine.
;
; In:
;  a0.l - pointer to chunky in fastmem. (SCREENWIDTH*SCREENHEIGHT)
;  a1.l - pointer to INTERLEAVED bitplanes
; Out:
;  None
		movem.l	d2-d7/a2-a6,-(sp)

		move.l	a1,-(sp)
		move.l	a0,-(sp)

c2p_p1		lea	(a1,(4*WIDTH_B).w),a1
c2p_p2		lea	(a0,(WIDTH*HEIGHT).l),a2

		move.l	#$00ff00ff,a6

c2p_p3		move.w	#WIDTH/32,d7

		move.l	#$f0f0f0f0,d6

		movem.l	(a0)+,d0/d1/d2/d3

		MOVE_HI_nBITS2	d0,d1,d2,d3,d6,4

		movem.l	(a0)+,d1/d3/d4/d5

		MOVE_HI_nBITS2	d1,d3,d4,d5,d6,4

		move.l	a6,d6
		MERGE_nBITS2	d0,d2,d3,d1,d4,d5,d6,8

		MERGE_WORD2	d0,d1,d3,d2,d4,d5

		move.l	#$33333333,d6
		MERGE_nBITS2	d0,d1,d3,d2,d4,d5,d6,2

		move.l	#$55555555,d6
		MERGE_nBITS2	d0,d2,d3,d1,d4,d5,d6,1

c2p_p4		move.l	d0,(a1,(3*WIDTH_B).w)
		move.l	d2,a3
		move.l	d1,a4
		move.l	d4,a5

C2P_FI_320x200C_loop1
		move.l	#$f0f0f0f0,d6

		movem.l	(a0)+,d0/d1/d2/d3

		MOVE_HI_nBITS2	d0,d1,d2,d3,d6,4

		movem.l	(a0)+,d1/d3/d4/d5

c2p_p5		move.l	a3,(a1,(2*WIDTH_B).w)

		MOVE_HI_nBITS2	d1,d3,d4,d5,d6,4

		move.l	a6,d6
		MERGE_nBITS2	d0,d2,d3,d1,d4,d5,d6,8

c2p_p6		move.l	a4,(a1,(1*WIDTH_B).w)

		MERGE_WORD2	d0,d1,d3,d2,d4,d5

		move.l	#$33333333,d6
		MERGE_nBITS2	d0,d1,d3,d2,d4,d5,d6,2

		move.l	a5,(a1)+

		subq.w	#1,d7
		bne.b	C2P_FI_320x200C_1
c2p_p7		lea	(a1,(7*WIDTH_B).w),a1
c2p_p8		move.w	#WIDTH/32,d7
C2P_FI_320x200C_1

		move.l	#$55555555,d6
		MERGE_nBITS2	d0,d2,d3,d1,d4,d5,d6,1

		move.l	d2,a3
		move.l	d1,a4
		move.l	d4,a5
c2p_p9		move.l	d0,(a1,(3*WIDTH_B).w)

		cmpa.l	a2,a0
		bne.w	C2P_FI_320x200C_loop1

		move.l	(sp)+,a0

c2p_p10		move.w	#WIDTH/32,d7

		move.l	#$0f0f0f0f,d6

		movem.l	(a0)+,d0/d1/d2/d3

		MOVE_LO_nBITS2	d0,d1,d2,d3,d6,4

		movem.l	(a0)+,d1/d3/d4/d5

c2p_p11		move.l	a3,(a1,(2*WIDTH_B).w)

		MOVE_LO_nBITS2	d1,d3,d4,d5,d6,4

		move.l	a6,d6
		MERGE_nBITS2	d0,d2,d3,d1,d4,d5,d6,8

c2p_p12		move.l	a4,(a1,(1*WIDTH_B).w)

		MERGE_WORD2	d0,d1,d3,d2,d4,d5

		move.l	#$33333333,d6
		MERGE_nBITS2	d0,d1,d3,d2,d4,d5,d6,2

		move.l	a5,(a1)

		move.l	#$55555555,d6
		MERGE_nBITS2	d0,d2,d3,d1,d4,d5,d6,1

		move.l	(sp)+,a1

c2p_p13		move.l	d0,(a1,(3*WIDTH_B).w)
		move.l	d2,a3
		move.l	d1,a4
		move.l	d4,a5

C2P_FI_320x200C_loop2
		move.l	#$0f0f0f0f,d6

		movem.l	(a0)+,d0/d1/d2/d3

		MOVE_LO_nBITS2	d0,d1,d2,d3,d6,4

		movem.l	(a0)+,d1/d3/d4/d5

c2p_p14		move.l	a3,(a1,(2*WIDTH_B).w)

		MOVE_LO_nBITS2	d1,d3,d4,d5,d6,4

		move.l	a6,d6
		MERGE_nBITS2	d0,d2,d3,d1,d4,d5,d6,8

c2p_p15		move.l	a4,(a1,(1*WIDTH_B).w)

		MERGE_WORD2	d0,d1,d3,d2,d4,d5

		move.l	#$33333333,d6
		MERGE_nBITS2	d0,d1,d3,d2,d4,d5,d6,2

		move.l	a5,(a1)+

		subq.w	#1,d7
		bne.b	C2P_FI_320x200C_2
c2p_p16		lea	(a1,(7*WIDTH_B).w),a1
c2p_p17		move.w	#WIDTH/32,d7
C2P_FI_320x200C_2

		move.l	#$55555555,d6
		MERGE_nBITS2	d0,d2,d3,d1,d4,d5,d6,1

		move.l	d2,a3
		move.l	d1,a4
		move.l	d4,a5
c2p_p18		move.l	d0,(a1,(3*WIDTH_B).w)

		cmpa.l	a2,a0
		bne.w	C2P_FI_320x200C_loop2

c2p_p19		move.l	a3,(a1,(2*WIDTH_B).w)
c2p_p20		move.l	a4,(a1,(1*WIDTH_B).w)
		move.l	a5,(a1)

		movem.l	(sp)+,d2-d7/a2-a6
                rts
