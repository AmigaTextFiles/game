	.file	"p_nhscoreboard.c"
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
	.string	"xv 32 yv 16 string2 \"%-2.2s %-15.15s  %-5.5s  %-4.4s %-4.4s  %s\" "
	.align 2
.LC1:
	.string	"#"
	.align 2
.LC2:
	.string	"Player"
	.align 2
.LC3:
	.string	"Score"
	.align 2
.LC4:
	.string	"Ping"
	.align 2
.LC5:
	.string	"Time"
	.align 2
.LC6:
	.string	"Status"
	.align 2
.LC7:
	.string	"Overflow problem in NHScoreboardmessage\n"
	.align 2
.LC8:
	.string	"i_fixme"
	.align 2
.LC9:
	.string	"Cheating"
	.align 2
.LC10:
	.string	"Predator"
	.align 2
.LC11:
	.string	"Chasing..."
	.align 2
.LC12:
	.string	"Chasing #%d"
	.align 2
.LC13:
	.string	"Observing"
	.align 2
.LC14:
	.string	"(P)Marine"
	.align 2
.LC15:
	.string	"Marine"
	.align 2
.LC16:
	.string	"xv 32 yv %i string \"%2d %-15.15s  %4i %5i %4i   %s\" "
	.align 2
.LC17:
	.string	"xv 32 yv %i string2 \"%2d %-15.15s  %4i %5i %4i   %s\" "
	.section	".text"
	.align 2
	.globl NHScoreboardMessage
	.type	 NHScoreboardMessage,@function
NHScoreboardMessage:
	stwu 1,-4592(1)
	mflr 0
	mfcr 12
	stmw 17,4532(1)
	stw 0,4596(1)
	stw 12,4528(1)
	lis 9,game@ha
	li 27,0
	la 11,game@l(9)
	mr 26,3
	lwz 0,1544(11)
	li 30,0
	addi 21,1,1040
	lis 17,gi@ha
	cmpw 0,27,0
	bc 4,0,.L17
	lis 9,g_edicts@ha
	mr 25,11
	lwz 23,g_edicts@l(9)
	addi 24,1,3472
.L19:
	mulli 9,30,952
	addi 28,30,1
	add 29,9,23
	lwz 0,1040(29)
	cmpwi 0,0,0
	bc 12,2,.L18
	lwz 0,1028(25)
	mulli 9,30,3868
	li 5,0
	addi 4,1,3472
	cmpw 0,5,27
	addi 3,1,2448
	add 9,9,0
	addi 31,27,1
	lwz 29,3464(9)
	bc 4,0,.L22
	lwz 0,0(24)
	cmpw 0,29,0
	bc 12,1,.L22
	mr 9,4
.L23:
	addi 5,5,1
	cmpw 0,5,27
	bc 4,0,.L22
	lwzu 0,4(9)
	cmpw 0,29,0
	bc 4,1,.L23
.L22:
	cmpw 0,27,5
	mr 7,27
	slwi 12,5,2
	bc 4,1,.L28
	slwi 9,27,2
	mr 6,3
	mr 10,9
	mr 8,4
	addi 11,9,-4
.L30:
	lwzx 9,11,6
	addi 7,7,-1
	cmpw 0,7,5
	stwx 9,10,6
	lwzx 0,11,8
	addi 11,11,-4
	stwx 0,10,8
	addi 10,10,-4
	bc 12,1,.L30
.L28:
	stwx 30,3,12
	mr 27,31
	stwx 29,4,12
.L18:
	lwz 0,1544(25)
	mr 30,28
	cmpw 0,30,0
	bc 12,0,.L19
.L17:
	li 0,0
	mr 3,21
	stb 0,1040(1)
	bl strlen
	cmpwi 7,27,13
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	mr 25,3
	stw 9,8(1)
	lis 5,.LC0@ha
	lis 6,.LC1@ha
	mfcr 0
	rlwinm 0,0,29,1
	lis 7,.LC2@ha
	neg 0,0
	lis 8,.LC3@ha
	nor 11,0,0
	lis 9,.LC4@ha
	and 0,27,0
	rlwinm 11,11,0,28,29
	lis 10,.LC5@ha
	addi 3,1,16
	la 5,.LC0@l(5)
	or 27,0,11
	la 6,.LC1@l(6)
	la 7,.LC2@l(7)
	la 8,.LC3@l(8)
	la 9,.LC4@l(9)
	la 10,.LC5@l(10)
	li 4,1024
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,16
	bl strlen
	add 30,25,3
	cmpwi 0,30,1024
	bc 4,1,.L34
	lis 9,gi+4@ha
	lis 3,.LC7@ha
	lwz 0,gi+4@l(9)
	la 3,.LC7@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L35
