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
	bc 4,2,.L24
	bl G_FreeEdict
	b .L23
.L24:
	lis 31,level+72@ha
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	la 3,level+72@l(31)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC6@ha
	la 3,level+72@l(31)
	la 4,.LC6@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC7@ha
	la 3,level+72@l(31)
	la 4,.LC7@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC8@ha
	la 3,level+72@l(31)
	la 4,.LC8@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC9@ha
	la 3,level+72@l(31)
	la 4,.LC9@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC10@ha
	la 3,level+72@l(31)
	la 4,.LC10@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC11@ha
	la 3,level+72@l(31)
	la 4,.LC11@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC12@ha
	la 3,level+72@l(31)
	la 4,.LC12@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC13@ha
	la 3,level+72@l(31)
	la 4,.LC13@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC14@ha
	la 3,level+72@l(31)
	la 4,.LC14@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC15@ha
	la 3,level+72@l(31)
	la 4,.LC15@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC16@ha
	la 3,level+72@l(31)
	la 4,.LC16@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC17@ha
	la 3,level+72@l(31)
	la 4,.LC17@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC18@ha
	la 3,level+72@l(31)
	la 4,.LC18@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L23
.L26:
	lis 9,SP_FixCoopSpots@ha
	lis 10,level+4@ha
	la 9,SP_FixCoopSpots@l(9)
	lis 11,.LC19@ha
	stw 9,440(30)
	lfs 0,level+4@l(10)
	lfd 13,.LC19@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(30)
.L23:
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
	.string	""
	.align 2
.LC22:
	.string	"suicides"
	.align 2
.LC23:
	.string	"fell to his death"
	.align 2
.LC24:
	.string	"was squished"
	.align 2
.LC25:
	.string	"drowned"
	.align 2
.LC26:
	.string	"melted"
	.align 2
.LC27:
	.string	"tripped on barbedwire"
	.align 2
.LC28:
	.string	"blew up"
	.align 2
.LC29:
	.string	"found a way out"
	.align 2
.LC30:
	.string	"saw the light"
	.align 2
.LC31:
	.string	"got blasted"
	.align 2
.LC32:
	.string	"was in the wrong place"
	.align 2
.LC33:
	.string	"changed teams"
	.align 2
.LC34:
	.string	"tried to put the pin back in"
	.align 2
.LC35:
	.string	"tripped on her own grenade"
	.align 2
.LC36:
	.string	"tripped on his own grenade"
	.align 2
.LC37:
	.string	"blew herself up"
	.align 2
.LC38:
	.string	"blew himself up"
	.align 2
.LC39:
	.string	"burned herself"
	.align 2
.LC40:
	.string	"burned himself"
	.align 2
.LC41:
	.string	"became toast"
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
	.string	"was capped by"
	.align 2
.LC46:
	.string	"was gunned down by"
	.align 2
.LC47:
	.string	"was shot down by"
	.align 2
.LC48:
	.string	"'s rifle"
	.align 2
.LC49:
	.string	"was machinegunned by"
	.align 2
.LC50:
	.string	"'s light machine gun"
	.align 2
.LC51:
	.string	"was killed by"
	.align 2
.LC52:
	.string	"'s heavy machine gun"
	.align 2
.LC53:
	.string	"was popped by"
	.align 2
.LC54:
	.string	"'s grenade"
	.align 2
.LC55:
	.string	"was shredded by"
	.align 2
.LC56:
	.string	"'s shrapnel"
	.align 2
.LC57:
	.string	"ate"
	.align 2
.LC58:
	.string	"'s rocket"
	.align 2
.LC59:
	.string	"did not survive"
	.align 2
.LC60:
	.string	"'s explosive attack"
	.align 2
.LC61:
	.string	"'s submachinegun"
	.align 2
.LC62:
	.string	"was sniped by"
	.align 2
.LC63:
	.string	"caught"
	.align 2
.LC64:
	.string	"'s handgrenade"
	.align 2
.LC65:
	.string	"'s TNT"
	.align 2
.LC66:
	.string	"feels"
	.align 2
.LC67:
	.string	"'s pain"
	.align 2
.LC68:
	.string	"didn't see"
	.align 2
.LC69:
	.string	"tripped on her own TNT"
	.align 2
.LC70:
	.string	"tripped on his own TNT"
	.align 2
.LC71:
	.string	"died of severe wounds inflicted by"
	.align 2
.LC72:
	.string	"tried to invade"
	.align 2
.LC73:
	.string	"'s personal space"
	.align 2
.LC74:
	.string	"was scorched by"
	.align 2
.LC75:
	.string	"was cremated by"
	.align 2
.LC76:
	.string	"got flamed by"
	.align 2
.LC77:
	.string	"was castrated by"
	.align 2
.LC78:
	.string	"was punched out by"
	.align 2
.LC79:
	.string	"%s %s %s%s\n"
	.align 2
.LC80:
	.long 0x0
	.align 2
.LC81:
	.long 0x3f800000
	.align 2
.LC82:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl ClientObituary
	.type	 ClientObituary,@function
ClientObituary:
	stwu 1,-64(1)
	mflr 0
	stmw 21,20(1)
	stw 0,68(1)
	lis 11,.LC80@ha
	lis 9,coop@ha
	la 11,.LC80@l(11)
	mr 27,3
	lfs 13,0(11)
	mr 26,5
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L40
	lwz 0,84(26)
	cmpwi 0,0,0
	bc 12,2,.L40
	lis 9,meansOfDeath@ha
	lwz 0,meansOfDeath@l(9)
	oris 0,0,0x800
	stw 0,meansOfDeath@l(9)
.L40:
	lis 11,.LC80@ha
	lis 9,deathmatch@ha
	la 11,.LC80@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L43
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L39
.L43:
	lis 9,meansOfDeath@ha
	lis 11,.LC21@ha
	lwz 0,meansOfDeath@l(9)
	la 28,.LC21@l(11)
	li 31,0
	rlwinm 7,0,0,5,3
	rlwinm 21,0,0,4,4
	addi 10,7,-17
	cmplwi 0,10,23
	bc 12,1,.L44
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
	.long .L48-.L62
	.long .L49-.L62
	.long .L50-.L62
	.long .L47-.L62
	.long .L44-.L62
	.long .L46-.L62
	.long .L45-.L62
	.long .L44-.L62
	.long .L52-.L62
	.long .L52-.L62
	.long .L58-.L62
	.long .L53-.L62
	.long .L58-.L62
	.long .L54-.L62
	.long .L58-.L62
	.long .L44-.L62
	.long .L55-.L62
	.long .L44-.L62
	.long .L44-.L62
	.long .L44-.L62
	.long .L44-.L62
	.long .L59-.L62
	.long .L60-.L62
	.long .L61-.L62
.L45:
	lis 9,.LC22@ha
	la 31,.LC22@l(9)
	b .L44
.L46:
	lis 9,.LC23@ha
	la 31,.LC23@l(9)
	b .L44
.L47:
	lis 9,.LC24@ha
	la 31,.LC24@l(9)
	b .L44
.L48:
	lis 9,.LC25@ha
	la 31,.LC25@l(9)
	b .L44
.L49:
	lis 9,.LC26@ha
	la 31,.LC26@l(9)
	b .L44
.L50:
	lis 9,.LC27@ha
	la 31,.LC27@l(9)
	b .L44
.L52:
	lis 9,.LC28@ha
	la 31,.LC28@l(9)
	b .L44
.L53:
	lis 9,.LC29@ha
	la 31,.LC29@l(9)
	b .L44
.L54:
	lis 9,.LC30@ha
	la 31,.LC30@l(9)
	b .L44
.L55:
	lis 9,.LC31@ha
	la 31,.LC31@l(9)
	b .L44
.L58:
	lis 9,.LC32@ha
	la 31,.LC32@l(9)
	b .L44
.L59:
	lis 9,.LC33@ha
	la 31,.LC33@l(9)
	b .L44
.L60:
.L61:
	li 31,0
.L44:
	cmpw 0,26,27
	bc 4,2,.L64
	cmpwi 0,7,24
	bc 12,2,.L66
	bc 12,1,.L87
	cmpwi 0,7,9
	bc 12,2,.L72
	bc 12,1,.L88
	cmpwi 0,7,7
	bc 12,2,.L68
	b .L82
.L88:
	cmpwi 0,7,16
	bc 12,2,.L68
	b .L82
.L87:
	cmpwi 0,7,102
	bc 12,2,.L81
	bc 12,1,.L89
	cmpwi 0,7,101
	bc 12,2,.L77
	b .L82
.L89:
	cmpwi 0,7,103
	bc 12,2,.L77
	b .L82
.L66:
	lis 9,.LC34@ha
	la 31,.LC34@l(9)
	b .L64
.L68:
	lis 9,.LC36@ha
	la 31,.LC36@l(9)
	b .L64
.L72:
	lis 9,.LC38@ha
	la 31,.LC38@l(9)
	b .L64
.L77:
	lis 9,.LC40@ha
	la 31,.LC40@l(9)
	b .L64
.L81:
	lis 9,.LC41@ha
	la 31,.LC41@l(9)
	b .L64
.L82:
	lis 9,.LC43@ha
	la 31,.LC43@l(9)
.L64:
	cmpwi 0,31,0
	bc 12,2,.L90
	lis 11,.LC80@ha
	lis 9,death_msg@ha
	la 11,.LC80@l(11)
	lfs 0,0(11)
	lwz 11,death_msg@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 4,2,.L91
	lis 9,gi+8@ha
	lwz 6,84(27)
	lis 5,.LC44@ha
	lwz 0,gi+8@l(9)
	la 5,.LC44@l(5)
	mr 7,31
	addi 6,6,700
	mr 3,27
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L92
.L91:
	lis 9,.LC81@ha
	la 9,.LC81@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L93
	lis 9,gi@ha
	lwz 5,84(27)
	lis 4,.LC44@ha
	lwz 0,gi@l(9)
	la 4,.LC44@l(4)
	mr 6,31
	addi 5,5,700
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L92
.L93:
	lis 9,.LC82@ha
	la 9,.LC82@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L92
	lis 9,game@ha
	li 30,1
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,30,0
	bc 12,1,.L92
	lis 9,gi@ha
	mr 24,11
	la 25,gi@l(9)
	lis 26,g_edicts@ha
	lis 28,.LC44@ha
	li 29,1016
.L99:
	lwz 0,g_edicts@l(26)
	add 3,0,29
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L98
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 12,2,.L98
	lwz 11,3448(9)
	cmpwi 0,11,0
	bc 12,2,.L98
	lwz 0,3464(9)
	cmpwi 0,0,0
	bc 12,2,.L98
	lwz 6,84(27)
	lwz 0,84(11)
	lwz 9,3448(6)
	lwz 11,84(9)
	cmpw 0,11,0
	bc 4,2,.L98
	lwz 9,8(25)
	addi 6,6,700
	li 4,1
	la 5,.LC44@l(28)
	mr 7,31
	mtlr 9
	crxor 6,6,6
	blrl
.L98:
	lwz 0,1544(24)
	addi 30,30,1
	addi 29,29,1016
	cmpw 0,30,0
	bc 4,1,.L99
.L92:
	lis 9,.LC80@ha
	lis 11,deathmatch@ha
	la 9,.LC80@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L104
	lwz 11,84(27)
	lwz 9,3424(11)
	addi 9,9,-1
	stw 9,3424(11)
.L104:
	li 0,0
	stw 0,548(27)
	b .L39
.L90:
	cmpwi 0,26,0
	stw 26,548(27)
	bc 12,2,.L39
	lwz 0,84(26)
	cmpwi 0,0,0
	mr 8,0
	bc 12,2,.L39
	addi 0,7,-1
	cmplwi 0,0,102
	bc 12,1,.L106
	lis 11,.L136@ha
	slwi 10,0,2
	la 11,.L136@l(11)
	lis 9,.L136@ha
	lwzx 0,10,11
	la 9,.L136@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L136:
	.long .L107-.L136
	.long .L108-.L136
	.long .L109-.L136
	.long .L110-.L136
	.long .L111-.L136
	.long .L112-.L136
	.long .L113-.L136
	.long .L114-.L136
	.long .L115-.L136
	.long .L116-.L136
	.long .L117-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L118-.L136
	.long .L127-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L130-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L128-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L129-.L136
	.long .L134-.L136
	.long .L135-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L119-.L136
	.long .L120-.L136
	.long .L128-.L136
	.long .L122-.L136
	.long .L123-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L106-.L136
	.long .L131-.L136
	.long .L132-.L136
	.long .L133-.L136
.L107:
	lis 9,.LC45@ha
	la 31,.LC45@l(9)
	b .L106
.L108:
	lis 9,.LC46@ha
	la 31,.LC46@l(9)
	b .L106
.L109:
	lis 9,.LC47@ha
	lis 11,.LC48@ha
	la 31,.LC47@l(9)
	la 28,.LC48@l(11)
	b .L106
.L110:
	lis 9,.LC49@ha
	lis 11,.LC50@ha
	la 31,.LC49@l(9)
	la 28,.LC50@l(11)
	b .L106
.L111:
	lis 9,.LC51@ha
	lis 11,.LC52@ha
	la 31,.LC51@l(9)
	la 28,.LC52@l(11)
	b .L106
.L112:
	lis 9,.LC53@ha
	lis 11,.LC54@ha
	la 31,.LC53@l(9)
	la 28,.LC54@l(11)
	b .L106
.L113:
	lis 9,.LC55@ha
	lis 11,.LC56@ha
	la 31,.LC55@l(9)
	la 28,.LC56@l(11)
	b .L106
.L114:
	lis 9,.LC57@ha
	lis 11,.LC58@ha
	la 31,.LC57@l(9)
	la 28,.LC58@l(11)
	b .L106
.L115:
	lis 9,.LC59@ha
	lis 11,.LC60@ha
	la 31,.LC59@l(9)
	la 28,.LC60@l(11)
	b .L106
.L116:
	lis 9,.LC46@ha
	lis 11,.LC61@ha
	la 31,.LC46@l(9)
	la 28,.LC61@l(11)
	b .L106
.L117:
	lis 9,.LC62@ha
	la 31,.LC62@l(9)
	b .L106
.L118:
	lis 9,.LC63@ha
	lis 11,.LC64@ha
	la 31,.LC63@l(9)
	la 28,.LC64@l(11)
	b .L106
.L119:
	lis 9,.LC63@ha
	lis 11,.LC65@ha
	la 31,.LC63@l(9)
	la 28,.LC65@l(11)
	b .L106
.L120:
	lis 9,.LC53@ha
	lis 11,.LC65@ha
	la 31,.LC53@l(9)
	la 28,.LC65@l(11)
	b .L106
.L122:
	lis 9,.LC68@ha
	lis 11,.LC65@ha
	la 31,.LC68@l(9)
	la 28,.LC65@l(11)
	b .L106
.L123:
	lis 9,.LC70@ha
	la 31,.LC70@l(9)
	b .L106
.L127:
	lis 9,.LC68@ha
	lis 11,.LC64@ha
	la 31,.LC68@l(9)
	la 28,.LC64@l(11)
	b .L106
.L128:
	lis 9,.LC66@ha
	lis 11,.LC67@ha
	la 31,.LC66@l(9)
	la 28,.LC67@l(11)
	b .L106
.L129:
	lis 9,.LC71@ha
	la 31,.LC71@l(9)
	b .L106
.L130:
	lis 9,.LC72@ha
	lis 11,.LC73@ha
	la 31,.LC72@l(9)
	la 28,.LC73@l(11)
	b .L106
.L131:
	lis 9,.LC74@ha
	la 31,.LC74@l(9)
	b .L106
.L132:
	lis 9,.LC75@ha
	la 31,.LC75@l(9)
	b .L106
.L133:
	lis 9,.LC76@ha
	la 31,.LC76@l(9)
	b .L106
.L134:
	lis 9,.LC77@ha
	la 31,.LC77@l(9)
	b .L106
.L135:
	lis 9,.LC78@ha
	la 31,.LC78@l(9)
.L106:
	cmpwi 0,31,0
	bc 12,2,.L39
	lis 11,.LC80@ha
	lis 9,death_msg@ha
	la 11,.LC80@l(11)
	lfs 0,0(11)
	lwz 11,death_msg@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 4,2,.L139
	lis 9,gi+8@ha
	lwz 6,84(27)
	lis 5,.LC79@ha
	lwz 0,gi+8@l(9)
	mr 3,27
	la 5,.LC79@l(5)
	addi 6,6,700
	mr 7,31
	addi 8,8,700
	mr 9,28
	mtlr 0
	li 4,2
	crxor 6,6,6
	blrl
	b .L140
.L139:
	lis 9,.LC81@ha
	la 9,.LC81@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L141
	lis 9,gi@ha
	lwz 5,84(27)
	lis 4,.LC79@ha
	lwz 0,gi@l(9)
	addi 7,8,700
	la 4,.LC79@l(4)
	mr 6,31
	addi 5,5,700
	mr 8,28
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L140
.L141:
	lis 9,.LC82@ha
	la 9,.LC82@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L140
	lis 9,game@ha
	li 30,1
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,30,0
	bc 12,1,.L140
	lis 9,gi@ha
	mr 22,11
	la 23,gi@l(9)
	lis 24,g_edicts@ha
	lis 25,.LC79@ha
	li 29,1016
