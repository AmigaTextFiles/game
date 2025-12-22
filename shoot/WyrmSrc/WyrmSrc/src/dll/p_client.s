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
	.string	"burned herself"
	.align 2
.LC43:
	.string	"burned himself"
	.align 2
.LC44:
	.string	"became toast"
	.align 2
.LC45:
	.string	"discharges into the water"
	.align 2
.LC46:
	.string	"killed itself"
	.align 2
.LC47:
	.string	"killed herself"
	.align 2
.LC48:
	.string	"killed himself"
	.align 2
.LC49:
	.string	"%s %s.\n"
	.align 2
.LC50:
	.string	"was blasted by"
	.align 2
.LC51:
	.string	"was gunned down by"
	.align 2
.LC52:
	.string	"was blown away by"
	.align 2
.LC53:
	.string	"'s super shotgun"
	.align 2
.LC54:
	.string	"was machinegunned by"
	.align 2
.LC55:
	.string	"was cut in half by"
	.align 2
.LC56:
	.string	"'s chaingun"
	.align 2
.LC57:
	.string	"was popped by"
	.align 2
.LC58:
	.string	"'s grenade"
	.align 2
.LC59:
	.string	"was shredded by"
	.align 2
.LC60:
	.string	"'s shrapnel"
	.align 2
.LC61:
	.string	"ate"
	.align 2
.LC62:
	.string	"'s rocket"
	.align 2
.LC63:
	.string	"almost dodged"
	.align 2
.LC64:
	.string	"was melted by"
	.align 2
.LC65:
	.string	"'s hyperblaster"
	.align 2
.LC66:
	.string	"was railed by"
	.align 2
.LC67:
	.string	"saw the pretty lights from"
	.align 2
.LC68:
	.string	"'s BFG"
	.align 2
.LC69:
	.string	"was disintegrated by"
	.align 2
.LC70:
	.string	"'s BFG blast"
	.align 2
.LC71:
	.string	"couldn't hide from"
	.align 2
.LC72:
	.string	"caught"
	.align 2
.LC73:
	.string	"'s handgrenade"
	.align 2
.LC74:
	.string	"didn't see"
	.align 2
.LC75:
	.string	"feels"
	.align 2
.LC76:
	.string	"'s pain"
	.align 2
.LC77:
	.string	"tried to invade"
	.align 2
.LC78:
	.string	"'s personal space"
	.align 2
.LC79:
	.string	"was caught by"
	.align 2
.LC80:
	.string	"'s grapple"
	.align 2
.LC81:
	.string	"was scorched by"
	.align 2
.LC82:
	.string	"was cremated by"
	.align 2
.LC83:
	.string	"got flamed by"
	.align 2
.LC84:
	.string	"took one bullet too many from"
	.align 2
.LC85:
	.string	"'s pistol"
	.align 2
.LC86:
	.string	"was killed by"
	.align 2
.LC87:
	.string	"'s wind!"
	.align 2
.LC88:
	.string	"was pulverized by"
	.align 2
.LC89:
	.string	"'s explosive bullets"
	.align 2
.LC90:
	.string	"gets ripped apart by"
	.align 2
.LC91:
	.string	"'s pulse rifle"
	.align 2
.LC92:
	.string	"was fried by"
	.align 2
.LC93:
	.string	" has his insides now on the outside, thanx to "
	.align 2
.LC94:
	.string	"'s Street Sweeper"
	.align 2
.LC95:
	.string	"was bombed by"
	.align 2
.LC96:
	.string	"'s cluster grenades"
	.align 2
.LC97:
	.string	"'s legs were blow off by"
	.align 2
.LC98:
	.string	"'s RailBomb"
	.align 2
.LC99:
	.string	"was detonated by"
	.align 2
.LC100:
	.string	"'s grenades"
	.align 2
.LC101:
	.string	"came face to face with"
	.align 2
.LC102:
	.string	"'s green grenade"
	.align 2
.LC103:
	.string	" was hunted down by "
	.align 2
.LC104:
	.string	"'s guided missile"
	.align 2
.LC105:
	.string	" got a taste of plasma from "
	.align 2
.LC106:
	.string	"was annihilated by"
	.align 2
.LC107:
	.string	"'s disruptor"
	.align 2
.LC108:
	.string	" was reaped apart by "
	.align 2
.LC109:
	.string	"'s antimatter cannon"
	.align 2
.LC110:
	.string	" is annhilated by "
	.align 2
.LC111:
	.string	"'s positron beam."
	.align 2
.LC112:
	.string	"tripped over"
	.align 2
.LC113:
	.string	"'s Tripbomb"
	.align 2
.LC114:
	.string	"'s Laser Tripwire"
	.align 2
.LC115:
	.string	"was nailed by"
	.align 2
.LC116:
	.string	"was punctured by"
	.align 2
.LC117:
	.string	"was purged by"
	.align 2
.LC118:
	.string	"'s Vacuum Maker"
	.align 2
.LC119:
	.string	"visits"
	.align 2
.LC120:
	.string	"'s new dimension."
	.align 2
.LC121:
	.string	"accepts"
	.align 2
.LC122:
	.string	" discharge"
	.align 2
.LC123:
	.string	" shaft"
	.align 2
.LC124:
	.string	"was perforated by"
	.align 2
.LC125:
	.string	"'s rocket."
	.align 2
.LC126:
	.string	"was nuked by"
	.align 2
.LC127:
	.string	"%s %s %s%s\n"
	.align 2
.LC128:
	.string	"%s died.\n"
	.align 2
.LC129:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientObituary
	.type	 ClientObituary,@function
ClientObituary:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,coop@ha
	lis 8,.LC129@ha
	lwz 11,coop@l(9)
	la 8,.LC129@l(8)
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
	lis 11,.LC129@ha
	lis 9,deathmatch@ha
	la 11,.LC129@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L39
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L38
.L39:
	lis 9,meansOfDeath@ha
	lis 11,.LC22@ha
	lwz 0,meansOfDeath@l(9)
	la 31,.LC22@l(11)
	li 6,0
	rlwinm 28,0,0,5,3
	rlwinm 27,0,0,4,4
	addi 10,28,-17
	cmplwi 0,10,16
	bc 12,1,.L40
	lis 11,.L55@ha
	slwi 10,10,2
	la 11,.L55@l(11)
	lis 9,.L55@ha
	lwzx 0,10,11
	la 9,.L55@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L55:
	.long .L44-.L55
	.long .L45-.L55
	.long .L46-.L55
	.long .L43-.L55
	.long .L40-.L55
	.long .L42-.L55
	.long .L41-.L55
	.long .L40-.L55
	.long .L48-.L55
	.long .L48-.L55
	.long .L54-.L55
	.long .L49-.L55
	.long .L54-.L55
	.long .L50-.L55
	.long .L54-.L55
	.long .L40-.L55
	.long .L51-.L55
.L41:
	lis 9,.LC23@ha
	la 6,.LC23@l(9)
	b .L40
.L42:
	lis 9,.LC24@ha
	la 6,.LC24@l(9)
	b .L40
.L43:
	lis 9,.LC25@ha
	la 6,.LC25@l(9)
	b .L40
.L44:
	lis 9,.LC26@ha
	la 6,.LC26@l(9)
	b .L40
.L45:
	lis 9,.LC27@ha
	la 6,.LC27@l(9)
	b .L40
.L46:
	lis 9,.LC28@ha
	la 6,.LC28@l(9)
	b .L40
.L48:
	lis 9,.LC29@ha
	la 6,.LC29@l(9)
	b .L40
.L49:
	lis 9,.LC30@ha
	la 6,.LC30@l(9)
	b .L40
.L50:
	lis 9,.LC31@ha
	la 6,.LC31@l(9)
	b .L40
.L51:
	lis 9,.LC32@ha
	la 6,.LC32@l(9)
	b .L40
.L54:
	lis 9,.LC33@ha
	la 6,.LC33@l(9)
.L40:
	cmpw 0,29,30
	bc 4,2,.L57
	addi 10,28,-7
	cmplwi 0,10,62
	bc 12,1,.L98
	lis 11,.L109@ha
	slwi 10,10,2
	la 11,.L109@l(11)
	lis 9,.L109@ha
	lwzx 0,10,11
	la 9,.L109@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L109:
	.long .L66-.L109
	.long .L98-.L109
	.long .L77-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L88-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L66-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L59-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L66-.L109
	.long .L66-.L109
	.long .L66-.L109
	.long .L98-.L109
	.long .L66-.L109
	.long .L66-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L90-.L109
	.long .L96-.L109
	.long .L90-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L98-.L109
	.long .L97-.L109
.L59:
	lis 9,.LC34@ha
	la 6,.LC34@l(9)
	b .L57
.L66:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L68
	li 10,0
	b .L69
.L68:
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
	bc 12,2,.L69
	cmpwi 0,11,109
	bc 12,2,.L69
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L69:
	cmpwi 0,10,0
	bc 12,2,.L67
	lis 9,.LC35@ha
	la 6,.LC35@l(9)
	b .L57
.L67:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L73
	li 0,0
	b .L74
.L73:
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
.L74:
	cmpwi 0,0,0
	bc 12,2,.L72
	lis 9,.LC36@ha
	la 6,.LC36@l(9)
	b .L57
.L72:
	lis 9,.LC37@ha
	la 6,.LC37@l(9)
	b .L57
.L77:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L79
	li 10,0
	b .L80
.L79:
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
	bc 12,2,.L80
	cmpwi 0,11,109
	bc 12,2,.L80
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L80:
	cmpwi 0,10,0
	bc 12,2,.L78
	lis 9,.LC38@ha
	la 6,.LC38@l(9)
	b .L57
.L78:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L84
	li 0,0
	b .L85
.L84:
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
.L85:
	cmpwi 0,0,0
	bc 12,2,.L83
	lis 9,.LC39@ha
	la 6,.LC39@l(9)
	b .L57
.L83:
	lis 9,.LC40@ha
	la 6,.LC40@l(9)
	b .L57
.L88:
	lis 9,.LC41@ha
	la 6,.LC41@l(9)
	b .L57
.L90:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L92
	li 0,0
	b .L93
.L92:
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
.L93:
	cmpwi 0,0,0
	bc 12,2,.L91
	lis 9,.LC42@ha
	la 6,.LC42@l(9)
	b .L57
.L91:
	lis 9,.LC43@ha
	la 6,.LC43@l(9)
	b .L57
.L96:
	lis 9,.LC44@ha
	la 6,.LC44@l(9)
	b .L57
.L97:
	lis 9,.LC45@ha
	la 6,.LC45@l(9)
	b .L57
.L98:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L100
	li 10,0
	b .L101
.L100:
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
	bc 12,2,.L101
	cmpwi 0,11,109
	bc 12,2,.L101
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L101:
	cmpwi 0,10,0
	bc 12,2,.L99
	lis 9,.LC46@ha
	la 6,.LC46@l(9)
	b .L57
.L99:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L105
	li 0,0
	b .L106
.L105:
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
.L106:
	cmpwi 0,0,0
	bc 12,2,.L104
	lis 9,.LC47@ha
	la 6,.LC47@l(9)
	b .L57
.L104:
	lis 9,.LC48@ha
	la 6,.LC48@l(9)
.L57:
	cmpwi 0,6,0
	bc 12,2,.L110
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC49@ha
	lwz 0,gi@l(9)
	la 4,.LC49@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lis 11,deathmatch@ha
	lis 8,.LC129@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC129@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L111
	lwz 11,84(30)
	lwz 9,3480(11)
	addi 9,9,-1
	stw 9,3480(11)
.L111:
	li 0,0
	stw 0,540(30)
	b .L35
.L110:
	cmpwi 0,29,0
	stw 29,540(30)
	bc 12,2,.L38
	lwz 0,84(29)
	cmpwi 0,0,0
	mr 7,0
	bc 12,2,.L38
	addi 0,28,-1
	cmplwi 0,0,73
	bc 12,1,.L113
	lis 11,.L167@ha
	slwi 10,0,2
	la 11,.L167@l(11)
	lis 9,.L167@ha
	lwzx 0,10,11
	la 9,.L167@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L167:
	.long .L114-.L167
	.long .L115-.L167
	.long .L116-.L167
	.long .L117-.L167
	.long .L118-.L167
	.long .L119-.L167
	.long .L120-.L167
	.long .L121-.L167
	.long .L122-.L167
	.long .L123-.L167
	.long .L124-.L167
	.long .L125-.L167
	.long .L126-.L167
	.long .L127-.L167
	.long .L128-.L167
	.long .L129-.L167
	.long .L113-.L167
	.long .L113-.L167
	.long .L113-.L167
	.long .L113-.L167
	.long .L131-.L167
	.long .L113-.L167
	.long .L113-.L167
	.long .L130-.L167
	.long .L113-.L167
	.long .L113-.L167
	.long .L113-.L167
	.long .L113-.L167
	.long .L113-.L167
	.long .L113-.L167
	.long .L113-.L167
	.long .L113-.L167
	.long .L113-.L167
	.long .L113-.L167
	.long .L136-.L167
	.long .L113-.L167
	.long .L137-.L167
	.long .L113-.L167
	.long .L138-.L167
	.long .L139-.L167
	.long .L140-.L167
	.long .L141-.L167
	.long .L142-.L167
	.long .L143-.L167
	.long .L144-.L167
	.long .L113-.L167
	.long .L113-.L167
	.long .L146-.L167
	.long .L113-.L167
	.long .L147-.L167
	.long .L148-.L167
	.long .L149-.L167
	.long .L150-.L167
	.long .L151-.L167
	.long .L152-.L167
	.long .L153-.L167
	.long .L132-.L167
	.long .L113-.L167
	.long .L133-.L167
	.long .L134-.L167
	.long .L135-.L167
	.long .L154-.L167
	.long .L155-.L167
	.long .L156-.L167
	.long .L157-.L167
	.long .L166-.L167
	.long .L166-.L167
	.long .L160-.L167
	.long .L161-.L167
	.long .L162-.L167
	.long .L166-.L167
	.long .L164-.L167
	.long .L165-.L167
	.long .L166-.L167
.L114:
	lis 9,.LC50@ha
	la 6,.LC50@l(9)
	b .L113
.L115:
	lis 9,.LC51@ha
	la 6,.LC51@l(9)
	b .L113
.L116:
	lis 9,.LC52@ha
	lis 11,.LC53@ha
	la 6,.LC52@l(9)
	la 31,.LC53@l(11)
	b .L113
.L117:
	lis 9,.LC54@ha
	la 6,.LC54@l(9)
	b .L113
.L118:
	lis 9,.LC55@ha
	lis 11,.LC56@ha
	la 6,.LC55@l(9)
	la 31,.LC56@l(11)
	b .L113
