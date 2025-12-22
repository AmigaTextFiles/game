	.file	"p_client.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"skin"
	.align 2
.LC1:
	.string	""
	.align 2
.LC2:
	.string	"kicked for suiciding"
	.align 2
.LC3:
	.string	"suicides"
	.align 2
.LC4:
	.string	"cratered"
	.align 2
.LC5:
	.string	"was squished"
	.align 2
.LC6:
	.string	"sank like a rock"
	.align 2
.LC7:
	.string	"melted"
	.align 2
.LC8:
	.string	"does a back flip into the lava"
	.align 2
.LC9:
	.string	"blew up"
	.align 2
.LC10:
	.string	"found a way out"
	.align 2
.LC11:
	.string	"watches Jean-Michel Jarre laser-show"
	.align 2
.LC12:
	.string	"was gassed"
	.align 2
.LC13:
	.string	"got blasted"
	.align 2
.LC14:
	.string	"was in the wrong place"
	.align 2
.LC15:
	.string	"tried to put the pin back in"
	.align 2
.LC16:
	.string	"tripped on her own grenade"
	.align 2
.LC17:
	.string	"tripped on his own grenade"
	.align 2
.LC18:
	.string	"blew herself up"
	.align 2
.LC19:
	.string	"blew himself up"
	.align 2
.LC20:
	.string	"should have used a smaller gun"
	.align 2
.LC21:
	.string	"burned herself"
	.align 2
.LC22:
	.string	"burned himself"
	.align 2
.LC23:
	.string	"became toast"
	.align 2
.LC24:
	.string	"searches for his legs"
	.align 2
.LC25:
	.string	"killed herself"
	.align 2
.LC26:
	.string	"killed himself"
	.align 2
.LC27:
	.string	"%s %s.\n"
	.align 2
.LC28:
	.string	"was blasted by"
	.align 2
.LC29:
	.string	"was gunned down by"
	.align 2
.LC30:
	.string	"was blown away by"
	.align 2
.LC31:
	.string	"'s super shotgun"
	.align 2
.LC32:
	.string	"was killed by"
	.align 2
.LC33:
	.string	"was machinegunned by"
	.align 2
.LC34:
	.string	"was cut in half by"
	.align 2
.LC35:
	.string	"'s chaingun"
	.align 2
.LC36:
	.string	"was popped by"
	.align 2
.LC37:
	.string	"'s grenade"
	.align 2
.LC38:
	.string	"was shredded by"
	.align 2
.LC39:
	.string	"'s shrapnel"
	.align 2
.LC40:
	.string	"ate"
	.align 2
.LC41:
	.string	"'s rocket"
	.align 2
.LC42:
	.string	"almost dodged"
	.align 2
.LC43:
	.string	"was melted by"
	.align 2
.LC44:
	.string	"'s hyperblaster"
	.align 2
.LC45:
	.string	"was railed by"
	.align 2
.LC46:
	.string	"saw the pretty lights from"
	.align 2
.LC47:
	.string	"'s BFG"
	.align 2
.LC48:
	.string	"was disintegrated by"
	.align 2
.LC49:
	.string	"'s BFG blast"
	.align 2
.LC50:
	.string	"couldn't hide from"
	.align 2
.LC51:
	.string	"caught"
	.align 2
.LC52:
	.string	"'s handgrenade"
	.align 2
.LC53:
	.string	"didn't see"
	.align 2
.LC54:
	.string	"feels"
	.align 2
.LC55:
	.string	"'s pain"
	.align 2
.LC56:
	.string	"tried to invade"
	.align 2
.LC57:
	.string	"'s personal space"
	.align 2
.LC58:
	.string	"was charbroiled by"
	.align 2
.LC59:
	.string	"'s plasma grenade"
	.align 2
.LC60:
	.string	"was caught in act by"
	.align 2
.LC61:
	.string	"'s plasma rifle"
	.align 2
.LC62:
	.string	"was perforated by"
	.align 2
.LC63:
	.string	"'s rail grenade"
	.align 2
.LC64:
	.string	"'s leapfrog grenade"
	.align 2
.LC65:
	.string	"was scorched by"
	.align 2
.LC66:
	.string	"was cremated by"
	.align 2
.LC67:
	.string	"got flamed by"
	.align 2
.LC68:
	.string	"flies with"
	.align 2
.LC69:
	.string	"'s pipebomb"
	.align 2
.LC70:
	.string	"%s "
	.align 2
.LC71:
	.string	"%s"
	.align 2
.LC72:
	.string	" %s "
	.align 2
.LC73:
	.string	"%s\n"
	.align 2
.LC74:
	.string	"sentry"
	.align 2
.LC75:
	.string	"%s was cut in half by %s's sentrygun\n"
	.align 2
.LC76:
	.string	"%s was gibbed by %s's sentrygun\n"
	.align 2
.LC77:
	.string	"%s rides %s's sentrygun rocket\n"
	.align 2
.LC78:
	.string	"%s was perforated by %s's sentrygun\n"
	.align 2
.LC79:
	.string	"%s was railed by %s's sentrygun\n"
	.align 2
.LC80:
	.string	"%s died.\n"
	.section	".text"
	.align 2
	.globl ClientObituary
	.type	 ClientObituary,@function
ClientObituary:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	lis 9,meansOfDeath@ha
	lis 11,.LC1@ha
	lwz 0,meansOfDeath@l(9)
	mr 29,3
	mr 27,5
	la 28,.LC1@l(11)
	li 31,0
	rlwinm 30,0,0,5,3
	rlwinm 26,0,0,4,4
	cmpwi 0,30,39
	bc 12,2,.L22
	addi 10,30,-17
	cmplwi 0,10,20
	bc 12,1,.L24
	lis 11,.L42@ha
	slwi 10,10,2
	la 11,.L42@l(11)
	lis 9,.L42@ha
	lwzx 0,10,11
	la 9,.L42@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L42:
	.long .L30-.L42
	.long .L31-.L42
	.long .L32-.L42
	.long .L29-.L42
	.long .L24-.L42
	.long .L28-.L42
	.long .L25-.L42
	.long .L24-.L42
	.long .L34-.L42
	.long .L34-.L42
	.long .L41-.L42
	.long .L35-.L42
	.long .L41-.L42
	.long .L36-.L42
	.long .L41-.L42
	.long .L24-.L42
	.long .L38-.L42
	.long .L24-.L42
	.long .L24-.L42
	.long .L24-.L42
	.long .L37-.L42
.L25:
	lis 10,ripflags@ha
	lwz 9,ripflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1
	bc 12,2,.L26
	lis 9,.LC2@ha
	la 31,.LC2@l(9)
	b .L24
.L26:
	lis 9,.LC3@ha
	la 31,.LC3@l(9)
	b .L24
.L28:
	lis 9,.LC4@ha
	la 31,.LC4@l(9)
	b .L24
.L29:
	lis 9,.LC5@ha
	la 31,.LC5@l(9)
	b .L24
.L30:
	lis 9,.LC6@ha
	la 31,.LC6@l(9)
	b .L24
.L31:
	lis 9,.LC7@ha
	la 31,.LC7@l(9)
	b .L24
.L32:
	lis 9,.LC8@ha
	la 31,.LC8@l(9)
	b .L24
.L34:
	lis 9,.LC9@ha
	la 31,.LC9@l(9)
	b .L24
.L35:
	lis 9,.LC10@ha
	la 31,.LC10@l(9)
	b .L24
.L36:
	lis 9,.LC11@ha
	la 31,.LC11@l(9)
	b .L24
.L37:
	lis 9,.LC12@ha
	la 31,.LC12@l(9)
	b .L24
.L38:
	lis 9,.LC13@ha
	la 31,.LC13@l(9)
	b .L24
.L41:
	lis 9,.LC14@ha
	la 31,.LC14@l(9)
.L24:
	cmpw 0,27,29
	bc 4,2,.L44
	cmpwi 0,30,24
	bc 12,2,.L46
	bc 12,1,.L77
	cmpwi 0,30,9
	bc 12,2,.L54
	bc 12,1,.L78
	cmpwi 0,30,7
	bc 12,2,.L48
	b .L70
.L78:
	cmpwi 0,30,13
	bc 12,2,.L60
	cmpwi 0,30,16
	bc 12,2,.L48
	b .L70
.L77:
	cmpwi 0,30,101
	bc 12,2,.L62
	bc 12,1,.L79
	cmpwi 0,30,41
	bc 12,2,.L69
	b .L70
.L79:
	cmpwi 0,30,102
	bc 12,2,.L68
	cmpwi 0,30,103
	bc 12,2,.L62
	b .L70
.L46:
	lis 9,.LC15@ha
	la 31,.LC15@l(9)
	b .L44
.L48:
	mr 3,29
	bl G_ClientExists
	cmpwi 0,3,0
	bc 4,2,.L50
	li 0,0
	b .L51
.L50:
	lwz 3,84(29)
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	addi 3,3,188
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 11,9,0
	adde 9,11,9
	xori 0,0,102
	subfic 11,0,0
	adde 0,11,0
	or 0,0,9
.L51:
	cmpwi 0,0,0
	bc 12,2,.L49
	lis 9,.LC16@ha
	la 31,.LC16@l(9)
	b .L44
.L49:
	lis 9,.LC17@ha
	la 31,.LC17@l(9)
	b .L44
.L54:
	mr 3,29
	bl G_ClientExists
	cmpwi 0,3,0
	bc 4,2,.L56
	li 0,0
	b .L57
.L56:
	lwz 3,84(29)
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	addi 3,3,188
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 11,9,0
	adde 9,11,9
	xori 0,0,102
	subfic 11,0,0
	adde 0,11,0
	or 0,0,9
.L57:
	cmpwi 0,0,0
	bc 12,2,.L55
	lis 9,.LC18@ha
	la 31,.LC18@l(9)
	b .L44
.L55:
	lis 9,.LC19@ha
	la 31,.LC19@l(9)
	b .L44
.L60:
	lis 9,.LC20@ha
	la 31,.LC20@l(9)
	b .L44
.L62:
	mr 3,29
	bl G_ClientExists
	cmpwi 0,3,0
	bc 4,2,.L64
	li 0,0
	b .L65
.L64:
	lwz 3,84(29)
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	addi 3,3,188
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 11,9,0
	adde 9,11,9
	xori 0,0,102
	subfic 11,0,0
	adde 0,11,0
	or 0,0,9
.L65:
	cmpwi 0,0,0
	bc 12,2,.L63
	lis 9,.LC21@ha
	la 31,.LC21@l(9)
	b .L44
.L63:
	lis 9,.LC22@ha
	la 31,.LC22@l(9)
	b .L44
.L68:
	lis 9,.LC23@ha
	la 31,.LC23@l(9)
	b .L44
.L69:
	lis 9,.LC24@ha
	la 31,.LC24@l(9)
	b .L44
.L70:
	mr 3,29
	bl G_ClientExists
	cmpwi 0,3,0
	bc 4,2,.L72
	li 0,0
	b .L73
.L72:
	lwz 3,84(29)
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	addi 3,3,188
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 11,9,0
	adde 9,11,9
	xori 0,0,102
	subfic 11,0,0
	adde 0,11,0
	or 0,0,9
.L73:
	cmpwi 0,0,0
	bc 12,2,.L71
	lis 9,.LC25@ha
	la 31,.LC25@l(9)
	b .L44
.L71:
	lis 9,.LC26@ha
	la 31,.LC26@l(9)
.L44:
	cmpwi 0,31,0
	bc 12,2,.L80
	lis 9,gi@ha
	lwz 5,84(29)
	lis 4,.LC27@ha
	lwz 0,gi@l(9)
	la 4,.LC27@l(4)
	mr 6,31
	addi 5,5,700
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(29)
	li 0,0
	lwz 9,1816(11)
	addi 9,9,-1
	stw 9,1816(11)
	stw 0,540(29)
	b .L22
.L80:
	cmpwi 0,27,0
	stw 27,540(29)
	bc 12,2,.L81
	lwz 0,84(27)
	cmpwi 0,0,0
	bc 12,2,.L81
	addi 0,30,-1
	cmplwi 0,0,102
	bc 12,1,.L82
	lis 11,.L110@ha
	slwi 10,0,2
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
	.long .L83-.L110
	.long .L84-.L110
	.long .L85-.L110
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
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L101-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L100-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L104-.L110
	.long .L102-.L110
	.long .L82-.L110
	.long .L105-.L110
	.long .L82-.L110
	.long .L86-.L110
	.long .L103-.L110
	.long .L109-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L82-.L110
	.long .L106-.L110
	.long .L107-.L110
	.long .L108-.L110
.L83:
	lis 9,.LC28@ha
	la 31,.LC28@l(9)
	b .L82
.L84:
	lis 9,.LC29@ha
	la 31,.LC29@l(9)
	b .L82
.L85:
	lis 9,.LC30@ha
	lis 11,.LC31@ha
	la 31,.LC30@l(9)
	la 28,.LC31@l(11)
	b .L82
.L86:
	lis 9,.LC32@ha
	la 31,.LC32@l(9)
	b .L82
.L87:
	lis 9,.LC33@ha
	la 31,.LC33@l(9)
	b .L82
.L88:
	lis 9,.LC34@ha
	lis 11,.LC35@ha
	la 31,.LC34@l(9)
	la 28,.LC35@l(11)
	b .L82
.L89:
	lis 9,.LC36@ha
	lis 11,.LC37@ha
	la 31,.LC36@l(9)
	la 28,.LC37@l(11)
	b .L82
