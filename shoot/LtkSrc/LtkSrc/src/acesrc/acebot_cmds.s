	.file	"acebot_cmds.c"
gcc2_compiled.:
	.globl debug_mode
	.section	".sdata","aw"
	.align 2
	.type	 debug_mode,@object
	.size	 debug_mode,4
debug_mode:
	.long 0
	.section	".rodata"
	.align 2
.LC0:
	.string	"addnode"
	.align 2
.LC1:
	.string	"removelink"
	.align 2
.LC2:
	.string	"addlink"
	.align 2
.LC3:
	.string	"showpath"
	.align 2
.LC4:
	.string	"shownode"
	.align 2
.LC5:
	.string	"findnode"
	.align 2
.LC6:
	.string	"node: %d type: %d x: %f y: %f z %f\n"
	.align 2
.LC7:
	.string	"movenode"
	.align 2
.LC8:
	.string	"node: %d moved to x: %f y: %f z %f\n"
	.align 2
.LC9:
	.string	"ltkversion"
	.align 2
.LC10:
	.string	"Current version is %s\n"
	.align 2
.LC11:
	.string	"LTK 1.10 (Fog) Release"
	.section	".text"
	.align 2
	.globl ACECM_Commands
	.type	 ACECM_Commands,@function
ACECM_Commands:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 31,3
	la 28,gi@l(9)
	li 3,0
	lwz 9,160(28)
	mtlr 9
	blrl
	mr 29,3
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L7
	lis 9,debug_mode@ha
	lwz 0,debug_mode@l(9)
	cmpwi 0,0,0
	bc 12,2,.L7
	lwz 0,160(28)
	li 3,1
	mtlr 0
	blrl
	bl atoi
	mr 4,3
	mr 3,31
	bl ACEND_AddNode
	stw 3,976(31)
	b .L8
.L7:
	lis 4,.LC1@ha
	mr 3,29
	la 4,.LC1@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L9
	lis 9,debug_mode@ha
	lwz 0,debug_mode@l(9)
	cmpwi 0,0,0
	bc 12,2,.L9
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	bl atoi
	lwz 0,160(29)
	mr 28,3
	li 3,2
	mtlr 0
	blrl
	bl atoi
	mr 5,3
	mr 4,28
	mr 3,31
	bl ACEND_RemoveNodeEdge
	b .L8
.L9:
	lis 4,.LC2@ha
	mr 3,29
	la 4,.LC2@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L11
	lis 9,debug_mode@ha
	lwz 0,debug_mode@l(9)
	cmpwi 0,0,0
	bc 12,2,.L11
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	bl atoi
	lwz 0,160(29)
	mr 28,3
	li 3,2
	mtlr 0
	blrl
	bl atoi
	mr 5,3
	mr 4,28
	mr 3,31
	bl ACEND_UpdateNodeEdge
	b .L8
.L11:
	lis 4,.LC3@ha
	mr 3,29
	la 4,.LC3@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L13
	lis 9,debug_mode@ha
	lwz 0,debug_mode@l(9)
	cmpwi 0,0,0
	bc 12,2,.L13
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	bl atoi
	mr 4,3
	mr 3,31
	bl ACEND_ShowPath
	b .L8
.L13:
	lis 4,.LC4@ha
	mr 3,29
	la 4,.LC4@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L15
	lis 9,debug_mode@ha
	lwz 0,debug_mode@l(9)
	cmpwi 0,0,0
	bc 12,2,.L15
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	bl atoi
	bl ACEND_ShowNode
	b .L8
.L15:
	lis 4,.LC5@ha
	mr 3,29
	la 4,.LC5@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L17
	lis 9,debug_mode@ha
	lwz 0,debug_mode@l(9)
	cmpwi 0,0,0
	bc 12,2,.L17
	li 4,96
	mr 3,31
	li 5,99
	bl ACEND_FindClosestReachableNode
	mr 31,3
	lis 11,nodes@ha
	la 11,nodes@l(11)
	mulli 0,31,116
	lis 4,.LC6@ha
	addi 10,11,8
	addi 9,11,4
	lfsx 2,9,0
	addi 8,11,12
	la 4,.LC6@l(4)
	lfsx 3,10,0
	mr 5,31
	li 3,1
	lfsx 1,11,0
	lwzx 6,8,0
	creqv 6,6,6
	bl safe_bprintf
	b .L8
.L17:
	lis 4,.LC7@ha
	mr 3,29
	la 4,.LC7@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L19
	lis 9,debug_mode@ha
	lwz 0,debug_mode@l(9)
	cmpwi 0,0,0
	bc 12,2,.L19
	lis 28,gi@ha
	li 3,1
	la 28,gi@l(28)
	lwz 9,160(28)
	mtlr 9
	blrl
	bl atoi
	lwz 9,160(28)
	mr 31,3
	li 3,2
	mulli 27,31,116
	mtlr 9
	blrl
	bl atof
	lwz 9,160(28)
	frsp 1,1
	li 3,3
	lis 29,nodes@ha
	la 29,nodes@l(29)
	mtlr 9
	addi 26,29,4
	stfsx 1,29,27
	blrl
	bl atof
	lwz 0,160(28)
	frsp 1,1
	li 3,4
	mtlr 0
	stfsx 1,26,27
	blrl
	bl atof
	frsp 3,1
	lfsx 2,26,27
	addi 9,29,8
	lis 4,.LC8@ha
	lfsx 1,29,27
	la 4,.LC8@l(4)
	mr 5,31
	li 3,1
	stfsx 3,9,27
	creqv 6,6,6
	bl safe_bprintf
	b .L8
