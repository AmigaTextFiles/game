	.file	"p_hud.c"
gcc2_compiled.:
	.section	".data"
	.align 2
	.type	 VEC_ORIGIN,@object
	.size	 VEC_ORIGIN,12
VEC_ORIGIN:
	.long 0x0
	.long 0x0
	.long 0x0
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
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stw 31,36(1)
	stw 0,52(1)
	lis 9,deathmatch@ha
	lis 4,.LC0@ha
	lwz 11,deathmatch@l(9)
	la 4,.LC0@l(4)
	mr 31,3
	lfs 13,0(4)
	lfs 0,20(11)
	lwz 5,84(31)
	fcmpu 0,0,13
	bc 4,2,.L8
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L7
.L8:
	li 0,1
	stw 0,3552(5)
.L7:
	lis 11,level@ha
	lis 9,.LC1@ha
	lwz 6,84(31)
	la 11,level@l(11)
	la 9,.LC1@l(9)
	lfs 0,212(11)
	li 0,4
	lis 4,.LC0@ha
	lfs 9,0(9)
	li 10,0
	la 4,.LC0@l(4)
	lfs 31,0(4)
	mr 3,31
	stfs 0,4(31)
	mr 8,9
	mr 7,9
	lfs 0,216(11)
	stfs 0,8(31)
	lfs 13,220(11)
	stfs 13,12(31)
	lfs 0,212(11)
	fmuls 0,0,9
	fctiwz 12,0
	stfd 12,24(1)
	lwz 9,28(1)
	sth 9,4(6)
	lfs 0,216(11)
	lwz 9,84(31)
	fmuls 0,0,9
	fctiwz 11,0
	stfd 11,24(1)
	lwz 8,28(1)
	sth 8,6(9)
	lfs 0,220(11)
	lwz 9,84(31)
	fmuls 0,0,9
	fctiwz 10,0
	stfd 10,24(1)
	lwz 7,28(1)
	sth 7,8(9)
	lfs 0,224(11)
	lwz 9,84(31)
	stfs 0,28(9)
	lfs 13,228(11)
	lwz 9,84(31)
	stfs 13,32(9)
	lfs 0,232(11)
	lwz 9,84(31)
	stfs 0,36(9)
	lwz 11,84(31)
	stw 0,0(11)
	lwz 9,84(31)
	stw 10,88(9)
	lwz 11,84(31)
	stfs 31,108(11)
	lwz 9,84(31)
	lwz 0,116(9)
	rlwinm 0,0,0,0,30
	stw 0,116(9)
	stfs 31,3772(5)
	stfs 31,3792(5)
	stfs 31,3776(5)
	stfs 31,3780(5)
	stfs 31,3784(5)
	stw 10,3788(5)
	stw 10,248(31)
	stw 10,508(31)
	stw 10,44(31)
	stw 10,48(31)
	stw 10,40(31)
	stw 10,64(31)
	stw 10,76(31)
	bl K2_InitClientVars
	mr 3,31
	bl K2_ResetClientKeyVars
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L9
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
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L9:
	lwz 0,52(1)
	mtlr 0
	lwz 31,36(1)
	lfd 31,40(1)
	la 1,48(1)
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
	li 31,1352
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
	addi 31,31,1352
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
	mulli 9,30,1352
	addi 7,30,1
	addi 9,9,1352
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
	bc 4,0,.L46
	lis 9,.LC7@ha
	lis 28,g_edicts@ha
	la 9,.LC7@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 31,1352
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
	addi 31,31,1352
	stw 0,12(1)
	stw 29,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L48
.L46:
	lis 9,nextleveldelay@ha
	lis 11,level+4@ha
	lwz 10,nextleveldelay@l(9)
	lis 8,nextlevelstart@ha
	lfs 0,level+4@l(11)
	lfs 13,20(10)
	fadds 0,0,13
	stfs 0,nextlevelstart@l(8)
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
	.string	"xv %i yv %i picn tag1 "
	.align 2
.LC9:
	.string	"xv %i yv %i string \"%s\" "
	.align 2
.LC10:
	.string	"xv %i yv %i string \"%i\" "
	.align 2
.LC11:
	.string	"xv %i yv %i string \"%3i %s\" "
	.align 2
.LC12:
	.string	"xv %i yv %i string2 \"%3i %s\" "
	.section	".text"
	.align 2
	.globl TeamplayScoreboardMessage
	.type	 TeamplayScoreboardMessage,@function
TeamplayScoreboardMessage:
	stwu 1,-5072(1)
	mflr 0
	stmw 14,5000(1)
	stw 0,5076(1)
	addi 29,1,4744
	mr 14,3
	mr 3,29
	li 4,0
	li 5,256
	li 15,0
	crxor 6,6,6
	bl memset
	li 27,0
	lis 9,bot_teams@ha
	addi 18,1,1032
	la 9,bot_teams@l(9)
	lwzx 0,9,15
	cmpwi 0,0,0
	bc 12,2,.L54
	mr 31,9
	mr 26,29
	li 28,1
	mr 4,31
	addi 5,1,4488
	lis 30,bot_teams@ha
