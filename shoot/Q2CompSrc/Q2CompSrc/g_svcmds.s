	.file	"g_svcmds.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"Svcmd_Test_f()\n"
	.align 2
.LC1:
	.string	"test"
	.align 2
.LC2:
	.string	"lockdown"
	.align 2
.LC3:
	.string	"matchfragset"
	.align 2
.LC4:
	.string	"matchtimeset"
	.align 2
.LC5:
	.string	"modstatus"
	.align 2
.LC6:
	.string	"playerlist"
	.align 2
.LC7:
	.string	"powerups"
	.align 2
.LC8:
	.string	"restart"
	.align 2
.LC9:
	.string	"timerset"
	.align 2
.LC10:
	.string	"Unknown server command \"%s\"\n"
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
	lis 4,.LC1@ha
	la 4,.LC1@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L8
	lwz 0,8(30)
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L10
.L8:
	lis 4,.LC2@ha
	mr 3,31
	la 4,.LC2@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L11
	li 3,0
	bl Cmd_Lockdown_f
	b .L10
.L11:
	lis 4,.LC3@ha
	mr 3,31
	la 4,.LC3@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L13
	li 3,0
	bl Cmd_MatchFragSet_f
	b .L10
.L13:
	lis 4,.LC4@ha
	mr 3,31
	la 4,.LC4@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L15
	li 3,0
	bl Cmd_MatchTimeSet_f
	b .L10
.L15:
	lis 4,.LC5@ha
	mr 3,31
	la 4,.LC5@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L17
	li 3,0
	bl Cmd_DisplayModMode_f
	b .L10
.L17:
	lis 4,.LC6@ha
	mr 3,31
	la 4,.LC6@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L19
	li 3,0
	bl Cmd_PlayerList_f
	b .L10
.L19:
	lis 4,.LC7@ha
	mr 3,31
	la 4,.LC7@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L21
	li 3,0
	bl Cmd_Powerups_f
	b .L10
.L21:
	lis 4,.LC8@ha
	mr 3,31
	la 4,.LC8@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L23
	li 3,0
	bl Cmd_Restart_f
	b .L10
.L23:
	lis 4,.LC9@ha
	mr 3,31
	la 4,.LC9@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L25
	li 3,0
	bl Cmd_TimerSet_f
	b .L10
.L25:
	lwz 0,8(30)
	lis 5,.LC10@ha
	mr 6,31
	la 5,.LC10@l(5)
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L10:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe1:
	.size	 ServerCommand,.Lfe1-ServerCommand
	.comm	compmod,284,4
	.comm	team,221,1
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
.Lfe2:
	.size	 Svcmd_Test_f,.Lfe2-Svcmd_Test_f
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
