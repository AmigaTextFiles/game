	.file	"matrix_tank.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.long 0x0
	.align 3
.LC1:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl RespawnAllPlayers
	.type	 RespawnAllPlayers,@function
RespawnAllPlayers:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 23,36(1)
	stw 0,84(1)
	lis 11,.LC0@ha
	lis 9,maxclients@ha
	la 11,.LC0@l(11)
	li 29,0
	lfs 13,0(11)
	lis 23,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L8
	lis 9,.LC1@ha
	lis 24,g_edicts@ha
	la 9,.LC1@l(9)
	li 25,0
	lfd 31,0(9)
	lis 26,vec3_origin@ha
	li 27,2
	lis 28,0x4330
	li 30,1116
.L10:
	lwz 0,g_edicts@l(24)
	add 31,0,30
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L9
	lwz 0,480(31)
	lwz 9,84(31)
	cmpwi 0,0,0
	bc 4,1,.L13
	lwz 0,3488(9)
	cmpwi 0,0,0
	bc 12,2,.L9
.L13:
	stw 25,3488(9)
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L14
	mr 3,31
	mr 4,31
	bl MatrixRespawn
	b .L15
.L14:
	lis 6,0x1
	mr 3,31
	mr 4,31
	mr 5,31
	ori 6,6,34464
	la 7,vec3_origin@l(26)
	bl player_die
.L15:
	stw 27,492(31)
	mr 3,31
	bl respawn
	lwz 11,84(31)
	lwz 9,3464(11)
	addi 9,9,1
	stw 9,3464(11)
.L9:
	addi 29,29,1
	lwz 11,maxclients@l(23)
	xoris 0,29,0x8000
	addi 30,30,1116
	stw 0,28(1)
	stw 28,24(1)
	lfd 0,24(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L10
.L8:
	lwz 0,84(1)
	mtlr 0
	lmw 23,36(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe1:
	.size	 RespawnAllPlayers,.Lfe1-RespawnAllPlayers
	.align 2
	.globl MatrixStartTank
	.type	 MatrixStartTank,@function
MatrixStartTank:
	blr
.Lfe2:
	.size	 MatrixStartTank,.Lfe2-MatrixStartTank
	.align 2
	.globl MatrixTankThink
	.type	 MatrixTankThink,@function
MatrixTankThink:
	blr
.Lfe3:
	.size	 MatrixTankThink,.Lfe3-MatrixTankThink
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
