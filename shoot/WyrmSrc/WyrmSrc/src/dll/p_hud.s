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
	stw 0,3576(9)
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
	stw 8,3964(9)
	lwz 11,84(31)
	lwz 7,deathmatch@l(5)
	stfs 8,3996(11)
	lwz 9,84(31)
	stfs 8,3800(9)
	lwz 11,84(31)
	stfs 8,3804(11)
	lwz 9,84(31)
	stfs 8,3808(9)
	lwz 11,84(31)
	stfs 8,3812(11)
	lwz 9,84(31)
	stw 8,3816(9)
	lwz 11,84(31)
	stfs 8,3820(11)
	lwz 10,84(31)
	lwz 0,116(10)
	rlwinm 0,0,0,30,28
	stw 0,116(10)
	lwz 9,84(31)
	stfs 8,3924(9)
	lwz 11,84(31)
	stfs 8,3896(11)
	lwz 9,84(31)
	stfs 8,3900(9)
	lwz 11,84(31)
	stfs 8,3904(11)
	stw 8,248(31)
	stfs 8,1140(31)
	stw 8,508(31)
	stw 8,44(31)
	stw 8,48(31)
	stw 8,40(31)
	stw 8,64(31)
	stw 8,76(31)
	lfs 0,20(7)
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
	li 31,1160
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
	addi 31,31,1160
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
	mulli 9,30,1160
	addi 7,30,1
	addi 9,9,1160
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
	addi 10,10,84
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
	li 31,1160
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
	addi 31,31,1160
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
	mr 22,3
	mr 20,4
	lwz 9,84(22)
	lwz 0,3576(9)
	cmpwi 0,0,0
	bc 4,2,.L54
	lwz 0,3588(9)
	cmpwi 0,0,0
	bc 12,2,.L53
.L54:
	lwz 0,1820(9)
	cmpwi 0,0,0
	bc 12,2,.L53
	li 0,2
	stw 0,1820(9)
.L53:
	lwz 9,84(22)
	lwz 0,3576(9)
	cmpwi 0,0,0
	bc 12,2,.L56
	lis 9,.LC13@ha
	lis 11,ctf@ha
	la 9,.LC13@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L57
	mr 3,22
	mr 4,20
	bl CTFScoreboardMessage
	b .L52
.L57:
	lis 9,game@ha
	li 25,0
	la 11,game@l(9)
	li 28,0
	lwz 0,1544(11)
	addi 23,1,1040
	lis 17,gi@ha
	cmpw 0,25,0
	bc 4,0,.L59
	lis 9,g_edicts@ha
	mr 26,11
	lwz 24,g_edicts@l(9)
	addi 31,1,3472
.L61:
	mulli 9,28,1160
	addi 27,28,1
	add 29,9,24
	lwz 0,1248(29)
	cmpwi 0,0,0
	bc 12,2,.L60
	lwz 0,1028(26)
	mulli 9,28,4016
	add 9,9,0
	lwz 11,3496(9)
	cmpwi 0,11,0
	bc 4,2,.L60
	li 5,0
	lwz 29,3480(9)
	addi 4,1,3472
	cmpw 0,5,25
	addi 3,1,2448
	addi 30,25,1
	bc 4,0,.L65
	lwz 0,0(31)
	cmpw 0,29,0
	bc 12,1,.L65
	mr 9,4
.L66:
	addi 5,5,1
	cmpw 0,5,25
	bc 4,0,.L65
	lwzu 0,4(9)
	cmpw 0,29,0
	bc 4,1,.L66
.L65:
	cmpw 0,25,5
	mr 7,25
	slwi 12,5,2
	bc 4,1,.L71
	slwi 9,25,2
	mr 6,3
	mr 10,9
	mr 8,4
	addi 11,9,-4
.L73:
	lwzx 9,11,6
	addi 7,7,-1
	cmpw 0,7,5
	stwx 9,10,6
	lwzx 0,11,8
	addi 11,11,-4
	stwx 0,10,8
	addi 10,10,-4
	bc 12,1,.L73
.L71:
	stwx 28,3,12
	mr 25,30
	stwx 29,4,12
.L60:
	lwz 0,1544(26)
	mr 28,27
	cmpw 0,28,0
	bc 12,0,.L61