.L119:
	lis 9,.LC57@ha
	lis 11,.LC58@ha
	la 6,.LC57@l(9)
	la 31,.LC58@l(11)
	b .L113
.L120:
	lis 9,.LC59@ha
	lis 11,.LC60@ha
	la 6,.LC59@l(9)
	la 31,.LC60@l(11)
	b .L113
.L121:
	lis 9,.LC61@ha
	lis 11,.LC62@ha
	la 6,.LC61@l(9)
	la 31,.LC62@l(11)
	b .L113
.L122:
	lis 9,.LC63@ha
	lis 11,.LC62@ha
	la 6,.LC63@l(9)
	la 31,.LC62@l(11)
	b .L113
.L123:
	lis 9,.LC64@ha
	lis 11,.LC65@ha
	la 6,.LC64@l(9)
	la 31,.LC65@l(11)
	b .L113
.L124:
	lis 9,.LC66@ha
	la 6,.LC66@l(9)
	b .L113
.L125:
	lis 9,.LC67@ha
	lis 11,.LC68@ha
	la 6,.LC67@l(9)
	la 31,.LC68@l(11)
	b .L113
.L126:
	lis 9,.LC69@ha
	lis 11,.LC70@ha
	la 6,.LC69@l(9)
	la 31,.LC70@l(11)
	b .L113
.L127:
	lis 9,.LC71@ha
	lis 11,.LC68@ha
	la 6,.LC71@l(9)
	la 31,.LC68@l(11)
	b .L113
.L128:
	lis 9,.LC72@ha
	lis 11,.LC73@ha
	la 6,.LC72@l(9)
	la 31,.LC73@l(11)
	b .L113
.L129:
	lis 9,.LC74@ha
	lis 11,.LC73@ha
	la 6,.LC74@l(9)
	la 31,.LC73@l(11)
	b .L113
.L130:
	lis 9,.LC75@ha
	lis 11,.LC76@ha
	la 6,.LC75@l(9)
	la 31,.LC76@l(11)
	b .L113
.L131:
	lis 9,.LC77@ha
	lis 11,.LC78@ha
	la 6,.LC77@l(9)
	la 31,.LC78@l(11)
	b .L113
.L132:
	lis 9,.LC79@ha
	lis 11,.LC80@ha
	la 6,.LC79@l(9)
	la 31,.LC80@l(11)
	b .L113
.L133:
	lis 9,.LC81@ha
	la 6,.LC81@l(9)
	b .L113
.L134:
	lis 9,.LC82@ha
	la 6,.LC82@l(9)
	b .L113
.L135:
	lis 9,.LC83@ha
	la 6,.LC83@l(9)
	b .L113
.L136:
	lis 9,.LC84@ha
	lis 11,.LC85@ha
	la 6,.LC84@l(9)
	la 31,.LC85@l(11)
	b .L113
.L137:
	lis 9,.LC86@ha
	lis 11,.LC87@ha
	la 6,.LC86@l(9)
	la 31,.LC87@l(11)
	b .L113
.L138:
	lis 9,.LC88@ha
	lis 11,.LC89@ha
	la 6,.LC88@l(9)
	la 31,.LC89@l(11)
	b .L113
.L139:
	lis 9,.LC90@ha
	lis 11,.LC91@ha
	la 6,.LC90@l(9)
	la 31,.LC91@l(11)
	b .L113
.L140:
	lis 9,.LC92@ha
	la 6,.LC92@l(9)
	b .L113
.L141:
	lis 9,.LC93@ha
	lis 11,.LC94@ha
	la 6,.LC93@l(9)
	la 31,.LC94@l(11)
	b .L113
.L142:
	lis 9,.LC95@ha
	lis 11,.LC96@ha
	la 6,.LC95@l(9)
	la 31,.LC96@l(11)
	b .L113
.L143:
	lis 9,.LC97@ha
	lis 11,.LC98@ha
	la 6,.LC97@l(9)
	la 31,.LC98@l(11)
	b .L113
.L144:
	lis 9,.LC99@ha
	lis 11,.LC100@ha
	la 6,.LC99@l(9)
	la 31,.LC100@l(11)
	b .L113
.L146:
	lis 9,.LC101@ha
	lis 11,.LC102@ha
	la 6,.LC101@l(9)
	la 31,.LC102@l(11)
	b .L113
.L147:
	lis 9,.LC103@ha
	lis 11,.LC104@ha
	la 6,.LC103@l(9)
	la 31,.LC104@l(11)
	b .L113
.L148:
	lis 9,.LC105@ha
	la 6,.LC105@l(9)
	b .L113
.L149:
	lis 9,.LC106@ha
	lis 11,.LC107@ha
	la 6,.LC106@l(9)
	la 31,.LC107@l(11)
	b .L113
.L150:
	lis 9,.LC108@ha
	lis 11,.LC109@ha
	la 6,.LC108@l(9)
	la 31,.LC109@l(11)
	b .L113
.L151:
	lis 9,.LC110@ha
	lis 11,.LC111@ha
	la 6,.LC110@l(9)
	la 31,.LC111@l(11)
	b .L113
.L152:
	lis 9,.LC112@ha
	lis 11,.LC113@ha
	la 6,.LC112@l(9)
	la 31,.LC113@l(11)
	b .L113
.L153:
	lis 9,.LC112@ha
	lis 11,.LC114@ha
	la 6,.LC112@l(9)
	la 31,.LC114@l(11)
	b .L113
.L154:
	lis 9,.LC115@ha
	lis 11,.LC22@ha
	la 6,.LC115@l(9)
	la 31,.LC22@l(11)
	b .L113
.L155:
	lis 9,.LC116@ha
	lis 11,.LC22@ha
	la 6,.LC116@l(9)
	la 31,.LC22@l(11)
	b .L113
.L156:
	lis 9,.LC117@ha
	lis 11,.LC118@ha
	la 6,.LC117@l(9)
	la 31,.LC118@l(11)
	b .L113
.L157:
	lis 9,.LC119@ha
	lis 11,.LC120@ha
	la 6,.LC119@l(9)
	la 31,.LC120@l(11)
	b .L113
.L160:
	lis 9,.LC121@ha
	lis 11,.LC122@ha
	la 6,.LC121@l(9)
	la 31,.LC122@l(11)
	b .L113
.L161:
	lis 9,.LC121@ha
	lis 11,.LC123@ha
	la 6,.LC121@l(9)
	la 31,.LC123@l(11)
	b .L113
.L162:
	lis 9,.LC124@ha
	lis 11,.LC125@ha
	la 6,.LC124@l(9)
	la 31,.LC125@l(11)
	b .L113
.L164:
	lis 9,.LC126@ha
	lis 11,.LC22@ha
	la 6,.LC126@l(9)
	la 31,.LC22@l(11)
	b .L113
.L165:
.L166:
	lis 9,.LC22@ha
	la 31,.LC22@l(9)
	mr 6,31
.L113:
	cmpwi 0,6,0
	bc 12,2,.L38
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC127@ha
	lwz 0,gi@l(9)
	mr 8,31
	la 4,.LC127@l(4)
	addi 5,5,700
	addi 7,7,700
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	lis 11,deathmatch@ha
	lis 8,.LC129@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC129@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L35
	cmpwi 0,27,0
	bc 12,2,.L171
	lwz 11,84(29)
	b .L174
.L171:
	lwz 11,84(29)
	lwz 9,3480(11)
	addi 9,9,1
	b .L175
.L38:
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC128@ha
	lwz 0,gi@l(9)
	la 4,.LC128@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lis 11,deathmatch@ha
	lis 8,.LC129@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC129@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L35
	lwz 11,84(30)
.L174:
	lwz 9,3480(11)
	addi 9,9,-1
.L175:
	stw 9,3480(11)
.L35:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 ClientObituary,.Lfe2-ClientObituary
	.section	".rodata"
	.align 2
.LC130:
	.string	"item_quad"
	.align 3
.LC131:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC132:
	.long 0x0
	.align 3
.LC133:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC134:
	.long 0x41b40000
	.section	".text"
	.align 2
	.globl TossClientWeapon
	.type	 TossClientWeapon,@function
TossClientWeapon:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 30,16(1)
	stw 0,36(1)
	lis 9,deathmatch@ha
	lis 10,.LC132@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC132@l(10)
	mr 31,3
	lfs 11,0(10)
	lfs 0,20(11)
	fcmpu 0,0,11
	bc 12,2,.L176
	lis 9,dmflags@ha
	lis 8,dropitems@ha
	lwz 11,84(31)
	lwz 7,dmflags@l(9)
	lwz 9,dropitems@l(8)
	mr 6,11
	lfs 0,20(7)
	addi 8,11,740
	lfs 12,20(9)
	lwz 9,3600(11)
	lwz 7,1788(11)
	slwi 9,9,2
	fcmpu 7,12,11
	lwzx 0,8,9
	fctiwz 13,0
	srawi 9,0,31
	xor 11,9,0
	crnor 31,30,30
	mfcr 0
	rlwinm 0,0,0,1
	subf 11,11,9
	stfd 13,8(1)
	neg 0,0
	srawi 11,11,31
	lwz 10,12(1)
	and 7,7,0
	and 4,7,11
	andi. 11,10,16384
	mr 7,4
	bc 4,2,.L180
	li 30,0
	b .L181
.L180:
	lis 10,level@ha
	lfs 12,3800(6)
	lwz 9,level@l(10)
	lis 0,0x4330
	lis 10,.LC133@ha
	addi 9,9,10
	la 10,.LC133@l(10)
	xoris 9,9,0x8000
	lfd 13,0(10)
	stw 9,12(1)
	stw 0,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 7,12,0
	mfcr 30
	rlwinm 30,30,30,1
.L181:
	addic 11,7,-1
	subfe 0,11,7
	lis 9,.LC132@ha
	and. 10,0,30
	la 9,.LC132@l(9)
	lfs 31,0(9)
	bc 12,2,.L182
	lis 11,.LC134@ha
	la 11,.LC134@l(11)
	lfs 31,0(11)
.L182:
	cmpwi 0,4,0
	bc 12,2,.L184
	lfs 0,3732(6)
	mr 3,31
	fsubs 0,0,31
	stfs 0,3732(6)
	bl Drop_Item
	lwz 9,84(31)
	lis 0,0x2
	lfs 0,3732(9)
	fadds 0,0,31
	stfs 0,3732(9)
	stw 0,284(3)
.L184:
	cmpwi 0,30,0
	bc 12,2,.L176
	lwz 9,84(31)
	lis 3,.LC130@ha
	la 3,.LC130@l(3)
	lfs 0,3732(9)
	fadds 0,0,31
	stfs 0,3732(9)
	bl FindItemByClassname
	mr 4,3
	mr 3,31
	bl Drop_Item
	lwz 7,84(31)
	lis 9,.LC133@ha
	lis 11,Touch_Item@ha
	la 9,.LC133@l(9)
	la 11,Touch_Item@l(11)
	lfs 0,3732(7)
	lis 6,level@ha
	lfd 10,0(9)
	lis 4,0x4330
	la 5,level@l(6)
	lis 9,.LC131@ha
	lis 10,G_FreeEdict@ha
	fsubs 0,0,31
	lfd 11,.LC131@l(9)
	la 10,G_FreeEdict@l(10)
	stfs 0,3732(7)
	lwz 0,284(3)
	stw 11,444(3)
	oris 0,0,0x2
	stw 0,284(3)
	lwz 9,level@l(6)
	lwz 11,84(31)
	xoris 9,9,0x8000
	lfs 12,4(5)
	stw 9,12(1)
	stw 4,8(1)
	lfd 13,8(1)
	lfs 0,3800(11)
	stw 10,436(3)
	fsub 13,13,10
	frsp 13,13
	fsubs 0,0,13
	fmadd 0,0,11,12
	frsp 0,0
	stfs 0,428(3)
.L176:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 TossClientWeapon,.Lfe3-TossClientWeapon
	.section	".rodata"
	.align 3
.LC135:
	.long 0x404ca5dc
	.long 0x1a63c1f8
	.align 2
.LC136:
	.long 0x0
	.align 2
.LC137:
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
	bc 12,2,.L187
	lis 9,g_edicts@ha
	xor 11,5,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,5,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L187
	lfs 11,12(5)
	lfs 13,4(5)
	lfs 10,4(31)
	lfs 0,8(5)
	b .L197
.L187:
	cmpwi 0,4,0
	bc 12,2,.L189
	lis 9,g_edicts@ha
	xor 11,4,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,4,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L189
	lfs 11,12(4)
	lfs 13,4(4)
	lfs 10,4(31)
	lfs 0,8(4)
.L197:
	lfs 9,8(31)
	lfs 12,12(31)
	fsubs 13,13,10
	fsubs 0,0,9
	fsubs 11,11,12
	stfs 13,8(1)
	stfs 0,12(1)
	stfs 11,16(1)
	b .L188
.L189:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3656(9)
	b .L186
.L188:
	lis 9,.LC136@ha
	lfs 2,8(1)
	la 9,.LC136@l(9)
	lfs 13,0(9)
	fcmpu 0,2,13
	bc 12,2,.L191
	lfs 1,12(1)
	bl atan2
	lis 9,.LC135@ha
	lwz 11,84(31)
	lfd 0,.LC135@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,3656(11)
	b .L192
.L191:
	lwz 9,84(31)
	stfs 13,3656(9)
	lfs 0,12(1)
	fcmpu 0,0,13
	bc 4,1,.L193
	lwz 9,84(31)
	lis 0,0x42b4
	b .L198
.L193:
	bc 4,0,.L192
	lwz 9,84(31)
	lis 0,0xc2b4
.L198:
	stw 0,3656(9)
.L192:
	lwz 3,84(31)
	lis 9,.LC136@ha
	la 9,.LC136@l(9)
	lfs 0,0(9)
	lfs 13,3656(3)
	fcmpu 0,13,0
	bc 4,0,.L186
	lis 11,.LC137@ha
	la 11,.LC137@l(11)
	lfs 0,0(11)
	fadds 0,13,0
	stfs 0,3656(3)
.L186:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 LookAtKiller,.Lfe4-LookAtKiller
	.section	".rodata"
	.align 2
.LC138:
	.string	"misc/udeath.wav"
	.align 2
.LC139:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.section	".sbss","aw",@nobits
	.align 2
i.42:
	.space	4
	.size	 i.42,4
	.section	".rodata"
	.align 2
.LC140:
	.string	"*death%i.wav"
	.align 2
.LC141:
	.long 0x0
	.align 3
.LC142:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC143:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl player_die
	.type	 player_die,@function
