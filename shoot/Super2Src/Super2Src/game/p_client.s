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
	.string	"skin"
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
	.string	"should have used a smaller gun"
	.align 2
.LC40:
	.string	"turns to dust"
	.align 2
.LC41:
	.string	"is consumed by his rage"
	.align 2
.LC42:
	.string	"electrocutes himself"
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
	.string	"powers/jediup.wav"
	.align 2
.LC47:
	.string	"was blasted by"
	.align 2
.LC48:
	.string	"was gunned down by"
	.align 2
.LC49:
	.string	"was blown away by"
	.align 2
.LC50:
	.string	"'s super shotgun"
	.align 2
.LC51:
	.string	"was machinegunned by"
	.align 2
.LC52:
	.string	"was cut in half by"
	.align 2
.LC53:
	.string	"'s chaingun"
	.align 2
.LC54:
	.string	"was popped by"
	.align 2
.LC55:
	.string	"'s grenade"
	.align 2
.LC56:
	.string	"was shredded by"
	.align 2
.LC57:
	.string	"'s shrapnel"
	.align 2
.LC58:
	.string	"ate"
	.align 2
.LC59:
	.string	"'s rocket"
	.align 2
.LC60:
	.string	"almost dodged"
	.align 2
.LC61:
	.string	"was melted by"
	.align 2
.LC62:
	.string	"'s hyperblaster"
	.align 2
.LC63:
	.string	"was railed by"
	.align 2
.LC64:
	.string	"saw the pretty lights from"
	.align 2
.LC65:
	.string	"'s BFG"
	.align 2
.LC66:
	.string	"was disintegrated by"
	.align 2
.LC67:
	.string	"'s BFG blast"
	.align 2
.LC68:
	.string	"couldn't hide from"
	.align 2
.LC69:
	.string	"caught"
	.align 2
.LC70:
	.string	"'s handgrenade"
	.align 2
.LC71:
	.string	"didn't see"
	.align 2
.LC72:
	.string	"feels"
	.align 2
.LC73:
	.string	"'s pain"
	.align 2
.LC74:
	.string	"tried to invade"
	.align 2
.LC75:
	.string	"'s personal space"
	.align 2
.LC76:
	.string	"'s brain"
	.align 2
.LC77:
	.string	"got bopped with"
	.align 2
.LC78:
	.string	"'s bop gun"
	.align 2
.LC79:
	.string	"was flamed by"
	.align 2
.LC80:
	.string	"'s ball"
	.align 2
.LC81:
	.string	"is thrown around by"
	.align 2
.LC82:
	.string	"deals"
	.align 2
.LC83:
	.string	" a bad hand"
	.align 2
.LC84:
	.string	"is eviscerated by"
	.align 2
.LC85:
	.string	"gets torched by"
	.align 2
.LC86:
	.string	"was freaked by"
	.align 2
.LC87:
	.string	"gets spooked by"
	.align 2
.LC88:
	.string	"destroys"
	.align 2
.LC89:
	.string	" with his eye-beams"
	.align 2
.LC90:
	.string	"is assimilated by"
	.align 2
.LC91:
	.string	"gets lazed by"
	.align 2
.LC92:
	.string	"was irradiated by"
	.align 2
.LC93:
	.string	"is electrocuted by"
	.align 2
.LC94:
	.string	"instructs"
	.align 2
.LC95:
	.string	" in the ways of the Force"
	.align 2
.LC96:
	.string	"was bombed by"
	.align 2
.LC97:
	.string	"was mysteriously killed by"
	.align 2
.LC98:
	.string	"boots"
	.align 2
.LC99:
	.string	" in the head"
	.align 2
.LC100:
	.string	"gets run over by"
	.align 2
.LC101:
	.string	"looked directly at"
	.align 2
.LC102:
	.string	"plays with"
	.align 2
.LC103:
	.string	"'s Happy Fun Balls"
	.align 2
.LC104:
	.string	"say That's one less cripple.\n"
	.align 2
.LC105:
	.string	"%s sure got lucky.\n"
	.align 2
.LC106:
	.string	"%s %s %s%s\n"
	.align 2
.LC107:
	.string	"%s\nBounty: %i\n"
	.align 2
.LC108:
	.string	"Target terminated"
	.align 2
.LC109:
	.string	"%s\nReward: %i\n"
	.align 2
.LC110:
	.string	"Assassin terminated"
	.align 2
.LC111:
	.string	"%s died.\n"
	.align 2
.LC112:
	.long 0x0
	.align 2
.LC113:
	.long 0x40000000
	.align 2
.LC114:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl ClientObituary
	.type	 ClientObituary,@function
ClientObituary:
	stwu 1,-48(1)
	mflr 0
	stmw 22,8(1)
	stw 0,52(1)
	lis 11,.LC112@ha
	lis 9,coop@ha
	la 11,.LC112@l(11)
	mr 27,3
	lfs 13,0(11)
	mr 24,4
	mr 31,5
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L33
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L33
	lis 9,meansOfDeath@ha
	lwz 0,meansOfDeath@l(9)
	oris 0,0,0x800
	stw 0,meansOfDeath@l(9)
.L33:
	lis 11,.LC112@ha
	lis 9,deathmatch@ha
	la 11,.LC112@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L35
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L34
.L35:
	lis 9,meansOfDeath@ha
	lis 11,.LC22@ha
	lwz 0,meansOfDeath@l(9)
	la 30,.LC22@l(11)
	li 28,0
	rlwinm 26,0,0,6,3
	rlwinm 22,0,0,4,4
	addi 10,26,-17
	rlwinm 23,0,0,5,5
	cmplwi 0,10,16
	bc 12,1,.L36
	lis 11,.L51@ha
	slwi 10,10,2
	la 11,.L51@l(11)
	lis 9,.L51@ha
	lwzx 0,10,11
	la 9,.L51@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L51:
	.long .L40-.L51
	.long .L41-.L51
	.long .L42-.L51
	.long .L39-.L51
	.long .L36-.L51
	.long .L38-.L51
	.long .L37-.L51
	.long .L36-.L51
	.long .L44-.L51
	.long .L44-.L51
	.long .L50-.L51
	.long .L45-.L51
	.long .L50-.L51
	.long .L46-.L51
	.long .L50-.L51
	.long .L36-.L51
	.long .L47-.L51
.L37:
	lis 9,.LC23@ha
	la 28,.LC23@l(9)
	b .L36
.L38:
	lis 9,.LC24@ha
	la 28,.LC24@l(9)
	b .L36
.L39:
	lis 9,.LC25@ha
	la 28,.LC25@l(9)
	b .L36
.L40:
	lis 9,.LC26@ha
	la 28,.LC26@l(9)
	b .L36
.L41:
	lis 9,.LC27@ha
	la 28,.LC27@l(9)
	b .L36
.L42:
	lis 9,.LC28@ha
	la 28,.LC28@l(9)
	b .L36
.L44:
	lis 9,.LC29@ha
	la 28,.LC29@l(9)
	b .L36
.L45:
	lis 9,.LC30@ha
	la 28,.LC30@l(9)
	b .L36
.L46:
	lis 9,.LC31@ha
	la 28,.LC31@l(9)
	b .L36
.L47:
	lis 9,.LC32@ha
	la 28,.LC32@l(9)
	b .L36
.L50:
	lis 9,.LC33@ha
	la 28,.LC33@l(9)
.L36:
	cmpw 0,31,27
	bc 4,2,.L53
	addi 10,26,-7
	cmplwi 0,10,42
	bc 12,1,.L73
	lis 11,.L79@ha
	slwi 10,10,2
	la 11,.L79@l(11)
	lis 9,.L79@ha
	lwzx 0,10,11
	la 9,.L79@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L79:
	.long .L57-.L79
	.long .L73-.L79
	.long .L63-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L69-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L57-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L55-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L73-.L79
	.long .L70-.L79
	.long .L72-.L79
	.long .L71-.L79
.L55:
	lis 9,.LC34@ha
	la 28,.LC34@l(9)
	b .L53
.L57:
	lwz 3,84(27)
	cmpwi 0,3,0
	bc 4,2,.L59
	li 0,0
	b .L60
.L59:
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
.L60:
	cmpwi 0,0,0
	bc 12,2,.L58
	lis 9,.LC35@ha
	la 28,.LC35@l(9)
	b .L53
.L58:
	lis 9,.LC36@ha
	la 28,.LC36@l(9)
	b .L53
.L63:
	lwz 3,84(27)
	cmpwi 0,3,0
	bc 4,2,.L65
	li 0,0
	b .L66
.L65:
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
.L66:
	cmpwi 0,0,0
	bc 12,2,.L64
	lis 9,.LC37@ha
	la 28,.LC37@l(9)
	b .L53
.L64:
	lis 9,.LC38@ha
	la 28,.LC38@l(9)
	b .L53
.L69:
	lis 9,.LC39@ha
	la 28,.LC39@l(9)
	b .L53
.L70:
	lis 9,.LC40@ha
	la 28,.LC40@l(9)
	b .L53
.L71:
	lis 9,.LC41@ha
	la 28,.LC41@l(9)
	b .L53
.L72:
	lis 9,.LC42@ha
	la 28,.LC42@l(9)
	b .L53
.L73:
	lwz 3,84(27)
	cmpwi 0,3,0
	bc 4,2,.L75
	li 0,0
	b .L76
.L75:
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
.L76:
	cmpwi 0,0,0
	bc 12,2,.L74
	lis 9,.LC43@ha
	la 28,.LC43@l(9)
	b .L53
.L74:
	lis 9,.LC44@ha
	la 28,.LC44@l(9)
.L53:
	cmpwi 0,28,0
	bc 12,2,.L80
	lis 9,gi@ha
	lwz 5,84(27)
	lis 4,.LC45@ha
	lwz 0,gi@l(9)
	la 4,.LC45@l(4)
	mr 6,28
	addi 5,5,700
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,.LC112@ha
	lis 11,deathmatch@ha
	la 9,.LC112@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L81
	lwz 11,84(27)
	lwz 9,3496(11)
	addi 9,9,-1
	stw 9,3496(11)
.L81:
	li 0,0
	stw 0,540(27)
	b .L32
.L80:
	cmpwi 0,31,0
	stw 31,540(27)
	bc 12,2,.L34
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L34
	lwz 0,1816(9)
	li 25,0
	cmpwi 0,0,5
	bc 4,2,.L83
	cmpwi 0,26,37
	bc 4,2,.L84
	lis 11,.LC113@ha
	lfs 13,592(31)
	la 11,.LC113@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L84
	lis 9,.LC114@ha
	la 9,.LC114@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	stfs 0,592(31)
	b .L85
.L84:
	lis 11,.LC113@ha
	lfs 13,592(31)
	la 11,.LC113@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,0,.L85
	li 0,0
	stw 0,592(31)
.L85:
	lis 9,.LC113@ha
	lfs 13,592(31)
	la 9,.LC113@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L83
	lis 0,0x4040
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,592(31)
	lis 3,.LC46@ha
	lwz 9,36(29)
	la 3,.LC46@l(3)
	mtlr 9
	blrl
	lis 9,.LC114@ha
	lwz 0,16(29)
	lis 11,.LC112@ha
	la 9,.LC114@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC112@l(11)
	li 4,0
	mtlr 0
	lis 9,.LC112@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC112@l(9)
	lfs 3,0(9)
	blrl
.L83:
	cmplwi 0,26,55
	bc 12,1,.L88
	lis 11,.L128@ha
	slwi 10,26,2
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
	.long .L123-.L128
	.long .L89-.L128
	.long .L90-.L128
	.long .L91-.L128
	.long .L92-.L128
	.long .L93-.L128
	.long .L94-.L128
	.long .L95-.L128
	.long .L96-.L128
	.long .L97-.L128
	.long .L98-.L128
	.long .L99-.L128
	.long .L100-.L128
	.long .L101-.L128
	.long .L102-.L128
	.long .L103-.L128
	.long .L104-.L128
	.long .L88-.L128
	.long .L88-.L128
	.long .L88-.L128
	.long .L88-.L128
	.long .L106-.L128
	.long .L88-.L128
	.long .L88-.L128
	.long .L105-.L128
	.long .L88-.L128
	.long .L88-.L128
	.long .L88-.L128
	.long .L88-.L128
	.long .L88-.L128
	.long .L88-.L128
	.long .L88-.L128
	.long .L88-.L128
	.long .L88-.L128
	.long .L107-.L128
	.long .L108-.L128
	.long .L109-.L128
	.long .L110-.L128
	.long .L111-.L128
	.long .L112-.L128
	.long .L113-.L128
	.long .L114-.L128
	.long .L115-.L128
	.long .L116-.L128
	.long .L117-.L128
	.long .L118-.L128
	.long .L119-.L128
	.long .L88-.L128
	.long .L120-.L128
	.long .L88-.L128
	.long .L121-.L128
	.long .L122-.L128
	.long .L124-.L128
	.long .L125-.L128
	.long .L126-.L128
	.long .L127-.L128
.L89:
	lis 9,.LC47@ha
	la 28,.LC47@l(9)
	b .L88
.L90:
	lis 9,.LC48@ha
	la 28,.LC48@l(9)
	b .L88
.L91:
	lis 9,.LC49@ha
	lis 11,.LC50@ha
	la 28,.LC49@l(9)
	la 30,.LC50@l(11)
	b .L88
.L92:
	lis 9,.LC51@ha
	la 28,.LC51@l(9)
	b .L88
.L93:
	lis 9,.LC52@ha
	lis 11,.LC53@ha
	la 28,.LC52@l(9)
	la 30,.LC53@l(11)
	b .L88
.L94:
	lis 9,.LC54@ha
	lis 11,.LC55@ha
	la 28,.LC54@l(9)
	la 30,.LC55@l(11)
	b .L88
.L95:
	lis 9,.LC56@ha
	lis 11,.LC57@ha
	la 28,.LC56@l(9)
	la 30,.LC57@l(11)
	b .L88
.L96:
	lis 9,.LC58@ha
	lis 11,.LC59@ha
	la 28,.LC58@l(9)
	la 30,.LC59@l(11)
	b .L88
.L97:
	lis 9,.LC60@ha
	lis 11,.LC59@ha
	la 28,.LC60@l(9)
	la 30,.LC59@l(11)
	b .L88
.L98:
	lis 9,.LC61@ha
	lis 11,.LC62@ha
	la 28,.LC61@l(9)
	la 30,.LC62@l(11)
	b .L88
.L99:
	lis 9,.LC63@ha
	la 28,.LC63@l(9)
	b .L88
.L100:
	lis 9,.LC64@ha
	lis 11,.LC65@ha
	la 28,.LC64@l(9)
	la 30,.LC65@l(11)
	b .L88
.L101:
	lis 9,.LC66@ha
	lis 11,.LC67@ha
	la 28,.LC66@l(9)
	la 30,.LC67@l(11)
	b .L88
.L102:
	lis 9,.LC68@ha
	lis 11,.LC65@ha
	la 28,.LC68@l(9)
	la 30,.LC65@l(11)
	b .L88
.L103:
	lis 9,.LC69@ha
	lis 11,.LC70@ha
	la 28,.LC69@l(9)
	la 30,.LC70@l(11)
	b .L88
.L104:
	lis 9,.LC71@ha
	lis 11,.LC70@ha
	la 28,.LC71@l(9)
	la 30,.LC70@l(11)
	b .L88
.L105:
	lis 9,.LC72@ha
	lis 11,.LC73@ha
	la 28,.LC72@l(9)
	la 30,.LC73@l(11)
	b .L88
.L106:
	lis 9,.LC74@ha
	lis 11,.LC75@ha
	la 28,.LC74@l(9)
	la 30,.LC75@l(11)
	b .L88
.L107:
	lis 9,.LC27@ha
	lis 11,.LC76@ha
	la 28,.LC27@l(9)
	la 30,.LC76@l(11)
	li 25,1
	b .L88
.L108:
	lis 9,.LC77@ha
	lis 11,.LC78@ha
	la 28,.LC77@l(9)
	la 30,.LC78@l(11)
	b .L88
.L109:
	lis 9,.LC79@ha
	lis 11,.LC80@ha
	la 28,.LC79@l(9)
	la 30,.LC80@l(11)
	b .L88
.L110:
	lis 9,.LC81@ha
	la 28,.LC81@l(9)
	b .L88
.L111:
	lis 9,.LC82@ha
	lis 11,.LC83@ha
	la 28,.LC82@l(9)
	la 30,.LC83@l(11)
	li 25,1
	b .L88
.L112:
	lis 9,.LC84@ha
	la 28,.LC84@l(9)
	b .L88
.L113:
	lis 9,.LC85@ha
	la 28,.LC85@l(9)
	b .L88
.L114:
	lis 9,.LC86@ha
	la 28,.LC86@l(9)
	b .L88
.L115:
	lis 9,.LC87@ha
	la 28,.LC87@l(9)
	b .L88
.L116:
	lis 9,.LC88@ha
	lis 11,.LC89@ha
	la 28,.LC88@l(9)
	la 30,.LC89@l(11)
	li 25,1
	b .L88
.L117:
	lis 9,.LC90@ha
	la 28,.LC90@l(9)
	b .L88
.L118:
	lis 9,.LC91@ha
	la 28,.LC91@l(9)
	b .L88
.L119:
	lis 9,.LC92@ha
	la 28,.LC92@l(9)
	b .L88
.L120:
	lis 9,.LC93@ha
	la 28,.LC93@l(9)
	b .L88
.L121:
	lis 9,.LC94@ha
	lis 11,.LC95@ha
	la 28,.LC94@l(9)
	la 30,.LC95@l(11)
	li 25,1
	b .L88
.L122:
	lis 9,.LC96@ha
	la 28,.LC96@l(9)
	b .L88
.L123:
	lis 9,.LC97@ha
	la 28,.LC97@l(9)
	b .L88
.L124:
	lis 9,.LC98@ha
	lis 11,.LC99@ha
	la 28,.LC98@l(9)
	la 30,.LC99@l(11)
	li 25,1
	b .L88
.L125:
	lis 9,.LC100@ha
	la 28,.LC100@l(9)
	b .L88
.L126:
	lis 9,.LC101@ha
	la 28,.LC101@l(9)
	b .L88
.L127:
	lis 9,.LC102@ha
	lis 11,.LC103@ha
	la 28,.LC102@l(9)
	la 30,.LC103@l(11)
.L88:
	lwz 9,84(27)
	lwz 0,1816(9)
	cmpwi 0,0,4
	bc 4,2,.L130
	lis 4,.LC104@ha
	mr 3,31
	la 4,.LC104@l(4)
	bl stuffcmd
.L130:
	cmpwi 0,23,0
	bc 12,2,.L131
	lis 9,gi@ha
	lwz 5,84(31)
	lis 4,.LC105@ha
	lwz 0,gi@l(9)
	la 4,.LC105@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L131:
	cmpwi 0,28,0
	bc 12,2,.L34
	cmpwi 0,25,0
	bc 4,2,.L133
	lis 9,gi@ha
	lwz 5,84(27)
	lis 4,.LC106@ha
	lwz 7,84(31)
	la 4,.LC106@l(4)
	mr 6,28
	lwz 0,gi@l(9)
	addi 5,5,700
	mr 8,30
	addi 7,7,700
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L134
.L133:
	lis 9,gi@ha
	lwz 5,84(31)
	lis 4,.LC106@ha
	lwz 7,84(27)
	la 4,.LC106@l(4)
	mr 6,28
	lwz 0,gi@l(9)
	addi 5,5,700
	mr 8,30
	addi 7,7,700
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
.L134:
	lis 9,.LC112@ha
	lis 11,deathmatch@ha
	la 9,.LC112@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L32
	cmpwi 0,22,0
	bc 12,2,.L136
	lwz 11,84(31)
	b .L147
.L136:
	lwz 9,84(31)
	lwz 11,3496(9)
	addi 11,11,1
	stw 11,3496(9)
	lwz 11,84(31)
	lwz 0,1808(11)
	cmpwi 0,0,-1
	bc 4,2,.L138
	lwz 9,3496(11)
	addi 9,9,2
	stw 9,3496(11)
	b .L32
