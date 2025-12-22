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
	.string	"%s"
	.align 2
.LC23:
	.string	"frags/killstreak2.wav"
	.align 2
.LC24:
	.string	"frags/killstreak3.wav"
	.align 2
.LC25:
	.string	"frags/killstreak4.wav"
	.align 2
.LC26:
	.string	"frags/killstreak5.wav"
	.align 2
.LC27:
	.string	"%s (%i kills)"
	.align 2
.LC28:
	.string	"frags/killstreak6.wav"
	.align 2
.LC29:
	.string	""
	.align 2
.LC30:
	.string	"suicides"
	.align 2
.LC31:
	.string	"cratered"
	.align 2
.LC32:
	.string	"was squished"
	.align 2
.LC33:
	.string	"sank like a rock"
	.align 2
.LC34:
	.string	"melted"
	.align 2
.LC35:
	.string	"does a back flip into the lava"
	.align 2
.LC36:
	.string	"blew up"
	.align 2
.LC37:
	.string	"found a way out"
	.align 2
.LC38:
	.string	"saw the light"
	.align 2
.LC39:
	.string	"got blasted"
	.align 2
.LC40:
	.string	"was in the wrong place"
	.align 2
.LC41:
	.string	"tried to put the pin back in"
	.align 2
.LC42:
	.string	"tripped on its own grenade"
	.align 2
.LC43:
	.string	"tripped on her own grenade"
	.align 2
.LC44:
	.string	"tripped on his own grenade"
	.align 2
.LC45:
	.string	"blew itself up"
	.align 2
.LC46:
	.string	"blew herself up"
	.align 2
.LC47:
	.string	"blew himself up"
	.align 2
.LC48:
	.string	"should have used a smaller gun"
	.align 2
.LC49:
	.string	"killed itself"
	.align 2
.LC50:
	.string	"killed herself"
	.align 2
.LC51:
	.string	"killed himself"
	.align 2
.LC52:
	.string	"%s %s.\n"
	.align 2
.LC53:
	.string	" was blasted by"
	.align 2
.LC54:
	.string	" had his left arm blasted off by"
	.align 2
.LC55:
	.string	" was shot in the leg by"
	.align 2
.LC56:
	.string	"'s blaster"
	.align 2
.LC57:
	.string	" was taught to hop by"
	.align 2
.LC58:
	.string	" from behind"
	.align 2
.LC59:
	.string	" was blasted in the face by"
	.align 2
.LC60:
	.string	" took a blaster bolt to the head from"
	.align 2
.LC61:
	.string	" was gunned down by"
	.align 2
.LC62:
	.string	" lost an arm to"
	.align 2
.LC63:
	.string	" lost a leg to"
	.align 2
.LC64:
	.string	" was gunned down in the back by"
	.align 2
.LC65:
	.string	" was made really pretty by"
	.align 2
.LC66:
	.string	"'s shotgun"
	.align 2
.LC67:
	.string	" lost a chunk of his head by"
	.align 2
.LC68:
	.string	" was blown away by"
	.align 2
.LC69:
	.string	"'s super shotgun"
	.align 2
.LC70:
	.string	" was hit by "
	.align 2
.LC71:
	.string	"'s super shotgun pellets in the leg"
	.align 2
.LC72:
	.string	"'s super shotgun while trying to get away"
	.align 2
.LC73:
	.string	" shows his intestines to the world because of"
	.align 2
.LC74:
	.string	" now has a hole in his head because of"
	.align 2
.LC75:
	.string	" was shot in the arm by"
	.align 2
.LC76:
	.string	" was shot in leg the by"
	.align 2
.LC77:
	.string	" was shot by"
	.align 2
.LC78:
	.string	"in the back"
	.align 2
.LC79:
	.string	" saw"
	.align 2
.LC80:
	.string	"'s bullet really close"
	.align 2
.LC81:
	.string	" took a bullet to the brain"
	.align 2
.LC82:
	.string	" arm was hit by a bullet from"
	.align 2
.LC83:
	.string	"'s chaingun"
	.align 2
.LC84:
	.string	" lost his legs to"
	.align 2
.LC85:
	.string	"'s back was cut in half by"
	.align 2
.LC86:
	.string	" chest was cut in half by"
	.align 2
.LC87:
	.string	"'s face was cut in half by"
	.align 2
.LC88:
	.string	" head was cut in half by"
	.align 2
.LC89:
	.string	" was cut in half by"
	.align 2
.LC90:
	.string	"'s arm was popped by"
	.align 2
.LC91:
	.string	"'s grenade"
	.align 2
.LC92:
	.string	"'s arms were popped by"
	.align 2
.LC93:
	.string	" 's legs were popped by"
	.align 2
.LC94:
	.string	" 's back was popped by"
	.align 2
.LC95:
	.string	" 's chest was blown apart by"
	.align 2
.LC96:
	.string	" 's legs were popped off by"
	.align 2
.LC97:
	.string	" 's head was popped off by"
	.align 2
.LC98:
	.string	" was popped by"
	.align 2
.LC99:
	.string	" was shredded by"
	.align 2
.LC100:
	.string	"'s shrapnel"
	.align 2
.LC101:
	.string	" ate"
	.align 2
.LC102:
	.string	"'s rocket"
	.align 2
.LC103:
	.string	"'s arms where blown off"
	.align 2
.LC104:
	.string	"'s legs where blown off"
	.align 2
.LC105:
	.string	"'s rocket in the face!"
	.align 2
.LC106:
	.string	" was decapitated by"
	.align 2
.LC107:
	.string	" almost dodged"
	.align 2
.LC108:
	.string	" was shot up by "
	.align 2
.LC109:
	.string	" was machinegunned in the left arm by "
	.align 2
.LC110:
	.string	" was machinegunned in the right arm by "
	.align 2
.LC111:
	.string	" leg was ripped apart by "
	.align 2
.LC112:
	.string	"'s machinegun fire"
	.align 2
.LC113:
	.string	" right leg was ripped apart by "
	.align 2
.LC114:
	.string	" was mowed down from behind by "
	.align 2
.LC115:
	.string	" feels hot lead in the chest, courtesy of "
	.align 2
.LC116:
	.string	" was machinegunned in the face "
	.align 2
.LC117:
	.string	" head exploded by machinegun fire from "
	.align 2
.LC118:
	.string	" was sniped in the arm by"
	.align 2
.LC119:
	.string	" was sniped in leg the by"
	.align 2
.LC120:
	.string	" was sniped by"
	.align 2
.LC121:
	.string	" in the back"
	.align 2
.LC122:
	.string	" in the chest"
	.align 2
.LC123:
	.string	" took a closer look at "
	.align 2
.LC124:
	.string	"'s bullet"
	.align 2
.LC125:
	.string	" took a slug to the brain from"
	.align 2
.LC126:
	.string	" saw the pretty lights from"
	.align 2
.LC127:
	.string	"'s BFG"
	.align 2
.LC128:
	.string	" was disintegrated by"
	.align 2
.LC129:
	.string	"'s BFG blast"
	.align 2
.LC130:
	.string	" couldn't hide from"
	.align 2
.LC131:
	.string	" caught"
	.align 2
.LC132:
	.string	"'s handgrenade"
	.align 2
.LC133:
	.string	"'s hand grenade in the arm"
	.align 2
.LC134:
	.string	"'s hand grenade in the leg"
	.align 2
.LC135:
	.string	"'s hand grenade in the back"
	.align 2
.LC136:
	.string	"'s hand grenade in the chest"
	.align 2
.LC137:
	.string	"'s hand grenade in the head"
	.align 2
.LC138:
	.string	" didn't see"
	.align 2
.LC139:
	.string	" feels"
	.align 2
.LC140:
	.string	"'s pain"
	.align 2
.LC141:
	.string	" tried to invade"
	.align 2
.LC142:
	.string	"'s personal space"
	.align 2
.LC143:
	.string	" slaps"
	.align 2
.LC144:
	.string	" to death"
	.align 2
.LC145:
	.string	" gave"
	.align 2
.LC146:
	.string	" a dead left arm"
	.align 2
.LC147:
	.string	" a dead right arm"
	.align 2
.LC148:
	.string	" breaks"
	.align 2
.LC149:
	.string	"'s left leg"
	.align 2
.LC150:
	.string	" gets"
	.align 2
.LC151:
	.string	" higher up on the list of right hip replacements"
	.align 2
.LC152:
	.string	" winds"
	.align 2
.LC153:
	.string	" with a swift punch to the solar plexis"
	.align 2
.LC154:
	.string	" rips out"
	.align 2
.LC155:
	.string	"'s spine."
	.align 2
.LC156:
	.string	" pushes jawbone into"
	.align 2
.LC157:
	.string	"'s brain"
	.align 2
.LC158:
	.string	" sneaks up and snaps"
	.align 2
.LC159:
	.string	"'s neck. Get out of the console, dumbass!"
	.align 2
.LC160:
	.string	" trips"
	.align 2
.LC161:
	.string	" over"
	.align 2
.LC162:
	.string	" a spin kick to the left arm"
	.align 2
.LC163:
	.string	" a spin kick to the right arm"
	.align 2
.LC164:
	.string	" sends"
	.align 2
.LC165:
	.string	"'s left leg over head"
	.align 2
.LC166:
	.string	"'s right leg over head"
	.align 2
.LC167:
	.string	" spin kicks"
	.align 2
.LC168:
	.string	"'s torso away"
	.align 2
.LC169:
	.string	" sneaks up on"
	.align 2
.LC170:
	.string	" and sweeps the fucker"
	.align 2
.LC171:
	.string	"'s wild break-dancing results in"
	.align 2
.LC172:
	.string	"'s demise (pin kick to the head)"
	.align 2
.LC173:
	.string	" makes"
	.align 2
.LC174:
	.string	" fall badly. Very Badly."
	.align 2
.LC175:
	.string	"'s 15th flying kick downs"
	.align 2
.LC176:
	.string	"."
	.align 2
.LC177:
	.string	"'s flying roundhouse loses"
	.align 2
.LC178:
	.string	"'s left arm"
	.align 2
.LC179:
	.string	"'s right arm"
	.align 2
.LC180:
	.string	"'s flurry results in crutches for"
	.align 2
.LC181:
	.string	" and his poor left leg"
	.align 2
.LC182:
	.string	" puts 87 well placed fly kicks in"
	.align 2
.LC183:
	.string	"'s chest"
	.align 2
.LC184:
	.string	" fells"
	.align 2
.LC185:
	.string	" with 54 stomps in the back"
	.align 2
.LC186:
	.string	" gives"
	.align 2
.LC187:
	.string	" a face massage.. with his feet of fury"
	.align 2
.LC188:
	.string	" gets "
	.align 2
.LC189:
	.string	"'s brain on his boots"
	.align 2
.LC190:
	.string	" punches"
	.align 2
.LC191:
	.string	"'s lights out"
	.align 2
.LC192:
	.string	"'s hook breaks"
	.align 2
.LC193:
	.string	"'s hook busts up"
	.align 2
.LC194:
	.string	"'s hook knackers"
	.align 2
.LC195:
	.string	"'s right leg"
	.align 2
.LC196:
	.string	" thrusts his fist through"
	.align 2
.LC197:
	.string	" takes out"
	.align 2
.LC198:
	.string	"'s spinal column"
	.align 2
.LC199:
	.string	" destroys"
	.align 2
.LC200:
	.string	"'s beautiful complextion"
	.align 2
.LC201:
	.string	" upside de heed"
	.align 2
.LC202:
	.string	"'s jab takes out"
	.align 2
.LC203:
	.string	" jabs "
	.align 2
.LC204:
	.string	"'s flurry of jabs results in wheelchairisation for"
	.align 2
.LC205:
	.string	" and his poor right leg"
	.align 2
.LC206:
	.string	" pummels"
	.align 2
.LC207:
	.string	" massages"
	.align 2
.LC208:
	.string	"'s back with with 54 jabs"
	.align 2
.LC209:
	.string	" a face massage.. with his fist of fury"
	.align 2
.LC210:
	.string	" knocks "
	.align 2
.LC211:
	.string	"'s block off"
	.align 2
.LC212:
	.string	" puts some sho ryu ken on"
	.align 2
.LC213:
	.string	" rips off"
	.align 2
.LC214:
	.string	"'s left arm with a dragon punch"
	.align 2
.LC215:
	.string	" upper cuts"
	.align 2
.LC216:
	.string	" in the left leg"
	.align 2
.LC217:
	.string	" in the right leg"
	.align 2
.LC218:
	.string	" puts some ha doo ken in"
	.align 2
.LC219:
	.string	" up the bracket"
	.align 2
.LC220:
	.string	" doesn't like"
	.align 2
.LC221:
	.string	"'s face"
	.align 2
.LC222:
	.string	" puts his fist through"
	.align 2
.LC223:
	.string	" rips"
	.align 2
.LC224:
	.string	" open"
	.align 2
.LC225:
	.string	" cuts up "
	.align 2
.LC226:
	.string	" stabs "
	.align 2
.LC227:
	.string	" makes a sheath out of"
	.align 2
.LC228:
	.string	"'s heart"
	.align 2
.LC229:
	.string	" backstabs "
	.align 2
.LC230:
	.string	" a newcastle smiley"
	.align 2
.LC231:
	.string	" tries brain surgury on"
	.align 2
.LC232:
	.string	" and fails"
	.align 2
.LC233:
	.string	"%s%s %s%s\n"
	.align 2
.LC234:
	.string	"%s died.\n"
	.align 3
.LC235:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC236:
	.long 0x42480000
	.align 2
.LC237:
	.long 0x0
	.align 2
.LC238:
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
	mr 31,5
	mr 30,3
	lwz 0,84(31)
	lis 10,level@ha
	cmpwi 0,0,0
	bc 12,2,.L39
	lis 11,.LC235@ha
	lwz 0,level@l(10)
	la 11,.LC235@l(11)
	lfs 13,1100(31)
	lis 8,0x4330
	lfd 12,0(11)
	xoris 0,0,0x8000
	lis 11,.LC236@ha
	stw 0,20(1)
	la 11,.LC236@l(11)
	stw 8,16(1)
	lfs 0,0(11)
	fadds 13,13,0
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 4,0,.L36
	cmpw 0,31,30
	bc 12,2,.L38
	lwz 9,1096(31)
	addi 9,9,1
	stw 9,1096(31)
	lwz 0,level@l(10)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 8,16(1)
	lfd 0,16(1)
	fsub 0,0,12
	b .L291
.L36:
	li 0,0
	stw 0,1096(31)
.L39:
	lis 11,level@ha
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 8,.LC235@ha
	la 8,.LC235@l(8)
	xoris 0,0,0x8000
	lfd 13,0(8)
	stw 0,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	fsub 0,0,13
.L291:
	frsp 0,0
	stfs 0,1100(31)
.L38:
	lwz 10,1096(31)
	lis 29,gi@ha
	cmpwi 0,10,0
	bc 12,2,.L40
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L40
	lis 11,.LC237@ha
	lis 9,killstreakmessage@ha
	la 11,.LC237@l(11)
	lfs 13,0(11)
	lwz 11,killstreakmessage@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L40
	cmpwi 0,10,1
	bc 4,2,.L41
	lis 9,streakmessage2@ha
	la 29,gi@l(29)
	lwz 11,streakmessage2@l(9)
	lis 4,.LC22@ha
	mr 3,31
	lwz 9,12(29)
	la 4,.LC22@l(4)
	lwz 5,4(11)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,36(29)
	lis 3,.LC23@ha
	la 3,.LC23@l(3)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC238@ha
	lis 9,.LC238@ha
	lis 11,.LC237@ha
	mr 5,3
	la 8,.LC238@l(8)
	la 9,.LC238@l(9)
	mtlr 0
	la 11,.LC237@l(11)
	li 4,2
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L41:
	lwz 0,1096(31)
	cmpwi 0,0,2
	bc 4,2,.L42
	lis 9,streakmessage3@ha
	lis 29,gi@ha
	lwz 11,streakmessage3@l(9)
	la 29,gi@l(29)
	lis 4,.LC22@ha
	lwz 9,12(29)
	la 4,.LC22@l(4)
	mr 3,31
	lwz 5,4(11)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,36(29)
	lis 3,.LC24@ha
	la 3,.LC24@l(3)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC238@ha
	lis 9,.LC238@ha
	lis 11,.LC237@ha
	mr 5,3
	la 8,.LC238@l(8)
	la 9,.LC238@l(9)
	mtlr 0
	la 11,.LC237@l(11)
	li 4,2
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L42:
	lwz 0,1096(31)
	cmpwi 0,0,3
	bc 4,2,.L43
	lis 9,streakmessage4@ha
	lis 29,gi@ha
	lwz 11,streakmessage4@l(9)
	la 29,gi@l(29)
	lis 4,.LC22@ha
	lwz 9,12(29)
	la 4,.LC22@l(4)
	mr 3,31
	lwz 5,4(11)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,36(29)
	lis 3,.LC25@ha
	la 3,.LC25@l(3)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC238@ha
	lis 9,.LC238@ha
	lis 11,.LC237@ha
	mr 5,3
	la 8,.LC238@l(8)
	la 9,.LC238@l(9)
	mtlr 0
	la 11,.LC237@l(11)
	li 4,2
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L43:
	lwz 0,1096(31)
	cmpwi 0,0,4
	bc 4,2,.L44
	lis 9,streakmessage5@ha
	lis 29,gi@ha
	lwz 11,streakmessage5@l(9)
	la 29,gi@l(29)
	lis 4,.LC22@ha
	lwz 9,12(29)
	la 4,.LC22@l(4)
	mr 3,31
	lwz 5,4(11)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,36(29)
	lis 3,.LC26@ha
	la 3,.LC26@l(3)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC238@ha
	lis 9,.LC238@ha
	lis 11,.LC237@ha
	mr 5,3
	la 8,.LC238@l(8)
	la 9,.LC238@l(9)
	mtlr 0
	la 11,.LC237@l(11)
	li 4,2
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L44:
	lwz 6,1096(31)
	cmpwi 0,6,4
	bc 4,1,.L40
	lis 9,streakmessage6@ha
	lis 29,gi@ha
	lwz 11,streakmessage6@l(9)
	la 29,gi@l(29)
	lis 4,.LC27@ha
	lwz 9,12(29)
	la 4,.LC27@l(4)
	mr 3,31
	lwz 5,4(11)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,36(29)
	lis 3,.LC28@ha
	la 3,.LC28@l(3)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC238@ha
	lis 9,.LC238@ha
	lis 11,.LC237@ha
	mr 5,3
	la 8,.LC238@l(8)
	la 9,.LC238@l(9)
	mtlr 0
	la 11,.LC237@l(11)
	li 4,2
	lfs 1,0(8)
	mr 3,31
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L40:
	lis 11,coop@ha
	lis 8,.LC237@ha
	lwz 9,coop@l(11)
	la 8,.LC237@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L46
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L46
	lis 9,meansOfDeath@ha
	lwz 0,meansOfDeath@l(9)
	oris 0,0,0x800
	stw 0,meansOfDeath@l(9)
