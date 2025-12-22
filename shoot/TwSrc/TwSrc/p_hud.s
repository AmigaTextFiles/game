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
	stw 0,3612(9)
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
	stfs 8,3920(9)
	lwz 11,84(31)
	lwz 10,deathmatch@l(5)
	stfs 8,3876(11)
	lwz 9,84(31)
	stfs 8,3880(9)
	lwz 11,84(31)
	stfs 8,3884(11)
	lwz 9,84(31)
	stfs 8,3888(9)
	lwz 11,84(31)
	stw 8,3892(11)
	lwz 9,84(31)
	stfs 8,3896(9)
	stw 8,248(31)
	stw 8,784(31)
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
	li 31,1268
.L16:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L15
	lwz 0,728(3)
	cmpwi 0,0,0
	bc 12,1,.L15
	bl respawn
.L15:
	addi 30,30,1
	lwz 11,maxclients@l(26)
	xoris 0,30,0x8000
	addi 31,31,1268
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
	lwz 0,780(27)
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
	mulli 9,30,1268
	addi 7,30,1
	addi 9,9,1268
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
	addi 9,9,748
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
	li 4,284
	bl G_Find
	lis 29,.LC3@ha
	mr. 31,3
	bc 4,2,.L36
	lis 5,.LC4@ha
	li 3,0
	la 5,.LC4@l(5)
	li 4,284
	bl G_Find
	mr. 31,3
	bc 4,2,.L38
	lis 5,.LC5@ha
	li 3,0
	la 5,.LC5@l(5)
	li 4,284
	bl G_Find
	mr 31,3
	b .L38
.L36:
	bl rand
	rlwinm 30,3,0,30,31
	b .L39
.L41:
	mr 3,31
	li 4,284
	la 5,.LC3@l(29)
	bl G_Find
	mr. 31,3
	bc 4,2,.L39
	li 3,0
	li 4,284
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
	li 31,1268
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
	addi 31,31,1268
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
	.ascii	"xv 0 yv 0 cstring2 \"Here Are Class Selection Commands:\" xv"
	.ascii	" 0 yv 16 cstring2 \"Scout         = Spawn as scout\" xv 0 yv"
	.ascii	" 24 cstring2 \"Assasin       = Spawn as assasin\" xv 0 yv 32"
	.ascii	" cstring2 \"Soldier       = Spawn as soldier\" xv 0 yv 40 cs"
	.ascii	"tring2 \"Demoman       = Spawn as demoman\" xv 0 yv 48 cstri"
	.ascii	"ng2 \"Hwguy         = Spawn as hwguy\" xv 0 yv 56 cstring2 \""
	.ascii	"Energyguy"
	.string	"     = Spawn as Energyguy\" xv 0 yv 64 cstring2 \"Watertrooper  = Spawn as Under Water Trooper\" xv 0 yv 72 cstring2 \"Engineer      = Spawn as Engineer\" xv 0 yv 80 cstring2 \"Berserk       = Spawn as Berserk\" xv 0 yv 88 cstring2 \"Spy           = Spawn as Spy\" "
	.align 2
.LC9:
	.string	"i_fixme"
	.align 2
.LC10:
	.string	"tag1"
	.align 2
.LC11:
	.string	"tag2"
	.align 2
.LC12:
	.string	"xv 0 yv 0 cstring2 \"%s\" xv 0 yv 16 cstring2 \"BLUE Score:%i Players:%i\" xv 0 yv 24 cstring2 \"RED Score:%i Players:%i\" "
	.align 2
.LC13:
	.string	"xv 0 yv 0 cstring2 \"%s\" xv 0 yv 8 cstring2 \"BLUE Score:%i Players:%i\" xv 0 yv 16 cstring2 \"RED Score:%i Players:%i\" xv 0 yv 24 cstring2 \"NEUTRAL Score:%i Players: %i\" "
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
	stmw 16,4496(1)
	stw 0,4564(1)
	mr 22,3
	mr 19,4
	lwz 9,84(22)
	lwz 0,3612(9)
	cmpwi 0,0,0
	bc 4,2,.L54
	lwz 0,3616(9)
	cmpwi 0,0,0
	bc 12,2,.L53