.L34:
	add 3,21,25
	addi 4,1,16
	bl strcpy
	mr 25,30
.L35:
	li 30,0
	cmpw 0,30,27
	bc 4,0,.L37
	lis 9,game@ha
	lis 23,0x1b4e
	la 18,game@l(9)
	addi 22,1,2448
	lis 20,g_edicts@ha
	ori 23,23,33205
.L39:
	slwi 9,30,2
	la 11,gi@l(17)
	lwz 10,1028(18)
	lwzx 0,22,9
	lis 3,.LC8@ha
	lwz 8,40(11)
	la 3,.LC8@l(3)
	mulli 9,0,952
	lwz 11,g_edicts@l(20)
	mtlr 8
	mulli 0,0,3868
	addi 9,9,952
	add 31,10,0
	add 29,11,9
	blrl
	lwz 0,948(26)
	slwi 9,30,3
	addi 24,9,32
	cmpwi 0,0,0
	bc 12,2,.L40
	lis 5,.LC9@ha
	addi 3,1,4496
	la 5,.LC9@l(5)
	li 4,20
	crxor 6,6,6
	bl Com_sprintf
	addi 28,30,1
	cmpw 4,29,26
	b .L65
.L40:
	lwz 0,896(29)
	cmpwi 0,0,0
	bc 12,2,.L42
	lis 5,.LC10@ha
	addi 3,1,4496
	la 5,.LC10@l(5)
	li 4,20
	crxor 6,6,6
	bl Com_sprintf
	addi 28,30,1
	cmpw 4,29,26
	b .L65
.L42:
	lwz 0,932(29)
	cmpwi 0,0,0
	bc 12,2,.L44
	lwz 9,84(29)
	lwz 8,3812(9)
	cmpwi 0,8,0
	bc 12,2,.L45
	lwz 0,88(8)
	cmpwi 0,0,0
	bc 12,2,.L45
	li 10,0
	addi 28,30,1
	cmpw 0,10,27
	addi 30,1,4496
	cmpw 4,29,26
	lis 19,level@ha
	addi 29,31,700
	bc 4,0,.L51
	lwz 9,2448(1)
	lwz 0,g_edicts@l(20)
	mulli 9,9,952
	addi 9,9,952
	add 0,0,9
	cmpw 0,0,8
	bc 12,2,.L51
	lis 9,g_edicts@ha
	mr 7,22
	lwz 11,g_edicts@l(9)
.L49:
	addi 10,10,1
	cmpw 0,10,27
	bc 4,0,.L51
	lwzu 9,4(7)
	mulli 9,9,952
	addi 9,9,952
	add 0,11,9
	cmpw 0,0,8
	bc 4,2,.L49
.L51:
	xor 11,10,27
	addi 9,10,1
	srawi 10,11,31
	xor 0,10,11
	subf 0,0,10
	srawi 0,0,31
	and 9,0,9
	orc 6,9,0
	cmpwi 0,6,-1
	bc 4,2,.L55
	lis 5,.LC11@ha
	mr 3,30
	la 5,.LC11@l(5)
	li 4,20
	crxor 6,6,6
	bl Com_sprintf
	b .L41
.L55:
	lis 5,.LC12@ha
	mr 3,30
	la 5,.LC12@l(5)
	li 4,20
	crxor 6,6,6
	bl Com_sprintf
	b .L41
.L45:
	lis 5,.LC13@ha
	addi 3,1,4496
	la 5,.LC13@l(5)
	li 4,20
	crxor 6,6,6
	bl Com_sprintf
	addi 28,30,1
	cmpw 4,29,26
	b .L65
.L44:
	bl getPenalty
	lwz 0,904(29)
	cmpw 0,0,3
	bc 12,0,.L59
	lis 5,.LC14@ha
	addi 3,1,4496
	la 5,.LC14@l(5)
	li 4,20
	crxor 6,6,6
	bl Com_sprintf
	addi 28,30,1
	cmpw 4,29,26
	b .L65
.L59:
	lis 5,.LC15@ha
	addi 3,1,4496
	la 5,.LC15@l(5)
	li 4,20
	cmpw 4,29,26
	addi 28,30,1
	crxor 6,6,6
	bl Com_sprintf
.L65:
	addi 30,1,4496
	addi 29,31,700
	lis 19,level@ha