.L57:
	lwz 9,0(4)
	lwz 0,140(9)
	cmpwi 0,0,0
	bc 12,2,.L55
	li 3,0
	lis 10,0xfff0
	lwzx 0,31,3
	ori 10,10,48577
	li 7,-1
	cmpwi 0,0,0
	bc 12,2,.L60
	mr 6,29
	la 8,bot_teams@l(30)
	li 11,0
.L63:
	lwzx 0,11,6
	cmpwi 0,0,0
	bc 4,2,.L61
	lwzx 9,11,8
	lwz 0,140(9)
	cmpwi 0,0,0
	bc 12,2,.L61
	lwz 0,144(9)
	cmpw 0,0,10
	bc 4,1,.L61
	mr 10,0
	mr 7,3
.L61:
	addi 3,3,1
	addi 11,11,4
	cmpwi 0,3,63
	bc 12,1,.L60
	lwzx 0,11,8
	cmpwi 0,0,0
	bc 4,2,.L63
.L60:
	cmpwi 0,7,-1
	bc 4,1,.L54
	slwi 0,7,2
	addi 15,15,1
	lwzx 9,31,0
	stwx 28,26,0
	stw 9,0(5)
	addi 5,5,4
.L55:
	addi 27,27,1
	addi 4,4,4
	cmpwi 0,27,63
	bc 12,1,.L54
	lwz 0,0(4)
	cmpwi 0,0,0
	bc 4,2,.L57
.L54:
	li 0,0
	mr 3,18
	stb 0,1032(1)
	li 16,0
	bl strlen
	cmpw 0,16,15
	mr 28,3
	bc 4,0,.L72
	addi 19,1,4488
.L75:
	lis 9,game@ha
	li 26,0
	mulli 17,16,48
	la 9,game@l(9)
	li 27,0
	lwz 0,1544(9)
	slwi 25,16,2
	cmpw 0,26,0
	bc 4,0,.L77
	lis 9,g_edicts@ha
	lis 11,game@ha
	lwz 20,g_edicts@l(9)
	la 24,game@l(11)
	mr 21,25
	mr 22,19
	addi 23,1,3464
.L79:
	mulli 9,27,1352
	addi 31,27,1
	addi 9,9,1352
	add 10,20,9
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L78
	lwz 0,1028(24)
	mulli 9,27,4088
	add 8,9,0
	lwz 11,3508(8)
	cmpwi 0,11,0
	bc 4,2,.L78
	lwz 9,84(10)
	lwzx 11,22,21
	lwz 0,3912(9)
	cmpw 0,0,11
	bc 4,2,.L78
	li 3,0
	lwz 7,3464(8)
	addi 4,1,3464
	cmpw 0,3,26
	addi 12,1,2440
	addi 30,26,1
	bc 4,0,.L84
	lwz 0,0(23)
	cmpw 0,7,0
	bc 12,1,.L84
	mr 9,4
.L85:
	addi 3,3,1
	cmpw 0,3,26
	bc 4,0,.L84
	lwzu 0,4(9)
	cmpw 0,7,0
	bc 4,1,.L85
.L84:
	cmpw 0,26,3
	mr 6,26
	slwi 29,3,2
	bc 4,1,.L90
	slwi 9,26,2
	mr 5,12
	mr 10,9
	mr 8,4
	addi 11,9,-4
.L92:
	lwzx 9,11,5
	addi 6,6,-1
	cmpw 0,6,3
	stwx 9,10,5
	lwzx 0,11,8
	addi 11,11,-4
	stwx 0,10,8
	addi 10,10,-4
	bc 12,1,.L92
.L90:
	stwx 27,12,29
	mr 26,30
	stwx 7,4,29
.L78:
	lwz 0,1544(24)
	mr 27,31
	cmpw 0,27,0
	bc 12,0,.L79
.L77:
	cmpwi 7,26,5
	lwz 11,84(14)
	mr 30,17
	lwzx 8,19,25
	lwz 10,3912(11)
	mfcr 9
	rlwinm 9,9,29,1
	neg 9,9
	cmpw 0,10,8
	nor 0,9,9
	and 9,26,9
	rlwinm 0,0,0,29,29
	or 26,9,0
	bc 4,2,.L96
	lis 5,.LC8@ha
	addi 3,1,8
	la 5,.LC8@l(5)
	li 4,1024
	li 6,32
	mr 7,30
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,8
	bl strlen
	add 29,28,3
	cmpwi 0,29,1024
	bc 12,1,.L72
	add 3,18,28
	addi 4,1,8
	bl strcpy
	mr 28,29
