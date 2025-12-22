	.file	"p_hud.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.long 0x0
	.align 2
.LC1:
	.long 0x41000000
	.section	".text"
	.align 2
	.globl MoveClientToIntermission
	.type	 MoveClientToIntermission,@function
MoveClientToIntermission:
	stwu 1,-16(1)
	lis 9,deathmatch@ha
	lis 6,.LC0@ha
	lwz 11,deathmatch@l(9)
	la 6,.LC0@l(6)
	lfs 13,0(6)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L8
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L7
.L8:
	lwz 9,84(3)
	li 0,1
	stw 0,3620(9)
.L7:
	lis 10,level@ha
	lis 9,.LC1@ha
	lwz 7,84(3)
	la 10,level@l(10)
	la 9,.LC1@l(9)
	lfs 0,212(10)
	li 0,4
	lis 6,.LC0@ha
	lfs 9,0(9)
	li 5,0
	la 6,.LC0@l(6)
	lfs 8,0(6)
	stfs 0,4(3)
	mr 11,9
	mr 8,9
	lfs 0,216(10)
	lis 6,deathmatch@ha
	stfs 0,8(3)
	lfs 13,220(10)
	stfs 13,12(3)
	lfs 0,212(10)
	fmuls 0,0,9
	fctiwz 12,0
	stfd 12,8(1)
	lwz 9,12(1)
	sth 9,4(7)
	lfs 0,216(10)
	lwz 9,84(3)
	fmuls 0,0,9
	fctiwz 11,0
	stfd 11,8(1)
	lwz 11,12(1)
	sth 11,6(9)
	lfs 0,220(10)
	lwz 11,84(3)
	fmuls 0,0,9
	fctiwz 10,0
	stfd 10,8(1)
	lwz 8,12(1)
	sth 8,8(11)
	lfs 0,224(10)
	lwz 9,84(3)
	stfs 0,28(9)
	lfs 0,228(10)
	lwz 11,84(3)
	stfs 0,32(11)
	lfs 13,232(10)
	lwz 9,84(3)
	stfs 13,36(9)
	lwz 11,84(3)
	stw 0,0(11)
	lwz 9,84(3)
	stw 5,88(9)
	lwz 11,84(3)
	stfs 8,108(11)
	lwz 10,84(3)
	lwz 0,116(10)
	rlwinm 0,0,0,0,30
	stw 0,116(10)
	lwz 9,84(3)
	stfs 8,3832(9)
	lwz 11,84(3)
	lwz 10,deathmatch@l(6)
	stfs 8,3836(11)
	lwz 9,84(3)
	stfs 8,3840(9)
	lwz 11,84(3)
	stfs 8,3844(11)
	lwz 9,84(3)
	stw 5,3848(9)
	lwz 11,84(3)
	stfs 8,3852(11)
	stw 5,508(3)
	stw 5,44(3)
	stw 5,48(3)
	stw 5,40(3)
	stw 5,64(3)
	stw 5,76(3)
	stw 5,248(3)
	lfs 0,20(10)
	fcmpu 0,0,8
	bc 4,2,.L10
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,8
	bc 12,2,.L9
.L10:
	stw 5,912(3)
	stw 5,908(3)
.L9:
	la 1,16(1)
	blr
.Lfe1:
	.size	 MoveClientToIntermission,.Lfe1-MoveClientToIntermission
	.section	".rodata"
	.align 2
.LC2:
	.string	"*"
	.align 2
.LC3:
	.string	"info_player_intermission"
	.align 2
.LC4:
	.string	"info_player_start"
	.align 2
.LC5:
	.string	"info_player_deathmatch"
	.align 2
.LC6:
	.long 0x0
	.align 3
.LC7:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl BeginIntermission
	.type	 BeginIntermission,@function
