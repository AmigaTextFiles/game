	.file	"s_build.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.long 0x41800000
	.align 2
.LC1:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl CheckArea
	.type	 CheckArea,@function
CheckArea:
	stwu 1,-144(1)
	mflr 0
	stfd 30,128(1)
	stfd 31,136(1)
	stmw 26,104(1)
	stw 0,148(1)
	lis 9,gi@ha
	mr 31,3
	la 29,gi@l(9)
	addi 26,31,4
	lwz 9,52(29)
	mr 3,26
	mr 27,4
	mtlr 9
	blrl
	addi 3,3,-1
	cmplwi 0,3,1
	bc 4,1,.L13
	lfs 11,200(31)
	lis 9,.LC0@ha
	addi 3,1,8
	lfs 12,4(31)
	la 9,.LC0@l(9)
	lfs 13,8(31)
	lfs 10,204(31)
	fadds 12,12,11
	lfs 0,12(31)
	lfs 11,208(31)
	lfs 31,0(9)
	fadds 13,13,10
	lwz 9,52(29)
	fadds 0,0,11
	fadds 12,12,31
	mtlr 9
	fadds 13,13,31
	fadds 0,0,31
	stfs 12,8(1)
	stfs 13,12(1)
	stfs 0,16(1)
	blrl
	addi 3,3,-1
	cmplwi 0,3,1
	bc 4,1,.L13
	lfs 0,188(31)
	lis 11,.LC1@ha
	addi 28,1,40
	lfs 12,4(31)
	la 11,.LC1@l(11)
	addi 30,1,24
	lfs 13,8(31)
	lis 9,0x203
	mr 3,28
	lfs 10,192(31)
	addi 4,1,8
	li 5,0
	fadds 12,12,0
	lfs 11,196(31)
	li 6,0
	mr 7,30
	lfs 0,12(31)
	mr 8,31
	ori 9,9,59
	lfs 30,0(11)
	fadds 13,13,10
	lwz 11,48(29)
	fsubs 12,12,31
	fadds 0,0,11
	fsubs 13,13,31
	mtlr 11
	stfs 12,24(1)
	fsubs 0,0,31
	stfs 13,28(1)
	stfs 0,32(1)
	blrl
	lfs 0,48(1)
	fcmpu 0,0,30
	bc 4,2,.L13
	lwz 9,52(29)
	mr 3,30
	mtlr 9
	blrl
	addi 3,3,-1
	cmplwi 0,3,1
	bc 4,1,.L13
	lfs 11,188(31)
	addi 3,1,8
	lfs 12,4(31)
	lfs 13,8(31)
	lfs 10,204(31)
	fadds 12,12,11
	lfs 0,12(31)
	lfs 11,208(31)
	fadds 13,13,10
	lwz 9,52(29)
	fsubs 12,12,31
	fadds 0,0,11
	mtlr 9
	fadds 13,13,31
	stfs 12,8(1)
	fadds 0,0,31
	stfs 13,12(1)
	stfs 0,16(1)
	blrl
	addi 3,3,-1
	cmplwi 0,3,1
	bc 4,1,.L13
	lfs 0,200(31)
	lis 9,0x203
	mr 8,31
	lfs 12,4(31)
	mr 3,28
	addi 4,1,8
	lfs 13,8(31)
	li 5,0
	li 6,0
	lfs 10,192(31)
	mr 7,30
	ori 9,9,59
	fadds 12,12,0
	lfs 11,196(31)
	lfs 0,12(31)
	fadds 13,13,10
	lwz 11,48(29)
	fadds 12,12,31
	fadds 0,0,11
	mtlr 11
	fsubs 13,13,31
	stfs 12,24(1)
	fsubs 0,0,31
	stfs 13,28(1)
	stfs 0,32(1)
	blrl
	lfs 0,48(1)
	fcmpu 0,0,30
	bc 4,2,.L13
	lwz 9,52(29)
	mr 3,30
	mtlr 9
	blrl
	addi 3,3,-1
	cmplwi 0,3,1
	bc 4,1,.L13
	lwz 0,48(29)
	lis 9,0x203
	mr 3,28
	mr 7,26
	mr 8,27
	addi 4,27,4
	li 5,0
	mtlr 0
	li 6,0
	ori 9,9,59
	blrl
	lfs 0,48(1)
	fcmpu 7,0,30
	mfcr 3
	rlwinm 3,3,31,1
	b .L15
.L13:
	li 3,0
.L15:
	lwz 0,148(1)
	mtlr 0
	lmw 26,104(1)
	lfd 30,128(1)
	lfd 31,136(1)
	la 1,144(1)
	blr
.Lfe1:
	.size	 CheckArea,.Lfe1-CheckArea
	.section	".rodata"
	.align 2
.LC2:
	.string	"models/weapons/s_rail/tris.md2"
	.align 2
.LC3:
	.string	"models/weapons/s_rocket/tris.md2"
	.align 2
.LC4:
	.string	"models/weapons/s_chain/tris.md2"
	.align 2
.LC5:
	.long 0x40000000
	.align 2
.LC6:
	.long 0x40800000
	.align 2
.LC7:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl sentry_fire_inflictor
	.type	 sentry_fire_inflictor,@function
sentry_fire_inflictor:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	lwz 3,540(31)
	mr 29,5
	mr 4,31
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L24
	lwz 0,900(31)
	cmpwi 0,0,0
	bc 4,2,.L26
	lwz 9,924(31)
	cmpwi 0,9,0
	bc 12,2,.L27
	stw 9,900(31)
	lis 0,0x40a0
	lis 3,.LC2@ha
	lis 9,gi+32@ha
	stw 0,328(31)
	la 3,.LC2@l(3)
	b .L40
.L27:
	lwz 9,912(31)
	cmpwi 0,9,0
	bc 12,2,.L29
	stw 9,900(31)
	lis 0,0x3f80
	lis 3,.LC3@ha
	lis 9,gi+32@ha
	stw 0,328(31)
	la 3,.LC3@l(3)
	b .L40
.L29:
	lwz 9,920(31)
	cmpwi 0,9,0
	bc 12,2,.L31
	stw 9,900(31)
	lis 0,0x4080
	lis 3,.LC3@ha
	lis 9,gi+32@ha
	stw 0,328(31)
	la 3,.LC3@l(3)
	b .L40
.L31:
	lwz 9,916(31)
	cmpwi 0,9,0
	bc 12,2,.L24
	stw 9,900(31)
	lis 0,0x4000
	lis 3,.LC4@ha
	lis 9,gi+32@ha
	stw 0,328(31)
	la 3,.LC4@l(3)
