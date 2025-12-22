	.file	"e_util.c"
gcc2_compiled.:
	.globl logfile
	.section	".sdata","aw"
	.align 2
	.type	 logfile,@object
	.size	 logfile,4
logfile:
	.long 0
	.lcomm	buf.21,33,4
	.section	".rodata"
	.align 2
.LC0:
	.string	"\nerror \""
	.align 2
.LC1:
	.string	"\"\n"
	.align 2
.LC2:
	.string	"%s kicked: %s\n"
	.align 2
.LC3:
	.string	"kick %d\n"
	.section	".text"
	.align 2
	.globl BootPlayer
	.type	 BootPlayer,@function
BootPlayer:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 29,3
	mr 28,4
	mr 25,5
	mr 3,28
	bl strlen
	lis 26,gi@ha
	addi 3,3,11
	la 27,gi@l(26)
	bl malloc
	lis 11,.LC0@ha
	mr 9,3
	lwz 8,.LC0@l(11)
	la 10,.LC0@l(11)
	mr 4,28
	lbz 11,8(10)
	lwz 0,4(10)
	stw 8,0(9)
	stb 11,8(9)
	stw 0,4(9)
	bl strcat
	lis 4,.LC1@ha
	la 4,.LC1@l(4)
	bl strcat
	lwz 9,100(27)
	mr 28,3
	li 3,11
	mtlr 9
	blrl
	lwz 9,116(27)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,92(27)
	li 4,1
	mr 3,29
	mtlr 9
	blrl
	mr 3,28
	bl free
	lwz 0,gi@l(26)
	lis 4,.LC2@ha
	mr 6,25
	lwz 5,84(29)
	la 4,.LC2@l(4)
	li 3,2
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	lwz 3,84(29)
	addi 3,3,700
	bl strlen
	addi 3,3,7
	bl malloc
	lis 9,g_edicts@ha
	lis 0,0x478b
	lwz 11,g_edicts@l(9)
	ori 0,0,48365
	mr 28,3
	lis 3,.LC3@ha
	subf 29,11,29
	la 3,.LC3@l(3)
	mullw 29,29,0
	srawi 29,29,2
	addi 4,29,-1
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,28
	bl strcpy
	lwz 0,168(27)
	mr 28,3
	mtlr 0
	blrl
	mr 3,28
	bl free
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 BootPlayer,.Lfe1-BootPlayer
	.section	".rodata"
	.align 2
.LC4:
	.string	"debuglog.txt"
	.align 2
.LC5:
	.string	"a"
	.align 2
.LC6:
	.string	"ERROR: Unable to open log file. Log message cancelled.\n"
	.align 2
.LC7:
	.string	"Log message at time %.2f, frame %d. Description: %s\nMessage:\n"
	.align 2
.LC8:
	.string	"\n----- End of message -----\n\n"
	.section	".text"
	.align 2
	.globl E_LogAppend
	.type	 E_LogAppend,@function
E_LogAppend:
	stwu 1,-160(1)
	mflr 0
	stmw 29,148(1)
	stw 0,164(1)
	lis 0,0x200
	addi 29,1,168
	stw 5,16(1)
	addi 11,1,8
	stw 0,128(1)
	mr 30,3
	stw 29,132(1)
	stw 11,136(1)
	stw 6,20(1)
	stw 7,24(1)
	stw 8,28(1)
	stw 9,32(1)
	stw 10,36(1)
	bc 4,6,.L46
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L46:
	lis 9,logfile@ha
	mr 31,4
	lwz 0,logfile@l(9)
	cmpwi 0,0,0
	bc 4,2,.L47
	lis 9,gamedir@ha
	lis 4,.LC4@ha
	lwz 11,gamedir@l(9)
	lis 5,.LC5@ha
	la 4,.LC4@l(4)
	la 5,.LC5@l(5)
	lwz 3,4(11)
	bl OpenGamedirFile
	cmpwi 0,3,0
	lis 9,logfile@ha
	stw 3,logfile@l(9)
	bc 4,2,.L47
	lis 9,gi+4@ha
	lis 3,.LC6@ha
	lwz 0,gi+4@l(9)
	la 3,.LC6@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L45
