	.file	"a_radio.c"
gcc2_compiled.:
	.globl male_radio_msgs
	.section	".data"
	.align 2
	.type	 male_radio_msgs,@object
male_radio_msgs:
	.long .LC0
	.long 6
	.long .LC1
	.long 6
	.long .LC2
	.long 8
	.long .LC3
	.long 7
	.long .LC4
	.long 8
	.long .LC5
	.long 9
	.long .LC6
	.long 8
	.long .LC7
	.long 7
	.long .LC8
	.long 7
	.long .LC9
	.long 6
	.long .LC10
	.long 6
	.long .LC11
	.long 7
	.long .LC12
	.long 13
	.long .LC13
	.long 10
	.long .LC14
	.long 9
	.long .LC15
	.long 6
	.long .LC16
	.long 6
	.long .LC17
	.long 7
	.long .LC18
	.long 7
	.long .LC19
	.long 9
	.long .LC20
	.long 6
	.long .LC21
	.long 22
	.long .LC22
	.long 13
	.long .LC23
	.long 12
	.long .LC24
	.long 4
	.long .LC25
	.long 0
	.section	".rodata"
	.align 2
.LC25:
	.string	"END"
	.align 2
.LC24:
	.string	"up"
	.align 2
.LC23:
	.string	"treport"
	.align 2
.LC22:
	.string	"teamdown"
	.align 2
.LC21:
	.string	"taking_f"
	.align 2
.LC20:
	.string	"right"
	.align 2
.LC19:
	.string	"reportin"
	.align 2
.LC18:
	.string	"left"
	.align 2
.LC17:
	.string	"im_hit"
	.align 2
.LC16:
	.string	"go"
	.align 2
.LC15:
	.string	"forward"
	.align 2
.LC14:
	.string	"enemys"
	.align 2
.LC13:
	.string	"enemyd"
	.align 2
.LC12:
	.string	"down"
	.align 2
.LC11:
	.string	"cover"
	.align 2
.LC10:
	.string	"back"
	.align 2
.LC9:
	.string	"10"
	.align 2
.LC8:
	.string	"9"
	.align 2
.LC7:
	.string	"8"
	.align 2
.LC6:
	.string	"7"
	.align 2
.LC5:
	.string	"6"
	.align 2
.LC4:
	.string	"5"
	.align 2
.LC3:
	.string	"4"
	.align 2
.LC2:
	.string	"3"
	.align 2
.LC1:
	.string	"2"
	.align 2
.LC0:
	.string	"1"
	.size	 male_radio_msgs,208
	.globl female_radio_msgs
	.section	".data"
	.align 2
	.type	 female_radio_msgs,@object
female_radio_msgs:
	.long .LC0
	.long 5
	.long .LC1
	.long 5
	.long .LC2
	.long 5
	.long .LC3
	.long 5
	.long .LC4
	.long 5
	.long .LC5
	.long 8
	.long .LC6
	.long 7
	.long .LC7
	.long 5
	.long .LC8
	.long 5
	.long .LC9
	.long 5
	.long .LC10
	.long 6
	.long .LC11
	.long 5
	.long .LC12
	.long 6
	.long .LC13
	.long 9
	.long .LC14
	.long 9
	.long .LC15
	.long 8
	.long .LC16
	.long 6
	.long .LC17
	.long 7
	.long .LC18
	.long 8
	.long .LC19
	.long 9
	.long .LC20
	.long 5
	.long .LC21
	.long 22
	.long .LC22
	.long 10
	.long .LC23
	.long 12
	.long .LC24
	.long 6
	.long .LC25
	.long 0
	.size	 female_radio_msgs,208
	.section	".rodata"
	.align 2
.LC26:
	.string	"%s%s.wav"
	.align 2
.LC27:
	.string	"radio/click.wav"
	.align 2
.LC28:
	.string	"radio/male/rdeath.wav"
	.align 2
.LC29:
	.string	"radio/female/rdeath.wav"
	.align 2
.LC30:
	.string	"radio/male/"
	.align 2
.LC31:
	.string	"radio/female/"
	.section	".text"
	.align 2
	.globl PrecacheRadioSounds
	.type	 PrecacheRadioSounds,@function
PrecacheRadioSounds:
	stwu 1,-2080(1)
	mflr 0
	stmw 27,2060(1)
	stw 0,2084(1)
	lis 29,gi@ha
	lis 3,.LC27@ha
	la 29,gi@l(29)
	la 3,.LC27@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC28@ha
	la 3,.LC28@l(3)
	mtlr 9
	blrl
	lwz 0,36(29)
	lis 3,.LC29@ha
	la 3,.LC29@l(3)
	mtlr 0
	blrl
	lis 11,male_radio_msgs@ha
	lis 9,.LC30@ha
	la 30,.LC30@l(9)
	la 29,male_radio_msgs@l(11)
	lis 31,.LC25@ha
	b .L12
.L14:
	lwz 6,0(29)
	addi 29,29,8
	crxor 6,6,6
	bl sprintf
	lis 9,gi+36@ha
	addi 3,1,8
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
.L12:
	lwz 3,0(29)
	lis 4,.LC25@ha
	la 4,.LC25@l(4)
	bl strcmp
	cmpwi 0,3,0
	lis 4,.LC26@ha
	mr 5,30
	la 4,.LC26@l(4)
	addi 3,1,8
	bc 4,2,.L14
	lis 9,female_radio_msgs@ha
	lis 11,.LC31@ha
	lis 10,gi@ha
	la 27,.LC31@l(11)
	la 28,gi@l(10)
	la 29,female_radio_msgs@l(9)
	lis 30,.LC26@ha
	b .L17
.L19:
	lwz 6,0(29)
	addi 29,29,8
	crxor 6,6,6
	bl sprintf
	lwz 9,36(28)
	addi 3,1,8
	mtlr 9
	blrl
.L17:
	lwz 3,0(29)
	la 4,.LC25@l(31)
	bl strcmp
	cmpwi 0,3,0
	la 4,.LC26@l(30)
	mr 5,27
	addi 3,1,8
	bc 4,2,.L19
	lwz 0,2084(1)
	mtlr 0
	lmw 27,2060(1)
	la 1,2080(1)
	blr
.Lfe1:
	.size	 PrecacheRadioSounds,.Lfe1-PrecacheRadioSounds
	.section	".rodata"
	.align 2
.LC32:
	.string	"DeleteFirstRadioQueueEntry: attempt to delete without any entries\n"
	.align 2
