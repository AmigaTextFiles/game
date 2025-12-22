	.file	"p_hud.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.long 0x41000000
	.section	".text"
	.align 2
	.globl MoveClientToIntermission
	.type	 MoveClientToIntermission,@function
MoveClientToIntermission:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 29,3
	li 0,1
	lwz 8,84(29)
	lis 11,level@ha
	lis 9,.LC0@ha
	la 11,level@l(11)
	la 9,.LC0@l(9)
	stw 0,1916(8)
	li 7,0
	lfs 0,212(11)
	li 0,4
	li 8,0
	lfs 9,0(9)
	li 4,0
	lwz 5,84(29)
	stfs 0,4(29)
	mr 10,9
	mr 6,9
	lfs 0,216(11)
	stfs 0,8(29)
	lfs 13,220(11)
	stfs 13,12(29)
	lfs 0,212(11)
	fmuls 0,0,9
	fctiwz 12,0
	stfd 12,24(1)
	lwz 9,28(1)
	sth 9,4(5)
	lfs 0,216(11)
	lwz 9,84(29)
	fmuls 0,0,9
	fctiwz 11,0
	stfd 11,24(1)
	lwz 10,28(1)
	sth 10,6(9)
	lfs 0,220(11)
	lwz 9,84(29)
	fmuls 0,0,9
	fctiwz 10,0
	stfd 10,24(1)
	lwz 6,28(1)
	sth 6,8(9)
	lfs 0,224(11)
	lwz 9,84(29)
	stfs 0,28(9)
	lfs 13,228(11)
	lwz 9,84(29)
	stfs 13,32(9)
	lfs 0,232(11)
	lwz 9,84(29)
	stfs 0,36(9)
	lwz 11,84(29)
	stw 0,0(11)
	lwz 9,84(29)
	stw 8,88(9)
	lwz 11,84(29)
	stw 7,108(11)
	lwz 10,84(29)
	lwz 0,116(10)
	rlwinm 0,0,0,0,30
	stw 0,116(10)
	lwz 9,84(29)
	stw 7,2196(9)
	lwz 11,84(29)
	stw 7,2200(11)
	lwz 9,84(29)
	stw 7,2204(9)
	lwz 11,84(29)
	stw 7,2208(11)
	lwz 9,84(29)
	stw 8,2212(9)
	lwz 11,84(29)
	stw 7,2216(11)
	stw 7,948(29)
	stw 8,248(29)
	stw 8,508(29)
	stw 8,44(29)
	stw 8,48(29)
	stw 8,40(29)
	stw 8,64(29)
	stw 8,76(29)
	bl CTFScoreboardMessage
	lis 9,gi+92@ha
	mr 3,29
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 MoveClientToIntermission,.Lfe1-MoveClientToIntermission
	.section	".rodata"
	.align 2
.LC1:
	.string	"*"
	.align 2
.LC2:
	.string	"info_player_intermission"
	.align 2
.LC3:
	.string	"info_player_start"
	.align 2
.LC4:
	.string	"info_player_deathmatch"
	.align 2
.LC5:
	.long 0x0
	.align 3
.LC6:
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
	lis 11,.LC5@ha
	lis 9,level+200@ha
	la 11,.LC5@l(11)
	lfs 0,level+200@l(9)
	mr 27,3
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L7
	lis 9,maxclients@ha
	lis 11,game+1560@ha
	lwz 10,maxclients@l(9)
	li 0,0
	li 30,0
	stw 0,game+1560@l(11)
	lis 26,maxclients@ha
	lfs 0,20(10)
	fcmpu 0,13,0
	bc 4,0,.L10
	lis 9,.LC6@ha
	lis 28,g_edicts@ha
	la 9,.LC6@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 31,1116
.L12:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L11
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 12,1,.L11
	bl respawn
.L11:
	addi 30,30,1
	lwz 11,maxclients@l(26)
	xoris 0,30,0x8000
	addi 31,31,1116
	stw 0,12(1)
	stw 29,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L12
.L10:
	lis 9,level@ha
	lis 4,.LC1@ha
	la 31,level@l(9)
	la 4,.LC1@l(4)
	lfs 0,4(31)
	stfs 0,200(31)
	lwz 0,504(27)
	mr 3,0
	stw 0,204(31)
	bl strstr
	cmpwi 0,3,0
	bc 4,2,.L17
	lis 11,.LC5@ha
	lis 9,deathmatch@ha
	la 11,.LC5@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L19
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L17
.L19:
	li 0,1
	stw 0,208(31)
	b .L7
