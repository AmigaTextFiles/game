	.file	"p_client.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"info_player_start"
	.align 2
.LC1:
	.string	"security"
	.align 2
.LC2:
	.string	"info_player_coop"
	.align 2
.LC3:
	.string	"jail3"
	.align 2
.LC5:
	.string	"jail2"
	.align 2
.LC6:
	.string	"jail4"
	.align 2
.LC7:
	.string	"mine1"
	.align 2
.LC8:
	.string	"mine2"
	.align 2
.LC9:
	.string	"mine3"
	.align 2
.LC10:
	.string	"mine4"
	.align 2
.LC11:
	.string	"lab"
	.align 2
.LC12:
	.string	"boss1"
	.align 2
.LC13:
	.string	"fact3"
	.align 2
.LC14:
	.string	"biggun"
	.align 2
.LC15:
	.string	"space"
	.align 2
.LC16:
	.string	"command"
	.align 2
.LC17:
	.string	"power2"
	.align 2
.LC18:
	.string	"strike"
	.align 3
.LC19:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC20:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_player_coop
	.type	 SP_info_player_coop,@function
SP_info_player_coop:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 11,.LC20@ha
	lis 9,coop@ha
	la 11,.LC20@l(11)
	mr 30,3
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L30
	bl G_FreeEdict
	b .L29
.L30:
	lis 31,level+72@ha
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	la 3,level+72@l(31)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L32
	lis 4,.LC6@ha
	la 3,level+72@l(31)
	la 4,.LC6@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L32
	lis 4,.LC7@ha
	la 3,level+72@l(31)
	la 4,.LC7@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L32
	lis 4,.LC8@ha
	la 3,level+72@l(31)
	la 4,.LC8@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L32
	lis 4,.LC9@ha
	la 3,level+72@l(31)
	la 4,.LC9@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L32
	lis 4,.LC10@ha
	la 3,level+72@l(31)
	la 4,.LC10@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L32
	lis 4,.LC11@ha
	la 3,level+72@l(31)
	la 4,.LC11@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L32
	lis 4,.LC12@ha
	la 3,level+72@l(31)
	la 4,.LC12@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L32
	lis 4,.LC13@ha
	la 3,level+72@l(31)
	la 4,.LC13@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L32
	lis 4,.LC14@ha
	la 3,level+72@l(31)
	la 4,.LC14@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L32
	lis 4,.LC15@ha
	la 3,level+72@l(31)
	la 4,.LC15@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L32
	lis 4,.LC16@ha
	la 3,level+72@l(31)
	la 4,.LC16@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L32
	lis 4,.LC17@ha
	la 3,level+72@l(31)
	la 4,.LC17@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L32
	lis 4,.LC18@ha
	la 3,level+72@l(31)
	la 4,.LC18@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L29
.L32:
	lis 9,SP_FixCoopSpots@ha
	lis 10,level+4@ha
	la 9,SP_FixCoopSpots@l(9)
	lis 11,.LC19@ha
	stw 9,680(30)
	lfs 0,level+4@l(10)
	lfd 13,.LC19@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(30)
.L29:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe1:
	.size	 SP_info_player_coop,.Lfe1-SP_info_player_coop
	.section	".rodata"
	.align 2
.LC21:
	.string	"skin"
	.align 2
.LC22:
	.string	"Red Flag"
	.align 2
.LC23:
	.string	"Blue Flag"
	.align 2
.LC24:
	.string	""
	.align 2
.LC25:
	.string	"suicides"
	.align 2
.LC26:
	.string	"cratered"
	.align 2
.LC27:
	.string	"was squished"
	.align 2
.LC28:
	.string	"sank like a rock"
	.align 2
.LC29:
	.string	"melted"
	.align 2
.LC30:
	.string	"does a back flip into the lava"
	.align 2
.LC31:
	.string	"blew up"
	.align 2
.LC32:
	.string	"found a way out"
	.align 2
.LC33:
	.string	"saw the light"
	.align 2
.LC34:
	.string	"got blasted"
	.align 2
.LC35:
	.string	"was in the wrong place"
	.align 2
.LC36:
	.string	"tried to put the pin back in"
	.align 2
.LC37:
	.string	"tripped on her own grenade"
	.align 2
.LC38:
	.string	"tripped on his own grenade"
	.align 2
.LC39:
	.string	"blew herself up"
	.align 2
.LC40:
	.string	"blew himself up"
	.align 2
.LC41:
	.string	"should have used a smaller gun"
	.align 2
.LC42:
	.string	"killed herself"
	.align 2
.LC43:
	.string	"killed himself"
	.align 2
.LC44:
	.string	"%s %s.\n"
	.align 2
.LC45:
	.string	"was blasted by"
	.align 2
.LC46:
	.string	"was cut to pieces by"
	.align 2
.LC47:
	.string	"was too slow to escape"
	.align 2
.LC48:
	.string	"'s axe"
	.align 2
.LC49:
	.string	"decided to die with"
	.align 2
.LC50:
	.string	"was too close to"
	.align 2
.LC51:
	.string	" when he terminated himself"
	.align 2
.LC52:
	.string	"died to"
	.align 2
.LC53:
	.string	"'s gasses"
	.align 2
.LC54:
	.string	"was gunned down by"
	.align 2
.LC55:
	.string	"was put to ground by"
	.align 2
.LC56:
	.string	"was eaten by"
	.align 2
.LC57:
	.string	"'s fishes"
	.align 2
.LC58:
	.string	"was blown to pieces by"
	.align 2
.LC59:
	.string	"'s detpack"
	.align 2
.LC60:
	.string	"was burned to death by"
	.align 2
.LC61:
	.string	"'s napalm grenade"
	.align 2
.LC62:
	.string	"was blown away by"
	.align 2
.LC63:
	.string	"'s super shotgun"
	.align 2
.LC64:
	.string	"eats too many bullets from"
	.align 2
.LC65:
	.string	"'s machinegun"
	.align 2
.LC66:
	.string	"was cut in half by"
	.align 2
.LC67:
	.string	"'s chaingun"
	.align 2
.LC68:
	.string	"was popped by"
	.align 2
.LC69:
	.string	"'s grenade"
	.align 2
.LC70:
	.string	"was shredded by"
	.align 2
.LC71:
	.string	"'s shrapnel"
	.align 2
.LC72:
	.string	"ate"
	.align 2
.LC73:
	.string	"'s rocket"
	.align 2
.LC74:
	.string	"feels"
	.align 2
.LC75:
	.string	"almost dodged"
	.align 2
.LC76:
	.string	"was melted by"
	.align 2
.LC77:
	.string	"'s hyperblaster"
	.align 2
.LC78:
	.string	"was railed by"
	.align 2
.LC79:
	.string	"saw the pretty lights from"
	.align 2
.LC80:
	.string	"'s BFG"
	.align 2
.LC81:
	.string	"was disintegrated by"
	.align 2
.LC82:
	.string	"'s BFG blast"
	.align 2
.LC83:
	.string	"couldn't hide from"
	.align 2
.LC84:
	.string	"caught"
	.align 2
.LC85:
	.string	"'s handgrenade"
	.align 2
.LC86:
	.string	"didn't see"
	.align 2
.LC87:
	.string	"'s pain"
	.align 2
.LC88:
	.string	"tried to invade"
	.align 2
.LC89:
	.string	"'s personal space"
	.align 2
.LC90:
	.string	"checks his glasses after killing teammate"
	.align 2
.LC91:
	.string	"needs better glasses after killing teammate"
	.align 2
.LC92:
	.string	"%s %s %s\n"
	.align 2
.LC93:
	.string	"%s %s %s%s\n"
	.align 2
.LC94:
	.string	"%s died.\n"
	.align 2
.LC95:
	.string	"%s decided to be dead instead of alive.\n"
	.align 2
.LC96:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientObituary
	.type	 ClientObituary,@function
ClientObituary:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,.LC96@ha
	lis 9,coop@ha
	la 11,.LC96@l(11)
	mr 29,3
	lfs 13,0(11)
	mr 30,5
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L44
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L44
	lis 9,meansOfDeath@ha
	lwz 0,meansOfDeath@l(9)
	oris 0,0,0x800
	stw 0,meansOfDeath@l(9)
.L44:
	lis 11,.LC96@ha
	lis 9,deathmatch@ha
	la 11,.LC96@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L46
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L45
.L46:
	lis 9,meansOfDeath@ha
	lis 11,.LC24@ha
	lwz 0,meansOfDeath@l(9)
	la 31,.LC24@l(11)
	li 6,0
	rlwinm 28,0,0,5,3
	addi 10,28,-17
	cmplwi 0,10,16
	bc 12,1,.L47
	lis 11,.L62@ha
	slwi 10,10,2
	la 11,.L62@l(11)
	lis 9,.L62@ha
	lwzx 0,10,11
	la 9,.L62@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L62:
	.long .L51-.L62
	.long .L52-.L62
	.long .L53-.L62
	.long .L50-.L62
	.long .L47-.L62
	.long .L49-.L62
	.long .L48-.L62
	.long .L47-.L62
	.long .L55-.L62
	.long .L55-.L62
	.long .L61-.L62
	.long .L56-.L62
	.long .L61-.L62
	.long .L57-.L62
	.long .L61-.L62
	.long .L47-.L62
	.long .L58-.L62
.L48:
	lis 9,.LC25@ha
	la 6,.LC25@l(9)
	b .L47
.L49:
	lis 9,.LC26@ha
	la 6,.LC26@l(9)
	b .L47
.L50:
	lis 9,.LC27@ha
	la 6,.LC27@l(9)
	b .L47
.L51:
	lis 9,.LC28@ha
	la 6,.LC28@l(9)
	b .L47
.L52:
	lis 9,.LC29@ha
	la 6,.LC29@l(9)
	b .L47
.L53:
	lis 9,.LC30@ha
	la 6,.LC30@l(9)
	b .L47
.L55:
	lis 9,.LC31@ha
	la 6,.LC31@l(9)
	b .L47
.L56:
	lis 9,.LC32@ha
	la 6,.LC32@l(9)
	b .L47
.L57:
	lis 9,.LC33@ha
	la 6,.LC33@l(9)
	b .L47
.L58:
	lis 9,.LC34@ha
	la 6,.LC34@l(9)
	b .L47
.L61:
	lis 9,.LC35@ha
	la 6,.LC35@l(9)
.L47:
	cmpw 0,30,29
	bc 4,2,.L64
	addi 10,28,-7
	cmplwi 0,10,17
	bc 12,1,.L81
	lis 11,.L87@ha
	slwi 10,10,2
	la 11,.L87@l(11)
	lis 9,.L87@ha
	lwzx 0,10,11
	la 9,.L87@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L87:
	.long .L68-.L87
	.long .L81-.L87
	.long .L74-.L87
	.long .L81-.L87
	.long .L81-.L87
	.long .L81-.L87
	.long .L80-.L87
	.long .L81-.L87
	.long .L81-.L87
	.long .L68-.L87
	.long .L81-.L87
	.long .L81-.L87
	.long .L81-.L87
	.long .L81-.L87
	.long .L81-.L87
	.long .L81-.L87
	.long .L81-.L87
	.long .L66-.L87
.L66:
	lis 9,.LC36@ha
	la 6,.LC36@l(9)
	b .L64
.L68:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L70
	li 0,0
	b .L71
.L70:
	lis 4,.LC21@ha
	addi 3,3,188
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 11,9,0
	adde 9,11,9
	xori 0,0,102
	subfic 11,0,0
	adde 0,11,0
	or 0,0,9
.L71:
	cmpwi 0,0,0
	bc 12,2,.L69
	lis 9,.LC37@ha
	la 6,.LC37@l(9)
	b .L64
.L69:
	lis 9,.LC38@ha
	la 6,.LC38@l(9)
	b .L64
.L74:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L76
	li 0,0
	b .L77
.L76:
	lis 4,.LC21@ha
	addi 3,3,188
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 11,9,0
	adde 9,11,9
	xori 0,0,102
	subfic 11,0,0
	adde 0,11,0
	or 0,0,9
.L77:
	cmpwi 0,0,0
	bc 12,2,.L75
	lis 9,.LC39@ha
	la 6,.LC39@l(9)
	b .L64
.L75:
	lis 9,.LC40@ha
	la 6,.LC40@l(9)
	b .L64
.L80:
	lis 9,.LC41@ha
	la 6,.LC41@l(9)
	b .L64
.L81:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L83
	li 0,0
	b .L84
.L83:
	lis 4,.LC21@ha
	addi 3,3,188
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 11,9,0
	adde 9,11,9
	xori 0,0,102
	subfic 11,0,0
	adde 0,11,0
	or 0,0,9
.L84:
	cmpwi 0,0,0
	bc 12,2,.L82
	lis 9,.LC42@ha
	la 6,.LC42@l(9)
	b .L64
.L82:
	lis 9,.LC43@ha
	la 6,.LC43@l(9)
.L64:
	cmpwi 0,6,0
	bc 12,2,.L88
	lis 9,gi@ha
	lwz 5,84(29)
	lis 4,.LC44@ha
	lwz 0,gi@l(9)
	la 4,.LC44@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,.LC96@ha
	lis 11,deathmatch@ha
	la 9,.LC96@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L89
	lwz 11,84(29)
	lwz 9,3560(11)
	addi 9,9,-1
	stw 9,3560(11)
.L89:
	li 0,0
	stw 0,816(29)
	b .L43
.L88:
	cmpwi 0,30,0
	stw 30,816(29)
	bc 12,2,.L45
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L45
	addi 0,28,-1
	cmplwi 0,0,42
	bc 12,1,.L91
	lis 11,.L123@ha
	slwi 10,0,2
	la 11,.L123@l(11)
	lis 9,.L123@ha
	lwzx 0,10,11
	la 9,.L123@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L123:
	.long .L92-.L123
	.long .L100-.L123
	.long .L105-.L123
	.long .L106-.L123
	.long .L107-.L123
	.long .L108-.L123
	.long .L109-.L123
	.long .L110-.L123
	.long .L113-.L123
	.long .L114-.L123
	.long .L115-.L123
	.long .L116-.L123
	.long .L117-.L123
	.long .L118-.L123
	.long .L119-.L123
	.long .L120-.L123
	.long .L91-.L123
	.long .L91-.L123
	.long .L91-.L123
	.long .L91-.L123
	.long .L122-.L123
	.long .L91-.L123
	.long .L91-.L123
	.long .L121-.L123
	.long .L91-.L123
	.long .L91-.L123
	.long .L91-.L123
	.long .L91-.L123
	.long .L91-.L123
	.long .L91-.L123
	.long .L91-.L123
	.long .L91-.L123
	.long .L91-.L123
	.long .L93-.L123
	.long .L91-.L123
	.long .L101-.L123
	.long .L96-.L123
	.long .L102-.L123
	.long .L91-.L123
	.long .L91-.L123
	.long .L99-.L123
	.long .L103-.L123
	.long .L104-.L123
.L92:
	lis 9,.LC45@ha
	la 6,.LC45@l(9)
	b .L91
.L93:
	bl rand
	andi. 0,3,1
	bc 12,2,.L94
	lis 9,.LC46@ha
	la 6,.LC46@l(9)
	b .L91
.L94:
	lis 9,.LC47@ha
	lis 11,.LC48@ha
	la 6,.LC47@l(9)
	la 31,.LC48@l(11)
	b .L91
.L96:
	bl rand
	andi. 0,3,1
	bc 12,2,.L97
	lis 9,.LC49@ha
	la 6,.LC49@l(9)
	b .L91
.L97:
	lis 9,.LC50@ha
	lis 11,.LC51@ha
	la 6,.LC50@l(9)
	la 31,.LC51@l(11)
	b .L91
.L99:
	lis 9,.LC52@ha
	lis 11,.LC53@ha
	la 6,.LC52@l(9)
	la 31,.LC53@l(11)
	b .L91
.L100:
	lis 9,.LC54@ha
	la 6,.LC54@l(9)
	b .L91
.L101:
	lis 9,.LC55@ha
	la 6,.LC55@l(9)
	b .L91
.L102:
	lis 9,.LC56@ha
	lis 11,.LC57@ha
	la 6,.LC56@l(9)
	la 31,.LC57@l(11)
	b .L91
.L103:
	lis 9,.LC58@ha
	lis 11,.LC59@ha
	la 6,.LC58@l(9)
	la 31,.LC59@l(11)
	b .L91
.L104:
	lis 9,.LC60@ha
	lis 11,.LC61@ha
	la 6,.LC60@l(9)
	la 31,.LC61@l(11)
	b .L91
.L105:
	lis 9,.LC62@ha
	lis 11,.LC63@ha
	la 6,.LC62@l(9)
	la 31,.LC63@l(11)
	b .L91
.L106:
	lis 9,.LC64@ha
	lis 11,.LC65@ha
	la 6,.LC64@l(9)
	la 31,.LC65@l(11)
	b .L91
.L107:
	lis 9,.LC66@ha
	lis 11,.LC67@ha
	la 6,.LC66@l(9)
	la 31,.LC67@l(11)
	b .L91
.L108:
	lis 9,.LC68@ha
	lis 11,.LC69@ha
	la 6,.LC68@l(9)
	la 31,.LC69@l(11)
	b .L91
.L109:
	lis 9,.LC70@ha
	lis 11,.LC71@ha
	la 6,.LC70@l(9)
	la 31,.LC71@l(11)
	b .L91
.L110:
	bl rand
	andi. 0,3,1
	bc 12,2,.L111
	lis 9,.LC72@ha
	lis 11,.LC73@ha
	la 6,.LC72@l(9)
	la 31,.LC73@l(11)
	b .L91
.L111:
	lis 9,.LC74@ha
	lis 11,.LC73@ha
	la 6,.LC74@l(9)
	la 31,.LC73@l(11)
	b .L91
.L113:
	lis 9,.LC75@ha
	lis 11,.LC73@ha
	la 6,.LC75@l(9)
	la 31,.LC73@l(11)
	b .L91
.L114:
	lis 9,.LC76@ha
	lis 11,.LC77@ha
	la 6,.LC76@l(9)
	la 31,.LC77@l(11)
	b .L91
.L115:
	lis 9,.LC78@ha
	la 6,.LC78@l(9)
	b .L91
.L116:
	lis 9,.LC79@ha
	lis 11,.LC80@ha
	la 6,.LC79@l(9)
	la 31,.LC80@l(11)
	b .L91
.L117:
	lis 9,.LC81@ha
	lis 11,.LC82@ha
	la 6,.LC81@l(9)
	la 31,.LC82@l(11)
	b .L91
.L118:
	lis 9,.LC83@ha
	lis 11,.LC80@ha
	la 6,.LC83@l(9)
	la 31,.LC80@l(11)
	b .L91
.L119:
	lis 9,.LC84@ha
	lis 11,.LC85@ha
	la 6,.LC84@l(9)
	la 31,.LC85@l(11)
	b .L91
.L120:
	lis 9,.LC86@ha
	lis 11,.LC85@ha
	la 6,.LC86@l(9)
	la 31,.LC85@l(11)
	b .L91
.L121:
	lis 9,.LC74@ha
	lis 11,.LC87@ha
	la 6,.LC74@l(9)
	la 31,.LC87@l(11)
	b .L91
.L122:
	lis 9,.LC88@ha
	lis 11,.LC89@ha
	la 6,.LC88@l(9)
	la 31,.LC89@l(11)
.L91:
	cmpwi 0,6,0
	bc 12,2,.L45
	lwz 9,908(29)
	lwz 0,908(30)
	cmpw 0,9,0
	bc 4,2,.L126
	bl rand
	andi. 0,3,1
	bc 12,2,.L127
	lis 9,.LC90@ha
	la 6,.LC90@l(9)
	b .L128
.L127:
	lis 9,.LC91@ha
	la 6,.LC91@l(9)
