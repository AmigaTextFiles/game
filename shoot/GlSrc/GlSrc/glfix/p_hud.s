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
	stw 0,3496(9)
.L7:
	lis 10,level@ha
	lis 9,.LC1@ha
	lwz 6,84(31)
	la 10,level@l(10)
	la 9,.LC1@l(9)
	lfs 0,232(10)
	li 0,4
	lis 5,.LC0@ha
	lfs 9,0(9)
	li 8,0
	la 5,.LC0@l(5)
	lfs 8,0(5)
	stfs 0,4(31)
	mr 11,9
	mr 7,9
	lfs 0,236(10)
	lis 5,deathmatch@ha
	stfs 0,8(31)
	lfs 13,240(10)
	stfs 13,12(31)
	lfs 0,232(10)
	fmuls 0,0,9
	fctiwz 12,0
	stfd 12,16(1)
	lwz 9,20(1)
	sth 9,4(6)
	lfs 0,236(10)
	lwz 9,84(31)
	fmuls 0,0,9
	fctiwz 11,0
	stfd 11,16(1)
	lwz 11,20(1)
	sth 11,6(9)
	lfs 0,240(10)
	lwz 11,84(31)
	fmuls 0,0,9
	fctiwz 10,0
	stfd 10,16(1)
	lwz 7,20(1)
	sth 7,8(11)
	lfs 0,244(10)
	lwz 9,84(31)
	stfs 0,28(9)
	lfs 0,248(10)
	lwz 11,84(31)
	stfs 0,32(11)
	lfs 13,252(10)
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
	stfs 8,3708(9)
	lwz 11,84(31)
	lwz 10,deathmatch@l(5)
	stfs 8,3712(11)
	lwz 9,84(31)
	stfs 8,3716(9)
	lwz 11,84(31)
	stfs 8,3720(11)
	lwz 9,84(31)
	stw 8,3724(9)
	lwz 11,84(31)
	stfs 8,3728(11)
	stw 8,248(31)
	stw 8,604(31)
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
	lis 9,level+220@ha
	la 11,.LC6@l(11)
	lfs 0,level+220@l(9)
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
	li 31,992
.L16:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L15
	lwz 0,576(3)
	cmpwi 0,0,0
	bc 12,1,.L15
	bl respawn
.L15:
	addi 30,30,1
	lwz 11,maxclients@l(26)
	xoris 0,30,0x8000
	addi 31,31,992
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
	stfs 0,220(31)
	lwz 0,600(27)
	mr 3,0
	stw 0,224(31)
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
	mulli 9,30,992
	addi 7,30,1
	addi 9,9,992
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
	stw 0,228(31)
	b .L11
.L34:
	lis 9,level+228@ha
	li 0,0
	lis 5,.LC3@ha
	stw 0,level+228@l(9)
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
	stfs 0,232(9)
	la 11,.LC6@l(11)
	lfs 0,8(31)
	lfs 12,0(11)
	stfs 0,236(9)
	lfs 13,12(31)
	stfs 13,240(9)
	lfs 0,16(31)
	stfs 0,244(9)
	lfs 13,20(31)
	stfs 13,248(9)
	lfs 0,24(31)
	stfs 0,252(9)
	lfs 13,20(10)
	fcmpu 0,12,13
	bc 4,0,.L11
	lis 9,.LC7@ha
	lis 28,g_edicts@ha
	la 9,.LC7@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 31,992
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
	addi 31,31,992
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
	mulli 9,28,992
	addi 27,28,1
	add 29,9,24
	lwz 0,1080(29)
	cmpwi 0,0,0
	bc 12,2,.L54
	lwz 0,1028(26)
	mulli 9,28,3804
	add 9,9,0
	lwz 11,3464(9)
	cmpwi 0,11,0
	bc 4,2,.L54
	li 5,0
	lwz 29,3448(9)
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
	lis 3,.LC8@ha
	lwz 8,40(11)
	la 3,.LC8@l(3)
	mulli 9,0,992
	lwz 11,g_edicts@l(18)
	mtlr 8
	mulli 0,0,3804
	addi 9,9,992
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
	lis 9,.LC9@ha
	la 8,.LC9@l(9)
	b .L78
