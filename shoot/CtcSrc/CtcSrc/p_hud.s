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
	stw 0,3476(9)
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
	stfs 8,3688(9)
	lwz 11,84(31)
	lwz 10,deathmatch@l(5)
	stfs 8,3692(11)
	lwz 9,84(31)
	stfs 8,3696(9)
	lwz 11,84(31)
	stfs 8,3700(11)
	lwz 9,84(31)
	stw 8,3704(9)
	lwz 11,84(31)
	stfs 8,3708(11)
	stw 8,248(31)
	stw 8,508(31)
	stw 8,40(31)
	stw 8,44(31)
	stw 8,48(31)
	stw 8,52(31)
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
	lis 9,.LC7@ha
	lis 28,g_edicts@ha
	la 9,.LC7@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 31,896
.L16:
	lwz 0,g_edicts@l(28)
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
	addi 31,31,896
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
	mulli 9,30,896
	addi 7,30,1
	addi 9,9,896
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
	addi 10,10,72
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
	li 31,896
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
	addi 31,31,896
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
	.string	"camera"
	.align 2
.LC9:
	.string	"i_fixme"
	.align 2
.LC10:
	.string	"tag3"
	.align 2
.LC11:
	.string	"tag1"
	.align 2
.LC12:
	.string	"tag2"
	.align 2
.LC13:
	.string	"xv %i yv %i picn %s "
	.align 2
.LC14:
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
	mr 20,3
	mr 21,4
	bl Chicken_TCTCScoreboard
	cmpwi 0,3,0
	bc 4,2,.L51
	lis 9,game@ha
	li 27,0
	la 9,game@l(9)
	li 28,0
	lwz 0,1544(9)
	addi 23,1,1040
	lis 17,gi@ha
	cmpw 0,27,0
	bc 4,0,.L54
	mr 25,9
	lis 31,g_edicts@ha
.L56:
	mulli 9,28,896
	lwz 11,g_edicts@l(31)
	addi 26,28,1
	addi 9,9,896
	add 29,11,9
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L55
	lwz 0,260(29)
	cmpwi 0,0,1
	bc 12,2,.L55
	lwz 3,280(29)
	lis 4,.LC8@ha
	la 4,.LC8@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L55
	lwz 0,1028(25)
	mulli 9,28,3832
	li 5,0
	addi 4,1,3472
	cmpw 0,5,27
	addi 3,1,2448
	add 9,9,0
	addi 30,27,1
	lwz 29,3424(9)
	bc 4,0,.L60
	lwz 0,3472(1)
	cmpw 0,29,0
	bc 12,1,.L60
	mr 9,4
.L61:
	addi 5,5,1
	cmpw 0,5,27
	bc 4,0,.L60
	lwzu 0,4(9)
	cmpw 0,29,0
	bc 4,1,.L61
.L60:
	cmpw 0,27,5
	mr 7,27
	slwi 12,5,2
	bc 4,1,.L66
	slwi 9,27,2
	mr 6,3
	mr 10,9
	mr 8,4
	addi 11,9,-4
.L68:
	lwzx 9,11,6
	addi 7,7,-1
	cmpw 0,7,5
	stwx 9,10,6
	lwzx 0,11,8
	addi 11,11,-4
	stwx 0,10,8
	addi 10,10,-4
	bc 12,1,.L68
.L66:
	stwx 28,3,12
	mr 27,30
	stwx 29,4,12
.L55:
	lwz 0,1544(25)
	mr 28,26
	cmpw 0,28,0
	bc 12,0,.L56
.L54:
	li 0,0
	mr 3,23
	stb 0,1040(1)
	li 28,0
	bl strlen
	cmpwi 7,27,13
	mr 31,3
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 0,27,0
	rlwinm 9,9,0,28,29
	or 27,0,9
	cmpw 0,28,27
	bc 4,0,.L73
	lis 9,game@ha
	lis 18,g_edicts@ha
	la 19,game@l(9)
	addi 24,1,2448
	li 22,0
