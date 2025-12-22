	.file	"b_spawn.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"misc/spawn.wav"
	.align 2
.LC1:
	.long 0x0
	.align 2
.LC2:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Bot_respawn
	.type	 Bot_respawn,@function
Bot_respawn:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,.LC1@ha
	lis 9,deathmatch@ha
	la 11,.LC1@l(11)
	mr 31,3
	lfs 13,0(11)
	lis 10,ctf@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L8
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L8
	lwz 9,ctf@l(10)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L7
.L8:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L9
	mr 3,31
	bl CopyToBodyQue
.L9:
	lis 11,.LC1@ha
	lwz 0,184(31)
	lis 9,ctf@ha
	la 11,.LC1@l(11)
	lfs 13,0(11)
	rlwinm 0,0,0,0,30
	lwz 11,ctf@l(9)
	stw 0,184(31)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L10
	lwz 9,84(31)
	mr 3,31
	li 4,1
	lwz 5,4048(9)
	bl Bot_PutClientInServer
	b .L11
.L10:
	mr 3,31
	li 4,1
	li 5,0
	bl Bot_PutClientInServer
.L11:
	mr 3,31
	addi 28,31,4
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
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	mtlr 9
	blrl
	lis 9,.LC2@ha
	lwz 0,16(29)
	lis 11,.LC2@ha
	la 9,.LC2@l(9)
	la 11,.LC2@l(11)
	lfs 1,0(9)
	mr 5,3
	mtlr 0
	li 4,2
	lis 9,.LC1@ha
	lfs 2,0(11)
	mr 3,31
	la 9,.LC1@l(9)
	lfs 3,0(9)
	blrl
	lwz 11,84(31)
	li 0,32
	li 10,14
	lis 8,level+4@ha
	stb 0,16(11)
	lwz 9,84(31)
	stb 10,17(9)
	lfs 0,level+4@l(8)
	lwz 11,84(31)
	stfs 0,4404(11)
.L7:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Bot_respawn,.Lfe1-Bot_respawn
	.section	".rodata"
	.align 2
.LC3:
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.align 2
.LC4:
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.align 2
.LC5:
	.string	"player"
	.align 2
.LC6:
	.string	"players/male/tris.md2"
	.align 2
.LC7:
	.string	"skin"
	.align 3
.LC8:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC9:
	.long 0x0
	.align 2
.LC10:
	.long 0x41400000
	.align 2
.LC11:
	.long 0x41000000
	.align 2
.LC12:
	.long 0x47800000
	.align 2
.LC13:
	.long 0x43b40000
	.align 2
.LC14:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Bot_PutClientInServer
	.type	 Bot_PutClientInServer,@function
Bot_PutClientInServer:
	stwu 1,-5072(1)
	mflr 0
	stfd 31,5064(1)
	stmw 20,5016(1)
	stw 0,5076(1)
	lis 9,.LC3@ha
	lis 11,.LC4@ha
	lwz 0,.LC3@l(9)
	la 6,.LC4@l(11)
	addi 7,1,8
	la 9,.LC3@l(9)
	lwz 8,.LC4@l(11)
	mr 22,5
	lwz 29,8(9)
	addi 10,1,24
	mr 31,3
	lwz 28,4(9)
	addi 5,1,56
	mr 21,4
	stw 0,8(1)
	mr 20,5
	stw 29,8(7)
	addi 4,1,40
	stw 28,4(7)
	lwz 0,8(6)
	lwz 9,4(6)
	stw 8,24(1)
	stw 0,8(10)
	stw 9,4(10)
	bl SelectSpawnPoint
	lis 9,.LC9@ha
	lis 11,g_edicts@ha
	lwz 30,84(31)
	la 9,.LC9@l(9)
	lis 0,0x6205
	lfs 13,0(9)
	ori 0,0,46533
	lis 9,deathmatch@ha
	lwz 10,deathmatch@l(9)
	lwz 9,g_edicts@l(11)
	lfs 0,20(10)
	subf 9,9,31
	mullw 9,9,0
	fcmpu 0,0,13
	srawi 9,9,2
	addi 24,9,-1
	bc 4,2,.L14
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L13
.L14:
	addi 28,1,1992
	addi 27,30,2108
	addi 26,1,3976
	mr 4,27
	li 5,1976
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
	b .L15
.L13:
	addi 27,1,1992
	li 4,0
	li 5,1976
	mr 3,27
	crxor 6,6,6
	bl memset
	addi 29,30,188
	mr 23,27
	addi 28,1,4488
	mr 4,29
	li 5,512
	mr 3,28
	crxor 6,6,6
	bl memcpy
	mr 27,29
	addi 25,30,2108
	mr 4,28
	mr 3,31
	bl ClientUserinfoChanged
.L15:
	addi 29,1,72
	mr 4,27
	li 5,1920
	mr 3,29
	crxor 6,6,6
	bl memcpy
	li 4,0
	li 5,4956
	mr 3,30
	crxor 6,6,6
	bl memset
	mr 4,29
	mr 3,27
	li 5,1920
	crxor 6,6,6
	bl memcpy
	lwz 0,724(30)
	cmpwi 0,0,0
	bc 12,1,.L16
	mr 3,30
	bl InitClientPersistant
