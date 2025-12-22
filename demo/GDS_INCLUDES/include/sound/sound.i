;***************************************************************
; Sound struct
;***************************************************************

	rsreset
SND_DATA	rs.l	1	;ptr to sound data
SND_LOOP	rs.l	1	;ptr to loop portion of sound data (echo)
SND_LENGTH rs.l	1	;length of sound data (in 16 bit words)
SND_REPEAT rs.w	1	;number of times to play sample
SND_COUNT	rs.w	1	;running total of number of times sample played
SND_PERIOD rs.w	1	;tone of sound or note value
SND_VOLUME rs.w	1	;volume to play sample (0 - 64)
SND_TYPE 	rs.w	1	;sample type (see below)
SND_FLAGS	rs.w	1	;sample flags (see below)
SND_VOLFADE rs.w	1	;volume fade value (0 for no fade)
SND_VOLCNT rs.w	1	;number VB interrupts before volume decrement, or 0
;			 for fade only after every play of sample
SND_PERFADE rs.w	1	;period fade value (0 for no fade)
SND_PERCNT rs.w	1	;number of VB interrupts before period decrement, of 0
;			 for fade only after every play of sample
SND_SIZEOF	rs.b	0	;size of sound struct

; The sound types:

SND_TYPE_EFX  EQU	3	;only supported sound type as yet

* ---------------------------------------------------------------------------
*
* The sound flags:
* ---------------

SND_FAST	EQU	1	;sound data resides in fast RAM

; Sound channel values

CHANNEL0	EQU	1	;sound channel 0
CHANNEL1	EQU	2	;sound channel 1
CHANNEL2	EQU	4	;sound channel 2
CHANNEL3	EQU	8	;sound channel 3
