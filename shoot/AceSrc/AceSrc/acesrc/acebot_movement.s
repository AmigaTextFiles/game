	.file	"acebot_movement.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC1:
	.string	"%s: move blocked\n"
	.align 3
.LC0:
	.long 0x3fd33333
	.long 0x33333333
	.align 2
.LC2:
	.long 0x42b40000
	.align 2
.LC3:
	.long 0x43340000
	.align 2
.LC4:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl ACEMV_CanMove
	.type	 ACEMV_CanMove,@function
ACEMV_CanMove:
	stwu 1,-208(1)
	mflr 0
	stmw 23,172(1)
	stw 0,212(1)
	mr 31,3
	mr. 4,4
	lfs 12,20(31)
	lfs 0,16(31)
	lfs 13,24(31)
	stfs 12,92(1)
	stfs 0,88(1)
	stfs 13,96(1)
	bc 4,2,.L7
	lis 9,.LC2@ha
	la 9,.LC2@l(9)
	lfs 0,0(9)
	fadds 0,12,0
	b .L17
.L7:
	cmpwi 0,4,1
	bc 4,2,.L9
	lis 9,.LC2@ha
	la 9,.LC2@l(9)
	b .L18
.L9:
	cmpwi 0,4,3
	bc 4,2,.L8
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
.L18:
	lfs 0,0(9)
	fsubs 0,12,0
.L17:
	stfs 0,92(1)
.L8:
	addi 29,1,24
	addi 3,1,88
	addi 4,1,8
	mr 5,29
	li 6,0
	lis 25,0x4210
	bl AngleVectors
	li 24,0
	addi 27,31,4
	addi 26,1,40
	addi 23,1,56
	stw 25,40(1)
	lis 0,0x41c0
	addi 5,1,8
	stw 24,44(1)
	stw 0,48(1)
	mr 3,27
	mr 4,26
	mr 6,29
	mr 7,23
	bl G_ProjectSource
	addi 28,1,72
	lis 0,0xc3c8
	stw 25,40(1)
	stw 0,48(1)
	addi 5,1,8
	mr 3,27
	mr 4,26
	mr 6,29
	stw 24,44(1)
	mr 7,28
	bl G_ProjectSource
	lis 9,gi+48@ha
	mr 4,23
	lwz 0,gi+48@l(9)
	mr 7,28
	addi 3,1,104
	li 9,25
	li 5,0
	li 6,0
	mr 8,31
	mtlr 0
	blrl
	lfs 12,112(1)
	lis 9,.LC0@ha
	lfd 13,.LC0@l(9)
	fmr 0,12
	fcmpu 0,0,13
	bc 4,1,.L14
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	lfs 0,0(9)
	fcmpu 0,12,0
	bc 4,2,.L13
.L14:
	lwz 0,152(1)
	andi. 9,0,24
	bc 12,2,.L12
.L13:
	lis 9,debug_mode@ha
	lwz 0,debug_mode@l(9)
	cmpwi 0,0,0
	bc 12,2,.L15
	lwz 4,84(31)
	lis 3,.LC1@ha
	la 3,.LC1@l(3)
	addi 4,4,700
	crxor 6,6,6
	bl debug_printf
.L15:
	li 3,0
	b .L16
.L12:
	li 3,1
.L16:
	lwz 0,212(1)
	mtlr 0
	lmw 23,172(1)
	la 1,208(1)
	blr
.Lfe1:
	.size	 ACEMV_CanMove,.Lfe1-ACEMV_CanMove
	.section	".rodata"
	.align 2
.LC5:
	.long 0x41900000
	.align 2
.LC6:
	.long 0x41600000
	.align 2
.LC7:
	.long 0x42000000
	.section	".text"
	.align 2
	.globl ACEMV_SpecialMove
	.type	 ACEMV_SpecialMove,@function