.L90:
	lis 9,.LC38@ha
	lis 11,.LC39@ha
	la 31,.LC38@l(9)
	la 28,.LC39@l(11)
	b .L82
.L91:
	lis 9,.LC40@ha
	lis 11,.LC41@ha
	la 31,.LC40@l(9)
	la 28,.LC41@l(11)
	b .L82
.L92:
	lis 9,.LC42@ha
	lis 11,.LC41@ha
	la 31,.LC42@l(9)
	la 28,.LC41@l(11)
	b .L82
.L93:
	lis 9,.LC43@ha
	lis 11,.LC44@ha
	la 31,.LC43@l(9)
	la 28,.LC44@l(11)
	b .L82
.L94:
	lis 9,.LC45@ha
	la 31,.LC45@l(9)
	b .L82
.L95:
	lis 9,.LC46@ha
	lis 11,.LC47@ha
	la 31,.LC46@l(9)
	la 28,.LC47@l(11)
	b .L82
.L96:
	lis 9,.LC48@ha
	lis 11,.LC49@ha
	la 31,.LC48@l(9)
	la 28,.LC49@l(11)
	b .L82
.L97:
	lis 9,.LC50@ha
	lis 11,.LC47@ha
	la 31,.LC50@l(9)
	la 28,.LC47@l(11)
	b .L82
.L98:
	lis 9,.LC51@ha
	lis 11,.LC52@ha
	la 31,.LC51@l(9)
	la 28,.LC52@l(11)
	b .L82
.L99:
	lis 9,.LC53@ha
	lis 11,.LC52@ha
	la 31,.LC53@l(9)
	la 28,.LC52@l(11)
	b .L82
.L100:
	lis 9,.LC54@ha
	lis 11,.LC55@ha
	la 31,.LC54@l(9)
	la 28,.LC55@l(11)
	b .L82
.L101:
	lis 9,.LC56@ha
	lis 11,.LC57@ha
	la 31,.LC56@l(9)
	la 28,.LC57@l(11)
	b .L82
.L102:
	lis 9,.LC58@ha
	lis 11,.LC59@ha
	la 31,.LC58@l(9)
	la 28,.LC59@l(11)
	b .L82
.L103:
	lis 9,.LC60@ha
	lis 11,.LC61@ha
	la 31,.LC60@l(9)
	la 28,.LC61@l(11)
	b .L82
.L104:
	lis 9,.LC62@ha
	lis 11,.LC63@ha
	la 31,.LC62@l(9)
	la 28,.LC63@l(11)
	b .L82
.L105:
	lis 9,.LC50@ha
	lis 11,.LC64@ha
	la 31,.LC50@l(9)
	la 28,.LC64@l(11)
	b .L82
.L106:
	lis 9,.LC65@ha
	la 31,.LC65@l(9)
	b .L82
.L107:
	lis 9,.LC66@ha
	la 31,.LC66@l(9)
	b .L82
.L108:
	lis 9,.LC67@ha
	la 31,.LC67@l(9)
	b .L82
.L109:
	lis 9,.LC68@ha
	lis 11,.LC69@ha
	la 31,.LC68@l(9)
	la 28,.LC69@l(11)
.L82:
	cmpwi 0,31,0
	bc 12,2,.L22
	lwz 5,84(29)
	lis 4,.LC70@ha
	li 3,1
	lis 29,gi@ha
	la 4,.LC70@l(4)
	lwz 9,gi@l(29)
	addi 5,5,700
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,gi@l(29)
	lis 4,.LC71@ha
	mr 5,31
	la 4,.LC71@l(4)
	li 3,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,gi@l(29)
	lis 4,.LC72@ha
	li 3,1
	lwz 5,84(27)
	la 4,.LC72@l(4)
	mtlr 9
	addi 5,5,700
	crxor 6,6,6
	blrl
	lwz 0,gi@l(29)
	lis 4,.LC73@ha
	mr 5,28
	la 4,.LC73@l(4)
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	cmpwi 0,26,0
	bc 12,2,.L22
	lwz 11,84(27)
	b .L128
.L81:
	lwz 3,280(27)
	lis 4,.LC74@ha
	la 4,.LC74@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L116
	lis 9,MeanOfDeath@ha
	lwz 0,MeanOfDeath@l(9)
	cmpwi 0,0,1
	bc 4,2,.L117
	lwz 9,1100(27)
	lis 11,gi@ha
	lis 4,.LC75@ha
	lwz 5,84(29)
	la 4,.LC75@l(4)
	b .L129
.L117:
	cmpwi 0,0,2
	bc 4,2,.L119
	lwz 0,480(29)
	cmpwi 0,0,-40
	bc 4,0,.L120
	lwz 9,1100(27)
	lis 11,gi@ha
	lis 4,.LC76@ha
	lwz 5,84(29)
	la 4,.LC76@l(4)
	b .L129
.L120:
	lwz 9,1100(27)
	lis 11,gi@ha
	lis 4,.LC77@ha
	lwz 5,84(29)
	la 4,.LC77@l(4)
	b .L129
.L119:
	cmpwi 0,0,3
	bc 4,2,.L118
	lwz 0,480(29)
	cmpwi 0,0,-40
	bc 4,0,.L124
	lwz 9,1100(27)
	lis 11,gi@ha
	lis 4,.LC78@ha
	lwz 5,84(29)
	la 4,.LC78@l(4)
.L129:
	li 3,1
	lwz 6,84(9)
	lwz 0,gi@l(11)
	addi 5,5,700
	addi 6,6,700
	mtlr 0
	crxor 6,6,6
	blrl
	b .L118
.L124:
	lwz 9,1100(27)
	lis 11,gi@ha
	lis 4,.LC79@ha
	lwz 5,84(29)
	la 4,.LC79@l(4)
	li 3,1
	lwz 6,84(9)
	lwz 0,gi@l(11)
	addi 5,5,700
	addi 6,6,700
	mtlr 0
	crxor 6,6,6
	blrl
.L118:
	lis 9,MeanOfDeath@ha
	li 0,0
	stw 0,MeanOfDeath@l(9)
	b .L22
.L116:
	lis 9,gi@ha
	lwz 5,84(29)
	lis 4,.LC80@ha
	lwz 0,gi@l(9)
	la 4,.LC80@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(29)
.L128:
	lwz 9,1816(11)
	addi 9,9,-1
	stw 9,1816(11)
.L22:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 ClientObituary,.Lfe1-ClientObituary
	.section	".rodata"
	.align 2
.LC81:
	.string	"Blaster"
	.align 2
.LC82:
	.string	"Flame Launcher"
	.align 2
.LC83:
	.string	"Flamethrower"
	.align 2
.LC84:
	.string	"Pipebomb Launcher"
	.align 2
.LC85:
	.string	"item_quad"
	.align 3
.LC86:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC87:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC88:
	.long 0x0
	.align 2
.LC89:
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
	mr 30,3
	lwz 9,84(30)
	lwz 11,2000(9)
	addi 10,9,740
	lwz 31,1788(9)
	slwi 11,11,2
	lwzx 9,10,11
	srawi 10,9,31
	xor 0,10,9
	subf 0,0,10
	srawi 0,0,31
	and. 31,31,0
	bc 12,2,.L135
	lwz 3,40(31)
	lis 4,.LC81@ha
	la 4,.LC81@l(4)
	bl strcmp
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	and. 31,31,0
	bc 12,2,.L135
	lwz 3,40(31)
	lis 4,.LC82@ha
	la 4,.LC82@l(4)
	bl strcmp
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	and. 31,31,0
	bc 12,2,.L135
	lwz 3,40(31)
	lis 4,.LC83@ha
	la 4,.LC83@l(4)
	bl strcmp
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	and. 31,31,0
	bc 12,2,.L135
	lwz 3,40(31)
	lis 4,.LC84@ha
	la 4,.LC84@l(4)
	bl strcmp
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	and 31,31,0
.L135:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,16384
	bc 4,2,.L136
	li 29,0
	b .L137
.L136:
	lis 10,level@ha
	lwz 8,84(30)
	lwz 9,level@l(10)
	lis 0,0x4330
	lis 10,.LC87@ha
	lfs 12,2196(8)
	addi 9,9,10
	la 10,.LC87@l(10)
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
.L137:
	addic 11,31,-1
	subfe 0,11,31
	lis 9,.LC88@ha
	and. 10,0,29
	la 9,.LC88@l(9)
	lfs 31,0(9)
	bc 12,2,.L138
	lis 11,.LC89@ha
	la 11,.LC89@l(11)
	lfs 31,0(11)
.L138:
	cmpwi 0,31,0
	bc 12,2,.L140
	lwz 9,84(30)
	mr 4,31
	mr 3,30
	lfs 0,2128(9)
	fsubs 0,0,31
	stfs 0,2128(9)
	bl Drop_Item
	lwz 9,84(30)
	lis 0,0x2
	lfs 0,2128(9)
	fadds 0,0,31
	stfs 0,2128(9)
	stw 0,284(3)
.L140:
	cmpwi 0,29,0
	bc 12,2,.L141
	lwz 9,84(30)
	lis 3,.LC85@ha
	la 3,.LC85@l(3)
	lfs 0,2128(9)
	fadds 0,0,31
	stfs 0,2128(9)
	bl FindItemByClassname
	mr 4,3
	mr 3,30
	bl Drop_Item
	lwz 7,84(30)
	lis 9,.LC87@ha
	lis 11,Touch_Item@ha
	la 9,.LC87@l(9)
	la 11,Touch_Item@l(11)
	lfs 0,2128(7)
	lis 6,level@ha
	lfd 10,0(9)
	lis 4,0x4330
	la 5,level@l(6)
	lis 9,.LC86@ha
	lis 10,G_FreeEdict@ha
	fsubs 0,0,31
	lfd 11,.LC86@l(9)
	la 10,G_FreeEdict@l(10)
	stfs 0,2128(7)
	lwz 0,284(3)
	stw 11,444(3)
	oris 0,0,0x2
	stw 0,284(3)
	lwz 9,level@l(6)
	lwz 11,84(30)
	xoris 9,9,0x8000
	lfs 12,4(5)
	stw 9,20(1)
	stw 4,16(1)
	lfd 13,16(1)
	lfs 0,2196(11)
	stw 10,436(3)
	fsub 13,13,10
	frsp 13,13
	fsubs 0,0,13
	fmadd 0,0,11,12
	frsp 0,0
	stfs 0,428(3)
.L141:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 TossClientWeapon,.Lfe2-TossClientWeapon
	.section	".rodata"
	.align 2
.LC91:
	.string	"pipebomb"
	.align 2
.LC93:
	.string	"off"
	.align 2
.LC94:
	.string	"misc/udeath.wav"
	.align 2
.LC95:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.section	".sbss","aw",@nobits
	.align 2
i.36:
	.space	4
	.size	 i.36,4
	.section	".rodata"
	.align 2
.LC96:
	.string	"*death%i.wav"
	.align 3
.LC92:
	.long 0x404ca5dc
	.long 0x1a63c1f8
	.align 3
.LC97:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC98:
	.long 0x3f800000
	.align 2
.LC99:
	.long 0x0
	.section	".text"
	.align 2
	.globl player_die
	.type	 player_die,@function
player_die:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 31,3
	mr 30,4
	mr 28,5
	mr 27,6
	li 29,0
	b .L148
.L150:
	lwz 3,256(29)
	bl G_EntExists
	cmpwi 0,3,0
	bc 12,2,.L151
	lwz 0,256(29)
	cmpw 0,0,31
	bc 4,2,.L148
.L151:
	lwz 9,436(29)
	mr 3,29
	mtlr 9
	blrl
.L148:
	lis 5,.LC91@ha
	mr 3,29
	la 5,.LC91@l(5)
	li 4,280
	bl G_Find
	mr. 29,3
	bc 4,2,.L150
	lwz 3,1096(31)
	bl G_EntExists
	cmpwi 0,3,0
	bc 12,2,.L153
	lwz 3,1096(31)
	bl G_FreeEdict
.L153:
	li 9,0
	lwz 10,84(31)
	li 0,1
	li 11,7
	stw 0,512(31)
	lis 8,0xc100
	stw 11,260(31)
	stw 9,24(31)
	stw 9,396(31)
	stw 9,392(31)
	stw 9,388(31)
	stw 9,16(31)
	stw 29,44(31)
	stw 29,48(31)
	stw 29,76(31)
	stw 29,2224(10)
	lwz 9,84(31)
	stw 29,736(9)
	lwz 11,84(31)
	stw 29,2244(11)
	lwz 9,492(31)
	lwz 0,184(31)
	cmpwi 0,9,0
	stw 8,208(31)
	ori 0,0,2
	stw 29,908(31)
	stw 0,184(31)
	bc 4,2,.L154
	lis 9,level+4@ha
	lis 11,.LC97@ha
	lfs 0,level+4@l(9)
	la 11,.LC97@l(11)
	cmpwi 0,28,0
	lfd 13,0(11)
	lwz 11,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,2228(11)
	bc 12,2,.L155
	lis 9,g_edicts@ha
	xor 11,28,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,28,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L155
	lfs 11,4(31)
	lfs 13,4(28)
	lfs 12,8(28)
	lfs 10,8(31)
	fsubs 13,13,11
	lfs 0,12(28)
	b .L184
.L155:
	cmpwi 0,30,0
	bc 12,2,.L157
	lis 9,g_edicts@ha
	xor 11,30,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,30,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L157
	lfs 11,4(31)
	lfs 13,4(30)
	lfs 12,8(30)
	lfs 10,8(31)
	fsubs 13,13,11
	lfs 0,12(30)
