	.file	"e_matrix.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 mpaTranslateRank,@object
	.size	 mpaTranslateRank,4
mpaTranslateRank:
	.long 0
	.section	".rodata"
	.align 2
.LC0:
	.string	"xv %d "
	.align 2
.LC1:
	.string	"yv %d string2 \"%s\" "
	.align 2
.LC2:
	.string	"Name Frags Ping Rank Eff FPM Skill"
	.align 2
.LC3:
	.string	"%-12.12s %3i %3i %3i %2i %2i %3i"
	.align 2
.LC4:
	.string	"yv %d string \"%s\" "
	.align 2
.LC5:
	.string	"%s,"
	.align 2
.LC6:
	.string	" %s,"
	.align 2
.LC7:
	.string	"yv %d string2 \"Kills v. %s etc.\" "
	.align 2
.LC8:
	.string	"%-8.8s "
	.align 2
.LC9:
	.string	"%2i"
	.section	".text"
	.align 2
	.globl DrawMatrix
	.type	 DrawMatrix,@function
DrawMatrix:
	stwu 1,-416(1)
	mflr 0
	mfcr 12
	stmw 17,356(1)
	stw 0,420(1)
	stw 12,352(1)
	mr 27,5
	mr 20,3
	andi. 0,27,1
	mr 21,4
	bc 12,2,.L9
	li 19,9
	li 10,4
	b .L10
.L9:
	li 19,13
	li 10,6
.L10:
	lis 9,gcPlayers@ha
	lis 17,gcPlayers@ha
	lbz 8,gcPlayers@l(9)
	rlwinm 11,8,0,0xff
	cmplw 0,19,11
	bc 12,0,.L11
	mr 19,11
	li 18,0
	b .L12
.L11:
	lwz 9,84(20)
	lbz 9,3580(9)
	rlwinm 0,9,0,0xff
	cmplw 0,0,10
	bc 12,1,.L13
	li 18,0
	b .L12
.L13:
	add 0,0,10
	cmpw 0,0,11
	bc 4,1,.L15
	subf 0,19,8
	b .L56
.L15:
	subf 0,10,9
.L56:
	rlwinm 18,0,0,0xff
.L12:
	lis 3,.LC0@ha
	li 4,3
	la 3,.LC0@l(3)
	li 24,10
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,21
	bl strcpy
	andi. 0,27,1
	bc 12,2,.L17
	lis 3,.LC1@ha
	lis 5,.LC2@ha
	li 4,10
	la 5,.LC2@l(5)
	la 3,.LC1@l(3)
	li 24,17
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,21
	bl strcat
.L17:
	mr 31,18
	add 0,31,19
	cmpw 0,31,0
	bc 4,0,.L19
	lis 9,game@ha
	lis 22,mpaTranslateRank@ha
	la 23,game@l(9)
	addi 30,1,280
	lis 25,level@ha
	lis 26,.LC3@ha
.L21:
	lwz 9,mpaTranslateRank@l(22)
	li 29,0
	li 12,0
	lbz 11,gcPlayers@l(17)
	li 28,0
	lbzx 0,9,31
	lwz 9,1028(23)
	cmplw 0,29,11
	mulli 0,0,4596
	add 3,9,0
	bc 4,0,.L23
	lis 9,mpaTranslateRank@ha
	lis 10,gcPlayers@ha
	lwz 6,3584(3)
	lis 11,game@ha
	lwz 7,mpaTranslateRank@l(9)
	lbz 8,gcPlayers@l(10)
	la 5,game@l(11)
.L25:
	lbzx 10,6,29
	cmpwi 0,10,0
	bc 12,2,.L24
	lbzx 9,7,29
	addi 0,12,1
	lwz 11,1028(5)
	rlwinm 12,0,0,0xff
	mulli 9,9,4596
	add 9,9,11
	lwz 0,3432(9)
	mullw 0,10,0
	add 28,28,0
.L24:
	addi 0,29,1
	rlwinm 29,0,0,0xff
	cmplw 0,29,8
	bc 12,0,.L25
.L23:
	lwz 0,184(3)
	lis 9,0x6666
	addi 4,3,700
	lwz 5,3432(3)
	ori 9,9,26215
	li 8,0
	lbz 11,3581(3)
	mulhw 9,0,9
	srawi 0,0,31
	mulli 10,5,100
	subf 7,11,5
	srawi 9,9,2
	add. 11,5,11
	subf 9,0,9
	mulli 6,9,10
	bc 12,2,.L29
	divw 8,10,11
