	.file	"p_hud.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 stuff_light,@object
	.size	 stuff_light,4
stuff_light:
	.long 1
	.section	".rodata"
	.align 2
.LC0:
	.string	"misc/beat2.wav"
	.align 2
.LC1:
	.string	"misc/beat1.wav"
	.align 2
.LC2:
	.string	"abcccbaaaaaaabaaaaaaaa"
	.align 2
.LC3:
	.long 0x0
	.align 2
.LC4:
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
	lis 11,.LC3@ha
	lis 9,deathmatch@ha
	la 11,.LC3@l(11)
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
	stw 0,3512(9)
.L7:
	lis 10,level@ha
	lis 9,.LC4@ha
	lwz 5,84(31)
	la 10,level@l(10)
	la 9,.LC4@l(9)
	lfs 0,212(10)
	li 0,4
	li 8,0
	lfs 9,0(9)
	li 6,0
	lis 4,last_beat@ha
	stfs 0,4(31)
	mr 11,9
	mr 7,9
	lfs 0,216(10)
	stfs 0,8(31)
	lfs 13,220(10)
	stfs 13,12(31)
	lfs 0,212(10)
	fmuls 0,0,9
	fctiwz 12,0
	stfd 12,16(1)
	lwz 9,20(1)
	sth 9,4(5)
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
	stw 6,108(11)
	lwz 10,84(31)
	lwz 0,116(10)
	rlwinm 0,0,0,0,30
	stw 0,116(10)
	lwz 9,84(31)
	stw 6,3724(9)
	lwz 11,84(31)
	lwz 0,last_beat@l(4)
	stw 6,3728(11)
	lwz 10,84(31)
	cmpwi 0,0,0
	stw 6,3732(10)
	lwz 9,84(31)
	stw 6,3736(9)
	lwz 11,84(31)
	stw 8,3740(11)
	lwz 9,84(31)
	stw 6,3744(9)
	stw 8,64(31)
	stw 8,508(31)
	stw 8,44(31)
	stw 8,48(31)
	stw 8,40(31)
	bc 12,2,.L9
	lis 9,gi+36@ha
	lis 3,.LC0@ha
	lwz 0,gi+36@l(9)
	la 3,.LC0@l(3)
	b .L15
.L9:
	lis 9,gi+36@ha
	lis 3,.LC1@ha
	lwz 0,gi+36@l(9)
	la 3,.LC1@l(3)
.L15:
	mtlr 0
	blrl
	stw 3,76(31)
	lis 9,gi+24@ha
	lis 4,.LC2@ha
	lwz 0,gi+24@l(9)
	la 4,.LC2@l(4)
	li 3,800
	mtlr 0
	blrl
	lis 9,.LC3@ha
	li 0,0
	la 9,.LC3@l(9)
	lfs 13,0(9)
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	stw 0,248(31)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L12
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L11
.L12:
	lis 9,use_NH_scoreboard@ha
	lwz 11,use_NH_scoreboard@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L13
	mr 3,31
	li 4,0
	bl NHScoreboardMessage
	b .L14
.L13:
	mr 3,31
	li 4,0
	bl DeathmatchScoreboardMessage
.L14:
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L11:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 MoveClientToIntermission,.Lfe1-MoveClientToIntermission
	.section	".rodata"
	.align 2
.LC6:
	.string	"*"
	.align 2
.LC7:
	.string	"info_player_intermission"
	.align 2
.LC8:
	.string	"info_player_start"
	.align 2
.LC9:
	.string	"info_player_deathmatch"
	.align 2
.LC5:
	.long 0x4479c000
	.align 2
.LC10:
	.long 0x0
	.align 3
.LC11:
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
	lis 11,.LC10@ha
	lis 9,level+200@ha
	la 11,.LC10@l(11)
	lfs 0,level+200@l(9)
	mr 27,3
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L16
	lis 9,maxclients@ha
	lis 11,game+1560@ha
	lwz 10,maxclients@l(9)
	li 0,0
	li 30,0
	stw 0,game+1560@l(11)
	lis 26,maxclients@ha
	lfs 0,20(10)
	fcmpu 0,13,0
	bc 4,0,.L19
	lis 9,.LC11@ha
	lis 28,g_edicts@ha
	la 9,.LC11@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 31,952
