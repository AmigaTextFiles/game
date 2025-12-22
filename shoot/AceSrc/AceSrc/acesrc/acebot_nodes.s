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
	.align 3
.LC0:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC1:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl ACEND_FindCloseReachableNode
	.type	 ACEND_FindCloseReachableNode,@function
ACEND_FindCloseReachableNode:
	stwu 1,-160(1)
	mflr 0
	mfcr 12
	stfd 30,144(1)
	stfd 31,152(1)
	stmw 21,100(1)
	stw 0,164(1)
	stw 12,96(1)
	lis 9,numnodes@ha
	li 29,0
	mullw 26,4,4
	lwz 0,numnodes@l(9)
	mr 31,3
	mr 27,5
	lis 21,numnodes@ha
	cmpw 0,29,0
	bc 4,0,.L15
	lis 9,gi@ha
	lis 11,nodes@ha
	la 22,gi@l(9)
	cmpwi 4,27,99
	lis 9,.LC0@ha
	la 11,nodes@l(11)
	la 9,.LC0@l(9)
	addi 23,11,8
	lfd 30,0(9)
	addi 24,11,4
	lis 25,0x4330
	lis 9,.LC1@ha
	li 30,0
	la 9,.LC1@l(9)
	addi 28,11,12
	lfd 31,0(9)
.L17:
	lis 9,nodes@ha
	slwi 7,29,4
	bc 12,18,.L19
	lwz 0,0(28)
	cmpw 0,27,0
	bc 4,2,.L16
.L19:
	lfs 0,8(31)
	la 11,nodes@l(9)
	xoris 0,26,0x8000
	lfsx 10,24,30
	lfsx 12,11,30
	stw 0,92(1)
	fsubs 10,10,0
	lfs 11,12(31)
	lfs 0,4(31)
	stw 25,88(1)
	lfd 13,88(1)
	fmuls 9,10,10
	fsubs 12,12,0
	lfsx 0,23,30
	fsub 13,13,30
	stfs 10,12(1)
	stfs 12,8(1)
	fsubs 0,0,11
	fmadds 12,12,12,9
	frsp 13,13
	stfs 0,16(1)
	fmadds 0,0,0,12
	fcmpu 0,0,13
	bc 4,0,.L16
	add 7,7,11
	addi 3,1,24
	lwz 11,48(22)
	addi 4,31,4
	addi 5,31,188
	addi 6,31,200
	mr 8,31
	li 9,25
	mtlr 11
	blrl
	lfs 0,32(1)
	fcmpu 0,0,31
	bc 4,2,.L16
	mr 3,29
	b .L23
.L16:
	lwz 0,numnodes@l(21)
	addi 29,29,1
	addi 30,30,16
	addi 28,28,16
	cmpw 0,29,0
	bc 12,0,.L17
.L15:
	li 3,-1
.L23:
	lwz 0,164(1)
	lwz 12,96(1)
	mtlr 0
	lmw 21,100(1)
	lfd 30,144(1)
	lfd 31,152(1)
	mtcrf 8,12
	la 1,160(1)
	blr
.Lfe1:
	.size	 ACEND_FindCloseReachableNode,.Lfe1-ACEND_FindCloseReachableNode
	.section	".rodata"
	.align 2
.LC2:
	.long 0x47c34f80
	.align 2
.LC3:
	.long 0x41900000
	.align 3
.LC4:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC5:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl ACEND_FindClosestReachableNode
	.type	 ACEND_FindClosestReachableNode,@function
ACEND_FindClosestReachableNode:
	stwu 1,-224(1)
	mflr 0
	mfcr 12
	stfd 28,192(1)
	stfd 29,200(1)
	stfd 30,208(1)
	stfd 31,216(1)
	stmw 22,152(1)
	stw 0,228(1)
	stw 12,148(1)
	mr 31,3
	mr 27,5
	lfs 9,196(31)
	cmpwi 0,27,1
	lis 9,.LC2@ha
	lfs 10,188(31)
	li 26,-1
	lfs 0,192(31)
	lfs 13,200(31)
	lfs 12,204(31)
	lfs 11,208(31)
	lfs 29,.LC2@l(9)
	stfs 10,104(1)
	stfs 0,108(1)
	stfs 13,88(1)
	stfs 12,92(1)
	stfs 11,96(1)
	stfs 9,112(1)
	bc 4,2,.L25
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
	b .L26
.L25:
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	lfs 0,0(9)
	fadds 0,9,0
	stfs 0,112(1)
.L26:
	mullw 0,4,4
	lis 8,0x4330
	lis 10,.LC4@ha
	lis 11,numnodes@ha
	xoris 0,0,0x8000
	la 10,.LC4@l(10)
	stw 0,140(1)
	li 29,0
	lis 22,numnodes@ha
	stw 8,136(1)
	lfd 13,0(10)
	lfd 0,136(1)
	lwz 10,numnodes@l(11)
	fsub 0,0,13
	cmpw 0,29,10
	frsp 28,0
	bc 4,0,.L28
	lis 9,gi@ha
	lis 11,nodes@ha
	la 23,gi@l(9)
	cmpwi 4,27,99
	lis 9,.LC5@ha
	la 11,nodes@l(11)
	la 9,.LC5@l(9)
	addi 24,11,8
	lfd 30,0(9)
	addi 25,11,4
	li 30,0
	addi 28,11,12