.L19:
	lis 4,.LC9@ha
	mr 3,29
	la 4,.LC9@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	li 3,0
	bc 4,2,.L23
	lis 4,.LC10@ha
	lis 5,.LC11@ha
	la 4,.LC10@l(4)
	la 5,.LC11@l(5)
	li 3,2
	crxor 6,6,6
	bl safe_bprintf
.L8:
	li 3,1
.L23:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 ACECM_Commands,.Lfe1-ACECM_Commands
	.section	".rodata"
	.align 2
.LC12:
	.long 0x0
	.align 3
.LC13:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl debug_printf
	.type	 debug_printf,@function
debug_printf:
	mr 12,1
	lis 0,0xfffe
	ori 0,0,65344
	stwux 1,1,0
	mflr 0
	stfd 31,-8(12)
	stmw 26,-32(12)
	stw 0,4(12)
	lis 11,0x1
	lis 0,0x1
	ori 11,11,200
	ori 0,0,112
	add 29,1,11
	add 12,1,0
	lis 31,0x100
	addi 11,1,8
	stw 29,20(12)
	stw 11,24(12)
	stw 31,16(12)
	stw 4,12(1)
	stw 5,16(1)
	stw 6,20(1)
	stw 7,24(1)
	stw 8,28(1)
	stw 9,32(1)
	stw 10,36(1)
	bc 4,6,.L26
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L26:
	addi 9,12,16
	mr 4,3
	lwz 11,8(9)
	mr 5,12
	addi 3,1,112
	lwz 0,4(9)
	lis 9,.LC12@ha
	stw 11,8(12)
	la 9,.LC12@l(9)
	stw 31,0(12)
	lfs 31,0(9)
	stw 0,4(12)
	bl vsprintf
	lis 9,dedicated@ha
	lwz 11,dedicated@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L27
	lis 9,gi+8@ha
	li 3,0
	lwz 0,gi+8@l(9)
	li 4,1
	addi 5,1,112
	mtlr 0
	crxor 6,6,6
	blrl
.L27:
	lis 9,maxclients@ha
	li 31,0
	lwz 11,maxclients@l(9)
	lis 26,maxclients@ha
	lfs 0,20(11)
	fcmpu 0,31,0
	bc 4,0,.L29
	lis 9,gi@ha
	lis 27,g_edicts@ha
	la 28,gi@l(9)
	lis 30,0x4330
	lis 9,.LC13@ha
	li 29,996
	la 9,.LC13@l(9)
	lfd 31,0(9)
.L31:
	lwz 0,g_edicts@l(27)
	add 3,0,29
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L30
	lwz 0,904(3)
	cmpwi 0,0,0
	bc 4,2,.L30
	lwz 9,8(28)
	li 4,1
	addi 5,1,112
	mtlr 9
	crxor 6,6,6
	blrl
.L30:
	addi 31,31,1
	addis 9,1,1
	lwz 11,maxclients@l(26)
	xoris 0,31,0x8000
	addi 29,29,996
	stw 0,156(9)
	stw 30,152(9)
	lfd 0,152(9)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L31
.L29:
	lwz 11,0(1)
	lwz 0,4(11)
	mtlr 0
	lmw 26,-32(11)
	lfd 31,-8(11)
	mr 1,11
	blr
.Lfe2:
	.size	 debug_printf,.Lfe2-debug_printf
	.align 2
	.globl safe_cprintf
	.type	 safe_cprintf,@function
safe_cprintf:
	mr 12,1
	lis 0,0xfffe
	ori 0,0,65376
	stwux 1,1,0
	mflr 0
	stmw 28,-16(12)
	stw 0,4(12)
	lis 0,0x1
	lis 31,0x1
	ori 31,31,168
	ori 0,0,112
	add 12,1,0
	add 11,1,31
	lis 28,0x300
	addi 29,1,8
	stw 11,20(12)
	stw 29,24(12)
	mr 31,3
	mr 30,4
	stw 28,16(12)
	stw 6,20(1)
	stw 7,24(1)
	stw 8,28(1)
	stw 9,32(1)
	stw 10,36(1)
	bc 4,6,.L36
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L36:
	cmpwi 0,31,0
	mr 4,5
	bc 12,2,.L37
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L35
	lwz 0,904(31)
	cmpwi 0,0,0
	bc 4,2,.L35
.L37:
	addi 9,12,16
	mr 5,12
	lwz 0,4(9)
	addi 3,1,112
	lwz 11,8(9)
	stw 0,4(12)
	stw 28,0(12)
	stw 11,8(12)
	bl vsprintf
	lis 9,gi+8@ha
	mr 3,31
	lwz 0,gi+8@l(9)
	mr 4,30
	addi 5,1,112
	mtlr 0
	crxor 6,6,6
	blrl