.L96:
	lwzx 9,19,25
	lis 5,.LC9@ha
	addi 3,1,8
	la 5,.LC9@l(5)
	li 4,1024
	lwz 8,0(9)
	li 6,70
	ori 7,30,6
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,8
	bl strlen
	add 29,28,3
	cmpwi 0,29,1024
	bc 12,1,.L72
	addi 4,1,8
	add 3,18,28
	bl strcpy
	mr 28,29
	lwzx 9,19,25
	lis 5,.LC10@ha
	addi 3,1,8
	la 5,.LC10@l(5)
	li 4,1024
	lwz 8,144(9)
	li 6,80
	addi 7,30,20
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,8
	bl strlen
	add 29,28,3
	cmpwi 0,29,1024
	bc 12,1,.L72
	add 3,18,28
	addi 4,1,8
	bl strcpy
	li 27,0
	mr 28,29
	cmpw 0,27,26
	addi 25,16,1
	bc 4,0,.L73
	mr 31,30
	lis 9,game@ha
	la 21,game@l(9)
	lis 22,g_edicts@ha
	lis 23,.LC11@ha
	addi 30,1,2440
	lis 24,.LC12@ha
.L103:
	lwz 0,0(30)
	lwz 10,g_edicts@l(22)
	addi 30,30,4
	mulli 9,0,1352
	lwz 11,1028(21)
	mulli 0,0,4088
	addi 9,9,1352
	add 10,10,9
	cmpw 0,14,10
	add 9,11,0
	bc 4,2,.L104
	lwz 8,3464(9)
	addi 3,1,8
	li 4,1024
	addi 9,9,700
	la 5,.LC11@l(23)
	li 6,160
	mr 7,31
	crxor 6,6,6
	bl Com_sprintf
	b .L105
.L104:
	lwz 8,3464(9)
	addi 3,1,8
	li 4,1024
	addi 9,9,700
	la 5,.LC12@l(24)
	li 6,160
	mr 7,31
	crxor 6,6,6
	bl Com_sprintf
.L105:
	addi 3,1,8
	bl strlen
	add 29,28,3
	cmpwi 0,29,1024
	bc 12,1,.L73
	add 3,18,28
	addi 4,1,8
	bl strcpy
	addi 27,27,1
	mr 28,29
	cmpw 0,27,26
	addi 31,31,10
	bc 12,0,.L103
.L73:
	cmpw 0,25,15
	mr 16,25
	bc 4,0,.L72
	cmpwi 0,25,3
	bc 4,1,.L75
.L72:
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,116(29)
	mr 3,18
	mtlr 0
	blrl
	lwz 0,5076(1)
	mtlr 0
	lmw 14,5000(1)
	la 1,5072(1)
	blr
.Lfe3:
	.size	 TeamplayScoreboardMessage,.Lfe3-TeamplayScoreboardMessage
	.section	".rodata"
	.align 2
.LC13:
	.string	""
	.globl memset
	.align 2
.LC14:
	.string	"i_fixme"
	.align 2
.LC15:
	.string	"tag1"
	.align 2
.LC16:
	.string	"tag2"
	.align 2
.LC17:
	.string	"xv %i yv %i picn %s "
	.align 2
.LC19:
	.string	"client %i %i %i %i %i %i "
	.align 2
.LC20:
	.string	"xv %i yv %i string2 \"Bonus\" "
	.align 2
.LC21:
	.string	"xv %i yv %i string2 %i "
	.align 2
.LC18:
	.long 0x46fffe00
	.align 2
.LC22:
	.long 0x0
	.align 3
.LC23:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC24:
	.long 0x3f800000
	.align 2
.LC25:
	.long 0x42a00000
	.align 2
.LC26:
	.long 0x41c80000
	.section	".text"
	.align 2
	.globl DeathmatchScoreboardMessage
	.type	 DeathmatchScoreboardMessage,@function
DeathmatchScoreboardMessage:
	stwu 1,-6000(1)
	mflr 0
	stfd 30,5984(1)
	stfd 31,5992(1)
	stmw 16,5920(1)
	stw 0,6004(1)
	lis 9,.LC13@ha
	mr 21,3
	lbz 0,.LC13@l(9)
	mr 19,4
	addi 3,1,2449
	li 4,0
	li 5,1399
	stb 0,2448(1)
	crxor 6,6,6
	bl memset
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	lfs 13,0(9)
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L110
	mr 3,21
	mr 4,19
	bl CTFScoreboardMessage
	b .L109
.L110:
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L111
	lwz 9,84(21)
	lwz 0,3912(9)
	cmpwi 0,0,0
	bc 12,2,.L111
	mr 3,21
	mr 4,19
	bl TeamplayScoreboardMessage
	b .L109
