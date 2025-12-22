* Breakout FAST functions.

        SECTION BREAKOUTMain

* In A0: het begin van de ptr-bank.
* in D0: De aangeroepen functie.

	cmp #1,d0
	beq _WALL
	cmp #2,d0
	beq _BOUNCE
	cmp #3,d0
	beq _LASER
	cmp #4,d0
	beq _MOVEB
	cmp #5,d0
	beq _DMOVE
	bra _ENDIT

* Begin of Wall-Collision code.

_WALL   move.l a0,a2 	* Backup from the original pointer.
	move.l (a0),a1
	move.l (a1),d4 
	move.l 8(a0),a1	* note the 8. This is the no of bytes to add to a0.
	move.l (a1),d5
* The above bit copied the contents of the variable rx,ry into d4,d5.
* Note the pointer-mechanism. A0 points to an addres, wich points to RX.
* etc.
	moveq #11,d2
        move.l #185,d3
        moveq #5,d6
        clr.l d7
        cmp d4,d2
        ble _CWALL
        moveq #1,d7
        move.l d2,d4
        bra _WENDIT
_CWALL  cmp d4,d3
        bge _CWALL2
        moveq #1,d7
        move.l d3,d4
        bra _WENDIT
_CWALL2 cmp d5,d6
        ble _WENDIT
        moveq #2,d7
        move.l d6,d5
        bra _WENDIT      

* Exit code as used by the wall-collision routine.

_WENDIT move.l (a2),a1
	move.l d4,(a1) 		* The variable rx.
	move.l 8(a2),a1 	* 8 bytes from a2.
	move.l d5,(a1)		* The variable ry.
	move.l 16(a2),a1 	* 16 bytes from a2.
	move.l d7,(a1) 		* The bounce direction.
	bra _ENDIT
* This routine sets the rx,ry variables to their new value (if any).

* Here follows the bounce routine, _BOUNCE.

_BOUNCE	move.l (a0),a1	* Get the adress of rx ( start(9) + 0 ).
	move.l (a1),d1	* d1 now contains the content of the pointer.
	move.l 8(a0),a1	* get the adress of ry ( start(9) + 8 ).
	move.l (a1),d2	* d2 now contains the content of the pointer.
	move.l d1,d5	* cx_current is equal to rx/xg, so form it.
	move.l #12,d3	* d3 is equal to 12. ( xg )
	divu d3,d5	* divide rx by xg, storing into cx_current.
	move.w d5,d7	* Remove the remainder, if any.
	move.l d7,d5	* See above.
	move.l d2,d6	* cy_current is equal to ry/yg, so form it.
	move.l #6,d3	* d3 is equal to 6. ( yg )
	divu d3,d6	* divide ry by yg, storing into cy_current.
	move.w d6,d7	* Remove the remainder, if any.
	move.l d7,d6	* See above.

* 	Now that we have cx_curent and cy_current, we
*	check is bouncing is nessecary.

	move.l #16,d7	* The comparisom number.
	cmp d5,d7	* CX may not be larger than 31.
	blt _ENDIT	* CX is larger than 31.
	move.l #32,d7	* The comparisom number.
	cmp d6,d7	* CY may not be larger than 15.
	blt _ENDIT	* CY is larger than 15.

	move.l 24(a0),a1	* Get adress of obj(0,0,0) (start(9)+24)
	
*	Now for the complex bit: the adress pointing to
*	obj(cx_current,cy_current,0) is equal to:
*	a1 + ( cx_current * 660 ) + ( cy_current * 20 ) + 0.
*	so we put cx_current * 660 into d1,
*		  cy_current * 20 into d2,
*	and add the bunch to a1.
*	Then we can check it's content with cmp (a1),#0 etc..

	move.l d5,d1	* Put cx_current into d1.
	move.l #660,d7	* d7 contains the required number: 660.
	mulu.l d7,d1	* multiply cx_current with 660.
	move.l d6,d2	* Put cy_current into d2.
	move.l #20,d7	* d7 contains the required number: 20.
	mulu.l d7,d2	* multiply cy_current with 20.
	adda d1,a1	* Add d1 to a1.
	adda d2,a1	* Add d2 to a1. Now we have the complete adress.
	move.l (a1),d7	* Form the comparisom number.
	cmp #0,d7	* Check if a brick is present at cx,cy.
	beq _ENDIT	* If it's true, then there is no brick.