.L30:
	lis 9,nodes@ha
	slwi 7,29,4
	bc 12,18,.L32
	lwz 0,0(28)
	cmpw 0,27,0
	bc 4,2,.L29
.L32:
	lfs 13,8(31)
	la 11,nodes@l(9)
	lfsx 11,25,30
	lfs 12,4(31)
	lfsx 0,11,30
	fsubs 11,11,13
	lfs 10,12(31)
	lfsx 13,24,30
	fsubs 0,0,12
	fmuls 12,11,11
	stfs 11,12(1)
	fsubs 13,13,10
	stfs 0,8(1)
	fmadds 0,0,0,12
	stfs 13,16(1)
	fmadds 31,13,13,0
	fcmpu 7,31,29
	fcmpu 6,31,28
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,25,1
	and. 10,9,0
	bc 12,2,.L29
	add 7,7,11
	addi 3,1,24
	lwz 11,48(23)
	addi 4,31,4
	addi 5,1,104
	addi 6,1,88
	mr 8,31
	li 9,25
	mtlr 11
	blrl
	lfs 0,32(1)
	fcmpu 0,0,30
	bc 4,2,.L29
	fmr 29,31
	mr 26,29
.L29:
	lwz 0,numnodes@l(22)
	addi 29,29,1
	addi 30,30,16
	addi 28,28,16
	cmpw 0,29,0
	bc 12,0,.L30
.L28:
	mr 3,26
	lwz 0,228(1)
	lwz 12,148(1)
	mtlr 0
	lmw 22,152(1)
	lfd 28,192(1)
	lfd 29,200(1)
	lfd 30,208(1)
	lfd 31,216(1)
	mtcrf 8,12
	la 1,224(1)
	blr
.Lfe2:
	.size	 ACEND_FindClosestReachableNode,.Lfe2-ACEND_FindClosestReachableNode
	.section	".rodata"
	.align 2
.LC6:
	.string	"%s new start node selected %d\n"
	.align 2
.LC7:
	.string	"%s reached goal!\n"
	.align 2
.LC8:
	.long 0x42000000
	.section	".text"
	.align 2
	.globl ACEND_FollowPath
	.type	 ACEND_FollowPath,@function
ACEND_FollowPath:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,936(31)
	mr 0,9
	cmpwi 0,0,30
	addi 9,9,1
	stw 9,936(31)
	bc 4,1,.L40
	lwz 9,944(31)
	mr 0,9
	cmpwi 0,0,3
	addi 9,9,1
	stw 9,944(31)
	li 3,0
	bc 12,1,.L52
	mr 3,31
	li 4,384
	li 5,99
	bl ACEND_FindClosestReachableNode
	mr 30,3
	cmpwi 0,30,-1
	bc 12,2,.L40
	lis 9,debug_mode@ha
	lwz 0,debug_mode@l(9)
	cmpwi 0,0,0
	bc 12,2,.L45
	lwz 4,84(31)
	lis 3,.LC6@ha
	mr 5,30
	la 3,.LC6@l(3)
	addi 4,4,700
	crxor 6,6,6
	bl debug_printf
.L45:
	li 0,0
	stw 30,932(31)
	stw 0,936(31)
	stw 30,924(31)
.L40:
	lwz 0,932(31)
	lis 9,nodes@ha
	addi 3,1,8
	la 9,nodes@l(9)
	lfs 10,4(31)
	slwi 0,0,4
	addi 10,9,8
	lfs 13,8(31)
	addi 11,9,4
	lfsx 11,9,0
	lfsx 9,10,0
	lfsx 12,11,0
	lfs 0,12(31)
	fsubs 10,10,11
	fsubs 13,13,12
	fsubs 0,0,9
	stfs 10,8(1)
	stfs 13,12(1)
	stfs 0,16(1)
	bl VectorLength
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L46
	lwz 8,932(31)
	li 0,0
	lwz 11,928(31)
	stw 0,936(31)
	cmpw 0,8,11
	bc 4,2,.L47
	lis 9,debug_mode@ha
	lwz 0,debug_mode@l(9)
	cmpwi 0,0,0
	bc 12,2,.L48
	lwz 4,84(31)
	lis 3,.LC7@ha
	la 3,.LC7@l(3)
	addi 4,4,700
	crxor 6,6,6
	bl debug_printf
.L48:
	mr 3,31
	bl ACEAI_PickLongRangeGoal
	b .L46
.L47:
	mulli 10,8,2000
	add 11,11,11
	lis 9,path_table@ha
	stw 8,924(31)
	la 9,path_table@l(9)
	add 11,11,10
	lhax 0,9,11
	stw 0,932(31)