.L16:
	mr 4,23
	li 5,1976
	mr 3,25
	li 29,0
	crxor 6,6,6
	bl memcpy
	lis 9,.LC9@ha
	mr 3,31
	la 9,.LC9@l(9)
	lfs 31,0(9)
	bl FetchClientEntData
	stw 29,552(31)
	lis 11,game+1028@ha
	mulli 10,24,4956
	lis 9,.LC5@ha
	lwz 0,game+1028@l(11)
	la 9,.LC5@l(9)
	li 6,2
	li 11,4
	stw 9,280(31)
	li 8,24
	add 0,0,10
	stw 11,260(31)
	li 9,1
	li 10,200
	lis 11,.LC10@ha
	stw 0,84(31)
	stw 8,508(31)
	la 11,.LC10@l(11)
	lis 4,level+4@ha
	stw 9,88(31)
	li 3,37
	lis 8,0x201
	stw 10,400(31)
	lis 7,.LC6@ha
	lis 5,ctf@ha
	stw 6,248(31)
	lis 10,player_die@ha
	la 7,.LC6@l(7)
	stw 6,512(31)
	la 10,player_die@l(10)
	ori 8,8,3
	stw 29,492(31)
	lfs 0,level+4@l(4)
	lfs 13,0(11)
	lwz 9,264(31)
	lis 11,player_pain@ha
	lwz 0,184(31)
	la 11,player_pain@l(11)
	fadds 0,0,13
	stb 3,924(31)
	rlwinm 9,9,0,21,19
	lwz 6,ctf@l(5)
	rlwinm 0,0,0,31,29
	stw 8,252(31)
	stfs 0,404(31)
	stw 7,268(31)
	stw 11,452(31)
	stw 10,456(31)
	stw 9,264(31)
	stw 0,184(31)
	stw 29,612(31)
	stw 29,608(31)
	stw 29,912(31)
	lfs 0,20(6)
	fcmpu 0,0,31
	bc 12,2,.L17
	lis 4,.LC7@ha
	stw 22,4048(30)
	mr 3,27
	la 4,.LC7@l(4)
	stw 29,4052(30)
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl CTFAssignSkin
.L17:
	lfs 9,8(1)
	cmpwi 0,21,0
	li 5,184
	lfs 10,12(1)
	li 4,0
	lfs 0,16(1)
	lfs 13,24(1)
	mfcr 28
	lfs 12,28(1)
	lfs 11,32(1)
	lwz 3,84(31)
	stfs 9,188(31)
	stfs 10,192(31)
	stfs 0,196(31)
	stfs 13,200(31)
	stfs 12,204(31)
	stfs 11,208(31)
	stfs 31,376(31)
	stfs 31,384(31)
	stfs 31,380(31)
	crxor 6,6,6
	bl memset
	lis 9,.LC11@ha
	lfs 0,40(1)
	lis 0,0x42b4
	la 9,.LC11@l(9)
	lis 8,gi+32@ha
	lwz 7,1764(30)
	lfs 10,0(9)
	mr 11,9
	mr 10,9
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,5008(1)
	lwz 9,5012(1)
	sth 9,4(30)
	lfs 0,44(1)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,5008(1)
	lwz 11,5012(1)
	sth 11,6(30)
	lfs 0,48(1)
	stw 0,112(30)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,5008(1)
	lwz 10,5012(1)
	sth 10,8(30)
	lwz 0,gi+32@l(8)
	lwz 3,32(7)
	mtlr 0
	blrl
	lis 11,.LC13@ha
	lis 9,.LC12@ha
	stw 3,88(30)
	la 11,.LC13@l(11)
	la 9,.LC12@l(9)
	lfs 13,48(1)
	lfs 10,0(11)
	lis 0,0x6205
	mr 5,20
	lis 11,g_edicts@ha
	lfs 9,0(9)
	ori 0,0,46533
	lwz 9,g_edicts@l(11)
	addi 7,30,4036
	addi 8,30,20
	lis 11,.LC14@ha
	lfs 11,40(1)
	li 10,0
	la 11,.LC14@l(11)
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
.L25:
	lfsx 0,10,5
	lfsx 12,10,7
	addi 10,10,4
	fsubs 0,0,12
	fmuls 0,0,9
	fdivs 0,0,10
	fctiwz 13,0
	stfd 13,5008(1)
	lwz 9,5012(1)
	sth 9,0(8)
	addi 8,8,2
	bdnz .L25
	lfs 0,60(1)
	li 0,0
	li 9,0
	stw 0,24(31)
	mr 3,31
	stw 0,16(31)
	stfs 0,20(31)
	stw 0,28(30)
	lfs 0,20(31)
	stfs 0,32(30)
	lfs 13,24(31)
	stfs 13,36(30)
	lfs 0,16(31)
	stfs 0,4252(30)
	lfs 13,20(31)
	stfs 13,4256(30)
	lfs 0,24(31)
	stfs 0,4260(30)
	stw 9,416(31)
	stw 9,540(31)
	bl KillBox
	lis 9,gi@ha
	mr 3,31
	la 29,gi@l(9)
	lwz 9,72(29)
	mtlr 9
	blrl
	lwz 0,1764(30)
	mr 3,31
	stw 0,4148(30)
	bl ChangeWeapon
	lis 9,Bot_AI_Think@ha
	lis 10,level+4@ha
	la 9,Bot_AI_Think@l(9)
	lis 11,.LC8@ha
	stw 9,436(31)
	mtcrf 128,28
	lfs 0,level+4@l(10)
	lfd 13,.LC8@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bc 4,2,.L24
	lwz 9,100(29)
	li 3,1
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
.L24:
	lwz 0,5076(1)
	mtlr 0
	lmw 20,5016(1)
	lfd 31,5064(1)
	la 1,5072(1)
	blr