* 	Now create the following: d1 = brickstart_x,
*				  d2 = brickend_x,
*				  d3 = brickstart_y,
*				  d4 = brickend_y.
*	This is order to check wich direction to bounce.
	move.l d5,d1	* Start forming brickstart_x.
	move.l #12,d7	* d7 contains the required multiple, 12.
	mulu d7,d1	* d1 now contains brickstart_x.
	move.l d6,d3	* Start forming brickstart_y.
	move.l #6,d7	* d7 contains the required multiple, 6.
	mulu d7,d3	* d3 now contains brickstart_y.
	move.l d1,d2	* Start forming brickend_x.
	add.l #11,d2	* d2 now contains brickend_x.
	move.l d3,d4	* Start forming brickend_y.
	addq #5,d4	* d4 now contains brickend_y.

*	Do the first check, wich is:
*	if ( rx>brickstart_x and rx<brickend_x) and 
*	(ry=brickstart_y or ry=brickstart_y+1)
*	bounce = 2 : ty = brickstart_y-1 : exit.
*	Variables:
*	d1 = brickstart_x.
*	d2 = brickend_x.
*	d3 = brickstart_y.
*	d4 = brickend_y.
*	d5 = rx. d6=ry.
*	Na de if:
*	d5 = ty. d6=bounce.
*	Stuur de inhoud van d5-d6 naar de juiste adressen.
*	Note: de andere checks zijn min of meer het zelfde.
*	      slechts met andere variabelen.

	move.l (a0),a1	* Start(9) content. ofwel: adress van rx.
	move.l (a1),d5	* d5 now contains rx.
	move.l 8(a0),a1	* Start(9)+8 content. Ofwel adress van ry.
	move.l (a1),d6	* d6 now contains ry.
	cmp d5,d1	* If rx>brickstart_x
	bge _BNO2	* Als niet, dan volgende.
	cmp d5,d2	* If rx<brickend_x
	ble _BNO2	* Als niet, dan volgende.
	cmp d6,d3	* if ry=brickstart_y
	beq _BCONT1	* Als waar, ga dan verder.
	move.l d3,d7	* in d7 wordt brickstart_y+1 gemaakt.
	addq #1,d7	* d7 now contains brickstart_y+1.
	cmp d6,d7	* if ry=brickstart_y+1
	bne _BNO2	* Als dit niet waar is, ga dan naar de volgende.
_BCONT1	move.l d3,d5	* Start forming ty.
	subq #1,d5	* TY (d5) now contains brickstart_y-1
	moveq #2,d6	* BOUNCE (d6) now contains 2.
	move.l 16(a0),a1	* Get the adress of bounce. (start(9)+16)
	move.l d6,(a1)		* Store bounce into its adress.
	move.l 40(a0),a1	* Get the adress of TY. (start(9)+40)
	move.l d5,(a1)		* Store bounce into its adress.
	bra _ENDIT
_BNO2	move.l (a0),a1	* Start(9) content. ofwel: adress van rx.
	move.l (a1),d5	* d5 now contains rx.
	move.l 8(a0),a1	* Start(9)+8 content. Ofwel adress van ry.
	move.l (a1),d6	* d6 now contains ry.
	cmp d5,d1	* If rx>brickstart_x
	bge _BNO3	* Als niet, dan volgende.
	cmp d5,d2	* If rx<brickend_x
	ble _BNO3	* Als niet, dan volgende.
	cmp d6,d4	* if ry=brickend_y
	beq _BCONT2	* Als waar, ga dan verder.
	move.l d4,d7	* in d7 wordt brickend_y-1 gemaakt.
	subq #1,d7	* d7 now contains brickend_y-1.
	cmp d6,d7	* if ry=brickend_y-1
	bne _BNO3	* Als dit niet waar is, ga dan naar de volgende.
_BCONT2	move.l d4,d5	* Start forming ty.
	addq #1,d5	* TY (d5) now contains brickend_y+1
	moveq #2,d6	* BOUNCE (d6) now contains 2.
	move.l 16(a0),a1	* Get the adress of bounce. (start(9)+16)
	move.l d6,(a1)		* Store bounce into its adress.
	move.l 40(a0),a1	* Get the adress of TY. (start(9)+40)
	move.l d5,(a1)		* Store bounce into its adress.
	bra _ENDIT
