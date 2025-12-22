	.file	"m_boss3.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC1:
	.string	"models/monsters/boss3/rider/tris.md2"
	.align 2
.LC2:
	.string	"misc/bigtele.wav"
	.comm	highscore,1080,4
	.comm	gamescore,540,4
	.section	".text"
	.align 2
	.globl Use_Boss3
	.type	 Use_Boss3,@function
Use_Boss3:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 27,3
	la 29,gi@l(29)
	li 3,3
	lwz 9,100(29)
	addi 28,27,4
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
	mr 3,27
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Use_Boss3,.Lfe1-Use_Boss3
	.section	".rodata"
	.align 3
.LC4:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl Think_Boss3Stand
	.type	 Think_Boss3Stand,@function
Think_Boss3Stand:
	lwz 9,56(3)
	cmpwi 0,9,473
	li 0,414
	bc 12,2,.L12
	addi 0,9,1
.L12:
	stw 0,56(3)
	lis 9,level+4@ha
	lis 11,.LC4@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC4@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe2:
	.size	 Think_Boss3Stand,.Lfe2-Think_Boss3Stand
	.section	".rodata"
	.align 3
.LC5:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC6:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_monster_boss3_stand
	.type	 SP_monster_boss3_stand,@function
SP_monster_boss3_stand:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 29,12(1)
	stw 0,36(1)
	lis 11,.LC6@ha
	lis 9,deathmatch@ha
	la 11,.LC6@l(11)
	mr 31,3
	lfs 31,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L11
	bl G_FreeEdict
	b .L10
.L11:
	lis 9,.LC1@ha
	li 11,2
	la 9,.LC1@l(9)
	li 0,5
	stw 11,248(31)
	lis 29,gi@ha
	stw 0,260(31)
	mr 3,9
	la 29,gi@l(29)
	stw 9,268(31)
	lwz 9,32(29)
	mtlr 9
	blrl
	li 0,414
	stw 3,40(31)
	stw 0,56(31)
	lis 3,.LC2@ha
	lwz 9,36(29)
	la 3,.LC2@l(3)
	mtlr 9
	blrl
	lis 9,Use_Boss3@ha
	lis 11,Think_Boss3Stand@ha
	stfs 31,196(31)
	la 9,Use_Boss3@l(9)
	lis 10,0xc200
	lis 8,0x4200
	lis 0,0x42b4
	stw 9,448(31)
	la 11,Think_Boss3Stand@l(11)
	stw 10,192(31)
	lis 7,level+4@ha
	stw 8,204(31)
	lis 9,.LC5@ha
	mr 3,31
	stw 0,208(31)
	stw 11,436(31)
	stw 10,188(31)
	stw 8,200(31)
	lfs 0,level+4@l(7)
	lfd 13,.LC5@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,72(29)
	mtlr 0
	blrl
.L10:
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 SP_monster_boss3_stand,.Lfe3-SP_monster_boss3_stand
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