.Lfe2:
	.size	 Bot_PutClientInServer,.Lfe2-Bot_PutClientInServer
	.section	".rodata"
	.align 2
.LC17:
	.string	"CaRRaC"
	.align 2
.LC18:
	.string	"male/jedi1"
	.align 2
.LC20:
	.string	"RipVTide"
	.align 2
.LC21:
	.string	"male/maul"
	.align 2
.LC23:
	.string	"Legion"
	.align 2
.LC24:
	.string	"male/jedi2"
	.align 2
.LC26:
	.string	"Darth Maul"
	.align 2
.LC27:
	.string	"Broken Fixed"
	.align 2
.LC28:
	.string	"male/ob1"
	.align 2
.LC29:
	.string	"-2+"
	.align 2
.LC30:
	.string	"male/playerskin"
	.align 2
.LC31:
	.string	"Privateer"
	.align 2
.LC32:
	.string	"male/hansolo"
	.align 2
.LC33:
	.string	"Falkon2"
	.align 2
.LC34:
	.string	"male/obiwan"
	.align 2
.LC35:
	.string	"ViolentBlue"
	.align 2
.LC36:
	.string	"male/combat"
	.align 2
.LC37:
	.string	"Darth Vader"
	.align 2
.LC38:
	.string	"Anakin"
	.align 2
.LC39:
	.string	"Armage"
	.align 2
.LC40:
	.string	"Red Knight"
	.align 2
.LC41:
	.string	"Grey Knight"
	.align 2
.LC42:
	.string	"Tim Elek"
	.align 2
.LC43:
	.string	"male/player1"
	.align 2
.LC44:
	.string	"Obiwan Kenobi"
	.align 2
.LC45:
	.string	"Quigon Jinn"
	.align 2
.LC46:
	.string	"McClane3"
	.align 2
.LC47:
	.string	"male/lando"
	.align 2
.LC48:
	.string	"ApocX"
	.align 2
.LC49:
	.string	"Electric"
	.align 2
.LC50:
	.string	"male/player2"
	.align 2
.LC51:
	.string	"Han Solo"
	.align 2
.LC52:
	.string	"Boba Fett"
	.align 2
.LC53:
	.string	"War|ocK"
	.align 2
.LC54:
	.string	"male/ctfred"
	.align 2
.LC55:
	.string	"deadguy"
	.align 2
.LC56:
	.string	"Maxer"
	.align 2
.LC57:
	.string	"Bitterman"
	.align 2
.LC58:
	.string	"male/ctfblue"
	.align 2
.LC59:
	.string	"Luke Skywalker"
	.align 2
.LC60:
	.string	"Damaramu"
	.align 2
.LC61:
	.string	"moresmart"
	.align 2
.LC62:
	.string	"AGWAR"
	.align 2
.LC63:
	.string	"Lando"
	.align 2
.LC64:
	.string	"Yoda"
	.align 2
.LC65:
	.string	"Palpatine"
	.align 2
.LC66:
	.string	"Bib Fortuna"
	.align 2
.LC67:
	.string	"Wicket"
	.align 2
.LC68:
	.string	"Drakis"
	.align 2
.LC69:
	.string	"hand"
	.align 2
.LC70:
	.string	"2"
	.align 2
.LC71:
	.string	"name"
	.align 2
.LC15:
	.long 0x46fffe00
	.align 3
.LC16:
	.long 0x3fc99999
	.long 0x9999999a
	.align 3
.LC19:
	.long 0x3fd99999
	.long 0x9999999a
	.align 3
.LC22:
	.long 0x3fe33333
	.long 0x33333333
	.align 3
.LC25:
	.long 0x3fe99999
	.long 0x9999999a
	.align 3
.LC72:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC73:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl Bot_Set_Data
	.type	 Bot_Set_Data,@function