.L40:
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
	stw 3,44(31)
	b .L24
.L26:
	lis 9,.LC5@ha
	lfs 13,328(31)
	la 9,.LC5@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L35
	mr 3,31
	bl sentry_noise
	li 9,500
	li 10,16
	mr 4,30
	mr 5,29
	mr 3,31
	li 6,10
	li 7,4
	li 8,300
	bl monster_fire_bullet
	lwz 11,900(31)
	lis 10,MeanOfDeath@ha
	li 0,1
	lwz 9,916(31)
	stw 0,MeanOfDeath@l(10)
	addi 11,11,-1
	addi 9,9,-1
	stw 11,900(31)
	stw 9,916(31)
	b .L24
.L35:
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L37
	mr 4,30
	mr 5,29
	mr 3,31
	li 6,40
	li 7,800
	li 8,16
	bl monster_fire_rocket
	lwz 11,900(31)
	lis 10,MeanOfDeath@ha
	li 0,2
	lwz 9,920(31)
	stw 0,MeanOfDeath@l(10)
	addi 11,11,-1
	addi 9,9,-1
	stw 11,900(31)
	stw 9,920(31)
	b .L24
.L37:
	lis 9,.LC7@ha
	la 9,.LC7@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L24
	mr 4,30
	mr 5,29
	mr 3,31
	li 6,60
	li 7,10
	li 8,16
	bl monster_fire_railgun
	lwz 11,900(31)
	lis 10,MeanOfDeath@ha
	li 0,3
	lwz 9,924(31)
	stw 0,MeanOfDeath@l(10)
	addi 11,11,-1
	addi 9,9,-1
	stw 11,900(31)
	stw 9,924(31)
.L24:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 sentry_fire_inflictor,.Lfe2-sentry_fire_inflictor
	.section	".rodata"
	.align 2
.LC8:
	.long 0xbe4ccccd
	.align 3
.LC9:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl sentry_attack2
	.type	 sentry_attack2,@function
sentry_attack2:
	stwu 1,-128(1)
	mflr 0
	stmw 27,108(1)
	stw 0,132(1)
	mr 30,3
	addi 29,1,24
	addi 31,1,40
	lis 0,0x4170
	lis 9,0x4190
	lis 11,0x4204
	stw 0,72(1)
	addi 28,30,16
	stw 9,76(1)
	mr 4,29
	mr 3,28
	stw 11,80(1)
	mr 5,31
	li 6,0
	mr 27,29
	bl AngleVectors
	addi 3,30,4
	addi 4,1,72
	mr 5,29
	mr 6,31
	addi 7,1,8
	bl G_ProjectSource
	lwz 3,540(30)
	cmpwi 0,3,0
	bc 12,2,.L42
	lis 9,.LC8@ha
	addi 4,3,376
	lfs 1,.LC8@l(9)
	addi 3,3,4
	addi 5,1,56
	bl VectorMA
	lis 9,.LC9@ha
	lwz 10,540(30)
	la 9,.LC9@l(9)
	lfs 0,8(1)
	lis 0,0x4330
	lfd 8,0(9)
	mr 3,27
	lwz 9,508(10)
	lfs 11,56(1)
	addi 9,9,-8
	lfs 9,64(1)
	xoris 9,9,0x8000
	lfs 12,60(1)
	stw 9,100(1)
	fsubs 11,11,0
	stw 0,96(1)
	lfd 0,96(1)
	lfs 10,12(1)
	lfs 13,16(1)
	fsub 0,0,8
	stfs 11,24(1)
	fsubs 12,12,10
	frsp 0,0
	stfs 12,28(1)
	fadds 9,9,0
	fsubs 13,9,13
	stfs 9,64(1)
	stfs 13,32(1)
	bl VectorNormalize
	b .L43
.L42:
	mr 3,28
	mr 5,31
	mr 4,27
	li 6,0
	bl AngleVectors
.L43:
	mr 3,30
	mr 5,27
	addi 4,1,8
	bl sentry_fire_inflictor
	lwz 0,132(1)
	mtlr 0
	lmw 27,108(1)
	la 1,128(1)
	blr
.Lfe3:
	.size	 sentry_attack2,.Lfe3-sentry_attack2
	.section	".rodata"
	.align 2
.LC10:
	.string	"bullets"
	.align 2
.LC11:
	.string	"weapons/chngnl1a.wav"
	.align 2
.LC12:
	.string	"float/fltsrch1.wav"
	.globl sentry_stand_frames
	.section	".data"
	.align 2
	.type	 sentry_stand_frames,@object
sentry_stand_frames:
	.long ai_stand
	.long 0x0
	.long sentry_noise_rotate
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long sentry_noise_rotate
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.size	 sentry_stand_frames,192
	.globl sentry_move_stand1
	.align 2
	.type	 sentry_move_stand1,@object
	.size	 sentry_move_stand1,16
sentry_move_stand1:
	.long 0
	.long 15
	.long sentry_stand_frames
	.long sentry_stand
	.globl sentry_attack2_frames
	.align 2
	.type	 sentry_attack2_frames,@object
sentry_attack2_frames:
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0xc0400000
	.long sentry_attack2
	.long ai_charge
	.long 0xc0000000
	.long 0
	.long ai_charge
	.long 0xbf800000
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x3f800000
	.long 0
	.long ai_charge
	.long 0x40000000
	.long 0
	.long ai_charge
	.long 0x40400000
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.size	 sentry_attack2_frames,192
	.globl sentry_move_attack2
	.align 2
	.type	 sentry_move_attack2,@object
	.size	 sentry_move_attack2,16
sentry_move_attack2:
	.long 16
	.long 27
	.long sentry_attack2_frames
	.long sentry_run
	.globl sentry_attack3_frames
	.align 2
	.type	 sentry_attack3_frames,@object
sentry_attack3_frames:
	.long ai_charge
	.long 0x0
	.long sentry_attack2
	.long ai_charge
	.long 0x0
	.long sentry_attack2
	.long ai_charge
	.long 0x0
	.long sentry_attack2
	.long ai_charge
	.long 0x0
	.long sentry_attack2
	.long ai_charge
	.long 0xc0400000
	.long sentry_attack2
	.long ai_charge
	.long 0xc0000000
	.long sentry_attack2
	.long ai_charge
	.long 0xbf800000
	.long sentry_attack2
	.long ai_charge
	.long 0x0
	.long sentry_attack2
	.long ai_charge
	.long 0x3f800000
	.long sentry_attack2
	.long ai_charge
	.long 0x40000000
	.long sentry_attack2
	.long ai_charge
	.long 0x40400000
	.long sentry_attack2
	.long ai_charge
	.long 0x0
	.long sentry_attack2
	.long ai_charge
	.long 0x0
	.long sentry_attack2
	.long ai_charge
	.long 0x0
	.long sentry_attack2
	.long ai_charge
	.long 0x0
	.long sentry_attack2
	.long ai_charge
	.long 0x0
	.long sentry_attack2
	.size	 sentry_attack3_frames,192
	.globl sentry_move_attack3
	.align 2
	.type	 sentry_move_attack3,@object
	.size	 sentry_move_attack3,16