.L21:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L20
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 12,1,.L20
	bl respawn
.L20:
	addi 30,30,1
	lwz 11,maxclients@l(26)
	xoris 0,30,0x8000
	addi 31,31,952
	stw 0,12(1)
	stw 29,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L21
.L19:
	lis 9,level@ha
	lis 11,.LC5@ha
	la 31,level@l(9)
	lfs 0,.LC5@l(11)
	lis 4,.LC6@ha
	lfs 12,4(31)
	la 4,.LC6@l(4)
	fadds 0,12,0
	stfs 12,200(31)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	stw 9,308(31)
	lwz 0,504(27)
	mr 3,0
	stw 0,204(31)
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L25
	lis 11,.LC10@ha
	lis 9,coop@ha
	la 11,.LC10@l(11)
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L39
	lis 9,maxclients@ha
	li 30,0
	lwz 10,maxclients@l(9)
	lfs 0,20(10)
	fcmpu 0,13,0
	bc 4,0,.L39
	lis 9,g_edicts@ha
	lis 11,itemlist@ha
	lwz 4,g_edicts@l(9)
	la 11,itemlist@l(11)
	mr 5,10
	lis 9,.LC11@ha
	lis 31,0x4330
	la 9,.LC11@l(9)
	lfd 12,0(9)
.L30:
	mulli 9,30,952
	addi 7,30,1
	addi 9,9,952
	add 3,4,9
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L29
	li 0,256
	li 6,0
	mtctr 0
	li 8,0
	addi 10,11,56
.L55:
	lwz 0,0(10)
	addi 10,10,76
	andi. 9,0,16
	bc 12,2,.L34
	lwz 9,84(3)
	addi 9,9,740
	stwx 6,9,8
.L34:
	addi 8,8,4
	bdnz .L55
.L29:
	mr 30,7
	lfs 13,20(5)
	xoris 0,30,0x8000
	stw 0,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L30
	b .L39
.L25:
	lis 9,.LC10@ha
	lis 11,deathmatch@ha
	la 9,.LC10@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L39
	li 0,1
	stw 0,208(31)
	b .L16
.L39:
	lis 9,level+208@ha
	li 0,0
	lis 5,.LC7@ha
	stw 0,level+208@l(9)
	li 3,0
	la 5,.LC7@l(5)
	li 4,280
	bl G_Find
	lis 29,.LC7@ha
	mr. 31,3
	bc 4,2,.L41
	lis 5,.LC8@ha
	li 3,0
	la 5,.LC8@l(5)
	li 4,280
	bl G_Find
	mr. 31,3
	bc 4,2,.L43
	lis 5,.LC9@ha
	li 3,0
	la 5,.LC9@l(5)
	li 4,280
	bl G_Find
	mr 31,3
	b .L43
.L41:
	bl rand
	rlwinm 30,3,0,30,31
	b .L44
.L46:
	mr 3,31
	li 4,280
	la 5,.LC7@l(29)
	bl G_Find
	mr. 31,3
	bc 4,2,.L44
	li 3,0
	li 4,280
	la 5,.LC7@l(29)
	bl G_Find
	mr 31,3
.L44:
	cmpwi 0,30,0
	addi 30,30,-1
	bc 4,2,.L46
.L43:
	lfs 0,4(31)
	lis 11,maxclients@ha
	lis 9,level@ha
	lwz 10,maxclients@l(11)
	la 9,level@l(9)
	li 30,0
	lis 11,.LC10@ha
	stfs 0,212(9)
	la 11,.LC10@l(11)
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
	bc 4,0,.L16
	lis 9,.LC11@ha
	lis 28,g_edicts@ha
	la 9,.LC11@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 31,952
.L52:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L51
	bl MoveClientToIntermission
