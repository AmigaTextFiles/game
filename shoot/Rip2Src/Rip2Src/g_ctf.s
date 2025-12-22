	.file	"g_ctf.c"
gcc2_compiled.:
	.section	".rodata"
	.align 3
.LC0:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC1:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.type	 loc_CanSee,@function
loc_CanSee:
	stwu 1,-224(1)
	mflr 0
	stfd 31,216(1)
	stmw 26,192(1)
	stw 0,228(1)
	lwz 0,260(3)
	mr 30,4
	cmpwi 0,0,2
	bc 4,2,.L24
	b .L34
.L33:
	li 3,1
	b .L32
.L24:
	mr 10,3
	lfs 12,188(3)
	addi 11,3,188
	lfsu 9,4(10)
	addi 8,3,200
	lis 9,.LC0@ha
	lfs 7,200(3)
	la 9,.LC0@l(9)
	lfd 6,0(9)
	lis 6,0x4330
	addi 28,1,168
	fadds 8,9,12
	lis 9,gi@ha
	lis 27,vec3_origin@ha
	fadds 9,9,7
	la 26,gi@l(9)
	addi 31,1,72
	lis 9,.LC1@ha
	addi 29,1,156
	stfs 8,72(1)
	fsubs 12,8,12
	la 9,.LC1@l(9)
	lfs 0,4(11)
	fsubs 5,9,7
	lfs 11,4(10)
	fsubs 7,8,7
	lfd 31,0(9)
	fadds 11,11,0
	stfs 11,76(1)
	lfs 0,8(11)
	lfs 10,8(10)
	stfs 11,100(1)
	stfs 11,88(1)
	fadds 10,10,0
	stfs 12,84(1)
	stfs 8,96(1)
	stfs 10,80(1)
	stfs 10,92(1)
	stfs 10,104(1)
	lfs 13,4(11)
	stfs 11,112(1)
	stfs 10,116(1)
	fsubs 13,11,13
	stfs 12,108(1)
	stfs 13,100(1)
	lfs 0,4(11)
	stfs 9,120(1)
	fsubs 0,11,0
	stfs 0,112(1)
	lfs 0,4(8)
	lfs 13,4(10)
	fadds 13,13,0
	stfs 13,124(1)
	lfs 12,8(8)
	lfs 0,8(10)
	stfs 13,136(1)
	stfs 5,132(1)
	fadds 0,0,12
	stfs 0,140(1)
	stfs 0,128(1)
	stfs 8,144(1)
	lwz 0,508(30)
	stfs 11,148(1)
	xoris 0,0,0x8000
	stfs 10,152(1)
	stw 0,188(1)
	lfs 13,4(8)
	stw 6,184(1)
	lfd 0,184(1)
	fsubs 13,11,13
	stfs 11,160(1)
	stfs 10,164(1)
	stfs 7,156(1)
	fsub 0,0,6
	lfs 12,12(30)
	stfs 13,148(1)
	lfs 13,4(8)
	frsp 0,0
	lfs 9,4(30)
	lfs 10,8(30)
	fsubs 11,11,13
	fadds 12,12,0
	stfs 9,168(1)
	stfs 10,172(1)
	stfs 11,160(1)
	stfs 12,176(1)
.L29:
	lwz 11,48(26)
	la 5,vec3_origin@l(27)
	addi 3,1,8
	mr 4,28
	mr 6,5
	mr 7,31
	mr 8,30
	mtlr 11
	li 9,3
	blrl
	lfs 0,16(1)
	fcmpu 0,0,31
	bc 12,2,.L33
	addi 31,31,12
	cmpw 0,31,29
	bc 4,1,.L29
.L34:
	li 3,0
.L32:
	lwz 0,228(1)
	mtlr 0
	lmw 26,192(1)
	lfd 31,216(1)
	la 1,224(1)
	blr
.Lfe1:
	.size	 loc_CanSee,.Lfe1-loc_CanSee
	.section	".rodata"
	.align 2
.LC2:
	.string	"RED"
	.align 2
.LC3:
	.string	"BLUE"
	.align 2
.LC4:
	.string	"UKNOWN"
	.align 2
.LC5:
	.string	"BONUS: %d points for fragging enemy flag carrier.\n"
	.align 2
.LC6:
	.string	"%s defends %s's flag carrier against an agressive enemy\n"
	.align 2
.LC7:
	.string	"item_flag_team1"
	.align 2
.LC8:
	.string	"item_flag_team2"
	.align 2
.LC9:
	.string	"%s defends the %s base.\n"
	.align 2
.LC10:
	.string	"%s defends the %s flag.\n"
	.align 2
.LC11:
	.string	"%s defends the %s's flag carrier.\n"
	.align 2
.LC12:
	.long 0x3f800000
	.align 3
.LC13:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC14:
	.long 0x0
	.align 2
.LC15:
	.long 0x41000000
	.align 2
.LC16:
	.long 0x43c80000
	.section	".text"
	.align 2
	.globl CTFFragBonuses
	.type	 CTFFragBonuses,@function
CTFFragBonuses:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 26,48(1)
	stw 0,84(1)
	mr 27,3
	mr 29,5
	lwz 11,84(27)
	cmpwi 0,11,0
	bc 12,2,.L53
	lwz 0,84(29)
	xor 9,27,29
	subfic 10,9,0
	adde 9,10,9
	mr 8,0
	subfic 10,0,0
	adde 0,10,0
	or. 10,0,9
	bc 4,2,.L53
	lwz 0,1820(11)
	cmpwi 0,0,1
	bc 12,2,.L56
	cmpwi 0,0,2
	bc 12,2,.L57
	b .L60
.L56:
	li 30,2
	b .L59
.L57:
	li 30,1
	b .L59
.L60:
	li 30,-1
.L59:
	cmpwi 0,30,0
	bc 12,0,.L53
	lwz 9,84(27)
	lwz 0,1820(9)
	mr 7,9
	cmpwi 0,0,1
	bc 4,2,.L62
	lis 9,flag1_item@ha
	lis 11,flag2_item@ha
	lwz 26,flag1_item@l(9)
	lwz 0,flag2_item@l(11)
	b .L63
.L62:
	lis 9,flag2_item@ha
	lis 11,flag1_item@ha
	lwz 26,flag2_item@l(9)
	lwz 0,flag1_item@l(11)
.L63:
	lis 9,itemlist@ha
	lis 10,0x286b
	la 6,itemlist@l(9)
	ori 10,10,51739
	subf 0,6,0
	addi 11,7,740
	mullw 0,0,10
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L64
	lis 9,level+4@ha
	lis 10,gi+8@ha
	lfs 0,level+4@l(9)
	lis 5,.LC5@ha
	mr 3,29
	la 5,.LC5@l(5)
	li 4,1
	li 6,5
	stfs 0,1860(8)
	lwz 11,84(29)
	lwz 9,1816(11)
	addi 9,9,5
	stw 9,1816(11)
	lwz 0,gi+8@l(10)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,maxclients@ha
	lis 10,.LC12@ha
	lwz 11,maxclients@l(9)
	la 10,.LC12@l(10)
	lfs 13,0(10)
	lfs 0,20(11)
	li 10,1
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L53
	lis 9,g_edicts@ha
	mr 8,11
	lwz 11,g_edicts@l(9)
	li 6,0
	lis 7,0x4330
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	addi 11,11,1116
	lfd 12,0(9)
.L68:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L67
	lwz 9,84(11)
	lwz 0,1820(9)
	cmpw 0,0,30
	bc 4,2,.L67
	stw 6,1848(9)
