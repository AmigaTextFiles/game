* $Id: keymap.s 1.1 1999/02/03 04:08:28 jotd Exp $


**************************************************************************
*   keymap-LIBRARY                                                    *
**************************************************************************
**************************************************************************
*   INITIALIZATION                                                       *
**************************************************************************

KEYMINIT	move.l	_keymbase,d0
		beq	.init
		rts

.init		move.l	#162,d0		; reserved function
		move.l	#80,d1		; 20 variables: should be OK
		lea	_keymname,a0
		bsr	_InitLibrary
		move.l	d0,a0
		move.l	d0,_keymbase
		
;;		patch	_LVOGetLanguageSelection(a0),GETLANGSEL(pc)
		rts