.L46:
	lwz 0,924(31)
	cmpwi 0,0,-1
	bc 12,2,.L51
	lwz 0,932(31)
	cmpwi 0,0,-1
	bc 4,2,.L50
.L51:
	li 3,0
	b .L52
.L50:
	lis 9,nodes@ha
	slwi 0,0,4
	lfs 0,4(31)
	la 9,nodes@l(9)
	lfs 11,8(31)
	li 3,1
	lfsx 13,9,0
	addi 11,9,4
	addi 9,9,8
	lfs 12,12(31)
	fsubs 13,13,0
	stfs 13,900(31)
	lfsx 0,11,0
	fsubs 0,0,11
	stfs 0,904(31)
	lfsx 13,9,0
	fsubs 13,13,12
	stfs 13,908(31)
.L52:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 ACEND_FollowPath,.Lfe3-ACEND_FollowPath
	.section	".sdata","aw"
	.align 2
	.type	 last_update.27,@object
	.size	 last_update.27,4
last_update.27:
	.long 0x0
	.section	".rodata"
	.align 3
.LC9:
	.long 0x3fc33333
	.long 0x33333333
	.align 2
.LC10:
	.long 0x0
	.align 2
.LC11:
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
	lis 9,level+4@ha
	lis 10,last_update.27@ha
	lfs 13,level+4@l(9)
	mr 30,3
	lfs 0,last_update.27@l(10)
	fcmpu 0,13,0
	bc 12,0,.L62
	fmr 0,13
	lis 9,.LC9@ha
	lis 11,show_path_to@ha
	lfd 13,.LC9@l(9)
	lwz 0,show_path_to@l(11)
	fadd 0,0,13
	cmpwi 0,0,-1
	frsp 0,0
	stfs 0,last_update.27@l(10)
	bc 12,2,.L64
	bl ACEND_DrawPath
.L64:
	lis 9,gi+52@ha
	addi 3,30,4
	lwz 0,gi+52@l(9)
	mtlr 0
	blrl
	andis. 0,3,8192
	bc 12,2,.L66
	lis 9,.LC10@ha
	lfs 13,384(30)
	la 9,.LC10@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L66
	mr 3,30
	li 4,128
	li 5,1
	bl ACEND_FindClosestReachableNode
	mr 31,3
	cmpwi 0,31,-1
	bc 4,2,.L67
	li 4,1
	mr 3,30
	bl ACEND_AddNode
	mr 31,3
.L67:
	lwz 3,940(30)
	mr 4,31
	bl ACEND_UpdateNodeEdge
	stw 31,940(30)
	li 0,1
	b .L69
.L66:
	li 0,0
.L69:
	cmpwi 0,0,0
	bc 4,2,.L62
	lwz 0,552(30)
	cmpwi 0,0,0
	bc 4,2,.L70
	lwz 0,612(30)
	cmpwi 0,0,0
	bc 12,2,.L62
.L70:
	lis 9,.LC11@ha
	lfs 12,12(30)
	addi 3,1,8
	la 9,.LC11@l(9)
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
	bc 4,2,.L62
	lwz 0,896(30)
	cmpwi 0,0,0
	bc 12,2,.L72
	mr 3,30
	li 4,64
	li 5,7
	bl ACEND_FindClosestReachableNode
	mr 31,3
	cmpwi 0,31,-1
	bc 4,2,.L73
	mr 3,30
	li 4,7
	bl ACEND_AddNode
	mr 31,3
.L73:
	lwz 3,940(30)
	cmpwi 0,3,-1
	bc 12,2,.L74
	mr 4,31
	bl ACEND_UpdateNodeEdge
.L74:
	stw 29,896(30)
	b .L62
.L72:
	lis 9,.LC10@ha
	lis 11,ctf@ha
	la 9,.LC10@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L75
	lwz 9,84(30)
	lwz 0,3836(9)
	cmpwi 0,0,1
	bc 12,2,.L62
.L75:
	mr 3,30
	li 4,128
	li 5,99
	bl ACEND_FindClosestReachableNode
	lwz 9,552(30)
	mr 31,3
	cmpwi 0,9,0
	bc 12,2,.L76
	lwz 0,448(9)
	lis 9,Use_Plat@ha
	la 9,Use_Plat@l(9)
	cmpw 0,0,9
	bc 4,2,.L76
	cmpwi 0,31,-1
	bc 12,2,.L62
	b .L79
.L76:
	cmpwi 0,31,-1
	bc 4,2,.L79
	lwz 0,612(30)
	cmpwi 0,0,0
	bc 12,2,.L80
	mr 3,30
	li 4,5
	b .L85
.L80:
	mr 3,30
	li 4,0
.L85:
	bl ACEND_AddNode
	mr 31,3
	lwz 3,940(30)
	cmpwi 0,3,-1
	bc 12,2,.L83
	mr 4,31
	bl ACEND_UpdateNodeEdge
	b .L83
