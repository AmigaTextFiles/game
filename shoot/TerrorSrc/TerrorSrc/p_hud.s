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
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 9,deathmatch@ha
	lis 5,.LC0@ha
	lwz 11,deathmatch@l(9)
	la 5,.LC0@l(5)
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
	lwz 9,84(31)
	li 0,1
	stw 0,3616(9)
.L7:
	lis 10,level@ha
	lis 9,.LC1@ha
	lwz 6,84(31)
	la 10,level@l(10)
	la 9,.LC1@l(9)
	lfs 0,212(10)
	li 0,4
	lis 5,.LC0@ha
	lfs 9,0(9)
	li 8,0
	la 5,.LC0@l(5)
	lfs 8,0(5)
	stfs 0,4(31)
	mr 11,9
	mr 7,9
	lfs 0,216(10)
	lis 5,deathmatch@ha
	stfs 0,8(31)
	lfs 13,220(10)
	stfs 13,12(31)
	lfs 0,212(10)
	fmuls 0,0,9
	fctiwz 12,0
	stfd 12,16(1)
	lwz 9,20(1)
	sth 9,4(6)
	lfs 0,216(10)
	lwz 9,84(31)
	fmuls 0,0,9
	fctiwz 11,0
	stfd 11,16(1)
	lwz 11,20(1)
	sth 11,6(9)
	lfs 0,220(10)
	lwz 11,84(31)
	fmuls 0,0,9
	fctiwz 10,0
	stfd 10,16(1)
	lwz 7,20(1)
	sth 7,8(11)
	lfs 0,224(10)
	lwz 9,84(31)
	stfs 0,28(9)
	lfs 0,228(10)
	lwz 11,84(31)
	stfs 0,32(11)
	lfs 13,232(10)
	lwz 9,84(31)
	stfs 13,36(9)
	lwz 11,84(31)
	stw 0,0(11)
	lwz 9,84(31)
	stw 8,88(9)
	lwz 11,84(31)
	stfs 8,108(11)
	lwz 10,84(31)
	lwz 0,116(10)
	rlwinm 0,0,0,0,30
	stw 0,116(10)
	lwz 9,84(31)
	stfs 8,3836(9)
	lwz 11,84(31)
	lwz 10,deathmatch@l(5)
	stfs 8,3840(11)
	lwz 9,84(31)
	stfs 8,3844(9)
	lwz 11,84(31)
	stfs 8,3848(11)
	lwz 9,84(31)
	stw 8,3852(9)
	lwz 11,84(31)
	stfs 8,3856(11)
	stw 8,248(31)
	stw 8,508(31)
	stw 8,44(31)
	stw 8,48(31)
	stw 8,40(31)
	stw 8,64(31)
	stw 8,76(31)
	lfs 0,20(10)
	fcmpu 0,0,8
	bc 4,2,.L10
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,8
	bc 12,2,.L9
.L10:
	mr 3,31
	li 4,0
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L9:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
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
	mr 27,3
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L11
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L13
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L13
	bl CTFCalcScores
.L13:
	lis 9,maxclients@ha
	lis 11,game+1560@ha
	lwz 10,maxclients@l(9)
	li 0,0
	li 30,0
	lis 9,.LC6@ha
	stw 0,game+1560@l(11)
	lis 26,maxclients@ha
	la 9,.LC6@l(9)
	lfs 0,20(10)
	lfs 13,0(9)
	fcmpu 0,13,0
	bc 4,0,.L15
	lis 11,.LC7@ha
	lis 28,g_edicts@ha
	la 11,.LC7@l(11)
	lis 29,0x4330
	lfd 31,0(11)
	li 31,928
.L17:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L16
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 12,1,.L16
	bl respawn
.L16:
	addi 30,30,1
	lwz 11,maxclients@l(26)
	xoris 0,30,0x8000
	addi 31,31,928
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
	lis 4,.LC2@ha
	la 31,level@l(9)
	la 4,.LC2@l(4)
	lfs 0,4(31)
	stfs 0,200(31)
	lwz 0,504(27)
	mr 3,0
	stw 0,204(31)
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L21
	lis 11,.LC6@ha
	lis 9,coop@ha
	la 11,.LC6@l(11)
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L35
	lis 9,maxclients@ha
	li 30,0
	lwz 10,maxclients@l(9)
	lfs 0,20(10)
	fcmpu 0,13,0
	bc 4,0,.L35
	lis 9,g_edicts@ha
	lis 11,itemlist@ha
	lwz 4,g_edicts@l(9)
	la 11,itemlist@l(11)
	mr 5,10
	lis 9,.LC7@ha
	lis 31,0x4330
	la 9,.LC7@l(9)
	lfd 12,0(9)
.L26:
	mulli 9,30,928
	addi 7,30,1
	addi 9,9,928
	add 3,4,9
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L25
	li 0,256
	li 6,0
	mtctr 0
	li 8,0
	addi 10,11,56