Bot_Set_Data:
	stwu 1,-608(1)
	mflr 0
	stmw 29,596(1)
	stw 0,612(1)
	mr 29,4
	mr 31,3
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,588(1)
	lis 11,.LC72@ha
	cmpwi 0,29,0
	la 11,.LC72@l(11)
	stw 0,584(1)
	lfd 13,0(11)
	lfd 0,584(1)
	lis 11,.LC15@ha
	lfs 12,.LC15@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	bc 4,2,.L41
	lis 9,num_players@ha
	lwz 10,num_players@l(9)
	la 5,num_players@l(9)
	xori 11,10,1
	subfic 0,11,0
	adde 11,0,11
	xori 0,10,6
	subfic 9,0,0
	adde 0,9,0
	or. 9,11,0
	bc 12,2,.L42
	fmr 13,0
	lis 9,.LC16@ha
	lfd 0,.LC16@l(9)
	fcmpu 0,13,0
	bc 4,0,.L43
	addi 29,1,536
	lis 4,.LC17@ha
	la 4,.LC17@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC18@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC18@l(4)
	b .L114
.L43:
	lis 9,.LC19@ha
	lfd 0,.LC19@l(9)
	fcmpu 0,13,0
	bc 4,0,.L45
	addi 29,1,536
	lis 4,.LC20@ha
	la 4,.LC20@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	b .L115
.L45:
	lis 9,.LC22@ha
	lfd 0,.LC22@l(9)
	fcmpu 0,13,0
	bc 4,0,.L47
	addi 29,1,536
	lis 4,.LC23@ha
	la 4,.LC23@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC24@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC24@l(4)
	b .L114
.L47:
	lis 9,.LC25@ha
	lfd 0,.LC25@l(9)
	fcmpu 0,13,0
	bc 4,0,.L49
	addi 29,1,536
	lis 4,.LC26@ha
	la 4,.LC26@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	b .L115
.L49:
	lis 9,.LC73@ha
	la 9,.LC73@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L51
	addi 29,1,536
	lis 4,.LC27@ha
	la 4,.LC27@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC28@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC28@l(4)
	b .L114
.L51:
	addi 29,1,536
	lis 4,.LC29@ha
	la 4,.LC29@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC30@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC30@l(4)
	b .L114
.L42:
	xori 9,10,2
	subfic 0,9,0
	adde 9,0,9
	xori 0,10,7
	subfic 11,0,0
	adde 0,11,0
	or. 11,9,0
	bc 12,2,.L54
	fmr 13,0
	lis 9,.LC16@ha
	lfd 0,.LC16@l(9)
	fcmpu 0,13,0
	bc 4,0,.L55
	addi 29,1,536
	lis 4,.LC31@ha
	la 4,.LC31@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC32@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC32@l(4)
	b .L114
.L55:
	lis 9,.LC19@ha
	lfd 0,.LC19@l(9)
	fcmpu 0,13,0
	bc 4,0,.L57
	addi 29,1,536
	lis 4,.LC33@ha
	la 4,.LC33@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC34@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC34@l(4)
	b .L114
.L57:
	lis 9,.LC22@ha
	lfd 0,.LC22@l(9)
	fcmpu 0,13,0
	bc 4,0,.L59
	addi 29,1,536
	lis 4,.LC35@ha
	la 4,.LC35@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC36@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC36@l(4)
	b .L114
.L59:
	lis 9,.LC25@ha
	lfd 0,.LC25@l(9)
	fcmpu 0,13,0
	bc 4,0,.L61
	addi 29,1,536
	lis 4,.LC37@ha
	la 4,.LC37@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC18@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC18@l(4)
	b .L114
.L61:
	lis 9,.LC73@ha
	la 9,.LC73@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L63
	addi 29,1,536
	lis 4,.LC38@ha
	la 4,.LC38@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC24@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC24@l(4)
	b .L114
.L63:
	addi 29,1,536
	lis 4,.LC39@ha
	la 4,.LC39@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC32@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC32@l(4)
	b .L114
.L54:
	xori 0,10,8
	subfic 11,0,0
	adde 0,11,0
	or. 11,9,0
	bc 12,2,.L66
	fmr 13,0
	lis 9,.LC16@ha
	lfd 0,.LC16@l(9)
	fcmpu 0,13,0
	bc 4,0,.L67
	addi 29,1,536
	lis 4,.LC40@ha
	la 4,.LC40@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	b .L115
.L67:
	lis 9,.LC19@ha
	lfd 0,.LC19@l(9)
	fcmpu 0,13,0
	bc 4,0,.L69
	addi 29,1,536
	lis 4,.LC41@ha
	la 4,.LC41@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC36@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC36@l(4)
	b .L114
.L69:
	lis 9,.LC22@ha
	lfd 0,.LC22@l(9)
	fcmpu 0,13,0
	bc 4,0,.L71
	addi 29,1,536
	lis 4,.LC42@ha
	la 4,.LC42@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC43@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC43@l(4)
	b .L114
.L71:
	lis 9,.LC25@ha
	lfd 0,.LC25@l(9)
	fcmpu 0,13,0
	bc 4,0,.L73
	addi 29,1,536
	lis 4,.LC44@ha
	la 4,.LC44@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC34@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC34@l(4)
	b .L114
