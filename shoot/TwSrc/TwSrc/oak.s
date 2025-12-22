	.file	"oak.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"Sorry Oak II is a deathmatch only bot.\n"
	.align 2
.LC1:
	.string	"player"
	.align 2
.LC2:
	.string	"players/male/tris.md2"
	.align 2
.LC4:
	.string	"A Oak bot has entered the game\n"
	.align 3
.LC3:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC5:
	.long 0x42000000
	.section	".text"
	.align 2
	.globl SP_Oak
	.type	 SP_Oak,@function
SP_Oak:
	stwu 1,-96(1)
	mflr 0
	stmw 21,52(1)
	stw 0,100(1)
	bl G_Spawn
	lis 21,gi@ha
	mr 29,3
	addi 4,1,24
	addi 3,1,8
	crxor 6,6,6
	bl SelectSpawnPoint
	lfs 0,8(1)
	lis 9,.LC5@ha
	lis 10,0x201
	la 9,.LC5@l(9)
	lis 8,.LC2@ha
	lfs 12,0(9)
	lis 6,oak_pain@ha
	lis 5,oak_die@ha
	stfs 0,4(29)
	lis 9,.LC1@ha
	lis 7,oak_stand@ha
	lfs 0,12(1)
	la 9,.LC1@l(9)
	li 11,0
	li 4,-40
	la 8,.LC2@l(8)
	la 6,oak_pain@l(6)
	la 5,oak_die@l(5)
	stfs 0,8(29)
	la 7,oak_stand@l(7)
	ori 10,10,3
	lfs 0,16(1)
	li 28,2
	li 27,255
	stw 9,284(29)
	li 26,100
	li 0,200
	li 9,5
	stw 4,760(29)
	lis 24,level+4@ha
	fadds 0,0,12
	stw 9,264(29)
	lis 23,.LC3@ha
	lis 25,0x41a0
	stw 0,644(29)
	lis 9,0xc180
	lis 22,0xc1c0
	stw 10,252(29)
	li 0,0
	mr 3,29
	stw 8,272(29)
	lis 10,0x4180
	stw 11,960(29)
	stw 6,696(29)
	stw 5,700(29)
	stw 7,680(29)
	stw 11,764(29)
	stw 11,56(29)
	stw 11,964(29)
	stw 28,248(29)
	stfs 0,12(29)
	stw 27,44(29)
	stw 26,756(29)
	stw 28,788(29)
	stw 27,40(29)
	stw 26,728(29)
	lfs 0,level+4@l(24)
	lfd 13,.LC3@l(23)
	stw 0,16(29)
	stw 25,664(29)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(29)
	lfs 13,28(1)
	stw 0,24(29)
	stfs 13,20(29)
	stw 9,188(29)
	stw 9,192(29)
	stw 10,204(29)
	stfs 12,208(29)
	stw 0,620(29)
	stw 10,200(29)
	stw 0,628(29)
	stw 0,624(29)
	stw 22,196(29)
	bl KillBox
	la 9,gi@l(21)
	mr 3,29
	lwz 0,72(9)
	mtlr 0
	blrl
	lwz 0,gi@l(21)
	lis 4,.LC4@ha
	li 3,2
	la 4,.LC4@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,100(1)
	mtlr 0
	lmw 21,52(1)
	la 1,96(1)
	blr
.Lfe1:
	.size	 SP_Oak,.Lfe1-SP_Oak
	.section	".rodata"
	.align 2
.LC7:
	.string	"A Drone has respawned\n"
	.align 3
.LC6:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC8:
	.long 0x42000000
	.section	".text"
	.align 2
	.globl OAK_Respawn
	.type	 OAK_Respawn,@function
OAK_Respawn:
	stwu 1,-80(1)
	mflr 0
	stmw 23,44(1)
	stw 0,84(1)
	mr 29,3
	addi 4,1,24
	addi 3,1,8
	lis 23,gi@ha
	crxor 6,6,6
	bl SelectSpawnPoint
	lis 9,.LC8@ha
	lfs 0,16(1)
	lis 10,oak_pain@ha
	la 9,.LC8@l(9)
	lfs 13,12(1)
	lis 8,oak_die@ha
	lfs 11,0(9)
	lis 7,oak_stand@ha
	li 11,0
	lis 9,.LC2@ha
	lfs 12,8(1)
	li 6,0
	la 9,.LC2@l(9)
	li 4,255
	stfs 13,8(29)
	fadds 0,0,11
	stw 9,272(29)
	la 7,oak_stand@l(7)
	la 10,oak_pain@l(10)
	la 8,oak_die@l(8)
	li 0,2
	stw 4,44(29)
	li 9,-40
	lis 5,0xc1c0
	stw 4,40(29)
	li 28,100
	lis 26,0xc180
	stfs 12,4(29)
	lis 27,0x4180
	stw 0,788(29)
	lis 25,level+4@ha
	stw 11,960(29)
	lis 24,.LC6@ha
	mr 3,29
	stw 9,760(29)
	stw 10,696(29)
	stw 8,700(29)
	stw 5,196(29)
	stfs 11,208(29)
	stw 6,620(29)
	stw 7,680(29)
	stw 11,764(29)
	stw 11,56(29)
	stw 11,964(29)
	stw 7,1140(29)
	stw 6,628(29)
	stw 6,624(29)
	stfs 0,12(29)
	stw 28,756(29)
	stw 26,192(29)
	stw 27,204(29)
	stw 28,728(29)
	stw 26,188(29)
	stw 27,200(29)
	lfs 0,level+4@l(25)
	lfd 13,.LC6@l(24)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(29)
	bl KillBox
	la 9,gi@l(23)
	mr 3,29
	lwz 0,72(9)
	mtlr 0
	blrl
	lwz 0,gi@l(23)
	lis 4,.LC7@ha
	li 3,2
	la 4,.LC7@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,84(1)
	mtlr 0
	lmw 23,44(1)
	la 1,80(1)
	blr
.Lfe2:
	.size	 OAK_Respawn,.Lfe2-OAK_Respawn
	.section	".rodata"
	.align 2
.LC9:
	.long 0x0
	.section	".text"
	.align 2
	.globl OAK_Check_SP
	.type	 OAK_Check_SP,@function
OAK_Check_SP:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC9@ha
	lis 9,deathmatch@ha
	la 11,.LC9@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L7
	bl SP_Oak
	b .L8
.L7:
	lis 9,gi+8@ha
	lis 5,.LC0@ha
	lwz 0,gi+8@l(9)
	la 5,.LC0@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L8:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe3:
	.size	 OAK_Check_SP,.Lfe3-OAK_Check_SP
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
