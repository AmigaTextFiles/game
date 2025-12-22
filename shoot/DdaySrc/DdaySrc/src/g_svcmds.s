	.file	"g_svcmds.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"Svcmd_Test_f()\n"
	.align 2
.LC1:
	.string	"%s (%i) ---\n"
	.align 2
.LC2:
	.string	"  Score: %i/%i\n"
	.align 2
.LC3:
	.string	"  Kills: %i/%i\n"
	.align 2
.LC4:
	.string	"%s (%i) -----\n"
	.section	".text"
	.align 2
	.globl Svcmd_Mapinfo_f
	.type	 Svcmd_Mapinfo_f,@function
Svcmd_Mapinfo_f:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 29,gi@ha
	lis 28,team_list@ha
	la 29,gi@l(29)
	lwz 9,team_list@l(28)
	lis 3,.LC1@ha
	lwz 11,4(29)
	la 3,.LC1@l(3)
	lis 26,.LC2@ha
	lwz 5,80(9)
	lis 25,.LC3@ha
	la 27,team_list@l(28)
	lwz 4,0(9)
	mtlr 11
	crxor 6,6,6
	blrl
	lwz 9,team_list@l(28)
	la 3,.LC2@l(26)
	lwz 11,4(29)
	lwz 5,236(9)
	lwz 4,88(9)
	mtlr 11
	crxor 6,6,6
	blrl
	lwz 9,team_list@l(28)
	la 3,.LC3@l(25)
	lwz 11,4(29)
	lwz 5,232(9)
	lwz 4,76(9)
	mtlr 11
	crxor 6,6,6
	blrl
	lwz 9,4(27)
	lis 3,.LC4@ha
	lwz 11,4(29)
	la 3,.LC4@l(3)
	lwz 5,80(9)
	lwz 4,0(9)
	mtlr 11
	crxor 6,6,6
	blrl
	lwz 9,4(27)
	la 3,.LC2@l(26)
	lwz 11,4(29)
	lwz 5,236(9)
	lwz 4,88(9)
	mtlr 11
	crxor 6,6,6
	blrl
	lwz 9,4(27)
	la 3,.LC3@l(25)
	lwz 0,4(29)
	lwz 5,232(9)
	lwz 4,76(9)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 Svcmd_Mapinfo_f,.Lfe1-Svcmd_Mapinfo_f
	.section	".rodata"
	.align 2
.LC5:
	.string	"test"
	.align 2
.LC6:
	.string	"maplist"
	.align 2
.LC7:
	.string	"mapinfo"
	.align 2
.LC8:
	.string	"Unknown server command \"%s\"\n"
	.comm	is_silenced,1,1
	.section	".text"
	.align 2
	.globl ServerCommand
	.type	 ServerCommand,@function
ServerCommand:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi@ha
	li 3,1
	la 30,gi@l(9)
	lwz 9,160(30)
	mtlr 9
	blrl
	mr 31,3
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L9
	lwz 0,8(30)
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L11
.L9:
	lis 4,.LC6@ha
	mr 3,31
	la 4,.LC6@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L12
	bl Svcmd_Maplist_f
	b .L11
.L12:
	lis 4,.LC7@ha
	mr 3,31
	la 4,.LC7@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L14
	bl Svcmd_Mapinfo_f
	b .L11
.L14:
	lwz 0,8(30)
	lis 5,.LC8@ha
	mr 6,31
	la 5,.LC8@l(5)
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L11:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe2:
	.size	 ServerCommand,.Lfe2-ServerCommand
	.comm	maplist,1060,4
	.comm	team_list,8,4
	.align 2
	.globl Svcmd_Test_f
	.type	 Svcmd_Test_f,@function
Svcmd_Test_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+8@ha
	lis 5,.LC0@ha
	lwz 0,gi+8@l(9)
	la 5,.LC0@l(5)
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe3:
	.size	 Svcmd_Test_f,.Lfe3-Svcmd_Test_f
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
