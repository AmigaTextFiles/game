	.file	"s_ptele.c"
gcc2_compiled.:
	.section	".rodata"
	.align 3
.LC0:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC1:
	.long 0x43c80000
	.section	".text"
	.align 2
	.globl findspawnpoint
	.type	 findspawnpoint,@function
findspawnpoint:
	stwu 1,-208(1)
	mflr 0
	stfd 31,200(1)
	stmw 17,140(1)
	stw 0,212(1)
	mr 28,3
	mr 25,4
	addi 3,1,8
	mr 20,5
	mr 18,3
	li 4,0
	li 5,12
	lis 23,0x3ff
	crxor 6,6,6
	bl memset
	addi 22,18,8
	li 21,0
	lis 9,.LC0@ha
	li 24,0
	la 9,.LC0@l(9)
	lis 17,gi@ha
	lfd 31,0(9)
	ori 23,23,57345
	lis 19,0x4330
.L11:
	addi 21,21,1
	mr 31,18
.L16:
	bl rand
	mulhw 9,3,23
	srawi 11,3,31
	srawi 9,9,7
	subf 9,11,9
	slwi 0,9,13
	add 0,0,9
	subf 3,0,3
	addi 3,3,-4096
	xoris 3,3,0x8000
	stw 3,132(1)
	stw 19,128(1)
	lfd 0,128(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,0(31)
	addi 31,31,4
	cmpw 0,31,22
	bc 4,1,.L16
	la 30,gi@l(17)
	addi 3,1,8
	lwz 9,52(30)
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 4,2,.L18
	lwz 11,48(30)
	addi 27,1,56
	addi 26,28,200
	addi 29,28,188
	lfs 0,8(1)
	li 9,59
	lfs 13,12(1)
	mr 3,27
	addi 4,1,8
	mtlr 11
	mr 5,26
	mr 6,29
	addi 7,1,24
	li 8,0
	stfs 0,24(1)
	lis 0,0xc580
	stfs 13,28(1)
	addi 24,24,1
	stw 0,32(1)
	blrl
	lwz 0,104(1)
	andi. 9,0,56
	bc 4,2,.L18
	lfs 0,196(28)
	addi 3,1,8
	lfs 13,208(28)
	lfs 12,76(1)
	lwz 9,52(30)
	fsubs 13,13,0
	lfs 11,72(1)
	lfs 0,68(1)
	mtlr 9
	fadds 12,12,13
	stfs 11,12(1)
	stfs 0,8(1)
	stfs 12,16(1)
	blrl
	subfic 0,3,0
	adde. 31,0,3
	bc 12,2,.L10
	lfs 11,4(25)
	addi 3,1,40
	lfs 12,8(1)
	lfs 10,8(25)
	lfs 13,12(1)
	fsubs 12,12,11
	lfs 0,16(1)
	lfs 11,12(25)
	fsubs 13,13,10
	stfs 12,40(1)
	fsubs 0,0,11
	stfs 13,44(1)
	stfs 0,48(1)
	bl VectorLength
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,1,.L22
	li 31,0
.L22:
	lwz 0,48(30)
	addi 4,1,8
	lis 9,0x201
	mr 3,27
	mr 5,29
	mtlr 0
	mr 6,26
	mr 7,4
	li 8,0
	ori 9,9,3
	blrl
	lwz 0,108(1)
	addic 0,0,-1
	subfe 0,0,0
	and 31,31,0
	b .L10
.L18:
	li 31,0
.L10:
	cmpwi 0,31,0
	cmpwi 7,21,1000
	mcrf 1,0
	mfcr 0
	rlwinm 9,0,3,1
	rlwinm 0,0,29,1
	mcrf 6,7
	and. 11,9,0
	bc 12,2,.L9
	cmpwi 0,24,500
	bc 4,0,.L9
	addic 0,31,-1
	subfe 9,0,31
	cror 27,26,25
	mfcr 0
	rlwinm 0,0,28,1
	or. 11,9,0
	bc 12,2,.L11
.L9:
	bc 4,6,.L28
	cmpwi 7,24,500
	cror 27,26,25
	cror 31,30,29
	mfcr 0
	rlwinm 9,0,28,1
	rlwinm 0,0,0,1
	or. 11,9,0
	bc 12,2,.L28
	li 3,0
	b .L29
.L28:
	lfs 0,8(1)
	li 3,1
	lfs 12,12(1)
	lfs 13,16(1)
	stfs 0,0(20)
	stfs 12,4(20)
	stfs 13,8(20)
.L29:
	lwz 0,212(1)
	mtlr 0
	lmw 17,140(1)
	lfd 31,200(1)
	la 1,208(1)
	blr
.Lfe1:
	.size	 findspawnpoint,.Lfe1-findspawnpoint
	.section	".rodata"
	.align 2
.LC2:
	.string	"item_flag_team1"
	.align 2
.LC3:
	.string	"No Other Players for teleport\n"
	.align 2
.LC4:
	.string	"No teleport spot available\n"
	.align 2
.LC5:
	.string	"world/blackhole.wav"
	.align 2
.LC6:
	.long 0x0
	.align 3
.LC7:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC8:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Cmd_Teleport_f
	.type	 Cmd_Teleport_f,@function
Cmd_Teleport_f:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 24,40(1)
	stw 0,84(1)
	lis 11,.LC6@ha
	lis 9,maxclients@ha
	la 11,.LC6@l(11)
	mr 31,3
	lfs 13,0(11)
	li 30,0
	li 27,0
	lwz 11,maxclients@l(9)
	lis 24,maxclients@ha
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L32
	lis 9,.LC7@ha
	lis 25,g_edicts@ha
	la 9,.LC7@l(9)
	lis 26,0x4330
	lfd 31,0(9)
	li 28,0
.L34:
	lwz 9,g_edicts@l(25)
	add 9,9,28
	addi 29,9,1116
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L33
	lwz 0,480(29)
	cmpwi 0,0,0
	bc 4,1,.L33
	cmpw 0,29,31
	bc 12,2,.L33
	bl rand
	andi. 0,3,1
	bc 4,2,.L32
.L33:
	addi 27,27,1
	lwz 11,maxclients@l(24)
	xoris 0,27,0x8000
	addi 28,28,1116
	stw 0,36(1)
	stw 26,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L34
.L32:
	lis 5,.LC2@ha
	li 3,0
	la 5,.LC2@l(5)
	li 4,280
	bl G_Find
	lis 28,0x1
	mr 29,3
	ori 28,28,34463
	b .L41
.L43:
	addi 30,30,1
.L41:
	mr 3,31
	mr 4,29
	addi 5,1,8
	bl findspawnpoint
	cmpw 7,30,28
	subfic 0,3,0
	adde 3,0,3
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	and. 9,3,0
	bc 4,2,.L43
	lis 0,0x1
	ori 0,0,34464
	cmpw 0,30,0
	bc 4,2,.L45
	lis 9,gi+8@ha
	lis 5,.LC4@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC4@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L30
.L45:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	addi 28,31,4
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,22
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,88(29)
	li 4,2
	mr 3,28
	mtlr 9
	blrl
	lwz 9,76(29)
	mr 3,31
	mtlr 9
	blrl
	lfs 12,8(1)
	li 0,6
	lis 3,.LC5@ha
	lfs 13,12(1)
	la 3,.LC5@l(3)
	lfs 0,16(1)
	stw 0,80(31)
	stfs 12,4(31)
	stfs 13,8(31)
	stfs 0,12(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC8@ha
	lis 11,.LC8@ha
	la 9,.LC8@l(9)
	la 11,.LC8@l(11)
	lfs 1,0(9)
	mr 5,3
	li 4,3
	lfs 2,0(11)
	lis 9,.LC6@ha
	mr 3,31
	lwz 11,16(29)
	la 9,.LC6@l(9)
	lfs 3,0(9)
	mtlr 11
	blrl
	lwz 0,72(29)
	mr 3,31
	mtlr 0
	blrl
.L30:
	lwz 0,84(1)
	mtlr 0
	lmw 24,40(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe2:
	.size	 Cmd_Teleport_f,.Lfe2-Cmd_Teleport_f
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.align 2
	.globl BossTeleport
	.type	 BossTeleport,@function
BossTeleport:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 28,3
	la 29,gi@l(29)
	li 3,3
	lwz 9,100(29)
	addi 28,28,4
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,22
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 BossTeleport,.Lfe3-BossTeleport
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