sentry_move_attack3:
	.long 16
	.long 27
	.long sentry_attack3_frames
	.long sentry_run
	.globl sentry_pain_frames
	.align 2
	.type	 sentry_pain_frames,@object
sentry_pain_frames:
	.long ai_move
	.long 0xc0000000
	.long 0
	.long ai_move
	.long 0xbf800000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x40000000
	.long 0
	.size	 sentry_pain_frames,48
	.globl sentry_move_pain1
	.align 2
	.type	 sentry_move_pain1,@object
	.size	 sentry_move_pain1,16
sentry_move_pain1:
	.long 28
	.long 31
	.long sentry_pain_frames
	.long sentry_run
	.section	".rodata"
	.align 2
.LC14:
	.string	"Sentry repaired.\n"
	.align 2
.LC15:
	.string	"slugs"
	.align 2
.LC16:
	.string	"Slugs added.\n"
	.align 2
.LC17:
	.string	"rockets"
	.align 2
.LC18:
	.string	"Rockets added.\n"
	.align 2
.LC19:
	.string	"Bullets added.\n"
	.align 2
.LC20:
	.long 0x0
	.align 3
.LC21:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Sentry_AddAmmo
	.type	 Sentry_AddAmmo,@function
Sentry_AddAmmo:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 25,28(1)
	stw 0,68(1)
	mr 28,3
	mr 30,5
	lwz 10,1104(28)
	lwz 0,892(10)
	cmpw 0,4,0
	bc 12,1,.L67
	cmpwi 0,4,0
	bc 4,2,.L69
	lwz 9,480(28)
	lwz 11,484(10)
	cmpw 7,30,9
	mr 8,9
	lwz 10,480(10)
	addi 9,9,-1
	cmpw 0,10,11
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,9,0
	and 0,30,0
	or 30,0,9
	bc 12,1,.L67
	add 0,10,30
	cmpwi 0,0,200
	bc 4,1,.L72
	cmpw 0,30,8
	subfic 31,10,200
	bc 4,2,.L75
	cmpw 7,30,31
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,30,0
	and 0,31,0
	or 31,0,9
	b .L75
.L72:
	mr 31,30
.L75:
	lis 9,.LC20@ha
	lfs 0,948(28)
	subf 0,31,8
	la 9,.LC20@l(9)
	stw 0,480(28)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 12,2,.L76
	bl rand
	lis 0,0x51eb
	srawi 9,3,31
	ori 0,0,34079
	mulhw 0,3,0
	srawi 0,0,5
	subf 0,9,0
	mulli 0,0,100
	subf 3,0,3
	cmpw 0,3,31
	bc 4,0,.L77
	xoris 11,31,0x8000
	lfs 11,948(28)
	stw 11,20(1)
	lis 0,0x4330
	lis 10,.LC21@ha
	stw 0,16(1)
	la 10,.LC21@l(10)
	mr 11,9
	lfd 13,0(10)
	lfd 0,16(1)
	stfs 31,948(28)
	fsub 0,0,13
	frsp 0,0
	fsubs 0,0,11
	fmr 13,0
	fctiwz 12,13
	stfd 12,16(1)
	lwz 31,20(1)
	b .L76
.L77:
	xoris 0,31,0x8000
	lfs 12,948(28)
	stw 0,20(1)
	lis 11,0x4330
	lis 10,.LC21@ha
	la 10,.LC21@l(10)
	stw 11,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fsubs 12,12,0
	stfs 12,948(28)
.L76:
	lwz 9,1104(28)
	cmpwi 0,31,0
	lwz 0,480(9)
	add 0,0,31
	stw 0,480(9)
	bc 12,2,.L67
	lis 9,gi+8@ha
	lis 5,.LC14@ha
	lwz 0,gi+8@l(9)
	mr 3,28
	la 5,.LC14@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L67
.L69:
	cmpwi 0,4,3
	bc 4,2,.L81
	lis 3,.LC15@ha
	lwz 29,84(28)
	lis 27,0x286b
	la 3,.LC15@l(3)
	ori 27,27,51739
	bl FindItem
	lis 25,.LC15@ha
	lis 9,itemlist@ha
	addi 29,29,740
	la 26,itemlist@l(9)
	subf 3,26,3
	mullw 3,3,27
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpw 0,30,0
	bc 4,1,.L82
	lwz 29,84(28)
	la 3,.LC15@l(25)
	bl FindItem
	subf 3,26,3
	addi 29,29,740
	mullw 3,3,27
	rlwinm 3,3,0,0,29
	lwzx 30,29,3
.L82:
	lwz 9,1104(28)
	lwz 11,924(9)
	cmpwi 0,11,19
	bc 12,1,.L67
	add 0,11,30
	cmpwi 0,0,20
	bc 4,1,.L84
	lwz 29,84(28)
	subfic 31,11,20
	la 3,.LC15@l(25)
	bl FindItem
	subf 3,26,3
	addi 29,29,740
	mullw 3,3,27
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpw 0,30,0
	bc 4,2,.L87
	cmpw 7,30,31
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,30,0
	and 0,31,0
	or 31,0,9
	b .L87
.L84:
	mr 31,30
.L87:
	lwz 9,1104(28)
	lis 11,gi+8@ha
	lis 5,.LC16@ha
	mr 3,28
	la 5,.LC16@l(5)
	lwz 0,924(9)
	li 4,2
	add 0,0,31
	stw 0,924(9)
	lwz 0,gi+8@l(11)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 3,.LC15@ha
	la 3,.LC15@l(3)
	b .L112
.L81:
	cmpwi 0,4,2
	bc 4,2,.L89
	lis 3,.LC17@ha
	lwz 29,84(28)
	lis 27,0x286b
	la 3,.LC17@l(3)
	ori 27,27,51739
	bl FindItem
	lis 25,.LC17@ha
	lis 9,itemlist@ha
	addi 29,29,740
	la 26,itemlist@l(9)
	subf 3,26,3
	mullw 3,3,27
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpw 0,30,0
	bc 4,1,.L90
	lwz 29,84(28)
	la 3,.LC17@l(25)
	bl FindItem
	subf 3,26,3
	addi 29,29,740
	mullw 3,3,27
	rlwinm 3,3,0,0,29
	lwzx 30,29,3