.L77:
	cmpw 0,29,21
	bc 4,2,.L79
	lis 9,.LC10@ha
	la 8,.LC10@l(9)
	b .L78
.L79:
	li 8,0
.L78:
	cmpwi 0,8,0
	bc 12,2,.L81
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
	bc 12,1,.L72
	add 3,23,30
	addi 4,1,16
	bl strcpy
	mr 30,29
.L81:
	lis 9,level@ha
	lwz 10,3444(31)
	lis 0,0x1b4e
	lwz 11,level@l(9)
	ori 0,0,33205
	lis 5,.LC12@ha
	lwz 8,0(24)
	addi 3,1,16
	la 5,.LC12@l(5)
	subf 11,10,11
	lwz 9,3448(31)
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
.LC13:
	.string	"easy"
	.align 2
.LC14:
	.string	"medium"
	.align 2
.LC15:
	.string	"hard"
	.align 2
.LC16:
	.string	"hard+"
	.align 2
.LC17:
	.string	"xv 32 yv 8 picn help xv 202 yv 12 string2 \"%s\" xv 0 yv 24 cstring2 \"%s\" xv 0 yv 54 cstring2 \"%s\" xv 0 yv 110 cstring2 \"%s\" xv 50 yv 164 string2 \" kills     goals    secrets\" xv 50 yv 172 string2 \"%3i/%3i     %i/%i       %i/%i\" "
	.align 2
.LC18:
	.long 0x0
	.align 2
.LC19:
	.long 0x3f800000
	.align 2
.LC20:
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
	lis 11,.LC18@ha
	lis 9,skill@ha
	la 11,.LC18@l(11)
	mr 31,3
	lfs 0,0(11)
	lwz 11,skill@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 4,2,.L91
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L92
.L91:
	lis 9,.LC19@ha
	la 9,.LC19@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L93
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L92
.L93:
	lis 11,.LC20@ha
	la 11,.LC20@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L95
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
	b .L92
.L95:
	lis 9,.LC16@ha
	la 6,.LC16@l(9)
.L92:
	lis 11,level@ha
	lis 8,game@ha
	la 11,level@l(11)
	la 8,game@l(8)
	lwz 0,292(11)
	lis 5,.LC17@ha
	addi 9,8,512
	lwz 29,288(11)
	li 4,1024
	addi 3,1,32
	lwz 26,304(11)
	addi 7,11,28
	la 5,.LC17@l(5)
	lwz 27,300(11)
	lwz 28,296(11)
	lwz 10,308(11)
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
.LC21:
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
	lis 11,.LC21@ha
	lwz 10,deathmatch@l(9)
	la 11,.LC21@l(11)
	mr 31,3
	lfs 13,0(11)
	lfs 0,20(10)
	fcmpu 0,0,13
	bc 12,2,.L98
	lwz 9,84(31)
	li 8,0
	stw 8,3500(9)
	lwz 11,84(31)
	stw 8,3504(11)
	lfs 0,20(10)
	fcmpu 0,0,13
	bc 4,2,.L99
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L97
.L99:
	lwz 9,84(31)
	lwz 0,3496(9)
	cmpwi 0,0,0
	bc 12,2,.L101
	stw 8,3496(9)
	b .L97
.L101:
	li 0,1
	mr 3,31
	stw 0,3496(9)
	lwz 4,636(31)
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L97
.L98:
	lwz 9,84(31)
	li 8,0
	stw 8,3500(9)
	lwz 11,84(31)
	stw 8,3496(11)
	lwz 10,84(31)
	lwz 0,3504(10)
	cmpwi 0,0,0
	bc 12,2,.L103
	lis 9,game+1024@ha
	lwz 11,1804(10)
	lwz 0,game+1024@l(9)
	cmpw 0,11,0
	bc 4,2,.L103
	stw 8,3504(10)
	b .L97
.L103:
	lwz 11,84(31)
	li 0,1
	li 10,0
	mr 3,31
	stw 0,3504(11)
	lwz 9,84(31)
	stw 10,1808(9)
	bl HelpComputer
.L97:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 Cmd_Help_f,.Lfe5-Cmd_Help_f
	.section	".rodata"
	.align 2
.LC22:
	.string	"gl_i"
	.align 2