.L128:
	lis 9,gi@ha
	lwz 7,84(29)
	lis 4,.LC92@ha
	lwz 0,gi@l(9)
	la 4,.LC92@l(4)
	li 3,1
	lwz 5,84(30)
	addi 7,7,700
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	lwz 11,84(30)
	b .L136
.L126:
	lwz 9,84(30)
	lwz 11,3560(9)
	addi 11,11,1
	stw 11,3560(9)
	lwz 0,908(30)
	cmpwi 0,0,2
	bc 4,2,.L130
	lis 11,level@ha
	la 11,level@l(11)
	lwz 9,308(11)
	addi 9,9,1
	stw 9,308(11)
.L130:
	lwz 0,908(30)
	cmpwi 0,0,3
	bc 4,2,.L131
	lis 11,level@ha
	la 11,level@l(11)
	lwz 9,312(11)
	addi 9,9,1
	stw 9,312(11)
.L131:
	lwz 0,908(30)
	cmpwi 0,0,1
	bc 4,2,.L132
	lis 11,level@ha
	la 11,level@l(11)
	lwz 9,304(11)
	addi 9,9,1
	stw 9,304(11)
.L132:
	lis 9,gi@ha
	lwz 5,84(29)
	lis 4,.LC93@ha
	lwz 7,84(30)
	la 4,.LC93@l(4)
	mr 8,31
	lwz 0,gi@l(9)
	addi 5,5,700
	li 3,1
	addi 7,7,700
	mtlr 0
	crxor 6,6,6
	blrl
	b .L43
.L45:
	bl rand
	andi. 0,3,1
	bc 12,2,.L133
	lis 9,gi@ha
	lwz 5,84(29)
	lis 4,.LC94@ha
	lwz 0,gi@l(9)
	la 4,.LC94@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	b .L134
.L133:
	lis 9,gi@ha
	lwz 5,84(29)
	lis 4,.LC95@ha
	lwz 0,gi@l(9)
	la 4,.LC95@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L134:
	lis 9,.LC96@ha
	lis 11,deathmatch@ha
	la 9,.LC96@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L43
	lwz 11,84(29)
.L136:
	lwz 9,3560(11)
	addi 9,9,-1
	stw 9,3560(11)
.L43:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 ClientObituary,.Lfe2-ClientObituary
	.section	".rodata"
	.align 2
.LC97:
	.string	"Blaster"
	.align 2
.LC98:
	.string	"item_quad"
	.align 3
.LC99:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC100:
	.long 0x0
	.align 3
.LC101:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC102:
	.long 0x41b40000
	.section	".text"
	.align 2
	.globl TossClientWeapon
	.type	 TossClientWeapon,@function
TossClientWeapon:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	lis 9,deathmatch@ha
	lis 10,.LC100@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC100@l(10)
	mr 30,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L137
	lwz 9,84(30)
	lwz 11,3628(9)
	addi 10,9,748
	lwz 31,1848(9)
	slwi 11,11,2
	lwzx 9,10,11
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	and. 31,31,0
	bc 12,2,.L140
	lwz 3,40(31)
	lis 4,.LC97@ha
	la 4,.LC97@l(4)
	bl strcmp
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	and 31,31,0
.L140:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,16384
	bc 4,2,.L141
	li 29,0
	b .L142
.L141:
	lis 10,level@ha
	lwz 8,84(30)
	lwz 9,level@l(10)
	lis 0,0x4330
	lis 10,.LC101@ha
	lfs 12,3876(8)
	addi 9,9,10
	la 10,.LC101@l(10)
	xoris 9,9,0x8000
	lfd 13,0(10)
	stw 9,20(1)
	stw 0,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 7,12,0
	mfcr 29
	rlwinm 29,29,30,1
.L142:
	addic 11,31,-1
	subfe 0,11,31
	lis 9,.LC100@ha
	and. 10,0,29
	la 9,.LC100@l(9)
	lfs 31,0(9)
	bc 12,2,.L143
	lis 11,.LC102@ha
	la 11,.LC102@l(11)
	lfs 31,0(11)
.L143:
	cmpwi 0,31,0
	bc 12,2,.L145
	lwz 9,84(30)
	mr 4,31
	mr 3,30
	lfs 0,3756(9)
	fsubs 0,0,31
	stfs 0,3756(9)
	bl Drop_Item
	lwz 9,84(30)
	lis 0,0x2
	lfs 0,3756(9)
	fadds 0,0,31
	stfs 0,3756(9)
	stw 0,288(3)
.L145:
	cmpwi 0,29,0
	bc 12,2,.L137
	lwz 9,84(30)
	lis 3,.LC98@ha
	la 3,.LC98@l(3)
	lfs 0,3756(9)
	fadds 0,0,31
	stfs 0,3756(9)
	bl FindItemByClassname
	mr 4,3
	mr 3,30
	bl Drop_Item
	lwz 7,84(30)
	lis 9,.LC101@ha
	lis 11,Touch_Item@ha
	la 9,.LC101@l(9)
	la 11,Touch_Item@l(11)
	lfs 0,3756(7)
	lis 6,level@ha
	lfd 10,0(9)
	lis 4,0x4330
	la 5,level@l(6)
	lis 9,.LC99@ha
	lis 10,G_FreeEdict@ha
	fsubs 0,0,31
	lfd 11,.LC99@l(9)
	la 10,G_FreeEdict@l(10)
	stfs 0,3756(7)
	lwz 0,288(3)
	stw 11,688(3)
	oris 0,0,0x2
	stw 0,288(3)
	lwz 9,level@l(6)
	lwz 11,84(30)
	xoris 9,9,0x8000
	lfs 12,4(5)
	stw 9,20(1)
	stw 4,16(1)
	lfd 13,16(1)
	lfs 0,3876(11)
	stw 10,680(3)
	fsub 13,13,10
	frsp 13,13
	fsubs 0,0,13
	fmadd 0,0,11,12
	frsp 0,0
	stfs 0,672(3)
.L137:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 TossClientWeapon,.Lfe3-TossClientWeapon
	.section	".rodata"
	.align 2
.LC105:
	.string	"misc/udeath.wav"
	.align 2
.LC106:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.section	".sbss","aw",@nobits
	.align 2
i.51:
	.space	4
	.size	 i.51,4
	.section	".rodata"
	.align 2
.LC107:
	.string	"*death%i.wav"
	.align 3
.LC104:
	.long 0x404ca5dc
	.long 0x1a63c1f8
	.align 3
.LC108:
	.long 0x40100000
	.long 0x0
	.align 2
.LC109:
	.long 0x0
	.align 2
.LC110:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl player_die
	.type	 player_die,@function
