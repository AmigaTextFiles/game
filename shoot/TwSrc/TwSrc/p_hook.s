	.file	"p_hook.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"misc/am_pkup.wav"
	.align 2
.LC1:
	.string	"rotate/h_rot1.wav"
	.align 2
.LC2:
	.string	"plats/pt1_strt.wav"
	.align 2
.LC3:
	.string	"items/respawn1.wav"
	.align 3
.LC4:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC5:
	.long 0x3f800000
	.align 2
.LC6:
	.long 0x40000000
	.align 2
.LC7:
	.long 0x0
	.align 2
.LC8:
	.long 0x41a00000
	.align 2
.LC9:
	.long 0x41200000
	.align 2
.LC10:
	.long 0x42700000
	.align 3
.LC11:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC12:
	.long 0x40a00000
	.align 2
.LC13:
	.long 0x41c80000
	.section	".text"
	.align 2
	.globl Hook_Behavior
	.type	 Hook_Behavior,@function
Hook_Behavior:
	stwu 1,-192(1)
	mflr 0
	stfd 29,168(1)
	stfd 30,176(1)
	stfd 31,184(1)
	stmw 25,140(1)
	stw 0,196(1)
	mr 31,3
	li 4,0
	addi 3,1,8
	li 5,12
	mr 25,3
	li 30,0
	crxor 6,6,6
	bl memset
	addi 3,1,24
	addi 29,1,40
	li 4,0
	li 5,12
	mr 27,3
	mr 26,29
	crxor 6,6,6
	bl memset
	mr 3,29
	li 4,0
	li 5,12
	crxor 6,6,6
	bl memset
	lwz 11,256(31)
	lwz 9,84(11)
	lwz 10,3812(9)
	andi. 0,10,1
	bc 12,2,.L27
	lwz 9,816(31)
	lwz 0,248(9)
	cmpwi 0,0,0
	bc 12,2,.L27
	lwz 0,764(11)
	cmpwi 0,0,0
	bc 4,2,.L27
	lwz 0,80(11)
	cmpwi 0,0,6
	bc 4,2,.L26
.L27:
	lwz 11,256(31)
	li 0,0
	lis 29,gi@ha
	la 29,gi@l(29)
	lis 3,.LC3@ha
	lwz 9,84(11)
	la 3,.LC3@l(3)
	stw 0,3812(9)
	lwz 9,36(29)
	lwz 28,256(31)
	mtlr 9
	blrl
	lis 9,.LC5@ha
	lwz 0,16(29)
	lis 11,.LC6@ha
	la 9,.LC5@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC6@l(11)
	mr 3,28
	mtlr 0
	lis 9,.LC7@ha
	li 4,6
	lfs 2,0(11)
	la 9,.LC7@l(9)
	lfs 3,0(9)
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L25
.L26:
	lfs 0,620(9)
	andi. 0,10,4
	stfs 0,620(31)
	lfs 13,624(9)
	stfs 13,624(31)
	lfs 0,628(9)
	stfs 0,628(31)
	bc 12,2,.L29
	lis 9,.LC8@ha
	lfs 0,528(31)
	li 30,1
	la 9,.LC8@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	b .L52
.L29:
	andi. 11,10,2
	bc 12,2,.L30
	lis 9,.LC9@ha
	lfs 13,528(31)
	la 9,.LC9@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L30
	lis 11,.LC10@ha
	li 30,1
	la 11,.LC10@l(11)
	lfs 0,0(11)
	fsubs 0,13,0
.L52:
	stfs 0,528(31)
.L30:
	lis 9,.LC9@ha
	lfs 0,528(31)
	la 9,.LC9@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L33
	stfs 13,528(31)
	li 30,0
.L33:
	cmpwi 0,30,0
	bc 12,2,.L34
	lwz 0,804(31)
	cmpwi 0,0,0
	bc 12,2,.L35
	cmpwi 0,0,1
	bc 12,2,.L36
	b .L41