.L111:
	lis 9,game@ha
	li 24,0
	la 11,game@l(9)
	li 27,0
	lwz 0,1544(11)
	addi 23,1,1040
	lis 16,gi@ha
	cmpw 0,24,0
	bc 4,0,.L113
	lis 9,g_edicts@ha
	mr 25,11
	lwz 22,g_edicts@l(9)
	addi 31,1,4880
.L115:
	mulli 9,27,1352
	addi 26,27,1
	add 28,9,22
	lwz 0,1440(28)
	cmpwi 0,0,0
	bc 12,2,.L114
	lwz 0,1028(25)
	mulli 9,27,4088
	add 9,9,0
	lwz 11,3508(9)
	cmpwi 0,11,0
	bc 4,2,.L114
	li 5,0
	lwz 29,3464(9)
	addi 4,1,4880
	cmpw 0,5,24
	addi 3,1,3856
	addi 30,24,1
	bc 4,0,.L119
	lwz 0,0(31)
	cmpw 0,29,0
	bc 12,1,.L119
	mr 9,4
.L120:
	addi 5,5,1
	cmpw 0,5,24
	bc 4,0,.L119
	lwzu 0,4(9)
	cmpw 0,29,0
	bc 4,1,.L120
.L119:
	cmpw 0,24,5
	mr 7,24
	slwi 28,5,2
	bc 4,1,.L125
	slwi 9,24,2
	mr 6,3
	mr 10,9
	mr 8,4
	addi 11,9,-4
.L127:
	lwzx 9,11,6
	addi 7,7,-1
	cmpw 0,7,5
	stwx 9,10,6
	lwzx 0,11,8
	addi 11,11,-4
	stwx 0,10,8
	addi 10,10,-4
	bc 12,1,.L127
.L125:
	stwx 27,3,28
	mr 24,30
	stwx 29,4,28
.L114:
	lwz 0,1544(25)
	mr 27,26
	cmpw 0,27,0
	bc 12,0,.L115
.L113:
	li 0,0
	mr 3,23
	stb 0,1040(1)
	li 27,0
	bl strlen
	cmpwi 7,24,13
	mr 31,3
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 0,24,0
	rlwinm 9,9,0,28,29
	or 24,0,9
	cmpw 0,27,24
	bc 4,0,.L132
	lis 9,.LC18@ha
	lis 11,game@ha
	lfs 30,.LC18@l(9)
	la 18,game@l(11)
	lis 17,g_edicts@ha
	lis 9,.LC23@ha
	lis 20,0x4330
	la 9,.LC23@l(9)
	addi 22,1,3856
	lfd 31,0(9)
.L134:
	addi 9,1,3856
	slwi 10,27,2
	lwz 8,1028(18)
	lwzx 0,9,10
	la 11,gi@l(16)
	lis 3,.LC14@ha
	lwz 10,40(11)
	la 3,.LC14@l(3)
	mulli 9,0,1352
	lwz 11,g_edicts@l(17)
	mtlr 10
	mulli 0,0,4088
	addi 9,9,1352
	add 28,11,9
	add 30,8,0
	blrl
	lis 9,0x2aaa
	srawi 11,27,31
	ori 9,9,43691
	cmpwi 7,27,6
	mulhw 9,27,9
	cmpw 6,28,21
	subf 9,11,9
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	mulli 9,9,6
	neg 0,0
	andi. 25,0,160
	subf 9,9,27
	slwi 9,9,5
	addi 26,9,32
	bc 4,26,.L137
	lis 9,.LC15@ha
	la 8,.LC15@l(9)
	b .L138
.L137:
	cmpw 0,28,19
	bc 4,2,.L139
	lis 9,.LC16@ha
	la 8,.LC16@l(9)
	b .L138
.L139:
	li 8,0
.L138:
	cmpwi 0,8,0
	bc 12,2,.L141
	lis 5,.LC17@ha
	addi 3,1,16
	la 5,.LC17@l(5)
	li 4,1024
	addi 6,25,32
	mr 7,26
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,16
	bl strlen
	add 29,31,3
	cmpwi 0,29,1024
	bc 12,1,.L132
	add 3,23,31
	addi 4,1,16
	bl strcpy
	mr 31,29
.L141:
	lwz 0,968(28)
	cmpwi 0,0,0
	bc 12,2,.L143
	bl rand
	lwz 10,1068(28)
	rlwinm 3,3,0,17,31
	mr 9,11
	xoris 3,3,0x8000
	lwz 0,28(10)
	lis 10,.LC24@ha
	xoris 0,0,0x8000
	la 10,.LC24@l(10)
	stw 0,5916(1)
	stw 20,5912(1)
	lfd 12,5912(1)
	stw 3,5916(1)
	stw 20,5912(1)
	lfd 0,5912(1)
	fsub 12,12,31
	lfs 13,0(10)
	lis 10,.LC25@ha
	fsub 0,0,31
	la 10,.LC25@l(10)
	lfs 10,0(10)
	frsp 12,12
	mr 10,11
	frsp 0,0
	fdivs 0,0,30
	fadds 0,0,0
	fsubs 0,0,13
	fmadds 0,0,10,12
	fmr 13,0
	fctiwz 11,13
	stfd 11,5912(1)
	lwz 10,5916(1)
	cmpwi 0,10,0
	stw 10,184(30)
	bc 4,0,.L143
	li 0,0
	stw 0,184(30)