.L79:
	lwz 3,940(30)
	cmpw 0,31,3
	bc 12,2,.L83
	cmpwi 0,3,-1
	bc 12,2,.L83
	mr 4,31
	bl ACEND_UpdateNodeEdge
.L83:
	stw 31,940(30)
.L62:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 ACEND_PathMap,.Lfe4-ACEND_PathMap
	.section	".rodata"
	.align 2
.LC12:
	.string	"models/items/ammo/grenades/medium/tris.md2"
	.section	".text"
	.align 2
	.globl ACEND_ShowNode
	.type	 ACEND_ShowNode,@function
ACEND_ShowNode:
	blr
.Lfe5:
	.size	 ACEND_ShowNode,.Lfe5-ACEND_ShowNode
	.align 2
	.globl ACEND_DrawPath
	.type	 ACEND_DrawPath,@function
ACEND_DrawPath:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	lis 10,show_path_from@ha
	lis 9,show_path_to@ha
	lwz 27,show_path_to@l(9)
	lis 11,path_table@ha
	lwz 31,show_path_from@l(10)
	la 6,path_table@l(11)
	add 7,27,27
	xor 10,31,27
	nor 8,31,31
	mulli 9,31,2000
	addic 0,10,-1
	subfe 11,0,10
	addic 10,8,-1
	subfe 0,10,8
	add 9,7,9
	and. 10,11,0
	lhax 30,6,9
	bc 12,2,.L95
	lis 9,gi@ha
	lis 11,nodes@ha
	la 28,gi@l(9)
	la 26,nodes@l(11)
	mr 24,6
	mr 25,7
.L96:
	lwz 9,100(28)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(28)
	li 3,23
	mtlr 9
	blrl
	lwz 9,120(28)
	slwi 29,31,4
	add 29,29,26
	mr 31,30
	mr 3,29
	mtlr 9
	blrl
	lwz 9,120(28)
	slwi 3,30,4
	add 3,3,26
	mtlr 9
	blrl
	lwz 9,88(28)
	mr 3,29
	li 4,2
	mtlr 9
	blrl
	xor 10,31,27
	nor 8,31,31
	mulli 9,31,2000
	addic 0,10,-1
	subfe 11,0,10
	addic 10,8,-1
	subfe 0,10,8
	add 9,25,9
	and. 10,11,0
	lhax 30,24,9
	bc 4,2,.L96
.L95:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 ACEND_DrawPath,.Lfe6-ACEND_DrawPath
	.section	".rodata"
	.align 2
.LC14:
	.string	"Node added %d type: Ladder\n"
	.align 2
.LC15:
	.string	"Node added %d type: Platform\n"
	.align 2
.LC16:
	.string	"Node added %d type: Move\n"
	.align 2
.LC17:
	.string	"Node added %d type: Teleporter\n"
	.align 2
.LC18:
	.string	"Node added %d type: Item\n"
	.align 2
.LC19:
	.string	"Node added %d type: Water\n"
	.align 2
.LC20:
	.string	"Node added %d type: Grapple\n"
	.align 2
.LC21:
	.long 0x41800000
	.align 2
.LC22:
	.long 0x42000000
	.align 2
.LC23:
	.long 0x3f000000
	.align 2
.LC24:
	.long 0x42800000
	.section	".text"
	.align 2
	.globl ACEND_AddNode
	.type	 ACEND_AddNode,@function
ACEND_AddNode:
	stwu 1,-80(1)
	mflr 0
	stmw 24,48(1)
	stw 0,84(1)
	lis 9,numnodes@ha
	mr 31,3
	lwz 11,numnodes@l(9)
	mr 30,4
	lis 29,numnodes@ha
	addi 0,11,1
	cmpwi 0,0,1000
	bc 4,1,.L100
	li 3,0
	b .L118
.L100:
	lfs 0,4(31)
	lis 9,nodes@ha
	slwi 0,11,4
	la 28,nodes@l(9)
	cmpwi 0,30,4
	addi 26,28,4
	addi 25,28,12
	stfsx 0,28,0
	addi 27,28,8
	lfs 0,8(31)
	stfsx 0,26,0
	lfs 13,12(31)
	stwx 30,25,0
	stfsx 13,27,0
	bc 4,2,.L101
	lis 9,.LC21@ha
	lis 11,numitemnodes@ha
	la 9,.LC21@l(9)
	lfs 0,0(9)
	lwz 9,numitemnodes@l(11)
	fadds 0,13,0
	addi 9,9,1
	stw 9,numitemnodes@l(11)
	stfsx 0,27,0
.L101:
	cmpwi 0,30,3
	bc 4,2,.L102
	lwz 0,numnodes@l(29)
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	slwi 0,0,4
	lfs 13,0(9)
	lfsx 0,27,0
	fadds 0,0,13
	stfsx 0,27,0
