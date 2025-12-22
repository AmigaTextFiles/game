	.file	"matrix_cmds.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC1:
	.string	"weapon_knives"
	.align 2
.LC2:
	.string	"weapon_fists"
	.align 2
.LC3:
	.string	"You can't buy until recharge is complete:%f seconds\n"
	.align 2
.LC4:
	.string	"You can only have 2 spells at a time\n"
	.align 2
.LC5:
	.string	"You dont have enough energy stored\n"
	.align 2
.LC6:
	.string	"%s goes into REDICULOUS SPEEEED (TM)\n"
	.align 2
.LC7:
	.string	"thingon.wav"
	.align 2
.LC8:
	.string	"You can't buy speed while using guns.\n"
	.align 3
.LC9:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC10:
	.long 0x42c80000
	.align 2
.LC11:
	.long 0x41200000
	.align 2
.LC12:
	.long 0x43160000
	.align 2
.LC13:
	.long 0x3f800000
	.align 2
.LC14:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_BuySpeed_f
	.type	 Cmd_BuySpeed_f,@function
Cmd_BuySpeed_f:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	mr 31,3
	lis 4,.LC1@ha
	lwz 11,84(31)
	la 4,.LC1@l(4)
	lwz 9,1788(11)
	lwz 3,0(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L15
	lwz 9,84(31)
	lis 4,.LC2@ha
	la 4,.LC2@l(4)
	lwz 11,1788(9)
	lwz 3,0(11)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L14
.L15:
	lis 11,level@ha
	lwz 10,84(31)
	lwz 11,level@l(11)
	lis 29,0x4330
	lis 7,.LC9@ha
	la 7,.LC9@l(7)
	lfs 11,3876(10)
	addi 0,11,-100
	lfd 31,0(7)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 29,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,11,0
	bc 4,1,.L16
	xoris 0,11,0x8000
	lis 8,.LC10@ha
	stw 0,20(1)
	la 8,.LC10@l(8)
	lis 11,.LC11@ha
	stw 29,16(1)
	la 11,.LC11@l(11)
	lis 5,.LC3@ha
	lfd 0,16(1)
	mr 3,31
	la 5,.LC3@l(5)
	lfs 13,0(8)
	li 4,2
	lfs 12,0(11)
	fsub 0,0,31
	lis 11,gi+8@ha
	lwz 0,gi+8@l(11)
	frsp 0,0
	mtlr 0
	fsubs 0,11,0
	fadds 0,0,13
	fdivs 0,0,12
	fmr 1,0
	creqv 6,6,6
	blrl
	b .L13
.L16:
	mr 3,31
	bl SpellFull
	cmpwi 0,3,0
	bc 12,2,.L17
	lis 9,gi+8@ha
	lis 5,.LC4@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC4@l(5)
	b .L23
.L17:
	lis 7,.LC10@ha
	lfs 0,924(31)
	la 7,.LC10@l(7)
	lfs 13,0(7)
	fcmpu 0,0,13
	bc 4,0,.L18
	lis 9,gi+8@ha
	lis 5,.LC5@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC5@l(5)
.L23:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L13
.L18:
	fsubs 0,0,13
	lis 9,gi@ha
	lwz 5,84(31)
	lis 4,.LC6@ha
	la 4,.LC6@l(4)
	li 3,2
	addi 5,5,700
	stfs 0,924(31)
	lwz 0,gi@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,level@ha
	lwz 10,84(31)
	lwz 9,level@l(9)
	lfs 13,3876(10)
	xoris 0,9,0x8000
	stw 0,20(1)
	stw 29,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L19
	lis 7,.LC12@ha
	la 7,.LC12@l(7)
	lfs 0,0(7)
	fadds 0,13,0
	b .L24
.L19:
	addi 0,9,150
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 29,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
.L24:
	stfs 0,3876(10)
	lis 11,level@ha
	lwz 10,84(31)
	lwz 11,level@l(11)
	lis 8,0x4330
	lis 7,.LC9@ha
	la 7,.LC9@l(7)
	lfs 13,3876(10)
	xoris 0,11,0x8000
	lfd 11,0(7)
	stw 0,20(1)
	lis 7,.LC12@ha
	stw 8,16(1)
	la 7,.LC12@l(7)
	lfd 0,16(1)
	lfs 12,0(7)
	fsub 0,0,11
	frsp 0,0
	fsubs 13,13,0
	fcmpu 0,13,12
	bc 4,1,.L21
	addi 0,11,150
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 8,16(1)
	lfd 0,16(1)
	fsub 0,0,11
	frsp 0,0
	stfs 0,3876(10)
.L21:
	lis 29,gi@ha
	lis 3,.LC7@ha
	la 29,gi@l(29)
	la 3,.LC7@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC13@ha
	lis 8,.LC14@ha
	lis 9,.LC13@ha
	la 7,.LC13@l(7)
	la 8,.LC14@l(8)
	mr 5,3
	lfs 2,0(7)
	mtlr 0
	la 9,.LC13@l(9)
	mr 3,31
	lfs 3,0(8)
	li 4,2
	lfs 1,0(9)
	blrl
	mr 3,31
	bl MatrixSpeed
	b .L13
.L14:
	lis 9,level@ha
	lwz 10,84(31)
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 7,.LC9@ha
	la 7,.LC9@l(7)
	lfs 1,3876(10)
	lis 9,.LC10@ha
	xoris 0,0,0x8000
	lfd 13,0(7)
	la 9,.LC10@l(9)
	stw 0,20(1)
	lis 7,.LC11@ha
	lis 5,.LC8@ha
	stw 8,16(1)
	la 7,.LC11@l(7)
	mr 3,31
	lfd 0,16(1)
	la 5,.LC8@l(5)
	li 4,2
	lfs 12,0(9)
	lfs 11,0(7)
	lis 9,gi+8@ha
	fsub 0,0,13
	lwz 0,gi+8@l(9)
	mtlr 0
	frsp 0,0
	fsubs 1,1,0
	fadds 1,1,12
	fdivs 1,1,11
	creqv 6,6,6
	blrl
.L13:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 Cmd_BuySpeed_f,.Lfe1-Cmd_BuySpeed_f
	.section	".rodata"
	.align 2
.LC15:
	.string	"%s has nightvision\n"
	.align 2
.LC16:
	.string	"ir_on.wav"
	.align 3
.LC17:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC18:
	.long 0x42c80000
	.align 2
.LC19:
	.long 0x41200000
	.align 2
.LC20:
	.long 0x42960000
	.align 2
.LC21:
	.long 0x44160000
	.align 2
.LC22:
	.long 0x3f800000
	.align 2
.LC23:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Infrared_f
	.type	 Cmd_Infrared_f,@function
Cmd_Infrared_f:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	lis 30,level@ha
	lwz 10,level@l(30)
	lis 29,0x4330
	lis 11,.LC17@ha
	la 11,.LC17@l(11)
	mr 31,3
	addi 0,10,-100
	lfd 31,0(11)
	xoris 0,0,0x8000
	lwz 11,84(31)
	stw 0,20(1)
	stw 29,16(1)
	lfd 0,16(1)
	lfs 13,3884(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L26
	xoris 0,10,0x8000
	lfs 1,3876(11)
	lis 5,.LC3@ha
	stw 0,20(1)
	lis 11,.LC18@ha
	stw 29,16(1)
	la 11,.LC18@l(11)
	la 5,.LC3@l(5)
	lfd 0,16(1)
	li 4,2
	lfs 13,0(11)
	lis 11,.LC19@ha
	fsub 0,0,31
	la 11,.LC19@l(11)
	lfs 12,0(11)
	lis 11,gi+8@ha
	frsp 0,0
	lwz 0,gi+8@l(11)
	mtlr 0
	fsubs 1,1,0
	fadds 1,1,13
	fdivs 1,1,12
	creqv 6,6,6
	blrl
	b .L25
.L26:
	lis 9,.LC20@ha
	lfs 13,924(31)
	la 9,.LC20@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L27
	lis 9,gi+8@ha
	lis 5,.LC5@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC5@l(5)
	b .L31
.L27:
	mr 3,31
	bl SpellFull
	cmpwi 0,3,0
	bc 12,2,.L28
	lis 9,gi+8@ha
	lis 5,.LC4@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC4@l(5)
.L31:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L25
.L28:
	lwz 10,level@l(30)
	lwz 11,84(31)
	xoris 0,10,0x8000
	stw 0,20(1)
	stw 29,16(1)
	lfd 0,16(1)
	lfs 13,3884(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L29
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L32
.L29:
	addi 0,10,600
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 29,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
.L32:
	stfs 0,3884(11)
	lis 11,.LC20@ha
	lfs 0,924(31)
	lis 9,gi@ha
	la 11,.LC20@l(11)
	lwz 5,84(31)
	lis 4,.LC15@ha
	lfs 13,0(11)
	li 3,2
	la 4,.LC15@l(4)
	addi 5,5,700
	la 29,gi@l(9)
	fsubs 0,0,13
	stfs 0,924(31)
	lwz 0,gi@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,36(29)
	lis 3,.LC16@ha
	la 3,.LC16@l(3)
	mtlr 9
	blrl
	lis 9,.LC22@ha
	lwz 0,16(29)
	lis 11,.LC22@ha
	la 9,.LC22@l(9)
	la 11,.LC22@l(11)
	lfs 1,0(9)
	mr 5,3
	mtlr 0
	li 4,3
	lis 9,.LC23@ha
	lfs 2,0(11)
	mr 3,31
	la 9,.LC23@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,84(31)
	li 0,1
	stw 0,3868(9)
	lwz 11,84(31)
	lwz 0,116(11)
	ori 0,0,4
	stw 0,116(11)
.L25:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 Cmd_Infrared_f,.Lfe2-Cmd_Infrared_f
	.section	".rodata"
	.align 2
.LC24:
	.string	"%s's body becomes translucent.\n"
	.align 2
.LC25:
	.string	"cloak.wav"
	.align 3
.LC26:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC27:
	.long 0x42c80000
	.align 2
.LC28:
	.long 0x41200000
	.align 2
.LC29:
	.long 0x44160000
	.align 2
.LC30:
	.long 0x3f800000
	.align 2
.LC31:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Cloak_f
	.type	 Cmd_Cloak_f,@function
Cmd_Cloak_f:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 28,24(1)
	stw 0,52(1)
	lis 28,level@ha
	lwz 10,level@l(28)
	lis 29,0x4330
	lis 11,.LC26@ha
	la 11,.LC26@l(11)
	mr 31,3
	addi 0,10,-100
	lfd 31,0(11)
	xoris 0,0,0x8000
	lwz 11,84(31)
	stw 0,20(1)
	stw 29,16(1)
	lfd 0,16(1)
	lfs 13,3888(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L34
	xoris 0,10,0x8000
	lfs 1,3876(11)
	lis 5,.LC3@ha
	stw 0,20(1)
	lis 11,.LC27@ha
	stw 29,16(1)
	la 11,.LC27@l(11)
	la 5,.LC3@l(5)
	lfd 0,16(1)
	li 4,2
	lfs 13,0(11)
	lis 11,.LC28@ha
	fsub 0,0,31
	la 11,.LC28@l(11)
	lfs 12,0(11)
	lis 11,gi+8@ha
	frsp 0,0
	lwz 0,gi+8@l(11)
	mtlr 0
	fsubs 1,1,0
	fadds 1,1,13
	fdivs 1,1,12
	creqv 6,6,6
	blrl
	b .L33
.L34:
	mr 3,31
	bl SpellFull
	cmpwi 0,3,0
	bc 12,2,.L35
	lis 9,gi+8@ha
	lis 5,.LC4@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC4@l(5)
	b .L39
.L35:
	lis 9,.LC27@ha
	lfs 13,924(31)
	la 9,.LC27@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L36
	lis 9,gi+8@ha
	lis 5,.LC5@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC5@l(5)
.L39:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L33
.L36:
	lwz 10,level@l(28)
	lwz 11,84(31)
	addi 0,10,100
	xoris 0,0,0x8000
	lfs 13,3888(11)
	stw 0,20(1)
	stw 29,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L37
	lis 9,.LC29@ha
	la 9,.LC29@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L40
.L37:
	addi 0,10,600
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 29,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
.L40:
	stfs 0,3888(11)
	lis 11,.LC27@ha
	lfs 0,924(31)
	lis 9,gi@ha
	la 11,.LC27@l(11)
	lwz 5,84(31)
	lis 4,.LC24@ha
	lfs 13,0(11)
	la 4,.LC24@l(4)
	li 3,2
	addi 5,5,700
	la 29,gi@l(9)
	addi 28,31,4
	fsubs 0,0,13
	stfs 0,924(31)
	lwz 0,gi@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,100(29)
	li 3,3
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
	lwz 9,88(29)
	mr 3,28
	li 4,0
	mtlr 9
	blrl
	li 0,0
	lis 3,.LC25@ha
	stw 0,44(31)
	la 3,.LC25@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC30@ha
	lwz 0,16(29)
	lis 11,.LC30@ha
	la 9,.LC30@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC30@l(11)
	li 4,3
	mtlr 0
	lis 9,.LC31@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC31@l(9)
	lfs 3,0(9)
	blrl
.L33:
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 Cmd_Cloak_f,.Lfe3-Cmd_Cloak_f
	.section	".rodata"
	.align 2
.LC32:
	.string	"%s defends himself from projectiles\n"
	.align 2
.LC33:
	.string	"laugh3.wav"
	.align 2
.LC34:
	.string	"You can't buy bullet stopping while using guns.\n"
	.align 3
.LC35:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC36:
	.long 0x42c80000
	.align 2
.LC37:
	.long 0x41200000
	.align 2
.LC38:
	.long 0x42960000
	.align 2
.LC39:
	.long 0x43960000
	.align 2
.LC40:
	.long 0x3f800000
	.align 2
.LC41:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_StopBullets_f
	.type	 Cmd_StopBullets_f,@function
Cmd_StopBullets_f:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 28,24(1)
	stw 0,52(1)
	mr 31,3
	lis 4,.LC1@ha
	lwz 11,84(31)
	la 4,.LC1@l(4)
	lwz 9,1788(11)
	lwz 3,0(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L43
	lwz 9,84(31)
	lis 4,.LC2@ha
	la 4,.LC2@l(4)
	lwz 11,1788(9)
	lwz 3,0(11)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L42
.L43:
	lis 28,level@ha
	lfs 13,912(31)
	lwz 11,level@l(28)
	lis 29,0x4330
	lis 10,.LC35@ha
	la 10,.LC35@l(10)
	addi 0,11,-100
	lfd 31,0(10)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 29,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L44
	xoris 0,11,0x8000
	lwz 10,84(31)
	lis 5,.LC3@ha
	stw 0,20(1)
	lis 11,.LC36@ha
	mr 3,31
	stw 29,16(1)
	la 11,.LC36@l(11)
	la 5,.LC3@l(5)
	lfd 0,16(1)
	li 4,2
	lfs 1,3876(10)
	lfs 13,0(11)
	fsub 0,0,31
	lis 11,.LC37@ha
	la 11,.LC37@l(11)
	lfs 12,0(11)
	frsp 0,0
	lis 11,gi+8@ha
	lwz 0,gi+8@l(11)
	fsubs 1,1,0
	mtlr 0
	fadds 1,1,13
	fdivs 1,1,12
	creqv 6,6,6
	blrl
	b .L41
.L44:
	mr 3,31
	bl SpellFull
	cmpwi 0,3,0
	bc 12,2,.L45
	lis 9,gi+8@ha
	lis 5,.LC4@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC4@l(5)
	b .L50
.L45:
	lis 9,.LC38@ha
	lfs 0,924(31)
	la 9,.LC38@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L46
	lis 9,gi+8@ha
	lis 5,.LC5@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC5@l(5)
.L50:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L41
.L46:
	fsubs 0,0,13
	lfs 13,912(31)
	stfs 0,924(31)
	lwz 11,level@l(28)
	addi 0,11,100
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 29,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L47
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L51
.L47:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 29,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
.L51:
	stfs 0,912(31)
	lis 29,gi@ha
	lwz 5,84(31)
	lis 4,.LC32@ha
	lwz 9,gi@l(29)
	la 4,.LC32@l(4)
	li 3,2
	addi 5,5,700
	la 29,gi@l(29)
	mtlr 9
	addi 28,31,4
	crxor 6,6,6
	blrl
	lwz 9,100(29)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,51
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,88(29)
	mr 3,28
	li 4,0
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC33@ha
	la 3,.LC33@l(3)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC40@ha
	lis 10,.LC40@ha
	lis 11,.LC41@ha
	mr 5,3
	la 9,.LC40@l(9)
	la 10,.LC40@l(10)
	mtlr 0
	la 11,.LC41@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L41
.L42:
	lis 9,level@ha
	lwz 10,84(31)
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 5,.LC34@ha
	lis 9,.LC35@ha
	lfs 1,3876(10)
	mr 3,31
	xoris 0,0,0x8000
	la 9,.LC35@l(9)
	stw 0,20(1)
	lis 10,.LC36@ha
	la 5,.LC34@l(5)
	stw 8,16(1)
	la 10,.LC36@l(10)
	li 4,2
	lfd 13,0(9)
	lfd 0,16(1)
	lis 9,.LC37@ha
	lfs 12,0(10)
	la 9,.LC37@l(9)
	lfs 11,0(9)
	fsub 0,0,13
	lis 9,gi+8@ha
	lwz 0,gi+8@l(9)
	frsp 0,0
	mtlr 0
	fsubs 1,1,0
	fadds 1,1,12
	fdivs 1,1,11
	creqv 6,6,6
	blrl
.L41:
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 Cmd_StopBullets_f,.Lfe4-Cmd_StopBullets_f
	.section	".rodata"
	.align 2
.LC42:
	.string	"You can't buy until the effect has worn off\n"
	.align 2
.LC43:
	.string	"%s explodes an emp device!!\n"
	.align 2
.LC44:
	.string	"bbbbaaaaaaaaaabbbbccdccbbbbbaaaaaaaaaaabcbbbaaaaamaaazoie"
	.align 3
.LC45:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC46:
	.long 0x43480000
	.align 2
.LC47:
	.long 0x43960000
	.section	".text"
	.align 2
	.globl Cmd_Lights_f
	.type	 Cmd_Lights_f,@function
Cmd_Lights_f:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 28,24(1)
	stw 0,52(1)
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 31,0x4330
	mr 28,3
	lis 9,.LC45@ha
	xoris 0,0,0x8000
	la 9,.LC45@l(9)
	stw 0,20(1)
	stw 31,16(1)
	lfd 31,0(9)
	lfd 0,16(1)
	lis 9,matrix@ha
	la 29,matrix@l(9)
	lfs 13,24(29)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L53
	lis 9,gi+8@ha
	lis 5,.LC42@ha
	lwz 0,gi+8@l(9)
	la 5,.LC42@l(5)
	b .L59
.L53:
	mr 3,28
	bl SpellFull
	cmpwi 0,3,0
	bc 12,2,.L54
	lis 9,gi+8@ha
	lis 5,.LC4@ha
	lwz 0,gi+8@l(9)
	mr 3,28
	la 5,.LC4@l(5)
	b .L59
.L54:
	lis 9,.LC46@ha
	lfs 0,924(28)
	la 9,.LC46@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L55
	lis 9,gi+8@ha
	lis 5,.LC5@ha
	lwz 0,gi+8@l(9)
	mr 3,28
	la 5,.LC5@l(5)
.L59:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L52
.L55:
	fsubs 0,0,13
	lis 9,level@ha
	stfs 0,924(28)
	lwz 9,level@l(9)
	lfs 13,24(29)
	xoris 0,9,0x8000
	stw 0,20(1)
	stw 31,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L56
	lis 9,.LC47@ha
	la 9,.LC47@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	b .L60
.L56:
	addi 0,9,300
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 31,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
.L60:
	stfs 0,24(29)
	lis 9,level@ha
	lwz 8,level@l(9)
	lis 7,0x4330
	lis 10,.LC45@ha
	la 10,.LC45@l(10)
	lis 9,matrix@ha
	xoris 0,8,0x8000
	lfd 11,0(10)
	stw 0,20(1)
	lis 10,.LC47@ha
	stw 7,16(1)
	la 10,.LC47@l(10)
	lfd 0,16(1)
	lfs 12,0(10)
	la 10,matrix@l(9)
	fsub 0,0,11
	lfs 13,24(10)
	frsp 0,0
	fsubs 13,13,0
	fcmpu 0,13,12
	bc 4,1,.L58
	addi 0,8,300
	mr 9,11
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 7,16(1)
	lfd 0,16(1)
	fsub 0,0,11
	frsp 0,0
	stfs 0,24(10)
.L58:
	li 0,1
	stw 28,32(10)
	lis 9,gi@ha
	stw 0,12(10)
	lis 4,.LC43@ha
	li 3,2
	lwz 0,gi@l(9)
	la 4,.LC43@l(4)
	la 29,gi@l(9)
	lwz 5,84(28)
	mtlr 0
	addi 28,28,4
	addi 5,5,700
	crxor 6,6,6
	blrl
	lwz 9,100(29)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,51
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,88(29)
	li 4,0
	mr 3,28
	mtlr 9
	blrl
	lwz 0,24(29)
	lis 4,.LC44@ha
	li 3,800
	la 4,.LC44@l(4)
	mtlr 0
	blrl
.L52:
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 Cmd_Lights_f,.Lfe5-Cmd_Lights_f
	.section	".rodata"
	.align 2
.LC48:
	.string	"Screen tilting off\n"
	.align 2
.LC49:
	.string	"Screen tilting on\n"
	.align 2
.LC50:
	.string	"You can't dodge bullets while using guns.\n"
	.align 2
.LC51:
	.long 0x3f800000
	.align 3
.LC52:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC53:
	.long 0x43960000
	.align 2
.LC54:
	.long 0x42c80000
	.align 2
.LC55:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl cmd_dodgebullets_f
	.type	 cmd_dodgebullets_f,@function
cmd_dodgebullets_f:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lis 4,.LC1@ha
	lwz 11,84(31)
	la 4,.LC1@l(4)
	lwz 9,1788(11)
	lwz 3,0(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L66
	lwz 9,84(31)
	lis 4,.LC2@ha
	la 4,.LC2@l(4)
	lwz 11,1788(9)
	lwz 3,0(11)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L65
.L66:
	mr 3,31
	bl SpellFull
	cmpwi 0,3,0
	bc 12,2,.L67
	lis 9,gi+8@ha
	lis 5,.LC4@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC4@l(5)
	b .L73
.L67:
	lwz 0,1068(31)
	cmpwi 0,0,0
	bc 12,2,.L64
	lis 8,.LC51@ha
	lfs 13,924(31)
	la 8,.LC51@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	bc 4,0,.L69
	lis 9,gi+8@ha
	lis 5,.LC5@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC5@l(5)
.L73:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L64
.L69:
	lis 11,level@ha
	lfs 13,916(31)
	lwz 11,level@l(11)
	lis 10,0x4330
	lis 8,.LC52@ha
	la 8,.LC52@l(8)
	addi 0,11,100
	lfd 12,0(8)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L70
	lis 9,.LC53@ha
	la 9,.LC53@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	stfs 0,916(31)
	b .L64
.L70:
	addi 0,11,300
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
	stfs 0,916(31)
	b .L64
.L65:
	lis 9,level@ha
	lwz 10,84(31)
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 5,.LC50@ha
	lis 9,.LC52@ha
	lfs 1,3876(10)
	mr 3,31
	xoris 0,0,0x8000
	la 9,.LC52@l(9)
	stw 0,20(1)
	la 5,.LC50@l(5)
	li 4,2
	stw 8,16(1)
	lfd 13,0(9)
	lfd 0,16(1)
	lis 9,.LC54@ha
	la 9,.LC54@l(9)
	lfs 12,0(9)
	fsub 0,0,13
	lis 9,.LC55@ha
	la 9,.LC55@l(9)
	lfs 11,0(9)
	frsp 0,0
	lis 9,gi+8@ha
	lwz 0,gi+8@l(9)
	fsubs 1,1,0
	mtlr 0
	fadds 1,1,12
	fdivs 1,1,11
	creqv 6,6,6
	blrl
.L64:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 cmd_dodgebullets_f,.Lfe6-cmd_dodgebullets_f
	.align 2
	.globl Cmd_ScreenTilt_f
	.type	 Cmd_ScreenTilt_f,@function
Cmd_ScreenTilt_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,1088(31)
	cmpwi 0,0,0
	bc 12,2,.L62
	lis 9,gi+8@ha
	lis 5,.LC48@ha
	lwz 0,gi+8@l(9)
	la 5,.LC48@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	li 0,0
	stw 0,1088(31)
	b .L63
.L62:
	li 0,1
	lis 9,gi+8@ha
	stw 0,1088(31)
	lis 5,.LC49@ha
	mr 3,31
	lwz 0,gi+8@l(9)
	la 5,.LC49@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L63:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 Cmd_ScreenTilt_f,.Lfe7-Cmd_ScreenTilt_f
	.align 2
	.globl Cmd_Leg_f
	.type	 Cmd_Leg_f,@function
Cmd_Leg_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	crxor 6,6,6
	bl Decide_attack
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 Cmd_Leg_f,.Lfe8-Cmd_Leg_f
	.section	".rodata"
	.align 2
.LC56:
	.long 0x43bb8000
	.align 2
.LC57:
	.long 0x43480000
	.align 2
.LC58:
	.long 0x43160000
	.align 2
.LC59:
	.long 0x42c80000
	.section	".text"
	.align 2
	.globl Cmd_Jump_f
	.type	 Cmd_Jump_f,@function
Cmd_Jump_f:
	lwz 0,552(3)
	cmpwi 0,0,0
	bclr 12,2
	lwz 0,612(3)
	cmpwi 0,0,0
	bc 4,2,.L9
	lis 9,.LC56@ha
	lfs 0,384(3)
	lfs 13,.LC56@l(9)
	fadds 0,0,13
	stfs 0,384(3)
.L9:
	lwz 0,612(3)
	cmpwi 0,0,1
	bc 4,2,.L10
	lis 9,.LC57@ha
	lfs 0,384(3)
	la 9,.LC57@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,384(3)
.L10:
	lwz 0,612(3)
	cmpwi 0,0,2
	bc 4,2,.L11
	lis 9,.LC58@ha
	lfs 0,384(3)
	la 9,.LC58@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,384(3)
.L11:
	lwz 0,612(3)
	cmpwi 0,0,3
	bclr 4,2
	lis 9,.LC59@ha
	lfs 0,384(3)
	la 9,.LC59@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,384(3)
	blr
.Lfe9:
	.size	 Cmd_Jump_f,.Lfe9-Cmd_Jump_f
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
