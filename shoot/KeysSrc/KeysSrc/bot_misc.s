	.file	"bot_misc.c"
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
.LC2:
	.string	"makron/step1.wav"
	.align 2
.LC0:
	.long 0x46fffe00
	.align 3
.LC1:
	.long 0x3fd33333
	.long 0x33333333
	.align 2
.LC3:
	.long 0x40000000
	.align 3
.LC4:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC5:
	.long 0x40400000
	.align 2
.LC6:
	.long 0x3f800000
	.align 2
.LC7:
	.long 0x40800000
	.align 2
.LC8:
	.long 0x0
	.section	".text"
	.align 2
	.globl bot_AnimateFrames
	.type	 bot_AnimateFrames,@function
bot_AnimateFrames:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 31,3
	li 9,0
	lfs 11,4(31)
	lfs 0,1016(31)
	lfs 10,8(31)
	lfs 13,1020(31)
	fsubs 0,11,0
	lwz 0,40(31)
	lfs 12,12(31)
	fsubs 13,10,13
	cmpwi 0,0,255
	stfs 0,8(1)
	stfs 11,1016(31)
	stfs 13,12(1)
	stfs 10,1020(31)
	stfs 12,1024(31)
	stw 9,16(1)
	bc 12,2,.L7
	li 0,0
	lis 10,.LC3@ha
	lfs 12,288(31)
	lis 9,level+4@ha
	stw 0,56(31)
	la 10,.LC3@l(10)
	lfs 13,0(10)
	lfs 0,level+4@l(9)
	fsubs 0,0,13
	fcmpu 0,12,0
	bc 4,0,.L6
	bl respawn_bot
	b .L6
.L7:
	lwz 0,56(31)
	cmpwi 0,0,172
	mr 8,0
	bc 4,1,.L9
	lwz 9,84(31)
	li 0,5
	stw 0,3760(9)
	lwz 11,56(31)
	addi 9,11,-173
	addi 0,11,-178
	subfic 9,9,3
	li 9,0
	adde 9,9,9
	subfic 0,0,4
	li 0,0
	adde 0,0,0
	or. 10,9,0
	bc 4,2,.L59
	addi 0,11,-184
	cmplwi 0,0,4
	bc 4,1,.L59
	addi 0,11,-190
	cmplwi 0,0,6
	bc 4,1,.L59
	mr 3,31
	bl CopyToBodyQue
	mr 3,31
	bl respawn_bot
	b .L6