.L184:
	lfs 11,12(31)
	fsubs 12,12,10
	stfs 13,8(1)
	fsubs 0,0,11
	stfs 12,12(1)
	stfs 0,16(1)
	b .L156
.L157:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,2052(9)
	b .L159
.L156:
	lfs 1,12(1)
	lfs 2,8(1)
	bl atan2
	lis 9,.LC92@ha
	lwz 11,84(31)
	lfd 0,.LC92@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,2052(11)
.L159:
	lwz 9,84(31)
	li 0,2
	mr 3,31
	mr 4,30
	mr 5,28
	stw 0,0(9)
	bl ClientObituary
	mr 4,30
	mr 5,28
	mr 3,31
	bl CTFFragBonuses
	mr 3,31
	bl CTFDeadDropFlag
	lwz 9,84(31)
	lwz 0,2264(9)
	cmpwi 0,0,0
	bc 12,2,.L160
	lis 4,.LC93@ha
	mr 3,31
	la 4,.LC93@l(4)
	bl ChasecamRemove
.L160:
	lwz 9,84(31)
	lwz 0,1916(9)
	cmpwi 0,0,0
	bc 4,2,.L161
	mr 3,31
	bl Cmd_Help_f
.L161:
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lwz 0,1556(9)
	cmpw 0,30,0
	bc 4,0,.L154
	mr 8,9
	li 10,0
	li 11,0
.L165:
	lwz 9,84(31)
	addi 30,30,1
	addi 9,9,740
	stwx 10,9,11
	lwz 0,1556(8)
	addi 11,11,4
	cmpw 0,30,0
	bc 12,0,.L165
.L154:
	lwz 11,84(31)
	li 0,0
	stw 0,2196(11)
	lwz 9,84(31)
	stw 0,2200(9)
	lwz 11,84(31)
	stw 0,2204(11)
	lwz 9,84(31)
	stw 0,2208(9)
	lwz 11,480(31)
	lwz 0,264(31)
	cmpwi 0,11,-40
	rlwinm 0,0,0,20,18
	stw 0,264(31)
	bc 4,0,.L167
	lis 29,gi@ha
	lis 3,.LC94@ha
	la 29,gi@l(29)
	la 3,.LC94@l(3)
	lwz 9,36(29)
	lis 28,.LC95@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC98@ha
	lwz 0,16(29)
	lis 11,.LC98@ha
	la 9,.LC98@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC98@l(11)
	li 4,4
	mtlr 0
	lis 9,.LC99@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC99@l(9)
	lfs 3,0(9)
	blrl
.L171:
	mr 3,31
	la 4,.LC95@l(28)
	mr 5,27
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L171
	mr 4,27
	mr 3,31
	bl ThrowClientHead
	li 0,0
	stw 0,512(31)
	b .L173
.L167:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L173
	lis 8,i.36@ha
	lis 9,0x5555
	lwz 6,84(31)
	lwz 10,i.36@l(8)
	ori 9,9,21846
	li 7,5
	addi 10,10,1
	mulhw 9,10,9
	srawi 11,10,31
	subf 9,11,9
	slwi 0,9,1
	add 0,0,9
	subf 10,0,10
	stw 10,i.36@l(8)
	stw 7,2184(6)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L175
	li 0,172
	li 9,177
	b .L185
.L175:
	cmpwi 0,10,1
	bc 12,2,.L179
	bc 12,1,.L183
	cmpwi 0,10,0
	bc 12,2,.L178
	b .L176
.L183:
	cmpwi 0,10,2
	bc 12,2,.L180
	b .L176
.L178:
	li 0,177
	li 9,183
	b .L185
.L179:
	li 0,183
	li 9,189
	b .L185
.L180:
	li 0,189
	li 9,197
.L185:
	stw 0,56(31)
	stw 9,2180(11)
.L176:
	lis 29,gi@ha
	la 29,gi@l(29)
	bl rand
	mr 4,3
	srawi 0,4,31
	lis 3,.LC96@ha
	srwi 0,0,30
	la 3,.LC96@l(3)
	add 0,4,0
	rlwinm 0,0,0,0,29
	subf 4,0,4
	addi 4,4,1
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC98@ha
	lwz 0,16(29)
	lis 11,.LC98@ha
	la 9,.LC98@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC98@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC99@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC99@l(9)
	lfs 3,0(9)
	blrl
.L173:
	li 0,2
	lis 9,gi+72@ha
	stw 0,492(31)
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 player_die,.Lfe3-player_die
	.section	".rodata"
	.align 2
.LC102:
	.string	"info_player_deathmatch"
	.align 2
.LC101:
	.long 0x47c34f80
	.align 2
.LC103:
	.long 0x4b18967f
	.align 2
.LC104:
	.long 0x3f800000
	.align 3
.LC105:
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
	lis 9,.LC101@ha
	li 28,0
	lfs 29,.LC101@l(9)
	li 30,0
	li 23,0
	li 24,0
	fmr 28,29
	lis 22,.LC102@ha
	b .L207
.L209:
	lis 10,.LC104@ha
	lis 9,maxclients@ha
	la 10,.LC104@l(10)
	lis 11,.LC103@ha
	lfs 13,0(10)
	addi 28,28,1
	li 29,1
	lwz 10,maxclients@l(9)
	lis 25,maxclients@ha
	lfs 31,.LC103@l(11)
	lfs 0,20(10)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L217
	lis 11,.LC105@ha
	lis 26,g_edicts@ha
	la 11,.LC105@l(11)
	lis 27,0x4330
	lfd 30,0(11)
	li 31,1116
.L212:
	lwz 0,g_edicts@l(26)
	add 11,0,31
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L214
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L214
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
	bc 4,0,.L214
	fmr 31,1
.L214:
	addi 29,29,1
	lwz 11,maxclients@l(25)
	xoris 0,29,0x8000
	addi 31,31,1116
	stw 0,36(1)
	stw 27,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L212
.L217:
	fcmpu 0,31,28
	bc 4,0,.L219
	fmr 28,31
	mr 24,30
	b .L207
.L219:
	fcmpu 0,31,29
	bc 4,0,.L207
	fmr 29,31
	mr 23,30
.L207:
	lis 5,.LC102@ha
	mr 3,30
	la 5,.LC102@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L209
	cmpwi 0,28,0
	bc 4,2,.L223
	li 3,0
	b .L231
.L223:
	cmpwi 0,28,2
	bc 12,1,.L224
	li 23,0
	li 24,0
	b .L225
.L224:
	addi 28,28,-2
.L225:
	bl rand
	li 30,0
	divw 0,3,28
	mullw 0,0,28
	subf 31,0,3
.L230:
	mr 3,30
	li 4,280
	la 5,.LC102@l(22)
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
	bc 4,2,.L230
