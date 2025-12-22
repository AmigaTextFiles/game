		section    code,code
		xdef       _swapshort
		xdef       _swapint

_swapshort
		rol.w      #8,d0
		rts

_swapint
		swap       d0
		rts
