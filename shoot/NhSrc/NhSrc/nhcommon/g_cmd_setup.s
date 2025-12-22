	.file	"g_cmd_setup.c"
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
	.string	"bind g flashlight\n"
	.align 2
.LC1:
	.string	"bind m menu\n"
	.align 2
.LC2:
	.string	"bind v gunscope\n"
	.align 2
.LC3:
	.string	"bind o overload\n"
	.align 2
.LC4:
	.string	"bind e anchor\n"
	.align 2
.LC5:
	.string	"bind r recall\n"
	.align 2
.LC6:
	.string	"bind f flare\n"
	.align 2
.LC7:
	.string	"bind q report\n"
	.align 2
.LC8:
	.string	"bind [ invprev\n"
	.align 2
.LC9:
	.string	"bind ] invnext\n"
	.align 2
.LC10:
	.string	"bind enter invuse\n"
	.align 2
.LC11:
	.string	"bind tab inven\n"
	.align 2
.LC12:
	.string	"\nCreating default bindings for game:\n\n"
	.align 2
.LC13:
	.string	"\nCreating default bindings for menu:\n\n"
	.align 2
.LC14:
	.string	"bind tab inven\n\n"
	.align 2
.LC15:
	.string	"Press your FLASHLIGHT key to join the game!!!\n\n"
	.section	".text"
	.align 2
	.globl Cmd_Setup_f
	.type	 Cmd_Setup_f,@function
Cmd_Setup_f:
	stwu 1,-80(1)
	mflr 0
	stmw 17,20(1)
	stw 0,84(1)
	mr 28,3
	lis 27,.LC0@ha
	la 4,.LC0@l(27)
	bl stuffcmd
	lis 26,.LC1@ha
	lis 25,.LC2@ha
	mr 3,28
	la 4,.LC1@l(26)
	bl stuffcmd
	lis 24,.LC3@ha
	lis 23,.LC4@ha
	mr 3,28
	la 4,.LC2@l(25)
	bl stuffcmd
	lis 22,.LC5@ha
	lis 21,.LC6@ha
	mr 3,28
	la 4,.LC3@l(24)
	bl stuffcmd
	lis 20,.LC7@ha
	lis 19,.LC8@ha
	mr 3,28
	la 4,.LC4@l(23)
	bl stuffcmd
	lis 18,.LC9@ha
	lis 17,.LC10@ha
	mr 3,28
	la 4,.LC5@l(22)
	bl stuffcmd
	mr 3,28
	la 4,.LC6@l(21)
	bl stuffcmd
	mr 3,28
	la 4,.LC7@l(20)
	bl stuffcmd
	mr 3,28
	la 4,.LC8@l(19)
	bl stuffcmd
	mr 3,28
	la 4,.LC9@l(18)
	bl stuffcmd
	la 4,.LC10@l(17)
	mr 3,28
	bl stuffcmd
	lis 4,.LC11@ha
	mr 3,28
	la 4,.LC11@l(4)
	bl stuffcmd
	lis 29,gi@ha
	lis 5,.LC12@ha
	la 29,gi@l(29)
	la 5,.LC12@l(5)
	lwz 9,8(29)
	mr 3,28
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	la 5,.LC0@l(27)
	mr 3,28
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	la 5,.LC1@l(26)
	mr 3,28
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	la 5,.LC2@l(25)
	mr 3,28
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	la 5,.LC3@l(24)
	mr 3,28
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	la 5,.LC4@l(23)
	mr 3,28
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	la 5,.LC5@l(22)
	mr 3,28
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	la 5,.LC6@l(21)
	mr 3,28
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	la 5,.LC7@l(20)
	mr 3,28
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC13@ha
	mr 3,28
	la 5,.LC13@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	la 5,.LC8@l(19)
	mr 3,28
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	la 5,.LC9@l(18)
	mr 3,28
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	la 5,.LC10@l(17)
	mr 3,28
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC14@ha
	mr 3,28
	la 5,.LC14@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	lis 5,.LC15@ha
	mr 3,28
	la 5,.LC15@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,84(1)
	mtlr 0
	lmw 17,20(1)
	la 1,80(1)
	blr
.Lfe1:
	.size	 Cmd_Setup_f,.Lfe1-Cmd_Setup_f
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
