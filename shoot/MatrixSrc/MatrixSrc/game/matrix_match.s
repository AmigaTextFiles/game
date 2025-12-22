	.file	"matrix_match.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"DEBUG: Starting in 3 Sec\n"
	.align 2
.LC1:
	.long 0x0
	.align 2
.LC2:
	.long 0x3f800000
	.align 3
.LC3:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC4:
	.long 0x40400000
	.align 2
.LC5:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl MatrixMatchThink
	.type	 MatrixMatchThink,@function
MatrixMatchThink:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 9,matchmode@ha
	lis 8,.LC1@ha
	lwz 11,matchmode@l(9)
	la 8,.LC1@l(8)
	li 10,0
	lfs 13,0(8)
	li 7,0
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L13
	lis 9,tankmode@ha
	lwz 11,tankmode@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L13
	lis 11,.LC2@ha
	lis 9,maxclients@ha
	la 11,.LC2@l(11)
	li 8,1
	lfs 0,0(11)
	lis 31,matrix@ha
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L17
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	addi 11,11,1116
	lfd 13,0(9)
.L19:
	cmpwi 0,11,0
	bc 12,2,.L18
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L18
	lwz 9,84(11)
	addi 7,7,1
	lwz 0,3480(9)
	cmpwi 0,0,0
	bc 4,2,.L18
	lwz 0,3492(9)
	addi 9,10,1
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,10,0
	or 10,0,9
.L18:
	addi 8,8,1
	xoris 0,8,0x8000
	addi 11,11,1116
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L19
.L17:
	cmpwi 7,10,1
	xor 9,10,7
	subfic 11,9,0
	adde 9,11,9
	mfcr 0
	rlwinm 0,0,30,1
	and. 8,0,9
	bc 12,2,.L24
	lis 9,matrix@ha
	la 10,matrix@l(9)
	lwz 0,8(10)
	cmpwi 0,0,0
	bc 4,2,.L24
	lwz 0,4(10)
	cmpwi 0,0,0
	bc 4,2,.L24
	lis 11,.LC4@ha
	lis 9,level+4@ha
	la 11,.LC4@l(11)
	lfs 0,level+4@l(9)
	lis 3,.LC0@ha
	lfs 13,0(11)
	la 3,.LC0@l(3)
	li 0,1
	lis 11,gi+4@ha
	lwz 9,gi+4@l(11)
	fadds 0,0,13
	stw 0,8(10)
	mtlr 9
	stfs 0,matrix@l(31)
	crxor 6,6,6
	blrl
.L24:
	lis 9,matrix@ha
	lis 11,level+4@ha
	lfs 13,matrix@l(9)
	la 10,matrix@l(9)
	lfs 0,level+4@l(11)
	fcmpu 0,13,0
	bc 4,2,.L25
	li 0,0
	li 9,1
	stw 0,8(10)
	stw 9,4(10)
.L25:
	lwz 0,4(10)
	cmpwi 0,0,0
	bc 12,2,.L13
	lis 9,matchtimelimit@ha
	lis 8,.LC1@ha
	lwz 11,matchtimelimit@l(9)
	la 8,.LC1@l(8)
	lfs 0,0(8)
	lfs 12,20(11)
	fcmpu 0,12,0
	bc 12,2,.L27
	lis 9,.LC5@ha
	lfs 13,matrix@l(31)
	la 9,.LC5@l(9)
	lfs 0,0(9)
	fmuls 0,12,0
	fcmpu 0,13,0
	cror 3,2,1
	bc 12,3,.L31
.L27:
	lis 11,.LC1@ha
	lis 9,teamfraglimit@ha
	la 11,.LC1@l(11)
	lfs 0,0(11)
	lwz 11,teamfraglimit@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L30
	lis 9,matrix@ha
	la 9,matrix@l(9)
	lis 10,0x4330
	lwz 0,20(9)
	lis 8,.LC3@ha
	la 8,.LC3@l(8)
	xoris 0,0,0x8000
	lfd 12,0(8)
	stw 0,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 12,3,.L31
	lwz 0,16(9)
	mr 9,11
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L30
.L31:
	li 0,1
	b .L28
.L30:
	li 0,0
.L28:
	cmpwi 0,0,0
	bc 12,2,.L13
	bl EndDMLevel
.L13:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 MatrixMatchThink,.Lfe1-MatrixMatchThink
	.section	".rodata"
	.align 2
.LC6:
	.string	"misc/udeath.wav"
	.align 2
.LC7:
	.string	"models/objects/gibs/chest/tris.md2"
	.align 3
.LC8:
	.long 0x3fd99999
	.long 0x9999999a
	.align 3
