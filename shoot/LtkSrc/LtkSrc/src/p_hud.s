	.file	"p_hud.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"bot"
	.align 2
.LC1:
	.long 0x0
	.align 2
.LC2:
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
	lwz 9,84(31)
	li 0,1
	stw 0,3912(9)
	lwz 11,84(31)
	stw 0,3920(11)
.L7:
	lis 10,level@ha
	lis 9,.LC2@ha
	lwz 6,84(31)
	la 10,level@l(10)
	la 9,.LC2@l(9)
	lfs 0,212(10)
	li 0,4
	lis 5,.LC1@ha
	lfs 9,0(9)
	li 8,0
	la 5,.LC1@l(5)
	lfs 8,0(5)
	li 4,90
	stfs 0,4(31)
	mr 11,9
	mr 7,9
	lfs 0,216(10)
	lis 5,deathmatch@ha
	lis 3,0x42b4
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
	stfs 8,4132(9)
	lwz 11,84(31)
	lwz 7,deathmatch@l(5)
	stfs 8,4136(11)
	lwz 9,84(31)
	stfs 8,4140(9)
	lwz 11,84(31)
	stfs 8,4144(11)
	lwz 9,84(31)
	stw 8,4148(9)
	lwz 11,84(31)
	stfs 8,4152(11)
	lwz 10,84(31)
	stw 8,508(31)
	stw 8,44(31)
	stw 8,48(31)
	stw 8,40(31)
	stw 8,64(31)
	stw 8,76(31)
	stw 8,248(31)
	stw 8,3464(10)
	lwz 9,84(31)
	stw 4,4304(9)
	lwz 11,84(31)
	stw 3,112(11)
	lwz 9,84(31)
	sth 8,156(9)
	lfs 0,20(7)
	fcmpu 0,0,8
	bc 4,2,.L10
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,8
	bc 12,2,.L6
.L10:
	lwz 3,280(31)
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L6
	mr 3,31
	li 4,0
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L6:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 MoveClientToIntermission,.Lfe1-MoveClientToIntermission
	.section	".rodata"
	.align 2
.LC3:
	.string	"*"
	.align 2
.LC4:
	.string	"info_player_intermission"
	.align 2
.LC5:
	.string	"info_player_start"
	.align 2
.LC6:
	.string	"info_player_deathmatch"
	.align 2
.LC7:
	.long 0x0
	.align 3
.LC8:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC9:
	.long 0x3f800000
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
	lis 11,.LC7@ha
	lis 9,level+200@ha
	la 11,.LC7@l(11)
	lfs 0,level+200@l(9)
	mr 27,3
	lfs 31,0(11)
	fcmpu 0,0,31
	bc 4,2,.L12
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L14
	bl TallyEndOfLevelTeamScores
.L14:
	lis 9,maxclients@ha
	lis 11,game+1560@ha
	lwz 10,maxclients@l(9)
	li 0,0
	li 30,0
	stw 0,game+1560@l(11)
	lis 26,maxclients@ha
	lfs 0,20(10)
	fcmpu 0,31,0
	bc 4,0,.L16
	lis 9,.LC8@ha
	lis 28,g_edicts@ha
	la 9,.LC8@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 31,996
.L18:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L17
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 12,1,.L17
	bl respawn
.L17:
	addi 30,30,1
	lwz 11,maxclients@l(26)
	xoris 0,30,0x8000
	addi 31,31,996
	stw 0,12(1)
	stw 29,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L18
.L16:
	lis 9,level@ha
	lis 4,.LC3@ha
	la 31,level@l(9)
	la 4,.LC3@l(4)
	lfs 0,4(31)
	stfs 0,200(31)
	lwz 0,504(27)
	mr 3,0
	stw 0,204(31)
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L22
	lis 11,.LC7@ha
	lis 9,coop@ha
	la 11,.LC7@l(11)
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
	lis 9,.LC8@ha
	lis 31,0x4330
	la 9,.LC8@l(9)
	lfd 12,0(9)
.L27:
	mulli 9,30,996
	addi 7,30,1
	addi 9,9,996
	add 3,4,9
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L26
	li 0,256
	li 6,0
	mtctr 0
	li 8,0
	addi 10,11,56
