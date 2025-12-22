;=========================================================================
;=========================================================================
;
;	Daleks - locale.library FormatString putCharFunc function
;
;	Copyright 1998 Halibut Software/John Girvin, All Rights Reserved
;
;	This file may not be distributed, reproduced or altered, in full or in
;	part, without written permission from John Girvin. Legal action will be
;	taken in cases where this notice is not obeyed.
;
;=========================================================================
;=========================================================================

	XDEF	@lcputchar

	INCLUDE	INCLUDE:utility/hooks.i

@lcputchar:	move.l	a1,d0	;d0=character
	move.l	h_Data(a0),a1	;a1=string pointer
	move.b	d0,(a1)+
	move.l	a1,h_Data(a0)
	rts
