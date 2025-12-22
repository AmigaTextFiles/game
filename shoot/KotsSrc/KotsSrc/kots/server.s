	.file	"server.cpp"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"Current KOTS Version: "
	.align 2
.LC1:
	.string	"5.3"
	.align 2
.LC2:
	.string	"KOTS: "
	.align 2
.LC3:
	.string	"\n"
	.align 2
.LC4:
	.string	"%s\\%s"
	.align 2
.LC5:
	.string	"%s entered the game\n"
	.align 2
.LC6:
	.string	"name"
	.align 2
.LC7:
	.string	"rejmsg"
	.align 2
.LC8:
	.string	"You need a name to play."
	.align 2
.LC9:
	.string	"ip"
	.align 2
.LC10:
	.string	"kots_password"
	.align 2
.LC11:
	.string	"changeme"
	.align 2
.LC12:
	.string	"Password must be less than 30 chars long."
	.align 2
.LC13:
	.string	"Player is already in the game."
	.align 2
.LC14:
	.string	"Invalid password for username."
	.align 2
.LC15:
	.string	"Unknown Error."
	.align 2
.LC16:
	.string	"Cannot enter due to level restrictions."
	.align 2
.LC17:
	.string	"No bosses in KOTS Lives."
	.align 2
.LC18:
	.string	"Cannot enter in the middle of KOTS Lives."
	.align 3
.LC19:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC20:
	.long 0x0
	.align 3
.LC21:
	.long 0x404e0000
	.long 0x0
	.section	".text"
	.align 2
	.globl KOTSClientCanEnter__FP7edict_s
	.type	 KOTSClientCanEnter__FP7edict_s,@function
KOTSClientCanEnter__FP7edict_s:
	stwu 1,-192(1)
	mflr 0
	stfd 31,184(1)
	stmw 27,164(1)
	stw 0,196(1)
	mr 30,3
	lis 4,.LC10@ha
	lwz 9,84(30)
	la 4,.LC10@l(4)
	addi 31,9,188
	mr 3,31
	bl Info_ValueForKey
	mr 29,3
	lis 4,.LC6@ha
	la 4,.LC6@l(4)
	mr 3,31
	bl Info_ValueForKey
	mr 27,3
	mr 4,29
	addi 3,1,8
	bl strcpy
	addi 3,1,8
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L40
	lis 9,.LC11@ha
	addi 8,1,8
	la 11,.LC11@l(9)
	lwz 10,.LC11@l(9)
	lbz 0,8(11)
	lwz 9,4(11)
	stb 0,8(8)
	stw 10,8(1)
	stw 9,4(8)
.L40:
	addi 3,1,8
	bl strlen
	cmplwi 0,3,29
	bc 4,1,.L41
	lis 9,gi+12@ha
	lis 4,.LC12@ha
	lwz 0,gi+12@l(9)
	mr 3,30
	la 4,.LC12@l(4)
	b .L59
.L41:
	lis 4,.LC9@ha
	mr 3,31
	la 4,.LC9@l(4)
	bl Info_ValueForKey
	cmpwi 0,30,0
	bc 12,2,.L60
	lwz 9,84(30)
	cmpwi 0,9,0
	bc 4,2,.L44
.L60:
	li 31,0
	b .L43
.L44:
	lwz 9,1812(9)
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	and 31,9,0
.L43:
	cmpwi 0,31,0
	lis 28,theApp@ha
	bc 12,2,.L46
	mr 4,31
	la 3,theApp@l(28)
	li 5,0
	bl DelUser__8CKotsAppP5CUserb
	lwz 9,84(30)
	li 0,0
	stw 0,1812(9)
.L46:
	lis 3,theApp@ha
	mr 4,27
	la 3,theApp@l(3)
	addi 5,1,8
	addi 6,1,120
	bl AddUser__8CKotsAppPCcT1Ri
	mr. 31,3
	bc 4,2,.L47
	lwz 0,120(1)
	cmpwi 0,0,5
	bc 12,2,.L50
	cmpwi 0,0,12
	bc 4,2,.L51
	lis 9,gi+12@ha
	lis 4,.LC13@ha
	lwz 0,gi+12@l(9)
	mr 3,30
	la 4,.LC13@l(4)
	b .L59
.L50:
	lis 9,gi+12@ha
	lis 4,.LC14@ha
	lwz 0,gi+12@l(9)
	mr 3,30
	la 4,.LC14@l(4)
	b .L59
