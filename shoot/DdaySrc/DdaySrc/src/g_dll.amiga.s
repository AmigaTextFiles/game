	.file	"g_dll.amiga.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 GlobalUserDLLList,@object
	.size	 GlobalUserDLLList,4
GlobalUserDLLList:
	.long 0
	.section	".rodata"
	.align 2
.LC0:
	.string	"usa"
	.string	""
	.align 2
.LC1:
	.string	"memory allocation failed for library <%s>\n"
	.align 2
.LC2:
	.string	"dday/"
	.align 2
.LC3:
	.string	"ppc.dll"
	.align 2
.LC4:
	.string	"GetAPI"
	.align 2
.LC5:
	.string	"1"
	.align 2
.LC6:
	.string	"Couldn't load library %s, errorcode = %s\n"
	.align 2
.LC7:
	.string	"Could not get entry point %s for library %s\n"
	.section	".text"
	.align 2
	.globl LoadUserDLLs
	.type	 LoadUserDLLs,@function
LoadUserDLLs:
	stwu 1,-304(1)
	mflr 0
	mfcr 12
	stmw 25,276(1)
	stw 0,308(1)
	stw 12,272(1)
	mr 30,3
	mr 26,4
	lwz 0,316(30)
	li 25,0
	cmpwi 0,0,0
	bc 4,2,.L7
	lis 9,gi@ha
	li 3,5
	la 9,gi@l(9)
	li 4,766
	lwz 0,132(9)
	mtlr 0
	blrl
	cmpwi 0,3,0
	stw 3,316(30)
	bc 12,2,.L27
	lis 9,.LC0@ha
	li 25,1
	lwz 0,.LC0@l(9)
	stw 0,0(3)
.L7:
	lis 9,gi@ha
	lis 3,0x7
	la 28,gi@l(9)
	ori 3,3,49248
	lwz 9,132(28)
	li 4,0
	mtlr 9
	blrl
	mr. 31,3
	bc 4,2,.L9
	lwz 0,4(28)
	lis 3,.LC1@ha
	la 3,.LC1@l(3)
	lwz 4,316(30)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L27
.L9:
	addi 29,31,4
	lis 4,.LC2@ha
	li 5,6
	la 4,.LC2@l(4)
	mr 3,29
	mr 27,29
	bl strncpy
	lwz 4,316(30)
	mr 3,29
	bl strcat
	lis 4,.LC3@ha
	mr 3,29
	la 4,.LC3@l(4)
	bl strcat
	lwz 4,316(30)
	addi 3,1,8
	li 5,4
	bl strncpy
	cmpwi 0,25,0
	bc 12,2,.L10
	lwz 0,136(28)
	lwz 3,316(30)
	mtlr 0
	blrl
.L10:
	li 29,0
	addi 28,31,132
	cmpwi 4,26,0
	addi 30,31,388
	addi 26,31,420
	lis 25,team0_library@ha
	b .L11
.L14:
	addi 7,1,8
	lis 9,_ctype_@ha
	lbzx 11,7,29
	lwz 10,_ctype_@l(9)
	addi 8,11,-32
	add 10,11,10
	lbz 9,1(10)
	andi. 0,9,2
	mfcr 0
	rlwinm 0,0,3,1
	neg 0,0
	andc 8,8,0
	and 11,11,0
	or 11,11,8
	stbx 11,7,29
	addi 29,29,1
.L11:
	addi 3,1,8
	bl strlen
	cmplw 0,29,3
	bc 4,1,.L14
	lis 4,.LC4@ha
	addi 3,1,8
	la 4,.LC4@l(4)
	lis 29,.LC5@ha
	bl strcat
	addi 4,1,8
	li 5,256
	mr 3,28
	bl strncpy
	la 4,.LC5@l(29)
	li 5,3
	mr 3,30
	bl strncpy
	mr 3,26
	la 4,.LC5@l(29)
	li 5,3
	bl strncpy
	lis 9,GlobalUserDLLList@ha
	lwz 0,GlobalUserDLLList@l(9)
	stw 0,0(31)
	stw 31,GlobalUserDLLList@l(9)
	bc 4,18,.L26
	lis 9,team0_library@ha
	lwz 0,team0_library@l(9)
	cmpwi 0,0,0
	bc 4,2,.L20
	mr 3,27
	mr 4,27
	bl dllLoadLibrary
	stw 3,team0_library@l(25)
	b .L18
.L26:
	lis 30,team1_library@ha
	lwz 0,team1_library@l(30)
	cmpwi 0,0,0
	bc 4,2,.L18
	mr 3,27
	mr 4,27
	bl dllLoadLibrary
	stw 3,team1_library@l(30)