.L147:
	lwz 0,g_edicts@l(24)
	add 3,0,29
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L146
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 12,2,.L146
	lwz 11,3448(9)
	cmpwi 0,11,0
	bc 12,2,.L146
	lwz 0,3464(9)
	cmpwi 0,0,0
	bc 12,2,.L146
	lwz 6,84(27)
	lwz 0,84(11)
	lwz 9,3448(6)
	lwz 11,84(9)
	cmpw 0,11,0
	bc 4,2,.L146
	lwz 8,84(26)
	addi 6,6,700
	li 4,1
	lwz 11,8(23)
	la 5,.LC79@l(25)
	mr 7,31
	addi 8,8,700
	mr 9,28
	mtlr 11
	crxor 6,6,6
	blrl
.L146:
	lwz 0,1544(22)
	addi 30,30,1
	addi 29,29,1016
	cmpw 0,30,0
	bc 4,1,.L147
.L140:
	lis 9,.LC80@ha
	lis 11,deathmatch@ha
	la 9,.LC80@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L39
	cmpwi 0,21,0
	bc 12,2,.L153
	lwz 11,84(26)
	lwz 9,3424(11)
	addi 9,9,-1
	b .L155
.L153:
	lwz 11,84(26)
	lwz 9,3424(11)
	addi 9,9,1
.L155:
	stw 9,3424(11)
.L39:
	lwz 0,68(1)
	mtlr 0
	lmw 21,20(1)
	la 1,64(1)
	blr
.Lfe2:
	.size	 ClientObituary,.Lfe2-ClientObituary
	.section	".rodata"
	.align 2
.LC83:
	.string	"Morphine"
	.align 2
.LC84:
	.string	"Fists"
	.align 2
.LC85:
	.string	"TNT"
	.align 2
.LC86:
	.string	"Binoculars"
	.align 2
.LC87:
	.long 0x0
	.align 3
.LC88:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC89:
	.long 0x41b40000
	.section	".text"
	.align 2
	.globl TossClientWeapon
	.type	 TossClientWeapon,@function
TossClientWeapon:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,deathmatch@ha
	lis 10,.LC87@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC87@l(10)
	mr 28,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L156
	lwz 9,84(28)
	lwz 11,4128(9)
	addi 10,9,740
	lwz 29,1796(9)
	slwi 11,11,2
	lwzx 9,10,11
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	and. 29,29,0
	bc 12,2,.L159
	lwz 3,40(29)
	lis 4,.LC83@ha
	la 4,.LC83@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L160
	lwz 3,40(29)
	lis 4,.LC84@ha
	la 4,.LC84@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L160
	lwz 3,40(29)
	lis 4,.LC85@ha
	la 4,.LC85@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L160
	lwz 3,40(29)
	lis 4,.LC86@ha
	la 4,.LC86@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L159
.L160:
	li 29,0
.L159:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,16384
	bc 4,2,.L161
	li 9,0
	b .L162
.L161:
	lis 10,level@ha
	lwz 8,84(28)
	lwz 9,level@l(10)
	lis 0,0x4330
	lis 10,.LC88@ha
	lfs 12,4340(8)
	addi 9,9,10
	la 10,.LC88@l(10)
	xoris 9,9,0x8000
	lfd 13,0(10)
	stw 9,12(1)
	stw 0,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 7,12,0
	mfcr 9
	rlwinm 9,9,30,1
.L162:
	addic 11,29,-1
	subfe 0,11,29
	lis 10,.LC87@ha
	and. 11,0,9
	la 10,.LC87@l(10)
	lfs 13,0(10)
	bc 12,2,.L163
	lis 9,.LC89@ha
	la 9,.LC89@l(9)
	lfs 13,0(9)
.L163:
	cmpwi 0,29,0
	bc 12,2,.L156
	lwz 9,84(28)
	lfs 0,4268(9)
	fsubs 0,0,13
	stfs 0,4268(9)
	lwz 11,84(28)
	lfs 0,4268(11)
	fadds 0,0,13
	stfs 0,4268(11)
	lwz 3,52(29)
	cmpwi 0,3,0
	bc 12,2,.L166
	lwz 0,68(29)
	cmpwi 0,0,0
	bc 12,2,.L166
	cmpwi 0,0,1
	bc 12,2,.L166
	cmpwi 0,0,12
	bc 12,2,.L166
	cmpwi 0,0,13
	bc 12,2,.L166
	cmpwi 0,0,8
	bc 12,2,.L166
	bl FindItem
	lis 9,itemlist@ha
	mr 30,3
	lwz 11,84(28)
	la 9,itemlist@l(9)
	lis 0,0xc4ec
	ori 0,0,20165
	subf 9,9,30
	mullw 9,9,0
	addi 11,11,740
	srawi 9,9,3
	slwi 31,9,2
	lwzx 0,11,31
	cmpwi 0,0,0
	bc 12,2,.L166
	lwz 0,12(30)
	cmpwi 0,0,0
	bc 12,2,.L156
	mr 3,28
	mr 4,30
	bl Drop_Item
	lwz 9,84(28)
	li 8,0
	lwz 10,664(3)
	addi 9,9,740
	lwzx 0,9,31
	stw 0,536(3)
	lwz 11,48(30)
	stw 11,48(10)
	lwz 9,84(28)
	addi 9,9,740
	stwx 8,9,31
.L166:
	mr 3,28
	mr 4,29
	bl Drop_Weapon
.L156:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 TossClientWeapon,.Lfe3-TossClientWeapon
	.section	".rodata"
	.align 2
.LC91:
	.long 0x0
	.long 0x0
	.long 0x3f800000
	.align 2
.LC92:
	.long 0x0
	.long 0x3f800000
	.long 0x3f800000
	.align 2
.LC93:
	.long 0x0
	.long 0xbf800000
	.long 0x3f800000
	.align 2
.LC94:
	.long 0x3f800000
	.long 0x0
	.long 0x3f800000
	.align 2
.LC95:
	.long 0xbf800000
	.long 0x0
	.long 0x3f800000
	.align 2
.LC96:
	.string	"misc/udeath.wav"
	.align 2
.LC97:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC98:
	.string	"models/objects/gibs/chest/tris.md2"
	.align 2
.LC99:
	.string	"models/objects/gibs/bone/tris.md2"
	.align 2
.LC100:
	.string	"models/objects/gibs/bone2/tris.md2"
	.align 2
.LC101:
	.string	"models/objects/gibs/sexyleg/tris.md2"
	.section	".sbss","aw",@nobits
	.align 2
i.69:
	.space	4
	.size	 i.69,4
	.section	".rodata"
	.align 2
.LC103:
	.string	"*death%i.wav"
	.align 2
.LC102:
	.long 0x3f19999a
	.align 2
.LC104:
	.long 0x0
	.align 3
.LC105:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC106:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl player_die
	.type	 player_die,@function
player_die:
	stwu 1,-208(1)
	mflr 0
	stfd 31,200(1)
	stmw 14,128(1)
	stw 0,212(1)
	lis 9,.LC91@ha
	addi 11,1,40
	lwz 0,.LC91@l(9)
	lis 10,.LC92@ha
	lis 25,.LC93@ha
	la 9,.LC91@l(9)
	lwz 26,.LC92@l(10)
	la 27,.LC92@l(10)
	lwz 28,8(9)
	la 24,.LC93@l(25)
	addi 29,1,72
	lwz 8,4(9)
	lis 23,.LC94@ha
	lis 21,.LC95@ha
	stw 0,40(1)
	addi 9,1,56
	la 22,.LC94@l(23)
	stw 8,4(11)
	mr 14,9
	la 20,.LC95@l(21)
	stw 28,8(11)
	addi 8,1,104
	mr 31,3
	lis 11,.LC104@ha
	lwz 0,4(27)
	addi 28,1,88
	la 11,.LC104@l(11)
	stw 26,56(1)
	li 3,0
	lfs 31,0(11)
	li 26,1
	mr 15,29
	lwz 10,8(27)
	mr 16,28
	mr 17,8
	stw 0,4(9)
	li 27,7
	mr 19,5
	lwz 11,.LC93@l(25)
	mr 30,6
	mr 18,7
	stw 10,8(9)
	lis 25,0xc100
	lwz 0,4(24)
	stw 11,72(1)
	lwz 10,8(24)
	stw 0,4(29)
	lwz 9,.LC94@l(23)
	stw 10,8(29)
	lwz 0,4(22)
	stw 9,88(1)
	lwz 11,8(22)
	stw 0,4(28)
	lwz 10,.LC95@l(21)
	stw 11,8(28)
	lwz 9,8(20)
	lwz 0,4(20)
	stw 10,104(1)
	stw 0,4(8)
	stw 9,8(8)
	stfs 31,400(31)
	stfs 31,396(31)
	stfs 31,392(31)
	stw 26,516(31)
	lwz 11,84(31)
	stw 27,264(31)
	stw 3,44(31)
	stfs 31,16(31)
	stfs 31,24(31)
	stw 3,76(31)
	stw 3,4372(11)
	lwz 9,496(31)
	lwz 0,184(31)
	cmpwi 0,9,0
	stw 25,208(31)
	ori 0,0,2
	stw 3,248(31)
	stw 0,184(31)
	bc 4,2,.L177
	lis 9,level+4@ha
	lis 10,.LC105@ha
	lfs 0,level+4@l(9)
	la 10,.LC105@l(10)
	li 0,2
	lfd 13,0(10)
	mr 3,31
	lwz 10,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,4380(10)
	lfs 0,20(31)
	lwz 11,84(31)
	stfs 0,4188(11)
	lwz 9,84(31)
	stw 0,0(9)
	bl ClientObituary
	mr 3,31
	bl TossClientWeapon
	lis 9,meansOfDeath@ha
	lwz 0,meansOfDeath@l(9)
	cmpwi 0,0,38
	bc 12,2,.L178
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L178
	mr 3,31
	bl Cmd_Help_f
.L178:
	lwz 9,84(31)
	lwz 0,4356(9)
	cmpwi 0,0,0
	bc 12,2,.L180
	mr 3,31
	bl weapon_grenade_fire
.L180:
	lwz 9,84(31)
	lwz 0,4364(9)
	cmpwi 0,0,0
	bc 12,2,.L177
	mr 3,31
	bl weapon_tnt_fire
.L177:
	lwz 11,84(31)
	li 0,0
	li 4,0
	li 5,1024
	stw 0,4340(11)
	lwz 9,84(31)
	stw 0,4344(9)
	lwz 11,84(31)
	stw 0,4348(11)
	lwz 9,84(31)
	stw 0,4352(9)
	lwz 3,84(31)
	addi 3,3,740
	crxor 6,6,6
	bl memset
	lis 9,meansOfDeath@ha
	lwz 9,meansOfDeath@l(9)
	xori 11,9,24
	subfic 0,11,0
	adde 11,0,11
	xori 0,9,6
	subfic 10,0,0
	adde 0,10,0
	or. 10,11,0
	bc 4,2,.L183
	cmpwi 0,9,8
	bc 12,2,.L183
	cmpwi 0,9,9
	bc 12,2,.L183
	cmpwi 0,9,7
	bc 12,2,.L183
	cmpwi 0,9,16
	bc 12,2,.L183
	cmpwi 0,9,25
	bc 12,2,.L183
	cmpwi 0,9,41
	bc 12,2,.L183
	cmpwi 0,9,42
	bc 12,2,.L183
	cmpwi 0,9,43
	bc 12,2,.L183
	cmpwi 0,9,44
	bc 12,2,.L183
	cmpwi 0,9,45
	bc 4,2,.L182
.L183:
	lis 29,gi@ha
	lis 3,.LC96@ha
	la 29,gi@l(29)
	la 3,.LC96@l(3)
	lwz 9,36(29)
	addi 28,31,4
	li 27,3
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC106@ha
	lis 10,.LC106@ha
	lis 11,.LC104@ha
	mr 5,3
	la 9,.LC106@l(9)
	la 10,.LC106@l(10)
	mtlr 0
	la 11,.LC104@l(11)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L187:
	addi 5,1,40
	mr 3,31
	mr 4,28
	mr 6,30
	li 7,69
	bl SprayBlood
	mr 3,31
	mr 4,28
	mr 5,14
	mr 6,30
	li 7,69
	bl SprayBlood
	mr 3,31
	mr 4,28
	mr 5,15
	mr 6,30
	li 7,69
	bl SprayBlood
	mr 3,31
	mr 4,28
	mr 5,16
	mr 6,30
	li 7,69
	bl SprayBlood
	mr 3,31
	mr 4,28
	mr 5,17
	mr 6,30
	li 7,69
	bl SprayBlood
	addic. 27,27,-1
	bc 4,2,.L187
	lis 4,.LC97@ha
	mr 3,31
	la 4,.LC97@l(4)
	mr 5,30
	li 6,0
	bl ThrowGib
	lis 4,.LC98@ha
	mr 3,31
	la 4,.LC98@l(4)
	mr 5,30
	li 6,0
	bl ThrowGib
	lis 4,.LC99@ha
	mr 3,31
	la 4,.LC99@l(4)
	mr 5,30
	li 6,0
	bl ThrowGib
	lis 4,.LC100@ha
	mr 3,31
	la 4,.LC100@l(4)
	mr 5,30
	li 6,0
	bl ThrowGib
	lis 4,.LC101@ha
	mr 3,31
	la 4,.LC101@l(4)
	mr 5,30
	li 6,0
	bl ThrowGib
	lis 9,.LC102@ha
	lwz 11,84(31)
	mr 4,30
	lfs 0,.LC102@l(9)
	mr 3,31
	stfs 0,3456(11)
	bl ThrowClientHead
	stw 27,516(31)
	b .L189
.L182:
	lwz 0,496(31)
	cmpwi 0,0,0
	bc 4,2,.L190
	lis 8,i.69@ha
	lis 9,0x5555
	lwz 6,84(31)
	lwz 10,i.69@l(8)
	ori 9,9,21846
	li 7,5
	addi 10,10,1
	mulhw 9,10,9
	srawi 11,10,31
	subf 9,11,9
	slwi 0,9,1
	add 0,0,9
	subf 10,0,10
	stw 10,i.69@l(8)
	stw 7,4328(6)
	lwz 0,672(31)
	cmpwi 0,0,2
	bc 4,2,.L191
	li 0,172
	lwz 11,84(31)
	li 9,177
	b .L208
.L191:
	cmpwi 0,0,4
	bc 4,2,.L193
	li 0,233
	lwz 11,84(31)
	li 9,240
	b .L208
.L193:
	cmpwi 0,10,1
	bc 12,2,.L197
	bc 12,1,.L201
	cmpwi 0,10,0
	bc 12,2,.L196
	b .L192
.L201:
	cmpwi 0,10,2
	bc 12,2,.L198
	b .L192
.L196:
	li 0,177
	lwz 11,84(31)
	li 9,183
	b .L208
.L197:
	li 0,183
	lwz 11,84(31)
	li 9,189
	b .L208
.L198:
	li 0,189
	lwz 11,84(31)
	li 9,197
.L208:
	stw 0,56(31)
	stw 9,4324(11)
.L192:
	lwz 0,688(31)
	cmpwi 0,0,8
	bc 4,2,.L202
	lis 9,meansOfDeath@ha
	lwz 0,meansOfDeath@l(9)
	cmpwi 0,0,36
	bc 12,2,.L202
	lwz 3,84(19)
	addi 29,1,24
	addi 4,1,8
	mr 5,29
	li 6,0
	addi 3,3,4264
	bl AngleVectors
	mr 4,18
	mr 6,29
	mr 3,31
	addi 5,1,8
	addi 7,31,380
	bl HeadShotGib
.L202:
	lis 29,gi@ha
	la 29,gi@l(29)
	bl rand
	mr 4,3
	srawi 0,4,31
	lis 3,.LC103@ha
	srwi 0,0,30
	la 3,.LC103@l(3)
	add 0,4,0
	rlwinm 0,0,0,0,29
	subf 4,0,4
	addi 4,4,1
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC106@ha
	lis 10,.LC106@ha
	lis 11,.LC104@ha
	mr 5,3
	la 9,.LC106@l(9)
	la 10,.LC106@l(10)
	mtlr 0
	la 11,.LC104@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L190:
	lwz 9,84(31)
	li 0,0
	stw 0,4264(9)
.L189:
	li 0,2
	li 8,0
	mtctr 0
	stw 0,496(31)
	li 10,0
.L206:
	lwz 9,84(31)
	addi 9,9,4444
	stwx 8,9,10
	lwz 11,84(31)
	addi 11,11,4440
	stwx 8,11,10
	lwz 9,84(31)
	addi 9,9,4436
	stwx 8,9,10
	lwz 11,84(31)
	addi 11,11,4432
	stwx 8,11,10
	lwz 9,84(31)
	addi 9,9,4404
	stwx 8,9,10
	lwz 11,84(31)
	addi 11,11,4400
	stwx 8,11,10
	lwz 9,84(31)
	addi 9,9,4420
	stwx 8,9,10
	lwz 11,84(31)
	addi 11,11,4416
	stwx 8,11,10
	lwz 9,84(31)
	addi 9,9,4428
	stwx 8,9,10
	lwz 11,84(31)
	addi 11,11,4424
	stwx 8,11,10
	lwz 9,84(31)
	addi 9,9,4412
	stwx 8,9,10
	lwz 11,84(31)
	addi 11,11,4408
	stwx 8,11,10
	addi 10,10,48
	bdnz .L206
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,212(1)
	mtlr 0
	lmw 14,128(1)
	lfd 31,200(1)
	la 1,208(1)
	blr