.L54:
	lwz 0,1864(9)
	cmpwi 0,0,0
	bc 12,2,.L53
	li 0,2
	stw 0,1864(9)
.L53:
	lwz 9,84(22)
	lwz 0,3612(9)
	cmpwi 0,0,0
	bc 4,2,.L57
	lwz 0,3616(9)
	cmpwi 0,0,0
	bc 12,2,.L56
.L57:
	lwz 0,1868(9)
	cmpwi 0,0,0
	bc 12,2,.L56
	li 0,2
	stw 0,1868(9)
.L56:
	lwz 9,84(22)
	lwz 0,3612(9)
	cmpwi 0,0,0
	bc 12,2,.L59
	lis 9,game@ha
	li 26,0
	la 11,game@l(9)
	li 30,0
	lwz 0,1544(11)
	addi 25,1,1040
	lis 16,gi@ha
	cmpw 0,26,0
	bc 4,0,.L61
	lis 9,g_edicts@ha
	mr 24,11
	lwz 23,g_edicts@l(9)
	addi 31,1,3472
.L63:
	mulli 9,30,1268
	addi 27,30,1
	add 29,9,23
	lwz 0,1356(29)
	cmpwi 0,0,0
	bc 12,2,.L62
	lwz 0,1028(24)
	mulli 9,30,3960
	li 29,0
	addi 5,1,3472
	cmpw 0,29,26
	addi 4,1,2448
	add 9,9,0
	addi 28,26,1
	lwz 3,3560(9)
	bc 4,0,.L66
	lwz 0,0(31)
	cmpw 0,3,0
	bc 12,1,.L66
	mr 9,5
.L67:
	addi 29,29,1
	cmpw 0,29,26
	bc 4,0,.L66
	lwzu 0,4(9)
	cmpw 0,3,0
	bc 4,1,.L67
.L66:
	cmpw 0,26,29
	mr 7,26
	slwi 12,29,2
	bc 4,1,.L72
	slwi 9,26,2
	mr 6,4
	mr 10,9
	mr 8,5
	addi 11,9,-4
.L74:
	lwzx 9,11,6
	addi 7,7,-1
	cmpw 0,7,29
	stwx 9,10,6
	lwzx 0,11,8
	addi 11,11,-4
	stwx 0,10,8
	addi 10,10,-4
	bc 12,1,.L74
.L72:
	stwx 30,4,12
	mr 26,28
	stwx 3,5,12
.L62:
	lwz 0,1544(24)
	mr 30,27
	cmpw 0,30,0
	bc 12,0,.L63
.L61:
	li 0,0
	mr 3,25
	stb 0,1040(1)
	li 30,0
	bl strlen
	cmpwi 7,26,13
	mr 31,3
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 0,26,0
	rlwinm 9,9,0,28,29
	or 26,0,9
	cmpw 0,30,26
	bc 4,0,.L94
	lis 9,game@ha
	lis 17,g_edicts@ha
	la 18,game@l(9)
	addi 21,1,2448
.L81:
	addi 9,1,2448
	slwi 10,30,2
	lwz 8,1028(18)
	lwzx 0,9,10
	la 11,gi@l(16)
	lis 3,.LC9@ha
	lwz 10,40(11)
	la 3,.LC9@l(3)
	mulli 9,0,1268
	lwz 11,g_edicts@l(17)
	mtlr 10
	mulli 0,0,3960
	addi 9,9,1268
	add 29,11,9
	add 27,8,0
	blrl
	lis 9,0x2aaa
	srawi 11,30,31
	ori 9,9,43691
	cmpwi 7,30,6
	mulhw 9,30,9
	cmpw 6,29,22
	subf 9,11,9
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	mulli 9,9,6
	neg 0,0
	andi. 23,0,160
	subf 9,9,30
	slwi 9,9,5
	addi 24,9,32
	bc 4,26,.L84
	lis 9,.LC10@ha
	la 28,.LC10@l(9)
	b .L85