.L18:
	lis 9,team0_library@ha
	lwz 0,team0_library@l(9)
	cmpwi 0,0,0
	bc 4,2,.L20
	lis 9,team1_library@ha
	lwz 0,team1_library@l(9)
	cmpwi 0,0,0
	bc 4,2,.L20
	lis 9,gi+4@ha
	lis 3,.LC6@ha
	lwz 0,gi+4@l(9)
	la 3,.LC6@l(3)
	mr 4,27
	li 5,1
	b .L28
.L20:
	bc 4,18,.L22
	lis 9,team0_library@ha
	mr 4,28
	lwz 3,team0_library@l(9)
	b .L29
.L22:
	lis 9,team1_library@ha
	mr 4,28
	lwz 3,team1_library@l(9)
.L29:
	bl dllGetProcAddress
	stw 3,488(31)
	lwz 0,488(31)
	cmpwi 0,0,0
	bc 12,2,.L21
	lis 9,GlobalUserDLLList@ha
	lwz 3,GlobalUserDLLList@l(9)
	b .L25
.L21:
	lis 9,gi+4@ha
	lis 3,.LC7@ha
	lwz 0,gi+4@l(9)
	la 3,.LC7@l(3)
	mr 4,28
	mr 5,27
.L28:
	mtlr 0
	crxor 6,6,6
	blrl
.L27:
	li 3,0
.L25:
	lwz 0,308(1)
	lwz 12,272(1)
	mtlr 0
	lmw 25,276(1)
	mtcrf 8,12
	la 1,304(1)
	blr
.Lfe1:
	.size	 LoadUserDLLs,.Lfe1-LoadUserDLLs
	.section	".rodata"
	.align 2
.LC8:
	.string	"Library %s has invalid version %d\n"
	.align 2
.LC9:
	.string	"Could not initialize library %s\n"
	.section	".text"
	.align 2
	.globl InitializeUserDLLs
	.type	 InitializeUserDLLs,@function
InitializeUserDLLs:
	stwu 1,-272(1)
	mflr 0
	stmw 25,244(1)
	stw 0,276(1)
	mr. 31,3
	mr 26,4
	li 25,1
	bc 4,2,.L31
	li 3,0
	b .L36
.L31:
	lis 9,g_edicts@ha
	lis 11,game@ha
	stw 26,32(1)
	lwz 0,g_edicts@l(9)
	lis 10,level@ha
	lis 8,globals@ha
	lis 9,gi@ha
	lis 7,FindGameFunction@ha
	la 30,gi@l(9)
	lis 4,InsertItem@ha
	stw 0,24(1)
	lis 9,InsertCmds@ha
	lis 29,InsertEntity@ha
	stw 30,16(1)
	lis 6,RemoveEntity@ha
	lis 5,is_silenced@ha
	la 11,game@l(11)
	la 10,level@l(10)
	la 8,globals@l(8)
	la 7,FindGameFunction@l(7)
	stw 11,8(1)
	la 6,RemoveEntity@l(6)
	la 9,InsertCmds@l(9)
	stw 10,12(1)
	la 4,InsertItem@l(4)
	la 29,InsertEntity@l(29)
	stw 9,36(1)
	la 5,is_silenced@l(5)
	addi 28,1,184
	stw 4,44(1)
	addi 27,1,56
	stw 29,48(1)
	addi 3,31,388
	stw 5,28(1)
	stw 8,20(1)
	stw 7,40(1)
	stw 6,52(1)
	bl atoi
	mr 29,3
	addi 4,1,8
	li 5,48
	mr 3,28
	crxor 6,6,6
	bl memcpy
	lwz 9,488(31)
	mr 4,28
	mr 3,27
	mtlr 9
	blrl
	li 5,116
	mr 4,27
	addi 3,31,492
	crxor 6,6,6
	bl memcpy
	lwz 5,492(31)
	cmpw 0,5,29
	bc 12,2,.L32
	lwz 0,4(30)
	lis 3,.LC8@ha
	addi 4,31,4
	la 3,.LC8@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L33
.L32:
	lwz 0,532(31)
	cmpwi 0,0,0
	bc 4,2,.L34
	lwz 0,4(30)
	lis 3,.LC9@ha
	addi 4,31,4
	la 3,.LC9@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L33
.L34:
	mtlr 0
	slwi 28,26,2
	li 25,2
	blrl
	lis 29,team_list@ha
	lwz 4,556(31)
	la 29,team_list@l(29)
	lwzx 3,28,29
	bl InitMOS_List
	lwzx 3,28,29
	addi 4,31,576
	addi 3,3,164
	bl strcpy
	lwzx 3,28,29
	addi 4,31,560
	addi 3,3,100
	bl strcpy
.L33:
	bl SetItemNames
	mr 3,25