.L9:
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 12,1,.L14
	bl rand
	rlwinm 3,3,0,17,31
	lwz 10,508(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 11,.LC4@ha
	cmpwi 0,10,0
	la 11,.LC4@l(11)
	stw 0,24(1)
	lis 10,.LC5@ha
	lfd 12,0(11)
	la 10,.LC5@l(10)
	lfd 0,24(1)
	lis 11,.LC0@ha
	lfs 13,.LC0@l(11)
	lfs 11,0(10)
	fsub 0,0,12
	frsp 0,0
	fdivs 0,0,13
	fmuls 13,0,11
	bc 4,0,.L15
	li 0,173
	stw 0,56(31)
	b .L6
.L15:
	lis 11,.LC6@ha
	la 11,.LC6@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L17
	li 0,178
	stw 0,56(31)
	b .L6
.L17:
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L19
	li 0,184
	stw 0,56(31)
	b .L6
.L19:
	li 0,190
	stw 0,56(31)
	b .L6
.L14:
	lwz 9,84(31)
	lwz 0,3760(9)
	mr 10,9
	cmpwi 0,0,3
	bc 4,2,.L22
	addi 9,8,1
	stw 9,56(31)
	lwz 0,3756(10)
	cmpw 0,9,0
	bc 4,1,.L6
	li 0,0
	stw 0,56(31)
	stw 0,3760(10)
	b .L6
.L22:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 4,2,.L25
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,2,.L26
	lis 9,level+4@ha
	lis 11,.LC1@ha
	lfs 13,1028(31)
	lfs 0,level+4@l(9)
	lfd 12,.LC1@l(11)
	fsub 0,0,12
	fcmpu 0,13,0
	bc 4,1,.L25
.L26:
	li 0,2
	li 30,66
	stw 0,3760(10)
	li 28,68
	lwz 9,56(31)
	addi 9,9,1
	cmpwi 0,9,66
	stw 9,56(31)
	bc 12,0,.L60
	cmpwi 0,9,68
	bc 4,1,.L6
	stw 28,56(31)
	b .L6
.L25:
	addi 0,8,-68
	cmplwi 0,0,2
	bc 12,1,.L31
	li 0,2
	stw 0,3760(10)
.L59:
	lwz 9,56(31)
	addi 9,9,1
	stw 9,56(31)
	b .L6
.L31:
	addi 0,8,-84
	cmplwi 0,0,50
	bc 12,1,.L33
	li 0,1
	stw 0,3760(10)
	lwz 9,540(31)
	lwz 11,56(31)
	cmpwi 0,9,0
	addi 11,11,1
	stw 11,56(31)
	bc 4,2,.L35
	lwz 0,520(31)
	cmpw 0,11,0
	bc 4,1,.L6
.L35:
	li 0,0
	stw 0,56(31)
	b .L6
.L33:
	addi 0,8,-46
	cmplwi 0,0,2
	bc 12,1,.L37
	li 0,4
	stw 0,3760(10)
	lwz 9,56(31)
	addi 9,9,1
	cmpwi 0,9,48
	b .L61
.L37:
	addi 0,8,-160
	cmplwi 0,0,1
	bc 12,1,.L40
	li 0,4
	stw 0,3760(10)
	lwz 9,56(31)
	addi 9,9,1
	cmpwi 0,9,162
.L61:
	stw 9,56(31)
	bc 4,1,.L6
	li 0,40
	stw 0,56(31)
	b .L6
.L40:
	addi 3,1,8
	bl VectorLength
	lis 9,.LC7@ha
	la 9,.LC7@l(9)
	lfs 13,0(9)
	fcmpu 0,1,13
	bc 4,1,.L43
	lwz 9,84(31)
	li 0,0
	stw 0,3760(9)
	lfs 0,208(31)
	fcmpu 0,0,13
	bc 4,2,.L44
	li 30,154
	li 28,159
	b .L55
.L44:
	lwz 0,612(31)
	li 30,40
	li 28,45
	cmpwi 0,0,0
	bc 4,2,.L55
	lis 9,level+4@ha
	lwz 11,84(31)
	lis 10,.LC1@ha
	lfs 0,level+4@l(9)
	lfs 13,3804(11)
	lfd 12,.LC1@l(10)
	fsub 0,0,12
	fcmpu 0,13,0
	bc 4,0,.L55
	mr 3,31
	bl K2_IsBFK
	cmpwi 0,3,0
	bc 12,2,.L47
	lis 29,gi@ha
	lis 3,.LC2@ha
	la 29,gi@l(29)
	la 3,.LC2@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC6@ha
	lis 10,.LC6@ha
	lis 11,.LC8@ha
	mr 5,3
	la 9,.LC6@l(9)
	la 10,.LC6@l(10)
	mtlr 0
	la 11,.LC8@l(11)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L48
.L47:
	mr 3,31
	bl K2_IsStealth
	cmpwi 0,3,0
	bc 4,2,.L48
	li 0,2
	stw 0,80(31)
.L48:
	lis 9,level+4@ha
	lwz 11,84(31)
	lfs 0,level+4@l(9)
	stfs 0,3804(11)
	b .L55
.L43:
	lwz 9,84(31)
	li 0,0
	stw 0,3760(9)
	lfs 0,208(31)
	fcmpu 0,0,13
	bc 4,2,.L54
	li 30,135
	li 28,153
	b .L55
.L54:
	li 30,0
	li 28,39
.L55:
	lwz 9,56(31)
	addi 9,9,1
	cmpw 0,9,30
	stw 9,56(31)
	bc 12,0,.L60
	cmpw 0,9,28
	bc 4,1,.L6
.L60:
	stw 30,56(31)
.L6:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 bot_AnimateFrames,.Lfe1-bot_AnimateFrames
	.section	".rodata"
	.align 2
.LC9:
	.long 0x0
	.section	".text"
	.align 2
	.globl botDebugPrint
	.type	 botDebugPrint,@function
botDebugPrint:
	mr 12,1
	lis 0,0xfffe
	ori 0,0,65376
	stwux 1,1,0
	mflr 0
	stmw 29,-12(12)
	stw 0,4(12)
	lis 11,0x1
	lis 0,0x1
	ori 11,11,168
	ori 0,0,112
	add 29,1,11
	add 12,1,0
	lis 31,0x100
	addi 11,1,8
	stw 29,20(12)
	stw 11,24(12)
	stw 31,16(12)
	stw 4,12(1)
	stw 5,16(1)
	stw 6,20(1)
	stw 7,24(1)
	stw 8,28(1)
	stw 9,32(1)
	stw 10,36(1)
	bc 4,6,.L63
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L63:
	lis 11,.LC9@ha
	lis 9,bot_debug@ha
	la 11,.LC9@l(11)
	lfs 13,0(11)
	lwz 11,bot_debug@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L62
	addi 9,12,16
	mr 4,3
	lwz 0,4(9)
	mr 5,12
	addi 3,1,112
	lwz 11,8(9)
	stw 0,4(12)
	stw 31,0(12)
	stw 11,8(12)
	bl vsprintf
	lis 9,gi+4@ha
	addi 3,1,112
	lwz 0,gi+4@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L62:
	lwz 11,0(1)
	lwz 0,4(11)
	mtlr 0
	lmw 29,-12(11)
	mr 1,11
	blr
.Lfe2:
	.size	 botDebugPrint,.Lfe2-botDebugPrint
	.section	".rodata"
	.align 2
.LC10:
	.string	"game"
	.align 2
.LC11:
	.string	""
	.align 2
.LC12:
	.string	"/chat.txt"
	.align 2
.LC13:
	.string	"r"
	.align 2
.LC14:
	.string	"\nUnable to read chat.txt\nChat functions not available.\n\n"
	.align 2
.LC15:
	.string	"%c"
	.section	".text"
	.align 2
	.globl ReadBotChat
	.type	 ReadBotChat,@function
ReadBotChat:
	stwu 1,-336(1)
	mflr 0
	stmw 20,288(1)
	stw 0,340(1)
	lis 9,gi@ha
	lis 3,.LC10@ha
	la 30,gi@l(9)
	lis 4,.LC11@ha
	lwz 9,144(30)
	li 5,0
	la 4,.LC11@l(4)
	la 3,.LC10@l(3)
	lis 20,gi@ha
	mtlr 9
	blrl
	lwz 4,4(3)
	addi 3,1,8
	bl strcpy
	lis 4,.LC12@ha
	addi 3,1,8
	la 4,.LC12@l(4)
	bl strcat
	lis 4,.LC13@ha
	addi 3,1,8
	la 4,.LC13@l(4)
	bl fopen
	mr. 31,3
	bc 4,2,.L67
	lwz 0,28(30)
	lis 3,.LC14@ha
	la 3,.LC14@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L66
.L67:
	lis 9,bot_chat_text@ha
	li 4,0
	la 30,bot_chat_text@l(9)
	li 5,2048
	mr 3,30
	crxor 6,6,6
	bl memset
	lhz 0,12(31)
	andi. 9,0,32
	bc 4,2,.L69
	mr 21,30
	lis 26,.LC15@ha
	addi 27,1,264
	li 22,-4
	li 24,-256
.L70:
	mr 3,31
	la 4,.LC15@l(26)
	addi 5,1,264
	crxor 6,6,6
	bl fscanf
	lbz 11,264(1)
	cmpwi 0,11,35
	bc 4,2,.L71
	lhz 0,12(31)
	andi. 9,0,32
	bc 4,2,.L69
.L74:
	mr 3,31
	la 4,.LC15@l(26)
	mr 5,27
	crxor 6,6,6
	bl fscanf
	lhz 0,12(31)
	andi. 9,0,32
	bc 4,2,.L69
	lbz 0,264(1)
	cmpwi 0,0,10
	bc 4,2,.L74
	b .L68
.L71:
	cmpwi 0,11,45
	bc 4,2,.L78
	lhz 0,12(31)
	addi 22,22,4
	addi 24,24,256
	li 23,-1
	andi. 10,0,32
	bc 4,2,.L69
.L81:
	mr 3,31
	la 4,.LC15@l(26)
	mr 5,27
	crxor 6,6,6
	bl fscanf
	lhz 0,12(31)
	andi. 9,0,32
	bc 4,2,.L69
	lbz 0,264(1)
	cmpwi 0,0,10
	bc 4,2,.L81
	b .L68
.L78:
	addi 9,11,-97
	addi 0,11,-65
	subfic 9,9,25
	li 9,0
	adde 9,9,9
	subfic 0,0,25
	li 0,0
	adde 0,0,0
	or. 10,9,0
	bc 4,2,.L86
	cmpwi 0,11,37
	bc 4,2,.L68
.L86:
	la 9,gi@l(20)
	li 4,765
	lwz 0,132(9)
	li 3,256
	addi 23,23,1
	li 29,0
	lis 25,bot_chat_count@ha
	mtlr 0
	blrl
	slwi 0,23,2
	mr 9,3
	add 30,0,24
	stwx 9,21,30
	li 4,0
	li 5,256
	crxor 6,6,6
	bl memset
	lhz 0,12(31)
	andi. 9,0,32
	bc 4,2,.L88
	lbz 0,264(1)
	cmpwi 0,0,10
	bc 12,2,.L88
	lis 9,bot_chat_text@ha
	la 28,bot_chat_text@l(9)
.L89:
	lwzx 9,28,30
	mr 3,31
	la 4,.LC15@l(26)
	mr 5,27
	stbx 0,9,29
	crxor 6,6,6
	bl fscanf
	addi 29,29,1
	lhz 0,12(31)
	andi. 9,0,32
	bc 4,2,.L88
	lbz 0,264(1)
	cmpwi 0,0,10
	bc 4,2,.L89
.L88:
	cmpwi 0,29,0
	bc 4,1,.L92
	slwi 0,23,2
	li 11,0
	add 0,0,24
	lwzx 9,21,0
	stbx 11,9,29
.L92:
	la 9,bot_chat_count@l(25)
	stwx 23,9,22
.L68:
	lhz 0,12(31)
	andi. 10,0,32
	bc 12,2,.L70
.L69:
	mr 3,31
	bl fclose
.L66:
	lwz 0,340(1)
	mtlr 0
	lmw 20,288(1)
	la 1,336(1)
	blr
.Lfe3:
	.size	 ReadBotChat,.Lfe3-ReadBotChat
	.section	".rodata"
	.align 3
.LC16:
	.long 0x4009df3b
	.long 0x645a1cac
	.align 3
.LC17:
	.long 0x4014872b
	.long 0x20c49ba
	.align 3
.LC18:
	.long 0x4011e76c
	.long 0x8b439581
	.align 3
.LC19:
	.long 0x4002d916
	.long 0x872b020c
	.align 3
.LC20:
	.long 0x3ff73f7c
	.long 0xed916873
	.align 3
.LC21:
	.long 0x4003020c
	.long 0x49ba5e35
	.align 3
.LC22:
	.long 0x3fe5b22d
	.long 0xe560419
	.align 3
.LC23:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl GenerateBotData
	.type	 GenerateBotData,@function
GenerateBotData:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 29,gi@ha
	mr 27,4
	la 29,gi@l(29)
	mr 28,3
	lwz 9,132(29)
	li 4,765
	li 3,48
	mtlr 9
	blrl
	mr 31,3
	li 0,0
	stw 0,12(31)
	li 4,765
	li 3,128
	lwz 9,132(29)
	mtlr 9
	blrl
	mr 0,3
	mr 4,27
	stw 0,4(31)
	bl strcpy
	lwz 0,132(29)
	li 4,765
	li 3,128
	mtlr 0
	blrl
	stw 3,8(31)
	lwz 4,8(28)
	bl strcpy
	lbz 0,0(27)
	li 11,0
	li 12,0
	cmpwi 0,0,0
	bc 12,2,.L111
.L112:
	lbzx 0,27,11
	add 0,0,11
	addi 11,11,1
	add 12,12,0
	lbzx 9,27,11
	cmpwi 0,9,0
	bc 4,2,.L112
.L111:
	xoris 0,12,0x8000
	lis 27,0x4330
	stw 0,20(1)
	lis 11,.LC23@ha
	stw 27,16(1)
	la 11,.LC23@l(11)
	lis 10,.LC16@ha
	lfd 6,0(11)
	lis 6,0x6666
	lfd 0,16(1)
	mr 11,9
	ori 6,6,26215
	lfd 11,.LC16@l(10)
	lis 9,.LC17@ha
	mr 29,3
	lfd 12,.LC17@l(9)
	mr 10,3
	mr 7,3
	fsub 0,0,6
	lis 9,.LC18@ha
	mr 28,3
	lfd 13,.LC18@l(9)
	mr 4,3
	lis 5,0x9249
	lis 9,.LC19@ha
	ori 5,5,9363
	fmul 11,0,11
	lfd 9,.LC19@l(9)
	fmul 12,0,12
	fmul 13,0,13
	fctiwz 10,11
	fmul 0,0,9
	fctiwz 8,12
	stfd 10,16(1)
	fctiwz 7,13
	lwz 11,20(1)
	fctiwz 5,0
	mulhw 9,11,6
	srawi 8,11,31
	srawi 9,9,1
	subf 9,8,9
	slwi 0,9,2
	add 0,0,9
	subf 11,0,11
	addi 11,11,1
	xoris 11,11,0x8000
	stw 11,20(1)
	stw 27,16(1)
	lfd 0,16(1)
	stfd 8,16(1)
	lwz 10,20(1)
	fsub 0,0,6
	mulhw 9,10,6
	srawi 11,10,31
	srawi 9,9,1
	frsp 0,0
	subf 9,11,9
	slwi 0,9,2
	add 0,0,9
	stfs 0,16(31)
	subf 10,0,10
	addi 10,10,1
	xoris 10,10,0x8000
	stw 10,20(1)
	stw 27,16(1)
	lfd 0,16(1)
	stfd 7,16(1)
	lwz 7,20(1)
	fsub 0,0,6
	mulhw 6,7,6
	srawi 9,7,31
	srawi 6,6,1
	frsp 0,0
	subf 6,9,6
	slwi 0,6,2
	add 0,0,6
	stfs 0,20(31)
	subf 7,0,7
	addi 7,7,1
	xoris 7,7,0x8000
	stw 7,20(1)
	stw 27,16(1)
	lfd 0,16(1)
	stfd 5,16(1)
	lwz 4,20(1)
	fsub 0,0,6
	mulhw 5,4,5
	srawi 9,4,31
	add 5,5,4
	frsp 0,0
	srawi 5,5,2
	subf 5,9,5
	slwi 0,5,3
	stfs 0,28(31)
	subf 0,5,0
	subf 4,0,4
	addi 4,4,3
	cmplwi 0,4,9
	bc 12,1,.L125
	lis 11,.L115@ha
	slwi 10,4,2
	la 11,.L115@l(11)
	lis 9,.L115@ha
	lwzx 0,10,11
	la 9,.L115@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L115:
	.long .L116-.L115
	.long .L125-.L115
	.long .L117-.L115
	.long .L118-.L115
	.long .L119-.L115
	.long .L120-.L115
	.long .L121-.L115
	.long .L122-.L115
	.long .L123-.L115
	.long .L124-.L115
.L117:
	lis 9,item_shotgun@ha
	lwz 30,item_shotgun@l(9)
	b .L125
.L118:
	lis 9,item_supershotgun@ha
	lwz 30,item_supershotgun@l(9)
	b .L125
.L119:
	lis 9,item_machinegun@ha
	lwz 30,item_machinegun@l(9)
	b .L125
.L120:
	lis 9,item_chaingun@ha
	lwz 30,item_chaingun@l(9)
	b .L125
.L121:
	lis 9,item_grenadelauncher@ha
	lwz 30,item_grenadelauncher@l(9)
	b .L125
.L122:
	lis 9,item_rocketlauncher@ha
	lwz 30,item_rocketlauncher@l(9)
	b .L125
.L123:
	lis 9,item_railgun@ha
	lwz 30,item_railgun@l(9)
	b .L125
.L124:
	lis 9,item_hyperblaster@ha
	lwz 30,item_hyperblaster@l(9)
	b .L125
.L116:
	lis 9,item_bfg10k@ha
	lwz 30,item_bfg10k@l(9)
.L125:
	xoris 11,12,0x8000
	stw 30,32(31)
	stw 11,20(1)
	lis 0,0x4330
	lis 8,.LC21@ha
	lis 11,.LC23@ha
	stw 0,16(1)
	lis 5,.LC22@ha
	la 11,.LC23@l(11)
	lfd 0,16(1)
	mr 7,9
	lfd 7,0(11)
	mr 6,9
	lis 10,0x5555
	lis 11,.LC20@ha
	lfd 13,.LC21@l(8)
	ori 10,10,21846
	lfd 12,.LC20@l(11)
	mr 8,9
	mr 3,31
	fsub 0,0,7
	lfd 11,.LC22@l(5)
	fmul 12,0,12
	fmul 13,0,13
	fmul 0,0,11
	fctiwz 10,12
	fctiwz 9,13
	fctiwz 8,0
	stfd 10,16(1)
	lwz 7,20(1)
	stfd 9,16(1)
	lwz 6,20(1)
	mulhw 11,7,10
	srawi 0,7,31
	stfd 8,16(1)
	lwz 8,20(1)
	subf 11,0,11
	mulhw 10,6,10
	srawi 5,6,31
	slwi 9,11,1
	srawi 0,8,31
	add 9,9,11
	srwi 0,0,30
	subf 10,5,10
	subf 7,9,7
	add 0,8,0
	rlwinm 0,0,0,0,29
	cmpwi 7,7,1
	slwi 9,10,1
	subf 8,0,8
	add 9,9,10
	mulli 8,8,100
	subf 6,9,6
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	xori 6,6,2
	subfic 9,6,0
	adde 6,9,6
	stw 0,36(31)
	stw 6,40(31)
	stw 8,44(31)
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 GenerateBotData,.Lfe4-GenerateBotData
	.section	".rodata"
	.align 2
.LC24:
	.string	"Bot team \"%s\"doesn't have bot list\n"
	.section	".text"
	.align 2
	.globl ReadTeamData
	.type	 ReadTeamData,@function
ReadTeamData:
	stwu 1,-352(1)
	mflr 0
	stmw 21,308(1)
	stw 0,356(1)
	lis 9,gi+132@ha
	mr 27,3
	lwz 0,gi+132@l(9)
	li 4,765
	li 3,160
	addi 29,1,8
	li 31,0
	mtlr 0
	mr 24,29
	lis 22,.LC15@ha
	blrl
	mr 23,3
	lis 4,.LC15@ha
	lwz 3,0(27)
	la 4,.LC15@l(4)
	mr 5,29
	crxor 6,6,6
	bl fscanf
	lbzx 0,29,31
	cmpwi 0,0,34
	bc 12,2,.L135
	mr 30,24
.L136:
	addi 31,31,1
	lwz 3,0(27)
	la 4,.LC15@l(22)
	add 5,30,31
	crxor 6,6,6
	bl fscanf
	lbzx 0,30,31
	cmpwi 7,31,254
	xori 0,0,34
	neg 0,0
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	srwi 0,0,31
	and. 11,0,9
	bc 4,2,.L136
.L135:
	li 0,0
	lis 29,gi@ha
	stbx 0,24,31
	la 29,gi@l(29)
	mr 3,24
	bl strlen
	li 31,0
	lwz 0,132(29)
	li 4,765
	addi 3,3,1
	mtlr 0
	blrl
	mr 0,3
	mr 4,24
	stw 0,0(23)
	bl strcpy
	li 9,9
	lwz 3,0(27)
	stb 9,264(1)
	lhz 0,12(3)
	andi. 9,0,32
	bc 4,2,.L142
.L140:
	la 4,.LC15@l(22)
	addi 5,1,264
	crxor 6,6,6
	bl fscanf
	lwz 3,0(27)
	lhz 0,12(3)
	andi. 9,0,32
	bc 4,2,.L142
	lbz 0,264(1)
	xori 9,0,32
	subfic 11,9,0
	adde 9,11,9
	xori 0,0,9
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 4,2,.L140
.L142:
	lwz 3,0(27)
	lis 4,.LC15@ha
	mr 5,24
	la 4,.LC15@l(4)
	crxor 6,6,6
	bl fscanf
	lbz 0,0(24)
	cmpwi 7,31,254
	xori 0,0,34
	neg 0,0
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	srwi 0,0,31
	and. 11,0,9
	bc 12,2,.L145
	mr 29,24
.L146:
	addi 31,31,1
	lwz 3,0(27)
	la 4,.LC15@l(22)
	add 5,29,31
	crxor 6,6,6
	bl fscanf
	lbzx 0,29,31
	cmpwi 7,31,254
	xori 0,0,34
	neg 0,0
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	srwi 0,0,31
	and. 11,0,9
	bc 4,2,.L146
.L145:
	li 0,0
	lis 29,gi@ha
	stbx 0,24,31
	la 29,gi@l(29)
	mr 3,24
	bl strlen
	li 31,0
	lwz 0,132(29)
	li 4,765
	addi 3,3,1
	mtlr 0
	blrl
	mr 0,3
	mr 4,24
	stw 0,4(23)
	bl strcpy
	li 9,9
	lwz 3,0(27)
	stb 9,264(1)
	lhz 0,12(3)
	andi. 9,0,32
	bc 4,2,.L152
.L150:
	la 4,.LC15@l(22)
	addi 5,1,264
	crxor 6,6,6
	bl fscanf
	lwz 3,0(27)
	lhz 0,12(3)
	andi. 9,0,32
	bc 4,2,.L152
	lbz 0,264(1)
	xori 9,0,32
	subfic 11,9,0
	adde 9,11,9
	xori 0,0,9
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 4,2,.L150
.L152:
	lwz 3,0(27)
	lis 4,.LC15@ha
	mr 5,24
	la 4,.LC15@l(4)
	crxor 6,6,6
	bl fscanf
	lbz 0,0(24)
	cmpwi 7,31,254
	xori 0,0,34
	neg 0,0
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	srwi 0,0,31
	and. 11,0,9
	bc 12,2,.L155
	mr 29,24
.L156:
	addi 31,31,1
	lwz 3,0(27)
	la 4,.LC15@l(22)
	add 5,29,31
	crxor 6,6,6
	bl fscanf
	lbzx 0,29,31
	cmpwi 7,31,254
	xori 0,0,34
	neg 0,0
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	srwi 0,0,31
	and. 11,0,9
	bc 4,2,.L156
.L155:
	li 0,0
	mr 3,24
	stbx 0,24,31
	bl G_CopyString
	stw 3,8(23)
	lis 29,gi@ha
	la 29,gi@l(29)
	mr 3,24
	bl strlen
	lwz 0,132(29)
	li 4,765
	addi 3,3,1
	mtlr 0
	blrl
	mr 0,3
	mr 4,24
	stw 0,8(23)
	bl strcpy
	li 9,0
	lwz 3,0(27)
	stb 9,280(1)
	lhz 0,12(3)
	andi. 9,0,32
	bc 4,2,.L188
.L160:
	la 4,.LC15@l(22)
	addi 5,1,280
	crxor 6,6,6
	bl fscanf
	lbz 0,280(1)
	cmpwi 0,0,91
	bc 12,2,.L159
	lwz 3,0(27)
	lhz 0,12(3)
	andi. 9,0,32
	bc 12,2,.L160
.L159:
	lwz 3,0(27)
	lhz 0,12(3)
	andi. 11,0,32
	bc 12,2,.L163
.L188:
	lis 9,gi+28@ha
	lis 3,.LC24@ha
	lwz 4,0(23)
	lwz 0,gi+28@l(9)
	la 3,.LC24@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
	b .L186
.L163:
	lis 4,.LC15@ha
	addi 5,1,280
	la 4,.LC15@l(4)
	li 29,0
	crxor 6,6,6
	bl fscanf
	mr 26,24
	li 21,0
.L175:
	cmpwi 7,29,31
	bc 12,29,.L187
	lbz 0,280(1)
	cmpwi 0,0,93
	bc 12,2,.L165
	lwz 3,0(27)
	la 4,.LC15@l(22)
	mr 5,26
	li 31,0
	addi 25,29,1
	crxor 6,6,6
	bl fscanf
	slwi 28,29,2
	addi 30,23,12
	lbzx 0,26,31
	cmpwi 0,0,34
	bc 12,2,.L169
	mr 29,24
.L170:
	addi 31,31,1
	lwz 3,0(27)
	la 4,.LC15@l(22)
	add 5,29,31
	crxor 6,6,6
	bl fscanf
	lbzx 0,29,31
	cmpwi 7,31,254
	xori 0,0,34
	neg 0,0
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	srwi 0,0,31
	and. 11,0,9
	bc 4,2,.L170
.L169:
	stbx 21,26,31
	mr 3,26
	bl GetBotData
	cmpwi 0,3,0
	stwx 3,30,28
	bc 4,2,.L172
	mr 3,23
	mr 4,24
	bl GenerateBotData
	lis 9,teambot_list@ha
	lwz 0,teambot_list@l(9)
	stwx 3,30,28
	cmpwi 0,0,0
	bc 4,2,.L173
	stw 3,teambot_list@l(9)
	stw 0,0(3)
	b .L172
.L173:
	stw 0,0(3)
	lwzx 0,30,28
	stw 0,teambot_list@l(9)
.L172:
	li 9,9
	lwz 3,0(27)
	mr 29,25
	stb 9,264(1)
	lhz 0,12(3)
	andi. 9,0,32
	bc 4,2,.L180
.L178:
	la 4,.LC15@l(22)
	addi 5,1,264
	crxor 6,6,6
	bl fscanf
	lwz 3,0(27)
	lhz 0,12(3)
	andi. 9,0,32
	bc 4,2,.L180
	lbz 0,264(1)
	xori 9,0,32
	subfic 11,9,0
	adde 9,11,9
	xori 0,0,9
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 4,2,.L178
.L180:
	lbz 0,264(1)
	cmpwi 7,25,31
	cmpwi 0,0,93
	bc 4,2,.L175
.L165:
	bc 12,29,.L187
	slwi 9,29,2
	li 0,0
	addi 9,9,12
	subfic 29,29,32
	add 9,9,23
.L184:
	addic. 29,29,-1
	stw 0,0(9)
	addi 9,9,4
	bc 4,2,.L184
.L187:
	li 0,0
	mr 3,23
	stw 0,148(23)
	stw 0,144(23)
	stw 0,140(23)
.L186:
	lwz 0,356(1)
	mtlr 0
	lmw 21,308(1)
	la 1,352(1)
	blr
.Lfe5:
	.size	 ReadTeamData,.Lfe5-ReadTeamData
	.section	".rodata"
	.align 2
.LC25:
	.string	"%i"
	.align 3
.LC26:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ReadBotData
	.type	 ReadBotData,@function
ReadBotData:
	stwu 1,-320(1)
	mflr 0
	stfd 31,312(1)
	stmw 26,288(1)
	stw 0,324(1)
	lis 9,gi+132@ha
	mr 31,3
	lwz 9,gi+132@l(9)
	li 4,765
	li 3,48
	li 0,32
	addi 29,1,8
	mtlr 9
	stb 0,264(1)
	mr 28,29
	lis 27,.LC15@ha
	blrl
	li 0,0
	mr 30,3
	stw 0,12(30)
	lis 4,.LC15@ha
	mr 5,29
	lwz 3,0(31)
	la 4,.LC15@l(4)
	stw 0,268(1)
	crxor 6,6,6
	bl fscanf
	lwz 9,268(1)
	lbzx 0,29,9
	cmpwi 7,9,254
	xori 0,0,34
	neg 0,0
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	srwi 0,0,31
	and. 11,0,9
	bc 12,2,.L191
.L192:
	lwz 9,268(1)
	la 4,.LC15@l(27)
	lwz 3,0(31)
	addi 9,9,1
	add 5,29,9
	stw 9,268(1)
	crxor 6,6,6
	bl fscanf
	lwz 9,268(1)
	lbzx 0,29,9
	cmpwi 0,0,10
	bc 12,2,.L224
	cmpwi 7,9,254
	xori 0,0,34
	neg 0,0
	srwi 0,0,31
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	and. 11,0,9
	bc 4,2,.L192
.L191:
	lis 9,gi+132@ha
	li 4,765
	lwz 11,268(1)
	lwz 9,gi+132@l(9)
	li 3,128
	li 0,0
	stbx 0,28,11
	mtlr 9
	blrl
	mr 0,3
	mr 4,28
	stw 0,4(30)
	bl strcpy
	lwz 3,0(31)
	lbz 0,264(1)
	lhz 9,12(3)
	xori 0,0,34
	xori 9,9,32
	neg 0,0
	rlwinm 9,9,27,31,31
	srwi 0,0,31
	and. 11,9,0
	bc 12,2,.L196
.L197:
	la 4,.LC15@l(27)
	addi 5,1,264
	crxor 6,6,6
	bl fscanf
	lbz 9,264(1)
	cmpwi 0,9,10
	bc 12,2,.L223
	lwz 3,0(31)
	xori 9,9,34
	neg 9,9
	lhz 0,12(3)
	srwi 9,9,31
	xori 0,0,32
	rlwinm 0,0,27,31,31
	and. 11,0,9
	bc 4,2,.L197
.L196:
	li 0,0
	lwz 3,0(31)
	lis 4,.LC15@ha
	stw 0,268(1)
	la 4,.LC15@l(4)
	mr 5,28
	crxor 6,6,6
	bl fscanf
	lwz 9,268(1)
	lbzx 0,28,9
	cmpwi 0,0,10
	bc 12,2,.L224
	cmpwi 7,9,254
	xori 0,0,34
	neg 0,0
	srwi 0,0,31
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	and. 11,0,9
	bc 12,2,.L202
	mr 29,28
.L203:
	lwz 9,268(1)
	la 4,.LC15@l(27)
	lwz 3,0(31)
	addi 9,9,1
	add 5,29,9
	stw 9,268(1)
	crxor 6,6,6
	bl fscanf
	lwz 9,268(1)
	lbzx 0,29,9
	cmpwi 0,0,10
	bc 12,2,.L224
	cmpwi 7,9,254
	xori 0,0,34
	neg 0,0
	srwi 0,0,31
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	and. 11,0,9
	bc 4,2,.L203
.L202:
	lis 9,gi+132@ha
	li 4,765
	lwz 11,268(1)
	lwz 9,gi+132@l(9)
	li 3,128
	li 0,0
	stbx 0,28,11
	mtlr 9
	blrl
	mr 0,3
	mr 4,28
	stw 0,8(30)
	bl strcpy
	lwz 3,0(31)
	lis 4,.LC15@ha
	addi 5,1,264
	la 4,.LC15@l(4)
	crxor 6,6,6
	bl fscanf
	lbz 0,264(1)
	cmpwi 0,0,10
	bc 12,2,.L224
	addi 28,1,268
	lis 29,.LC25@ha
	lwz 3,0(31)
	la 4,.LC25@l(29)
	mr 5,28
	crxor 6,6,6
	bl fscanf
	lis 27,0x4330
	lis 9,.LC26@ha
	lwz 0,268(1)
	la 4,.LC25@l(29)
	la 9,.LC26@l(9)
	mr 5,28
	lfd 31,0(9)
	xoris 0,0,0x8000
	stw 0,284(1)
	stw 27,280(1)
	lfd 0,280(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,16(30)
	lwz 3,0(31)
	crxor 6,6,6
	bl fscanf
	lwz 0,268(1)
	la 4,.LC25@l(29)
	mr 5,28
	xoris 0,0,0x8000
	stw 0,284(1)
	stw 27,280(1)
	lfd 0,280(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,20(30)
	lwz 3,0(31)
	crxor 6,6,6
	bl fscanf
	lwz 0,268(1)
	la 4,.LC25@l(29)
	mr 5,28
	xoris 0,0,0x8000
	stw 0,284(1)
	stw 27,280(1)
	lfd 0,280(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,28(30)
	lwz 3,0(31)
	crxor 6,6,6
	bl fscanf
	lwz 0,268(1)
	cmpwi 0,0,1
	bc 4,2,.L207
	li 0,7
	stw 0,268(1)
.L207:
	lwz 10,268(1)
	cmplwi 0,10,9
	bc 12,1,.L219
	lis 11,.L209@ha
	slwi 10,10,2
	la 11,.L209@l(11)
	lis 9,.L209@ha
	lwzx 0,10,11
	la 9,.L209@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L209:
	.long .L210-.L209
	.long .L219-.L209
	.long .L211-.L209
	.long .L212-.L209
	.long .L213-.L209
	.long .L214-.L209
	.long .L215-.L209
	.long .L216-.L209
	.long .L217-.L209
	.long .L218-.L209
.L211:
	lis 9,item_shotgun@ha
	lwz 26,item_shotgun@l(9)
	b .L219
.L212:
	lis 9,item_supershotgun@ha
	lwz 26,item_supershotgun@l(9)
	b .L219
.L213:
	lis 9,item_machinegun@ha
	lwz 26,item_machinegun@l(9)
	b .L219
.L214:
	lis 9,item_chaingun@ha
	lwz 26,item_chaingun@l(9)
	b .L219
.L215:
	lis 9,item_grenadelauncher@ha
	lwz 26,item_grenadelauncher@l(9)
	b .L219
.L216:
	lis 9,item_rocketlauncher@ha
	lwz 26,item_rocketlauncher@l(9)
	b .L219
.L217:
	lis 9,item_railgun@ha
	lwz 26,item_railgun@l(9)
	b .L219
.L218:
	lis 9,item_hyperblaster@ha
	lwz 26,item_hyperblaster@l(9)
	b .L219
.L223:
.L224:
	li 3,0
	b .L221
.L210:
	lis 9,item_bfg10k@ha
	lwz 26,item_bfg10k@l(9)
.L219:
	stw 26,32(30)
	lis 29,.LC25@ha
	addi 5,30,36
	lwz 3,0(31)
	la 4,.LC25@l(29)
	crxor 6,6,6
	bl fscanf
	lwz 3,0(31)
	la 4,.LC25@l(29)
	addi 5,30,40
	crxor 6,6,6
	bl fscanf
	lwz 3,0(31)
	la 4,.LC25@l(29)
	addi 5,30,44
	crxor 6,6,6
	bl fscanf
	mr 3,30
.L221:
	lwz 0,324(1)
	mtlr 0
	lmw 26,288(1)
	lfd 31,312(1)
	la 1,320(1)
	blr
.Lfe6:
	.size	 ReadBotData,.Lfe6-ReadBotData
	.align 2
	.globl ReadViewWeaponModel
	.type	 ReadViewWeaponModel,@function
ReadViewWeaponModel:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 30,3
	li 9,32
	lwz 3,0(30)
	li 31,0
	stb 9,8(1)
	lhz 0,12(3)
	xori 0,0,32
	andi. 8,0,32
	bc 12,2,.L228
	lis 9,view_weapon_models@ha
	lis 27,.LC15@ha
	la 28,view_weapon_models@l(9)
	lis 29,num_view_weapons@ha
.L229:
	la 4,.LC15@l(27)
	addi 5,1,8
	crxor 6,6,6
	bl fscanf
	lbz 10,8(1)
	rlwinm 11,10,0,0xff
	xori 9,11,34
	xori 0,11,10
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,9,0
	bc 12,2,.L227
	cmpwi 0,11,13
	bc 12,2,.L227
	lwz 0,num_view_weapons@l(29)
	slwi 0,0,6
	add 0,31,0
	stbx 10,28,0
	addi 31,31,1
.L227:
	lwz 3,0(30)
	lbz 0,8(1)
	lhz 9,12(3)
	xori 0,0,10
	xori 9,9,32
	neg 0,0
	rlwinm 9,9,27,31,31
	srwi 0,0,31
	and. 11,9,0
	bc 4,2,.L229
.L228:
	cmpwi 0,31,0
	bc 4,1,.L232
	lis 8,num_view_weapons@ha
	lis 11,view_weapon_models@ha
	lwz 9,num_view_weapons@l(8)
	la 11,view_weapon_models@l(11)
	li 10,0
	slwi 0,9,6
	addi 9,9,1
	add 0,31,0
	stw 9,num_view_weapons@l(8)
	stbx 10,11,0
.L232:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 ReadViewWeaponModel,.Lfe7-ReadViewWeaponModel
	.globl read_bot_cfg
	.section	".sdata","aw"
	.align 2
	.type	 read_bot_cfg,@object
	.size	 read_bot_cfg,4
read_bot_cfg:
	.long 0
	.section	".rodata"
	.align 2
.LC27:
	.string	"/bots.cfg"
	.align 2
.LC28:
	.string	"Unable to read bots.cfg. Cannot continue.\n"
	.align 2
.LC29:
	.string	"\nReading bots.cfg..."
	.align 2
.LC30:
	.string	"Eraser"
	.align 2
.LC31:
	.string	"male\razor.pcx"
	.align 2
.LC32:
	.string	"\n"
	.align 2
.LC33:
	.string	"\nError in BOTS.CFG: Invalid BOT (#%i)\nEither re-install Eraser, or check your bots.cfg file for errors\n\n"
	.align 2
.LC34:
	.string	"\nError in BOTS.CFG: Invalid TEAM (#%i)\nEither re-install Eraser, or check your bots.cfg file for errors\n\n"
	.align 2
.LC35:
	.string	"Warning: MAX_TEAMS reached, unable to process all teams\n"
	.align 2
.LC36:
	.string	"%i bots read.\n"
	.align 2
.LC37:
	.string	"%i teams read.\n"
	.align 2
.LC38:
	.string	"WARNING: usevwep enabled, but no [view weapon] section in bots.cfg\n  You should re-install Eraser to restore the [view weapons] section.\n\n"
	.align 2
.LC39:
	.long 0x0
	.section	".text"
	.align 2
	.globl ReadBotConfig
	.type	 ReadBotConfig,@function
ReadBotConfig:
	stwu 1,-352(1)
	mflr 0
	stfd 31,344(1)
	stmw 18,288(1)
	stw 0,356(1)
	lis 9,read_bot_cfg@ha
	li 25,0
	lwz 0,read_bot_cfg@l(9)
	cmpwi 0,0,0
	bc 4,2,.L233
	lis 9,gi@ha
	lis 3,.LC10@ha
	la 30,gi@l(9)
	lis 4,.LC11@ha
	lwz 9,144(30)
	li 5,0
	la 4,.LC11@l(4)
	la 3,.LC10@l(3)
	mtlr 9
	blrl
	lwz 4,4(3)
	addi 3,1,8
	bl strcpy
	lis 4,.LC27@ha
	addi 3,1,8
	la 4,.LC27@l(4)
	bl strcat
	lis 4,.LC13@ha
	addi 3,1,8
	la 4,.LC13@l(4)
	bl fopen
	cmpwi 0,3,0
	stw 3,268(1)
	bc 4,2,.L235
	lwz 0,28(30)
	lis 3,.LC28@ha
	la 3,.LC28@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L233
.L235:
	li 11,64
	lis 9,bot_teams@ha
	mtctr 11
	la 9,bot_teams@l(9)
	lis 18,botinfo_list@ha
	lis 19,.LC30@ha
	addi 9,9,252
	lis 23,total_teams@ha
	lis 20,usevwep@ha
	lis 21,.LC32@ha
	li 0,0
.L292:
	stw 0,0(9)
	addi 9,9,-4
	bdnz .L292
	lis 29,gi@ha
	lis 3,.LC29@ha
	la 29,gi@l(29)
	la 3,.LC29@l(3)
	lwz 9,4(29)
	lis 28,botinfo_list@ha
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,132(29)
	li 3,48
	li 4,765
	mtlr 0
	blrl
	lis 9,.LC30@ha
	lis 11,.LC31@ha
	stw 3,botinfo_list@l(28)
	la 9,.LC30@l(9)
	lis 7,0x40a0
	li 0,0
	la 11,.LC31@l(11)
	stw 9,4(3)
	li 8,0
	stw 7,28(3)
	lis 10,.L242+32@ha
	stw 0,12(3)
	lis 9,.L242@ha
	stw 11,8(3)
	la 9,.L242@l(9)
	stw 8,20(3)
	stw 7,16(3)
	lwz 0,.L242+32@l(10)
	add 9,9,0
	mtctr 9
	bctr
	.align 2
	.align 2
.L242:
	.long .L243-.L242
	.long .L252-.L242
	.long .L244-.L242
	.long .L245-.L242
	.long .L246-.L242
	.long .L247-.L242
	.long .L248-.L242
	.long .L249-.L242
	.long .L250-.L242
	.long .L251-.L242
.L244:
	lis 9,item_shotgun@ha
	lwz 31,item_shotgun@l(9)
	b .L252
.L245:
	lis 9,item_supershotgun@ha
	lwz 31,item_supershotgun@l(9)
	b .L252
.L246:
	lis 9,item_machinegun@ha
	lwz 31,item_machinegun@l(9)
	b .L252
.L247:
	lis 9,item_chaingun@ha
	lwz 31,item_chaingun@l(9)
	b .L252
.L248:
	lis 9,item_grenadelauncher@ha
	lwz 31,item_grenadelauncher@l(9)
	b .L252
.L249:
	lis 9,item_rocketlauncher@ha
	lwz 31,item_rocketlauncher@l(9)
	b .L252
.L250:
	lis 9,item_railgun@ha
	lwz 31,item_railgun@l(9)
	b .L252
.L251:
	lis 9,item_hyperblaster@ha
	lwz 31,item_hyperblaster@l(9)
	b .L252
.L290:
	lis 9,gi+28@ha
	lis 11,total_bots@ha
	lwz 0,gi+28@l(9)
	lis 3,.LC33@ha
	la 3,.LC33@l(3)
	lwz 4,total_bots@l(11)
	b .L293
.L291:
	lis 9,gi+28@ha
	lis 3,.LC34@ha
	lwz 0,gi+28@l(9)
	la 3,.LC34@l(3)
.L293:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L255
.L243:
	lis 9,item_bfg10k@ha
	lwz 31,item_bfg10k@l(9)
.L252:
	lis 9,botinfo_list@ha
	li 0,0
	lwz 11,botinfo_list@l(9)
	li 10,1
	lis 7,total_bots@ha
	li 9,50
	lis 6,teambot_list@ha
	stw 9,44(11)
	lis 8,num_view_weapons@ha
	lis 29,total_teams@ha
	stw 31,32(11)
	lis 3,view_weapon_models@ha
	mr 28,11
	stw 10,36(11)
	la 3,view_weapon_models@l(3)
	li 4,0
	stw 0,40(11)
	li 5,4096
	lis 24,total_bots@ha
	stw 10,total_bots@l(7)
	stw 0,num_view_weapons@l(8)
	stw 0,total_teams@l(29)
	stw 0,teambot_list@l(6)
	crxor 6,6,6
	bl memset
	lis 9,gi@ha
	lis 11,bot_teams@ha
	la 26,gi@l(9)
	la 22,bot_teams@l(11)
	b .L254
.L257:
	lbz 0,264(1)
	cmpwi 0,0,35
	bc 4,2,.L258
.L261:
	la 4,.LC15@l(30)
	mr 5,27
	crxor 6,6,6
	bl fscanf
	lwz 3,268(1)
	lhz 0,12(3)
	andi. 9,0,32
	bc 4,2,.L255
	lbz 0,264(1)
	cmpwi 0,0,10
	bc 4,2,.L261
	b .L254
.L258:
	cmpwi 0,0,91
	bc 4,2,.L265
	la 4,.LC15@l(31)
	mr 5,29
	crxor 6,6,6
	bl fscanf
	lbz 0,264(1)
	cmpwi 0,0,98
	bc 4,2,.L266
	li 25,0
	b .L267
.L266:
	cmpwi 0,0,116
	bc 4,2,.L268
	li 25,1
	b .L267
.L268:
	cmpwi 0,0,118
	bc 4,2,.L267
	lwz 9,usevwep@l(20)
	lis 11,.LC39@ha
	la 11,.LC39@l(11)
	lfs 13,0(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L255
	li 25,2
.L267:
	lwz 3,268(1)
	la 4,.LC32@l(21)
	crxor 6,6,6
	bl fscanf
	b .L254
.L265:
	cmpwi 0,0,34
	bc 4,2,.L254
	cmpwi 0,25,0
	bc 4,2,.L274
	addi 3,1,268
	mr 29,28
	bl ReadBotData
	mr. 28,3
	bc 12,2,.L290
	lwz 3,4(28)
	la 4,.LC30@l(19)
	bl strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L276
	lwz 9,136(26)
	mr 3,28
	mr 28,29
	mtlr 9
	blrl
	b .L254
.L276:
	lwz 9,total_bots@l(24)
	cmpwi 0,29,0
	addi 9,9,1
	stw 9,total_bots@l(24)
	bc 12,2,.L278
	stw 28,0(29)
	b .L279
.L278:
	stw 28,botinfo_list@l(18)
.L279:
	li 0,0
	stw 0,0(28)
	b .L254
.L274:
	cmpwi 0,25,1
	bc 4,2,.L281
	addi 3,1,268
	bl ReadTeamData
	lwz 4,total_teams@l(23)
	cmpwi 0,3,0
	slwi 0,4,2
	stwx 3,22,0
	bc 12,2,.L291
	addi 0,4,1
	cmpwi 0,0,64
	stw 0,total_teams@l(23)
	bc 4,2,.L254
	lwz 0,4(26)
	lis 3,.LC35@ha
	la 3,.LC35@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L255
.L281:
	cmpwi 0,25,2
	bc 4,2,.L254
	addi 3,1,268
	bl ReadViewWeaponModel
.L254:
	lwz 3,268(1)
	lhz 0,12(3)
	andi. 9,0,32
	bc 4,2,.L255
	addi 29,1,264
	lis 31,.LC15@ha
	la 4,.LC15@l(31)
	mr 5,29
	crxor 6,6,6
	bl fscanf
	mr 27,29
	lis 30,.LC15@ha
	lwz 3,268(1)
	lhz 0,12(3)
	andi. 9,0,32
	bc 12,2,.L257
.L255:
	lis 9,gi@ha
	lis 11,total_bots@ha
	la 31,gi@l(9)
	lwz 4,total_bots@l(11)
	lis 3,.LC36@ha
	lwz 11,4(31)
	la 3,.LC36@l(3)
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	mtlr 11
	lfs 31,0(9)
	crxor 6,6,6
	blrl
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L287
	lwz 11,4(31)
	lis 9,total_teams@ha
	lis 3,.LC37@ha
	la 3,.LC37@l(3)
	lwz 4,total_teams@l(9)
	mtlr 11
	crxor 6,6,6
	blrl
.L287:
	lwz 9,4(31)
	lis 3,.LC32@ha
	la 3,.LC32@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
	lis 9,usevwep@ha
	lwz 11,usevwep@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L288
	lis 9,num_view_weapons@ha
	lwz 0,num_view_weapons@l(9)
	cmpwi 0,0,0
	bc 4,2,.L288
	lwz 0,4(31)
	lis 3,.LC38@ha
	la 3,.LC38@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L288:
	lwz 3,268(1)
	bl fclose
	bl ReadBotChat
	lis 9,read_bot_cfg@ha
	li 0,1
	stw 0,read_bot_cfg@l(9)
.L233:
	lwz 0,356(1)
	mtlr 0
	lmw 18,288(1)
	lfd 31,344(1)
	la 1,352(1)
	blr
.Lfe8:
	.size	 ReadBotConfig,.Lfe8-ReadBotConfig
	.section	".rodata"
	.align 2
.LC40:
	.string	"No bots available!\n"
	.align 2
.LC42:
	.string	"GetBotData(): random selection didn't work\n"
	.align 2
.LC41:
	.long 0x46fffe00
	.align 3
.LC43:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC44:
	.long 0x0
	.section	".text"
	.align 2
	.globl GetBotData
	.type	 GetBotData,@function
GetBotData:
	stwu 1,-320(1)
	mflr 0
	stmw 23,284(1)
	stw 0,324(1)
	lis 9,botinfo_list@ha
	li 25,0
	lwz 31,botinfo_list@l(9)
	lis 23,botinfo_list@ha
	cmpwi 0,31,0
	bc 4,2,.L302
	lis 9,gi+4@ha
	lis 3,.LC40@ha
	lwz 0,gi+4@l(9)
	la 3,.LC40@l(3)
	b .L391
.L302:
	cmpwi 0,3,0
	bc 4,2,.L303
	lis 30,total_bots@ha
	lis 31,bot_count@ha
	lwz 9,total_bots@l(30)
	li 24,0
	lwz 0,bot_count@l(31)
	addi 9,9,-1
	cmpw 0,9,0
	bc 4,2,.L304
	li 3,0
	b .L384
.L304:
	bl rand
	rlwinm 3,3,0,17,31
	lwz 10,bot_count@l(31)
	xoris 3,3,0x8000
	lis 7,0x4330
	lwz 0,total_bots@l(30)
	stw 3,276(1)
	lis 8,.LC43@ha
	addi 10,10,1
	stw 7,272(1)
	la 8,.LC43@l(8)
	subf 0,10,0
	lfd 12,0(8)
	mr 9,11
	xoris 0,0,0x8000
	lfd 13,272(1)
	lis 8,.LC41@ha
	lfs 11,.LC41@l(8)
	stw 0,276(1)
	fsub 13,13,12
	stw 7,272(1)
	lfd 0,272(1)
	frsp 13,13
	fsub 0,0,12
	fdivs 13,13,11
	frsp 0,0
	fmuls 13,13,0
	fmr 1,13
	bl ceil
	fctiwz 0,1
	lwz 9,botinfo_list@l(23)
	lwz 30,0(9)
	stfd 0,272(1)
	lwz 10,276(1)
	addic 0,30,-1
	subfe 9,0,30
	srawi 0,10,31
	b .L392
.L307:
	lwz 11,12(30)
	addi 9,10,-1
	srawi 8,11,31
	xor 0,8,11
	subf 0,0,8
	srawi 0,0,31
	andc 9,9,0
	and 0,10,0
	or. 10,0,9
	bc 4,1,.L305
	lwz 30,0(30)
.L305:
	srawi 0,10,31
	addic 11,30,-1
	subfe 9,11,30
.L392:
	subf 0,10,0
	srwi 0,0,31
	and. 8,9,0
	bc 4,2,.L307
	cmpwi 0,30,0
	bc 12,2,.L312
.L313:
	srawi 10,25,31
	lwz 0,12(30)
	li 27,1
	xor 9,10,25
	subf 9,9,10
	cmpwi 0,0,0
	srawi 9,9,31
	andc 11,30,9
	and 9,25,9
	or 25,9,11
	bc 12,2,.L315
	li 27,0
	b .L316
.L315:
	lis 11,usevwep@ha
	lis 8,.LC44@ha
	lwz 9,usevwep@l(11)
	la 8,.LC44@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L316
	lwz 4,8(30)
	addi 3,1,8
	lis 26,num_view_weapons@ha
	bl strcpy
	mr 9,1
	li 11,0
	lbzu 0,8(9)
	cmpwi 0,0,0
	mr 28,9
	bc 12,2,.L319
	cmpwi 0,0,47
	bc 4,2,.L320
	stbx 11,28,11
	b .L319
.L390:
	li 0,1
	b .L329
.L320:
	addi 11,11,1
	lbzx 0,28,11
	cmpwi 0,0,0
	bc 12,2,.L319
	cmpwi 0,0,47
	bc 4,2,.L320
	li 0,0
	stbx 0,28,11
.L319:
	lwz 0,num_view_weapons@l(26)
	li 31,0
	cmpw 0,31,0
	bc 4,0,.L331
	lis 9,view_weapon_models@ha
	la 29,view_weapon_models@l(9)
.L327:
	mr 3,29
	mr 4,28
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L390
	lwz 0,num_view_weapons@l(26)
	addi 31,31,1
	addi 29,29,64
	cmpw 0,31,0
	bc 12,0,.L327
.L331:
	li 0,0
.L329:
	neg 0,0
	and 27,27,0
.L316:
	cmpwi 7,27,0
	bc 4,30,.L311
	lwz 30,0(30)
	cmpwi 0,30,0
	bc 4,2,.L311
	cmpwi 0,24,1
	bc 12,1,.L334
	lwz 9,botinfo_list@l(23)
	lwz 30,0(9)
.L334:
	addi 24,24,1
.L311:
	mfcr 9
	rlwinm 9,9,31,1
	addic 8,30,-1
	subfe 0,8,30
	and. 10,9,0
	bc 4,2,.L313
.L312:
	cmpwi 0,30,0
	bc 4,2,.L364
	cmpwi 0,25,0
	bc 12,2,.L338
	mr 3,25
	b .L384
.L338:
	lis 9,gi+4@ha
	lis 3,.LC42@ha
	lwz 0,gi+4@l(9)
	la 3,.LC42@l(3)
.L391:
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
	b .L384
.L303:
	addi 29,1,136
	mr 4,3
	mr 3,29
	mr 27,29
	bl strcpy
	mr 30,31
	lbz 9,0(29)
	addi 28,1,8
	li 11,0
	xori 0,9,91
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,9,0
	bc 12,2,.L342
	mr 10,27
.L343:
	addi 11,11,1
	lbzx 9,10,11
	xori 0,9,91
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,9,0
	bc 4,2,.L343
.L342:
	lbzx 0,27,11
	cmpwi 0,0,91
	bc 4,2,.L345
	li 0,0
	stbx 0,27,11
.L345:
	cmpwi 0,31,0
	lwz 4,4(31)
	addi 3,1,8
	mfcr 31
	bl strcpy
	lbz 0,0(28)
	li 11,0
	cmpwi 0,0,0
	bc 12,2,.L347
	cmpwi 0,0,91
	bc 12,2,.L385
.L348:
	addi 11,11,1
	cmpwi 0,11,127
	bc 12,1,.L347
	lbzx 0,28,11
	cmpwi 0,0,0
	bc 12,2,.L347
	cmpwi 0,0,91
	bc 4,2,.L348
.L347:
	lbzx 0,28,11
	cmpwi 0,0,91
	bc 4,2,.L351
.L385:
	li 0,0
	stbx 0,28,11
.L351:
	mr 25,28
	li 26,0
	b .L352
.L354:
	lwz 30,0(30)
	cmpwi 0,30,0
	mfcr 29
	bc 12,2,.L387
	lwz 4,4(30)
	addi 3,1,8
	mr 31,29
	bl strcpy
	lbz 0,0(25)
	li 11,0
	cmpwi 0,0,0
	bc 12,2,.L358
	cmpwi 0,0,91
	bc 12,2,.L386
.L359:
	addi 11,11,1
	cmpwi 0,11,127
	bc 12,1,.L358
	lbzx 0,28,11
	cmpwi 0,0,0
	bc 12,2,.L358
	cmpwi 0,0,91
	bc 4,2,.L359
.L358:
	lbzx 0,28,11
	cmpwi 0,0,91
	bc 4,2,.L352
.L386:
	stbx 26,28,11
.L352:
	mtcrf 128,31
	bc 12,2,.L387
	mr 3,27
	addi 4,1,8
	bl strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L354
	mtcrf 128,31
	bc 4,2,.L364
.L387:
	lis 9,teambot_list@ha
	lwz 30,teambot_list@l(9)
	cmpwi 0,30,0
	bc 12,2,.L365
	lwz 4,4(30)
	addi 3,1,8
	bl strcpy
	lbz 0,0(28)
	li 11,0
	cmpwi 0,0,0
	bc 12,2,.L367
	cmpwi 0,0,91
	bc 12,2,.L388
.L368:
	addi 11,11,1
	cmpwi 0,11,127
	bc 12,1,.L367
	lbzx 0,28,11
	cmpwi 0,0,0
	bc 12,2,.L367
	cmpwi 0,0,91
	bc 4,2,.L368
.L367:
	lbzx 0,28,11
	cmpwi 0,0,91
	bc 4,2,.L365
.L388:
	li 0,0
	stbx 0,28,11
.L365:
	cmpwi 0,30,0
	mfcr 31
	b .L372
.L374:
	lwz 30,0(30)
	cmpwi 7,30,0
	mfcr 29
	rlwinm 29,29,28,0xf0000000
	mcrf 0,7
	bc 12,2,.L364
	lwz 4,4(30)
	addi 3,1,8
	mr 31,29
	bl strcpy
	lbz 0,0(28)
	li 11,0
	cmpwi 0,0,0
	bc 12,2,.L378
	cmpwi 0,0,91
	bc 12,2,.L389
.L379:
	addi 11,11,1
	cmpwi 0,11,127
	bc 12,1,.L378
	lbzx 0,28,11
	cmpwi 0,0,0
	bc 12,2,.L378
	cmpwi 0,0,91
	bc 4,2,.L379
.L378:
	lbzx 0,28,11
	cmpwi 0,0,91
	bc 4,2,.L372
.L389:
	li 0,0
	stbx 0,28,11
.L372:
	mtcrf 128,31
	bc 12,2,.L364
	mr 3,27
	addi 4,1,8
	bl strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L374
.L364:
	mr 3,30
.L384:
	lwz 0,324(1)
	mtlr 0
	lmw 23,284(1)
	la 1,320(1)
	blr
.Lfe9:
	.size	 GetBotData,.Lfe9-GetBotData
	.section	".rodata"
	.align 2
.LC46:
	.long 0x0
	.align 2
.LC47:
	.long 0x41000000
	.align 2
.LC48:
	.long 0x43800000
	.section	".text"
	.align 2
	.globl FindVisibleItemsFromNode
	.type	 FindVisibleItemsFromNode,@function
FindVisibleItemsFromNode:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 26,32(1)
	stw 0,68(1)
	mr 28,3
	li 11,0
.L397:
	cmpwi 0,11,0
	bc 4,2,.L398
	lis 9,weapons_head@ha
	lwz 31,weapons_head@l(9)
	b .L399
.L398:
	cmpwi 0,11,1
	bc 4,2,.L400
	lis 9,health_head@ha
	lwz 31,health_head@l(9)
	b .L399
.L400:
	cmpwi 0,11,2
	bc 4,2,.L402
	lis 9,ammo_head@ha
	lwz 31,ammo_head@l(9)
	b .L399
.L402:
	lis 9,bonus_head@ha
	lwz 31,bonus_head@l(9)
.L399:
	cmpwi 0,31,0
	addi 27,11,1
	bc 12,2,.L396
	lis 9,gi@ha
	la 26,gi@l(9)
.L406:
	lis 9,.LC46@ha
	lis 10,.LC46@ha
	la 9,.LC46@l(9)
	la 10,.LC46@l(10)
	lfs 1,0(9)
	lis 9,.LC47@ha
	lfs 2,0(10)
	la 9,.LC47@l(9)
	lfs 3,0(9)
	bl tv
	lis 9,.LC46@ha
	lfs 13,0(3)
	lis 10,.LC46@ha
	lfs 0,4(31)
	la 9,.LC46@l(9)
	la 10,.LC46@l(10)
	lfs 1,0(9)
	lis 9,.LC47@ha
	lfs 2,0(10)
	fsubs 0,0,13
	la 9,.LC47@l(9)
	lfs 3,0(9)
	stfs 0,8(1)
	bl tv
	lis 9,.LC46@ha
	lfs 13,4(3)
	lis 10,.LC46@ha
	lfs 0,8(31)
	la 9,.LC46@l(9)
	la 10,.LC46@l(10)
	lfs 1,0(9)
	lis 9,.LC47@ha
	lfs 2,0(10)
	fsubs 0,0,13
	la 9,.LC47@l(9)
	lfs 3,0(9)
	stfs 0,12(1)
	bl tv
	lfs 13,8(3)
	lfs 0,12(31)
	addi 3,1,8
	lwz 9,52(26)
	fsubs 0,0,13
	mtlr 9
	stfs 0,16(1)
	blrl
	andi. 0,3,24
	bc 4,2,.L409
	mr 3,31
	mr 4,28
	bl entdist
	lis 9,.LC48@ha
	fmr 31,1
	la 9,.LC48@l(9)
	lfs 0,0(9)
	fcmpu 0,31,0
	bc 12,1,.L409
	addi 9,31,1176
	li 30,0
	lwzx 0,9,30
	mr 29,9
	cmpwi 0,0,0
	bc 12,0,.L411
	mr 11,29
.L412:
	addi 30,30,1
	lwzu 0,4(11)
	cmpwi 7,30,23
	nor 0,0,0
	srwi 0,0,31
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	and. 10,0,9
	bc 4,2,.L412
.L411:
	cmpwi 0,30,24
	bc 12,2,.L409
	mr 3,28
	mr 4,31
	bl visible_box
	cmpwi 0,3,0
	bc 12,2,.L409
	mr 3,28
	mr 4,31
	bl CanReach
	cmpwi 0,3,0
	bc 12,2,.L409
	lwz 9,1276(28)
	slwi 0,30,2
	stwx 9,29,0
	lwz 4,416(31)
	cmpwi 0,4,0
	bc 12,2,.L417
	mr 3,31
	bl entdist
	fcmpu 0,31,1
	bc 4,0,.L409
.L417:
	stw 28,416(31)
.L409:
	lwz 31,936(31)
	cmpwi 0,31,0
	bc 4,2,.L406
.L396:
	mr 11,27
	cmpwi 0,11,3
	bc 4,1,.L397
	lwz 0,68(1)
	mtlr 0
	lmw 26,32(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe10:
	.size	 FindVisibleItemsFromNode,.Lfe10-FindVisibleItemsFromNode
	.section	".rodata"
	.align 3
.LC49:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC50:
	.long 0x40040000
	.long 0x0
	.align 2
.LC51:
	.long 0x40a00000
	.align 2
.LC52:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl AdjustRatingsToSkill
	.type	 AdjustRatingsToSkill,@function
AdjustRatingsToSkill:
	stwu 1,-16(1)
	lwz 9,1076(3)
	lis 0,0x4330
	lis 7,.LC49@ha
	lwz 10,1072(3)
	lis 8,.LC50@ha
	addi 9,9,-1
	la 7,.LC49@l(7)
	xoris 9,9,0x8000
	lfd 13,0(7)
	la 8,.LC50@l(8)
	stw 9,12(1)
	lis 7,.LC51@ha
	stw 0,8(1)
	la 7,.LC51@l(7)
	lfd 0,8(1)
	lfs 12,16(10)
	lfd 11,0(8)
	fsub 0,0,13
	lwz 8,1068(3)
	lfs 10,0(7)
	frsp 0,0
	fmr 13,0
	fmadd 13,13,11,12
	frsp 13,13
	stfs 13,0(8)
	lwz 9,1068(3)
	lfs 0,0(9)
	fcmpu 0,0,10
	bc 4,1,.L421
	stfs 10,0(9)
	b .L422
.L421:
	lis 8,.LC52@ha
	la 8,.LC52@l(8)
	lfs 13,0(8)
	fcmpu 0,0,13
	bc 4,0,.L422
	stfs 13,0(9)
.L422:
	lwz 9,1076(3)
	lis 0,0x4330
	lis 10,.LC49@ha
	lis 7,.LC50@ha
	lwz 8,1068(3)
	addi 9,9,-1
	la 10,.LC49@l(10)
	xoris 9,9,0x8000
	lfd 13,0(10)
	la 7,.LC50@l(7)
	stw 9,12(1)
	stw 0,8(1)
	lfd 0,8(1)
	lwz 10,1072(3)
	lfd 11,0(7)
	fsub 0,0,13
	lfs 12,28(10)
	lis 7,.LC51@ha
	la 7,.LC51@l(7)
	lfs 10,0(7)
	frsp 0,0
	fmr 13,0
	fmadd 13,13,11,12
	frsp 13,13
	stfs 13,12(8)
	lwz 9,1068(3)
	lfs 0,12(9)
	fcmpu 0,0,10
	bc 4,1,.L424
	stfs 10,12(9)
	b .L425
.L424:
	lis 8,.LC52@ha
	la 8,.LC52@l(8)
	lfs 13,0(8)
	fcmpu 0,0,13
	bc 4,0,.L425
	stfs 13,12(9)
.L425:
	lwz 9,1076(3)
	lis 0,0x4330
	lis 10,.LC49@ha
	lwz 8,1068(3)
	lis 7,.LC51@ha
	addi 9,9,-1
	la 10,.LC49@l(10)
	xoris 9,9,0x8000
	lfd 12,0(10)
	la 7,.LC51@l(7)
	stw 9,12(1)
	stw 0,8(1)
	lfd 0,8(1)
	lwz 10,1072(3)
	lfs 11,0(7)
	fsub 0,0,12
	lfs 13,20(10)
	frsp 0,0
	fadds 0,0,0
	fsubs 13,13,0
	stfs 13,4(8)
	lwz 3,1068(3)
	lfs 0,4(3)
	fcmpu 0,0,11
	bc 4,1,.L427
	stfs 11,4(3)
	b .L428
.L427:
	lis 8,.LC52@ha
	la 8,.LC52@l(8)
	lfs 13,0(8)
	fcmpu 0,0,13
	bc 4,0,.L428
	stfs 13,4(3)
.L428:
	la 1,16(1)
	blr
.Lfe11:
	.size	 AdjustRatingsToSkill,.Lfe11-AdjustRatingsToSkill
	.section	".rodata"
	.align 2
.LC53:
	.string	"path_beam"
	.align 3
.LC54:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl DrawLine
	.type	 DrawLine,@function
DrawLine:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	mr 28,4
	mr 30,5
	bl G_Spawn
	mr 31,3
	lis 9,.LC53@ha
	lwz 0,68(31)
	la 9,.LC53@l(9)
	lis 11,0xd0d1
	stw 9,280(31)
	cmpwi 0,29,0
	li 4,0
	ori 0,0,160
	li 10,5
	stw 29,256(31)
	li 8,1
	li 9,4
	stw 10,284(31)
	ori 11,11,53971
	stw 0,68(31)
	stw 8,40(31)
	stw 9,56(31)
	stw 11,60(31)
	stw 4,260(31)
	stw 4,248(31)
	bc 4,2,.L431
	stw 31,256(31)
.L431:
	lwz 0,284(31)
	lis 10,0xc100
	lis 8,0x4100
	lwz 11,184(31)
	lis 7,target_laser_think@ha
	lis 5,level+4@ha
	lwz 9,264(31)
	oris 0,0,0x8000
	la 7,target_laser_think@l(7)
	ori 0,0,1
	rlwinm 11,11,0,0,30
	stw 10,196(31)
	mtlr 7
	ori 9,9,1024
	stw 8,208(31)
	lis 6,.LC54@ha
	stw 0,284(31)
	mr 3,31
	stw 11,184(31)
	stw 9,264(31)
	stw 10,188(31)
	stw 10,192(31)
	stw 8,200(31)
	stw 8,204(31)
	lfs 0,0(28)
	stfs 0,4(31)
	lfs 13,4(28)
	stfs 13,8(31)
	lfs 0,8(28)
	stfs 0,12(31)
	lfs 13,0(30)
	stfs 13,28(31)
	lfs 0,4(30)
	stfs 0,32(31)
	lfs 13,8(30)
	stfs 13,36(31)
	lfs 13,0(28)
	lfs 0,0(30)
	fsubs 0,0,13
	stfs 0,340(31)
	lfs 0,4(28)
	lfs 13,4(30)
	fsubs 13,13,0
	stfs 13,344(31)
	lfs 13,8(28)
	lfs 0,8(30)
	fsubs 0,0,13
	stfs 0,348(31)
	stw 4,516(31)
	stw 4,540(31)
	stw 7,436(31)
	lfs 0,level+4@l(5)
	lfd 13,.LC54@l(6)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	blrl
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	mr 3,31
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 DrawLine,.Lfe12-DrawLine
	.section	".rodata"
	.align 2
.LC57:
	.string	"%s: "
	.align 2
.LC55:
	.long 0x46fffe00
	.align 3
.LC56:
	.long 0x3fd99999
	.long 0x9999999a
	.align 2
.LC58:
	.long 0x0
	.align 2
.LC59:
	.long 0x44000000
	.align 3
.LC60:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC61:
	.long 0x43800000
	.align 2
.LC62:
	.long 0x41200000
	.align 2
.LC63:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl TeamGroup
	.type	 TeamGroup,@function
TeamGroup:
	stwu 1,-96(1)
	mflr 0
	stfd 28,64(1)
	stfd 29,72(1)
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 20,16(1)
	stw 0,100(1)
	mr 30,3
	lwz 9,84(30)
	lwz 0,3912(9)
	cmpwi 0,0,0
	bc 4,2,.L436
	lis 11,ctf@ha
	lis 7,.LC58@ha
	lwz 9,ctf@l(11)
	la 7,.LC58@l(7)
	lfs 13,0(7)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L435
.L436:
	lis 9,level+4@ha
	lfs 13,1120(30)
	li 27,0
	lfs 0,level+4@l(9)
	lis 20,.LC55@ha
	lis 9,.LC59@ha
	la 9,.LC59@l(9)
	fcmpu 7,13,0
	lfs 31,0(9)
	crnor 31,30,30
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	rlwinm 0,0,0,29,31
	ori 26,0,5
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 6,0x4330
	stw 3,12(1)
	lis 7,.LC60@ha
	lis 8,.LC55@ha
	la 7,.LC60@l(7)
	stw 6,8(1)
	lis 9,bot_chat_count@ha
	lfd 13,0(7)
	la 9,bot_chat_count@l(9)
	lis 10,weapons_head@ha
	lfd 12,8(1)
	slwi 7,26,2
	lfs 10,.LC55@l(8)
	lwzx 0,9,7
	mr 8,11
	fsub 12,12,13
	lwz 31,weapons_head@l(10)
	xoris 0,0,0x8000
	stw 0,12(1)
	cmpwi 0,31,0
	frsp 12,12
	stw 6,8(1)
	lfd 0,8(1)
	fdivs 12,12,10
	fsub 0,0,13
	frsp 0,0
	fmuls 12,12,0
	fmr 13,12
	fctiwz 11,13
	stfd 11,8(1)
	lwz 29,12(1)
	bc 12,2,.L440
.L441:
	lwz 0,648(31)
	cmpwi 0,0,0
	bc 12,2,.L442
	mr 3,31
	mr 4,30
	bl entdist
	fcmpu 0,1,31
	bc 4,0,.L442
	mr 27,31
.L442:
	lwz 31,936(31)
	cmpwi 0,31,0
	bc 4,2,.L441
.L440:
	lis 7,.LC61@ha
	subfic 11,27,0
	adde 9,11,27
	la 7,.LC61@l(7)
	lfs 0,0(7)
	fcmpu 7,31,0
	mfcr 0
	rlwinm 0,0,30,1
	or. 7,9,0
	bc 12,2,.L444
	lis 9,bonus_head@ha
	lwz 31,bonus_head@l(9)
	cmpwi 0,31,0
	bc 12,2,.L444
.L447:
	lwz 9,648(31)
	cmpwi 0,9,0
	bc 12,2,.L448
	lwz 0,68(9)
	cmpwi 0,0,4
	bc 12,2,.L448
	mr 3,31
	mr 4,30
	bl entdist
	fcmpu 0,1,31
	bc 4,0,.L448
	mr 27,31
.L448:
	lwz 31,936(31)
	cmpwi 0,31,0
	bc 4,2,.L447
.L444:
	cmpwi 0,27,0
	bc 12,2,.L435
	lis 9,num_players@ha
	li 28,0
	lwz 0,num_players@l(9)
	lis 21,num_players@ha
	cmpw 0,28,0
	bc 4,0,.L452
	lis 9,.LC56@ha
	slwi 11,29,2
	lfd 31,.LC56@l(9)
	slwi 0,26,8
	lis 25,players@ha
	lis 9,bot_chat_text@ha
	add 24,11,0
	la 22,bot_chat_text@l(9)
	la 26,players@l(25)
	lis 23,0x4330
	li 29,0
.L454:
	lwzx 10,29,26
	cmpw 0,10,30
	bc 12,2,.L456
	lis 11,ctf@ha
	lis 7,.LC58@ha
	lwz 9,ctf@l(11)
	la 7,.LC58@l(7)
	lfs 13,0(7)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L457
	lwz 9,84(10)
	lwz 11,84(30)
	lwz 10,3912(9)
	lwz 0,3912(11)
	xor 10,10,0
	subfic 9,10,0
	adde 10,9,10
	b .L458
.L457:
	lwz 11,84(30)
	lwz 9,84(10)
	lwz 0,3468(11)
	lwz 10,3468(9)
	xor 10,10,0
	subfic 11,10,0
	adde 10,11,10
.L458:
	cmpwi 0,10,0
	bc 12,2,.L453
	lwzx 9,29,26
	lwz 0,324(9)
	cmpwi 0,0,0
	bc 12,2,.L456
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,.LC55@l(20)
	xoris 3,3,0x8000
	lis 7,.LC60@ha
	stw 3,12(1)
	la 7,.LC60@l(7)
	stw 23,8(1)
	lfd 13,0(7)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,31
	bc 4,0,.L453
.L456:
	la 31,players@l(25)
	lwzx 3,31,29
	lwz 0,968(3)
	cmpwi 0,0,0
	bc 4,2,.L460
	lwz 6,84(30)
	lis 5,.LC57@ha
	li 4,3
	la 5,.LC57@l(5)
	addi 6,6,700
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,648(27)
	li 4,3
	lwzx 5,22,24
	lwzx 3,31,29
	lwz 6,40(9)
	crxor 6,6,6
	bl safe_cprintf
	lis 5,.LC32@ha
	lwzx 3,31,29
	li 4,3
	la 5,.LC32@l(5)
	crxor 6,6,6
	bl safe_cprintf
	b .L453
.L460:
	lwz 0,324(3)
	cmpwi 0,0,0
	bc 4,2,.L453
	stw 30,324(3)
.L453:
	lwz 0,num_players@l(21)
	addi 28,28,1
	addi 29,29,4
	cmpw 0,28,0
	bc 12,0,.L454
.L452:
	bl rand
	lis 29,0x4330
	rlwinm 3,3,0,17,31
	lwz 8,84(30)
	xoris 3,3,0x8000
	lis 7,.LC60@ha
	stw 3,12(1)
	la 7,.LC60@l(7)
	lis 10,.LC55@ha
	stw 29,8(1)
	lis 11,level@ha
	lfd 31,0(7)
	la 31,level@l(11)
	lfd 0,8(1)
	lis 7,.LC62@ha
	lis 11,.LC63@ha
	lfs 29,.LC55@l(10)
	la 7,.LC62@l(7)
	la 11,.LC63@l(11)
	lfs 13,4(31)
	fsub 0,0,31
	lfs 28,0(7)
	lfs 30,0(11)
	frsp 0,0
	fadds 13,13,28
	fdivs 0,0,29
	fmadds 0,0,30,13
	stfs 0,1116(30)
	lwz 0,3912(8)
	cmpwi 0,0,0
	bc 12,2,.L435
	bl rand
	rlwinm 3,3,0,17,31
	lfs 13,4(31)
	xoris 3,3,0x8000
	lwz 11,84(30)
	stw 3,12(1)
	stw 29,8(1)
	fadds 13,13,30
	lfd 0,8(1)
	lwz 10,3912(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmadds 0,0,28,13
	stfs 0,156(10)
.L435:
	lwz 0,100(1)
	mtlr 0
	lmw 20,16(1)
	lfd 28,64(1)
	lfd 29,72(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe13:
	.size	 TeamGroup,.Lfe13-TeamGroup
	.section	".rodata"
	.align 2
.LC64:
	.string	"all units disperse!\n"
	.align 3
.LC67:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC68:
	.long 0x40140000
	.long 0x0
	.align 2
.LC69:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl BotInsultStart
	.type	 BotInsultStart,@function
BotInsultStart:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 9,.LC67@ha
	mr 31,3
	la 9,.LC67@l(9)
	lwz 3,256(31)
	lfd 13,0(9)
	lis 8,0x4330
	lis 9,.LC68@ha
	lwz 4,540(31)
	la 9,.LC68@l(9)
	lfd 12,0(9)
	lwz 9,84(3)
	lwz 11,84(4)
	lwz 7,3464(9)
	lwz 9,3464(11)
	subf 0,9,7
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 8,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	fabs 0,0
	fcmpu 0,0,12
	bc 4,0,.L478
	lis 9,.LC69@ha
	lis 11,level+4@ha
	la 9,.LC69@l(9)
	lfs 0,level+4@l(11)
	lfs 12,0(9)
	lis 9,last_bot_chat+4@ha
	lfs 13,last_bot_chat+4@l(9)
	fsubs 0,0,12
	fcmpu 0,13,0
	bc 4,0,.L480
	li 5,1
	bl BotInsult
	b .L480
.L478:
	cmpw 0,7,9
	bc 4,1,.L481
	lis 9,.LC69@ha
	lis 11,level+4@ha
	la 9,.LC69@l(9)
	lfs 0,level+4@l(11)
	lfs 12,0(9)
	lis 9,last_bot_chat+8@ha
	lfs 13,last_bot_chat+8@l(9)
	fsubs 0,0,12
	fcmpu 0,13,0
	bc 4,0,.L480
	li 5,2
	bl BotInsult
	b .L480
.L481:
	lis 9,.LC69@ha
	lis 11,level+4@ha
	la 9,.LC69@l(9)
	lfs 0,level+4@l(11)
	lfs 12,0(9)
	lis 9,last_bot_chat+12@ha
	lfs 13,last_bot_chat+12@l(9)
	fsubs 0,0,12
	fcmpu 0,13,0
	bc 4,0,.L480
	li 5,3
	bl BotInsult
.L480:
	mr 3,31
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 BotInsultStart,.Lfe14-BotInsultStart
	.section	".rodata"
	.align 2
.LC70:
	.long 0x46fffe00
	.align 3
.LC71:
	.long 0x3fd33333
	.long 0x33333333
	.align 2
.LC72:
	.long 0x0
	.align 3
.LC73:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC74:
	.long 0x40400000
	.align 2
.LC75:
	.long 0x40000000
	.align 2
.LC76:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl BotInsult
	.type	 BotInsult,@function
BotInsult:
	stwu 1,-80(1)
	mflr 0
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 25,36(1)
	stw 0,84(1)
	lis 11,.LC72@ha
	lis 9,bot_chat@ha
	la 11,.LC72@l(11)
	mr 25,3
	lfs 13,0(11)
	mr 30,4
	mr 31,5
	lwz 11,bot_chat@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L485
	bl rand
	lis 26,0x4330
	slwi 28,31,2
	lis 9,.LC73@ha
	rlwinm 3,3,0,17,31
	lwz 5,84(25)
	la 9,.LC73@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 8,.LC70@ha
	lis 11,bot_chat_count@ha
	lfs 30,.LC70@l(8)
	la 11,bot_chat_count@l(11)
	stw 3,28(1)
	mr 10,9
	mr 29,9
	stw 26,24(1)
	lis 4,.LC57@ha
	addi 5,5,700
	lfd 12,24(1)
	la 4,.LC57@l(4)
	li 3,3
	lwzx 0,11,28
	fsub 12,12,31
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 26,24(1)
	frsp 12,12
	lfd 0,24(1)
	fdivs 12,12,30
	fsub 0,0,31
	frsp 0,0
	fmuls 12,12,0
	fmr 13,12
	fctiwz 11,13
	stfd 11,24(1)
	lwz 29,28(1)
	crxor 6,6,6
	bl my_bprintf
	slwi 0,31,8
	slwi 29,29,2
	lwz 5,84(30)
	lis 9,bot_chat_text@ha
	add 29,29,0
	la 9,bot_chat_text@l(9)
	addi 5,5,700
	lwzx 4,9,29
	li 3,3
	crxor 6,6,6
	bl my_bprintf
	lis 4,.LC32@ha
	li 3,3
	la 4,.LC32@l(4)
	crxor 6,6,6
	bl my_bprintf
	lis 9,level@ha
	lis 11,last_bot_chat@ha
	la 31,level@l(9)
	la 27,last_bot_chat@l(11)
	lfs 0,4(31)
	stfsx 0,27,28
	lwz 0,968(30)
	cmpwi 0,0,0
	bc 12,2,.L485
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC71@ha
	stw 3,28(1)
	stw 26,24(1)
	lfd 0,24(1)
	lfd 12,.LC71@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fcmpu 0,13,12
	bc 4,0,.L485
	lis 9,.LC74@ha
	lfs 0,4(31)
	la 9,.LC74@l(9)
	lfs 12,16(27)
	lfs 13,0(9)
	fsubs 0,0,13
	fcmpu 0,12,0
	bc 4,0,.L485
	bl G_Spawn
	lis 9,BotComeback@ha
	mr 29,3
	la 9,BotComeback@l(9)
	stw 9,436(29)
	bl rand
	lis 11,.LC75@ha
	lfs 13,4(31)
	rlwinm 3,3,0,17,31
	la 11,.LC75@l(11)
	stw 30,256(29)
	lfs 0,0(11)
	xoris 3,3,0x8000
	stw 3,28(1)
	lis 11,.LC76@ha
	stw 26,24(1)
	la 11,.LC76@l(11)
	fadds 13,13,0
	stw 25,540(29)
	lfd 0,24(1)
	lfs 12,0(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fadds 13,13,0
	stfs 13,428(29)
	lfs 0,4(31)
	fadds 0,0,12
	stfs 0,16(27)
.L485:
	lwz 0,84(1)
	mtlr 0
	lmw 25,36(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe15:
	.size	 BotInsult,.Lfe15-BotInsult
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
	.comm	spawn_bots,4,4
	.comm	roam_calls_this_frame,4,4
	.comm	bestdirection_callsthisframe,4,4
	.comm	bot_chat_text,2048,4
	.comm	bot_chat_count,32,4
	.comm	last_bot_chat,32,4
	.comm	num_view_weapons,4,4
	.comm	view_weapon_models,4096,1
	.comm	botdebug,4,4
	.align 2
	.globl TeamDisperse
	.type	 TeamDisperse,@function
TeamDisperse:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,num_players@ha
	li 10,0
	lwz 0,num_players@l(9)
	mr 31,3
	cmpw 0,10,0
	bc 4,0,.L467
	mtctr 0
	lis 9,players@ha
	li 8,0
	la 9,players@l(9)
.L469:
	lwz 11,0(9)
	addi 9,9,4
	lwz 0,324(11)
	cmpw 0,0,31
	bc 4,2,.L468
	stw 8,324(11)
	addi 10,10,1
.L468:
	bdnz .L469
.L467:
	cmpwi 0,10,0
	bc 12,2,.L472
	lwz 6,84(31)
	lis 5,.LC57@ha
	mr 3,31
	la 5,.LC57@l(5)
	li 4,3
	addi 6,6,700
	crxor 6,6,6
	bl safe_cprintf
	lis 5,.LC64@ha
	mr 3,31
	la 5,.LC64@l(5)
	li 4,3
	crxor 6,6,6
	bl safe_cprintf
.L472:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe16:
	.size	 TeamDisperse,.Lfe16-TeamDisperse
	.section	".rodata"
	.align 2
.LC77:
	.long 0x46fffe00
	.align 2
.LC78:
	.long 0x0
	.align 3
.LC79:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl BotGreeting
	.type	 BotGreeting,@function
BotGreeting:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 11,.LC78@ha
	lis 9,bot_chat@ha
	la 11,.LC78@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,bot_chat@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L473
	bl rand
	rlwinm 3,3,0,17,31
	lwz 6,256(31)
	xoris 3,3,0x8000
	lis 7,0x4330
	stw 3,28(1)
	lis 11,.LC79@ha
	lis 10,.LC77@ha
	stw 7,24(1)
	la 11,.LC79@l(11)
	lis 8,bot_chat_count@ha
	lfd 13,0(11)
	mr 29,9
	lis 4,.LC57@ha
	lfd 12,24(1)
	mr 11,9
	la 4,.LC57@l(4)
	lfs 10,.LC77@l(10)
	li 3,3
	lwz 0,bot_chat_count@l(8)
	fsub 12,12,13
	lwz 5,84(6)
	xoris 0,0,0x8000
	stw 0,28(1)
	addi 5,5,700
	frsp 12,12
	stw 7,24(1)
	lfd 0,24(1)
	fdivs 12,12,10
	fsub 0,0,13
	frsp 0,0
	fmuls 12,12,0
	fmr 13,12
	fctiwz 11,13
	stfd 11,24(1)
	lwz 29,28(1)
	crxor 6,6,6
	bl my_bprintf
	lis 9,bot_chat_text@ha
	slwi 29,29,2
	la 9,bot_chat_text@l(9)
	li 3,3
	lwzx 4,9,29
	crxor 6,6,6
	bl my_bprintf
	lis 4,.LC32@ha
	li 3,3
	la 4,.LC32@l(4)
	crxor 6,6,6
	bl my_bprintf
	mr 3,31
	bl G_FreeEdict
.L473:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe17:
	.size	 BotGreeting,.Lfe17-BotGreeting
	.section	".rodata"
	.align 2
.LC80:
	.long 0x0
	.section	".text"
	.align 2
	.globl SameTeam
	.type	 SameTeam,@function
SameTeam:
	lis 11,.LC80@ha
	lis 9,ctf@ha
	la 11,.LC80@l(11)
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L489
	lwz 9,84(3)
	lwz 11,84(4)
	lwz 0,3468(9)
	lwz 3,3468(11)
	xor 3,0,3
	subfic 9,3,0
	adde 3,9,3
	blr
.L489:
	lwz 9,84(3)
	lwz 3,3912(9)
	cmpwi 0,3,0
	bc 12,2,.L492
	lwz 9,84(4)
	lwz 4,3912(9)
	cmpwi 0,4,0
	bc 4,2,.L491
.L492:
	li 3,0
	blr
.L491:
	xor 3,3,4
	subfic 11,3,0
	adde 3,11,3
	blr
.Lfe18:
	.size	 SameTeam,.Lfe18-SameTeam
	.align 2
	.globl HomeFlagDist
	.type	 HomeFlagDist,@function
HomeFlagDist:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 0,3468(9)
	cmpwi 0,0,1
	bc 4,2,.L494
	lis 9,flag1_ent@ha
	lwz 4,flag1_ent@l(9)
	b .L495
.L494:
	lis 9,flag2_ent@ha
	lwz 4,flag2_ent@l(9)
.L495:
	bl entdist
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe19:
	.size	 HomeFlagDist,.Lfe19-HomeFlagDist
	.align 2
	.globl CarryingFlag
	.type	 CarryingFlag,@function
CarryingFlag:
	lwz 3,64(3)
	rlwinm 3,3,0,12,13
	blr
.Lfe20:
	.size	 CarryingFlag,.Lfe20-CarryingFlag
	.align 2
	.globl GetWeaponForNumber
	.type	 GetWeaponForNumber,@function
GetWeaponForNumber:
	cmplwi 0,3,9
	bclr 12,1
	lis 11,.L107@ha
	slwi 10,3,2
	la 11,.L107@l(11)
	lis 9,.L107@ha
	lwzx 0,10,11
	la 9,.L107@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L107:
	.long .L106-.L107
	.long .L96-.L107
	.long .L98-.L107
	.long .L99-.L107
	.long .L100-.L107
	.long .L101-.L107
	.long .L102-.L107
	.long .L103-.L107
	.long .L104-.L107
	.long .L105-.L107
.L98:
	lis 9,item_shotgun@ha
	lwz 3,item_shotgun@l(9)
	blr
.L99:
	lis 9,item_supershotgun@ha
	lwz 3,item_supershotgun@l(9)
	blr
.L100:
	lis 9,item_machinegun@ha
	lwz 3,item_machinegun@l(9)
	blr
.L101:
	lis 9,item_chaingun@ha
	lwz 3,item_chaingun@l(9)
	blr
.L102:
	lis 9,item_grenadelauncher@ha
	lwz 3,item_grenadelauncher@l(9)
	blr
.L103:
	lis 9,item_rocketlauncher@ha
	lwz 3,item_rocketlauncher@l(9)
	blr
.L104:
	lis 9,item_railgun@ha
	lwz 3,item_railgun@l(9)
	blr
.L105:
	lis 9,item_hyperblaster@ha
	lwz 3,item_hyperblaster@l(9)
	blr
.L106:
	lis 9,item_bfg10k@ha
	lwz 3,item_bfg10k@l(9)
.L96:
	blr
.Lfe21:
	.size	 GetWeaponForNumber,.Lfe21-GetWeaponForNumber
	.align 2
	.globl next_nonspace
	.type	 next_nonspace,@function
next_nonspace:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	li 9,9
	lwz 3,0(31)
	stb 9,8(1)
	lhz 0,12(3)
	andi. 9,0,32
	bc 4,2,.L129
	lis 30,.LC15@ha
.L130:
	la 4,.LC15@l(30)
	addi 5,1,8
	crxor 6,6,6
	bl fscanf
	lwz 3,0(31)
	lhz 0,12(3)
	andi. 9,0,32
	bc 4,2,.L129
	lbz 0,8(1)
	xori 9,0,32
	subfic 11,9,0
	adde 9,11,9
	xori 0,0,9
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 4,2,.L130
.L129:
	lbz 3,8(1)
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe22:
	.size	 next_nonspace,.Lfe22-next_nonspace
	.align 2
	.globl ViewModelSupported
	.type	 ViewModelSupported,@function
ViewModelSupported:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,num_view_weapons@ha
	li 31,0
	lwz 0,num_view_weapons@l(9)
	mr 29,3
	lis 28,num_view_weapons@ha
	cmpw 0,31,0
	bc 4,0,.L296
	lis 9,view_weapon_models@ha
	la 30,view_weapon_models@l(9)
.L298:
	mr 3,30
	mr 4,29
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L297
	li 3,1
	b .L499
.L297:
	lwz 0,num_view_weapons@l(28)
	addi 31,31,1
	addi 30,30,64
	cmpw 0,31,0
	bc 12,0,.L298
.L296:
	li 3,0
.L499:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe23:
	.size	 ViewModelSupported,.Lfe23-ViewModelSupported
	.section	".rodata"
	.align 2
.LC81:
	.long 0x0
	.section	".text"
	.align 2
	.globl botOnSameTeam
	.type	 botOnSameTeam,@function
botOnSameTeam:
	lis 11,.LC81@ha
	lis 9,ctf@ha
	la 11,.LC81@l(11)
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L433
	lwz 9,84(3)
	lwz 11,84(4)
	lwz 0,3468(9)
	lwz 3,3468(11)
	xor 3,0,3
	subfic 9,3,0
	adde 3,9,3
	blr
.L433:
	lwz 9,84(3)
	lwz 11,84(4)
	lwz 0,3912(9)
	lwz 3,3912(11)
	xor 3,0,3
	subfic 11,3,0
	adde 3,11,3
	blr
.Lfe24:
	.size	 botOnSameTeam,.Lfe24-botOnSameTeam
	.section	".rodata"
	.align 2
.LC82:
	.long 0x46fffe00
	.align 2
.LC83:
	.long 0x0
	.align 3
.LC84:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl BotComeback
	.type	 BotComeback,@function
BotComeback:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 11,.LC83@ha
	lis 9,bot_chat@ha
	la 11,.LC83@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,bot_chat@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L475
	bl rand
	rlwinm 3,3,0,17,31
	lwz 6,256(31)
	xoris 3,3,0x8000
	lis 7,0x4330
	stw 3,28(1)
	lis 11,.LC84@ha
	lis 10,.LC82@ha
	stw 7,24(1)
	la 11,.LC84@l(11)
	lis 8,bot_chat_count+16@ha
	lfd 13,0(11)
	mr 29,9
	lis 4,.LC57@ha
	lfd 12,24(1)
	mr 11,9
	la 4,.LC57@l(4)
	lfs 10,.LC82@l(10)
	li 3,3
	lwz 0,bot_chat_count+16@l(8)
	fsub 12,12,13
	lwz 5,84(6)
	xoris 0,0,0x8000
	stw 0,28(1)
	addi 5,5,700
	frsp 12,12
	stw 7,24(1)
	lfd 0,24(1)
	fdivs 12,12,10
	fsub 0,0,13
	frsp 0,0
	fmuls 12,12,0
	fmr 13,12
	fctiwz 11,13
	stfd 11,24(1)
	lwz 29,28(1)
	crxor 6,6,6
	bl my_bprintf
	lwz 11,540(31)
	lis 9,bot_chat_text@ha
	slwi 29,29,2
	la 9,bot_chat_text@l(9)
	li 3,3
	addi 9,9,1024
	lwz 5,84(11)
	lwzx 4,9,29
	addi 5,5,700
	crxor 6,6,6
	bl my_bprintf
	lis 4,.LC32@ha
	li 3,3
	la 4,.LC32@l(4)
	crxor 6,6,6
	bl my_bprintf
	mr 3,31
	bl G_FreeEdict
.L475:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe25:
	.size	 BotComeback,.Lfe25-BotComeback
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
