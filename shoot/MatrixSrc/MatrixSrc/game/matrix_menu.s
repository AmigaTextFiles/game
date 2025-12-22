	.file	"matrix_menu.c"
gcc2_compiled.:
	.globl spellmenu
	.section	".data"
	.align 2
	.type	 spellmenu,@object
spellmenu:
	.long .LC0
	.long 1
	.long 0
	.long 0
	.long .LC1
	.long 0
	.long 0
	.long 0
	.long .LC2
	.long 0
	.long 0
	.long 0
	.long .LC3
	.long 0
	.long 0
	.long posses
	.long .LC4
	.long 0
	.long 0
	.long stopb
	.long .LC5
	.long 0
	.long 0
	.long jump
	.long .LC6
	.long 0
	.long 0
	.long irvis
	.long .LC7
	.long 0
	.long 0
	.long cloak
	.long .LC8
	.long 0
	.long 0
	.long speed
	.long .LC9
	.long 0
	.long 0
	.long light
	.section	".rodata"
	.align 2
.LC9:
	.string	"EMP Blast   |     Lights"
	.align 2
.LC8:
	.string	"Speed       |   Up_Speed"
	.align 2
.LC7:
	.string	"Cloak       |      Cloak"
	.align 2
.LC6:
	.string	"Ir Vision   |   IRVision"
	.align 2
.LC5:
	.string	"Matrix Jump | MatrixJump"
	.align 2
.LC4:
	.string	"Stop Bullets|StopBullets"
	.align 2
.LC3:
	.string	"Posses      |     Change"
	.align 2
.LC2:
	.string	"            |           "
	.align 2
.LC1:
	.string	"Spell----Console Command"
	.align 2
.LC0:
	.string	"*Spells"
	.size	 spellmenu,160
	.globl matrixmenu
	.section	".data"
	.align 2
	.type	 matrixmenu,@object
matrixmenu:
	.long .LC10
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC11
	.long 0
	.long 0
	.long Autobuyspell
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC12
	.long 0
	.long 0
	.long openspell
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC13
	.long 0
	.long 0
	.long 0
	.long .LC14
	.long 0
	.long 0
	.long 0
	.long .LC15
	.long 0
	.long 0
	.long 0
	.long .LC16
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC17
	.long 2
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC17:
	.string	"The Matrix Q2 1.2"
	.align 2
.LC16:
	.string	"(TAB to view inventory)"
	.align 2
.LC15:
	.string	"ESC to Exit Menu"
	.align 2
.LC14:
	.string	"ENTER to select"
	.align 2
.LC13:
	.string	"Use [ and ] to move cursor"
	.align 2
.LC12:
	.string	"Use Spell"
	.align 2
.LC11:
	.string	"Auto-Buy Spell"
	.align 2
.LC10:
	.string	"The Matrix For Quake II"
	.size	 matrixmenu,224
	.align 2
.LC18:
	.string	"You dont have enough energy stored\n"
	.globl tankmenu
	.section	".data"
	.align 2
	.type	 tankmenu,@object
tankmenu:
	.long .LC10
	.long 1
	.long 0
	.long 0
	.long .LC19
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC20
	.long 0
	.long 0
	.long dropweap
	.long .LC21
	.long 0
	.long 0
	.long dropstamina
	.long .LC22
	.long 0
	.long 0
	.long droparmour
	.long .LC23
	.long 0
	.long 0
	.long droppower
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC13
	.long 0
	.long 0
	.long 0
	.long .LC14
	.long 0
	.long 0
	.long 0
	.long .LC15
	.long 0
	.long 0
	.long 0
	.long .LC16
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC17
	.long 2
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC23:
	.string	"Drop PowerUp"
	.align 2
.LC22:
	.string	"Drop Armor"
	.align 2
.LC21:
	.string	"Drop Stamina"
	.align 2
.LC20:
	.string	"Drop Weapon"
	.align 2
.LC19:
	.string	"Tank Mode"
	.size	 tankmenu,272
	.section	".text"
	.align 2
	.type	 speed,@function
speed:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L7
	bl PMenu_Close
.L7:
	mr 3,31
	crxor 6,6,6
	bl Cmd_BuySpeed_f
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe1:
	.size	 speed,.Lfe1-speed
	.align 2
	.type	 posses,@function
posses:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L9
	bl PMenu_Close
.L9:
	mr 3,31
	crxor 6,6,6
	bl MatrixStartSwap
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe2:
	.size	 posses,.Lfe2-posses
	.align 2
	.type	 stopb,@function
stopb:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L11
	bl PMenu_Close
.L11:
	mr 3,31
	crxor 6,6,6
	bl Cmd_StopBullets_f
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 stopb,.Lfe3-stopb
	.align 2
	.type	 jump,@function
jump:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L13
	bl PMenu_Close
.L13:
	mr 3,31
	crxor 6,6,6
	bl Cmd_Jump_f
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 jump,.Lfe4-jump
	.align 2
	.type	 irvis,@function
irvis:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L15
	bl PMenu_Close