_BNO3	move.l (a0),a1	* Start(9) content. ofwel: adress van rx.
	move.l (a1),d5	* d5 now contains rx.
	move.l 8(a0),a1	* Start(9)+8 content. Ofwel adress van ry.
	move.l (a1),d6	* d6 now contains ry.
	cmp d6,d3	* If ry>brickstart_y
	bge _BNO4	* Als niet, dan volgende.
	cmp d6,d4	* If ry<brickend_y
	ble _BNO4	* Als niet, dan volgende.
	cmp d5,d1	* if rx=brickstart_x
	beq _BCONT3	* Als waar, ga dan verder.
	move.l d1,d7	* in d7 wordt brickstart_x+1 gemaakt.
	addq #1,d7	* d7 now contains brickstart_x+1.
	cmp d5,d7	* if rx=brickstart_x+1
	bne _BNO4	* Als dit niet waar is, ga dan naar de volgende.
_BCONT3	move.l d1,d5	* Start forming tx.
	subq #1,d5	* TX (d5) now contains brickstart_x-1
	moveq #1,d6	* BOUNCE (d6) now contains 1.
	move.l 16(a0),a1	* Get the adress of bounce. (start(9)+16)
	move.l d6,(a1)		* Store bounce into its adress.
	move.l 32(a0),a1	* Get the adress of TX. (start(9)+32)
	move.l d5,(a1)		* Store bounce into its adress.
	bra _ENDIT
_BNO4	move.l (a0),a1	* Start(9) content. ofwel: adress van rx.
	move.l (a1),d5	* d5 now contains rx.
	move.l 8(a0),a1	* Start(9)+8 content. Ofwel adress van ry.
	move.l (a1),d6	* d6 now contains ry.
	cmp d6,d3	* If ry>brickstart_y
	bge _BNO5	* Als niet, dan volgende.
	cmp d6,d4	* If ry<brickend_y
	ble _BNO5	* Als niet, dan volgende.
	cmp d5,d2	* if rx=brickend_x
	beq _BCONT4	* Als waar, ga dan verder.
	move.l d2,d7	* in d7 wordt brickend_x-1 gemaakt.
	subq #1,d7	* d7 now contains brickstart_x-1.
	cmp d5,d7	* if rx=brickstart_x-1
	bne _BNO5	* Als dit niet waar is, ga dan naar de volgende.
_BCONT4	move.l d2,d5	* Start forming tx.
	addq #1,d5	* TX (d5) now contains brickend_x+1
	moveq #1,d6	* BOUNCE (d6) now contains 1.
	move.l 16(a0),a1	* Get the adress of bounce. (start(9)+16)
	move.l d6,(a1)		* Store bounce into its adress.
	move.l 32(a0),a1	* Get the adress of TX. (start(9)+32)
	move.l d5,(a1)		* Store bounce into its adress.
	bra _ENDIT
_BNO5	moveq #3,d6		* BOUNCE (d6) now contains 3.
	move.l 16(a0),a1	* Get the adress of bounce. (start(9)+16)
	move.l d6,(a1)		* Store bounce into its adress.
	bra _ENDIT

_LASER	move.l 24(a0),a1	* Get the adress of obj(0,0,0)
	move.l 96(a0),a2	* Get the adress of bricks(0,0)
	move.l 80(a0),a3	* Get the adress of XP.
	move.l (a3),d1		* Get XP into d1.
	move.l 88(a0),a3	* Get the adress of XSIZE.
	move.l (a3),d2		* Get XSIZE into d2.
	clr.l  d0		* Clear Bcounter (=d0).

* Hier wordt MI_X berekent aan de hand van d1 (XP) en d2 ( XSIZE )
* Formule:
* 	  MI_X = ( XP + ( XSIZE/2 ) - 25 ) / XG ( XG = 12 )
*         d3   = ( d1 + ( d2 / 2 ) - 25 ) / 12

	move.l d2,d3		* Put XSIZE into D3 ( MI_X )
	move.l #2,d4		* Register shift 1 is divide by 2.
	divu   d4,d3		* Shift right for divide by 2.
	move.w d3,d4		* Remove the remainder (if any)
	move.l d4,d3		* Move result back into d3.
	add.l  d1,d3		* add XP to XSIZE ( d1,d3 ).
	subi   #25,d3		* subtract 25 from result ( d3).
	bpl    _LGOOD		* If >0, continue.
	move.l #0,d3		* Else, d3 = 0.	