.L59:
	lwz 0,0(10)
	addi 10,10,72
	andi. 9,0,16
	bc 12,2,.L31
	lwz 9,84(3)
	addi 9,9,740
	stwx 6,9,8
.L31:
	addi 8,8,4
	bdnz .L59
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
	lis 9,.LC7@ha
	lis 11,deathmatch@ha
	la 9,.LC7@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L36
	li 0,1
	stw 0,208(31)
	b .L12
.L36:
	lis 9,level+208@ha
	li 0,0
	lis 5,.LC4@ha
	stw 0,level+208@l(9)
	li 3,0
	la 5,.LC4@l(5)
	li 4,280
	bl G_Find
	lis 29,.LC4@ha
	mr. 31,3
	bc 4,2,.L38
	lis 5,.LC5@ha
	li 3,0
	la 5,.LC5@l(5)
	li 4,280
	bl G_Find
	mr. 31,3
	bc 4,2,.L40
	lis 5,.LC6@ha
	li 3,0
	la 5,.LC6@l(5)
	li 4,280
	bl G_Find
	mr 31,3
	b .L40
.L38:
	bl rand
	rlwinm 30,3,0,30,31
	b .L41
.L43:
	mr 3,31
	li 4,280
	la 5,.LC4@l(29)
	bl G_Find
	mr. 31,3
	bc 4,2,.L41
	li 3,0
	li 4,280
	la 5,.LC4@l(29)
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
	lis 11,.LC7@ha
	stfs 0,212(9)
	la 11,.LC7@l(11)
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
	bc 4,0,.L47
	lis 9,.LC8@ha
	lis 28,g_edicts@ha
	la 9,.LC8@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 31,996
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
	addi 31,31,996
	stw 0,12(1)
	stw 29,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L49
.L47:
	lis 11,.LC9@ha
	lis 9,maxclients@ha
	la 11,.LC9@l(11)
	li 30,1
	lfs 13,0(11)
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L12
	lis 9,g_edicts@ha
	mr 8,11
	lwz 11,g_edicts@l(9)
	li 10,0
	lis 7,0x4330
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	addi 11,11,996
	lfd 12,0(9)
.L55:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L54
	lwz 9,84(11)
	cmpwi 0,9,0
	bc 12,2,.L54
	stw 10,4452(9)
	lwz 9,84(11)
	stw 10,4448(9)
.L54:
	addi 30,30,1
	lfs 13,20(8)
	xoris 0,30,0x8000
	addi 11,11,996
	stw 0,12(1)
	stw 7,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L55
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
	.string	"i_fixme"
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
	.align 2
.LC15:
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
	mr 21,3
	mr 20,4
	lwz 0,904(21)
	cmpwi 0,0,0
	bc 4,2,.L60
	lis 9,.LC15@ha
	lis 11,teamplay@ha
	la 9,.LC15@l(9)
	lfs 13,0(9)
	lwz 9,teamplay@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L62
	bl A_ScoreboardMessage
	b .L60
.L62:
	lis 9,game@ha
	li 25,0
	la 11,game@l(9)
	li 28,0
	lwz 0,1544(11)
	addi 23,1,1040
	lis 17,gi@ha
	cmpw 0,25,0
	bc 4,0,.L64
	lis 9,g_edicts@ha
	mr 26,11
	lwz 24,g_edicts@l(9)
	addi 31,1,3472
.L66:
	mulli 9,28,996
	addi 27,28,1
	add 29,9,24
	lwz 0,1084(29)
	cmpwi 0,0,0
	bc 12,2,.L65
	lwz 0,1028(26)
	mulli 9,28,4564
	li 5,0
	addi 4,1,3472
	cmpw 0,5,25
	addi 3,1,2448
	add 9,9,0
	addi 30,25,1
	lwz 29,3440(9)
	bc 4,0,.L69
	lwz 0,0(31)
	cmpw 0,29,0
	bc 12,1,.L69
	mr 9,4
.L70:
	addi 5,5,1
	cmpw 0,5,25
	bc 4,0,.L69
	lwzu 0,4(9)
	cmpw 0,29,0
	bc 4,1,.L70