.L51:
	addi 30,30,1
	lwz 11,maxclients@l(26)
	xoris 0,30,0x8000
	addi 31,31,952
	stw 0,12(1)
	stw 29,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L52
.L16:
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
.LC12:
	.string	"i_fixme"
	.align 2
.LC13:
	.string	"tag1"
	.align 2
.LC14:
	.string	"tag2"
	.align 2
.LC15:
	.string	"xv %i yv %i picn %s "
	.align 2
.LC16:
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
	bc 4,0,.L58
	lis 9,g_edicts@ha
	mr 26,11
	lwz 24,g_edicts@l(9)
	addi 31,1,3472
.L60:
	mulli 9,28,952
	addi 27,28,1
	add 29,9,24
	lwz 0,1040(29)
	cmpwi 0,0,0
	bc 12,2,.L59
	lwz 0,1028(26)
	mulli 9,28,3868
	add 9,9,0
	lwz 11,3480(9)
	cmpwi 0,11,0
	bc 4,2,.L59
	li 5,0
	lwz 29,3464(9)
	addi 4,1,3472
	cmpw 0,5,25
	addi 3,1,2448
	addi 30,25,1
	bc 4,0,.L64
	lwz 0,0(31)
	cmpw 0,29,0
	bc 12,1,.L64
	mr 9,4
.L65:
	addi 5,5,1
	cmpw 0,5,25
	bc 4,0,.L64
	lwzu 0,4(9)
	cmpw 0,29,0
	bc 4,1,.L65
.L64:
	cmpw 0,25,5
	mr 7,25
	slwi 12,5,2
	bc 4,1,.L70
	slwi 9,25,2
	mr 6,3
	mr 10,9
	mr 8,4
	addi 11,9,-4
.L72:
	lwzx 9,11,6
	addi 7,7,-1
	cmpw 0,7,5
	stwx 9,10,6
	lwzx 0,11,8
	addi 11,11,-4
	stwx 0,10,8
	addi 10,10,-4
	bc 12,1,.L72
.L70:
	stwx 28,3,12
	mr 25,30
	stwx 29,4,12
.L59:
	lwz 0,1544(26)
	mr 28,27
	cmpw 0,28,0
	bc 12,0,.L60
.L58:
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
	bc 4,0,.L77
	lis 9,game@ha
	lis 18,g_edicts@ha
	la 19,game@l(9)
	addi 24,1,2448
	li 22,0
.L79:
	addi 9,1,2448
	la 11,gi@l(17)
	lwz 10,1028(19)
	lwzx 0,9,22
	lis 3,.LC12@ha
	lwz 8,40(11)
	la 3,.LC12@l(3)
	mulli 9,0,952
	lwz 11,g_edicts@l(18)
	mtlr 8
	mulli 0,0,3868
	addi 9,9,952
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
	bc 4,26,.L82
	lis 9,.LC13@ha
	la 8,.LC13@l(9)
	b .L83
.L82:
	cmpw 0,29,21
	bc 4,2,.L84
	lis 9,.LC14@ha
	la 8,.LC14@l(9)
	b .L83
.L84:
	li 8,0
.L83:
	cmpwi 0,8,0
	bc 12,2,.L86
	lis 5,.LC15@ha
	addi 3,1,16
	la 5,.LC15@l(5)
	li 4,1024
	addi 6,26,32
	mr 7,27
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,16
	bl strlen
	add 29,30,3
	cmpwi 0,29,1024
	bc 12,1,.L77
	add 3,23,30
	addi 4,1,16
	bl strcpy
	mr 30,29
.L86:
	lis 9,level@ha
	lwz 10,3460(31)
	lis 0,0x1b4e
	lwz 11,level@l(9)
	ori 0,0,33205
	lis 5,.LC16@ha
	lwz 8,0(24)
	addi 3,1,16
	la 5,.LC16@l(5)
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
	bc 12,1,.L77
	add 3,23,30
	addi 4,1,16
	bl strcpy
	addi 28,28,1
	mr 30,29
	cmpw 0,28,25
	addi 22,22,4
	bc 12,0,.L79