.L35:
	lwz 11,0(1)
	lwz 0,4(11)
	mtlr 0
	lmw 28,-16(11)
	mr 1,11
	blr
.Lfe3:
	.size	 safe_cprintf,.Lfe3-safe_cprintf
	.align 2
	.globl safe_centerprintf
	.type	 safe_centerprintf,@function
safe_centerprintf:
	mr 12,1
	lis 0,0xfffe
	ori 0,0,65376
	stwux 1,1,0
	mflr 0
	stmw 29,-12(12)
	stw 0,4(12)
	lis 0,0x1
	lis 31,0x1
	ori 31,31,168
	ori 0,0,112
	add 12,1,0
	add 11,1,31
	lis 30,0x200
	addi 29,1,8
	stw 11,20(12)
	stw 29,24(12)
	mr 31,3
	stw 30,16(12)
	stw 5,16(1)
	stw 6,20(1)
	stw 7,24(1)
	stw 8,28(1)
	stw 9,32(1)
	stw 10,36(1)
	bc 4,6,.L40
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L40:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L39
	lwz 0,904(31)
	cmpwi 0,0,0
	bc 4,2,.L39
	addi 9,12,16
	mr 5,12
	lwz 0,4(9)
	addi 3,1,112
	lwz 11,8(9)
	stw 0,4(12)
	stw 30,0(12)
	stw 11,8(12)
	bl vsprintf
	lis 9,gi+12@ha
	mr 3,31
	lwz 0,gi+12@l(9)
	addi 4,1,112
	mtlr 0
	crxor 6,6,6
	blrl
.L39:
	lwz 11,0(1)
	lwz 0,4(11)
	mtlr 0
	lmw 29,-12(11)
	mr 1,11
	blr
.Lfe4:
	.size	 safe_centerprintf,.Lfe4-safe_centerprintf
	.section	".rodata"
	.align 2
.LC14:
	.long 0x0
	.align 3
.LC15:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl safe_bprintf
	.type	 safe_bprintf,@function
safe_bprintf:
	mr 12,1
	lis 0,0xfffe
	ori 0,0,65328
	stwux 1,1,0
	mflr 0
	stfd 31,-8(12)
	stmw 25,-36(12)
	stw 0,4(12)
	lis 0,0x1
	lis 30,0x1
	ori 30,30,216
	ori 0,0,112
	add 12,1,0
	add 11,1,30
	lis 31,0x200
	addi 29,1,8
	stw 11,20(12)
	stw 29,24(12)
	mr 30,3
	stw 31,16(12)
	stw 5,16(1)
	stw 6,20(1)
	stw 7,24(1)
	stw 8,28(1)
	stw 9,32(1)
	stw 10,36(1)
	bc 4,6,.L44
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L44:
	addi 9,12,16
	mr 5,12
	lwz 11,8(9)
	addi 3,1,112
	lwz 0,4(9)
	lis 9,.LC14@ha
	stw 11,8(12)
	la 9,.LC14@l(9)
	stw 31,0(12)
	lfs 31,0(9)
	stw 0,4(12)
	bl vsprintf
	lis 9,dedicated@ha
	lwz 11,dedicated@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L45
	lis 9,gi+8@ha
	li 3,0
	lwz 0,gi+8@l(9)
	mr 4,30
	addi 5,1,112
	mtlr 0
	crxor 6,6,6
	blrl
.L45:
	lis 9,maxclients@ha
	li 31,0
	lwz 11,maxclients@l(9)
	lis 25,maxclients@ha
	lfs 0,20(11)
	fcmpu 0,31,0
	bc 4,0,.L47
	lis 9,gi@ha
	lis 26,g_edicts@ha
	la 27,gi@l(9)
	lis 28,0x4330
	lis 9,.LC15@ha
	li 29,996
	la 9,.LC15@l(9)
	lfd 31,0(9)
.L49:
	lwz 0,g_edicts@l(26)
	add 3,0,29
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L48
	lwz 0,904(3)
	cmpwi 0,0,0
	bc 4,2,.L48
	lwz 9,8(27)
	mr 4,30
	addi 5,1,112
	mtlr 9
	crxor 6,6,6
	blrl
.L48:
	addi 31,31,1
	addis 9,1,1
	lwz 11,maxclients@l(25)
	xoris 0,31,0x8000
	addi 29,29,996
	stw 0,164(9)
	stw 28,160(9)
	lfd 0,160(9)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L49
.L47:
	lwz 11,0(1)
	lwz 0,4(11)
	mtlr 0
	lmw 25,-36(11)
	lfd 31,-8(11)
	mr 1,11
	blr
.Lfe5:
	.size	 safe_bprintf,.Lfe5-safe_bprintf
	.align 2
	.globl ACECM_Store
	.type	 ACECM_Store,@function
ACECM_Store:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl ACEND_SaveNodes
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 ACECM_Store,.Lfe6-ACECM_Store
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