.L143:
	bl rand
	rlwinm 3,3,0,17,31
	lfs 10,3920(30)
	xoris 3,3,0x8000
	lis 10,.LC26@ha
	lwz 29,3460(30)
	stw 3,5916(1)
	la 10,.LC26@l(10)
	lis 8,level@ha
	stw 20,5912(1)
	lis 0,0x1b4e
	lis 5,.LC19@ha
	lfd 13,5912(1)
	ori 0,0,33205
	addi 3,1,16
	lfs 11,0(10)
	la 5,.LC19@l(5)
	li 4,1024
	lwz 11,level@l(8)
	mr 10,9
	mr 6,25
	fsub 13,13,31
	lwz 28,184(30)
	mr 7,26
	subf 11,29,11
	lwz 8,0(22)
	mulhw 0,11,0
	lwz 9,3464(30)
	addi 22,22,4
	frsp 13,13
	srawi 11,11,31
	srawi 0,0,6
	subf 0,11,0
	fdivs 13,13,30
	stw 0,8(1)
	fmadds 13,13,11,10
	fmr 0,13
	fctiwz 12,0
	stfd 12,5912(1)
	lwz 10,5916(1)
	add 10,28,10
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,16
	bl strlen
	add 29,31,3
	cmpwi 0,29,1024
	bc 12,1,.L132
	addi 4,1,16
	add 3,23,31
	bl strcpy
	mr 31,29
	addi 28,1,2448
	lis 5,.LC20@ha
	mr 3,28
	la 5,.LC20@l(5)
	li 4,1400
	addi 6,25,117
	ori 7,26,8
	crxor 6,6,6
	bl Com_sprintf
	mr 3,28
	bl strlen
	add 29,31,3
	cmpwi 0,29,1024
	bc 12,1,.L132
	add 3,23,31
	mr 4,28
	bl strcpy
	mr 31,29
	lwz 8,3516(30)
	lis 5,.LC21@ha
	addi 6,25,133
	la 5,.LC21@l(5)
	ori 7,26,15
	mr 3,28
	li 4,1400
	crxor 6,6,6
	bl Com_sprintf
	mr 3,28
	bl strlen
	add 29,31,3
	cmpwi 0,29,1024
	bc 12,1,.L132
	add 3,23,31
	mr 4,28
	bl strcpy
	addi 27,27,1
	mr 31,29
	cmpw 0,27,24
	bc 12,0,.L134
.L132:
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
.L109:
	lwz 0,6004(1)
	mtlr 0
	lmw 16,5920(1)
	lfd 30,5984(1)
	lfd 31,5992(1)
	la 1,6000(1)
	blr
.Lfe4:
	.size	 DeathmatchScoreboardMessage,.Lfe4-DeathmatchScoreboardMessage
	.section	".rodata"
	.align 2
.LC27:
	.string	"easy"
	.align 2
.LC28:
	.string	"medium"
	.align 2
.LC29:
	.string	"hard"
	.align 2
.LC30:
	.string	"hard+"
	.align 2
.LC31:
	.string	"xv 32 yv 8 picn help xv 202 yv 12 string2 \"%s\" xv 0 yv 24 cstring2 \"%s\" xv 0 yv 54 cstring2 \"%s\" xv 0 yv 110 cstring2 \"%s\" xv 50 yv 164 string2 \" kills     goals    secrets\" xv 50 yv 172 string2 \"%3i/%3i     %i/%i       %i/%i\" "
	.align 2
.LC32:
	.long 0x0
	.align 2
.LC33:
	.long 0x3f800000
	.align 2
.LC34:
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
	lis 11,.LC32@ha
	lis 9,skill@ha
	la 11,.LC32@l(11)
	mr 31,3
	lfs 0,0(11)
	lwz 11,skill@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 4,2,.L156
	lis 9,.LC27@ha
	la 6,.LC27@l(9)
	b .L157
.L156:
	lis 9,.LC33@ha
	la 9,.LC33@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L158
	lis 9,.LC28@ha
	la 6,.LC28@l(9)
	b .L157
.L158:
	lis 11,.LC34@ha
	la 11,.LC34@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L160
	lis 9,.LC29@ha
	la 6,.LC29@l(9)
	b .L157
.L160:
	lis 9,.LC30@ha
	la 6,.LC30@l(9)