.L138:
	cmpwi 0,11,0
	bc 12,2,.L32
	lwz 0,84(27)
	cmpwi 0,0,0
	mr 9,0
	bc 12,2,.L140
	lwz 0,932(31)
	cmpw 0,0,27
	bc 4,2,.L140
	lwz 0,1816(11)
	cmpwi 0,0,3
	bc 4,2,.L140
	bl rand
	lis 9,0x5555
	mr 29,3
	lwz 8,84(31)
	ori 9,9,21846
	srawi 10,29,31
	mulhw 9,29,9
	lwz 11,3496(8)
	lis 28,gi@ha
	lis 3,.LC108@ha
	la 28,gi@l(28)
	la 3,.LC108@l(3)
	subf 9,10,9
	slwi 0,9,1
	add 0,0,9
	subf 29,0,29
	addi 29,29,2
	add 11,11,29
	stw 11,3496(8)
	bl Green1
	lwz 0,12(28)
	mr 5,3
	lis 4,.LC107@ha
	mr 3,31
	la 4,.LC107@l(4)
	b .L148
.L140:
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L32
	cmpwi 0,9,0
	bc 12,2,.L32
	lwz 0,932(27)
	cmpw 0,0,31
	bc 4,2,.L32
	bl rand
	mr 29,3
	lwz 11,84(31)
	lis 28,gi@ha
	srwi 0,29,31
	lis 3,.LC110@ha
	add 0,29,0
	lwz 9,3496(11)
	la 28,gi@l(28)
	rlwinm 0,0,0,0,30
	la 3,.LC110@l(3)
	subf 29,0,29
	addi 29,29,1
	add 9,9,29
	stw 9,3496(11)
	bl Green1
	lwz 0,12(28)
	mr 5,3
	lis 4,.LC109@ha
	mr 3,31
	la 4,.LC109@l(4)
.L148:
	mr 6,29
	mtlr 0
	crxor 6,6,6
	blrl
	b .L32
.L34:
	lis 9,gi@ha
	lwz 5,84(27)
	lis 4,.LC111@ha
	lwz 0,gi@l(9)
	la 4,.LC111@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,.LC112@ha
	lis 11,deathmatch@ha
	la 9,.LC112@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L143
	lwz 11,84(27)
.L147:
	lwz 9,3496(11)
	addi 9,9,-1
	stw 9,3496(11)
	b .L32
.L143:
	cmpw 0,31,24
	bc 12,2,.L146
	lwz 0,256(24)
	cmpw 0,0,31
	bc 4,2,.L32
.L146:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 12,2,.L32
	lwz 9,3496(3)
	addi 9,9,1
	stw 9,3496(3)