.L75:
	addi 9,1,2448
	la 11,gi@l(17)
	lwz 10,1028(19)
	lwzx 0,9,22
	lis 3,.LC9@ha
	lwz 8,40(11)
	la 3,.LC9@l(3)
	mulli 9,0,896
	lwz 11,g_edicts@l(18)
	mtlr 8
	mulli 0,0,3832
	addi 9,9,896
	add 29,11,9
	add 30,10,0
	blrl
	lis 9,0x2aaa
	srawi 11,28,31
	lwz 10,84(29)
	ori 9,9,43691
	cmpwi 7,28,6
	mulhw 9,28,9
	cmpwi 6,10,0
	subf 9,11,9
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	mulli 9,9,6
	neg 0,0
	andi. 25,0,160
	subf 9,9,28
	slwi 9,9,5
	addi 26,9,32
	bc 12,26,.L78
	lis 9,chickenItemIndex@ha
	addi 11,10,740
	lwz 0,chickenItemIndex@l(9)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,1,.L78
	lwz 0,3764(10)
	cmpwi 0,0,0
	bc 4,2,.L78
	lis 9,.LC10@ha
	la 8,.LC10@l(9)
	b .L79
.L78:
	cmpw 0,29,20
	bc 4,2,.L80
	lis 9,.LC11@ha
	la 8,.LC11@l(9)
	b .L79
.L80:
	cmpw 0,29,21
	bc 4,2,.L82
	lis 9,.LC12@ha
	la 8,.LC12@l(9)
	b .L79
.L82:
	li 8,0
.L79:
	cmpwi 0,8,0
	bc 12,2,.L84
	lis 5,.LC13@ha
	addi 3,1,16
	la 5,.LC13@l(5)
	li 4,1024
	addi 6,25,32
	mr 7,26
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,16
	bl strlen
	add 29,31,3
	cmpwi 0,29,1024
	bc 12,1,.L73
	add 3,23,31
	addi 4,1,16
	bl strcpy
	mr 31,29
.L84:
	lis 9,level@ha
	lwz 10,3420(30)
	lis 0,0x1b4e
	lwz 11,level@l(9)
	ori 0,0,33205
	lis 5,.LC14@ha
	lwz 8,0(24)
	addi 3,1,16
	la 5,.LC14@l(5)
	subf 11,10,11
	lwz 9,3424(30)
	mr 6,25
	mulhw 0,11,0
	lwz 10,184(30)
	mr 7,26
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
	add 29,31,3
	cmpwi 0,29,1024
	bc 12,1,.L73
	add 3,23,31
	addi 4,1,16
	bl strcpy
	addi 28,28,1
	mr 31,29
	cmpw 0,28,27
	addi 22,22,4
	bc 12,0,.L75
.L73:
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
.L51:
	lwz 0,4564(1)
	mtlr 0
	lmw 17,4500(1)
	la 1,4560(1)
	blr
.Lfe3:
	.size	 DeathmatchScoreboardMessage,.Lfe3-DeathmatchScoreboardMessage
	.section	".rodata"
	.align 2
.LC15:
	.string	"easy"
	.align 2
.LC16:
	.string	"medium"
	.align 2
.LC17:
	.string	"hard"
	.align 2
.LC18:
	.string	"hard+"
	.align 2
.LC19:
	.string	"xv 32 yv 8 picn help xv 202 yv 12 string2 \"%s\" xv 0 yv 24 cstring2 \"%s\" xv 0 yv 54 cstring2 \"%s\" xv 0 yv 110 cstring2 \"%s\" xv 50 yv 164 string2 \" kills     goals    secrets\" xv 50 yv 172 string2 \"%3i/%3i     %i/%i       %i/%i\" "
	.align 2
.LC20:
	.long 0x0
	.align 2
.LC21:
	.long 0x3f800000
	.align 2
.LC22:
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
	lis 11,.LC20@ha
	lis 9,skill@ha
	la 11,.LC20@l(11)
	mr 31,3
	lfs 0,0(11)
	lwz 11,skill@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 4,2,.L94
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
	b .L95
