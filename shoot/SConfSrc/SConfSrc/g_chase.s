	.file	"g_chase.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"xv 0 yb -58 string2 \"Chasing %s\"xr -218 yb -78 string \"Hit 'TAB' or type 'menu'\" xr -218 yb -68 string \"to toggle menu.\" "
	.align 2
.LC1:
	.long 0x3f800000
	.align 3
.LC2:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC3:
	.long 0x42600000
	.align 2
.LC4:
	.long 0xc1f00000
	.align 2
.LC5:
	.long 0x41f00000
	.align 2
.LC6:
	.long 0x41800000
	.align 2
.LC7:
	.long 0x40c00000
	.align 2
.LC8:
	.long 0x40000000
	.align 2
.LC9:
	.long 0x47800000
	.align 2
.LC10:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl UpdateChaseCam
	.type	 UpdateChaseCam,@function
UpdateChaseCam:
	stwu 1,-1280(1)
	mflr 0
	stfd 30,1264(1)
	stfd 31,1272(1)
	stmw 25,1236(1)
	stw 0,1284(1)
	mr 31,3
	lwz 11,84(31)
	lwz 30,3832(11)
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 4,2,.L29
	stw 0,3832(11)
	lwz 9,84(31)
	lwz 0,3832(9)
	cmpwi 0,0,0
	bc 4,2,.L8
	lis 9,maxclients@ha
	lis 10,.LC1@ha
	lwz 11,maxclients@l(9)
	la 10,.LC1@l(10)
	li 29,1
	lfs 13,0(10)
	lis 26,maxclients@ha
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L8
	lis 11,.LC2@ha
	lis 27,g_edicts@ha
	la 11,.LC2@l(11)
	lis 28,0x4330
	lfd 31,0(11)
	li 30,892
.L12:
	lwz 0,g_edicts@l(27)
	add 31,0,30
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L11
	lwz 9,84(31)
	lwz 0,3832(9)
	cmpw 0,0,31
	bc 4,2,.L11
	mr 3,31
	bl UpdateChaseCam