.L29:
	lwz 11,3428(3)
	lis 9,0x1b4e
	lwz 0,level@l(25)
	ori 9,9,33205
	mr 3,5
	subf 0,11,0
	mulhw 9,0,9
	srawi 0,0,31
	srawi 9,9,6
	subf. 9,0,9
	bc 12,2,.L31
	divw 3,3,9
.L31:
	cmpwi 0,12,0
	li 10,0
	bc 12,2,.L33
	divw 10,28,12
.L33:
	mr 9,3
	la 3,.LC3@l(26)
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,30
	bl strcpy
	lwz 9,84(20)
	lbz 0,3580(9)
	cmpw 0,31,0
	bc 4,2,.L34
	lis 3,.LC1@ha
	mr 4,24
	la 3,.LC1@l(3)
	mr 5,30
	crxor 6,6,6
	bl va
	mr 4,3
	addi 3,1,8
	bl strcpy
	b .L35
.L34:
	lis 3,.LC4@ha
	mr 4,24
	la 3,.LC4@l(3)
	mr 5,30
	crxor 6,6,6
	bl va
	mr 4,3
	addi 3,1,8
	bl strcpy
.L35:
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,21
	bl strlen
	add 29,29,3
	cmplwi 0,29,1399
	bc 12,1,.L8
	mr 3,21
	addi 4,1,8
	bl strcat
	addi 0,31,1
	add 11,18,19
	rlwinm 31,0,0,0xff
	addi 9,24,7
	cmpw 0,31,11
	rlwinm 24,9,0,0xff
	bc 12,0,.L21
.L19:
	andi. 0,27,1
	addi 0,24,7
	rlwinm 24,0,0,0xff
	bc 12,2,.L38
	lis 28,mpaTranslateRank@ha
	lis 9,game@ha
	lwz 11,mpaTranslateRank@l(28)
	la 31,game@l(9)
	lis 3,.LC5@ha
	lwz 4,1028(31)
	addi 29,1,280
	la 3,.LC5@l(3)
	lbzx 0,11,18
	mr 30,29
	mulli 0,0,4596
	add 4,4,0
	addi 4,4,700
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,29
	bl strcpy
	lis 9,gcPlayers@ha
	lbz 0,gcPlayers@l(9)
	cmplwi 0,0,1
	bc 4,1,.L39
	lwz 9,mpaTranslateRank@l(28)
	lis 3,.LC6@ha
	lwz 4,1028(31)
	la 3,.LC6@l(3)
	add 9,18,9
	lbz 0,1(9)
	mulli 0,0,4596
	add 4,4,0
	addi 4,4,700
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,30
	bl strcat
.L39:
	lis 3,.LC7@ha
	mr 5,30
	mr 4,24
	la 3,.LC7@l(3)
	crxor 6,6,6
	bl va
	mr 4,3
	addi 3,1,8
	bl strcpy
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,21
	bl strlen
	add 29,29,3
	cmplwi 0,29,1399
	bc 12,1,.L8
	mr 3,21
	addi 4,1,8
	bl strcat
	addi 0,24,7
	rlwinm 24,0,0,0xff
.L38:
	mr 31,18
	add 0,31,19
	cmpw 0,31,0
	bc 4,0,.L8
	mcrf 4,0
	rlwinm 22,27,0,31,31
	addi 23,1,280
.L44:
	cmpwi 0,22,0
	bc 12,2,.L45
	lwz 4,84(20)
	lis 3,.LC8@ha
	mr 30,23
	la 3,.LC8@l(3)
	addi 4,4,700
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,23
	bl strcpy
	b .L46
.L45:
	stb 22,280(1)
	addi 30,1,280
.L46:
	mr 29,18
	add 25,29,19
	bc 4,16,.L48
	lis 9,game@ha
	lis 26,mpaTranslateRank@ha
	la 27,game@l(9)
	lis 28,.LC9@ha
.L50:
	lwz 11,mpaTranslateRank@l(26)
	la 3,.LC9@l(28)
	lwz 0,1028(27)
	lbzx 9,11,31
	lbzx 10,11,29
	mulli 9,9,4596
	add 9,9,0
	lwz 11,3584(9)
	lbzx 4,11,10
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,30
	bl strcat
	addi 0,29,1
	rlwinm 29,0,0,0xff
	cmpw 0,29,25
	bc 12,0,.L50
.L48:
	lwz 9,84(20)
	lbz 0,3580(9)
	cmpw 0,31,0
	bc 4,2,.L52
	lis 3,.LC1@ha
	mr 5,30
	mr 4,24
	la 3,.LC1@l(3)
	crxor 6,6,6
	bl va
	mr 4,3
	li 5,256
	addi 3,1,8
	bl strncpy
	b .L53