.L59:
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
	bc 4,0,.L91
	lis 9,game@ha
	lis 18,g_edicts@ha
	la 19,game@l(9)
	addi 24,1,2448
	li 21,0
.L80:
	addi 9,1,2448
	la 11,gi@l(17)
	lwz 10,1028(19)
	lwzx 0,9,21
	lis 3,.LC8@ha
	lwz 8,40(11)
	la 3,.LC8@l(3)
	mulli 9,0,1160
	lwz 11,g_edicts@l(18)
	mtlr 8
	mulli 0,0,4016
	addi 9,9,1160
	add 29,11,9
	add 31,10,0
	blrl
	lis 9,0x2aaa
	srawi 11,28,31
	ori 9,9,43691
	cmpwi 7,28,6
	mulhw 9,28,9
	cmpw 6,29,22
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
	bc 4,26,.L83
	lis 9,.LC9@ha
	la 8,.LC9@l(9)
	b .L84
.L83:
	cmpw 0,29,20
	bc 4,2,.L85
	lis 9,.LC10@ha
	la 8,.LC10@l(9)
	b .L84
.L85:
	li 8,0
.L84:
	cmpwi 0,8,0
	bc 12,2,.L87
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
	bc 12,1,.L91
	add 3,23,30
	addi 4,1,16
	bl strcpy
	mr 30,29
.L87:
	lis 9,level@ha
	lwz 10,3476(31)
	lis 0,0x1b4e
	lwz 11,level@l(9)
	ori 0,0,33205
	lis 5,.LC12@ha
	lwz 8,0(24)
	addi 3,1,16
	la 5,.LC12@l(5)
	subf 11,10,11
	lwz 9,3480(31)
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
	bc 12,1,.L91
	add 3,23,30
	addi 4,1,16
	bl strcpy
	addi 28,28,1
	mr 30,29
	cmpw 0,28,25
	addi 21,21,4
	bc 12,0,.L80
	b .L91
.L56:
	stb 0,1040(1)
	addi 23,1,1040
.L91:
	lwz 9,84(22)
	lwz 0,1820(9)
	andi. 9,0,1
	bc 12,2,.L92
	mr 3,22
	mr 4,23
	bl ShowScanner
.L92:
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
	bc 4,2,.L100
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L101
.L100:
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L102
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
	b .L101
.L102:
	lis 11,.LC21@ha
	la 11,.LC21@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L104
	lis 9,.LC16@ha
	la 6,.LC16@l(9)
	b .L101
.L104:
	lis 9,.LC17@ha
	la 6,.LC17@l(9)
.L101:
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
	stmw 29,12(1)
	stw 0,36(1)
	lis 9,.LC22@ha
	lis 29,deathmatch@ha
	la 9,.LC22@l(9)
	mr 31,3
	lfs 31,0(9)
	lwz 9,deathmatch@l(29)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L107
	lwz 11,84(31)
	li 30,0
	stw 30,3588(11)
	lwz 9,84(31)
	stw 30,3592(9)
	lwz 11,84(31)
	lwz 0,3584(11)
	cmpwi 0,0,0
	bc 12,2,.L108
	bl PMenu_Close
.L108:
	lwz 9,deathmatch@l(29)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 4,2,.L109
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L106
.L109:
	lwz 9,84(31)
	lwz 0,3576(9)
	cmpwi 0,0,0
	bc 12,2,.L111
	stw 30,3576(9)
	b .L106
.L111:
	li 0,1
	mr 3,31
	stw 0,3576(9)
	lwz 4,540(31)
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L106
.L107:
	lwz 11,84(31)
	li 8,0
	stw 8,3588(11)
	lwz 9,84(31)
	stw 8,3576(9)
	lwz 11,84(31)
	stw 8,1820(11)
	lwz 10,84(31)
	lwz 0,3592(10)
	cmpwi 0,0,0
	bc 12,2,.L113
	lis 9,game+1024@ha
	lwz 11,1804(10)
	lwz 0,game+1024@l(9)
	cmpw 0,11,0
	bc 4,2,.L113
	stw 8,3592(10)
	b .L106
.L113:
	lwz 11,84(31)
	li 0,1
	li 10,0
	mr 3,31
	stw 0,3592(11)
	lwz 9,84(31)
	stw 10,1808(9)
	bl HelpComputer
