			OPT		C+,L+,S-,Y+
			
			INCDIR	"DevpacAm:include/"
			
			INCLUDE	"devices/inputevent.i"
			
			INCLUDE	"exec.offsets"
			
ExecBase	=		4
			
			XREF	_IntuitionBase
			XREF	_LinkerDB
			XREF	_Common
			
			XDEF	_MHandler
			
			
			IDNT	handler.a
			SECTION	handler,CODE

			
SinTab		DC.B	0,5,10,14,18,21,23,25
			DC.B	25,25,23,21,18,14,10,5
			DC.B	0,-5,-10,-14,-18,-21,-23,-25
			DC.B	-25,-25,-23,-21,-18,-14,-10,-5
			
xAngle		DS.W	1
yAngle		DS.W	1
xDev		DS.B	1
yDev		DS.B	1
			
			
_MHandler	MOVE.L	A0,D0
			
.Again		CMP.B	#IECLASS_RAWMOUSE,ie_Class(A0)
			BNE.B	.NotMouse
			
			MOVE.W	D0,-(SP)
			LEA		xAngle(PC),A1
			
			MOVE.W	ie_X(A0),D0
			ADD.W	(A1),D0
			AND.W	#$FF,D0
			MOVE.W	D0,(A1)
			
			LSR.W	#3,D0
			MOVE.B	SinTab(PC,D0.W),D1
			MOVE.B	4(A1),D0
			MOVE.B	D1,4(A1)
			SUB.B	D0,D1
			
			EXT.W	D1
			
			MOVE.W	ie_Y(A0),D0
			ADD.W	D1,ie_Y(A0)
			
			ADD.W	2(A1),D0
			AND.W	#$7F,D0
			MOVE.W	D0,2(A1)
			
			LSR.W	#2,D0
			MOVE.B	SinTab(PC,D0.W),D1
			ASR.B	#1,D1
			MOVE.B	5(A1),D0
			MOVE.B	D1,5(A1)
			SUB.B	D0,D1
			
			EXT.W	D1
			ADD.W	D1,ie_X(A0)
			
			
			MOVE.W	(SP)+,D0
			
.NotMouse	CMP.B	#IECLASS_RAWKEY,ie_Class(A0)
			BNE.B	.NextEvent
			
			CMP.W	#$40,ie_Code(A0)
			BNE.B	.NextEvent
			MOVE.W	ie_Qualifier(A0),D1
			AND.W	#IEQUALIFIER_RELATIVEMOUSE|IEQUALIFIER_LCOMMAND|IEQUALIFIER_RCOMMAND,D1
			CMP.W	#IEQUALIFIER_RELATIVEMOUSE|IEQUALIFIER_LCOMMAND|IEQUALIFIER_RCOMMAND,D1
			BNE.B	.NextEvent
			
			MOVEM.L	D0/A0/A6,-(SP)
			MOVE.L	ExecBase,A6
			LEA		_LinkerDB,A1
			MOVE.B	_Common+4(A1),D1
			MOVE.L	_Common+0(A1),A1
			CLR.L	D0
			BSET	D1,D0
			JSR		_LVOSignal(A6)
			MOVEM.L	(SP)+,D0/A0/A6
			
.NextEvent	MOVE.L	ie_NextEvent(A0),A0
			MOVE.L	A0,D1
			BNE.W	.Again
			
			RTS