.L84:
	cmpw 0,29,19
	bc 4,2,.L86
	lis 9,.LC11@ha
	la 28,.LC11@l(9)
	b .L85
.L86:
	li 28,0
.L85:
	lis 9,level@ha
	lis 20,level@ha
	la 29,level@l(9)
	lwz 0,316(29)
	cmpwi 0,0,0
	bc 4,2,.L88
	lwz 10,356(29)
	lis 5,.LC12@ha
	addi 6,29,8
	lwz 7,304(29)
	addi 3,1,16
	li 4,1024
	lwz 8,352(29)
	la 5,.LC12@l(5)
	lwz 9,308(29)
	crxor 6,6,6
	bl Com_sprintf
	b .L97
.L88:
	lwz 11,312(29)
	lis 5,.LC13@ha
	addi 6,29,8
	lwz 0,360(29)
	addi 3,1,16
	la 5,.LC13@l(5)
	lwz 7,304(29)
	li 4,1024
	lwz 8,352(29)
	lwz 9,308(29)
	lwz 10,356(29)
	stw 11,8(1)
	stw 0,12(1)
	crxor 6,6,6
	bl Com_sprintf
.L97:
	addi 3,1,16
	bl strlen
	mr 29,3
	addi 4,1,16
	add 3,25,31
	bl strcpy
	add 31,31,29
	cmpwi 0,28,0
	bc 12,2,.L90
	lis 5,.LC14@ha
	addi 3,1,16
	mr 8,28
	la 5,.LC14@l(5)
	li 4,1024
	addi 6,23,32
	mr 7,24
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,16
	bl strlen
	add 29,31,3
	cmpwi 0,29,1024
	bc 12,1,.L94
	add 3,25,31
	addi 4,1,16
	bl strcpy
	mr 31,29
.L90:
	lwz 9,3556(27)
	lis 0,0x1b4e
	lis 5,.LC15@ha
	lwz 11,level@l(20)
	ori 0,0,33205
	addi 3,1,16
	lwz 8,0(21)
	la 5,.LC15@l(5)
	mr 6,23
	subf 11,9,11
	lwz 10,184(27)
	mr 7,24
	mulhw 0,11,0
	lwz 9,3560(27)
	li 4,1024
	addi 21,21,4
	srawi 11,11,31
	srawi 0,0,6
	subf 0,11,0
	stw 0,8(1)
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,16
	bl strlen
	add 29,31,3
	cmpwi 0,29,1024
	bc 12,1,.L94
	add 3,25,31
	addi 4,1,16
	bl strcpy
	addi 30,30,1
	mr 31,29
	cmpw 0,30,26
	bc 12,0,.L81
	b .L94
.L59:
	stb 0,1040(1)
	addi 25,1,1040
.L94:
	lwz 9,84(22)
	lwz 0,1864(9)
	andi. 9,0,1
	bc 12,2,.L95
	mr 3,22
	mr 4,25
	bl ShowScanner
.L95:
	lwz 9,84(22)
	lwz 0,1868(9)
	andi. 9,0,1
	bc 12,2,.L96
	mr 3,22
	mr 4,25
	crxor 6,6,6
	bl ShowClasses
.L96:
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,116(29)
	mr 3,25
	mtlr 0
	blrl
	lwz 0,4564(1)
	mtlr 0
	lmw 16,4496(1)
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
	bc 4,2,.L107
	lis 9,.LC16@ha
	la 6,.LC16@l(9)
	b .L108
.L107:
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L109
	lis 9,.LC17@ha
	la 6,.LC17@l(9)
	b .L108
.L109:
	lis 11,.LC23@ha
	la 11,.LC23@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L111
	lis 9,.LC18@ha
	la 6,.LC18@l(9)
	b .L108
.L111:
	lis 9,.LC19@ha
	la 6,.LC19@l(9)
