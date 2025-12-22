	.file	"oakai.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"player"
	.align 2
.LC3:
	.string	"Oak: in oak_pain ouch!\n"
	.align 2
.LC6:
	.string	"Oak: in oak_painthink running anim\n"
	.align 2
.LC8:
	.string	"misc/udeath.wav"
	.align 2
.LC9:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 3
.LC13:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC14:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl oak_stand
	.type	 oak_stand,@function
oak_stand:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,.LC14@ha
	mr 30,3
	la 9,.LC14@l(9)
	li 0,0
	lfs 1,0(9)
	li 3,0
	addi 4,30,4
	stw 0,816(30)
	bl findradius
	mr. 31,3
	bc 12,2,.L8
	lis 29,.LC0@ha
.L9:
	mr 3,30
	mr 4,31
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L10
	mr 3,30
	mr 4,31
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L10
	lwz 3,284(31)
	la 4,.LC0@l(29)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L10
	stw 31,816(30)
.L10:
	lis 9,.LC14@ha
	mr 3,31
	la 9,.LC14@l(9)
	addi 4,30,4
	lfs 1,0(9)
	bl findradius
	mr. 31,3
	bc 4,2,.L9
.L8:
	lwz 0,816(30)
	cmpwi 0,0,0
	bc 12,2,.L14
	mr 3,30
	bl OakAI_FaceEnemy
	mr 3,30
	li 4,40
	li 5,45
	bl OakAI_RunFrames
	b .L15
.L14:
	mr 3,30
	li 4,0
	li 5,39
	bl OakAI_RunFrames
.L15:
	lis 9,level+4@ha
	lis 11,.LC13@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC13@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(30)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 oak_stand,.Lfe1-oak_stand
	.section	".rodata"
	.align 3
.LC15:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl oak_run
	.type	 oak_run,@function
oak_run:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	li 4,40
	li 5,45
	bl OakAI_RunFrames
	mr 3,29
	bl OakAI_FaceEnemy
	lis 9,level+4@ha
	lis 11,.LC15@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC15@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 oak_run,.Lfe2-oak_run
	.section	".rodata"
	.align 3
.LC16:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC17:
	.long 0x3fd33333
	.long 0x33333333
	.section	".text"
	.align 2
	.globl oak_pain
	.type	 oak_pain,@function