.L67:
	addi 10,10,1
	lfs 13,20(8)
	xoris 0,10,0x8000
	addi 11,11,1116
	stw 0,44(1)
	stw 7,40(1)
	lfd 0,40(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L68
	b .L53
.L64:
	lis 11,.LC14@ha
	lfs 12,1848(7)
	la 11,.LC14@l(11)
	lfs 0,0(11)
	fcmpu 0,12,0
	bc 12,2,.L71
	lis 9,level+4@ha
	lis 11,.LC15@ha
	lfs 0,level+4@l(9)
	la 11,.LC15@l(11)
	lfs 13,0(11)
	fsubs 0,0,12
	fcmpu 0,0,13
	bc 4,0,.L71
	subf 0,6,26
	addi 11,8,740
	mullw 0,0,10
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L71
	lwz 9,1816(8)
	lis 11,gi@ha
	la 10,gi@l(11)
	addi 9,9,2
	stw 9,1816(8)
	lwz 11,84(29)
	lwz 0,1820(11)
	addi 5,11,700
	cmpwi 0,0,1
	bc 12,2,.L72
	cmpwi 0,0,2
	bc 12,2,.L73
	b .L76
.L72:
	lis 9,.LC2@ha
	la 6,.LC2@l(9)
	b .L75
.L73:
	lis 9,.LC3@ha
	la 6,.LC3@l(9)
	b .L75
.L76:
	lis 9,.LC4@ha
	la 6,.LC4@l(9)
.L75:
	lwz 0,0(10)
	lis 4,.LC6@ha
	li 3,1
	la 4,.LC6@l(4)
	b .L115
.L71:
	lwz 0,1820(8)
	cmpwi 0,0,1
	bc 12,2,.L78
	cmpwi 0,0,2
	bc 12,2,.L79
	b .L53
.L78:
	lis 9,.LC7@ha
	la 28,.LC7@l(9)
	b .L77
.L79:
	lis 9,.LC8@ha
	la 28,.LC8@l(9)
.L77:
	li 30,0
.L85:
	mr 3,30
	li 4,280
	mr 5,28
	bl G_Find
	mr. 30,3
	mcrf 7,0
	bc 12,30,.L53
	lwz 0,284(30)
	andis. 9,0,1
	bc 4,2,.L85
	bc 12,30,.L53
	lis 9,maxclients@ha
	lis 10,.LC12@ha
	lfs 11,4(27)
	lwz 11,maxclients@l(9)
	la 10,.LC12@l(10)
	lfs 0,0(10)
	lfs 13,20(11)
	li 10,1
	lfs 10,4(30)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L88
	lis 11,g_edicts@ha
	lis 9,itemlist@ha
	fmr 12,13
	lis 0,0x286b
	la 9,itemlist@l(9)
	lwz 7,g_edicts@l(11)
	ori 0,0,51739
	subf 9,9,26
	lis 11,.LC13@ha
	mullw 9,9,0
	lis 6,0x4330
	la 11,.LC13@l(11)
	lfd 13,0(11)
	rlwinm 8,9,0,0,29
	li 11,1116
.L90:
	add 31,7,11
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L91
	lwz 9,84(31)
	addi 9,9,740
	lwzx 0,9,8
	cmpwi 0,0,0
	bc 4,2,.L88
.L91:
	addi 10,10,1
	xoris 0,10,0x8000
	li 31,0
	stw 0,44(1)
	addi 11,11,1116
	stw 6,40(1)
	lfd 0,40(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L90
.L88:
	fsubs 10,11,10
	lfs 13,8(27)
	lis 9,.LC16@ha
	addi 3,1,8
	lfs 12,12(27)
	la 9,.LC16@l(9)
	lfs 11,4(29)
	stfs 10,8(1)
	lfs 0,8(30)
	lfs 10,8(29)
	lfs 9,12(29)
	fsubs 13,13,0
	lfs 31,0(9)
	stfs 13,12(1)
	lfs 0,12(30)
	fsubs 12,12,0
	stfs 12,16(1)
	lfs 0,4(30)
	fsubs 11,11,0
	stfs 11,24(1)
	lfs 0,8(30)
	fsubs 10,10,0
	stfs 10,28(1)
	lfs 0,12(30)
	fsubs 9,9,0
	stfs 9,32(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L94
	addi 28,1,24
	mr 3,28
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L94
	mr 3,30
	mr 4,27
	bl loc_CanSee
	cmpwi 0,3,0
	bc 4,2,.L94
	mr 3,30
	mr 4,29
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L93
.L94:
	lwz 9,84(29)
	lwz 11,1816(9)
	addi 11,11,1
	stw 11,1816(9)
	lwz 0,248(30)
	cmpwi 0,0,0
	bc 4,2,.L95
	lwz 11,84(29)
	lis 9,gi@ha
	la 10,gi@l(9)
	lwz 0,1820(11)
	addi 5,11,700
	cmpwi 0,0,1
	bc 12,2,.L96
	cmpwi 0,0,2
	bc 12,2,.L97
	b .L100
.L96:
	lis 9,.LC2@ha
	la 6,.LC2@l(9)
	b .L99
.L97:
	lis 9,.LC3@ha
	la 6,.LC3@l(9)
	b .L99
.L100:
	lis 9,.LC4@ha
	la 6,.LC4@l(9)
.L99:
	lwz 0,0(10)
	lis 4,.LC9@ha
	li 3,1
	la 4,.LC9@l(4)
	b .L115
.L95:
	lwz 11,84(29)
	lis 9,gi@ha
	la 10,gi@l(9)
	lwz 0,1820(11)
	addi 5,11,700
	cmpwi 0,0,1
	bc 12,2,.L102
	cmpwi 0,0,2
	bc 12,2,.L103
	b .L106
.L102:
	lis 9,.LC2@ha
	la 6,.LC2@l(9)
	b .L105
.L103:
	lis 9,.LC3@ha
	la 6,.LC3@l(9)
	b .L105
.L106:
	lis 9,.LC4@ha
	la 6,.LC4@l(9)
.L105:
	lwz 0,0(10)
	lis 4,.LC10@ha
	li 3,1
	la 4,.LC10@l(4)
.L115:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L53
.L93:
	xor 0,31,29
	addic 9,31,-1
	subfe 11,9,31
	addic 10,0,-1
	subfe 9,10,0
	and. 0,11,9
	bc 12,2,.L53
	lfs 13,4(31)
	addi 3,1,8
	lfs 0,4(27)
	lfs 12,8(27)
	lfs 11,12(27)
	fsubs 0,0,13
	lfs 10,4(29)
	lfs 9,8(29)
	stfs 0,8(1)
	lfs 13,8(31)
	lfs 8,12(29)
	fsubs 12,12,13
	stfs 12,12(1)
	lfs 0,12(31)
	fsubs 11,11,0
	stfs 11,16(1)
	lfs 0,4(31)
	fsubs 10,10,0
	stfs 10,8(1)
	lfs 0,8(31)
	fsubs 9,9,0
	stfs 9,12(1)
	lfs 0,12(31)
	fsubs 8,8,0
	stfs 8,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L109
	mr 3,28
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L109
	mr 4,27
	mr 3,31
	bl loc_CanSee
	cmpwi 0,3,0
	bc 4,2,.L109
	mr 3,31
	mr 4,29
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L53
.L109:
	lwz 10,84(29)
	lis 11,gi@ha
	la 8,gi@l(11)
	lwz 9,1816(10)
	addi 9,9,1
	stw 9,1816(10)
	lwz 11,84(29)
	lwz 0,1820(11)
	addi 5,11,700
	cmpwi 0,0,1
	bc 12,2,.L110
	cmpwi 0,0,2
	bc 12,2,.L111
	b .L114
.L110:
	lis 9,.LC2@ha
	la 6,.LC2@l(9)
	b .L113
.L111:
	lis 9,.LC3@ha
	la 6,.LC3@l(9)
	b .L113
.L114:
	lis 9,.LC4@ha
	la 6,.LC4@l(9)
.L113:
	lwz 0,0(8)
	lis 4,.LC11@ha
	li 3,1
	la 4,.LC11@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L53:
	lwz 0,84(1)
	mtlr 0
	lmw 26,48(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe2:
	.size	 CTFFragBonuses,.Lfe2-CTFFragBonuses
	.section	".rodata"
	.align 2
.LC17:
	.string	"Red Flag"
	.align 2
.LC18:
	.string	"Blue Flag"
	.align 2
.LC19:
	.string	"Flag"
	.align 2
.LC20:
	.string	"\n"
	.section	".text"
	.align 2
	.globl Print_Msg
	.type	 Print_Msg,@function
Print_Msg:
	stwu 1,-1056(1)
	mflr 0
	stmw 28,1040(1)
	stw 0,1060(1)
	mr 29,4
	li 31,0
	lbz 0,0(29)
	mr 30,3
	stb 31,8(1)
	cmpwi 0,0,34
	bc 4,2,.L127
	mr 3,29
	bl strlen
	add 3,3,29
	stb 31,-1(3)
	addi 29,29,1
.L127:
	lbz 9,0(29)
	addi 31,1,8
	mr 28,31
	cmpwi 0,9,0
	bc 12,2,.L129
.L131:
	cmpwi 0,9,37
	bc 4,2,.L133
	lbzu 9,1(29)
	addi 9,9,-69
	cmplwi 0,9,47
	bc 12,1,.L185
	lis 11,.L186@ha
	slwi 10,9,2
	la 11,.L186@l(11)
	lis 9,.L186@ha
	lwzx 0,10,11
	la 9,.L186@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L186:
	.long .L172-.L186
	.long .L136-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L184-.L186
	.long .L148-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L160-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L172-.L186
	.long .L136-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L184-.L186
	.long .L148-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L185-.L186
	.long .L160-.L186
.L136:
	lwz 9,84(30)
	lwz 0,1820(9)
	cmpwi 0,0,1
	bc 4,2,.L137
	lis 9,.LC17@ha
	la 4,.LC17@l(9)
	b .L138
.L137:
	cmpwi 0,0,2
	bc 4,2,.L140
	lis 9,.LC18@ha
	la 4,.LC18@l(9)
	b .L138
.L140:
	lis 9,.LC19@ha
	la 4,.LC19@l(9)
.L138:
	mr 3,31
	bl strcpy
	lwz 9,84(30)
	lwz 0,1820(9)
	cmpwi 0,0,1
	bc 4,2,.L142
	lis 9,.LC17@ha
	la 3,.LC17@l(9)
	b .L189
.L142:
	cmpwi 0,0,2
	bc 4,2,.L145
	lis 9,.LC18@ha
	la 3,.LC18@l(9)
	b .L189
.L145:
	lis 9,.LC19@ha
	la 3,.LC19@l(9)
	b .L189
.L148:
	lwz 9,84(30)
	lwz 0,1820(9)
	cmpwi 0,0,1
	bc 4,2,.L149
	lis 9,.LC18@ha
	la 4,.LC18@l(9)
	b .L150
.L149:
	cmpwi 0,0,2
	bc 4,2,.L152
	lis 9,.LC17@ha
	la 4,.LC17@l(9)
	b .L150
.L152:
	lis 9,.LC19@ha
	la 4,.LC19@l(9)
.L150:
	mr 3,31
	bl strcpy
	lwz 9,84(30)
	lwz 0,1820(9)
	cmpwi 0,0,1
	bc 4,2,.L154
	lis 9,.LC18@ha
	la 3,.LC18@l(9)
	b .L189
.L154:
	cmpwi 0,0,2
	bc 4,2,.L157
	lis 9,.LC17@ha
	la 3,.LC17@l(9)
	b .L189
.L157:
	lis 9,.LC19@ha
	la 3,.LC19@l(9)
	b .L189
.L160:
	lwz 9,84(30)
	lwz 0,1820(9)
	cmpwi 0,0,1
	bc 12,2,.L161
	cmpwi 0,0,2
	bc 12,2,.L162
	b .L165
.L161:
	lis 9,.LC2@ha
	la 4,.LC2@l(9)
	b .L164
.L162:
	lis 9,.LC3@ha
	la 4,.LC3@l(9)
	b .L164
.L165:
	lis 9,.LC4@ha
	la 4,.LC4@l(9)
.L164:
	mr 3,31
	bl strcpy
	lwz 9,84(30)
	lwz 0,1820(9)
	cmpwi 0,0,1
	bc 12,2,.L166
	cmpwi 0,0,2
	bc 12,2,.L167
	b .L170
.L166:
	lis 9,.LC2@ha
	la 3,.LC2@l(9)
	b .L189
.L167:
	lis 9,.LC3@ha
	la 3,.LC3@l(9)
	b .L189
.L170:
	lis 9,.LC4@ha
	la 3,.LC4@l(9)
	b .L189
.L172:
	lwz 9,84(30)
	lwz 0,1820(9)
	cmpwi 0,0,1
	bc 12,2,.L173
	cmpwi 0,0,2
	bc 12,2,.L174
	b .L177
.L173:
	lis 9,.LC3@ha
	la 4,.LC3@l(9)
	b .L176
.L174:
	lis 9,.LC2@ha
	la 4,.LC2@l(9)
	b .L176
.L177:
	lis 9,.LC4@ha
	la 4,.LC4@l(9)
.L176:
	mr 3,31
	bl strcpy
	lwz 9,84(30)
	lwz 0,1820(9)
	cmpwi 0,0,1
	bc 12,2,.L178
	cmpwi 0,0,2
	bc 12,2,.L179
	b .L182
.L178:
	lis 9,.LC3@ha
	la 3,.LC3@l(9)
	b .L189
.L179:
	lis 9,.LC2@ha
	la 3,.LC2@l(9)
	b .L189
.L182:
	lis 9,.LC4@ha
	la 3,.LC4@l(9)
	b .L189
.L184:
	lwz 4,84(30)
	mr 3,31
	addi 4,4,700
	bl strcpy
	lwz 3,84(30)
	addi 3,3,700
.L189:
	bl strlen
	add 31,31,3
	b .L130
.L185:
	lbz 0,0(29)
	stb 0,0(31)
	b .L190
.L133:
	stb 9,0(31)
.L190:
	addi 31,31,1
.L130:
	lbzu 9,1(29)
	cmpwi 0,9,0
	bc 12,2,.L129
	subf 0,28,31
	cmplwi 0,0,1022
	bc 4,1,.L131
.L129:
	li 0,0
	lis 4,.LC20@ha
	stb 0,0(31)
	la 4,.LC20@l(4)
	addi 3,1,8
	bl strcat
	lis 9,gi+8@ha
	mr 3,30
	lwz 0,gi+8@l(9)
	li 4,2
	addi 5,1,8
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,1060(1)
	mtlr 0
	lmw 28,1040(1)
	la 1,1056(1)
	blr
.Lfe3:
	.size	 Print_Msg,.Lfe3-Print_Msg
	.section	".rodata"
	.align 2
.LC21:
	.string	"info_goal_team1"
	.align 2
.LC22:
	.string	"info_touch_team1"
	.align 2
.LC23:
	.string	"info_goal_team2"
	.align 2
.LC24:
	.string	"info_touch_team2"
	.align 2
.LC25:
	.string	"Don't know what team the touchdown is on.\n"
	.align 2
.LC26:
	.string	"%s %s\n"
	.align 2
.LC27:
	.string	"%s captured the enemy's flag!\n"
	.align 2
.LC28:
	.string	"%s captured your flag!\n"
	.align 2
.LC29:
	.string	"teams/flagcap.wav"
	.align 2
.LC30:
	.string	"%s gets an assist for returning the flag!\n"
	.align 2
.LC31:
	.string	"%s gets an assist for fragging the flag carrier!\n"
	.align 2
.LC32:
	.long 0x3f800000
	.align 2
.LC33:
	.long 0x0
	.align 2
.LC34:
	.long 0x41200000
	.align 3
.LC35:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Flag_Check
	.type	 Flag_Check,@function
Flag_Check:
	stwu 1,-96(1)
	mflr 0
	stfd 31,88(1)
	stmw 19,36(1)
	stw 0,100(1)
	mr 30,4
	mr 31,3
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L197
	lwz 3,280(31)
	lis 4,.LC21@ha
	la 4,.LC21@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L200
	lwz 3,280(31)
	lis 4,.LC22@ha
	la 4,.LC22@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L199
.L200:
	li 11,1
	b .L201
.L199:
	lwz 3,280(31)
	lis 4,.LC23@ha
	la 4,.LC23@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L203
	lwz 3,280(31)
	lis 4,.LC24@ha
	la 4,.LC24@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L202
.L203:
	li 11,2
	b .L201
.L202:
	lis 9,gi+8@ha
	lis 5,.LC25@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC25@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L197
.L201:
	cmpwi 0,11,1
	bc 4,2,.L205
	lis 9,flag2_item@ha
	lwz 29,flag2_item@l(9)
	b .L206
.L205:
	lis 9,flag1_item@ha
	lwz 29,flag1_item@l(9)
.L206:
	lwz 8,84(30)
	lwz 0,1820(8)
	cmpw 0,11,0
	bc 12,2,.L208
	lwz 0,932(31)
	cmpwi 0,0,1
	bc 4,2,.L197
.L208:
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,29
	addi 11,8,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L197
	lis 9,level+368@ha
	la 9,level+368@l(9)
	cmpwi 0,9,0
	bc 12,2,.L210
	lis 7,.LC26@ha
	addi 8,8,700
	la 7,.LC26@l(7)
	mr 3,30
	li 4,0
	li 5,2
	li 6,0
	crxor 6,6,6
	bl tprintf
	b .L211
.L210:
	lis 7,.LC27@ha
	addi 8,8,700
	la 7,.LC27@l(7)
	mr 3,30
	li 4,0
	li 5,2
	li 6,0
	crxor 6,6,6
	bl tprintf
.L211:
	lis 9,level+304@ha
	la 9,level+304@l(9)
	cmpwi 0,9,0
	bc 12,2,.L212
	lwz 8,84(30)
	lis 7,.LC26@ha
	mr 3,30
	la 7,.LC26@l(7)
	li 4,0
	addi 8,8,700
	li 5,2
	li 6,0
	crxor 6,6,6
	bl eprintf
	b .L213
.L212:
	lwz 8,84(30)
	lis 7,.LC28@ha
	mr 3,30
	la 7,.LC28@l(7)
	li 4,0
	addi 8,8,700
	li 5,2
	li 6,0
	crxor 6,6,6
	bl eprintf
.L213:
	lwz 5,296(31)
	cmpwi 0,5,0
	bc 12,2,.L214
	li 3,0
	li 4,300
	bl G_Find
	mr. 3,3
	bc 12,2,.L214
	lis 0,0x3f80
	stw 0,328(3)
.L214:
	lwz 10,932(31)
	cmpwi 0,10,0
	bc 4,2,.L216
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,29
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	stwx 10,11,9
	b .L217
.L216:
	li 0,0
	stw 0,932(31)
.L217:
	lis 29,gi@ha
	lis 3,.LC29@ha
	la 29,gi@l(29)
	la 3,.LC29@l(3)
	lwz 9,36(29)
	lis 26,gi@ha
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC32@ha
	lis 10,.LC33@ha
	lis 11,.LC33@ha
	la 9,.LC32@l(9)
	mr 5,3
	la 10,.LC33@l(10)
	lfs 1,0(9)
	mtlr 0
	la 11,.LC33@l(11)
	li 4,26
	lfs 2,0(10)
	mr 3,31
	lfs 3,0(11)
	blrl
	lwz 9,84(30)
	lwz 0,1820(9)
	cmpwi 0,0,1
	bc 4,2,.L218
	lis 11,team1_captures@ha
	lwz 9,team1_captures@l(11)
	addi 9,9,1
	stw 9,team1_captures@l(11)
	b .L219
.L218:
	cmpwi 0,0,2
	bc 4,2,.L219
	lis 11,team2_captures@ha
	lwz 9,team2_captures@l(11)
	addi 9,9,1
	stw 9,team2_captures@l(11)
.L219:
	lis 9,level+956@ha
	lwz 8,84(30)
	lis 11,maxclients@ha
	lwz 10,level+956@l(9)
	li 27,1
	lis 19,level@ha
	lis 9,.LC32@ha
	lwz 0,1816(8)
	lis 20,maxclients@ha
	la 9,.LC32@l(9)
	lfs 13,0(9)
	add 0,0,10
	lwz 9,maxclients@l(11)
	stw 0,1816(8)
	lfs 0,20(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L222
	lis 21,g_edicts@ha
	lis 22,0x4330
	li 28,1116
	lis 23,0xc0a0
	lis 24,.LC30@ha
	lis 25,.LC31@ha
.L224:
	lwz 0,g_edicts@l(21)
	add 29,0,28
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L223
	lwz 10,84(29)
	lwz 9,84(30)
	lwz 11,1820(10)
	lwz 0,1820(9)
	cmpw 0,11,0
	bc 12,2,.L233
	stw 23,1848(10)
	b .L223
.L233:
	la 31,level@l(19)
	lwz 9,1816(10)
	lis 11,.LC34@ha
	lwz 0,960(31)
	la 11,.LC34@l(11)
	lfs 31,0(11)
	add 9,9,0
	stw 9,1816(10)
	lwz 5,84(29)
	lfs 13,4(31)
	lfs 0,1852(5)
	fadds 0,0,31
	fcmpu 0,0,13
	bc 4,1,.L229
	lwz 9,gi@l(26)
	addi 5,5,700
	li 3,2
	la 4,.LC30@l(24)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 11,84(29)
	lwz 9,1816(11)
	addi 9,9,1
	stw 9,1816(11)
.L229:
	lwz 5,84(29)
	lfs 13,4(31)
	lfs 0,1860(5)
	fadds 0,0,31
	fcmpu 0,0,13
	bc 4,1,.L223
	lwz 9,gi@l(26)
	addi 5,5,700
	li 3,2
	la 4,.LC31@l(25)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 11,84(29)
	lwz 9,1816(11)
	addi 9,9,2
	stw 9,1816(11)
.L223:
	addi 27,27,1
	lwz 11,maxclients@l(20)
	xoris 0,27,0x8000
	lis 10,.LC35@ha
	stw 0,28(1)
	la 10,.LC35@l(10)
	addi 28,28,1116
	stw 22,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L224
.L222:
	bl CTFResetFlags
.L197:
	lwz 0,100(1)
	mtlr 0
	lmw 19,36(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe4:
	.size	 Flag_Check,.Lfe4-Flag_Check
	.align 2
	.globl CTFResetFlags
	.type	 CTFResetFlags,@function
CTFResetFlags:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,.LC7@ha
	li 31,0
	la 29,.LC7@l(9)
	b .L262
.L264:
	lwz 0,284(31)
	andis. 11,0,1
	bc 12,2,.L265
	mr 3,31
	bl G_FreeEdict
	b .L262
.L265:
	lwz 0,184(31)
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	stw 30,80(31)
.L262:
	mr 3,31
	li 4,280
	mr 5,29
	li 30,1
	bl G_Find
	mr. 31,3
	lis 9,gi+72@ha
	mr 3,31
	bc 4,2,.L264
	lis 9,.LC8@ha
	lis 11,gi@ha
	la 28,.LC8@l(9)
	la 29,gi@l(11)
	li 31,0
	b .L273
.L275:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L276
	mr 3,31
	bl G_FreeEdict
	b .L273
.L276:
	lwz 0,184(31)
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 9,72(29)
	mtlr 9
	blrl
	stw 30,80(31)
.L273:
	mr 3,31
	li 4,280
	mr 5,28
	bl G_Find
	mr. 31,3
	mr 3,31
	bc 4,2,.L275
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 CTFResetFlags,.Lfe5-CTFResetFlags
	.section	".rodata"
	.align 2
.LC39:
	.string	"Don't know what team the flag is on.\n"
	.align 2
.LC40:
	.string	"%s got the enemy's flag!\n"
	.align 2
.LC41:
	.string	"%s got your flag!\n"
	.align 2
.LC42:
	.string	"world/x_alarm.wav"
	.align 2
.LC43:
	.long 0x3f800000
	.align 2
.LC44:
	.long 0x0
	.align 2
.LC45:
	.long 0x41200000
	.align 3
.LC46:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFPickup_Flag
	.type	 CTFPickup_Flag,@function
CTFPickup_Flag:
	stwu 1,-96(1)
	mflr 0
	stfd 31,88(1)
	stmw 19,36(1)
	stw 0,100(1)
	mr 30,4
	mr 31,3
	lwz 3,280(31)
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L280
	li 29,1
	b .L281
.L280:
	lwz 3,280(31)
	lis 4,.LC8@ha
	la 4,.LC8@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L282
	lis 9,gi+8@ha
	lis 5,.LC39@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC39@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L317:
	li 3,0
	b .L314
.L282:
	li 29,2
.L281:
	cmpwi 0,29,1
	bc 4,2,.L284
	lis 9,flag1_item@ha
	lis 11,flag2_item@ha
	lis 5,.LC21@ha
	lwz 27,flag1_item@l(9)
	li 3,0
	lwz 28,flag2_item@l(11)
	la 5,.LC21@l(5)
	li 4,280
	bl G_Find
	b .L285
.L284:
	lis 9,flag2_item@ha
	lis 11,flag1_item@ha
	lis 5,.LC23@ha
	lwz 27,flag2_item@l(9)
	li 3,0
	lwz 28,flag1_item@l(11)
	la 5,.LC23@l(5)
	li 4,280
	bl G_Find
.L285:
	lwz 8,84(30)
	lwz 0,1820(8)
	cmpw 0,29,0
	bc 4,2,.L286
	lwz 0,284(31)
	andis. 9,0,1
	bc 4,2,.L317
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,28
	addi 11,8,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L317
	cmpwi 0,3,0
	bc 4,2,.L317
	lis 9,level+368@ha
	la 9,level+368@l(9)
	cmpwi 0,9,0
	bc 12,2,.L290
	lis 7,.LC26@ha
	addi 8,8,700
	la 7,.LC26@l(7)
	mr 3,30
	li 4,0
	li 5,2
	li 6,0
	crxor 6,6,6
	bl tprintf
	b .L291
.L290:
	lis 7,.LC27@ha
	addi 8,8,700
	la 7,.LC27@l(7)
	mr 3,30
	li 4,0
	li 5,2
	li 6,0
	crxor 6,6,6
	bl tprintf
.L291:
	lis 9,level+304@ha
	la 9,level+304@l(9)
	cmpwi 0,9,0
	bc 12,2,.L292
	lwz 8,84(30)
	lis 7,.LC26@ha
	mr 3,30
	la 7,.LC26@l(7)
	li 4,0
	addi 8,8,700
	li 5,2
	li 6,0
	crxor 6,6,6
	bl eprintf
	b .L293
.L292:
	lwz 8,84(30)
	lis 7,.LC28@ha
	mr 3,30
	la 7,.LC28@l(7)
	li 4,0
	addi 8,8,700
	li 5,2
	li 6,0
	crxor 6,6,6
	bl eprintf
.L293:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 10,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,28
	addi 10,10,740
	mullw 9,9,0
	li 8,0
	rlwinm 9,9,0,0,29
	stwx 8,10,9
	lwz 11,84(30)
	lwz 0,1820(11)
	cmpwi 0,0,1
	bc 4,2,.L294
	lis 11,team1_captures@ha
	lwz 9,team1_captures@l(11)
	addi 9,9,1
	stw 9,team1_captures@l(11)
	b .L295
.L294:
	cmpwi 0,0,2
	bc 4,2,.L295
	lis 11,team2_captures@ha
	lwz 9,team2_captures@l(11)
	addi 9,9,1
	stw 9,team2_captures@l(11)
.L295:
	lis 29,gi@ha
	lis 3,.LC29@ha
	la 29,gi@l(29)
	la 3,.LC29@l(3)
	lwz 9,36(29)
	li 27,1
	lis 26,gi@ha
	lis 19,level@ha
	lis 20,maxclients@ha
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC43@ha
	lis 10,.LC44@ha
	lis 11,.LC44@ha
	la 9,.LC43@l(9)
	la 10,.LC44@l(10)
	la 11,.LC44@l(11)
	lfs 1,0(9)
	mtlr 0
	mr 5,3
	lfs 2,0(10)
	li 4,26
	lfs 3,0(11)
	mr 3,31
	blrl
	lis 9,level+956@ha
	lwz 8,84(30)
	lis 11,maxclients@ha
	lwz 10,level+956@l(9)
	lis 9,.LC43@ha
	lwz 0,1816(8)
	la 9,.LC43@l(9)
	lfs 13,0(9)
	add 0,0,10
	lwz 9,maxclients@l(11)
	stw 0,1816(8)
	lfs 0,20(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L298
	lis 21,g_edicts@ha
	lis 22,0x4330
	li 28,1116
	lis 23,0xc0a0
	lis 24,.LC30@ha
	lis 25,.LC31@ha
.L300:
	lwz 0,g_edicts@l(21)
	add 29,0,28
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L299
	lwz 10,84(29)
	lwz 9,84(30)
	lwz 11,1820(10)
	lwz 0,1820(9)
	cmpw 0,11,0
	bc 12,2,.L315
	stw 23,1848(10)
	b .L299
.L315:
	la 31,level@l(19)
	lwz 9,1816(10)
	lis 11,.LC45@ha
	lwz 0,960(31)
	la 11,.LC45@l(11)
	lfs 31,0(11)
	add 9,9,0
	stw 9,1816(10)
	lwz 5,84(29)
	lfs 13,4(31)
	lfs 0,1852(5)
	fadds 0,0,31
	fcmpu 0,0,13
	bc 4,1,.L305
	lwz 9,gi@l(26)
	addi 5,5,700
	li 3,2
	la 4,.LC30@l(24)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 11,84(29)
	lwz 9,1816(11)
	addi 9,9,1
	stw 9,1816(11)
.L305:
	lwz 5,84(29)
	lfs 13,4(31)
	lfs 0,1860(5)
	fadds 0,0,31
	fcmpu 0,0,13
	bc 4,1,.L299
	lwz 9,gi@l(26)
	addi 5,5,700
	li 3,2
	la 4,.LC31@l(25)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 11,84(29)
	lwz 9,1816(11)
	addi 9,9,2
	stw 9,1816(11)
.L299:
	addi 27,27,1
	lwz 11,maxclients@l(20)
	xoris 0,27,0x8000
	lis 10,.LC46@ha
	stw 0,28(1)
	la 10,.LC46@l(10)
	addi 28,28,1116
	stw 22,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L300
.L298:
	bl CTFResetFlags
	b .L317
.L286:
	lis 9,level+496@ha
	la 9,level+496@l(9)
	cmpwi 0,9,0
	bc 12,2,.L308
	lis 7,.LC26@ha
	addi 8,8,700
	la 7,.LC26@l(7)
	mr 3,30
	li 4,0
	li 5,2
	li 6,0
	crxor 6,6,6
	bl tprintf
	b .L309
.L308:
	lis 7,.LC40@ha
	addi 8,8,700
	la 7,.LC40@l(7)
	mr 3,30
	li 4,0
	li 5,2
	li 6,0
	crxor 6,6,6
	bl tprintf
.L309:
	lis 9,level+432@ha
	la 9,level+432@l(9)
	cmpwi 0,9,0
	bc 12,2,.L310
	lwz 8,84(30)
	lis 7,.LC26@ha
	mr 3,30
	la 7,.LC26@l(7)
	li 4,0
	addi 8,8,700
	li 5,2
	li 6,0
	crxor 6,6,6
	bl eprintf
	b .L311
.L310:
	lwz 8,84(30)
	lis 7,.LC41@ha
	mr 3,30
	la 7,.LC41@l(7)
	li 4,0
	addi 8,8,700
	li 5,2
	li 6,0
	crxor 6,6,6
	bl eprintf
.L311:
	lwz 4,276(31)
	lis 26,gi@ha
	cmpwi 0,4,0
	bc 12,2,.L312
	la 9,gi@l(26)
	mr 3,30
	lwz 0,12(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L312:
	lis 29,gi@ha
	lis 3,.LC42@ha
	la 29,gi@l(29)
	la 3,.LC42@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC43@ha
	lis 10,.LC44@ha
	lis 11,.LC44@ha
	la 9,.LC43@l(9)
	la 10,.LC44@l(10)
	la 11,.LC44@l(11)
	lfs 1,0(9)
	mtlr 0
	mr 5,3
	lfs 2,0(10)
	li 4,26
	lfs 3,0(11)
	mr 3,31
	blrl
	lwz 6,84(30)
	lis 8,level@ha
	lis 11,itemlist@ha
	la 8,level@l(8)
	la 11,itemlist@l(11)
	lwz 10,952(8)
	lis 0,0x286b
	subf 11,11,27
	lwz 9,1816(6)
	ori 0,0,51739
	li 7,1
	mullw 11,11,0
	add 9,9,10
	stw 9,1816(6)
	rlwinm 11,11,0,0,29
	lwz 9,84(30)
	addi 9,9,740
	stwx 7,9,11
	lfs 0,4(8)
	lwz 10,84(30)
	stfs 0,1856(10)
	lwz 0,284(31)
	andis. 11,0,0x1
	bc 4,2,.L313
	lwz 0,264(31)
	lwz 9,184(31)
	oris 0,0,0x8000
	stw 11,248(31)
	ori 9,9,1
	stw 0,264(31)
	stw 9,184(31)
.L313:
	li 3,1
.L314:
	lwz 0,100(1)
	mtlr 0
	lmw 19,36(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe6:
	.size	 CTFPickup_Flag,.Lfe6-CTFPickup_Flag
	.section	".rodata"
	.align 2
.LC47:
	.string	"The %s %s\n"
	.align 2
.LC48:
	.string	"The %s flag has returned!\n"
	.section	".text"
	.align 2
	.globl CTFDropFlagThink
	.type	 CTFDropFlagThink,@function
CTFDropFlagThink:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lis 9,.LC7@ha
	lwz 30,280(31)
	la 9,.LC7@l(9)
	cmpw 0,30,9
	bc 4,2,.L321
	li 31,0
	b .L327
.L329:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L330
	mr 3,31
	bl G_FreeEdict
	b .L327
.L330:
	lwz 0,184(31)
	li 29,1
	lis 9,gi+72@ha
	stw 29,248(31)
	mr 3,31
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	stw 29,80(31)
.L327:
	mr 3,31
	li 4,280
	mr 5,30
	bl G_Find
	mr. 31,3
	bc 4,2,.L329
	lis 9,level+560@ha
	la 6,level+560@l(9)
	cmpwi 0,6,0
	bc 12,2,.L333
	lis 9,gi@ha
	lis 5,.LC2@ha
	lwz 0,gi@l(9)
	lis 4,.LC47@ha
	la 5,.LC2@l(5)
	b .L373
.L333:
	lis 9,gi@ha
	lis 5,.LC2@ha
	lwz 0,gi@l(9)
	lis 4,.LC48@ha
	la 5,.LC2@l(5)
	b .L374
.L321:
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	cmpw 0,30,9
	bc 4,2,.L346
	li 31,0
	b .L352
.L354:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L355
	mr 3,31
	bl G_FreeEdict
	b .L352
.L355:
	lwz 0,184(31)
	li 29,1
	lis 9,gi+72@ha
	stw 29,248(31)
	mr 3,31
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	stw 29,80(31)
.L352:
	mr 3,31
	li 4,280
	mr 5,30
	bl G_Find
	mr. 31,3
	bc 4,2,.L354
	lis 9,level+560@ha
	la 6,level+560@l(9)
	cmpwi 0,6,0
	bc 12,2,.L358
	lis 9,gi@ha
	lis 5,.LC3@ha
	lwz 0,gi@l(9)
	lis 4,.LC47@ha
	la 5,.LC3@l(5)
.L373:
	la 4,.LC47@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L345
.L358:
	lis 9,gi@ha
	lis 5,.LC3@ha
	lwz 0,gi@l(9)
	lis 4,.LC48@ha
	la 5,.LC3@l(5)
.L374:
	la 4,.LC48@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L345
.L346:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L371
	mr 3,31
	bl G_FreeEdict
	b .L345
.L371:
	lwz 0,184(31)
	li 29,1
	lis 9,gi+72@ha
	stw 29,248(31)
	mr 3,31
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	stw 29,80(31)
.L345:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 CTFDropFlagThink,.Lfe7-CTFDropFlagThink
	.section	".rodata"
	.align 2
.LC49:
	.string	"droptofloor: %s startsolid at %s\n"
	.align 3
.LC50:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC51:
	.long 0xc1700000
	.align 2
.LC52:
	.long 0x41700000
	.align 2
.LC53:
	.long 0x0
	.align 2
.LC54:
	.long 0xc3000000
	.section	".text"
	.align 2
	.globl CTFFlagSetup
	.type	 CTFFlagSetup,@function
CTFFlagSetup:
	stwu 1,-112(1)
	mflr 0
	stmw 29,100(1)
	stw 0,116(1)
	lis 9,.LC51@ha
	lis 11,.LC51@ha
	la 9,.LC51@l(9)
	la 11,.LC51@l(11)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC51@ha
	lfs 2,0(11)
	la 9,.LC51@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lis 9,.LC52@ha
	lfs 13,0(11)
	la 9,.LC52@l(9)
	lfs 1,0(9)
	lis 9,.LC52@ha
	stfs 13,188(31)
	la 9,.LC52@l(9)
	lfs 0,4(11)
	lfs 2,0(9)
	lis 9,.LC52@ha
	stfs 0,192(31)
	la 9,.LC52@l(9)
	lfs 13,8(11)
	lfs 3,0(9)
	stfs 13,196(31)
	bl tv
	mr 11,3
	lwz 4,268(31)
	lfs 13,0(11)
	cmpwi 0,4,0
	stfs 13,200(31)
	lfs 0,4(11)
	stfs 0,204(31)
	lfs 13,8(11)
	stfs 13,208(31)
	bc 12,2,.L376
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L377
.L376:
	lis 9,gi+44@ha
	lwz 11,648(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L377:
	li 11,1
	lis 9,Touch_Item@ha
	stw 11,248(31)
	la 9,Touch_Item@l(9)
	li 0,7
	lis 11,.LC53@ha
	stw 9,444(31)
	addi 29,31,4
	la 11,.LC53@l(11)
	lis 9,.LC54@ha
	stw 0,260(31)
	lfs 1,0(11)
	la 9,.LC54@l(9)
	lis 11,.LC53@ha
	lfs 3,0(9)
	la 11,.LC53@l(11)
	lfs 2,0(11)
	bl tv
	mr 11,3
	lfs 11,4(31)
	lis 9,gi@ha
	lfs 0,0(11)
	la 30,gi@l(9)
	addi 3,1,8
	lfs 12,8(31)
	mr 4,29
	addi 5,31,188
	lfs 13,12(31)
	addi 6,31,200
	addi 7,1,72
	fadds 11,11,0
	lwz 10,48(30)
	mr 8,31
	li 9,3
	mtlr 10
	stfs 11,72(1)
	lfs 0,4(11)
	fadds 12,12,0
	stfs 12,76(1)
	lfs 0,8(11)
	fadds 13,13,0
	stfs 13,80(1)
	blrl
	lwz 0,12(1)
	cmpwi 0,0,0
	bc 12,2,.L378
	mr 3,29
	lwz 29,280(31)
	bl vtos
	mr 5,3
	lwz 0,4(30)
	mr 4,29
	lis 3,.LC49@ha
	la 3,.LC49@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L375
.L378:
	lfs 12,20(1)
	mr 3,31
	lfs 0,24(1)
	lfs 13,28(1)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	lwz 0,72(30)
	mtlr 0
	blrl
	lwz 0,268(31)
	cmpwi 0,0,0
	bc 4,2,.L375
	lis 11,level+4@ha
	lis 10,.LC50@ha
	lfs 0,level+4@l(11)
	lis 9,CTFFlagThink@ha
	lfd 13,.LC50@l(10)
	la 9,CTFFlagThink@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L375:
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe8:
	.size	 CTFFlagSetup,.Lfe8-CTFFlagSetup
	.section	".rodata"
	.align 2
.LC55:
	.string	"players/male/flag1.md2"
	.align 2
.LC56:
	.string	"players/male/flag2.md2"
	.section	".text"
	.align 2
	.globl CTFEffects
	.type	 CTFEffects,@function
CTFEffects:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,480(31)
	lwz 9,64(31)
	cmpwi 0,0,0
	rlwinm 8,9,0,12,13
	stw 8,64(31)
	bc 4,1,.L381
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 0,flag1_item@l(9)
	la 7,itemlist@l(11)
	lis 10,0x286b
	ori 10,10,51739
	lwz 11,84(31)
	subf 0,7,0
	mullw 0,0,10
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L382
	oris 0,8,0x4
	stw 0,64(31)
.L382:
	lis 9,flag2_item@ha
	lwz 11,84(31)
	lwz 0,flag2_item@l(9)
	addi 11,11,740
	subf 0,7,0
	mullw 0,0,10
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L383
	lwz 0,64(31)
	oris 0,0,0x8
	stw 0,64(31)
.L383:
	lwz 0,932(31)
	cmpwi 0,0,0
	bc 12,2,.L381
	lwz 0,64(31)
	oris 0,0,0xc
	stw 0,64(31)
.L381:
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 10,84(31)
	lwz 0,flag1_item@l(9)
	la 8,itemlist@l(11)
	lis 11,0x286b
	addi 10,10,740
	ori 11,11,51739
	subf 0,8,0
	mullw 0,0,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L385
	lis 9,gi+32@ha
	lis 3,.LC55@ha
	lwz 0,gi+32@l(9)
	la 3,.LC55@l(3)
	b .L389
.L385:
	lis 9,flag2_item@ha
	lwz 0,flag2_item@l(9)
	subf 0,8,0
	mullw 0,0,11
	rlwinm 0,0,0,0,29
	lwzx 10,10,0
	cmpwi 0,10,0
	bc 12,2,.L387
	lis 9,gi+32@ha
	lis 3,.LC56@ha
	lwz 0,gi+32@l(9)
	la 3,.LC56@l(3)
.L389:
	mtlr 0
	blrl
	stw 3,48(31)
	b .L386
.L387:
	stw 10,48(31)
.L386:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe9:
	.size	 CTFEffects,.Lfe9-CTFEffects
	.section	".rodata"
	.align 2
.LC57:
	.string	"item_flag"
	.align 2
.LC58:
	.string	"Your flag is at the base\n"
	.align 2
.LC59:
	.string	"Your flag is being carried by %s\n"
	.align 2
.LC60:
	.string	"Your flag is corrupt\n"
	.align 2
.LC61:
	.string	"This map doesn't have the %s\n"
	.align 2
.LC62:
	.long 0x3f800000
	.align 3
.LC63:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Flag_StatusReport
	.type	 Flag_StatusReport,@function
Flag_StatusReport:
	stwu 1,-80(1)
	mflr 0
	stmw 21,36(1)
	stw 0,84(1)
	mr 28,3
	lis 5,.LC57@ha
	la 5,.LC57@l(5)
	li 3,0
	li 4,280
	bl G_Find
	lwz 9,84(28)
	mr 26,3
	cmpwi 0,9,0
	bc 12,2,.L390
	lwz 0,88(28)
	cmpwi 0,0,0
	bc 12,2,.L390
	lwz 0,1820(9)
	cmpwi 0,0,0
	bc 12,2,.L390
	cmpwi 0,26,0
	bc 4,2,.L390
	cmpwi 0,0,1
	bc 4,2,.L398
	lis 5,.LC7@ha
	li 3,0
	la 5,.LC7@l(5)
	b .L428
.L398:
	cmpwi 0,0,2
	bc 4,2,.L399
	lis 5,.LC8@ha
	li 3,0
	la 5,.LC8@l(5)
.L428:
	li 4,280
	bl G_Find
	mr 26,3
.L399:
	lis 9,maxclients@ha
	lis 8,.LC62@ha
	lwz 11,maxclients@l(9)
	la 8,.LC62@l(8)
	li 23,1
	lfs 13,0(8)
	lis 21,maxclients@ha
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L390
	lis 22,gi@ha
	li 24,1116
	la 25,gi@l(22)
.L404:
	lis 9,g_edicts@ha
	lwz 0,g_edicts@l(9)
	add. 29,0,24
	bc 12,2,.L403
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L403
	cmpwi 0,26,0
	bc 12,2,.L406
	lwz 0,284(26)
	andis. 9,0,1
	bc 12,2,.L407
	lis 9,level+752@ha
	la 4,level+752@l(9)
	cmpwi 0,4,0
	bc 4,2,.L429
	lwz 9,8(25)
	mr 3,28
	li 4,2
	li 5,0
	b .L430
.L407:
	lwz 3,280(26)
	lis 31,0x286b
	ori 31,31,51739
	bl FindItemByClassname
	lis 9,itemlist@ha
	lwz 10,84(29)
	la 27,itemlist@l(9)
	lhz 11,284(26)
	subf 3,27,3
	addi 30,10,740
	mullw 3,3,31
	xori 11,11,1
	rlwinm 11,11,0,31,31
	rlwinm 3,3,0,0,29
	lwzx 0,30,3
	subfic 8,0,0
	adde 0,8,0
	and. 9,11,0
	bc 12,2,.L411
	lis 9,level+624@ha
	la 4,level+624@l(9)
	cmpwi 0,4,0
	bc 4,2,.L429
	lwz 9,8(25)
	lis 5,.LC58@ha
	mr 3,28
	la 5,.LC58@l(5)
	b .L431
.L411:
	lwz 3,280(26)
	bl FindItemByClassname
	subf 3,27,3
	mullw 3,3,31
	rlwinm 3,3,0,0,29
	lwzx 0,30,3
	cmpwi 0,0,0
	bc 12,2,.L415
	lis 9,level+688@ha
	la 4,level+688@l(9)
	cmpwi 0,4,0
	bc 4,2,.L429
	lwz 6,84(29)
	lis 5,.LC59@ha
	mr 3,28
	lwz 9,8(25)
	la 5,.LC59@l(5)
	li 4,2
	addi 6,6,700
	mtlr 9
	crxor 6,6,6
	blrl
	b .L403
.L415:
	lis 9,level+816@ha
	la 4,level+816@l(9)
	cmpwi 0,4,0
	bc 12,2,.L419
.L429:
	mr 3,28
	bl Print_Msg
	b .L403
.L419:
	lwz 9,8(25)
	lis 5,.LC60@ha
	mr 3,28
	la 5,.LC60@l(5)
.L431:
	li 4,2
.L430:
	mtlr 9
	crxor 6,6,6
	blrl
	b .L403
.L406:
	lwz 9,84(28)
	la 11,gi@l(22)
	lwz 0,1820(9)
	cmpwi 0,0,1
	bc 4,2,.L422
	lis 9,.LC17@ha
	la 6,.LC17@l(9)
	b .L423
.L422:
	cmpwi 0,0,2
	bc 4,2,.L425
	lis 9,.LC18@ha
	la 6,.LC18@l(9)
	b .L423
.L425:
	lis 9,.LC19@ha
	la 6,.LC19@l(9)
.L423:
	lwz 0,8(11)
	lis 5,.LC61@ha
	mr 3,28
	la 5,.LC61@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L403:
	addi 23,23,1
	lwz 10,maxclients@l(21)
	xoris 0,23,0x8000
	lis 11,0x4330
	stw 0,28(1)
	lis 8,.LC63@ha
	addi 24,24,1116
	la 8,.LC63@l(8)
	stw 11,24(1)
	lfd 13,0(8)
	lfd 0,24(1)
	lfs 12,20(10)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L404
.L390:
	lwz 0,84(1)
	mtlr 0
	lmw 21,36(1)
	la 1,80(1)
	blr
.Lfe10:
	.size	 Flag_StatusReport,.Lfe10-Flag_StatusReport
	.section	".rodata"
	.align 2
.LC64:
	.string	"%s lost the %s!\n"
	.align 2
.LC65:
	.string	"%s lost the Flag!\n"
	.align 2
.LC66:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl CTFDeadDropFlag
	.type	 CTFDeadDropFlag,@function
CTFDeadDropFlag:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	li 29,0
	lwz 30,84(31)
	lwz 0,1820(30)
	cmpwi 0,0,0
	bc 12,2,.L432
	cmpwi 0,0,1
	bc 4,2,.L435
	lis 9,.LC18@ha
	la 3,.LC18@l(9)
	b .L436
.L435:
	cmpwi 0,0,2
	bc 4,2,.L438
	lis 9,.LC17@ha
	la 3,.LC17@l(9)
	b .L436
.L438:
	lis 9,.LC19@ha
	la 3,.LC19@l(9)
.L436:
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,30,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,11,3
	cmpwi 0,0,0
	bc 12,2,.L434
	lwz 0,932(31)
	cmpwi 0,0,0
	bc 4,2,.L440
	lwz 9,84(31)
	lwz 0,1820(9)
	cmpwi 0,0,1
	bc 4,2,.L441
	lis 9,.LC18@ha
	la 3,.LC18@l(9)
	b .L442
.L441:
	cmpwi 0,0,2
	bc 4,2,.L444
	lis 9,.LC17@ha
	la 3,.LC17@l(9)
	b .L442
.L444:
	lis 9,.LC19@ha
	la 3,.LC19@l(9)
.L442:
	bl FindItem
	mr 4,3
	mr 3,31
	bl Drop_Item
	lwz 9,84(31)
	mr 29,3
	lwz 0,1820(9)
	cmpwi 0,0,1
	bc 4,2,.L446
	lis 9,.LC18@ha
	la 3,.LC18@l(9)
	b .L447
.L446:
	cmpwi 0,0,2
	bc 4,2,.L449
	lis 9,.LC17@ha
	la 3,.LC17@l(9)
	b .L447
.L449:
	lis 9,.LC19@ha
	la 3,.LC19@l(9)
.L447:
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	lis 9,gi@ha
	li 10,0
	la 8,gi@l(9)
	rlwinm 3,3,0,0,29
	stwx 10,11,3
	lwz 9,84(31)
	lwz 0,1820(9)
	addi 5,9,700
	cmpwi 0,0,1
	bc 4,2,.L451
	lis 9,.LC18@ha
	la 6,.LC18@l(9)
	b .L452
.L451:
	cmpwi 0,0,2
	bc 4,2,.L454
	lis 9,.LC17@ha
	la 6,.LC17@l(9)
	b .L452
.L454:
	lis 9,.LC19@ha
	la 6,.LC19@l(9)
.L452:
	lwz 0,0(8)
	lis 4,.LC64@ha
	li 3,2
	la 4,.LC64@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L434
.L440:
	lis 3,.LC19@ha
	la 3,.LC19@l(3)
	bl FindItem
	mr 4,3
	mr 3,31
	bl Drop_Item
	li 0,0
	lis 9,gi@ha
	lwz 5,84(31)
	stw 0,932(31)
	mr 29,3
	lis 4,.LC65@ha
	lwz 0,gi@l(9)
	la 4,.LC65@l(4)
	addi 5,5,700
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L434:
	cmpwi 0,29,0
	bc 12,2,.L432
	lis 11,CTFDropFlagThink@ha
	lis 9,.LC66@ha
	la 11,CTFDropFlagThink@l(11)
	la 9,.LC66@l(9)
	lis 10,level+4@ha
	stw 11,436(29)
	lfs 0,level+4@l(10)
	lfs 13,0(9)
	lis 9,CTFDropFlagTouch@ha
	la 9,CTFDropFlagTouch@l(9)
	fadds 0,0,13
	stw 9,444(29)
	stfs 0,428(29)
.L432:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 CTFDeadDropFlag,.Lfe11-CTFDeadDropFlag
	.section	".rodata"
	.align 2
.LC67:
	.string	"%s dropped the %s!\n"
	.align 2
.LC68:
	.string	"%s dropped the Flag!\n"
	.align 2
.LC69:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl RipDropFlag
	.type	 RipDropFlag,@function
RipDropFlag:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 11,ripflags@ha
	lwz 10,ripflags@l(11)
	mr 31,3
	mr 30,4
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	andi. 0,9,2
	bc 12,2,.L458
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,932(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,30
	cmpwi 0,11,0
	mullw 9,9,0
	srawi 29,9,2
	bc 4,2,.L460
	lwz 11,84(31)
	lis 9,gi@ha
	la 10,gi@l(9)
	lwz 0,1820(11)
	addi 5,11,700
	cmpwi 0,0,1
	bc 4,2,.L461
	lis 9,.LC18@ha
	la 6,.LC18@l(9)
	b .L462
.L461:
	cmpwi 0,0,2
	bc 4,2,.L464
	lis 9,.LC17@ha
	la 6,.LC17@l(9)
	b .L462
.L464:
	lis 9,.LC19@ha
	la 6,.LC19@l(9)
.L462:
	lwz 0,0(10)
	lis 4,.LC67@ha
	li 3,2
	la 4,.LC67@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L466
.L460:
	lis 9,gi@ha
	lwz 5,84(31)
	lis 4,.LC68@ha
	lwz 0,gi@l(9)
	la 4,.LC68@l(4)
	li 3,2
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L466:
	mr 4,30
	mr 3,31
	bl Drop_Item
	lwz 9,84(31)
	mr. 3,3
	li 10,0
	slwi 0,29,2
	addi 9,9,740
	stwx 10,9,0
	bc 12,2,.L458
	lis 11,CTFDropFlagThink@ha
	stw 10,932(31)
	lis 9,.LC69@ha
	la 11,CTFDropFlagThink@l(11)
	la 9,.LC69@l(9)
	lis 10,level+4@ha
	stw 11,436(3)
	lfs 0,level+4@l(10)
	lfs 13,0(9)
	lis 9,CTFDropFlagTouch@ha
	la 9,CTFDropFlagTouch@l(9)
	fadds 0,0,13
	stw 9,444(3)
	stfs 0,428(3)
.L458:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe12:
	.size	 RipDropFlag,.Lfe12-RipDropFlag
	.section	".rodata"
	.align 2
.LC70:
	.string	"if 27 xv 8 yv 8 pic 27 endif xv 40 yv 28 string \"%4d/%-3d\" xv 98 yv 12 num 2 30 if 28 xv 168 yv 8 pic 28 endif xv 200 yv 28 string \"%4d/%-3d\" xv 256 yv 12 num 2 31 "
	.align 2
.LC71:
	.string	"ctf 0 %d %d %d %d "
	.align 2
.LC72:
	.string	"ctf 160 %d %d %d %d "
	.align 2
.LC73:
	.string	"xv 0 yv %d string2 \"Spectators\" "
	.align 2
.LC74:
	.string	"ctf %d %d %d %d %d "
	.align 2
.LC75:
	.string	"xv 8 yv %d string \"..and %d more\" "
	.align 2
.LC76:
	.string	"xv 168 yv %d string \"..and %d more\" "
	.align 2
.LC77:
	.long 0x0
	.align 3
.LC78:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFScoreboardMessage
	.type	 CTFScoreboardMessage,@function
CTFScoreboardMessage:
	stwu 1,-6656(1)
	mflr 0
	mfcr 12
	stmw 14,6584(1)
	stw 0,6660(1)
	stw 12,6580(1)
	lwz 9,84(3)
	lwz 0,1916(9)
	cmpwi 0,0,0
	bc 12,2,.L469
	lis 9,game@ha
	li 0,0
	la 8,game@l(9)
	addi 11,1,6536
	lwz 10,1544(8)
	li 26,0
	li 24,0
	stw 0,4(11)
	li 25,0
	addi 9,1,6544
	stw 0,6536(1)
	cmpw 0,24,10
	mr 17,11
	stw 26,4(9)
	mr 15,9
	addi 21,1,1032
	stw 26,6544(1)
	bc 4,0,.L471
	lis 9,g_edicts@ha
	mr 20,8
	lwz 18,g_edicts@l(9)
	mr 12,17
	mr 19,15
	addi 31,1,4488
	mr 16,17
.L473:
	mulli 9,24,1116
	addi 22,24,1
	add 10,9,18
	lwz 0,1204(10)
	cmpwi 0,0,0
	bc 12,2,.L472
	mulli 9,24,2288
	lwz 0,1028(20)
	mr 8,9
	add 9,9,0
	lwz 0,1820(9)
	cmpwi 0,0,2
	bc 4,2,.L475
	li 10,0
	b .L476
.L475:
	cmpwi 0,0,1
	bc 4,2,.L472
	li 10,1
.L476:
	slwi 0,10,2
	lwz 9,1028(20)
	li 30,0
	lwzx 11,12,0
	mr 3,0
	slwi 6,10,10
	add 9,8,9
	addi 7,1,4488
	cmpw 0,30,11
	lwz 29,1816(9)
	addi 4,1,2440
	addi 22,24,1
	bc 4,0,.L480
	lwzx 0,31,6
	cmpw 0,29,0
	bc 12,1,.L480
	lwzx 11,3,16
	add 9,6,7
.L481:
	addi 30,30,1
	cmpw 0,30,11
	bc 4,0,.L480
	lwzu 0,4(9)
	cmpw 0,29,0
	bc 4,1,.L481
.L480:
	lwzx 27,3,12
	slwi 23,30,2
	cmpw 0,27,30
	bc 4,1,.L486
	addi 11,4,-4
	slwi 9,27,2
	add 11,6,11
	addi 0,7,-4
	add 0,6,0
	add 10,9,11
	mr 28,4
	add 8,9,0
	add 11,9,6
	mr 5,7
.L488:
	lwz 9,0(10)
	addi 27,27,-1
	cmpw 0,27,30
	addi 10,10,-4
	stwx 9,11,28
	lwz 0,0(8)
	addi 8,8,-4
	stwx 0,11,5
	addi 11,11,-4
	bc 12,1,.L488
.L486:
	add 0,23,6
	stwx 24,4,0
	stwx 29,7,0
	lwzx 9,3,19
	lwzx 11,3,12
	add 9,9,29
	addi 11,11,1
	stwx 9,3,19
	stwx 11,3,12
.L472:
	lwz 0,1544(20)
	mr 24,22
	cmpw 0,24,0
	bc 12,0,.L473
.L471:
	li 0,0
	lwz 7,4(15)
	lis 4,.LC70@ha
	lwz 8,4(17)
	la 4,.LC70@l(4)
	mr 3,21
	lwz 5,6544(1)
	li 24,0
	lwz 6,6536(1)
	stb 0,1032(1)
	crxor 6,6,6
	bl sprintf
	mr 3,21
	bl strlen
	lwz 0,6536(1)
	mr 23,3
	b .L522
.L495:
	lwz 9,6536(1)
	li 0,0
	stb 0,8(1)
	cmpw 0,24,9
	bc 4,0,.L496
	addi 29,1,2440
	slwi 28,24,2
	lwzx 0,29,28
	lis 9,game+1028@ha
	addi 3,1,8
	lwz 11,game+1028@l(9)
	mr 30,3
	subfic 27,23,1000
	mulli 0,0,2288
	add 31,11,0
	bl strlen
	lwz 9,184(31)
	slwi 5,24,3
	lis 4,.LC71@ha
	lwzx 6,29,28
	la 4,.LC71@l(4)
	addi 5,5,42
	cmpwi 7,9,1000
	lwz 7,1816(31)
	add 3,30,3
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 8,0,0
	and 9,9,0
	andi. 8,8,999
	or 8,9,8
	crxor 6,6,6
	bl sprintf
	mr 3,30
	bl strlen
	cmplw 0,27,3
	bc 4,1,.L496
	mr 4,30
	mr 3,21
	bl strcat
	mr 25,24
	mr 3,21
	bl strlen
	mr 23,3
.L496:
	lwz 0,4(17)
	cmpw 0,24,0
	bc 4,0,.L493
	addi 29,1,3464
	slwi 28,24,2
	lwzx 0,29,28
	lis 9,game+1028@ha
	addi 3,1,8
	lwz 11,game+1028@l(9)
	mr 30,3
	subfic 27,23,1000
	mulli 0,0,2288
	add 31,11,0
	bl strlen
	lwz 9,184(31)
	slwi 5,24,3
	lis 4,.LC72@ha
	lwzx 6,29,28
	la 4,.LC72@l(4)
	addi 5,5,42
	cmpwi 7,9,1000
	lwz 7,1816(31)
	add 3,30,3
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 8,0,0
	and 9,9,0
	andi. 8,8,999
	or 8,9,8
	crxor 6,6,6
	bl sprintf
	mr 3,30
	bl strlen
	cmplw 0,27,3
	bc 4,1,.L493
	mr 4,30
	mr 3,21
	bl strcat
	mr 26,24
	mr 3,21
	bl strlen
	mr 23,3
.L493:
	addi 24,24,1
	cmpwi 0,24,15
	bc 12,1,.L492
	lwz 0,6536(1)
.L522:
	cmpw 0,24,0
	bc 12,0,.L495
	lwz 0,4(17)
	cmpw 0,24,0
	bc 12,0,.L495
.L492:
	cmpw 7,25,26
	subfic 0,23,1000
	cmpwi 0,0,50
	li 18,0
	li 27,0
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 11,25,0
	and 0,26,0
	or 30,0,11
	slwi 9,30,3
	addi 30,9,58
	bc 4,1,.L505
	lis 9,maxclients@ha
	lis 10,.LC77@ha
	lwz 11,maxclients@l(9)
	la 10,.LC77@l(10)
	li 24,0
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L505
	lis 9,game@ha
	lis 14,g_edicts@ha
	la 15,game@l(9)
	mr 22,21
	lis 16,0x4330
	li 19,0
	li 20,1116
.L509:
	lwz 0,g_edicts@l(14)
	lwz 11,1028(15)
	add 10,0,20
	lwz 9,88(10)
	add 31,11,19
	cmpwi 0,9,0
	bc 12,2,.L508
	lwz 0,248(10)
	cmpwi 0,0,0
	bc 4,2,.L508
	lwz 9,84(10)
	lwz 0,1820(9)
	cmpwi 0,0,0
	bc 4,2,.L508
	cmpwi 0,27,0
	bc 4,2,.L512
	lis 4,.LC73@ha
	mr 5,30
	addi 3,1,8
	la 4,.LC73@l(4)
	crxor 6,6,6
	bl sprintf
	li 27,1
	addi 30,30,8
	addi 4,1,8
	mr 3,22
	bl strcat
	mr 3,22
	bl strlen
	mr 23,3
.L512:
	addi 3,1,8
	subfic 29,23,1000
	mr 28,3
	bl strlen
	lwz 11,184(31)
	rlwinm 5,18,0,31,31
	lis 4,.LC74@ha
	cmpwi 4,5,0
	lwz 8,1816(31)
	la 4,.LC74@l(4)
	cmpwi 7,11,1000
	neg 5,5
	andi. 5,5,160
	mr 6,30
	mr 7,24
	add 3,28,3
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 11,11,0
	andi. 9,9,999
	or 9,11,9
	crxor 6,6,6
	bl sprintf
	mr 3,28
	bl strlen
	cmplw 0,29,3
	bc 4,1,.L516
	mr 4,28
	mr 3,22
	bl strcat
	mr 3,22
	bl strlen
	mr 23,3
.L516:
	mfcr 0
	rlwinm 0,0,19,1
	addi 9,30,8
	neg 0,0
	addi 18,18,1
	andc 9,9,0
	and 0,30,0
	or 30,0,9
.L508:
	lis 10,maxclients@ha
	addi 24,24,1
	lwz 11,maxclients@l(10)
	xoris 0,24,0x8000
	lis 10,.LC78@ha
	stw 0,6572(1)
	addi 19,19,2288
	la 10,.LC78@l(10)
	stw 16,6568(1)
	addi 20,20,1116
	lfd 12,0(10)
	lfd 0,6568(1)
	lfs 13,20(11)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L509
.L505:
	lwz 0,6536(1)
	subf 0,25,0
	cmpwi 0,0,1
	bc 4,1,.L519
	mr 3,21
	bl strlen
	lwz 6,6536(1)
	slwi 5,25,3
	lis 4,.LC75@ha
	la 4,.LC75@l(4)
	addi 5,5,50
	subf 6,25,6
	add 3,21,3
	addi 6,6,-1
	crxor 6,6,6
	bl sprintf
.L519:
	lwz 0,4(17)
	subf 0,26,0
	cmpwi 0,0,1
	bc 4,1,.L521
	mr 3,21
	bl strlen
	lwz 6,4(17)
	slwi 5,26,3
	lis 4,.LC76@ha
	la 4,.LC76@l(4)
	addi 5,5,50
	subf 6,26,6
	add 3,21,3
	addi 6,6,-1
	crxor 6,6,6
	bl sprintf
	b .L521
.L469:
	stb 0,1032(1)
	addi 21,1,1032
.L521:
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
	lwz 0,6660(1)
	lwz 12,6580(1)
	mtlr 0
	lmw 14,6584(1)
	mtcrf 8,12
	la 1,6656(1)
	blr
.Lfe13:
	.size	 CTFScoreboardMessage,.Lfe13-CTFScoreboardMessage
	.globl ctf_statusbar
	.section	".rodata"
	.align 2
.LC79:
	.ascii	"yb\t-24 if 1 xv\t0 hnum endif xv\t50 pic 0 if 2 \txv\t100 \t"
	.ascii	"anum \txv\t150 \tpic 2 endif if 4 \txv\t200 \trnum \txv\t250"
	.ascii	" \tpic 4 endif if 6 \txv\t296 \tpic 6 endif yb\t-50 if 7 \tx"
	.ascii	"v\t0 \tpic 7 \txv\t26 \tyb\t-42 \tstat_string 8 \tyb\t-50 en"
	.ascii	"dif if 9 xv 246 num 2 10 xv 296 pic 9 endif if 11 xv 148 pic"
	.ascii	" 11 endif if 24 xr -33 yt 1 pic 24 endif xr\t-50 yt 34 num 3"
	.ascii	" 14 if 16 yt 67 xr -23 pic 16 endif if 17 \tyb\t-120 \txr\t-"
	.ascii	"75 \tnum\t3\t17 \txr\t-24 \tpic\t0 endif"
	.string	" if 18 \tyb\t-48 \txr\t-75 \tnum\t3\t18 \txr\t-24 \tpic\t19 endif if 20 \tyb\t-72 \txr\t-75 \tnum\t3\t20 \txr\t-24 \tpic\t21 endif if 22 \tyb\t-96 \txr\t-75 \tnum\t3\t22 \txr\t-24 \tpic\t23 endif if 25  yb -174  xr -75  num 3\t25  xr -24  pic 26 endif if 29  yb -144  xr -19 num 1\t29 endif "
	.section	".sdata","aw"
	.align 2
	.type	 ctf_statusbar,@object
	.size	 ctf_statusbar,4
ctf_statusbar:
	.long .LC79
	.globl loc_names
	.section	".data"
	.align 2
	.type	 loc_names,@object
loc_names:
	.long .LC80
	.long 1
	.long .LC7
	.long 2
	.long .LC8
	.long 2
	.long .LC81
	.long 3
	.long .LC82
	.long 4
	.long .LC83
	.long 5
	.long .LC84
	.long 5
	.long .LC85
	.long 6
	.long .LC86
	.long 6
	.long .LC87
	.long 6
	.long .LC88
	.long 7
	.long .LC89
	.long 7
	.long .LC90
	.long 7
	.long .LC91
	.long 7
	.long .LC92
	.long 8
	.long .LC93
	.long 8
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC93:
	.string	"item_pack"
	.align 2
.LC92:
	.string	"item_bandolier"
	.align 2
.LC91:
	.string	"item_adrenaline"
	.align 2
.LC90:
	.string	"item_enviro"
	.align 2
.LC89:
	.string	"item_breather"
	.align 2
.LC88:
	.string	"item_silencer"
	.align 2
.LC87:
	.string	"item_armor_jacket"
	.align 2
.LC86:
	.string	"item_armor_combat"
	.align 2
.LC85:
	.string	"item_armor_body"
	.align 2
.LC84:
	.string	"item_power_shield"
	.align 2
.LC83:
	.string	"item_power_screen"
	.align 2
.LC82:
	.string	"item_invulnerability"
	.align 2
.LC81:
	.string	"item_quad"
	.align 2
.LC80:
	.string	"info_position"
	.size	 loc_names,136
	.align 2
.LC95:
	.string	"nowhere"
	.align 2
.LC96:
	.string	"in the water "
	.align 2
.LC97:
	.string	"above "
	.align 2
.LC98:
	.string	"below "
	.align 2
.LC99:
	.string	"near "
	.align 2
.LC100:
	.string	"the red "
	.align 2
.LC101:
	.string	"the blue "
	.align 2
.LC102:
	.string	"the "
	.align 2
.LC94:
	.long 0x4d53ed79
	.align 2
.LC103:
	.long 0x44800000
	.align 3
.LC104:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC105:
	.long 0x0
	.section	".text"
	.align 2
	.type	 CTFSay_Team_Location,@function
CTFSay_Team_Location:
	stwu 1,-128(1)
	mflr 0
	stfd 30,112(1)
	stfd 31,120(1)
	stmw 14,40(1)
	stw 0,132(1)
	lis 9,loc_names@ha
	lis 11,.LC94@ha
	la 16,loc_names@l(9)
	lfs 31,.LC94@l(11)
	mr 27,3
	lis 9,.LC103@ha
	addi 17,16,4
	la 9,.LC103@l(9)
	addi 18,27,4
	lfs 30,0(9)
	mr 25,4
	li 30,0
	li 26,0
	li 22,999
	li 15,-1
	li 21,0
	li 24,0
	addi 19,1,24
	lis 20,g_edicts@ha
	lis 14,globals@ha
.L530:
	cmpwi 0,30,0
	bc 4,2,.L533
	lwz 31,g_edicts@l(20)
	b .L534
.L605:
	mr 30,31
	b .L546
.L533:
	addi 31,30,1116
.L534:
	la 11,globals@l(14)
	lwz 9,g_edicts@l(20)
	lwz 0,72(11)
	mulli 0,0,1116
	add 9,9,0
	cmplw 0,31,9
	bc 4,0,.L547
	mr 23,11
	addi 28,31,188
	addi 30,31,200
	addi 29,31,4
.L537:
	lwz 0,-112(30)
	cmpwi 0,0,0
	bc 12,2,.L539
	li 0,3
	lis 9,.LC104@ha
	mtctr 0
	la 9,.LC104@l(9)
	mr 8,29
	lfd 10,0(9)
	mr 10,28
	mr 11,30
	li 9,0
.L611:
	lfsx 13,9,10
	lfsx 11,9,11
	lfsx 12,9,8
	lfsx 0,9,18
	fadds 13,13,11
	fmadd 13,13,10,12
	fsub 0,0,13
	frsp 0,0
	stfsx 0,9,19
	addi 9,9,4
	bdnz .L611
	addi 3,1,24
	bl VectorLength
	fcmpu 0,1,30
	bc 4,1,.L605
.L539:
	lwz 9,72(23)
	addi 31,31,1116
	addi 28,28,1116
	lwz 0,g_edicts@l(20)
	addi 30,30,1116
	addi 29,29,1116
	mulli 9,9,1116
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L537
.L547:
	li 30,0
.L546:
	cmpwi 0,30,0
	bc 12,2,.L531
	li 31,0
	lis 28,loc_names@ha
	b .L548
.L550:
	addi 31,31,1
.L548:
	slwi 0,31,3
	lwzx 4,16,0
	mr 29,0
	cmpwi 0,4,0
	bc 12,2,.L530
	lwz 3,280(30)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L550
	la 9,loc_names@l(28)
	lwzx 0,9,29
	cmpwi 0,0,0
	bc 12,2,.L530
	mr 3,30
	mr 4,27
	bl loc_CanSee
	cmpwi 7,21,0
	addic 0,3,-1
	subfe 9,0,3
	mfcr 0
	rlwinm 0,0,31,1
	and. 11,9,0
	bc 12,2,.L555
	mr 26,30
	lfs 0,4(27)
	li 11,3
	lfs 13,4(26)
	lis 9,.LC105@ha
	mtctr 11
	li 21,1
	lfs 12,8(27)
	la 9,.LC105@l(9)
	lfs 11,12(27)
	fsubs 13,13,0
	lfs 10,0(9)
	lwzx 22,17,29
	addi 9,1,8
	stfs 13,8(1)
	lfs 0,8(26)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(26)
	fsubs 13,13,11
	stfs 13,16(1)
.L610:
	lfs 0,0(9)
	addi 9,9,4
	fmadds 10,0,0,10
	bdnz .L610
	fmr 31,10
	b .L530
.L555:
	cmpwi 0,3,0
	addic 0,21,-1
	subfe 9,0,21
	mcrf 6,0
	mfcr 0
	rlwinm 0,0,3,1
	and. 11,9,0
	bc 4,2,.L530
	bc 12,30,.L563
	lwzx 0,17,29
	cmpw 0,22,0
	bc 12,0,.L530
.L563:
	lfs 0,4(27)
	li 11,3
	lis 9,.LC105@ha
	lfs 13,4(30)
	mtctr 11
	la 9,.LC105@l(9)
	lfs 12,8(27)
	lfs 11,12(27)
	fsubs 13,13,0
	lfs 10,0(9)
	addi 9,1,8
	stfs 13,8(1)
	lfs 0,8(30)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(30)
	fsubs 13,13,11
	stfs 13,16(1)
.L609:
	lfs 0,0(9)
	addi 9,9,4
	fmadds 10,0,0,10
	bdnz .L609
	fmr 0,10
	fcmpu 0,0,31
	bc 12,0,.L571
	bc 12,26,.L530
	lwzx 0,17,29
	cmpw 0,0,22
	bc 4,0,.L530
.L571:
	mr 26,30
	fmr 31,0
	mr 4,27
	mr 3,26
	mr 22,31
	bl loc_CanSee
	mr 21,3
	b .L530
.L531:
	cmpwi 0,26,0
	bc 4,2,.L572
	b .L612
.L606:
	li 15,1
	b .L574
.L572:
	li 30,0
	b .L573
.L575:
	cmpw 0,30,26
	bc 12,2,.L573
	lis 5,.LC7@ha
	li 3,0
	la 5,.LC7@l(5)
	li 4,280
	bl G_Find
	mr. 31,3
	bc 12,2,.L574
	lis 5,.LC8@ha
	li 3,0
	la 5,.LC8@l(5)
	li 4,280
	bl G_Find
	mr. 3,3
	bc 12,2,.L574
	lfs 0,4(31)
	li 11,3
	lis 9,.LC105@ha
	lfs 13,4(26)
	mtctr 11
	la 9,.LC105@l(9)
	addi 0,1,8
	lfs 11,0(9)
	mr 9,0
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 13,8(31)
	lfs 0,8(26)
	fsubs 0,0,13
	stfs 0,12(1)
	lfs 13,12(31)
	lfs 0,12(26)
	fsubs 0,0,13
	stfs 0,16(1)
.L608:
	lfs 0,0(9)
	addi 9,9,4
	fmadds 11,0,0,11
	bdnz .L608
	lfs 0,4(3)
	mr 9,0
	lis 11,.LC105@ha
	lfs 13,4(26)
	li 0,3
	la 11,.LC105@l(11)
	mtctr 0
	lfs 12,0(11)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 13,8(3)
	lfs 0,8(26)
	fsubs 0,0,13
	stfs 0,12(1)
	lfs 13,12(3)
	lfs 0,12(26)
	fsubs 0,0,13
	stfs 0,16(1)
.L607:
	lfs 0,0(9)
	addi 9,9,4
	fmadds 12,0,0,12
	bdnz .L607
	fcmpu 0,11,12
	bc 12,0,.L606
	bc 4,1,.L574
	li 15,2
	b .L574
.L573:
	lwz 5,280(26)
	mr 3,30
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L575
.L574:
	lwz 3,280(26)
	bl FindItemByClassname
	mr. 3,3
	bc 4,2,.L594
.L612:
	lis 9,.LC95@ha
	la 11,.LC95@l(9)
	lwz 0,.LC95@l(9)
	lwz 10,4(11)
	stw 0,0(25)
	stw 10,4(25)
	b .L529
.L594:
	lwz 0,612(27)
	cmpwi 0,0,0
	bc 12,2,.L595
	lis 11,.LC96@ha
	li 24,13
	lwz 10,.LC96@l(11)
	la 9,.LC96@l(11)
	lbz 8,12(9)
	lwz 0,4(9)
	lwz 11,8(9)
	stw 10,0(25)
	stw 0,4(25)
	stw 11,8(25)
	stb 8,12(25)
	b .L596
.L595:
	stb 0,0(25)
.L596:
	lfs 13,4(26)
	lfs 0,4(27)
	lfs 12,8(27)
	lfs 11,12(27)
	fsubs 0,0,13
	stfs 0,8(1)
	lfs 13,8(26)
	fsubs 10,12,13
	fabs 0,0
	stfs 10,12(1)
	lfs 13,12(26)
	fsubs 11,11,13
	fmr 12,11
	stfs 11,16(1)
	fabs 12,12
	fcmpu 0,12,0
	bc 4,1,.L597
	fmr 0,10
	fabs 0,0
	fcmpu 0,12,0
	bc 4,1,.L597
	lis 9,.LC105@ha
	la 9,.LC105@l(9)
	lfs 0,0(9)
	fcmpu 0,11,0
	bc 4,1,.L598
	lis 9,.LC97@ha
	add 10,25,24
	lwz 11,.LC97@l(9)
	la 9,.LC97@l(9)
	b .L613
.L598:
	lis 9,.LC98@ha
	add 10,25,24
	lwz 11,.LC98@l(9)
	la 9,.LC98@l(9)
.L613:
	lhz 0,4(9)
	stwx 11,25,24
	sth 0,4(10)
	addi 24,24,6
	b .L600
.L597:
	lis 9,.LC99@ha
	add 10,25,24
	lwz 11,.LC99@l(9)
	la 9,.LC99@l(9)
	lbz 0,4(9)
	stwx 11,25,24
	stb 0,4(10)
	addi 24,24,5
.L600:
	cmpwi 0,15,1
	bc 4,2,.L601
	lis 9,.LC100@ha
	add 10,25,24
	lwz 11,.LC100@l(9)
	la 9,.LC100@l(9)
	lwz 0,4(9)
	stwx 11,25,24
	stw 0,4(10)
	addi 24,24,8
	b .L602
.L601:
	cmpwi 0,15,2
	bc 4,2,.L603
	lis 9,.LC101@ha
	add 8,25,24
	lwz 11,.LC101@l(9)
	la 9,.LC101@l(9)
	lbz 0,8(9)
	lwz 10,4(9)
	stwx 11,25,24
	stb 0,8(8)
	addi 24,24,9
	stw 10,4(8)
	b .L602
.L603:
	lis 9,.LC102@ha
	lwz 0,.LC102@l(9)
	stwx 0,25,24
	addi 24,24,4
.L602:
	lwz 4,40(3)
	add 3,25,24
	bl strcpy
.L529:
	lwz 0,132(1)
	mtlr 0
	lmw 14,40(1)
	lfd 30,112(1)
	lfd 31,120(1)
	la 1,128(1)
	blr
.Lfe14:
	.size	 CTFSay_Team_Location,.Lfe14-CTFSay_Team_Location
	.section	".rodata"
	.align 2
.LC106:
	.string	"cells"
	.align 2
.LC107:
	.string	"%s with %i cells "
	.align 2
.LC108:
	.string	"Power Screen"
	.align 2
.LC109:
	.string	"Power Shield"
	.align 2
.LC110:
	.string	"and "
	.align 2
.LC111:
	.string	"%i units of %s"
	.align 2
.LC112:
	.string	"no armor"
	.section	".text"
	.align 2
	.type	 CTFSay_Team_Armor,@function
CTFSay_Team_Armor:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,4
	li 0,0
	mr 30,3
	stb 0,0(31)
	bl PowerArmorType
	mr. 28,3
	bc 12,2,.L615
	lis 3,.LC106@ha
	lwz 29,84(30)
	la 3,.LC106@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 29,29,3
	cmpwi 0,29,0
	bc 12,2,.L615
	mr 3,31
	bl strlen
	cmpwi 0,28,1
	add 3,31,3
	bc 4,2,.L617
	lis 9,.LC108@ha
	la 5,.LC108@l(9)
	b .L618
.L617:
	lis 9,.LC109@ha
	la 5,.LC109@l(9)
.L618:
	lis 4,.LC107@ha
	mr 6,29
	la 4,.LC107@l(4)
	crxor 6,6,6
	bl sprintf
.L615:
	mr 3,30
	bl ArmorIndex
	mr. 29,3
	bc 12,2,.L619
	mr 3,29
	bl GetItemByIndex
	mr. 28,3
	bc 12,2,.L619
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L621
	lis 4,.LC110@ha
	mr 3,31
	la 4,.LC110@l(4)
	bl strcat
.L621:
	mr 3,31
	bl strlen
	lwz 9,84(30)
	slwi 0,29,2
	lis 4,.LC111@ha
	lwz 6,40(28)
	la 4,.LC111@l(4)
	add 3,31,3
	addi 9,9,740
	lwzx 5,9,0
	crxor 6,6,6
	bl sprintf
.L619:
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 4,2,.L622
	lis 9,.LC112@ha
	lwz 10,.LC112@l(9)
	la 11,.LC112@l(9)
	lbz 0,8(11)
	lwz 9,4(11)
	stb 0,8(31)
	stw 10,0(31)
	stw 9,4(31)
.L622:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 CTFSay_Team_Armor,.Lfe15-CTFSay_Team_Armor
	.section	".rodata"
	.align 2
.LC113:
	.string	"dead"
	.align 2
.LC114:
	.string	"%i health"
	.align 2
.LC115:
	.string	", "
	.align 2
.LC116:
	.string	" and "
	.align 2
.LC117:
	.string	"no enemy"
	.align 2
.LC118:
	.long 0x3f800000
	.align 3
.LC119:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.type	 CTFSay_Team_SightEnemy,@function
CTFSay_Team_SightEnemy:
	stwu 1,-2128(1)
	mflr 0
	stmw 19,2076(1)
	stw 0,2132(1)
	lis 9,maxclients@ha
	li 26,0
	lwz 11,maxclients@l(9)
	mr 27,3
	mr 23,4
	lis 9,.LC118@ha
	stb 26,1032(1)
	li 24,1
	la 9,.LC118@l(9)
	stb 26,8(1)
	lis 19,maxclients@ha
	lfs 13,0(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L628
	lis 20,g_edicts@ha
	lis 21,0x4330
	li 25,1116
	lis 22,.LC115@ha
.L630:
	lwz 0,g_edicts@l(20)
	add 30,0,25
	lwz 9,88(30)
	xor 0,30,27
	subfic 10,0,0
	adde 0,10,0
	subfic 11,9,0
	adde 9,11,9
	or. 28,9,0
	bc 4,2,.L629
	mr 3,30
	mr 4,27
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L629
	lwz 9,84(30)
	lwz 11,84(27)
	lwz 10,1820(9)
	lwz 0,1820(11)
	cmpw 0,0,10
	bc 12,2,.L629
	lbz 0,1032(1)
	addi 31,1,1032
	cmpwi 0,0,0
	bc 12,2,.L633
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,31
	bl strlen
	add 29,29,3
	addi 29,29,3
	cmplwi 0,29,1023
	bc 12,1,.L634
	cmpwi 0,26,0
	bc 12,2,.L635
	addi 3,1,8
	la 4,.LC115@l(22)
	bl strcat
.L635:
	addi 3,1,8
	mr 4,31
	bl strcat
	stb 28,1032(1)
.L634:
	lwz 9,84(30)
	addi 26,26,1
.L633:
	mr 3,31
	addi 4,9,700
	bl strcpy
.L629:
	addi 24,24,1
	lwz 11,maxclients@l(19)
	xoris 0,24,0x8000
	lis 10,.LC119@ha
	stw 0,2068(1)
	la 10,.LC119@l(10)
	addi 25,25,1116
	stw 21,2064(1)
	lfd 13,0(10)
	lfd 0,2064(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L630
.L628:
	lbz 0,1032(1)
	cmpwi 0,0,0
	bc 12,2,.L637
	addi 31,1,1032
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,31
	bl strlen
	add 29,29,3
	addi 29,29,6
	cmplwi 0,29,1023
	bc 12,1,.L638
	cmpwi 0,26,0
	bc 12,2,.L639
	lis 4,.LC116@ha
	addi 3,1,8
	la 4,.LC116@l(4)
	bl strcat
.L639:
	mr 4,31
	addi 3,1,8
	bl strcat
.L638:
	mr 3,23
	addi 4,1,8
	bl strcpy
	b .L640
.L637:
	lis 9,.LC117@ha
	lwz 10,.LC117@l(9)
	la 11,.LC117@l(9)
	lbz 0,8(11)
	lwz 9,4(11)
	stb 0,8(23)
	stw 10,0(23)
	stw 9,4(23)
.L640:
	lwz 0,2132(1)
	mtlr 0
	lmw 19,2076(1)
	la 1,2128(1)
	blr
.Lfe16:
	.size	 CTFSay_Team_SightEnemy,.Lfe16-CTFSay_Team_SightEnemy
	.section	".rodata"
	.align 2
.LC120:
	.string	"nobody"
	.align 2
.LC121:
	.long 0x3f800000
	.align 3
.LC122:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.type	 CTFSay_Team_SightTeammate,@function
CTFSay_Team_SightTeammate:
	stwu 1,-2128(1)
	mflr 0
	stmw 19,2076(1)
	stw 0,2132(1)
	lis 9,maxclients@ha
	li 26,0
	lwz 11,maxclients@l(9)
	mr 27,3
	mr 23,4
	lis 9,.LC121@ha
	stb 26,1032(1)
	li 24,1
	la 9,.LC121@l(9)
	stb 26,8(1)
	lis 19,maxclients@ha
	lfs 13,0(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L643
	lis 20,g_edicts@ha
	lis 21,0x4330
	li 25,1116
	lis 22,.LC115@ha
.L645:
	lwz 0,g_edicts@l(20)
	add 30,0,25
	lwz 9,88(30)
	xor 0,30,27
	subfic 10,0,0
	adde 0,10,0
	subfic 11,9,0
	adde 9,11,9
	or. 28,9,0
	bc 4,2,.L644
	mr 3,30
	mr 4,27
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L644
	lwz 9,84(30)
	lwz 11,84(27)
	lwz 10,1820(9)
	lwz 0,1820(11)
	cmpw 0,0,10
	bc 4,2,.L644
	lbz 0,1032(1)
	addi 31,1,1032
	cmpwi 0,0,0
	bc 12,2,.L648
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,31
	bl strlen
	add 29,29,3
	addi 29,29,3
	cmplwi 0,29,1023
	bc 12,1,.L649
	cmpwi 0,26,0
	bc 12,2,.L650
	addi 3,1,8
	la 4,.LC115@l(22)
	bl strcat
.L650:
	addi 3,1,8
	mr 4,31
	bl strcat
	stb 28,1032(1)
.L649:
	lwz 9,84(30)
	addi 26,26,1
.L648:
	mr 3,31
	addi 4,9,700
	bl strcpy
.L644:
	addi 24,24,1
	lwz 11,maxclients@l(19)
	xoris 0,24,0x8000
	lis 10,.LC122@ha
	stw 0,2068(1)
	la 10,.LC122@l(10)
	addi 25,25,1116
	stw 21,2064(1)
	lfd 13,0(10)
	lfd 0,2064(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L645
.L643:
	lbz 0,1032(1)
	cmpwi 0,0,0
	bc 12,2,.L652
	addi 31,1,1032
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,31
	bl strlen
	add 29,29,3
	addi 29,29,6
	cmplwi 0,29,1023
	bc 12,1,.L653
	cmpwi 0,26,0
	bc 12,2,.L654
	lis 4,.LC116@ha
	addi 3,1,8
	la 4,.LC116@l(4)
	bl strcat
.L654:
	mr 4,31
	addi 3,1,8
	bl strcat
.L653:
	mr 3,23
	addi 4,1,8
	bl strcpy
	b .L655
.L652:
	lis 9,.LC120@ha
	lwz 10,.LC120@l(9)
	la 11,.LC120@l(9)
	lbz 0,6(11)
	lhz 9,4(11)
	stb 0,6(23)
	stw 10,0(23)
	sth 9,4(23)
.L655:
	lwz 0,2132(1)
	mtlr 0
	lmw 19,2076(1)
	la 1,2128(1)
	blr
.Lfe17:
	.size	 CTFSay_Team_SightTeammate,.Lfe17-CTFSay_Team_SightTeammate
	.section	".rodata"
	.align 2
.LC123:
	.string	"none"
	.align 2
.LC124:
	.string	"no one"
	.section	".text"
	.align 2
	.type	 CTFSay_Team_Sight,@function
CTFSay_Team_Sight:
	stwu 1,-2112(1)
	mflr 0
	stmw 20,2064(1)
	stw 0,2116(1)
	lis 9,game@ha
	li 26,1
	la 9,game@l(9)
	li 27,0
	lwz 0,1544(9)
	mr 25,3
	mr 23,4
	stb 27,1032(1)
	cmpw 0,26,0
	stb 27,8(1)
	bc 12,1,.L661
	mr 20,9
	lis 21,g_edicts@ha
	lis 22,.LC115@ha
	li 24,1116
.L663:
	lwz 0,g_edicts@l(21)
	add 30,0,24
	lwz 9,88(30)
	cmpwi 0,9,0
	bc 12,2,.L662
	lwz 0,184(30)
	xor 9,30,25
	subfic 11,9,0
	adde 9,11,9
	rlwinm 0,0,0,31,31
	or. 28,0,9
	bc 4,2,.L662
	mr 3,30
	mr 4,25
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L662
	lbz 0,1032(1)
	addi 31,1,1032
	cmpwi 0,0,0
	bc 12,2,.L666
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,31
	bl strlen
	add 29,29,3
	addi 29,29,3
	cmplwi 0,29,1023
	bc 12,1,.L667
	cmpwi 0,27,0
	bc 12,2,.L668
	addi 3,1,8
	la 4,.LC115@l(22)
	bl strcat
.L668:
	addi 3,1,8
	mr 4,31
	bl strcat
	stb 28,1032(1)
.L667:
	addi 27,27,1
.L666:
	lwz 4,84(30)
	mr 3,31
	addi 4,4,700
	bl strcpy
.L662:
	lwz 0,1544(20)
	addi 26,26,1
	addi 24,24,1116
	cmpw 0,26,0
	bc 4,1,.L663
.L661:
	lbz 0,1032(1)
	cmpwi 0,0,0
	bc 12,2,.L670
	addi 31,1,1032
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,31
	bl strlen
	add 29,29,3
	addi 29,29,6
	cmplwi 0,29,1023
	bc 12,1,.L671
	cmpwi 0,27,0
	bc 12,2,.L672
	lis 4,.LC116@ha
	addi 3,1,8
	la 4,.LC116@l(4)
	bl strcat
.L672:
	mr 4,31
	addi 3,1,8
	bl strcat
.L671:
	mr 3,23
	addi 4,1,8
	bl strcpy
	b .L673
.L670:
	lis 9,.LC124@ha
	lwz 10,.LC124@l(9)
	la 11,.LC124@l(9)
	lbz 0,6(11)
	lhz 9,4(11)
	stb 0,6(23)
	stw 10,0(23)
	sth 9,4(23)
.L673:
	lwz 0,2116(1)
	mtlr 0
	lmw 20,2064(1)
	la 1,2112(1)
	blr
.Lfe18:
	.size	 CTFSay_Team_Sight,.Lfe18-CTFSay_Team_Sight
	.align 2
	.globl CTFParseTeamMessage
	.type	 CTFParseTeamMessage,@function
CTFParseTeamMessage:
	stwu 1,-1072(1)
	mflr 0
	stmw 24,1040(1)
	stw 0,1076(1)
	mr 28,5
	li 31,0
	mr 25,4
	stb 31,0(28)
	mr 26,3
	lbz 0,0(25)
	mr 27,6
	cmpwi 0,0,34
	bc 4,2,.L675
	mr 3,25
	bl strlen
	add 3,3,25
	stb 31,-1(3)
	addi 25,25,1
.L675:
	lbz 9,0(25)
	mr 30,28
	cmpwi 0,9,0
	bc 12,2,.L677
	addic. 0,27,-1
	mr 24,0
	bc 4,1,.L677
.L679:
	cmpwi 0,9,37
	bc 4,2,.L681
	lbzu 10,1(25)
	cmplwi 0,10,119
	bc 12,1,.L678
	lis 11,.L713@ha
	slwi 10,10,2
	la 11,.L713@l(11)
	lis 9,.L713@ha
	lwzx 0,10,11
	la 9,.L713@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L713:
	.long .L711-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L710-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L687-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L699-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L690-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L684-.L713
	.long .L678-.L713
	.long .L708-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L696-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L702-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L687-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L699-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L690-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L684-.L713
	.long .L678-.L713
	.long .L708-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L696-.L713
	.long .L678-.L713
	.long .L678-.L713
	.long .L702-.L713
.L684:
	mr 3,26
	addi 4,1,8
	bl CTFSay_Team_Location
	b .L716
.L687:
	mr 3,26
	addi 4,1,8
	bl CTFSay_Team_Armor
	b .L716
.L690:
	lwz 5,480(26)
	addi 29,1,8
	cmpwi 0,5,0
	bc 12,1,.L691
	lis 9,.LC113@ha
	lwz 11,.LC113@l(9)
	la 9,.LC113@l(9)
	lbz 0,4(9)
	stw 11,8(1)
	stb 0,4(29)
	b .L693
.L691:
	lis 4,.LC114@ha
	mr 3,29
	la 4,.LC114@l(4)
	crxor 6,6,6
	bl sprintf
.L693:
	addi 3,1,8
	bl strlen
	mr 31,3
	subf 0,28,30
	add 0,0,31
	cmpw 0,0,27
	bc 4,0,.L678
	mr 3,30
	mr 4,29
	b .L717
.L696:
	mr 3,26
	addi 4,1,8
	bl CTFSay_Team_SightTeammate
	b .L716
.L699:
	mr 3,26
	addi 4,1,8
	bl CTFSay_Team_SightEnemy
	b .L716
.L702:
	lwz 9,84(26)
	addi 29,1,8
	lwz 9,1788(9)
	cmpwi 0,9,0
	bc 12,2,.L703
	lwz 4,40(9)
	mr 3,29
	bl strcpy
	b .L705
.L703:
	lis 9,.LC123@ha
	lwz 11,.LC123@l(9)
	la 9,.LC123@l(9)
	lbz 0,4(9)
	stw 11,8(1)
	stb 0,4(29)
.L705:
	addi 3,1,8
	bl strlen
	mr 31,3
	subf 0,28,30
	add 0,0,31
	cmpw 0,0,27
	bc 4,0,.L678
	mr 3,30
	mr 4,29
	b .L717
.L708:
	mr 3,26
	addi 4,1,8
	bl CTFSay_Team_Sight
.L716:
	addi 3,1,8
	bl strlen
	mr 31,3
	subf 0,28,30
	add 0,0,31
	cmpw 0,0,27
	bc 4,0,.L678
	mr 3,30
	addi 4,1,8
.L717:
	mr 5,31
	add 30,30,31
	crxor 6,6,6
	bl memcpy
	b .L678
.L710:
	li 0,37
	stb 0,0(30)
	b .L718
.L711:
	addi 25,25,-1
	b .L678
.L681:
	stb 9,0(30)
.L718:
	addi 30,30,1
.L678:
	lbzu 9,1(25)
	cmpwi 0,9,0
	bc 12,2,.L677
	subf 0,28,30
	cmpw 0,0,24
	bc 12,0,.L679
.L677:
	li 0,0
	stb 0,0(30)
	lwz 0,1076(1)
	mtlr 0
	lmw 24,1040(1)
	la 1,1072(1)
	blr
.Lfe19:
	.size	 CTFParseTeamMessage,.Lfe19-CTFParseTeamMessage
	.section	".rodata"
	.align 2
.LC125:
	.string	"You can't talk for %i more seconds..\n"
	.align 2
.LC126:
	.string	"(%s): %s\n"
	.align 2
.LC127:
	.long 0x3f800000
	.align 2
.LC128:
	.long 0x41f00000
	.align 2
.LC129:
	.long 0x0
	.align 3
.LC130:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFSay_Team
	.type	 CTFSay_Team,@function
CTFSay_Team:
	stwu 1,-1088(1)
	mflr 0
	stfd 31,1080(1)
	stmw 24,1048(1)
	stw 0,1092(1)
	mr 31,3
	lis 9,level@ha
	lwz 11,84(31)
	la 9,level@l(9)
	li 6,0
	lfs 12,4(9)
	lfs 0,2248(11)
	fcmpu 0,0,12
	bc 12,1,.L720
	lwz 0,2252(11)
	cmpwi 0,0,2
	bc 4,1,.L720
	lis 10,.LC127@ha
	lfs 0,2256(11)
	la 10,.LC127@l(10)
	lfs 13,0(10)
	fadds 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L720
	lis 10,.LC128@ha
	la 10,.LC128@l(10)
	lfs 0,0(10)
	fadds 0,12,0
	stfs 0,2248(11)
	lfs 13,4(9)
	lwz 9,84(31)
	stfs 13,2256(9)
	lwz 11,84(31)
	stw 6,2252(11)
.L720:
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,2248(11)
	fcmpu 0,0,13
	bc 4,1,.L722
	fsubs 0,0,13
	lis 9,gi+8@ha
	lwz 0,gi+8@l(9)
	lis 5,.LC125@ha
	mr 3,31
	la 5,.LC125@l(5)
	li 4,2
	mtlr 0
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 6,1044(1)
	crxor 6,6,6
	blrl
	b .L719
.L722:
	mr 3,31
	addi 5,1,8
	li 6,1024
	li 29,0
	bl CTFParseTeamMessage
	lis 24,maxclients@ha
	lis 9,.LC129@ha
	lis 11,maxclients@ha
	la 9,.LC129@l(9)
	lfs 13,0(9)
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L719
	lis 10,.LC130@ha
	lis 9,gi@ha
	la 10,.LC130@l(10)
	lis 25,g_edicts@ha
	lfd 31,0(10)
	la 26,gi@l(9)
	lis 27,.LC126@ha
	lis 28,0x4330
	li 30,1116
.L726:
	lwz 0,g_edicts@l(25)
	add 3,0,30
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L725
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 12,2,.L725
	lwz 6,84(31)
	lwz 9,1820(9)
	lwz 0,1820(6)
	cmpw 0,9,0
	bc 4,2,.L725
	lwz 9,8(26)
	addi 6,6,700
	li 4,3
	la 5,.LC126@l(27)
	addi 7,1,8
	mtlr 9
	crxor 6,6,6
	blrl
.L725:
	addi 29,29,1
	lwz 11,maxclients@l(24)
	xoris 0,29,0x8000
	addi 30,30,1116
	stw 0,1044(1)
	stw 28,1040(1)
	lfd 0,1040(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L726
.L719:
	lwz 0,1092(1)
	mtlr 0
	lmw 24,1048(1)
	lfd 31,1080(1)
	la 1,1088(1)
	blr
.Lfe20:
	.size	 CTFSay_Team,.Lfe20-CTFSay_Team
	.section	".rodata"
	.align 2
.LC131:
	.string	"team1"
	.align 2
.LC132:
	.string	"team2"
	.align 2
.LC133:
	.string	"a_slugs"
	.align 2
.LC134:
	.string	"a_cells"
	.align 2
.LC135:
	.string	"a_rockets"
	.align 2
.LC136:
	.string	"a_bullets"
	.align 2
.LC137:
	.string	"w_railgun"
	.align 2
.LC138:
	.long 0x0
	.section	".text"
	.align 2
	.globl RIP_GetStats
	.type	 RIP_GetStats,@function
RIP_GetStats:
	stwu 1,-4176(1)
	mflr 0
	stmw 18,4120(1)
	stw 0,4180(1)
	lis 9,game@ha
	li 0,0
	la 6,game@l(9)
	addi 7,1,4104
	lwz 8,1544(6)
	li 27,0
	li 10,0
	stw 0,4(7)
	addi 11,1,4112
	mr 31,3
	stw 0,4104(1)
	cmpw 0,27,8
	mr 18,11
	stw 10,4(11)
	stw 10,4112(1)
	bc 4,0,.L735
	lis 9,g_edicts@ha
	mr 24,7
	lwz 20,g_edicts@l(9)
	mr 19,24
	mr 23,6
	mr 22,18
	addi 21,1,2056
.L737:
	mulli 9,27,1116
	addi 25,27,1
	add 9,9,20
	lwz 0,1204(9)
	cmpwi 0,0,0
	bc 12,2,.L736
	mulli 9,27,2288
	lwz 0,1028(23)
	mr 8,9
	add 9,9,0
	lwz 0,1820(9)
	cmpwi 0,0,2
	bc 4,2,.L739
	li 10,0
	b .L740
.L739:
	cmpwi 0,0,1
	bc 4,2,.L736
	li 10,1
.L740:
	slwi 0,10,2
	lwz 9,1028(23)
	li 29,0
	lwzx 11,24,0
	mr 12,0
	slwi 5,10,10
	add 9,8,9
	addi 6,1,2056
	cmpw 0,29,11
	lwz 30,1816(9)
	addi 3,1,8
	addi 25,27,1
	bc 4,0,.L744
	lwzx 0,21,5
	cmpw 0,30,0
	bc 12,1,.L744
	lwzx 11,12,19
	add 9,5,6
.L745:
	addi 29,29,1
	cmpw 0,29,11
	bc 4,0,.L744
	lwzu 0,4(9)
	cmpw 0,30,0
	bc 4,1,.L745
.L744:
	lwzx 7,12,24
	slwi 26,29,2
	cmpw 0,7,29
	bc 4,1,.L750
	addi 11,3,-4
	slwi 9,7,2
	add 11,5,11
	addi 0,6,-4
	add 0,5,0
	add 10,9,11
	mr 28,3
	add 8,9,0
	add 11,9,5
	mr 4,6
.L752:
	lwz 9,0(10)
	addi 7,7,-1
	cmpw 0,7,29
	addi 10,10,-4
	stwx 9,11,28
	lwz 0,0(8)
	addi 8,8,-4
	stwx 0,11,4
	addi 11,11,-4
	bc 12,1,.L752
.L750:
	add 0,26,5
	stwx 27,3,0
	stwx 30,6,0
	lwzx 9,12,22
	lwzx 11,12,24
	add 9,9,30
	addi 11,11,1
	stwx 9,12,22
	stwx 11,12,24
.L736:
	lwz 0,1544(23)
	mr 27,25
	cmpw 0,27,0
	bc 12,0,.L737
.L735:
	lis 29,gi@ha
	lis 3,.LC131@ha
	la 29,gi@l(29)
	la 3,.LC131@l(3)
	lwz 9,40(29)
	li 30,0
	mtlr 9
	blrl
	lwz 9,84(31)
	lis 11,.LC132@ha
	sth 3,176(9)
	lwz 0,40(29)
	la 3,.LC132@l(11)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,174(9)
	lwz 3,1104(31)
	bl G_EntExists
	cmpwi 0,3,0
	bc 12,2,.L756
	lwz 0,892(31)
	xori 30,0,6
	subfic 9,30,0
	adde 30,9,30
.L756:
	cmpwi 0,30,0
	bc 12,2,.L755
	lwz 9,1104(31)
	lwz 11,84(31)
	lhz 0,482(9)
	sth 0,154(11)
	lwz 9,1104(31)
	lwz 11,84(31)
	lhz 0,926(9)
	sth 0,156(11)
	lwz 9,1104(31)
	lwz 11,84(31)
	lhz 0,922(9)
	sth 0,160(11)
	lwz 9,1104(31)
	lwz 11,84(31)
	lhz 0,918(9)
	sth 0,164(11)
	lwz 9,1104(31)
	lwz 11,84(31)
	lhz 0,894(9)
	sth 0,178(11)
	b .L758
.L755:
	lwz 0,892(31)
	cmpwi 0,0,9
	bc 4,2,.L759
	lis 3,.LC106@ha
	la 3,.LC106@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	add 3,11,3
	lhz 0,742(3)
	sth 0,156(11)
	b .L760
.L759:
	lwz 9,84(31)
	sth 30,156(9)
.L760:
	lwz 11,84(31)
	li 0,0
	sth 0,154(11)
	lwz 9,84(31)
	sth 0,160(9)
	lwz 11,84(31)
	sth 0,164(11)
	lwz 9,84(31)
	sth 0,178(9)
.L758:
	lis 11,.LC138@ha
	lis 9,level+200@ha
	la 11,.LC138@l(11)
	lfs 0,level+200@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,2,.L761
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L761
	lwz 0,4(18)
	lwz 11,4112(1)
	cmpw 0,11,0
	bc 4,1,.L762
	lwz 9,84(31)
	li 0,0
	sth 0,174(9)
	b .L761
.L762:
	cmpw 0,0,11
	bc 4,1,.L764
	lwz 9,84(31)
	li 0,0
	sth 0,176(9)
	b .L761
.L764:
	lwz 9,84(31)
	li 0,0
	sth 0,174(9)
	lwz 11,84(31)
	sth 0,176(11)
.L761:
	lwz 9,84(31)
	li 0,0
	sth 0,152(9)
	lwz 11,84(31)
	lwz 0,1820(11)
	cmpwi 0,0,0
	bc 12,2,.L766
	cmpwi 0,0,1
	bc 4,2,.L767
	lis 9,.LC18@ha
	la 3,.LC18@l(9)
	b .L768
.L767:
	cmpwi 0,0,2
	bc 4,2,.L770
	lis 9,.LC17@ha
	la 3,.LC17@l(9)
	b .L768
.L770:
	lis 9,.LC19@ha
	la 3,.LC19@l(9)
.L768:
	bl FindItem
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L766
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,3
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L766
	lis 9,gi+40@ha
	lwz 3,36(3)
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,152(9)
.L766:
	lwz 9,84(31)
	lhz 0,894(31)
	sth 0,168(9)
	lwz 11,892(31)
	cmpwi 0,11,6
	bc 4,2,.L774
	lis 9,gi+40@ha
	lis 3,.LC133@ha
	lwz 0,gi+40@l(9)
	la 3,.LC133@l(3)
	b .L776
.L774:
	lis 9,gi+40@ha
	lis 3,.LC134@ha
	lwz 0,gi+40@l(9)
	la 3,.LC134@l(3)
.L776:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
	lis 29,gi@ha
	lis 3,.LC135@ha
	la 29,gi@l(29)
	la 3,.LC135@l(3)
	lwz 9,40(29)
	mtlr 9
	blrl
	lwz 9,84(31)
	lis 11,.LC136@ha
	sth 3,162(9)
	lwz 9,40(29)
	la 3,.LC136@l(11)
	mtlr 9
	blrl
	lwz 9,84(31)
	lis 10,.LC137@ha
	sth 3,166(9)
	lwz 11,84(31)
	la 3,.LC137@l(10)
	lhz 0,2246(11)
	sth 0,170(11)
	lwz 0,40(29)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 9,team2_captures+2@ha
	lis 8,team1_captures+2@ha
	lhz 7,team2_captures+2@l(9)
	sth 3,172(10)
	lwz 11,84(31)
	lhz 0,team1_captures+2@l(8)
	sth 7,180(11)
	lwz 9,84(31)
	sth 0,182(9)
	lwz 0,4180(1)
	mtlr 0
	lmw 18,4120(1)
	la 1,4176(1)
	blr
.Lfe21:
	.size	 RIP_GetStats,.Lfe21-RIP_GetStats
	.section	".rodata"
	.align 2
.LC139:
	.string	"Capturelimit hit.\n"
	.align 2
.LC140:
	.long 0x0
	.align 2
.LC141:
	.long 0x41200000
	.align 2
.LC142:
	.long 0x42500000
	.align 2
.LC143:
	.long 0x41a00000
	.align 2
.LC144:
	.long 0x44820000
	.align 2
.LC145:
	.long 0x40000000
	.align 2
.LC146:
	.long 0x3f800000
	.align 3
.LC147:
	.long 0x403e0000
	.long 0x0
	.align 2
.LC148:
	.long 0x44020000
	.section	".text"
	.align 2
	.globl Concussion_Explode
	.type	 Concussion_Explode,@function
Concussion_Explode:
	stwu 1,-64(1)
	mflr 0
	stmw 29,52(1)
	stw 0,68(1)
	lis 9,.LC140@ha
	mr 31,3
	la 9,.LC140@l(9)
	lfs 13,4(31)
	lfs 0,0(9)
	lis 9,.LC141@ha
	lfs 12,8(31)
	la 9,.LC141@l(9)
	lfs 11,12(31)
	lfs 10,0(9)
	fadds 13,13,0
	fadds 12,12,0
	lwz 3,256(31)
	stfs 0,8(1)
	fadds 11,11,10
	stfs 0,12(1)
	stfs 13,4(31)
	stfs 12,8(31)
	stfs 11,12(31)
	stfs 10,16(1)
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L781
	addi 4,31,4
	li 5,2
	bl PlayerNoise
.L781:
	li 30,0
	addi 29,31,4
	b .L782
.L784:
	lwz 9,84(30)
	cmpwi 0,9,0
	bc 12,2,.L782
	lwz 11,256(31)
	lwz 10,1820(9)
	lwz 9,84(11)
	lwz 0,1820(9)
	cmpw 0,10,0
	bc 12,2,.L782
	mr 3,31
	mr 4,30
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L782
	lfs 0,4(30)
	addi 3,1,24
	lfs 13,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,24(1)
	lfs 0,8(30)
	fsubs 12,12,0
	stfs 12,28(1)
	lfs 0,12(30)
	fsubs 11,11,0
	stfs 11,32(1)
	bl VectorLength
	lis 9,.LC142@ha
	la 9,.LC142@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L788
	lis 9,.LC143@ha
	la 9,.LC143@l(9)
	lfs 1,0(9)
	b .L789
.L788:
	lis 9,.LC144@ha
	la 9,.LC144@l(9)
	lfs 12,0(9)
	lis 9,.LC145@ha
	la 9,.LC145@l(9)
	fsubs 0,1,12
	lfs 10,0(9)
	lis 9,.LC146@ha
	la 9,.LC146@l(9)
	fdivs 0,0,12
	lfs 11,0(9)
	lis 9,.LC147@ha
	la 9,.LC147@l(9)
	lfd 13,0(9)
	fsubs 0,0,10
	fdivs 0,11,0
	fadds 0,0,11
	fmul 0,0,13
	frsp 1,0
.L789:
	lis 9,.LC140@ha
	la 9,.LC140@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L790
	lis 9,.LC140@ha
	la 9,.LC140@l(9)
	lfs 1,0(9)
.L790:
	lis 9,level+4@ha
	lfs 13,952(30)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L791
	fadds 0,1,0
	b .L794
.L791:
	fadds 0,13,1
.L794:
	stfs 0,952(30)
.L782:
	lis 9,.LC148@ha
	mr 3,30
	la 9,.LC148@l(9)
	mr 4,29
	lfs 1,0(9)
	bl findradius
	mr. 30,3
	bc 4,2,.L784
	li 3,22
	mr 4,29
	li 5,1
	bl G_PointEntity
	mr 3,31
	bl G_FreeEdict
	lwz 0,68(1)
	mtlr 0
	lmw 29,52(1)
	la 1,64(1)
	blr
.Lfe22:
	.size	 Concussion_Explode,.Lfe22-Concussion_Explode
	.section	".rodata"
	.align 2
.LC150:
	.string	"models/ctf/banner/tris.md2"
	.align 2
.LC152:
	.string	"models/ctf/banner/small.md2"
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.align 2
.LC154:
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
	lwz 0,2280(31)
	cmpwi 0,0,0
	bc 4,2,.L809
	bl G_SetStats
.L809:
	lwz 9,724(31)
	li 0,0
	sth 0,146(31)
	cmpwi 0,9,0
	bc 4,1,.L811
	lis 11,.LC154@ha
	lis 9,level+200@ha
	la 11,.LC154@l(11)
	lfs 0,level+200@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L811
	lwz 0,1916(31)
	cmpwi 0,0,0
	bc 12,2,.L810
.L811:
	lhz 0,146(31)
	ori 0,0,1
	sth 0,146(31)
.L810:
	lwz 0,1920(31)
	cmpwi 0,0,0
	bc 12,2,.L812
	lwz 0,724(31)
	cmpwi 0,0,0
	bc 4,1,.L812
	lhz 0,146(31)
	ori 0,0,2
	sth 0,146(31)
.L812:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe23:
	.size	 G_SetSpectatorStats,.Lfe23-G_SetSpectatorStats
	.section	".rodata"
	.align 2
.LC155:
	.long 0x3f800000
	.align 3
.LC156:
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
	lis 11,.LC155@ha
	lis 9,maxclients@ha
	la 11,.LC155@l(11)
	mr 30,3
	lfs 13,0(11)
	li 29,1
	lis 26,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L802
	lis 9,.LC156@ha
	lis 28,g_edicts@ha
	la 9,.LC156@l(9)
	lis 27,0x4330
	lfd 31,0(9)
	li 31,1116
.L804:
	lwz 9,g_edicts@l(28)
	add 9,31,9
	lwz 0,88(9)
	lwz 3,84(9)
	cmpwi 0,0,0
	bc 12,2,.L803
	lwz 0,2280(3)
	cmpw 0,0,30
	bc 4,2,.L803
	lwz 4,84(30)
	addi 3,3,120
	li 5,64
	addi 4,4,120
	crxor 6,6,6
	bl memcpy
	lwz 3,g_edicts@l(28)
	add 3,3,31
	bl G_SetSpectatorStats
.L803:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 31,31,1116
	stw 0,12(1)
	stw 27,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L804
.L802:
	lwz 0,52(1)
	mtlr 0
	lmw 26,16(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe24:
	.size	 G_CheckChaseStats,.Lfe24-G_CheckChaseStats
	.section	".sbss","aw",@nobits
	.align 2
flag1_item:
	.space	4
	.size	 flag1_item,4
	.align 2
flag2_item:
	.space	4
	.size	 flag2_item,4
	.align 2
touchdown1:
	.space	4
	.size	 touchdown1,4
	.align 2
touchdown2:
	.space	4
	.size	 touchdown2,4
	.align 2
team1_captures:
	.space	4
	.size	 team1_captures,4
	.align 2
team1_scores:
	.space	4
	.size	 team1_scores,4
	.align 2
team2_scores:
	.space	4
	.size	 team2_scores,4
	.align 2
team2_captures:
	.space	4
	.size	 team2_captures,4
	.section	".rodata"
	.align 3
.LC157:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.type	 CTFFlagThink,@function
CTFFlagThink:
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 12,2,.L235
	lwz 9,56(3)
	addi 9,9,-172
	srawi 0,9,31
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	addi 9,9,173
	stw 9,56(3)
.L235:
	lis 9,level+4@ha
	lis 11,.LC157@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC157@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe25:
	.size	 CTFFlagThink,.Lfe25-CTFFlagThink
	.align 2
	.globl InitFragSystem
	.type	 InitFragSystem,@function
InitFragSystem:
	lis 9,level@ha
	li 10,5
	la 9,level@l(9)
	li 0,10
	li 11,0
	stw 0,960(9)
	stw 11,952(9)
	stw 10,948(9)
	stw 10,956(9)
	blr
.Lfe26:
	.size	 InitFragSystem,.Lfe26-InitFragSystem
	.align 2
	.globl CTFTeamName
	.type	 CTFTeamName,@function
CTFTeamName:
	cmpwi 0,3,1
	bc 12,2,.L37
	cmpwi 0,3,2
	bc 12,2,.L38
	b .L36
.L37:
	lis 3,.LC2@ha
	la 3,.LC2@l(3)
	blr
.L38:
	lis 3,.LC3@ha
	la 3,.LC3@l(3)
	blr
.L36:
	lis 3,.LC4@ha
	la 3,.LC4@l(3)
	blr
.Lfe27:
	.size	 CTFTeamName,.Lfe27-CTFTeamName
	.align 2
	.globl CTFOtherTeamName
	.type	 CTFOtherTeamName,@function
CTFOtherTeamName:
	cmpwi 0,3,1
	bc 12,2,.L43
	cmpwi 0,3,2
	bc 12,2,.L44
	b .L42
.L43:
	lis 3,.LC3@ha
	la 3,.LC3@l(3)
	blr
.L44:
	lis 3,.LC2@ha
	la 3,.LC2@l(3)
	blr
.L42:
	lis 3,.LC4@ha
	la 3,.LC4@l(3)
	blr
.Lfe28:
	.size	 CTFOtherTeamName,.Lfe28-CTFOtherTeamName
	.align 2
	.globl CTFOtherTeam
	.type	 CTFOtherTeam,@function
CTFOtherTeam:
	cmpwi 0,3,1
	bc 12,2,.L49
	cmpwi 0,3,2
	bc 12,2,.L50
	b .L48
.L49:
	li 3,2
	blr
.L50:
	li 3,1
	blr
.L48:
	li 3,-1
	blr
.Lfe29:
	.size	 CTFOtherTeam,.Lfe29-CTFOtherTeam
	.align 2
	.globl Your_Flag
	.type	 Your_Flag,@function
Your_Flag:
	cmpwi 0,3,1
	bc 4,2,.L117
	lis 3,.LC17@ha
	la 3,.LC17@l(3)
	blr
.L117:
	cmpwi 0,3,2
	bc 12,2,.L119
	lis 3,.LC19@ha
	la 3,.LC19@l(3)
	blr
.L119:
	lis 3,.LC18@ha
	la 3,.LC18@l(3)
	blr
.Lfe30:
	.size	 Your_Flag,.Lfe30-Your_Flag
	.align 2
	.globl Enemy_Flag
	.type	 Enemy_Flag,@function
Enemy_Flag:
	cmpwi 0,3,1
	bc 4,2,.L122
	lis 3,.LC18@ha
	la 3,.LC18@l(3)
	blr
.L122:
	cmpwi 0,3,2
	bc 12,2,.L124
	lis 3,.LC19@ha
	la 3,.LC19@l(3)
	blr
.L124:
	lis 3,.LC17@ha
	la 3,.LC17@l(3)
	blr
.Lfe31:
	.size	 Enemy_Flag,.Lfe31-Enemy_Flag
	.align 2
	.globl CTFCheckHurtCarrier
	.type	 CTFCheckHurtCarrier,@function
CTFCheckHurtCarrier:
	lwz 9,84(3)
	cmpwi 0,9,0
	bclr 12,2
	lwz 0,84(4)
	cmpwi 0,0,0
	mr 8,0
	bclr 12,2
	lwz 0,1820(9)
	cmpwi 0,0,1
	bc 4,2,.L194
	lis 9,flag2_item@ha
	lwz 10,flag2_item@l(9)
	b .L195
.L194:
	lis 9,flag1_item@ha
	lwz 10,flag1_item@l(9)
.L195:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 3,84(3)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,10
	addi 11,3,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bclr 12,2
	lwz 9,1820(3)
	lwz 0,1820(8)
	cmpw 0,9,0
	bclr 12,2
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	stfs 0,1848(8)
	blr
.Lfe32:
	.size	 CTFCheckHurtCarrier,.Lfe32-CTFCheckHurtCarrier
	.section	".rodata"
	.align 3
.LC158:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC159:
	.long 0xc1700000
	.align 2
.LC160:
	.long 0x41700000
	.section	".text"
	.align 2
	.globl SP_info_goal_team1
	.type	 SP_info_goal_team1,@function
SP_info_goal_team1:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,.LC159@ha
	mr 31,3
	la 9,.LC159@l(9)
	lfs 1,0(9)
	lis 9,.LC159@ha
	la 9,.LC159@l(9)
	lfs 2,0(9)
	lis 9,.LC159@ha
	la 9,.LC159@l(9)
	lfs 3,0(9)
	bl tv
	lfs 13,0(3)
	lis 9,.LC160@ha
	la 9,.LC160@l(9)
	lfs 1,0(9)
	stfs 13,188(31)
	lis 9,.LC160@ha
	lfs 0,4(3)
	la 9,.LC160@l(9)
	lfs 2,0(9)
	lis 9,.LC160@ha
	stfs 0,192(31)
	la 9,.LC160@l(9)
	lfs 13,8(3)
	lfs 3,0(9)
	stfs 13,196(31)
	bl tv
	lfs 0,0(3)
	lis 9,Flag_Check@ha
	lis 11,CTFFlagThink@ha
	la 9,Flag_Check@l(9)
	la 11,CTFFlagThink@l(11)
	lwz 4,268(31)
	li 0,0
	li 7,1
	stfs 0,200(31)
	li 10,7
	li 8,144
	lfs 0,4(3)
	lis 6,level+4@ha
	lis 5,.LC158@ha
	lfd 13,.LC158@l(5)
	cmpwi 0,4,0
	stfs 0,204(31)
	lfs 0,8(3)
	stw 0,60(31)
	stw 7,248(31)
	stfs 0,208(31)
	stw 10,260(31)
	stw 8,64(31)
	stw 9,444(31)
	stw 11,436(31)
	lfs 0,level+4@l(6)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bc 12,2,.L237
	lis 9,gi@ha
	mr 3,31
	la 9,gi@l(9)
	lwz 0,44(9)
	mtlr 0
	blrl
.L237:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe33:
	.size	 SP_info_goal_team1,.Lfe33-SP_info_goal_team1
	.section	".rodata"
	.align 3
.LC161:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC162:
	.long 0xc1700000
	.align 2
.LC163:
	.long 0x41700000
	.section	".text"
	.align 2
	.globl SP_info_goal_team2
	.type	 SP_info_goal_team2,@function
SP_info_goal_team2:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,.LC162@ha
	mr 31,3
	la 9,.LC162@l(9)
	lfs 1,0(9)
	lis 9,.LC162@ha
	la 9,.LC162@l(9)
	lfs 2,0(9)
	lis 9,.LC162@ha
	la 9,.LC162@l(9)
	lfs 3,0(9)
	bl tv
	lfs 13,0(3)
	lis 9,.LC163@ha
	la 9,.LC163@l(9)
	lfs 1,0(9)
	stfs 13,188(31)
	lis 9,.LC163@ha
	lfs 0,4(3)
	la 9,.LC163@l(9)
	lfs 2,0(9)
	lis 9,.LC163@ha
	stfs 0,192(31)
	la 9,.LC163@l(9)
	lfs 13,8(3)
	lfs 3,0(9)
	stfs 13,196(31)
	bl tv
	lfs 0,0(3)
	lis 9,Flag_Check@ha
	lis 11,CTFFlagThink@ha
	la 9,Flag_Check@l(9)
	la 11,CTFFlagThink@l(11)
	lwz 4,268(31)
	li 0,0
	li 7,1
	stfs 0,200(31)
	li 10,7
	li 8,144
	lfs 0,4(3)
	lis 6,level+4@ha
	lis 5,.LC161@ha
	cmpwi 0,4,0
	stfs 0,204(31)
	lfs 0,8(3)
	stw 0,60(31)
	stw 7,248(31)
	stfs 0,208(31)
	stw 10,260(31)
	stw 8,64(31)
	stw 9,444(31)
	stw 11,436(31)
	lfs 0,level+4@l(6)
	lfd 13,.LC161@l(5)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bc 12,2,.L239
	lis 9,gi@ha
	mr 3,31
	la 9,gi@l(9)
	lwz 0,44(9)
	mtlr 0
	blrl
.L239:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe34:
	.size	 SP_info_goal_team2,.Lfe34-SP_info_goal_team2
	.align 2
	.globl CTFInit
	.type	 CTFInit,@function
CTFInit:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 31,flag1_item@ha
	lwz 0,flag1_item@l(31)
	cmpwi 0,0,0
	bc 4,2,.L242
	lis 3,.LC7@ha
	la 3,.LC7@l(3)
	bl FindItemByClassname
	stw 3,flag1_item@l(31)
.L242:
	lis 31,flag2_item@ha
	lwz 0,flag2_item@l(31)
	cmpwi 0,0,0
	bc 4,2,.L243
	lis 3,.LC8@ha
	la 3,.LC8@l(3)
	bl FindItemByClassname
	stw 3,flag2_item@l(31)
.L243:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe35:
	.size	 CTFInit,.Lfe35-CTFInit
	.align 2
	.globl CTFResetFlag
	.type	 CTFResetFlag,@function
CTFResetFlag:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	cmpwi 0,3,1
	bc 12,2,.L246
	cmpwi 0,3,2
	bc 12,2,.L247
	b .L244
.L246:
	lis 9,.LC7@ha
	la 29,.LC7@l(9)
	b .L245
.L247:
	lis 9,.LC8@ha
	la 29,.LC8@l(9)
.L245:
	lis 9,gi@ha
	li 31,0
	la 28,gi@l(9)
	li 30,1
	b .L250
.L252:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L253
	mr 3,31
	bl G_FreeEdict
	b .L250
.L253:
	lwz 0,184(31)
	mr 3,31
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 9,72(28)
	mtlr 9
	blrl
	stw 30,80(31)
.L250:
	mr 3,31
	li 4,280
	mr 5,29
	bl G_Find
	mr. 31,3
	bc 4,2,.L252
.L244:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe36:
	.size	 CTFResetFlag,.Lfe36-CTFResetFlag
	.section	".rodata"
	.align 2
.LC164:
	.long 0x41e00000
	.section	".text"
	.align 2
	.globl CTFDropFlagTouch
	.type	 CTFDropFlagTouch,@function
CTFDropFlagTouch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,256(3)
	cmpw 0,4,0
	bc 4,2,.L319
	lis 9,level+4@ha
	lfs 0,428(3)
	lis 11,.LC164@ha
	lfs 13,level+4@l(9)
	la 11,.LC164@l(11)
	lfs 12,0(11)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,1,.L318
.L319:
	bl Touch_Item
.L318:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe37:
	.size	 CTFDropFlagTouch,.Lfe37-CTFDropFlagTouch
	.section	".rodata"
	.align 2
.LC165:
	.long 0x0
	.section	".text"
	.align 2
	.globl VectorLengthSqr
	.type	 VectorLengthSqr,@function
VectorLengthSqr:
	lis 9,.LC165@ha
	li 0,3
	la 9,.LC165@l(9)
	mtctr 0
	lfs 1,0(9)
.L818:
	lfs 0,0(3)
	addi 3,3,4
	fmadds 1,0,0,1
	bdnz .L818
	blr
.Lfe38:
	.size	 VectorLengthSqr,.Lfe38-VectorLengthSqr
	.align 2
	.globl sentry_valid
	.type	 sentry_valid,@function
sentry_valid:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	li 30,0
	lwz 3,1104(31)
	bl G_EntExists
	cmpwi 0,3,0
	bc 12,2,.L732
	lwz 0,892(31)
	xori 30,0,6
	subfic 9,30,0
	adde 30,9,30
.L732:
	mr 3,30
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe39:
	.size	 sentry_valid,.Lfe39-sentry_valid
	.section	".rodata"
	.align 3
.LC166:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Captures_Reached
	.type	 Captures_Reached,@function
Captures_Reached:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,team1_captures@ha
	lwz 0,team1_captures@l(9)
	lis 8,0x4330
	lis 9,.LC166@ha
	xoris 0,0,0x8000
	la 9,.LC166@l(9)
	stw 0,12(1)
	stw 8,8(1)
	lfd 12,0(9)
	lfd 0,8(1)
	lis 9,capturelimit@ha
	lwz 10,capturelimit@l(9)
	fsub 0,0,12
	lfs 13,20(10)
	frsp 0,0
	fcmpu 0,13,0
	bc 12,2,.L779
	lis 11,team2_captures@ha
	lwz 0,team2_captures@l(11)
	xoris 0,0,0x8000
	stw 0,12(1)
	stw 8,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,2,.L778
.L779:
	lis 9,gi@ha
	lis 4,.LC139@ha
	lwz 0,gi@l(9)
	la 4,.LC139@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	bl EndDMLevel
.L778:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe40:
	.size	 Captures_Reached,.Lfe40-Captures_Reached
	.section	".rodata"
	.align 3
.LC167:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_ctf_banner
	.type	 SP_misc_ctf_banner,@function
SP_misc_ctf_banner:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	li 0,0
	lis 9,gi@ha
	stw 0,248(31)
	lis 3,.LC150@ha
	stw 0,260(31)
	la 30,gi@l(9)
	la 3,.LC150@l(3)
	lwz 9,32(30)
	mtlr 9
	blrl
	lwz 0,284(31)
	stw 3,40(31)
	andi. 9,0,1
	bc 12,2,.L797
	li 0,1
	stw 0,60(31)
.L797:
	bl rand
	mr 9,3
	srawi 0,9,31
	mr 3,31
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	stw 9,56(31)
	lwz 0,72(30)
	mtlr 0
	blrl
	lis 9,misc_ctf_banner_think@ha
	lis 10,level+4@ha
	la 9,misc_ctf_banner_think@l(9)
	lis 11,.LC167@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC167@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe41:
	.size	 SP_misc_ctf_banner,.Lfe41-SP_misc_ctf_banner
	.section	".rodata"
	.align 3
.LC168:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_ctf_small_banner
	.type	 SP_misc_ctf_small_banner,@function
SP_misc_ctf_small_banner:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	li 0,0
	lis 9,gi@ha
	stw 0,248(31)
	lis 3,.LC152@ha
	stw 0,260(31)
	la 30,gi@l(9)
	la 3,.LC152@l(3)
	lwz 9,32(30)
	mtlr 9
	blrl
	lwz 0,284(31)
	stw 3,40(31)
	andi. 9,0,1
	bc 12,2,.L799
	li 0,1
	stw 0,60(31)
.L799:
	bl rand
	mr 9,3
	srawi 0,9,31
	mr 3,31
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	stw 9,56(31)
	lwz 0,72(30)
	mtlr 0
	blrl
	lis 9,misc_ctf_banner_think@ha
	lis 10,level+4@ha
	la 9,misc_ctf_banner_think@l(9)
	lis 11,.LC168@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC168@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe42:
	.size	 SP_misc_ctf_small_banner,.Lfe42-SP_misc_ctf_small_banner
	.section	".rodata"
	.align 3
.LC169:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.type	 misc_ctf_banner_think,@function
misc_ctf_banner_think:
	lwz 9,56(3)
	lis 10,level+4@ha
	lis 11,.LC169@ha
	lfd 13,.LC169@l(11)
	addi 9,9,1
	srawi 0,9,31
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	stw 9,56(3)
	lfs 0,level+4@l(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe43:
	.size	 misc_ctf_banner_think,.Lfe43-misc_ctf_banner_think
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