.L90:
	lwz 9,1104(28)
	lwz 11,920(9)
	cmpwi 0,11,49
	bc 12,1,.L67
	add 0,11,30
	cmpwi 0,0,50
	bc 4,1,.L92
	lwz 29,84(28)
	subfic 31,11,50
	la 3,.LC17@l(25)
	bl FindItem
	subf 3,26,3
	addi 29,29,740
	mullw 3,3,27
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpw 0,30,0
	bc 4,2,.L95
	cmpw 7,30,31
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,30,0
	and 0,31,0
	or 31,0,9
	b .L95
.L92:
	mr 31,30
.L95:
	lwz 9,1104(28)
	lis 11,gi+8@ha
	lis 5,.LC18@ha
	mr 3,28
	la 5,.LC18@l(5)
	lwz 0,920(9)
	li 4,2
	add 0,0,31
	stw 0,920(9)
	lwz 0,gi+8@l(11)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 3,.LC17@ha
	la 3,.LC17@l(3)
	b .L112
.L89:
	cmpwi 0,4,1
	bc 4,2,.L80
	lis 3,.LC10@ha
	lwz 29,84(28)
	lis 27,0x286b
	la 3,.LC10@l(3)
	ori 27,27,51739
	bl FindItem
	lis 25,.LC10@ha
	lis 9,itemlist@ha
	addi 29,29,740
	la 26,itemlist@l(9)
	subf 3,26,3
	mullw 3,3,27
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpw 0,30,0
	bc 4,1,.L98
	lwz 29,84(28)
	la 3,.LC10@l(25)
	bl FindItem
	subf 3,26,3
	addi 29,29,740
	mullw 3,3,27
	rlwinm 3,3,0,0,29
	lwzx 30,29,3
.L98:
	lwz 9,1104(28)
	lwz 11,916(9)
	cmpwi 0,11,99
	bc 12,1,.L67
	add 0,11,30
	cmpwi 0,0,100
	bc 4,1,.L100
	lwz 29,84(28)
	subfic 31,11,100
	la 3,.LC10@l(25)
	bl FindItem
	subf 3,26,3
	addi 29,29,740
	mullw 3,3,27
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpw 0,30,0
	bc 4,2,.L103
	cmpw 7,30,31
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,30,0
	and 0,31,0
	or 31,0,9
	b .L103
.L100:
	mr 31,30
.L103:
	lwz 9,1104(28)
	lis 11,gi+8@ha
	lis 5,.LC19@ha
	mr 3,28
	la 5,.LC19@l(5)
	lwz 0,916(9)
	li 4,2
	add 0,0,31
	stw 0,916(9)
	lwz 0,gi+8@l(11)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 3,.LC10@ha
	la 3,.LC10@l(3)
.L112:
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(28)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,11,3
	subf 0,31,0
	stwx 0,11,3
.L80:
	lwz 29,1104(28)
	lwz 9,924(29)
	cmpwi 0,9,0
	bc 12,2,.L104
	stw 9,900(29)
	lis 0,0x40a0
	lis 3,.LC2@ha
	lis 9,gi+32@ha
	stw 0,328(29)
	la 3,.LC2@l(3)
	b .L113
.L104:
	lwz 9,912(29)
	cmpwi 0,9,0
	bc 12,2,.L106
	stw 9,900(29)
	lis 0,0x3f80
	lis 3,.LC3@ha
	lis 9,gi+32@ha
	stw 0,328(29)
	la 3,.LC3@l(3)
	b .L113
.L106:
	lwz 9,920(29)
	cmpwi 0,9,0
	bc 12,2,.L108
	stw 9,900(29)
	lis 0,0x4080
	lis 3,.LC3@ha
	lis 9,gi+32@ha
	stw 0,328(29)
	la 3,.LC3@l(3)
	b .L113
.L108:
	lwz 9,916(29)
	cmpwi 0,9,0
	bc 12,2,.L67
	stw 9,900(29)
	lis 0,0x4000
	lis 3,.LC4@ha
	lis 9,gi+32@ha
	stw 0,328(29)
	la 3,.LC4@l(3)
.L113:
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
	stw 3,44(29)
.L67:
	lwz 0,68(1)
	mtlr 0
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe4:
	.size	 Sentry_AddAmmo,.Lfe4-Sentry_AddAmmo
	.section	".rodata"
	.align 2
.LC22:
	.string	"cells"
	.align 2
.LC23:
	.string	"Not enough energy\n"
	.align 2
.LC24:
	.string	"Sentry upgraded.\n"
	.align 2
.LC25:
	.string	"Rotated 45 degrees to the left.\n"
	.align 2
.LC26:
	.long 0x42340000
	.section	".text"
	.align 2
	.globl Sentry_Sel
	.type	 Sentry_Sel,@function
Sentry_Sel:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr. 4,4
	mr 31,3
	bc 4,2,.L115
	li 4,1
	li 5,20
	bl Sentry_AddAmmo
	b .L114
.L115:
	cmpwi 0,4,1
	bc 4,2,.L117
	mr 3,31
	li 4,2
	b .L141
.L117:
	cmpwi 0,4,2
	bc 4,2,.L119
	mr 3,31
	li 4,4
.L141:
	li 5,4
	bl Sentry_AddAmmo
	b .L114
.L119:
	cmpwi 0,4,3
	bc 4,2,.L121
	mr 3,31
	li 4,0
	li 5,15
	bl Sentry_AddAmmo
	b .L114
.L121:
	cmpwi 0,4,4
	bc 4,2,.L123
	lwz 9,1104(31)
	lwz 0,892(9)
	cmpwi 0,0,3
	bc 12,1,.L114
	lis 26,.LC22@ha
	lwz 29,84(31)
	lis 30,0x286b
	la 3,.LC22@l(26)
	ori 30,30,51739
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 27,itemlist@l(9)
	subf 3,27,3
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,69
	bc 12,1,.L125
	lis 9,gi+8@ha
	lis 5,.LC23@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC23@l(5)
	li 4,2
	b .L142
.L125:
	lis 9,gi@ha
	lis 5,.LC24@ha
	la 28,gi@l(9)
	la 5,.LC24@l(5)
	lwz 9,8(28)
	mr 3,31
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	la 3,.LC22@l(26)
	bl FindItem
	subf 3,27,3
	lwz 9,84(31)
	li 0,0
	mullw 3,3,30
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 0,9,3
	lwz 11,1104(31)
	lwz 9,892(11)
	addi 9,9,1
	stw 9,892(11)
	lwz 10,1104(31)
	lwz 0,892(10)
	mulli 0,0,100
	stw 0,484(10)
	lwz 29,1104(31)
	lwz 9,924(29)
	cmpwi 0,9,0
	bc 12,2,.L126
	lis 0,0x40a0
	stw 9,900(29)
	lis 3,.LC2@ha
	stw 0,328(29)
	la 3,.LC2@l(3)
	b .L143
