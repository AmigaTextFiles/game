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
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
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
	stw 0,3568(5)
.L7:
	lis 10,level@ha
	lis 9,.LC1@ha
	lwz 6,84(31)
	la 10,level@l(10)
	la 9,.LC1@l(9)
	lfs 0,212(10)
	li 0,4
	lis 4,.LC0@ha
	lfs 9,0(9)
	li 8,0
	la 4,.LC0@l(4)
	lfs 8,0(4)
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
	lwz 9,84(31)
	lwz 0,116(9)
	rlwinm 0,0,0,0,30
	stw 0,116(9)
	stfs 8,3788(5)
	stfs 8,3808(5)
	stfs 8,3792(5)
	stfs 8,3796(5)
	stfs 8,3800(5)
	stw 8,3804(5)
	lwz 0,968(31)
	stw 8,248(31)
	cmpwi 0,0,0
	stw 8,508(31)
	stw 8,44(31)
	stw 8,48(31)
	stw 8,40(31)
	stw 8,64(31)
	stw 8,76(31)
	bc 4,2,.L9
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,8
	bc 4,2,.L10
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,8
	bc 12,2,.L9
.L10:
	lis 9,niq_enable@ha
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,8
	bc 12,2,.L11
	mr 3,31
	li 4,0
	li 5,1
	bl niq_deathmatchscoreboardmessage
	b .L9
.L11:
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
	bc 4,2,.L13
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L15
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L15
	bl CTFCalcScores
.L15:
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
	bc 4,0,.L17
	lis 11,.LC7@ha
	lis 28,g_edicts@ha
	la 11,.LC7@l(11)
	lis 29,0x4330
	lfd 31,0(11)
	li 31,1332
.L19:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L18
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 12,1,.L18
	bl respawn
.L18:
	addi 30,30,1
	lwz 11,maxclients@l(26)
	xoris 0,30,0x8000
	addi 31,31,1332
	stw 0,12(1)
	stw 29,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L19
.L17:
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
	bc 12,2,.L23
	lis 11,.LC6@ha
	lis 9,coop@ha
	la 11,.LC6@l(11)
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L37
	lis 9,maxclients@ha
	li 30,0
	lwz 10,maxclients@l(9)
	lfs 0,20(10)
	fcmpu 0,13,0
	bc 4,0,.L37
	lis 9,g_edicts@ha
	lis 11,itemlist@ha
	lwz 4,g_edicts@l(9)
	la 11,itemlist@l(11)
	mr 5,10
	lis 9,.LC7@ha
	lis 31,0x4330
	la 9,.LC7@l(9)
	lfd 12,0(9)
.L28:
	mulli 9,30,1332
	addi 7,30,1
	addi 9,9,1332
	add 3,4,9
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L27
	li 0,256
	li 6,0
	mtctr 0
	li 8,0
	addi 10,11,56
.L53:
	lwz 0,0(10)
	addi 10,10,72
	andi. 9,0,16
	bc 12,2,.L32
	lwz 9,84(3)
	addi 9,9,740
	stwx 6,9,8
.L32:
	addi 8,8,4
	bdnz .L53
.L27:
	mr 30,7
	lfs 13,20(5)
	xoris 0,30,0x8000
	stw 0,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L28
	b .L37
.L23:
	lis 9,.LC6@ha
	lis 11,deathmatch@ha
	la 9,.LC6@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L37
	li 0,1
	stw 0,208(31)
	b .L13
.L37:
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
	bc 4,2,.L39
	lis 5,.LC4@ha
	li 3,0
	la 5,.LC4@l(5)
	li 4,280
	bl G_Find
	mr. 31,3
	bc 4,2,.L41
	lis 5,.LC5@ha
	li 3,0
	la 5,.LC5@l(5)
	li 4,280
	bl G_Find
	mr 31,3
	b .L41
.L39:
	bl rand
	rlwinm 30,3,0,30,31
	b .L42
.L44:
	mr 3,31
	li 4,280
	la 5,.LC3@l(29)
	bl G_Find
	mr. 31,3
	bc 4,2,.L42
	li 3,0
	li 4,280
	la 5,.LC3@l(29)
	bl G_Find
	mr 31,3
