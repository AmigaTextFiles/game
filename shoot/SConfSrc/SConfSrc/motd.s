	.file	"motd.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC1:
	.string	"TimedMessage"
	.comm	highscore,1080,4
	.comm	gamescore,540,4
	.section	".text"
	.align 2
	.globl DeleteTimedMessage
	.type	 DeleteTimedMessage,@function
DeleteTimedMessage:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lwz 3,276(29)
	bl free
	mr 3,29
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 DeleteTimedMessage,.Lfe1-DeleteTimedMessage
	.section	".rodata"
	.align 3
.LC2:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC3:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl SendTimedMessage
	.type	 SendTimedMessage,@function
SendTimedMessage:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,level@ha
	mr 31,3
	la 30,level@l(9)
	lfs 13,476(31)
	lfs 0,4(30)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L8
	lis 9,DeleteTimedMessage@ha
	lis 11,.LC2@ha
	la 9,DeleteTimedMessage@l(9)
	lfd 13,.LC2@l(11)
	stw 9,436(31)
	lfs 0,4(30)
	fadd 0,0,13
	frsp 0,0
	b .L30
.L8:
	lis 9,gi+12@ha
	lwz 3,256(31)
	lwz 0,gi+12@l(9)
	lwz 4,276(31)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,.LC3@ha
	lfs 0,4(30)
	la 9,.LC3@l(9)
	lfs 13,0(9)
	fadds 0,0,13
.L30:
	stfs 0,428(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe2:
	.size	 SendTimedMessage,.Lfe2-SendTimedMessage
	.align 2
	.globl GetTimedMessage
	.type	 GetTimedMessage,@function
GetTimedMessage:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lwz 0,1548(9)
	cmpw 0,30,0
	bc 4,0,.L12
	mr 27,9
	lis 29,g_edicts@ha
	lis 28,.LC1@ha
	li 31,0
.L14:
	lwz 9,g_edicts@l(29)
	add 9,31,9
	lwz 3,280(9)
	cmpwi 0,3,0
	bc 12,2,.L13
	la 4,.LC1@l(28)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L13
	lwz 3,g_edicts@l(29)
	add 3,3,31
	b .L31
.L13:
	lwz 0,1548(27)
	addi 30,30,1
	addi 31,31,892
	cmpw 0,30,0
	bc 12,0,.L14
.L12:
	li 3,0
.L31:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 GetTimedMessage,.Lfe3-GetTimedMessage
	.align 2
	.globl StopTimedMessage
	.type	 StopTimedMessage,@function
StopTimedMessage:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lwz 0,1548(9)
	cmpw 0,30,0
	bc 4,0,.L26
	mr 27,9
	lis 29,g_edicts@ha
	lis 28,.LC1@ha
	li 31,0
.L21:
	lwz 9,g_edicts@l(29)
	add 9,31,9
	lwz 3,280(9)
	cmpwi 0,3,0
	bc 12,2,.L25
	la 4,.LC1@l(28)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L25
	lwz 0,g_edicts@l(29)
	add 31,0,31
	b .L24
.L25:
	lwz 0,1548(27)
	addi 30,30,1
	addi 31,31,892
	cmpw 0,30,0
	bc 12,0,.L21
.L26:
	li 31,0
.L24:
	cmpwi 0,31,0
	bc 12,2,.L27
	lwz 3,276(31)
	bl free
	mr 3,31
	bl G_FreeEdict
.L27:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 StopTimedMessage,.Lfe4-StopTimedMessage
	.section	".rodata"
	.align 2
.LC4:
	.long 0x3f800000
	.align 3
.LC5:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl DisplayTimedMessage
	.type	 DisplayTimedMessage,@function
DisplayTimedMessage:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 27,4
	mr 28,5
	mr 26,3
	bl G_Spawn
	lis 9,.LC1@ha
	mr 29,3
	la 9,.LC1@l(9)
	mr 3,27
	stw 9,280(29)
	bl strdup
	xoris 28,28,0x8000
	stw 3,276(29)
	stw 28,20(1)
	lis 0,0x4330
	lis 11,SendTimedMessage@ha
	stw 0,16(1)
	la 11,SendTimedMessage@l(11)
	lis 10,level@ha
	lfd 12,16(1)
	la 10,level@l(10)
	mr 3,29
	lis 9,.LC4@ha
	stw 26,256(29)
	la 9,.LC4@l(9)
	stw 11,436(29)
	lfs 11,0(9)
	lis 9,.LC5@ha
	lfs 13,4(10)
	la 9,.LC5@l(9)
	lfd 0,0(9)
	fadds 13,13,11
	lis 9,gi+72@ha
	fsub 12,12,0
	stfs 13,428(29)
	lfs 0,4(10)
	frsp 12,12
	fadds 0,0,12
	stfs 0,476(29)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 DisplayTimedMessage,.Lfe5-DisplayTimedMessage
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
