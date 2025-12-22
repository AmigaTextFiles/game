	.file	"g_safety.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 stuff_light,@object
	.size	 stuff_light,4
stuff_light:
	.long 1
	.section	".rodata"
	.align 2
.LC0:
	.string	"marine_safety_time"
	.align 2
.LC1:
	.string	"10"
	.align 2
.LC2:
	.string	"predator_safety_time"
	.align 2
.LC3:
	.string	"2"
	.comm	showscores,4,4
	.comm	nextdynamicset,4,4
	.align 2
.LC4:
	.long 0x0
	.section	".text"
	.align 2
	.globl setSafetyMode
	.type	 setSafetyMode,@function
setSafetyMode:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L7
	bl getPredatorSafetyTime
	cmpwi 0,3,0
	bc 4,1,.L6
	lis 9,.LC4@ha
	lis 11,enable_predator_safety@ha
	la 9,.LC4@l(9)
	lfs 13,0(9)
	lwz 9,enable_predator_safety@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L6
	bl getPredatorSafetyTime
	b .L35
.L7:
	bl getMarineSafetyTime
	cmpwi 0,3,0
	bc 4,1,.L6
	lis 9,.LC4@ha
	lis 11,enable_marine_safety@ha
	la 9,.LC4@l(9)
	lfs 13,0(9)
	lwz 9,enable_marine_safety@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L6
	bl getMarineSafetyTime
.L35:
	lis 11,level+4@ha
	lfs 0,level+4@l(11)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	add 9,9,3
	stw 9,944(31)
	li 9,0
	lwz 10,84(31)
	li 11,1
	stw 9,512(31)
	li 0,1
	sth 11,166(10)
	stw 0,940(31)
.L6:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 setSafetyMode,.Lfe1-setSafetyMode
	.align 2
	.globl clearSafetyMode
	.type	 clearSafetyMode,@function
clearSafetyMode:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,940(31)
	cmpwi 0,0,0
	bc 12,2,.L13
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L15
	bl getPredatorSafetyTime
	b .L36
.L15:
	bl getMarineSafetyTime
.L36:
	cmpwi 0,3,0
	bc 4,1,.L13
	li 9,0
	lwz 11,84(31)
	li 0,1
	stw 0,512(31)
	stw 9,940(31)
	sth 9,166(11)
.L13:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe2:
	.size	 clearSafetyMode,.Lfe2-clearSafetyMode
	.section	".rodata"
	.align 2
.LC5:
	.long 0x0
	.align 2
.LC6:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl validateMarineSafetyTime
	.type	 validateMarineSafetyTime,@function
validateMarineSafetyTime:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC5@ha
	lis 9,marine_safety_time@ha
	la 11,.LC5@l(11)
	lfs 0,0(11)
	lwz 11,marine_safety_time@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L21
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L20
.L21:
	lis 9,gi+148@ha
	lis 3,.LC0@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC1@ha
	la 3,.LC0@l(3)
	la 4,.LC1@l(4)
	mtlr 0
	blrl
.L20:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe3:
	.size	 validateMarineSafetyTime,.Lfe3-validateMarineSafetyTime
	.section	".rodata"
	.align 2
.LC7:
	.long 0x0
	.align 2
.LC8:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl validatePredatorSafetyTime
	.type	 validatePredatorSafetyTime,@function
validatePredatorSafetyTime:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC7@ha
	lis 9,predator_safety_time@ha
	la 11,.LC7@l(11)
	lfs 0,0(11)
	lwz 11,predator_safety_time@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L29
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L28
.L29:
	lis 9,gi+148@ha
	lis 3,.LC2@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC3@ha
	la 3,.LC2@l(3)
	la 4,.LC3@l(4)
	mtlr 0
	blrl
.L28:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe4:
	.size	 validatePredatorSafetyTime,.Lfe4-validatePredatorSafetyTime
	.section	".rodata"
	.align 2
.LC9:
	.long 0x0
	.align 2
.LC10:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl getMarineSafetyTime
	.type	 getMarineSafetyTime,@function
getMarineSafetyTime:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,marine_safety_time@ha
	lwz 9,marine_safety_time@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L23
	lfs 13,20(9)
	lis 9,.LC9@ha
	la 9,.LC9@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L24
	lis 9,.LC10@ha
	la 9,.LC10@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L23
.L24:
	lis 9,gi+148@ha
	lis 3,.LC0@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC1@ha
	la 3,.LC0@l(3)
	la 4,.LC1@l(4)
	mtlr 0
	blrl
.L23:
	lis 11,marine_safety_time@ha
	lwz 9,marine_safety_time@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe5:
	.size	 getMarineSafetyTime,.Lfe5-getMarineSafetyTime
	.comm	predatorModel,32,4
	.comm	predatorSkin,64,4
	.comm	marineSkin,64,4
	.comm	maplist_lastmap,64,4
	.comm	maplist2_lastmap,64,4
	.comm	maplist3_lastmap,64,4
	.comm	last_beat,4,4
	.section	".rodata"
	.align 2
.LC11:
	.long 0x0
	.align 2
.LC12:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl getPredatorSafetyTime
	.type	 getPredatorSafetyTime,@function
getPredatorSafetyTime:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,predator_safety_time@ha
	lwz 9,predator_safety_time@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L31
	lfs 13,20(9)
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L32
	lis 9,.LC12@ha
	la 9,.LC12@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L31
.L32:
	lis 9,gi+148@ha
	lis 3,.LC2@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC3@ha
	la 3,.LC2@l(3)
	la 4,.LC3@l(4)
	mtlr 0
	blrl
.L31:
	lis 11,predator_safety_time@ha
	lwz 9,predator_safety_time@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 getPredatorSafetyTime,.Lfe6-getPredatorSafetyTime
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