.L42:
	cmpwi 0,30,0
	addi 30,30,-1
	bc 4,2,.L44
.L41:
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
	bc 4,0,.L13
	lis 9,.LC7@ha
	lis 28,g_edicts@ha
	la 9,.LC7@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 31,1332
.L50:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L49
	bl MoveClientToIntermission
.L49:
	addi 30,30,1
	lwz 11,maxclients@l(26)
	xoris 0,30,0x8000
	addi 31,31,1332
	stw 0,12(1)
	stw 29,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L50
.L13:
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
.LC13:
	.string	"client %i %i %i %i %i %i "
	.align 2
.LC12:
	.long 0x46fffe00
	.align 2
.LC14:
	.long 0x0
	.align 3
.LC15:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC16:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC17:
	.long 0x3f800000
	.align 2
.LC18:
	.long 0x42a00000
	.align 2
.LC19:
	.long 0x41c80000
	.section	".text"
	.align 2
	.globl DeathmatchScoreboardMessage
	.type	 DeathmatchScoreboardMessage,@function
DeathmatchScoreboardMessage:
	stwu 1,-4592(1)
	mflr 0
	stfd 29,4568(1)
	stfd 30,4576(1)
	stfd 31,4584(1)
	stmw 16,4504(1)
	stw 0,4596(1)
	lis 9,ctf@ha
	lis 10,.LC14@ha
	lwz 11,ctf@l(9)
	la 10,.LC14@l(10)
	mr 20,3
	lfs 13,0(10)
	mr 19,4
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L55
	lis 9,niq_enable@ha
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L56
	lwz 9,84(20)
	lwz 0,1808(9)
	cmpwi 0,0,8
	bc 4,2,.L55
.L56:
	mr 3,20
	mr 4,19
	bl CTFScoreboardMessage
	b .L54
.L55:
	lis 9,game@ha
	li 26,0
	la 11,game@l(9)
	li 28,0
	lwz 0,1544(11)
	addi 22,1,1040
	lis 16,gi@ha
	cmpw 0,26,0
	bc 4,0,.L58
	lis 9,g_edicts@ha
	mr 27,11
	lwz 24,g_edicts@l(9)
	addi 25,1,3472
.L60:
	mulli 9,28,1332
	addi 29,28,1
	add 31,9,24
	lwz 0,1420(31)
	cmpwi 0,0,0
	bc 12,2,.L59
	lwz 0,1028(27)
	mulli 9,28,3968
	li 6,0
	addi 5,1,3472
	cmpw 0,6,26
	addi 4,1,2448
	add 9,9,0
	addi 30,26,1
	lfs 13,3512(9)
	bc 4,0,.L63
	lfs 0,0(25)
	fcmpu 0,13,0
	bc 12,1,.L63
	mr 9,5
.L64:
	addi 6,6,1
	cmpw 0,6,26
	bc 4,0,.L63
	lfsu 0,4(9)
	fcmpu 0,13,0
	bc 4,1,.L64
.L63:
	cmpw 0,26,6
	mr 8,26
	slwi 3,6,2
	bc 4,1,.L69
	slwi 9,26,2
	mr 7,4
	mr 11,9
	mr 10,5
	addi 9,9,-4
.L71:
	lwzx 0,9,7
	addi 8,8,-1
	cmpw 0,8,6
	stwx 0,11,7
	lfsx 0,9,10
	addi 9,9,-4
	stfsx 0,11,10
	addi 11,11,-4
	bc 12,1,.L71
.L69:
	stwx 28,4,3
	mr 26,30
	stfsx 13,5,3
.L59:
	lwz 0,1544(27)
	mr 28,29
	cmpw 0,28,0
	bc 12,0,.L60
.L58:
	li 0,0
	mr 3,22
	stb 0,1040(1)
	li 28,0
	bl strlen
	cmpwi 7,26,13
	mr 27,3
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 0,26,0
	rlwinm 9,9,0,28,29
	or 26,0,9
	cmpw 0,28,26
	bc 4,0,.L76
	lis 9,.LC12@ha
	lis 10,.LC16@ha
	lfs 29,.LC12@l(9)
	la 10,.LC16@l(10)
	lis 11,game@ha
	lis 9,.LC15@ha
	lfd 30,0(10)
	la 18,game@l(11)
	la 9,.LC15@l(9)
	lis 17,g_edicts@ha
	lfd 31,0(9)
	lis 21,0x4330
	addi 23,1,2448
