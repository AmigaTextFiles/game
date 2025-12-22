	.file	"p_hud.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"%s/victory.wav"
	.align 2
.LC1:
	.long 0x0
	.align 2
.LC2:
	.long 0x41000000
	.align 2
.LC3:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl MoveClientToIntermission
	.type	 MoveClientToIntermission,@function
MoveClientToIntermission:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,deathmatch@ha
	lis 5,.LC1@ha
	lwz 11,deathmatch@l(9)
	la 5,.LC1@l(5)
	mr 31,3
	lfs 13,0(5)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L8
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L7
.L8:
	lwz 11,84(31)
	li 0,0
	stw 0,3524(11)
	lwz 9,84(31)
	stw 0,3528(9)
	lwz 11,84(31)
	stw 0,3536(11)
	lwz 9,84(31)
	stw 0,3532(9)
.L7:
	lis 10,level@ha
	lis 9,.LC2@ha
	lwz 6,84(31)
	la 10,level@l(10)
	la 9,.LC2@l(9)
	lfs 0,216(10)
	li 0,4
	lis 5,.LC1@ha
	lfs 9,0(9)
	li 8,0
	la 5,.LC1@l(5)
	lfs 8,0(5)
	li 4,1
	stfs 0,4(31)
	mr 11,9
	mr 7,9
	lfs 0,220(10)
	lis 5,deathmatch@ha
	stfs 0,8(31)
	lfs 13,224(10)
	stfs 13,12(31)
	lfs 0,216(10)
	fmuls 0,0,9
	fctiwz 12,0
	stfd 12,24(1)
	lwz 9,28(1)
	sth 9,4(6)
	lfs 0,220(10)
	lwz 9,84(31)
	fmuls 0,0,9
	fctiwz 11,0
	stfd 11,24(1)
	lwz 11,28(1)
	sth 11,6(9)
	lfs 0,224(10)
	lwz 11,84(31)
	fmuls 0,0,9
	fctiwz 10,0
	stfd 10,24(1)
	lwz 7,28(1)
	sth 7,8(11)
	lfs 0,228(10)
	lwz 9,84(31)
	stfs 0,28(9)
	lfs 0,232(10)
	lwz 11,84(31)
	stfs 0,32(11)
	lfs 13,236(10)
	lwz 9,84(31)
	stfs 13,36(9)
	lwz 11,84(31)
	stw 0,0(11)
	lwz 9,84(31)
	stw 8,88(9)
	lwz 11,84(31)
	stfs 8,108(11)
	lwz 9,84(31)
	lwz 0,116(9)
	rlwinm 0,0,0,0,30
	stw 0,116(9)
	stfs 8,988(31)
	lwz 11,84(31)
	lwz 10,deathmatch@l(5)
	stfs 8,4340(11)
	lwz 9,84(31)
	stfs 8,4344(9)
	lwz 11,84(31)
	stfs 8,4348(11)
	lwz 9,84(31)
	stfs 8,4352(9)
	lwz 11,84(31)
	stw 8,248(31)
	stw 8,512(31)
	stw 8,44(31)
	stw 8,48(31)
	stw 8,40(31)
	stw 8,64(31)
	stw 8,76(31)
	stw 4,4396(11)
	lfs 0,20(10)
	fcmpu 0,0,8
	bc 4,2,.L10
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,8
	bc 12,2,.L9
.L10:
	lis 9,Last_Team_Winner@ha
	lwz 0,Last_Team_Winner@l(9)
	cmpwi 0,0,99
	bc 12,2,.L9
	lis 9,team_list@ha
	slwi 0,0,2
	la 9,team_list@l(9)
	lis 29,gi@ha
	lwzx 4,9,0
	lis 3,.LC0@ha
	la 29,gi@l(29)
	la 3,.LC0@l(3)
	addi 4,4,100
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC3@ha
	lwz 0,16(29)
	lis 11,.LC1@ha
	la 9,.LC3@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC1@l(11)
	li 4,24
	mtlr 0
	lis 9,.LC1@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC1@l(9)
	lfs 3,0(9)
	blrl
.L9:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 MoveClientToIntermission,.Lfe1-MoveClientToIntermission
	.section	".rodata"
	.align 2
.LC4:
	.string	"*"
	.align 2
.LC5:
	.string	"info_player_intermission"
	.align 2
.LC6:
	.string	"info_player_start"
	.align 2
.LC7:
	.string	"info_player_deathmatch"
	.align 2
.LC8:
	.long 0x0
	.align 3
.LC9:
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
	lis 11,.LC8@ha
	lis 9,level+204@ha
	la 11,.LC8@l(11)
	lfs 0,level+204@l(9)
	mr 27,3
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L12
	lis 9,maxclients@ha
	lis 11,game+1560@ha
	lwz 10,maxclients@l(9)
	li 0,0
	li 30,0
	stw 0,game+1560@l(11)
	lis 26,maxclients@ha
	lfs 0,20(10)
	fcmpu 0,13,0
	bc 4,0,.L15
	lis 9,.LC9@ha
	lis 28,g_edicts@ha
	la 9,.LC9@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 31,1016