.L102:
	cmpwi 0,30,1
	bc 4,2,.L103
	lis 9,debug_mode@ha
	lwz 4,numnodes@l(29)
	lwz 0,debug_mode@l(9)
	slwi 11,4,4
	cmpwi 0,0,0
	stwx 30,25,11
	bc 12,2,.L107
	lis 3,.LC14@ha
	la 3,.LC14@l(3)
	b .L120
.L103:
	cmpwi 0,30,2
	bc 4,2,.L105
	lfs 11,188(31)
	lis 9,.LC23@ha
	lis 24,debug_mode@ha
	lfs 7,200(31)
	la 9,.LC23@l(9)
	lfs 12,192(31)
	lfs 6,204(31)
	lfs 8,0(9)
	fsubs 0,7,11
	lwz 3,numnodes@l(29)
	fsubs 13,6,12
	lfs 10,208(31)
	fmadds 0,0,8,11
	lfs 9,196(31)
	slwi 0,3,4
	lwz 9,debug_mode@l(24)
	fmadds 13,13,8,12
	stfs 10,16(1)
	stfsx 0,28,0
	cmpwi 0,9,0
	stfs 9,32(1)
	stfsx 13,26,0
	lfs 0,208(31)
	stfs 7,8(1)
	stfs 6,12(1)
	stfsx 0,27,0
	stfs 11,24(1)
	stfs 12,28(1)
	bc 12,2,.L106
	bl ACEND_ShowNode
.L106:
	lwz 4,numnodes@l(29)
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	slwi 11,4,4
	addi 0,4,1
	lfs 12,0(9)
	lfsx 0,28,11
	slwi 9,0,4
	mr 3,0
	stw 0,numnodes@l(29)
	stfsx 0,28,9
	lfsx 13,26,11
	stfsx 13,26,9
	lfs 0,196(31)
	stwx 30,25,9
	fadds 0,0,12
	stfsx 0,27,9
	bl ACEND_UpdateNodeEdge
	lwz 0,debug_mode@l(24)
	cmpwi 0,0,0
	bc 12,2,.L107
	lis 3,.LC15@ha
	lwz 4,numnodes@l(29)
	la 3,.LC15@l(3)
.L120:
	crxor 6,6,6
	bl debug_printf
	lwz 3,numnodes@l(29)
	bl ACEND_ShowNode
.L107:
	lwz 3,numnodes@l(29)
	addi 0,3,1
	stw 0,numnodes@l(29)
	b .L118
.L105:
	lis 9,debug_mode@ha
	lwz 0,debug_mode@l(9)
	cmpwi 0,0,0
	bc 12,2,.L108
	lwz 4,numnodes@l(29)
	slwi 0,4,4
	lwzx 0,25,0
	cmpwi 0,0,0
	bc 4,2,.L109
	lis 3,.LC16@ha
	la 3,.LC16@l(3)
	crxor 6,6,6
	bl debug_printf
	b .L110
.L109:
	cmpwi 0,0,3
	bc 4,2,.L111
	lis 3,.LC17@ha
	la 3,.LC17@l(3)
	crxor 6,6,6
	bl debug_printf
	b .L110
.L111:
	cmpwi 0,0,4
	bc 4,2,.L113
	lis 3,.LC18@ha
	la 3,.LC18@l(3)
	crxor 6,6,6
	bl debug_printf
	b .L110
.L113:
	cmpwi 0,0,5
	bc 4,2,.L115
	lis 3,.LC19@ha
	la 3,.LC19@l(3)
	crxor 6,6,6
	bl debug_printf
	b .L110
.L115:
	cmpwi 0,0,6
	bc 4,2,.L110
	lis 3,.LC20@ha
	la 3,.LC20@l(3)
	crxor 6,6,6
	bl debug_printf
.L110:
	lis 9,numnodes@ha
	lwz 3,numnodes@l(9)
	bl ACEND_ShowNode
.L108:
	lis 9,numnodes@ha
	lwz 3,numnodes@l(9)
	addi 0,3,1
	stw 0,numnodes@l(9)
.L118:
	lwz 0,84(1)
	mtlr 0
	lmw 24,48(1)
	la 1,80(1)
	blr
.Lfe7:
	.size	 ACEND_AddNode,.Lfe7-ACEND_AddNode
	.section	".rodata"
	.align 2
.LC25:
	.string	"Link %d -> %d\n"
	.align 2
.LC26:
	.string	"%s: Removing Edge %d -> %d\n"
	.align 2
.LC27:
	.string	"Resolving all paths..."
	.align 2
.LC28:
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
	lis 4,.LC27@ha
	li 3,2
	la 4,.LC27@l(4)
	li 26,0
	crxor 6,6,6
	bl safe_bprintf
	lis 9,numnodes@ha
	li 4,0
	lwz 0,numnodes@l(9)
	cmpw 0,26,0
	bc 4,0,.L143
	mr 27,0
	lis 22,path_table@ha
	mr 23,27
.L145:
	li 7,0
	addi 25,4,1
	cmpw 0,7,27
	bc 4,0,.L144
	lis 9,numnodes@ha
	la 24,path_table@l(22)
	mulli 28,4,2000
	lwz 29,numnodes@l(9)
	mr 31,24
	mr 5,23
	add 30,4,4