.L77:
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
.LC17:
	.string	"easy"
	.align 2
.LC18:
	.string	"medium"
	.align 2
.LC19:
	.string	"hard"
	.align 2
.LC20:
	.string	"hard+"
	.align 2
.LC21:
	.string	"xv 32 yv 8 picn help xv 202 yv 12 string2 \"%s\" xv 0 yv 24 cstring2 \"%s\" xv 0 yv 54 cstring2 \"%s\" xv 0 yv 110 cstring2 \"%s\" xv 50 yv 164 string2 \" kills     goals    secrets\" xv 50 yv 172 string2 \"%3i/%3i     %i/%i       %i/%i\" "
	.align 2
.LC22:
	.long 0x0
	.align 2
.LC23:
	.long 0x3f800000
	.align 2
.LC24:
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
	lis 11,.LC22@ha
	lis 9,skill@ha
	la 11,.LC22@l(11)
	mr 31,3
	lfs 0,0(11)
	lwz 11,skill@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 4,2,.L97
	lis 9,.LC17@ha
	la 6,.LC17@l(9)
	b .L98
.L97:
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L99
	lis 9,.LC18@ha
	la 6,.LC18@l(9)
	b .L98
.L99:
	lis 11,.LC24@ha
	la 11,.LC24@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L101
	lis 9,.LC19@ha
	la 6,.LC19@l(9)
	b .L98
.L101:
	lis 9,.LC20@ha
	la 6,.LC20@l(9)
.L98:
	lis 11,level@ha
	lis 8,game@ha
	la 11,level@l(11)
	la 8,game@l(8)
	lwz 0,272(11)
	lis 5,.LC21@ha
	addi 9,8,512
	lwz 29,268(11)
	li 4,1024
	addi 3,1,32
	lwz 26,284(11)
	addi 7,11,8
	la 5,.LC21@l(5)
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
.LC25:
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
	lis 9,.LC25@ha
	lis 29,deathmatch@ha
	la 9,.LC25@l(9)
	mr 31,3
	lfs 31,0(9)
	lwz 9,deathmatch@l(29)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L104
	lis 9,use_NH_scoreboard@ha
	lwz 11,use_NH_scoreboard@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L105
	bl Cmd_NHScore_f
	b .L103
.L105:
	lwz 11,84(31)
	li 30,0
	stw 30,3516(11)
	lwz 9,84(31)
	stw 30,3520(9)
	lwz 11,84(31)
	lwz 0,3856(11)
	cmpwi 0,0,0
	bc 12,2,.L107
	mr 3,31
	bl PMenu_Close
.L107:
	lwz 9,deathmatch@l(29)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 4,2,.L108
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L103
.L108:
	lwz 9,84(31)
	lwz 0,3512(9)
	cmpwi 0,0,0
	bc 12,2,.L110
	stw 30,3512(9)
	b .L103
.L110:
	li 0,1
	mr 3,31
	stw 0,3512(9)
	lwz 4,540(31)
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L103
.L104:
	lwz 9,84(31)
	li 8,0
	stw 8,3516(9)
	lwz 11,84(31)
	stw 8,3512(11)
	lwz 10,84(31)
	lwz 0,3520(10)
	cmpwi 0,0,0
	bc 12,2,.L112
	lis 9,game+1024@ha
	lwz 11,1804(10)
	lwz 0,game+1024@l(9)
	cmpw 0,11,0
	bc 4,2,.L112
	stw 8,3520(10)
	b .L103
.L112:
	lwz 11,84(31)
	li 0,1
	li 10,0
	mr 3,31
	stw 0,3520(11)
	lwz 9,84(31)
	stw 10,1808(9)
	bl HelpComputer
.L103:
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 Cmd_Help_f,.Lfe5-Cmd_Help_f
	.section	".sdata","aw"
	.align 2
	.type	 panic_end.27,@object
	.size	 panic_end.27,4
panic_end.27:
	.long 0
	.section	".rodata"
	.align 2