.LC9:
	.long 0x3fb47ae1
	.long 0x47ae147b
	.align 2
.LC10:
	.long 0x0
	.align 2
.LC11:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl MatrixRespawn
	.type	 MatrixRespawn,@function
MatrixRespawn:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	lwz 9,84(31)
	lwz 3,3844(9)
	cmpwi 0,3,0
	bc 12,2,.L34
	bl G_FreeEdict
.L34:
	lwz 9,84(31)
	lwz 3,3840(9)
	cmpwi 0,3,0
	bc 12,2,.L35
	bl G_FreeEdict
.L35:
	lis 29,gi@ha
	lis 3,.LC6@ha
	la 29,gi@l(29)
	la 3,.LC6@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC10@ha
	lwz 11,16(29)
	mr 5,3
	la 9,.LC10@l(9)
	li 4,4
	lfs 3,0(9)
	mtlr 11
	mr 3,31
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	lfs 1,0(9)
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	lfs 2,0(9)
	blrl
	lis 4,.LC7@ha
	li 6,0
	li 5,150
	la 4,.LC7@l(4)
	mr 3,31
	bl ThrowGib
	li 4,150
	mr 3,31
	bl ThrowClientHead
	lwz 11,84(31)
	li 0,0
	li 9,0
	stw 9,24(31)
	mr 3,31
	stw 0,512(31)
	stw 0,44(31)
	stw 0,48(31)
	stw 0,52(31)
	stw 9,16(31)
	stw 0,76(31)
	stw 0,3768(11)
	crxor 6,6,6
	bl TossClientWeapon
	mr 4,30
	mr 3,31
	mr 5,4
	crxor 6,6,6
	bl ClientObituary
	lwz 0,184(31)
	li 9,7
	mr 3,31
	stw 9,260(31)
	ori 0,0,2
	stw 0,184(31)
	crxor 6,6,6
	bl CopyToBodyQue
	lwz 0,184(31)
	mr 3,31
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	bl PutClientInServer
	lwz 9,100(29)
	li 3,1
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xbfc5
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,18087
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,2
	blrl
	lwz 9,100(29)
	li 3,9
	mtlr 9
	blrl
	lwz 0,88(29)
	addi 3,31,4
	li 4,2
	mtlr 0
	blrl
	lwz 9,84(31)
	li 0,32
	li 8,14
	lis 7,level+4@ha
	lis 11,.LC8@ha
	stb 0,16(9)
	lis 10,.LC9@ha
	li 3,0
	lwz 9,84(31)
	li 4,0
	lfd 1,.LC8@l(11)
	stb 8,17(9)
	lfs 0,level+4@l(7)
	lwz 9,84(31)
	lfd 2,.LC9@l(10)
	stfs 0,3824(9)
	lwz 5,84(31)
	addi 5,5,96
	creqv 6,6,6
	bl SV_AddBlend
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 MatrixRespawn,.Lfe2-MatrixRespawn
	.align 2
	.globl CheckWhosReady
	.type	 CheckWhosReady,@function
CheckWhosReady:
	blr
.Lfe3:
	.size	 CheckWhosReady,.Lfe3-CheckWhosReady
	.section	".rodata"
	.align 2
.LC12:
	.long 0x0
	.align 2
.LC13:
	.long 0x42700000
	.align 3
.LC14:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl MatrixMatchWin
	.type	 MatrixMatchWin,@function
MatrixMatchWin:
	stwu 1,-16(1)
	lis 9,matchtimelimit@ha
	lis 8,.LC12@ha
	lwz 11,matchtimelimit@l(9)
	la 8,.LC12@l(8)
	lfs 0,0(8)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L8
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 0,0(9)
	lis 9,matrix@ha
	fmuls 0,13,0
	lfs 13,matrix@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 12,3,.L11
.L8:
	lis 11,.LC12@ha
	lis 9,teamfraglimit@ha
	la 11,.LC12@l(11)
	lfs 0,0(11)
	lwz 11,teamfraglimit@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L10
	lis 9,matrix@ha
	la 9,matrix@l(9)
	lis 10,0x4330
	lwz 0,20(9)
	lis 8,.LC14@ha
	la 8,.LC14@l(8)
	xoris 0,0,0x8000
	lfd 12,0(8)
	stw 0,12(1)
	stw 10,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 12,3,.L11
	lwz 0,16(9)
	mr 9,11
	xoris 0,0,0x8000
	stw 0,12(1)
	stw 10,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L10
.L11:
	li 3,1
	b .L37
.L10:
	li 3,0
.L37:
	la 1,16(1)
	blr
.Lfe4:
	.size	 MatrixMatchWin,.Lfe4-MatrixMatchWin
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
