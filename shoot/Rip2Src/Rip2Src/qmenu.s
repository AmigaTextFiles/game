	.file	"qmenu.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"\n"
	.align 2
.LC1:
	.string	"This sever is running a mod that makes\n"
	.align 2
.LC2:
	.string	"use of the QMENU in game menuing system.\n"
	.align 2
.LC3:
	.string	"QMENU makes selecting options as simple\n"
	.align 2
.LC4:
	.string	"as using the inventory system built in\n"
	.align 2
.LC5:
	.string	"to quake it'self.\n"
	.align 2
.LC6:
	.string	"When in a QMENU, use the same keys\n"
	.align 2
.LC7:
	.string	"you would use to move through Quake 2's\n"
	.align 2
.LC8:
	.string	"inventory (ie: Next_Inventory and\n"
	.align 2
.LC9:
	.string	"Prev_Inventory).  When you wish to\n"
	.align 2
.LC10:
	.string	"select an option, press your use key!\n"
	.align 2
.LC11:
	.string	"Press ESC will abort any menu.\n"
	.section	".text"
	.align 2
	.globl Menu_Hlp
	.type	 Menu_Hlp,@function
Menu_Hlp:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 28,3
	la 29,gi@l(29)
	lis 27,.LC0@ha
	lwz 9,8(29)
	la 5,.LC0@l(27)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC1@ha
	mr 3,28
	la 5,.LC1@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC2@ha
	mr 3,28
	la 5,.LC2@l(5)
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
	lis 5,.LC3@ha
	mr 3,28
	la 5,.LC3@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC4@ha
	mr 3,28
	la 5,.LC4@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC5@ha
	mr 3,28
	la 5,.LC5@l(5)
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
	lis 5,.LC6@ha
	mr 3,28
	la 5,.LC6@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC7@ha
	mr 3,28
	la 5,.LC7@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC8@ha
	mr 3,28
	la 5,.LC8@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC9@ha
	mr 3,28
	la 5,.LC9@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC10@ha
	mr 3,28
	la 5,.LC10@l(5)
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
	lis 5,.LC11@ha
	mr 3,28
	la 5,.LC11@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	mr 3,28
	la 5,.LC0@l(27)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Menu_Hlp,.Lfe1-Menu_Hlp
	.section	".rodata"
	.align 2
.LC12:
	.string	"xv 32 yv 8 picn inventory "
	.align 2
.LC13:
	.string	"Turned zero at char: %i[%c]\n"
	.align 2
.LC14:
	.string	"xv 50 yv %i string2 \"%s\" "
	.section	".text"
	.align 2
	.globl Menu_Msg
	.type	 Menu_Msg,@function
Menu_Msg:
	stwu 1,-1232(1)
	mflr 0
	stmw 24,1200(1)
	stw 0,1236(1)
	mr 25,3
	mr 24,4
	lwz 9,84(25)
	lwz 0,1920(9)
	cmpwi 0,0,0
	bc 4,2,.L7
	lwz 0,1932(9)
	cmpwi 0,0,0
	bc 4,2,.L7
	lwz 0,1916(9)
	lwz 9,1936(9)
	cmpwi 0,0,0
	bc 12,2,.L8
	cmpwi 0,9,0
	bc 12,2,.L7
.L8:
	cmpwi 0,9,0
	bc 12,2,.L10
	mr 3,25
	bl Menu_Close
	b .L7
.L10:
	lis 4,.LC12@ha
	addi 3,1,8
	la 4,.LC12@l(4)
	li 27,0
	crxor 6,6,6
	bl sprintf
	li 30,0
	li 28,0
	li 26,24
	b .L11
.L15:
	cmpwi 0,0,10
	bc 4,2,.L17
	addi 31,1,1032
	li 0,0
	stbx 0,31,30
	mr 3,31
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L18
	addi 29,1,1112
	lis 4,.LC14@ha
	la 4,.LC14@l(4)
	mr 3,29
	mr 5,26
	mr 6,31
	crxor 6,6,6
	bl sprintf
	mr 4,29
	addi 3,1,8
	bl strcat
.L18:
	cmpwi 0,27,13
	li 30,0
	stbx 30,31,30
	addi 26,26,12
	addi 28,28,1
	addi 27,27,1
	bc 12,2,.L12
	b .L16
