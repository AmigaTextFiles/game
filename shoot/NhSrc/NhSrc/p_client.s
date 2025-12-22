	.file	"p_client.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 stuff_light,@object
	.size	 stuff_light,4
stuff_light:
	.long 1
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
	.string	"tripped on its own grenade"
	.align 2
.LC36:
	.string	"tripped on her own grenade"
	.align 2
.LC37:
	.string	"tripped on his own grenade"
	.align 2
.LC38:
	.string	"blew itself up"
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
	.string	"killed itself"
	.align 2
.LC43:
	.string	"killed herself"
	.align 2
.LC44:
	.string	"killed himself"
	.align 2
.LC45:
	.string	"%s %s.\n"
	.align 2
.LC46:
	.string	"was blasted by"
	.align 2
.LC47:
	.string	"was gunned down by"
	.align 2
.LC48:
	.string	"was blown away by"
	.align 2
.LC49:
	.string	"'s super shotgun"
	.align 2
.LC50:
	.string	"was machinegunned by"
	.align 2
.LC51:
	.string	"was cut in half by"
	.align 2
.LC52:
	.string	"'s chaingun"
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
	.string	"was creamed by"
	.align 2
.LC58:
	.string	"'s overloaded impulse cannon"
	.align 2
.LC59:
	.string	"burst over"
	.align 2
.LC60:
	.string	"'s impulse cannon"
	.align 2
.LC61:
	.string	"ate"
	.align 2
.LC62:
	.string	"'s rocket"
	.align 2
.LC63:
	.string	"was obliterated by"
	.align 2
.LC64:
	.string	"was smeared by"
	.align 2
.LC65:
	.string	"almost dodged"
	.align 2
.LC66:
	.string	"was melted by"
	.align 2
.LC67:
	.string	"'s hyperblaster"
	.align 2
.LC68:
	.string	"was sniped by"
	.align 2
.LC69:
	.string	"was railed by"
	.align 2
.LC70:
	.string	"saw the pretty lights from"
	.align 2
.LC71:
	.string	"'s BFG"
	.align 2
.LC72:
	.string	"was disintegrated by"
	.align 2
.LC73:
	.string	"'s BFG blast"
	.align 2
.LC74:
	.string	"couldn't hide from"
	.align 2
.LC75:
	.string	"caught"
	.align 2
.LC76:
	.string	"'s handgrenade"
	.align 2
.LC77:
	.string	"didn't see"
	.align 2
.LC78:
	.string	"feels"
	.align 2
.LC79:
	.string	"'s pain"
	.align 2
.LC80:
	.string	"tried to invade"
	.align 2
.LC81:
	.string	"'s personal space"
	.align 2
.LC82:
	.string	"gets all flared up over"
	.align 2
.LC83:
	.string	"'s night light"
	.align 2
.LC84:
	.string	"%s %s the predator%s (%s).\n"
	.align 2
.LC85:
	.string	"misc/predscore.wav"
	.align 2
.LC86:
	.string	"%s killed fellow marine, %s.\n"
	.align 2
.LC87:
	.string	"You just received a PENALTY for that!!!\nNow everyone can see you!\n"
	.align 2
.LC88:
	.string	"Do NOT kill other marines!!!\nRead the console by pressing the ~\n(tilde) key!\n"
	.align 2
.LC89:
	.string	"\nYou're NOT supposed to kill other marines!!!\nKill the predator to become the predator!\nIf you don't get it, read the About page on\nhttp://www.planetquake.com/nighthunnters\n\n"
	.align 2
.LC90:
	.string	"%s killed too many fellow marines. Goodbye %s!\n"
	.align 2
.LC91:
	.string	"disconnect\n"
	.align 2
.LC92:
	.string	"The predator (%s) %s %s%s.\n"
	.align 2
.LC93:
	.string	"%s is now the predator!\n"
	.align 2
.LC94:
	.string	"You will become the new predator!\n"
	.align 2
.LC95:
	.string	"%s died.\n"
	.align 2
.LC96:
	.long 0x0
	.align 2
.LC97:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl ClientObituary
	.type	 ClientObituary,@function
ClientObituary:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 9,coop@ha
	lis 8,.LC96@ha
	lwz 11,coop@l(9)
	la 8,.LC96@l(8)
	mr 30,3
	lfs 13,0(8)
	mr 31,5
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L36
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L36
	lis 9,meansOfDeath@ha
	lwz 0,meansOfDeath@l(9)
	oris 0,0,0x800
	stw 0,meansOfDeath@l(9)
.L36:
	lis 11,.LC96@ha
	lis 9,deathmatch@ha
	la 11,.LC96@l(11)
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
	li 6,0
	rlwinm 29,0,0,5,3
	addi 10,29,-17
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
	la 6,.LC23@l(9)
	b .L39
.L41:
	lis 9,.LC24@ha
	la 6,.LC24@l(9)
	b .L39
.L42:
	lis 9,.LC25@ha
	la 6,.LC25@l(9)
	b .L39
.L43:
	lis 9,.LC26@ha
	la 6,.LC26@l(9)
	b .L39
.L44:
	lis 9,.LC27@ha
	la 6,.LC27@l(9)
	b .L39
.L45:
	lis 9,.LC28@ha
	la 6,.LC28@l(9)
	b .L39
.L47:
	lis 9,.LC29@ha
	la 6,.LC29@l(9)
	b .L39
.L48:
	lis 9,.LC30@ha
	la 6,.LC30@l(9)
	b .L39
.L49:
	lis 9,.LC31@ha
	la 6,.LC31@l(9)
	b .L39
.L50:
	lis 9,.LC32@ha
	la 6,.LC32@l(9)
	b .L39
.L53:
	lis 9,.LC33@ha
	la 6,.LC33@l(9)
.L39:
	cmpw 0,31,30
	bc 4,2,.L56
	addi 10,29,-7
	cmplwi 0,10,17
	bc 12,1,.L83
	lis 11,.L94@ha
	slwi 10,10,2
	la 11,.L94@l(11)
	lis 9,.L94@ha
	lwzx 0,10,11
	la 9,.L94@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L94:
	.long .L60-.L94
	.long .L83-.L94
	.long .L71-.L94
	.long .L83-.L94
	.long .L83-.L94
	.long .L83-.L94
	.long .L82-.L94
	.long .L83-.L94
	.long .L83-.L94
	.long .L60-.L94
	.long .L83-.L94
	.long .L83-.L94
	.long .L83-.L94
	.long .L83-.L94
	.long .L83-.L94
	.long .L83-.L94
	.long .L83-.L94
	.long .L58-.L94
.L58:
	lis 9,.LC34@ha
	la 6,.LC34@l(9)
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
	bc 12,2,.L61
	lis 9,.LC35@ha
	la 6,.LC35@l(9)
	b .L56
.L61:
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
	bc 12,2,.L66
	lis 9,.LC36@ha
	la 6,.LC36@l(9)
	b .L56
.L66:
	lis 9,.LC37@ha
	la 6,.LC37@l(9)
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
	lis 9,.LC38@ha
	la 6,.LC38@l(9)
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
	lis 9,.LC39@ha
	la 6,.LC39@l(9)
	b .L56
.L77:
	lis 9,.LC40@ha
	la 6,.LC40@l(9)
	b .L56
.L82:
	lis 9,.LC41@ha
	la 6,.LC41@l(9)
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
	lis 9,.LC42@ha
	la 6,.LC42@l(9)
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
	lis 9,.LC43@ha
	la 6,.LC43@l(9)
	b .L56
.L89:
	lis 9,.LC44@ha
	la 6,.LC44@l(9)
.L56:
	cmpwi 0,6,0
	bc 12,2,.L95
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC45@ha
	lwz 0,gi@l(9)
	la 4,.LC45@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,896(30)
	cmpwi 0,0,0
	bc 12,2,.L96
	lwz 11,84(30)
	lwz 9,3464(11)
	addi 9,9,-2
	stw 9,3464(11)
.L96:
	li 9,0
	li 0,1
	stw 0,900(30)
	stw 9,540(30)
	b .L35
.L95:
	cmpwi 0,31,0
	stw 31,540(30)
	bc 12,2,.L37
	lwz 0,84(31)
	cmpwi 0,0,0
	mr 8,0
	bc 12,2,.L37
	addi 0,29,-1
	cmplwi 0,0,59
	bc 12,1,.L98
	lis 11,.L128@ha
	slwi 10,0,2
	la 11,.L128@l(11)
	lis 9,.L128@ha
	lwzx 0,10,11
	la 9,.L128@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L128:
	.long .L99-.L128
	.long .L100-.L128
	.long .L101-.L128
	.long .L102-.L128
	.long .L103-.L128
	.long .L104-.L128
	.long .L105-.L128
	.long .L106-.L128
	.long .L111-.L128
	.long .L116-.L128
	.long .L117-.L128
	.long .L120-.L128
	.long .L121-.L128
	.long .L122-.L128
	.long .L123-.L128
	.long .L124-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L126-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L125-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L98-.L128
	.long .L127-.L128
.L99:
	lis 9,.LC46@ha
	la 6,.LC46@l(9)
	b .L98
.L100:
	lis 9,.LC47@ha
	la 6,.LC47@l(9)
	b .L98
.L101:
	lis 9,.LC48@ha
	lis 11,.LC49@ha
	la 6,.LC48@l(9)
	la 28,.LC49@l(11)
	b .L98
.L102:
	lis 9,.LC50@ha
	la 6,.LC50@l(9)
	b .L98
.L103:
	lis 9,.LC51@ha
	lis 11,.LC52@ha
	la 6,.LC51@l(9)
	la 28,.LC52@l(11)
	b .L98
.L104:
	lis 9,.LC53@ha
	lis 11,.LC54@ha
	la 6,.LC53@l(9)
	la 28,.LC54@l(11)
	b .L98
.L105:
	lis 9,.LC55@ha
	lis 11,.LC56@ha
	la 6,.LC55@l(9)
	la 28,.LC56@l(11)
	b .L98
.L106:
	lwz 0,896(31)
	cmpwi 0,0,0
	mr 9,0
	bc 12,2,.L109
	lwz 0,3864(8)
	cmpwi 0,0,0
	bc 12,2,.L107
	lwz 0,912(31)
	cmpwi 0,0,0
	bc 4,2,.L107
	lis 9,.LC57@ha
	lis 11,.LC58@ha
	la 6,.LC57@l(9)
	la 28,.LC58@l(11)
	b .L98
.L107:
	cmpwi 0,9,0
	bc 12,2,.L109
	lwz 0,912(30)
	cmpwi 0,0,0
	bc 4,2,.L109
	lis 9,.LC59@ha
	lis 11,.LC60@ha
	la 6,.LC59@l(9)
	la 28,.LC60@l(11)
	b .L98
.L109:
	lis 9,.LC61@ha
	lis 11,.LC62@ha
	la 6,.LC61@l(9)
	la 28,.LC62@l(11)
	b .L98
.L111:
	lwz 0,896(31)
	cmpwi 0,0,0
	mr 9,0
	bc 12,2,.L114
	lwz 0,3864(8)
	cmpwi 0,0,0
	bc 12,2,.L112
	lwz 0,912(31)
	cmpwi 0,0,0
	bc 4,2,.L112
	lis 9,.LC63@ha
	lis 11,.LC58@ha
	la 6,.LC63@l(9)
	la 28,.LC58@l(11)
	b .L98
.L112:
	cmpwi 0,9,0
	bc 12,2,.L114
	lwz 0,912(31)
	cmpwi 0,0,0
	bc 4,2,.L114
	lis 9,.LC64@ha
	lis 11,.LC60@ha
	la 6,.LC64@l(9)
	la 28,.LC60@l(11)
	b .L98
.L114:
	lis 9,.LC65@ha
	lis 11,.LC62@ha
	la 6,.LC65@l(9)
	la 28,.LC62@l(11)
	b .L98
.L116:
	lis 9,.LC66@ha
	lis 11,.LC67@ha
	la 6,.LC66@l(9)
	la 28,.LC67@l(11)
	b .L98
.L117:
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L118
	lwz 0,912(31)
	cmpwi 0,0,0
	bc 4,2,.L118
	lis 9,.LC68@ha
	la 6,.LC68@l(9)
	b .L98
.L118:
	lis 9,.LC69@ha
	la 6,.LC69@l(9)
	b .L98
.L120:
	lis 9,.LC70@ha
	lis 11,.LC71@ha
	la 6,.LC70@l(9)
	la 28,.LC71@l(11)
	b .L98
.L121:
	lis 9,.LC72@ha
	lis 11,.LC73@ha
	la 6,.LC72@l(9)
	la 28,.LC73@l(11)
	b .L98
.L122:
	lis 9,.LC74@ha
	lis 11,.LC71@ha
	la 6,.LC74@l(9)
	la 28,.LC71@l(11)
	b .L98
.L123:
	lis 9,.LC75@ha
	lis 11,.LC76@ha
	la 6,.LC75@l(9)
	la 28,.LC76@l(11)
	b .L98
.L124:
	lis 9,.LC77@ha
	lis 11,.LC76@ha
	la 6,.LC77@l(9)
	la 28,.LC76@l(11)
	b .L98