_LGOOD	move.l d3,d7		* Move result into d7 for MA_X
	move.l #12,d4		* Set the divider to 12.
	divu   d4,d3		* divide d3 by d4.
	move.w d3,d4		* Remove the remainder (if any)
	move.l d4,d1		* Move result into d1. (MI_X)

* Hier wordt MA_X berekent aan de hand van d1 (XP) en d2 ( XSIZE )
* Formule:
* 	  MA_X = ( XP + ( XSIZE/2 ) + 25 ) / XG ( XG = 12 )
*         d3   = ( d1 + ( d2 / 2 ) + 25 ) / 12

	move.l #50,d4		* Set add bit to 50.
	add.l  d4,d7		* Add 50 to Result (XP+(XSIZE/2)-25)
	cmp    #194,d7		* Compare to 159.
	ble    _LGOOD2		* If so, it's ok.
	move.l #194,d7		* Else, set d7 at 159.
_LGOOD2	move.l #12,d4		* Set the divider to 12.
	divu   d4,d7		* divide d3 by d4.
	move.w d7,d4		* Remove the remainder (if any)
	move.l d4,d2		* Move result into d2. (MA_X)

* Maak een dubbelle loop om het array te vullen:
* for x = mi_x to ma_x
*   for y = 0 to 31
*     DO_STUFF
*   next
* next

	move.l d1,d3		* X-loop init at MI_X ( d3=x , d1=MI_X )
_XLOOP  cmp d2,d3		* Compare MA_X with d3 ( x )
	bgt _ENDXL		* If x is larger, branch to end x_loop.
	move.l #0,d4		* Y-loop init at 0 ( d4= y )
_YLOOP	move.l #31,d5		* Compare set at 31 ( d5 )
	cmp d5,d4		* Compare 31 with d4 ( y )
	bgt _ENDYL		* If y is larger, branch to end y_loop.
	bsr _LARRF		* Execute subroutine Laser Array Fill.
	addq #1,d4		* Add one to d4 (y) for the looping.
	bra _YLOOP		* Branch to begin YLOOP. (next)
_ENDYL	addq #1,d3		* Add one to d3 (x) for the looping.
	move.l #0,d4		* Reset d4 (y) for the loop.
	bra _XLOOP		* Branch to begin XLOOP. (next)
_ENDXL	move.l d0,d7		* Test!	
	bra _ENDIT		* All Done.

*	Now for the complex bit: the adress pointing to
*	obj(bx,by,0) is equal to:
*	a1 + ( bx * 660 ) + ( by * 20 ) + 0.
*	so we put bx * 660 into d5,
*		  by * 20 into d6,
*	and add the bunch to a1.
*	Then we can check it's content with cmp (a1),#0 etc..
*
*	Now for the complex bit (2) : the adress pointing to
*	bricks(bcounter,0) is equal to:
*	a2 + ( bcounter * 12 ) + 0.
*	so we put bcounter * 12  into d5,
*	and add the bunch to a2.
*	Then we can check it's content with cmp (a2),#0 etc..

_LARRF	move.l a1,a3	* Make backup for usage.	
	move.l d3,d5	* Put bx into d5.
	move.l #660,d7	* d7 contains the required number: 660.
	mulu.l d7,d5	* multiply bx with 660.
	move.l d4,d6	* Put by into d6.
	move.l #20,d7	* d7 contains the required number: 20.
	mulu.l d7,d6	* multiply by with 20.
	adda d5,a3	* Add d5 to a1.
	adda d6,a3	* Add d6 to a1. Now we have the complete adress.
	move.l (a3),d7	* Form the comparisom number.
	cmp #0,d7	* Check if a brick is present at bx,by.
	beq _LEND	* If it's true, then there is no brick.
	move.l a1,a3	* Make backup for usage.	
	move.l d3,d5	* Put bx into d5.
	move.l #660,d7	* d7 contains the required number: 660.
	mulu.l d7,d5	* multiply bx with 660.
	move.l d4,d6	* Put by into d6.
	move.l #20,d7	* d7 contains the required number: 20.
	mulu.l d7,d6	* multiply by with 20.
	adda d5,a3	* Add d5 to a3.
	adda d6,a3	* Add d6 to a3.
	moveq #8,d7	* d7 Contains the required add: 8.
	adda d7,a3	* Add d7 to a3. Now we have the complete adress.
	move.l (a3),d7	* Form the comparisom number.
	cmp #-1,d7	* Check if a valid brick is present at bx,by.
	beq _LEND	* if it is -1, the brick is invalid.

