*
* Macros to define monster animations.
* Needs "monster.i".
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*

	; create variable number of animation phases with constant speed

	macro	ANIM16			; speed, anim-index, ...
	dc.w	\1*(NARG-1)*2
CARG	set	2
	rept	NARG-1
	dcb.w	\1,4*\+
	endr
	; fill unused animation slots with 0
	ds.w	MT_ANIMFRAMES-\1*(NARG-1)
	endm

	macro	ANIM20			; speed, anim-index, ...
	dc.w	\1*(NARG-1)*2
CARG	set	2
	rept	NARG-1
	dcb.w	\1,4*(256+\+)
	endr
	; fill unused animation slots with 0
	ds.w	MT_ANIMFRAMES-\1*(NARG-1)
	endm


	; create variable number of animation phases with variable speed

	macro	ANIM16V			; cnt1, anim-index1, cnt2, ...
	ifne	NARG&1
	fail	"ANIM16V needs an even number of arguments!"
	endc
	dc.w	(anim\@end-anim\@start)/2
anim\@start:
	rept	NARG/2
	dcb.w	\+,4*\+
	endr
anim\@end:
	; fill unused animation slots with 0
	ds.w	MT_ANIMFRAMES-(anim\@end-anim\@start)/2
	endm

	macro	ANIM20V			; cnt1, anim-index1, cnt2, ...
	ifne	NARG&1
	fail	"ANIM20V needs an even number of arguments!"
	endc
	dc.w	(anim\@end-anim\@start)/2
anim\@start:
	rept	NARG/2
	dcb.w	\+,4*(256+\+)
	endr
anim\@end:
	; fill unused animation slots with 0
	ds.w	MT_ANIMFRAMES-(anim\@end-anim\@start)/2
	endm