ACEMV_SpecialMove:
	stwu 1,-240(1)
	mflr 0
	stfd 31,232(1)
	stmw 20,184(1)
	stw 0,244(1)
	mr 31,3
	lis 11,.LC5@ha
	lwz 9,84(31)
	la 11,.LC5@l(11)
	addi 29,1,24
	lfs 13,20(31)
	addi 28,1,40
	mr 23,4
	lfs 0,28(9)
	addi 26,1,88
	addi 30,1,56
	lfs 31,0(11)
	addi 25,1,72
	addi 3,1,8
	addi 24,1,120
	mr 4,29
	stfs 0,8(1)
	mr 5,28
	li 6,0
	lfs 0,32(9)
	li 21,0
	addi 27,31,4
	addi 22,31,188
	addi 20,31,200
	stfs 0,12(1)
	lfs 0,36(9)
	stfs 13,12(1)
	stfs 0,16(1)
	bl AngleVectors
	stfs 31,88(1)
	mr 5,29
	mr 3,27
	stw 21,92(1)
	mr 4,26
	mr 6,28
	stw 21,96(1)
	mr 7,30
	bl G_ProjectSource
	lfs 0,88(1)
	mr 5,29
	mr 3,27
	mr 4,26
	mr 6,28
	mr 7,25
	fadds 0,0,31
	stfs 0,88(1)
	bl G_ProjectSource
	lis 11,gi@ha
	lfs 13,64(1)
	lis 9,0x202
	lfs 0,80(1)
	la 29,gi@l(11)
	mr 3,24
	lwz 11,48(29)
	mr 4,30
	mr 5,22
	fadds 13,13,31
	mr 6,20
	mr 7,25
	fadds 0,0,31
	mr 8,31
	ori 9,9,3
	mtlr 11
	stfs 13,64(1)
	stfs 0,80(1)
	blrl
	lwz 0,120(1)
	cmpwi 0,0,0
	bc 12,2,.L20
	lis 9,.LC6@ha
	lfs 11,64(1)
	mr 3,24
	la 9,.LC6@l(9)
	lfs 0,80(1)
	mr 4,30
	lfs 13,0(9)
	mr 5,22
	addi 6,1,104
	stw 21,112(1)
	lis 9,0x201
	mr 7,25
	lwz 11,48(29)
	mr 8,31
	ori 9,9,3
	fsubs 11,11,13
	lfs 12,204(31)
	fsubs 0,0,13
	mtlr 11
	lfs 13,200(31)
	stfs 11,64(1)
	stfs 0,80(1)
	stfs 13,104(1)
	stfs 12,108(1)
	blrl
	lwz 0,120(1)
	cmpwi 0,0,0
	bc 4,2,.L21
	li 9,400
	li 0,-400
	sth 0,12(23)
	li 3,1
	sth 9,8(23)
	b .L23
.L21:
	lis 9,.LC7@ha
	lfs 13,64(1)
	mr 3,24
	la 9,.LC7@l(9)
	lfs 0,80(1)
	mr 4,30
	lfs 12,0(9)
	mr 5,22
	mr 6,20
	lwz 0,48(29)
	lis 9,0x202
	mr 7,25
	mr 8,31
	ori 9,9,3
	fadds 13,13,12
	mtlr 0
	fadds 0,0,12
	stfs 13,64(1)
	stfs 0,80(1)
	blrl
	lwz 0,120(1)
	cmpwi 0,0,0
	bc 4,2,.L20
	li 0,400
	li 3,1
	sth 0,12(23)
	sth 0,8(23)
	b .L23
.L20:
	li 3,0
.L23:
	lwz 0,244(1)
	mtlr 0
	lmw 20,184(1)
	lfd 31,232(1)
	la 1,240(1)
	blr
.Lfe2:
	.size	 ACEMV_SpecialMove,.Lfe2-ACEMV_SpecialMove
	.section	".rodata"
	.align 2
.LC8:
	.string	"func_door"
	.align 3
.LC9:
	.long 0x40468000
	.long 0x0
	.align 2
.LC10:
	.long 0x42100000
	.align 2
.LC11:
	.long 0x3f800000
	.align 2
.LC12:
	.long 0x43480000
	.align 2
.LC13:
	.long 0x40a00000
	.align 3
.LC14:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl ACEMV_CheckEyes
	.type	 ACEMV_CheckEyes,@function
ACEMV_CheckEyes:
	stwu 1,-480(1)
	mflr 0
	stfd 30,464(1)
	stfd 31,472(1)
	stmw 20,416(1)
	stw 0,484(1)
	mr 31,3
	addi 5,1,24
	lfs 12,16(31)
	mr 21,4
	addi 3,1,120
	lfs 13,20(31)
	mr 23,5
	addi 4,1,8
	lfs 0,24(31)
	li 6,0
	stfs 12,120(1)
	stfs 13,124(1)
	stfs 0,128(1)
	bl AngleVectors
	lwz 0,416(31)
	cmpwi 0,0,0
	bc 4,2,.L25
	lis 0,0x4348
	b .L35
.L25:
	lis 0,0x4210