.L52:
	lis 3,.LC4@ha
	mr 5,30
	mr 4,24
	la 3,.LC4@l(3)
	crxor 6,6,6
	bl va
	mr 4,3
	li 5,256
	addi 3,1,8
	bl strncpy
.L53:
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,21
	bl strlen
	add 29,29,3
	cmplwi 0,29,1399
	bc 12,1,.L8
	mr 3,21
	addi 4,1,8
	bl strcat
	addi 0,31,1
	addi 9,24,7
	rlwinm 31,0,0,0xff
	rlwinm 24,9,0,0xff
	cmpw 0,31,25
	bc 12,0,.L44
.L8:
	lwz 0,420(1)
	lwz 12,352(1)
	mtlr 0
	lmw 17,356(1)
	mtcrf 8,12
	la 1,416(1)
	blr
.Lfe1:
	.size	 DrawMatrix,.Lfe1-DrawMatrix
	.align 2
	.globl UpdateMatrixScores
	.type	 UpdateMatrixScores,@function
UpdateMatrixScores:
	stwu 1,-16(1)
	stmw 30,8(1)
	lwz 11,84(3)
	lbz 9,3581(11)
	addi 9,9,1
	stb 9,3581(11)
	lwz 8,84(4)
	cmpwi 0,8,0
	bc 12,2,.L72
	lwz 10,84(3)
	lis 9,mpaTranslateRank@ha
	lis 30,mpaTranslateRank@ha
	lwz 7,mpaTranslateRank@l(9)
	lbz 11,3580(10)
	lwz 8,3584(8)
	lbzx 10,7,11
	lbzx 9,8,10
	addi 9,9,1
	stbx 9,8,10
	lwz 4,84(4)
	lbz 0,3580(4)
	lwz 5,3432(4)
	cmpwi 0,0,0
	bc 12,2,.L80
	lis 9,game@ha
	lis 12,mpaTranslateRank@ha
	la 3,game@l(9)
.L75:
	lwz 10,mpaTranslateRank@l(12)
	rlwinm 6,0,0,0xff
	lwz 11,1028(3)
	add 9,6,10
	lbz 0,-1(9)
	mulli 0,0,4596
	add 7,11,0
	lwz 9,3432(7)
	cmpw 0,9,5
	bc 12,1,.L80
	lbz 9,3580(7)
	lbzx 8,10,6
	lbzx 0,10,9
	stbx 0,10,6
	lwz 11,mpaTranslateRank@l(30)
	lbz 10,3580(7)
	stbx 8,11,10
	lbz 9,3580(4)
	addi 9,9,-1
	stb 9,3580(4)
	lbz 11,3580(7)
	addi 11,11,1
	stb 11,3580(7)
	lbz 0,3580(4)
	cmpwi 0,0,0
	bc 4,2,.L75
	b .L80
.L72:
	lwz 7,84(3)
	lis 9,mpaTranslateRank@ha
	lis 5,gcPlayers@ha
	lwz 6,mpaTranslateRank@l(9)
	lis 30,mpaTranslateRank@ha
	lbz 11,3580(7)
	lwz 8,3584(7)
	lbzx 10,6,11
	lbzx 9,8,10
	addi 9,9,1
	stbx 9,8,10
	lwz 3,84(3)
	lbz 9,gcPlayers@l(5)
	lbz 11,3580(3)
	addi 9,9,-1
	lwz 5,3432(3)
	rlwinm 0,11,0,0xff
	cmpw 0,0,9
	bc 12,2,.L80
	lis 9,game@ha
	lis 31,mpaTranslateRank@ha
	la 12,game@l(9)
	lis 4,gcPlayers@ha
.L83:
	lwz 10,mpaTranslateRank@l(31)
	rlwinm 6,11,0,0xff
	lwz 11,1028(12)
	add 9,6,10
	lbz 0,1(9)
	mulli 0,0,4596
	add 7,11,0
	lwz 9,3432(7)
	cmpw 0,5,9
	bc 12,1,.L80
	lbz 9,3580(7)
	lbzx 8,10,6
	lbzx 0,10,9
	stbx 0,10,6
	lwz 11,mpaTranslateRank@l(30)
	lbz 10,3580(7)
	stbx 8,11,10
	lbz 9,3580(3)
	addi 9,9,1
	stb 9,3580(3)
	lbz 11,3580(7)
	addi 11,11,-1
	stb 11,3580(7)
	lbz 11,3580(3)
	lbz 9,gcPlayers@l(4)
	rlwinm 0,11,0,0xff
	addi 9,9,-1
	cmpw 0,0,9
	bc 4,2,.L83