.L17:
	lis 9,level+208@ha
	li 0,0
	lis 5,.LC2@ha
	stw 0,level+208@l(9)
	li 3,0
	la 5,.LC2@l(5)
	li 4,280
	bl G_Find
	lis 29,.LC2@ha
	mr. 31,3
	bc 4,2,.L20
	lis 5,.LC3@ha
	li 3,0
	la 5,.LC3@l(5)
	li 4,280
	bl G_Find
	mr. 31,3
	bc 4,2,.L22
	lis 5,.LC4@ha
	li 3,0
	la 5,.LC4@l(5)
	li 4,280
	bl G_Find
	mr 31,3
	b .L22
.L20:
	bl rand
	rlwinm 30,3,0,30,31
	b .L23
.L25:
	mr 3,31
	li 4,280
	la 5,.LC2@l(29)
	bl G_Find
	mr. 31,3
	bc 4,2,.L23
	li 3,0
	li 4,280
	la 5,.LC2@l(29)
	bl G_Find
	mr 31,3
.L23:
	cmpwi 0,30,0
	addi 30,30,-1
	bc 4,2,.L25
.L22:
	lfs 0,4(31)
	lis 11,maxclients@ha
	lis 9,level@ha
	lwz 10,maxclients@l(11)
	la 9,level@l(9)
	li 30,0
	lis 11,.LC5@ha
	stfs 0,212(9)
	la 11,.LC5@l(11)
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
	bc 4,0,.L7
	lis 9,.LC6@ha
	lis 28,g_edicts@ha
	la 9,.LC6@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 31,1116
.L31:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L30
	bl MoveClientToIntermission
.L30:
	addi 30,30,1
	lwz 11,maxclients@l(26)
	xoris 0,30,0x8000
	addi 31,31,1116
	stw 0,12(1)
	stw 29,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L31
.L7:
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
.LC7:
	.string	"easy"
	.align 2
.LC8:
	.string	"medium"
	.align 2
.LC9:
	.string	"hard"
	.align 2
.LC10:
	.string	"hard+"
	.align 2
.LC11:
	.string	"xv 32 yv 8 picn help xv 202 yv 12 string2 \"%s\" xv 0 yv 24 cstring2 \"%s\" xv 0 yv 54 cstring2 \"%s\" xv 0 yv 110 cstring2 \"%s\" xv 50 yv 164 string2 \" kills     goals    secrets\" xv 50 yv 172 string2 \"%3i/%3i     %i/%i       %i/%i\" "
	.align 2
.LC12:
	.long 0x0
	.align 2
.LC13:
	.long 0x3f800000
	.align 2
.LC14:
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
	lis 11,.LC12@ha
	lis 9,skill@ha
	la 11,.LC12@l(11)
	mr 31,3
	lfs 0,0(11)
	lwz 11,skill@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 4,2,.L43
	lis 9,.LC7@ha
	la 6,.LC7@l(9)
	b .L44
.L43:
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L45
	lis 9,.LC8@ha
	la 6,.LC8@l(9)
	b .L44
.L45:
	lis 11,.LC14@ha
	la 11,.LC14@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L47
	lis 9,.LC9@ha
	la 6,.LC9@l(9)
	b .L44
.L47:
	lis 9,.LC10@ha
	la 6,.LC10@l(9)
.L44:
	lis 11,level@ha
	lis 8,game@ha
	la 11,level@l(11)
	la 8,game@l(8)
	lwz 0,272(11)
	lis 5,.LC11@ha
	addi 9,8,512
	lwz 29,268(11)
	li 4,1024
	addi 3,1,32
	lwz 26,284(11)
	addi 7,11,8
	la 5,.LC11@l(5)
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
.LC15:
	.string	"cells"
	.align 2
.LC16:
	.string	"misc/power2.wav"
	.align 2
.LC17:
	.string	"i_powershield"
	.align 2
.LC18:
	.string	"p_quad"
	.align 2
.LC19:
	.string	"p_invulnerability"
	.align 2
.LC20:
	.string	"p_envirosuit"
	.align 2
.LC21:
	.string	"p_rebreather"
	.align 2
.LC22:
	.string	"i_help"
	.align 2
.LC23:
	.long 0x3f800000
	.align 2