.L46:
	lis 11,.LC237@ha
	lis 9,deathmatch@ha
	la 11,.LC237@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L48
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L47
.L48:
	lis 9,meansOfDeath@ha
	lis 11,.LC29@ha
	lwz 0,meansOfDeath@l(9)
	la 29,.LC29@l(11)
	li 6,0
	rlwinm 28,0,0,5,3
	rlwinm 27,0,0,4,4
	addi 10,28,-7
	cmplwi 0,10,16
	bc 12,1,.L49
	lis 11,.L64@ha
	slwi 10,10,2
	la 11,.L64@l(11)
	lis 9,.L64@ha
	lwzx 0,10,11
	la 9,.L64@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L64:
	.long .L53-.L64
	.long .L54-.L64
	.long .L55-.L64
	.long .L52-.L64
	.long .L49-.L64
	.long .L51-.L64
	.long .L50-.L64
	.long .L49-.L64
	.long .L57-.L64
	.long .L57-.L64
	.long .L63-.L64
	.long .L58-.L64
	.long .L63-.L64
	.long .L59-.L64
	.long .L63-.L64
	.long .L49-.L64
	.long .L60-.L64
.L50:
	lis 9,.LC30@ha
	la 6,.LC30@l(9)
	b .L49
.L51:
	lis 9,.LC31@ha
	la 6,.LC31@l(9)
	b .L49
.L52:
	lis 9,.LC32@ha
	la 6,.LC32@l(9)
	b .L49
.L53:
	lis 9,.LC33@ha
	la 6,.LC33@l(9)
	b .L49
.L54:
	lis 9,.LC34@ha
	la 6,.LC34@l(9)
	b .L49
.L55:
	lis 9,.LC35@ha
	la 6,.LC35@l(9)
	b .L49
.L57:
	lis 9,.LC36@ha
	la 6,.LC36@l(9)
	b .L49
.L58:
	lis 9,.LC37@ha
	la 6,.LC37@l(9)
	b .L49
.L59:
	lis 9,.LC38@ha
	la 6,.LC38@l(9)
	b .L49
.L60:
	lis 9,.LC39@ha
	la 6,.LC39@l(9)
	b .L49
.L63:
	lis 9,.LC40@ha
	la 6,.LC40@l(9)
.L49:
	cmpw 0,31,30
	bc 4,2,.L66
	addi 10,28,-1
	cmplwi 0,10,13
	bc 12,1,.L93
	lis 11,.L104@ha
	slwi 10,10,2
	la 11,.L104@l(11)
	lis 9,.L104@ha
	lwzx 0,10,11
	la 9,.L104@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L104:
	.long .L70-.L104
	.long .L81-.L104
	.long .L93-.L104
	.long .L92-.L104
	.long .L93-.L104
	.long .L70-.L104
	.long .L93-.L104
	.long .L93-.L104
	.long .L93-.L104
	.long .L93-.L104
	.long .L93-.L104
	.long .L93-.L104
	.long .L93-.L104
	.long .L68-.L104
.L68:
	lis 9,.LC41@ha
	la 6,.LC41@l(9)
	b .L66
.L70:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L72
	li 10,0
	b .L73
.L72:
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
	bc 12,2,.L73
	cmpwi 0,11,109
	bc 12,2,.L73
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L73:
	cmpwi 0,10,0
	bc 12,2,.L71
	lis 9,.LC42@ha
	la 6,.LC42@l(9)
	b .L66
.L71:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L77
	li 0,0
	b .L78
.L77:
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
.L78:
	cmpwi 0,0,0
	bc 12,2,.L76
	lis 9,.LC43@ha
	la 6,.LC43@l(9)
	b .L66
.L76:
	lis 9,.LC44@ha
	la 6,.LC44@l(9)
	b .L66
.L81:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L83
	li 10,0
	b .L84
.L83:
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
	bc 12,2,.L84
	cmpwi 0,11,109
	bc 12,2,.L84
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L84:
	cmpwi 0,10,0
	bc 12,2,.L82
	lis 9,.LC45@ha
	la 6,.LC45@l(9)
	b .L66
.L82:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L88
	li 0,0
	b .L89
.L88:
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
.L89:
	cmpwi 0,0,0
	bc 12,2,.L87
	lis 9,.LC46@ha
	la 6,.LC46@l(9)
	b .L66
.L87:
	lis 9,.LC47@ha
	la 6,.LC47@l(9)
	b .L66
.L92:
	lis 9,.LC48@ha
	la 6,.LC48@l(9)
	b .L66
.L93:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L95
	li 10,0
	b .L96
.L95:
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
	bc 12,2,.L96
	cmpwi 0,11,109
	bc 12,2,.L96
	xori 0,11,77
	neg 0,0
	srwi 10,0,31
.L96:
	cmpwi 0,10,0
	bc 12,2,.L94
	lis 9,.LC49@ha
	la 6,.LC49@l(9)
	b .L66
.L94:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 4,2,.L100
	li 0,0
	b .L101
.L100:
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
.L101:
	cmpwi 0,0,0
	bc 12,2,.L99
	lis 9,.LC50@ha
	la 6,.LC50@l(9)
	b .L66
.L99:
	lis 9,.LC51@ha
	la 6,.LC51@l(9)
.L66:
	cmpwi 0,6,0
	bc 12,2,.L105
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC52@ha
	lwz 0,gi@l(9)
	la 4,.LC52@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,deathmatch@ha
	lis 8,.LC237@ha
	lwz 11,deathmatch@l(9)
	la 8,.LC237@l(8)
	lfs 13,0(8)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L106
	lwz 10,84(30)
	lis 11,tankmode@ha
	lwz 8,tankmode@l(11)
	lwz 9,3464(10)
	addi 9,9,-1
	stw 9,3464(10)
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 4,2,.L106
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L106
	lwz 9,84(30)
	lwz 0,3484(9)
	cmpwi 0,0,1
	bc 4,2,.L108
	lis 11,matrix@ha
	la 11,matrix@l(11)
	lwz 9,16(11)
	addi 9,9,-1
	stw 9,16(11)
.L108:
	lwz 9,84(30)
	lwz 0,3484(9)
	cmpwi 0,0,2
	bc 4,2,.L106
	lis 11,matrix@ha
	la 11,matrix@l(11)
	lwz 9,20(11)
	addi 9,9,-1
	stw 9,20(11)
.L106:
	li 0,0
	stw 0,540(30)
	b .L35
.L105:
	cmpwi 0,31,0
	stw 31,540(30)
	bc 12,2,.L47
	lwz 0,84(31)
	cmpwi 0,0,0
	mr 8,0
	bc 12,2,.L47
	addi 10,28,-1
	cmplwi 0,10,193
	bc 12,1,.L111
	lis 11,.L273@ha
	slwi 10,10,2
	la 11,.L273@l(11)
	lis 9,.L273@ha
	lwzx 0,10,11
	la 9,.L273@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L273:
	.long .L166-.L273
	.long .L176-.L273
	.long .L195-.L273
	.long .L196-.L273
	.long .L197-.L273
	.long .L207-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L209-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L208-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L117-.L273
	.long .L113-.L273
	.long .L114-.L273
	.long .L115-.L273
	.long .L116-.L273
	.long .L117-.L273
	.long .L118-.L273
	.long .L119-.L273
	.long .L120-.L273
	.long .L126-.L273
	.long .L122-.L273
	.long .L123-.L273
	.long .L124-.L273
	.long .L125-.L273
	.long .L126-.L273
	.long .L127-.L273
	.long .L128-.L273
	.long .L129-.L273
	.long .L132-.L273
	.long .L131-.L273
	.long .L132-.L273
	.long .L133-.L273
	.long .L134-.L273
	.long .L136-.L273
	.long .L135-.L273
	.long .L137-.L273
	.long .L138-.L273
	.long .L177-.L273
	.long .L178-.L273
	.long .L179-.L273
	.long .L180-.L273
	.long .L181-.L273
	.long .L183-.L273
	.long .L182-.L273
	.long .L184-.L273
	.long .L185-.L273
	.long .L156-.L273
	.long .L148-.L273
	.long .L149-.L273
	.long .L150-.L273
	.long .L151-.L273
	.long .L153-.L273
	.long .L152-.L273
	.long .L154-.L273
	.long .L155-.L273
	.long .L147-.L273
	.long .L139-.L273
	.long .L140-.L273
	.long .L141-.L273
	.long .L142-.L273
	.long .L147-.L273
	.long .L143-.L273
	.long .L145-.L273
	.long .L146-.L273
	.long .L173-.L273
	.long .L168-.L273
	.long .L169-.L273
	.long .L170-.L273
	.long .L171-.L273
	.long .L173-.L273
	.long .L172-.L273
	.long .L174-.L273
	.long .L175-.L273
	.long .L165-.L273
	.long .L157-.L273
	.long .L158-.L273
	.long .L159-.L273
	.long .L160-.L273
	.long .L162-.L273
	.long .L161-.L273
	.long .L163-.L273
	.long .L164-.L273
	.long .L198-.L273
	.long .L199-.L273
	.long .L200-.L273
	.long .L201-.L273
	.long .L202-.L273
	.long .L204-.L273
	.long .L203-.L273
	.long .L205-.L273
	.long .L206-.L273
	.long .L194-.L273
	.long .L186-.L273
	.long .L187-.L273
	.long .L188-.L273
	.long .L189-.L273
	.long .L191-.L273
	.long .L190-.L273
	.long .L192-.L273
	.long .L193-.L273
	.long .L210-.L273
	.long .L211-.L273
	.long .L212-.L273
	.long .L213-.L273
	.long .L214-.L273
	.long .L215-.L273
	.long .L216-.L273
	.long .L217-.L273
	.long .L218-.L273
	.long .L219-.L273
	.long .L220-.L273
	.long .L221-.L273
	.long .L222-.L273
	.long .L223-.L273
	.long .L224-.L273
	.long .L225-.L273
	.long .L226-.L273
	.long .L227-.L273
	.long .L228-.L273
	.long .L229-.L273
	.long .L230-.L273
	.long .L231-.L273
	.long .L232-.L273
	.long .L233-.L273
	.long .L234-.L273
	.long .L235-.L273
	.long .L236-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L111-.L273
	.long .L237-.L273
	.long .L238-.L273
	.long .L239-.L273
	.long .L240-.L273
	.long .L241-.L273
	.long .L242-.L273
	.long .L243-.L273
	.long .L244-.L273
	.long .L245-.L273
	.long .L246-.L273
	.long .L247-.L273
	.long .L248-.L273
	.long .L249-.L273
	.long .L250-.L273
	.long .L251-.L273
	.long .L252-.L273
	.long .L253-.L273
	.long .L254-.L273
	.long .L255-.L273
	.long .L256-.L273
	.long .L257-.L273
	.long .L258-.L273
	.long .L259-.L273
	.long .L260-.L273
	.long .L261-.L273
	.long .L262-.L273
	.long .L263-.L273
	.long .L264-.L273
	.long .L265-.L273
	.long .L266-.L273
	.long .L267-.L273
	.long .L268-.L273
	.long .L269-.L273
	.long .L270-.L273
	.long .L271-.L273
	.long .L272-.L273
.L113:
.L114:
	lis 9,.LC54@ha
	la 6,.LC54@l(9)
	b .L111
.L115:
	lis 9,.LC55@ha
	lis 11,.LC56@ha
	la 6,.LC55@l(9)
	la 29,.LC56@l(11)
	b .L111
.L116:
	lis 9,.LC57@ha
	lis 11,.LC56@ha
	la 6,.LC57@l(9)
	la 29,.LC56@l(11)
	b .L111
.L117:
	lis 9,.LC53@ha
	la 6,.LC53@l(9)
	b .L111
.L118:
	lis 9,.LC53@ha
	lis 11,.LC58@ha
	la 6,.LC53@l(9)
	la 29,.LC58@l(11)
	b .L111
.L119:
	lis 9,.LC59@ha
	la 6,.LC59@l(9)
	b .L111
.L120:
	lis 9,.LC60@ha
	la 6,.LC60@l(9)
	b .L111
.L122:
.L123:
	lis 9,.LC62@ha
	la 6,.LC62@l(9)
	b .L111
.L124:
.L125:
	lis 9,.LC63@ha
	la 6,.LC63@l(9)
	b .L111
.L126:
	lis 9,.LC61@ha
	la 6,.LC61@l(9)
	b .L111
.L127:
	lis 9,.LC64@ha
	la 6,.LC64@l(9)
	b .L111
.L128:
	lis 9,.LC66@ha
	la 6,.LC66@l(9)
	b .L111
.L129:
	lis 9,.LC67@ha
	la 6,.LC67@l(9)
	b .L111
.L131:
.L132:
	lis 9,.LC68@ha
	lis 11,.LC69@ha
	la 6,.LC68@l(9)
	la 29,.LC69@l(11)
	b .L111
.L133:
.L134:
	lis 9,.LC70@ha
	lis 11,.LC71@ha
	la 6,.LC70@l(9)
	la 29,.LC71@l(11)
	b .L111
.L135:
	lis 9,.LC68@ha
	lis 11,.LC72@ha
	la 6,.LC68@l(9)
	la 29,.LC72@l(11)
	b .L111
.L136:
	lis 9,.LC73@ha
	lis 11,.LC69@ha
	la 6,.LC73@l(9)
	la 29,.LC69@l(11)
	b .L111
.L137:
.L138:
	lis 9,.LC74@ha
	lis 11,.LC69@ha
	la 6,.LC74@l(9)
	la 29,.LC69@l(11)
	b .L111
.L139:
.L140:
	lis 9,.LC75@ha
	la 6,.LC75@l(9)
	b .L111
.L141:
.L142:
	lis 9,.LC76@ha
	la 6,.LC76@l(9)
	b .L111
.L143:
	lis 9,.LC77@ha
	lis 11,.LC78@ha
	la 6,.LC77@l(9)
	la 29,.LC78@l(11)
	b .L111
.L145:
	lis 9,.LC79@ha
	lis 11,.LC80@ha
	la 6,.LC79@l(9)
	la 29,.LC80@l(11)
	b .L111
.L146:
	lis 9,.LC81@ha
	la 6,.LC81@l(9)
	b .L111
.L147:
	lis 9,.LC77@ha
	la 6,.LC77@l(9)
	b .L111
.L148:
.L149:
	lis 9,.LC82@ha
	lis 11,.LC83@ha
	la 6,.LC82@l(9)
	la 29,.LC83@l(11)
	b .L111
.L150:
.L151:
	lis 9,.LC84@ha
	lis 11,.LC83@ha
	la 6,.LC84@l(9)
	la 29,.LC83@l(11)
	b .L111
.L152:
	lis 9,.LC85@ha
	lis 11,.LC83@ha
	la 6,.LC85@l(9)
	la 29,.LC83@l(11)
	b .L111
.L153:
	lis 9,.LC86@ha
	lis 11,.LC83@ha
	la 6,.LC86@l(9)
	la 29,.LC83@l(11)
	b .L111
.L154:
	lis 9,.LC87@ha
	lis 11,.LC83@ha
	la 6,.LC87@l(9)
	la 29,.LC83@l(11)
	b .L111
.L155:
	lis 9,.LC88@ha
	lis 11,.LC83@ha
	la 6,.LC88@l(9)
	la 29,.LC83@l(11)
	b .L111
.L156:
	lis 9,.LC89@ha
	lis 11,.LC83@ha
	la 6,.LC89@l(9)
	la 29,.LC83@l(11)
	b .L111