* Now fill the bricks array, using the method described above.

	move.l a2,a3	* Make backup for usage.	
	move.l d0,d5	* Put bcounter into d5.
	move.l #12,d7	* d7 contains the required number: 12.
	mulu.l d7,d5	* multiply bcounter with 12.
	adda d5,a3	* Add d5 to a3. Now we have the complete adress.
	move.l #0,d7	* The bit to put into bricks(bcounter,0)
	move.l #4,d6	* The bit to add to the adress (a3).
	move.l d7,(a3)	* Move it into bricks(bcounter,0)
	adda d6,a3
	move.l d3,(a3)  * Move bx into bricks(bcounter,1)
	adda d6,a3
	move.l d4,(a3)  * Move by into bricks(bcounter,2)
	addq #1,d0	* Add one to bcounter.
_LEND	rts

_MOVEB	bra _ENDIT

*   XCN=XCN+1 : YCN=YCN+1
*   If(XCN<XSP and YCN<YSP) Then Pop Proc : Rem This should save some time.
*   If XCN=>XSP Then RX=RX+X : XCN=0
*   If YCN=>YSP Then RY=RY+Y : YCN=0
*   If TX<>False Then Goto TXCHK : Rem This should save some time.  
*   If TY<>False Then Goto TYCHK : Rem This should save some time.
*   Rem Check for any collisions with the walls. 
*   Dreg(0)=1 : Areg(0)=Start(9) : Rem This should work.. 
*   Call 7
*   Rem No more calls to Dreg() are nessecary..
*   If BOUNCE<>0 Then SPLAY[3]
*   If RY=>249 and(BOUND=False and PROTECT=False)
*      DIE=True
*      Pop Proc
*   Else 
*      If RY=>249
*         BOUNCE=2
*      End If 
*   End If 
*   Rem check for the paddle.
*   If RY=>YPM Then PADDLE_BOUNCE
*   If BOUNCE=0 Then BOUNCE[RX,RY]
*   If BOUNCE=1 Then X=-X : XCN=XSP-1 : Pop Proc
*   If BOUNCE=2 Then Y=-Y : YCN=YSP-1 : Pop Proc
*   If BOUNCE=3 Then X=-X : Y=-Y : XCN=XSP-1 : YCN=YSP-1 : Pop Proc
*   Pop Proc
*   TXCHK:
*   If RX=TX Then TX=False : Pop Proc
*   If TX-RX>0 Then X=AX Else X=-AX
*   Pop Proc
*   TYCHK:
*   If RY=TY Then TY=False : Pop Proc
*   If TY-RY>0 Then Y=AY Else Y=-AY
*   Pop Proc

_DMOVE  bra _ENDIT

*   If XDOB=0 Then XBL1=XP+(XSIZE4)-2 : XBL2=XP+(XSIZE-(XSIZE4))
*   If XDOB=1 Then XBL1=XP+(XSIZE-(XSIZE4)) : XBL2=XP+XSIZE
*   If XDOB=-1 Then XBL1=XP-2 : XBL2=XP+(XSIZE4)-2
*   If RX-1>XBL1 Then XP=XP+PSTEP
*   If RX+1<XBL2 Then XP=XP-PSTEP
*   If XP>(179-15) Then XP=(179-15)
*   If XP<6 Then XP=6
*   If STICKY=True or STICKY=1 Then STICKY=False

_ENDIT  move.l #0,a1
	move.l #0,a2
	move.l #0,a3
	move.l #0,a4
	move.l #0,a5
        rts

	END
