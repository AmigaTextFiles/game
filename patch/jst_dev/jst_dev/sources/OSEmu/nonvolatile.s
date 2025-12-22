* $Id: nonvolatile.s 1.1 1999/02/03 04:10:45 jotd Exp $
**************************************************************************
*   NONVOLATILE-LIBRARY                                                  *
**************************************************************************
**************************************************************************
*   INITIALIZATION                                                       *
**************************************************************************

NONVINIT	move.l	_nonvbase,d0
		beq	.init
		rts

.init		move.l	#162,d0		; reserved function
		move.l	#80,d1		; 20 variables: should be OK
		lea	_nonvname,a0
		bsr	_InitLibrary
		move.l	d0,a0
		move.l	d0,_nonvbase
		
		patch	_LVOGetCopyNV(a0),GETCOPYNV(pc)
		patch	_LVOStoreNV(a0),STORENV(pc)

		rts


GETCOPYNV:
	moveq	#0,D0	; dummy ATM
	rts

;; StoreNV(appName, itemName, data, length, killRequesters)

STORENV:
	moveq	#0,D0	; dummy ATM
	rts
