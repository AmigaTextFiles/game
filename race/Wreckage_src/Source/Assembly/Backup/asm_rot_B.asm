;	a0 	&ox
;	a1	&oy
;	a2	&oz
;	a3	&oapp
;	a4	&sincache
;	d0	templong
;	sincache(0)=cvaz*32767
;	sincache(1)=svaz*32767
;	sincache(2)=cvax*32767
;	sincache(3)=svax*32767
;	sincache(4)=cvay*32767
;	sincache(5)=svay*32767


_rot_loop1:

	MOVE.b 	(a3)+	,d1	;oapp
  	BEQ 	_rot_loop_skip	;(oapp=0)=> skip point


;Main Code :)
;--------

	MOVE.w	(a4)	,d6	;get cos
	MOVE.w	2(a4)	,d7	;get sin

  	MOVE.l 	(a0)	,d1	;d1=ox(n)
 	CLR.w 	d1
  	SWAP 	d1

  	MOVE.w 	d1	,d2	;d2=x
  	MULS.w 	d6	,d1	;x*csa

  	MULS.w 	d7	,d2	;x*sna


  	MOVE.l 	(a1)	,d3	;oy(n)
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

  	MOVE.l 	(a2)	,d5	;d2=oz(n)
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



_rot_loop_skip:
	MOVE.l	d1	,(a0)+	;x()
 	MOVE.l	d3	,(a1)+    	;y()
	MOVE.l	d5	,(a2)+	;z()

  	SUBQ.l	#1	,d0	;n=n-1
  	BGT 	_rot_loop1