.LC23:
	.string	"cells"
	.align 2
.LC24:
	.string	"misc/power2.wav"
	.align 2
.LC25:
	.string	"i_powershield"
	.align 2
.LC26:
	.string	"p_quad"
	.align 2
.LC27:
	.string	"p_invulnerability"
	.align 2
.LC28:
	.string	"p_envirosuit"
	.align 2
.LC29:
	.string	"p_rebreather"
	.align 2
.LC30:
	.string	"Cells"
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
	stmw 27,36(1)
	stw 0,68(1)
	mr 31,3
	lwz 0,320(31)
	cmpwi 0,0,0
	bc 12,2,.L105
	lis 9,gi+40@ha
	lis 3,.LC22@ha
	lwz 0,gi+40@l(9)
	la 3,.LC22@l(3)
	lis 27,level@ha
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,120(9)
	lwz 11,84(31)
	lhz 0,578(31)
	sth 0,122(11)
	b .L106
.L105:
	lis 9,level+286@ha
	lwz 11,84(31)
	lis 27,level@ha
	lhz 0,level+286@l(9)
	sth 0,120(11)
	lwz 9,84(31)
	lhz 0,578(31)
	sth 0,122(9)
.L106:
	lwz 9,84(31)
	lwz 11,3512(9)
	cmpwi 0,11,0
	bc 4,2,.L107
	sth 11,124(9)
	lwz 9,84(31)
	sth 11,126(9)
	b .L108
.L107:
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
	lwz 9,3512(11)
	slwi 9,9,2
	add 9,11,9
	lhz 0,742(9)
	sth 0,126(11)