.L106:
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
.LC23:
	.string	"Shells"
	.align 2
.LC24:
	.string	"marc1"
	.align 2
.LC25:
	.string	"Bullets"
	.align 2
.LC26:
	.string	"marc2"
	.align 2
.LC27:
	.string	"Grenades"
	.align 2
.LC28:
	.string	"marc3"
	.align 2
.LC29:
	.string	"Rockets"
	.align 2
.LC30:
	.string	"marc4"
	.align 2
.LC31:
	.string	"Slugs"
	.align 2
.LC32:
	.string	"marc5"
	.align 2
.LC33:
	.string	"Cells"
	.align 2
.LC34:
	.string	"marc6"
	.align 2
.LC35:
	.string	"cells"
	.align 2
.LC36:
	.string	"misc/power2.wav"
	.align 2
.LC37:
	.string	"i_powershield"
	.align 2
.LC38:
	.string	"i_powerscreen"
	.align 2
.LC39:
	.string	"p_jetpack"
	.align 2
.LC40:
	.string	"Jetpack"
	.align 2
.LC41:
	.string	"p_quad"
	.align 2
.LC42:
	.string	"p_invulnerability"
	.align 2
.LC43:
	.string	"p_cloak"
	.align 2
.LC44:
	.string	"p_envirosuit"
	.align 2
.LC45:
	.string	"p_rebreather"
	.align 2
.LC46:
	.string	"p_goggles"
	.align 2
.LC47:
	.string	"p_adrenaline"
	.align 2
.LC48:
	.string	"ctfsb1"
	.align 2
.LC49:
	.string	"ctfsb2"
	.align 2
.LC50:
	.string	"i_help"
	.align 2
.LC51:
	.long 0x3f800000
	.align 2
.LC52:
	.long 0x0
	.align 3
.LC53:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC54:
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
	mr 31,3
	lwz 10,84(31)
	lwz 9,1816(10)
	cmpwi 0,9,2
	bc 12,2,.L116
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 4,2,.L115
.L116:
	li 0,0
	sth 0,180(10)
	b .L189
.L115:
	cmpwi 0,9,0
	bc 4,2,.L118
	sth 9,180(10)
	li 0,1
.L189:
	lwz 9,84(31)
	sth 0,182(9)
	b .L117
.L118:
	li 0,1
	li 11,0
	sth 0,180(10)
	lwz 9,84(31)
	sth 11,182(9)
.L117:
	lis 9,level+266@ha
	lwz 11,84(31)
	lis 28,level@ha
	lhz 0,level+266@l(9)
	sth 0,120(11)
	lwz 9,84(31)
	lhz 0,482(31)
	sth 0,122(9)
	lwz 9,84(31)
	lwz 11,1788(9)
	cmpwi 0,11,0
	bc 12,2,.L120
	lis 9,gi+40@ha
	lwz 3,36(11)
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,124(9)
	b .L121
.L120:
	sth 11,124(9)
	lwz 9,84(31)
	sth 11,126(9)
.L121:
	lwz 9,84(31)
	lha 0,182(9)
	cmpwi 0,0,0
	bc 12,2,.L122
	li 0,0
	lis 3,.LC23@ha
	sth 0,168(9)
	la 3,.LC23@l(3)
	lwz 9,84(31)
	sth 0,170(9)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 10,84(31)
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 3,9,3
	lwz 11,3600(10)
	mullw 3,3,0
	srawi 29,3,2
	cmpw 0,29,11
	bc 4,2,.L123
	lis 9,gi+40@ha
	lis 3,.LC24@ha
	lwz 0,gi+40@l(9)
	la 3,.LC24@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,168(9)
	b .L124
.L123:
	lwz 0,3604(10)
	cmpw 0,29,0
	bc 4,2,.L124
	lis 9,gi+40@ha
	lis 3,.LC24@ha
	lwz 0,gi+40@l(9)
	la 3,.LC24@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,170(9)
.L124:
	lwz 11,84(31)
	slwi 9,29,2
	lis 3,.LC25@ha
	la 3,.LC25@l(3)
	add 9,11,9
	lhz 0,742(9)
	sth 0,174(11)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 10,84(31)
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 3,9,3
	lwz 11,3600(10)
	mullw 3,3,0
	srawi 29,3,2
	cmpw 0,29,11
	bc 4,2,.L126
	lis 9,gi+40@ha
	lis 3,.LC26@ha
	lwz 0,gi+40@l(9)
	la 3,.LC26@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,168(9)
	b .L127