.L73:
	lis 9,.LC73@ha
	la 9,.LC73@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L75
	addi 29,1,536
	lis 4,.LC45@ha
	la 4,.LC45@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC18@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC18@l(4)
	b .L114
.L75:
	addi 29,1,536
	lis 4,.LC46@ha
	la 4,.LC46@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC47@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC47@l(4)
	b .L114
.L66:
	xori 9,10,3
	subfic 0,9,0
	adde 9,0,9
	xori 0,10,9
	subfic 11,0,0
	adde 0,11,0
	or. 11,9,0
	bc 12,2,.L78
	fmr 13,0
	lis 9,.LC16@ha
	lfd 0,.LC16@l(9)
	fcmpu 0,13,0
	bc 4,0,.L79
	addi 29,1,536
	lis 4,.LC48@ha
	la 4,.LC48@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC43@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC43@l(4)
	b .L114
.L79:
	lis 9,.LC19@ha
	lfd 0,.LC19@l(9)
	fcmpu 0,13,0
	bc 4,0,.L81
	addi 29,1,536
	lis 4,.LC49@ha
	la 4,.LC49@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC50@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC50@l(4)
	b .L114
.L81:
	lis 9,.LC22@ha
	lfd 0,.LC22@l(9)
	fcmpu 0,13,0
	bc 4,0,.L83
	addi 29,1,536
	lis 4,.LC51@ha
	la 4,.LC51@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC32@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC32@l(4)
	b .L114
.L83:
	lis 9,.LC25@ha
	lfd 0,.LC25@l(9)
	fcmpu 0,13,0
	bc 4,0,.L85
	addi 29,1,536
	lis 4,.LC52@ha
	la 4,.LC52@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC36@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC36@l(4)
	b .L114
.L85:
	lis 9,.LC73@ha
	la 9,.LC73@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L87
	addi 29,1,536
	lis 4,.LC53@ha
	la 4,.LC53@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC54@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC54@l(4)
	b .L114
.L87:
	addi 29,1,536
	lis 4,.LC55@ha
	la 4,.LC55@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	b .L115
.L78:
	cmpwi 7,10,10
	xori 9,10,4
	subfic 0,9,0
	adde 9,0,9
	mfcr 0
	rlwinm 0,0,31,1
	or. 11,9,0
	bc 12,2,.L90
	fmr 13,0
	lis 9,.LC16@ha
	lfd 0,.LC16@l(9)
	fcmpu 0,13,0
	bc 4,0,.L91
	addi 29,1,536
	lis 4,.LC56@ha
	la 4,.LC56@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC24@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC24@l(4)
	b .L114
.L91:
	lis 9,.LC19@ha
	lfd 0,.LC19@l(9)
	fcmpu 0,13,0
	bc 4,0,.L93
	addi 29,1,536
	lis 4,.LC57@ha
	la 4,.LC57@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC58@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC58@l(4)
	b .L114
.L93:
	lis 9,.LC22@ha
	lfd 0,.LC22@l(9)
	fcmpu 0,13,0
	bc 4,0,.L95
	addi 29,1,536
	lis 4,.LC59@ha
	la 4,.LC59@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC18@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC18@l(4)
	b .L114
.L95:
	lis 9,.LC25@ha
	lfd 0,.LC25@l(9)
	fcmpu 0,13,0
	bc 4,0,.L97
	addi 29,1,536
	lis 4,.LC60@ha
	la 4,.LC60@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC43@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC43@l(4)
	b .L114
.L97:
	lis 9,.LC73@ha
	la 9,.LC73@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L99
	addi 29,1,536
	lis 4,.LC61@ha
	la 4,.LC61@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	addi 0,1,520
	lis 4,.LC34@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC34@l(4)
	b .L114
.L99:
	addi 29,1,536
	lwz 5,0(5)
	lis 4,.LC62@ha
	la 4,.LC62@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
.L115:
	addi 0,1,520
	lis 4,.LC21@ha
	stw 29,556(1)
	mr 3,0
	la 4,.LC21@l(4)
.L114:
	stw 0,552(1)
	crxor 6,6,6
	bl sprintf
	b .L113
.L90:
	mfcr 9
	rlwinm 9,9,30,1
	xori 0,10,5
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	addi 0,1,536
	addi 9,1,520
	stw 0,556(1)
	stw 9,552(1)
	bc 12,2,.L113
	fmr 13,0
	lis 9,.LC16@ha
	lfd 0,.LC16@l(9)
	fcmpu 0,13,0
	bc 4,0,.L103
	lis 4,.LC63@ha
	mr 3,0
	la 4,.LC63@l(4)
	crxor 6,6,6
	bl sprintf
	lis 4,.LC47@ha
	lwz 3,552(1)
	la 4,.LC47@l(4)
	crxor 6,6,6
	bl sprintf
	b .L113
.L103:
	lis 9,.LC19@ha
	lfd 0,.LC19@l(9)
	fcmpu 0,13,0
	bc 4,0,.L105
	lis 4,.LC64@ha
	lwz 3,556(1)
	la 4,.LC64@l(4)
	b .L116