.L108:
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
	bc 12,2,.L114
	lwz 9,84(31)
	li 8,0
	stw 8,3616(9)
	lwz 11,84(31)
	stw 8,3620(11)
	lfs 0,20(10)
	fcmpu 0,0,13
	bc 4,2,.L115
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L113
.L115:
	lwz 9,84(31)
	lwz 0,3612(9)
	cmpwi 0,0,0
	bc 12,2,.L117
	stw 8,3612(9)
	b .L113
.L117:
	li 0,1
	mr 3,31
	stw 0,3612(9)
	lwz 4,816(31)
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L113
.L114:
	lwz 9,84(31)
	li 8,0
	stw 8,3616(9)
	lwz 11,84(31)
	stw 8,3612(11)
	lwz 10,84(31)
	lwz 0,3620(10)
	cmpwi 0,0,0
	bc 12,2,.L119
	lis 9,game+1024@ha
	lwz 11,3576(10)
	lwz 0,game+1024@l(9)
	cmpw 0,11,0
	bc 4,2,.L119
	stw 8,3620(10)
	b .L113
.L119:
	lwz 11,84(31)
	li 0,1
	li 10,0
	mr 3,31
	stw 0,3620(11)
	lwz 9,84(31)
	stw 10,3580(9)
	bl HelpComputer
.L113:
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
	.string	"cells"
	.align 2
.LC26:
	.string	"misc/power2.wav"
	.align 2
.LC27:
	.string	"i_powershield"
	.align 2
.LC28:
	.string	"p_quad"
	.align 2
.LC29:
	.string	"p_invulnerability"
	.align 2
.LC30:
	.string	"p_envirosuit"
	.align 2
.LC31:
	.string	"p_rebreather"
	.align 2
.LC32:
	.string	"i_help"
	.align 2
.LC33:
	.long 0x3f800000
	.align 2
.LC34:
	.long 0x0
	.align 3
.LC35:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC36:
	.long 0x41200000
	.align 2
.LC37:
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
	lhz 0,730(31)
	sth 0,122(11)
	lwz 9,84(31)
	lwz 11,3628(9)
	cmpwi 0,11,0
	bc 4,2,.L121
	sth 11,124(9)
	lwz 9,84(31)
	sth 11,126(9)
	b .L122
.L121:
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
	lwz 9,3628(11)
	slwi 9,9,2
	add 9,11,9
	lhz 0,750(9)
	sth 0,126(11)
