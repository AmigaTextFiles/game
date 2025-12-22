	.file	"matrix_spells.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"%s Is trying to posses You.\n Hunt Him Down!\n"
	.align 2
.LC1:
	.string	"You must stay still during the countdown.\nYou Will be possesing %s\n"
	.section	".text"
	.align 2
	.globl MatrixHighestLevel
	.type	 MatrixHighestLevel,@function
MatrixHighestLevel:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,game@ha
	mr 31,3
	la 11,game@l(9)
	li 7,0
	lwz 0,1544(11)
	cmpwi 0,0,0
	bc 4,1,.L8
	lis 9,g_edicts@ha
	mr 6,11
	mtctr 0
	lwz 11,g_edicts@l(9)
	li 8,0
	addi 10,11,1116
.L10:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L9
	lwz 9,1028(6)
	add 9,8,9
	lwz 0,3480(9)
	cmpwi 0,0,0
	bc 4,2,.L9
	cmpw 0,10,31
	bc 12,2,.L9
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L9
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 12,0,.L9
	lwz 0,988(10)
	lwz 9,984(10)
	lwz 11,992(10)
	add 0,0,9
	add 0,0,11
	cmpw 0,0,7
	bc 12,0,.L9
	mr 7,0
	mr 30,10
.L9:
	addi 10,10,1116
	addi 8,8,3916
	bdnz .L10
.L8:
	lis 29,gi@ha
	lwz 5,84(31)
	lis 4,.LC0@ha
	la 29,gi@l(29)
	la 4,.LC0@l(4)
	lwz 9,12(29)
	addi 5,5,700
	mr 3,30
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 5,84(30)
	lis 4,.LC1@ha
	mr 3,31
	lwz 0,12(29)
	la 4,.LC1@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,30
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 MatrixHighestLevel,.Lfe1-MatrixHighestLevel
	.section	".rodata"
	.align 2
.LC2:
	.string	"DEBUG: Starting swap Counters\n"
	.align 2
.LC3:
	.string	"Posses is banned on this server. Type possesban 0 to fix.\n"
	.align 2
.LC4:
	.string	"You dont have enough stamina\n"
	.align 2
.LC5:
	.string	"world/10_0.wav"
	.align 2
.LC6:
	.long 0x0
	.align 2
.LC7:
	.long 0x437a0000
	.align 2
.LC8:
	.long 0x3f800000
	.align 2
.LC9:
	.long 0x41200000
	.align 3
.LC10:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl MatrixStartSwap
	.type	 MatrixStartSwap,@function
MatrixStartSwap:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,.LC6@ha
	lis 9,possesban@ha
	la 11,.LC6@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,possesban@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L27
	lis 9,gi+8@ha
	lis 5,.LC3@ha
	lwz 0,gi+8@l(9)
	la 5,.LC3@l(5)
	b .L36
.L27:
	lis 9,.LC7@ha
	lfs 13,924(31)
	la 9,.LC7@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L28
	lis 9,gi+8@ha
	lis 5,.LC4@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC4@l(5)
