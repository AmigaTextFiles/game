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
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC6@ha
	la 3,level+72@l(31)
	la 4,.LC6@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC7@ha
	la 3,level+72@l(31)
	la 4,.LC7@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC8@ha
	la 3,level+72@l(31)
	la 4,.LC8@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC9@ha
	la 3,level+72@l(31)
	la 4,.LC9@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC10@ha
	la 3,level+72@l(31)
	la 4,.LC10@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC11@ha
	la 3,level+72@l(31)
	la 4,.LC11@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC12@ha
	la 3,level+72@l(31)
	la 4,.LC12@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC13@ha
	la 3,level+72@l(31)
	la 4,.LC13@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC14@ha
	la 3,level+72@l(31)
	la 4,.LC14@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC15@ha
	la 3,level+72@l(31)
	la 4,.LC15@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC16@ha
	la 3,level+72@l(31)
	la 4,.LC16@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC17@ha
	la 3,level+72@l(31)
	la 4,.LC17@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 4,.LC18@ha
	la 3,level+72@l(31)
	la 4,.LC18@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L23
.L26:
	lis 9,SP_FixCoopSpots@ha
	lis 10,level+4@ha
	la 9,SP_FixCoopSpots@l(9)
	lis 11,.LC19@ha
	stw 9,436(30)
	lfs 0,level+4@l(10)
	lfd 13,.LC19@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(30)
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
	.string	"gender"
	.align 2
.LC22:
	.string	""
	.align 2
.LC23:
	.string	"suicides"
	.align 2
.LC24:
	.string	"cratered"
	.align 2
.LC25:
	.string	"was squished"
	.align 2
.LC26:
	.string	"sank like a rock"
	.align 2
.LC27:
	.string	"melted"
	.align 2
.LC28:
	.string	"does a back flip into the lava"
	.align 2
.LC29:
	.string	"blew up"
	.align 2
.LC30:
	.string	"found a way out"
	.align 2
.LC31:
	.string	"saw the light"
	.align 2
.LC32:
	.string	"got blasted"
	.align 2
.LC33:
	.string	"was in the wrong place"
	.align 2
.LC34:
	.string	"tried to put the pin back in"
	.align 2
.LC35:
	.string	"forgot to take cover"
	.align 2
.LC36:
	.string	"blew itself up"
	.align 2
.LC37:
	.string	"blew herself up"
	.align 2
.LC38:
	.string	"blew himself up"
	.align 2
.LC39:
	.string	"should have used a smaller gun"
	.align 2
.LC40:
	.string	"killed itself"
	.align 2
.LC41:
	.string	"killed herself"
	.align 2
.LC42:
	.string	"killed himself"
	.align 2
.LC43:
	.string	"bled to death cuz of the wounds he caused himself"
	.align 2
.LC44:
	.string	"%s %s.\n"
	.align 2
.LC45:
	.string	"was humiliated by"
	.align 2
.LC46:
	.string	"looks like a Swiss cheese after meeting"
	.align 2
.LC47:
	.string	"was blown away by"
	.align 2
.LC48:
	.string	"'s super shotgun"
	.align 2
.LC49:
	.string	"unfortunately met"
	.align 2
.LC50:
	.string	" carrying his trusty automatic"
	.align 2
.LC51:
	.string	"tried to defend himself from"
	.align 2
.LC52:
	.string	"'s AK47"
	.align 2
.LC53:
	.string	"was killed by"
	.align 2
.LC54:
	.string	"'s silenced Glock"
	.align 2
.LC55:
	.string	"lost his head to"
	.align 2
.LC56:
	.string	"'s sharp Bush Knife"
	.align 2
.LC57:
	.string	"is left in pieces by"
	.align 2
.LC58:
	.string	"`s legs are half as long as they used to be, cuz of"
	.align 2
.LC59:
	.string	"bled to death thanks to the wounds"
	.align 2
.LC60:
	.string	" caused"
	.align 2
.LC61:
	.string	"was cut in half by"
	.align 2
.LC62:
	.string	"'s chaingun"
	.align 2
.LC63:
	.string	"was popped by"
	.align 2
.LC64:
	.string	"'s grenade"
	.align 2
.LC65:
	.string	"was shredded by"
	.align 2
.LC66:
	.string	"'s shrapnel"
	.align 2
.LC67:
	.string	"ate"
	.align 2
.LC68:
	.string	"'s rocket"
	.align 2
.LC69:
	.string	"almost dodged"
	.align 2
.LC70:
	.string	"was melted by"
	.align 2
.LC71:
	.string	"'s hyperblaster"
	.align 2
.LC72:
	.string	"was sniped by"
	.align 2
.LC73:
	.string	"saw the pretty lights from"
	.align 2
.LC74:
	.string	"'s BFG"
	.align 2
.LC75:
	.string	"was disintegrated by"
	.align 2
.LC76:
	.string	"'s BFG blast"
	.align 2
.LC77:
	.string	"couldn't hide from"
	.align 2
.LC78:
	.string	"happened to be too close"
	.align 2
.LC79:
	.string	"'s explosive"
	.align 2
.LC80:
	.string	"didn't see"
	.align 2
.LC81:
	.string	"feels"
	.align 2
.LC82:
	.string	"'s pain"
	.align 2
.LC83:
	.string	"%s %s %s%s\n"
	.align 2
.LC84:
	.string	"You have %i kills in a row\n"
	.align 2
.LC85:
	.string	"%s has %i kills in a row, he now gets 2 frags per kill\n"
	.align 2
.LC86:
	.string	"%s has %i kills in a row, he now gets 4 frags per kill\n"
	.align 2
.LC87:
	.string	"%s has %i kills in a row, he now gets 6 frags per kill\n"
	.align 2
.LC88:
	.string	"%s has %i kills in a row, he now gets 8 frags per kill\n"
	.align 2
.LC89:
	.string	"%s died.\n"
	.align 2
.LC90:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientObituary
	.type	 ClientObituary,@function
ClientObituary:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 9,coop@ha
	lis 8,.LC90@ha
	lwz 11,coop@l(9)
	la 8,.LC90@l(8)
	mr 30,3
	lfs 13,0(8)
	mr 29,5
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L36
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L36
	lis 9,meansOfDeath@ha
	lwz 0,meansOfDeath@l(9)
	oris 0,0,0x800
	stw 0,meansOfDeath@l(9)
.L36:
	lis 11,.LC90@ha
	lis 9,deathmatch@ha
	la 11,.LC90@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L38
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L37
.L38:
	lis 9,meansOfDeath@ha
	lis 11,.LC22@ha
	lwz 0,meansOfDeath@l(9)
	la 28,.LC22@l(11)
	li 31,0
	rlwinm 27,0,0,5,3
	rlwinm 25,0,0,4,4
	addi 10,27,-17
	cmplwi 0,10,16
	bc 12,1,.L39
	lis 11,.L54@ha
	slwi 10,10,2
	la 11,.L54@l(11)
	lis 9,.L54@ha
	lwzx 0,10,11
	la 9,.L54@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L54:
	.long .L43-.L54
	.long .L44-.L54
	.long .L45-.L54
	.long .L42-.L54
	.long .L39-.L54
	.long .L41-.L54
	.long .L40-.L54
	.long .L39-.L54
	.long .L47-.L54
	.long .L47-.L54
	.long .L53-.L54
	.long .L48-.L54
	.long .L53-.L54
	.long .L49-.L54
	.long .L53-.L54
	.long .L39-.L54
	.long .L50-.L54
.L40:
	lis 9,.LC23@ha
	la 31,.LC23@l(9)
	b .L39
.L41:
	lis 9,.LC24@ha
	la 31,.LC24@l(9)
	b .L39
.L42:
	lis 9,.LC25@ha
	la 31,.LC25@l(9)
	b .L39
.L43:
	lis 9,.LC26@ha
	la 31,.LC26@l(9)
	b .L39
.L44:
	lis 9,.LC27@ha
	la 31,.LC27@l(9)
	b .L39
.L45:
	lis 9,.LC28@ha
	la 31,.LC28@l(9)
	b .L39
.L47:
	lis 9,.LC29@ha
	la 31,.LC29@l(9)
	b .L39
.L48:
	lis 9,.LC30@ha
	la 31,.LC30@l(9)
	b .L39
.L49:
	lis 9,.LC31@ha
	la 31,.LC31@l(9)
	b .L39
.L50:
	lis 9,.LC32@ha
	la 31,.LC32@l(9)
	b .L39
.L53:
	lis 9,.LC33@ha
	la 31,.LC33@l(9)
.L39:
	cmpw 0,29,30
	bc 4,2,.L56
	addi 10,27,-7
	cmplwi 0,10,17
	bc 12,1,.L83
	lis 11,.L97@ha
	slwi 10,10,2
	la 11,.L97@l(11)
	lis 9,.L97@ha
	lwzx 0,10,11
	la 9,.L97@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L97:
	.long .L60-.L97
	.long .L83-.L97
	.long .L71-.L97
	.long .L83-.L97
	.long .L83-.L97
	.long .L83-.L97
	.long .L82-.L97
	.long .L83-.L97
	.long .L83-.L97
	.long .L60-.L97
	.long .L83-.L97
	.long .L83-.L97
	.long .L83-.L97
	.long .L83-.L97
	.long .L83-.L97
	.long .L83-.L97
	.long .L83-.L97
	.long .L58-.L97
.L58:
	lis 9,.LC34@ha
	la 31,.LC34@l(9)
	b .L56
.L60:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L62
	li 10,0
	b .L63
.L62:
	lis 4,.LC21@ha
	addi 3,3,188
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	lbz 11,0(3)
	li 10,0
	xori 9,11,102
	xori 0,11,70
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,9,0
	bc 12,2,.L63
	cmpwi 0,11,109
	bc 12,2,.L63
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L63:
	cmpwi 0,10,0
	bc 4,2,.L66
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L67
	li 0,0
	b .L68
.L67:
	lis 4,.LC21@ha
	addi 3,3,188
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 11,0,0
	adde 0,11,0
	or 0,0,9
.L68:
	cmpwi 0,0,0
.L66:
	lis 9,.LC35@ha
	la 31,.LC35@l(9)
	b .L56
.L71:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L73
	li 10,0
	b .L74
.L73:
	lis 4,.LC21@ha
	addi 3,3,188
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	lbz 11,0(3)
	li 10,0
	xori 9,11,102
	xori 0,11,70
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,9,0
	bc 12,2,.L74
	cmpwi 0,11,109
	bc 12,2,.L74
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L74:
	cmpwi 0,10,0
	bc 12,2,.L72
	lis 9,.LC36@ha
	la 31,.LC36@l(9)
	b .L56
.L72:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L78
	li 0,0
	b .L79
.L78:
	lis 4,.LC21@ha
	addi 3,3,188
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 11,0,0
	adde 0,11,0
	or 0,0,9
.L79:
	cmpwi 0,0,0
	bc 12,2,.L77
	lis 9,.LC37@ha
	la 31,.LC37@l(9)
	b .L56
.L77:
	lis 9,.LC38@ha
	la 31,.LC38@l(9)
	b .L56
.L82:
	lis 9,.LC39@ha
	la 31,.LC39@l(9)
	b .L56
.L83:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L85
	li 10,0
	b .L86
.L85:
	lis 4,.LC21@ha
	addi 3,3,188
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	lbz 11,0(3)
	li 10,0
	xori 9,11,102
	xori 0,11,70
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 8,9,0
	bc 12,2,.L86
	cmpwi 0,11,109
	bc 12,2,.L86
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L86:
	cmpwi 0,10,0
	bc 12,2,.L84
	lwz 9,84(30)
	lwz 0,4044(9)
	cmpwi 0,0,0
	bc 4,2,.L84
	lis 9,.LC40@ha
	la 31,.LC40@l(9)
	b .L56
.L84:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L90
	li 0,0
	b .L91
.L90:
	lis 4,.LC21@ha
	addi 3,3,188
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 11,0,0
	adde 0,11,0
	or 0,0,9
.L91:
	cmpwi 0,0,0
	bc 12,2,.L89
	lwz 9,84(30)
	lwz 0,4044(9)
	cmpwi 0,0,0
	bc 4,2,.L94
	lis 9,.LC41@ha
	la 31,.LC41@l(9)
	b .L56
.L89:
	lwz 9,84(30)
	lwz 0,4044(9)
	cmpwi 0,0,0
	bc 4,2,.L94
	lis 9,.LC42@ha
	la 31,.LC42@l(9)
	b .L56
.L94:
	lwz 9,84(30)
	lwz 0,4044(9)
	cmpwi 0,0,1
	bc 4,2,.L56
	lis 9,.LC43@ha
	la 31,.LC43@l(9)
.L56:
	cmpwi 0,31,0
	bc 12,2,.L98
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC44@ha
	lwz 0,gi@l(9)
	la 4,.LC44@l(4)
	mr 6,31
	addi 5,5,700
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	lis 11,deathmatch@ha
	lis 8,.LC90@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC90@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L99
	lwz 11,84(30)
	lwz 9,3528(11)
	addi 9,9,-1
	stw 9,3528(11)
.L99:
	li 0,0
	stw 0,540(30)
	b .L35
.L98:
	cmpwi 0,29,0
	stw 29,540(30)
	bc 12,2,.L37
	lwz 0,84(29)
	cmpwi 0,0,0
	mr 7,0
	bc 12,2,.L37
	addi 0,27,-1
	cmplwi 0,0,38
	bc 12,1,.L101
	lis 11,.L125@ha
	slwi 10,0,2
	la 11,.L125@l(11)
	lis 9,.L125@ha
	lwzx 0,10,11
	la 9,.L125@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L125:
	.long .L102-.L125
	.long .L103-.L125
	.long .L104-.L125
	.long .L105-.L125
	.long .L112-.L125
	.long .L113-.L125
	.long .L114-.L125
	.long .L115-.L125
	.long .L116-.L125
	.long .L117-.L125
	.long .L118-.L125
	.long .L119-.L125
	.long .L120-.L125
	.long .L121-.L125
	.long .L122-.L125
	.long .L123-.L125
	.long .L101-.L125
	.long .L101-.L125
	.long .L101-.L125
	.long .L101-.L125
	.long .L101-.L125
	.long .L101-.L125
	.long .L101-.L125
	.long .L124-.L125
	.long .L101-.L125
	.long .L101-.L125
	.long .L101-.L125
	.long .L101-.L125
	.long .L101-.L125
	.long .L101-.L125
	.long .L101-.L125
	.long .L101-.L125
	.long .L101-.L125
	.long .L106-.L125
	.long .L107-.L125
	.long .L108-.L125
	.long .L109-.L125
	.long .L110-.L125
	.long .L111-.L125
.L102:
	lis 9,.LC45@ha
	la 31,.LC45@l(9)
	b .L101
.L103:
	lis 9,.LC46@ha
	la 31,.LC46@l(9)
	b .L101
.L104:
	lis 9,.LC47@ha
	lis 11,.LC48@ha
	la 31,.LC47@l(9)
	la 28,.LC48@l(11)
	b .L101
.L105:
	lis 9,.LC49@ha
	lis 11,.LC50@ha
	la 31,.LC49@l(9)
	la 28,.LC50@l(11)
	b .L101
.L106:
	lis 9,.LC51@ha
	lis 11,.LC52@ha
	la 31,.LC51@l(9)
	la 28,.LC52@l(11)
	b .L101
.L107:
	lis 9,.LC53@ha
	lis 11,.LC54@ha
	la 31,.LC53@l(9)
	la 28,.LC54@l(11)
	b .L101
.L108:
	lis 9,.LC55@ha
	lis 11,.LC56@ha
	la 31,.LC55@l(9)
	la 28,.LC56@l(11)
	b .L101
.L109:
	lis 9,.LC57@ha
	lis 11,.LC56@ha
	la 31,.LC57@l(9)
	la 28,.LC56@l(11)
	b .L101
.L110:
	lis 9,.LC58@ha
	lis 11,.LC56@ha
	la 31,.LC58@l(9)
	la 28,.LC56@l(11)
	b .L101
.L111:
	lis 9,.LC59@ha
	lis 11,.LC60@ha
	la 31,.LC59@l(9)
	la 28,.LC60@l(11)
	b .L101
.L112:
	lis 9,.LC61@ha
	lis 11,.LC62@ha
	la 31,.LC61@l(9)
	la 28,.LC62@l(11)
	b .L101
.L113:
	lis 9,.LC63@ha
	lis 11,.LC64@ha
	la 31,.LC63@l(9)
	la 28,.LC64@l(11)
	b .L101
.L114:
	lis 9,.LC65@ha
	lis 11,.LC66@ha
	la 31,.LC65@l(9)
	la 28,.LC66@l(11)
	b .L101
.L115:
	lis 9,.LC67@ha
	lis 11,.LC68@ha
	la 31,.LC67@l(9)
	la 28,.LC68@l(11)
	b .L101
.L116:
	lis 9,.LC69@ha
	lis 11,.LC68@ha
	la 31,.LC69@l(9)
	la 28,.LC68@l(11)
	b .L101
.L117:
	lis 9,.LC70@ha
	lis 11,.LC71@ha
	la 31,.LC70@l(9)
	la 28,.LC71@l(11)
	b .L101
.L118:
	lis 9,.LC72@ha
	la 31,.LC72@l(9)
	b .L101
.L119:
	lis 9,.LC73@ha
	lis 11,.LC74@ha
	la 31,.LC73@l(9)
	la 28,.LC74@l(11)
	b .L101
.L120:
	lis 9,.LC75@ha
	lis 11,.LC76@ha
	la 31,.LC75@l(9)
	la 28,.LC76@l(11)
	b .L101
.L121:
	lis 9,.LC77@ha
	lis 11,.LC74@ha
	la 31,.LC77@l(9)
	la 28,.LC74@l(11)
	b .L101
.L122:
	lis 9,.LC78@ha
	lis 11,.LC79@ha
	la 31,.LC78@l(9)
	la 28,.LC79@l(11)
	b .L101
.L123:
	lis 9,.LC80@ha
	lis 11,.LC79@ha
	la 31,.LC80@l(9)
	la 28,.LC79@l(11)
	b .L101
.L124:
	lis 9,.LC81@ha
	lis 11,.LC82@ha
	la 31,.LC81@l(9)
	la 28,.LC82@l(11)
.L101:
	cmpwi 0,31,0
	bc 12,2,.L37
	lis 27,gi@ha
	lwz 5,84(30)
	lis 4,.LC83@ha
	lwz 9,gi@l(27)
	mr 8,28
	la 4,.LC83@l(4)
	addi 5,5,700
	mr 6,31
	mtlr 9
	addi 7,7,700
	li 3,1
	la 26,gi@l(27)
	crxor 6,6,6
	blrl
	lis 9,deathmatch@ha
	lis 8,.LC90@ha
	lwz 11,deathmatch@l(9)
	la 8,.LC90@l(8)
	lfs 13,0(8)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L35
	cmpwi 0,25,0
	bc 12,2,.L129
	lwz 11,84(29)
	b .L146