.LC26:
	.string	"Rocket Launcher"
	.align 2
.LC27:
	.string	"h_over"
	.align 2
.LC28:
	.string	"cells"
	.align 2
.LC29:
	.string	"misc/power2.wav"
	.align 2
.LC30:
	.string	"i_powershield"
	.align 2
.LC31:
	.string	"nhir"
	.align 2
.LC32:
	.string	"p_envirosuit"
	.align 2
.LC33:
	.string	"p_rebreather"
	.align 2
.LC34:
	.string	"h_marine"
	.align 2
.LC35:
	.string	"h_pred"
	.align 2
.LC36:
	.string	"nhflash"
	.align 2
.LC37:
	.long 0x0
	.align 2
.LC38:
	.long 0x3f800000
	.align 3
.LC39:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC40:
	.long 0x41200000
	.align 2
.LC41:
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
	lis 28,level@ha
	lwz 9,84(31)
	sth 0,120(9)
	lhz 0,482(31)
	lwz 11,84(31)
	sth 0,122(11)
	lwz 29,84(31)
	lwz 0,3528(29)
	cmpwi 0,0,0
	bc 4,2,.L114
	sth 0,124(29)
	lwz 9,84(31)
	b .L158
.L114:
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L116
	lis 9,.LC37@ha
	lis 11,enable_predator_overload@ha
	la 9,.LC37@l(9)
	lfs 13,0(9)
	lwz 9,enable_predator_overload@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L116
	lwz 0,3864(29)
	cmpwi 0,0,0
	bc 12,2,.L116
	lis 3,.LC26@ha
	la 3,.LC26@l(3)
	bl FindItem
	lwz 0,1788(29)
	cmpw 0,0,3
	bc 4,2,.L116
	lis 9,gi+40@ha
	lis 3,.LC27@ha
	lwz 0,gi+40@l(9)
	la 3,.LC27@l(3)
	mtlr 0
	b .L159
.L116:
	lwz 8,84(31)
	lis 10,gi+40@ha
	lis 11,itemlist@ha
	la 11,itemlist@l(11)
	lwz 0,gi+40@l(10)
	lwz 9,3528(8)
	mtlr 0
	mulli 9,9,76
	add 9,9,11
	lwz 3,36(9)
.L159:
	blrl
	lwz 9,84(31)
	sth 3,124(9)
	lwz 9,84(31)
	lwz 11,3528(9)
	slwi 11,11,2
	add 11,9,11
	lhz 0,742(11)