.L35:
	li 9,0
	lis 11,0x4080
	stw 0,136(1)
	stw 9,140(1)
	stw 11,144(1)
	addi 29,1,136
	addi 27,31,4
	addi 30,1,72
	addi 5,1,8
	mr 3,27
	mr 4,29
	mr 6,23
	mr 7,30
	bl G_ProjectSource
	li 26,0
	mr 25,27
	lis 9,.LC10@ha
	addi 28,1,104
	stw 26,140(1)
	la 9,.LC10@l(9)
	addi 5,1,8
	stw 26,144(1)
	lfs 30,0(9)
	mr 3,27
	mr 4,29
	mr 6,23
	mr 7,28
	mr 22,29
	mr 20,28
	stfs 30,136(1)
	bl G_ProjectSource
	lis 9,gi@ha
	addi 3,1,344
	la 24,gi@l(9)
	mr 4,27
	lwz 11,48(24)
	li 9,25
	addi 5,31,188
	addi 6,31,200
	mr 7,28
	mr 8,31
	mtlr 11
	blrl
	lwz 0,392(1)
	andis. 9,0,2048
	bc 12,2,.L27
	li 0,400
	li 3,1
	sth 0,8(21)
	sth 0,12(21)
	b .L34
.L27:
	lis 9,.LC11@ha
	lfs 0,352(1)
	la 9,.LC11@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 12,2,.L33
	addi 28,1,40
	lis 0,0x4190
	stw 26,136(1)
	lis 9,0x4080
	stw 0,140(1)
	addi 5,1,8
	stw 9,144(1)
	mr 3,25
	mr 4,22
	mr 6,23
	mr 7,28
	bl G_ProjectSource
	lfs 0,140(1)
	addi 29,1,56
	addi 5,1,8
	mr 3,25
	mr 4,22
	mr 6,23
	mr 7,29
	fsubs 0,0,30
	stfs 0,140(1)
	bl G_ProjectSource
	lwz 11,48(24)
	addi 3,1,152
	mr 4,29
	li 5,0
	li 6,0
	mtlr 11
	mr 7,30
	mr 8,31
	li 9,25
	blrl
	lwz 0,48(24)
	mr 4,28
	mr 7,30
	addi 3,1,216
	li 5,0
	li 6,0
	mr 8,31
	mtlr 0
	li 9,25
	blrl
	lfs 0,160(1)
	fcmpu 0,0,31
	bc 4,2,.L30
	lfs 0,224(1)
	fcmpu 0,0,31
	bc 4,2,.L30
	lwz 9,268(1)
	lis 4,.LC8@ha
	la 4,.LC8@l(4)
	lwz 3,280(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L29
.L30:
	lis 9,0x41c0
	addi 27,1,88
	stw 9,144(1)
	lis 0,0x4190
	li 28,0
	lis 9,.LC12@ha
	stw 0,140(1)
	addi 5,1,8
	la 9,.LC12@l(9)
	stw 28,136(1)
	mr 3,25
	lfs 31,0(9)
	mr 4,22
	mr 6,23
	mr 7,27
	bl G_ProjectSource
	addi 26,1,280
	addi 5,1,8
	stw 28,136(1)
	stw 28,140(1)
	mr 3,25
	mr 4,22
	stfs 31,144(1)
	mr 6,23
	mr 7,20
	bl G_ProjectSource
	lis 29,gi@ha
	li 9,25
	la 29,gi@l(29)
	mr 8,31
	lwz 11,48(29)
	mr 3,26
	mr 4,27
	li 5,0
	li 6,0
	mtlr 11
	mr 7,20
	blrl
	lis 9,.LC13@ha
	lfs 0,288(1)
	addi 5,1,8
	la 9,.LC13@l(9)
	mr 3,25
	stw 28,140(1)
	lfs 13,0(9)
	mr 4,22
	mr 6,23
	mr 7,20
	stfs 31,136(1)
	fmsubs 0,0,31,13
	stfs 0,144(1)
	bl G_ProjectSource
	lwz 0,48(29)
	li 9,25
	mr 3,26
	mr 4,27
	mr 7,20
	li 5,0
	li 6,0
	mtlr 0
	mr 8,31
	blrl
	lis 9,.LC11@ha
	lfs 13,288(1)
	la 9,.LC11@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L29
	lfs 0,160(1)
	lfs 11,224(1)
	fcmpu 0,0,11
	bc 4,1,.L32
	lis 9,.LC14@ha
	lfs 13,20(31)
	la 9,.LC14@l(9)
	lfd 0,0(9)
	lis 9,.LC9@ha
	lfd 12,.LC9@l(9)
	fsub 0,0,11
	b .L36
.L32:
	lis 9,.LC14@ha
	fmr 11,0
	lfs 13,20(31)
	la 9,.LC14@l(9)
	lfd 0,0(9)
	lis 9,.LC9@ha
	lfd 12,.LC9@l(9)
	fsub 0,0,11
	fneg 0,0
.L36:
	fmadd 0,0,12,13
	frsp 0,0
	stfs 0,20(31)
.L33:
	li 0,400
	li 3,1
	sth 0,8(21)
	b .L34
.L29:
	li 3,0
.L34:
	lwz 0,484(1)
	mtlr 0
	lmw 20,416(1)
	lfd 30,464(1)
	lfd 31,472(1)
	la 1,480(1)
	blr
.Lfe3:
	.size	 ACEMV_CheckEyes,.Lfe3-ACEMV_CheckEyes
	.section	".rodata"
	.align 2
.LC15:
	.long 0x43340000
	.align 2
.LC16:
	.long 0x43b40000
	.align 2
.LC17:
	.long 0xc3340000
	.align 2
.LC18:
	.long 0x0
	.section	".text"
	.align 2
	.globl ACEMV_ChangeBotAngle
	.type	 ACEMV_ChangeBotAngle,@function
ACEMV_ChangeBotAngle:
	stwu 1,-80(1)
	mflr 0
	stfd 28,48(1)
	stfd 29,56(1)
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 29,36(1)
	stw 0,84(1)
	mr 31,3
	addi 29,31,900
	mr 3,29
	bl VectorNormalize
	lfs 1,20(31)
	bl anglemod
	fmr 30,1
	lfs 1,16(31)
	bl anglemod
	addi 4,1,8
	mr 3,29
	fmr 28,1
	bl vectoangles
	lfs 1,12(1)
	bl anglemod
	fmr 31,1
	lfs 1,8(1)
	bl anglemod
	fcmpu 0,30,31
	fmr 29,1
	bc 12,2,.L38
	fcmpu 0,31,30
	lfs 13,420(31)
	fsubs 1,31,30
	bc 4,1,.L39
	lis 9,.LC15@ha
	la 9,.LC15@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	cror 3,2,1
	bc 4,3,.L41
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 0,0(9)
	fsubs 1,1,0
	b .L41
.L39:
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	cror 3,2,0
	bc 4,3,.L41
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 0,0(9)
	fadds 1,1,0
.L41:
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,1,.L43
	fcmpu 0,1,13
	bc 4,1,.L45
	fmr 1,13
	b .L45
.L43:
	fneg 0,13
	fcmpu 0,1,0
	bc 4,0,.L45
	fmr 1,0
.L45:
	fadds 1,30,1
	bl anglemod
	stfs 1,20(31)
.L38:
	fcmpu 0,28,29
	bc 12,2,.L47
	fcmpu 0,29,28
	lfs 13,420(31)
	fsubs 1,29,28
	bc 4,1,.L48
	lis 9,.LC15@ha
	la 9,.LC15@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	cror 3,2,1
	bc 4,3,.L50
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 0,0(9)
	fsubs 1,1,0
	b .L50
.L48:
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	cror 3,2,0
	bc 4,3,.L50
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 0,0(9)
	fadds 1,1,0
.L50:
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,1,.L52
	fcmpu 0,1,13
	bc 4,1,.L54
	fmr 1,13
	b .L54
.L52:
	fneg 0,13
	fcmpu 0,1,0
	bc 4,0,.L54
	fmr 1,0
.L54:
	fadds 1,28,1
	bl anglemod
	stfs 1,16(31)
.L47:
	lwz 0,84(1)
	mtlr 0
	lmw 29,36(1)
	lfd 28,48(1)
	lfd 29,56(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe4:
	.size	 ACEMV_ChangeBotAngle,.Lfe4-ACEMV_ChangeBotAngle
	.section	".rodata"
	.align 2
.LC19:
	.string	"rocket"
	.align 2
.LC20:
	.string	"grenade"
	.align 2
.LC21:
	.string	"%s: Oh crap a rocket!\n"
	.section	".text"
	.align 2
	.globl ACEMV_MoveToGoal
	.type	 ACEMV_MoveToGoal,@function
ACEMV_MoveToGoal:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	lwz 9,416(31)
	lis 4,.LC19@ha
	la 4,.LC19@l(4)
	lwz 3,280(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L58
	lwz 9,416(31)
	lis 4,.LC20@ha
	la 4,.LC20@l(4)
	lwz 3,280(9)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L57
.L58:
	lwz 9,416(31)
	mr 3,31
	lfs 0,4(31)
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,900(31)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,904(31)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,908(31)
	bl ACEMV_ChangeBotAngle
	lis 9,debug_mode@ha
	lwz 0,debug_mode@l(9)
	cmpwi 0,0,0
	bc 12,2,.L59
	lwz 4,84(31)
	lis 3,.LC21@ha
	la 3,.LC21@l(3)
	addi 4,4,700
	crxor 6,6,6
	bl debug_printf
.L59:
	bl rand
	mr 3,31
	li 4,1
	bl ACEMV_CanMove
	cmpwi 0,3,0
	bc 12,2,.L56
	li 0,400
	sth 0,10(30)
	b .L56
.L57:
	lwz 9,416(31)
	mr 3,31
	lfs 0,4(31)
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,900(31)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,904(31)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,908(31)
	bl ACEMV_ChangeBotAngle
	li 0,400
	sth 0,8(30)
.L56:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 ACEMV_MoveToGoal,.Lfe5-ACEMV_MoveToGoal
	.section	".rodata"
	.align 2
.LC22:
	.string	"grapple"
	.align 2
.LC23:
	.long 0x46fffe00
	.align 3
.LC24:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC25:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC26:
	.long 0x41200000
	.align 2
.LC27:
	.long 0x43dc0000
	.align 2
.LC28:
	.long 0x43b40000
	.align 2
.LC29:
	.long 0x42140000
	.align 3
.LC30:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC31:
	.long 0x43340000
	.align 2
.LC32:
	.long 0x42b40000
	.section	".text"
	.align 2
	.globl ACEMV_Move
	.type	 ACEMV_Move,@function
ACEMV_Move:
	stwu 1,-64(1)
	mflr 0
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 28,32(1)
	stw 0,68(1)
	mr 31,3
	mr 29,4
	bl ACEND_FollowPath
	cmpwi 0,3,0
	bc 4,2,.L65
	li 0,3
	lis 9,level+4@ha
	stw 0,948(31)
	lis 10,.LC25@ha
	lfs 0,level+4@l(9)
	la 10,.LC25@l(10)
	lfd 13,0(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,916(31)
	b .L64
.L65:
	lwz 10,416(31)
	lis 9,nodes@ha
	lwz 11,924(31)
	la 9,nodes@l(9)
	lwz 0,932(31)
	cmpwi 0,10,0
	addi 9,9,12
	slwi 11,11,4
	slwi 0,0,4
	lwzx 28,9,11
	lwzx 30,9,0
	bc 12,2,.L66
	mr 3,31
	mr 4,29
	bl ACEMV_MoveToGoal
.L66:
	cmpwi 0,30,6
	bc 4,2,.L67
	mr 3,31
	bl ACEMV_ChangeBotAngle
	lis 3,.LC22@ha
	la 3,.LC22@l(3)
	bl FindItem
	mr 4,3
	mr 3,31
	bl ACEIT_ChangeWeapon
	li 0,1
	stb 0,1(29)
	b .L64
.L67:
	cmpwi 0,28,6
	bc 4,2,.L68
	mr 3,31
	bl CTFPlayerResetGrapple
	b .L64
.L68:
	cmpwi 7,30,2
	xori 0,28,2
	addic 10,0,-1
	subfe 9,10,0
	mfcr 0
	rlwinm 0,0,31,1
	mcrf 6,7
	and. 11,9,0
	bc 12,2,.L69
	lis 9,num_items@ha
	li 10,0
	lwz 0,num_items@l(9)
	cmpw 0,10,0
	bc 4,0,.L69
	lis 9,item_table@ha
	lwz 7,932(31)
	mr 8,0
	la 9,item_table@l(9)
	addi 11,9,8
.L73:
	lwz 0,4(11)
	cmpw 0,0,7
	bc 4,2,.L72
	lwz 9,0(11)
	lwz 0,732(9)
	cmpwi 0,0,1
	bc 4,2,.L64
.L72:
	addi 10,10,1
	addi 11,11,16
	cmpw 0,10,8
	bc 12,0,.L73
.L69:
	mfcr 9
	rlwinm 9,9,27,1
	xori 0,28,2
	subfic 10,0,0
	adde 0,10,0
	and. 11,0,9
	bc 12,2,.L77
	li 0,0
	addi 3,31,900
	stw 0,908(31)
	bl VectorLength
	lis 9,.LC26@ha
	la 9,.LC26@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,1,.L78
	li 0,200
	sth 0,8(29)
.L78:
	mr 3,31
	bl ACEMV_ChangeBotAngle
	b .L64
.L77:
	cmpwi 0,30,7
	bc 12,2,.L80
	xori 0,30,4
	xori 11,28,7
	subfic 9,11,0
	adde 11,9,11
	addic 10,0,-1
	subfe 9,10,0
	and. 0,11,9
	bc 12,2,.L79
	lis 9,nodes@ha
	lwz 0,932(31)
	la 9,nodes@l(9)
	lfs 13,12(31)
	slwi 0,0,4
	addi 9,9,8
	lfsx 0,9,0
	fcmpu 0,0,13
	bc 4,1,.L79
.L80:
	li 0,400
	mr 3,31
	sth 0,12(29)
	sth 0,8(29)
	bl ACEMV_ChangeBotAngle
	lis 9,.LC27@ha
	lfs 12,900(31)
	addi 4,31,376
	lfs 13,904(31)
	la 9,.LC27@l(9)
	addi 3,1,8
	lfs 0,908(31)
	lfs 1,0(9)
	stfs 12,8(1)
	stfs 13,12(1)
	stfs 0,16(1)
	bl VectorScale
	b .L64
.L79:
	cmpwi 0,30,1
	bc 4,2,.L81
	lis 9,nodes@ha
	lwz 0,932(31)
	la 9,nodes@l(9)
	lfs 13,12(31)
	slwi 0,0,4
	addi 9,9,8
	lfsx 0,9,0
	fcmpu 0,0,13
	bc 4,1,.L81
	li 0,400
	lis 9,0x43a0
	sth 0,8(29)
	mr 3,31
	stw 9,384(31)
	bl ACEMV_ChangeBotAngle
	b .L64
.L81:
	xori 0,30,1
	xori 11,28,1
	subfic 9,11,0
	adde 11,9,11
	addic 10,0,-1
	subfe 9,10,0
	and. 0,11,9
	bc 12,2,.L82
	lis 9,nodes@ha
	lwz 0,932(31)
	la 9,nodes@l(9)
	lfs 13,12(31)
	slwi 0,0,4
	addi 9,9,8
	lfsx 0,9,0
	fcmpu 0,0,13
	bc 4,1,.L82
	li 0,400
	li 9,200
	sth 9,12(29)
	lis 11,0x4348
	mr 3,31
	sth 0,8(29)
	stw 11,384(31)
	bl ACEMV_ChangeBotAngle
	b .L64
.L82:
	cmpwi 0,28,5
	bc 4,2,.L83
	mr 3,31
	bl ACEMV_ChangeBotAngle
	cmpwi 0,30,5
	bc 12,2,.L84
	lwz 0,932(31)
	lis 9,gi+52@ha
	lis 3,nodes@ha
	lwz 9,gi+52@l(9)
	la 3,nodes@l(3)
	slwi 0,0,4
	add 3,0,3
	mtlr 9
	blrl
	andi. 0,3,56
	bc 4,2,.L84
	li 0,400
	sth 0,12(29)
.L84:
	li 0,300
	sth 0,8(29)
	b .L64
.L83:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 4,2,.L85
	mr 3,31
	bl ACEMV_ChangeBotAngle
	lis 9,.LC28@ha
	lfs 0,900(31)
	la 9,.LC28@l(9)
	lfs 13,904(31)
	lfs 12,0(9)
	fmuls 0,0,12
	fmuls 13,13,12
	stfs 0,376(31)
	stfs 13,380(31)
	b .L64
.L85:
	addi 3,31,376
	bl VectorLength
	lis 9,.LC29@ha
	la 9,.LC29@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L86
	bl rand
	lis 30,0x4330
	lis 9,.LC30@ha
	rlwinm 3,3,0,17,31
	la 9,.LC30@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 10,.LC23@ha
	lis 11,.LC24@ha
	lfs 30,.LC23@l(10)
	stw 3,28(1)
	stw 30,24(1)
	lfd 0,24(1)
	lfd 12,.LC24@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L87
	mr 3,31
	mr 4,29
	bl ACEMV_SpecialMove
	cmpwi 0,3,0
	bc 4,2,.L64
.L87:
	bl rand
	rlwinm 3,3,0,17,31
	lfs 13,20(31)
	xoris 3,3,0x8000
	lis 10,.LC31@ha
	stw 3,28(1)
	lis 11,.LC32@ha
	la 10,.LC31@l(10)
	stw 30,24(1)
	la 11,.LC32@l(11)
	li 0,400
	lfd 0,24(1)
	lfs 11,0(10)
	lfs 12,0(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmsubs 0,0,11,12
	fadds 13,13,0
	stfs 13,20(31)
	sth 0,8(29)
	b .L64
.L86:
	li 0,400
	mr 3,31
	sth 0,8(29)
	bl ACEMV_ChangeBotAngle
.L64:
	lwz 0,68(1)
	mtlr 0
	lmw 28,32(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe6:
	.size	 ACEMV_Move,.Lfe6-ACEMV_Move
	.section	".rodata"
	.align 2
.LC33:
	.long 0x46fffe00
	.align 3
.LC34:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC35:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC36:
	.long 0x41c00000
	.align 2
.LC37:
	.long 0x0
	.align 2
.LC38:
	.long 0x42400000
	.align 3
.LC39:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC40:
	.long 0x43b40000
	.align 2
.LC41:
	.long 0x43340000
	.align 2
.LC42:
	.long 0x42140000
	.align 2
.LC43:
	.long 0x42b40000
	.section	".text"
	.align 2
	.globl ACEMV_Wander
	.type	 ACEMV_Wander,@function
ACEMV_Wander:
	stwu 1,-80(1)
	mflr 0
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 29,52(1)
	stw 0,84(1)
	lis 9,level@ha
	mr 31,3
	la 10,level@l(9)
	lfs 13,912(31)
	mr 30,4
	lfs 0,4(10)
	fcmpu 0,13,0
	bc 12,1,.L88
	lwz 11,552(31)
	cmpwi 0,11,0
	bc 12,2,.L90
	lwz 0,448(11)
	lis 9,Use_Plat@ha
	la 9,Use_Plat@l(9)
	cmpw 0,0,9
	bc 4,2,.L90
	lwz 9,732(11)
	addi 9,9,-2
	cmplwi 0,9,1
	bc 12,1,.L90
	li 0,0
	lis 9,.LC35@ha
	stw 0,384(31)
	la 9,.LC35@l(9)
	stw 0,376(31)
	stw 0,380(31)
	lfs 0,4(10)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,912(31)
	b .L88
.L90:
	lwz 0,416(31)
	cmpwi 0,0,0
	bc 12,2,.L92
	mr 3,31
	mr 4,30
	bl ACEMV_MoveToGoal
.L92:
	lis 9,.LC36@ha
	lfs 12,12(31)
	addi 3,1,8
	la 9,.LC36@l(9)
	lfs 0,4(31)
	lfs 13,0(9)
	lis 9,gi+52@ha
	lwz 0,gi+52@l(9)
	fadds 12,12,13
	lfs 13,8(31)
	mtlr 0
	stfs 0,8(1)
	stfs 12,16(1)
	stfs 13,12(1)
	blrl
	andi. 0,3,56
	bc 12,2,.L93
	lwz 9,84(31)
	lis 10,.LC37@ha
	la 10,.LC37@l(10)
	lfs 13,0(10)
	lfs 0,3712(9)
	fcmpu 0,0,13
	bc 4,1,.L94
	li 0,1
	lis 9,0xc234
	sth 0,12(30)
	stw 9,16(31)
	b .L95
.L94:
	li 0,15
	sth 0,12(30)
.L95:
	li 0,300
	sth 0,8(30)
	b .L96
.L93:
	lwz 9,84(31)
	li 0,0
	stw 0,3712(9)
.L96:
	lis 11,.LC38@ha
	lfs 0,16(1)
	lis 9,gi+52@ha
	la 11,.LC38@l(11)
	lwz 0,gi+52@l(9)
	addi 3,1,8
	lfs 13,0(11)
	mtlr 0
	fsubs 0,0,13
	stfs 0,16(1)
	blrl
	andi. 0,3,24
	bc 12,2,.L97
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,20(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,44(1)
	lis 10,.LC39@ha
	lis 11,.LC33@ha
	la 10,.LC39@l(10)
	stw 0,40(1)
	lfd 12,0(10)
	li 0,400
	lfd 0,40(1)
	lis 10,.LC40@ha
	lfs 13,.LC33@l(11)
	la 10,.LC40@l(10)
	lfs 9,0(10)
	fsub 0,0,12
	lis 10,.LC41@ha
	la 10,.LC41@l(10)
	lfs 10,0(10)
	frsp 0,0
	fdivs 0,0,13
	fmsubs 0,0,9,10
	fadds 11,11,0
	stfs 11,20(31)
	sth 0,12(30)
	b .L103
.L97:
	mr 3,31
	mr 4,30
	bl ACEMV_CheckEyes
	cmpwi 0,3,0
	bc 4,2,.L88
	addi 3,31,376
	bl VectorLength
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L99
	bl rand
	lis 29,0x4330
	lis 9,.LC39@ha
	rlwinm 3,3,0,17,31
	la 9,.LC39@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 10,.LC33@ha
	lis 11,.LC34@ha
	lfs 30,.LC33@l(10)
	stw 3,44(1)
	stw 29,40(1)
	lfd 0,40(1)
	lfd 12,.LC34@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L100
	mr 3,31
	mr 4,30
	bl ACEMV_SpecialMove
	cmpwi 0,3,0
	bc 4,2,.L88
.L100:
	bl rand
	rlwinm 3,3,0,17,31
	lfs 13,20(31)
	xoris 3,3,0x8000
	lis 9,.LC41@ha
	stw 3,44(1)
	lis 10,.LC43@ha
	la 9,.LC41@l(9)
	stw 29,40(1)
	la 10,.LC43@l(10)
	lfd 0,40(1)
	lfs 11,0(9)
	lfs 12,0(10)
	lis 9,M_CheckBottom@ha
	fsub 0,0,31
	la 9,M_CheckBottom@l(9)
	cmpwi 0,9,0
	frsp 0,0
	fdivs 0,0,30
	fmsubs 0,0,11,12
	fadds 13,13,0
	stfs 13,20(31)
	bc 12,2,.L102
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 4,2,.L88
.L102:
.L99:
	li 0,400
.L103:
	sth 0,8(30)
.L88:
	lwz 0,84(1)
	mtlr 0
	lmw 29,52(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe7:
	.size	 ACEMV_Wander,.Lfe7-ACEMV_Wander
	.section	".rodata"
	.align 2
.LC44:
	.long 0x46fffe00
	.align 3
.LC45:
	.long 0x3fc99999
	.long 0x9999999a
	.align 3
.LC46:
	.long 0x3fd99999
	.long 0x9999999a
	.align 3
.LC47:
	.long 0x3fe33333
	.long 0x33333333
	.align 3
.LC48:
	.long 0x3fe99999
	.long 0x9999999a
	.align 3
.LC49:
	.long 0x3fee6666
	.long 0x66666666
	.align 3
.LC50:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ACEMV_Attack
	.type	 ACEMV_Attack,@function
ACEMV_Attack:
	stwu 1,-80(1)
	mflr 0
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 30,56(1)
	stw 0,84(1)
	mr 31,3
	mr 30,4
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,52(1)
	lis 11,.LC50@ha
	lis 10,.LC44@ha
	la 11,.LC50@l(11)
	stw 0,48(1)
	lfd 12,0(11)
	lfd 0,48(1)
	lis 11,.LC45@ha
	lfs 11,.LC44@l(10)
	lfd 13,.LC45@l(11)
	fsub 0,0,12
	frsp 0,0
	fdivs 30,0,11
	fmr 31,30
	fcmpu 0,31,13
	bc 4,0,.L105
	mr 3,31
	li 4,0
	bl ACEMV_CanMove
	cmpwi 0,3,0
	bc 12,2,.L105
	lhz 9,10(30)
	addi 9,9,-400
	b .L113
.L105:
	lis 9,.LC46@ha
	fmr 13,30
	lfd 0,.LC46@l(9)
	fmr 31,13
	fcmpu 0,13,0
	bc 4,0,.L106
	mr 3,31
	li 4,1
	bl ACEMV_CanMove
	cmpwi 0,3,0
	bc 12,2,.L106
	lhz 9,10(30)
	addi 9,9,400
.L113:
	sth 9,10(30)
.L106:
	lis 9,.LC47@ha
	lfd 0,.LC47@l(9)
	fcmpu 0,31,0
	bc 4,0,.L108
	mr 3,31
	li 4,2
	bl ACEMV_CanMove
	cmpwi 0,3,0
	bc 12,2,.L108
	lhz 9,8(30)
	addi 9,9,400
	b .L114
.L108:
	lis 9,.LC48@ha
	lfd 0,.LC48@l(9)
	fcmpu 0,31,0
	bc 4,0,.L109
	mr 3,31
	li 4,2
	bl ACEMV_CanMove
	cmpwi 0,3,0
	bc 12,2,.L109
	lhz 9,8(30)
	addi 9,9,-400
.L114:
	sth 9,8(30)
.L109:
	lis 9,.LC49@ha
	lfd 0,.LC49@l(9)
	fcmpu 0,31,0
	bc 4,0,.L111
	lhz 9,12(30)
	addi 9,9,-200
	b .L115
.L111:
	lhz 9,12(30)
	addi 9,9,200
.L115:
	sth 9,12(30)
	li 0,1
	addi 3,31,900
	stb 0,1(30)
	addi 4,1,24
	lwz 9,540(31)
	lfs 12,4(31)
	lfs 13,4(9)
	lfs 10,8(31)
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 13,13,12
	lfs 12,12(31)
	stfs 0,12(1)
	lfs 11,12(9)
	fsubs 0,0,10
	stfs 13,900(31)
	fsubs 12,11,12
	stfs 0,904(31)
	stfs 11,16(1)
	stfs 12,908(31)
	bl vectoangles
	lfs 13,24(1)
	lfs 12,28(1)
	lfs 0,32(1)
	stfs 13,16(31)
	stfs 12,20(31)
	stfs 0,24(31)
	lwz 0,84(1)
	mtlr 0
	lmw 30,56(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe8:
	.size	 ACEMV_Attack,.Lfe8-ACEMV_Attack
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
