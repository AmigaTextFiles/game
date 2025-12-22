	.file	"p_trail.c"
gcc2_compiled.:
	.globl trail_active
	.section	".sdata","aw"
	.align 2
	.type	 trail_active,@object
	.size	 trail_active,4
trail_active:
	.long 0
	.section	".rodata"
	.align 2
.LC0:
	.string	"player_trail"
	.section	".text"
	.align 2
	.globl PlayerTrail_Add
	.type	 PlayerTrail_Add,@function
PlayerTrail_Add:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	lis 9,trail_active@ha
	mr 7,3
	lwz 0,trail_active@l(9)
	cmpwi 0,0,0
	bc 12,2,.L12
	lis 28,trail_head@ha
	lis 29,trail@ha
	lfs 0,0(7)
	lwz 9,trail_head@l(28)
	la 29,trail@l(29)
	lis 8,level+4@ha
	addi 3,1,8
	slwi 0,9,2
	lwzx 10,29,0
	addi 9,9,-1
	andi. 9,9,749
	stfs 0,4(10)
	slwi 9,9,2
	lfs 0,4(7)
	lwzx 11,29,0
	stfs 0,8(11)
	lfs 0,8(7)
	lwzx 10,29,0
	stfs 0,12(10)
	lfs 0,level+4@l(8)
	lwzx 11,29,0
	stfs 0,288(11)
	lwzx 10,29,9
	lfs 13,0(7)
	lfs 0,4(10)
	lfs 12,4(7)
	lfs 11,8(7)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(10)
	fsubs 12,12,0
	stfs 12,12(1)
	lfs 0,12(10)
	fsubs 11,11,0
	stfs 11,16(1)
	bl vectoyaw
	lwz 9,trail_head@l(28)
	slwi 0,9,2
	lwzx 11,29,0
	addi 9,9,1
	andi. 9,9,749
	stfs 1,20(11)
	stw 9,trail_head@l(28)
.L12:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 PlayerTrail_Add,.Lfe1-PlayerTrail_Add
	.align 2
	.globl PlayerTrail_PickFirst
	.type	 PlayerTrail_PickFirst,@function
PlayerTrail_PickFirst:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,trail_active@ha
	mr 28,3
	lwz 0,trail_active@l(9)
	cmpwi 0,0,0
	bc 4,2,.L23
	li 3,0
	b .L33
.L23:
	lis 9,trail_head@ha
	li 0,750
	lfs 13,852(28)
	lwz 31,trail_head@l(9)
	lis 11,trail@ha
	mtctr 0
	la 11,trail@l(11)
.L34:
	slwi 0,31,2
	lwzx 9,11,0
	lfs 0,288(9)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L25
	addi 0,31,1
	andi. 31,0,749
	bdnz .L34
.L25:
	lis 9,trail@ha
	slwi 30,31,2
	la 29,trail@l(9)
	mr 3,28
	lwzx 4,29,30
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L35
	addi 0,31,-1
	mr 3,28
	andi. 0,0,749
	slwi 31,0,2
	lwzx 4,29,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L32
.L35:
	lwzx 3,29,30
	b .L33
.L32:
	lwzx 3,29,31
.L33:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 PlayerTrail_PickFirst,.Lfe2-PlayerTrail_PickFirst
	.align 2
	.globl PlayerTrail_New
	.type	 PlayerTrail_New,@function
PlayerTrail_New:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,trail_active@ha
	mr 27,3
	lwz 0,trail_active@l(9)
	cmpwi 0,0,0
	bc 12,2,.L14
	lis 9,trail@ha
	lis 11,.LC0@ha
	la 29,trail@l(9)
	la 28,.LC0@l(11)
	li 31,0
	li 30,750
.L18:
	bl G_Spawn
	stwx 3,31,29
	stw 28,280(3)
	lwzx 3,31,29
	addi 31,31,4
	bl G_FreeEdict
	addic. 30,30,-1
	bc 4,2,.L18
	lis 11,trail_head@ha
	lis 9,trail_active@ha
	stw 30,trail_active@l(9)
	mr 3,27
	stw 30,trail_head@l(11)
	bl PlayerTrail_Add
.L14:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 PlayerTrail_New,.Lfe3-PlayerTrail_New
	.align 2
	.globl PlayerTrail_PickNext
	.type	 PlayerTrail_PickNext,@function
PlayerTrail_PickNext:
	lis 9,trail_active@ha
	lwz 0,trail_active@l(9)
	cmpwi 0,0,0
	bc 4,2,.L37
	li 3,0
	blr
.L37:
	lis 9,trail_head@ha
	li 0,750
	lfs 13,852(3)
	lwz 10,trail_head@l(9)
	lis 11,trail@ha
	mtctr 0
	la 11,trail@l(11)
.L47:
	slwi 0,10,2
	lwzx 9,11,0
	lfs 0,288(9)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L39
	addi 0,10,1
	andi. 10,0,749
	bdnz .L47
.L39:
	lis 9,trail@ha
	slwi 0,10,2
	la 9,trail@l(9)
	lwzx 3,9,0
	blr
.Lfe4:
	.size	 PlayerTrail_PickNext,.Lfe4-PlayerTrail_PickNext
	.align 2
	.globl PlayerTrail_LastSpot
	.type	 PlayerTrail_LastSpot,@function
PlayerTrail_LastSpot:
	lis 10,trail_head@ha
	lis 11,trail@ha
	lwz 9,trail_head@l(10)
	la 11,trail@l(11)
	addi 9,9,-1
	andi. 9,9,749
	slwi 9,9,2
	lwzx 3,11,9
	blr
.Lfe5:
	.size	 PlayerTrail_LastSpot,.Lfe5-PlayerTrail_LastSpot
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.align 2
	.globl PlayerTrail_Init
	.type	 PlayerTrail_Init,@function
PlayerTrail_Init:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,trail@ha
	lis 11,.LC0@ha
	la 29,trail@l(9)
	la 28,.LC0@l(11)
	li 31,0
	li 30,750
.L10:
	bl G_Spawn
	stwx 3,31,29
	stw 28,280(3)
	lwzx 3,31,29
	addi 31,31,4
	bl G_FreeEdict
	addic. 30,30,-1
	bc 4,2,.L10
	lis 11,trail_head@ha
	lis 9,trail_active@ha
	stw 30,trail_active@l(9)
	stw 30,trail_head@l(11)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 PlayerTrail_Init,.Lfe6-PlayerTrail_Init
	.comm	trail_head,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