.LC33:
	.string	"DeleteRadioQueueEntry: attempt to delete out of range queue entry\n"
	.align 2
.LC34:
	.string	"play %s"
	.section	".text"
	.align 2
	.globl RadioThink
	.type	 RadioThink,@function
RadioThink:
	stwu 1,-560(1)
	mflr 0
	stmw 25,532(1)
	stw 0,564(1)
	mr 29,3
	lwz 11,84(29)
	lwz 9,3816(11)
	cmpwi 0,9,0
	bc 12,2,.L37
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L39
	lwz 9,84(9)
	lwz 0,3816(9)
	cmpw 0,0,29
	bc 12,2,.L37
.L39:
	li 0,0
	stw 0,3816(11)
.L37:
	lwz 11,84(29)
	lwz 9,3820(11)
	cmpwi 0,9,0
	bc 12,2,.L40
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L42
	lwz 0,248(9)
	cmpwi 0,0,0
	bc 4,2,.L40
.L42:
	li 0,0
	stw 0,3820(11)
.L40:
	lwz 11,84(29)
	lwz 9,3828(11)
	cmpwi 0,9,0
	bc 12,2,.L43
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L45
	lwz 0,248(9)
	cmpwi 0,0,0
	bc 4,2,.L43
.L45:
	li 0,0
	stw 0,3828(11)
.L43:
	lwz 9,84(29)
	lwz 0,3880(9)
	cmpwi 0,0,0
	bc 12,2,.L46
	li 0,0
	stw 0,3812(9)
	b .L36
.L46:
	lwz 11,3496(9)
	cmpwi 0,11,1
	bc 4,1,.L47
	addi 0,11,-1
	b .L75
.L47:
	bc 4,2,.L48
	lwz 0,3812(9)
	cmpwi 0,0,0
	bc 12,1,.L50
	lis 9,gi+4@ha
	lis 3,.LC32@ha
	lwz 0,gi+4@l(9)
	la 3,.LC32@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L51
.L50:
	li 31,1
	cmpw 0,31,0
	bc 4,0,.L56
	li 30,52
.L54:
	lwz 3,84(29)
	li 5,52
	addi 31,31,1
	add 3,30,3
	addi 4,3,3500
	addi 30,30,52
	addi 3,3,3448
	crxor 6,6,6
	bl memcpy
	lwz 9,84(29)
	lwz 0,3812(9)
	cmpw 0,31,0
	bc 12,0,.L54
.L56:
	lwz 11,84(29)
	lwz 9,3812(11)
	addi 9,9,-1
	stw 9,3812(11)
.L51:
	lwz 9,84(29)
	li 0,0
	stw 0,3496(9)
.L48:
	lwz 9,84(29)
	lwz 0,3812(9)
	mr 5,9
	cmpwi 0,0,0
	bc 12,2,.L36
	lwz 0,3548(5)
	lwz 27,3532(5)
	cmpwi 0,0,0
	bc 4,2,.L58
	lwz 0,88(27)
	cmpwi 0,0,0
	bc 12,2,.L59
	lwz 0,248(27)
	cmpwi 0,0,0
	bc 12,2,.L59
	lwz 0,492(27)
	cmpwi 0,0,2
	bc 4,2,.L58
.L59:
	lwz 5,84(29)
	lwz 0,3536(5)
	cmpwi 0,0,0
	bc 12,2,.L60
	lis 9,.LC29@ha
	addi 10,5,3500
	lwz 7,.LC29@l(9)
	li 6,30
	la 9,.LC29@l(9)
	lwz 0,4(9)
	lwz 11,8(9)
	lwz 8,12(9)
	stw 7,3500(5)
	stw 0,4(10)
	stw 11,8(10)
	stw 8,12(10)
	lwz 0,20(9)
	lwz 11,16(9)
	stw 0,20(10)
	b .L76
.L60:
	lis 9,.LC28@ha
	addi 10,5,3500
	lwz 7,.LC28@l(9)
	li 6,27
	la 9,.LC28@l(9)
	lwz 0,4(9)
	lwz 11,8(9)
	lwz 8,12(9)
	stw 7,3500(5)
	stw 0,4(10)
	stw 11,8(10)
	stw 8,12(10)
	lhz 0,20(9)
	lwz 11,16(9)
	sth 0,20(10)
.L76:
	stw 11,16(10)
	lwz 9,84(29)
	stw 6,3544(9)
	lwz 10,84(29)
	li 30,1
	lwz 0,3812(10)
	mr 5,10
	cmpw 0,30,0
	bc 4,0,.L58
	lis 9,gi@ha
	lis 25,.LC33@ha
	la 26,gi@l(9)
.L65:
	mulli 0,30,52
	addi 9,10,3532
	lwzx 11,9,0
	cmpw 0,11,27
	bc 4,2,.L64
	lwz 9,3812(10)
	cmpw 0,9,30
	bc 12,1,.L67
	lwz 9,4(26)
	la 3,.LC33@l(25)
	addi 28,30,-1
	mtlr 9
	crxor 6,6,6
	blrl
	b .L68
.L67:
	addi 31,30,1
	addi 28,30,-1
	cmpw 0,31,9
	bc 4,0,.L73
	mulli 30,31,52
.L71:
	lwz 3,84(29)
	li 5,52
	addi 31,31,1
	add 3,30,3
	addi 4,3,3500
	addi 30,30,52
	addi 3,3,3448
	crxor 6,6,6
	bl memcpy
	lwz 9,84(29)
	lwz 0,3812(9)
	cmpw 0,31,0
	bc 12,0,.L71
.L73:
	lwz 11,84(29)
	lwz 9,3812(11)
	addi 9,9,-1
	stw 9,3812(11)
.L68:
	lwz 5,84(29)
	mr 30,28
.L64:
	lwz 0,3812(5)
	addi 30,30,1
	mr 10,5
	cmpw 0,30,0
	bc 12,0,.L65
.L58:
	lis 4,.LC34@ha
	addi 5,5,3500
	la 4,.LC34@l(4)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	mr 3,29
	addi 4,1,8
	bl stuffcmd
	lwz 11,84(29)
	li 0,1
	stw 0,3540(11)
	lwz 9,84(29)
	lwz 0,3544(9)
.L75:
	stw 0,3496(9)
.L36:
	lwz 0,564(1)
	mtlr 0
	lmw 25,532(1)
	la 1,560(1)
	blr
.Lfe2:
	.size	 RadioThink,.Lfe2-RadioThink
	.section	".rodata"
	.align 2
