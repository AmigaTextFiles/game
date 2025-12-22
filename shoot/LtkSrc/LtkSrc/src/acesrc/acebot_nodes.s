	.file	"acebot_nodes.c"
gcc2_compiled.:
	.globl newmap
	.section	".sdata","aw"
	.align 2
	.type	 newmap,@object
	.size	 newmap,4
newmap:
	.long 1
	.globl show_path_from
	.align 2
	.type	 show_path_from,@object
	.size	 show_path_from,4
show_path_from:
	.long -1
	.globl show_path_to
	.align 2
	.type	 show_path_to,@object
	.size	 show_path_to,4
show_path_to:
	.long -1
	.section	".rodata"
	.align 2
.LC0:
	.long 0x41800000
	.align 3
.LC1:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC2:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl ACEND_FindCloseReachableNode
	.type	 ACEND_FindCloseReachableNode,@function
ACEND_FindCloseReachableNode:
	stwu 1,-208(1)
	mflr 0
	mfcr 12
	stfd 30,192(1)
	stfd 31,200(1)
	stmw 22,152(1)
	stw 0,212(1)
	stw 12,148(1)
	lis 11,.LC0@ha
	mr 31,3
	mullw 27,4,4
	la 11,.LC0@l(11)
	lfs 0,196(31)
	lis 9,numnodes@ha
	lfs 13,208(31)
	li 30,0
	mr 28,5
	lfs 12,0(11)
	lis 22,numnodes@ha
	lwz 0,numnodes@l(9)
	lfs 11,188(31)
	fadds 0,0,12
	lfs 10,200(31)
	cmpw 0,30,0
	fsubs 13,13,12
	lfs 9,204(31)
	lfs 12,192(31)
	stfs 11,104(1)
	stfs 0,112(1)
	stfs 12,108(1)
	stfs 10,88(1)
	stfs 9,92(1)
	stfs 13,96(1)
	bc 4,0,.L16
	lis 11,nodes@ha
	lis 9,gi@ha
	la 11,nodes@l(11)
	la 23,gi@l(9)
	addi 24,11,8
	addi 25,11,4
	addi 29,11,12
	lis 9,.LC1@ha
	lis 11,.LC2@ha
	la 9,.LC1@l(9)
	la 11,.LC2@l(11)
	cmpwi 4,28,99
	lfd 30,0(9)
	lfd 31,0(11)
	lis 26,0x4330
.L18:
	lis 9,nodes@ha
	mulli 7,30,116
	bc 12,18,.L20
	lwz 0,0(29)
	cmpw 0,28,0
	bc 4,2,.L17
.L20:
	lfs 0,8(31)
	la 11,nodes@l(9)
	xoris 0,27,0x8000
	lfsx 10,25,7
	lfsx 12,11,7
	stw 0,140(1)
	fsubs 10,10,0
	lfs 11,12(31)
	lfs 0,4(31)
	stw 26,136(1)
	lfd 13,136(1)
	fmuls 9,10,10
	fsubs 12,12,0
	lfsx 0,24,7
	fsub 13,13,30
	stfs 10,12(1)
	stfs 12,8(1)
	fsubs 0,0,11
	fmadds 12,12,12,9
	frsp 13,13
	stfs 0,16(1)
	fmadds 0,0,0,12
	fcmpu 0,0,13
	bc 4,0,.L17
	add 7,7,11
	addi 3,1,24
	lwz 11,48(23)
	addi 4,31,4
	addi 5,1,104
	addi 6,1,88
	mr 8,31
	li 9,-1
	mtlr 11
	blrl
	lfs 0,32(1)
	fcmpu 0,0,31
	bc 4,2,.L17
	mr 3,30
	b .L24
.L17:
	lwz 0,numnodes@l(22)
	addi 30,30,1
	addi 29,29,116
	cmpw 0,30,0
	bc 12,0,.L18
.L16:
	li 3,-1
.L24:
	lwz 0,212(1)
	lwz 12,148(1)
	mtlr 0
	lmw 22,152(1)
	lfd 30,192(1)
	lfd 31,200(1)
	mtcrf 8,12
	la 1,208(1)
	blr
.Lfe1:
	.size	 ACEND_FindCloseReachableNode,.Lfe1-ACEND_FindCloseReachableNode
	.section	".rodata"
	.align 2
.LC5:
	.string	"func_door_rotating"
	.align 2
.LC3:
	.long 0x47c34f80
	.align 3
.LC4:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 2
.LC6:
	.long 0x41900000
	.align 2
.LC7:
	.long 0x41800000
	.align 3
.LC8:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC9:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl ACEND_FindClosestReachableNode
	.type	 ACEND_FindClosestReachableNode,@function
ACEND_FindClosestReachableNode:
	stwu 1,-208(1)
	mflr 0
	mfcr 12
	stfd 28,176(1)
	stfd 29,184(1)
	stfd 30,192(1)
	stfd 31,200(1)
	stmw 24,144(1)
	stw 0,212(1)
	stw 12,140(1)
	mr 31,3
	mr 28,5
	lfs 9,196(31)
	cmpwi 0,28,1
	lis 9,.LC3@ha
	lfs 10,208(31)
	li 27,-1
	lfs 0,188(31)
	lfs 13,192(31)
	lfs 12,200(31)
	lfs 11,204(31)
	lfs 30,.LC3@l(9)
	stfs 0,104(1)
	stfs 13,108(1)
	stfs 12,88(1)
	stfs 11,92(1)
	stfs 9,112(1)
	stfs 10,96(1)
	bc 4,2,.L26
	lis 9,vec3_origin@ha
	la 11,vec3_origin@l(9)
	lfs 13,vec3_origin@l(9)
	lfs 12,8(11)
	lfs 0,4(11)
	stfs 13,104(1)
	stfs 12,112(1)
	stfs 0,108(1)
	stfs 13,88(1)
	stfs 0,92(1)
	stfs 12,96(1)
	b .L27
.L26:
	lis 9,.LC6@ha
	lis 10,.LC7@ha
	la 9,.LC6@l(9)
	la 10,.LC7@l(10)
	lfs 0,0(9)
	lfs 13,0(10)
	fadds 0,9,0
	fsubs 13,10,13
	stfs 0,112(1)
	stfs 13,96(1)
.L27:
	mullw 0,4,4
	lis 8,0x4330
	lis 10,.LC8@ha
	lis 11,numnodes@ha
	xoris 0,0,0x8000
	la 10,.LC8@l(10)
	stw 0,132(1)
	li 30,0
	lis 24,numnodes@ha
	stw 8,128(1)
	lfd 13,0(10)
	lfd 0,128(1)
	lwz 10,numnodes@l(11)
	fsub 0,0,13
	cmpw 0,30,10
	frsp 28,0
	bc 4,0,.L29
	lis 11,.LC4@ha
	lis 9,nodes@ha
	lfd 29,.LC4@l(11)
	cmpwi 4,28,99
	la 9,nodes@l(9)
	lis 11,gi@ha
	addi 25,9,4
	la 26,gi@l(11)
	addi 29,9,12
.L31:
	lis 9,nodes@ha
	mulli 7,30,116
	bc 12,18,.L33
	lwz 0,0(29)
	cmpw 0,28,0
	bc 4,2,.L30