.L51:
	lwz 0,0(10)
	addi 10,10,76
	andi. 9,0,16
	bc 12,2,.L30
	lwz 9,84(3)
	addi 9,9,740
	stwx 6,9,8
.L30:
	addi 8,8,4
	bdnz .L51
.L25:
	mr 30,7
	lfs 13,20(5)
	xoris 0,30,0x8000
	stw 0,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L26
	b .L35
.L21:
	lis 9,.LC6@ha
	lis 11,deathmatch@ha
	la 9,.LC6@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L35
	li 0,1
	stw 0,208(31)
	b .L11
.L35:
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
	bc 4,2,.L37
	lis 5,.LC4@ha
	li 3,0
	la 5,.LC4@l(5)
	li 4,280
	bl G_Find
	mr. 31,3
	bc 4,2,.L39
	lis 5,.LC5@ha
	li 3,0
	la 5,.LC5@l(5)
	li 4,280
	bl G_Find
	mr 31,3
	b .L39
.L37:
	bl rand
	rlwinm 30,3,0,30,31
	b .L40
.L42:
	mr 3,31
	li 4,280
	la 5,.LC3@l(29)
	bl G_Find
	mr. 31,3
	bc 4,2,.L40
	li 3,0
	li 4,280
	la 5,.LC3@l(29)
	bl G_Find
	mr 31,3
.L40:
	cmpwi 0,30,0
	addi 30,30,-1
	bc 4,2,.L42
.L39:
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
	li 31,928
.L48:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L47
	bl MoveClientToIntermission
.L47:
	addi 30,30,1
	lwz 11,maxclients@l(26)
	xoris 0,30,0x8000
	addi 31,31,928
	stw 0,12(1)
	stw 29,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L48
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
	.string	"i_fixme"
	.align 2
.LC9:
	.string	"tag1"
	.align 2
.LC10:
	.string	"tag2"
	.align 2
.LC11:
	.string	"xv %i yv %i picn %s "
	.align 2
.LC12:
	.string	"client %i %i %i %i %i %i "
	.align 2
.LC13:
	.long 0x0
	.section	".text"
	.align 2
	.globl DeathmatchScoreboardMessage
	.type	 DeathmatchScoreboardMessage,@function
DeathmatchScoreboardMessage:
	stwu 1,-4560(1)
	mflr 0
	stmw 17,4500(1)
	stw 0,4564(1)
	lis 11,.LC13@ha
	lis 9,ctf@ha
	la 11,.LC13@l(11)
	mr 21,3
	lfs 13,0(11)
	mr 20,4
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L53
	bl CTFScoreboardMessage
	b .L52
.L53:
	lis 9,game@ha
	li 25,0
	la 11,game@l(9)
	li 28,0
	lwz 0,1544(11)
	addi 23,1,1040
	lis 17,gi@ha
	cmpw 0,25,0
	bc 4,0,.L55
	lis 9,g_edicts@ha
	mr 26,11
	lwz 24,g_edicts@l(9)
	addi 31,1,3472
.L57:
	mulli 9,28,928
	addi 27,28,1
	add 29,9,24
	lwz 0,1016(29)
	cmpwi 0,0,0
	bc 12,2,.L56
	lwz 0,1028(26)
	mulli 9,28,4080
	add 9,9,0
	lwz 11,3572(9)
	cmpwi 0,11,0
	bc 4,2,.L56
	li 5,0
	lwz 29,3528(9)
	addi 4,1,3472
	cmpw 0,5,25
	addi 3,1,2448
	addi 30,25,1
	bc 4,0,.L61
	lwz 0,0(31)
	cmpw 0,29,0
	bc 12,1,.L61
	mr 9,4
.L62:
	addi 5,5,1
	cmpw 0,5,25
	bc 4,0,.L61
	lwzu 0,4(9)
	cmpw 0,29,0
	bc 4,1,.L62
.L61:
	cmpw 0,25,5
	mr 7,25
	slwi 12,5,2
	bc 4,1,.L67
	slwi 9,25,2
	mr 6,3
	mr 10,9
	mr 8,4
	addi 11,9,-4
.L69:
	lwzx 9,11,6
	addi 7,7,-1
	cmpw 0,7,5
	stwx 9,10,6
	lwzx 0,11,8
	addi 11,11,-4
	stwx 0,10,8
	addi 10,10,-4
	bc 12,1,.L69
.L67:
	stwx 28,3,12
	mr 25,30
	stwx 29,4,12
.L56:
	lwz 0,1544(26)
	mr 28,27
	cmpw 0,28,0
	bc 12,0,.L57
.L55:
	li 0,0
	mr 3,23
	stb 0,1040(1)
	li 28,0
	bl strlen
	cmpwi 7,25,13
	mr 30,3
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 0,25,0
	rlwinm 9,9,0,28,29
	or 25,0,9
	cmpw 0,28,25
	bc 4,0,.L74
	lis 9,game@ha
	lis 18,g_edicts@ha
	la 19,game@l(9)
	addi 24,1,2448
	li 22,0