.L78:
	addi 9,1,2448
	slwi 10,28,2
	lwz 8,1028(18)
	lwzx 0,9,10
	la 11,gi@l(16)
	lis 3,.LC8@ha
	lwz 10,40(11)
	la 3,.LC8@l(3)
	mulli 9,0,1332
	lwz 11,g_edicts@l(17)
	mtlr 10
	mulli 0,0,3968
	addi 9,9,1332
	add 31,11,9
	add 30,8,0
	blrl
	lis 9,0x2aaa
	srawi 11,28,31
	ori 9,9,43691
	cmpwi 7,28,6
	mulhw 9,28,9
	cmpw 6,31,20
	subf 9,11,9
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	mulli 9,9,6
	neg 0,0
	andi. 24,0,160
	subf 9,9,28
	slwi 9,9,5
	addi 25,9,32
	bc 4,26,.L81
	lis 9,.LC9@ha
	la 8,.LC9@l(9)
	b .L82
.L81:
	cmpw 0,31,19
	bc 4,2,.L83
	lis 9,.LC10@ha
	la 8,.LC10@l(9)
	b .L82
.L83:
	li 8,0
.L82:
	cmpwi 0,8,0
	bc 12,2,.L85
	lis 5,.LC11@ha
	addi 3,1,16
	la 5,.LC11@l(5)
	li 4,1024
	addi 6,24,32
	mr 7,25
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,16
	bl strlen
	add 29,27,3
	cmpwi 0,29,1024
	bc 12,1,.L76
	add 3,22,27
	addi 4,1,16
	bl strcpy
	mr 27,29
.L85:
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 12,2,.L87
	bl rand
	lwz 10,1068(31)
	rlwinm 3,3,0,17,31
	mr 9,11
	xoris 3,3,0x8000
	lwz 0,24(10)
	lis 10,.LC17@ha
	xoris 0,0,0x8000
	la 10,.LC17@l(10)
	stw 0,4500(1)
	stw 21,4496(1)
	lfd 12,4496(1)
	stw 3,4500(1)
	stw 21,4496(1)
	lfd 0,4496(1)
	fsub 12,12,31
	lfs 13,0(10)
	lis 10,.LC18@ha
	fsub 0,0,31
	la 10,.LC18@l(10)
	lfs 10,0(10)
	frsp 12,12
	mr 10,11
	frsp 0,0
	fdivs 0,0,29
	fadds 0,0,0
	fsubs 0,0,13
	fmadds 0,0,10,12
	fmr 13,0
	fctiwz 11,13
	stfd 11,4496(1)
	lwz 10,4500(1)
	cmpwi 0,10,0
	stw 10,184(30)
	bc 4,0,.L87
	li 0,0
	stw 0,184(30)
.L87:
	lis 11,.LC14@ha
	lfs 13,3512(30)
	la 11,.LC14@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L89
	fmr 0,13
	fsub 0,0,30
	b .L93
.L89:
	fmr 0,13
	fadd 0,0,30