.L126:
	lwz 9,912(29)
	cmpwi 0,9,0
	bc 12,2,.L128
	lis 0,0x3f80
	stw 9,900(29)
	lis 3,.LC3@ha
	stw 0,328(29)
	la 3,.LC3@l(3)
	b .L143
.L128:
	lwz 9,920(29)
	cmpwi 0,9,0
	bc 12,2,.L130
	lis 0,0x4080
	stw 9,900(29)
	lis 3,.LC3@ha
	stw 0,328(29)
	la 3,.LC3@l(3)
	b .L143
.L130:
	lwz 9,916(29)
	cmpwi 0,9,0
	bc 12,2,.L114
	lis 0,0x4000
	stw 9,900(29)
	lis 3,.LC4@ha
	stw 0,328(29)
	la 3,.LC4@l(3)
.L143:
	lwz 0,32(28)
	mtlr 0
	blrl
	stw 3,44(29)
	b .L114
.L123:
	cmpwi 0,4,5
	bc 4,2,.L135
	lwz 9,1104(31)
	lis 11,.LC26@ha
	lis 5,.LC25@ha
	la 11,.LC26@l(11)
	mr 3,31
	lfs 13,0(11)
	la 5,.LC25@l(5)
	li 4,2
	lfs 0,20(9)
	lis 11,gi+8@ha
	fadds 0,0,13
	stfs 0,424(9)
	stfs 0,20(9)
	lwz 0,gi+8@l(11)
.L142:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L114
.L135:
	cmpwi 0,4,6
	bc 4,2,.L114
	lwz 31,1104(31)
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,2,.L138
	li 3,8
	addi 4,31,4
	li 5,2
	bl G_PointEntity
	b .L139
.L138:
	li 3,18
	addi 4,31,4
	li 5,2
	bl G_PointEntity
.L139:
	mr 3,31
	bl G_FreeEdict
.L114:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 Sentry_Sel,.Lfe5-Sentry_Sel
	.section	".rodata"
	.align 2
.LC27:
	.string	"Sentry"
	.align 2
.LC28:
	.string	"Add Bullets  "
	.align 2
.LC29:
	.string	"Add Rockets  "
	.align 2
.LC30:
	.string	"Add Slugs    "
	.align 2
.LC31:
	.string	"Repair       "
	.align 2
.LC32:
	.string	"Upgrade      "
	.align 2
.LC33:
	.string	"Rotate       "
	.align 2
.LC34:
	.string	"Dismantle    "
	.align 2
.LC35:
	.string	"models/weapons/s_base/tris.md2"
	.align 2
.LC36:
	.string	"sentry"
	.section	".text"
	.align 2
	.globl Sentry_Think
	.type	 Sentry_Think,@function
Sentry_Think:
	stwu 1,-64(1)
	mflr 0
	stmw 20,16(1)
	stw 0,68(1)
	mr 31,3
	lis 20,.LC10@ha
	la 3,.LC10@l(20)
	lis 24,0x286b
	bl FindItem
	ori 24,24,51739
	li 29,0
	lis 25,itemlist@ha
	lwz 22,1100(31)
	lis 11,Sentry_Menu@ha
	la 25,itemlist@l(25)
	lis 8,.LC35@ha
	lwz 26,776(31)
	subf 3,25,3
	lwz 9,84(22)
	lis 10,.LC36@ha
	mullw 3,3,24
	la 11,Sentry_Menu@l(11)
	la 8,.LC35@l(8)
	addi 9,9,740
	la 10,.LC36@l(10)
	rlwinm 3,3,0,0,29
	li 27,2
	lwzx 0,9,3
	li 21,100
	li 23,1
	lis 9,gi@ha
	stw 27,512(31)
	lis 7,sentry_pain@ha
	stw 11,444(31)
	la 30,gi@l(9)
	lis 6,sentry_die@ha
	stw 8,268(31)
	lis 4,sentry_stand@ha
	lis 28,sentry_run@ha
	stw 10,280(31)
	lis 5,sentry_attack@ha
	lis 11,decoy_sight@ha
	stw 27,248(31)
	la 7,sentry_pain@l(7)
	la 6,sentry_die@l(6)
	stw 0,916(31)
	la 4,sentry_stand@l(4)
	la 5,sentry_attack@l(5)
	stw 21,484(31)
	li 10,200
	li 8,6418
	stw 23,892(31)
	la 11,decoy_sight@l(11)
	la 28,sentry_run@l(28)
	stw 29,920(31)
	ori 26,26,1024
	li 27,-30
	stw 29,924(31)
	mr 3,31
	stw 29,912(31)
	stw 29,260(31)
	stw 29,64(31)
	stw 29,56(31)
	lwz 9,84(22)
	lwz 0,1820(9)
	stw 10,400(31)
	stw 7,452(31)
	stw 6,456(31)
	stw 8,904(31)
	stw 4,788(31)
	stw 5,812(31)
	stw 0,908(31)
	stw 11,820(31)
	stw 23,644(31)
	stw 28,804(31)
	stw 29,800(31)
	stw 29,808(31)
	stw 29,816(31)
	stw 26,776(31)
	stw 21,480(31)
	stw 27,488(31)
	lwz 9,72(30)
	mtlr 9
	blrl
	mr 3,31
	bl M_droptofloor
	lwz 9,788(31)
	mr 3,31
	mtlr 9
	blrl
	mr 3,31
	bl walkmonster_start
	lis 3,.LC22@ha
	la 3,.LC22@l(3)
	bl FindItem
	lwz 9,1100(31)
	subf 0,25,3
	mullw 0,0,24
	la 3,.LC10@l(20)
	lwz 11,84(9)
	rlwinm 0,0,0,0,29
	addi 11,11,740
	lwzx 9,11,0
	addi 9,9,-70
	stwx 9,11,0
	bl FindItem
	lwz 11,1100(31)
	subf 3,25,3
	mullw 3,3,24
	lwz 9,84(11)
	rlwinm 3,3,0,0,29
	addi 9,9,740
	stwx 29,9,3
	lwz 11,1100(31)
	lwz 0,928(11)
	rlwinm 0,0,0,28,26
	stw 0,928(11)
	lwz 10,1100(31)
	lwz 8,32(30)
	lwz 9,84(10)
	mtlr 8
	lwz 11,1788(9)
	lwz 3,32(11)
	blrl
	lwz 9,1100(31)
	lwz 11,84(9)
	stw 3,88(11)
	lwz 9,924(31)
	cmpwi 0,9,0
	bc 12,2,.L159
	lis 0,0x40a0
	stw 9,900(31)
	lis 3,.LC2@ha
	stw 0,328(31)
	la 3,.LC2@l(3)
	b .L167