.L231:
	lwz 0,116(1)
	mtlr 0
	lmw 22,40(1)
	lfd 28,80(1)
	lfd 29,88(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe4:
	.size	 SelectRandomDeathmatchSpawnPoint,.Lfe4-SelectRandomDeathmatchSpawnPoint
	.section	".rodata"
	.align 2
.LC106:
	.long 0x4b18967f
	.align 2
.LC107:
	.long 0x0
	.align 2
.LC108:
	.long 0x3f800000
	.align 3
.LC109:
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
	lis 9,.LC107@ha
	li 31,0
	la 9,.LC107@l(9)
	li 25,0
	lfs 29,0(9)
	b .L233
.L235:
	lis 9,maxclients@ha
	lis 11,.LC108@ha
	lwz 10,maxclients@l(9)
	la 11,.LC108@l(11)
	li 29,1
	lfs 13,0(11)
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC106@ha
	lfs 31,.LC106@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L243
	lis 9,.LC109@ha
	lis 27,g_edicts@ha
	la 9,.LC109@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,1116
.L238:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L240
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L240
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
	bc 4,0,.L240
	fmr 31,1
.L240:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,1116
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L238
.L243:
	fcmpu 0,31,29
	bc 4,1,.L233
	fmr 29,31
	mr 25,31
.L233:
	lis 30,.LC102@ha
	mr 3,31
	li 4,280
	la 5,.LC102@l(30)
	bl G_Find
	mr. 31,3
	bc 4,2,.L235
	cmpwi 0,25,0
	mr 3,25
	bc 4,2,.L248
	la 5,.LC102@l(30)
	li 3,0
	li 4,280
	bl G_Find
.L248:
	lwz 0,100(1)
	mtlr 0
	lmw 25,44(1)
	lfd 29,72(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe5:
	.size	 SelectFarthestDeathmatchSpawnPoint,.Lfe5-SelectFarthestDeathmatchSpawnPoint
	.section	".rodata"
	.align 2
.LC110:
	.string	"info_player_coop"
	.align 2
.LC111:
	.string	"info_player_start"
	.align 2
.LC112:
	.string	"Couldn't find spawn point %s\n"
	.align 2
.LC113:
	.long 0x0
	.section	".text"
	.align 2
	.globl SelectSpawnPoint1
	.type	 SelectSpawnPoint1,@function
SelectSpawnPoint1:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 11,.LC113@ha
	lis 9,teamplay@ha
	la 11,.LC113@l(11)
	li 31,0
	lfs 13,0(11)
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L263
	bl SelectTeamSpawnPoint
	b .L282
.L263:
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L264
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,512
	bc 12,2,.L266
	bl SelectFarthestDeathmatchSpawnPoint
	b .L282
.L266:
	bl SelectRandomDeathmatchSpawnPoint
.L282:
	mr 31,3
.L264:
	cmpwi 0,31,0
	bc 4,2,.L269
	lis 29,.LC111@ha
	lis 30,game@ha
.L276:
	mr 3,31
	li 4,280
	la 5,.LC111@l(29)
	bl G_Find
	mr. 31,3
	bc 12,2,.L281
	la 3,game@l(30)
	lbz 0,1032(3)
	cmpwi 0,0,0
	bc 4,2,.L280
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L271
	b .L276
.L280:
	lwz 4,300(31)
	cmpwi 0,4,0
	bc 12,2,.L276
	addi 3,3,1032
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L276
.L271:
	cmpwi 0,31,0
	bc 4,2,.L269
.L281:
	lis 9,game@ha
	la 30,game@l(9)
	lbz 0,1032(30)
	cmpwi 0,0,0
	bc 4,2,.L278
	lis 5,.LC111@ha
	li 3,0
	la 5,.LC111@l(5)
	li 4,280
	bl G_Find
	mr 31,3
.L278:
	cmpwi 0,31,0
	bc 4,2,.L269
	lis 9,gi+28@ha
	lis 3,.LC112@ha
	lwz 0,gi+28@l(9)
	la 3,.LC112@l(3)
	addi 4,30,1032
	mtlr 0
	crxor 6,6,6
	blrl
.L269:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 SelectSpawnPoint1,.Lfe6-SelectSpawnPoint1
	.section	".rodata"
	.align 2
.LC114:
	.string	"info_player_team1"
	.align 2
.LC115:
	.string	"info_player_team2"
	.align 2
.LC116:
	.long 0x47c34f80
	.align 2
.LC117:
	.long 0x4b18967f
	.align 2
.LC118:
	.long 0x3f800000
	.align 3
.LC119:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SelectTeamSpawnPoint
	.type	 SelectTeamSpawnPoint,@function
SelectTeamSpawnPoint:
	stwu 1,-128(1)
	mflr 0
	stfd 27,88(1)
	stfd 28,96(1)
	stfd 29,104(1)
	stfd 30,112(1)
	stfd 31,120(1)
	stmw 20,40(1)
	stw 0,132(1)
	lwz 9,84(3)
	li 28,0
	lwz 0,1820(9)
	cmpwi 0,0,1
	bc 12,2,.L297
	cmpwi 0,0,2
	bc 12,2,.L298
	b .L296
.L297:
	lis 9,.LC114@ha
	la 22,.LC114@l(9)
	b .L296
.L298:
	lis 9,.LC115@ha
	la 22,.LC115@l(9)
.L296:
	lis 9,.LC116@ha
	li 30,0
	lfs 29,.LC116@l(9)
	li 23,0
	li 24,0
	lis 9,.LC118@ha
	lis 20,.LC117@ha
	la 9,.LC118@l(9)
	lis 21,maxclients@ha
	lfs 27,0(9)
	fmr 28,29
	b .L301
.L303:
	lwz 9,maxclients@l(21)
	addi 28,28,1
	li 29,1
	lfs 31,.LC117@l(20)
	lis 25,maxclients@ha
	lfs 0,20(9)
	fcmpu 0,27,0
	cror 3,2,0
	bc 4,3,.L311
	lis 10,.LC119@ha
	lis 26,g_edicts@ha
	la 10,.LC119@l(10)
	lis 27,0x4330
	lfd 30,0(10)
	li 31,1116
.L306:
	lwz 0,g_edicts@l(26)
	add 11,0,31
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L308
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L308
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
	bc 4,0,.L308
	fmr 31,1
.L308:
	addi 29,29,1
	lwz 11,maxclients@l(25)
	xoris 0,29,0x8000
	addi 31,31,1116
	stw 0,36(1)
	stw 27,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L306
.L311:
	fcmpu 0,31,28
	bc 4,0,.L313
	fmr 28,31
	mr 24,30
	b .L301
.L313:
	fcmpu 0,31,29
	bc 4,0,.L301
	fmr 29,31
	mr 23,30
.L301:
	mr 3,30
	li 4,280
	mr 5,22
	bl G_Find
	mr. 30,3
	bc 4,2,.L303
	cmpwi 0,28,0
	bc 4,2,.L317
	bl SelectRandomDeathmatchSpawnPoint
	b .L325
.L317:
	cmpwi 0,28,2
	bc 12,1,.L318
	li 23,0
	li 24,0
	b .L319
.L318:
	addi 28,28,-2
.L319:
	bl rand
	li 30,0
	divw 0,3,28
	mullw 0,0,28
	subf 31,0,3
.L324:
	mr 3,30
	li 4,280
	mr 5,22
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
	bc 4,2,.L324
.L325:
	lwz 0,132(1)
	mtlr 0
	lmw 20,40(1)
	lfd 27,88(1)
	lfd 28,96(1)
	lfd 29,104(1)
	lfd 30,112(1)
	lfd 31,120(1)
	la 1,128(1)
	blr
.Lfe7:
	.size	 SelectTeamSpawnPoint,.Lfe7-SelectTeamSpawnPoint
	.section	".rodata"
	.align 2
.LC120:
	.string	"bodyque"
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
	lwz 8,296(11)
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
	stw 9,296(11)
	stfd 13,16(1)
	lwz 29,20(1)
	add 29,29,8
	mulli 29,29,1116
	addi 29,29,1116
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
	lis 9,0xbfc5
	li 10,0
	ori 9,9,18087
	subf 0,0,31
	mullw 0,0,9
	srawi 0,0,2
	stwx 0,26,29
	lwz 9,184(30)
	lwz 11,776(31)
	stw 9,184(31)
	lfs 13,188(30)
	ori 11,11,256
	stfs 13,188(31)
	lfs 0,192(30)
	stfs 0,192(31)
	lfs 13,196(30)
	stfs 13,196(31)
	lfs 0,200(30)
	stfs 0,200(31)
	lfs 13,204(30)
	stfs 13,204(31)
	lfs 0,208(30)
	stfs 0,208(31)
	lfs 13,212(30)
	stfs 13,212(31)
	lfs 0,216(30)
	stfs 0,216(31)
	lfs 13,220(30)
	stfs 13,220(31)
	lfs 0,224(30)
	stfs 0,224(31)
	lfs 13,228(30)
	stfs 13,228(31)
	lfs 0,232(30)
	stfs 0,232(31)
	lwz 0,184(30)
	stw 11,776(31)
	ori 0,0,6
	stw 0,184(31)
	lfs 0,236(30)
	stfs 0,236(31)
	lfs 13,240(30)
	stfs 13,240(31)
	lfs 0,244(30)
	stfs 0,244(31)
	lwz 0,248(30)
	stw 0,248(31)
	lwz 9,252(30)
	stw 10,256(31)
	stw 9,252(31)
	stw 10,44(31)
	lwz 0,260(30)
	stw 0,260(31)
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L340
	stw 10,480(31)
	b .L341
.L340:
	stw 0,480(31)
.L341:
	lwz 0,488(30)
	stw 0,488(31)
	lwz 9,400(30)
	stw 9,400(31)
	lfs 0,948(30)
	stfs 0,948(31)
	lwz 9,1092(30)
	cmpwi 0,9,0
	bc 12,2,.L342
	stw 9,1092(31)
	li 0,0
	stw 31,540(9)
	stw 0,1092(30)
.L342:
	lwz 11,904(30)
	lis 9,body_die@ha
	li 0,1
	la 9,body_die@l(9)
	stw 0,512(31)
	lis 10,gi+72@ha
	rlwinm 11,11,0,21,19
	stw 9,456(31)
	mr 3,31
	stw 11,904(31)
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
.LC121:
	.string	"spectator"
	.align 2
.LC122:
	.string	"none"
	.align 2
.LC123:
	.string	"Spectator password incorrect.\n"
	.align 2
.LC124:
	.string	"spectator 0\n"
	.align 2
.LC125:
	.string	"Server spectator limit is full."
	.align 2
.LC126:
	.string	"password"
	.align 2
.LC127:
	.string	"Password incorrect.\n"
	.align 2
.LC128:
	.string	"spectator 1\n"
	.align 2
.LC129:
	.string	"%s has moved to the sidelines\n"
	.align 2
.LC130:
	.string	"%s joined the game\n"
	.align 2
.LC131:
	.long 0x3f800000
	.align 3
.LC132:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl spectator_respawn
	.type	 spectator_respawn,@function
spectator_respawn:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 3,84(31)
	lwz 0,1808(3)
	cmpwi 0,0,0
	bc 12,2,.L344
	lis 4,.LC121@ha
	addi 3,3,188
	la 4,.LC121@l(4)
	lis 30,spectator_password@ha
	bl Info_ValueForKey
	lwz 9,spectator_password@l(30)
	mr 29,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L345
	lis 4,.LC122@ha
	la 4,.LC122@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L345
	lwz 9,spectator_password@l(30)
	mr 4,29
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L345
	lis 9,gi+8@ha
	lis 5,.LC123@ha
	lwz 0,gi+8@l(9)
	li 4,2
	mr 3,31
	la 5,.LC123@l(5)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,0
	lis 4,.LC124@ha
	mr 3,31
	la 4,.LC124@l(4)
	b .L358
.L345:
	lis 9,maxclients@ha
	lis 10,.LC131@ha
	lwz 11,maxclients@l(9)
	la 10,.LC131@l(10)
	li 7,1
	lfs 0,0(10)
	li 8,0
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L347
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC132@ha
	la 9,.LC132@l(9)
	addi 10,11,1116
	lfd 13,0(9)
.L349:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L348
	lwz 11,84(10)
	addi 9,8,1
	lwz 0,1808(11)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L348:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,1116
	stw 0,12(1)
	stw 6,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L349
.L347:
	xoris 0,8,0x8000
	lis 11,0x4330
	stw 0,12(1)
	lis 10,.LC132@ha
	la 10,.LC132@l(10)
	stw 11,8(1)
	lfd 12,0(10)
	lfd 0,8(1)
	lis 10,maxspectators@ha
	lwz 11,maxspectators@l(10)
	fsub 0,0,12
	lfs 13,20(11)
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L353
	lis 9,gi+8@ha
	lis 5,.LC125@ha
	lwz 0,gi+8@l(9)
	li 4,2
	mr 3,31
	la 5,.LC125@l(5)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,0
	lis 4,.LC124@ha
	mr 3,31
	la 4,.LC124@l(4)
	b .L358
.L344:
	lis 4,.LC126@ha
	addi 3,3,188
	la 4,.LC126@l(4)
	lis 30,password@ha
	bl Info_ValueForKey
	lis 28,gi@ha
	lwz 9,password@l(30)
	mr 29,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L353
	lis 4,.LC122@ha
	la 4,.LC122@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L353
	lwz 9,password@l(30)
	mr 4,29
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L353
	la 9,gi@l(28)
	lis 5,.LC127@ha
	lwz 0,8(9)
	li 4,2
	mr 3,31
	la 5,.LC127@l(5)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,1
	lis 4,.LC128@ha
	mr 3,31
	la 4,.LC128@l(4)
.L358:
	stw 0,1808(9)
	bl stuffcmd
	b .L343
.L353:
	lwz 9,84(31)
	li 30,0
	mr 3,31
	stw 30,1816(9)
	lwz 0,184(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	bl PutClientInServer
	lwz 9,84(31)
	lwz 0,1808(9)
	cmpwi 0,0,0
	bc 4,2,.L355
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xbfc5
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,18087
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
	addi 3,31,4
	li 4,2
	mtlr 0
	blrl
	lwz 11,84(31)
	li 0,32
	li 10,14
	stb 0,16(11)
	lwz 9,84(31)
	stb 10,17(9)
.L355:
	lis 9,level+4@ha
	lwz 11,84(31)
	lfs 0,level+4@l(9)
	stfs 0,2228(11)
	lwz 5,84(31)
	lwz 0,1808(5)
	cmpwi 0,0,0
	bc 12,2,.L356
	lis 9,gi@ha
	lis 4,.LC129@ha
	lwz 0,gi@l(9)
	la 4,.LC129@l(4)
	addi 5,5,700
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl CTFDeadDropFlag
	lwz 9,84(31)
	stw 30,1820(9)
	stw 30,892(31)
	stw 30,896(31)
	b .L343
.L356:
	lis 9,gi@ha
	lis 4,.LC130@ha
	lwz 0,gi@l(9)
	la 4,.LC130@l(4)
	addi 5,5,700
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L343:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 spectator_respawn,.Lfe9-spectator_respawn
	.section	".rodata"
	.align 2
.LC133:
	.string	"gamedir"
	.align 2
.LC134:
	.string	"mod-1"
	.align 2
.LC135:
	.string	"player"
	.align 2
.LC136:
	.string	"fov"
	.align 2
.LC137:
	.string	"/motd.txt"
	.align 2
.LC138:
	.string	"r"
	.align 2
.LC139:
	.string	"Rip II 2.2\nwww.captured.com/rip2/\n%s\n"
	.align 2
.LC140:
	.string	"Rip II 2.2\nwww.captured.com/rip2/\n"
	.align 3
.LC141:
	.long 0x40033333
	.long 0x33333333
	.align 2
.LC142:
	.long 0x40000000
	.align 2
.LC143:
	.long 0x41400000
	.align 3
.LC144:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC145:
	.long 0x3f800000
	.align 2
.LC146:
	.long 0x43200000
	.align 2
.LC147:
	.long 0x47800000
	.align 2
.LC148:
	.long 0x43b40000
	.align 2
.LC149:
	.long 0x41000000
	.section	".text"
	.align 2
	.globl PutClientInServer
	.type	 PutClientInServer,@function
PutClientInServer:
	stwu 1,-2976(1)
	mflr 0
	stmw 23,2940(1)
	stw 0,2980(1)
	mr 31,3
	li 4,0
	addi 3,1,8
	li 5,12
	crxor 6,6,6
	bl memset
	lis 28,game@ha
	addi 24,1,1704
	li 4,0
	addi 3,1,24
	addi 26,1,1784
	li 5,12
	crxor 6,6,6
	bl memset
	lis 9,gi+144@ha
	lis 3,.LC133@ha
	lwz 0,gi+144@l(9)
	lis 4,.LC134@ha
	li 5,4
	la 4,.LC134@l(4)
	la 3,.LC133@l(3)
	mtlr 0
	addi 25,1,72
	blrl
	mr 23,3
	mr 3,31
	bl SelectTeamSpawnPoint
	mr. 29,3
	bc 4,2,.L365
	lis 30,.LC111@ha
.L367:
	mr 3,29
	li 4,280
	la 5,.LC111@l(30)
	bl G_Find
	mr. 29,3
	bc 12,2,.L404
	la 3,game@l(28)
	lbz 0,1032(3)
	cmpwi 0,0,0
	bc 4,2,.L402
	lwz 0,300(29)
	cmpwi 0,0,0
	bc 12,2,.L369
	b .L367
.L402:
	lwz 4,300(29)
	cmpwi 0,4,0
	bc 12,2,.L367
	addi 3,3,1032
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L367
.L369:
	cmpwi 0,29,0
	bc 4,2,.L365
.L404:
	lis 9,game+1032@ha
	lbz 0,game+1032@l(9)
	cmpwi 0,0,0
	bc 4,2,.L374
	lis 5,.LC111@ha
	li 3,0
	la 5,.LC111@l(5)
	li 4,280
	bl G_Find
	mr 29,3
.L374:
	cmpwi 0,29,0
	bc 4,2,.L365
	lis 9,g_edicts@ha
	lwz 29,g_edicts@l(9)
.L365:
	lfs 0,4(29)
	lis 9,.LC142@ha
	li 5,76
	lwz 4,84(31)
	la 9,.LC142@l(9)
	mr 3,24
	lfs 12,0(9)
	li 30,0
	li 28,1
	stfs 0,40(1)
	addi 4,4,1812
	li 27,0
	lfs 13,8(29)
	stfs 13,44(1)
	lfs 0,12(29)
	fadds 0,0,12
	stfs 0,48(1)
	lfs 13,16(29)
	stfs 13,56(1)
	lfs 0,20(29)
	stfs 0,60(1)
	lfs 13,24(29)
	stfs 13,64(1)
	crxor 6,6,6
	bl memcpy
	lwz 4,84(31)
	li 5,512
	mr 3,26
	addi 4,4,188
	crxor 6,6,6
	bl memcpy
	lwz 29,84(31)
	li 5,1624
	li 4,0
	addi 3,29,188
	crxor 6,6,6
	bl memset
	mr 4,26
	stw 28,720(29)
	mr 3,31
	stw 28,728(29)
	stw 28,724(29)
	stw 30,1764(29)
	stw 30,1768(29)
	stw 30,1772(29)
	stw 30,1776(29)
	stw 30,1780(29)
	stw 30,1784(29)
	stw 30,2252(29)
	stw 27,2256(29)
	stw 27,2248(29)
	bl ClientUserinfoChanged
	lwz 4,84(31)
	li 5,1624
	mr 3,25
	addi 4,4,188
	crxor 6,6,6
	bl memcpy
	lwz 3,84(31)
	li 4,0
	li 5,2288
	crxor 6,6,6
	bl memset
	lwz 3,84(31)
	mr 4,25
	li 5,1624
	addi 3,3,188
	crxor 6,6,6
	bl memcpy
	lwz 3,84(31)
	mr 4,24
	li 5,76
	addi 3,3,1812
	crxor 6,6,6
	bl memcpy
	lwz 29,84(31)
	lwz 0,724(29)
	cmpwi 0,0,0
	bc 12,1,.L378
	addi 3,29,188
	li 4,0
	li 5,1624
	crxor 6,6,6
	bl memset
	stw 28,720(29)
	stw 28,728(29)
	stw 28,724(29)
	stw 30,1764(29)
	stw 30,1768(29)
	stw 30,1772(29)
	stw 30,1776(29)
	stw 30,1780(29)
	stw 30,1784(29)
	stw 30,2252(29)
	stw 27,2256(29)
	stw 27,2248(29)
.L378:
	lwz 11,84(31)
	lwz 0,724(11)
	stw 0,480(31)
	lwz 9,728(11)
	stw 9,484(31)
	lwz 0,732(11)
	cmpwi 0,0,0
	bc 12,2,.L381
	lwz 0,264(31)
	ori 0,0,4096
	stw 0,264(31)
.L381:
	lis 11,g_edicts@ha
	lis 0,0xbfc5
	stw 30,552(31)
	lwz 9,g_edicts@l(11)
	ori 0,0,18087
	lis 10,game+1028@ha
	stw 30,512(31)
	lis 11,.LC135@ha
	li 29,200
	subf 9,9,31
	lwz 5,game+1028@l(10)
	la 11,.LC135@l(11)
	mullw 9,9,0
	li 10,22
	stw 11,280(31)
	lis 3,level+4@ha
	stw 10,508(31)
	lis 7,.LC1@ha
	lis 8,player_pain@ha
	srawi 9,9,2
	lis 10,.LC143@ha
	stw 28,260(31)
	mulli 9,9,2288
	la 10,.LC143@l(10)
	stw 28,88(31)
	lis 6,dmflags@ha
	stw 29,400(31)
	la 7,.LC1@l(7)
	la 8,player_pain@l(8)
	addi 9,9,-2288
	stw 30,248(31)
	li 4,-41
	add 12,5,9
	stw 30,492(31)
	stw 12,84(31)
	li 5,6418
	lfs 0,level+4@l(3)
	lfs 12,0(10)
	lwz 9,264(31)
	lis 10,player_die@ha
	lwz 0,184(31)
	la 10,player_die@l(10)
	fadds 0,0,12
	lwz 3,dmflags@l(6)
	rlwinm 9,9,0,21,19
	ori 0,0,1
	stw 7,268(31)
	stw 0,184(31)
	stfs 0,404(31)
	stw 8,452(31)
	stw 10,456(31)
	stw 9,264(31)
	stw 30,928(31)
	stw 27,948(31)
	stw 4,488(31)
	stw 5,904(31)
	stw 28,644(31)
	stw 29,944(31)
	stw 30,612(31)
	stw 30,608(31)
	stw 30,892(31)
	stw 30,908(31)
	lfs 0,20(3)
	fctiwz 13,0
	stfd 13,2928(1)
	lwz 11,2932(1)
	andi. 0,11,32768
	bc 12,2,.L382
	lis 0,0x42b4
	stw 0,112(12)
	b .L383
.L382:
	lis 4,.LC136@ha
	addi 3,12,188
	la 4,.LC136@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	lwz 11,84(31)
	stw 3,2932(1)
	lis 0,0x4330
	lis 10,.LC144@ha
	la 10,.LC144@l(10)
	stw 0,2928(1)
	lfd 13,0(10)
	lfd 0,2928(1)
	lis 10,.LC145@ha
	la 10,.LC145@l(10)
	lfs 12,0(10)
	fsub 0,0,13
	frsp 0,0
	stfs 0,112(11)
	lwz 9,84(31)
	lfs 0,112(9)
	fcmpu 0,0,12
	bc 4,0,.L384
	lis 0,0x42b4
	stw 0,112(9)
	b .L383
.L384:
	lis 11,.LC146@ha
	la 11,.LC146@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L383
	stfs 13,112(9)
.L383:
	lwz 9,84(31)
	lwz 30,1808(9)
	cmpwi 0,30,0
	bc 12,2,.L387
	li 11,0
	li 10,1
	stw 11,2280(9)
	lis 8,gi+72@ha
	mr 3,31
	lwz 9,84(31)
	stw 10,1880(9)
	lwz 0,184(31)
	lwz 9,84(31)
	ori 0,0,1
	stw 10,260(31)
	stw 0,184(31)
	stw 11,248(31)
	stw 11,88(9)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	b .L364
.L387:
	stw 30,1880(9)
	li 0,0
	li 4,0
	lfs 9,8(1)
	li 5,184
	addi 28,1,2888
	lfs 0,12(1)
	lfs 13,16(1)
	lfs 12,24(1)
	lfs 11,28(1)
	lfs 10,32(1)
	lwz 3,84(31)
	stfs 9,188(31)
	stfs 0,192(31)
	stfs 13,196(31)
	stfs 12,200(31)
	stfs 11,204(31)
	stfs 10,208(31)
	stw 0,376(31)
	stw 0,384(31)
	stw 0,380(31)
	crxor 6,6,6
	bl memset
	lis 11,.LC149@ha
	lfs 0,40(1)
	lis 10,.LC148@ha
	la 11,.LC149@l(11)
	la 10,.LC148@l(10)
	lwz 6,84(31)
	lfs 10,0(11)
	lis 9,.LC147@ha
	lis 5,0x42b4
	lfs 8,0(10)
	la 9,.LC147@l(9)
	lis 0,0xbfc5
	lfs 7,0(9)
	ori 0,0,18087
	fmuls 0,0,10
	mr 8,10
	mr 7,10
	lis 9,g_edicts@ha
	addi 29,1,56
	lwz 11,g_edicts@l(9)
	li 3,0
	li 4,0
	lis 9,.LC142@ha
	la 9,.LC142@l(9)
	subf 11,11,31
	lfs 9,0(9)
	mullw 11,11,0
	fctiwz 13,0
	li 0,3
	mtctr 0
	srawi 11,11,2
	addi 11,11,-1
	stfd 13,2928(1)
	lwz 10,2932(1)
	sth 10,4(6)
	lfs 0,44(1)
	lwz 9,84(31)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,2928(1)
	lwz 8,2932(1)
	sth 8,6(9)
	lfs 0,48(1)
	lwz 10,84(31)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,2928(1)
	lwz 7,2932(1)
	sth 7,8(10)
	lwz 9,84(31)
	stw 5,112(9)
	lfs 0,48(1)
	lfs 12,40(1)
	lfs 13,44(1)
	fadds 0,0,9
	stw 11,60(31)
	stw 30,44(31)
	stfs 12,4(31)
	stfs 13,8(31)
	stfs 0,12(31)
	stw 30,64(31)
	stw 30,56(31)
	stw 30,40(31)
.L403:
	lwz 10,84(31)
	add 0,3,3
	lfsx 0,4,29
	addi 3,3,1
	addi 9,10,1824
	lfsx 13,9,4
	addi 10,10,20
	addi 4,4,4
	fsubs 0,0,13
	fmuls 0,0,7
	fdivs 0,0,8
	fctiwz 12,0
	stfd 12,2928(1)
	lwz 11,2932(1)
	sthx 11,10,0
	bdnz .L403
	lfs 0,60(1)
	li 0,0
	lis 8,level+4@ha
	lwz 11,84(31)
	mr 3,31
	stw 0,24(31)
	stw 0,16(31)
	stfs 0,20(31)
	stw 0,28(11)
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,32(9)
	lfs 0,24(31)
	lwz 11,84(31)
	stfs 0,36(11)
	lfs 0,16(31)
	lwz 9,84(31)
	stfs 0,2124(9)
	lfs 0,20(31)
	lwz 11,84(31)
	stfs 0,2128(11)
	lfs 0,24(31)
	lwz 10,84(31)
	stfs 0,2132(10)
	lwz 9,84(31)
	stw 0,2236(9)
	lwz 11,84(31)
	stw 0,2232(11)
	lfs 0,level+4@l(8)
	lwz 9,84(31)
	stfs 0,2228(9)
	bl KillBox
	lis 9,gi@ha
	mr 3,31
	la 29,gi@l(9)
	lwz 9,72(29)
	mtlr 9
	blrl
	lwz 4,4(23)
	mr 3,28
	bl strcpy
	lis 4,.LC137@ha
	mr 3,28
	la 4,.LC137@l(4)
	bl strcat
	lis 4,.LC138@ha
	mr 3,28
	la 4,.LC138@l(4)
	bl fopen
	mr. 30,3
	bc 12,2,.L395
	addi 3,1,2296
	li 4,500
	mr 28,3
	mr 5,30
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L396
	addi 29,1,2808
	b .L397
.L399:
	mr 3,28
	mr 4,29
	bl strcat
.L397:
	mr 3,29
	li 4,80
	mr 5,30
	bl fgets
	cmpwi 0,3,0
	bc 4,2,.L399
	lis 9,gi+12@ha
	lis 4,.LC139@ha
	lwz 0,gi+12@l(9)
	la 4,.LC139@l(4)
	mr 5,28
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
.L396:
	mr 3,30
	bl fclose
	b .L401
.L395:
	lwz 0,12(29)
	lis 4,.LC140@ha
	mr 3,31
	la 4,.LC140@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L401:
	bl G_Spawn
	lis 9,AppearMenu@ha
	mr 11,3
	la 9,AppearMenu@l(9)
	stw 31,256(11)
	lis 10,level+4@ha
	stw 9,436(11)
	lis 8,.LC141@ha
	lfs 0,level+4@l(10)
	lis 9,gi+72@ha
	lfd 13,.LC141@l(8)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(11)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L364:
	lwz 0,2980(1)
	mtlr 0
	lmw 23,2940(1)
	la 1,2976(1)
	blr
.Lfe10:
	.size	 PutClientInServer,.Lfe10-PutClientInServer
	.section	".rodata"
	.align 2
.LC150:
	.string	"%s entered the game\n"
	.align 2
.LC151:
	.string	"%s entered the world\n"
	.section	".text"
	.align 2
	.globl ClientBegin
	.type	 ClientBegin,@function
ClientBegin:
	stwu 1,-208(1)
	mflr 0
	stmw 27,188(1)
	stw 0,212(1)
	lis 11,g_edicts@ha
	mr 29,3
	lwz 9,g_edicts@l(11)
	lis 0,0xbfc5
	lis 27,gi@ha
	ori 0,0,18087
	lis 11,game+1028@ha
	subf 9,9,29
	lwz 10,game+1028@l(11)
	addi 3,1,8
	mullw 9,9,0
	la 4,gi@l(27)
	li 5,176
	srawi 9,9,2
	mulli 9,9,2288
	addi 9,9,-2288
	add 10,10,9
	stw 10,84(29)
	crxor 6,6,6
	bl memcpy
	mr 3,29
	bl G_InitEdict
	lwz 28,84(29)
	li 4,0
	li 5,76
	addi 3,28,1812
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,29
	lwz 0,level@l(9)
	stw 0,1812(28)
	bl PutClientInServer
	mr 3,29
	bl ClientEndServerFrame
	lwz 5,84(29)
	lis 4,.LC150@ha
	li 3,2
	lwz 0,gi@l(27)
	la 4,.LC150@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,212(1)
	mtlr 0
	lmw 27,188(1)
	la 1,208(1)
	blr
.Lfe11:
	.size	 ClientBegin,.Lfe11-ClientBegin
	.section	".rodata"
	.align 2
.LC152:
	.string	"\\name\\badinfo\\skin\\male/grunt"
	.align 2
.LC153:
	.string	"0"
	.align 2
.LC154:
	.string	"name"
	.align 2
.LC155:
	.string	"rejmsg"
	.align 2
.LC156:
	.string	"Kicked for changing skin."
	.align 2
.LC157:
	.string	"%s was kicked for changing his skin\n"
	.align 2
.LC158:
	.string	"disconnect\n"
	.align 2
.LC159:
	.string	"%s\\%s"
	.align 2
.LC160:
	.string	"hand"
	.align 2
.LC161:
	.long 0x0
	.align 3
.LC162:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC163:
	.long 0x3f800000
	.align 2
.LC164:
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
	mr 30,4
	mr 28,3
	mr 3,30
	bl Info_Validate
	cmpwi 0,3,0
	bc 4,2,.L422
	lis 11,.LC152@ha
	lwz 0,.LC152@l(11)
	la 9,.LC152@l(11)
	lwz 10,4(9)
	lwz 11,8(9)
	lwz 8,12(9)
	stw 0,0(30)
	stw 10,4(30)
	stw 11,8(30)
	stw 8,12(30)
	lhz 7,28(9)
	lwz 0,16(9)
	lwz 11,20(9)
	lwz 10,24(9)
	stw 0,16(30)
	stw 11,20(30)
	stw 10,24(30)
	sth 7,28(30)
.L422:
	lis 4,.LC121@ha
	mr 3,30
	la 4,.LC121@l(4)
	bl Info_ValueForKey
	mr 31,3
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L423
	lis 4,.LC153@ha
	la 4,.LC153@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L423
	lwz 9,84(28)
	li 0,1
	b .L433
.L423:
	lwz 9,84(28)
	li 0,0
.L433:
	stw 0,1808(9)
	lis 4,.LC154@ha
	mr 3,30
	la 4,.LC154@l(4)
	bl Info_ValueForKey
	lwz 9,84(28)
	mr 31,3
	li 5,15
	mr 4,31
	addi 3,9,700
	bl strncpy
	lis 4,.LC0@ha
	mr 3,30
	la 4,.LC0@l(4)
	bl Info_ValueForKey
	lis 11,g_edicts@ha
	lis 0,0xbfc5
	lwz 10,908(28)
	lwz 9,g_edicts@l(11)
	ori 0,0,18087
	mr 31,3
	andi. 11,10,2
	subf 9,9,28
	mullw 9,9,0
	srawi 9,9,2
	addi 27,9,-1
	bc 12,2,.L425
	addi 4,28,956
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L425
	lwz 3,84(28)
	lis 4,.LC155@ha
	lis 5,.LC156@ha
	la 4,.LC155@l(4)
	la 5,.LC156@l(5)
	addi 3,3,188
	bl Info_SetValueForKey
	mr 3,28
	bl Rip_SetSkin
	lis 9,gi@ha
	lwz 5,84(28)
	lis 4,.LC157@ha
	lwz 0,gi@l(9)
	la 4,.LC157@l(4)
	li 3,2
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lis 4,.LC158@ha
	mr 3,28
	la 4,.LC158@l(4)
	bl stuffcmd
	b .L421
.L425:
	lwz 4,84(28)
	lis 29,gi@ha
	lis 3,.LC159@ha
	la 29,gi@l(29)
	mr 5,31
	addi 4,4,700
	la 3,.LC159@l(3)
	crxor 6,6,6
	bl va
	lwz 9,24(29)
	addi 0,27,1312
	mr 4,3
	mr 3,0
	mtlr 9
	blrl
	lis 9,.LC161@ha
	lis 11,deathmatch@ha
	la 9,.LC161@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L427
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,32768
	bc 12,2,.L427
	lwz 9,84(28)
	b .L434
.L427:
	lis 4,.LC136@ha
	mr 3,30
	la 4,.LC136@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	lwz 11,84(28)
	stw 3,20(1)
	lis 0,0x4330
	lis 10,.LC162@ha
	la 10,.LC162@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC163@ha
	la 10,.LC163@l(10)
	lfs 12,0(10)
	fsub 0,0,13
	frsp 0,0
	stfs 0,112(11)
	lwz 9,84(28)
	lfs 0,112(9)
	fcmpu 0,0,12
	bc 4,0,.L429
.L434:
	lis 0,0x42b4
	stw 0,112(9)
	b .L428
.L429:
	lis 11,.LC164@ha
	la 11,.LC164@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L428
	stfs 13,112(9)
.L428:
	lis 4,.LC160@ha
	mr 3,30
	la 4,.LC160@l(4)
	bl Info_ValueForKey
	mr 31,3
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L432
	mr 3,31
	bl atoi
	lwz 9,84(28)
	stw 3,716(9)
.L432:
	lwz 3,84(28)
	mr 4,30
	li 5,511
	addi 3,3,188
	bl strncpy
.L421:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe12:
	.size	 ClientUserinfoChanged,.Lfe12-ClientUserinfoChanged
	.section	".rodata"
	.align 2
.LC165:
	.string	"ip"
	.align 2
.LC166:
	.string	"Banned."
	.align 2
.LC167:
	.string	"Password required or incorrect."
	.align 2
.LC168:
	.string	"Spectator password required or incorrect."
	.align 2
.LC169:
	.string	"%s connected\n"
	.align 2
.LC170:
	.long 0x0
	.align 3
.LC171:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ClientConnect
	.type	 ClientConnect,@function
ClientConnect:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 28,4
	mr 30,3
	lis 4,.LC165@ha
	mr 3,28
	la 4,.LC165@l(4)
	bl Info_ValueForKey
	bl SV_FilterPacket
	cmpwi 0,3,0
	bc 12,2,.L436
	lis 4,.LC155@ha
	lis 5,.LC166@ha
	mr 3,28
	la 4,.LC155@l(4)
	la 5,.LC166@l(5)
	b .L456
.L436:
	lis 4,.LC126@ha
	mr 3,28
	la 4,.LC126@l(4)
	bl Info_ValueForKey
	lis 9,password@ha
	mr 31,3
	lwz 11,password@l(9)
	mr 4,31
	lwz 3,4(11)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L457
	lis 4,.LC121@ha
	mr 3,28
	la 4,.LC121@l(4)
	bl Info_ValueForKey
	mr 31,3
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L438
	lis 4,.LC153@ha
	la 4,.LC153@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L438
	lis 29,spectator_password@ha
	lwz 9,spectator_password@l(29)
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L439
	lis 4,.LC122@ha
	la 4,.LC122@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L439
	lwz 9,spectator_password@l(29)
	mr 4,31
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L439
	lis 4,.LC155@ha
	lis 5,.LC168@ha
	mr 3,28
	la 4,.LC155@l(4)
	la 5,.LC168@l(5)
	b .L456
.L439:
	lis 9,maxclients@ha
	lis 10,.LC170@ha
	lwz 11,maxclients@l(9)
	la 10,.LC170@l(10)
	li 8,0
	lfs 0,0(10)
	li 7,0
	lfs 13,20(11)
	fcmpu 0,0,13
	bc 4,0,.L441
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC171@ha
	la 9,.LC171@l(9)
	addi 10,11,1116
	lfd 13,0(9)
.L443:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L442
	lwz 11,84(10)
	addi 9,8,1
	lwz 0,1808(11)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L442:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,1116
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L443
.L441:
	xoris 0,8,0x8000
	lis 11,0x4330
	stw 0,20(1)
	lis 10,.LC171@ha
	la 10,.LC171@l(10)
	stw 11,16(1)
	lfd 12,0(10)
	lfd 0,16(1)
	lis 10,maxspectators@ha
	lwz 11,maxspectators@l(10)
	fsub 0,0,12
	lfs 13,20(11)
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L447
	lis 4,.LC155@ha
	lis 5,.LC125@ha
	mr 3,28
	la 4,.LC155@l(4)
	la 5,.LC125@l(5)
	b .L456
.L438:
	lis 4,.LC126@ha
	mr 3,28
	la 4,.LC126@l(4)
	bl Info_ValueForKey
	lis 11,password@ha
	mr 31,3
	lwz 9,password@l(11)
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L447
	lis 4,.LC122@ha
	la 4,.LC122@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L447
	lis 9,password@ha
	mr 4,31
	lwz 11,password@l(9)
	lwz 3,4(11)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L447
.L457:
	lis 4,.LC155@ha
	lis 5,.LC167@ha
	mr 3,28
	la 4,.LC155@l(4)
	la 5,.LC167@l(5)
.L456:
	bl Info_SetValueForKey
	li 3,0
	b .L455
.L447:
	lis 11,g_edicts@ha
	lis 0,0xbfc5
	lwz 9,g_edicts@l(11)
	ori 0,0,18087
	li 10,0
	lis 11,game@ha
	subf 9,9,30
	la 27,game@l(11)
	mullw 9,9,0
	lwz 11,1028(27)
	srawi 9,9,2
	mulli 9,9,2288
	addi 9,9,-2288
	add 11,11,9
	stw 11,84(30)
	stw 10,1796(11)
	lwz 31,88(30)
	cmpwi 0,31,0
	bc 4,2,.L449
	lwz 29,84(30)
	li 4,0
	li 5,76
	addi 3,29,1812
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	lwz 0,level@l(9)
	stw 0,1812(29)
	lwz 9,1560(27)
	cmpwi 0,9,0
	bc 12,2,.L452
	lwz 9,84(30)
	lwz 0,1788(9)
	cmpwi 0,0,0
	bc 4,2,.L449
.L452:
	lwz 29,84(30)
	li 4,0
	li 5,1624
	addi 3,29,188
	crxor 6,6,6
	bl memset
	li 0,1
	li 9,0
	stw 31,2252(29)
	stw 0,720(29)
	stw 9,2248(29)
	stw 0,728(29)
	stw 0,724(29)
	stw 31,1764(29)
	stw 31,1768(29)
	stw 31,1772(29)
	stw 31,1776(29)
	stw 31,1780(29)
	stw 31,1784(29)
	stw 9,2256(29)
.L449:
	lwz 9,84(30)
	li 0,0
	mr 4,28
	mr 3,30
	stw 0,1880(9)
	bl ClientUserinfoChanged
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L454
	lis 9,gi+4@ha
	lwz 4,84(30)
	lis 3,.LC169@ha
	lwz 0,gi+4@l(9)
	la 3,.LC169@l(3)
	addi 4,4,700
	mtlr 0
	crxor 6,6,6
	blrl
.L454:
	lwz 9,84(30)
	li 0,1
	mr 3,30
	stw 0,720(9)
	bl Menu_Init
	li 3,1
.L455:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe13:
	.size	 ClientConnect,.Lfe13-ClientConnect
	.section	".rodata"
	.align 2
.LC172:
	.string	"%s disconnected\n"
	.align 2
.LC173:
	.string	"disconnected"
	.align 2
.LC174:
	.string	"sv %3i:%i %i\n"
	.align 2
.LC176:
	.string	"*jump1.wav"
	.align 3
.LC175:
	.long 0x3f768000
	.long 0x0
	.align 2
.LC177:
	.long 0x0
	.align 3
.LC178:
	.long 0x40140000
	.long 0x0
	.align 2
.LC179:
	.long 0x41000000
	.align 3
.LC180:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC181:
	.long 0x3fc00000
	.long 0x0
	.align 2
.LC182:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl ClientThink
	.type	 ClientThink,@function
ClientThink:
	stwu 1,-320(1)
	mflr 0
	stfd 31,312(1)
	stmw 20,264(1)
	stw 0,324(1)
	lis 9,level@ha
	lis 10,.LC177@ha
	la 9,level@l(9)
	la 10,.LC177@l(10)
	lfs 13,0(10)
	mr 30,3
	mr 26,4
	lfs 0,200(9)
	stw 30,292(9)
	lwz 31,84(30)
	fcmpu 0,0,13
	bc 12,2,.L485
	li 0,4
	lis 11,.LC178@ha
	stw 0,0(31)
	la 11,.LC178@l(11)
	lfs 0,200(9)
	lfd 12,0(11)
	lfs 13,4(9)
	fadd 0,0,12
	fcmpu 0,13,0
	bc 4,1,.L484
	lbz 0,1(26)
	andi. 20,0,128
	bc 12,2,.L484
	li 0,1
	stw 0,208(9)
	b .L484
.L485:
	addi 3,1,8
	lis 9,pm_passent@ha
	mr 29,3
	stw 30,pm_passent@l(9)
	li 4,0
	li 5,240
	crxor 6,6,6
	bl memset
	lwz 0,260(30)
	cmpwi 0,0,1
	bc 12,2,.L494
	lwz 0,40(30)
	cmpwi 0,0,255
	li 0,3
	bc 4,2,.L494
	lwz 0,492(30)
	cmpwi 0,0,0
	bc 4,2,.L492
	lwz 0,908(30)
	andi. 9,0,64
	bc 12,2,.L491
.L492:
	li 0,2
	b .L494
.L491:
	lwz 0,928(30)
	andi. 0,0,16
	bc 12,2,.L494
	li 0,4
.L494:
	stw 0,0(31)
	lis 9,sv_gravity@ha
	lwz 7,0(31)
	lwz 10,sv_gravity@l(9)
	li 20,3
	addi 23,1,12
	lwz 0,8(31)
	mtctr 20
	addi 25,30,4
	addi 22,1,18
	lfs 0,20(10)
	addi 24,30,376
	mr 12,23
	lwz 9,12(31)
	lis 10,.LC179@ha
	mr 4,25
	lwz 8,4(31)
	la 10,.LC179@l(10)
	mr 3,22
	lfs 10,0(10)
	mr 5,24
	addi 28,31,1888
	addi 27,1,36
	lis 21,maxclients@ha
	li 6,0
	li 10,0
	fctiwz 13,0
	stfd 13,256(1)
	lwz 11,260(1)
	sth 11,18(31)
	stw 7,8(1)
	stw 8,4(29)
	stw 0,8(29)
	stw 9,12(29)
	lwz 0,16(31)
	lwz 9,20(31)
	lwz 11,24(31)
	stw 0,16(29)
	stw 9,20(29)
	stw 11,24(29)
.L546:
	lfsx 13,6,4
	lfsx 0,6,5
	mr 9,11
	addi 6,6,4
	fmuls 13,13,10
	fmuls 0,0,10
	fctiwz 12,13
	fctiwz 11,0
	stfd 12,256(1)
	lwz 11,260(1)
	stfd 11,256(1)
	lwz 9,260(1)
	sthx 11,10,12
	sthx 9,10,3
	addi 10,10,2
	bdnz .L546
	mr 3,28
	addi 4,1,8
	li 5,28
	bl memcmp
	cmpwi 0,3,0
	bc 12,2,.L501
	li 0,1
	stw 0,52(1)
.L501:
	lha 9,8(26)
	lwz 0,944(30)
	cmpw 0,9,0
	bc 4,1,.L502
	lhz 0,946(30)
	mr 3,30
	sth 0,8(26)
	bl Rip_SetSpeed
.L502:
	lis 9,gi@ha
	lwz 7,0(26)
	addi 3,1,8
	la 9,gi@l(9)
	lwz 6,4(26)
	lis 11,PM_trace@ha
	lwz 5,84(9)
	la 11,PM_trace@l(11)
	lis 20,.LC181@ha
	lwz 8,8(26)
	la 20,.LC181@l(20)
	lwz 0,12(26)
	mtlr 5
	stw 7,36(1)
	lwz 10,52(9)
	stw 0,12(27)
	stw 6,4(27)
	stw 8,8(27)
	stw 11,240(1)
	stw 10,244(1)
	blrl
	lis 9,.LC180@ha
	lwz 11,8(1)
	mr 27,23
	la 9,.LC180@l(9)
	lwz 10,4(29)
	mr 3,24
	lfd 11,0(9)
	mr 4,22
	mr 5,25
	lwz 0,8(29)
	lis 6,0x4330
	li 7,0
	lwz 9,12(29)
	li 8,0
	stw 11,0(31)
	li 11,3
	stw 10,4(31)
	stw 0,8(31)
	mtctr 11
	stw 9,12(31)
	lwz 0,16(29)
	lwz 9,20(29)
	lwz 11,24(29)
	stw 0,16(31)
	stw 9,20(31)
	stw 11,24(31)
	lwz 0,8(1)
	lwz 9,4(29)
	lwz 11,8(29)
	lwz 10,12(29)
	stw 0,1888(31)
	stw 9,4(28)
	stw 11,8(28)
	stw 10,12(28)
	lwz 0,24(29)
	lwz 9,16(29)
	lwz 11,20(29)
	lfd 12,0(20)
	stw 0,24(28)
	stw 9,16(28)
	stw 11,20(28)
.L545:
	lhax 0,7,27
	lhax 9,7,4
	mr 10,11
	xoris 0,0,0x8000
	addi 7,7,2
	stw 0,260(1)
	xoris 9,9,0x8000
	stw 6,256(1)
	lfd 13,256(1)
	stw 9,260(1)
	stw 6,256(1)
	lfd 0,256(1)
	fsub 13,13,11
	fsub 0,0,11
	fmul 13,13,12
	fmul 0,0,12
	frsp 13,13
	frsp 0,0
	stfsx 13,8,5
	stfsx 0,8,3
	addi 8,8,4
	bdnz .L545
	lfs 0,216(1)
	mr 9,11
	lis 8,0x4330
	lfs 13,220(1)
	lis 20,.LC180@ha
	lis 7,.LC175@ha
	lfs 8,204(1)
	la 20,.LC180@l(20)
	lfs 9,208(1)
	lfs 10,212(1)
	lfs 11,224(1)
	stfs 0,200(30)
	stfs 13,204(30)
	stfs 8,188(30)
	stfs 9,192(30)
	stfs 10,196(30)
	stfs 11,208(30)
	lha 0,2(26)
	lfd 12,0(20)
	xoris 0,0,0x8000
	lfd 13,.LC175@l(7)
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,1824(31)
	lha 0,4(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,1828(31)
	lha 0,6(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,1832(31)
	lwz 0,552(30)
	cmpwi 0,0,0
	bc 12,2,.L508
	lwz 0,228(1)
	cmpwi 0,0,0
	bc 4,2,.L508
	lha 0,48(1)
	cmpwi 0,0,9
	bc 4,1,.L508
	lwz 0,236(1)
	cmpwi 0,0,0
	bc 4,2,.L508
	lis 29,gi@ha
	lis 3,.LC176@ha
	la 29,gi@l(29)
	la 3,.LC176@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC182@ha
	lis 10,.LC182@ha
	lis 11,.LC177@ha
	mr 5,3
	la 9,.LC182@l(9)
	la 10,.LC182@l(10)
	mtlr 0
	la 11,.LC177@l(11)
	mr 3,30
	lfs 1,0(9)
	li 4,2
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	mr 4,25
	mr 3,30
	li 5,0
	bl PlayerNoise
.L508:
	lfs 0,200(1)
	lwz 10,228(1)
	lwz 0,236(1)
	lwz 11,232(1)
	cmpwi 0,10,0
	stw 0,612(30)
	stw 11,608(30)
	fctiwz 13,0
	stw 10,552(30)
	stfd 13,256(1)
	lwz 9,260(1)
	stw 9,508(30)
	bc 12,2,.L509
	lwz 0,92(10)
	stw 0,556(30)
.L509:
	lwz 0,492(30)
	cmpwi 0,0,0
	bc 12,2,.L510
	lfs 0,2052(31)
	lis 0,0x4220
	lis 9,0xc170
	stw 0,36(31)
	stw 9,28(31)
	stfs 0,32(31)
	b .L511
.L510:
	lfs 0,188(1)
	stfs 0,2124(31)
	lfs 13,192(1)
	stfs 13,2128(31)
	lfs 0,196(1)
	stfs 0,2132(31)
	lfs 13,188(1)
	stfs 13,28(31)
	lfs 0,192(1)
	stfs 0,32(31)
	lfs 13,196(1)
	stfs 13,36(31)
.L511:
	lis 9,gi+72@ha
	mr 3,30
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,260(30)
	cmpwi 0,0,1
	bc 12,2,.L512
	mr 3,30
	bl G_TouchTriggers
.L512:
	lwz 0,56(1)
	li 29,0
	cmpw 0,29,0
	bc 4,0,.L514
	addi 28,1,60
.L516:
	li 11,0
	slwi 0,29,2
	cmpw 0,11,29
	lwzx 3,28,0
	addi 27,29,1
	bc 4,0,.L518
	lwz 0,0(28)
	cmpw 0,0,3
	bc 12,2,.L518
	mr 9,28
.L519:
	addi 11,11,1
	cmpw 0,11,29
	bc 4,0,.L518
	lwzu 0,4(9)
	cmpw 0,0,3
	bc 4,2,.L519
.L518:
	cmpw 0,11,29
	bc 4,2,.L515
	lwz 0,444(3)
	cmpwi 0,0,0
	bc 12,2,.L515
	mr 4,30
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L515:
	lwz 0,56(1)
	mr 29,27
	cmpw 0,29,0
	bc 12,0,.L516
.L514:
	lwz 0,2004(31)
	lwz 11,2012(31)
	stw 0,2008(31)
	lbz 9,1(26)
	andc 0,9,0
	stw 9,2004(31)
	or 11,11,0
	stw 11,2012(31)
	lbz 0,15(26)
	stw 0,640(30)
	lwz 9,2012(31)
	andi. 0,9,1
	bc 12,2,.L526
	lwz 0,1880(31)
	cmpwi 0,0,0
	bc 12,2,.L527
	lwz 0,2280(31)
	li 9,0
	stw 9,2012(31)
	cmpwi 0,0,0
	bc 12,2,.L528
	lbz 0,16(31)
	stw 9,2280(31)
	andi. 0,0,191
	stb 0,16(31)
	b .L526
.L528:
	mr 3,30
	bl GetChaseTarget
	b .L526
.L527:
	lwz 0,2016(31)
	cmpwi 0,0,0
	bc 4,2,.L526
	li 0,1
	mr 3,30
	stw 0,2016(31)
	bl Think_Weapon
.L526:
	lwz 0,1880(31)
	cmpwi 0,0,0
	bc 12,2,.L532
	lha 0,12(26)
	cmpwi 0,0,9
	bc 4,1,.L533
	lbz 0,16(31)
	andi. 9,0,2
	bc 4,2,.L532
	lwz 9,2280(31)
	ori 0,0,2
	stb 0,16(31)
	cmpwi 0,9,0
	bc 12,2,.L535
	mr 3,30
	bl ChaseNext
	b .L532
.L535:
	mr 3,30
	bl GetChaseTarget
	b .L532
.L533:
	lbz 0,16(31)
	andi. 0,0,253
	stb 0,16(31)
.L532:
	lis 9,maxclients@ha
	lis 10,.LC182@ha
	lwz 11,maxclients@l(9)
	la 10,.LC182@l(10)
	li 29,1
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L539
	lis 11,.LC180@ha
	lis 27,g_edicts@ha
	la 11,.LC180@l(11)
	lis 28,0x4330
	lfd 31,0(11)
	li 31,1116
.L541:
	lwz 0,g_edicts@l(27)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L540
	lwz 9,84(3)
	lwz 0,2280(9)
	cmpw 0,0,30
	bc 4,2,.L540
	bl UpdateChaseCam
.L540:
	addi 29,29,1
	lwz 11,maxclients@l(21)
	xoris 0,29,0x8000
	addi 31,31,1116
	stw 0,260(1)
	stw 28,256(1)
	lfd 0,256(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L541
.L539:
	lwz 3,84(30)
	lwz 0,2264(3)
	cmpwi 0,0,0
	bc 12,2,.L484
	lbz 0,16(3)
	ori 0,0,64
	stb 0,16(3)
.L484:
	lwz 0,324(1)
	mtlr 0
	lmw 20,264(1)
	lfd 31,312(1)
	la 1,320(1)
	blr
.Lfe14:
	.size	 ClientThink,.Lfe14-ClientThink
	.section	".rodata"
	.align 2
.LC183:
	.long 0x0
	.align 2
.LC184:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl ClientBeginServerFrame
	.type	 ClientBeginServerFrame,@function
ClientBeginServerFrame:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 11,.LC183@ha
	lis 9,level@ha
	la 11,.LC183@l(11)
	mr 31,3
	lfs 13,0(11)
	la 11,level@l(9)
	lfs 0,200(11)
	fcmpu 0,0,13
	bc 4,2,.L547
	lwz 30,84(31)
	lwz 9,1808(30)
	lwz 0,1880(30)
	cmpw 0,9,0
	bc 12,2,.L549
	lfs 0,4(11)
	lis 9,.LC184@ha
	lfs 13,2228(30)
	la 9,.LC184@l(9)
	lfs 12,0(9)
	fsubs 0,0,13
	fcmpu 0,0,12
	cror 3,2,1
	bc 4,3,.L549
	bl spectator_respawn
	b .L547
.L549:
	lwz 0,2016(30)
	cmpwi 0,0,0
	bc 4,2,.L550
	lwz 0,1880(30)
	cmpwi 0,0,0
	bc 4,2,.L550
	mr 3,31
	bl Think_Weapon
	b .L551
.L550:
	li 0,0
	stw 0,2016(30)
.L551:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L552
	lis 9,level@ha
	lfs 13,2228(30)
	la 29,level@l(9)
	lfs 0,4(29)
	fcmpu 0,0,13
	bc 4,1,.L547
	lwz 0,2012(30)
	andi. 9,0,1
	bc 4,2,.L555
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,1024
	bc 12,2,.L547
.L555:
	lwz 9,84(31)
	lwz 3,2272(9)
	cmpwi 0,3,0
	bc 12,2,.L556
	bl G_FreeEdict
.L556:
	lwz 9,84(31)
	lwz 3,2268(9)
	cmpwi 0,3,0
	bc 12,2,.L557
	bl G_FreeEdict
.L557:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L558
	mr 3,31
	bl CopyToBodyQue
.L558:
	lwz 0,184(31)
	mr 3,31
	lwz 4,896(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	bl ClassFunction
	lwz 11,84(31)
	li 0,32
	li 10,14
	li 8,0
	stb 0,16(11)
	lwz 9,84(31)
	stb 10,17(9)
	lfs 0,4(29)
	lwz 11,84(31)
	stfs 0,2228(11)
	stw 8,2012(30)
	b .L547
.L552:
	stw 0,2012(30)
.L547:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe15:
	.size	 ClientBeginServerFrame,.Lfe15-ClientBeginServerFrame
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.align 2
	.globl low2high
	.type	 low2high,@function
low2high:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi+132@ha
	mr 30,3
	lwz 0,gi+132@l(9)
	li 3,4
	li 4,766
	li 31,0
	mtlr 0
	blrl
	lbzx 9,30,31
	mr 11,3
	cmpwi 0,9,0
	bc 12,2,.L12
.L14:
	cmpwi 0,9,10
	bc 12,2,.L15
	addi 0,9,128
	stbx 0,11,31
	b .L13
.L15:
	stbx 9,11,31
.L13:
	addi 31,31,1
	lbzx 9,30,31
	cmpwi 0,9,0
	bc 4,2,.L14
.L12:
	li 0,0
	mr 3,11
	stbx 0,11,31
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe16:
	.size	 low2high,.Lfe16-low2high
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
	lwz 3,2272(9)
	cmpwi 0,3,0
	bc 12,2,.L360
	bl G_FreeEdict
.L360:
	lwz 9,84(31)
	lwz 3,2268(9)
	cmpwi 0,3,0
	bc 12,2,.L361
	bl G_FreeEdict
.L361:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L362
	mr 3,31
	bl CopyToBodyQue
.L362:
	lwz 0,184(31)
	mr 3,31
	lwz 4,896(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	bl ClassFunction
	lwz 11,84(31)
	li 0,32
	li 10,14
	lis 8,level+4@ha
	stb 0,16(11)
	lwz 9,84(31)
	stb 10,17(9)
	lfs 0,level+4@l(8)
	lwz 11,84(31)
	stfs 0,2228(11)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe17:
	.size	 respawn,.Lfe17-respawn
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
	li 5,1624
	crxor 6,6,6
	bl memset
	li 0,0
	li 9,1
	li 11,0
	stw 9,720(29)
	stw 0,2252(29)
	stw 11,2248(29)
	stw 9,728(29)
	stw 9,724(29)
	stw 0,1764(29)
	stw 0,1768(29)
	stw 0,1772(29)
	stw 0,1776(29)
	stw 0,1780(29)
	stw 0,1784(29)
	stw 11,2256(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 InitClientPersistant,.Lfe18-InitClientPersistant
	.align 2
	.globl InitClientResp
	.type	 InitClientResp,@function
InitClientResp:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	li 4,0
	addi 3,29,1812
	li 5,76
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	lwz 0,level@l(9)
	stw 0,1812(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 InitClientResp,.Lfe19-InitClientResp
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
	lis 11,.LC120@ha
	stw 0,level+296@l(9)
	li 31,8
	la 30,.LC120@l(11)
.L330:
	bl G_Spawn
	addic. 31,31,-1
	stw 30,280(3)
	bc 4,2,.L330
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe20:
	.size	 InitBodyQue,.Lfe20-InitBodyQue
	.align 2
	.globl player_pain
	.type	 player_pain,@function
player_pain:
	blr
.Lfe21:
	.size	 player_pain,.Lfe21-player_pain
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
	addi 10,11,1116
.L192:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L191
	lwz 9,1028(7)
	lwz 0,480(10)
	add 9,8,9
	stw 0,724(9)
	lwz 11,1028(7)
	lwz 0,484(10)
	add 11,8,11
	stw 0,728(11)
	lwz 9,1028(7)
	lwz 0,264(10)
	add 9,8,9
	rlwinm 0,0,0,19,19
	stw 0,732(9)
.L191:
	lwz 0,1544(7)
	addi 6,6,1
	addi 8,8,2288
	addi 10,10,1116
	cmpw 0,6,0
	bc 12,0,.L192
	blr
.Lfe22:
	.size	 SaveClientData,.Lfe22-SaveClientData
	.align 2
	.globl FetchClientEntData
	.type	 FetchClientEntData,@function
FetchClientEntData:
	lwz 11,84(3)
	lwz 0,724(11)
	stw 0,480(3)
	lwz 9,728(11)
	stw 9,484(3)
	lwz 0,732(11)
	cmpwi 0,0,0
	bclr 12,2
	lwz 0,264(3)
	ori 0,0,4096
	stw 0,264(3)
	blr
.Lfe23:
	.size	 FetchClientEntData,.Lfe23-FetchClientEntData
	.align 2
	.globl SP_info_player_start
	.type	 SP_info_player_start,@function
SP_info_player_start:
	blr
.Lfe24:
	.size	 SP_info_player_start,.Lfe24-SP_info_player_start
	.align 2
	.globl SP_info_player_deathmatch
	.type	 SP_info_player_deathmatch,@function
SP_info_player_deathmatch:
	blr
.Lfe25:
	.size	 SP_info_player_deathmatch,.Lfe25-SP_info_player_deathmatch
	.align 2
	.globl SP_info_player_coop
	.type	 SP_info_player_coop,@function
SP_info_player_coop:
	blr
.Lfe26:
	.size	 SP_info_player_coop,.Lfe26-SP_info_player_coop
	.align 2
	.globl SP_info_player_intermission
	.type	 SP_info_player_intermission,@function
SP_info_player_intermission:
	blr
.Lfe27:
	.size	 SP_info_player_intermission,.Lfe27-SP_info_player_intermission
	.align 2
	.globl IsFemale
	.type	 IsFemale,@function
IsFemale:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl G_ClientExists
	cmpwi 0,3,0
	bc 12,2,.L20
	lwz 3,84(31)
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	addi 3,3,188
	bl Info_ValueForKey
	lbz 3,0(3)
	xori 0,3,70
	subfic 9,0,0
	adde 0,9,0
	xori 3,3,102
	subfic 9,3,0
	adde 3,9,3
	or 3,3,0
	b .L560
.L20:
	li 3,0
.L560:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe28:
	.size	 IsFemale,.Lfe28-IsFemale
	.section	".rodata"
	.align 3
.LC185:
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
	bc 12,2,.L143
	lis 9,g_edicts@ha
	xor 11,5,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,5,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L143
	lfs 11,12(5)
	lfs 13,4(5)
	lfs 10,4(31)
	lfs 0,8(5)
	b .L561
.L143:
	cmpwi 0,4,0
	bc 12,2,.L145
	lis 9,g_edicts@ha
	xor 11,4,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,4,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L145
	lfs 11,12(4)
	lfs 13,4(4)
	lfs 10,4(31)
	lfs 0,8(4)
.L561:
	lfs 9,8(31)
	lfs 12,12(31)
	fsubs 13,13,10
	fsubs 0,0,9
	fsubs 11,11,12
	stfs 13,8(1)
	stfs 0,12(1)
	stfs 11,16(1)
	b .L144
.L145:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,2052(9)
	b .L142
.L144:
	lfs 1,12(1)
	lfs 2,8(1)
	bl atan2
	lis 9,.LC185@ha
	lwz 11,84(31)
	lfd 0,.LC185@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,2052(11)
.L142:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 LookAtKiller,.Lfe29-LookAtKiller
	.section	".rodata"
	.align 2
.LC186:
	.long 0x4b18967f
	.align 2
.LC187:
	.long 0x3f800000
	.align 3
.LC188:
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
	lis 11,.LC187@ha
	lwz 10,maxclients@l(9)
	la 11,.LC187@l(11)
	mr 31,3
	lfs 13,0(11)
	li 29,1
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC186@ha
	lfs 31,.LC186@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L199
	lis 9,.LC188@ha
	lis 27,g_edicts@ha
	la 9,.LC188@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,1116
.L201:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L200
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L200
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
	bc 4,0,.L200
	fmr 31,1
.L200:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,1116
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L201
.L199:
	fmr 1,31
	lwz 0,84(1)
	mtlr 0
	lmw 26,40(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe30:
	.size	 PlayersRangeFromSpot,.Lfe30-PlayersRangeFromSpot
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
	bc 4,2,.L250
	bl SelectRandomDeathmatchSpawnPoint
	b .L563
.L250:
	bl SelectFarthestDeathmatchSpawnPoint
.L563:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe31:
	.size	 SelectDeathmatchSpawnPoint,.Lfe31-SelectDeathmatchSpawnPoint
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
	lis 9,0xfaa1
	lwz 10,game+1028@l(11)
	ori 9,9,7791
	li 30,0
	li 3,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,4
	bc 12,2,.L564
.L256:
	lis 5,.LC110@ha
	mr 3,30
	la 5,.LC110@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L257
	li 3,0
	b .L564
.L257:
	lwz 4,300(30)
	cmpwi 0,4,0
	bc 4,2,.L258
	lis 9,.LC1@ha
	la 4,.LC1@l(9)
.L258:
	lis 3,game+1032@ha
	la 3,game+1032@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L256
	addic. 31,31,-1
	bc 4,2,.L256
	mr 3,30
.L564:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe32:
	.size	 SelectCoopSpawnPoint,.Lfe32-SelectCoopSpawnPoint
	.section	".rodata"
	.align 2
.LC189:
	.long 0x40000000
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
	bl SelectTeamSpawnPoint
	mr. 31,3
	bc 4,2,.L284
	lis 27,.LC111@ha
	lis 28,game@ha
.L291:
	mr 3,31
	li 4,280
	la 5,.LC111@l(27)
	bl G_Find
	mr. 31,3
	bc 12,2,.L566
	la 3,game@l(28)
	lbz 0,1032(3)
	cmpwi 0,0,0
	bc 4,2,.L565
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L286
	b .L291
.L565:
	lwz 4,300(31)
	cmpwi 0,4,0
	bc 12,2,.L291
	addi 3,3,1032
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L291
.L286:
	cmpwi 0,31,0
	bc 4,2,.L284
.L566:
	lis 9,game+1032@ha
	lbz 0,game+1032@l(9)
	cmpwi 0,0,0
	bc 4,2,.L293
	lis 5,.LC111@ha
	li 3,0
	la 5,.LC111@l(5)
	li 4,280
	bl G_Find
	mr 31,3
.L293:
	cmpwi 0,31,0
	bc 4,2,.L284
	lis 9,g_edicts@ha
	lwz 31,g_edicts@l(9)
.L284:
	lfs 0,4(31)
	lis 9,.LC189@ha
	la 9,.LC189@l(9)
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
.Lfe33:
	.size	 SelectSpawnPoint,.Lfe33-SelectSpawnPoint
	.section	".rodata"
	.align 2
.LC190:
	.long 0x3f800000
	.align 2
.LC191:
	.long 0x0
	.align 2
.LC192:
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
	lwz 0,480(31)
	cmpwi 0,0,-40
	bc 4,0,.L333
	lis 29,gi@ha
	lis 3,.LC94@ha
	la 29,gi@l(29)
	la 3,.LC94@l(3)
	lwz 9,36(29)
	lis 27,.LC95@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC190@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC190@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC190@ha
	la 9,.LC190@l(9)
	lfs 2,0(9)
	lis 9,.LC191@ha
	la 9,.LC191@l(9)
	lfs 3,0(9)
	blrl
.L337:
	mr 3,31
	la 4,.LC95@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L337
	lis 9,.LC192@ha
	lfs 0,12(31)
	mr 4,28
	la 9,.LC192@l(9)
	mr 3,31
	lfs 13,0(9)
	fsubs 0,0,13
	stfs 0,12(31)
	bl ThrowClientHead
	stw 30,512(31)
.L333:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe34:
	.size	 body_die,.Lfe34-body_die
	.align 2
	.globl AppearMenu
	.type	 AppearMenu,@function
AppearMenu:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lwz 3,256(29)
	bl Cmd_Team_f
	mr 3,29
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe35:
	.size	 AppearMenu,.Lfe35-AppearMenu
	.align 2
	.globl ClientBeginDeathmatch
	.type	 ClientBeginDeathmatch,@function
ClientBeginDeathmatch:
	stwu 1,-208(1)
	mflr 0
	stmw 27,188(1)
	stw 0,212(1)
	mr 29,3
	lis 27,gi@ha
	addi 3,1,8
	la 4,gi@l(27)
	li 5,176
	crxor 6,6,6
	bl memcpy
	mr 3,29
	bl G_InitEdict
	lwz 28,84(29)
	li 4,0
	li 5,76
	addi 3,28,1812
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,29
	lwz 0,level@l(9)
	stw 0,1812(28)
	bl PutClientInServer
	mr 3,29
	bl ClientEndServerFrame
	lwz 5,84(29)
	lis 4,.LC150@ha
	li 3,2
	lwz 0,gi@l(27)
	la 4,.LC150@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,212(1)
	mtlr 0
	lmw 27,188(1)
	la 1,208(1)
	blr
.Lfe36:
	.size	 ClientBeginDeathmatch,.Lfe36-ClientBeginDeathmatch
	.align 2
	.globl ClientDisconnect
	.type	 ClientDisconnect,@function
ClientDisconnect:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	bl G_ClientExists
	cmpwi 0,3,0
	bc 12,2,.L458
	lis 9,gi@ha
	lwz 5,84(31)
	lis 4,.LC172@ha
	lwz 0,gi@l(9)
	li 3,2
	la 4,.LC172@l(4)
	addi 5,5,700
	la 30,gi@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	lwz 3,2268(9)
	cmpwi 0,3,0
	bc 12,2,.L460
	bl G_FreeEdict
.L460:
	lwz 9,84(31)
	lwz 3,2272(9)
	cmpwi 0,3,0
	bc 12,2,.L461
	bl G_FreeEdict
.L461:
	mr 3,31
	bl CTFDeadDropFlag
	li 4,10
	mr 3,31
	bl muzzleflash
	lwz 9,76(30)
	mr 3,31
	mtlr 9
	blrl
	lis 10,g_edicts@ha
	lis 9,.LC173@ha
	lwz 8,84(31)
	lwz 3,g_edicts@l(10)
	li 0,0
	lis 11,0xbfc5
	la 9,.LC173@l(9)
	stw 0,40(31)
	ori 11,11,18087
	stw 9,280(31)
	subf 3,3,31
	lis 4,.LC1@ha
	stw 0,248(31)
	mullw 3,3,11
	la 4,.LC1@l(4)
	stw 0,88(31)
	stw 0,720(8)
	srawi 3,3,2
	lwz 0,24(30)
	addi 3,3,1311
	mtlr 0
	blrl
.L458:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe37:
	.size	 ClientDisconnect,.Lfe37-ClientDisconnect
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
	lwz 0,480(8)
	cmpwi 0,0,0
	bc 4,1,.L463
	lis 11,gi+48@ha
	lis 9,0x201
	lwz 0,gi+48@l(11)
	ori 9,9,3
	mtlr 0
	blrl
	b .L462
.L463:
	lis 11,gi+48@ha
	lis 9,0x1
	lwz 0,gi+48@l(11)
	mr 3,31
	ori 9,9,3
	mtlr 0
	blrl
.L462:
	mr 3,31
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe38:
	.size	 PM_trace,.Lfe38-PM_trace
	.align 2
	.globl CheckBlock
	.type	 CheckBlock,@function
CheckBlock:
	li 11,0
	li 9,0
	cmpw 0,11,4
	bc 4,0,.L467
.L469:
	lbzx 0,3,9
	addi 9,9,1
	cmpw 0,9,4
	add 11,11,0
	bc 12,0,.L469
.L467:
	mr 3,11
	blr
.Lfe39:
	.size	 CheckBlock,.Lfe39-CheckBlock
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
.L568:
	lbzx 0,3,9
	addi 9,9,1
	add 5,5,0
	bdnz .L568
	li 0,16
	lbz 4,42(3)
	li 6,0
	mtctr 0
	addi 3,3,28
	li 9,0
.L567:
	lbzx 0,3,9
	addi 9,9,1
	add 6,6,0
	bdnz .L567
	lis 3,.LC174@ha
	la 3,.LC174@l(3)
	crxor 6,6,6
	bl Com_Printf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe40:
	.size	 PrintPmove,.Lfe40-PrintPmove
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