.L157:
	lis 9,.LC90@ha
	lis 11,.LC91@ha
	la 6,.LC90@l(9)
	la 29,.LC91@l(11)
	b .L111
.L158:
	lis 9,.LC92@ha
	lis 11,.LC91@ha
	la 6,.LC92@l(9)
	la 29,.LC91@l(11)
	b .L111
.L159:
.L160:
	lis 9,.LC93@ha
	lis 11,.LC91@ha
	la 6,.LC93@l(9)
	la 29,.LC91@l(11)
	b .L111
.L161:
	lis 9,.LC94@ha
	lis 11,.LC91@ha
	la 6,.LC94@l(9)
	la 29,.LC91@l(11)
	b .L111
.L162:
	lis 9,.LC95@ha
	lis 11,.LC91@ha
	la 6,.LC95@l(9)
	la 29,.LC91@l(11)
	b .L111
.L163:
	lis 9,.LC96@ha
	lis 11,.LC91@ha
	la 6,.LC96@l(9)
	la 29,.LC91@l(11)
	b .L111
.L164:
	lis 9,.LC97@ha
	lis 11,.LC91@ha
	la 6,.LC97@l(9)
	la 29,.LC91@l(11)
	b .L111
.L165:
	lis 9,.LC98@ha
	lis 11,.LC91@ha
	la 6,.LC98@l(9)
	la 29,.LC91@l(11)
	b .L111
.L166:
	lis 9,.LC99@ha
	lis 11,.LC100@ha
	la 6,.LC99@l(9)
	la 29,.LC100@l(11)
	b .L111
.L168:
.L169:
	lis 9,.LC103@ha
	lis 11,.LC102@ha
	la 6,.LC103@l(9)
	la 29,.LC102@l(11)
	b .L111
.L170:
.L171:
	lis 9,.LC104@ha
	lis 11,.LC102@ha
	la 6,.LC104@l(9)
	la 29,.LC102@l(11)
	b .L111
.L172:
.L173:
	lis 9,.LC101@ha
	lis 11,.LC102@ha
	la 6,.LC101@l(9)
	la 29,.LC102@l(11)
	b .L111
.L174:
	lis 9,.LC101@ha
	lis 11,.LC105@ha
	la 6,.LC101@l(9)
	la 29,.LC105@l(11)
	b .L111
.L175:
	lis 9,.LC106@ha
	lis 11,.LC102@ha
	la 6,.LC106@l(9)
	la 29,.LC102@l(11)
	b .L111
.L176:
	lis 9,.LC107@ha
	lis 11,.LC102@ha
	la 6,.LC107@l(9)
	la 29,.LC102@l(11)
	b .L111
.L177:
	lis 9,.LC108@ha
	lis 11,.LC29@ha
	la 6,.LC108@l(9)
	la 29,.LC29@l(11)
	b .L111
.L178:
	lis 9,.LC109@ha
	lis 11,.LC29@ha
	la 6,.LC109@l(9)
	la 29,.LC29@l(11)
	b .L111
.L179:
	lis 9,.LC110@ha
	lis 11,.LC29@ha
	la 6,.LC110@l(9)
	la 29,.LC29@l(11)
	b .L111
.L180:
	lis 9,.LC111@ha
	lis 11,.LC112@ha
	la 6,.LC111@l(9)
	la 29,.LC112@l(11)
	b .L111
.L181:
	lis 9,.LC113@ha
	lis 11,.LC112@ha
	la 6,.LC113@l(9)
	la 29,.LC112@l(11)
	b .L111
.L182:
	lis 9,.LC114@ha
	lis 11,.LC29@ha
	la 6,.LC114@l(9)
	la 29,.LC29@l(11)
	b .L111
.L183:
	lis 9,.LC115@ha
	lis 11,.LC29@ha
	la 6,.LC115@l(9)
	la 29,.LC29@l(11)
	b .L111
.L184:
	lis 9,.LC116@ha
	lis 11,.LC29@ha
	la 6,.LC116@l(9)
	la 29,.LC29@l(11)
	b .L111
.L185:
	lis 9,.LC117@ha
	lis 11,.LC29@ha
	la 6,.LC117@l(9)
	la 29,.LC29@l(11)
	b .L111
.L186:
.L187:
	lis 9,.LC118@ha
	la 6,.LC118@l(9)
	b .L111
.L188:
.L189:
	lis 9,.LC119@ha
	la 6,.LC119@l(9)
	b .L111
.L190:
	lis 9,.LC120@ha
	lis 11,.LC121@ha
	la 6,.LC120@l(9)
	la 29,.LC121@l(11)
	b .L111
.L191:
	lis 9,.LC120@ha
	lis 11,.LC122@ha
	la 6,.LC120@l(9)
	la 29,.LC122@l(11)
	b .L111
.L192:
	lis 9,.LC123@ha
	lis 11,.LC124@ha
	la 6,.LC123@l(9)
	la 29,.LC124@l(11)
	b .L111
.L193:
	lis 9,.LC125@ha
	la 6,.LC125@l(9)
	b .L111
.L194:
	lis 9,.LC120@ha
	la 6,.LC120@l(9)
	b .L111
.L195:
	lis 9,.LC126@ha
	lis 11,.LC127@ha
	la 6,.LC126@l(9)
	la 29,.LC127@l(11)
	b .L111
.L196:
	lis 9,.LC128@ha
	lis 11,.LC129@ha
	la 6,.LC128@l(9)
	la 29,.LC129@l(11)
	b .L111
.L197:
	lis 9,.LC130@ha
	lis 11,.LC127@ha
	la 6,.LC130@l(9)
	la 29,.LC127@l(11)
	b .L111
.L198:
	lis 9,.LC131@ha
	lis 11,.LC132@ha
	la 6,.LC131@l(9)
	la 29,.LC132@l(11)
	b .L111
.L199:
.L200:
	lis 9,.LC131@ha
	lis 11,.LC133@ha
	la 6,.LC131@l(9)
	la 29,.LC133@l(11)
	b .L111
.L201:
.L202:
	lis 9,.LC131@ha
	lis 11,.LC134@ha
	la 6,.LC131@l(9)
	la 29,.LC134@l(11)
	b .L111
.L203:
	lis 9,.LC131@ha
	lis 11,.LC135@ha
	la 6,.LC131@l(9)
	la 29,.LC135@l(11)
	b .L111
.L204:
	lis 9,.LC131@ha
	lis 11,.LC136@ha
	la 6,.LC131@l(9)
	la 29,.LC136@l(11)
	b .L111
.L205:
.L206:
	lis 9,.LC131@ha
	lis 11,.LC137@ha
	la 6,.LC131@l(9)
	la 29,.LC137@l(11)
	b .L111
.L207:
	lis 9,.LC138@ha
	lis 11,.LC132@ha
	la 6,.LC138@l(9)
	la 29,.LC132@l(11)
	b .L111
.L208:
	lis 9,.LC139@ha
	lis 11,.LC140@ha
	la 6,.LC139@l(9)
	la 29,.LC140@l(11)
	b .L111
.L209:
	lis 9,.LC141@ha
	lis 11,.LC142@ha
	la 6,.LC141@l(9)
	la 29,.LC142@l(11)
	b .L111
.L210:
	lis 9,.LC143@ha
	lis 11,.LC144@ha
	la 6,.LC143@l(9)
	la 29,.LC144@l(11)
	b .L111
.L211:
	lis 9,.LC145@ha
	lis 11,.LC146@ha
	la 6,.LC145@l(9)
	la 29,.LC146@l(11)
	b .L111
.L212:
	lis 9,.LC145@ha
	lis 11,.LC147@ha
	la 6,.LC145@l(9)
	la 29,.LC147@l(11)
	b .L111
.L213:
	lis 9,.LC148@ha
	lis 11,.LC149@ha
	la 6,.LC148@l(9)
	la 29,.LC149@l(11)
	b .L111
.L214:
	lis 9,.LC150@ha
	lis 11,.LC151@ha
	la 6,.LC150@l(9)
	la 29,.LC151@l(11)
	b .L111
.L215:
	lis 9,.LC152@ha
	lis 11,.LC153@ha
	la 6,.LC152@l(9)
	la 29,.LC153@l(11)
	b .L111
.L216:
	lis 9,.LC154@ha
	lis 11,.LC155@ha
	la 6,.LC154@l(9)
	la 29,.LC155@l(11)
	b .L111
.L217:
	lis 9,.LC156@ha
	lis 11,.LC157@ha
	la 6,.LC156@l(9)
	la 29,.LC157@l(11)
	b .L111
.L218:
	lis 9,.LC158@ha
	lis 11,.LC159@ha
	la 6,.LC158@l(9)
	la 29,.LC159@l(11)
	b .L111
.L219:
	lis 9,.LC160@ha
	lis 11,.LC161@ha
	la 6,.LC160@l(9)
	la 29,.LC161@l(11)
	b .L111
.L220:
	lis 9,.LC145@ha
	lis 11,.LC162@ha
	la 6,.LC145@l(9)
	la 29,.LC162@l(11)
	b .L111
.L221:
	lis 9,.LC145@ha
	lis 11,.LC163@ha
	la 6,.LC145@l(9)
	la 29,.LC163@l(11)
	b .L111
.L222:
	lis 9,.LC164@ha
	lis 11,.LC165@ha
	la 6,.LC164@l(9)
	la 29,.LC165@l(11)
	b .L111
.L223:
	lis 9,.LC150@ha
	lis 11,.LC166@ha
	la 6,.LC150@l(9)
	la 29,.LC166@l(11)
	b .L111
.L224:
	lis 9,.LC167@ha
	lis 11,.LC168@ha
	la 6,.LC167@l(9)
	la 29,.LC168@l(11)
	b .L111
.L225:
	lis 9,.LC169@ha
	lis 11,.LC170@ha
	la 6,.LC169@l(9)
	la 29,.LC170@l(11)
	b .L111
.L226:
	lis 9,.LC171@ha
	lis 11,.LC172@ha
	la 6,.LC171@l(9)
	la 29,.LC172@l(11)
	b .L111
.L227:
	lis 9,.LC173@ha
	lis 11,.LC174@ha
	la 6,.LC173@l(9)
	la 29,.LC174@l(11)
	b .L111
.L228:
	lis 9,.LC175@ha
	lis 11,.LC176@ha
	la 6,.LC175@l(9)
	la 29,.LC176@l(11)
	b .L111
.L229:
	lis 9,.LC177@ha
	lis 11,.LC178@ha
	la 6,.LC177@l(9)
	la 29,.LC178@l(11)
	b .L111
.L230:
	lis 9,.LC177@ha
	lis 11,.LC179@ha
	la 6,.LC177@l(9)
	la 29,.LC179@l(11)
	b .L111
.L231:
.L232:
	lis 9,.LC180@ha
	lis 11,.LC181@ha
	la 6,.LC180@l(9)
	la 29,.LC181@l(11)
	b .L111
.L233:
	lis 9,.LC182@ha
	lis 11,.LC183@ha
	la 6,.LC182@l(9)
	la 29,.LC183@l(11)
	b .L111
.L234:
	lis 9,.LC184@ha
	lis 11,.LC185@ha
	la 6,.LC184@l(9)
	la 29,.LC185@l(11)
	b .L111
.L235:
	lis 9,.LC186@ha
	lis 11,.LC187@ha
	la 6,.LC186@l(9)
	la 29,.LC187@l(11)
	b .L111
.L236:
	lis 9,.LC188@ha
	lis 11,.LC189@ha
	la 6,.LC188@l(9)
	la 29,.LC189@l(11)
	b .L111
.L237:
	lis 9,.LC190@ha
	lis 11,.LC191@ha
	la 6,.LC190@l(9)
	la 29,.LC191@l(11)
	b .L111
.L238:
	lis 9,.LC192@ha
	lis 11,.LC178@ha
	la 6,.LC192@l(9)
	la 29,.LC178@l(11)
	b .L111
.L239:
	lis 9,.LC192@ha
	lis 11,.LC179@ha
	la 6,.LC192@l(9)
	la 29,.LC179@l(11)
	b .L111
.L240:
	lis 9,.LC193@ha
	lis 11,.LC149@ha
	la 6,.LC193@l(9)
	la 29,.LC149@l(11)
	b .L111
.L241:
	lis 9,.LC194@ha
	lis 11,.LC195@ha
	la 6,.LC194@l(9)
	la 29,.LC195@l(11)
	b .L111
.L242:
	lis 9,.LC196@ha
	lis 11,.LC183@ha
	la 6,.LC196@l(9)
	la 29,.LC183@l(11)
	b .L111
.L243:
	lis 9,.LC197@ha
	lis 11,.LC198@ha
	la 6,.LC197@l(9)
	la 29,.LC198@l(11)
	b .L111
.L244:
	lis 9,.LC199@ha
	lis 11,.LC200@ha
	la 6,.LC199@l(9)
	la 29,.LC200@l(11)
	b .L111
.L245:
	lis 9,.LC190@ha
	lis 11,.LC201@ha
	la 6,.LC190@l(9)
	la 29,.LC201@l(11)
	b .L111
.L246:
	lis 9,.LC202@ha
	lis 11,.LC29@ha
	la 6,.LC202@l(9)
	la 29,.LC29@l(11)
	b .L111
.L247:
	lis 9,.LC203@ha
	lis 11,.LC178@ha
	la 6,.LC203@l(9)
	la 29,.LC178@l(11)
	b .L111
.L248:
	lis 9,.LC203@ha
	lis 11,.LC179@ha
	la 6,.LC203@l(9)
	la 29,.LC179@l(11)
	b .L111
.L249:
	lis 9,.LC204@ha
	lis 11,.LC181@ha
	la 6,.LC204@l(9)
	la 29,.LC181@l(11)
	b .L111
.L250:
	lis 9,.LC204@ha
	lis 11,.LC205@ha
	la 6,.LC204@l(9)
	la 29,.LC205@l(11)
	b .L111
.L251:
	lis 9,.LC206@ha
	lis 11,.LC183@ha
	la 6,.LC206@l(9)
	la 29,.LC183@l(11)
	b .L111
.L252:
	lis 9,.LC207@ha
	lis 11,.LC208@ha
	la 6,.LC207@l(9)
	la 29,.LC208@l(11)
	b .L111
.L253:
	lis 9,.LC186@ha
	lis 11,.LC209@ha
	la 6,.LC186@l(9)
	la 29,.LC209@l(11)
	b .L111
.L254:
	lis 9,.LC210@ha
	lis 11,.LC211@ha
	la 6,.LC210@l(9)
	la 29,.LC211@l(11)
	b .L111
.L255:
	lis 9,.LC212@ha
	lis 11,.LC29@ha
	la 6,.LC212@l(9)
	la 29,.LC29@l(11)
	b .L111
.L256:
.L257:
	lis 9,.LC213@ha
	lis 11,.LC214@ha
	la 6,.LC213@l(9)
	la 29,.LC214@l(11)
	b .L111
.L258:
	lis 9,.LC215@ha
	lis 11,.LC216@ha
	la 6,.LC215@l(9)
	la 29,.LC216@l(11)
	b .L111
.L259:
	lis 9,.LC215@ha
	lis 11,.LC217@ha
	la 6,.LC215@l(9)
	la 29,.LC217@l(11)
	b .L111
.L260:
	lis 9,.LC218@ha
	lis 11,.LC183@ha
	la 6,.LC218@l(9)
	la 29,.LC183@l(11)
	b .L111
.L261:
	lis 9,.LC190@ha
	lis 11,.LC219@ha
	la 6,.LC190@l(9)
	la 29,.LC219@l(11)
	b .L111
.L262:
	lis 9,.LC220@ha
	lis 11,.LC221@ha
	la 6,.LC220@l(9)
	la 29,.LC221@l(11)
	b .L111
.L263:
	lis 9,.LC222@ha
	lis 11,.LC157@ha
	la 6,.LC222@l(9)
	la 29,.LC157@l(11)
	b .L111
.L264:
	lis 9,.LC223@ha
	lis 11,.LC224@ha
	la 6,.LC223@l(9)
	la 29,.LC224@l(11)
	b .L111
.L265:
	lis 9,.LC225@ha
	lis 11,.LC178@ha
	la 6,.LC225@l(9)
	la 29,.LC178@l(11)
	b .L111
.L266:
	lis 9,.LC225@ha
	lis 11,.LC179@ha
	la 6,.LC225@l(9)
	la 29,.LC179@l(11)
	b .L111
.L267:
	lis 9,.LC226@ha
	lis 11,.LC216@ha
	la 6,.LC226@l(9)
	la 29,.LC216@l(11)
	b .L111
.L268:
	lis 9,.LC226@ha
	lis 11,.LC217@ha
	la 6,.LC226@l(9)
	la 29,.LC217@l(11)
	b .L111
.L269:
	lis 9,.LC227@ha
	lis 11,.LC228@ha
	la 6,.LC227@l(9)
	la 29,.LC228@l(11)
	b .L111
.L270:
	lis 9,.LC229@ha
	lis 11,.LC29@ha
	la 6,.LC229@l(9)
	la 29,.LC29@l(11)
	b .L111
.L271:
	lis 9,.LC186@ha
	lis 11,.LC230@ha
	la 6,.LC186@l(9)
	la 29,.LC230@l(11)
	b .L111
