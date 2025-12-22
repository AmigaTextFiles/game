	.file	"g_IRgoggles.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 stuff_light,@object
	.size	 stuff_light,4
stuff_light:
	.long 1
	.section	".rodata"
	.align 3
.LC0:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Use_IRgoggles
	.type	 Use_IRgoggles,@function
Use_IRgoggles:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	lis 11,itemlist@ha
	lis 0,0x286b
	la 11,itemlist@l(11)
	mr 31,3
	ori 0,0,51739
	subf 11,11,4
	lwz 10,84(31)
	mullw 11,11,0
	lis 9,IR_type_dropped@ha
	stw 4,IR_type_dropped@l(9)
	addi 10,10,740
	rlwinm 11,11,0,0,29
	lwzx 9,10,11
	addi 9,9,-1
	stwx 9,10,11
	bl ValidateSelectedItem
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 4,2,.L7
	bl getIRMarineFOV
	xoris 3,3,0x8000
	lwz 11,84(31)
	stw 3,20(1)
	lis 0,0x4330
	lis 10,.LC0@ha
	la 10,.LC0@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,112(11)
.L7:
	lis 29,level@ha
	lwz 11,84(31)
	lwz 0,level@l(29)
	lis 30,0x4330
	lis 10,.LC0@ha
	la 10,.LC0@l(10)
	lfs 13,3860(11)
	xoris 0,0,0x8000
	lfd 31,0(10)
	stw 0,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L8
	bl getIREffectTime
	mulli 3,3,10
	lwz 11,84(31)
	xoris 3,3,0x8000
	lfs 13,3860(11)
	stw 3,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	fadds 13,13,0
	stfs 13,3860(11)
	b .L9
.L8:
	bl getIREffectTime
	lwz 0,level@l(29)
	mulli 3,3,10
	lwz 11,84(31)
	add 0,0,3
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,3860(11)
.L9:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 Use_IRgoggles,.Lfe1-Use_IRgoggles
	.section	".rodata"
	.align 2
.LC1:
	.string	"item_quad"
	.align 2
.LC2:
	.string	"IR goggles"
	.align 2
.LC3:
	.string	"item_invulnerability"
	.align 2
.LC4:
	.string	"Quad Damage"
	.align 2
.LC5:
	.string	"Invulnerability"
	.align 2
.LC6:
	.string	"fov"
	.align 3
.LC7:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC8:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl G_SetIREffects
	.type	 G_SetIREffects,@function
G_SetIREffects:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 26,16(1)
	stw 0,52(1)
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 10,0x4330
	mr 29,3
	lis 9,.LC7@ha
	xoris 0,0,0x8000
	la 9,.LC7@l(9)
	stw 0,12(1)
	stw 10,8(1)
	lfd 12,0(9)
	lfd 0,8(1)
	lwz 9,84(29)
	fsub 0,0,12
	lfs 13,3860(9)
	frsp 0,0
	fcmpu 0,13,0
	bc 12,1,.L14
	lwz 0,932(29)
	cmpwi 0,0,0
	bc 12,2,.L13
	lwz 0,3812(9)
	cmpwi 0,0,0
	bc 4,2,.L13
.L14:
	lis 10,.LC8@ha
	lis 9,maxclients@ha
	la 10,.LC8@l(10)
	lis 11,g_edicts@ha
	lfs 13,0(10)
	li 28,1
	lis 26,maxclients@ha
	lwz 10,maxclients@l(9)
	lwz 9,g_edicts@l(11)
	lfs 0,20(10)
	addi 31,9,952
	fcmpu 0,13,0
	bc 4,0,.L24
	lis 11,.LC7@ha
	lis 9,gi@ha
	la 11,.LC7@l(11)
	lis 27,0x4330
	lfd 31,0(11)
	la 30,gi@l(9)
.L18:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L17
	cmpw 0,31,29
	bc 12,2,.L17
	lwz 0,932(31)
	cmpwi 0,0,0
	bc 4,2,.L17
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L17
	lwz 9,100(30)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(30)
	li 3,25
	mtlr 9
	blrl
	lwz 9,100(30)
	li 3,1
	mtlr 9
	blrl
	lwz 9,120(30)
	addi 3,31,4
	mtlr 9
	blrl
	lwz 9,124(30)
	addi 3,31,340
	mtlr 9
	blrl
	lwz 9,100(30)
	li 3,0
	mtlr 9
	blrl
	lwz 9,92(30)
	mr 3,29
	li 4,0
	mtlr 9
	blrl
.L17:
	addi 28,28,1
	lwz 11,maxclients@l(26)
	xoris 0,28,0x8000
	addi 31,31,952
	stw 0,12(1)
	stw 27,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L18
	b .L24