player_die:
	stwu 1,-80(1)
	mflr 0
	stmw 25,52(1)
	stw 0,84(1)
	mr 31,3
	mr 28,4
	lwz 3,84(31)
	mr 29,5
	mr 27,6
	li 30,0
	li 26,1
	bl ClearScanner
	lwz 3,84(31)
	crxor 6,6,6
	bl ClearClasses
	lwz 0,268(31)
	mr 3,31
	lwz 9,84(31)
	rlwinm 0,0,0,14,11
	stw 30,564(31)
	stw 0,268(31)
	stw 30,3812(9)
	lwz 0,184(31)
	lwz 11,84(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	stw 30,1812(11)
	lwz 9,84(31)
	stw 30,920(31)
	stw 26,1836(9)
	crxor 6,6,6
	bl Kamikaze_Cancel
	mr 3,31
	crxor 6,6,6
	bl Cmd_DetPipes_f
	lwz 0,1244(31)
	cmpwi 0,0,0
	bc 12,2,.L153
	mr 3,31
	bl SP_LaserSight
.L153:
	li 0,0
	stw 30,732(31)
	lis 11,level+4@ha
	stw 0,640(31)
	li 10,7
	stw 0,636(31)
	lis 7,0xc100
	stw 0,632(31)
	lfs 0,level+4@l(11)
	lwz 8,84(31)
	stw 26,788(31)
	stw 10,264(31)
	fctiwz 13,0
	stfd 13,40(1)
	lwz 9,44(1)
	stw 9,736(31)
	stw 30,3928(8)
	lwz 9,84(31)
	stw 0,24(31)
	stw 0,16(31)
	stw 30,44(31)
	stw 30,76(31)
	stw 30,3904(9)
	lwz 11,908(31)
	lwz 0,184(31)
	cmpwi 0,11,1
	stw 7,208(31)
	ori 0,0,2
	stw 0,184(31)
	bc 4,2,.L154
	lis 9,.LC22@ha
	la 25,.LC22@l(9)
.L154:
	cmpwi 0,11,2
	bc 4,2,.L155
	lis 9,.LC23@ha
	la 25,.LC23@l(9)
.L155:
	cmpwi 0,11,3
	bc 12,2,.L157
	mr 3,25
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,3
	addi 11,11,748
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L157
	lwz 0,12(3)
	mr 4,3
	mr 3,31
	mtlr 0
	blrl
.L157:
	lwz 0,764(31)
	cmpwi 0,0,0
	bc 4,2,.L159
	lis 9,level+4@ha
	lis 11,.LC108@ha
	lfs 0,level+4@l(9)
	la 11,.LC108@l(11)
	cmpwi 0,29,0
	lfd 13,0(11)
	lwz 11,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3912(11)
	bc 12,2,.L160
	lis 9,g_edicts@ha
	xor 11,29,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,29,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L160
	lfs 11,4(31)
	lfs 13,4(29)
	lfs 12,8(29)
	lfs 10,8(31)
	fsubs 13,13,11
	lfs 0,12(29)
	b .L183
.L160:
	cmpwi 0,28,0
	bc 12,2,.L162
	lis 9,g_edicts@ha
	xor 11,28,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,28,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L162
	lfs 11,4(31)
	lfs 13,4(28)
	lfs 12,8(28)
	lfs 10,8(31)
	fsubs 13,13,11
	lfs 0,12(28)
.L183:
	lfs 11,12(31)
	fsubs 12,12,10
	stfs 13,8(1)
	fsubs 0,0,11
	stfs 12,12(1)
	stfs 0,16(1)
	b .L161
.L162:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3680(9)
	b .L164
.L161:
	lfs 1,12(1)
	lfs 2,8(1)
	bl atan2
	lis 9,.LC104@ha
	lwz 11,84(31)
	lfd 0,.LC104@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,3680(11)
.L164:
	lwz 9,84(31)
	li 0,2
	mr 4,28
	mr 5,29
	mr 3,31
	stw 0,0(9)
	bl ClientObituary
	mr 3,31
	bl TossClientWeapon
	lis 9,.LC109@ha
	lis 11,deathmatch@ha
	la 9,.LC109@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L159
	mr 3,31
	bl Cmd_Help_f
.L159:
	lwz 11,84(31)
	li 0,0
	li 4,0
	li 5,1024
	stw 0,3876(11)
	lwz 9,84(31)
	stw 0,3880(9)
	lwz 11,84(31)
	stw 0,3884(11)
	lwz 9,84(31)
	stw 0,3888(9)
	lwz 3,84(31)
	addi 3,3,748
	crxor 6,6,6
	bl memset
	lwz 0,728(31)
	cmpwi 0,0,-40
	bc 4,0,.L166
	lis 29,gi@ha
	lis 3,.LC105@ha
	la 29,gi@l(29)
	la 3,.LC105@l(3)
	lwz 9,36(29)
	lis 28,.LC106@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC110@ha
	lwz 0,16(29)
	lis 11,.LC110@ha
	la 9,.LC110@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC110@l(11)
	li 4,4
	mtlr 0
	lis 9,.LC109@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC109@l(9)
	lfs 3,0(9)
	blrl
.L170:
	mr 3,31
	la 4,.LC106@l(28)
	mr 5,27
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L170
	mr 4,27
	mr 3,31
	bl ThrowClientHead
	stw 30,788(31)
	b .L172
.L166:
	lwz 0,764(31)
	cmpwi 0,0,0
	bc 4,2,.L172
	lis 8,i.51@ha
	lis 9,0x5555
	lwz 6,84(31)
	lwz 10,i.51@l(8)
	ori 9,9,21846
	li 7,5
	addi 10,10,1
	mulhw 9,10,9
	srawi 11,10,31
	subf 9,11,9
	slwi 0,9,1
	add 0,0,9
	subf 10,0,10
	stw 10,i.51@l(8)
	stw 7,3864(6)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L174
	li 0,172
	li 9,177
	b .L184
.L174:
	cmpwi 0,10,1
	bc 12,2,.L178
	bc 12,1,.L182
	cmpwi 0,10,0
	bc 12,2,.L177
	b .L175
.L182:
	cmpwi 0,10,2
	bc 12,2,.L179
	b .L175
.L177:
	li 0,177
	li 9,183
	b .L184
.L178:
	li 0,183
	li 9,189
	b .L184
.L179:
	li 0,189
	li 9,197
.L184:
	stw 0,56(31)
	stw 9,3860(11)
.L175:
	lis 29,gi@ha
	la 29,gi@l(29)
	bl rand
	mr 4,3
	srawi 0,4,31
	lis 3,.LC107@ha
	srwi 0,0,30
	la 3,.LC107@l(3)
	add 0,4,0
	rlwinm 0,0,0,0,29
	subf 4,0,4
	addi 4,4,1
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC110@ha
	lwz 0,16(29)
	lis 11,.LC110@ha
	la 9,.LC110@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC110@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC109@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC109@l(9)
	lfs 3,0(9)
	blrl
.L172:
	li 0,2
	lis 9,gi+72@ha
	stw 0,764(31)
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,84(1)
	mtlr 0
	lmw 25,52(1)
	la 1,80(1)
	blr
.Lfe4:
	.size	 player_die,.Lfe4-player_die
	.section	".rodata"
	.align 2
.LC111:
	.string	"%s was assigned to BLUE team \n"
	.align 2
.LC112:
	.string	"%s was assigned to RED team \n"
	.align 2
.LC113:
	.string	"%s was assigned to CIVILIAN team \n"
	.align 2
.LC114:
	.string	"Shells"
	.align 2
.LC115:
	.string	"Bullets"
	.align 2
.LC116:
	.string	"Slugs"
	.align 2
.LC117:
	.string	"Silencer"
	.align 2
.LC118:
	.string	"Railgun"
	.align 2
.LC119:
	.string	"Shotgun"
	.align 2
.LC120:
	.string	"Grenades"
	.align 2
.LC121:
	.string	"Jacket Armor"
	.align 2
.LC122:
	.string	"Machinegun"
	.align 2
.LC123:
	.string	"Body Armor"
	.align 2
.LC124:
	.string	"Super Shotgun"
	.align 2
.LC125:
	.string	"Rocket Launcher"
	.align 2
.LC126:
	.string	"Rockets"
	.align 2
.LC127:
	.string	"Combat Armor"
	.align 2
.LC128:
	.string	"Grenade Launcher"
	.align 2
.LC129:
	.string	"Chaingun"
	.align 2
.LC130:
	.string	"Cells"
	.align 2
.LC131:
	.string	"HyperBlaster"
	.align 2
.LC132:
	.string	"Power Shield"
	.align 2
.LC133:
	.string	"Sword"
	.align 2
.LC134:
	.string	"Tranquilizer"
	.section	".text"
	.align 2
	.globl InitClientPersistant
	.type	 InitClientPersistant,@function
InitClientPersistant:
	stwu 1,-64(1)
	mflr 0
	stmw 23,28(1)
	stw 0,68(1)
	mr 31,3
	lis 11,dmflags@ha
	lwz 10,1820(31)
	li 0,0
	lwz 8,dmflags@l(11)
	mr 30,4
	stw 0,3812(31)
	stw 0,1832(31)
	stw 0,1836(31)
	stw 10,1804(31)
	lfs 0,20(8)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andis. 0,9,1
	bc 4,2,.L187
	lwz 9,84(30)
	lwz 0,1804(9)
	cmpwi 0,0,0
	bc 4,1,.L187
	lwz 0,908(30)
	cmpwi 0,0,0
	bc 4,2,.L187
	lis 9,level@ha
	la 9,level@l(9)
	lwz 0,316(9)
	cmpwi 0,0,1
	bc 4,2,.L190
	lwz 0,360(9)
	cmpwi 0,0,0
	bc 12,1,.L190
	li 0,3
	stw 0,908(30)
.L190:
	lwz 0,908(30)
	cmpwi 0,0,0
	bc 4,2,.L192
	lis 9,level@ha
	la 9,level@l(9)
	lwz 11,356(9)
	lwz 0,352(9)
	cmpw 0,0,11
	bc 12,0,.L197
	cmpw 0,11,0
	bc 4,0,.L195
	li 0,2
	b .L225
.L195:
	bl rand
	andi. 0,3,1
	li 0,2
	bc 4,2,.L225
.L197:
	li 0,1
.L225:
	stw 0,908(30)
.L192:
	lwz 0,908(30)
	cmpwi 0,0,1
	bc 4,2,.L199
	lis 11,level@ha
	la 11,level@l(11)
	lwz 9,352(11)
	addi 9,9,1
	stw 9,352(11)
.L199:
	lwz 0,908(30)
	cmpwi 0,0,2
	bc 4,2,.L200
	lis 11,level@ha
	la 11,level@l(11)
	lwz 9,356(11)
	addi 9,9,1
	stw 9,356(11)
.L200:
	lwz 0,908(30)
	cmpwi 0,0,3
	bc 4,2,.L201
	lis 11,level@ha
	la 11,level@l(11)
	lwz 9,360(11)
	addi 9,9,1
	stw 9,360(11)
.L201:
	lwz 0,908(30)
	cmpwi 0,0,1
	bc 4,2,.L202
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC111@ha
	lwz 0,gi@l(9)
	la 4,.LC111@l(4)
	li 3,2
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L202:
	lwz 0,908(30)
	cmpwi 0,0,2
	bc 4,2,.L203
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC112@ha
	lwz 0,gi@l(9)
	la 4,.LC112@l(4)
	li 3,2
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L203:
	lwz 0,908(30)
	cmpwi 0,0,3
	bc 4,2,.L224
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC113@ha
	lwz 0,gi@l(9)
	la 4,.LC113@l(4)
	li 3,2
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L187:
	lwz 0,908(30)
	cmpwi 0,0,3
	bc 12,2,.L205
.L224:
	lwz 0,1804(31)
	cmpwi 0,0,0
	bc 4,1,.L205
	lis 3,.LC97@ha
	lis 28,0x38e3
	la 3,.LC97@l(3)
	ori 28,28,36409
	bl FindItem
	addi 27,31,748
	lis 29,itemlist@ha
	lis 9,.LC114@ha
	la 29,itemlist@l(29)
	li 11,1
	subf 0,29,3
	mullw 0,0,28
	la 3,.LC114@l(9)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 11,27,9
	bl FindItem
	subf 3,29,3
	li 11,50
	mullw 3,3,28
	li 9,100
	srawi 3,3,3
	slwi 0,3,2
	stw 3,744(31)
	stwx 11,27,0
	stw 9,736(31)
	stw 9,732(31)
.L205:
	lwz 28,1804(31)
	cmpwi 0,28,0
	bc 4,2,.L207
	li 0,8
	li 29,1
	stw 28,1860(31)
	lis 3,.LC115@ha
	stw 0,1844(31)
	la 3,.LC115@l(3)
	stw 29,1808(31)
	bl FindItem
	stw 3,1848(31)
	li 0,2
	stw 29,732(31)
	stw 28,1792(31)
	stw 28,736(31)
	stw 28,1772(31)
	stw 28,1776(31)
	stw 28,1780(31)
	stw 28,1784(31)
	stw 28,1788(31)
	stw 0,764(30)
.L207:
	lwz 0,1804(31)
	cmpwi 0,0,2
	bc 4,2,.L208
	li 24,4
	lis 3,.LC116@ha
	la 3,.LC116@l(3)
	stw 24,1844(31)
	lis 28,0x38e3
	bl FindItem
	ori 28,28,36409
	addi 27,31,748
	lis 29,itemlist@ha
	lis 9,.LC115@ha
	la 29,itemlist@l(29)
	li 26,60
	subf 0,29,3
	li 25,1
	mullw 0,0,28
	la 3,.LC115@l(9)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 26,27,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC117@ha
	la 3,.LC117@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 26,27,9
	bl FindItem
	subf 0,29,3
	li 11,10
	mullw 0,0,28
	lis 3,.LC118@ha
	la 3,.LC118@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 11,27,9
	bl FindItem
	mr 8,3
	subf 0,29,8
	lis 3,.LC119@ha
	mullw 0,0,28
	la 3,.LC119@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 25,27,9
	stw 8,1848(31)
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC120@ha
	la 3,.LC120@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 25,27,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC121@ha
	la 3,.LC121@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 24,27,9
	bl FindItem
	subf 3,29,3
	li 9,25
	mullw 3,3,28
	li 10,90
	li 8,0
	li 11,100
	srawi 3,3,3
	slwi 0,3,2
	stw 3,744(31)
	stwx 9,27,0
	stw 25,724(31)
	stw 9,728(31)
	stw 10,736(31)
	stw 11,1776(31)
	stw 24,1784(31)
	stw 8,1788(31)
	stw 26,1792(31)
	stw 10,732(31)
	stw 26,1772(31)
	stw 8,1780(31)
.L208:
	lwz 24,1804(31)
	cmpwi 0,24,1
	bc 4,2,.L209
	li 0,10
	lis 3,.LC115@ha
	stw 0,1844(31)
	la 3,.LC115@l(3)
	lis 28,0x38e3
	bl FindItem
	ori 28,28,36409
	addi 27,31,748
	lis 29,itemlist@ha
	li 25,150
	la 29,itemlist@l(29)
	li 11,130
	subf 0,29,3
	li 26,25
	mullw 0,0,28
	lis 3,.LC122@ha
	la 3,.LC122@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 25,27,9
	stw 11,644(30)
	bl FindItem
	mr 8,3
	subf 0,29,8
	lis 3,.LC119@ha
	mullw 0,0,28
	la 3,.LC119@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 24,27,9
	stw 8,1848(31)
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC121@ha
	la 3,.LC121@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 24,27,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC120@ha
	la 3,.LC120@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 26,27,9
	bl FindItem
	subf 3,29,3
	li 8,6
	mullw 3,3,28
	li 9,0
	li 11,75
	li 10,50
	srawi 3,3,3
	slwi 0,3,2
	stw 3,744(31)
	stwx 8,27,0
	stw 24,724(31)
	stw 26,728(31)
	stw 11,736(31)
	stw 25,1772(31)
	stw 10,1776(31)
	stw 8,1784(31)
	stw 9,1792(31)
	stw 11,732(31)
	stw 9,1780(31)
	stw 9,1788(31)
.L209:
	lwz 23,1804(31)
	cmpwi 0,23,3
	bc 4,2,.L210
	li 0,220
	stw 23,1844(31)
	lis 3,.LC120@ha
	stw 0,644(30)
	la 3,.LC120@l(3)
	lis 28,0x38e3
	bl FindItem
	ori 28,28,36409
	addi 27,31,748
	lis 29,itemlist@ha
	lis 9,.LC123@ha
	la 29,itemlist@l(29)
	li 24,6
	subf 0,29,3
	li 25,40
	mullw 0,0,28
	la 3,.LC123@l(9)
	li 26,1
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 24,27,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC124@ha
	la 3,.LC124@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 25,27,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC125@ha
	la 3,.LC125@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 26,27,9
	bl FindItem
	mr 8,3
	subf 0,29,8
	lis 3,.LC126@ha
	mullw 0,0,28
	la 3,.LC126@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 26,27,9
	stw 8,1848(31)
	bl FindItem
	subf 3,29,3
	li 11,50
	mullw 3,3,28
	li 9,0
	li 10,100
	srawi 3,3,3
	slwi 0,3,2
	stw 3,744(31)
	stwx 11,27,0
	stw 23,724(31)
	stw 25,728(31)
	stw 10,736(31)
	stw 11,1780(31)
	stw 24,1784(31)
	stw 9,1792(31)
	stw 10,732(31)
	stw 9,1772(31)
	stw 11,1776(31)
	stw 9,1788(31)
.L210:
	lwz 0,1804(31)
	cmpwi 0,0,4
	bc 4,2,.L211
	li 0,5
	li 9,200
	stw 0,1844(31)
	lis 3,.LC120@ha
	lis 28,0x38e3
	stw 9,644(30)
	la 3,.LC120@l(3)
	ori 28,28,36409
	bl FindItem
	addi 27,31,748
	li 26,50
	lis 29,itemlist@ha
	lis 9,.LC127@ha
	la 29,itemlist@l(29)
	li 24,30
	subf 0,29,3
	li 25,1
	mullw 0,0,28
	la 3,.LC127@l(9)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 26,27,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC124@ha
	la 3,.LC124@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 24,27,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC128@ha
	la 3,.LC128@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 25,27,9
	bl FindItem
	mr 8,3
	li 9,0
	subf 29,29,8
	li 10,90
	mullw 29,29,28
	li 11,2
	srawi 29,29,3
	slwi 0,29,2
	stw 29,744(31)
	stwx 25,27,0
	stw 8,1848(31)
	stw 11,724(31)
	stw 24,728(31)
	stw 10,736(31)
	stw 26,1784(31)
	stw 9,1792(31)
	stw 10,732(31)
	stw 9,1772(31)
	stw 26,1776(31)
	stw 9,1780(31)
	stw 9,1788(31)
.L211:
	lwz 0,1804(31)
	cmpwi 0,0,5
	bc 4,2,.L212
	li 0,2
	li 9,260
	stw 0,1844(31)
	lis 3,.LC115@ha
	lis 28,0x38e3
	stw 9,644(30)
	la 3,.LC115@l(3)
	ori 28,28,36409
	bl FindItem
	addi 27,31,748
	li 23,500
	lis 29,itemlist@ha
	lis 9,.LC120@ha
	la 29,itemlist@l(29)
	li 24,10
	subf 0,29,3
	li 26,100
	mullw 0,0,28
	la 3,.LC120@l(9)
	li 25,1
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 23,27,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC123@ha
	la 3,.LC123@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 24,27,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC124@ha
	la 3,.LC124@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 26,27,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC129@ha
	la 3,.LC129@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 25,27,9
	bl FindItem
	mr 8,3
	li 11,120
	subf 29,29,8
	li 10,0
	mullw 29,29,28
	li 9,3
	srawi 29,29,3
	slwi 0,29,2
	stw 29,744(31)
	stwx 25,27,0
	stw 8,1848(31)
	stw 9,724(31)
	stw 11,736(31)
	stw 23,1772(31)
	stw 24,1784(31)
	stw 26,1788(31)
	stw 10,1792(31)
	stw 26,728(31)
	stw 11,732(31)
	stw 26,1776(31)
	stw 10,1780(31)
.L212:
	lwz 0,1804(31)
	cmpwi 0,0,6
	bc 4,2,.L213
	stw 0,1844(31)
	lis 3,.LC130@ha
	lis 28,0x38e3
	li 0,180
	la 3,.LC130@l(3)
	stw 0,644(30)
	ori 28,28,36409
	addi 27,31,748
	bl FindItem
	li 24,400
	li 25,1
	lis 29,itemlist@ha
	lis 9,.LC131@ha
	la 29,itemlist@l(29)
	li 26,4
	subf 0,29,3
	mullw 0,0,28
	la 3,.LC131@l(9)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 24,27,9
	bl FindItem
	mr 8,3
	subf 0,29,8
	lis 3,.LC120@ha
	mullw 0,0,28
	la 3,.LC120@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 25,27,9
	stw 8,1848(31)
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC132@ha
	la 3,.LC132@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 26,27,9
	bl FindItem
	subf 3,29,3
	li 9,0
	mullw 3,3,28
	li 11,40
	srawi 3,3,3
	slwi 0,3,2
	stw 3,744(31)
	stwx 25,27,0
	stw 11,736(31)
	stw 26,1784(31)
	stw 24,1788(31)
	stw 9,1792(31)
	stw 9,724(31)
	stw 9,728(31)
	stw 11,732(31)
	stw 9,1772(31)
	stw 9,1776(31)
	stw 9,1780(31)
.L213:
	lwz 0,1804(31)
	cmpwi 0,0,7
	bc 4,2,.L214
	li 0,5
	li 9,170
	stw 0,1844(31)
	lis 3,.LC130@ha
	lis 28,0x38e3
	stw 9,644(30)
	la 3,.LC130@l(3)
	ori 28,28,36409
	bl FindItem
	addi 27,31,748
	li 24,200
	lis 29,itemlist@ha
	lis 9,.LC119@ha
	la 29,itemlist@l(29)
	li 26,1
	subf 0,29,3
	li 25,8
	mullw 0,0,28
	la 3,.LC119@l(9)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 24,27,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC120@ha
	la 3,.LC120@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 26,27,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC124@ha
	la 3,.LC124@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 25,27,9
	bl FindItem
	mr 8,3
	subf 0,29,8
	lis 3,.LC121@ha
	mullw 0,0,28
	la 3,.LC121@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 26,27,9
	stw 8,1848(31)
	bl FindItem
	subf 3,29,3
	li 11,30
	mullw 3,3,28
	li 9,0
	li 8,80
	li 10,50
	srawi 3,3,3
	slwi 0,3,2
	stw 3,744(31)
	stwx 11,27,0
	stw 26,724(31)
	stw 11,728(31)
	stw 8,736(31)
	stw 10,1776(31)
	stw 25,1784(31)
	stw 24,1788(31)
	stw 9,1792(31)
	stw 8,732(31)
	stw 9,1772(31)
	stw 9,1780(31)
.L214:
	lwz 24,1804(31)
	cmpwi 0,24,8
	bc 4,2,.L215
	li 0,5
	li 9,200
	stw 0,1844(31)
	lis 3,.LC120@ha
	lis 28,0x38e3
	stw 9,644(30)
	la 3,.LC120@l(3)
	ori 28,28,36409
	bl FindItem
	addi 27,31,748
	li 25,150
	lis 29,itemlist@ha
	lis 9,.LC115@ha
	la 29,itemlist@l(29)
	li 26,1
	subf 0,29,3
	mullw 0,0,28
	la 3,.LC115@l(9)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 24,27,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC122@ha
	la 3,.LC122@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 25,27,9
	bl FindItem
	mr 8,3
	subf 0,29,8
	lis 3,.LC124@ha
	mullw 0,0,28
	la 3,.LC124@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 26,27,9
	stw 8,1848(31)
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC127@ha
	la 3,.LC127@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 26,27,9
	bl FindItem
	subf 3,29,3
	li 10,40
	mullw 3,3,28
	li 9,0
	li 7,80
	li 11,10
	li 8,70
	srawi 3,3,3
	slwi 0,3,2
	stw 3,744(31)
	stwx 10,27,0
	stw 26,724(31)
	stw 11,728(31)
	stw 7,736(31)
	stw 25,1772(31)
	stw 8,1776(31)
	stw 24,1784(31)
	stw 9,1792(31)
	stw 7,732(31)
	stw 9,1780(31)
	stw 9,1788(31)
.L215:
	lwz 0,1804(31)
	cmpwi 0,0,9
	bc 4,2,.L216
	li 0,7
	li 9,190
	stw 0,1844(31)
	lis 3,.LC97@ha
	lis 28,0x38e3
	stw 9,644(30)
	la 3,.LC97@l(3)
	ori 28,28,36409
	bl FindItem
	li 27,0
	addi 26,31,748
	lis 29,itemlist@ha
	lis 9,.LC120@ha
	la 29,itemlist@l(29)
	li 24,5
	subf 0,29,3
	li 25,50
	mullw 0,0,28
	la 3,.LC120@l(9)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 27,26,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC127@ha
	la 3,.LC127@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 24,26,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC133@ha
	la 3,.LC133@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 25,26,9
	bl FindItem
	mr 8,3
	li 11,1
	subf 29,29,8
	li 10,90
	mullw 29,29,28
	li 9,2
	srawi 29,29,3
	slwi 0,29,2
	stw 29,744(31)
	stwx 11,26,0
	stw 8,1848(31)
	stw 9,724(31)
	stw 25,728(31)
	stw 10,736(31)
	stw 24,1784(31)
	stw 27,1792(31)
	stw 10,732(31)
	stw 27,1772(31)
	stw 27,1776(31)
	stw 27,1780(31)
	stw 27,1788(31)
.L216:
	lwz 0,1804(31)
	cmpwi 0,0,10
	bc 4,2,.L217
	li 0,200
	li 9,5
	stw 0,644(30)
	lis 3,.LC120@ha
	lis 28,0x38e3
	stw 9,1844(31)
	la 3,.LC120@l(3)
	ori 28,28,36409
	lwz 0,908(30)
	addi 27,31,748
	li 25,4
	li 26,1
	li 24,15
	stw 0,948(30)
	bl FindItem
	lis 29,itemlist@ha
	lis 9,.LC119@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	mullw 0,0,28
	la 3,.LC119@l(9)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 25,27,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC134@ha
	la 3,.LC134@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 26,27,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC121@ha
	la 3,.LC121@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 26,27,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC130@ha
	la 3,.LC130@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 24,27,9
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC133@ha
	la 3,.LC133@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 25,27,9
	bl FindItem
	mr 8,3
	li 9,0
	subf 29,29,8
	li 10,80
	mullw 29,29,28
	li 11,50
	srawi 29,29,3
	slwi 0,29,2
	stw 29,744(31)
	stwx 26,27,0
	stw 8,1848(31)
	stw 26,724(31)
	stw 24,728(31)
	stw 10,736(31)
	stw 11,1776(31)
	stw 25,1788(31)
	stw 9,1792(31)
	stw 10,732(31)
	stw 9,1772(31)
	stw 9,1780(31)
	stw 25,1784(31)
.L217:
	lwz 0,908(30)
	cmpwi 0,0,3
	bc 4,2,.L218
	li 0,4
	lis 9,level@ha
	la 9,level@l(9)
	stw 0,1844(31)
	lwz 0,336(9)
	cmpwi 0,0,0
	bc 4,2,.L219
	li 0,100
	stw 0,736(31)
	stw 0,732(31)
	b .L220
.L219:
	stw 0,732(31)
	lwz 0,336(9)
	stw 0,736(31)
.L220:
	lis 9,level@ha
	la 30,level@l(9)
	lwz 0,332(30)
	cmpwi 0,0,0
	bc 12,2,.L221
	lis 3,.LC118@ha
	lis 28,0x38e3
	la 3,.LC118@l(3)
	ori 28,28,36409
	bl FindItem
	addi 27,31,748
	lis 29,itemlist@ha
	mr 8,3
	la 29,itemlist@l(29)
	li 11,1
	subf 0,29,8
	lis 3,.LC116@ha
	mullw 0,0,28
	la 3,.LC116@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 11,27,9
	stw 8,1848(31)
	bl FindItem
	subf 3,29,3
	mullw 3,3,28
	srawi 3,3,3
	stw 3,744(31)
	lwz 0,332(30)
	slwi 3,3,2
	stwx 0,27,3
.L221:
	lwz 0,328(30)
	cmpwi 0,0,0
	bc 12,2,.L222
	lis 3,.LC119@ha
	lis 28,0x38e3
	la 3,.LC119@l(3)
	ori 28,28,36409
	bl FindItem
	addi 27,31,748
	lis 29,itemlist@ha
	mr 8,3
	la 29,itemlist@l(29)
	li 11,1
	subf 0,29,8
	lis 3,.LC114@ha
	mullw 0,0,28
	la 3,.LC114@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,744(31)
	stwx 11,27,9
	stw 8,1848(31)
	bl FindItem
	subf 3,29,3
	mullw 3,3,28
	srawi 3,3,3
	stw 3,744(31)
	lwz 0,328(30)
	slwi 3,3,2
	stwx 0,27,3
.L222:
	lwz 0,340(30)
	cmpwi 0,0,0
	bc 12,2,.L218
	lis 3,.LC114@ha
	la 3,.LC114@l(3)
	bl FindItem
	lis 9,itemlist@ha
	mr 8,3
	la 9,itemlist@l(9)
	lis 0,0x38e3
	ori 0,0,36409
	subf 9,9,8
	mullw 9,9,0
	addi 10,31,748
	li 11,1
	srawi 9,9,3
	slwi 0,9,2
	stw 9,744(31)
	stwx 11,10,0
	stw 8,1848(31)
.L218:
	li 0,1
	mr 3,31
	stw 0,720(31)
	bl ClearScanner
	mr 3,31
	crxor 6,6,6
	bl ClearClasses
	lwz 0,68(1)
	mtlr 0
	lmw 23,28(1)
	la 1,64(1)
	blr
.Lfe5:
	.size	 InitClientPersistant,.Lfe5-InitClientPersistant
	.section	".rodata"
	.align 2
.LC137:
	.string	"info_player_deathmatch"
	.align 2
.LC136:
	.long 0x47c34f80
	.align 2
.LC138:
	.long 0x4b18967f
	.align 2
.LC139:
	.long 0x3f800000
	.align 3
.LC140:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SelectRandomDeathmatchSpawnPoint
	.type	 SelectRandomDeathmatchSpawnPoint,@function
SelectRandomDeathmatchSpawnPoint:
	stwu 1,-112(1)
	mflr 0
	stfd 28,80(1)
	stfd 29,88(1)
	stfd 30,96(1)
	stfd 31,104(1)
	stmw 22,40(1)
	stw 0,116(1)
	lis 9,.LC136@ha
	li 28,0
	lfs 29,.LC136@l(9)
	li 30,0
	li 23,0
	li 24,0
	fmr 28,29
	lis 22,.LC137@ha
	b .L248
.L250:
	lis 10,.LC139@ha
	lis 9,maxclients@ha
	la 10,.LC139@l(10)
	lis 11,.LC138@ha
	lfs 13,0(10)
	addi 28,28,1
	li 29,1
	lwz 10,maxclients@l(9)
	lis 25,maxclients@ha
	lfs 31,.LC138@l(11)
	lfs 0,20(10)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L258
	lis 11,.LC140@ha
	lis 26,g_edicts@ha
	la 11,.LC140@l(11)
	lis 27,0x4330
	lfd 30,0(11)
	li 31,1268
.L253:
	lwz 0,g_edicts@l(26)
	add 11,0,31
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L255
	lwz 0,728(11)
	cmpwi 0,0,0
	bc 4,1,.L255
	lfs 0,4(11)
	addi 3,1,8
	lfs 13,4(30)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 13,8(11)
	lfs 0,8(30)
	fsubs 0,0,13
	stfs 0,12(1)
	lfs 13,12(11)
	lfs 0,12(30)
	fsubs 0,0,13
	stfs 0,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 4,0,.L255
	fmr 31,1
.L255:
	addi 29,29,1
	lwz 11,maxclients@l(25)
	xoris 0,29,0x8000
	addi 31,31,1268
	stw 0,36(1)
	stw 27,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L253
.L258:
	fcmpu 0,31,28
	bc 4,0,.L260
	fmr 28,31
	mr 24,30
	b .L248
.L260:
	fcmpu 0,31,29
	bc 4,0,.L248
	fmr 29,31
	mr 23,30
.L248:
	lis 5,.LC137@ha
	mr 3,30
	la 5,.LC137@l(5)
	li 4,284
	bl G_Find
	mr. 30,3
	bc 4,2,.L250
	cmpwi 0,28,0
	bc 4,2,.L264
	li 3,0
	b .L272
.L264:
	cmpwi 0,28,2
	bc 12,1,.L265
	li 23,0
	li 24,0
	b .L266
.L265:
	addi 28,28,-2
.L266:
	bl rand
	li 30,0
	divw 0,3,28
	mullw 0,0,28
	subf 31,0,3
.L271:
	mr 3,30
	li 4,284
	la 5,.LC137@l(22)
	bl G_Find
	mr 30,3
	addi 0,31,1
	xor 9,30,24
	subfic 10,9,0
	adde 9,10,9
	xor 11,30,23
	subfic 10,11,0
	adde 11,10,11
	or 9,9,11
	addic 9,9,-1
	subfe 9,9,9
	andc 0,0,9
	and 9,31,9
	or 31,9,0
	cmpwi 0,31,0
	addi 31,31,-1
	bc 4,2,.L271
.L272:
	lwz 0,116(1)
	mtlr 0
	lmw 22,40(1)
	lfd 28,80(1)
	lfd 29,88(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe6:
	.size	 SelectRandomDeathmatchSpawnPoint,.Lfe6-SelectRandomDeathmatchSpawnPoint
	.section	".rodata"
	.align 2
.LC142:
	.string	"info_player_team1"
	.align 2
.LC141:
	.long 0x47c34f80
	.align 2
.LC143:
	.long 0x4b18967f
	.align 2
.LC144:
	.long 0x3f800000
	.align 3
.LC145:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SelectTeam2SpawnPoint
	.type	 SelectTeam2SpawnPoint,@function
SelectTeam2SpawnPoint:
	stwu 1,-112(1)
	mflr 0
	stfd 28,80(1)
	stfd 29,88(1)
	stfd 30,96(1)
	stfd 31,104(1)
	stmw 22,40(1)
	stw 0,116(1)
	lis 9,.LC141@ha
	li 28,0
	lfs 29,.LC141@l(9)
	li 30,0
	li 23,0
	li 24,0
	fmr 28,29
	lis 22,.LC142@ha
	b .L274
.L276:
	lis 10,.LC144@ha
	lis 9,maxclients@ha
	la 10,.LC144@l(10)
	lis 11,.LC143@ha
	lfs 13,0(10)
	addi 28,28,1
	li 29,1
	lwz 10,maxclients@l(9)
	lis 25,maxclients@ha
	lfs 31,.LC143@l(11)
	lfs 0,20(10)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L284
	lis 11,.LC145@ha
	lis 26,g_edicts@ha
	la 11,.LC145@l(11)
	lis 27,0x4330
	lfd 30,0(11)
	li 31,1268
.L279:
	lwz 0,g_edicts@l(26)
	add 11,0,31
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L281
	lwz 0,728(11)
	cmpwi 0,0,0
	bc 4,1,.L281
	lfs 0,4(11)
	addi 3,1,8
	lfs 13,4(30)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 13,8(11)
	lfs 0,8(30)
	fsubs 0,0,13
	stfs 0,12(1)
	lfs 13,12(11)
	lfs 0,12(30)
	fsubs 0,0,13
	stfs 0,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 4,0,.L281
	fmr 31,1
.L281:
	addi 29,29,1
	lwz 11,maxclients@l(25)
	xoris 0,29,0x8000
	addi 31,31,1268
	stw 0,36(1)
	stw 27,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L279
.L284:
	fcmpu 0,31,28
	bc 4,0,.L286
	fmr 28,31
	mr 24,30
	b .L274
.L286:
	fcmpu 0,31,29
	bc 4,0,.L274
	fmr 29,31
	mr 23,30
.L274:
	lis 5,.LC142@ha
	mr 3,30
	la 5,.LC142@l(5)
	li 4,284
	bl G_Find
	mr. 30,3
	bc 4,2,.L276
	cmpwi 0,28,0
	bc 4,2,.L290
	li 3,0
	b .L298
.L290:
	cmpwi 0,28,2
	bc 12,1,.L291
	li 23,0
	li 24,0
	b .L292
.L291:
	addi 28,28,-2
.L292:
	bl rand
	li 30,0
	divw 0,3,28
	mullw 0,0,28
	subf 31,0,3
.L297:
	mr 3,30
	li 4,284
	la 5,.LC142@l(22)
	bl G_Find
	mr 30,3
	addi 0,31,1
	xor 9,30,24
	subfic 10,9,0
	adde 9,10,9
	xor 11,30,23
	subfic 10,11,0
	adde 11,10,11
	or 9,9,11
	addic 9,9,-1
	subfe 9,9,9
	andc 0,0,9
	and 9,31,9
	or 31,9,0
	cmpwi 0,31,0
	addi 31,31,-1
	bc 4,2,.L297
.L298:
	lwz 0,116(1)
	mtlr 0
	lmw 22,40(1)
	lfd 28,80(1)
	lfd 29,88(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe7:
	.size	 SelectTeam2SpawnPoint,.Lfe7-SelectTeam2SpawnPoint
	.section	".rodata"
	.align 2
.LC147:
	.string	"info_player_team3"
	.align 2
.LC146:
	.long 0x47c34f80
	.align 2
.LC148:
	.long 0x4b18967f
	.align 2
.LC149:
	.long 0x3f800000
	.align 3
.LC150:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SelectTeam3SpawnPoint
	.type	 SelectTeam3SpawnPoint,@function
SelectTeam3SpawnPoint:
	stwu 1,-112(1)
	mflr 0
	stfd 28,80(1)
	stfd 29,88(1)
	stfd 30,96(1)
	stfd 31,104(1)
	stmw 22,40(1)
	stw 0,116(1)
	lis 9,.LC146@ha
	li 28,0
	lfs 29,.LC146@l(9)
	li 30,0
	li 23,0
	li 24,0
	fmr 28,29
	lis 22,.LC147@ha
	b .L300
.L302:
	lis 10,.LC149@ha
	lis 9,maxclients@ha
	la 10,.LC149@l(10)
	lis 11,.LC148@ha
	lfs 13,0(10)
	addi 28,28,1
	li 29,1
	lwz 10,maxclients@l(9)
	lis 25,maxclients@ha
	lfs 31,.LC148@l(11)
	lfs 0,20(10)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L310
	lis 11,.LC150@ha
	lis 26,g_edicts@ha
	la 11,.LC150@l(11)
	lis 27,0x4330
	lfd 30,0(11)
	li 31,1268
.L305:
	lwz 0,g_edicts@l(26)
	add 11,0,31
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L307
	lwz 0,728(11)
	cmpwi 0,0,0
	bc 4,1,.L307
	lfs 0,4(11)
	addi 3,1,8
	lfs 13,4(30)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 13,8(11)
	lfs 0,8(30)
	fsubs 0,0,13
	stfs 0,12(1)
	lfs 13,12(11)
	lfs 0,12(30)
	fsubs 0,0,13
	stfs 0,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 4,0,.L307
	fmr 31,1
.L307:
	addi 29,29,1
	lwz 11,maxclients@l(25)
	xoris 0,29,0x8000
	addi 31,31,1268
	stw 0,36(1)
	stw 27,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L305
.L310:
	fcmpu 0,31,28
	bc 4,0,.L312
	fmr 28,31
	mr 24,30
	b .L300
.L312:
	fcmpu 0,31,29
	bc 4,0,.L300
	fmr 29,31
	mr 23,30
.L300:
	lis 5,.LC147@ha
	mr 3,30
	la 5,.LC147@l(5)
	li 4,284
	bl G_Find
	mr. 30,3
	bc 4,2,.L302
	cmpwi 0,28,0
	bc 4,2,.L316
	li 3,0
	b .L324
.L316:
	cmpwi 0,28,2
	bc 12,1,.L317
	li 23,0
	li 24,0
	b .L318
.L317:
	addi 28,28,-2
.L318:
	bl rand
	li 30,0
	divw 0,3,28
	mullw 0,0,28
	subf 31,0,3
.L323:
	mr 3,30
	li 4,284
	la 5,.LC147@l(22)
	bl G_Find
	mr 30,3
	addi 0,31,1
	xor 9,30,24
	subfic 10,9,0
	adde 9,10,9
	xor 11,30,23
	subfic 10,11,0
	adde 11,10,11
	or 9,9,11
	addic 9,9,-1
	subfe 9,9,9
	andc 0,0,9
	and 9,31,9
	or 31,9,0
	cmpwi 0,31,0
	addi 31,31,-1
	bc 4,2,.L323
.L324:
	lwz 0,116(1)
	mtlr 0
	lmw 22,40(1)
	lfd 28,80(1)
	lfd 29,88(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe8:
	.size	 SelectTeam3SpawnPoint,.Lfe8-SelectTeam3SpawnPoint
	.section	".rodata"
	.align 2
.LC152:
	.string	"info_player_team2"
	.align 2
.LC151:
	.long 0x47c34f80
	.align 2
.LC153:
	.long 0x4b18967f
	.align 2
.LC154:
	.long 0x3f800000
	.align 3
.LC155:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SelectTeam1SpawnPoint
	.type	 SelectTeam1SpawnPoint,@function
SelectTeam1SpawnPoint:
	stwu 1,-112(1)
	mflr 0
	stfd 28,80(1)
	stfd 29,88(1)
	stfd 30,96(1)
	stfd 31,104(1)
	stmw 22,40(1)
	stw 0,116(1)
	lis 9,.LC151@ha
	li 28,0
	lfs 29,.LC151@l(9)
	li 30,0
	li 23,0
	li 24,0
	fmr 28,29
	lis 22,.LC152@ha
	b .L326
.L328:
	lis 10,.LC154@ha
	lis 9,maxclients@ha
	la 10,.LC154@l(10)
	lis 11,.LC153@ha
	lfs 13,0(10)
	addi 28,28,1
	li 29,1
	lwz 10,maxclients@l(9)
	lis 25,maxclients@ha
	lfs 31,.LC153@l(11)
	lfs 0,20(10)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L336
	lis 11,.LC155@ha
	lis 26,g_edicts@ha
	la 11,.LC155@l(11)
	lis 27,0x4330
	lfd 30,0(11)
	li 31,1268
.L331:
	lwz 0,g_edicts@l(26)
	add 11,0,31
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L333
	lwz 0,728(11)
	cmpwi 0,0,0
	bc 4,1,.L333
	lfs 0,4(11)
	addi 3,1,8
	lfs 13,4(30)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 13,8(11)
	lfs 0,8(30)
	fsubs 0,0,13
	stfs 0,12(1)
	lfs 13,12(11)
	lfs 0,12(30)
	fsubs 0,0,13
	stfs 0,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 4,0,.L333
	fmr 31,1
.L333:
	addi 29,29,1
	lwz 11,maxclients@l(25)
	xoris 0,29,0x8000
	addi 31,31,1268
	stw 0,36(1)
	stw 27,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L331
.L336:
	fcmpu 0,31,28
	bc 4,0,.L338
	fmr 28,31
	mr 24,30
	b .L326
.L338:
	fcmpu 0,31,29
	bc 4,0,.L326
	fmr 29,31
	mr 23,30
.L326:
	lis 5,.LC152@ha
	mr 3,30
	la 5,.LC152@l(5)
	li 4,284
	bl G_Find
	mr. 30,3
	bc 4,2,.L328
	cmpwi 0,28,0
	bc 4,2,.L342
	li 3,0
	b .L350
.L342:
	cmpwi 0,28,2
	bc 12,1,.L343
	li 23,0
	li 24,0
	b .L344
.L343:
	addi 28,28,-2
.L344:
	bl rand
	li 30,0
	divw 0,3,28
	mullw 0,0,28
	subf 31,0,3
.L349:
	mr 3,30
	li 4,284
	la 5,.LC152@l(22)
	bl G_Find
	mr 30,3
	addi 0,31,1
	xor 9,30,24
	subfic 10,9,0
	adde 9,10,9
	xor 11,30,23
	subfic 10,11,0
	adde 11,10,11
	or 9,9,11
	addic 9,9,-1
	subfe 9,9,9
	andc 0,0,9
	and 9,31,9
	or 31,9,0
	cmpwi 0,31,0
	addi 31,31,-1
	bc 4,2,.L349
.L350:
	lwz 0,116(1)
	mtlr 0
	lmw 22,40(1)
	lfd 28,80(1)
	lfd 29,88(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe9:
	.size	 SelectTeam1SpawnPoint,.Lfe9-SelectTeam1SpawnPoint
	.section	".rodata"
	.align 2
.LC156:
	.long 0x4b18967f
	.align 2
.LC157:
	.long 0x0
	.align 2
.LC158:
	.long 0x3f800000
	.align 3
.LC159:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SelectFarthestDeathmatchSpawnPoint
	.type	 SelectFarthestDeathmatchSpawnPoint,@function
SelectFarthestDeathmatchSpawnPoint:
	stwu 1,-96(1)
	mflr 0
	stfd 29,72(1)
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 25,44(1)
	stw 0,100(1)
	lis 9,.LC157@ha
	li 31,0
	la 9,.LC157@l(9)
	li 25,0
	lfs 29,0(9)
	b .L352
.L354:
	lis 9,maxclients@ha
	lis 11,.LC158@ha
	lwz 10,maxclients@l(9)
	la 11,.LC158@l(11)
	li 29,1
	lfs 13,0(11)
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC156@ha
	lfs 31,.LC156@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L362
	lis 9,.LC159@ha
	lis 27,g_edicts@ha
	la 9,.LC159@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,1268
.L357:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L359
	lwz 0,728(11)
	cmpwi 0,0,0
	bc 4,1,.L359
	lfs 0,4(11)
	addi 3,1,8
	lfs 13,4(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 13,8(11)
	lfs 0,8(31)
	fsubs 0,0,13
	stfs 0,12(1)
	lfs 13,12(11)
	lfs 0,12(31)
	fsubs 0,0,13
	stfs 0,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 4,0,.L359
	fmr 31,1
.L359:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,1268
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L357
.L362:
	fcmpu 0,31,29
	bc 4,1,.L352
	fmr 29,31
	mr 25,31
.L352:
	lis 30,.LC137@ha
	mr 3,31
	li 4,284
	la 5,.LC137@l(30)
	bl G_Find
	mr. 31,3
	bc 4,2,.L354
	cmpwi 0,25,0
	mr 3,25
	bc 4,2,.L367
	la 5,.LC137@l(30)
	li 3,0
	li 4,284
	bl G_Find
.L367:
	lwz 0,100(1)
	mtlr 0
	lmw 25,44(1)
	lfd 29,72(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe10:
	.size	 SelectFarthestDeathmatchSpawnPoint,.Lfe10-SelectFarthestDeathmatchSpawnPoint
	.section	".rodata"
	.align 2
.LC160:
	.string	"Couldn't find spawn point %s\n"
	.align 2
.LC161:
	.long 0x0
	.align 2
.LC162:
	.long 0x41100000
	.section	".text"
	.align 2
	.globl SelectSpawnPoint
	.type	 SelectSpawnPoint,@function
SelectSpawnPoint:
	stwu 1,-64(1)
	mflr 0
	stmw 25,36(1)
	stw 0,68(1)
	lis 11,.LC161@ha
	lis 9,deathmatch@ha
	la 11,.LC161@l(11)
	mr 30,3
	lfs 13,0(11)
	mr 26,4
	mr 25,5
	lwz 11,deathmatch@l(9)
	li 31,0
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L385
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,512
	bc 12,2,.L386
	bl SelectFarthestDeathmatchSpawnPoint
	b .L421
.L386:
	bl SelectRandomDeathmatchSpawnPoint
.L421:
	mr 31,3
.L385:
	lwz 0,908(30)
	cmpwi 0,0,1
	bc 4,2,.L389
	bl SelectTeam1SpawnPoint
	mr 31,3
.L389:
	lwz 0,908(30)
	cmpwi 0,0,2
	bc 4,2,.L391
	bl SelectTeam2SpawnPoint
	mr 31,3
.L391:
	lwz 0,908(30)
	cmpwi 0,0,3
	bc 4,2,.L393
	bl SelectTeam3SpawnPoint
	mr 31,3
	b .L395
.L393:
	lis 9,.LC161@ha
	lis 11,coop@ha
	la 9,.LC161@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L395
	lis 11,game+1028@ha
	lwz 0,84(30)
	lis 9,0x2645
	lwz 10,game+1028@l(11)
	ori 9,9,19727
	li 30,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,3
	bc 4,2,.L397
.L422:
	li 31,0
	b .L395
.L397:
	lis 27,.LC2@ha
	lis 28,.LC24@ha
	lis 29,game+1032@ha
.L401:
	mr 3,30
	li 4,284
	la 5,.LC2@l(27)
	bl G_Find
	mr. 30,3
	bc 12,2,.L422
	lwz 4,536(30)
	la 9,.LC24@l(28)
	la 3,game+1032@l(29)
	srawi 11,4,31
	xor 0,11,4
	subf 0,0,11
	srawi 0,0,31
	andc 9,9,0
	and 4,4,0
	or 4,4,9
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L401
	addic. 31,31,-1
	bc 4,2,.L401
	mr 31,30
.L395:
	cmpwi 0,31,0
	bc 4,2,.L407
	lis 29,.LC0@ha
	lis 30,game@ha
.L414:
	mr 3,31
	li 4,284
	la 5,.LC0@l(29)
	bl G_Find
	mr. 31,3
	bc 12,2,.L420
	la 3,game@l(30)
	lbz 0,1032(3)
	cmpwi 0,0,0
	bc 4,2,.L418
	lwz 0,536(31)
	cmpwi 0,0,0
	bc 12,2,.L409
	b .L414
.L418:
	lwz 4,536(31)
	cmpwi 0,4,0
	bc 12,2,.L414
	addi 3,3,1032
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L414
.L409:
	cmpwi 0,31,0
	bc 4,2,.L407
.L420:
	lis 9,game@ha
	la 30,game@l(9)
	lbz 0,1032(30)
	cmpwi 0,0,0
	bc 4,2,.L416
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,284
	bl G_Find
	mr 31,3
.L416:
	cmpwi 0,31,0
	bc 4,2,.L407
	lis 9,gi+28@ha
	lis 3,.LC160@ha
	lwz 0,gi+28@l(9)
	la 3,.LC160@l(3)
	addi 4,30,1032
	mtlr 0
	crxor 6,6,6
	blrl
.L407:
	lfs 0,4(31)
	lis 9,.LC162@ha
	la 9,.LC162@l(9)
	lfs 12,0(9)
	stfs 0,0(26)
	lfs 13,8(31)
	stfs 13,4(26)
	lfs 0,12(31)
	fadds 0,0,12
	stfs 0,8(26)
	lfs 13,16(31)
	stfs 13,0(25)
	lfs 0,20(31)
	stfs 0,4(25)
	lfs 13,24(31)
	stfs 13,8(25)
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe11:
	.size	 SelectSpawnPoint,.Lfe11-SelectSpawnPoint
	.section	".rodata"
	.align 2
.LC163:
	.string	"bodyque"
	.section	".text"
	.align 2
	.globl CopyToBodyQue
	.type	 CopyToBodyQue,@function
CopyToBodyQue:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	lis 9,maxclients@ha
	lis 11,level@ha
	lwz 10,maxclients@l(9)
	la 11,level@l(11)
	lwz 8,296(11)
	lis 26,gi@ha
	mr 28,3
	lfs 0,20(10)
	la 26,gi@l(26)
	addi 9,8,1
	lwz 10,76(26)
	lis 25,g_edicts@ha
	srawi 0,9,31
	lwz 24,g_edicts@l(25)
	srwi 0,0,29
	mtlr 10
	add 0,9,0
	rlwinm 0,0,0,0,28
	fctiwz 13,0
	subf 9,0,9
	stw 9,296(11)
	stfd 13,8(1)
	lwz 27,12(1)
	add 27,27,8
	mulli 27,27,1268
	addi 27,27,1268
	blrl
	add 29,24,27
	lwz 9,76(26)
	mr 3,29
	mtlr 9
	blrl
	mr 4,28
	li 5,84
	mr 3,29
	crxor 6,6,6
	bl memcpy
	lwz 0,g_edicts@l(25)
	lis 9,0x6f71
	lis 11,body_die@ha
	ori 9,9,56853
	la 11,body_die@l(11)
	subf 0,0,29
	li 10,1
	mullw 0,0,9
	mr 3,29
	srawi 0,0,2
	stwx 0,24,27
	lwz 9,184(28)
	stw 9,184(29)
	lfs 0,188(28)
	stfs 0,188(29)
	lfs 13,192(28)
	stfs 13,192(29)
	lfs 0,196(28)
	stfs 0,196(29)
	lfs 13,200(28)
	stfs 13,200(29)
	lfs 0,204(28)
	stfs 0,204(29)
	lfs 13,208(28)
	stfs 13,208(29)
	lfs 0,212(28)
	stfs 0,212(29)
	lfs 13,216(28)
	stfs 13,216(29)
	lfs 0,220(28)
	stfs 0,220(29)
	lfs 13,224(28)
	stfs 13,224(29)
	lfs 0,228(28)
	stfs 0,228(29)
	lfs 13,232(28)
	stfs 13,232(29)
	lfs 0,236(28)
	stfs 0,236(29)
	lfs 13,240(28)
	stfs 13,240(29)
	lfs 0,244(28)
	stfs 0,244(29)
	lwz 0,248(28)
	stw 0,248(29)
	lwz 9,252(28)
	stw 9,252(29)
	lwz 0,256(28)
	stw 0,256(29)
	lwz 9,264(28)
	stw 11,700(29)
	stw 9,264(29)
	stw 10,788(29)
	lwz 0,72(26)
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe12:
	.size	 CopyToBodyQue,.Lfe12-CopyToBodyQue
	.section	".rodata"
	.align 2
.LC164:
	.string	"menu_loadgame\n"
	.align 2
.LC165:
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.align 2
.LC166:
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.align 2
.LC167:
	.string	"player"
	.align 2
.LC168:
	.string	"players/male/tris.md2"
	.align 2
.LC169:
	.string	"fov"
	.align 2
.LC170:
	.long 0x0
	.align 2
.LC171:
	.long 0x41400000
	.align 2
.LC172:
	.long 0x41000000
	.align 3
.LC173:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC174:
	.long 0x3f800000
	.align 2
.LC175:
	.long 0x43200000
	.align 2
.LC176:
	.long 0x47800000
	.align 2
.LC177:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl PutClientInServer
	.type	 PutClientInServer,@function
PutClientInServer:
	stwu 1,-4576(1)
	mflr 0
	stfd 31,4568(1)
	stmw 20,4520(1)
	stw 0,4580(1)
	lis 11,g_edicts@ha
	mr 31,3
	lwz 9,g_edicts@l(11)
	lis 0,0x6f71
	lis 10,.LC165@ha
	ori 0,0,56853
	la 11,.LC165@l(10)
	lwz 4,.LC165@l(10)
	subf 9,9,31
	lwz 30,84(31)
	lis 8,.LC166@ha
	mullw 9,9,0
	stw 4,8(1)
	addi 10,1,8
	la 7,.LC166@l(8)
	lwz 0,4(11)
	addi 6,1,24
	li 5,0
	lwz 28,8(11)
	srawi 9,9,2
	addi 29,1,56
	stw 0,4(10)
	addi 25,9,-1
	mr 3,30
	lwz 11,.LC166@l(8)
	mr 4,31
	mr 20,29
	stw 28,8(10)
	lwz 0,8(7)
	lwz 9,4(7)
	stw 11,24(1)
	stw 0,8(6)
	stw 9,4(6)
	stw 5,952(31)
	stw 5,948(31)
	bl InitClientPersistant
	mr 3,31
	addi 4,1,40
	mr 5,29
	bl SelectSpawnPoint
	lwz 9,268(31)
	andi. 0,9,8192
	bc 12,2,.L441
	addi 0,9,-8192
	stw 0,268(31)
.L441:
	lwz 0,268(31)
	lis 9,deathmatch@ha
	lis 8,.LC170@ha
	lwz 11,deathmatch@l(9)
	la 8,.LC170@l(8)
	rlwinm 0,0,0,14,11
	lfs 13,0(8)
	stw 0,268(31)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L442
	addi 28,1,1768
	addi 27,30,1872
	mulli 25,25,3960
	addi 26,1,3480
	mr 4,27
	li 5,1712
	mr 3,28
	crxor 6,6,6
	bl memcpy
	addi 29,30,188
	mr 21,28
	mr 4,29
	li 5,512
	mr 3,26
	mr 28,29
	crxor 6,6,6
	bl memcpy
	addi 22,30,20
	addi 23,30,3564
	mr 3,30
	mr 4,31
	addi 29,1,72
	bl InitClientPersistant
	mr 4,26
	mr 3,31
	bl ClientUserinfoChanged
	b .L443
.L442:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L444
	addi 27,1,1768
	addi 26,30,1872
	mulli 25,25,3960
	addi 29,1,3992
	mr 4,26
	li 5,1712
	mr 3,27
	crxor 6,6,6
	bl memcpy
	addi 28,30,188
	mr 24,29
	mr 3,29
	mr 4,28
	li 5,512
	mr 21,27
	crxor 6,6,6
	bl memcpy
	mr 27,26
	addi 22,30,20
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	la 9,itemlist@l(9)
	addi 29,1,72
	addi 9,9,56
	addi 23,30,3564
	addi 10,1,2328
	addi 11,30,748
.L472:
	lwz 0,0(9)
	addi 9,9,72
	andi. 8,0,16
	bc 12,2,.L447
	lwz 0,0(11)
	stw 0,0(10)
.L447:
	addi 10,10,4
	addi 11,11,4
	bdnz .L472
	mr 4,21
	li 5,1684
	mr 3,28
	crxor 6,6,6
	bl memcpy
	mr 4,24
	mr 3,31
	bl ClientUserinfoChanged
	lwz 9,3456(1)
	lwz 0,1860(30)
	cmpw 0,9,0
	bc 4,1,.L443
	stw 9,1860(30)
	b .L443
.L444:
	addi 29,1,1768
	li 4,0
	mulli 25,25,3960
	mr 3,29
	li 5,1712
	crxor 6,6,6
	bl memset
	mr 21,29
	addi 27,30,1872
	addi 28,30,188
	addi 29,1,72
	addi 22,30,20
	addi 23,30,3564
.L443:
	mr 4,28
	li 5,1684
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 4,0
	li 5,3960
	mr 3,30
	crxor 6,6,6
	bl memset
	mr 4,29
	mr 3,28
	li 5,1684
	crxor 6,6,6
	bl memcpy
	lwz 0,732(30)
	cmpwi 0,0,0
	bc 12,1,.L453
	mr 3,30
	mr 4,31
	bl InitClientPersistant
.L453:
	mr 3,27
	mr 4,21
	li 5,1712
	crxor 6,6,6
	bl memcpy
	lwz 11,84(31)
	lwz 0,732(11)
	stw 0,728(31)
	lwz 9,736(11)
	stw 9,756(31)
	lwz 0,740(11)
	cmpwi 0,0,0
	bc 12,2,.L454
	lwz 0,268(31)
	ori 0,0,4096
	stw 0,268(31)
.L454:
	lis 9,coop@ha
	lis 8,.LC170@ha
	lwz 11,coop@l(9)
	la 8,.LC170@l(8)
	lfs 31,0(8)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L456
	lwz 9,84(31)
	lwz 0,1860(9)
	stw 0,3560(9)
.L456:
	li 6,0
	lis 11,game+1028@ha
	stw 6,828(31)
	li 0,4
	li 7,2
	lwz 9,game+1028@l(11)
	stw 0,264(31)
	add 9,9,25
	stw 7,788(31)
	stw 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,0
	bc 4,2,.L457
	li 0,1
	stw 0,264(31)
.L457:
	lis 9,.LC167@ha
	li 0,1
	lwz 8,84(31)
	li 10,22
	la 9,.LC167@l(9)
	stw 0,88(31)
	li 11,200
	stw 10,784(31)
	stw 9,284(31)
	stw 11,644(31)
	stw 7,248(31)
	lwz 0,1804(8)
	cmpwi 0,0,0
	bc 4,2,.L458
	stw 6,248(31)
.L458:
	lis 11,.LC171@ha
	stfs 31,940(31)
	lis 9,level+4@ha
	stw 6,764(31)
	la 11,.LC171@l(11)
	lis 10,0x201
	lfs 0,level+4@l(9)
	lis 8,.LC168@ha
	ori 10,10,3
	lfs 13,0(11)
	lis 9,player_die@ha
	la 8,.LC168@l(8)
	lfs 12,24(1)
	lis 11,player_pain@ha
	la 9,player_die@l(9)
	lfs 11,28(1)
	la 11,player_pain@l(11)
	li 4,0
	fadds 0,0,13
	lfs 10,32(1)
	li 5,184
	lfs 13,16(1)
	lfs 8,8(1)
	lfs 9,12(1)
	lwz 7,268(31)
	lwz 0,184(31)
	rlwinm 7,7,0,21,19
	lwz 3,84(31)
	rlwinm 0,0,0,31,29
	stfs 0,648(31)
	stw 10,252(31)
	stw 8,272(31)
	stw 11,696(31)
	stw 9,700(31)
	stw 7,268(31)
	stfs 13,196(31)
	stfs 12,200(31)
	stfs 11,204(31)
	stfs 10,208(31)
	stw 6,960(31)
	stw 0,184(31)
	stfs 8,188(31)
	stfs 9,192(31)
	stw 6,964(31)
	stfs 31,628(31)
	stfs 31,624(31)
	stfs 31,620(31)
	crxor 6,6,6
	bl memset
	lis 8,.LC172@ha
	lfs 0,40(1)
	la 8,.LC172@l(8)
	mr 10,11
	lfs 10,0(8)
	lis 9,deathmatch@ha
	mr 8,11
	lwz 7,deathmatch@l(9)
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,4512(1)
	lwz 11,4516(1)
	sth 11,4(30)
	lfs 0,44(1)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,4512(1)
	lwz 10,4516(1)
	sth 10,6(30)
	lfs 0,48(1)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,4512(1)
	lwz 8,4516(1)
	sth 8,8(30)
	lfs 0,20(7)
	fcmpu 0,0,31
	bc 12,2,.L459
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,4512(1)
	lwz 11,4516(1)
	andi. 9,11,32768
	bc 4,2,.L473
.L459:
	lis 4,.LC169@ha
	mr 3,28
	la 4,.LC169@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	stw 3,4516(1)
	lis 0,0x4330
	lis 8,.LC173@ha
	la 8,.LC173@l(8)
	stw 0,4512(1)
	lis 11,.LC174@ha
	lfd 13,0(8)
	la 11,.LC174@l(11)
	lfd 0,4512(1)
	lfs 12,0(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	stfs 0,112(30)
	bc 4,0,.L461
.L473:
	lis 0,0x42b4
	stw 0,112(30)
	b .L460
.L461:
	lis 8,.LC175@ha
	la 8,.LC175@l(8)
	lfs 13,0(8)
	fcmpu 0,0,13
	bc 4,1,.L460
	stfs 13,112(30)
.L460:
	lis 9,gi+32@ha
	lwz 11,1848(30)
	li 29,255
	lwz 0,gi+32@l(9)
	li 28,0
	lwz 3,32(11)
	mtlr 0
	blrl
	lis 11,g_edicts@ha
	lis 0,0x6f71
	stw 3,88(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,56853
	mr 3,31
	stw 28,64(31)
	subf 9,9,31
	stw 29,40(31)
	mullw 9,9,0
	srawi 9,9,2
	addi 9,9,-1
	stw 9,60(31)
	bl ShowGun
	lwz 9,84(31)
	stw 29,44(31)
	lwz 0,1804(9)
	cmpwi 0,0,0
	bc 4,2,.L464
	stw 28,40(31)
	stw 28,44(31)
.L464:
	lis 8,.LC174@ha
	lfs 0,48(1)
	lis 9,.LC176@ha
	la 8,.LC174@l(8)
	li 0,3
	lfs 11,40(1)
	lfs 13,0(8)
	la 9,.LC176@l(9)
	lis 11,.LC177@ha
	mtctr 0
	lfs 12,44(1)
	la 11,.LC177@l(11)
	mr 29,20
	lfs 9,0(9)
	mr 8,23
	mr 10,22
	fadds 0,0,13
	lfs 10,0(11)
	stw 28,56(31)
	li 11,0
	stfs 11,28(31)
	stfs 12,32(31)
	stfs 0,36(31)
	stfs 11,4(31)
	stfs 12,8(31)
	stfs 0,12(31)
.L471:
	lfsx 0,11,29
	lfsx 12,11,8
	addi 11,11,4
	fsubs 0,0,12
	fmuls 0,0,9
	fdivs 0,0,10
	fctiwz 13,0
	stfd 13,4512(1)
	lwz 9,4516(1)
	sth 9,0(10)
	addi 10,10,2
	bdnz .L471
	lfs 0,60(1)
	li 0,0
	mr 3,31
	stw 0,24(31)
	stw 0,16(31)
	stfs 0,20(31)
	stw 0,28(30)
	lfs 0,20(31)
	stfs 0,32(30)
	lfs 13,24(31)
	stfs 13,36(30)
	lfs 0,16(31)
	stfs 0,3752(30)
	lfs 13,20(31)
	stfs 13,3756(30)
	lfs 0,24(31)
	stfs 0,3760(30)
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,1848(30)
	mr 3,31
	stw 0,3648(30)
	bl ChangeWeapon
	lwz 0,4580(1)
	mtlr 0
	lmw 20,4520(1)
	lfd 31,4568(1)
	la 1,4576(1)
	blr
.Lfe13:
	.size	 PutClientInServer,.Lfe13-PutClientInServer
	.section	".rodata"
	.align 2
.LC178:
	.string	"%s entered the game\n"
	.align 2
.LC179:
	.string	"motd.txt"
	.align 2
.LC180:
	.string	"r"
	.section	".text"
	.align 2
	.globl ClientBeginDeathmatch
	.type	 ClientBeginDeathmatch,@function
ClientBeginDeathmatch:
	stwu 1,-624(1)
	mflr 0
	stmw 26,600(1)
	stw 0,628(1)
	mr 31,3
	lis 26,gi@ha
	la 27,gi@l(26)
	bl G_InitEdict
	lwz 29,84(31)
	li 4,0
	li 5,1712
	addi 28,29,1872
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	li 5,1684
	lwz 0,level@l(9)
	addi 4,29,188
	mr 3,28
	stw 0,3556(29)
	crxor 6,6,6
	bl memcpy
	mr 3,31
	bl PutClientInServer
	lwz 9,100(27)
	li 3,1
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x6f71
	lwz 10,104(27)
	lwz 3,g_edicts@l(9)
	ori 0,0,56853
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,2
	blrl
	lwz 9,100(27)
	li 3,9
	mtlr 9
	blrl
	lwz 0,88(27)
	li 4,2
	addi 3,31,4
	mtlr 0
	blrl
	lwz 0,gi@l(26)
	lis 4,.LC178@ha
	li 3,2
	lwz 5,84(31)
	la 4,.LC178@l(4)
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	lis 3,.LC179@ha
	lis 4,.LC180@ha
	la 3,.LC179@l(3)
	la 4,.LC180@l(4)
	bl fopen
	mr. 28,3
	bc 12,2,.L476
	addi 3,1,8
	li 4,500
	mr 5,28
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L477
	addi 29,1,520
	b .L478
.L480:
	addi 3,1,8
	mr 4,29
	bl strcat
.L478:
	mr 3,29
	li 4,80
	mr 5,28
	bl fgets
	cmpwi 0,3,0
	bc 4,2,.L480
	lis 9,gi+12@ha
	mr 3,31
	lwz 0,gi+12@l(9)
	addi 4,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L477:
	mr 3,28
	bl fclose
.L476:
	mr 3,31
	bl ClientEndServerFrame
	lwz 0,628(1)
	mtlr 0
	lmw 26,600(1)
	la 1,624(1)
	blr
.Lfe14:
	.size	 ClientBeginDeathmatch,.Lfe14-ClientBeginDeathmatch
	.section	".rodata"
	.align 2
.LC181:
	.long 0x0
	.align 2
.LC182:
	.long 0x47800000
	.align 2
.LC183:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl ClientBegin
	.type	 ClientBegin,@function
ClientBegin:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,g_edicts@ha
	mr 31,3
	lwz 9,g_edicts@l(11)
	lis 0,0x6f71
	lis 10,deathmatch@ha
	ori 0,0,56853
	lis 11,game+1028@ha
	subf 9,9,31
	lwz 8,game+1028@l(11)
	mullw 9,9,0
	lwz 11,deathmatch@l(10)
	lis 10,.LC181@ha
	srawi 9,9,2
	la 10,.LC181@l(10)
	mulli 9,9,3960
	lfs 13,0(10)
	addi 9,9,-3960
	add 8,8,9
	stw 8,84(31)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L483
	bl ClientBeginDeathmatch
	b .L482
.L483:
	lwz 0,88(31)
	cmpwi 0,0,1
	bc 4,2,.L484
	lis 9,.LC182@ha
	lis 10,.LC183@ha
	li 11,3
	la 9,.LC182@l(9)
	la 10,.LC183@l(10)
	mtctr 11
	lfs 11,0(9)
	li 8,0
	lfs 12,0(10)
	li 7,0
.L495:
	lwz 10,84(31)
	add 0,8,8
	addi 8,8,1
	addi 9,10,28
	lfsx 0,9,7
	addi 10,10,20
	addi 7,7,4
	fmuls 0,0,11
	fdivs 0,0,12
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	sthx 11,10,0
	bdnz .L495
	b .L490
.L484:
	mr 3,31
	bl G_InitEdict
	lwz 28,84(31)
	lis 9,.LC167@ha
	li 4,0
	la 9,.LC167@l(9)
	li 5,1712
	addi 29,28,1872
	stw 9,284(31)
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,29
	lwz 0,level@l(9)
	addi 4,28,188
	li 5,1684
	stw 0,3556(28)
	crxor 6,6,6
	bl memcpy
	mr 3,31
	bl PutClientInServer
.L490:
	lis 10,.LC181@ha
	lis 9,level+200@ha
	la 10,.LC181@l(10)
	lfs 0,level+200@l(9)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 12,2,.L492
	mr 3,31
	bl MoveClientToIntermission
	b .L493
.L492:
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L493
	lis 28,gi@ha
	li 3,1
	la 29,gi@l(28)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x6f71
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,56853
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,2
	blrl
	lwz 9,100(29)
	li 3,9
	mtlr 9
	blrl
	lwz 0,88(29)
	li 4,2
	addi 3,31,4
	mtlr 0
	blrl
	lwz 5,84(31)
	lis 4,.LC178@ha
	li 3,2
	lwz 0,gi@l(28)
	la 4,.LC178@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L493:
	mr 3,31
	bl ClientEndServerFrame
.L482:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 ClientBegin,.Lfe15-ClientBegin
	.section	".rodata"
	.align 2
.LC184:
	.string	"\\name\\badinfo\\skin\\male/grunt"
	.align 2
.LC185:
	.string	"name"
	.align 2
.LC186:
	.string	"male/grunt"
	.align 2
.LC187:
	.string	"cyborg/oni911"
	.align 2
.LC188:
	.string	"male/razor"
	.align 2
.LC189:
	.string	"male/sniper"
	.align 2
.LC190:
	.string	"male/major"
	.align 2
.LC191:
	.string	"male/nightops"
	.align 2
.LC192:
	.string	"male/recon"
	.align 2
.LC193:
	.string	"male/energy1"
	.align 2
.LC194:
	.string	"male/ctf_b"
	.align 2
.LC195:
	.string	"male/viper"
	.align 2
.LC196:
	.string	"male/berserk"
	.align 2
.LC197:
	.string	"male/bluespy"
	.align 2
.LC198:
	.string	"male/ctf_r"
	.align 2
.LC199:
	.string	"male/scout"
	.align 2
.LC200:
	.string	"male/gravy"
	.align 2
.LC201:
	.string	"male/claymore"
	.align 2
.LC202:
	.string	"male/rampage"
	.align 2
.LC203:
	.string	"male/flak"
	.align 2
.LC204:
	.string	"male/energy2"
	.align 2
.LC205:
	.string	"male/cipher"
	.align 2
.LC206:
	.string	"male/psycho"
	.align 2
.LC207:
	.string	"male/redspy"
	.align 2
.LC208:
	.string	"%s\\%s"
	.align 2
.LC209:
	.string	"hand"
	.align 2
.LC210:
	.long 0x0
	.align 3
.LC211:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC212:
	.long 0x3f800000
	.align 2
.LC213:
	.long 0x43200000
	.section	".text"
	.align 2
	.globl ClientUserinfoChanged
	.type	 ClientUserinfoChanged,@function
ClientUserinfoChanged:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 27,4
	mr 30,3
	mr 3,27
	bl Info_Validate
	cmpwi 0,3,0
	bc 4,2,.L497
	lis 11,.LC184@ha
	lwz 0,.LC184@l(11)
	la 9,.LC184@l(11)
	lwz 10,4(9)
	lwz 11,8(9)
	lwz 8,12(9)
	stw 0,0(27)
	stw 10,4(27)
	stw 11,8(27)
	stw 8,12(27)
	lhz 7,28(9)
	lwz 0,16(9)
	lwz 11,20(9)
	lwz 10,24(9)
	stw 0,16(27)
	stw 11,20(27)
	stw 10,24(27)
	sth 7,28(27)
.L497:
	lis 4,.LC185@ha
	mr 3,27
	la 4,.LC185@l(4)
	bl Info_ValueForKey
	lwz 9,84(30)
	mr 31,3
	li 5,15
	mr 4,31
	addi 3,9,700
	bl strncpy
	lis 4,.LC21@ha
	mr 3,27
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	lwz 0,908(30)
	lis 9,.LC186@ha
	la 31,.LC186@l(9)
	cmpwi 0,0,3
	bc 4,2,.L498
	lis 9,.LC187@ha
	la 31,.LC187@l(9)
.L498:
	cmpwi 0,0,1
	lwz 11,84(30)
	bc 4,2,.L499
	lwz 0,1804(11)
	cmpwi 0,0,1
	bc 4,2,.L500
	lis 9,.LC188@ha
	la 31,.LC188@l(9)
.L500:
	cmpwi 0,0,2
	bc 4,2,.L501
	lis 9,.LC189@ha
	la 31,.LC189@l(9)
.L501:
	cmpwi 0,0,3
	bc 4,2,.L502
	lis 9,.LC190@ha
	la 31,.LC190@l(9)
.L502:
	cmpwi 0,0,4
	bc 4,2,.L503
	lis 9,.LC191@ha
	la 31,.LC191@l(9)
.L503:
	cmpwi 0,0,5
	bc 4,2,.L504
	lis 9,.LC192@ha
	la 31,.LC192@l(9)
.L504:
	cmpwi 0,0,6
	bc 4,2,.L505
	lis 9,.LC193@ha
	la 31,.LC193@l(9)
.L505:
	cmpwi 0,0,7
	bc 4,2,.L506
	lis 9,.LC194@ha
	la 31,.LC194@l(9)
.L506:
	cmpwi 0,0,8
	bc 4,2,.L507
	lis 9,.LC195@ha
	la 31,.LC195@l(9)
.L507:
	cmpwi 0,0,9
	bc 4,2,.L508
	lis 9,.LC196@ha
	la 31,.LC196@l(9)
.L508:
	cmpwi 0,0,10
	bc 4,2,.L499
	lis 9,.LC197@ha
	la 31,.LC197@l(9)
.L499:
	lwz 0,908(30)
	cmpwi 0,0,2
	bc 4,2,.L510
	lwz 10,1804(11)
	lis 8,.LC198@ha
	la 31,.LC198@l(8)
	cmpwi 0,10,1
	bc 4,2,.L511
	lis 9,.LC199@ha
	la 31,.LC199@l(9)
.L511:
	cmpwi 0,10,2
	bc 4,2,.L512
	lis 9,.LC200@ha
	la 31,.LC200@l(9)
.L512:
	cmpwi 0,10,3
	bc 4,2,.L513
	lis 9,.LC201@ha
	la 31,.LC201@l(9)
.L513:
	cmpwi 0,10,4
	bc 4,2,.L514
	lis 9,.LC202@ha
	la 31,.LC202@l(9)
.L514:
	cmpwi 0,10,5
	bc 4,2,.L515
	lis 9,.LC203@ha
	la 31,.LC203@l(9)
.L515:
	cmpwi 0,10,6
	bc 4,2,.L516
	lis 9,.LC204@ha
	la 31,.LC204@l(9)
.L516:
	xori 11,10,7
	la 9,.LC198@l(8)
	srawi 8,11,31
	cmpwi 0,10,8
	xor 0,8,11
	subf 0,0,8
	srawi 0,0,31
	andc 9,9,0
	and 0,31,0
	or 31,0,9
	bc 4,2,.L518
	lis 9,.LC205@ha
	la 31,.LC205@l(9)
.L518:
	cmpwi 0,10,9
	bc 4,2,.L519
	lis 9,.LC206@ha
	la 31,.LC206@l(9)
.L519:
	cmpwi 0,10,10
	bc 4,2,.L510
	lis 9,.LC207@ha
	la 31,.LC207@l(9)
.L510:
	lwz 0,948(30)
	cmpwi 0,0,1
	mr 11,0
	bc 4,2,.L521
	lwz 0,952(30)
	cmpwi 0,0,1
	bc 4,2,.L522
	lis 9,.LC188@ha
	la 31,.LC188@l(9)
.L522:
	cmpwi 0,0,2
	bc 4,2,.L523
	lis 9,.LC189@ha
	la 31,.LC189@l(9)
.L523:
	cmpwi 0,0,3
	bc 4,2,.L524
	lis 9,.LC190@ha
	la 31,.LC190@l(9)
.L524:
	cmpwi 0,0,4
	bc 4,2,.L525
	lis 9,.LC191@ha
	la 31,.LC191@l(9)
.L525:
	cmpwi 0,0,5
	bc 4,2,.L526
	lis 9,.LC192@ha
	la 31,.LC192@l(9)
.L526:
	cmpwi 0,0,6
	bc 4,2,.L527
	lis 9,.LC193@ha
	la 31,.LC193@l(9)
.L527:
	cmpwi 0,0,7
	bc 4,2,.L528
	lis 9,.LC194@ha
	la 31,.LC194@l(9)
.L528:
	cmpwi 0,0,8
	bc 4,2,.L529
	lis 9,.LC195@ha
	la 31,.LC195@l(9)
.L529:
	cmpwi 0,0,9
	bc 4,2,.L530
	lis 9,.LC196@ha
	la 31,.LC196@l(9)
.L530:
	cmpwi 0,0,10
	bc 4,2,.L521
	lis 9,.LC197@ha
	la 31,.LC197@l(9)
.L521:
	cmpwi 0,11,2
	bc 4,2,.L532
	lwz 0,952(30)
	cmpwi 0,0,1
	bc 4,2,.L533
	lis 9,.LC199@ha
	la 31,.LC199@l(9)
.L533:
	cmpwi 0,0,2
	bc 4,2,.L534
	lis 9,.LC200@ha
	la 31,.LC200@l(9)
.L534:
	cmpwi 0,0,3
	bc 4,2,.L535
	lis 9,.LC201@ha
	la 31,.LC201@l(9)
.L535:
	cmpwi 0,0,4
	bc 4,2,.L536
	lis 9,.LC202@ha
	la 31,.LC202@l(9)
.L536:
	cmpwi 0,0,5
	bc 4,2,.L537
	lis 9,.LC203@ha
	la 31,.LC203@l(9)
.L537:
	cmpwi 0,0,6
	bc 4,2,.L538
	lis 9,.LC204@ha
	la 31,.LC204@l(9)
.L538:
	cmpwi 0,0,7
	bc 4,2,.L539
	lis 9,.LC198@ha
	la 31,.LC198@l(9)
.L539:
	cmpwi 0,0,8
	bc 4,2,.L540
	lis 9,.LC205@ha
	la 31,.LC205@l(9)
.L540:
	cmpwi 0,0,9
	bc 4,2,.L541
	lis 9,.LC206@ha
	la 31,.LC206@l(9)
.L541:
	cmpwi 0,0,10
	bc 4,2,.L532
	lis 9,.LC207@ha
	la 31,.LC207@l(9)
.L532:
	lis 9,g_edicts@ha
	lis 0,0x6f71
	lwz 4,84(30)
	lwz 29,g_edicts@l(9)
	ori 0,0,56853
	lis 28,gi@ha
	lis 3,.LC208@ha
	la 28,gi@l(28)
	subf 29,29,30
	addi 4,4,700
	mullw 29,29,0
	mr 5,31
	la 3,.LC208@l(3)
	srawi 29,29,2
	addi 29,29,1311
	crxor 6,6,6
	bl va
	lwz 0,24(28)
	mr 4,3
	mr 3,29
	mtlr 0
	blrl
	lis 11,deathmatch@ha
	lis 8,.LC210@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC210@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L543
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 9,11,32768
	bc 12,2,.L543
	lwz 9,84(30)
	b .L549
.L543:
	lis 4,.LC169@ha
	mr 3,27
	la 4,.LC169@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	lwz 11,84(30)
	stw 3,20(1)
	lis 0,0x4330
	lis 8,.LC211@ha
	stw 0,16(1)
	la 8,.LC211@l(8)
	lis 10,.LC212@ha
	lfd 0,16(1)
	la 10,.LC212@l(10)
	lfd 13,0(8)
	lfs 12,0(10)
	fsub 0,0,13
	frsp 0,0
	stfs 0,112(11)
	lwz 9,84(30)
	lfs 0,112(9)
	fcmpu 0,0,12
	bc 4,0,.L545
.L549:
	lis 0,0x42b4
	stw 0,112(9)
	b .L544
.L545:
	lis 11,.LC213@ha
	la 11,.LC213@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L544
	stfs 13,112(9)
.L544:
	lis 4,.LC209@ha
	mr 3,27
	la 4,.LC209@l(4)
	bl Info_ValueForKey
	mr 31,3
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L548
	mr 3,31
	bl atoi
	lwz 9,84(30)
	stw 3,716(9)
.L548:
	lwz 3,84(30)
	mr 4,27
	li 5,511
	addi 3,3,188
	bl strncpy
	mr 3,30
	bl ShowGun
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe16:
	.size	 ClientUserinfoChanged,.Lfe16-ClientUserinfoChanged
	.section	".rodata"
	.align 2
.LC214:
	.string	"ip"
	.align 2
.LC215:
	.string	"password"
	.align 2
.LC216:
	.string	"%s connected\n"
	.section	".text"
	.align 2
	.globl ClientConnect
	.type	 ClientConnect,@function
ClientConnect:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 30,4
	mr 31,3
	lis 4,.LC214@ha
	mr 3,30
	la 4,.LC214@l(4)
	bl Info_ValueForKey
	lis 4,.LC215@ha
	mr 3,30
	la 4,.LC215@l(4)
	bl Info_ValueForKey
	lis 9,password@ha
	mr 4,3
	lwz 11,password@l(9)
	lwz 3,4(11)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L551
	li 3,0
	b .L557
.L551:
	lis 11,g_edicts@ha
	lis 0,0x6f71
	lwz 9,g_edicts@l(11)
	ori 0,0,56853
	li 10,4
	lis 11,game@ha
	subf 9,9,31
	la 27,game@l(11)
	mullw 9,9,0
	lwz 11,1028(27)
	srawi 9,9,2
	mulli 9,9,3960
	addi 9,9,-3960
	add 11,11,9
	stw 11,84(31)
	stw 10,1804(11)
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 4,2,.L552
	lwz 28,84(31)
	li 4,0
	li 5,1712
	addi 29,28,1872
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,29
	lwz 0,level@l(9)
	addi 4,28,188
	li 5,1684
	stw 0,3556(28)
	crxor 6,6,6
	bl memcpy
	lwz 0,1560(27)
	cmpwi 0,0,0
	bc 12,2,.L555
	lwz 9,84(31)
	lwz 0,1848(9)
	cmpwi 0,0,0
	bc 4,2,.L552
.L555:
	lwz 3,84(31)
	mr 4,31
	bl InitClientPersistant
.L552:
	mr 4,30
	mr 3,31
	bl ClientUserinfoChanged
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L556
	lis 9,gi+4@ha
	lwz 4,84(31)
	lis 3,.LC216@ha
	lwz 0,gi+4@l(9)
	la 3,.LC216@l(3)
	addi 4,4,700
	mtlr 0
	crxor 6,6,6
	blrl
.L556:
	lwz 9,84(31)
	li 0,1
	li 3,1
	stw 0,720(9)
.L557:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 ClientConnect,.Lfe17-ClientConnect
	.section	".rodata"
	.align 2
.LC217:
	.string	"%s disconnected\n"
	.align 2
.LC218:
	.string	"disconnected"
	.section	".text"
	.align 2
	.globl ClientDisconnect
	.type	 ClientDisconnect,@function
ClientDisconnect:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L558
	lwz 0,908(31)
	cmpwi 0,0,1
	bc 4,2,.L560
	lis 11,level@ha
	la 11,level@l(11)
	lwz 9,352(11)
	addi 9,9,-1
	stw 9,352(11)
.L560:
	lwz 0,908(31)
	cmpwi 0,0,2
	bc 4,2,.L561
	lis 11,level@ha
	la 11,level@l(11)
	lwz 9,356(11)
	addi 9,9,-1
	stw 9,356(11)
.L561:
	lwz 0,908(31)
	cmpwi 0,0,3
	bc 4,2,.L562
	lis 11,level@ha
	la 11,level@l(11)
	lwz 9,360(11)
	addi 9,9,-1
	stw 9,360(11)
.L562:
	lis 29,gi@ha
	lwz 5,84(31)
	lis 4,.LC217@ha
	lwz 9,gi@l(29)
	li 3,2
	la 4,.LC217@l(4)
	addi 5,5,700
	la 29,gi@l(29)
	mtlr 9
	li 28,0
	lis 26,g_edicts@ha
	lis 27,0x6f71
	ori 27,27,56853
	crxor 6,6,6
	blrl
	lwz 3,84(31)
	li 5,1684
	li 4,0
	addi 3,3,188
	crxor 6,6,6
	bl memset
	lwz 11,84(31)
	li 3,1
	stw 28,908(31)
	stw 28,1804(11)
	lwz 9,84(31)
	stw 28,1820(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 3,g_edicts@l(26)
	lwz 9,104(29)
	subf 3,3,31
	mullw 3,3,27
	mtlr 9
	srawi 3,3,2
	blrl
	lwz 9,100(29)
	li 3,10
	mtlr 9
	blrl
	lwz 9,88(29)
	li 4,2
	addi 3,31,4
	mtlr 9
	blrl
	lwz 9,76(29)
	mr 3,31
	mtlr 9
	blrl
	lwz 3,g_edicts@l(26)
	lis 9,.LC218@ha
	lis 4,.LC24@ha
	la 9,.LC218@l(9)
	lwz 11,84(31)
	la 4,.LC24@l(4)
	stw 9,284(31)
	subf 3,3,31
	stw 28,40(31)
	mullw 3,3,27
	stw 28,248(31)
	stw 28,88(31)
	srawi 3,3,2
	stw 28,720(11)
	addi 3,3,1311
	lwz 0,24(29)
	mtlr 0
	blrl
.L558:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 ClientDisconnect,.Lfe18-ClientDisconnect
	.section	".rodata"
	.align 2
.LC219:
	.string	"sv %3i:%i %i\n"
	.align 2
.LC224:
	.string	"*jump1.wav"
	.align 3
.LC220:
	.long 0x3fc99999
	.long 0x9999999a
	.align 3
.LC221:
	.long 0x3fe33333
	.long 0x33333333
	.align 3
.LC222:
	.long 0x3fd99999
	.long 0x9999999a
	.align 3
.LC223:
	.long 0x3f768000
	.long 0x0
	.align 2
.LC225:
	.long 0xc2700000
	.align 3
.LC226:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC227:
	.long 0x3fec0000
	.long 0x0
	.align 3
.LC228:
	.long 0x3fe80000
	.long 0x0
	.align 3
.LC229:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC230:
	.long 0x43960000
	.align 2
.LC231:
	.long 0xc3960000
	.align 2
.LC232:
	.long 0x43480000
	.align 2
.LC233:
	.long 0x44160000
	.align 2
.LC234:
	.long 0x0
	.align 3
.LC235:
	.long 0x40140000
	.long 0x0
	.align 2
.LC236:
	.long 0x41000000
	.align 3
.LC237:
	.long 0x3fc00000
	.long 0x0
	.align 2
.LC238:
	.long 0x3f800000
	.align 2
.LC239:
	.long 0x42480000
	.align 2
.LC240:
	.long 0xc2480000
	.section	".text"
	.align 2
	.globl ClientThink
	.type	 ClientThink,@function
ClientThink:
	stwu 1,-416(1)
	mflr 0
	stfd 30,400(1)
	stfd 31,408(1)
	stmw 22,360(1)
	stw 0,420(1)
	mr 31,3
	mr 30,4
	lwz 0,912(31)
	cmpwi 0,0,1
	bc 4,2,.L586
	lwz 0,264(31)
	cmpwi 0,0,4
	bc 4,2,.L586
	li 0,0
	stw 0,912(31)
.L586:
	lwz 11,84(31)
	lwz 9,1868(11)
	lwz 0,1804(11)
	subfic 11,9,0
	adde 9,11,9
	subfic 11,0,0
	adde 0,11,0
	and. 11,0,9
	bc 12,2,.L588
	mr 3,31
	crxor 6,6,6
	bl Toggle_Classes
.L588:
	lwz 0,764(31)
	cmpwi 0,0,2
	bc 12,2,.L590
	lis 8,dmflags@ha
	lwz 7,84(31)
	lwz 11,dmflags@l(8)
	lwz 10,1804(7)
	lfs 0,20(11)
	srawi 0,10,31
	subf 0,10,0
	srwi 0,0,31
	fctiwz 13,0
	stfd 13,352(1)
	lwz 9,356(1)
	xoris 9,9,0x4
	rlwinm 9,9,14,31,31
	and. 11,0,9
	bc 12,2,.L590
	lwz 0,828(31)
	cmpwi 0,0,0
	bc 4,2,.L593
	lwz 0,964(31)
	cmpwi 0,0,0
	bc 12,2,.L590
.L593:
	lis 9,.LC225@ha
	lfs 13,628(31)
	la 9,.LC225@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,1,.L595
	lwz 0,964(31)
	cmpwi 0,0,0
	bc 12,2,.L595
	lwz 0,1844(7)
	cmpwi 0,0,5
	bc 4,2,.L590
.L595:
	lwz 3,84(31)
	lis 27,0x4330
	lis 9,.LC226@ha
	addi 29,1,280
	lwz 0,1844(3)
	la 9,.LC226@l(9)
	addi 28,1,296
	lfd 31,0(9)
	addi 26,1,312
	li 24,0
	xoris 0,0,0x8000
	lis 9,.LC220@ha
	stw 24,256(1)
	stw 0,356(1)
	addi 25,1,264
	mr 5,28
	stw 27,352(1)
	mr 6,26
	addi 3,3,3752
	lfd 0,352(1)
	mr 4,29
	lfd 13,.LC220@l(9)
	stw 24,252(1)
	fsub 0,0,31
	stw 24,248(1)
	fmul 0,0,13
	frsp 30,0
	bl AngleVectors
	lha 0,8(30)
	mr 3,29
	mr 4,25
	xoris 0,0,0x8000
	stw 0,356(1)
	stw 27,352(1)
	lfd 1,352(1)
	fsub 1,1,31
	frsp 1,1
	fmuls 1,1,30
	bl VectorScale
	lfs 9,248(1)
	mr 4,29
	mr 6,26
	lfs 11,252(1)
	mr 5,28
	lfs 10,256(1)
	lfs 0,264(1)
	lfs 13,268(1)
	lfs 12,272(1)
	fadds 0,0,9
	lwz 3,84(31)
	fadds 13,13,11
	fadds 12,12,10
	addi 3,3,3752
	stfs 0,248(1)
	stfs 13,252(1)
	stfs 12,256(1)
	bl AngleVectors
	lha 0,10(30)
	mr 3,28
	mr 4,25
	xoris 0,0,0x8000
	stw 0,356(1)
	stw 27,352(1)
	lfd 1,352(1)
	fsub 1,1,31
	frsp 1,1
	fmuls 1,1,30
	bl VectorScale
	lfs 11,248(1)
	lfs 10,252(1)
	lfs 9,256(1)
	lfs 0,264(1)
	lfs 13,268(1)
	lfs 12,272(1)
	lwz 0,964(31)
	fadds 0,0,11
	fadds 13,13,10
	fadds 12,12,9
	cmpwi 0,0,0
	stfs 0,248(1)
	stfs 13,252(1)
	stfs 12,256(1)
	bc 4,2,.L596
	stw 24,256(1)
.L596:
	lwz 0,964(31)
	cmpwi 0,0,1
	bc 4,2,.L597
	lfs 12,248(1)
	lis 9,.LC227@ha
	fmr 10,30
	lfs 0,252(1)
	la 9,.LC227@l(9)
	lfs 13,256(1)
	lfd 11,0(9)
	b .L667
.L597:
	cmpwi 0,0,2
	bc 4,2,.L599
	lfs 12,248(1)
	lis 11,.LC228@ha
	fmr 10,30
	lfs 0,252(1)
	la 11,.LC228@l(11)
	lfs 13,256(1)
	lfd 11,0(11)
.L667:
	fmul 12,12,11
	fmul 0,0,11
	fmul 13,13,11
	fmul 10,10,11
	frsp 12,12
	frsp 0,0
	frsp 13,13
	stfs 12,248(1)
	frsp 30,10
	stfs 0,252(1)
	stfs 13,256(1)
	b .L598
.L599:
	cmpwi 0,0,3
	bc 4,2,.L598
	lfs 11,248(1)
	lis 9,.LC221@ha
	fmr 10,30
	lfs 13,252(1)
	lfs 12,256(1)
	lfd 0,.LC221@l(9)
	fmul 11,11,0
	fmul 13,13,0
	fmul 12,12,0
	fmul 10,10,0
	frsp 11,11
	frsp 13,13
	frsp 12,12
	frsp 30,10
	stfs 11,248(1)
	stfs 13,252(1)
	stfs 12,256(1)
.L598:
	lwz 9,84(31)
	lbz 0,16(9)
	andi. 9,0,1
	bc 12,2,.L602
	lfs 12,248(1)
	lis 11,.LC229@ha
	fmr 10,30
	lfs 0,252(1)
	la 11,.LC229@l(11)
	lfs 13,256(1)
	lfd 11,0(11)
	fmul 12,12,11
	fmul 0,0,11
	fmul 13,13,11
	fmul 10,10,11
	frsp 12,12
	frsp 0,0
	frsp 13,13
	frsp 30,10
	stfs 12,248(1)
	stfs 0,252(1)
	stfs 13,256(1)
.L602:
	lwz 0,828(31)
	cmpwi 0,0,0
	bc 4,2,.L668
	lwz 0,964(31)
	cmpwi 0,0,0
	bc 12,2,.L604
.L668:
	lfs 0,248(1)
	lfs 13,252(1)
	lfs 12,256(1)
	lfs 11,620(31)
	lfs 10,624(31)
	lfs 9,628(31)
	fadds 0,0,11
	fadds 13,13,10
	fadds 12,12,9
	stfs 0,620(31)
	stfs 13,624(31)
	stfs 12,628(31)
.L604:
	lwz 0,828(31)
	cmpwi 0,0,0
	bc 4,2,.L669
	lwz 0,964(31)
	cmpwi 0,0,0
	bc 12,2,.L608
.L669:
	lfs 0,620(31)
	li 0,0
	lfs 13,624(31)
	stw 0,256(1)
	stfs 0,248(1)
	stfs 13,252(1)
	b .L607
.L608:
	li 0,0
	stw 0,256(1)
	stw 0,248(1)
	stw 0,252(1)
.L607:
	lwz 0,964(31)
	cmpwi 0,0,3
	bc 4,2,.L610
	lfs 0,628(31)
	stfs 0,256(1)
.L610:
	addi 3,1,248
	bl VectorLength
	lis 9,.LC230@ha
	la 9,.LC230@l(9)
	lfs 0,0(9)
	fmuls 13,30,0
	fcmpu 0,1,13
	bc 12,1,.L612
	lis 11,.LC231@ha
	la 11,.LC231@l(11)
	lfs 0,0(11)
	fmuls 0,30,0
	fcmpu 0,1,0
	bc 4,0,.L611
.L612:
	fdivs 1,13,1
	addi 3,31,620
	mr 4,3
	bl VectorScale
.L611:
	lwz 0,964(31)
	cmpwi 0,0,1
	bc 4,2,.L613
	lis 9,.LC232@ha
	lfs 0,628(31)
	la 9,.LC232@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L613
	stfs 13,628(31)
.L613:
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,1
	bc 4,2,.L590
	lis 11,.LC233@ha
	lfs 0,628(31)
	la 11,.LC233@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L590
	stfs 13,628(31)
.L590:
	lis 9,level@ha
	lis 11,.LC234@ha
	la 9,level@l(9)
	la 11,.LC234@l(11)
	lfs 13,0(11)
	lfs 0,200(9)
	stw 31,292(9)
	lwz 28,84(31)
	fcmpu 0,0,13
	bc 12,2,.L617
	li 0,4
	lis 11,.LC235@ha
	stw 0,0(28)
	la 11,.LC235@l(11)
	lfs 0,200(9)
	lfd 12,0(11)
	lfs 13,4(9)
	fadd 0,0,12
	fcmpu 0,13,0
	bc 4,1,.L585
	lbz 0,1(30)
	andi. 11,0,128
	bc 12,2,.L585
	li 0,1
	stw 0,208(9)
	b .L585
.L617:
	addi 3,1,8
	lis 9,pm_passent@ha
	mr 29,3
	stw 31,pm_passent@l(9)
	li 4,0
	li 5,240
	crxor 6,6,6
	bl memset
	lwz 0,264(31)
	cmpwi 0,0,1
	bc 12,2,.L623
	lwz 0,40(31)
	cmpwi 0,0,255
	li 0,3
	bc 4,2,.L623
	lwz 0,764(31)
	cmpwi 0,0,0
	bc 12,2,.L623
	li 0,2
.L623:
	stw 0,0(28)
	lis 11,sv_gravity@ha
	lwz 11,sv_gravity@l(11)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,352(1)
	lwz 9,356(1)
	sth 9,18(28)
	lwz 0,268(31)
	andi. 9,0,8192
	bc 12,2,.L625
	lfs 0,20(11)
	lis 11,.LC222@ha
	lfd 12,.LC222@l(11)
	fmul 0,0,12
	fctiwz 13,0
	stfd 13,352(1)
	lwz 9,356(1)
	sth 9,18(28)
.L625:
	lwz 0,0(28)
	addi 23,31,620
	addi 25,1,12
	lwz 9,4(28)
	addi 22,31,4
	addi 24,1,18
	lwz 11,8(28)
	mr 3,25
	mr 5,22
	lwz 10,12(28)
	mr 4,24
	mr 6,23
	stw 0,8(1)
	addi 27,28,3584
	addi 26,1,36
	stw 9,4(29)
	li 7,0
	li 8,0
	stw 11,8(29)
	lis 9,.LC236@ha
	la 9,.LC236@l(9)
	li 11,3
	stw 10,12(29)
	lfs 10,0(9)
	mtctr 11
	lwz 0,16(28)
	lwz 9,20(28)
	lwz 11,24(28)
	stw 0,16(29)
	stw 9,20(29)
	stw 11,24(29)
.L666:
	lfsx 13,7,5
	lfsx 0,7,6
	mr 9,11
	addi 7,7,4
	fmuls 13,13,10
	fmuls 0,0,10
	fctiwz 12,13
	fctiwz 11,0
	stfd 12,352(1)
	lwz 11,356(1)
	stfd 11,352(1)
	lwz 9,356(1)
	sthx 11,8,3
	sthx 9,8,4
	addi 8,8,2
	bdnz .L666
	mr 3,27
	addi 4,1,8
	li 5,28
	bl memcmp
	cmpwi 0,3,0
	bc 12,2,.L631
	li 0,1
	stw 0,52(1)
.L631:
	lis 9,gi@ha
	lwz 7,0(30)
	addi 3,1,8
	la 9,gi@l(9)
	lwz 6,4(30)
	lis 11,PM_trace@ha
	lwz 5,84(9)
	la 11,PM_trace@l(11)
	lwz 8,8(30)
	lwz 0,12(30)
	mtlr 5
	stw 7,36(1)
	lwz 10,52(9)
	stw 0,12(26)
	stw 6,4(26)
	stw 8,8(26)
	stw 11,240(1)
	stw 10,244(1)
	blrl
	lis 9,.LC226@ha
	lwz 11,8(1)
	mr 26,25
	la 9,.LC226@l(9)
	lwz 10,4(29)
	mr 3,23
	lfd 11,0(9)
	mr 4,24
	mr 5,22
	lis 9,.LC237@ha
	lwz 0,8(29)
	lis 6,0x4330
	la 9,.LC237@l(9)
	li 7,0
	lfd 12,0(9)
	li 8,0
	lwz 9,12(29)
	stw 11,0(28)
	li 11,3
	stw 10,4(28)
	stw 0,8(28)
	mtctr 11
	stw 9,12(28)
	lwz 0,16(29)
	lwz 9,20(29)
	lwz 11,24(29)
	stw 0,16(28)
	stw 9,20(28)
	stw 11,24(28)
	lwz 0,8(1)
	lwz 9,4(29)
	lwz 11,8(29)
	lwz 10,12(29)
	stw 0,3584(28)
	stw 9,4(27)
	stw 11,8(27)
	stw 10,12(27)
	lwz 0,24(29)
	lwz 9,16(29)
	lwz 11,20(29)
	stw 0,24(27)
	stw 9,16(27)
	stw 11,20(27)
.L665:
	lhax 0,7,26
	lhax 9,7,4
	mr 10,11
	xoris 0,0,0x8000
	addi 7,7,2
	stw 0,356(1)
	xoris 9,9,0x8000
	stw 6,352(1)
	lfd 13,352(1)
	stw 9,356(1)
	stw 6,352(1)
	lfd 0,352(1)
	fsub 13,13,11
	fsub 0,0,11
	fmul 13,13,12
	fmul 0,0,12
	frsp 13,13
	frsp 0,0
	stfsx 13,8,5
	stfsx 0,8,3
	addi 8,8,4
	bdnz .L665
	lfs 0,216(1)
	mr 9,11
	lis 8,0x4330
	lfs 13,220(1)
	lis 11,.LC226@ha
	lis 7,.LC223@ha
	lfs 8,204(1)
	la 11,.LC226@l(11)
	lfs 9,208(1)
	lfs 10,212(1)
	lfs 11,224(1)
	stfs 0,200(31)
	stfs 13,204(31)
	stfs 8,188(31)
	stfs 9,192(31)
	stfs 10,196(31)
	stfs 11,208(31)
	lha 0,2(30)
	lfd 12,0(11)
	xoris 0,0,0x8000
	lfd 13,.LC223@l(7)
	stw 0,356(1)
	mr 10,11
	stw 8,352(1)
	lfd 0,352(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3564(28)
	lha 0,4(30)
	xoris 0,0,0x8000
	stw 0,356(1)
	stw 8,352(1)
	lfd 0,352(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3568(28)
	lha 0,6(30)
	xoris 0,0,0x8000
	stw 0,356(1)
	stw 8,352(1)
	lfd 0,352(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3572(28)
	lwz 0,828(31)
	cmpwi 0,0,0
	bc 12,2,.L637
	lwz 0,228(1)
	cmpwi 0,0,0
	bc 4,2,.L637
	lha 0,48(1)
	cmpwi 0,0,9
	bc 4,1,.L637
	lwz 0,236(1)
	cmpwi 0,0,0
	bc 4,2,.L637
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,8
	bc 12,2,.L638
	lis 29,gi@ha
	lis 3,.LC224@ha
	la 29,gi@l(29)
	la 3,.LC224@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC238@ha
	lwz 0,16(29)
	lis 11,.LC238@ha
	la 9,.LC238@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC238@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC234@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC234@l(9)
	lfs 3,0(9)
	blrl
.L638:
	mr 4,22
	mr 3,31
	li 5,0
	bl PlayerNoise
.L637:
	lfs 0,200(1)
	lwz 10,228(1)
	lwz 0,236(1)
	lwz 11,232(1)
	cmpwi 0,10,0
	stw 0,964(31)
	stw 11,960(31)
	fctiwz 13,0
	stw 10,828(31)
	stfd 13,352(1)
	lwz 9,356(1)
	stw 9,784(31)
	bc 12,2,.L639
	lwz 0,92(10)
	stw 0,832(31)
.L639:
	lwz 0,764(31)
	cmpwi 0,0,0
	bc 12,2,.L640
	lfs 0,3680(28)
	lis 0,0x4220
	lis 9,0xc170
	stw 0,36(28)
	stw 9,28(28)
	stfs 0,32(28)
	b .L641
.L640:
	lfs 0,188(1)
	stfs 0,3752(28)
	lfs 13,192(1)
	stfs 13,3756(28)
	lfs 0,196(1)
	stfs 0,3760(28)
	lfs 13,188(1)
	stfs 13,28(28)
	lfs 0,192(1)
	stfs 0,32(28)
	lfs 13,196(1)
	stfs 13,36(28)
	lha 0,8(30)
	cmpwi 0,0,0
	bc 4,2,.L643
	lha 0,10(30)
	cmpwi 0,0,0
	bc 12,2,.L642
	lwz 0,184(31)
	andi. 9,0,1
	bc 12,2,.L642
.L643:
	lis 11,.LC239@ha
	lfs 0,624(31)
	la 11,.LC239@l(11)
	lfs 12,0(11)
	fcmpu 0,0,12
	bc 12,1,.L645
	lis 9,.LC240@ha
	la 9,.LC240@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L645
	lfs 0,620(31)
	fcmpu 0,0,12
	bc 12,1,.L645
	fcmpu 0,0,13
	bc 4,0,.L642
.L645:
	lwz 0,184(31)
	li 11,0
	lwz 9,84(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	stw 11,1812(9)
.L642:
	lwz 9,84(31)
	lwz 0,3792(9)
	cmpwi 0,0,2
	bc 4,2,.L646
	mr 3,31
	mr 4,30
	crxor 6,6,6
	bl Turret_Cmd
.L646:
	lfs 0,4(31)
	lwz 9,84(31)
	stfs 0,3764(9)
	lfs 0,8(31)
	lwz 11,84(31)
	stfs 0,3768(11)
	lfs 0,12(31)
	lwz 9,84(31)
	stfs 0,3772(9)
.L641:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,264(31)
	cmpwi 0,0,1
	bc 12,2,.L647
	mr 3,31
	bl G_TouchTriggers
.L647:
	lwz 0,56(1)
	li 11,0
	cmpw 0,11,0
	bc 4,0,.L649
	addi 29,1,60
.L651:
	li 10,0
	slwi 0,11,2
	cmpw 0,10,11
	lwzx 3,29,0
	addi 27,11,1
	bc 4,0,.L653
	lwz 0,0(29)
	cmpw 0,0,3
	bc 12,2,.L653
	mr 9,29
.L654:
	addi 10,10,1
	cmpw 0,10,11
	bc 4,0,.L653
	lwzu 0,4(9)
	cmpw 0,0,3
	bc 4,2,.L654
.L653:
	cmpw 0,10,11
	bc 4,2,.L650
	lwz 0,688(3)
	cmpwi 0,0,0
	bc 12,2,.L650
	mr 4,31
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L650:
	lwz 0,56(1)
	mr 11,27
	cmpw 0,11,0
	bc 12,0,.L651
.L649:
	lwz 0,3632(28)
	lwz 11,3640(28)
	stw 0,3636(28)
	lbz 9,1(30)
	andc 0,9,0
	stw 9,3632(28)
	or 11,11,0
	stw 11,3640(28)
	lbz 0,15(30)
	stw 0,992(31)
	lwz 9,3640(28)
	andi. 0,9,1
	bc 12,2,.L661
	lwz 0,3644(28)
	cmpwi 0,0,0
	bc 4,2,.L661
	li 0,1
	mr 3,31
	stw 0,3644(28)
	bl Think_Weapon
.L661:
	lis 11,level@ha
	lwz 8,84(31)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC226@ha
	lfs 12,3920(8)
	xoris 0,0,0x8000
	la 11,.LC226@l(11)
	stw 0,356(1)
	stw 10,352(1)
	lfd 13,0(11)
	lfd 0,352(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	cror 3,2,0
	bc 4,3,.L663
	lwz 0,3916(8)
	andi. 9,0,1
	bc 12,2,.L663
	mr 3,31
	crxor 6,6,6
	bl Kamikaze_Explode
.L663:
	lwz 0,3928(28)
	cmpwi 0,0,0
	bc 12,2,.L585
	lis 9,level+4@ha
	lfs 13,3944(28)
	lfs 0,level+4@l(9)
	fcmpu 0,0,13
	bc 4,1,.L585
	li 0,0
	mr 3,31
	stw 0,3928(28)
	bl Think_Airstrike
.L585:
	lwz 0,420(1)
	mtlr 0
	lmw 22,360(1)
	lfd 30,400(1)
	lfd 31,408(1)
	la 1,416(1)
	blr
.Lfe19:
	.size	 ClientThink,.Lfe19-ClientThink
	.section	".rodata"
	.align 2
.LC241:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientBeginServerFrame
	.type	 ClientBeginServerFrame,@function
ClientBeginServerFrame:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 11,.LC241@ha
	lis 9,level+200@ha
	la 11,.LC241@l(11)
	lfs 0,level+200@l(9)
	mr 31,3
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L670
	lwz 30,84(31)
	lwz 0,3644(30)
	cmpwi 0,0,0
	bc 4,2,.L672
	bl Think_Weapon
	b .L673
.L672:
	li 0,0
	stw 0,3644(30)
.L673:
	lwz 0,764(31)
	cmpwi 0,0,0
	bc 12,2,.L674
	lis 9,level+4@ha
	lfs 13,3912(30)
	lfs 0,level+4@l(9)
	fcmpu 0,0,13
	bc 4,1,.L670
	lis 9,.LC241@ha
	lis 11,deathmatch@ha
	lwz 10,3640(30)
	la 9,.LC241@l(9)
	lfs 12,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 7,0,12
	mfcr 0
	rlwinm 0,0,31,1
	neg 0,0
	ori 0,0,1
	and. 11,10,0
	bc 4,2,.L679
	bc 12,30,.L670
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1024
	bc 12,2,.L670
.L679:
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,0
	bc 12,2,.L680
	bc 4,30,.L680
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L681
.L680:
	mr 3,31
	bl CopyToBodyQue
	mr 3,31
	bl PutClientInServer
	lwz 7,84(31)
	li 0,6
	li 11,32
	stw 0,80(31)
	li 10,14
	lis 8,level+4@ha
	stb 11,16(7)
	lwz 9,84(31)
	stb 10,17(9)
	lfs 0,level+4@l(8)
	lwz 11,84(31)
	stfs 0,3912(11)
	b .L683
.L681:
	lis 9,gi+168@ha
	lis 3,.LC164@ha
	lwz 0,gi+168@l(9)
	la 3,.LC164@l(3)
	mtlr 0
	blrl
	b .L685
.L674:
	lis 9,.LC241@ha
	lis 11,deathmatch@ha
	la 9,.LC241@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L683
	bl PlayerTrail_LastSpot
	mr 4,3
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L683
	addi 3,31,28
	bl PlayerTrail_Add
.L685:
.L683:
	li 0,0
	stw 0,3640(30)
.L670:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 ClientBeginServerFrame,.Lfe20-ClientBeginServerFrame
	.section	".rodata"
	.align 2
.LC242:
	.long 0x0
	.section	".text"
	.align 2
	.globl respawn
	.type	 respawn,@function
respawn:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,0
	bc 12,2,.L439
	lis 11,.LC242@ha
	lis 9,deathmatch@ha
	la 11,.LC242@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L439
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L438
.L439:
	mr 3,31
	bl CopyToBodyQue
	mr 3,31
	bl PutClientInServer
	lwz 7,84(31)
	li 0,6
	li 11,32
	stw 0,80(31)
	li 10,14
	lis 8,level+4@ha
	stb 11,16(7)
	lwz 9,84(31)
	stb 10,17(9)
	lfs 0,level+4@l(8)
	lwz 11,84(31)
	stfs 0,3912(11)
	b .L437
.L438:
	lis 9,gi+168@ha
	lis 3,.LC164@ha
	lwz 0,gi+168@l(9)
	la 3,.LC164@l(3)
	mtlr 0
	blrl
.L437:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe21:
	.size	 respawn,.Lfe21-respawn
	.align 2
	.globl InitClientResp
	.type	 InitClientResp,@function
InitClientResp:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 4,0
	addi 28,29,1872
	li 5,1712
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,28
	lwz 0,level@l(9)
	addi 4,29,188
	li 5,1684
	stw 0,3556(29)
	crxor 6,6,6
	bl memcpy
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe22:
	.size	 InitClientResp,.Lfe22-InitClientResp
	.align 2
	.globl InitBodyQue
	.type	 InitBodyQue,@function
InitBodyQue:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,level+296@ha
	li 0,0
	lis 11,.LC163@ha
	stw 0,level+296@l(9)
	li 31,8
	la 30,.LC163@l(11)
.L427:
	bl G_Spawn
	addic. 31,31,-1
	stw 30,284(3)
	bc 4,2,.L427
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe23:
	.size	 InitBodyQue,.Lfe23-InitBodyQue
	.align 2
	.globl player_pain
	.type	 player_pain,@function
player_pain:
	blr
.Lfe24:
	.size	 player_pain,.Lfe24-player_pain
	.section	".rodata"
	.align 2
.LC243:
	.long 0x0
	.section	".text"
	.align 2
	.globl SaveClientData
	.type	 SaveClientData,@function
SaveClientData:
	lis 9,game@ha
	li 6,0
	la 8,game@l(9)
	lwz 0,1544(8)
	cmpw 0,6,0
	bclr 4,0
	lis 9,g_edicts@ha
	lis 11,coop@ha
	lwz 10,g_edicts@l(9)
	mr 3,8
	lis 4,game@ha
	lis 9,.LC243@ha
	lwz 5,coop@l(11)
	li 7,0
	la 9,.LC243@l(9)
	addi 10,10,1268
	lfs 13,0(9)
.L231:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L230
	la 8,game@l(4)
	lwz 0,728(10)
	lwz 9,1028(8)
	add 9,7,9
	stw 0,732(9)
	lwz 11,1028(8)
	lwz 0,756(10)
	add 11,7,11
	stw 0,736(11)
	lwz 9,1028(8)
	lwz 0,268(10)
	add 9,7,9
	rlwinm 0,0,0,19,19
	stw 0,740(9)
	lfs 0,20(5)
	fcmpu 0,0,13
	bc 12,2,.L230
	lwz 9,84(10)
	lwz 11,1028(8)
	lwz 0,3560(9)
	add 11,7,11
	stw 0,1860(11)
.L230:
	lwz 0,1544(3)
	addi 6,6,1
	addi 7,7,3960
	addi 10,10,1268
	cmpw 0,6,0
	bc 12,0,.L231
	blr
.Lfe25:
	.size	 SaveClientData,.Lfe25-SaveClientData
	.section	".rodata"
	.align 2
.LC244:
	.long 0x0
	.section	".text"
	.align 2
	.globl FetchClientEntData
	.type	 FetchClientEntData,@function
FetchClientEntData:
	lwz 11,84(3)
	lwz 0,732(11)
	stw 0,728(3)
	lwz 9,736(11)
	stw 9,756(3)
	lwz 0,740(11)
	cmpwi 0,0,0
	bc 12,2,.L236
	lwz 0,268(3)
	ori 0,0,4096
	stw 0,268(3)
.L236:
	lis 9,.LC244@ha
	lis 11,coop@ha
	la 9,.LC244@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bclr 12,2
	lwz 9,84(3)
	lwz 0,1860(9)
	stw 0,3560(9)
	blr
.Lfe26:
	.size	 FetchClientEntData,.Lfe26-FetchClientEntData
	.section	".rodata"
	.align 2
.LC245:
	.long 0x43c00000
	.section	".text"
	.align 2
	.type	 SP_FixCoopSpots,@function
SP_FixCoopSpots:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	lis 9,.LC245@ha
	mr 30,3
	la 9,.LC245@l(9)
	li 31,0
	lfs 31,0(9)
	lis 29,.LC0@ha
.L9:
	mr 3,31
	li 4,284
	la 5,.LC0@l(29)
	bl G_Find
	mr. 31,3
	bc 12,2,.L6
	lwz 0,536(31)
	cmpwi 0,0,0
	bc 12,2,.L9
	lfs 0,4(31)
	addi 3,1,8
	lfs 13,4(30)
	lfs 12,8(30)
	lfs 11,12(30)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(31)
	fsubs 12,12,0
	stfs 12,12(1)
	lfs 0,12(31)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 4,0,.L9
	lwz 3,536(30)
	cmpwi 0,3,0
	bc 12,2,.L14
	lwz 4,536(31)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L6
.L14:
	lwz 0,536(31)
	stw 0,536(30)
.L6:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe27:
	.size	 SP_FixCoopSpots,.Lfe27-SP_FixCoopSpots
	.section	".rodata"
	.align 3
.LC246:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC247:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_player_start
	.type	 SP_info_player_start,@function
SP_info_player_start:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC247@ha
	lis 9,coop@ha
	la 11,.LC247@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L18
	lis 3,level+72@ha
	lis 4,.LC1@ha
	la 3,level+72@l(3)
	la 4,.LC1@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L18
	lis 9,SP_CreateCoopSpots@ha
	lis 10,level+4@ha
	la 9,SP_CreateCoopSpots@l(9)
	lis 11,.LC246@ha
	stw 9,680(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC246@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
.L18:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe28:
	.size	 SP_info_player_start,.Lfe28-SP_info_player_start
	.section	".rodata"
	.align 2
.LC248:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_player_deathmatch
	.type	 SP_info_player_deathmatch,@function
SP_info_player_deathmatch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC248@ha
	lis 9,deathmatch@ha
	la 11,.LC248@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L22
	bl G_FreeEdict
.L22:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe29:
	.size	 SP_info_player_deathmatch,.Lfe29-SP_info_player_deathmatch
	.section	".rodata"
	.align 2
.LC249:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_player_team1
	.type	 SP_info_player_team1,@function
SP_info_player_team1:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC249@ha
	lis 9,deathmatch@ha
	la 11,.LC249@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L24
	bl G_FreeEdict
.L24:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe30:
	.size	 SP_info_player_team1,.Lfe30-SP_info_player_team1
	.section	".rodata"
	.align 2
.LC250:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_player_team3
	.type	 SP_info_player_team3,@function
SP_info_player_team3:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC250@ha
	lis 9,deathmatch@ha
	la 11,.LC250@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L26
	bl G_FreeEdict
.L26:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe31:
	.size	 SP_info_player_team3,.Lfe31-SP_info_player_team3
	.section	".rodata"
	.align 2
.LC251:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_player_team2
	.type	 SP_info_player_team2,@function
SP_info_player_team2:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC251@ha
	lis 9,deathmatch@ha
	la 11,.LC251@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L28
	bl G_FreeEdict
.L28:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe32:
	.size	 SP_info_player_team2,.Lfe32-SP_info_player_team2
	.align 2
	.globl SP_info_player_intermission
	.type	 SP_info_player_intermission,@function
SP_info_player_intermission:
	blr
.Lfe33:
	.size	 SP_info_player_intermission,.Lfe33-SP_info_player_intermission
	.align 2
	.globl IsFemale
	.type	 IsFemale,@function
IsFemale:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L36
	lis 4,.LC21@ha
	addi 3,3,188
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	lbz 3,0(3)
	xori 0,3,70
	subfic 9,0,0
	adde 0,9,0
	xori 3,3,102
	subfic 9,3,0
	adde 3,9,3
	or 3,3,0
	b .L686
.L36:
	li 3,0
.L686:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe34:
	.size	 IsFemale,.Lfe34-IsFemale
	.align 2
	.globl Drop_Flag
	.type	 Drop_Flag,@function
Drop_Flag:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,908(31)
	cmpwi 0,0,1
	bc 4,2,.L39
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
.L39:
	cmpwi 0,0,2
	bc 4,2,.L40
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
.L40:
	cmpwi 0,0,3
	bc 12,2,.L38
	mr 3,9
	bl FindItem
	lis 9,itemlist@ha
	mr 10,3
	lwz 11,84(31)
	la 9,itemlist@l(9)
	lis 0,0x38e3
	ori 0,0,36409
	subf 9,9,10
	mullw 9,9,0
	addi 11,11,748
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L38
	lwz 0,12(10)
	mr 3,31
	mr 4,10
	mtlr 0
	blrl
.L38:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe35:
	.size	 Drop_Flag,.Lfe35-Drop_Flag
	.section	".rodata"
	.align 3
.LC252:
	.long 0x404ca5dc
	.long 0x1a63c1f8
	.section	".text"
	.align 2
	.globl LookAtKiller
	.type	 LookAtKiller,@function
LookAtKiller:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr. 5,5
	mr 31,3
	bc 12,2,.L148
	lis 9,g_edicts@ha
	xor 11,5,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,5,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L148
	lfs 11,12(5)
	lfs 13,4(5)
	lfs 10,4(31)
	lfs 0,8(5)
	b .L687
.L148:
	cmpwi 0,4,0
	bc 12,2,.L150
	lis 9,g_edicts@ha
	xor 11,4,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,4,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L150
	lfs 11,12(4)
	lfs 13,4(4)
	lfs 10,4(31)
	lfs 0,8(4)
.L687:
	lfs 9,8(31)
	lfs 12,12(31)
	fsubs 13,13,10
	fsubs 0,0,9
	fsubs 11,11,12
	stfs 13,8(1)
	stfs 0,12(1)
	stfs 11,16(1)
	b .L149
.L150:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3680(9)
	b .L147
.L149:
	lfs 1,12(1)
	lfs 2,8(1)
	bl atan2
	lis 9,.LC252@ha
	lwz 11,84(31)
	lfd 0,.LC252@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,3680(11)
.L147:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe36:
	.size	 LookAtKiller,.Lfe36-LookAtKiller
	.section	".rodata"
	.align 2
.LC253:
	.long 0x4b18967f
	.align 2
.LC254:
	.long 0x3f800000
	.align 3
.LC255:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl PlayersRangeFromSpot
	.type	 PlayersRangeFromSpot,@function
PlayersRangeFromSpot:
	stwu 1,-80(1)
	mflr 0
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 26,40(1)
	stw 0,84(1)
	lis 9,maxclients@ha
	lis 11,.LC254@ha
	lwz 10,maxclients@l(9)
	la 11,.LC254@l(11)
	mr 31,3
	lfs 13,0(11)
	li 29,1
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC253@ha
	lfs 31,.LC253@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L240
	lis 9,.LC255@ha
	lis 27,g_edicts@ha
	la 9,.LC255@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,1268
.L242:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L241
	lwz 0,728(11)
	cmpwi 0,0,0
	bc 4,1,.L241
	lfs 0,4(11)
	addi 3,1,8
	lfs 13,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(11)
	fsubs 12,12,0
	stfs 12,12(1)
	lfs 0,12(11)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 4,0,.L241
	fmr 31,1
.L241:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,1268
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L242
.L240:
	fmr 1,31
	lwz 0,84(1)
	mtlr 0
	lmw 26,40(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe37:
	.size	 PlayersRangeFromSpot,.Lfe37-PlayersRangeFromSpot
	.align 2
	.globl SelectDeathmatchSpawnPoint
	.type	 SelectDeathmatchSpawnPoint,@function
SelectDeathmatchSpawnPoint:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,512
	bc 4,2,.L369
	bl SelectRandomDeathmatchSpawnPoint
	b .L689
.L369:
	bl SelectFarthestDeathmatchSpawnPoint
.L689:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe38:
	.size	 SelectDeathmatchSpawnPoint,.Lfe38-SelectDeathmatchSpawnPoint
	.align 2
	.globl SelectTeam1SpawnPoints
	.type	 SelectTeam1SpawnPoints,@function
SelectTeam1SpawnPoints:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl SelectTeam1SpawnPoint
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe39:
	.size	 SelectTeam1SpawnPoints,.Lfe39-SelectTeam1SpawnPoints
	.align 2
	.globl SelectTeam2SpawnPoints
	.type	 SelectTeam2SpawnPoints,@function
SelectTeam2SpawnPoints:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl SelectTeam2SpawnPoint
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe40:
	.size	 SelectTeam2SpawnPoints,.Lfe40-SelectTeam2SpawnPoints
	.align 2
	.globl SelectTeam3SpawnPoints
	.type	 SelectTeam3SpawnPoints,@function
SelectTeam3SpawnPoints:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl SelectTeam3SpawnPoint
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe41:
	.size	 SelectTeam3SpawnPoints,.Lfe41-SelectTeam3SpawnPoints
	.align 2
	.globl SelectCoopSpawnPoint
	.type	 SelectCoopSpawnPoint,@function
SelectCoopSpawnPoint:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 11,game+1028@ha
	lwz 0,84(3)
	lis 9,0x2645
	lwz 10,game+1028@l(11)
	ori 9,9,19727
	li 30,0
	li 3,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,3
	bc 12,2,.L690
.L378:
	lis 5,.LC2@ha
	mr 3,30
	la 5,.LC2@l(5)
	li 4,284
	bl G_Find
	mr. 30,3
	bc 4,2,.L379
	li 3,0
	b .L690
.L379:
	lwz 4,536(30)
	cmpwi 0,4,0
	bc 4,2,.L380
	lis 9,.LC24@ha
	la 4,.LC24@l(9)
.L380:
	lis 3,game+1032@ha
	la 3,game+1032@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L378
	addic. 31,31,-1
	bc 4,2,.L378
	mr 3,30
.L690:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe42:
	.size	 SelectCoopSpawnPoint,.Lfe42-SelectCoopSpawnPoint
	.section	".rodata"
	.align 2
.LC256:
	.long 0x3f800000
	.align 2
.LC257:
	.long 0x0
	.align 2
.LC258:
	.long 0x42400000
	.section	".text"
	.align 2
	.globl body_die
	.type	 body_die,@function
body_die:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	mr 28,6
	lwz 0,728(31)
	cmpwi 0,0,-40
	bc 4,0,.L430
	lis 29,gi@ha
	lis 3,.LC105@ha
	la 29,gi@l(29)
	la 3,.LC105@l(3)
	lwz 9,36(29)
	lis 27,.LC106@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC256@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC256@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC256@ha
	la 9,.LC256@l(9)
	lfs 2,0(9)
	lis 9,.LC257@ha
	la 9,.LC257@l(9)
	lfs 3,0(9)
	blrl
.L434:
	mr 3,31
	la 4,.LC106@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L434
	lis 9,.LC258@ha
	lfs 0,12(31)
	mr 4,28
	la 9,.LC258@l(9)
	mr 3,31
	lfs 13,0(9)
	fsubs 0,0,13
	stfs 0,12(31)
	bl ThrowClientHead
	stw 30,788(31)
.L430:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe43:
	.size	 body_die,.Lfe43-body_die
	.comm	pm_passent,4,4
	.align 2
	.globl PM_trace
	.type	 PM_trace,@function
PM_trace:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,pm_passent@ha
	mr 31,3
	lwz 8,pm_passent@l(9)
	lwz 0,728(8)
	cmpwi 0,0,0
	bc 4,1,.L564
	lis 11,gi+48@ha
	lis 9,0x201
	lwz 0,gi+48@l(11)
	ori 9,9,3
	mtlr 0
	blrl
	b .L563
.L564:
	lis 11,gi+48@ha
	lis 9,0x1
	lwz 0,gi+48@l(11)
	mr 3,31
	ori 9,9,3
	mtlr 0
	blrl
.L563:
	mr 3,31
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe44:
	.size	 PM_trace,.Lfe44-PM_trace
	.align 2
	.globl CheckBlock
	.type	 CheckBlock,@function
CheckBlock:
	li 11,0
	li 9,0
	cmpw 0,11,4
	bc 4,0,.L568
.L570:
	lbzx 0,3,9
	addi 9,9,1
	cmpw 0,9,4
	add 11,11,0
	bc 12,0,.L570
.L568:
	mr 3,11
	blr
.Lfe45:
	.size	 CheckBlock,.Lfe45-CheckBlock
	.align 2
	.globl PrintPmove
	.type	 PrintPmove,@function
PrintPmove:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 0,28
	li 5,0
	mtctr 0
	li 9,0
.L692:
	lbzx 0,3,9
	addi 9,9,1
	add 5,5,0
	bdnz .L692
	li 0,16
	lbz 4,42(3)
	li 6,0
	mtctr 0
	addi 3,3,28
	li 9,0
.L691:
	lbzx 0,3,9
	addi 9,9,1
	add 6,6,0
	bdnz .L691
	lis 3,.LC219@ha
	la 3,.LC219@l(3)
	crxor 6,6,6
	bl Com_Printf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe46:
	.size	 PrintPmove,.Lfe46-PrintPmove
	.align 2
	.type	 SP_CreateCoopSpots,@function
SP_CreateCoopSpots:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 3,level+72@ha
	lis 4,.LC1@ha
	la 3,level+72@l(3)
	la 4,.LC1@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L17
	bl G_Spawn
	lis 26,0xc324
	lis 25,0x42a0
	lis 29,.LC2@ha
	lis 28,.LC3@ha
	stw 26,8(3)
	la 29,.LC2@l(29)
	la 28,.LC3@l(28)
	stw 25,12(3)
	lis 27,0x42b4
	lis 0,0x42f8
	stw 29,284(3)
	stw 0,4(3)
	stw 27,20(3)
	stw 28,536(3)
	bl G_Spawn
	lis 0,0x437c
	stw 27,20(3)
	stw 0,4(3)
	stw 29,284(3)
	stw 26,8(3)
	stw 25,12(3)
	stw 28,536(3)
	bl G_Spawn
	lis 0,0x439e
	stw 27,20(3)
	stw 29,284(3)
	stw 0,4(3)
	stw 26,8(3)
	stw 25,12(3)
	stw 28,536(3)
.L17:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe47:
	.size	 SP_CreateCoopSpots,.Lfe47-SP_CreateCoopSpots
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