.LC35:
	.string	"AppendRadioMsgToQueue: Maximum radio queue size exceeded\n"
	.align 2
.LC36:
	.string	"Radio sound file path (%s) exceeded maximum length\n"
	.align 2
.LC37:
	.string	"InsertRadioMsgInQueueBeforeClick: Maximum radio queue size exceeded\n"
	.section	".text"
	.align 2
	.globl AddRadioMsg
	.type	 AddRadioMsg,@function
AddRadioMsg:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 28,3
	mr 29,4
	lwz 10,84(28)
	mr 26,5
	mr 27,6
	lwz 11,3812(10)
	cmpwi 0,11,0
	bc 12,2,.L92
	lwz 0,3548(10)
	cmpwi 0,0,0
	bc 12,2,.L91
	cmpwi 0,11,1
	bc 4,2,.L91
.L92:
	cmpwi 0,11,5
	lis 9,.LC27@ha
	la 30,.LC27@l(9)
	bc 4,1,.L93
	lis 9,gi+4@ha
	lis 3,.LC35@ha
	lwz 0,gi+4@l(9)
	la 3,.LC35@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L94
.L93:
	mulli 9,11,52
	mr 3,30
	addi 9,9,3500
	add 31,10,9
	bl strlen
	addi 3,3,1
	cmplwi 0,3,32
	bc 4,1,.L95
	lis 9,gi+4@ha
	lis 3,.LC36@ha
	lwz 0,gi+4@l(9)
	la 3,.LC36@l(3)
	mr 4,30
	mtlr 0
	crxor 6,6,6
	blrl
	li 0,0
	stb 0,31(30)
.L95:
	mr 4,30
	mr 3,31
	bl strcpy
	stw 27,32(31)
	li 0,1
	li 10,0
	lwz 9,84(27)
	lwz 11,3876(9)
	stw 0,48(31)
	li 0,2
	stw 11,36(31)
	stw 10,40(31)
	stw 0,44(31)
	lwz 11,84(28)
	lwz 9,3812(11)
	addi 9,9,1
	stw 9,3812(11)
.L94:
	lwz 11,84(28)
	li 30,0
	lwz 9,3812(11)
	cmpwi 0,9,5
	bc 4,1,.L96
	lis 9,gi+4@ha
	lis 3,.LC35@ha
	lwz 0,gi+4@l(9)
	la 3,.LC35@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L97
.L96:
	mulli 9,9,52
	mr 3,29
	addi 9,9,3500
	add 31,11,9
	bl strlen
	addi 3,3,1
	cmplwi 0,3,32
	bc 4,1,.L98
	lis 9,gi+4@ha
	lis 3,.LC36@ha
	lwz 0,gi+4@l(9)
	la 3,.LC36@l(3)
	mr 4,29
	mtlr 0
	crxor 6,6,6
	blrl
	stb 30,31(29)
.L98:
	mr 4,29
	mr 3,31
	bl strcpy
	stw 27,32(31)
	lwz 9,84(27)
	lwz 0,3876(9)
	stw 30,48(31)
	stw 0,36(31)
	stw 26,44(31)
	stw 30,40(31)
	lwz 11,84(28)
	lwz 9,3812(11)
	addi 9,9,1
	stw 9,3812(11)
.L97:
	lis 9,.LC27@ha
	lwz 11,84(28)
	la 30,.LC27@l(9)
	lwz 9,3812(11)
	cmpwi 0,9,5
	bc 4,1,.L99
	lis 9,gi+4@ha
	lis 3,.LC35@ha
	lwz 0,gi+4@l(9)
	la 3,.LC35@l(3)
	b .L114
.L99:
	mulli 9,9,52
	mr 3,30
	addi 9,9,3500
	add 31,11,9
	bl strlen
	addi 3,3,1
	cmplwi 0,3,32
	bc 4,1,.L101
	lis 9,gi+4@ha
	lis 3,.LC36@ha
	lwz 0,gi+4@l(9)
	la 3,.LC36@l(3)
	mr 4,30
	mtlr 0
	crxor 6,6,6
	blrl
	li 0,0
	stb 0,31(30)
.L101:
	mr 4,30
	mr 3,31
	bl strcpy
	stw 27,32(31)
	li 0,1
	li 10,0
	lwz 9,84(27)
	lwz 11,3876(9)
	stw 0,48(31)
	li 0,2
	stw 11,36(31)
	stw 10,40(31)
	stw 0,44(31)
	b .L115
.L91:
	lwz 8,84(28)
	li 7,0
	li 5,0
	lwz 0,3812(8)
	mr 4,8
	cmpw 0,7,0
	bc 4,0,.L109
	li 6,0
.L106:
	addi 11,8,3548
	lwz 0,3812(8)
	addi 5,5,1
	lwzx 10,11,6
	addi 9,7,1
	cmpw 0,5,0
	addi 6,6,52
	srawi 11,10,31
	xor 0,11,10
	subf 0,0,11
	srawi 0,0,31
	andc 9,9,0
	and 0,7,0
	or 7,0,9
	bc 12,0,.L106
.L109:
	cmpwi 0,7,3
	bc 12,1,.L102
	lwz 3,3812(4)
	cmpwi 0,3,5
	bc 4,1,.L111
	lis 9,gi+4@ha
	lis 3,.LC37@ha
	lwz 0,gi+4@l(9)
	la 3,.LC37@l(3)
.L114:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L102
.L111:
	mulli 3,3,52
	li 5,52
	add 3,3,4
	addi 4,3,3448
	addi 3,3,3500
	crxor 6,6,6
	bl memcpy
	lwz 11,84(28)
	mr 3,29
	lwz 9,3812(11)
	mulli 9,9,52
	addi 9,9,3448
	add 31,11,9
	bl strlen
	addi 3,3,1
	cmplwi 0,3,32
	bc 4,1,.L113
	lis 9,gi+4@ha
	lis 3,.LC36@ha
	lwz 0,gi+4@l(9)
	la 3,.LC36@l(3)
	mr 4,29
	mtlr 0
	crxor 6,6,6
	blrl
	li 0,0
	stb 0,31(29)
.L113:
	mr 4,29
	mr 3,31
	bl strcpy
	stw 27,32(31)
	li 10,0
	lwz 9,84(27)
	lwz 0,3876(9)
	stw 10,48(31)
	stw 0,36(31)
	stw 26,44(31)
	stw 10,40(31)
.L115:
	lwz 11,84(28)
	lwz 9,3812(11)
	addi 9,9,1
	stw 9,3812(11)