.L105:
	lis 9,.LC22@ha
	lfd 0,.LC22@l(9)
	fcmpu 0,13,0
	bc 4,0,.L107
	lis 4,.LC65@ha
	lwz 3,556(1)
	la 4,.LC65@l(4)
	crxor 6,6,6
	bl sprintf
	lis 4,.LC34@ha
	lwz 3,552(1)
	la 4,.LC34@l(4)
	crxor 6,6,6
	bl sprintf
	b .L113
.L107:
	lis 9,.LC25@ha
	lfd 0,.LC25@l(9)
	fcmpu 0,13,0
	bc 4,0,.L109
	lis 4,.LC66@ha
	lwz 3,556(1)
	la 4,.LC66@l(4)
	crxor 6,6,6
	bl sprintf
	lis 4,.LC50@ha
	lwz 3,552(1)
	la 4,.LC50@l(4)
	crxor 6,6,6
	bl sprintf
	b .L113
.L109:
	lis 9,.LC73@ha
	la 9,.LC73@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L111
	lis 4,.LC67@ha
	lwz 3,556(1)
	la 4,.LC67@l(4)
.L116:
	crxor 6,6,6
	bl sprintf
	lis 4,.LC24@ha
	lwz 3,552(1)
	la 4,.LC24@l(4)
	crxor 6,6,6
	bl sprintf
	b .L113
.L111:
	lis 4,.LC68@ha
	lwz 3,556(1)
	la 4,.LC68@l(4)
	crxor 6,6,6
	bl sprintf
	lis 4,.LC43@ha
	lwz 3,552(1)
	la 4,.LC43@l(4)
	crxor 6,6,6
	bl sprintf
	b .L113
.L41:
	addi 0,1,536
	mr 4,29
	mr 3,0
	stw 0,556(1)
	bl strcpy
	addi 0,1,520
	stw 0,552(1)
.L113:
	addi 29,1,8
	li 4,0
	li 5,512
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 4,.LC69@ha
	lis 5,.LC70@ha
	la 4,.LC69@l(4)
	la 5,.LC70@l(5)
	mr 3,29
	bl Info_SetValueForKey
	lwz 5,556(1)
	lis 4,.LC71@ha
	mr 3,29
	la 4,.LC71@l(4)
	bl Info_SetValueForKey
	lis 4,.LC7@ha
	lwz 5,552(1)
	mr 3,29
	la 4,.LC7@l(4)
	bl Info_SetValueForKey
	mr 3,31
	mr 4,29
	bl ClientConnect
	lwz 0,612(1)
	mtlr 0
	lmw 29,596(1)
	la 1,608(1)
	blr
.Lfe3:
	.size	 Bot_Set_Data,.Lfe3-Bot_Set_Data
	.section	".rodata"
	.align 2
.LC74:
	.string	"game"
	.align 2
.LC75:
	.string	""
	.align 2
.LC76:
	.string	"basedir"
	.align 2
.LC77:
	.string	"."
	.align 2
.LC78:
	.string	"baseq2"
	.align 2
.LC79:
	.string	"%s\\%s\\players\\%s.pcx"
	.align 2
.LC80:
	.string	"rb"
	.align 2
.LC81:
	.string	"Cannot add bots in CTF mode. (set cheats 1)\n"
	.align 2
.LC82:
	.string	"Can only add bots in multiplayer\n"
	.align 2
.LC83:
	.string	"No node file\n"
	.align 2
.LC84:
	.string	"cannot add any more bots\n"
	.align 2
.LC85:
	.long 0x46fffe00
	.align 2
.LC86:
	.long 0x0
	.align 3
.LC87:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC88:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl Spawn_Bot
	.type	 Spawn_Bot,@function
Spawn_Bot:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,sv_cheats@ha
	lis 10,.LC86@ha
	lwz 11,sv_cheats@l(9)
	la 10,.LC86@l(10)
	mr 5,4
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L130
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L130
	lis 4,.LC81@ha
	li 3,1
	la 4,.LC81@l(4)
	crxor 6,6,6
	bl safe_bprintf
	b .L129
.L130:
	lis 9,.LC86@ha
	lis 11,deathmatch@ha
	la 9,.LC86@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L131
	lis 4,.LC82@ha
	li 3,1
	la 4,.LC82@l(4)
	crxor 6,6,6
	bl safe_bprintf
	b .L129
.L131:
	lis 9,node_count@ha
	lhz 0,node_count@l(9)
	cmpwi 0,0,0
	bc 4,2,.L132
	lis 4,.LC83@ha
	li 3,1
	la 4,.LC83@l(4)
	crxor 6,6,6
	bl safe_bprintf
	b .L129
.L132:
	lis 11,maxclients@ha
	lwz 9,maxclients@l(11)
	li 4,0
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 8,28(1)
	cmpwi 0,8,0
	bc 4,1,.L138
	mulli 11,8,1076
	lis 9,g_edicts@ha
	lwz 10,g_edicts@l(9)
	addi 0,11,1076
	addi 11,11,1608
	add 7,0,10
	add 11,11,10