.L69:
	cmpw 0,25,5
	mr 7,25
	slwi 12,5,2
	bc 4,1,.L75
	slwi 9,25,2
	mr 6,3
	mr 10,9
	mr 8,4
	addi 11,9,-4
.L77:
	lwzx 9,11,6
	addi 7,7,-1
	cmpw 0,7,5
	stwx 9,10,6
	lwzx 0,11,8
	addi 11,11,-4
	stwx 0,10,8
	addi 10,10,-4
	bc 12,1,.L77
.L75:
	stwx 28,3,12
	mr 25,30
	stwx 29,4,12
.L65:
	lwz 0,1544(26)
	mr 28,27
	cmpw 0,28,0
	bc 12,0,.L66
.L64:
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
	bc 4,0,.L82
	lis 9,game@ha
	lis 18,g_edicts@ha
	la 19,game@l(9)
	addi 24,1,2448
	li 22,0
.L84:
	addi 9,1,2448
	la 11,gi@l(17)
	lwz 10,1028(19)
	lwzx 0,9,22
	lis 3,.LC10@ha
	lwz 8,40(11)
	la 3,.LC10@l(3)
	mulli 9,0,996
	lwz 11,g_edicts@l(18)
	mtlr 8
	mulli 0,0,4564
	addi 9,9,996
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
	bc 4,26,.L87
	lis 9,.LC11@ha
	la 8,.LC11@l(9)
	b .L88
.L87:
	cmpw 0,29,20
	bc 4,2,.L89
	lis 9,.LC12@ha
	la 8,.LC12@l(9)
	b .L88
.L89:
	li 8,0
.L88:
	cmpwi 0,8,0
	bc 12,2,.L91
	lis 5,.LC13@ha
	addi 3,1,16
	la 5,.LC13@l(5)
	li 4,1024
	addi 6,26,32
	mr 7,27
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,16
	bl strlen
	add 29,30,3
	cmpwi 0,29,1024
	bc 12,1,.L82
	add 3,23,30
	addi 4,1,16
	bl strcpy
	mr 30,29
.L91:
	lis 9,level@ha
	lwz 10,3436(31)
	lis 0,0x1b4e
	lwz 11,level@l(9)
	ori 0,0,33205
	lis 5,.LC14@ha
	lwz 8,0(24)
	addi 3,1,16
	la 5,.LC14@l(5)
	subf 11,10,11
	lwz 9,3440(31)
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
	bc 12,1,.L82
	add 3,23,30
	addi 4,1,16
	bl strcpy
	addi 28,28,1
	mr 30,29
	cmpw 0,28,25
	addi 22,22,4
	bc 12,0,.L84
.L82:
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
.L60:
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
	li 0,0
	lwz 9,84(31)
	stw 0,3924(9)
	lwz 11,84(31)
	stw 0,3928(11)
	lwz 9,84(31)
	lwz 0,4432(9)
	cmpwi 0,0,0
	bc 12,2,.L98
	bl PMenu_Close
.L98:
	lis 11,.LC16@ha
	lis 9,deathmatch@ha
	la 11,.LC16@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L99
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L97
.L99:
	lwz 10,84(31)
	lwz 0,3912(10)
	mr 8,10
	cmpwi 0,0,0
	bc 12,2,.L100
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L101
	lwz 9,3920(10)
	cmpwi 0,9,1
	bc 12,1,.L101
	addi 0,9,1
	lis 4,.LC0@ha
	stw 0,3920(10)
	la 4,.LC0@l(4)
	lwz 3,280(31)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L97
	lwz 4,540(31)
	mr 3,31
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L97
.L101:
	li 0,0
	stw 0,3912(8)
	b .L97
.L100:
	li 0,1
	lis 4,.LC0@ha
	stw 0,3912(10)
	la 4,.LC0@l(4)
	lwz 9,84(31)
	stw 0,3920(9)
	lwz 3,280(31)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L97
	lwz 4,540(31)
	mr 3,31
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L97:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 Cmd_Score_f,.Lfe4-Cmd_Score_f
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
	bc 4,2,.L107
	lis 9,.LC17@ha
	la 6,.LC17@l(9)
	b .L108