.L129:
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 7,0,13
	bc 4,30,.L131
	lwz 11,84(29)
	lwz 9,3984(11)
	addi 9,9,1
	stw 9,3984(11)
	lwz 11,84(29)
	lwz 6,3984(11)
	cmpwi 0,6,3
	bc 12,1,.L132
	lwz 9,3528(11)
	lis 5,.LC84@ha
	mr 3,29
	la 5,.LC84@l(5)
	li 4,2
	addi 9,9,1
	stw 9,3528(11)
	lwz 11,84(29)
	lwz 0,8(26)
	lwz 6,3984(11)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L35
.L132:
	addi 0,6,-4
	cmplwi 0,0,3
	bc 12,1,.L134
	lwz 0,gi@l(27)
	lis 4,.LC85@ha
	addi 5,11,700
	la 4,.LC85@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(29)
	lwz 9,3528(11)
	addi 9,9,2
	b .L147
.L134:
	addi 0,6,-8
	cmplwi 0,0,3
	bc 12,1,.L136
	lwz 0,gi@l(27)
	lis 4,.LC86@ha
	addi 5,11,700
	la 4,.LC86@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(29)
	lwz 9,3528(11)
	addi 9,9,4
	b .L147
.L136:
	addi 0,6,-12
	cmplwi 0,0,3
	bc 12,1,.L138
	lwz 0,gi@l(27)
	lis 4,.LC87@ha
	addi 5,11,700
	la 4,.LC87@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(29)
	lwz 9,3528(11)
	addi 9,9,6
	b .L147
.L138:
	cmpwi 0,6,15
	bc 4,1,.L35
	lwz 0,gi@l(27)
	lis 4,.LC88@ha
	addi 5,11,700
	la 4,.LC88@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(29)
	lwz 9,3528(11)
	addi 9,9,8
	b .L147
.L131:
	xor 0,29,30
	lwz 10,84(29)
	addic 8,0,-1
	subfe 11,8,0
	addic 0,10,-1
	subfe 9,0,10
	and. 8,9,11
	bc 12,2,.L35
	lwz 9,84(30)
	lwz 11,3532(10)
	lwz 0,3532(9)
	cmpw 0,11,0
	bc 12,2,.L35
	cmpwi 0,11,0
	bc 12,2,.L35
	bc 12,30,.L35
	cmpwi 0,11,1
	bc 4,2,.L143
	lis 11,ctfgame@ha
	lwz 9,ctfgame@l(11)
	addi 9,9,1
	stw 9,ctfgame@l(11)
	b .L35
.L143:
	lis 11,ctfgame@ha
	la 11,ctfgame@l(11)
	lwz 9,4(11)
	addi 9,9,1
	stw 9,4(11)
	b .L35
.L37:
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC89@ha
	lwz 0,gi@l(9)
	la 4,.LC89@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lis 11,deathmatch@ha
	lis 8,.LC90@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC90@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L35
	lwz 11,84(30)
.L146:
	lwz 9,3528(11)
	addi 9,9,-1
.L147:
	stw 9,3528(11)
.L35:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 ClientObituary,.Lfe2-ClientObituary
	.section	".rodata"
	.align 2
.LC91:
	.string	"IR goggles"
	.align 2
.LC92:
	.string	"IR Goggles"
	.align 2
.LC93:
	.string	"Bullet Proof Vest"
	.align 2
.LC94:
	.string	"Helmet"
	.align 2
.LC95:
	.string	"C4 Detpack"
	.align 2
.LC96:
	.string	"Mine"
	.align 2
.LC97:
	.string	"mine"
	.align 2
.LC98:
	.string	"detonator"
	.align 2
.LC99:
	.string	"medkit"
	.align 2
.LC100:
	.string	"scuba gear"
	.align 2
.LC101:
	.string	"ak 47"
	.align 2
.LC102:
	.string	"ak47rounds"
	.align 2
.LC103:
	.string	"glock"
	.align 2
.LC104:
	.string	"glockrounds"
	.align 2
.LC105:
	.string	"casull"
	.align 2
.LC106:
	.string	"casullrounds"
	.align 2
.LC107:
	.string	"beretta"
	.align 2
.LC108:
	.string	"berettarounds"
	.align 2
.LC109:
	.string	"uzi"
	.align 2
.LC110:
	.string	"uzirounds"
	.align 2
.LC111:
	.string	"mp5"
	.align 2
.LC112:
	.string	"mp5rounds"
	.align 2
.LC113:
	.string	"m60"
	.align 2
.LC114:
	.string	"m60rounds"
	.align 2
.LC115:
	.string	"barrett"
	.align 2
.LC116:
	.string	"50cal"
	.align 2
.LC117:
	.string	"msg90"
	.align 2
.LC118:
	.string	"msg90rounds"
	.align 2
.LC119:
	.string	"mariner"
	.align 2
.LC120:
	.string	"marinerrounds"
	.align 2
.LC121:
	.string	"head light"
	.align 2
.LC122:
	.string	"grenades"
	.align 3
.LC123:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC124:
	.long 0x0
	.align 2
.LC125:
	.long 0x41b40000
	.align 2
.LC126:
	.long 0x3f800000
	.align 2
.LC127:
	.long 0x43f00000
	.section	".text"
	.align 2
	.globl TossClientWeapon
	.type	 TossClientWeapon,@function
TossClientWeapon:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 27,52(1)
	stw 0,84(1)
	lis 9,dmflags@ha
	mr 31,3
	lwz 11,dmflags@l(9)
	lwz 8,84(31)
	lfs 0,20(11)
	lwz 0,3640(8)
	addi 11,8,740
	lwz 3,1824(8)
	slwi 0,0,2
	lwzx 9,11,0
	fctiwz 13,0
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	stfd 13,40(1)
	srawi 0,0,31
	lwz 10,44(1)
	and 3,3,0
	andi. 0,10,16384
	bc 4,2,.L150
	li 4,0
	b .L151