.L135:
	lwz 9,0(11)
	addic. 8,8,-1
	mr 6,7
	addi 11,11,-1076
	addi 7,6,-1076
	cmpw 7,9,4
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,9,0
	and 0,4,0
	or 4,0,9
	bc 12,1,.L135
.L138:
	lis 11,maxclients@ha
	lwz 9,maxclients@l(11)
	addi 4,4,1
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 8,28(1)
	cmpwi 0,8,0
	bc 4,1,.L144
	lis 9,g_edicts@ha
	mulli 10,8,1076
	lwz 7,g_edicts@l(9)
	add 11,7,10
	addi 6,11,1076
	lwz 0,88(6)
	cmpwi 0,0,0
	bc 12,2,.L144
	addi 0,10,1076
	addi 9,10,1164
	add 11,0,7
	add 9,9,7
.L142:
	addic. 8,8,-1
	addi 11,11,-1076
	bc 4,1,.L144
	lwzu 0,-1076(9)
	mr 6,11
	cmpwi 0,0,0
	bc 4,2,.L142
.L144:
	lwz 0,88(6)
	stw 4,532(6)
	addic 0,0,-1
	subfe 0,0,0
	and. 31,6,0
	bc 4,2,.L147
	lis 4,.LC84@ha
	li 3,1
	la 4,.LC84@l(4)
	crxor 6,6,6
	bl safe_bprintf
	b .L129
.L147:
	lis 7,num_players@ha
	lis 9,players@ha
	lwz 11,num_players@l(7)
	la 9,players@l(9)
	li 10,0
	li 8,-1
	ori 10,10,65535
	stw 11,264(31)
	slwi 0,11,2
	mr 4,3
	stwx 31,9,0
	addi 11,11,1
	li 29,1
	lwz 0,1000(31)
	lis 9,0x42b4
	li 6,0
	stw 11,num_players@l(7)
	mr 3,31
	ori 0,0,1
	stw 9,420(31)
	sth 8,994(31)
	stw 10,996(31)
	stw 0,1000(31)
	sth 8,992(31)
	sth 8,990(31)
	stw 29,972(31)
	stw 29,88(31)
	bl Bot_Set_Data
	mr 3,31
	bl G_InitEdict
	lwz 3,84(31)
	bl InitClientResp
	lis 9,.LC86@ha
	lis 11,ctf@ha
	la 9,.LC86@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L149
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC87@ha
	lis 11,.LC85@ha
	la 10,.LC87@l(10)
	stw 0,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lis 10,.LC88@ha
	lfs 12,.LC85@l(11)
	la 10,.LC88@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L150
	mr 3,31
	li 4,0
	li 5,1
	bl Bot_PutClientInServer
	b .L152
.L150:
	mr 3,31
	li 4,0
	li 5,2
	bl Bot_PutClientInServer
	b .L152
.L149:
	mr 3,31
	li 4,0
	li 5,0
	bl Bot_PutClientInServer
.L152:
	mr 3,31
	bl ClientEndServerFrame
.L129:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 Spawn_Bot,.Lfe4-Spawn_Bot
	.comm	node_count,2,2
	.comm	path_not_time_yet,4,4
	.comm	conversation_content,7760,4
	.comm	highlighted,4,4
	.comm	yeah_you,4,4
	.comm	its_me,4,4
	.comm	holdthephone,4,4
	.comm	NoTouch,4,4
	.comm	showingit,4,4
	.comm	path_time,4,4
	.comm	print_time,4,4
	.align 2
	.globl Bot_Find_Free_Client
	.type	 Bot_Find_Free_Client,@function
Bot_Find_Free_Client:
	stwu 1,-16(1)
	lis 11,maxclients@ha
	lwz 9,maxclients@l(11)
	li 5,0
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 8,12(1)
	cmpwi 0,8,0
	bc 4,1,.L28
	mulli 11,8,1076
	lis 9,g_edicts@ha
	lwz 10,g_edicts@l(9)
	addi 0,11,1076
	addi 11,11,1608
	add 7,0,10
	add 11,11,10
.L30:
	lwz 9,0(11)
	addic. 8,8,-1
	mr 6,7
	addi 11,11,-1076
	addi 7,6,-1076
	cmpw 7,9,5
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,9,0
	and 0,5,0
	or 5,0,9
	bc 12,1,.L30
.L28:
	lis 11,maxclients@ha
	lwz 9,maxclients@l(11)
	addi 5,5,1
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 8,12(1)
	cmpwi 0,8,0
	bc 4,1,.L34
	lis 9,g_edicts@ha
	mulli 10,8,1076
	lwz 7,g_edicts@l(9)
	add 11,7,10
	addi 6,11,1076
	lwz 0,88(6)
	cmpwi 0,0,0
	bc 12,2,.L34
	addi 0,10,1076
	addi 9,10,1164
	add 11,0,7
	add 9,9,7