.L125:
	lis 9,.LC78@ha
	lis 11,.LC79@ha
	la 6,.LC78@l(9)
	la 28,.LC79@l(11)
	b .L98
.L126:
	lis 9,.LC80@ha
	lis 11,.LC81@ha
	la 6,.LC80@l(9)
	la 28,.LC81@l(11)
	b .L98
.L127:
	lis 9,.LC82@ha
	lis 11,.LC83@ha
	la 6,.LC82@l(9)
	la 28,.LC83@l(11)
.L98:
	cmpwi 0,6,0
	bc 12,2,.L37
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L139
	lwz 27,912(31)
	cmpwi 0,27,0
	bc 4,2,.L133
	lis 29,gi@ha
	lwz 5,84(30)
	lis 4,.LC84@ha
	lwz 9,gi@l(29)
	addi 8,8,700
	la 4,.LC84@l(4)
	addi 5,5,700
	mr 7,28
	li 3,1
	mtlr 9
	la 29,gi@l(29)
	crxor 6,6,6
	blrl
	lwz 9,36(29)
	lis 3,.LC85@ha
	la 3,.LC85@l(3)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC97@ha
	lis 9,.LC96@ha
	lis 11,.LC96@ha
	la 9,.LC96@l(9)
	la 11,.LC96@l(11)
	mr 5,3
	lfs 2,0(9)
	mtlr 0
	la 8,.LC97@l(8)
	lfs 3,0(11)
	li 4,0
	mr 3,31
	lfs 1,0(8)
	blrl
	stw 27,76(30)
	lwz 11,84(31)
	lwz 9,3464(11)
	addi 9,9,1
	b .L140
.L139:
	lwz 29,896(30)
	cmpwi 0,29,0
	bc 4,2,.L133
	lis 9,gi@ha
	lwz 5,84(31)
	lis 4,.LC86@ha
	lwz 0,gi@l(9)
	la 4,.LC86@l(4)
	li 3,1
	lwz 6,84(30)
	addi 5,5,700
	la 28,gi@l(9)
	mtlr 0
	addi 6,6,700
	crxor 6,6,6
	blrl
	stw 29,76(30)
	lis 10,level+4@ha
	lwz 9,904(31)
	addi 9,9,1
	stw 9,904(31)
	lfs 0,level+4@l(10)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	stw 11,908(31)
	bl getPenalty
	cmpwi 0,3,0
	bc 12,2,.L134
	bl getPenalty
	lwz 0,904(31)
	cmpw 0,0,3
	bc 4,2,.L134
	lwz 0,12(28)
	lis 4,.LC87@ha
	mr 3,31
	la 4,.LC87@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L135
.L134:
	lis 29,gi@ha
	lis 4,.LC88@ha
	la 29,gi@l(29)
	la 4,.LC88@l(4)
	lwz 9,12(29)
	mr 3,31
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	lis 5,.LC89@ha
	mr 3,31
	la 5,.LC89@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L135:
	bl getMaxMarineKill
	lwz 0,904(31)
	cmpw 0,0,3
	bc 12,0,.L136
	lis 9,gi@ha
	lwz 5,84(31)
	lis 4,.LC90@ha
	lwz 0,gi@l(9)
	la 4,.LC90@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	mr 6,5
	crxor 6,6,6
	blrl
	lis 4,.LC91@ha
	mr 3,31
	la 4,.LC91@l(4)
	bl stuffcmd
	li 0,0
	stw 0,896(31)
	stw 0,76(31)
	b .L35
.L136:
	lwz 11,84(31)
	b .L141
.L133:
	lis 29,gi@ha
	lwz 5,84(30)
	addi 7,8,700
	lwz 9,gi@l(29)
	lis 4,.LC92@ha
	mr 8,28
	la 4,.LC92@l(4)
	addi 5,5,700
	mtlr 9
	li 3,1
	la 28,gi@l(29)
	crxor 6,6,6
	blrl
	lwz 0,gi@l(29)
	lis 4,.LC93@ha
	li 3,1
	lwz 5,84(31)
	la 4,.LC93@l(4)
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	lwz 0,12(28)
	lis 4,.LC94@ha
	mr 3,31
	la 4,.LC94@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	lwz 9,3464(11)
	addi 9,9,3
	stw 9,3464(11)
	lwz 10,84(30)
	lwz 9,3464(10)
	addi 9,9,-1
	stw 9,3464(10)
	b .L35
.L37:
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC95@ha
	lwz 0,gi@l(9)
	la 4,.LC95@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lis 11,deathmatch@ha
	lis 8,.LC96@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC96@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L35
	lwz 11,84(30)
.L141:
	lwz 9,3464(11)
	addi 9,9,-1
.L140:
	stw 9,3464(11)
.L35:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 ClientObituary,.Lfe2-ClientObituary
	.section	".rodata"
	.align 2
.LC98:
	.string	"Flares"
	.align 2
.LC99:
	.string	"Blaster"
	.align 2
.LC100:
	.string	"item_quad"
	.align 3
.LC101:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC102:
	.long 0x0
	.align 3
.LC103:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC104:
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
	lis 10,.LC102@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC102@l(10)
	mr 30,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L142
	lwz 9,84(30)
	lis 3,.LC98@ha
	la 3,.LC98@l(3)
	lwz 31,1788(9)
	bl FindItem
	cmpw 0,31,3
	bc 12,2,.L142
	lwz 11,84(30)
	lwz 9,3528(11)
	addi 11,11,740
	slwi 9,9,2
	lwzx 10,11,9
	srawi 9,10,31
	xor 0,9,10
	subf 0,0,9
	srawi 0,0,31
	and. 31,31,0
	bc 12,2,.L146
	lwz 3,40(31)
	lis 4,.LC99@ha
	la 4,.LC99@l(4)
	bl strcmp
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	and 31,31,0
.L146:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,16384
	bc 4,2,.L147
	li 29,0
	b .L148
.L147:
	lis 10,level@ha
	lwz 8,84(30)
	lwz 9,level@l(10)
	lis 0,0x4330
	lis 10,.LC103@ha
	lfs 12,3724(8)
	addi 9,9,10
	la 10,.LC103@l(10)
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
.L148:
	addic 11,31,-1
	subfe 0,11,31
	lis 9,.LC102@ha
	and. 10,0,29
	la 9,.LC102@l(9)
	lfs 31,0(9)
	bc 12,2,.L149
	lis 11,.LC104@ha
	la 11,.LC104@l(11)
	lfs 31,0(11)
.L149:
	cmpwi 0,31,0
	bc 12,2,.L151
	lwz 9,84(30)
	mr 4,31
	mr 3,30
	lfs 0,3656(9)
	fsubs 0,0,31
	stfs 0,3656(9)
	bl Drop_Item
	lwz 9,84(30)
	lis 0,0x2
	lfs 0,3656(9)
	fadds 0,0,31
	stfs 0,3656(9)
	stw 0,284(3)
.L151:
	cmpwi 0,29,0
	bc 12,2,.L142
	lwz 9,84(30)
	lis 3,.LC100@ha
	la 3,.LC100@l(3)
	lfs 0,3656(9)
	fadds 0,0,31
	stfs 0,3656(9)
	bl FindItemByClassname
	mr 4,3
	mr 3,30
	bl Drop_Item
	lwz 7,84(30)
	lis 9,.LC103@ha
	lis 11,Touch_Item@ha
	la 9,.LC103@l(9)
	la 11,Touch_Item@l(11)
	lfs 0,3656(7)
	lis 6,level@ha
	lfd 10,0(9)
	lis 4,0x4330
	la 5,level@l(6)
	lis 9,.LC101@ha
	lis 10,G_FreeEdict@ha
	fsubs 0,0,31
	lfd 11,.LC101@l(9)
	la 10,G_FreeEdict@l(10)
	stfs 0,3656(7)
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
	lfs 0,3724(11)
	stw 10,436(3)
	fsub 13,13,10
	frsp 13,13
	fsubs 0,0,13
	fmadd 0,0,11,12
	frsp 0,0
	stfs 0,428(3)
.L142:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 TossClientWeapon,.Lfe3-TossClientWeapon
	.section	".rodata"
	.align 3
.LC105:
	.long 0x404ca5dc
	.long 0x1a63c1f8
	.align 2
.LC106:
	.long 0x0
	.align 2
.LC107:
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
	bc 12,2,.L154
	lis 9,g_edicts@ha
	xor 11,5,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,5,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L154
	lfs 11,12(5)
	lfs 13,4(5)
	lfs 10,4(31)
	lfs 0,8(5)
	b .L164
.L154:
	cmpwi 0,4,0
	bc 12,2,.L156
	lis 9,g_edicts@ha
	xor 11,4,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,4,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L156
	lfs 11,12(4)
	lfs 13,4(4)
	lfs 10,4(31)
	lfs 0,8(4)
.L164:
	lfs 9,8(31)
	lfs 12,12(31)
	fsubs 13,13,10
	fsubs 0,0,9
	fsubs 11,11,12
	stfs 13,8(1)
	stfs 0,12(1)
	stfs 11,16(1)
	b .L155
.L156:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3580(9)
	b .L153
.L155:
	lis 9,.LC106@ha
	lfs 2,8(1)
	la 9,.LC106@l(9)
	lfs 13,0(9)
	fcmpu 0,2,13
	bc 12,2,.L158
	lfs 1,12(1)
	bl atan2
	lis 9,.LC105@ha
	lwz 11,84(31)
	lfd 0,.LC105@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,3580(11)
	b .L159
.L158:
	lwz 9,84(31)
	stfs 13,3580(9)
	lfs 0,12(1)
	fcmpu 0,0,13
	bc 4,1,.L160
	lwz 9,84(31)
	lis 0,0x42b4
	b .L165
.L160:
	bc 4,0,.L159
	lwz 9,84(31)
	lis 0,0xc2b4
.L165:
	stw 0,3580(9)
.L159:
	lwz 3,84(31)
	lis 9,.LC106@ha
	la 9,.LC106@l(9)
	lfs 0,0(9)
	lfs 13,3580(3)
	fcmpu 0,13,0
	bc 4,0,.L153
	lis 11,.LC107@ha
	la 11,.LC107@l(11)
	lfs 0,0(11)
	fadds 0,13,0
	stfs 0,3580(3)
.L153:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 LookAtKiller,.Lfe4-LookAtKiller
	.section	".rodata"
	.align 2
.LC108:
	.string	"predator/growl%i.wav"
	.align 2
.LC109:
	.string	"misc/udeath.wav"
	.align 2
.LC110:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.section	".sbss","aw",@nobits
	.align 2
i.42:
	.space	4
	.size	 i.42,4
	.section	".rodata"
	.align 2
.LC111:
	.string	"*death%i.wav"
	.align 2
.LC112:
	.string	"%s's score is below %i. Goodbye %s!\n"
	.align 3
.LC113:
	.long 0x40080000
	.long 0x0
	.align 3
.LC114:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC115:
	.long 0x3f800000
	.align 2
.LC116:
	.long 0x0
	.section	".text"
	.align 2
	.globl player_die
	.type	 player_die,@function
player_die:
	stwu 1,-144(1)
	mflr 0
	stmw 27,124(1)
	stw 0,148(1)
	mr 31,3
	mr 29,4
	lwz 7,912(31)
	mr 30,5
	mr 28,6
	cmpwi 0,7,0
	bc 4,2,.L166
	li 0,0
	li 9,1
	lwz 10,84(31)
	li 11,7
	stw 9,512(31)
	lis 8,0xc100
	stw 0,24(31)
	lis 27,gi@ha
	stw 0,396(31)
	stw 0,392(31)
	stw 0,388(31)
	stw 0,16(31)
	stw 11,260(31)
	stw 7,44(31)
	stw 7,76(31)
	stw 7,3752(10)
	lwz 9,492(31)
	lwz 0,184(31)
	cmpwi 0,9,0
	stw 8,208(31)
	ori 0,0,2
	stw 0,184(31)
	bc 4,2,.L168
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L169
	lwz 0,900(31)
	cmpwi 0,0,0
	bc 4,2,.L169
	lis 9,level+4@ha
	lis 11,.LC113@ha
	lfs 0,level+4@l(9)
	la 11,.LC113@l(11)
	b .L207
.L169:
	lis 9,level+4@ha
	lis 11,.LC114@ha
	lfs 0,level+4@l(9)
	la 11,.LC114@l(11)
.L207:
	lfd 13,0(11)
	lwz 11,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3808(11)
	mr 3,31
	mr 4,29
	mr 5,30
	bl LookAtKiller
	lwz 9,84(31)
	li 0,2
	mr 4,29
	mr 5,30
	mr 3,31
	stw 0,0(9)
	bl ClientObituary
	mr 3,31
	bl TossClientWeapon
	bl getIREffectTime
	cmpwi 0,3,0
	bc 12,2,.L171
	mr 3,31
	bl deadDropIRgoggles
.L171:
	mr 3,31
	bl ClearFlashlight
	mr 3,31
	bl ClearOverload
	cmpwi 0,30,0
	bc 12,2,.L172
	lwz 9,84(30)
	cmpwi 0,9,0
	bc 12,2,.L172
	lwz 0,3464(9)
	lis 9,fraglimit@ha
	lwz 11,fraglimit@l(9)
	cmpwi 0,0,0
	lfs 13,20(11)
	bc 4,2,.L173
	lis 9,.LC115@ha
	la 9,.LC115@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 12,3,.L174
	b .L172