.L150:
	lis 10,level@ha
	lfs 12,3836(8)
	lwz 9,level@l(10)
	lis 0,0x4330
	lis 10,.LC123@ha
	addi 9,9,10
	la 10,.LC123@l(10)
	xoris 9,9,0x8000
	lfd 13,0(10)
	stw 9,44(1)
	stw 0,40(1)
	lfd 0,40(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 7,12,0
	mfcr 4
	rlwinm 4,4,30,1
.L151:
	addic 11,3,-1
	subfe 0,11,3
	lis 9,.LC124@ha
	and. 10,0,4
	la 9,.LC124@l(9)
	lfs 31,0(9)
	bc 12,2,.L152
	lis 11,.LC125@ha
	la 11,.LC125@l(11)
	lfs 31,0(11)
.L152:
	lis 3,.LC91@ha
	lwz 29,84(31)
	lis 30,0x286b
	la 3,.LC91@l(3)
	ori 30,30,51739
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 27,itemlist@l(9)
	subf 3,27,3
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L154
	bl rand
	mulli 0,3,10
	lis 11,0x4330
	lis 10,.LC123@ha
	lis 3,.LC92@ha
	xoris 0,0,0x8000
	la 10,.LC123@l(10)
	stw 0,44(1)
	la 3,.LC92@l(3)
	stw 11,40(1)
	lfd 0,40(1)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	fadds 31,31,0
	bl FindItem
	lwz 9,84(31)
	mr 4,3
	mr 3,31
	lfs 0,3768(9)
	fsubs 0,0,31
	stfs 0,3768(9)
	bl Drop_Item
	lwz 9,84(31)
	lfs 0,3768(9)
	fadds 0,0,31
	stfs 0,3768(9)
.L154:
	lis 28,.LC93@ha
	lwz 29,84(31)
	la 3,.LC93@l(28)
	bl FindItem
	subf 3,27,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L155
	bl rand
	mulli 0,3,10
	lis 11,0x4330
	lis 10,.LC123@ha
	la 3,.LC93@l(28)
	xoris 0,0,0x8000
	la 10,.LC123@l(10)
	stw 0,44(1)
	stw 11,40(1)
	lfd 0,40(1)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	fadds 31,31,0
	bl FindItem
	lwz 9,84(31)
	mr 4,3
	mr 3,31
	lfs 0,3768(9)
	fsubs 0,0,31
	stfs 0,3768(9)
	bl Drop_Item
	lwz 9,84(31)
	lfs 0,3768(9)
	fadds 0,0,31
	stfs 0,3768(9)
.L155:
	lis 28,.LC94@ha
	lwz 29,84(31)
	la 3,.LC94@l(28)
	bl FindItem
	subf 3,27,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L156
	bl rand
	mulli 0,3,10
	lis 11,0x4330
	lis 10,.LC123@ha
	la 3,.LC94@l(28)
	xoris 0,0,0x8000
	la 10,.LC123@l(10)
	stw 0,44(1)
	stw 11,40(1)
	lfd 0,40(1)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	fadds 31,31,0
	bl FindItem
	lwz 9,84(31)
	mr 4,3
	mr 3,31
	lfs 0,3768(9)
	fsubs 0,0,31
	stfs 0,3768(9)
	bl Drop_Item
	lwz 9,84(31)
	lfs 0,3768(9)
	fadds 0,0,31
	stfs 0,3768(9)
.L156:
	lis 28,.LC95@ha
	lwz 29,84(31)
	la 3,.LC95@l(28)
	bl FindItem
	subf 3,27,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L157
	bl rand
	mulli 0,3,10
	lis 11,0x4330
	lis 10,.LC123@ha
	la 3,.LC95@l(28)
	xoris 0,0,0x8000
	la 10,.LC123@l(10)
	stw 0,44(1)
	stw 11,40(1)
	lfd 0,40(1)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	fadds 31,31,0
	bl FindItem
	lwz 9,84(31)
	mr 4,3
	mr 3,31
	lfs 0,3768(9)
	fsubs 0,0,31
	stfs 0,3768(9)
	bl Drop_Item
	lwz 9,84(31)
	lfs 0,3768(9)
	fadds 0,0,31
	stfs 0,3768(9)
.L157:
	lis 3,.LC96@ha
	lwz 29,84(31)
	la 3,.LC96@l(3)
	bl FindItem
	subf 3,27,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L158
	bl rand
	mulli 0,3,10
	lis 11,0x4330
	lis 10,.LC123@ha
	lis 3,.LC97@ha
	xoris 0,0,0x8000
	la 10,.LC123@l(10)
	stw 0,44(1)
	la 3,.LC97@l(3)
	stw 11,40(1)
	lfd 0,40(1)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	fadds 31,31,0
	bl FindItem
	lwz 9,84(31)
	mr 4,3
	mr 3,31
	lfs 0,3768(9)
	fsubs 0,0,31
	stfs 0,3768(9)
	bl Drop_Item
	lwz 9,84(31)
	lfs 0,3768(9)
	fadds 0,0,31
	stfs 0,3768(9)
.L158:
	lis 28,.LC98@ha
	lwz 29,84(31)
	la 3,.LC98@l(28)
	bl FindItem
	subf 3,27,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L159
	bl rand
	mulli 0,3,10
	lis 11,0x4330
	lis 10,.LC123@ha
	la 3,.LC98@l(28)
	xoris 0,0,0x8000
	la 10,.LC123@l(10)
	stw 0,44(1)
	stw 11,40(1)
	lfd 0,40(1)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	fadds 31,31,0
	bl FindItem
	lwz 9,84(31)
	mr 4,3
	mr 3,31
	lfs 0,3768(9)
	fsubs 0,0,31
	stfs 0,3768(9)
	bl Drop_Item
	lwz 9,84(31)
	lfs 0,3768(9)
	fadds 0,0,31
	stfs 0,3768(9)
.L159:
	lis 28,.LC99@ha
	lwz 29,84(31)
	la 3,.LC99@l(28)
	bl FindItem
	subf 3,27,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L160
	bl rand
	mulli 0,3,10
	lis 11,0x4330
	lis 10,.LC123@ha
	la 3,.LC99@l(28)
	xoris 0,0,0x8000
	la 10,.LC123@l(10)
	stw 0,44(1)
	stw 11,40(1)
	lfd 0,40(1)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	fadds 31,31,0
	bl FindItem
	lwz 9,84(31)
	mr 4,3
	mr 3,31
	lfs 0,3768(9)
	fsubs 0,0,31
	stfs 0,3768(9)
	bl Drop_Item
	lwz 9,84(31)
	lfs 0,3768(9)
	fadds 0,0,31
	stfs 0,3768(9)
.L160:
	lis 28,.LC100@ha
	lwz 29,84(31)
	la 3,.LC100@l(28)
	bl FindItem
	subf 3,27,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L161
	bl rand
	mulli 0,3,10
	lis 11,0x4330
	lis 10,.LC123@ha
	la 3,.LC100@l(28)
	xoris 0,0,0x8000
	la 10,.LC123@l(10)
	stw 0,44(1)
	stw 11,40(1)
	lfd 0,40(1)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	fadds 31,31,0
	bl FindItem
	lwz 9,84(31)
	mr 4,3
	mr 3,31
	lfs 0,3768(9)
	fsubs 0,0,31
	stfs 0,3768(9)
	bl Drop_Item
	lwz 9,84(31)
	lfs 0,3768(9)
	fadds 0,0,31
	stfs 0,3768(9)
.L161:
	lis 28,.LC101@ha
	lwz 29,84(31)
	la 3,.LC101@l(28)
	bl FindItem
	subf 3,27,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L162
	bl rand
	mulli 0,3,10
	lis 11,0x4330
	lis 10,.LC123@ha
	la 3,.LC101@l(28)
	xoris 0,0,0x8000
	la 10,.LC123@l(10)
	stw 0,44(1)
	stw 11,40(1)
	lfd 0,40(1)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	fadds 31,31,0
	bl FindItem
	lwz 9,84(31)
	mr 4,3
	mr 3,31
	lfs 0,3768(9)
	fsubs 0,0,31
	stfs 0,3768(9)
	bl Drop_Item
	lwz 9,84(31)
	mr 29,3
	lis 3,.LC102@ha
	lfs 0,3768(9)
	la 3,.LC102@l(3)
	fadds 0,0,31
	stfs 0,3768(9)
	bl FindItem
	subf 3,27,3
	lwz 9,84(31)
	mullw 3,3,30
	addi 9,9,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	stw 0,924(29)
.L162:
	lis 28,.LC103@ha
	lwz 29,84(31)
	la 3,.LC103@l(28)
	bl FindItem
	subf 3,27,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L163
	bl rand
	mulli 0,3,10
	lis 11,0x4330
	lis 10,.LC123@ha
	la 3,.LC103@l(28)
	xoris 0,0,0x8000
	la 10,.LC123@l(10)
	stw 0,44(1)
	stw 11,40(1)
	lfd 0,40(1)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	fadds 31,31,0
	bl FindItem
	lwz 9,84(31)
	mr 4,3
	mr 3,31
	lfs 0,3768(9)
	fsubs 0,0,31
	stfs 0,3768(9)
	bl Drop_Item
	lwz 9,84(31)
	mr 29,3
	lis 3,.LC104@ha
	lfs 0,3768(9)
	la 3,.LC104@l(3)
	fadds 0,0,31
	stfs 0,3768(9)
	bl FindItem
	subf 3,27,3
	lwz 9,84(31)
	mullw 3,3,30
	addi 9,9,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	cmpwi 0,0,0
	stw 0,924(29)
	bc 4,2,.L163
	li 0,1
	stw 0,56(29)
.L163:
	lis 28,.LC105@ha
	lwz 29,84(31)
	lis 30,0x286b
	la 3,.LC105@l(28)
	ori 30,30,51739
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 27,itemlist@l(9)
	subf 3,27,3
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L165
	bl rand
	mulli 0,3,10
	lis 11,0x4330
	lis 10,.LC123@ha
	la 3,.LC105@l(28)
	xoris 0,0,0x8000
	la 10,.LC123@l(10)
	stw 0,44(1)
	stw 11,40(1)
	lfd 0,40(1)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	fadds 31,31,0
	bl FindItem
	lwz 9,84(31)
	mr 4,3
	mr 3,31
	lfs 0,3768(9)
	fsubs 0,0,31
	stfs 0,3768(9)
	bl Drop_Item
	lwz 9,84(31)
	mr 29,3
	lis 3,.LC106@ha
	lfs 0,3768(9)
	la 3,.LC106@l(3)
	fadds 0,0,31
	stfs 0,3768(9)
	bl FindItem
	subf 3,27,3
	lwz 9,84(31)
	mullw 3,3,30
	addi 9,9,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	stw 0,924(29)
.L165:
	lis 28,.LC107@ha
	lwz 29,84(31)
	la 3,.LC107@l(28)
	bl FindItem
	subf 3,27,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L166
	bl rand
	mulli 0,3,10
	lis 11,0x4330
	lis 10,.LC123@ha
	la 3,.LC107@l(28)
	xoris 0,0,0x8000
	la 10,.LC123@l(10)
	stw 0,44(1)
	stw 11,40(1)
	lfd 0,40(1)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	fadds 31,31,0
	bl FindItem
	lwz 9,84(31)
	mr 4,3
	mr 3,31
	lfs 0,3768(9)
	fsubs 0,0,31
	stfs 0,3768(9)
	bl Drop_Item
	lwz 9,84(31)
	mr 29,3
	lis 3,.LC108@ha
	lfs 0,3768(9)
	la 3,.LC108@l(3)
	fadds 0,0,31
	stfs 0,3768(9)
	bl FindItem
	subf 3,27,3
	lwz 9,84(31)
	mullw 3,3,30
	addi 9,9,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	cmpwi 0,0,0
	stw 0,924(29)
	bc 4,2,.L166
	li 0,1
	stw 0,56(29)
.L166:
	lis 28,.LC109@ha
	lwz 29,84(31)
	lis 30,0x286b
	la 3,.LC109@l(28)
	ori 30,30,51739
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 27,itemlist@l(9)
	subf 3,27,3
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L168
	bl rand
	mulli 0,3,10
	lis 11,0x4330
	lis 10,.LC123@ha
	la 3,.LC109@l(28)
	xoris 0,0,0x8000
	la 10,.LC123@l(10)
	stw 0,44(1)
	stw 11,40(1)
	lfd 0,40(1)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	fadds 31,31,0
	bl FindItem
	lwz 9,84(31)
	mr 4,3
	mr 3,31
	lfs 0,3768(9)
	fsubs 0,0,31
	stfs 0,3768(9)
	bl Drop_Item
	lwz 9,84(31)
	mr 29,3
	lis 3,.LC110@ha
	lfs 0,3768(9)
	la 3,.LC110@l(3)
	fadds 0,0,31
	stfs 0,3768(9)
	bl FindItem
	subf 3,27,3
	lwz 9,84(31)
	mullw 3,3,30
	addi 9,9,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	stw 0,924(29)
.L168:
	lis 28,.LC111@ha
	lwz 29,84(31)
	la 3,.LC111@l(28)
	bl FindItem
	subf 3,27,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L169
	bl rand
	mulli 0,3,10
	lis 11,0x4330
	lis 10,.LC123@ha
	la 3,.LC111@l(28)
	xoris 0,0,0x8000
	la 10,.LC123@l(10)
	stw 0,44(1)
	stw 11,40(1)
	lfd 0,40(1)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	fadds 31,31,0
	bl FindItem
	lwz 9,84(31)
	mr 4,3
	mr 3,31
	lfs 0,3768(9)
	fsubs 0,0,31
	stfs 0,3768(9)
	bl Drop_Item
	lwz 9,84(31)
	mr 29,3
	lis 3,.LC112@ha
	lfs 0,3768(9)
	la 3,.LC112@l(3)
	fadds 0,0,31
	stfs 0,3768(9)
	bl FindItem
	subf 3,27,3
	lwz 9,84(31)
	mullw 3,3,30
	addi 9,9,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	stw 0,924(29)
.L169:
	lis 28,.LC113@ha
	lwz 29,84(31)
	la 3,.LC113@l(28)
	bl FindItem
	subf 3,27,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L170
	bl rand
	mulli 0,3,10
	lis 11,0x4330
	lis 10,.LC123@ha
	la 3,.LC113@l(28)
	xoris 0,0,0x8000
	la 10,.LC123@l(10)
	stw 0,44(1)
	stw 11,40(1)
	lfd 0,40(1)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	fadds 31,31,0
	bl FindItem
	lwz 9,84(31)
	mr 4,3
	mr 3,31
	lfs 0,3768(9)
	fsubs 0,0,31
	stfs 0,3768(9)
	bl Drop_Item
	lwz 9,84(31)
	mr 29,3
	lis 3,.LC114@ha
	lfs 0,3768(9)
	la 3,.LC114@l(3)
	fadds 0,0,31
	stfs 0,3768(9)
	bl FindItem
	subf 3,27,3
	lwz 9,84(31)
	mullw 3,3,30
	addi 9,9,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	stw 0,924(29)
.L170:
	lis 28,.LC115@ha
	lwz 29,84(31)
	la 3,.LC115@l(28)
	bl FindItem
	subf 3,27,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L171
	bl rand
	mulli 0,3,10
	lis 11,0x4330
	lis 10,.LC123@ha
	la 3,.LC115@l(28)
	xoris 0,0,0x8000
	la 10,.LC123@l(10)
	stw 0,44(1)
	stw 11,40(1)
	lfd 0,40(1)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	fadds 31,31,0
	bl FindItem
	lwz 9,84(31)
	mr 4,3
	mr 3,31
	lfs 0,3768(9)
	fsubs 0,0,31
	stfs 0,3768(9)
	bl Drop_Item
	lwz 9,84(31)
	mr 29,3
	lis 3,.LC116@ha
	lfs 0,3768(9)
	la 3,.LC116@l(3)
	fadds 0,0,31
	stfs 0,3768(9)
	bl FindItem
	subf 3,27,3
	lwz 9,84(31)
	mullw 3,3,30
	addi 9,9,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	stw 0,924(29)
.L171:
	lis 28,.LC117@ha
	lwz 29,84(31)
	la 3,.LC117@l(28)
	bl FindItem
	subf 3,27,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L172
	bl rand
	mulli 0,3,10
	lis 11,0x4330
	lis 10,.LC123@ha
	la 3,.LC117@l(28)
	xoris 0,0,0x8000
	la 10,.LC123@l(10)
	stw 0,44(1)
	stw 11,40(1)
	lfd 0,40(1)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	fadds 31,31,0
	bl FindItem
	lwz 9,84(31)
	mr 4,3
	mr 3,31
	lfs 0,3768(9)
	fsubs 0,0,31
	stfs 0,3768(9)
	bl Drop_Item
	lwz 9,84(31)
	mr 29,3
	lis 3,.LC118@ha
	lfs 0,3768(9)
	la 3,.LC118@l(3)
	fadds 0,0,31
	stfs 0,3768(9)
	bl FindItem
	subf 3,27,3
	lwz 9,84(31)
	mullw 3,3,30
	addi 9,9,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	stw 0,924(29)
.L172:
	lis 28,.LC119@ha
	lwz 29,84(31)
	la 3,.LC119@l(28)
	bl FindItem
	subf 3,27,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L173
	bl rand
	mulli 0,3,10
	lis 11,0x4330
	lis 10,.LC123@ha
	la 3,.LC119@l(28)
	xoris 0,0,0x8000
	la 10,.LC123@l(10)
	stw 0,44(1)
	stw 11,40(1)
	lfd 0,40(1)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	fadds 31,31,0
	bl FindItem
	lwz 9,84(31)
	mr 4,3
	mr 3,31
	lfs 0,3768(9)
	fsubs 0,0,31
	stfs 0,3768(9)
	bl Drop_Item
	lwz 9,84(31)
	mr 29,3
	lis 3,.LC120@ha
	lfs 0,3768(9)
	la 3,.LC120@l(3)
	fadds 0,0,31
	stfs 0,3768(9)
	bl FindItem
	subf 3,27,3
	lwz 9,84(31)
	mullw 3,3,30
	addi 9,9,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	stw 0,924(29)
.L173:
	lis 28,.LC121@ha
	lwz 29,84(31)
	la 3,.LC121@l(28)
	bl FindItem
	subf 3,27,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L174
	bl rand
	mulli 0,3,10
	lis 11,0x4330
	lis 10,.LC123@ha
	la 3,.LC121@l(28)
	xoris 0,0,0x8000
	la 10,.LC123@l(10)
	stw 0,44(1)
	stw 11,40(1)
	lfd 0,40(1)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	fadds 31,31,0
	bl FindItem
	lwz 9,84(31)
	mr 4,3
	mr 3,31
	lfs 0,3768(9)
	fsubs 0,0,31
	stfs 0,3768(9)
	bl Drop_Item
	lwz 9,84(31)
	lfs 0,3768(9)
	fadds 0,0,31
	stfs 0,3768(9)
.L174:
	lwz 29,84(31)
	lwz 0,4000(29)
	cmpwi 0,0,1
	bc 4,2,.L175
	lis 9,.LC126@ha
	lis 10,.LC127@ha
	la 9,.LC126@l(9)
	la 10,.LC127@l(10)
	lfs 1,0(9)
	mr 3,31
	li 0,0
	lfs 2,0(10)
	addi 4,3,4
	addi 5,1,8
	stw 0,4000(29)
	li 6,400
	li 7,0
	li 8,0
	bl fire_grenade2
	b .L176
.L175:
	lis 28,.LC122@ha
	la 3,.LC122@l(28)
	bl FindItem
	subf 3,27,3
	addi 9,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	cmpwi 0,0,0
	bc 12,2,.L176
	bl rand
	mulli 0,3,10
	lis 11,0x4330
	lis 10,.LC123@ha
	la 3,.LC122@l(28)
	xoris 0,0,0x8000
	la 10,.LC123@l(10)
	stw 0,44(1)
	stw 11,40(1)
	lfd 0,40(1)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	fadds 31,31,0
	bl FindItem
	lwz 9,84(31)
	mr 4,3
	mr 3,31
	lfs 0,3768(9)
	fsubs 0,0,31
	stfs 0,3768(9)
	bl Drop_Item
	lwz 9,84(31)
	lfs 0,3768(9)
	fadds 0,0,31
	stfs 0,3768(9)
.L176:
	lwz 0,84(1)
	mtlr 0
	lmw 27,52(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe3:
	.size	 TossClientWeapon,.Lfe3-TossClientWeapon
	.section	".rodata"
	.align 3
.LC128:
	.long 0x404ca5dc
	.long 0x1a63c1f8
	.align 2
.LC129:
	.long 0x0
	.align 2
.LC130:
	.long 0x43b40000
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
	bc 12,2,.L179
	lis 9,g_edicts@ha
	xor 11,5,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,5,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L179
	lfs 11,12(5)
	lfs 13,4(5)
	lfs 10,4(31)
	lfs 0,8(5)
	b .L189
.L179:
	cmpwi 0,4,0
	bc 12,2,.L181
	lis 9,g_edicts@ha
	xor 11,4,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,4,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L181
	lfs 11,12(4)
	lfs 13,4(4)
	lfs 10,4(31)
	lfs 0,8(4)
.L189:
	lfs 9,8(31)
	lfs 12,12(31)
	fsubs 13,13,10
	fsubs 0,0,9
	fsubs 11,11,12
	stfs 13,8(1)
	stfs 0,12(1)
	stfs 11,16(1)
	b .L180
.L181:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3692(9)
	b .L178
.L180:
	lis 9,.LC129@ha
	lfs 2,8(1)
	la 9,.LC129@l(9)
	lfs 13,0(9)
	fcmpu 0,2,13
	bc 12,2,.L183
	lfs 1,12(1)
	bl atan2
	lis 9,.LC128@ha
	lwz 11,84(31)
	lfd 0,.LC128@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,3692(11)
	b .L184
.L183:
	lwz 9,84(31)
	stfs 13,3692(9)
	lfs 0,12(1)
	fcmpu 0,0,13
	bc 4,1,.L185
	lwz 9,84(31)
	lis 0,0x42b4
	b .L190
.L185:
	bc 4,0,.L184
	lwz 9,84(31)
	lis 0,0xc2b4
.L190:
	stw 0,3692(9)
.L184:
	lwz 3,84(31)
	lis 9,.LC129@ha
	la 9,.LC129@l(9)
	lfs 0,0(9)
	lfs 13,3692(3)
	fcmpu 0,13,0
	bc 4,0,.L178
	lis 11,.LC130@ha
	la 11,.LC130@l(11)
	lfs 0,0(11)
	fadds 0,13,0
	stfs 0,3692(3)
.L178:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 LookAtKiller,.Lfe4-LookAtKiller
	.section	".rodata"
	.align 2
.LC131:
	.string	"%s is a traitor, he has killed a teammate\n"
	.align 2
.LC132:
	.string	"The Terrorists couldn`t cover %s`s ass from %s`s nasty attack...\n"
	.align 2
.LC133:
	.string	"The Force couldn`t cover %s`s ass from %s`s nasty attack...\n"
	.align 2
.LC134:
	.string	"**The terrorist leader has been assassinated**\n"
	.align 2
.LC135:
	.string	"**The SWAT leader has been assassinated**\n"
	.align 2
.LC136:
	.string	"misc/udeath.wav"
	.align 2
.LC137:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC138:
	.string	"*death%i.wav"
	.align 2
.LC139:
	.long 0x0
	.align 3
.LC140:
	.long 0x40080000
	.long 0x0
	.align 2
.LC141:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl player_die
	.type	 player_die,@function
player_die:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 28,8(1)
	stw 0,36(1)
	mr 31,3
	lis 11,.LC139@ha
	lwz 9,480(31)
	la 11,.LC139@l(11)
	li 30,0
	lfs 31,0(11)
	li 0,7
	mr 29,5
	cmpwi 0,9,-99
	stw 0,260(31)
	stw 30,512(31)
	stfs 31,396(31)
	stfs 31,392(31)
	stfs 31,388(31)
	stw 30,44(31)
	stw 30,48(31)
	stw 30,52(31)
	bc 4,0,.L192
	li 0,-99
	stw 0,480(31)
.L192:
	lwz 9,84(31)
	lwz 0,4048(9)
	cmpwi 0,0,1
	bc 4,2,.L193
	stw 30,4048(9)
	mr 3,31
	bl SP_FlashLight
.L193:
	lwz 9,84(31)
	lwz 0,4052(9)
	cmpwi 0,0,1
	bc 4,2,.L194
	stw 30,4052(9)
	mr 3,31
	bl SP_LaserSight
.L194:
	lis 9,lms@ha
	lwz 11,lms@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L195
	lwz 9,84(31)
	li 0,1
	stw 0,3584(9)
.L195:
	lwz 11,84(31)
	lis 10,0xc100
	stfs 31,16(31)
	stfs 31,24(31)
	stw 30,76(31)
	stw 30,3864(11)
	lwz 9,492(31)
	lwz 0,184(31)
	cmpwi 0,9,0
	stw 10,208(31)
	ori 0,0,2
	stw 30,248(31)
	stw 0,184(31)
	bc 4,2,.L196
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	lis 9,level+4@ha
	lis 11,.LC140@ha
	lfs 0,level+4@l(9)
	la 11,.LC140@l(11)
	lfd 13,0(11)
	lwz 11,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3920(11)
	lwz 9,84(31)
	li 0,2
	mr 3,31
	mr 4,29
	stw 0,0(9)
	bl Decide_Score
	xor 9,29,31
	lwz 5,84(29)
	lis 10,gi@ha
	addic 0,9,-1
	subfe 11,0,9
	addic 9,5,-1
	subfe 0,9,5
	and. 9,0,11
	bc 12,2,.L199
	lwz 9,84(31)
	lwz 11,3532(5)
	lwz 0,3532(9)
	cmpw 0,11,0
	bc 4,2,.L199
	cmpwi 0,11,0
	bc 12,2,.L199
	lis 11,.LC139@ha
	lis 9,ctf@ha
	la 11,.LC139@l(11)
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L199
	lwz 0,gi@l(10)
	lis 4,.LC131@ha
	addi 5,5,700
	la 4,.LC131@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	lwz 0,3532(9)
	cmpwi 0,0,1
	bc 4,2,.L200
	lis 11,ctfgame@ha
	lwz 9,ctfgame@l(11)
	addi 9,9,-3
	stw 9,ctfgame@l(11)
.L200:
	lwz 9,84(31)
	lwz 0,3532(9)
	cmpwi 0,0,2
	bc 4,2,.L201
	lis 11,ctfgame@ha
	la 11,ctfgame@l(11)
	lwz 9,4(11)
	addi 9,9,-3
	stw 9,4(11)
.L201:
	lwz 9,84(29)
	li 0,0
	stw 0,3984(9)
.L199:
	lwz 5,84(31)
	lwz 0,3532(5)
	cmpwi 0,0,1
	bc 4,2,.L202
	cmpw 0,29,31
	bc 12,2,.L202
	lwz 6,84(29)
	cmpwi 0,6,0
	bc 12,2,.L202
	lwz 0,3532(6)
	cmpwi 0,0,2
	bc 4,2,.L202
	lis 9,gi@ha
	lis 4,.LC132@ha
	lwz 0,gi@l(9)
	la 4,.LC132@l(4)
	addi 5,5,700
	addi 6,6,700
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L202:
	lwz 5,84(31)
	lwz 0,3532(5)
	cmpwi 0,0,2
	bc 4,2,.L204
	cmpw 0,29,31
	bc 12,2,.L204
	lwz 6,84(29)
	cmpwi 0,6,0
	bc 12,2,.L204
	lwz 0,3532(6)
	cmpwi 0,0,1
	bc 4,2,.L204
	lis 9,gi@ha
	lis 4,.LC133@ha
	lwz 0,gi@l(9)
	la 4,.LC133@l(4)
	addi 5,5,700
	addi 6,6,700
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L204:
	lwz 9,84(31)
	lwz 0,4060(9)
	cmpwi 0,0,1
	bc 4,2,.L206
	lwz 0,3532(9)
	cmpwi 0,0,1
	bc 4,2,.L206
	lis 9,.LC139@ha
	lis 11,leader@ha
	la 9,.LC139@l(9)
	lfs 13,0(9)
	lwz 9,leader@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L206
	lis 9,gi@ha
	lis 4,.LC134@ha
	lwz 11,gi@l(9)
	la 4,.LC134@l(4)
	li 3,2
	lis 9,terror_l@ha
	li 0,0
	mtlr 11
	stw 0,terror_l@l(9)
	crxor 6,6,6
	blrl
	lis 11,ctfgame@ha
	la 11,ctfgame@l(11)
	lwz 9,4(11)
	addi 9,9,15
	stw 9,4(11)
.L206:
	lwz 9,84(31)
	lwz 0,4064(9)
	cmpwi 0,0,1
	bc 4,2,.L207
	lwz 0,3532(9)
	cmpwi 0,0,2
	bc 4,2,.L207
	lis 9,.LC139@ha
	lis 11,leader@ha
	la 9,.LC139@l(9)
	lfs 13,0(9)
	lwz 9,leader@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L207
	lis 9,gi@ha
	lis 4,.LC135@ha
	lwz 11,gi@l(9)
	la 4,.LC135@l(4)
	li 3,2
	lis 9,swat_l@ha
	li 0,0
	mtlr 11
	stw 0,swat_l@l(9)
	crxor 6,6,6
	blrl
	lis 11,ctfgame@ha
	lwz 9,ctfgame@l(11)
	addi 9,9,15
	stw 9,ctfgame@l(11)
.L207:
	mr 3,31
	li 30,0
	bl TossClientWeapon
	mr 3,31
	bl CTFDeadDropFlag
	lis 9,game@ha
	la 10,game@l(9)
	lwz 0,1556(10)
	cmpw 0,30,0
	bc 4,0,.L196
	lis 9,itemlist@ha
	lis 11,coop@ha
	la 9,itemlist@l(9)
	mr 5,10
	lwz 7,coop@l(11)
	addi 8,9,56
	li 6,0
	lis 9,.LC139@ha
	li 10,0
	la 9,.LC139@l(9)
	lfs 13,0(9)
.L211:
	lfs 0,20(7)
	fcmpu 0,0,13
	bc 12,2,.L212
	lwz 0,0(8)
	andi. 11,0,16
	bc 12,2,.L212
	lwz 9,84(31)
	addi 11,9,740
	lwzx 0,11,10
	addi 9,9,2408
	stwx 0,9,10
.L212:
	lwz 9,84(31)
	addi 30,30,1
	addi 8,8,76
	addi 9,9,740
	stwx 6,9,10
	lwz 0,1556(5)
	addi 10,10,4
	cmpw 0,30,0
	bc 12,0,.L211
.L196:
	lwz 0,480(31)
	cmpwi 0,0,-700
	bc 4,0,.L214
	lis 29,gi@ha
	lis 3,.LC136@ha
	la 29,gi@l(29)
	la 3,.LC136@l(3)
	lwz 9,36(29)
	lis 28,.LC137@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC141@ha
	lwz 0,16(29)
	lis 11,.LC141@ha
	la 9,.LC141@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC141@l(11)
	li 4,4
	mtlr 0
	lis 9,.LC139@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC139@l(9)
	lfs 3,0(9)
	blrl
.L218:
	mr 3,31
	la 4,.LC137@l(28)
	li 5,0
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L218
	mr 3,31
	li 4,0
	bl ThrowClientHead
	lwz 10,84(31)
	li 0,5
	li 11,0
	stw 0,3824(10)
	lwz 9,84(31)
	stw 11,3820(9)
	stw 11,512(31)
	b .L220
.L214:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L220
	lwz 9,84(31)
	li 0,5
	stw 0,3824(9)
	lwz 9,84(31)
	lbz 0,16(9)
	andi. 11,0,1
	bc 12,2,.L222
	li 0,172
	li 11,177
	stw 0,56(31)
	li 10,1
	stw 11,3820(9)
	lwz 9,84(31)
	stw 10,3964(9)
.L222:
	lwz 9,84(31)
	lwz 0,3960(9)
	mr 8,9
	cmpwi 0,0,1
	bc 4,2,.L223
	lbz 0,16(8)
	andi. 9,0,1
	bc 4,2,.L223
	li 0,189
	li 11,197
	stw 0,56(31)
	li 10,4
	b .L229
.L223:
	lwz 0,3960(8)
	cmpwi 0,0,2
	bc 4,2,.L225
	lbz 0,16(8)
	andi. 11,0,1
	bc 12,2,.L230
.L225:
	lwz 0,3960(8)
	cmpwi 0,0,3
	bc 4,2,.L227
	lbz 0,16(8)
	andi. 9,0,1
	bc 4,2,.L227
	li 0,177
	li 11,183
	stw 0,56(31)
	li 10,2
	b .L229
.L227:
	lwz 8,84(31)
.L230:
	li 0,183
	li 11,189
	stw 0,56(31)
	li 10,3
.L229:
	stw 11,3820(8)
	lwz 9,84(31)
	stw 10,3964(9)
	lis 29,gi@ha
	la 29,gi@l(29)
	bl rand
	mr 4,3
	srawi 0,4,31
	lis 3,.LC138@ha
	srwi 0,0,30
	la 3,.LC138@l(3)
	add 0,4,0
	rlwinm 0,0,0,0,29
	subf 4,0,4
	addi 4,4,1
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC141@ha
	lwz 0,16(29)
	lis 11,.LC141@ha
	la 9,.LC141@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC141@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC139@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC139@l(9)
	lfs 3,0(9)
	blrl
.L220:
	li 0,2
	lis 9,gi+72@ha
	stw 0,492(31)
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 player_die,.Lfe5-player_die
	.section	".rodata"
	.align 2
.LC142:
	.string	"1911"
	.align 2
.LC143:
	.string	"Bush Knife"
	.align 2
.LC144:
	.string	"1911clip"
	.align 2
.LC145:
	.string	"1911rounds"
	.align 2
.LC146:
	.string	"weight"
	.align 2
.LC147:
	.long 0x0
	.section	".text"
	.align 2
	.globl InitClientPersistant
	.type	 InitClientPersistant,@function
InitClientPersistant:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 31,3
	li 4,0
	li 5,1668
	addi 3,31,188
	crxor 6,6,6
	bl memset
	lis 30,0x286b
	addi 29,31,740
	lis 3,.LC142@ha
	ori 30,30,51739
	la 3,.LC142@l(3)
	li 27,1
	bl FindItem
	li 26,8
	lis 9,itemlist@ha
	mr 11,3
	la 28,itemlist@l(9)
	lis 3,.LC143@ha
	subf 0,28,11
	la 3,.LC143@l(3)
	mullw 0,0,30
	srawi 0,0,2
	slwi 9,0,2
	stw 0,736(31)
	stwx 27,29,9
	stw 11,1828(31)
	stw 11,1824(31)
	bl FindItem
	subf 0,28,3
	mullw 0,0,30
	lis 3,.LC144@ha
	la 3,.LC144@l(3)
	rlwinm 0,0,0,0,29
	stwx 27,29,0
	bl FindItem
	subf 0,28,3
	li 9,2
	mullw 0,0,30
	lis 3,.LC145@ha
	la 3,.LC145@l(3)
	rlwinm 0,0,0,0,29
	stwx 9,29,0
	bl FindItem
	subf 3,28,3
	lis 9,deathmatch@ha
	mullw 3,3,30
	lwz 11,deathmatch@l(9)
	lis 9,.LC147@ha
	rlwinm 3,3,0,0,29
	la 9,.LC147@l(9)
	stwx 26,29,3
	lfs 13,0(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L232
	lis 3,.LC146@ha
	la 3,.LC146@l(3)
	bl FindItem
	subf 3,28,3
	li 0,20
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	stwx 0,29,3
.L232:
	li 9,1000
	li 0,100
	stw 27,720(31)
	stw 9,1768(31)
	li 5,200
	li 6,30
	li 8,10
	li 7,9
	stw 5,1780(31)
	li 11,40
	li 9,17
	stw 26,1804(31)
	li 10,5
	stw 6,1808(31)
	stw 8,1812(31)
	stw 7,1816(31)
	stw 11,1800(31)
	stw 9,1792(31)
	stw 0,1788(31)
	stw 10,1820(31)
	stw 0,724(31)
	stw 0,728(31)
	stw 5,1764(31)
	stw 0,1772(31)
	stw 0,1776(31)
	stw 0,1784(31)
	stw 0,1796(31)
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 InitClientPersistant,.Lfe6-InitClientPersistant
	.section	".rodata"
	.align 2
.LC150:
	.string	"info_player_deathmatch"
	.align 2
.LC149:
	.long 0x47c34f80
	.align 2
.LC151:
	.long 0x4b18967f
	.align 2
.LC152:
	.long 0x3f800000
	.align 3
.LC153:
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
	lis 9,.LC149@ha
	li 28,0
	lfs 29,.LC149@l(9)
	li 30,0
	li 23,0
	li 24,0
	fmr 28,29
	lis 22,.LC150@ha
	b .L255
.L257:
	lis 10,.LC152@ha
	lis 9,maxclients@ha
	la 10,.LC152@l(10)
	lis 11,.LC151@ha
	lfs 13,0(10)
	addi 28,28,1
	li 29,1
	lwz 10,maxclients@l(9)
	lis 25,maxclients@ha
	lfs 31,.LC151@l(11)
	lfs 0,20(10)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L265
	lis 11,.LC153@ha
	lis 26,g_edicts@ha
	la 11,.LC153@l(11)
	lis 27,0x4330
	lfd 30,0(11)
	li 31,928
.L260:
	lwz 0,g_edicts@l(26)
	add 11,0,31
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L262
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L262
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
	bc 4,0,.L262
	fmr 31,1
.L262:
	addi 29,29,1
	lwz 11,maxclients@l(25)
	xoris 0,29,0x8000
	addi 31,31,928
	stw 0,36(1)
	stw 27,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L260
.L265:
	fcmpu 0,31,28
	bc 4,0,.L267
	fmr 28,31
	mr 24,30
	b .L255
.L267:
	fcmpu 0,31,29
	bc 4,0,.L255
	fmr 29,31
	mr 23,30
.L255:
	lis 5,.LC150@ha
	mr 3,30
	la 5,.LC150@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L257
	cmpwi 0,28,0
	bc 4,2,.L271
	li 3,0
	b .L279
.L271:
	cmpwi 0,28,2
	bc 12,1,.L272
	li 23,0
	li 24,0
	b .L273
.L272:
	addi 28,28,-2
.L273:
	bl rand
	li 30,0
	divw 0,3,28
	mullw 0,0,28
	subf 31,0,3
.L278:
	mr 3,30
	li 4,280
	la 5,.LC150@l(22)
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
	bc 4,2,.L278
.L279:
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
	.size	 SelectRandomDeathmatchSpawnPoint,.Lfe7-SelectRandomDeathmatchSpawnPoint
	.section	".rodata"
	.align 2
.LC154:
	.long 0x4b18967f
	.align 2
.LC155:
	.long 0x0
	.align 2
.LC156:
	.long 0x3f800000
	.align 3
.LC157:
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
	lis 9,.LC155@ha
	li 31,0
	la 9,.LC155@l(9)
	li 25,0
	lfs 29,0(9)
	b .L281
.L283:
	lis 9,maxclients@ha
	lis 11,.LC156@ha
	lwz 10,maxclients@l(9)
	la 11,.LC156@l(11)
	li 29,1
	lfs 13,0(11)
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC154@ha
	lfs 31,.LC154@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L291
	lis 9,.LC157@ha
	lis 27,g_edicts@ha
	la 9,.LC157@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,928
.L286:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L288
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L288
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
	bc 4,0,.L288
	fmr 31,1
.L288:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,928
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L286
.L291:
	fcmpu 0,31,29
	bc 4,1,.L281
	fmr 29,31
	mr 25,31
.L281:
	lis 30,.LC150@ha
	mr 3,31
	li 4,280
	la 5,.LC150@l(30)
	bl G_Find
	mr. 31,3
	bc 4,2,.L283
	cmpwi 0,25,0
	mr 3,25
	bc 4,2,.L296
	la 5,.LC150@l(30)
	li 3,0
	li 4,280
	bl G_Find
.L296:
	lwz 0,100(1)
	mtlr 0
	lmw 25,44(1)
	lfd 29,72(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe8:
	.size	 SelectFarthestDeathmatchSpawnPoint,.Lfe8-SelectFarthestDeathmatchSpawnPoint
	.section	".rodata"
	.align 2
.LC158:
	.string	"Couldn't find spawn point %s\n"
	.align 2
.LC159:
	.long 0x0
	.align 2
.LC160:
	.long 0x41100000
	.section	".text"
	.align 2
	.globl SelectSpawnPoint
	.type	 SelectSpawnPoint,@function
SelectSpawnPoint:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 11,.LC159@ha
	lis 9,deathmatch@ha
	la 11,.LC159@l(11)
	mr 26,4
	lfs 13,0(11)
	mr 25,5
	li 30,0
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L311
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L312
	bl SelectCTFSpawnPoint
	mr 30,3
	b .L314
.L312:
	bl SelectRandomDeathmatchSpawnPoint
	mr 30,3
	b .L314
.L338:
	li 30,0
	b .L314
.L311:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L314
	lis 11,game+1028@ha
	lwz 0,84(3)
	lis 9,0xfefe
	lwz 10,game+1028@l(11)
	ori 9,9,65279
	li 29,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,4
	bc 12,2,.L314
	lis 27,.LC2@ha
	lis 28,.LC22@ha
	lis 30,game+1032@ha
.L320:
	mr 3,29
	li 4,280
	la 5,.LC2@l(27)
	bl G_Find
	mr. 29,3
	bc 12,2,.L338
	lwz 4,300(29)
	la 9,.LC22@l(28)
	la 3,game+1032@l(30)
	srawi 11,4,31
	xor 0,11,4
	subf 0,0,11
	srawi 0,0,31
	andc 9,9,0
	and 4,4,0
	or 4,4,9
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L320
	addic. 31,31,-1
	bc 4,2,.L320
	mr 30,29
.L314:
	cmpwi 0,30,0
	bc 4,2,.L326
	lis 29,.LC0@ha
	lis 31,game@ha
.L333:
	mr 3,30
	li 4,280
	la 5,.LC0@l(29)
	bl G_Find
	mr. 30,3
	bc 12,2,.L339
	la 3,game@l(31)
	lbz 0,1032(3)
	cmpwi 0,0,0
	bc 4,2,.L337
	lwz 0,300(30)
	cmpwi 0,0,0
	bc 12,2,.L328
	b .L333
.L337:
	lwz 4,300(30)
	cmpwi 0,4,0
	bc 12,2,.L333
	addi 3,3,1032
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L333
.L328:
	cmpwi 0,30,0
	bc 4,2,.L326
.L339:
	lis 9,game@ha
	la 31,game@l(9)
	lbz 0,1032(31)
	cmpwi 0,0,0
	bc 4,2,.L335
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,280
	bl G_Find
	mr 30,3
.L335:
	cmpwi 0,30,0
	bc 4,2,.L326
	lis 9,gi+28@ha
	lis 3,.LC158@ha
	lwz 0,gi+28@l(9)
	la 3,.LC158@l(3)
	addi 4,31,1032
	mtlr 0
	crxor 6,6,6
	blrl
.L326:
	lfs 0,4(30)
	lis 9,.LC160@ha
	la 9,.LC160@l(9)
	lfs 12,0(9)
	stfs 0,0(26)
	lfs 13,8(30)
	stfs 13,4(26)
	lfs 0,12(30)
	fadds 0,0,12
	stfs 0,8(26)
	lfs 13,16(30)
	stfs 13,0(25)
	lfs 0,20(30)
	stfs 0,4(25)
	lfs 13,24(30)
	stfs 13,8(25)
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 SelectSpawnPoint,.Lfe9-SelectSpawnPoint
	.section	".rodata"
	.align 2
.LC161:
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
	mulli 27,27,928
	addi 27,27,928
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
	lis 9,0x4f72
	lis 11,body_die@ha
	ori 9,9,49717
	li 10,0
	subf 0,0,29
	la 11,body_die@l(11)
	mullw 0,0,9
	mr 3,29
	srawi 0,0,5
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
	lwz 9,260(28)
	stw 11,456(29)
	stw 9,260(29)
	stw 10,512(29)
	stw 10,72(29)
	lwz 0,72(26)
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe10:
	.size	 CopyToBodyQue,.Lfe10-CopyToBodyQue
	.section	".rodata"
	.align 2
.LC162:
	.string	"players/team2/tris.md2"
	.align 2
.LC163:
	.string	"players/team1/tris.md2"
	.align 2
.LC164:
	.string	"players/messiah/tris.md2"
	.align 2
.LC165:
	.string	"players/crakhor/tris.md2"
	.align 2
.LC166:
	.string	"menu_loadgame\n"
	.align 2
.LC167:
	.long 0x0
	.align 2
.LC168:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl respawn
	.type	 respawn,@function
respawn:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 11,.LC167@ha
	lis 9,deathmatch@ha
	la 11,.LC167@l(11)
	mr 30,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L356
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L355
.L356:
	lwz 0,260(30)
	cmpwi 0,0,1
	bc 12,2,.L357
	bl G_Spawn
	lfs 0,4(30)
	mr 31,3
	stfs 0,4(31)
	lfs 13,8(30)
	stfs 13,8(31)
	lfs 0,12(30)
	stfs 0,12(31)
	lwz 9,84(30)
	lwz 0,3532(9)
	cmpwi 0,0,2
	bc 4,2,.L358
	lis 9,gi+32@ha
	lis 3,.LC162@ha
	lwz 0,gi+32@l(9)
	la 3,.LC162@l(3)
	b .L410
.L358:
	cmpwi 0,0,1
	bc 12,2,.L368
	lwz 0,3580(9)
	cmpwi 0,0,1
	bc 12,2,.L368
	cmpwi 0,0,2
	bc 4,2,.L364
	lis 9,gi+32@ha
	lis 3,.LC164@ha
	lwz 0,gi+32@l(9)
	la 3,.LC164@l(3)
	b .L410
.L364:
	cmpwi 0,0,3
	bc 4,2,.L366
	lis 9,gi+32@ha
	lis 3,.LC162@ha
	lwz 0,gi+32@l(9)
	la 3,.LC162@l(3)
	b .L410
.L366:
	cmpwi 0,0,4
	bc 4,2,.L368
	lis 9,gi+32@ha
	lis 3,.LC165@ha
	lwz 0,gi+32@l(9)
	la 3,.LC165@l(3)
	b .L410
.L368:
	lis 9,gi+32@ha
	lis 3,.LC163@ha
	lwz 0,gi+32@l(9)
	la 3,.LC163@l(3)
.L410:
	mtlr 0
	blrl
	stw 3,40(31)
	lwz 9,84(30)
	lwz 0,4064(9)
	cmpwi 0,0,1
	bc 4,2,.L370
	lis 9,gi+32@ha
	lis 3,.LC165@ha
	lwz 0,gi+32@l(9)
	la 3,.LC165@l(3)
	b .L411
.L370:
	lwz 0,4060(9)
	cmpwi 0,0,1
	bc 4,2,.L371
	lis 9,gi+32@ha
	lis 3,.LC164@ha
	lwz 0,gi+32@l(9)
	la 3,.LC164@l(3)
.L411:
	mtlr 0
	blrl
	stw 3,40(31)
.L371:
	lwz 9,84(30)
	lwz 0,3964(9)
	cmpwi 0,0,1
	bc 4,2,.L373
	li 0,177
	b .L412
.L373:
	cmpwi 0,0,2
	bc 4,2,.L375
	li 0,183
	b .L412
.L375:
	cmpwi 0,0,3
	li 0,197
	bc 4,2,.L377
	li 0,189
.L377:
.L412:
	stw 0,56(31)
	lfs 0,20(30)
	li 0,0
	ori 0,0,32768
	stw 0,68(31)
	stfs 0,20(31)
	lwz 9,84(30)
	lwz 0,3968(9)
	cmpwi 0,0,0
	bc 4,2,.L379
	lwz 0,3972(9)
	cmpwi 0,0,0
	bc 4,2,.L379
	lwz 0,3976(9)
	cmpwi 0,0,0
	bc 4,2,.L379
	lwz 0,3980(9)
	cmpwi 0,0,0
	bc 12,2,.L413
.L379:
	lwz 9,84(30)
	mr 11,9
	lwz 9,3968(9)
	cmpwi 0,9,1
	bc 4,2,.L395
	lwz 0,3972(11)
	cmpwi 0,0,0
	bc 4,2,.L381
	lwz 0,3976(11)
	cmpwi 0,0,0
	bc 4,2,.L381
	lwz 0,3980(11)
	cmpwi 0,0,0
	bc 4,2,.L381
	stw 9,60(31)
	b .L380
.L381:
	lwz 0,3968(11)
	cmpwi 0,0,1
	bc 4,2,.L395
	lwz 0,3972(11)
	cmpwi 0,0,1
	bc 4,2,.L383
	lwz 0,3976(11)
	cmpwi 0,0,0
	bc 4,2,.L383
	lwz 0,3980(11)
	cmpwi 0,0,0
	li 0,2
	bc 12,2,.L413
.L383:
	lwz 0,3968(11)
	cmpwi 0,0,1
	bc 4,2,.L395
	lwz 0,3972(11)
	cmpwi 0,0,0
	bc 4,2,.L385
	lwz 0,3976(11)
	cmpwi 0,0,1
	bc 4,2,.L385
	lwz 0,3980(11)
	cmpwi 0,0,0
	li 0,3
	bc 12,2,.L413
.L385:
	lwz 0,3968(11)
	cmpwi 0,0,1
	bc 4,2,.L395
	lwz 0,3972(11)
	cmpwi 0,0,0
	bc 4,2,.L387
	lwz 0,3976(11)
	cmpwi 0,0,0
	bc 4,2,.L387
	lwz 0,3980(11)
	cmpwi 0,0,1
	li 0,4
	bc 12,2,.L413
.L387:
	lwz 0,3968(11)
	cmpwi 0,0,1
	bc 4,2,.L395
	lwz 0,3972(11)
	cmpwi 0,0,1
	bc 4,2,.L389
	lwz 0,3976(11)
	cmpwi 0,0,1
	bc 4,2,.L389
	lwz 0,3980(11)
	cmpwi 0,0,0
	li 0,5
	bc 12,2,.L413
.L389:
	lwz 0,3968(11)
	cmpwi 0,0,1
	bc 4,2,.L395
	lwz 0,3972(11)
	cmpwi 0,0,0
	bc 4,2,.L391
	lwz 0,3976(11)
	cmpwi 0,0,1
	bc 4,2,.L391
	lwz 0,3980(11)
	cmpwi 0,0,1
	li 0,6
	bc 12,2,.L413
.L391:
	lwz 0,3968(11)
	cmpwi 0,0,1
	bc 4,2,.L395
	lwz 0,3972(11)
	cmpwi 0,0,1
	bc 4,2,.L393
	lwz 0,3976(11)
	cmpwi 0,0,0
	bc 4,2,.L393
	lwz 0,3980(11)
	cmpwi 0,0,1
	li 0,7
	bc 12,2,.L413
.L393:
	lwz 0,3968(11)
	cmpwi 0,0,1
	bc 4,2,.L395
	lwz 0,3972(11)
	cmpwi 0,0,1
	bc 4,2,.L395
	lwz 0,3976(11)
	cmpwi 0,0,1
	bc 4,2,.L395
	lwz 0,3980(11)
	cmpwi 0,0,1
	li 0,8
	bc 12,2,.L413
.L395:
	lwz 0,3968(11)
	cmpwi 0,0,0
	bc 4,2,.L380
	lwz 0,3972(11)
	cmpwi 0,0,1
	bc 4,2,.L397
	lwz 0,3976(11)
	cmpwi 0,0,0
	bc 4,2,.L397
	lwz 0,3980(11)
	cmpwi 0,0,0
	li 0,9
	bc 12,2,.L413
.L397:
	lwz 0,3968(11)
	cmpwi 0,0,0
	bc 4,2,.L380
	lwz 0,3972(11)
	cmpwi 0,0,1
	bc 4,2,.L399
	lwz 0,3976(11)
	cmpwi 0,0,1
	bc 4,2,.L399
	lwz 0,3980(11)
	cmpwi 0,0,0
	li 0,10
	bc 12,2,.L413
.L399:
	lwz 0,3968(11)
	cmpwi 0,0,0
	bc 4,2,.L380
	lwz 0,3972(11)
	cmpwi 0,0,1
	bc 4,2,.L401
	lwz 0,3976(11)
	cmpwi 0,0,0
	bc 4,2,.L401
	lwz 0,3980(11)
	cmpwi 0,0,1
	li 0,11
	bc 12,2,.L413
.L401:
	lwz 0,3968(11)
	cmpwi 0,0,0
	bc 4,2,.L380
	lwz 0,3972(11)
	cmpwi 0,0,1
	bc 4,2,.L403
	lwz 0,3976(11)
	cmpwi 0,0,1
	bc 4,2,.L403
	lwz 0,3980(11)
	cmpwi 0,0,1
	li 0,12
	bc 12,2,.L413
.L403:
	lwz 0,3968(11)
	cmpwi 0,0,0
	bc 4,2,.L380
	lwz 0,3972(11)
	cmpwi 0,0,0
	bc 4,2,.L405
	lwz 0,3976(11)
	cmpwi 0,0,1
	bc 4,2,.L405
	lwz 0,3980(11)
	cmpwi 0,0,0
	li 0,13
	bc 12,2,.L413
.L405:
	lwz 0,3968(11)
	cmpwi 0,0,0
	bc 4,2,.L380
	lwz 0,3972(11)
	cmpwi 0,0,0
	bc 4,2,.L407
	lwz 0,3976(11)
	cmpwi 0,0,1
	bc 4,2,.L407
	lwz 0,3980(11)
	cmpwi 0,0,1
	li 0,14
	bc 12,2,.L413
.L407:
	lwz 0,3968(11)
	cmpwi 0,0,0
	bc 4,2,.L380
	lwz 0,3972(11)
	cmpwi 0,0,0
	bc 4,2,.L380
	lwz 0,3976(11)
	cmpwi 0,0,0
	bc 4,2,.L380
	lwz 0,3980(11)
	cmpwi 0,0,1
	bc 4,2,.L380
	li 0,15
.L413:
	stw 0,60(31)
.L380:
	lis 9,.LC168@ha
	lis 11,level+4@ha
	la 9,.LC168@l(9)
	lfs 0,level+4@l(11)
	mr 3,31
	lfs 13,0(9)
	lis 11,gi+72@ha
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	fadds 0,0,13
	stw 9,436(31)
	stfs 0,428(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
.L357:
	lwz 0,184(30)
	mr 3,30
	rlwinm 0,0,0,0,30
	stw 0,184(30)
	bl PutClientInServer
	lwz 7,84(30)
	li 0,6
	li 11,32
	stw 0,80(30)
	li 10,14
	lis 8,level+4@ha
	stb 11,16(7)
	lwz 9,84(30)
	stb 10,17(9)
	lfs 0,level+4@l(8)
	lwz 11,84(30)
	stfs 0,3920(11)
	b .L354
.L355:
	lis 9,gi+168@ha
	lis 3,.LC166@ha
	lwz 0,gi+168@l(9)
	la 3,.LC166@l(3)
	mtlr 0
	blrl
.L354:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 respawn,.Lfe11-respawn
	.section	".rodata"
	.align 2
.LC169:
	.string	"%s, the terrorist leader, left the match.\n"
	.align 2
.LC170:
	.string	"%s, the SWAT leader, left the match.\n"
	.align 2
.LC171:
	.string	"spectator"
	.align 2
.LC172:
	.string	"none"
	.align 2
.LC173:
	.string	"Spectator password incorrect.\n"
	.align 2
.LC174:
	.string	"spectator 0\n"
	.align 2
.LC175:
	.string	"Server spectator limit is full."
	.align 2
.LC176:
	.string	"password"
	.align 2
.LC177:
	.string	"Password incorrect.\n"
	.align 2
.LC178:
	.string	"spectator 1\n"
	.align 2
.LC179:
	.string	"%s has moved to the sidelines\n"
	.align 2
.LC180:
	.string	"%s joined the game\n"
	.align 2
.LC181:
	.long 0x3f800000
	.align 3
.LC182:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl spectator_respawn
	.type	 spectator_respawn,@function
spectator_respawn:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,4060(9)
	cmpwi 0,0,1
	bc 4,2,.L415
	li 0,0
	lis 4,.LC169@ha
	stw 0,4060(9)
	la 4,.LC169@l(4)
	li 3,2
	lis 9,gi@ha
	lwz 5,84(31)
	lis 11,terror_l@ha
	lwz 9,gi@l(9)
	addi 5,5,700
	stw 0,terror_l@l(11)
	mtlr 9
	crxor 6,6,6
	blrl
.L415:
	lwz 9,84(31)
	lwz 0,4064(9)
	cmpwi 0,0,1
	bc 4,2,.L416
	li 0,0
	lis 11,gi@ha
	stw 0,4064(9)
	lis 4,.LC170@ha
	li 3,2
	lwz 5,84(31)
	la 4,.LC170@l(4)
	lis 9,swat_l@ha
	lwz 11,gi@l(11)
	addi 5,5,700
	stw 0,swat_l@l(9)
	mtlr 11
	crxor 6,6,6
	blrl
.L416:
	lwz 3,84(31)
	lwz 0,1848(3)
	cmpwi 0,0,0
	bc 12,2,.L417
	lis 4,.LC171@ha
	addi 3,3,188
	la 4,.LC171@l(4)
	lis 30,spectator_password@ha
	bl Info_ValueForKey
	lwz 9,spectator_password@l(30)
	mr 29,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L418
	lis 4,.LC172@ha
	la 4,.LC172@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L418
	lwz 9,spectator_password@l(30)
	mr 4,29
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L418
	lis 29,gi@ha
	lis 5,.LC173@ha
	la 29,gi@l(29)
	li 4,2
	lwz 9,8(29)
	la 5,.LC173@l(5)
	mr 3,31
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,0
	li 3,11
	stw 0,1848(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC174@ha
	la 3,.LC174@l(3)
	b .L431
.L418:
	lis 9,maxclients@ha
	lis 10,.LC181@ha
	lwz 11,maxclients@l(9)
	la 10,.LC181@l(10)
	li 7,1
	lfs 0,0(10)
	li 8,0
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L420
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC182@ha
	la 9,.LC182@l(9)
	addi 10,11,928
	lfd 13,0(9)
.L422:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L421
	lwz 11,84(10)
	addi 9,8,1
	lwz 0,1848(11)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L421:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,928
	stw 0,28(1)
	stw 6,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L422
.L420:
	xoris 0,8,0x8000
	lis 11,0x4330
	stw 0,28(1)
	lis 10,.LC182@ha
	la 10,.LC182@l(10)
	stw 11,24(1)
	lfd 12,0(10)
	lfd 0,24(1)
	lis 10,maxspectators@ha
	lwz 11,maxspectators@l(10)
	fsub 0,0,12
	lfs 13,20(11)
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L426
	lis 29,gi@ha
	lis 5,.LC175@ha
	la 29,gi@l(29)
	li 4,2
	lwz 9,8(29)
	la 5,.LC175@l(5)
	mr 3,31
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,0
	li 3,11
	stw 0,1848(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC174@ha
	la 3,.LC174@l(3)
	b .L431
.L417:
	lis 4,.LC176@ha
	addi 3,3,188
	la 4,.LC176@l(4)
	lis 30,password@ha
	bl Info_ValueForKey
	lwz 9,password@l(30)
	mr 29,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L426
	lis 4,.LC172@ha
	la 4,.LC172@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L426
	lwz 9,password@l(30)
	mr 4,29
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L426
	lis 29,gi@ha
	lis 5,.LC177@ha
	la 29,gi@l(29)
	li 4,2
	lwz 9,8(29)
	la 5,.LC177@l(5)
	mr 3,31
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,1
	li 3,11
	stw 0,1848(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC178@ha
	la 3,.LC178@l(3)
.L431:
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,31
	li 4,1
	mtlr 0
	blrl
	b .L414
.L426:
	lwz 11,84(31)
	li 9,0
	mr 3,31
	stw 9,3528(11)
	stw 9,1836(11)
	lwz 0,184(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	bl PutClientInServer
	lwz 9,84(31)
	lwz 0,1848(9)
	cmpwi 0,0,0
	bc 4,2,.L428
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x4f72
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,49717
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,5
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
.L428:
	lis 9,level+4@ha
	lwz 11,84(31)
	lfs 0,level+4@l(9)
	stfs 0,3920(11)
	lwz 3,84(31)
	lwz 0,1848(3)
	cmpwi 0,0,0
	bc 12,2,.L429
	lis 9,gi@ha
	lis 4,.LC179@ha
	lwz 0,gi@l(9)
	addi 5,3,700
	la 4,.LC179@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L414
.L429:
	lis 9,gi@ha
	lis 4,.LC180@ha
	lwz 0,gi@l(9)
	addi 5,3,700
	la 4,.LC180@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L414:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe12:
	.size	 spectator_respawn,.Lfe12-spectator_respawn
	.section	".rodata"
	.align 2
.LC183:
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.align 2
.LC184:
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.align 2
.LC185:
	.string	"player"
	.align 2
.LC186:
	.string	"players/male/tris.md2"
	.align 2
.LC187:
	.string	"**SWAT, kill the terrorist leader, %s!**\n"
	.align 2
.LC188:
	.string	"**Terrorists, kill the SWAT leader, %s!**\n"
	.align 2
.LC189:
	.string	"You are alone\n"
	.align 2
.LC190:
	.long 0x0
	.align 2
.LC191:
	.long 0x41400000
	.align 2
.LC192:
	.long 0x41000000
	.align 2
.LC193:
	.long 0x47800000
	.align 2
.LC194:
	.long 0x43b40000
	.align 2
.LC195:
	.long 0x3f800000
	.align 3
.LC196:
	.long 0x43300000
	.long 0x0
	.section	".text"
	.align 2
	.globl PutClientInServer
	.type	 PutClientInServer,@function
PutClientInServer:
	stwu 1,-4576(1)
	mflr 0
	stfd 31,4568(1)
	stmw 22,4528(1)
	stw 0,4580(1)
	lis 9,.LC183@ha
	lis 8,.LC184@ha
	lwz 0,.LC183@l(9)
	la 29,.LC184@l(8)
	addi 10,1,8
	la 9,.LC183@l(9)
	lwz 11,.LC184@l(8)
	addi 7,1,24
	lwz 28,8(9)
	mr 31,3
	addi 5,1,56
	lwz 6,4(9)
	mr 22,5
	stw 0,8(1)
	addi 4,1,40
	stw 28,8(10)
	stw 6,4(10)
	lwz 0,8(29)
	lwz 9,4(29)
	stw 11,24(1)
	stw 0,8(7)
	stw 9,4(7)
	bl SelectSpawnPoint
	lwz 30,84(31)
	cmpwi 0,30,0
	bc 12,2,.L432
	lis 9,deathmatch@ha
	lis 11,g_edicts@ha
	lwz 10,deathmatch@l(9)
	lis 0,0x4f72
	lis 9,.LC190@ha
	ori 0,0,49717
	la 9,.LC190@l(9)
	lfs 0,20(10)
	lfs 13,0(9)
	lwz 9,g_edicts@l(11)
	fcmpu 7,0,13
	subf 9,9,31
	mullw 9,9,0
	srawi 9,9,5
	addi 24,9,-1
	bc 12,30,.L434
	addi 28,1,1752
	addi 27,30,1856
	addi 26,1,3496
	mr 4,27
	li 5,1732
	mr 3,28
	crxor 6,6,6
	bl memcpy
	addi 29,30,188
	mr 25,27
	mr 4,29
	li 5,512
	mr 3,26
	mr 23,28
	crxor 6,6,6
	bl memcpy
	mr 27,29
	mr 3,30
	bl InitClientPersistant
	mr 4,26
	mr 3,31
	bl ClientUserinfoChanged
	b .L435
.L434:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L437
	bc 4,30,.L436
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L436
.L437:
	addi 28,1,1752
	addi 27,30,1856
	mr 4,27
	li 5,1732
	mr 3,28
	addi 29,30,188
	crxor 6,6,6
	bl memcpy
	mr 25,27
	mr 23,28
	addi 26,1,4008
	mr 4,29
	li 5,512
	mr 3,26
	crxor 6,6,6
	bl memcpy
	mr 27,29
	lwz 9,1840(30)
	mr 4,28
	li 5,1668
	mr 3,29
	stw 9,3404(1)
	lwz 0,1844(30)
	stw 0,3408(1)
	crxor 6,6,6
	bl memcpy
	mr 4,26
	mr 3,31
	bl ClientUserinfoChanged
	lwz 9,3424(1)
	lwz 0,1836(30)
	cmpw 0,9,0
	bc 4,1,.L435
	stw 9,1836(30)
	b .L435
.L436:
	addi 29,1,1752
	li 4,0
	mr 3,29
	li 5,1732
	crxor 6,6,6
	bl memset
	mr 23,29
	addi 25,30,1856
	addi 27,30,188
.L435:
	addi 29,1,72
	mr 4,27
	li 5,1668
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 4,0
	li 5,4080
	mr 3,30
	crxor 6,6,6
	bl memset
	mr 3,27
	mr 4,29
	li 5,1668
	crxor 6,6,6
	bl memcpy
	lwz 0,724(30)
	cmpwi 0,0,0
	bc 12,1,.L440
	mr 3,30
	bl InitClientPersistant
.L440:
	mr 3,25
	mr 4,23
	li 5,1732
	crxor 6,6,6
	bl memcpy
	lis 9,.LC190@ha
	lwz 7,84(31)
	lis 10,coop@ha
	la 9,.LC190@l(9)
	lwz 8,coop@l(10)
	lfs 12,0(9)
	lwz 9,724(7)
	lwz 11,264(31)
	stw 9,480(31)
	lwz 0,728(7)
	stw 0,484(31)
	lwz 9,732(7)
	or 11,11,9
	stw 11,264(31)
	lfs 0,20(8)
	fcmpu 0,0,12
	bc 12,2,.L442
	lwz 0,1836(7)
	stw 0,3528(7)
.L442:
	li 29,0
	lis 9,game+1028@ha
	mulli 6,24,4080
	lwz 7,264(31)
	stw 29,552(31)
	lis 11,.LC185@ha
	li 4,2
	lwz 0,game+1028@l(9)
	la 11,.LC185@l(11)
	li 10,22
	li 9,4
	li 8,1
	stw 10,508(31)
	stw 9,260(31)
	add 0,0,6
	li 5,200
	lis 9,.LC191@ha
	stw 0,84(31)
	lis 3,level+4@ha
	stw 8,88(31)
	la 9,.LC191@l(9)
	lis 10,.LC186@ha
	stw 11,280(31)
	lis 8,player_pain@ha
	lis 6,deathmatch@ha
	stw 5,400(31)
	la 10,.LC186@l(10)
	la 8,player_pain@l(8)
	stw 4,248(31)
	rlwinm 7,7,0,21,19
	stw 4,512(31)
	stw 29,540(31)
	stw 29,492(31)
	lfs 0,level+4@l(3)
	lfs 13,0(9)
	lwz 0,184(31)
	lis 9,0x201
	lwz 11,deathmatch@l(6)
	ori 9,9,3
	fadds 0,0,13
	rlwinm 0,0,0,31,29
	stw 9,252(31)
	stw 10,268(31)
	stw 8,452(31)
	stfs 0,404(31)
	stw 7,264(31)
	stw 0,184(31)
	stw 29,612(31)
	stw 29,608(31)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L443
	lis 9,ctf@ha
	li 0,20
	stw 29,4012(30)
	lwz 11,ctf@l(9)
	lis 7,gi@ha
	stw 0,4008(30)
	stw 29,3960(30)
	stw 29,3964(30)
	stw 29,3968(30)
	stw 29,3972(30)
	stw 29,3976(30)
	stw 29,3980(30)
	stw 29,3984(30)
	stw 29,3956(30)
	stw 29,4048(30)
	stw 29,4052(30)
	stw 29,4028(30)
	stw 29,3988(30)
	stw 29,3992(30)
	stw 29,3996(30)
	stw 29,4032(30)
	stw 29,4024(30)
	stw 29,4020(30)
	stw 29,4040(30)
	stw 29,4044(30)
	stw 29,4000(30)
	stw 29,4036(30)
	stw 29,4016(30)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L444
	lis 8,terror_l@ha
	lwz 0,terror_l@l(8)
	cmpwi 0,0,0
	bc 4,2,.L444
	lwz 10,3532(30)
	cmpwi 0,10,1
	bc 4,2,.L444
	lis 9,leader@ha
	lwz 11,leader@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L444
	lwz 0,1848(30)
	cmpwi 0,0,0
	bc 4,2,.L444
	stw 10,4060(30)
	lis 4,.LC187@ha
	li 3,2
	lwz 0,gi@l(7)
	la 4,.LC187@l(4)
	addi 5,30,700
	stw 10,terror_l@l(8)
	mtlr 0
	crxor 6,6,6
	blrl
.L444:
	lis 11,.LC190@ha
	lis 9,ctf@ha
	la 11,.LC190@l(11)
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L445
	lis 10,swat_l@ha
	lwz 0,swat_l@l(10)
	cmpwi 0,0,0
	bc 4,2,.L445
	lwz 0,3532(30)
	cmpwi 0,0,2
	bc 4,2,.L445
	lis 9,leader@ha
	lwz 11,leader@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L445
	lwz 0,1848(30)
	cmpwi 0,0,0
	bc 4,2,.L445
	li 0,1
	lis 9,gi@ha
	stw 0,4064(30)
	lis 4,.LC188@ha
	li 3,2
	lwz 9,gi@l(9)
	la 4,.LC188@l(4)
	addi 5,30,700
	stw 0,swat_l@l(10)
	mtlr 9
	crxor 6,6,6
	blrl
.L445:
	mr 3,31
	bl painskin
	b .L446
.L443:
	mr 3,31
	bl painskin
	mr 3,31
	bl SP_Values
.L446:
	lfs 9,8(1)
	li 0,0
	li 5,184
	lfs 10,12(1)
	li 4,0
	lfs 0,16(1)
	lfs 13,24(1)
	lfs 12,28(1)
	lfs 11,32(1)
	lwz 3,84(31)
	stfs 9,188(31)
	stfs 10,192(31)
	stfs 0,196(31)
	stfs 13,200(31)
	stfs 12,204(31)
	stfs 11,208(31)
	stw 0,376(31)
	stw 0,384(31)
	stw 0,380(31)
	crxor 6,6,6
	bl memset
	lis 9,.LC192@ha
	lfs 0,40(1)
	lis 8,0x42b4
	la 9,.LC192@l(9)
	lbz 0,16(30)
	lis 7,gi+32@ha
	lfs 10,0(9)
	andi. 0,0,191
	lwz 6,1824(30)
	mr 11,9
	mr 10,9
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,4520(1)
	lwz 9,4524(1)
	sth 9,4(30)
	lfs 0,44(1)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,4520(1)
	lwz 11,4524(1)
	sth 11,6(30)
	lfs 0,48(1)
	stw 8,112(30)
	stb 0,16(30)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,4520(1)
	lwz 10,4524(1)
	sth 10,8(30)
	lwz 0,gi+32@l(7)
	lwz 3,32(6)
	mtlr 0
	blrl
	lis 11,.LC194@ha
	lis 9,.LC193@ha
	stw 3,88(30)
	la 11,.LC194@l(11)
	la 9,.LC193@l(9)
	lfs 13,48(1)
	lfs 10,0(11)
	lis 0,0x4f72
	li 10,255
	lis 11,g_edicts@ha
	lfs 9,0(9)
	ori 0,0,49717
	lwz 9,g_edicts@l(11)
	mr 5,22
	addi 6,30,3560
	lis 11,.LC195@ha
	lfs 11,40(1)
	addi 7,30,20
	la 11,.LC195@l(11)
	subf 9,9,31
	lfs 12,44(1)
	lfs 0,0(11)
	mullw 9,9,0
	li 8,0
	li 0,3
	li 11,0
	stw 10,44(31)
	mtctr 0
	srawi 9,9,5
	stw 11,56(31)
	fadds 13,13,0
	addi 9,9,-1
	stfs 11,28(31)
	stfs 12,32(31)
	stw 9,60(31)
	stfs 13,36(31)
	stw 11,64(31)
	stw 10,40(31)
	stfs 11,4(31)
	stfs 12,8(31)
	stfs 13,12(31)
.L461:
	lfsx 0,8,5
	lfsx 12,8,6
	addi 8,8,4
	fsubs 0,0,12
	fmuls 0,0,9
	fdivs 0,0,10
	fctiwz 13,0
	stfd 13,4520(1)
	lwz 9,4524(1)
	sth 9,0(7)
	addi 7,7,2
	bdnz .L461
	lis 9,.LC190@ha
	lfs 0,60(1)
	mr 3,31
	la 9,.LC190@l(9)
	lfs 31,0(9)
	stfs 0,20(31)
	stfs 31,24(31)
	stfs 31,16(31)
	stfs 31,28(30)
	lfs 0,20(31)
	stfs 0,32(30)
	lfs 13,24(31)
	stfs 13,36(30)
	lfs 0,16(31)
	stfs 0,3764(30)
	lfs 13,20(31)
	stfs 13,3768(30)
	lfs 0,24(31)
	stfs 0,3772(30)
	bl CTFStartClient
	mr. 8,3
	bc 4,2,.L432
	lwz 29,1848(30)
	cmpwi 0,29,0
	bc 12,2,.L453
	li 11,1
	stw 8,3924(30)
	lis 10,gi+72@ha
	stw 11,3572(30)
	mr 3,31
	lwz 0,184(31)
	lwz 9,84(31)
	ori 0,0,1
	stw 11,260(31)
	stw 0,184(31)
	stw 8,248(31)
	stw 8,88(9)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
	b .L432
.L453:
	stw 29,3572(30)
	mr 3,31
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,1824(30)
	mr 3,31
	stw 0,3660(30)
	bl ChangeWeapon
	lis 9,lms@ha
	lwz 11,lms@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L432
	lis 9,lms_round@ha
	lwz 11,84(31)
	lwz 0,lms_round@l(9)
	stw 29,4076(11)
	cmpwi 0,0,0
	bc 12,2,.L458
	lis 9,lms_players@ha
	lwz 0,lms_players@l(9)
	cmplwi 0,0,1
	bc 4,1,.L458
	lwz 9,84(31)
	lwz 0,3584(9)
	cmpwi 0,0,1
	bc 12,2,.L458
	lis 11,lms_delay@ha
	lwz 0,lms_delay@l(11)
	lis 10,0x4330
	lis 11,.LC196@ha
	stw 0,4524(1)
	la 11,.LC196@l(11)
	stw 10,4520(1)
	lfd 13,0(11)
	lfd 0,4520(1)
	lis 11,level+4@ha
	lfs 12,level+4@l(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,1,.L457
.L458:
	lwz 0,184(31)
	li 9,1
	li 11,0
	stw 9,260(31)
	ori 0,0,1
	stw 11,248(31)
	stw 0,184(31)
	bl CheckLMSRules
	lis 9,lms_players@ha
	lwz 0,lms_players@l(9)
	cmplwi 0,0,1
	bc 12,1,.L432
	lis 9,gi+12@ha
	lis 4,.LC189@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC189@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L432
.L457:
	lwz 0,184(31)
	li 9,2
	stw 9,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
.L432:
	lwz 0,4580(1)
	mtlr 0
	lmw 22,4528(1)
	lfd 31,4568(1)
	la 1,4576(1)
	blr
.Lfe13:
	.size	 PutClientInServer,.Lfe13-PutClientInServer
	.section	".rodata"
	.align 2
.LC197:
	.string	"%s entered the game\n"
	.align 2
.LC198:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientBeginDeathmatch
	.type	 ClientBeginDeathmatch,@function
ClientBeginDeathmatch:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 28,8(1)
	stw 0,36(1)
	mr 30,3
	bl G_InitEdict
	lwz 31,84(30)
	li 4,0
	li 5,1732
	addi 28,31,1856
	lwz 29,3532(31)
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	stw 29,3532(31)
	mr 3,28
	lwz 0,level@l(9)
	addi 4,31,188
	li 5,1668
	stw 0,3524(31)
	crxor 6,6,6
	bl memcpy
	lis 9,.LC198@ha
	lis 11,ctf@ha
	la 9,.LC198@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L464
	lwz 0,3532(31)
	cmpwi 0,0,0
	bc 12,1,.L464
	mr 3,31
	bl CTFAssignTeam
.L464:
	lis 11,.LC198@ha
	lis 9,lms@ha
	la 11,.LC198@l(11)
	lfs 31,0(11)
	lwz 11,lms@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L465
	lwz 9,84(30)
	li 0,0
	stw 0,4076(9)
	stw 0,492(30)
.L465:
	mr 3,30
	bl PutClientInServer
	lis 9,level+200@ha
	lfs 0,level+200@l(9)
	fcmpu 0,0,31
	bc 12,2,.L466
	mr 3,30
	bl MoveClientToIntermission
	b .L467
.L466:
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x4f72
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,49717
	mtlr 10
	subf 3,3,30
	mullw 3,3,0
	srawi 3,3,5
	blrl
	lwz 9,100(29)
	li 3,9
	mtlr 9
	blrl
	lwz 0,88(29)
	addi 3,30,4
	li 4,2
	mtlr 0
	blrl
.L467:
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC197@ha
	lwz 0,gi@l(9)
	li 3,2
	la 4,.LC197@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,30
	bl ClientEndServerFrame
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 ClientBeginDeathmatch,.Lfe14-ClientBeginDeathmatch
	.section	".rodata"
	.align 2
.LC199:
	.long 0x0
	.align 2
.LC200:
	.long 0x47800000
	.align 2
.LC201:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl ClientBegin
	.type	 ClientBegin,@function
ClientBegin:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 28,24(1)
	stw 0,52(1)
	lis 11,g_edicts@ha
	mr 30,3
	lwz 9,g_edicts@l(11)
	lis 0,0x4f72
	lis 10,deathmatch@ha
	ori 0,0,49717
	lis 11,game+1028@ha
	subf 9,9,30
	lwz 8,game+1028@l(11)
	mullw 9,9,0
	lwz 11,deathmatch@l(10)
	lis 10,.LC199@ha
	srawi 9,9,5
	la 10,.LC199@l(10)
	mulli 9,9,4080
	lfs 31,0(10)
	addi 9,9,-4080
	add 8,8,9
	stw 8,84(30)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L469
	bl ClientBeginDeathmatch
	b .L468
.L469:
	lwz 0,88(30)
	cmpwi 0,0,1
	bc 4,2,.L470
	lis 9,.LC200@ha
	lis 10,.LC201@ha
	li 11,3
	la 9,.LC200@l(9)
	la 10,.LC201@l(10)
	mtctr 11
	lfs 11,0(9)
	li 8,0
	lfs 12,0(10)
	li 7,0
.L482:
	lwz 10,84(30)
	add 0,8,8
	addi 8,8,1
	addi 9,10,28
	lfsx 0,9,7
	addi 10,10,20
	addi 7,7,4
	fmuls 0,0,11
	fdivs 0,0,12
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	sthx 11,10,0
	bdnz .L482
	b .L476
.L470:
	mr 3,30
	bl G_InitEdict
	lwz 31,84(30)
	lis 9,.LC185@ha
	li 4,0
	la 9,.LC185@l(9)
	li 5,1732
	stw 9,280(30)
	addi 28,31,1856
	lwz 29,3532(31)
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	stw 29,3532(31)
	mr 3,28
	lwz 0,level@l(9)
	addi 4,31,188
	li 5,1668
	stw 0,3524(31)
	crxor 6,6,6
	bl memcpy
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L478
	lwz 0,3532(31)
	cmpwi 0,0,0
	bc 12,1,.L478
	mr 3,31
	bl CTFAssignTeam
.L478:
	mr 3,30
	bl PutClientInServer
.L476:
	lis 10,.LC199@ha
	lis 9,level+200@ha
	la 10,.LC199@l(10)
	lfs 0,level+200@l(9)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 12,2,.L479
	mr 3,30
	bl MoveClientToIntermission
	b .L480
.L479:
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L480
	lis 28,gi@ha
	li 3,1
	la 29,gi@l(28)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x4f72
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,49717
	mtlr 10
	subf 3,3,30
	mullw 3,3,0
	srawi 3,3,5
	blrl
	lwz 9,100(29)
	li 3,9
	mtlr 9
	blrl
	lwz 0,88(29)
	li 4,2
	addi 3,30,4
	mtlr 0
	blrl
	lwz 5,84(30)
	lis 4,.LC197@ha
	li 3,2
	lwz 0,gi@l(28)
	la 4,.LC197@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L480:
	mr 3,30
	bl ClientEndServerFrame
.L468:
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe15:
	.size	 ClientBegin,.Lfe15-ClientBegin
	.section	".rodata"
	.align 2
.LC202:
	.string	"\\name\\badinfo\\skin\\male/grunt"
	.align 2
.LC203:
	.string	"name"
	.align 2
.LC204:
	.string	"0"
	.align 2
.LC205:
	.string	"skin"
	.align 2
.LC206:
	.string	"hand"
	.align 2
.LC207:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientUserinfoChanged
	.type	 ClientUserinfoChanged,@function
ClientUserinfoChanged:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 30,4
	mr 29,3
	mr 3,30
	bl Info_Validate
	cmpwi 0,3,0
	bc 4,2,.L484
	lis 11,.LC202@ha
	lwz 0,.LC202@l(11)
	la 9,.LC202@l(11)
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
.L484:
	lis 4,.LC203@ha
	mr 3,30
	la 4,.LC203@l(4)
	bl Info_ValueForKey
	lwz 9,84(29)
	mr 31,3
	li 5,15
	mr 4,31
	addi 3,9,700
	bl strncpy
	lis 4,.LC171@ha
	mr 3,30
	la 4,.LC171@l(4)
	bl Info_ValueForKey
	lis 11,.LC207@ha
	lis 9,deathmatch@ha
	la 11,.LC207@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L485
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L485
	lis 4,.LC204@ha
	la 4,.LC204@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L485
	lwz 9,84(29)
	li 0,1
	b .L488
.L485:
	lwz 9,84(29)
	li 0,0
.L488:
	stw 0,1848(9)
	lis 4,.LC205@ha
	mr 3,30
	la 4,.LC205@l(4)
	bl Info_ValueForKey
	lis 4,.LC206@ha
	mr 3,30
	la 4,.LC206@l(4)
	bl Info_ValueForKey
	mr 31,3
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L487
	mr 3,31
	bl atoi
	lwz 9,84(29)
	stw 3,716(9)
.L487:
	lwz 3,84(29)
	mr 4,30
	li 5,511
	addi 3,3,188
	bl strncpy
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 ClientUserinfoChanged,.Lfe16-ClientUserinfoChanged
	.section	".rodata"
	.align 2
.LC208:
	.string	"ip"
	.align 2
.LC209:
	.string	"rejmsg"
	.align 2
.LC210:
	.string	"Banned."
	.align 2
.LC211:
	.string	"Spectator password required or incorrect."
	.align 2
.LC212:
	.string	"Password required or incorrect."
	.align 2
.LC213:
	.string	"%s connected\n"
	.align 2
.LC214:
	.long 0x0
	.align 3
.LC215:
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
	mr 27,4
	mr 30,3
	lis 4,.LC208@ha
	mr 3,27
	la 4,.LC208@l(4)
	bl Info_ValueForKey
	bl SV_FilterPacket
	cmpwi 0,3,0
	bc 12,2,.L490
	lis 4,.LC209@ha
	lis 5,.LC210@ha
	mr 3,27
	la 4,.LC209@l(4)
	la 5,.LC210@l(5)
	b .L509
.L490:
	lis 4,.LC171@ha
	mr 3,27
	la 4,.LC171@l(4)
	bl Info_ValueForKey
	lis 9,deathmatch@ha
	lis 10,.LC214@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC214@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L491
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L491
	lis 4,.LC204@ha
	la 4,.LC204@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L491
	lis 29,spectator_password@ha
	lwz 9,spectator_password@l(29)
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L492
	lis 4,.LC172@ha
	la 4,.LC172@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L492
	lwz 9,spectator_password@l(29)
	mr 4,31
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L492
	lis 4,.LC209@ha
	lis 5,.LC211@ha
	mr 3,27
	la 4,.LC209@l(4)
	la 5,.LC211@l(5)
	b .L509
.L492:
	lis 9,maxclients@ha
	lis 10,.LC214@ha
	lwz 11,maxclients@l(9)
	la 10,.LC214@l(10)
	li 8,0
	lfs 0,0(10)
	li 7,0
	lfs 13,20(11)
	fcmpu 0,0,13
	bc 4,0,.L494
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC215@ha
	la 9,.LC215@l(9)
	addi 10,11,928
	lfd 13,0(9)
.L496:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L495
	lwz 11,84(10)
	addi 9,8,1
	lwz 0,1848(11)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L495:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,928
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L496
.L494:
	xoris 0,8,0x8000
	lis 11,0x4330
	stw 0,20(1)
	lis 10,.LC215@ha
	la 10,.LC215@l(10)
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
	bc 4,3,.L500
	lis 4,.LC209@ha
	lis 5,.LC175@ha
	mr 3,27
	la 4,.LC209@l(4)
	la 5,.LC175@l(5)
	b .L509
.L491:
	lis 4,.LC176@ha
	mr 3,27
	la 4,.LC176@l(4)
	lis 29,password@ha
	bl Info_ValueForKey
	lwz 9,password@l(29)
	mr 31,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L500
	lis 4,.LC172@ha
	la 4,.LC172@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L500
	lwz 9,password@l(29)
	mr 4,31
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L500
	lis 4,.LC209@ha
	lis 5,.LC212@ha
	mr 3,27
	la 4,.LC209@l(4)
	la 5,.LC212@l(5)
.L509:
	bl Info_SetValueForKey
	li 3,0
	b .L508
.L500:
	lis 11,g_edicts@ha
	lis 0,0x4f72
	lwz 10,88(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,49717
	lis 11,game+1028@ha
	cmpwi 0,10,0
	subf 9,9,30
	lwz 8,game+1028@l(11)
	mullw 9,9,0
	srawi 9,9,5
	mulli 9,9,4080
	addi 9,9,-4080
	add 8,8,9
	stw 8,84(30)
	bc 4,2,.L502
	li 0,-1
	li 4,0
	stw 0,3532(8)
	li 5,1732
	lwz 31,84(30)
	addi 28,31,1856
	lwz 29,3532(31)
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	stw 29,3532(31)
	mr 3,28
	lwz 0,level@l(9)
	addi 4,31,188
	li 5,1668
	stw 0,3524(31)
	crxor 6,6,6
	bl memcpy
	lis 9,.LC214@ha
	lis 11,ctf@ha
	la 9,.LC214@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L504
	lwz 0,3532(31)
	cmpwi 0,0,0
	bc 12,1,.L504
	mr 3,31
	bl CTFAssignTeam
.L504:
	lis 9,game+1560@ha
	lwz 3,84(30)
	lwz 0,game+1560@l(9)
	cmpwi 0,0,0
	bc 12,2,.L506
	lwz 0,1824(3)
	cmpwi 0,0,0
	bc 4,2,.L502
.L506:
	bl InitClientPersistant
.L502:
	mr 4,27
	mr 3,30
	bl ClientUserinfoChanged
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L507
	lis 9,gi+4@ha
	lwz 4,84(30)
	lis 3,.LC213@ha
	lwz 0,gi+4@l(9)
	la 3,.LC213@l(3)
	addi 4,4,700
	mtlr 0
	crxor 6,6,6
	blrl
.L507:
	lwz 9,84(30)
	li 0,0
	li 11,1
	stw 0,184(30)
	li 3,1
	stw 11,720(9)
.L508:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe17:
	.size	 ClientConnect,.Lfe17-ClientConnect
	.section	".rodata"
	.align 2
.LC216:
	.string	"%s disconnected\n"
	.align 2
.LC217:
	.string	"The terrorist disconnected\n"
	.align 2
.LC218:
	.string	"The SWAT leader disconnected\n"
	.align 2
.LC219:
	.string	"disconnected"
	.align 2
.LC220:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientDisconnect
	.type	 ClientDisconnect,@function
ClientDisconnect:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	lwz 5,84(31)
	cmpwi 0,5,0
	bc 12,2,.L510
	lis 9,gi@ha
	lis 4,.LC216@ha
	lwz 0,gi@l(9)
	la 4,.LC216@l(4)
	addi 5,5,700
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl TossClientWeapon
	lwz 10,84(31)
	lwz 0,4060(10)
	cmpwi 0,0,1
	bc 4,2,.L512
	lwz 0,3532(10)
	cmpwi 0,0,1
	bc 4,2,.L512
	lis 9,.LC220@ha
	lis 11,leader@ha
	la 9,.LC220@l(9)
	lfs 13,0(9)
	lwz 9,leader@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L512
	li 0,0
	lis 9,terror_l@ha
	stw 0,terror_l@l(9)
	lis 4,.LC217@ha
	li 3,2
	stw 0,4060(10)
	lis 9,gi@ha
	la 4,.LC217@l(4)
	lwz 0,gi@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L512:
	lwz 10,84(31)
	lwz 0,4064(10)
	cmpwi 0,0,1
	bc 4,2,.L513
	lwz 0,3532(10)
	cmpwi 0,0,2
	bc 4,2,.L513
	lis 9,.LC220@ha
	lis 11,leader@ha
	la 9,.LC220@l(9)
	lfs 13,0(9)
	lwz 9,leader@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L513
	li 0,0
	lis 9,swat_l@ha
	stw 0,swat_l@l(9)
	lis 11,gi@ha
	lis 4,.LC218@ha
	stw 0,4064(10)
	la 4,.LC218@l(4)
	li 3,2
	lwz 0,gi@l(11)
	mtlr 0
	crxor 6,6,6
	blrl
.L513:
	mr 3,31
	lis 27,g_edicts@ha
	bl CTFDeadDropFlag
	lis 28,0x4f72
	mr 3,31
	ori 28,28,49717
	bl CTFDeadDropTech
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 3,g_edicts@l(27)
	lwz 9,104(29)
	subf 3,3,31
	mullw 3,3,28
	mtlr 9
	srawi 3,3,5
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
	lwz 3,g_edicts@l(27)
	lis 9,.LC219@ha
	li 0,0
	la 9,.LC219@l(9)
	lwz 11,84(31)
	lis 4,.LC22@ha
	stw 9,280(31)
	subf 3,3,31
	la 4,.LC22@l(4)
	stw 0,40(31)
	mullw 3,3,28
	stw 0,248(31)
	stw 0,88(31)
	srawi 3,3,5
	stw 0,720(11)
	addi 3,3,1311
	lwz 0,24(29)
	mtlr 0
	blrl
.L510:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 ClientDisconnect,.Lfe18-ClientDisconnect
	.section	".rodata"
	.align 2
.LC221:
	.string	"sv %3i:%i %i\n"
	.align 2
.LC223:
	.string	"**The new terrorist leader is %s**\n"
	.align 2
.LC224:
	.string	"**The new SWAT leader is %s**\n"
	.align 2
.LC225:
	.string	"%s is the Last Man Standing\n"
	.align 3
.LC222:
	.long 0x3fc99999
	.long 0x9999999a
	.align 3
.LC226:
	.long 0x3f768000
	.long 0x0
	.align 2
.LC227:
	.long 0x41200000
	.align 2
.LC228:
	.long 0x0
	.align 3
.LC229:
	.long 0x43300000
	.long 0x0
	.align 3
.LC230:
	.long 0x40140000
	.long 0x0
	.align 3
.LC231:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC232:
	.long 0x41000000
	.align 3
.LC233:
	.long 0x3fc00000
	.long 0x0
	.align 2
.LC234:
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
	mr 28,3
	lis 9,level+292@ha
	stw 28,level+292@l(9)
	mr 26,4
	lwz 30,84(28)
	lwz 0,4020(30)
	cmpwi 0,0,1
	bc 4,2,.L543
	lis 9,.LC227@ha
	lfs 13,384(28)
	la 9,.LC227@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L544
	li 0,0
	stw 0,384(28)
.L544:
	lis 9,level@ha
	lis 0,0x2aaa
	lwz 11,level@l(9)
	ori 0,0,43691
	mulhw 0,11,0
	srawi 9,11,31
	subf 0,9,0
	mulli 0,0,6
	subf 11,0,11
	cmpwi 0,11,2
	bc 12,1,.L543
	lfs 13,380(28)
	lis 9,.LC222@ha
	lfs 0,376(28)
	lfd 12,.LC222@l(9)
	fmul 13,13,12
	fmul 0,0,12
	frsp 13,13
	frsp 0,0
	stfs 13,380(28)
	stfs 0,376(28)
.L543:
	lis 11,level@ha
	lis 0,0x8888
	lwz 9,level@l(11)
	ori 0,0,34953
	la 10,level@l(11)
	mulhw 0,9,0
	srawi 11,9,31
	add 0,0,9
	srawi 0,0,4
	subf 0,11,0
	mulli 0,0,30
	cmpw 0,9,0
	bc 4,2,.L546
	lis 11,.LC228@ha
	lis 9,leader@ha
	la 11,.LC228@l(11)
	lfs 13,0(11)
	lwz 11,leader@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L546
	lfs 0,200(10)
	fcmpu 0,0,13
	bc 4,2,.L546
	lis 9,terror_l@ha
	lwz 0,terror_l@l(9)
	cmpwi 0,0,0
	bc 4,2,.L547
	lwz 0,3532(30)
	addic 20,30,-1
	subfe 9,20,30
	xori 0,0,1
	subfic 10,0,0
	adde 0,10,0
	and. 11,0,9
	bc 12,2,.L547
	lwz 0,492(28)
	cmpwi 0,0,0
	bc 4,2,.L547
	lwz 0,1848(30)
	cmpwi 0,0,0
	bc 4,2,.L547
	bl rand
	li 29,0
	lis 0,0x6666
	srawi 11,3,31
	ori 0,0,26215
	mulhw 0,3,0
	srawi 0,0,3
	subf 31,11,0
	mulli 9,31,20
	subf 31,9,3
	cmpwi 0,31,0
	addi 31,31,-1
	bc 12,2,.L552
	lis 27,.LC185@ha
.L551:
	mr 3,29
	li 4,280
	la 5,.LC185@l(27)
	bl G_Find
	cmpwi 0,31,0
	mr 29,3
	addi 31,31,-1
	bc 4,2,.L551
.L552:
	cmpwi 0,29,0
	bc 4,2,.L553
	lis 5,.LC185@ha
	li 3,0
	la 5,.LC185@l(5)
	li 4,280
	bl G_Find
	mr 29,3
.L553:
	cmpwi 0,29,0
	bc 12,2,.L547
	lis 9,gi@ha
	lwz 5,84(28)
	lis 4,.LC223@ha
	lwz 0,gi@l(9)
	la 4,.LC223@l(4)
	li 3,2
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	li 0,1
	lis 9,terror_l@ha
	stw 0,4060(30)
	mr 3,28
	stw 0,terror_l@l(9)
	bl painskin
	mr 3,28
	bl ShowTorso
	mr 3,28
	bl ShowItem
.L547:
	lis 9,swat_l@ha
	lwz 0,swat_l@l(9)
	cmpwi 0,0,0
	bc 4,2,.L546
	lwz 0,3532(30)
	addic 10,30,-1
	subfe 9,10,30
	xori 0,0,2
	subfic 11,0,0
	adde 0,11,0
	and. 20,0,9
	bc 12,2,.L546
	lwz 0,492(28)
	cmpwi 0,0,0
	bc 4,2,.L546
	lwz 0,1848(30)
	cmpwi 0,0,0
	bc 4,2,.L546
	bl rand
	li 29,0
	lis 0,0x6666
	srawi 11,3,31
	ori 0,0,26215
	mulhw 0,3,0
	srawi 0,0,3
	subf 31,11,0
	mulli 9,31,20
	subf 31,9,3
	cmpwi 0,31,0
	addi 31,31,-1
	bc 12,2,.L560
	lis 27,.LC185@ha
.L559:
	mr 3,29
	li 4,280
	la 5,.LC185@l(27)
	bl G_Find
	cmpwi 0,31,0
	mr 29,3
	addi 31,31,-1
	bc 4,2,.L559
.L560:
	cmpwi 0,29,0
	bc 4,2,.L561
	lis 5,.LC185@ha
	li 3,0
	la 5,.LC185@l(5)
	li 4,280
	bl G_Find
	mr 29,3
.L561:
	cmpwi 0,29,0
	bc 12,2,.L546
	lis 9,gi@ha
	lwz 5,84(28)
	lis 4,.LC224@ha
	lwz 0,gi@l(9)
	la 4,.LC224@l(4)
	li 3,2
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	li 0,1
	lis 9,swat_l@ha
	stw 0,4064(30)
	mr 3,28
	stw 0,swat_l@l(9)
	bl painskin
	mr 3,28
	bl ShowTorso
	mr 3,28
	bl ShowItem
.L546:
	lis 9,.LC228@ha
	lis 11,lms@ha
	la 9,.LC228@l(9)
	lfs 13,0(9)
	lwz 9,lms@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L563
	lis 9,lms_round@ha
	lwz 29,lms_round@l(9)
	cmpwi 0,29,1
	bc 4,2,.L564
	lis 11,lms_delay@ha
	lwz 0,lms_delay@l(11)
	lis 10,0x4330
	lis 11,.LC229@ha
	stw 0,260(1)
	la 11,.LC229@l(11)
	stw 10,256(1)
	lfd 13,0(11)
	lfd 0,256(1)
	lis 11,level+4@ha
	lfs 12,level+4@l(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L564
	lwz 9,84(28)
	lwz 31,4072(9)
	cmpwi 0,31,0
	bc 4,2,.L564
	mr 3,28
	bl TossClientWeapon
	mr 3,28
	bl PutClientInServer
	lwz 9,84(28)
	stw 29,4072(9)
	lwz 11,84(28)
	stw 31,492(28)
	stw 31,4076(11)
.L564:
	lwz 7,84(28)
	lwz 0,4076(7)
	cmpwi 0,0,0
	bc 4,2,.L563
	lis 9,lms_alive_players@ha
	lwz 8,lms_alive_players@l(9)
	cmpwi 0,8,1
	bc 4,2,.L563
	lwz 0,260(28)
	cmpwi 0,0,1
	bc 12,2,.L563
	lwz 31,492(28)
	cmpwi 0,31,0
	bc 4,2,.L563
	lis 11,lms_delay@ha
	lwz 0,lms_delay@l(11)
	lis 10,0x4330
	lis 11,.LC229@ha
	stw 0,260(1)
	la 11,.LC229@l(11)
	stw 10,256(1)
	lfd 13,0(11)
	lfd 0,256(1)
	lis 11,level+4@ha
	lfs 12,level+4@l(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,1,.L563
	stw 8,4076(7)
	lis 9,gi@ha
	lis 4,.LC225@ha
	lwz 0,gi@l(9)
	la 4,.LC225@l(4)
	li 3,3
	lwz 5,84(28)
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	lwz 11,84(28)
	lwz 9,3528(11)
	addi 9,9,10
	stw 9,3528(11)
	lwz 9,84(28)
	lwz 0,4048(9)
	cmpwi 0,0,1
	bc 4,2,.L566
	stw 31,4048(9)
	mr 3,28
	bl SP_FlashLight
.L566:
	lwz 9,84(28)
	lwz 0,4052(9)
	cmpwi 0,0,1
	bc 4,2,.L563
	stw 31,4052(9)
	mr 3,28
	bl SP_LaserSight
.L563:
	lis 9,.LC228@ha
	lis 11,ctf@ha
	la 9,.LC228@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L568
	lwz 0,3532(30)
	cmpwi 0,0,0
	bc 4,2,.L568
	lwz 0,3624(30)
	cmpwi 0,0,0
	bc 4,2,.L568
	stw 0,3632(30)
	mr 3,28
	stw 0,3616(30)
	bl CTFOpenJoinMenu
.L568:
	lis 9,ctf@ha
	lis 10,.LC228@ha
	lwz 11,ctf@l(9)
	la 10,.LC228@l(10)
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L569
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L569
	lwz 0,3576(30)
	cmpwi 0,0,0
	bc 4,2,.L569
	lwz 0,1852(30)
	cmpwi 0,0,0
	bc 4,2,.L569
	li 0,1
	mr 3,28
	stw 0,1852(30)
	bl CTFOpenSkinMenu
.L569:
	lis 9,level@ha
	lis 10,.LC228@ha
	la 10,.LC228@l(10)
	la 31,level@l(9)
	lfs 13,0(10)
	lfs 0,200(31)
	fcmpu 0,0,13
	bc 12,2,.L570
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L571
	lis 3,.LC146@ha
	la 3,.LC146@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(28)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	lwz 10,4008(11)
	mullw 3,3,0
	addi 11,11,740
	rlwinm 3,3,0,0,29
	stwx 10,11,3
.L571:
	li 0,4
	lis 9,.LC230@ha
	stw 0,0(30)
	la 9,.LC230@l(9)
	lfs 0,200(31)
	lfd 12,0(9)
	lfs 13,4(31)
	fadd 0,0,12
	fcmpu 0,13,0
	bc 4,1,.L542
	lbz 0,1(26)
	andi. 10,0,128
	bc 12,2,.L542
	li 0,1
	stw 0,208(31)
	b .L542
.L570:
	lwz 9,84(28)
	lis 11,pm_passent@ha
	stw 28,pm_passent@l(11)
	lwz 0,3924(9)
	cmpwi 0,0,0
	bc 12,2,.L573
	lha 0,2(26)
	lis 8,0x4330
	lis 20,.LC231@ha
	lis 9,.LC226@ha
	xoris 0,0,0x8000
	la 20,.LC231@l(20)
	lfd 13,.LC226@l(9)
	stw 0,260(1)
	mr 10,11
	mr 9,11
	stw 8,256(1)
	lis 21,maxclients@ha
	lfd 12,0(20)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3560(30)
	lha 0,4(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3564(30)
	lha 0,6(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3568(30)
	b .L574
.L573:
	addi 3,1,8
	li 4,0
	mr 29,3
	li 5,240
	crxor 6,6,6
	bl memset
	lwz 0,260(28)
	cmpwi 0,0,1
	bc 12,2,.L579
	lwz 0,40(28)
	cmpwi 0,0,255
	li 0,3
	bc 4,2,.L579
	lwz 0,492(28)
	cmpwi 0,0,0
	bc 12,2,.L579
	li 0,2
.L579:
	stw 0,0(30)
	lis 9,sv_gravity@ha
	lwz 7,0(30)
	lwz 10,sv_gravity@l(9)
	li 20,3
	addi 23,1,12
	lwz 0,8(30)
	mtctr 20
	addi 25,28,4
	addi 22,1,18
	lfs 0,20(10)
	addi 24,28,376
	mr 12,23
	lwz 9,12(30)
	lis 10,.LC232@ha
	mr 4,25
	lwz 8,4(30)
	la 10,.LC232@l(10)
	mr 3,22
	lfs 10,0(10)
	mr 5,24
	addi 27,30,3588
	addi 31,1,36
	lis 21,maxclients@ha
	li 6,0
	li 10,0
	fctiwz 13,0
	stfd 13,256(1)
	lwz 11,260(1)
	sth 11,18(30)
	stw 7,8(1)
	stw 8,4(29)
	stw 0,8(29)
	stw 9,12(29)
	lwz 0,16(30)
	lwz 9,20(30)
	lwz 11,24(30)
	stw 0,16(29)
	stw 9,20(29)
	stw 11,24(29)
.L630:
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
	bdnz .L630
	mr 3,27
	addi 4,1,8
	li 5,28
	bl memcmp
	cmpwi 0,3,0
	bc 12,2,.L586
	li 0,1
	stw 0,52(1)
.L586:
	lis 9,gi@ha
	lwz 7,0(26)
	addi 3,1,8
	la 9,gi@l(9)
	lwz 6,4(26)
	lis 11,PM_trace@ha
	lwz 5,84(9)
	la 11,PM_trace@l(11)
	lis 20,.LC233@ha
	lwz 8,8(26)
	la 20,.LC233@l(20)
	lwz 0,12(26)
	mtlr 5
	stw 7,36(1)
	lwz 10,52(9)
	stw 0,12(31)
	stw 6,4(31)
	stw 8,8(31)
	stw 11,240(1)
	stw 10,244(1)
	blrl
	lis 9,.LC231@ha
	lwz 11,8(1)
	mr 31,23
	la 9,.LC231@l(9)
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
	stw 11,0(30)
	li 11,3
	stw 10,4(30)
	stw 0,8(30)
	mtctr 11
	stw 9,12(30)
	lwz 0,16(29)
	lwz 9,20(29)
	lwz 11,24(29)
	stw 0,16(30)
	stw 9,20(30)
	stw 11,24(30)
	lwz 0,8(1)
	lwz 9,4(29)
	lwz 11,8(29)
	lwz 10,12(29)
	stw 0,3588(30)
	stw 9,4(27)
	stw 11,8(27)
	stw 10,12(27)
	lwz 0,24(29)
	lwz 9,16(29)
	lwz 11,20(29)
	lfd 12,0(20)
	stw 0,24(27)
	stw 9,16(27)
	stw 11,20(27)
.L629:
	lhax 0,7,31
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
	bdnz .L629
	lfs 0,216(1)
	mr 9,11
	lis 8,0x4330
	lfs 13,220(1)
	lis 20,.LC231@ha
	lis 7,.LC226@ha
	lfs 8,204(1)
	la 20,.LC231@l(20)
	lfs 9,208(1)
	lfs 10,212(1)
	lfs 11,224(1)
	stfs 0,200(28)
	stfs 13,204(28)
	stfs 8,188(28)
	stfs 9,192(28)
	stfs 10,196(28)
	stfs 11,208(28)
	lha 0,2(26)
	lfd 12,0(20)
	xoris 0,0,0x8000
	lfd 13,.LC226@l(7)
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3560(30)
	lha 0,4(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3564(30)
	lha 0,6(26)
	xoris 0,0,0x8000
	stw 0,260(1)
	stw 8,256(1)
	lfd 0,256(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3568(30)
	lwz 0,552(28)
	cmpwi 0,0,0
	bc 12,2,.L592
	lwz 0,228(1)
	cmpwi 0,0,0
	bc 4,2,.L592
	lha 0,48(1)
	cmpwi 0,0,9
	bc 4,1,.L592
	lwz 0,236(1)
	cmpwi 0,0,0
	bc 4,2,.L592
	mr 4,25
	mr 3,28
	li 5,0
	bl PlayerNoise
.L592:
	lfs 0,200(1)
	lwz 10,228(1)
	lwz 0,236(1)
	lwz 11,232(1)
	cmpwi 0,10,0
	stw 0,612(28)
	stw 11,608(28)
	fctiwz 13,0
	stw 10,552(28)
	stfd 13,256(1)
	lwz 9,260(1)
	stw 9,508(28)
	bc 12,2,.L593
	lwz 0,92(10)
	stw 0,556(28)
.L593:
	lwz 0,492(28)
	cmpwi 0,0,0
	bc 12,2,.L594
	lfs 0,3692(30)
	lis 0,0x4220
	lis 9,0xc170
	stw 0,36(30)
	stw 9,28(30)
	stfs 0,32(30)
	b .L595
.L594:
	lfs 0,188(1)
	stfs 0,3764(30)
	lfs 13,192(1)
	stfs 13,3768(30)
	lfs 0,196(1)
	stfs 0,3772(30)
	lfs 13,188(1)
	stfs 13,28(30)
	lfs 0,192(1)
	stfs 0,32(30)
	lfs 13,196(1)
	stfs 13,36(30)
.L595:
	lwz 3,3932(30)
	cmpwi 0,3,0
	bc 12,2,.L596
	bl CTFGrapplePull
.L596:
	lis 9,gi+72@ha
	mr 3,28
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,260(28)
	cmpwi 0,0,1
	bc 12,2,.L597
	mr 3,28
	bl G_TouchTriggers
.L597:
	lwz 11,84(28)
	li 9,0
	li 31,0
	stw 9,3956(11)
	lwz 0,56(1)
	cmpw 0,31,0
	bc 4,0,.L599
	addi 29,1,60
.L601:
	li 11,0
	slwi 0,31,2
	cmpw 0,11,31
	lwzx 3,29,0
	addi 27,31,1
	bc 4,0,.L603
	lwz 0,0(29)
	cmpw 0,0,3
	bc 12,2,.L603
	mr 9,29
.L604:
	addi 11,11,1
	cmpw 0,11,31
	bc 4,0,.L603
	lwzu 0,4(9)
	cmpw 0,0,3
	bc 4,2,.L604
.L603:
	cmpw 0,11,31
	bc 4,2,.L600
	lwz 0,444(3)
	cmpwi 0,0,0
	bc 12,2,.L600
	mr 4,28
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L600:
	lwz 0,56(1)
	mr 31,27
	cmpw 0,31,0
	bc 12,0,.L601
.L599:
	li 0,0
	stw 0,4056(30)
.L574:
	lwz 0,3644(30)
	lwz 11,3652(30)
	stw 0,3648(30)
	lbz 9,1(26)
	andc 0,9,0
	stw 9,3644(30)
	or 11,11,0
	stw 11,3652(30)
	lbz 0,15(26)
	stw 0,640(28)
	lwz 9,3652(30)
	andi. 0,9,1
	bc 12,2,.L611
	lwz 0,260(28)
	cmpwi 0,0,1
	bc 12,2,.L611
	lwz 0,3572(30)
	cmpwi 0,0,0
	bc 12,2,.L612
	lwz 0,3924(30)
	li 9,0
	stw 9,3652(30)
	cmpwi 0,0,0
	bc 12,2,.L613
	lbz 0,16(30)
	stw 9,3924(30)
	andi. 0,0,191
	stb 0,16(30)
	b .L611
.L613:
	mr 3,28
	bl GetChaseTarget
	b .L611
.L612:
	lwz 0,3656(30)
	cmpwi 0,0,0
	bc 4,2,.L611
	li 0,1
	mr 3,28
	stw 0,3656(30)
	bl Think_Weapon
.L611:
	mr 3,28
	bl CTFApplyRegeneration
	lwz 0,3572(30)
	cmpwi 0,0,0
	bc 12,2,.L617
	lha 0,12(26)
	cmpwi 0,0,9
	bc 4,1,.L618
	lbz 0,16(30)
	andi. 9,0,2
	bc 4,2,.L617
	lwz 9,3924(30)
	ori 0,0,2
	stb 0,16(30)
	cmpwi 0,9,0
	bc 12,2,.L620
	mr 3,28
	bl ChaseNext
	b .L617
.L620:
	mr 3,28
	bl GetChaseTarget
	b .L617
.L618:
	lbz 0,16(30)
	andi. 0,0,253
	stb 0,16(30)
.L617:
	lis 9,maxclients@ha
	lis 10,.LC234@ha
	lwz 11,maxclients@l(9)
	la 10,.LC234@l(10)
	li 31,1
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L542
	lis 11,.LC231@ha
	lis 27,g_edicts@ha
	la 11,.LC231@l(11)
	lis 29,0x4330
	lfd 31,0(11)
	li 30,928
.L626:
	lwz 0,g_edicts@l(27)
	add 3,0,30
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L625
	lwz 9,84(3)
	lwz 0,3924(9)
	cmpw 0,0,28
	bc 4,2,.L625
	bl UpdateChaseCam
.L625:
	addi 31,31,1
	lwz 11,maxclients@l(21)
	xoris 0,31,0x8000
	addi 30,30,928
	stw 0,260(1)
	stw 29,256(1)
	lfd 0,256(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L626
.L542:
	lwz 0,324(1)
	mtlr 0
	lmw 20,264(1)
	lfd 31,312(1)
	la 1,320(1)
	blr
.Lfe19:
	.size	 ClientThink,.Lfe19-ClientThink
	.section	".rodata"
	.align 2
.LC235:
	.long 0x0
	.align 2
.LC236:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl ClientBeginServerFrame
	.type	 ClientBeginServerFrame,@function
ClientBeginServerFrame:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 9,level@ha
	lis 11,.LC235@ha
	la 11,.LC235@l(11)
	la 10,level@l(9)
	lfs 13,0(11)
	mr 30,3
	lfs 0,200(10)
	fcmpu 0,0,13
	bc 4,2,.L631
	lis 9,deathmatch@ha
	lwz 31,84(30)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L633
	lwz 9,1848(31)
	lwz 0,3572(31)
	cmpw 0,9,0
	bc 12,2,.L633
	lfs 0,4(10)
	lis 9,.LC236@ha
	lfs 13,3920(31)
	la 9,.LC236@l(9)
	lfs 12,0(9)
	fsubs 0,0,13
	fcmpu 0,0,12
	cror 3,2,1
	bc 4,3,.L633
	bl spectator_respawn
	b .L631
.L633:
	lwz 0,3656(31)
	cmpwi 0,0,0
	bc 4,2,.L634
	lwz 0,3572(31)
	cmpwi 0,0,0
	bc 4,2,.L634
	lwz 0,260(30)
	cmpwi 0,0,1
	bc 12,2,.L634
	mr 3,30
	bl Think_Weapon
	b .L635
.L634:
	li 0,0
	stw 0,3656(31)
.L635:
	lwz 0,492(30)
	cmpwi 0,0,0
	bc 12,2,.L636
	lis 9,level+4@ha
	lfs 13,3920(31)
	lfs 0,level+4@l(9)
	fcmpu 0,0,13
	bc 4,1,.L631
	lis 9,.LC235@ha
	lis 11,deathmatch@ha
	lwz 10,3652(31)
	la 9,.LC235@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 7,0,13
	mfcr 0
	rlwinm 0,0,31,1
	neg 0,0
	ori 0,0,1
	and. 11,10,0
	bc 4,2,.L641
	bc 12,30,.L631
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1024
	bc 12,2,.L631
.L641:
	mr 3,30
	bl respawn
	li 0,0
.L636:
	stw 0,3652(31)
.L631:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 ClientBeginServerFrame,.Lfe20-ClientBeginServerFrame
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_UZIclip,4,4
	.comm	item_9mm,4,4
	.comm	item_1911rounds,4,4
	.comm	item_50cal,4,4
	.comm	item_MARINERrounds,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_sshotgun,4,4
	.comm	item_handgrenade,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.section	".rodata"
	.align 2
.LC237:
	.long 0x0
	.section	".text"
	.align 2
	.globl InitClientResp
	.type	 InitClientResp,@function
InitClientResp:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	li 4,0
	addi 28,31,1856
	lwz 29,3532(31)
	li 5,1732
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	stw 29,3532(31)
	mr 3,28
	lwz 0,level@l(9)
	addi 4,31,188
	li 5,1668
	stw 0,3524(31)
	crxor 6,6,6
	bl memcpy
	lis 9,.LC237@ha
	lis 11,ctf@ha
	la 9,.LC237@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L234
	lwz 0,3532(31)
	cmpwi 0,0,0
	bc 12,1,.L234
	mr 3,31
	bl CTFAssignTeam
.L234:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 InitClientResp,.Lfe21-InitClientResp
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
	lis 11,.LC161@ha
	stw 0,level+296@l(9)
	li 31,8
	la 30,.LC161@l(11)
.L344:
	bl G_Spawn
	addic. 31,31,-1
	stw 30,280(3)
	bc 4,2,.L344
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe22:
	.size	 InitBodyQue,.Lfe22-InitBodyQue
	.align 2
	.globl player_pain
	.type	 player_pain,@function
player_pain:
	blr
.Lfe23:
	.size	 player_pain,.Lfe23-player_pain
	.section	".rodata"
	.align 2
.LC238:
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
	lis 9,.LC238@ha
	lwz 5,coop@l(11)
	li 7,0
	la 9,.LC238@l(9)
	addi 10,10,928
	lfs 13,0(9)
.L239:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L238
	la 8,game@l(4)
	lwz 0,480(10)
	lwz 9,1028(8)
	add 9,7,9
	stw 0,724(9)
	lwz 11,1028(8)
	lwz 0,484(10)
	add 11,7,11
	stw 0,728(11)
	lwz 9,1028(8)
	lwz 0,264(10)
	add 9,7,9
	andi. 0,0,4144
	stw 0,732(9)
	lfs 0,20(5)
	fcmpu 0,0,13
	bc 12,2,.L238
	lwz 9,84(10)
	lwz 11,1028(8)
	lwz 0,3528(9)
	add 11,7,11
	stw 0,1836(11)
.L238:
	lwz 0,1544(3)
	addi 6,6,1
	addi 7,7,4080
	addi 10,10,928
	cmpw 0,6,0
	bc 12,0,.L239
	blr
.Lfe24:
	.size	 SaveClientData,.Lfe24-SaveClientData
	.section	".rodata"
	.align 2
.LC239:
	.long 0x0
	.section	".text"
	.align 2
	.globl FetchClientEntData
	.type	 FetchClientEntData,@function
FetchClientEntData:
	lis 9,.LC239@ha
	lwz 7,84(3)
	lis 10,coop@ha
	la 9,.LC239@l(9)
	lwz 8,coop@l(10)
	lfs 13,0(9)
	lwz 9,724(7)
	lwz 11,264(3)
	stw 9,480(3)
	lwz 0,728(7)
	stw 0,484(3)
	lwz 9,732(7)
	or 11,11,9
	stw 11,264(3)
	lfs 0,20(8)
	fcmpu 0,0,13
	bclr 12,2
	lwz 0,1836(7)
	stw 0,3528(7)
	blr
.Lfe25:
	.size	 FetchClientEntData,.Lfe25-FetchClientEntData
	.comm	ctfgame,24,4
	.comm	enemies,4,4
	.comm	spawned,4,4
	.comm	lms_round,4,4
	.comm	terror_l,4,4
	.comm	swat_l,4,4
	.comm	lms_delay,4,4
	.comm	lms_delay2,4,4
	.comm	lms_players,4,4
	.comm	lms_dead_players,4,4
	.comm	lms_alive_players,4,4
	.comm	lms_round_over,4,4
	.section	".rodata"
	.align 2
.LC240:
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
	lis 9,.LC240@ha
	mr 30,3
	la 9,.LC240@l(9)
	li 31,0
	lfs 31,0(9)
	lis 29,.LC0@ha
.L9:
	mr 3,31
	li 4,280
	la 5,.LC0@l(29)
	bl G_Find
	mr. 31,3
	bc 12,2,.L6
	lwz 0,300(31)
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
	lwz 3,300(30)
	cmpwi 0,3,0
	bc 12,2,.L14
	lwz 4,300(31)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L6
.L14:
	lwz 0,300(31)
	stw 0,300(30)
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
.LC241:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC242:
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
	lis 11,.LC242@ha
	lis 9,coop@ha
	la 11,.LC242@l(11)
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
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L18
	lis 9,SP_CreateCoopSpots@ha
	lis 10,level+4@ha
	la 9,SP_CreateCoopSpots@l(9)
	lis 11,.LC241@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC241@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
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
.LC243:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_player_deathmatch
	.type	 SP_info_player_deathmatch,@function
SP_info_player_deathmatch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC243@ha
	lis 9,deathmatch@ha
	la 11,.LC243@l(11)
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
	.globl IsFemale
	.type	 IsFemale,@function
IsFemale:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L30
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
	b .L642
.L30:
	li 3,0
.L642:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe30:
	.size	 IsFemale,.Lfe30-IsFemale
	.align 2
	.globl IsNeutral
	.type	 IsNeutral,@function
IsNeutral:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L34
	lis 4,.LC21@ha
	addi 3,3,188
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	lbz 11,0(3)
	xori 9,11,102
	xori 0,11,70
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 10,9,0
	bc 12,2,.L34
	cmpwi 0,11,109
	bc 12,2,.L34
	cmpwi 0,11,77
	li 3,1
	bc 4,2,.L643
.L34:
	li 3,0
.L643:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe31:
	.size	 IsNeutral,.Lfe31-IsNeutral
	.section	".rodata"
	.align 2
.LC244:
	.long 0x4b18967f
	.align 2
.LC245:
	.long 0x3f800000
	.align 3
.LC246:
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
	lis 11,.LC245@ha
	lwz 10,maxclients@l(9)
	la 11,.LC245@l(11)
	mr 31,3
	lfs 13,0(11)
	li 29,1
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC244@ha
	lfs 31,.LC244@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L247
	lis 9,.LC246@ha
	lis 27,g_edicts@ha
	la 9,.LC246@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,928
.L249:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L248
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L248
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
	bc 4,0,.L248
	fmr 31,1
.L248:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,928
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L249
.L247:
	fmr 1,31
	lwz 0,84(1)
	mtlr 0
	lmw 26,40(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe32:
	.size	 PlayersRangeFromSpot,.Lfe32-PlayersRangeFromSpot
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
	bc 4,2,.L298
	bl SelectRandomDeathmatchSpawnPoint
	b .L645
.L298:
	bl SelectFarthestDeathmatchSpawnPoint
.L645:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe33:
	.size	 SelectDeathmatchSpawnPoint,.Lfe33-SelectDeathmatchSpawnPoint
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
	lis 9,0xfefe
	lwz 10,game+1028@l(11)
	ori 9,9,65279
	li 30,0
	li 3,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,4
	bc 12,2,.L646
.L304:
	lis 5,.LC2@ha
	mr 3,30
	la 5,.LC2@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L305
	li 3,0
	b .L646
.L305:
	lwz 4,300(30)
	cmpwi 0,4,0
	bc 4,2,.L306
	lis 9,.LC22@ha
	la 4,.LC22@l(9)
.L306:
	lis 3,game+1032@ha
	la 3,game+1032@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L304
	addic. 31,31,-1
	bc 4,2,.L304
	mr 3,30
.L646:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe34:
	.size	 SelectCoopSpawnPoint,.Lfe34-SelectCoopSpawnPoint
	.section	".rodata"
	.align 2
.LC247:
	.long 0x3f800000
	.align 2
.LC248:
	.long 0x0
	.align 2
.LC249:
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
	lis 0,0xfff0
	lwz 9,480(31)
	ori 0,0,48577
	mr 28,6
	cmpw 0,9,0
	bc 4,0,.L347
	lis 29,gi@ha
	lis 3,.LC136@ha
	la 29,gi@l(29)
	la 3,.LC136@l(3)
	lwz 9,36(29)
	lis 27,.LC137@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC247@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC247@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC247@ha
	la 9,.LC247@l(9)
	lfs 2,0(9)
	lis 9,.LC248@ha
	la 9,.LC248@l(9)
	lfs 3,0(9)
	blrl
.L351:
	mr 3,31
	la 4,.LC137@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L351
	lis 9,.LC249@ha
	lfs 0,12(31)
	mr 4,28
	la 9,.LC249@l(9)
	mr 3,31
	lfs 13,0(9)
	fsubs 0,0,13
	stfs 0,12(31)
	bl ThrowClientHead
	stw 30,512(31)
.L347:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe35:
	.size	 body_die,.Lfe35-body_die
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
	bc 4,1,.L515
	lis 11,gi+48@ha
	lis 9,0x201
	lwz 0,gi+48@l(11)
	ori 9,9,3
	mtlr 0
	blrl
	b .L514
.L515:
	lis 11,gi+48@ha
	lis 9,0x1
	lwz 0,gi+48@l(11)
	mr 3,31
	ori 9,9,3
	mtlr 0
	blrl
.L514:
	mr 3,31
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe36:
	.size	 PM_trace,.Lfe36-PM_trace
	.align 2
	.globl CheckBlock
	.type	 CheckBlock,@function
CheckBlock:
	li 11,0
	li 9,0
	cmpw 0,11,4
	bc 4,0,.L519
.L521:
	lbzx 0,3,9
	addi 9,9,1
	cmpw 0,9,4
	add 11,11,0
	bc 12,0,.L521
.L519:
	mr 3,11
	blr
.Lfe37:
	.size	 CheckBlock,.Lfe37-CheckBlock
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
.L648:
	lbzx 0,3,9
	addi 9,9,1
	add 5,5,0
	bdnz .L648
	li 0,16
	lbz 4,42(3)
	li 6,0
	mtctr 0
	addi 3,3,28
	li 9,0
.L647:
	lbzx 0,3,9
	addi 9,9,1
	add 6,6,0
	bdnz .L647
	lis 3,.LC221@ha
	la 3,.LC221@l(3)
	crxor 6,6,6
	bl Com_Printf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe38:
	.size	 PrintPmove,.Lfe38-PrintPmove
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
	bl Q_stricmp
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
	stw 29,280(3)
	stw 0,4(3)
	stw 27,20(3)
	stw 28,300(3)
	bl G_Spawn
	lis 0,0x437c
	stw 27,20(3)
	stw 0,4(3)
	stw 29,280(3)
	stw 26,8(3)
	stw 25,12(3)
	stw 28,300(3)
	bl G_Spawn
	lis 0,0x439e
	stw 27,20(3)
	stw 29,280(3)
	stw 0,4(3)
	stw 26,8(3)
	stw 25,12(3)
	stw 28,300(3)
.L17:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe39:
	.size	 SP_CreateCoopSpots,.Lfe39-SP_CreateCoopSpots
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
