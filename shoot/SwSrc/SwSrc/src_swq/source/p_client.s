	.file	"p_client.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC1:
	.string	"info_player_start"
	.align 2
.LC2:
	.string	"security"
	.align 2
.LC3:
	.string	"info_player_coop"
	.align 2
.LC4:
	.string	"jail3"
	.align 2
.LC6:
	.string	"jail2"
	.align 2
.LC7:
	.string	"jail4"
	.align 2
.LC8:
	.string	"mine1"
	.align 2
.LC9:
	.string	"mine2"
	.align 2
.LC10:
	.string	"mine3"
	.align 2
.LC11:
	.string	"mine4"
	.align 2
.LC12:
	.string	"lab"
	.align 2
.LC13:
	.string	"boss1"
	.align 2
.LC14:
	.string	"fact3"
	.align 2
.LC15:
	.string	"biggun"
	.align 2
.LC16:
	.string	"space"
	.align 2
.LC17:
	.string	"command"
	.align 2
.LC18:
	.string	"power2"
	.align 2
.LC19:
	.string	"strike"
	.align 3
.LC20:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC21:
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
	lis 11,.LC21@ha
	lis 9,coop@ha
	la 11,.LC21@l(11)
	mr 30,3
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L25
	bl G_FreeEdict
	b .L24
.L25:
	lis 31,level+72@ha
	lis 4,.LC6@ha
	la 4,.LC6@l(4)
	la 3,level+72@l(31)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC7@ha
	la 3,level+72@l(31)
	la 4,.LC7@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC8@ha
	la 3,level+72@l(31)
	la 4,.LC8@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC9@ha
	la 3,level+72@l(31)
	la 4,.LC9@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC10@ha
	la 3,level+72@l(31)
	la 4,.LC10@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC11@ha
	la 3,level+72@l(31)
	la 4,.LC11@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC12@ha
	la 3,level+72@l(31)
	la 4,.LC12@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC13@ha
	la 3,level+72@l(31)
	la 4,.LC13@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC14@ha
	la 3,level+72@l(31)
	la 4,.LC14@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC15@ha
	la 3,level+72@l(31)
	la 4,.LC15@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC16@ha
	la 3,level+72@l(31)
	la 4,.LC16@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC17@ha
	la 3,level+72@l(31)
	la 4,.LC17@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC18@ha
	la 3,level+72@l(31)
	la 4,.LC18@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lis 4,.LC19@ha
	la 3,level+72@l(31)
	la 4,.LC19@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L24
.L27:
	lis 9,SP_FixCoopSpots@ha
	lis 10,level+4@ha
	la 9,SP_FixCoopSpots@l(9)
	lis 11,.LC20@ha
	stw 9,436(30)
	lfs 0,level+4@l(10)
	lfd 13,.LC20@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(30)
.L24:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe1:
	.size	 SP_info_player_coop,.Lfe1-SP_info_player_coop
	.section	".rodata"
	.align 2
.LC22:
	.string	"gender"
	.align 2
.LC23:
	.string	""
	.align 2
.LC25:
	.string	"suicides"
	.align 2
.LC26:
	.string	"knocked himself off"
	.align 2
.LC27:
	.string	"did it on purpose. Honest."
	.align 2
.LC28:
	.string	"is having an out of body experience"
	.align 2
.LC29:
	.string	"spontaniously self combusts"
	.align 2
.LC30:
	.string	"cratered"
	.align 2
.LC31:
	.string	"can't feel his legs"
	.align 2
.LC32:
	.string	"is looking at things from a new perspective"
	.align 2
.LC33:
	.string	"is 2 inches tall"
	.align 2
.LC34:
	.string	"fell from grace"
	.align 2
.LC35:
	.string	"was squished"
	.align 2
.LC36:
	.string	"got thin quick"
	.align 2
.LC37:
	.string	"is showing agoraphobic tendancies"
	.align 2
.LC38:
	.string	"is in a jam"
	.align 2
.LC39:
	.string	"didn't escape from the garbage compressor"
	.align 2
.LC40:
	.string	"sank like a rock"
	.align 2
.LC41:
	.string	"sank like an Ewok"
	.align 2
.LC42:
	.string	"ate just before bathing"
	.align 2
.LC43:
	.string	"is keeping Ackbar company"
	.align 2
.LC44:
	.string	"is experiencing flow"
	.align 2
.LC45:
	.string	"melted"
	.align 2
.LC46:
	.string	"learned not to swallow acid"
	.align 2
.LC47:
	.string	"could be poured into a glass"
	.align 2
.LC48:
	.string	"finished chemistry 101"
	.align 2
.LC49:
	.string	"learned the dangers of chemical warfare"
	.align 2
.LC50:
	.string	"did a backflip into the lava"
	.align 2
.LC51:
	.string	"found the downside to geothermal energy"
	.align 2
.LC52:
	.string	"is burning with desire"
	.align 2
.LC53:
	.string	"learned not to play with fire"
	.align 2
.LC54:
	.string	"went AGWAR"
	.align 2
.LC55:
	.string	"blew up"
	.align 2
.LC56:
	.string	"is decorating the walls"
	.align 2
.LC57:
	.string	"is spreading himself thin"
	.align 2
.LC58:
	.string	"went out with a bang"
	.align 2
.LC59:
	.string	"got his stupid self blown up"
	.align 2
.LC60:
	.string	"found a way out"
	.align 2
.LC61:
	.string	"chickened out"
	.align 2
.LC62:
	.string	"saw his boss coming"
	.align 2
.LC63:
	.string	"got scared"
	.align 2
.LC64:
	.string	"is lost to us"
	.align 2
.LC65:
	.string	"saw the light"
	.align 2
.LC66:
	.string	"was always a bright student"
	.align 2
.LC67:
	.string	"learned not to stare at bright lights"
	.align 2
.LC68:
	.string	"has a few photons to spare"
	.align 2
.LC69:
	.string	"stopped playing with his laser pen"
	.align 2
.LC70:
	.string	"got blasted"
	.align 2
.LC71:
	.string	"chews plasma"
	.align 2
.LC72:
	.string	"got blasta mastad"
	.align 2
.LC73:
	.string	"was in the wrong place"
	.align 2
.LC74:
	.string	"got a booboo"
	.align 2
.LC75:
	.string	"wants a refund"
	.align 2
.LC76:
	.string	"was pre-emptivly struck"
	.align 2
.LC77:
	.string	"was hit by a low yield nuclear chicken"
	.align 2
.LC78:
	.string	"tried to put the pin back in"
	.align 2
.LC79:
	.string	"tripped on it's own thermal detonator"
	.align 2
.LC80:
	.string	"made itself dissapear"
	.align 2
.LC81:
	.string	"tried bluffing Jabba for a little too long"
	.align 2
.LC82:
	.string	"wanted the thermal detonator back"
	.align 2
.LC83:
	.string	"found out that what it picked up was NOT a baseball"
	.align 2
.LC84:
	.string	"tripped on her own thermal detonator"
	.align 2
.LC85:
	.string	"made herself dissapear"
	.align 2
.LC86:
	.string	"found out the hard way that what she picked up was NOT a remote"
	.align 2
.LC87:
	.string	"tripped on his own thermal detonator"
	.align 2
.LC88:
	.string	"made himself dissapear"
	.align 2
.LC89:
	.string	"cfound out the hard way that what he picked up was NOT a remote"
	.align 2
.LC90:
	.string	"blew itself up"
	.align 2
.LC91:
	.string	"aimed at it's feet"
	.align 2
.LC92:
	.string	"held the missile tube backwards"
	.align 2
.LC93:
	.string	"self combusted"
	.align 2
.LC94:
	.string	"wanted it's rocket back"
	.align 2
.LC95:
	.string	"blew herself up"
	.align 2
.LC96:
	.string	"aimed at her feet"
	.align 2
.LC97:
	.string	"wanted her rocket back"
	.align 2
.LC98:
	.string	"blew himself up"
	.align 2
.LC99:
	.string	"aimed at his feet"
	.align 2
.LC100:
	.string	"wanted his rocket back"
	.align 2
.LC101:
	.string	"killed itself"
	.align 2
.LC102:
	.string	"killed herself"
	.align 2
.LC103:
	.string	"killed himself"
	.align 2
.LC104:
	.string	"%s %s.\n"
	.align 2
.LC105:
	.string	"was sliced in two by"
	.align 2
.LC106:
	.string	"was reminded by"
	.align 2
.LC107:
	.string	" of her wedding night"
	.align 2
.LC108:
	.string	"learned"
	.align 2
.LC109:
	.string	"'s piercing technique"
	.align 2
.LC110:
	.string	"is having an out of limbs experience,"
	.align 2
.LC111:
	.string	" is helping"
	.align 2
.LC112:
	.string	"gave"
	.align 2
.LC113:
	.string	" a hand, among other things"
	.align 2
.LC114:
	.string	"failed"
	.align 2
.LC115:
	.string	"'s fencing 101"
	.align 2
.LC116:
	.string	"tried to grab "
	.align 2
.LC117:
	.string	"'s shiny stick"
	.align 2
.LC118:
	.string	"was taught by"
	.align 2
.LC119:
	.string	" not to bend after the soap"
	.align 2
.LC120:
	.string	"gave "
	.align 2
.LC121:
	.string	"got blasted by"
	.align 2
.LC122:
	.string	"chews"
	.align 2
.LC123:
	.string	"'s plasma"
	.align 2
.LC124:
	.string	"got blasta mastad by"
	.align 2
.LC125:
	.string	"was humiliated by"
	.align 2
.LC126:
	.string	"was blistered by"
	.align 2
.LC127:
	.string	"'s blaster"
	.align 2
.LC128:
	.string	"was actually hit by"
	.align 2
.LC129:
	.string	"'s trooper rifle"
	.align 2
.LC130:
	.string	"is riddled with"
	.align 2
.LC131:
	.string	"'s holes"
	.align 2
.LC132:
	.string	"re-evaluates"
	.align 2
.LC133:
	.string	"'s shooting skills"
	.align 2
.LC134:
	.string	"wishes"
	.align 2
.LC135:
	.string	" wouldn't shoot so fast"
	.align 2
.LC136:
	.string	"was energized by"
	.align 2
.LC137:
	.string	"was repeatedly hit by"
	.align 2
.LC138:
	.string	"thinks"
	.align 2
.LC139:
	.string	" is getting repeticious"
	.align 2
.LC140:
	.string	" learns that quality looses out to"
	.align 2
.LC141:
	.string	"'s quantity"
	.align 2
.LC142:
	.string	"wants"
	.align 2
.LC143:
	.string	" to stop hurting him"
	.align 2
.LC144:
	.string	"dances to"
	.align 2
.LC145:
	.string	"'s rythm"
	.align 2
.LC146:
	.string	"got disrupted by"
	.align 2
.LC147:
	.string	"wonders if"
	.align 2
.LC148:
	.string	" can turn the lights back on"
	.align 2
.LC149:
	.string	"was put to sleep by"
	.align 2
.LC150:
	.string	"'s portable sandman"
	.align 2
.LC151:
	.string	"saw"
	.align 2
.LC152:
	.string	"'s black angel of death"
	.align 2
.LC153:
	.string	"tried to parry"
	.align 2
.LC154:
	.string	"'s disruptor blast"
	.align 2
.LC155:
	.string	"was pierced by"
	.align 2
.LC156:
	.string	"'s bowcaster"
	.align 2
.LC157:
	.string	"learns not to argue with"
	.align 2
.LC158:
	.string	"'s wookie"
	.align 2
.LC159:
	.string	"tries to pull"
	.align 2
.LC160:
	.string	"'s bowcaster bolt out of his back"
	.align 2
.LC161:
	.string	"had"
	.align 2
.LC162:
	.string	" teach him another way to die"
	.align 2
.LC163:
	.string	"borrowed"
	.align 2
.LC164:
	.string	"'s spare bowcaster bolt"
	.align 2
.LC165:
	.string	"was vaporised"
	.align 2
.LC166:
	.string	"'s shrapnel"
	.align 2
.LC167:
	.string	"swallowed"
	.align 2
.LC168:
	.string	"'s thermal detonator"
	.align 2
.LC169:
	.string	"tried to throw back"
	.align 2
.LC170:
	.string	"found out why "
	.align 2
.LC171:
	.string	"'s ball was blinking so fast"
	.align 2
.LC172:
	.string	"was cremated by"
	.align 2
.LC173:
	.string	"ate"
	.align 2
.LC174:
	.string	"'s mini rocket"
	.align 2
.LC175:
	.string	"tried to catch"
	.align 2
.LC176:
	.string	"tried to grab"
	.align 2
.LC177:
	.string	"'s boba fett souvenir"
	.align 2
.LC178:
	.string	"was overwhelmed by"
	.align 2
.LC179:
	.string	"'s mini rockets"
	.align 2
.LC180:
	.string	"learned that"
	.align 2
.LC181:
	.string	"'s mini rockets are just as bad as the big ones"
	.align 2
.LC182:
	.string	"almost dodged"
	.align 2
.LC183:
	.string	"'s rocket"
	.align 2
.LC184:
	.string	"'s rocket science 101"
	.align 2
.LC185:
	.string	"'s rocket to the stars"
	.align 2
.LC186:
	.string	"saw the license plate on"
	.align 2
.LC187:
	.string	"had his horizons widened by"
	.align 2
.LC188:
	.string	"was melted by"
	.align 2
.LC189:
	.string	"'s beamtube"
	.align 2
.LC190:
	.string	" is a big meanie"
	.align 2
.LC191:
	.string	"was beamed up by"
	.align 2
.LC192:
	.string	"'s beam tube"
	.align 2
.LC193:
	.string	"wonder's where"
	.align 2
.LC194:
	.string	" got the oversized lightsaber"
	.align 2
.LC195:
	.string	"was dominated by"
	.align 2
.LC196:
	.string	"was picked off by"
	.align 2
.LC197:
	.string	"didn't see"
	.align 2
.LC198:
	.string	"'s nightstinger trail untill it was too late"
	.align 2
.LC199:
	.string	"watches"
	.align 2
.LC200:
	.string	"'s nightstinger trail go through his chest"
	.align 2
.LC201:
	.string	"learned the dangers of"
	.align 2
.LC202:
	.string	"'s modern warfare"
	.align 2
.LC203:
	.string	"got a long distance call from"
	.align 2
.LC204:
	.string	"'s nightstinger"
	.align 2
.LC205:
	.string	"had his throat crushed by"
	.align 2
.LC206:
	.string	"wasn't allowed to borrow"
	.align 2
.LC207:
	.string	"'s astma medication"
	.align 2
.LC208:
	.string	"got his larynx crushed by"
	.align 2
.LC209:
	.string	"'s telekinetics"
	.align 2
.LC210:
	.string	"was forgiven by"
	.align 2
.LC211:
	.string	", Darthy style"
	.align 2
.LC212:
	.string	"was fried by"
	.align 2
.LC213:
	.string	"wonders why"
	.align 2
.LC214:
	.string	"couldn't just touch a radiator"
	.align 2
.LC215:
	.string	"'s lightning -can- strike twice"
	.align 2
.LC216:
	.string	"was tutored by"
	.align 2
.LC217:
	.string	" on the true power of the darkside"
	.align 2
.LC218:
	.string	"got zapped by"
	.align 2
.LC219:
	.string	"%s %s %s%s\n"
	.align 2
.LC220:
	.string	"It looks like %s didn't use the force\n"
	.align 2
.LC24:
	.long 0x46fffe00
	.align 2
.LC221:
	.long 0x0
	.align 3
.LC222:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC223:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientObituary
	.type	 ClientObituary,@function
ClientObituary:
	stwu 1,-64(1)
	mflr 0
	stfd 29,40(1)
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 26,16(1)
	stw 0,68(1)
	lis 9,coop@ha
	lis 8,.LC221@ha
	lwz 11,coop@l(9)
	la 8,.LC221@l(8)
	mr 29,3
	lfs 13,0(8)
	mr 27,5
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L37
	lwz 0,84(27)
	cmpwi 0,0,0
	bc 12,2,.L37
	lis 9,meansOfDeath@ha
	lwz 0,meansOfDeath@l(9)
	oris 0,0,0x800
	stw 0,meansOfDeath@l(9)
.L37:
	lis 9,deathmatch@ha
	lis 10,.LC221@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC221@l(10)
	lfs 13,0(10)
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
	lis 11,.LC23@ha
	lwz 0,meansOfDeath@l(9)
	la 30,.LC23@l(11)
	li 6,0
	rlwinm 28,0,0,5,3
	rlwinm 26,0,0,4,4
	addi 10,28,-17
	cmplwi 0,10,16
	bc 12,1,.L40
	lis 11,.L139@ha
	slwi 10,10,2
	la 11,.L139@l(11)
	lis 9,.L139@ha
	lwzx 0,10,11
	la 9,.L139@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L139:
	.long .L68-.L139
	.long .L77-.L139
	.long .L86-.L139
	.long .L59-.L139
	.long .L40-.L139
	.long .L50-.L139
	.long .L41-.L139
	.long .L40-.L139
	.long .L96-.L139
	.long .L96-.L139
	.long .L130-.L139
	.long .L105-.L139
	.long .L130-.L139
	.long .L114-.L139
	.long .L130-.L139
	.long .L40-.L139
	.long .L123-.L139
.L41:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L42
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L43
	lis 9,.LC25@ha
	la 6,.LC25@l(9)
	b .L40
.L43:
	lis 9,.LC26@ha
	la 6,.LC26@l(9)
	b .L40
.L42:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L46
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L47
	lis 9,.LC27@ha
	la 6,.LC27@l(9)
	b .L40
.L47:
	lis 9,.LC28@ha
	la 6,.LC28@l(9)
	b .L40
.L46:
	lis 9,.LC29@ha
	la 6,.LC29@l(9)
	b .L40
.L50:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L51
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L52
	lis 9,.LC30@ha
	la 6,.LC30@l(9)
	b .L40
.L52:
	lis 9,.LC31@ha
	la 6,.LC31@l(9)
	b .L40
.L51:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L55
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L56
	lis 9,.LC32@ha
	la 6,.LC32@l(9)
	b .L40
.L56:
	lis 9,.LC33@ha
	la 6,.LC33@l(9)
	b .L40
.L55:
	lis 9,.LC34@ha
	la 6,.LC34@l(9)
	b .L40
.L59:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L60
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L61
	lis 9,.LC35@ha
	la 6,.LC35@l(9)
	b .L40
.L61:
	lis 9,.LC36@ha
	la 6,.LC36@l(9)
	b .L40
.L60:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L64
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L65
	lis 9,.LC37@ha
	la 6,.LC37@l(9)
	b .L40
.L65:
	lis 9,.LC38@ha
	la 6,.LC38@l(9)
	b .L40
.L64:
	lis 9,.LC39@ha
	la 6,.LC39@l(9)
	b .L40
.L68:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L69
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L70
	lis 9,.LC40@ha
	la 6,.LC40@l(9)
	b .L40
.L70:
	lis 9,.LC41@ha
	la 6,.LC41@l(9)
	b .L40
.L69:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L73
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L74
	lis 9,.LC42@ha
	la 6,.LC42@l(9)
	b .L40
.L74:
	lis 9,.LC43@ha
	la 6,.LC43@l(9)
	b .L40
.L73:
	lis 9,.LC44@ha
	la 6,.LC44@l(9)
	b .L40
.L77:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L78
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L79
	lis 9,.LC45@ha
	la 6,.LC45@l(9)
	b .L40
.L79:
	lis 9,.LC46@ha
	la 6,.LC46@l(9)
	b .L40
.L78:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L82
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L83
	lis 9,.LC47@ha
	la 6,.LC47@l(9)
	b .L40
.L83:
	lis 9,.LC48@ha
	la 6,.LC48@l(9)
	b .L40
.L82:
	lis 9,.LC49@ha
	la 6,.LC49@l(9)
	b .L40
.L86:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L87
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L88
	lis 9,.LC50@ha
	la 6,.LC50@l(9)
	b .L40
.L88:
	lis 9,.LC51@ha
	la 6,.LC51@l(9)
	b .L40
.L87:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L91
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L92
	lis 9,.LC52@ha
	la 6,.LC52@l(9)
	b .L40
.L92:
	lis 9,.LC53@ha
	la 6,.LC53@l(9)
	b .L40
.L91:
	lis 9,.LC54@ha
	la 6,.LC54@l(9)
	b .L40
.L96:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L97
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L98
	lis 9,.LC55@ha
	la 6,.LC55@l(9)
	b .L40
.L98:
	lis 9,.LC56@ha
	la 6,.LC56@l(9)
	b .L40
.L97:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L101
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L102
	lis 9,.LC57@ha
	la 6,.LC57@l(9)
	b .L40
.L102:
	lis 9,.LC58@ha
	la 6,.LC58@l(9)
	b .L40
.L101:
	lis 9,.LC59@ha
	la 6,.LC59@l(9)
	b .L40
.L105:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L106
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L107
	lis 9,.LC60@ha
	la 6,.LC60@l(9)
	b .L40
.L107:
	lis 9,.LC61@ha
	la 6,.LC61@l(9)
	b .L40
.L106:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L110
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L111
	lis 9,.LC62@ha
	la 6,.LC62@l(9)
	b .L40
.L111:
	lis 9,.LC63@ha
	la 6,.LC63@l(9)
	b .L40
.L110:
	lis 9,.LC64@ha
	la 6,.LC64@l(9)
	b .L40
.L114:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L115
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L116
	lis 9,.LC65@ha
	la 6,.LC65@l(9)
	b .L40
.L116:
	lis 9,.LC66@ha
	la 6,.LC66@l(9)
	b .L40
.L115:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L119
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L120
	lis 9,.LC67@ha
	la 6,.LC67@l(9)
	b .L40
.L120:
	lis 9,.LC68@ha
	la 6,.LC68@l(9)
	b .L40
.L119:
	lis 9,.LC69@ha
	la 6,.LC69@l(9)
	b .L40
.L123:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 30,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 31,0(10)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,31
	bc 4,1,.L124
	lis 9,.LC70@ha
	la 6,.LC70@l(9)
	b .L40
.L124:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,31
	bc 4,1,.L126
	lis 9,.LC71@ha
	la 6,.LC71@l(9)
	b .L40
.L126:
	lis 9,.LC72@ha
	la 6,.LC72@l(9)
	b .L40
.L130:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L131
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L132
	lis 9,.LC73@ha
	la 6,.LC73@l(9)
	b .L40
.L132:
	lis 9,.LC74@ha
	la 6,.LC74@l(9)
	b .L40
.L131:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L135
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L136
	lis 9,.LC75@ha
	la 6,.LC75@l(9)
	b .L40
.L136:
	lis 9,.LC76@ha
	la 6,.LC76@l(9)
	b .L40
.L135:
	lis 9,.LC77@ha
	la 6,.LC77@l(9)
.L40:
	cmpw 0,27,29
	bc 4,2,.L141
	cmpwi 0,28,9
	bc 12,2,.L180
	bc 12,1,.L227
	cmpwi 0,28,7
	bc 12,2,.L145
	b .L215
.L227:
	cmpwi 0,28,16
	bc 12,2,.L145
	cmpwi 0,28,24
	bc 4,2,.L215
	lis 9,.LC78@ha
	la 6,.LC78@l(9)
	b .L141
.L145:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L147
	li 10,0
	b .L148
.L147:
	lis 4,.LC22@ha
	addi 3,3,188
	la 4,.LC22@l(4)
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
	bc 12,2,.L148
	cmpwi 0,11,109
	bc 12,2,.L148
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L148:
	cmpwi 0,10,0
	bc 12,2,.L146
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L150
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L151
	lis 9,.LC79@ha
	la 6,.LC79@l(9)
	b .L141
.L151:
	lis 9,.LC80@ha
	la 6,.LC80@l(9)
	b .L141
.L150:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L154
.L388:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 12,1,.L382
	b .L177
.L154:
	lis 9,.LC83@ha
	la 6,.LC83@l(9)
	b .L141
.L146:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L160
	li 0,0
	b .L161
.L160:
	lis 4,.LC22@ha
	addi 3,3,188
	la 4,.LC22@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 10,0,0
	adde 0,10,0
	or 0,0,9
.L161:
	cmpwi 0,0,0
	bc 12,2,.L159
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L163
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L164
	lis 9,.LC84@ha
	la 6,.LC84@l(9)
	b .L141
.L164:
	lis 9,.LC85@ha
	la 6,.LC85@l(9)
	b .L141