.L17:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L16
	lwz 0,484(3)
	cmpwi 0,0,0
	bc 12,1,.L16
	bl respawn
.L16:
	addi 30,30,1
	lwz 11,maxclients@l(26)
	xoris 0,30,0x8000
	addi 31,31,1016
	stw 0,12(1)
	stw 29,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L17
.L15:
	lis 9,level@ha
	la 31,level@l(9)
	lfs 0,4(31)
	stfs 0,204(31)
	lwz 0,508(27)
	cmpwi 0,0,0
	stw 0,208(31)
	bc 4,2,.L21
	addi 0,31,72
	stw 0,208(31)
.L21:
	lwz 3,208(31)
	lis 4,.LC4@ha
	la 4,.LC4@l(4)
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L22
	lis 11,.LC8@ha
	lis 9,coop@ha
	la 11,.LC8@l(11)
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L36
	lis 9,maxclients@ha
	li 30,0
	lwz 10,maxclients@l(9)
	lfs 0,20(10)
	fcmpu 0,13,0
	bc 4,0,.L36
	lis 9,g_edicts@ha
	lis 11,itemlist@ha
	lwz 4,g_edicts@l(9)
	la 11,itemlist@l(11)
	mr 5,10
	lis 9,.LC9@ha
	lis 31,0x4330
	la 9,.LC9@l(9)
	lfd 12,0(9)
.L27:
	mulli 9,30,1016
	addi 7,30,1
	addi 9,9,1016
	add 3,4,9
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L26
	li 0,256
	li 6,0
	mtctr 0
	li 8,0
	addi 10,11,56
.L52:
	lwz 0,0(10)
	addi 10,10,104
	andi. 9,0,16
	bc 12,2,.L31
	lwz 9,84(3)
	addi 9,9,740
	stwx 6,9,8
.L31:
	addi 8,8,4
	bdnz .L52
.L26:
	mr 30,7
	lfs 13,20(5)
	xoris 0,30,0x8000
	stw 0,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L27
	b .L36
.L22:
	lis 9,.LC8@ha
	lis 11,deathmatch@ha
	la 9,.LC8@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L36
	li 0,1
	stw 0,212(31)
	b .L12
.L36:
	lis 9,level+212@ha
	li 0,0
	lis 5,.LC5@ha
	stw 0,level+212@l(9)
	li 3,0
	la 5,.LC5@l(5)
	li 4,284
	bl G_Find
	lis 29,.LC5@ha
	mr. 31,3
	bc 4,2,.L38
	lis 5,.LC6@ha
	li 3,0
	la 5,.LC6@l(5)
	li 4,284
	bl G_Find
	mr. 31,3
	bc 4,2,.L40
	lis 5,.LC7@ha
	li 3,0
	la 5,.LC7@l(5)
	li 4,284
	bl G_Find
	mr 31,3
	b .L40
.L38:
	bl rand
	rlwinm 30,3,0,30,31
	b .L41
.L43:
	mr 3,31
	li 4,284
	la 5,.LC5@l(29)
	bl G_Find
	mr. 31,3
	bc 4,2,.L41
	li 3,0
	li 4,284
	la 5,.LC5@l(29)
	bl G_Find
	mr 31,3
.L41:
	cmpwi 0,30,0
	addi 30,30,-1
	bc 4,2,.L43
.L40:
	lfs 0,4(31)
	lis 11,maxclients@ha
	lis 9,level@ha
	lwz 10,maxclients@l(11)
	la 9,level@l(9)
	li 30,0
	lis 11,.LC8@ha
	stfs 0,216(9)
	la 11,.LC8@l(11)
	lfs 0,8(31)
	lfs 12,0(11)
	stfs 0,220(9)
	lfs 13,12(31)
	stfs 13,224(9)
	lfs 0,16(31)
	stfs 0,228(9)
	lfs 13,20(31)
	stfs 13,232(9)
	lfs 0,24(31)
	stfs 0,236(9)
	lfs 13,20(10)
	fcmpu 0,12,13
	bc 4,0,.L12
	lis 9,.LC9@ha
	lis 28,g_edicts@ha
	la 9,.LC9@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 31,1016
.L49:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L48
	bl MoveClientToIntermission
.L48:
	addi 30,30,1
	lwz 11,maxclients@l(26)
	xoris 0,30,0x8000
	addi 31,31,1016
	stw 0,12(1)
	stw 29,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L49
.L12:
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
.LC10:
	.string	"teams/%s"
	.section	".text"
	.align 2
	.globl TeamStats
	.type	 TeamStats,@function
TeamStats:
	stwu 1,-48(1)
	mflr 0
	stmw 22,8(1)
	stw 0,52(1)
	lis 9,gi@ha
	mr 28,3
	la 22,gi@l(9)
	li 25,0
	lis 23,team_list@ha
	lis 24,.LC10@ha
	li 26,0
.L57:
	cmpwi 0,25,0
	bc 4,2,.L58
	li 31,22
	li 30,23
	li 29,24
	b .L59
.L58:
	cmpwi 0,25,1
	bc 4,2,.L53
	li 31,25
	li 30,26
	li 29,27