.L159:
	lwz 9,912(31)
	cmpwi 0,9,0
	bc 12,2,.L161
	lis 0,0x3f80
	stw 9,900(31)
	lis 3,.LC3@ha
	stw 0,328(31)
	la 3,.LC3@l(3)
	b .L167
.L161:
	lwz 9,920(31)
	cmpwi 0,9,0
	bc 12,2,.L163
	lis 0,0x4080
	stw 9,900(31)
	lis 3,.LC3@ha
	stw 0,328(31)
	la 3,.LC3@l(3)
	b .L167
.L163:
	lwz 9,916(31)
	cmpwi 0,9,0
	bc 12,2,.L166
	lis 0,0x4000
	stw 9,900(31)
	lis 3,.LC4@ha
	stw 0,328(31)
	la 3,.LC4@l(3)
.L167:
	lwz 0,32(30)
	mtlr 0
	blrl
	stw 3,44(31)
.L166:
	lwz 0,68(1)
	mtlr 0
	lmw 20,16(1)
	la 1,64(1)
	blr
.Lfe6:
	.size	 Sentry_Think,.Lfe6-Sentry_Think
	.section	".rodata"
	.align 2
.LC38:
	.string	"You already have a sentrygun\n"
	.align 2
.LC39:
	.string	"Only scientist can build a sentry gun\n"
	.align 2
.LC40:
	.string	"Cells"
	.align 2
.LC41:
	.string	"Not enough energy cells\n"
	.align 2
.LC42:
	.string	"Not enough space to build sentrygun\n"
	.align 3
.LC43:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC44:
	.long 0x42c80000
	.section	".text"
	.align 2
	.globl Cmd_Build_f
	.type	 Cmd_Build_f,@function
Cmd_Build_f:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 30,3
	lwz 9,1104(30)
	cmpwi 0,9,0
	bc 12,2,.L173
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L173
	lwz 0,280(9)
	cmpwi 0,0,0
	bc 12,2,.L173
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L173
	lis 9,gi+8@ha
	lis 5,.LC38@ha
	lwz 0,gi+8@l(9)
	la 5,.LC38@l(5)
	b .L177
.L173:
	lwz 0,892(30)
	cmpwi 0,0,6
	bc 12,2,.L174
	lis 9,gi+8@ha
	lis 5,.LC39@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC39@l(5)
	b .L177
.L174:
	lis 3,.LC40@ha
	lwz 29,84(30)
	la 3,.LC40@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,69
	bc 12,1,.L175
	lis 9,gi+8@ha
	lis 5,.LC41@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC41@l(5)
.L177:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L172
.L175:
	bl G_Spawn
	mr 31,3
	addi 4,1,8
	lwz 3,84(30)
	li 6,0
	li 5,0
	addi 3,3,2124
	bl AngleVectors
	lis 9,.LC44@ha
	addi 4,1,8
	la 9,.LC44@l(9)
	addi 3,30,4
	lfs 1,0(9)
	addi 5,31,4
	bl VectorMA
	lis 11,0xc180
	lis 10,0x4180
	li 0,0
	lis 9,0x41c8
	stw 11,192(31)
	stw 0,196(31)
	mr 3,31
	mr 4,30
	stw 10,204(31)
	stw 9,208(31)
	stw 11,188(31)
	stw 10,200(31)
	bl CheckArea
	cmpwi 0,3,0
	bc 4,2,.L176
	lis 9,gi+8@ha
	lis 5,.LC42@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC42@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L172
.L176:
	stw 31,1104(30)
	lis 29,gi@ha
	lis 3,.LC35@ha
	stw 30,1100(31)
	la 29,gi@l(29)
	la 3,.LC35@l(3)
	lwz 0,928(30)
	ori 0,0,16
	stw 0,928(30)
	lwz 9,32(29)
	mtlr 9
	blrl
	stw 3,40(31)
	lis 11,level+4@ha
	lis 10,.LC43@ha
	lfs 0,level+4@l(11)
	lis 9,sentry_die@ha
	li 0,2
	lfd 13,.LC43@l(10)
	lis 11,Sentry_health@ha
	la 9,sentry_die@l(9)
	la 11,Sentry_health@l(11)
	mr 3,31
	stw 0,512(31)
	stw 9,456(31)
	stw 11,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bl M_droptofloor
	lwz 0,72(29)
	mr 3,31
	mtlr 0
	blrl
.L172:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 Cmd_Build_f,.Lfe7-Cmd_Build_f
	.globl sentry_death_frames
	.section	".data"
	.align 2
	.type	 sentry_death_frames,@object
sentry_death_frames:
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 sentry_death_frames,192
	.globl sentry_death_move
	.align 2
	.type	 sentry_death_move,@object
	.size	 sentry_death_move,16
sentry_death_move:
	.long 32
	.long 43
	.long sentry_death_frames
	.long sentry_dead
	.section	".rodata"
	.align 2
.LC45:
	.string	"Your sentrygun was destroyed by %s\n"
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.section	".sbss","aw",@nobits
	.align 2
sound_idle:
	.space	4
	.size	 sound_idle,4
	.comm	MeanOfDeath,4,4
	.section	".text"
	.align 2
	.globl sentry_die
	.type	 sentry_die,@function
sentry_die:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 3,1100(31)
	cmpw 0,5,3
	bc 12,2,.L180
	lis 9,gi+8@ha
	lwz 6,84(5)
	li 4,2
	lwz 0,gi+8@l(9)
	lis 5,.LC45@ha
	la 5,.LC45@l(5)
	addi 6,6,700
	mtlr 0
	crxor 6,6,6
	blrl
.L180:
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,2,.L181
	li 3,8
	addi 4,31,4
	li 5,2
	bl G_PointEntity
	b .L182
.L181:
	li 3,18
	addi 4,31,4
	li 5,2
	bl G_PointEntity
.L182:
	mr 3,31
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 sentry_die,.Lfe8-sentry_die
	.align 2
	.globl sentry_run
	.type	 sentry_run,@function
sentry_run:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 11,3
	lwz 9,540(11)
	lwz 0,492(9)
	cmpwi 0,0,2
	bc 4,2,.L46
	lis 9,sentry_move_stand1@ha
	b .L184