.L107:
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L109
	lis 9,.LC18@ha
	la 6,.LC18@l(9)
	b .L108
.L109:
	lis 11,.LC24@ha
	la 11,.LC24@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L111
	lis 9,.LC19@ha
	la 6,.LC19@l(9)
	b .L108
.L111:
	lis 9,.LC20@ha
	la 6,.LC20@l(9)
.L108:
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
.Lfe5:
	.size	 HelpComputer,.Lfe5-HelpComputer
	.section	".rodata"
	.align 2
.LC25:
	.string	"Sniper Rifle"
	.align 2
.LC26:
	.string	"M4 Assault Rifle"
	.align 2
.LC27:
	.string	"MP5/10 Submachinegun"
	.align 2
.LC28:
	.string	"M3 Super 90 Assault Shotgun"
	.align 2
.LC29:
	.string	"Handcannon"
	.align 2
.LC30:
	.string	"Kevlar Vest"
	.align 2
.LC31:
	.string	"Lasersight"
	.align 2
.LC32:
	.string	"Stealth Slippers"
	.align 2
.LC33:
	.string	"Silencer"
	.align 2
.LC34:
	.string	"Bandolier"
	.align 2
.LC35:
	.string	"M26 Fragmentation Grenade"
	.align 2
.LC36:
	.string	"a_m61frag"
	.align 2
.LC37:
	.string	"a_bullets"
	.align 2
.LC38:
	.string	"a_shells"
	.align 2
.LC39:
	.string	"w_knife"
	.align 2
.LC40:
	.string	"Combat Knife"
	.align 2
.LC41:
	.string	"Failed to find weapon/icon for hud.\n"
	.align 2
.LC42:
	.string	"scope2x"
	.align 2
.LC43:
	.string	"scope4x"
	.align 2
.LC44:
	.string	"scope6x"
	.align 2
.LC45:
	.string	"cells"
	.align 2
.LC46:
	.string	"misc/power2.wav"
	.align 2
.LC47:
	.string	"i_powershield"
	.align 2
.LC48:
	.string	"p_quad"
	.align 2
.LC49:
	.string	"p_invulnerability"
	.align 2
.LC50:
	.string	"p_envirosuit"
	.align 2
.LC51:
	.string	"p_rebreather"
	.align 2
.LC52:
	.string	"i_help"
	.align 2
.LC53:
	.long 0x3f800000
	.align 2
.LC54:
	.long 0x0
	.align 3
.LC55:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC56:
	.long 0x41200000
	.align 2
.LC57:
	.long 0x42b60000
	.section	".text"
	.align 2
	.globl G_SetStats
	.type	 G_SetStats,@function
G_SetStats:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 25,28(1)
	stw 0,68(1)
	mr 31,3
	lwz 11,84(31)
	lwz 0,4444(11)
	cmpwi 0,0,0
	bc 4,2,.L117
	lis 9,level+266@ha
	lis 26,level@ha
	lhz 0,level+266@l(9)
	sth 0,120(11)
	lwz 9,84(31)
	lhz 0,482(31)
	sth 0,122(9)
	lwz 9,84(31)
	lwz 11,3936(9)
	cmpwi 0,11,0
	bc 4,2,.L118
	sth 11,152(9)
	lwz 9,84(31)
	sth 11,154(9)
	b .L119
.L118:
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
	sth 3,152(9)
	lwz 11,84(31)
	lwz 9,3936(11)
	slwi 9,9,2
	add 9,11,9
	lhz 0,742(9)
	sth 0,154(11)
.L119:
	lis 27,.LC25@ha
	lwz 29,84(31)
	lis 30,0x38e3
	la 3,.LC25@l(27)
	ori 30,30,36409
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 28,itemlist@l(9)
	subf 3,28,3
	mullw 3,3,30
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L120
	lis 29,gi@ha
	la 3,.LC25@l(27)
	b .L195
.L120:
	lis 27,.LC26@ha
	lwz 29,84(31)
	la 3,.LC26@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L122
	lis 29,gi@ha
	la 3,.LC26@l(27)
	b .L195
