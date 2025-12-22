		xdef	_hndstub	;this is hndstub()
		xref	_hndcode	;will call hndcode(InputEvent,Data)

_hndstub	movem.l	a0/a1,-(a7)	;stack InputEvent & Data ptrs
		jsr	_hndcode	;jump to actual input handler
		addq.l	#8,a7		;de-stack pointers
		rts			;return (return value is in D0)

		end
