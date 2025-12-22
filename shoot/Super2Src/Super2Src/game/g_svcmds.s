	.file	"g_svcmds.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"Svcmd_Test_f()\n"
	.align 2
.LC1:
	.string	"admin.sh2"
	.align 2
.LC2:
	.string	"r"
	.align 2
.LC3:
	.string	"No \"admin.sh2\" found.\n"
	.align 2
.LC4:
	.string	"queue.sh2"
	.align 2
.LC5:
	.string	"No \"queue.sh2\" found.\n"
	.section	".text"
	.align 2
	.globl readqueue
	.type	 readqueue,@function
readqueue:
	stwu 1,-544(1)
	mflr 0
	stmw 29,532(1)
	stw 0,548(1)
	lis 3,.LC4@ha
	lis 4,.LC2@ha
	la 3,.LC4@l(3)
	la 4,.LC2@l(4)
	bl fopen
	li 30,0
	li 31,0
	mr. 29,3
	bc 12,2,.L38
	b .L39
.L41:
	cmpwi 7,31,19
	lbz 9,8(1)
	addi 6,30,1
	mulli 8,30,20
	addi 7,1,8
	subfic 9,9,32
	subfe 9,9,9
	neg 9,9
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	and. 11,9,0
	bc 12,2,.L44
	lis 9,admin@ha
	la 9,admin@l(9)
	addi 9,9,20
	add 9,8,9
	add 10,31,9
.L45:
	lbzx 0,7,31
	mr 11,7
	addi 31,31,1
	stb 0,0(10)
	cmpwi 7,31,19
	lbzx 9,11,31
	addi 10,10,1
	subfic 9,9,32
	subfe 9,9,9
	neg 9,9
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	and. 11,9,0
	bc 4,2,.L45
.L44:
	lis 9,admin@ha
	addi 11,8,1
	la 9,admin@l(9)
	add 11,31,11
	addi 9,9,20
	li 0,0
	stbx 0,9,11
	rlwinm 30,6,0,0xff
	li 31,0
.L39:
	addi 3,1,8
	li 4,20
	mr 5,29
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L40
	cmplwi 0,30,39
	bc 4,1,.L41
.L40:
	lis 9,admin+820@ha
	li 0,0
	stw 0,admin+820@l(9)
	mr 3,29
	bl fclose
	b .L48
.L38:
	lis 9,gi@ha
	lis 4,.LC5@ha
	lwz 0,gi@l(9)
	la 4,.LC5@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L48:
	lwz 0,548(1)
	mtlr 0
	lmw 29,532(1)
	la 1,544(1)
	blr
.Lfe1:
	.size	 readqueue,.Lfe1-readqueue
	.section	".rodata"
	.align 2
.LC6:
	.string	"banned.sh2"
	.align 2
.LC7:
	.string	"%s"
	.section	".text"
	.align 2
	.globl readbans
	.type	 readbans,@function
readbans:
	stwu 1,-560(1)
	mflr 0
	stmw 23,524(1)
	stw 0,564(1)
	li 6,23
	lis 9,game@ha
	mtctr 6
	la 9,game@l(9)
	li 30,0
	li 31,0
	addi 9,9,1652
	li 26,0
	li 0,0
.L102:
	stw 0,0(9)
	addi 9,9,-4
	bdnz .L102
	li 11,19
	lis 9,game@ha
	mtctr 11
	la 9,game@l(9)
	li 0,0
	addi 9,9,1728
.L101:
	stw 0,0(9)
	addi 9,9,-4
	bdnz .L101
	li 6,19
	lis 9,game@ha
	mtctr 6
	la 9,game@l(9)
	li 0,0
	addi 9,9,1804
.L100:
	stw 0,0(9)
	addi 9,9,-4
	bdnz .L100
	li 11,8
	lis 9,game@ha
	mtctr 11
	la 9,game@l(9)
	li 0,0
	addi 9,9,1836
.L99:
	stw 0,0(9)
	addi 9,9,-4
	bdnz .L99
	lis 3,.LC6@ha
	lis 4,.LC2@ha
	la 3,.LC6@l(3)
	la 4,.LC2@l(4)
	bl fopen
	mr. 28,3
	bc 12,2,.L71
	lis 9,game+1564@ha
	li 29,1
	la 27,game+1564@l(9)
	addi 23,27,92
	addi 24,27,168
	addi 25,27,244
	b .L72
.L74:
	lbz 0,8(1)
	addi 9,1,8
	lis 7,gi@ha
	mr 8,9
	lis 4,.LC7@ha
	cmpwi 0,0,0
	bc 12,2,.L76
	cmpwi 0,0,47
	bc 4,2,.L78
	lbz 0,1(9)
	cmpwi 0,0,47
	bc 12,2,.L76
.L78:
	lbzx 10,8,30
	rlwinm 11,10,0,0xff
	xori 9,11,97
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,65
	subfic 6,0,0
	adde 0,6,0
	or. 6,9,0
	bc 12,2,.L79
	li 31,1
	b .L91
.L79:
	xori 9,11,112
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,80
	subfic 6,0,0
	adde 0,6,0
	or. 6,9,0
	bc 12,2,.L81
	li 31,2
	b .L91
.L81:
	xori 9,11,115
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,83
	subfic 6,0,0
	adde 0,6,0
	or. 6,9,0
	bc 12,2,.L83
	li 31,3
	b .L91
.L83:
	xori 9,11,99
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,67
	subfic 6,0,0
	adde 0,6,0
	or. 6,9,0
	bc 12,2,.L85
	li 31,4
	b .L91
.L85:
	addi 0,10,-48
	cmplwi 0,0,9
	bc 12,1,.L87
	mulli 26,26,10
	addi 0,26,-48
	add 26,0,11
	b .L80
.L87:
	cmpwi 0,26,0
	bc 4,1,.L80
	cmpwi 0,31,1
	bc 4,2,.L90
	slwi 0,26,2
	stwx 31,27,0
	b .L91
.L90:
	cmpwi 0,31,2
	bc 4,2,.L92
	slwi 0,26,2
	stwx 29,23,0
	b .L91
.L92:
	cmpwi 0,31,3
	bc 4,2,.L94
	slwi 0,26,2
	stwx 29,24,0
	b .L91
.L94:
	cmpwi 0,31,4
	bc 4,2,.L91
	slwi 0,26,2
	stwx 29,25,0
.L91:
	li 26,0
.L80:
	addi 0,30,1
	rlwinm 30,0,0,0xff
	lbzx 0,8,30
	cmpwi 0,0,0
	bc 12,2,.L76
	cmpwi 0,0,47
	bc 4,2,.L78
	addi 0,30,1
	lbzx 9,8,0
	cmpwi 0,9,47
	bc 4,2,.L78
.L76:
	lwz 0,gi@l(7)
	la 4,.LC7@l(4)
	li 3,2
	addi 5,1,8
	li 30,0
	mtlr 0
	li 26,0
	crxor 6,6,6
	blrl
.L72:
	addi 3,1,8
	li 4,500
	mr 5,28
	bl fgets
	cmpwi 0,3,0
	bc 4,2,.L74
	mr 3,28
	bl fclose
.L71:
	lwz 0,564(1)
	mtlr 0
	lmw 23,524(1)
	la 1,560(1)
	blr
.Lfe2:
	.size	 readbans,.Lfe2-readbans
	.section	".rodata"
	.align 2
.LC8:
	.string	"Banned:"
	.align 2
.LC9:
	.string	"\nActive : "
	.align 2
.LC10:
	.string	"%i "
	.align 2
.LC11:
	.string	"\nPassive: "
	.align 2
.LC12:
	.string	"\nSpecial: "
	.align 2
.LC13:
	.string	"\nCombo  : "
	.section	".text"
	.align 2
	.globl showbans
	.type	 showbans,@function
showbans:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 29,gi@ha
	lis 3,.LC8@ha
	la 29,gi@l(29)
	la 3,.LC8@l(3)
	lwz 9,4(29)
	mr 28,29
	li 31,0
	lis 30,.LC10@ha
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,4(29)
	lis 3,.LC9@ha
	la 3,.LC9@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,game@ha
	la 9,game@l(9)
	addi 29,9,1564
.L107:
	lwz 0,0(29)
	mr 4,31
	la 3,.LC10@l(30)
	addi 31,31,1
	addi 29,29,4
	cmpwi 0,0,1
	bc 4,2,.L106
	lwz 9,4(28)
	mtlr 9
	crxor 6,6,6
	blrl
.L106:
	cmpwi 0,31,22
	bc 4,1,.L107
	lis 9,gi@ha
	lis 3,.LC11@ha
	la 9,gi@l(9)
	la 3,.LC11@l(3)
	lwz 0,4(9)
	mr 28,9
	li 31,0
	lis 30,.LC10@ha
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,game@ha
	la 9,game@l(9)
	addi 29,9,1656
.L113:
	lwz 0,0(29)
	mr 4,31
	la 3,.LC10@l(30)
	addi 31,31,1
	addi 29,29,4
	cmpwi 0,0,1
	bc 4,2,.L112
	lwz 9,4(28)
	mtlr 9
	crxor 6,6,6
	blrl
.L112:
	cmpwi 0,31,18
	bc 4,1,.L113
	lis 9,gi@ha
	lis 3,.LC12@ha
	la 9,gi@l(9)
	la 3,.LC12@l(3)
	lwz 0,4(9)
	mr 28,9
	li 31,0
	lis 30,.LC10@ha
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,game@ha
	la 9,game@l(9)
	addi 29,9,1732
.L119:
	lwz 0,0(29)
	mr 4,31
	la 3,.LC10@l(30)
	addi 31,31,1
	addi 29,29,4
	cmpwi 0,0,1
	bc 4,2,.L118
	lwz 9,4(28)
	mtlr 9
	crxor 6,6,6
	blrl
.L118:
	cmpwi 0,31,18
	bc 4,1,.L119
	lis 9,gi@ha
	lis 3,.LC13@ha
	la 9,gi@l(9)
	la 3,.LC13@l(3)
	lwz 0,4(9)
	mr 28,9
	li 31,0
	lis 30,.LC10@ha
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,game@ha
	la 9,game@l(9)
	addi 29,9,1808