.L272:
	lis 9,.LC231@ha
	lis 11,.LC232@ha
	la 6,.LC231@l(9)
	la 29,.LC232@l(11)
.L111:
	cmpwi 0,6,0
	bc 12,2,.L47
	cmpwi 0,28,113
	bc 4,1,.L276
	lis 9,gi@ha
	lwz 7,84(30)
	lis 4,.LC233@ha
	lwz 0,gi@l(9)
	addi 5,8,700
	la 4,.LC233@l(4)
	addi 7,7,700
	mr 8,29
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L277
.L276:
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC233@ha
	lwz 0,gi@l(9)
	addi 7,8,700
	la 4,.LC233@l(4)
	addi 5,5,700
	mr 8,29
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
.L277:
	lis 9,deathmatch@ha
	lis 8,.LC237@ha
	lwz 11,deathmatch@l(9)
	la 8,.LC237@l(8)
	lfs 13,0(8)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L35
	cmpwi 0,27,0
	bc 12,2,.L279
	lis 9,tankmode@ha
	lwz 11,tankmode@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L280
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L280
	lwz 9,84(31)
	lwz 0,3484(9)
	cmpwi 0,0,1
	bc 4,2,.L281
	lis 11,matrix@ha
	la 11,matrix@l(11)
	lwz 9,16(11)
	addi 9,9,-1
	stw 9,16(11)
.L281:
	lwz 9,84(31)
	lwz 0,3484(9)
	cmpwi 0,0,2
	bc 4,2,.L280
	lis 11,matrix@ha
	la 11,matrix@l(11)
	lwz 9,20(11)
	addi 9,9,-1
	stw 9,20(11)
.L280:
	lwz 11,84(31)
	b .L292
.L279:
	lis 9,tankmode@ha
	lwz 11,tankmode@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L284
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L284
	lwz 9,84(31)
	lwz 0,3484(9)
	cmpwi 0,0,1
	bc 4,2,.L285
	lis 11,matrix@ha
	la 11,matrix@l(11)
	lwz 9,16(11)
	addi 9,9,1
	stw 9,16(11)
.L285:
	lwz 9,84(31)
	lwz 0,3484(9)
	cmpwi 0,0,2
	bc 4,2,.L284
	lis 11,matrix@ha
	la 11,matrix@l(11)
	lwz 9,20(11)
	addi 9,9,1
	stw 9,20(11)
.L284:
	lwz 11,84(31)
	lwz 9,3464(11)
	addi 9,9,1
	b .L293
.L47:
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC234@ha
	lwz 0,gi@l(9)
	la 4,.LC234@l(4)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,deathmatch@ha
	lis 8,.LC237@ha
	lwz 11,deathmatch@l(9)
	la 8,.LC237@l(8)
	lfs 13,0(8)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L35
	lis 9,tankmode@ha
	lwz 11,tankmode@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L288
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L288
	lwz 9,84(30)
	lwz 0,3484(9)
	cmpwi 0,0,1
	bc 4,2,.L289
	lis 11,matrix@ha
	la 11,matrix@l(11)
	lwz 9,16(11)
	addi 9,9,-1
	stw 9,16(11)
.L289:
	lwz 9,84(30)
	lwz 0,3484(9)
	cmpwi 0,0,2
	bc 4,2,.L288
	lis 11,matrix@ha
	la 11,matrix@l(11)
	lwz 9,20(11)
	addi 9,9,-1
	stw 9,20(11)
.L288:
	lwz 11,84(30)
.L292:
	lwz 9,3464(11)
	addi 9,9,-1
.L293:
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
.LC239:
	.string	"Blaster"
	.align 2
.LC240:
	.string	"Fists of fury"
	.align 2
.LC241:
	.string	"gung ho knives"
	.align 2
.LC242:
	.string	"item_quad"
	.align 3
.LC243:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC244:
	.long 0x0
	.align 3
.LC245:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC246:
	.long 0x41b40000
	.section	".text"
	.align 2
	.globl TossClientWeapon
	.type	 TossClientWeapon,@function
TossClientWeapon:
	stwu 1,-64(1)
	mflr 0
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 29,36(1)
	stw 0,68(1)
	lis 9,deathmatch@ha
	lis 6,.LC244@ha
	lwz 11,deathmatch@l(9)
	la 6,.LC244@l(6)
	mr 30,3
	lfs 13,0(6)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L294
	lwz 9,84(30)
	lwz 11,3544(9)
	addi 10,9,740
	lwz 31,1788(9)
	slwi 11,11,2
	lwzx 9,10,11
	srawi 10,9,31
	xor 0,10,9
	subf 0,0,10
	srawi 0,0,31
	and. 31,31,0
	bc 12,2,.L299
	lwz 3,40(31)
	lis 4,.LC239@ha
	la 4,.LC239@l(4)
	bl strcmp
	srawi 6,3,31
	xor 0,6,3
	subf 0,0,6
	srawi 0,0,31
	and. 31,31,0
	bc 12,2,.L299
	lwz 3,40(31)
	lis 4,.LC240@ha
	la 4,.LC240@l(4)
	bl strcmp
	srawi 6,3,31
	xor 0,6,3
	subf 0,0,6
	srawi 0,0,31
	and. 31,31,0
	bc 12,2,.L299
	lwz 3,40(31)
	lis 4,.LC241@ha
	la 4,.LC241@l(4)
	bl strcmp
	srawi 6,3,31
	xor 0,6,3
	subf 0,0,6
	srawi 0,0,31
	and 31,31,0
.L299:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 9,11,16384
	bc 4,2,.L300
	li 29,0
	b .L301
.L300:
	lis 10,level@ha
	lwz 8,84(30)
	lwz 9,level@l(10)
	lis 0,0x4330
	lis 10,.LC245@ha
	lfs 12,3740(8)
	addi 9,9,10
	la 10,.LC245@l(10)
	xoris 9,9,0x8000
	lfd 13,0(10)
	stw 9,28(1)
	stw 0,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 7,12,0
	mfcr 29
	rlwinm 29,29,30,1
.L301:
	addic 11,31,-1
	subfe 0,11,31
	lis 6,.LC244@ha
	and. 9,0,29
	la 6,.LC244@l(6)
	lfs 30,0(6)
	bc 12,2,.L302
	lis 10,.LC246@ha
	la 10,.LC246@l(10)
	lfs 30,0(10)
.L302:
	cmpwi 0,31,0
	bc 12,2,.L304
	bl rand
	lis 0,0xb60b
	mr 9,3
	lwz 7,84(30)
	ori 0,0,24759
	srawi 10,9,31
	mulhw 0,9,0
	lis 8,0x4330
	lfs 0,3672(7)
	lis 6,.LC245@ha
	mr 4,31
	add 0,0,9
	la 6,.LC245@l(6)
	srawi 0,0,8
	lfd 13,0(6)
	mr 3,30
	subf 0,10,0
	mulli 0,0,360
	subf 9,0,9
	xoris 9,9,0x8000
	stw 9,28(1)
	stw 8,24(1)
	lfd 31,24(1)
	fsub 31,31,13
	frsp 31,31
	fsubs 0,0,31
	stfs 0,3672(7)
	bl Drop_Item
	lwz 9,84(30)
	lis 0,0x2
	lfs 0,3672(9)
	fadds 0,0,31
	stfs 0,3672(9)
	stw 0,284(3)
.L304:
	cmpwi 0,29,0
	bc 12,2,.L294
	lwz 9,84(30)
	lis 3,.LC242@ha
	la 3,.LC242@l(3)
	lfs 0,3672(9)
	fadds 0,0,30
	stfs 0,3672(9)
	bl FindItemByClassname
	mr 4,3
	mr 3,30
	bl Drop_Item
	lwz 7,84(30)
	lis 9,.LC245@ha
	lis 11,Touch_Item@ha
	la 9,.LC245@l(9)
	la 11,Touch_Item@l(11)
	lfs 0,3672(7)
	lis 6,level@ha
	lfd 10,0(9)
	lis 4,0x4330
	la 5,level@l(6)
	lis 9,.LC243@ha
	lis 10,G_FreeEdict@ha
	fsubs 0,0,30
	lfd 11,.LC243@l(9)
	la 10,G_FreeEdict@l(10)
	stfs 0,3672(7)
	lwz 0,284(3)
	stw 11,444(3)
	oris 0,0,0x2
	stw 0,284(3)
	lwz 9,level@l(6)
	lwz 11,84(30)
	xoris 9,9,0x8000
	lfs 12,4(5)
	stw 9,28(1)
	stw 4,24(1)
	lfd 13,24(1)
	lfs 0,3740(11)
	stw 10,436(3)
	fsub 13,13,10
	frsp 13,13
	fsubs 0,0,13
	fmadd 0,0,11,12
	frsp 0,0
	stfs 0,428(3)