.L149:
	cmpw 0,4,7
	addi 12,7,1
	bc 12,2,.L148
	add 11,7,7
	add 0,11,28
	lhax 9,24,0
	cmpw 0,9,7
	bc 4,2,.L148
	li 8,0
	addi 26,26,1
	cmpw 0,8,5
	bc 4,0,.L148
	add 11,11,31
	li 3,-1
	mr 6,29
	add 10,30,31
.L154:
	lhz 9,0(10)
	addi 10,10,2000
	extsh 0,9
	cmpwi 0,0,-1
	bc 12,2,.L153
	cmpw 0,8,7
	bc 4,2,.L156
	sth 3,0(11)
	b .L153
.L156:
	sth 9,0(11)
.L153:
	addi 8,8,1
	addi 11,11,2000
	cmpw 0,8,6
	bc 12,0,.L154
.L148:
	mr 7,12
	cmpw 0,7,5
	bc 12,0,.L149
.L144:
	mr 4,25
	cmpw 0,4,27
	bc 12,0,.L145
.L143:
	lis 4,.LC28@ha
	mr 5,26
	la 4,.LC28@l(4)
	li 3,1
	crxor 6,6,6
	bl safe_bprintf
	lwz 0,52(1)
	mtlr 0
	lmw 22,8(1)
	la 1,48(1)
	blr
.Lfe8:
	.size	 ACEND_ResolveAllPaths,.Lfe8-ACEND_ResolveAllPaths
	.section	".rodata"
	.align 2
.LC29:
	.string	"Saving node table..."
	.align 2
.LC30:
	.string	"ace/nav/"
	.align 2
.LC31:
	.string	".nod"
	.align 2
.LC32:
	.string	"wb"
	.align 2
.LC33:
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
	li 0,1
	addi 29,1,8
	stw 0,72(1)
	bl ACEND_ResolveAllPaths
	lis 4,.LC29@ha
	li 3,1
	la 4,.LC29@l(4)
	crxor 6,6,6
	bl safe_bprintf
	lis 9,.LC30@ha
	lis 4,level+72@ha
	lwz 10,.LC30@l(9)
	la 4,level+72@l(4)
	mr 3,29
	la 9,.LC30@l(9)
	lbz 11,8(9)
	lwz 0,4(9)
	stw 10,8(1)
	stw 0,4(29)
	stb 11,8(29)
	bl strcat
	lis 4,.LC31@ha
	mr 3,29
	la 4,.LC31@l(4)
	bl strcat
	lis 4,.LC32@ha
	mr 3,29
	la 4,.LC32@l(4)
	bl fopen
	mr. 30,3
	bc 12,2,.L161
	addi 3,1,72
	li 4,4
	li 5,1
	mr 6,30
	bl fwrite
	lis 29,numnodes@ha
	lis 27,numnodes@ha
	li 4,4
	li 5,1
	mr 6,30
	la 3,numnodes@l(29)
	bl fwrite
	lis 3,num_items@ha
	li 4,4
	li 5,1
	mr 6,30
	la 3,num_items@l(3)
	bl fwrite
	lis 3,nodes@ha
	lwz 5,numnodes@l(29)
	li 4,16
	la 3,nodes@l(3)
	mr 6,30
	bl fwrite
	lwz 0,numnodes@l(29)
	li 11,0
	cmpw 0,11,0
	bc 4,0,.L164
	lis 9,path_table@ha
	la 26,path_table@l(9)
.L166:
	lwz 0,numnodes@l(27)
	li 31,0
	addi 28,11,1
	cmpw 0,31,0
	bc 4,0,.L165
	mulli 0,11,2000
	add 29,26,0
.L170:
	mr 3,29
	li 4,2
	li 5,1
	mr 6,30
	bl fwrite
	addi 31,31,1
	addi 29,29,2
	lwz 0,numnodes@l(27)
	cmpw 0,31,0
	bc 12,0,.L170
.L165:
	lwz 0,numnodes@l(27)
	mr 11,28
	cmpw 0,11,0
	bc 12,0,.L166
.L164:
	lis 9,num_items@ha
	lis 3,item_table@ha
	lwz 5,num_items@l(9)
	li 4,16
	mr 6,30
	la 3,item_table@l(3)
	bl fwrite
	mr 3,30
	bl fclose
	lis 4,.LC33@ha
	li 3,1
	la 4,.LC33@l(4)
	crxor 6,6,6
	bl safe_bprintf
.L161:
	lwz 0,116(1)
	mtlr 0
	lmw 26,88(1)
	la 1,112(1)
	blr
.Lfe9:
	.size	 ACEND_SaveNodes,.Lfe9-ACEND_SaveNodes
	.section	".rodata"
	.align 2
.LC34:
	.string	"rb"
	.align 2
.LC35:
	.string	"ACE: No node file found, creating new one..."
	.align 2