.L173:
	lis 11,.LC116@ha
	la 11,.LC116@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L172
.L174:
	lis 9,.LC116@ha
	lis 11,deathmatch@ha
	la 9,.LC116@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L172
	mr 3,31
	bl Cmd_Help_f
.L172:
	lis 9,game@ha
	li 29,0
	la 10,game@l(9)
	lis 27,gi@ha
	lwz 0,1556(10)
	cmpw 0,29,0
	bc 4,0,.L168
	lis 9,itemlist@ha
	lis 11,coop@ha
	la 9,itemlist@l(9)
	mr 5,10
	lwz 7,coop@l(11)
	addi 8,9,56
	li 6,0
	lis 9,.LC116@ha
	li 10,0
	la 9,.LC116@l(9)
	lfs 13,0(9)
.L179:
	lfs 0,20(7)
	fcmpu 0,0,13
	bc 12,2,.L180
	lwz 0,0(8)
	andi. 11,0,16
	bc 12,2,.L180
	lwz 9,84(31)
	addi 11,9,740
	lwzx 0,11,10
	addi 9,9,2376
	stwx 0,9,10
.L180:
	lwz 9,84(31)
	addi 29,29,1
	addi 8,8,76
	addi 9,9,740
	stwx 6,9,10
	lwz 0,1556(5)
	addi 10,10,4
	cmpw 0,29,0
	bc 12,0,.L179
.L168:
	lwz 11,84(31)
	li 0,0
	stw 0,3724(11)
	lwz 9,84(31)
	stw 0,3728(9)
	lwz 11,84(31)
	stw 0,3732(11)
	lwz 9,84(31)
	stw 0,3736(9)
	lwz 11,480(31)
	lwz 0,264(31)
	cmpwi 0,11,-40
	rlwinm 0,0,0,20,18
	stw 0,264(31)
	bc 4,0,.L182
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L183
	lwz 0,912(30)
	cmpwi 0,0,0
	bc 4,2,.L183
	lis 29,gi@ha
	la 29,gi@l(29)
	bl rand
	mr 4,3
	srwi 0,4,31
	lis 3,.LC108@ha
	add 0,4,0
	la 3,.LC108@l(3)
	rlwinm 0,0,0,0,30
	subf 4,0,4
	addi 4,4,1
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC115@ha
	lwz 0,16(29)
	lis 11,.LC115@ha
	la 9,.LC115@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC115@l(11)
	mtlr 0
	li 4,2
	lis 9,.LC116@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC116@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,900(31)
	cmpwi 0,0,0
	bc 4,2,.L186
	stw 0,896(31)
	lwz 0,492(30)
	cmpwi 0,0,0
	bc 12,2,.L185
	mr 3,30
	bl PutClientInServer
.L185:
	mr 3,30
	bl switchPredator
	b .L186
.L183:
	lis 29,gi@ha
	lis 3,.LC109@ha
	la 29,gi@l(29)
	la 3,.LC109@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC115@ha
	lwz 0,16(29)
	lis 11,.LC115@ha
	la 9,.LC115@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC115@l(11)
	li 4,4
	mtlr 0
	lis 9,.LC116@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC116@l(9)
	lfs 3,0(9)
	blrl
.L186:
	lis 30,.LC110@ha
	li 29,4
.L190:
	mr 3,31
	la 4,.LC110@l(30)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 29,29,-1
	bc 4,2,.L190
	mr 4,28
	mr 3,31
	bl ThrowClientHead
	li 0,0
	stw 0,512(31)
	b .L192
.L182:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L192
	lis 8,i.42@ha
	lis 9,0x5555
	lwz 6,84(31)
	lwz 10,i.42@l(8)
	ori 9,9,21846
	li 7,5
	addi 10,10,1
	mulhw 9,10,9
	srawi 11,10,31
	subf 9,11,9
	slwi 0,9,1
	add 0,0,9
	subf 10,0,10
	stw 10,i.42@l(8)
	stw 7,3712(6)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L194
	li 0,172
	li 9,177
	b .L208
.L194:
	cmpwi 0,10,1
	bc 12,2,.L198
	bc 12,1,.L202
	cmpwi 0,10,0
	bc 12,2,.L197
	b .L195
.L202:
	cmpwi 0,10,2
	bc 12,2,.L199
	b .L195
.L197:
	li 0,177
	li 9,183
	b .L208
.L198:
	li 0,183
	li 9,189
	b .L208
.L199:
	li 0,189
	li 9,197
.L208:
	stw 0,56(31)
	stw 9,3708(11)
.L195:
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L203
	lwz 0,912(30)
	cmpwi 0,0,0
	bc 4,2,.L203
	lis 29,gi@ha
	la 29,gi@l(29)
	bl rand
	mr 4,3
	srwi 0,4,31
	lis 3,.LC108@ha
	add 0,4,0
	la 3,.LC108@l(3)
	rlwinm 0,0,0,0,30
	subf 4,0,4
	addi 4,4,1
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC115@ha
	lwz 0,16(29)
	lis 11,.LC115@ha
	la 9,.LC115@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC115@l(11)
	mtlr 0
	li 4,2
	lis 9,.LC116@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC116@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,900(31)
	cmpwi 0,0,0
	bc 4,2,.L192
	stw 0,896(31)
	mr 3,30
	bl switchPredator
	b .L192
.L203:
	lis 29,gi@ha
	la 29,gi@l(29)
	bl rand
	mr 4,3
	srawi 0,4,31
	lis 3,.LC111@ha
	srwi 0,0,30
	la 3,.LC111@l(3)
	add 0,4,0
	rlwinm 0,0,0,0,29
	subf 4,0,4
	addi 4,4,1
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC115@ha
	lwz 0,16(29)
	lis 11,.LC115@ha
	la 9,.LC115@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC115@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC116@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC116@l(9)
	lfs 3,0(9)
	blrl
.L192:
	li 0,2
	lis 9,gi+72@ha
	stw 0,492(31)
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 29,84(31)
	bl getMinScore
	lwz 0,3464(29)
	cmpw 0,0,3
	bc 4,0,.L166
	lwz 29,84(31)
	addi 29,29,700
	bl getMinScore
	lwz 7,84(31)
	mr 6,3
	lis 4,.LC112@ha
	lwz 0,gi@l(27)
	la 4,.LC112@l(4)
	li 3,1
	mr 5,29
	addi 7,7,700
	mtlr 0
	crxor 6,6,6
	blrl
	lis 4,.LC91@ha
	mr 3,31
	la 4,.LC91@l(4)
	bl stuffcmd
.L166:
	lwz 0,148(1)
	mtlr 0
	lmw 27,124(1)
	la 1,144(1)
	blr
.Lfe5:
	.size	 player_die,.Lfe5-player_die
	.section	".rodata"
	.align 2
.LC117:
	.string	"flares"
	.section	".text"
	.align 2
	.globl InitClientPersistant
	.type	 InitClientPersistant,@function
InitClientPersistant:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	mr 29,3
	li 4,0
	lwz 31,84(29)
	li 5,1636
	addi 3,31,188
	crxor 6,6,6
	bl memset
	lwz 0,896(29)
	cmpwi 0,0,0
	bc 12,2,.L210
	mr 3,29
	bl initPredator
	b .L211
.L210:
	lis 3,.LC98@ha
	lis 28,0x286b
	la 3,.LC98@l(3)
	ori 28,28,51739
	bl FindItem
	lis 24,init_marine_weapon@ha
	addi 29,31,740
	mr 27,3
	mr 26,29
	bl getMaxFlares
	lis 9,itemlist@ha
	lis 10,max_flares@ha
	lwz 7,init_marine_weapon@l(24)
	la 25,itemlist@l(9)
	lwz 8,max_flares@l(10)
	subf 0,25,27
	lis 4,.LC117@ha
	mullw 0,0,28
	la 4,.LC117@l(4)
	srawi 30,0,2
	slwi 9,30,2
	stwx 3,29,9
	lfs 0,20(8)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	stw 11,1816(31)
	lwz 3,4(7)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L216
	lwz 9,init_marine_weapon@l(24)
	lwz 3,4(9)
	bl FindItem
	mr. 3,3
	bc 4,2,.L214
.L216:
	stw 30,736(31)
	stw 27,1788(31)
	b .L213
.L214:
	subf 29,25,3
	stw 3,1788(31)
	mullw 29,29,28
	srawi 29,29,2
	stw 29,736(31)
	lwz 3,52(3)
	bl FindItem
	subf 0,25,3
	lwz 9,48(3)
	slwi 29,29,2
	mullw 0,0,28
	li 11,1
	rlwinm 0,0,0,0,29
	stwx 9,26,0
	stwx 11,26,29
.L213:
	lis 3,.LC99@ha
	la 3,.LC99@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	li 11,1
	mullw 3,3,0
	li 9,100
	li 10,200
	li 0,50
	rlwinm 3,3,0,0,29
	stwx 11,26,3
	stw 11,720(31)
	stw 9,1768(31)
	stw 10,1780(31)
	stw 0,1784(31)
	stw 9,724(31)
	stw 9,728(31)
	stw 10,1764(31)
	stw 0,1772(31)
	stw 0,1776(31)
.L211:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 InitClientPersistant,.Lfe6-InitClientPersistant
	.section	".rodata"
	.align 2
.LC120:
	.string	"info_player_deathmatch"
	.align 2
.LC119:
	.long 0x47c34f80
	.align 2
.LC121:
	.long 0x4b18967f
	.align 2
.LC122:
	.long 0x3f800000
	.align 3
.LC123:
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
	lis 9,.LC119@ha
	li 28,0
	lfs 29,.LC119@l(9)
	li 30,0
	li 23,0
	li 24,0
	fmr 28,29
	lis 22,.LC120@ha
	b .L238
.L240:
	lis 10,.LC122@ha
	lis 9,maxclients@ha
	la 10,.LC122@l(10)
	lis 11,.LC121@ha
	lfs 13,0(10)
	addi 28,28,1
	li 29,1
	lwz 10,maxclients@l(9)
	lis 25,maxclients@ha
	lfs 31,.LC121@l(11)
	lfs 0,20(10)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L248
	lis 11,.LC123@ha
	lis 26,g_edicts@ha
	la 11,.LC123@l(11)
	lis 27,0x4330
	lfd 30,0(11)
	li 31,952
.L243:
	lwz 0,g_edicts@l(26)
	add 11,0,31
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L245
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L245
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
	bc 4,0,.L245
	fmr 31,1
.L245:
	addi 29,29,1
	lwz 11,maxclients@l(25)
	xoris 0,29,0x8000
	addi 31,31,952
	stw 0,36(1)
	stw 27,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L243
.L248:
	fcmpu 0,31,28
	bc 4,0,.L250
	fmr 28,31
	mr 24,30
	b .L238
.L250:
	fcmpu 0,31,29
	bc 4,0,.L238
	fmr 29,31
	mr 23,30
.L238:
	lis 5,.LC120@ha
	mr 3,30
	la 5,.LC120@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L240
	cmpwi 0,28,0
	bc 4,2,.L254
	li 3,0
	b .L262
.L254:
	cmpwi 0,28,2
	bc 12,1,.L255
	li 23,0
	li 24,0
	b .L256
.L255:
	addi 28,28,-2
.L256:
	bl rand
	li 30,0
	divw 0,3,28
	mullw 0,0,28
	subf 31,0,3
.L261:
	mr 3,30
	li 4,280
	la 5,.LC120@l(22)
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
	bc 4,2,.L261
.L262:
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
.LC124:
	.long 0x4b18967f
	.align 2
.LC125:
	.long 0x0
	.align 2
.LC126:
	.long 0x3f800000
	.align 3
.LC127:
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
	lis 9,.LC125@ha
	li 31,0
	la 9,.LC125@l(9)
	li 25,0
	lfs 29,0(9)
	b .L264
.L266:
	lis 9,maxclients@ha
	lis 11,.LC126@ha
	lwz 10,maxclients@l(9)
	la 11,.LC126@l(11)
	li 29,1
	lfs 13,0(11)
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC124@ha
	lfs 31,.LC124@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L274
	lis 9,.LC127@ha
	lis 27,g_edicts@ha
	la 9,.LC127@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,952
.L269:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L271
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L271
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
	bc 4,0,.L271
	fmr 31,1
.L271:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,952
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L269
.L274:
	fcmpu 0,31,29
	bc 4,1,.L264
	fmr 29,31
	mr 25,31
.L264:
	lis 30,.LC120@ha
	mr 3,31
	li 4,280
	la 5,.LC120@l(30)
	bl G_Find
	mr. 31,3
	bc 4,2,.L266
	cmpwi 0,25,0
	mr 3,25
	bc 4,2,.L279
	la 5,.LC120@l(30)
	li 3,0
	li 4,280
	bl G_Find
.L279:
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
.LC128:
	.string	"Couldn't find spawn point %s\n"
	.align 2
.LC129:
	.long 0x0
	.align 2
.LC130:
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
	lis 11,.LC129@ha
	lis 9,deathmatch@ha
	la 11,.LC129@l(11)
	mr 26,4
	lfs 13,0(11)
	mr 25,5
	li 30,0
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L294
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,512
	bc 12,2,.L295
	bl SelectFarthestDeathmatchSpawnPoint
	mr 30,3
	b .L298