.L80:
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe2:
	.size	 UpdateMatrixScores,.Lfe2-UpdateMatrixScores
	.align 2
	.globl ExpandMatrix
	.type	 ExpandMatrix,@function
ExpandMatrix:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 9,mpaTranslateRank@ha
	mr 30,3
	lwz 0,mpaTranslateRank@l(9)
	lis 26,mpaTranslateRank@ha
	cmpwi 0,0,0
	bc 4,2,.L89
	lis 9,gi@ha
	lis 29,game@ha
	la 9,gi@l(9)
	la 29,game@l(29)
	lwz 0,132(9)
	li 4,766
	lwz 3,1544(29)
	mtlr 0
	blrl
	mr 0,3
	lwz 5,1544(29)
	li 4,204
	stw 0,mpaTranslateRank@l(26)
	bl memset
.L89:
	lis 29,gcPlayers@ha
	lis 9,game@ha
	lbz 11,gcPlayers@l(29)
	la 28,game@l(9)
	li 0,0
	lis 10,gi+132@ha
	li 4,766
	addi 11,11,1
	li 31,0
	stb 11,gcPlayers@l(29)
	lwz 9,84(30)
	stb 0,3581(9)
	lwz 0,gi+132@l(10)
	lwz 3,1544(28)
	mtlr 0
	blrl
	lwz 9,84(30)
	li 4,0
	stw 3,3584(9)
	lwz 11,84(30)
	lwz 5,1544(28)
	lwz 3,3584(11)
	bl memset
	lbz 9,gcPlayers@l(29)
	lwz 11,84(30)
	addi 9,9,-1
	rlwinm 29,9,0,0xff
	stb 29,3580(11)
	lwz 0,1544(28)
	cmpw 0,31,0
	bc 4,0,.L91
	mr 27,28
	lis 28,g_edicts@ha
.L93:
	mulli 0,31,916
	lwz 9,g_edicts@l(28)
	add 9,9,0
	addi 9,9,916
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L92
	lwz 4,84(9)
	lis 5,0x1
	lwz 3,84(30)
	ori 5,5,34463
	addi 4,4,700
	addi 3,3,700
	bl Q_strncasecmp
	cmpwi 0,3,0
	bc 4,2,.L92
	lwz 9,mpaTranslateRank@l(26)
	stbx 31,9,29
	b .L91
.L92:
	addi 0,31,1
	lwz 9,1544(27)
	rlwinm 31,0,0,0xff
	cmpw 0,31,9
	bc 12,0,.L93
.L91:
	lwz 3,84(30)
	lbz 0,3580(3)
	lwz 5,3432(3)
	cmpwi 0,0,0
	bc 12,2,.L100
	lis 9,game@ha
	lis 31,mpaTranslateRank@ha
	la 4,game@l(9)
.L98:
	lwz 10,mpaTranslateRank@l(31)
	rlwinm 6,0,0,0xff
	lwz 11,1028(4)
	add 9,6,10
	lbz 0,-1(9)
	mulli 0,0,4596
	add 7,11,0
	lwz 9,3432(7)
	cmpw 0,9,5
	bc 12,1,.L100
	lbz 9,3580(7)
	lbzx 8,10,6
	lbzx 0,10,9
	stbx 0,10,6
	lwz 11,mpaTranslateRank@l(26)
	lbz 10,3580(7)
	stbx 8,11,10
	lbz 9,3580(3)
	addi 9,9,-1
	stb 9,3580(3)
	lbz 11,3580(7)
	addi 11,11,1
	stb 11,3580(7)
	lbz 0,3580(3)
	cmpwi 0,0,0
	bc 4,2,.L98
.L100:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 ExpandMatrix,.Lfe3-ExpandMatrix
	.align 2
	.globl ContractMatrix
	.type	 ContractMatrix,@function
ContractMatrix:
	stwu 1,-16(1)
	stw 31,12(1)
	lis 10,gcPlayers@ha
	li 0,-999
	lbz 9,gcPlayers@l(10)
	addi 9,9,-1
	stb 9,gcPlayers@l(10)
	lwz 11,84(3)
	stw 0,3432(11)
	lwz 5,84(3)
	lbz 9,gcPlayers@l(10)
	lbz 11,3580(5)
	addi 9,9,-1
	lwz 3,3432(5)
	rlwinm 0,11,0,0xff
	cmpw 0,0,9
	bc 12,2,.L108
	lis 9,game@ha
	lis 4,mpaTranslateRank@ha
	la 31,game@l(9)
	lis 12,gcPlayers@ha