player_die:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 27,20(1)
	stw 0,52(1)
	mr 31,3
	lis 9,.LC141@ha
	la 9,.LC141@l(9)
	lwz 3,84(31)
	mr 29,4
	lfs 31,0(9)
	mr 30,5
	mr 27,6
	bl ClearScanner
	li 0,0
	lwz 10,84(31)
	li 9,1
	li 11,7
	stw 0,44(31)
	lis 8,0xc100
	stw 0,48(31)
	stw 0,76(31)
	stw 9,512(31)
	stw 11,260(31)
	stfs 31,396(31)
	stfs 31,392(31)
	stfs 31,388(31)
	stfs 31,16(31)
	stfs 31,24(31)
	stw 0,3828(10)
	lwz 10,492(31)
	lwz 0,184(31)
	cmpwi 0,10,0
	stw 8,208(31)
	ori 0,0,2
	stw 0,184(31)
	bc 4,2,.L200
	lwz 9,84(31)
	lwz 0,3964(9)
	cmpwi 0,0,0
	bc 12,2,.L201
	stw 10,3964(9)
	lwz 9,84(31)
	lwz 11,3968(9)
	stfs 31,628(11)
	lwz 9,84(31)
	lwz 11,3968(9)
	stw 10,256(11)
	lwz 9,84(31)
	stw 10,3968(9)
.L201:
	lwz 9,84(31)
	lfs 0,3928(9)
	fcmpu 0,0,31
	bc 12,2,.L202
	mr 3,31
	bl RemoveAttackingPainDaemons
.L202:
	lwz 9,84(31)
	lwz 3,3908(9)
	cmpwi 0,3,0
	bc 12,2,.L203
	bl GuidedRocket_Think
.L203:
	mr 3,31
	bl ChasecamRemove
	lwz 9,84(31)
	lwz 0,3956(9)
	cmpwi 0,0,0
	bc 12,2,.L204
	mr 3,31
	bl nightmarePlayerResetFlashlight
.L204:
	lis 9,level+4@ha
	lis 11,.LC142@ha
	lfs 0,level+4@l(9)
	la 11,.LC142@l(11)
	mr 3,31
	lfd 13,0(11)
	mr 4,29
	mr 5,30
	lwz 11,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3884(11)
	bl LookAtKiller
	lwz 9,84(31)
	li 0,2
	mr 3,31
	mr 4,29
	mr 5,30
	stw 0,0(9)
	bl ClientObituary
	mr 4,29
	mr 5,30
	mr 3,31
	bl CTFFragBonuses
	mr 3,31
	bl TossClientWeapon
	mr 3,31
	bl CTFPlayerResetGrapple
	mr 3,31
	bl CTFDeadDropFlag
	mr 3,31
	bl CTFDeadDropTech
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L205
	mr 3,31
	bl Cmd_Help_f
.L205:
	lis 9,game@ha
	li 30,0
	la 10,game@l(9)
	lwz 0,1556(10)
	cmpw 0,30,0
	bc 4,0,.L200
	lis 9,itemlist@ha
	lis 11,coop@ha
	la 9,itemlist@l(9)
	mr 5,10
	lwz 7,coop@l(11)
	addi 8,9,56
	li 6,0
	lis 9,.LC141@ha
	li 10,0
	la 9,.LC141@l(9)
	lfs 13,0(9)
.L209:
	lfs 0,20(7)
	fcmpu 0,0,13
	bc 12,2,.L210
	lwz 0,0(8)
	andi. 11,0,16
	bc 12,2,.L210
	lwz 9,84(31)
	addi 11,9,740
	lwzx 0,11,10
	addi 9,9,2384
	stwx 0,9,10
.L210:
	lwz 9,84(31)
	addi 30,30,1
	addi 8,8,84
	addi 9,9,740
	stwx 6,9,10
	lwz 0,1556(5)
	addi 10,10,4
	cmpw 0,30,0
	bc 12,0,.L209
.L200:
	lwz 11,84(31)
	li 29,0
	mr 3,31
	stw 29,3800(11)
	lwz 9,84(31)
	stw 29,3804(9)
	lwz 11,84(31)
	stw 29,3808(11)
	lwz 9,84(31)
	stw 29,3812(9)
	lwz 11,84(31)
	stw 29,3924(11)
	lwz 9,84(31)
	stw 29,3900(9)
	lwz 11,84(31)
	stw 29,3904(11)
	lwz 0,264(31)
	rlwinm 0,0,0,20,17
	stw 0,264(31)
	bl Jet_Active
	cmpwi 0,3,0
	bc 12,2,.L212
	mr 4,27
	mr 3,31
	bl Jet_BecomeExplosion
	lwz 9,84(31)
	stw 29,3996(9)
	b .L213
.L212:
	lwz 0,480(31)
	cmpwi 0,0,-40
	bc 4,0,.L214
	lis 29,gi@ha
	lis 3,.LC138@ha
	la 29,gi@l(29)
	la 3,.LC138@l(3)
	lwz 9,36(29)
	lis 28,.LC139@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC143@ha
	lwz 0,16(29)
	lis 11,.LC143@ha
	la 9,.LC143@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC143@l(11)
	li 4,4
	mtlr 0
	lis 9,.LC141@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC141@l(9)
	lfs 3,0(9)
	blrl
.L218:
	mr 3,31
	la 4,.LC139@l(28)
	mr 5,27
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L218
	mr 4,27
	mr 3,31
	bl ThrowClientHead
	li 0,0
	stw 0,512(31)
	b .L213
.L214:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L213
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
	stw 7,3788(6)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L222
	li 0,172
	li 9,177
	b .L231
.L222:
	cmpwi 0,10,1
	bc 12,2,.L226
	bc 12,1,.L230
	cmpwi 0,10,0
	bc 12,2,.L225
	b .L223
.L230:
	cmpwi 0,10,2
	bc 12,2,.L227
	b .L223
.L225:
	li 0,177
	li 9,183
	b .L231
.L226:
	li 0,183
	li 9,189
	b .L231
.L227:
	li 0,189
	li 9,197
.L231:
	stw 0,56(31)
	stw 9,3784(11)
.L223:
	lis 29,gi@ha
	la 29,gi@l(29)
	bl rand
	mr 4,3
	srawi 0,4,31
	lis 3,.LC140@ha
	srwi 0,0,30
	la 3,.LC140@l(3)
	add 0,4,0
	rlwinm 0,0,0,0,29
	subf 4,0,4
	addi 4,4,1
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC143@ha
	lwz 0,16(29)
	lis 11,.LC143@ha
	la 9,.LC143@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC143@l(11)
	mtlr 0
	li 4,2
	lis 9,.LC141@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC141@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,84(31)
	li 0,0
	stw 0,3728(9)