.L295:
	bl SelectRandomDeathmatchSpawnPoint
	mr 30,3
	b .L298
.L322:
	li 30,0
	b .L298
.L294:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L298
	lis 11,game+1028@ha
	lwz 0,84(3)
	lis 9,0xf5a
	lwz 10,game+1028@l(11)
	ori 9,9,52727
	li 29,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,2
	bc 12,2,.L298
	lis 27,.LC2@ha
	lis 28,.LC22@ha
	lis 30,game+1032@ha
.L304:
	mr 3,29
	li 4,280
	la 5,.LC2@l(27)
	bl G_Find
	mr. 29,3
	bc 12,2,.L322
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
	bc 4,2,.L304
	addic. 31,31,-1
	bc 4,2,.L304
	mr 30,29
.L298:
	cmpwi 0,30,0
	bc 4,2,.L310
	lis 29,.LC0@ha
	lis 31,game@ha
.L317:
	mr 3,30
	li 4,280
	la 5,.LC0@l(29)
	bl G_Find
	mr. 30,3
	bc 12,2,.L323
	la 3,game@l(31)
	lbz 0,1032(3)
	cmpwi 0,0,0
	bc 4,2,.L321
	lwz 0,300(30)
	cmpwi 0,0,0
	bc 12,2,.L312
	b .L317
.L321:
	lwz 4,300(30)
	cmpwi 0,4,0
	bc 12,2,.L317
	addi 3,3,1032
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L317
.L312:
	cmpwi 0,30,0
	bc 4,2,.L310
.L323:
	lis 9,game@ha
	la 31,game@l(9)
	lbz 0,1032(31)
	cmpwi 0,0,0
	bc 4,2,.L319
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,280
	bl G_Find
	mr 30,3
.L319:
	cmpwi 0,30,0
	bc 4,2,.L310
	lis 9,gi+28@ha
	lis 3,.LC128@ha
	lwz 0,gi+28@l(9)
	la 3,.LC128@l(3)
	addi 4,31,1032
	mtlr 0
	crxor 6,6,6
	blrl
.L310:
	lfs 0,4(30)
	lis 9,.LC130@ha
	la 9,.LC130@l(9)
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
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe9:
	.size	 SelectSpawnPoint,.Lfe9-SelectSpawnPoint
	.section	".rodata"
	.align 2
.LC131:
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
	mulli 27,27,952
	addi 27,27,952
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
	lis 9,0x46fd
	lis 11,body_die@ha
	ori 9,9,55623
	la 11,body_die@l(11)
	subf 0,0,29
	li 10,1
	mullw 0,0,9
	mr 3,29
	srawi 0,0,3
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
.LC132:
	.string	"menu_loadgame\n"
	.align 2
.LC133:
	.string	"spectator"
	.align 2
.LC134:
	.string	"spectator 0\n"
	.align 2
.LC135:
	.string	"none"
	.align 2
.LC136:
	.string	"Spectator password incorrect.\n"
	.align 2
.LC137:
	.string	"Server spectator limit is full.\n"
	.align 2
.LC138:
	.string	"password"
	.align 2
.LC139:
	.string	"Password incorrect.\n"
	.align 2
.LC140:
	.string	"spectator 1\n"
	.align 2
.LC141:
	.string	"%s has moved to the sidelines\n"
	.align 2
.LC142:
	.string	"%s joined the hunt\n"
	.align 2
.LC143:
	.long 0x3f800000
	.align 3
