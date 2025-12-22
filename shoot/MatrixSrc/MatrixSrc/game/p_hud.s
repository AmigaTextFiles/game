	.file	"p_hud.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"endlevel.wav"
	.align 2
.LC1:
	.long 0x0
	.align 2
.LC2:
	.long 0x41000000
	.align 3
.LC3:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC4:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl MoveClientToIntermission
	.type	 MoveClientToIntermission,@function
MoveClientToIntermission:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 25,28(1)
	stw 0,68(1)
	lis 11,.LC1@ha
	lis 9,deathmatch@ha
	la 11,.LC1@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
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
	stw 0,3528(9)
.L7:
	lis 4,level@ha
	lis 9,.LC2@ha
	lwz 28,84(31)
	la 29,level@l(4)
	la 9,.LC2@l(9)
	lfs 0,212(29)
	li 0,4
	lfs 9,0(9)
	mr 6,11
	mr 5,11
	mr 10,11
	mr 7,11
	stfs 0,4(31)
	lis 9,.LC1@ha
	li 8,0
	lfs 0,216(29)
	la 9,.LC1@l(9)
	lis 27,g_edicts@ha
	lfs 31,0(9)
	lis 26,0x4330
	lis 25,matrix+24@ha
	lis 9,.LC3@ha
	lis 3,.LC0@ha
	stfs 0,8(31)
	la 9,.LC3@l(9)
	la 3,.LC0@l(3)
	lfs 12,220(29)
	lfd 8,0(9)
	lis 9,gi@ha
	stfs 12,12(31)
	la 30,gi@l(9)
	lfs 0,212(29)
	fmuls 0,0,9
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	sth 11,4(28)
	lfs 0,216(29)
	lwz 9,84(31)
	fmuls 0,0,9
	fctiwz 11,0
	stfd 11,16(1)
	lwz 10,20(1)
	sth 10,6(9)
	lfs 0,220(29)
	lwz 11,84(31)
	fmuls 0,0,9
	fctiwz 10,0
	stfd 10,16(1)
	lwz 7,20(1)
	sth 7,8(11)
	lfs 0,224(29)
	lwz 9,84(31)
	stfs 0,28(9)
	lfs 0,228(29)
	lwz 11,84(31)
	stfs 0,32(11)
	lfs 0,232(29)
	lwz 10,84(31)
	stfs 0,36(10)
	lwz 9,84(31)
	stw 0,0(9)
	lwz 11,84(31)
	stw 8,88(11)
	lwz 9,84(31)
	stfs 31,108(9)
	lwz 11,84(31)
	lwz 0,116(11)
	rlwinm 0,0,0,0,30
	stw 0,116(11)
	lwz 9,84(31)
	stfs 31,3740(9)
	lwz 11,84(31)
	lwz 28,g_edicts@l(27)
	stfs 31,3744(11)
	lwz 9,84(31)
	stfs 31,3748(9)
	lwz 11,84(31)
	stfs 31,3752(11)
	lwz 9,84(31)
	stw 8,3756(9)
	lwz 11,84(31)
	stfs 31,3760(11)
	lwz 9,84(31)
	stfs 31,3876(9)
	lwz 11,84(31)
	stfs 31,1084(31)
	stfs 31,3884(11)
	lwz 9,level@l(4)
	lwz 11,84(31)
	addi 9,9,1
	xoris 9,9,0x8000
	stw 9,20(1)
	stw 26,16(1)
	lfd 0,16(1)
	fsub 0,0,8
	frsp 0,0
	stfs 0,3888(11)
	stfs 31,912(31)
	lwz 9,level@l(4)
	addi 9,9,1
	xoris 9,9,0x8000
	stw 9,20(1)
	stw 26,16(1)
	lfd 0,16(1)
	fsub 0,0,8
	frsp 0,0
	stfs 0,matrix+24@l(25)
	stw 8,248(31)
	stw 8,508(31)
	stw 8,44(31)
	stw 8,48(31)
	stw 8,40(31)
	stw 8,64(31)
	stw 8,76(31)
	lwz 9,36(30)
	mtlr 9
	blrl
	lis 9,.LC4@ha
	lwz 11,20(30)
	mr 6,3
	la 9,.LC4@l(9)
	mr 4,28
	lfs 1,0(9)
	mtlr 11
	addi 3,29,212
	li 5,8
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	lfs 2,0(9)
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	lfs 3,0(9)
	blrl
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L10
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L9
.L10:
	mr 3,31
	li 4,0
	bl DeathmatchScoreboardMessage
	lwz 0,92(30)
	mr 3,31
	li 4,1
	mtlr 0
	blrl