.LC36:
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
	lis 9,.LC30@ha
	addi 29,1,8
	lwz 10,.LC30@l(9)
	lis 4,level+72@ha
	mr 3,29
	la 9,.LC30@l(9)
	la 4,level+72@l(4)
	lbz 11,8(9)
	lwz 0,4(9)
	stw 10,8(1)
	stw 0,4(29)
	stb 11,8(29)
	bl strcat
	lis 4,.LC31@ha
	mr 3,29
	la 4,.LC31@l(4)
	bl strcat
	lis 4,.LC34@ha
	mr 3,29
	la 4,.LC34@l(4)
	bl fopen
	mr. 28,3
	bc 12,2,.L175
	addi 3,1,72
	li 4,4
	li 5,1
	mr 6,28
	bl fread
	lwz 0,72(1)
	cmpwi 0,0,1
	bc 4,2,.L175
	lis 4,.LC36@ha
	li 3,1
	la 4,.LC36@l(4)
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
	li 4,16
	la 3,nodes@l(3)
	mr 6,28
	bl fread
	lwz 0,numnodes@l(29)
	li 11,0
	cmpw 0,11,0
	bc 4,0,.L177
	lis 9,path_table@ha
	la 26,path_table@l(9)
.L179:
	lwz 0,numnodes@l(27)
	li 31,0
	addi 30,11,1
	cmpw 0,31,0
	bc 4,0,.L178
	mulli 0,11,2000
	add 29,26,0
.L183:
	mr 3,29
	li 4,2
	li 5,1
	mr 6,28
	bl fread
	addi 31,31,1
	addi 29,29,2
	lwz 0,numnodes@l(27)
	cmpw 0,31,0
	bc 12,0,.L183
.L178:
	lwz 0,numnodes@l(27)
	mr 11,30
	cmpw 0,11,0
	bc 12,0,.L179
.L177:
	lis 9,num_items@ha
	lis 3,item_table@ha
	lwz 5,num_items@l(9)
	la 3,item_table@l(3)
	li 4,16
	mr 6,28
	bl fread
	mr 3,28
	bl fclose
	b .L186
.L175:
	lis 4,.LC35@ha
	li 3,1
	la 4,.LC35@l(4)
	crxor 6,6,6
	bl safe_bprintf
	li 3,0
	bl ACEIT_BuildItemNodeTable
	lis 4,.LC33@ha
	li 3,1
	la 4,.LC33@l(4)
	crxor 6,6,6
	bl safe_bprintf
	b .L173
.L186:
	lis 4,.LC33@ha
	li 3,1
	la 4,.LC33@l(4)
	crxor 6,6,6
	bl safe_bprintf
	li 3,1
	bl ACEIT_BuildItemNodeTable
.L173:
	lwz 0,116(1)
	mtlr 0
	lmw 26,88(1)
	la 1,112(1)
	blr
.Lfe10:
	.size	 ACEND_LoadNodes,.Lfe10-ACEND_LoadNodes
	.comm	nodes,16000,4
	.comm	numnodes,4,4
	.align 2
	.globl ACEND_FindCost
	.type	 ACEND_FindCost,@function
ACEND_FindCost:
	mulli 3,3,2000
	lis 9,path_table@ha
	add 10,4,4
	la 9,path_table@l(9)
	li 11,1
	add 3,10,3
	lhax 0,9,3
	cmpwi 0,0,-1
	bc 4,2,.L7
.L189:
	li 3,-1
	blr
.L7:
	cmpw 0,0,4
	bc 12,2,.L9
	mr 3,10
.L10:
	mulli 0,0,2000
	add 0,3,0
	lhax 0,9,0
	cmpwi 0,0,-1
	bc 12,2,.L189
	cmpw 0,0,4
	addi 11,11,1
	bc 4,2,.L10
.L9:
	mr 3,11
	blr
.Lfe11:
	.size	 ACEND_FindCost,.Lfe11-ACEND_FindCost
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
	stw 4,928(31)
	li 4,384
	bl ACEND_FindClosestReachableNode
	mr 30,3
	cmpwi 0,30,-1
	bc 12,2,.L36
	lis 9,debug_mode@ha
	lwz 0,debug_mode@l(9)
	cmpwi 0,0,0
	bc 12,2,.L38
	lwz 4,84(31)
	lis 3,.LC6@ha
	mr 5,30
	la 3,.LC6@l(3)
	addi 4,4,700
	crxor 6,6,6
	bl debug_printf
.L38:
	li 0,0
	stw 30,932(31)
	stw 0,936(31)
	stw 30,924(31)
.L36:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 ACEND_SetGoal,.Lfe12-ACEND_SetGoal
	.align 2
	.globl ACEND_GrapFired
	.type	 ACEND_GrapFired,@function
