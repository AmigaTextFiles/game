	incdir	"p1:include/"
	include "exec/types.i"
	include	"exec/memory.i"
	include	"exec/tasks.i"
	include "exec/exec_lib.i"
	include "libraries/dos_lib.i"


STACKSIZE=300
CODESIZE=100
LEVEL = 0


	move.l	#STACKSIZE,d0
	move.l	#MEMF_CLEAR|MEMF_PUBLIC,d1
	move.l	4.w,a6
	jsr	_LVOAllocMem(a6)
	tst.l	d0
	beq	nomemory
	move.l	d0,stack

	move.l	#CODESIZE,d0
	move.l	#MEMF_CLEAR|MEMF_PUBLIC,d1
	move.l	4.w,a6
	jsr	_LVOAllocMem(a6)
	tst.l	d0
	beq	exit3
	move.l	d0,mycode


	clr.l	d0
	move.w	#TC_SIZE,d0
	move.l	#MEMF_CLEAR|MEMF_PUBLIC,d1
	move.l	4.w,a6
	jsr	_LVOAllocMem(a6)
	tst.l	d0
	beq	exit2
	move.l	d0,task


	move.l	task,a1

	move.l	stack,d0
	move.l	d0,TC_SPLOWER(a1)
	add.l	#STACKSIZE-4,d0
	move.l	d0,TC_SPUPPER(a1)
	move.l	d0,TC_SPREG(a1)

	lea	TC(a1),a2
	move.b	#NT_TASK,LN_TYPE(a2)
	move.l	#mytask,LN_NAME(a2)	

        move.l  4,a6
        lea     dosname,a1
	move.l	#0,d0
        jsr     _LVOOpenLibrary(a6)
        tst.l   d0
        beq     nodos
        move.l  d0,dosbase

	move.l	mycode,a0
	lea	taskcode,a1
	move.l	#10,d0
cloop:
	move.l	(a1)+,(a0)+
	dbra	d0,cloop

	move.l	task,a1
	move.l	mycode,a2
	move.l	#0,a3
	move.l	4.w,a6
	jsr	_LVOAddTask(a6)


	move.l	#15,d0
	move.l	task,a0
	lea	$3a(a0),a0
	move.l	(a0),a0	
	move.l	d0,8(a0)	;Signalnummer eintragen

	lea	$3a(a0),a0
	move.l	(a0),a0

	move.w	#$0f0,$dff180
	move.w	#2,4(a0)
	move.w	#LEVEL,6(a0)
	move.w	#1,2(a0)
	move.l	#0,d0

	move.l	dosbase,a6
	move.l	#file1,d1
	move.l	#0,d2
	move.l	#0,d3
	jsr	_LVOExecute(a6)

	bsr	waitsig

	move.l	dosbase,a6
	move.l	#file2,d1
	move.l	#0,d2
	move.l	#0,d3
	jsr	_LVOExecute(a6)

	bsr	waitsig

	bsr	mapsig
	
	move.l	task,a1
	move.b	#-120,d0
	move.l	4.w,a6
	jsr	_LVOSetTaskPri(a6)

waitmouse:
	move.l	#50,d1
	move.l	dosbase,a6
	jsr	_LVODelay(a6)
	btst	#6,$bfe001
	bne	waitmouse
	btst	#7,$bfe001
	bne	waitmouse

	move.l	task,a0
	lea	$3a(a0),a0
	move.l	(a0),a0	
	move.l	8(a0),d0
	;move.l	4.w,a6
	;jsr	-336(a6)	;freesignal


	move.l	task,a0
	lea	$3a(a0),a0
	move.l	(a0),a0	
	move.w	#0,4(a0)
	move.w	#0,2(a0)

	bsr	mapsig
	bsr	ingsig

	move.l	#50,d1
	move.l	dosbase,a6
	jsr	_LVODelay(a6)


kein_signal
	move.l	task,a1
	move.l	4.w,a6
	jsr	_LVORemTask(a6)

	move.l  dosbase,a1
        move.l  4,a6
	jsr	_LVOCloseLibrary(a6)

nodos:
	move.l	#CODESIZE,d0
	move.l	mycode,a1
	move.l	4.w,a6
	jsr	_LVOFreeMem(a6)
exit3:
	move.l	#TC_SIZE,d0
	move.l	task,a1
	move.l	4.w,a6
	jsr	_LVOFreeMem(a6)
exit2:
	move.l	#STACKSIZE,d0
	move.l	stack,a1
	move.l	4.w,a6
	jsr	_LVOFreeMem(a6)
exit:
	move.l	#0,d0
	rts

nomemory
	move.l	#-1,d0
	rts	


waitsig:

	rts


mapsig:	
	move.l	task,a0
	lea	$3a(a0),a0
	move.l	(a0),a0
	move.l	12(a0),a1
	move.l	8(a0),d1
	move.l	#1,d0
	lsl.l	d1,d0
	move.l	4.w,a6
	jsr	-324(a6)	;signal
	rts

ingsig:	
	move.l	task,a0
	lea	$3a(a0),a0
	move.l	(a0),a0
	move.l	16(a0),a1
	move.l	8(a0),d1
	move.l	#1,d0
	lsl.l	d1,d0
	move.l	4.w,a6
	jsr	-324(a6)	;signal
	rts


file1:		dc.b    "run <nil: >nil: map.exe",0
        	even

file2:		dc.b    "run <nil: >nil: ingame.exe",0
        	even


taskcode:
back:
	move.w	#$040,$dff180
	bra	back


mycode:		dc.l	0
stack:		dc.l	0	
task:		dc.l	0
mytask:		dc.b	"Chrisis_task",0
dosbase: 	dc.l    0
dosname:	dc.b    "dos.library",0
        	even
savedata:	dc.l	0
dataspace:	dcb.l	20,0