.L36:
	lwz 0,276(1)
	mtlr 0
	lmw 25,244(1)
	la 1,272(1)
	blr
.Lfe2:
	.size	 InitializeUserDLLs,.Lfe2-InitializeUserDLLs
	.section	".rodata"
	.align 2
.LC10:
	.string	"Clearing user DLLs\n"
	.comm	is_silenced,1,1
	.comm	maplist,1060,4
	.comm	team_list,8,4
	.comm	id_GameCmds,492,4
	.lcomm	UserDLLImports,48,4
	.section	".sbss","aw",@nobits
	.align 2
team0_library:
	.space	4
	.size	 team0_library,4
	.align 2
team1_library:
	.space	4
	.size	 team1_library,4
	.section	".text"
	.align 2
	.globl ClearUserDLLs
	.type	 ClearUserDLLs,@function
ClearUserDLLs:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,gi@ha
	lis 3,.LC10@ha
	la 30,gi@l(9)
	la 3,.LC10@l(3)
	lwz 9,4(30)
	mtlr 9
	crxor 6,6,6
	blrl
	lis 9,GlobalUserDLLList@ha
	lwz 31,GlobalUserDLLList@l(9)
	cmpwi 0,31,0
	bc 12,2,.L39
	mr 27,30
	lis 28,team0_library@ha
	li 29,0
.L40:
	lwz 3,team0_library@l(28)
	cmpwi 0,3,0
	bc 12,2,.L41
	bl dllFreeLibrary
	stw 29,team0_library@l(28)
.L41:
	lis 30,team1_library@ha
	lwz 3,team1_library@l(30)
	cmpwi 0,3,0
	bc 12,2,.L42
	bl dllFreeLibrary
	stw 29,team1_library@l(30)
.L42:
	lwz 9,136(27)
	mr 3,31
	lwz 31,0(31)
	mtlr 9
	blrl
	cmpwi 0,31,0
	bc 4,2,.L40
.L39:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 ClearUserDLLs,.Lfe3-ClearUserDLLs
	.align 2
	.globl LevelStartUserDLLs
	.type	 LevelStartUserDLLs,@function
LevelStartUserDLLs:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,GlobalUserDLLList@ha
	mr 30,3
	lwz 31,GlobalUserDLLList@l(9)
	cmpwi 0,31,0
	bc 12,2,.L46
.L47:
	lwz 0,484(31)
	cmpwi 0,0,0
	bc 12,2,.L48
	lwz 9,540(31)
	mr 3,30
	mtlr 9
	blrl
.L48:
	lwz 31,0(31)
	cmpwi 0,31,0
	bc 4,2,.L47
.L46:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 LevelStartUserDLLs,.Lfe4-LevelStartUserDLLs
	.align 2
	.globl LevelExitUserDLLs
	.type	 LevelExitUserDLLs,@function
LevelExitUserDLLs:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,GlobalUserDLLList@ha
	lwz 31,GlobalUserDLLList@l(9)
	cmpwi 0,31,0
	bc 12,2,.L52
.L53:
	lwz 9,544(31)
	mtlr 9
	blrl
	lwz 31,0(31)
	cmpwi 0,31,0
	bc 4,2,.L53
.L52:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 LevelExitUserDLLs,.Lfe5-LevelExitUserDLLs
	.align 2
	.globl PlayerSpawnUserDLLs
	.type	 PlayerSpawnUserDLLs,@function
PlayerSpawnUserDLLs:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,GlobalUserDLLList@ha
	mr 30,3
	lwz 31,GlobalUserDLLList@l(9)
	cmpwi 0,31,0
	bc 12,2,.L57
.L58:
	lwz 9,548(31)
	mr 3,30
	mtlr 9
	blrl
	lwz 31,0(31)
	cmpwi 0,31,0
	bc 4,2,.L58
.L57:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 PlayerSpawnUserDLLs,.Lfe6-PlayerSpawnUserDLLs
	.align 2
	.globl PlayerDiesUserDLLs
	.type	 PlayerDiesUserDLLs,@function
PlayerDiesUserDLLs:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 9,GlobalUserDLLList@ha
	mr 26,3
	lwz 31,GlobalUserDLLList@l(9)
	mr 27,4
	mr 28,5
	mr 29,6
	mr 30,7
	cmpwi 0,31,0
	bc 12,2,.L62
.L63:
	lwz 9,552(31)
	mr 3,26
	mr 4,27
	mr 5,28
	mr 6,29
	mr 7,30
	mtlr 9
	blrl
	lwz 31,0(31)
	cmpwi 0,31,0
	bc 4,2,.L63
.L62:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 PlayerDiesUserDLLs,.Lfe7-PlayerDiesUserDLLs
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