.L157:
	lis 11,level@ha
	lis 8,game@ha
	la 11,level@l(11)
	la 8,game@l(8)
	lwz 0,272(11)
	lis 5,.LC31@ha
	addi 9,8,512
	lwz 29,268(11)
	li 4,1024
	addi 3,1,32
	lwz 26,284(11)
	addi 7,11,8
	la 5,.LC31@l(5)
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
.LC35:
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
	lis 9,.LC35@ha
	lis 29,deathmatch@ha
	la 9,.LC35@l(9)
	mr 31,3
	lfs 31,0(9)
	lwz 9,deathmatch@l(29)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L163
	lwz 11,84(31)
	li 30,0
	stw 30,3564(11)
	lwz 9,84(31)
	stw 30,3568(9)
	lwz 11,84(31)
	lwz 0,3560(11)
	cmpwi 0,0,0
	bc 12,2,.L164
	bl PMenu_Close
.L164:
	lwz 9,deathmatch@l(29)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 4,2,.L165
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L162
.L165:
	lwz 9,84(31)
	lwz 0,3552(9)
	cmpwi 0,0,0
	bc 12,2,.L167
	stw 30,3552(9)
	b .L162
.L167:
	li 0,1
	mr 3,31
	stw 0,3552(9)
	lwz 4,540(31)
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L162
.L163:
	lwz 9,84(31)
	li 8,0
	stw 8,3564(9)
	lwz 11,84(31)
	stw 8,3552(11)
	lwz 10,84(31)
	lwz 0,3568(10)
	cmpwi 0,0,0
	bc 12,2,.L169
	lis 9,game+1024@ha
	lwz 11,1804(10)
	lwz 0,game+1024@l(9)
	cmpw 0,11,0
	bc 4,2,.L169
	stw 8,3568(10)
	b .L162
.L169:
	lwz 11,84(31)
	li 0,1
	li 10,0
	mr 3,31
	stw 0,3568(11)
	lwz 9,84(31)
	stw 10,1808(9)
	bl HelpComputer
.L162:
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 Cmd_Help_f,.Lfe6-Cmd_Help_f
	.section	".rodata"
	.align 2
.LC36:
	.string	"cells"
	.align 2
.LC37:
	.string	"misc/power2.wav"
	.align 2
.LC38:
	.string	"i_powershield"
	.align 2
.LC39:
	.string	"p_quad"
	.align 2
.LC40:
	.string	"p_invulnerability"
	.align 2
.LC41:
	.string	"p_envirosuit"
	.align 2
.LC42:
	.string	"p_rebreather"
	.align 2
.LC43:
	.string	"i_help"
	.align 2
.LC44:
	.long 0x3f800000
	.align 2
.LC45:
	.long 0x0
	.align 3
.LC46:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC47:
	.long 0x41200000
	.align 2
.LC48:
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
	lhz 0,482(31)
	sth 0,122(11)
	lwz 9,84(31)
	lwz 11,3576(9)
	cmpwi 0,11,0
	bc 4,2,.L171
	sth 11,124(9)
	lwz 9,84(31)
	sth 11,126(9)
	b .L172
.L171:
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
	lwz 9,3576(11)
	slwi 9,9,2
	add 9,11,9
	lhz 0,742(9)
	sth 0,126(11)