.L17:
	addi 31,1,1032
	cmpwi 0,30,27
	stbx 9,31,30
	addi 30,30,1
	bc 4,2,.L16
	addi 29,1,1112
	li 0,0
	lis 4,.LC14@ha
	stbx 0,31,30
	mr 5,26
	la 4,.LC14@l(4)
	mr 6,31
	mr 3,29
	li 30,0
	crxor 6,6,6
	bl sprintf
	mr 4,29
	addi 3,1,8
	bl strcat
	stbx 30,31,30
.L24:
	b .L24
.L16:
	addi 28,28,1
.L11:
	cmpwi 0,27,13
	bc 12,1,.L12
	addi 3,1,8
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L14
	lis 9,gi@ha
	lis 4,.LC13@ha
	lbzx 6,24,28
	lwz 0,gi@l(9)
	la 4,.LC13@l(4)
	li 3,2
	mr 5,28
	mtlr 0
	crxor 6,6,6
	blrl
.L14:
	lbzx 9,24,28
	rlwinm 0,9,0,0xff
	cmpwi 0,0,0
	bc 4,2,.L15
.L12:
	cmpwi 7,27,13
	srawi 0,30,31
	subf 0,30,0
	srwi 0,0,31
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	and. 11,0,9
	bc 12,2,.L28
	addi 29,1,1112
	addi 6,1,1032
	li 0,0
	lis 4,.LC14@ha
	la 4,.LC14@l(4)
	stbx 0,6,30
	mr 5,26
	mr 3,29
	crxor 6,6,6
	bl sprintf
	mr 4,29
	addi 3,1,8
	bl strcat
