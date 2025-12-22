	.file	"g_cmd_scopetoggle.c"
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
	.string	"2x Zoom\n"
	.align 2
.LC1:
	.string	"4x Zoom\n"
	.align 2
.LC2:
	.string	"8x Zoom\n"
	.align 2
.LC3:
	.string	"1x Zoom\n"
	.align 2
.LC4:
	.string	"Space marines cannot use the gun scope.\n"
	.align 2
.LC5:
	.long 0x42b40000
	.align 2
.LC6:
	.long 0x42700000
	.align 2
.LC7:
	.long 0x42200000
	.section	".text"
	.align 2
	.globl Cmd_ScopeToggle_f
	.type	 Cmd_ScopeToggle_f,@function
Cmd_ScopeToggle_f:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stw 31,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L7
	lwz 9,84(31)
	lis 11,.LC5@ha
	la 11,.LC5@l(11)
	lfs 31,0(11)
	lfs 13,112(9)
	fcmpu 0,13,31
	bc 4,2,.L8
	lis 9,gi+8@ha
	lis 5,.LC0@ha
	lwz 0,gi+8@l(9)
	la 5,.LC0@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	lis 0,0x4270
	stw 0,112(9)
	b .L14
.L8:
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L10
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	lis 0,0x4220
	stw 0,112(9)
	b .L14
.L10:
	lis 9,.LC7@ha
	la 9,.LC7@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L12
	lis 9,gi+8@ha
	lis 5,.LC2@ha
	lwz 0,gi+8@l(9)
	la 5,.LC2@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	lis 0,0x41a0
	stw 0,112(9)
	b .L14
.L12:
	lis 9,gi+8@ha
	lis 5,.LC3@ha
	lwz 0,gi+8@l(9)
	la 5,.LC3@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	stfs 31,112(9)
	b .L14
.L7:
	lis 9,gi+8@ha
	lis 5,.LC4@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC4@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L14:
	lwz 0,36(1)
	mtlr 0
	lwz 31,20(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Cmd_ScopeToggle_f,.Lfe1-Cmd_ScopeToggle_f
	.comm	showscores,4,4
	.comm	nextdynamicset,4,4
	.comm	predatorModel,32,4
	.comm	predatorSkin,64,4
	.comm	marineSkin,64,4
	.comm	maplist_lastmap,64,4
	.comm	maplist2_lastmap,64,4
	.comm	maplist3_lastmap,64,4
	.comm	last_beat,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
