	.file	"g_nh_light.c"
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
	.string	"u_%s"
	.align 2
.LC1:
	.string	"set %s $%s u\n"
	.align 2
.LC2:
	.string	"u_gl_dynamic"
	.comm	showscores,4,4
	.comm	nextdynamicset,4,4
	.comm	predatorModel,32,4
	.comm	predatorSkin,64,4
	.comm	marineSkin,64,4
	.section	".text"
	.align 2
	.globl toggleStuffLight
	.type	 toggleStuffLight,@function
toggleStuffLight:
	lis 9,stuff_light@ha
	lwz 3,stuff_light@l(9)
	subfic 0,3,0
	adde 3,0,3
	stw 3,stuff_light@l(9)
	blr
.Lfe1:
	.size	 toggleStuffLight,.Lfe1-toggleStuffLight
	.align 2
	.globl stuffLight
	.type	 stuffLight,@function
stuffLight:
	lis 9,stuff_light@ha
	lwz 3,stuff_light@l(9)
	blr
.Lfe2:
	.size	 stuffLight,.Lfe2-stuffLight
	.align 2
	.globl getUserVar
	.type	 getUserVar,@function
getUserVar:
	stwu 1,-192(1)
	mflr 0
	stmw 27,172(1)
	stw 0,196(1)
	mr 29,4
	addi 28,1,136
	mr 27,3
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	mr 5,29
	mr 3,28
	crxor 6,6,6
	bl sprintf
	lis 4,.LC1@ha
	mr 6,29
	la 4,.LC1@l(4)
	mr 5,28
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	mr 3,27
	addi 4,1,8
	bl stuffcmd
	lwz 0,196(1)
	mtlr 0
	lmw 27,172(1)
	la 1,192(1)
	blr
.Lfe3:
	.size	 getUserVar,.Lfe3-getUserVar
	.align 2
	.globl checkCheating
	.type	 checkCheating,@function
checkCheating:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 9,.LC2@ha
	mr 3,4
	la 4,.LC2@l(9)
	bl Info_ValueForKey
	mr. 3,3
	bc 12,2,.L10
	bl atoi
	cmpwi 0,3,0
	li 0,0
	bc 4,2,.L11
	li 0,1
.L11:
	stw 0,948(31)
.L10:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 checkCheating,.Lfe4-checkCheating
	.comm	maplist_lastmap,64,4
	.comm	maplist2_lastmap,64,4
	.comm	maplist3_lastmap,64,4
	.comm	last_beat,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