.L125:
	lwz 0,0(29)
	mr 4,31
	la 3,.LC10@l(30)
	addi 31,31,1
	addi 29,29,4
	cmpwi 0,0,1
	bc 4,2,.L124
	lwz 9,4(28)
	mtlr 9
	crxor 6,6,6
	blrl
.L124:
	cmpwi 0,31,7
	bc 4,1,.L125
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 showbans,.Lfe3-showbans
	.section	".rodata"
	.align 2
.LC14:
	.string	"test"
	.align 2
.LC15:
	.string	"ban"
	.align 2
.LC16:
	.string	"clear"
	.align 2
.LC17:
	.string	"reload"
	.align 2
.LC18:
	.string	"show"
	.align 2
.LC19:
	.string	"a"
	.align 2
.LC20:
	.string	"p"
	.align 2
.LC21:
	.string	"s"
	.align 2
.LC22:
	.string	"c"
	.align 2
.LC23:
	.string	"forceobs"
	.align 2
.LC24:
	.string	"Unknown server command \"%s\"\n"
	.align 2
.LC25:
	.long 0x3f800000
	.align 3
.LC26:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ServerCommand
	.type	 ServerCommand,@function
ServerCommand:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 27,36(1)
	stw 0,68(1)
	lis 9,gi@ha
	li 3,1
	la 29,gi@l(9)
	lwz 9,160(29)
	mtlr 9
	blrl
	lwz 9,160(29)
	mr 30,3
	li 3,2
	mtlr 9
	blrl
	lwz 9,160(29)
	mr 31,3
	li 3,3
	mtlr 9
	blrl
	mr 28,3
	lis 4,.LC14@ha
	la 4,.LC14@l(4)
	mr 3,30
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L137
	lwz 0,8(29)
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L139
.L137:
	lis 4,.LC15@ha
	mr 3,30
	la 4,.LC15@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L140
	lis 4,.LC16@ha
	mr 3,31
	la 4,.LC16@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L141
	li 10,23
	lis 9,game@ha
	mtctr 10
	la 9,game@l(9)
	li 0,0
	addi 9,9,1652
.L193:
	stw 0,0(9)
	addi 9,9,-4
	bdnz .L193
	li 11,19
	lis 9,game@ha
	mtctr 11
	la 9,game@l(9)
	li 0,0
	addi 9,9,1728
.L192:
	stw 0,0(9)
	addi 9,9,-4
	bdnz .L192
	li 10,19
	lis 9,game@ha
	mtctr 10
	la 9,game@l(9)
	li 0,0
	addi 9,9,1804
.L191:
	stw 0,0(9)
	addi 9,9,-4
	bdnz .L191
	li 11,8
	lis 9,game@ha
	mtctr 11
	la 9,game@l(9)
	li 0,0
	addi 9,9,1836
.L190:
	stw 0,0(9)
	addi 9,9,-4
	bdnz .L190
	b .L139
.L141:
	lis 4,.LC17@ha
	mr 3,31
	la 4,.LC17@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L164
	bl readbans
	b .L139
.L164:
	lis 4,.LC18@ha
	mr 3,31
	la 4,.LC18@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L166
	bl showbans
	b .L139
.L166:
	lis 4,.LC19@ha
	mr 3,31
	la 4,.LC19@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L168
	mr 3,28
	bl atoi
	addi 0,3,-1
	cmplwi 0,0,22
	bc 12,1,.L139
	lis 9,game@ha
	slwi 11,3,2
	la 9,game@l(9)
	addi 9,9,1564
	b .L194
.L168:
	lis 4,.LC20@ha
	mr 3,31
	la 4,.LC20@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L171
	mr 3,28
	bl atoi
	addi 0,3,-1
	cmplwi 0,0,18
	bc 12,1,.L139
	lis 9,game@ha
	slwi 11,3,2
	la 9,game@l(9)
	addi 9,9,1656
	b .L194
.L171:
	lis 4,.LC21@ha
	mr 3,31
	la 4,.LC21@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L174
	mr 3,28
	bl atoi
	addi 0,3,-1
	cmplwi 0,0,18
	bc 12,1,.L139
	lis 9,game@ha
	slwi 11,3,2
	la 9,game@l(9)
	addi 9,9,1732
	b .L194
.L174:
	lis 4,.LC22@ha
	mr 3,31
	la 4,.LC22@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L139
	mr 3,28
	bl atoi
	addi 0,3,-1
	cmplwi 0,0,7
	bc 12,1,.L139
	lis 9,game@ha
	slwi 11,3,2
	la 9,game@l(9)
	addi 9,9,1808
.L194:
	lwzx 0,9,11
	subfic 10,0,0
	adde 0,10,0
	stwx 0,9,11
	b .L139
.L140:
	lis 4,.LC23@ha
	mr 3,30
	la 4,.LC23@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L180
	lis 9,maxclients@ha
	lis 10,.LC25@ha
	lwz 11,maxclients@l(9)
	la 10,.LC25@l(10)
	li 30,1
	lfs 13,0(10)
	lis 27,maxclients@ha
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L139
	lis 11,.LC26@ha
	lis 28,g_edicts@ha
	la 11,.LC26@l(11)
	lis 29,0x4330
	lfd 31,0(11)
	li 31,936
.L183:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L186
	lwz 0,264(3)
	andi. 9,0,8192
	bc 4,2,.L186
	bl MakeObserver