.L106:
	lwz 10,mpaTranslateRank@l(4)
	rlwinm 6,11,0,0xff
	lwz 11,1028(31)
	add 9,6,10
	lbz 0,1(9)
	mulli 0,0,4596
	add 7,11,0
	lwz 9,3432(7)
	cmpw 0,3,9
	bc 12,1,.L108
	lbz 9,3580(7)
	lbzx 8,10,6
	lbzx 0,10,9
	stbx 0,10,6
	lwz 11,mpaTranslateRank@l(4)
	lbz 10,3580(7)
	stbx 8,11,10
	lbz 9,3580(5)
	addi 9,9,1
	stb 9,3580(5)
	lbz 11,3580(7)
	addi 11,11,-1
	stb 11,3580(7)
	lbz 11,3580(5)
	lbz 9,gcPlayers@l(12)
	rlwinm 0,11,0,0xff
	addi 9,9,-1
	cmpw 0,0,9
	bc 4,2,.L106
.L108:
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 ContractMatrix,.Lfe4-ContractMatrix
	.comm	gametype,4,4
	.comm	flags,4,4
	.comm	gCauseTable,4,4
	.comm	gcPlayers,1,1
	.align 2
	.globl safediv
	.type	 safediv,@function
safediv:
	mr. 4,4
	mr 0,3
	mr 3,5
	bclr 12,2
	divw 3,0,4
	blr
.Lfe5:
	.size	 safediv,.Lfe5-safediv
	.align 2
	.globl RankPlayerUp
	.type	 RankPlayerUp,@function
RankPlayerUp:
	lbz 0,3580(3)
	lwz 4,3432(3)
	cmpwi 0,0,0
	bclr 12,2
	lis 9,game@ha
	lis 5,mpaTranslateRank@ha
	la 12,game@l(9)
.L61:
	lwz 10,mpaTranslateRank@l(5)
	rlwinm 6,0,0,0xff
	lwz 11,1028(12)
	add 9,6,10
	lbz 0,-1(9)
	mulli 0,0,4596
	add 7,11,0
	lwz 9,3432(7)
	cmpw 0,9,4
	bclr 12,1
	lbz 9,3580(7)
	lbzx 8,10,6
	lbzx 0,10,9
	stbx 0,10,6
	lwz 11,mpaTranslateRank@l(5)
	lbz 10,3580(7)
	stbx 8,11,10
	lbz 9,3580(3)
	addi 9,9,-1
	stb 9,3580(3)
	lbz 11,3580(7)
	addi 11,11,1
	stb 11,3580(7)
	lbz 0,3580(3)
	cmpwi 0,0,0
	bc 4,2,.L61
	blr
.Lfe6:
	.size	 RankPlayerUp,.Lfe6-RankPlayerUp
	.align 2
	.globl RankPlayerDown
	.type	 RankPlayerDown,@function
RankPlayerDown:
	stwu 1,-16(1)
	stw 31,12(1)
	lis 9,gcPlayers@ha
	lbz 8,3580(3)
	lbz 11,gcPlayers@l(9)
	rlwinm 0,8,0,0xff
	lwz 4,3432(3)
	addi 11,11,-1
	cmpw 0,0,11
	bc 12,2,.L64
	lis 9,game@ha
	lis 5,mpaTranslateRank@ha
	la 31,game@l(9)
	lis 12,gcPlayers@ha
.L68:
	lwz 10,mpaTranslateRank@l(5)
	rlwinm 6,8,0,0xff
	lwz 11,1028(31)
	add 9,6,10
	lbz 0,1(9)
	mulli 0,0,4596
	add 7,11,0
	lwz 9,3432(7)
	cmpw 0,4,9
	bc 12,1,.L64
	lbz 9,3580(7)
	lbzx 8,10,6
	lbzx 0,10,9
	stbx 0,10,6
	lwz 11,mpaTranslateRank@l(5)
	lbz 10,3580(7)
	stbx 8,11,10
	lbz 9,3580(3)
	addi 9,9,1
	stb 9,3580(3)
	lbz 11,3580(7)
	addi 11,11,-1
	stb 11,3580(7)
	lbz 8,3580(3)
	lbz 9,gcPlayers@l(12)
	rlwinm 0,8,0,0xff
	addi 9,9,-1
	cmpw 0,0,9
	bc 4,2,.L68
.L64:
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 RankPlayerDown,.Lfe7-RankPlayerDown
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