.L15:
	mr 3,31
	crxor 6,6,6
	bl Cmd_Infrared_f
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 irvis,.Lfe5-irvis
	.align 2
	.type	 cloak,@function
cloak:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L17
	bl PMenu_Close
.L17:
	mr 3,31
	crxor 6,6,6
	bl Cmd_Cloak_f
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 cloak,.Lfe6-cloak
	.align 2
	.type	 light,@function
light:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L19
	bl PMenu_Close
.L19:
	mr 3,31
	crxor 6,6,6
	bl Cmd_Lights_f
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 light,.Lfe7-light
	.align 2
	.type	 openspell,@function
openspell:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L23
	bl PMenu_Close
.L23:
	lis 4,spellmenu@ha
	mr 3,31
	la 4,spellmenu@l(4)
	li 5,-1
	li 6,10
	bl PMenu_Open
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 openspell,.Lfe8-openspell
	.align 2
	.type	 Autobuyspell,@function
Autobuyspell:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L25
	bl PMenu_Close
.L25:
	mr 3,31
	crxor 6,6,6
	bl Cmd_AutoBuy_f
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe9:
	.size	 Autobuyspell,.Lfe9-Autobuyspell
	.align 2
	.globl MatrixOpenMenu
	.type	 MatrixOpenMenu,@function
MatrixOpenMenu:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L27
	bl PMenu_Close
.L27:
	lis 4,matrixmenu@ha
	mr 3,31
	la 4,matrixmenu@l(4)
	li 5,-1
	li 6,14
	bl PMenu_Open
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe10:
	.size	 MatrixOpenMenu,.Lfe10-MatrixOpenMenu
	.section	".rodata"
	.align 2
.LC24:
	.long 0x42c80000
	.section	".text"
	.align 2
	.type	 dropstamina,@function
dropstamina:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,.LC24@ha
	mr 31,3
	la 9,.LC24@l(9)
	lfs 0,924(31)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L29
	lis 9,gi+8@ha
	lis 5,.LC18@ha
	lwz 0,gi+8@l(9)
	la 5,.LC18@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L28
.L29:
	fsubs 0,0,13
	lwz 9,84(31)
	stfs 0,924(31)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L30
	mr 3,31
	bl PMenu_Close
.L30:
	mr 3,31
	li 4,64
	crxor 6,6,6
	bl MatrixTankDropItem
.L28:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 dropstamina,.Lfe11-dropstamina
	.section	".rodata"
	.align 2
.LC25:
	.long 0x42c80000
	.section	".text"
	.align 2
	.type	 droparmour,@function
droparmour:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,.LC25@ha
	mr 31,3
	la 9,.LC25@l(9)
	lfs 0,924(31)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L32
	lis 9,gi+8@ha
	lis 5,.LC18@ha
	lwz 0,gi+8@l(9)
	la 5,.LC18@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L31
.L32:
	fsubs 0,0,13
	lwz 9,84(31)
	stfs 0,924(31)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L33
	mr 3,31
	bl PMenu_Close
.L33:
	mr 3,31
	li 4,4
	crxor 6,6,6
	bl MatrixTankDropItem
.L31:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 droparmour,.Lfe12-droparmour
	.section	".rodata"
	.align 2
.LC26:
	.long 0x42c80000
	.section	".text"
	.align 2
	.type	 droppower,@function
droppower:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,.LC26@ha
	mr 31,3
	la 9,.LC26@l(9)
	lfs 0,924(31)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L35
	lis 9,gi+8@ha
	lis 5,.LC18@ha
	lwz 0,gi+8@l(9)
	la 5,.LC18@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L34
.L35:
	fsubs 0,0,13
	lwz 9,84(31)
	stfs 0,924(31)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L36
	mr 3,31
	bl PMenu_Close
.L36:
	mr 3,31
	li 4,32
	crxor 6,6,6
	bl MatrixTankDropItem
.L34:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe13:
	.size	 droppower,.Lfe13-droppower
	.section	".rodata"
	.align 2
.LC27:
	.long 0x42c80000
	.section	".text"
	.align 2
	.type	 dropweap,@function
dropweap:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,.LC27@ha
	mr 31,3
	la 9,.LC27@l(9)
	lfs 0,924(31)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L38
	lis 9,gi+8@ha
	lis 5,.LC18@ha
	lwz 0,gi+8@l(9)
	la 5,.LC18@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L37
.L38:
	fsubs 0,0,13
	lwz 9,84(31)
	stfs 0,924(31)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L39
	mr 3,31
	bl PMenu_Close
.L39:
	mr 3,31
	li 4,1
	crxor 6,6,6
	bl MatrixTankDropItem
.L37:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe14:
	.size	 dropweap,.Lfe14-dropweap
	.align 2
	.globl MatrixOpenTankMenu
	.type	 MatrixOpenTankMenu,@function
MatrixOpenTankMenu:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L41
	bl PMenu_Close
.L41:
	lis 4,tankmenu@ha
	mr 3,31
	la 4,tankmenu@l(4)
	li 5,-1
	li 6,17
	bl PMenu_Open
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe15:
	.size	 MatrixOpenTankMenu,.Lfe15-MatrixOpenTankMenu
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