.L35:
	addic. 8,8,-1
	addi 11,11,-1076
	bc 4,1,.L34
	lwzu 0,-1076(9)
	mr 6,11
	cmpwi 0,0,0
	bc 4,2,.L35
.L34:
	lwz 3,88(6)
	stw 5,532(6)
	addic 3,3,-1
	subfe 3,3,3
	and 3,6,3
	la 1,16(1)
	blr
.Lfe5:
	.size	 Bot_Find_Free_Client,.Lfe5-Bot_Find_Free_Client
	.align 2
	.globl Setup_Bot
	.type	 Setup_Bot,@function
Setup_Bot:
	lis 6,num_players@ha
	lis 9,players@ha
	lwz 11,num_players@l(6)
	la 9,players@l(9)
	li 10,0
	li 8,-1
	li 7,1
	stw 11,264(3)
	slwi 0,11,2
	ori 10,10,65535
	stwx 3,9,0
	addi 11,11,1
	lwz 0,1000(3)
	lis 9,0x42b4
	stw 11,num_players@l(6)
	ori 0,0,1
	stw 7,972(3)
	stw 0,1000(3)
	stw 9,420(3)
	sth 8,994(3)
	stw 10,996(3)
	stw 7,88(3)
	sth 8,992(3)
	sth 8,990(3)
	blr
.Lfe6:
	.size	 Setup_Bot,.Lfe6-Setup_Bot
	.align 2
	.globl ValidateSkin
	.type	 ValidateSkin,@function
ValidateSkin:
	stwu 1,-288(1)
	mflr 0
	stmw 28,272(1)
	stw 0,292(1)
	lis 29,gi@ha
	mr 30,3
	la 29,gi@l(29)
	lis 28,.LC75@ha
	lwz 9,144(29)
	lis 3,.LC74@ha
	la 4,.LC75@l(28)
	li 5,0
	la 3,.LC74@l(3)
	mtlr 9
	blrl
	lwz 0,144(29)
	mr 31,3
	lis 4,.LC77@ha
	lis 3,.LC76@ha
	la 4,.LC77@l(4)
	li 5,0
	mtlr 0
	la 3,.LC76@l(3)
	blrl
	mr 29,3
	la 4,.LC75@l(28)
	lwz 3,4(31)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L119
	lis 4,.LC78@ha
	lwz 3,4(31)
	la 4,.LC78@l(4)
	crxor 6,6,6
	bl sprintf
.L119:
	lwz 5,4(29)
	lis 4,.LC79@ha
	mr 7,30
	lwz 6,4(31)
	la 4,.LC79@l(4)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	lis 4,.LC80@ha
	addi 3,1,8
	la 4,.LC80@l(4)
	bl fopen
	addic 9,3,-1
	subfe 0,9,3
	mr 3,0
	lwz 0,292(1)
	mtlr 0
	lmw 28,272(1)
	la 1,288(1)
	blr
.Lfe7:
	.size	 ValidateSkin,.Lfe7-ValidateSkin
	.align 2
	.globl Spawn_New_Bot
	.type	 Spawn_New_Bot,@function
Spawn_New_Bot:
	stwu 1,-288(1)
	mflr 0
	stmw 27,268(1)
	stw 0,292(1)
	mr 29,3
	mr 30,4
	lis 28,.LC75@ha
	mr 4,29
	la 3,.LC75@l(28)
	bl strcmp
	srawi 9,3,31
	mr 4,30
	xor 0,9,3
	subf 0,0,9
	la 3,.LC75@l(28)
	srawi 0,0,31
	and 27,29,0
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L123
	li 30,0
	b .L124
.L123:
	lis 29,gi@ha
	lis 3,.LC74@ha
	la 29,gi@l(29)
	la 4,.LC75@l(28)
	lwz 9,144(29)
	li 5,0
	la 3,.LC74@l(3)
	mtlr 9
	blrl
	lwz 0,144(29)
	mr 31,3
	lis 4,.LC77@ha
	lis 3,.LC76@ha
	la 4,.LC77@l(4)
	li 5,0
	mtlr 0
	la 3,.LC76@l(3)
	blrl
	mr 29,3
	la 4,.LC75@l(28)
	lwz 3,4(31)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L126
	lis 4,.LC78@ha
	lwz 3,4(31)
	la 4,.LC78@l(4)
	crxor 6,6,6
	bl sprintf
.L126:
	lwz 5,4(29)
	lis 4,.LC79@ha
	mr 7,30
	lwz 6,4(31)
	la 4,.LC79@l(4)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	lis 4,.LC80@ha
	addi 3,1,8
	la 4,.LC80@l(4)
	bl fopen
	addic 9,3,-1
	subfe 0,9,3
	neg 0,0
	and 30,30,0
.L124:
	mr 3,27
	mr 4,30
	bl Spawn_Bot
	lwz 0,292(1)
	mtlr 0
	lmw 27,268(1)
	la 1,288(1)
	blr
.Lfe8:
	.size	 Spawn_New_Bot,.Lfe8-Spawn_New_Bot
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