.L9:
	lwz 0,68(1)
	mtlr 0
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe1:
	.size	 MoveClientToIntermission,.Lfe1-MoveClientToIntermission
	.section	".rodata"
	.align 2
.LC5:
	.string	"*"
	.align 2
.LC6:
	.string	"info_player_intermission"
	.align 2
.LC7:
	.string	"info_player_start"
	.align 2
.LC8:
	.string	"info_player_deathmatch"
	.align 2
.LC9:
	.long 0x0
	.align 3
.LC10:
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
	lis 11,.LC9@ha
	lis 9,level+200@ha
	la 11,.LC9@l(11)
	lfs 0,level+200@l(9)
	mr 27,3
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L11
	lis 9,maxclients@ha
	lis 11,game+1560@ha
	lwz 10,maxclients@l(9)
	li 0,0
	li 30,0
	stw 0,game+1560@l(11)
	lis 26,maxclients@ha
	lfs 0,20(10)
	fcmpu 0,13,0
	bc 4,0,.L14
	lis 9,.LC10@ha
	lis 28,g_edicts@ha
	la 9,.LC10@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 31,1116
.L16:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L15
	lwz 9,84(3)
	lwz 0,3836(9)
	stw 0,1816(9)
	lwz 11,480(3)
	cmpwi 0,11,0
	bc 12,1,.L15
	bl respawn
.L15:
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
	bc 12,0,.L16
.L14:
	lis 9,level@ha
	lis 4,.LC5@ha
	la 31,level@l(9)
	la 4,.LC5@l(4)
	lfs 0,4(31)
	stfs 0,200(31)
	lwz 0,504(27)
	mr 3,0
	stw 0,204(31)
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L20
	lis 11,.LC9@ha
	lis 9,coop@ha
	la 11,.LC9@l(11)
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
	lis 9,.LC10@ha
	lis 31,0x4330
	la 9,.LC10@l(9)
	lfd 12,0(9)
.L25:
	mulli 9,30,1116
	addi 7,30,1
	addi 9,9,1116
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
	addi 10,10,80
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
	lis 9,.LC9@ha
	lis 11,deathmatch@ha
	la 9,.LC9@l(9)
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
	lis 5,.LC6@ha
	stw 0,level+208@l(9)
	li 3,0
	la 5,.LC6@l(5)
	li 4,280
	bl G_Find
	lis 29,.LC6@ha
	mr. 31,3
	bc 4,2,.L36
	lis 5,.LC7@ha
	li 3,0
	la 5,.LC7@l(5)
	li 4,280
	bl G_Find
	mr. 31,3
	bc 4,2,.L38
	lis 5,.LC8@ha
	li 3,0
	la 5,.LC8@l(5)
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
	la 5,.LC6@l(29)
	bl G_Find
	mr. 31,3
	bc 4,2,.L39
	li 3,0
	li 4,280
	la 5,.LC6@l(29)
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
	lis 11,.LC9@ha
	stfs 0,212(9)
	la 11,.LC9@l(11)
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
	lis 9,.LC10@ha
	lis 28,g_edicts@ha
	la 9,.LC10@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 31,1116
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
	addi 31,31,1116
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
.LC11:
	.string	"i_fixme"
	.align 2
.LC12:
	.string	"tag1"
	.align 2
.LC13:
	.string	"tag2"
	.align 2
.LC14:
	.string	"xv %i yv %i picn %s "
	.align 2
.LC15:
	.string	"client %i %i %i %i %i %i "
	.section	".text"
	.align 2
	.globl DeathmatchScoreboardMessage
	.type	 DeathmatchScoreboardMessage,@function
DeathmatchScoreboardMessage:
	stwu 1,-4560(1)
	mflr 0
	stmw 17,4500(1)
	stw 0,4564(1)
	lis 9,game@ha
	li 25,0
	la 11,game@l(9)
	mr 20,3
	lwz 0,1544(11)
	mr 21,4
	li 28,0
	addi 23,1,1040
	lis 17,gi@ha
	cmpw 0,25,0
	bc 4,0,.L53
	lis 9,g_edicts@ha
	mr 26,11
	lwz 24,g_edicts@l(9)
	addi 31,1,3472