.L41:
	bc 4,18,.L61
	lwz 0,3460(31)
	lis 5,.LC16@ha
	mr 6,24
	lwz 11,level@l(19)
	la 5,.LC16@l(5)
	mr 8,29
	lwz 9,3464(31)
	addi 3,1,16
	li 4,1024
	subf 11,0,11
	lwz 10,184(31)
	mr 7,28
	mulhw 0,11,23
	stw 30,12(1)
	srawi 11,11,31
	srawi 0,0,6
	subf 0,11,0
	stw 0,8(1)
	crxor 6,6,6
	bl Com_sprintf
	b .L62
.L61:
	lwz 0,3460(31)
	lis 5,.LC17@ha
	mr 6,24
	lwz 11,level@l(19)
	la 5,.LC17@l(5)
	mr 8,29
	lwz 9,3464(31)
	addi 3,1,16
	li 4,1024
	subf 11,0,11
	lwz 10,184(31)
	mr 7,28
	mulhw 0,11,23
	stw 30,12(1)
	srawi 11,11,31
	srawi 0,0,6
	subf 0,11,0
	stw 0,8(1)
	crxor 6,6,6
	bl Com_sprintf
.L62:
	addi 3,1,16
	bl strlen
	add 29,25,3
	cmpwi 0,29,1024
	bc 12,1,.L37
	add 3,21,25
	addi 4,1,16
	bl strcpy
	mr 30,28
	mr 25,29
	cmpw 0,30,27
	bc 12,0,.L39
.L37:
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,116(29)
	mr 3,21
	mtlr 0
	blrl
	lwz 0,4596(1)
	lwz 12,4528(1)
	mtlr 0
	lmw 17,4532(1)
	mtcrf 8,12
	la 1,4592(1)
	blr
.Lfe1:
	.size	 NHScoreboardMessage,.Lfe1-NHScoreboardMessage
	.comm	showscores,4,4
	.comm	nextdynamicset,4,4
	.comm	predatorModel,32,4
	.comm	predatorSkin,64,4
	.comm	marineSkin,64,4
	.align 2
	.globl NHScoreboard
	.type	 NHScoreboard,@function
NHScoreboard:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lwz 4,540(29)
	bl NHScoreboardMessage
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
.Lfe2:
	.size	 NHScoreboard,.Lfe2-NHScoreboard
	.section	".rodata"
	.align 2
.LC18:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_NHScore_f
	.type	 Cmd_NHScore_f,@function
Cmd_NHScore_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 10,.LC18@ha
	mr 31,3
	la 10,.LC18@l(10)
	lwz 11,84(31)
	lis 9,deathmatch@ha
	lfs 13,0(10)
	li 30,0
	lwz 10,deathmatch@l(9)
	stw 30,3516(11)
	lwz 9,84(31)
	stw 30,3520(9)
	stw 30,924(31)
	lfs 0,20(10)
	fcmpu 0,0,13
	bc 4,2,.L68
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L67
.L68:
	lwz 9,84(31)
	lwz 0,3856(9)
	cmpwi 0,0,0
	bc 12,2,.L69
	mr 3,31
	bl PMenu_Close
.L69:
	lwz 9,84(31)
	lwz 0,3512(9)
	cmpwi 0,0,0
	bc 12,2,.L70
	stw 30,3512(9)
	b .L67
.L70:
	li 0,1
	mr 3,31
	stw 0,3512(9)
	lwz 4,540(31)
	bl NHScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L67:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 Cmd_NHScore_f,.Lfe3-Cmd_NHScore_f
	.comm	maplist_lastmap,64,4
	.comm	maplist2_lastmap,64,4
	.comm	maplist3_lastmap,64,4
	.comm	last_beat,4,4
	.align 2
	.globl findChasePlayerNumber
	.type	 findChasePlayerNumber,@function
findChasePlayerNumber:
	li 10,0
	cmpw 0,10,5
	bc 4,0,.L8
	lwz 9,0(4)
	lis 11,g_edicts@ha
	lwz 11,g_edicts@l(11)
	b .L73
.L9:
	addi 10,10,1
	cmpw 0,10,5
	bc 4,0,.L8
	lwzu 9,4(4)
.L73:
	mulli 9,9,952
	addi 9,9,952
	add 0,11,9
	cmpw 0,0,3
	bc 4,2,.L9
.L8:
	cmpw 0,10,5
	li 3,-1
	bclr 12,2
	addi 3,10,1
	blr
.Lfe4:
	.size	 findChasePlayerNumber,.Lfe4-findChasePlayerNumber
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