.L59:
	la 27,team_list@l(23)
	lwzx 4,26,27
	cmpwi 0,4,0
	bc 12,2,.L62
	addi 4,4,100
	la 3,.LC10@l(24)
	crxor 6,6,6
	bl va
	lwz 9,40(22)
	mtlr 9
	blrl
	lwz 9,84(28)
	add 0,31,31
	add 10,30,30
	add 8,29,29
	addi 9,9,120
	sthx 3,9,0
	lwzx 11,26,27
	lwz 9,84(28)
	lhz 0,78(11)
	addi 9,9,120
	sthx 0,9,10
	lwzx 11,26,27
	lwz 9,84(28)
	lhz 0,90(11)
	addi 9,9,120
	sthx 0,9,8
	b .L56
.L62:
	lwz 11,84(28)
	add 0,31,31
	add 10,30,30
	add 8,29,29
	addi 11,11,120
	sthx 4,11,0
	lwz 9,84(28)
	addi 9,9,120
	sthx 4,9,10
	lwz 11,84(28)
	addi 11,11,120
	sthx 4,11,8
.L56:
	addi 25,25,1
	addi 26,26,4
	cmpwi 0,25,1
	bc 4,1,.L57
.L53:
	lwz 0,52(1)
	mtlr 0
	lmw 22,8(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 TeamStats,.Lfe3-TeamStats
	.section	".rodata"
	.align 2
.LC11:
	.string	"easy"
	.align 2
.LC12:
	.string	"medium"
	.align 2
.LC13:
	.string	"hard"
	.align 2
.LC14:
	.string	"hard+"
	.align 2
.LC15:
	.string	"xv 32 yv 8 picn help xv 202 yv 12 string2 \"%s\" xv 0 yv 24 cstring2 \"%s\" xv 0 yv 54 cstring2 \"%s\" xv 0 yv 110 cstring2 \"%s\" xv 50 yv 164 string2 \" kills     goals    secrets\" xv 50 yv 172 string2 \"%3i/%3i     %i/%i       %i/%i\" "
	.align 2
.LC16:
	.long 0x0
	.align 2
.LC17:
	.long 0x3f800000
	.align 2
.LC18:
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
	lis 11,.LC16@ha
	lis 9,skill@ha
	la 11,.LC16@l(11)
	mr 31,3
	lfs 0,0(11)
	lwz 11,skill@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 4,2,.L74
	lis 9,.LC11@ha
	la 6,.LC11@l(9)
	b .L75
.L74:
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L76
	lis 9,.LC12@ha
	la 6,.LC12@l(9)
	b .L75
.L76:
	lis 11,.LC18@ha
	la 11,.LC18@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L78
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L75
.L78:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
.L75:
	lis 11,level@ha
	lis 8,game@ha
	la 11,level@l(11)
	la 8,game@l(8)
	lwz 0,276(11)
	lis 5,.LC15@ha
	addi 9,8,512
	lwz 29,272(11)
	li 4,1024
	addi 3,1,32
	lwz 26,288(11)
	addi 7,11,8
	la 5,.LC15@l(5)
	lwz 27,284(11)
	lwz 28,280(11)
	lwz 10,292(11)
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
.Lfe4:
	.size	 HelpComputer,.Lfe4-HelpComputer
	.section	".rodata"
	.align 2
.LC19:
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
	lis 9,.LC19@ha
	lis 29,deathmatch@ha
	la 9,.LC19@l(9)
	mr 31,3
	lfs 31,0(9)
	lwz 9,deathmatch@l(29)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L81
	lwz 11,84(31)
	li 30,0
	stw 30,3528(11)
	lwz 9,84(31)
	stw 30,3536(9)
	lwz 11,84(31)
	lwz 0,3548(11)
	cmpwi 0,0,0
	bc 12,2,.L82
	bl PMenu_Close
.L82:
	lwz 9,deathmatch@l(29)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 4,2,.L83
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L80
.L83:
	lwz 9,84(31)
	li 11,1
	stw 11,3524(9)
	lwz 9,84(31)
	lwz 0,3524(9)
	cmpwi 0,0,0
	bc 12,2,.L85
	lwz 0,3532(9)
	cmpwi 0,0,0
	bc 12,2,.L86
	stw 30,3524(9)
	lwz 9,84(31)
	stw 30,3532(9)
	b .L80
.L86:
	stw 11,3532(9)
.L85:
	mr 3,31
	bl DDayScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L80
.L81:
	lwz 9,84(31)
	li 8,0
	stw 8,3528(9)
	lwz 11,84(31)
	stw 8,3524(11)
	lwz 10,84(31)
	lwz 0,3536(10)
	cmpwi 0,0,0
	bc 12,2,.L89
	lis 9,game+1024@ha
	lwz 11,3440(10)
	lwz 0,game+1024@l(9)
	cmpw 0,11,0
	bc 4,2,.L89
	stw 8,3536(10)
	b .L80
.L89:
	lwz 11,84(31)
	li 0,1
	li 10,0
	mr 3,31
	stw 0,3536(11)
	lwz 9,84(31)
	stw 10,3444(9)
	bl HelpComputer
.L80:
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 Cmd_Help_f,.Lfe5-Cmd_Help_f
	.section	".rodata"
	.align 2
.LC20:
	.string	"s_00"
	.align 2
.LC21:
	.string	"s_%i"
	.align 2
.LC22:
	.string	"i_dday"
	.align 2
.LC23:
	.string	"i_respcount"
	.align 2
.LC24:
	.string	"objectives\\"
	.align 2
.LC25:
	.string	"scope_%s"
	.align 2
.LC26:
	.string	"crosshair"
	.align 2
.LC27:
	.string	"i_help"
	.align 3
.LC28:
	.long 0x40240000
	.long 0x0
	.align 2
.LC29:
	.long 0x0
	.align 3
.LC30:
	.long 0x3ff80000
	.long 0x0
	.align 2
.LC31:
	.long 0x42ac0000
	.section	".text"
	.align 2
	.globl G_SetStats
	.type	 G_SetStats,@function
G_SetStats:
	stwu 1,-80(1)
	mflr 0
	stmw 29,68(1)
	stw 0,84(1)
	lis 9,level+270@ha
	mr 31,3
	lhz 0,level+270@l(9)
	lis 30,level@ha
	lwz 9,84(31)
	sth 0,120(9)
	lwz 11,84(31)
	lhz 0,486(31)
	sth 0,122(11)
	lwz 9,84(31)
	lwz 3,1796(9)
	cmpwi 0,3,0
	bc 12,2,.L91
	lwz 3,36(3)
	cmpwi 0,3,0
	bc 12,2,.L91
	lis 9,gi+40@ha
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,132(9)
	b .L92
.L91:
	lwz 9,84(31)
	li 0,0
	sth 0,132(9)
.L92:
	lwz 9,84(31)
	lwz 3,1796(9)
	cmpwi 0,3,0
	bc 12,2,.L93
	lwz 3,52(3)
	cmpwi 0,3,0
	bc 12,2,.L93
	bl FindItem
	mr. 3,3
	bc 12,2,.L94
	lis 9,itemlist@ha
	lis 0,0xc4ec
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,20165
	subf 9,9,3
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	add 9,11,9
	lhz 0,742(9)
	sth 0,130(11)
	lwz 29,84(31)
	lwz 0,4496(29)
	cmpwi 0,0,0
	bc 12,2,.L95
	lwz 3,36(3)
	cmpwi 0,3,0
	bc 12,2,.L96
	lis 9,gi+40@ha
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
	b .L97
.L96:
	li 3,0
.L97:
	sth 3,128(29)
	lwz 9,84(31)
	lwz 11,4496(9)
	lhz 0,2(11)
	sth 0,126(9)
	b .L100
.L95:
	sth 0,128(29)
	lwz 9,84(31)
	sth 0,126(9)
	b .L100
.L94:
	lwz 9,84(31)
	sth 3,130(9)
	lwz 11,84(31)
	sth 3,128(11)
	lwz 9,84(31)
	sth 3,126(9)
	b .L100
.L93:
	lwz 11,84(31)
	li 0,0
	sth 0,130(11)
	lwz 9,84(31)
	sth 0,128(9)
	lwz 11,84(31)
	sth 0,126(11)
.L100:
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,4376(11)
	fcmpu 0,13,0
	bc 4,1,.L101
	li 0,0
	sth 0,134(11)
	lwz 9,84(31)
	sth 0,136(9)
.L101:
	lwz 9,84(31)
	lis 11,.LC28@ha
	la 11,.LC28@l(11)
	lfs 0,4668(9)
	lfd 13,0(11)
	lis 11,gi@ha
	la 29,gi@l(11)
	fcmpu 0,0,13
	bc 4,0,.L102
	lis 9,.LC20@ha
	la 3,.LC20@l(9)
	b .L103
.L102:
	fdiv 13,0,13
	lis 3,.LC21@ha
	la 3,.LC21@l(3)
	fctiwz 0,13
	stfd 0,56(1)
	lwz 4,60(1)
	mulli 4,4,10
	crxor 6,6,6
	bl va
.L103:
	lwz 0,40(29)
	lis 29,level_wait@ha
	mtlr 0
	blrl
	lwz 8,84(31)
	lis 11,level@ha
	lwz 10,level_wait@l(29)
	sth 3,176(8)
	lfs 0,20(10)
	lwz 11,level@l(11)
	fctiwz 13,0
	stfd 13,56(1)
	lwz 9,60(1)
	mulli 9,9,10
	cmpw 0,11,9
	bc 4,0,.L104
	lis 9,gi+40@ha
	lis 3,.LC22@ha
	lwz 0,gi+40@l(9)
	la 3,.LC22@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	lis 0,0x6666
	lwz 10,level_wait@l(29)
	ori 0,0,26215
	sth 3,138(9)
	lfs 0,20(10)
	lwz 9,level@l(30)
	lwz 10,84(31)
	mulhw 0,9,0
	srawi 9,9,31
	srawi 0,0,2
	fctiwz 13,0
	subf 0,9,0
	stfd 13,56(1)
	lwz 11,60(1)
	subf 11,0,11
	sth 11,140(10)
	b .L105
.L104:
	lwz 9,84(31)
	lwz 0,4556(9)
	cmpw 0,11,0
	bc 12,1,.L106
	lis 9,gi+40@ha
	lis 3,.LC23@ha
	lwz 0,gi+40@l(9)
	la 3,.LC23@l(3)
	mtlr 0
	blrl
	lwz 11,84(31)
	lis 9,0x6666
	ori 9,9,26215
	sth 3,138(11)
	lwz 10,84(31)
	lwz 11,level@l(30)
	lwz 0,4556(10)
	subf 0,11,0
	mulhw 9,0,9
	srawi 0,0,31
	srawi 9,9,2
	subf 9,0,9
	sth 9,140(10)
	b .L105
.L106:
	li 0,0
	sth 0,138(9)
	lwz 9,84(31)
	sth 0,140(9)
.L105:
	lwz 9,84(31)
	lwz 0,4524(9)
	cmpwi 0,0,0
	bc 12,2,.L108
	lis 9,.LC24@ha
	addi 29,1,8
	lwz 10,.LC24@l(9)
	lis 4,level+72@ha
	mr 3,29
	la 9,.LC24@l(9)
	la 4,level+72@l(4)
	lwz 11,8(9)
	lwz 0,4(9)
	stw 10,8(1)
	stw 0,4(29)
	stw 11,8(29)
	bl strcat
	lis 9,gi+40@ha
	mr 3,29
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,152(9)
	b .L109
.L108:
	sth 0,152(9)
.L109:
	lwz 11,84(31)
	lwz 0,4528(11)
	cmpwi 0,0,0
	bc 12,2,.L110
	lwz 9,1796(11)
	cmpwi 0,9,0
	bc 12,2,.L110
	lwz 0,68(9)
	cmpwi 0,0,10
	bc 4,2,.L110
	lwz 4,3448(11)
	lis 29,gi@ha
	lis 3,.LC25@ha
	la 29,gi@l(29)
	la 3,.LC25@l(3)
	addi 4,4,100
	crxor 6,6,6
	bl va
	lwz 0,40(29)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,162(9)
	b .L111
.L110:
	lwz 9,84(31)
	li 0,0
	sth 0,162(9)
.L111:
	lwz 9,84(31)
	lwz 0,4528(9)
	cmpwi 0,0,0
	bc 12,2,.L112
	lwz 9,1796(9)
	cmpwi 0,9,0
	bc 12,2,.L112
	lwz 0,68(9)
	cmpwi 0,0,10
	bc 12,2,.L112
	lis 9,gi+40@ha
	lis 3,.LC26@ha
	lwz 0,gi+40@l(9)
	la 3,.LC26@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,178(9)
	b .L113
.L112:
	lwz 9,84(31)
	li 0,0
	sth 0,178(9)
.L113:
	lwz 11,84(31)
	lis 9,deathmatch@ha
	li 10,0
	lwz 8,deathmatch@l(9)
	lhz 0,738(11)
	lis 9,.LC29@ha
	la 9,.LC29@l(9)
	sth 0,144(11)
	lfs 13,0(9)
	lwz 9,84(31)
	sth 10,146(9)
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L114
	lwz 9,84(31)
	lwz 0,724(9)
	cmpwi 0,0,0
	bc 4,1,.L116
	lwz 0,3524(9)
	cmpwi 0,0,0
	bc 4,2,.L116
	lis 9,level@ha
	la 9,level@l(9)
	lfs 0,204(9)
	fcmpu 0,0,13
	bc 12,2,.L119
	lis 11,.LC30@ha
	lfs 13,4(9)
	la 11,.LC30@l(11)
	lfd 12,0(11)
	fadd 0,0,12
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L119
.L116:
	lwz 9,84(31)
	b .L120
.L114:
	lwz 9,84(31)
	lwz 0,3524(9)
	cmpwi 0,0,0
	bc 4,2,.L120
	lwz 0,3536(9)
	cmpwi 0,0,0
	bc 12,2,.L119
.L120:
	lhz 0,146(9)
	ori 0,0,1
	sth 0,146(9)
.L119:
	lwz 9,84(31)
	lwz 0,3528(9)
	cmpwi 0,0,0
	bc 12,2,.L118
	lwz 0,724(9)
	cmpwi 0,0,0
	bc 4,1,.L118
	lhz 0,146(9)
	ori 0,0,2
	sth 0,146(9)
.L118:
	lwz 9,84(31)
	lwz 0,3444(9)
	mr 10,9
	cmpwi 0,0,0
	bc 12,2,.L122
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L122
	lis 9,gi+40@ha
	lis 3,.LC27@ha
	lwz 0,gi+40@l(9)
	la 3,.LC27@l(3)
	b .L127
.L122:
	lwz 0,716(10)
	cmpwi 0,0,2
	bc 12,2,.L125
	lis 9,.LC31@ha
	lfs 13,112(10)
	la 9,.LC31@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L124
.L125:
	lwz 11,1796(10)
	cmpwi 0,11,0
	bc 12,2,.L124
	lis 9,gi+40@ha
	lwz 3,36(11)
	lwz 0,gi+40@l(9)
.L127:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,142(9)
	b .L123
.L124:
	li 0,0
	sth 0,142(10)
.L123:
	mr 3,31
	bl TeamStats
	lwz 0,84(1)
	mtlr 0
	lmw 29,68(1)
	la 1,80(1)
	blr
.Lfe6:
	.size	 G_SetStats,.Lfe6-G_SetStats
	.section	".rodata"
	.align 2
.LC32:
	.string	"usa"
	.align 2
.LC33:
	.string	"grm"
	.align 2
.LC34:
	.string	"xv 0  yv   0 picn scorehead  yv 80 xv   0 picn scoreleft        xv 160 picn scoreright "
	.align 2
.LC35:
	.string	"yv 80 xv   0 picn "
	.align 2
.LC36:
	.string	"_score  "
	.align 2
.LC37:
	.string	"      xv 160 picn "
	.align 2
.LC38:
	.string	"xv 0  yv   0 picn "
	.align 2
.LC39:
	.string	"_score_top  "
	.align 2
.LC40:
	.string	"xv 0  xv 160 picn "
	.align 2
.LC41:
	.string	"xv 52  yv 31 num 2 23 xv 100 yv 31 num 3 24 xv 208 yv 31 num 2 26 xv 256 yv 31 num 3 27 xv 0   yv 67 string  \" Ping Player         Ping Player\" "
	.align 2
.LC42:
	.string	"xv 0 yv -80 picn victory_%s "
	.align 2
.LC43:
	.string	"yv %d "
	.align 2
.LC44:
	.string	"xv 0 string \"  %3d %-13.13s\" "
	.align 2
.LC45:
	.string	"%s%s"
	.align 2
.LC46:
	.string	"+"
	.align 2
.LC47:
	.string	""
	.align 2
.LC48:
	.string	"xv 160 string \"  %3d %-13.13s\" "
	.align 2
.LC49:
	.string	"xv 8 yv %d string \"..and %d more\" "
	.align 2
.LC50:
	.string	"xv 168 yv %d string \"..and %d more\" "
	.align 2
.LC51:
	.long 0x0
	.section	".text"
	.align 2
	.globl DDayScoreboardMessage
	.type	 DDayScoreboardMessage,@function
DDayScoreboardMessage:
	stwu 1,-7648(1)
	mflr 0
	stmw 17,7588(1)
	stw 0,7652(1)
	lis 9,game@ha
	li 25,0
	la 10,game@l(9)
	li 0,0
	lwz 11,1544(10)
	addi 9,1,7560
	li 31,0
	stw 0,4(9)
	mr 18,9
	li 30,0
	cmpw 0,25,11
	stw 0,7560(1)
	addi 21,1,1032
	bc 4,0,.L130
	lis 9,g_edicts@ha
	mr 12,10
	lwz 19,g_edicts@l(9)
	mr 23,18
	addi 20,1,4488
	mr 17,18
.L132:
	mulli 9,25,1016
	addi 22,25,1
	addi 9,9,1016
	add 9,19,9
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L131
	lwz 0,996(9)
	cmpwi 0,0,0
	bc 4,2,.L131
	lwz 9,1028(12)
	mulli 0,25,4732
	add 11,0,9
	lwz 9,3448(11)
	cmpwi 0,9,0
	bc 12,2,.L131
	lwz 10,84(9)
	li 29,0
	addi 4,1,4488
	lwz 26,3424(11)
	addi 28,1,2440
	slwi 9,10,2
	lwzx 0,9,23
	cmpw 0,29,0
	bc 4,0,.L138
	slwi 0,10,10
	mr 3,9
	lwzx 9,20,0
	mr 6,0
	cmpw 0,26,9
	bc 12,1,.L138
	lwzx 9,3,17
	add 11,6,4
.L139:
	addi 29,29,1
	cmpw 0,29,9
	bc 4,0,.L138
	lwzu 0,4(11)
	cmpw 0,26,0
	bc 4,1,.L139
.L138:
	slwi 0,10,2
	slwi 6,10,10
	lwzx 7,23,0
	mr 3,0
	slwi 24,29,2
	cmpw 0,7,29
	bc 4,1,.L144
	addi 11,28,-4
	slwi 9,7,2
	add 11,6,11
	addi 0,4,-4
	add 0,6,0
	add 10,9,11
	mr 27,28
	add 8,9,0
	add 11,9,6
	mr 5,4
.L146:
	lwz 9,0(10)
	addi 7,7,-1
	cmpw 0,7,29
	addi 10,10,-4
	stwx 9,11,27
	lwz 0,0(8)
	addi 8,8,-4
	stwx 0,11,5
	addi 11,11,-4
	bc 12,1,.L146
.L144:
	add 0,24,6
	stwx 25,28,0
	stwx 26,4,0
	lwzx 9,3,23
	addi 9,9,1
	stwx 9,3,23
.L131:
	lwz 0,1544(12)
	mr 25,22
	cmpw 0,25,0
	bc 12,0,.L132
.L130:
	lis 9,team_list@ha
	li 0,0
	lwz 3,team_list@l(9)
	lis 4,.LC32@ha
	la 29,team_list@l(9)
	stb 0,1032(1)
	la 4,.LC32@l(4)
	addi 3,3,100
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L149
	lwz 3,4(29)
	lis 4,.LC33@ha
	la 4,.LC33@l(4)
	addi 3,3,100
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L149
	lis 4,.LC34@ha
	mr 3,21
	la 4,.LC34@l(4)
	crxor 6,6,6
	bl sprintf
	b .L150
.L149:
	lis 9,.LC35@ha
	lis 25,team_list@ha
	lwz 7,.LC35@l(9)
	addi 26,1,6536
	addi 27,1,6792
	la 9,.LC35@l(9)
	lwz 4,team_list@l(25)
	addi 29,1,7048
	lbz 6,18(9)
	addi 28,1,7304
	mr 3,26
	lwz 8,4(9)
	addi 4,4,100
	lis 24,.LC36@ha
	lwz 10,8(9)
	la 23,team_list@l(25)
	lis 22,.LC39@ha
	lwz 11,12(9)
	lhz 0,16(9)
	stw 7,6536(1)
	stw 8,4(26)
	stw 10,8(26)
	stw 11,12(26)
	sth 0,16(26)
	stb 6,18(26)
	bl strcat
	la 4,.LC36@l(24)
	mr 3,26
	bl strcat
	lis 9,.LC37@ha
	lwz 4,4(23)
	mr 3,27
	lwz 7,.LC37@l(9)
	la 9,.LC37@l(9)
	addi 4,4,100
	lbz 6,18(9)
	lwz 0,4(9)
	lwz 11,8(9)
	lwz 10,12(9)
	lhz 8,16(9)
	stw 7,6792(1)
	stw 0,4(27)
	stw 11,8(27)
	stw 10,12(27)
	sth 8,16(27)
	stb 6,18(27)
	bl strcat
	la 4,.LC36@l(24)
	mr 3,27
	bl strcat
	lis 9,.LC38@ha
	lwz 4,team_list@l(25)
	mr 3,29
	lwz 7,.LC38@l(9)
	la 9,.LC38@l(9)
	addi 4,4,100
	lbz 6,18(9)
	lwz 0,4(9)
	lwz 11,8(9)
	lwz 10,12(9)
	lhz 8,16(9)
	stw 7,7048(1)
	stw 0,4(29)
	stw 11,8(29)
	stw 10,12(29)
	sth 8,16(29)
	stb 6,18(29)
	bl strcat
	la 4,.LC39@l(22)
	mr 3,29
	bl strcat
	lis 9,.LC40@ha
	lwz 4,4(23)
	mr 3,28
	lwz 7,.LC40@l(9)
	la 9,.LC40@l(9)
	addi 4,4,100
	lbz 6,18(9)
	lwz 0,4(9)
	lwz 11,8(9)
	lwz 10,12(9)
	lhz 8,16(9)
	stw 7,7304(1)
	stw 0,4(28)
	stw 11,8(28)
	stw 10,12(28)
	sth 8,16(28)
	stb 6,18(28)
	bl strcat
	la 4,.LC39@l(22)
	mr 3,28
	bl strcat
	mr 4,29
	mr 3,21
	crxor 6,6,6
	bl sprintf
	mr 4,28
	mr 3,21
	bl strcat
	mr 4,26
	mr 3,21
	bl strcat
	mr 4,27
	mr 3,21
	bl strcat
.L150:
	lis 4,.LC41@ha
	mr 3,21
	la 4,.LC41@l(4)
	bl strcat
	lis 11,.LC51@ha
	lis 9,level+204@ha
	la 11,.LC51@l(11)
	lfs 0,level+204@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,2,.L151
	lis 9,Last_Team_Winner@ha
	lwz 0,Last_Team_Winner@l(9)
	cmpwi 0,0,99
	bc 12,2,.L151
	lis 9,team_list@ha
	slwi 0,0,2
	la 9,team_list@l(9)
	lis 3,.LC42@ha
	lwzx 4,9,0
	la 3,.LC42@l(3)
	addi 4,4,100
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,21
	bl strcat
.L151:
	mr 3,21
	li 25,0
	bl strlen
	lwz 0,7560(1)
	mr 27,3
	b .L171
.L156:
	slwi 5,25,3
	lis 4,.LC43@ha
	la 4,.LC43@l(4)
	addi 5,5,84
	addi 3,1,8
	subfic 29,27,1000
	crxor 6,6,6
	bl sprintf
	addi 3,1,8
	bl strlen
	cmplw 0,29,3
	bc 4,1,.L157
	addi 4,1,8
	mr 3,21
	bl strcat
	mr 3,21
	bl strlen
	mr 27,3
.L157:
	lwz 0,7560(1)
	cmpw 0,25,0
	bc 4,0,.L158
	addi 9,1,2440
	slwi 11,25,2
	lwzx 0,9,11
	lis 10,game+1028@ha
	addi 3,1,8
	lwz 9,game+1028@l(10)
	mulli 0,0,4732
	add 29,9,0
	bl strlen
	lwz 28,184(29)
	addi 0,1,8
	lwz 9,3464(29)
	add 26,0,3
	cmpwi 7,28,1000
	cmpwi 6,9,8
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 0,28,0
	andi. 9,9,999
	or 28,0,9
	bc 4,26,.L160
	lis 9,.LC46@ha
	la 4,.LC46@l(9)
	b .L161
.L160:
	lis 9,.LC47@ha
	la 4,.LC47@l(9)
.L161:
	lis 3,.LC45@ha
	addi 5,29,700
	la 3,.LC45@l(3)
	subfic 29,27,1000
	crxor 6,6,6
	bl va
	mr 6,3
	lis 4,.LC44@ha
	la 4,.LC44@l(4)
	mr 5,28
	mr 3,26
	crxor 6,6,6
	bl sprintf
	addi 3,1,8
	bl strlen
	cmplw 0,29,3
	bc 4,1,.L158
	addi 4,1,8
	mr 3,21
	bl strcat
	mr 30,25
	mr 3,21
	bl strlen
	mr 27,3
.L158:
	lwz 0,4(18)
	cmpw 0,25,0
	bc 4,0,.L154
	addi 9,1,3464
	slwi 11,25,2
	lwzx 0,9,11
	lis 10,game+1028@ha
	addi 3,1,8
	lwz 9,game+1028@l(10)
	mulli 0,0,4732
	add 29,9,0
	bl strlen
	lwz 28,184(29)
	addi 0,1,8
	lwz 9,3464(29)
	add 26,0,3
	cmpwi 7,28,1000
	cmpwi 6,9,8
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 0,28,0
	andi. 9,9,999
	or 28,0,9
	bc 4,26,.L165
	lis 9,.LC46@ha
	la 4,.LC46@l(9)
	b .L166
.L165:
	lis 9,.LC47@ha
	la 4,.LC47@l(9)
.L166:
	lis 3,.LC45@ha
	addi 5,29,700
	la 3,.LC45@l(3)
	subfic 29,27,1000
	crxor 6,6,6
	bl va
	mr 6,3
	lis 4,.LC48@ha
	la 4,.LC48@l(4)
	mr 5,28
	mr 3,26
	crxor 6,6,6
	bl sprintf
	addi 3,1,8
	bl strlen
	cmplw 0,29,3
	bc 4,1,.L154
	addi 4,1,8
	mr 3,21
	bl strcat
	mr 31,25
	mr 3,21
	bl strlen
	mr 27,3
.L154:
	addi 25,25,1
	cmpwi 0,25,15
	bc 12,1,.L153
	lwz 0,7560(1)
.L171:
	cmpw 0,25,0
	bc 12,0,.L156
	lwz 0,4(18)
	cmpw 0,25,0
	bc 12,0,.L156
.L153:
	lwz 0,7560(1)
	subf 0,30,0
	cmpwi 0,0,1
	bc 4,1,.L169
	mr 3,21
	bl strlen
	lwz 6,7560(1)
	slwi 5,30,3
	lis 4,.LC49@ha
	la 4,.LC49@l(4)
	addi 5,5,92
	subf 6,30,6
	add 3,21,3
	addi 6,6,-1
	crxor 6,6,6
	bl sprintf
.L169:
	lwz 0,4(18)
	subf 0,31,0
	cmpwi 0,0,1
	bc 4,1,.L170
	mr 3,21
	bl strlen
	lwz 6,4(18)
	slwi 5,31,3
	lis 4,.LC50@ha
	la 4,.LC50@l(4)
	addi 5,5,92
	subf 6,31,6
	add 3,21,3
	addi 6,6,-1
	crxor 6,6,6
	bl sprintf
.L170:
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,116(29)
	mr 3,21
	mtlr 0
	blrl
	lwz 0,7652(1)
	mtlr 0
	lmw 17,7588(1)
	la 1,7648(1)
	blr
.Lfe7:
	.size	 DDayScoreboardMessage,.Lfe7-DDayScoreboardMessage
	.comm	is_silenced,1,1
	.section	".rodata"
	.align 2
.LC52:
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
	stw 30,3528(9)
	lwz 11,84(31)
	stw 30,3536(11)
	lwz 9,84(31)
	lwz 0,3548(9)
	cmpwi 0,0,0
	bc 12,2,.L67
	bl PMenu_Close
.L67:
	lis 11,.LC52@ha
	lis 9,deathmatch@ha
	la 11,.LC52@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L68
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L66
.L68:
	lwz 9,84(31)
	li 11,1
	stw 11,3524(9)
	lwz 9,84(31)
	lwz 0,3524(9)
	cmpwi 0,0,0
	bc 12,2,.L69
	lwz 0,3532(9)
	cmpwi 0,0,0
	bc 12,2,.L70
	stw 30,3524(9)
	lwz 9,84(31)
	stw 30,3532(9)
	b .L66
.L70:
	stw 11,3532(9)
.L69:
	mr 3,31
	bl DDayScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L66:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 Cmd_Score_f,.Lfe8-Cmd_Score_f
	.comm	maplist,1060,4
	.comm	team_list,8,4
	.align 2
	.globl DeathmatchScoreboard
	.type	 DeathmatchScoreboard,@function
DeathmatchScoreboard:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl DDayScoreboardMessage
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
.Lfe9:
	.size	 DeathmatchScoreboard,.Lfe9-DeathmatchScoreboard
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
