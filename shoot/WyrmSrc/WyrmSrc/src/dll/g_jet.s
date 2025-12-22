	.file	"g_jet.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"misc/udeath.wav"
	.align 2
.LC1:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 3
.LC2:
	.long 0x400921fb
	.long 0x54442d18
	.align 3
.LC3:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC4:
	.long 0x43340000
	.align 2
.LC5:
	.long 0x0
	.align 2
.LC6:
	.long 0x41000000
	.align 2
.LC7:
	.long 0x3e000000
	.align 3
.LC8:
	.long 0x3fc00000
	.long 0x0
	.section	".text"
	.align 2
	.globl Jet_ApplyLifting
	.type	 Jet_ApplyLifting,@function
Jet_ApplyLifting:
	stwu 1,-144(1)
	mflr 0
	stfd 30,128(1)
	stfd 31,136(1)
	stmw 29,116(1)
	stw 0,148(1)
	lis 9,level@ha
	li 11,24
	lwz 0,level@l(9)
	lis 29,0x4330
	lis 9,.LC3@ha
	mr 31,3
	divw 11,0,11
	la 9,.LC3@l(9)
	lfd 31,0(9)
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	lfs 12,0(9)
	lis 9,.LC2@ha
	lfd 13,.LC2@l(9)
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	lfs 30,0(9)
	mulli 11,11,24
	subf 0,11,0
	mulli 0,0,15
	xoris 0,0,0x8000
	stw 0,108(1)
	stw 29,104(1)
	lfd 0,104(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,12
	fmr 1,0
	fmul 1,1,13
	bl sin
	fadd 1,1,1
	lis 9,.LC6@ha
	lfs 0,8(31)
	lis 10,.LC7@ha
	la 9,.LC6@l(9)
	lfs 9,12(31)
	la 10,.LC7@l(10)
	lfs 11,0(9)
	addi 3,31,376
	frsp 1,1
	lfs 12,4(31)
	stfs 0,12(1)
	mr 11,9
	lfs 10,0(10)
	fmuls 1,1,11
	stfs 12,8(1)
	fmr 0,1
	fctiwz 13,0
	stfd 13,104(1)
	lwz 9,108(1)
	xoris 9,9,0x8000
	stw 9,108(1)
	stw 29,104(1)
	lfd 0,104(1)
	fsub 0,0,31
	frsp 0,0
	fmadds 0,0,10,9
	stfs 0,16(1)
	bl VectorLength
	fcmpu 0,1,30
	bc 4,2,.L16
	lfs 12,8(1)
	lis 9,.LC8@ha
	lfs 0,12(1)
	la 9,.LC8@l(9)
	lfs 13,16(1)
	lfd 11,0(9)
	fsub 12,12,11
	fsub 0,0,11
	fsub 13,13,11
	frsp 12,12
	frsp 0,0
	frsp 13,13
	stfs 12,8(1)
	stfs 0,12(1)
	stfs 13,16(1)
.L16:
	lis 11,gi+48@ha
	lis 9,0x202
	lwz 0,gi+48@l(11)
	addi 3,1,24
	addi 4,31,4
	addi 5,31,188
	addi 6,31,200
	addi 7,1,8
	mr 8,31
	mtlr 0
	ori 9,9,3
	blrl
	lfs 0,56(1)
	fcmpu 0,0,30
	bc 4,2,.L17
	lfs 0,8(1)
	lfs 12,12(1)
	lfs 13,16(1)
	stfs 0,4(31)
	stfs 12,8(31)
	stfs 13,12(31)
.L17:
	lwz 0,148(1)
	mtlr 0
	lmw 29,116(1)
	lfd 30,128(1)
	lfd 31,136(1)
	la 1,144(1)
	blr
.Lfe1:
	.size	 Jet_ApplyLifting,.Lfe1-Jet_ApplyLifting
	.section	".rodata"
	.align 2
.LC10:
	.long 0x3d4ccccd
	.align 3
.LC11:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC12:
	.long 0x0
	.align 2
.LC13:
	.long 0x3f800000
	.align 2
.LC14:
	.long 0xbf800000
	.align 2
.LC15:
	.long 0x42700000
	.align 2
.LC16:
	.long 0x42200000
	.align 2
.LC17:
	.long 0x41f00000
	.align 2
.LC18:
	.long 0xc1f00000
	.align 3
.LC19:
	.long 0x40180000
	.long 0x0
	.align 3
.LC20:
	.long 0x401c0000
	.long 0x0
	.align 2
.LC21:
	.long 0x41000000
	.align 2
.LC22:
	.long 0x3e000000
	.align 2
.LC23:
	.long 0x43960000
	.align 2
.LC24:
	.long 0xc3960000
	.align 2
.LC25:
	.long 0xc0e00000
	.align 2
.LC26:
	.long 0xc2480000
	.section	".text"
	.align 2
	.globl Jet_ApplyJet
	.type	 Jet_ApplyJet,@function
Jet_ApplyJet:
	stwu 1,-176(1)
	mflr 0
	stfd 30,160(1)
	stfd 31,168(1)
	stmw 29,148(1)
	stw 0,180(1)
	mr 29,3
	li 0,0
	lwz 9,84(29)
	mr 31,4
	addi 5,1,40
	addi 4,1,24
	li 6,0
	sth 0,18(9)
	lwz 3,84(29)
	addi 3,3,3728
	bl AngleVectors
	lis 11,level@ha
	lwz 10,84(29)
	lwz 11,level@l(11)
	lis 8,0x4330
	lis 5,.LC11@ha
	la 5,.LC11@l(5)
	lfs 13,4000(10)
	xoris 0,11,0x8000
	lfd 12,0(5)
	stw 0,140(1)
	stw 8,136(1)
	lfd 0,136(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L21
	addi 0,11,1
	xoris 0,0,0x8000
	lis 11,.LC12@ha
	stw 0,140(1)
	la 11,.LC12@l(11)
	stw 8,136(1)
	lfd 0,136(1)
	lfs 10,0(11)
	fsub 0,0,12
	frsp 0,0
	stfs 0,4000(10)
	lha 0,8(31)
	stfs 10,16(1)
	cmpwi 0,0,0
	stfs 10,12(1)
	stfs 10,8(1)
	bc 12,2,.L22
	lis 5,.LC13@ha
	la 5,.LC13@l(5)
	lfs 9,0(5)
	bc 4,0,.L23
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfs 9,0(9)
.L23:
	lfs 12,24(1)
	lis 10,.LC15@ha
	lfs 0,28(1)
	la 10,.LC15@l(10)
	lfs 13,32(1)
	lfs 11,0(10)
	fmuls 12,9,12
	fmuls 0,9,0
	fmuls 13,9,13
	fmadds 12,12,11,10
	fmadds 0,0,11,10
	fmadds 13,13,11,10
	stfs 12,8(1)
	stfs 0,12(1)
	stfs 13,16(1)
.L22:
	lha 0,10(31)
	cmpwi 0,0,0
	bc 12,2,.L25
	lis 11,.LC13@ha
	la 11,.LC13@l(11)
	lfs 9,0(11)
	bc 4,0,.L26
	lis 5,.LC14@ha
	la 5,.LC14@l(5)
	lfs 9,0(5)
.L26:
	lfs 13,40(1)
	lis 9,.LC16@ha
	lfs 0,44(1)
	la 9,.LC16@l(9)
	lfs 10,0(9)
	lfs 11,8(1)
	fmuls 13,13,9
	lfs 12,12(1)
	fmuls 0,0,9
	fmadds 13,13,10,11
	fmadds 0,0,10,12
	stfs 13,8(1)
	stfs 0,12(1)
.L25:
	lha 0,12(31)
	cmpwi 0,0,0
	bc 12,2,.L28
	lfs 13,16(1)
	bc 4,1,.L29
	lis 10,.LC17@ha
	la 10,.LC17@l(10)
	lfs 0,0(10)
	b .L42
.L29:
	lis 11,.LC18@ha
	la 11,.LC18@l(11)
	lfs 0,0(11)
.L42:
	fadds 0,13,0
	stfs 0,16(1)
.L28:
	lfs 12,376(29)
	lis 31,.LC19@ha
	lis 5,.LC20@ha
	la 31,.LC19@l(31)
	lfs 13,380(29)
	la 5,.LC20@l(5)
	lfd 11,0(31)
	lis 9,.LC21@ha
	lfs 0,384(29)
	la 9,.LC21@l(9)
	mr 8,11
	lfd 10,0(5)
	mr 7,11
	mr 6,11
	lfs 31,8(1)
	mr 10,11
	lis 0,0x4330
	fdiv 7,12,11
	lfs 4,0(9)
	lis 31,.LC11@ha
	lis 5,.LC22@ha
	lfs 1,12(1)
	mr 9,11
	la 31,.LC11@l(31)
	lfs 2,16(1)
	la 5,.LC22@l(5)
	addi 4,29,376
	lfd 5,0(31)
	mr 3,4
	lis 31,.LC23@ha
	lfs 3,0(5)
	la 31,.LC23@l(31)
	li 5,0
	lfs 30,0(31)
	li 31,2
	mtctr 31
	fdiv 11,13,11
	fdiv 10,0,10
	fsub 12,12,7
	fsub 13,13,11
	fsub 0,0,10
	frsp 12,12
	frsp 13,13
	frsp 0,0
	fadds 12,12,31
	fadds 13,13,1
	fadds 0,0,2
	fmuls 12,12,4
	fmuls 13,13,4
	fmuls 0,0,4
	fmr 11,12
	fmr 10,13
	fmr 12,0
	fctiwz 8,11
	fctiwz 6,10
	fctiwz 9,12
	stfd 8,136(1)
	lwz 11,140(1)
	xoris 11,11,0x8000
	stw 11,140(1)
	stw 0,136(1)
	lfd 12,136(1)
	stfd 6,136(1)
	lwz 9,140(1)
	fsub 12,12,5
	xoris 9,9,0x8000
	stw 9,140(1)
	stw 0,136(1)
	frsp 12,12
	lfd 13,136(1)
	stfd 9,136(1)
	lwz 10,140(1)
	fmuls 12,12,3
	fsub 13,13,5
	xoris 10,10,0x8000
	stw 10,140(1)
	stw 0,136(1)
	frsp 13,13
	lfd 0,136(1)
	stfs 12,376(29)
	fmuls 13,13,3
	fsub 0,0,5
	stfs 13,380(29)
	frsp 0,0
	fmuls 0,0,3
	stfs 0,384(29)
.L34:
	lfsx 0,5,3
	fcmpu 0,0,30
	bc 4,1,.L35
	stfsx 30,5,4
	b .L33
.L35:
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L33
	stfsx 13,5,4
.L33:
	addi 5,5,4
	bdnz .L34
	addi 3,1,8
	bl VectorLength
	lis 5,.LC12@ha
	la 5,.LC12@l(5)
	lfs 0,0(5)
	fcmpu 0,1,0
	bc 4,2,.L21
	mr 3,29
	bl Jet_ApplyLifting
.L21:
	lfs 0,44(1)
	lis 11,.LC10@ha
	addi 5,1,72
	lfs 12,380(29)
	addi 4,1,56
	li 6,0
	lfs 11,40(1)
	lfs 13,376(29)
	fmuls 12,12,0
	lfs 9,48(1)
	lfs 0,384(29)
	lfs 10,.LC10@l(11)
	fmadds 13,13,11,12
	lwz 9,84(29)
	fmadds 0,0,9,13
	fmuls 0,0,10
	fneg 0,0
	stfs 0,3672(9)
	lwz 3,84(29)
	addi 3,3,3728
	bl AngleVectors
	lis 5,.LC25@ha
	addi 3,1,56
	la 5,.LC25@l(5)
	addi 4,1,88
	lfs 1,0(5)
	bl VectorScale
	lwz 0,508(29)
	lis 11,0x4330
	lis 5,.LC11@ha
	lfs 9,96(1)
	lis 10,.LC26@ha
	xoris 0,0,0x8000
	la 5,.LC11@l(5)
	lfs 13,12(29)
	stw 0,140(1)
	la 10,.LC26@l(10)
	addi 4,1,104
	stw 11,136(1)
	addi 3,1,56
	lfd 10,0(5)
	fadds 9,9,13
	lfd 0,136(1)
	lfs 12,4(29)
	lfs 13,88(1)
	fsub 0,0,10
	lfs 11,92(1)
	lfs 10,8(29)
	fadds 13,13,12
	lfs 1,0(10)
	frsp 0,0
	fadds 11,11,10
	stfs 13,88(1)
	fadds 9,9,0
	stfs 11,92(1)
	stfs 9,96(1)
	bl VectorScale
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,9
	mtlr 9
	blrl
	lwz 9,120(29)
	addi 3,1,88
	mtlr 9
	blrl
	lwz 9,124(29)
	addi 3,1,104
	mtlr 9
	blrl
	lwz 0,88(29)
	addi 3,1,88
	li 4,2
	mtlr 0
	blrl
	lwz 0,180(1)
	mtlr 0
	lmw 29,148(1)
	lfd 30,160(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe2:
	.size	 Jet_ApplyJet,.Lfe2-Jet_ApplyJet
	.section	".rodata"
	.align 3
.LC27:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC28:
	.long 0x0
	.section	".text"
	.align 2
	.globl Jet_AvoidGround
	.type	 Jet_AvoidGround,@function
Jet_AvoidGround:
	stwu 1,-112(1)
	mflr 0
	stfd 31,104(1)
	stw 31,100(1)
	stw 0,116(1)
	mr 31,3
	lis 9,.LC27@ha
	lfs 0,12(31)
	la 9,.LC27@l(9)
	lis 11,gi+48@ha
	lfd 31,0(9)
	addi 3,1,24
	addi 4,31,4
	lwz 0,gi+48@l(11)
	lis 9,0x202
	addi 5,31,188
	lfs 13,8(31)
	ori 9,9,3
	addi 6,31,200
	lfs 12,4(31)
	addi 7,1,8
	mr 8,31
	mtlr 0
	fadd 0,0,31
	stfs 13,12(1)
	stfs 12,8(1)
	frsp 0,0
	stfs 0,16(1)
	blrl
	lis 9,.LC28@ha
	lfs 13,56(1)
	la 9,.LC28@l(9)
	lfs 0,0(9)
	fcmpu 7,13,0
	mfcr 3
	rlwinm. 3,3,31,1
	bc 12,2,.L7
	lfs 0,12(31)
	fadd 0,0,31
	frsp 0,0
	stfs 0,12(31)
.L7:
	lwz 0,116(1)
	mtlr 0
	lwz 31,100(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe3:
	.size	 Jet_AvoidGround,.Lfe3-Jet_AvoidGround
	.section	".rodata"
	.align 3
.LC29:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Jet_Active
	.type	 Jet_Active,@function
Jet_Active:
	stwu 1,-16(1)
	lis 11,level@ha
	lwz 10,84(3)
	lwz 0,level@l(11)
	lis 8,0x4330
	lis 11,.LC29@ha
	lfs 12,3996(10)
	xoris 0,0,0x8000
	la 11,.LC29@l(11)
	stw 0,12(1)
	stw 8,8(1)
	lfd 13,0(11)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 7,12,0
	cror 31,30,29
	mfcr 3
	rlwinm 3,3,0,1
	la 1,16(1)
	blr
.Lfe4:
	.size	 Jet_Active,.Lfe4-Jet_Active
	.section	".rodata"
	.align 2
.LC30:
	.long 0x3f800000
	.align 2
.LC31:
	.long 0x0
	.section	".text"
	.align 2
	.globl Jet_BecomeExplosion
	.type	 Jet_BecomeExplosion,@function
Jet_BecomeExplosion:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 30,3
	la 29,gi@l(29)
	li 3,3
	lwz 9,100(29)
	mr 27,4
	addi 28,30,4
	lis 26,.LC1@ha
	li 31,4
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,5
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,88(29)
	mr 3,28
	li 4,2
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	mtlr 9
	blrl
	lis 9,.LC30@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC30@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	lfs 2,0(9)
	lis 9,.LC31@ha
	la 9,.LC31@l(9)
	lfs 3,0(9)
	blrl
.L13:
	mr 3,30
	la 4,.LC1@l(26)
	mr 5,27
	li 6,0
	bl ThrowGib
	addic. 31,31,-1
	bc 4,2,.L13
	mr 4,27
	mr 3,30
	bl ThrowClientHead
	stw 31,512(30)
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 Jet_BecomeExplosion,.Lfe5-Jet_BecomeExplosion
	.section	".rodata"
	.align 2
.LC32:
	.long 0xc0e00000
	.align 3
.LC33:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC34:
	.long 0xc2480000
	.section	".text"
	.align 2
	.globl Jet_ApplySparks
	.type	 Jet_ApplySparks,@function
Jet_ApplySparks:
	stwu 1,-112(1)
	mflr 0
	stmw 27,92(1)
	stw 0,116(1)
	mr 29,3
	addi 28,1,40
	lwz 3,84(29)
	addi 27,1,56
	addi 4,1,8
	addi 5,1,24
	li 6,0
	addi 3,3,3728
	bl AngleVectors
	lis 9,.LC32@ha
	addi 3,1,8
	la 9,.LC32@l(9)
	mr 4,28
	lfs 1,0(9)
	bl VectorScale
	lwz 0,508(29)
	lis 11,0x4330
	lis 10,.LC33@ha
	lfs 9,48(1)
	mr 4,27
	xoris 0,0,0x8000
	la 10,.LC33@l(10)
	lfs 13,12(29)
	stw 0,84(1)
	addi 3,1,8
	stw 11,80(1)
	lfd 0,80(1)
	fadds 9,9,13
	lfd 10,0(10)
	lfs 12,4(29)
	lis 10,.LC34@ha
	lfs 13,40(1)
	la 10,.LC34@l(10)
	fsub 0,0,10
	lfs 11,44(1)
	lfs 10,8(29)
	fadds 13,13,12
	lfs 1,0(10)
	frsp 0,0
	fadds 11,11,10
	stfs 13,40(1)
	fadds 9,9,0
	stfs 11,44(1)
	stfs 9,48(1)
	bl VectorScale
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,9
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,124(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
	lwz 0,116(1)
	mtlr 0
	lmw 27,92(1)
	la 1,112(1)
	blr
.Lfe6:
	.size	 Jet_ApplySparks,.Lfe6-Jet_ApplySparks
	.section	".rodata"
	.align 2
.LC35:
	.long 0x3d4ccccd
	.section	".text"
	.align 2
	.globl Jet_ApplyRolling
	.type	 Jet_ApplyRolling,@function
Jet_ApplyRolling:
	lfs 0,4(4)
	lis 11,.LC35@ha
	lfs 13,380(3)
	lfs 12,376(3)
	lfs 11,0(4)
	fmuls 13,13,0
	lfs 9,8(4)
	lfs 0,384(3)
	lfs 10,.LC35@l(11)
	fmadds 12,12,11,13
	lwz 9,84(3)
	fmadds 0,0,9,12
	fmuls 0,0,10
	fneg 0,0
	stfs 0,3672(9)
	blr
.Lfe7:
	.size	 Jet_ApplyRolling,.Lfe7-Jet_ApplyRolling
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
