	.file	"g_nh.c"
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
	.string	"spectator"
	.align 2
.LC1:
	.string	"1"
	.align 2
.LC2:
	.string	"spectator 1\n"
	.align 2
.LC3:
	.string	"set gl_dynamic 1; set sw_drawflat 0\n"
	.comm	showscores,4,4
	.comm	nextdynamicset,4,4
	.comm	predatorModel,32,4
	.comm	predatorSkin,64,4
	.comm	marineSkin,64,4
	.align 3
.LC4:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC5:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC6:
	.long 0x3e000000
	.long 0x0
	.section	".text"
	.align 2
	.globl nhrand
	.type	 nhrand,@function
nhrand:
	stwu 1,-48(1)
	mflr 0
	stfd 30,32(1)
	stfd 31,40(1)
	stmw 28,16(1)
	stw 0,52(1)
	mr 28,3
	subf 4,28,4
	lis 29,0x4330
	xoris 4,4,0x8000
	lis 11,.LC4@ha
	stw 4,12(1)
	la 11,.LC4@l(11)
	li 3,0
	stw 29,8(1)
	lfd 31,8(1)
	lfd 30,0(11)
	lis 11,.LC5@ha
	la 11,.LC5@l(11)
	lfd 0,0(11)
	fsub 31,31,30
	fadd 31,31,0
	frsp 31,31
	bl time
	bl srand
	bl rand
	xoris 3,3,0x8000
	stw 3,12(1)
	lis 11,.LC6@ha
	stw 29,8(1)
	la 11,.LC6@l(11)
	mr 3,9
	lfd 0,8(1)
	lfd 11,0(11)
	fsub 0,0,30
	frsp 0,0
	fmuls 31,31,0
	fmr 13,31
	fmul 13,13,11
	frsp 13,13
	fmr 0,13
	fctiwz 12,0
	stfd 12,8(1)
	lwz 3,12(1)
	add 3,28,3
	lwz 0,52(1)
	mtlr 0
	lmw 28,16(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 nhrand,.Lfe1-nhrand
	.align 2
	.globl NH_PreConnect
	.type	 NH_PreConnect,@function
NH_PreConnect:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 28,1
	lwz 9,84(29)
	li 0,0
	lis 4,.LC0@ha
	stw 28,932(29)
	lis 5,.LC1@ha
	la 4,.LC0@l(4)
	stw 28,1812(9)
	la 5,.LC1@l(5)
	lwz 9,84(29)
	stw 0,3480(9)
	lwz 3,84(29)
	addi 3,3,188
	bl Info_SetValueForKey
	lis 4,.LC2@ha
	mr 3,29
	la 4,.LC2@l(4)
	bl stuffcmd
	stw 28,916(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 NH_PreConnect,.Lfe2-NH_PreConnect
	.align 2
	.globl NH_PostConnect
	.type	 NH_PostConnect,@function
NH_PostConnect:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 28,0
	lis 4,.LC3@ha
	stw 28,900(29)
	la 4,.LC3@l(4)
	bl stuffcmd
	lwz 4,84(29)
	mr 3,29
	stw 28,948(29)
	addi 4,4,188
	bl checkMarineSkin
	mr 3,29
	bl ClearFlashlight
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 NH_PostConnect,.Lfe3-NH_PostConnect
	.comm	maplist_lastmap,64,4
	.comm	maplist2_lastmap,64,4
	.comm	maplist3_lastmap,64,4
	.comm	last_beat,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
