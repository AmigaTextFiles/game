;	a0 	&ox
;	a1	&oy
;	a2	&oz
;	a3	&oapp
;	a4	&sincache
;	d0	templong
;	sincache(0)=cvaz*32767;0
;	sincache(1)=svaz*32767;2
;	sincache(2)=cvax*32767;4
;	sincache(3)=svax*32767;6
;	sincache(4)=cvay*32767;8
;	sincache(5)=svay*32767;10

		;A5-A7 MUST NOT BE TRASHED!!!

	MOVE.l	a6	,-(a7)	;PUSH a5
	MOVE.l	d1	,a6	;load new value

_rot_loop1:

	MOVE.b 	(a3)+	,d1	;oapp
  	BEQ 	_hide_point2	;(oapp=0)=> skip point


;Main Code :)
;--------

	MOVE.w	(a4)	,d6	;get cos
	MOVE.w	2(a4)	,d7	;get sin

  	MOVE.l 	(a0)+	,d1	;d1=ox(n)
 	CLR.w 	d1
  	SWAP 	d1

  	MOVE.w 	d1	,d2	;d2=x
  	MULS.w 	d6	,d1	;x*csa

  	MULS.w 	d7	,d2	;x*sna


  	MOVE.l 	(a1)+	,d3	;oy(n)
  	CLR.w 	d3
  	SWAP 	d3

  	MOVE.w 	d3	,d4	;y

  	MULS.w 	d7	,d3	;y*sna
  	SUB.l 	d3	,d1	;x*csa-y*sna

  	MULS.w 	d6	,d4	;y*csa
  	ADD.l 	d2	,d4	;y*csa+x*sna



	;d4 holds Y
	;d1 holds X


_rot_loop2:
;      yy=y*cvax-z*svax	
;      zz=z*cvax+y*svax

	MOVE.w	4(a4)	,d6	;get cos
	MOVE.w	6(a4)	,d7	;get sin

  	MOVE.l 	(a2)+	,d5	;d2=oz(n)
 	CLR.w 	d5
  	SWAP 	d5

  	MOVE.w 	d5	,d2	;d2=z

  	MULS.w 	d6	,d5	;z*csa
  	MULS.w 	d7	,d2	;z*sna

	CLR.w	d4
	SWAP	d4
  	MOVE.w 	d4	,d3	;y is still here
				;   <grin>

  	MULS.w 	d6	,d3	;y*csa
  	SUB.l 	d2	,d3	;yy=y*csa-z*sna

  	MULS.w 	d7	,d4	;y*sna
  	ADD.l 	d5	,d4	;zz=z*csa+y*sna

;	X	D1
;	Z	D4
;	Y	D3 (do not trash)
;		-----------------

_rot_loop3:
;      xx=x*cvay-z*svay
;      zz=z*cvay+x*svay

	MOVE.w	8(a4)	,d6	;get cos
	MOVE.w	10(a4)	,d7	;get sin

	CLR.W	d4
	SWAP	d4
  	MOVE.w 	d4	,d2	;d2=z (yes, it is still here)

  	MULS.w 	d6	,d4	;z*csa
  	MULS.w 	d7	,d2	;z*sna

	CLR.w	d1
	SWAP	d1

  	MOVE.w 	d1	,d5	;x is still here				;   (I hope)
  	MULS.w 	d6	,d1	;x*csa
  	SUB.l 	d2	,d1	;xx=x*csa-z*sna

  	MULS.w 	d7	,d5	;x*sna
  	ADD.l 	d4	,d5	;zz=z*csa+x*sna

;	X	D1
;	Y	D3
;	Z	D5


;	And do the 2d->3d Projection


	CLR.w	d3		;d3 IS a longword..
	SWAP	d3		;but I am shifting it twice..
	EXT.l	d3	;yeah
	ADDI.l	#6,d3
	TST.l 	d3
	BLE 	_hide_point
	
	MOVE.w	12(a4)	,d2
	DIVS.l	d3	,d1	;this is x
	ASR.l	#6	,d1
	ASR.l	d2	,d1
	ADD.w	#320	,d1

	DIVS.l	d3	,d5	;and this is z
	ASR.l	#6	,d5
	ASR.l	d2	,d5
	ADD.l	#160	,d5

	MOVE.w	#1	,d7	;display point!!
	BRA	_loop_ending
	
		
_hide_point2:
	ADDQ.l	#4	,a0
	ADDQ.l	#4	,a1
	ADDQ.l	#4	,a2

_hide_point:
	CLR.w d7


_loop_ending:
	MOVE.w 	d1	,(a6)+	;sx
 	MOVE.w 	d5	,(a6)+    	;sy
  	MOVE.w 	d7	,(a6)+    	;app

  	SUBQ.l	#1	,d0	;n=n-1
  	BGT 	_rot_loop1


	MOVE.l	(a7)+	,a6	;POP A5