.L102:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 AddRadioMsg,.Lfe3-AddRadioMsg
	.section	".rodata"
	.align 2
.LC38:
	.string	"Your radio is off!\n"
	.align 2
.LC39:
	.string	"You don't have a partner.\n"
	.align 2
.LC40:
	.string	"'%s' is not a valid radio message\n"
	.align 2
.LC41:
	.string	"[%s RADIO] %s: %s\n"
	.align 2
.LC42:
	.string	"PARTNER"
	.align 2
.LC43:
	.string	"TEAM"
	.align 2
.LC44:
	.long 0x0
	.section	".text"
	.align 2
	.globl RadioBroadcast
	.type	 RadioBroadcast,@function
RadioBroadcast:
	stwu 1,-2112(1)
	mflr 0
	mfcr 12
	stmw 23,2076(1)
	stw 0,2116(1)
	stw 12,2072(1)
	mr 28,3
	mr 26,5
	lwz 0,492(28)
	cmpwi 0,0,2
	bc 12,2,.L116
	lwz 0,248(28)
	cmpwi 0,0,0
	bc 12,2,.L116
	lis 9,.LC44@ha
	lis 11,teamplay@ha
	la 9,.LC44@l(9)
	lfs 13,0(9)
	lwz 9,teamplay@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L119
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,2064(1)
	lwz 11,2068(1)
	andi. 0,11,192
	bc 12,2,.L116
.L119:
	lwz 9,84(28)
	lwz 0,3880(9)
	mr 11,9
	cmpwi 0,0,0
	bc 12,2,.L121
	lis 4,.LC38@ha
	mr 3,28
	la 4,.LC38@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	b .L116
.L121:
	cmpwi 4,4,0
	bc 12,18,.L122
	lwz 0,3816(11)
	cmpwi 0,0,0
	bc 4,2,.L122
	lis 5,.LC39@ha
	mr 3,28
	la 5,.LC39@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L116
.L122:
	lwz 0,3876(11)
	cmpwi 0,0,0
	bc 12,2,.L123
	lis 9,female_radio_msgs@ha
	lis 11,.LC31@ha
	la 30,female_radio_msgs@l(9)
	la 24,.LC31@l(11)
	b .L124
.L143:
	lwzx 6,31,30
	lis 4,.LC26@ha
	mr 5,24
	la 4,.LC26@l(4)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	li 25,1
	lwz 23,4(27)
	b .L126
.L123:
	lis 9,male_radio_msgs@ha
	lis 11,.LC30@ha
	la 30,male_radio_msgs@l(9)
	la 24,.LC30@l(11)
.L124:
	li 25,0
	li 29,0
	b .L125
.L127:
	lwzx 3,31,30
	mr 4,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L143
	addi 29,29,1
.L125:
	slwi 31,29,3
	lis 4,.LC25@ha
	lwzx 3,31,30
	la 4,.LC25@l(4)
	add 27,31,30
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L127
.L126:
	cmpwi 0,25,0
	bc 4,2,.L130
	lis 4,.LC40@ha
	mr 3,28
	la 4,.LC40@l(4)
	mr 5,26
	crxor 6,6,6
	bl safe_centerprintf
	b .L116
.L130:
	lis 9,.LC44@ha
	lis 11,radiolog@ha
	la 9,.LC44@l(9)
	lfs 13,0(9)
	lwz 9,radiolog@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L131
	bc 12,18,.L132
	lis 9,.LC42@ha
	la 6,.LC42@l(9)
	b .L133
.L132:
	lis 9,.LC43@ha
	la 6,.LC43@l(9)
.L133:
	lwz 7,84(28)
	lis 5,.LC41@ha
	mr 8,26
	la 5,.LC41@l(5)
	li 3,0
	addi 7,7,700
	li 4,3
	crxor 6,6,6
	bl safe_cprintf
.L131:
	lis 9,game@ha
	li 30,1
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,30,0
	bc 12,1,.L116
	mr 26,9
	lis 27,g_edicts@ha
	li 29,996
.L137:
	lwz 0,g_edicts@l(27)
	add 31,0,29
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L136
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L136
	mr 3,28
	mr 4,31
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L136
	bc 12,18,.L141
	lwz 9,84(28)
	lwz 0,3816(9)
	cmpw 0,31,0
	bc 4,2,.L136
.L141:
	mr 3,31
	addi 4,1,8
	mr 5,23
	mr 6,28
	bl AddRadioMsg
.L136:
	lwz 0,1544(26)
	addi 30,30,1
	addi 29,29,996
	cmpw 0,30,0
	bc 4,1,.L137
.L116:
	lwz 0,2116(1)
	lwz 12,2072(1)
	mtlr 0
	lmw 23,2076(1)
	mtcrf 8,12
	la 1,2112(1)
	blr
.Lfe4:
	.size	 RadioBroadcast,.Lfe4-RadioBroadcast
	.section	".rodata"
	.align 2
.LC45:
	.string	"Radio gender currently set to female\n"
	.align 2
.LC46:
	.string	"Radio gender currently set to male\n"
	.align 2
.LC47:
	.string	"male"
	.align 2
.LC48:
	.string	"Radio gender set to male\n"
	.align 2
.LC49:
	.string	"female"
	.align 2
.LC50:
	.string	"Radio gender set to female\n"
	.align 2
.LC51:
	.string	"Invalid gender selection, try 'male' or 'female'\n"
	.align 2
.LC52:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Radiogender_f
	.type	 Cmd_Radiogender_f,@function
Cmd_Radiogender_f:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 11,.LC52@ha
	lis 9,teamplay@ha
	la 11,.LC52@l(11)
	mr 30,3
	lfs 13,0(11)
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L148
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,192
	bc 12,2,.L147
.L148:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr. 31,3
	bc 12,2,.L151
	mr 3,31
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L150
.L151:
	lwz 9,84(30)
	lwz 0,3876(9)
	cmpwi 0,0,0
	bc 12,2,.L152
	lis 5,.LC45@ha
	mr 3,30
	la 5,.LC45@l(5)
	b .L158
.L152:
	lis 5,.LC46@ha
	mr 3,30
	la 5,.LC46@l(5)
.L158:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L147
.L150:
	lis 4,.LC47@ha
	mr 3,31
	la 4,.LC47@l(4)
	bl Q_stricmp
	mr. 29,3
	bc 4,2,.L154
	lis 5,.LC48@ha
	mr 3,30
	la 5,.LC48@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(30)
	stw 29,3876(9)
	b .L147