.L172:
	mr 3,31
	bl PowerArmorType
	mr. 30,3
	bc 12,2,.L173
	lis 3,.LC36@ha
	lwz 29,84(31)
	la 3,.LC36@l(3)
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
	bc 4,2,.L173
	lwz 0,264(31)
	lis 29,gi@ha
	lis 3,.LC37@ha
	la 29,gi@l(29)
	la 3,.LC37@l(3)
	rlwinm 0,0,0,20,18
	li 30,0
	stw 0,264(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC44@ha
	lwz 0,16(29)
	lis 11,.LC44@ha
	la 9,.LC44@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC44@l(11)
	li 4,3
	mtlr 0
	lis 9,.LC45@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC45@l(9)
	lfs 3,0(9)
	blrl
.L173:
	mr 3,31
	bl ArmorIndex
	cmpwi 0,30,0
	mr 29,3
	bc 12,2,.L175
	cmpwi 0,29,0
	bc 12,2,.L176
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L175
.L176:
	lis 9,gi+40@ha
	lis 3,.LC38@ha
	lwz 0,gi+40@l(9)
	la 3,.LC38@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,128(9)
	lwz 11,84(31)
	sth 28,130(11)
	b .L177
.L175:
	cmpwi 0,29,0
	bc 12,2,.L178
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
	b .L177
.L178:
	lwz 9,84(31)
	sth 29,128(9)
	lwz 11,84(31)
	sth 29,130(11)
.L177:
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,3804(11)
	fcmpu 0,13,0
	bc 4,1,.L180
	li 0,0
	sth 0,134(11)
	lwz 9,84(31)
	sth 0,136(9)
.L180:
	lwz 0,level@l(27)
	lis 30,0x4330
	lis 11,.LC46@ha
	xoris 0,0,0x8000
	la 11,.LC46@l(11)
	stw 0,28(1)
	stw 30,24(1)
	lfd 31,0(11)
	lfd 0,24(1)
	lwz 11,84(31)
	fsub 0,0,31
	lfs 13,3772(11)
	frsp 12,0
	fcmpu 0,13,12
	bc 4,1,.L181
	lis 9,gi+40@ha
	lis 3,.LC39@ha
	lwz 0,gi+40@l(9)
	la 3,.LC39@l(3)
	li 29,1
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC47@ha
	la 11,.LC47@l(11)
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3772(10)
	b .L205
.L181:
	lfs 0,3776(11)
	fcmpu 0,0,12
	bc 4,1,.L183
	lis 9,gi+40@ha
	lis 3,.LC40@ha
	lwz 0,gi+40@l(9)
	la 3,.LC40@l(3)
	li 29,1
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC47@ha
	la 11,.LC47@l(11)
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3776(10)
	b .L205
.L183:
	lfs 0,3784(11)
	fcmpu 0,0,12
	bc 4,1,.L185
	lis 9,gi+40@ha
	lis 3,.LC41@ha
	lwz 0,gi+40@l(9)
	la 3,.LC41@l(3)
	li 29,1
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC47@ha
	la 11,.LC47@l(11)
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3784(10)
	b .L205
.L185:
	lfs 0,3780(11)
	fcmpu 0,0,12
	bc 4,1,.L187
	lis 9,gi+40@ha
	lis 3,.LC42@ha
	lwz 0,gi+40@l(9)
	la 3,.LC42@l(3)
	li 29,1
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC47@ha
	la 11,.LC47@l(11)
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3780(10)
.L205:
	fsub 13,13,31
	frsp 13,13
	fsubs 0,0,13
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,24(1)
	lwz 11,28(1)
	sth 11,140(10)
	b .L182
.L187:
	li 29,0
	sth 29,138(11)
	lwz 9,84(31)
	sth 29,140(9)
.L182:
	mr 4,29
	mr 3,31
	bl K2_SetClientStats
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L189
	li 0,0
	sth 0,132(9)
	b .L190
.L189:
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
.L190:
	lwz 11,84(31)
	lis 9,deathmatch@ha
	li 10,0
	lwz 8,deathmatch@l(9)
	lhz 0,738(11)
	lis 9,.LC45@ha
	la 9,.LC45@l(9)
	sth 0,144(11)
	lfs 13,0(9)
	lwz 9,84(31)
	sth 10,146(9)
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L191
	lwz 11,84(31)
	lwz 0,724(11)
	cmpwi 0,0,0
	bc 4,1,.L193
	lis 9,level+200@ha
	lfs 0,level+200@l(9)
	fcmpu 0,0,13
	bc 4,2,.L193
	lwz 0,3552(11)
	cmpwi 0,0,0
	bc 12,2,.L196
.L193:
	lwz 9,84(31)
	b .L197
.L191:
	lwz 9,84(31)
	lwz 0,3552(9)
	cmpwi 0,0,0
	bc 4,2,.L197
	lwz 0,3568(9)
	cmpwi 0,0,0
	bc 12,2,.L196
.L197:
	lhz 0,146(9)
	ori 0,0,1
	sth 0,146(9)
.L196:
	lwz 9,84(31)
	lwz 0,3564(9)
	cmpwi 0,0,0
	bc 12,2,.L195
	lwz 0,724(9)
	cmpwi 0,0,0
	bc 4,1,.L195
	lhz 0,146(9)
	ori 0,0,2
	sth 0,146(9)
.L195:
	lwz 11,84(31)
	lhz 0,3466(11)
	sth 0,148(11)
	lwz 9,84(31)
	lwz 0,1808(9)
	cmpwi 0,0,0
	bc 12,2,.L199
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 11,0,8
	bc 12,2,.L199
	lis 9,gi+40@ha
	lis 3,.LC43@ha
	lwz 0,gi+40@l(9)
	la 3,.LC43@l(3)
	b .L206
.L199:
	lwz 9,84(31)
	lwz 0,716(9)
	mr 11,9
	cmpwi 0,0,2
	bc 12,2,.L202
	lis 9,.LC48@ha
	lfs 13,112(11)
	la 9,.LC48@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L201
.L202:
	lwz 10,1788(11)
	cmpwi 0,10,0
	bc 12,2,.L201
	lis 9,gi+40@ha
	lwz 3,36(10)
	lwz 0,gi+40@l(9)
.L206:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,142(9)
	b .L200
.L201:
	li 0,0
	sth 0,142(11)
.L200:
	lis 9,.LC45@ha
	lis 11,ctf@ha
	la 9,.LC45@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L204
	mr 3,31
	bl SetCTFStats
.L204:
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe7:
	.size	 G_SetStats,.Lfe7-G_SetStats
	.section	".rodata"
	.align 2
.LC49:
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
	stw 30,3564(9)
	lwz 11,84(31)
	stw 30,3568(11)
	lwz 9,84(31)
	lwz 0,3560(9)
	cmpwi 0,0,0
	bc 12,2,.L151
	bl PMenu_Close
.L151:
	lis 11,.LC49@ha
	lis 9,deathmatch@ha
	la 11,.LC49@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L152
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L150
.L152:
	lwz 9,84(31)
	lwz 0,3552(9)
	cmpwi 0,0,0
	bc 12,2,.L153
	stw 30,3552(9)
	b .L150
.L153:
	li 0,1
	mr 3,31
	stw 0,3552(9)
	lwz 4,540(31)
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L150:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 Cmd_Score_f,.Lfe8-Cmd_Score_f
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.comm	last_trail_time,4,4
	.section	".rodata"
	.align 2
.LC50:
	.long 0x0
	.section	".text"
	.align 2
	.globl G_SetSpectatorStats
	.type	 G_SetSpectatorStats,@function
G_SetSpectatorStats:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr. 3,3
	bc 12,2,.L215
	lwz 30,968(3)
	cmpwi 0,30,0
	bc 4,2,.L215
	lwz 31,84(3)
	lwz 0,3972(31)
	cmpwi 0,0,0
	bc 4,2,.L218
	bl G_SetStats
.L218:
	lwz 9,724(31)
	li 0,1
	sth 0,154(31)
	cmpwi 0,9,0
	sth 30,146(31)
	bc 4,1,.L220
	lis 11,.LC50@ha
	lis 9,level+200@ha
	la 11,.LC50@l(11)
	lfs 0,level+200@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L220
	lwz 0,3552(31)
	cmpwi 0,0,0
	bc 12,2,.L219
.L220:
	lhz 0,146(31)
	ori 0,0,1
	sth 0,146(31)
.L219:
	lwz 0,3564(31)
	cmpwi 0,0,0
	bc 12,2,.L221
	lwz 0,724(31)
	cmpwi 0,0,0
	bc 4,1,.L221
	lhz 0,146(31)
	ori 0,0,2
	sth 0,146(31)
.L221:
	lwz 10,3972(31)
	cmpwi 0,10,0
	bc 12,2,.L222
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L222
	lis 11,g_edicts@ha
	lis 0,0xfb74
	lwz 9,g_edicts@l(11)
	ori 0,0,41881
	subf 9,9,10
	mullw 9,9,0
	srawi 9,9,3
	addi 9,9,1311
	sth 9,152(31)
	b .L215
.L222:
	li 0,0
	sth 0,152(31)
.L215:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe9:
	.size	 G_SetSpectatorStats,.Lfe9-G_SetSpectatorStats
	.align 2
	.globl G_CheckChaseStats
	.type	 G_CheckChaseStats,@function
G_CheckChaseStats:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,num_players@ha
	li 11,0
	lwz 0,num_players@l(9)
	mr 10,3
	lis 8,num_players@ha
	cmpw 0,11,0
	bc 4,0,.L209
	lis 9,players@ha
	la 31,players@l(9)
.L211:
	lwz 9,0(31)
	lwz 0,88(9)
	lwz 3,84(9)
	cmpwi 0,0,0
	bc 12,2,.L210
	lwz 0,3972(3)
	cmpw 0,0,10
	bc 4,2,.L210
	lwz 4,84(10)
	addi 3,3,120
	li 5,64
	addi 4,4,120
	crxor 6,6,6
	bl memcpy
	lwz 3,4(31)
	bl G_SetSpectatorStats
	b .L209
.L210:
	lwz 0,num_players@l(8)
	addi 11,11,1
	addi 31,31,4
	cmpw 0,11,0
	bc 12,0,.L211
.L209:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe10:
	.size	 G_CheckChaseStats,.Lfe10-G_CheckChaseStats
	.comm	bot_frametime,8,8
	.comm	max_bots,4,4
	.comm	last_bot_spawn,4,4
	.comm	bot_male_names_used,4,4
	.comm	bot_female_names_used,4,4
	.comm	bot_count,4,4
	.comm	bot_teams,256,4
	.comm	total_teams,4,4
	.comm	the_client,4,4
	.comm	num_players,4,4
	.comm	players,1024,4
	.comm	weapons_head,4,4
	.comm	health_head,4,4
	.comm	bonus_head,4,4
	.comm	ammo_head,4,4
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_bullets,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_supershotgun,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.comm	botinfo_list,4,4
	.comm	total_bots,4,4
	.comm	teambot_list,4,4
	.comm	paused,4,4
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
.Lfe11:
	.size	 DeathmatchScoreboard,.Lfe11-DeathmatchScoreboard
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