.L94:
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L96
	lis 9,.LC16@ha
	la 6,.LC16@l(9)
	b .L95
.L96:
	lis 11,.LC22@ha
	la 11,.LC22@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L98
	lis 9,.LC17@ha
	la 6,.LC17@l(9)
	b .L95
.L98:
	lis 9,.LC18@ha
	la 6,.LC18@l(9)
.L95:
	lis 11,level@ha
	lis 8,game@ha
	la 11,level@l(11)
	la 8,game@l(8)
	lwz 0,272(11)
	lis 5,.LC19@ha
	addi 9,8,512
	lwz 29,268(11)
	li 4,1024
	addi 3,1,32
	lwz 26,284(11)
	addi 7,11,8
	la 5,.LC19@l(5)
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
.LC23:
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
	lis 11,.LC23@ha
	lwz 8,deathmatch@l(9)
	la 11,.LC23@l(11)
	mr 31,3
	lfs 13,0(11)
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L101
	lwz 11,84(31)
	li 10,0
	stw 10,3480(11)
	lwz 9,84(31)
	stw 10,3484(9)
	lwz 11,84(31)
	stw 10,3728(11)
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 4,2,.L102
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L100
.L102:
	lwz 9,84(31)
	lwz 0,3476(9)
	cmpwi 0,0,0
	bc 12,2,.L104
	stw 10,3476(9)
	b .L100
.L104:
	li 0,1
	mr 3,31
	stw 0,3476(9)
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
	stw 8,3480(9)
	lwz 11,84(31)
	stw 8,3476(11)
	lwz 10,84(31)
	lwz 0,3484(10)
	cmpwi 0,0,0
	bc 12,2,.L106
	lis 9,game+1024@ha
	lwz 11,3440(10)
	lwz 0,game+1024@l(9)
	cmpw 0,11,0
	bc 4,2,.L106
	stw 8,3484(10)
	b .L100
.L106:
	lwz 11,84(31)
	li 0,1
	li 10,0
	mr 3,31
	stw 0,3484(11)
	lwz 9,84(31)
	stw 10,3444(9)
	bl HelpComputer
.L100:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 Cmd_Help_f,.Lfe5-Cmd_Help_f
	.section	".rodata"
	.align 2
.LC24:
	.string	"cells"
	.align 2
.LC25:
	.string	"misc/power2.wav"
	.align 2
.LC26:
	.string	"i_powershield"
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
	.string	"i_help"
	.align 2
.LC32:
	.long 0x3f800000
	.align 2
.LC33:
	.long 0x0
	.align 3
.LC34:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC35:
	.long 0x41200000
	.align 2
.LC36:
	.long 0x42b60000
	.section	".text"
	.align 2
	.globl G_SetStats
	.type	 G_SetStats,@function
G_SetStats:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 24,24(1)
	stw 0,68(1)
	mr 31,3
	lis 9,chickenItemIndex@ha
	lwz 11,84(31)
	lis 10,level+266@ha
	li 24,0
	lwz 0,chickenItemIndex@l(9)
	lis 25,level@ha
	addi 9,11,740
	lhz 8,level+266@l(10)
	slwi 0,0,2
	lwz 26,3780(11)
	lwzx 28,9,0
	sth 8,120(11)
	lwz 9,84(31)
	lhz 0,482(31)
	sth 0,122(9)
	lwz 9,84(31)
	lwz 11,3492(9)
	cmpwi 0,11,0
	bc 4,2,.L108
	sth 24,124(9)
	lwz 9,84(31)
	sth 24,126(9)
	b .L109
.L108:
	mulli 11,11,72
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
	lwz 9,3492(11)
	slwi 9,9,2
	add 9,11,9
	lhz 0,742(9)
	sth 0,126(11)