.L46:
	cmpwi 0,9,0
	bc 12,2,.L47
	lwz 9,84(9)
	cmpwi 0,9,0
	bc 12,2,.L47
	lwz 9,1820(9)
	lwz 0,908(11)
	cmpw 0,9,0
	bc 4,2,.L47
	lis 9,sentry_move_stand1@ha
	mr 3,11
.L184:
	la 9,sentry_move_stand1@l(9)
	stw 9,772(11)
	bl FindTarget
	b .L45
.L47:
	lwz 0,812(11)
	mr 3,11
	mtlr 0
	blrl
.L45:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 sentry_run,.Lfe9-sentry_run
	.section	".rodata"
	.align 2
.LC46:
	.long 0x3c23d70a
	.align 2
.LC47:
	.long 0x40000000
	.align 2
.LC48:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl sentry_attack
	.type	 sentry_attack,@function
sentry_attack:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 10,3
	lwz 9,540(10)
	cmpwi 0,9,0
	bc 12,2,.L61
	lwz 9,84(9)
	cmpwi 0,9,0
	bc 12,2,.L61
	lwz 9,1820(9)
	lwz 0,908(10)
	cmpw 0,9,0
	bc 4,2,.L61
	lis 9,sentry_move_stand1@ha
	la 9,sentry_move_stand1@l(9)
	stw 9,772(10)
	bl FindTarget
	b .L60
.L61:
	lis 9,.LC47@ha
	lfs 13,328(10)
	la 9,.LC47@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L63
	lis 11,.LC46@ha
	lis 9,sentry_move_attack3@ha
	lfs 1,.LC46@l(11)
	la 9,sentry_move_attack3@l(9)
	mr 3,10
	stw 9,772(10)
	bl AttackFinished
	b .L60
.L63:
	lis 11,.LC48@ha
	lis 9,sentry_move_attack2@ha
	la 11,.LC48@l(11)
	la 9,sentry_move_attack2@l(9)
	lfs 1,0(11)
	mr 3,10
	stw 9,772(10)
	bl AttackFinished
.L60:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe10:
	.size	 sentry_attack,.Lfe10-sentry_attack
	.section	".rodata"
	.align 2
.LC49:
	.long 0x3f800000
	.align 2
.LC50:
	.long 0x0
	.section	".text"
	.align 2
	.globl sentry_noise
	.type	 sentry_noise,@function
sentry_noise:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi@ha
	mr 30,3
	la 31,gi@l(9)
	lis 3,.LC4@ha
	lwz 9,32(31)
	la 3,.LC4@l(3)
	mtlr 9
	blrl
	lwz 0,44(30)
	cmpw 0,0,3
	bc 4,2,.L51
	lwz 9,36(31)
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	mtlr 9
	blrl
	lis 9,.LC49@ha
	lwz 0,16(31)
	mr 5,3
	la 9,.LC49@l(9)
	li 4,1
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC49@ha
	la 9,.LC49@l(9)
	lfs 2,0(9)
	lis 9,.LC50@ha
	la 9,.LC50@l(9)
	lfs 3,0(9)
	blrl
.L51:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 sentry_noise,.Lfe11-sentry_noise
	.align 2
	.globl Sentry_ChangeWeapon
	.type	 Sentry_ChangeWeapon,@function
Sentry_ChangeWeapon:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,924(31)
	cmpwi 0,9,0
	bc 12,2,.L17
	stw 9,900(31)
	lis 0,0x40a0
	lis 3,.LC2@ha
	lis 9,gi+32@ha
	stw 0,328(31)
	la 3,.LC2@l(3)
	b .L185
.L17:
	lwz 9,912(31)
	cmpwi 0,9,0
	bc 12,2,.L19
	stw 9,900(31)
	lis 0,0x3f80
	lis 3,.LC3@ha
	lis 9,gi+32@ha
	stw 0,328(31)
	la 3,.LC3@l(3)
	b .L185
.L19:
	lwz 9,920(31)
	cmpwi 0,9,0
	bc 12,2,.L21
	stw 9,900(31)
	lis 0,0x4080
	lis 3,.LC3@ha
	lis 9,gi+32@ha
	stw 0,328(31)
	la 3,.LC3@l(3)
	b .L185
.L21:
	lwz 9,916(31)
	cmpwi 0,9,0
	bc 12,2,.L18
	stw 9,900(31)
	lis 0,0x4000
	lis 3,.LC4@ha
	lis 9,gi+32@ha
	stw 0,328(31)
	la 3,.LC4@l(3)
.L185:
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
	stw 3,44(31)
.L18:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 Sentry_ChangeWeapon,.Lfe12-Sentry_ChangeWeapon
	.align 2
	.globl ClearSentryAmmo
	.type	 ClearSentryAmmo,@function