.L47:
	lis 9,level@ha
	lis 29,logfile@ha
	la 11,level@l(9)
	lwz 5,level@l(9)
	lis 4,.LC7@ha
	lfs 1,4(11)
	la 4,.LC7@l(4)
	mr 6,30
	lwz 3,logfile@l(29)
	creqv 6,6,6
	bl fprintf
	lwz 10,128(1)
	addi 11,1,128
	addi 9,1,112
	lwz 8,8(11)
	mr 4,31
	mr 5,9
	lwz 0,4(11)
	stw 10,112(1)
	lwz 3,logfile@l(29)
	stw 0,4(9)
	stw 8,8(9)
	bl vfprintf
	lis 4,.LC8@ha
	lwz 3,logfile@l(29)
	la 4,.LC8@l(4)
	crxor 6,6,6
	bl fprintf
.L45:
	lwz 0,164(1)
	mtlr 0
	lmw 29,148(1)
	la 1,160(1)
	blr
.Lfe2:
	.size	 E_LogAppend,.Lfe2-E_LogAppend
	.section	".rodata"
	.align 2
.LC9:
	.string	"Closing logfile at time %.2f seconds elapsed in game\n"
	.align 2
.LC10:
	.string	"ERROR in E_LogClose: Attempted to close an already-closed logfile\n"
	.section	".text"
	.align 2
	.globl trimWhitespace
	.type	 trimWhitespace,@function
trimWhitespace:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr. 29,3
	li 28,0
	bc 12,2,.L55
	mr 3,29
	bl strlen
	mr. 30,3
	bc 12,2,.L55
	li 4,1
	addi 3,30,1
	bl calloc
	mr 31,3
	mr 4,29
	bl strcpy
	li 8,0
	addi 10,30,-1
	b .L58
.L60:
	addi 10,10,-1
.L58:
	cmpwi 0,10,0
	bc 4,1,.L59
	lbzx 11,31,10
	xori 9,11,32
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,9
	subfic 7,0,0
	adde 0,7,0
	or. 7,9,0
	bc 4,2,.L63
	xori 9,11,13
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,10
	subfic 7,0,0
	adde 0,7,0
	or. 11,0,9
	bc 12,2,.L59
.L63:
	stbx 8,31,10
	b .L60
.L59:
	li 10,0
	b .L66
.L68:
	addi 10,10,1
.L66:
	cmpw 0,10,30
	bc 4,0,.L67
	lbzx 11,31,10
	xori 9,11,32
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,9
	subfic 7,0,0
	adde 0,7,0
	or. 8,9,0
	bc 4,2,.L71
	xori 9,11,13
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,10
	subfic 7,0,0
	adde 0,7,0
	or. 8,0,9
	bc 12,2,.L67
.L71:
	addi 28,28,1
	b .L68
.L67:
	mr 3,29
	add 4,31,28
	bl strcpy
	mr 3,31
	bl free
.L55:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 trimWhitespace,.Lfe3-trimWhitespace
	.section	".rodata"
	.align 2
.LC11:
	.string	"/"
	.align 2
.LC12:
	.string	"Unable to load file %s\n"
	.align 2
.LC13:
	.string	" "
	.align 2
.LC14:
	.string	"Floodprot activated.  No spamming.\n"
	.align 2
.LC15:
	.long 0x40400000
	.align 2
.LC16:
	.long 0x41400000
	.align 2
.LC17:
	.long 0x41900000
	.align 2
.LC18:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl floodProt
	.type	 floodProt,@function
floodProt:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 11,3688(9)
	addi 11,11,1
	stw 11,3688(9)
	lwz 9,84(3)
	lwz 0,3688(9)
	cmpwi 0,0,19
	bc 4,1,.L168
	li 0,0
	stw 0,3688(9)
.L168:
	lwz 11,84(3)
	lis 9,level+4@ha
	lis 10,.LC15@ha
	lfs 0,level+4@l(9)
	la 10,.LC15@l(10)
	li 6,0
	lwz 0,3688(11)
	addi 11,11,3608
	lfs 13,0(10)
	slwi 0,0,2
	stfsx 0,11,0
	lwz 9,84(3)
	lwz 8,3688(9)
	addi 7,9,3608
	addi 0,8,-4
	addi 11,8,16
	nor 9,0,0
	slwi 10,8,2
	srawi 9,9,31
	lfsx 12,7,10
	addi 5,8,1
	andc 11,11,9
	and 0,0,9
	or 0,0,11
	slwi 0,0,2
	lfsx 0,7,0
	fsubs 0,12,0
	fcmpu 0,0,13
	bc 4,0,.L175
	li 6,1