.L163:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 12,1,.L388
	lis 9,.LC86@ha
	la 6,.LC86@l(9)
	b .L141
.L159:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L172
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L173
	lis 9,.LC87@ha
	la 6,.LC87@l(9)
	b .L141
.L173:
	lis 9,.LC88@ha
	la 6,.LC88@l(9)
	b .L141
.L172:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L176
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L177
.L382:
	lis 9,.LC81@ha
	la 6,.LC81@l(9)
	b .L141
.L177:
	lis 9,.LC82@ha
	la 6,.LC82@l(9)
	b .L141
.L176:
	lis 9,.LC89@ha
	la 6,.LC89@l(9)
	b .L141
.L180:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L182
	li 10,0
	b .L183
.L182:
	lis 4,.LC22@ha
	addi 3,3,188
	la 4,.LC22@l(4)
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
	bc 12,2,.L183
	cmpwi 0,11,109
	bc 12,2,.L183
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L183:
	cmpwi 0,10,0
	bc 12,2,.L181
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L185
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L186
	lis 9,.LC90@ha
	la 6,.LC90@l(9)
	b .L141
.L186:
	lis 9,.LC91@ha
	la 6,.LC91@l(9)
	b .L141
.L185:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L189
.L389:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 12,1,.L383
	b .L212
.L189:
	lis 9,.LC94@ha
	la 6,.LC94@l(9)
	b .L141
.L181:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L195
	li 0,0
	b .L196
.L195:
	lis 4,.LC22@ha
	addi 3,3,188
	la 4,.LC22@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 10,0,0
	adde 0,10,0
	or 0,0,9
.L196:
	cmpwi 0,0,0
	bc 12,2,.L194
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L198
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L199
	lis 9,.LC95@ha
	la 6,.LC95@l(9)
	b .L141
.L199:
	lis 9,.LC96@ha
	la 6,.LC96@l(9)
	b .L141
.L198:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 12,1,.L389
	lis 9,.LC97@ha
	la 6,.LC97@l(9)
	b .L141
.L194:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L207
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L208
	lis 9,.LC98@ha
	la 6,.LC98@l(9)
	b .L141
.L208:
	lis 9,.LC99@ha
	la 6,.LC99@l(9)
	b .L141
.L207:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L211
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L212
.L383:
	lis 9,.LC92@ha
	la 6,.LC92@l(9)
	b .L141
.L212:
	lis 9,.LC93@ha
	la 6,.LC93@l(9)
	b .L141
.L211:
	lis 9,.LC100@ha
	la 6,.LC100@l(9)
	b .L141
.L215:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L217
	li 10,0
	b .L218
.L217:
	lis 4,.LC22@ha
	addi 3,3,188
	la 4,.LC22@l(4)
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
	bc 12,2,.L218
	cmpwi 0,11,109
	bc 12,2,.L218
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L218:
	cmpwi 0,10,0
	bc 12,2,.L216
	lis 9,.LC101@ha
	la 6,.LC101@l(9)
	b .L141
.L216:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L222
	li 0,0
	b .L223
.L222:
	lis 4,.LC22@ha
	addi 3,3,188
	la 4,.LC22@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 10,0,0
	adde 0,10,0
	or 0,0,9
.L223:
	cmpwi 0,0,0
	bc 12,2,.L221
	lis 9,.LC102@ha
	la 6,.LC102@l(9)
	b .L141
.L221:
	lis 9,.LC103@ha
	la 6,.LC103@l(9)
.L141:
	cmpwi 0,6,0
	bc 12,2,.L228
	lwz 5,84(29)
	lis 4,.LC104@ha
	li 3,1
	la 4,.LC104@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
	lis 11,deathmatch@ha
	lis 8,.LC221@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC221@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L229
	lwz 11,84(29)
	lwz 9,4032(11)
	addi 9,9,-1
	stw 9,4032(11)
.L229:
	li 0,0
	stw 0,540(29)
	b .L36
.L228:
	cmpwi 0,27,0
	stw 27,540(29)
	bc 12,2,.L38
	lwz 0,84(27)
	cmpwi 0,0,0
	bc 12,2,.L38
	addi 0,28,-1
	cmplwi 0,0,12
	bc 12,1,.L231
	lis 11,.L375@ha
	slwi 10,0,2
	la 11,.L375@l(11)
	lis 9,.L375@ha
	lwzx 0,10,11
	la 9,.L375@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L375:
	.long .L232-.L375
	.long .L267-.L375
	.long .L276-.L375
	.long .L285-.L375
	.long .L294-.L375
	.long .L303-.L375
	.long .L312-.L375
	.long .L321-.L375
	.long .L330-.L375
	.long .L339-.L375
	.long .L348-.L375
	.long .L357-.L375
	.long .L366-.L375
.L232:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L234
	li 0,0
	b .L235
.L234:
	lis 4,.LC22@ha
	addi 3,3,188
	la 4,.LC22@l(4)
	bl Info_ValueForKey
	lbz 0,0(3)
	xori 9,0,70
	subfic 8,9,0
	adde 9,8,9
	xori 0,0,102
	subfic 10,0,0
	adde 0,10,0
	or 0,0,9
.L235:
	cmpwi 0,0,0
	bc 12,2,.L233
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L237
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 12,1,.L384
	lis 9,.LC106@ha
	lis 11,.LC107@ha
	la 6,.LC106@l(9)
	la 30,.LC107@l(11)
	b .L231
.L237:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L254
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L385
	lis 9,.LC108@ha
	lis 11,.LC109@ha
	la 6,.LC108@l(9)
	la 30,.LC109@l(11)
	b .L231
.L233:
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L247
	li 10,0
	b .L248
.L247:
	lis 4,.LC22@ha
	addi 3,3,188
	la 4,.LC22@l(4)
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
	bc 12,2,.L248
	cmpwi 0,11,109
	bc 12,2,.L248
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L248:
	cmpwi 0,10,0
	bc 12,2,.L246
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L250
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 12,1,.L384
	lis 9,.LC114@ha
	lis 11,.LC115@ha
	la 6,.LC114@l(9)
	la 30,.LC115@l(11)
	b .L231
.L250:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L254
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 12,1,.L385
	b .L264
.L254:
	lis 9,.LC112@ha
	lis 11,.LC113@ha
	la 6,.LC112@l(9)
	la 30,.LC113@l(11)
	b .L231
.L246:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L259
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L260
.L384:
	lis 9,.LC105@ha
	la 6,.LC105@l(9)
	b .L231
.L260:
	lis 9,.LC118@ha
	lis 11,.LC119@ha
	la 6,.LC118@l(9)
	la 30,.LC119@l(11)
	b .L231
.L259:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L263
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L264
.L385:
	lis 9,.LC110@ha
	lis 11,.LC111@ha
	la 6,.LC110@l(9)
	la 30,.LC111@l(11)
	b .L231
.L264:
	lis 9,.LC116@ha
	lis 11,.LC117@ha
	la 6,.LC116@l(9)
	la 30,.LC117@l(11)
	b .L231
.L263:
	lis 9,.LC120@ha
	lis 11,.LC113@ha
	la 6,.LC120@l(9)
	la 30,.LC113@l(11)
	b .L231
.L267:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L268
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L269
	lis 9,.LC121@ha
	la 6,.LC121@l(9)
	b .L231
.L269:
	lis 9,.LC122@ha
	lis 11,.LC123@ha
	la 6,.LC122@l(9)
	la 30,.LC123@l(11)
	b .L231
.L268:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L272
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L273
	lis 9,.LC124@ha
	la 6,.LC124@l(9)
	b .L231
.L273:
	lis 9,.LC125@ha
	la 6,.LC125@l(9)
	b .L231
.L272:
	lis 9,.LC126@ha
	lis 11,.LC127@ha
	la 6,.LC126@l(9)
	la 30,.LC127@l(11)
	b .L231
.L276:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L277
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L278
	lis 9,.LC128@ha
	lis 11,.LC129@ha
	la 6,.LC128@l(9)
	la 30,.LC129@l(11)
	b .L231
.L278:
	lis 9,.LC130@ha
	lis 11,.LC131@ha
	la 6,.LC130@l(9)
	la 30,.LC131@l(11)
	b .L231
.L277:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L281
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L282
	lis 9,.LC132@ha
	lis 11,.LC133@ha
	la 6,.LC132@l(9)
	la 30,.LC133@l(11)
	b .L231
.L282:
	lis 9,.LC134@ha
	lis 11,.LC135@ha
	la 6,.LC134@l(9)
	la 30,.LC135@l(11)
	b .L231
.L281:
	lis 9,.LC136@ha
	lis 11,.LC129@ha
	la 6,.LC136@l(9)
	la 30,.LC129@l(11)
	b .L231
.L285:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L286
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L287
	lis 9,.LC137@ha
	la 6,.LC137@l(9)
	b .L231
.L287:
	lis 9,.LC138@ha
	lis 11,.LC139@ha
	la 6,.LC138@l(9)
	la 30,.LC139@l(11)
	b .L231
.L286:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L290
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L291
	lis 9,.LC140@ha
	lis 11,.LC141@ha
	la 6,.LC140@l(9)
	la 30,.LC141@l(11)
	b .L231
.L291:
	lis 9,.LC142@ha
	lis 11,.LC143@ha
	la 6,.LC142@l(9)
	la 30,.LC143@l(11)
	b .L231
.L290:
	lis 9,.LC144@ha
	lis 11,.LC145@ha
	la 6,.LC144@l(9)
	la 30,.LC145@l(11)
	b .L231
.L294:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L295
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L296
	lis 9,.LC146@ha
	la 6,.LC146@l(9)
	b .L231
.L296:
	lis 9,.LC147@ha
	lis 11,.LC148@ha
	la 6,.LC147@l(9)
	la 30,.LC148@l(11)
	b .L231
.L295:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L299
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L300
	lis 9,.LC149@ha
	lis 11,.LC150@ha
	la 6,.LC149@l(9)
	la 30,.LC150@l(11)
	b .L231
.L300:
	lis 9,.LC151@ha
	lis 11,.LC152@ha
	la 6,.LC151@l(9)
	la 30,.LC152@l(11)
	b .L231
.L299:
	lis 9,.LC153@ha
	lis 11,.LC154@ha
	la 6,.LC153@l(9)
	la 30,.LC154@l(11)
	b .L231
.L303:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L304
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L305
	lis 9,.LC155@ha
	lis 11,.LC156@ha
	la 6,.LC155@l(9)
	la 30,.LC156@l(11)
	b .L231
.L305:
	lis 9,.LC157@ha
	lis 11,.LC158@ha
	la 6,.LC157@l(9)
	la 30,.LC158@l(11)
	b .L231
.L304:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L308
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L309
	lis 9,.LC159@ha
	lis 11,.LC160@ha
	la 6,.LC159@l(9)
	la 30,.LC160@l(11)
	b .L231
.L309:
	lis 9,.LC161@ha
	lis 11,.LC162@ha
	la 6,.LC161@l(9)
	la 30,.LC162@l(11)
	b .L231
.L308:
	lis 9,.LC163@ha
	lis 11,.LC164@ha
	la 6,.LC163@l(9)
	la 30,.LC164@l(11)
	b .L231
.L312:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L313
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L314
	lis 9,.LC165@ha
	lis 11,.LC166@ha
	la 6,.LC165@l(9)
	la 30,.LC166@l(11)
	b .L231
.L314:
	lis 9,.LC167@ha
	lis 11,.LC168@ha
	la 6,.LC167@l(9)
	la 30,.LC168@l(11)
	b .L231
.L313:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L317
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L318
	lis 9,.LC169@ha
	lis 11,.LC168@ha
	la 6,.LC169@l(9)
	la 30,.LC168@l(11)
	b .L231
.L318:
	lis 9,.LC170@ha
	lis 11,.LC171@ha
	la 6,.LC170@l(9)
	la 30,.LC171@l(11)
	b .L231
.L317:
	lis 9,.LC172@ha
	lis 11,.LC168@ha
	la 6,.LC172@l(9)
	la 30,.LC168@l(11)
	b .L231
.L321:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L322
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L323
	lis 9,.LC173@ha
	lis 11,.LC174@ha
	la 6,.LC173@l(9)
	la 30,.LC174@l(11)
	b .L231
.L323:
	lis 9,.LC175@ha
	lis 11,.LC174@ha
	la 6,.LC175@l(9)
	la 30,.LC174@l(11)
	b .L231
.L322:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L326
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L327
	lis 9,.LC176@ha
	lis 11,.LC177@ha
	la 6,.LC176@l(9)
	la 30,.LC177@l(11)
	b .L231
.L327:
	lis 9,.LC178@ha
	lis 11,.LC179@ha
	la 6,.LC178@l(9)
	la 30,.LC179@l(11)
	b .L231
.L326:
	lis 9,.LC180@ha
	lis 11,.LC181@ha
	la 6,.LC180@l(9)
	la 30,.LC181@l(11)
	b .L231
.L330:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L331
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L332
	lis 9,.LC182@ha
	lis 11,.LC183@ha
	la 6,.LC182@l(9)
	la 30,.LC183@l(11)
	b .L231
.L332:
	lis 9,.LC114@ha
	lis 11,.LC184@ha
	la 6,.LC114@l(9)
	la 30,.LC184@l(11)
	b .L231
.L331:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L335
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L336
	lis 9,.LC175@ha
	lis 11,.LC185@ha
	la 6,.LC175@l(9)
	la 30,.LC185@l(11)
	b .L231
.L336:
	lis 9,.LC186@ha
	lis 11,.LC183@ha
	la 6,.LC186@l(9)
	la 30,.LC183@l(11)
	b .L231
.L335:
	lis 9,.LC187@ha
	lis 11,.LC183@ha
	la 6,.LC187@l(9)
	la 30,.LC183@l(11)
	b .L231
.L339:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L340
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L341
	lis 9,.LC188@ha
	lis 11,.LC189@ha
	la 6,.LC188@l(9)
	la 30,.LC189@l(11)
	b .L231
.L341:
	lis 9,.LC138@ha
	lis 11,.LC190@ha
	la 6,.LC138@l(9)
	la 30,.LC190@l(11)
	b .L231
.L340:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L344
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L345
	lis 9,.LC191@ha
	lis 11,.LC192@ha
	la 6,.LC191@l(9)
	la 30,.LC192@l(11)
	b .L231
.L345:
	lis 9,.LC193@ha
	lis 11,.LC194@ha
	la 6,.LC193@l(9)
	la 30,.LC194@l(11)
	b .L231
.L344:
	lis 9,.LC195@ha
	lis 11,.LC189@ha
	la 6,.LC195@l(9)
	la 30,.LC189@l(11)
	b .L231
.L348:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L349
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L350
	lis 9,.LC196@ha
	la 6,.LC196@l(9)
	b .L231
.L350:
	lis 9,.LC197@ha
	lis 11,.LC198@ha
	la 6,.LC197@l(9)
	la 30,.LC198@l(11)
	b .L231
.L349:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L353
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L354
	lis 9,.LC199@ha
	lis 11,.LC200@ha
	la 6,.LC199@l(9)
	la 30,.LC200@l(11)
	b .L231
.L354:
	lis 9,.LC201@ha
	lis 11,.LC202@ha
	la 6,.LC201@l(9)
	la 30,.LC202@l(11)
	b .L231
.L353:
	lis 9,.LC203@ha
	lis 11,.LC204@ha
	la 6,.LC203@l(9)
	la 30,.LC204@l(11)
	b .L231
.L357:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L358
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 12,1,.L362
	lis 9,.LC206@ha
	lis 11,.LC207@ha
	la 6,.LC206@l(9)
	la 30,.LC207@l(11)
	b .L231
.L358:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L362
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L363
	lis 9,.LC208@ha
	lis 11,.LC209@ha
	la 6,.LC208@l(9)
	la 30,.LC209@l(11)
	b .L231
.L363:
	lis 9,.LC210@ha
	lis 11,.LC211@ha
	la 6,.LC210@l(9)
	la 30,.LC211@l(11)
	b .L231
.L362:
	lis 9,.LC205@ha
	la 6,.LC205@l(9)
	b .L231
.L366:
	bl rand
	lis 31,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 8,.LC222@ha
	stw 3,12(1)
	la 8,.LC222@l(8)
	lis 11,.LC24@ha
	stw 31,8(1)
	lis 10,.LC223@ha
	lfd 31,0(8)
	la 10,.LC223@l(10)
	lfd 0,8(1)
	lfs 29,.LC24@l(11)
	lfd 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L367
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L368
	lis 9,.LC212@ha
	la 6,.LC212@l(9)
	b .L231
.L368:
	lis 9,.LC213@ha
	lis 11,.LC214@ha
	la 6,.LC213@l(9)
	la 30,.LC214@l(11)
	b .L231
.L367:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L371
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,30
	bc 4,1,.L372
	lis 9,.LC180@ha
	lis 11,.LC215@ha
	la 6,.LC180@l(9)
	la 30,.LC215@l(11)
	b .L231
.L372:
	lis 9,.LC216@ha
	lis 11,.LC217@ha
	la 6,.LC216@l(9)
	la 30,.LC217@l(11)
	b .L231
.L371:
	lis 9,.LC218@ha
	la 6,.LC218@l(9)
.L231:
	cmpwi 0,6,0
	bc 12,2,.L38
	lwz 5,84(29)
	lis 4,.LC219@ha
	mr 8,30
	lwz 7,84(27)
	la 4,.LC219@l(4)
	li 3,1
	addi 5,5,700
	addi 7,7,700
	crxor 6,6,6
	bl safe_bprintf
	lis 11,deathmatch@ha
	lis 8,.LC221@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC221@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L36
	cmpwi 0,26,0
	bc 12,2,.L379
	lwz 11,84(27)
	b .L386
.L379:
	lwz 11,84(27)
	lwz 9,4032(11)
	addi 9,9,1
	b .L387
.L38:
	lwz 5,84(29)
	lis 4,.LC220@ha
	li 3,1
	la 4,.LC220@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
	lis 11,deathmatch@ha
	lis 8,.LC221@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC221@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L36
	lwz 11,84(29)
.L386:
	lwz 9,4032(11)
	addi 9,9,-1
.L387:
	stw 9,4032(11)
