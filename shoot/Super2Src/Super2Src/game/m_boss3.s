	.file	"m_boss3.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC1:
	.string	"models/monsters/boss3/rider/tris.md2"
	.align 2
.LC2:
	.string	"misc/bigtele.wav"
	.align 3
.LC3:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC4:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_monster_boss3_stand
	.type	 SP_monster_boss3_stand,@function
SP_monster_boss3_stand:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 11,.LC4@ha
	lis 9,deathmatch@ha
	la 11,.LC4@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L11
	lis 9,hunt@ha
	lwz 11,hunt@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L11
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
	la 9,Use_Boss3@l(9)
	lis 7,0xc200
	stw 9,448(31)
	lis 6,0x4200
	li 0,0
	la 11,Think_Boss3Stand@l(11)
	lis 9,0x42b4
	stw 7,192(31)
	stw 0,196(31)
	lis 10,level+4@ha
	lis 8,.LC3@ha
	stw 6,204(31)
	mr 3,31
	stw 9,208(31)
	stw 11,436(31)
	stw 7,188(31)
	stw 6,200(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC3@l(8)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,72(29)
	mtlr 0
	blrl
.L10:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 SP_monster_boss3_stand,.Lfe1-SP_monster_boss3_stand
	.comm	v_forward,12,4
	.comm	v_right,12,4
	.comm	v_up,12,4
	.comm	invis_index,4,4
	.comm	cripple_index,4,4
	.comm	robot_index,4,4
	.comm	sun_index,4,4
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
.Lfe2:
	.size	 Use_Boss3,.Lfe2-Use_Boss3
	.section	".rodata"
	.align 3
.LC5:
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
	lis 11,.LC5@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC5@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe3:
	.size	 Think_Boss3Stand,.Lfe3-Think_Boss3Stand
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