.L28:
	lwz 9,84(25)
	li 0,1
	li 10,0
	lis 29,gi@ha
	li 3,4
	stw 0,1916(9)
	la 29,gi@l(29)
	lwz 9,84(25)
	stw 0,1936(9)
	lwz 11,84(25)
	stw 10,1932(11)
	lwz 9,84(25)
	stw 10,1920(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	addi 3,1,8
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,25
	li 4,1
	mtlr 0
	blrl
.L7:
	lwz 0,1236(1)
	mtlr 0
	lmw 24,1200(1)
	la 1,1232(1)
	blr
.Lfe2:
	.size	 Menu_Msg,.Lfe2-Menu_Msg
	.section	".rodata"
	.align 2
.LC15:
	.string	"ERROR: Too many items in menu [%i]\n"
	.align 2
.LC16:
	.string	"%-21s"
	.align 2
.LC17:
	.string	"xv 50 yv 36 string2 \"  QRANK - Select option\" "
	.align 2
.LC18:
	.string	"xv 52 yv 36 string2 \"  %s\" "
	.align 2
.LC19:
	.string	"xv 52 yv 45 string2 \"  -------------------------\" "
	.align 2
.LC20:
	.string	"xv 52 yv %i string \" \215%s   \" "
	.align 2
.LC21:
	.string	"xv 52 yv %i string2 \"  %s   \" "
	.section	".text"
	.align 2
	.globl Menu_Open
	.type	 Menu_Open,@function
Menu_Open:
	stwu 1,-1232(1)
	mflr 0
	stmw 23,1196(1)
	stw 0,1236(1)
	mr 31,3
	lis 4,.LC12@ha
	addi 3,1,168
	la 4,.LC12@l(4)
	mr 25,3
	crxor 6,6,6
	bl sprintf
	lwz 9,84(31)
	lwz 5,1948(9)
	cmpwi 0,5,0
	bc 4,2,.L52
	lis 4,.LC17@ha
	addi 3,1,8
	la 4,.LC17@l(4)
	crxor 6,6,6
	bl sprintf
	b .L53
.L52:
	lis 4,.LC18@ha
	addi 3,1,8
	la 4,.LC18@l(4)
	crxor 6,6,6
	bl sprintf
.L53:
	addi 4,1,8
	mr 3,25
	bl strcat
	li 29,0
	li 30,57
	lis 4,.LC19@ha
	addi 3,1,8
	la 4,.LC19@l(4)
	crxor 6,6,6
	bl sprintf
	mr 3,25
	addi 4,1,8
	bl strcat
	lwz 9,84(31)
	lwz 0,1944(9)
	cmpw 0,29,0
	bc 4,0,.L55
	addi 28,1,88
	lis 23,.LC20@ha
	lis 24,.LC21@ha
	li 26,0
	li 27,0
.L57:
	lwz 0,1940(9)
	cmpw 0,29,0
	bc 4,2,.L58
	addi 9,9,1952
	mr 3,28
	lwzx 4,9,27
	bl strcpy
	addi 3,1,8
	la 4,.LC20@l(23)
	mr 5,30
	mr 6,28
	crxor 6,6,6
	bl sprintf
	b .L59
.L58:
	addi 9,9,1952
	addi 3,1,8
	lwzx 6,9,26
	la 4,.LC21@l(24)
	mr 5,30
	crxor 6,6,6
	bl sprintf
.L59:
	mr 3,25
	addi 4,1,8
	bl strcat
	addi 29,29,1
	addi 30,30,8
	lwz 9,84(31)
	addi 26,26,4
	addi 27,27,4
	lwz 0,1944(9)
	cmpw 0,29,0
	bc 12,0,.L57
.L55:
	lwz 9,84(31)
	li 0,1
	li 10,0
	lis 29,gi@ha
	li 3,4
	stw 0,1916(9)
	la 29,gi@l(29)
	lwz 9,84(31)
	stw 0,1932(9)
	lwz 11,84(31)
	stw 10,1936(11)
	lwz 9,84(31)
	stw 10,1920(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	mr 3,25
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,31
	li 4,1
	mtlr 0
	blrl
	lwz 0,1236(1)
	mtlr 0
	lmw 23,1196(1)
	la 1,1232(1)
	blr
.Lfe3:
	.size	 Menu_Open,.Lfe3-Menu_Open
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.align 2
	.globl Menu_Init
	.type	 Menu_Init,@function
Menu_Init:
	li 9,11
	li 0,0
	mtctr 9
	li 11,0
.L90:
	lwz 9,84(3)
	addi 9,9,1952
	stwx 0,9,11
	addi 11,11,4
	bdnz .L90
	lwz 9,84(3)
	li 0,0
	stw 0,1948(9)
	lwz 11,84(3)
	stw 0,1944(11)
	blr
.Lfe4:
	.size	 Menu_Init,.Lfe4-Menu_Init
	.align 2
	.globl Menu_Clear
	.type	 Menu_Clear,@function
Menu_Clear:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lwz 9,84(29)
	lwz 0,1932(9)
	cmpwi 0,0,0
	bc 12,2,.L35
	li 30,0
	li 31,11
.L40:
	lwz 9,84(29)
	addi 9,9,1952
	lwzx 3,9,30
	cmpwi 0,3,0
	bc 12,2,.L39
	bl free
.L39:
	addic. 31,31,-1
	addi 30,30,4
	bc 4,2,.L40
	lwz 9,84(29)
	lwz 3,1948(9)
	cmpwi 0,3,0
	bc 12,2,.L43
	bl free
.L43:
	lwz 9,84(29)
	stw 31,1944(9)
	lwz 11,84(29)
	stw 31,1940(11)
.L35:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 Menu_Clear,.Lfe5-Menu_Clear
	.align 2
	.globl Menu_Add
	.type	 Menu_Add,@function
Menu_Add:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	lwz 9,84(31)
	lwz 4,1944(9)
	cmpwi 0,4,11
	bc 4,1,.L45
	lis 9,gi+4@ha
	lis 3,.LC15@ha
	lwz 0,gi+4@l(9)
	la 3,.LC15@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L44
.L45:
	li 3,22
	bl malloc
	lwz 9,84(31)
	lwz 0,1944(9)
	addi 9,9,1952
	slwi 0,0,2
	stwx 3,9,0
	lwz 11,84(31)
	lwz 0,1944(11)
	addi 11,11,1952
	slwi 0,0,2
	lwzx 3,11,0
	cmpwi 0,3,0
	bc 12,2,.L44
	lis 4,.LC16@ha
	mr 5,30
	la 4,.LC16@l(4)
	crxor 6,6,6
	bl sprintf
	lwz 11,84(31)
	lwz 9,1944(11)
	addi 9,9,1
	stw 9,1944(11)
.L44:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 Menu_Add,.Lfe6-Menu_Add
	.align 2
	.globl Menu_Title
	.type	 Menu_Title,@function
Menu_Title:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	li 3,28
	bl malloc
	lwz 9,84(31)
	stw 3,1948(9)
	lwz 11,84(31)
	lwz 3,1948(11)
	cmpwi 0,3,0
	bc 12,2,.L47
	mr 4,30
	li 5,27
	bl strncpy
	lwz 9,84(31)
	li 0,0
	lwz 11,1948(9)
	stb 0,27(11)
.L47:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 Menu_Title,.Lfe7-Menu_Title
	.align 2
	.globl Menu_Close
	.type	 Menu_Close,@function
Menu_Close:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,1932(9)
	cmpwi 0,0,0
	bc 12,2,.L63
	li 29,0
	li 30,11
.L66:
	lwz 9,84(31)
	addi 9,9,1952
	lwzx 3,9,29
	cmpwi 0,3,0
	bc 12,2,.L68
	bl free
.L68:
	addic. 30,30,-1
	addi 29,29,4
	bc 4,2,.L66
	lwz 9,84(31)
	lwz 3,1948(9)
	cmpwi 0,3,0
	bc 12,2,.L70
	bl free
.L70:
	lwz 9,84(31)
	stw 30,1944(9)
	lwz 11,84(31)
	stw 30,1940(11)
.L63:
	lwz 11,84(31)
	li 0,0
	stw 0,1916(11)
	lwz 9,84(31)
	stw 0,1932(9)
	lwz 11,84(31)
	stw 0,1936(11)
	lwz 9,84(31)
	stw 0,1920(9)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 Menu_Close,.Lfe8-Menu_Close
	.align 2
	.globl Menu_Up
	.type	 Menu_Up,@function
Menu_Up:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 10,1944(9)
	cmpwi 0,10,0
	bc 12,2,.L71
	lwz 11,1940(9)
	cmpwi 0,11,0
	bc 4,2,.L73
	addi 0,10,-1
	b .L91
.L73:
	addi 0,11,-1
.L91:
	stw 0,1940(9)
	bl Menu_Open
.L71:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 Menu_Up,.Lfe9-Menu_Up
	.align 2
	.globl Menu_Dn
	.type	 Menu_Dn,@function
Menu_Dn:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 11,1944(9)
	cmpwi 0,11,0
	bc 12,2,.L75
	lwz 10,1940(9)
	addi 0,11,-1
	cmpw 0,10,0
	li 0,0
	bc 12,2,.L92
	addi 0,10,1
.L92:
	stw 0,1940(9)
	bl Menu_Open
.L75:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe10:
	.size	 Menu_Dn,.Lfe10-Menu_Dn
	.align 2
	.globl Menu_Sel
	.type	 Menu_Sel,@function
Menu_Sel:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,1932(9)
	lwz 28,1940(9)
	cmpwi 0,0,0
	bc 12,2,.L81
	li 30,0
	li 29,11
.L84:
	lwz 9,84(31)
	addi 9,9,1952
	lwzx 3,9,30
	cmpwi 0,3,0
	bc 12,2,.L86
	bl free
.L86:
	addic. 29,29,-1
	addi 30,30,4
	bc 4,2,.L84
	lwz 9,84(31)
	lwz 3,1948(9)
	cmpwi 0,3,0
	bc 12,2,.L88
	bl free
.L88:
	lwz 9,84(31)
	stw 29,1944(9)
	lwz 11,84(31)
	stw 29,1940(11)
.L81:
	lwz 11,84(31)
	li 29,0
	mr 4,28
	mr 3,31
	stw 29,1916(11)
	lwz 9,84(31)
	stw 29,1932(9)
	lwz 11,84(31)
	stw 29,1936(11)
	lwz 9,84(31)
	stw 29,1920(9)
	lwz 11,84(31)
	lwz 0,1996(11)
	mtlr 0
	blrl
	lwz 9,84(31)
	stw 29,1996(9)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 Menu_Sel,.Lfe11-Menu_Sel
	.align 2
	.globl Menu_Title1
	.type	 Menu_Title1,@function
Menu_Title1:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	li 3,28
	bl malloc
	lwz 9,84(31)
	stw 3,1948(9)
	lwz 11,84(31)
	lwz 3,1948(11)
	cmpwi 0,3,0
	bc 12,2,.L49
	mr 4,30
	li 5,27
	bl strncpy
	lwz 9,84(31)
	li 0,0
	lwz 11,1948(9)
	stb 0,27(11)
.L49:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 Menu_Title1,.Lfe12-Menu_Title1
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