.L11:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,892
	stw 0,1228(1)
	stw 28,1224(1)
	lfd 0,1224(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L12
.L8:
	lwz 11,84(31)
	li 10,0
	li 8,1
	lis 7,gi+72@ha
	mr 3,31
	stw 10,3840(11)
	lwz 9,84(31)
	stw 10,3844(9)
	lwz 11,84(31)
	sth 10,162(11)
	lwz 0,184(31)
	lwz 11,84(31)
	ori 0,0,1
	stw 8,260(31)
	stw 0,184(31)
	stw 10,248(31)
	stw 10,3428(11)
	lwz 9,84(31)
	stw 10,88(9)
	lwz 0,gi+72@l(7)
	b .L31
.L29:
	lwz 8,248(30)
	cmpwi 0,8,0
	bc 4,2,.L15
	lwz 0,184(31)
	li 9,1
	lis 10,gi+72@ha
	stw 9,260(31)
	mr 3,31
	ori 0,0,1
	stw 8,248(31)
	stw 0,184(31)
	stw 8,3428(11)
	lwz 9,84(31)
	stw 8,88(9)
	lwz 11,84(31)
	stw 8,3832(11)
	lwz 0,gi+72@l(10)
.L31:
	mtlr 0
	blrl
	b .L6
.L15:
	lfs 13,4(30)
	lis 11,0x4330
	lis 10,.LC2@ha
	la 10,.LC2@l(10)
	stfs 13,24(1)
	lfs 0,8(30)
	lfd 11,0(10)
	lis 10,.LC3@ha
	stfs 0,28(1)
	la 10,.LC3@l(10)
	lfs 12,12(30)
	lfs 10,0(10)
	stfs 12,32(1)
	lfs 0,4(31)
	stfs 0,1176(1)
	lfs 13,8(31)
	stfs 13,1180(1)
	lfs 0,12(31)
	stfs 0,1184(1)
	lwz 0,508(30)
	xoris 0,0,0x8000
	stw 0,1228(1)
	stw 11,1224(1)
	lfd 0,1224(1)
	fsub 0,0,11
	frsp 0,0
	fadds 12,12,0
	stfs 12,32(1)
	lwz 9,84(30)
	lfs 0,3656(9)
	stfs 0,1192(1)
	fcmpu 0,0,10
	lwz 9,84(30)
	lfs 0,3660(9)
	stfs 0,1196(1)
	lwz 9,84(30)
	lfs 0,3664(9)
	stfs 0,1200(1)
	bc 4,1,.L16
	stfs 10,1192(1)
.L16:
	addi 29,1,56
	addi 5,1,72
	addi 3,1,1192
	addi 28,1,24
	mr 4,29
	li 6,0
	bl AngleVectors
	mr 3,29
	bl VectorNormalize
	lis 9,.LC4@ha
	mr 3,28
	la 9,.LC4@l(9)
	mr 4,29
	lfs 1,0(9)
	addi 5,1,8
	bl VectorMA
	lis 9,.LC5@ha
	lfs 0,12(30)
	la 9,.LC5@l(9)
	lfs 12,16(1)
	lfs 13,0(9)
	fadds 0,0,13
	fcmpu 0,12,0
	bc 4,0,.L17
	stfs 0,16(1)
.L17:
	lwz 0,552(30)
	cmpwi 0,0,0
	bc 4,2,.L18
	lis 10,.LC6@ha
	lfs 0,16(1)
	la 10,.LC6@l(10)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,16(1)
.L18:
	lis 9,gi@ha
	lis 25,vec3_origin@ha
	la 26,gi@l(9)
	lis 11,.LC7@ha
	lwz 10,48(26)
	addi 27,1,88
	la 5,vec3_origin@l(25)
	la 11,.LC7@l(11)
	mr 6,5
	addi 7,1,8
	li 9,3
	mtlr 10
	lfs 31,0(11)
	mr 4,28
	mr 8,30
	mr 3,27
	lis 11,.LC1@ha
	la 11,.LC1@l(11)
	addi 28,1,40
	lfs 30,0(11)
	blrl
	lis 9,.LC8@ha
	lfs 12,100(1)
	mr 4,29
	lfs 13,104(1)
	la 9,.LC8@l(9)
	mr 3,28
	lfs 0,108(1)
	mr 5,28
	lfs 1,0(9)
	stfs 12,40(1)
	stfs 13,44(1)
	stfs 0,48(1)
	bl VectorMA
	lfs 12,48(1)
	la 5,vec3_origin@l(25)
	mr 3,27
	lwz 11,48(26)
	mr 4,28
	mr 6,5
	lfs 0,44(1)
	addi 7,1,8
	mr 8,30
	fadds 12,12,31
	lfs 13,40(1)
	li 9,3
	mtlr 11
	stfs 0,12(1)
	stfs 13,8(1)
	stfs 12,16(1)
	blrl
	lfs 0,96(1)
	fcmpu 0,0,30
	bc 4,0,.L19
	lfs 0,108(1)
	lfs 12,100(1)
	lfs 13,104(1)
	fsubs 0,0,31
	stfs 12,40(1)
	stfs 13,44(1)
	stfs 0,48(1)
.L19:
	lfs 12,48(1)
	la 5,vec3_origin@l(25)
	mr 3,27
	lwz 0,48(26)
	mr 4,28
	mr 6,5
	lfs 0,44(1)
	addi 7,1,8
	mr 8,30
	fsubs 12,12,31
	lfs 13,40(1)
	li 9,3
	mtlr 0
	stfs 0,12(1)
	stfs 13,8(1)
	stfs 12,16(1)
	blrl
	lfs 0,96(1)
	fcmpu 0,0,30
	bc 4,0,.L20
	lfs 0,108(1)
	lfs 12,100(1)
	lfs 13,104(1)
	fadds 0,0,31
	stfs 12,40(1)
	stfs 13,44(1)
	stfs 0,48(1)
.L20:
	lwz 9,84(31)
	li 0,4
	lis 10,.LC9@ha
	lis 11,.LC10@ha
	la 10,.LC9@l(10)
	stw 0,0(9)
	la 11,.LC10@l(11)
	li 29,0
	lfs 0,40(1)
	li 0,3
	li 7,0
	mtctr 0
	lfs 10,0(10)
	lfs 11,0(11)
	stfs 0,4(31)
	lfs 13,44(1)
	stfs 13,8(31)
	lfs 0,48(1)
	stfs 0,12(31)
.L30:
	lwz 8,84(31)
	add 0,29,29
	lwz 9,84(30)
	addi 29,29,1
	addi 11,8,3432
	addi 9,9,3656
	lfsx 12,11,7
	addi 8,8,20
	lfsx 0,9,7
	addi 7,7,4
	fsubs 0,0,12
	fmuls 0,0,10
	fdivs 0,0,11
	fctiwz 13,0
	stfd 13,1224(1)
	lwz 10,1228(1)
	sthx 10,8,0
	bdnz .L30
	lwz 9,84(30)
	li 10,0
	lis 8,gi+72@ha
	lwz 11,84(31)
	mr 3,31
	lfs 0,3656(9)
	stfs 0,28(11)
	lwz 9,84(30)
	lwz 11,84(31)
	lfs 0,3660(9)
	stfs 0,32(11)
	lwz 9,84(30)
	lwz 11,84(31)
	lfs 0,3664(9)
	stfs 0,36(11)
	lwz 9,84(30)
	lwz 11,84(31)
	lfs 0,3656(9)
	stfs 0,3656(11)
	lwz 9,84(30)
	lwz 11,84(31)
	lfs 0,3660(9)
	stfs 0,3660(11)
	lwz 9,84(30)
	lwz 11,84(31)
	lfs 0,3664(9)
	stfs 0,3664(11)
	lwz 9,84(31)
	stw 10,508(31)
	lbz 0,16(9)
	ori 0,0,64
	stb 0,16(9)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	lwz 11,84(31)
	lwz 0,3508(11)
	cmpwi 0,0,0
	bc 4,2,.L28
	lwz 0,3516(11)
	cmpwi 0,0,0
	bc 4,2,.L28
	lwz 0,3520(11)
	cmpwi 0,0,0
	bc 4,2,.L28
	lwz 0,3524(11)
	cmpwi 0,0,0
	bc 4,2,.L28
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,31
	bc 12,2,.L27
.L28:
	lwz 9,84(31)
	lwz 0,3836(9)
	mr 11,9
	cmpwi 0,0,0
	bc 12,2,.L6
.L27:
	li 0,0
	addi 28,1,152
	stw 0,3836(11)
	lis 4,.LC0@ha
	mr 3,28
	lwz 5,84(30)
	la 4,.LC0@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl sprintf
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,31
	li 4,0
	mtlr 0
	blrl
.L6:
	lwz 0,1284(1)
	mtlr 0
	lmw 25,1236(1)
	lfd 30,1264(1)
	lfd 31,1272(1)
	la 1,1280(1)
	blr
.Lfe1:
	.size	 UpdateChaseCam,.Lfe1-UpdateChaseCam
	.comm	highscore,1080,4
	.comm	gamescore,540,4
	.section	".rodata"
	.align 3
.LC11:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ChaseNext
	.type	 ChaseNext,@function
ChaseNext:
	stwu 1,-16(1)
	lwz 8,84(3)
	lwz 7,3832(8)
	cmpwi 0,7,0
	bc 12,2,.L32
	lis 9,g_edicts@ha
	mr 6,8
	lwz 11,g_edicts@l(9)
	lis 0,0xdb43
	lis 5,0x4330
	ori 0,0,47903
	lis 9,maxclients@ha
	mr 8,11
	lwz 10,maxclients@l(9)
	subf 11,11,7
	lis 9,.LC11@ha
	mullw 11,11,0
	la 9,.LC11@l(9)
	lfs 12,20(10)
	mr 7,6
	lfd 13,0(9)
	srawi 11,11,2
	mulli 0,11,892
	add 10,0,8
.L40:
	addi 11,11,1
	xoris 0,11,0x8000
	addi 10,10,892
	stw 0,12(1)
	stw 5,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,1,.L37
	addi 10,8,892
	li 11,1
.L37:
	mr 9,10
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L36
	lwz 0,248(9)
	cmpwi 0,0,0
	bc 4,2,.L35
.L36:
	lwz 0,3832(7)
	cmpw 0,9,0
	bc 4,2,.L40
.L35:
	stw 9,3832(6)
	li 0,1
	lwz 9,84(3)
	stw 0,3836(9)
.L32:
	la 1,16(1)
	blr
.Lfe2:
	.size	 ChaseNext,.Lfe2-ChaseNext
	.align 2
	.globl ChasePrev
	.type	 ChasePrev,@function
ChasePrev:
	stwu 1,-16(1)
	lwz 10,84(3)
	lwz 8,3832(10)
	cmpwi 0,8,0
	bc 12,2,.L41
	lis 9,g_edicts@ha
	lis 11,0xdb43
	lwz 0,g_edicts@l(9)
	ori 11,11,47903
	mr 5,10
	lis 9,maxclients@ha
	mr 7,0
	lwz 6,maxclients@l(9)
	subf 0,0,8
	mullw 0,0,11
	mr 8,5
	srawi 10,0,2
.L49:
	addic. 10,10,-1
	bc 12,1,.L46
	lfs 0,20(6)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 10,12(1)
.L46:
	mulli 0,10,892
	add 11,7,0
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L45
	lwz 0,248(11)
	cmpwi 0,0,0
	bc 4,2,.L44
.L45:
	lwz 0,3832(8)
	cmpw 0,11,0
	bc 4,2,.L49
.L44:
	stw 11,3832(5)
	li 0,1
	lwz 9,84(3)
	stw 0,3836(9)
.L41:
	la 1,16(1)
	blr
.Lfe3:
	.size	 ChasePrev,.Lfe3-ChasePrev
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
