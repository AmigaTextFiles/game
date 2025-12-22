	.file	"g_cmd_overload.c"
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
	.string	"world/fusein.wav"
	.align 2
.LC1:
	.string	"world/fuseout.wav"
	.align 2
.LC2:
	.string	"predator_overload_cost"
	.align 2
.LC3:
	.string	"2"
	.comm	showscores,4,4
	.comm	nextdynamicset,4,4
	.comm	predatorModel,32,4
	.comm	predatorSkin,64,4
	.comm	marineSkin,64,4
	.align 2
.LC4:
	.long 0x0
	.align 2
.LC5:
	.long 0x3f800000
	.align 2
.LC6:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl Cmd_Overload_f
	.type	 Cmd_Overload_f,@function
Cmd_Overload_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L6
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L6
	lwz 0,912(31)
	cmpwi 0,0,0
	bc 4,2,.L6
	lis 9,.LC4@ha
	lis 11,enable_predator_overload@ha
	la 9,.LC4@l(9)
	lfs 13,0(9)
	lwz 9,enable_predator_overload@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L6
	lwz 11,84(31)
	lwz 0,3864(11)
	subfic 9,0,0
	adde 0,9,0
	stw 0,3864(11)
	lwz 9,84(31)
	lwz 0,3864(9)
	cmpwi 0,0,0
	bc 12,2,.L10
	lis 29,gi@ha
	lis 3,.LC0@ha
	la 29,gi@l(29)
	la 3,.LC0@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC5@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC5@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 2,0(9)
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	lfs 3,0(9)
	blrl
	b .L6
.L10:
	lis 29,gi@ha
	lis 3,.LC1@ha
	la 29,gi@l(29)
	la 3,.LC1@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC5@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC5@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 2,0(9)
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	lfs 3,0(9)
	blrl
.L6:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Cmd_Overload_f,.Lfe1-Cmd_Overload_f
	.align 2
	.globl ClearOverload
	.type	 ClearOverload,@function
ClearOverload:
	lwz 11,84(3)
	li 0,0
	li 10,0
	sth 0,164(11)
	lwz 9,84(3)
	stw 10,3864(9)
	blr
.Lfe2:
	.size	 ClearOverload,.Lfe2-ClearOverload
	.section	".rodata"
	.align 2
.LC7:
	.long 0x0
	.align 2
.LC8:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl validatePredatorOverloadCost
	.type	 validatePredatorOverloadCost,@function
validatePredatorOverloadCost:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC7@ha
	lis 9,predator_overload_cost@ha
	la 11,.LC7@l(11)
	lfs 0,0(11)
	lwz 11,predator_overload_cost@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L15
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L14
.L15:
	lis 9,gi+148@ha
	lis 3,.LC2@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC3@ha
	la 3,.LC2@l(3)
	la 4,.LC3@l(4)
	mtlr 0
	blrl
.L14:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe3:
	.size	 validatePredatorOverloadCost,.Lfe3-validatePredatorOverloadCost
	.section	".rodata"
	.align 2
.LC9:
	.long 0x0
	.align 2
.LC10:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl getPredatorOverloadCost
	.type	 getPredatorOverloadCost,@function
getPredatorOverloadCost:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,predator_overload_cost@ha
	lwz 9,predator_overload_cost@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L17
	lfs 13,20(9)
	lis 9,.LC9@ha
	la 9,.LC9@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L18
	lis 9,.LC10@ha
	la 9,.LC10@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L17
.L18:
	lis 9,gi+148@ha
	lis 3,.LC2@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC3@ha
	la 3,.LC2@l(3)
	la 4,.LC3@l(4)
	mtlr 0
	blrl
.L17:
	lis 11,predator_overload_cost@ha
	lwz 9,predator_overload_cost@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe4:
	.size	 getPredatorOverloadCost,.Lfe4-getPredatorOverloadCost
	.comm	maplist_lastmap,64,4
	.comm	maplist2_lastmap,64,4
	.comm	maplist3_lastmap,64,4
	.comm	last_beat,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