.L126:
	lwz 0,3604(10)
	cmpw 0,29,0
	bc 4,2,.L127
	lis 9,gi+40@ha
	lis 3,.LC26@ha
	lwz 0,gi+40@l(9)
	la 3,.LC26@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,170(9)
.L127:
	lwz 11,84(31)
	slwi 9,29,2
	lis 3,.LC27@ha
	la 3,.LC27@l(3)
	add 9,11,9
	lhz 0,742(9)
	sth 0,176(11)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 10,84(31)
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 3,9,3
	lwz 11,3600(10)
	mullw 3,3,0
	srawi 29,3,2
	cmpw 0,29,11
	bc 4,2,.L129
	lis 9,gi+40@ha
	lis 3,.LC28@ha
	lwz 0,gi+40@l(9)
	la 3,.LC28@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,168(9)
	b .L130
.L129:
	lwz 0,3604(10)
	cmpw 0,29,0
	bc 4,2,.L130
	lis 9,gi+40@ha
	lis 3,.LC28@ha
	lwz 0,gi+40@l(9)
	la 3,.LC28@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,170(9)
.L130:
	lwz 11,84(31)
	slwi 9,29,2
	lis 3,.LC29@ha
	la 3,.LC29@l(3)
	add 9,11,9
	lhz 0,742(9)
	sth 0,178(11)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 10,84(31)
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 3,9,3
	lwz 11,3600(10)
	mullw 3,3,0
	srawi 29,3,2
	cmpw 0,29,11
	bc 4,2,.L132
	lis 9,gi+40@ha
	lis 3,.LC30@ha
	lwz 0,gi+40@l(9)
	la 3,.LC30@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,168(9)
	b .L133
.L132:
	lwz 0,3604(10)
	cmpw 0,29,0
	bc 4,2,.L133
	lis 9,gi+40@ha
	lis 3,.LC30@ha
	lwz 0,gi+40@l(9)
	la 3,.LC30@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,170(9)
.L133:
	lwz 11,84(31)
	slwi 9,29,2
	lis 3,.LC31@ha
	la 3,.LC31@l(3)
	add 9,11,9
	lhz 0,742(9)
	sth 0,156(11)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 10,84(31)
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 3,9,3
	lwz 11,3600(10)
	mullw 3,3,0
	srawi 29,3,2
	cmpw 0,29,11
	bc 4,2,.L135
	lis 9,gi+40@ha
	lis 3,.LC32@ha
	lwz 0,gi+40@l(9)
	la 3,.LC32@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,168(9)
	b .L136
.L135:
	lwz 0,3604(10)
	cmpw 0,29,0
	bc 4,2,.L136
	lis 9,gi+40@ha
	lis 3,.LC32@ha
	lwz 0,gi+40@l(9)
	la 3,.LC32@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,170(9)
.L136:
	lwz 11,84(31)
	slwi 9,29,2
	lis 3,.LC33@ha
	la 3,.LC33@l(3)
	add 9,11,9
	lhz 0,742(9)
	sth 0,158(11)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 10,84(31)
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 3,9,3
	lwz 11,3600(10)
	mullw 3,3,0
	srawi 29,3,2
	cmpw 0,29,11
	bc 4,2,.L138
	lis 9,gi+40@ha
	lis 3,.LC34@ha
	lwz 0,gi+40@l(9)
	la 3,.LC34@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,168(9)
	b .L139
.L138:
	lwz 0,3604(10)
	cmpw 0,29,0
	bc 4,2,.L139
	lis 9,gi+40@ha
	lis 3,.LC34@ha
	lwz 0,gi+40@l(9)
	la 3,.LC34@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,170(9)
.L139:
	lwz 9,84(31)
	slwi 11,29,2
	add 11,9,11
	lhz 0,742(11)
	sth 0,166(9)