.L32:
	lwz 0,52(1)
	mtlr 0
	lmw 22,8(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 ClientObituary,.Lfe2-ClientObituary
	.section	".rodata"
	.align 2
.LC115:
	.string	"Blaster"
	.align 2
.LC116:
	.string	"item_quad"
	.align 3
.LC117:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC118:
	.long 0x0
	.align 3
.LC119:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC120:
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
	lwz 0,264(30)
	andis. 9,0,64
	bc 4,2,.L149
	lwz 4,84(30)
	lwz 11,1816(4)
	xori 9,11,2
	subfic 10,9,0
	adde 9,10,9
	xori 0,11,6
	subfic 10,0,0
	adde 0,10,0
	or. 10,9,0
	bc 4,2,.L149
	cmpwi 0,11,4
	bc 12,2,.L149
	lis 9,.LC118@ha
	lis 11,deathmatch@ha
	la 9,.LC118@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L149
	lwz 9,3568(4)
	addi 10,4,740
	lwz 31,1788(4)
	slwi 9,9,2
	lwzx 11,10,9
	srawi 10,11,31
	xor 0,10,11
	subf 0,0,10
	srawi 0,0,31
	and. 31,31,0
	bc 12,2,.L155
	lwz 3,40(31)
	lis 4,.LC115@ha
	la 4,.LC115@l(4)
	bl strcmp
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	and 31,31,0
.L155:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,16384
	bc 4,2,.L156
	li 29,0
	b .L157
.L156:
	lis 10,level@ha
	lwz 8,84(30)
	lwz 9,level@l(10)
	lis 0,0x4330
	lis 10,.LC119@ha
	lfs 12,3764(8)
	addi 9,9,10
	la 10,.LC119@l(10)
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
.L157:
	addic 9,31,-1
	subfe 0,9,31
	lis 10,.LC118@ha
	and. 9,0,29
	la 10,.LC118@l(10)
	lfs 31,0(10)
	bc 12,2,.L158
	lis 10,.LC120@ha
	la 10,.LC120@l(10)
	lfs 31,0(10)
.L158:
	cmpwi 0,31,0
	bc 12,2,.L160
	lwz 9,84(30)
	mr 4,31
	mr 3,30
	lfs 0,3696(9)
	fsubs 0,0,31
	stfs 0,3696(9)
	bl Drop_Item
	lwz 9,84(30)
	lis 0,0x2
	lfs 0,3696(9)
	fadds 0,0,31
	stfs 0,3696(9)
	stw 0,284(3)
.L160:
	cmpwi 0,29,0
	bc 12,2,.L149
	lwz 9,84(30)
	lis 3,.LC116@ha
	la 3,.LC116@l(3)
	lfs 0,3696(9)
	fadds 0,0,31
	stfs 0,3696(9)
	bl FindItemByClassname
	mr 4,3
	mr 3,30
	bl Drop_Item
	lwz 7,84(30)
	lis 9,.LC119@ha
	lis 11,Touch_Item@ha
	la 9,.LC119@l(9)
	la 11,Touch_Item@l(11)
	lfs 0,3696(7)
	lis 6,level@ha
	lfd 10,0(9)
	lis 4,0x4330
	la 5,level@l(6)
	lis 9,.LC117@ha
	lis 10,G_FreeEdict@ha
	fsubs 0,0,31
	lfd 11,.LC117@l(9)
	la 10,G_FreeEdict@l(10)
	stfs 0,3696(7)
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
	lfs 0,3764(11)
	stw 10,436(3)
	fsub 13,13,10
	frsp 13,13
	fsubs 0,0,13
	fmadd 0,0,11,12
	frsp 0,0
	stfs 0,428(3)
.L149:
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
.LC123:
	.string	"misc/udeath.wav"
	.align 2
.LC124:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.section	".sbss","aw",@nobits
	.align 2
i.39:
	.space	4
	.size	 i.39,4
	.section	".rodata"
	.align 2
.LC125:
	.string	"*death%i.wav"
	.align 3
.LC122:
	.long 0x404ca5dc
	.long 0x1a63c1f8
	.align 3
.LC126:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC127:
	.long 0x0
	.align 2
.LC128:
	.long 0x3f800000
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
	mr 30,5
	lwz 11,84(31)
	xor 0,30,31
	mr 29,4
	addic 10,0,-1
	subfe 9,10,0
	mr 27,6
	lwz 0,1812(11)
	xori 0,0,11
	subfic 11,0,0
	adde 0,11,0
	and. 10,0,9
	bc 12,2,.L168
	lwz 0,480(31)
	cmpwi 0,0,-40
	bc 4,1,.L168
	mr 4,30
	bl death_blossom
.L168:
	mr 3,31
	bl CTFDrop_Flag
	lwz 3,412(31)
	cmpwi 0,3,0
	bc 12,2,.L169
	bl G_FreeEdict
	li 0,0
	stw 0,412(31)
.L169:
	lis 9,invis_index@ha
	lwz 11,40(31)
	lwz 0,invis_index@l(9)
	cmpw 0,11,0
	bc 12,2,.L171
	lis 9,sun_index@ha
	lwz 0,sun_index@l(9)
	cmpw 0,11,0
	bc 4,2,.L170
.L171:
	li 0,255
	stw 0,40(31)
.L170:
	lwz 3,560(31)
	cmpwi 0,3,0
	bc 12,2,.L172
	bl G_FreeEdict
	li 0,0
	stw 0,560(31)
.L172:
	li 0,0
	li 11,0
	lwz 7,84(31)
	li 9,1
	li 10,7
	stw 0,24(31)
	stw 9,512(31)
	lis 8,0xc100
	stw 0,396(31)
	stw 0,392(31)
	stw 0,388(31)
	stw 0,16(31)
	stw 10,260(31)
	stw 11,44(31)
	stw 11,76(31)
	stw 11,3792(7)
	lwz 9,492(31)
	lwz 0,184(31)
	cmpwi 0,9,0
	stw 8,208(31)
	ori 0,0,2
	stw 0,184(31)
	bc 4,2,.L173
	lis 9,level+4@ha
	lis 10,.LC126@ha
	lwz 11,84(31)
	lfs 0,level+4@l(9)
	la 10,.LC126@l(10)
	cmpwi 0,30,0
	lfd 13,0(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3800(11)
	bc 12,2,.L174
	lis 9,g_edicts@ha
	xor 11,30,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,30,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L174
	lfs 11,4(31)
	lfs 13,4(30)
	lfs 12,8(30)
	lfs 10,8(31)
	fsubs 13,13,11
	lfs 0,12(30)
	b .L198
.L174:
	cmpwi 0,29,0
	bc 12,2,.L176
	lis 9,g_edicts@ha
	xor 11,29,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,29,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L176
	lfs 11,4(31)
	lfs 13,4(29)
	lfs 12,8(29)
	lfs 10,8(31)
	fsubs 13,13,11
	lfs 0,12(29)
.L198:
	lfs 11,12(31)
	fsubs 12,12,10
	stfs 13,8(1)
	fsubs 0,0,11
	stfs 12,12(1)
	stfs 0,16(1)
	b .L175
.L176:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3620(9)
	b .L178
.L175:
	lfs 1,12(1)
	lfs 2,8(1)
	bl atan2
	lis 9,.LC122@ha
	lwz 11,84(31)
	lfd 0,.LC122@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,3620(11)
.L178:
	lwz 9,84(31)
	li 0,2
	mr 4,29
	mr 3,31
	mr 5,30
	stw 0,0(9)
	bl ClientObituary
	cmpw 0,30,31
	bc 12,2,.L179
	mr 3,31
	bl TossClientWeapon
.L179:
	lis 9,.LC127@ha
	lis 11,deathmatch@ha
	la 9,.LC127@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L173
	mr 3,31
	bl Cmd_Help_f
.L173:
	lwz 11,84(31)
	li 0,0
	li 4,0
	li 5,1024
	stw 0,3764(11)
	lwz 9,84(31)
	stw 0,3768(9)
	lwz 11,84(31)
	stw 0,3772(11)
	lwz 9,84(31)
	stw 0,3776(9)
	lwz 3,84(31)
	addi 3,3,740
	crxor 6,6,6
	bl memset
	lwz 0,480(31)
	cmpwi 0,0,-40
	bc 4,0,.L181
	lis 29,gi@ha
	lis 3,.LC123@ha
	la 29,gi@l(29)
	la 3,.LC123@l(3)
	lwz 9,36(29)
	lis 28,.LC124@ha
	li 30,4
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC128@ha
	lis 10,.LC128@ha
	lis 11,.LC127@ha
	mr 5,3
	la 9,.LC128@l(9)
	la 10,.LC128@l(10)
	mtlr 0
	la 11,.LC127@l(11)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L185:
	mr 3,31
	la 4,.LC124@l(28)
	mr 5,27
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L185
	mr 4,27
	mr 3,31
	bl ThrowClientHead
	stw 30,512(31)
	b .L187
.L181:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L187
	lis 8,i.39@ha
	lis 9,0x5555
	lwz 6,84(31)
	lwz 10,i.39@l(8)
	ori 9,9,21846
	li 7,5
	addi 10,10,1
	mulhw 9,10,9
	srawi 11,10,31
	subf 9,11,9
	slwi 0,9,1
	add 0,0,9
	subf 10,0,10
	stw 10,i.39@l(8)
	stw 7,3752(6)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L189
	li 0,172
	li 9,177
	b .L199
.L189:
	cmpwi 0,10,1
	bc 12,2,.L193
	bc 12,1,.L197
	cmpwi 0,10,0
	bc 12,2,.L192
	b .L190
.L197:
	cmpwi 0,10,2
	bc 12,2,.L194
	b .L190
.L192:
	li 0,177
	li 9,183
	b .L199
.L193:
	li 0,183
	li 9,189
	b .L199
.L194:
	li 0,189
	li 9,197
.L199:
	stw 0,56(31)
	stw 9,3748(11)
.L190:
	lis 29,gi@ha
	la 29,gi@l(29)
	bl rand
	mr 4,3
	srawi 0,4,31
	lis 3,.LC125@ha
	srwi 0,0,30
	la 3,.LC125@l(3)
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
	lis 9,.LC128@ha
	lis 10,.LC128@ha
	lis 11,.LC127@ha
	mr 5,3
	la 9,.LC128@l(9)
	la 10,.LC128@l(10)
	mtlr 0
	la 11,.LC127@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L187:
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
.Lfe4:
	.size	 player_die,.Lfe4-player_die
	.section	".rodata"
	.align 2
.LC129:
	.string	"Shotgun"
	.align 2
.LC130:
	.string	"shells"
	.section	".text"
	.align 2
	.globl InitClientPersistant
	.type	 InitClientPersistant,@function
InitClientPersistant:
	stwu 1,-64(1)
	mflr 0
	stmw 20,16(1)
	stw 0,68(1)
	mr 31,3
	li 4,0
	li 5,1652
	lwz 30,1808(31)
	addi 3,31,188
	lwz 24,1804(31)
	lis 28,0x38e3
	addi 27,31,740
	lwz 20,1812(31)
	ori 28,28,36409
	li 25,1
	lwz 23,1816(31)
	lwz 22,1820(31)
	lwz 21,1824(31)
	crxor 6,6,6
	bl memset
	lis 3,.LC115@ha
	la 3,.LC115@l(3)
	bl FindItem
	lis 29,itemlist@ha
	lis 9,.LC129@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	mullw 0,0,28
	la 3,.LC129@l(9)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,736(31)
	stwx 25,27,9
	bl FindItem
	mr 26,3
	subf 0,29,26
	lis 3,.LC130@ha
	mullw 0,0,28
	la 3,.LC130@l(3)
	srawi 0,0,3
	slwi 9,0,2
	stw 0,736(31)
	stwx 25,27,9
	bl FindItem
	subf 3,29,3
	li 0,25
	mullw 3,3,28
	cmpwi 0,30,11
	li 9,100
	srawi 3,3,3
	slwi 3,3,2
	stwx 0,27,3
	stw 26,1788(31)
	stw 9,724(31)
	bc 4,2,.L201
	li 0,400
	stw 0,728(31)
	b .L202
.L201:
	cmpwi 0,30,-4
	bc 4,2,.L203
	li 0,250
	stw 0,728(31)
	b .L202
.L203:
	cmpwi 0,30,-3
	bc 4,2,.L205
	li 0,40
	stw 0,728(31)
	b .L202
.L205:
	stw 9,728(31)
.L202:
	li 9,50
	li 10,200
	stw 24,1804(31)
	li 11,100
	li 0,1
	stw 10,1780(31)
	stw 0,720(31)
	stw 11,1768(31)
	stw 9,1784(31)
	stw 30,1808(31)
	stw 20,1812(31)
	stw 23,1816(31)
	stw 22,1820(31)
	stw 21,1824(31)
	stw 10,1764(31)
	stw 9,1772(31)
	stw 9,1776(31)
	lwz 0,68(1)
	mtlr 0
	lmw 20,16(1)
	la 1,64(1)
	blr
.Lfe5:
	.size	 InitClientPersistant,.Lfe5-InitClientPersistant
	.section	".rodata"
	.align 2
.LC133:
	.string	"info_player_deathmatch"
	.align 2
.LC132:
	.long 0x47c34f80
	.align 2
.LC134:
	.long 0x4b18967f
	.align 2
.LC135:
	.long 0x3f800000
	.align 3
.LC136:
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
	lis 9,.LC132@ha
	li 28,0
	lfs 29,.LC132@l(9)
	li 30,0
	li 23,0
	li 24,0
	fmr 28,29
	lis 22,.LC133@ha
	b .L230
.L232:
	lis 10,.LC135@ha
	lis 9,maxclients@ha
	la 10,.LC135@l(10)
	lis 11,.LC134@ha
	lfs 13,0(10)
	addi 28,28,1
	li 29,1
	lwz 10,maxclients@l(9)
	lis 25,maxclients@ha
	lfs 31,.LC134@l(11)
	lfs 0,20(10)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L241
	lis 11,.LC136@ha
	lis 26,g_edicts@ha
	la 11,.LC136@l(11)
	lis 27,0x4330
	lfd 30,0(11)
	li 31,936
.L235:
	lwz 0,g_edicts@l(26)
	add 11,0,31
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L237
	lwz 0,84(11)
	cmpwi 0,0,0
	bc 4,2,.L238
	lwz 0,184(11)
	andi. 9,0,4
	bc 12,2,.L237
.L238:
	lwz 0,480(11)
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
	addi 31,31,936
	stw 0,36(1)
	stw 27,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L235
.L241:
	fcmpu 0,31,28
	bc 4,0,.L243
	fmr 28,31
	mr 24,30
	b .L230
.L243:
	fcmpu 0,31,29
	bc 4,0,.L230
	fmr 29,31
	mr 23,30
.L230:
	lis 5,.LC133@ha
	mr 3,30
	la 5,.LC133@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L232
	cmpwi 0,28,0
	bc 4,2,.L247
	li 3,0
	b .L255
.L247:
	cmpwi 0,28,2
	bc 12,1,.L248
	li 23,0
	li 24,0
	b .L249
.L248:
	addi 28,28,-2
.L249:
	bl rand
	li 30,0
	divw 0,3,28
	mullw 0,0,28
	subf 31,0,3
.L254:
	mr 3,30
	li 4,280
	la 5,.LC133@l(22)
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
	bc 4,2,.L254
.L255:
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
.LC137:
	.long 0x4b18967f
	.align 2
.LC138:
	.long 0x0
	.align 2
.LC139:
	.long 0x3f800000
	.align 3
.LC140:
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
	lis 9,.LC138@ha
	li 30,0
	la 9,.LC138@l(9)
	li 25,0
	lfs 29,0(9)
	b .L257
.L259:
	lis 9,maxclients@ha
	lis 11,.LC139@ha
	lwz 10,maxclients@l(9)
	la 11,.LC139@l(11)
	li 29,1
	lfs 13,0(11)
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC137@ha
	lfs 31,.LC137@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L268
	lis 9,.LC140@ha
	lis 27,g_edicts@ha
	la 9,.LC140@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 31,936
.L262:
	lwz 0,g_edicts@l(27)
	add 11,0,31
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L264
	lwz 0,84(11)
	cmpwi 0,0,0
	bc 4,2,.L265
	lwz 0,184(11)
	andi. 9,0,4
	bc 12,2,.L264
.L265:
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L264
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
	bc 4,0,.L264
	fmr 31,1
.L264:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 31,31,936
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L262
.L268:
	fcmpu 0,31,29
	bc 4,1,.L257
	fmr 29,31
	mr 25,30
.L257:
	lis 31,.LC133@ha
	mr 3,30
	li 4,280
	la 5,.LC133@l(31)
	bl G_Find
	mr. 30,3
	bc 4,2,.L259
	cmpwi 0,25,0
	mr 3,25
	bc 4,2,.L273
	la 5,.LC133@l(31)
	li 3,0
	li 4,280
	bl G_Find
.L273:
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
.LC141:
	.string	"Couldn't find spawn point %s\n"
	.align 2
.LC142:
	.long 0x0
	.align 2
.LC143:
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
	lis 11,.LC142@ha
	lis 9,deathmatch@ha
	la 11,.LC142@l(11)
	mr 26,4
	lfs 13,0(11)
	mr 25,5
	li 31,0
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L288
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L289
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 12,2,.L289
	lwz 0,3496(9)
	cmpwi 0,0,0
	bc 4,2,.L289
	bl SelectCTFSpawnPoint
	mr 31,3
	b .L294
.L289:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,512
	bc 12,2,.L291
	bl SelectFarthestDeathmatchSpawnPoint
	mr 31,3
	b .L294
.L291:
	bl SelectRandomDeathmatchSpawnPoint
	mr 31,3
	b .L294
.L318:
	li 31,0
	b .L294
.L288:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L294
	lis 11,game+1028@ha
	lwz 0,84(3)
	lis 9,0x7a7b
	lwz 10,game+1028@l(11)
	ori 9,9,18951
	li 29,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 30,0,2
	bc 12,2,.L294
	lis 27,.LC2@ha
	lis 28,.LC22@ha
	lis 31,game+1032@ha
.L300:
	mr 3,29
	li 4,280
	la 5,.LC2@l(27)
	bl G_Find
	mr. 29,3
	bc 12,2,.L318
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
	bc 4,2,.L300
	addic. 30,30,-1
	bc 4,2,.L300
	mr 31,29
.L294:
	cmpwi 0,31,0
	bc 4,2,.L306
	lis 29,.LC0@ha
	lis 30,game@ha
.L313:
	mr 3,31
	li 4,280
	la 5,.LC0@l(29)
	bl G_Find
	mr. 31,3
	bc 12,2,.L319
	la 3,game@l(30)
	lbz 0,1032(3)
	cmpwi 0,0,0
	bc 4,2,.L317
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L308
	b .L313
.L317:
	lwz 4,300(31)
	cmpwi 0,4,0
	bc 12,2,.L313
	addi 3,3,1032
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L313
.L308:
	cmpwi 0,31,0
	bc 4,2,.L306
.L319:
	lis 9,game@ha
	la 30,game@l(9)
	lbz 0,1032(30)
	cmpwi 0,0,0
	bc 4,2,.L315
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,280
	bl G_Find
	mr 31,3
.L315:
	cmpwi 0,31,0
	bc 4,2,.L306
	lis 9,gi+28@ha
	lis 3,.LC141@ha
	lwz 0,gi+28@l(9)
	la 3,.LC141@l(3)
	addi 4,30,1032
	mtlr 0
	crxor 6,6,6
	blrl
.L306:
	lfs 0,4(31)
	lis 9,.LC143@ha
	la 9,.LC143@l(9)
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
.LC144:
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
	mulli 27,27,936
	addi 27,27,936
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
	lis 9,0xdcfd
	lis 11,body_die@ha
	ori 9,9,53213
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
.Lfe9:
	.size	 CopyToBodyQue,.Lfe9-CopyToBodyQue
	.section	".rodata"
	.align 2
.LC145:
	.string	"menu_loadgame\n"
	.align 2
.LC146:
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.align 2
.LC147:
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.align 2
.LC148:
	.string	"player"
	.align 2
.LC149:
	.string	"players/male/tris.md2"
	.align 2
.LC150:
	.string	"fov"
	.align 2
.LC151:
	.string	"rocket launcher"
	.align 2
.LC152:
	.string	"rockets"
	.align 2
.LC153:
	.string	"chaingun"
	.align 2
.LC154:
	.string	"bullets"
	.align 2
.LC155:
	.string	"hyperblaster"
	.align 2
.LC156:
	.string	"cells"
	.align 2
.LC157:
	.string	"Your target is %s\n"
	.align 2
.LC158:
	.string	"There is a price on your head!\n"
	.align 2
.LC159:
	.long 0x0
	.align 2
.LC160:
	.long 0x41400000
	.align 2
.LC161:
	.long 0x41000000
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
	.align 2
.LC165:
	.long 0x47800000
	.align 2
.LC166:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl PutClientInServer
	.type	 PutClientInServer,@function
PutClientInServer:
	stwu 1,-4560(1)
	mflr 0
	stfd 31,4552(1)
	stmw 15,4484(1)
	stw 0,4564(1)
	lis 9,.LC146@ha
	lis 10,.LC147@ha
	lwz 0,.LC146@l(9)
	la 29,.LC147@l(10)
	addi 8,1,8
	la 9,.LC146@l(9)
	lwz 11,.LC147@l(10)
	mr 31,3
	lwz 28,8(9)
	addi 7,1,24
	addi 5,1,56
	lwz 6,4(9)
	mr 15,5
	stw 0,8(1)
	addi 4,1,40
	li 25,0
	stw 28,8(8)
	stw 6,4(8)
	lwz 0,8(29)
	lwz 9,4(29)
	stw 11,24(1)
	stw 0,8(7)
	stw 9,4(7)
	bl SelectSpawnPoint
	lis 9,deathmatch@ha
	lis 8,.LC159@ha
	lwz 30,84(31)
	lwz 10,deathmatch@l(9)
	la 8,.LC159@l(8)
	lis 11,g_edicts@ha
	lfs 13,0(8)
	lis 0,0xdcfd
	lfs 0,20(10)
	ori 0,0,53213
	lwz 9,g_edicts@l(11)
	fcmpu 0,0,13
	subf 9,9,31
	mullw 9,9,0
	srawi 9,9,3
	addi 26,9,-1
	bc 12,2,.L338
	addi 28,1,1736
	addi 27,30,1840
	mulli 23,26,3804
	addi 26,1,3432
	mr 4,27
	li 5,1684
	mr 3,28
	crxor 6,6,6
	bl memcpy
	addi 29,30,188
	mr 24,27
	mr 4,29
	li 5,512
	mr 3,26
	mr 16,28
	crxor 6,6,6
	bl memcpy
	mr 22,29
	mr 3,30
	addi 27,1,72
	bl InitClientPersistant
	mr 4,26
	mr 3,31
	bl ClientUserinfoChanged
	b .L339
.L338:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L340
	addi 0,1,1736
	addi 9,30,1840
	mulli 23,26,3804
	lwz 17,1804(30)
	mr 4,9
	addi 28,1,3944
	lwz 26,1808(30)
	mr 3,0
	mr 16,0
	lwz 19,1812(30)
	mr 24,9
	li 5,1684
	lwz 20,1816(30)
	lwz 21,1820(30)
	addi 29,30,188
	mr 18,28
	crxor 6,6,6
	bl memcpy
	mr 22,29
	addi 27,1,72
	mr 3,28
	mr 4,29
	li 5,512
	crxor 6,6,6
	bl memcpy
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	la 9,itemlist@l(9)
	addi 10,1,2288
	addi 11,30,740
	addi 9,9,56
.L416:
	lwz 0,0(9)
	addi 9,9,72
	andi. 8,0,16
	bc 12,2,.L343
	lwz 0,0(11)
	stw 0,0(10)
.L343:
	addi 10,10,4
	addi 11,11,4
	bdnz .L416
	mr 4,16
	li 5,1652
	mr 3,22
	crxor 6,6,6
	bl memcpy
	mr 4,18
	mr 3,31
	bl ClientUserinfoChanged
	lwz 9,3392(1)
	lwz 0,1800(30)
	cmpw 0,9,0
	bc 4,1,.L347
	stw 9,1800(30)
.L347:
	cmpwi 0,26,11
	bc 4,2,.L348
	li 0,400
	b .L417
.L348:
	cmpwi 0,26,-4
	bc 4,2,.L350
	li 0,250
	b .L417
.L350:
	cmpwi 0,26,-3
	li 0,100
	bc 4,2,.L352
	li 0,40
.L352:
.L417:
	stw 0,728(30)
	stw 17,1804(30)
	stw 26,1808(30)
	stw 19,1812(30)
	stw 20,1816(30)
	stw 21,1820(30)
	b .L339
.L340:
	addi 29,1,1736
	li 4,0
	mulli 23,26,3804
	mr 3,29
	li 5,1684
	crxor 6,6,6
	bl memset
	mr 16,29
	addi 24,30,1840
	addi 22,30,188
	addi 27,1,72
.L339:
	mr 4,22
	li 5,1652
	mr 3,27
	crxor 6,6,6
	bl memcpy
	li 4,0
	li 5,3804
	mr 3,30
	crxor 6,6,6
	bl memset
	mr 4,27
	mr 3,22
	li 5,1652
	crxor 6,6,6
	bl memcpy
	lwz 0,724(30)
	cmpwi 0,0,0
	bc 12,1,.L355
	mr 3,30
	bl InitClientPersistant
.L355:
	mr 3,24
	mr 4,16
	li 5,1684
	crxor 6,6,6
	bl memcpy
	lwz 11,84(31)
	lwz 0,724(11)
	stw 0,480(31)
	lwz 9,728(11)
	stw 9,484(31)
	lwz 0,732(11)
	cmpwi 0,0,0
	bc 12,2,.L356
	lwz 0,264(31)
	ori 0,0,4096
	stw 0,264(31)
.L356:
	lis 9,coop@ha
	lis 8,.LC159@ha
	lwz 11,coop@l(9)
	la 8,.LC159@l(8)
	lfs 12,0(8)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L358
	lwz 9,84(31)
	lwz 0,1800(9)
	stw 0,3496(9)
.L358:
	lis 9,game@ha
	li 7,0
	lwz 5,264(31)
	la 28,game@l(9)
	stw 7,552(31)
	li 4,2
	lis 9,.LC148@ha
	lwz 6,1028(28)
	li 0,4
	la 9,.LC148@l(9)
	li 11,22
	stw 0,260(31)
	stw 9,280(31)
	add 6,6,23
	li 10,200
	li 9,1
	stw 11,508(31)
	lis 3,level+4@ha
	stw 9,88(31)
	lis 0,0xff86
	lis 11,.LC149@ha
	lis 9,.LC160@ha
	stw 10,400(31)
	ori 0,0,14335
	stw 4,248(31)
	la 9,.LC160@l(9)
	and 5,5,0
	stw 6,84(31)
	lis 10,player_pain@ha
	lis 8,player_die@ha
	stw 4,512(31)
	la 11,.LC149@l(11)
	la 10,player_pain@l(10)
	stw 7,492(31)
	la 8,player_die@l(8)
	lfs 0,level+4@l(3)
	lfs 13,0(9)
	lwz 0,184(31)
	lis 9,0x201
	ori 9,9,3
	stw 5,264(31)
	fadds 0,0,13
	rlwinm 0,0,0,31,29
	stw 9,252(31)
	stw 11,268(31)
	stw 10,452(31)
	stfs 0,404(31)
	stw 8,456(31)
	stw 0,184(31)
	stw 7,900(31)
	stfs 12,916(31)
	stw 7,612(31)
	stw 7,608(31)
	stfs 12,908(31)
	stfs 12,592(31)
	stfs 12,896(31)
	stfs 12,912(31)
	lbz 0,16(6)
	andi. 0,0,191
	stb 0,16(6)
	lwz 9,264(31)
	andis. 0,9,128
	bc 12,2,.L359
	bl rand
	lis 29,0x30c3
	addi 28,28,1564
	lis 0,0x30c3
	srawi 9,3,31
	ori 0,0,3121
	ori 29,29,3121
	mulhw 0,3,0
	srawi 0,0,2
	subf 0,9,0
	mulli 0,0,21
	subf 3,0,3
	addi 3,3,1
.L363:
	slwi 0,3,2
	lwzx 9,28,0
	cmpwi 0,9,1
	bc 4,2,.L361
	bl rand
	addi 25,25,1
	mulhw 0,3,29
	srawi 9,3,31
	cmpwi 0,25,50
	srawi 0,0,2
	subf 0,9,0
	mulli 0,0,21
	subf 3,0,3
	addi 3,3,1
	bc 4,1,.L363
	li 3,0
.L361:
	lwz 9,84(31)
	li 25,0
	stw 3,1804(9)
.L359:
	lwz 0,264(31)
	andis. 8,0,256
	bc 12,2,.L364
	bl rand
	lis 29,0x7878
	lis 9,0x7878
	srawi 10,3,31
	ori 9,9,30841
	lis 11,game+1656@ha
	mulhw 9,3,9
	ori 29,29,30841
	la 28,game+1656@l(11)
	srawi 9,9,3
	subf 9,10,9
	slwi 0,9,4
	add 0,0,9
	subf 3,0,3
	addi 3,3,1
.L368:
	slwi 0,3,2
	lwzx 9,28,0
	cmpwi 0,9,1
	bc 4,2,.L366
	bl rand
	addi 25,25,1
	mulhw 9,3,29
	srawi 11,3,31
	cmpwi 0,25,50
	srawi 9,9,3
	subf 9,11,9
	slwi 0,9,4
	add 0,0,9
	subf 3,0,3
	addi 3,3,1
	bc 4,1,.L368
	li 3,0
.L366:
	lwz 9,84(31)
	li 25,0
	stw 3,1808(9)
.L364:
	lwz 0,264(31)
	andis. 8,0,512
	bc 12,2,.L369
	bl rand
	lis 29,0x7878
	lis 9,0x7878
	srawi 10,3,31
	ori 9,9,30841
	lis 11,game+1732@ha
	mulhw 9,3,9
	ori 29,29,30841
	la 28,game+1732@l(11)
	srawi 9,9,3
	subf 9,10,9
	slwi 0,9,4
	add 0,0,9
	subf 3,0,3
	addi 3,3,1
.L373:
	slwi 0,3,2
	lwzx 9,28,0
	cmpwi 0,9,1
	bc 4,2,.L371
	bl rand
	addi 25,25,1
	mulhw 9,3,29
	srawi 11,3,31
	cmpwi 0,25,50
	srawi 9,9,3
	subf 9,11,9
	slwi 0,9,4
	add 0,0,9
	subf 3,0,3
	addi 3,3,1
	bc 4,1,.L373
	li 3,0
.L371:
	lwz 9,84(31)
	stw 3,1812(9)
	lwz 11,84(31)
	li 3,0
	lwz 9,1812(11)
	addi 9,9,-2
	cmplwi 0,9,2
	bc 4,1,.L369
	stw 3,892(31)
.L369:
	lwz 0,264(31)
	andi. 8,0,8192
	bc 4,2,.L414
	lwz 9,84(31)
	lwz 0,1804(9)
	cmpwi 0,0,0
	bc 12,2,.L376
	lwz 0,1808(9)
	cmpwi 0,0,0
	bc 12,2,.L376
	lwz 0,1812(9)
	cmpwi 0,0,0
	bc 4,2,.L377
.L376:
	mr 3,31
	bl MakeObserver
	b .L337
.L414:
	lis 9,.LC22@ha
	li 10,0
	la 9,.LC22@l(9)
	li 11,1
	stw 10,400(31)
	li 0,6
	stw 11,248(31)
	stw 0,260(31)
	stw 9,268(31)
	stw 10,512(31)
.L377:
	lwz 9,84(31)
	lwz 0,1808(9)
	cmpwi 0,0,11
	bc 4,2,.L378
	li 0,400
	b .L418
.L378:
	cmpwi 0,0,-4
	bc 4,2,.L380
	li 0,250
	b .L418
.L380:
	cmpwi 0,0,-3
	li 0,100
	bc 4,2,.L382
	li 0,40
.L382:
.L418:
	stw 0,484(31)
	lis 8,.LC159@ha
	lfs 10,12(1)
	li 4,0
	la 8,.LC159@l(8)
	lfs 0,16(1)
	li 5,184
	lfs 13,24(1)
	lfs 12,28(1)
	lfs 11,32(1)
	lfs 9,8(1)
	lfs 31,0(8)
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
	lis 8,.LC161@ha
	lfs 0,40(1)
	la 8,.LC161@l(8)
	mr 10,11
	lfs 10,0(8)
	lis 9,deathmatch@ha
	mr 8,11
	lwz 7,deathmatch@l(9)
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,4472(1)
	lwz 11,4476(1)
	sth 11,4(30)
	lfs 0,44(1)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,4472(1)
	lwz 10,4476(1)
	sth 10,6(30)
	lfs 0,48(1)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,4472(1)
	lwz 8,4476(1)
	sth 8,8(30)
	lfs 0,20(7)
	fcmpu 0,0,31
	bc 12,2,.L384
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,4472(1)
	lwz 11,4476(1)
	andi. 9,11,32768
	bc 4,2,.L419
.L384:
	lis 4,.LC150@ha
	mr 3,22
	la 4,.LC150@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	stw 3,4476(1)
	lis 0,0x4330
	lis 8,.LC162@ha
	la 8,.LC162@l(8)
	stw 0,4472(1)
	lis 10,.LC163@ha
	lfd 13,0(8)
	la 10,.LC163@l(10)
	lfd 0,4472(1)
	lfs 12,0(10)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	stfs 0,112(30)
	bc 4,0,.L386
.L419:
	lis 0,0x42b4
	stw 0,112(30)
	b .L385
.L386:
	lis 11,.LC164@ha
	la 11,.LC164@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L385
	stfs 13,112(30)
.L385:
	lwz 0,264(31)
	andi. 8,0,8192
	bc 4,2,.L389
	lwz 11,84(31)
	li 9,255
	li 0,0
	stw 9,44(31)
	lis 10,gi+32@ha
	stw 9,40(31)
	stw 0,1828(11)
	lwz 9,84(31)
	stw 0,1832(9)
	lwz 11,84(31)
	stw 0,1836(11)
	lwz 9,1788(30)
	lwz 0,gi+32@l(10)
	lwz 3,32(9)
	mtlr 0
	blrl
	stw 3,88(30)
	b .L390
.L389:
	li 0,0
	lwz 9,84(31)
	stw 0,40(31)
	stw 0,44(31)
	stw 0,48(31)
	stw 0,88(9)
.L390:
	lis 11,g_edicts@ha
	lis 8,.LC163@ha
	lfs 13,48(1)
	lwz 9,g_edicts@l(11)
	la 8,.LC163@l(8)
	lis 0,0xdcfd
	lfs 0,0(8)
	ori 0,0,53213
	lis 10,.LC165@ha
	subf 9,9,31
	lfs 12,40(1)
	lis 8,.LC166@ha
	mullw 9,9,0
	la 10,.LC165@l(10)
	la 8,.LC166@l(8)
	fadds 13,13,0
	li 0,3
	li 11,0
	lfs 10,0(10)
	lfs 0,44(1)
	mtctr 0
	srawi 9,9,3
	mr 5,15
	lfs 11,0(8)
	addi 9,9,-1
	addi 7,30,3500
	stw 11,56(31)
	addi 8,30,20
	li 10,0
	stfs 12,28(31)
	stfs 0,32(31)
	stfs 13,36(31)
	stw 9,60(31)
	stw 11,64(31)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
.L415:
	lfsx 0,10,5
	lfsx 12,10,7
	addi 10,10,4
	fsubs 0,0,12
	fmuls 0,0,10
	fdivs 0,0,11
	fctiwz 13,0
	stfd 13,4472(1)
	lwz 9,4476(1)
	sth 9,0(8)
	addi 8,8,2
	bdnz .L415
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
	stfs 0,3692(30)
	lfs 13,20(31)
	stfs 13,3696(30)
	lfs 0,24(31)
	stfs 0,3700(30)
	bl KillBox
	lwz 0,264(31)
	andi. 29,0,8192
	bc 4,2,.L398
	lwz 10,84(31)
	lwz 0,1808(10)
	cmpwi 0,0,-4
	bc 4,2,.L399
	lis 9,robot_index@ha
	mr 3,31
	lwz 0,robot_index@l(9)
	lis 27,.LC151@ha
	lis 28,0x38e3
	stw 29,44(31)
	ori 28,28,36409
	li 26,1
	stw 0,40(31)
	bl CTFTripSkin
	li 0,30
	li 9,500
	stw 0,508(31)
	la 3,.LC151@l(27)
	stw 9,400(31)
	bl FindItem
	lis 29,itemlist@ha
	lwz 9,84(31)
	lis 11,.LC152@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	addi 9,9,740
	mullw 0,0,28
	la 3,.LC152@l(11)
	srawi 0,0,3
	slwi 0,0,2
	stwx 26,9,0
	bl FindItem
	subf 0,29,3
	lwz 9,84(31)
	mullw 0,0,28
	la 3,.LC151@l(27)
	addi 9,9,740
	srawi 0,0,3
	slwi 0,0,2
	stwx 26,9,0
	b .L420
.L399:
	cmpwi 0,0,-3
	bc 4,2,.L401
	lis 9,cripple_index@ha
	mr 3,31
	lwz 0,cripple_index@l(9)
	lis 27,.LC153@ha
	lis 28,0x38e3
	stw 29,44(31)
	ori 28,28,36409
	li 26,1
	stw 0,40(31)
	bl CTFTripSkin
	li 0,100
	li 9,40
	stw 29,508(31)
	stw 0,400(31)
	la 3,.LC153@l(27)
	stw 9,480(31)
	bl FindItem
	lis 29,itemlist@ha
	lwz 9,84(31)
	lis 11,.LC154@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	addi 9,9,740
	mullw 0,0,28
	la 3,.LC154@l(11)
	srawi 0,0,3
	slwi 0,0,2
	stwx 26,9,0
	bl FindItem
	subf 0,29,3
	lwz 9,84(31)
	mullw 0,0,28
	la 3,.LC153@l(27)
	addi 9,9,740
	srawi 0,0,3
	slwi 0,0,2
	stwx 26,9,0
	b .L420
.L401:
	cmpwi 0,0,-2
	bc 4,2,.L403
	lis 26,.LC155@ha
	lis 28,0x38e3
	la 3,.LC155@l(26)
	ori 28,28,36409
	bl FindItem
	li 27,1
	lis 29,itemlist@ha
	lwz 9,84(31)
	lis 11,.LC156@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	addi 9,9,740
	mullw 0,0,28
	la 3,.LC156@l(11)
	srawi 0,0,3
	slwi 0,0,2
	stwx 27,9,0
	bl FindItem
	subf 0,29,3
	lwz 9,84(31)
	mullw 0,0,28
	la 3,.LC155@l(26)
	addi 9,9,740
	srawi 0,0,3
	slwi 0,0,2
	stwx 27,9,0
.L420:
	bl FindItem
	lwz 9,84(31)
	stw 3,3588(9)
	mr 3,31
	bl ChangeWeapon
	b .L398
.L403:
	cmpwi 0,0,-10
	bc 4,2,.L405
	lis 9,sun_index@ha
	li 0,5
	lwz 11,sun_index@l(9)
	stw 0,56(31)
	stw 11,40(31)
	stw 29,60(31)
	stw 29,44(31)
	b .L398
.L405:
	cmpwi 0,0,-8
	bc 4,2,.L407
	lis 9,body_armor_index@ha
	addi 10,10,740
	lwz 0,body_armor_index@l(9)
	li 11,50
	slwi 0,0,2
	stwx 11,10,0
	stw 29,88(30)
	b .L398
.L407:
	cmpwi 0,0,-6
	bc 4,2,.L409
	mr 3,31
	bl randplayer
	mr 28,3
	cmpwi 0,28,0
	stw 28,932(31)
	bc 12,2,.L398
	lwz 3,84(28)
	lis 29,gi@ha
	la 29,gi@l(29)
	addi 3,3,700
	bl Green1
	lwz 9,8(29)
	mr 6,3
	lis 5,.LC157@ha
	li 4,2
	mr 3,31
	mtlr 9
	la 5,.LC157@l(5)
	crxor 6,6,6
	blrl
	lwz 0,12(29)
	lis 4,.LC158@ha
	mr 3,28
	la 4,.LC158@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L398
.L409:
	cmpwi 0,0,13
	bc 4,2,.L398
	lis 9,body_armor_index@ha
	addi 10,10,740
	lwz 0,body_armor_index@l(9)
	li 11,10
	slwi 0,0,2
	stwx 11,10,0
.L398:
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,3
	bc 12,2,.L413
	li 0,0
	stw 0,932(31)
.L413:
	lwz 0,1788(30)
	mr 3,31
	stw 0,3588(30)
	bl ChangeWeapon
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L337:
	lwz 0,4564(1)
	mtlr 0
	lmw 15,4484(1)
	lfd 31,4552(1)
	la 1,4560(1)
	blr
.Lfe10:
	.size	 PutClientInServer,.Lfe10-PutClientInServer
	.section	".rodata"
	.align 2
.LC167:
	.string	"%s entered the game\n"
	.align 2
.LC168:
	.string	"bind ins  \"use a_inc\"\n"
	.align 2
.LC169:
	.string	"bind del  \"use a_dec\"\n"
	.align 2
.LC170:
	.string	"bind home \"use p_inc\"\n"
	.align 2
.LC171:
	.string	"bind end  \"use p_dec\"\n"
	.align 2
.LC172:
	.string	"bind pgup \"use s_inc\"\n"
	.align 2
.LC173:
	.string	"bind pgdn \"use s_dec\"\n"
	.align 2
.LC174:
	.string	"bind ] \"use c_inc\"\n"
	.align 2
.LC175:
	.string	"bind [ \"use c_dec\"\n"
	.align 2
.LC176:
	.string	"bind o \"use s_obs\"\n"
	.align 2
.LC177:
	.string	"bind p \"use s_pwr\"\n"
	.align 2
.LC178:
	.ascii	"Superheroes ][\n%s\n\nUse INS DEL HOM"
	.string	"E END PGUP PGDN\nto select your powers\nor [ and ] to use pre-made combos\n*O* will make you an observer\n*P* will display your powers\nHit fire to become a player\nWritten by SoulScythe\nphead@ucla.edu\nwww.planetquake.com/modsquad/super2\nYour lucky number is: %i"
	.section	".text"
	.align 2
	.globl ClientBeginDeathmatch
	.type	 ClientBeginDeathmatch,@function
ClientBeginDeathmatch:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 28,3
	lis 25,gi@ha
	la 26,gi@l(25)
	bl G_InitEdict
	lwz 27,84(28)
	li 4,0
	li 5,1684
	addi 29,27,1840
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	li 5,1652
	lwz 0,level@l(9)
	addi 4,27,188
	mr 3,29
	stw 0,3492(27)
	crxor 6,6,6
	bl memcpy
	li 0,1
	mr 3,28
	stw 0,3520(27)
	bl MakeObserver
	lwz 9,100(26)
	li 3,1
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xdcfd
	lwz 10,104(26)
	lwz 3,g_edicts@l(9)
	ori 0,0,53213
	mtlr 10
	subf 3,3,28
	mullw 3,3,0
	srawi 3,3,3
	blrl
	lwz 9,100(26)
	li 3,9
	mtlr 9
	blrl
	lwz 9,88(26)
	li 4,2
	addi 3,28,4
	mtlr 9
	blrl
	lwz 0,gi@l(25)
	lis 4,.LC167@ha
	li 3,2
	lwz 5,84(28)
	la 4,.LC167@l(4)
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	li 3,0
	bl time
	bl srand
	bl rand
	lis 0,0x6666
	mr 9,3
	lwz 10,84(28)
	ori 0,0,26215
	srawi 11,9,31
	mulhw 0,9,0
	lis 4,.LC168@ha
	mr 3,28
	la 4,.LC168@l(4)
	srawi 0,0,2
	subf 0,11,0
	mulli 0,0,10
	subf 9,0,9
	stw 9,1824(10)
	bl stuffcmd
	lis 4,.LC169@ha
	mr 3,28
	la 4,.LC169@l(4)
	bl stuffcmd
	lis 4,.LC170@ha
	mr 3,28
	la 4,.LC170@l(4)
	bl stuffcmd
	lis 4,.LC171@ha
	mr 3,28
	la 4,.LC171@l(4)
	bl stuffcmd
	lis 4,.LC172@ha
	mr 3,28
	la 4,.LC172@l(4)
	bl stuffcmd
	lis 4,.LC173@ha
	mr 3,28
	la 4,.LC173@l(4)
	bl stuffcmd
	lis 4,.LC174@ha
	mr 3,28
	la 4,.LC174@l(4)
	bl stuffcmd
	lis 4,.LC175@ha
	mr 3,28
	la 4,.LC175@l(4)
	bl stuffcmd
	lis 4,.LC176@ha
	mr 3,28
	la 4,.LC176@l(4)
	bl stuffcmd
	lis 4,.LC177@ha
	mr 3,28
	la 4,.LC177@l(4)
	bl stuffcmd
	bl GetSub
	lwz 9,84(28)
	mr 5,3
	lis 4,.LC178@ha
	lwz 0,12(26)
	mr 3,28
	la 4,.LC178@l(4)
	lwz 6,1824(9)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,28
	bl ClientEndServerFrame
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe11:
	.size	 ClientBeginDeathmatch,.Lfe11-ClientBeginDeathmatch
	.section	".rodata"
	.align 2
.LC179:
	.long 0x0
	.align 2
.LC180:
	.long 0x47800000
	.align 2
.LC181:
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
	mr 31,3
	lis 4,.LC168@ha
	la 4,.LC168@l(4)
	bl stuffcmd
	lis 4,.LC169@ha
	mr 3,31
	la 4,.LC169@l(4)
	bl stuffcmd
	lis 4,.LC170@ha
	mr 3,31
	la 4,.LC170@l(4)
	bl stuffcmd
	lis 4,.LC171@ha
	mr 3,31
	la 4,.LC171@l(4)
	bl stuffcmd
	lis 4,.LC172@ha
	mr 3,31
	la 4,.LC172@l(4)
	bl stuffcmd
	lis 4,.LC173@ha
	mr 3,31
	la 4,.LC173@l(4)
	bl stuffcmd
	lis 4,.LC174@ha
	mr 3,31
	la 4,.LC174@l(4)
	bl stuffcmd
	lis 4,.LC175@ha
	mr 3,31
	la 4,.LC175@l(4)
	bl stuffcmd
	lis 4,.LC176@ha
	mr 3,31
	la 4,.LC176@l(4)
	bl stuffcmd
	lis 4,.LC177@ha
	mr 3,31
	la 4,.LC177@l(4)
	bl stuffcmd
	lis 11,g_edicts@ha
	lis 0,0xdcfd
	lwz 9,g_edicts@l(11)
	ori 0,0,53213
	lis 8,deathmatch@ha
	lis 11,game+1028@ha
	subf 9,9,31
	lwz 10,game+1028@l(11)
	mullw 9,9,0
	lis 11,.LC179@ha
	la 11,.LC179@l(11)
	srawi 9,9,3
	lfs 13,0(11)
	mulli 9,9,3804
	lwz 11,deathmatch@l(8)
	addi 9,9,-3804
	add 10,10,9
	stw 10,84(31)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L424
	mr 3,31
	bl ClientBeginDeathmatch
	b .L423
.L424:
	lwz 0,88(31)
	cmpwi 0,0,1
	bc 4,2,.L425
	lis 9,.LC180@ha
	lis 11,.LC181@ha
	li 0,3
	la 9,.LC180@l(9)
	la 11,.LC181@l(11)
	mtctr 0
	lfs 11,0(9)
	li 8,0
	lfs 12,0(11)
	li 7,0
.L436:
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
	bdnz .L436
	b .L431
.L425:
	mr 3,31
	bl G_InitEdict
	lwz 28,84(31)
	lis 9,.LC148@ha
	li 4,0
	la 9,.LC148@l(9)
	li 5,1684
	addi 29,28,1840
	stw 9,280(31)
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,29
	lwz 0,level@l(9)
	addi 4,28,188
	li 5,1652
	stw 0,3492(28)
	crxor 6,6,6
	bl memcpy
	li 0,1
	mr 3,31
	stw 0,3520(28)
	bl MakeObserver
.L431:
	lis 11,.LC179@ha
	lis 9,level+200@ha
	la 11,.LC179@l(11)
	lfs 0,level+200@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,2,.L433
	mr 3,31
	bl MoveClientToIntermission
	b .L434
.L433:
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L434
	lis 28,gi@ha
	li 3,1
	la 29,gi@l(28)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xdcfd
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,53213
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
	lis 4,.LC167@ha
	li 3,2
	lwz 0,gi@l(28)
	la 4,.LC167@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L434:
	mr 3,31
	bl ClientEndServerFrame
.L423:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 ClientBegin,.Lfe12-ClientBegin
	.section	".rodata"
	.align 2
.LC182:
	.string	"\\name\\badinfo\\skin\\male/grunt"
	.align 2
.LC183:
	.string	"name"
	.align 2
.LC184:
	.string	"%s\\%s"
	.align 2
.LC185:
	.string	"hand"
	.align 2
.LC186:
	.long 0x0
	.align 3
.LC187:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC188:
	.long 0x3f800000
	.align 2
.LC189:
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
	bc 4,2,.L438
	lis 11,.LC182@ha
	lwz 0,.LC182@l(11)
	la 9,.LC182@l(11)
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
.L438:
	lis 4,.LC183@ha
	mr 3,30
	la 4,.LC183@l(4)
	bl Info_ValueForKey
	lwz 9,84(27)
	mr 31,3
	li 5,15
	mr 4,31
	addi 3,9,700
	bl strncpy
	lis 4,.LC21@ha
	mr 3,30
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	lis 9,ctf@ha
	lis 11,g_edicts@ha
	lwz 10,ctf@l(9)
	mr 31,3
	lis 9,.LC186@ha
	lwz 0,g_edicts@l(11)
	la 9,.LC186@l(9)
	lfs 0,20(10)
	lfs 13,0(9)
	subf 0,0,27
	lis 9,0xdcfd
	ori 9,9,53213
	fcmpu 0,0,13
	mullw 0,0,9
	srawi 28,0,3
	bc 12,2,.L439
	mr 4,31
	mr 3,27
	bl CTFAssignSkin
	b .L440
.L439:
	lwz 4,84(27)
	lis 29,gi@ha
	lis 3,.LC184@ha
	la 29,gi@l(29)
	addi 28,28,1311
	addi 4,4,700
	la 3,.LC184@l(3)
	mr 5,31
	crxor 6,6,6
	bl va
	lwz 0,24(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
.L440:
	lis 9,.LC186@ha
	lis 11,deathmatch@ha
	la 9,.LC186@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L441
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,32768
	bc 12,2,.L441
	lwz 9,84(27)
	b .L447
.L441:
	lis 4,.LC150@ha
	mr 3,30
	la 4,.LC150@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	lwz 11,84(27)
	stw 3,20(1)
	lis 0,0x4330
	lis 10,.LC187@ha
	la 10,.LC187@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC188@ha
	la 10,.LC188@l(10)
	lfs 12,0(10)
	fsub 0,0,13
	frsp 0,0
	stfs 0,112(11)
	lwz 9,84(27)
	lfs 0,112(9)
	fcmpu 0,0,12
	bc 4,0,.L443
.L447:
	lis 0,0x42b4
	stw 0,112(9)
	b .L442
.L443:
	lis 11,.LC189@ha
	la 11,.LC189@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L442
	stfs 13,112(9)
.L442:
	lis 4,.LC185@ha
	mr 3,30
	la 4,.LC185@l(4)
	bl Info_ValueForKey
	mr 31,3
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L446
	mr 3,31
	bl atoi
	lwz 9,84(27)
	stw 3,716(9)
.L446:
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
.Lfe13:
	.size	 ClientUserinfoChanged,.Lfe13-ClientUserinfoChanged
	.section	".rodata"
	.align 2
.LC190:
	.string	"%s: reconnect without disconnect\n"
	.align 2
.LC191:
	.string	"ip"
	.align 2
.LC192:
	.string	"password"
	.align 2
.LC193:
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
	mr 30,3
	mr 28,4
	lwz 4,84(30)
	lwz 0,3520(4)
	cmpwi 0,0,0
	bc 12,2,.L449
	lis 9,gi+4@ha
	lis 3,.LC190@ha
	lwz 0,gi+4@l(9)
	la 3,.LC190@l(3)
	addi 4,4,700
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,30
	bl ClientDisconnect
.L449:
	lis 4,.LC191@ha
	mr 3,28
	la 4,.LC191@l(4)
	bl Info_ValueForKey
	lis 4,.LC192@ha
	mr 3,28
	la 4,.LC192@l(4)
	bl Info_ValueForKey
	lis 9,password@ha
	mr 4,3
	lwz 11,password@l(9)
	lwz 3,4(11)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L450
	li 3,0
	b .L456
.L450:
	lis 11,g_edicts@ha
	lis 0,0xdcfd
	lwz 10,88(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,53213
	lis 11,game@ha
	cmpwi 0,10,0
	subf 9,9,30
	la 27,game@l(11)
	mullw 9,9,0
	lwz 11,1028(27)
	srawi 9,9,3
	mulli 9,9,3804
	addi 9,9,-3804
	add 31,11,9
	stw 31,84(30)
	bc 4,2,.L451
	addi 29,31,1840
	li 4,0
	li 5,1684
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,29
	lwz 0,level@l(9)
	addi 4,31,188
	li 5,1652
	stw 0,3492(31)
	crxor 6,6,6
	bl memcpy
	li 0,1
	stw 0,3520(31)
	lwz 9,1560(27)
	cmpwi 0,9,0
	bc 12,2,.L454
	lwz 9,84(30)
	lwz 0,1788(9)
	cmpwi 0,0,0
	bc 4,2,.L451
.L454:
	lwz 3,84(30)
	bl InitClientPersistant
.L451:
	mr 4,28
	mr 3,30
	bl ClientUserinfoChanged
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L455
	lis 9,gi+4@ha
	lwz 4,84(30)
	lis 3,.LC193@ha
	lwz 0,gi+4@l(9)
	la 3,.LC193@l(3)
	addi 4,4,700
	mtlr 0
	crxor 6,6,6
	blrl
.L455:
	lwz 9,84(30)
	li 0,1
	li 3,1
	stw 0,720(9)
.L456:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 ClientConnect,.Lfe14-ClientConnect
	.section	".rodata"
	.align 2
.LC194:
	.string	"%s disconnected\n"
	.align 2
.LC195:
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
	bc 12,2,.L457
	lis 9,gi@ha
	lis 4,.LC194@ha
	lwz 0,gi@l(9)
	li 3,2
	la 4,.LC194@l(4)
	addi 5,5,700
	la 30,gi@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 3,892(31)
	cmpwi 0,3,0
	bc 12,2,.L459
	bl G_FreeEdict
.L459:
	lwz 9,84(31)
	li 29,0
	mr 3,31
	lis 27,g_edicts@ha
	lis 28,0xdcfd
	stw 29,3520(9)
	ori 28,28,53213
	bl CTFDrop_Flag
	lwz 11,84(31)
	li 3,1
	stw 29,1804(11)
	lwz 9,84(31)
	stw 29,1808(9)
	lwz 11,84(31)
	stw 29,1812(11)
	lwz 9,84(31)
	stw 29,1816(9)
	lwz 0,264(31)
	rlwinm 0,0,0,6,3
	stw 0,264(31)
	lwz 9,100(30)
	mtlr 9
	blrl
	lwz 3,g_edicts@l(27)
	lwz 9,104(30)
	subf 3,3,31
	mullw 3,3,28
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
	lwz 3,g_edicts@l(27)
	lis 9,.LC195@ha
	lis 4,.LC22@ha
	la 9,.LC195@l(9)
	lwz 11,84(31)
	la 4,.LC22@l(4)
	stw 9,280(31)
	subf 3,3,31
	stw 29,40(31)
	mullw 3,3,28
	stw 29,248(31)
	stw 29,88(31)
	srawi 3,3,3
	stw 29,720(11)
	addi 3,3,1311
	lwz 0,24(30)
	mtlr 0
	blrl
.L457:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 ClientDisconnect,.Lfe15-ClientDisconnect
	.section	".rodata"
	.align 2
.LC196:
	.string	"sv %3i:%i %i\n"
	.align 2
.LC197:
	.string	"optic blast"
	.align 2
.LC198:
	.string	"light saber"
	.align 2
.LC200:
	.string	"robot laser"
	.align 2
.LC202:
	.string	"world/scan1.wav"
	.align 2
.LC204:
	.string	"Killer Robot Upgrade Lost!\n"
	.align 2
.LC205:
	.string	"Killer Robot Upgrade!\n"
	.align 2
.LC212:
	.string	"world/force2.wav"
	.align 2
.LC219:
	.string	"%s goes berserk!\n"
	.align 2
.LC220:
	.string	"powers/berzfemale.wav"
	.align 2
.LC221:
	.string	"powers/berzmale.wav"
	.align 2
.LC223:
	.string	"weapons/rockfly.wav"
	.align 2
.LC228:
	.string	"*jump1.wav"
	.align 2
.LC229:
	.string	"powers/bootf.wav"
	.align 2
.LC199:
	.long 0x3dcccccd
	.align 2
.LC201:
	.long 0x3ecccccd
	.align 3
.LC203:
	.long 0x3fd33333
	.long 0x33333333
	.align 2
.LC206:
	.long 0x3f99999a
	.align 3
.LC207:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC208:
	.long 0x3f4ccccd
	.align 2
.LC209:
	.long 0x3e99999a
	.align 2
.LC210:
	.long 0x3f19999a
	.align 2
.LC211:
	.long 0x3f666666
	.align 3
.LC213:
	.long 0x3fe99999
	.long 0x9999999a
	.align 3
.LC214:
	.long 0x3ff19999
	.long 0x9999999a
	.align 3
.LC215:
	.long 0x3ff99999
	.long 0x9999999a
	.align 3
.LC216:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 3
.LC217:
	.long 0x3fe33333
	.long 0x33333333
	.align 3
.LC218:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC222:
	.long 0x44098000
	.align 2
.LC224:
	.long 0x3eb33333
	.align 2
.LC225:
	.long 0x44d48000
	.align 3
.LC226:
	.long 0x3f768000
	.long 0x0
	.align 2
.LC227:
	.long 0x44548000
	.align 2
.LC230:
	.long 0x0
	.align 3
.LC231:
	.long 0x40140000
	.long 0x0
	.align 2
.LC232:
	.long 0x3f800000
	.align 2
.LC233:
	.long 0x40400000
	.align 2
.LC234:
	.long 0x40000000
	.align 3
.LC235:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC236:
	.long 0x41200000
	.align 2
.LC237:
	.long 0x42c80000
	.align 2
.LC238:
	.long 0x437a0000
	.align 2
.LC239:
	.long 0x43020000
	.align 2
.LC240:
	.long 0x43480000
	.align 2
.LC241:
	.long 0x3fc00000
	.align 2
.LC242:
	.long 0x41000000
	.align 2
.LC243:
	.long 0x41700000
	.align 2
.LC244:
	.long 0x42700000
	.align 2
.LC245:
	.long 0x42480000
	.align 3
.LC246:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC247:
	.long 0x40800000
	.align 2
.LC248:
	.long 0x44960000
	.align 2
.LC249:
	.long 0x43960000
	.align 2
.LC250:
	.long 0x43340000
	.align 2
.LC251:
	.long 0x44610000
	.align 2
.LC252:
	.long 0x43fa0000
	.align 2
.LC253:
	.long 0x447a0000
	.align 3
.LC254:
	.long 0x3fc00000
	.long 0x0
	.align 2
.LC255:
	.long 0x43520000
	.align 2
.LC256:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl ClientThink
	.type	 ClientThink,@function
ClientThink:
	stwu 1,-368(1)
	mflr 0
	stfd 31,360(1)
	stmw 21,316(1)
	stw 0,372(1)
	lis 9,level@ha
	lis 6,.LC230@ha
	la 9,level@l(9)
	la 6,.LC230@l(6)
	lfs 31,0(6)
	mr 31,3
	mr 26,4
	lfs 0,200(9)
	lis 21,level@ha
	stw 31,292(9)
	lwz 25,84(31)
	fcmpu 0,0,31
	bc 12,2,.L483
	li 0,4
	lis 8,.LC231@ha
	stw 0,0(25)
	la 8,.LC231@l(8)
	lfs 0,200(9)
	lfd 12,0(8)
	lfs 13,4(9)
	fadd 0,0,12
	fcmpu 0,13,0
	bc 4,1,.L482
	lbz 0,1(26)
	andi. 10,0,128
	bc 12,2,.L482
	li 0,1
	stw 0,208(9)
	b .L482
.L483:
	lfs 13,4(9)
	lfs 0,896(31)
	fcmpu 0,0,13
	bc 4,1,.L485
	lwz 0,264(31)
	andi. 11,0,8192
	bc 4,2,.L486
	li 0,4
	stw 0,0(25)
	b .L482
.L485:
	lwz 0,264(31)
	andi. 6,0,8192
	bc 4,2,.L486
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L486
	lwz 0,480(31)
	cmpwi 0,0,999
	bc 4,1,.L487
	li 0,999
	stw 0,480(31)
.L487:
	lwz 0,264(31)
	lis 29,gi@ha
	andis. 8,0,1
	bc 12,2,.L512
	lwz 27,560(31)
	cmpwi 0,27,0
	bc 4,2,.L488
	bl G_Spawn
	li 30,3
	mr 28,3
	stw 31,564(28)
	stw 28,560(31)
	stw 27,540(28)
	stw 31,256(28)
	stw 30,284(28)
	lwz 9,84(31)
	lwz 11,1804(9)
	cmpwi 0,11,14
	bc 4,2,.L489
	lis 9,.LC197@ha
	li 0,12
	la 9,.LC197@l(9)
	lis 11,0x4000
	stw 0,516(28)
	stw 9,280(28)
	li 3,3
	la 29,gi@l(29)
	stw 11,592(28)
	b .L696
.L489:
	xori 9,11,13
	subfic 0,9,0
	adde 9,0,9
	subfic 0,11,-8
	subfic 6,0,0
	adde 0,6,0
	or. 8,9,0
	bc 12,2,.L491
	bl rand
	lis 9,0x9249
	lis 6,.LC233@ha
	lfs 13,592(31)
	ori 9,9,9363
	la 6,.LC233@l(6)
	lfs 0,0(6)
	mulhw 9,3,9
	srawi 11,3,31
	add 9,9,3
	srawi 9,9,2
	fcmpu 0,13,0
	subf 10,11,9
	slwi 0,10,3
	subf 0,10,0
	subf 10,0,3
	bc 4,2,.L492
	li 0,40
	stw 30,284(28)
	stw 0,516(28)
	b .L493
.L492:
	li 0,9
	li 9,22
	stw 0,284(28)
	stw 9,516(28)
.L493:
	lis 9,.LC199@ha
	lis 11,.LC198@ha
	lfs 0,.LC199@l(9)
	cmpwi 0,10,0
	la 11,.LC198@l(11)
	stw 11,280(28)
	stfs 0,592(28)
	bc 4,2,.L494
	lis 0,0xc0a0
	li 9,0
	b .L697
.L494:
	cmpwi 0,10,1
	bc 4,2,.L496
	lis 0,0x40a0
	li 9,0
	b .L697
.L496:
	cmpwi 0,10,2
	bc 4,2,.L498
	li 0,0
	b .L698
.L498:
	cmpwi 0,10,3
	bc 4,2,.L500
	li 0,0
	b .L698
.L500:
	cmpwi 0,10,4
	bc 4,2,.L502
	lis 0,0x40a0
.L698:
	stw 10,644(28)
	stw 0,596(28)
	stw 0,600(28)
	b .L495
.L502:
	cmpwi 0,10,5
	bc 4,2,.L504
	lis 0,0xc0a0
	lis 9,0x40a0
	b .L697
.L504:
	cmpwi 0,10,6
	bc 4,2,.L495
	li 0,0
	lis 9,0xc0a0
.L697:
	stw 10,644(28)
	stw 0,600(28)
	stw 9,596(28)
.L495:
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	bl rand_laser
	lwz 0,16(29)
	lis 6,.LC232@ha
	lis 8,.LC234@ha
	lis 9,.LC230@ha
	mr 5,3
	la 6,.LC232@l(6)
	la 8,.LC234@l(8)
	b .L699
.L491:
	cmpwi 0,11,-4
	bc 4,2,.L490
	lfs 0,592(31)
	fcmpu 0,0,31
	bc 4,2,.L509
	lis 9,.LC200@ha
	li 0,5
	la 9,.LC200@l(9)
	li 11,16
	stw 0,284(28)
	lis 10,0x3f00
	stw 9,280(28)
	li 3,1
	stw 11,516(28)
	la 29,gi@l(29)
	stw 10,592(28)
.L696:
	bl rand_laser
	lwz 0,16(29)
	lis 6,.LC232@ha
	lis 8,.LC232@ha
	lis 9,.LC230@ha
	mr 5,3
	la 6,.LC232@l(6)
	la 8,.LC232@l(8)
.L699:
	mtlr 0
	la 9,.LC230@l(9)
	li 4,0
	lfs 1,0(6)
	mr 3,31
	lfs 2,0(8)
	lfs 3,0(9)
	blrl
	b .L490
.L509:
	lis 9,.LC201@ha
	lis 11,.LC200@ha
	lfs 0,.LC201@l(9)
	li 0,193
	la 11,.LC200@l(11)
	li 9,24
	stw 0,284(28)
	li 3,2
	stw 9,516(28)
	la 29,gi@l(29)
	stw 11,280(28)
	stfs 0,592(28)
	bl rand_laser
	lwz 0,16(29)
	lis 6,.LC232@ha
	lis 8,.LC232@ha
	lis 9,.LC230@ha
	mr 5,3
	la 6,.LC232@l(6)
	la 8,.LC232@l(8)
	mtlr 0
	la 9,.LC230@l(9)
	li 4,0
	lfs 1,0(6)
	mr 3,31
	lfs 2,0(8)
	lfs 3,0(9)
	blrl
.L490:
	lfs 13,16(31)
	mr 3,28
	stfs 13,16(28)
	lfs 0,20(31)
	stfs 0,20(28)
	lfs 13,24(31)
	stfs 13,24(28)
	bl target_laser_start
	li 0,8
	lis 9,gi+72@ha
	stw 0,260(28)
	mr 3,28
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L488:
	lwz 0,264(31)
	andis. 6,0,1
	bc 12,2,.L512
	lwz 3,560(31)
	cmpwi 0,3,0
	bc 12,2,.L511
	lis 9,level+4@ha
	lfs 12,592(3)
	lfs 0,level+4@l(9)
	lwz 9,84(31)
	fadds 0,0,12
	lfs 13,1828(9)
	fcmpu 0,0,13
	bc 4,1,.L511
	lwz 0,1816(9)
	cmpwi 0,0,5
	bc 12,2,.L511
	bl target_laser_off
	lwz 3,560(31)
	bl G_FreeEdict
	lwz 0,264(31)
	li 9,0
	stw 9,560(31)
	rlwinm 0,0,0,16,14
	stw 0,264(31)
.L511:
	lwz 0,264(31)
	andis. 6,0,1
	bc 12,2,.L512
	lwz 3,560(31)
	cmpwi 0,3,0
	bc 12,2,.L512
	lis 9,level+4@ha
	lfs 12,592(3)
	lfs 0,level+4@l(9)
	lfs 13,920(31)
	fadds 0,0,12
	fcmpu 0,0,13
	bc 4,1,.L512
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,5
	bc 4,2,.L512
	bl target_laser_off
	lwz 3,560(31)
	bl G_FreeEdict
	lwz 0,264(31)
	li 9,0
	lwz 11,84(31)
	rlwinm 0,0,0,16,14
	stw 9,560(31)
	stw 0,264(31)
	stw 9,3624(11)
.L512:
	lwz 0,264(31)
	andi. 6,0,16384
	bc 12,2,.L513
	lwz 10,84(31)
	lis 9,level+4@ha
	lfs 12,level+4@l(9)
	lis 0,0x2aaa
	lfs 0,1828(10)
	ori 0,0,43691
	fsubs 0,0,12
	fctiwz 13,0
	stfd 13,304(1)
	lwz 11,308(1)
	mulli 11,11,10
	mulhw 0,11,0
	srawi 9,11,31
	subf 0,9,0
	mulli 0,0,6
	cmpw 0,11,0
	bc 4,2,.L513
	lis 29,gi@ha
	lis 3,.LC202@ha
	la 29,gi@l(29)
	la 3,.LC202@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 6,.LC232@ha
	lis 8,.LC232@ha
	lis 9,.LC230@ha
	mr 5,3
	la 6,.LC232@l(6)
	la 8,.LC232@l(8)
	mtlr 0
	la 9,.LC230@l(9)
	li 4,0
	lfs 1,0(6)
	mr 3,31
	lfs 2,0(8)
	lfs 3,0(9)
	blrl
.L513:
	lwz 4,924(31)
	cmpwi 0,4,0
	bc 4,1,.L515
	xoris 0,4,0x8000
	lwz 8,84(31)
	lis 9,0x4330
	stw 0,308(1)
	lis 6,.LC235@ha
	stw 9,304(1)
	la 6,.LC235@l(6)
	lis 10,level+4@ha
	lfd 11,0(6)
	lis 9,.LC236@ha
	lfd 0,304(1)
	la 9,.LC236@l(9)
	lfs 9,0(9)
	lfs 13,1828(8)
	lis 9,.LC203@ha
	fsub 0,0,11
	lfd 10,.LC203@l(9)
	lfs 12,level+4@l(10)
	frsp 0,0
	fdivs 0,0,9
	fsubs 13,13,0
	fsub 13,13,10
	fcmpu 0,13,12
	bc 4,0,.L515
	lis 10,.LC230@ha
	mr 3,31
	la 10,.LC230@l(10)
	li 5,14
	lfs 1,0(10)
	li 6,2000
	li 7,0
	bl card_fire
	lwz 9,924(31)
	addi 9,9,-1
	stw 9,924(31)
.L515:
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,6
	bc 4,2,.L516
	mr 3,31
	bl ArmorIndex
	mr. 3,3
	bc 12,2,.L516
	lis 6,.LC232@ha
	lfs 0,592(31)
	la 6,.LC232@l(6)
	lfs 13,0(6)
	fmr 12,0
	fcmpu 0,0,13
	bc 4,2,.L518
	slwi 0,3,2
	addi 9,25,740
	lwzx 11,9,0
	cmpwi 0,11,99
	bc 12,1,.L518
	li 0,0
	li 9,250
	stw 0,592(31)
	lis 11,gi+8@ha
	lis 5,.LC204@ha
	stw 9,484(31)
	la 5,.LC204@l(5)
	mr 3,31
	lwz 0,gi+8@l(11)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L519
.L518:
	lis 6,.LC230@ha
	la 6,.LC230@l(6)
	lfs 0,0(6)
	fcmpu 0,12,0
	bc 4,2,.L519
	slwi 0,3,2
	addi 9,25,740
	lwzx 11,9,0
	cmpwi 0,11,99
	bc 4,1,.L519
	lis 0,0x3f80
	li 9,300
	stw 0,592(31)
	lis 11,gi+8@ha
	lis 5,.LC205@ha
	stw 9,484(31)
	la 5,.LC205@l(5)
	mr 3,31
	lwz 0,gi+8@l(11)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L519:
	lwz 0,480(31)
	lwz 9,484(31)
	cmpw 0,0,9
	bc 4,1,.L516
	stw 9,480(31)
.L516:
	lwz 9,84(31)
	addi 24,31,4
	lwz 0,1816(9)
	cmpwi 0,0,3
	bc 4,2,.L522
	lwz 0,40(31)
	cmpwi 0,0,255
	mr 11,0
	bc 4,2,.L523
	lwz 0,3624(9)
	cmpwi 0,0,0
	bc 4,2,.L523
	lwz 0,640(31)
	cmpwi 0,0,50
	bc 12,1,.L523
	mr 3,31
	bl MakeInvis
	b .L524
.L523:
	lis 9,invis_index@ha
	addi 24,31,4
	lwz 0,invis_index@l(9)
	cmpw 0,11,0
	bc 4,2,.L522
	lwz 0,640(31)
	cmpwi 0,0,50
	bc 12,1,.L526
	lwz 9,84(31)
	lwz 0,3624(9)
	cmpwi 0,0,0
	bc 12,2,.L524
.L526:
	mr 3,31
	bl MakeVis
.L524:
	lis 9,invis_index@ha
	lwz 11,40(31)
	addi 24,31,4
	lwz 0,invis_index@l(9)
	cmpw 0,11,0
	bc 4,2,.L522
	bl rand
	lis 0,0x6666
	srawi 9,3,31
	ori 0,0,26215
	mulhw 0,3,0
	srawi 0,0,2
	subf 0,9,0
	mulli 0,0,10
	cmpw 0,3,0
	bc 4,2,.L522
	addi 29,1,256
	mr 3,29
	bl avrandom
	lis 6,.LC237@ha
	mr 3,24
	la 6,.LC237@l(6)
	mr 4,29
	lfs 1,0(6)
	mr 5,29
	bl VectorMA
	mr 4,29
	li 3,4
	li 5,0
	li 6,10
	bl SpawnDamage
.L522:
	lwz 11,84(31)
	addi 30,31,376
	lwz 0,1808(11)
	cmpwi 0,0,17
	bc 4,2,.L528
	lis 9,level+4@ha
	lfs 13,1832(11)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L528
	lis 6,.LC238@ha
	lis 9,g_edicts@ha
	la 6,.LC238@l(6)
	lwz 3,g_edicts@l(9)
	mr 4,24
	lfs 1,0(6)
	lis 23,g_edicts@ha
	bl findradius
	mr. 28,3
	bc 12,2,.L530
.L531:
	cmpw 0,28,31
	lwz 9,g_edicts@l(23)
	xor 9,28,9
	subfic 0,9,0
	adde 9,0,9
	mcrf 7,0
	mfcr 0
	rlwinm 0,0,3,1
	or. 6,9,0
	bc 4,2,.L533
	lwz 9,84(28)
	cmpwi 0,9,0
	bc 12,2,.L532
	lwz 0,1808(9)
	cmpwi 0,0,8
	bc 4,2,.L532
.L533:
	lis 8,.LC238@ha
	mr 3,28
	la 8,.LC238@l(8)
	mr 4,24
	lfs 1,0(8)
	b .L700
.L532:
	bc 12,30,.L534
	lwz 0,512(28)
	cmpwi 0,0,0
	bc 4,2,.L535
	lwz 0,260(28)
	cmpwi 0,0,9
	bc 12,2,.L535
	cmpwi 0,0,8
	bc 4,2,.L534
.L535:
	lwz 0,g_edicts@l(23)
	cmpw 0,28,0
	bc 12,2,.L534
	lwz 0,248(28)
	cmpwi 0,0,3
	bc 12,2,.L534
	lwz 0,264(28)
	andi. 29,0,8192
	bc 4,2,.L534
	lfs 0,4(31)
	addi 27,1,256
	lfs 13,4(28)
	mr 3,27
	mr 4,27
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,256(1)
	lfs 0,8(28)
	fsubs 0,0,12
	stfs 0,260(1)
	lfs 13,12(28)
	fsubs 13,13,11
	stfs 13,264(1)
	bl VectorNormalize2
	lwz 0,552(28)
	cmpwi 0,0,0
	bc 12,2,.L536
	stw 29,552(28)
.L536:
	lis 6,.LC239@ha
	addi 29,28,376
	la 6,.LC239@l(6)
	mr 4,27
	lfs 1,0(6)
	mr 3,29
	mr 5,29
	bl VectorMA
	lis 9,.LC206@ha
	mr 3,29
	lfs 1,.LC206@l(9)
	mr 4,30
	mr 5,3
	bl VectorMA
.L534:
	lis 6,.LC240@ha
	mr 3,28
	la 6,.LC240@l(6)
	mr 4,24
	lfs 1,0(6)
.L700:
	bl findradius
	mr 28,3
	cmpwi 0,28,0
	bc 4,2,.L531
.L530:
	lis 9,level+4@ha
	lis 11,.LC207@ha
	lwz 10,84(31)
	lfs 0,level+4@l(9)
	lfd 13,.LC207@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,1832(10)
.L528:
	lwz 11,84(31)
	lwz 0,1808(11)
	cmpwi 0,0,16
	bc 4,2,.L538
	lis 9,level+4@ha
	lfs 13,1832(11)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L538
	lwz 11,480(31)
	lis 9,.LC208@ha
	lfs 13,.LC208@l(9)
	cmpwi 0,11,29
	bc 12,1,.L539
	addi 0,11,1
	lis 9,.LC209@ha
	stw 0,480(31)
	lfs 13,.LC209@l(9)
	b .L540
.L539:
	cmpwi 0,11,99
	bc 12,1,.L541
	addi 0,11,1
	lis 9,.LC210@ha
	stw 0,480(31)
	lfs 13,.LC210@l(9)
	b .L540
.L541:
	cmpwi 0,11,199
	bc 12,1,.L543
	addi 0,11,1
	lis 9,.LC211@ha
	stw 0,480(31)
	lfs 13,.LC211@l(9)
	b .L540
.L543:
	cmpwi 0,11,249
	bc 12,1,.L540
	lis 6,.LC241@ha
	addi 0,11,1
	la 6,.LC241@l(6)
	stw 0,480(31)
	lfs 13,0(6)
.L540:
	lis 9,level+4@ha
	lwz 11,84(31)
	lfs 0,level+4@l(9)
	fadds 0,0,13
	stfs 0,1832(11)
.L538:
	lwz 11,84(31)
	lwz 0,1808(11)
	cmpwi 0,0,15
	bc 4,2,.L546
	lis 9,level@ha
	lfs 13,1832(11)
	la 30,level@l(9)
	lfs 0,4(30)
	fcmpu 0,13,0
	bc 4,0,.L546
	bl rand
	lis 0,0x6666
	srawi 9,3,31
	ori 0,0,26215
	mulhw 0,3,0
	srawi 0,0,2
	subf 0,9,0
	mulli 0,0,10
	subf 3,0,3
	cmpwi 0,3,4
	bc 12,1,.L547
	lis 6,.LC242@ha
	lis 8,.LC240@ha
	la 6,.LC242@l(6)
	la 8,.LC240@l(8)
	lfs 1,0(6)
	mr 3,31
	mr 4,31
	lfs 2,0(8)
	mr 5,31
	li 6,128
	li 7,46
	bl T_RadiusDamage
.L547:
	lfs 0,4(30)
	lis 9,.LC207@ha
	lfd 13,.LC207@l(9)
	lwz 9,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,1832(9)
.L546:
	lwz 11,84(31)
	lwz 0,1808(11)
	cmpwi 0,0,-10
	bc 4,2,.L548
	lis 9,level@ha
	lfs 13,1832(11)
	la 30,level@l(9)
	lfs 0,4(30)
	fcmpu 0,13,0
	bc 4,0,.L548
	bl rand
	lis 0,0x6666
	srawi 9,3,31
	ori 0,0,26215
	mulhw 0,3,0
	srawi 0,0,2
	subf 0,9,0
	mulli 0,0,10
	subf 3,0,3
	cmpwi 0,3,4
	bc 12,1,.L549
	lis 6,.LC243@ha
	lis 8,.LC237@ha
	la 6,.LC243@l(6)
	la 8,.LC237@l(8)
	lfs 1,0(6)
	mr 3,31
	mr 4,31
	lfs 2,0(8)
	mr 5,31
	li 6,128
	li 7,54
	bl T_RadiusDamage
.L549:
	lfs 0,4(30)
	lis 9,.LC207@ha
	lfd 13,.LC207@l(9)
	lwz 9,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,1832(9)
.L548:
	lwz 9,84(31)
	lwz 0,1808(9)
	cmpwi 7,0,-8
	xori 0,0,10
	subfic 6,0,0
	adde 0,6,0
	mfcr 9
	rlwinm 9,9,31,1
	or. 8,0,9
	bc 12,2,.L550
	li 28,5
	bc 4,30,.L551
	addi 3,31,376
	bl VectorLength
	lis 6,.LC244@ha
	lis 8,.LC236@ha
	la 6,.LC244@l(6)
	la 8,.LC236@l(8)
	lfs 12,0(6)
	lfs 0,0(8)
	fdivs 1,1,12
	fsubs 0,0,1
	fctiwz 13,0
	stfd 13,304(1)
	lwz 28,308(1)
	cmpwi 7,28,4
	mfcr 0
	rlwinm 0,0,30,1
	neg 0,0
	nor 9,0,0
	and 0,28,0
	andi. 9,9,5
	or 28,0,9
	cmpwi 7,28,11
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 0,28,0
	andi. 9,9,10
	or 28,0,9
.L551:
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,1832(11)
	fcmpu 0,0,13
	bc 4,0,.L554
	lwz 0,40(31)
	cmpwi 0,0,255
	bc 4,2,.L554
	lwz 0,3624(11)
	cmpwi 0,0,0
	bc 4,2,.L554
	lis 29,gi@ha
	lis 3,.LC212@ha
	la 29,gi@l(29)
	la 3,.LC212@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 6,.LC232@ha
	lis 8,.LC232@ha
	lis 9,.LC230@ha
	mr 5,3
	la 6,.LC232@l(6)
	la 8,.LC232@l(8)
	mtlr 0
	la 9,.LC230@l(9)
	mr 3,31
	lfs 1,0(6)
	li 4,3
	lfs 2,0(8)
	lfs 3,0(9)
	blrl
	mr 3,31
	bl MakeInvis
	b .L555
.L554:
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,1832(11)
	fcmpu 0,0,13
	bc 4,1,.L555
	lis 9,invis_index@ha
	lwz 0,40(31)
	lwz 11,invis_index@l(9)
	cmpw 0,0,11
	bc 4,2,.L555
	mr 3,31
	bl MakeVis
.L555:
	lis 11,invis_index@ha
	lwz 9,40(31)
	srawi 0,28,31
	lwz 10,invis_index@l(11)
	subf 0,28,0
	srwi 0,0,31
	xor 9,9,10
	subfic 6,9,0
	adde 9,6,9
	and. 8,9,0
	bc 12,2,.L550
	bl rand
	divw 0,3,28
	mullw 0,0,28
	cmpw 0,3,0
	bc 4,2,.L550
	addi 29,1,272
	mr 3,29
	bl avrandom
	lis 6,.LC245@ha
	mr 3,24
	la 6,.LC245@l(6)
	mr 4,29
	lfs 1,0(6)
	mr 5,29
	bl VectorMA
	mr 4,29
	li 3,4
	li 5,0
	li 6,15
	bl SpawnDamage
.L550:
	lwz 11,84(31)
	lwz 0,1808(11)
	cmpwi 0,0,14
	bc 4,2,.L558
	lis 9,level+4@ha
	lfs 13,1832(11)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L558
	bl rand
	lis 0,0x51eb
	srawi 9,3,31
	ori 0,0,34079
	mulhw 0,3,0
	srawi 0,0,5
	subf 0,9,0
	mulli 0,0,100
	subf 3,0,3
	cmpwi 0,3,4
	bc 12,1,.L559
	lwz 0,264(31)
	andis. 6,0,16
	bc 12,2,.L560
	rlwinm 0,0,0,12,10
	b .L701
.L560:
	oris 0,0,0x10
.L701:
	stw 0,264(31)
.L559:
	bl rand
	lis 0,0x51eb
	srawi 9,3,31
	ori 0,0,34079
	mulhw 0,3,0
	srawi 0,0,5
	subf 0,9,0
	mulli 0,0,100
	subf 3,0,3
	cmpwi 0,3,4
	bc 12,1,.L562
	lwz 0,264(31)
	andis. 6,0,32
	bc 12,2,.L563
	rlwinm 0,0,0,11,9
	b .L702
.L563:
	oris 0,0,0x20
.L702:
	stw 0,264(31)
.L562:
	bl rand
	lis 0,0x51eb
	srawi 9,3,31
	ori 0,0,34079
	mulhw 0,3,0
	srawi 0,0,5
	subf 0,9,0
	mulli 0,0,100
	subf 3,0,3
	cmpwi 0,3,4
	bc 12,1,.L565
	lwz 0,264(31)
	andis. 6,0,8
	bc 12,2,.L566
	rlwinm 0,0,0,13,11
	b .L703
.L566:
	oris 0,0,0x8
.L703:
	stw 0,264(31)
.L565:
	lis 9,level+4@ha
	lis 11,.LC207@ha
	lwz 10,84(31)
	lfs 0,level+4@l(9)
	lfd 13,.LC207@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,1832(10)
.L558:
	lwz 9,84(31)
	lwz 0,1808(9)
	cmpwi 0,0,12
	bc 4,2,.L568
	lwz 0,608(31)
	andi. 8,0,56
	bc 12,2,.L693
	lwz 0,40(31)
	cmpwi 0,0,255
	bc 4,2,.L570
	mr 3,31
	bl MakeInvis
	b .L570
.L693:
	lis 9,invis_index@ha
	lwz 11,40(31)
	lwz 0,invis_index@l(9)
	cmpw 0,11,0
	bc 4,2,.L568
	mr 3,31
	bl MakeVis
.L570:
	lis 9,invis_index@ha
	lwz 11,40(31)
	lwz 0,invis_index@l(9)
	cmpw 0,11,0
	bc 4,2,.L568
	bl rand
	lis 0,0x6666
	srawi 9,3,31
	ori 0,0,26215
	mulhw 0,3,0
	srawi 0,0,2
	subf 0,9,0
	mulli 0,0,10
	cmpw 0,3,0
	bc 4,2,.L568
	addi 29,1,272
	mr 3,29
	bl avrandom
	lis 6,.LC245@ha
	mr 3,24
	la 6,.LC245@l(6)
	mr 4,29
	lfs 1,0(6)
	mr 5,29
	bl VectorMA
	mr 4,29
	li 3,4
	li 5,0
	li 6,10
	bl SpawnDamage
.L568:
	lwz 27,84(31)
	lwz 0,1808(27)
	cmpwi 0,0,20
	bc 4,2,.L573
	lwz 10,640(31)
	cmpwi 0,10,39
	bc 12,1,.L574
	lis 9,level+4@ha
	lfs 0,1832(27)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L574
	lis 0,0x6666
	lis 6,.LC246@ha
	ori 0,0,26215
	srawi 11,10,31
	mulhw 0,10,0
	la 6,.LC246@l(6)
	lfd 0,0(6)
	lis 10,0x4330
	lis 8,.LC235@ha
	srawi 0,0,2
	la 8,.LC235@l(8)
	subf 0,11,0
	lfd 12,0(8)
	li 28,32
	xoris 0,0,0x8000
	fadd 13,13,0
	li 29,47
	stw 0,308(1)
	lis 6,v_up@ha
	mr 3,31
	stw 10,304(1)
	la 6,v_up@l(6)
	mr 4,31
	lfd 0,304(1)
	mr 5,31
	mr 7,24
	li 8,0
	li 9,1
	li 10,0
	fsub 0,0,12
	fadd 13,13,0
	frsp 13,13
	stfs 13,1832(27)
	stw 28,8(1)
	stw 29,12(1)
	bl T_Damage
.L574:
	lwz 11,640(31)
	cmpwi 0,11,85
	bc 4,1,.L573
	lwz 8,84(31)
	lis 9,level@ha
	la 7,level@l(9)
	lfs 11,4(7)
	lfs 0,1832(8)
	fcmpu 0,0,11
	bc 4,0,.L573
	addi 0,11,-85
	lis 9,0x6666
	ori 9,9,26215
	srawi 10,0,31
	mulhw 0,0,9
	lis 6,.LC235@ha
	lis 9,0x4330
	la 6,.LC235@l(6)
	srawi 0,0,2
	lfd 12,0(6)
	subf 0,10,0
	lis 6,.LC247@ha
	xoris 0,0,0x8000
	la 6,.LC247@l(6)
	stw 0,308(1)
	stw 9,304(1)
	lfd 0,304(1)
	lfs 13,0(6)
	lis 6,.LC246@ha
	fsub 0,0,12
	la 6,.LC246@l(6)
	fadds 13,11,13
	lfd 11,0(6)
	frsp 0,0
	fsubs 13,13,0
	stfs 13,1832(8)
	lfs 0,4(7)
	lwz 9,84(31)
	lfs 13,1832(9)
	fadd 0,0,11
	fcmpu 0,13,0
	bc 4,0,.L576
	frsp 0,0
	stfs 0,1832(9)
.L576:
	lwz 9,480(31)
	addi 9,9,1
	cmpwi 0,9,200
	stw 9,480(31)
	bc 4,1,.L573
	li 0,200
	stw 0,480(31)
.L573:
	lwz 11,84(31)
	lwz 0,1808(11)
	cmpwi 0,0,13
	bc 4,2,.L578
	lis 9,level@ha
	lfs 13,1832(11)
	la 30,level@l(9)
	lfs 0,4(30)
	fcmpu 0,13,0
	bc 4,0,.L578
	mr 3,31
	bl ArmorIndex
	mr. 3,3
	bc 12,2,.L578
	lwz 11,84(31)
	slwi 3,3,2
	addi 11,11,740
	lwzx 9,11,3
	addi 9,9,1
	stwx 9,11,3
	lwz 10,84(31)
	addi 10,10,740
	lwzx 0,10,3
	cmpwi 0,0,500
	bc 4,1,.L580
	li 0,500
	stwx 0,10,3
.L580:
	lfs 0,4(30)
	lis 9,.LC213@ha
	lfd 13,.LC213@l(9)
	lwz 9,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,1832(9)
.L578:
	lwz 11,84(31)
	lwz 0,1812(11)
	cmpwi 0,0,18
	bc 4,2,.L581
	lis 9,level@ha
	lfs 0,1836(11)
	la 10,level@l(9)
	lfs 13,4(10)
	fcmpu 0,0,13
	bc 4,0,.L581
	lwz 9,480(31)
	cmpwi 0,9,100
	bc 12,1,.L582
	fmr 0,13
	lis 9,.LC214@ha
	lfd 13,.LC214@l(9)
	b .L704
.L582:
	cmpwi 0,9,199
	bc 12,1,.L584
	addi 0,9,-1
	stw 0,480(31)
	lis 9,.LC215@ha
	lfs 0,4(10)
	lfd 13,.LC215@l(9)
	b .L705
.L584:
	cmpwi 0,9,299
	bc 12,1,.L586
	addi 0,9,-1
	stw 0,480(31)
	lis 9,.LC216@ha
	lfs 0,4(10)
	lfd 13,.LC216@l(9)
	b .L705
.L586:
	cmpwi 0,9,399
	bc 12,1,.L588
	addi 0,9,-1
	lis 6,.LC246@ha
	stw 0,480(31)
	la 6,.LC246@l(6)
	lfs 0,4(10)
	lfd 13,0(6)
	b .L705
.L588:
	cmpwi 0,9,499
	bc 12,1,.L590
	addi 0,9,-3
	stw 0,480(31)
	lis 9,.LC217@ha
	lfs 0,4(10)
	lfd 13,.LC217@l(9)
	b .L705
.L590:
	addi 0,9,-3
	stw 0,480(31)
	lis 9,.LC218@ha
	lfs 0,4(10)
	lfd 13,.LC218@l(9)
.L705:
.L704:
	fadd 0,0,13
	frsp 0,0
	stfs 0,1836(11)
.L581:
	lwz 9,84(31)
	lwz 0,1812(9)
	cmpwi 0,0,8
	bc 4,2,.L592
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,1,.L592
	bl rand
	lis 0,0x6666
	srawi 9,3,31
	ori 0,0,26215
	mulhw 0,3,0
	srawi 0,0,2
	subf 0,9,0
	mulli 0,0,10
	subf. 6,0,3
	bc 12,1,.L592
	lwz 11,84(31)
	lis 9,level@ha
	la 30,level@l(9)
	lfs 13,1836(11)
	lfs 0,4(30)
	fcmpu 0,13,0
	bc 4,0,.L592
	lwz 0,612(31)
	lis 10,0x4330
	lis 8,.LC235@ha
	lis 9,g_edicts@ha
	xoris 0,0,0x8000
	la 8,.LC235@l(8)
	lwz 4,g_edicts@l(9)
	stw 0,308(1)
	lis 9,.LC240@ha
	mr 3,31
	stw 10,304(1)
	la 9,.LC240@l(9)
	li 5,0
	lfd 0,0(8)
	li 6,128
	li 7,48
	lfd 1,304(1)
	lfs 2,0(9)
	fsub 1,1,0
	frsp 1,1
	bl T_RadiusDamage
	lfs 0,4(30)
	lis 9,.LC207@ha
	lfd 13,.LC207@l(9)
	lwz 9,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,1836(9)
.L592:
	lwz 11,84(31)
	lwz 0,1812(11)
	cmpwi 0,0,6
	bc 4,2,.L594
	lwz 0,264(31)
	andis. 6,0,64
	bc 12,2,.L593
	lis 9,level+4@ha
	lfs 13,1836(11)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L593
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L593
	mr 3,31
	bl MV
	li 9,49
	li 0,32
	stw 9,12(1)
	lis 6,v_up@ha
	mr 7,24
	stw 0,8(1)
	la 6,v_up@l(6)
	mr 3,31
	mr 4,31
	mr 5,31
	li 8,0
	li 9,10000
	li 10,0
	bl T_Damage
	lwz 0,264(31)
	rlwinm 0,0,0,10,8
	stw 0,264(31)
.L593:
	lwz 8,84(31)
	lwz 0,1812(8)
	cmpwi 0,0,6
	bc 4,2,.L594
	lwz 0,264(31)
	andis. 6,0,64
	bc 4,2,.L594
	lwz 9,480(31)
	cmpwi 0,9,19
	bc 12,1,.L594
	cmpwi 0,9,0
	bc 4,1,.L594
	li 9,300
	oris 0,0,0x40
	lis 10,.LC243@ha
	stw 9,480(31)
	lis 11,level+4@ha
	stw 0,264(31)
	la 10,.LC243@l(10)
	lis 4,.LC219@ha
	lfs 13,0(10)
	la 4,.LC219@l(4)
	li 3,2
	lfs 0,level+4@l(11)
	lis 10,gi@ha
	lis 27,.LC151@ha
	lis 28,0x38e3
	ori 28,28,36409
	fadds 0,0,13
	stfs 0,1836(8)
	lwz 0,gi@l(10)
	lwz 5,84(31)
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	la 3,.LC151@l(27)
	bl FindItem
	lis 29,itemlist@ha
	lwz 9,84(31)
	li 10,1
	la 29,itemlist@l(29)
	lis 11,.LC152@ha
	subf 0,29,3
	addi 9,9,740
	mullw 0,0,28
	la 3,.LC152@l(11)
	srawi 0,0,3
	slwi 0,0,2
	stwx 10,9,0
	bl FindItem
	subf 0,29,3
	lwz 9,84(31)
	li 11,100
	mullw 0,0,28
	la 3,.LC151@l(27)
	addi 9,9,740
	srawi 0,0,3
	slwi 0,0,2
	stwx 11,9,0
	bl FindItem
	lwz 9,84(31)
	stw 3,3588(9)
	mr 3,31
	bl ChangeWeapon
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 4,2,.L596
	li 0,0
	b .L597
.L596:
	lis 4,.LC21@ha
	addi 3,3,188
	la 4,.LC21@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 6,9,0
	adde 9,6,9
	xori 0,0,102
	subfic 8,0,0
	adde 0,8,0
	or 0,0,9
.L597:
	cmpwi 0,0,0
	bc 12,2,.L595
	lis 29,gi@ha
	lis 3,.LC220@ha
	la 29,gi@l(29)
	la 3,.LC220@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 6,.LC232@ha
	lis 8,.LC232@ha
	lis 9,.LC230@ha
	mr 5,3
	la 6,.LC232@l(6)
	la 8,.LC232@l(8)
	mtlr 0
	la 9,.LC230@l(9)
	li 4,0
	lfs 1,0(6)
	mr 3,31
	lfs 2,0(8)
	lfs 3,0(9)
	blrl
	b .L599
.L595:
	lis 29,gi@ha
	lis 3,.LC221@ha
	la 29,gi@l(29)
	la 3,.LC221@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 6,.LC232@ha
	lis 8,.LC232@ha
	lis 9,.LC230@ha
	mr 5,3
	la 6,.LC232@l(6)
	la 8,.LC232@l(8)
	mtlr 0
	la 9,.LC230@l(9)
	li 4,0
	lfs 1,0(6)
	mr 3,31
	lfs 2,0(8)
	lfs 3,0(9)
	blrl
.L599:
	lwz 9,540(31)
	lwz 11,84(9)
	cmpwi 0,11,0
	bc 12,2,.L594
	cmpw 0,9,31
	bc 12,2,.L594
	lwz 9,3496(11)
	addi 9,9,1
	stw 9,3496(11)
.L594:
	lwz 11,84(31)
	lwz 9,1812(11)
	addi 9,9,-2
	cmplwi 0,9,2
	bc 12,1,.L601
	lwz 0,892(31)
	cmpwi 0,0,0
	bc 4,2,.L601
	mr 3,31
	bl spawn_angel
.L601:
	lwz 0,900(31)
	cmpwi 0,0,0
	bc 4,1,.L604
	lwz 0,480(31)
	cmpwi 0,0,5
	bc 4,1,.L602
	bl rand
	lis 0,0xea0e
	srawi 9,3,31
	lwz 11,900(31)
	ori 0,0,41195
	mulhw 0,3,0
	add 0,0,3
	srawi 0,0,5
	subf 0,9,0
	mulli 0,0,35
	subf 3,0,3
	cmpw 0,3,11
	bc 4,0,.L602
	lis 9,level@ha
	lfs 13,904(31)
	la 30,level@l(9)
	lfs 0,4(30)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L602
	mr 3,31
	bl MV
	lwz 9,480(31)
	lis 11,.LC207@ha
	lis 5,v_forward@ha
	lfd 13,.LC207@l(11)
	la 5,v_forward@l(5)
	li 3,1
	addi 9,9,-1
	addi 4,31,4
	stw 9,480(31)
	li 6,100
	lfs 0,4(30)
	fadd 0,0,13
	frsp 0,0
	stfs 0,904(31)
	bl SpawnDamage
.L602:
	lwz 0,900(31)
	cmpwi 0,0,0
	bc 4,1,.L604
	lwz 0,480(31)
	cmpwi 0,0,5
	bc 12,1,.L603
	li 0,0
	stw 0,900(31)
.L603:
	lwz 9,900(31)
	cmpwi 0,9,0
	bc 4,1,.L604
	lwz 0,480(31)
	cmpwi 0,0,89
	bc 4,1,.L604
	addi 0,9,-1
	stw 0,900(31)
.L604:
	lis 9,level+4@ha
	lfs 13,908(31)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,1,.L486
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L486
	li 0,300
	sth 0,12(26)
.L486:
	addi 3,1,16
	lis 9,pm_passent@ha
	mr 27,3
	stw 31,pm_passent@l(9)
	li 4,0
	li 5,240
	crxor 6,6,6
	bl memset
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L611
	lwz 0,264(31)
	andi. 6,0,8192
	bc 4,2,.L609
	lwz 11,40(31)
	cmpwi 0,11,255
	bc 12,2,.L609
	lis 9,invis_index@ha
	lwz 0,invis_index@l(9)
	cmpw 0,11,0
	bc 12,2,.L609
	lis 9,robot_index@ha
	lwz 0,robot_index@l(9)
	cmpw 0,11,0
	bc 12,2,.L609
	lis 9,cripple_index@ha
	lwz 0,cripple_index@l(9)
	cmpw 0,11,0
	bc 12,2,.L609
	lis 9,sun_index@ha
	lwz 0,sun_index@l(9)
	cmpw 0,11,0
	li 0,3
	bc 4,2,.L611
.L609:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L611
	li 0,2
.L611:
	stw 0,0(25)
	lis 10,sv_gravity@ha
	lwz 7,0(25)
	lwz 9,sv_gravity@l(10)
	lwz 0,8(25)
	lfs 0,20(9)
	lwz 9,12(25)
	lwz 8,4(25)
	fctiwz 13,0
	stfd 13,304(1)
	lwz 11,308(1)
	sth 11,18(25)
	stw 7,16(1)
	stw 8,4(27)
	stw 0,8(27)
	stw 9,12(27)
	lwz 0,16(25)
	lwz 9,20(25)
	lwz 11,24(25)
	lwz 10,84(31)
	stw 0,16(27)
	stw 9,20(27)
	stw 11,24(27)
	lwz 0,1808(10)
	cmpwi 0,0,18
	bc 4,2,.L613
	lwz 0,264(31)
	andi. 8,0,8192
	bc 4,2,.L613
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L613
	mr 3,31
	bl MV
	lha 0,8(26)
	cmpwi 0,0,0
	bc 4,1,.L614
	lis 6,.LC248@ha
	mr 3,26
	la 6,.LC248@l(6)
	lfs 31,0(6)
	bl framerate
	lis 29,v_forward@ha
	lfs 13,376(31)
	mr 3,26
	lfs 0,v_forward@l(29)
	la 29,v_forward@l(29)
	fmuls 0,0,31
	fmadds 0,0,1,13
	stfs 0,376(31)
	bl framerate
	lfs 0,4(29)
	lfs 13,380(31)
	fmuls 0,0,31
	fmadds 0,0,1,13
	stfs 0,380(31)
	b .L615
.L614:
	bc 4,0,.L615
	lis 6,.LC248@ha
	mr 3,26
	la 6,.LC248@l(6)
	lfs 31,0(6)
	bl framerate
	lis 29,v_forward@ha
	lfs 13,376(31)
	mr 3,26
	lfs 0,v_forward@l(29)
	la 29,v_forward@l(29)
	fmuls 0,0,31
	fmuls 0,0,1
	fsubs 13,13,0
	stfs 13,376(31)
	bl framerate
	lfs 0,4(29)
	lfs 13,380(31)
	fmuls 0,0,31
	fmuls 0,0,1
	fsubs 13,13,0
	stfs 13,380(31)
.L615:
	lha 0,10(26)
	cmpwi 0,0,0
	bc 4,1,.L617
	lis 6,.LC248@ha
	mr 3,26
	la 6,.LC248@l(6)
	lfs 31,0(6)
	bl framerate
	lis 29,v_right@ha
	lfs 13,376(31)
	mr 3,26
	lfs 0,v_right@l(29)
	la 29,v_right@l(29)
	fmuls 0,0,31
	fmadds 0,0,1,13
	stfs 0,376(31)
	bl framerate
	lfs 0,4(29)
	lfs 13,380(31)
	fmuls 0,0,31
	fmadds 0,0,1,13
	stfs 0,380(31)
	b .L618
.L617:
	bc 4,0,.L618
	lis 6,.LC248@ha
	mr 3,26
	la 6,.LC248@l(6)
	lfs 31,0(6)
	bl framerate
	lis 29,v_right@ha
	lfs 13,376(31)
	mr 3,26
	lfs 0,v_right@l(29)
	la 29,v_right@l(29)
	fmuls 0,0,31
	fmuls 0,0,1
	fsubs 13,13,0
	stfs 13,376(31)
	bl framerate
	lfs 0,4(29)
	lfs 13,380(31)
	fmuls 0,0,31
	fmuls 0,0,1
	fsubs 13,13,0
	stfs 13,380(31)
.L618:
	lha 0,12(26)
	cmpwi 0,0,9
	bc 4,1,.L620
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L620
	lis 6,.LC249@ha
	lfs 0,384(31)
	la 6,.LC249@l(6)
	lfs 13,0(6)
	fadds 0,0,13
	stfs 0,384(31)
.L620:
	lfs 0,380(31)
	lfs 1,376(31)
	fmuls 0,0,0
	fmadds 1,1,1,0
	bl sqrt
	lis 9,.LC222@ha
	frsp 1,1
	lfs 12,.LC222@l(9)
	b .L706
.L613:
	lwz 9,84(31)
	lwz 0,264(31)
	lwz 11,1808(9)
	mr 10,9
	mr 9,0
	xori 0,0,8192
	subfic 11,11,-4
	subfic 6,11,0
	adde 11,6,11
	rlwinm 0,0,19,31,31
	and. 8,11,0
	bc 12,2,.L623
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L623
	lis 9,.LC230@ha
	lfs 13,380(31)
	lis 10,.LC250@ha
	la 9,.LC230@l(9)
	lfs 0,592(31)
	lis 11,.LC238@ha
	lfs 11,0(9)
	la 10,.LC250@l(10)
	la 11,.LC238@l(11)
	fmuls 13,13,13
	lfs 1,376(31)
	lfs 12,0(10)
	fsubs 0,0,11
	lfs 31,0(11)
	fmadds 1,1,1,13
	fsel 31,0,31,12
	fneg 0,0
	fsel 31,0,12,31
	bl sqrt
	frsp 11,1
	fcmpu 0,11,31
	bc 4,1,.L626
	fdivs 12,31,11
	lfs 13,376(31)
	lfs 0,380(31)
	fmuls 13,13,12
	fmuls 0,0,12
	stfs 13,376(31)
	stfs 0,380(31)
.L626:
	lha 0,12(26)
	lis 29,gi@ha
	cmpwi 0,0,9
	bc 4,1,.L622
	mr 3,26
	bl framerate
	lis 6,.LC251@ha
	lfs 0,384(31)
	la 6,.LC251@l(6)
	lfs 13,0(6)
	fmadds 1,1,13,0
	fcmpu 0,1,31
	stfs 1,384(31)
	bc 4,1,.L628
	stfs 31,384(31)
.L628:
	li 0,0
	la 29,gi@l(29)
	stw 0,552(31)
	lis 3,.LC223@ha
	lwz 9,36(29)
	la 3,.LC223@l(3)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 6,.LC232@ha
	lis 8,.LC230@ha
	mr 5,3
	lis 9,.LC224@ha
	la 6,.LC232@l(6)
	la 8,.LC230@l(8)
	lfs 1,.LC224@l(9)
	mtlr 0
	mr 3,31
	li 4,0
	lfs 2,0(6)
	lfs 3,0(8)
	blrl
	b .L622
.L623:
	lwz 0,1808(10)
	cmpwi 0,0,-3
	bc 4,2,.L630
	andi. 0,9,8192
	bc 4,2,.L630
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L630
	mr 3,31
	bl MV
	lha 0,8(26)
	cmpwi 0,0,0
	bc 4,1,.L631
	lis 6,.LC248@ha
	mr 3,26
	la 6,.LC248@l(6)
	lfs 31,0(6)
	bl framerate
	lis 29,v_forward@ha
	lfs 13,376(31)
	mr 3,26
	lfs 0,v_forward@l(29)
	la 29,v_forward@l(29)
	fmuls 0,0,31
	fmadds 0,0,1,13
	stfs 0,376(31)
	bl framerate
	lfs 0,4(29)
	lfs 13,380(31)
	fmuls 0,0,31
	fmadds 0,0,1,13
	stfs 0,380(31)
	b .L632
.L631:
	bc 4,0,.L632
	lis 6,.LC248@ha
	mr 3,26
	la 6,.LC248@l(6)
	lfs 31,0(6)
	bl framerate
	lis 29,v_forward@ha
	lfs 13,376(31)
	mr 3,26
	lfs 0,v_forward@l(29)
	la 29,v_forward@l(29)
	fmuls 0,0,31
	fmuls 0,0,1
	fsubs 13,13,0
	stfs 13,376(31)
	bl framerate
	lfs 0,4(29)
	lfs 13,380(31)
	fmuls 0,0,31
	fmuls 0,0,1
	fsubs 13,13,0
	stfs 13,380(31)
.L632:
	lha 11,10(26)
	cmpwi 0,11,0
	bc 12,1,.L707
	bc 4,0,.L635
.L707:
	lis 0,0x6666
	srawi 9,11,31
	ori 0,0,26215
	mulhw 0,11,0
	srawi 0,0,1
	subf 0,9,0
	sth 0,10(26)
.L635:
	lha 0,12(26)
	cmpwi 0,0,9
	bc 4,1,.L637
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L637
	lis 6,.LC249@ha
	lfs 0,384(31)
	la 6,.LC249@l(6)
	lfs 13,0(6)
	fadds 0,0,13
	stfs 0,384(31)
.L637:
	lfs 0,380(31)
	lfs 1,376(31)
	fmuls 0,0,0
	fmadds 1,1,1,0
	bl sqrt
	lis 6,.LC252@ha
	frsp 1,1
	la 6,.LC252@l(6)
	lfs 12,0(6)
.L706:
	fcmpu 0,1,12
	bc 4,1,.L622
	fdivs 12,12,1
	lfs 13,376(31)
	lfs 0,380(31)
	fmuls 13,13,12
	fmuls 0,0,12
	stfs 13,376(31)
	stfs 0,380(31)
	b .L622
.L630:
	lwz 0,1808(10)
	cmpwi 0,0,5
	bc 12,2,.L641
	andi. 8,9,8192
	bc 12,2,.L640
.L641:
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L640
	mr 3,31
	bl MV
	lha 0,12(26)
	cmpwi 0,0,9
	bc 4,1,.L642
	mr 3,26
	bl framerate
	lis 9,.LC225@ha
	lfs 13,384(31)
	lis 6,.LC249@ha
	lfs 0,.LC225@l(9)
	la 6,.LC249@l(6)
	lfs 12,0(6)
	fmadds 1,1,0,13
	fcmpu 0,1,12
	stfs 1,384(31)
	bc 4,1,.L643
	stfs 12,384(31)
.L643:
	li 0,0
	lis 11,level+4@ha
	lwz 10,84(31)
	stw 0,552(31)
	lis 9,.LC207@ha
	lfs 0,level+4@l(11)
	lfd 13,.LC207@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,1832(10)
.L642:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 4,2,.L644
	lha 0,8(26)
	cmpwi 0,0,0
	bc 4,1,.L645
	lis 8,.LC253@ha
	mr 3,26
	la 8,.LC253@l(8)
	lfs 31,0(8)
	bl framerate
	lis 29,v_forward@ha
	lfs 13,376(31)
	mr 3,26
	lfs 0,v_forward@l(29)
	la 29,v_forward@l(29)
	fmuls 0,0,31
	fmadds 0,0,1,13
	stfs 0,376(31)
	bl framerate
	lfs 0,4(29)
	lfs 13,380(31)
	fmuls 0,0,31
	fmadds 0,0,1,13
	stfs 0,380(31)
	b .L646
.L645:
	bc 4,0,.L646
	lis 6,.LC253@ha
	mr 3,26
	la 6,.LC253@l(6)
	lfs 31,0(6)
	bl framerate
	lis 29,v_forward@ha
	lfs 13,376(31)
	mr 3,26
	lfs 0,v_forward@l(29)
	la 29,v_forward@l(29)
	fmuls 0,0,31
	fmuls 0,0,1
	fsubs 13,13,0
	stfs 13,376(31)
	bl framerate
	lfs 0,4(29)
	lfs 13,380(31)
	fmuls 0,0,31
	fmuls 0,0,1
	fsubs 13,13,0
	stfs 13,380(31)
.L646:
	lha 0,10(26)
	cmpwi 0,0,0
	bc 4,1,.L648
	lis 6,.LC253@ha
	mr 3,26
	la 6,.LC253@l(6)
	lfs 31,0(6)
	bl framerate
	lis 29,v_right@ha
	lfs 13,376(31)
	mr 3,26
	lfs 0,v_right@l(29)
	la 29,v_right@l(29)
	fmuls 0,0,31
	fmadds 0,0,1,13
	stfs 0,376(31)
	bl framerate
	lfs 0,4(29)
	lfs 13,380(31)
	fmuls 0,0,31
	fmadds 0,0,1,13
	stfs 0,380(31)
	b .L644
.L648:
	bc 4,0,.L644
	lis 6,.LC253@ha
	mr 3,26
	la 6,.LC253@l(6)
	lfs 31,0(6)
	bl framerate
	lis 29,v_right@ha
	lfs 13,376(31)
	mr 3,26
	lfs 0,v_right@l(29)
	la 29,v_right@l(29)
	fmuls 0,0,31
	fmuls 0,0,1
	fsubs 13,13,0
	stfs 13,376(31)
	bl framerate
	lfs 0,4(29)
	lfs 13,380(31)
	fmuls 0,0,31
	fmuls 0,0,1
	fsubs 13,13,0
	stfs 13,380(31)
.L644:
	lfs 0,380(31)
	lfs 13,376(31)
	lfs 1,384(31)
	fmuls 0,0,0
	fmadds 13,13,13,0
	fmadds 1,1,1,13
	bl sqrt
	lis 6,.LC249@ha
	frsp 1,1
	la 6,.LC249@l(6)
	lfs 13,0(6)
	fcmpu 0,1,13
	bc 4,1,.L622
	fdivs 13,13,1
	lfs 12,376(31)
	lfs 11,380(31)
	lfs 0,384(31)
	fmuls 12,12,13
	fmuls 0,0,13
	fmuls 11,11,13
	stfs 12,376(31)
	stfs 0,384(31)
	stfs 11,380(31)
	b .L622
.L640:
	lwz 0,1808(10)
	cmpwi 0,0,8
	bc 4,2,.L622
	andi. 30,9,8192
	bc 4,2,.L622
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 4,2,.L654
	mr 3,26
	bl framerate
	lis 6,.LC251@ha
	lis 9,v_up+8@ha
	lfs 13,384(31)
	la 6,.LC251@l(6)
	lfs 0,v_up+8@l(9)
	lfs 12,0(6)
	fmuls 0,0,12
	fmuls 0,0,1
	fsubs 13,13,0
	stfs 13,384(31)
.L654:
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 12,2,.L622
	sth 30,12(26)
.L622:
	li 9,3
	lis 8,.LC242@ha
	mtctr 9
	la 8,.LC242@l(8)
	addi 24,31,4
	addi 30,31,376
	addi 23,1,20
	lfs 11,0(8)
	addi 22,1,26
	mr 4,23
	mr 6,24
	mr 5,22
	mr 7,30
	addi 29,25,3524
	addi 28,1,44
	li 8,0
	li 10,0
.L695:
	lfsx 0,8,6
	mr 11,9
	fmuls 0,0,11
	fctiwz 13,0
	stfd 13,304(1)
	lwz 9,308(1)
	sthx 9,10,4
	lfsx 0,8,7
	addi 8,8,4
	fmuls 0,0,11
	fctiwz 12,0
	stfd 12,304(1)
	lwz 11,308(1)
	sthx 11,10,5
	addi 10,10,2
	bdnz .L695
	mr 3,29
	addi 4,1,16
	li 5,28
	bl memcmp
	cmpwi 0,3,0
	bc 12,2,.L661
	li 0,1
	stw 0,60(1)
.L661:
	lis 9,gi@ha
	lwz 7,0(26)
	addi 3,1,16
	la 9,gi@l(9)
	lwz 6,4(26)
	lis 11,PM_trace@ha
	lwz 5,84(9)
	la 11,PM_trace@l(11)
	lwz 8,8(26)
	lwz 0,12(26)
	mtlr 5
	stw 7,44(1)
	lwz 10,52(9)
	stw 0,12(28)
	stw 6,4(28)
	stw 8,8(28)
	stw 11,248(1)
	stw 10,252(1)
	blrl
	lis 9,.LC254@ha
	lwz 11,16(1)
	lis 8,.LC235@ha
	la 9,.LC254@l(9)
	lwz 10,4(27)
	la 8,.LC235@l(8)
	lfd 13,0(9)
	mr 28,23
	mr 3,22
	lwz 0,8(27)
	mr 4,24
	lis 6,0x4330
	lwz 9,12(27)
	mr 5,30
	li 7,0
	stw 11,0(25)
	li 11,3
	stw 10,4(25)
	stw 0,8(25)
	mtctr 11
	stw 9,12(25)
	lwz 0,16(27)
	lwz 9,20(27)
	lwz 11,24(27)
	stw 0,16(25)
	stw 9,20(25)
	stw 11,24(25)
	lwz 0,16(1)
	lwz 9,4(27)
	lwz 11,8(27)
	lwz 10,12(27)
	stw 0,3524(25)
	stw 9,4(29)
	stw 11,8(29)
	stw 10,12(29)
	lwz 0,24(27)
	lwz 9,16(27)
	lwz 11,20(27)
	lfd 12,0(8)
	li 8,0
	stw 0,24(29)
	stw 9,16(29)
	stw 11,20(29)
.L694:
	lhax 0,7,28
	mr 11,9
	xoris 0,0,0x8000
	stw 0,308(1)
	stw 6,304(1)
	lfd 0,304(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfsx 0,8,4
	lhax 0,7,3
	addi 7,7,2
	xoris 0,0,0x8000
	stw 0,308(1)
	stw 6,304(1)
	lfd 0,304(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfsx 0,8,5
	addi 8,8,4
	bdnz .L694
	lfs 0,224(1)
	lis 8,0x4330
	lis 6,.LC235@ha
	lfs 13,228(1)
	la 6,.LC235@l(6)
	lis 7,.LC226@ha
	lfs 8,212(1)
	mr 10,9
	lfs 9,216(1)
	lfs 10,220(1)
	lfs 11,232(1)
	stfs 0,200(31)
	stfs 13,204(31)
	stfs 8,188(31)
	stfs 9,192(31)
	stfs 10,196(31)
	stfs 11,208(31)
	lha 0,2(26)
	lfd 12,0(6)
	xoris 0,0,0x8000
	lfd 13,.LC226@l(7)
	stw 0,308(1)
	stw 8,304(1)
	lfd 0,304(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3500(25)
	lha 0,4(26)
	xoris 0,0,0x8000
	stw 0,308(1)
	stw 8,304(1)
	lfd 0,304(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3504(25)
	lha 0,6(26)
	xoris 0,0,0x8000
	stw 0,308(1)
	stw 8,304(1)
	lfd 0,304(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3508(25)
	lwz 11,264(31)
	andi. 8,11,8192
	bc 4,2,.L667
	lwz 3,84(31)
	lwz 0,1808(3)
	cmpwi 0,0,-4
	bc 12,2,.L667
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L667
	lwz 0,236(1)
	cmpwi 0,0,0
	bc 4,2,.L667
	lha 0,56(1)
	cmpwi 0,0,9
	bc 4,1,.L667
	lwz 0,244(1)
	cmpwi 0,0,0
	bc 4,2,.L667
	lwz 0,1812(3)
	subfic 9,0,-8
	subfic 10,9,0
	adde 9,10,9
	xori 0,0,16
	subfic 6,0,0
	adde 0,6,0
	or. 8,0,9
	bc 12,2,.L668
	andis. 9,11,4096
	bc 4,2,.L668
	lis 29,v_forward@ha
	lis 28,v_up@ha
	lis 5,v_right@ha
	la 6,v_up@l(28)
	addi 3,3,3692
	la 5,v_right@l(5)
	la 4,v_forward@l(29)
	bl AngleVectors
	lis 9,.LC227@ha
	li 0,0
	lfs 1,.LC227@l(9)
	la 4,v_forward@l(29)
	mr 3,30
	mr 5,30
	stw 0,376(31)
	stw 0,384(31)
	stw 0,380(31)
	bl VectorMA
	lis 6,.LC255@ha
	mr 3,30
	la 6,.LC255@l(6)
	la 4,v_up@l(28)
	lfs 1,0(6)
	mr 5,3
	bl VectorMA
.L668:
	lwz 9,84(31)
	lwz 0,1816(9)
	xori 10,0,11
	xori 0,0,3
	addic 8,10,-1
	subfe 9,8,10
	addic 6,0,-1
	subfe 11,6,0
	and. 10,11,9
	bc 12,2,.L667
	lis 29,gi@ha
	lis 3,.LC228@ha
	la 29,gi@l(29)
	la 3,.LC228@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 6,.LC232@ha
	lis 8,.LC232@ha
	lis 9,.LC230@ha
	mr 5,3
	la 6,.LC232@l(6)
	la 8,.LC232@l(8)
	mtlr 0
	la 9,.LC230@l(9)
	li 4,2
	lfs 1,0(6)
	mr 3,31
	lfs 2,0(8)
	lfs 3,0(9)
	blrl
	mr 4,24
	mr 3,31
	li 5,0
	bl PlayerNoise
.L667:
	lfs 0,208(1)
	lwz 10,236(1)
	lwz 0,244(1)
	lwz 11,240(1)
	cmpwi 0,10,0
	stw 0,612(31)
	stw 11,608(31)
	fctiwz 13,0
	stw 10,552(31)
	stfd 13,304(1)
	lwz 9,308(1)
	stw 9,508(31)
	bc 12,2,.L670
	lwz 0,92(10)
	stw 0,556(31)
.L670:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L671
	lfs 0,3620(25)
	lis 0,0x4220
	lis 9,0xc170
	stw 0,36(25)
	stw 9,28(25)
	stfs 0,32(25)
	b .L672
.L671:
	lfs 0,196(1)
	stfs 0,3692(25)
	lfs 13,200(1)
	stfs 13,3696(25)
	lfs 0,204(1)
	stfs 0,3700(25)
	lfs 13,196(1)
	stfs 13,28(25)
	lfs 0,200(1)
	stfs 0,32(25)
	lfs 13,204(1)
	stfs 13,36(25)
.L672:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L673
	lwz 0,264(31)
	andi. 6,0,8192
	bc 4,2,.L673
	mr 3,31
	bl G_TouchTriggers
.L673:
	lwz 0,64(1)
	li 10,0
	cmpw 0,10,0
	bc 4,0,.L675
	lis 9,gi@ha
	addi 27,1,68
	la 24,gi@l(9)
	lis 23,0x4330
.L677:
	li 11,0
	slwi 0,10,2
	cmpw 0,11,10
	lwzx 29,27,0
	addi 30,10,1
	bc 4,0,.L679
	lwz 0,0(27)
	cmpw 0,0,29
	bc 12,2,.L679
	mr 9,27
.L680:
	addi 11,11,1
	cmpw 0,11,10
	bc 4,0,.L679
	lwzu 0,4(9)
	cmpw 0,0,29
	bc 4,2,.L680
.L679:
	cmpw 0,11,10
	bc 4,2,.L676
	lwz 0,264(31)
	andi. 6,0,8192
	bc 4,2,.L686
	lwz 0,512(29)
	cmpwi 0,0,0
	bc 12,2,.L685
	lwz 9,84(31)
	lwz 0,1808(9)
	cmpwi 0,0,1
	bc 4,2,.L685
	la 28,level@l(21)
	lfs 13,1832(9)
	lfs 0,4(28)
	fcmpu 0,13,0
	bc 4,0,.L685
	mr 3,31
	mr 4,29
	bl CTFSameTeam
	cmpwi 0,3,0
	bc 4,2,.L685
	lis 6,.LC244@ha
	mr 4,29
	la 6,.LC244@l(6)
	mr 3,31
	lfs 1,0(6)
	bl boot
	lwz 9,36(24)
	lis 3,.LC229@ha
	la 3,.LC229@l(3)
	mtlr 9
	blrl
	lwz 11,16(24)
	lis 6,.LC232@ha
	lis 8,.LC232@ha
	lis 9,.LC230@ha
	la 6,.LC232@l(6)
	la 9,.LC230@l(9)
	mr 5,3
	lfs 1,0(6)
	mtlr 11
	la 8,.LC232@l(8)
	lfs 3,0(9)
	li 4,2
	mr 3,31
	lfs 2,0(8)
	blrl
	lis 6,.LC232@ha
	lfs 0,4(28)
	la 6,.LC232@l(6)
	lwz 9,84(31)
	lfs 13,0(6)
	fadds 0,0,13
	stfs 0,1832(9)
.L685:
	lwz 0,264(31)
	andi. 8,0,8192
	bc 4,2,.L686
	lwz 0,512(29)
	cmpwi 0,0,0
	bc 12,2,.L686
	lwz 11,84(31)
	lwz 0,1808(11)
	cmpwi 0,0,-3
	bc 4,2,.L686
	lwz 0,level@l(21)
	lis 10,.LC235@ha
	la 10,.LC235@l(10)
	lfs 12,3768(11)
	xoris 0,0,0x8000
	lfd 13,0(10)
	stw 0,308(1)
	stw 23,304(1)
	lfd 0,304(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L686
	mr 3,31
	mr 4,29
	bl CTFSameTeam
	cmpwi 0,3,0
	bc 4,2,.L686
	lis 6,.LC256@ha
	mr 3,31
	la 6,.LC256@l(6)
	mr 4,29
	lfs 1,0(6)
	bl boot
.L686:
	lwz 0,444(29)
	cmpwi 0,0,0
	bc 12,2,.L676
	mr 3,29
	mr 4,31
	mtlr 0
	li 5,0
	li 6,0
	blrl
.L676:
	lwz 0,64(1)
	mr 10,30
	cmpw 0,10,0
	bc 12,0,.L677
.L675:
	lwz 0,3572(25)
	lwz 11,3580(25)
	stw 0,3576(25)
	lbz 9,1(26)
	andc 0,9,0
	stw 9,3572(25)
	or 11,11,0
	stw 11,3580(25)
	lwz 0,264(31)
	lbz 9,15(26)
	andi. 6,0,8192
	stw 9,640(31)
	bc 4,2,.L482
	lwz 0,3580(25)
	andi. 8,0,1
	bc 4,2,.L690
	lis 9,level+4@ha
	lfs 13,908(31)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,1,.L482
.L690:
	lwz 11,84(31)
	lwz 0,1808(11)
	cmpwi 0,0,10
	bc 4,2,.L691
	lis 10,.LC233@ha
	lis 9,level+4@ha
	la 10,.LC233@l(10)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,1832(11)
.L691:
	lwz 0,3584(25)
	cmpwi 0,0,0
	bc 4,2,.L482
	li 0,1
	mr 3,31
	stw 0,3584(25)
	bl Think_Weapon
.L482:
	lwz 0,372(1)
	mtlr 0
	lmw 21,316(1)
	lfd 31,360(1)
	la 1,368(1)
	blr
.Lfe16:
	.size	 ClientThink,.Lfe16-ClientThink
	.section	".rodata"
	.align 2
.LC257:
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
	lis 11,.LC257@ha
	lis 9,level+200@ha
	la 11,.LC257@l(11)
	lfs 0,level+200@l(9)
	mr 31,3
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L708
	lwz 30,84(31)
	lwz 0,3584(30)
	cmpwi 0,0,0
	bc 4,2,.L710
	bl Think_Weapon
	b .L711
.L710:
	li 0,0
	stw 0,3584(30)
.L711:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L712
	lis 9,level@ha
	lfs 13,3800(30)
	la 29,level@l(9)
	lfs 0,4(29)
	fcmpu 0,0,13
	bc 4,1,.L708
	lis 9,.LC257@ha
	lis 11,deathmatch@ha
	lwz 10,3580(30)
	la 9,.LC257@l(9)
	lfs 12,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 7,0,12
	mfcr 0
	rlwinm 0,0,31,1
	neg 0,0
	ori 0,0,1
	and. 11,10,0
	bc 4,2,.L717
	bc 12,30,.L708
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,1024
	bc 12,2,.L708
.L717:
	bc 4,30,.L718
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L719
.L718:
	mr 3,31
	bl CopyToBodyQue
	mr 3,31
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
	stfs 0,3800(11)
	b .L721
.L719:
	lis 9,gi+168@ha
	lis 3,.LC145@ha
	lwz 0,gi+168@l(9)
	la 3,.LC145@l(3)
	mtlr 0
	blrl
	b .L723
.L712:
	lis 9,.LC257@ha
	lis 11,deathmatch@ha
	la 9,.LC257@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L721
	bl PlayerTrail_LastSpot
	mr 4,3
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L721
	addi 3,31,28
	bl PlayerTrail_Add
.L723:
.L721:
	li 0,0
	stw 0,3580(30)
.L708:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe17:
	.size	 ClientBeginServerFrame,.Lfe17-ClientBeginServerFrame
	.comm	v_forward,12,4
	.comm	v_right,12,4
	.comm	v_up,12,4
	.comm	invis_index,4,4
	.comm	cripple_index,4,4
	.comm	robot_index,4,4
	.comm	sun_index,4,4
	.section	".rodata"
	.align 2
.LC258:
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
	lis 11,.LC258@ha
	lis 9,deathmatch@ha
	la 11,.LC258@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L336
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L335
.L336:
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
	stfs 0,3800(11)
	b .L334
.L335:
	lis 9,gi+168@ha
	lis 3,.LC145@ha
	lwz 0,gi+168@l(9)
	la 3,.LC145@l(3)
	mtlr 0
	blrl
.L334:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe18:
	.size	 respawn,.Lfe18-respawn
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
	addi 28,29,1840
	li 5,1684
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,28
	lwz 0,level@l(9)
	addi 4,29,188
	li 5,1652
	stw 0,3492(29)
	crxor 6,6,6
	bl memcpy
	li 0,1
	stw 0,3520(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
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
	lis 11,.LC144@ha
	stw 0,level+296@l(9)
	li 31,8
	la 30,.LC144@l(11)
.L324:
	bl G_Spawn
	addic. 31,31,-1
	stw 30,280(3)
	bc 4,2,.L324
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
	.section	".rodata"
	.align 2
.LC259:
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
	lis 9,.LC259@ha
	lwz 5,coop@l(11)
	li 7,0
	la 9,.LC259@l(9)
	addi 10,10,936
	lfs 13,0(9)
.L212:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L211
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
	rlwinm 0,0,0,19,19
	stw 0,732(9)
	lfs 0,20(5)
	fcmpu 0,0,13
	bc 12,2,.L211
	lwz 9,84(10)
	lwz 11,1028(8)
	lwz 0,3496(9)
	add 11,7,11
	stw 0,1800(11)
.L211:
	lwz 0,1544(3)
	addi 6,6,1
	addi 7,7,3804
	addi 10,10,936
	cmpw 0,6,0
	bc 12,0,.L212
	blr
.Lfe22:
	.size	 SaveClientData,.Lfe22-SaveClientData
	.section	".rodata"
	.align 2
.LC260:
	.long 0x0
	.section	".text"
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
	bc 12,2,.L217
	lwz 0,264(3)
	ori 0,0,4096
	stw 0,264(3)
.L217:
	lis 9,.LC260@ha
	lis 11,coop@ha
	la 9,.LC260@l(9)
	lfs 13,0(9)
	lwz 9,coop@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bclr 12,2
	lwz 9,84(3)
	lwz 0,1800(9)
	stw 0,3496(9)
	blr
.Lfe23:
	.size	 FetchClientEntData,.Lfe23-FetchClientEntData
	.section	".rodata"
	.align 2
.LC261:
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
	lis 9,.LC261@ha
	mr 30,3
	la 9,.LC261@l(9)
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
	bl stricmp
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
.Lfe24:
	.size	 SP_FixCoopSpots,.Lfe24-SP_FixCoopSpots
	.section	".rodata"
	.align 3
.LC262:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC263:
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
	lis 11,.LC263@ha
	lis 9,coop@ha
	la 11,.LC263@l(11)
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
	lis 11,.LC262@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC262@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L18:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe25:
	.size	 SP_info_player_start,.Lfe25-SP_info_player_start
	.section	".rodata"
	.align 2
.LC264:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_player_deathmatch
	.type	 SP_info_player_deathmatch,@function
SP_info_player_deathmatch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC264@ha
	lis 9,deathmatch@ha
	la 11,.LC264@l(11)
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
.Lfe26:
	.size	 SP_info_player_deathmatch,.Lfe26-SP_info_player_deathmatch
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
	b .L724
.L30:
	li 3,0
.L724:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe28:
	.size	 IsFemale,.Lfe28-IsFemale
	.section	".rodata"
	.align 3
.LC265:
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
	bc 12,2,.L163
	lis 9,g_edicts@ha
	xor 11,5,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,5,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L163
	lfs 11,12(5)
	lfs 13,4(5)
	lfs 10,4(31)
	lfs 0,8(5)
	b .L725
.L163:
	cmpwi 0,4,0
	bc 12,2,.L165
	lis 9,g_edicts@ha
	xor 11,4,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,4,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L165
	lfs 11,12(4)
	lfs 13,4(4)
	lfs 10,4(31)
	lfs 0,8(4)
.L725:
	lfs 9,8(31)
	lfs 12,12(31)
	fsubs 13,13,10
	fsubs 0,0,9
	fsubs 11,11,12
	stfs 13,8(1)
	stfs 0,12(1)
	stfs 11,16(1)
	b .L164
.L165:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3620(9)
	b .L162
.L164:
	lfs 1,12(1)
	lfs 2,8(1)
	bl atan2
	lis 9,.LC265@ha
	lwz 11,84(31)
	lfd 0,.LC265@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,3620(11)
.L162:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 LookAtKiller,.Lfe29-LookAtKiller
	.section	".rodata"
	.align 2
.LC266:
	.long 0x4b18967f
	.align 2
.LC267:
	.long 0x3f800000
	.align 3
.LC268:
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
	lis 11,.LC267@ha
	lwz 10,maxclients@l(9)
	la 11,.LC267@l(11)
	mr 31,3
	lfs 13,0(11)
	li 29,1
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC266@ha
	lfs 31,.LC266@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L221
	lis 9,.LC268@ha
	lis 27,g_edicts@ha
	la 9,.LC268@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,936
.L223:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L222
	lwz 0,84(11)
	cmpwi 0,0,0
	bc 4,2,.L225
	lwz 0,184(11)
	andi. 9,0,4
	bc 12,2,.L222
.L225:
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L222
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
	bc 4,0,.L222
	fmr 31,1
.L222:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,936
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L223
.L221:
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
	bc 4,2,.L275
	bl SelectRandomDeathmatchSpawnPoint
	b .L727
.L275:
	bl SelectFarthestDeathmatchSpawnPoint
.L727:
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
	lis 9,0x7a7b
	lwz 10,game+1028@l(11)
	ori 9,9,18951
	li 30,0
	li 3,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,2
	bc 12,2,.L728
.L281:
	lis 5,.LC2@ha
	mr 3,30
	la 5,.LC2@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L282
	li 3,0
	b .L728
.L282:
	lwz 4,300(30)
	cmpwi 0,4,0
	bc 4,2,.L283
	lis 9,.LC22@ha
	la 4,.LC22@l(9)
.L283:
	lis 3,game+1032@ha
	la 3,game+1032@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L281
	addic. 31,31,-1
	bc 4,2,.L281
	mr 3,30
.L728:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe32:
	.size	 SelectCoopSpawnPoint,.Lfe32-SelectCoopSpawnPoint
	.section	".rodata"
	.align 2
.LC269:
	.long 0x3f800000
	.align 2
.LC270:
	.long 0x0
	.align 2
.LC271:
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
	bc 4,0,.L327
	lis 29,gi@ha
	lis 3,.LC123@ha
	la 29,gi@l(29)
	la 3,.LC123@l(3)
	lwz 9,36(29)
	lis 27,.LC124@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC269@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC269@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC269@ha
	la 9,.LC269@l(9)
	lfs 2,0(9)
	lis 9,.LC270@ha
	la 9,.LC270@l(9)
	lfs 3,0(9)
	blrl
.L331:
	mr 3,31
	la 4,.LC124@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L331
	lis 9,.LC271@ha
	lfs 0,12(31)
	mr 4,28
	la 9,.LC271@l(9)
	mr 3,31
	lfs 13,0(9)
	fsubs 0,0,13
	stfs 0,12(31)
	bl ThrowClientHead
	stw 30,512(31)
.L327:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe33:
	.size	 body_die,.Lfe33-body_die
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
	bc 4,1,.L461
	lis 11,gi+48@ha
	lis 9,0x201
	lwz 0,gi+48@l(11)
	ori 9,9,3
	mtlr 0
	blrl
	b .L460
.L461:
	lis 11,gi+48@ha
	lis 9,0x1
	lwz 0,gi+48@l(11)
	mr 3,31
	ori 9,9,3
	mtlr 0
	blrl
.L460:
	mr 3,31
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe34:
	.size	 PM_trace,.Lfe34-PM_trace
	.align 2
	.globl CheckBlock
	.type	 CheckBlock,@function
CheckBlock:
	li 11,0
	li 9,0
	cmpw 0,11,4
	bc 4,0,.L465
.L467:
	lbzx 0,3,9
	addi 9,9,1
	cmpw 0,9,4
	add 11,11,0
	bc 12,0,.L467
.L465:
	mr 3,11
	blr
.Lfe35:
	.size	 CheckBlock,.Lfe35-CheckBlock
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
.L730:
	lbzx 0,3,9
	addi 9,9,1
	add 5,5,0
	bdnz .L730
	li 0,16
	lbz 4,42(3)
	li 6,0
	mtctr 0
	addi 3,3,28
	li 9,0
.L729:
	lbzx 0,3,9
	addi 9,9,1
	add 6,6,0
	bdnz .L729
	lis 3,.LC196@ha
	la 3,.LC196@l(3)
	crxor 6,6,6
	bl Com_Printf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe36:
	.size	 PrintPmove,.Lfe36-PrintPmove
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
.Lfe37:
	.size	 SP_CreateCoopSpots,.Lfe37-SP_CreateCoopSpots
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