.L36:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L26
.L28:
	mr 3,31
	bl MatrixEffects
	lis 9,maxclients@ha
	li 7,1
	lwz 8,maxclients@l(9)
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	lfs 0,20(8)
	lfs 13,0(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L34
	lis 9,g_edicts@ha
	lis 11,level@ha
	lwz 10,g_edicts@l(9)
	la 11,level@l(11)
	lis 6,0x4330
	lis 9,.LC9@ha
	la 9,.LC9@l(9)
	addi 10,10,1116
	lfs 11,0(9)
	lis 9,.LC10@ha
	la 9,.LC10@l(9)
	lfd 12,0(9)
.L31:
	cmpwi 0,10,0
	bc 12,2,.L33
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L33
	lfs 0,4(11)
	fadds 0,0,11
	stfs 0,1028(10)
.L33:
	addi 7,7,1
	lfs 13,20(8)
	xoris 0,7,0x8000
	addi 10,10,1116
	stw 0,12(1)
	stw 6,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L31
.L34:
	lis 29,gi@ha
	lis 3,.LC2@ha
	la 29,gi@l(29)
	la 3,.LC2@l(3)
	lwz 9,4(29)
	lis 28,.LC5@ha
	mtlr 9
	crxor 6,6,6
	blrl
	mr 3,31
	bl MatrixHighestLevel
	lis 9,.LC7@ha
	lfs 0,924(31)
	la 9,.LC7@l(9)
	stw 3,1020(31)
	lfs 13,0(9)
	la 3,.LC5@l(28)
	fsubs 0,0,13
	stfs 0,924(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC8@ha
	lwz 11,16(29)
	mr 5,3
	la 9,.LC8@l(9)
	li 4,0
	lfs 1,0(9)
	mtlr 11
	mr 3,31
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 2,0(9)
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,36(29)
	la 3,.LC5@l(28)
	lwz 28,1020(31)
	mtlr 9
	blrl
	lis 9,.LC8@ha
	lwz 0,16(29)
	lis 11,.LC6@ha
	la 9,.LC8@l(9)
	la 11,.LC6@l(11)
	lfs 1,0(9)
	mr 5,3
	li 4,0
	mtlr 0
	lis 9,.LC6@ha
	lfs 2,0(11)
	mr 3,28
	la 9,.LC6@l(9)
	lfs 3,0(9)
	blrl
	lis 11,.LC9@ha
	lis 9,level+4@ha
	la 11,.LC9@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,1024(31)
.L26:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 MatrixStartSwap,.Lfe2-MatrixStartSwap
	.section	".rodata"
	.align 2
.LC11:
	.string	"%s swapped with %s"
	.align 2
.LC12:
	.string	"teleport.wav"
	.align 2
.LC13:
	.long 0x3f800000
	.align 2
.LC14:
	.long 0x0
	.section	".text"
	.align 2
	.globl MatrixPlayerSwap
	.type	 MatrixPlayerSwap,@function
MatrixPlayerSwap:
	stwu 1,-1072(1)
	mflr 0
	stmw 28,1056(1)
	stw 0,1076(1)
	mr 31,4
	mr 30,3
	lwz 6,84(31)
	cmpwi 0,6,0
	bc 12,2,.L37
	cmpw 0,31,30
	bc 12,2,.L37
	lis 29,gi@ha
	lwz 5,84(30)
	lis 4,.LC11@ha
	lwz 9,gi@l(29)
	addi 6,6,700
	la 4,.LC11@l(4)
	addi 5,5,700
	li 3,2
	mtlr 9
	la 29,gi@l(29)
	crxor 6,6,6
	blrl
	lwz 9,76(29)
	mr 3,31
	mtlr 9
	blrl
	lwz 0,76(29)
	mr 3,30
	mtlr 0
	blrl
	lis 9,game@ha
	li 6,0
	la 9,game@l(9)
	lwz 0,1556(9)
	cmpw 0,6,0
	bc 4,0,.L41
	mr 5,9
	addi 8,1,24
	li 7,0
.L43:
	lwz 10,84(30)
	addi 6,6,1
	lwz 9,84(31)
	addi 10,10,740
	lwzx 11,10,7
	addi 9,9,740
	stw 11,0(8)
	lwzx 0,9,7
	stwx 0,10,7
	lwz 9,84(31)
	lwz 11,0(8)
	addi 9,9,740
	addi 8,8,4
	stwx 11,9,7
	lwz 0,1556(5)
	addi 7,7,4
	cmpw 0,6,0
	bc 12,0,.L43
.L41:
	lwz 0,480(31)
	mr 3,30
	lis 28,.LC12@ha
	lwz 9,480(30)
	stw 0,480(30)
	stw 9,480(31)
	lwz 9,84(31)
	lwz 11,84(30)
	lwz 0,1788(9)
	lwz 10,1788(11)
	stw 0,1788(11)
	lwz 9,84(31)
	stw 10,1788(9)
	lwz 11,84(30)
	lwz 0,1788(11)
	stw 0,3564(11)
	lwz 9,84(31)
	lwz 0,1788(9)
	stw 0,3564(9)
	lwz 11,988(31)
	lwz 9,988(30)
	stw 11,988(30)
	stw 9,988(31)
	lwz 0,984(31)
	lwz 9,984(30)
	stw 0,984(30)
	stw 9,984(31)
	lwz 0,992(31)
	lwz 9,992(30)
	stw 0,992(30)
	stw 9,992(31)
	lwz 0,980(31)
	lwz 9,980(30)
	stw 0,980(30)
	lwz 0,484(31)
	stw 9,980(31)
	lwz 9,484(30)
	stw 0,484(30)
	stw 9,484(31)
	lwz 9,84(31)
	lwz 11,84(30)
	lfs 0,3876(9)
	lfs 13,3876(11)
	stfs 0,3876(11)
	lwz 9,84(31)
	stfs 13,3876(9)
	lfs 0,912(31)
	lfs 13,912(30)
	stfs 0,912(30)
	lwz 9,84(31)
	stfs 13,912(31)
	lwz 11,84(30)
	lfs 0,3884(9)
	lfs 13,3884(11)
	stfs 0,3884(11)
	lwz 9,84(31)
	stfs 13,3884(9)
	bl ChangeWeapon
	mr 3,31
	bl ChangeWeapon
	lfs 13,4(31)
	lis 29,gi@ha
	mr 3,30
	lfs 11,4(30)
	la 29,gi@l(29)
	lfs 12,8(30)
	stfs 13,4(30)
	lfs 0,8(31)
	stfs 0,8(30)
	lfs 13,12(31)
	lfs 0,12(30)
	stfs 13,12(30)
	stfs 11,4(31)
	stfs 12,8(31)
	stfs 0,12(31)
	lwz 9,72(29)
	stfs 11,8(1)
	mtlr 9
	stfs 12,12(1)
	stfs 0,16(1)
	blrl
	lwz 9,72(29)
	mr 3,31
	mtlr 9
	blrl
	lwz 9,36(29)
	la 3,.LC12@l(28)
	mtlr 9
	blrl
	lis 9,.LC13@ha
	lwz 11,16(29)
	mr 5,3
	la 9,.LC13@l(9)
	li 4,2
	lfs 1,0(9)
	mtlr 11
	mr 3,30
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 2,0(9)
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,36(29)
	la 3,.LC12@l(28)
	mtlr 9
	blrl
	lis 9,.LC13@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC13@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 2,0(9)
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfs 3,0(9)
	blrl
.L37:
	lwz 0,1076(1)
	mtlr 0
	lmw 28,1056(1)
	la 1,1072(1)
	blr
.Lfe3:
	.size	 MatrixPlayerSwap,.Lfe3-MatrixPlayerSwap
	.section	".rodata"
	.align 2
.LC15:
	.long 0x437a0000
	.section	".text"
	.align 2
	.globl MatrixPlayerChange
	.type	 MatrixPlayerChange,@function
MatrixPlayerChange:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl MatrixHighestLevel
	mr. 8,3
	bc 12,2,.L51
	cmpw 0,8,31
	bc 12,2,.L51
	lis 9,.LC15@ha
	lfs 0,924(31)
	la 9,.LC15@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L51
	fsubs 0,0,13
	lis 9,game@ha
	li 7,0
	la 9,game@l(9)
	stfs 0,924(31)
	lwz 0,1556(9)
	cmpw 0,7,0
	bc 4,0,.L56
	mr 5,9
	li 6,0
	li 10,0
.L58:
	lwz 9,84(31)
	addi 7,7,1
	addi 9,9,740
	stwx 6,9,10
	lwz 11,84(8)
	lwz 9,84(31)
	addi 11,11,740
	lwzx 0,11,10
	addi 9,9,740
	stwx 0,9,10
	lwz 11,1556(5)
	addi 10,10,4
	cmpw 0,7,11
	bc 12,0,.L58
.L56:
	lwz 0,480(8)
	mr 3,31
	lwz 10,84(31)
	stw 0,480(31)
	lfs 0,4(8)
	stfs 0,4(31)
	lfs 13,8(8)
	stfs 13,8(31)
	lfs 0,12(8)
	stfs 0,12(31)
	lwz 9,84(8)
	lwz 0,1788(9)
	stw 0,1788(10)
	lwz 11,84(31)
	lwz 0,1788(11)
	stw 0,3564(11)
	lwz 9,988(8)
	stw 9,988(31)
	lwz 0,984(8)
	stw 0,984(31)
	lwz 9,992(8)
	stw 9,992(31)
	lwz 0,980(8)
	stw 0,980(31)
	lwz 9,484(8)
	stw 9,484(31)
	bl KillBox
	mr 3,31
	bl ChangeWeapon
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L51:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 MatrixPlayerChange,.Lfe4-MatrixPlayerChange
	.section	".rodata"
	.align 2
.LC16:
	.string	"bolt"
	.align 2
.LC17:
	.string	"grenade"
	.align 2
.LC18:
	.string	"hgrenade"
	.align 2
.LC19:
	.string	"rocket"
	.align 2
.LC20:
	.string	"bullet"
	.align 2
.LC21:
	.string	"bfg blast"
	.align 2
.LC23:
	.string	"buletstp.wav"
	.align 3
.LC22:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC24:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC25:
	.long 0x0
	.align 2
.LC26:
	.long 0x3f800000
	.align 2
.LC27:
	.long 0x43070000
	.section	".text"
	.align 2
	.globl MatrixStopBullets
	.type	 MatrixStopBullets,@function
MatrixStopBullets:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 10,0x4330
	mr 30,3
	lis 9,.LC24@ha
	lfs 12,912(30)
	li 31,0
	xoris 0,0,0x8000
	la 9,.LC24@l(9)
	stw 0,12(1)
	stw 10,8(1)
	lfd 13,0(9)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 12,0,.L60
	addi 28,30,4
	b .L62
.L64:
	lwz 0,256(31)
	cmpw 0,0,30
	bc 12,2,.L62
	lwz 3,280(31)
	lis 4,.LC16@ha
	la 4,.LC16@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L66
	lwz 3,280(31)
	lis 4,.LC17@ha
	la 4,.LC17@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L66
	lwz 3,280(31)
	lis 4,.LC18@ha
	la 4,.LC18@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L66
	lwz 3,280(31)
	lis 4,.LC19@ha
	la 4,.LC19@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L66
	lwz 3,280(31)
	lis 4,.LC20@ha
	la 4,.LC20@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L66
	lwz 3,280(31)
	lis 4,.LC21@ha
	la 4,.LC21@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L62
.L66:
	lis 9,.LC25@ha
	lfs 0,376(31)
	la 9,.LC25@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L68
	lfs 0,380(31)
	fcmpu 0,0,13
	bc 12,2,.L67
.L68:
	stfs 13,376(31)
	stfs 13,384(31)
	stfs 13,380(31)
.L67:
	lis 9,sv_gravity@ha
	lis 11,.LC22@ha
	lfs 13,384(31)
	lwz 10,sv_gravity@l(9)
	lis 29,gi@ha
	lis 3,.LC23@ha
	lfd 12,.LC22@l(11)
	la 29,gi@l(29)
	la 3,.LC23@l(3)
	lfs 0,20(10)
	fmul 0,0,12
	fsub 13,13,0
	frsp 13,13
	stfs 13,384(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC26@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC26@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC26@ha
	la 9,.LC26@l(9)
	lfs 2,0(9)
	lis 9,.LC25@ha
	la 9,.LC25@l(9)
	lfs 3,0(9)
	blrl
.L62:
	lis 9,.LC27@ha
	mr 3,31
	la 9,.LC27@l(9)
	mr 4,28
	lfs 1,0(9)
	bl findradius
	mr. 31,3
	bc 4,2,.L64
.L60:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 MatrixStopBullets,.Lfe5-MatrixStopBullets
	.section	".rodata"
	.align 2
.LC28:
	.long 0x46fffe00
	.align 2
.LC29:
	.long 0x3dcccccd
	.align 3
.LC30:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC31:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC32:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC33:
	.long 0x402e0000
	.long 0x0
	.align 2
.LC34:
	.long 0x3f000000
	.align 2
.LC35:
	.long 0x43960000
	.section	".text"
	.align 2
	.globl Effectthink
	.type	 Effectthink,@function
Effectthink:
	stwu 1,-96(1)
	mflr 0
	stfd 28,64(1)
	stfd 29,72(1)
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 27,44(1)
	stw 0,100(1)
	mr 31,3
	lis 9,level@ha
	lwz 11,256(31)
	la 30,level@l(9)
	lfs 13,4(30)
	lfs 0,1024(11)
	fcmpu 0,0,13
	bc 4,0,.L76
	bl G_FreeEdict
	b .L75
.L76:
	lfs 13,4(11)
	lis 9,.LC31@ha
	lis 29,0x4330
	lfs 0,4(31)
	la 9,.LC31@l(9)
	addi 28,31,376
	lfs 11,8(31)
	lis 27,.LC29@ha
	lfs 12,12(31)
	fsubs 13,13,0
	lfd 31,0(9)
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
	stfs 13,8(1)
	lfs 0,8(11)
	lfd 30,0(9)
	lis 9,.LC33@ha
	fsubs 0,0,11
	la 9,.LC33@l(9)
	lfd 29,0(9)
	stfs 0,12(1)
	lfs 13,12(11)
	fsubs 13,13,12
	stfs 13,16(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,376(31)
	xoris 3,3,0x8000
	lis 11,.LC28@ha
	stw 3,36(1)
	stw 29,32(1)
	lfd 13,32(1)
	lfs 28,.LC28@l(11)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,29,12
	frsp 0,0
	stfs 0,376(31)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,380(31)
	xoris 3,3,0x8000
	stw 3,36(1)
	stw 29,32(1)
	lfd 13,32(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,29,12
	frsp 0,0
	stfs 0,380(31)
	bl rand
	rlwinm 0,3,0,17,31
	lfs 12,384(31)
	xoris 0,0,0x8000
	addi 3,1,8
	stw 0,36(1)
	stw 29,32(1)
	lfd 13,32(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,29,12
	frsp 0,0
	stfs 0,384(31)
	bl VectorNormalize
	mr 3,28
	bl VectorNormalize
	lis 9,.LC34@ha
	addi 3,1,8
	la 9,.LC34@l(9)
	mr 4,3
	lfs 1,0(9)
	bl VectorScale
	lfs 11,8(1)
	mr 3,28
	lfs 10,12(1)
	lfs 9,16(1)
	lfs 12,376(31)
	lfs 0,380(31)
	lfs 13,384(31)
	fadds 12,12,11
	fadds 0,0,10
	fadds 13,13,9
	stfs 12,376(31)
	stfs 0,380(31)
	stfs 13,384(31)
	bl VectorNormalize
	lis 9,.LC35@ha
	mr 3,28
	la 9,.LC35@l(9)
	mr 4,28
	lfs 1,0(9)
	bl VectorScale
	lfs 1,.LC29@l(27)
	addi 3,31,16
	addi 4,31,388
	mr 5,3
	bl VectorMA
	lfs 1,.LC29@l(27)
	addi 3,31,4
	mr 4,28
	mr 5,3
	bl VectorMA
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lfs 0,4(30)
	lis 11,.LC30@ha
	lis 9,Effectthink@ha
	lfd 13,.LC30@l(11)
	la 9,Effectthink@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L75:
	lwz 0,100(1)
	mtlr 0
	lmw 27,44(1)
	lfd 28,64(1)
	lfd 29,72(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe6:
	.size	 Effectthink,.Lfe6-Effectthink
	.section	".rodata"
	.align 2
.LC36:
	.long 0x46fffe00
	.align 3
.LC37:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC38:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC39:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC40:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC41:
	.long 0x42c80000
	.section	".text"
	.align 2
	.globl MatrixEffects
	.type	 MatrixEffects,@function
MatrixEffects:
	stwu 1,-176(1)
	mflr 0
	stfd 28,144(1)
	stfd 29,152(1)
	stfd 30,160(1)
	stfd 31,168(1)
	stmw 21,100(1)
	stw 0,180(1)
	lis 9,.LC36@ha
	mr 30,3
	lfs 28,.LC36@l(9)
	li 28,0
	lis 21,level@ha
	lis 9,.LC38@ha
	lis 22,.LC37@ha
	la 9,.LC38@l(9)
	lis 23,Effectthink@ha
	lfd 29,0(9)
	lis 24,gi@ha
	li 25,0
	lis 9,.LC39@ha
	lis 26,0x4330
	la 9,.LC39@l(9)
	addi 27,1,56
	lfd 30,0(9)
	li 29,0
	lis 9,.LC40@ha
	la 9,.LC40@l(9)
	lfd 31,0(9)
.L81:
	bl G_Spawn
	mr 31,3
	stw 25,40(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,92(1)
	stw 26,88(1)
	lfd 13,88(1)
	fsub 13,13,29
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fadd 0,0,0
	fsub 0,0,31
	frsp 0,0
	stfs 0,56(1)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,92(1)
	stw 26,88(1)
	lfd 13,88(1)
	fsub 13,13,29
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fadd 0,0,0
	fsub 0,0,31
	frsp 0,0
	stfs 0,60(1)
	bl rand
	rlwinm 0,3,0,17,31
	xoris 0,0,0x8000
	mr 3,27
	stw 0,92(1)
	stw 26,88(1)
	lfd 13,88(1)
	fsub 13,13,29
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fadd 0,0,0
	fsub 0,0,31
	frsp 0,0
	stfs 0,64(1)
	bl VectorNormalize
	lis 9,.LC41@ha
	mr 3,27
	la 9,.LC41@l(9)
	addi 4,31,376
	lfs 1,0(9)
	bl VectorScale
	lfs 13,4(30)
	cmpwi 0,28,0
	stfs 13,4(31)
	lfs 0,8(30)
	stfs 0,8(31)
	lfs 13,12(30)
	stfs 13,12(31)
	lfs 0,16(30)
	stfs 0,16(31)
	lfs 13,20(30)
	stfs 13,20(31)
	lfs 0,24(30)
	stw 25,248(31)
	stfs 0,24(31)
	bc 4,2,.L82
	lwz 0,64(31)
	oris 0,0,0x2000
	b .L87
.L82:
	cmpwi 0,28,1
	bc 4,2,.L84
	lwz 0,64(31)
	oris 0,0,0x4
	b .L87
.L84:
	lwz 0,64(31)
	oris 0,0,0x8
.L87:
	stw 0,64(31)
	lwz 9,184(31)
	li 0,1
	la 11,level@l(21)
	stw 0,260(31)
	la 10,Effectthink@l(23)
	la 8,gi@l(24)
	ori 9,9,4
	stw 30,256(31)
	mr 3,31
	stw 9,184(31)
	addi 28,28,1
	stw 29,196(31)
	stw 29,192(31)
	stw 29,188(31)
	stw 29,208(31)
	stw 29,204(31)
	stw 29,200(31)
	lfs 0,4(11)
	lfd 13,.LC37@l(22)
	stw 10,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,72(8)
	mtlr 0
	blrl
	cmpwi 0,28,2
	bc 4,1,.L81
	lwz 0,180(1)
	mtlr 0
	lmw 21,100(1)
	lfd 28,144(1)
	lfd 29,152(1)
	lfd 30,160(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe7:
	.size	 MatrixEffects,.Lfe7-MatrixEffects
	.section	".rodata"
	.align 2
.LC43:
	.string	"whatever.wav"
	.align 3
.LC42:
	.long 0x3ff451eb
	.long 0x851eb852
	.align 3
.LC44:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC45:
	.long 0x0
	.align 2
.LC46:
	.long 0x40400000
	.align 2
.LC47:
	.long 0x40a00000
	.align 2
.LC48:
	.long 0x3f800000
	.align 2
.LC49:
	.long 0x43800000
	.section	".text"
	.align 2
	.globl dodgebullets
	.type	 dodgebullets,@function
dodgebullets:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 10,0x4330
	mr 30,3
	lis 9,.LC44@ha
	lfs 12,916(30)
	li 31,0
	xoris 0,0,0x8000
	la 9,.LC44@l(9)
	stw 0,12(1)
	stw 10,8(1)
	lfd 13,0(9)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 12,0,.L88
	lwz 0,1068(30)
	cmpwi 0,0,0
	bc 12,2,.L88
	lis 9,.LC45@ha
	lfs 13,924(30)
	la 9,.LC45@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L88
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	lfs 0,0(9)
	fsubs 0,13,0
	stfs 0,924(30)
	addi 28,30,4
	b .L91
.L93:
	lwz 0,256(31)
	cmpw 0,0,30
	bc 12,2,.L91
	lwz 3,280(31)
	lis 4,.LC16@ha
	la 4,.LC16@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L95
	lwz 3,280(31)
	lis 4,.LC17@ha
	la 4,.LC17@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L95
	lwz 3,280(31)
	lis 4,.LC18@ha
	la 4,.LC18@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L95
	lwz 3,280(31)
	lis 4,.LC19@ha
	la 4,.LC19@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L95
	lwz 3,280(31)
	lis 4,.LC20@ha
	la 4,.LC20@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L95
	lwz 3,280(31)
	lis 4,.LC21@ha
	la 4,.LC21@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L91
.L95:
	cmpwi 0,31,-376
	bc 12,2,.L97
	lis 9,.LC47@ha
	lfs 10,376(31)
	la 9,.LC47@l(9)
	lfs 11,384(31)
	lfs 12,0(9)
	lfs 9,380(31)
	lis 9,.LC20@ha
	lwz 0,280(31)
	la 9,.LC20@l(9)
	fdivs 13,10,12
	cmpw 0,0,9
	fdivs 0,11,12
	fdivs 12,9,12
	fsubs 10,10,13
	fsubs 13,11,0
	fsubs 9,9,12
	stfs 10,376(31)
	stfs 13,384(31)
	stfs 9,380(31)
	bc 4,2,.L97
	lis 9,.LC42@ha
	fmr 11,10
	lfd 0,.LC42@l(9)
	fmr 12,9
	fdiv 10,11,0
	fdiv 9,13,0
	fdiv 0,12,0
	fsub 11,11,10
	fsub 12,12,0
	fsub 13,13,9
	frsp 11,11
	frsp 12,12
	frsp 13,13
	stfs 11,376(31)
	stfs 12,380(31)
	stfs 13,384(31)
.L97:
	lis 29,gi@ha
	lis 3,.LC43@ha
	la 29,gi@l(29)
	la 3,.LC43@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC48@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC48@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC48@ha
	la 9,.LC48@l(9)
	lfs 2,0(9)
	lis 9,.LC45@ha
	la 9,.LC45@l(9)
	lfs 3,0(9)
	blrl
.L91:
	lis 9,.LC49@ha
	mr 3,31
	la 9,.LC49@l(9)
	mr 4,28
	lfs 1,0(9)
	bl findradius
	mr. 31,3
	bc 4,2,.L93
.L88:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 dodgebullets,.Lfe8-dodgebullets
	.section	".sbss","aw",@nobits
	.align 2
quad_drop_timeout_hack:
	.space	4
	.size	 quad_drop_timeout_hack,4
	.section	".text"
	.align 2
	.globl MatrixCancelSwap
	.type	 MatrixCancelSwap,@function
MatrixCancelSwap:
	li 0,0
	li 9,0
	stw 0,1020(3)
	stw 9,1024(3)
	blr
.Lfe9:
	.size	 MatrixCancelSwap,.Lfe9-MatrixCancelSwap
	.section	".rodata"
	.align 2
.LC50:
	.long 0x3f800000
	.align 2
.LC51:
	.long 0x41200000
	.align 3
.LC52:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SwapCounters
	.type	 SwapCounters,@function
SwapCounters:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,maxclients@ha
	lis 11,.LC50@ha
	lwz 8,maxclients@l(9)
	la 11,.LC50@l(11)
	li 7,1
	lfs 13,0(11)
	lfs 0,20(8)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L21
	lis 9,g_edicts@ha
	lis 11,level@ha
	lwz 10,g_edicts@l(9)
	la 11,level@l(11)
	lis 6,0x4330
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	addi 10,10,1116
	lfs 11,0(9)
	lis 9,.LC52@ha
	la 9,.LC52@l(9)
	lfd 12,0(9)
.L23:
	cmpwi 0,10,0
	bc 12,2,.L22
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L22
	lfs 0,4(11)
	fadds 0,0,11
	stfs 0,1028(10)
.L22:
	addi 7,7,1
	lfs 13,20(8)
	xoris 0,7,0x8000
	addi 10,10,1116
	stw 0,12(1)
	stw 6,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L23
.L21:
	lis 9,gi+4@ha
	lis 3,.LC2@ha
	lwz 0,gi+4@l(9)
	la 3,.LC2@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe10:
	.size	 SwapCounters,.Lfe10-SwapCounters
	.section	".rodata"
	.align 2
.LC53:
	.long 0x0
	.section	".text"
	.align 2
	.globl MatrixSwapThink
	.type	 MatrixSwapThink,@function
MatrixSwapThink:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,1024(31)
	fcmpu 0,0,13
	bc 12,0,.L45
	addi 3,31,376
	bl VectorLength
	lis 9,.LC53@ha
	la 9,.LC53@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,2,.L48
	lwz 0,1020(31)
	cmpwi 0,0,0
	bc 4,2,.L47
.L48:
	li 0,0
	stfs 0,1024(31)
	stw 0,1020(31)
.L47:
	lis 9,level+4@ha
	lfs 13,1024(31)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,2,.L45
	lwz 4,1020(31)
	lwz 0,492(4)
	cmpwi 0,0,0
	bc 4,2,.L45
	mr 3,31
	bl MatrixPlayerSwap
.L45:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 MatrixSwapThink,.Lfe11-MatrixSwapThink
	.align 2
	.globl MatrixTankDropItem
	.type	 MatrixTankDropItem,@function
MatrixTankDropItem:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	lwz 9,84(31)
	lwz 0,3488(9)
	cmpwi 0,0,0
	bc 12,2,.L70
.L72:
	bl rand
	lis 11,game+1556@ha
	lis 9,itemlist@ha
	lwz 10,game+1556@l(11)
	la 9,itemlist@l(9)
	divw 0,3,10
	mullw 0,0,10
	subf 3,0,3
	mulli 3,3,80
	add 4,3,9
	lwz 0,56(4)
	and. 9,0,30
	bc 12,2,.L72
	lwz 0,24(4)
	cmpwi 0,0,0
	bc 12,2,.L72
	mr 3,31
	bl Drop_Item
.L70:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 MatrixTankDropItem,.Lfe12-MatrixTankDropItem
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