.L55:
	mulli 9,28,1116
	addi 27,28,1
	add 29,9,24
	lwz 0,1204(29)
	cmpwi 0,0,0
	bc 12,2,.L54
	lwz 0,1028(26)
	mulli 9,28,3916
	add 9,9,0
	lwz 11,3480(9)
	cmpwi 0,11,0
	bc 4,2,.L54
	li 5,0
	lwz 29,3464(9)
	addi 4,1,3472
	cmpw 0,5,25
	addi 3,1,2448
	addi 30,25,1
	bc 4,0,.L59
	lwz 0,0(31)
	cmpw 0,29,0
	bc 12,1,.L59
	mr 9,4
.L60:
	addi 5,5,1
	cmpw 0,5,25
	bc 4,0,.L59
	lwzu 0,4(9)
	cmpw 0,29,0
	bc 4,1,.L60
.L59:
	cmpw 0,25,5
	mr 7,25
	slwi 12,5,2
	bc 4,1,.L65
	slwi 9,25,2
	mr 6,3
	mr 10,9
	mr 8,4
	addi 11,9,-4
.L67:
	lwzx 9,11,6
	addi 7,7,-1
	cmpw 0,7,5
	stwx 9,10,6
	lwzx 0,11,8
	addi 11,11,-4
	stwx 0,10,8
	addi 10,10,-4
	bc 12,1,.L67
.L65:
	stwx 28,3,12
	mr 25,30
	stwx 29,4,12
.L54:
	lwz 0,1544(26)
	mr 28,27
	cmpw 0,28,0
	bc 12,0,.L55
.L53:
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
	bc 4,0,.L72
	lis 9,game@ha
	lis 18,g_edicts@ha
	la 19,game@l(9)
	addi 24,1,2448
	li 22,0
.L74:
	addi 9,1,2448
	la 11,gi@l(17)
	lwz 10,1028(19)
	lwzx 0,9,22
	lis 3,.LC11@ha
	lwz 8,40(11)
	la 3,.LC11@l(3)
	mulli 9,0,1116
	lwz 11,g_edicts@l(18)
	mtlr 8
	mulli 0,0,3916
	addi 9,9,1116
	add 29,11,9
	add 31,10,0
	blrl
	lis 9,0x2aaa
	srawi 11,28,31
	ori 9,9,43691
	cmpwi 7,28,6
	mulhw 9,28,9
	cmpw 6,29,20
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
	bc 4,26,.L77
	lis 9,.LC12@ha
	la 8,.LC12@l(9)
	b .L78
.L77:
	cmpw 0,29,21
	bc 4,2,.L79
	lis 9,.LC13@ha
	la 8,.LC13@l(9)
	b .L78
.L79:
	li 8,0
.L78:
	cmpwi 0,8,0
	bc 12,2,.L81
	lis 5,.LC14@ha
	addi 3,1,16
	la 5,.LC14@l(5)
	li 4,1024
	addi 6,26,32
	mr 7,27
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,16
	bl strlen
	add 29,30,3
	cmpwi 0,29,1024
	bc 12,1,.L72
	add 3,23,30
	addi 4,1,16
	bl strcpy
	mr 30,29
.L81:
	lis 9,level@ha
	lwz 10,3460(31)
	lis 0,0x1b4e
	lwz 11,level@l(9)
	ori 0,0,33205
	lis 5,.LC15@ha
	lwz 8,0(24)
	addi 3,1,16
	la 5,.LC15@l(5)
	subf 11,10,11
	lwz 9,3464(31)
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
	bc 12,1,.L72
	add 3,23,30
	addi 4,1,16
	bl strcpy
	addi 28,28,1
	mr 30,29
	cmpw 0,28,25
	addi 22,22,4
	bc 12,0,.L74
.L72:
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
	lwz 0,4564(1)
	mtlr 0
	lmw 17,4500(1)
	la 1,4560(1)
	blr
.Lfe3:
	.size	 DeathmatchScoreboardMessage,.Lfe3-DeathmatchScoreboardMessage
	.section	".rodata"
	.align 2
.LC16:
	.string	"easy"
	.align 2
.LC17:
	.string	"medium"
	.align 2
.LC18:
	.string	"hard"
	.align 2
.LC19:
	.string	"hard+"
	.align 2
.LC20:
	.string	"xv 32 yv 8 picn help xv 202 yv 12 string2 \"%s\" xv 0 yv 24 cstring2 \"%s\" xv 0 yv 54 cstring2 \"%s\" xv 0 yv 110 cstring2 \"%s\" xv 50 yv 164 string2 \" kills     goals    secrets\" xv 50 yv 172 string2 \"%3i/%3i     %i/%i       %i/%i\" "
	.align 2