.L122:
	mr 3,31
	bl PowerArmorType
	mr. 30,3
	bc 12,2,.L123
	lis 3,.LC25@ha
	lwz 29,84(31)
	la 3,.LC25@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 29,29,748
	mullw 3,3,0
	srawi 3,3,3
	slwi 3,3,2
	lwzx 28,29,3
	cmpwi 0,28,0
	bc 4,2,.L123
	lwz 0,268(31)
	lis 29,gi@ha
	lis 3,.LC26@ha
	la 29,gi@l(29)
	la 3,.LC26@l(3)
	rlwinm 0,0,0,20,18
	li 30,0
	stw 0,268(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC33@ha
	lwz 0,16(29)
	lis 11,.LC33@ha
	la 9,.LC33@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC33@l(11)
	li 4,3
	mtlr 0
	lis 9,.LC34@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC34@l(9)
	lfs 3,0(9)
	blrl
.L123:
	mr 3,31
	bl ArmorIndex
	cmpwi 0,30,0
	mr 29,3
	bc 12,2,.L125
	cmpwi 0,29,0
	bc 12,2,.L126
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L125
.L126:
	lis 9,gi+40@ha
	lis 3,.LC27@ha
	lwz 0,gi+40@l(9)
	la 3,.LC27@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,128(9)
	lwz 11,84(31)
	sth 28,130(11)
	b .L127
.L125:
	cmpwi 0,29,0
	bc 12,2,.L128
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
	lhz 0,750(9)
	sth 0,130(10)
	b .L127
.L128:
	lwz 9,84(31)
	sth 29,128(9)
	lwz 11,84(31)
	sth 29,130(11)
.L127:
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,3908(11)
	fcmpu 0,13,0
	bc 4,1,.L130
	li 0,0
	sth 0,134(11)
	lwz 9,84(31)
	sth 0,136(9)
.L130:
	lwz 0,level@l(27)
	lis 30,0x4330
	lis 11,.LC35@ha
	xoris 0,0,0x8000
	la 11,.LC35@l(11)
	stw 0,28(1)
	stw 30,24(1)
	lfd 31,0(11)
	lfd 0,24(1)
	lwz 11,84(31)
	fsub 0,0,31
	lfs 13,3876(11)
	frsp 12,0
	fcmpu 0,13,12
	bc 4,1,.L131
	lis 9,gi+40@ha
	lis 3,.LC28@ha
	lwz 0,gi+40@l(9)
	la 3,.LC28@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC36@ha
	la 11,.LC36@l(11)
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3876(10)
	b .L154
.L131:
	lfs 0,3880(11)
	fcmpu 0,0,12
	bc 4,1,.L133
	lis 9,gi+40@ha
	lis 3,.LC29@ha
	lwz 0,gi+40@l(9)
	la 3,.LC29@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC36@ha
	la 11,.LC36@l(11)
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3880(10)
	b .L154
.L133:
	lfs 0,3888(11)
	fcmpu 0,0,12
	bc 4,1,.L135
	lis 9,gi+40@ha
	lis 3,.LC30@ha
	lwz 0,gi+40@l(9)
	la 3,.LC30@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC36@ha
	la 11,.LC36@l(11)
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3888(10)
	b .L154
.L135:
	lfs 0,3884(11)
	fcmpu 0,0,12
	bc 4,1,.L137
	lis 9,gi+40@ha
	lis 3,.LC31@ha
	lwz 0,gi+40@l(9)
	la 3,.LC31@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC36@ha
	la 11,.LC36@l(11)
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3884(10)
.L154:
	fsub 13,13,31
	frsp 13,13
	fsubs 0,0,13
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,24(1)
	lwz 11,28(1)
	sth 11,140(10)
	b .L132
.L137:
	li 0,0
	sth 0,138(11)
	lwz 9,84(31)
	sth 0,140(9)
.L132:
	lwz 9,84(31)
	lwz 0,744(9)
	cmpwi 0,0,-1
	bc 4,2,.L139
	li 0,0
	sth 0,132(9)
	b .L140
.L139:
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
.L140:
	lwz 11,84(31)
	lis 9,deathmatch@ha
	li 10,0
	lwz 8,deathmatch@l(9)
	lhz 0,746(11)
	lis 9,.LC34@ha
	la 9,.LC34@l(9)
	sth 0,144(11)
	lfs 13,0(9)
	lwz 9,84(31)
	sth 10,146(9)
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L141
	lwz 11,84(31)
	lwz 0,732(11)
	cmpwi 0,0,0
	bc 4,1,.L143
	lis 9,level+200@ha
	lfs 0,level+200@l(9)
	fcmpu 0,0,13
	bc 4,2,.L143
	lwz 0,3612(11)
	cmpwi 0,0,0
	bc 4,2,.L143
	lwz 0,1864(11)
	cmpwi 0,0,0
	bc 4,2,.L143
	lwz 0,1868(11)
	cmpwi 0,0,0
	bc 12,2,.L146
.L143:
	lwz 9,84(31)
	b .L147
.L141:
	lwz 9,84(31)
	lwz 0,3612(9)
	cmpwi 0,0,0
	bc 4,2,.L147
	lwz 0,3620(9)
	cmpwi 0,0,0
	bc 12,2,.L146
.L147:
	lhz 0,146(9)
	ori 0,0,1
	sth 0,146(9)
.L146:
	lwz 9,84(31)
	lwz 0,3616(9)
	cmpwi 0,0,0
	bc 12,2,.L145
	lwz 0,732(9)
	cmpwi 0,0,0
	bc 4,1,.L145
	lhz 0,146(9)
	ori 0,0,2
	sth 0,146(9)
.L145:
	lwz 11,84(31)
	lhz 0,3562(11)
	sth 0,148(11)
	lwz 9,84(31)
	lwz 0,3580(9)
	cmpwi 0,0,0
	bc 12,2,.L149
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 11,0,8
	bc 12,2,.L149
	lis 9,gi+40@ha
	lis 3,.LC32@ha
	lwz 0,gi+40@l(9)
	la 3,.LC32@l(3)
	b .L155
.L149:
	lwz 9,84(31)
	lwz 0,716(9)
	mr 11,9
	cmpwi 0,0,2
	bc 12,2,.L152
	lis 9,.LC37@ha
	lfs 13,112(11)
	la 9,.LC37@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L151
.L152:
	lwz 10,1848(11)
	cmpwi 0,10,0
	bc 12,2,.L151
	lis 9,gi+40@ha
	lwz 3,36(10)
	lwz 0,gi+40@l(9)
.L155:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,142(9)
	b .L150
.L151:
	li 0,0
	sth 0,142(11)
.L150:
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
.LC38:
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
	lis 10,.LC38@ha
	mr 31,3
	la 10,.LC38@l(10)
	lwz 11,84(31)
	lis 9,deathmatch@ha
	lfs 13,0(10)
	li 8,0
	lwz 10,deathmatch@l(9)
	stw 8,3616(11)
	lwz 9,84(31)
	stw 8,3620(9)
	lfs 0,20(10)
	fcmpu 0,0,13
	bc 4,2,.L100
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L99
.L100:
	lwz 9,84(31)
	lwz 0,3612(9)
	cmpwi 0,0,0
	bc 12,2,.L101
	stw 8,3612(9)
	b .L99
.L101:
	li 0,1
	mr 3,31
	stw 0,3612(9)
	lwz 4,816(31)
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L99:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 Cmd_Score_f,.Lfe7-Cmd_Score_f
	.align 2
	.globl ClassHelpMenu
	.type	 ClassHelpMenu,@function
ClassHelpMenu:
	stwu 1,-1056(1)
	mflr 0
	stmw 28,1040(1)
	stw 0,1060(1)
	mr 29,3
	lis 5,.LC8@ha
	li 4,1024
	addi 3,1,8
	la 5,.LC8@l(5)
	crxor 6,6,6
	bl Com_sprintf
	lis 28,gi@ha
	li 3,4
	la 28,gi@l(28)
	lwz 9,100(28)
	mtlr 9
	blrl
	lwz 9,116(28)
	addi 3,1,8
	mtlr 9
	blrl
	lwz 0,92(28)
	mr 3,29
	li 4,1
	mtlr 0
	blrl
	lwz 0,1060(1)
	mtlr 0
	lmw 28,1040(1)
	la 1,1056(1)
	blr
.Lfe8:
	.size	 ClassHelpMenu,.Lfe8-ClassHelpMenu
	.align 2
	.globl DeathmatchScoreboard
	.type	 DeathmatchScoreboard,@function
DeathmatchScoreboard:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lwz 4,816(29)
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
.Lfe9:
	.size	 DeathmatchScoreboard,.Lfe9-DeathmatchScoreboard
	.section	".rodata"
	.align 2
.LC39:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Class_f
	.type	 Cmd_Class_f,@function
Cmd_Class_f:
	lis 10,.LC39@ha
	lwz 11,84(3)
	lis 9,deathmatch@ha
	la 10,.LC39@l(10)
	li 8,0
	lfs 13,0(10)
	lwz 10,deathmatch@l(9)
	stw 8,3616(11)
	lwz 9,84(3)
	stw 8,3620(9)
	lfs 0,20(10)
	fcmpu 0,0,13
	bc 4,2,.L104
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bclr 12,2
.L104:
	lwz 3,84(3)
	lwz 0,3612(3)
	cmpwi 0,0,0
	bc 12,2,.L105
	stw 8,3612(3)
	blr
.L105:
	li 0,1
	stw 0,3612(3)
	blr
.Lfe10:
	.size	 Cmd_Class_f,.Lfe10-Cmd_Class_f
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