.L175:
	cmpwi 0,6,0
	bc 4,2,.L171
	addi 0,8,-9
	addi 11,8,11
	nor 9,0,0
	lis 10,.LC16@ha
	srawi 9,9,31
	la 10,.LC16@l(10)
	andc 11,11,9
	and 0,0,9
	lfs 13,0(10)
	or 0,0,11
	li 10,0
	slwi 0,0,2
	lfsx 0,7,0
	fsubs 0,12,0
	fcmpu 0,0,13
	bc 4,0,.L179
	li 10,1
.L179:
	cmpwi 0,10,0
	bc 4,2,.L171
	addi 0,8,-19
	lis 11,.LC17@ha
	la 11,.LC17@l(11)
	nor 9,0,0
	lfs 13,0(11)
	srawi 9,9,31
	li 10,0
	andc 11,5,9
	and 0,0,9
	or 0,0,11
	slwi 0,0,2
	lfsx 0,7,0
	fsubs 0,12,0
	fcmpu 0,0,13
	bc 4,0,.L183
	li 10,1
.L183:
	cmpwi 0,10,0
	bc 12,2,.L170
.L171:
	lis 10,.LC18@ha
	lis 9,level+4@ha
	lwz 11,84(3)
	la 10,.LC18@l(10)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,3692(11)
.L170:
	lwz 11,84(3)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,3692(11)
	fcmpu 0,0,13
	bc 12,1,.L184
	li 3,0
	b .L185
.L184:
	lis 9,gi+8@ha
	lis 5,.LC14@ha
	lwz 0,gi+8@l(9)
	la 5,.LC14@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,1
.L185:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe4:
	.size	 floodProt,.Lfe4-floodProt
	.comm	gametype,4,4
	.align 2
	.globl StrToInt
	.type	 StrToInt,@function
StrToInt:
	lbz 11,0(3)
	li 8,1
	li 10,0
	b .L188
.L122:
	lbzu 11,1(3)
.L188:
	xori 9,11,32
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,9
	subfic 7,0,0
	adde 0,7,0
	or. 7,9,0
	bc 4,2,.L122
	cmpwi 0,11,10
	bc 12,2,.L122
	lbz 0,0(3)
	cmpwi 0,0,43
	bc 4,2,.L124
	addi 3,3,1
	b .L125
.L124:
	cmpwi 0,0,45
	bc 4,2,.L125
	addi 3,3,1
	li 8,-1
.L125:
	lbz 9,0(3)
	addi 9,9,-48
	cmplwi 0,9,9
	bc 4,1,.L130
	mr 3,4
	blr
.L130:
	lbz 0,0(3)
	mulli 9,10,10
	lbzu 11,1(3)
	add 9,9,0
	addi 11,11,-48
	addi 10,9,-48
	cmplwi 0,11,9
	bc 4,1,.L130
	mullw 3,10,8
	blr
.Lfe5:
	.size	 StrToInt,.Lfe5-StrToInt
	.align 2
	.globl numchr
	.type	 numchr,@function
numchr:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr. 3,3
	mr 30,4
	li 31,0
	bc 4,2,.L39
	li 3,0
	b .L189
.L41:
	addi 31,31,1
	addi 3,3,1
.L39:
	mr 4,30
	bl strchr
	mr. 3,3
	bc 4,2,.L41
	mr 3,31
.L189:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 numchr,.Lfe6-numchr
	.align 2
	.globl greenText
	.type	 greenText,@function
greenText:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 4,3
	bl greenCopy
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe7:
	.size	 greenText,.Lfe7-greenText
	.align 2
	.globl greenCopy
	.type	 greenCopy,@function
greenCopy:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,4
	mr 30,3
	mr 3,29
	li 31,0
	bl strlen
	mr. 3,3
	bc 4,2,.L191
	li 3,0
	b .L190
.L82:
	lbzx 9,29,31
	addi 0,9,-33
	cmplwi 0,0,94
	bc 12,1,.L83
	ori 0,9,128
	stbx 0,30,31
	b .L81
.L83:
	stbx 9,30,31
.L81:
	addi 31,31,1
.L191:
	cmpw 0,31,3
	bc 12,0,.L82
	li 0,0
	mr 3,30
	stbx 0,30,31