.L108:
	mr 3,31
	bl PowerArmorType
	mr. 30,3
	bc 12,2,.L109
	lis 3,.LC23@ha
	lwz 29,84(31)
	la 3,.LC23@l(3)
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
	bc 4,2,.L109
	lwz 0,264(31)
	lis 29,gi@ha
	lis 3,.LC24@ha
	la 29,gi@l(29)
	la 3,.LC24@l(3)
	rlwinm 0,0,0,20,18
	li 30,0
	stw 0,264(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC32@ha
	lis 9,.LC32@ha
	lis 11,.LC33@ha
	mr 5,3
	la 7,.LC32@l(7)
	la 9,.LC32@l(9)
	mtlr 0
	la 11,.LC33@l(11)
	li 4,3
	lfs 1,0(7)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L109:
	mr 3,31
	bl ArmorIndex
	cmpwi 0,30,0
	mr 29,3
	bc 12,2,.L111
	cmpwi 0,29,0
	bc 12,2,.L112
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 7,0,8
	bc 12,2,.L111
.L112:
	lis 9,gi+40@ha
	lis 3,.LC25@ha
	lwz 0,gi+40@l(9)
	la 3,.LC25@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,128(9)
	lwz 11,84(31)
	sth 28,130(11)
	b .L113
.L111:
	cmpwi 0,29,0
	bc 12,2,.L114
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
	b .L113
.L114:
	lwz 9,84(31)
	sth 29,128(9)
	lwz 11,84(31)
	sth 29,130(11)
.L113:
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,3740(11)
	fcmpu 0,13,0
	bc 4,1,.L116
	li 0,0
	sth 0,134(11)
	lwz 9,84(31)
	sth 0,136(9)
.L116:
	lwz 0,level@l(27)
	lis 30,0x4330
	lis 7,.LC34@ha
	lwz 11,84(31)
	xoris 0,0,0x8000
	la 7,.LC34@l(7)
	stw 0,28(1)
	stw 30,24(1)
	lfd 31,0(7)
	lfd 0,24(1)
	lfs 13,3708(11)
	fsub 0,0,31
	frsp 12,0
	fcmpu 0,13,12
	bc 4,1,.L117
	lis 9,gi+40@ha
	lis 3,.LC26@ha
	lwz 0,gi+40@l(9)
	la 3,.LC26@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 7,.LC35@ha
	la 7,.LC35@l(7)
	mr 11,9
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(7)
	stw 0,28(1)
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3708(10)
	b .L149
.L117:
	lfs 0,3712(11)
	fcmpu 0,0,12
	bc 4,1,.L119
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
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(7)
	stw 0,28(1)
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3712(10)
	b .L149
.L119:
	lfs 0,3720(11)
	fcmpu 0,0,12
	bc 4,1,.L121
	lis 9,gi+40@ha
	lis 3,.LC28@ha
	lwz 0,gi+40@l(9)
	la 3,.LC28@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 7,.LC35@ha
	la 7,.LC35@l(7)
	mr 11,9
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(7)
	stw 0,28(1)
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3720(10)
	b .L149
.L121:
	lfs 0,3716(11)
	fcmpu 0,0,12
	bc 4,1,.L123
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
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(7)
	stw 0,28(1)
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3716(10)
.L149:
	fsub 13,13,31
	frsp 13,13
	fsubs 0,0,13
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,24(1)
	lwz 11,28(1)
	sth 11,140(10)
	b .L118
.L123:
	li 0,0
	sth 0,138(11)
	lwz 9,84(31)
	sth 0,140(9)
.L118:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L125
	li 0,0
	sth 0,132(9)
	b .L126
.L125:
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
.L126:
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
	bc 12,2,.L127
	lwz 11,84(31)
	lwz 0,724(11)
	cmpwi 0,0,0
	bc 4,1,.L129
	lis 9,level+220@ha
	lfs 0,level+220@l(9)
	fcmpu 0,0,13
	bc 4,2,.L129
	lwz 0,3496(11)
	cmpwi 0,0,0
	bc 12,2,.L132
.L129:
	lwz 9,84(31)
	b .L133
.L127:
	lwz 9,84(31)
	lwz 0,3496(9)
	cmpwi 0,0,0
	bc 4,2,.L133
	lwz 0,3504(9)
	cmpwi 0,0,0
	bc 12,2,.L132
.L133:
	lhz 0,146(9)
	ori 0,0,1
	sth 0,146(9)
.L132:
	lwz 9,84(31)
	lwz 0,3500(9)
	cmpwi 0,0,0
	bc 12,2,.L131
	lwz 0,724(9)
	cmpwi 0,0,0
	bc 4,1,.L131
	lhz 0,146(9)
	ori 0,0,2
	sth 0,146(9)
.L131:
	lwz 0,292(31)
	cmpwi 0,0,0
	bc 12,2,.L135
	lwz 0,376(31)
	lis 10,0x4330
	lis 11,.LC34@ha
	xoris 0,0,0x8000
	la 11,.LC34@l(11)
	stw 0,28(1)
	stw 10,24(1)
	lfd 13,0(11)
	lfd 0,24(1)
	lis 11,level+4@ha
	lfs 12,level+4@l(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,1,.L135
	fsubs 0,0,12
	b .L150
.L135:
	lwz 0,320(31)
	cmpwi 0,0,0
	mr 8,0
	bc 4,2,.L137
	lis 9,level@ha
	la 9,level@l(9)
	lis 10,0x4330
	lwz 0,12(9)
	lis 7,.LC34@ha
	la 7,.LC34@l(7)
	lfs 12,4(9)
	xoris 0,0,0x8000
	lfd 13,0(7)
	stw 0,28(1)
	stw 10,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,0,.L137
	lwz 0,16(9)
	mr 9,11
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 10,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,0,.L137
	lwz 9,84(31)
	lhz 0,3450(9)
	sth 0,148(9)
	b .L136
.L137:
	lis 9,level@ha
	la 9,level@l(9)
	lis 10,0x4330
	lwz 0,12(9)
	lis 7,.LC34@ha
	la 7,.LC34@l(7)
	lfs 13,4(9)
	xoris 0,0,0x8000
	lfd 12,0(7)
	stw 0,28(1)
	stw 10,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 4,1,.L139
	fsubs 0,0,13
	mr 9,11
	b .L150
.L139:
	lwz 0,16(9)
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 10,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 4,1,.L141
	fsubs 0,0,13
.L150:
	lwz 11,84(31)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 0,28(1)
	sth 0,148(11)
	b .L136
.L141:
	cmpwi 0,8,0
	bc 12,2,.L136
	lis 3,.LC30@ha
	la 3,.LC30@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 10,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,10,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,11,3
	sth 0,148(10)
.L136:
	lwz 9,84(31)
	lwz 0,1808(9)
	mr 11,9
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
	lwz 0,716(11)
	cmpwi 0,0,2
	bc 12,2,.L147
	lis 7,.LC36@ha
	lfs 13,112(11)
	la 7,.LC36@l(7)
	lfs 0,0(7)
	fcmpu 0,13,0
	bc 4,1,.L146
.L147:
	lwz 11,1788(11)
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
	lwz 9,84(31)
	li 0,0
	sth 0,142(9)
.L145:
	lwz 9,84(31)
	li 0,0
	sth 0,154(9)
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
	stw 8,3500(11)
	lwz 9,84(31)
	stw 8,3504(9)
	lfs 0,20(10)
	fcmpu 0,0,13
	bc 4,2,.L87
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L86
.L87:
	lwz 9,84(31)
	lwz 0,3496(9)
	cmpwi 0,0,0
	bc 12,2,.L88
	stw 8,3496(9)
	b .L86
.L88:
	li 0,1
	mr 3,31
	stw 0,3496(9)
	lwz 4,636(31)
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L86:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 Cmd_Score_f,.Lfe7-Cmd_Score_f
	.section	".rodata"
	.align 2
.LC38:
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
	lwz 0,3796(31)
	cmpwi 0,0,0
	bc 4,2,.L161
	bl G_SetStats
.L161:
	lwz 0,724(31)
	li 9,1
	li 11,0
	sth 9,154(31)
	cmpwi 0,0,0
	sth 11,146(31)
	bc 4,1,.L163
	lis 11,.LC38@ha
	lis 9,level+220@ha
	la 11,.LC38@l(11)
	lfs 0,level+220@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L163
	lwz 0,3496(31)
	cmpwi 0,0,0
	bc 12,2,.L162
.L163:
	lhz 0,146(31)
	ori 0,0,1
	sth 0,146(31)
.L162:
	lwz 0,3500(31)
	cmpwi 0,0,0
	bc 12,2,.L164
	lwz 0,724(31)
	cmpwi 0,0,0
	bc 4,1,.L164
	lhz 0,146(31)
	ori 0,0,2
	sth 0,146(31)
.L164:
	lwz 10,3796(31)
	cmpwi 0,10,0
	bc 12,2,.L165
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L165
	lis 11,g_edicts@ha
	lis 0,0xbdef
	lwz 9,g_edicts@l(11)
	ori 0,0,31711
	subf 9,9,10
	mullw 9,9,0
	srawi 9,9,5
	addi 9,9,1311
	sth 9,152(31)
	b .L166
.L165:
	li 0,0
	sth 0,152(31)
.L166:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 G_SetSpectatorStats,.Lfe8-G_SetSpectatorStats
	.section	".rodata"
	.align 2
.LC39:
	.long 0x3f800000
	.align 3
.LC40:
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
	lis 11,.LC39@ha
	lis 9,maxclients@ha
	la 11,.LC39@l(11)
	mr 30,3
	lfs 13,0(11)
	li 29,1
	lis 26,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L154
	lis 9,.LC40@ha
	lis 28,g_edicts@ha
	la 9,.LC40@l(9)
	lis 27,0x4330
	lfd 31,0(9)
	li 31,992
.L156:
	lwz 9,g_edicts@l(28)
	add 9,31,9
	lwz 0,88(9)
	lwz 3,84(9)
	cmpwi 0,0,0
	bc 12,2,.L155
	lwz 0,3796(3)
	cmpw 0,0,30
	bc 4,2,.L155
	lwz 4,84(30)
	addi 3,3,120
	li 5,64
	addi 4,4,120
	crxor 6,6,6
	bl memcpy
	lwz 3,g_edicts@l(28)
	add 3,3,31
	bl G_SetSpectatorStats
.L155:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 31,31,992
	stw 0,12(1)
	stw 27,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L156
.L154:
	lwz 0,52(1)
	mtlr 0
	lmw 26,16(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 G_CheckChaseStats,.Lfe9-G_CheckChaseStats
	.comm	maplist,292,4
	.align 2
	.globl DeathmatchScoreboard
	.type	 DeathmatchScoreboard,@function
DeathmatchScoreboard:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lwz 4,636(29)
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