.L154:
	lis 4,.LC49@ha
	mr 3,31
	la 4,.LC49@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L156
	lis 5,.LC50@ha
	mr 3,30
	la 5,.LC50@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(30)
	li 0,1
	stw 0,3876(9)
	b .L147
.L156:
	lis 5,.LC51@ha
	mr 3,30
	la 5,.LC51@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L147:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 Cmd_Radiogender_f,.Lfe5-Cmd_Radiogender_f
	.section	".rodata"
	.align 2
.LC53:
	.string	"Radio switched off\n"
	.align 2
.LC54:
	.string	"play radio/click.wav"
	.align 2
.LC55:
	.string	"Radio switched on\n"
	.align 2
.LC56:
	.string	"Channel set to 1, partner channel\n"
	.align 2
.LC57:
	.string	"Channel set to 0, team channel\n"
	.align 2
.LC58:
	.long 0x3f666666
	.align 3
.LC59:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 2
.LC60:
	.long 0x46000000
	.align 2
.LC61:
	.long 0x3f800000
	.align 3
.LC62:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl DetermineViewedTeammate
	.type	 DetermineViewedTeammate,@function
DetermineViewedTeammate:
	stwu 1,-176(1)
	mflr 0
	stfd 29,152(1)
	stfd 30,160(1)
	stfd 31,168(1)
	stmw 24,120(1)
	stw 0,180(1)
	mr 30,3
	lis 9,.LC58@ha
	lwz 3,84(30)
	addi 4,1,8
	li 5,0
	lfs 29,.LC58@l(9)
	li 6,0
	addi 3,3,4060
	bl AngleVectors
	lis 9,.LC60@ha
	addi 3,1,8
	la 9,.LC60@l(9)
	mr 4,3
	lfs 1,0(9)
	bl VectorScale
	lfs 0,4(30)
	lis 9,transparent_list@ha
	lfs 13,8(30)
	lfs 12,12(30)
	lfs 11,8(1)
	lfs 10,12(1)
	lfs 9,16(1)
	lwz 0,transparent_list@l(9)
	fadds 0,0,11
	fadds 13,13,10
	fadds 12,12,9
	cmpwi 0,0,0
	stfs 0,8(1)
	stfs 13,12(1)
	stfs 12,16(1)
	bc 12,2,.L170
	lis 10,teamplay@ha
	lwz 9,teamplay@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,112(1)
	lwz 11,116(1)
	cmpwi 0,11,0
	bc 12,2,.L170
	lis 9,lights_camera_action@ha
	lwz 0,lights_camera_action@l(9)
	cmpwi 0,0,0
	bc 4,2,.L170
	li 3,2
	bl TransparentListSet
.L170:
	lis 9,gi+48@ha
	addi 3,1,40
	lwz 0,gi+48@l(9)
	addi 4,30,4
	li 5,0
	li 9,3
	li 6,0
	mtlr 0
	addi 7,1,8
	mr 8,30
	blrl
	lis 9,transparent_list@ha
	lwz 0,transparent_list@l(9)
	cmpwi 0,0,0
	bc 12,2,.L171
	lis 10,teamplay@ha
	lwz 9,teamplay@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,112(1)
	lwz 11,116(1)
	cmpwi 0,11,0
	bc 12,2,.L171
	lis 9,lights_camera_action@ha
	lwz 0,lights_camera_action@l(9)
	cmpwi 0,0,0
	bc 4,2,.L171
	li 3,1
	bl TransparentListSet
.L171:
	lis 9,.LC61@ha
	lfs 13,48(1)
	la 9,.LC61@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L172
	lwz 9,92(1)
	cmpwi 0,9,0
	bc 12,2,.L172
	lwz 0,84(9)
	cmpwi 0,0,0
	li 3,0
	bc 4,2,.L181
.L172:
	lwz 3,84(30)
	addi 4,1,8
	li 5,0
	li 6,0
	li 27,0
	addi 3,3,4060
	li 28,1
	bl AngleVectors
	lis 24,maxclients@ha
	lis 9,.LC61@ha
	lis 11,maxclients@ha
	la 9,.LC61@l(9)
	lfs 13,0(9)
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L174
	lis 9,.LC62@ha
	lis 25,g_edicts@ha
	la 9,.LC62@l(9)
	lis 26,0x4330
	lfd 30,0(9)
	li 29,996
.L176:
	lwz 0,g_edicts@l(25)
	add 31,0,29
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L175
	lfs 0,4(30)
	addi 3,1,24
	lfs 13,4(31)
	lfs 12,8(30)
	lfs 11,12(30)
	fsubs 13,13,0
	stfs 13,24(1)
	lfs 0,8(31)
	fsubs 0,0,12
	stfs 0,28(1)
	lfs 13,12(31)
	fsubs 13,13,11
	stfs 13,32(1)
	bl VectorNormalize
	lfs 0,28(1)
	lfs 12,12(1)
	lfs 13,8(1)
	lfs 11,24(1)
	fmuls 12,12,0
	lfs 10,16(1)
	lfs 0,32(1)
	fmadds 13,13,11,12
	fmadds 31,10,0,13
	fcmpu 0,31,29
	bc 4,1,.L175
	mr 3,30
	mr 4,31
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L175
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L175
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L175
	mr 3,31
	mr 4,30
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L175
	fmr 29,31
	mr 27,31