.L213:
	li 0,2
	lis 9,gi+72@ha
	stw 0,492(31)
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 27,20(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 player_die,.Lfe5-player_die
	.section	".rodata"
	.align 2
.LC146:
	.string	"info_player_deathmatch"
	.align 2
.LC145:
	.long 0x47c34f80
	.align 2
.LC147:
	.long 0x4b18967f
	.align 2
.LC148:
	.long 0x3f800000
	.align 3
.LC149:
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
	lis 9,.LC145@ha
	li 28,0
	lfs 29,.LC145@l(9)
	li 30,0
	li 23,0
	li 24,0
	fmr 28,29
	lis 22,.LC146@ha
	b .L255
.L257:
	lis 10,.LC148@ha
	lis 9,maxclients@ha
	la 10,.LC148@l(10)
	lis 11,.LC147@ha
	lfs 13,0(10)
	addi 28,28,1
	li 29,1
	lwz 10,maxclients@l(9)
	lis 25,maxclients@ha
	lfs 31,.LC147@l(11)
	lfs 0,20(10)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L265
	lis 11,.LC149@ha
	lis 26,g_edicts@ha
	la 11,.LC149@l(11)
	lis 27,0x4330
	lfd 30,0(11)
	li 31,1160
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
	addi 31,31,1160
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
	lis 5,.LC146@ha
	mr 3,30
	la 5,.LC146@l(5)
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
	la 5,.LC146@l(22)
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
.Lfe6:
	.size	 SelectRandomDeathmatchSpawnPoint,.Lfe6-SelectRandomDeathmatchSpawnPoint
	.section	".rodata"
	.align 2
.LC150:
	.long 0x4b18967f
	.align 2
.LC151:
	.long 0x0
	.align 2
.LC152:
	.long 0x3f800000
	.align 3
.LC153:
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
	lis 9,.LC151@ha
	li 31,0
	la 9,.LC151@l(9)
	li 25,0
	lfs 29,0(9)
	b .L281
.L283:
	lis 9,maxclients@ha
	lis 11,.LC152@ha
	lwz 10,maxclients@l(9)
	la 11,.LC152@l(11)
	li 29,1
	lfs 13,0(11)
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC150@ha
	lfs 31,.LC150@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L291
	lis 9,.LC153@ha
	lis 27,g_edicts@ha
	la 9,.LC153@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,1160
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
	addi 30,30,1160
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
	lis 30,.LC146@ha
	mr 3,31
	li 4,280
	la 5,.LC146@l(30)
	bl G_Find
	mr. 31,3
	bc 4,2,.L283
	cmpwi 0,25,0
	mr 3,25
	bc 4,2,.L296
	la 5,.LC146@l(30)
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
.Lfe7:
	.size	 SelectFarthestDeathmatchSpawnPoint,.Lfe7-SelectFarthestDeathmatchSpawnPoint
	.section	".rodata"
	.align 2
.LC154:
	.string	"Couldn't find spawn point %s\n"
	.align 2
.LC155:
	.long 0x0
	.align 2
.LC156:
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
	lis 11,.LC155@ha
	lis 9,deathmatch@ha
	la 11,.LC155@l(11)
	mr 26,4
	lfs 13,0(11)
	mr 25,5
	li 31,0
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
	mr 31,3
	b .L317
.L312:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,512
	bc 12,2,.L314
	bl SelectFarthestDeathmatchSpawnPoint
	mr 31,3
	b .L317
.L314:
	bl SelectRandomDeathmatchSpawnPoint
	mr 31,3
	b .L317
.L341:
	li 31,0
	b .L317
.L311:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L317
	lis 11,game+1028@ha
	lwz 0,84(3)
	lis 9,0x9a02
	lwz 10,game+1028@l(11)
	ori 9,9,2611
	li 29,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 30,0,4
	bc 12,2,.L317
	lis 27,.LC2@ha
	lis 28,.LC22@ha
	lis 31,game+1032@ha
.L323:
	mr 3,29
	li 4,280
	la 5,.LC2@l(27)
	bl G_Find
	mr. 29,3
	bc 12,2,.L341
	lwz 4,300(29)
	la 9,.LC22@l(28)
	la 3,game+1032@l(31)
	srawi 11,4,31
	xor 0,11,4
	subf 0,0,11
	srawi 0,0,31
	andc 9,9,0
	and 4,4,0
	or 4,4,9
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L323
	addic. 30,30,-1
	bc 4,2,.L323
	mr 31,29
.L317:
	cmpwi 0,31,0
	bc 4,2,.L329
	lis 29,.LC0@ha
	lis 30,game@ha
.L336:
	mr 3,31
	li 4,280
	la 5,.LC0@l(29)
	bl G_Find
	mr. 31,3
	bc 12,2,.L342
	la 3,game@l(30)
	lbz 0,1032(3)
	cmpwi 0,0,0
	bc 4,2,.L340
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L331
	b .L336
.L340:
	lwz 4,300(31)
	cmpwi 0,4,0
	bc 12,2,.L336
	addi 3,3,1032
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L336
.L331:
	cmpwi 0,31,0
	bc 4,2,.L329
.L342:
	lis 9,game@ha
	la 30,game@l(9)
	lbz 0,1032(30)
	cmpwi 0,0,0
	bc 4,2,.L338
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,280
	bl G_Find
	mr 31,3
.L338:
	cmpwi 0,31,0
	bc 4,2,.L329
	lis 9,gi+28@ha
	lis 3,.LC154@ha
	lwz 0,gi+28@l(9)
	la 3,.LC154@l(3)
	addi 4,30,1032
	mtlr 0
	crxor 6,6,6
	blrl
.L329:
	lfs 0,4(31)
	lis 9,.LC156@ha
	la 9,.LC156@l(9)
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
.Lfe8:
	.size	 SelectSpawnPoint,.Lfe8-SelectSpawnPoint
	.section	".rodata"
	.align 2
.LC157:
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
	mulli 29,29,1160
	addi 29,29,1160
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
	lis 9,0xfe3
	li 11,0
	ori 9,9,49265
	subf 0,0,31
	mullw 0,0,9
	srawi 0,0,3
	stwx 0,26,29
	stw 11,76(31)
	lwz 0,184(30)
	lwz 9,776(31)
	ori 0,0,6
	ori 9,9,256
	stw 0,184(31)
	stw 9,776(31)
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
	lfs 0,220(30)
	stfs 0,220(31)
	lfs 13,224(30)
	stfs 13,224(31)
	lfs 0,228(30)
	stfs 0,228(31)
	lfs 13,232(30)
	stfs 13,232(31)
	lfs 0,236(30)
	stfs 0,236(31)
	lfs 13,240(30)
	stfs 13,240(31)
	lfs 0,244(30)
	stfs 0,244(31)
	lwz 0,248(30)
	stw 0,248(31)
	lwz 9,252(30)
	stw 9,252(31)
	lwz 0,256(30)
	stw 0,256(31)
	lwz 9,260(30)
	stw 9,260(31)
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L357
	stw 11,480(31)
	b .L358
.L357:
	stw 0,480(31)
.L358:
	lwz 0,488(30)
	stw 0,488(31)
	lwz 9,552(30)
	stw 9,552(31)
	lwz 0,400(30)
	stw 0,400(31)
	lfs 0,1140(30)
	stfs 0,1140(31)
	lwz 9,1144(30)
	cmpwi 0,9,0
	bc 12,2,.L359
	stw 9,1144(31)
	li 0,0
	stw 31,540(9)
	stw 0,1144(30)
.L359:
	lwz 11,1136(30)
	lis 9,body_die@ha
	li 0,1
	la 9,body_die@l(9)
	stw 0,512(31)
	lis 10,gi+72@ha
	rlwinm 11,11,0,21,19
	stw 9,456(31)
	mr 3,31
	stw 11,1136(31)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 CopyToBodyQue,.Lfe9-CopyToBodyQue
	.section	".rodata"
	.align 2
.LC158:
	.string	"menu_loadgame\n"
	.align 2
.LC159:
	.string	"spectator"
	.align 2
.LC160:
	.string	"none"
	.align 2
.LC161:
	.string	"Spectator password incorrect.\n"
	.align 2
.LC162:
	.string	"spectator 0\n"
	.align 2
.LC163:
	.string	"Server spectator limit is full."
	.align 2
.LC164:
	.string	"password"
	.align 2
.LC165:
	.string	"Password incorrect.\n"
	.align 2
.LC166:
	.string	"spectator 1\n"
	.align 2
.LC167:
	.string	"%s has moved to the sidelines\n"
	.align 2
.LC168:
	.string	"%s joined the game\n"
	.align 2
.LC169:
	.long 0x3f800000
	.align 3
.LC170:
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
	bc 12,2,.L365
	lis 4,.LC159@ha
	addi 3,3,188
	la 4,.LC159@l(4)
	lis 30,spectator_password@ha
	bl Info_ValueForKey
	lwz 9,spectator_password@l(30)
	mr 29,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L366
	lis 4,.LC160@ha
	la 4,.LC160@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L366
	lwz 9,spectator_password@l(30)
	mr 4,29
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L366
	lis 29,gi@ha
	lis 5,.LC161@ha
	la 29,gi@l(29)
	li 4,2
	lwz 9,8(29)
	la 5,.LC161@l(5)
	mr 3,31
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,0
	li 3,11
	stw 0,1812(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC162@ha
	la 3,.LC162@l(3)
	b .L379
.L366:
	lis 9,maxclients@ha
	lis 10,.LC169@ha
	lwz 11,maxclients@l(9)
	la 10,.LC169@l(10)
	li 7,1
	lfs 0,0(10)
	li 8,0
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L368
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC170@ha
	la 9,.LC170@l(9)
	addi 10,11,1160
	lfd 13,0(9)
.L370:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L369
	lwz 11,84(10)
	addi 9,8,1
	lwz 0,1812(11)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L369:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,1160
	stw 0,12(1)
	stw 6,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L370
.L368:
	xoris 0,8,0x8000
	lis 11,0x4330
	stw 0,12(1)
	lis 10,.LC170@ha
	la 10,.LC170@l(10)
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
	bc 4,3,.L374
	lis 29,gi@ha
	lis 5,.LC163@ha
	la 29,gi@l(29)
	li 4,2
	lwz 9,8(29)
	la 5,.LC163@l(5)
	mr 3,31
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,0
	li 3,11
	stw 0,1812(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC162@ha
	la 3,.LC162@l(3)
	b .L379
.L365:
	lis 4,.LC164@ha
	addi 3,3,188
	la 4,.LC164@l(4)
	lis 29,password@ha
	bl Info_ValueForKey
	lis 28,gi@ha
	lwz 9,password@l(29)
	mr 30,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L374
	lis 4,.LC160@ha
	la 4,.LC160@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L374
	lwz 9,password@l(29)
	mr 4,30
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L374
	la 29,gi@l(28)
	lis 5,.LC165@ha
	lwz 9,8(29)
	li 4,2
	la 5,.LC165@l(5)
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
	lis 3,.LC166@ha
	la 3,.LC166@l(3)
.L379:
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,31
	li 4,1
	mtlr 0
	blrl
	b .L364
.L374:
	lwz 11,84(31)
	li 9,0
	mr 3,31
	stw 9,3480(11)
	stw 9,1800(11)
	lwz 0,184(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	bl PutClientInServer
	lwz 9,84(31)
	lwz 0,1812(9)
	cmpwi 0,0,0
	bc 4,2,.L376
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xfe3
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,49265
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
.L376:
	lis 9,level+4@ha
	lwz 11,84(31)
	lfs 0,level+4@l(9)
	stfs 0,3884(11)
	lwz 3,84(31)
	lwz 0,1812(3)
	cmpwi 0,0,0
	bc 12,2,.L377
	lis 9,gi@ha
	lis 4,.LC167@ha
	lwz 0,gi@l(9)
	addi 5,3,700
	la 4,.LC167@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L364
.L377:
	lis 9,gi@ha
	lis 4,.LC168@ha
	lwz 0,gi@l(9)
	addi 5,3,700
	la 4,.LC168@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L364:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 spectator_respawn,.Lfe10-spectator_respawn
	.section	".rodata"
	.align 2
.LC171:
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.align 2
.LC172:
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.align 2
.LC173:
	.string	"player"
	.align 2
.LC174:
	.string	"players/male/tris.md2"
	.align 2
.LC175:
	.string	"fov"
	.align 2
.LC176:
	.long 0x0
	.align 2
.LC177:
	.long 0x41400000
	.align 2
.LC178:
	.long 0x41000000
	.align 3
.LC179:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC180:
	.long 0x3f800000
	.align 2
.LC181:
	.long 0x43200000
	.align 2
.LC182:
	.long 0x47800000
	.align 2
.LC183:
	.long 0x43b40000
	.align 2
.LC184:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl PutClientInServer
	.type	 PutClientInServer,@function
PutClientInServer:
	stwu 1,-4528(1)
	mflr 0
	stfd 31,4520(1)
	stmw 22,4480(1)
	stw 0,4532(1)
	lis 9,.LC171@ha
	lis 10,.LC172@ha
	lwz 0,.LC171@l(9)
	la 29,.LC172@l(10)
	addi 8,1,8
	la 9,.LC171@l(9)
	lwz 11,.LC172@l(10)
	mr 31,3
	lwz 28,8(9)
	addi 7,1,24
	addi 5,1,56
	lwz 6,4(9)
	mr 22,5
	lis 9,.LC176@ha
	stw 0,8(1)
	addi 4,1,40
	la 9,.LC176@l(9)
	stw 28,8(8)
	lfs 31,0(9)
	stw 6,4(8)
	lwz 0,8(29)
	lwz 9,4(29)
	stw 11,24(1)
	stw 0,8(7)
	stw 9,4(7)
	bl SelectSpawnPoint
	lis 9,deathmatch@ha
	lis 11,g_edicts@ha
	lwz 30,84(31)
	lwz 10,deathmatch@l(9)
	lis 0,0xfe3
	lwz 9,g_edicts@l(11)
	ori 0,0,49265
	lfs 0,20(10)
	subf 9,9,31
	mullw 9,9,0
	fcmpu 0,0,31
	srawi 9,9,3
	addi 24,9,-1
	bc 12,2,.L381
	addi 28,1,1720
	addi 27,30,1832
	mr 4,27
	li 5,1716
	mr 3,28
	addi 29,30,188
	crxor 6,6,6
	bl memcpy
	mr 23,28
	mr 25,29
	addi 26,1,3448
	mr 4,29
	li 5,512
	mr 3,26
	crxor 6,6,6
	bl memcpy
	li 4,0
	li 5,1644
	mr 3,29
	crxor 6,6,6
	bl memset
	li 0,1
	mr 3,30
	stw 0,720(30)
	bl ClearScanner
	mr 4,26
	mr 3,31
	bl ClientUserinfoChanged
	lis 9,enableclass@ha
	lwz 11,enableclass@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L383
	mr 3,30
	li 4,0
	bl ClassInitPersistant
	b .L385
.L383:
	lwz 4,3528(30)
	mr 3,30
	bl ClassInitPersistant
	b .L385
.L381:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L386
	addi 28,1,1720
	addi 27,30,1832
	mr 4,27
	li 5,1716
	mr 3,28
	addi 29,30,188
	crxor 6,6,6
	bl memcpy
	mr 23,28
	mr 25,29
	addi 26,1,3960
	mr 4,29
	li 5,512
	mr 3,26
	crxor 6,6,6
	bl memcpy
	lwz 9,1804(30)
	mr 4,28
	li 5,1644
	mr 3,29
	stw 9,3336(1)
	lwz 0,1808(30)
	stw 0,3340(1)
	crxor 6,6,6
	bl memcpy
	mr 4,26
	mr 3,31
	bl ClientUserinfoChanged
	lwz 9,3368(1)
	lwz 0,1800(30)
	cmpw 0,9,0
	bc 4,1,.L385
	stw 9,1800(30)
	b .L385
.L386:
	addi 29,1,1720
	li 4,0
	mr 3,29
	li 5,1716
	crxor 6,6,6
	bl memset
	mr 23,29
	addi 27,30,1832
	lwz 9,3528(30)
	addi 25,30,188
	stw 9,3416(1)
	lwz 0,3540(30)
	stw 0,3428(1)
	lwz 9,3544(30)
	stw 9,3432(1)
.L385:
	addi 29,1,72
	mr 4,25
	li 5,1644
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 4,0
	li 5,4016
	mr 3,30
	crxor 6,6,6
	bl memset
	mr 4,29
	mr 3,25
	li 5,1644
	crxor 6,6,6
	bl memcpy
	lwz 0,724(30)
	cmpwi 0,0,0
	bc 12,1,.L389
	li 4,0
	li 5,1644
	mr 3,25
	crxor 6,6,6
	bl memset
	li 0,1
	mr 3,30
	stw 0,720(30)
	bl ClearScanner
	mr 3,30
	li 4,0
	bl ClassInitPersistant
.L389:
	mr 3,27
	mr 4,23
	li 5,1716
	crxor 6,6,6
	bl memcpy
	lis 9,.LC176@ha
	lwz 7,84(31)
	lis 10,coop@ha
	la 9,.LC176@l(9)
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
	bc 12,2,.L392
	lwz 0,1800(7)
	stw 0,3480(7)
.L392:
	li 10,0
	lis 11,game+1028@ha
	mulli 8,24,4016
	lwz 5,184(31)
	stw 10,552(31)
	lis 9,.LC173@ha
	li 4,2
	lwz 6,game+1028@l(11)
	la 9,.LC173@l(9)
	li 26,1
	li 11,22
	stw 9,280(31)
	li 0,4
	stw 11,508(31)
	add 6,6,8
	li 9,200
	lis 11,.LC177@ha
	stw 0,260(31)
	lis 3,level+4@ha
	stw 9,400(31)
	la 11,.LC177@l(11)
	lis 8,player_pain@ha
	stw 4,248(31)
	lis 9,.LC174@ha
	lis 7,player_die@ha
	stw 6,84(31)
	la 9,.LC174@l(9)
	la 8,player_pain@l(8)
	stw 4,512(31)
	la 7,player_die@l(7)
	rlwinm 5,5,0,31,29
	stw 26,88(31)
	li 28,-41
	li 29,6418
	stw 10,492(31)
	li 4,90
	lis 27,enableclass@ha
	lfs 0,level+4@l(3)
	lfs 13,0(11)
	lwz 0,264(31)
	lis 11,0x201
	ori 11,11,3
	stw 5,184(31)
	fadds 0,0,13
	rlwinm 0,0,0,21,19
	stw 11,252(31)
	stw 9,268(31)
	stw 8,452(31)
	stfs 0,404(31)
	stw 0,264(31)
	stw 7,456(31)
	stw 10,612(31)
	stw 10,608(31)
	stw 10,3964(6)
	lwz 0,184(31)
	lwz 9,84(31)
	rlwinm 0,0,0,0,30
	stw 28,488(31)
	stw 29,1136(31)
	stw 26,644(31)
	stw 0,184(31)
	stfs 12,1140(31)
	stw 10,256(31)
	stw 4,4004(9)
	stw 4,1128(31)
	lwz 11,84(31)
	lwz 8,enableclass@l(27)
	stw 10,3908(11)
	lwz 9,84(31)
	stw 10,3952(9)
	lwz 11,84(31)
	stw 10,3956(11)
	lwz 9,84(31)
	stw 10,3960(9)
	lfs 0,20(8)
	fcmpu 0,0,12
	bc 4,2,.L393
	mr 3,30
	li 4,0
	bl SetClassAttributes
	b .L394
.L393:
	lwz 4,3528(30)
	mr 3,30
	bl SetClassAttributes
.L394:
	lis 9,.LC176@ha
	lfs 10,12(1)
	li 4,0
	la 9,.LC176@l(9)
	lfs 0,16(1)
	li 5,184
	lfs 13,24(1)
	lfs 12,28(1)
	lfs 11,32(1)
	lfs 9,8(1)
	lfs 31,0(9)
	lwz 3,84(31)
	stfs 10,192(31)
	stfs 0,196(31)
	stfs 13,200(31)
	stfs 12,204(31)
	stfs 11,208(31)
	stfs 9,188(31)
	stfs 31,384(31)
	stfs 31,380(31)
	stfs 31,376(31)
	crxor 6,6,6
	bl memset
	lis 9,.LC178@ha
	lfs 0,40(1)
	lis 8,deathmatch@ha
	la 9,.LC178@l(9)
	lbz 0,16(30)
	lfs 10,0(9)
	andi. 0,0,191
	mr 11,9
	mr 10,9
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,4472(1)
	lwz 9,4476(1)
	sth 9,4(30)
	lfs 0,44(1)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,4472(1)
	lwz 11,4476(1)
	sth 11,6(30)
	lfs 0,48(1)
	stb 0,16(30)
	lwz 9,deathmatch@l(8)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,4472(1)
	lwz 10,4476(1)
	sth 10,8(30)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L395
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,4472(1)
	lwz 11,4476(1)
	andi. 0,11,32768
	bc 4,2,.L418
.L395:
	lis 4,.LC175@ha
	mr 3,25
	la 4,.LC175@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	stw 3,4476(1)
	lis 0,0x4330
	lis 11,.LC179@ha
	la 11,.LC179@l(11)
	stw 0,4472(1)
	lfd 13,0(11)
	lfd 0,4472(1)
	lis 11,.LC180@ha
	la 11,.LC180@l(11)
	lfs 12,0(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	stfs 0,112(30)
	bc 4,0,.L397
.L418:
	lis 0,0x42b4
	stw 0,112(30)
	b .L396
.L397:
	lis 9,.LC181@ha
	la 9,.LC181@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L396
	stfs 13,112(30)
.L396:
	lis 9,gi+32@ha
	lwz 11,1788(30)
	lwz 0,gi+32@l(9)
	lwz 3,32(11)
	mtlr 0
	blrl
	lis 11,.LC183@ha
	lis 9,.LC182@ha
	stw 3,88(30)
	la 11,.LC183@l(11)
	la 9,.LC182@l(9)
	lfs 13,48(1)
	lfs 10,0(11)
	lis 0,0xfe3
	li 10,255
	lis 11,g_edicts@ha
	lfs 9,0(9)
	ori 0,0,49265
	lwz 9,g_edicts@l(11)
	mr 5,22
	addi 6,30,3484
	lis 11,.LC180@ha
	lfs 11,40(1)
	addi 7,30,20
	la 11,.LC180@l(11)
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
.L417:
	lfsx 0,8,5
	lfsx 12,8,6
	addi 8,8,4
	fsubs 0,0,12
	fmuls 0,0,9
	fdivs 0,0,10
	fctiwz 13,0
	stfd 13,4472(1)
	lwz 9,4476(1)
	sth 9,0(7)
	addi 7,7,2
	bdnz .L417
	lis 9,.LC176@ha
	lfs 0,60(1)
	la 9,.LC176@l(9)
	lfs 12,0(9)
	stfs 0,20(31)
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	stfs 12,24(31)
	stfs 12,16(31)
	stfs 12,28(30)
	lfs 13,20(31)
	stfs 13,32(30)
	lfs 0,24(31)
	stfs 0,36(30)
	lfs 13,16(31)
	stfs 13,3728(30)
	lfs 0,20(31)
	stfs 0,3732(30)
	lfs 13,24(31)
	stfs 13,3736(30)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L405
	mr 3,31
	bl CTFStartClient
	cmpwi 0,3,0
	bc 4,2,.L380
	b .L407
.L405:
	lis 9,enableclass@ha
	lwz 11,enableclass@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L408
	lwz 7,84(31)
	lwz 8,3540(7)
	cmpwi 0,8,0
	bc 4,2,.L407
	lwz 9,184(31)
	li 11,1
	lis 10,gi+72@ha
	lwz 0,264(31)
	mr 3,31
	ori 9,9,1
	stw 11,260(31)
	ori 0,0,32
	stw 9,184(31)
	stw 0,264(31)
	stw 8,248(31)
	stw 8,3528(7)
	lwz 9,84(31)
	stw 8,88(9)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
	mr 3,31
	bl ClassOpenJoinMenu
	b .L380
.L408:
	lwz 0,1812(30)
	cmpwi 0,0,0
	bc 12,2,.L411
	li 9,0
	li 10,1
	stw 10,3496(30)
	lis 8,gi+72@ha
	mr 3,31
	stw 9,3888(30)
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
	b .L380
.L411:
	lis 9,cam_force@ha
	stw 0,3496(30)
	lwz 11,cam_force@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L407
	mr 3,31
	bl ChasecamStart
	lwz 9,84(31)
	lwz 11,3916(9)
	cmpwi 0,11,0
	bc 12,2,.L407
	lwz 0,4004(9)
	stw 0,1124(11)
.L407:
	mr 3,31
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,1788(30)
	mr 3,31
	stw 0,3624(30)
	bl ChangeWeapon
	lis 9,.LC176@ha
	lis 11,start_666_time@ha
	la 9,.LC176@l(9)
	lfs 0,0(9)
	lwz 9,start_666_time@l(11)
	lfs 11,20(9)
	fcmpu 0,11,0
	bc 12,2,.L380
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 10,0x4330
	lis 9,.LC179@ha
	xoris 0,0,0x8000
	la 9,.LC179@l(9)
	stw 0,4476(1)
	stw 10,4472(1)
	lfd 12,0(9)
	lfd 0,4472(1)
	lis 9,.LC184@ha
	la 9,.LC184@l(9)
	lfs 13,0(9)
	fsub 0,0,12
	frsp 0,0
	fmadds 13,11,13,0
	stfs 13,3804(30)
.L380:
	lwz 0,4532(1)
	mtlr 0
	lmw 22,4480(1)
	lfd 31,4520(1)
	la 1,4528(1)
	blr
.Lfe11:
	.size	 PutClientInServer,.Lfe11-PutClientInServer
	.section	".rodata"
	.align 2
.LC185:
	.string	"%s entered the game\n"
	.align 2
.LC186:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientBeginDeathmatch
	.type	 ClientBeginDeathmatch,@function
ClientBeginDeathmatch:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 30,3
	bl G_InitEdict
	lwz 31,84(30)
	li 4,0
	li 5,1716
	addi 29,31,1832
	lwz 28,3500(31)
	lwz 27,3528(31)
	mr 3,29
	lwz 26,3540(31)
	lwz 25,3544(31)
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	stw 28,3500(31)
	mr 3,29
	stw 27,3528(31)
	addi 4,31,188
	li 5,1644
	stw 26,3540(31)
	stw 25,3544(31)
	lwz 0,level@l(9)
	stw 0,3476(31)
	crxor 6,6,6
	bl memcpy
	lis 9,.LC186@ha
	lis 11,ctf@ha
	la 9,.LC186@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L421
	lwz 0,3500(31)
	cmpwi 0,0,0
	bc 12,1,.L421
	mr 3,31
	bl CTFAssignTeam
.L421:
	mr 3,30
	bl PutClientInServer
	lis 11,.LC186@ha
	lis 9,level+200@ha
	la 11,.LC186@l(11)
	lfs 0,level+200@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,2,.L422
	mr 3,30
	bl MoveClientToIntermission
	b .L423
.L422:
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xfe3
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,49265
	mtlr 10
	subf 3,3,30
	mullw 3,3,0
	srawi 3,3,3
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
.L423:
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC185@ha
	lwz 0,gi@l(9)
	li 3,2
	la 4,.LC185@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,30
	bl ClientEndServerFrame
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe12:
	.size	 ClientBeginDeathmatch,.Lfe12-ClientBeginDeathmatch
	.section	".rodata"
	.align 2
.LC187:
	.long 0x0
	.align 2
.LC188:
	.long 0x47800000
	.align 2
.LC189:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl ClientBegin
	.type	 ClientBegin,@function
ClientBegin:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 25,28(1)
	stw 0,68(1)
	lis 11,g_edicts@ha
	mr 30,3
	lwz 9,g_edicts@l(11)
	lis 0,0xfe3
	lis 10,deathmatch@ha
	ori 0,0,49265
	lis 11,game+1028@ha
	subf 9,9,30
	lwz 8,game+1028@l(11)
	mullw 9,9,0
	lwz 11,deathmatch@l(10)
	lis 10,.LC187@ha
	srawi 9,9,3
	la 10,.LC187@l(10)
	mulli 9,9,4016
	lfs 31,0(10)
	addi 9,9,-4016
	add 8,8,9
	stw 8,84(30)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L425
	bl ClientBeginDeathmatch
	b .L424
.L425:
	lwz 0,88(30)
	cmpwi 0,0,1
	bc 4,2,.L426
	lis 9,.LC188@ha
	lis 10,.LC189@ha
	li 11,3
	la 9,.LC188@l(9)
	la 10,.LC189@l(10)
	mtctr 11
	lfs 11,0(9)
	li 8,0
	lfs 12,0(10)
	li 7,0
.L438:
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
	bdnz .L438
	b .L432
.L426:
	mr 3,30
	bl G_InitEdict
	lwz 31,84(30)
	lis 9,.LC173@ha
	li 4,0
	la 9,.LC173@l(9)
	li 5,1716
	stw 9,280(30)
	addi 29,31,1832
	lwz 28,3500(31)
	mr 3,29
	lwz 27,3528(31)
	lwz 26,3540(31)
	lwz 25,3544(31)
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	stw 28,3500(31)
	mr 3,29
	stw 27,3528(31)
	addi 4,31,188
	li 5,1644
	stw 26,3540(31)
	stw 25,3544(31)
	lwz 0,level@l(9)
	stw 0,3476(31)
	crxor 6,6,6
	bl memcpy
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L434
	lwz 0,3500(31)
	cmpwi 0,0,0
	bc 12,1,.L434
	mr 3,31
	bl CTFAssignTeam
.L434:
	mr 3,30
	bl PutClientInServer
.L432:
	lis 10,.LC187@ha
	lis 9,level+200@ha
	la 10,.LC187@l(10)
	lfs 0,level+200@l(9)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 12,2,.L435
	mr 3,30
	bl MoveClientToIntermission
	b .L436
.L435:
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L436
	lis 28,gi@ha
	li 3,1
	la 29,gi@l(28)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xfe3
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,49265
	mtlr 10
	subf 3,3,30
	mullw 3,3,0
	srawi 3,3,3
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
	lis 4,.LC185@ha
	li 3,2
	lwz 0,gi@l(28)
	la 4,.LC185@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L436:
	mr 3,30
	bl ClientEndServerFrame
.L424:
	lwz 0,68(1)
	mtlr 0
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe13:
	.size	 ClientBegin,.Lfe13-ClientBegin
	.section	".rodata"
	.align 2
.LC190:
	.string	"\\name\\badinfo\\skin\\male/grunt"
	.align 2
.LC191:
	.string	"name"
	.align 2
.LC192:
	.string	"0"
	.align 2
.LC193:
	.string	"skin"
	.align 2
.LC194:
	.string	"%s\\%s"
	.align 2
.LC195:
	.string	"hand"
	.align 2
.LC196:
	.long 0x0
	.align 3
.LC197:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC198:
	.long 0x3f800000
	.align 2
.LC199:
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
	mr 27,3
	mr 3,30
	bl Info_Validate
	cmpwi 0,3,0
	bc 4,2,.L440
	lis 11,.LC190@ha
	lwz 0,.LC190@l(11)
	la 9,.LC190@l(11)
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
.L440:
	lis 4,.LC191@ha
	mr 3,30
	la 4,.LC191@l(4)
	bl Info_ValueForKey
	lwz 9,84(27)
	mr 31,3
	li 5,15
	mr 4,31
	addi 3,9,700
	bl strncpy
	lis 4,.LC159@ha
	mr 3,30
	la 4,.LC159@l(4)
	bl Info_ValueForKey
	lis 9,deathmatch@ha
	lis 10,.LC196@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC196@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L441
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L441
	lis 4,.LC192@ha
	la 4,.LC192@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L441
	lwz 9,84(27)
	li 0,1
	b .L451
.L441:
	lwz 9,84(27)
	li 0,0
.L451:
	stw 0,1812(9)
	lis 4,.LC193@ha
	mr 3,30
	la 4,.LC193@l(4)
	bl Info_ValueForKey
	lwz 9,84(27)
	lwz 4,3528(9)
	bl ClassSkin
	lis 9,ctf@ha
	lis 11,g_edicts@ha
	lwz 10,ctf@l(9)
	mr 31,3
	lis 9,.LC196@ha
	lwz 0,g_edicts@l(11)
	la 9,.LC196@l(9)
	lfs 0,20(10)
	lfs 13,0(9)
	subf 0,0,27
	lis 9,0xfe3
	ori 9,9,49265
	fcmpu 0,0,13
	mullw 0,0,9
	srawi 28,0,3
	bc 12,2,.L443
	mr 4,31
	mr 3,27
	bl CTFAssignSkin
	b .L444
.L443:
	lwz 4,84(27)
	lis 29,gi@ha
	lis 3,.LC194@ha
	la 29,gi@l(29)
	addi 28,28,1311
	addi 4,4,700
	la 3,.LC194@l(3)
	mr 5,31
	crxor 6,6,6
	bl va
	lwz 0,24(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
.L444:
	lis 9,.LC196@ha
	lis 11,deathmatch@ha
	la 9,.LC196@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L445
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,32768
	bc 12,2,.L445
	lwz 9,84(27)
	b .L452
.L445:
	lis 4,.LC175@ha
	mr 3,30
	la 4,.LC175@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	lwz 11,84(27)
	stw 3,20(1)
	lis 0,0x4330
	lis 10,.LC197@ha
	la 10,.LC197@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC198@ha
	la 10,.LC198@l(10)
	lfs 12,0(10)
	fsub 0,0,13
	frsp 0,0
	stfs 0,112(11)
	lwz 9,84(27)
	lfs 0,112(9)
	fcmpu 0,0,12
	bc 4,0,.L447
.L452:
	lis 0,0x42b4
	stw 0,112(9)
	b .L446
.L447:
	lis 11,.LC199@ha
	la 11,.LC199@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L446
	stfs 13,112(9)
.L446:
	lis 4,.LC195@ha
	mr 3,30
	la 4,.LC195@l(4)
	bl Info_ValueForKey
	mr 31,3
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L450
	mr 3,31
	bl atoi
	lwz 9,84(27)
	stw 3,716(9)
.L450:
	lwz 3,84(27)
	mr 4,30
	li 5,511
	addi 3,3,188
	bl strncpy
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe14:
	.size	 ClientUserinfoChanged,.Lfe14-ClientUserinfoChanged
	.section	".rodata"
	.align 2
.LC200:
	.string	"ip"
	.align 2
.LC201:
	.string	"rejmsg"
	.align 2
.LC202:
	.string	"Banned."
	.align 2
.LC203:
	.string	"Spectator password required or incorrect."
	.align 2
.LC204:
	.string	"Password required or incorrect."
	.align 2
.LC205:
	.string	"%s connected.\n"
	.align 2
.LC206:
	.long 0x0
	.align 3
.LC207:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ClientConnect
	.type	 ClientConnect,@function
ClientConnect:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	mr 24,4
	mr 30,3
	lis 4,.LC200@ha
	mr 3,24
	la 4,.LC200@l(4)
	bl Info_ValueForKey
	bl SV_FilterPacket
	cmpwi 0,3,0
	bc 12,2,.L454
	lis 4,.LC201@ha
	lis 5,.LC202@ha
	mr 3,24
	la 4,.LC201@l(4)
	la 5,.LC202@l(5)
	b .L476
.L454:
	lis 4,.LC159@ha
	mr 3,24
	la 4,.LC159@l(4)
	bl Info_ValueForKey
	lis 9,deathmatch@ha
	lis 10,.LC206@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC206@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L455
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L455
	lis 4,.LC192@ha
	la 4,.LC192@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L455
	lis 29,spectator_password@ha
	lwz 9,spectator_password@l(29)
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L456
	lis 4,.LC160@ha
	la 4,.LC160@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L456
	lwz 9,spectator_password@l(29)
	mr 4,31
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L456
	lis 4,.LC201@ha
	lis 5,.LC203@ha
	mr 3,24
	la 4,.LC201@l(4)
	la 5,.LC203@l(5)
	b .L476
.L456:
	lis 9,maxclients@ha
	lis 10,.LC206@ha
	lwz 11,maxclients@l(9)
	la 10,.LC206@l(10)
	li 8,0
	lfs 0,0(10)
	li 7,0
	lfs 13,20(11)
	fcmpu 0,0,13
	bc 4,0,.L458
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC207@ha
	la 9,.LC207@l(9)
	addi 10,11,1160
	lfd 13,0(9)
.L460:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L459
	lwz 11,84(10)
	addi 9,8,1
	lwz 0,1812(11)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L459:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,1160
	stw 0,12(1)
	stw 6,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L460
.L458:
	xoris 0,8,0x8000
	lis 11,0x4330
	stw 0,12(1)
	lis 10,.LC207@ha
	la 10,.LC207@l(10)
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
	bc 4,3,.L464
	lis 4,.LC201@ha
	lis 5,.LC163@ha
	mr 3,24
	la 4,.LC201@l(4)
	la 5,.LC163@l(5)
	b .L476
.L455:
	lis 4,.LC164@ha
	mr 3,24
	la 4,.LC164@l(4)
	lis 29,password@ha
	bl Info_ValueForKey
	lwz 9,password@l(29)
	mr 31,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L464
	lis 4,.LC160@ha
	la 4,.LC160@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L464
	lwz 9,password@l(29)
	mr 4,31
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L464
	lis 4,.LC201@ha
	lis 5,.LC204@ha
	mr 3,24
	la 4,.LC201@l(4)
	la 5,.LC204@l(5)
.L476:
	bl Info_SetValueForKey
	li 3,0
	b .L475
.L464:
	lis 11,g_edicts@ha
	lis 0,0xfe3
	lwz 8,88(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,49265
	lis 11,game+1028@ha
	cmpwi 0,8,0
	subf 9,9,30
	lwz 10,game+1028@l(11)
	mullw 9,9,0
	srawi 9,9,3
	mulli 9,9,4016
	addi 9,9,-4016
	add 10,10,9
	stw 10,84(30)
	bc 4,2,.L466
	li 0,-1
	li 4,0
	stw 0,3500(10)
	li 5,1716
	lwz 9,84(30)
	stw 8,3540(9)
	lwz 11,84(30)
	stw 8,3544(11)
	lwz 9,84(30)
	stw 8,3528(9)
	lwz 31,84(30)
	addi 29,31,1832
	lwz 28,3500(31)
	lwz 27,3528(31)
	mr 3,29
	lwz 26,3540(31)
	lwz 25,3544(31)
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	stw 28,3500(31)
	mr 3,29
	stw 27,3528(31)
	addi 4,31,188
	li 5,1644
	stw 26,3540(31)
	stw 25,3544(31)
	lwz 0,level@l(9)
	stw 0,3476(31)
	crxor 6,6,6
	bl memcpy
	lis 9,.LC206@ha
	lis 11,ctf@ha
	la 9,.LC206@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L468
	lwz 0,3500(31)
	cmpwi 0,0,0
	bc 12,1,.L468
	mr 3,31
	bl CTFAssignTeam
.L468:
	lis 9,game+1560@ha
	lwz 0,game+1560@l(9)
	cmpwi 0,0,0
	bc 12,2,.L470
	lwz 9,84(30)
	lwz 0,1788(9)
	cmpwi 0,0,0
	bc 4,2,.L466
.L470:
	lwz 29,84(30)
	li 4,0
	li 5,1644
	addi 3,29,188
	crxor 6,6,6
	bl memset
	li 0,1
	mr 3,29
	stw 0,720(29)
	bl ClearScanner
	lis 9,.LC206@ha
	lis 11,enableclass@ha
	la 9,.LC206@l(9)
	lfs 13,0(9)
	lwz 9,enableclass@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L472
	lwz 3,84(30)
	li 4,0
	bl ClassInitPersistant
	b .L466
.L472:
	lwz 3,84(30)
	lwz 4,3528(3)
	bl ClassInitPersistant
.L466:
	mr 4,24
	mr 3,30
	bl ClientUserinfoChanged
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L474
	lis 9,gi+4@ha
	lwz 4,84(30)
	lis 3,.LC205@ha
	lwz 0,gi+4@l(9)
	la 3,.LC205@l(3)
	addi 4,4,700
	mtlr 0
	crxor 6,6,6
	blrl
.L474:
	lwz 9,84(30)
	li 0,0
	li 11,1
	stw 0,184(30)
	li 3,1
	stw 11,720(9)
.L475:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe15:
	.size	 ClientConnect,.Lfe15-ClientConnect
	.section	".rodata"
	.align 2
.LC208:
	.string	"%s disconnected\n"
	.align 2
.LC209:
	.string	"disconnected"
	.align 2
.LC210:
	.long 0x0
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
	lwz 5,84(31)
	cmpwi 0,5,0
	bc 12,2,.L477
	lis 9,gi@ha
	lis 4,.LC208@ha
	lwz 0,gi@l(9)
	la 4,.LC208@l(4)
	addi 5,5,700
	li 3,2
	la 30,gi@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	lis 11,.LC210@ha
	la 11,.LC210@l(11)
	lfs 13,0(11)
	lfs 0,3928(9)
	fcmpu 0,0,13
	bc 12,2,.L479
	mr 3,31
	bl RemoveAttackingPainDaemons
.L479:
	mr 3,31
	lis 28,g_edicts@ha
	bl ThrowIce
	lis 29,0xfe3
	mr 3,31
	ori 29,29,49265
	bl ChasecamRemove
	mr 3,31
	bl CTFDeadDropFlag
	mr 3,31
	bl CTFDeadDropTech
	lwz 9,100(30)
	li 3,1
	mtlr 9
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
	lis 9,.LC209@ha
	li 0,0
	la 9,.LC209@l(9)
	lwz 11,84(31)
	lis 4,.LC22@ha
	stw 9,280(31)
	subf 3,3,31
	la 4,.LC22@l(4)
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
.L477:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 ClientDisconnect,.Lfe16-ClientDisconnect
	.section	".rodata"
	.align 2
.LC211:
	.string	"sv %3i:%i %i\n"
	.align 2
.LC212:
	.string	"weapons/shatter.wav"
	.align 2
.LC213:
	.string	"models/objects/debris2/tris.md2"
	.align 2
.LC214:
	.string	"models/objects/debris1/tris.md2"
	.align 2
.LC218:
	.string	"*jump1.wav"
	.align 3
.LC215:
	.long 0x3fe33333
	.long 0x33333333
	.align 3
.LC216:
	.long 0x3f768000
	.long 0x0
	.align 3
.LC217:
	.long 0x3ff59999
	.long 0x9999999a
	.align 2
.LC219:
	.long 0x3f800000
	.align 2
.LC220:
	.long 0x40000000
	.align 2
.LC221:
	.long 0x0
	.align 3
.LC222:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC223:
	.long 0x3fec0000
	.long 0x0
	.align 3
.LC224:
	.long 0x3fe80000
	.long 0x0
	.align 3
.LC225:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC226:
	.long 0x43960000
	.align 2
.LC227:
	.long 0xc3960000
	.align 3
.LC228:
	.long 0x40140000
	.long 0x0
	.align 2
.LC229:
	.long 0x41000000
	.align 3
.LC230:
	.long 0x3fc00000
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientThink
	.type	 ClientThink,@function
ClientThink:
	stwu 1,-432(1)
	mflr 0
	stfd 30,416(1)
	stfd 31,424(1)
	stmw 17,356(1)
	stw 0,436(1)
	mr 31,3
	mr 22,4
	lwz 0,264(31)
	andi. 7,0,16384
	bc 12,2,.L503
	lis 9,level@ha
	lfs 13,1152(31)
	la 9,level@l(9)
	lfs 0,4(9)
	fcmpu 0,0,13
	bc 12,0,.L502
	rlwinm 0,0,0,18,16
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,264(31)
	lis 3,.LC212@ha
	lwz 9,36(29)
	la 3,.LC212@l(3)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC219@ha
	lis 9,.LC220@ha
	lis 10,.LC221@ha
	mr 5,3
	la 7,.LC219@l(7)
	la 9,.LC220@l(9)
	mtlr 0
	la 10,.LC221@l(10)
	li 4,0
	lfs 1,0(7)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	bl rand
	srawi 0,3,31
	srwi 0,0,30
	add 0,3,0
	rlwinm 0,0,0,0,29
	subf 29,0,3
	cmpwi 0,29,-1
	bc 12,2,.L507
	lis 30,.LC213@ha
.L508:
	lis 7,.LC219@ha
	mr 3,31
	la 7,.LC219@l(7)
	la 4,.LC213@l(30)
	lfs 1,0(7)
	addi 5,31,4
	bl ThrowDebris
	cmpwi 0,29,0
	addi 29,29,-1
	bc 4,2,.L508
.L507:
	bl rand
	lis 9,0x5555
	srawi 11,3,31
	ori 9,9,21846
	mulhw 9,3,9
	subf 9,11,9
	slwi 0,9,1
	add 0,0,9
	subf 29,0,3
	cmpwi 0,29,-1
	bc 12,2,.L503
	lis 30,.LC214@ha
.L512:
	lis 7,.LC219@ha
	mr 3,31
	la 7,.LC219@l(7)
	la 4,.LC214@l(30)
	lfs 1,0(7)
	addi 5,31,4
	bl ThrowDebris
	cmpwi 0,29,0
	addi 29,29,-1
	bc 4,2,.L512
.L503:
	lis 11,level@ha
	lwz 3,84(31)
	lwz 0,level@l(11)
	lis 25,0x4330
	lis 7,.LC222@ha
	la 7,.LC222@l(7)
	lfs 13,3896(3)
	xoris 0,0,0x8000
	lfd 30,0(7)
	stw 0,348(1)
	stw 25,344(1)
	lfd 0,344(1)
	lfs 31,3932(3)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L514
	fadds 31,31,31
.L514:
	lis 9,.LC219@ha
	la 9,.LC219@l(9)
	lfs 0,0(9)
	fcmpu 0,31,0
	bc 4,1,.L515
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 4,2,.L517
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 12,2,.L530
.L517:
	addi 29,1,280
	addi 28,1,296
	addi 27,1,312
	li 30,0
	stw 30,256(1)
	mr 5,28
	mr 6,27
	stw 30,252(1)
	addi 3,3,3728
	mr 4,29
	stw 30,248(1)
	bl AngleVectors
	lha 0,8(22)
	addi 26,1,264
	mr 3,29
	mr 4,26
	xoris 0,0,0x8000
	stw 0,348(1)
	stw 25,344(1)
	lfd 1,344(1)
	fsub 1,1,30
	frsp 1,1
	fmuls 1,1,31
	bl VectorScale
	lfs 9,248(1)
	mr 4,29
	mr 6,27
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
	addi 3,3,3728
	stfs 0,248(1)
	stfs 13,252(1)
	stfs 12,256(1)
	bl AngleVectors
	lha 0,10(22)
	mr 3,28
	mr 4,26
	xoris 0,0,0x8000
	stw 0,348(1)
	stw 25,344(1)
	lfd 1,344(1)
	fsub 1,1,30
	frsp 1,1
	fmuls 1,1,31
	bl VectorScale
	lfs 11,248(1)
	lfs 10,252(1)
	lfs 9,256(1)
	lfs 0,264(1)
	lfs 13,268(1)
	lfs 12,272(1)
	lwz 0,612(31)
	fadds 0,0,11
	fadds 13,13,10
	fadds 12,12,9
	cmpwi 0,0,0
	stfs 0,248(1)
	stfs 13,252(1)
	stfs 12,256(1)
	bc 4,2,.L518
	stw 30,256(1)
.L518:
	lwz 0,612(31)
	cmpwi 0,0,1
	bc 4,2,.L519
	lfs 12,248(1)
	lis 7,.LC223@ha
	fmr 10,31
	lfs 0,252(1)
	la 7,.LC223@l(7)
	lfs 13,256(1)
	lfd 11,0(7)
	b .L612
.L519:
	cmpwi 0,0,2
	bc 4,2,.L521
	lfs 12,248(1)
	lis 9,.LC224@ha
	fmr 10,31
	lfs 0,252(1)
	la 9,.LC224@l(9)
	lfs 13,256(1)
	lfd 11,0(9)
.L612:
	fmul 12,12,11
	fmul 0,0,11
	fmul 13,13,11
	fmul 10,10,11
	frsp 12,12
	frsp 0,0
	frsp 13,13
	stfs 12,248(1)
	frsp 31,10
	stfs 0,252(1)
	stfs 13,256(1)
	b .L520
.L521:
	cmpwi 0,0,3
	bc 4,2,.L520
	lfs 11,248(1)
	lis 9,.LC215@ha
	fmr 10,31
	lfs 13,252(1)
	lfs 12,256(1)
	lfd 0,.LC215@l(9)
	fmul 11,11,0
	fmul 13,13,0
	fmul 12,12,0
	fmul 10,10,0
	frsp 11,11
	frsp 13,13
	frsp 12,12
	frsp 31,10
	stfs 11,248(1)
	stfs 13,252(1)
	stfs 12,256(1)
.L520:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 4,2,.L613
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 12,2,.L526
.L613:
	lfs 0,248(1)
	lfs 13,252(1)
	lfs 12,256(1)
	lfs 11,376(31)
	lfs 10,380(31)
	lfs 9,384(31)
	fadds 0,0,11
	fadds 13,13,10
	fadds 12,12,9
	stfs 0,376(31)
	stfs 13,380(31)
	stfs 12,384(31)
	b .L525
.L526:
	lfs 0,248(1)
	lis 10,.LC225@ha
	lfs 13,252(1)
	la 10,.LC225@l(10)
	lfs 12,256(1)
	lfd 11,0(10)
	lfs 8,376(31)
	lfs 9,380(31)
	fmul 0,0,11
	lfs 10,384(31)
	fmul 13,13,11
	fmul 12,12,11
	frsp 0,0
	frsp 13,13
	frsp 12,12
	fadds 8,0,8
	stfs 0,248(1)
	fadds 9,13,9
	stfs 13,252(1)
	fadds 10,12,10
	stfs 12,256(1)
	stfs 8,376(31)
	stfs 9,380(31)
	stfs 10,384(31)
.L525:
	addi 0,31,376
	mr 3,0
	mr 24,0
	bl VectorLength
	lis 7,.LC226@ha
	la 7,.LC226@l(7)
	lfs 0,0(7)
	fmuls 13,31,0
	fcmpu 0,1,13
	bc 12,1,.L529
	lis 9,.LC227@ha
	la 9,.LC227@l(9)
	lfs 0,0(9)
	fmuls 0,31,0
	fcmpu 0,1,0
	bc 4,0,.L528
.L529:
	fdivs 1,13,1
	mr 3,24
	mr 4,3
	bl VectorScale
.L528:
	li 0,0
	sth 0,10(22)
	sth 0,8(22)
	b .L530
.L515:
	bc 4,0,.L530
	lis 7,.LC226@ha
	lha 0,8(22)
	la 7,.LC226@l(7)
	lfs 0,0(7)
	xoris 0,0,0x8000
	stw 0,348(1)
	stw 25,344(1)
	fmuls 31,31,0
	lfd 0,344(1)
	fsub 0,0,30
	frsp 13,0
	fcmpu 0,13,31
	bc 4,1,.L532
	fmr 0,31
	b .L614
.L532:
	fneg 0,31
	fcmpu 0,13,0
	bc 4,0,.L533
.L614:
	fctiwz 13,0
	stfd 13,344(1)
	lwz 9,348(1)
	sth 9,8(22)
.L533:
	lha 0,10(22)
	lis 11,0x4330
	lis 10,.LC222@ha
	xoris 0,0,0x8000
	la 10,.LC222@l(10)
	stw 0,348(1)
	stw 11,344(1)
	lfd 13,0(10)
	lfd 0,344(1)
	fsub 0,0,13
	frsp 13,0
	fcmpu 0,13,31
	bc 4,1,.L535
	fmr 0,31
	b .L615
.L535:
	fneg 0,31
	fcmpu 0,13,0
	bc 4,0,.L530
.L615:
	fctiwz 13,0
	stfd 13,344(1)
	lwz 9,348(1)
	sth 9,10(22)
.L530:
	lis 9,level@ha
	lis 11,.LC221@ha
	la 9,level@l(9)
	la 11,.LC221@l(11)
	lfs 13,0(11)
	lfs 0,200(9)
	stw 31,292(9)
	lwz 28,84(31)
	fcmpu 0,0,13
	bc 12,2,.L538
	li 0,4
	lis 7,.LC228@ha
	stw 0,0(28)
	la 7,.LC228@l(7)
	lfs 0,200(9)
	lfd 12,0(7)
	lfs 13,4(9)
	fadd 0,0,12
	fcmpu 0,13,0
	bc 4,1,.L502
	lbz 0,1(22)
	andi. 10,0,128
	bc 12,2,.L502
	li 0,1
	stw 0,208(9)
	b .L502
.L538:
	lwz 0,260(31)
	cmpwi 0,0,11
	bc 4,2,.L540
	li 0,4
	stw 0,0(28)
	b .L502
.L540:
	lwz 0,3888(28)
	lis 9,pm_passent@ha
	stw 31,pm_passent@l(9)
	cmpwi 0,0,0
	bc 12,2,.L541
	lha 0,2(22)
	lis 8,0x4330
	lis 7,.LC222@ha
	lis 9,.LC216@ha
	xoris 0,0,0x8000
	la 7,.LC222@l(7)
	lfd 13,.LC216@l(9)
	stw 0,348(1)
	mr 10,11
	mr 9,11
	stw 8,344(1)
	lis 17,maxclients@ha
	lfd 12,0(7)
	lfd 0,344(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3484(28)
	lha 0,4(22)
	xoris 0,0,0x8000
	stw 0,348(1)
	stw 8,344(1)
	lfd 0,344(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3488(28)
	lha 0,6(22)
	xoris 0,0,0x8000
	stw 0,348(1)
	stw 8,344(1)
	lfd 0,344(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3492(28)
	b .L542
.L541:
	addi 3,1,8
	li 4,0
	mr 26,3
	li 5,240
	crxor 6,6,6
	bl memset
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L547
	lwz 0,40(31)
	cmpwi 0,0,255
	li 0,3
	bc 4,2,.L547
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L547
	li 0,2
.L547:
	stw 0,0(28)
	lwz 0,3964(28)
	cmpwi 0,0,0
	bc 12,2,.L549
	li 0,0
	sth 0,18(28)
	b .L550
.L549:
	lis 10,sv_gravity@ha
	lfs 12,408(31)
	lwz 11,sv_gravity@l(10)
	lis 0,0x3f80
	lfs 0,20(11)
	fmuls 0,0,12
	fctiwz 13,0
	stfd 13,344(1)
	lwz 9,348(1)
	sth 9,18(28)
	stw 0,408(31)
.L550:
	mr 3,31
	bl Jet_Active
	cmpwi 0,3,0
	bc 12,2,.L551
	mr 3,31
	mr 4,22
	bl Jet_ApplyJet
.L551:
	lwz 0,0(28)
	cmpwi 0,0,3
	bc 4,2,.L552
	mr 3,31
	bl SV_Physics_FallFloat
.L552:
	lwz 0,0(28)
	lis 7,.LC229@ha
	addi 18,31,4
	lwz 9,4(28)
	la 7,.LC229@l(7)
	addi 24,31,376
	lwz 11,8(28)
	addi 19,1,12
	addi 21,1,18
	lwz 10,12(28)
	mr 3,19
	mr 5,18
	stw 0,8(1)
	mr 4,21
	mr 6,24
	stw 9,4(26)
	addi 29,28,3548
	addi 23,1,36
	li 9,3
	stw 11,8(26)
	lis 17,maxclients@ha
	stw 10,12(26)
	mtctr 9
	li 8,0
	lwz 0,16(28)
	lwz 9,20(28)
	lwz 11,24(28)
	lfs 11,0(7)
	li 7,0
	stw 0,16(26)
	stw 9,20(26)
	stw 11,24(26)
.L611:
	lfsx 0,7,5
	mr 11,9
	fmuls 0,0,11
	fctiwz 13,0
	stfd 13,344(1)
	lwz 9,348(1)
	sthx 9,8,3
	lfsx 0,7,6
	addi 7,7,4
	fmuls 0,0,11
	fctiwz 12,0
	stfd 12,344(1)
	lwz 11,348(1)
	sthx 11,8,4
	addi 8,8,2
	bdnz .L611
	mr 3,29
	addi 4,1,8
	li 5,28
	bl memcmp
	cmpwi 0,3,0
	bc 12,2,.L558
	li 0,1
	stw 0,52(1)
.L558:
	lis 10,.LC222@ha
	lis 9,gi@ha
	lwz 0,0(22)
	la 10,.LC222@l(10)
	la 9,gi@l(9)
	lwz 7,4(22)
	lfd 30,0(10)
	addi 3,1,8
	lis 11,PM_trace@ha
	lis 10,.LC230@ha
	lwz 6,84(9)
	la 11,PM_trace@l(11)
	la 10,.LC230@l(10)
	lwz 8,8(22)
	lis 20,0x4330
	lfd 31,0(10)
	mtlr 6
	li 25,0
	li 30,0
	lwz 10,12(22)
	li 27,3
	stw 0,36(1)
	lwz 0,52(9)
	stw 10,12(23)
	stw 7,4(23)
	stw 8,8(23)
	stw 11,240(1)
	stw 0,244(1)
	blrl
	lwz 0,8(1)
	lwz 9,4(26)
	lwz 11,8(26)
	lwz 10,12(26)
	stw 0,0(28)
	stw 9,4(28)
	stw 11,8(28)
	stw 10,12(28)
	lwz 0,16(26)
	lwz 9,20(26)
	lwz 11,24(26)
	stw 0,16(28)
	stw 9,20(28)
	stw 11,24(28)
	lwz 0,8(1)
	lwz 9,4(26)
	lwz 11,8(26)
	lwz 10,12(26)
	stw 0,3548(28)
	stw 9,4(29)
	stw 11,8(29)
	stw 10,12(29)
	lwz 0,24(26)
	lwz 9,16(26)
	lwz 11,20(26)
	stw 0,24(29)
	stw 9,16(29)
	stw 11,20(29)
.L562:
	lhax 0,25,19
	mr 3,31
	xoris 0,0,0x8000
	stw 0,348(1)
	stw 20,344(1)
	lfd 0,344(1)
	fsub 0,0,30
	fmul 0,0,31
	frsp 0,0
	stfsx 0,30,18
	bl Jet_Active
	cmpwi 0,3,0
	bc 12,2,.L564
	mr 3,31
	bl Jet_Active
	cmpwi 0,3,0
	bc 12,2,.L561
	lhax 0,25,21
	lfsx 12,30,24
	xoris 0,0,0x8000
	stw 0,348(1)
	stw 20,344(1)
	lfd 13,344(1)
	fabs 12,12
	fsub 13,13,30
	frsp 13,13
	fmr 0,13
	fmul 0,0,31
	fabs 0,0
	fcmpu 0,0,12
	bc 4,0,.L561
.L564:
	lhax 0,25,21
	xoris 0,0,0x8000
	stw 0,348(1)
	stw 20,344(1)
	lfd 0,344(1)
	fsub 0,0,30
	fmul 0,0,31
	frsp 0,0
	stfsx 0,30,24
.L561:
	addic. 27,27,-1
	addi 25,25,2
	addi 30,30,4
	bc 4,2,.L562
	lfs 0,220(1)
	lis 8,0x4330
	lfs 13,224(1)
	lis 7,.LC222@ha
	mr 11,9
	lfs 8,204(1)
	la 7,.LC222@l(7)
	mr 10,9
	lfs 9,208(1)
	mr 3,31
	lfs 10,212(1)
	lfs 11,216(1)
	stfs 0,204(31)
	stfs 13,208(31)
	stfs 8,188(31)
	stfs 9,192(31)
	stfs 10,196(31)
	stfs 11,200(31)
	lha 0,2(22)
	lfd 12,0(7)
	xoris 0,0,0x8000
	lis 7,.LC216@ha
	stw 0,348(1)
	stw 8,344(1)
	lfd 0,344(1)
	lfd 13,.LC216@l(7)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3484(28)
	lha 0,4(22)
	xoris 0,0,0x8000
	stw 0,348(1)
	stw 8,344(1)
	lfd 0,344(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3488(28)
	lha 0,6(22)
	xoris 0,0,0x8000
	stw 0,348(1)
	stw 8,344(1)
	lfd 0,344(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3492(28)
	bl Jet_Active
	cmpwi 0,3,0
	bc 12,2,.L566
	lwz 0,228(1)
	cmpwi 0,0,0
	bc 12,2,.L566
	mr 3,31
	bl Jet_AvoidGround
	cmpwi 0,3,0
	bc 12,2,.L566
	li 0,0
	stw 0,228(1)
.L566:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L569
	lwz 0,228(1)
	cmpwi 0,0,0
	bc 4,2,.L569
	lha 0,48(1)
	cmpwi 0,0,9
	bc 4,1,.L569
	lwz 0,236(1)
	cmpwi 0,0,0
	bc 4,2,.L569
	lwz 11,84(31)
	lis 10,level@ha
	lfs 13,384(31)
	lis 8,0x4330
	lis 7,.LC222@ha
	lfs 0,3944(11)
	la 7,.LC222@l(7)
	lfd 12,0(7)
	fmuls 11,13,0
	stfs 11,384(31)
	lwz 0,level@l(10)
	lfs 13,3896(11)
	xoris 0,0,0x8000
	stw 0,348(1)
	stw 8,344(1)
	lfd 0,344(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L570
	lis 9,.LC217@ha
	fmr 0,11
	lfd 13,.LC217@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,384(31)
.L570:
	lwz 9,84(31)
	lis 10,.LC221@ha
	la 10,.LC221@l(10)
	lfs 13,0(10)
	lfs 0,3944(9)
	fcmpu 0,0,13
	bc 12,2,.L572
	lis 29,gi@ha
	lis 3,.LC218@ha
	la 29,gi@l(29)
	la 3,.LC218@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC219@ha
	lis 9,.LC219@ha
	lis 10,.LC221@ha
	mr 5,3
	la 7,.LC219@l(7)
	la 9,.LC219@l(9)
	mtlr 0
	la 10,.LC221@l(10)
	li 4,2
	lfs 1,0(7)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	mr 4,18
	mr 3,31
	li 5,0
	bl PlayerNoise
	b .L572
.L569:
	lwz 0,3964(28)
	cmpwi 0,0,0
	bc 12,2,.L572
	lha 0,48(1)
	cmpwi 0,0,9
	bc 4,1,.L572
	li 0,3
	stw 0,3964(28)
.L572:
	lfs 0,200(1)
	lwz 10,228(1)
	lwz 0,236(1)
	lwz 11,232(1)
	cmpwi 0,10,0
	stw 0,612(31)
	stw 11,608(31)
	fctiwz 13,0
	stw 10,552(31)
	stfd 13,344(1)
	lwz 9,348(1)
	stw 9,508(31)
	bc 12,2,.L574
	lwz 0,92(10)
	stw 0,556(31)
.L574:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L575
	lfs 0,3656(28)
	lis 0,0x4220
	lis 9,0xc170
	stw 0,36(28)
	stw 9,28(28)
	stfs 0,32(28)
	b .L576
.L575:
	lfs 0,188(1)
	stfs 0,3728(28)
	lfs 13,192(1)
	stfs 13,3732(28)
	lfs 0,196(1)
	stfs 0,3736(28)
	lfs 13,188(1)
	stfs 13,28(28)
	lfs 0,192(1)
	stfs 0,32(28)
	lfs 13,196(1)
	stfs 13,36(28)
.L576:
	lwz 3,3972(28)
	cmpwi 0,3,0
	bc 12,2,.L577
	bl CTFGrapplePull
.L577:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L578
	mr 3,31
	bl G_TouchTriggers
.L578:
	lwz 0,56(1)
	li 27,0
	cmpw 0,27,0
	bc 4,0,.L542
	addi 29,1,60
.L582:
	li 11,0
	slwi 0,27,2
	cmpw 0,11,27
	lwzx 3,29,0
	addi 26,27,1
	bc 4,0,.L584
	lwz 0,0(29)
	cmpw 0,0,3
	bc 12,2,.L584
	mr 9,29
.L585:
	addi 11,11,1
	cmpw 0,11,27
	bc 4,0,.L584
	lwzu 0,4(9)
	cmpw 0,0,3
	bc 4,2,.L585
.L584:
	cmpw 0,11,27
	bc 4,2,.L581
	lwz 0,444(3)
	cmpwi 0,0,0
	bc 12,2,.L581
	mr 4,31
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L581:
	lwz 0,56(1)
	mr 27,26
	cmpw 0,27,0
	bc 12,0,.L582
.L542:
	lwz 0,3608(28)
	lwz 9,3908(28)
	stw 0,3612(28)
	lbz 0,1(22)
	cmpwi 0,9,0
	stw 0,3608(28)
	bc 12,2,.L592
	li 0,0
	stw 0,3608(28)
.L592:
	lwz 9,3612(28)
	lwz 11,3608(28)
	lwz 0,3616(28)
	andc 9,11,9
	or 0,0,9
	stw 0,3616(28)
	lbz 9,15(22)
	stw 9,640(31)
	lwz 0,3616(28)
	andi. 7,0,1
	bc 12,2,.L593
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L593
	lwz 0,3496(28)
	cmpwi 0,0,0
	bc 12,2,.L594
	lwz 0,3888(28)
	li 9,0
	stw 9,3616(28)
	cmpwi 0,0,0
	bc 12,2,.L595
	lbz 0,16(28)
	stw 9,3888(28)
	andi. 0,0,191
	stb 0,16(28)
	b .L593
.L595:
	mr 3,31
	bl GetChaseTarget
	b .L593
.L594:
	lwz 0,3620(28)
	cmpwi 0,0,0
	bc 4,2,.L593
	li 0,1
	mr 3,31
	stw 0,3620(28)
	bl Think_Weapon
.L593:
	lwz 0,3496(28)
	cmpwi 0,0,0
	bc 12,2,.L599
	lha 0,12(22)
	cmpwi 0,0,9
	bc 4,1,.L600
	lbz 0,16(28)
	andi. 7,0,2
	bc 4,2,.L599
	lwz 9,3888(28)
	ori 0,0,2
	stb 0,16(28)
	cmpwi 0,9,0
	bc 12,2,.L602
	mr 3,31
	bl ChaseNext
	b .L599
.L602:
	mr 3,31
	bl GetChaseTarget
	b .L599
.L600:
	lbz 0,16(28)
	andi. 0,0,253
	stb 0,16(28)
.L599:
	mr 3,31
	li 27,1
	bl CTFApplyRegeneration
	lis 11,maxclients@ha
	lis 7,.LC219@ha
	lwz 9,maxclients@l(11)
	la 7,.LC219@l(7)
	lfs 13,0(7)
	lfs 0,20(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L502
	lis 9,.LC222@ha
	lis 28,g_edicts@ha
	la 9,.LC222@l(9)
	lis 30,0x4330
	lfd 31,0(9)
	li 29,1160
.L608:
	lwz 0,g_edicts@l(28)
	add 3,0,29
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L607
	lwz 9,84(3)
	lwz 0,3888(9)
	cmpw 0,0,31
	bc 4,2,.L607
	bl UpdateChaseCam
.L607:
	addi 27,27,1
	lwz 11,maxclients@l(17)
	xoris 0,27,0x8000
	addi 29,29,1160
	stw 0,348(1)
	stw 30,344(1)
	lfd 0,344(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L608
.L502:
	lwz 0,436(1)
	mtlr 0
	lmw 17,356(1)
	lfd 30,416(1)
	lfd 31,424(1)
	la 1,432(1)
	blr
.Lfe17:
	.size	 ClientThink,.Lfe17-ClientThink
	.section	".rodata"
	.align 2
.LC231:
	.long 0x0
	.align 2
.LC232:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl ClientBeginServerFrame
	.type	 ClientBeginServerFrame,@function
ClientBeginServerFrame:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	lis 9,level@ha
	lis 11,.LC231@ha
	la 11,.LC231@l(11)
	la 29,level@l(9)
	lfs 31,0(11)
	mr 31,3
	lfs 0,200(29)
	fcmpu 0,0,31
	bc 4,2,.L616
	lwz 30,84(31)
	lwz 3,3952(30)
	cmpwi 0,3,0
	bc 12,2,.L618
	bl IceThink
.L618:
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L619
	lwz 9,1812(30)
	lwz 0,3496(30)
	cmpw 0,9,0
	bc 12,2,.L619
	lfs 0,4(29)
	lis 9,.LC232@ha
	lfs 13,3884(30)
	la 9,.LC232@l(9)
	lfs 12,0(9)
	fsubs 0,0,13
	fcmpu 0,0,12
	cror 3,2,1
	bc 4,3,.L619
	mr 3,31
	bl spectator_respawn
	b .L616
.L619:
	lwz 0,3620(30)
	cmpwi 0,0,0
	bc 4,2,.L620
	lwz 0,3496(30)
	cmpwi 0,0,0
	bc 4,2,.L620
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L620
	lwz 0,264(31)
	andi. 9,0,16384
	bc 4,2,.L620
	mr 3,31
	bl Think_Weapon
	b .L621
.L620:
	li 0,0
	stw 0,3620(30)
.L621:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L622
	lis 9,level@ha
	lfs 13,3884(30)
	la 29,level@l(9)
	lfs 0,4(29)
	fcmpu 0,0,13
	bc 4,1,.L616
	lis 9,.LC231@ha
	lis 11,deathmatch@ha
	lwz 10,3616(30)
	la 9,.LC231@l(9)
	lfs 12,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 7,0,12
	mfcr 0
	rlwinm 0,0,31,1
	neg 0,0
	ori 0,0,1
	and. 11,10,0
	bc 4,2,.L627
	bc 12,30,.L616
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1024
	bc 12,2,.L616
.L627:
	bc 4,30,.L628
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L629
.L628:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L630
	mr 3,31
	bl CopyToBodyQue
.L630:
	lwz 0,184(31)
	mr 3,31
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	bl PutClientInServer
	lwz 8,84(31)
	li 0,6
	li 11,32
	stw 0,80(31)
	li 10,14
	stb 11,16(8)
	lwz 9,84(31)
	stb 10,17(9)
	lfs 0,4(29)
	lwz 11,84(31)
	stfs 0,3884(11)
	b .L637
.L629:
	lis 9,gi+168@ha
	lis 3,.LC158@ha
	lwz 0,gi+168@l(9)
	la 3,.LC158@l(3)
	mtlr 0
	blrl
	b .L639
.L622:
	lwz 0,3496(30)
	cmpwi 0,0,0
	bc 4,2,.L632
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L632
	lis 9,.LC231@ha
	lis 11,autokeybinding@ha
	la 9,.LC231@l(9)
	lfs 13,0(9)
	lwz 9,autokeybinding@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L632
	lwz 9,3544(30)
	cmpwi 0,9,5
	bc 4,2,.L634
	mr 3,31
	bl Cmd_BindKeys
	lwz 9,3544(30)
	addi 9,9,1
	stw 9,3544(30)
	b .L632
.L634:
	cmpwi 0,9,4
	bc 12,1,.L632
	addi 0,9,1
	stw 0,3544(30)
.L632:
	lis 9,.LC231@ha
	lis 11,deathmatch@ha
	la 9,.LC231@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L637
	bl PlayerTrail_LastSpot
	mr 4,3
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L637
	addi 3,31,28
	bl PlayerTrail_Add
.L639:
.L637:
	li 0,0
	stw 0,3616(30)
.L616:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe18:
	.size	 ClientBeginServerFrame,.Lfe18-ClientBeginServerFrame
	.section	".rodata"
	.align 2
.LC233:
	.string	"pain daemon"
	.align 2
.LC234:
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
	lis 11,.LC234@ha
	lis 9,deathmatch@ha
	la 11,.LC234@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L362
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L361
.L362:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L363
	mr 3,31
	bl CopyToBodyQue
.L363:
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
	stfs 0,3884(11)
	b .L360
.L361:
	lis 9,gi+168@ha
	lis 3,.LC158@ha
	lwz 0,gi+168@l(9)
	la 3,.LC158@l(3)
	mtlr 0
	blrl
.L360:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe19:
	.size	 respawn,.Lfe19-respawn
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
	li 5,1644
	crxor 6,6,6
	bl memset
	li 0,1
	mr 3,29
	stw 0,720(29)
	bl ClearScanner
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 InitClientPersistant,.Lfe20-InitClientPersistant
	.section	".rodata"
	.align 2
.LC235:
	.long 0x0
	.section	".text"
	.align 2
	.globl InitClientResp
	.type	 InitClientResp,@function
InitClientResp:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 31,3
	li 4,0
	addi 29,31,1832
	lwz 28,3500(31)
	li 5,1716
	lwz 27,3528(31)
	mr 3,29
	lwz 26,3540(31)
	lwz 25,3544(31)
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	stw 28,3500(31)
	mr 3,29
	stw 27,3528(31)
	addi 4,31,188
	li 5,1644
	stw 26,3540(31)
	stw 25,3544(31)
	lwz 0,level@l(9)
	stw 0,3476(31)
	crxor 6,6,6
	bl memcpy
	lis 9,.LC235@ha
	lis 11,ctf@ha
	la 9,.LC235@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L234
	lwz 0,3500(31)
	cmpwi 0,0,0
	bc 12,1,.L234
	mr 3,31
	bl CTFAssignTeam
.L234:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
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
	lis 11,.LC157@ha
	stw 0,level+296@l(9)
	li 31,8
	la 30,.LC157@l(11)
.L347:
	bl G_Spawn
	addic. 31,31,-1
	stw 30,280(3)
	bc 4,2,.L347
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
.LC236:
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
	lis 9,.LC236@ha
	lwz 5,coop@l(11)
	li 7,0
	la 9,.LC236@l(9)
	addi 10,10,1160
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
	andi. 0,0,12336
	stw 0,732(9)
	lfs 0,20(5)
	fcmpu 0,0,13
	bc 12,2,.L238
	lwz 9,84(10)
	lwz 11,1028(8)
	lwz 0,3480(9)
	add 11,7,11
	stw 0,1800(11)
.L238:
	lwz 0,1544(3)
	addi 6,6,1
	addi 7,7,4016
	addi 10,10,1160
	cmpw 0,6,0
	bc 12,0,.L239
	blr
.Lfe24:
	.size	 SaveClientData,.Lfe24-SaveClientData
	.section	".rodata"
	.align 2
.LC237:
	.long 0x0
	.section	".text"
	.align 2
	.globl FetchClientEntData
	.type	 FetchClientEntData,@function
FetchClientEntData:
	lis 9,.LC237@ha
	lwz 7,84(3)
	lis 10,coop@ha
	la 9,.LC237@l(9)
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
	stw 0,3480(7)
	blr
.Lfe25:
	.size	 FetchClientEntData,.Lfe25-FetchClientEntData
	.align 2
	.globl RemoveAttackingPainDaemons
	.type	 RemoveAttackingPainDaemons,@function
RemoveAttackingPainDaemons:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 30,3
	lis 5,.LC233@ha
	la 5,.LC233@l(5)
	li 3,0
	li 4,280
	lis 29,.LC233@ha
	b .L647
.L643:
	lwz 0,540(31)
	cmpw 0,0,30
	bc 4,2,.L644
	mr 3,31
	bl G_FreeEdict
.L644:
	mr 3,31
	li 4,280
	la 5,.LC233@l(29)
.L647:
	bl G_Find
	mr. 31,3
	bc 4,2,.L643
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 12,2,.L646
	li 0,0
	stw 0,3928(3)
.L646:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe26:
	.size	 RemoveAttackingPainDaemons,.Lfe26-RemoveAttackingPainDaemons
	.section	".rodata"
	.align 2
.LC238:
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
	lis 9,.LC238@ha
	mr 30,3
	la 9,.LC238@l(9)
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
.Lfe27:
	.size	 SP_FixCoopSpots,.Lfe27-SP_FixCoopSpots
	.section	".rodata"
	.align 3
.LC239:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC240:
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
	lis 11,.LC240@ha
	lis 9,coop@ha
	la 11,.LC240@l(11)
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
	lis 11,.LC239@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC239@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
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
.LC241:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_player_deathmatch
	.type	 SP_info_player_deathmatch,@function
SP_info_player_deathmatch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC241@ha
	lis 9,deathmatch@ha
	la 11,.LC241@l(11)
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
.Lfe29:
	.size	 SP_info_player_deathmatch,.Lfe29-SP_info_player_deathmatch
	.align 2
	.globl SP_info_player_intermission
	.type	 SP_info_player_intermission,@function
SP_info_player_intermission:
	blr
.Lfe30:
	.size	 SP_info_player_intermission,.Lfe30-SP_info_player_intermission
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
	b .L648
.L30:
	li 3,0
.L648:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe31:
	.size	 IsFemale,.Lfe31-IsFemale
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
	bc 4,2,.L649
.L34:
	li 3,0
.L649:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe32:
	.size	 IsNeutral,.Lfe32-IsNeutral
	.section	".rodata"
	.align 2
.LC242:
	.long 0x4b18967f
	.align 2
.LC243:
	.long 0x3f800000
	.align 3
.LC244:
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
	lis 11,.LC243@ha
	lwz 10,maxclients@l(9)
	la 11,.LC243@l(11)
	mr 31,3
	lfs 13,0(11)
	li 29,1
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC242@ha
	lfs 31,.LC242@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L247
	lis 9,.LC244@ha
	lis 27,g_edicts@ha
	la 9,.LC244@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,1160
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
	addi 30,30,1160
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
.Lfe33:
	.size	 PlayersRangeFromSpot,.Lfe33-PlayersRangeFromSpot
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
	b .L651
.L298:
	bl SelectFarthestDeathmatchSpawnPoint
.L651:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe34:
	.size	 SelectDeathmatchSpawnPoint,.Lfe34-SelectDeathmatchSpawnPoint
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
	lis 9,0x9a02
	lwz 10,game+1028@l(11)
	ori 9,9,2611
	li 30,0
	li 3,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,4
	bc 12,2,.L652
.L304:
	lis 5,.LC2@ha
	mr 3,30
	la 5,.LC2@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L305
	li 3,0
	b .L652
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
.L652:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe35:
	.size	 SelectCoopSpawnPoint,.Lfe35-SelectCoopSpawnPoint
	.section	".rodata"
	.align 2
.LC245:
	.long 0x3f800000
	.align 2
.LC246:
	.long 0x0
	.align 2
.LC247:
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
	bc 4,0,.L350
	lis 29,gi@ha
	lis 3,.LC138@ha
	la 29,gi@l(29)
	la 3,.LC138@l(3)
	lwz 9,36(29)
	lis 27,.LC139@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC245@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC245@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC245@ha
	la 9,.LC245@l(9)
	lfs 2,0(9)
	lis 9,.LC246@ha
	la 9,.LC246@l(9)
	lfs 3,0(9)
	blrl
.L354:
	mr 3,31
	la 4,.LC139@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L354
	lis 9,.LC247@ha
	lfs 0,12(31)
	mr 4,28
	la 9,.LC247@l(9)
	mr 3,31
	lfs 13,0(9)
	fsubs 0,0,13
	stfs 0,12(31)
	bl ThrowClientHead
	stw 30,512(31)
.L350:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe36:
	.size	 body_die,.Lfe36-body_die
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
	bc 4,1,.L481
	lis 11,gi+48@ha
	lis 9,0x201
	lwz 0,gi+48@l(11)
	ori 9,9,3
	mtlr 0
	blrl
	b .L480
.L481:
	lis 11,gi+48@ha
	lis 9,0x1
	lwz 0,gi+48@l(11)
	mr 3,31
	ori 9,9,3
	mtlr 0
	blrl
.L480:
	mr 3,31
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe37:
	.size	 PM_trace,.Lfe37-PM_trace
	.align 2
	.globl CheckBlock
	.type	 CheckBlock,@function
CheckBlock:
	li 11,0
	li 9,0
	cmpw 0,11,4
	bc 4,0,.L485
.L487:
	lbzx 0,3,9
	addi 9,9,1
	cmpw 0,9,4
	add 11,11,0
	bc 12,0,.L487
.L485:
	mr 3,11
	blr
.Lfe38:
	.size	 CheckBlock,.Lfe38-CheckBlock
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
.L654:
	lbzx 0,3,9
	addi 9,9,1
	add 5,5,0
	bdnz .L654
	li 0,16
	lbz 4,42(3)
	li 6,0
	mtctr 0
	addi 3,3,28
	li 9,0
.L653:
	lbzx 0,3,9
	addi 9,9,1
	add 6,6,0
	bdnz .L653
	lis 3,.LC211@ha
	la 3,.LC211@l(3)
	crxor 6,6,6
	bl Com_Printf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe39:
	.size	 PrintPmove,.Lfe39-PrintPmove
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
.Lfe40:
	.size	 SP_CreateCoopSpots,.Lfe40-SP_CreateCoopSpots
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
