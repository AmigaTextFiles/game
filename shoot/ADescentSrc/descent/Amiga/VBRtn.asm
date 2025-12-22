

*********************************************************
*                                                       *
* Copyright (c) 1989, David Kinzer, All Rights Reserved *
*                                                       *
* Permission hereby granted to redistribute this        *
* program in unmodified form in a not for profit manner.*
*                                                       *
* Permission hereby granted to use this software freely *
* in programs, commercial or not.                       *
*                                                       *
*********************************************************
*                                                       *
* VBRtn.a                                               *
*                                                       *
* Vertical Blanking Routine for analog joystick support.*
* This routine reads the joyport hardware during every  *
* vertical blanking interrupt and stores the joystick   *
* data for use by the read routine.                     *
*                                                       *
*********************************************************



* The ordering of the buttons is sortof taken from the
* RKM hardware manual (buttons 3 and 4 are not defined
* there) 
*
* when reading from the joyport it is  xxxxxx13xxxxxx24
* where 1 & 2 are obtained directly, 3 is obtained by 1
* eor 3, and 4 is obtained by 2 eor 4.
*
*

* Lattice (tm) users need to remove the comment asterisk
* from the following line to make the assembler happy

	   csect   text


regbase equ     $DFF000
joy0dat equ     $00A
pot0dat equ     $012
joy1dat equ     $00C
pot1dat equ     $014

WritePotgo equ -$12


o_U0X       equ     $0          offsets for data passing
o_U0Y       equ     $2           structure
o_U0b1      equ     $4
o_U0b2      equ     $5
o_U0b3      equ     $6
o_U0b4      equ     $7
o_U0eb1     equ     $8
o_U0eb2     equ     $9
o_U0eb3     equ     $a
o_U0eb4     equ     $b

o_U1X       equ     $c
o_U1Y       equ     $e
o_U1b1      equ     $10
o_U1b2      equ     $11
o_U1b3      equ     $12
o_U1b4      equ     $13
o_U1eb1     equ     $14
o_U1eb2     equ     $15
o_U1eb3     equ     $16
o_U1eb4     equ     $17

o_Potbase   equ     $18 
o_flags     equ     $1c



   xdef     _vbserver

* We rely on the data area being pointed to by A1 upon
* entry, which the exec does for us.
*
* We can consider D0, D1, A0, A1, A4, A5 and A6 scratch

_vbserver:


	move.l  #regbase,A0         A0 points to hardware base

	btst    #0,o_flags+3(A1)    see if unit 0 open
*                                (btst works on bytes)
	beq     u1                  branch if not

	move.w  pot0dat(A0),D0      save pot data
	move.w  D0,D1
	asl.w   #8,D0
	move.w  D0,o_U0X(A1)
	and.w   #$FF00,D1
	move.w  D1,o_U0Y(A1)

	move.w  joy0dat(A0),D1      get joystick button
*                                positions

	move.b  o_U0b1(A1),D0       do button 1
*                                save previous state
	btst    #9,D1               test to see if pressed
	sne     o_U0b1(A1)          set or clear data element
*                                based on position
	beq.s   u0t1                if not pressed we are done
	tst.b   D0                  was it pressed before?
	bne.s   u0t1                yes, branch
	st      o_U0eb1(A1)         just pressed, set flag
*                                indicating button pressed
u0t1
	move.b  o_U0b2(A1),D0       do button 2
	btst    #2,D1
	sne     o_U0b2(A1)
	beq.s   u0t2
	tst.b   D0
	bne.s   u0t2
	st      o_U0eb2(A1)
u0t2
* The fastest way to do the exclusive or in this case is
* to add 1 to the least significant bit.  If that bit is
* a 1, there will be a carry into the next position.  If
* so, and the next position is a zero, the result will be
* a one.  If the next position is a one, the result is a
* zero.  Obscure, but fast.  Note that this renders all
* other bits useless.  We use a byte add here to prevent
* ruining the button 2 and 4 data in the upper byte.
	add.b   #1,D1               do button 3
	move.b  o_U0b3(A1),D0       
	btst    #1,D1
	sne     o_U0b3(A1)
	beq.s   u0t3
	tst.b   D0
	bne.s   u0t3
	st      o_U0eb3(A1)
u0t3
	add.w   #$100,D1            do button 4
	move.b  o_U0b4(A1),D0       (same eor scheme used)
	btst    #9,D1
	sne     o_U0b4(A1)
	beq.s   u0t4
	tst.b   D0
	bne.s   u0t4
	st      o_U0eb4(A1)
u0t4



u1
	btst    #1,o_flags+3(A1)    see if unit 1 open
	beq     restart

	move.w  pot1dat(A0),D0      save pot data
	move.w  D0,D1
	asl.w   #8,D0
	move.w  D0,o_U1X(A1)
	and.w   #$FF00,D1
	move.w  D1,o_U1Y(A1)

	move.w  joy1dat(A0),D1      get joystick button
*                                positions

	move.b  o_U1b1(A1),D0       do button 1
	btst    #9,D1
	sne     o_U1b1(A1)
	beq.s   u1t1
	tst.b   D0
	bne.s   u1t1
	st      o_U1eb1(A1)
u1t1
	move.b  o_U1b2(A1),D0       do button 2
	btst    #1,D1
	sne     o_U1b2(A1)
	beq.s   u1t2
	tst.b   D0
	bne.s   u1t2
	st      o_U1eb2(A1)
u1t2
	add.b   #1,D1
	move.b  o_U1b4(A1),D0       do button 4
	btst    #1,D1
	sne     o_U1b4(A1)
	beq.s   u1t4
	tst.b   D0
	bne.s   u1t4
	st      o_U1eb4(A1)
u1t4
	add.w   #$100,D1            do button 3
	move.b  o_U1b3(A1),D0       
	btst    #9,D1
	sne     o_U1b3(A1)
	beq.s   u1t3
	tst.b   D0
	bne.s   u1t3
	st      o_U1eb3(A1)
u1t3
restart
	move.l  #1,D0
	move.l  D0,D1
	move.l  o_Potbase(A1),A6        Call WritePotgo
	jsr     WritePotgo(A6)
	move.l  #0,D0
	rts

	end

* End: VBRtn.a