.L190:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 greenCopy,.Lfe8-greenCopy
	.align 2
	.globl strBeginsWith
	.type	 strBeginsWith,@function
strBeginsWith:
	lis 6,0xf
	ori 6,6,16959
.L96:
	lbz 8,0(3)
	lbz 7,0(4)
	addi 3,3,1
	cmpwi 0,8,0
	addi 4,4,1
	bc 4,2,.L90
.L193:
	li 3,1
	blr
.L90:
	cmpwi 0,6,0
	addi 6,6,-1
	bc 12,2,.L193
	cmpw 0,8,7
	bc 12,2,.L89
	addi 0,8,-97
	addi 9,7,-97
	subfic 0,0,25
	subfe 0,0,0
	subfic 9,9,25
	subfe 9,9,9
	addi 11,8,-32
	addi 10,7,-32
	andc 11,11,0
	andc 10,10,9
	and 0,8,0
	and 9,7,9
	or 8,0,11
	or 7,9,10
	cmpw 0,8,7
	bc 12,2,.L89
	li 3,0
	blr
.L89:
	cmpwi 0,8,0
	bc 4,2,.L96
	li 3,1
	blr
.Lfe9:
	.size	 strBeginsWith,.Lfe9-strBeginsWith
	.align 2
	.globl insertValue
	.type	 insertValue,@function
insertValue:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	li 25,0
	mr 27,3
	mr 28,7
	mr 30,4
	stb 25,0(27)
	lbzx 0,30,25
	cmpw 7,25,28
	mr 24,5
	mr 26,6
	li 31,0
	neg 0,0
	li 29,0
	b .L198
.L100:
	lis 6,0xf
	mr 4,24
	add 5,30,31
	ori 6,6,16959
.L103:
	lbz 8,0(4)
	lbz 7,0(5)
	addi 4,4,1
	cmpwi 0,8,0
	addi 5,5,1
	bc 12,2,.L199
	cmpwi 0,6,0
	addi 6,6,-1
	bc 12,2,.L199
	cmpw 0,8,7
	bc 12,2,.L111
	addi 0,8,-97
	addi 9,7,-97
	subfic 0,0,25
	subfe 0,0,0
	subfic 9,9,25
	subfe 9,9,9
	addi 11,8,-32
	addi 10,7,-32
	andc 11,11,0
	andc 10,10,9
	and 0,8,0
	and 9,7,9
	or 8,0,11
	or 7,9,10
	cmpw 0,8,7
	bc 4,2,.L197
.L111:
	cmpwi 0,8,0
	bc 4,2,.L103
.L199:
	li 0,1
.L105:
	cmpwi 0,0,0
	bc 12,2,.L101
	mr 3,26
	bl strlen
	add 3,31,3
	cmplw 0,3,28
	bc 4,0,.L113
	mr 4,26
	add 3,27,29
	bl strcpy
	addi 25,25,1
	mr 3,26
	bl strlen
	add 29,29,3
	mr 3,24
	bl strlen
	add 31,31,3
	b .L98
.L197:
	li 0,0
	b .L105
.L113:
	li 3,-1
	b .L194
.L101:
	lbzx 0,30,31
	addi 31,31,1
	stbx 0,27,29
	addi 29,29,1
.L98:
	lbzx 0,30,31
	cmpw 7,31,28
	neg 0,0
.L198:
	srwi 0,0,31
	mfcr 9
	rlwinm 9,9,29,1
	and. 11,0,9
	bc 4,2,.L100
	cmpw 0,29,28
	bc 4,0,.L117
	li 0,0
	stbx 0,27,29
	b .L118
.L117:
	add 9,28,27
	li 0,0
	stb 0,-1(9)
.L118:
	mr 3,25
.L194:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe10:
	.size	 insertValue,.Lfe10-insertValue
	.align 2
	.globl stringForBitField
	.type	 stringForBitField,@function
stringForBitField:
	lis 9,buf.21@ha
	li 0,0
	la 9,buf.21@l(9)
	li 7,1
	stb 0,32(9)
	mr 11,9
	li 8,49
	li 0,32
	li 9,0
	mtctr 0
	li 10,48
.L200:
	slw 0,7,9
	and. 6,3,0
	bc 12,2,.L34
	stbx 8,11,9
	b .L32
.L34:
	stbx 10,11,9
