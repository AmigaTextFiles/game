	.file	"botchat.c"
gcc2_compiled.:
	.globl ltk_welcomes
	.section	".data"
	.align 2
	.type	 ltk_welcomes,@object
	.size	 ltk_welcomes,52
ltk_welcomes:
	.long .LC0
	.long .LC1
	.long .LC2
	.long .LC3
	.long .LC4
	.long .LC5
	.long .LC6
	.long .LC7
	.long .LC8
	.long .LC9
	.long .LC10
	.long .LC11
	.long .LC12
	.section	".rodata"
	.align 2
.LC12:
	.string	"OK %s, let's get this over with"
	.align 2
.LC11:
	.string	"Nice :-) :-) :-)"
	.align 2
.LC10:
	.string	"Hi %s, I wondered if you'd show your face around here again."
	.align 2
.LC9:
	.string	"Hey, any of you guys played before?"
	.align 2
.LC8:
	.string	"I gotta find a better server..."
	.align 2
.LC7:
	.string	"Hey Mom, they gave me a gun!"
	.align 2
.LC6:
	.string	"Damn! I hoped Thresh would be here..."
	.align 2
.LC5:
	.string	"Give your arse a rest, %s. try talking through your mouth"
	.align 2
.LC4:
	.string	"%s, how do you see where you're going with those b*ll*cks in your eyes?"
	.align 2
.LC3:
	.string	"I say, %s, have you got a license for that face?"
	.align 2
.LC2:
	.string	"%s? Who the hell is that?"
	.align 2
.LC1:
	.string	"Hello %s! Prepare to die!!"
	.align 2
.LC0:
	.string	"Greetings all!"
	.globl ltk_killeds
	.section	".data"
	.align 2
	.type	 ltk_killeds,@object
	.size	 ltk_killeds,52
ltk_killeds:
	.long .LC13
	.long .LC14
	.long .LC15
	.long .LC16
	.long .LC17
	.long .LC18
	.long .LC19
	.long .LC20
	.long .LC21
	.long .LC22
	.long .LC23
	.long .LC24
	.long .LC25
	.section	".rodata"
	.align 2
.LC25:
	.string	"One feels like chicken tonight...."
	.align 2
.LC24:
	.string	"laaaaaaaaaaaaaaag!"
	.align 2
.LC23:
	.string	"Oh - now I know how strawberry jam feels..."
	.align 2
.LC22:
	.string	"Hey, I was tying my shoelace!"
	.align 2
.LC21:
	.string	"It's clobberin' time, %s"
	.align 2
.LC20:
	.string	"Aw, %s doesn't like me..."
	.align 2
.LC19:
	.string	"Was %s talking to me, or chewing a brick?"
	.align 2
.LC18:
	.string	"Hey, %s, how about a match - your face and my arse!"
	.align 2
.LC17:
	.string	"%s's mother cooks socks in hell!"
	.align 2
.LC16:
	.string	"Ooooh, %s, that smarts!"
	.align 2
.LC15:
	.string	"Hey! Go easy on me! I'm a newbie!"
	.align 2
.LC14:
	.string	"All right, %s. Now I'm feeling put out!"
	.align 2
.LC13:
	.string	"B*stard! %s messed up my hair."
	.globl ltk_insults
	.section	".data"
	.align 2
	.type	 ltk_insults,@object
	.size	 ltk_insults,64
ltk_insults:
	.long .LC26
	.long .LC27
	.long .LC28
	.long .LC29
	.long .LC30
	.long .LC31
	.long .LC32
	.long .LC33
	.long .LC34
	.long .LC35
	.long .LC36
	.long .LC37
	.long .LC38
	.long .LC39
	.long .LC40
	.long .LC41
	.section	".rodata"
	.align 2
.LC41:
	.string	"Ooooooh - I'm sooooo scared %s"
	.align 2
.LC40:
	.string	"Errm, %s, have you ever thought of taking up croquet instead?"
	.align 2
.LC39:
	.string	"Oh - good play %s ... hehehe"
	.align 2
.LC38:
	.string	"Hey everyone, %s was better than the Pirates of Penzance"
	.align 2
.LC37:
	.string	"Mmmmm... %s chunks!"
	.align 2
.LC36:
	.string	"Yuck! I've got some %s on my shoe!"
	.align 2
.LC35:
	.string	"Oh %s, ever thought of taking up croquet instead?"
	.align 2
.LC34:
	.string	"Hey, %s, one guy wins, the other prick loses..."
	.align 2
.LC33:
	.string	"%s, does your mother know you're out?"
	.align 2
.LC32:
	.string	"You couldn't organise a p*ss-up in a brewery, %s"
	.align 2
.LC31:
	.string	"Get used to disappointment, %s"
	.align 2
.LC30:
	.string	"Unlike certain other bots, %s, I can kill with an English accent.."
	.align 2
.LC29:
	.string	"I'm sorry, %s, did I break your concentration?"
	.align 2