.L109:
	mr 3,31
	bl PowerArmorType
	mr. 30,3
	bc 12,2,.L110
	lis 3,.LC24@ha
	lwz 29,84(31)
	la 3,.LC24@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	addic 0,28,-1
	subfe 9,0,28
	srawi 3,3,3
	slwi 3,3,2
	lwzx 27,29,3
	subfic 7,27,0
	adde 0,7,27
	or. 10,9,0
	bc 4,2,.L112
	lwz 0,260(31)
	addic 11,26,-1
	subfe 9,11,26
	xori 0,0,1
	subfic 7,0,0
	adde 0,7,0
	or. 10,0,9
	bc 12,2,.L110
.L112:
	lwz 0,264(31)
	lis 29,gi@ha
	lis 3,.LC25@ha
	la 29,gi@l(29)
	la 3,.LC25@l(3)
	rlwinm 0,0,0,20,18
	li 30,0
	stw 0,264(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC32@ha
	lis 9,.LC32@ha
	lis 10,.LC33@ha
	mr 5,3
	la 7,.LC32@l(7)
	la 9,.LC32@l(9)
	mtlr 0
	la 10,.LC33@l(10)
	li 4,3
	lfs 1,0(7)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L110:
	mr 3,31
	bl ArmorIndex
	cmpwi 0,30,0
	mr 29,3
	bc 12,2,.L113
	cmpwi 0,29,0
	bc 12,2,.L114
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 7,0,8
	bc 12,2,.L113
.L114:
	lis 9,gi+40@ha
	lis 3,.LC26@ha
	lwz 0,gi+40@l(9)
	la 3,.LC26@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,128(9)
	lwz 11,84(31)
	sth 27,130(11)
	b .L115
.L113:
	cmpwi 0,29,0
	bc 12,2,.L116
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
	b .L115
.L116:
	lwz 9,84(31)
	sth 29,128(9)
	lwz 11,84(31)
	sth 29,130(11)
.L115:
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,3720(11)
	fcmpu 0,13,0
	bc 4,1,.L118
	li 0,0
	sth 0,134(11)
	lwz 9,84(31)
	sth 0,136(9)
.L118:
	lwz 0,260(31)
	subfic 7,26,0
	adde 11,7,26
	xori 0,0,1
	addic 10,0,-1
	subfe 9,10,0
	and. 0,9,11
	bc 12,2,.L119
	cmpwi 7,28,0
	lwz 8,84(31)
	bc 4,30,.L120
	lwz 0,level@l(25)
	lis 30,0x4330
	lis 7,.LC34@ha
	lfs 13,3688(8)
	xoris 0,0,0x8000
	la 7,.LC34@l(7)
	stw 0,20(1)
	stw 30,16(1)
	lfd 31,0(7)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L120
	lis 9,gi+40@ha
	lis 3,.LC27@ha
	lwz 0,gi+40@l(9)
	la 3,.LC27@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 7,.LC35@ha
	la 7,.LC35@l(7)
	mr 11,9
	sth 3,138(10)
	lwz 0,level@l(25)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(7)
	stw 0,20(1)
	stw 30,16(1)
	lfd 13,16(1)
	lfs 0,3688(10)
	b .L149
.L120:
	lis 11,level@ha
	lfs 12,3692(8)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC34@ha
	xoris 0,0,0x8000
	la 11,.LC34@l(11)
	stw 0,20(1)
	stw 10,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L124
	lis 11,chickenGame@ha
	addic 0,28,-1
	subfe 10,0,28
	lwz 0,chickenGame@l(11)
	addic 7,0,-1
	subfe 9,7,0
	and. 11,9,10
	bc 12,2,.L124
	lis 9,allowInvulnerable@ha
	lwz 0,allowInvulnerable@l(9)
	cmpwi 0,0,0
	bc 4,2,.L123
.L124:
	bc 4,30,.L122
	lis 11,level@ha
	lfs 12,3692(8)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 7,.LC34@ha
	la 7,.LC34@l(7)
	xoris 0,0,0x8000
	lfd 13,0(7)
	stw 0,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L122
.L123:
	lis 9,gi+40@ha
	lis 3,.LC28@ha
	lwz 0,gi+40@l(9)
	la 3,.LC28@l(3)
	mtlr 0
	blrl
	lwz 11,84(31)
	lis 10,level@ha
	lis 8,0x4330
	lis 7,.LC34@ha
	sth 3,138(11)
	la 7,.LC34@l(7)
	lwz 0,level@l(10)
	lis 11,.LC35@ha
	lfd 11,0(7)
	la 11,.LC35@l(11)
	xoris 0,0,0x8000
	lwz 7,84(31)
	stw 0,20(1)
	stw 8,16(1)
	lfd 13,16(1)
	lfs 0,3692(7)
	lfs 10,0(11)
	fsub 13,13,11
	mr 11,9
	frsp 13,13
	fsubs 0,0,13
	fdivs 0,0,10
	fctiwz 12,0
	stfd 12,16(1)
	lwz 11,20(1)
	sth 11,140(7)
	b .L130
.L122:
	lis 11,level@ha
	lwz 10,84(31)
	lwz 0,level@l(11)
	lis 29,0x4330
	lis 7,.LC34@ha
	la 7,.LC34@l(7)
	lfs 13,3700(10)
	xoris 0,0,0x8000
	lfd 31,0(7)
	stw 0,20(1)
	stw 29,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 12,0
	fcmpu 0,13,12
	bc 4,1,.L126
	lis 9,gi+40@ha
	lis 3,.LC29@ha
	lwz 0,gi+40@l(9)
	la 3,.LC29@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 7,.LC35@ha
	la 7,.LC35@l(7)
	mr 11,9
	sth 3,138(10)
	lwz 0,level@l(25)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(7)
	stw 0,20(1)
	stw 29,16(1)
	lfd 13,16(1)
	lfs 0,3700(10)
	b .L149
.L126:
	lfs 0,3696(10)
	fcmpu 0,0,12
	bc 4,1,.L128
	lis 9,gi+40@ha
	lis 3,.LC30@ha
	lwz 0,gi+40@l(9)
	la 3,.LC30@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 7,.LC35@ha
	la 7,.LC35@l(7)
	mr 11,9
	sth 3,138(10)
	lwz 0,level@l(25)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(7)
	stw 0,20(1)
	stw 29,16(1)
	lfd 13,16(1)
	lfs 0,3696(10)
.L149:
	fsub 13,13,31
	frsp 13,13
	fsubs 0,0,13
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,16(1)
	lwz 11,20(1)
	sth 11,140(10)
	b .L130
.L128:
.L119:
	li 24,1
.L130:
	cmpwi 0,24,0
	bc 12,2,.L131
	lis 8,level@ha
	lwz 10,84(31)
	lwz 0,level@l(8)
	lis 7,0x4330
	lis 11,.LC34@ha
	la 11,.LC34@l(11)
	li 6,0
	xoris 0,0,0x8000
	lfd 13,0(11)
	stw 0,20(1)
	mr 11,9
	stw 7,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,3692(10)
	lwz 0,level@l(8)
	lwz 10,84(31)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 7,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,3688(10)
	lwz 9,84(31)
	sth 6,138(9)
	lwz 11,84(31)
	sth 6,140(11)
.L131:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L132
	li 0,0
	sth 0,132(9)
	b .L133
.L132:
	lis 9,itemlist@ha
	lis 11,gi+40@ha
	mulli 0,0,72
	la 9,itemlist@l(9)
	lwz 11,gi+40@l(11)
	addi 9,9,36
	lwzx 3,9,0
	mtlr 11
	blrl
	lwz 9,84(31)
	sth 3,132(9)
.L133:
	lwz 11,84(31)
	lis 9,deathmatch@ha
	li 10,0
	lwz 8,deathmatch@l(9)
	lis 7,.LC33@ha
	lhz 0,738(11)
	la 7,.LC33@l(7)
	lfs 13,0(7)
	sth 0,144(11)
	lwz 9,84(31)
	sth 10,146(9)
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L134
	lwz 11,84(31)
	lwz 0,724(11)
	cmpwi 0,0,0
	bc 4,1,.L136
	lis 9,level+200@ha
	lfs 0,level+200@l(9)
	fcmpu 0,0,13
	bc 4,2,.L136
	lwz 0,3476(11)
	cmpwi 0,0,0
	bc 12,2,.L135
.L136:
	lwz 9,84(31)
	lhz 0,146(9)
	ori 0,0,1
	sth 0,146(9)
.L135:
	lwz 9,84(31)
	lwz 0,3480(9)
	cmpwi 0,0,0
	bc 12,2,.L137
	lwz 0,724(9)
	cmpwi 0,0,0
	bc 4,1,.L137
	lhz 0,146(9)
	ori 0,0,2
	sth 0,146(9)
.L137:
	mr 3,31
	bl Chicken_ShowMenu
	cmpwi 0,3,0
	bc 12,2,.L139
	lwz 9,84(31)
	lhz 0,146(9)
	ori 0,0,1
	b .L150
.L134:
	lwz 9,84(31)
	lwz 0,3476(9)
	cmpwi 0,0,0
	bc 4,2,.L141
	lwz 0,3484(9)
	cmpwi 0,0,0
	bc 12,2,.L140
.L141:
	lhz 0,146(9)
	ori 0,0,1
	sth 0,146(9)
.L140:
	lwz 9,84(31)
	lwz 0,3480(9)
	cmpwi 0,0,0
	bc 12,2,.L139
	lwz 0,724(9)
	cmpwi 0,0,0
	bc 4,1,.L139
	lhz 0,146(9)
	ori 0,0,2
.L150:
	sth 0,146(9)
.L139:
	lis 9,teams@ha
	lwz 0,teams@l(9)
	cmpwi 0,0,0
	bc 4,2,.L143
	lwz 9,84(31)
	lhz 0,3426(9)
	sth 0,148(9)
.L143:
	lwz 9,84(31)
	lwz 0,3444(9)
	mr 8,9
	cmpwi 0,0,0
	bc 12,2,.L144
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 7,0,8
	bc 12,2,.L144
	lis 9,gi+40@ha
	lis 3,.LC31@ha
	lwz 0,gi+40@l(9)
	la 3,.LC31@l(3)
	b .L151
.L144:
	lwz 0,716(8)
	cmpwi 0,0,2
	bc 12,2,.L147
	lis 7,.LC36@ha
	lfs 13,112(8)
	la 7,.LC36@l(7)
	lfs 0,0(7)
	fcmpu 0,13,0
	bc 4,1,.L146
.L147:
	lwz 11,1788(8)
	cmpwi 0,11,0
	bc 12,2,.L146
	lis 9,gi+40@ha
	lwz 3,36(11)
	lwz 0,gi+40@l(9)
.L151:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,142(9)
	b .L145
.L146:
	li 0,0
	sth 0,142(8)
.L145:
	mr 3,31
	bl Chicken_Stats
	lwz 0,68(1)
	mtlr 0
	lmw 24,24(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe6:
	.size	 G_SetStats,.Lfe6-G_SetStats
	.section	".rodata"
	.align 2
.LC37:
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
	lis 10,.LC37@ha
	mr 31,3
	la 10,.LC37@l(10)
	lwz 11,84(31)
	lis 9,deathmatch@ha
	lfs 13,0(10)
	li 8,0
	lwz 10,deathmatch@l(9)
	stw 8,3480(11)
	lwz 9,84(31)
	stw 8,3484(9)
	lwz 11,84(31)
	stw 8,3728(11)
	lfs 0,20(10)
	fcmpu 0,0,13
	bc 4,2,.L90
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L89
.L90:
	lwz 9,84(31)
	lwz 0,3476(9)
	cmpwi 0,0,0
	bc 12,2,.L91
	stw 8,3476(9)
	b .L89
.L91:
	li 0,1
	mr 3,31
	stw 0,3476(9)
	lwz 4,540(31)
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L89:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 Cmd_Score_f,.Lfe7-Cmd_Score_f
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
.Lfe8:
	.size	 DeathmatchScoreboard,.Lfe8-DeathmatchScoreboard
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