.L32:
	addi 9,9,1
	bdnz .L200
	lis 3,buf.21@ha
	la 3,buf.21@l(3)
	blr
.Lfe11:
	.size	 stringForBitField,.Lfe11-stringForBitField
	.align 2
	.globl numberOfBitsSet
	.type	 numberOfBitsSet,@function
numberOfBitsSet:
	li 0,32
	mr 10,3
	mtctr 0
	li 3,0
	li 11,0
	li 8,1
.L201:
	slw 0,8,11
	addi 9,3,1
	and 0,10,0
	addi 11,11,1
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,3,0
	or 3,0,9
	bdnz .L201
	blr
.Lfe12:
	.size	 numberOfBitsSet,.Lfe12-numberOfBitsSet
	.align 2
	.globl lowestOrderBit
	.type	 lowestOrderBit,@function
lowestOrderBit:
	li 10,32
	mr 0,3
	mtctr 10
	li 9,0
	li 11,1
.L203:
	slw 3,11,9
	and. 10,0,3
	bclr 4,2
	addi 9,9,1
	bdnz .L203
	li 3,0
	blr
.Lfe13:
	.size	 lowestOrderBit,.Lfe13-lowestOrderBit
	.align 2
	.globl log2
	.type	 log2,@function
log2:
	cmplwi 0,3,1
	li 9,0
	bc 4,1,.L12
.L13:
	srwi 3,3,1
	addi 9,9,1
	cmplwi 0,3,1
	bc 12,1,.L13
.L12:
	mr 3,9
	blr
.Lfe14:
	.size	 log2,.Lfe14-log2
	.align 2
	.globl StuffCmd
	.type	 StuffCmd,@function