.L76:
	addi 9,1,2448
	la 11,gi@l(17)
	lwz 10,1028(19)
	lwzx 0,9,22
	lis 3,.LC8@ha
	lwz 8,40(11)
	la 3,.LC8@l(3)
	mulli 9,0,928
	lwz 11,g_edicts@l(18)
	mtlr 8
	mulli 0,0,4080
	addi 9,9,928
	add 29,11,9
	add 31,10,0
	blrl
	lis 9,0x2aaa
	srawi 11,28,31
	ori 9,9,43691
	cmpwi 7,28,6
	mulhw 9,28,9
	cmpw 6,29,21
	subf 9,11,9
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	mulli 9,9,6
	neg 0,0
	andi. 26,0,160
	subf 9,9,28
	slwi 9,9,5
	addi 27,9,32
	bc 4,26,.L79
	lis 9,.LC9@ha
	la 8,.LC9@l(9)
	b .L80
.L79:
	cmpw 0,29,20
	bc 4,2,.L81
	lis 9,.LC10@ha
	la 8,.LC10@l(9)
	b .L80
.L81:
	li 8,0
.L80:
	cmpwi 0,8,0
	bc 12,2,.L83
	lis 5,.LC11@ha
	addi 3,1,16
	la 5,.LC11@l(5)
	li 4,1024
	addi 6,26,32
	mr 7,27
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,16
	bl strlen
	add 29,30,3
	cmpwi 0,29,1024
	bc 12,1,.L74
	add 3,23,30
	addi 4,1,16
	bl strcpy
	mr 30,29
.L83:
	lis 9,level@ha
	lwz 10,3524(31)
	lis 0,0x1b4e
	lwz 11,level@l(9)
	ori 0,0,33205
	lis 5,.LC12@ha
	lwz 8,0(24)
	addi 3,1,16
	la 5,.LC12@l(5)
	subf 11,10,11
	lwz 9,3528(31)
	mr 6,26
	mulhw 0,11,0
	lwz 10,184(31)
	mr 7,27
	li 4,1024
	srawi 11,11,31
	addi 24,24,4
	srawi 0,0,6
	subf 0,11,0
	stw 0,8(1)
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,16
	bl strlen
	add 29,30,3
	cmpwi 0,29,1024
	bc 12,1,.L74
	add 3,23,30
	addi 4,1,16
	bl strcpy
	addi 28,28,1
	mr 30,29
	cmpw 0,28,25
	addi 22,22,4
	bc 12,0,.L76
.L74:
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,116(29)
	mr 3,23
	mtlr 0
	blrl
.L52:
	lwz 0,4564(1)
	mtlr 0
	lmw 17,4500(1)
	la 1,4560(1)
	blr
.Lfe3:
	.size	 DeathmatchScoreboardMessage,.Lfe3-DeathmatchScoreboardMessage
	.section	".rodata"
	.align 2
.LC14:
	.string	"easy"
	.align 2
.LC15:
	.string	"medium"
	.align 2
.LC16:
	.string	"hard"
	.align 2
.LC17:
	.string	"hard+"
	.align 2
.LC18:
	.string	"xv 32 yv 8 picn help xv 202 yv 12 string2 \"%s\" xv 0 yv 24 cstring2 \"%s\" xv 0 yv 54 cstring2 \"%s\" xv 0 yv 110 cstring2 \"%s\" xv 50 yv 164 string2 \" kills     goals    secrets\" xv 50 yv 172 string2 \"%3i/%3i     %i/%i       %i/%i\" "
	.align 2
.LC19:
	.long 0x0
	.align 2
.LC20:
	.long 0x3f800000
	.align 2
.LC21:
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
	lis 11,.LC19@ha
	lis 9,skill@ha
	la 11,.LC19@l(11)
	mr 31,3
	lfs 0,0(11)
	lwz 11,skill@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 4,2,.L94
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L95
.L94:
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L96
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
	b .L95
.L96:
	lis 11,.LC21@ha
	la 11,.LC21@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L98
	lis 9,.LC16@ha
	la 6,.LC16@l(9)
	b .L95
.L98:
	lis 9,.LC17@ha
	la 6,.LC17@l(9)
.L95:
	lis 11,level@ha
	lis 8,game@ha
	la 11,level@l(11)
	la 8,game@l(8)
	lwz 0,272(11)
	lis 5,.LC18@ha
	addi 9,8,512
	lwz 29,268(11)
	li 4,1024
	addi 3,1,32
	lwz 26,284(11)
	addi 7,11,8
	la 5,.LC18@l(5)
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
.Lfe4:
	.size	 HelpComputer,.Lfe4-HelpComputer
	.section	".rodata"
	.align 2
.LC22:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Help_f
	.type	 Cmd_Help_f,@function