.LC144:
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
	lwz 0,1812(3)
	cmpwi 0,0,0
	bc 12,2,.L345
	lis 29,.LC133@ha
	addi 3,3,188
	la 4,.LC133@l(29)
	bl Info_ValueForKey
	lwz 28,912(31)
	cmpwi 0,28,0
	bc 12,2,.L343
	lwz 9,84(31)
	li 28,0
	lis 29,gi@ha
	la 29,gi@l(29)
	li 3,11
	stw 28,1812(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC134@ha
	la 3,.LC134@l(3)
	mtlr 9
	blrl
	stw 28,932(31)
	mr 3,31
	li 4,1
	lwz 0,92(29)
	b .L361
.L343:
	lwz 3,84(31)
	lwz 0,1812(3)
	cmpwi 0,0,0
	bc 12,2,.L345
	la 4,.LC133@l(29)
	addi 3,3,188
	bl Info_ValueForKey
	lis 30,spectator_password@ha
	lwz 9,spectator_password@l(30)
	mr 29,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L346
	lis 4,.LC135@ha
	la 4,.LC135@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L346
	lwz 9,spectator_password@l(30)
	mr 4,29
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L346
	lis 29,gi@ha
	lis 5,.LC136@ha
	la 29,gi@l(29)
	li 4,2
	lwz 9,8(29)
	la 5,.LC136@l(5)
	mr 3,31
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 3,11
	stw 28,1812(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC134@ha
	la 3,.LC134@l(3)
	mtlr 9
	blrl
	stw 28,932(31)
	mr 3,31
	li 4,1
	lwz 0,92(29)
	b .L361
.L346:
	lis 11,.LC143@ha
	lis 9,maxclients@ha
	la 11,.LC143@l(11)
	li 7,1
	lfs 0,0(11)
	li 8,0
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L348
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC144@ha
	la 9,.LC144@l(9)
	addi 10,11,952
	lfd 13,0(9)
.L350:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L349
	lwz 11,84(10)
	addi 9,8,1
	lwz 0,1812(11)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L349:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,952
	stw 0,12(1)
	stw 6,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L350
.L348:
	cmpwi 0,8,99
	bc 4,1,.L354
	lis 29,gi@ha
	lis 5,.LC137@ha
	la 29,gi@l(29)
	li 4,2
	lwz 9,8(29)
	la 5,.LC137@l(5)
	mr 3,31
	li 28,0
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 3,11
	stw 28,1812(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC134@ha
	la 3,.LC134@l(3)
	mtlr 9
	blrl
	stw 28,932(31)
	mr 3,31
	li 4,1
	lwz 0,92(29)
	b .L361
.L345:
	lwz 3,84(31)
	lis 4,.LC138@ha
	lis 30,password@ha
	la 4,.LC138@l(4)
	addi 3,3,188
	bl Info_ValueForKey
	lwz 9,password@l(30)
	mr 29,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L354
	lis 4,.LC135@ha
	la 4,.LC135@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L354
	lwz 9,password@l(30)
	mr 4,29
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L354
	lis 29,gi@ha
	lis 5,.LC139@ha
	la 29,gi@l(29)
	li 4,2
	lwz 9,8(29)
	la 5,.LC139@l(5)
	mr 3,31
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,1
	li 3,11
	stw 0,1812(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC140@ha
	la 3,.LC140@l(3)
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,31
	li 4,1
.L361:
	mtlr 0
	blrl
	b .L342
.L354:
	lwz 0,184(31)
	li 30,0
	mr 3,31
	stw 30,932(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	bl PutClientInServer
	lwz 9,84(31)
	lwz 0,1812(9)
	cmpwi 0,0,0
	bc 4,2,.L356
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x46fd
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,55623
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
.L356:
	lis 9,level+4@ha
	lwz 11,84(31)
	lfs 0,level+4@l(9)
	stfs 0,3808(11)
	lwz 5,84(31)
	lwz 0,1812(5)
	cmpwi 0,0,0
	bc 12,2,.L357
	lis 9,gi@ha
	lis 4,.LC141@ha
	lwz 0,gi@l(9)
	la 4,.LC141@l(4)
	addi 5,5,700
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	li 0,1
	mr 3,31
	stw 0,932(31)
	crxor 6,6,6
	bl applyObservePenalties
	lwz 0,916(31)
	cmpwi 0,0,0
	bc 12,2,.L359
	mr 3,31
	bl ShowMOTD
	stw 30,916(31)
	b .L359
.L357:
	lwz 29,916(31)
	cmpwi 0,29,0
	bc 4,2,.L359
	lis 9,gi@ha
	lis 4,.LC142@ha
	lwz 0,gi@l(9)
	la 4,.LC142@l(4)
	addi 5,5,700
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	stw 29,924(31)
	stw 29,932(31)
.L359:
	mr 3,31
	bl ClearFlashlight
.L342:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 spectator_respawn,.Lfe11-spectator_respawn
	.section	".rodata"
	.align 2
.LC145:
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.align 2
.LC146:
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.align 2
.LC147:
	.string	"player"
	.align 2
.LC148:
	.string	"fov"
	.align 2
.LC149:
	.long 0x0
	.align 2
.LC150:
	.long 0x41400000
	.align 2
.LC151:
	.long 0x41000000
	.align 3
.LC152:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC153:
	.long 0x3f800000
	.align 2
.LC154:
	.long 0x43200000
	.align 2
.LC155:
	.long 0x47800000
	.align 2
.LC156:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl PutClientInServer
	.type	 PutClientInServer,@function
PutClientInServer:
	stwu 1,-4464(1)
	mflr 0
	stfd 31,4456(1)
	stmw 22,4416(1)
	stw 0,4468(1)
	lis 9,.LC145@ha
	lis 8,.LC146@ha
	lwz 0,.LC145@l(9)
	addi 10,1,8
	la 29,.LC146@l(8)
	la 9,.LC145@l(9)
	lwz 11,.LC146@l(8)
	mr 31,3
	lwz 28,8(9)
	addi 7,1,24
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
	lis 9,.LC149@ha
	lis 11,g_edicts@ha
	lwz 30,84(31)
	la 9,.LC149@l(9)
	lis 0,0x46fd
	lfs 13,0(9)
	ori 0,0,55623
	lis 9,deathmatch@ha
	lwz 10,deathmatch@l(9)
	lwz 9,g_edicts@l(11)
	lfs 0,20(10)
	subf 9,9,31
	mullw 9,9,0
	fcmpu 0,0,13
	srawi 9,9,3
	addi 24,9,-1
	bc 12,2,.L363
	addi 28,1,1720
	addi 27,30,1824
	addi 26,1,3384
	mr 4,27
	li 5,1660
	mr 3,28
	crxor 6,6,6
	bl memcpy
	addi 29,30,188
	mr 23,28
	mr 4,29
	li 5,512
	mr 3,26
	mr 25,29
	crxor 6,6,6
	bl memcpy
	mr 3,31
	bl InitClientPersistant
	mr 4,26
	mr 3,31
	bl ClientUserinfoChanged
	b .L364
.L363:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L365
	addi 28,1,1720
	addi 27,30,1824
	mr 4,27
	li 5,1660
	mr 3,28
	addi 29,30,188
	crxor 6,6,6
	bl memcpy
	mr 23,28
	mr 25,29
	addi 26,1,3896
	mr 4,29
	li 5,512
	mr 3,26
	crxor 6,6,6
	bl memcpy
	lwz 9,1804(30)
	mr 4,28
	li 5,1636
	mr 3,29
	stw 9,3336(1)
	lwz 0,1808(30)
	stw 0,3340(1)
	crxor 6,6,6
	bl memcpy
	mr 4,26
	mr 3,31
	bl ClientUserinfoChanged
	lwz 9,3360(1)
	lwz 0,1800(30)
	cmpw 0,9,0
	bc 4,1,.L364
	stw 9,1800(30)
	b .L364
.L365:
	addi 29,1,1720
	li 4,0
	mr 3,29
	li 5,1660
	crxor 6,6,6
	bl memset
	mr 23,29
	addi 27,30,1824
	addi 25,30,188
.L364:
	addi 29,1,72
	mr 4,25
	li 5,1636
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 4,0
	li 5,3868
	mr 3,30
	crxor 6,6,6
	bl memset
	mr 4,29
	mr 3,25
	li 5,1636
	crxor 6,6,6
	bl memcpy
	lwz 0,724(30)
	cmpwi 0,0,0
	bc 12,1,.L368
	mr 3,31
	bl InitClientPersistant
.L368:
	lis 9,.LC149@ha
	mr 3,27
	la 9,.LC149@l(9)
	mr 4,23
	lfs 31,0(9)
	li 5,1660
	crxor 6,6,6
	bl memcpy
	lwz 7,84(31)
	lis 10,coop@ha
	lwz 8,coop@l(10)
	lwz 9,724(7)
	lwz 11,264(31)
	stw 9,480(31)
	lwz 0,728(7)
	stw 0,484(31)
	lwz 9,732(7)
	or 11,11,9
	stw 11,264(31)
	lfs 0,20(8)
	fcmpu 0,0,31
	bc 12,2,.L370
	lwz 0,1800(7)
	stw 0,3464(7)
.L370:
	li 8,0
	lis 11,game+1028@ha
	mulli 7,24,3868
	lwz 6,264(31)
	stw 8,552(31)
	li 0,4
	lis 9,.LC147@ha
	lwz 3,game+1028@l(11)
	li 5,2
	la 9,.LC147@l(9)
	li 11,22
	stw 0,260(31)
	li 10,1
	stw 11,508(31)
	add 3,3,7
	li 0,200
	lis 11,.LC150@ha
	stw 10,88(31)
	lis 7,level+4@ha
	stw 9,280(31)
	la 11,.LC150@l(11)
	lis 10,player_pain@ha
	stw 0,400(31)
	lis 9,player_die@ha
	la 10,player_pain@l(10)
	stw 5,248(31)
	la 9,player_die@l(9)
	rlwinm 6,6,0,21,19
	stw 5,512(31)
	li 4,0
	stw 8,492(31)
	li 5,184
	stw 3,84(31)
	lfs 0,level+4@l(7)
	lfs 13,0(11)
	lfs 10,8(1)
	lis 11,0x201
	lfs 12,24(1)
	ori 11,11,3
	fadds 0,0,13
	lfs 11,28(1)
	lfs 13,16(1)
	lfs 9,12(1)
	lwz 0,184(31)
	lfs 8,32(1)
	rlwinm 0,0,0,31,29
	stfs 0,404(31)
	stw 11,252(31)
	stw 10,452(31)
	stw 9,456(31)
	stw 8,912(31)
	stfs 10,188(31)
	stfs 13,196(31)
	stfs 12,200(31)
	stfs 11,204(31)
	stw 6,264(31)
	stw 0,184(31)
	stfs 9,192(31)
	stw 8,612(31)
	stw 8,608(31)
	stfs 8,208(31)
	stfs 31,384(31)
	stfs 31,380(31)
	stfs 31,376(31)
	crxor 6,6,6
	bl memset
	lis 9,.LC151@ha
	lfs 0,40(1)
	la 9,.LC151@l(9)
	mr 10,11
	lfs 10,0(9)
	mr 8,11
	lis 9,deathmatch@ha
	lwz 7,deathmatch@l(9)
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,4408(1)
	lwz 11,4412(1)
	sth 11,4(30)
	lfs 0,44(1)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,4408(1)
	lwz 10,4412(1)
	sth 10,6(30)
	lfs 0,48(1)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,4408(1)
	lwz 8,4412(1)
	sth 8,8(30)
	lfs 0,20(7)
	fcmpu 0,0,31
	bc 12,2,.L371
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,4408(1)
	lwz 11,4412(1)
	andi. 0,11,32768
	bc 4,2,.L385
.L371:
	lis 4,.LC148@ha
	mr 3,25
	la 4,.LC148@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	stw 3,4412(1)
	lis 0,0x4330
	lis 11,.LC152@ha
	la 11,.LC152@l(11)
	stw 0,4408(1)
	lfd 13,0(11)
	lfd 0,4408(1)
	lis 11,.LC153@ha
	la 11,.LC153@l(11)
	lfs 12,0(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	stfs 0,112(30)
	bc 4,0,.L373
.L385:
	lis 0,0x42b4
	stw 0,112(30)
	b .L372
.L373:
	lis 9,.LC154@ha
	la 9,.LC154@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L372
	stfs 13,112(30)
.L372:
	lis 9,gi+32@ha
	lwz 11,1788(30)
	lwz 0,gi+32@l(9)
	lwz 3,32(11)
	mtlr 0
	blrl
	lis 11,.LC156@ha
	lis 9,.LC155@ha
	stw 3,88(30)
	la 11,.LC156@l(11)
	la 9,.LC155@l(9)
	lfs 13,48(1)
	lfs 10,0(11)
	lis 0,0x46fd
	li 10,255
	lis 11,g_edicts@ha
	lfs 9,0(9)
	ori 0,0,55623
	lwz 9,g_edicts@l(11)
	mr 5,22
	addi 6,30,3468
	lis 11,.LC153@ha
	lfs 11,40(1)
	addi 7,30,20
	la 11,.LC153@l(11)
	subf 9,9,31
	lfs 12,44(1)
	lfs 0,0(11)
	mullw 9,9,0
	li 8,0
	li 0,3
	li 11,0
	stw 10,44(31)
	mtctr 0
	srawi 9,9,3
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
.L384:
	lfsx 0,8,5
	lfsx 12,8,6
	addi 8,8,4
	fsubs 0,0,12
	fmuls 0,0,9
	fdivs 0,0,10
	fctiwz 13,0
	stfd 13,4408(1)
	lwz 9,4412(1)
	sth 9,0(7)
	addi 7,7,2
	bdnz .L384
	lfs 0,60(1)
	li 0,0
	stw 0,24(31)
	stw 0,16(31)
	stfs 0,20(31)
	stw 0,28(30)
	lfs 13,20(31)
	lwz 9,1812(30)
	stfs 13,32(30)
	cmpwi 0,9,0
	lfs 0,24(31)
	stfs 0,36(30)
	lfs 13,16(31)
	stfs 13,3652(30)
	lfs 0,20(31)
	stfs 0,3656(30)
	lfs 13,24(31)
	stfs 13,3660(30)
	bc 12,2,.L381
	li 9,0
	li 10,1
	stw 10,3480(30)
	lis 8,gi+72@ha
	mr 3,31
	stw 9,3812(30)
	lwz 0,184(31)
	lwz 11,84(31)
	ori 0,0,1
	stw 10,260(31)
	stw 0,184(31)
	stw 9,248(31)
	stw 9,88(11)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	b .L362
.L381:
	stw 9,3480(30)
	mr 3,31
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,1788(30)
	mr 3,31
	stw 0,3548(30)
	bl ChangeWeapon
	mr 3,31
	bl setSafetyMode
.L362:
	lwz 0,4468(1)
	mtlr 0
	lmw 22,4416(1)
	lfd 31,4456(1)
	la 1,4464(1)
	blr
.Lfe12:
	.size	 PutClientInServer,.Lfe12-PutClientInServer
	.section	".rodata"
	.align 2
.LC157:
	.string	"%s entered the game\n"
	.align 2
.LC158:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientBeginDeathmatch
	.type	 ClientBeginDeathmatch,@function
ClientBeginDeathmatch:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	bl G_InitEdict
	lwz 29,84(31)
	li 4,0
	li 5,1660
	addi 28,29,1824
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	addi 4,29,188
	lwz 0,level@l(9)
	la 30,level@l(9)
	li 5,1636
	mr 3,28
	stw 0,3460(29)
	crxor 6,6,6
	bl memcpy
	mr 3,31
	bl NH_PreConnect
	mr 3,31
	bl PutClientInServer
	mr 3,31
	bl NH_PostConnect
	lis 9,.LC158@ha
	lfs 13,200(30)
	la 9,.LC158@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L388
	mr 3,31
	bl MoveClientToIntermission
	b .L389
.L388:
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x46fd
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,55623
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
	addi 3,31,4
	li 4,2
	mtlr 0
	blrl
	lfs 0,4(30)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	addi 9,9,2
	stw 9,920(31)
.L389:
	lis 9,gi@ha
	lwz 5,84(31)
	lis 4,.LC157@ha
	lwz 0,gi@l(9)
	li 3,2
	la 4,.LC157@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl ClientEndServerFrame
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 ClientBeginDeathmatch,.Lfe13-ClientBeginDeathmatch
	.section	".rodata"
	.align 2
.LC159:
	.long 0x0
	.align 2
.LC160:
	.long 0x47800000
	.align 2
.LC161:
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
	lis 0,0x46fd
	lis 10,deathmatch@ha
	ori 0,0,55623
	lis 11,game+1028@ha
	subf 9,9,31
	lwz 8,game+1028@l(11)
	mullw 9,9,0
	lwz 11,deathmatch@l(10)
	lis 10,.LC159@ha
	srawi 9,9,3
	la 10,.LC159@l(10)
	mulli 9,9,3868
	lfs 13,0(10)
	addi 9,9,-3868
	add 8,8,9
	stw 8,84(31)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L391
	bl ClientBeginDeathmatch
	b .L390
.L391:
	lwz 0,88(31)
	cmpwi 0,0,1
	bc 4,2,.L392
	lis 9,.LC160@ha
	lis 10,.LC161@ha
	li 11,3
	la 9,.LC160@l(9)
	la 10,.LC161@l(10)
	mtctr 11
	lfs 11,0(9)
	li 8,0
	lfs 12,0(10)
	li 7,0
.L403:
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
	bdnz .L403
	b .L398
.L392:
	mr 3,31
	bl G_InitEdict
	lwz 28,84(31)
	lis 9,.LC147@ha
	li 4,0
	la 9,.LC147@l(9)
	li 5,1660
	addi 29,28,1824
	stw 9,280(31)
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,29
	lwz 0,level@l(9)
	addi 4,28,188
	li 5,1636
	stw 0,3460(28)
	crxor 6,6,6
	bl memcpy
	mr 3,31
	bl PutClientInServer
.L398:
	lis 10,.LC159@ha
	lis 9,level+200@ha
	la 10,.LC159@l(10)
	lfs 0,level+200@l(9)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 12,2,.L400
	mr 3,31
	bl MoveClientToIntermission
	b .L401
.L400:
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L401
	lis 28,gi@ha
	li 3,1
	la 29,gi@l(28)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x46fd
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,55623
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
	lis 4,.LC157@ha
	li 3,2
	lwz 0,gi@l(28)
	la 4,.LC157@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L401:
	mr 3,31
	bl ClientEndServerFrame
.L390:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 ClientBegin,.Lfe14-ClientBegin
	.section	".rodata"
	.align 2
.LC162:
	.string	"\\name\\badinfo\\skin\\male/grunt"
	.align 2
.LC163:
	.string	"name"
	.align 2
.LC164:
	.string	"0"
	.align 2
.LC165:
	.string	"hand"
	.align 2
.LC166:
	.long 0x0
	.align 3
.LC167:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC168:
	.long 0x42b40000
	.align 2
.LC169:
	.long 0x3f800000
	.align 2
.LC170:
	.long 0x43200000
	.section	".text"
	.align 2
	.globl ClientUserinfoChanged
	.type	 ClientUserinfoChanged,@function
ClientUserinfoChanged:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 30,4
	mr 29,3
	mr 3,30
	bl Info_Validate
	cmpwi 0,3,0
	bc 4,2,.L405
	lis 11,.LC162@ha
	lwz 0,.LC162@l(11)
	la 9,.LC162@l(11)
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
.L405:
	lis 4,.LC163@ha
	mr 3,30
	la 4,.LC163@l(4)
	bl Info_ValueForKey
	lwz 9,84(29)
	mr 31,3
	li 5,15
	mr 4,31
	addi 3,9,700
	bl strncpy
	lis 4,.LC133@ha
	mr 3,30
	la 4,.LC133@l(4)
	bl Info_ValueForKey
	lis 11,.LC166@ha
	lis 9,deathmatch@ha
	la 11,.LC166@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L406
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L406
	lis 4,.LC164@ha
	la 4,.LC164@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L406
	lwz 9,84(29)
	li 0,1
	b .L418
.L406:
	lwz 9,84(29)
	li 0,0
.L418:
	stw 0,1812(9)
	lwz 0,896(29)
	cmpwi 0,0,0
	bc 4,2,.L408
	mr 3,29
	mr 4,30
	bl checkMarineSkin
.L408:
	lis 9,.LC166@ha
	lis 11,deathmatch@ha
	la 9,.LC166@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L409
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,32768
	bc 12,2,.L409
	lwz 9,84(29)
	b .L419
.L409:
	lis 4,.LC148@ha
	mr 3,30
	la 4,.LC148@l(4)
	bl Info_ValueForKey
	bl atoi
	lis 9,.LC167@ha
	xoris 3,3,0x8000
	lwz 11,84(29)
	la 9,.LC167@l(9)
	lis 8,0x4330
	lfd 12,0(9)
	lis 9,.LC168@ha
	la 9,.LC168@l(9)
	lfs 11,0(9)
	stw 3,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	stfs 0,112(11)
	lwz 10,84(29)
	lfs 0,112(10)
	fcmpu 0,0,11
	bc 4,0,.L411
	lis 11,level@ha
	lfs 13,3860(10)
	lwz 0,level@l(11)
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L411
	lwz 0,896(29)
	cmpwi 0,0,0
	bc 4,2,.L411
	stfs 11,112(10)
.L411:
	lwz 9,84(29)
	lis 11,.LC169@ha
	la 11,.LC169@l(11)
	lfs 0,0(11)
	lfs 13,112(9)
	fcmpu 0,13,0
	bc 4,0,.L414
.L419:
	lis 0,0x42b4
	stw 0,112(9)
	b .L410
.L414:
	lis 11,.LC170@ha
	la 11,.LC170@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L410
	stfs 0,112(9)
.L410:
	lis 4,.LC165@ha
	mr 3,30
	la 4,.LC165@l(4)
	bl Info_ValueForKey
	mr 31,3
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L417
	mr 3,31
	bl atoi
	lwz 9,84(29)
	stw 3,716(9)
.L417:
	lwz 3,84(29)
	mr 4,30
	li 5,511
	addi 3,3,188
	bl strncpy
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe15:
	.size	 ClientUserinfoChanged,.Lfe15-ClientUserinfoChanged
	.section	".rodata"
	.align 2
.LC171:
	.string	"ip"
	.align 2
.LC172:
	.string	"rejmsg"
	.align 2
.LC173:
	.string	"Banned."
	.align 2
.LC174:
	.string	"Spectator password required or incorrect."
	.align 2
.LC175:
	.string	"Server spectator limit is full."
	.align 2
.LC176:
	.string	"Password required or incorrect."
	.align 2
.LC177:
	.string	"%s connected\n"
	.align 2
.LC178:
	.string	"%s connected from IP address: %s\n"
	.align 2
.LC179:
	.long 0x0
	.align 3
.LC180:
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
	mr 30,4
	mr 31,3
	lis 4,.LC171@ha
	mr 3,30
	la 4,.LC171@l(4)
	bl Info_ValueForKey
	bl SV_FilterPacket
	cmpwi 0,3,0
	bc 12,2,.L421
	lis 4,.LC172@ha
	lis 5,.LC173@ha
	mr 3,30
	la 4,.LC172@l(4)
	la 5,.LC173@l(5)
	b .L439
.L421:
	lis 4,.LC133@ha
	mr 3,30
	la 4,.LC133@l(4)
	bl Info_ValueForKey
	lis 11,.LC179@ha
	lis 9,deathmatch@ha
	la 11,.LC179@l(11)
	mr 29,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L422
	lbz 0,0(29)
	cmpwi 0,0,0
	bc 12,2,.L422
	lis 4,.LC164@ha
	la 4,.LC164@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L422
	lis 28,spectator_password@ha
	lwz 9,spectator_password@l(28)
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L423
	lis 4,.LC135@ha
	la 4,.LC135@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L423
	lwz 9,spectator_password@l(28)
	mr 4,29
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L423
	lis 4,.LC172@ha
	lis 5,.LC174@ha
	mr 3,30
	la 4,.LC172@l(4)
	la 5,.LC174@l(5)
	b .L439
.L423:
	lis 11,.LC179@ha
	lis 9,maxclients@ha
	la 11,.LC179@l(11)
	li 8,0
	lfs 0,0(11)
	li 7,0
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	bc 4,0,.L425
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC180@ha
	la 9,.LC180@l(9)
	addi 10,11,952
	lfd 13,0(9)
.L427:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L426
	lwz 11,84(10)
	addi 9,8,1
	lwz 0,1812(11)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L426:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,952
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L427
.L425:
	cmpwi 0,8,99
	bc 4,1,.L431
	lis 4,.LC172@ha
	lis 5,.LC175@ha
	mr 3,30
	la 4,.LC172@l(4)
	la 5,.LC175@l(5)
	b .L439
.L422:
	lis 4,.LC138@ha
	mr 3,30
	la 4,.LC138@l(4)
	lis 28,password@ha
	bl Info_ValueForKey
	lwz 9,password@l(28)
	mr 29,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L431
	lis 4,.LC135@ha
	la 4,.LC135@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L431
	lwz 9,password@l(28)
	mr 4,29
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L431
	lis 4,.LC172@ha
	lis 5,.LC176@ha
	mr 3,30
	la 4,.LC172@l(4)
	la 5,.LC176@l(5)
.L439:
	bl Info_SetValueForKey
	li 3,0
	b .L438
.L431:
	lis 11,g_edicts@ha
	lis 0,0x46fd
	lwz 10,88(31)
	lwz 9,g_edicts@l(11)
	ori 0,0,55623
	lis 11,game@ha
	cmpwi 0,10,0
	subf 9,9,31
	la 27,game@l(11)
	mullw 9,9,0
	lwz 11,1028(27)
	srawi 9,9,3
	mulli 9,9,3868
	addi 9,9,-3868
	add 28,11,9
	stw 28,84(31)
	bc 4,2,.L433
	addi 29,28,1824
	li 4,0
	li 5,1660
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,29
	lwz 0,level@l(9)
	addi 4,28,188
	li 5,1636
	stw 0,3460(28)
	crxor 6,6,6
	bl memcpy
	lwz 0,1560(27)
	cmpwi 0,0,0
	bc 12,2,.L436
	lwz 9,84(31)
	lwz 0,1788(9)
	cmpwi 0,0,0
	bc 4,2,.L433
.L436:
	mr 3,31
	bl InitClientPersistant
.L433:
	mr 4,30
	mr 3,31
	bl ClientUserinfoChanged
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L437
	lis 9,gi@ha
	lwz 5,84(31)
	lis 4,.LC177@ha
	lwz 0,gi@l(9)
	li 3,2
	la 4,.LC177@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L437:
	lwz 28,84(31)
	lis 29,gi@ha
	lis 4,.LC171@ha
	la 29,gi@l(29)
	la 4,.LC171@l(4)
	addi 3,28,188
	addi 28,28,700
	bl Info_ValueForKey
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC178@ha
	la 3,.LC178@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,0
	li 9,1
	stw 0,184(31)
	li 3,1
	stw 9,720(11)
.L438:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe16:
	.size	 ClientConnect,.Lfe16-ClientConnect
	.section	".rodata"
	.align 2
.LC181:
	.string	"%s disconnected\n"
	.align 2
.LC182:
	.string	"disconnected"
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
	bc 12,2,.L440
	lis 29,gi@ha
	lis 4,.LC181@ha
	lwz 9,gi@l(29)
	addi 5,5,700
	la 4,.LC181@l(4)
	li 3,2
	la 29,gi@l(29)
	mtlr 9
	lis 27,g_edicts@ha
	lis 28,0x46fd
	ori 28,28,55623
	li 30,0
	crxor 6,6,6
	blrl
	lwz 9,100(29)
	li 3,1
	mtlr 9
	blrl
	lwz 3,g_edicts@l(27)
	lwz 9,104(29)
	subf 3,3,31
	mullw 3,3,28
	mtlr 9
	srawi 3,3,3
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
	lis 9,.LC182@ha
	lis 4,.LC22@ha
	la 9,.LC182@l(9)
	lwz 11,84(31)
	la 4,.LC22@l(4)
	stw 9,280(31)
	subf 3,3,31
	stw 30,40(31)
	mullw 3,3,28
	stw 30,248(31)
	stw 30,88(31)
	srawi 3,3,3
	stw 30,720(11)
	addi 3,3,1311
	lwz 0,24(29)
	mtlr 0
	blrl
	mr 3,31
	bl ClearFlashlight
	lwz 0,896(31)
	stw 30,76(31)
	cmpwi 0,0,0
	bc 12,2,.L440
	stw 30,896(31)
.L440:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 ClientDisconnect,.Lfe17-ClientDisconnect
	.section	".rodata"
	.align 2
.LC183:
	.string	"sv %3i:%i %i\n"
	.align 2
.LC187:
	.string	"predator/growl_75.wav"
	.align 2
.LC188:
	.string	"*jump1.wav"
	.align 2
.LC189:
	.string	"rockets"
	.align 2
.LC190:
	.string	"slugs"
	.align 2
.LC191:
	.string	"%s\\%s"
	.align 2
.LC192:
	.string	"world/bigpump.wav"
	.align 2
.LC193:
	.string	"misc/newpred.wav"
	.align 2
.LC184:
	.long 0x43968000
	.align 3
.LC185:
	.long 0x3f768000
	.long 0x0
	.align 3
.LC186:
	.long 0x3fc051eb
	.long 0x851eb852
	.align 2
.LC194:
	.long 0x0
	.align 3
.LC195:
	.long 0x40140000
	.long 0x0
	.align 3
.LC196:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC197:
	.long 0x41000000
	.align 3
.LC198:
	.long 0x3fc00000
	.long 0x0
	.align 2
.LC199:
	.long 0x3f800000
	.align 2
.LC200:
	.long 0x41200000
	.align 2
.LC201:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl ClientThink
	.type	 ClientThink,@function
ClientThink:
	stwu 1,-320(1)
	mflr 0
	stfd 30,304(1)
	stfd 31,312(1)
	stmw 20,256(1)
	stw 0,324(1)
	lis 9,level@ha
	mr 31,3
	la 10,level@l(9)
	mr 30,4
	stw 31,292(10)
	lwz 0,908(31)
	lwz 28,84(31)
	cmpwi 0,0,0
	bc 4,2,.L466
	lis 11,.LC184@ha
	lfs 0,4(10)
	lfs 12,.LC184@l(11)
	fsubs 0,0,12
	fctiwz 13,0
	stfd 13,248(1)
	lwz 9,252(1)
	stw 9,908(31)
.L466:
	lis 7,.LC194@ha
	lfs 13,200(10)
	la 7,.LC194@l(7)
	lfs 0,0(7)
	fcmpu 0,13,0
	bc 12,2,.L467
	li 0,4
	lis 9,.LC195@ha
	stw 0,0(28)
	la 9,.LC195@l(9)
	lfs 0,200(10)
	lfd 12,0(9)
	lfs 13,4(10)
	fadd 0,0,12
	fcmpu 0,13,0
	bc 4,1,.L465
	lbz 0,1(30)
	andi. 11,0,128
	bc 12,2,.L465
	li 0,1
	stw 0,208(10)
	b .L465
.L467:
	lwz 9,84(31)
	lis 11,pm_passent@ha
	stw 31,pm_passent@l(11)
	lwz 0,3812(9)
	cmpwi 0,0,0
	bc 12,2,.L469
	lha 0,2(30)
	lis 8,0x4330
	lis 20,.LC196@ha
	lis 9,.LC185@ha
	xoris 0,0,0x8000
	la 20,.LC196@l(20)
	lfd 13,.LC185@l(9)
	stw 0,252(1)
	mr 10,11
	mr 9,11
	stw 8,248(1)
	lis 21,maxclients@ha
	lfd 12,0(20)
	lfd 0,248(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3468(28)
	lha 0,4(30)
	xoris 0,0,0x8000
	stw 0,252(1)
	stw 8,248(1)
	lfd 0,248(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3472(28)
	lha 0,6(30)
	xoris 0,0,0x8000
	stw 0,252(1)
	stw 8,248(1)
	lfd 0,248(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3476(28)
	b .L470
.L469:
	addi 3,1,8
	li 4,0
	mr 29,3
	li 5,240
	crxor 6,6,6
	bl memset
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L475
	lwz 0,40(31)
	cmpwi 0,0,255
	li 0,3
	bc 4,2,.L475
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L475
	li 0,2
.L475:
	stw 0,0(28)
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L477
	lwz 0,912(31)
	cmpwi 0,0,0
	bc 12,2,.L477
	li 0,0
	li 11,0
	stw 0,376(31)
	stw 0,384(31)
	stw 0,380(31)
	lbz 9,16(28)
	ori 9,9,64
	stb 9,16(28)
	sth 11,12(30)
	sth 11,8(30)
	sth 11,10(30)
.L477:
	lis 9,sv_gravity@ha
	lwz 7,0(28)
	lwz 10,sv_gravity@l(9)
	li 20,3
	addi 24,1,12
	lwz 0,8(28)
	mtctr 20
	addi 22,31,4
	addi 23,1,18
	lfs 0,20(10)
	addi 25,31,376
	mr 12,24
	lwz 9,12(28)
	lis 10,.LC197@ha
	mr 4,22
	lwz 8,4(28)
	la 10,.LC197@l(10)
	mr 3,23
	lfs 10,0(10)
	mr 5,25
	addi 27,28,3484
	addi 26,1,36
	lis 21,maxclients@ha
	li 6,0
	li 10,0
	fctiwz 13,0
	stfd 13,248(1)
	lwz 11,252(1)
	sth 11,18(28)
	stw 7,8(1)
	stw 8,4(29)
	stw 0,8(29)
	stw 9,12(29)
	lwz 0,16(28)
	lwz 9,20(28)
	lwz 11,24(28)
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
	stfd 12,248(1)
	lwz 11,252(1)
	stfd 11,248(1)
	lwz 9,252(1)
	sthx 11,10,12
	sthx 9,10,3
	addi 10,10,2
	bdnz .L546
	mr 3,27
	addi 4,1,8
	li 5,28
	bl memcmp
	cmpwi 0,3,0
	bc 12,2,.L483
	li 0,1
	stw 0,52(1)
.L483:
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
	lis 9,.LC198@ha
	lwz 11,8(1)
	lis 7,.LC196@ha
	la 9,.LC198@l(9)
	lwz 10,4(29)
	lis 8,.LC186@ha
	lfd 12,0(9)
	la 7,.LC196@l(7)
	mr 12,24
	lwz 0,8(29)
	mr 4,25
	mr 5,23
	lwz 9,12(29)
	mr 26,22
	lis 3,0x4330
	stw 10,4(28)
	li 6,0
	stw 11,0(28)
	li 10,3
	stw 0,8(28)
	mtctr 10
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
	stw 0,3484(28)
	stw 9,4(27)
	stw 11,8(27)
	stw 10,12(27)
	lwz 11,24(29)
	lwz 0,16(29)
	lwz 9,20(29)
	lfd 11,.LC186@l(8)
	lfd 13,0(7)
	li 7,0
	stw 11,24(27)
	stw 0,16(27)
	stw 9,20(27)
.L545:
	lhax 0,6,12
	xoris 0,0,0x8000
	stw 0,252(1)
	stw 3,248(1)
	lfd 0,248(1)
	fsub 0,0,13
	fmul 0,0,12
	frsp 0,0
	stfsx 0,7,26
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L488
	lwz 0,912(31)
	cmpwi 0,0,0
	bc 4,2,.L486
	lhax 0,6,5
	xoris 0,0,0x8000
	stw 0,252(1)
	stw 3,248(1)
	lfd 0,248(1)
	fsub 0,0,13
	fmul 0,0,11
	b .L547
.L488:
	lhax 0,6,5
	xoris 0,0,0x8000
	stw 0,252(1)
	stw 3,248(1)
	lfd 0,248(1)
	fsub 0,0,13
	fmul 0,0,12
.L547:
	frsp 0,0
	stfsx 0,7,4
.L486:
	addi 6,6,2
	addi 7,7,4
	bdnz .L545
	lfs 0,216(1)
	lis 8,0x4330
	lfs 13,220(1)
	lis 11,.LC196@ha
	lis 7,.LC185@ha
	lfs 8,204(1)
	la 11,.LC196@l(11)
	mr 10,9
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
	lfd 13,.LC185@l(7)
	mr 11,9
	stw 0,252(1)
	stw 8,248(1)
	lfd 0,248(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3468(28)
	lha 0,4(30)
	xoris 0,0,0x8000
	stw 0,252(1)
	stw 8,248(1)
	lfd 0,248(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3472(28)
	lha 0,6(30)
	xoris 0,0,0x8000
	stw 0,252(1)
	stw 8,248(1)
	lfd 0,248(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3476(28)
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L492
	lwz 0,228(1)
	cmpwi 0,0,0
	bc 4,2,.L492
	lha 0,48(1)
	cmpwi 0,0,9
	bc 4,1,.L492
	lwz 0,236(1)
	cmpwi 0,0,0
	bc 4,2,.L492
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L493
	lis 29,gi@ha
	lis 3,.LC187@ha
	la 29,gi@l(29)
	la 3,.LC187@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC199@ha
	lis 9,.LC199@ha
	lis 10,.LC194@ha
	mr 5,3
	la 7,.LC199@l(7)
	la 9,.LC199@l(9)
	mtlr 0
	la 10,.LC194@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L494
.L493:
	lis 29,gi@ha
	lis 3,.LC188@ha
	la 29,gi@l(29)
	la 3,.LC188@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC199@ha
	lis 9,.LC199@ha
	lis 10,.LC194@ha
	mr 5,3
	la 7,.LC199@l(7)
	la 9,.LC199@l(9)
	mtlr 0
	la 10,.LC194@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L494:
	mr 4,22
	mr 3,31
	li 5,0
	bl PlayerNoise
.L492:
	lfs 0,200(1)
	lwz 10,228(1)
	lwz 0,236(1)
	lwz 11,232(1)
	cmpwi 0,10,0
	stw 0,612(31)
	stw 11,608(31)
	fctiwz 13,0
	stw 10,552(31)
	stfd 13,248(1)
	lwz 9,252(1)
	stw 9,508(31)
	bc 12,2,.L495
	lwz 0,92(10)
	stw 0,556(31)
.L495:
	lwz 0,912(31)
	cmpwi 0,0,0
	bc 4,2,.L496
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L497
	lfs 0,3580(28)
	lis 0,0x4220
	lis 9,0xc170
	stw 0,36(28)
	stw 9,28(28)
	stfs 0,32(28)
	b .L496
.L497:
	lfs 0,188(1)
	stfs 0,3652(28)
	lfs 13,192(1)
	stfs 13,3656(28)
	lfs 0,196(1)
	stfs 0,3660(28)
	lfs 13,188(1)
	stfs 13,28(28)
	lfs 0,192(1)
	stfs 0,32(28)
	lfs 13,196(1)
	stfs 13,36(28)
.L496:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L499
	mr 3,31
	bl G_TouchTriggers
.L499:
	lwz 0,56(1)
	li 29,0
	cmpw 0,29,0
	bc 4,0,.L470
	addi 27,1,60
.L503:
	li 11,0
	slwi 0,29,2
	cmpw 0,11,29
	lwzx 3,27,0
	addi 26,29,1
	bc 4,0,.L505
	lwz 0,0(27)
	cmpw 0,0,3
	bc 12,2,.L505
	mr 9,27
.L506:
	addi 11,11,1
	cmpw 0,11,29
	bc 4,0,.L505
	lwzu 0,4(9)
	cmpw 0,0,3
	bc 4,2,.L506
.L505:
	cmpw 0,11,29
	bc 4,2,.L502
	lwz 0,444(3)
	cmpwi 0,0,0
	bc 12,2,.L502
	mr 4,31
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L502:
	lwz 0,56(1)
	mr 29,26
	cmpw 0,29,0
	bc 12,0,.L503
.L470:
	lwz 0,3532(28)
	lwz 11,3540(28)
	stw 0,3536(28)
	lbz 9,1(30)
	andc 0,9,0
	stw 9,3532(28)
	or 11,11,0
	stw 11,3540(28)
	lbz 0,15(30)
	stw 0,640(31)
	lwz 9,3540(28)
	andi. 0,9,1
	bc 12,2,.L513
	lwz 9,912(31)
	cmpwi 0,9,0
	bc 4,2,.L513
	lwz 0,3480(28)
	cmpwi 0,0,0
	bc 12,2,.L514
	lwz 0,3812(28)
	stw 9,3540(28)
	cmpwi 0,0,0
	bc 12,2,.L515
	lbz 0,16(28)
	stw 9,3812(28)
	andi. 0,0,191
	stb 0,16(28)
	b .L513
.L515:
	lis 11,level+4@ha
	lwz 0,924(31)
	lfs 0,level+4@l(11)
	fctiwz 13,0
	stfd 13,248(1)
	lwz 9,252(1)
	cmpw 0,0,9
	bc 4,1,.L517
	mr 3,31
	bl ClearMOTD
	b .L513
.L517:
	mr 3,31
	bl GetChaseTarget
	b .L513
.L514:
	lwz 0,3544(28)
	cmpwi 0,0,0
	bc 4,2,.L513
	li 0,1
	mr 3,31
	stw 0,3544(28)
	bl Think_Weapon
.L513:
	lwz 0,3480(28)
	cmpwi 0,0,0
	bc 12,2,.L521
	lha 0,12(30)
	cmpwi 0,0,9
	bc 4,1,.L522
	lbz 0,16(28)
	andi. 7,0,2
	bc 4,2,.L521
	lwz 9,3812(28)
	ori 0,0,2
	stb 0,16(28)
	cmpwi 0,9,0
	bc 12,2,.L524
	mr 3,31
	bl ChaseNext
	b .L521
.L524:
	mr 3,31
	bl GetChaseTarget
	b .L521
.L522:
	lbz 0,16(28)
	andi. 0,0,253
	stb 0,16(28)
.L521:
	lis 9,maxclients@ha
	lis 7,.LC199@ha
	lwz 11,maxclients@l(9)
	la 7,.LC199@l(7)
	li 29,1
	lfs 13,0(7)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L528
	lis 9,.LC196@ha
	lis 26,g_edicts@ha
	la 9,.LC196@l(9)
	lis 30,0x4330
	lfd 31,0(9)
	li 27,952
.L530:
	lwz 0,g_edicts@l(26)
	add 3,0,27
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L529
	lwz 9,84(3)
	lwz 0,3812(9)
	cmpw 0,0,31
	bc 4,2,.L529
	bl UpdateChaseCam
.L529:
	addi 29,29,1
	lwz 11,maxclients@l(21)
	xoris 0,29,0x8000
	addi 27,27,952
	stw 0,252(1)
	stw 30,248(1)
	lfd 0,248(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L530
.L528:
	lis 9,level@ha
	la 25,level@l(9)
	lis 10,0x4330
	lwz 0,304(25)
	lis 7,.LC196@ha
	la 7,.LC196@l(7)
	lfs 12,4(25)
	xoris 0,0,0x8000
	lfd 13,0(7)
	stw 0,252(1)
	stw 10,248(1)
	lfd 0,248(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 4,3,.L533
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L533
	lwz 0,912(31)
	cmpwi 0,0,0
	bc 4,2,.L533
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L533
	lwz 9,480(31)
	addi 9,9,10
	cmpwi 0,9,200
	stw 9,480(31)
	bc 4,1,.L534
	li 0,200
	stw 0,480(31)
.L534:
	lis 30,.LC189@ha
	lis 29,0x286b
	la 3,.LC189@l(30)
	ori 29,29,51739
	bl FindItem
	addi 27,28,740
	lis 9,itemlist@ha
	lwz 11,1772(28)
	la 26,itemlist@l(9)
	subf 3,26,3
	mullw 3,3,29
	rlwinm 3,3,0,0,29
	lwzx 0,27,3
	cmpw 0,0,11
	bc 4,0,.L535
	la 3,.LC189@l(30)
	bl FindItem
	subf 3,26,3
	mullw 3,3,29
	rlwinm 3,3,0,0,29
	lwzx 9,27,3
	addi 9,9,1
	stwx 9,27,3
.L535:
	lis 30,.LC190@ha
	la 3,.LC190@l(30)
	bl FindItem
	subf 3,26,3
	lwz 9,1784(28)
	mullw 3,3,29
	rlwinm 3,3,0,0,29
	lwzx 0,27,3
	cmpw 0,0,9
	bc 4,0,.L536
	la 3,.LC190@l(30)
	bl FindItem
	subf 3,26,3
	mullw 3,3,29
	rlwinm 3,3,0,0,29
	lwzx 9,27,3
	addi 9,9,1
	stwx 9,27,3
.L536:
	lis 7,.LC200@ha
	lfs 0,4(25)
	la 7,.LC200@l(7)
	lfs 12,0(7)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,248(1)
	lwz 9,252(1)
	stw 9,304(25)
.L533:
	lwz 0,908(31)
	lis 29,0x4330
	lis 10,.LC196@ha
	lis 11,level@ha
	xoris 0,0,0x8000
	la 10,.LC196@l(10)
	stw 0,252(1)
	la 30,level@l(11)
	stw 29,248(1)
	lfd 0,248(1)
	lfd 30,0(10)
	lfs 31,4(30)
	fsub 0,0,30
	frsp 0,0
	fsubs 31,31,0
	bl getMaxTime
	xoris 3,3,0x8000
	stw 3,252(1)
	stw 29,248(1)
	lfd 0,248(1)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,31,0
	bc 4,1,.L537
	li 0,0
	stw 0,904(31)
.L537:
	lfs 0,4(30)
	lwz 11,312(30)
	fctiwz 13,0
	stfd 13,248(1)
	lwz 9,252(1)
	cmpw 0,11,9
	bc 12,0,.L538
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L538
	lwz 0,912(31)
	cmpwi 0,0,0
	bc 12,2,.L538
	addi 0,11,-4
	cmpw 0,0,9
	bc 4,2,.L539
	lwz 0,320(30)
	cmpwi 0,0,0
	bc 4,2,.L539
	li 0,1
	stw 0,320(30)
.L539:
	lis 9,level@ha
	la 30,level@l(9)
	lfs 0,4(30)
	lwz 9,312(30)
	addi 9,9,-3
	fctiwz 13,0
	stfd 13,248(1)
	lwz 11,252(1)
	cmpw 0,9,11
	bc 4,2,.L540
	lwz 0,324(30)
	cmpwi 0,0,0
	bc 4,2,.L540
	lis 9,g_edicts@ha
	lis 0,0x46fd
	lwz 28,84(31)
	lwz 29,g_edicts@l(9)
	ori 0,0,55623
	lis 27,gi@ha
	la 27,gi@l(27)
	addi 28,28,700
	subf 29,29,31
	li 26,1
	mullw 29,29,0
	srawi 29,29,3
	addi 29,29,1311
	bl getLivePredatorSkin
	mr 5,3
	mr 4,28
	lis 3,.LC191@ha
	la 3,.LC191@l(3)
	crxor 6,6,6
	bl va
	lwz 9,24(27)
	mr 4,3
	mr 3,29
	mtlr 9
	blrl
	lwz 9,84(31)
	li 0,71
	li 11,83
	lis 3,.LC192@ha
	stw 26,3712(9)
	la 3,.LC192@l(3)
	lwz 9,84(31)
	stw 0,56(31)
	stw 11,3708(9)
	lwz 9,36(27)
	mtlr 9
	blrl
	lwz 0,16(27)
	lis 7,.LC199@ha
	lis 9,.LC199@ha
	lis 10,.LC194@ha
	mr 5,3
	la 7,.LC199@l(7)
	la 9,.LC199@l(9)
	mtlr 0
	la 10,.LC194@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	stw 26,324(30)
.L540:
	lis 9,level@ha
	la 10,level@l(9)
	lfs 0,4(10)
	lwz 9,312(10)
	addi 9,9,-2
	fctiwz 13,0
	stfd 13,248(1)
	lwz 11,252(1)
	cmpw 0,9,11
	bc 4,2,.L538
	lwz 0,328(10)
	cmpwi 0,0,0
	bc 4,2,.L538
	lis 29,gi@ha
	lis 3,.LC193@ha
	la 29,gi@l(29)
	la 3,.LC193@l(3)
	lwz 9,36(29)
	li 0,1
	stw 0,328(10)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC199@ha
	lis 9,.LC201@ha
	lis 10,.LC194@ha
	mr 5,3
	la 7,.LC199@l(7)
	la 9,.LC201@l(9)
	mtlr 0
	la 10,.LC194@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L538:
	lis 9,level@ha
	la 9,level@l(9)
	lis 10,0x4330
	lwz 8,312(9)
	lis 7,.LC196@ha
	la 7,.LC196@l(7)
	lfs 12,4(9)
	xoris 0,8,0x8000
	lfd 13,0(7)
	stw 0,252(1)
	stw 10,248(1)
	lfd 0,248(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	cror 3,2,1
	bc 4,3,.L542
	cmpwi 0,8,0
	bc 12,2,.L542
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L542
	lwz 0,912(31)
	cmpwi 0,0,0
	bc 12,2,.L542
	li 0,0
	mr 3,31
	stw 0,312(9)
	bl startPredator
.L542:
	lis 11,level+4@ha
	lwz 0,920(31)
	lfs 0,level+4@l(11)
	fctiwz 13,0
	stfd 13,248(1)
	lwz 9,252(1)
	cmpw 0,9,0
	bc 12,0,.L465
	cmpwi 0,0,0
	bc 12,2,.L465
	lwz 9,932(31)
	li 0,0
	stw 0,920(31)
	cmpwi 0,9,0
	bc 12,2,.L465
	mr 3,31
	bl ShowMOTD
.L465:
	lwz 0,324(1)
	mtlr 0
	lmw 20,256(1)
	lfd 30,304(1)
	lfd 31,312(1)
	la 1,320(1)
	blr
.Lfe18:
	.size	 ClientThink,.Lfe18-ClientThink
	.section	".rodata"
	.align 2
.LC202:
	.string	"rate"
	.align 2
.LC203:
	.string	"\nServer enforcing max rate of %s\n"
	.align 2
.LC204:
	.string	"rate %s\n"
	.align 2
.LC205:
	.long 0x0
	.align 2
.LC206:
	.long 0x40a00000
	.align 3
.LC207:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ClientBeginServerFrame
	.type	 ClientBeginServerFrame,@function
ClientBeginServerFrame:
	stwu 1,-64(1)
	mflr 0
	stmw 30,56(1)
	stw 0,68(1)
	lis 10,.LC205@ha
	lis 9,level@ha
	la 10,.LC205@l(10)
	mr 31,3
	lfs 13,0(10)
	la 10,level@l(9)
	lfs 0,200(10)
	fcmpu 0,0,13
	bc 4,2,.L548
	lis 9,deathmatch@ha
	lwz 30,84(31)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L550
	lwz 9,1812(30)
	lwz 0,3480(30)
	cmpw 0,9,0
	bc 12,2,.L550
	lwz 0,928(31)
	cmpwi 0,0,0
	bc 4,2,.L552
	lfs 0,4(10)
	lis 11,.LC206@ha
	lfs 13,3808(30)
	la 11,.LC206@l(11)
	lfs 12,0(11)
	fsubs 0,0,13
	fcmpu 0,0,12
	cror 3,2,1
	bc 4,3,.L550
.L552:
	mr 3,31
	bl spectator_respawn
	lwz 0,928(31)
	cmpwi 0,0,0
	bc 12,2,.L550
	li 0,0
	stw 0,928(31)
.L550:
	lwz 0,3544(30)
	cmpwi 0,0,0
	bc 4,2,.L554
	lwz 0,3480(30)
	cmpwi 0,0,0
	bc 4,2,.L554
	mr 3,31
	bl Think_Weapon
	b .L555
.L554:
	li 0,0
	stw 0,3544(30)
.L555:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L556
	lwz 0,912(31)
	cmpwi 0,0,0
	bc 4,2,.L556
	lwz 0,932(31)
	cmpwi 0,0,0
	bc 4,2,.L556
	lis 9,level+4@ha
	lfs 13,3808(30)
	lfs 0,level+4@l(9)
	fcmpu 0,0,13
	bc 4,1,.L548
	lis 9,.LC205@ha
	lis 11,deathmatch@ha
	lwz 10,3540(30)
	la 9,.LC205@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 7,0,13
	mfcr 0
	rlwinm 0,0,31,1
	neg 0,0
	ori 0,0,1
	and. 11,10,0
	bc 4,2,.L561
	bc 12,30,.L562
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,48(1)
	lwz 11,52(1)
	andi. 0,11,1024
	bc 4,2,.L561
.L562:
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 12,2,.L548
.L561:
	lis 9,deathmatch@ha
	lis 10,.LC205@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC205@l(10)
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L563
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L564
.L563:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L565
	mr 3,31
	bl CopyToBodyQue
.L565:
	lwz 0,184(31)
	mr 3,31
	rlwinm 0,0,0,0,30
	stw 0,184(31)
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
	stfs 0,3808(11)
	b .L566
.L564:
	lis 9,gi+168@ha
	lis 3,.LC132@ha
	lwz 0,gi+168@l(9)
	la 3,.LC132@l(3)
	mtlr 0
	blrl
.L566:
	li 0,0
	stw 0,3540(30)
	b .L548
.L556:
	lis 9,.LC205@ha
	lis 11,deathmatch@ha
	la 9,.LC205@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L568
	bl PlayerTrail_LastSpot
	mr 4,3
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L568
	addi 3,31,28
	bl PlayerTrail_Add
.L568:
	li 0,0
	stw 0,3540(30)
	bl getMaxRate
	cmpwi 0,3,0
	bc 4,1,.L548
	lwz 3,84(31)
	lis 4,.LC202@ha
	lis 30,maxrate@ha
	la 4,.LC202@l(4)
	addi 3,3,188
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	lwz 11,maxrate@l(30)
	stw 3,52(1)
	lis 0,0x4330
	lis 10,.LC207@ha
	la 10,.LC207@l(10)
	stw 0,48(1)
	lfd 13,0(10)
	lfd 0,48(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,1,.L548
	lis 9,gi+8@ha
	lis 5,.LC203@ha
	lwz 6,4(11)
	lwz 0,gi+8@l(9)
	la 5,.LC203@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,maxrate@l(30)
	lis 5,.LC204@ha
	addi 3,1,8
	li 4,20
	la 5,.LC204@l(5)
	lwz 6,4(9)
	crxor 6,6,6
	bl Com_sprintf
	mr 3,31
	addi 4,1,8
	bl stuffcmd
.L548:
	lwz 0,68(1)
	mtlr 0
	lmw 30,56(1)
	la 1,64(1)
	blr
.Lfe19:
	.size	 ClientBeginServerFrame,.Lfe19-ClientBeginServerFrame
	.comm	showscores,4,4
	.comm	nextdynamicset,4,4
	.comm	predatorModel,32,4
	.comm	predatorSkin,64,4
	.comm	marineSkin,64,4
	.comm	maplist_lastmap,64,4
	.comm	maplist2_lastmap,64,4
	.comm	maplist3_lastmap,64,4
	.comm	last_beat,4,4
	.section	".rodata"
	.align 2
.LC208:
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
	lis 11,.LC208@ha
	lis 9,deathmatch@ha
	la 11,.LC208@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L340
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L339
.L340:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L341
	mr 3,31
	bl CopyToBodyQue
.L341:
	lwz 0,184(31)
	mr 3,31
	rlwinm 0,0,0,0,30
	stw 0,184(31)
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
	stfs 0,3808(11)
	b .L338
.L339:
	lis 9,gi+168@ha
	lis 3,.LC132@ha
	lwz 0,gi+168@l(9)
	la 3,.LC132@l(3)
	mtlr 0
	blrl
.L338:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe20:
	.size	 respawn,.Lfe20-respawn
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
	addi 28,29,1824
	li 5,1660
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,28
	lwz 0,level@l(9)
	addi 4,29,188
	li 5,1636
	stw 0,3460(29)
	crxor 6,6,6
	bl memcpy
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
	lis 11,.LC131@ha
	stw 0,level+296@l(9)
	li 31,8
	la 30,.LC131@l(11)
.L328:
	bl G_Spawn
	addic. 31,31,-1
	stw 30,280(3)
	bc 4,2,.L328
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
.LC209:
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
	lis 9,.LC209@ha
	lwz 5,coop@l(11)
	li 7,0
	la 9,.LC209@l(9)
	addi 10,10,952
	lfs 13,0(9)
.L222:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L221
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
	bc 12,2,.L221
	lwz 9,84(10)
	lwz 11,1028(8)
	lwz 0,3464(9)
	add 11,7,11
	stw 0,1800(11)
.L221:
	lwz 0,1544(3)
	addi 6,6,1
	addi 7,7,3868
	addi 10,10,952
	cmpw 0,6,0
	bc 12,0,.L222
	blr
.Lfe24:
	.size	 SaveClientData,.Lfe24-SaveClientData
	.section	".rodata"
	.align 2
.LC210:
	.long 0x0
	.section	".text"
	.align 2
	.globl FetchClientEntData
	.type	 FetchClientEntData,@function
FetchClientEntData:
	lis 9,.LC210@ha
	lwz 7,84(3)
	lis 10,coop@ha
	la 9,.LC210@l(9)
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
	lwz 0,1800(7)
	stw 0,3464(7)
	blr
.Lfe25:
	.size	 FetchClientEntData,.Lfe25-FetchClientEntData
	.comm	IR_type_dropped,4,4
	.section	".rodata"
	.align 2
.LC211:
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
	lis 9,.LC211@ha
	mr 30,3
	la 9,.LC211@l(9)
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
.LC212:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC213:
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
	lis 11,.LC213@ha
	lis 9,coop@ha
	la 11,.LC213@l(11)
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
	lis 11,.LC212@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC212@l(11)
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
.LC214:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_player_deathmatch
	.type	 SP_info_player_deathmatch,@function
SP_info_player_deathmatch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC214@ha
	lis 9,deathmatch@ha
	la 11,.LC214@l(11)
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
	b .L572
.L30:
	li 3,0
.L572:
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
	bc 4,2,.L573
.L34:
	li 3,0
.L573:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe31:
	.size	 IsNeutral,.Lfe31-IsNeutral
	.section	".rodata"
	.align 2
.LC215:
	.long 0x4b18967f
	.align 2
.LC216:
	.long 0x3f800000
	.align 3
.LC217:
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
	lis 11,.LC216@ha
	lwz 10,maxclients@l(9)
	la 11,.LC216@l(11)
	mr 31,3
	lfs 13,0(11)
	li 29,1
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC215@ha
	lfs 31,.LC215@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L230
	lis 9,.LC217@ha
	lis 27,g_edicts@ha
	la 9,.LC217@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,952
.L232:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L231
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L231
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
	bc 4,0,.L231
	fmr 31,1
.L231:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,952
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L232
.L230:
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
	bc 4,2,.L281
	bl SelectRandomDeathmatchSpawnPoint
	b .L575
.L281:
	bl SelectFarthestDeathmatchSpawnPoint
.L575:
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
	lis 9,0xf5a
	lwz 10,game+1028@l(11)
	ori 9,9,52727
	li 30,0
	li 3,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,2
	bc 12,2,.L576
.L287:
	lis 5,.LC2@ha
	mr 3,30
	la 5,.LC2@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L288
	li 3,0
	b .L576
.L288:
	lwz 4,300(30)
	cmpwi 0,4,0
	bc 4,2,.L289
	lis 9,.LC22@ha
	la 4,.LC22@l(9)
.L289:
	lis 3,game+1032@ha
	la 3,game+1032@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L287
	addic. 31,31,-1
	bc 4,2,.L287
	mr 3,30
.L576:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe34:
	.size	 SelectCoopSpawnPoint,.Lfe34-SelectCoopSpawnPoint
	.section	".rodata"
	.align 2
.LC218:
	.long 0x3f800000
	.align 2
.LC219:
	.long 0x0
	.align 2
.LC220:
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
	bc 4,0,.L331
	lis 29,gi@ha
	lis 3,.LC109@ha
	la 29,gi@l(29)
	la 3,.LC109@l(3)
	lwz 9,36(29)
	lis 27,.LC110@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC218@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC218@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC218@ha
	la 9,.LC218@l(9)
	lfs 2,0(9)
	lis 9,.LC219@ha
	la 9,.LC219@l(9)
	lfs 3,0(9)
	blrl
.L335:
	mr 3,31
	la 4,.LC110@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L335
	lis 9,.LC220@ha
	lfs 0,12(31)
	mr 4,28
	la 9,.LC220@l(9)
	mr 3,31
	lfs 13,0(9)
	fsubs 0,0,13
	stfs 0,12(31)
	bl ThrowClientHead
	stw 30,512(31)
.L331:
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
	bc 4,1,.L444
	lis 11,gi+48@ha
	lis 9,0x201
	lwz 0,gi+48@l(11)
	ori 9,9,3
	mtlr 0
	blrl
	b .L443
.L444:
	lis 11,gi+48@ha
	lis 9,0x1
	lwz 0,gi+48@l(11)
	mr 3,31
	ori 9,9,3
	mtlr 0
	blrl
.L443:
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
	bc 4,0,.L448
.L450:
	lbzx 0,3,9
	addi 9,9,1
	cmpw 0,9,4
	add 11,11,0
	bc 12,0,.L450
.L448:
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
.L578:
	lbzx 0,3,9
	addi 9,9,1
	add 5,5,0
	bdnz .L578
	li 0,16
	lbz 4,42(3)
	li 6,0
	mtctr 0
	addi 3,3,28
	li 9,0
.L577:
	lbzx 0,3,9
	addi 9,9,1
	add 6,6,0
	bdnz .L577
	lis 3,.LC183@ha
	la 3,.LC183@l(3)
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
