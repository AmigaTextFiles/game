;
;   cop.asm, the copper list mangler for "Wavebench".  Written 15-Oct-87
;   by Bryce Nesbitt.  No copyright claimed.
;
;   This version should assemble under Metacomco V11.0 or the Manx 3.4b
;   assembler.
;
;   Will mangle Intuition's private View every other frame until
;   either the proper signal bits have been changed or something
;   strange happens.
;
;   This program is "dirty", and will not work on upgraded version of
;   the graphics copprocessor.
;
	NOLIST
	INCLUDE "exec/types.i"
	INCLUDE "graphics/gfx.i"
	INCLUDE "graphics/copper.i"
	INCLUDE "graphics/view.i"
jsrlib	MACRO
	jsr  _LVO\1(a6)
	XREF _LVO\1
	ENDM
	LIST

;---------------Size of animation table must be here due to Aztec assembler------
;---------------stupidity.------
maxtable	equ	18  ;Size of table
maxwinkle	equ	18  ;Table offset for start the wave (same as above)
;---------------

rgfxbase	EQUR	a4
rview		EQUR	a5  ;register copy of View
rwsignals	EQUR	d5
inscounter	EQUR	d6
startwinkle	EQUR	d7

		XDEF	_manglecop
_manglecop	movem.l d0-d7/a0-a7,-(a7)
		move.l	16*4+4(a7),rwsignals	   ;wsignals
		move.l	16*4+8(a7),rview	   ;MyViewP
		move.l	16*4+12(a7),rgfxbase	    ;GfxBase

resetwinkle	moveq.l #maxtable+2,startwinkle
keeponwavin	subq.w	#2,startwinkle
		bmi.s	resetwinkle

		move.l	rgfxbase,a6	;get graphics.library
		jsrlib	WaitTOF
		jsrlib	WaitTOF

		move.l	4,a6		;get exec.library
; Using the Forbid() library call is the preferred way of doing this...
; Never use one of those silly macros for Forbid... that will cause
; problems with stuff planned for the future.
;		jsrlib	Forbid		;we ain't 'fraid 'o 'other tasks

		move.l	v_LOFCprList(rview),d1
		beq.s	noLOF
		move.l	startwinkle,d0
		bsr.s	Animatecprlst
noLOF		move.l	v_SHFCprList(rview),d1	;for interlaced screens only
		beq.s	noSOF
		move.l	startwinkle,d0
		bsr.s	Animatecprlst
noSOF	       ;jsrlib	Permit

		moveq.l #0,d0
		moveq.l #0,d1
		jsrlib	SetSignal
		and.l	rwsignals,d0
		beq.s	keeponwavin

;-------------- We're outta here! --------------

signalfound	movem.l (a7)+,d0-d7/a0-a7
		moveq.l #0,d0
		rts

;-----------------------------------------------
; Animatecprlst(cprlist,cell),exec
;		d1	d0    a6
;
;   uses inscounter
;   Call while Forbid()ed!
;   Animate the copper list starting at the specified cell.  Typically
;   this will be called twice on interlace displays, once for each
;   long and short frame cprlist.
;
Animatecprlst	move.l	d1,a0
		move.w	crl_MaxCount(a0),inscounter
		beq.s	bogus
		move.l	crl_start(a0),d1
		beq.s	bogus
		btst.l	#1,d1
		bne.s	bogus
		;Could call TypeOfMem() here...
		move.l	d1,a0

;This the place that animates the actual list.	There are two components
;that we need to worry about.  First comes "move to diwstop".  This register
;defines the physical right edge of the display.  Since we are about to play
;with the horizontal scroll registers this will need to be expanded.  (else
;the wave would get clipped on the left and the right).  Only the diwstop
;nearest the scroll register moves will be affected, and then only if there
;actually are scroll register moves.

;Kludge to make it a little bit faster
		subq.l	#2,a0
finddiwstope	addq.l	#2,a0
		cmp.w	#$0090,(a0)+		;compare with "move to diwstop"
		dbeq	inscounter,finddiwstope ;branch UNTIL equal
		bne.s	endoflist1
		move.l	a0,a1

;Scan for first bplcon1 move and keep track of the most recent move to
;diwstop
finddiwstop	addq.l	#2,a0
		move.w	(a0)+,d1	    ;get the copper instruction
		cmpi.w	#$0090,d1	    ;compare with "move to diwstop"
		bne.s	notdiwstop
		move.l	a0,a1		    ;save pointer for later, a1
notdiwstop	cmp.w	#$0102,d1	    ;compare with "move to bplcon1"
		dbeq	inscounter,finddiwstop	;branch UNTIL equal
		bne.s	endoflist1

; We have found the first move to bplcon1.  Any more that come along will
; be assumed to have come from our user copperlist. (The first one is
; left alone)

findbplcon1e	addq.l	#2,a0
		cmpi.w	#$0102,(a0)+	    ;compare with "move to bplcon1"
		dbeq	inscounter,findbplcon1e
		bne.s	endoflist2

		or.w	#$00ff,(a1)	    ;make screen wider
		move.w	table(pc,d0.w),(a0)
		subq.w	#2,d0
		bpl.s	findbplcon1
		moveq.l #maxtable,d0

; We have found the second move to bplcon1.  Any more that come along will
; be assumed to have come from our user copperlist.

findbplcon1	addq.l	#2,a0
		cmpi.w	#$0102,(a0)+	    ;compare with "move to bplcon1"
		dbeq	inscounter,findbplcon1
		bne.s	endoflist2

		move.w	table(pc,d0.w),(a0)
		subq.w	#2,d0
		bpl.s	findbplcon1
		moveq.l #maxtable,d0
		bra.s	findbplcon1

;---------------Animation data table ----------
table		dc.w	$00,$11,$22,$33,$33,$33,$22,$11,$00,$00,$ff
;If you play with this, be sure to update size equates above!!
;---------------
bogus
endoflist0
endoflist1
endoflist2	rts

		END
