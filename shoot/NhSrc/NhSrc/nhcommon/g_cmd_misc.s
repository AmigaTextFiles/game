	.file	"g_cmd_misc.c"
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
	.string	"Credits:\n=======\nCreator/sound/coder/manager:\nmajoon\n\nPlaytesters:\nGunar, StompfesT\n\nMaps:\nMr. Hankey\n"
	.align 2
.LC1:
	.string	"q2dm1"
	.align 2
.LC2:
	.string	"q2dm2"
	.align 2
.LC3:
	.string	"q2dm3"
	.align 2
.LC4:
	.string	"q2dm4"
	.align 2
.LC5:
	.string	"q2dm5"
	.align 2
.LC6:
	.string	"q2dm6"
	.align 2
.LC7:
	.string	"q2dm7"
	.align 2
.LC8:
	.string	"q2dm8"
	.align 2
.LC9:
	.string	"Error, bad map name.\n"
	.align 2
.LC10:
	.string	"abcdefghijklmlkjihgfedcb"
	.align 2
.LC11:
	.string	"Changing maps...\n"
	.align 2
.LC12:
	.string	"target_changelevel"
	.section	".text"
	.align 2
	.globl Cmd_Gotomap_f
	.type	 Cmd_Gotomap_f,@function
Cmd_Gotomap_f:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 30,3
	la 28,gi@l(9)
	lis 31,.LC1@ha
	lwz 9,164(28)
	mtlr 9
	blrl
	mr 29,3
	la 4,.LC1@l(31)
	bl Q_stricmp
	cmpwi 0,3,0
	la 31,.LC1@l(31)
	bc 12,2,.L9
	lis 31,.LC2@ha
	mr 3,29
	la 4,.LC2@l(31)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L10
	la 31,.LC2@l(31)
	b .L9
.L10:
	lis 31,.LC3@ha
	mr 3,29
	la 4,.LC3@l(31)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L12
	la 31,.LC3@l(31)
	b .L9
.L12:
	lis 31,.LC4@ha
	mr 3,29
	la 4,.LC4@l(31)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L14
	la 31,.LC4@l(31)
	b .L9
.L14:
	lis 31,.LC5@ha
	mr 3,29
	la 4,.LC5@l(31)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L16
	la 31,.LC5@l(31)
	b .L9
.L16:
	lis 31,.LC6@ha
	mr 3,29
	la 4,.LC6@l(31)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L18
	la 31,.LC6@l(31)
	b .L9
.L18:
	lis 31,.LC7@ha
	mr 3,29
	la 4,.LC7@l(31)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L20
	la 31,.LC7@l(31)
	b .L9
.L20:
	lis 31,.LC8@ha
	mr 3,29
	la 4,.LC8@l(31)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L22
	lwz 0,8(28)
	lis 5,.LC9@ha
	mr 3,30
	la 5,.LC9@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L7
.L22:
	la 31,.LC8@l(31)
.L9:
	lis 29,gi@ha
	lis 4,.LC10@ha
	la 9,gi@l(29)
	la 4,.LC10@l(4)
	lwz 0,24(9)
	li 3,800
	mtlr 0
	blrl
	lwz 0,gi@l(29)
	lis 4,.LC11@ha
	li 3,2
	la 4,.LC11@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	bl G_Spawn
	lis 9,.LC12@ha
	mr 30,3
	la 9,.LC12@l(9)
	stw 31,504(30)
	stw 9,280(30)
	bl BeginIntermission
.L7:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Cmd_Gotomap_f,.Lfe1-Cmd_Gotomap_f
	.comm	showscores,4,4
	.comm	nextdynamicset,4,4
	.comm	predatorModel,32,4
	.comm	predatorSkin,64,4
	.comm	marineSkin,64,4
	.comm	maplist_lastmap,64,4
	.comm	maplist2_lastmap,64,4
	.comm	maplist3_lastmap,64,4
	.comm	last_beat,4,4
	.align 2
	.globl Cmd_Credits_f
	.type	 Cmd_Credits_f,@function
Cmd_Credits_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+12@ha
	lis 4,.LC0@ha
	lwz 0,gi+12@l(9)
	la 4,.LC0@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe2:
	.size	 Cmd_Credits_f,.Lfe2-Cmd_Credits_f
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