ClearSentryAmmo:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lis 3,.LC10@ha
	la 3,.LC10@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lwz 10,1100(29)
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	lwz 11,84(10)
	mullw 3,3,0
	li 9,0
	addi 11,11,740
	rlwinm 3,3,0,0,29
	lwzx 0,11,3
	stw 9,912(29)
	stw 0,916(29)
	stw 9,920(29)
	stw 9,924(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 ClearSentryAmmo,.Lfe13-ClearSentryAmmo
	.section	".rodata"
	.align 2
.LC51:
	.long 0x3f800000
	.align 2
.LC52:
	.long 0x0
	.section	".text"
	.align 2
	.globl sentry_noise_rotate
	.type	 sentry_noise_rotate,@function
sentry_noise_rotate:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 28,3
	la 29,gi@l(29)
	lis 3,.LC12@ha
	lwz 9,36(29)
	la 3,.LC12@l(3)
	mtlr 9
	blrl
	lis 9,.LC51@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC51@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,28
	mtlr 0
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	lfs 2,0(9)
	lis 9,.LC52@ha
	la 9,.LC52@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 sentry_noise_rotate,.Lfe14-sentry_noise_rotate
	.align 2
	.globl sentry_stand
	.type	 sentry_stand,@function
sentry_stand:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 3,540(31)
	cmpwi 0,3,0
	bc 4,2,.L55
	lwz 0,412(31)
	cmpwi 0,0,0
	bc 12,2,.L54
.L55:
	mr 4,31
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L53
	lwz 0,812(31)
	mr 3,31
	mtlr 0
	blrl
	b .L53
.L54:
	lis 9,sentry_move_stand1@ha
	la 9,sentry_move_stand1@l(9)
	stw 9,772(31)
.L53:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe15:
	.size	 sentry_stand,.Lfe15-sentry_stand
	.align 2
	.globl sentry_expl
	.type	 sentry_expl,@function
sentry_expl:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,2,.L58
	li 3,8
	addi 4,31,4
	li 5,2
	bl G_PointEntity
	b .L59
.L58:
	li 3,18
	addi 4,31,4
	li 5,2
	bl G_PointEntity
.L59:
	mr 3,31
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe16:
	.size	 sentry_expl,.Lfe16-sentry_expl
	.align 2
	.globl sentry_pain
	.type	 sentry_pain,@function
sentry_pain:
	lis 9,sentry_move_pain1@ha
	la 9,sentry_move_pain1@l(9)
	stw 9,772(3)
	blr
.Lfe17:
	.size	 sentry_pain,.Lfe17-sentry_pain
	.align 2
	.globl decoy_sight
	.type	 decoy_sight,@function
decoy_sight:
	blr
.Lfe18:
	.size	 decoy_sight,.Lfe18-decoy_sight
	.align 2
	.globl Cmd_SentryM_f
	.type	 Cmd_SentryM_f,@function
Cmd_SentryM_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,1916(9)
	cmpwi 0,0,0
	bc 4,2,.L144
	lwz 0,1920(9)
	cmpwi 0,0,0
	bc 4,2,.L144
	lwz 0,1932(9)
	cmpwi 0,0,0
	bc 4,2,.L144
	lwz 0,1936(9)
	cmpwi 0,0,0
	bc 4,2,.L144
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L144
	lis 4,.LC27@ha
	la 4,.LC27@l(4)
	bl Menu_Title
	lis 4,.LC28@ha
	mr 3,31
	la 4,.LC28@l(4)
	bl Menu_Add
	lis 4,.LC29@ha
	mr 3,31
	la 4,.LC29@l(4)
	bl Menu_Add
	lis 4,.LC30@ha
	mr 3,31
	la 4,.LC30@l(4)
	bl Menu_Add
	lis 4,.LC31@ha
	mr 3,31
	la 4,.LC31@l(4)
	bl Menu_Add
	lis 4,.LC32@ha
	mr 3,31
	la 4,.LC32@l(4)
	bl Menu_Add
	lis 4,.LC33@ha
	mr 3,31
	la 4,.LC33@l(4)
	bl Menu_Add
	lis 4,.LC34@ha
	mr 3,31
	la 4,.LC34@l(4)
	bl Menu_Add
	lwz 11,84(31)
	lis 9,Sentry_Sel@ha
	mr 3,31
	la 9,Sentry_Sel@l(9)
	stw 9,1996(11)
	bl Menu_Open
.L144:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe19:
	.size	 Cmd_SentryM_f,.Lfe19-Cmd_SentryM_f
	.align 2
	.globl Sentry_Menu
	.type	 Sentry_Menu,@function
Sentry_Menu:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 30,3
	mr 31,4
	lwz 0,492(30)
	cmpwi 0,0,2
	bc 12,2,.L148
	mr 3,31
	bl G_ClientExists
	cmpwi 0,3,0
	bc 12,2,.L148
	lwz 11,84(31)
	lwz 9,908(30)
	lwz 0,1820(11)
	cmpw 0,0,9
	bc 4,2,.L148
	lwz 0,892(31)
	cmpwi 0,0,6
	bc 4,2,.L148
	lwz 0,1916(11)
	cmpwi 0,0,0
	bc 4,2,.L148
	lwz 0,1920(11)
	cmpwi 0,0,0
	bc 4,2,.L148
	lwz 0,1932(11)
	cmpwi 0,0,0
	bc 4,2,.L148
	lwz 0,1936(11)
	cmpwi 0,0,0
	bc 4,2,.L148
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L148
	lis 4,.LC27@ha
	mr 3,31
	la 4,.LC27@l(4)
	bl Menu_Title
	lis 4,.LC28@ha
	mr 3,31
	la 4,.LC28@l(4)
	bl Menu_Add
	lis 4,.LC29@ha
	mr 3,31
	la 4,.LC29@l(4)
	bl Menu_Add
	lis 4,.LC30@ha
	mr 3,31
	la 4,.LC30@l(4)
	bl Menu_Add
	lis 4,.LC31@ha
	mr 3,31
	la 4,.LC31@l(4)
	bl Menu_Add
	lis 4,.LC32@ha
	mr 3,31
	la 4,.LC32@l(4)
	bl Menu_Add
	lis 4,.LC33@ha
	mr 3,31
	la 4,.LC33@l(4)
	bl Menu_Add
	lis 4,.LC34@ha
	mr 3,31
	la 4,.LC34@l(4)
	bl Menu_Add
	lwz 11,84(31)
	lis 9,Sentry_Sel@ha
	mr 3,31
	la 9,Sentry_Sel@l(9)
	stw 9,1996(11)
	bl Menu_Open
.L148:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe20:
	.size	 Sentry_Menu,.Lfe20-Sentry_Menu
	.section	".rodata"
	.align 3
.LC53:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl Sentry_health
	.type	 Sentry_health,@function
Sentry_health:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,480(31)
	cmpwi 0,0,100
	bc 4,2,.L169
	lis 11,level+4@ha
	lis 10,.LC53@ha
	lfs 0,level+4@l(11)
	lis 9,Sentry_Think@ha
	lfd 13,.LC53@l(10)
	la 9,Sentry_Think@l(9)
	stw 9,436(31)
	b .L186
.L169:
	bl rand
	andi. 0,3,1
	bc 12,2,.L170
	bl rand
	andi. 0,3,1
	bc 12,2,.L170
	lis 5,vec3_origin@ha
	li 3,2
	la 5,vec3_origin@l(5)
	addi 4,31,4
	li 6,2
	bl G_ImpactEntity
.L170:
	lwz 11,480(31)
	lis 10,level+4@ha
	lis 9,.LC53@ha
	lfd 13,.LC53@l(9)
	addi 11,11,2
	stw 11,480(31)
	lfs 0,level+4@l(10)
.L186:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe21:
	.size	 Sentry_health,.Lfe21-Sentry_health
	.align 2
	.globl sentry_dead
	.type	 sentry_dead,@function
sentry_dead:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lis 5,0xc180
	lwz 0,184(9)
	lis 6,0x4180
	lis 11,0xc1c0
	lis 10,0xc100
	li 8,7
	stw 5,192(9)
	ori 0,0,2
	stw 11,196(9)
	lis 7,gi+72@ha
	stw 6,204(9)
	stw 10,208(9)
	stw 8,260(9)
	stw 0,184(9)
	stw 5,188(9)
	stw 6,200(9)
	lwz 0,gi+72@l(7)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe22:
	.size	 sentry_dead,.Lfe22-sentry_dead
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