.L93:
	fctiwz 13,0
	stfd 13,4496(1)
	lwz 29,4500(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 10,3888(30)
	xoris 3,3,0x8000
	lis 10,.LC19@ha
	lwz 4,3460(30)
	stw 3,4500(1)
	la 10,.LC19@l(10)
	lis 8,level@ha
	stw 21,4496(1)
	lis 0,0x1b4e
	mr 9,29
	lfd 13,4496(1)
	ori 0,0,33205
	lis 5,.LC13@ha
	lfs 11,0(10)
	addi 3,1,16
	la 5,.LC13@l(5)
	mr 10,11
	lwz 29,184(30)
	mr 6,24
	fsub 13,13,31
	lwz 11,level@l(8)
	mr 7,25
	lwz 8,0(23)
	subf 11,4,11
	addi 23,23,4
	frsp 13,13
	mulhw 0,11,0
	li 4,1024
	srawi 11,11,31
	srawi 0,0,6
	fdivs 13,13,29
	subf 0,11,0
	stw 0,8(1)
	fmadds 13,13,11,10
	fmr 0,13
	fctiwz 12,0
	stfd 12,4496(1)
	lwz 10,4500(1)
	add 10,29,10
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,16
	bl strlen
	add 29,27,3
	cmpwi 0,29,1024
	bc 12,1,.L76
	add 3,22,27
	addi 4,1,16
	bl strcpy
	addi 28,28,1
	mr 27,29
	cmpw 0,28,26
	bc 12,0,.L78
.L76:
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,116(29)
	mr 3,22
	mtlr 0
	blrl
.L54:
	lwz 0,4596(1)
	mtlr 0
	lmw 16,4504(1)
	lfd 29,4568(1)
	lfd 30,4576(1)
	lfd 31,4584(1)
	la 1,4592(1)
	blr
.Lfe3:
	.size	 DeathmatchScoreboardMessage,.Lfe3-DeathmatchScoreboardMessage
	.section	".rodata"
	.align 2
.LC20:
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
	stw 30,3580(9)
	lwz 11,84(31)
	stw 30,3584(11)
	lwz 9,84(31)
	lwz 0,3576(9)
	cmpwi 0,0,0
	bc 12,2,.L98
	bl PMenu_Close
.L98:
	lis 11,.LC20@ha
	lis 9,deathmatch@ha
	la 11,.LC20@l(11)
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
	lwz 0,3568(10)
	cmpwi 0,0,0
	bc 12,2,.L100
	lis 9,niq_enable@ha
	stw 30,3568(10)
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L97
	mr 3,31
	bl niq_updatescreen
	b .L97
.L100:
	lis 9,niq_enable@ha
	li 0,1
	lwz 11,niq_enable@l(9)
	stw 0,3568(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L102
	lwz 4,540(31)
	mr 3,31
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L104
.L102:
	mr 3,31
	li 4,0
	li 5,1
	bl niq_deathmatchscoreboardmessage
.L104:
	lis 9,.LC20@ha
	lis 11,ctf@ha
	la 9,.LC20@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L97
	mr 3,31
	bl niq_updatescreen
.L97:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 Cmd_Score_f,.Lfe4-Cmd_Score_f
	.section	".rodata"
	.align 2
.LC21:
	.string	"easy"
	.align 2
.LC22:
	.string	"medium"
	.align 2
.LC23:
	.string	"hard"
	.align 2
.LC24:
	.string	"hard+"
	.align 2
.LC25:
	.string	"xv 32 yv 8 picn help xv 202 yv 12 string2 \"%s\" xv 0 yv 24 cstring2 \"%s\" xv 0 yv 54 cstring2 \"%s\" xv 0 yv 110 cstring2 \"%s\" xv 50 yv 164 string2 \" kills     goals    secrets\" xv 50 yv 172 string2 \"%3i/%3i     %i/%i       %i/%i\" "
	.align 2
.LC26:
	.long 0x0
	.align 2
.LC27:
	.long 0x3f800000
	.align 2
.LC28:
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
	lis 11,.LC26@ha
	lis 9,skill@ha
	la 11,.LC26@l(11)
	mr 31,3
	lfs 0,0(11)
	lwz 11,skill@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 4,2,.L107
	lis 9,.LC21@ha
	la 6,.LC21@l(9)
	b .L108
.L107:
	lis 9,.LC27@ha
	la 9,.LC27@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L109
	lis 9,.LC22@ha
	la 6,.LC22@l(9)
	b .L108
.L109:
	lis 11,.LC28@ha
	la 11,.LC28@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L111
	lis 9,.LC23@ha
	la 6,.LC23@l(9)
	b .L108
.L111:
	lis 9,.LC24@ha
	la 6,.LC24@l(9)
.L108:
	lis 11,level@ha
	lis 8,game@ha
	la 11,level@l(11)
	la 8,game@l(8)
	lwz 0,272(11)
	lis 5,.LC25@ha
	addi 9,8,512
	lwz 29,268(11)
	li 4,1024
	addi 3,1,32
	lwz 26,284(11)
	addi 7,11,8
	la 5,.LC25@l(5)
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
.LC29:
	.string	"cells"
	.align 2
.LC30:
	.string	"misc/power2.wav"
	.align 2
.LC31:
	.string	"i_powershield"
	.align 2
.LC32:
	.string	"p_quad"
	.align 2
.LC33:
	.string	"p_invulnerability"
	.align 2
.LC34:
	.string	"p_envirosuit"
	.align 2
.LC35:
	.string	"p_rebreather"
	.align 2
.LC36:
	.string	"i_help"
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
	lis 11,.LC37@ha
	lis 9,niq_enable@ha
	la 11,.LC37@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L117
	bl niq_setstats
	b .L118
.L117:
	lis 9,level+266@ha
	lwz 11,84(31)
	lis 27,level@ha
	lhz 0,level+266@l(9)
	sth 0,120(11)
	lwz 9,84(31)
	lhz 0,482(31)
	sth 0,122(9)
	lwz 9,84(31)
	lwz 11,3592(9)
	cmpwi 0,11,0
	bc 4,2,.L119
	sth 11,124(9)
	lwz 9,84(31)
	sth 11,126(9)
	b .L120
.L119:
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
	lwz 9,3592(11)
	slwi 9,9,2
	add 9,11,9
	lhz 0,742(9)
	sth 0,126(11)
.L120:
	mr 3,31
	bl PowerArmorType
	mr. 30,3
	bc 12,2,.L121
	lis 3,.LC29@ha
	lwz 29,84(31)
	la 3,.LC29@l(3)
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
	lwzx 28,29,3
	cmpwi 0,28,0
	bc 4,2,.L121
	lwz 0,264(31)
	lis 29,gi@ha
	lis 3,.LC30@ha
	la 29,gi@l(29)
	la 3,.LC30@l(3)
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
.L121:
	mr 3,31
	bl ArmorIndex
	cmpwi 0,30,0
	mr 29,3
	bc 12,2,.L123
	cmpwi 0,29,0
	bc 12,2,.L124
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L123
.L124:
	lis 9,gi+40@ha
	lis 3,.LC31@ha
	lwz 0,gi+40@l(9)
	la 3,.LC31@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,128(9)
	lwz 11,84(31)
	sth 28,130(11)
	b .L125
.L123:
	cmpwi 0,29,0
	bc 12,2,.L126
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
	b .L125
.L126:
	lwz 9,84(31)
	sth 29,128(9)
	lwz 11,84(31)
	sth 29,130(11)
.L125:
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,3820(11)
	fcmpu 0,13,0
	bc 4,1,.L128
	li 0,0
	sth 0,134(11)
	lwz 9,84(31)
	sth 0,136(9)
.L128:
	lwz 0,level@l(27)
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
	lfs 13,3788(11)
	frsp 12,0
	fcmpu 0,13,12
	bc 4,1,.L129
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
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3788(10)
	b .L155
.L129:
	lfs 0,3792(11)
	fcmpu 0,0,12
	bc 4,1,.L131
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
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3792(10)
	b .L155
.L131:
	lfs 0,3800(11)
	fcmpu 0,0,12
	bc 4,1,.L133
	lis 9,gi+40@ha
	lis 3,.LC34@ha
	lwz 0,gi+40@l(9)
	la 3,.LC34@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC40@ha
	la 11,.LC40@l(11)
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3800(10)
	b .L155
.L133:
	lfs 0,3796(11)
	fcmpu 0,0,12
	bc 4,1,.L135
	lis 9,gi+40@ha
	lis 3,.LC35@ha
	lwz 0,gi+40@l(9)
	la 3,.LC35@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC40@ha
	la 11,.LC40@l(11)
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3796(10)
.L155:
	fsub 13,13,31
	frsp 13,13
	fsubs 0,0,13
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,24(1)
	lwz 11,28(1)
	sth 11,140(10)
	b .L130
.L135:
	li 0,0
	sth 0,138(11)
	lwz 9,84(31)
	sth 0,140(9)
.L130:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L137
	li 0,0
	sth 0,132(9)
	b .L138
.L137:
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
.L138:
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
	bc 12,2,.L139
	lwz 11,84(31)
	lwz 0,724(11)
	cmpwi 0,0,0
	bc 4,1,.L141
	lis 9,level+200@ha
	lfs 0,level+200@l(9)
	fcmpu 0,0,13
	bc 4,2,.L141
	lwz 0,3568(11)
	cmpwi 0,0,0
	bc 4,2,.L141
	lwz 0,3536(11)
	cmpwi 0,0,0
	bc 12,2,.L144
.L141:
	lwz 9,84(31)
	b .L145
.L139:
	lwz 9,84(31)
	lwz 0,3568(9)
	cmpwi 0,0,0
	bc 4,2,.L145
	lwz 0,3584(9)
	cmpwi 0,0,0
	bc 12,2,.L144
.L145:
	lhz 0,146(9)
	ori 0,0,1
	sth 0,146(9)
.L144:
	lwz 9,84(31)
	lwz 0,3580(9)
	cmpwi 0,0,0
	bc 12,2,.L143
	lwz 0,724(9)
	cmpwi 0,0,0
	bc 4,1,.L143
	lhz 0,146(9)
	ori 0,0,2
	sth 0,146(9)
.L143:
	lwz 10,84(31)
	lfs 0,3512(10)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	sth 11,148(10)
	lwz 9,84(31)
	lwz 0,3508(9)
	cmpwi 0,0,0
	bc 12,2,.L147
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 11,0,8
	bc 12,2,.L147
	lis 9,gi+40@ha
	lis 3,.LC36@ha
	lwz 0,gi+40@l(9)
	la 3,.LC36@l(3)
	b .L156
.L147:
	lwz 9,84(31)
	lwz 0,716(9)
	mr 11,9
	cmpwi 0,0,2
	bc 12,2,.L150
	lis 9,.LC41@ha
	lfs 13,112(11)
	la 9,.LC41@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L149
.L150:
	lwz 10,1788(11)
	cmpwi 0,10,0
	bc 12,2,.L149
	lis 9,gi+40@ha
	lwz 3,36(10)
	lwz 0,gi+40@l(9)
.L156:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,142(9)
	b .L148
.L149:
	li 0,0
	sth 0,142(11)
.L148:
	lis 9,.LC37@ha
	lis 11,ctf@ha
	la 9,.LC37@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L152
	lwz 9,84(31)
	li 0,255
	sth 0,174(9)
	lwz 9,84(31)
	lwz 0,3488(9)
	cmpwi 0,0,0
	bc 12,2,.L118
	lwz 0,3584(9)
	cmpwi 0,0,0
	bc 4,2,.L118
	lwz 0,3568(9)
	cmpwi 0,0,0
	bc 4,2,.L118
	lwz 0,3536(9)
	xori 9,0,9
	subfic 11,9,0
	adde 9,11,9
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 12,2,.L118
	mr 3,31
	bl CTFSetIDView
	b .L118
.L152:
	mr 3,31
	bl SetCTFStats
.L118:
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
.LC42:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Help_f
	.type	 Cmd_Help_f,@function
Cmd_Help_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC42@ha
	lis 9,deathmatch@ha
	la 11,.LC42@l(11)
	mr 8,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L114
	bl Cmd_Score_f
	b .L113
.L114:
	lwz 11,84(8)
	li 7,0
	stw 7,3580(11)
	lwz 9,84(8)
	stw 7,3568(9)
	lwz 11,84(8)
	stw 7,3536(11)
	lwz 10,84(8)
	lwz 0,3584(10)
	cmpwi 0,0,0
	bc 12,2,.L115
	lis 9,game+1024@ha
	lwz 11,3504(10)
	lwz 0,game+1024@l(9)
	cmpw 0,11,0
	bc 4,2,.L115
	stw 7,3584(10)
	b .L113
.L115:
	lwz 11,84(8)
	li 0,1
	li 10,0
	mr 3,8
	stw 0,3584(11)
	lwz 9,84(8)
	stw 10,3508(9)
	bl HelpComputer
.L113:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe7:
	.size	 Cmd_Help_f,.Lfe7-Cmd_Help_f
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.comm	last_trail_time,4,4
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
	.section	".rodata"
	.align 2
.LC43:
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
	lis 11,.LC43@ha
	lis 9,niq_enable@ha
	la 11,.LC43@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L95
	lwz 4,540(31)
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L96
.L95:
	mr 3,31
	li 4,0
	li 5,1
	bl niq_deathmatchscoreboardmessage
.L96:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 DeathmatchScoreboard,.Lfe8-DeathmatchScoreboard
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