.L33:
	lfs 12,8(31)
	la 11,nodes@l(9)
	lfsx 11,25,7
	addi 9,11,8
	lfs 13,4(31)
	lfsx 0,11,7
	fsubs 11,11,12
	lfs 10,12(31)
	lfsx 12,9,7
	fsubs 0,0,13
	fmuls 13,11,11
	stfs 11,12(1)
	fsubs 12,12,10
	stfs 0,8(1)
	fmadds 0,0,0,13
	stfs 12,16(1)
	fmadds 31,12,12,0
	fcmpu 7,31,30
	fcmpu 6,31,28
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,25,1
	and. 10,9,0
	bc 12,2,.L30
	add 7,7,11
	li 9,27
	lwz 11,48(26)
	addi 3,1,24
	addi 4,31,4
	addi 5,1,104
	addi 6,1,88
	mr 8,31
	mtlr 11
	blrl
	lfs 13,32(1)
	lis 9,.LC9@ha
	la 9,.LC9@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L36
	fcmpu 0,13,29
	bc 4,1,.L30
	lwz 9,76(1)
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	lwz 3,280(9)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L30
.L36:
	fmr 30,31
	mr 27,30
.L30:
	lwz 0,numnodes@l(24)
	addi 30,30,1
	addi 29,29,116
	cmpw 0,30,0
	bc 12,0,.L31
.L29:
	mr 3,27
	lwz 0,212(1)
	lwz 12,140(1)
	mtlr 0
	lmw 24,144(1)
	lfd 28,176(1)
	lfd 29,184(1)
	lfd 30,192(1)
	lfd 31,200(1)
	mtcrf 8,12
	la 1,208(1)
	blr
.Lfe2:
	.size	 ACEND_FindClosestReachableNode,.Lfe2-ACEND_FindClosestReachableNode
	.section	".rodata"
	.align 2
.LC10:
	.string	"%s new start node selected %d\n"
	.align 2
.LC11:
	.string	"%s: Target at(%i) - No Path \n"
	.align 2
.LC12:
	.string	"%s reached goal!\n"
	.align 2
.LC13:
	.string	"Trying to read an empty SLL nodelist!\n"
	.align 2
.LC14:
	.long 0x0
	.align 3
.LC15:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC16:
	.long 0x42000000
	.section	".text"
	.align 2
	.globl ACEND_FollowPath
	.type	 ACEND_FollowPath,@function
ACEND_FollowPath:
	stwu 1,-64(1)
	mflr 0
	stmw 29,52(1)
	stw 0,68(1)
	lis 9,ltk_showpath@ha
	lis 10,.LC14@ha
	lwz 11,ltk_showpath@l(9)
	la 10,.LC14@l(10)
	mr 31,3
	lfs 13,0(10)
	lis 8,show_path_from@ha
	lfs 0,20(11)
	lis 10,show_path_to@ha
	lwz 9,960(31)
	lwz 0,964(31)
	fcmpu 0,0,13
	stw 9,show_path_from@l(8)
	stw 0,show_path_to@l(10)
	bc 12,2,.L42
	bl ACEND_DrawPath
.L42:
	lwz 9,972(31)
	mr 0,9
	cmpwi 0,0,30
	addi 9,9,1
	stw 9,972(31)
	bc 4,1,.L43
	lwz 9,980(31)
	mr 0,9
	cmpwi 0,0,3
	addi 9,9,1
	stw 9,980(31)
	li 3,0
	bc 12,1,.L63
	mr 3,31
	li 4,288
	li 5,99
	bl ACEND_FindClosestReachableNode
	mr 29,3
	cmpwi 0,29,-1
	bc 12,2,.L43
	lis 9,debug_mode@ha
	lwz 0,debug_mode@l(9)
	cmpwi 0,0,0
	bc 12,2,.L48
	lwz 4,84(31)
	lis 3,.LC10@ha
	mr 5,29
	la 3,.LC10@l(3)
	addi 4,4,700
	crxor 6,6,6
	bl debug_printf
.L48:
	li 0,0
	stw 29,968(31)
	stw 0,972(31)
	stw 29,960(31)