.L294:
	lwz 0,68(1)
	mtlr 0
	lmw 29,36(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe3:
	.size	 TossClientWeapon,.Lfe3-TossClientWeapon
	.section	".rodata"
	.align 3
.LC247:
	.long 0x404ca5dc
	.long 0x1a63c1f8
	.align 2
.LC248:
	.long 0x0
	.align 2
.LC249:
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
	bc 12,2,.L307
	lis 9,g_edicts@ha
	xor 11,5,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,5,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L307
	lfs 11,12(5)
	lfs 13,4(5)
	lfs 10,4(31)
	lfs 0,8(5)
	b .L317
.L307:
	cmpwi 0,4,0
	bc 12,2,.L309
	lis 9,g_edicts@ha
	xor 11,4,31
	lwz 0,g_edicts@l(9)
	addic 9,11,-1
	subfe 10,9,11
	xor 0,4,0
	addic 11,0,-1
	subfe 9,11,0
	and. 0,9,10
	bc 12,2,.L309
	lfs 11,12(4)
	lfs 13,4(4)
	lfs 10,4(31)
	lfs 0,8(4)
.L317:
	lfs 9,8(31)
	lfs 12,12(31)
	fsubs 13,13,10
	fsubs 0,0,9
	fsubs 11,11,12
	stfs 13,8(1)
	stfs 0,12(1)
	stfs 11,16(1)
	b .L308
.L309:
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3596(9)
	b .L306
.L308:
	lis 9,.LC248@ha
	lfs 2,8(1)
	la 9,.LC248@l(9)
	lfs 13,0(9)
	fcmpu 0,2,13
	bc 12,2,.L311
	lfs 1,12(1)
	bl atan2
	lis 9,.LC247@ha
	lwz 11,84(31)
	lfd 0,.LC247@l(9)
	fmul 1,1,0
	frsp 1,1
	stfs 1,3596(11)
	b .L312
.L311:
	lwz 9,84(31)
	stfs 13,3596(9)
	lfs 0,12(1)
	fcmpu 0,0,13
	bc 4,1,.L313
	lwz 9,84(31)
	lis 0,0x42b4
	b .L318
.L313:
	bc 4,0,.L312
	lwz 9,84(31)
	lis 0,0xc2b4
.L318:
	stw 0,3596(9)
.L312:
	lwz 3,84(31)
	lis 9,.LC248@ha
	la 9,.LC248@l(9)
	lfs 0,0(9)
	lfs 13,3596(3)
	fcmpu 0,13,0
	bc 4,0,.L306
	lis 11,.LC249@ha
	la 11,.LC249@l(11)
	lfs 0,0(11)
	fadds 0,13,0
	stfs 0,3596(3)
.L306:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 LookAtKiller,.Lfe4-LookAtKiller
	.section	".rodata"
	.align 2
.LC250:
	.string	"off"
	.section	".sbss","aw",@nobits
	.align 2
i.42:
	.space	4
	.size	 i.42,4
	.section	".rodata"
	.align 2
.LC251:
	.string	"*death%i.wav"
	.align 2
.LC252:
	.long 0x0
	.align 3
.LC253:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC254:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl player_die
	.type	 player_die,@function
player_die:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 29,12(1)
	stw 0,36(1)
	mr 31,3
	mr 29,4
	mr 30,5
	bl rand
	lwz 9,84(31)
	lwz 0,3836(9)
	cmpwi 0,0,0
	bc 12,2,.L320
	lis 4,.LC250@ha
	mr 3,31
	la 4,.LC250@l(4)
	bl ChasecamRemove
	lwz 9,84(31)
	li 0,1
.L320:
	stw 0,1816(9)
	lis 9,.LC252@ha
	li 0,0
	lwz 8,84(31)
	la 9,.LC252@l(9)
	li 11,7
	stw 0,44(31)
	lfs 31,0(9)
	lis 10,0xc100
	li 9,1
	stw 0,48(31)
	stw 9,512(31)
	stw 0,52(31)
	stw 0,76(31)
	stfs 31,396(31)
	stw 11,260(31)
	stfs 31,392(31)
	stfs 31,388(31)
	stfs 31,16(31)
	stfs 31,24(31)
	stw 0,3768(8)
	lwz 9,492(31)
	lwz 0,184(31)
	cmpwi 0,9,0
	stw 10,208(31)
	ori 0,0,2
	stw 0,184(31)
	bc 4,2,.L322
	lis 9,level+4@ha
	lis 11,.LC253@ha
	lfs 0,level+4@l(9)
	la 11,.LC253@l(11)
	mr 3,31
	lfd 13,0(11)
	mr 4,29
	mr 5,30
	lwz 11,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3824(11)
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
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L323
	mr 3,31
	bl Cmd_Help_f
.L323:
	lis 9,game@ha
	li 8,0
	la 10,game@l(9)
	lwz 0,1556(10)
	cmpw 0,8,0
	bc 4,0,.L322
	lis 9,itemlist@ha
	lis 11,coop@ha
	la 9,itemlist@l(9)
	mr 4,10
	lwz 6,coop@l(11)
	addi 7,9,56
	li 5,0
	lis 9,.LC252@ha
	li 10,0
	la 9,.LC252@l(9)
	lfs 13,0(9)
.L327:
	lfs 0,20(6)
	fcmpu 0,0,13
	bc 12,2,.L328
	lwz 0,0(7)
	andi. 11,0,16
	bc 12,2,.L328
	lwz 9,84(31)
	addi 11,9,740
	lwzx 0,11,10
	addi 9,9,2376
	stwx 0,9,10
.L328:
	lwz 9,84(31)
	addi 8,8,1
	addi 7,7,80
	addi 9,9,740
	stwx 5,9,10
	lwz 0,1556(4)
	addi 10,10,4
	cmpw 0,8,0
	bc 12,0,.L327
.L322:
	lwz 11,84(31)
	li 0,0
	stw 0,3740(11)
	lwz 9,84(31)
	stw 0,3744(9)
	lwz 11,84(31)
	stw 0,3748(11)
	lwz 9,84(31)
	stw 0,3752(9)
	lwz 11,84(31)
	stw 0,3884(11)
	lwz 9,84(31)
	stw 0,3888(9)
	lwz 11,84(31)
	stw 0,912(31)
	stw 0,3876(11)
	lwz 10,480(31)
	lwz 9,264(31)
	cmpwi 0,10,-40
	stw 0,916(31)
	rlwinm 9,9,0,20,18
	stw 0,1084(31)
	stw 9,264(31)
	bc 12,0,.L331
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L331
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
	stw 7,3728(6)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L333
	li 0,172
	li 9,177
	b .L342
.L333:
	cmpwi 0,10,1
	bc 12,2,.L337
	bc 12,1,.L341
	cmpwi 0,10,0
	bc 12,2,.L336
	b .L334
.L341:
	cmpwi 0,10,2
	bc 12,2,.L338
	b .L334
.L336:
	li 0,177
	li 9,183
	b .L342
.L337:
	li 0,183
	li 9,189
	b .L342
.L338:
	li 0,189
	li 9,197
.L342:
	stw 0,56(31)
	stw 9,3724(11)
.L334:
	lis 29,gi@ha
	la 29,gi@l(29)
	bl rand
	mr 4,3
	srawi 0,4,31
	lis 3,.LC251@ha
	srwi 0,0,30
	la 3,.LC251@l(3)
	add 0,4,0
	rlwinm 0,0,0,0,29
	subf 4,0,4
	addi 4,4,1
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC254@ha
	lwz 0,16(29)
	lis 11,.LC254@ha
	la 9,.LC254@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC254@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC252@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC252@l(9)
	lfs 3,0(9)
	blrl
.L331:
	li 0,2
	lis 9,gi+72@ha
	stw 0,492(31)
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 player_die,.Lfe5-player_die
	.section	".rodata"
	.align 2
.LC255:
	.string	"bullets"
	.align 2
.LC256:
	.string	"Fists Of Fury"
	.align 2
.LC257:
	.string	"Gung Ho Knives"
	.align 2
.LC258:
	.string	"mk 23 pistol"
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
	li 5,1636
	addi 3,29,188
	crxor 6,6,6
	bl memset
	lis 27,0xcccc
	addi 26,29,740
	lis 3,.LC255@ha
	ori 27,27,52429
	la 3,.LC255@l(3)
	li 25,50
	bl FindItem
	li 24,2
	lis 28,itemlist@ha
	lis 9,.LC256@ha
	la 28,itemlist@l(28)
	subf 0,28,3
	mullw 0,0,27
	la 3,.LC256@l(9)
	srawi 0,0,4
	slwi 9,0,2
	stw 0,736(29)
	stwx 25,26,9
	bl FindItem
	subf 0,28,3
	mullw 0,0,27
	lis 3,.LC257@ha
	la 3,.LC257@l(3)
	srawi 0,0,4
	slwi 9,0,2
	stw 0,736(29)
	stwx 24,26,9
	bl FindItem
	subf 0,28,3
	li 11,10
	mullw 0,0,27
	lis 3,.LC258@ha
	la 3,.LC258@l(3)
	srawi 0,0,4
	slwi 9,0,2
	stw 0,736(29)
	stwx 11,26,9
	bl FindItem
	subf 28,28,3
	li 9,100
	mullw 28,28,27
	li 10,200
	li 8,1
	li 11,0
	srawi 28,28,4
	slwi 0,28,2
	stw 28,736(29)
	stwx 24,26,0
	stw 11,1816(29)
	stw 3,1788(29)
	stw 9,1768(29)
	stw 10,1780(29)
	stw 25,1784(29)
	stw 8,720(29)
	stw 9,724(29)
	stw 9,728(29)
	stw 10,1764(29)
	stw 25,1772(29)
	stw 25,1776(29)
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 InitClientPersistant,.Lfe6-InitClientPersistant
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
	addi 10,10,1116
	lfs 13,0(9)
.L349:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L348
	lwz 11,84(10)
	la 8,game@l(4)
	lwz 9,1028(8)
	lwz 0,3836(11)
	add 9,7,9
	stw 0,1816(9)
	lwz 11,1028(8)
	lwz 0,480(10)
	add 11,7,11
	stw 0,724(11)
	lwz 9,1028(8)
	lwz 0,484(10)
	add 9,7,9
	stw 0,728(9)
	lwz 11,1028(8)
	lwz 0,264(10)
	add 11,7,11
	andi. 0,0,4144
	stw 0,732(11)
	lfs 0,20(5)
	fcmpu 0,0,13
	bc 12,2,.L348
	lwz 9,84(10)
	lwz 11,1028(8)
	lwz 0,3464(9)
	add 11,7,11
	stw 0,1800(11)
.L348:
	lwz 0,1544(3)
	addi 6,6,1
	addi 7,7,3916
	addi 10,10,1116
	cmpw 0,6,0
	bc 12,0,.L349
	blr
.Lfe7:
	.size	 SaveClientData,.Lfe7-SaveClientData
	.section	".rodata"
	.align 2
.LC262:
	.string	"info_player_deathmatch"
	.align 2
.LC261:
	.long 0x47c34f80
	.align 2
.LC263:
	.long 0x4b18967f
	.align 2
.LC264:
	.long 0x3f800000
	.align 3
.LC265:
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
	lis 9,.LC261@ha
	li 28,0
	lfs 29,.LC261@l(9)
	li 30,0
	li 23,0
	li 24,0
	fmr 28,29
	lis 22,.LC262@ha
	b .L365
.L367:
	lis 10,.LC264@ha
	lis 9,maxclients@ha
	la 10,.LC264@l(10)
	lis 11,.LC263@ha
	lfs 13,0(10)
	addi 28,28,1
	li 29,1
	lwz 10,maxclients@l(9)
	lis 25,maxclients@ha
	lfs 31,.LC263@l(11)
	lfs 0,20(10)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L375
	lis 11,.LC265@ha
	lis 26,g_edicts@ha
	la 11,.LC265@l(11)
	lis 27,0x4330
	lfd 30,0(11)
	li 31,1116
.L370:
	lwz 0,g_edicts@l(26)
	add 11,0,31
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L372
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L372
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
	bc 4,0,.L372
	fmr 31,1
.L372:
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
	bc 12,3,.L370
.L375:
	fcmpu 0,31,28
	bc 4,0,.L377
	fmr 28,31
	mr 24,30
	b .L365
.L377:
	fcmpu 0,31,29
	bc 4,0,.L365
	fmr 29,31
	mr 23,30
.L365:
	lis 5,.LC262@ha
	mr 3,30
	la 5,.LC262@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L367
	cmpwi 0,28,0
	bc 4,2,.L381
	li 3,0
	b .L389
.L381:
	cmpwi 0,28,2
	bc 12,1,.L382
	li 23,0
	li 24,0
	b .L383
.L382:
	addi 28,28,-2
.L383:
	bl rand
	li 30,0
	divw 0,3,28
	mullw 0,0,28
	subf 31,0,3
.L388:
	mr 3,30
	li 4,280
	la 5,.LC262@l(22)
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
	bc 4,2,.L388
.L389:
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
	.size	 SelectRandomDeathmatchSpawnPoint,.Lfe8-SelectRandomDeathmatchSpawnPoint
	.section	".rodata"
	.align 2
.LC266:
	.long 0x4b18967f
	.align 2
.LC267:
	.long 0x0
	.align 2
.LC268:
	.long 0x3f800000
	.align 3
.LC269:
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
	lis 9,.LC267@ha
	li 31,0
	la 9,.LC267@l(9)
	li 25,0
	lfs 29,0(9)
	b .L391
.L393:
	lis 9,maxclients@ha
	lis 11,.LC268@ha
	lwz 10,maxclients@l(9)
	la 11,.LC268@l(11)
	li 29,1
	lfs 13,0(11)
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC266@ha
	lfs 31,.LC266@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L401
	lis 9,.LC269@ha
	lis 27,g_edicts@ha
	la 9,.LC269@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,1116
.L396:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L398
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L398
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
	bc 4,0,.L398
	fmr 31,1
.L398:
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
	bc 12,3,.L396
.L401:
	fcmpu 0,31,29
	bc 4,1,.L391
	fmr 29,31
	mr 25,31
.L391:
	lis 30,.LC262@ha
	mr 3,31
	li 4,280
	la 5,.LC262@l(30)
	bl G_Find
	mr. 31,3
	bc 4,2,.L393
	cmpwi 0,25,0
	mr 3,25
	bc 4,2,.L406
	la 5,.LC262@l(30)
	li 3,0
	li 4,280
	bl G_Find
.L406:
	lwz 0,100(1)
	mtlr 0
	lmw 25,44(1)
	lfd 29,72(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe9:
	.size	 SelectFarthestDeathmatchSpawnPoint,.Lfe9-SelectFarthestDeathmatchSpawnPoint
	.section	".rodata"
	.align 2
.LC270:
	.string	"Couldn't find spawn point %s\n"
	.align 2
.LC271:
	.long 0x0
	.align 2
.LC272:
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
	lis 11,.LC271@ha
	lis 9,deathmatch@ha
	la 11,.LC271@l(11)
	mr 26,4
	lfs 13,0(11)
	mr 25,5
	li 30,0
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L421
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,512
	bc 12,2,.L422
	bl SelectFarthestDeathmatchSpawnPoint
	mr 30,3
	b .L425
.L422:
	bl SelectRandomDeathmatchSpawnPoint
	mr 30,3
	b .L425
.L449:
	li 30,0
	b .L425
.L421:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L425
	lis 11,game+1028@ha
	lwz 0,84(3)
	lis 9,0xe834
	lwz 10,game+1028@l(11)
	ori 9,9,19547
	li 29,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,2
	bc 12,2,.L425
	lis 27,.LC2@ha
	lis 28,.LC29@ha
	lis 30,game+1032@ha
.L431:
	mr 3,29
	li 4,280
	la 5,.LC2@l(27)
	bl G_Find
	mr. 29,3
	bc 12,2,.L449
	lwz 4,300(29)
	la 9,.LC29@l(28)
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
	bc 4,2,.L431
	addic. 31,31,-1
	bc 4,2,.L431
	mr 30,29
.L425:
	cmpwi 0,30,0
	bc 4,2,.L437
	lis 29,.LC0@ha
	lis 31,game@ha
.L444:
	mr 3,30
	li 4,280
	la 5,.LC0@l(29)
	bl G_Find
	mr. 30,3
	bc 12,2,.L450
	la 3,game@l(31)
	lbz 0,1032(3)
	cmpwi 0,0,0
	bc 4,2,.L448
	lwz 0,300(30)
	cmpwi 0,0,0
	bc 12,2,.L439
	b .L444
.L448:
	lwz 4,300(30)
	cmpwi 0,4,0
	bc 12,2,.L444
	addi 3,3,1032
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L444
.L439:
	cmpwi 0,30,0
	bc 4,2,.L437
.L450:
	lis 9,game@ha
	la 31,game@l(9)
	lbz 0,1032(31)
	cmpwi 0,0,0
	bc 4,2,.L446
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,280
	bl G_Find
	mr 30,3
.L446:
	cmpwi 0,30,0
	bc 4,2,.L437
	lis 9,gi+28@ha
	lis 3,.LC270@ha
	lwz 0,gi+28@l(9)
	la 3,.LC270@l(3)
	addi 4,31,1032
	mtlr 0
	crxor 6,6,6
	blrl
.L437:
	lfs 0,4(30)
	lis 9,.LC272@ha
	la 9,.LC272@l(9)
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
.Lfe10:
	.size	 SelectSpawnPoint,.Lfe10-SelectSpawnPoint
	.section	".rodata"
	.align 2
.LC273:
	.string	"bodyque"
	.align 2
.LC274:
	.string	"misc/udeath.wav"
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
	mulli 27,27,1116
	addi 27,27,1116
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
	lis 9,0xbfc5
	lis 11,body_die@ha
	ori 9,9,18087
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
.Lfe11:
	.size	 CopyToBodyQue,.Lfe11-CopyToBodyQue
	.section	".rodata"
	.align 2
.LC275:
	.string	"menu_loadgame\n"
	.align 2
.LC276:
	.string	"spectator"
	.align 2
.LC277:
	.string	"none"
	.align 2
.LC278:
	.string	"Spectator password incorrect.\n"
	.align 2
.LC279:
	.string	"spectator 0\n"
	.align 2
.LC280:
	.string	"Server spectator limit is full."
	.align 2
.LC281:
	.string	"password"
	.align 2
.LC282:
	.string	"Password incorrect.\n"
	.align 2
.LC283:
	.string	"spectator 1\n"
	.align 2
.LC284:
	.string	"%s has moved to the sidelines\n"
	.align 2
.LC285:
	.string	"%s joined the game\n"
	.align 2
.LC286:
	.long 0x3f800000
	.align 3
.LC287:
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
	bc 12,2,.L467
	lis 4,.LC276@ha
	addi 3,3,188
	la 4,.LC276@l(4)
	lis 30,spectator_password@ha
	bl Info_ValueForKey
	lwz 9,spectator_password@l(30)
	mr 29,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L468
	lis 4,.LC277@ha
	la 4,.LC277@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L468
	lwz 9,spectator_password@l(30)
	mr 4,29
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L468
	lis 29,gi@ha
	lis 5,.LC278@ha
	la 29,gi@l(29)
	li 4,2
	lwz 9,8(29)
	la 5,.LC278@l(5)
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
	lis 3,.LC279@ha
	la 3,.LC279@l(3)
	b .L483
.L468:
	lis 9,maxclients@ha
	lis 10,.LC286@ha
	lwz 11,maxclients@l(9)
	la 10,.LC286@l(10)
	li 7,1
	lfs 0,0(10)
	li 8,0
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L470
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC287@ha
	la 9,.LC287@l(9)
	addi 10,11,1116
	lfd 13,0(9)
.L472:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L471
	lwz 11,84(10)
	addi 9,8,1
	lwz 0,1812(11)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L471:
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
	bc 12,3,.L472
.L470:
	xoris 0,8,0x8000
	lis 11,0x4330
	stw 0,12(1)
	lis 10,.LC287@ha
	la 10,.LC287@l(10)
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
	bc 4,3,.L475
	lis 29,gi@ha
	lis 5,.LC280@ha
	la 29,gi@l(29)
	li 4,2
	lwz 9,8(29)
	la 5,.LC280@l(5)
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
	lis 3,.LC279@ha
	la 3,.LC279@l(3)
	b .L483
.L475:
	lwz 9,84(31)
	lwz 0,3836(9)
	cmpwi 0,0,0
	bc 12,2,.L484
	lis 4,.LC250@ha
	mr 3,31
	la 4,.LC250@l(4)
	bl ChasecamRemove
	lwz 9,84(31)
	li 0,1
.L484:
	stw 0,1816(9)
	b .L478
.L467:
	lis 4,.LC281@ha
	addi 3,3,188
	la 4,.LC281@l(4)
	lis 29,password@ha
	bl Info_ValueForKey
	lis 28,gi@ha
	lwz 9,password@l(29)
	mr 30,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L478
	lis 4,.LC277@ha
	la 4,.LC277@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L478
	lwz 9,password@l(29)
	mr 4,30
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L478
	la 29,gi@l(28)
	lis 5,.LC282@ha
	lwz 9,8(29)
	li 4,2
	la 5,.LC282@l(5)
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
	lis 3,.LC283@ha
	la 3,.LC283@l(3)
.L483:
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,31
	li 4,1
	mtlr 0
	blrl
	b .L466
.L478:
	lwz 11,84(31)
	li 9,0
	mr 3,31
	stw 9,3464(11)
	stw 9,1800(11)
	lwz 0,184(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	bl PutClientInServer
	lwz 9,84(31)
	lwz 0,1812(9)
	cmpwi 0,0,0
	bc 4,2,.L480
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
.L480:
	lis 9,level+4@ha
	lwz 11,84(31)
	lfs 0,level+4@l(9)
	stfs 0,3824(11)
	lwz 3,84(31)
	lwz 0,1812(3)
	cmpwi 0,0,0
	bc 12,2,.L481
	lis 9,gi@ha
	lis 4,.LC284@ha
	lwz 0,gi@l(9)
	addi 5,3,700
	la 4,.LC284@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L466
.L481:
	lis 9,gi@ha
	lis 4,.LC285@ha
	lwz 0,gi@l(9)
	addi 5,3,700
	la 4,.LC285@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L466:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 spectator_respawn,.Lfe12-spectator_respawn
	.section	".rodata"
	.align 2
.LC288:
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.align 2
.LC289:
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.align 2
.LC290:
	.string	"player"
	.align 2
.LC291:
	.string	"players/male/tris.md2"
	.align 2
.LC292:
	.string	"fov"
	.align 2
.LC293:
	.long 0x0
	.align 2
.LC294:
	.long 0x41400000
	.align 2
.LC295:
	.long 0x41000000
	.align 3
.LC296:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC297:
	.long 0x3f800000
	.align 2
.LC298:
	.long 0x43200000
	.align 2
.LC299:
	.long 0x47800000
	.align 2
.LC300:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl PutClientInServer
	.type	 PutClientInServer,@function
PutClientInServer:
	stwu 1,-3984(1)
	mflr 0
	stfd 31,3976(1)
	stmw 21,3932(1)
	stw 0,3988(1)
	lis 9,.LC288@ha
	lis 8,.LC289@ha
	lwz 0,.LC288@l(9)
	la 29,.LC289@l(8)
	addi 10,1,8
	la 9,.LC288@l(9)
	lwz 11,.LC289@l(8)
	mr 31,3
	lwz 28,8(9)
	addi 7,1,24
	addi 5,1,56
	lwz 6,4(9)
	mr 21,5
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
	lis 8,.LC293@ha
	lis 9,deathmatch@ha
	lwz 30,84(31)
	la 8,.LC293@l(8)
	li 11,0
	lfs 13,0(8)
	lis 10,g_edicts@ha
	lis 0,0xbfc5
	lwz 8,deathmatch@l(9)
	ori 0,0,18087
	stw 11,1068(31)
	stw 11,1064(31)
	lfs 0,20(8)
	lwz 9,g_edicts@l(10)
	lwz 24,1816(30)
	subf 9,9,31
	fcmpu 0,0,13
	mullw 9,9,0
	srawi 9,9,2
	addi 23,9,-1
	bc 12,2,.L486
	addi 28,1,2232
	addi 27,30,1824
	addi 26,1,72
	mr 4,27
	li 5,1676
	mr 3,28
	crxor 6,6,6
	bl memcpy
	addi 29,30,188
	mr 22,28
	mr 4,29
	li 5,512
	mr 3,26
	mr 25,29
	crxor 6,6,6
	bl memcpy
	mr 3,30
	bl InitClientPersistant
	mr 4,26
	mr 3,31
	bl ClientUserinfoChanged
	b .L487
.L486:
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L488
	addi 28,1,2232
	addi 27,30,1824
	mr 4,27
	li 5,1676
	mr 3,28
	addi 29,30,188
	crxor 6,6,6
	bl memcpy
	mr 22,28
	mr 25,29
	addi 26,1,72
	mr 4,29
	li 5,512
	mr 3,26
	crxor 6,6,6
	bl memcpy
	lwz 9,1804(30)
	mr 4,28
	li 5,1636
	mr 3,29
	stw 9,3848(1)
	lwz 0,1808(30)
	stw 0,3852(1)
	crxor 6,6,6
	bl memcpy
	mr 4,26
	mr 3,31
	bl ClientUserinfoChanged
	lwz 9,3872(1)
	lwz 0,1800(30)
	cmpw 0,9,0
	bc 4,1,.L487
	stw 9,1800(30)
	b .L487
.L488:
	addi 27,1,2232
	li 4,0
	li 5,1676
	mr 3,27
	crxor 6,6,6
	bl memset
	addi 29,30,188
	mr 22,27
	addi 28,1,72
	mr 4,29
	li 5,512
	mr 3,28
	crxor 6,6,6
	bl memcpy
	mr 25,29
	addi 27,30,1824
	mr 4,28
	mr 3,31
	bl ClientUserinfoChanged
.L487:
	addi 29,1,584
	mr 4,25
	li 5,1636
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 4,0
	li 5,3916
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
	bc 12,1,.L491
	mr 3,30
	bl InitClientPersistant
.L491:
	lis 8,.LC293@ha
	mr 3,27
	la 8,.LC293@l(8)
	mr 4,22
	lfs 31,0(8)
	li 5,1676
	crxor 6,6,6
	bl memcpy
	stw 24,1816(30)
	lis 10,coop@ha
	lwz 7,84(31)
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
	bc 12,2,.L493
	lwz 0,1800(7)
	stw 0,3464(7)
.L493:
	li 6,0
	lis 11,game+1028@ha
	mulli 8,23,3916
	lwz 3,264(31)
	stw 6,552(31)
	li 0,4
	lis 9,.LC290@ha
	lwz 7,game+1028@l(11)
	li 5,2
	la 9,.LC290@l(9)
	stw 0,260(31)
	li 11,22
	li 10,1
	add 7,7,8
	li 0,200
	stw 11,508(31)
	lis 8,.LC294@ha
	stw 10,88(31)
	lis 29,level+4@ha
	stw 9,280(31)
	la 8,.LC294@l(8)
	lis 11,0x201
	stw 0,400(31)
	lis 10,.LC291@ha
	lis 9,player_pain@ha
	stw 5,248(31)
	la 10,.LC291@l(10)
	la 9,player_pain@l(9)
	stw 7,84(31)
	ori 11,11,3
	rlwinm 3,3,0,21,19
	stw 5,512(31)
	li 4,0
	stw 6,492(31)
	li 5,184
	lfs 0,level+4@l(29)
	lfs 13,0(8)
	lwz 0,184(31)
	lis 8,player_die@ha
	la 8,player_die@l(8)
	stw 11,252(31)
	fadds 0,0,13
	rlwinm 0,0,0,0,29
	stw 10,268(31)
	stw 9,452(31)
	stw 8,456(31)
	stw 3,264(31)
	stfs 0,404(31)
	stw 6,608(31)
	stw 0,184(31)
	stw 6,612(31)
	lbz 0,16(7)
	andi. 0,0,191
	stb 0,16(7)
	lfs 0,8(1)
	lfs 13,12(1)
	lfs 12,16(1)
	lfs 11,24(1)
	lfs 10,28(1)
	stfs 0,188(31)
	stfs 13,192(31)
	stfs 12,196(31)
	stfs 11,200(31)
	stfs 10,204(31)
	lfs 0,32(1)
	lwz 3,84(31)
	stfs 31,384(31)
	stfs 0,208(31)
	stfs 31,380(31)
	stfs 31,376(31)
	crxor 6,6,6
	bl memset
	lis 8,.LC295@ha
	lfs 0,40(1)
	la 8,.LC295@l(8)
	mr 10,11
	lfs 10,0(8)
	lis 9,deathmatch@ha
	mr 8,11
	lwz 7,deathmatch@l(9)
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,3920(1)
	lwz 11,3924(1)
	sth 11,4(30)
	lfs 0,44(1)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,3920(1)
	lwz 10,3924(1)
	sth 10,6(30)
	lfs 0,48(1)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,3920(1)
	lwz 8,3924(1)
	sth 8,8(30)
	lfs 0,20(7)
	fcmpu 0,0,31
	bc 12,2,.L494
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,3920(1)
	lwz 11,3924(1)
	andi. 9,11,32768
	bc 4,2,.L512
.L494:
	lis 4,.LC292@ha
	mr 3,25
	la 4,.LC292@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	stw 3,3924(1)
	lis 0,0x4330
	lis 8,.LC296@ha
	la 8,.LC296@l(8)
	stw 0,3920(1)
	lis 11,.LC297@ha
	lfd 13,0(8)
	la 11,.LC297@l(11)
	lfd 0,3920(1)
	lfs 12,0(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	stfs 0,112(30)
	bc 4,0,.L496
.L512:
	lis 0,0x42b4
	stw 0,112(30)
	b .L495
.L496:
	lis 8,.LC298@ha
	la 8,.LC298@l(8)
	lfs 13,0(8)
	fcmpu 0,0,13
	bc 4,1,.L495
	stfs 13,112(30)
.L495:
	lwz 11,84(31)
	lwz 9,1788(11)
	lwz 0,76(9)
	cmpwi 0,0,0
	bc 12,2,.L499
	li 0,1
	stw 0,3912(11)
.L499:
	lwz 9,84(31)
	lwz 0,3912(9)
	cmpwi 0,0,0
	bc 12,2,.L500
	lis 11,gi+32@ha
	lwz 9,1788(9)
	lwz 0,gi+32@l(11)
	lwz 3,76(9)
	mtlr 0
	blrl
	lwz 9,84(31)
	stw 3,88(9)
	b .L501
.L500:
	lis 9,gi+32@ha
	lwz 11,1788(30)
	lwz 0,gi+32@l(9)
	lwz 3,32(11)
	mtlr 0
	blrl
	stw 3,88(30)
.L501:
	lis 11,g_edicts@ha
	lis 8,.LC297@ha
	lfs 13,48(1)
	lwz 9,g_edicts@l(11)
	la 8,.LC297@l(8)
	lis 0,0xbfc5
	lfs 0,0(8)
	ori 0,0,18087
	li 11,0
	subf 9,9,31
	lis 8,.LC299@ha
	lfs 12,40(1)
	mullw 9,9,0
	la 8,.LC299@l(8)
	li 10,255
	fadds 13,13,0
	lfs 10,0(8)
	li 0,3
	mr 5,21
	lfs 0,44(1)
	lis 8,.LC300@ha
	mtctr 0
	srawi 9,9,2
	la 8,.LC300@l(8)
	addi 9,9,-1
	stw 10,44(31)
	lfs 11,0(8)
	addi 6,30,3468
	addi 7,30,20
	stw 11,56(31)
	li 8,0
	stfs 12,28(31)
	stfs 0,32(31)
	stw 9,60(31)
	stfs 13,36(31)
	stw 11,64(31)
	stw 10,40(31)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
.L511:
	lfsx 0,8,5
	lfsx 12,8,6
	addi 8,8,4
	fsubs 0,0,12
	fmuls 0,0,10
	fdivs 0,0,11
	fctiwz 13,0
	stfd 13,3920(1)
	lwz 9,3924(1)
	sth 9,0(7)
	addi 7,7,2
	bdnz .L511
	lfs 0,60(1)
	li 0,0
	stw 0,24(31)
	stw 0,16(31)
	stfs 0,20(31)
	stw 0,28(30)
	lfs 13,20(31)
	lwz 29,1812(30)
	stfs 13,32(30)
	cmpwi 0,29,0
	lfs 0,24(31)
	stfs 0,36(30)
	lfs 13,16(31)
	stfs 13,3668(30)
	lfs 0,20(31)
	stfs 0,3672(30)
	lfs 13,24(31)
	stfs 13,3676(30)
	bc 12,2,.L507
	li 9,0
	li 10,1
	stw 10,3480(30)
	lis 8,gi+72@ha
	mr 3,31
	stw 9,3828(30)
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
	b .L485
.L507:
	stw 29,3480(30)
	mr 3,31
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 9,84(31)
	stw 29,3836(9)
	lwz 11,84(31)
	lwz 0,1816(11)
	cmpwi 0,0,0
	bc 12,2,.L510
	mr 3,31
	bl ChasecamStart
.L510:
	mr 3,31
	crxor 6,6,6
	bl MatrixClientInit
	lwz 0,1788(30)
	mr 3,31
	stw 0,3564(30)
	bl ChangeWeapon
.L485:
	lwz 0,3988(1)
	mtlr 0
	lmw 21,3932(1)
	lfd 31,3976(1)
	la 1,3984(1)
	blr
.Lfe13:
	.size	 PutClientInServer,.Lfe13-PutClientInServer
	.section	".rodata"
	.align 2
.LC301:
	.string	"%s entered the game\n"
	.align 2
.LC302:
	.long 0x0
	.section	".text"
	.align 2
	.globl ClientBeginDeathmatch
	.type	 ClientBeginDeathmatch,@function
ClientBeginDeathmatch:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	bl G_InitEdict
	lwz 28,84(31)
	li 4,0
	li 5,1676
	addi 27,28,1824
	mr 3,27
	crxor 6,6,6
	bl memset
	lis 29,level@ha
	addi 4,28,188
	lwz 0,level@l(29)
	li 5,1636
	mr 3,27
	la 29,level@l(29)
	stw 0,3460(28)
	crxor 6,6,6
	bl memcpy
	mr 3,31
	bl PutClientInServer
	lis 9,.LC302@ha
	lfs 13,200(29)
	la 9,.LC302@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L515
	mr 3,31
	bl MoveClientToIntermission
	b .L516
.L515:
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
.L516:
	lis 9,gi@ha
	lwz 5,84(31)
	lis 4,.LC301@ha
	lwz 0,gi@l(9)
	la 4,.LC301@l(4)
	li 3,2
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	crxor 6,6,6
	bl MatrixBeginDM
	mr 3,31
	bl ClientEndServerFrame
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 ClientBeginDeathmatch,.Lfe14-ClientBeginDeathmatch
	.section	".rodata"
	.align 2
.LC303:
	.string	"alias +button0 onbutton0\nalias -button0 offbutton0\nalias +button1 onbutton1\nalias -button1 offbutton1\nalias +boot booton\nalias -boot bootoff\nalias +attack2 booton\nalias -attack2 bootoff"
	.align 2
.LC304:
	.string	"alias +button0 onbutton0\nalias -button0 offbutton0\nalias +button1 onbutton1\nalias -button1 offbutton1\nalias +dodge dodgeon\nalias -dodge dodgeoff\nalias +attack2 dodgeon\nalias -attack2 dodgeoff"
	.align 2
.LC305:
	.long 0x0
	.align 3
.LC306:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC307:
	.long 0x47800000
	.align 2
.LC308:
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
	lis 0,0xbfc5
	lis 10,deathmatch@ha
	ori 0,0,18087
	lis 11,game+1028@ha
	subf 9,9,31
	lwz 8,game+1028@l(11)
	mullw 9,9,0
	lwz 11,deathmatch@l(10)
	lis 10,.LC305@ha
	srawi 9,9,2
	la 10,.LC305@l(10)
	mulli 9,9,3916
	lfs 13,0(10)
	addi 9,9,-3916
	add 8,8,9
	stw 8,84(31)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L518
	bl ClientBeginDeathmatch
	b .L517
.L518:
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 10,0x4330
	lis 4,.LC303@ha
	lis 9,.LC306@ha
	la 4,.LC303@l(4)
	xoris 0,0,0x8000
	la 9,.LC306@l(9)
	stw 0,12(1)
	mr 3,31
	stw 10,8(1)
	lfd 13,0(9)
	lfd 0,8(1)
	lis 9,matrix+24@ha
	fsub 0,0,13
	frsp 0,0
	stfs 0,matrix+24@l(9)
	crxor 6,6,6
	bl stuffcmd
	lis 4,.LC304@ha
	mr 3,31
	la 4,.LC304@l(4)
	crxor 6,6,6
	bl stuffcmd
	lwz 0,88(31)
	cmpwi 0,0,1
	bc 4,2,.L520
	lis 9,.LC307@ha
	lis 10,.LC308@ha
	li 11,3
	la 9,.LC307@l(9)
	la 10,.LC308@l(10)
	mtctr 11
	lfs 11,0(9)
	li 8,0
	lfs 12,0(10)
	li 7,0
.L531:
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
	bdnz .L531
	b .L526
.L520:
	mr 3,31
	bl G_InitEdict
	lwz 29,84(31)
	lis 9,.LC290@ha
	li 4,0
	la 9,.LC290@l(9)
	li 5,1676
	addi 28,29,1824
	stw 9,280(31)
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
	mr 3,31
	bl PutClientInServer
.L526:
	lis 10,.LC305@ha
	lis 9,level+200@ha
	la 10,.LC305@l(10)
	lfs 0,level+200@l(9)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 12,2,.L528
	mr 3,31
	bl MoveClientToIntermission
	b .L529
.L528:
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L529
	lis 28,gi@ha
	li 3,1
	la 29,gi@l(28)
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
	li 4,2
	addi 3,31,4
	mtlr 0
	blrl
	lwz 5,84(31)
	lis 4,.LC301@ha
	li 3,2
	lwz 0,gi@l(28)
	la 4,.LC301@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L529:
	mr 3,31
	bl ClientEndServerFrame
.L517:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 ClientBegin,.Lfe15-ClientBegin
	.section	".rodata"
	.align 2
.LC309:
	.string	"\\name\\badinfo\\skin\\male/grunt"
	.align 2
.LC310:
	.string	"name"
	.align 2
.LC311:
	.string	"0"
	.align 2
.LC312:
	.string	"skin"
	.align 2
.LC313:
	.string	"%s\\%s"
	.align 2
.LC314:
	.string	"hand"
	.align 2
.LC315:
	.long 0x0
	.align 3
.LC316:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC317:
	.long 0x3f800000
	.align 2
.LC318:
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
	bc 4,2,.L533
	lis 11,.LC309@ha
	lwz 0,.LC309@l(11)
	la 9,.LC309@l(11)
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
.L533:
	lis 4,.LC310@ha
	mr 3,30
	la 4,.LC310@l(4)
	bl Info_ValueForKey
	lwz 9,84(27)
	mr 31,3
	li 5,15
	mr 4,31
	addi 3,9,700
	bl strncpy
	lis 4,.LC276@ha
	mr 3,30
	la 4,.LC276@l(4)
	bl Info_ValueForKey
	lis 9,deathmatch@ha
	lis 10,.LC315@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC315@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L536
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L536
	lis 4,.LC311@ha
	la 4,.LC311@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L535
.L536:
	lwz 10,84(27)
	lwz 0,3484(10)
	cmpwi 0,0,0
	bc 4,2,.L537
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lis 9,.LC315@ha
	la 9,.LC315@l(9)
	lfs 0,20(11)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L535
.L537:
	lwz 0,3488(10)
	cmpwi 0,0,0
	bc 12,2,.L534
	lis 11,tankmode@ha
	lis 10,.LC315@ha
	lwz 9,tankmode@l(11)
	la 10,.LC315@l(10)
	lfs 13,0(10)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L534
.L535:
	lwz 9,84(27)
	li 0,1
	b .L547
.L534:
	lwz 9,84(27)
	li 0,0
.L547:
	stw 0,1812(9)
	lis 4,.LC312@ha
	mr 3,30
	la 4,.LC312@l(4)
	bl Info_ValueForKey
	lis 9,teamplay@ha
	lis 11,g_edicts@ha
	lwz 10,teamplay@l(9)
	mr 31,3
	lis 9,.LC315@ha
	lwz 0,g_edicts@l(11)
	la 9,.LC315@l(9)
	lfs 0,20(10)
	lfs 13,0(9)
	subf 0,0,27
	lis 9,0xbfc5
	ori 9,9,18087
	fcmpu 0,0,13
	mullw 0,0,9
	srawi 28,0,2
	bc 12,2,.L539
	mr 4,31
	mr 3,27
	crxor 6,6,6
	bl AssignSkin
	b .L540
.L539:
	lwz 4,84(27)
	lis 29,gi@ha
	lis 3,.LC313@ha
	la 29,gi@l(29)
	addi 28,28,1311
	addi 4,4,700
	la 3,.LC313@l(3)
	mr 5,31
	crxor 6,6,6
	bl va
	lwz 0,24(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
.L540:
	lis 9,.LC315@ha
	lis 11,deathmatch@ha
	la 9,.LC315@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L541
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 10,11,32768
	bc 12,2,.L541
	lwz 9,84(27)
	b .L548
.L541:
	lis 4,.LC292@ha
	mr 3,30
	la 4,.LC292@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	lwz 11,84(27)
	stw 3,20(1)
	lis 0,0x4330
	lis 10,.LC316@ha
	la 10,.LC316@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC317@ha
	la 10,.LC317@l(10)
	lfs 12,0(10)
	fsub 0,0,13
	frsp 0,0
	stfs 0,112(11)
	lwz 9,84(27)
	lfs 0,112(9)
	fcmpu 0,0,12
	bc 4,0,.L543
.L548:
	lis 0,0x42b4
	stw 0,112(9)
	b .L542
.L543:
	lis 11,.LC318@ha
	la 11,.LC318@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L542
	stfs 13,112(9)
.L542:
	lis 4,.LC314@ha
	mr 3,30
	la 4,.LC314@l(4)
	bl Info_ValueForKey
	mr 31,3
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L546
	mr 3,31
	bl atoi
	lwz 9,84(27)
	stw 3,716(9)
.L546:
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
.LC319:
	.string	"ip"
	.align 2
.LC320:
	.string	"rejmsg"
	.align 2
.LC321:
	.string	"Banned."
	.align 2
.LC322:
	.string	"neo"
	.align 2
.LC323:
	.string	"morpheus"
	.align 2
.LC324:
	.string	"trinity"
	.align 2
.LC325:
	.string	"Please don't use names from the film.\n This gets confusing if everyone does it."
	.align 2
.LC326:
	.string	"Faglimit hit. Another %s tried to join the game.\n"
	.align 2
.LC327:
	.string	"Spectator password required or incorrect."
	.align 2
.LC328:
	.string	"Password required or incorrect."
	.align 2
.LC329:
	.string	"%s connected\n"
	.align 2
.LC330:
	.long 0x0
	.align 3
.LC331:
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
	lis 4,.LC319@ha
	mr 3,28
	la 4,.LC319@l(4)
	bl Info_ValueForKey
	bl SV_FilterPacket
	cmpwi 0,3,0
	bc 12,2,.L550
	lis 4,.LC320@ha
	lis 5,.LC321@ha
	mr 3,28
	la 4,.LC320@l(4)
	la 5,.LC321@l(5)
	b .L571
.L550:
	lis 9,.LC330@ha
	lis 11,faglimit@ha
	la 9,.LC330@l(9)
	lfs 13,0(9)
	lwz 9,faglimit@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L551
	lwz 3,84(30)
	lis 4,.LC322@ha
	la 4,.LC322@l(4)
	addi 3,3,700
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L553
	lwz 3,84(30)
	lis 4,.LC323@ha
	la 4,.LC323@l(4)
	addi 3,3,700
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L553
	lwz 3,84(30)
	lis 4,.LC324@ha
	la 4,.LC324@l(4)
	addi 3,3,700
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L552
.L553:
	lis 4,.LC320@ha
	lis 5,.LC325@ha
	mr 3,28
	la 4,.LC320@l(4)
	la 5,.LC325@l(5)
	b .L571
.L552:
	lis 9,gi@ha
	lwz 5,84(30)
	lis 4,.LC326@ha
	lwz 0,gi@l(9)
	la 4,.LC326@l(4)
	li 3,2
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L551:
	lis 4,.LC276@ha
	mr 3,28
	la 4,.LC276@l(4)
	bl Info_ValueForKey
	lis 9,deathmatch@ha
	lis 10,.LC330@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC330@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L554
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L554
	lis 4,.LC311@ha
	la 4,.LC311@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L554
	lis 29,spectator_password@ha
	lwz 9,spectator_password@l(29)
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L555
	lis 4,.LC277@ha
	la 4,.LC277@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L555
	lwz 9,spectator_password@l(29)
	mr 4,31
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L555
	lis 4,.LC320@ha
	lis 5,.LC327@ha
	mr 3,28
	la 4,.LC320@l(4)
	la 5,.LC327@l(5)
	b .L571
.L555:
	lis 9,maxclients@ha
	lis 10,.LC330@ha
	lwz 11,maxclients@l(9)
	la 10,.LC330@l(10)
	li 8,0
	lfs 0,0(10)
	li 7,0
	lfs 13,20(11)
	fcmpu 0,0,13
	bc 4,0,.L557
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC331@ha
	la 9,.LC331@l(9)
	addi 10,11,1116
	lfd 13,0(9)
.L559:
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L558
	lwz 11,84(10)
	addi 9,8,1
	lwz 0,1812(11)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,8,0
	or 8,0,9
.L558:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 10,10,1116
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L559
.L557:
	xoris 0,8,0x8000
	lis 11,0x4330
	stw 0,20(1)
	lis 10,.LC331@ha
	la 10,.LC331@l(10)
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
	bc 4,3,.L563
	lis 4,.LC320@ha
	lis 5,.LC280@ha
	mr 3,28
	la 4,.LC320@l(4)
	la 5,.LC280@l(5)
	b .L571
.L554:
	lis 4,.LC281@ha
	mr 3,28
	la 4,.LC281@l(4)
	lis 29,password@ha
	bl Info_ValueForKey
	lwz 9,password@l(29)
	mr 31,3
	lwz 3,4(9)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L563
	lis 4,.LC277@ha
	la 4,.LC277@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L563
	lwz 9,password@l(29)
	mr 4,31
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L563
	lis 4,.LC320@ha
	lis 5,.LC328@ha
	mr 3,28
	la 4,.LC320@l(4)
	la 5,.LC328@l(5)
.L571:
	bl Info_SetValueForKey
	li 3,0
	b .L570
.L563:
	lis 11,g_edicts@ha
	lis 0,0xbfc5
	lwz 10,88(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,18087
	lis 11,game@ha
	cmpwi 0,10,0
	subf 9,9,30
	la 27,game@l(11)
	mullw 9,9,0
	lwz 11,1028(27)
	srawi 9,9,2
	mulli 9,9,3916
	addi 9,9,-3916
	add 31,11,9
	stw 31,84(30)
	bc 4,2,.L565
	addi 29,31,1824
	li 4,0
	li 5,1676
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 9,level@ha
	mr 3,29
	lwz 0,level@l(9)
	addi 4,31,188
	li 5,1636
	stw 0,3460(31)
	crxor 6,6,6
	bl memcpy
	lwz 0,1560(27)
	cmpwi 0,0,0
	bc 12,2,.L568
	lwz 9,84(30)
	lwz 0,1788(9)
	cmpwi 0,0,0
	bc 4,2,.L565
.L568:
	lwz 3,84(30)
	bl InitClientPersistant
.L565:
	mr 4,28
	mr 3,30
	bl ClientUserinfoChanged
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,1
	bc 4,1,.L569
	lis 9,gi+4@ha
	lwz 4,84(30)
	lis 3,.LC329@ha
	lwz 0,gi+4@l(9)
	la 3,.LC329@l(3)
	addi 4,4,700
	mtlr 0
	crxor 6,6,6
	blrl
.L569:
	lwz 9,84(30)
	li 0,0
	li 11,1
	stw 0,184(30)
	li 3,1
	stw 11,720(9)
.L570:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe17:
	.size	 ClientConnect,.Lfe17-ClientConnect
	.section	".rodata"
	.align 2
.LC332:
	.string	"%s disconnected\n"
	.align 2
.LC333:
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
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L572
	lwz 0,3836(9)
	cmpwi 0,0,0
	bc 12,2,.L574
	lis 4,.LC250@ha
	la 4,.LC250@l(4)
	bl ChasecamRemove
.L574:
	mr 3,31
	lis 27,g_edicts@ha
	crxor 6,6,6
	bl MatrixDoAtDeath
	lis 28,0xbfc5
	lis 29,gi@ha
	lwz 5,84(31)
	lis 4,.LC332@ha
	lwz 9,gi@l(29)
	la 4,.LC332@l(4)
	li 3,2
	addi 5,5,700
	la 29,gi@l(29)
	mtlr 9
	ori 28,28,18087
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
	lis 9,.LC333@ha
	li 0,0
	la 9,.LC333@l(9)
	lwz 11,84(31)
	lis 4,.LC29@ha
	stw 9,280(31)
	subf 3,3,31
	la 4,.LC29@l(4)
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
.L572:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 ClientDisconnect,.Lfe18-ClientDisconnect
	.section	".rodata"
	.align 2
.LC334:
	.string	"sv %3i:%i %i\n"
	.align 2
.LC336:
	.string	"*jump1.wav"
	.align 3
.LC335:
	.long 0x3f768000
	.long 0x0
	.align 2
.LC337:
	.long 0x0
	.align 3
.LC338:
	.long 0x40140000
	.long 0x0
	.align 2
.LC339:
	.long 0x47800000
	.align 2
.LC340:
	.long 0x43b40000
	.align 3
.LC341:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC342:
	.long 0x3f000000
	.align 2
.LC343:
	.long 0x41000000
	.align 3
.LC344:
	.long 0x3fc00000
	.long 0x0
	.align 2
.LC345:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl ClientThink
	.type	 ClientThink,@function
ClientThink:
	stwu 1,-336(1)
	mflr 0
	stfd 31,328(1)
	stmw 20,280(1)
	stw 0,340(1)
	mr 26,4
	mr 28,3
	lhz 11,8(26)
	lis 9,level@ha
	lis 8,.LC337@ha
	la 30,level@l(9)
	la 8,.LC337@l(8)
	sth 11,936(28)
	lhz 0,10(26)
	lfs 13,0(8)
	sth 0,938(28)
	lhz 9,12(26)
	sth 9,940(28)
	lfs 0,200(30)
	stw 28,292(30)
	lwz 31,84(28)
	fcmpu 0,0,13
	bc 12,2,.L598
	lwz 0,3836(31)
	cmpwi 0,0,0
	bc 12,2,.L599
	lis 4,.LC250@ha
	la 4,.LC250@l(4)
	bl ChasecamRemove
.L599:
	li 0,4
	lis 8,.LC338@ha
	stw 0,0(31)
	la 8,.LC338@l(8)
	lfs 0,200(30)
	lfd 12,0(8)
	lfs 13,4(30)
	fadd 0,0,12
	fcmpu 0,13,0
	bc 4,1,.L597
	lbz 0,1(26)
	andi. 9,0,128
	bc 12,2,.L597
	li 0,1
	stw 0,208(30)
	b .L597
.L598:
	lwz 0,3836(31)
	cmpwi 0,0,0
	bc 12,2,.L601
	lbz 0,16(31)
	ori 0,0,64
	b .L678
.L601:
	lbz 0,16(31)
	andi. 0,0,191
.L678:
	stb 0,16(31)
	lbz 0,1(26)
	andi. 8,0,2
	bc 12,2,.L603
	lis 9,.LC337@ha
	lis 11,deathmatch@ha
	la 9,.LC337@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L603
	li 0,1
	stw 0,3848(31)
	lha 9,8(26)
	cmpwi 0,9,0
	bc 4,0,.L604
	lwz 9,3852(31)
	cmpwi 0,9,59
	bc 12,1,.L604
	addi 0,9,1
	b .L679
.L604:
	lha 0,8(26)
	cmpwi 0,0,0
	bc 4,1,.L605
	lwz 9,3852(31)
	cmpwi 0,9,-40
	bc 4,1,.L605
	addi 0,9,-1
.L679:
	stw 0,3852(31)
.L605:
	li 0,0
	lis 20,maxclients@ha
	sth 0,10(26)
	sth 0,8(26)
	b .L607
.L603:
	lwz 0,3848(31)
	lis 20,maxclients@ha
	cmpwi 0,0,0
	bc 12,2,.L607
	lwz 0,3844(31)
	cmpwi 0,0,0
	bc 12,2,.L609
	lis 10,.LC339@ha
	lis 11,.LC340@ha
	li 0,3
	la 10,.LC339@l(10)
	la 11,.LC340@l(11)
	mtctr 0
	lfs 10,0(10)
	li 29,0
	lfs 11,0(11)
	li 7,0
.L677:
	lwz 10,84(28)
	add 0,29,29
	addi 29,29,1
	lwz 9,3844(10)
	addi 11,10,3468
	lfsx 12,11,7
	addi 10,10,20
	addi 9,9,16
	lfsx 0,9,7
	addi 7,7,4
	fsubs 0,0,12
	fmuls 0,0,10
	fdivs 0,0,11
	fctiwz 13,0
	stfd 13,272(1)
	lwz 8,276(1)
	sthx 8,10,0
	bdnz .L677
.L609:
	li 0,0
	stw 0,3848(31)
.L607:
	lwz 9,84(28)
	lis 11,pm_passent@ha
	stw 28,pm_passent@l(11)
	lwz 0,3828(9)
	cmpwi 0,0,0
	bc 12,2,.L615
	lha 0,2(26)
	lis 8,0x4330
	lis 9,.LC341@ha
	mr 10,11
	xoris 0,0,0x8000
	la 9,.LC341@l(9)
	stw 0,276(1)
	stw 8,272(1)
	lfd 12,0(9)
	lfd 0,272(1)
	lis 9,.LC335@ha
	lfd 13,.LC335@l(9)
	mr 9,11
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3468(31)
	lha 0,4(26)
	xoris 0,0,0x8000
	stw 0,276(1)
	stw 8,272(1)
	lfd 0,272(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3472(31)
	lha 0,6(26)
	xoris 0,0,0x8000
	stw 0,276(1)
	stw 8,272(1)
	lfd 0,272(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3476(31)
	b .L616
.L615:
	addi 3,1,8
	li 4,0
	mr 29,3
	li 5,240
	crxor 6,6,6
	bl memset
	lwz 0,260(28)
	cmpwi 0,0,1
	bc 12,2,.L621
	lwz 0,40(28)
	cmpwi 0,0,255
	li 0,3
	bc 4,2,.L621
	lwz 0,492(28)
	cmpwi 0,0,0
	bc 12,2,.L621
	li 0,2
.L621:
	stw 0,0(31)
	lis 11,level@ha
	lwz 10,84(28)
	lwz 0,level@l(11)
	lis 8,0x4330
	lis 11,.LC341@ha
	lfs 12,3876(10)
	xoris 0,0,0x8000
	la 11,.LC341@l(11)
	stw 0,276(1)
	stw 8,272(1)
	lfd 13,0(11)
	lfd 0,272(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L623
	lis 10,sv_gravity@ha
	lis 8,.LC342@ha
	lwz 11,sv_gravity@l(10)
	la 8,.LC342@l(8)
	lfs 12,0(8)
	lfs 0,20(11)
	fmuls 0,0,12
	fctiwz 13,0
	stfd 13,272(1)
	lwz 9,276(1)
	sth 9,18(31)
	b .L624
.L623:
	lis 10,sv_gravity@ha
	lwz 9,sv_gravity@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,272(1)
	lwz 11,276(1)
	sth 11,18(31)
.L624:
	lwz 0,0(31)
	addi 22,1,12
	addi 24,28,4
	lwz 9,4(31)
	addi 21,1,18
	addi 23,28,376
	lwz 11,8(31)
	mr 3,22
	mr 5,24
	lwz 10,12(31)
	mr 4,21
	mr 6,23
	stw 0,8(1)
	addi 30,31,3500
	addi 27,1,36
	stw 9,4(29)
	li 7,0
	li 8,0
	stw 11,8(29)
	lis 9,.LC343@ha
	la 9,.LC343@l(9)
	li 11,3
	stw 10,12(29)
	lfs 10,0(9)
	mtctr 11
	lwz 0,16(31)
	lwz 9,20(31)
	lwz 11,24(31)
	stw 0,16(29)
	stw 9,20(29)
	stw 11,24(29)
.L676:
	lfsx 13,7,5
	lfsx 0,7,6
	mr 9,11
	addi 7,7,4
	fmuls 13,13,10
	fmuls 0,0,10
	fctiwz 12,13
	fctiwz 11,0
	stfd 12,272(1)
	lwz 11,276(1)
	stfd 11,272(1)
	lwz 9,276(1)
	sthx 11,8,3
	sthx 9,8,4
	addi 8,8,2
	bdnz .L676
	mr 3,30
	addi 4,1,8
	li 5,28
	bl memcmp
	cmpwi 0,3,0
	bc 12,2,.L630
	li 0,1
	stw 0,52(1)
.L630:
	lis 9,gi@ha
	lwz 8,0(26)
	addi 3,1,8
	la 25,gi@l(9)
	lwz 10,8(26)
	lwz 6,84(25)
	lis 9,PM_trace@ha
	lwz 0,12(26)
	la 9,PM_trace@l(9)
	lwz 7,4(26)
	mtlr 6
	lwz 11,52(25)
	stw 8,36(1)
	stw 0,12(27)
	stw 10,8(27)
	stw 7,4(27)
	stw 9,240(1)
	stw 11,244(1)
	blrl
	lis 11,level@ha
	lwz 10,84(28)
	lwz 0,level@l(11)
	lis 8,0x4330
	lis 11,.LC341@ha
	lfs 12,3876(10)
	xoris 0,0,0x8000
	la 11,.LC341@l(11)
	stw 0,276(1)
	stw 8,272(1)
	lfd 13,0(11)
	lfd 0,272(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L631
	lwz 0,84(25)
	addi 3,1,8
	mtlr 0
	blrl
.L631:
	lwz 11,8(1)
	lis 8,.LC341@ha
	mr 27,22
	lwz 10,4(29)
	la 8,.LC341@l(8)
	mr 3,23
	lwz 0,8(29)
	mr 4,21
	mr 5,24
	lwz 9,12(29)
	lis 6,0x4330
	li 7,0
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
	stw 0,3500(31)
	lfd 11,0(8)
	stw 9,4(30)
	lis 8,.LC344@ha
	stw 11,8(30)
	la 8,.LC344@l(8)
	stw 10,12(30)
	lwz 0,24(29)
	lwz 9,16(29)
	lwz 11,20(29)
	lfd 12,0(8)
	li 8,0
	stw 0,24(30)
	stw 9,16(30)
	stw 11,20(30)
.L675:
	lhax 0,7,27
	lhax 9,7,4
	mr 10,11
	xoris 0,0,0x8000
	addi 7,7,2
	stw 0,276(1)
	xoris 9,9,0x8000
	stw 6,272(1)
	lfd 13,272(1)
	stw 9,276(1)
	stw 6,272(1)
	lfd 0,272(1)
	fsub 13,13,11
	fsub 0,0,11
	fmul 13,13,12
	fmul 0,0,12
	frsp 13,13
	frsp 0,0
	stfsx 13,8,5
	stfsx 0,8,3
	addi 8,8,4
	bdnz .L675
	lfs 0,216(1)
	mr 9,11
	lis 8,0x4330
	lfs 13,220(1)
	lis 10,.LC341@ha
	lis 7,.LC335@ha
	lfs 8,204(1)
	la 10,.LC341@l(10)
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
	lfd 12,0(10)
	xoris 0,0,0x8000
	lfd 13,.LC335@l(7)
	mr 10,11
	stw 0,276(1)
	stw 8,272(1)
	lfd 0,272(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3468(31)
	lha 0,4(26)
	xoris 0,0,0x8000
	stw 0,276(1)
	stw 8,272(1)
	lfd 0,272(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3472(31)
	lha 0,6(26)
	xoris 0,0,0x8000
	stw 0,276(1)
	stw 8,272(1)
	lfd 0,272(1)
	fsub 0,0,12
	fmul 0,0,13
	frsp 0,0
	stfs 0,3476(31)
	lwz 0,552(28)
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
	lis 29,gi@ha
	lis 3,.LC336@ha
	la 29,gi@l(29)
	la 3,.LC336@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC345@ha
	lis 9,.LC345@ha
	lis 10,.LC337@ha
	mr 5,3
	la 8,.LC345@l(8)
	la 9,.LC345@l(9)
	mtlr 0
	la 10,.LC337@l(10)
	mr 3,28
	lfs 1,0(8)
	li 4,2
	lfs 2,0(9)
	lfs 3,0(10)
	blrl
	mr 4,24
	mr 3,28
	li 5,0
	bl PlayerNoise
.L637:
	lfs 0,200(1)
	lwz 10,228(1)
	lwz 0,236(1)
	lwz 11,232(1)
	cmpwi 0,10,0
	stw 0,612(28)
	stw 11,608(28)
	fctiwz 13,0
	stw 10,552(28)
	stfd 13,272(1)
	lwz 9,276(1)
	stw 9,508(28)
	bc 12,2,.L638
	lwz 0,92(10)
	stw 0,556(28)
.L638:
	lwz 0,492(28)
	cmpwi 0,0,0
	bc 12,2,.L639
	lfs 0,3596(31)
	lis 0,0x4220
	lis 9,0xc170
	stw 0,36(31)
	stw 9,28(31)
	stfs 0,32(31)
	b .L640
.L639:
	lfs 0,188(1)
	stfs 0,3668(31)
	lfs 13,192(1)
	stfs 13,3672(31)
	lfs 0,196(1)
	stfs 0,3676(31)
	lfs 13,188(1)
	stfs 13,28(31)
	lfs 0,192(1)
	stfs 0,32(31)
	lfs 13,196(1)
	stfs 13,36(31)
.L640:
	lis 9,gi+72@ha
	mr 3,28
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,260(28)
	cmpwi 0,0,1
	bc 12,2,.L641
	mr 3,28
	bl G_TouchTriggers
.L641:
	lwz 0,56(1)
	li 29,0
	cmpw 0,29,0
	bc 4,0,.L616
	addi 30,1,60
.L645:
	li 11,0
	slwi 0,29,2
	cmpw 0,11,29
	lwzx 3,30,0
	addi 27,29,1
	bc 4,0,.L647
	lwz 0,0(30)
	cmpw 0,0,3
	bc 12,2,.L647
	mr 9,30
.L648:
	addi 11,11,1
	cmpw 0,11,29
	bc 4,0,.L647
	lwzu 0,4(9)
	cmpw 0,0,3
	bc 4,2,.L648
.L647:
	cmpw 0,11,29
	bc 4,2,.L644
	lwz 0,444(3)
	cmpwi 0,0,0
	bc 12,2,.L644
	mr 4,28
	li 5,0
	mtlr 0
	li 6,0
	blrl
.L644:
	lwz 0,56(1)
	mr 29,27
	cmpw 0,29,0
	bc 12,0,.L645
.L616:
	lwz 0,3548(31)
	lwz 11,3556(31)
	stw 0,3552(31)
	lbz 9,1(26)
	andc 0,9,0
	stw 9,3548(31)
	or 11,11,0
	stw 11,3556(31)
	lbz 0,15(26)
	stw 0,640(28)
	lwz 9,3556(31)
	andi. 0,9,1
	bc 12,2,.L655
	lwz 0,3480(31)
	cmpwi 0,0,0
	bc 12,2,.L656
	lwz 0,3488(31)
	li 30,0
	stw 30,3556(31)
	cmpwi 0,0,0
	bc 12,2,.L657
	addi 29,1,248
	addi 3,31,3668
	mr 4,29
	li 5,0
	li 6,0
	bl AngleVectors
	mr 5,29
	mr 3,28
	addi 4,28,4
	li 6,1
	li 7,100
	li 8,51
	crxor 6,6,6
	bl kick_attack
.L657:
	lwz 0,3828(31)
	cmpwi 0,0,0
	bc 4,2,.L659
	lwz 0,3488(31)
	cmpwi 0,0,0
	bc 12,2,.L658
.L659:
	lbz 0,16(31)
	stw 30,3828(31)
	andi. 0,0,191
	stb 0,16(31)
	b .L655
.L658:
	mr 3,28
	bl GetChaseTarget
	b .L655
.L656:
	lwz 0,3560(31)
	cmpwi 0,0,0
	bc 4,2,.L655
	li 0,1
	mr 3,28
	stw 0,3560(31)
	bl Think_Weapon
.L655:
	lwz 0,3480(31)
	cmpwi 0,0,0
	bc 12,2,.L663
	lha 0,12(26)
	cmpwi 0,0,9
	bc 4,1,.L664
	lbz 0,16(31)
	andi. 8,0,2
	bc 4,2,.L663
	lwz 9,3828(31)
	ori 0,0,2
	stb 0,16(31)
	cmpwi 0,9,0
	bc 12,2,.L666
	mr 3,28
	bl ChaseNext
	b .L663
.L666:
	mr 3,28
	bl GetChaseTarget
	b .L663
.L664:
	lbz 0,16(31)
	andi. 0,0,253
	stb 0,16(31)
.L663:
	lis 9,maxclients@ha
	lis 8,.LC345@ha
	lwz 11,maxclients@l(9)
	la 8,.LC345@l(8)
	li 29,1
	lfs 13,0(8)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L597
	lis 9,.LC341@ha
	lis 27,g_edicts@ha
	la 9,.LC341@l(9)
	lis 30,0x4330
	lfd 31,0(9)
	li 31,1116
.L672:
	lwz 0,g_edicts@l(27)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L671
	lwz 9,84(3)
	lwz 0,3828(9)
	cmpw 0,0,28
	bc 4,2,.L671
	bl UpdateChaseCam
.L671:
	addi 29,29,1
	lwz 11,maxclients@l(20)
	xoris 0,29,0x8000
	addi 31,31,1116
	stw 0,276(1)
	stw 30,272(1)
	lfd 0,272(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L672
.L597:
	lwz 0,340(1)
	mtlr 0
	lmw 20,280(1)
	lfd 31,328(1)
	la 1,336(1)
	blr
.Lfe19:
	.size	 ClientThink,.Lfe19-ClientThink
	.section	".rodata"
	.align 2
.LC346:
	.long 0x0
	.align 2
.LC347:
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
	lis 11,.LC346@ha
	la 11,.LC346@l(11)
	la 29,level@l(9)
	lfs 31,0(11)
	mr 31,3
	lfs 0,200(29)
	fcmpu 0,0,31
	bc 4,2,.L680
	bl MatrixFlip
	lis 9,deathmatch@ha
	lwz 30,84(31)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L682
	lwz 9,1812(30)
	lwz 0,3480(30)
	cmpw 0,9,0
	bc 12,2,.L682
	lfs 0,4(29)
	lis 9,.LC347@ha
	lfs 13,3824(30)
	la 9,.LC347@l(9)
	lfs 12,0(9)
	fsubs 0,0,13
	fcmpu 0,0,12
	cror 3,2,1
	bc 4,3,.L682
	mr 3,31
	bl spectator_respawn
	b .L680
.L682:
	lwz 0,3560(30)
	cmpwi 0,0,0
	bc 4,2,.L683
	lwz 0,3480(30)
	cmpwi 0,0,0
	bc 4,2,.L683
	mr 3,31
	bl Think_Weapon
	b .L684
.L683:
	li 0,0
	stw 0,3560(30)
.L684:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L685
	lis 9,level@ha
	lfs 13,3824(30)
	la 29,level@l(9)
	lfs 0,4(29)
	fcmpu 0,0,13
	bc 4,1,.L680
	lis 9,.LC346@ha
	lis 11,deathmatch@ha
	lwz 10,3556(30)
	la 9,.LC346@l(9)
	lfs 31,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 7,0,31
	mfcr 0
	rlwinm 0,0,31,1
	neg 0,0
	ori 0,0,1
	and. 11,10,0
	bc 4,2,.L690
	bc 12,30,.L680
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,1024
	bc 12,2,.L680
.L690:
	lis 9,tankmode@ha
	lwz 11,tankmode@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L691
	lwz 9,84(31)
	li 0,1
	mr 3,31
	stw 0,3488(9)
	bl spectator_respawn
	b .L699
.L691:
	lwz 9,84(31)
	lwz 3,3844(9)
	cmpwi 0,3,0
	bc 12,2,.L693
	bl G_FreeEdict
.L693:
	lwz 9,84(31)
	lwz 3,3840(9)
	cmpwi 0,3,0
	bc 12,2,.L694
	bl G_FreeEdict
.L694:
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L695
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L696
.L695:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L697
	mr 3,31
	bl CopyToBodyQue
.L697:
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
	stfs 0,3824(11)
	b .L699
.L696:
	lis 9,gi+168@ha
	lis 3,.LC275@ha
	lwz 0,gi+168@l(9)
	la 3,.LC275@l(3)
	mtlr 0
	blrl
	b .L701
.L685:
	lis 9,.LC346@ha
	lis 11,deathmatch@ha
	la 9,.LC346@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L699
	bl PlayerTrail_LastSpot
	mr 4,3
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L699
	addi 3,31,28
	bl PlayerTrail_Add
.L701:
.L699:
	li 0,0
	stw 0,3556(30)
.L680:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe20:
	.size	 ClientBeginServerFrame,.Lfe20-ClientBeginServerFrame
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
	bc 4,2,.L408
	bl SelectRandomDeathmatchSpawnPoint
	b .L703
.L408:
	bl SelectFarthestDeathmatchSpawnPoint
.L703:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe21:
	.size	 SelectDeathmatchSpawnPoint,.Lfe21-SelectDeathmatchSpawnPoint
	.section	".rodata"
	.align 2
.LC348:
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
	lwz 3,3844(9)
	cmpwi 0,3,0
	bc 12,2,.L461
	bl G_FreeEdict
.L461:
	lwz 9,84(31)
	lwz 3,3840(9)
	cmpwi 0,3,0
	bc 12,2,.L462
	bl G_FreeEdict
.L462:
	lis 11,.LC348@ha
	lis 9,deathmatch@ha
	la 11,.LC348@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L464
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L463
.L464:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L465
	mr 3,31
	bl CopyToBodyQue
.L465:
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
	stfs 0,3824(11)
	b .L460
.L463:
	lis 9,gi+168@ha
	lis 3,.LC275@ha
	lwz 0,gi+168@l(9)
	la 3,.LC275@l(3)
	mtlr 0
	blrl
.L460:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe22:
	.size	 respawn,.Lfe22-respawn
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
	li 5,1676
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
.Lfe23:
	.size	 InitClientResp,.Lfe23-InitClientResp
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
	lis 11,.LC273@ha
	stw 0,level+296@l(9)
	li 31,8
	la 30,.LC273@l(11)
.L455:
	bl G_Spawn
	addic. 31,31,-1
	stw 30,280(3)
	bc 4,2,.L455
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe24:
	.size	 InitBodyQue,.Lfe24-InitBodyQue
	.align 2
	.globl player_pain
	.type	 player_pain,@function
player_pain:
	blr
.Lfe25:
	.size	 player_pain,.Lfe25-player_pain
	.section	".rodata"
	.align 2
.LC349:
	.long 0x0
	.section	".text"
	.align 2
	.globl FetchClientEntData
	.type	 FetchClientEntData,@function
FetchClientEntData:
	lis 9,.LC349@ha
	lwz 7,84(3)
	lis 10,coop@ha
	la 9,.LC349@l(9)
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
.Lfe26:
	.size	 FetchClientEntData,.Lfe26-FetchClientEntData
	.section	".rodata"
	.align 2
.LC350:
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
	lis 9,.LC350@ha
	mr 30,3
	la 9,.LC350@l(9)
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
.LC351:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC352:
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
	lis 11,.LC352@ha
	lis 9,coop@ha
	la 11,.LC352@l(11)
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
	lis 11,.LC351@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC351@l(11)
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
.LC353:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_player_deathmatch
	.type	 SP_info_player_deathmatch,@function
SP_info_player_deathmatch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC353@ha
	lis 9,deathmatch@ha
	la 11,.LC353@l(11)
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
	b .L704
.L30:
	li 3,0
.L704:
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
	bc 4,2,.L705
.L34:
	li 3,0
.L705:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe32:
	.size	 IsNeutral,.Lfe32-IsNeutral
	.section	".rodata"
	.align 2
.LC354:
	.long 0x4b18967f
	.align 2
.LC355:
	.long 0x3f800000
	.align 3
.LC356:
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
	lis 11,.LC355@ha
	lwz 10,maxclients@l(9)
	la 11,.LC355@l(11)
	mr 31,3
	lfs 13,0(11)
	li 29,1
	lis 26,maxclients@ha
	lfs 0,20(10)
	lis 11,.LC354@ha
	lfs 31,.LC354@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L357
	lis 9,.LC356@ha
	lis 27,g_edicts@ha
	la 9,.LC356@l(9)
	lis 28,0x4330
	lfd 30,0(9)
	li 30,1116
.L359:
	lwz 0,g_edicts@l(27)
	add 11,0,30
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L358
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L358
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
	bc 4,0,.L358
	fmr 31,1
.L358:
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
	bc 12,3,.L359
.L357:
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
	.globl SelectCoopSpawnPoint
	.type	 SelectCoopSpawnPoint,@function
SelectCoopSpawnPoint:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 11,game+1028@ha
	lwz 0,84(3)
	lis 9,0xe834
	lwz 10,game+1028@l(11)
	ori 9,9,19547
	li 30,0
	li 3,0
	subf 0,10,0
	mullw 0,0,9
	srawi. 31,0,2
	bc 12,2,.L706
.L414:
	lis 5,.LC2@ha
	mr 3,30
	la 5,.LC2@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L415
	li 3,0
	b .L706
.L415:
	lwz 4,300(30)
	cmpwi 0,4,0
	bc 4,2,.L416
	lis 9,.LC29@ha
	la 4,.LC29@l(9)
.L416:
	lis 3,game+1032@ha
	la 3,game+1032@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L414
	addic. 31,31,-1
	bc 4,2,.L414
	mr 3,30
.L706:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe34:
	.size	 SelectCoopSpawnPoint,.Lfe34-SelectCoopSpawnPoint
	.section	".rodata"
	.align 2
.LC357:
	.long 0x3f800000
	.align 2
.LC358:
	.long 0x0
	.align 2
.LC359:
	.long 0x42400000
	.section	".text"
	.align 2
	.globl body_die
	.type	 body_die,@function
body_die:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	mr 30,6
	lwz 0,480(31)
	cmpwi 0,0,-40
	bc 4,0,.L458
	lis 29,gi@ha
	lis 3,.LC274@ha
	la 29,gi@l(29)
	la 3,.LC274@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC357@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC357@l(9)
	mr 3,31
	lfs 1,0(9)
	mtlr 0
	li 4,4
	lis 9,.LC357@ha
	la 9,.LC357@l(9)
	lfs 2,0(9)
	lis 9,.LC358@ha
	la 9,.LC358@l(9)
	lfs 3,0(9)
	blrl
	lis 9,.LC359@ha
	lfs 0,12(31)
	mr 4,30
	la 9,.LC359@l(9)
	mr 3,31
	lfs 13,0(9)
	fsubs 0,0,13
	stfs 0,12(31)
	bl ThrowClientHead
	li 0,0
	stw 0,512(31)
.L458:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
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
	bc 4,1,.L576
	lis 11,gi+48@ha
	lis 9,0x201
	lwz 0,gi+48@l(11)
	ori 9,9,3
	mtlr 0
	blrl
	b .L575
.L576:
	lis 11,gi+48@ha
	lis 9,0x1
	lwz 0,gi+48@l(11)
	mr 3,31
	ori 9,9,3
	mtlr 0
	blrl
.L575:
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
	bc 4,0,.L580
.L582:
	lbzx 0,3,9
	addi 9,9,1
	cmpw 0,9,4
	add 11,11,0
	bc 12,0,.L582
.L580:
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
.L708:
	lbzx 0,3,9
	addi 9,9,1
	add 5,5,0
	bdnz .L708
	li 0,16
	lbz 4,42(3)
	li 6,0
	mtctr 0
	addi 3,3,28
	li 9,0
.L707:
	lbzx 0,3,9
	addi 9,9,1
	add 6,6,0
	bdnz .L707
	lis 3,.LC334@ha
	la 3,.LC334@l(3)
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
