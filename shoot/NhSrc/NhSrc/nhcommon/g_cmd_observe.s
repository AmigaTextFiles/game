	.file	"g_cmd_observe.c"
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
	.string	"spectator 1\n"
	.align 2
.LC1:
	.string	"spectator 0\n"
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
	.globl Start_Observe_f
	.type	 Start_Observe_f,@function
Start_Observe_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L13
	lwz 9,84(31)
	lwz 29,3464(9)
	addi 29,29,-1
	bl getMinScore
	cmpw 0,29,3
	bc 12,0,.L14
	lwz 11,84(31)
	lwz 9,3464(11)
	addi 9,9,-1
	stw 9,3464(11)
.L14:
	mr 3,31
	bl quitPredator
	b .L18
.L13:
	lwz 0,480(31)
	cmpwi 0,0,100
	bc 12,2,.L18
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L18
	lwz 9,84(31)
	lwz 29,3464(9)
	addi 29,29,-1
	bl getMinScore
	cmpw 0,29,3
	bc 12,0,.L18
	lwz 11,84(31)
	lwz 9,3464(11)
	addi 9,9,-1
	stw 9,3464(11)
.L18:
	lis 4,.LC0@ha
	mr 3,31
	la 4,.LC0@l(4)
	bl stuffcmd
	li 0,1
	stw 0,928(31)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Start_Observe_f,.Lfe1-Start_Observe_f
	.align 2
	.globl Cmd_Observe_f
	.type	 Cmd_Observe_f,@function
Cmd_Observe_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L20
	lwz 9,84(31)
	lwz 29,3464(9)
	addi 29,29,-1
	bl getMinScore
	cmpw 0,29,3
	bc 12,0,.L21
	lwz 11,84(31)
	lwz 9,3464(11)
	addi 9,9,-1
	stw 9,3464(11)
.L21:
	mr 3,31
	bl quitPredator
	b .L25
.L20:
	lwz 0,480(31)
	cmpwi 0,0,100
	bc 12,2,.L25
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L25
	lwz 9,84(31)
	lwz 29,3464(9)
	addi 29,29,-1
	bl getMinScore
	cmpw 0,29,3
	bc 12,0,.L25
	lwz 11,84(31)
	lwz 9,3464(11)
	addi 9,9,-1
	stw 9,3464(11)
.L25:
	lis 4,.LC0@ha
	mr 3,31
	la 4,.LC0@l(4)
	bl stuffcmd
	li 0,1
	stw 0,928(31)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Cmd_Observe_f,.Lfe2-Cmd_Observe_f
	.align 2
	.globl Start_Play_f
	.type	 Start_Play_f,@function
Start_Play_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lwz 4,84(29)
	addi 4,4,188
	bl checkMarineSkin
	lis 4,.LC1@ha
	mr 3,29
	la 4,.LC1@l(4)
	bl stuffcmd
	li 9,1
	li 0,0
	stw 0,924(29)
	stw 9,928(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 Start_Play_f,.Lfe3-Start_Play_f
	.align 2
	.globl Cmd_Play_f
	.type	 Cmd_Play_f,@function
Cmd_Play_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lwz 4,84(29)
	addi 4,4,188
	bl checkMarineSkin
	lis 4,.LC1@ha
	mr 3,29
	la 4,.LC1@l(4)
	bl stuffcmd
	li 9,1
	li 0,0
	stw 0,924(29)
	stw 9,928(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 Cmd_Play_f,.Lfe4-Cmd_Play_f
	.align 2
	.globl applyObservePenalties
	.type	 applyObservePenalties,@function
applyObservePenalties:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L7
	lwz 9,84(31)
	lwz 29,3464(9)
	addi 29,29,-1
	bl getMinScore
	cmpw 0,29,3
	bc 12,0,.L8
	lwz 11,84(31)
	lwz 9,3464(11)
	addi 9,9,-1
	stw 9,3464(11)
.L8:
	mr 3,31
	bl quitPredator
	b .L9
.L7:
	lwz 0,480(31)
	cmpwi 0,0,100
	bc 12,2,.L9
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L9
	lwz 9,84(31)
	lwz 29,3464(9)
	addi 29,29,-1
	bl getMinScore
	cmpw 0,29,3
	bc 12,0,.L9
	lwz 11,84(31)
	lwz 9,3464(11)
	addi 9,9,-1
	stw 9,3464(11)
.L9:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 applyObservePenalties,.Lfe5-applyObservePenalties
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