.Lfe4:
	.size	 player_die,.Lfe4-player_die
	.section	".rodata"
	.align 2
.LC109:
	.string	"info_player_deathmatch"
	.align 2
.LC108:
	.long 0x47c34f80
	.align 2
.LC110:
	.long 0x4b18967f
	.align 2
.LC111:
	.long 0x3f800000
	.align 3
.LC112:
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
	lis 9,.LC108@ha
	li 28,0
	lfs 29,.LC108@l(9)
	li 30,0
	li 23,0
	li 24,0
	fmr 28,29
	lis 22,.LC109@ha
	b .L230
.L232:
	lis 10,.LC111@ha
	lis 9,maxclients@ha
	la 10,.LC111@l(10)
	lis 11,.LC110@ha
	lfs 13,0(10)
	addi 28,28,1
	li 29,1
	lwz 10,maxclients@l(9)
	lis 25,maxclients@ha
	lfs 31,.LC110@l(11)
	lfs 0,20(10)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L240
	lis 11,.LC112@ha
	lis 26,g_edicts@ha
	la 11,.LC112@l(11)
	lis 27,0x4330
	lfd 30,0(11)
	li 31,1016
.L235:
	lwz 0,g_edicts@l(26)
	add 11,0,31
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L237
	lwz 0,484(11)
	cmpwi 0,0,0
	bc 4,1,.L237
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
	bc 4,0,.L237
	fmr 31,1
.L237:
	addi 29,29,1
	lwz 11,maxclients@l(25)
	xoris 0,29,0x8000
	addi 31,31,1016
	stw 0,36(1)
	stw 27,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L235
.L240:
	fcmpu 0,31,28
	bc 4,0,.L242
	fmr 28,31
	mr 24,30
	b .L230
.L242:
	fcmpu 0,31,29
	bc 4,0,.L230
	fmr 29,31
	mr 23,30
.L230:
	lis 5,.LC109@ha
	mr 3,30
	la 5,.LC109@l(5)
	li 4,284
	bl G_Find
	mr. 30,3
	bc 4,2,.L232
	cmpwi 0,28,0
	bc 4,2,.L246
	li 3,0
	b .L254
.L246:
	cmpwi 0,28,2
	bc 12,1,.L247
	li 23,0
	li 24,0
	b .L248
.L247:
	addi 28,28,-2
.L248:
	bl rand
	li 30,0
	divw 0,3,28
	mullw 0,0,28
	subf 31,0,3
.L253:
	mr 3,30
	li 4,284
	la 5,.LC109@l(22)
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
	bc 4,2,.L253