BeginIntermission:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 26,16(1)
	stw 0,52(1)
	lis 11,.LC6@ha
	lis 9,level+200@ha
	la 11,.LC6@l(11)
	lfs 0,level+200@l(9)
	mr 29,3
	lfs 31,0(11)
	fcmpu 0,0,31
	bc 4,2,.L11
	lis 9,game+1560@ha
	li 0,0
	stw 0,game+1560@l(9)
	li 4,0
	li 5,1
	li 30,0
	bl KOTSScoreboardMessage
	lis 26,maxclients@ha
	lis 9,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,31,0
	bc 4,0,.L14
	lis 9,.LC7@ha
	lis 27,g_edicts@ha
	la 9,.LC7@l(9)
	lis 28,0x4330
	lfd 31,0(9)
	li 31,976
.L16:
	lwz 0,g_edicts@l(27)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L15
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 12,1,.L15
	bl respawn
.L15:
	addi 30,30,1
	lwz 11,maxclients@l(26)
	xoris 0,30,0x8000
	addi 31,31,976
	stw 0,12(1)
	stw 28,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L16
.L14:
	lis 9,level@ha
	lis 4,.LC2@ha
	la 31,level@l(9)
	la 4,.LC2@l(4)
	lfs 0,4(31)
	stfs 0,200(31)
	lwz 0,504(29)
	mr 3,0
	stw 0,204(31)
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L20
	lis 11,.LC6@ha
	lis 9,coop@ha
	la 11,.LC6@l(11)
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L34
	lis 9,maxclients@ha
	li 30,0
	lwz 10,maxclients@l(9)
	lfs 0,20(10)
	fcmpu 0,13,0
	bc 4,0,.L34
	lis 9,g_edicts@ha
	lis 11,itemlist@ha
	lwz 4,g_edicts@l(9)
	la 11,itemlist@l(11)
	mr 5,10
	lis 9,.LC7@ha
	lis 31,0x4330
	la 9,.LC7@l(9)
	lfd 12,0(9)
.L25:
	mulli 9,30,976
	addi 7,30,1
	addi 9,9,976
	add 3,4,9
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L24
	li 0,256
	li 6,0
	mtctr 0
	li 8,0
	addi 10,11,56
.L50:
	lwz 0,0(10)
	addi 10,10,76
	andi. 9,0,16
	bc 12,2,.L29
	lwz 9,84(3)
	addi 9,9,740
	stwx 6,9,8
.L29:
	addi 8,8,4
	bdnz .L50
.L24:
	mr 30,7
	lfs 13,20(5)
	xoris 0,30,0x8000
	stw 0,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L25
	b .L34
.L20:
	lis 9,.LC6@ha
	lis 11,deathmatch@ha
	la 9,.LC6@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L34
	li 0,1
	stw 0,208(31)
	b .L11
.L34:
	lis 9,level+208@ha
	li 0,0
	lis 5,.LC3@ha
	stw 0,level+208@l(9)
	li 3,0
	la 5,.LC3@l(5)
	li 4,280
	bl G_Find
	lis 29,.LC3@ha
	mr. 31,3
	bc 4,2,.L36
	lis 5,.LC4@ha
	li 3,0
	la 5,.LC4@l(5)
	li 4,280
	bl G_Find
	mr. 31,3
	bc 4,2,.L38
	lis 5,.LC5@ha
	li 3,0
	la 5,.LC5@l(5)
	li 4,280
	bl G_Find
	mr 31,3
	b .L38
.L36:
	bl rand
	rlwinm 30,3,0,30,31
	b .L39
.L41:
	mr 3,31
	li 4,280
	la 5,.LC3@l(29)
	bl G_Find
	mr. 31,3
	bc 4,2,.L39
	li 3,0
	li 4,280
	la 5,.LC3@l(29)
	bl G_Find
	mr 31,3
.L39:
	cmpwi 0,30,0
	addi 30,30,-1
	bc 4,2,.L41