.LC28:
	.string	"Hahaha! Hook, Line and Sinker, %s!"
	.align 2
.LC27:
	.string	"%s; Eat my dust!"
	.align 2
.LC26:
	.string	"Hey, %s. Your mother was a hamster...!"
	.align 2
.LC42:
	.string	"LTK_Chat: Unknown speech type attempted!(out of range)"
	.align 2
.LC43:
	.string	"%s: "
	.align 2
.LC44:
	.string	"\n"
	.align 2
.LC45:
	.string	"%s"
	.align 2
.LC46:
	.string	"bot"
	.align 2
.LC47:
	.long 0x0
	.section	".text"
	.align 2
	.globl LTK_Say
	.type	 LTK_Say,@function
LTK_Say:
	stwu 1,-2096(1)
	mflr 0
	stmw 24,2064(1)
	stw 0,2100(1)
	lwz 6,84(3)
	mr 31,4
	lis 5,.LC43@ha
	la 5,.LC43@l(5)
	addi 3,1,8
	addi 6,6,700
	li 4,2048
	crxor 6,6,6
	bl Com_sprintf
	lbz 0,0(31)
	cmpwi 0,0,34
	bc 4,2,.L17
	addi 31,31,1
	mr 3,31
	bl strlen
	add 3,3,31
	li 0,0
	stb 0,-1(3)
.L17:
	mr 4,31
	addi 3,1,8
	bl strcat
	addi 3,1,8
	bl strlen
	cmplwi 0,3,200
	bc 4,1,.L18
	li 0,0
	stb 0,208(1)
.L18:
	lis 4,.LC44@ha
	addi 3,1,8
	la 4,.LC44@l(4)
	bl strcat
	lis 9,.LC47@ha
	lis 11,dedicated@ha
	la 9,.LC47@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L19
	lis 9,gi+8@ha
	lis 5,.LC45@ha
	lwz 0,gi+8@l(9)
	la 5,.LC45@l(5)
	li 3,0
	li 4,3
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L19:
	lis 9,game@ha
	li 30,1
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,30,0
	bc 12,1,.L21
	lis 9,gi@ha
	mr 24,11
	la 25,gi@l(9)
	lis 26,g_edicts@ha
	lis 27,.LC46@ha
	lis 28,.LC45@ha
	li 29,996
.L23:
	lwz 0,g_edicts@l(26)
	add 31,0,29
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L22
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L22
	lwz 3,280(31)
	la 4,.LC46@l(27)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L22
	lwz 9,8(25)
	mr 3,31
	li 4,3
	la 5,.LC45@l(28)
	addi 6,1,8
	mtlr 9
	crxor 6,6,6
	blrl
.L22:
	lwz 0,1544(24)
	addi 30,30,1
	addi 29,29,996
	cmpw 0,30,0
	bc 4,1,.L23
.L21:
	lwz 0,2100(1)
	mtlr 0
	lmw 24,2064(1)
	la 1,2096(1)
	blr
.Lfe1:
	.size	 LTK_Say,.Lfe1-LTK_Say
	.align 2
	.globl LTK_Chat
	.type	 LTK_Chat,@function
LTK_Chat:
	stwu 1,-192(1)
	mflr 0
	stmw 29,180(1)
	stw 0,196(1)
	mr. 31,4
	mr 30,3
	bc 12,2,.L6
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L6
	cmpwi 0,5,0
	bc 4,2,.L9
	lis 29,ltk_welcomes@ha
	la 29,ltk_welcomes@l(29)
	bl rand
	lis 0,0x4ec4
	srawi 9,3,31
	ori 0,0,60495
	mulhw 0,3,0
	srawi 0,0,2
	subf 0,9,0
	mulli 0,0,13
	b .L28
.L9:
	cmpwi 0,5,1
	bc 4,2,.L11
	lis 29,ltk_killeds@ha
	la 29,ltk_killeds@l(29)
	bl rand
	lis 0,0x4ec4
	srawi 9,3,31
	ori 0,0,60495
	mulhw 0,3,0
	srawi 0,0,2
	subf 0,9,0
	mulli 0,0,13
	b .L28
.L11:
	lis 29,ltk_insults@ha
	la 29,ltk_insults@l(29)
	bl rand
	srawi 0,3,31
	srwi 0,0,28
	add 0,3,0
	rlwinm 0,0,0,0,27
.L28:
	subf 3,0,3
	slwi 3,3,2
	lwzx 4,29,3
	lwz 5,84(31)
	addi 3,1,8
	addi 5,5,700
	crxor 6,6,6
	bl sprintf
	mr 3,30
	addi 4,1,8
	bl LTK_Say
.L6:
	lwz 0,196(1)
	mtlr 0
	lmw 29,180(1)
	la 1,192(1)
	blr
.Lfe2:
	.size	 LTK_Chat,.Lfe2-LTK_Chat
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