.L35:
	lis 29,gi@ha
	lis 3,.LC0@ha
	lwz 28,256(31)
	la 29,gi@l(29)
	la 3,.LC0@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC5@ha
	lwz 0,16(29)
	lis 11,.LC6@ha
	la 9,.LC5@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC6@l(11)
	mtlr 0
	li 4,6
	lis 9,.LC7@ha
	mr 3,28
	lfs 2,0(11)
	la 9,.LC7@l(9)
	lfs 3,0(9)
	blrl
	li 0,1
	stw 0,804(31)
	b .L41
.L36:
	lis 29,gi@ha
	lis 3,.LC1@ha
	lwz 28,256(31)
	la 29,gi@l(29)
	la 3,.LC1@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC5@ha
	lwz 0,16(29)
	lis 11,.LC6@ha
	la 9,.LC5@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC6@l(11)
	mtlr 0
	li 4,6
	lis 9,.LC7@ha
	mr 3,28
	lfs 2,0(11)
	la 9,.LC7@l(9)
	lfs 3,0(9)
	blrl
	li 0,2
	stw 0,804(31)
	b .L41
.L34:
	lwz 0,804(31)
	cmpwi 0,0,0
	bc 12,2,.L41
	lis 29,gi@ha
	lis 3,.LC2@ha
	lwz 28,256(31)
	la 29,gi@l(29)
	la 3,.LC2@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC5@ha
	lwz 0,16(29)
	lis 11,.LC6@ha
	la 9,.LC5@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC6@l(11)
	li 4,6
	mtlr 0
	lis 9,.LC7@ha
	mr 3,28
	lfs 2,0(11)
	la 9,.LC7@l(9)
	lfs 3,0(9)
	blrl
	stw 30,804(31)