oak_pain:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 28,4
	lwz 0,gi@l(9)
	mr 29,3
	lis 4,.LC3@ha
	la 4,.LC3@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,29
	li 4,54
	li 5,57
	bl OakAI_RunFrames
	lis 9,oak_painthink@ha
	lis 11,level@ha
	stw 28,816(29)
	la 9,oak_painthink@l(9)
	la 11,level@l(11)
	stw 9,680(29)
	lis 10,.LC16@ha
	lfs 13,4(11)
	lis 9,.LC17@ha
	lfd 0,.LC16@l(10)
	lfd 12,.LC17@l(9)
	fadd 13,13,0
	frsp 13,13
	stfs 13,672(29)
	lfs 0,4(11)
	fadd 0,0,12
	frsp 0,0
	stfs 0,1228(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 oak_pain,.Lfe3-oak_pain
	.section	".rodata"
	.align 3
.LC18:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl oak_painthink
	.type	 oak_painthink,@function
oak_painthink:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,gi@ha
	mr 31,3
	lwz 0,gi@l(9)
	lis 4,.LC6@ha
	li 3,2
	la 4,.LC6@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,level+4@ha
	lfs 13,1228(31)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L19
	mr 3,31
	li 4,54
	li 5,57
	bl OakAI_RunFrames
	b .L20
.L19:
	lis 9,oak_run@ha
	la 9,oak_run@l(9)
	stw 9,680(31)
.L20:
	lis 9,level+4@ha
	lis 11,.LC18@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC18@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 oak_painthink,.Lfe4-oak_painthink
	.section	".rodata"
	.align 2
.LC19:
	.long 0x3f800000
	.align 2
.LC20:
	.long 0x0
	.section	".text"
	.align 2
	.globl oak_die
	.type	 oak_die,@function
oak_die:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 30,3
	la 29,gi@l(29)
	lis 3,.LC8@ha
	lwz 9,36(29)
	la 3,.LC8@l(3)
	mr 28,6
	lis 27,.LC9@ha
	li 31,4
	mtlr 9
	blrl
	lis 9,.LC19@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC19@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC19@ha
	la 9,.LC19@l(9)
	lfs 2,0(9)
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 3,0(9)
	blrl
.L25:
	mr 3,30
	la 4,.LC9@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 31,31,-1
	bc 4,2,.L25
	stw 31,788(30)
	mr 3,30
	crxor 6,6,6
	bl OAK_Respawn
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 oak_die,.Lfe5-oak_die
	.align 2
	.globl OakAI_FaceEnemy
	.type	 OakAI_FaceEnemy,@function
OakAI_FaceEnemy:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 29,3
	lwz 9,816(29)
	addi 3,1,8
	lfs 0,4(29)
	lfs 13,4(9)
	lfs 12,8(29)
	lfs 11,12(29)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,16(1)
	bl vectoyaw
	stfs 1,668(29)
	mr 3,29
	bl M_ChangeYaw
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 OakAI_FaceEnemy,.Lfe6-OakAI_FaceEnemy
	.section	".rodata"
	.align 2
.LC21:
	.long 0x46fffe00
	.align 3
.LC22:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 3
.LC23:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC24:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC25:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl oak_standclose
	.type	 oak_standclose,@function
oak_standclose:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 4,816(31)
	cmpwi 0,4,0
	bc 12,2,.L29
	li 5,50
	crxor 6,6,6
	bl SV_CloseEnough
	cmpwi 0,3,0
	bc 12,2,.L29
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC24@ha
	lis 10,.LC22@ha
	la 11,.LC24@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC21@ha
	lfs 11,.LC21@l(11)
	lfd 12,.LC22@l(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 4,0,.L30
	lis 9,level@ha
	lfs 13,1228(31)
	la 9,level@l(9)
	lfs 0,4(9)
	fcmpu 0,13,0
	bc 4,0,.L30
	mr 3,31
	li 4,0
	li 5,39
	bl OakAI_RunFrames
	b .L33
.L30:
	lis 9,level+4@ha
	lfs 0,1228(31)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L32
	lis 9,.LC25@ha
	fmr 0,13
	la 9,.LC25@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,1228(31)
.L32:
	mr 3,31
	bl OakAI_Wave
	b .L33
.L29:
	lis 9,oak_stand@ha
	la 9,oak_stand@l(9)
	stw 9,680(31)
.L33:
	lis 9,level+4@ha
	lis 11,.LC23@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC23@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 oak_standclose,.Lfe7-oak_standclose
	.align 2
	.globl OakAI_RunFrames
	.type	 OakAI_RunFrames,@function
OakAI_RunFrames:
	lwz 9,56(3)
	cmpw 0,9,5
	bc 4,0,.L35
	cmpw 0,9,4
	bc 12,0,.L35
	addi 0,9,1
	stw 0,56(3)
	blr
.L35:
	stw 4,56(3)
	blr
.Lfe8:
	.size	 OakAI_RunFrames,.Lfe8-OakAI_RunFrames
	.align 2
	.globl OakAI_Finger
	.type	 OakAI_Finger,@function
OakAI_Finger:
	lwz 9,56(3)
	cmpwi 0,9,83
	bc 4,0,.L38
	cmpwi 0,9,72
	bc 12,0,.L38
	addi 0,9,1
	stw 0,56(3)
	blr
.L38:
	li 0,72
	stw 0,56(3)
	blr
.Lfe9:
	.size	 OakAI_Finger,.Lfe9-OakAI_Finger
	.align 2
	.globl OakAI_Taunt
	.type	 OakAI_Taunt,@function
OakAI_Taunt:
	lwz 9,56(3)
	cmpwi 0,9,111
	bc 4,0,.L42
	cmpwi 0,9,95
	bc 12,0,.L42
	addi 0,9,1
	stw 0,56(3)
	blr
.L42:
	li 0,95
	stw 0,56(3)
	blr
.Lfe10:
	.size	 OakAI_Taunt,.Lfe10-OakAI_Taunt
	.align 2
	.globl OakAI_Wave
	.type	 OakAI_Wave,@function
OakAI_Wave:
	lwz 9,56(3)
	cmpwi 0,9,122
	bc 4,0,.L46
	cmpwi 0,9,112
	bc 12,0,.L46
	addi 0,9,1
	stw 0,56(3)
	blr
.L46:
	li 0,112
	stw 0,56(3)
	blr
.Lfe11:
	.size	 OakAI_Wave,.Lfe11-OakAI_Wave
	.align 2
	.globl OakAI_Salute
	.type	 OakAI_Salute,@function
OakAI_Salute:
	lwz 9,56(3)
	cmpwi 0,9,94
	bc 4,0,.L50
	cmpwi 0,9,84
	bc 12,0,.L50
	addi 0,9,1
	stw 0,56(3)
	blr
.L50:
	li 0,84
	stw 0,56(3)
	blr
.Lfe12:
	.size	 OakAI_Salute,.Lfe12-OakAI_Salute
	.align 2
	.globl OakAI_Point
	.type	 OakAI_Point,@function
OakAI_Point:
	lwz 9,56(3)
	cmpwi 0,9,134
	bc 4,0,.L54
	cmpwi 0,9,123
	bc 12,0,.L54
	addi 0,9,1
	stw 0,56(3)
	blr
.L54:
	li 0,123
	stw 0,56(3)
	blr
.Lfe13:
	.size	 OakAI_Point,.Lfe13-OakAI_Point
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
