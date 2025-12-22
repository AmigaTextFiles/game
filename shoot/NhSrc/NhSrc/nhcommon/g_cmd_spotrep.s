	.file	"g_cmd_spotrep.c"
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
	.string	"** predator seen from %l **"
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
	.globl Cmd_SpotRep_f
	.type	 Cmd_SpotRep_f,@function
Cmd_SpotRep_f:
	stwu 1,-144(1)
	mflr 0
	stmw 29,132(1)
	stw 0,148(1)
	mr 29,3
	lwz 0,896(29)
	cmpwi 0,0,0
	bc 4,2,.L6
	lwz 0,932(29)
	cmpwi 0,0,0
	bc 4,2,.L6
	lwz 0,492(29)
	cmpwi 0,0,0
	bc 4,2,.L6
	bl clearSafetyMode
	lis 9,.LC0@ha
	mr 3,29
	lwz 5,.LC0@l(9)
	addi 11,1,8
	la 9,.LC0@l(9)
	mr 4,11
	lwz 29,24(9)
	lwz 0,4(9)
	lwz 10,8(9)
	lwz 8,12(9)
	lwz 7,16(9)
	lwz 6,20(9)
	stw 5,8(1)
	stw 0,4(11)
	stw 10,8(11)
	stw 8,12(11)
	stw 7,16(11)
	stw 6,20(11)
	stw 29,24(11)
	crxor 6,6,6
	bl CTFSay_Team
.L6:
	lwz 0,148(1)
	mtlr 0
	lmw 29,132(1)
	la 1,144(1)
	blr
.Lfe1:
	.size	 Cmd_SpotRep_f,.Lfe1-Cmd_SpotRep_f
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