.L43:
	lis 10,level+4@ha
	lfs 11,level+4@l(10)
	mr 11,9
	lis 0,0x4330
	lis 10,.LC15@ha
	addi 30,31,944
	la 10,.LC15@l(10)
	fmr 0,11
	lfd 12,0(10)
	fctiwz 13,0
	stfd 13,40(1)
	lwz 9,44(1)
	xoris 9,9,0x8000
	stw 9,44(1)
	stw 0,40(1)
	lfd 0,40(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,11,0
	bc 4,2,.L49
	lwz 29,960(31)
	mr 3,30
	bl SLLfront
	mr 4,3
	mr 3,29
	bl AntLinkExists
	cmpwi 0,3,0
	bc 4,2,.L49
	mr 3,30
	bl SLLfront
	lwz 0,960(31)
	cmpw 0,0,3
	bc 12,2,.L49
	mr 3,31
	bl AntInitSearch
.L49:
	mr 3,30
	bl SLLempty
	cmpwi 0,3,0
	bc 12,2,.L51
	lwz 4,960(31)
	lwz 5,964(31)
	cmpw 0,4,5
	bc 12,2,.L51
	mr 3,31
	bl AntStartSearch
	cmpwi 0,3,0
	bc 4,2,.L51
	lis 9,debug_mode@ha
	lwz 0,debug_mode@l(9)
	cmpwi 0,0,0
	bc 12,2,.L62
	lis 9,gi@ha
	lwz 5,84(31)
	lis 4,.LC11@ha
	lwz 0,gi@l(9)
	la 4,.LC11@l(4)
	li 3,2
	addi 5,5,700
	lwz 7,968(31)
	lwz 6,964(31)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L62
.L51:
	lwz 0,968(31)
	lis 9,nodes@ha
	addi 3,1,8
	la 9,nodes@l(9)
	lfs 9,4(31)
	mulli 0,0,116
	addi 11,9,8
	addi 10,9,4
	lfs 13,8(31)
	lfs 0,12(31)
	lfsx 10,9,0
	lfsx 12,11,0
	lfsx 11,10,0
	fsubs 9,9,10
	fsubs 0,0,12
	fsubs 13,13,11
	stfs 9,8(1)
	stfs 0,16(1)
	stfs 13,12(1)
	bl VectorLength
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L54
	lwz 11,968(31)
	li 0,0
	lwz 9,964(31)
	stw 0,972(31)
	cmpw 0,11,9
	bc 4,2,.L55
	lis 9,debug_mode@ha
	lwz 0,debug_mode@l(9)
	cmpwi 0,0,0
	bc 12,2,.L56
	lwz 4,84(31)
	lis 3,.LC12@ha
	la 3,.LC12@l(3)
	addi 4,4,700
	crxor 6,6,6
	bl debug_printf
.L56:
	mr 3,31
	bl ACEAI_PickLongRangeGoal
	b .L54
.L55:
	stw 11,960(31)
	mr 3,30
	bl SLLpop_front
	mr 3,30
	bl SLLempty
	cmpwi 0,3,0
	bc 4,2,.L58
	mr 3,30
	bl SLLfront
	stw 3,968(31)
	b .L54
.L58:
	lis 9,debug_mode@ha
	lwz 0,debug_mode@l(9)
	cmpwi 0,0,0
	bc 12,2,.L60
	lis 9,gi@ha
	lis 4,.LC13@ha
	lwz 0,gi@l(9)
	la 4,.LC13@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L60:
	li 0,-1
	stw 0,968(31)
.L54:
	lwz 0,960(31)
	cmpwi 0,0,-1
	bc 12,2,.L62
	lwz 0,968(31)
	cmpwi 0,0,-1
	bc 4,2,.L61
.L62:
	li 3,0
	b .L63
.L61:
	mulli 0,0,116
	lis 9,nodes@ha
	lfs 0,4(31)
	li 3,1
	la 9,nodes@l(9)
	lfs 11,8(31)
	lfsx 13,9,0
	addi 11,9,4
	addi 9,9,8
	lfs 12,12(31)
	fsubs 13,13,0
	stfs 13,912(31)
	lfsx 0,11,0
	fsubs 0,0,11
	stfs 0,916(31)
	lfsx 13,9,0
	fsubs 13,13,12
	stfs 13,920(31)
.L63:
	lwz 0,68(1)
	mtlr 0
	lmw 29,52(1)
	la 1,64(1)
	blr
.Lfe3:
	.size	 ACEND_FollowPath,.Lfe3-ACEND_FollowPath
	.section	".rodata"
	.align 2
.LC17:
	.long 0x41800000
	.align 2
.LC18:
	.long 0x41b00000
	.align 3
.LC19:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl ACEND_LadderForward
	.type	 ACEND_LadderForward,@function
ACEND_LadderForward:
	stwu 1,-176(1)
	mflr 0
	stmw 28,160(1)
	stw 0,180(1)
	mr 31,3
	li 0,0
	lfs 0,20(31)
	addi 28,1,40
	addi 3,1,24
	stw 0,24(1)
	addi 4,1,8
	li 6,0
	stw 0,32(1)
	li 5,0
	addi 29,31,4
	stfs 0,28(1)
	bl AngleVectors
	lis 9,.LC17@ha
	lfs 0,196(31)
	addi 4,1,8
	la 9,.LC17@l(9)
	lfs 9,188(31)
	mr 3,29
	lfs 1,0(9)
	mr 5,28
	lis 9,.LC18@ha
	lfs 12,192(31)
	la 9,.LC18@l(9)
	lfs 11,204(31)
	lfs 13,0(9)
	lfs 10,208(31)
	fadds 0,0,13
	lfs 13,200(31)
	stfs 9,56(1)
	stfs 0,64(1)
	stfs 13,72(1)
	stfs 12,60(1)
	stfs 11,76(1)
	stfs 10,80(1)
	bl VectorMA
	lis 9,gi+48@ha
	mr 4,29
	lwz 0,gi+48@l(9)
	mr 7,28
	addi 3,1,88
	li 9,-1
	addi 5,1,56
	addi 6,1,72
	mr 8,31
	mtlr 0
	blrl
	lfs 0,96(1)
	lis 9,.LC19@ha
	la 9,.LC19@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L71
	lwz 0,136(1)
	andis. 9,0,0x2800
	bc 12,2,.L71
	mr 3,31
	li 4,96
	li 5,1
	bl ACEND_FindClosestReachableNode
	mr 29,3
	cmpwi 0,29,-1
	bc 4,2,.L72
	li 4,1
	mr 3,31
	bl ACEND_AddNode
	mr 29,3
.L72:
	lwz 4,976(31)
	mr 3,31
	mr 5,29
	bl ACEND_UpdateNodeEdge
	stw 29,976(31)
	li 3,1
	b .L74
.L71:
	li 3,0
.L74:
	lwz 0,180(1)
	mtlr 0
	lmw 28,160(1)
	la 1,176(1)
	blr
.Lfe4:
	.size	 ACEND_LadderForward,.Lfe4-ACEND_LadderForward
	.section	".rodata"
	.align 2
.LC20:
	.long 0x0
	.align 2
.LC21:
	.long 0x41900000
	.section	".text"
	.align 2
	.globl ACEND_PathMap
	.type	 ACEND_PathMap,@function
ACEND_PathMap:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 11,.LC20@ha
	lis 9,ltk_showpath@ha
	la 11,.LC20@l(11)
	mr 30,3
	lfs 13,0(11)
	lwz 11,ltk_showpath@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L76
	lis 9,show_path_to@ha
	lwz 0,show_path_to@l(9)
	cmpwi 0,0,-1
	bc 12,2,.L76
	bl ACEND_DrawPath
.L76:
	mr 3,30
	bl ACEND_LadderForward
	cmpwi 0,3,0
	bc 4,2,.L75
	lwz 0,552(30)
	cmpwi 0,0,0
	bc 4,2,.L79
	lwz 0,612(30)
	cmpwi 0,0,0
	bc 12,2,.L75
.L79:
	lis 9,.LC21@ha
	lfs 12,12(30)
	addi 3,1,8
	la 9,.LC21@l(9)
	lfs 0,4(30)
	lfs 13,0(9)
	lis 9,gi+52@ha
	lwz 0,gi+52@l(9)
	fsubs 12,12,13
	lfs 13,8(30)
	mtlr 0
	stfs 0,8(1)
	stfs 12,16(1)
	stfs 13,12(1)
	blrl
	andi. 29,3,24
	bc 4,2,.L75
	lwz 0,908(30)
	cmpwi 0,0,0
	bc 12,2,.L81
	mr 3,30
	li 4,64
	li 5,7
	bl ACEND_FindClosestReachableNode
	mr 31,3
	cmpwi 0,31,-1
	bc 4,2,.L82
	mr 3,30
	li 4,7
	bl ACEND_AddNode
	mr 31,3
.L82:
	lwz 4,976(30)
	cmpwi 0,4,-1
	bc 12,2,.L83
	mr 5,31
	mr 3,30
	bl ACEND_UpdateNodeEdge
.L83:
	stw 29,908(30)
	b .L75
.L81:
	mr 3,30
	li 4,96
	li 5,99
	bl ACEND_FindClosestReachableNode
	lwz 9,552(30)
	mr 31,3
	cmpwi 0,9,0
	bc 12,2,.L84
	lwz 0,448(9)
	lis 9,Use_Plat@ha
	la 9,Use_Plat@l(9)
	cmpw 0,0,9
	bc 4,2,.L84
	cmpwi 0,31,-1
	bc 12,2,.L75
	b .L87
.L84:
	cmpwi 0,31,-1
	bc 4,2,.L87
	lwz 0,612(30)
	cmpwi 0,0,0
	bc 12,2,.L88
	mr 3,30
	li 4,5
	b .L93
.L88:
	mr 3,30
	li 4,0
.L93:
	bl ACEND_AddNode
	mr 31,3
	lwz 4,976(30)
	cmpwi 0,4,-1
	bc 12,2,.L91
	mr 3,30
	mr 5,31
	bl ACEND_UpdateNodeEdge
	b .L91
.L87:
	lwz 4,976(30)
	cmpw 0,31,4
	bc 12,2,.L91
	cmpwi 0,4,-1
	bc 12,2,.L91
	mr 3,30
	mr 5,31
	bl ACEND_UpdateNodeEdge
.L91:
	stw 31,976(30)
.L75:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 ACEND_PathMap,.Lfe5-ACEND_PathMap
	.section	".rodata"
	.align 2
.LC22:
	.string	"models/items/ammo/grenades/medium/tris.md2"
	.align 3
.LC23:
	.long 0x4082c000
	.long 0x0
	.section	".text"
	.align 2
	.globl ACEND_ShowNode
	.type	 ACEND_ShowNode,@function
ACEND_ShowNode:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 30,3
	bl G_Spawn
	lis 9,nodes@ha
	li 0,0
	mulli 11,30,116
	mr 31,3
	la 9,nodes@l(9)
	stw 0,248(31)
	addi 9,9,12
	stw 0,260(31)
	lwzx 0,9,11
	cmpwi 0,0,0
	bc 4,2,.L97
	li 0,4096
	b .L101
.L97:
	cmpwi 0,0,5
	li 0,2048
	bc 4,2,.L99
	li 0,1024
.L99:
.L101:
	stw 0,68(31)
	lis 29,gi@ha
	lis 3,.LC22@ha
	la 29,gi@l(29)
	la 3,.LC22@l(3)
	lwz 9,32(29)
	mtlr 9
	blrl
	stw 3,40(31)
	lis 9,level+4@ha
	lis 10,.LC23@ha
	mulli 0,30,116
	stw 31,256(31)
	lis 11,G_FreeEdict@ha
	li 8,0
	lfs 0,level+4@l(9)
	la 11,G_FreeEdict@l(11)
	mr 3,31
	lfd 13,.LC23@l(10)
	lis 9,nodes@ha
	stw 11,436(31)
	la 9,nodes@l(9)
	stw 8,516(31)
	addi 10,9,4
	addi 11,9,8
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lfsx 13,9,0
	stfs 13,4(31)
	lfsx 0,10,0
	stfs 0,8(31)
	lfsx 13,11,0
	stfs 13,12(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 ACEND_ShowNode,.Lfe6-ACEND_ShowNode
	.align 2
	.globl ACEND_DrawPath
	.type	 ACEND_DrawPath,@function
ACEND_DrawPath:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 11,show_path_from@ha
	lis 9,show_path_to@ha
	lwz 31,show_path_from@l(11)
	addi 29,3,944
	lwz 26,show_path_to@l(9)
	mr 4,31
	mr 5,26
	bl AntStartSearch
	mr 3,29
	bl SLLfront
	xor 9,31,26
	nor 11,31,31
	addic 0,9,-1
	subfe 10,0,9
	mr 30,3
	addic 9,11,-1
	subfe 0,9,11
	and. 9,10,0
	bc 12,2,.L104
	lis 9,gi@ha
	lis 11,nodes@ha
	la 28,gi@l(9)
	la 25,nodes@l(11)
	mr 27,29
.L105:
	lwz 9,100(28)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(28)
	li 3,23
	mtlr 9
	blrl
	mulli 29,31,116
	lwz 9,120(28)
	mr 31,30
	add 29,29,25
	mtlr 9
	mr 3,29
	blrl
	lwz 9,120(28)
	mulli 3,30,116
	mtlr 9
	add 3,3,25
	blrl
	lwz 9,88(28)
	li 4,2
	mr 3,29
	mtlr 9
	blrl
	mr 3,27
	bl SLLpop_front
	mr 3,27
	bl SLLfront
	xor 9,31,26
	nor 11,31,31
	addic 0,9,-1
	subfe 10,0,9
	mr 30,3
	addic 9,11,-1
	subfe 0,9,11
	and. 9,10,0
	bc 4,2,.L105
.L104:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 ACEND_DrawPath,.Lfe7-ACEND_DrawPath
	.section	".rodata"
	.align 2
.LC24:
	.string	"Node added %d type: Ladder\n"
	.align 2
.LC25:
	.string	"Node added %d type: Platform\n"
	.align 2
.LC26:
	.string	"Node added %d type: Move\n"
	.align 2
.LC27:
	.string	"Node added %d type: Teleporter\n"
	.align 2
.LC28:
	.string	"Node added %d type: Item\n"
	.align 2
.LC29:
	.string	"Node added %d type: Water\n"
	.align 2
.LC30:
	.string	"Node added %d type: Grapple\n"
	.align 2
.LC31:
	.long 0x41800000
	.align 2
.LC32:
	.long 0x42000000
	.align 2
.LC33:
	.long 0x3f000000
	.align 2
.LC34:
	.long 0x42800000
	.section	".text"
	.align 2
	.globl ACEND_AddNode
	.type	 ACEND_AddNode,@function
ACEND_AddNode:
	stwu 1,-80(1)
	mflr 0
	stmw 26,56(1)
	stw 0,84(1)
	lis 9,numnodes@ha
	mr 31,3
	lwz 11,numnodes@l(9)
	la 10,numnodes@l(9)
	mr 30,4
	lis 27,numnodes@ha
	addi 0,11,1
	cmpwi 0,0,1200
	bc 4,1,.L109
	li 3,0
	b .L133
.L109:
	lfs 0,4(31)
	mulli 0,11,116
	lis 9,nodes@ha
	cmpwi 0,30,4
	la 9,nodes@l(9)
	lhz 6,2(10)
	cmpwi 7,30,3
	addi 10,9,4
	addi 8,9,12
	stfsx 0,9,0
	addi 7,9,8
	add 11,9,0
	lfs 0,8(31)
	cmpwi 6,30,8
	add 9,0,9
	cmpwi 1,30,1
	addi 11,11,108
	stfsx 0,10,0
	lfs 0,12(31)
	li 10,-1
	stwx 30,8,0
	li 8,12
	mtctr 8
	stfsx 0,7,0
	sth 6,16(9)
.L134:
	sth 10,0(11)
	addi 11,11,-8
	bdnz .L134
	bc 4,2,.L115
	lis 9,numnodes@ha
	lis 11,nodes@ha
	lwz 0,numnodes@l(9)
	la 11,nodes@l(11)
	lis 10,numitemnodes@ha
	lis 9,.LC31@ha
	addi 11,11,8
	mulli 0,0,116
	la 9,.LC31@l(9)
	lfs 13,0(9)
	lfsx 0,11,0
	lwz 9,numitemnodes@l(10)
	fadds 0,0,13
	addi 9,9,1
	stw 9,numitemnodes@l(10)
	stfsx 0,11,0
.L115:
	bc 4,30,.L116
	lis 11,numnodes@ha
	lis 9,nodes@ha
	lwz 0,numnodes@l(11)
	la 9,nodes@l(9)
	lis 11,.LC32@ha
	addi 9,9,8
	mulli 0,0,116
	la 11,.LC32@l(11)
	lfs 13,0(11)
	lfsx 0,9,0
	fadds 0,0,13
	stfsx 0,9,0
.L116:
	bc 4,26,.L117
	lfs 8,188(31)
	lis 11,.LC31@ha
	lis 9,.LC33@ha
	lfs 11,4(31)
	la 11,.LC31@l(11)
	la 9,.LC33@l(9)
	lfs 13,200(31)
	lis 8,numnodes@ha
	lfs 9,192(31)
	lfs 10,8(31)
	fadds 11,11,8
	lfs 0,204(31)
	fsubs 13,13,8
	lfs 12,12(31)
	lfs 6,0(11)
	fadds 10,10,9
	lfs 7,0(9)
	fsubs 0,0,9
	lwz 0,numnodes@l(8)
	lis 9,nodes@ha
	fsubs 12,12,6
	la 9,nodes@l(9)
	mulli 0,0,116
	fmadds 13,13,7,11
	addi 11,9,8
	addi 10,9,4
	fmadds 0,0,7,10
	stfsx 12,11,0
	stfsx 13,9,0
	stfsx 0,10,0
	stfs 13,40(1)
	stfs 0,44(1)
	stfs 12,48(1)
.L117:
	bc 4,6,.L118
	lis 11,numnodes@ha
	lis 10,debug_mode@ha
	lwz 4,numnodes@l(11)
	lis 9,nodes@ha
	lwz 11,debug_mode@l(10)
	la 9,nodes@l(9)
	mulli 0,4,116
	addi 9,9,12
	cmpwi 0,11,0
	stwx 30,9,0
	bc 12,2,.L122
	lis 3,.LC24@ha
	la 3,.LC24@l(3)
	b .L136
.L118:
	cmpwi 0,30,2
	bc 4,2,.L120
	lfs 9,188(31)
	lis 8,.LC33@ha
	lis 10,numnodes@ha
	lfs 7,200(31)
	la 8,.LC33@l(8)
	lis 9,nodes@ha
	lfs 10,192(31)
	la 29,nodes@l(9)
	lis 11,debug_mode@ha
	lfs 6,204(31)
	addi 28,29,4
	addi 26,29,8
	lfs 8,0(8)
	fsubs 0,7,9
	lwz 3,numnodes@l(10)
	fsubs 13,6,10
	lfs 11,208(31)
	fmadds 0,0,8,9
	lfs 12,196(31)
	mulli 0,3,116
	lwz 9,debug_mode@l(11)
	fmadds 13,13,8,10
	stfs 11,16(1)
	stfsx 0,29,0
	cmpwi 0,9,0
	stfs 12,32(1)
	stfsx 13,28,0
	lfs 0,208(31)
	stfs 7,8(1)
	stfs 6,12(1)
	stfsx 0,26,0
	stfs 9,24(1)
	stfs 10,28(1)
	bc 12,2,.L121
	bl ACEND_ShowNode
.L121:
	lwz 5,numnodes@l(27)
	lis 8,.LC34@ha
	addi 10,29,12
	la 8,.LC34@l(8)
	mr 3,31
	mulli 11,5,116
	addi 0,5,1
	lfs 12,0(8)
	mulli 9,0,116
	stw 0,numnodes@l(27)
	mr 4,0
	lfsx 0,29,11
	stfsx 0,29,9
	lfsx 13,28,11
	stfsx 13,28,9
	lfs 0,196(31)
	stwx 30,10,9
	fadds 0,0,12
	stfsx 0,26,9
	bl ACEND_UpdateNodeEdge
	lis 9,debug_mode@ha
	lwz 0,debug_mode@l(9)
	cmpwi 0,0,0
	bc 12,2,.L122
	lis 3,.LC25@ha
	lwz 4,numnodes@l(27)
	la 3,.LC25@l(3)
.L136:
	crxor 6,6,6
	bl debug_printf
	lwz 3,numnodes@l(27)
	bl ACEND_ShowNode
.L122:
	lwz 3,numnodes@l(27)
	addi 0,3,1
	stw 0,numnodes@l(27)
	b .L133
.L120:
	lis 9,debug_mode@ha
	lwz 0,debug_mode@l(9)
	cmpwi 0,0,0
	bc 12,2,.L123
	lis 9,numnodes@ha
	lis 11,nodes@ha
	lwz 4,numnodes@l(9)
	la 11,nodes@l(11)
	addi 11,11,12
	mulli 0,4,116
	lwzx 0,11,0
	cmpwi 0,0,0
	bc 4,2,.L124
	lis 3,.LC26@ha
	la 3,.LC26@l(3)
	crxor 6,6,6
	bl debug_printf
	b .L125
.L124:
	cmpwi 0,0,3
	bc 4,2,.L126
	lis 3,.LC27@ha
	la 3,.LC27@l(3)
	crxor 6,6,6
	bl debug_printf
	b .L125
.L126:
	cmpwi 0,0,4
	bc 4,2,.L128
	lis 3,.LC28@ha
	la 3,.LC28@l(3)
	crxor 6,6,6
	bl debug_printf
	b .L125
.L128:
	cmpwi 0,0,5
	bc 4,2,.L130
	lis 3,.LC29@ha
	la 3,.LC29@l(3)
	crxor 6,6,6
	bl debug_printf
	b .L125
.L130:
	cmpwi 0,0,6
	bc 4,2,.L125
	lis 3,.LC30@ha
	la 3,.LC30@l(3)
	crxor 6,6,6
	bl debug_printf
.L125:
	lis 9,numnodes@ha
	lwz 3,numnodes@l(9)
	bl ACEND_ShowNode
.L123:
	lis 9,numnodes@ha
	lwz 3,numnodes@l(9)
	addi 0,3,1
	stw 0,numnodes@l(9)
.L133:
	lwz 0,84(1)
	mtlr 0
	lmw 26,56(1)
	la 1,80(1)
	blr
.Lfe8:
	.size	 ACEND_AddNode,.Lfe8-ACEND_AddNode
	.section	".rodata"
	.align 3
.LC35:
	.long 0x40400000
	.long 0x0
	.align 3
.LC36:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl ACEND_ReverseLink
	.type	 ACEND_ReverseLink,@function
ACEND_ReverseLink:
	stwu 1,-160(1)
	mflr 0
	stmw 24,128(1)
	stw 0,164(1)
	mr 27,4
	mr 29,5
	subfic 9,27,-1
	subfic 0,9,0
	adde 9,0,9
	subfic 0,29,-1
	subfic 10,0,0
	adde 0,10,0
	or. 11,9,0
	mr 11,3
	bc 4,2,.L137
	cmpw 0,27,29
	bc 12,2,.L137
	lis 9,nodes@ha
	mulli 0,27,116
	lis 10,.LC35@ha
	la 26,nodes@l(9)
	mulli 28,29,116
	la 10,.LC35@l(10)
	addi 25,26,8
	lfd 12,0(10)
	mr 30,0
	lfsx 0,25,0
	lfsx 13,25,28
	fadd 0,0,12
	fcmpu 0,0,13
	bc 12,0,.L137
	lis 9,gi+48@ha
	add 31,30,26
	lfs 13,200(11)
	lwz 10,gi+48@l(9)
	mr 8,11
	addi 3,1,8
	lfs 0,204(11)
	li 9,3
	mr 4,31
	lfs 11,188(11)
	addi 5,1,72
	addi 6,1,88
	mtlr 10
	lfs 12,192(11)
	add 7,28,26
	li 0,0
	stfs 13,88(1)
	stfs 0,92(1)
	stfs 11,72(1)
	stfs 12,76(1)
	stw 0,96(1)
	stw 0,80(1)
	blrl
	lfs 0,16(1)
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L137
	lha 11,20(31)
	add 0,29,29
	mulli 10,27,2400
	lis 9,path_table@ha
	mr 24,0
	la 9,path_table@l(9)
	cmpw 0,11,29
	add 0,0,10
	sthx 29,9,0
	li 8,0
	bc 12,2,.L143
	mr 9,26
	mr 7,28
	addi 10,9,4
	mr 11,25
.L146:
	lha 0,20(31)
	cmpwi 0,0,-1
	bc 4,2,.L144
	lfsx 9,11,7
	addi 3,1,104
	lfsx 11,9,7
	lfsx 10,10,7
	lfsx 0,11,30
	lfsx 13,9,30
	lfsx 12,10,30
	fsubs 0,0,9
	fsubs 13,13,11
	fsubs 12,12,10
	stfs 0,112(1)
	stfs 13,104(1)
	stfs 12,108(1)
	bl VectorLength
	stfs 1,24(31)
	sth 29,20(31)
	b .L143
.L144:
	addi 8,8,1
	addi 31,31,8
	cmpwi 0,8,11
	bc 12,1,.L143
	lha 0,20(31)
	cmpw 0,0,29
	bc 4,2,.L146
.L143:
	lis 9,numnodes@ha
	li 8,0
	lwz 11,numnodes@l(9)
	cmpw 0,8,11
	bc 4,0,.L137
	lis 9,path_table@ha
	add 0,27,27
	la 9,path_table@l(9)
	mr 6,11
	add 7,24,9
	add 4,0,9
	li 5,-1
	li 10,0
.L152:
	lhz 11,0(4)
	addi 4,4,2400
	extsh 0,11
	cmpwi 0,0,-1
	bc 12,2,.L151
	cmpw 0,8,29
	bc 4,2,.L154
	add 0,8,8
	add 0,0,10
	sthx 5,9,0
	b .L151
.L154:
	sth 11,0(7)
.L151:
	addi 8,8,1
	addi 7,7,2400
	cmpw 0,8,6
	addi 10,10,2400
	bc 12,0,.L152
.L137:
	lwz 0,164(1)
	mtlr 0
	lmw 24,128(1)
	la 1,160(1)
	blr
.Lfe9:
	.size	 ACEND_ReverseLink,.Lfe9-ACEND_ReverseLink
	.section	".rodata"
	.align 2
.LC37:
	.long 0x42100000
	.align 2
.LC38:
	.long 0x43340000
	.align 3
.LC39:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl ACEND_UpdateNodeEdge
	.type	 ACEND_UpdateNodeEdge,@function
ACEND_UpdateNodeEdge:
	stwu 1,-160(1)
	mflr 0
	stmw 23,124(1)
	stw 0,164(1)
	mr 28,4
	mr 29,5
	subfic 9,28,-1
	subfic 0,9,0
	adde 9,0,9
	mr 23,3
	subfic 0,29,-1
	subfic 10,0,0
	adde 0,10,0
	or. 11,9,0
	bc 4,2,.L157
	cmpw 0,28,29
	bc 12,2,.L157
	lis 10,.LC37@ha
	lis 9,nodes@ha
	mulli 11,28,116
	la 10,.LC37@l(10)
	mulli 0,29,116
	lfs 12,0(10)
	mr 30,11
	la 10,nodes@l(9)
	mr 27,0
	addi 9,10,8
	lfsx 0,9,11
	lfsx 13,9,0
	fadds 0,0,12
	fcmpu 0,13,0
	bc 4,1,.L160
	addi 11,10,12
	lwzx 0,11,30
	xori 9,0,7
	subfic 10,9,0
	adde 9,10,9
	subfic 10,0,0
	adde 0,10,0
	or. 10,0,9
	bc 12,2,.L160
	lwzx 0,11,27
	xori 9,0,7
	subfic 11,9,0
	adde 9,11,9
	subfic 10,0,0
	adde 0,10,0
	or. 11,0,9
	bc 4,2,.L157
.L160:
	lis 9,nodes@ha
	lis 10,.LC38@ha
	la 26,nodes@l(9)
	la 10,.LC38@l(10)
	addi 25,26,8
	lfs 12,0(10)
	lfsx 0,25,27
	lfsx 13,25,30
	fadds 0,0,12
	fcmpu 0,13,0
	bc 12,1,.L157
	lis 9,gi+48@ha
	lis 11,vec3_origin@ha
	lwz 0,gi+48@l(9)
	la 10,vec3_origin@l(11)
	add 31,30,26
	lfs 13,8(10)
	li 9,3
	addi 3,1,8
	lfs 0,4(10)
	mr 4,31
	addi 5,1,72
	mtlr 0
	lfs 12,vec3_origin@l(11)
	addi 6,1,88
	add 7,27,26
	mr 8,23
	stfs 13,96(1)
	stfs 0,92(1)
	stfs 0,76(1)
	stfs 13,80(1)
	stfs 12,88(1)
	stfs 12,72(1)
	blrl
	lfs 0,16(1)
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L157
	lha 11,20(31)
	add 0,29,29
	mulli 10,28,2400
	lis 9,path_table@ha
	mr 24,0
	la 9,path_table@l(9)
	cmpw 0,11,29
	add 0,0,10
	sthx 29,9,0
	li 8,0
	bc 12,2,.L166
	mr 9,26
	mr 7,27
	addi 10,9,4
	mr 11,25
.L169:
	lha 0,20(31)
	cmpwi 0,0,-1
	bc 4,2,.L167
	lfsx 9,11,7
	addi 3,1,104
	lfsx 11,9,7
	lfsx 10,10,7
	lfsx 0,11,30
	lfsx 13,9,30
	lfsx 12,10,30
	fsubs 0,0,9
	fsubs 13,13,11
	fsubs 12,12,10
	stfs 0,112(1)
	stfs 13,104(1)
	stfs 12,108(1)
	bl VectorLength
	stfs 1,24(31)
	sth 29,20(31)
	b .L166
.L167:
	addi 8,8,1
	addi 31,31,8
	cmpwi 0,8,11
	bc 12,1,.L166
	lha 0,20(31)
	cmpw 0,0,29
	bc 4,2,.L169
.L166:
	lis 9,numnodes@ha
	li 8,0
	lwz 11,numnodes@l(9)
	cmpw 0,8,11
	bc 4,0,.L173
	lis 9,path_table@ha
	add 0,28,28
	la 9,path_table@l(9)
	mr 7,11
	add 10,0,9
	li 6,-1
	add 9,24,9
.L175:
	lhz 11,0(10)
	addi 10,10,2400
	extsh 0,11
	cmpwi 0,0,-1
	bc 12,2,.L174
	cmpw 0,8,29
	bc 4,2,.L177
	sth 6,0(9)
	b .L174
.L177:
	sth 11,0(9)
.L174:
	addi 8,8,1
	addi 9,9,2400
	cmpw 0,8,7
	bc 12,0,.L175
.L173:
	mr 3,23
	mr 4,29
	mr 5,28
	bl ACEND_ReverseLink
.L157:
	lwz 0,164(1)
	mtlr 0
	lmw 23,124(1)
	la 1,160(1)
	blr
.Lfe10:
	.size	 ACEND_UpdateNodeEdge,.Lfe10-ACEND_UpdateNodeEdge
	.section	".rodata"
	.align 2
.LC40:
	.string	"%s: Removing Edge %d -> %d\n"
	.align 2
.LC41:
	.string	"Resolving all paths..."
	.align 2
.LC42:
	.string	"done (%d updated)\n"
	.section	".text"
	.align 2
	.globl ACEND_ResolveAllPaths
	.type	 ACEND_ResolveAllPaths,@function
ACEND_ResolveAllPaths:
	stwu 1,-48(1)
	mflr 0
	stmw 22,8(1)
	stw 0,52(1)
	lis 4,.LC41@ha
	li 3,2
	la 4,.LC41@l(4)
	li 26,0
	crxor 6,6,6
	bl safe_bprintf
	lis 9,numnodes@ha
	li 4,0
	lwz 0,numnodes@l(9)
	cmpw 0,26,0
	bc 4,0,.L190
	mr 27,0
	lis 22,path_table@ha
	mr 23,27
.L192:
	li 7,0
	addi 25,4,1
	cmpw 0,7,27
	bc 4,0,.L191
	lis 9,numnodes@ha
	la 24,path_table@l(22)
	mulli 28,4,2400
	lwz 29,numnodes@l(9)
	mr 31,24
	mr 5,23
	add 30,4,4
.L196:
	cmpw 0,4,7
	addi 12,7,1
	bc 12,2,.L195
	add 11,7,7
	add 0,11,28
	lhax 9,24,0
	cmpw 0,9,7
	bc 4,2,.L195
	li 8,0
	addi 26,26,1
	cmpw 0,8,5
	bc 4,0,.L195
	add 11,11,31
	li 3,-1
	mr 6,29
	add 10,30,31
.L201:
	lhz 9,0(10)
	addi 10,10,2400
	extsh 0,9
	cmpwi 0,0,-1
	bc 12,2,.L200
	cmpw 0,8,7
	bc 4,2,.L203
	sth 3,0(11)
	b .L200
.L203:
	sth 9,0(11)
.L200:
	addi 8,8,1
	addi 11,11,2400
	cmpw 0,8,6
	bc 12,0,.L201
.L195:
	mr 7,12
	cmpw 0,7,5
	bc 12,0,.L196
.L191:
	mr 4,25
	cmpw 0,4,27
	bc 12,0,.L192
.L190:
	lis 4,.LC42@ha
	mr 5,26
	la 4,.LC42@l(4)
	li 3,1
	crxor 6,6,6
	bl safe_bprintf
	lwz 0,52(1)
	mtlr 0
	lmw 22,8(1)
	la 1,48(1)
	blr
.Lfe11:
	.size	 ACEND_ResolveAllPaths,.Lfe11-ACEND_ResolveAllPaths
	.section	".rodata"
	.align 2
.LC43:
	.string	"game"
	.align 2
.LC44:
	.string	""
	.align 2
.LC45:
	.string	"/terrain/"
	.align 2
.LC46:
	.string	".ltk"
	.align 2
.LC47:
	.string	"Saving node table..."
	.align 2
.LC48:
	.string	"wb"
	.align 2
.LC49:
	.string	"done.\n"
	.section	".text"
	.align 2
	.globl ACEND_SaveNodes
	.type	 ACEND_SaveNodes,@function
ACEND_SaveNodes:
	stwu 1,-112(1)
	mflr 0
	stmw 26,88(1)
	stw 0,116(1)
	lis 9,numnodes@ha
	li 11,3
	lwz 0,numnodes@l(9)
	la 31,numnodes@l(9)
	lis 27,numnodes@ha
	stw 11,72(1)
	cmpwi 0,0,99
	bc 4,1,.L208
	lis 9,gi+144@ha
	lis 3,.LC43@ha
	lwz 0,gi+144@l(9)
	lis 4,.LC44@ha
	li 5,0
	la 4,.LC44@l(4)
	la 3,.LC43@l(3)
	mtlr 0
	blrl
	lwz 4,4(3)
	addi 3,1,8
	bl strcpy
	lis 4,.LC45@ha
	addi 3,1,8
	la 4,.LC45@l(4)
	bl strcat
	lis 4,level+72@ha
	addi 3,1,8
	la 4,level+72@l(4)
	bl strcat
	lis 4,.LC46@ha
	addi 3,1,8
	la 4,.LC46@l(4)
	bl strcat
	bl ACEND_ResolveAllPaths
	lis 4,.LC47@ha
	li 3,1
	la 4,.LC47@l(4)
	crxor 6,6,6
	bl safe_bprintf
	lis 4,.LC48@ha
	addi 3,1,8
	la 4,.LC48@l(4)
	bl fopen
	mr. 29,3
	bc 12,2,.L208
	addi 3,1,72
	li 4,4
	li 5,1
	mr 6,29
	bl fwrite
	li 4,4
	li 5,1
	mr 6,29
	mr 3,31
	bl fwrite
	lis 3,num_items@ha
	li 4,4
	li 5,1
	mr 6,29
	la 3,num_items@l(3)
	bl fwrite
	lis 3,nodes@ha
	lwz 5,numnodes@l(27)
	li 4,116
	la 3,nodes@l(3)
	mr 6,29
	bl fwrite
	lwz 0,numnodes@l(27)
	li 11,0
	cmpw 0,11,0
	bc 4,0,.L212
	lis 9,path_table@ha
	la 26,path_table@l(9)
.L214:
	lwz 0,numnodes@l(27)
	li 30,0
	addi 28,11,1
	cmpw 0,30,0
	bc 4,0,.L213
	mulli 0,11,2400
	add 31,26,0
.L218:
	mr 3,31
	li 4,2
	li 5,1
	mr 6,29
	bl fwrite
	addi 30,30,1
	addi 31,31,2
	lwz 0,numnodes@l(27)
	cmpw 0,30,0
	bc 12,0,.L218
.L213:
	lwz 0,numnodes@l(27)
	mr 11,28
	cmpw 0,11,0
	bc 12,0,.L214
.L212:
	lis 9,num_items@ha
	lis 3,item_table@ha
	lwz 5,num_items@l(9)
	li 4,16
	mr 6,29
	la 3,item_table@l(3)
	bl fwrite
	mr 3,29
	bl fclose
	lis 4,.LC49@ha
	li 3,1
	la 4,.LC49@l(4)
	crxor 6,6,6
	bl safe_bprintf
.L208:
	lwz 0,116(1)
	mtlr 0
	lmw 26,88(1)
	la 1,112(1)
	blr
.Lfe12:
	.size	 ACEND_SaveNodes,.Lfe12-ACEND_SaveNodes
	.section	".rodata"
	.align 2
.LC50:
	.string	"rb"
	.align 2
.LC51:
	.string	"ACE: No node file found, creating new one..."
	.align 2
.LC52:
	.string	"ACE: Loading node table..."
	.section	".text"
	.align 2
	.globl ACEND_LoadNodes
	.type	 ACEND_LoadNodes,@function
ACEND_LoadNodes:
	stwu 1,-112(1)
	mflr 0
	stmw 26,88(1)
	stw 0,116(1)
	lis 9,gi+144@ha
	lis 3,.LC43@ha
	lwz 0,gi+144@l(9)
	lis 4,.LC44@ha
	li 5,0
	la 4,.LC44@l(4)
	la 3,.LC43@l(3)
	mtlr 0
	blrl
	lwz 4,4(3)
	addi 3,1,8
	bl strcpy
	lis 4,.LC45@ha
	addi 3,1,8
	la 4,.LC45@l(4)
	bl strcat
	lis 4,level+72@ha
	addi 3,1,8
	la 4,level+72@l(4)
	bl strcat
	lis 4,.LC46@ha
	addi 3,1,8
	la 4,.LC46@l(4)
	bl strcat
	lis 4,.LC50@ha
	addi 3,1,8
	la 4,.LC50@l(4)
	bl fopen
	mr. 28,3
	bc 12,2,.L223
	addi 3,1,72
	li 4,4
	li 5,1
	mr 6,28
	bl fread
	lwz 0,72(1)
	cmpwi 0,0,3
	bc 4,2,.L223
	lis 4,.LC52@ha
	li 3,1
	la 4,.LC52@l(4)
	lis 29,numnodes@ha
	crxor 6,6,6
	bl safe_bprintf
	lis 27,numnodes@ha
	li 4,4
	li 5,1
	mr 6,28
	la 3,numnodes@l(29)
	bl fread
	lis 3,num_items@ha
	li 4,4
	li 5,1
	mr 6,28
	la 3,num_items@l(3)
	bl fread
	lis 3,nodes@ha
	lwz 5,numnodes@l(29)
	li 4,116
	la 3,nodes@l(3)
	mr 6,28
	bl fread
	lwz 0,numnodes@l(29)
	li 11,0
	cmpw 0,11,0
	bc 4,0,.L225
	lis 9,path_table@ha
	la 26,path_table@l(9)
.L227:
	lwz 0,numnodes@l(27)
	li 31,0
	addi 30,11,1
	cmpw 0,31,0
	bc 4,0,.L226
	mulli 0,11,2400
	add 29,26,0
.L231:
	mr 3,29
	li 4,2
	li 5,1
	mr 6,28
	bl fread
	addi 31,31,1
	addi 29,29,2
	lwz 0,numnodes@l(27)
	cmpw 0,31,0
	bc 12,0,.L231
.L226:
	lwz 0,numnodes@l(27)
	mr 11,30
	cmpw 0,11,0
	bc 12,0,.L227
.L225:
	lis 9,num_items@ha
	lis 3,item_table@ha
	lwz 5,num_items@l(9)
	la 3,item_table@l(3)
	li 4,16
	mr 6,28
	bl fread
	mr 3,28
	bl fclose
	b .L234
.L223:
	lis 4,.LC51@ha
	li 3,1
	la 4,.LC51@l(4)
	crxor 6,6,6
	bl safe_bprintf
	li 3,0
	bl ACEIT_BuildItemNodeTable
	lis 4,.LC49@ha
	li 3,1
	la 4,.LC49@l(4)
	crxor 6,6,6
	bl safe_bprintf
	b .L221
.L234:
	lis 4,.LC49@ha
	li 3,1
	la 4,.LC49@l(4)
	crxor 6,6,6
	bl safe_bprintf
	li 3,1
	bl ACEIT_BuildItemNodeTable
.L221:
	lwz 0,116(1)
	mtlr 0
	lmw 26,88(1)
	la 1,112(1)
	blr
.Lfe13:
	.size	 ACEND_LoadNodes,.Lfe13-ACEND_LoadNodes
	.comm	nodes,139200,4
	.comm	numnodes,4,4
	.align 2
	.globl ACEND_FindCost
	.type	 ACEND_FindCost,@function
ACEND_FindCost:
	subfic 9,3,-1
	subfic 0,9,0
	adde 9,0,9
	li 10,1
	subfic 0,4,-1
	subfic 11,0,0
	adde 0,11,0
	or. 11,9,0
	bc 4,2,.L8
	mulli 0,3,2400
	lis 9,path_table@ha
	add 11,4,4
	la 9,path_table@l(9)
	add 0,11,0
	lhax 0,9,0
	cmpwi 0,0,-1
	bc 4,2,.L7
.L8:
	li 3,-1
	blr
.L7:
	cmpw 0,0,4
	bc 12,2,.L10
.L11:
	mulli 0,0,2400
	add 0,11,0
	lhax 0,9,0
	cmpwi 0,0,-1
	bc 12,2,.L8
	cmpw 0,0,4
	addi 10,10,1
	bc 4,2,.L11
.L10:
	mr 3,10
	blr
.Lfe14:
	.size	 ACEND_FindCost,.Lfe14-ACEND_FindCost
	.align 2
	.globl ACEND_SetGoal
	.type	 ACEND_SetGoal,@function
ACEND_SetGoal:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	li 5,99
	stw 4,964(31)
	li 4,288
	bl ACEND_FindClosestReachableNode
	mr 30,3
	cmpwi 0,30,-1
	bc 12,2,.L38
	lis 9,debug_mode@ha
	lwz 0,debug_mode@l(9)
	cmpwi 0,0,0
	bc 12,2,.L40
	lwz 4,84(31)
	lis 3,.LC10@ha
	mr 5,30
	la 3,.LC10@l(3)
	addi 4,4,700
	crxor 6,6,6
	bl debug_printf
.L40:
	li 0,0
	stw 30,968(31)
	stw 0,972(31)
	stw 30,960(31)
.L38:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe15:
	.size	 ACEND_SetGoal,.Lfe15-ACEND_SetGoal
	.align 2
	.globl ACEND_GrapFired
	.type	 ACEND_GrapFired,@function
ACEND_GrapFired:
	blr
.Lfe16:
	.size	 ACEND_GrapFired,.Lfe16-ACEND_GrapFired
	.section	".rodata"
	.align 2
.LC53:
	.long 0x0
	.section	".text"
	.align 2
	.globl ACEND_CheckForLadder
	.type	 ACEND_CheckForLadder,@function
ACEND_CheckForLadder:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi+52@ha
	mr 31,3
	lwz 0,gi+52@l(9)
	addi 3,31,4
	mtlr 0
	blrl
	andis. 0,3,8192
	bc 12,2,.L66
	lis 9,.LC53@ha
	lfs 13,384(31)
	la 9,.LC53@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L66
	mr 3,31
	li 4,96
	li 5,1
	bl ACEND_FindClosestReachableNode
	mr 30,3
	cmpwi 0,30,-1
	bc 4,2,.L67
	li 4,1
	mr 3,31
	bl ACEND_AddNode
	mr 30,3
.L67:
	lwz 4,976(31)
	mr 3,31
	mr 5,30
	bl ACEND_UpdateNodeEdge
	stw 30,976(31)
	li 3,1
	b .L237
.L66:
	li 3,0
.L237:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe17:
	.size	 ACEND_CheckForLadder,.Lfe17-ACEND_CheckForLadder
	.align 2
	.globl ACEND_InitNodes
	.type	 ACEND_InitNodes,@function
ACEND_InitNodes:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 0,1
	lis 9,numnodes@ha
	lis 11,numitemnodes@ha
	lis 3,nodes@ha
	stw 0,numnodes@l(9)
	lis 5,0x2
	li 4,0
	stw 0,numitemnodes@l(11)
	ori 5,5,8128
	la 3,nodes@l(3)
	crxor 6,6,6
	bl memset
	lis 3,path_table@ha
	lis 5,0x2b
	la 3,path_table@l(3)
	li 4,-1
	ori 5,5,61952
	bl memset
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe18:
	.size	 ACEND_InitNodes,.Lfe18-ACEND_InitNodes
	.align 2
	.globl ACEND_ShowPath
	.type	 ACEND_ShowPath,@function
ACEND_ShowPath:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,4
	li 5,99
	li 4,96
	bl ACEND_FindClosestReachableNode
	lis 9,show_path_from@ha
	lis 11,show_path_to@ha
	stw 3,show_path_from@l(9)
	stw 29,show_path_to@l(11)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 ACEND_ShowPath,.Lfe19-ACEND_ShowPath
	.align 2
	.globl ACEND_RemoveNodeEdge
	.type	 ACEND_RemoveNodeEdge,@function
ACEND_RemoveNodeEdge:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,debug_mode@ha
	mr 30,4
	lwz 0,debug_mode@l(9)
	mr 31,5
	cmpwi 0,0,0
	bc 12,2,.L181
	lwz 4,84(3)
	mr 5,30
	mr 6,31
	lis 3,.LC40@ha
	la 3,.LC40@l(3)
	addi 4,4,700
	crxor 6,6,6
	bl debug_printf
.L181:
	lis 11,numnodes@ha
	lis 9,path_table@ha
	mulli 4,30,2400
	lwz 11,numnodes@l(11)
	la 10,path_table@l(9)
	add 0,31,31
	add 0,0,4
	li 9,-1
	cmpwi 0,11,0
	sthx 9,10,0
	bc 4,1,.L183
	mtctr 11
	mr 9,10
	li 11,-1
.L185:
	lhax 0,4,9
	cmpw 0,0,31
	bc 4,2,.L184
	sthx 11,4,9
.L184:
	addi 4,4,2
	bdnz .L185
.L183:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe20:
	.size	 ACEND_RemoveNodeEdge,.Lfe20-ACEND_RemoveNodeEdge
	.comm	numitemnodes,4,4
	.comm	path_table,2880000,2
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