.L36:
	lwz 0,68(1)
	mtlr 0
	lmw 26,16(1)
	lfd 29,40(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe2:
	.size	 ClientObituary,.Lfe2-ClientObituary
	.section	".rodata"
	.align 3
.LC224:
	.long 0x404ca5dc
	.long 0x1a63c1f8
	.align 2
.LC225:
	.long 0x0
	.align 2
.LC226:
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
	bc 12,2,.L395
	lis 9,g_edicts@ha
	xor 11,5,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,5,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L395
	lfs 11,12(5)
	lfs 13,4(5)
	lfs 10,4(31)
	lfs 0,8(5)
	b .L405
.L395:
	cmpwi 0,4,0
	bc 12,2,.L397
	lis 9,g_edicts@ha
	xor 11,4,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,4,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L397
	lfs 11,12(4)
	lfs 13,4(4)
	lfs 10,4(31)
	lfs 0,8(4)
.L405:
	lfs 9,8(31)
	lfs 12,12(31)
	fsubs 13,13,10
	fsubs 0,0,9
	fsubs 11,11,12
	stfs 13,8(1)
	stfs 0,12(1)
	stfs 11,16(1)
	b .L396
.L397:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,4180(9)
	b .L394
.L396:
	lis 9,.LC225@ha
	lfs 2,8(1)
	la 9,.LC225@l(9)
	lfs 13,0(9)
	fcmpu 0,2,13
	bc 12,2,.L399
	lfs 1,12(1)
	bl atan2
	lis 9,.LC224@ha
	lwz 11,84(31)
	lfd 0,.LC224@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,4180(11)
	b .L400
.L399:
	lwz 9,84(31)
	stfs 13,4180(9)
	lfs 0,12(1)
	fcmpu 0,0,13
	bc 4,1,.L401
	lwz 9,84(31)
	lis 0,0x42b4
	b .L406
.L401:
	bc 4,0,.L400
	lwz 9,84(31)
	lis 0,0xc2b4
.L406:
	stw 0,4180(9)
.L400:
	lwz 3,84(31)
	lis 9,.LC225@ha
	la 9,.LC225@l(9)
	lfs 0,0(9)
	lfs 13,4180(3)
	fcmpu 0,13,0
	bc 4,0,.L394
	lis 11,.LC226@ha
	la 11,.LC226@l(11)
	lfs 0,0(11)
	fadds 0,13,0
	stfs 0,4180(3)
.L394:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 LookAtKiller,.Lfe3-LookAtKiller
	.section	".rodata"
	.align 3
.LC227:
	.long 0x3fe99999
	.long 0x9999999a
	.align 3
.LC228:
	.long 0x3f847ae1
	.long 0x47ae147b
	.section	".text"
	.align 2
	.globl falling
	.type	 falling,@function
falling:
	lwz 11,56(3)
	li 0,0
	stw 0,260(3)
	addi 9,11,1
	cmpwi 0,9,497
	stw 9,56(3)
	bc 4,2,.L408
	lis 9,ddc@ha
	lis 10,level+4@ha
	la 9,ddc@l(9)
	lis 11,.LC227@ha
	stw 9,436(3)
	lfs 0,level+4@l(10)
	lfd 13,.LC227@l(11)
.L416:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.L408:
	lwz 0,552(3)
	cmpwi 0,0,0
	bc 12,2,.L412
	addi 0,11,-492
	cmplwi 0,0,4
	bc 12,1,.L410
	lis 9,level+4@ha
	lis 11,.LC228@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC228@l(11)
	b .L416
.L410:
	lwz 9,84(3)
	li 0,493
	li 11,497
	stw 0,56(3)
	stw 11,4308(9)
	blr
.L412:
	lwz 8,84(3)
	lwz 0,4308(8)
	cmpw 0,9,0
	bc 4,2,.L414
	li 0,491
	li 10,493
	stw 0,56(3)
	lis 9,level+4@ha
	lis 11,.LC228@ha
	stw 10,4308(8)
	lfs 0,level+4@l(9)
	lfd 13,.LC228@l(11)
	b .L416
.L414:
	lis 9,level+4@ha
	lis 11,.LC228@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC228@l(11)
	b .L416
.Lfe4:
	.size	 falling,.Lfe4-falling
	.section	".rodata"
	.align 2
.LC229:
	.string	"misc/udeath.wav"
	.align 2
.LC235:
	.string	"*death%i.wav"
	.align 2
.LC230:
	.long 0x46fffe00
	.align 3
.LC231:
	.long 0x3fe99999
	.long 0x9999999a
	.align 2
.LC232:
	.long 0x3c23d70a
	.align 3
.LC233:
	.long 0x3fe51eb8
	.long 0x51eb851f
	.align 3
.LC234:
	.long 0x3fd51eb8
	.long 0x51eb851f
	.align 2
.LC236:
	.long 0x0
	.align 3
.LC237:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC238:
	.long 0x3f800000
	.align 3
.LC239:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC240:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl player_die
	.type	 player_die,@function
player_die:
	stwu 1,-64(1)
	mflr 0
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 29,36(1)
	stw 0,68(1)
	mr 31,3
	mr 29,4
	lwz 9,84(31)
	mr 30,5
	lwz 0,4724(9)
	cmpwi 0,0,0
	bc 4,2,.L418
	lwz 0,972(31)
	cmpwi 0,0,0
	bc 4,2,.L418
	bl ChasecamStart
.L418:
	lwz 9,84(31)
	lhz 0,4426(9)
	cmpwi 0,0,0
	bc 12,2,.L419
	lwz 11,1764(9)
	lis 9,gi@ha
	la 9,gi@l(9)
	lwz 3,32(11)
	lwz 0,32(9)
	mtlr 0
	blrl
	lwz 11,84(31)
	li 0,0
	li 10,4
	stw 3,88(11)
	lwz 9,84(31)
	sth 0,4426(9)
	stw 10,260(31)
.L419:
	lis 9,.LC236@ha
	li 0,0
	lwz 11,84(31)
	la 9,.LC236@l(9)
	stw 0,44(31)
	lis 10,0xc100
	lfs 31,0(9)
	li 9,1
	stw 0,76(31)
	stw 9,512(31)
	stfs 31,16(31)
	stfs 31,24(31)
	stw 0,4348(11)
	lwz 9,492(31)
	lwz 0,184(31)
	cmpwi 0,9,0
	stw 10,208(31)
	ori 0,0,2
	stw 0,184(31)
	bc 4,2,.L420
	lis 9,level+4@ha
	lis 11,.LC237@ha
	lfs 0,level+4@l(9)
	la 11,.LC237@l(11)
	li 0,2
	lfd 13,0(11)
	mr 3,31
	mr 4,29
	lwz 11,84(31)
	mr 5,30
	fadd 0,0,13
	frsp 0,0
	stfs 0,4404(11)
	lwz 9,84(31)
	stw 0,0(9)
	bl ClientObituary
	mr 4,29
	mr 5,30
	mr 3,31
	bl CTFFragBonuses
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L422
	lwz 10,84(31)
	lwz 0,4128(10)
	addi 11,10,740
	lwz 4,1764(10)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L423
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 10,10,1792
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 11,10,9
	srawi 9,11,31
	xor 0,9,11
	subf 0,0,9
	srawi 0,0,31
	and 4,4,0
.L423:
	cmpwi 0,4,0
	bc 12,2,.L422
	mr 3,31
	bl Drop_Item
	lis 0,0x2
	stw 0,284(3)
.L422:
	lis 11,.LC236@ha
	lis 9,ctf@ha
	la 11,.LC236@l(11)
	lfs 31,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L425
	mr 3,31
	bl CTFPlayerResetGrapple
	mr 3,31
	bl CTFDeadDropFlag
	mr 3,31
	bl CTFDeadDropTech
.L425:
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L426
	mr 3,31
	bl Cmd_Help_f
.L426:
	lis 9,game@ha
	li 8,0
	la 10,game@l(9)
	lwz 0,1556(10)
	cmpw 0,8,0
	bc 4,0,.L420
	lis 9,itemlist@ha
	lis 11,coop@ha
	la 9,itemlist@l(9)
	mr 4,10
	lwz 6,coop@l(11)
	addi 7,9,56
	li 5,0
	lis 9,.LC236@ha
	li 10,0
	la 9,.LC236@l(9)
	lfs 13,0(9)
.L430:
	lfs 0,20(6)
	fcmpu 0,0,13
	bc 12,2,.L431
	lwz 0,0(7)
	andi. 11,0,16
	bc 12,2,.L431
	lwz 9,84(31)
	addi 11,9,740
	lwzx 0,11,10
	addi 9,9,2660
	stwx 0,9,10
.L431:
	lwz 9,84(31)
	addi 8,8,1
	addi 7,7,76
	addi 9,9,740
	stwx 5,9,10
	lwz 0,1556(4)
	addi 10,10,4
	cmpw 0,8,0
	bc 12,0,.L430
.L420:
	lwz 11,84(31)
	li 30,0
	stw 30,4324(11)
	lwz 9,84(31)
	stw 30,4328(9)
	lwz 11,84(31)
	stw 30,4332(11)
	lwz 0,480(31)
	cmpwi 0,0,-60
	bc 4,0,.L433
	lis 29,gi@ha
	lis 3,.LC229@ha
	la 29,gi@l(29)
	la 3,.LC229@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC238@ha
	lwz 0,16(29)
	lis 11,.LC238@ha
	la 9,.LC238@l(9)
	la 11,.LC238@l(11)
	lfs 1,0(9)
	mr 5,3
	mtlr 0
	li 4,4
	lis 9,.LC236@ha
	lfs 2,0(11)
	mr 3,31
	la 9,.LC236@l(9)
	lfs 3,0(9)
	blrl
	li 11,0
	lis 9,0x1000
	stw 30,408(31)
	li 0,1
	stw 11,248(31)
	stw 9,64(31)
	stw 0,260(31)
	stw 11,512(31)
	stw 30,396(31)
	stw 30,392(31)
	stw 30,388(31)
	stw 30,384(31)
	stw 30,380(31)
	stw 30,376(31)
	b .L434
.L433:
	lwz 9,492(31)
	li 0,7
	stw 0,260(31)
	cmpwi 0,9,0
	bc 4,2,.L434
	bl rand
	lis 30,0x4330
	lis 9,.LC239@ha
	rlwinm 3,3,0,17,31
	lwz 8,84(31)
	la 9,.LC239@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	li 11,5
	lis 10,.LC230@ha
	stw 11,4312(8)
	stw 3,28(1)
	stw 30,24(1)
	lfd 0,24(1)
	lwz 0,612(31)
	lfs 30,.LC230@l(10)
	fsub 0,0,31
	cmpwi 0,0,1
	frsp 0,0
	fdivs 0,0,30
	bc 4,1,.L436
	li 0,407
	lwz 10,84(31)
	li 11,414
	stw 0,56(31)
	lis 9,ddc@ha
	lis 8,level+4@ha
	stw 11,4308(10)
	la 9,ddc@l(9)
	stw 9,436(31)
	lis 11,.LC231@ha
	lfs 0,level+4@l(8)
	lfd 13,.LC231@l(11)
	fadd 0,0,13
	frsp 0,0
	b .L456
.L436:
	lwz 8,84(31)
	lbz 0,16(8)
	andi. 11,0,1
	bc 12,2,.L438
	li 0,414
	li 11,420
	stw 0,56(31)
	lis 9,ddc@ha
	lis 10,level+4@ha
	stw 11,4308(8)
	la 9,ddc@l(9)
	stw 9,436(31)
	lis 11,.LC231@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC231@l(11)
	fadd 0,0,13
	frsp 0,0
	b .L456
.L438:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 4,2,.L440
	lis 11,.LC232@ha
	li 0,488
	lfs 0,.LC232@l(11)
	li 10,490
	lis 9,falling@ha
	stw 0,56(31)
	la 9,falling@l(9)
	stw 10,4308(8)
	stw 9,436(31)
	b .L456
.L440:
	lwz 0,480(31)
	cmpwi 0,0,-25
	bc 4,0,.L442
	lwz 0,4836(8)
	cmpwi 0,0,0
	bc 12,2,.L443
	li 0,460
	li 11,469
	stw 0,56(31)
	lis 9,ddc@ha
	lis 10,level+4@ha
	stw 11,4308(8)
	la 9,ddc@l(9)
	stw 9,436(31)
	lis 11,.LC231@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC231@l(11)
	fadd 0,0,13
	frsp 0,0
	b .L456
.L443:
	lwz 0,4840(8)
	cmpwi 0,0,0
	bc 12,2,.L445
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC240@ha
	stw 3,28(1)
	la 11,.LC240@l(11)
	stw 30,24(1)
	lfd 0,24(1)
	lfd 12,0(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fcmpu 0,13,12
	bc 4,0,.L446
	li 0,469
	lwz 10,84(31)
	li 11,478
	stw 0,56(31)
	lis 9,ddc@ha
	lis 8,level+4@ha
	stw 11,4308(10)
	la 9,ddc@l(9)
	stw 9,436(31)
	lis 11,.LC231@ha
	lfs 0,level+4@l(8)
	lfd 13,.LC231@l(11)
	fadd 0,0,13
	frsp 0,0
	b .L456
.L446:
	li 0,478
	lwz 10,84(31)
	li 11,487
	stw 0,56(31)
	lis 9,ddc@ha
	lis 8,level+4@ha
	stw 11,4308(10)
	la 9,ddc@l(9)
	stw 9,436(31)
	lis 11,.LC231@ha
	lfs 0,level+4@l(8)
	lfd 13,.LC231@l(11)
	fadd 0,0,13
	frsp 0,0
	b .L456
.L445:
	li 0,436
	li 11,444
	stw 0,56(31)
	lis 9,ddc@ha
	lis 10,level+4@ha
	stw 11,4308(8)
	la 9,ddc@l(9)
	stw 9,436(31)
	lis 11,.LC231@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC231@l(11)
	fadd 0,0,13
	frsp 0,0
	b .L456
.L442:
	lwz 0,4828(8)
	cmpwi 0,0,0
	bc 12,2,.L450
	lis 11,.LC232@ha
	li 0,445
	lfs 0,.LC232@l(11)
	li 10,460
	lis 9,falling@ha
	stw 0,56(31)
	la 9,falling@l(9)
	stw 10,4308(8)
	stw 9,436(31)
	b .L456
.L450:
	fmr 13,0
	lis 9,.LC233@ha
	lfd 0,.LC233@l(9)
	fcmpu 0,13,0
	bc 4,1,.L452
	li 0,420
	li 11,427
	b .L457
.L452:
	lis 9,.LC234@ha
	lfd 0,.LC234@l(9)
	fcmpu 0,13,0
	bc 4,1,.L454
	li 0,427
	li 11,436
	b .L457
.L454:
	li 0,436
	li 11,444
.L457:
	stw 0,56(31)
	lis 9,ddc@ha
	lis 10,level+4@ha
	stw 11,4308(8)
	la 9,ddc@l(9)
	lis 11,.LC238@ha
	stw 9,436(31)
	la 11,.LC238@l(11)
	lfs 0,level+4@l(10)
	lfs 13,0(11)
	fadds 0,0,13
.L456:
	stfs 0,428(31)
	lis 29,gi@ha
	la 29,gi@l(29)
	bl rand
	mr 4,3
	srawi 0,4,31
	lis 3,.LC235@ha
	srwi 0,0,30
	la 3,.LC235@l(3)
	add 0,4,0
	rlwinm 0,0,0,0,29
	subf 4,0,4
	addi 4,4,1
	crxor 6,6,6
	bl va
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
	lis 9,.LC236@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC236@l(9)
	lfs 3,0(9)
	blrl
.L434:
	li 0,2
	lis 9,gi+72@ha
	stw 0,492(31)
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,68(1)
	mtlr 0
	lmw 29,36(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe5:
	.size	 player_die,.Lfe5-player_die
	.section	".rodata"
	.align 2
.LC241:
	.string	"Blaster"
	.align 2
.LC242:
	.string	"Lightsaber"
	.align 2
.LC243:
	.long 0x461c4000
	.align 2
.LC244:
	.long 0x0
	.section	".text"
	.align 2
	.globl InitClientPersistant
	.type	 InitClientPersistant,@function
InitClientPersistant:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 26,16(1)
	stw 0,52(1)
	mr 31,3
	li 4,0
	addi 3,31,188
	li 5,1920
	crxor 6,6,6
	bl memset
	lis 9,.LC244@ha
	la 9,.LC244@l(9)
	lfs 13,0(9)
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L460
	lis 9,saberonly@ha
	lwz 11,saberonly@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L459
.L460:
	lis 3,.LC241@ha
	lis 28,0x286b
	la 3,.LC241@l(3)
	ori 28,28,51739
	bl FindItem
	addi 26,31,740
	li 27,1
	lis 29,itemlist@ha
	mr 30,3
	la 29,itemlist@l(29)
	subf 0,29,30
	mullw 0,0,28
	srawi 0,0,2
	stw 0,736(31)
	slwi 9,0,2
	stwx 27,26,9
	lwz 3,52(30)
	bl FindItem
	subf 3,29,3
	li 0,20
	mullw 3,3,28
	rlwinm 3,3,0,0,29
	stwx 27,26,3
	stw 0,1796(31)
	stw 30,1768(31)
	stw 30,1764(31)
.L459:
	lis 11,.LC244@ha
	lis 9,deathmatch@ha
	la 11,.LC244@l(11)
	lfs 31,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L461
	lis 3,.LC242@ha
	la 3,.LC242@l(3)
	bl FindItem
	lis 9,itemlist@ha
	mr 30,3
	la 9,itemlist@l(9)
	lis 0,0x286b
	ori 0,0,51739
	subf 9,9,30
	mullw 9,9,0
	lis 11,saberonly@ha
	addi 8,31,740
	lwz 7,saberonly@l(11)
	li 10,1
	srawi 9,9,2
	stw 9,736(31)
	slwi 0,9,2
	stwx 10,8,0
	lfs 0,20(7)
	fcmpu 0,0,31
	bc 12,2,.L461
	stw 30,1768(31)
	stw 30,1764(31)
.L461:
	li 0,0
	li 29,0
	stw 0,1852(31)
	li 3,1
	sth 29,1948(31)
	bl GetPowerByIndex
	lis 11,.LC243@ha
	li 9,255
	stw 3,2076(31)
	lfs 0,.LC243@l(11)
	li 10,0
	li 8,100
	li 11,1
	li 0,1
	sth 9,2102(31)
	stw 0,720(31)
	sth 11,2106(31)
	sth 29,2104(31)
	stfs 0,4456(31)
	stw 10,4788(31)
	stw 8,728(31)
	sth 9,2092(31)
	sth 9,2094(31)
	sth 9,2096(31)
	sth 9,2098(31)
	sth 9,2100(31)
	stw 10,4612(31)
	stw 8,724(31)
	lwz 0,52(1)
	mtlr 0
	lmw 26,16(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 InitClientPersistant,.Lfe6-InitClientPersistant
	.section	".rodata"
	.align 2
.LC247:
	.string	"info_player_deathmatch"
	.align 2
.LC246:
	.long 0x47c34f80
	.align 2
.LC248:
	.long 0x4b18967f
	.align 2
.LC249:
	.long 0x3f800000
	.align 3
.LC250:
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
	lis 9,.LC246@ha
	li 28,0
	lfs 29,.LC246@l(9)
	li 30,0
	li 23,0
	li 24,0
	fmr 28,29
	lis 22,.LC247@ha
	b .L485
.L487:
	lis 10,.LC249@ha
	lis 9,maxclients@ha
	la 10,.LC249@l(10)
	lis 11,.LC248@ha
	lfs 13,0(10)
	addi 28,28,1
	li 29,1
	lwz 10,maxclients@l(9)
	lis 25,maxclients@ha
	lfs 31,.LC248@l(11)
	lfs 0,20(10)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L495
	lis 11,.LC250@ha
	lis 26,g_edicts@ha
	la 11,.LC250@l(11)
	lis 27,0x4330
	lfd 30,0(11)
	li 31,1076
.L490:
	lwz 0,g_edicts@l(26)
	add 11,0,31
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L492
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L492
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
	bc 4,0,.L492
	fmr 31,1
.L492:
	addi 29,29,1
	lwz 11,maxclients@l(25)
	xoris 0,29,0x8000
	addi 31,31,1076
	stw 0,36(1)
	stw 27,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L490
.L495:
	fcmpu 0,31,28
	bc 4,0,.L497
	fmr 28,31
	mr 24,30
	b .L485
.L497:
	fcmpu 0,31,29
	bc 4,0,.L485
	fmr 29,31
	mr 23,30
.L485:
	lis 5,.LC247@ha
	mr 3,30
	la 5,.LC247@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L487
	cmpwi 0,28,0
	bc 4,2,.L501
	li 3,0
	b .L509
.L501:
	cmpwi 0,28,2
	bc 12,1,.L502
	li 23,0
	li 24,0
	b .L503
.L502:
	addi 28,28,-2
.L503:
	bl rand
	li 30,0
	divw 0,3,28
	mullw 0,0,28
	subf 31,0,3
.L508:
	mr 3,30
	li 4,280
	la 5,.LC247@l(22)
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
	bc 4,2,.L508
.L509:
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
.LC251:
	.long 0x4b18967f
	.align 2
.LC252:
	.long 0x0
	.align 2
.LC253:
	.long 0x3f800000
	.align 3
.LC254:
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
	lis 9,.LC252@ha
	li 31,0
	la 9,.LC252@l(9)
	li 25,0
	lfs 29,0(9)
	b .L511
.L513:
	lis 9,maxclients@ha
	lis 11,.LC253@ha
	lwz 10,maxclients@l(9)
	la 11,.LC253@l(11)
	li 29,1
	lfs 13,0(11)
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC251@ha
	lfs 31,.LC251@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L521
	lis 9,.LC254@ha
	lis 27,g_edicts@ha
	la 9,.LC254@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,1076
.L516:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L518
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L518
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
	bc 4,0,.L518
	fmr 31,1
.L518:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,1076
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L516
.L521:
	fcmpu 0,31,29
	bc 4,1,.L511
	fmr 29,31
	mr 25,31
.L511:
	lis 30,.LC247@ha
	mr 3,31
	li 4,280
	la 5,.LC247@l(30)
	bl G_Find
	mr. 31,3
	bc 4,2,.L513
	cmpwi 0,25,0
	mr 3,25
	bc 4,2,.L526
	la 5,.LC247@l(30)
	li 3,0
	li 4,280
	bl G_Find
.L526:
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
.LC255:
	.string	"Couldn't find spawn point %s\n"
	.align 2
.LC256:
	.long 0x0
	.align 2
.LC257:
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
	lis 11,.LC256@ha
	lis 9,ctf@ha
	la 11,.LC256@l(11)
	mr 26,4
	lfs 13,0(11)
	mr 25,5
	li 30,0
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L541
	bl SelectCTFSpawnPoint
	mr 30,3
	b .L542
.L541:
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L543
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,512
	bc 12,2,.L544
	bl SelectFarthestDeathmatchSpawnPoint
	mr 30,3
	b .L542
.L544:
	bl SelectRandomDeathmatchSpawnPoint
	mr 30,3
	b .L542
.L571:
	li 30,0
	b .L542
.L543:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L542
	lis 11,game+1028@ha
	lwz 0,84(3)
	lis 9,0x692b
	lwz 10,game+1028@l(11)
	ori 9,9,12007
	li 29,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,2
	bc 12,2,.L542
	lis 27,.LC3@ha
	lis 28,.LC23@ha
	lis 30,game+1032@ha
.L553:
	mr 3,29
	li 4,280
	la 5,.LC3@l(27)
	bl G_Find
	mr. 29,3
	bc 12,2,.L571
	lwz 4,300(29)
	la 9,.LC23@l(28)
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
	bc 4,2,.L553
	addic. 31,31,-1
	bc 4,2,.L553
	mr 30,29
.L542:
	cmpwi 0,30,0
	bc 4,2,.L559
	lis 29,.LC1@ha
	lis 31,game@ha
.L566:
	mr 3,30
	li 4,280
	la 5,.LC1@l(29)
	bl G_Find
	mr. 30,3
	bc 12,2,.L572
	la 3,game@l(31)
	lbz 0,1032(3)
	cmpwi 0,0,0
	bc 4,2,.L570
	lwz 0,300(30)
	cmpwi 0,0,0
	bc 12,2,.L561
	b .L566
.L570:
	lwz 4,300(30)
	cmpwi 0,4,0
	bc 12,2,.L566
	addi 3,3,1032
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L566
.L561:
	cmpwi 0,30,0
	bc 4,2,.L559
.L572:
	lis 9,game@ha
	la 31,game@l(9)
	lbz 0,1032(31)
	cmpwi 0,0,0
	bc 4,2,.L568
	lis 5,.LC1@ha
	li 3,0
	la 5,.LC1@l(5)
	li 4,280
	bl G_Find
	mr 30,3
.L568:
	cmpwi 0,30,0
	bc 4,2,.L559
	lis 9,gi+28@ha
	lis 3,.LC255@ha
	lwz 0,gi+28@l(9)
	la 3,.LC255@l(3)
	addi 4,31,1032
	mtlr 0
	crxor 6,6,6
	blrl
.L559:
	lfs 0,4(30)
	lis 9,.LC257@ha
	la 9,.LC257@l(9)
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
.LC258:
	.string	"bodyque"
	.align 3
.LC259:
	.long 0x3f847ae1
	.long 0x47ae147b
	.section	".text"
	.align 2
	.globl CopyToBodyQue
	.type	 CopyToBodyQue,@function
CopyToBodyQue:
	stwu 1,-64(1)
	mflr 0
	stmw 23,28(1)
	stw 0,68(1)
	lis 9,maxclients@ha
	lis 25,level@ha
	lwz 11,maxclients@l(9)
	la 25,level@l(25)
	lwz 10,296(25)
	lis 24,gi@ha
	mr 28,3
	lfs 0,20(11)
	la 24,gi@l(24)
	addi 9,10,1
	lwz 11,76(24)
	lis 26,g_edicts@ha
	srawi 0,9,31
	lwz 23,g_edicts@l(26)
	srwi 0,0,29
	mtlr 11
	add 0,9,0
	rlwinm 0,0,0,0,28
	fctiwz 13,0
	subf 9,0,9
	stw 9,296(25)
	stfd 13,16(1)
	lwz 27,20(1)
	add 27,27,10
	mulli 27,27,1076
	addi 27,27,1076
	blrl
	add 29,23,27
	lwz 9,76(24)
	mr 3,29
	mtlr 9
	blrl
	mr 4,28
	li 5,84
	mr 3,29
	crxor 6,6,6
	bl memcpy
	lwz 0,g_edicts@l(26)
	lis 9,0x6205
	lis 11,body_die@ha
	ori 9,9,46533
	lis 10,deadboy@ha
	subf 0,0,29
	la 11,body_die@l(11)
	mullw 0,0,9
	la 10,deadboy@l(10)
	lis 8,.LC259@ha
	mr 3,29
	srawi 0,0,2
	stwx 0,23,27
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
	lfs 13,8(29)
	stw 0,248(29)
	lwz 9,252(28)
	lfs 0,12(29)
	stw 9,252(29)
	lwz 0,256(28)
	lfs 12,4(29)
	stw 0,256(29)
	lwz 9,260(28)
	stfs 13,1024(29)
	stw 11,456(29)
	stw 9,260(29)
	stfs 12,1020(29)
	stfs 0,1028(29)
	stw 10,436(29)
	lfs 0,4(25)
	lfd 13,.LC259@l(8)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 0,72(24)
	mtlr 0
	blrl
	lwz 0,68(1)
	mtlr 0
	lmw 23,28(1)
	la 1,64(1)
	blr
.Lfe10:
	.size	 CopyToBodyQue,.Lfe10-CopyToBodyQue
	.section	".rodata"
	.align 2
.LC260:
	.string	"misc/spawn.wav"
	.align 2
.LC261:
	.string	"menu_loadgame\n"
	.align 2
.LC262:
	.long 0x0
	.align 2
.LC263:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl respawn
	.type	 respawn,@function
respawn:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 28,24(1)
	stw 0,52(1)
	mr 31,3
	lwz 9,84(31)
	lwz 3,4732(9)
	cmpwi 0,3,0
	bc 12,2,.L583
	bl G_FreeEdict
.L583:
	lwz 9,84(31)
	lwz 3,4728(9)
	cmpwi 0,3,0
	bc 12,2,.L584
	bl G_FreeEdict
.L584:
	lis 9,deathmatch@ha
	li 0,255
	lwz 11,deathmatch@l(9)
	lis 9,.LC262@ha
	stw 0,40(31)
	la 9,.LC262@l(9)
	lfs 0,20(11)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L586
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L582
.L586:
	lwz 0,184(31)
	mr 3,31
	addi 28,31,4
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	bl PutClientInServer
	mr 3,31
	bl RespawnExplosion
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,51
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,88(29)
	mr 3,28
	li 4,1
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC260@ha
	la 3,.LC260@l(3)
	mtlr 9
	blrl
	lis 9,.LC263@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC263@l(9)
	li 4,2
	lfs 1,0(9)
	mtlr 0
	mr 3,31
	lis 9,.LC263@ha
	la 9,.LC263@l(9)
	lfs 2,0(9)
	lis 9,.LC262@ha
	la 9,.LC262@l(9)
	lfs 3,0(9)
	blrl
	lwz 11,84(31)
	li 0,32
	li 10,14
	lis 8,level+4@ha
	lis 7,theforce@ha
	stb 0,16(11)
	lwz 9,84(31)
	stb 10,17(9)
	lfs 13,level+4@l(8)
	lwz 9,84(31)
	lwz 11,theforce@l(7)
	stfs 13,4404(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L582
	lwz 9,84(31)
	li 11,1
	stw 11,4612(9)
	lwz 9,84(31)
	lwz 0,4080(9)
	cmpwi 0,0,11
	bc 4,2,.L588
	mr 3,31
	bl watchmesing
	b .L582
.L588:
	cmpwi 0,0,12
	bc 4,2,.L590
	mr 3,31
	bl imabigchicken
	b .L582
.L590:
	cmpwi 0,0,13
	bc 4,2,.L592
	mr 3,31
	bl googl3
	b .L582
.L592:
	stw 11,4612(9)
	li 8,1
	lis 0,0x447a
	li 9,22
	li 10,4
	mtctr 9
.L599:
	lwz 9,84(31)
	addi 9,9,1856
	stwx 8,9,10
	lwz 11,84(31)
	addi 11,11,1984
	stwx 0,11,10
	addi 10,10,4
	bdnz .L599
	mr 3,31
	bl calc_subgroup_values
	mr 3,31
	bl calc_darklight_value
	mr 3,31
	bl calc_top_level_value
	lwz 9,84(31)
	lfs 1,1952(9)
	fadds 1,1,1
	bl ceil
	fctiwz 0,1
	lwz 11,84(31)
	mr 3,31
	stfd 0,16(1)
	lwz 9,20(1)
	sth 9,1948(11)
	bl sort_useable_powers
.L582:
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe11:
	.size	 respawn,.Lfe11-respawn
	.section	".rodata"
	.align 2
.LC264:
	.string	"spectator"
	.align 2
.LC265:
	.string	"none"
	.align 2
.LC266:
	.string	"Spectator password incorrect.\n"
	.align 2
.LC267:
	.string	"spectator 0\n"
	.align 2
.LC268:
	.string	"Server spectator limit is full."
	.align 2
.LC269:
	.string	"password"
	.align 2
.LC270:
	.string	"Password incorrect.\n"
	.align 2
.LC271:
	.string	"spectator 1\n"
	.align 2
.LC272:
	.string	"%s has moved to the sidelines\n"
	.align 2
.LC273:
	.string	"%s joined the game\n"
	.align 2
.LC274:
	.long 0x3f800000
	.align 3
.LC275:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC276:
	.long 0x0
	.section	".text"
	.align 2
	.globl spectator_respawn
	.type	 spectator_respawn,@function
spectator_respawn:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	mr 31,3
	lwz 3,84(31)
	lwz 0,1788(3)
	cmpwi 0,0,0
	bc 12,2,.L601
	lis 4,.LC264@ha
	addi 3,3,188
	la 4,.LC264@l(4)
	lis 30,spectator_password@ha
	bl Info_ValueForKey
	lwz 9,spectator_password@l(30)
	mr 29,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L602
	lis 4,.LC265@ha
	la 4,.LC265@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L602
	lwz 9,spectator_password@l(30)
	mr 4,29
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L602
	lis 5,.LC266@ha
	li 4,2
	la 5,.LC266@l(5)
	mr 3,31
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(31)
	li 0,0
	lis 29,gi@ha
	la 29,gi@l(29)
	li 3,11
	stw 0,1788(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC267@ha
	la 3,.LC267@l(3)
	b .L629
.L602:
	lis 9,maxclients@ha
	lis 10,.LC274@ha
	lwz 11,maxclients@l(9)
	la 10,.LC274@l(10)
	li 7,1
	lfs 0,0(10)
	li 8,0
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L604
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC275@ha
	la 9,.LC275@l(9)
	addi 10,11,1076
	lfd 13,0(9)
.L606:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L605
	lwz 11,84(10)
	addi 9,8,1
	lwz 0,1788(11)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L605:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,1076
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L606
.L604:
	xoris 0,8,0x8000
	lis 11,0x4330
	stw 0,20(1)
	lis 10,.LC275@ha
	la 10,.LC275@l(10)
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
	bc 4,3,.L610
	lis 5,.LC268@ha
	li 4,2
	la 5,.LC268@l(5)
	mr 3,31
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(31)
	li 0,0
	lis 29,gi@ha
	la 29,gi@l(29)
	li 3,11
	stw 0,1788(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC267@ha
	la 3,.LC267@l(3)
	b .L629
.L601:
	lis 4,.LC269@ha
	addi 3,3,188
	la 4,.LC269@l(4)
	lis 30,password@ha
	bl Info_ValueForKey
	lwz 9,password@l(30)
	mr 29,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L610
	lis 4,.LC265@ha
	la 4,.LC265@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L610
	lwz 9,password@l(30)
	mr 4,29
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L610
	lis 5,.LC270@ha
	li 4,2
	la 5,.LC270@l(5)
	mr 3,31
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(31)
	li 0,1
	lis 29,gi@ha
	la 29,gi@l(29)
	li 3,11
	stw 0,1788(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	lis 3,.LC271@ha
	la 3,.LC271@l(3)
.L629:
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,31
	li 4,1
	mtlr 0
	blrl
	b .L600
.L610:
	lwz 11,84(31)
	li 9,0
	lis 10,.LC276@ha
	la 10,.LC276@l(10)
	mr 3,31
	stw 9,4032(11)
	stw 9,1776(11)
	lwz 0,184(31)
	lfs 31,0(10)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	bl PutClientInServer
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L612
	mr 3,31
	bl ClientBeginDeathmatch
	lis 9,theforce@ha
	lwz 11,theforce@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L612
	lwz 9,84(31)
	li 11,1
	stw 11,4612(9)
	lwz 9,84(31)
	lwz 0,4080(9)
	cmpwi 0,0,11
	bc 4,2,.L614
	mr 3,31
	bl watchmesing
	b .L612
.L614:
	cmpwi 0,0,12
	bc 4,2,.L616
	mr 3,31
	bl imabigchicken
	b .L612
.L616:
	cmpwi 0,0,13
	bc 4,2,.L618
	mr 3,31
	bl googl3
	b .L612
.L618:
	stw 11,4612(9)
	li 8,1
	lis 0,0x447a
	li 9,22
	li 10,4
	mtctr 9
.L628:
	lwz 9,84(31)
	addi 9,9,1856
	stwx 8,9,10
	lwz 11,84(31)
	addi 11,11,1984
	stwx 0,11,10
	addi 10,10,4
	bdnz .L628
	mr 3,31
	bl calc_subgroup_values
	mr 3,31
	bl calc_darklight_value
	mr 3,31
	bl calc_top_level_value
	lwz 9,84(31)
	lfs 1,1952(9)
	fadds 1,1,1
	bl ceil
	fctiwz 0,1
	lwz 11,84(31)
	mr 3,31
	stfd 0,16(1)
	lwz 9,20(1)
	sth 9,1948(11)
	bl sort_useable_powers
.L612:
	lwz 9,84(31)
	lwz 0,1788(9)
	cmpwi 0,0,0
	bc 4,2,.L625
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x6205
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,46533
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
.L625:
	lis 9,level+4@ha
	lwz 11,84(31)
	lfs 0,level+4@l(9)
	stfs 0,4404(11)
	lwz 3,84(31)
	lwz 0,1788(3)
	cmpwi 0,0,0
	bc 12,2,.L626
	lis 4,.LC272@ha
	addi 5,3,700
	la 4,.LC272@l(4)
	li 3,2
	crxor 6,6,6
	bl safe_bprintf
	b .L600
.L626:
	lis 4,.LC273@ha
	addi 5,3,700
	la 4,.LC273@l(4)
	li 3,2
	crxor 6,6,6
	bl safe_bprintf
.L600:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe12:
	.size	 spectator_respawn,.Lfe12-spectator_respawn
	.section	".rodata"
	.align 2
.LC277:
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.align 2
.LC278:
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.align 2
.LC279:
	.string	"player"
	.align 2
.LC280:
	.string	"players/male/tris.md2"
	.align 2
.LC281:
	.string	"sensitivity \"%f\"\n"
	.align 2
.LC282:
	.string	"Custom mouse sensitivity is %f\n"
	.align 2
.LC283:
	.long 0x0
	.align 2
.LC284:
	.long 0x41400000
	.align 2
.LC285:
	.long 0x41000000
	.align 2
.LC286:
	.long 0x47800000
	.align 2
.LC287:
	.long 0x43b40000
	.align 2
.LC288:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl PutClientInServer
	.type	 PutClientInServer,@function
PutClientInServer:
	stwu 1,-5088(1)
	mflr 0
	stfd 31,5080(1)
	stmw 19,5028(1)
	stw 0,5092(1)
	lis 9,.LC277@ha
	lis 10,.LC278@ha
	lwz 0,.LC277@l(9)
	la 29,.LC278@l(10)
	addi 8,1,8
	la 9,.LC277@l(9)
	lwz 11,.LC278@l(10)
	mr 31,3
	lwz 28,8(9)
	addi 7,1,24
	addi 5,1,56
	lwz 6,4(9)
	mr 19,5
	lis 9,.LC283@ha
	stw 0,8(1)
	addi 4,1,40
	la 9,.LC283@l(9)
	stw 28,8(8)
	lfs 31,0(9)
	stw 6,4(8)
	lwz 0,8(29)
	lwz 9,4(29)
	stw 11,24(1)
	stw 0,8(7)
	stw 9,4(7)
	bl SelectSpawnPoint
	lis 11,g_edicts@ha
	lwz 25,84(31)
	lis 10,deathmatch@ha
	lwz 9,g_edicts@l(11)
	li 8,0
	lis 0,0x6205
	lwz 11,deathmatch@l(10)
	ori 0,0,46533
	stw 8,4796(25)
	subf 9,9,31
	lfs 0,20(11)
	mullw 9,9,0
	srawi 9,9,2
	fcmpu 0,0,31
	addi 30,9,-1
	bc 12,2,.L631
	addi 27,1,1992
	addi 26,25,2108
	mulli 23,30,4956
	addi 29,1,3976
	mr 4,26
	li 5,1976
	mr 3,27
	crxor 6,6,6
	bl memcpy
	addi 28,25,188
	mr 20,27
	mr 4,28
	li 5,512
	mr 3,29
	mr 27,28
	crxor 6,6,6
	bl memcpy
	mr 21,29
	mr 24,26
	mr 3,25
	addi 30,1,72
	bl InitClientPersistant
	addi 22,25,20
	addi 28,25,4036
	lis 9,theforce@ha
	lwz 11,theforce@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L632
	lwz 9,84(31)
	li 11,1
	stw 11,4612(9)
	lwz 9,84(31)
	lwz 0,4080(9)
	cmpwi 0,0,11
	bc 4,2,.L633
	mr 3,31
	bl watchmesing
	b .L632
.L633:
	cmpwi 0,0,12
	bc 4,2,.L635
	mr 3,31
	bl imabigchicken
	b .L632
.L635:
	cmpwi 0,0,13
	bc 4,2,.L637
	mr 3,31
	bl googl3
	b .L632
.L637:
	stw 11,4612(9)
	li 8,1
	lis 0,0x447a
	li 9,22
	li 10,4
	mtctr 9
.L675:
	lwz 9,84(31)
	addi 9,9,1856
	stwx 8,9,10
	lwz 11,84(31)
	addi 11,11,1984
	stwx 0,11,10
	addi 10,10,4
	bdnz .L675
	mr 3,31
	bl calc_subgroup_values
	mr 3,31
	bl calc_darklight_value
	mr 3,31
	bl calc_top_level_value
	lwz 9,84(31)
	lfs 1,1952(9)
	fadds 1,1,1
	bl ceil
	fctiwz 0,1
	lwz 11,84(31)
	mr 3,31
	stfd 0,5016(1)
	lwz 9,5020(1)
	sth 9,1948(11)
	bl sort_useable_powers
.L632:
	mr 4,21
	mr 3,31
	bl ClientUserinfoChanged
	b .L644
.L631:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L645
	addi 28,1,1992
	addi 27,25,2108
	mulli 23,30,4956
	mr 4,27
	li 5,1976
	mr 3,28
	addi 29,25,188
	crxor 6,6,6
	bl memcpy
	mr 20,28
	mr 24,27
	addi 26,1,4488
	mr 4,29
	li 5,512
	mr 3,26
	crxor 6,6,6
	bl memcpy
	mr 27,29
	addi 22,25,20
	lwz 0,1780(25)
	mr 4,28
	addi 30,1,72
	li 5,1920
	mr 3,29
	stw 0,3584(1)
	addi 28,25,4036
	lwz 0,1784(25)
	stw 0,3588(1)
	crxor 6,6,6
	bl memcpy
	mr 4,26
	mr 3,31
	bl ClientUserinfoChanged
	lwz 9,3916(1)
	lwz 0,1776(25)
	cmpw 0,9,0
	bc 4,1,.L644
	stw 9,1776(25)
	b .L644
.L645:
	addi 29,1,1992
	li 4,0
	mulli 23,30,4956
	mr 3,29
	li 5,1976
	crxor 6,6,6
	bl memset
	mr 20,29
	addi 24,25,2108
	addi 27,25,188
	addi 30,1,72
	addi 22,25,20
	addi 28,25,4036
.L644:
	lwz 9,84(31)
	li 29,1
	mr 4,27
	li 5,1920
	mr 3,30
	stw 29,4832(9)
	crxor 6,6,6
	bl memcpy
	li 4,0
	li 5,4956
	mr 3,25
	crxor 6,6,6
	bl memset
	mr 3,27
	mr 4,30
	li 5,1920
	crxor 6,6,6
	bl memcpy
	lwz 0,724(25)
	cmpwi 0,0,0
	bc 12,1,.L648
	mr 3,25
	bl InitClientPersistant
	lis 9,.LC283@ha
	lis 11,theforce@ha
	la 9,.LC283@l(9)
	lfs 13,0(9)
	lwz 9,theforce@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L648
	lwz 9,84(31)
	stw 29,4612(9)
	lwz 9,84(31)
	lwz 0,4080(9)
	cmpwi 0,0,11
	bc 4,2,.L650
	mr 3,31
	bl watchmesing
	b .L648
.L650:
	cmpwi 0,0,12
	bc 4,2,.L652
	mr 3,31
	bl imabigchicken
	b .L648
.L652:
	cmpwi 0,0,13
	bc 4,2,.L654
	mr 3,31
	bl googl3
	b .L648
.L654:
	stw 29,4612(9)
	li 8,1
	lis 0,0x447a
	li 9,22
	li 10,4
	mtctr 9
.L674:
	lwz 9,84(31)
	addi 9,9,1856
	stwx 8,9,10
	lwz 11,84(31)
	addi 11,11,1984
	stwx 0,11,10
	addi 10,10,4
	bdnz .L674
	mr 3,31
	bl calc_subgroup_values
	mr 3,31
	bl calc_darklight_value
	mr 3,31
	bl calc_top_level_value
	lwz 9,84(31)
	lfs 1,1952(9)
	fadds 1,1,1
	bl ceil
	fctiwz 0,1
	lwz 11,84(31)
	mr 3,31
	stfd 0,5016(1)
	lwz 9,5020(1)
	sth 9,1948(11)
	bl sort_useable_powers
.L648:
	mr 3,24
	mr 4,20
	li 5,1976
	crxor 6,6,6
	bl memcpy
	lis 9,.LC283@ha
	lwz 7,84(31)
	lis 10,coop@ha
	la 9,.LC283@l(9)
	lwz 8,coop@l(10)
	lfs 10,0(9)
	lwz 9,724(7)
	lwz 11,264(31)
	stw 9,480(31)
	lwz 0,728(7)
	stw 0,484(31)
	lwz 9,732(7)
	or 11,11,9
	stw 11,264(31)
	lfs 0,20(8)
	fcmpu 0,0,10
	bc 12,2,.L662
	lwz 0,1776(7)
	stw 0,4032(7)
.L662:
	li 29,0
	lis 9,game+1028@ha
	lwz 7,264(31)
	stw 29,552(31)
	lis 11,.LC279@ha
	li 5,2
	lwz 0,game+1028@l(9)
	la 11,.LC279@l(11)
	li 10,22
	li 9,4
	li 8,1
	stw 10,508(31)
	stw 9,260(31)
	add 0,0,23
	li 6,200
	lis 9,.LC284@ha
	stw 0,84(31)
	lis 3,level+4@ha
	stw 8,88(31)
	la 9,.LC284@l(9)
	lis 10,player_pain@ha
	stw 11,280(31)
	lis 8,.LC280@ha
	la 10,player_pain@l(10)
	stw 6,400(31)
	lis 11,player_die@ha
	la 8,.LC280@l(8)
	stw 5,248(31)
	la 11,player_die@l(11)
	rlwinm 7,7,0,21,19
	stw 5,512(31)
	li 6,36
	li 4,0
	stw 29,492(31)
	li 5,184
	lfs 0,level+4@l(3)
	lfs 13,0(9)
	lwz 0,184(31)
	lis 9,0x201
	ori 9,9,3
	stw 8,268(31)
	fadds 0,0,13
	rlwinm 0,0,0,31,29
	stw 9,252(31)
	stw 10,452(31)
	stw 11,456(31)
	stw 7,264(31)
	stw 0,184(31)
	stb 6,924(31)
	stfs 0,404(31)
	stw 29,612(31)
	stw 29,608(31)
	stw 29,912(31)
	stw 29,972(31)
	stw 29,4436(25)
	lfs 0,8(1)
	lfs 13,12(1)
	lfs 12,16(1)
	lfs 11,24(1)
	stfs 0,188(31)
	stfs 13,192(31)
	stfs 12,196(31)
	stfs 11,200(31)
	lfs 0,28(1)
	lfs 13,32(1)
	lwz 3,84(31)
	stfs 0,204(31)
	stfs 13,208(31)
	stfs 10,376(31)
	stfs 10,384(31)
	stfs 10,380(31)
	crxor 6,6,6
	bl memset
	lis 9,.LC285@ha
	lfs 0,40(1)
	lis 8,0x42b4
	la 9,.LC285@l(9)
	lbz 0,16(25)
	lis 7,gi+32@ha
	lfs 10,0(9)
	andi. 0,0,191
	lwz 6,1764(25)
	mr 11,9
	mr 10,9
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,5016(1)
	lwz 9,5020(1)
	sth 9,4(25)
	lfs 0,44(1)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,5016(1)
	lwz 11,5020(1)
	sth 11,6(25)
	lfs 0,48(1)
	stw 8,4428(25)
	stw 8,112(25)
	fmuls 0,0,10
	stb 0,16(25)
	fctiwz 11,0
	stfd 11,5016(1)
	lwz 10,5020(1)
	sth 10,8(25)
	lwz 0,gi+32@l(7)
	lwz 3,32(6)
	mtlr 0
	blrl
	lis 11,.LC287@ha
	lis 9,.LC286@ha
	stw 3,88(25)
	la 11,.LC287@l(11)
	la 9,.LC286@l(9)
	lfs 13,48(1)
	lfs 10,0(11)
	lis 0,0x6205
	mr 5,19
	lis 11,g_edicts@ha
	lfs 9,0(9)
	ori 0,0,46533
	lwz 9,g_edicts@l(11)
	mr 7,28
	mr 8,22
	lis 11,.LC288@ha
	lfs 11,40(1)
	li 10,0
	la 11,.LC288@l(11)
	subf 9,9,31
	lfs 12,44(1)
	lfs 0,0(11)
	mullw 9,9,0
	li 0,3
	li 11,255
	stw 29,56(31)
	mtctr 0
	srawi 9,9,2
	stw 11,44(31)
	fadds 13,13,0
	addi 9,9,-1
	stfs 11,28(31)
	stfs 12,32(31)
	stw 9,60(31)
	stfs 13,36(31)
	stw 29,64(31)
	stw 11,40(31)
	stfs 11,4(31)
	stfs 12,8(31)
	stfs 13,12(31)
.L673:
	lfsx 0,10,5
	lfsx 12,10,7
	addi 10,10,4
	fsubs 0,0,12
	fmuls 0,0,9
	fdivs 0,0,10
	fctiwz 13,0
	stfd 13,5016(1)
	lwz 9,5020(1)
	sth 9,0(8)
	addi 8,8,2
	bdnz .L673
	lis 9,.LC283@ha
	lfs 0,60(1)
	la 9,.LC283@l(9)
	lfs 31,0(9)
	stfs 0,20(31)
	stfs 31,24(31)
	stfs 31,16(31)
	stfs 31,28(25)
	lfs 13,20(31)
	lwz 0,1788(25)
	stfs 13,32(25)
	cmpwi 0,0,0
	lfs 0,24(31)
	stfs 0,36(25)
	lfs 13,16(31)
	stfs 13,4252(25)
	lfs 0,20(31)
	stfs 0,4256(25)
	lfs 13,24(31)
	stfs 13,4260(25)
	bc 12,2,.L668
	li 9,0
	li 10,1
	stw 10,4076(25)
	lis 8,gi+72@ha
	mr 3,31
	stw 9,4408(25)
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
	b .L630
.L668:
	stw 0,4076(25)
	mr 3,31
	bl CTFStartClient
	cmpwi 0,3,0
	bc 4,2,.L630
	mr 3,31
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,1764(25)
	mr 3,31
	stw 0,4148(25)
	bl ChangeWeapon
	lis 9,mouse_s@ha
	lwz 11,mouse_s@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L630
	lwz 0,972(31)
	cmpwi 0,0,0
	bc 4,2,.L630
	stfs 0,4824(25)
	lis 4,.LC281@ha
	mr 3,31
	lwz 9,84(31)
	la 4,.LC281@l(4)
	lfs 1,4824(9)
	creqv 6,6,6
	bl _stuffcmd
	lfs 1,4824(25)
	lis 5,.LC282@ha
	mr 3,31
	la 5,.LC282@l(5)
	li 4,1
	creqv 6,6,6
	bl safe_cprintf
.L630:
	lwz 0,5092(1)
	mtlr 0
	lmw 19,5028(1)
	lfd 31,5080(1)
	la 1,5088(1)
	blr
.Lfe13:
	.size	 PutClientInServer,.Lfe13-PutClientInServer
	.globl num_players
	.section	".sdata","aw"
	.align 2
	.type	 num_players,@object
	.size	 num_players,4
num_players:
	.long 0
	.section	".rodata"
	.align 2
.LC289:
	.string	"%s entered the game\n"
	.align 2
.LC290:
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
	mr 30,3
	bl G_InitEdict
	lwz 31,84(30)
	li 4,0
	li 5,1976
	addi 28,31,2108
	lwz 29,4048(31)
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	stw 29,4048(31)
	mr 3,28
	lwz 0,level@l(9)
	addi 4,31,188
	li 5,1920
	stw 0,4028(31)
	crxor 6,6,6
	bl memcpy
	lis 9,.LC290@ha
	lis 11,ctf@ha
	la 9,.LC290@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L678
	lwz 0,4048(31)
	cmpwi 0,0,0
	bc 12,1,.L678
	mr 3,31
	bl CTFAssignTeam
.L678:
	lis 10,num_players@ha
	lis 11,players@ha
	lwz 9,num_players@l(10)
	la 11,players@l(11)
	mr 3,30
	slwi 0,9,2
	addi 9,9,1
	stwx 30,11,0
	stw 9,num_players@l(10)
	bl PutClientInServer
	lis 11,.LC290@ha
	lis 9,level+200@ha
	la 11,.LC290@l(11)
	lfs 0,level+200@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,2,.L679
	mr 3,30
	addi 31,30,4
	bl MoveClientToIntermission
	b .L680
.L679:
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	addi 28,30,4
	lwz 9,100(29)
	mr 31,28
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x6205
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,46533
	mtlr 10
	subf 3,3,30
	mullw 3,3,0
	srawi 3,3,2
	blrl
	lwz 9,100(29)
	li 3,9
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
.L680:
	lwz 5,84(30)
	lis 4,.LC289@ha
	li 3,2
	la 4,.LC289@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
	lwz 9,84(30)
	lis 0,0x4234
	mr 3,30
	stw 0,4428(9)
	bl RespawnExplosion
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,51
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,31
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,31
	li 4,1
	mtlr 0
	blrl
	mr 3,30
	bl ClientEndServerFrame
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 ClientBeginDeathmatch,.Lfe14-ClientBeginDeathmatch
	.section	".rodata"
	.align 2
.LC291:
	.long 0x0
	.align 2
.LC292:
	.long 0x47800000
	.align 2
.LC293:
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
	lis 0,0x6205
	lis 10,deathmatch@ha
	ori 0,0,46533
	lis 11,game+1028@ha
	subf 9,9,30
	lwz 8,game+1028@l(11)
	mullw 9,9,0
	lwz 11,deathmatch@l(10)
	lis 10,.LC291@ha
	srawi 9,9,2
	la 10,.LC291@l(10)
	mulli 9,9,4956
	lfs 31,0(10)
	addi 9,9,-4956
	add 8,8,9
	stw 8,84(30)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L682
	bl ClientBeginDeathmatch
	lis 9,theforce@ha
	lwz 11,theforce@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L681
	lwz 9,84(30)
	li 11,1
	stw 11,4612(9)
	lwz 9,84(30)
	lwz 0,4080(9)
	cmpwi 0,0,11
	bc 4,2,.L684
	mr 3,30
	bl watchmesing
	b .L681
.L684:
	cmpwi 0,0,12
	bc 4,2,.L686
	mr 3,30
	bl imabigchicken
	b .L681
.L686:
	cmpwi 0,0,13
	bc 4,2,.L688
	mr 3,30
	bl googl3
	b .L681
.L688:
	stw 11,4612(9)
	li 8,1
	lis 0,0x447a
	li 9,22
	li 10,4
	mtctr 9
.L708:
	lwz 9,84(30)
	addi 9,9,1856
	stwx 8,9,10
	lwz 11,84(30)
	addi 11,11,1984
	stwx 0,11,10
	addi 10,10,4
	bdnz .L708
	mr 3,30
	bl calc_subgroup_values
	mr 3,30
	bl calc_darklight_value
	mr 3,30
	bl calc_top_level_value
	lwz 9,84(30)
	lfs 1,1952(9)
	fadds 1,1,1
	bl ceil
	fctiwz 0,1
	lwz 11,84(30)
	mr 3,30
	stfd 0,16(1)
	lwz 9,20(1)
	sth 9,1948(11)
	bl sort_useable_powers
	b .L681
.L682:
	lwz 0,88(30)
	cmpwi 0,0,1
	bc 4,2,.L695
	lis 9,.LC292@ha
	lis 10,.LC293@ha
	li 11,3
	la 9,.LC292@l(9)
	la 10,.LC293@l(10)
	mtctr 11
	lfs 11,0(9)
	li 8,0
	lfs 12,0(10)
	addi 31,30,4
	li 7,0
.L707:
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
	bdnz .L707
	b .L701
.L695:
	mr 3,30
	bl G_InitEdict
	lwz 31,84(30)
	lis 9,.LC279@ha
	li 4,0
	la 9,.LC279@l(9)
	li 5,1976
	stw 9,280(30)
	addi 28,31,2108
	lwz 29,4048(31)
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	stw 29,4048(31)
	mr 3,28
	lwz 0,level@l(9)
	addi 4,31,188
	li 5,1920
	stw 0,4028(31)
	crxor 6,6,6
	bl memcpy
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L703
	lwz 0,4048(31)
	cmpwi 0,0,0
	bc 12,1,.L703
	mr 3,31
	bl CTFAssignTeam
.L703:
	mr 3,30
	addi 31,30,4
	bl PutClientInServer
.L701:
	lis 10,.LC291@ha
	lis 9,level+200@ha
	la 10,.LC291@l(10)
	lfs 0,level+200@l(9)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 12,2,.L704
	mr 3,30
	bl MoveClientToIntermission
	b .L705
.L704:
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L705
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x6205
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,46533
	mtlr 10
	subf 3,3,30
	mullw 3,3,0
	srawi 3,3,2
	blrl
	lwz 9,100(29)
	li 3,9
	mtlr 9
	blrl
	lwz 0,88(29)
	li 4,2
	mr 3,31
	mtlr 0
	blrl
	lwz 5,84(30)
	lis 4,.LC289@ha
	li 3,2
	la 4,.LC289@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
.L705:
	mr 3,30
	bl RespawnExplosion
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,51
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,31
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,31
	li 4,1
	mtlr 0
	blrl
	mr 3,30
	bl ClientEndServerFrame
.L681:
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
.LC294:
	.string	"\\name\\badinfo\\skin\\male/grunt"
	.align 2
.LC295:
	.string	"name"
	.align 2
.LC296:
	.string	"0"
	.align 2
.LC297:
	.string	"skin"
	.align 2
.LC298:
	.string	"%s\\%s"
	.align 2
.LC299:
	.string	"fov"
	.align 2
.LC300:
	.string	"hand"
	.align 2
.LC301:
	.long 0x0
	.align 3
.LC302:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC303:
	.long 0x3f800000
	.align 2
.LC304:
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
	bc 4,2,.L710
	lis 11,.LC294@ha
	lwz 0,.LC294@l(11)
	la 9,.LC294@l(11)
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
.L710:
	lis 4,.LC295@ha
	mr 3,30
	la 4,.LC295@l(4)
	bl Info_ValueForKey
	lwz 9,84(27)
	mr 31,3
	li 5,15
	mr 4,31
	addi 3,9,700
	bl strncpy
	lis 4,.LC264@ha
	mr 3,30
	la 4,.LC264@l(4)
	bl Info_ValueForKey
	lis 9,deathmatch@ha
	lis 10,.LC301@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC301@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L711
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L711
	lis 4,.LC296@ha
	la 4,.LC296@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L711
	lwz 9,84(27)
	li 0,1
	b .L721
.L711:
	lwz 9,84(27)
	li 0,0
.L721:
	stw 0,1788(9)
	lis 4,.LC297@ha
	mr 3,30
	la 4,.LC297@l(4)
	bl Info_ValueForKey
	lis 9,ctf@ha
	lis 11,g_edicts@ha
	lwz 10,ctf@l(9)
	mr 31,3
	lis 9,.LC301@ha
	lwz 0,g_edicts@l(11)
	la 9,.LC301@l(9)
	lfs 0,20(10)
	lfs 13,0(9)
	subf 0,0,27
	lis 9,0x6205
	ori 9,9,46533
	fcmpu 0,0,13
	mullw 0,0,9
	srawi 28,0,2
	bc 12,2,.L713
	mr 4,31
	mr 3,27
	bl CTFAssignSkin
	b .L714
.L713:
	lwz 4,84(27)
	lis 29,gi@ha
	lis 3,.LC298@ha
	la 29,gi@l(29)
	addi 28,28,1311
	addi 4,4,700
	la 3,.LC298@l(3)
	mr 5,31
	crxor 6,6,6
	bl va
	lwz 0,24(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
.L714:
	lwz 9,84(27)
	lhz 0,4426(9)
	cmpwi 0,0,0
	bc 12,2,.L722
	lis 4,.LC299@ha
	mr 3,30
	la 4,.LC299@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	lwz 11,84(27)
	stw 3,20(1)
	lis 0,0x4330
	lis 10,.LC302@ha
	la 10,.LC302@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC303@ha
	la 10,.LC303@l(10)
	lfs 12,0(10)
	fsub 0,0,13
	frsp 0,0
	stfs 0,112(11)
	lwz 9,84(27)
	lfs 0,112(9)
	fcmpu 0,0,12
	bc 4,0,.L717
.L722:
	lis 0,0x42b4
	stw 0,112(9)
	b .L716
.L717:
	lis 11,.LC304@ha
	la 11,.LC304@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L716
	stfs 13,112(9)
.L716:
	lis 4,.LC300@ha
	mr 3,30
	la 4,.LC300@l(4)
	bl Info_ValueForKey
	mr 31,3
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L720
	mr 3,31
	bl atoi
	lwz 9,84(27)
	stw 3,716(9)
.L720:
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
.Lfe16:
	.size	 ClientUserinfoChanged,.Lfe16-ClientUserinfoChanged
	.section	".rodata"
	.align 2
.LC305:
	.string	"ip"
	.align 2
.LC306:
	.string	"rejmsg"
	.align 2
.LC307:
	.string	"Banned."
	.align 2
.LC308:
	.string	"Spectator password required or incorrect."
	.align 2
.LC309:
	.string	"Password required or incorrect."
	.align 2
.LC310:
	.string	"%s connected\n"
	.align 2
.LC311:
	.long 0x0
	.align 3
.LC312:
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
	lis 4,.LC305@ha
	mr 3,27
	la 4,.LC305@l(4)
	bl Info_ValueForKey
	bl SV_FilterPacket
	cmpwi 0,3,0
	bc 12,2,.L724
	lis 4,.LC306@ha
	lis 5,.LC307@ha
	mr 3,27
	la 4,.LC306@l(4)
	la 5,.LC307@l(5)
	b .L756
.L724:
	lis 4,.LC264@ha
	mr 3,27
	la 4,.LC264@l(4)
	bl Info_ValueForKey
	lis 9,deathmatch@ha
	lis 10,.LC311@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC311@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L725
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L725
	lis 4,.LC296@ha
	la 4,.LC296@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L725
	lis 29,spectator_password@ha
	lwz 9,spectator_password@l(29)
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L726
	lis 4,.LC265@ha
	la 4,.LC265@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L726
	lwz 9,spectator_password@l(29)
	mr 4,31
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L726
	lis 4,.LC306@ha
	lis 5,.LC308@ha
	mr 3,27
	la 4,.LC306@l(4)
	la 5,.LC308@l(5)
	b .L756
.L726:
	lis 9,maxclients@ha
	lis 10,.LC311@ha
	lwz 11,maxclients@l(9)
	la 10,.LC311@l(10)
	li 8,0
	lfs 0,0(10)
	li 7,0
	lfs 13,20(11)
	fcmpu 0,0,13
	bc 4,0,.L728
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC312@ha
	la 9,.LC312@l(9)
	addi 10,11,1076
	lfd 13,0(9)
.L730:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L729
	lwz 11,84(10)
	addi 9,8,1
	lwz 0,1788(11)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L729:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,1076
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L730
.L728:
	xoris 0,8,0x8000
	lis 11,0x4330
	stw 0,20(1)
	lis 10,.LC312@ha
	la 10,.LC312@l(10)
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
	bc 4,3,.L734
	lis 4,.LC306@ha
	lis 5,.LC268@ha
	mr 3,27
	la 4,.LC306@l(4)
	la 5,.LC268@l(5)
	b .L756
.L725:
	lis 4,.LC269@ha
	mr 3,27
	la 4,.LC269@l(4)
	lis 29,password@ha
	bl Info_ValueForKey
	lwz 9,password@l(29)
	mr 31,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L734
	lis 4,.LC265@ha
	la 4,.LC265@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L734
	lwz 9,password@l(29)
	mr 4,31
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L734
	lis 4,.LC306@ha
	lis 5,.LC309@ha
	mr 3,27
	la 4,.LC306@l(4)
	la 5,.LC309@l(5)
.L756:
	bl Info_SetValueForKey
	li 3,0
	b .L754
.L734:
	lis 11,g_edicts@ha
	lis 0,0x6205
	lwz 10,88(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,46533
	lis 11,game+1028@ha
	cmpwi 0,10,0
	subf 9,9,30
	lwz 8,game+1028@l(11)
	mullw 9,9,0
	srawi 9,9,2
	mulli 9,9,4956
	addi 9,9,-4956
	add 8,8,9
	stw 8,84(30)
	bc 4,2,.L736
	li 0,-1
	li 4,0
	stw 0,4048(8)
	li 5,1976
	lwz 31,84(30)
	addi 28,31,2108
	lwz 29,4048(31)
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	stw 29,4048(31)
	mr 3,28
	lwz 0,level@l(9)
	addi 4,31,188
	li 5,1920
	stw 0,4028(31)
	crxor 6,6,6
	bl memcpy
	lis 9,.LC311@ha
	lis 11,ctf@ha
	la 9,.LC311@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L738
	lwz 0,4048(31)
	cmpwi 0,0,0
	bc 12,1,.L738
	mr 3,31
	bl CTFAssignTeam
.L738:
	lis 9,game+1560@ha
	lwz 3,84(30)
	lwz 0,game+1560@l(9)
	cmpwi 0,0,0
	bc 12,2,.L740
	lwz 0,1764(3)
	cmpwi 0,0,0
	bc 4,2,.L736
.L740:
	bl InitClientPersistant
	lis 9,.LC311@ha
	lis 11,theforce@ha
	la 9,.LC311@l(9)
	lfs 13,0(9)
	lwz 9,theforce@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L736
	lwz 9,84(30)
	li 11,1
	stw 11,4612(9)
	lwz 9,84(30)
	lwz 0,4080(9)
	cmpwi 0,0,11
	bc 4,2,.L742
	mr 3,30
	bl watchmesing
	b .L736
.L742:
	cmpwi 0,0,12
	bc 4,2,.L744
	mr 3,30
	bl imabigchicken
	b .L736
.L744:
	cmpwi 0,0,13
	bc 4,2,.L746
	mr 3,30
	bl googl3
	b .L736
.L746:
	stw 11,4612(9)
	li 8,1
	lis 0,0x447a
	li 9,22
	li 10,4
	mtctr 9
.L755:
	lwz 9,84(30)
	addi 9,9,1856
	stwx 8,9,10
	lwz 11,84(30)
	addi 11,11,1984
	stwx 0,11,10
	addi 10,10,4
	bdnz .L755
	mr 3,30
	bl calc_subgroup_values
	mr 3,30
	bl calc_darklight_value
	mr 3,30
	bl calc_top_level_value
	lwz 9,84(30)
	lfs 1,1952(9)
	fadds 1,1,1
	bl ceil
	fctiwz 0,1
	lwz 11,84(30)
	mr 3,30
	stfd 0,16(1)
	lwz 9,20(1)
	sth 9,1948(11)
	bl sort_useable_powers
.L736:
	mr 4,27
	mr 3,30
	bl ClientUserinfoChanged
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L753
	lis 9,gi+4@ha
	lwz 4,84(30)
	lis 3,.LC310@ha
	lwz 0,gi+4@l(9)
	la 3,.LC310@l(3)
	addi 4,4,700
	mtlr 0
	crxor 6,6,6
	blrl
.L753:
	lwz 9,84(30)
	li 0,0
	li 11,1
	stw 0,184(30)
	li 3,1
	stw 11,720(9)
.L754:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe17:
	.size	 ClientConnect,.Lfe17-ClientConnect
	.section	".rodata"
	.align 2
.LC313:
	.string	"%s disconnected\n"
	.align 2
.LC314:
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
	bc 12,2,.L757
	lis 4,.LC313@ha
	addi 5,5,700
	la 4,.LC313@l(4)
	li 3,2
	crxor 6,6,6
	bl safe_bprintf
	lis 27,g_edicts@ha
	lis 28,0x6205
	mr 3,31
	ori 28,28,46533
	bl CTFDeadDropFlag
	mr 3,31
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
	lwz 3,g_edicts@l(27)
	lis 9,.LC314@ha
	li 0,0
	la 9,.LC314@l(9)
	lwz 11,84(31)
	lis 4,.LC23@ha
	stw 9,280(31)
	subf 3,3,31
	la 4,.LC23@l(4)
	stw 0,40(31)
	mullw 3,3,28
	stw 0,248(31)
	stw 0,88(31)
	srawi 3,3,2
	stw 0,720(11)
	addi 3,3,1311
	lwz 0,24(29)
	mtlr 0
	blrl
.L757:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 ClientDisconnect,.Lfe18-ClientDisconnect
	.section	".rodata"
	.align 2
.LC315:
	.string	"sv %3i:%i %i\n"
	.align 2
.LC316:
	.long 0x42be0000
	.align 2
.LC317:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Client_Check_Collide
	.type	 Client_Check_Collide,@function
Client_Check_Collide:
	stwu 1,-160(1)
	mflr 0
	stmw 28,144(1)
	stw 0,164(1)
	mr 31,3
	addi 4,1,32
	lwz 3,84(31)
	addi 5,1,48
	mr 30,4
	mr 28,5
	li 6,0
	addi 3,3,4252
	bl AngleVectors
	lwz 9,84(31)
	lwz 0,4448(9)
	cmpwi 0,0,100
	bc 4,1,.L782
	lis 9,.LC316@ha
	addi 29,31,4
	la 9,.LC316@l(9)
	addi 5,1,16
	lfs 1,0(9)
	mr 3,29
	mr 4,30
	bl VectorMA
	lis 9,gi+48@ha
	mr 4,29
	lwz 0,gi+48@l(9)
	addi 3,1,64
	addi 5,31,188
	li 9,-1
	addi 6,31,200
	addi 7,1,16
	mr 8,31
	mtlr 0
	blrl
	lis 9,.LC317@ha
	lfs 13,72(1)
	la 9,.LC317@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L782
	lwz 0,116(1)
	cmpwi 0,0,0
	bc 12,2,.L782
	addi 29,1,128
	mr 3,30
	mr 4,29
	bl VectorNormalize2
	li 0,1
	lwz 3,116(1)
	mr 8,29
	stw 0,12(1)
	mr 4,31
	mr 5,31
	stw 0,8(1)
	mr 6,30
	addi 7,1,76
	li 9,30
	li 10,1000
	bl T_Damage
.L782:
	lwz 9,84(31)
	lwz 0,4448(9)
	cmpwi 0,0,0
	bc 4,1,.L785
	lis 9,.LC316@ha
	addi 29,31,4
	la 9,.LC316@l(9)
	addi 5,1,16
	lfs 1,0(9)
	mr 3,29
	mr 4,28
	bl VectorMA
	lis 9,gi+48@ha
	mr 4,29
	lwz 0,gi+48@l(9)
	addi 3,1,64
	addi 5,31,188
	li 9,-1
	addi 6,31,200
	addi 7,1,16
	mr 8,31
	mtlr 0
	blrl
	lis 9,.LC317@ha
	lfs 13,72(1)
	la 9,.LC317@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L788
	lwz 0,116(1)
	cmpwi 0,0,0
	bc 12,2,.L788
	addi 29,1,128
	mr 3,30
	mr 4,29
	bl VectorNormalize2
	li 0,1
	mr 4,31
	lwz 3,116(1)
	stw 0,12(1)
	mr 6,28
	mr 8,29
	stw 0,8(1)
	mr 5,4
	addi 7,1,76
	li 9,30
	li 10,1000
	bl T_Damage
	b .L788
.L785:
	bc 4,0,.L788
	lis 9,.LC316@ha
	addi 29,31,4
	la 9,.LC316@l(9)
	addi 5,1,16
	lfs 1,0(9)
	mr 3,29
	mr 4,28
	bl VectorMA
	lfs 12,48(1)
	lis 9,gi+48@ha
	mr 4,29
	lfs 13,52(1)
	addi 3,1,64
	addi 5,31,188
	lfs 0,56(1)
	addi 6,31,200
	addi 7,1,16
	lwz 0,gi+48@l(9)
	fneg 12,12
	mr 8,31
	fneg 13,13
	li 9,-1
	fneg 0,0
	mtlr 0
	stfs 12,48(1)
	stfs 13,52(1)
	stfs 0,56(1)
	blrl
	lis 9,.LC317@ha
	lfs 13,72(1)
	la 9,.LC317@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L788
	lwz 0,116(1)
	cmpwi 0,0,0
	bc 12,2,.L788
	addi 29,1,128
	mr 3,28
	mr 4,29
	bl VectorNormalize2
	li 0,1
	mr 4,31
	lwz 3,116(1)
	stw 0,12(1)
	mr 6,28
	mr 8,29
	stw 0,8(1)
	mr 5,4
	addi 7,1,76
	li 9,30
	li 10,1000
	bl T_Damage
.L788:
	lwz 0,164(1)
	mtlr 0
	lmw 28,144(1)
	la 1,160(1)
	blr
.Lfe19:
	.size	 Client_Check_Collide,.Lfe19-Client_Check_Collide
	.section	".rodata"
	.align 2
.LC318:
	.string	"weapon_saber"
	.align 2
.LC328:
	.string	"force/jump.wav"
	.align 2
.LC329:
	.string	"*jump1.wav"
	.align 3
.LC319:
	.long 0x3f768000
	.long 0x0
	.align 2
.LC320:
	.long 0x46fffe00
	.align 2
.LC321:
	.long 0x3e99999a
	.align 2
.LC322:
	.long 0x3e4ccccd
	.align 3
.LC323:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC324:
	.long 0x3dcccccd
	.align 3
.LC325:
	.long 0x408f4000
	.long 0x0
	.align 3
.LC326:
	.long 0x3fd33333
	.long 0x33333333
	.align 2
.LC327:
	.long 0x3f19999a
	.align 2
.LC330:
	.long 0x0
	.align 3
.LC331:
	.long 0x40140000
	.long 0x0
	.align 3
.LC332:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC333:
	.long 0x42c80000
	.align 2
.LC334:
	.long 0x42480000
	.align 2
.LC335:
	.long 0x44160000
	.align 2
.LC336:
	.long 0x3f000000
	.align 3
.LC337:
	.long 0x3ff80000
	.long 0x0
	.align 2
.LC338:
	.long 0x3f800000
	.align 2
.LC339:
	.long 0x40800000
	.align 2
.LC340:
	.long 0x41000000
	.align 2
.LC341:
	.long 0x42b40000
	.align 2
.LC342:
	.long 0x41200000
	.align 2
.LC343:
	.long 0xbf800000
	.align 2
.LC344:
	.long 0x42b60000
	.align 2
.LC345:
	.long 0x43340000
	.align 2
.LC346:
	.long 0x3c800000
	.align 2
.LC347:
	.long 0x3d000000
	.align 2
.LC348:
	.long 0xc2b60000
	.align 2
.LC349:
	.long 0x41c00000
	.align 3
.LC350:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC351:
	.long 0x3fc00000
	.long 0x0
	.align 2
.LC352:
	.long 0x40a00000
	.align 3
.LC353:
	.long 0x40240000
	.long 0x0
	.align 2
.LC354:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl ClientThink
	.type	 ClientThink,@function
ClientThink:
	stwu 1,-544(1)
	mflr 0
	mfcr 12
	stfd 31,536(1)
	stmw 18,480(1)
	stw 0,548(1)
	stw 12,476(1)
	mr 31,3
	lis 9,level+292@ha
	stw 31,level+292@l(9)
	mr 25,4
	lwz 27,84(31)
	lwz 3,1764(27)
	cmpwi 0,3,0
	bc 12,2,.L795
	lwz 3,0(3)
	b .L796
.L795:
	lis 9,.LC23@ha
	la 3,.LC23@l(9)
.L796:
	lis 4,.LC318@ha
	la 4,.LC318@l(4)
	bl strcmp
	lhz 0,946(31)
	subfic 4,3,0
	adde 21,4,3
	andi. 5,0,128
	bc 12,2,.L799
	andi. 0,0,65407
	li 26,1
	sth 0,946(31)
	b .L800
.L799:
	li 26,0
.L800:
	li 4,3
	mr 3,31
	bl Force_constant_active
	li 30,1
	xori 3,3,255
	li 4,6
	addic 0,3,-1
	subfe 29,0,3
	mr 3,31
	bl Force_constant_active
	xori 3,3,255
	li 4,5
	addic 0,3,-1
	subfe 22,0,3
	mr 3,31
	bl Force_constant_active
	xori 3,3,255
	li 4,10
	addic 0,3,-1
	subfe 19,0,3
	mr 3,31
	bl Force_constant_active
	cmpwi 0,3,255
	bc 4,2,.L807
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,4464(11)
	fcmpu 0,0,13
	bc 4,0,.L807
	li 30,0
.L807:
	mr 3,31
	bl force_frame
	lis 9,level@ha
	lis 3,.LC330@ha
	la 3,.LC330@l(3)
	la 9,level@l(9)
	lfs 13,0(3)
	lfs 0,200(9)
	fcmpu 0,0,13
	bc 12,2,.L809
	li 0,4
	lis 4,.LC331@ha
	stw 0,0(27)
	la 4,.LC331@l(4)
	lfs 0,200(9)
	lfd 12,0(4)
	lfs 13,4(9)
	fadd 0,0,12
	fcmpu 0,13,0
	bc 4,1,.L794
	lbz 0,1(25)
	andi. 5,0,128
	bc 12,2,.L794
	li 0,1
	stw 0,208(9)
	b .L794
.L809:
	lwz 9,84(31)
	lis 11,pm_passent@ha
	stw 31,pm_passent@l(11)
	lwz 0,4408(9)
	cmpwi 0,0,0
	bc 12,2,.L811
	lha 0,2(25)
	lis 8,0x4330
	lis 9,.LC332@ha
	mr 10,11
	xoris 0,0,0x8000
	la 9,.LC332@l(9)
	stw 0,468(1)
	lis 18,maxclients@ha
	stw 8,464(1)
	lfd 12,0(9)
	lfd 0,464(1)
	lis 9,.LC319@ha
	lfd 13,.LC319@l(9)
	mr 9,11
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,4036(27)
	lha 0,4(25)
	xoris 0,0,0x8000
	stw 0,468(1)
	stw 8,464(1)
	lfd 0,464(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,4040(27)
	lha 0,6(25)
	xoris 0,0,0x8000
	stw 0,468(1)
	stw 8,464(1)
	lfd 0,464(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,4044(27)
	b .L812
.L811:
	addi 3,1,8
	li 4,0
	mr 23,3
	li 5,240
	crxor 6,6,6
	bl memset
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L819
	lwz 0,40(31)
	xori 11,30,1
	xori 0,0,255
	addic 3,0,-1
	subfe 9,3,0
	and. 4,9,11
	bc 12,2,.L815
	lwz 9,84(31)
	lwz 0,4740(9)
	andi. 5,0,4
	li 0,3
	bc 12,2,.L819
.L815:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L817
	li 0,2
	b .L819
.L817:
	lwz 9,84(31)
	lhz 0,4426(9)
	cmpwi 0,0,0
	bc 12,2,.L819
	li 0,4
.L819:
	stw 0,0(27)
	cmpwi 4,29,0
	bc 4,18,.L822
	lwz 9,84(31)
	lwz 0,4740(9)
	andi. 8,0,4
	bc 12,2,.L821
.L822:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,468(1)
	lis 10,.LC320@ha
	lis 4,.LC333@ha
	lis 3,.LC332@ha
	stw 0,464(1)
	lis 5,.LC334@ha
	la 3,.LC332@l(3)
	lfd 0,464(1)
	la 4,.LC333@l(4)
	lfd 11,0(3)
	la 5,.LC334@l(5)
	mr 9,11
	lfs 13,.LC320@l(10)
	lfs 9,0(4)
	fsub 0,0,11
	lfs 10,0(5)
	frsp 0,0
	fdivs 0,0,13
	fmsubs 0,0,9,10
	fmr 13,0
	fctiwz 12,13
	stfd 12,464(1)
	b .L992
.L821:
	cmpwi 0,22,0
	bc 12,2,.L824
	lis 8,.LC335@ha
	lfs 13,2008(9)
	la 8,.LC335@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	bc 4,1,.L825
	lis 10,sv_gravity@ha
	lis 9,.LC336@ha
	lwz 11,sv_gravity@l(10)
	la 9,.LC336@l(9)
	lfs 12,0(9)
	lfs 0,20(11)
	fmuls 0,0,12
	b .L993
.L825:
	lis 10,.LC333@ha
	la 10,.LC333@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,1,.L823
	lis 11,.LC337@ha
	lis 10,sv_gravity@ha
	la 11,.LC337@l(11)
	lfd 12,0(11)
	lwz 11,sv_gravity@l(10)
	lfs 0,20(11)
	fdiv 0,0,12
.L993:
	fctiwz 13,0
	stfd 13,464(1)
.L992:
	lwz 9,468(1)
	sth 9,18(27)
	b .L823
.L824:
	lwz 0,4848(9)
	cmpwi 0,0,1
	bc 4,2,.L829
	sth 22,18(27)
	b .L823
.L829:
	lis 10,sv_gravity@ha
	lwz 9,sv_gravity@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,464(1)
	lwz 11,468(1)
	sth 11,18(27)
.L823:
	lwz 0,0(27)
	lwz 9,4(27)
	lwz 11,8(27)
	lwz 10,12(27)
	stw 0,8(1)
	stw 9,4(23)
	stw 11,8(23)
	stw 10,12(23)
	lwz 0,16(27)
	lwz 9,20(27)
	lwz 11,24(27)
	lwz 30,84(31)
	stw 0,16(23)
	stw 9,20(23)
	stw 11,24(23)
	lwz 0,4740(30)
	andi. 4,0,4
	bc 12,2,.L831
	lha 0,8(25)
	li 10,0
	lis 28,gi+48@ha
	addi 3,1,328
	addi 4,31,4
	stw 0,4448(30)
	addi 5,31,188
	addi 6,31,200
	lwz 29,84(31)
	addi 7,1,280
	mr 8,31
	lha 0,10(25)
	li 9,3
	stw 0,4452(29)
	lwz 11,84(31)
	lha 0,12(25)
	stw 0,4444(11)
	sth 10,12(25)
	sth 10,8(25)
	sth 10,10(25)
	lfs 0,12(31)
	lfs 13,4(31)
	lfs 12,8(31)
	lwz 11,84(31)
	stfs 0,288(1)
	stfs 13,280(1)
	stfs 12,284(1)
	lfs 13,4744(11)
	lwz 0,gi+48@l(28)
	fsubs 0,0,13
	mtlr 0
	stfs 0,288(1)
	blrl
	lis 3,.LC338@ha
	lfs 13,336(1)
	la 3,.LC338@l(3)
	lfs 0,0(3)
	fcmpu 0,13,0
	bc 4,2,.L833
	lwz 9,84(31)
	lis 4,.LC330@ha
	la 4,.LC330@l(4)
	lfs 13,0(4)
	lfs 0,4748(9)
	fcmpu 0,0,13
	bc 4,1,.L832
.L833:
	bl rand
	rlwinm 3,3,0,17,31
	lwz 8,84(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	lfs 11,348(1)
	stw 3,468(1)
	lis 10,.LC320@ha
	lis 4,.LC339@ha
	lis 3,.LC332@ha
	stw 0,464(1)
	la 4,.LC339@l(4)
	la 3,.LC332@l(3)
	lfd 0,464(1)
	lis 5,.LC340@ha
	lfd 10,0(3)
	la 5,.LC340@l(5)
	mr 9,11
	lfs 9,.LC320@l(10)
	lfs 13,4744(8)
	fsub 0,0,10
	lfs 8,0(4)
	lfs 7,0(5)
	fadds 11,11,13
	frsp 0,0
	fdivs 0,0,9
	fmadds 0,0,8,11
	fmuls 0,0,7
	fmr 13,0
	fctiwz 12,13
	b .L994
.L832:
	lis 9,sv_gravity@ha
	lis 8,.LC333@ha
	lfs 0,12(31)
	lwz 11,sv_gravity@l(9)
	la 8,.LC333@l(8)
	lfs 10,0(8)
	lis 9,.LC340@ha
	lfs 13,20(11)
	la 9,.LC340@l(9)
	lfs 11,0(9)
	fdivs 13,13,10
	fsubs 0,0,13
	fmuls 0,0,11
	fctiwz 12,0
.L994:
	stfd 12,464(1)
	lwz 9,468(1)
	sth 9,16(1)
	addi 30,1,296
	addi 29,1,312
	addi 3,27,4252
	mr 4,30
	mr 5,29
	li 6,0
	bl AngleVectors
	lwz 9,84(31)
	lwz 0,4448(9)
	cmpwi 0,0,0
	bc 12,1,.L836
	lwz 0,4452(9)
	addi 24,27,4084
	addi 26,1,36
	lis 18,maxclients@ha
	cmpwi 0,0,0
	bc 12,2,.L835
.L836:
	lis 8,.LC340@ha
	lis 3,.LC332@ha
	la 8,.LC340@l(8)
	la 3,.LC332@l(3)
	lfs 8,0(8)
	mr 4,30
	mr 5,29
	lfd 9,0(3)
	addi 24,27,4084
	addi 26,1,36
	lis 18,maxclients@ha
	lis 30,0x4330
	addi 3,1,18
	li 28,0
	li 29,2
.L840:
	lwz 10,84(31)
	addic. 29,29,-1
	mr 7,8
	lfsx 10,28,5
	mr 6,8
	lwz 0,4452(10)
	lwz 9,4448(10)
	srwi 11,0,31
	lfsx 11,28,4
	xoris 9,9,0x8000
	add 0,0,11
	stw 9,468(1)
	srawi 0,0,1
	addi 28,28,4
	stw 30,464(1)
	xoris 0,0,0x8000
	lfd 13,464(1)
	stw 0,468(1)
	stw 30,464(1)
	lfd 0,464(1)
	fsub 13,13,9
	fsub 0,0,9
	frsp 13,13
	frsp 0,0
	fmuls 0,0,10
	fmadds 13,13,11,0
	fmuls 13,13,8
	fmr 0,13
	fctiwz 12,0
	stfd 12,464(1)
	lwz 6,468(1)
	sth 6,0(3)
	addi 3,3,2
	bc 4,2,.L840
.L835:
	lwz 9,84(31)
	lwz 0,4448(9)
	cmpwi 0,0,0
	bc 4,0,.L843
	li 0,0
	sth 0,20(1)
	sth 0,18(1)
	b .L843
.L831:
	lhz 0,4426(30)
	cmpwi 0,0,0
	bc 12,2,.L844
	lis 3,.LC340@ha
	lfs 0,4(31)
	la 3,.LC340@l(3)
	lfs 13,8(31)
	mr 10,6
	lfs 6,0(3)
	mr 7,6
	mr 8,6
	lfs 11,12(31)
	mr 11,6
	lis 0,0x51eb
	lfs 12,384(31)
	ori 0,0,34079
	lis 5,0x4330
	fmuls 0,0,6
	lha 9,8(25)
	lis 3,.LC332@ha
	fmuls 13,13,6
	la 3,.LC332@l(3)
	sth 4,20(1)
	fmuls 11,11,6
	mulhw 0,9,0
	lfd 5,0(3)
	srawi 9,9,31
	sth 4,18(1)
	srawi 0,0,6
	lis 4,.LC341@ha
	fmuls 12,12,6
	subf 0,9,0
	la 4,.LC341@l(4)
	fctiwz 9,0
	extsh 0,0
	lfs 6,0(4)
	xoris 0,0,0x8000
	fctiwz 8,13
	stfd 9,464(1)
	lwz 6,468(1)
	fctiwz 7,11
	stfd 8,464(1)
	lwz 7,468(1)
	fctiwz 10,12
	stfd 7,464(1)
	lwz 8,468(1)
	stfd 10,464(1)
	lwz 11,468(1)
	stw 0,468(1)
	stw 5,464(1)
	lfd 0,464(1)
	sth 6,12(1)
	sth 7,14(1)
	fsub 0,0,5
	sth 8,16(1)
	sth 11,22(1)
	lfs 13,4428(30)
	frsp 0,0
	fsubs 13,13,0
	stfs 13,4428(30)
	lwz 9,84(31)
	lfs 0,4428(9)
	fcmpu 0,0,6
	bc 4,1,.L845
	stfs 6,4428(9)
	b .L846
.L845:
	lis 5,.LC342@ha
	la 5,.LC342@l(5)
	lfs 13,0(5)
	fcmpu 0,0,13
	bc 4,0,.L846
	stfs 13,4428(9)
.L846:
	lha 0,8(25)
	cmpwi 0,0,0
	bc 12,2,.L848
	lwz 0,972(31)
	cmpwi 0,0,0
	bc 4,2,.L848
	lwz 9,84(31)
	lfs 0,4428(9)
	stfs 0,112(9)
.L848:
	lwz 9,84(31)
	li 0,0
	addi 24,27,4084
	addi 26,1,36
	lis 18,maxclients@ha
	stw 0,4448(9)
	sth 0,12(25)
	sth 0,18(1)
	sth 0,20(1)
	sth 0,22(1)
	sth 0,8(25)
	sth 0,10(25)
	b .L843
.L844:
	cmpwi 0,26,0
	bc 12,2,.L852
	sth 0,22(1)
	addi 24,27,4084
	addi 26,1,36
	sth 0,18(1)
	lis 18,maxclients@ha
	sth 0,20(1)
	b .L843
.L852:
	lis 9,coolgrav@ha
	lis 8,.LC330@ha
	lwz 11,coolgrav@l(9)
	la 8,.LC330@l(8)
	lfs 31,0(8)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L854
	lfs 0,4888(30)
	fcmpu 0,0,31
	bc 12,2,.L855
	addi 4,30,4852
	addi 3,30,4864
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L857
	lwz 11,84(31)
	mr 8,10
	mr 7,10
	lfs 0,4852(11)
	stfs 0,4864(11)
	lwz 9,84(31)
	lfs 0,4856(9)
	stfs 0,4868(9)
	lwz 11,84(31)
	lfs 0,4860(11)
	stfs 0,4872(11)
	lwz 9,84(31)
	lfs 0,4864(9)
	fctiwz 13,0
	stfd 13,464(1)
	lwz 10,468(1)
	sth 10,2(25)
	lwz 9,84(31)
	lfs 0,4868(9)
	fctiwz 12,0
	stfd 12,464(1)
	lwz 8,468(1)
	sth 8,4(25)
	lwz 9,84(31)
	lfs 0,4872(9)
	fctiwz 11,0
	stfd 11,464(1)
	lwz 7,468(1)
	sth 7,6(25)
.L857:
	lha 0,8(25)
	addi 26,1,264
	addi 30,1,424
	stfs 31,264(1)
	cmpwi 0,0,0
	stfs 31,272(1)
	stfs 31,268(1)
	bc 12,2,.L858
	lfs 12,4(31)
	lis 8,.LC332@ha
	li 6,0
	lfs 13,8(31)
	la 8,.LC332@l(8)
	mr 3,26
	lfs 0,12(31)
	mr 4,30
	li 5,0
	lfd 31,0(8)
	lis 29,0x4330
	stfs 12,392(1)
	stfs 13,396(1)
	stfs 0,400(1)
	bl AngleVectors
	lha 0,8(25)
	mr 4,30
	addi 5,1,408
	addi 3,1,392
	xoris 0,0,0x8000
	stw 0,468(1)
	stw 29,464(1)
	lfd 1,464(1)
	fsub 1,1,31
	frsp 1,1
	bl VectorMA
	lha 0,18(1)
	lha 9,20(1)
	mr 8,11
	mr 7,11
	xoris 0,0,0x8000
	lfs 11,4(31)
	mr 6,11
	stw 0,468(1)
	xoris 9,9,0x8000
	mr 5,11
	stw 29,464(1)
	mr 4,11
	lfd 0,464(1)
	lfs 13,408(1)
	lha 10,22(1)
	stw 9,468(1)
	fsub 0,0,31
	stw 29,464(1)
	xoris 10,10,0x8000
	fsubs 11,11,13
	lfd 12,464(1)
	frsp 0,0
	stw 10,468(1)
	stw 29,464(1)
	lfd 13,464(1)
	fsub 12,12,31
	fadds 0,0,11
	lfs 10,8(31)
	lfs 11,12(31)
	lfs 7,412(1)
	fsub 13,13,31
	lfs 9,416(1)
	fmr 8,0
	frsp 12,12
	stfs 0,264(1)
	fsubs 10,10,7
	fsubs 11,11,9
	frsp 13,13
	fctiwz 6,8
	fadds 12,12,10
	fadds 13,13,11
	stfd 6,464(1)
	lwz 6,468(1)
	stfs 12,268(1)
	stfs 13,272(1)
	sth 6,8(28)
	lfs 0,268(1)
	fctiwz 5,0
	stfd 5,464(1)
	lwz 5,468(1)
	sth 5,10(28)
	lfs 0,272(1)
	fctiwz 4,0
	stfd 4,464(1)
	lwz 4,468(1)
	sth 4,12(28)
.L858:
	lha 0,10(25)
	cmpwi 0,0,0
	bc 12,2,.L859
	lfs 12,4(31)
	lis 8,.LC332@ha
	li 6,0
	lfs 13,8(31)
	la 8,.LC332@l(8)
	mr 3,26
	lfs 0,12(31)
	li 4,0
	mr 5,30
	lfd 31,0(8)
	lis 29,0x4330
	stfs 12,392(1)
	stfs 13,396(1)
	stfs 0,400(1)
	bl AngleVectors
	lha 0,8(25)
	mr 4,30
	addi 5,1,408
	addi 3,1,392
	xoris 0,0,0x8000
	stw 0,468(1)
	stw 29,464(1)
	lfd 1,464(1)
	fsub 1,1,31
	frsp 1,1
	bl VectorMA
	lha 0,18(1)
	lha 9,20(1)
	mr 8,11
	mr 7,11
	xoris 0,0,0x8000
	lfs 11,4(31)
	mr 6,11
	stw 0,468(1)
	xoris 9,9,0x8000
	mr 5,11
	stw 29,464(1)
	mr 4,11
	lfd 0,464(1)
	lfs 13,408(1)
	lha 10,22(1)
	stw 9,468(1)
	fsub 0,0,31
	stw 29,464(1)
	xoris 10,10,0x8000
	fsubs 11,11,13
	lfd 12,464(1)
	frsp 0,0
	stw 10,468(1)
	stw 29,464(1)
	lfd 13,464(1)
	fsub 12,12,31
	fadds 0,0,11
	lfs 10,8(31)
	lfs 11,12(31)
	lfs 7,412(1)
	fsub 13,13,31
	lfs 9,416(1)
	fmr 8,0
	frsp 12,12
	stfs 0,264(1)
	fsubs 10,10,7
	fsubs 11,11,9
	frsp 13,13
	fctiwz 6,8
	fadds 12,12,10
	fadds 13,13,11
	stfd 6,464(1)
	lwz 6,468(1)
	stfs 12,268(1)
	stfs 13,272(1)
	sth 6,8(28)
	lfs 0,268(1)
	fctiwz 5,0
	stfd 5,464(1)
	lwz 5,468(1)
	sth 5,10(28)
	lfs 0,272(1)
	fctiwz 4,0
	stfd 4,464(1)
	lwz 4,468(1)
	sth 4,12(28)
.L859:
	lwz 9,84(31)
	lis 3,.LC343@ha
	la 3,.LC343@l(3)
	lfs 0,0(3)
	lfs 13,4252(9)
	fcmpu 0,13,0
	bc 4,1,.L860
	lis 4,.LC344@ha
	la 4,.LC344@l(4)
	lfs 0,0(4)
	fcmpu 0,13,0
	bc 4,0,.L860
	lis 5,.LC341@ha
	lfs 0,4260(9)
	la 5,.LC341@l(5)
	lfs 13,0(5)
	fadds 0,0,13
	stfs 0,264(1)
	lfs 13,4256(9)
	stfs 13,268(1)
	b .L861
.L860:
	lwz 9,84(31)
	lis 8,.LC345@ha
	la 8,.LC345@l(8)
	lfs 13,0(8)
	lfs 0,4256(9)
	fcmpu 0,0,13
	bc 4,1,.L862
	fsubs 0,0,13
	b .L995
.L862:
	fadds 0,0,13
.L995:
	stfs 0,268(1)
.L861:
	lwz 9,84(31)
	mr 3,26
	mr 4,30
	lfs 11,4(31)
	li 5,0
	li 6,0
	lfs 0,4260(9)
	lfs 13,8(31)
	lfs 12,12(31)
	stfs 0,272(1)
	stfs 11,392(1)
	stfs 13,396(1)
	stfs 12,400(1)
	bl AngleVectors
	lbz 0,16(27)
	andi. 3,0,2
	bc 12,2,.L866
	lwz 11,552(31)
	cmpwi 0,11,0
	bc 12,2,.L864
	lwz 9,84(31)
	li 10,1
	lis 4,.LC346@ha
	la 4,.LC346@l(4)
	addi 3,1,392
	stw 10,4892(9)
	addi 5,1,408
	lbz 0,16(27)
	lfs 0,0(4)
	rlwinm 0,0,0,30,30
	mr 4,30
	stb 0,16(27)
	lwz 9,84(31)
	stw 10,4896(9)
	b .L996
.L864:
	lwz 9,84(31)
	lwz 0,4896(9)
	cmpwi 0,0,0
	bc 12,2,.L866
	li 0,1
	lis 4,.LC347@ha
	stw 0,4892(9)
	la 4,.LC347@l(4)
	addi 3,1,392
	lbz 0,16(27)
	addi 5,1,408
	lfs 0,0(4)
	rlwinm 0,0,0,30,30
	mr 4,30
	stb 0,16(27)
	lwz 9,84(31)
	stw 11,4896(9)
.L996:
	lwz 11,84(31)
	lfs 1,4888(11)
	fmuls 1,1,0
	bl VectorMA
	lha 0,18(1)
	lis 6,0x4330
	lis 3,.LC332@ha
	lha 9,20(1)
	mr 10,11
	xoris 0,0,0x8000
	la 3,.LC332@l(3)
	lha 8,22(1)
	stw 0,468(1)
	xoris 9,9,0x8000
	mr 7,11
	stw 6,464(1)
	xoris 8,8,0x8000
	mr 5,11
	lfd 9,0(3)
	mr 4,11
	lfd 0,464(1)
	mr 3,11
	stw 9,468(1)
	lfs 11,4(31)
	lfs 13,408(1)
	fsub 0,0,9
	stw 6,464(1)
	lfd 12,464(1)
	stw 8,468(1)
	fsubs 11,11,13
	stw 6,464(1)
	frsp 0,0
	lfd 13,464(1)
	fsub 12,12,9
	lfs 10,8(31)
	fadds 0,0,11
	lfs 7,412(1)
	fsub 13,13,9
	lfs 11,12(31)
	lfs 9,416(1)
	frsp 12,12
	fmr 8,0
	stfs 0,264(1)
	fsubs 10,10,7
	fsubs 11,11,9
	frsp 13,13
	fctiwz 6,8
	fadds 12,12,10
	fadds 13,13,11
	stfd 6,464(1)
	lwz 5,468(1)
	stfs 12,268(1)
	stfs 13,272(1)
	sth 5,8(28)
	lfs 0,268(1)
	fctiwz 5,0
	stfd 5,464(1)
	lwz 4,468(1)
	sth 4,10(28)
	lfs 0,272(1)
	fctiwz 4,0
	stfd 4,464(1)
	lwz 3,468(1)
	sth 3,12(28)
	b .L865
.L866:
	lwz 9,84(31)
	li 0,0
	stw 0,4892(9)
	lwz 11,84(31)
	stw 0,4896(11)
.L865:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 4,2,.L868
	lwz 9,84(31)
	lis 4,.LC348@ha
	la 4,.LC348@l(4)
	lfs 0,0(4)
	lfs 13,4252(9)
	fcmpu 0,13,0
	bc 4,1,.L869
	lis 5,.LC338@ha
	la 5,.LC338@l(5)
	lfs 0,0(5)
	fcmpu 0,13,0
	bc 4,0,.L869
	lis 8,.LC341@ha
	lfs 0,4260(9)
	la 8,.LC341@l(8)
	lfs 13,0(8)
	fsubs 0,0,13
	stfs 0,264(1)
	lfs 13,4256(9)
	stfs 13,268(1)
	b .L870
.L869:
	lwz 9,84(31)
	lis 10,.LC345@ha
	la 10,.LC345@l(10)
	lfs 13,0(10)
	lfs 0,4256(9)
	fcmpu 0,0,13
	bc 4,1,.L871
	fsubs 0,0,13
	b .L997
.L871:
	fadds 0,0,13
.L997:
	stfs 0,268(1)
.L870:
	lwz 9,84(31)
	lis 11,.LC349@ha
	mr 4,30
	la 11,.LC349@l(11)
	addi 3,1,392
	lfs 0,4260(9)
	addi 5,1,408
	lfs 13,0(11)
	stfs 0,272(1)
	lfs 1,4888(9)
	fdivs 1,1,13
	bl VectorMA
	lha 0,18(1)
	lis 6,0x4330
	lis 3,.LC332@ha
	lha 9,20(1)
	mr 10,11
	xoris 0,0,0x8000
	la 3,.LC332@l(3)
	lha 8,22(1)
	stw 0,468(1)
	xoris 9,9,0x8000
	mr 7,11
	stw 6,464(1)
	xoris 8,8,0x8000
	mr 5,11
	lfd 9,0(3)
	mr 4,11
	lfd 0,464(1)
	mr 3,11
	stw 9,468(1)
	lfs 11,4(31)
	lfs 13,408(1)
	fsub 0,0,9
	stw 6,464(1)
	lfd 12,464(1)
	stw 8,468(1)
	fsubs 11,11,13
	stw 6,464(1)
	frsp 0,0
	lfd 13,464(1)
	fsub 12,12,9
	lfs 10,8(31)
	fadds 0,0,11
	lfs 7,412(1)
	fsub 13,13,9
	lfs 11,12(31)
	lfs 9,416(1)
	frsp 12,12
	fmr 8,0
	stfs 0,264(1)
	fsubs 10,10,7
	fsubs 11,11,9
	frsp 13,13
	fctiwz 6,8
	fadds 12,12,10
	fadds 13,13,11
	stfd 6,464(1)
	lwz 5,468(1)
	stfs 12,268(1)
	stfs 13,272(1)
	sth 5,8(28)
	lfs 0,268(1)
	fctiwz 5,0
	stfd 5,464(1)
	lwz 4,468(1)
	sth 4,10(28)
	lfs 0,272(1)
	fctiwz 4,0
	stfd 4,464(1)
	lwz 3,468(1)
	sth 3,12(28)
.L868:
	lhz 0,8(28)
	li 9,3
	lis 8,.LC340@ha
	mtctr 9
	la 8,.LC340@l(8)
	addi 24,27,4084
	sth 0,8(25)
	addi 26,1,36
	lis 18,maxclients@ha
	lhz 0,10(28)
	addi 4,1,12
	addi 5,31,4
	lfs 10,0(8)
	addi 6,1,18
	addi 7,31,376
	sth 0,10(25)
	li 8,0
	li 10,0
	lhz 0,12(28)
	sth 0,12(25)
.L991:
	lfsx 13,8,5
	lfsx 0,8,7
	mr 9,11
	addi 8,8,4
	fmuls 13,13,10
	fmuls 0,0,10
	fctiwz 12,13
	fctiwz 11,0
	stfd 12,464(1)
	lwz 11,468(1)
	stfd 11,464(1)
	lwz 9,468(1)
	sthx 11,10,4
	sthx 9,10,6
	addi 10,10,2
	bdnz .L991
	b .L843
.L855:
	addi 24,27,4084
	addi 26,1,36
	lis 18,maxclients@ha
	bc 4,2,.L843
	lfs 0,4876(30)
	mr 10,11
	mr 8,11
	fctiwz 13,0
	stfd 13,464(1)
	lwz 11,468(1)
	sth 11,8(25)
	lwz 9,84(31)
	lfs 0,4880(9)
	fctiwz 12,0
	stfd 12,464(1)
	lwz 10,468(1)
	sth 10,10(25)
	lwz 9,84(31)
	lfs 0,4884(9)
	fctiwz 11,0
	stfd 11,464(1)
	lwz 8,468(1)
	sth 8,12(25)
	b .L843
.L854:
	li 11,3
	lis 10,.LC340@ha
	mtctr 11
	la 10,.LC340@l(10)
	addi 24,27,4084
	lfs 10,0(10)
	addi 26,1,36
	lis 18,maxclients@ha
	addi 4,1,12
	addi 5,31,4
	addi 6,1,18
	addi 7,31,376
	li 8,0
	li 10,0
.L990:
	lfsx 13,8,5
	lfsx 0,8,7
	mr 9,11
	addi 8,8,4
	fmuls 13,13,10
	fmuls 0,0,10
	fctiwz 12,13
	fctiwz 11,0
	stfd 12,464(1)
	lwz 11,468(1)
	stfd 11,464(1)
	lwz 9,468(1)
	sthx 11,10,4
	sthx 9,10,6
	addi 10,10,2
	bdnz .L990
	lhz 0,926(31)
	cmpwi 0,0,1
	bc 12,2,.L887
	lwz 9,84(31)
	lwz 0,4436(9)
	addic 3,0,-1
	subfe 11,3,0
	and. 4,11,21
	bc 12,2,.L843
.L887:
	lha 0,18(1)
	lis 6,0x4330
	lha 11,20(1)
	mr 8,9
	mr 7,9
	xoris 0,0,0x8000
	lha 10,22(1)
	lis 5,.LC332@ha
	stw 0,468(1)
	xoris 11,11,0x8000
	la 5,.LC332@l(5)
	stw 6,464(1)
	xoris 10,10,0x8000
	addi 3,1,248
	lfd 12,464(1)
	mr 4,3
	stw 11,468(1)
	stw 6,464(1)
	lfd 13,464(1)
	stw 10,468(1)
	stw 6,464(1)
	lfd 11,0(5)
	lfd 0,464(1)
	lis 5,.LC321@ha
	lfs 1,.LC321@l(5)
	fsub 12,12,11
	fsub 13,13,11
	fsub 0,0,11
	frsp 12,12
	frsp 13,13
	frsp 0,0
	stfs 12,248(1)
	stfs 13,252(1)
	stfs 0,256(1)
	bl VectorScale
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L843
	lfs 12,248(1)
	lfs 13,252(1)
	mr 9,10
	mr 11,10
	lfs 0,256(1)
	fctiwz 11,12
	fctiwz 9,13
	fctiwz 10,0
	stfd 11,464(1)
	lwz 10,468(1)
	stfd 9,464(1)
	lwz 9,468(1)
	stfd 10,464(1)
	lwz 11,468(1)
	sth 10,18(1)
	sth 9,20(1)
	sth 11,22(1)
.L843:
	mr 3,24
	addi 4,1,8
	li 5,28
	bl memcmp
	cmpwi 0,3,0
	bc 12,2,.L889
	lhz 9,926(31)
	li 0,1
	stw 0,52(1)
	cmpwi 0,9,1
	bc 12,2,.L891
	lwz 9,84(31)
	lwz 0,4436(9)
	addic 3,0,-1
	subfe 11,3,0
	and. 4,11,21
	bc 12,2,.L889
.L891:
	lha 0,18(1)
	lis 6,0x4330
	lha 11,20(1)
	mr 8,9
	mr 7,9
	xoris 0,0,0x8000
	lha 10,22(1)
	lis 5,.LC332@ha
	stw 0,468(1)
	xoris 11,11,0x8000
	la 5,.LC332@l(5)
	stw 6,464(1)
	xoris 10,10,0x8000
	addi 3,1,248
	lfd 12,464(1)
	mr 4,3
	stw 11,468(1)
	stw 6,464(1)
	lfd 13,464(1)
	stw 10,468(1)
	stw 6,464(1)
	lfd 11,0(5)
	lfd 0,464(1)
	lis 5,.LC322@ha
	lfs 1,.LC322@l(5)
	fsub 12,12,11
	fsub 13,13,11
	fsub 0,0,11
	frsp 12,12
	frsp 13,13
	frsp 0,0
	stfs 12,248(1)
	stfs 13,252(1)
	stfs 0,256(1)
	bl VectorScale
	lfs 12,248(1)
	lfs 13,252(1)
	mr 9,10
	mr 11,10
	lfs 0,256(1)
	fctiwz 11,12
	fctiwz 9,13
	fctiwz 10,0
	stfd 11,464(1)
	lwz 10,468(1)
	stfd 9,464(1)
	lwz 9,468(1)
	stfd 10,464(1)
	lwz 11,468(1)
	sth 10,18(1)
	sth 9,20(1)
	sth 11,22(1)
.L889:
	lwz 9,84(31)
	lwz 0,4828(9)
	cmpwi 0,0,0
	bc 12,2,.L892
	lis 3,.LC350@ha
	li 4,3
	la 3,.LC350@l(3)
	mtctr 4
	addi 10,1,18
	lfd 12,0(3)
	addi 11,31,376
.L989:
	lfs 0,0(11)
	addi 11,11,4
	fmul 0,0,12
	fctiwz 13,0
	stfd 13,464(1)
	lwz 9,468(1)
	sth 9,0(10)
	addi 10,10,2
	bdnz .L989
	lwz 11,84(31)
	lwz 9,4828(11)
	addi 9,9,-1
	stw 9,4828(11)
.L892:
	lwz 9,56(31)
	addi 0,9,-175
	addi 9,9,-369
	subfic 0,0,13
	li 0,0
	adde 0,0,0
	subfic 9,9,13
	li 9,0
	adde 9,9,9
	or. 5,9,0
	bc 12,2,.L898
	li 8,3
	lis 9,.LC323@ha
	mtctr 8
	lfd 12,.LC323@l(9)
	addi 10,1,18
	addi 11,31,376
.L988:
	lfs 0,0(11)
	addi 11,11,4
	fmul 0,0,12
	fctiwz 13,0
	stfd 13,464(1)
	lwz 9,468(1)
	sth 9,0(10)
	addi 10,10,2
	bdnz .L988
.L898:
	lis 9,gi@ha
	lwz 8,0(25)
	lis 11,PM_trace@ha
	la 28,gi@l(9)
	lwz 0,12(25)
	la 11,PM_trace@l(11)
	lwz 9,8(25)
	lwz 10,4(25)
	stw 8,36(1)
	stw 0,12(26)
	stw 10,4(26)
	stw 9,8(26)
	lwz 0,492(31)
	lwz 9,52(28)
	cmpwi 0,0,0
	stw 11,240(1)
	stw 9,244(1)
	bc 12,2,.L904
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L905
.L904:
	lwz 9,84(31)
	lwz 0,4740(9)
	andi. 26,0,4
	bc 12,2,.L906
	lwz 0,84(28)
	addi 3,1,8
	mtlr 0
	blrl
	b .L905
.L906:
	cmpwi 0,22,0
	bc 12,2,.L905
	lis 3,.LC333@ha
	lfs 13,2008(9)
	la 3,.LC333@l(3)
	lfs 0,0(3)
	fcmpu 0,13,0
	bc 4,1,.L909
	lwz 9,84(28)
	addi 3,1,8
	mtlr 9
	blrl
.L909:
	lwz 9,84(31)
	lis 3,.LC335@ha
	la 3,.LC335@l(3)
	lfs 13,0(3)
	lfs 0,2008(9)
	fcmpu 0,0,13
	bc 4,1,.L910
	lwz 9,84(28)
	addi 3,1,8
	mtlr 9
	blrl
.L910:
	lha 0,18(1)
	cmpwi 0,0,0
	bc 4,2,.L912
	lwz 0,20(1)
	cmpwi 0,0,0
	bc 12,2,.L905
.L912:
	lis 30,trailtime@ha
	lis 3,.LC330@ha
	lwz 9,trailtime@l(30)
	la 3,.LC330@l(3)
	lfs 0,0(3)
	lfs 13,20(9)
	fcmpu 0,13,0
	bc 12,2,.L905
	bl G_Spawn
	li 20,1
	lis 9,.LC324@ha
	mr 29,3
	lfs 1,.LC324@l(9)
	addi 3,31,376
	addi 4,1,440
	bl VectorScale
	lfs 0,440(1)
	lis 8,level+4@ha
	lis 11,G_FreeEdict@ha
	lfs 13,4(31)
	la 11,G_FreeEdict@l(11)
	mr 3,29
	lwz 10,trailtime@l(30)
	lwz 0,64(29)
	fsubs 13,13,0
	oris 0,0,0x1000
	stfs 13,4(29)
	lfs 13,444(1)
	lfs 0,8(31)
	fsubs 0,0,13
	stfs 0,8(29)
	lfs 0,448(1)
	lfs 13,12(31)
	fsubs 13,13,0
	stfs 13,12(29)
	lfs 0,16(31)
	stfs 0,16(29)
	lfs 13,20(31)
	stfs 13,20(29)
	lfs 0,24(31)
	stw 26,248(29)
	stw 0,64(29)
	stfs 0,24(29)
	stw 20,260(29)
	lwz 9,40(31)
	stw 31,256(29)
	stw 9,40(29)
	lwz 0,56(31)
	stw 0,56(29)
	lfs 0,level+4@l(8)
	lfs 13,20(10)
	stw 11,436(29)
	fadds 0,0,13
	stfs 0,428(29)
	lwz 0,72(28)
	mtlr 0
	blrl
.L905:
	lwz 9,84(31)
	lhz 0,4426(9)
	cmpwi 0,0,0
	bc 12,2,.L915
	li 0,0
	sth 0,22(1)
	sth 0,18(1)
	sth 0,20(1)
.L915:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L916
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L917
.L916:
	lis 9,gi+84@ha
	addi 3,1,8
	lwz 0,gi+84@l(9)
	mtlr 0
	blrl
.L917:
	lha 0,44(1)
	stw 0,4448(27)
	lha 9,46(1)
	stw 9,4452(27)
	lha 0,48(1)
	stw 0,4444(27)
	lwz 9,8(1)
	lwz 0,4(23)
	lwz 11,8(23)
	lwz 10,12(23)
	stw 9,0(27)
	stw 0,4(27)
	stw 11,8(27)
	stw 10,12(27)
	lwz 0,16(23)
	lwz 9,20(23)
	lwz 11,24(23)
	stw 0,16(27)
	stw 9,20(27)
	stw 11,24(27)
	lwz 0,8(1)
	lwz 9,4(23)
	lwz 11,8(23)
	lwz 10,12(23)
	stw 0,4084(27)
	stw 9,4(24)
	stw 11,8(24)
	stw 10,12(24)
	lwz 0,16(23)
	lwz 9,20(23)
	lwz 11,24(23)
	stw 0,16(24)
	stw 9,20(24)
	stw 11,24(24)
	lwz 9,84(31)
	lhz 0,4426(9)
	cmpwi 0,0,0
	bc 4,2,.L918
	li 9,3
	lis 4,.LC332@ha
	lis 5,.LC351@ha
	mtctr 9
	la 4,.LC332@l(4)
	la 5,.LC351@l(5)
	lfd 11,0(4)
	addi 30,31,4
	lfd 12,0(5)
	addi 3,1,12
	lis 6,0x4330
	addi 4,31,376
	addi 5,1,18
	li 7,0
	li 8,0
.L987:
	lhax 0,7,3
	lhax 9,7,5
	mr 10,11
	xoris 0,0,0x8000
	addi 7,7,2
	stw 0,468(1)
	xoris 9,9,0x8000
	stw 6,464(1)
	lfd 13,464(1)
	stw 9,468(1)
	stw 6,464(1)
	lfd 0,464(1)
	fsub 13,13,11
	fsub 0,0,11
	fmul 13,13,12
	fmul 0,0,12
	frsp 13,13
	frsp 0,0
	stfsx 13,8,30
	stfsx 0,8,4
	addi 8,8,4
	bdnz .L987
.L918:
	lfs 0,216(1)
	lis 8,0x4330
	lfs 13,220(1)
	lis 10,.LC332@ha
	lis 7,.LC319@ha
	lfs 8,204(1)
	la 10,.LC332@l(10)
	mr 11,9
	lfs 9,208(1)
	lfs 10,212(1)
	lfs 11,224(1)
	stfs 0,200(31)
	stfs 13,204(31)
	stfs 8,188(31)
	stfs 9,192(31)
	stfs 10,196(31)
	stfs 11,208(31)
	lha 0,2(25)
	lfd 12,0(10)
	xoris 0,0,0x8000
	lfd 13,.LC319@l(7)
	mr 10,9
	stw 0,468(1)
	stw 8,464(1)
	lfd 0,464(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,4036(27)
	lha 0,4(25)
	xoris 0,0,0x8000
	stw 0,468(1)
	stw 8,464(1)
	lfd 0,464(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,4040(27)
	lha 0,6(25)
	xoris 0,0,0x8000
	stw 0,468(1)
	stw 8,464(1)
	lfd 0,464(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,4044(27)
	lha 0,22(1)
	cmpwi 0,0,0
	bc 12,2,.L924
	lhz 0,976(31)
	neg 0,0
	srwi 0,0,31
	and. 11,0,19
	bc 12,2,.L924
	lis 30,trailtime@ha
	lis 3,.LC330@ha
	lwz 9,trailtime@l(30)
	la 3,.LC330@l(3)
	xori 11,20,1
	lfs 13,0(3)
	lfs 0,20(9)
	fcmpu 7,0,13
	crnor 31,30,30
	mfcr 0
	rlwinm 0,0,0,1
	and. 4,0,11
	bc 12,2,.L924
	bl G_Spawn
	lis 9,.LC324@ha
	mr 29,3
	lfs 1,.LC324@l(9)
	addi 3,31,376
	addi 4,1,440
	bl VectorScale
	lfs 0,440(1)
	li 9,1
	li 10,0
	lfs 13,4(31)
	lis 7,level+4@ha
	lis 11,G_FreeEdict@ha
	lwz 8,trailtime@l(30)
	la 11,G_FreeEdict@l(11)
	lis 6,gi+72@ha
	lwz 0,64(29)
	mr 3,29
	fsubs 13,13,0
	oris 0,0,0x1000
	stfs 13,4(29)
	lfs 13,444(1)
	lfs 0,8(31)
	fsubs 0,0,13
	stfs 0,8(29)
	lfs 0,448(1)
	lfs 13,12(31)
	fsubs 13,13,0
	stfs 13,12(29)
	lfs 0,16(31)
	stfs 0,16(29)
	lfs 13,20(31)
	stfs 13,20(29)
	lfs 0,24(31)
	stw 9,260(29)
	stw 10,248(29)
	stfs 0,24(29)
	stw 0,64(29)
	lwz 9,40(31)
	stw 31,256(29)
	stw 9,40(29)
	lwz 0,56(31)
	stw 0,56(29)
	lfs 0,level+4@l(7)
	lfs 13,20(8)
	stw 11,436(29)
	fadds 0,0,13
	stfs 0,428(29)
	lwz 0,gi+72@l(6)
	mtlr 0
	blrl
.L924:
	bc 12,18,.L927
	lwz 0,228(1)
	cmpwi 0,0,0
	bc 4,2,.L927
	lha 8,48(1)
	cmpwi 0,8,0
	bc 12,2,.L928
	lwz 0,236(1)
	cmpwi 0,0,0
	bc 4,2,.L935
	lwz 10,84(31)
	lis 9,.LC325@ha
	lis 11,.LC326@ha
	lfd 13,.LC325@l(9)
	lfs 0,1996(10)
	lfd 12,.LC326@l(11)
	fdiv 0,0,13
	frsp 11,0
	fmr 13,11
	fcmpu 0,13,12
	bc 4,0,.L929
	lis 9,.LC321@ha
	lfs 11,.LC321@l(9)
.L929:
	lis 0,0x51eb
	srawi 10,8,31
	lfs 12,384(31)
	ori 0,0,34079
	mulhw 0,8,0
	lis 11,0x4330
	lis 3,.LC332@ha
	la 3,.LC332@l(3)
	srawi 0,0,4
	lfd 13,0(3)
	subf 0,10,0
	extsh 0,0
	xoris 0,0,0x8000
	stw 0,468(1)
	stw 11,464(1)
	lfd 0,464(1)
	fsub 0,0,13
	frsp 0,0
	fmadds 0,0,11,12
	stfs 0,384(31)
	b .L935
.L928:
	lwz 0,236(1)
	cmpwi 0,0,0
	bc 4,2,.L935
	lis 4,.LC330@ha
	lfs 13,384(31)
	la 4,.LC330@l(4)
	lfs 0,0(4)
	fcmpu 0,13,0
	bc 4,1,.L932
	lis 5,.LC352@ha
	la 5,.LC352@l(5)
	lfs 0,0(5)
	fsubs 0,13,0
	stfs 0,384(31)
	b .L935
.L932:
	bc 4,0,.L935
	lis 8,.LC352@ha
	la 8,.LC352@l(8)
	lfs 0,0(8)
	fadds 0,13,0
	stfs 0,384(31)
	b .L935
.L927:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L935
	lwz 0,228(1)
	cmpwi 0,0,0
	bc 4,2,.L935
	lha 0,48(1)
	cmpwi 0,0,9
	bc 4,1,.L935
	lwz 0,236(1)
	cmpwi 0,0,0
	bc 4,2,.L935
	cmpwi 0,19,0
	bc 12,2,.L937
	lwz 9,84(31)
	lwz 0,4796(9)
	cmpwi 0,0,0
	bc 4,2,.L938
	lis 9,.LC327@ha
	li 4,0
	lfs 1,.LC327@l(9)
	mr 3,31
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC328@ha
	la 29,gi@l(29)
	la 3,.LC328@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC338@ha
	lis 9,.LC338@ha
	lis 10,.LC330@ha
	mr 5,3
	la 8,.LC338@l(8)
	la 9,.LC338@l(9)
	mtlr 0
	la 10,.LC330@l(10)
	li 4,3
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	b .L939
.L938:
	cmpwi 0,0,2
	bc 4,2,.L939
	lis 9,.LC327@ha
	li 4,2
	lfs 1,.LC327@l(9)
	mr 3,31
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC328@ha
	la 29,gi@l(29)
	la 3,.LC328@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC338@ha
	lis 9,.LC338@ha
	lis 10,.LC330@ha
	mr 5,3
	la 8,.LC338@l(8)
	la 9,.LC338@l(9)
	mtlr 0
	la 10,.LC330@l(10)
	li 4,3
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L939:
	li 0,1
	mr 3,31
	sth 0,976(31)
	li 4,5
	bl Drain_Force_Pool
	lha 0,22(1)
	cmpwi 0,0,0
	bc 12,2,.L941
	lis 30,trailtime@ha
	lis 3,.LC330@ha
	lwz 9,trailtime@l(30)
	la 3,.LC330@l(3)
	xori 11,20,1
	lfs 13,0(3)
	lfs 0,20(9)
	fcmpu 7,0,13
	crnor 31,30,30
	mfcr 0
	rlwinm 0,0,0,1
	and. 4,0,11
	bc 12,2,.L941
	bl G_Spawn
	lis 9,.LC324@ha
	mr 29,3
	lfs 1,.LC324@l(9)
	addi 3,31,376
	addi 4,1,440
	bl VectorScale
	lfs 0,440(1)
	li 9,1
	li 10,0
	lfs 13,4(31)
	lis 7,level+4@ha
	lis 11,G_FreeEdict@ha
	lwz 8,trailtime@l(30)
	la 11,G_FreeEdict@l(11)
	lis 6,gi+72@ha
	lwz 0,64(29)
	mr 3,29
	fsubs 13,13,0
	oris 0,0,0x1000
	stfs 13,4(29)
	lfs 13,444(1)
	lfs 0,8(31)
	fsubs 0,0,13
	stfs 0,8(29)
	lfs 0,448(1)
	lfs 13,12(31)
	fsubs 13,13,0
	stfs 13,12(29)
	lfs 0,16(31)
	stfs 0,16(29)
	lfs 13,20(31)
	stfs 13,20(29)
	lfs 0,24(31)
	stw 9,260(29)
	stw 10,248(29)
	stfs 0,24(29)
	stw 0,64(29)
	lwz 9,40(31)
	stw 31,256(29)
	stw 9,40(29)
	lwz 0,56(31)
	stw 0,56(29)
	lfs 0,level+4@l(7)
	lfs 13,20(8)
	stw 11,436(29)
	fadds 0,0,13
	stfs 0,428(29)
	lwz 0,gi+72@l(6)
	mtlr 0
	blrl
.L941:
	lwz 9,84(31)
	lis 3,.LC353@ha
	lis 4,.LC354@ha
	la 3,.LC353@l(3)
	la 4,.LC354@l(4)
	lfs 12,384(31)
	lfs 0,2004(9)
	lfd 13,0(3)
	lfs 11,0(4)
	fdiv 0,0,13
	frsp 0,0
	fmadds 0,0,11,12
	stfs 0,384(31)
	b .L944
.L937:
	lis 29,gi@ha
	lis 3,.LC329@ha
	la 29,gi@l(29)
	la 3,.LC329@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC338@ha
	lis 9,.LC338@ha
	lis 10,.LC330@ha
	mr 5,3
	la 8,.LC338@l(8)
	la 9,.LC338@l(9)
	mtlr 0
	la 10,.LC330@l(10)
	li 4,2
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
.L944:
	mr 3,31
	addi 4,31,4
	li 5,0
	bl PlayerNoise
.L935:
	lfs 0,200(1)
	lwz 10,228(1)
	lwz 0,236(1)
	lwz 11,232(1)
	cmpwi 0,10,0
	stw 0,612(31)
	stw 11,608(31)
	fctiwz 13,0
	stw 10,552(31)
	stfd 13,464(1)
	lwz 9,468(1)
	stw 9,508(31)
	bc 12,2,.L945
	lwz 0,92(10)
	stw 0,556(31)
.L945:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L946
	lfs 0,4180(27)
	lis 0,0x4220
	lis 9,0xc170
	stw 0,36(27)
	stw 9,28(27)
	stfs 0,32(27)
	b .L947
.L946:
	lfs 12,188(1)
	lfs 13,192(1)
	lfs 0,196(1)
	stfs 12,440(1)
	stfs 13,444(1)
	stfs 0,448(1)
	lwz 0,4724(27)
	cmpwi 0,0,3
	bc 4,2,.L948
	lfs 0,4256(27)
	lwz 11,4728(27)
	fsubs 0,13,0
	stfs 0,984(11)
	lwz 9,4732(27)
	lfs 0,16(9)
	stfs 0,4252(27)
	lfs 13,20(9)
	stfs 13,4256(27)
	lfs 0,24(9)
	stfs 0,4260(27)
	b .L949
.L948:
	cmpwi 0,0,0
	bc 4,1,.L950
	lwz 9,4728(27)
	lfs 0,984(9)
	fsubs 0,13,0
	stfs 0,444(1)
	stfs 12,4252(27)
	lfs 0,444(1)
	stfs 0,4256(27)
	lfs 13,448(1)
	b .L998
.L950:
	stfs 12,4252(27)
	lfs 0,192(1)
	stfs 0,4256(27)
	lfs 13,196(1)
.L998:
	stfs 13,4260(27)
.L949:
	lfs 0,188(1)
	stfs 0,28(27)
	lfs 13,192(1)
	stfs 13,32(27)
	lfs 0,196(1)
	stfs 0,36(27)
.L947:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L952
	mr 3,31
	bl G_TouchTriggers
.L952:
	lwz 0,56(1)
	li 29,0
	cmpw 0,29,0
	bc 4,0,.L812
	addi 28,1,60
.L956:
	li 11,0
	slwi 0,29,2
	cmpw 0,11,29
	lwzx 3,28,0
	addi 30,29,1
	bc 4,0,.L958
	lwz 0,0(28)
	cmpw 0,0,3
	bc 12,2,.L958
	mr 9,28
.L959:
	addi 11,11,1
	cmpw 0,11,29
	bc 4,0,.L958
	lwzu 0,4(9)
	cmpw 0,0,3
	bc 4,2,.L959
.L958:
	cmpw 0,11,29
	bc 4,2,.L955
	lwz 0,444(3)
	cmpwi 0,0,0
	bc 12,2,.L955
	mr 4,31
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L955:
	lwz 0,56(1)
	mr 29,30
	cmpw 0,29,0
	bc 12,0,.L956
.L812:
	lwz 0,4132(27)
	lwz 11,4140(27)
	stw 0,4136(27)
	lbz 9,1(25)
	andc 0,9,0
	stw 9,4132(27)
	or 11,11,0
	stw 11,4140(27)
	lbz 0,15(25)
	stw 0,640(31)
	lwz 9,4140(27)
	andi. 0,9,1
	bc 12,2,.L966
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L966
	lwz 0,4076(27)
	cmpwi 0,0,0
	bc 12,2,.L967
	lwz 0,4408(27)
	li 9,0
	stw 9,4140(27)
	cmpwi 0,0,0
	bc 12,2,.L968
	lbz 0,16(27)
	stw 9,4408(27)
	andi. 0,0,191
	stb 0,16(27)
	b .L966
.L968:
	mr 3,31
	bl GetChaseTarget
	b .L966
.L967:
	lhz 0,926(31)
	cmpwi 0,0,0
	bc 4,2,.L971
	lwz 9,84(31)
	lhz 0,4716(9)
	cmpwi 0,0,2
	bc 4,2,.L971
	mr 3,31
	bl weapon_menu_use
	lwz 9,84(31)
	lwz 0,1764(9)
	cmpw 0,0,3
	bc 12,2,.L972
	mr 3,31
	bl weapon_menu_use
	lwz 9,84(31)
	lis 11,level+4@ha
	stw 3,4148(9)
	lfs 0,level+4@l(11)
	lwz 9,84(31)
	stfs 0,4476(9)
.L972:
	lis 9,level+4@ha
	lwz 11,84(31)
	lfs 0,level+4@l(9)
	stfs 0,4476(11)
	b .L966
.L971:
	lwz 0,4144(27)
	cmpwi 0,0,0
	bc 4,2,.L966
	li 0,1
	mr 3,31
	stw 0,4144(27)
	li 4,0
	bl Think_Weapon
.L966:
	lwz 0,4076(27)
	cmpwi 0,0,0
	bc 12,2,.L975
	lha 0,12(25)
	cmpwi 0,0,9
	bc 4,1,.L976
	lbz 0,16(27)
	andi. 3,0,2
	bc 4,2,.L975
	lwz 9,4408(27)
	ori 0,0,2
	stb 0,16(27)
	cmpwi 0,9,0
	bc 12,2,.L978
	mr 3,31
	bl ChaseNext
	b .L975
.L978:
	mr 3,31
	bl GetChaseTarget
	b .L975
.L976:
	lbz 0,16(27)
	andi. 0,0,253
	stb 0,16(27)
.L975:
	lis 9,maxclients@ha
	lis 3,.LC338@ha
	lwz 11,maxclients@l(9)
	la 3,.LC338@l(3)
	li 29,1
	lfs 13,0(3)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L794
	lis 4,.LC332@ha
	lis 27,g_edicts@ha
	la 4,.LC332@l(4)
	lis 28,0x4330
	lfd 31,0(4)
	li 30,1076
.L984:
	lwz 0,g_edicts@l(27)
	add 3,0,30
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L983
	lwz 9,84(3)
	lwz 0,4408(9)
	cmpw 0,0,31
	bc 4,2,.L983
	bl UpdateChaseCam
.L983:
	addi 29,29,1
	lwz 11,maxclients@l(18)
	xoris 0,29,0x8000
	addi 30,30,1076
	stw 0,468(1)
	stw 28,464(1)
	lfd 0,464(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L984
.L794:
	lwz 0,548(1)
	lwz 12,476(1)
	mtlr 0
	lmw 18,480(1)
	lfd 31,536(1)
	mtcrf 8,12
	la 1,544(1)
	blr
.Lfe20:
	.size	 ClientThink,.Lfe20-ClientThink
	.section	".rodata"
	.align 2
.LC355:
	.long 0x0
	.align 2
.LC356:
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
	lis 9,level@ha
	lis 11,.LC355@ha
	la 11,.LC355@l(11)
	la 8,level@l(9)
	lfs 13,0(11)
	mr 30,3
	lfs 0,200(8)
	fcmpu 0,0,13
	bc 4,2,.L999
	lis 9,deathmatch@ha
	lwz 31,84(30)
	lwz 11,deathmatch@l(9)
	mr 10,31
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L1001
	lwz 9,1788(31)
	lwz 0,4076(31)
	cmpw 0,9,0
	bc 12,2,.L1001
	lfs 0,4(8)
	lis 9,.LC356@ha
	lfs 13,4404(31)
	la 9,.LC356@l(9)
	lfs 12,0(9)
	fsubs 0,0,13
	fcmpu 0,0,12
	cror 3,2,1
	bc 4,3,.L1001
	bl spectator_respawn
	b .L999
.L1001:
	lwz 0,972(30)
	cmpwi 0,0,0
	bc 4,2,.L1002
	lwz 0,916(30)
	cmpwi 0,0,0
	bc 4,2,.L1003
	lwz 0,116(10)
	andi. 9,0,1
	bc 12,2,.L1002
.L1003:
	mr 3,30
	bl Fog_Update
.L1002:
	lwz 0,4076(31)
	cmpwi 0,0,0
	bc 4,2,.L1004
	lwz 0,4612(31)
	cmpwi 0,0,0
	bc 12,2,.L1004
	mr 3,30
	bl Think_Force
.L1004:
	lwz 0,4144(31)
	cmpwi 0,0,0
	bc 4,2,.L1005
	lwz 0,4076(31)
	cmpwi 0,0,0
	bc 4,2,.L1005
	mr 3,30
	li 4,0
	bl Think_Weapon
	b .L1006
.L1005:
	li 0,0
	stw 0,4144(31)
.L1006:
	lwz 29,492(30)
	cmpwi 0,29,0
	bc 12,2,.L1007
	lis 9,level+4@ha
	lfs 13,4404(31)
	lfs 0,level+4@l(9)
	fcmpu 0,0,13
	bc 4,1,.L999
	lis 9,.LC355@ha
	lis 11,deathmatch@ha
	lwz 10,4140(31)
	la 9,.LC355@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 7,0,13
	mfcr 0
	rlwinm 0,0,31,1
	neg 0,0
	ori 0,0,1
	and. 11,10,0
	bc 4,2,.L1012
	bc 12,30,.L999
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,1024
	bc 12,2,.L999
.L1012:
	lwz 0,972(30)
	cmpwi 0,0,0
	bc 12,2,.L1013
	mr 3,30
	bl Bot_respawn
	b .L1014
.L1013:
	mr 3,30
	bl respawn
.L1014:
	li 0,0
	stw 0,4140(31)
	b .L999
.L1007:
	lis 11,.LC355@ha
	lis 9,path_time@ha
	la 11,.LC355@l(11)
	lfs 0,path_time@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,2,.L1015
	mr 3,30
	bl make_node
.L1015:
	stw 29,4140(31)
.L999:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe21:
	.size	 ClientBeginServerFrame,.Lfe21-ClientBeginServerFrame
	.section	".rodata"
	.align 2
.LC358:
	.string	"models/objects/shockwave/tris.md2"
	.align 2
.LC359:
	.string	"respawn_effect"
	.comm	node_count,2,2
	.comm	path_not_time_yet,4,4
	.align 2
.LC363:
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
	lis 9,.LC363@ha
	lwz 5,coop@l(11)
	li 7,0
	la 9,.LC363@l(9)
	addi 10,10,1076
	lfs 13,0(9)
.L469:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L468
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
	rlwinm 0,0,0,26,27
	stw 0,732(9)
	lfs 0,20(5)
	fcmpu 0,0,13
	bc 12,2,.L468
	lwz 9,84(10)
	lwz 11,1028(8)
	lwz 0,4032(9)
	add 11,7,11
	stw 0,1776(11)
.L468:
	lwz 0,1544(3)
	addi 6,6,1
	addi 7,7,4956
	addi 10,10,1076
	cmpw 0,6,0
	bc 12,0,.L469
	blr
.Lfe22:
	.size	 SaveClientData,.Lfe22-SaveClientData
	.section	".rodata"
	.align 2
.LC364:
	.long 0x0
	.section	".text"
	.align 2
	.globl FetchClientEntData
	.type	 FetchClientEntData,@function
FetchClientEntData:
	lis 9,.LC364@ha
	lwz 7,84(3)
	lis 10,coop@ha
	la 9,.LC364@l(9)
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
	lwz 0,1776(7)
	stw 0,4032(7)
	blr
.Lfe23:
	.size	 FetchClientEntData,.Lfe23-FetchClientEntData
	.comm	conversation_content,7760,4
	.comm	highlighted,4,4
	.comm	yeah_you,4,4
	.comm	its_me,4,4
	.comm	holdthephone,4,4
	.comm	NoTouch,4,4
	.comm	showingit,4,4
	.comm	path_time,4,4
	.comm	print_time,4,4
	.comm	players,1024,4
	.section	".rodata"
	.align 2
.LC365:
	.long 0x3dcccccd
	.section	".text"
	.align 2
	.globl spawn_ghost
	.type	 spawn_ghost,@function
spawn_ghost:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 28,3
	bl G_Spawn
	lis 9,.LC365@ha
	mr 29,3
	lfs 1,.LC365@l(9)
	addi 3,28,376
	addi 4,1,8
	bl VectorScale
	lfs 0,8(1)
	lis 9,trailtime@ha
	li 10,1
	lfs 13,4(28)
	li 8,0
	lis 6,level+4@ha
	lwz 7,trailtime@l(9)
	lis 11,G_FreeEdict@ha
	lis 5,gi+72@ha
	lwz 0,64(29)
	la 11,G_FreeEdict@l(11)
	mr 3,29
	fsubs 13,13,0
	oris 0,0,0x1000
	stfs 13,4(29)
	lfs 13,12(1)
	lfs 0,8(28)
	fsubs 0,0,13
	stfs 0,8(29)
	lfs 0,16(1)
	lfs 13,12(28)
	fsubs 13,13,0
	stfs 13,12(29)
	lfs 0,16(28)
	stfs 0,16(29)
	lfs 13,20(28)
	stfs 13,20(29)
	lfs 0,24(28)
	stw 10,260(29)
	stw 8,248(29)
	stfs 0,24(29)
	stw 0,64(29)
	lwz 9,40(28)
	stw 28,256(29)
	stw 9,40(29)
	lwz 0,56(28)
	stw 0,56(29)
	lfs 0,level+4@l(6)
	lfs 13,20(7)
	stw 11,436(29)
	fadds 0,0,13
	stfs 0,428(29)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe24:
	.size	 spawn_ghost,.Lfe24-spawn_ghost
	.section	".rodata"
	.align 3
.LC366:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC367:
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
	lis 11,.LC367@ha
	lis 9,coop@ha
	la 11,.LC367@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L19
	lis 3,level+72@ha
	lis 4,.LC2@ha
	la 3,level+72@l(3)
	la 4,.LC2@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L19
	lis 9,SP_CreateCoopSpots@ha
	lis 10,level+4@ha
	la 9,SP_CreateCoopSpots@l(9)
	lis 11,.LC366@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC366@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L19:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe25:
	.size	 SP_info_player_start,.Lfe25-SP_info_player_start
	.section	".rodata"
	.align 2
.LC368:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_player_deathmatch
	.type	 SP_info_player_deathmatch,@function
SP_info_player_deathmatch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC368@ha
	lis 9,deathmatch@ha
	la 11,.LC368@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L23
	bl G_FreeEdict
	b .L22
.L23:
	bl SP_misc_teleporter_dest
.L22:
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
	.globl player_pain
	.type	 player_pain,@function
player_pain:
	blr
.Lfe28:
	.size	 player_pain,.Lfe28-player_pain
	.align 2
	.globl IsFemale
	.type	 IsFemale,@function
IsFemale:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L31
	lis 4,.LC22@ha
	addi 3,3,188
	la 4,.LC22@l(4)
	bl Info_ValueForKey
	lbz 3,0(3)
	xori 0,3,70
	subfic 9,0,0
	adde 0,9,0
	xori 3,3,102
	subfic 9,3,0
	adde 3,9,3
	or 3,3,0
	b .L1027
.L31:
	li 3,0
.L1027:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe29:
	.size	 IsFemale,.Lfe29-IsFemale
	.align 2
	.globl IsNeutral
	.type	 IsNeutral,@function
IsNeutral:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L35
	lis 4,.LC22@ha
	addi 3,3,188
	la 4,.LC22@l(4)
	bl Info_ValueForKey
	lbz 11,0(3)
	xori 9,11,102
	xori 0,11,70
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 10,9,0
	bc 12,2,.L35
	cmpwi 0,11,109
	bc 12,2,.L35
	cmpwi 0,11,77
	li 3,1
	bc 4,2,.L1028
.L35:
	li 3,0
.L1028:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe30:
	.size	 IsNeutral,.Lfe30-IsNeutral
	.section	".rodata"
	.align 2
.LC369:
	.long 0x0
	.section	".text"
	.align 2
	.globl TossClientWeapon
	.type	 TossClientWeapon,@function
TossClientWeapon:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC369@ha
	lis 9,deathmatch@ha
	la 11,.LC369@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L390
	lwz 10,84(3)
	lwz 0,4128(10)
	addi 11,10,740
	lwz 4,1764(10)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L392
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 10,10,1792
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 11,10,9
	srawi 9,11,31
	xor 0,9,11
	subf 0,0,9
	srawi 0,0,31
	and 4,4,0
.L392:
	cmpwi 0,4,0
	bc 12,2,.L390
	bl Drop_Item
	lis 0,0x2
	stw 0,284(3)
.L390:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe31:
	.size	 TossClientWeapon,.Lfe31-TossClientWeapon
	.section	".rodata"
	.align 2
.LC370:
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
	addi 28,31,2108
	lwz 29,4048(31)
	li 5,1976
	mr 3,28
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	stw 29,4048(31)
	mr 3,28
	lwz 0,level@l(9)
	addi 4,31,188
	li 5,1920
	stw 0,4028(31)
	crxor 6,6,6
	bl memcpy
	lis 9,.LC370@ha
	lis 11,ctf@ha
	la 9,.LC370@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L464
	lwz 0,4048(31)
	cmpwi 0,0,0
	bc 12,1,.L464
	mr 3,31
	bl CTFAssignTeam
.L464:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe32:
	.size	 InitClientResp,.Lfe32-InitClientResp
	.section	".rodata"
	.align 2
.LC371:
	.long 0x4b18967f
	.align 2
.LC372:
	.long 0x3f800000
	.align 3
.LC373:
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
	lis 11,.LC372@ha
	lwz 10,maxclients@l(9)
	la 11,.LC372@l(11)
	mr 31,3
	lfs 13,0(11)
	li 29,1
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC371@ha
	lfs 31,.LC371@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L477
	lis 9,.LC373@ha
	lis 27,g_edicts@ha
	la 9,.LC373@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,1076
.L479:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L478
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L478
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
	bc 4,0,.L478
	fmr 31,1
.L478:
	addi 29,29,1
	lwz 11,maxclients@l(26)
	xoris 0,29,0x8000
	addi 30,30,1076
	stw 0,36(1)
	stw 28,32(1)
	lfd 0,32(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L479
.L477:
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
	bc 4,2,.L528
	bl SelectRandomDeathmatchSpawnPoint
	b .L1030
.L528:
	bl SelectFarthestDeathmatchSpawnPoint
.L1030:
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
	lis 9,0x692b
	lwz 10,game+1028@l(11)
	ori 9,9,12007
	li 30,0
	li 3,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,2
	bc 12,2,.L1031
.L534:
	lis 5,.LC3@ha
	mr 3,30
	la 5,.LC3@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L535
	li 3,0
	b .L1031
.L535:
	lwz 4,300(30)
	cmpwi 0,4,0
	bc 4,2,.L536
	lis 9,.LC23@ha
	la 4,.LC23@l(9)
.L536:
	lis 3,game+1032@ha
	la 3,game+1032@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L534
	addic. 31,31,-1
	bc 4,2,.L534
	mr 3,30
.L1031:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe35:
	.size	 SelectCoopSpawnPoint,.Lfe35-SelectCoopSpawnPoint
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
	lis 11,.LC258@ha
	stw 0,level+296@l(9)
	li 31,8
	la 30,.LC258@l(11)
.L577:
	bl G_Spawn
	addic. 31,31,-1
	stw 30,280(3)
	bc 4,2,.L577
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe36:
	.size	 InitBodyQue,.Lfe36-InitBodyQue
	.align 2
	.globl body_die
	.type	 body_die,@function
body_die:
	lwz 0,480(3)
	cmpwi 0,0,-40
	bclr 4,0
	li 0,0
	stw 0,512(3)
	blr
.Lfe37:
	.size	 body_die,.Lfe37-body_die
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
	bc 4,1,.L760
	lis 11,gi+48@ha
	lis 9,0x201
	lwz 0,gi+48@l(11)
	ori 9,9,3
	mtlr 0
	blrl
	b .L759
.L760:
	lis 11,gi+48@ha
	lis 9,0x1
	lwz 0,gi+48@l(11)
	mr 3,31
	ori 9,9,3
	mtlr 0
	blrl
.L759:
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
	bc 4,0,.L764
.L766:
	lbzx 0,3,9
	addi 9,9,1
	cmpw 0,9,4
	add 11,11,0
	bc 12,0,.L766
.L764:
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
.L1033:
	lbzx 0,3,9
	addi 9,9,1
	add 5,5,0
	bdnz .L1033
	li 0,16
	lbz 4,42(3)
	li 6,0
	mtctr 0
	addi 3,3,28
	li 9,0
.L1032:
	lbzx 0,3,9
	addi 9,9,1
	add 6,6,0
	bdnz .L1032
	lis 3,.LC315@ha
	la 3,.LC315@l(3)
	crxor 6,6,6
	bl Com_Printf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe40:
	.size	 PrintPmove,.Lfe40-PrintPmove
	.align 2
	.globl set_fov
	.type	 set_fov,@function
set_fov:
	lwz 0,972(3)
	cmpwi 0,0,0
	bclr 4,2
	lwz 9,84(3)
	lfs 0,4428(9)
	stfs 0,112(9)
	blr
.Lfe41:
	.size	 set_fov,.Lfe41-set_fov
	.section	".rodata"
	.align 2
.LC374:
	.long 0x3ca3d70a
	.section	".text"
	.align 2
	.globl RespawnExplosion
	.type	 RespawnExplosion,@function
RespawnExplosion:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 28,3
	bl G_Spawn
	lis 11,.LC374@ha
	lis 9,chicken@ha
	lfs 0,.LC374@l(11)
	mr 29,3
	la 9,chicken@l(9)
	lis 27,gi@ha
	stw 9,436(29)
	lis 3,.LC358@ha
	la 27,gi@l(27)
	la 3,.LC358@l(3)
	stfs 0,428(29)
	lwz 9,32(27)
	mtlr 9
	blrl
	stw 3,40(29)
	lis 9,.LC359@ha
	li 0,0
	lfs 13,4(28)
	la 9,.LC359@l(9)
	lis 11,0x1000
	li 10,8
	mr 3,29
	stfs 13,4(29)
	lfs 0,8(28)
	stfs 0,8(29)
	lfs 13,12(28)
	stfs 13,12(29)
	lfs 0,16(28)
	stfs 0,16(29)
	lfs 13,20(28)
	stfs 13,20(29)
	lfs 0,24(28)
	stw 28,540(29)
	stw 9,280(29)
	stfs 0,24(29)
	stw 0,56(29)
	stw 11,64(29)
	stw 10,68(29)
	stw 0,260(29)
	stw 0,248(29)
	stw 28,256(29)
	lwz 0,72(27)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe42:
	.size	 RespawnExplosion,.Lfe42-RespawnExplosion
	.section	".rodata"
	.align 2
.LC375:
	.long 0x3c23d70a
	.section	".text"
	.align 2
	.globl chicken
	.type	 chicken,@function
chicken:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 11,56(3)
	cmpwi 0,11,14
	bc 4,2,.L1018
	bl G_FreeEdict
	b .L1019
.L1018:
	lis 9,.LC375@ha
	addi 0,11,1
	lfs 0,.LC375@l(9)
	stw 0,56(3)
	stfs 0,428(3)
.L1019:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe43:
	.size	 chicken,.Lfe43-chicken
	.section	".rodata"
	.align 2
.LC376:
	.long 0x41400000
	.section	".text"
	.align 2
	.globl deadboy
	.type	 deadboy,@function
deadboy:
	lis 9,deadboy2@ha
	lis 11,level+4@ha
	la 9,deadboy2@l(9)
	stw 9,436(3)
	lis 9,.LC376@ha
	lfs 0,level+4@l(11)
	la 9,.LC376@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,428(3)
	blr
.Lfe44:
	.size	 deadboy,.Lfe44-deadboy
	.section	".rodata"
	.align 3
.LC377:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC378:
	.long 0x3f800000
	.align 2
.LC379:
	.long 0x41100000
	.section	".text"
	.align 2
	.globl deadboy2
	.type	 deadboy2,@function
deadboy2:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,.LC378@ha
	lfs 13,12(3)
	la 9,.LC378@l(9)
	lfs 0,1028(3)
	lfs 11,0(9)
	lis 9,.LC379@ha
	la 9,.LC379@l(9)
	lfs 12,0(9)
	fsubs 13,13,11
	fsubs 0,0,12
	stfs 13,12(3)
	fcmpu 0,0,13
	bc 4,1,.L1022
	li 0,0
	lis 9,gi+76@ha
	stw 0,40(3)
	lwz 0,gi+76@l(9)
	mtlr 0
	blrl
	b .L1023
.L1022:
	lis 9,level+4@ha
	lis 11,.LC377@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC377@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
.L1023:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe45:
	.size	 deadboy2,.Lfe45-deadboy2
	.section	".rodata"
	.align 3
.LC380:
	.long 0x3f847ae1
	.long 0x47ae147b
	.section	".text"
	.align 2
	.globl ddc
	.type	 ddc,@function
ddc:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,972(31)
	cmpwi 0,0,0
	bc 4,2,.L1025
	lwz 9,84(31)
	lwz 3,4732(9)
	bl CopyToBodyQue
	lis 0,0x1000
	stw 0,64(31)
	b .L1026
.L1025:
	mr 3,31
	bl CopyToBodyQue
	lis 9,Bot_AI_Think@ha
	lis 10,level+4@ha
	la 9,Bot_AI_Think@l(9)
	lis 11,.LC380@ha
	stw 9,436(31)
	lis 8,0x1000
	li 0,3
	lfs 0,level+4@l(10)
	lfd 13,.LC380@l(11)
	stw 0,492(31)
	stw 8,64(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L1026:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe46:
	.size	 ddc,.Lfe46-ddc
	.section	".rodata"
	.align 2
.LC381:
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
	lis 9,.LC381@ha
	mr 30,3
	la 9,.LC381@l(9)
	li 31,0
	lfs 31,0(9)
	lis 29,.LC1@ha
.L10:
	mr 3,31
	li 4,280
	la 5,.LC1@l(29)
	bl G_Find
	mr. 31,3
	bc 12,2,.L7
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L10
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
	bc 4,0,.L10
	lwz 3,300(30)
	cmpwi 0,3,0
	bc 12,2,.L15
	lwz 4,300(31)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L7
.L15:
	lwz 0,300(31)
	stw 0,300(30)
.L7:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe47:
	.size	 SP_FixCoopSpots,.Lfe47-SP_FixCoopSpots
	.align 2
	.type	 SP_CreateCoopSpots,@function
SP_CreateCoopSpots:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 3,level+72@ha
	lis 4,.LC2@ha
	la 3,level+72@l(3)
	la 4,.LC2@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L18
	bl G_Spawn
	lis 26,0xc324
	lis 25,0x42a0
	lis 29,.LC3@ha
	lis 28,.LC4@ha
	stw 26,8(3)
	la 29,.LC3@l(29)
	la 28,.LC4@l(28)
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
.L18:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe48:
	.size	 SP_CreateCoopSpots,.Lfe48-SP_CreateCoopSpots
	.comm	pm_passent,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