.LC21:
	.long 0x0
	.align 2
.LC22:
	.long 0x3f800000
	.align 2
.LC23:
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
	lis 11,.LC21@ha
	lis 9,skill@ha
	la 11,.LC21@l(11)
	mr 31,3
	lfs 0,0(11)
	lwz 11,skill@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 4,2,.L95
	lis 9,.LC16@ha
	la 6,.LC16@l(9)
	b .L96
.L95:
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L97
	lis 9,.LC17@ha
	la 6,.LC17@l(9)
	b .L96
.L97:
	lis 11,.LC23@ha
	la 11,.LC23@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L99
	lis 9,.LC18@ha
	la 6,.LC18@l(9)
	b .L96
.L99:
	lis 9,.LC19@ha
	la 6,.LC19@l(9)
.L96:
	lis 11,level@ha
	lis 8,game@ha
	la 11,level@l(11)
	la 8,game@l(8)
	lwz 0,272(11)
	lis 5,.LC20@ha
	addi 9,8,512
	lwz 29,268(11)
	li 4,1024
	addi 3,1,32
	lwz 26,284(11)
	addi 7,11,8
	la 5,.LC20@l(5)
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
.LC24:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Help_f
	.type	 Cmd_Help_f,@function
Cmd_Help_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,deathmatch@ha
	lis 11,.LC24@ha
	lwz 10,deathmatch@l(9)
	la 11,.LC24@l(11)
	mr 31,3
	lfs 13,0(11)
	lfs 0,20(10)
	fcmpu 0,0,13
	bc 12,2,.L102
	lwz 9,84(31)
	li 8,0
	stw 8,3532(9)
	lwz 11,84(31)
	stw 8,3536(11)
	lfs 0,20(10)
	fcmpu 0,0,13
	bc 4,2,.L103
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L101
.L103:
	lwz 10,84(31)
	lwz 0,3528(10)
	cmpwi 0,0,0
	bc 12,2,.L105
	stw 8,3528(10)
	b .L101