.LC24:
	.long 0x0
	.align 3
.LC25:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC26:
	.long 0x41200000
	.align 2
.LC27:
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
	lwz 0,892(31)
	cmpwi 0,0,0
	bc 12,2,.L57
	lwz 9,84(31)
	lhz 0,482(31)
	b .L87
.L57:
	lwz 9,84(31)
.L87:
	sth 0,122(9)
	lwz 9,84(31)
	lwz 11,2000(9)
	cmpwi 0,11,0
	bc 4,2,.L59
	sth 11,124(9)
	lwz 9,84(31)
	sth 11,126(9)
	b .L60
.L59:
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
	lwz 9,2000(11)
	slwi 9,9,2
	add 9,11,9
	lhz 0,742(9)
	sth 0,126(11)
.L60:
	mr 3,31
	bl PowerArmorType
	mr. 30,3
	bc 12,2,.L61
	lis 3,.LC15@ha
	lwz 29,84(31)
	la 3,.LC15@l(3)
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
	bc 4,2,.L61
	lwz 0,264(31)
	lis 29,gi@ha
	lis 3,.LC16@ha
	la 29,gi@l(29)
	la 3,.LC16@l(3)
	rlwinm 0,0,0,20,18
	li 30,0
	stw 0,264(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC23@ha
	lis 10,.LC23@ha
	lis 11,.LC24@ha
	mr 5,3
	la 9,.LC23@l(9)
	la 10,.LC23@l(10)
	mtlr 0
	la 11,.LC24@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L61:
	mr 3,31
	bl ArmorIndex
	cmpwi 0,30,0
	mr 29,3
	bc 12,2,.L63
	cmpwi 0,29,0
	bc 12,2,.L64
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L63
.L64:
	lis 9,gi+40@ha
	lis 3,.LC17@ha
	lwz 0,gi+40@l(9)
	la 3,.LC17@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,128(9)
	lwz 11,84(31)
	sth 28,130(11)
	b .L65
.L63:
	cmpwi 0,29,0
	bc 12,2,.L66
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
	b .L65
.L66:
	lwz 9,84(31)
	sth 29,128(9)
	lwz 11,84(31)
	sth 29,130(11)
.L65:
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,2276(11)
	fcmpu 0,13,0
	bc 4,1,.L68
	li 0,0
	sth 0,134(11)
	lwz 9,84(31)
	sth 0,136(9)
.L68:
	lwz 0,level@l(27)
	lis 30,0x4330
	lis 10,.LC25@ha
	lwz 11,84(31)
	xoris 0,0,0x8000
	la 10,.LC25@l(10)
	stw 0,28(1)
	stw 30,24(1)
	lfd 31,0(10)
	lfd 0,24(1)
	lfs 13,2196(11)
	fsub 0,0,31
	frsp 12,0
	fcmpu 0,13,12
	bc 4,1,.L69
	lis 9,gi+40@ha
	lis 3,.LC18@ha
	lwz 0,gi+40@l(9)
	la 3,.LC18@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC26@ha
	la 11,.LC26@l(11)
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,2196(10)
	b .L88
.L69:
	lfs 0,2200(11)
	fcmpu 0,0,12
	bc 4,1,.L71
	lis 9,gi+40@ha
	lis 3,.LC19@ha
	lwz 0,gi+40@l(9)
	la 3,.LC19@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC26@ha
	la 11,.LC26@l(11)
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,2200(10)
	b .L88
.L71:
	lfs 0,2208(11)
	fcmpu 0,0,12
	bc 4,1,.L73
	lis 9,gi+40@ha
	lis 3,.LC20@ha
	lwz 0,gi+40@l(9)
	la 3,.LC20@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC26@ha
	la 11,.LC26@l(11)
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,2208(10)
	b .L88
.L73:
	lfs 0,2204(11)
	fcmpu 0,0,12
	bc 4,1,.L75
	lis 9,gi+40@ha
	lis 3,.LC21@ha
	lwz 0,gi+40@l(9)
	la 3,.LC21@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC26@ha
	la 11,.LC26@l(11)
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,2204(10)
.L88:
	fsub 13,13,31
	frsp 13,13
	fsubs 0,0,13
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,24(1)
	lwz 11,28(1)
	sth 11,140(10)
	b .L70
.L75:
	li 0,0
	sth 0,138(11)
	lwz 9,84(31)
	sth 0,140(9)
.L70:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L77
	li 0,0
	sth 0,132(9)
	b .L78
.L77:
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
.L78:
	lwz 11,84(31)
	li 10,0
	lhz 0,738(11)
	sth 0,144(11)
	lwz 9,84(31)
	sth 10,146(9)
	lwz 11,84(31)
	lwz 0,724(11)
	cmpwi 0,0,0
	bc 4,1,.L80
	lis 10,.LC24@ha
	lis 9,level+200@ha
	la 10,.LC24@l(10)
	lfs 0,level+200@l(9)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 4,2,.L80
	lwz 0,1916(11)
	cmpwi 0,0,0
	bc 12,2,.L79
.L80:
	lwz 9,84(31)
	lhz 0,146(9)
	ori 0,0,1
	sth 0,146(9)
.L79:
	lwz 9,84(31)
	lwz 0,1920(9)
	cmpwi 0,0,0
	bc 12,2,.L81
	lwz 0,724(9)
	cmpwi 0,0,0
	bc 4,1,.L81
	lhz 0,146(9)
	ori 0,0,2
	sth 0,146(9)
.L81:
	lwz 11,84(31)
	lhz 0,1818(11)
	sth 0,148(11)
	lwz 9,84(31)
	lwz 0,1840(9)
	cmpwi 0,0,0
	bc 12,2,.L82
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 11,0,8
	bc 12,2,.L82
	lis 9,gi+40@ha
	lis 3,.LC22@ha
	lwz 0,gi+40@l(9)
	la 3,.LC22@l(3)
	b .L89
.L82:
	lwz 9,84(31)
	lwz 0,716(9)
	mr 11,9
	cmpwi 0,0,2
	bc 12,2,.L85
	lis 9,.LC27@ha
	lfs 13,112(11)
	la 9,.LC27@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L84
.L85:
	lwz 10,1788(11)
	cmpwi 0,10,0
	bc 12,2,.L84
	lis 9,gi+40@ha
	lwz 3,36(10)
	lwz 0,gi+40@l(9)
.L89:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,142(9)
	b .L83
.L84:
	li 0,0
	sth 0,142(11)
.L83:
	mr 3,31
	bl RIP_GetStats
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe4:
	.size	 G_SetStats,.Lfe4-G_SetStats
	.align 2
	.globl Cmd_Help_f
	.type	 Cmd_Help_f,@function
Cmd_Help_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	li 30,0
	lwz 9,84(31)
	stw 30,1920(9)
	lwz 11,84(31)
	stw 30,1924(11)
	lwz 9,84(31)
	lwz 0,1932(9)
	cmpwi 0,0,0
	bc 12,2,.L50
	bl Menu_Close
.L50:
	lwz 9,84(31)
	lwz 0,1916(9)
	cmpwi 0,0,0
	bc 12,2,.L51
	stw 30,1916(9)
	b .L49
.L51:
	li 0,1
	mr 3,31
	stw 0,1916(9)
	lwz 4,540(31)
	bl CTFScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L49:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 Cmd_Help_f,.Lfe5-Cmd_Help_f
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
	stw 30,1920(9)
	lwz 11,84(31)
	stw 30,1924(11)
	lwz 9,84(31)
	lwz 0,1932(9)
	cmpwi 0,0,0
	bc 12,2,.L38
	bl Menu_Close
.L38:
	lwz 9,84(31)
	lwz 0,1916(9)
	cmpwi 0,0,0
	bc 12,2,.L39
	stw 30,1916(9)
	b .L37
.L39:
	li 0,1
	mr 3,31
	stw 0,1916(9)
	lwz 4,540(31)
	bl CTFScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L37:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 Cmd_Score_f,.Lfe6-Cmd_Score_f
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.align 2
	.globl DeathmatchScoreboardMessage
	.type	 DeathmatchScoreboardMessage,@function
DeathmatchScoreboardMessage:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl CTFScoreboardMessage
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe7:
	.size	 DeathmatchScoreboardMessage,.Lfe7-DeathmatchScoreboardMessage
	.align 2
	.globl DeathmatchScoreboard
	.type	 DeathmatchScoreboard,@function
DeathmatchScoreboard:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lwz 4,540(29)
	bl CTFScoreboardMessage
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
.Lfe8:
	.size	 DeathmatchScoreboard,.Lfe8-DeathmatchScoreboard
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