Cmd_Help_f:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 30,16(1)
	stw 0,36(1)
	lis 9,.LC22@ha
	lis 30,deathmatch@ha
	la 9,.LC22@l(9)
	mr 31,3
	lfs 31,0(9)
	lwz 9,deathmatch@l(30)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L101
	lwz 9,84(31)
	lwz 0,3624(9)
	cmpwi 0,0,0
	bc 12,2,.L102
	bl PMenu_Close
.L102:
	lwz 11,84(31)
	li 8,0
	lwz 10,deathmatch@l(30)
	stw 8,3628(11)
	lwz 9,84(31)
	stw 8,3632(9)
	lfs 0,20(10)
	fcmpu 0,0,31
	bc 4,2,.L103
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L100
.L103:
	lwz 9,84(31)
	lwz 0,3616(9)
	cmpwi 0,0,0
	bc 12,2,.L105
	stw 8,3616(9)
	b .L100
.L105:
	li 0,1
	mr 3,31
	stw 0,3616(9)
	lwz 4,540(31)
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L100
.L101:
	lwz 9,84(31)
	li 8,0
	stw 8,3628(9)
	lwz 11,84(31)
	stw 8,3616(11)
	lwz 10,84(31)
	lwz 0,3632(10)
	cmpwi 0,0,0
	bc 12,2,.L107
	lis 9,game+1024@ha
	lwz 11,1840(10)
	lwz 0,game+1024@l(9)
	cmpw 0,11,0
	bc 4,2,.L107
	stw 8,3632(10)
	b .L100
.L107:
	lwz 11,84(31)
	li 0,1
	li 10,0
	mr 3,31
	stw 0,3632(11)
	lwz 9,84(31)
	stw 10,1844(9)
	bl HelpComputer
.L100:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 Cmd_Help_f,.Lfe5-Cmd_Help_f
	.section	".rodata"
	.align 2
.LC23:
	.string	"i_medkit"
	.align 2
.LC24:
	.string	"i_leader"
	.align 2
.LC25:
	.string	"cells"
	.align 2
.LC26:
	.string	"misc/power2.wav"
	.align 2
.LC27:
	.string	"p_quad"
	.align 2
.LC28:
	.string	"p_invulnerability"
	.align 2
.LC29:
	.string	"p_envirosuit"
	.align 2
.LC30:
	.string	"p_rebreather"
	.align 2
.LC31:
	.string	"i_chosen"
	.align 2
.LC32:
	.string	"BARRETT"
	.align 2
.LC33:
	.string	"scope"
	.align 2
.LC34:
	.string	"msg90"
	.align 2
.LC35:
	.string	"scope2"
	.align 2
.LC36:
	.string	"i_info"
	.align 2
.LC37:
	.string	"body_0"
	.align 2
.LC38:
	.string	"bullet proof vest"
	.align 2
.LC39:
	.string	"body_1"
	.align 2
.LC40:
	.string	"scuba gear"
	.align 2
.LC41:
	.string	"body_2"
	.align 2
.LC42:
	.string	"medkit"
	.align 2
.LC43:
	.string	"body_3"
	.align 2
.LC44:
	.string	"m60"
	.align 2
.LC45:
	.string	"m60ammo"
	.align 2
.LC46:
	.string	"body_4"
	.align 2
.LC47:
	.string	"body_head_0"
	.align 2
.LC48:
	.string	"helmet"
	.align 2
.LC49:
	.string	"body_head_1"
	.align 2
.LC50:
	.string	"head light"
	.align 2
.LC51:
	.string	"body_head_2"
	.align 2
.LC52:
	.string	"ir goggles"
	.align 2
.LC53:
	.string	"body_head_3"
	.align 2
.LC54:
	.string	"i_clip"
	.align 2
.LC55:
	.string	"1911"
	.align 2
.LC56:
	.string	"1911clip"
	.align 2
.LC57:
	.string	"glock"
	.align 2
.LC58:
	.string	"glockclip"
	.align 2
.LC59:
	.string	"beretta"
	.align 2
.LC60:
	.string	"berettaclip"
	.align 2
.LC61:
	.string	"casull"
	.align 2
.LC62:
	.string	"casullbullets"
	.align 2
.LC63:
	.string	"ak 47"
	.align 2
.LC64:
	.string	"ak47 clip"
	.align 2
.LC65:
	.string	"mp5"
	.align 2
.LC66:
	.string	"mp5clip"
	.align 2
.LC67:
	.string	"msg90clip"
	.align 2
.LC68:
	.string	"mariner"
	.align 2
.LC69:
	.string	"marinershells"
	.align 2
.LC70:
	.string	"barrett"
	.align 2
.LC71:
	.string	"barrettclip"
	.align 2
.LC72:
	.string	"uzi"
	.align 2
.LC73:
	.string	"uziclip"
	.align 2
.LC74:
	.string	"body_hand_0"
	.align 2
.LC75:
	.string	"detonator"
	.align 2
.LC76:
	.string	"body_hand_1"
	.align 2
.LC77:
	.long 0x3f800000
	.align 2
.LC78:
	.long 0x0
	.align 3