.L122:
	mr 3,31
	bl PowerArmorType
	mr. 30,3
	bc 12,2,.L141
	lis 3,.LC35@ha
	lwz 29,84(31)
	la 3,.LC35@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x3cf3
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 27,29,3
	cmpwi 0,27,0
	bc 4,2,.L141
	lwz 0,264(31)
	lis 29,gi@ha
	lis 3,.LC36@ha
	la 29,gi@l(29)
	la 3,.LC36@l(3)
	rlwinm 0,0,0,20,17
	li 30,0
	stw 0,264(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC51@ha
	lwz 0,16(29)
	lis 11,.LC51@ha
	la 9,.LC51@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC51@l(11)
	li 4,3
	mtlr 0
	lis 9,.LC52@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC52@l(9)
	lfs 3,0(9)
	blrl
.L141:
	mr 3,31
	bl ArmorIndex
	cmpwi 0,30,0
	mr 29,3
	bc 12,2,.L143
	cmpwi 0,29,0
	bc 12,2,.L144
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L143
.L144:
	cmpwi 0,30,2
	bc 4,2,.L145
	lis 9,gi+40@ha
	lis 3,.LC37@ha
	lwz 0,gi+40@l(9)
	la 3,.LC37@l(3)
	b .L190
.L145:
	lis 9,gi+40@ha
	lis 3,.LC38@ha
	lwz 0,gi+40@l(9)
	la 3,.LC38@l(3)
.L190:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,128(9)
	lwz 9,84(31)
	sth 27,130(9)
	b .L147
.L143:
	cmpwi 0,29,0
	bc 12,2,.L148
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
	b .L147
.L148:
	lwz 9,84(31)
	sth 29,128(9)
	lwz 11,84(31)
	sth 29,130(11)
.L147:
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,3832(11)
	fcmpu 0,13,0
	bc 4,1,.L150
	li 0,0
	sth 0,134(11)
	lwz 9,84(31)
	sth 0,136(9)
.L150:
	mr 3,31
	bl Jet_Active
	mr. 3,3
	bc 12,2,.L151
	lis 9,gi+40@ha
	lis 3,.LC39@ha
	lwz 0,gi+40@l(9)
	la 3,.LC39@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	lis 11,.LC40@ha
	sth 3,138(9)
	la 3,.LC40@l(11)
	bl FindItem
	lis 9,itemlist@ha
	lis 11,0x3cf3
	lwz 8,84(31)
	la 9,itemlist@l(9)
	ori 11,11,53053
	subf 3,9,3
	addi 10,8,740
	mullw 3,3,11
	lis 0,0x6666
	ori 0,0,26215
	rlwinm 3,3,0,0,29
	lwzx 9,10,3
	mulhw 0,9,0
	srawi 9,9,31
	srawi 0,0,2
	subf 0,9,0
	sth 0,140(8)
	b .L152
.L151:
	lwz 0,level@l(28)
	lis 30,0x4330
	lis 11,.LC53@ha
	xoris 0,0,0x8000
	la 11,.LC53@l(11)
	stw 0,28(1)
	stw 30,24(1)
	lfd 31,0(11)
	lfd 0,24(1)
	lwz 11,84(31)
	fsub 0,0,31
	lfs 13,3800(11)
	frsp 12,0
	fcmpu 0,13,12
	bc 4,1,.L153
	lis 9,gi+40@ha
	lis 3,.LC41@ha
	lwz 0,gi+40@l(9)
	la 3,.LC41@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC54@ha
	la 11,.LC54@l(11)
	sth 3,138(10)
	lwz 0,level@l(28)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3800(10)
	b .L191
.L153:
	lfs 0,3804(11)
	fcmpu 0,0,12
	bc 4,1,.L155
	lis 9,gi+40@ha
	lis 3,.LC42@ha
	lwz 0,gi+40@l(9)
	la 3,.LC42@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC54@ha
	la 11,.LC54@l(11)
	sth 3,138(10)
	lwz 0,level@l(28)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3804(10)
	b .L191
.L155:
	lfs 0,3900(11)
	fcmpu 0,0,12
	bc 4,1,.L157
	lis 9,gi+40@ha
	lis 3,.LC43@ha
	lwz 0,gi+40@l(9)
	la 3,.LC43@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC54@ha
	la 11,.LC54@l(11)
	sth 3,138(10)
	lwz 0,level@l(28)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3900(10)
	b .L191
.L157:
	lfs 0,3812(11)
	fcmpu 0,0,12
	bc 4,1,.L159
	lis 9,gi+40@ha
	lis 3,.LC44@ha
	lwz 0,gi+40@l(9)
	la 3,.LC44@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC54@ha
	la 11,.LC54@l(11)
	sth 3,138(10)
	lwz 0,level@l(28)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3812(10)
	b .L191
.L159:
	lfs 0,3808(11)
	fcmpu 0,0,12
	bc 4,1,.L161
	lis 9,gi+40@ha
	lis 3,.LC45@ha
	lwz 0,gi+40@l(9)
	la 3,.LC45@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC54@ha
	la 11,.LC54@l(11)
	sth 3,138(10)
	lwz 0,level@l(28)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3808(10)
	b .L191
.L161:
	lfs 0,3924(11)
	fcmpu 0,0,12
	bc 4,1,.L163
	lis 9,gi+40@ha
	lis 3,.LC46@ha
	lwz 0,gi+40@l(9)
	la 3,.LC46@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC54@ha
	la 11,.LC54@l(11)
	sth 3,138(10)
	lwz 0,level@l(28)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3924(10)
	b .L191
.L163:
	lfs 0,3896(11)
	fcmpu 0,0,12
	bc 4,1,.L165
	lis 9,gi+40@ha
	lis 3,.LC47@ha
	lwz 0,gi+40@l(9)
	la 3,.LC47@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC54@ha
	la 11,.LC54@l(11)
	sth 3,138(10)
	lwz 0,level@l(28)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3896(10)
.L191:
	fsub 13,13,31
	frsp 13,13
	fsubs 0,0,13
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,24(1)
	lwz 11,28(1)
	sth 11,140(10)
	b .L152
.L165:
	sth 3,138(11)
	lwz 9,84(31)
	sth 3,140(9)
.L152:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L167
	li 0,0
	sth 0,132(9)
	b .L168
.L167:
	lis 9,itemlist@ha
	lis 11,gi+40@ha
	mulli 0,0,84
	la 9,itemlist@l(9)
	lwz 11,gi+40@l(11)
	addi 9,9,36
	lwzx 3,9,0
	mtlr 11
	blrl
	lwz 9,84(31)
	sth 3,132(9)
.L168:
	lwz 11,84(31)
	lis 9,deathmatch@ha
	li 10,0
	lwz 8,deathmatch@l(9)
	lhz 0,738(11)
	lis 9,.LC52@ha
	la 9,.LC52@l(9)
	sth 0,144(11)
	lfs 13,0(9)
	lwz 9,84(31)
	sth 10,146(9)
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L169
	lwz 11,84(31)
	lwz 0,724(11)
	cmpwi 0,0,0
	bc 4,1,.L175
	lis 9,level+200@ha
	lfs 0,level+200@l(9)
	fcmpu 0,0,13
	bc 4,2,.L175
	lwz 0,3576(11)
	cmpwi 0,0,0
	bc 4,2,.L175
	lwz 0,1820(11)
	b .L193
.L169:
	lwz 9,84(31)
	lwz 0,3576(9)
	cmpwi 0,0,0
	bc 4,2,.L175
	lwz 0,3592(9)
	cmpwi 0,0,0
	bc 4,2,.L175
	lwz 0,1820(9)
.L193:
	cmpwi 0,0,0
	bc 12,2,.L174
.L175:
	lwz 9,84(31)
	lhz 0,146(9)
	ori 0,0,1
	sth 0,146(9)
.L174:
	lwz 9,84(31)
	lwz 0,3588(9)
	cmpwi 0,0,0
	bc 12,2,.L173
	lwz 0,724(9)
	cmpwi 0,0,0
	bc 4,1,.L173
	lhz 0,146(9)
	ori 0,0,2
	sth 0,146(9)
.L173:
	lwz 10,84(31)
	lis 11,.LC52@ha
	lis 9,ctf@ha
	la 11,.LC52@l(11)
	lfs 13,0(11)
	lhz 0,3482(10)
	lwz 11,ctf@l(9)
	sth 0,148(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L177
	lis 9,level+200@ha
	lfs 0,level+200@l(9)
	fcmpu 0,0,13
	bc 12,2,.L185
	bl CTF_GetWinner
	mr. 3,3
	bc 12,2,.L185
	lwz 0,level@l(28)
	andi. 9,0,8
	bc 4,2,.L186
	cmpwi 0,3,1
	bc 4,2,.L182
	lis 9,gi+40@ha
	lis 3,.LC48@ha
	lwz 0,gi+40@l(9)
	la 3,.LC48@l(3)
	b .L192
.L182:
	cmpwi 0,3,2
	bc 4,2,.L185
	lis 9,gi+40@ha
	lis 3,.LC49@ha
	lwz 0,gi+40@l(9)
	la 3,.LC49@l(3)
	b .L192
.L177:
	lwz 9,84(31)
	lwz 0,1808(9)
	cmpwi 0,0,0
	bc 12,2,.L186
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L186
	lis 9,gi+40@ha
	lis 3,.LC50@ha
	lwz 0,gi+40@l(9)
	la 3,.LC50@l(3)
.L192:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,142(9)
	b .L185
.L186:
	lwz 9,84(31)
	li 0,0
	sth 0,142(9)
.L185:
	lwz 9,84(31)
	li 0,0
	mr 3,31
	sth 0,154(9)
	bl SetTechStat
	lwz 9,84(31)
	lha 0,180(9)
	cmpwi 0,0,0
	bc 12,2,.L188
	mr 3,31
	bl SetCTFStats
.L188:
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
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	li 30,0
	lwz 9,84(31)
	stw 30,3588(9)
	lwz 11,84(31)
	stw 30,3592(11)
	lwz 9,84(31)
	lwz 0,3584(9)
	cmpwi 0,0,0
	bc 12,2,.L95
	bl PMenu_Close
.L95:
	lis 11,.LC55@ha
	lis 9,deathmatch@ha
	la 11,.LC55@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L96
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L94
.L96:
	lwz 9,84(31)
	lwz 0,3576(9)
	cmpwi 0,0,0
	bc 12,2,.L97
	stw 30,3576(9)
	b .L94
.L97:
	li 0,1
	mr 3,31
	stw 0,3576(9)
	lwz 4,540(31)
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L94:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
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
	lwz 0,3888(31)
	cmpwi 0,0,0
	bc 4,2,.L203
	bl G_SetStats
.L203:
	lwz 0,724(31)
	li 9,1
	li 11,0
	sth 9,154(31)
	cmpwi 0,0,0
	sth 11,146(31)
	bc 4,1,.L205
	lis 11,.LC56@ha
	lis 9,level+200@ha
	la 11,.LC56@l(11)
	lfs 0,level+200@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L205
	lwz 0,3576(31)
	cmpwi 0,0,0
	bc 12,2,.L204
.L205:
	lhz 0,146(31)
	ori 0,0,1
	sth 0,146(31)
.L204:
	lwz 0,3588(31)
	cmpwi 0,0,0
	bc 12,2,.L206
	lwz 0,724(31)
	cmpwi 0,0,0
	bc 4,1,.L206
	lhz 0,146(31)
	ori 0,0,2
	sth 0,146(31)
.L206:
	lwz 10,3888(31)
	cmpwi 0,10,0
	bc 12,2,.L207
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L207
	lis 11,g_edicts@ha
	lis 0,0xfe3
	lwz 9,g_edicts@l(11)
	ori 0,0,49265
	subf 9,9,10
	mullw 9,9,0
	srawi 9,9,3
	addi 9,9,1311
	sth 9,152(31)
	b .L208
.L207:
	li 0,0
	sth 0,152(31)
.L208:
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
	bc 4,3,.L196
	lis 9,.LC58@ha
	lis 28,g_edicts@ha
	la 9,.LC58@l(9)
	lis 27,0x4330
	lfd 31,0(9)
	li 31,1160
.L198:
	lwz 9,g_edicts@l(28)
	add 9,31,9
	lwz 0,88(9)
	lwz 3,84(9)
	cmpwi 0,0,0
	bc 12,2,.L197
	lwz 0,3888(3)
	cmpw 0,0,30
	bc 4,2,.L197
	lwz 4,84(30)
	addi 3,3,120
	li 5,64
	addi 4,4,120
	crxor 6,6,6
	bl memcpy
	lwz 3,g_edicts@l(28)
	add 3,3,31
	bl G_SetSpectatorStats
.L197:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 31,31,1160
	stw 0,12(1)
	stw 27,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L198
.L196:
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