.L13:
	lwz 0,896(29)
	cmpwi 0,0,0
	bc 4,2,.L24
	lwz 3,84(29)
	lis 31,.LC6@ha
	la 4,.LC6@l(31)
	addi 3,3,188
	bl Info_ValueForKey
	bl atoi
	cmpwi 0,3,89
	bc 4,1,.L26
	lwz 3,84(29)
	la 4,.LC6@l(31)
	addi 3,3,188
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	lwz 11,84(29)
	stw 3,12(1)
	lis 0,0x4330
	lis 10,.LC7@ha
	la 10,.LC7@l(10)
	stw 0,8(1)
	lfd 13,0(10)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,112(11)
	b .L24
.L26:
	lwz 9,84(29)
	lis 0,0x42b4
	stw 0,112(9)
.L24:
	lwz 9,84(29)
	lwz 10,3812(9)
	cmpwi 0,10,0
	bc 12,2,.L28
	lis 11,level@ha
	lwz 10,84(10)
	lwz 0,level@l(11)
	lis 31,0x4330
	lis 11,.LC7@ha
	lfs 13,3860(10)
	xoris 0,0,0x8000
	la 11,.LC7@l(11)
	stw 0,12(1)
	stw 31,8(1)
	lfd 31,0(11)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L28
	lwz 0,896(29)
	cmpwi 0,0,0
	bc 4,2,.L30
	lwz 0,932(29)
	cmpwi 0,0,0
	bc 4,2,.L30
	bl getIRMarineFOV
	xoris 3,3,0x8000
	lwz 11,84(29)
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,112(11)
.L30:
	lis 10,.LC8@ha
	lis 9,maxclients@ha
	la 10,.LC8@l(10)
	lis 11,g_edicts@ha
	lfs 13,0(10)
	li 28,1
	lis 26,maxclients@ha
	lwz 10,maxclients@l(9)
	lwz 9,g_edicts@l(11)
	lfs 0,20(10)
	addi 31,9,952
	fcmpu 0,13,0
	bc 4,0,.L28
	lis 11,.LC7@ha
	lis 9,gi@ha
	la 11,.LC7@l(11)
	lis 27,0x4330
	lfd 31,0(11)
	la 30,gi@l(9)
.L34:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L33
	cmpw 0,31,29
	bc 12,2,.L33
	lwz 0,932(31)
	cmpwi 0,0,0
	bc 4,2,.L33
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L33
	lwz 9,84(29)
	lwz 0,3812(9)
	cmpw 0,31,0
	bc 12,2,.L33
	lwz 9,100(30)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(30)
	li 3,25
	mtlr 9
	blrl
	lwz 9,100(30)
	li 3,1
	mtlr 9
	blrl
	lwz 9,120(30)
	addi 3,31,4
	mtlr 9
	blrl
	lwz 9,124(30)
	addi 3,31,340
	mtlr 9
	blrl
	lwz 9,100(30)
	li 3,0
	mtlr 9
	blrl
	lwz 9,92(30)
	mr 3,29
	li 4,0
	mtlr 9
	blrl
.L33:
	addi 28,28,1
	lwz 11,maxclients@l(26)
	xoris 0,28,0x8000
	addi 31,31,952
	stw 0,12(1)
	stw 27,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L34