.L105:
	lis 9,teamplay@ha
	li 0,1
	lwz 11,teamplay@l(9)
	stw 0,3528(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L106
	lwz 4,540(31)
	mr 3,31
	bl DeathmatchScoreboardMessage
	b .L107
.L106:
	lwz 4,540(31)
	mr 3,31
	crxor 6,6,6
	bl TeamplayScoreboardMessage
.L107:
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L101
.L102:
	lwz 9,84(31)
	li 8,0
	stw 8,3532(9)
	lwz 11,84(31)
	stw 8,3528(11)
	lwz 10,84(31)
	lwz 0,3536(10)
	cmpwi 0,0,0
	bc 12,2,.L109
	lis 9,game+1024@ha
	lwz 11,1804(10)
	lwz 0,game+1024@l(9)
	cmpw 0,11,0
	bc 4,2,.L109
	stw 8,3536(10)
	b .L101
.L109:
	lwz 11,84(31)
	li 0,1
	li 10,0
	mr 3,31
	stw 0,3536(11)
	lwz 9,84(31)
	stw 10,1808(9)
	bl HelpComputer
.L101:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 Cmd_Help_f,.Lfe5-Cmd_Help_f
	.section	".rodata"
	.align 2
.LC25:
	.string	"h1"
	.align 2
.LC26:
	.string	"h2"
	.align 2
.LC27:
	.string	"h3"
	.align 2
.LC28:
	.string	"h4"
	.align 2
.LC29:
	.string	"h5"
	.align 2
.LC30:
	.string	"h6"
	.align 2
.LC31:
	.string	"h7"
	.align 2
.LC32:
	.string	"h8"
	.align 2
.LC33:
	.string	"h9"
	.align 2
.LC34:
	.string	"h10"
	.align 2
.LC35:
	.string	"h11"
	.align 2
.LC36:
	.string	"h12"
	.align 2
.LC37:
	.string	"h13"
	.align 2
.LC38:
	.string	"h14"
	.align 2
.LC39:
	.string	"h15"
	.align 2
.LC40:
	.string	"h16"
	.align 2
.LC41:
	.string	"h17"
	.align 2
.LC42:
	.string	"cells"
	.align 2
.LC43:
	.string	"misc/power2.wav"
	.align 2
.LC44:
	.string	"i_powershield"
	.align 2
.LC45:
	.string	"p_quad"
	.align 2
.LC46:
	.string	"p_invulnerability"
	.align 2
.LC47:
	.string	"p_envirosuit"
	.align 2
.LC48:
	.string	"p_rebreather"
	.align 2
.LC49:
	.string	"i_help"
	.align 2
.LC50:
	.long 0x3f800000
	.align 2
.LC51:
	.long 0x0
	.align 3
.LC52:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC53:
	.long 0x41200000
	.align 2
.LC54:
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
	mr 31,3
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 12,1,.L163
	lis 9,gi@ha
	lis 3,.LC25@ha
	la 9,gi@l(9)
	la 3,.LC25@l(3)
	lwz 0,40(9)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,120(9)
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L112
.L163:
	lis 9,gi+40@ha
	lis 3,.LC25@ha
	lwz 0,gi+40@l(9)
	la 3,.LC25@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,120(9)
.L112:
	lwz 0,480(31)
	cmpwi 0,0,11
	bc 4,1,.L113
	lis 9,gi+40@ha
	lis 3,.LC26@ha
	lwz 0,gi+40@l(9)
	la 3,.LC26@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,120(9)
.L113:
	lwz 0,480(31)
	cmpwi 0,0,16
	bc 4,1,.L114
	lis 9,gi+40@ha
	lis 3,.LC27@ha
	lwz 0,gi+40@l(9)
	la 3,.LC27@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,120(9)
.L114:
	lwz 0,480(31)
	cmpwi 0,0,22
	bc 4,1,.L115
	lis 9,gi+40@ha
	lis 3,.LC28@ha
	lwz 0,gi+40@l(9)
	la 3,.LC28@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,120(9)
.L115:
	lwz 0,480(31)
	cmpwi 0,0,27
	bc 4,1,.L116
	lis 9,gi+40@ha
	lis 3,.LC29@ha
	lwz 0,gi+40@l(9)
	la 3,.LC29@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,120(9)
.L116:
	lwz 0,480(31)
	cmpwi 0,0,33
	bc 4,1,.L117
	lis 9,gi+40@ha
	lis 3,.LC30@ha
	lwz 0,gi+40@l(9)
	la 3,.LC30@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,120(9)
.L117:
	lwz 0,480(31)
	cmpwi 0,0,38
	bc 4,1,.L118
	lis 9,gi+40@ha
	lis 3,.LC31@ha
	lwz 0,gi+40@l(9)
	la 3,.LC31@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,120(9)
.L118:
	lwz 0,480(31)
	cmpwi 0,0,44
	bc 4,1,.L119
	lis 9,gi+40@ha
	lis 3,.LC32@ha
	lwz 0,gi+40@l(9)
	la 3,.LC32@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,120(9)
.L119:
	lwz 0,480(31)
	cmpwi 0,0,49
	bc 4,1,.L120
	lis 9,gi+40@ha
	lis 3,.LC33@ha
	lwz 0,gi+40@l(9)
	la 3,.LC33@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,120(9)
.L120:
	lwz 0,480(31)
	cmpwi 0,0,55
	bc 4,1,.L121
	lis 9,gi+40@ha
	lis 3,.LC34@ha
	lwz 0,gi+40@l(9)
	la 3,.LC34@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,120(9)
.L121:
	lwz 0,480(31)
	cmpwi 0,0,60
	bc 4,1,.L122
	lis 9,gi+40@ha
	lis 3,.LC35@ha
	lwz 0,gi+40@l(9)
	la 3,.LC35@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,120(9)
.L122:
	lwz 0,480(31)
	cmpwi 0,0,66
	bc 4,1,.L123
	lis 9,gi+40@ha
	lis 3,.LC36@ha
	lwz 0,gi+40@l(9)
	la 3,.LC36@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,120(9)
.L123:
	lwz 0,480(31)
	cmpwi 0,0,71
	bc 4,1,.L124
	lis 9,gi+40@ha
	lis 3,.LC37@ha
	lwz 0,gi+40@l(9)
	la 3,.LC37@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,120(9)
.L124:
	lwz 0,480(31)
	cmpwi 0,0,77
	bc 4,1,.L125
	lis 9,gi+40@ha
	lis 3,.LC38@ha
	lwz 0,gi+40@l(9)
	la 3,.LC38@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,120(9)
.L125:
	lwz 0,480(31)
	cmpwi 0,0,82
	bc 4,1,.L126
	lis 9,gi+40@ha
	lis 3,.LC39@ha
	lwz 0,gi+40@l(9)
	la 3,.LC39@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,120(9)
.L126:
	lwz 0,480(31)
	cmpwi 0,0,88
	bc 4,1,.L127
	lis 9,gi+40@ha
	lis 3,.LC40@ha
	lwz 0,gi+40@l(9)
	la 3,.LC40@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,120(9)
.L127:
	lwz 0,480(31)
	cmpwi 0,0,93
	bc 4,1,.L128
	lis 9,gi+40@ha
	lis 3,.LC41@ha
	lwz 0,gi+40@l(9)
	la 3,.LC41@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,120(9)
.L128:
	lwz 0,480(31)
	lis 28,level@ha
	cmpwi 0,0,99
	bc 4,1,.L129
	la 9,level@l(28)
	lwz 11,84(31)
	lhz 0,266(9)
	sth 0,120(11)
.L129:
	lwz 9,84(31)
	lhz 0,482(31)
	sth 0,122(9)
	lwz 9,84(31)
	lwz 11,3544(9)
	cmpwi 0,11,0
	bc 4,2,.L130
	sth 11,124(9)
	lwz 9,84(31)
	sth 11,126(9)
	b .L131
.L130:
	mulli 11,11,80
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
	lwz 9,3544(11)
	slwi 9,9,2
	add 9,11,9
	lhz 0,742(9)
	sth 0,126(11)
.L131:
	mr 3,31
	bl PowerArmorType
	mr. 30,3
	bc 12,2,.L132
	lis 3,.LC42@ha
	lwz 29,84(31)
	la 3,.LC42@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0xcccc
	la 9,itemlist@l(9)
	ori 0,0,52429
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	srawi 3,3,4
	slwi 3,3,2
	lwzx 27,29,3
	cmpwi 0,27,0
	bc 4,2,.L132
	lwz 0,264(31)
	lis 29,gi@ha
	lis 3,.LC43@ha
	la 29,gi@l(29)
	la 3,.LC43@l(3)
	rlwinm 0,0,0,20,18
	li 30,0
	stw 0,264(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC50@ha
	lwz 0,16(29)
	lis 11,.LC50@ha
	la 9,.LC50@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC50@l(11)
	li 4,3
	mtlr 0
	lis 9,.LC51@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC51@l(9)
	lfs 3,0(9)
	blrl
.L132:
	mr 3,31
	bl ArmorIndex
	cmpwi 0,30,0
	mr 29,3
	bc 12,2,.L134
	cmpwi 0,29,0
	bc 12,2,.L135
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L134
.L135:
	lis 9,gi+40@ha
	lis 3,.LC44@ha
	lwz 0,gi+40@l(9)
	la 3,.LC44@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,128(9)
	lwz 11,84(31)
	sth 27,130(11)
	b .L136
.L134:
	cmpwi 0,29,0
	bc 12,2,.L137
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
	b .L136
.L137:
	lwz 9,84(31)
	sth 29,128(9)
	lwz 11,84(31)
	sth 29,130(11)
.L136:
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,3772(11)
	fcmpu 0,13,0
	bc 4,1,.L139
	li 0,0
	sth 0,134(11)
	lwz 9,84(31)
	sth 0,136(9)
.L139:
	lwz 0,level@l(28)
	lis 30,0x4330
	lis 11,.LC52@ha
	xoris 0,0,0x8000
	la 11,.LC52@l(11)
	stw 0,28(1)
	stw 30,24(1)
	lfd 31,0(11)
	lfd 0,24(1)
	lwz 11,84(31)
	fsub 0,0,31
	lfs 13,3740(11)
	frsp 12,0
	fcmpu 0,13,12
	bc 4,1,.L140
	lis 9,gi+40@ha
	lis 3,.LC45@ha
	lwz 0,gi+40@l(9)
	la 3,.LC45@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC53@ha
	la 11,.LC53@l(11)
	sth 3,138(10)
	lwz 0,level@l(28)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3740(10)
	b .L164
.L140:
	lfs 0,3744(11)
	fcmpu 0,0,12
	bc 4,1,.L142
	lis 9,gi+40@ha
	lis 3,.LC46@ha
	lwz 0,gi+40@l(9)
	la 3,.LC46@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC53@ha
	la 11,.LC53@l(11)
	sth 3,138(10)
	lwz 0,level@l(28)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3744(10)
	b .L164
.L142:
	lfs 0,3752(11)
	fcmpu 0,0,12
	bc 4,1,.L144
	lis 9,gi+40@ha
	lis 3,.LC47@ha
	lwz 0,gi+40@l(9)
	la 3,.LC47@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC53@ha
	la 11,.LC53@l(11)
	sth 3,138(10)
	lwz 0,level@l(28)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3752(10)
	b .L164
.L144:
	lfs 0,3748(11)
	fcmpu 0,0,12
	bc 4,1,.L146
	lis 9,gi+40@ha
	lis 3,.LC48@ha
	lwz 0,gi+40@l(9)
	la 3,.LC48@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC53@ha
	la 11,.LC53@l(11)
	sth 3,138(10)
	lwz 0,level@l(28)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3748(10)
.L164:
	fsub 13,13,31
	frsp 13,13
	fsubs 0,0,13
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,24(1)
	lwz 11,28(1)
	sth 11,140(10)
	b .L141
.L146:
	li 0,0
	sth 0,138(11)
	lwz 9,84(31)
	sth 0,140(9)
.L141:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L148
	li 0,0
	sth 0,132(9)
	b .L149
.L148:
	lis 9,itemlist@ha
	lis 11,gi+40@ha
	mulli 0,0,80
	la 9,itemlist@l(9)
	lwz 11,gi+40@l(11)
	addi 9,9,36
	lwzx 3,9,0
	mtlr 11
	blrl
	lwz 9,84(31)
	sth 3,132(9)
.L149:
	lwz 11,84(31)
	lis 9,deathmatch@ha
	li 10,0
	lwz 8,deathmatch@l(9)
	lhz 0,738(11)
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	sth 0,144(11)
	lfs 13,0(9)
	lwz 9,84(31)
	sth 10,146(9)
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L150
	lwz 11,84(31)
	lwz 0,724(11)
	cmpwi 0,0,0
	bc 4,1,.L152
	lis 9,level+200@ha
	lfs 0,level+200@l(9)
	fcmpu 0,0,13
	bc 4,2,.L152
	lwz 0,3528(11)
	cmpwi 0,0,0
	bc 12,2,.L155
.L152:
	lwz 9,84(31)
	b .L156
.L150:
	lwz 9,84(31)
	lwz 0,3528(9)
	cmpwi 0,0,0
	bc 4,2,.L156
	lwz 0,3536(9)
	cmpwi 0,0,0
	bc 12,2,.L155
.L156:
	lhz 0,146(9)
	ori 0,0,1
	sth 0,146(9)
.L155:
	lwz 9,84(31)
	lwz 0,3532(9)
	cmpwi 0,0,0
	bc 12,2,.L154
	lwz 0,724(9)
	cmpwi 0,0,0
	bc 4,1,.L154
	lhz 0,146(9)
	ori 0,0,2
	sth 0,146(9)
.L154:
	lwz 11,84(31)
	lhz 0,3466(11)
	sth 0,148(11)
	lwz 9,84(31)
	lwz 0,1808(9)
	cmpwi 0,0,0
	bc 12,2,.L158
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 11,0,8
	bc 12,2,.L158
	lis 9,gi+40@ha
	lis 3,.LC49@ha
	lwz 0,gi+40@l(9)
	la 3,.LC49@l(3)
	b .L165
.L158:
	lwz 9,84(31)
	lwz 0,716(9)
	mr 11,9
	cmpwi 0,0,2
	bc 12,2,.L161
	lis 9,.LC54@ha
	lfs 13,112(11)
	la 9,.LC54@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,1,.L161
	lwz 0,3836(11)
	cmpwi 0,0,0
	bc 12,2,.L160
.L161:
	lwz 11,1788(11)
	cmpwi 0,11,0
	bc 12,2,.L160
	lis 9,gi+40@ha
	lwz 3,36(11)
	lwz 0,gi+40@l(9)
.L165:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,142(9)
	b .L159
.L160:
	lwz 9,84(31)
	li 0,0
	sth 0,142(9)
.L159:
	lwz 9,84(31)
	li 0,0
	mr 3,31
	sth 0,154(9)
	crxor 6,6,6
	bl MatrixSetStats
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe6:
	.size	 G_SetStats,.Lfe6-G_SetStats
	.section	".rodata"
	.align 2
.LC55:
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
	lis 10,.LC55@ha
	mr 31,3
	la 10,.LC55@l(10)
	lwz 11,84(31)
	lis 9,deathmatch@ha
	lfs 13,0(10)
	li 8,0
	lwz 10,deathmatch@l(9)
	stw 8,3532(11)
	lwz 9,84(31)
	stw 8,3536(9)
	lfs 0,20(10)
	fcmpu 0,0,13
	bc 4,2,.L89
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L88
.L89:
	lwz 10,84(31)
	lwz 0,3528(10)
	cmpwi 0,0,0
	bc 12,2,.L90
	stw 8,3528(10)
	b .L88
.L90:
	lis 9,teamplay@ha
	li 0,1
	lwz 11,teamplay@l(9)
	stw 0,3528(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L91
	lwz 4,540(31)
	mr 3,31
	bl DeathmatchScoreboardMessage
	b .L92
.L91:
	lwz 4,540(31)
	mr 3,31
	crxor 6,6,6
	bl TeamplayScoreboardMessage
.L92:
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
.LC56:
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
	lwz 0,3828(31)
	cmpwi 0,0,0
	bc 4,2,.L175
	bl G_SetStats
.L175:
	lwz 0,724(31)
	li 9,1
	li 11,0
	sth 9,154(31)
	cmpwi 0,0,0
	sth 11,146(31)
	bc 4,1,.L177
	lis 11,.LC56@ha
	lis 9,level+200@ha
	la 11,.LC56@l(11)
	lfs 0,level+200@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L177
	lwz 0,3528(31)
	cmpwi 0,0,0
	bc 12,2,.L176
.L177:
	lhz 0,146(31)
	ori 0,0,1
	sth 0,146(31)
.L176:
	lwz 0,3532(31)
	cmpwi 0,0,0
	bc 12,2,.L178
	lwz 0,724(31)
	cmpwi 0,0,0
	bc 4,1,.L178
	lhz 0,146(31)
	ori 0,0,2
	sth 0,146(31)
.L178:
	lwz 10,3828(31)
	cmpwi 0,10,0
	bc 12,2,.L179
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L179
	lis 11,g_edicts@ha
	lis 0,0xbfc5
	lwz 9,g_edicts@l(11)
	ori 0,0,18087
	subf 9,9,10
	mullw 9,9,0
	srawi 9,9,2
	addi 9,9,1311
	sth 9,152(31)
	b .L180
.L179:
	li 0,0
	sth 0,152(31)
.L180:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 G_SetSpectatorStats,.Lfe8-G_SetSpectatorStats
	.section	".rodata"
	.align 2
.LC57:
	.long 0x3f800000
	.align 3
.LC58:
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
	lis 11,.LC57@ha
	lis 9,maxclients@ha
	la 11,.LC57@l(11)
	mr 30,3
	lfs 13,0(11)
	li 29,1
	lis 26,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L168
	lis 9,.LC58@ha
	lis 28,g_edicts@ha
	la 9,.LC58@l(9)
	lis 27,0x4330
	lfd 31,0(9)
	li 31,1116
.L170:
	lwz 9,g_edicts@l(28)
	add 9,31,9
	lwz 0,88(9)
	lwz 3,84(9)
	cmpwi 0,0,0
	bc 12,2,.L169
	lwz 0,3828(3)
	cmpw 0,0,30
	bc 4,2,.L169
	lwz 4,84(30)
	addi 3,3,120
	li 5,64
	addi 4,4,120
	crxor 6,6,6
	bl memcpy
	lwz 3,g_edicts@l(28)
	add 3,3,31
	bl G_SetSpectatorStats
.L169:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 31,31,1116
	stw 0,12(1)
	stw 27,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L170
.L168:
	lwz 0,52(1)
	mtlr 0
	lmw 26,16(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 G_CheckChaseStats,.Lfe9-G_CheckChaseStats
	.section	".rodata"
	.align 2
.LC59:
	.long 0x0
	.section	".text"
	.align 2
	.globl DeathmatchScoreboard
	.type	 DeathmatchScoreboard,@function
DeathmatchScoreboard:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC59@ha
	lis 9,teamplay@ha
	la 11,.LC59@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L86
	lwz 4,540(31)
	bl DeathmatchScoreboardMessage
	b .L87
.L86:
	lwz 4,540(31)
	mr 3,31
	crxor 6,6,6
	bl TeamplayScoreboardMessage
.L87:
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe10:
	.size	 DeathmatchScoreboard,.Lfe10-DeathmatchScoreboard
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
