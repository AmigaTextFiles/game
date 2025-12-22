	.file	"matrix_main.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"weapon_knives"
	.align 2
.LC1:
	.string	"weapon_fists"
	.align 2
.LC2:
	.string	"Switched from fists to guns. Speed boost comprimised\n"
	.align 2
.LC3:
	.string	"Switched to guns. Bullet stopping forsaken\n"
	.align 2
.LC4:
	.string	"thingoff.wav"
	.align 2
.LC5:
	.string	"ir_off.wav"
	.align 2
.LC6:
	.string	"decloak.wav"
	.align 3
.LC7:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC8:
	.long 0x0
	.align 2
.LC9:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl MatrixClientFrame
	.type	 MatrixClientFrame,@function
MatrixClientFrame:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 28,24(1)
	stw 0,52(1)
	mr 31,3
	lis 4,.LC0@ha
	lwz 11,84(31)
	la 4,.LC0@l(4)
	lis 28,level@ha
	lwz 9,1788(11)
	lwz 3,0(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L7
	lwz 11,84(31)
	lis 4,.LC1@ha
	la 4,.LC1@l(4)
	lwz 9,1788(11)
	lwz 3,0(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L7
	lwz 0,level@l(28)
	lis 30,0x4330
	lis 10,.LC7@ha
	lwz 11,84(31)
	xoris 0,0,0x8000
	la 10,.LC7@l(10)
	stw 0,20(1)
	stw 30,16(1)
	lfd 31,0(10)
	lfd 0,16(1)
	lfs 13,3876(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L8
	stfs 0,3876(11)
	lis 9,gi+8@ha
	lis 5,.LC2@ha
	lwz 0,gi+8@l(9)
	la 5,.LC2@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L8:
	lwz 0,level@l(28)
	lfs 13,912(31)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L7
	stfs 0,912(31)
	lis 9,gi+8@ha
	lis 5,.LC3@ha
	lwz 0,gi+8@l(9)
	la 5,.LC3@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L7:
	lwz 9,84(31)
	lwz 0,3912(9)
	cmpwi 0,0,0
	bc 4,2,.L10
	stw 0,3904(9)
	lwz 9,84(31)
	stw 0,3908(9)
.L10:
	addi 3,31,376
	bl VectorLength
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,2,.L11
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	stfs 0,476(31)
.L11:
	lha 0,940(31)
	cmpwi 0,0,0
	bc 4,1,.L12
	li 0,1
	stw 0,996(31)
.L12:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L13
	li 0,0
	stw 0,996(31)
.L13:
	mr 3,31
	crxor 6,6,6
	bl heavybreathing
	mr 3,31
	crxor 6,6,6
	bl MatrixCheckSpeed
	mr 3,31
	crxor 6,6,6
	bl MatrixStamina
	mr 3,31
	crxor 6,6,6
	bl MatrixStopBullets
	mr 3,31
	crxor 6,6,6
	bl dodgebullets
	mr 3,31
	crxor 6,6,6
	bl MatrixSwapThink
	mr 3,31
	bl MatrixOlympics
	mr 3,31
	crxor 6,6,6
	bl MatrixKungfu
	mr 3,31
	crxor 6,6,6
	bl MatrixScreenTilt
	mr 3,31
	bl MatrixComboTally
	lwz 9,84(31)
	lwz 0,3848(9)
	cmpwi 0,0,0
	bc 12,2,.L14
	li 0,0
	stw 0,88(9)
.L14:
	lis 10,level@ha
	lwz 8,84(31)
	lwz 9,level@l(10)
	lis 30,0x4330
	lis 10,.LC7@ha
	lfs 13,3876(8)
	addi 9,9,5
	la 10,.LC7@l(10)
	xoris 9,9,0x8000
	lfd 31,0(10)
	stw 9,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,2,.L15
	lis 29,gi@ha
	lis 3,.LC4@ha
	la 29,gi@l(29)
	la 3,.LC4@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC9@ha
	lis 10,.LC9@ha
	lis 11,.LC8@ha
	mr 5,3
	la 9,.LC9@l(9)
	la 10,.LC9@l(10)
	mtlr 0
	la 11,.LC8@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L15:
	lwz 9,level@l(28)
	lwz 10,84(31)
	addi 9,9,5
	xoris 9,9,0x8000
	lfs 13,3884(10)
	stw 9,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,2,.L16
	lis 29,gi@ha
	lis 3,.LC5@ha
	la 29,gi@l(29)
	la 3,.LC5@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC9@ha
	lis 10,.LC9@ha
	lis 11,.LC8@ha
	mr 5,3
	la 9,.LC9@l(9)
	la 10,.LC9@l(10)
	mtlr 0
	la 11,.LC8@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L16:
	lwz 9,level@l(28)
	lwz 10,84(31)
	addi 9,9,5
	xoris 9,9,0x8000
	lfs 13,3888(10)
	stw 9,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,2,.L17
	lis 29,gi@ha
	lis 3,.LC6@ha
	la 29,gi@l(29)
	la 3,.LC6@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC9@ha
	lis 10,.LC9@ha
	lis 11,.LC8@ha
	mr 5,3
	la 9,.LC9@l(9)
	la 10,.LC9@l(10)
	mtlr 0
	la 11,.LC8@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L17:
	lhz 0,936(31)
	lhz 11,938(31)
	lhz 9,940(31)
	sth 0,942(31)
	sth 9,946(31)
	sth 11,944(31)
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 MatrixClientFrame,.Lfe1-MatrixClientFrame
	.section	".rodata"
	.align 2
.LC10:
	.string	"alias +button0 onbutton0\nalias -button0 offbutton0\nalias +button1 onbutton1\nalias -button1 offbutton1\nalias +boot booton\nalias -boot bootoff\nalias +attack2 booton\nalias -attack2 bootoff"
	.align 2
.LC11:
	.string	"m"
	.align 2
.LC12:
	.string	"matchtimelimit"
	.align 2
.LC13:
	.string	"0"
	.align 2
.LC14:
	.string	"teamfraglimit"
	.align 2
.LC15:
	.string	"matchmode"
	.align 2
.LC16:
	.string	"teamplay"
	.align 2
.LC17:
	.string	"tankmode"
	.align 2
.LC18:
	.string	"weaponban"
	.align 2
.LC19:
	.string	"weaponrespawntime"
	.align 2
.LC20:
	.string	"15"
	.align 2
.LC21:
	.string	"sv_maxlevel"
	.align 2
.LC22:
	.string	"4"
	.align 2
.LC23:
	.string	"zk_logonly"
	.align 2
.LC24:
	.string	"laseroff"
	.align 2
.LC25:
	.string	"streakoff"
	.align 2
.LC26:
	.string	"shellsoff"
	.align 2
.LC27:
	.string	"hop"
	.align 2
.LC28:
	.string	"250"
	.align 2
.LC29:
	.string	"action"
	.align 2
.LC30:
	.string	"blueteamname"
	.align 2
.LC31:
	.string	"Hackers"
	.align 2
.LC32:
	.string	"redteamname"
	.align 2
.LC33:
	.string	"Agents"
	.align 2
.LC34:
	.string	"redteamskin"
	.align 2
.LC35:
	.string	"ctf_r"
	.align 2
.LC36:
	.string	"blueteamskin"
	.align 2
.LC37:
	.string	"ctf_b"
	.align 2
.LC38:
	.string	"damage_deserts"
	.align 2
.LC39:
	.string	"40"
	.align 2
.LC40:
	.string	"damage_mk23"
	.align 2
.LC41:
	.string	"30"
	.align 2
.LC42:
	.string	"damage_mp5"
	.align 2
.LC43:
	.string	"10"
	.align 2
.LC44:
	.string	"damage_m4"
	.align 2
.LC45:
	.string	"damage_pumps"
	.align 2
.LC46:
	.string	"6"
	.align 2
.LC47:
	.string	"damage_smc"
	.align 2
.LC48:
	.string	"damage_sniper"
	.align 2
.LC49:
	.string	"100"
	.align 2
.LC50:
	.string	"damage_knife"
	.align 2
.LC51:
	.string	"50"
	.align 2
.LC52:
	.string	"damage_fist"
	.align 2
.LC53:
	.string	"80"
	.align 2
.LC54:
	.string	"damageradius_rack"
	.align 2
.LC55:
	.string	"120"
	.align 2
.LC56:
	.string	"damageradius_grenade"
	.align 2
.LC57:
	.string	"200"
	.align 2
.LC58:
	.string	"radiusdamage_rack"
	.align 2
.LC59:
	.string	"radiusdamage_grenade"
	.align 2
.LC60:
	.string	"110"
	.align 2
.LC61:
	.string	"ammo_deserts"
	.align 2
.LC62:
	.string	"ammo_mk23"
	.align 2
.LC63:
	.string	"ammo_mp5"
	.align 2
.LC64:
	.string	"3"
	.align 2
.LC65:
	.string	"ammo_m4"
	.align 2
.LC66:
	.string	"ammo_pumps"
	.align 2
.LC67:
	.string	"20"
	.align 2
.LC68:
	.string	"ammo_smc"
	.align 2
.LC69:
	.string	"1"
	.align 2
.LC70:
	.string	"ammo_sniper"
	.align 2
.LC71:
	.string	"ammo_knife"
	.align 2
.LC72:
	.string	"ammo_grenade"
	.align 2
.LC73:
	.string	"ammo_rack"
	.align 2
.LC74:
	.string	"damage_jab"
	.align 2
.LC75:
	.string	"damage_hook"
	.align 2
.LC76:
	.string	"damage_uppercut"
	.align 2
.LC77:
	.string	"damage_hoverkick"
	.align 2
.LC78:
	.string	"damage_spinkick"
	.align 2
.LC79:
	.string	"60"
	.align 2
.LC80:
	.string	"reload_jab"
	.align 2
.LC81:
	.string	"2"
	.align 2
.LC82:
	.string	"reload_hook"
	.align 2
.LC83:
	.string	"reload_uppercut"
	.align 2
.LC84:
	.string	"18"
	.align 2
.LC85:
	.string	"reload_hoverkick"
	.align 2
.LC86:
	.string	"reload_spinkick"
	.align 2
.LC87:
	.string	"possesban"
	.align 2
.LC88:
	.string	"combomessage"
	.align 2
.LC89:
	.string	"killstreakmessage"
	.align 2
.LC90:
	.string	"streakmessage2"
	.align 2
.LC91:
	.string	"Kill Streak"
	.align 2
.LC92:
	.string	"streakmessage3"
	.align 2
.LC93:
	.string	"Oooooooohhh Yeeeaaaah"
	.align 2
.LC94:
	.string	"streakmessage4"
	.align 2
.LC95:
	.string	"Hmmmm mmmmm mmm!"
	.align 2
.LC96:
	.string	"streakmessage5"
	.align 2
.LC97:
	.string	"Musn't Grrumble!"
	.align 2
.LC98:
	.string	"streakmessage6"
	.align 2
.LC99:
	.string	"M-M-M-Monster Frag"
	.section	".text"
	.align 2
	.globl MatrixInit
	.type	 MatrixInit,@function
MatrixInit:
	stwu 1,-80(1)
	mflr 0
	stmw 17,20(1)
	stw 0,84(1)
	lis 29,gi@ha
	lis 28,.LC13@ha
	la 29,gi@l(29)
	lis 3,.LC12@ha
	lwz 9,144(29)
	la 4,.LC13@l(28)
	li 5,5
	la 3,.LC12@l(3)
	lis 26,.LC20@ha
	mtlr 9
	lis 24,.LC22@ha
	lis 27,.LC39@ha
	lis 23,.LC38@ha
	lis 19,.LC41@ha
	lis 25,.LC43@ha
	lis 18,.LC51@ha
	lis 17,.LC53@ha
	lis 21,.LC55@ha
	blrl
	lis 20,.LC67@ha
	lis 22,.LC69@ha
	lwz 10,144(29)
	lis 9,matchtimelimit@ha
	lis 11,.LC14@ha
	stw 3,matchtimelimit@l(9)
	la 4,.LC13@l(28)
	li 5,5
	mtlr 10
	la 3,.LC14@l(11)
	blrl
	lwz 10,144(29)
	lis 9,teamfraglimit@ha
	lis 11,.LC15@ha
	stw 3,teamfraglimit@l(9)
	la 4,.LC13@l(28)
	li 5,5
	mtlr 10
	la 3,.LC15@l(11)
	blrl
	lwz 10,144(29)
	lis 9,matchmode@ha
	lis 11,.LC16@ha
	stw 3,matchmode@l(9)
	la 4,.LC13@l(28)
	li 5,5
	mtlr 10
	la 3,.LC16@l(11)
	blrl
	lwz 10,144(29)
	lis 9,teamplay@ha
	lis 11,.LC17@ha
	stw 3,teamplay@l(9)
	la 4,.LC13@l(28)
	li 5,5
	mtlr 10
	la 3,.LC17@l(11)
	blrl
	lwz 10,144(29)
	lis 9,tankmode@ha
	lis 11,.LC18@ha
	stw 3,tankmode@l(9)
	la 4,.LC13@l(28)
	li 5,5
	mtlr 10
	la 3,.LC18@l(11)
	blrl
	lwz 10,144(29)
	lis 9,weaponban@ha
	lis 11,.LC19@ha
	stw 3,weaponban@l(9)
	la 4,.LC20@l(26)
	li 5,5
	mtlr 10
	la 3,.LC19@l(11)
	blrl
	lwz 10,144(29)
	lis 9,weaponrespawntime@ha
	lis 11,.LC21@ha
	stw 3,weaponrespawntime@l(9)
	la 4,.LC22@l(24)
	li 5,5
	mtlr 10
	la 3,.LC21@l(11)
	blrl
	lwz 10,144(29)
	lis 9,sv_maxlevel@ha
	lis 11,.LC23@ha
	stw 3,sv_maxlevel@l(9)
	la 4,.LC13@l(28)
	li 5,5
	mtlr 10
	la 3,.LC23@l(11)
	blrl
	lwz 10,144(29)
	lis 9,zk_logonly@ha
	lis 11,.LC24@ha
	stw 3,zk_logonly@l(9)
	la 4,.LC13@l(28)
	li 5,5
	mtlr 10
	la 3,.LC24@l(11)
	blrl
	lwz 10,144(29)
	lis 9,laseroff@ha
	lis 11,.LC25@ha
	stw 3,laseroff@l(9)
	la 4,.LC13@l(28)
	li 5,5
	mtlr 10
	la 3,.LC25@l(11)
	blrl
	lwz 10,144(29)
	lis 9,streakoff@ha
	lis 11,.LC26@ha
	stw 3,streakoff@l(9)
	la 4,.LC13@l(28)
	li 5,5
	mtlr 10
	la 3,.LC26@l(11)
	blrl
	lwz 10,144(29)
	lis 9,shellsoff@ha
	lis 11,.LC27@ha
	stw 3,shellsoff@l(9)
	lis 4,.LC28@ha
	li 5,5
	mtlr 10
	la 4,.LC28@l(4)
	la 3,.LC27@l(11)
	blrl
	lwz 10,144(29)
	lis 9,hop@ha
	lis 11,.LC29@ha
	stw 3,hop@l(9)
	la 4,.LC13@l(28)
	li 5,5
	mtlr 10
	la 3,.LC29@l(11)
	blrl
	lwz 10,144(29)
	lis 9,action@ha
	lis 11,.LC30@ha
	stw 3,action@l(9)
	lis 4,.LC31@ha
	li 5,0
	la 4,.LC31@l(4)
	mtlr 10
	la 3,.LC30@l(11)
	blrl
	lwz 10,144(29)
	lis 9,blueteamname@ha
	lis 11,.LC32@ha
	stw 3,blueteamname@l(9)
	lis 4,.LC33@ha
	li 5,0
	la 4,.LC33@l(4)
	mtlr 10
	la 3,.LC32@l(11)
	blrl
	lwz 10,144(29)
	lis 9,redteamname@ha
	lis 11,.LC34@ha
	stw 3,redteamname@l(9)
	lis 4,.LC35@ha
	li 5,0
	la 4,.LC35@l(4)
	mtlr 10
	la 3,.LC34@l(11)
	blrl
	lwz 10,144(29)
	lis 9,redteamskin@ha
	lis 11,.LC36@ha
	stw 3,redteamskin@l(9)
	lis 4,.LC37@ha
	li 5,0
	mtlr 10
	la 4,.LC37@l(4)
	la 3,.LC36@l(11)
	blrl
	lwz 11,144(29)
	lis 9,blueteamskin@ha
	la 4,.LC39@l(27)
	stw 3,blueteamskin@l(9)
	li 5,5
	mtlr 11
	la 3,.LC38@l(23)
	blrl
	lwz 11,144(29)
	lis 9,faglimit@ha
	la 4,.LC39@l(27)
	stw 3,faglimit@l(9)
	li 5,5
	mtlr 11
	la 3,.LC38@l(23)
	blrl
	lwz 10,144(29)
	lis 9,damage_deserts@ha
	lis 11,.LC40@ha
	stw 3,damage_deserts@l(9)
	la 4,.LC41@l(19)
	li 5,5
	mtlr 10
	la 3,.LC40@l(11)
	blrl
	lwz 10,144(29)
	lis 9,damage_mk23@ha
	lis 11,.LC42@ha
	stw 3,damage_mk23@l(9)
	la 4,.LC43@l(25)
	li 5,5
	mtlr 10
	la 3,.LC42@l(11)
	blrl
	lwz 10,144(29)
	lis 9,damage_mp5@ha
	lis 11,.LC44@ha
	stw 3,damage_mp5@l(9)
	la 4,.LC20@l(26)
	li 5,5
	mtlr 10
	la 3,.LC44@l(11)
	blrl
	lwz 10,144(29)
	lis 9,damage_m4@ha
	lis 11,.LC45@ha
	stw 3,damage_m4@l(9)
	lis 4,.LC46@ha
	li 5,5
	mtlr 10
	la 4,.LC46@l(4)
	la 3,.LC45@l(11)
	blrl
	lwz 10,144(29)
	lis 9,damage_pumps@ha
	lis 11,.LC47@ha
	stw 3,damage_pumps@l(9)
	la 4,.LC22@l(24)
	li 5,5
	mtlr 10
	la 3,.LC47@l(11)
	blrl
	lwz 10,144(29)
	lis 9,damage_smc@ha
	lis 11,.LC48@ha
	stw 3,damage_smc@l(9)
	lis 4,.LC49@ha
	li 5,5
	mtlr 10
	la 4,.LC49@l(4)
	la 3,.LC48@l(11)
	blrl
	lwz 10,144(29)
	lis 9,damage_sniper@ha
	lis 11,.LC50@ha
	stw 3,damage_sniper@l(9)
	la 4,.LC51@l(18)
	li 5,5
	mtlr 10
	la 3,.LC50@l(11)
	blrl
	lwz 10,144(29)
	lis 9,damage_knife@ha
	lis 11,.LC52@ha
	stw 3,damage_knife@l(9)
	la 4,.LC53@l(17)
	li 5,5
	mtlr 10
	la 3,.LC52@l(11)
	blrl
	lwz 10,144(29)
	lis 9,damage_fist@ha
	lis 11,.LC54@ha
	stw 3,damage_fist@l(9)
	la 4,.LC55@l(21)
	li 5,5
	mtlr 10
	la 3,.LC54@l(11)
	blrl
	lwz 10,144(29)
	lis 9,damageradius_rack@ha
	lis 11,.LC56@ha
	stw 3,damageradius_rack@l(9)
	lis 4,.LC57@ha
	li 5,5
	mtlr 10
	la 4,.LC57@l(4)
	la 3,.LC56@l(11)
	blrl
	lwz 10,144(29)
	lis 9,damageradius_grenade@ha
	lis 11,.LC58@ha
	stw 3,damageradius_grenade@l(9)
	la 4,.LC55@l(21)
	li 5,5
	mtlr 10
	la 3,.LC58@l(11)
	blrl
	lwz 10,144(29)
	lis 9,radiusdamage_rack@ha
	lis 11,.LC59@ha
	stw 3,radiusdamage_rack@l(9)
	lis 4,.LC60@ha
	li 5,5
	mtlr 10
	la 4,.LC60@l(4)
	la 3,.LC59@l(11)
	blrl
	lwz 10,144(29)
	lis 9,radiusdamage_grenade@ha
	lis 11,.LC61@ha
	stw 3,radiusdamage_grenade@l(9)
	la 4,.LC20@l(26)
	li 5,5
	mtlr 10
	la 3,.LC61@l(11)
	blrl
	lwz 10,144(29)
	lis 9,ammo_deserts@ha
	lis 11,.LC62@ha
	stw 3,ammo_deserts@l(9)
	la 4,.LC43@l(25)
	li 5,5
	mtlr 10
	la 3,.LC62@l(11)
	blrl
	lwz 10,144(29)
	lis 9,ammo_mk23@ha
	lis 11,.LC63@ha
	stw 3,ammo_mk23@l(9)
	lis 4,.LC64@ha
	li 5,5
	mtlr 10
	la 4,.LC64@l(4)
	la 3,.LC63@l(11)
	blrl
	lwz 10,144(29)
	lis 9,ammo_mp5@ha
	lis 11,.LC65@ha
	stw 3,ammo_mp5@l(9)
	la 4,.LC22@l(24)
	li 5,5
	mtlr 10
	la 3,.LC65@l(11)
	blrl
	lwz 10,144(29)
	lis 9,ammo_m4@ha
	lis 11,.LC66@ha
	stw 3,ammo_m4@l(9)
	la 4,.LC67@l(20)
	li 5,5
	mtlr 10
	la 3,.LC66@l(11)
	blrl
	lwz 10,144(29)
	lis 9,ammo_pumps@ha
	lis 11,.LC68@ha
	stw 3,ammo_pumps@l(9)
	la 4,.LC69@l(22)
	li 5,5
	mtlr 10
	la 3,.LC68@l(11)
	blrl
	lwz 10,144(29)
	lis 9,ammo_smc@ha
	lis 11,.LC70@ha
	stw 3,ammo_smc@l(9)
	la 4,.LC39@l(27)
	li 5,5
	mtlr 10
	la 3,.LC70@l(11)
	blrl
	lwz 10,144(29)
	lis 9,ammo_sniper@ha
	lis 11,.LC71@ha
	stw 3,ammo_sniper@l(9)
	la 4,.LC67@l(20)
	li 5,5
	mtlr 10
	la 3,.LC71@l(11)
	blrl
	lwz 10,144(29)
	lis 9,ammo_knife@ha
	lis 11,.LC72@ha
	stw 3,ammo_knife@l(9)
	la 4,.LC41@l(19)
	li 5,5
	mtlr 10
	la 3,.LC72@l(11)
	blrl
	lwz 10,144(29)
	lis 9,ammo_grenade@ha
	lis 11,.LC73@ha
	stw 3,ammo_grenade@l(9)
	la 4,.LC51@l(18)
	li 5,5
	mtlr 10
	la 3,.LC73@l(11)
	blrl
	lwz 10,144(29)
	lis 9,ammo_rack@ha
	lis 11,.LC74@ha
	stw 3,ammo_rack@l(9)
	la 4,.LC43@l(25)
	li 5,5
	mtlr 10
	la 3,.LC74@l(11)
	blrl
	lwz 10,144(29)
	lis 9,damage_jab@ha
	lis 11,.LC75@ha
	stw 3,damage_jab@l(9)
	la 4,.LC39@l(27)
	li 5,5
	mtlr 10
	la 3,.LC75@l(11)
	blrl
	lwz 10,144(29)
	lis 9,damage_hook@ha
	lis 11,.LC76@ha
	stw 3,damage_hook@l(9)
	la 4,.LC53@l(17)
	li 5,5
	mtlr 10
	la 3,.LC76@l(11)
	blrl
	lwz 10,144(29)
	lis 9,damage_uppercut@ha
	lis 11,.LC77@ha
	stw 3,damage_uppercut@l(9)
	la 4,.LC39@l(27)
	li 5,5
	mtlr 10
	la 3,.LC77@l(11)
	blrl
	lwz 10,144(29)
	lis 9,damage_hoverkick@ha
	lis 11,.LC78@ha
	stw 3,damage_hoverkick@l(9)
	lis 4,.LC79@ha
	li 5,5
	la 4,.LC79@l(4)
	mtlr 10
	la 3,.LC78@l(11)
	blrl
	lwz 10,144(29)
	lis 9,damage_spinkick@ha
	lis 11,.LC80@ha
	stw 3,damage_spinkick@l(9)
	lis 4,.LC81@ha
	li 5,5
	mtlr 10
	la 4,.LC81@l(4)
	la 3,.LC80@l(11)
	blrl
	lwz 10,144(29)
	lis 9,reload_jab@ha
	lis 11,.LC82@ha
	stw 3,reload_jab@l(9)
	la 4,.LC43@l(25)
	li 5,5
	mtlr 10
	la 3,.LC82@l(11)
	blrl
	lwz 10,144(29)
	lis 9,reload_hook@ha
	lis 11,.LC83@ha
	stw 3,reload_hook@l(9)
	lis 4,.LC84@ha
	li 5,5
	mtlr 10
	la 4,.LC84@l(4)
	la 3,.LC83@l(11)
	blrl
	lwz 10,144(29)
	lis 9,reload_uppercut@ha
	lis 11,.LC85@ha
	stw 3,reload_uppercut@l(9)
	la 4,.LC13@l(28)
	li 5,5
	mtlr 10
	la 3,.LC85@l(11)
	blrl
	lwz 10,144(29)
	lis 9,reload_hoverkick@ha
	lis 11,.LC86@ha
	stw 3,reload_hoverkick@l(9)
	la 4,.LC43@l(25)
	li 5,5
	mtlr 10
	la 3,.LC86@l(11)
	blrl
	lwz 10,144(29)
	lis 9,reload_spinkick@ha
	lis 11,.LC87@ha
	stw 3,reload_spinkick@l(9)
	la 4,.LC13@l(28)
	li 5,5
	mtlr 10
	la 3,.LC87@l(11)
	blrl
	lwz 10,144(29)
	lis 9,possesban@ha
	lis 11,.LC88@ha
	stw 3,possesban@l(9)
	la 4,.LC69@l(22)
	li 5,5
	mtlr 10
	la 3,.LC88@l(11)
	blrl
	lwz 10,144(29)
	lis 9,combomessage@ha
	lis 11,.LC89@ha
	stw 3,combomessage@l(9)
	la 4,.LC69@l(22)
	li 5,5
	mtlr 10
	la 3,.LC89@l(11)
	blrl
	lwz 10,144(29)
	lis 9,killstreakmessage@ha
	lis 11,.LC90@ha
	stw 3,killstreakmessage@l(9)
	lis 4,.LC91@ha
	li 5,5
	la 4,.LC91@l(4)
	mtlr 10
	la 3,.LC90@l(11)
	blrl
	lwz 10,144(29)
	lis 9,streakmessage2@ha
	lis 11,.LC92@ha
	stw 3,streakmessage2@l(9)
	lis 4,.LC93@ha
	li 5,5
	la 4,.LC93@l(4)
	mtlr 10
	la 3,.LC92@l(11)
	blrl
	lwz 10,144(29)
	lis 9,streakmessage3@ha
	lis 11,.LC94@ha
	stw 3,streakmessage3@l(9)
	lis 4,.LC95@ha
	li 5,5
	la 4,.LC95@l(4)
	mtlr 10
	la 3,.LC94@l(11)
	blrl
	lwz 10,144(29)
	lis 9,streakmessage4@ha
	lis 11,.LC96@ha
	stw 3,streakmessage4@l(9)
	lis 4,.LC97@ha
	li 5,5
	mtlr 10
	la 4,.LC97@l(4)
	la 3,.LC96@l(11)
	blrl
	lwz 0,144(29)
	lis 9,streakmessage5@ha
	lis 11,.LC98@ha
	stw 3,streakmessage5@l(9)
	lis 4,.LC99@ha
	li 5,5
	la 3,.LC98@l(11)
	mtlr 0
	la 4,.LC99@l(4)
	blrl
	lis 8,matrix@ha
	li 0,0
	la 9,matrix@l(8)
	li 10,0
	stw 0,8(9)
	lis 11,streakmessage6@ha
	stw 3,streakmessage6@l(11)
	stw 10,matrix@l(8)
	stw 10,24(9)
	stw 0,4(9)
	stw 0,20(9)
	stw 0,16(9)
	stw 0,12(9)
	lwz 0,84(1)
	mtlr 0
	lmw 17,20(1)
	la 1,80(1)
	blr
.Lfe2:
	.size	 MatrixInit,.Lfe2-MatrixInit
	.section	".rodata"
	.align 2
.LC100:
	.string	"st1"
	.align 2
.LC101:
	.string	"st2"
	.align 2
.LC102:
	.string	"st3"
	.align 2
.LC103:
	.string	"st4"
	.align 2
.LC104:
	.string	"st5"
	.align 2
.LC105:
	.string	"st6"
	.align 2
.LC106:
	.string	"st7"
	.align 2
.LC107:
	.string	"st8"
	.align 2
.LC108:
	.string	"st9"
	.align 2
.LC109:
	.string	"st10"
	.align 2
.LC110:
	.string	"st11"
	.align 2
.LC111:
	.string	"st12"
	.align 2
.LC112:
	.string	"st13"
	.align 2
.LC113:
	.string	"st14"
	.align 2
.LC114:
	.string	"st15"
	.align 2
.LC115:
	.string	"st16"
	.align 2
.LC116:
	.string	"st17"
	.align 2
.LC117:
	.string	"st18"
	.align 2
.LC118:
	.string	"st19"
	.align 2
.LC119:
	.string	"st20"
	.align 2
.LC120:
	.string	"p_stam"
	.align 2
.LC121:
	.string	"schr"
	.align 2
.LC122:
	.string	"schl"
	.align 2
.LC123:
	.string	"blank"
	.align 2
.LC124:
	.string	"weapon_sniper"
	.align 2
.LC125:
	.string	"posses"
	.align 2
.LC126:
	.string	"cloak"
	.align 2
.LC127:
	.string	"bullstop"
	.align 2
.LC128:
	.string	"irvis"
	.align 2
.LC129:
	.string	"spedlevl"
	.align 2
.LC130:
	.string	"damlevl"
	.align 2
.LC131:
	.string	"stamlevl"
	.align 2
.LC132:
	.string	"heallevl"
	.align 2
.LC133:
	.long 0x0
	.align 2
.LC134:
	.long 0x41200000
	.align 2
.LC135:
	.long 0x41a00000
	.align 2
.LC136:
	.long 0x41f00000
	.align 2
.LC137:
	.long 0x42200000
	.align 2
.LC138:
	.long 0x42480000
	.align 2
.LC139:
	.long 0x42700000
	.align 2
.LC140:
	.long 0x428c0000
	.align 2
.LC141:
	.long 0x42a00000
	.align 2
.LC142:
	.long 0x42b40000
	.align 2
.LC143:
	.long 0x42c80000
	.align 2
.LC144:
	.long 0x42dc0000
	.align 2
.LC145:
	.long 0x42f00000
	.align 2
.LC146:
	.long 0x43020000
	.align 2
.LC147:
	.long 0x430c0000
	.align 2
.LC148:
	.long 0x43160000
	.align 2
.LC149:
	.long 0x43200000
	.align 2
.LC150:
	.long 0x432a0000
	.align 2
.LC151:
	.long 0x43340000
	.align 2
.LC152:
	.long 0x433e0000
	.align 2
.LC153:
	.long 0x43480000
	.align 3
.LC154:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl MatrixSetStats
	.type	 MatrixSetStats,@function
MatrixSetStats:
	stwu 1,-176(1)
	mflr 0
	stfd 31,168(1)
	stmw 26,144(1)
	stw 0,180(1)
	lis 9,.LC133@ha
	mr 31,3
	la 9,.LC133@l(9)
	lfs 0,924(31)
	li 27,0
	lfs 13,0(9)
	li 26,0
	fcmpu 0,0,13
	bc 4,1,.L32
	lis 9,gi@ha
	lis 3,.LC100@ha
	la 9,gi@l(9)
	la 3,.LC100@l(3)
	lwz 0,40(9)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
.L32:
	lis 9,.LC134@ha
	lfs 13,924(31)
	la 9,.LC134@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L33
	lis 9,gi+40@ha
	lis 3,.LC101@ha
	lwz 0,gi+40@l(9)
	la 3,.LC101@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
.L33:
	lis 9,.LC135@ha
	lfs 13,924(31)
	la 9,.LC135@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L34
	lis 9,gi+40@ha
	lis 3,.LC102@ha
	lwz 0,gi+40@l(9)
	la 3,.LC102@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
.L34:
	lis 9,.LC136@ha
	lfs 13,924(31)
	la 9,.LC136@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L35
	lis 9,gi+40@ha
	lis 3,.LC103@ha
	lwz 0,gi+40@l(9)
	la 3,.LC103@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
.L35:
	lis 9,.LC137@ha
	lfs 13,924(31)
	la 9,.LC137@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L36
	lis 9,gi+40@ha
	lis 3,.LC104@ha
	lwz 0,gi+40@l(9)
	la 3,.LC104@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
.L36:
	lis 9,.LC138@ha
	lfs 13,924(31)
	la 9,.LC138@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L37
	lis 9,gi+40@ha
	lis 3,.LC105@ha
	lwz 0,gi+40@l(9)
	la 3,.LC105@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
.L37:
	lis 9,.LC139@ha
	lfs 13,924(31)
	la 9,.LC139@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L38
	lis 9,gi+40@ha
	lis 3,.LC106@ha
	lwz 0,gi+40@l(9)
	la 3,.LC106@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
.L38:
	lis 9,.LC140@ha
	lfs 13,924(31)
	la 9,.LC140@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L39
	lis 9,gi+40@ha
	lis 3,.LC107@ha
	lwz 0,gi+40@l(9)
	la 3,.LC107@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
.L39:
	lis 9,.LC141@ha
	lfs 13,924(31)
	la 9,.LC141@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L40
	lis 9,gi+40@ha
	lis 3,.LC108@ha
	lwz 0,gi+40@l(9)
	la 3,.LC108@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
.L40:
	lis 9,.LC142@ha
	lfs 13,924(31)
	la 9,.LC142@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L41
	lis 9,gi+40@ha
	lis 3,.LC109@ha
	lwz 0,gi+40@l(9)
	la 3,.LC109@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
.L41:
	lis 9,.LC143@ha
	lfs 13,924(31)
	la 9,.LC143@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L42
	lis 9,gi+40@ha
	lis 3,.LC110@ha
	lwz 0,gi+40@l(9)
	la 3,.LC110@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
.L42:
	lis 9,.LC144@ha
	lfs 13,924(31)
	la 9,.LC144@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L43
	lis 9,gi+40@ha
	lis 3,.LC111@ha
	lwz 0,gi+40@l(9)
	la 3,.LC111@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
.L43:
	lis 9,.LC145@ha
	lfs 13,924(31)
	la 9,.LC145@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L44
	lis 9,gi+40@ha
	lis 3,.LC112@ha
	lwz 0,gi+40@l(9)
	la 3,.LC112@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
.L44:
	lis 9,.LC146@ha
	lfs 13,924(31)
	la 9,.LC146@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L45
	lis 9,gi+40@ha
	lis 3,.LC113@ha
	lwz 0,gi+40@l(9)
	la 3,.LC113@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
.L45:
	lis 9,.LC147@ha
	lfs 13,924(31)
	la 9,.LC147@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L46
	lis 9,gi+40@ha
	lis 3,.LC114@ha
	lwz 0,gi+40@l(9)
	la 3,.LC114@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
.L46:
	lis 9,.LC148@ha
	lfs 13,924(31)
	la 9,.LC148@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L47
	lis 9,gi+40@ha
	lis 3,.LC115@ha
	lwz 0,gi+40@l(9)
	la 3,.LC115@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
.L47:
	lis 9,.LC149@ha
	lfs 13,924(31)
	la 9,.LC149@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L48
	lis 9,gi+40@ha
	lis 3,.LC116@ha
	lwz 0,gi+40@l(9)
	la 3,.LC116@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
.L48:
	lis 9,.LC150@ha
	lfs 13,924(31)
	la 9,.LC150@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L49
	lis 9,gi+40@ha
	lis 3,.LC117@ha
	lwz 0,gi+40@l(9)
	la 3,.LC117@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
.L49:
	lis 9,.LC151@ha
	lfs 13,924(31)
	la 9,.LC151@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L50
	lis 9,gi+40@ha
	lis 3,.LC118@ha
	lwz 0,gi+40@l(9)
	la 3,.LC118@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
.L50:
	lis 9,.LC152@ha
	lfs 13,924(31)
	la 9,.LC152@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L51
	lis 9,gi+40@ha
	lis 3,.LC119@ha
	lwz 0,gi+40@l(9)
	la 3,.LC119@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
.L51:
	lis 9,.LC153@ha
	lfs 13,924(31)
	la 9,.LC153@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L52
	lis 9,gi+40@ha
	lis 3,.LC120@ha
	lwz 0,gi+40@l(9)
	la 3,.LC120@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
.L52:
	lfs 0,924(31)
	lis 9,gi@ha
	lwz 10,84(31)
	la 30,gi@l(9)
	li 0,1
	fctiwz 13,0
	stfd 13,136(1)
	lwz 11,140(1)
	sth 11,156(10)
	lwz 9,84(31)
	sth 0,182(9)
	lwz 29,84(31)
	lwz 11,32(30)
	lwz 9,1788(29)
	mtlr 11
	lwz 3,76(9)
	blrl
	lwz 0,88(29)
	cmpw 0,0,3
	bc 4,2,.L53
	lwz 9,84(31)
	lwz 0,3904(9)
	cmpwi 0,0,0
	bc 4,2,.L54
	lwz 0,40(30)
	lis 3,.LC121@ha
	la 3,.LC121@l(3)
	b .L84
.L54:
	cmpwi 0,0,1
	bc 4,2,.L57
	lwz 0,40(30)
	lis 3,.LC122@ha
	la 3,.LC122@l(3)
	b .L84
.L53:
	lwz 0,40(30)
	lis 3,.LC123@ha
	la 3,.LC123@l(3)
.L84:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,160(9)
.L57:
	lwz 9,84(31)
	lis 4,.LC124@ha
	la 4,.LC124@l(4)
	lwz 11,1788(9)
	lwz 3,0(11)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L58
	lwz 9,84(31)
	lwz 0,3548(9)
	andi. 9,0,1
	bc 12,2,.L58
	mr 3,31
	bl MatrixSniperHud
.L58:
	lwz 9,84(31)
	lwz 0,3488(9)
	cmpwi 0,0,0
	bc 12,2,.L59
	li 0,0
	sth 0,154(9)
.L59:
	lwz 9,84(31)
	lha 0,138(9)
	cmpwi 0,0,0
	bc 12,2,.L60
	li 0,0
	sth 0,138(9)
.L60:
	lwz 9,84(31)
	lha 0,140(9)
	cmpwi 0,0,0
	bc 12,2,.L61
	li 0,0
	sth 0,140(9)
.L61:
	lwz 9,84(31)
	lha 0,162(9)
	cmpwi 0,0,0
	bc 12,2,.L62
	li 0,0
	sth 0,162(9)
.L62:
	lwz 9,84(31)
	lha 0,164(9)
	cmpwi 0,0,0
	bc 12,2,.L63
	li 0,0
	sth 0,164(9)
.L63:
	lis 9,level@ha
	lfs 13,1028(31)
	lis 28,level@ha
	la 30,level@l(9)
	lfs 0,4(30)
	fcmpu 0,13,0
	bc 4,1,.L64
	lis 9,gi+40@ha
	lis 3,.LC125@ha
	lwz 0,gi+40@l(9)
	la 3,.LC125@l(3)
	li 27,1
	mtlr 0
	blrl
	lwz 11,84(31)
	sth 3,138(11)
	lfs 12,4(30)
	lfs 0,1028(31)
	lwz 11,84(31)
	fsubs 0,0,12
	fctiwz 13,0
	stfd 13,136(1)
	lwz 9,140(1)
	sth 9,140(11)
.L64:
	lwz 0,level@l(28)
	lis 30,0x4330
	lis 11,.LC154@ha
	xoris 0,0,0x8000
	la 11,.LC154@l(11)
	stw 0,140(1)
	stw 30,136(1)
	lfd 31,0(11)
	lfd 0,136(1)
	lwz 11,84(31)
	fsub 0,0,31
	lfs 13,3888(11)
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L65
	cmpwi 0,27,0
	bc 4,2,.L66
	lis 9,gi+40@ha
	lis 3,.LC126@ha
	lwz 0,gi+40@l(9)
	la 3,.LC126@l(3)
	li 27,1
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC134@ha
	la 11,.LC134@l(11)
	sth 3,138(10)
	lwz 0,level@l(28)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,140(1)
	mr 11,9
	stw 30,136(1)
	lfd 13,136(1)
	lfs 0,3888(10)
	fsub 13,13,31
	frsp 13,13
	fsubs 0,0,13
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,136(1)
	lwz 11,140(1)
	sth 11,140(10)
	b .L65
.L66:
	lis 9,gi+40@ha
	lis 3,.LC126@ha
	lwz 0,gi+40@l(9)
	la 3,.LC126@l(3)
	li 26,1
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC134@ha
	la 11,.LC134@l(11)
	sth 3,162(10)
	lwz 0,level@l(28)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,140(1)
	mr 11,9
	stw 30,136(1)
	lfd 13,136(1)
	lfs 0,3888(10)
	fsub 13,13,31
	frsp 13,13
	fsubs 0,0,13
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,136(1)
	lwz 11,140(1)
	sth 11,164(10)
.L65:
	lis 11,level@ha
	lfs 13,912(31)
	lwz 0,level@l(11)
	lis 30,0x4330
	lis 11,.LC154@ha
	xoris 0,0,0x8000
	la 11,.LC154@l(11)
	stw 0,140(1)
	stw 30,136(1)
	lfd 31,0(11)
	lfd 0,136(1)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L68
	cmpwi 7,27,0
	cmpwi 6,26,0
	mfcr 0
	rlwinm 9,0,31,1
	rlwinm 0,0,27,1
	or. 11,9,0
	bc 12,2,.L68
	bc 4,30,.L69
	lis 9,gi+40@ha
	lis 3,.LC127@ha
	lwz 0,gi+40@l(9)
	la 3,.LC127@l(3)
	li 27,1
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC134@ha
	la 11,.LC134@l(11)
	sth 3,138(10)
	lwz 0,level@l(28)
	lfs 13,912(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,140(1)
	mr 11,9
	stw 30,136(1)
	lfd 0,136(1)
	lwz 10,84(31)
	fsub 0,0,31
	frsp 0,0
	fsubs 13,13,0
	fdivs 13,13,11
	fctiwz 12,13
	stfd 12,136(1)
	lwz 11,140(1)
	sth 11,140(10)
	b .L68
.L69:
	bc 4,26,.L68
	lis 9,gi+40@ha
	lis 3,.LC127@ha
	lwz 0,gi+40@l(9)
	la 3,.LC127@l(3)
	li 26,1
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC134@ha
	la 11,.LC134@l(11)
	sth 3,162(10)
	lwz 0,level@l(28)
	lfs 13,912(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,140(1)
	mr 11,9
	stw 30,136(1)
	lfd 0,136(1)
	lwz 10,84(31)
	fsub 0,0,31
	frsp 0,0
	fsubs 13,13,0
	fdivs 13,13,11
	fctiwz 12,13
	stfd 12,136(1)
	lwz 11,140(1)
	sth 11,164(10)
.L68:
	lis 11,level@ha
	lwz 10,84(31)
	lwz 0,level@l(11)
	lis 30,0x4330
	lis 11,.LC154@ha
	lfs 13,3884(10)
	xoris 0,0,0x8000
	la 11,.LC154@l(11)
	stw 0,140(1)
	stw 30,136(1)
	lfd 31,0(11)
	lfd 0,136(1)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L72
	cmpwi 7,27,0
	cmpwi 6,26,0
	mfcr 0
	rlwinm 9,0,31,1
	rlwinm 0,0,27,1
	or. 11,9,0
	bc 12,2,.L72
	bc 4,30,.L73
	lis 9,gi+40@ha
	lis 3,.LC128@ha
	lwz 0,gi+40@l(9)
	la 3,.LC128@l(3)
	li 27,1
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC134@ha
	la 11,.LC134@l(11)
	sth 3,138(10)
	lwz 0,level@l(28)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,140(1)
	mr 11,9
	stw 30,136(1)
	lfd 13,136(1)
	lfs 0,3884(10)
	fsub 13,13,31
	frsp 13,13
	fsubs 0,0,13
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,136(1)
	lwz 11,140(1)
	sth 11,140(10)
	b .L72
.L73:
	bc 4,26,.L72
	lis 9,gi+40@ha
	lis 3,.LC128@ha
	lwz 0,gi+40@l(9)
	la 3,.LC128@l(3)
	li 26,1
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC134@ha
	la 11,.LC134@l(11)
	sth 3,162(10)
	lwz 0,level@l(28)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,140(1)
	mr 11,9
	stw 30,136(1)
	lfd 13,136(1)
	lfs 0,3884(10)
	fsub 13,13,31
	frsp 13,13
	fsubs 0,0,13
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,136(1)
	lwz 11,140(1)
	sth 11,164(10)
.L72:
	lis 11,level@ha
	lwz 10,84(31)
	lwz 0,level@l(11)
	lis 30,0x4330
	lis 11,.LC154@ha
	lfs 13,3876(10)
	xoris 0,0,0x8000
	la 11,.LC154@l(11)
	stw 0,140(1)
	stw 30,136(1)
	lfd 31,0(11)
	lfd 0,136(1)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L76
	cmpwi 7,27,0
	cmpwi 6,26,0
	mfcr 0
	rlwinm 9,0,31,1
	rlwinm 0,0,27,1
	or. 11,9,0
	bc 12,2,.L76
	bc 4,30,.L77
	lis 9,gi+40@ha
	lis 3,.LC129@ha
	lwz 0,gi+40@l(9)
	la 3,.LC129@l(3)
	li 27,1
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC134@ha
	la 11,.LC134@l(11)
	sth 3,138(10)
	lwz 0,level@l(28)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,140(1)
	mr 11,9
	stw 30,136(1)
	lfd 13,136(1)
	lfs 0,3876(10)
	fsub 13,13,31
	frsp 13,13
	fsubs 0,0,13
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,136(1)
	lwz 11,140(1)
	sth 11,140(10)
	b .L76
.L77:
	bc 4,26,.L76
	lis 9,gi+40@ha
	lis 3,.LC129@ha
	lwz 0,gi+40@l(9)
	la 3,.LC129@l(3)
	li 26,1
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC134@ha
	la 11,.LC134@l(11)
	sth 3,162(10)
	lwz 0,level@l(28)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,140(1)
	mr 11,9
	stw 30,136(1)
	lfd 13,136(1)
	lfs 0,3876(10)
	fsub 13,13,31
	frsp 13,13
	fsubs 0,0,13
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,136(1)
	lwz 11,140(1)
	sth 11,164(10)
.L76:
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 29,0x4330
	lis 9,.LC154@ha
	xoris 0,0,0x8000
	la 9,.LC154@l(9)
	stw 0,140(1)
	stw 29,136(1)
	lfd 31,0(9)
	lfd 0,136(1)
	lis 9,matrix@ha
	la 30,matrix@l(9)
	lfs 13,24(30)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L80
	cmpwi 7,27,0
	cmpwi 6,26,0
	mfcr 0
	rlwinm 9,0,31,1
	rlwinm 0,0,27,1
	or. 11,9,0
	bc 12,2,.L80
	bc 4,30,.L81
	lis 9,gi+40@ha
	lis 3,.LC128@ha
	lwz 0,gi+40@l(9)
	la 3,.LC128@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC134@ha
	la 11,.LC134@l(11)
	sth 3,138(10)
	lwz 0,level@l(28)
	lfs 13,24(30)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,140(1)
	mr 11,9
	stw 29,136(1)
	lfd 0,136(1)
	lwz 10,84(31)
	fsub 0,0,31
	frsp 0,0
	fsubs 13,13,0
	fdivs 13,13,11
	fctiwz 12,13
	stfd 12,136(1)
	lwz 11,140(1)
	sth 11,140(10)
	b .L80
.L81:
	bc 4,26,.L80
	lis 9,gi+40@ha
	lis 3,.LC128@ha
	lwz 0,gi+40@l(9)
	la 3,.LC128@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC134@ha
	la 11,.LC134@l(11)
	sth 3,162(10)
	lwz 0,level@l(28)
	lfs 13,24(30)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,140(1)
	mr 11,9
	stw 29,136(1)
	lfd 0,136(1)
	lwz 10,84(31)
	fsub 0,0,31
	frsp 0,0
	fsubs 13,13,0
	fdivs 13,13,11
	fctiwz 12,13
	stfd 12,136(1)
	lwz 11,140(1)
	sth 11,164(10)
.L80:
	lis 29,gi@ha
	lis 3,.LC130@ha
	la 29,gi@l(29)
	la 3,.LC130@l(3)
	lwz 9,40(29)
	mtlr 9
	blrl
	lwz 9,84(31)
	lis 11,.LC131@ha
	sth 3,168(9)
	lwz 10,84(31)
	la 3,.LC131@l(11)
	lhz 0,994(31)
	sth 0,166(10)
	lwz 9,40(29)
	mtlr 9
	blrl
	lwz 9,84(31)
	lis 11,.LC132@ha
	sth 3,176(9)
	lhz 0,986(31)
	la 3,.LC132@l(11)
	lwz 10,84(31)
	sth 0,174(10)
	lwz 0,40(29)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,172(9)
	lhz 0,990(31)
	lwz 9,84(31)
	sth 0,170(9)
	lwz 0,180(1)
	mtlr 0
	lmw 26,144(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe3:
	.size	 MatrixSetStats,.Lfe3-MatrixSetStats
	.globl matrix_statusbar
	.section	".rodata"
	.align 2
.LC156:
	.ascii	"yb\t-24 xl\t0 hnum xl\t50 pic 0 if 2 \txv\t100 \tanum \txv\t"
	.ascii	"150 \tpic 2 endif \tyb\t-50\t\txl\t0 \tnum\t3\t18\t\txl\t50 "
	.ascii	"\tpic 19 yb\t-24 if 4 \txv\t200 \trnum \txv\t250 \tpic 4 end"
	.ascii	"if if 6 \txv\t296 \tpic 6 endif yb\t-50 if 7 yb\t-102 \txl\t"
	.ascii	"0 \tpic 7 \txl\t26 \tyb\t-94 \tstat_string 8 \tyb\t-50 endif"
	.ascii	" if 9 \txr\t-58 \tnum\t2\t10 \txr\t-24 \tpic\t9 endif if 22 "
	.ascii	"\tyb\t-74 \txr\t-58 "
	.string	"\tnum\t2\t22 \txr\t-24 \tpic\t21 \tyb\t-50 endif if 11 \txv\t148 \tpic\t11 endif if 31 \tyv\t20\t\txv\t60 \tpic 20 \txl\t50 \txv\t100 yb\t-24 endif xr\t-50 yt 2 num 3 14 if 17 xv 0 yb -58 string2 \"SPECTATOR MODE\" endif if 16 xv 0 yb -68 string \"Chasing\" xv 64 stat_string 16 endif "
	.section	".sdata","aw"
	.align 2
	.type	 matrix_statusbar,@object
	.size	 matrix_statusbar,4
matrix_statusbar:
	.long .LC156
	.comm	damage_deserts,4,4
	.comm	damage_mk23,4,4
	.comm	damage_mp5,4,4
	.comm	damage_m4,4,4
	.comm	damage_pumps,4,4
	.comm	damage_smc,4,4
	.comm	damage_sniper,4,4
	.comm	damage_knife,4,4
	.comm	damage_fist,4,4
	.comm	damageradius_rack,4,4
	.comm	damageradius_grenade,4,4
	.comm	radiusdamage_rack,4,4
	.comm	radiusdamage_grenade,4,4
	.comm	ammo_deserts,4,4
	.comm	ammo_mk23,4,4
	.comm	ammo_mp5,4,4
	.comm	ammo_m4,4,4
	.comm	ammo_pumps,4,4
	.comm	ammo_smc,4,4
	.comm	ammo_sniper,4,4
	.comm	ammo_knife,4,4
	.comm	ammo_grenade,4,4
	.comm	ammo_rack,4,4
	.comm	damage_jab,4,4
	.comm	damage_hook,4,4
	.comm	damage_uppercut,4,4
	.comm	damage_hoverkick,4,4
	.comm	damage_spinkick,4,4
	.comm	reload_jab,4,4
	.comm	reload_hook,4,4
	.comm	reload_uppercut,4,4
	.comm	reload_hoverkick,4,4
	.comm	reload_spinkick,4,4
	.comm	possesban,4,4
	.comm	sv_maxlevel,4,4
	.comm	zk_logonly,4,4
	.comm	teamplay,4,4
	.comm	tankmode,4,4
	.comm	weaponrespawntime,4,4
	.comm	weaponban,4,4
	.comm	laseroff,4,4
	.comm	streakoff,4,4
	.comm	shellsoff,4,4
	.comm	redteamskin,4,4
	.comm	redteamname,4,4
	.comm	blueteamskin,4,4
	.comm	blueteamname,4,4
	.comm	matchtimelimit,4,4
	.comm	teamfraglimit,4,4
	.comm	matchmode,4,4
	.comm	choosestuff,4,4
	.comm	hop,4,4
	.comm	action,4,4
	.comm	faglimit,4,4
	.comm	combomessage,4,4
	.comm	killstreakmessage,4,4
	.comm	streakmessage2,4,4
	.comm	streakmessage3,4,4
	.comm	streakmessage4,4,4
	.comm	streakmessage5,4,4
	.comm	streakmessage6,4,4
	.comm	matrix,36,4
	.comm	vid_ref,4,4
	.section	".text"
	.align 2
	.globl MatrixDoAtDeath
	.type	 MatrixDoAtDeath,@function
MatrixDoAtDeath:
	blr
.Lfe4:
	.size	 MatrixDoAtDeath,.Lfe4-MatrixDoAtDeath
	.section	".rodata"
	.align 3
.LC157:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl MatrixClientInit
	.type	 MatrixClientInit,@function
MatrixClientInit:
	stwu 1,-32(1)
	stmw 28,16(1)
	lwz 10,84(3)
	li 0,1
	li 11,0
	stw 0,1088(3)
	li 9,0
	lis 29,0x42c8
	stw 11,3868(10)
	li 28,200
	lis 6,level@ha
	lwz 10,84(3)
	lis 4,0x4330
	lis 7,.LC157@ha
	mr 5,8
	lwz 0,116(10)
	la 7,.LC157@l(7)
	lfd 13,0(7)
	rlwinm 0,0,0,30,28
	mr 7,8
	stw 0,116(10)
	stw 9,1084(3)
	stw 9,904(3)
	stw 9,908(3)
	stw 9,912(3)
	stw 9,916(3)
	stw 29,924(3)
	stw 28,980(3)
	stw 11,988(3)
	stw 11,984(3)
	stw 11,992(3)
	stw 11,952(3)
	stw 11,972(3)
	stw 11,1008(3)
	lwz 0,level@l(6)
	lwz 9,84(3)
	xoris 0,0,0x8000
	stw 0,12(1)
	stw 4,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,3892(9)
	stw 11,1060(3)
	lwz 9,level@l(6)
	stw 11,1096(3)
	addi 9,9,-30
	xoris 9,9,0x8000
	stw 9,12(1)
	stw 4,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,1100(3)
	lwz 9,level@l(6)
	stw 11,1104(3)
	addi 9,9,-30
	stw 11,1108(3)
	xoris 9,9,0x8000
	stw 9,12(1)
	stw 4,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,1112(3)
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 MatrixClientInit,.Lfe5-MatrixClientInit
	.section	".rodata"
	.align 2
.LC158:
	.long 0x0
	.section	".text"
	.align 2
	.globl MatrixBeginDM
	.type	 MatrixBeginDM,@function
MatrixBeginDM:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	crxor 6,6,6
	bl Matrix_MOTD
	lis 9,.LC158@ha
	la 9,.LC158@l(9)
	lfs 13,0(9)
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L22
	lis 9,matchmode@ha
	lwz 11,matchmode@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L22
	lis 9,tankmode@ha
	lwz 11,tankmode@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L21
.L22:
	lis 4,.LC10@ha
	mr 3,31
	la 4,.LC10@l(4)
	crxor 6,6,6
	bl stuffcmd
.L21:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 MatrixBeginDM,.Lfe6-MatrixBeginDM
	.section	".rodata"
	.align 3
.LC159:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl MatrixFrame
	.type	 MatrixFrame,@function
MatrixFrame:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 10,0x4330
	lis 9,.LC159@ha
	xoris 0,0,0x8000
	la 9,.LC159@l(9)
	stw 0,12(1)
	stw 10,8(1)
	lfd 12,0(9)
	lfd 0,8(1)
	lis 9,matrix@ha
	la 8,matrix@l(9)
	lfs 13,24(8)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,2,.L24
	lis 9,gi+24@ha
	lis 4,.LC11@ha
	lwz 9,gi+24@l(9)
	la 4,.LC11@l(4)
	li 3,800
	li 0,0
	mtlr 9
	stw 0,12(8)
	blrl
.L24:
	bl MatrixMatchThink
	bl MatrixTankThink
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe7:
	.size	 MatrixFrame,.Lfe7-MatrixFrame
	.section	".rodata"
	.align 2
.LC160:
	.long 0x0
	.align 3
.LC161:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl MatrixDamage
	.type	 MatrixDamage,@function
MatrixDamage:
	stwu 1,-16(1)
	lwz 0,992(4)
	cmpwi 0,0,0
	bc 12,2,.L27
	srwi 9,0,31
	add 9,0,9
	srawi 9,9,1
	addi 9,9,1
	mullw 5,5,9
.L27:
	lwz 0,952(3)
	cmpwi 0,0,0
	bc 12,2,.L28
	lwz 0,492(3)
	cmpwi 0,0,0
	bc 4,2,.L28
	lis 9,.LC160@ha
	lfs 0,924(3)
	la 9,.LC160@l(9)
	lfs 12,0(9)
	fcmpu 0,0,12
	bc 12,2,.L28
	srwi 0,5,31
	lwz 7,84(3)
	add 0,5,0
	lis 8,0x4330
	srawi 5,0,1
	lis 11,.LC161@ha
	xoris 0,5,0x8000
	la 11,.LC161@l(11)
	stw 0,12(1)
	li 10,116
	stw 8,8(1)
	lfd 13,0(11)
	lfd 0,8(1)
	li 11,122
	stw 10,56(3)
	stw 11,3724(7)
	fsub 0,0,13
	lfs 13,924(3)
	frsp 0,0
	fcmpu 0,0,13
	bc 4,1,.L29
	stfs 12,924(3)
	b .L28
.L29:
	fsubs 0,13,0
	stfs 0,924(3)
.L28:
	mr 3,5
	la 1,16(1)
	blr
.Lfe8:
	.size	 MatrixDamage,.Lfe8-MatrixDamage
	.section	".rodata"
	.align 3
.LC162:
	.long 0x3fc99999
	.long 0x9999999a
	.align 3
.LC163:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl MatrixBlend
	.type	 MatrixBlend,@function
MatrixBlend:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 10,0x4330
	mr 7,3
	lis 9,.LC163@ha
	lwz 8,84(7)
	xoris 0,0,0x8000
	la 9,.LC163@l(9)
	stw 0,12(1)
	stw 10,8(1)
	lfd 13,0(9)
	lfd 0,8(1)
	lfs 12,3884(8)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L86
	fsubs 0,12,0
	mr 9,11
	fctiwz 13,0
	stfd 13,8(1)
	lwz 0,12(1)
	cmpwi 0,0,30
	bc 12,1,.L88
	andi. 9,0,4
	bc 12,2,.L87
.L88:
	lwz 0,116(8)
	lis 9,.LC162@ha
	li 3,1
	lfd 1,.LC162@l(9)
	li 4,0
	li 5,0
	ori 0,0,4
	stw 0,116(8)
	lwz 6,84(7)
	addi 6,6,96
	creqv 6,6,6
	bl SV_AddBlend
	b .L90
.L87:
.L86:
	lwz 0,116(8)
	rlwinm 0,0,0,30,28
	stw 0,116(8)
.L90:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 MatrixBlend,.Lfe9-MatrixBlend
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