.L28:
	lwz 0,52(1)
	mtlr 0
	lmw 26,16(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 G_SetIREffects,.Lfe2-G_SetIREffects
	.section	".rodata"
	.align 2
.LC9:
	.string	"IR_marine_fov"
	.align 2
.LC10:
	.string	"75"
	.align 2
.LC11:
	.string	"IR_effect_time"
	.align 2
.LC12:
	.string	"30"
	.comm	showscores,4,4
	.comm	nextdynamicset,4,4
	.comm	predatorModel,32,4
	.comm	predatorSkin,64,4
	.comm	marineSkin,64,4
	.comm	maplist_lastmap,64,4
	.comm	maplist2_lastmap,64,4
	.comm	maplist3_lastmap,64,4
	.comm	last_beat,4,4
	.section	".text"
	.align 2
	.globl enable_IRgoggles
	.type	 enable_IRgoggles,@function
enable_IRgoggles:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 3,.LC1@ha
	la 3,.LC1@l(3)
	bl FindItemByClassname
	mr 9,3
	lis 28,Use_IRgoggles@ha
	lis 29,.LC2@ha
	la 28,Use_IRgoggles@l(28)
	la 29,.LC2@l(29)
	lis 3,.LC3@ha
	stw 28,8(9)
	stw 29,40(9)
	la 3,.LC3@l(3)
	bl FindItemByClassname
	mr 9,3
	stw 29,40(9)
	stw 28,8(9)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 enable_IRgoggles,.Lfe3-enable_IRgoggles
	.align 2
	.globl enable_Quad
	.type	 enable_Quad,@function
enable_Quad:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 3,.LC1@ha
	la 3,.LC1@l(3)
	bl FindItemByClassname
	mr 10,3
	lis 9,Use_Quad@ha
	lis 11,.LC4@ha
	la 9,Use_Quad@l(9)
	la 11,.LC4@l(11)
	lis 3,.LC3@ha
	stw 9,8(10)
	stw 11,40(10)
	la 3,.LC3@l(3)
	bl FindItemByClassname
	lis 9,Use_Invulnerability@ha
	lis 11,.LC5@ha
	mr 10,3
	la 9,Use_Invulnerability@l(9)
	la 11,.LC5@l(11)
	stw 9,8(10)
	stw 11,40(10)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe4:
	.size	 enable_Quad,.Lfe4-enable_Quad
	.section	".rodata"
	.align 3
.LC13:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl deadDropIRgoggles
	.type	 deadDropIRgoggles,@function
deadDropIRgoggles:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 10,0x4330
	mr 31,3
	lis 9,.LC13@ha
	xoris 0,0,0x8000
	la 9,.LC13@l(9)
	stw 0,20(1)
	stw 10,16(1)
	lfd 12,0(9)
	lfd 0,16(1)
	lwz 9,84(31)
	fsub 0,0,12
	lfs 13,3860(9)
	frsp 0,0
	fcmpu 0,13,0
	cror 3,2,0
	bc 12,3,.L41
	lis 9,IR_type_dropped@ha
	lwz 4,IR_type_dropped@l(9)
	bl Drop_Item
	lwz 9,84(31)
	li 0,0
	stw 0,3860(9)
.L41:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 deadDropIRgoggles,.Lfe5-deadDropIRgoggles
	.comm	IR_type_dropped,4,4
	.section	".rodata"
	.align 2
.LC14:
	.long 0x42340000
	.align 2
.LC15:
	.long 0x42f00000
	.section	".text"
	.align 2
	.globl validateIRMarineFOV
	.type	 validateIRMarineFOV,@function
validateIRMarineFOV:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC14@ha
	lis 9,IR_marine_fov@ha
	la 11,.LC14@l(11)
	lfs 0,0(11)
	lwz 11,IR_marine_fov@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L45
	lis 9,.LC15@ha
	la 9,.LC15@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L44
.L45:
	lis 9,gi+148@ha
	lis 3,.LC9@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC10@ha
	la 3,.LC9@l(3)
	la 4,.LC10@l(4)
	mtlr 0
	blrl
.L44:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 validateIRMarineFOV,.Lfe6-validateIRMarineFOV
	.section	".rodata"
	.align 2
.LC16:
	.long 0x42340000
	.align 2
.LC17:
	.long 0x42f00000
	.section	".text"
	.align 2
	.globl getIRMarineFOV
	.type	 getIRMarineFOV,@function
getIRMarineFOV:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,IR_marine_fov@ha
	lwz 9,IR_marine_fov@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L47
	lfs 13,20(9)
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L48
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L47
.L48:
	lis 9,gi+148@ha
	lis 3,.LC9@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC10@ha
	la 3,.LC9@l(3)
	la 4,.LC10@l(4)
	mtlr 0
	blrl
.L47:
	lis 11,IR_marine_fov@ha
	lwz 9,IR_marine_fov@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe7:
	.size	 getIRMarineFOV,.Lfe7-getIRMarineFOV
	.section	".rodata"
	.align 2
.LC18:
	.long 0x0
	.align 2
.LC19:
	.long 0x42f00000
	.section	".text"
	.align 2
	.globl validateIREffectTime
	.type	 validateIREffectTime,@function
validateIREffectTime:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC18@ha
	lis 9,IR_effect_time@ha
	la 11,.LC18@l(11)
	lfs 0,0(11)
	lwz 11,IR_effect_time@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L53
	lis 9,.LC19@ha
	la 9,.LC19@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L52
.L53:
	lis 9,gi+148@ha
	lis 3,.LC11@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC12@ha
	la 3,.LC11@l(3)
	la 4,.LC12@l(4)
	mtlr 0
	blrl
.L52:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 validateIREffectTime,.Lfe8-validateIREffectTime
	.section	".rodata"
	.align 2
.LC20:
	.long 0x0
	.align 2
.LC21:
	.long 0x42f00000
	.section	".text"
	.align 2
	.globl getIREffectTime
	.type	 getIREffectTime,@function
getIREffectTime:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,IR_effect_time@ha
	lwz 9,IR_effect_time@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L55
	lfs 13,20(9)
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L56
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L55
.L56:
	lis 9,gi+148@ha
	lis 3,.LC11@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC12@ha
	la 3,.LC11@l(3)
	la 4,.LC12@l(4)
	mtlr 0
	blrl
.L55:
	lis 11,IR_effect_time@ha
	lwz 9,IR_effect_time@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 getIREffectTime,.Lfe9-getIREffectTime
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
