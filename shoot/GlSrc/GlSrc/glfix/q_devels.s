	.file	"q_devels.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"player"
	.comm	maplist,292,4
	.section	".text"
	.align 2
	.globl stuffcmd
	.type	 stuffcmd,@function
stuffcmd:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 27,3
	la 29,gi@l(29)
	li 3,11
	lwz 9,100(29)
	mr 28,4
	mtlr 9
	blrl
	lwz 9,116(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,27
	li 4,1
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 stuffcmd,.Lfe1-stuffcmd
	.align 2
	.globl ent_by_name
	.type	 ent_by_name,@function
ent_by_name:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,globals@ha
	mr 29,3
	la 27,globals@l(9)
	li 31,0
	li 30,0
	lis 28,.LC0@ha
.L8:
	lwz 0,72(27)
	li 3,0
	cmpw 0,30,0
	bc 12,1,.L20
	mr 3,31
	li 4,280
	la 5,.LC0@l(28)
	bl G_Find
	mr 31,3
	mr 4,29
	lwz 3,84(31)
	addi 3,3,700
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L10
	addi 30,30,1
	b .L8
.L10:
	mr 3,31
.L20:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 ent_by_name,.Lfe2-ent_by_name
	.section	".rodata"
	.align 2
.LC1:
	.long 0x3f800000
	.align 3
.LC2:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl centerprint_all
	.type	 centerprint_all,@function
centerprint_all:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 25,28(1)
	stw 0,68(1)
	lis 11,.LC1@ha
	lis 9,maxclients@ha
	la 11,.LC1@l(11)
	mr 29,3
	lfs 13,0(11)
	li 30,1
	lis 25,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L15
	lis 9,gi@ha
	lis 26,g_edicts@ha
	la 27,gi@l(9)
	lis 28,0x4330
	lis 9,.LC2@ha
	li 31,992
	la 9,.LC2@l(9)
	lfd 31,0(9)
.L17:
	lwz 0,g_edicts@l(26)
	add. 3,0,31
	bc 12,2,.L16
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L16
	lwz 9,12(27)
	mr 4,29
	mtlr 9
	crxor 6,6,6
	blrl
.L16:
	addi 30,30,1
	lwz 11,maxclients@l(25)
	xoris 0,30,0x8000
	addi 31,31,992
	stw 0,20(1)
	stw 28,16(1)
	lfd 0,16(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L17
.L15:
	lwz 0,68(1)
	mtlr 0
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe3:
	.size	 centerprint_all,.Lfe3-centerprint_all
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