StuffCmd:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 27,3
	la 29,gi@l(29)
	li 3,11
	lwz 9,100(29)
	mr 28,4
	mtlr 9
	blrl
	lwz 9,116(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,27
	li 4,1
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 StuffCmd,.Lfe15-StuffCmd
	.section	".rodata"
	.align 3
.LC19:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC20:
	.long 0x437f0000
	.section	".text"
	.align 2
	.globl unicastSound
	.type	 unicastSound,@function
unicastSound:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 28,24(1)
	stw 0,52(1)
	fmr 31,1
	lis 9,.LC19@ha
	mr 30,3
	la 9,.LC19@l(9)
	li 3,9
	lfd 13,0(9)
	mr 28,4
	fmr 0,31
	lis 9,gi@ha
	la 31,gi@l(9)
	lwz 9,100(31)
	fcmpu 7,0,13
	mtlr 9
	mfcr 29
	rlwinm 29,29,31,1
	neg 29,29
	nor 0,29,29
	andi. 0,0,9
	rlwinm 29,29,0,28,28
	or 29,29,0
	blrl
	lwz 9,100(31)
	mr 3,29
	mtlr 9
	blrl
	lwz 9,100(31)
	rlwinm 3,28,0,0xff
	mtlr 9
	blrl
	andi. 0,29,1
	bc 12,2,.L9
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 0,0(9)
	lwz 9,100(31)
	fmuls 0,31,0
	mtlr 9
	fctiwz 13,0
	stfd 13,16(1)
	lwz 3,20(1)
	rlwinm 3,3,0,0xff
	blrl
.L9:
	lis 9,g_edicts@ha
	lis 0,0x478b
	lwz 10,104(31)
	lwz 3,g_edicts@l(9)
	ori 0,0,48365
	mtlr 10
	subf 3,3,30
	mullw 3,3,0
	rlwinm 3,3,1,0,28
	blrl
	lwz 0,92(31)
	mr 3,30
	li 4,1
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe16:
	.size	 unicastSound,.Lfe16-unicastSound
	.section	".rodata"
	.align 2
.LC21:
	.long 0x0
	.align 2
.LC22:
	.long 0xc2c00000
	.align 3
.LC23:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl nearToGround
	.type	 nearToGround,@function
nearToGround:
	stwu 1,-128(1)
	mflr 0
	stw 0,132(1)
	mr 6,3
	lwz 0,612(6)
	cmpwi 0,0,0
	bc 12,1,.L53
	lis 9,.LC21@ha
	lfs 11,4(6)
	lis 11,gi+48@ha
	la 9,.LC21@l(9)
	lfs 8,8(6)
	mr 8,6
	lfs 0,0(9)
	addi 4,6,4
	addi 5,6,188
	lis 9,.LC22@ha
	lfs 10,12(6)
	addi 3,1,56
	la 9,.LC22@l(9)
	lwz 0,gi+48@l(11)
	addi 6,6,200
	lfs 7,0(9)
	fadds 9,11,0
	addi 7,1,24
	lis 9,0x201
	fadds 12,8,0
	mtlr 0
	stfs 0,40(1)
	ori 9,9,59
	stfs 0,44(1)
	fadds 13,10,7
	stfs 11,8(1)
	stfs 9,24(1)
	stfs 12,28(1)
	stfs 13,32(1)
	stfs 8,12(1)
	stfs 10,16(1)
	stfs 7,48(1)
	blrl
	lfs 0,64(1)
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfd 13,0(9)
	fcmpu 7,0,13
	crnor 31,30,30
	mfcr 3
	rlwinm 3,3,0,1
	b .L204
.L53:
	li 3,1
.L204:
	lwz 0,132(1)
	mtlr 0
	la 1,128(1)
	blr
.Lfe17:
	.size	 nearToGround,.Lfe17-nearToGround
	.section	".rodata"
	.align 2
.LC24:
	.long 0x0
	.section	".text"
	.align 2
	.globl playerDistance
	.type	 playerDistance,@function
playerDistance:
	stwu 1,-32(1)
	mflr 0
	stw 0,36(1)
	mr 9,3
	lfs 11,12(4)
	lfs 12,12(9)
	addi 3,1,8
	lfs 13,4(9)
	lfs 0,8(9)
	fsubs 12,12,11
	lfs 10,4(4)
	lfs 11,8(4)
	fsubs 13,13,10
	stfs 12,16(1)
	fsubs 0,0,11
	stfs 13,8(1)
	stfs 0,12(1)
	bl VectorLength
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	cror 3,2,1
	bc 12,3,.L205
	fneg 1,1
.L205:
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe18:
	.size	 playerDistance,.Lfe18-playerDistance
	.align 2
	.globl E_LogClose
	.type	 E_LogClose,@function
E_LogClose:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 31,logfile@ha
	lwz 3,logfile@l(31)
	cmpwi 0,3,0
	bc 12,2,.L50
	lis 9,level+4@ha
	lis 4,.LC9@ha
	lfs 1,level+4@l(9)
	la 4,.LC9@l(4)
	creqv 6,6,6
	bl fprintf
	lwz 3,logfile@l(31)
	bl fclose
	b .L51
.L50:
	lis 9,gi+4@ha
	lis 3,.LC10@ha
	lwz 0,gi+4@l(9)
	la 3,.LC10@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L51:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe19:
	.size	 E_LogClose,.Lfe19-E_LogClose
	.align 2
	.globl ResizeLevelMemory
	.type	 ResizeLevelMemory,@function
ResizeLevelMemory:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 29,4
	la 26,gi@l(9)
	mr 27,3
	lwz 9,132(26)
	mr 3,29
	li 4,766
	mr 31,5
	lwz 28,0(27)
	mtlr 9
	blrl
	cmpw 0,29,31
	mr 30,3
	bc 12,2,.L132
	mr 5,31
	mr 4,28
	crxor 6,6,6
	bl memcpy
	lwz 0,136(26)
	mr 3,28
	mtlr 0
	blrl
	stw 30,0(27)
.L132:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 ResizeLevelMemory,.Lfe20-ResizeLevelMemory
	.align 2
	.globl OpenGamedirFile
	.type	 OpenGamedirFile,@function
OpenGamedirFile:
	stwu 1,-96(1)
	mflr 0
	stmw 27,76(1)
	stw 0,100(1)
	addi 31,1,8
	mr 29,3
	mr 28,4
	mr 27,5
	li 5,64
	li 4,0
	mr 3,31
	crxor 6,6,6
	bl memset
	mr 4,29
	mr 3,31
	bl strcpy
	lis 4,.LC11@ha
	mr 3,31
	la 4,.LC11@l(4)
	bl strcat
	mr 4,28
	mr 3,31
	bl strcat
	mr 4,27
	mr 3,31
	bl fopen
	mr. 29,3
	bc 4,2,.L135
	lis 9,gi+4@ha
	lis 3,.LC12@ha
	lwz 0,gi+4@l(9)
	la 3,.LC12@l(3)
	mr 4,31
	mtlr 0
	crxor 6,6,6
	blrl
.L135:
	mr 3,29
	lwz 0,100(1)
	mtlr 0
	lmw 27,76(1)
	la 1,96(1)
	blr
.Lfe21:
	.size	 OpenGamedirFile,.Lfe21-OpenGamedirFile
	.align 2
	.globl getSettingBit
	.type	 getSettingBit,@function
getSettingBit:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl getSettingNumber
	mr 0,3
	cmpwi 0,0,-1
	bc 12,2,.L137
	li 3,1
	slw 3,3,0
	b .L206
.L137:
	li 3,-1
.L206:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe22:
	.size	 getSettingBit,.Lfe22-getSettingBit
	.align 2
	.globl getSettingNumber
	.type	 getSettingNumber,@function
getSettingNumber:
	stwu 1,-256(1)
	mflr 0
	stmw 26,232(1)
	stw 0,260(1)
	lis 9,e_bits@ha
	mr 28,3
	la 30,e_bits@l(9)
	li 31,0
.L142:
	mr 3,28
	mr 4,30
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L208
	addi 31,31,1
	addi 30,30,25
	cmplwi 0,31,18
	bc 4,1,.L142
	lis 9,e_bits@ha
	li 31,0
	la 29,e_bits@l(9)
	lis 27,.LC13@ha
	li 26,0
	addi 30,1,120
.L148:
	mr 4,29
	stb 26,8(1)
	mr 3,30
	bl strcpy
	mr 3,30
	b .L209
.L151:
	mr 4,3
	addi 3,1,8
	bl strcat
	li 3,0
.L209:
	la 4,.LC13@l(27)
	bl strtok
	mr. 3,3
	bc 4,2,.L151
	mr 3,28
	addi 4,1,8
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L147
.L208:
	mr 3,31
	b .L207
.L147:
	addi 31,31,1
	addi 29,29,25
	cmplwi 0,31,18
	bc 4,1,.L148
	li 3,-1
.L207:
	lwz 0,260(1)
	mtlr 0
	lmw 26,232(1)
	la 1,256(1)
	blr
.Lfe23:
	.size	 getSettingNumber,.Lfe23-getSettingNumber
	.align 2
	.globl addFloodSample
	.type	 addFloodSample,@function
addFloodSample:
	lwz 9,84(3)
	lwz 11,3688(9)
	addi 11,11,1
	stw 11,3688(9)
	lwz 9,84(3)
	lwz 0,3688(9)
	cmpwi 0,0,19
	bc 4,1,.L156
	li 0,0
	stw 0,3688(9)
.L156:
	lwz 11,84(3)
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	lwz 0,3688(11)
	addi 11,11,3608
	slwi 0,0,2
	stfsx 0,11,0
	blr
.Lfe24:
	.size	 addFloodSample,.Lfe24-addFloodSample
	.align 2
	.globl clearFloodSamples
	.type	 clearFloodSamples,@function
clearFloodSamples:
	li 9,20
	lis 0,0xc2c6
	mtctr 9
	li 11,0
.L210:
	lwz 9,84(3)
	addi 9,9,3608
	stwx 0,9,11
	addi 11,11,4
	bdnz .L210
	lwz 9,84(3)
	li 0,0
	stw 0,3688(9)
	blr
.Lfe25:
	.size	 clearFloodSamples,.Lfe25-clearFloodSamples
	.align 2
	.globl checkFlood
	.type	 checkFlood,@function
checkFlood:
	cmpwi 0,4,20
	bc 12,1,.L164
	lwz 10,84(3)
	lwz 11,3688(10)
	addi 10,10,3608
	addi 9,11,1
	subf 9,4,9
	slwi 11,11,2
	lfsx 13,10,11
	nor 0,9,9
	addi 11,9,20
	srawi 0,0,31
	andc 11,11,0
	and 9,9,0
	or 9,9,11
	slwi 9,9,2
	lfsx 0,10,9
	fsubs 13,13,0
	fcmpu 7,13,1
	mfcr 3
	rlwinm 3,3,29,1
	blr
.L164:
	li 3,0
	blr
.Lfe26:
	.size	 checkFlood,.Lfe26-checkFlood
	.comm	flags,4,4
	.comm	gCauseTable,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