.L254:
	lwz 0,116(1)
	mtlr 0
	lmw 22,40(1)
	lfd 28,80(1)
	lfd 29,88(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe5:
	.size	 SelectRandomDeathmatchSpawnPoint,.Lfe5-SelectRandomDeathmatchSpawnPoint
	.section	".rodata"
	.align 2
.LC113:
	.long 0x47c34f80
	.align 2
.LC114:
	.long 0x4b18967f
	.align 2
.LC115:
	.long 0x3f800000
	.align 3
.LC116:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SelectRandomDDaySpawnPoint
	.type	 SelectRandomDDaySpawnPoint,@function
SelectRandomDDaySpawnPoint:
	stwu 1,-144(1)
	mflr 0
	stfd 27,104(1)
	stfd 28,112(1)
	stfd 29,120(1)
	stfd 30,128(1)
	stfd 31,136(1)
	stmw 19,52(1)
	stw 0,148(1)
	lis 9,.LC113@ha
	mr 23,3
	lfs 29,.LC113@l(9)
	mr 24,4
	li 28,0
	lis 9,.LC115@ha
	li 30,0
	la 9,.LC115@l(9)
	li 21,0
	fmr 28,29
	lfs 27,0(9)
	li 22,0
	lis 19,.LC114@ha
	lis 20,maxclients@ha
	b .L256
.L258:
	lwz 9,maxclients@l(20)
	addi 28,28,1
	li 29,1
	lfs 31,.LC114@l(19)
	lis 25,maxclients@ha
	lfs 0,20(9)
	fcmpu 0,27,0
	cror 3,2,0
	bc 4,3,.L266
	lis 10,.LC116@ha
	lis 26,g_edicts@ha
	la 10,.LC116@l(10)
	lis 27,0x4330
	lfd 30,0(10)
	li 31,1016
.L261:
	lwz 0,g_edicts@l(26)
	add 11,0,31
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L263
	lwz 0,484(11)
	cmpwi 0,0,0
	bc 4,1,.L263
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
	bc 4,0,.L263
	fmr 31,1
.L263:
	addi 29,29,1
	lwz 11,maxclients@l(25)
	xoris 0,29,0x8000
	addi 31,31,1016
	stw 0,44(1)
	stw 27,40(1)
	lfd 0,40(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L261
.L266:
	fcmpu 0,31,28
	bc 4,0,.L268
	fmr 28,31
	mr 22,30
	b .L256
.L268:
	fcmpu 0,31,29
	bc 4,0,.L256
	fmr 29,31
	mr 21,30
.L256:
	mr 3,30
	li 4,284
	mr 5,23
	mr 6,24
	bl G_Find_Team
	mr. 30,3
	bc 4,2,.L258
	cmpwi 0,28,0
	bc 4,2,.L272
	li 3,0
	b .L280
.L272:
	cmpwi 0,28,2
	bc 12,1,.L273
	li 21,0
	li 22,0
	b .L274
.L273:
	addi 28,28,-2
.L274:
	bl rand
	li 30,0
	divw 0,3,28
	mullw 0,0,28
	subf 31,0,3
.L279:
	mr 3,30
	li 4,284
	mr 5,23
	mr 6,24
	bl G_Find_Team
	mr 30,3
	addi 0,31,1
	xor 9,30,22
	subfic 10,9,0
	adde 9,10,9
	xor 11,30,21
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
	bc 4,2,.L279
.L280:
	lwz 0,148(1)
	mtlr 0
	lmw 19,52(1)
	lfd 27,104(1)
	lfd 28,112(1)
	lfd 29,120(1)
	lfd 30,128(1)
	lfd 31,136(1)
	la 1,144(1)
	blr
.Lfe6:
	.size	 SelectRandomDDaySpawnPoint,.Lfe6-SelectRandomDDaySpawnPoint
	.section	".rodata"
	.align 2
.LC117:
	.long 0x4b18967f
	.align 2
.LC118:
	.long 0x0
	.align 2
.LC119:
	.long 0x3f800000
	.align 3
.LC120:
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
	lis 9,.LC118@ha
	li 31,0
	la 9,.LC118@l(9)
	li 25,0
	lfs 29,0(9)
	b .L282
.L284:
	lis 9,maxclients@ha
	lis 11,.LC119@ha
	lwz 10,maxclients@l(9)
	la 11,.LC119@l(11)
	li 29,1
	lfs 13,0(11)
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC117@ha
	lfs 31,.LC117@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L292
	lis 9,.LC120@ha
	lis 27,g_edicts@ha
	la 9,.LC120@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,1016
.L287:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L289
	lwz 0,484(11)
	cmpwi 0,0,0
	bc 4,1,.L289
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
	bc 4,0,.L289
	fmr 31,1
.L289:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,1016
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L287
.L292:
	fcmpu 0,31,29
	bc 4,1,.L282
	fmr 29,31
	mr 25,31
.L282:
	lis 30,.LC109@ha
	mr 3,31
	li 4,284
	la 5,.LC109@l(30)
	bl G_Find
	mr. 31,3
	bc 4,2,.L284
	cmpwi 0,25,0
	mr 3,25
	bc 4,2,.L297
	la 5,.LC109@l(30)
	li 3,0
	li 4,284
	bl G_Find
.L297:
	lwz 0,100(1)
	mtlr 0
	lmw 25,44(1)
	lfd 29,72(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe7:
	.size	 SelectFarthestDeathmatchSpawnPoint,.Lfe7-SelectFarthestDeathmatchSpawnPoint
	.section	".rodata"
	.align 2
.LC121:
	.string	"Couldn't find spawn point %s\n"
	.align 2
.LC122:
	.string	"info_reinforcements_start"
	.align 2
.LC123:
	.string	"bodyque"
	.align 2
.LC124:
	.long 0x41800000
	.section	".text"
	.align 2
	.globl CopyToBodyQue
	.type	 CopyToBodyQue,@function
CopyToBodyQue:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	lis 9,maxclients@ha
	lis 11,level@ha
	lwz 10,maxclients@l(9)
	la 11,level@l(11)
	lwz 8,300(11)
	lis 28,gi@ha
	mr 30,3
	lfs 0,20(10)
	la 28,gi@l(28)
	addi 9,8,1
	lwz 10,76(28)
	lis 27,g_edicts@ha
	srawi 0,9,31
	lwz 26,g_edicts@l(27)
	srwi 0,0,29
	mtlr 10
	add 0,9,0
	rlwinm 0,0,0,0,28
	fctiwz 13,0
	subf 9,0,9
	stw 9,300(11)
	stfd 13,16(1)
	lwz 29,20(1)
	add 29,29,8
	mulli 29,29,1016
	addi 29,29,1016
	blrl
	add 31,26,29
	lwz 0,76(28)
	mr 3,31
	mtlr 0
	blrl
	mr 3,31
	mr 4,30
	li 5,84
	crxor 6,6,6
	bl memcpy
	lwz 0,g_edicts@l(27)
	lis 9,0xefdf
	li 7,0
	ori 9,9,49023
	lis 11,.LC124@ha
	subf 0,0,31
	la 11,.LC124@l(11)
	mullw 0,0,9
	lfs 11,0(11)
	lis 10,0xc100
	li 8,2
	lis 11,0xc1c0
	srawi 0,0,3
	stwx 0,26,29
	stw 7,76(31)
	lwz 0,184(30)
	lwz 9,820(31)
	ori 0,0,6
	ori 9,9,256
	stw 0,184(31)
	stw 9,820(31)
	lwz 0,184(30)
	stw 0,184(31)
	lfs 0,188(30)
	stfs 0,188(31)
	lfs 13,192(30)
	stfs 13,192(31)
	lfs 0,196(30)
	stfs 0,196(31)
	lfs 13,200(30)
	stfs 13,200(31)
	lfs 0,204(30)
	stfs 0,204(31)
	lfs 13,208(30)
	stfs 13,208(31)
	lfs 0,212(30)
	stfs 0,212(31)
	lfs 13,216(30)
	stfs 13,216(31)
	lfs 12,220(30)
	stfs 12,220(31)
	lfs 0,224(30)
	fadds 12,12,11
	stfs 0,224(31)
	lfs 13,228(30)
	stfs 13,228(31)
	lfs 0,232(30)
	stfs 0,232(31)
	lfs 13,236(30)
	stfs 13,236(31)
	lfs 0,240(30)
	stw 11,196(31)
	stw 10,208(31)
	stfs 0,240(31)
	stfs 12,232(31)
	stfs 11,244(31)
	stw 8,248(31)
	lwz 0,252(30)
	stw 0,252(31)
	lwz 9,256(30)
	stw 9,256(31)
	lwz 0,264(30)
	stw 0,264(31)
	lwz 0,484(30)
	cmpwi 0,0,0
	bc 4,1,.L340
	stw 7,484(31)
	b .L341
.L340:
	stw 0,484(31)
.L341:
	lwz 0,492(30)
	stw 0,492(31)
	lwz 9,560(30)
	stw 9,560(31)
	lwz 0,404(30)
	stw 0,404(31)
	lfs 0,988(30)
	stfs 0,988(31)
	lwz 9,992(30)
	cmpwi 0,9,0
	bc 12,2,.L342
	stw 9,992(31)
	li 0,0
	stw 31,548(9)
	stw 0,992(30)
.L342:
	lwz 11,984(30)
	lis 9,body_die@ha
	li 0,1
	la 9,body_die@l(9)
	stw 0,516(31)
	lis 10,gi+72@ha
	rlwinm 11,11,0,21,19
	stw 9,460(31)
	mr 3,31
	stw 11,984(31)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe8:
	.size	 CopyToBodyQue,.Lfe8-CopyToBodyQue
	.section	".rodata"
	.align 2
.LC125:
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.align 2
.LC126:
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.align 2
.LC127:
	.string	"private"
	.align 2
.LC128:
	.string	"players/%s/tris.md2"
	.align 2
.LC129:
	.string	"players/usa/tris.md2"
	.align 2
.LC130:
	.string	"fov"
	.align 2
.LC131:
	.long 0x41100000
	.align 2
.LC132:
	.long 0x0
	.align 2
.LC133:
	.long 0x41400000
	.align 2
.LC134:
	.long 0x41000000
	.align 3
.LC135:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC136:
	.long 0x3f800000
	.align 2
.LC137:
	.long 0x43200000
	.align 2
.LC138:
	.long 0x47800000
	.align 2
.LC139:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl PutClientInServer
	.type	 PutClientInServer,@function
PutClientInServer:
	stwu 1,-3968(1)
	mflr 0
	stfd 31,3960(1)
	stmw 20,3912(1)
	stw 0,3972(1)
	lis 9,.LC125@ha
	lis 10,.LC126@ha
	lwz 0,.LC125@l(9)
	addi 8,1,8
	la 7,.LC126@l(10)
	la 9,.LC125@l(9)
	lwz 11,.LC126@l(10)
	addi 5,1,24
	lwz 4,8(9)
	mr 31,3
	li 29,0
	lwz 6,4(9)
	lis 28,.LC0@ha
	lis 30,game@ha
	stw 0,8(1)
	addi 26,1,1688
	addi 21,1,72
	stw 4,8(8)
	addi 20,1,56
	stw 6,4(8)
	lwz 0,8(7)
	lwz 9,4(7)
	stw 11,24(1)
	stw 0,8(5)
	stw 9,4(5)
.L347:
	mr 3,29
	li 4,284
	la 5,.LC0@l(28)
	bl G_Find
	mr. 29,3
	bc 12,2,.L388
	la 3,game@l(30)
	lbz 0,1032(3)
	cmpwi 0,0,0
	bc 4,2,.L385
	lwz 0,304(29)
	cmpwi 0,0,0
	bc 12,2,.L349
	b .L347
.L385:
	lwz 4,304(29)
	cmpwi 0,4,0
	bc 12,2,.L347
	addi 3,3,1032
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L347
.L349:
	cmpwi 0,29,0
	bc 4,2,.L345
.L388:
	lis 9,game@ha
	la 30,game@l(9)
	lbz 0,1032(30)
	cmpwi 0,0,0
	bc 4,2,.L354
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,284
	bl G_Find
	mr 29,3
.L354:
	cmpwi 0,29,0
	bc 4,2,.L345
	lis 9,gi+28@ha
	lis 3,.LC121@ha
	lwz 0,gi+28@l(9)
	la 3,.LC121@l(3)
	addi 4,30,1032
	mtlr 0
	crxor 6,6,6
	blrl
.L345:
	lfs 0,4(29)
	lis 8,.LC131@ha
	lis 9,deathmatch@ha
	la 8,.LC131@l(8)
	lwz 10,deathmatch@l(9)
	lis 11,g_edicts@ha
	lfs 12,0(8)
	lis 9,.LC132@ha
	lis 0,0xefdf
	stfs 0,40(1)
	la 9,.LC132@l(9)
	ori 0,0,49023
	lfs 0,8(29)
	lfs 11,0(9)
	lwz 9,g_edicts@l(11)
	stfs 0,44(1)
	lfs 13,12(29)
	subf 9,9,31
	lwz 30,84(31)
	mullw 9,9,0
	fadds 13,13,12
	srawi 9,9,3
	addi 27,9,-1
	stfs 13,48(1)
	lfs 0,16(29)
	stfs 0,56(1)
	lfs 13,20(29)
	stfs 13,60(1)
	lfs 0,24(29)
	stfs 0,64(1)
	lfs 13,20(10)
	fcmpu 0,13,11
	bc 12,2,.L357
	addi 29,30,188
	li 5,512
	mulli 25,27,4732
	mr 4,29
	addi 3,1,3384
	crxor 6,6,6
	bl memcpy
	addi 28,30,1804
	mr 27,29
	lwz 3,84(31)
	mr 29,28
	addi 22,30,20
	addi 23,30,3428
	bl InitClientPersistant
	lis 9,globals+40@ha
	mr 3,31
	lwz 0,globals+40@l(9)
	addi 4,1,3384
	mtlr 0
	blrl
	mr 3,26
	mr 4,28
	li 5,1692
	crxor 6,6,6
	bl memcpy
	b .L360
.L357:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,11
	bc 12,2,.L361
	addi 28,30,1804
	li 5,1692
	mulli 25,27,4732
	mr 4,28
	mr 3,26
	crxor 6,6,6
	bl memcpy
	addi 29,30,188
	addi 22,30,20
	addi 3,1,3384
	mr 4,29
	mr 24,3
	li 5,512
	crxor 6,6,6
	bl memcpy
	mr 27,29
	addi 23,30,3428
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	la 9,itemlist@l(9)
	mr 29,28
	addi 9,9,56
	addi 10,1,2240
	addi 11,30,740
.L387:
	lwz 0,0(9)
	addi 9,9,104
	andi. 8,0,16
	bc 12,2,.L364
	lwz 0,0(11)
	stw 0,0(10)
.L364:
	addi 10,10,4
	addi 11,11,4
	bdnz .L387
	mr 4,26
	mr 3,27
	li 5,1616
	crxor 6,6,6
	bl memcpy
	lis 9,globals+40@ha
	mr 4,24
	lwz 0,globals+40@l(9)
	mr 3,31
	mtlr 0
	blrl
	b .L360
.L361:
	mulli 25,27,4732
	mr 3,26
	li 4,0
	li 5,1692
	addi 27,30,188
	crxor 6,6,6
	bl memset
	addi 29,30,1804
	addi 22,30,20
	addi 23,30,3428
.L360:
	mr 4,27
	li 5,1616
	mr 3,21
	crxor 6,6,6
	bl memcpy
	li 4,0
	li 5,4732
	mr 3,30
	crxor 6,6,6
	bl memset
	mr 4,21
	mr 3,27
	li 5,1616
	crxor 6,6,6
	bl memcpy
	lwz 0,724(30)
	cmpwi 0,0,0
	bc 12,1,.L369
	mr 3,27
	li 4,0
	li 5,1616
	crxor 6,6,6
	bl memset
	li 0,100
	li 7,5
	li 6,1
	li 8,2
	stw 0,1768(30)
	li 11,10
	li 10,8
	stw 7,1772(30)
	li 9,6
	stw 8,1776(30)
	stw 11,1784(30)
	stw 10,1788(30)
	stw 9,1792(30)
	stw 6,720(30)
	stw 0,724(30)
	stw 0,728(30)
	stw 7,1764(30)
	stw 6,1780(30)
.L369:
	mr 3,29
	mr 4,26
	li 5,1692
	crxor 6,6,6
	bl memcpy
	lwz 11,84(31)
	lwz 0,724(11)
	stw 0,484(31)
	lwz 9,728(11)
	stw 9,488(31)
	lwz 0,732(11)
	cmpwi 0,0,0
	bc 12,2,.L372
	lwz 0,268(31)
	ori 0,0,4096
	stw 0,268(31)
.L372:
	li 7,0
	lis 11,game+1028@ha
	lwz 6,268(31)
	stw 7,560(31)
	lis 9,.LC127@ha
	li 0,4
	lwz 10,game+1028@l(11)
	la 9,.LC127@l(9)
	li 5,1
	stw 0,264(31)
	li 11,22
	li 8,200
	stw 9,284(31)
	add 28,10,25
	li 0,2
	lis 9,.LC133@ha
	stw 11,512(31)
	lis 29,level+4@ha
	stw 8,404(31)
	la 9,.LC133@l(9)
	lis 10,player_pain@ha
	stw 0,248(31)
	lis 11,player_die@ha
	li 4,6418
	stw 28,84(31)
	la 10,player_pain@l(10)
	la 11,player_die@l(11)
	stw 5,516(31)
	rlwinm 6,6,0,21,19
	li 3,0
	stw 5,88(31)
	li 8,-41
	stw 7,496(31)
	lfs 0,level+4@l(29)
	lfs 13,0(9)
	lwz 0,184(31)
	lis 9,0x201
	ori 9,9,3
	stw 10,456(31)
	fadds 0,0,13
	rlwinm 0,0,0,31,29
	stw 9,252(31)
	stw 11,460(31)
	stw 7,616(31)
	stfs 0,408(31)
	stw 6,268(31)
	stw 0,184(31)
	stw 3,988(31)
	stw 8,492(31)
	stw 4,984(31)
	stw 5,660(31)
	stw 7,620(31)
	lwz 4,3448(28)
	cmpwi 0,4,0
	bc 12,2,.L373
	lwz 0,3464(28)
	cmpwi 0,0,0
	bc 12,2,.L373
	lwz 0,3472(28)
	cmpwi 0,0,0
	bc 12,2,.L373
	lis 3,.LC128@ha
	addi 4,4,164
	la 3,.LC128@l(3)
	crxor 6,6,6
	bl va
	stw 3,272(31)
	b .L374
.L373:
	lis 9,.LC129@ha
	la 9,.LC129@l(9)
	stw 9,272(31)
.L374:
	lis 9,gi+44@ha
	mr 3,31
	lwz 4,272(31)
	lwz 0,gi+44@l(9)
	lis 8,.LC132@ha
	la 8,.LC132@l(8)
	mtlr 0
	lfs 31,0(8)
	blrl
	lfs 0,12(1)
	li 4,0
	li 5,184
	lfs 13,16(1)
	lfs 12,24(1)
	lfs 11,28(1)
	lfs 10,32(1)
	lfs 9,8(1)
	lwz 3,84(31)
	stfs 0,192(31)
	stfs 13,196(31)
	stfs 12,200(31)
	stfs 11,204(31)
	stfs 10,208(31)
	stfs 9,188(31)
	stfs 31,388(31)
	stfs 31,384(31)
	stfs 31,380(31)
	crxor 6,6,6
	bl memset
	lis 8,.LC134@ha
	lfs 0,40(1)
	la 8,.LC134@l(8)
	mr 10,11
	lfs 10,0(8)
	lis 9,deathmatch@ha
	mr 8,11
	lwz 7,deathmatch@l(9)
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,3904(1)
	lwz 11,3908(1)
	sth 11,4(30)
	lfs 0,44(1)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,3904(1)
	lwz 10,3908(1)
	sth 10,6(30)
	lfs 0,48(1)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,3904(1)
	lwz 8,3908(1)
	sth 8,8(30)
	lfs 0,20(7)
	fcmpu 0,0,31
	bc 12,2,.L375
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,3904(1)
	lwz 11,3908(1)
	andi. 9,11,32768
	bc 4,2,.L389
.L375:
	lis 4,.LC130@ha
	mr 3,27
	la 4,.LC130@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	stw 3,3908(1)
	lis 0,0x4330
	lis 8,.LC135@ha
	la 8,.LC135@l(8)
	stw 0,3904(1)
	lis 11,.LC136@ha
	lfd 13,0(8)
	la 11,.LC136@l(11)
	lfd 0,3904(1)
	lfs 12,0(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	stfs 0,112(30)
	bc 4,0,.L377
.L389:
	lis 0,0x42aa
	stw 0,112(30)
	b .L376
.L377:
	lis 8,.LC137@ha
	la 8,.LC137@l(8)
	lfs 13,0(8)
	fcmpu 0,0,13
	bc 4,1,.L376
	stfs 13,112(30)
.L376:
	lis 11,g_edicts@ha
	lis 0,0xefdf
	lwz 9,g_edicts@l(11)
	ori 0,0,49023
	li 29,0
	li 11,255
	stw 29,64(31)
	mr 3,31
	subf 9,9,31
	stw 11,44(31)
	mullw 9,9,0
	stw 11,40(31)
	srawi 9,9,3
	addi 9,9,-1
	stw 9,60(31)
	bl ShowGun
	lis 9,.LC138@ha
	lfs 13,48(1)
	li 0,3
	la 9,.LC138@l(9)
	lfs 11,40(1)
	lis 11,.LC139@ha
	mtctr 0
	lfs 9,0(9)
	la 11,.LC139@l(11)
	mr 7,20
	lis 9,.LC136@ha
	lfs 12,44(1)
	mr 8,23
	la 9,.LC136@l(9)
	lfs 10,0(11)
	mr 10,22
	lfs 0,0(9)
	li 11,0
	stw 29,56(31)
	stfs 11,28(31)
	fadds 13,13,0
	stfs 12,32(31)
	stfs 11,4(31)
	stfs 12,8(31)
	stfs 13,36(31)
	stfs 13,12(31)
.L386:
	lfsx 0,11,7
	lfsx 12,11,8
	addi 11,11,4
	fsubs 0,0,12
	fmuls 0,0,9
	fdivs 0,0,10
	fctiwz 13,0
	stfd 13,3904(1)
	lwz 9,3908(1)
	sth 9,0(10)
	addi 10,10,2
	bdnz .L386
	lfs 0,60(1)
	li 0,0
	li 29,0
	stw 0,24(31)
	lis 9,gi+72@ha
	mr 3,31
	stw 0,16(31)
	stfs 0,20(31)
	stw 0,28(30)
	lfs 0,20(31)
	stfs 0,32(30)
	lfs 13,24(31)
	stfs 13,36(30)
	lfs 0,16(31)
	stfs 0,4264(30)
	lfs 13,20(31)
	stfs 13,4268(30)
	lfs 0,24(31)
	stw 29,4388(30)
	stfs 0,4272(30)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	li 0,22
	stw 29,680(31)
	mr 3,31
	stw 0,684(31)
	li 4,1
	stw 29,676(31)
	bl change_stance
	lwz 11,84(31)
	lis 0,0x42c8
	stw 29,692(31)
	stw 29,4396(11)
	lwz 9,84(31)
	stw 0,4668(9)
	stw 29,996(31)
	lwz 0,3972(1)
	mtlr 0
	lmw 20,3912(1)
	lfd 31,3960(1)
	la 1,3968(1)
	blr
.Lfe9:
	.size	 PutClientInServer,.Lfe9-PutClientInServer
	.align 2
	.globl ClientBeginDeathmatch
	.type	 ClientBeginDeathmatch,@function
ClientBeginDeathmatch:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 31,3
	lis 27,level@ha
	la 30,level@l(27)
	bl G_InitEdict
	lwz 29,84(31)
	li 4,0
	li 5,1692
	addi 28,29,1804
	mr 3,28
	crxor 6,6,6
	bl memset
	lwz 0,level@l(27)
	mr 3,28
	addi 4,29,188
	li 5,1616
	stw 0,3420(29)
	crxor 6,6,6
	bl memcpy
	lis 10,level_wait@ha
	lwz 0,level@l(27)
	lwz 9,level_wait@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	mulli 11,11,10
	cmpw 0,0,11
	bc 4,1,.L392
	lwz 9,84(31)
	li 0,192
	stw 0,3460(9)
.L392:
	lwz 11,84(31)
	li 0,0
	mr 3,31
	stw 0,3472(11)
	lwz 9,84(31)
	stw 0,3464(9)
	bl PutClientInServer
	lwz 27,200(30)
	cmpwi 0,27,0
	bc 12,2,.L393
	lwz 9,84(31)
	li 0,1
	stw 0,4524(9)
	b .L394
.L393:
	lwz 9,84(31)
	stw 27,4524(9)
.L394:
	lwz 11,84(31)
	li 0,0
	li 10,1
	mr 3,31
	stw 0,3476(11)
	lwz 9,84(31)
	stw 10,3480(9)
	bl SwitchToObserver
	lis 10,level_wait@ha
	lwz 8,level_wait@l(10)
	lis 9,level@ha
	lwz 0,level@l(9)
	lfs 0,20(8)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	mulli 11,11,10
	cmpw 0,0,11
	bc 4,1,.L395
	mr 3,31
	bl Cmd_MOTD
.L395:
	mr 3,31
	bl ClientEndServerFrame
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe10:
	.size	 ClientBeginDeathmatch,.Lfe10-ClientBeginDeathmatch
	.section	".rodata"
	.align 2
.LC140:
	.string	"cl_forwardspeed 200;cl_sidespeed 200;cl_upspeed 200;"
	.align 2
.LC141:
	.string	"%s has joined the battle.\n"
	.align 2
.LC142:
	.long 0x0
	.align 2
.LC143:
	.long 0x47800000
	.align 2
.LC144:
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
	lis 0,0xefdf
	lis 10,deathmatch@ha
	ori 0,0,49023
	lis 11,game+1028@ha
	subf 9,9,31
	lwz 8,game+1028@l(11)
	li 29,0
	mullw 9,9,0
	lwz 11,deathmatch@l(10)
	lis 10,.LC142@ha
	srawi 9,9,3
	la 10,.LC142@l(10)
	mulli 9,9,4732
	lfs 13,0(10)
	addi 9,9,-4732
	add 8,8,9
	stw 8,84(31)
	stw 29,3472(8)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L397
	bl ClientBeginDeathmatch
	mr 3,31
	bl LevelStartUserDLLs
	lis 4,.LC140@ha
	mr 3,31
	la 4,.LC140@l(4)
	bl stuffcmd
	b .L396
.L397:
	lwz 0,88(31)
	cmpwi 0,0,1
	bc 4,2,.L398
	lis 9,.LC143@ha
	lis 10,.LC144@ha
	li 11,3
	la 9,.LC143@l(9)
	la 10,.LC144@l(10)
	mtctr 11
	lfs 11,0(9)
	li 8,0
	lfs 12,0(10)
	li 7,0
.L409:
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
	bdnz .L409
	b .L404
.L398:
	mr 3,31
	bl G_InitEdict
	lis 9,.LC127@ha
	lwz 11,84(31)
	li 4,0
	la 9,.LC127@l(9)
	li 5,1692
	stw 9,284(31)
	stw 29,3464(11)
	lwz 29,84(31)
	addi 28,29,1804
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	addi 4,29,188
	lwz 0,level@l(9)
	li 5,1616
	mr 3,28
	stw 0,3420(29)
	crxor 6,6,6
	bl memcpy
	mr 3,31
	bl PutClientInServer
	mr 3,31
	bl SwitchToObserver
.L404:
	lis 10,.LC142@ha
	lis 9,level+204@ha
	la 10,.LC142@l(10)
	lfs 0,level+204@l(9)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 12,2,.L406
	mr 3,31
	bl MoveClientToIntermission
	b .L407
.L406:
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L407
	lis 28,gi@ha
	li 3,1
	la 29,gi@l(28)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xefdf
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,49023
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,3
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
	lis 4,.LC141@ha
	li 3,2
	lwz 0,gi@l(28)
	la 4,.LC141@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L407:
	mr 3,31
	bl ClientEndServerFrame
	mr 3,31
	bl LevelStartUserDLLs
.L396:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 ClientBegin,.Lfe11-ClientBegin
	.section	".rodata"
	.align 2
.LC145:
	.string	"\\name\\badinfo\\skin\\usa/USMC"
	.align 2
.LC146:
	.string	"name"
	.align 2
.LC147:
	.string	"skin"
	.align 2
.LC148:
	.string	"%s/%s"
	.align 2
.LC149:
	.string	"%s\\%s"
	.align 2
.LC150:
	.string	"usa/class_infantry"
	.align 2
.LC151:
	.string	"hand"
	.section	".text"
	.align 2
	.globl ClientUserinfoChanged
	.type	 ClientUserinfoChanged,@function
ClientUserinfoChanged:
	stwu 1,-96(1)
	mflr 0
	stmw 26,72(1)
	stw 0,100(1)
	mr 30,4
	mr 26,3
	mr 3,30
	bl Info_Validate
	cmpwi 0,3,0
	bc 4,2,.L411
	lis 9,.LC145@ha
	lwz 0,.LC145@l(9)
	la 11,.LC145@l(9)
	lwz 10,4(11)
	lwz 9,8(11)
	lwz 8,12(11)
	stw 0,0(30)
	stw 10,4(30)
	stw 9,8(30)
	stw 8,12(30)
	lwz 10,24(11)
	lwz 0,16(11)
	lwz 9,20(11)
	stw 0,16(30)
	stw 9,20(30)
	stw 10,24(30)
.L411:
	lis 4,.LC146@ha
	mr 3,30
	la 4,.LC146@l(4)
	bl Info_ValueForKey
	lwz 9,84(26)
	mr 31,3
	li 5,15
	mr 4,31
	addi 3,9,700
	bl strncpy
	lis 4,.LC147@ha
	mr 3,30
	la 4,.LC147@l(4)
	bl Info_ValueForKey
	lis 11,g_edicts@ha
	lis 9,0xefdf
	lwz 0,g_edicts@l(11)
	ori 9,9,49023
	cmpwi 0,26,0
	mr 31,3
	subf 0,0,26
	mullw 0,0,9
	srawi 28,0,3
	addi 27,28,-1
	bc 12,2,.L412
	lwz 11,84(26)
	lwz 4,3448(11)
	cmpwi 0,4,0
	bc 12,2,.L413
	lwz 11,3464(11)
	cmpwi 0,11,0
	bc 12,2,.L413
	lwz 10,96(4)
	slwi 11,11,2
	lis 3,.LC148@ha
	addi 4,4,164
	la 3,.LC148@l(3)
	lwzx 9,11,10
	addi 28,28,1311
	lwz 5,4(9)
	crxor 6,6,6
	bl va
	mr 4,3
	addi 3,1,8
	bl strcpy
	lwz 4,84(26)
	lis 29,gi@ha
	lis 3,.LC149@ha
	la 29,gi@l(29)
	la 3,.LC149@l(3)
	addi 4,4,700
	addi 5,1,8
	crxor 6,6,6
	bl va
	lwz 0,24(29)
	mr 4,3
	mr 3,28
	b .L417
.L413:
	lis 9,.LC150@ha
	lwz 4,84(26)
	addi 11,1,8
	lwz 6,.LC150@l(9)
	lis 29,gi@ha
	lis 3,.LC149@ha
	la 9,.LC150@l(9)
	la 29,gi@l(29)
	lwz 0,12(9)
	addi 27,27,1312
	addi 4,4,700
	lbz 28,18(9)
	la 3,.LC149@l(3)
	mr 5,11
	lwz 7,4(9)
	lwz 8,8(9)
	lhz 10,16(9)
	stw 6,8(1)
	stw 0,12(11)
	stw 7,4(11)
	stw 8,8(11)
	sth 10,16(11)
	stb 28,18(11)
	crxor 6,6,6
	bl va
	lwz 0,24(29)
	mr 4,3
	mr 3,27
.L417:
	mtlr 0
	blrl
	b .L415
.L412:
	lwz 4,84(26)
	lis 29,gi@ha
	lis 3,.LC149@ha
	la 29,gi@l(29)
	la 3,.LC149@l(3)
	addi 4,4,700
	mr 5,31
	crxor 6,6,6
	bl va
	lwz 9,24(29)
	addi 0,28,1311
	mr 4,3
	mr 3,0
	mtlr 9
	blrl
.L415:
	lis 4,.LC151@ha
	mr 3,30
	la 4,.LC151@l(4)
	bl Info_ValueForKey
	mr 31,3
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L416
	mr 3,31
	bl atoi
	lwz 9,84(26)
	stw 3,716(9)
.L416:
	lwz 3,84(26)
	mr 4,30
	li 5,511
	addi 3,3,188
	bl strncpy
	mr 3,26
	bl ShowGun
	lwz 0,100(1)
	mtlr 0
	lmw 26,72(1)
	la 1,96(1)
	blr
.Lfe12:
	.size	 ClientUserinfoChanged,.Lfe12-ClientUserinfoChanged
	.section	".sdata","aw"
	.align 2
	.type	 Already_Done.133,@object
	.size	 Already_Done.133,4
Already_Done.133:
	.long 0
	.section	".rodata"
	.align 2
.LC152:
	.string	"ip"
	.align 2
.LC153:
	.string	"password"
	.align 2
.LC154:
	.string	"id"
	.align 2
.LC155:
	.string	"%s connected.\n"
	.section	".text"
	.align 2
	.globl ClientConnect
	.type	 ClientConnect,@function
ClientConnect:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 28,4
	mr 30,3
	lis 4,.LC152@ha
	mr 3,28
	la 4,.LC152@l(4)
	bl Info_ValueForKey
	lis 4,.LC153@ha
	mr 3,28
	la 4,.LC153@l(4)
	bl Info_ValueForKey
	lis 9,password@ha
	mr 4,3
	lwz 11,password@l(9)
	lwz 3,4(11)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L419
	li 3,0
	b .L427
.L419:
	lis 9,Already_Done.133@ha
	lwz 0,Already_Done.133@l(9)
	cmpwi 0,0,0
	bc 4,2,.L420
	li 0,1
	lis 3,id_GameCmds@ha
	lis 5,.LC154@ha
	stw 0,Already_Done.133@l(9)
	la 3,id_GameCmds@l(3)
	la 5,.LC154@l(5)
	li 4,41
	bl InsertCmds
.L420:
	lis 11,g_edicts@ha
	lis 0,0xefdf
	lwz 10,88(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,49023
	lis 11,game@ha
	cmpwi 0,10,0
	subf 9,9,30
	la 27,game@l(11)
	mullw 9,9,0
	lwz 11,1028(27)
	srawi 9,9,3
	mulli 9,9,4732
	addi 9,9,-4732
	add 31,11,9
	stw 31,84(30)
	bc 4,2,.L421
	addi 29,31,1804
	li 4,0
	li 5,1692
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,29
	lwz 0,level@l(9)
	addi 4,31,188
	li 5,1616
	stw 0,3420(31)
	crxor 6,6,6
	bl memcpy
	lwz 0,1560(27)
	cmpwi 0,0,0
	bc 12,2,.L424
	lwz 9,84(30)
	lwz 0,1796(9)
	cmpwi 0,0,0
	bc 4,2,.L421
.L424:
	lwz 29,84(30)
	li 4,0
	li 5,1616
	addi 3,29,188
	crxor 6,6,6
	bl memset
	li 0,100
	li 7,5
	li 6,1
	li 8,2
	stw 0,1768(29)
	li 11,10
	li 10,8
	stw 6,720(29)
	li 9,6
	stw 7,1772(29)
	stw 8,1776(29)
	stw 11,1784(29)
	stw 10,1788(29)
	stw 9,1792(29)
	stw 0,724(29)
	stw 0,728(29)
	stw 7,1764(29)
	stw 6,1780(29)
.L421:
	lis 9,globals+40@ha
	mr 4,28
	lwz 0,globals+40@l(9)
	mr 3,30
	mtlr 0
	blrl
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L426
	lis 9,gi+4@ha
	lwz 4,84(30)
	lis 3,.LC155@ha
	lwz 0,gi+4@l(9)
	la 3,.LC155@l(3)
	addi 4,4,700
	mtlr 0
	crxor 6,6,6
	blrl
.L426:
	lwz 9,84(30)
	li 0,1
	li 3,1
	stw 0,720(9)
.L427:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 ClientConnect,.Lfe13-ClientConnect
	.section	".rodata"
	.align 2
.LC156:
	.string	"%s disconnected\n"
	.align 2
.LC157:
	.string	"disconnected"
	.section	".text"
	.align 2
	.globl ClientDisconnect
	.type	 ClientDisconnect,@function
ClientDisconnect:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L428
	li 4,1
	bl change_stance
	lis 4,.LC140@ha
	mr 3,31
	la 4,.LC140@l(4)
	bl stuffcmd
	lis 9,gi@ha
	lwz 5,84(31)
	lis 4,.LC156@ha
	lwz 0,gi@l(9)
	la 4,.LC156@l(4)
	li 3,2
	addi 5,5,700
	la 30,gi@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	lwz 9,3448(9)
	cmpwi 0,9,0
	bc 12,2,.L430
	lwz 0,84(9)
	lis 8,team_list@ha
	li 7,0
	la 8,team_list@l(8)
	slwi 0,0,2
	lwzx 10,8,0
	lwz 9,80(10)
	addi 9,9,-1
	stw 9,80(10)
	lwz 11,84(31)
	lwz 9,3448(11)
	lwz 10,3452(11)
	lwz 0,84(9)
	slwi 10,10,2
	slwi 0,0,2
	lwzx 9,8,0
	addi 9,9,8
	stwx 7,9,10
.L430:
	lwz 9,100(30)
	li 3,1
	lis 28,g_edicts@ha
	lis 29,0xefdf
	mtlr 9
	ori 29,29,49023
	blrl
	lwz 3,g_edicts@l(28)
	lwz 9,104(30)
	subf 3,3,31
	mullw 3,3,29
	mtlr 9
	srawi 3,3,3
	blrl
	lwz 9,100(30)
	li 3,10
	mtlr 9
	blrl
	lwz 9,88(30)
	li 4,2
	addi 3,31,4
	mtlr 9
	blrl
	lwz 9,76(30)
	mr 3,31
	mtlr 9
	blrl
	lwz 3,g_edicts@l(28)
	lis 9,.LC157@ha
	li 0,0
	la 9,.LC157@l(9)
	lwz 11,84(31)
	lis 4,.LC21@ha
	stw 9,284(31)
	subf 3,3,31
	la 4,.LC21@l(4)
	stw 0,40(31)
	mullw 3,3,29
	stw 0,248(31)
	stw 0,88(31)
	srawi 3,3,3
	stw 0,720(11)
	addi 3,3,1311
	lwz 0,24(30)
	mtlr 0
	blrl
.L428:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 ClientDisconnect,.Lfe14-ClientDisconnect
	.section	".rodata"
	.align 2
.LC158:
	.string	"sv %3i:%i %i\n"
	.align 3
.LC159:
	.long 0x3fe99999
	.long 0x9999999a
	.align 3
.LC160:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC161:
	.long 0x3ffc0000
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientSetMaxSpeed
	.type	 ClientSetMaxSpeed,@function
ClientSetMaxSpeed:
	stwu 1,-64(1)
	stw 31,60(1)
	mr. 3,3
	mr 31,4
	li 8,1
	bc 12,2,.L453
	lwz 10,84(3)
	cmpwi 0,10,0
	bc 12,2,.L453
	lwz 0,3484(10)
	cmpwi 0,0,0
	bc 4,2,.L453
	lwz 0,496(3)
	cmpwi 0,0,0
	bc 4,2,.L453
	li 0,120
	li 9,75
	li 11,50
	stw 0,24(1)
	stw 9,28(1)
	stw 11,32(1)
	lwz 0,4396(10)
	cmpwi 0,0,0
	bc 4,2,.L456
	lwz 9,1796(10)
	cmpwi 0,9,0
	bc 12,2,.L458
	lwz 0,68(9)
	cmpwi 0,0,1
	bc 12,2,.L458
	cmpwi 0,0,8
	bc 12,2,.L458
	cmpwi 0,0,11
	bc 12,2,.L458
	cmpwi 0,0,9
	bc 12,2,.L458
	cmpwi 0,0,12
	bc 12,2,.L458
	cmpwi 0,0,13
	bc 4,2,.L457
.L458:
	li 8,0
.L457:
	lis 9,.LC159@ha
	lis 11,.LC161@ha
	lfd 8,.LC159@l(9)
	li 0,3
	la 11,.LC161@l(11)
	lis 9,.LC160@ha
	mtctr 0
	lfd 9,0(11)
	cmpwi 7,8,0
	la 9,.LC160@l(9)
	addi 12,1,8
	lfd 10,0(9)
	addi 7,1,24
	mr 6,12
	lis 5,0x4330
	li 4,0
	li 8,0
.L493:
	lwz 10,84(3)
	lwz 0,4392(10)
	cmpwi 0,0,0
	bc 12,2,.L463
	lwz 0,672(3)
	cmpwi 0,0,1
	bc 4,2,.L464
	bc 12,30,.L463
	lwzx 0,8,7
	lfs 11,4508(10)
	mr 11,9
	xoris 0,0,0x8000
	stw 0,52(1)
	stw 5,48(1)
	lfd 0,48(1)
	fsub 0,0,10
	frsp 0,0
	fmuls 0,0,11
	fmr 13,0
	fdiv 13,13,9
	b .L494
.L464:
	cmpwi 0,0,2
	bc 4,2,.L468
	bc 4,30,.L469
	lwzx 0,8,7
	lfs 11,4508(10)
	mr 11,9
	xoris 0,0,0x8000
	stw 0,52(1)
	stw 5,48(1)
	lfd 0,48(1)
	fsub 0,0,10
	frsp 0,0
	fmuls 0,0,11
	fmr 13,0
	b .L495
.L469:
	lwzx 0,8,7
	lfs 11,4508(10)
	mr 11,9
	xoris 0,0,0x8000
	stw 0,52(1)
	stw 5,48(1)
	lfd 0,48(1)
	fsub 0,0,10
	frsp 0,0
	fmuls 0,0,11
	fmr 13,0
	fdiv 13,13,9
.L495:
	fctiwz 12,13
	stfd 12,48(1)
	lwz 11,52(1)
	stwx 11,8,6
	lwz 9,84(3)
	lwz 9,1796(9)
	cmpwi 0,9,0
	bc 12,2,.L461
	lwz 0,68(9)
	cmpwi 0,0,7
	bc 4,2,.L461
	stwx 4,8,6
	b .L461
.L468:
	lwzx 0,8,7
	lfs 13,4508(10)
	mr 11,9
	xoris 0,0,0x8000
	stw 0,52(1)
	stw 5,48(1)
	lfd 0,48(1)
	fmul 13,13,8
	fsub 0,0,10
	fmul 0,0,13
	fctiwz 12,0
	stfd 12,48(1)
	lwz 11,52(1)
	stwx 11,8,6
	lwz 9,1796(10)
	cmpwi 0,9,0
	bc 12,2,.L461
	lwz 0,68(9)
	cmpwi 0,0,7
	bc 4,2,.L461
	stwx 4,8,12
	b .L461
.L463:
	lwzx 0,8,7
	lfs 11,4508(10)
	mr 11,9
	xoris 0,0,0x8000
	stw 0,52(1)
	stw 5,48(1)
	lfd 0,48(1)
	fsub 0,0,10
	frsp 0,0
	fmuls 0,0,11
	fmr 13,0
.L494:
	fctiwz 12,13
	stfd 12,48(1)
	lwz 11,52(1)
	stwx 11,8,6
.L461:
	addi 8,8,4
	bdnz .L493
	lwz 0,672(3)
	cmpwi 0,0,1
	bc 12,2,.L478
	lwz 0,620(3)
	cmpwi 0,0,3
	bc 4,2,.L477
.L478:
	lwz 9,84(3)
	lwz 0,4676(9)
	cmpwi 0,0,1
	bc 4,2,.L479
.L477:
	li 0,0
	stw 0,16(1)
	b .L479
.L456:
	li 11,3
	addi 12,1,8
	mtctr 11
	li 0,0
	addi 9,12,8
.L492:
	stw 0,0(9)
	addi 9,9,-4
	bdnz .L492
.L479:
	li 9,3
	mr 8,12
	mtctr 9
	addic 0,31,-1
	subfe 4,0,31
	li 10,0
.L491:
	lwz 9,84(3)
	lwzx 11,10,8
	addi 9,9,4512
	lwzx 0,9,10
	cmpw 0,0,11
	bc 12,2,.L487
	stwx 11,9,10
	lwz 9,84(3)
	stw 4,4532(9)
.L487:
	addi 10,10,4
	bdnz .L491
.L453:
	lwz 31,60(1)
	la 1,64(1)
	blr
.Lfe15:
	.size	 ClientSetMaxSpeed,.Lfe15-ClientSetMaxSpeed
	.section	".rodata"
	.align 2
.LC162:
	.long 0x0
	.long 0x0
	.long 0xc6000000
	.align 2
.LC163:
	.string	"Select your team\n"
	.align 2
.LC165:
	.string	"cl_forwardspeed %i; cl_sidespeed %i; cl_upspeed %i;"
	.align 2
.LC167:
	.string	"*jump1.wav"
	.align 2
.LC169:
	.string	"%s/arty/fire.wav"
	.align 3
.LC164:
	.long 0x4067c000
	.long 0x0
	.align 3
.LC166:
	.long 0x3f768000
	.long 0x0
	.align 3
.LC168:
	.long 0x3fb70a3d
	.long 0x70a3d70a
	.align 2
.LC170:
	.long 0x0
	.align 3
.LC171:
	.long 0x40240000
	.long 0x0
	.align 3
.LC172:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC173:
	.long 0x42200000
	.align 2
.LC174:
	.long 0x3f800000
	.align 3
.LC175:
	.long 0x40040000
	.long 0x0
	.align 3
.LC176:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC177:
	.long 0x41c80000
	.align 2
.LC178:
	.long 0x42700000
	.align 2
.LC179:
	.long 0x41a00000
	.align 2
.LC180:
	.long 0x40000000
	.align 2
.LC181:
	.long 0x41200000
	.align 3
.LC182:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC183:
	.long 0x41000000
	.align 3
.LC184:
	.long 0x3fc00000
	.long 0x0
	.align 2
.LC185:
	.long 0xc1c80000
	.align 2
.LC186:
	.long 0x42c80000
	.align 2
.LC187:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl ClientThink
	.type	 ClientThink,@function
ClientThink:
	stwu 1,-528(1)
	mflr 0
	stfd 28,496(1)
	stfd 29,504(1)
	stfd 30,512(1)
	stfd 31,520(1)
	stmw 18,440(1)
	stw 0,532(1)
	lis 9,.LC162@ha
	addi 11,1,352
	lwz 8,.LC162@l(9)
	lis 29,level@ha
	mr 31,3
	la 9,.LC162@l(9)
	la 28,level@l(29)
	lwz 6,8(9)
	lis 10,gi@ha
	mr 7,11
	lwz 0,4(9)
	la 27,gi@l(10)
	mr 26,4
	stw 8,352(1)
	li 9,3
	addi 3,1,368
	stw 6,8(11)
	mr 8,31
	addi 4,1,320
	stw 0,4(11)
	addi 5,31,188
	addi 6,31,200
	stw 31,296(28)
	li 18,12
	lfs 11,4(31)
	lfs 10,8(31)
	lfs 9,12(31)
	lfs 0,352(1)
	lfs 13,356(1)
	lfs 12,360(1)
	lwz 11,48(27)
	fadds 0,11,0
	fadds 13,10,13
	lwz 30,84(31)
	fadds 12,9,12
	mtlr 11
	stfs 11,320(1)
	stfs 0,352(1)
	stfs 13,356(1)
	stfs 12,360(1)
	stfs 10,324(1)
	stfs 9,328(1)
	blrl
	lfs 11,4(31)
	lis 10,level_wait@ha
	lfs 10,380(1)
	lfs 0,8(31)
	lfs 13,12(31)
	fsubs 11,11,10
	lfs 9,384(1)
	lfs 10,388(1)
	lwz 11,level_wait@l(10)
	fsubs 0,0,9
	stfs 11,336(1)
	fsubs 13,13,10
	lwz 8,level@l(29)
	stfs 0,340(1)
	stfs 13,344(1)
	lfs 0,20(11)
	fctiwz 12,0
	stfd 12,432(1)
	lwz 9,436(1)
	mulli 9,9,10
	cmpw 0,8,9
	bc 4,0,.L497
	lwz 11,84(31)
	lwz 10,3460(11)
	cmpwi 0,10,127
	bc 12,1,.L498
	li 0,128
	mr 3,31
	stw 0,3460(11)
	bl Cmd_MOTD
	b .L496
.L498:
	addi 0,9,-3
	cmpw 0,8,0
	bc 4,2,.L496
	cmpwi 0,10,191
	bc 12,1,.L496
	li 0,192
	lis 4,.LC163@ha
	stw 0,3460(11)
	la 4,.LC163@l(4)
	mr 3,31
	lwz 0,12(27)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	lwz 0,4524(9)
	cmpwi 0,0,0
	bc 4,2,.L496
	mr 3,31
	bl MainMenu
	b .L496
.L497:
	lis 5,.LC170@ha
	lfs 13,204(28)
	la 5,.LC170@l(5)
	lfs 0,0(5)
	fcmpu 0,13,0
	bc 12,2,.L502
	li 0,4
	lis 6,.LC171@ha
	stw 0,0(30)
	la 6,.LC171@l(6)
	lfs 0,204(28)
	lfd 12,0(6)
	lfs 13,4(28)
	fadd 0,0,12
	fcmpu 0,13,0
	bc 4,1,.L496
	lbz 0,1(26)
	andi. 8,0,128
	bc 12,2,.L496
	li 0,1
	stw 0,212(28)
	b .L496
.L502:
	lwz 11,84(31)
	lwz 9,3460(11)
	cmpwi 0,9,39
	bc 12,1,.L504
	addi 0,9,1
	stw 0,3460(11)
	lwz 28,84(31)
	lwz 0,3460(28)
	cmpwi 0,0,10
	bc 4,1,.L504
	mulli 0,0,10
	lis 29,0x4330
	lis 10,.LC172@ha
	lis 11,.LC173@ha
	xoris 0,0,0x8000
	la 10,.LC172@l(10)
	stw 0,436(1)
	lis 5,.LC174@ha
	lis 6,.LC175@ha
	stw 29,432(1)
	la 11,.LC173@l(11)
	la 5,.LC174@l(5)
	lfd 30,0(10)
	la 6,.LC175@l(6)
	lfd 1,432(1)
	lfs 28,0(11)
	lfs 31,0(5)
	fsub 1,1,30
	lfd 29,0(6)
	bl sin
	lwz 11,84(31)
	mr 10,9
	lwz 0,3460(11)
	xoris 0,0,0x8000
	stw 0,436(1)
	stw 29,432(1)
	lfd 0,432(1)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,28
	fsubs 0,31,0
	fmr 13,0
	fmul 1,1,13
	fmul 1,1,29
	frsp 1,1
	stfs 1,4200(28)
	lwz 28,84(31)
	lwz 9,3460(28)
	addi 9,9,45
	mulli 9,9,6
	xoris 9,9,0x8000
	stw 9,436(1)
	stw 29,432(1)
	lfd 1,432(1)
	fsub 1,1,30
	bl sin
	lwz 11,84(31)
	lwz 0,3460(11)
	xoris 0,0,0x8000
	stw 0,436(1)
	stw 29,432(1)
	lfd 0,432(1)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,28
	fsubs 31,31,0
	fmul 1,1,31
	fmul 1,1,29
	frsp 1,1
	stfs 1,4204(28)
.L504:
	lwz 0,4396(30)
	cmpwi 0,0,0
	mr 11,0
	bc 12,2,.L508
	lwz 0,996(31)
	cmpwi 0,0,0
	bc 12,2,.L506
	lwz 9,84(31)
	lwz 0,3448(9)
	cmpwi 0,0,0
	bc 4,2,.L506
	lha 10,8(26)
	lha 8,10(26)
	lha 7,12(26)
	slwi 0,10,1
	slwi 11,8,1
	add 0,0,10
	slwi 9,7,1
	add 11,11,8
	sth 0,8(26)
	add 9,9,7
	sth 11,10(26)
	sth 9,12(26)
	b .L507
.L506:
	cmpwi 0,11,0
	bc 12,2,.L508
	li 0,0
	sth 0,12(26)
	sth 0,2(26)
	sth 0,4(26)
	sth 0,6(26)
	sth 0,8(26)
	sth 0,10(26)
	b .L507
.L508:
	lis 5,.LC170@ha
	lfs 0,380(31)
	la 5,.LC170@l(5)
	lfs 13,0(5)
	fcmpu 0,0,13
	bc 4,2,.L511
	lfs 0,384(31)
	fcmpu 0,0,13
	bc 12,2,.L510
.L511:
	lwz 0,688(31)
	cmpwi 0,0,1
	bc 4,2,.L510
	lis 27,level@ha
	lwz 28,84(31)
	lwz 0,level@l(27)
	lis 29,0x4330
	lis 6,.LC172@ha
	la 6,.LC172@l(6)
	lis 8,.LC176@ha
	lfs 31,4200(28)
	xoris 0,0,0x8000
	lfd 30,0(6)
	la 8,.LC176@l(8)
	stw 0,436(1)
	stw 29,432(1)
	lfd 1,432(1)
	lfd 0,0(8)
	fsub 1,1,30
	fmul 1,1,0
	bl sin
	lha 9,8(26)
	lis 10,.LC164@ha
	lha 8,10(26)
	mr 7,11
	srawi 5,9,31
	lfd 29,.LC164@l(10)
	srawi 6,8,31
	xor 0,5,9
	xor 9,6,8
	subf 0,5,0
	subf 9,6,9
	add 0,0,9
	xoris 0,0,0x8000
	stw 0,436(1)
	stw 29,432(1)
	lfd 0,432(1)
	fsub 0,0,30
	fmul 1,1,0
	fdiv 1,1,29
	fadd 31,31,1
	frsp 31,31
	stfs 31,4200(28)
	lwz 0,level@l(27)
	lwz 28,84(31)
	xoris 0,0,0x8000
	stw 0,436(1)
	stw 29,432(1)
	lfd 1,432(1)
	lfs 31,4204(28)
	fsub 1,1,30
	bl sin
	lha 8,8(26)
	lha 10,10(26)
	srawi 5,8,31
	srawi 6,10,31
	xor 0,5,8
	xor 9,6,10
	subf 0,5,0
	subf 9,6,9
	add 0,0,9
	xoris 0,0,0x8000
	stw 0,436(1)
	stw 29,432(1)
	lfd 0,432(1)
	fsub 0,0,30
	fmul 1,1,0
	fdiv 1,1,29
	fadd 31,31,1
	frsp 31,31
	stfs 31,4204(28)
.L510:
	lwz 9,84(31)
	lwz 0,4392(9)
	cmpwi 0,0,0
	bc 12,2,.L512
	addi 3,1,336
	bl VectorLength
	lis 5,.LC177@ha
	la 5,.LC177@l(5)
	lfs 0,0(5)
	fcmpu 0,1,0
	bc 4,1,.L512
	lis 6,.LC170@ha
	lfs 13,388(31)
	la 6,.LC170@l(6)
	lfs 0,0(6)
	fcmpu 0,13,0
	bc 12,2,.L512
	mr 3,31
	bl Cmd_Scope_f
.L512:
	lwz 0,4680(30)
	cmpwi 0,0,0
	bc 12,2,.L513
	lis 5,.LC170@ha
	lfs 13,388(31)
	la 5,.LC170@l(5)
	lfs 0,0(5)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L513
	li 0,0
	stw 0,4680(30)
.L513:
	lwz 0,4676(30)
	cmpwi 0,0,0
	bc 12,2,.L514
	lwz 0,4680(30)
	cmpwi 0,0,0
	bc 4,2,.L514
	sth 0,12(26)
.L514:
	lha 0,8(26)
	cmpwi 0,0,0
	bc 4,2,.L516
	lha 0,10(26)
	cmpwi 0,0,0
	bc 4,2,.L516
	lha 0,12(26)
	cmpwi 0,0,0
	bc 12,2,.L515
.L516:
	li 0,1
.L515:
	stw 0,4540(30)
	lwz 11,84(31)
	lha 9,8(26)
	lwz 0,4512(11)
	add 0,0,0
	cmpw 0,9,0
	bc 4,1,.L518
	lhz 0,4514(11)
	sth 0,8(26)
.L518:
	lwz 11,84(31)
	lha 9,8(26)
	lwz 0,4512(11)
	add 0,0,0
	neg 0,0
	cmpw 0,9,0
	bc 4,0,.L519
	lhz 0,4514(11)
	neg 0,0
	sth 0,8(26)
.L519:
	lwz 11,84(31)
	lha 9,10(26)
	lwz 0,4516(11)
	add 0,0,0
	cmpw 0,9,0
	bc 4,1,.L520
	lhz 0,4518(11)
	sth 0,10(26)
.L520:
	lwz 11,84(31)
	lha 9,10(26)
	lwz 0,4516(11)
	add 0,0,0
	neg 0,0
	cmpw 0,9,0
	bc 4,0,.L521
	lhz 0,4518(11)
	neg 0,0
	sth 0,10(26)
.L521:
	lha 0,12(26)
	cmpwi 0,0,0
	bc 12,2,.L611
	lwz 9,84(31)
	lwz 0,4520(9)
	cmpwi 0,0,0
	bc 4,1,.L526
	lhz 0,4522(9)
	sth 0,12(26)
	lwz 9,4672(30)
	cmpwi 0,9,0
	bc 4,2,.L523
	lis 6,.LC178@ha
	lfs 13,4668(30)
	la 6,.LC178@l(6)
	lfs 0,0(6)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L523
	lwz 0,620(31)
	cmpwi 0,0,3
	bc 12,2,.L523
	lis 8,.LC179@ha
	la 8,.LC179@l(8)
	lfs 0,0(8)
	fsubs 0,13,0
	stfs 0,4668(30)
.L523:
	li 0,1
.L611:
	stw 0,4672(30)
.L526:
	lis 9,.LC178@ha
	lfs 13,4668(30)
	la 9,.LC178@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L528
	lis 10,.LC170@ha
	lfs 13,388(31)
	la 10,.LC170@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 12,2,.L529
	lwz 0,4676(30)
	cmpwi 0,0,0
	bc 4,2,.L529
	li 0,1
	stw 0,4680(30)
.L529:
	li 0,1
	stw 0,4676(30)
	b .L530
.L528:
	lwz 0,4676(30)
	cmpwi 0,0,0
	bc 12,2,.L530
	li 0,0
	mr 3,31
	stw 0,4676(30)
	bl WeighPlayer
.L530:
	lwz 0,672(31)
	cmpwi 0,0,1
	bc 12,2,.L532
	lwz 0,620(31)
	cmpwi 0,0,3
	bc 12,2,.L532
	lhz 9,12(26)
	addi 9,9,-300
	sth 9,12(26)
	lwz 0,672(31)
	xori 0,0,4
	srawi 5,0,31
	xor 9,5,0
	subf 9,9,5
	srawi 9,9,31
	nor 0,9,9
	and 9,18,9
	rlwinm 0,0,0,27,28
	or 18,9,0
	b .L507
.L532:
	li 0,32
	stw 0,676(31)
.L507:
	lbz 0,1(26)
	andi. 6,0,1
	bc 12,2,.L535
	lwz 9,84(31)
	lwz 0,4524(9)
	cmpwi 0,0,0
	bc 12,2,.L536
	li 0,0
	mr 3,31
	stw 0,4524(9)
	bl SwitchToObserver
.L536:
	lwz 0,672(31)
	addi 28,1,16
	addi 23,1,20
	addi 20,31,4
	addi 25,1,26
	cmpwi 0,0,4
	addi 21,31,380
	addi 24,30,3496
	addi 27,1,44
	neg 19,18
	bc 4,2,.L544
	lwz 9,84(31)
	lwz 0,4392(9)
	cmpwi 0,0,0
	bc 12,2,.L544
	li 0,3
	li 10,0
	mtctr 0
	li 8,1
	li 11,0
.L614:
	lwz 9,84(31)
	addi 9,9,4512
	lwzx 0,9,11
	cmpwi 0,0,0
	bc 12,2,.L540
	stwx 10,9,11
	lwz 9,84(31)
	stw 8,4532(9)
	sth 10,8(26)
	sth 10,10(26)
	sth 10,12(26)
.L540:
	addi 11,11,4
	bdnz .L614
	b .L544
.L535:
	mr 3,31
	addi 28,1,16
	bl WeighPlayer
	addi 20,31,4
	addi 21,31,380
	addi 23,1,20
	addi 25,1,26
	addi 24,30,3496
	addi 27,1,44
	neg 19,18
.L544:
	lis 9,level@ha
	lwz 11,84(31)
	la 22,level@l(9)
	lwz 0,4532(30)
	lfs 13,4(22)
	lfs 0,4548(11)
	fcmpu 0,13,0
	cror 3,2,1
	bc 12,3,.L546
	cmpwi 0,0,1
	bc 4,2,.L545
.L546:
	cmpwi 0,0,0
	bc 12,2,.L545
	addi 29,1,256
	lwz 8,4520(11)
	lis 5,.LC165@ha
	lwz 6,4512(11)
	la 5,.LC165@l(5)
	mr 3,29
	lwz 7,4516(11)
	li 4,64
	crxor 6,6,6
	bl Com_sprintf
	li 0,0
	lis 5,.LC180@ha
	la 5,.LC180@l(5)
	stw 0,4532(30)
	mr 4,29
	lfs 0,4(22)
	mr 3,31
	lfs 13,0(5)
	fadds 0,0,13
	stfs 0,4548(30)
	bl stuffcmd
.L545:
	lis 9,pm_passent@ha
	mr 3,28
	stw 31,pm_passent@l(9)
	li 4,0
	li 5,240
	crxor 6,6,6
	bl memset
	lwz 0,264(31)
	cmpwi 0,0,1
	bc 12,2,.L554
	lwz 0,40(31)
	cmpwi 0,0,255
	li 0,3
	bc 4,2,.L554
	lwz 0,496(31)
	cmpwi 0,0,0
	li 0,2
	bc 4,2,.L554
	lwz 0,4396(30)
	cmpwi 0,0,0
	bc 12,2,.L554
	li 0,4
.L554:
	stw 0,0(30)
	lwz 0,3464(30)
	cmpwi 0,0,6
	bc 4,2,.L556
	lis 5,.LC181@ha
	lfs 0,4544(30)
	lis 9,level+4@ha
	la 5,.LC181@l(5)
	lfs 13,level+4@l(9)
	lfs 12,0(5)
	fadds 0,0,12
	fcmpu 0,13,0
	bc 4,0,.L556
	lwz 0,4716(30)
	cmpwi 0,0,0
	bc 4,2,.L556
	lwz 0,560(31)
	cmpwi 0,0,0
	bc 12,2,.L557
	lis 10,sv_gravity@ha
	lwz 11,sv_gravity@l(10)
	li 0,1
	lfs 0,20(11)
	stw 0,4716(30)
	b .L615
.L557:
	lis 10,sv_gravity@ha
	lis 6,.LC182@ha
	lwz 11,sv_gravity@l(10)
	la 6,.LC182@l(6)
	lfd 12,0(6)
	lfs 0,20(11)
	stw 0,4716(30)
	fmul 0,0,12
.L615:
	fctiwz 13,0
	stfd 13,432(1)
	lwz 9,436(1)
	sth 9,18(30)
	b .L559
.L556:
	lis 10,sv_gravity@ha
	lwz 9,sv_gravity@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,432(1)
	lwz 11,436(1)
	sth 11,18(30)
.L559:
	lwz 10,0(30)
	li 29,3
	lis 8,.LC183@ha
	lwz 11,4(30)
	mtctr 29
	la 8,.LC183@l(8)
	mr 3,23
	lwz 0,8(30)
	mr 4,20
	mr 5,25
	lwz 9,12(30)
	mr 6,21
	li 7,0
	stw 10,16(1)
	stw 11,4(28)
	stw 0,8(28)
	stw 9,12(28)
	lwz 0,16(30)
	lwz 9,20(30)
	lwz 11,24(30)
	lfs 11,0(8)
	li 8,0
	stw 0,16(28)
	stw 9,20(28)
	stw 11,24(28)
.L613:
	lfsx 0,7,4
	mr 11,9
	fmuls 0,0,11
	fctiwz 13,0
	stfd 13,432(1)
	lwz 9,436(1)
	sthx 9,8,3
	lfsx 0,7,6
	addi 7,7,4
	fmuls 0,0,11
	fctiwz 12,0
	stfd 12,432(1)
	lwz 11,436(1)
	sthx 11,8,5
	addi 8,8,2
	bdnz .L613
	mr 3,24
	addi 4,1,16
	li 5,28
	bl memcmp
	cmpwi 0,3,0
	bc 12,2,.L565
	li 0,1
	stw 0,60(1)
.L565:
	lwz 7,0(26)
	lis 11,gi@ha
	addi 3,1,16
	lwz 8,4(26)
	la 11,gi@l(11)
	lis 9,PM_trace@ha
	lwz 10,8(26)
	la 9,PM_trace@l(9)
	lwz 0,12(26)
	stw 7,44(1)
	stw 8,4(27)
	stw 0,12(27)
	stw 10,8(27)
	lwz 10,84(11)
	lwz 0,52(11)
	mtlr 10
	stw 9,248(1)
	stw 0,252(1)
	blrl
	lis 9,.LC184@ha
	lwz 11,16(1)
	lis 8,.LC172@ha
	la 9,.LC184@l(9)
	lwz 10,4(28)
	la 8,.LC172@l(8)
	lfd 13,0(9)
	mr 29,23
	mr 3,21
	lwz 0,8(28)
	mr 4,25
	mr 5,20
	lwz 9,12(28)
	lis 6,0x4330
	li 7,0
	stw 11,0(30)
	li 11,3
	stw 10,4(30)
	stw 0,8(30)
	mtctr 11
	stw 9,12(30)
	lwz 0,16(28)
	lwz 9,20(28)
	lwz 11,24(28)
	stw 0,16(30)
	stw 9,20(30)
	stw 11,24(30)
	lwz 0,16(1)
	lwz 9,4(28)
	lwz 11,8(28)
	lwz 10,12(28)
	stw 0,3496(30)
	stw 9,4(24)
	stw 11,8(24)
	stw 10,12(24)
	lwz 0,24(28)
	lwz 9,16(28)
	lwz 11,20(28)
	lfd 12,0(8)
	li 8,0
	stw 0,24(24)
	stw 9,16(24)
	stw 11,20(24)
.L612:
	lhax 0,7,29
	mr 11,9
	xoris 0,0,0x8000
	stw 0,436(1)
	stw 6,432(1)
	lfd 0,432(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfsx 0,8,5
	lhax 0,7,4
	addi 7,7,2
	xoris 0,0,0x8000
	stw 0,436(1)
	stw 6,432(1)
	lfd 0,432(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfsx 0,8,3
	addi 8,8,4
	bdnz .L612
	lwz 0,684(31)
	lis 6,0x4330
	mr 10,9
	lwz 11,676(31)
	mr 7,9
	xoris 4,18,0x8000
	xoris 0,0,0x8000
	mr 8,9
	lfs 9,220(1)
	stw 0,436(1)
	xoris 11,11,0x8000
	lis 29,.LC172@ha
	stw 6,432(1)
	xoris 0,19,0x8000
	la 29,.LC172@l(29)
	lfd 10,432(1)
	mr 5,9
	lis 3,.LC166@ha
	stw 11,436(1)
	stw 6,432(1)
	mr 11,9
	lfd 0,432(1)
	stw 4,436(1)
	stw 6,432(1)
	lfd 12,432(1)
	stw 0,436(1)
	stw 6,432(1)
	lfd 11,0(29)
	lfd 13,432(1)
	lfs 7,212(1)
	fsub 0,0,11
	lfs 8,224(1)
	fsub 12,12,11
	stfs 9,196(31)
	fsub 13,13,11
	stfs 7,188(31)
	frsp 0,0
	stfs 8,200(31)
	frsp 12,12
	lfd 9,.LC166@l(3)
	frsp 13,13
	stfs 0,208(31)
	fsub 10,10,11
	stfs 12,204(31)
	stfs 13,192(31)
	lha 0,2(26)
	frsp 10,10
	stfs 0,232(1)
	xoris 0,0,0x8000
	stfs 12,228(1)
	stw 0,436(1)
	stw 6,432(1)
	lfd 0,432(1)
	stfs 10,208(1)
	stfs 13,216(1)
	fsub 0,0,11
	fmul 0,0,9
	frsp 0,0
	stfs 0,3428(30)
	lha 0,4(26)
	xoris 0,0,0x8000
	stw 0,436(1)
	stw 6,432(1)
	lfd 0,432(1)
	fsub 0,0,11
	fmul 0,0,9
	frsp 0,0
	stfs 0,3432(30)
	lha 0,6(26)
	xoris 0,0,0x8000
	stw 0,436(1)
	stw 6,432(1)
	lfd 0,432(1)
	fsub 0,0,11
	fmul 0,0,9
	frsp 0,0
	stfs 0,3436(30)
	lwz 0,560(31)
	cmpwi 0,0,0
	bc 12,2,.L571
	lwz 0,236(1)
	cmpwi 0,0,0
	bc 4,2,.L571
	lha 0,56(1)
	cmpwi 0,0,9
	bc 4,1,.L571
	lwz 0,244(1)
	cmpwi 0,0,0
	bc 4,2,.L571
	lis 29,gi@ha
	lis 3,.LC167@ha
	la 29,gi@l(29)
	la 3,.LC167@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 6,.LC174@ha
	lis 8,.LC174@ha
	lis 9,.LC170@ha
	mr 5,3
	la 6,.LC174@l(6)
	la 8,.LC174@l(8)
	mtlr 0
	la 9,.LC170@l(9)
	li 4,2
	lfs 1,0(6)
	mr 3,31
	lfs 2,0(8)
	lfs 3,0(9)
	blrl
	mr 3,31
	mr 4,20
	li 5,0
	bl PlayerNoise
.L571:
	lfs 0,208(1)
	lwz 10,236(1)
	lwz 0,244(1)
	lwz 11,240(1)
	cmpwi 0,10,0
	stw 0,620(31)
	stw 11,616(31)
	fctiwz 13,0
	stw 10,560(31)
	stfd 13,432(1)
	lwz 9,436(1)
	stw 9,512(31)
	bc 12,2,.L572
	lwz 0,92(10)
	stw 0,564(31)
.L572:
	lwz 0,496(31)
	cmpwi 0,0,0
	bc 12,2,.L573
	lfs 0,4188(30)
	stfs 0,32(30)
	stfs 0,36(30)
	b .L616
.L573:
	lfs 0,196(1)
	stfs 0,4264(30)
	lfs 13,200(1)
	stfs 13,4268(30)
	lfs 0,204(1)
	stfs 0,4272(30)
	lfs 12,196(1)
	stfs 12,28(30)
	lfs 0,200(1)
	stfs 0,32(30)
	lfs 13,204(1)
	stfs 13,36(30)
	lwz 0,672(31)
	cmpwi 0,0,4
	bc 4,2,.L574
	lis 5,.LC185@ha
	la 5,.LC185@l(5)
	lfs 0,0(5)
	fcmpu 0,12,0
	bc 4,0,.L574
	stfs 0,64(30)
.L616:
	stfs 0,28(30)
.L574:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,264(31)
	cmpwi 0,0,1
	bc 12,2,.L577
	mr 3,31
	bl G_TouchTriggers
.L577:
	lwz 0,64(1)
	li 11,0
	cmpw 0,11,0
	bc 4,0,.L579
	addi 29,1,68
.L581:
	li 10,0
	slwi 0,11,2
	cmpw 0,10,11
	lwzx 3,29,0
	addi 28,11,1
	bc 4,0,.L583
	lwz 0,0(29)
	cmpw 0,0,3
	bc 12,2,.L583
	mr 9,29
.L584:
	addi 10,10,1
	cmpw 0,10,11
	bc 4,0,.L583
	lwzu 0,4(9)
	cmpw 0,0,3
	bc 4,2,.L584
.L583:
	cmpw 0,10,11
	bc 4,2,.L580
	lwz 0,448(3)
	cmpwi 0,0,0
	bc 12,2,.L580
	mr 4,31
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L580:
	lwz 0,64(1)
	mr 11,28
	cmpw 0,11,0
	bc 12,0,.L581
.L579:
	lis 5,.LC170@ha
	lwz 0,4132(30)
	la 5,.LC170@l(5)
	lfs 0,4684(30)
	lfs 13,0(5)
	stw 0,4136(30)
	lbz 11,1(26)
	fcmpu 0,0,13
	lwz 9,4140(30)
	andc 0,11,0
	stw 11,4132(30)
	or 9,9,0
	stw 9,4140(30)
	bc 12,2,.L591
	andi. 6,11,1
	bc 4,2,.L591
	stfs 13,4684(30)
.L591:
	lbz 0,15(26)
	stw 0,656(31)
	lwz 9,4140(30)
	andi. 8,9,1
	bc 12,2,.L592
	lwz 0,4144(30)
	cmpwi 0,0,0
	bc 4,2,.L592
	li 0,1
	mr 3,31
	stw 0,4144(30)
	bl Think_Weapon
.L592:
	lwz 0,4192(30)
	lwz 9,4196(30)
	cmpw 0,0,9
	bc 12,2,.L594
	addi 0,9,-6
	cmplwi 0,0,1
	bc 12,1,.L595
	mr 3,31
	bl WeighPlayer
.L595:
	lwz 0,4192(30)
	stw 0,4196(30)
.L594:
	lwz 10,84(31)
	lwz 0,3464(10)
	cmpwi 0,0,8
	bc 4,2,.L596
	lis 9,invuln_medic@ha
	lis 5,.LC174@ha
	lwz 11,invuln_medic@l(9)
	la 5,.LC174@l(5)
	lfs 0,0(5)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L597
	lis 6,.LC180@ha
	la 6,.LC180@l(6)
	lfs 0,0(6)
	fcmpu 0,13,0
	bc 4,2,.L596
.L597:
	li 0,0
	stw 0,3476(10)
.L596:
	lis 8,.LC186@ha
	lfs 13,4668(30)
	la 8,.LC186@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	bc 4,0,.L598
	fmr 0,13
	lis 9,.LC168@ha
	lfd 13,.LC168@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,4668(30)
.L598:
	lwz 0,692(31)
	cmpwi 0,0,0
	bc 12,2,.L599
	xoris 0,0,0x8000
	stw 0,436(1)
	lis 11,0x4330
	lis 10,.LC172@ha
	la 10,.LC172@l(10)
	stw 11,432(1)
	lfd 13,0(10)
	lfd 0,432(1)
	lis 10,level@ha
	la 29,level@l(10)
	lfs 12,4(29)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L599
	lwz 4,548(31)
	li 0,32
	li 11,35
	lwz 9,688(31)
	mr 7,20
	mr 3,31
	mr 5,4
	stw 0,8(1)
	addi 6,31,200
	rlwinm 9,9,0,29,29
	stw 11,12(1)
	li 8,0
	li 10,0
	bl T_Damage
	lis 5,.LC180@ha
	lfs 0,4(29)
	la 5,.LC180@l(5)
	lfs 12,0(5)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,432(1)
	lwz 9,436(1)
	stw 9,692(31)
.L599:
	lwz 9,4356(30)
	cmpwi 0,9,0
	bc 12,2,.L603
	lfs 0,4(31)
	li 0,0
	stfs 0,4(9)
	lfs 0,8(31)
	lwz 9,4356(30)
	stfs 0,8(9)
	lfs 0,12(31)
	lwz 11,4356(30)
	stfs 0,12(11)
	lwz 9,4356(30)
	stw 0,40(9)
.L603:
	lwz 9,4364(30)
	cmpwi 0,9,0
	bc 12,2,.L604
	lfs 0,4(31)
	li 0,0
	stfs 0,4(9)
	lfs 0,8(31)
	lwz 9,4364(30)
	stfs 0,8(9)
	lfs 0,12(31)
	lwz 11,4364(30)
	stfs 0,12(11)
	lwz 9,4364(30)
	stw 0,40(9)
.L604:
	lwz 0,4612(30)
	cmpwi 0,0,0
	bc 12,2,.L605
	lis 6,.LC187@ha
	lfs 0,4660(30)
	lis 9,level+4@ha
	la 6,.LC187@l(6)
	lfs 13,level+4@l(9)
	lfs 12,0(6)
	fsubs 0,0,12
	fcmpu 0,0,13
	bc 4,0,.L606
	lwz 0,4620(30)
	cmpwi 0,0,0
	bc 4,2,.L606
	li 0,1
	lis 29,gi@ha
	stw 0,4620(30)
	lis 3,.LC169@ha
	la 29,gi@l(29)
	lwz 9,84(31)
	la 3,.LC169@l(3)
	lwz 4,3448(9)
	addi 4,4,100
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 6,.LC174@ha
	lis 8,.LC170@ha
	lis 9,.LC170@ha
	mr 5,3
	la 6,.LC174@l(6)
	la 8,.LC170@l(8)
	mtlr 0
	la 9,.LC170@l(9)
	li 4,0
	lfs 1,0(6)
	mr 3,31
	lfs 2,0(8)
	lfs 3,0(9)
	blrl
.L606:
	lis 9,level+4@ha
	lfs 13,4660(30)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L608
	li 0,0
	mr 3,31
	stw 0,4620(30)
	stw 0,4612(30)
	bl Think_Arty
	b .L608
.L605:
	stw 0,4620(30)
.L608:
	lwz 0,620(31)
	cmpwi 0,0,1
	bc 4,1,.L496
	lwz 0,672(31)
	cmpwi 0,0,1
	bc 12,2,.L496
	mr 3,31
	li 4,1
	bl change_stance
.L496:
	lwz 0,532(1)
	mtlr 0
	lmw 18,440(1)
	lfd 28,496(1)
	lfd 29,504(1)
	lfd 30,512(1)
	lfd 31,520(1)
	la 1,528(1)
	blr
.Lfe16:
	.size	 ClientThink,.Lfe16-ClientThink
	.section	".rodata"
	.align 2
.LC188:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientBeginServerFrame
	.type	 ClientBeginServerFrame,@function
ClientBeginServerFrame:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 11,.LC188@ha
	lis 9,level+204@ha
	la 11,.LC188@l(11)
	lfs 0,level+204@l(9)
	mr 31,3
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L617
	lwz 30,84(31)
	lwz 0,4144(30)
	cmpwi 0,0,0
	bc 4,2,.L619
	bl Think_Weapon
	b .L620
.L619:
	li 0,0
	stw 0,4144(30)
.L620:
	lwz 0,496(31)
	cmpwi 0,0,0
	bc 12,2,.L621
	lis 9,level+4@ha
	lfs 13,4380(30)
	lfs 0,level+4@l(9)
	fcmpu 0,0,13
	bc 4,1,.L617
	lis 9,.LC188@ha
	lis 11,deathmatch@ha
	lwz 10,4140(30)
	la 9,.LC188@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 7,0,13
	mfcr 0
	rlwinm 0,0,31,1
	neg 0,0
	ori 0,0,1
	and. 11,10,0
	bc 4,2,.L626
	bc 12,30,.L627
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,1024
	bc 4,2,.L626
.L627:
	lis 9,level@ha
	lwz 0,4556(30)
	lwz 11,level@l(9)
	cmpw 0,0,11
	bc 12,1,.L617
	lwz 0,4396(30)
	cmpwi 0,0,0
	bc 4,2,.L617
	lwz 0,3484(30)
	cmpwi 0,0,0
	bc 4,2,.L617
.L626:
	mr 3,31
	li 29,0
	bl CopyToBodyQue
	mr 3,31
	bl PutClientInServer
	lwz 9,84(31)
	li 0,16
	li 11,14
	lis 10,level+4@ha
	li 8,1
	stb 0,16(9)
	lis 7,gi+72@ha
	mr 3,31
	lwz 9,84(31)
	stb 11,17(9)
	lfs 0,level+4@l(10)
	lwz 9,84(31)
	stfs 0,4380(9)
	lwz 0,184(31)
	lwz 11,84(31)
	ori 0,0,1
	stw 8,264(31)
	stw 0,184(31)
	stw 29,248(31)
	stw 29,88(11)
	lwz 9,84(31)
	stw 29,1796(9)
	lwz 11,84(31)
	stw 8,4396(11)
	lwz 0,gi+72@l(7)
	mtlr 0
	blrl
	stw 29,4140(30)
	b .L617
.L621:
	lis 9,.LC188@ha
	lis 11,deathmatch@ha
	la 9,.LC188@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L629
	bl PlayerTrail_LastSpot
	mr 4,3
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L629
	addi 3,31,28
	bl PlayerTrail_Add
.L629:
	li 0,0
	stw 0,4140(30)
.L617:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe17:
	.size	 ClientBeginServerFrame,.Lfe17-ClientBeginServerFrame
	.comm	is_silenced,1,1
	.align 2
	.globl respawn
	.type	 respawn,@function
respawn:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl CopyToBodyQue
	mr 3,29
	bl PutClientInServer
	lwz 9,84(29)
	li 0,16
	li 11,14
	lis 8,level+4@ha
	li 10,0
	stb 0,16(9)
	li 7,1
	lis 6,gi+72@ha
	lwz 9,84(29)
	mr 3,29
	stb 11,17(9)
	lfs 0,level+4@l(8)
	lwz 9,84(29)
	stfs 0,4380(9)
	lwz 0,184(29)
	lwz 11,84(29)
	ori 0,0,1
	stw 7,264(29)
	stw 0,184(29)
	stw 10,248(29)
	stw 10,88(11)
	lwz 9,84(29)
	stw 10,1796(9)
	lwz 11,84(29)
	stw 7,4396(11)
	lwz 0,gi+72@l(6)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 respawn,.Lfe18-respawn
	.align 2
	.globl InitClientPersistant
	.type	 InitClientPersistant,@function
InitClientPersistant:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	li 4,0
	addi 3,29,188
	li 5,1616
	crxor 6,6,6
	bl memset
	li 0,100
	li 7,5
	li 6,1
	li 8,2
	stw 0,1768(29)
	li 11,10
	li 10,8
	stw 6,720(29)
	li 9,6
	stw 7,1772(29)
	stw 8,1776(29)
	stw 11,1784(29)
	stw 10,1788(29)
	stw 9,1792(29)
	stw 0,724(29)
	stw 0,728(29)
	stw 7,1764(29)
	stw 6,1780(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 InitClientPersistant,.Lfe19-InitClientPersistant
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
	addi 28,29,1804
	li 5,1692
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,28
	lwz 0,level@l(9)
	addi 4,29,188
	li 5,1616
	stw 0,3420(29)
	crxor 6,6,6
	bl memcpy
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 InitClientResp,.Lfe20-InitClientResp
	.align 2
	.globl InitBodyQue
	.type	 InitBodyQue,@function
InitBodyQue:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,level+300@ha
	li 0,0
	lis 11,.LC123@ha
	stw 0,level+300@l(9)
	li 31,8
	la 30,.LC123@l(11)
.L330:
	bl G_Spawn
	addic. 31,31,-1
	stw 30,284(3)
	bc 4,2,.L330
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe21:
	.size	 InitBodyQue,.Lfe21-InitBodyQue
	.align 2
	.globl player_pain
	.type	 player_pain,@function
player_pain:
	blr
.Lfe22:
	.size	 player_pain,.Lfe22-player_pain
	.align 2
	.globl SaveClientData
	.type	 SaveClientData,@function
SaveClientData:
	lis 9,game@ha
	li 6,0
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,6,0
	bclr 4,0
	lis 9,g_edicts@ha
	mr 7,11
	lwz 11,g_edicts@l(9)
	li 8,0
	addi 10,11,1016
.L215:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L214
	lwz 9,1028(7)
	lwz 0,484(10)
	add 9,8,9
	stw 0,724(9)
	lwz 11,1028(7)
	lwz 0,488(10)
	add 11,8,11
	stw 0,728(11)
	lwz 9,1028(7)
	lwz 0,268(10)
	add 9,8,9
	rlwinm 0,0,0,19,19
	stw 0,732(9)
.L214:
	lwz 0,1544(7)
	addi 6,6,1
	addi 8,8,4732
	addi 10,10,1016
	cmpw 0,6,0
	bc 12,0,.L215
	blr
.Lfe23:
	.size	 SaveClientData,.Lfe23-SaveClientData
	.align 2
	.globl FetchClientEntData
	.type	 FetchClientEntData,@function
FetchClientEntData:
	lwz 11,84(3)
	lwz 0,724(11)
	stw 0,484(3)
	lwz 9,728(11)
	stw 9,488(3)
	lwz 0,732(11)
	cmpwi 0,0,0
	bclr 12,2
	lwz 0,268(3)
	ori 0,0,4096
	stw 0,268(3)
	blr
.Lfe24:
	.size	 FetchClientEntData,.Lfe24-FetchClientEntData
	.comm	maplist,1060,4
	.align 2
	.globl SyncUserInfo
	.type	 SyncUserInfo,@function
SyncUserInfo:
	stwu 1,-544(1)
	mflr 0
	stmw 29,532(1)
	stw 0,548(1)
	mr 29,4
	mr 31,3
	lwz 4,84(31)
	addi 30,1,8
	li 5,512
	mr 3,30
	addi 4,4,188
	crxor 6,6,6
	bl memcpy
	cmpwi 0,29,1
	bc 4,2,.L175
	lwz 3,84(31)
	bl InitClientPersistant
.L175:
	lis 9,globals+40@ha
	mr 3,31
	lwz 0,globals+40@l(9)
	mr 4,30
	mtlr 0
	blrl
	lwz 0,548(1)
	mtlr 0
	lmw 29,532(1)
	la 1,544(1)
	blr
.Lfe25:
	.size	 SyncUserInfo,.Lfe25-SyncUserInfo
	.comm	team_list,8,4
	.comm	id_GameCmds,492,4
	.section	".rodata"
	.align 2
.LC189:
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
	lis 9,.LC189@ha
	mr 30,3
	la 9,.LC189@l(9)
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
	lwz 0,304(31)
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
	lwz 3,304(30)
	cmpwi 0,3,0
	bc 12,2,.L14
	lwz 4,304(31)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L6
.L14:
	lwz 0,304(31)
	stw 0,304(30)
.L6:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe26:
	.size	 SP_FixCoopSpots,.Lfe26-SP_FixCoopSpots
	.section	".rodata"
	.align 3
.LC190:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC191:
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
	lis 11,.LC191@ha
	lis 9,coop@ha
	la 11,.LC191@l(11)
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
	lis 11,.LC190@ha
	stw 9,440(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC190@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(31)
.L18:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe27:
	.size	 SP_info_player_start,.Lfe27-SP_info_player_start
	.section	".rodata"
	.align 2
.LC192:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_player_deathmatch
	.type	 SP_info_player_deathmatch,@function
SP_info_player_deathmatch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC192@ha
	lis 9,deathmatch@ha
	la 11,.LC192@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L22
	bl G_FreeEdict
	b .L21
.L22:
	bl SP_misc_teleporter_dest
.L21:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe28:
	.size	 SP_info_player_deathmatch,.Lfe28-SP_info_player_deathmatch
	.align 2
	.globl SP_info_player_intermission
	.type	 SP_info_player_intermission,@function
SP_info_player_intermission:
	blr
.Lfe29:
	.size	 SP_info_player_intermission,.Lfe29-SP_info_player_intermission
	.align 2
	.globl SP_info_Infantry_Start
	.type	 SP_info_Infantry_Start,@function
SP_info_Infantry_Start:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl SP_info_reinforcement_start
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe30:
	.size	 SP_info_Infantry_Start,.Lfe30-SP_info_Infantry_Start
	.align 2
	.globl SP_info_L_Gunner_Start
	.type	 SP_info_L_Gunner_Start,@function
SP_info_L_Gunner_Start:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl SP_info_reinforcement_start
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe31:
	.size	 SP_info_L_Gunner_Start,.Lfe31-SP_info_L_Gunner_Start
	.align 2
	.globl SP_info_H_Gunner_Start
	.type	 SP_info_H_Gunner_Start,@function
SP_info_H_Gunner_Start:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl SP_info_reinforcement_start
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe32:
	.size	 SP_info_H_Gunner_Start,.Lfe32-SP_info_H_Gunner_Start
	.align 2
	.globl SP_info_Sniper_Start
	.type	 SP_info_Sniper_Start,@function
SP_info_Sniper_Start:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl SP_info_reinforcement_start
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe33:
	.size	 SP_info_Sniper_Start,.Lfe33-SP_info_Sniper_Start
	.align 2
	.globl SP_info_Engineer_Start
	.type	 SP_info_Engineer_Start,@function
SP_info_Engineer_Start:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl SP_info_reinforcement_start
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe34:
	.size	 SP_info_Engineer_Start,.Lfe34-SP_info_Engineer_Start
	.align 2
	.globl SP_info_Medic_Start
	.type	 SP_info_Medic_Start,@function
SP_info_Medic_Start:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl SP_info_reinforcement_start
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe35:
	.size	 SP_info_Medic_Start,.Lfe35-SP_info_Medic_Start
	.align 2
	.globl SP_info_Flamethrower_Start
	.type	 SP_info_Flamethrower_Start,@function
SP_info_Flamethrower_Start:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl SP_info_reinforcement_start
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe36:
	.size	 SP_info_Flamethrower_Start,.Lfe36-SP_info_Flamethrower_Start
	.align 2
	.globl SP_info_Special_Start
	.type	 SP_info_Special_Start,@function
SP_info_Special_Start:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl SP_info_reinforcement_start
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe37:
	.size	 SP_info_Special_Start,.Lfe37-SP_info_Special_Start
	.align 2
	.globl SP_info_Officer_Start
	.type	 SP_info_Officer_Start,@function
SP_info_Officer_Start:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl SP_info_reinforcement_start
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe38:
	.size	 SP_info_Officer_Start,.Lfe38-SP_info_Officer_Start
	.align 2
	.globl IsFemale
	.type	 IsFemale,@function
IsFemale:
	li 3,0
	blr
.Lfe39:
	.size	 IsFemale,.Lfe39-IsFemale
	.section	".rodata"
	.align 3
.LC193:
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
	bc 12,2,.L170
	lis 9,g_edicts@ha
	xor 11,5,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,5,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L170
	lfs 11,12(5)
	lfs 13,4(5)
	lfs 10,4(31)
	lfs 0,8(5)
	b .L631
.L170:
	cmpwi 0,4,0
	bc 12,2,.L172
	lis 9,g_edicts@ha
	xor 11,4,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,4,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L172
	lfs 11,12(4)
	lfs 13,4(4)
	lfs 10,4(31)
	lfs 0,8(4)
.L631:
	lfs 9,8(31)
	lfs 12,12(31)
	fsubs 13,13,10
	fsubs 0,0,9
	fsubs 11,11,12
	stfs 13,8(1)
	stfs 0,12(1)
	stfs 11,16(1)
	b .L171
.L172:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,4188(9)
	b .L169
.L171:
	lfs 1,12(1)
	lfs 2,8(1)
	bl atan2
	lis 9,.LC193@ha
	lwz 11,84(31)
	lfd 0,.LC193@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,4188(11)
.L169:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe40:
	.size	 LookAtKiller,.Lfe40-LookAtKiller
	.section	".rodata"
	.align 2
.LC194:
	.long 0x4b18967f
	.align 2
.LC195:
	.long 0x3f800000
	.align 3
.LC196:
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
	lis 11,.LC195@ha
	lwz 10,maxclients@l(9)
	la 11,.LC195@l(11)
	mr 31,3
	lfs 13,0(11)
	li 29,1
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC194@ha
	lfs 31,.LC194@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L222
	lis 9,.LC196@ha
	lis 27,g_edicts@ha
	la 9,.LC196@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,1016
.L224:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L223
	lwz 0,484(11)
	cmpwi 0,0,0
	bc 4,1,.L223
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
	bc 4,0,.L223
	fmr 31,1
.L223:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,1016
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L224
.L222:
	fmr 1,31
	lwz 0,84(1)
	mtlr 0
	lmw 26,40(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe41:
	.size	 PlayersRangeFromSpot,.Lfe41-PlayersRangeFromSpot
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
	bc 4,2,.L299
	bl SelectRandomDeathmatchSpawnPoint
	b .L633
.L299:
	bl SelectFarthestDeathmatchSpawnPoint
.L633:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe42:
	.size	 SelectDeathmatchSpawnPoint,.Lfe42-SelectDeathmatchSpawnPoint
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
	lis 9,0x23ec
	lwz 10,game+1028@l(11)
	ori 9,9,5983
	li 30,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,2
	bc 12,2,.L635
.L305:
	lis 5,.LC2@ha
	mr 3,30
	la 5,.LC2@l(5)
	li 4,284
	bl G_Find
	mr. 30,3
	bc 4,2,.L306
.L635:
	li 3,0
	b .L634
.L306:
	lwz 4,304(30)
	cmpwi 0,4,0
	bc 4,2,.L307
	lis 9,.LC21@ha
	la 4,.LC21@l(9)
.L307:
	lis 3,game+1032@ha
	la 3,game+1032@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L305
	addic. 31,31,-1
	bc 4,2,.L305
	mr 3,30
.L634:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe43:
	.size	 SelectCoopSpawnPoint,.Lfe43-SelectCoopSpawnPoint
	.section	".rodata"
	.align 2
.LC197:
	.long 0x41100000
	.section	".text"
	.align 2
	.globl SelectSpawnPoint
	.type	 SelectSpawnPoint,@function
SelectSpawnPoint:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 30,4
	mr 29,5
	li 31,0
	lis 27,.LC0@ha
	lis 28,game@ha
.L319:
	mr 3,31
	li 4,284
	la 5,.LC0@l(27)
	bl G_Find
	mr. 31,3
	bc 12,2,.L637
	la 3,game@l(28)
	lbz 0,1032(3)
	cmpwi 0,0,0
	bc 4,2,.L636
	lwz 0,304(31)
	cmpwi 0,0,0
	bc 12,2,.L314
	b .L319
.L636:
	lwz 4,304(31)
	cmpwi 0,4,0
	bc 12,2,.L319
	addi 3,3,1032
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L319
.L314:
	cmpwi 0,31,0
	bc 4,2,.L312
.L637:
	lis 9,game@ha
	la 28,game@l(9)
	lbz 0,1032(28)
	cmpwi 0,0,0
	bc 4,2,.L321
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,284
	bl G_Find
	mr 31,3
.L321:
	cmpwi 0,31,0
	bc 4,2,.L312
	lis 9,gi+28@ha
	lis 3,.LC121@ha
	lwz 0,gi+28@l(9)
	la 3,.LC121@l(3)
	addi 4,28,1032
	mtlr 0
	crxor 6,6,6
	blrl
.L312:
	lfs 0,4(31)
	lis 9,.LC197@ha
	la 9,.LC197@l(9)
	lfs 12,0(9)
	stfs 0,0(30)
	lfs 13,8(31)
	stfs 13,4(30)
	lfs 0,12(31)
	fadds 0,0,12
	stfs 0,8(30)
	lfs 13,16(31)
	stfs 13,0(29)
	lfs 0,20(31)
	stfs 0,4(29)
	lfs 13,24(31)
	stfs 13,8(29)
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe44:
	.size	 SelectSpawnPoint,.Lfe44-SelectSpawnPoint
	.section	".rodata"
	.align 2
.LC198:
	.long 0x41100000
	.section	".text"
	.align 2
	.globl Find_Mission_Start_Point
	.type	 Find_Mission_Start_Point,@function
Find_Mission_Start_Point:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	mr 29,4
	lwz 9,84(31)
	lwz 10,3448(9)
	lwz 11,3464(9)
	lwz 8,96(10)
	slwi 11,11,2
	lwz 30,84(10)
	lwzx 9,11,8
	mr 4,30
	lwz 3,64(9)
	bl SelectRandomDDaySpawnPoint
	mr. 3,3
	bc 4,2,.L325
	lis 3,.LC122@ha
	mr 4,30
	la 3,.LC122@l(3)
	bl SelectRandomDDaySpawnPoint
	mr. 3,3
	bc 4,2,.L325
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,284
	bl G_Find
.L325:
	lfs 0,4(3)
	lis 9,.LC198@ha
	la 9,.LC198@l(9)
	lfs 12,0(9)
	stfs 0,0(29)
	lfs 13,8(3)
	stfs 13,4(29)
	lfs 0,12(3)
	fadds 0,0,12
	stfs 0,8(29)
	lfs 13,16(3)
	lwz 11,84(31)
	stfs 13,16(31)
	lfs 0,20(3)
	stfs 0,20(31)
	lfs 13,24(3)
	stfs 13,24(31)
	lfs 0,16(3)
	stfs 0,28(11)
	lfs 0,20(3)
	lwz 9,84(31)
	stfs 0,32(9)
	lfs 0,24(3)
	lwz 11,84(31)
	stfs 0,36(11)
	lfs 0,16(3)
	lwz 9,84(31)
	stfs 0,4264(9)
	lfs 0,20(3)
	lwz 11,84(31)
	stfs 0,4268(11)
	lfs 0,24(3)
	lwz 9,84(31)
	stfs 0,4272(9)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe45:
	.size	 Find_Mission_Start_Point,.Lfe45-Find_Mission_Start_Point
	.section	".rodata"
	.align 2
.LC199:
	.long 0x3f800000
	.align 2
.LC200:
	.long 0x0
	.align 2
.LC201:
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
	lwz 0,484(31)
	cmpwi 0,0,-40
	bc 4,0,.L333
	lis 29,gi@ha
	lis 3,.LC96@ha
	la 29,gi@l(29)
	la 3,.LC96@l(3)
	lwz 9,36(29)
	lis 27,.LC97@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC199@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC199@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC199@ha
	la 9,.LC199@l(9)
	lfs 2,0(9)
	lis 9,.LC200@ha
	la 9,.LC200@l(9)
	lfs 3,0(9)
	blrl
.L337:
	mr 3,31
	la 4,.LC97@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L337
	lis 9,.LC201@ha
	lfs 0,12(31)
	mr 4,28
	la 9,.LC201@l(9)
	mr 3,31
	lfs 13,0(9)
	fsubs 0,0,13
	stfs 0,12(31)
	bl ThrowClientHead
	stw 30,516(31)
.L333:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe46:
	.size	 body_die,.Lfe46-body_die
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
	lwz 0,484(8)
	cmpwi 0,0,0
	bc 4,1,.L432
	lis 11,gi+48@ha
	lis 9,0x201
	lwz 0,gi+48@l(11)
	ori 9,9,3
	mtlr 0
	blrl
	b .L431
.L432:
	lis 11,gi+48@ha
	lis 9,0x1
	lwz 0,gi+48@l(11)
	mr 3,31
	ori 9,9,3
	mtlr 0
	blrl
.L431:
	mr 3,31
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe47:
	.size	 PM_trace,.Lfe47-PM_trace
	.align 2
	.globl CheckBlock
	.type	 CheckBlock,@function
CheckBlock:
	li 11,0
	li 9,0
	cmpw 0,11,4
	bc 4,0,.L436
.L438:
	lbzx 0,3,9
	addi 9,9,1
	cmpw 0,9,4
	add 11,11,0
	bc 12,0,.L438
.L436:
	mr 3,11
	blr
.Lfe48:
	.size	 CheckBlock,.Lfe48-CheckBlock
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
.L639:
	lbzx 0,3,9
	addi 9,9,1
	add 5,5,0
	bdnz .L639
	li 0,16
	lbz 4,42(3)
	li 6,0
	mtctr 0
	addi 3,3,28
	li 9,0
.L638:
	lbzx 0,3,9
	addi 9,9,1
	add 6,6,0
	bdnz .L638
	lis 3,.LC158@ha
	la 3,.LC158@l(3)
	crxor 6,6,6
	bl Com_Printf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe49:
	.size	 PrintPmove,.Lfe49-PrintPmove
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
	stw 28,304(3)
	bl G_Spawn
	lis 0,0x437c
	stw 27,20(3)
	stw 0,4(3)
	stw 29,284(3)
	stw 26,8(3)
	stw 25,12(3)
	stw 28,304(3)
	bl G_Spawn
	lis 0,0x439e
	stw 27,20(3)
	stw 29,284(3)
	stw 0,4(3)
	stw 26,8(3)
	stw 25,12(3)
	stw 28,304(3)
.L17:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe50:
	.size	 SP_CreateCoopSpots,.Lfe50-SP_CreateCoopSpots
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
