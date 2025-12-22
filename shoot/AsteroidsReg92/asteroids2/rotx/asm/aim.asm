;
;     my first fucking assembly code
;
;		d0 dx
;       d1 dy
;       a0 dxdy
;		a1 dydx
;

	xdef		_determineaim

	section code

_determineaim:

	cmp.L		#0,d0
	blt xltzero					; is x less than zero ?
	cmp.L		#0,d1
	blt xgyl					; x is greater and y is less
	bra xgyg					; else x and y are greater than zero 

xltzero:
	cmp.L		#0,d1
	blt xlyl					; x and y are less than zero
	bra xlyg					; x is less and y is greater than zero


xgyl:
	move.L		#0,d0
	bra usedxdy
xgyg:
	move.L		#8,d0
	bra usedydx
xlyg:
	move.L		#16,d0
	bra usedxdy
xlyl:
	move.L		#24,d0
	bra usedydx


usedxdy:
	cmp.L		#101,a0
	bgt addeight
	cmp.L		 #33,a0
	bgt addseven
	cmp.L		 #19,a0
	bgt addsix
	cmp.L		 #12,a0
	bgt addfive
	cmp.L		  #8,a0
	bgt addfour
	cmp.L		  #5,a0
	bgt addthree
	cmp.L		  #3,a0
	bgt addtwo
	cmp.L		  #1,a0
	bgt addone
	rts

usedydx:
	cmp.L		#101,a1
	bgt addeight
	cmp.L		 #33,a1
	bgt addseven
	cmp.L		 #19,a1
	bgt addsix
	cmp.L		 #12,a1
	bgt addfive
	cmp.L		  #8,a1
	bgt addfour
	cmp.L		  #5,a1
	bgt addthree
	cmp.L		  #3,a1
	bgt addtwo
	cmp.L		  #1,a1
	bgt addone
	rts


addeight:
	add.L		#1,d0
addseven:
	add.L		#1,d0
addsix:
	add.L		#1,d0
addfive:
	add.L		#1,d0
addfour:
	add.L		#1,d0
addthree:
	add.L		#1,d0
addtwo:
	add.L		#1,d0
addone:
	add.L		#1,d0

	rts

	END