.L158:
	sth 0,126(9)
	mr 3,31
	bl PowerArmorType
	mr. 30,3
	bc 12,2,.L118
	lis 3,.LC28@ha
	lwz 29,84(31)
	la 3,.LC28@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 27,29,3
	cmpwi 0,27,0
	bc 4,2,.L118
	lwz 0,264(31)
	lis 29,gi@ha
	lis 3,.LC29@ha
	la 29,gi@l(29)
	la 3,.LC29@l(3)
	rlwinm 0,0,0,20,18
	li 30,0
	stw 0,264(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC38@ha
	lwz 0,16(29)
	lis 11,.LC38@ha
	la 9,.LC38@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC38@l(11)
	li 4,3
	mtlr 0
	lis 9,.LC37@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC37@l(9)
	lfs 3,0(9)
	blrl
.L118:
	mr 3,31
	bl ArmorIndex
	cmpwi 0,30,0
	mr 29,3
	bc 12,2,.L120
	cmpwi 0,29,0
	bc 12,2,.L121
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L120
.L121:
	lis 9,gi+40@ha
	lis 3,.LC30@ha
	lwz 0,gi+40@l(9)
	la 3,.LC30@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,128(9)
	lwz 11,84(31)
	sth 27,130(11)
	b .L122
.L120:
	cmpwi 0,29,0
	bc 12,2,.L123
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
	b .L122
.L123:
	lwz 9,84(31)
	sth 29,128(9)
	lwz 11,84(31)
	sth 29,130(11)
.L122:
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,3756(11)
	fcmpu 0,13,0
	bc 4,1,.L125
	li 0,0
	sth 0,134(11)
	lwz 9,84(31)
	sth 0,136(9)
.L125:
	lwz 0,level@l(28)
	lis 30,0x4330
	lis 11,.LC39@ha
	xoris 0,0,0x8000
	la 11,.LC39@l(11)
	stw 0,28(1)
	stw 30,24(1)
	lfd 31,0(11)
	lfd 0,24(1)
	lwz 11,84(31)
	fsub 0,0,31
	lfs 13,3724(11)
	frsp 12,0
	fcmpu 0,13,12
	bc 4,1,.L126
	lis 9,gi+40@ha
	lis 3,.LC31@ha
	lwz 0,gi+40@l(9)
	la 3,.LC31@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC40@ha
	la 11,.LC40@l(11)
	sth 3,138(10)
	lwz 0,level@l(28)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3724(10)
	b .L160
.L126:
	lfs 0,3728(11)
	fcmpu 0,0,12
	bc 4,1,.L128
	lis 9,gi+40@ha
	lis 3,.LC31@ha
	lwz 0,gi+40@l(9)
	la 3,.LC31@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC40@ha
	la 11,.LC40@l(11)
	sth 3,138(10)
	lwz 0,level@l(28)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3728(10)
	b .L160
.L128:
	lfs 0,3736(11)
	fcmpu 0,0,12
	bc 4,1,.L130
	lis 9,gi+40@ha
	lis 3,.LC32@ha
	lwz 0,gi+40@l(9)
	la 3,.LC32@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC40@ha
	la 11,.LC40@l(11)
	sth 3,138(10)
	lwz 0,level@l(28)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3736(10)
	b .L160
.L130:
	lfs 0,3732(11)
	fcmpu 0,0,12
	bc 4,1,.L132
	lis 9,gi+40@ha
	lis 3,.LC33@ha
	lwz 0,gi+40@l(9)
	la 3,.LC33@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC40@ha
	la 11,.LC40@l(11)
	sth 3,138(10)
	lwz 0,level@l(28)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3732(10)
	b .L160
.L132:
	lfs 0,3860(11)
	fcmpu 0,0,12
	bc 4,1,.L134
	lis 9,gi+40@ha
	lis 3,.LC31@ha
	lwz 0,gi+40@l(9)
	la 3,.LC31@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC40@ha
	la 11,.LC40@l(11)
	sth 3,138(10)
	lwz 0,level@l(28)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3860(10)
.L160:
	fsub 13,13,31
	frsp 13,13
	fsubs 0,0,13
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,24(1)
	lwz 11,28(1)
	sth 11,140(10)
	b .L127
.L134:
	li 0,0
	sth 0,138(11)
	lwz 9,84(31)
	sth 0,140(9)
.L127:
	lwz 9,84(31)
	lwz 0,716(9)
	cmpwi 0,0,2
	bc 12,2,.L137
	lis 11,.LC41@ha
	lfs 13,112(9)
	la 11,.LC41@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L136
.L137:
	lwz 11,1788(9)
	cmpwi 0,11,0
	bc 12,2,.L136
	lis 9,gi+40@ha
	lwz 3,36(11)
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,142(9)
	b .L138
.L136:
	lwz 9,84(31)
	li 0,0
	sth 0,142(9)
.L138:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L139
	li 0,0
	sth 0,132(9)
	b .L140
.L139:
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
.L140:
	lwz 11,84(31)
	lis 9,deathmatch@ha
	li 10,0
	lwz 8,deathmatch@l(9)
	lhz 0,738(11)
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	sth 0,144(11)
	lfs 13,0(9)
	lwz 9,84(31)
	sth 10,146(9)
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L141
	lwz 11,84(31)
	lwz 0,724(11)
	cmpwi 0,0,0
	bc 4,1,.L143
	lis 9,level@ha
	la 9,level@l(9)
	lfs 0,200(9)
	fcmpu 0,0,13
	bc 4,2,.L143
	lwz 0,3512(11)
	cmpwi 0,0,0
	bc 4,2,.L143
	lfs 0,4(9)
	lwz 0,924(31)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	cmpw 0,0,9
	bc 4,1,.L146
.L143:
	lwz 9,84(31)
	b .L147
.L141:
	lwz 9,84(31)
	lwz 0,3512(9)
	cmpwi 0,0,0
	bc 4,2,.L147
	lwz 0,3520(9)
	cmpwi 0,0,0
	bc 12,2,.L146
.L147:
	lhz 0,146(9)
	ori 0,0,1
	sth 0,146(9)
.L146:
	lwz 9,84(31)
	lwz 0,3516(9)
	cmpwi 0,0,0
	bc 12,2,.L145
	lwz 0,724(9)
	cmpwi 0,0,0
	bc 4,1,.L145
	lhz 0,146(9)
	ori 0,0,2
	sth 0,146(9)
.L145:
	lwz 11,84(31)
	lis 9,gi@ha
	li 29,0
	la 30,gi@l(9)
	lis 3,.LC34@ha
	lhz 0,3466(11)
	la 3,.LC34@l(3)
	sth 0,148(11)
	lwz 9,84(31)
	sth 29,154(9)
	lwz 9,40(30)
	mtlr 9
	blrl
	lwz 9,84(31)
	sth 3,158(9)
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L149
	lwz 0,40(30)
	lis 3,.LC35@ha
	la 3,.LC35@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
.L149:
	lwz 9,84(31)
	sth 29,160(9)
	lwz 11,84(31)
	sth 29,156(11)
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L150
	lis 9,level+4@ha
	lwz 10,84(31)
	lfs 0,level+4@l(9)
	lwz 0,3848(10)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	cmpw 0,0,9
	bc 4,1,.L151
	lwz 0,3820(10)
	cmpwi 0,0,0
	bc 4,2,.L151
	lhz 0,3850(10)
	subf 0,9,0
	sth 0,156(10)
.L151:
	lwz 9,84(31)
	lhz 0,1822(9)
	sth 0,160(9)
.L150:
	lwz 0,892(31)
	cmpwi 0,0,0
	bc 12,2,.L152
	lis 9,gi+40@ha
	lis 3,.LC36@ha
	lwz 0,gi+40@l(9)
	la 3,.LC36@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,162(9)
	b .L153
.L152:
	lwz 9,84(31)
	sth 0,162(9)
.L153:
	lwz 0,940(31)
	cmpwi 0,0,0
	bc 12,2,.L154
	lis 11,level+4@ha
	lwz 0,944(31)
	lfs 0,level+4@l(11)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	cmpw 0,0,9
	bc 4,0,.L154
	mr 3,31
	bl clearSafetyMode
.L154:
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L156
	lwz 0,912(31)
	cmpwi 0,0,0
	bc 12,2,.L156
	lis 11,level@ha
	la 10,level@l(11)
	lfs 0,4(10)
	lwz 0,312(10)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	cmpw 0,0,9
	bc 4,1,.L156
	lwz 11,84(31)
	li 0,1
	sth 0,168(11)
	lfs 0,4(10)
	lhz 0,314(10)
	lwz 11,84(31)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	subf 0,9,0
	sth 0,170(11)
	b .L157
.L156:
	lwz 9,84(31)
	li 0,0
	sth 0,168(9)
.L157:
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe6:
	.size	 G_SetStats,.Lfe6-G_SetStats
	.comm	showscores,4,4
	.comm	nextdynamicset,4,4
	.comm	predatorModel,32,4
	.comm	predatorSkin,64,4
	.comm	marineSkin,64,4
	.comm	maplist_lastmap,64,4
	.comm	maplist2_lastmap,64,4
	.comm	maplist3_lastmap,64,4
	.comm	last_beat,4,4
	.section	".rodata"
	.align 2
.LC42:
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
	stw 30,3516(9)
	lwz 11,84(31)
	stw 30,3520(11)
	lwz 9,84(31)
	lwz 0,3856(9)
	cmpwi 0,0,0
	bc 12,2,.L92
	bl PMenu_Close
.L92:
	lis 11,.LC42@ha
	lis 9,deathmatch@ha
	la 11,.LC42@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L93
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L91
.L93:
	lwz 9,84(31)
	lwz 0,3512(9)
	cmpwi 0,0,0
	bc 12,2,.L94
	stw 30,3512(9)
	b .L91
.L94:
	li 0,1
	mr 3,31
	stw 0,3512(9)
	lwz 4,540(31)
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L91:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 Cmd_Score_f,.Lfe7-Cmd_Score_f
	.section	".rodata"
	.align 2
.LC43:
	.long 0x0
	.section	".text"
	.align 2
	.globl G_SetSpectatorStats
	.type	 G_SetSpectatorStats,@function
G_SetSpectatorStats:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 30,3
	lwz 31,84(30)
	lwz 0,3812(31)
	cmpwi 0,0,0
	bc 4,2,.L170
	bl G_SetStats
.L170:
	lwz 0,724(31)
	li 9,1
	li 11,0
	sth 9,154(31)
	cmpwi 0,0,0
	sth 11,146(31)
	bc 4,1,.L172
	lis 9,level@ha
	lis 11,.LC43@ha
	la 11,.LC43@l(11)
	la 9,level@l(9)
	lfs 13,0(11)
	lfs 0,200(9)
	fcmpu 0,0,13
	bc 4,2,.L172
	lwz 0,3512(31)
	cmpwi 0,0,0
	bc 4,2,.L172
	lfs 0,4(9)
	lwz 0,924(30)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	cmpw 0,0,9
	bc 4,1,.L171
.L172:
	lhz 0,146(31)
	ori 0,0,1
	sth 0,146(31)
.L171:
	lwz 0,3516(31)
	cmpwi 0,0,0
	bc 12,2,.L173
	lwz 0,724(31)
	cmpwi 0,0,0
	bc 4,1,.L173
	lhz 0,146(31)
	ori 0,0,2
	sth 0,146(31)
.L173:
	lwz 10,3812(31)
	cmpwi 0,10,0
	bc 12,2,.L174
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L174
	lis 11,g_edicts@ha
	lis 0,0x46fd
	lwz 9,g_edicts@l(11)
	ori 0,0,55623
	subf 9,9,10
	mullw 9,9,0
	srawi 9,9,3
	addi 9,9,1311
	sth 9,152(31)
	b .L175
.L174:
	li 0,0
	sth 0,164(31)
	sth 0,152(31)
	sth 0,162(31)
.L175:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 G_SetSpectatorStats,.Lfe8-G_SetSpectatorStats
	.section	".rodata"
	.align 2
.LC44:
	.long 0x3f800000
	.align 3
.LC45:
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
	lis 11,.LC44@ha
	lis 9,maxclients@ha
	la 11,.LC44@l(11)
	mr 30,3
	lfs 13,0(11)
	li 29,1
	lis 26,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L163
	lis 9,.LC45@ha
	lis 28,g_edicts@ha
	la 9,.LC45@l(9)
	lis 27,0x4330
	lfd 31,0(9)
	li 31,952
.L165:
	lwz 9,g_edicts@l(28)
	add 9,31,9
	lwz 0,88(9)
	lwz 3,84(9)
	cmpwi 0,0,0
	bc 12,2,.L164
	lwz 0,3812(3)
	cmpw 0,0,30
	bc 4,2,.L164
	lwz 4,84(30)
	addi 3,3,120
	li 5,64
	addi 4,4,120
	crxor 6,6,6
	bl memcpy
	lwz 3,g_edicts@l(28)
	add 3,3,31
	bl G_SetSpectatorStats
.L164:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 31,31,952
	stw 0,12(1)
	stw 27,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L165
.L163:
	lwz 0,52(1)
	mtlr 0
	lmw 26,16(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 G_CheckChaseStats,.Lfe9-G_CheckChaseStats
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