.L51:
	lis 9,gi+12@ha
	lis 4,.LC15@ha
	lwz 0,gi+12@l(9)
	mr 3,30
	la 4,.LC15@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L62
.L47:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	lis 29,0x4330
	lis 9,.LC19@ha
	xoris 3,3,0x8000
	la 9,.LC19@l(9)
	lis 10,kots_levelmin@ha
	lfd 31,0(9)
	lwz 11,kots_levelmin@l(10)
	stw 3,156(1)
	stw 29,152(1)
	lfd 0,152(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L54
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	xoris 3,3,0x8000
	stw 3,156(1)
	lis 10,kots_levelmax@ha
	stw 29,152(1)
	lfd 0,152(1)
	lwz 11,kots_levelmax@l(10)
	fsub 0,0,31
	lfs 13,20(11)
	frsp 0,0
	fcmpu 0,0,13
	bc 4,1,.L53
.L54:
	mr 4,31
	li 5,0
	la 3,theApp@l(28)
	bl DelUser__8CKotsAppP5CUserb
	lis 9,gi+12@ha
	lis 4,.LC16@ha
	lwz 0,gi+12@l(9)
	mr 3,30
	la 4,.LC16@l(4)
	b .L59
.L53:
	lis 9,.LC20@ha
	lis 11,kots_lives@ha
	la 9,.LC20@l(9)
	lfs 13,0(9)
	lwz 9,kots_lives@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L55
	lbz 0,244(31)
	cmpwi 0,0,0
	bc 12,2,.L55
	mr 4,31
	li 5,0
	la 3,theApp@l(28)
	bl DelUser__8CKotsAppP5CUserb
	lis 9,gi+12@ha
	lis 4,.LC17@ha
	lwz 0,gi+12@l(9)
	mr 3,30
	la 4,.LC17@l(4)
	b .L59
.L55:
	lis 9,.LC20@ha
	lis 11,kots_lives@ha
	la 9,.LC20@l(9)
	lfs 13,0(9)
	lwz 9,kots_lives@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L56
	lis 9,level+4@ha
	lis 11,.LC21@ha
	lfs 0,level+4@l(9)
	la 11,.LC21@l(11)
	lfd 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L56
	lis 3,theApp@ha
	mr 4,31
	li 5,0
	la 3,theApp@l(3)
	bl DelUser__8CKotsAppP5CUserb
	lis 9,gi+12@ha
	lis 4,.LC18@ha
	lwz 0,gi+12@l(9)
	mr 3,30
	la 4,.LC18@l(4)
.L59:
	mtlr 0
	crxor 6,6,6
	blrl
.L62:
	li 3,0
	b .L58
.L56:
	lwz 8,84(30)
	lis 11,kots_lives@ha
	lwz 10,kots_lives@l(11)
	li 3,1
	stw 31,1812(8)
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,152(1)
	lwz 9,156(1)
	stw 9,928(30)
	stw 30,4(31)
.L58:
	lwz 0,196(1)
	mtlr 0
	lmw 27,164(1)
	lfd 31,184(1)
	la 1,192(1)
	blr
.Lfe1:
	.size	 KOTSClientCanEnter__FP7edict_s,.Lfe1-KOTSClientCanEnter__FP7edict_s
	.section	".rodata"
	.align 2
.LC22:
	.string	"Edict leaving with no user.\n"
	.align 2
.LC23:
	.string	"User leaving but not found.\n"
	.align 2
.LC24:
	.string	"visit www.planetquake.com/kots to choose new abilities."
	.align 2
.LC25:
	.string	"To teleport yourself:\n bind x use tball self"
	.align 2
.LC26:
	.string	"To teleport another:\n bind x use tball"
	.align 2
.LC27:
	.string	""
	.align 2
.LC28:
	.string	"Vote for next map\n by typing vote in console."
	.align 2
.LC29:
	.string	"Game score is your score for this map"
	.align 2
.LC30:
	.string	"Total score is your saved score\n for every time you've played kots"
	.align 2
.LC31:
	.string	"To set a password:\n set kots_password mypass u"
	.align 2
.LC32:
	.string	"The first Quake based RPG!"
	.align 2
.LC33:
	.string	"The saber replaces the blaster\n to use it, just use the blaster"
	.align 2
.LC34:
	.string	"You get 1 point for each player you teleport\n if you don't teleport yourself"
	.align 2
.LC35:
	.string	"Level 1 is reached when you have\n 100 total points"
	.align 2
.LC36:
	.string	"Sometimes you have to type your password 3\n times at the console to get in the game"
	.align 2
.LC37:
	.string	"Type kotsinfo in the console"
	.align 2
.LC38:
	.string	"This help stops after you reach\n Level 1"
	.align 2
.LC39:
	.string	"Type kotshelp to get this help\n after Level 0"
	.align 2
.LC40:
	.string	"A spree war is everyone against\n the guy glowing white"
	.align 2
.LC41:
	.string	"Someone glowing green\n is on a killing spree"
	.align 2
.LC42:
	.string	"Player help is at\n www.planetquake.com/kots"
	.section	".text"
	.align 2
	.globl KOTSHelp__FP5CUseri
	.type	 KOTSHelp__FP5CUseri,@function
KOTSHelp__FP5CUseri:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lwz 31,4(3)
	subfic 0,3,0
	adde 9,0,3
	mr 30,4
	subfic 11,31,0
	adde 0,11,31
	or. 11,9,0
	bc 4,2,.L81
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,0
	bc 4,1,.L83
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L81
.L83:
	cmpwi 0,30,0
	bc 12,2,.L84
	lis 9,gi+12@ha
	lis 4,.LC24@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC24@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L81
.L84:
	lwz 9,896(31)
	addi 9,9,-1
	cmplwi 0,9,22
	bc 12,1,.L109
	lis 11,.L110@ha
	slwi 10,9,2
	la 11,.L110@l(11)
	lis 9,.L110@ha
	lwzx 0,10,11
	la 9,.L110@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L110:
	.long .L86-.L110
	.long .L87-.L110
	.long .L88-.L110
	.long .L89-.L110
	.long .L90-.L110
	.long .L91-.L110
	.long .L92-.L110
	.long .L93-.L110
	.long .L94-.L110
	.long .L95-.L110
	.long .L96-.L110
	.long .L97-.L110
	.long .L98-.L110
	.long .L99-.L110
	.long .L100-.L110
	.long .L101-.L110
	.long .L102-.L110
	.long .L103-.L110
	.long .L104-.L110
	.long .L105-.L110
	.long .L106-.L110
	.long .L107-.L110
	.long .L108-.L110
.L86:
	lis 9,gi+12@ha
	lis 4,.LC25@ha
	lwz 0,gi+12@l(9)
	la 4,.LC25@l(4)
	b .L112
.L87:
	lis 9,gi+12@ha
	lis 4,.LC26@ha
	lwz 0,gi+12@l(9)
	la 4,.LC26@l(4)
	b .L112
.L88:
	lis 9,gi+12@ha
	lis 4,.LC27@ha
	lwz 0,gi+12@l(9)
	la 4,.LC27@l(4)
	b .L112
.L89:
	lis 9,gi+12@ha
	lis 4,.LC27@ha
	lwz 0,gi+12@l(9)
	la 4,.LC27@l(4)
	b .L112
.L90:
	lis 9,gi+12@ha
	lis 4,.LC28@ha
	lwz 0,gi+12@l(9)
	la 4,.LC28@l(4)
	b .L112
.L91:
	lis 9,gi+12@ha
	lis 4,.LC27@ha
	lwz 0,gi+12@l(9)
	la 4,.LC27@l(4)
	b .L112
.L92:
	lis 9,gi+12@ha
	lis 4,.LC29@ha
	lwz 0,gi+12@l(9)
	la 4,.LC29@l(4)
	b .L112
.L93:
	lis 9,gi+12@ha
	lis 4,.LC30@ha
	lwz 0,gi+12@l(9)
	la 4,.LC30@l(4)
	b .L112
.L94:
	lis 9,gi+12@ha
	lis 4,.LC27@ha
	lwz 0,gi+12@l(9)
	la 4,.LC27@l(4)
	b .L112
.L95:
	lis 9,gi+12@ha
	lis 4,.LC31@ha
	lwz 0,gi+12@l(9)
	la 4,.LC31@l(4)
	b .L112
.L96:
	lis 9,gi+12@ha
	lis 4,.LC27@ha
	lwz 0,gi+12@l(9)
	la 4,.LC27@l(4)
	b .L112
.L97:
	lis 9,gi+12@ha
	lis 4,.LC32@ha
	lwz 0,gi+12@l(9)
	la 4,.LC32@l(4)
	b .L112
.L98:
	lis 9,gi+12@ha
	lis 4,.LC33@ha
	lwz 0,gi+12@l(9)
	la 4,.LC33@l(4)
	b .L112
.L99:
	lis 9,gi+12@ha
	lis 4,.LC34@ha
	lwz 0,gi+12@l(9)
	la 4,.LC34@l(4)
	b .L112
.L100:
	lis 9,gi+12@ha
	lis 4,.LC35@ha
	lwz 0,gi+12@l(9)
	la 4,.LC35@l(4)
	b .L112
.L101:
	lis 9,gi+12@ha
	lis 4,.LC36@ha
	lwz 0,gi+12@l(9)
	la 4,.LC36@l(4)
	b .L112
.L102:
	lis 9,gi+12@ha
	lis 4,.LC27@ha
	lwz 0,gi+12@l(9)
	la 4,.LC27@l(4)
	b .L112
.L103:
	lis 9,gi+12@ha
	lis 4,.LC37@ha
	lwz 0,gi+12@l(9)
	la 4,.LC37@l(4)
	b .L112
.L104:
	lis 9,gi+12@ha
	lis 4,.LC27@ha
	lwz 0,gi+12@l(9)
	la 4,.LC27@l(4)
	b .L112
.L105:
	lis 9,gi+12@ha
	lis 4,.LC38@ha
	lwz 0,gi+12@l(9)
	la 4,.LC38@l(4)
	b .L112
.L106:
	lis 9,gi+12@ha
	lis 4,.LC39@ha
	lwz 0,gi+12@l(9)
	la 4,.LC39@l(4)
	b .L112
.L107:
	lis 9,gi+12@ha
	lis 4,.LC40@ha
	lwz 0,gi+12@l(9)
	la 4,.LC40@l(4)
	b .L112
.L108:
	lis 9,gi+12@ha
	lis 4,.LC41@ha
	lwz 0,gi+12@l(9)
	la 4,.LC41@l(4)
.L112:
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,896(31)
	addi 9,9,1
	stw 9,896(31)
	b .L81
.L109:
	lis 9,gi+12@ha
	lis 4,.LC42@ha
	lwz 0,gi+12@l(9)
	la 4,.LC42@l(4)
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
	li 0,1
	stw 0,896(31)
.L81:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe2:
	.size	 KOTSHelp__FP5CUseri,.Lfe2-KOTSHelp__FP5CUseri
	.section	".rodata"
	.align 2
.LC43:
	.string	"makron/laf%d.wav"
	.align 2
.LC44:
	.string	"makron/roar%d.wav"
	.align 2
.LC45:
	.string	"makron/voice%d.wav"
	.align 2
.LC46:
	.string	"makron/voice.wav"
	.align 2
.LC47:
	.long 0x3f800000
	.align 2
.LC48:
	.long 0x0
	.section	".text"
	.align 2
	.globl KOTSDeathSound
	.type	 KOTSDeathSound,@function
KOTSDeathSound:
	stwu 1,-96(1)
	mflr 0
	stmw 29,84(1)
	stw 0,100(1)
	mr. 31,3
	bc 12,2,.L113
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L113
	lwz 9,904(31)
	addi 9,9,-1
	cmplwi 0,9,8
	bc 12,1,.L126
	lis 11,.L127@ha
	slwi 10,9,2
	la 11,.L127@l(11)
	lis 9,.L127@ha
	lwzx 0,10,11
	la 9,.L127@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L127:
	.long .L119-.L127
	.long .L119-.L127
	.long .L119-.L127
	.long .L121-.L127
	.long .L121-.L127
	.long .L125-.L127
	.long .L125-.L127
	.long .L125-.L127
	.long .L125-.L127
.L119:
	lis 4,.LC43@ha
	lwz 5,904(31)
	addi 3,1,8
	la 4,.LC43@l(4)
	crxor 6,6,6
	bl sprintf
	b .L116
.L121:
	lwz 5,904(31)
	lis 4,.LC44@ha
	addi 3,1,8
	la 4,.LC44@l(4)
	addi 5,5,-3
	crxor 6,6,6
	bl sprintf
	b .L116
.L125:
	lwz 5,904(31)
	lis 4,.LC45@ha
	addi 3,1,8
	la 4,.LC45@l(4)
	addi 5,5,-5
	crxor 6,6,6
	bl sprintf
	b .L116
.L126:
	li 0,0
	lis 10,.LC46@ha
	stw 0,904(31)
	la 9,.LC46@l(10)
	addi 11,1,8
	lwz 0,.LC46@l(10)
	lbz 8,16(9)
	lwz 10,4(9)
	lwz 7,8(9)
	lwz 6,12(9)
	stw 0,8(1)
	stb 8,16(11)
	stw 10,4(11)
	stw 7,8(11)
	stw 6,12(11)
.L116:
	lwz 9,904(31)
	lis 29,gi@ha
	addi 3,1,8
	la 29,gi@l(29)
	addi 9,9,1
	stw 9,904(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC47@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC47@l(9)
	li 4,5
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC47@ha
	la 9,.LC47@l(9)
	lfs 2,0(9)
	lis 9,.LC48@ha
	la 9,.LC48@l(9)
	lfs 3,0(9)
	blrl
.L113:
	lwz 0,100(1)
	mtlr 0
	lmw 29,84(1)
	la 1,96(1)
	blr
.Lfe3:
	.size	 KOTSDeathSound,.Lfe3-KOTSDeathSound
	.section	".rodata"
	.align 2
.LC49:
	.string	"player"
	.align 2
.LC50:
	.string	"*jump1.wav"
	.align 2
.LC51:
	.string	"%s got kicked out of the way by %s\n"
	.align 2
.LC52:
	.long 0x42c80000
	.align 2
.LC53:
	.long 0x44480000
	.align 2
.LC54:
	.long 0x3f000000
	.align 3
.LC55:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC56:
	.long 0x0
	.align 2
.LC57:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl KOTSSpawnKick
	.type	 KOTSSpawnKick,@function
KOTSSpawnKick:
	stwu 1,-96(1)
	mflr 0
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 26,56(1)
	stw 0,100(1)
	lis 9,.LC52@ha
	lis 10,.LC53@ha
	la 9,.LC52@l(9)
	la 10,.LC53@l(10)
	lfs 31,0(9)
	mr 29,3
	lis 26,gi@ha
	lfs 30,0(10)
	addi 28,29,4
	la 27,gi@l(26)
	li 30,0
	b .L130
.L132:
	lwz 11,84(30)
	xor 9,30,29
	subfic 0,9,0
	adde 9,0,9
	subfic 10,11,0
	adde 0,10,11
	or. 10,0,9
	bc 4,2,.L130
	lwz 0,512(30)
	cmpwi 0,0,0
	bc 12,2,.L130
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L130
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L130
	lwz 0,3580(11)
	cmpwi 0,0,0
	bc 12,2,.L130
	lwz 0,3576(11)
	cmpwi 0,0,0
	bc 4,2,.L130
	lfs 0,200(30)
	lis 9,.LC54@ha
	addi 4,1,16
	lfs 13,188(30)
	la 9,.LC54@l(9)
	addi 3,30,4
	lfs 1,0(9)
	mr 5,4
	fadds 13,13,0
	stfs 13,16(1)
	lfs 13,204(30)
	lfs 0,192(30)
	fadds 0,0,13
	stfs 0,20(1)
	lfs 0,208(30)
	lfs 13,196(30)
	fadds 13,13,0
	stfs 13,24(1)
	bl VectorMA
	lfs 0,4(29)
	addi 3,1,16
	lfs 13,8(29)
	lfs 12,12(29)
	lfs 9,16(1)
	lfs 11,20(1)
	lfs 10,24(1)
	fsubs 0,0,9
	fsubs 13,13,11
	fsubs 12,12,10
	stfs 0,16(1)
	stfs 13,20(1)
	stfs 12,24(1)
	bl VectorLength
	lis 9,.LC55@ha
	lis 10,.LC56@ha
	la 9,.LC55@l(9)
	fmr 0,31
	la 10,.LC56@l(10)
	lfd 13,0(9)
	lfs 12,0(10)
	fmul 1,1,13
	fsub 0,0,1
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L130
	mr 3,30
	mr 4,29
	bl CanDamage
	cmpwi 0,3,0
	bc 12,2,.L130
	lwz 3,280(30)
	lis 31,.LC49@ha
	la 4,.LC49@l(31)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L130
	lwz 3,280(29)
	la 4,.LC49@l(31)
	bl strcmp
	mr. 11,3
	bc 4,2,.L130
	lfs 13,4(29)
	fmr 11,30
	li 0,21
	lfs 12,4(30)
	lis 8,vec3_origin@ha
	addi 6,1,32
	lfs 10,8(29)
	li 9,0
	la 8,vec3_origin@l(8)
	lfs 9,12(29)
	fctiwz 0,11
	mr 4,29
	mr 5,29
	fsubs 12,12,13
	mr 7,28
	mr 3,30
	stfd 0,48(1)
	stfs 12,32(1)
	lfs 13,8(30)
	lwz 10,52(1)
	fsubs 13,13,10
	stfs 13,36(1)
	lfs 0,12(30)
	stw 11,8(1)
	stw 0,12(1)
	fsubs 0,0,9
	stfs 0,40(1)
	bl T_Damage
	lwz 9,36(27)
	lis 3,.LC50@ha
	la 3,.LC50@l(3)
	mtlr 9
	blrl
	lis 9,.LC57@ha
	lwz 11,16(27)
	lis 10,.LC56@ha
	la 9,.LC57@l(9)
	mr 5,3
	lfs 2,0(9)
	la 10,.LC56@l(10)
	li 4,2
	mtlr 11
	lis 9,.LC57@ha
	mr 3,30
	lfs 3,0(10)
	la 9,.LC57@l(9)
	lfs 1,0(9)
	blrl
	lwz 5,84(30)
	lis 4,.LC51@ha
	li 3,2
	lwz 6,84(29)
	la 4,.LC51@l(4)
	lwz 9,gi@l(26)
	addi 5,5,700
	addi 6,6,700
	mtlr 9
	crxor 6,6,6
	blrl
.L130:
	lis 9,.LC52@ha
	mr 3,30
	la 9,.LC52@l(9)
	mr 4,28
	lfs 1,0(9)
	bl findradius
	mr. 30,3
	bc 4,2,.L132
	lwz 0,100(1)
	mtlr 0
	lmw 26,56(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe4:
	.size	 KOTSSpawnKick,.Lfe4-KOTSSpawnKick
	.align 2
	.globl KOTSStartup
	.type	 KOTSStartup,@function
KOTSStartup:
	stwu 1,-288(1)
	mflr 0
	stmw 28,272(1)
	stw 0,292(1)
	lis 9,.LC0@ha
	addi 29,1,8
	lwz 6,.LC0@l(9)
	lis 4,.LC1@ha
	mr 3,29
	la 9,.LC0@l(9)
	la 4,.LC1@l(4)
	lbz 5,22(9)
	lis 28,theApp@ha
	lwz 7,4(9)
	lwz 0,8(9)
	lwz 11,12(9)
	lwz 10,16(9)
	lhz 8,20(9)
	stw 6,8(1)
	stw 7,4(29)
	stw 0,8(29)
	stw 11,12(29)
	stw 10,16(29)
	sth 8,20(29)
	stb 5,22(29)
	bl strcat
	mr 3,29
	bl KOTSMessage__FPCc
	lis 11,kots_datapath@ha
	la 3,theApp@l(28)
	lwz 9,kots_datapath@l(11)
	lwz 4,4(9)
	bl SetDataDir__8CKotsAppPCc
	la 3,theApp@l(28)
	bl SaveAll__8CKotsApp
	lwz 0,292(1)
	mtlr 0
	lmw 28,272(1)
	la 1,288(1)
	blr
.Lfe5:
	.size	 KOTSStartup,.Lfe5-KOTSStartup
	.align 2
	.globl KOTSMessage__FPCc
	.type	 KOTSMessage__FPCc,@function
KOTSMessage__FPCc:
	stwu 1,-288(1)
	mflr 0
	stmw 29,276(1)
	stw 0,292(1)
	lis 9,.LC2@ha
	addi 29,1,8
	lwz 10,.LC2@l(9)
	mr 4,3
	la 9,.LC2@l(9)
	mr 3,29
	lhz 0,4(9)
	lbz 11,6(9)
	stw 10,8(1)
	sth 0,4(29)
	stb 11,6(29)
	bl strcat
	lis 4,.LC3@ha
	mr 3,29
	la 4,.LC3@l(4)
	bl strcat
	lis 9,gi+4@ha
	mr 3,29
	lwz 0,gi+4@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,292(1)
	mtlr 0
	lmw 29,276(1)
	la 1,288(1)
	blr
.Lfe6:
	.size	 KOTSMessage__FPCc,.Lfe6-KOTSMessage__FPCc
	.align 2
	.globl KOTSAssignSkin
	.type	 KOTSAssignSkin,@function
KOTSAssignSkin:
	stwu 1,-96(1)
	mflr 0
	stmw 28,80(1)
	stw 0,100(1)
	mr 29,3
	lis 11,g_edicts@ha
	lwz 9,g_edicts@l(11)
	lis 0,0xc10c
	lwz 10,84(29)
	ori 0,0,38677
	subf 9,9,29
	lwz 11,3584(10)
	mullw 9,9,0
	cmpwi 0,11,0
	srawi 9,9,4
	addi 28,9,-1
	bc 4,2,.L12
	lis 9,kots_skin1@ha
	lwz 11,kots_skin1@l(9)
	b .L143
.L12:
	lis 9,kots_skin2@ha
	lwz 11,kots_skin2@l(9)
.L143:
	lwz 31,4(11)
	mr 4,31
	addi 3,1,8
	bl strcpy
	addi 28,28,1312
	lwz 4,84(29)
	lis 3,.LC4@ha
	addi 5,1,8
	lis 29,gi@ha
	la 3,.LC4@l(3)
	la 29,gi@l(29)
	addi 4,4,700
	crxor 6,6,6
	bl va
	lwz 0,24(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
	mr 3,31
	lwz 0,100(1)
	mtlr 0
	lmw 28,80(1)
	la 1,96(1)
	blr
.Lfe7:
	.size	 KOTSAssignSkin,.Lfe7-KOTSAssignSkin
	.align 2
	.globl KOTSNumPlayers__Fv
	.type	 KOTSNumPlayers__Fv,@function
KOTSNumPlayers__Fv:
	lis 9,game+1544@ha
	li 3,0
	lwz 0,game+1544@l(9)
	cmpw 0,3,0
	bclr 4,0
	lis 11,g_edicts@ha
	mtctr 0
	lwz 9,g_edicts@l(11)
	addi 10,9,976
.L18:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L17
	lwz 9,84(10)
	lwz 0,3580(9)
	cmpwi 0,0,0
	bc 12,2,.L17
	lwz 11,3576(9)
	addi 9,3,1
	srawi 8,11,31
	xor 0,8,11
	subf 0,0,8
	srawi 0,0,31
	andc 9,9,0
	and 0,3,0
	or 3,0,9
.L17:
	addi 10,10,976
	bdnz .L18
	blr
.Lfe8:
	.size	 KOTSNumPlayers__Fv,.Lfe8-KOTSNumPlayers__Fv
	.section	".rodata"
	.align 2
.LC58:
	.long 0x0
	.section	".text"
	.align 2
	.globl KOTSTime
	.type	 KOTSTime,@function
KOTSTime:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	bl KOTSGetUser__FP7edict_s
	mr. 30,3
	bc 12,2,.L23
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L23
	lwz 9,84(31)
	lwz 0,3580(9)
	cmpwi 0,0,0
	bc 12,2,.L23
	lwz 0,3576(9)
	cmpwi 0,0,0
	bc 4,2,.L23
	lwz 0,724(9)
	cmpwi 0,0,0
	bc 4,1,.L23
	lis 11,.LC58@ha
	lis 9,level+200@ha
	la 11,.LC58@l(11)
	lfs 0,level+200@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L23
	addi 3,1,8
	bl time
	lwz 9,84(31)
	lwz 9,3588(9)
	cmpwi 0,9,0
	bc 4,1,.L30
	lwz 0,8(1)
	cmpw 0,9,0
	bc 4,0,.L23
.L30:
	lwz 9,224(30)
	addi 9,9,20
	stw 9,224(30)
	lwz 11,8(1)
	lwz 9,84(31)
	addi 11,11,20
	stw 11,3588(9)
.L23:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 KOTSTime,.Lfe9-KOTSTime
	.align 2
	.globl KOTSEnter
	.type	 KOTSEnter,@function
KOTSEnter:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 29,3
	lis 9,gi@ha
	lwz 0,gi@l(9)
	lis 4,.LC5@ha
	li 3,2
	lwz 5,84(29)
	la 4,.LC5@l(4)
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	lis 11,kots_lives@ha
	li 0,0
	lwz 10,kots_lives@l(11)
	stw 0,912(29)
	stw 0,896(29)
	stw 0,892(29)
	stw 0,924(29)
	stw 0,916(29)
	stw 0,920(29)
	stw 0,908(29)
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	stw 9,928(29)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe10:
	.size	 KOTSEnter,.Lfe10-KOTSEnter
	.align 2
	.globl KOTSGetUser__FP7edict_s
	.type	 KOTSGetUser__FP7edict_s,@function
KOTSGetUser__FP7edict_s:
	mr. 3,3
	bc 4,2,.L33
.L145:
	li 3,0
	blr
.L33:
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L145
	lwz 0,1812(3)
	srawi 9,0,31
	xor 3,9,0
	subf 3,3,9
	srawi 3,3,31
	and 3,0,3
	blr
.Lfe11:
	.size	 KOTSGetUser__FP7edict_s,.Lfe11-KOTSGetUser__FP7edict_s
	.align 2
	.globl KOTSGetClientData
	.type	 KOTSGetClientData,@function
KOTSGetClientData:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 30,4
	lis 29,.LC6@ha
	la 4,.LC6@l(29)
	mr 3,30
	bl Info_ValueForKey
	mr 31,3
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L37
	lis 4,.LC7@ha
	lis 5,.LC8@ha
	mr 3,30
	la 4,.LC7@l(4)
	la 5,.LC8@l(5)
	bl Info_SetValueForKey
	li 3,0
	b .L146
.L37:
	mr 3,31
	bl strlen
	cmplwi 0,3,15
	bc 4,1,.L38
	li 4,0
	li 5,16
	addi 3,1,8
	bl memset
	lwz 8,0(31)
	addi 9,1,8
	mr 3,30
	lwz 0,8(31)
	la 4,.LC6@l(29)
	mr 5,9
	lwz 10,4(31)
	lhz 11,12(31)
	stw 8,8(1)
	stw 10,4(9)
	stw 0,8(9)
	sth 11,12(9)
	lbz 0,14(31)
	stb 0,14(9)
	bl Info_SetValueForKey
	la 4,.LC6@l(29)
	mr 3,30
	bl Info_ValueForKey
.L38:
	lis 4,.LC9@ha
	mr 3,30
	la 4,.LC9@l(4)
	bl Info_ValueForKey
	li 3,1
.L146:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe12:
	.size	 KOTSGetClientData,.Lfe12-KOTSGetClientData
	.align 2
	.globl KOTSEnd
	.type	 KOTSEnd,@function
KOTSEnd:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 3,theApp@ha
	la 3,theApp@l(3)
	bl Cleanup__8CKotsApp
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe13:
	.size	 KOTSEnd,.Lfe13-KOTSEnd
	.align 2
	.globl KOTSLeave
	.type	 KOTSLeave,@function
KOTSLeave:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr. 31,3
	li 9,0
	bc 12,2,.L67
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 4,2,.L68
	li 9,0
	b .L67
.L68:
	lwz 9,1812(9)
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	and 9,9,0
.L67:
	cmpwi 0,9,0
	bc 4,2,.L70
	lis 9,gi+8@ha
	lis 5,.LC22@ha
	lwz 0,gi+8@l(9)
	li 3,0
	la 5,.LC22@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,1
	b .L147
.L70:
	lwz 0,480(31)
	lis 3,theApp@ha
	mr 4,9
	la 3,theApp@l(3)
	li 5,1
	stw 0,196(9)
	bl DelUser__8CKotsAppP5CUserb
	cmpwi 0,3,0
	bc 4,2,.L71
	lis 9,gi+8@ha
	lis 5,.LC23@ha
	lwz 0,gi+8@l(9)
	la 5,.LC23@l(5)
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L71:
	lwz 9,84(31)
	li 0,0
	li 3,1
	stw 0,1812(9)
.L147:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe14:
	.size	 KOTSLeave,.Lfe14-KOTSLeave
	.section	".rodata"
	.align 3
.LC59:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl KOTSInit
	.type	 KOTSInit,@function
KOTSInit:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr. 30,3
	bc 12,2,.L148
	lwz 9,84(30)
	cmpwi 0,9,0
	bc 4,2,.L76
.L148:
	li 31,0
	b .L75
.L76:
	lwz 9,1812(9)
	srawi 10,9,31
	xor 0,10,9
	subf 0,0,10
	srawi 0,0,31
	and 31,9,0
.L75:
	cmpwi 0,31,0
	bc 12,2,.L73
	mr 3,31
	bl SetMaxAmmo__5CUser
	mr 3,31
	bl SetMaxHealth__5CUser
	lwz 0,196(31)
	cmpwi 0,0,0
	bc 12,1,.L79
	mr 3,31
	bl Respawn__5CUser
.L79:
	mr 3,31
	bl Init__5CUser
	li 0,0
	lis 10,level@ha
	stw 0,196(31)
	lwz 9,level@l(10)
	lis 0,0x4330
	lis 10,.LC59@ha
	addi 9,9,15
	la 10,.LC59@l(10)
	xoris 9,9,0x8000
	lfd 13,0(10)
	stw 9,20(1)
	stw 0,16(1)
	lfd 0,16(1)
	lwz 10,84(30)
	fsub 0,0,13
	frsp 0,0
	stfs 0,3836(10)
.L73:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 KOTSInit,.Lfe15-KOTSInit
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