.L41:
	lwz 9,256(31)
	addi 29,1,56
	addi 4,1,72
	addi 5,1,88
	addi 30,1,104
	lwz 3,84(9)
	li 6,0
	addi 3,3,3752
	bl AngleVectors
	lwz 10,256(31)
	lis 0,0x4100
	lis 9,.LC11@ha
	stw 0,56(1)
	la 9,.LC11@l(9)
	stw 0,4(29)
	lis 8,0x4330
	addi 28,10,4
	lfd 13,0(9)
	mr 3,30
	li 4,0
	lwz 9,784(10)
	li 5,12
	addi 9,9,-8
	xoris 9,9,0x8000
	stw 9,132(1)
	stw 8,128(1)
	lfd 0,128(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,64(1)
	lwz 29,84(10)
	crxor 6,6,6
	bl memset
	lfs 12,60(1)
	lfs 0,56(1)
	lfs 13,64(1)
	stfs 12,108(1)
	stfs 0,104(1)
	stfs 13,112(1)
	lwz 0,716(29)
	cmpwi 0,0,0
	bc 4,2,.L42
	fneg 0,12
	stfs 0,108(1)
	b .L43
.L42:
	cmpwi 0,0,2
	bc 4,2,.L43
	li 0,0
	stw 0,4(30)
.L43:
	lis 9,.LC7@ha
	mr 3,28
	la 9,.LC7@l(9)
	mr 7,25
	addi 4,1,104
	addi 5,1,72
	lfs 29,0(9)
	addi 6,1,88
	bl G_ProjectSource
	lfs 12,4(31)
	mr 3,27
	lfs 11,8(1)
	lfs 13,8(31)
	lfs 0,12(31)
	fsubs 12,12,11
	lfs 10,12(1)
	lfs 11,16(1)
	fsubs 13,13,10
	stfs 12,24(1)
	fsubs 0,0,11
	stfs 13,28(1)
	stfs 0,32(1)
	bl VectorLength
	fmr 30,1
	lfs 0,528(31)
	fcmpu 0,30,0
	bc 4,1,.L47
	lwz 9,256(31)
	mr 3,27
	mr 4,26
	lfs 0,28(1)
	lfs 10,624(9)
	lfs 13,24(1)
	fmuls 11,0,0
	lfs 12,620(9)
	fmuls 10,10,0
	lfs 1,628(9)
	lfs 0,32(1)
	fmadds 11,13,13,11
	fmadds 12,12,13,10
	fmadds 11,0,0,11
	fmadds 1,1,0,12
	fdivs 1,1,11
	bl VectorScale
	lwz 9,256(31)
	lis 11,.LC12@ha
	lfs 11,28(1)
	la 11,.LC12@l(11)
	lfs 12,624(9)
	lfs 7,620(9)
	lfs 13,24(1)
	fmuls 12,12,11
	lfs 0,628(9)
	lfs 11,32(1)
	lfs 8,528(31)
	fmadds 13,7,13,12
	lfs 9,0(11)
	fsubs 10,30,8
	fmadds 0,0,11,13
	fmuls 31,10,9
	fcmpu 0,0,29
	bc 4,0,.L48
	lis 11,.LC13@ha
	la 11,.LC13@l(11)
	lfs 0,0(11)
	fadds 0,8,0
	fcmpu 0,30,0
	bc 4,1,.L49
	lfs 0,40(1)
	fsubs 0,7,0
	stfs 0,620(9)
	lwz 9,256(31)
	lfs 13,44(1)
	lfs 0,624(9)
	fsubs 0,0,13
	stfs 0,624(9)
	lwz 11,256(31)
	lfs 13,48(1)
	lfs 0,628(11)
	fsubs 0,0,13
	stfs 0,628(11)
.L49:
	fmr 29,31
	b .L47
.L48:
	mr 3,26
	bl VectorLength
	fcmpu 0,1,31
	bc 4,0,.L47
	mr 3,26
	bl VectorLength
	fsubs 29,31,1
.L47:
	mr 3,27
	bl VectorNormalize
	lwz 3,256(31)
	fmr 1,29
	mr 4,27
	addi 3,3,620
	mr 5,3
	bl VectorMA
	addi 5,31,4
	li 3,23
	addi 4,1,8
	mr 6,5
	bl G_Spawn_Trails
	lis 9,level+4@ha
	lis 11,.LC4@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC4@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
.L25:
	lwz 0,196(1)
	mtlr 0
	lmw 25,140(1)
	lfd 29,168(1)
	lfd 30,176(1)
	lfd 31,184(1)
	la 1,192(1)
	blr
.Lfe1:
	.size	 Hook_Behavior,.Lfe1-Hook_Behavior
	.section	".rodata"
	.align 3
.LC14:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC15:
	.long 0x3f800000
	.align 2
.LC16:
	.long 0x40000000
	.align 2
.LC17:
	.long 0x0
	.align 3
.LC18:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Hook_Airborne
	.type	 Hook_Airborne,@function
Hook_Airborne:
	stwu 1,-128(1)
	mflr 0
	stmw 27,108(1)
	stw 0,132(1)
	mr 31,3
	addi 27,1,8
	mr 3,27
	li 4,0
	li 5,12
	crxor 6,6,6
	bl memset
	lwz 9,256(31)
	lwz 3,84(9)
	lwz 0,3812(3)
	andi. 0,0,1
	bc 4,2,.L54
	lis 29,gi@ha
	stw 0,3812(3)
	la 29,gi@l(29)
	lis 3,.LC3@ha
	lwz 28,256(31)
	lwz 9,36(29)
	la 3,.LC3@l(3)
	mtlr 9
	blrl
	lis 7,.LC15@ha
	lwz 0,16(29)
	lis 9,.LC16@ha
	la 7,.LC15@l(7)
	la 9,.LC16@l(9)
	lfs 1,0(7)
	mr 5,3
	li 4,6
	mtlr 0
	lis 7,.LC17@ha
	mr 3,28
	lfs 2,0(9)
	la 7,.LC17@l(7)
	lfs 3,0(7)
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L53
.L54:
	addi 4,1,40
	addi 5,1,56
	addi 3,3,3752
	li 6,0
	bl AngleVectors
	lwz 10,256(31)
	lis 0,0x4100
	addi 9,1,24
	stw 0,24(1)
	lis 8,0x4330
	stw 0,4(9)
	lis 7,.LC18@ha
	addi 28,1,72
	lwz 9,784(10)
	la 7,.LC18@l(7)
	addi 30,10,4
	lfd 13,0(7)
	mr 3,28
	li 4,0
	addi 9,9,-8
	li 5,12
	xoris 9,9,0x8000
	stw 9,100(1)
	stw 8,96(1)
	lfd 0,96(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,32(1)
	lwz 29,84(10)
	crxor 6,6,6
	bl memset
	lfs 12,28(1)
	lfs 0,24(1)
	lfs 13,32(1)
	stfs 12,76(1)
	stfs 0,72(1)
	stfs 13,80(1)
	lwz 0,716(29)
	cmpwi 0,0,0
	bc 4,2,.L56
	fneg 0,12
	stfs 0,76(1)
	b .L57
.L56:
	cmpwi 0,0,2
	bc 4,2,.L57
	li 0,0
	stw 0,4(28)
.L57:
	addi 4,1,72
	addi 5,1,40
	addi 6,1,56
	mr 3,30
	mr 7,27
	bl G_ProjectSource
	addi 5,31,4
	li 3,23
	addi 4,1,8
	mr 6,5
	bl G_Spawn_Trails
	lis 9,level+4@ha
	lis 11,.LC14@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC14@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
.L53:
	lwz 0,132(1)
	mtlr 0
	lmw 27,108(1)
	la 1,128(1)
	blr
.Lfe2:
	.size	 Hook_Airborne,.Lfe2-Hook_Airborne
	.section	".rodata"
	.align 2
.LC19:
	.string	"misc/menu3.wav"
	.align 2
.LC20:
	.string	"misc/menu1.wav"
	.align 3
.LC21:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC22:
	.long 0x3f800000
	.align 2
.LC23:
	.long 0x40000000
	.align 2
.LC24:
	.long 0x0
	.align 3
.LC25:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Hook_Touch
	.type	 Hook_Touch,@function
Hook_Touch:
	stwu 1,-160(1)
	mflr 0
	stmw 24,128(1)
	stw 0,164(1)
	mr 31,3
	mr 28,4
	addi 3,1,16
	mr 26,5
	addi 29,1,32
	mr 30,6
	li 4,0
	li 5,12
	mr 24,3
	mr 25,29
	crxor 6,6,6
	bl memset
	mr 3,29
	li 4,0
	li 5,12
	crxor 6,6,6
	bl memset
	lwz 9,256(31)
	xor 11,31,28
	subfic 0,11,0
	adde 11,0,11
	lwz 9,84(9)
	lwz 0,3812(9)
	xori 0,0,1
	rlwinm 0,0,0,31,31
	or. 11,0,11
	bc 12,2,.L62
	li 0,0
	lis 29,gi@ha
	stw 0,3812(9)
	la 29,gi@l(29)
	lis 3,.LC3@ha
	lwz 9,36(29)
	la 3,.LC3@l(3)
	lwz 28,256(31)
	b .L78
.L62:
	cmpwi 0,30,0
	bc 12,2,.L64
	lwz 0,16(30)
	andi. 10,0,4
	bc 12,2,.L64
	lis 29,gi@ha
	stw 11,3812(9)
	lis 3,.LC3@ha
	la 29,gi@l(29)
	la 3,.LC3@l(3)
	lwz 28,256(31)
	lwz 9,36(29)
.L78:
	mtlr 9
	blrl
	lis 9,.LC22@ha
	lwz 0,16(29)
	lis 10,.LC23@ha
	la 9,.LC22@l(9)
	mr 5,3
	lfs 1,0(9)
	la 10,.LC23@l(10)
	mr 3,28
	mtlr 0
	lis 9,.LC24@ha
	li 4,6
	lfs 2,0(10)
	la 9,.LC24@l(9)
	lfs 3,0(9)
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L61
.L64:
	lwz 9,256(31)
	addi 29,1,48
	addi 4,1,64
	addi 5,1,80
	addi 30,1,96
	lwz 3,84(9)
	li 6,0
	addi 3,3,3752
	bl AngleVectors
	lwz 10,256(31)
	lis 0,0x4100
	lis 9,.LC25@ha
	stw 0,48(1)
	la 9,.LC25@l(9)
	stw 0,4(29)
	lis 8,0x4330
	addi 27,10,4
	lfd 13,0(9)
	mr 3,30
	li 4,0
	lwz 9,784(10)
	li 5,12
	addi 9,9,-8
	xoris 9,9,0x8000
	stw 9,124(1)
	stw 8,120(1)
	lfd 0,120(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,56(1)
	lwz 29,84(10)
	crxor 6,6,6
	bl memset
	lfs 12,52(1)
	lfs 0,48(1)
	lfs 13,56(1)
	stfs 12,100(1)
	stfs 0,96(1)
	stfs 13,104(1)
	lwz 0,716(29)
	cmpwi 0,0,0
	bc 4,2,.L66
	fneg 0,12
	stfs 0,100(1)
	b .L67
.L66:
	cmpwi 0,0,2
	bc 4,2,.L67
	li 0,0
	stw 0,4(30)
.L67:
	mr 3,27
	mr 7,24
	addi 4,1,96
	addi 5,1,64
	addi 6,1,80
	bl G_ProjectSource
	lfs 12,4(31)
	mr 3,25
	lfs 11,16(1)
	lfs 13,8(31)
	lfs 0,12(31)
	fsubs 12,12,11
	lfs 10,20(1)
	lfs 11,24(1)
	fsubs 13,13,10
	stfs 12,32(1)
	fsubs 0,0,11
	stfs 13,36(1)
	stfs 0,40(1)
	bl VectorLength
	stfs 1,528(31)
	lwz 0,248(28)
	cmpwi 0,0,2
	bc 12,2,.L72
	cmpwi 0,0,3
	bc 12,2,.L74
	b .L71
.L72:
	lwz 0,84(28)
	cmpwi 0,0,0
	bc 12,2,.L71
	lis 29,gi@ha
	lis 3,.LC19@ha
	la 29,gi@l(29)
	la 3,.LC19@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC22@ha
	lwz 0,16(29)
	lis 10,.LC23@ha
	la 9,.LC22@l(9)
	mr 5,3
	lfs 1,0(9)
	la 10,.LC23@l(10)
	li 4,2
	mtlr 0
	lis 9,.LC24@ha
	mr 3,31
	lfs 2,0(10)
	la 9,.LC24@l(9)
	lfs 3,0(9)
	blrl
	addi 4,31,4
	li 3,1
	mr 5,26
	mr 6,4
	bl G_Spawn_Sparks
	b .L71
.L74:
	addi 4,31,4
	mr 5,26
	mr 6,4
	li 3,9
	bl G_Spawn_Sparks
	lis 29,gi@ha
	lis 3,.LC20@ha
	la 29,gi@l(29)
	la 3,.LC20@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC22@ha
	lwz 0,16(29)
	lis 10,.LC23@ha
	la 9,.LC22@l(9)
	mr 5,3
	lfs 1,0(9)
	la 10,.LC23@l(10)
	mtlr 0
	li 4,2
	lis 9,.LC24@ha
	mr 3,31
	lfs 2,0(10)
	la 9,.LC24@l(9)
	lfs 3,0(9)
	blrl
	li 0,0
	stw 0,632(31)
	stw 0,640(31)
	stw 0,636(31)
.L71:
	lwz 0,788(28)
	cmpwi 0,0,0
	bc 12,2,.L77
	lwz 5,256(31)
	li 0,0
	li 11,32
	lwz 9,792(31)
	mr 8,26
	mr 3,28
	stw 0,8(1)
	mr 4,31
	addi 6,31,620
	stw 11,12(1)
	addi 7,31,4
	li 10,100
	bl T_Damage
.L77:
	lfs 0,620(28)
	lis 9,.LC21@ha
	lis 11,Hook_Behavior@ha
	lwz 10,256(31)
	li 7,0
	la 11,Hook_Behavior@l(11)
	lfd 12,.LC21@l(9)
	lis 8,level+4@ha
	stfs 0,620(31)
	lfs 13,624(28)
	stfs 13,624(31)
	lfs 0,628(28)
	stfs 0,628(31)
	lwz 9,84(10)
	lwz 0,3812(9)
	ori 0,0,2
	stw 0,3812(9)
	stw 28,816(31)
	stw 7,688(31)
	stw 11,680(31)
	lfs 0,level+4@l(8)
	fadd 0,0,12
	frsp 0,0
	stfs 0,672(31)
.L61:
	lwz 0,164(1)
	mtlr 0
	lmw 24,128(1)
	la 1,160(1)
	blr
.Lfe3:
	.size	 Hook_Touch,.Lfe3-Hook_Touch
	.section	".rodata"
	.align 3
.LC26:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC27:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC28:
	.long 0x44c80000
	.section	".text"
	.align 2
	.globl Fire_Grapple_Hook
	.type	 Fire_Grapple_Hook,@function
Fire_Grapple_Hook:
	stwu 1,-128(1)
	mflr 0
	stmw 26,104(1)
	stw 0,132(1)
	mr 31,3
	li 0,1
	lwz 9,84(31)
	addi 4,1,40
	addi 29,1,8
	addi 5,1,56
	addi 30,1,72
	stw 0,3812(9)
	mr 26,4
	li 6,0
	lwz 3,84(31)
	addi 27,31,4
	addi 3,3,3752
	bl AngleVectors
	lwz 9,784(31)
	lis 10,0x4330
	lis 8,.LC27@ha
	lwz 28,84(31)
	lis 0,0x4100
	addi 9,9,-8
	la 8,.LC27@l(8)
	stw 0,12(1)
	xoris 9,9,0x8000
	lfd 13,0(8)
	mr 3,30
	stw 9,100(1)
	li 4,0
	li 5,12
	stw 10,96(1)
	lfd 0,96(1)
	stw 0,8(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,16(1)
	crxor 6,6,6
	bl memset
	lfs 0,8(1)
	stfs 0,72(1)
	lfs 13,4(29)
	stfs 13,76(1)
	lfs 0,8(29)
	stfs 0,80(1)
	lwz 0,716(28)
	cmpwi 0,0,0
	bc 4,2,.L80
	fneg 0,13
	stfs 0,76(1)
	b .L81
.L80:
	cmpwi 0,0,2
	bc 4,2,.L81
	li 0,0
	stw 0,4(30)
.L81:
	addi 6,1,56
	addi 7,1,24
	addi 4,1,72
	addi 5,1,40
	mr 3,27
	bl G_ProjectSource
	bl G_Spawn
	lfs 13,24(1)
	mr 29,3
	mr 3,26
	addi 4,29,16
	stfs 13,4(29)
	lfs 0,28(1)
	stfs 0,8(29)
	lfs 13,32(1)
	stfs 13,12(29)
	lfs 0,40(1)
	stfs 0,584(29)
	lfs 13,44(1)
	stfs 13,588(29)
	lfs 0,48(1)
	stfs 0,592(29)
	bl vectoangles
	lis 8,.LC28@ha
	mr 3,26
	la 8,.LC28@l(8)
	addi 4,29,620
	lfs 1,0(8)
	bl VectorScale
	lis 9,Hook_Touch@ha
	li 8,6
	stw 31,256(29)
	la 9,Hook_Touch@l(9)
	lis 11,0x600
	stw 8,264(29)
	stw 9,688(29)
	lis 10,Hook_Airborne@ha
	li 0,0
	ori 11,11,3
	li 9,2
	stw 0,200(29)
	la 10,Hook_Airborne@l(10)
	li 7,20
	stw 11,252(29)
	li 6,0
	stw 9,248(29)
	lis 8,level+4@ha
	stw 7,792(29)
	lis 11,.LC26@ha
	lis 9,gi+72@ha
	stw 6,804(29)
	mr 3,29
	stw 10,680(29)
	stw 0,196(29)
	stw 0,192(29)
	stw 0,188(29)
	stw 0,208(29)
	stw 0,204(29)
	lfs 0,level+4@l(8)
	lfd 13,.LC26@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(29)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,132(1)
	mtlr 0
	lmw 26,104(1)
	la 1,128(1)
	blr
.Lfe4:
	.size	 Fire_Grapple_Hook,.Lfe4-Fire_Grapple_Hook
	.section	".rodata"
	.align 2
.LC29:
	.string	"action"
	.align 2
.LC30:
	.string	"stop"
	.align 2
.LC31:
	.string	"grow"
	.align 2
.LC32:
	.string	"shrink"
	.section	".text"
	.align 2
	.globl Cmd_Hook_f
	.type	 Cmd_Hook_f,@function
Cmd_Hook_f:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 28,3
	mr 29,4
	lwz 31,84(28)
	lwz 0,3812(31)
	addi 30,31,3812
	andi. 9,0,1
	bc 4,2,.L91
	lis 4,.LC29@ha
	mr 3,29
	la 4,.LC29@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L85
	mr 3,28
	bl Fire_Grapple_Hook
	b .L84
.L85:
	lwz 0,3812(31)
	andi. 9,0,1
	bc 12,2,.L84
.L91:
	lis 4,.LC29@ha
	mr 3,29
	la 4,.LC29@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L87
	stw 3,0(30)
	b .L84
.L87:
	lis 4,.LC30@ha
	mr 3,29
	la 4,.LC30@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L88
	lwz 0,0(30)
	rlwinm 9,0,0,29,30
	subf 0,9,0
	b .L92
.L88:
	lis 4,.LC31@ha
	mr 3,29
	la 4,.LC31@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L89
	lwz 0,0(30)
	ori 0,0,4
	rlwinm 0,0,0,31,29
	b .L92
.L89:
	lis 4,.LC32@ha
	mr 3,29
	la 4,.LC32@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L84
	lwz 0,0(30)
	ori 0,0,2
	rlwinm 0,0,0,30,28
.L92:
	stw 0,0(30)
.L84:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 Cmd_Hook_f,.Lfe5-Cmd_Hook_f
	.align 2
	.globl P_ProjectSource_Reverse
	.type	 P_ProjectSource_Reverse,@function
P_ProjectSource_Reverse:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 29,5
	mr 28,3
	mr 31,4
	mr 30,6
	mr 27,7
	mr 26,8
	addi 3,1,8
	li 4,0
	li 5,12
	crxor 6,6,6
	bl memset
	lwz 0,716(28)
	lfs 12,4(29)
	lfs 13,8(29)
	cmpwi 0,0,0
	lfs 0,0(29)
	stfs 12,12(1)
	stfs 13,16(1)
	stfs 0,8(1)
	bc 4,2,.L7
	fneg 0,12
	stfs 0,12(1)
	b .L8
.L7:
	cmpwi 0,0,2
	bc 4,2,.L8
	li 0,0
	stw 0,12(1)
.L8:
	mr 3,31
	mr 5,30
	mr 6,27
	mr 7,26
	addi 4,1,8
	bl G_ProjectSource
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 P_ProjectSource_Reverse,.Lfe6-P_ProjectSource_Reverse
	.section	".rodata"
	.align 3
.LC33:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl get_start_position
	.type	 get_start_position,@function
get_start_position:
	stwu 1,-112(1)
	mflr 0
	stmw 27,92(1)
	stw 0,116(1)
	mr 29,3
	mr 27,4
	lwz 9,256(29)
	addi 28,1,8
	addi 4,1,24
	addi 5,1,40
	addi 31,1,56
	lwz 3,84(9)
	li 6,0
	addi 3,3,3752
	bl AngleVectors
	lis 9,.LC33@ha
	lwz 10,256(29)
	lis 0,0x4100
	la 9,.LC33@l(9)
	stw 0,12(1)
	lfd 13,0(9)
	lis 8,0x4330
	addi 30,10,4
	stw 0,8(1)
	mr 3,31
	li 4,0
	lwz 9,784(10)
	li 5,12
	addi 9,9,-8
	xoris 9,9,0x8000
	stw 9,84(1)
	stw 8,80(1)
	lfd 0,80(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,16(1)
	lwz 29,84(10)
	crxor 6,6,6
	bl memset
	lfs 0,8(1)
	stfs 0,56(1)
	lfs 13,4(28)
	stfs 13,60(1)
	lfs 0,8(28)
	stfs 0,64(1)
	lwz 0,716(29)
	cmpwi 0,0,0
	bc 4,2,.L11
	fneg 0,13
	stfs 0,60(1)
	b .L12
.L11:
	cmpwi 0,0,2
	bc 4,2,.L12
	li 0,0
	stw 0,4(31)
.L12:
	mr 3,30
	mr 7,27
	addi 4,1,56
	addi 5,1,24
	addi 6,1,40
	bl G_ProjectSource
	lwz 0,116(1)
	mtlr 0
	lmw 27,92(1)
	la 1,112(1)
	blr
.Lfe7:
	.size	 get_start_position,.Lfe7-get_start_position
	.section	".rodata"
	.align 2
.LC34:
	.long 0x3f800000
	.align 2
.LC35:
	.long 0x40000000
	.align 2
.LC36:
	.long 0x0
	.section	".text"
	.align 2
	.globl play_moving_chain_sound
	.type	 play_moving_chain_sound,@function
play_moving_chain_sound:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr. 30,4
	mr 31,3
	bc 12,2,.L16
	lwz 0,804(31)
	cmpwi 0,0,0
	bc 12,2,.L18
	cmpwi 0,0,1
	bc 12,2,.L19
	b .L22
.L18:
	lis 29,gi@ha
	lis 3,.LC0@ha
	lwz 28,256(31)
	la 29,gi@l(29)
	la 3,.LC0@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC34@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC34@l(9)
	li 4,6
	lfs 1,0(9)
	mtlr 0
	mr 3,28
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	lfs 2,0(9)
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfs 3,0(9)
	blrl
	li 0,1
	stw 0,804(31)
	b .L22
.L19:
	lis 29,gi@ha
	lis 3,.LC1@ha
	lwz 28,256(31)
	la 29,gi@l(29)
	la 3,.LC1@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC34@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC34@l(9)
	li 4,6
	lfs 1,0(9)
	mtlr 0
	mr 3,28
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	lfs 2,0(9)
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfs 3,0(9)
	blrl
	li 0,2
	stw 0,804(31)
	b .L22
.L16:
	lwz 0,804(31)
	cmpwi 0,0,0
	bc 12,2,.L22
	lis 29,gi@ha
	lis 3,.LC2@ha
	lwz 28,256(31)
	la 29,gi@l(29)
	la 3,.LC2@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC34@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC34@l(9)
	li 4,6
	lfs 1,0(9)
	mr 3,28
	mtlr 0
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	lfs 2,0(9)
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfs 3,0(9)
	blrl
	stw 30,804(31)
.L22:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 play_moving_chain_sound,.Lfe8-play_moving_chain_sound
	.section	".rodata"
	.align 2
.LC37:
	.long 0x3f800000
	.align 2
.LC38:
	.long 0x40000000
	.align 2
.LC39:
	.long 0x0
	.section	".text"
	.align 2
	.globl DropHook
	.type	 DropHook,@function
DropHook:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 28,3
	li 0,0
	lwz 11,256(28)
	lis 29,gi@ha
	lis 3,.LC3@ha
	la 29,gi@l(29)
	la 3,.LC3@l(3)
	lwz 9,84(11)
	stw 0,3812(9)
	lwz 9,36(29)
	lwz 27,256(28)
	mtlr 9
	blrl
	lis 9,.LC37@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC37@l(9)
	mr 3,27
	lfs 1,0(9)
	li 4,6
	mtlr 0
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfs 2,0(9)
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfs 3,0(9)
	blrl
	mr 3,28
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 DropHook,.Lfe9-DropHook
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