.LC79:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC80:
	.long 0x41200000
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
	lis 9,gi@ha
	mr 31,3
	la 30,gi@l(9)
	lis 3,.LC23@ha
	lwz 9,40(30)
	la 3,.LC23@l(3)
	mtlr 9
	blrl
	lwz 9,84(31)
	sth 3,120(9)
	lwz 9,84(31)
	lwz 0,4060(9)
	cmpwi 0,0,0
	bc 4,2,.L110
	lwz 0,4064(9)
	cmpwi 0,0,0
	bc 12,2,.L109
.L110:
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L109
	lwz 0,40(30)
	lis 3,.LC24@ha
	la 3,.LC24@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,120(9)
.L109:
	lwz 9,84(31)
	lhz 0,482(31)
	sth 0,122(9)
	lwz 9,84(31)
	lwz 11,3640(9)
	cmpwi 0,11,0
	bc 4,2,.L111
	sth 11,124(9)
	lwz 9,84(31)
	sth 11,126(9)
	b .L112
.L111:
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
	lwz 9,3640(11)
	slwi 9,9,2
	add 9,11,9
	lhz 0,742(9)
	sth 0,126(11)
.L112:
	mr 3,31
	bl PowerArmorType
	cmpwi 0,3,0
	bc 12,2,.L113
	lis 3,.LC25@ha
	lwz 29,84(31)
	la 3,.LC25@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 4,2,.L113
	lwz 0,264(31)
	lis 29,gi@ha
	lis 3,.LC26@ha
	la 29,gi@l(29)
	la 3,.LC26@l(3)
	rlwinm 0,0,0,20,18
	stw 0,264(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC77@ha
	lwz 0,16(29)
	lis 11,.LC77@ha
	la 9,.LC77@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC77@l(11)
	li 4,3
	mtlr 0
	lis 9,.LC78@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC78@l(9)
	lfs 3,0(9)
	blrl
.L113:
	mr 3,31
	lis 30,level@ha
	bl ArmorIndex
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,3868(11)
	fcmpu 0,13,0
	bc 4,1,.L115
	li 0,0
	sth 0,134(11)
	lwz 9,84(31)
	sth 0,136(9)
.L115:
	lwz 0,level@l(30)
	lis 29,0x4330
	lis 11,.LC79@ha
	xoris 0,0,0x8000
	la 11,.LC79@l(11)
	stw 0,28(1)
	stw 29,24(1)
	lfd 31,0(11)
	lfd 0,24(1)
	lwz 11,84(31)
	fsub 0,0,31
	lfs 13,3836(11)
	frsp 12,0
	fcmpu 0,13,12
	bc 4,1,.L116
	lis 9,gi+40@ha
	lis 3,.LC27@ha
	lwz 0,gi+40@l(9)
	la 3,.LC27@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC80@ha
	la 11,.LC80@l(11)
	sth 3,138(10)
	lwz 0,level@l(30)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 29,24(1)
	lfd 13,24(1)
	lfs 0,3836(10)
	b .L157
.L116:
	lfs 0,3840(11)
	fcmpu 0,0,12
	bc 4,1,.L118
	lis 9,gi+40@ha
	lis 3,.LC28@ha
	lwz 0,gi+40@l(9)
	la 3,.LC28@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC80@ha
	la 11,.LC80@l(11)
	sth 3,138(10)
	lwz 0,level@l(30)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 29,24(1)
	lfd 13,24(1)
	lfs 0,3840(10)
	b .L157
.L118:
	lfs 0,3848(11)
	fcmpu 0,0,12
	bc 4,1,.L120
	lis 9,gi+40@ha
	lis 3,.LC29@ha
	lwz 0,gi+40@l(9)
	la 3,.LC29@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC80@ha
	la 11,.LC80@l(11)
	sth 3,138(10)
	lwz 0,level@l(30)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 29,24(1)
	lfd 13,24(1)
	lfs 0,3848(10)
	b .L157
.L120:
	lfs 0,3844(11)
	fcmpu 0,0,12
	bc 4,1,.L122
	lis 9,gi+40@ha
	lis 3,.LC30@ha
	lwz 0,gi+40@l(9)
	la 3,.LC30@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC80@ha
	la 11,.LC80@l(11)
	sth 3,138(10)
	lwz 0,level@l(30)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 29,24(1)
	lfd 13,24(1)
	lfs 0,3844(10)
.L157:
	fsub 13,13,31
	frsp 13,13
	fsubs 0,0,13
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,24(1)
	lwz 11,28(1)
	sth 11,140(10)
	b .L117
.L122:
	li 0,0
	sth 0,138(11)
	lwz 9,84(31)
	sth 0,140(9)
.L117:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L124
	li 0,0
	sth 0,182(9)
	lwz 9,84(31)
	sth 0,132(9)
	b .L125
.L124:
	lis 29,gi@ha
	lis 3,.LC31@ha
	la 29,gi@l(29)
	la 3,.LC31@l(3)
	lwz 9,40(29)
	mtlr 9
	blrl
	lwz 11,84(31)
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	sth 3,182(11)
	addi 9,9,36
	lwz 11,84(31)
	lwz 10,40(29)
	lwz 0,736(11)
	mtlr 10
	mulli 0,0,76
	lwzx 3,9,0
	blrl
	lwz 9,84(31)
	sth 3,132(9)
.L125:
	lwz 11,84(31)
	lis 9,deathmatch@ha
	li 10,0
	lwz 8,deathmatch@l(9)
	lhz 0,738(11)
	lis 9,.LC78@ha
	la 9,.LC78@l(9)
	sth 0,144(11)
	lfs 13,0(9)
	lwz 9,84(31)
	sth 10,146(9)
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L126
	lwz 11,84(31)
	lwz 0,724(11)
	cmpwi 0,0,0
	bc 4,1,.L128
	lis 9,level+200@ha
	lfs 0,level+200@l(9)
	fcmpu 0,0,13
	bc 4,2,.L128
	lwz 0,3616(11)
	cmpwi 0,0,0
	bc 12,2,.L131
.L128:
	lwz 9,84(31)
	b .L132
.L126:
	lwz 9,84(31)
	lwz 0,3616(9)
	cmpwi 0,0,0
	bc 4,2,.L132
	lwz 0,3632(9)
	cmpwi 0,0,0
	bc 12,2,.L131
.L132:
	lhz 0,146(9)
	ori 0,0,1
	sth 0,146(9)
.L131:
	lwz 9,84(31)
	lwz 0,3628(9)
	cmpwi 0,0,0
	bc 12,2,.L130
	lwz 0,724(9)
	cmpwi 0,0,0
	bc 4,1,.L130
	lhz 0,146(9)
	ori 0,0,2
	sth 0,146(9)
.L130:
	lwz 9,84(31)
	mr 3,31
	lhz 0,3530(9)
	sth 0,148(9)
	bl SetCTFStats
	lwz 9,84(31)
	li 0,0
	lis 3,.LC32@ha
	la 3,.LC32@l(3)
	sth 0,176(9)
	lwz 29,84(31)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L134
	lwz 9,84(31)
	lwz 0,4036(9)
	cmpwi 0,0,0
	bc 12,2,.L134
	lis 9,gi+40@ha
	lis 3,.LC33@ha
	lwz 0,gi+40@l(9)
	la 3,.LC33@l(3)
	b .L158
.L134:
	lis 3,.LC34@ha
	lwz 29,84(31)
	la 3,.LC34@l(3)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L135
	lwz 9,84(31)
	lwz 0,4036(9)
	cmpwi 0,0,0
	bc 12,2,.L135
	lis 9,gi+40@ha
	lis 3,.LC35@ha
	lwz 0,gi+40@l(9)
	la 3,.LC35@l(3)
.L158:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,176(9)
.L135:
	lwz 11,84(31)
	lis 9,gi@ha
	lis 3,.LC36@ha
	la 27,gi@l(9)
	la 3,.LC36@l(3)
	lhz 0,4010(11)
	lis 30,0x286b
	ori 30,30,51739
	sth 0,174(11)
	lwz 9,40(27)
	mtlr 9
	blrl
	lwz 9,84(31)
	lis 11,.LC37@ha
	sth 3,152(9)
	lwz 9,40(27)
	la 3,.LC37@l(11)
	mtlr 9
	blrl
	lwz 9,84(31)
	lis 11,.LC38@ha
	sth 3,178(9)
	lwz 29,84(31)
	la 3,.LC38@l(11)
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 28,itemlist@l(9)
	subf 3,28,3
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L137
	lwz 9,40(27)
	lis 3,.LC39@ha
	la 3,.LC39@l(3)
	mtlr 9
	blrl
	lwz 9,84(31)
	sth 3,178(9)
.L137:
	lis 3,.LC40@ha
	lwz 29,84(31)
	la 3,.LC40@l(3)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L138
	lwz 9,40(27)
	lis 3,.LC41@ha
	la 3,.LC41@l(3)
	mtlr 9
	blrl
	lwz 9,84(31)
	sth 3,178(9)
.L138:
	lis 3,.LC42@ha
	lwz 29,84(31)
	la 3,.LC42@l(3)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L139
	lwz 9,40(27)
	lis 3,.LC43@ha
	la 3,.LC43@l(3)
	mtlr 9
	blrl
	lwz 9,84(31)
	sth 3,178(9)
.L139:
	lis 3,.LC44@ha
	lwz 29,84(31)
	la 3,.LC44@l(3)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 4,2,.L141
	lis 3,.LC45@ha
	lwz 29,84(31)
	la 3,.LC45@l(3)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L140
.L141:
	lwz 0,40(27)
	lis 3,.LC46@ha
	la 3,.LC46@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,178(9)
.L140:
	lis 9,gi@ha
	lis 3,.LC47@ha
	la 27,gi@l(9)
	la 3,.LC47@l(3)
	lwz 9,40(27)
	mtlr 9
	blrl
	lwz 9,84(31)
	lis 11,.LC48@ha
	sth 3,180(9)
	lwz 29,84(31)
	la 3,.LC48@l(11)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 28,itemlist@l(9)
	ori 0,0,51739
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L142
	lwz 9,40(27)
	lis 3,.LC49@ha
	la 3,.LC49@l(3)
	mtlr 9
	blrl
	lwz 9,84(31)
	sth 3,180(9)
.L142:
	lis 3,.LC50@ha
	lwz 29,84(31)
	la 3,.LC50@l(3)
	bl FindItem
	lis 0,0x286b
	subf 3,28,3
	ori 0,0,51739
	addi 29,29,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L143
	lwz 9,40(27)
	lis 3,.LC51@ha
	la 3,.LC51@l(3)
	mtlr 9
	blrl
	lwz 9,84(31)
	sth 3,180(9)
.L143:
	lis 3,.LC52@ha
	lwz 29,84(31)
	lis 30,0x286b
	la 3,.LC52@l(3)
	ori 30,30,51739
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L144
	lwz 9,40(27)
	lis 3,.LC53@ha
	la 3,.LC53@l(3)
	mtlr 9
	blrl
	lwz 9,84(31)
	sth 3,180(9)
.L144:
	lwz 9,84(31)
	li 0,0
	lis 3,.LC54@ha
	la 3,.LC54@l(3)
	sth 0,130(9)
	lwz 0,40(27)
	mtlr 0
	blrl
	lwz 9,84(31)
	lis 11,.LC55@ha
	sth 3,142(9)
	lwz 29,84(31)
	la 3,.LC55@l(11)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L145
	lis 3,.LC56@ha
	la 3,.LC56@l(3)
	bl FindItem
	subf 3,28,3
	lwz 9,84(31)
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	add 3,9,3
	lhz 0,742(3)
	sth 0,130(9)
.L145:
	lis 3,.LC57@ha
	lwz 29,84(31)
	la 3,.LC57@l(3)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L146
	lis 3,.LC58@ha
	la 3,.LC58@l(3)
	bl FindItem
	subf 3,28,3
	lwz 9,84(31)
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	add 3,9,3
	lhz 0,742(3)
	sth 0,130(9)
.L146:
	lis 3,.LC59@ha
	lwz 29,84(31)
	la 3,.LC59@l(3)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L147
	lis 3,.LC60@ha
	la 3,.LC60@l(3)
	bl FindItem
	subf 3,28,3
	lwz 9,84(31)
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	add 3,9,3
	lhz 0,742(3)
	sth 0,130(9)
.L147:
	lis 3,.LC61@ha
	lwz 29,84(31)
	la 3,.LC61@l(3)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L148
	lis 3,.LC62@ha
	la 3,.LC62@l(3)
	bl FindItem
	subf 3,28,3
	lwz 9,84(31)
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	add 3,9,3
	lhz 0,742(3)
	sth 0,130(9)
.L148:
	lis 3,.LC63@ha
	lwz 29,84(31)
	la 3,.LC63@l(3)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L149
	lis 3,.LC64@ha
	la 3,.LC64@l(3)
	bl FindItem
	subf 3,28,3
	lwz 9,84(31)
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	add 3,9,3
	lhz 0,742(3)
	sth 0,130(9)
.L149:
	lis 3,.LC65@ha
	lwz 29,84(31)
	la 3,.LC65@l(3)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L150
	lis 3,.LC66@ha
	la 3,.LC66@l(3)
	bl FindItem
	subf 3,28,3
	lwz 9,84(31)
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	add 3,9,3
	lhz 0,742(3)
	sth 0,130(9)
.L150:
	lis 3,.LC44@ha
	lwz 29,84(31)
	la 3,.LC44@l(3)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L151
	lis 3,.LC45@ha
	la 3,.LC45@l(3)
	bl FindItem
	subf 3,28,3
	lwz 9,84(31)
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	add 3,9,3
	lhz 0,742(3)
	sth 0,130(9)
.L151:
	lis 3,.LC34@ha
	lwz 29,84(31)
	la 3,.LC34@l(3)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L152
	lis 3,.LC67@ha
	la 3,.LC67@l(3)
	bl FindItem
	subf 3,28,3
	lwz 9,84(31)
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	add 3,9,3
	lhz 0,742(3)
	sth 0,130(9)
.L152:
	lis 3,.LC68@ha
	lwz 29,84(31)
	la 3,.LC68@l(3)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L153
	lis 3,.LC69@ha
	la 3,.LC69@l(3)
	bl FindItem
	subf 3,28,3
	lwz 9,84(31)
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	add 3,9,3
	lhz 0,742(3)
	sth 0,130(9)
.L153:
	lis 3,.LC70@ha
	lwz 29,84(31)
	la 3,.LC70@l(3)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L154
	lis 3,.LC71@ha
	la 3,.LC71@l(3)
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
	sth 0,130(11)
.L154:
	lis 3,.LC72@ha
	lwz 29,84(31)
	la 3,.LC72@l(3)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L155
	lis 3,.LC73@ha
	la 3,.LC73@l(3)
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
	sth 0,130(11)
.L155:
	lis 9,gi@ha
	lis 3,.LC74@ha
	la 30,gi@l(9)
	la 3,.LC74@l(3)
	lwz 9,40(30)
	mtlr 9
	blrl
	lwz 9,84(31)
	lis 11,.LC75@ha
	sth 3,128(9)
	lwz 29,84(31)
	la 3,.LC75@l(11)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L156
	lwz 0,40(30)
	lis 3,.LC76@ha
	la 3,.LC76@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,128(9)
.L156:
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe6:
	.size	 G_SetStats,.Lfe6-G_SetStats
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_UZIclip,4,4
	.comm	item_9mm,4,4
	.comm	item_1911rounds,4,4
	.comm	item_50cal,4,4
	.comm	item_MARINERrounds,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_sshotgun,4,4
	.comm	item_handgrenade,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.section	".rodata"
	.align 2
.LC81:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Score_f
	.type	 Cmd_Score_f,@function
Cmd_Score_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3624(9)
	cmpwi 0,0,0
	bc 12,2,.L89
	bl PMenu_Close
.L89:
	lis 9,deathmatch@ha
	lwz 11,84(31)
	li 8,0
	lwz 10,deathmatch@l(9)
	lis 9,.LC81@ha
	stw 8,3628(11)
	la 9,.LC81@l(9)
	lfs 13,0(9)
	lwz 9,84(31)
	stw 8,3632(9)
	lfs 0,20(10)
	fcmpu 0,0,13
	bc 4,2,.L90
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L88
.L90:
	lwz 9,84(31)
	lwz 0,3616(9)
	cmpwi 0,0,0
	bc 12,2,.L91
	stw 8,3616(9)
	b .L88
.L91:
	li 0,1
	mr 3,31
	stw 0,3616(9)
	lwz 4,540(31)
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L88:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 Cmd_Score_f,.Lfe7-Cmd_Score_f
	.section	".rodata"
	.align 2
.LC82:
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
	lwz 0,3924(31)
	cmpwi 0,0,0
	bc 4,2,.L168
	bl G_SetStats
.L168:
	lwz 9,724(31)
	li 0,0
	sth 0,146(31)
	cmpwi 0,9,0
	bc 4,1,.L170
	lis 11,.LC82@ha
	lis 9,level+200@ha
	la 11,.LC82@l(11)
	lfs 0,level+200@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L170
	lwz 0,3616(31)
	cmpwi 0,0,0
	bc 12,2,.L169
.L170:
	lhz 0,146(31)
	ori 0,0,1
	sth 0,146(31)
.L169:
	lwz 0,3628(31)
	cmpwi 0,0,0
	bc 12,2,.L171
	lwz 0,724(31)
	cmpwi 0,0,0
	bc 4,1,.L171
	lhz 0,146(31)
	ori 0,0,2
	sth 0,146(31)
.L171:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 G_SetSpectatorStats,.Lfe8-G_SetSpectatorStats
	.section	".rodata"
	.align 2
.LC83:
	.long 0x3f800000
	.align 3
.LC84:
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
	lis 11,.LC83@ha
	lis 9,maxclients@ha
	la 11,.LC83@l(11)
	mr 30,3
	lfs 13,0(11)
	li 29,1
	lis 26,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L161
	lis 9,.LC84@ha
	lis 28,g_edicts@ha
	la 9,.LC84@l(9)
	lis 27,0x4330
	lfd 31,0(9)
	li 31,928
.L163:
	lwz 9,g_edicts@l(28)
	add 9,31,9
	lwz 0,88(9)
	lwz 3,84(9)
	cmpwi 0,0,0
	bc 12,2,.L162
	lwz 0,3924(3)
	cmpw 0,0,30
	bc 4,2,.L162
	lwz 4,84(30)
	addi 3,3,120
	li 5,64
	addi 4,4,120
	crxor 6,6,6
	bl memcpy
	lwz 3,g_edicts@l(28)
	add 3,3,31
	bl G_SetSpectatorStats
.L162:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 31,31,928
	stw 0,12(1)
	stw 27,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L163
.L161:
	lwz 0,52(1)
	mtlr 0
	lmw 26,16(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 G_CheckChaseStats,.Lfe9-G_CheckChaseStats
	.comm	ctfgame,24,4
	.comm	enemies,4,4
	.comm	spawned,4,4
	.comm	lms_round,4,4
	.comm	terror_l,4,4
	.comm	swat_l,4,4
	.comm	lms_delay,4,4
	.comm	lms_delay2,4,4
	.comm	lms_players,4,4
	.comm	lms_dead_players,4,4
	.comm	lms_alive_players,4,4
	.comm	lms_round_over,4,4
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
	bl DeathmatchScoreboardMessage
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