ACEND_GrapFired:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 30,3
	lwz 9,256(30)
	cmpwi 0,9,0
	bc 12,2,.L53
	lwz 9,84(9)
	lwz 0,3836(9)
	cmpwi 0,0,1
	bc 4,2,.L53
	li 4,128
	li 5,6
	bl ACEND_FindClosestReachableNode
	mr 31,3
	cmpwi 0,31,-1
	bc 4,2,.L56
	li 4,6
	mr 3,30
	bl ACEND_AddNode
	lwz 9,256(30)
	mr 31,3
	mr 4,31
	lwz 3,940(9)
	bl ACEND_UpdateNodeEdge
.L56:
	lwz 9,256(30)
	stw 31,940(9)
.L53:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe13:
	.size	 ACEND_GrapFired,.Lfe13-ACEND_GrapFired
	.section	".rodata"
	.align 2
.LC37:
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
	mr 30,3
	lwz 0,gi+52@l(9)
	addi 3,30,4
	mtlr 0
	blrl
	andis. 0,3,8192
	bc 12,2,.L59
	lis 9,.LC37@ha
	lfs 13,384(30)
	la 9,.LC37@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L59
	mr 3,30
	li 4,128
	li 5,1
	bl ACEND_FindClosestReachableNode
	mr 31,3
	cmpwi 0,31,-1
	bc 4,2,.L60
	li 4,1
	mr 3,30
	bl ACEND_AddNode
	mr 31,3
.L60:
	lwz 3,940(30)
	mr 4,31
	bl ACEND_UpdateNodeEdge
	stw 31,940(30)
	li 3,1
	b .L190
.L59:
	li 3,0
.L190:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe14:
	.size	 ACEND_CheckForLadder,.Lfe14-ACEND_CheckForLadder
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
	li 4,0
	li 5,16000
	stw 0,numitemnodes@l(11)
	la 3,nodes@l(3)
	crxor 6,6,6
	bl memset
	lis 3,path_table@ha
	lis 5,0x1e
	la 3,path_table@l(3)
	li 4,-1
	ori 5,5,33920
	bl memset
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe15:
	.size	 ACEND_InitNodes,.Lfe15-ACEND_InitNodes
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
	li 4,128
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
.Lfe16:
	.size	 ACEND_ShowPath,.Lfe16-ACEND_ShowPath
	.align 2
	.globl ACEND_UpdateNodeEdge
	.type	 ACEND_UpdateNodeEdge,@function
ACEND_UpdateNodeEdge:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 7,3
	mr 5,4
	subfic 9,7,-1
	subfic 0,9,0
	adde 9,0,9
	subfic 0,5,-1
	subfic 11,0,0
	adde 0,11,0
	or. 11,9,0
	bc 4,2,.L121
	cmpw 0,7,5
	bc 12,2,.L121
	lis 9,numnodes@ha
	mulli 0,7,2000
	li 8,0
	lwz 10,numnodes@l(9)
	lis 11,path_table@ha
	add 9,5,5
	la 11,path_table@l(11)
	cmpw 0,8,10
	add 0,9,0
	sthx 5,11,0
	bc 4,0,.L125
	add 0,7,7
	mr 6,10
	add 10,0,11
	li 4,-1
	add 11,9,11
.L127:
	lhz 9,0(10)
	addi 10,10,2000
	extsh 0,9
	cmpwi 0,0,-1
	bc 12,2,.L126
	cmpw 0,8,5
	bc 4,2,.L129
	sth 4,0(11)
	b .L126
.L129:
	sth 9,0(11)
.L126:
	addi 8,8,1
	addi 11,11,2000
	cmpw 0,8,6
	bc 12,0,.L127
.L125:
	lis 9,debug_mode@ha
	lwz 0,debug_mode@l(9)
	cmpwi 0,0,0
	bc 12,2,.L121
	lis 3,.LC25@ha
	mr 4,7
	la 3,.LC25@l(3)
	crxor 6,6,6
	bl debug_printf
.L121:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe17:
	.size	 ACEND_UpdateNodeEdge,.Lfe17-ACEND_UpdateNodeEdge
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
	bc 12,2,.L134
	lwz 4,84(3)
	mr 5,30
	mr 6,31
	lis 3,.LC26@ha
	la 3,.LC26@l(3)
	addi 4,4,700
	crxor 6,6,6
	bl debug_printf
.L134:
	lis 11,numnodes@ha
	lis 9,path_table@ha
	mulli 4,30,2000
	lwz 11,numnodes@l(11)
	la 10,path_table@l(9)
	add 0,31,31
	add 0,0,4
	li 9,-1
	cmpwi 0,11,0
	sthx 9,10,0
	bc 4,1,.L136
	mtctr 11
	mr 9,10
	li 11,-1
.L138:
	lhax 0,4,9
	cmpw 0,0,31
	bc 4,2,.L137
	sthx 11,4,9
.L137:
	addi 4,4,2
	bdnz .L138
.L136:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe18:
	.size	 ACEND_RemoveNodeEdge,.Lfe18-ACEND_RemoveNodeEdge
	.comm	numitemnodes,4,4
	.comm	path_table,2000000,2
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