.L38:
	lfs 0,4(31)
	lis 11,maxclients@ha
	lis 9,level@ha
	lwz 10,maxclients@l(11)
	la 9,level@l(9)
	li 30,0
	lis 11,.LC6@ha
	stfs 0,212(9)
	la 11,.LC6@l(11)
	lfs 0,8(31)
	lfs 12,0(11)
	stfs 0,216(9)
	lfs 13,12(31)
	stfs 13,220(9)
	lfs 0,16(31)
	stfs 0,224(9)
	lfs 13,20(31)
	stfs 13,228(9)
	lfs 0,24(31)
	stfs 0,232(9)
	lfs 13,20(10)
	fcmpu 0,12,13
	bc 4,0,.L11
	lis 9,.LC7@ha
	lis 28,g_edicts@ha
	la 9,.LC7@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 31,976
.L47:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L46
	bl MoveClientToIntermission
.L46:
	addi 30,30,1
	lwz 11,maxclients@l(26)
	xoris 0,30,0x8000
	addi 31,31,976
	stw 0,12(1)
	stw 29,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L47
.L11:
	lwz 0,52(1)
	mtlr 0
	lmw 26,16(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 BeginIntermission,.Lfe2-BeginIntermission
	.section	".rodata"
	.align 2
.LC8:
	.string	"easy"
	.align 2
.LC9:
	.string	"medium"
	.align 2
.LC10:
	.string	"hard"
	.align 2
.LC11:
	.string	"hard+"
	.align 2
.LC12:
	.string	"xv 32 yv 8 picn help xv 202 yv 12 string2 \"%s\" xv 0 yv 24 cstring2 \"%s\" xv 0 yv 54 cstring2 \"%s\" xv 0 yv 110 cstring2 \"%s\" xv 50 yv 164 string2 \" kills     goals    secrets\" xv 50 yv 172 string2 \"%3i/%3i     %i/%i       %i/%i\" "
	.align 2
.LC13:
	.long 0x0
	.align 2
.LC14:
	.long 0x3f800000
	.align 2
.LC15:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl HelpComputer
	.type	 HelpComputer,@function
HelpComputer:
	stwu 1,-1088(1)
	mflr 0
	stmw 26,1064(1)
	stw 0,1092(1)
	lis 11,.LC13@ha
	lis 9,skill@ha
	la 11,.LC13@l(11)
	mr 31,3
	lfs 0,0(11)
	lwz 11,skill@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 4,2,.L61
	lis 9,.LC8@ha
	la 6,.LC8@l(9)
	b .L62
.L61:
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L63
	lis 9,.LC9@ha
	la 6,.LC9@l(9)
	b .L62
.L63:
	lis 11,.LC15@ha
	la 11,.LC15@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L65
	lis 9,.LC10@ha
	la 6,.LC10@l(9)
	b .L62
.L65:
	lis 9,.LC11@ha
	la 6,.LC11@l(9)
.L62:
	lis 11,level@ha
	lis 8,game@ha
	la 11,level@l(11)
	la 8,game@l(8)
	lwz 0,272(11)
	lis 5,.LC12@ha
	addi 9,8,512
	lwz 29,268(11)
	li 4,1024
	addi 3,1,32
	lwz 26,284(11)
	addi 7,11,8
	la 5,.LC12@l(5)
	lwz 27,280(11)
	lwz 28,276(11)
	lwz 10,288(11)
	stw 0,20(1)
	stw 29,24(1)
	stw 26,8(1)
	stw 27,12(1)
	stw 28,16(1)
	crxor 6,6,6
	bl Com_sprintf
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	addi 3,1,32
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,31
	li 4,1
	mtlr 0
	blrl
	lwz 0,1092(1)
	mtlr 0
	lmw 26,1064(1)
	la 1,1088(1)
	blr
.Lfe3:
	.size	 HelpComputer,.Lfe3-HelpComputer
	.section	".rodata"
	.align 2
.LC16:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Help_f
	.type	 Cmd_Help_f,@function
Cmd_Help_f:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 29,12(1)
	stw 0,36(1)
	lis 9,.LC16@ha
	lis 29,deathmatch@ha
	la 9,.LC16@l(9)
	mr 31,3
	lfs 31,0(9)
	lwz 9,deathmatch@l(29)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L68
	lwz 11,84(31)
	li 30,0
	stw 30,3624(11)
	lwz 9,84(31)
	stw 30,3628(9)
	lwz 11,84(31)
	lwz 0,3932(11)
	cmpwi 0,0,0
	bc 12,2,.L69
	bl PMenu_Close
.L69:
	lwz 9,deathmatch@l(29)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 4,2,.L70
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L67
.L70:
	lwz 9,84(31)
	lwz 0,3620(9)
	cmpwi 0,0,0
	bc 12,2,.L72
	stw 30,3620(9)
	b .L67
.L72:
	li 0,1
	mr 3,31
	stw 0,3620(9)
	li 5,0
	lwz 4,540(31)
	bl KOTSScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L67
.L68:
	lwz 9,84(31)
	li 8,0
	stw 8,3624(9)
	lwz 11,84(31)
	stw 8,3620(11)
	lwz 10,84(31)
	lwz 0,3628(10)
	cmpwi 0,0,0
	bc 12,2,.L75
	lis 9,game+1024@ha
	lwz 11,1804(10)
	lwz 0,game+1024@l(9)
	cmpw 0,11,0
	bc 4,2,.L75
	stw 8,3628(10)
	b .L67
.L75:
	lwz 11,84(31)
	li 0,1
	li 10,0
	mr 3,31
	stw 0,3628(11)
	lwz 9,84(31)
	stw 10,1808(9)
	bl HelpComputer
.L67:
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 Cmd_Help_f,.Lfe4-Cmd_Help_f
	.section	".rodata"
	.align 2
.LC17:
	.string	"cells"
	.align 2
.LC18:
	.string	"misc/power2.wav"
	.align 2
.LC19:
	.string	"i_powershield"
	.align 2
.LC20:
	.string	"k_powercube"
	.align 2
.LC21:
	.string	"Power Cube"
	.align 2
.LC22:
	.string	"p_quad"
	.align 2
.LC23:
	.string	"p_invulnerability"
	.align 2
.LC24:
	.string	"p_envirosuit"
	.align 2
.LC25:
	.string	"p_rebreather"
	.align 2
.LC26:
	.string	"i_help"
	.align 2
.LC27:
	.long 0x3f800000
	.align 2
.LC28:
	.long 0x0
	.align 3
.LC29:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC30:
	.long 0x41200000
	.align 2
.LC31:
	.long 0x42b60000
	.section	".text"
	.align 2
	.globl G_SetStats
	.type	 G_SetStats,@function
G_SetStats:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 27,36(1)
	stw 0,68(1)
	lis 9,level+266@ha
	mr 31,3
	lhz 0,level+266@l(9)
	lis 27,level@ha
	lwz 9,84(31)
	sth 0,120(9)
	lwz 11,84(31)
	lhz 0,482(31)
	sth 0,122(11)
	lwz 9,84(31)
	lwz 11,3636(9)
	cmpwi 0,11,0
	bc 4,2,.L77
	sth 11,124(9)
	lwz 9,84(31)
	sth 11,126(9)
	b .L78
.L77:
	mulli 11,11,76
	lis 10,gi+40@ha
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	lwz 0,gi+40@l(10)
	add 11,11,9
	lwz 3,36(11)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,124(9)
	lwz 11,84(31)
	lwz 9,3636(11)
	slwi 9,9,2
	add 9,11,9
	lhz 0,742(9)
	sth 0,126(11)
.L78:
	mr 3,31
	bl PowerArmorType
	mr. 30,3
	bc 12,2,.L79
	lis 3,.LC17@ha
	lwz 29,84(31)
	la 3,.LC17@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 28,29,3
	cmpwi 0,28,0
	bc 4,2,.L79
	lwz 0,264(31)
	lis 29,gi@ha
	lis 3,.LC18@ha
	la 29,gi@l(29)
	la 3,.LC18@l(3)
	rlwinm 0,0,0,20,18
	li 30,0
	stw 0,264(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC27@ha
	lis 9,.LC27@ha
	lis 11,.LC28@ha
	mr 5,3
	la 8,.LC27@l(8)
	la 9,.LC27@l(9)
	mtlr 0
	la 11,.LC28@l(11)
	li 4,3
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L79:
	mr 3,31
	bl ArmorIndex
	cmpwi 0,30,0
	mr 29,3
	bc 12,2,.L81
	cmpwi 0,29,0
	bc 12,2,.L82
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 8,0,8
	bc 12,2,.L81
.L82:
	lis 9,gi+40@ha
	lis 3,.LC19@ha
	lwz 0,gi+40@l(9)
	la 3,.LC19@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,128(9)
	lwz 11,84(31)
	sth 28,130(11)
	b .L83
.L81:
	cmpwi 0,29,0
	bc 12,2,.L84
	mr 3,29
	bl GetItemByIndex
	lis 9,gi+40@ha
	lwz 3,36(3)
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
	lwz 11,84(31)
	slwi 9,29,2
	sth 3,128(11)
	lwz 10,84(31)
	add 9,10,9
	lhz 0,742(9)
	sth 0,130(10)
	b .L83
.L84:
	lwz 9,84(31)
	sth 29,128(9)
	lwz 11,84(31)
	sth 29,130(11)
.L83:
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,3864(11)
	fcmpu 0,13,0
	bc 4,1,.L86
	li 0,0
	sth 0,134(11)
	lwz 9,84(31)
	sth 0,136(9)
.L86:
	lwz 11,84(31)
	lwz 0,1844(11)
	cmpwi 0,0,0
	bc 4,2,.L88
	lwz 10,1852(11)
	cmpwi 0,10,0
	bc 12,2,.L87
.L88:
	lis 9,gi+40@ha
	lis 3,.LC20@ha
	lwz 0,gi+40@l(9)
	la 3,.LC20@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	lis 11,.LC21@ha
	sth 3,138(9)
	la 3,.LC21@l(11)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	add 3,11,3
	lhz 0,742(3)
	sth 0,140(11)
	b .L89
.L87:
	lwz 0,level@l(27)
	lis 30,0x4330
	lis 8,.LC29@ha
	lfs 13,3832(11)
	xoris 0,0,0x8000
	la 8,.LC29@l(8)
	stw 0,28(1)
	stw 30,24(1)
	lfd 31,0(8)
	lfd 0,24(1)
	fsub 0,0,31
	frsp 12,0
	fcmpu 0,13,12
	bc 4,1,.L90
	lis 9,gi+40@ha
	lis 3,.LC22@ha
	lwz 0,gi+40@l(9)
	la 3,.LC22@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 8,.LC30@ha
	la 8,.LC30@l(8)
	mr 11,9
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(8)
	stw 0,28(1)
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3832(10)
	b .L113
.L90:
	lfs 0,3836(11)
	fcmpu 0,0,12
	bc 4,1,.L92
	lis 9,gi+40@ha
	lis 3,.LC23@ha
	lwz 0,gi+40@l(9)
	la 3,.LC23@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 8,.LC30@ha
	la 8,.LC30@l(8)
	mr 11,9
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(8)
	stw 0,28(1)
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3836(10)
	b .L113
.L92:
	lfs 0,3844(11)
	fcmpu 0,0,12
	bc 4,1,.L94
	lis 9,gi+40@ha
	lis 3,.LC24@ha
	lwz 0,gi+40@l(9)
	la 3,.LC24@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 8,.LC30@ha
	la 8,.LC30@l(8)
	mr 11,9
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(8)
	stw 0,28(1)
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3844(10)
	b .L113
.L94:
	lfs 0,3840(11)
	fcmpu 0,0,12
	bc 4,1,.L96
	lis 9,gi+40@ha
	lis 3,.LC25@ha
	lwz 0,gi+40@l(9)
	la 3,.LC25@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 8,.LC30@ha
	la 8,.LC30@l(8)
	mr 11,9
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(8)
	stw 0,28(1)
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3840(10)
.L113:
	fsub 13,13,31
	frsp 13,13
	fsubs 0,0,13
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,24(1)
	lwz 11,28(1)
	sth 11,140(10)
	b .L89
.L96:
	sth 10,138(11)
	lwz 9,84(31)
	sth 10,140(9)
.L89:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L98
	li 0,0
	sth 0,132(9)
	b .L99
.L98:
	lis 9,itemlist@ha
	lis 11,gi+40@ha
	mulli 0,0,76
	la 9,itemlist@l(9)
	lwz 11,gi+40@l(11)
	addi 9,9,36
	lwzx 3,9,0
	mtlr 11
	blrl
	lwz 9,84(31)
	sth 3,132(9)
.L99:
	lwz 11,84(31)
	lis 9,deathmatch@ha
	li 10,0
	lwz 8,deathmatch@l(9)
	lhz 0,738(11)
	lis 9,.LC28@ha
	la 9,.LC28@l(9)
	sth 0,144(11)
	lfs 13,0(9)
	lwz 9,84(31)
	sth 10,146(9)
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L100
	lwz 11,84(31)
	lwz 0,724(11)
	cmpwi 0,0,0
	bc 4,1,.L102
	lis 9,level+200@ha
	lfs 0,level+200@l(9)
	fcmpu 0,0,13
	bc 4,2,.L102
	lwz 0,3620(11)
	cmpwi 0,0,0
	bc 12,2,.L105
.L102:
	lwz 9,84(31)
	b .L106
.L100:
	lwz 9,84(31)
	lwz 0,3620(9)
	cmpwi 0,0,0
	bc 4,2,.L106
	lwz 0,3628(9)
	cmpwi 0,0,0
	bc 12,2,.L105
.L106:
	lhz 0,146(9)
	ori 0,0,1
	sth 0,146(9)
.L105:
	lwz 9,84(31)
	lwz 0,3624(9)
	cmpwi 0,0,0
	bc 12,2,.L104
	lwz 0,724(9)
	cmpwi 0,0,0
	bc 4,1,.L104
	lhz 0,146(9)
	ori 0,0,2
	sth 0,146(9)
.L104:
	lwz 11,84(31)
	lhz 0,3562(11)
	sth 0,148(11)
	lwz 9,84(31)
	lwz 0,1808(9)
	cmpwi 0,0,0
	bc 12,2,.L108
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 11,0,8
	bc 12,2,.L108
	lis 9,gi+40@ha
	lis 3,.LC26@ha
	lwz 0,gi+40@l(9)
	la 3,.LC26@l(3)
	b .L114
.L108:
	lwz 9,84(31)
	lwz 0,716(9)
	cmpwi 0,0,2
	bc 12,2,.L111
	lis 8,.LC31@ha
	lfs 13,112(9)
	la 8,.LC31@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	bc 4,1,.L110
.L111:
	lwz 11,1788(9)
	cmpwi 0,11,0
	bc 12,2,.L110
	lis 9,gi+40@ha
	lwz 3,36(11)
	lwz 0,gi+40@l(9)
.L114:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,142(9)
	b .L109
.L110:
	lwz 9,84(31)
	li 0,0
	sth 0,142(9)
.L109:
	lwz 9,84(31)
	li 0,0
	mr 3,31
	sth 0,154(9)
	bl KOTSShowHUD
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe5:
	.size	 G_SetStats,.Lfe5-G_SetStats
	.section	".rodata"
	.align 2
.LC32:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Score_f
	.type	 Cmd_Score_f,@function
Cmd_Score_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	li 30,0
	lwz 9,84(31)
	stw 30,3624(9)
	lwz 11,84(31)
	stw 30,3628(11)
	lwz 9,84(31)
	lwz 0,3932(9)
	cmpwi 0,0,0
	bc 12,2,.L55
	bl PMenu_Close
.L55:
	lis 11,.LC32@ha
	lis 9,deathmatch@ha
	la 11,.LC32@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L56
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L54
.L56:
	lwz 9,84(31)
	lwz 0,3620(9)
	cmpwi 0,0,0
	bc 12,2,.L57
	stw 30,3620(9)
	b .L54
.L57:
	li 0,1
	mr 3,31
	stw 0,3620(9)
	li 5,0
	lwz 4,540(31)
	bl KOTSScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L54:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 Cmd_Score_f,.Lfe6-Cmd_Score_f
	.section	".rodata"
	.align 2
.LC33:
	.long 0x0
	.section	".text"
	.align 2
	.globl G_SetSpectatorStats
	.type	 G_SetSpectatorStats,@function
G_SetSpectatorStats:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lwz 31,84(3)
	lwz 0,3920(31)
	cmpwi 0,0,0
	bc 4,2,.L124
	bl G_SetStats
.L124:
	lwz 0,724(31)
	li 9,1
	li 11,0
	sth 9,154(31)
	cmpwi 0,0,0
	sth 11,146(31)
	bc 4,1,.L126
	lis 11,.LC33@ha
	lis 9,level+200@ha
	la 11,.LC33@l(11)
	lfs 0,level+200@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L126
	lwz 0,3620(31)
	cmpwi 0,0,0
	bc 12,2,.L125
.L126:
	lhz 0,146(31)
	ori 0,0,1
	sth 0,146(31)
.L125:
	lwz 0,3624(31)
	cmpwi 0,0,0
	bc 12,2,.L127
	lwz 0,724(31)
	cmpwi 0,0,0
	bc 4,1,.L127
	lhz 0,146(31)
	ori 0,0,2
	sth 0,146(31)
.L127:
	lwz 10,3920(31)
	cmpwi 0,10,0
	bc 12,2,.L128
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L128
	lis 11,g_edicts@ha
	lis 0,0xc10c
	lwz 9,g_edicts@l(11)
	ori 0,0,38677
	subf 9,9,10
	mullw 9,9,0
	srawi 9,9,4
	addi 9,9,1311
	sth 9,152(31)
	b .L129
.L128:
	li 0,0
	sth 0,152(31)
.L129:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 G_SetSpectatorStats,.Lfe7-G_SetSpectatorStats
	.section	".rodata"
	.align 2
.LC34:
	.long 0x3f800000
	.align 3
.LC35:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl G_CheckChaseStats
	.type	 G_CheckChaseStats,@function
G_CheckChaseStats:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 26,16(1)
	stw 0,52(1)
	lis 11,.LC34@ha
	lis 9,maxclients@ha
	la 11,.LC34@l(11)
	mr 30,3
	lfs 13,0(11)
	li 29,1
	lis 26,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L117
	lis 9,.LC35@ha
	lis 28,g_edicts@ha
	la 9,.LC35@l(9)
	lis 27,0x4330
	lfd 31,0(9)
	li 31,976
.L119:
	lwz 9,g_edicts@l(28)
	add 9,31,9
	lwz 0,88(9)
	lwz 3,84(9)
	cmpwi 0,0,0
	bc 12,2,.L118
	lwz 0,3920(3)
	cmpw 0,0,30
	bc 4,2,.L118
	lwz 4,84(30)
	addi 3,3,120
	li 5,64
	addi 4,4,120
	crxor 6,6,6
	bl memcpy
	lwz 3,g_edicts@l(28)
	add 3,3,31
	bl G_SetSpectatorStats
.L118:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 31,31,976
	stw 0,12(1)
	stw 27,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L119
.L117:
	lwz 0,52(1)
	mtlr 0
	lmw 26,16(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe8:
	.size	 G_CheckChaseStats,.Lfe8-G_CheckChaseStats
	.align 2
	.globl DeathmatchScoreboardMessage
	.type	 DeathmatchScoreboardMessage,@function
DeathmatchScoreboardMessage:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 5,0
	bl KOTSScoreboardMessage
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 DeathmatchScoreboardMessage,.Lfe9-DeathmatchScoreboardMessage
	.align 2
	.globl DeathmatchScoreboard
	.type	 DeathmatchScoreboard,@function
DeathmatchScoreboard:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	li 5,0
	lwz 4,540(29)
	bl KOTSScoreboardMessage
	lis 9,gi+92@ha
	mr 3,29
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 DeathmatchScoreboard,.Lfe10-DeathmatchScoreboard
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
