	incdir	"p1:include/"
 	include "exec/types.i"
	include	"exec/memory.i"
	include	"exec/tasks.i"
	include "exec/exec_lib.i"
	include "libraries/dos_lib.i"



        move.l  4,a6
        lea     dosname,a1
	move.l	#0,d0
        jsr     _LVOOpenLibrary(a6)
        tst.l   d0
        beq     nodos
        move.l  d0,dosbase

	move.l	dosbase,a6
	move.l	#file1,d1
	move.l	#0,d2
	move.l	#0,d3
	jsr	_LVOExecute(a6)

	move.l  dosbase,a1
        move.l  4,a6
	jsr	_LVOCloseLibrary(a6)


nodos:
	move.l	#0,d0
	rts

dosbase: 	dc.l    0
dosname:	dc.b    "dos.library",0
        	even
file1:		dc.b    "run <nil: >nil: p2:share",0
        	even