.L186:
	addi 30,30,1
	lwz 11,maxclients@l(27)
	xoris 0,30,0x8000
	addi 31,31,936
	stw 0,28(1)
	stw 29,24(1)
	lfd 0,24(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L183
	b .L139
.L180:
	lwz 0,8(29)
	lis 5,.LC24@ha
	mr 6,30
	la 5,.LC24@l(5)
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L139:
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe4:
	.size	 ServerCommand,.Lfe4-ServerCommand
	.section	".rodata"
	.align 2
.LC27:
	.string	"male/"
	.align 2
.LC28:
	.string	"%s\\%s%s"
	.align 2
.LC29:
	.string	"ctf_r"
	.align 2
.LC30:
	.string	"ctf_b"
	.align 2
.LC31:
	.string	"%s\\%s"
	.section	".text"
	.align 2
	.globl CTFAssignSkin
	.type	 CTFAssignSkin,@function
CTFAssignSkin:
	stwu 1,-96(1)
	mflr 0
	stmw 28,80(1)
	stw 0,100(1)
	lis 11,g_edicts@ha
	mr 31,3
	lwz 9,g_edicts@l(11)
	lis 0,0xdcfd
	mr 28,4
	ori 0,0,53213
	lis 5,.LC7@ha
	subf 9,9,31
	addi 3,1,8
	mullw 9,9,0
	la 5,.LC7@l(5)
	li 4,64
	mr 6,28
	srawi 9,9,3
	addi 30,9,-1
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,8
	li 4,47
	bl strrchr
	mr. 3,3
	bc 12,2,.L209
	li 0,0
	stb 0,1(3)
	b .L210
.L209:
	lis 9,.LC27@ha
	la 11,.LC27@l(9)
	lwz 0,.LC27@l(9)
	lhz 10,4(11)
	stw 0,8(1)
	sth 10,12(1)
.L210:
	lwz 0,264(31)
	andis. 9,0,1024
	bc 12,2,.L211
	lwz 4,84(31)
	lis 29,gi@ha
	lis 3,.LC28@ha
	lis 6,.LC29@ha
	la 29,gi@l(29)
	addi 4,4,700
	la 3,.LC28@l(3)
	la 6,.LC29@l(6)
	b .L221
.L211:
	andis. 9,0,2048
	bc 12,2,.L213
	lwz 4,84(31)
	lis 29,gi@ha
	lis 3,.LC28@ha
	lis 6,.LC30@ha
	la 29,gi@l(29)
	addi 4,4,700
	la 3,.LC28@l(3)
	la 6,.LC30@l(6)
.L221:
	addi 5,1,8
	crxor 6,6,6
	bl va
	lwz 9,24(29)
	addi 0,30,1312
	mr 4,3
	mr 3,0
	mtlr 9
	blrl
	b .L212
.L213:
	lwz 4,84(31)
	lis 29,gi@ha
	lis 3,.LC31@ha
	la 29,gi@l(29)
	la 3,.LC31@l(3)
	addi 4,4,700
	mr 5,28
	crxor 6,6,6
	bl va
	lwz 9,24(29)
	addi 0,30,1312
	mr 4,3
	mr 3,0
	mtlr 9
	blrl
.L212:
	lwz 9,84(31)
	lwz 0,1816(9)
	xori 11,0,4
	subfic 9,11,0
	adde 11,9,11
	xori 0,0,6
	subfic 9,0,0
	adde 0,9,0
	or. 9,0,11
	bc 12,2,.L215
	lwz 0,264(31)
	andis. 9,0,1024
	bc 12,2,.L216
	li 0,1
	b .L218
.L216:
	andis. 0,0,0x800
	bc 12,2,.L218
	li 0,2
.L218:
	stw 0,60(31)
.L215:
	lwz 0,100(1)
	mtlr 0
	lmw 28,80(1)
	la 1,96(1)
	blr
.Lfe5:
	.size	 CTFAssignSkin,.Lfe5-CTFAssignSkin
	.section	".rodata"
	.align 2
.LC32:
	.string	"*** You have been assigned to the %s Team!\n"
	.align 2
.LC33:
	.string	"Good"
	.string	""
	.align 2
.LC34:
	.string	"Evil"
	.string	""
	.align 2
.LC35:
	.long 0x3f800000
	.align 3
.LC36:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFSetTeam
	.type	 CTFSetTeam,@function
CTFSetTeam:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 11,.LC35@ha
	lis 9,maxclients@ha
	la 11,.LC35@l(11)
	mr 31,3
	lfs 0,0(11)
	li 6,0
	li 8,1
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L229
	lis 9,g_edicts@ha
	fmr 12,13
	lis 7,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	addi 10,11,936
	lfd 13,0(9)
.L225:
	lwz 0,88(10)
	subfic 11,10,0
	adde 9,11,10
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 4,2,.L227
	lwz 0,264(10)
	addi 11,6,1
	andis. 9,0,1024
	mfcr 9
	rlwinm 9,9,3,1
	neg 9,9
	andc 11,11,9
	and 9,6,9
	or 6,9,11
.L227:
	addi 8,8,1
	xoris 0,8,0x8000
	addi 10,10,936
	stw 0,20(1)
	stw 7,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L225
.L229:
	lis 11,.LC35@ha
	lis 9,maxclients@ha
	la 11,.LC35@l(11)
	li 8,0
	lfs 0,0(11)
	li 7,1
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L237
	lis 9,g_edicts@ha
	fmr 12,13
	lis 5,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	addi 10,11,936
	lfd 13,0(9)
.L233:
	lwz 0,88(10)
	subfic 11,10,0
	adde 9,11,10
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 4,2,.L235
	lwz 0,264(10)
	addi 11,8,1
	andis. 9,0,2048
	mfcr 9
	rlwinm 9,9,3,1
	neg 9,9
	andc 11,11,9
	and 9,8,9
	or 8,9,11
.L235:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,936
	stw 0,20(1)
	stw 5,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L233
.L237:
	cmpw 0,6,8
	bc 4,0,.L239
	lwz 0,264(31)
	oris 0,0,0x400
	b .L247
.L239:
	cmpw 0,8,6
	bc 12,0,.L243
	bl rand
	andi. 0,3,1
	bc 12,2,.L243
	lwz 0,264(31)
	oris 0,0,0x400
	b .L247
.L243:
	lwz 0,264(31)
	oris 0,0,0x800
.L247:
	stw 0,264(31)
	lis 9,gi@ha
	lwz 0,264(31)
	la 30,gi@l(9)
	andis. 9,0,1024
	bc 12,2,.L245
	lis 3,.LC33@ha
	la 3,.LC33@l(3)
	b .L248
.L245:
	lis 3,.LC34@ha
	la 3,.LC34@l(3)
.L248:
	bl Green1
	mr 6,3
	lwz 0,8(30)
	lis 5,.LC32@ha
	mr 3,31
	la 5,.LC32@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 CTFSetTeam,.Lfe6-CTFSetTeam
	.section	".rodata"
	.align 2
.LC37:
	.string	"item_flag_team1"
	.align 2
.LC38:
	.string	"item_flag_team2"
	.section	".text"
	.align 2
	.globl CTFResetFlags
	.type	 CTFResetFlags,@function
CTFResetFlags:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,.LC37@ha
	li 31,0
	la 29,.LC37@l(9)
	b .L269
.L271:
	lwz 0,284(31)
	andis. 11,0,1
	bc 12,2,.L272
	mr 3,31
	bl G_FreeEdict
	b .L269
.L272:
	lwz 0,184(31)
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	stw 30,80(31)
.L269:
	mr 3,31
	li 4,280
	mr 5,29
	li 30,1
	bl G_Find
	mr. 31,3
	lis 9,gi+72@ha
	mr 3,31
	bc 4,2,.L271
	lis 9,.LC38@ha
	lis 11,gi@ha
	la 28,.LC38@l(9)
	la 29,gi@l(11)
	li 31,0
	b .L280
.L282:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L283
	mr 3,31
	bl G_FreeEdict
	b .L280
.L283:
	lwz 0,184(31)
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 9,72(29)
	mtlr 9
	blrl
	stw 30,80(31)
.L280:
	mr 3,31
	li 4,280
	mr 5,28
	bl G_Find
	mr. 31,3
	mr 3,31
	bc 4,2,.L282
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 CTFResetFlags,.Lfe7-CTFResetFlags
	.section	".rodata"
	.align 2
.LC39:
	.string	"Player %s without a team\n"
	.align 2
.LC40:
	.string	"Good"
	.align 2
.LC41:
	.string	"Evil"
	.align 2
.LC42:
	.string	"*** %s flag returned by %s\n"
	.align 2
.LC43:
	.string	"ctf/goodret.wav"
	.align 2
.LC44:
	.string	"ctf/evilret.wav"
	.align 2
.LC45:
	.string	"*** %s flag picked up by %s\n"
	.align 2
.LC46:
	.string	"ctf/goodpick.wav"
	.align 2
.LC47:
	.string	"ctf/evilpick.wav"
	.align 2
.LC48:
	.string	"ctf/goodcap.wav"
	.align 2
.LC49:
	.string	"ctf/evilcap.wav"
	.align 2
.LC50:
	.string	"*** %s flag captured by %s\n"
	.align 2
.LC51:
	.string	"*** %s flag stolen by %s\n"
	.align 2
.LC52:
	.string	"ctf/goodstel.wav"
	.align 2
.LC53:
	.string	"ctf/evilstel.wav"
	.align 2
.LC54:
	.long 0x3f800000
	.align 2
.LC55:
	.long 0x0
	.align 3
.LC56:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC57:
	.long 0x40140000
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFPickup_Flag
	.type	 CTFPickup_Flag,@function
CTFPickup_Flag:
	stwu 1,-144(1)
	mflr 0
	stfd 29,120(1)
	stfd 30,128(1)
	stfd 31,136(1)
	stmw 19,68(1)
	stw 0,148(1)
	addi 28,1,8
	mr 31,4
	mr 29,3
	li 4,0
	li 5,10
	mr 3,28
	crxor 6,6,6
	bl memset
	addi 3,1,24
	li 4,0
	mr 21,3
	li 5,10
	crxor 6,6,6
	bl memset
	lwz 0,264(31)
	andis. 6,0,1024
	bc 12,2,.L297
	lis 9,.LC40@ha
	lis 11,.LC41@ha
	lwz 10,.LC40@l(9)
	la 8,.LC41@l(11)
	lis 24,0x400
	la 9,.LC40@l(9)
	lwz 0,.LC41@l(11)
	lis 20,0x800
	b .L383
.L297:
	lis 9,.LC41@ha
	lis 11,.LC40@ha
	lwz 10,.LC41@l(9)
	la 8,.LC40@l(11)
	lis 24,0x800
	la 9,.LC41@l(9)
	lwz 0,.LC40@l(11)
	lis 20,0x400
.L383:
	lbz 7,4(9)
	stw 10,8(1)
	lbz 9,4(8)
	stb 7,4(28)
	stw 0,24(1)
	stb 9,4(21)
	lwz 0,284(29)
	andis. 8,0,1
	bc 12,2,.L299
	lwz 0,644(29)
	lwz 9,264(31)
	and. 10,9,0
	bc 12,2,.L300
	lwz 11,84(31)
	addi 3,1,8
	lis 28,gi@ha
	la 30,gi@l(28)
	lwz 9,3496(11)
	addi 9,9,1
	stw 9,3496(11)
	bl Green1
	lwz 9,84(31)
	mr 29,3
	addi 3,9,700
	bl Green2
	lwz 0,gi@l(28)
	mr 6,3
	lis 4,.LC42@ha
	la 4,.LC42@l(4)
	mr 5,29
	mtlr 0
	li 3,2
	crxor 6,6,6
	blrl
	lis 0,0x400
	cmpw 0,24,0
	bc 4,2,.L303
	lwz 9,36(30)
	lis 3,.LC43@ha
	la 3,.LC43@l(3)
	mtlr 9
	blrl
	lwz 0,16(30)
	lis 6,.LC54@ha
	lis 8,.LC54@ha
	lis 9,.LC55@ha
	mr 5,3
	la 6,.LC54@l(6)
	la 8,.LC54@l(8)
	mtlr 0
	la 9,.LC55@l(9)
	li 4,3
	lfs 1,0(6)
	mr 3,31
	lfs 2,0(8)
	lfs 3,0(9)
	blrl
	b .L304
.L303:
	lwz 9,36(30)
	lis 3,.LC44@ha
	la 3,.LC44@l(3)
	mtlr 9
	blrl
	lwz 0,16(30)
	lis 6,.LC54@ha
	lis 8,.LC54@ha
	lis 9,.LC55@ha
	mr 5,3
	la 6,.LC54@l(6)
	la 8,.LC54@l(8)
	mtlr 0
	la 9,.LC55@l(9)
	li 4,3
	lfs 1,0(6)
	mr 3,31
	lfs 2,0(8)
	lfs 3,0(9)
	blrl
.L304:
	lis 0,0x400
	cmpw 0,24,0
	bc 12,2,.L305
	lis 0,0x800
	cmpw 0,24,0
	bc 12,2,.L306
	b .L323
.L305:
	lis 9,.LC37@ha
	la 31,.LC37@l(9)
	b .L308
.L306:
	lis 9,.LC38@ha
	la 31,.LC38@l(9)
.L308:
	lis 9,gi@ha
	li 29,0
	la 30,gi@l(9)
	li 28,1
	b .L310
.L312:
	lwz 0,284(29)
	andis. 6,0,1
	bc 12,2,.L313
	mr 3,29
	bl G_FreeEdict
	b .L310
.L313:
	lwz 0,184(29)
	mr 3,29
	stw 28,248(29)
	rlwinm 0,0,0,0,30
	stw 0,184(29)
	lwz 9,72(30)
	mtlr 9
	blrl
	stw 28,80(29)
.L310:
	mr 3,29
	li 4,280
	mr 5,31
	bl G_Find
	mr. 29,3
	bc 4,2,.L312
	b .L323
.L300:
	oris 0,9,0x1000
	mr 3,21
	stw 0,264(31)
	lis 29,gi@ha
	bl Green1
	la 30,gi@l(29)
	lwz 9,84(31)
	mr 28,3
	addi 3,9,700
	bl Green2
	lwz 0,gi@l(29)
	mr 6,3
	lis 4,.LC45@ha
	la 4,.LC45@l(4)
	mr 5,28
	mtlr 0
	li 3,2
	crxor 6,6,6
	blrl
	lis 0,0x400
	cmpw 0,24,0
	bc 4,2,.L317
	lwz 9,36(30)
	lis 3,.LC46@ha
	la 3,.LC46@l(3)
	mtlr 9
	blrl
	lwz 0,16(30)
	lis 6,.LC54@ha
	lis 8,.LC54@ha
	lis 9,.LC55@ha
	mr 5,3
	la 6,.LC54@l(6)
	la 8,.LC54@l(8)
	b .L384
.L317:
	lwz 9,36(30)
	lis 3,.LC47@ha
	la 3,.LC47@l(3)
	mtlr 9
	blrl
	lwz 0,16(30)
	lis 6,.LC54@ha
	lis 8,.LC54@ha
	lis 9,.LC55@ha
	mr 5,3
	la 6,.LC54@l(6)
	la 8,.LC54@l(8)
	b .L386
.L299:
	lwz 9,264(31)
	lwz 0,644(29)
	and 0,9,0
	addic 6,0,-1
	subfe 11,6,0
	cmpwi 0,11,0
	bc 12,2,.L320
	andis. 8,9,4096
	bc 12,2,.L323
	andis. 10,9,1024
	bc 12,2,.L324
	lis 30,0x400
	b .L325
.L324:
	andis. 11,9,2048
	bc 12,2,.L327
	lis 30,0x800
	b .L325
.L327:
	andi. 0,9,8192
	bc 4,2,.L325
	lwz 3,84(31)
	li 30,0
	addi 3,3,700
	bl Green1
	lis 9,gi@ha
	mr 5,3
	lwz 0,gi@l(9)
	lis 4,.LC39@ha
	li 3,2
	la 4,.LC39@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L325:
	lis 9,maxclients@ha
	lis 6,.LC54@ha
	lwz 11,maxclients@l(9)
	la 6,.LC54@l(6)
	mr 8,30
	lfs 0,0(6)
	li 25,0
	li 10,1
	lfs 13,20(11)
	lis 19,maxclients@ha
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L336
	lis 9,g_edicts@ha
	fmr 12,13
	lis 7,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	addi 11,11,936
	lfd 13,0(9)
.L332:
	lwz 0,88(11)
	subfic 6,11,0
	adde 9,6,11
	subfic 6,0,0
	adde 0,6,0
	or. 6,0,9
	bc 4,2,.L334
	lwz 0,264(11)
	addi 9,25,1
	and 0,0,8
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,25,0
	or 25,0,9
.L334:
	addi 10,10,1
	xoris 0,10,0x8000
	addi 11,11,936
	stw 0,60(1)
	stw 7,56(1)
	lfd 0,56(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L332
.L336:
	lis 9,maxclients@ha
	lis 8,.LC54@ha
	lwz 11,maxclients@l(9)
	la 8,.LC54@l(8)
	li 6,0
	lfs 0,0(8)
	lfs 13,20(11)
	li 8,1
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L344
	lis 9,g_edicts@ha
	fmr 12,13
	lis 7,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	addi 10,11,936
	lfd 13,0(9)
.L340:
	lwz 0,88(10)
	subfic 11,10,0
	adde 9,11,10
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 4,2,.L342
	lwz 0,264(10)
	addi 11,6,1
	andis. 9,0,1024
	mfcr 9
	rlwinm 9,9,3,1
	neg 9,9
	andc 11,11,9
	and 9,6,9
	or 6,9,11
.L342:
	addi 8,8,1
	xoris 0,8,0x8000
	addi 10,10,936
	stw 0,60(1)
	stw 7,56(1)
	lfd 0,56(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L340
.L344:
	lis 9,maxclients@ha
	lis 10,.LC54@ha
	lwz 11,maxclients@l(9)
	la 10,.LC54@l(10)
	li 8,0
	lfs 0,0(10)
	li 7,1
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L352
	lis 9,g_edicts@ha
	fmr 12,13
	lis 5,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	addi 10,11,936
	lfd 13,0(9)
.L348:
	lwz 0,88(10)
	subfic 11,10,0
	adde 9,11,10
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 4,2,.L350
	lwz 0,264(10)
	addi 11,8,1
	andis. 9,0,2048
	mfcr 9
	rlwinm 9,9,3,1
	neg 9,9
	andc 11,11,9
	and 9,8,9
	or 8,9,11
.L350:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,936
	stw 0,60(1)
	stw 5,56(1)
	lfd 0,56(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L348
.L352:
	add 27,6,8
	srwi 0,27,31
	lis 29,0x4330
	add 0,27,0
	lis 10,.LC56@ha
	srawi 0,0,1
	la 10,.LC56@l(10)
	xoris 0,0,0x8000
	lfd 31,0(10)
	li 26,1
	stw 0,60(1)
	stw 29,56(1)
	lfd 1,56(1)
	fsub 1,1,31
	bl ceil
	lwz 7,84(31)
	lis 10,maxclients@ha
	mr 11,9
	lwz 8,maxclients@l(10)
	lis 6,.LC54@ha
	lwz 0,3496(7)
	la 6,.LC54@l(6)
	lfs 12,0(6)
	xoris 0,0,0x8000
	stw 0,60(1)
	stw 29,56(1)
	lfd 0,56(1)
	fsub 0,0,31
	fadd 0,0,1
	fctiwz 13,0
	stfd 13,56(1)
	lwz 11,60(1)
	stw 11,3496(7)
	lfs 0,20(8)
	fcmpu 0,12,0
	cror 3,2,0
	bc 4,3,.L355
	lis 8,.LC56@ha
	lis 9,.LC55@ha
	lis 10,.LC57@ha
	la 8,.LC56@l(8)
	la 9,.LC55@l(9)
	la 10,.LC57@l(10)
	lfd 31,0(8)
	lfs 29,0(9)
	lis 22,g_edicts@ha
	lis 23,ctf@ha
	lfd 30,0(10)
	lis 28,0x4330
	li 30,936
.L357:
	lwz 0,g_edicts@l(22)
	add 29,0,30
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L356
	lwz 0,264(29)
	andi. 6,0,8192
	mr 11,0
	bc 4,2,.L356
	lwz 9,ctf@l(23)
	lfs 0,20(9)
	fcmpu 0,0,29
	bc 4,2,.L361
	li 0,0
	b .L362
.L361:
	andis. 8,11,1024
	bc 12,2,.L363
	lwz 0,264(31)
	andis. 9,0,1024
	bc 12,2,.L363
	li 0,1
	b .L362
.L363:
	andis. 10,11,2048
	li 0,0
	bc 12,2,.L362
	lwz 0,264(31)
	rlwinm 0,0,5,31,31
.L362:
	cmpwi 0,0,0
	bc 12,2,.L356
	divw 0,27,25
	xoris 0,0,0x8000
	stw 0,60(1)
	stw 28,56(1)
	lfd 1,56(1)
	fsub 1,1,31
	bl ceil
	lwz 10,84(29)
	mr 11,9
	lwz 0,3496(10)
	xoris 0,0,0x8000
	stw 0,60(1)
	stw 28,56(1)
	lfd 0,56(1)
	fsub 0,0,31
	fmadd 1,1,30,0
	fctiwz 13,1
	stfd 13,56(1)
	lwz 11,60(1)
	stw 11,3496(10)
.L356:
	addi 26,26,1
	lwz 11,maxclients@l(19)
	xoris 0,26,0x8000
	addi 30,30,936
	stw 0,60(1)
	stw 28,56(1)
	lfd 0,56(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L357
.L355:
	lwz 0,264(31)
	lis 9,0x400
	cmpw 0,20,9
	rlwinm 0,0,0,4,2
	stw 0,264(31)
	bc 12,2,.L366
	lis 0,0x800
	cmpw 0,20,0
	bc 12,2,.L367
	b .L370
.L366:
	lis 9,.LC37@ha
	la 30,.LC37@l(9)
	b .L369
.L367:
	lis 9,.LC38@ha
	la 30,.LC38@l(9)
.L369:
	lis 9,gi@ha
	li 29,0
	la 27,gi@l(9)
	li 28,1
	b .L371
.L373:
	lwz 0,284(29)
	andis. 6,0,1
	bc 12,2,.L374
	mr 3,29
	bl G_FreeEdict
	b .L371
.L374:
	lwz 0,184(29)
	mr 3,29
	stw 28,248(29)
	rlwinm 0,0,0,0,30
	stw 0,184(29)
	lwz 9,72(27)
	mtlr 9
	blrl
	stw 28,80(29)
.L371:
	mr 3,29
	li 4,280
	mr 5,30
	bl G_Find
	mr. 29,3
	bc 4,2,.L373
.L370:
	lis 0,0x400
	cmpw 0,24,0
	bc 4,2,.L377
	lis 29,gi@ha
	lis 3,.LC48@ha
	la 29,gi@l(29)
	la 3,.LC48@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 6,.LC54@ha
	lis 8,.LC55@ha
	lis 9,.LC55@ha
	mr 5,3
	la 6,.LC54@l(6)
	la 8,.LC55@l(8)
	mtlr 0
	la 9,.LC55@l(9)
	li 4,3
	lfs 1,0(6)
	mr 3,31
	lfs 2,0(8)
	lfs 3,0(9)
	blrl
	b .L378
.L377:
	lis 29,gi@ha
	lis 3,.LC49@ha
	la 29,gi@l(29)
	la 3,.LC49@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 6,.LC54@ha
	lis 8,.LC55@ha
	lis 9,.LC55@ha
	mr 5,3
	la 6,.LC54@l(6)
	la 8,.LC55@l(8)
	mtlr 0
	la 9,.LC55@l(9)
	li 4,3
	lfs 1,0(6)
	mr 3,31
	lfs 2,0(8)
	lfs 3,0(9)
	blrl
.L378:
	mr 3,21
	lis 28,gi@ha
	bl Green1
	lwz 9,84(31)
	mr 29,3
	addi 3,9,700
	bl Green2
	lwz 0,gi@l(28)
	mr 6,3
	lis 4,.LC50@ha
	la 4,.LC50@l(4)
	mr 5,29
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L323:
	li 3,0
	b .L382
.L320:
	lwz 9,184(29)
	lis 28,gi@ha
	mr 3,29
	lwz 0,264(29)
	la 30,gi@l(28)
	ori 9,9,1
	stw 11,248(29)
	oris 0,0,0x8000
	stw 9,184(29)
	stw 0,264(29)
	lwz 9,72(30)
	mtlr 9
	blrl
	lwz 0,264(31)
	mr 3,21
	oris 0,0,0x1000
	stw 0,264(31)
	bl Green1
	lwz 9,84(31)
	mr 29,3
	addi 3,9,700
	bl Green2
	lwz 0,gi@l(28)
	mr 6,3
	lis 4,.LC51@ha
	la 4,.LC51@l(4)
	mr 5,29
	mtlr 0
	li 3,2
	crxor 6,6,6
	blrl
	lis 0,0x400
	cmpw 0,24,0
	bc 4,2,.L380
	lwz 9,36(30)
	lis 3,.LC52@ha
	la 3,.LC52@l(3)
	mtlr 9
	blrl
	lwz 0,16(30)
	lis 6,.LC54@ha
	lis 8,.LC55@ha
	lis 9,.LC55@ha
	mr 5,3
	la 6,.LC54@l(6)
	la 8,.LC55@l(8)
.L384:
	mtlr 0
	la 9,.LC55@l(9)
	li 4,3
	lfs 1,0(6)
	mr 3,31
	lfs 2,0(8)
	lfs 3,0(9)
	blrl
	b .L381
.L380:
	lwz 9,36(30)
	lis 3,.LC53@ha
	la 3,.LC53@l(3)
	mtlr 9
	blrl
	lwz 0,16(30)
	lis 6,.LC54@ha
	lis 8,.LC55@ha
	lis 9,.LC55@ha
	mr 5,3
	la 6,.LC54@l(6)
	la 8,.LC55@l(8)
.L386:
	mtlr 0
	la 9,.LC55@l(9)
	li 4,3
	lfs 1,0(6)
	mr 3,31
	lfs 2,0(8)
	lfs 3,0(9)
	blrl
.L381:
	li 3,1
.L382:
	lwz 0,148(1)
	mtlr 0
	lmw 19,68(1)
	lfd 29,120(1)
	lfd 30,128(1)
	lfd 31,136(1)
	la 1,144(1)
	blr
.Lfe8:
	.size	 CTFPickup_Flag,.Lfe8-CTFPickup_Flag
	.section	".rodata"
	.align 2
.LC58:
	.string	"*** %s Flag returned by timer.\n"
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
	lis 29,.LC37@ha
	lwz 3,280(31)
	la 4,.LC37@l(29)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L390
	la 30,.LC37@l(29)
	li 31,0
	b .L396
.L398:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L399
	mr 3,31
	bl G_FreeEdict
	b .L396
.L399:
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
.L396:
	mr 3,31
	li 4,280
	mr 5,30
	bl G_Find
	mr. 31,3
	bc 4,2,.L398
	lis 3,.LC33@ha
	lis 29,gi@ha
	la 3,.LC33@l(3)
	bl Green1
	lwz 0,gi@l(29)
	mr 5,3
	lis 4,.LC58@ha
	la 4,.LC58@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L402
.L390:
	lwz 3,280(31)
	lis 31,.LC38@ha
	la 4,.LC38@l(31)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L402
	la 30,.LC38@l(31)
	li 31,0
	b .L409
.L411:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L412
	mr 3,31
	bl G_FreeEdict
	b .L409
.L412:
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
.L409:
	mr 3,31
	li 4,280
	mr 5,30
	bl G_Find
	mr. 31,3
	bc 4,2,.L411
	lis 3,.LC34@ha
	lis 29,gi@ha
	la 3,.LC34@l(3)
	bl Green1
	lwz 0,gi@l(29)
	mr 5,3
	lis 4,.LC58@ha
	la 4,.LC58@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L402:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 CTFDropFlagThink,.Lfe9-CTFDropFlagThink
	.section	".rodata"
	.align 2
.LC59:
	.string	"models/ctf/flagevil.md2"
	.align 2
.LC60:
	.string	"i_ctf1"
	.align 2
.LC61:
	.string	"models/ctf/flaggood.md2"
	.align 2
.LC62:
	.string	"i_ctf2"
	.align 2
.LC63:
	.long 0x42c80000
	.align 2
.LC64:
	.long 0x42200000
	.section	".text"
	.align 2
	.globl CTFDrop_Flag
	.type	 CTFDrop_Flag,@function
CTFDrop_Flag:
	stwu 1,-144(1)
	mflr 0
	stmw 26,120(1)
	stw 0,148(1)
	mr 30,3
	lwz 0,264(30)
	andis. 9,0,4096
	bc 12,2,.L415
	bl G_Spawn
	lis 9,gi+132@ha
	mr 31,3
	lwz 0,gi+132@l(9)
	li 3,72
	li 4,766
	mtlr 0
	blrl
	lis 9,CTFPickup_Flag@ha
	stw 3,648(31)
	la 9,CTFPickup_Flag@l(9)
	stw 9,4(3)
	lwz 0,264(30)
	andis. 9,0,1024
	bc 12,2,.L417
	lwz 10,648(31)
	lis 0,0x800
	lis 9,.LC60@ha
	stw 0,644(31)
	la 9,.LC60@l(9)
	lis 11,.LC46@ha
	stw 9,36(10)
	la 11,.LC46@l(11)
	lwz 8,648(31)
	lis 10,.LC38@ha
	lis 9,.LC59@ha
	la 10,.LC38@l(10)
	la 4,.LC59@l(9)
	stw 11,20(8)
	lwz 0,64(31)
	oris 0,0,0x8
	b .L421
.L417:
	lwz 10,648(31)
	lis 0,0x400
	lis 9,.LC62@ha
	stw 0,644(31)
	la 9,.LC62@l(9)
	lis 11,.LC47@ha
	stw 9,36(10)
	la 11,.LC47@l(11)
	lwz 8,648(31)
	lis 10,.LC37@ha
	lis 9,.LC61@ha
	la 10,.LC37@l(10)
	la 4,.LC61@l(9)
	stw 11,20(8)
	lwz 0,64(31)
	oris 0,0,0x4
.L421:
	ori 0,0,1
	stw 0,64(31)
	stw 10,280(31)
	lis 0,0xc170
	lis 11,0x4170
	lis 10,0x1
	li 8,198
	stw 0,196(31)
	lis 9,gi@ha
	stw 11,208(31)
	mr 3,31
	stw 0,188(31)
	la 26,gi@l(9)
	stw 0,192(31)
	stw 11,200(31)
	stw 11,204(31)
	stw 10,284(31)
	stw 8,56(31)
	lwz 9,44(26)
	mtlr 9
	blrl
	lis 9,CTFDropFlagTouch@ha
	li 11,1
	stw 30,256(31)
	la 9,CTFDropFlagTouch@l(9)
	li 0,7
	stw 11,248(31)
	stw 0,260(31)
	stw 9,444(31)
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 12,2,.L419
	addi 29,1,24
	addi 4,1,8
	addi 3,3,3692
	mr 5,29
	li 6,0
	addi 27,30,4
	bl AngleVectors
	addi 28,31,4
	lis 0,0x41c0
	li 9,0
	lis 11,0xc180
	stw 0,40(1)
	addi 4,1,40
	stw 9,44(1)
	addi 5,1,8
	mr 6,29
	mr 3,27
	stw 11,48(1)
	mr 7,28
	bl G_ProjectSource
	lwz 0,48(26)
	mr 4,27
	mr 7,28
	addi 3,1,56
	addi 5,31,188
	addi 6,31,200
	mr 8,30
	mtlr 0
	li 9,1
	blrl
	lfs 0,68(1)
	stfs 0,4(31)
	lfs 13,72(1)
	stfs 13,8(31)
	lfs 0,76(1)
	b .L422
.L419:
	addi 3,30,16
	addi 4,1,8
	addi 5,1,24
	li 6,0
	bl AngleVectors
	lfs 0,4(30)
	stfs 0,4(31)
	lfs 13,8(30)
	stfs 13,8(31)
	lfs 0,12(30)
.L422:
	stfs 0,12(31)
	lis 9,.LC63@ha
	addi 3,1,8
	la 9,.LC63@l(9)
	addi 4,31,376
	lfs 1,0(9)
	bl VectorScale
	lis 9,CTFDropFlagThink@ha
	lis 0,0x4396
	la 9,CTFDropFlagThink@l(9)
	stw 0,384(31)
	lis 11,level+4@ha
	stw 9,436(31)
	mr 3,31
	lis 9,.LC64@ha
	lfs 0,level+4@l(11)
	la 9,.LC64@l(9)
	lfs 13,0(9)
	lis 9,gi+72@ha
	fadds 0,0,13
	stfs 0,428(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,264(30)
	li 9,0
	stw 9,48(30)
	rlwinm 0,0,0,4,2
	stw 0,264(30)
.L415:
	lwz 0,148(1)
	mtlr 0
	lmw 26,120(1)
	la 1,144(1)
	blr
.Lfe10:
	.size	 CTFDrop_Flag,.Lfe10-CTFDrop_Flag
	.section	".rodata"
	.align 2
.LC66:
	.string	"CTFFlagSetup: %s startsolid at %s\n"
	.align 3
.LC67:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC68:
	.long 0xc1700000
	.align 2
.LC69:
	.long 0x41700000
	.align 2
.LC70:
	.long 0x0
	.align 2
.LC71:
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
	lis 9,.LC68@ha
	lis 11,.LC68@ha
	la 9,.LC68@l(9)
	la 11,.LC68@l(11)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC68@ha
	lfs 2,0(11)
	la 9,.LC68@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lis 9,.LC69@ha
	lfs 13,0(11)
	la 9,.LC69@l(9)
	lfs 1,0(9)
	lis 9,.LC69@ha
	stfs 13,188(31)
	la 9,.LC69@l(9)
	lfs 0,4(11)
	lfs 2,0(9)
	lis 9,.LC69@ha
	stfs 0,192(31)
	la 9,.LC69@l(9)
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
	bc 12,2,.L425
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L426
.L425:
	lis 9,gi+44@ha
	lwz 11,648(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L426:
	li 11,7
	lis 9,Touch_Item@ha
	stw 11,260(31)
	la 9,Touch_Item@l(9)
	li 0,1
	lis 11,.LC70@ha
	stw 9,444(31)
	li 10,198
	la 11,.LC70@l(11)
	lis 9,.LC70@ha
	stw 0,248(31)
	lfs 1,0(11)
	la 9,.LC70@l(9)
	addi 29,31,4
	lis 11,.LC71@ha
	lfs 2,0(9)
	la 11,.LC71@l(11)
	stw 10,56(31)
	lfs 3,0(11)
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
	bc 12,2,.L427
	mr 3,29
	lwz 29,280(31)
	bl vtos
	mr 5,3
	lwz 0,4(30)
	mr 4,29
	lis 3,.LC66@ha
	la 3,.LC66@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L424
.L427:
	lwz 0,64(31)
	lfs 0,20(1)
	lfs 12,24(1)
	andis. 9,0,4
	lfs 13,28(1)
	stfs 0,4(31)
	stfs 12,8(31)
	stfs 13,12(31)
	bc 12,2,.L428
	lis 0,0x400
	b .L431
.L428:
	andis. 11,0,8
	bc 12,2,.L429
	lis 0,0x800
.L431:
	stw 0,644(31)
.L429:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 11,level+4@ha
	lis 10,.LC67@ha
	lfs 0,level+4@l(11)
	lis 9,CTFFlagThink@ha
	lfd 13,.LC67@l(10)
	la 9,CTFFlagThink@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L424:
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe11:
	.size	 CTFFlagSetup,.Lfe11-CTFFlagSetup
	.section	".rodata"
	.align 2
.LC72:
	.string	"ctf/i_ctf1"
	.align 2
.LC73:
	.string	"ctf/i_ctf1d"
	.align 2
.LC74:
	.string	"ctf/i_ctf1t"
	.align 2
.LC75:
	.string	"ctf/i_ctf2"
	.align 2
.LC76:
	.string	"ctf/i_ctf2d"
	.align 2
.LC77:
	.string	"ctf/i_ctf2t"
	.align 2
.LC78:
	.long 0x3f800000
	.align 3
.LC79:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFFlagStat
	.type	 CTFFlagStat,@function
CTFFlagStat:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 0,0x400
	cmpw 0,3,0
	bc 4,2,.L441
	lis 29,gi@ha
	lis 3,.LC72@ha
	la 29,gi@l(29)
	la 3,.LC72@l(3)
	lwz 9,40(29)
	lis 27,0x800
	mtlr 9
	blrl
	lwz 9,40(29)
	mr 30,3
	lis 3,.LC73@ha
	mtlr 9
	la 3,.LC73@l(3)
	blrl
	mr 31,3
	lwz 0,40(29)
	lis 3,.LC74@ha
	la 3,.LC74@l(3)
	mtlr 0
	blrl
	lis 9,.LC37@ha
	mr 28,3
	la 5,.LC37@l(9)
	b .L442
.L441:
	lis 0,0x800
	cmpw 0,3,0
	bc 12,2,.L443
	li 3,0
	b .L455
.L443:
	lis 29,gi@ha
	lis 3,.LC75@ha
	la 29,gi@l(29)
	la 3,.LC75@l(3)
	lwz 9,40(29)
	lis 27,0x400
	mtlr 9
	blrl
	lwz 9,40(29)
	mr 30,3
	lis 3,.LC76@ha
	mtlr 9
	la 3,.LC76@l(3)
	blrl
	mr 31,3
	lwz 0,40(29)
	lis 3,.LC77@ha
	la 3,.LC77@l(3)
	mtlr 0
	blrl
	lis 9,.LC38@ha
	mr 28,3
	la 5,.LC38@l(9)
.L442:
	li 3,0
	li 4,280
	bl G_Find
	mr 29,30
	mr. 3,3
	bc 12,2,.L445
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 4,2,.L446
	lis 11,.LC78@ha
	lis 9,maxclients@ha
	la 11,.LC78@l(11)
	mr 29,31
	lfs 0,0(11)
	li 10,1
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L445
	lis 9,g_edicts@ha
	fmr 12,13
	lis 8,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC79@ha
	la 9,.LC79@l(9)
	addi 11,11,936
	lfd 13,0(9)
.L450:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L449
	lwz 0,264(11)
	andis. 9,0,4096
	bc 12,2,.L449
	and. 9,0,27
	bc 4,2,.L456
.L449:
	addi 10,10,1
	xoris 0,10,0x8000
	addi 11,11,936
	stw 0,20(1)
	stw 8,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L450
	b .L445
.L456:
	mr 29,28
	b .L445
.L446:
	lwz 0,284(3)
	andis. 11,0,1
	mfcr 9
	rlwinm 9,9,3,1
	neg 9,9
	andc 0,31,9
	and 9,29,9
	or 29,9,0
.L445:
	mr 3,29
.L455:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe12:
	.size	 CTFFlagStat,.Lfe12-CTFFlagStat
	.section	".rodata"
	.align 2
.LC80:
	.string	"Forces of Good"
	.align 2
.LC81:
	.string	"Minions of Evil"
	.align 2
.LC82:
	.string	"*****\n"
	.align 2
.LC83:
	.string	"The %s are crushing the %s\n"
	.align 2
.LC84:
	.string	"The battle is %s!\n"
	.align 2
.LC85:
	.string	"tied"
	.string	""
	.align 2
.LC86:
	.string	"%s\n"
	.align 2
.LC87:
	.string	"The Forces of Good have defeated the Minions of Evil"
	.align 2
.LC88:
	.string	"The Minions of Evil have defeated the Forces of Good"
	.align 2
.LC89:
	.string	"The battle results in a draw!"
	.string	""
	.align 2
.LC90:
	.string	"Score: %i to %i\n*****\n"
	.align 2
.LC91:
	.long 0x3f800000
	.align 3
.LC92:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFAnnounceScore
	.type	 CTFAnnounceScore,@function
CTFAnnounceScore:
	stwu 1,-112(1)
	mflr 0
	mfcr 12
	stmw 25,84(1)
	stw 0,116(1)
	stw 12,80(1)
	addi 29,1,8
	mr 26,3
	addi 28,1,40
	li 4,0
	li 5,20
	mr 3,29
	crxor 6,6,6
	bl memset
	mr 25,28
	li 31,0
	li 4,0
	li 5,20
	mr 3,28
	lis 27,gi@ha
	crxor 6,6,6
	bl memset
	lis 9,.LC80@ha
	lis 8,.LC91@ha
	lwz 4,.LC80@l(9)
	la 8,.LC91@l(8)
	lis 7,.LC81@ha
	la 9,.LC80@l(9)
	lfs 0,0(8)
	la 11,.LC81@l(7)
	lwz 8,4(9)
	lis 3,maxclients@ha
	li 12,1
	lwz 0,8(9)
	lbz 5,14(9)
	lhz 10,12(9)
	stw 4,8(1)
	lwz 6,.LC81@l(7)
	stb 5,14(29)
	stw 8,4(29)
	stw 0,8(29)
	sth 10,12(29)
	lwz 8,12(11)
	lwz 0,4(11)
	lwz 9,8(11)
	stw 6,40(1)
	lwz 11,maxclients@l(3)
	stw 0,4(28)
	stw 9,8(28)
	stw 8,12(28)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L464
	lis 9,g_edicts@ha
	fmr 12,13
	lis 10,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC92@ha
	la 9,.LC92@l(9)
	addi 11,11,936
	lfd 13,0(9)
.L460:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L462
	lwz 0,264(11)
	andis. 8,0,1024
	bc 12,2,.L462
	lwz 9,84(11)
	lwz 0,3496(9)
	add 31,31,0
.L462:
	addi 12,12,1
	xoris 0,12,0x8000
	addi 11,11,936
	stw 0,76(1)
	stw 10,72(1)
	lfd 0,72(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L460
.L464:
	lis 9,maxclients@ha
	lis 10,.LC91@ha
	lwz 11,maxclients@l(9)
	la 10,.LC91@l(10)
	mr 30,31
	lfs 0,0(10)
	li 6,0
	cmpwi 4,26,0
	lfs 13,20(11)
	li 10,1
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L472
	lis 9,g_edicts@ha
	fmr 12,13
	lis 8,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC92@ha
	la 9,.LC92@l(9)
	addi 11,11,936
	lfd 13,0(9)
.L468:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L470
	lwz 0,264(11)
	andis. 9,0,2048
	bc 12,2,.L470
	lwz 9,84(11)
	lwz 0,3496(9)
	add 6,6,0
.L470:
	addi 10,10,1
	xoris 0,10,0x8000
	addi 11,11,936
	stw 0,76(1)
	stw 8,72(1)
	lfd 0,72(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L468
.L472:
	lis 9,gi@ha
	lis 4,.LC82@ha
	lwz 0,gi@l(9)
	la 4,.LC82@l(4)
	li 3,2
	mr 28,6
	mtlr 0
	crxor 6,6,6
	blrl
	cmpw 7,31,28
	mfcr 10
	rlwinm 0,10,19,1
	rlwinm 10,10,30,1
	and. 8,10,0
	bc 12,2,.L474
	addi 3,1,8
	mr 30,31
	bl Green1
	mr 29,3
	mr 3,25
	b .L485
.L474:
	cmpw 7,28,31
	mfcr 11
	rlwinm 11,11,30,1
	and. 8,11,0
	bc 12,2,.L476
	mr 3,25
	mr 30,28
	bl Green1
	mr 28,31
	mr 29,3
	addi 3,1,8
.L485:
	bl Green2
	lwz 0,gi@l(27)
	mr 6,3
	lis 4,.LC83@ha
	la 4,.LC83@l(4)
	mr 5,29
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L475
.L476:
	mfcr 9
	rlwinm 9,9,31,1
	and. 8,9,0
	bc 12,2,.L478
	lis 3,.LC85@ha
	la 3,.LC85@l(3)
	bl Green1
	lwz 0,gi@l(27)
	mr 5,3
	lis 4,.LC84@ha
	la 4,.LC84@l(4)
	b .L486
.L478:
	addic 0,26,-1
	subfe 3,0,26
	and. 8,10,3
	bc 12,2,.L480
	lis 3,.LC87@ha
	mr 30,31
	la 3,.LC87@l(3)
	b .L487
.L480:
	and. 0,11,3
	bc 12,2,.L482
	lis 3,.LC88@ha
	mr 30,28
	la 3,.LC88@l(3)
	mr 28,31
.L487:
	bl Green1
	lwz 0,gi@l(27)
	mr 5,3
	lis 4,.LC86@ha
	la 4,.LC86@l(4)
.L486:
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L475
.L482:
	and. 0,9,3
	bc 12,2,.L475
	lis 3,.LC89@ha
	la 3,.LC89@l(3)
	bl Green1
	lwz 0,gi@l(27)
	mr 5,3
	lis 4,.LC86@ha
	la 4,.LC86@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L475:
	lis 9,gi@ha
	lis 4,.LC90@ha
	lwz 0,gi@l(9)
	la 4,.LC90@l(4)
	mr 5,30
	mr 6,28
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,116(1)
	lwz 12,80(1)
	mtlr 0
	lmw 25,84(1)
	mtcrf 8,12
	la 1,112(1)
	blr
.Lfe13:
	.size	 CTFAnnounceScore,.Lfe13-CTFAnnounceScore
	.section	".rodata"
	.align 2
.LC93:
	.string	"info_player_team1"
	.align 2
.LC94:
	.string	"info_player_team2"
	.align 2
.LC95:
	.long 0x47c34f80
	.section	".text"
	.align 2
	.globl SelectCTFSpawnPoint
	.type	 SelectCTFSpawnPoint,@function
SelectCTFSpawnPoint:
	stwu 1,-48(1)
	mflr 0
	stfd 30,32(1)
	stfd 31,40(1)
	stmw 26,8(1)
	stw 0,52(1)
	lwz 0,264(3)
	li 30,0
	andis. 10,0,1024
	bc 12,2,.L496
	lis 9,0x400
	b .L497
.L496:
	andis. 11,0,2048
	bc 12,2,.L499
	lis 9,0x800
	b .L497
.L499:
	andi. 10,0,8192
	bc 4,2,.L497
	lwz 3,84(3)
	lis 29,gi@ha
	addi 3,3,700
	bl Green1
	lwz 0,gi@l(29)
	mr 5,3
	lis 4,.LC39@ha
	la 4,.LC39@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	li 9,0
.L497:
	lis 0,0x400
	cmpw 0,9,0
	bc 12,2,.L492
	lis 0,0x800
	cmpw 0,9,0
	bc 12,2,.L493
	b .L518
.L492:
	lis 9,.LC93@ha
	la 26,.LC93@l(9)
	b .L491
.L493:
	lis 9,.LC94@ha
	la 26,.LC94@l(9)
.L491:
	lis 9,.LC95@ha
	li 31,0
	lfs 31,.LC95@l(9)
	li 27,0
	li 28,0
	fmr 30,31
	b .L502
.L504:
	mr 3,31
	addi 30,30,1
	bl PlayersRangeFromSpot
	fcmpu 0,1,30
	bc 4,0,.L505
	fmr 30,1
	mr 28,31
	b .L502
.L505:
	fcmpu 0,1,31
	bc 4,0,.L502
	fmr 31,1
	mr 27,31
.L502:
	mr 3,31
	li 4,280
	mr 5,26
	bl G_Find
	mr. 31,3
	bc 4,2,.L504
	cmpwi 0,30,0
	bc 4,2,.L509
.L518:
	bl SelectRandomDeathmatchSpawnPoint
	b .L517
.L509:
	cmpwi 0,30,2
	bc 12,1,.L510
	li 27,0
	li 28,0
	b .L511
.L510:
	addi 30,30,-2
.L511:
	bl rand
	li 31,0
	divw 0,3,30
	mullw 0,0,30
	subf 29,0,3
.L516:
	mr 3,31
	li 4,280
	mr 5,26
	bl G_Find
	mr 31,3
	addi 0,29,1
	xor 9,31,28
	subfic 10,9,0
	adde 9,10,9
	xor 11,31,27
	subfic 10,11,0
	adde 11,10,11
	or 9,9,11
	addic 9,9,-1
	subfe 9,9,9
	andc 0,0,9
	and 9,29,9
	or 29,9,0
	cmpwi 0,29,0
	addi 29,29,-1
	bc 4,2,.L516
.L517:
	lwz 0,52(1)
	mtlr 0
	lmw 26,8(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe14:
	.size	 SelectCTFSpawnPoint,.Lfe14-SelectCTFSpawnPoint
	.section	".rodata"
	.align 2
.LC96:
	.string	"+++ Illegal flag check\n"
	.align 2
.LC97:
	.string	"*** %s has the %s flag!\n"
	.align 2
.LC98:
	.string	"*** %s flag is lying free!\n"
	.align 2
.LC99:
	.string	"+++ Unexpected reset of %s flag.\n"
	.align 2
.LC100:
	.long 0x3f800000
	.align 3
.LC101:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFCheck_Flag
	.type	 CTFCheck_Flag,@function
CTFCheck_Flag:
	stwu 1,-64(1)
	mflr 0
	stmw 25,36(1)
	stw 0,68(1)
	mr 30,3
	lis 0,0x400
	cmpw 0,30,0
	bc 12,2,.L521
	lis 0,0x800
	cmpw 0,30,0
	bc 12,2,.L522
	b .L523
.L521:
	lis 9,.LC37@ha
	lis 7,0x800
	la 25,.LC37@l(9)
	b .L520
.L522:
	lis 9,.LC38@ha
	lis 7,0x400
	la 25,.LC38@l(9)
	b .L520
.L523:
	lis 9,gi@ha
	lis 4,.LC96@ha
	lwz 0,gi@l(9)
	li 3,2
	la 4,.LC96@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L558
.L520:
	lis 11,.LC100@ha
	lis 9,maxclients@ha
	la 11,.LC100@l(11)
	li 8,1
	lfs 13,0(11)
	lis 28,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L526
	lis 9,.LC101@ha
	lis 0,0x400
	la 9,.LC101@l(9)
	cmpw 7,30,0
	lfd 12,0(9)
	lis 3,g_edicts@ha
	lis 31,gi@ha
	lis 29,.LC40@ha
	lis 6,.LC41@ha
	lis 4,.LC97@ha
	lis 5,0x4330
	li 10,936
.L528:
	lwz 0,g_edicts@l(3)
	add 11,0,10
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L527
	lwz 0,264(11)
	andi. 9,0,8192
	bc 4,2,.L527
	and. 9,0,7
	bc 12,2,.L527
	andis. 9,0,4096
	bc 12,2,.L527
	lwz 9,84(11)
	la 11,gi@l(31)
	addi 5,9,700
	bc 4,30,.L532
	la 6,.LC40@l(29)
	b .L533
.L532:
	la 6,.LC41@l(6)
.L533:
	lwz 11,0(11)
	li 3,2
	la 4,.LC97@l(4)
	mtlr 11
	crxor 6,6,6
	blrl
	li 3,1
	b .L557
.L527:
	addi 8,8,1
	lwz 11,maxclients@l(28)
	xoris 0,8,0x8000
	addi 10,10,936
	stw 0,28(1)
	stw 5,24(1)
	lfd 0,24(1)
	lfs 13,20(11)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L528
.L526:
	lis 0,0x400
	li 9,0
	cmpw 0,30,0
	lis 29,gi@ha
	lis 27,.LC40@ha
	lis 28,.LC41@ha
	lis 26,.LC98@ha
	mfcr 31
	b .L535
.L537:
	lwz 0,284(9)
	andis. 11,0,1
	bc 12,2,.L538
	la 9,gi@l(29)
	mtcrf 128,31
	bc 4,2,.L539
	la 5,.LC40@l(27)
	b .L540
.L539:
	la 5,.LC41@l(28)
.L540:
	lwz 0,0(9)
	li 3,2
	la 4,.LC98@l(26)
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,1
	b .L557
.L538:
	lwz 0,184(9)
	li 3,1
	andi. 11,0,1
	bc 12,2,.L557
.L535:
	mr 3,9
	li 4,280
	mr 5,25
	bl G_Find
	mr. 9,3
	bc 4,2,.L537
	lis 0,0x400
	cmpw 0,30,0
	bc 12,2,.L544
	lis 0,0x800
	cmpw 0,30,0
	bc 12,2,.L545
	b .L548
.L544:
	lis 9,.LC37@ha
	la 28,.LC37@l(9)
	b .L547
.L545:
	lis 9,.LC38@ha
	la 28,.LC38@l(9)
.L547:
	li 31,0
	b .L549
.L551:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L552
	mr 3,31
	bl G_FreeEdict
	b .L549
.L552:
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
.L549:
	mr 3,31
	li 4,280
	mr 5,28
	bl G_Find
	mr. 31,3
	bc 4,2,.L551
.L548:
	lis 0,0x400
	lis 9,gi@ha
	cmpw 0,30,0
	la 11,gi@l(9)
	bc 4,2,.L555
	lis 9,.LC40@ha
	la 5,.LC40@l(9)
	b .L556
.L555:
	lis 9,.LC41@ha
	la 5,.LC41@l(9)
.L556:
	lwz 0,0(11)
	lis 4,.LC99@ha
	li 3,2
	la 4,.LC99@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L558:
	li 3,0
.L557:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe15:
	.size	 CTFCheck_Flag,.Lfe15-CTFCheck_Flag
	.comm	v_forward,12,4
	.comm	v_right,12,4
	.comm	v_up,12,4
	.comm	invis_index,4,4
	.comm	cripple_index,4,4
	.comm	robot_index,4,4
	.comm	sun_index,4,4
	.section	".rodata"
	.align 2
.LC102:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFSameTeam
	.type	 CTFSameTeam,@function
CTFSameTeam:
	lis 11,.LC102@ha
	lis 9,ctf@ha
	la 11,.LC102@l(11)
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L287
	li 3,0
	blr
.L287:
	lwz 0,264(3)
	andis. 11,0,1024
	mr 9,0
	bc 12,2,.L288
	lwz 0,264(4)
	andis. 11,0,1024
	bc 12,2,.L288
	li 3,1
	blr
.L288:
	andis. 0,9,2048
	bc 12,2,.L289
	lwz 0,264(4)
	li 3,1
	andis. 9,0,2048
	bclr 4,2
.L289:
	li 3,0
	blr
.Lfe16:
	.size	 CTFSameTeam,.Lfe16-CTFSameTeam
	.section	".rodata"
	.align 2
.LC103:
	.long 0x3f800000
	.align 3
.LC104:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFTeamScore
	.type	 CTFTeamScore,@function
CTFTeamScore:
	stwu 1,-16(1)
	lis 11,.LC103@ha
	lis 9,maxclients@ha
	la 11,.LC103@l(11)
	mr 8,3
	lfs 0,0(11)
	li 3,0
	li 10,1
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L434
	lis 9,g_edicts@ha
	fmr 12,13
	lis 7,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC104@ha
	la 9,.LC104@l(9)
	addi 11,11,936
	lfd 13,0(9)
.L436:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L435
	lwz 0,264(11)
	and. 9,0,8
	bc 12,2,.L435
	lwz 9,84(11)
	lwz 0,3496(9)
	add 3,3,0
.L435:
	addi 10,10,1
	xoris 0,10,0x8000
	addi 11,11,936
	stw 0,12(1)
	stw 7,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L436
.L434:
	la 1,16(1)
	blr
.Lfe17:
	.size	 CTFTeamScore,.Lfe17-CTFTeamScore
	.section	".rodata"
	.align 2
.LC105:
	.long 0x3f800000
	.align 3
.LC106:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFTeamCount
	.type	 CTFTeamCount,@function
CTFTeamCount:
	stwu 1,-16(1)
	lis 9,maxclients@ha
	lis 6,.LC105@ha
	lwz 11,maxclients@l(9)
	la 6,.LC105@l(6)
	mr 8,3
	lfs 0,0(6)
	li 3,0
	li 10,1
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L197
	lis 9,g_edicts@ha
	fmr 12,13
	lis 7,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC106@ha
	la 9,.LC106@l(9)
	addi 11,11,936
	lfd 13,0(9)
.L199:
	lwz 0,88(11)
	xor 9,11,4
	subfic 6,9,0
	adde 9,6,9
	subfic 6,0,0
	adde 0,6,0
	or. 6,0,9
	bc 4,2,.L198
	lwz 0,264(11)
	addi 9,3,1
	and 0,0,8
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,3,0
	or 3,0,9
.L198:
	addi 10,10,1
	xoris 0,10,0x8000
	addi 11,11,936
	stw 0,12(1)
	stw 7,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L199
.L197:
	la 1,16(1)
	blr
.Lfe18:
	.size	 CTFTeamCount,.Lfe18-CTFTeamCount
	.align 2
	.globl readadmin
	.type	 readadmin,@function
readadmin:
	stwu 1,-528(1)
	mflr 0
	stmw 30,520(1)
	stw 0,532(1)
	lis 3,.LC1@ha
	lis 4,.LC2@ha
	la 3,.LC1@l(3)
	la 4,.LC2@l(4)
	bl fopen
	li 31,0
	mr. 30,3
	bc 12,2,.L29
	addi 3,1,8
	li 4,500
	mr 5,30
	bl fgets
	li 0,20
	lis 9,admin@ha
	mtctr 0
	addi 10,1,8
	li 8,0
	la 11,admin@l(9)
.L560:
	lbzx 0,10,31
	mr 9,0
	stbx 0,11,31
	cmplwi 0,9,32
	bc 12,1,.L32
	stbx 8,11,31
.L32:
	addi 31,31,1
	bdnz .L560
	mr 3,30
	bl fclose
	b .L36
.L29:
	lis 9,gi@ha
	lis 4,.LC3@ha
	lwz 0,gi@l(9)
	la 4,.LC3@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L36:
	lwz 0,532(1)
	mtlr 0
	lmw 30,520(1)
	la 1,528(1)
	blr
.Lfe19:
	.size	 readadmin,.Lfe19-readadmin
	.align 2
	.globl CTFTripSkin
	.type	 CTFTripSkin,@function
CTFTripSkin:
	lwz 0,264(3)
	andis. 9,0,1024
	bc 12,2,.L204
	li 0,1
.L562:
	stw 0,60(3)
	blr
.L204:
	andis. 0,0,0x800
	bc 12,2,.L562
	li 0,2
	b .L562
.Lfe20:
	.size	 CTFTripSkin,.Lfe20-CTFTripSkin
	.align 2
	.globl Svcmd_Test_f
	.type	 Svcmd_Test_f,@function
Svcmd_Test_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+8@ha
	lis 5,.LC0@ha
	lwz 0,gi+8@l(9)
	la 5,.LC0@l(5)
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe21:
	.size	 Svcmd_Test_f,.Lfe21-Svcmd_Test_f
	.align 2
	.globl clearbans
	.type	 clearbans,@function
clearbans:
	li 11,23
	lis 9,game@ha
	mtctr 11
	la 9,game@l(9)
	li 0,0
	addi 9,9,1652
.L566:
	stw 0,0(9)
	addi 9,9,-4
	bdnz .L566
	li 11,19
	lis 9,game@ha
	mtctr 11
	la 9,game@l(9)
	li 0,0
	addi 9,9,1728
.L565:
	stw 0,0(9)
	addi 9,9,-4
	bdnz .L565
	li 11,19
	lis 9,game@ha
	mtctr 11
	la 9,game@l(9)
	li 0,0
	addi 9,9,1804
.L564:
	stw 0,0(9)
	addi 9,9,-4
	bdnz .L564
	li 11,8
	lis 9,game@ha
	mtctr 11
	la 9,game@l(9)
	li 0,0
	addi 9,9,1836
.L563:
	stw 0,0(9)
	addi 9,9,-4
	bdnz .L563
	blr
.Lfe22:
	.size	 clearbans,.Lfe22-clearbans
	.section	".rodata"
	.align 2
.LC107:
	.long 0x3f800000
	.align 3
.LC108:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl MakeAllObs
	.type	 MakeAllObs,@function
MakeAllObs:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 27,36(1)
	stw 0,68(1)
	lis 11,.LC107@ha
	lis 9,maxclients@ha
	la 11,.LC107@l(11)
	li 30,1
	lfs 13,0(11)
	lis 27,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L130
	lis 9,.LC108@ha
	lis 28,g_edicts@ha
	la 9,.LC108@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 31,936
.L132:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L131
	lwz 0,264(3)
	andi. 11,0,8192
	bc 4,2,.L131
	bl MakeObserver
.L131:
	addi 30,30,1
	lwz 11,maxclients@l(27)
	xoris 0,30,0x8000
	addi 31,31,936
	stw 0,28(1)
	stw 29,24(1)
	lfd 0,24(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L132
.L130:
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe23:
	.size	 MakeAllObs,.Lfe23-MakeAllObs
	.align 2
	.globl CTFTeam_Flag
	.type	 CTFTeam_Flag,@function
CTFTeam_Flag:
	lwz 9,644(3)
	lwz 0,264(4)
	and 0,0,9
	addic 9,0,-1
	subfe 3,9,0
	blr
.Lfe24:
	.size	 CTFTeam_Flag,.Lfe24-CTFTeam_Flag
	.align 2
	.globl CTFResetFlag
	.type	 CTFResetFlag,@function
CTFResetFlag:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 0,0x400
	cmpw 0,3,0
	bc 12,2,.L253
	lis 0,0x800
	cmpw 0,3,0
	bc 12,2,.L254
	b .L251
.L253:
	lis 9,.LC37@ha
	la 29,.LC37@l(9)
	b .L252
.L254:
	lis 9,.LC38@ha
	la 29,.LC38@l(9)
.L252:
	lis 9,gi@ha
	li 31,0
	la 28,gi@l(9)
	li 30,1
	b .L257
.L259:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L260
	mr 3,31
	bl G_FreeEdict
	b .L257
.L260:
	lwz 0,184(31)
	mr 3,31
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 9,72(28)
	mtlr 9
	blrl
	stw 30,80(31)
.L257:
	mr 3,31
	li 4,280
	mr 5,29
	bl G_Find
	mr. 31,3
	bc 4,2,.L259
.L251:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe25:
	.size	 CTFResetFlag,.Lfe25-CTFResetFlag
	.align 2
	.globl CTFTeam
	.type	 CTFTeam,@function
CTFTeam:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lwz 0,264(3)
	andis. 9,0,1024
	bc 12,2,.L291
	lis 3,0x400
	b .L290
.L291:
	andis. 9,0,2048
	bc 12,2,.L293
	lis 3,0x800
	b .L290
.L293:
	andi. 9,0,8192
	bc 4,2,.L290
	lwz 3,84(3)
	lis 29,gi@ha
	addi 3,3,700
	bl Green1
	lwz 0,gi@l(29)
	mr 5,3
	lis 4,.LC39@ha
	li 3,2
	la 4,.LC39@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
.L290:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe26:
	.size	 CTFTeam,.Lfe26-CTFTeam
	.section	".rodata"
	.align 2
.LC109:
	.long 0x42180000
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
	bc 4,2,.L388
	lis 9,level+4@ha
	lfs 0,428(3)
	lis 11,.LC109@ha
	lfs 13,level+4@l(9)
	la 11,.LC109@l(11)
	lfs 12,0(11)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,1,.L387
.L388:
	bl Touch_Item
.L387:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe27:
	.size	 CTFDropFlagTouch,.Lfe27-CTFDropFlagTouch
	.section	".rodata"
	.align 3
.LC110:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl CTFFlagThink
	.type	 CTFFlagThink,@function
CTFFlagThink:
	lis 9,level+4@ha
	lis 11,.LC110@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC110@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe28:
	.size	 CTFFlagThink,.Lfe28-CTFFlagThink
	.align 2
	.globl SP_info_player_team1
	.type	 SP_info_player_team1,@function
SP_info_player_team1:
	blr
.Lfe29:
	.size	 SP_info_player_team1,.Lfe29-SP_info_player_team1
	.align 2
	.globl SP_info_player_team2
	.type	 SP_info_player_team2,@function
SP_info_player_team2:
	blr
.Lfe30:
	.size	 SP_info_player_team2,.Lfe30-SP_info_player_team2
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