.L122:
	lis 27,.LC27@ha
	lwz 29,84(31)
	la 3,.LC27@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L124
	lis 29,gi@ha
	la 3,.LC27@l(27)
	b .L195
.L124:
	lis 27,.LC28@ha
	lwz 29,84(31)
	la 3,.LC28@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L126
	lis 29,gi@ha
	la 3,.LC28@l(27)
	b .L195
.L126:
	lis 27,.LC29@ha
	lwz 29,84(31)
	la 3,.LC29@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L128
	lis 29,gi@ha
	la 3,.LC29@l(27)
.L195:
	la 29,gi@l(29)
	bl FindItem
	lwz 0,40(29)
	lwz 3,36(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,160(9)
	b .L121
.L128:
	lwz 9,84(31)
	sth 0,160(9)
.L121:
	lis 27,.LC30@ha
	lwz 29,84(31)
	lis 30,0x38e3
	la 3,.LC30@l(27)
	ori 30,30,36409
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 28,itemlist@l(9)
	subf 3,28,3
	mullw 3,3,30
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L130
	lis 29,gi@ha
	la 3,.LC30@l(27)
	b .L196
.L130:
	lis 27,.LC31@ha
	lwz 29,84(31)
	la 3,.LC31@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L132
	lis 29,gi@ha
	la 3,.LC31@l(27)
	b .L196
.L132:
	lis 27,.LC32@ha
	lwz 29,84(31)
	la 3,.LC32@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L134
	lis 29,gi@ha
	la 3,.LC32@l(27)
	b .L196
.L134:
	lis 27,.LC33@ha
	lwz 29,84(31)
	la 3,.LC33@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L136
	lis 29,gi@ha
	la 3,.LC33@l(27)
	b .L196
.L136:
	lis 27,.LC34@ha
	lwz 29,84(31)
	la 3,.LC34@l(27)
	bl FindItem
	subf 3,28,3
	addi 29,29,740
	mullw 3,3,30
	srawi 3,3,3
	slwi 3,3,2
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L138
	lis 29,gi@ha
	la 3,.LC34@l(27)
.L196:
	la 29,gi@l(29)
	bl FindItem
	lwz 0,40(29)
	lwz 3,36(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
	b .L131
.L138:
	lwz 9,84(31)
	sth 0,158(9)
.L131:
	lis 3,.LC35@ha
	la 3,.LC35@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 10,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 11,10,740
	mullw 3,3,0
	srawi 3,3,3
	slwi 30,3,2
	lwzx 0,11,30
	cmpwi 0,0,0
	bc 12,2,.L140
	lis 9,gi+40@ha
	lis 3,.LC36@ha
	lwz 0,gi+40@l(9)
	la 3,.LC36@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,176(9)
	lwz 11,84(31)
	add 9,11,30
	lhz 0,742(9)
	sth 0,178(11)
	b .L141
.L140:
	sth 0,176(10)
.L141:
	lwz 10,84(31)
	lwz 0,1788(10)
	cmpwi 0,0,0
	bc 12,2,.L142
	lwz 10,4284(10)
	cmplwi 0,10,8
	bc 12,1,.L153
	lis 11,.L154@ha
	slwi 10,10,2
	la 11,.L154@l(11)
	lis 9,.L154@ha
	lwzx 0,10,11
	la 9,.L154@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L154:
	.long .L144-.L154
	.long .L145-.L154
	.long .L146-.L154
	.long .L147-.L154
	.long .L148-.L154
	.long .L149-.L154
	.long .L150-.L154
	.long .L151-.L154
	.long .L152-.L154
.L144:
	lis 9,gi+40@ha
	lis 3,.LC37@ha
	lwz 0,gi+40@l(9)
	la 3,.LC37@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,124(9)
	lwz 11,84(31)
	lhz 0,4226(11)
	sth 0,126(11)
	b .L142
.L145:
	lis 9,gi+40@ha
	lis 3,.LC37@ha
	lwz 0,gi+40@l(9)
	la 3,.LC37@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,124(9)
	lwz 11,84(31)
	lhz 0,4258(11)
	sth 0,126(11)
	b .L142
.L146:
	lis 9,gi+40@ha
	lis 3,.LC37@ha
	lwz 0,gi+40@l(9)
	la 3,.LC37@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,124(9)
	lwz 11,84(31)
	lhz 0,4266(11)
	sth 0,126(11)
	b .L142
.L147:
	lis 9,gi+40@ha
	lis 3,.LC38@ha
	lwz 0,gi+40@l(9)
	la 3,.LC38@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,124(9)
	lwz 11,84(31)
	lhz 0,4242(11)
	sth 0,126(11)
	b .L142
.L148:
	lis 9,gi+40@ha
	lis 3,.LC38@ha
	lwz 0,gi+40@l(9)
	la 3,.LC38@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,124(9)
	lwz 11,84(31)
	lhz 0,4274(11)
	sth 0,126(11)
	b .L142
.L149:
	lis 9,gi+40@ha
	lis 3,.LC37@ha
	lwz 0,gi+40@l(9)
	la 3,.LC37@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,124(9)
	lwz 11,84(31)
	lhz 0,4250(11)
	sth 0,126(11)
	b .L142
.L150:
	lis 9,gi+40@ha
	lis 3,.LC37@ha
	lwz 0,gi+40@l(9)
	la 3,.LC37@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,124(9)
	lwz 11,84(31)
	lhz 0,4234(11)
	sth 0,126(11)
	b .L142
.L151:
	lis 9,gi+40@ha
	lis 3,.LC39@ha
	lwz 0,gi+40@l(9)
	la 3,.LC39@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	lis 11,.LC40@ha
	sth 3,124(9)
	la 3,.LC40@l(11)
	b .L197
.L152:
	lis 9,gi+40@ha
	lis 3,.LC36@ha
	lwz 0,gi+40@l(9)
	la 3,.LC36@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	lis 11,.LC35@ha
	sth 3,124(9)
	la 3,.LC35@l(11)
.L197:
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	mullw 3,3,0
	srawi 3,3,3
	slwi 3,3,2
	add 3,11,3
	lhz 0,742(3)
	sth 0,126(11)
	b .L142
.L153:
	lis 9,gi+4@ha
	lis 3,.LC41@ha
	lwz 0,gi+4@l(9)
	la 3,.LC41@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L142:
	lwz 9,84(31)
	lwz 11,3464(9)
	cmpwi 0,11,0
	bc 12,2,.L156
	lwz 0,3992(9)
	cmpwi 0,0,5
	bc 12,2,.L156
	cmpwi 0,0,7
	bc 12,2,.L156
	lwz 0,4324(9)
	cmpwi 0,0,0
	bc 12,2,.L155
.L156:
	lwz 9,84(31)
	li 0,0
	sth 0,156(9)
	b .L157
.L155:
	cmpwi 0,11,1
	bc 4,2,.L158
	lis 9,gi+40@ha
	lis 3,.LC42@ha
	lwz 0,gi+40@l(9)
	la 3,.LC42@l(3)
	b .L198
.L158:
	cmpwi 0,11,2
	bc 4,2,.L160
	lis 9,gi+40@ha
	lis 3,.LC43@ha
	lwz 0,gi+40@l(9)
	la 3,.LC43@l(3)
	b .L198
.L160:
	cmpwi 0,11,3
	bc 4,2,.L157
	lis 9,gi+40@ha
	lis 3,.LC44@ha
	lwz 0,gi+40@l(9)
	la 3,.LC44@l(3)
.L198:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,156(9)
.L157:
	mr 3,31
	bl PowerArmorType
	mr. 30,3
	bc 12,2,.L163
	lis 3,.LC45@ha
	lwz 29,84(31)
	la 3,.LC45@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	srawi 3,3,3
	slwi 3,3,2
	lwzx 25,29,3
	cmpwi 0,25,0
	bc 4,2,.L163
	lwz 0,264(31)
	lis 29,gi@ha
	lis 3,.LC46@ha
	la 29,gi@l(29)
	la 3,.LC46@l(3)
	rlwinm 0,0,0,20,18
	li 30,0
	stw 0,264(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC53@ha
	lwz 0,16(29)
	lis 11,.LC53@ha
	la 9,.LC53@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC53@l(11)
	li 4,3
	mtlr 0
	lis 9,.LC54@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC54@l(9)
	lfs 3,0(9)
	blrl
.L163:
	mr 3,31
	bl ArmorIndex
	cmpwi 0,30,0
	mr 29,3
	bc 12,2,.L165
	cmpwi 0,29,0
	bc 12,2,.L166
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L165
.L166:
	lis 9,gi+40@ha
	lis 3,.LC47@ha
	lwz 0,gi+40@l(9)
	la 3,.LC47@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,128(9)
	lwz 11,84(31)
	sth 25,130(11)
	b .L167
.L165:
	cmpwi 0,29,0
	bc 12,2,.L168
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
	b .L167
.L168:
	lwz 9,84(31)
	sth 29,128(9)
	lwz 11,84(31)
	sth 29,130(11)
.L167:
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,4164(11)
	fcmpu 0,13,0
	bc 4,1,.L170
	li 0,0
	sth 0,134(11)
	lwz 9,84(31)
	sth 0,136(9)
.L170:
	lwz 0,level@l(26)
	lis 30,0x4330
	lis 11,.LC55@ha
	xoris 0,0,0x8000
	la 11,.LC55@l(11)
	stw 0,20(1)
	stw 30,16(1)
	lfd 31,0(11)
	lfd 0,16(1)
	lwz 11,84(31)
	fsub 0,0,31
	lfs 13,4132(11)
	frsp 12,0
	fcmpu 0,13,12
	bc 4,1,.L171
	lis 9,gi+40@ha
	lis 3,.LC48@ha
	lwz 0,gi+40@l(9)
	la 3,.LC48@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC56@ha
	la 11,.LC56@l(11)
	sth 3,138(10)
	lwz 0,level@l(26)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,20(1)
	mr 11,9
	stw 30,16(1)
	lfd 13,16(1)
	lfs 0,4132(10)
	b .L199
.L171:
	lfs 0,4136(11)
	fcmpu 0,0,12
	bc 4,1,.L173
	lis 9,gi+40@ha
	lis 3,.LC49@ha
	lwz 0,gi+40@l(9)
	la 3,.LC49@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC56@ha
	la 11,.LC56@l(11)
	sth 3,138(10)
	lwz 0,level@l(26)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,20(1)
	mr 11,9
	stw 30,16(1)
	lfd 13,16(1)
	lfs 0,4136(10)
	b .L199
.L173:
	lfs 0,4144(11)
	fcmpu 0,0,12
	bc 4,1,.L175
	lis 9,gi+40@ha
	lis 3,.LC50@ha
	lwz 0,gi+40@l(9)
	la 3,.LC50@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC56@ha
	la 11,.LC56@l(11)
	sth 3,138(10)
	lwz 0,level@l(26)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,20(1)
	mr 11,9
	stw 30,16(1)
	lfd 13,16(1)
	lfs 0,4144(10)
	b .L199
.L175:
	lfs 0,4140(11)
	fcmpu 0,0,12
	bc 4,1,.L177
	lis 9,gi+40@ha
	lis 3,.LC51@ha
	lwz 0,gi+40@l(9)
	la 3,.LC51@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC56@ha
	la 11,.LC56@l(11)
	sth 3,138(10)
	lwz 0,level@l(26)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,20(1)
	mr 11,9
	stw 30,16(1)
	lfd 13,16(1)
	lfs 0,4140(10)
.L199:
	fsub 13,13,31
	frsp 13,13
	fsubs 0,0,13
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,16(1)
	lwz 11,20(1)
	sth 11,140(10)
	b .L172
.L177:
	li 0,0
	sth 0,138(11)
	lwz 9,84(31)
	sth 0,140(9)
.L172:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L179
	li 0,0
	sth 0,132(9)
	b .L180
.L179:
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
.L180:
	lwz 9,84(31)
	lhz 0,738(9)
	sth 0,144(9)
	lwz 11,84(31)
	lhz 0,3442(11)
	sth 0,148(11)
	lwz 9,84(31)
	lwz 0,3460(9)
	cmpwi 0,0,0
	bc 12,2,.L181
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L181
	lis 9,gi+40@ha
	lis 3,.LC52@ha
	lwz 0,gi+40@l(9)
	la 3,.LC52@l(3)
	b .L200
.L181:
	lwz 9,84(31)
	lwz 0,716(9)
	cmpwi 0,0,2
	bc 12,2,.L184
	lis 11,.LC57@ha
	lfs 13,112(9)
	la 11,.LC57@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L183
.L184:
	lwz 11,1788(9)
	cmpwi 0,11,0
	bc 12,2,.L183
	lis 9,gi+40@ha
	lwz 3,36(11)
	lwz 0,gi+40@l(9)
.L200:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,142(9)
	b .L117
.L183:
	lwz 9,84(31)
	li 0,0
	sth 0,142(9)
.L117:
	lis 9,deathmatch@ha
	lwz 10,84(31)
	li 0,0
	lwz 11,deathmatch@l(9)
	lis 9,.LC54@ha
	sth 0,146(10)
	la 9,.LC54@l(9)
	lfs 0,20(11)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L186
	lwz 11,84(31)
	lwz 0,724(11)
	cmpwi 0,0,0
	bc 4,1,.L188
	lis 9,level+200@ha
	lfs 0,level+200@l(9)
	fcmpu 0,0,13
	bc 4,2,.L188
	lwz 0,3912(11)
	cmpwi 0,0,0
	bc 12,2,.L191
.L188:
	lwz 9,84(31)
	b .L192
.L186:
	lwz 9,84(31)
	lwz 0,3912(9)
	cmpwi 0,0,0
	bc 4,2,.L192
	lwz 0,3928(9)
	cmpwi 0,0,0
	bc 12,2,.L191
.L192:
	lhz 0,146(9)
	ori 0,0,1
	sth 0,146(9)
.L191:
	lwz 9,84(31)
	lwz 0,3924(9)
	cmpwi 0,0,0
	bc 12,2,.L190
	lwz 0,724(9)
	cmpwi 0,0,0
	bc 4,1,.L190
	lhz 0,146(9)
	ori 0,0,2
	sth 0,146(9)
.L190:
	mr 3,31
	bl SetIDView
	lis 9,.LC54@ha
	lis 11,teamplay@ha
	la 9,.LC54@l(9)
	lfs 13,0(9)
	lwz 9,teamplay@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L194
	mr 3,31
	bl A_Scoreboard
.L194:
	lwz 0,68(1)
	mtlr 0
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe6:
	.size	 G_SetStats,.Lfe6-G_SetStats
	.section	".rodata"
	.align 2
.LC58:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Help_f
	.type	 Cmd_Help_f,@function
Cmd_Help_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC58@ha
	lis 9,deathmatch@ha
	la 11,.LC58@l(11)
	mr 8,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L114
	bl Cmd_Score_f
	b .L113
.L114:
	lwz 9,84(8)
	li 7,0
	stw 7,3924(9)
	lwz 11,84(8)
	stw 7,3912(11)
	lwz 10,84(8)
	lwz 0,3928(10)
	cmpwi 0,0,0
	bc 12,2,.L115
	lis 9,game+1024@ha
	lwz 11,3456(10)
	lwz 0,game+1024@l(9)
	cmpw 0,11,0
	bc 4,2,.L115
	stw 7,3928(10)
	b .L113
.L115:
	lwz 11,84(8)
	li 0,1
	li 10,0
	mr 3,8
	stw 0,3928(11)
	lwz 9,84(8)
	stw 10,3460(9)
	bl HelpComputer
.L113:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe7:
	.size	 Cmd_Help_f,.Lfe7-Cmd_Help_f
	.align 2
	.globl DeathmatchScoreboard
	.type	 DeathmatchScoreboard,@function
DeathmatchScoreboard:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 4,.LC0@ha
	lwz 3,280(31)
	la 4,.LC0@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L95
	lwz 4,540(31)
	mr 3,31
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L95:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 DeathmatchScoreboard,.Lfe8-DeathmatchScoreboard
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