.L175:
	addi 28,28,1
	lwz 11,maxclients@l(24)
	xoris 0,28,0x8000
	addi 29,29,996
	stw 0,116(1)
	stw 26,112(1)
	lfd 0,112(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L176
.L174:
	lis 9,.LC59@ha
	fmr 13,29
	lfd 0,.LC59@l(9)
	fcmpu 7,13,0
	mfcr 3
	rlwinm 3,3,30,1
	neg 3,3
	and 3,27,3
.L181:
	lwz 0,180(1)
	mtlr 0
	lmw 24,120(1)
	lfd 29,152(1)
	lfd 30,160(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe6:
	.size	 DetermineViewedTeammate,.Lfe6-DetermineViewedTeammate
	.section	".rodata"
	.align 2
.LC63:
	.string	"You already have a partner, %s\n"
	.align 2
.LC64:
	.string	"No potential partner selected\n"
	.align 2
.LC65:
	.string	"%s already has a partner\n"
	.align 2
.LC66:
	.string	"%s is now your partner\n"
	.align 2
.LC67:
	.string	"%s has already denied you\n"
	.align 2
.LC68:
	.string	"her"
	.align 2
.LC69:
	.string	"it"
	.align 2
.LC70:
	.string	"him"
	.align 2
.LC71:
	.string	"Already awaiting confirmation from %s\n"
	.align 2
.LC72:
	.string	"Awaiting confirmation from %s\n"
	.align 2
.LC73:
	.string	"%s offers to be your partner\nTo accept:\nView %s and use the 'partner' command\nTo deny:\nUse the 'deny' command\n"
	.align 2
.LC74:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Partner_f
	.type	 Cmd_Partner_f,@function
Cmd_Partner_f:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,.LC74@ha
	lis 9,teamplay@ha
	la 11,.LC74@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L183
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,192
	bc 12,2,.L182
.L183:
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L182
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L182
	lwz 11,84(31)
	lwz 9,3816(11)
	cmpwi 0,9,0
	bc 12,2,.L188
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 4,2,.L187
	stw 0,3816(11)
.L187:
	lwz 9,84(31)
	lwz 9,3816(9)
	cmpwi 0,9,0
	bc 12,2,.L188
	lwz 5,84(9)
	lis 4,.LC63@ha
	mr 3,31
	la 4,.LC63@l(4)
	b .L202
.L188:
	mr 3,31
	bl DetermineViewedTeammate
	mr. 30,3
	bc 4,2,.L189
	lis 4,.LC64@ha
	mr 3,31
	la 4,.LC64@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	b .L182
.L189:
	lwz 9,84(30)
	lwz 28,3816(9)
	mr 5,9
	cmpwi 0,28,0
	bc 12,2,.L190
	lis 4,.LC65@ha
	mr 3,31
	la 4,.LC65@l(4)
	b .L202
.L190:
	lwz 0,3820(5)
	cmpw 0,0,31
	bc 4,2,.L191
	lwz 9,84(31)
	lwz 0,3824(9)
	cmpw 0,0,30
	bc 4,2,.L191
	lis 29,.LC66@ha
	addi 5,5,700
	mr 3,31
	la 4,.LC66@l(29)
	crxor 6,6,6
	bl safe_centerprintf
	lwz 5,84(31)
	la 4,.LC66@l(29)
	mr 3,30
	addi 5,5,700
	crxor 6,6,6
	bl safe_centerprintf
	lwz 9,84(31)
	stw 30,3816(9)
	lwz 11,84(30)
	stw 31,3816(11)
	lwz 9,84(31)
	stw 28,3824(9)
	lwz 11,84(30)
	stw 28,3820(11)
	b .L182
.L191:
	lwz 0,3828(5)
	cmpw 0,0,31
	bc 4,2,.L192
	lis 4,.LC67@ha
	mr 3,31
	la 4,.LC67@l(4)
.L202:
	addi 5,5,700
	crxor 6,6,6
	bl safe_centerprintf
	b .L182
.L192:
	lwz 9,84(31)
	lwz 0,3820(9)
	cmpw 0,30,0
	bc 4,2,.L193
	mr 3,30
	bl IsFemale
	cmpwi 0,3,0
	bc 12,2,.L194
	lis 9,.LC68@ha
	la 29,.LC68@l(9)
	b .L195
.L194:
	mr 3,30
	bl IsNeutral
	cmpwi 0,3,0
	bc 12,2,.L196
	lis 9,.LC69@ha
	la 29,.LC69@l(9)
	b .L195
.L196:
	lis 9,.LC70@ha
	la 29,.LC70@l(9)
.L195:
	lis 4,.LC71@ha
	mr 3,31
	la 4,.LC71@l(4)
	mr 5,29
	crxor 6,6,6
	bl safe_centerprintf
	b .L182
.L193:
	mr 3,31
	bl IsFemale
	cmpwi 0,3,0
	bc 12,2,.L198
	lis 9,.LC68@ha
	la 29,.LC68@l(9)
	b .L199
.L198:
	mr 3,31
	bl IsNeutral
	cmpwi 0,3,0
	bc 12,2,.L200
	lis 9,.LC69@ha
	la 29,.LC69@l(9)
	b .L199
.L200:
	lis 9,.LC70@ha
	la 29,.LC70@l(9)
.L199:
	lwz 5,84(30)
	lis 4,.LC72@ha
	mr 3,31
	la 4,.LC72@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl safe_centerprintf
	lwz 5,84(31)
	lis 4,.LC73@ha
	mr 6,29
	la 4,.LC73@l(4)
	mr 3,30
	addi 5,5,700
	crxor 6,6,6
	bl safe_centerprintf
	lwz 9,84(31)
	stw 30,3820(9)
	lwz 11,84(30)
	stw 31,3824(11)
.L182:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 Cmd_Partner_f,.Lfe7-Cmd_Partner_f
	.section	".rodata"
	.align 2
.LC75:
	.string	"You don't have a partner\n"
	.align 2
.LC76:
	.string	"%s broke your partnership\n"
	.align 2
.LC77:
	.string	"You broke your partnership with %s\n"
	.align 2
.LC78:
	.string	"You denied %s\n"
	.align 2
.LC79:
	.string	"%s has denied you\n"
	.align 2
.LC80:
	.string	"No one has offered to be your partner\n"
	.section	".text"
	.align 2
	.globl Cmd_Radio_f
	.type	 Cmd_Radio_f,@function
Cmd_Radio_f:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,gi+164@ha
	mr 28,3
	lwz 0,gi+164@l(11)
	lwz 9,84(28)
	mtlr 0
	lwz 29,3872(9)
	blrl
	mr 5,3
	mr 4,29
	mr 3,28
	bl RadioBroadcast
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 Cmd_Radio_f,.Lfe8-Cmd_Radio_f
	.section	".rodata"
	.align 2
.LC81:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Radio_power_f
	.type	 Cmd_Radio_power_f,@function
Cmd_Radio_power_f:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 11,.LC81@ha
	lis 9,teamplay@ha
	la 11,.LC81@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L160
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,192
	bc 12,2,.L159
.L160:
	lwz 11,84(31)
	lwz 0,3880(11)
	subfic 9,0,0
	adde 0,9,0
	stw 0,3880(11)
	lwz 9,84(31)
	lwz 0,3880(9)
	cmpwi 0,0,0
	bc 12,2,.L162
	lis 4,.LC53@ha
	mr 3,31
	la 4,.LC53@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	lis 4,.LC54@ha
	mr 3,31
	la 4,.LC54@l(4)
	bl stuffcmd
	b .L159
.L162:
	lis 4,.LC55@ha
	mr 3,31
	la 4,.LC55@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	lis 4,.LC54@ha
	mr 3,31
	la 4,.LC54@l(4)
	bl stuffcmd
.L159:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 Cmd_Radio_power_f,.Lfe9-Cmd_Radio_power_f
	.align 2
	.globl Cmd_Radiopartner_f
	.type	 Cmd_Radiopartner_f,@function
Cmd_Radiopartner_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi+164@ha
	mr 29,3
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 5,3
	li 4,1
	mr 3,29
	bl RadioBroadcast
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 Cmd_Radiopartner_f,.Lfe10-Cmd_Radiopartner_f
	.align 2
	.globl Cmd_Radioteam_f
	.type	 Cmd_Radioteam_f,@function
Cmd_Radioteam_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi+164@ha
	mr 29,3
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 5,3
	li 4,0
	mr 3,29
	bl RadioBroadcast
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 Cmd_Radioteam_f,.Lfe11-Cmd_Radioteam_f
	.section	".rodata"
	.align 2
.LC82:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Channel_f
	.type	 Cmd_Channel_f,@function
Cmd_Channel_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC82@ha
	lis 9,teamplay@ha
	la 11,.LC82@l(11)
	lfs 13,0(11)
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L165
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,192
	bc 12,2,.L164
.L165:
	lwz 11,84(3)
	lwz 0,3872(11)
	subfic 9,0,0
	adde 0,9,0
	stw 0,3872(11)
	lwz 9,84(3)
	lwz 0,3872(9)
	cmpwi 0,0,0
	bc 12,2,.L167
	lis 4,.LC56@ha
	la 4,.LC56@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	b .L164
.L167:
	lis 4,.LC57@ha
	la 4,.LC57@l(4)
	crxor 6,6,6
	bl safe_centerprintf
.L164:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe12:
	.size	 Cmd_Channel_f,.Lfe12-Cmd_Channel_f
	.section	".rodata"
	.align 2
.LC83:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Say_partner_f
	.type	 Cmd_Say_partner_f,@function
Cmd_Say_partner_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC83@ha
	lis 9,teamplay@ha
	la 11,.LC83@l(11)
	lfs 13,0(11)
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L218
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,192
	bc 12,2,.L217
.L218:
	lwz 9,84(3)
	lwz 0,3816(9)
	cmpwi 0,0,0
	bc 4,2,.L220
	lis 5,.LC39@ha
	li 4,2
	la 5,.LC39@l(5)
	crxor 6,6,6
	bl safe_cprintf
	b .L217
.L220:
	li 4,0
	li 5,0
	li 6,1
	bl Cmd_Say_f
.L217:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe13:
	.size	 Cmd_Say_partner_f,.Lfe13-Cmd_Say_partner_f
	.section	".rodata"
	.align 2
.LC84:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Deny_f
	.type	 Cmd_Deny_f,@function
Cmd_Deny_f:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 11,.LC84@ha
	lis 9,teamplay@ha
	la 11,.LC84@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L210
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,192
	bc 12,2,.L209
.L210:
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L209
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L209
	lwz 9,84(31)
	lwz 30,3824(9)
	cmpwi 0,30,0
	bc 12,2,.L214
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L214
	lwz 5,84(30)
	lis 4,.LC78@ha
	mr 3,31
	la 4,.LC78@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl safe_centerprintf
	lwz 5,84(31)
	lis 4,.LC79@ha
	mr 3,30
	la 4,.LC79@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl safe_centerprintf
	lwz 9,84(31)
	li 10,0
	stw 30,3828(9)
	lwz 11,84(31)
	stw 10,3824(11)
	lwz 3,84(30)
	lwz 0,3820(3)
	cmpw 0,0,31
	bc 4,2,.L209
	stw 10,3820(3)
	b .L209
.L214:
	lis 4,.LC80@ha
	mr 3,31
	la 4,.LC80@l(4)
	crxor 6,6,6
	bl safe_centerprintf
.L209:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 Cmd_Deny_f,.Lfe14-Cmd_Deny_f
	.section	".rodata"
	.align 2
.LC85:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Unpartner_f
	.type	 Cmd_Unpartner_f,@function
Cmd_Unpartner_f:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 11,.LC85@ha
	lis 9,teamplay@ha
	la 11,.LC85@l(11)
	mr 30,3
	lfs 13,0(11)
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L204
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,192
	bc 12,2,.L203
.L204:
	lwz 11,84(30)
	lwz 9,3816(11)
	cmpwi 0,9,0
	bc 12,2,.L206
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 4,2,.L206
	stw 0,3816(11)
.L206:
	lwz 5,84(30)
	lwz 31,3816(5)
	cmpwi 0,31,0
	bc 4,2,.L207
	lis 4,.LC75@ha
	mr 3,30
	la 4,.LC75@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	b .L203
.L207:
	lwz 9,84(31)
	lwz 0,3816(9)
	cmpw 0,0,30
	bc 4,2,.L208
	lis 4,.LC76@ha
	addi 5,5,700
	la 4,.LC76@l(4)
	mr 3,31
	crxor 6,6,6
	bl safe_centerprintf
	lwz 9,84(31)
	li 0,0
	stw 0,3816(9)
.L208:
	lwz 5,84(31)
	lis 4,.LC77@ha
	mr 3,30
	la 4,.LC77@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl safe_centerprintf
	lwz 9,84(30)
	li 0,0
	stw 0,3816(9)
.L203:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 Cmd_Unpartner_f,.Lfe15-Cmd_Unpartner_f
	.align 2
	.globl PrecacheRadioMsgSet
	.type	 PrecacheRadioMsgSet,@function
PrecacheRadioMsgSet:
	stwu 1,-2064(1)
	mflr 0
	stmw 30,2056(1)
	stw 0,2068(1)
	mr 31,3
	mr 30,4
	b .L7
.L9:
	lwz 6,0(31)
	addi 31,31,8
	crxor 6,6,6
	bl sprintf
	lis 9,gi+36@ha
	addi 3,1,8
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
.L7:
	lwz 3,0(31)
	lis 4,.LC25@ha
	la 4,.LC25@l(4)
	bl strcmp
	cmpwi 0,3,0
	lis 4,.LC26@ha
	mr 5,30
	la 4,.LC26@l(4)
	addi 3,1,8
	bc 4,2,.L9
	lwz 0,2068(1)
	mtlr 0
	lmw 30,2056(1)
	la 1,2064(1)
	blr
.Lfe16:
	.size	 PrecacheRadioMsgSet,.Lfe16-PrecacheRadioMsgSet
	.align 2
	.globl DeleteFirstRadioQueueEntry
	.type	 DeleteFirstRadioQueueEntry,@function
DeleteFirstRadioQueueEntry:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 30,3
	lwz 9,84(30)
	lwz 0,3812(9)
	cmpwi 0,0,0
	bc 12,1,.L23
	lis 9,gi+4@ha
	lis 3,.LC32@ha
	lwz 0,gi+4@l(9)
	la 3,.LC32@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L22
.L23:
	li 31,1
	cmpw 0,31,0
	bc 4,0,.L25
	li 29,52
.L27:
	lwz 3,84(30)
	li 5,52
	addi 31,31,1
	add 3,29,3
	addi 4,3,3500
	addi 29,29,52
	addi 3,3,3448
	crxor 6,6,6
	bl memcpy
	lwz 9,84(30)
	lwz 0,3812(9)
	cmpw 0,31,0
	bc 12,0,.L27
.L25:
	lwz 11,84(30)
	lwz 9,3812(11)
	addi 9,9,-1
	stw 9,3812(11)
.L22:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 DeleteFirstRadioQueueEntry,.Lfe17-DeleteFirstRadioQueueEntry
	.align 2
	.globl DeleteRadioQueueEntry
	.type	 DeleteRadioQueueEntry,@function
DeleteRadioQueueEntry:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lwz 9,84(29)
	lwz 0,3812(9)
	cmpw 0,0,4
	bc 12,1,.L30
	lis 9,gi+4@ha
	lis 3,.LC33@ha
	lwz 0,gi+4@l(9)
	la 3,.LC33@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L29
.L30:
	addi 31,4,1
	cmpw 0,31,0
	bc 4,0,.L32
	mulli 30,31,52
.L34:
	lwz 3,84(29)
	li 5,52
	addi 31,31,1
	add 3,30,3
	addi 4,3,3500
	addi 30,30,52
	addi 3,3,3448
	crxor 6,6,6
	bl memcpy
	lwz 9,84(29)
	lwz 0,3812(9)
	cmpw 0,31,0
	bc 12,0,.L34
.L32:
	lwz 11,84(29)
	lwz 9,3812(11)
	addi 9,9,-1
	stw 9,3812(11)
.L29:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 DeleteRadioQueueEntry,.Lfe18-DeleteRadioQueueEntry
	.align 2
	.globl TotalNonClickMessagesInQueue
	.type	 TotalNonClickMessagesInQueue,@function
TotalNonClickMessagesInQueue:
	lwz 8,84(3)
	li 6,0
	li 3,0
	lwz 0,3812(8)
	cmpw 0,3,0
	bclr 4,0
	li 7,0
.L81:
	addi 11,8,3548
	lwz 0,3812(8)
	addi 6,6,1
	lwzx 10,11,7
	addi 9,3,1
	cmpw 0,6,0
	addi 7,7,52
	srawi 11,10,31
	xor 0,11,10
	subf 0,0,11
	srawi 0,0,31
	andc 9,9,0
	and 0,3,0
	or 3,0,9
	bc 12,0,.L81
	blr
.Lfe19:
	.size	 TotalNonClickMessagesInQueue,.Lfe19-TotalNonClickMessagesInQueue
	.align 2
	.globl AppendRadioMsgToQueue
	.type	 AppendRadioMsgToQueue,@function
AppendRadioMsgToQueue:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 28,3
	mr 30,4
	lwz 11,84(28)
	mr 26,5
	mr 27,6
	mr 29,7
	lwz 9,3812(11)
	cmpwi 0,9,5
	bc 4,1,.L85
	lis 9,gi+4@ha
	lis 3,.LC35@ha
	lwz 0,gi+4@l(9)
	la 3,.LC35@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L84
.L85:
	mulli 9,9,52
	mr 3,30
	addi 9,9,3500
	add 31,11,9
	bl strlen
	addi 3,3,1
	cmplwi 0,3,32
	bc 4,1,.L86
	lis 9,gi+4@ha
	lis 3,.LC36@ha
	lwz 0,gi+4@l(9)
	la 3,.LC36@l(3)
	mr 4,30
	mtlr 0
	crxor 6,6,6
	blrl
	li 0,0
	stb 0,31(30)
.L86:
	mr 4,30
	mr 3,31
	bl strcpy
	stw 29,32(31)
	li 11,0
	lwz 9,84(29)
	lwz 0,3876(9)
	stw 27,48(31)
	stw 0,36(31)
	stw 11,40(31)
	stw 26,44(31)
	lwz 11,84(28)
	lwz 9,3812(11)
	addi 9,9,1
	stw 9,3812(11)
.L84:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 AppendRadioMsgToQueue,.Lfe20-AppendRadioMsgToQueue
	.align 2
	.globl InsertRadioMsgInQueueBeforeClick
	.type	 InsertRadioMsgInQueueBeforeClick,@function
InsertRadioMsgInQueueBeforeClick:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 29,3
	mr 30,4
	lwz 9,84(29)
	mr 27,5
	mr 28,6
	lwz 3,3812(9)
	cmpwi 0,3,5
	bc 4,1,.L88
	lis 9,gi+4@ha
	lis 3,.LC37@ha
	lwz 0,gi+4@l(9)
	la 3,.LC37@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L87
.L88:
	mulli 3,3,52
	li 5,52
	add 3,3,9
	addi 4,3,3448
	addi 3,3,3500
	crxor 6,6,6
	bl memcpy
	lwz 11,84(29)
	mr 3,30
	lwz 9,3812(11)
	mulli 9,9,52
	addi 9,9,3448
	add 31,11,9
	bl strlen
	addi 3,3,1
	cmplwi 0,3,32
	bc 4,1,.L89
	lis 9,gi+4@ha
	lis 3,.LC36@ha
	lwz 0,gi+4@l(9)
	la 3,.LC36@l(3)
	mr 4,30
	mtlr 0
	crxor 6,6,6
	blrl
	li 0,0
	stb 0,31(30)
.L89:
	mr 4,30
	mr 3,31
	bl strcpy
	stw 28,32(31)
	li 10,0
	lwz 9,84(28)
	lwz 0,3876(9)
	stw 10,48(31)
	stw 0,36(31)
	stw 27,44(31)
	stw 10,40(31)
	lwz 11,84(29)
	lwz 9,3812(11)
	addi 9,9,1
	stw 9,3812(11)
.L87:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 InsertRadioMsgInQueueBeforeClick,.Lfe21-InsertRadioMsgInQueueBeforeClick
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
