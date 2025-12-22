	.file	"acebot_spawn.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"ace/bots.tmp"
	.align 2
.LC1:
	.string	"wb"
	.section	".text"
	.align 2
	.globl ACESP_SaveBots
	.type	 ACESP_SaveBots,@function
ACESP_SaveBots:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	li 0,0
	lis 3,.LC0@ha
	lis 4,.LC1@ha
	stw 0,8(1)
	la 3,.LC0@l(3)
	la 4,.LC1@l(4)
	bl fopen
	mr. 29,3
	bc 12,2,.L6
	lis 11,maxclients@ha
	lwz 9,maxclients@l(11)
	addi 3,1,8
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 31,28(1)
	cmpwi 0,31,0
	bc 4,1,.L9
	lis 9,g_edicts@ha
	mulli 11,31,952
	lwz 10,8(1)
	lwz 0,g_edicts@l(9)
	addi 11,11,952
	add 11,11,0
.L11:
	mr 9,11
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L10
	lwz 0,892(9)
	cmpwi 0,0,0
	bc 12,2,.L10
	addi 10,10,1
.L10:
	addic. 31,31,-1
	addi 11,11,-952
	bc 12,1,.L11
	stw 10,8(1)
.L9:
	li 4,4
	li 5,1
	mr 6,29
	bl fwrite
	lis 11,maxclients@ha
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 31,28(1)
	cmpwi 0,31,0
	bc 4,1,.L15
	mulli 30,31,952
	lis 28,g_edicts@ha
.L17:
	lwz 9,g_edicts@l(28)
	add 9,9,30
	addi 9,9,952
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L16
	lwz 0,892(9)
	cmpwi 0,0,0
	bc 12,2,.L16
	lwz 3,84(9)
	li 4,512
	li 5,1
	mr 6,29
	addi 3,3,188
	bl fwrite
.L16:
	addic. 31,31,-1
	addi 30,30,-952
	bc 12,1,.L17
.L15:
	mr 3,29
	bl fclose
.L6:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 ACESP_SaveBots,.Lfe1-ACESP_SaveBots
	.section	".rodata"
	.align 2
.LC2:
	.string	"rb"
	.align 2
.LC4:
	.string	"%s joined the %s team.\n"
	.align 2
.LC5:
	.string	"%s entered the game\n"
	.align 3
.LC3:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC6:
	.long 0x0
	.section	".text"
	.align 2
	.globl ACESP_HoldSpawn
	.type	 ACESP_HoldSpawn,@function
ACESP_HoldSpawn:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	bl KillBox
	lis 29,gi@ha
	mr 3,31
	la 29,gi@l(29)
	lwz 9,72(29)
	mtlr 9
	blrl
	lis 9,ACEAI_Think@ha
	lis 10,level+4@ha
	la 9,ACEAI_Think@l(9)
	lis 11,.LC3@ha
	stw 9,436(31)
	li 3,1
	lfs 0,level+4@l(10)
	lfd 13,.LC3@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
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
	lis 9,.LC6@ha
	lis 11,ctf@ha
	la 9,.LC6@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L30
	lwz 29,84(31)
	lwz 3,3452(29)
	addi 29,29,700
	bl CTFTeamName
	mr 6,3
	lis 4,.LC4@ha
	la 4,.LC4@l(4)
	mr 5,29
	li 3,1
	crxor 6,6,6
	bl safe_bprintf
	b .L31
.L30:
	lwz 5,84(31)
	lis 4,.LC5@ha
	li 3,1
	la 4,.LC5@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
.L31:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 ACESP_HoldSpawn,.Lfe2-ACESP_HoldSpawn
	.section	".rodata"
	.align 2
.LC7:
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.align 2
.LC8:
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.align 2
.LC9:
	.string	"bot"
	.align 2
.LC10:
	.string	"players/male/tris.md2"
	.align 2
.LC11:
	.string	"skin"
	.align 2
.LC12:
	.string	"fov"
	.align 3
.LC13:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC14:
	.long 0x46fffe00
	.align 2
.LC15:
	.long 0x0
	.align 2
.LC16:
	.long 0x41400000
	.align 2
.LC17:
	.long 0x41000000
	.align 3
.LC18:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC19:
	.long 0x3f800000
	.align 2
.LC20:
	.long 0x43200000
	.align 2
.LC21:
	.long 0x47800000
	.align 2
.LC22:
	.long 0x43b40000
	.align 3
.LC23:
	.long 0x402e0000
	.long 0x0
	.align 3
.LC24:
	.long 0x40080000
	.long 0x0
	.section	".text"
	.align 2
	.globl ACESP_PutClientInServer
	.type	 ACESP_PutClientInServer,@function
ACESP_PutClientInServer:
	stwu 1,-3968(1)
	mflr 0
	stfd 31,3960(1)
	stmw 21,3916(1)
	stw 0,3972(1)
	lis 9,.LC7@ha
	lis 11,.LC8@ha
	lwz 0,.LC7@l(9)
	la 6,.LC8@l(11)
	addi 7,1,8
	la 9,.LC7@l(9)
	lwz 8,.LC8@l(11)
	mr 23,5
	lwz 29,8(9)
	addi 10,1,24
	mr 31,3
	lwz 28,4(9)
	addi 5,1,56
	mr 22,4
	stw 0,8(1)
	mr 21,5
	stw 29,8(7)
	addi 4,1,40
	stw 28,4(7)
	lwz 0,8(6)
	lwz 9,4(6)
	stw 8,24(1)
	stw 0,8(10)
	stw 9,4(10)
	bl SelectSpawnPoint
	lis 9,deathmatch@ha
	lis 11,g_edicts@ha
	lwz 30,84(31)
	lwz 10,deathmatch@l(9)
	lis 0,0x46fd
	lis 9,.LC15@ha
	ori 0,0,55623
	la 9,.LC15@l(9)
	lfs 0,20(10)
	lfs 13,0(9)
	lwz 9,g_edicts@l(11)
	fcmpu 0,0,13
	subf 9,9,31
	mullw 9,9,0
	srawi 9,9,3
	addi 25,9,-1
	bc 12,2,.L33
	addi 28,1,1704
	addi 27,30,1816
	addi 26,1,3384
	mr 4,27
	li 5,1680
	mr 3,28
	crxor 6,6,6
	bl memcpy
	addi 29,30,188
	mr 24,28
	mr 4,29
	li 5,512
	mr 3,26
	mr 28,29
	crxor 6,6,6
	bl memcpy
	mr 3,30
	bl InitClientPersistant
	mr 4,26
	mr 3,31
	bl ClientUserinfoChanged
	b .L34
.L33:
	addi 29,1,1704
	li 4,0
	mr 3,29
	li 5,1680
	crxor 6,6,6
	bl memset
	mr 24,29
	addi 27,30,1816
	addi 28,30,188
.L34:
	addi 29,1,72
	mr 4,28
	li 5,1628
	mr 3,29
	crxor 6,6,6
	bl memcpy
	lis 9,.LC15@ha
	li 4,0
	la 9,.LC15@l(9)
	li 5,3864
	lfs 31,0(9)
	mr 3,30
	crxor 6,6,6
	bl memset
	mr 4,29
	li 5,1628
	mr 3,28
	crxor 6,6,6
	bl memcpy
	mr 4,24
	li 5,1680
	mr 3,27
	crxor 6,6,6
	bl memcpy
	mr 3,31
	bl FetchClientEntData
	li 29,0
	lis 9,game+1028@ha
	mulli 8,25,3864
	lwz 7,264(31)
	stw 29,552(31)
	lis 11,.LC9@ha
	li 5,2
	lwz 0,game+1028@l(9)
	la 11,.LC9@l(11)
	li 10,24
	li 9,4
	li 6,200
	stw 10,508(31)
	stw 9,260(31)
	add 0,0,8
	lis 4,level+4@ha
	lis 9,.LC16@ha
	stw 0,84(31)
	lis 10,0x201
	stw 11,280(31)
	la 9,.LC16@l(9)
	lis 8,player_pain@ha
	stw 6,400(31)
	lis 11,player_die@ha
	la 8,player_pain@l(8)
	stw 5,248(31)
	lis 6,ctf@ha
	la 11,player_die@l(11)
	stw 5,512(31)
	ori 10,10,3
	rlwinm 7,7,0,21,19
	stw 29,492(31)
	lfs 0,level+4@l(4)
	lfs 13,0(9)
	lwz 0,184(31)
	lis 9,.LC10@ha
	lwz 5,ctf@l(6)
	la 9,.LC10@l(9)
	fadds 0,0,13
	rlwinm 0,0,0,31,29
	stw 10,252(31)
	stw 9,268(31)
	stw 8,452(31)
	stfs 0,404(31)
	stw 11,456(31)
	stw 7,264(31)
	stw 0,184(31)
	stw 29,612(31)
	stw 29,608(31)
	stw 29,896(31)
	lfs 0,20(5)
	fcmpu 0,0,31
	bc 12,2,.L35
	lis 4,.LC11@ha
	stw 23,3452(30)
	mr 3,28
	la 4,.LC11@l(4)
	stw 29,3456(30)
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl CTFAssignSkin
.L35:
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
	stfs 31,384(31)
	stfs 31,380(31)
	stfs 31,376(31)
	crxor 6,6,6
	bl memset
	lis 9,.LC17@ha
	lfs 0,40(1)
	lis 8,deathmatch@ha
	la 9,.LC17@l(9)
	lbz 0,16(30)
	lfs 10,0(9)
	andi. 0,0,191
	mr 11,9
	mr 10,9
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,3904(1)
	lwz 9,3908(1)
	sth 9,4(30)
	lfs 0,44(1)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,3904(1)
	lwz 11,3908(1)
	sth 11,6(30)
	lfs 0,48(1)
	stb 0,16(30)
	lwz 9,deathmatch@l(8)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,3904(1)
	lwz 10,3908(1)
	sth 10,8(30)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L36
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,3904(1)
	lwz 11,3908(1)
	andi. 0,11,32768
	bc 4,2,.L50
.L36:
	lis 4,.LC12@ha
	mr 3,28
	la 4,.LC12@l(4)
	bl Info_ValueForKey
	bl atoi
	xoris 3,3,0x8000
	stw 3,3908(1)
	lis 0,0x4330
	lis 10,.LC18@ha
	la 10,.LC18@l(10)
	stw 0,3904(1)
	lis 11,.LC19@ha
	lfd 13,0(10)
	la 11,.LC19@l(11)
	lfd 0,3904(1)
	lfs 12,0(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	stfs 0,112(30)
	bc 4,0,.L38
.L50:
	lis 0,0x42b4
	stw 0,112(30)
	b .L37
.L38:
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L37
	stfs 13,112(30)
.L37:
	lis 9,gi+32@ha
	lwz 11,1788(30)
	cmpwi 0,22,0
	lwz 0,gi+32@l(9)
	lwz 3,32(11)
	mtlr 0
	mfcr 29
	blrl
	lis 9,.LC21@ha
	lis 11,g_edicts@ha
	stw 3,88(30)
	la 9,.LC21@l(9)
	lis 0,0x46fd
	lfs 13,48(1)
	lfs 9,0(9)
	ori 0,0,55623
	lis 10,.LC22@ha
	lwz 9,g_edicts@l(11)
	la 10,.LC22@l(10)
	mr 5,21
	lis 11,.LC19@ha
	lfs 11,40(1)
	addi 6,30,3480
	la 11,.LC19@l(11)
	subf 9,9,31
	lfs 12,44(1)
	lfs 0,0(11)
	mullw 9,9,0
	addi 7,30,20
	li 8,0
	li 0,3
	lfs 10,0(10)
	li 11,0
	mtctr 0
	srawi 9,9,3
	li 10,255
	stw 11,56(31)
	fadds 13,13,0
	addi 9,9,-1
	stw 10,44(31)
	stfs 11,4(31)
	stfs 12,8(31)
	stfs 13,12(31)
	stw 9,60(31)
	stw 11,64(31)
	stw 10,40(31)
.L49:
	lfsx 0,8,5
	lfsx 12,8,6
	addi 8,8,4
	fsubs 0,0,12
	fmuls 0,0,9
	fdivs 0,0,10
	fctiwz 13,0
	stfd 13,3904(1)
	lwz 9,3908(1)
	sth 9,0(7)
	addi 7,7,2
	bdnz .L49
	lfs 0,60(1)
	li 0,0
	mr 3,31
	stw 0,24(31)
	stw 0,16(31)
	stfs 0,20(31)
	stw 0,28(30)
	lfs 13,20(31)
	lwz 0,1788(30)
	stfs 13,32(30)
	lfs 0,24(31)
	stfs 0,36(30)
	lfs 13,16(31)
	stfs 13,3672(30)
	lfs 0,20(31)
	stfs 0,3676(30)
	lfs 13,24(31)
	stw 0,3568(30)
	stfs 13,3680(30)
	bl ChangeWeapon
	li 9,0
	li 0,1
	stw 9,416(31)
	mr 3,31
	li 4,128
	stw 9,540(31)
	li 5,99
	stw 0,948(31)
	bl ACEND_FindClosestReachableNode
	lis 9,level@ha
	stw 3,932(31)
	mtcrf 128,29
	la 30,level@l(9)
	stw 3,924(31)
	stw 3,928(31)
	lis 9,.LC23@ha
	lfs 13,4(30)
	la 9,.LC23@l(9)
	lfd 12,0(9)
	stfs 13,912(31)
	lfs 0,4(30)
	fadd 0,0,12
	frsp 0,0
	stfs 0,920(31)
	bc 4,2,.L46
	lis 9,ACESP_HoldSpawn@ha
	lis 11,.LC13@ha
	la 9,ACESP_HoldSpawn@l(9)
	lfd 13,.LC13@l(11)
	stw 9,436(31)
	lfs 0,4(30)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,4(30)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,3908(1)
	lis 10,.LC18@ha
	lis 11,.LC14@ha
	la 10,.LC18@l(10)
	stw 0,3904(1)
	lfd 13,0(10)
	lfd 0,3904(1)
	lis 10,.LC24@ha
	lfs 11,.LC14@l(11)
	la 10,.LC24@l(10)
	lfd 10,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fmadd 13,13,10,12
	frsp 13,13
	stfs 13,428(31)
	b .L47
.L46:
	mr 3,31
	bl KillBox
	lis 29,gi@ha
	mr 3,31
	la 29,gi@l(29)
	lwz 9,72(29)
	mtlr 9
	blrl
	lis 9,ACEAI_Think@ha
	lis 11,.LC13@ha
	la 9,ACEAI_Think@l(9)
	lfd 13,.LC13@l(11)
	li 3,1
	stw 9,436(31)
	lfs 0,4(30)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
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
.L47:
	lwz 0,3972(1)
	mtlr 0
	lmw 21,3916(1)
	lfd 31,3960(1)
	la 1,3968(1)
	blr
.Lfe3:
	.size	 ACESP_PutClientInServer,.Lfe3-ACESP_PutClientInServer
	.section	".rodata"
	.align 2
.LC25:
	.string	"ACEBot_%d"
	.align 2
.LC28:
	.string	"female/athena"
	.align 2
.LC30:
	.string	"female/brianna"
	.align 2
.LC32:
	.string	"female/cobalt"
	.align 2
.LC34:
	.string	"female/ensign"
	.align 2
.LC35:
	.string	"female/jezebel"
	.align 2
.LC37:
	.string	"female/jungle"
	.align 2
.LC39:
	.string	"female/lotus"
	.align 2
.LC41:
	.string	"female/stiletto"
	.align 2
.LC43:
	.string	"female/venus"
	.align 2
.LC44:
	.string	"female/voodoo"
	.align 2
.LC46:
	.string	"male/cipher"
	.align 2
.LC48:
	.string	"male/flak"
	.align 2
.LC50:
	.string	"male/grunt"
	.align 2
.LC52:
	.string	"male/howitzer"
	.align 2
.LC53:
	.string	"male/major"
	.align 2
.LC55:
	.string	"male/nightops"
	.align 2
.LC57:
	.string	"male/pointman"
	.align 2
.LC59:
	.string	"male/psycho"
	.align 2
.LC61:
	.string	"male/razor"
	.align 2
.LC62:
	.string	"male/sniper"
	.align 2
.LC63:
	.string	"name"
	.align 2
.LC64:
	.string	"hand"
	.align 2
.LC65:
	.string	"2"
	.align 2
.LC26:
	.long 0x46fffe00
	.align 3
.LC27:
	.long 0x3fa99999
	.long 0x9999999a
	.align 3
.LC29:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC31:
	.long 0x3fc33333
	.long 0x33333333
	.align 3
.LC33:
	.long 0x3fc99999
	.long 0x9999999a
	.align 3
.LC36:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC38:
	.long 0x3fd66666
	.long 0x66666666
	.align 3
.LC40:
	.long 0x3fd99999
	.long 0x9999999a
	.align 3
.LC42:
	.long 0x3fdccccc
	.long 0xcccccccd
	.align 3
.LC45:
	.long 0x3fe19999
	.long 0x9999999a
	.align 3
.LC47:
	.long 0x3fe33333
	.long 0x33333333
	.align 3
.LC49:
	.long 0x3fe4cccc
	.long 0xcccccccd
	.align 3
.LC51:
	.long 0x3fe66666
	.long 0x66666666
	.align 3
.LC54:
	.long 0x3fe99999
	.long 0x9999999a
	.align 3
.LC56:
	.long 0x3feb3333
	.long 0x33333333
	.align 3
.LC58:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 3
.LC60:
	.long 0x3fee6666
	.long 0x66666666
	.align 3
.LC66:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC67:
	.long 0x3fd00000
	.long 0x0
	.align 3
.LC68:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC69:
	.long 0x3fe80000
	.long 0x0
	.section	".text"
	.align 2
	.globl ACESP_SetName
	.type	 ACESP_SetName,@function
ACESP_SetName:
	stwu 1,-1568(1)
	mflr 0
	stmw 28,1552(1)
	stw 0,1572(1)
	mr 29,4
	mr 30,3
	mr 31,5
	mr 3,29
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L69
	addi 29,1,1032
	lis 4,.LC25@ha
	lwz 5,532(30)
	la 4,.LC25@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	mr 28,29
	b .L70
.L69:
	addi 0,1,1032
	mr 4,29
	mr 3,0
	mr 28,0
	bl strcpy
.L70:
	mr 3,31
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L71
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,1548(1)
	lis 11,.LC66@ha
	lis 10,.LC26@ha
	la 11,.LC66@l(11)
	stw 0,1544(1)
	lfd 12,0(11)
	lfd 0,1544(1)
	lis 11,.LC27@ha
	lfs 11,.LC26@l(10)
	lfd 13,.LC27@l(11)
	fsub 0,0,12
	frsp 0,0
	fdivs 11,0,11
	fmr 12,11
	fcmpu 0,12,13
	bc 4,0,.L72
	addi 29,1,520
	lis 4,.LC28@ha
	la 4,.LC28@l(4)
	b .L111
.L72:
	lis 9,.LC29@ha
	lfd 0,.LC29@l(9)
	fcmpu 0,12,0
	bc 4,0,.L74
	addi 29,1,520
	lis 4,.LC30@ha
	la 4,.LC30@l(4)
	b .L111
.L74:
	lis 9,.LC31@ha
	lfd 0,.LC31@l(9)
	fcmpu 0,12,0
	bc 4,0,.L76
	addi 29,1,520
	lis 4,.LC32@ha
	la 4,.LC32@l(4)
	b .L111
.L76:
	lis 9,.LC33@ha
	lfd 0,.LC33@l(9)
	fcmpu 0,12,0
	bc 4,0,.L78
	addi 29,1,520
	lis 4,.LC34@ha
	la 4,.LC34@l(4)
	b .L111
.L78:
	lis 9,.LC67@ha
	la 9,.LC67@l(9)
	lfd 0,0(9)
	fcmpu 0,12,0
	bc 4,0,.L80
	addi 29,1,520
	lis 4,.LC35@ha
	la 4,.LC35@l(4)
	b .L111
.L80:
	lis 9,.LC36@ha
	lfd 0,.LC36@l(9)
	fcmpu 0,12,0
	bc 4,0,.L82
	addi 29,1,520
	lis 4,.LC37@ha
	la 4,.LC37@l(4)
	b .L111
.L82:
	lis 9,.LC38@ha
	lfd 0,.LC38@l(9)
	fcmpu 0,12,0
	bc 4,0,.L84
	addi 29,1,520
	lis 4,.LC39@ha
	la 4,.LC39@l(4)
	b .L111
.L84:
	lis 9,.LC40@ha
	lfd 0,.LC40@l(9)
	fcmpu 0,12,0
	bc 4,0,.L86
	addi 29,1,520
	lis 4,.LC41@ha
	la 4,.LC41@l(4)
	b .L111
.L86:
	lis 9,.LC42@ha
	lfd 0,.LC42@l(9)
	fcmpu 0,12,0
	bc 4,0,.L88
	addi 29,1,520
	lis 4,.LC43@ha
	la 4,.LC43@l(4)
	b .L111
.L88:
	lis 9,.LC68@ha
	fmr 13,11
	la 9,.LC68@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L90
	addi 29,1,520
	lis 4,.LC44@ha
	la 4,.LC44@l(4)
	b .L111
.L90:
	lis 9,.LC45@ha
	lfd 0,.LC45@l(9)
	fcmpu 0,13,0
	bc 4,0,.L92
	addi 29,1,520
	lis 4,.LC46@ha
	la 4,.LC46@l(4)
	b .L111
.L92:
	lis 9,.LC47@ha
	lfd 0,.LC47@l(9)
	fcmpu 0,13,0
	bc 4,0,.L94
	addi 29,1,520
	lis 4,.LC48@ha
	la 4,.LC48@l(4)
	b .L111
.L94:
	lis 9,.LC49@ha
	lfd 0,.LC49@l(9)
	fcmpu 0,13,0
	bc 4,0,.L96
	addi 29,1,520
	lis 4,.LC50@ha
	la 4,.LC50@l(4)
	b .L111
.L96:
	lis 9,.LC51@ha
	lfd 0,.LC51@l(9)
	fcmpu 0,13,0
	bc 4,0,.L98
	addi 29,1,520
	lis 4,.LC52@ha
	la 4,.LC52@l(4)
	b .L111
.L98:
	lis 9,.LC69@ha
	la 9,.LC69@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L100
	addi 29,1,520
	lis 4,.LC53@ha
	la 4,.LC53@l(4)
	b .L111
.L100:
	lis 9,.LC54@ha
	lfd 0,.LC54@l(9)
	fcmpu 0,13,0
	bc 4,0,.L102
	addi 29,1,520
	lis 4,.LC55@ha
	la 4,.LC55@l(4)
	b .L111
.L102:
	lis 9,.LC56@ha
	lfd 0,.LC56@l(9)
	fcmpu 0,13,0
	bc 4,0,.L104
	addi 29,1,520
	lis 4,.LC57@ha
	la 4,.LC57@l(4)
	b .L111
.L104:
	lis 9,.LC58@ha
	lfd 0,.LC58@l(9)
	fcmpu 0,13,0
	bc 4,0,.L106
	addi 29,1,520
	lis 4,.LC59@ha
	la 4,.LC59@l(4)
	b .L111
.L106:
	lis 9,.LC60@ha
	lfd 0,.LC60@l(9)
	fcmpu 0,13,0
	bc 4,0,.L108
	addi 29,1,520
	lis 4,.LC61@ha
	la 4,.LC61@l(4)
	b .L111
.L108:
	addi 29,1,520
	lis 4,.LC62@ha
	la 4,.LC62@l(4)
.L111:
	mr 3,29
	crxor 6,6,6
	bl sprintf
	mr 31,29
	b .L110
.L71:
	addi 0,1,520
	mr 4,31
	mr 3,0
	mr 31,0
	bl strcpy
.L110:
	addi 29,1,8
	li 4,0
	li 5,512
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 4,.LC63@ha
	mr 5,28
	la 4,.LC63@l(4)
	mr 3,29
	bl Info_SetValueForKey
	lis 4,.LC11@ha
	mr 5,31
	la 4,.LC11@l(4)
	mr 3,29
	bl Info_SetValueForKey
	lis 4,.LC64@ha
	lis 5,.LC65@ha
	la 4,.LC64@l(4)
	la 5,.LC65@l(5)
	mr 3,29
	bl Info_SetValueForKey
	mr 4,29
	mr 3,30
	bl ClientConnect
	bl ACESP_SaveBots
	lwz 0,1572(1)
	mtlr 0
	lmw 28,1552(1)
	la 1,1568(1)
	blr
.Lfe4:
	.size	 ACESP_SetName,.Lfe4-ACESP_SetName
	.section	".rodata"
	.align 2
.LC70:
	.string	"Server is full, increase Maxclients.\n"
	.align 2
.LC71:
	.string	"red"
	.align 2
.LC72:
	.long 0x0
	.section	".text"
	.align 2
	.globl ACESP_SpawnBot
	.type	 ACESP_SpawnBot,@function
ACESP_SpawnBot:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 9,maxclients@ha
	lwz 11,maxclients@l(9)
	mr 30,3
	mr 12,4
	mr 4,6
	li 3,0
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 8,20(1)
	cmpwi 0,8,0
	bc 4,1,.L118
	mulli 11,8,952
	lis 9,g_edicts@ha
	lwz 10,g_edicts@l(9)
	addi 0,11,952
	addi 11,11,1484
	add 7,0,10
	add 11,11,10
.L115:
	lwz 9,0(11)
	addic. 8,8,-1
	mr 31,7
	addi 11,11,-952
	addi 7,31,-952
	cmpw 7,9,3
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,9,0
	and 0,3,0
	or 3,0,9
	bc 12,1,.L115
.L118:
	lis 11,maxclients@ha
	lwz 9,maxclients@l(11)
	addi 3,3,1
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 8,20(1)
	cmpwi 0,8,0
	bc 4,1,.L124
	lis 9,g_edicts@ha
	mulli 10,8,952
	lwz 7,g_edicts@l(9)
	add 11,7,10
	addi 31,11,952
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L124
	addi 0,10,952
	addi 9,10,1040
	add 11,0,7
	add 9,9,7
.L122:
	addic. 8,8,-1
	addi 11,11,-952
	bc 4,1,.L124
	lwzu 0,-952(9)
	mr 31,11
	cmpwi 0,0,0
	bc 4,2,.L122
.L124:
	lwz 0,88(31)
	stw 3,532(31)
	addic 0,0,-1
	subfe 0,0,0
	and. 31,31,0
	bc 4,2,.L127
	lis 4,.LC70@ha
	li 3,1
	la 4,.LC70@l(4)
	crxor 6,6,6
	bl safe_bprintf
	b .L112
.L127:
	cmpwi 0,4,0
	li 9,1
	lis 0,0x42c8
	stw 9,892(31)
	stw 0,420(31)
	stw 9,88(31)
	bc 4,2,.L128
	mr 4,12
	mr 3,31
	mr 6,30
	bl ACESP_SetName
	b .L129
.L128:
	mr 3,31
	bl ClientConnect
.L129:
	mr 3,31
	bl G_InitEdict
	lwz 3,84(31)
	bl InitClientResp
	lis 9,.LC72@ha
	lis 11,ctf@ha
	la 9,.LC72@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L130
	cmpwi 0,30,0
	bc 12,2,.L131
	lis 4,.LC71@ha
	mr 3,30
	la 4,.LC71@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L131
	mr 3,31
	li 4,0
	li 5,1
	bl ACESP_PutClientInServer
	b .L133
.L131:
	mr 3,31
	li 4,0
	li 5,2
	bl ACESP_PutClientInServer
	b .L133
.L130:
	mr 3,31
	li 4,0
	li 5,0
	bl ACESP_PutClientInServer
.L133:
	mr 3,31
	bl ClientEndServerFrame
	mr 3,31
	bl ACEIT_PlayerAdded
	mr 3,31
	bl ACEAI_PickLongRangeGoal
.L112:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 ACESP_SpawnBot,.Lfe5-ACESP_SpawnBot
	.section	".rodata"
	.align 2
.LC73:
	.string	"all"
	.align 2
.LC74:
	.string	"%s removed\n"
	.align 2
.LC75:
	.string	"%s not found\n"
	.align 2
.LC76:
	.long 0x0
	.align 3
.LC77:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ACESP_RemoveBot
	.type	 ACESP_RemoveBot,@function
ACESP_RemoveBot:
	stwu 1,-96(1)
	mflr 0
	stfd 31,88(1)
	stmw 19,36(1)
	stw 0,100(1)
	lis 11,.LC76@ha
	lis 9,maxclients@ha
	la 11,.LC76@l(11)
	mr 30,3
	lfs 13,0(11)
	li 26,0
	li 28,0
	lwz 11,maxclients@l(9)
	lis 19,maxclients@ha
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L136
	lis 9,.LC77@ha
	lis 20,g_edicts@ha
	la 9,.LC77@l(9)
	lis 21,.LC73@ha
	lfd 31,0(9)
	li 27,0
	lis 22,vec3_origin@ha
	li 23,2
	lis 24,0x4330
	li 29,0
	lis 25,.LC74@ha
.L138:
	lwz 9,g_edicts@l(20)
	add 9,9,29
	addi 31,9,952
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L137
	lwz 0,892(31)
	cmpwi 0,0,0
	bc 12,2,.L137
	lwz 3,84(31)
	mr 4,30
	addi 3,3,700
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L141
	mr 3,30
	la 4,.LC73@l(21)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L137
.L141:
	lis 6,0x1
	mr 5,31
	stw 27,480(31)
	mr 4,31
	mr 3,31
	ori 6,6,34464
	la 7,vec3_origin@l(22)
	bl player_die
	li 26,1
	mr 3,31
	stw 23,492(31)
	stw 27,88(31)
	bl ACEIT_PlayerRemoved
	lwz 5,84(31)
	li 3,1
	la 4,.LC74@l(25)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
.L137:
	addi 28,28,1
	lwz 11,maxclients@l(19)
	xoris 0,28,0x8000
	addi 29,29,952
	stw 0,28(1)
	stw 24,24(1)
	lfd 0,24(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L138
.L136:
	cmpwi 0,26,0
	bc 4,2,.L143
	lis 4,.LC75@ha
	mr 5,30
	la 4,.LC75@l(4)
	li 3,1
	crxor 6,6,6
	bl safe_bprintf
.L143:
	bl ACESP_SaveBots
	lwz 0,100(1)
	mtlr 0
	lmw 19,36(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe6:
	.size	 ACESP_RemoveBot,.Lfe6-ACESP_RemoveBot
	.align 2
	.globl ACESP_LoadBots
	.type	 ACESP_LoadBots,@function
ACESP_LoadBots:
	stwu 1,-544(1)
	mflr 0
	stmw 30,536(1)
	stw 0,548(1)
	lis 3,.LC0@ha
	lis 4,.LC2@ha
	la 3,.LC0@l(3)
	la 4,.LC2@l(4)
	bl fopen
	mr. 30,3
	bc 12,2,.L21
	addi 3,1,520
	li 4,4
	li 5,1
	mr 6,30
	bl fread
	li 31,0
	b .L144
.L26:
	li 4,512
	li 5,1
	mr 6,30
	addi 3,1,8
	bl fread
	addi 31,31,1
	li 3,0
	li 4,0
	li 5,0
	addi 6,1,8
	bl ACESP_SpawnBot
.L144:
	lwz 0,520(1)
	cmpw 0,31,0
	bc 12,0,.L26
	mr 3,30
	bl fclose
.L21:
	lwz 0,548(1)
	mtlr 0
	lmw 30,536(1)
	la 1,544(1)
	blr
.Lfe7:
	.size	 ACESP_LoadBots,.Lfe7-ACESP_LoadBots
	.section	".rodata"
	.align 2
.LC78:
	.long 0x0
	.section	".text"
	.align 2
	.globl ACESP_Respawn
	.type	 ACESP_Respawn,@function
ACESP_Respawn:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl CopyToBodyQue
	lis 9,.LC78@ha
	lis 11,ctf@ha
	la 9,.LC78@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L52
	lwz 9,84(31)
	mr 3,31
	li 4,1
	lwz 5,3452(9)
	bl ACESP_PutClientInServer
	b .L53
.L52:
	mr 3,31
	li 4,1
	li 5,0
	bl ACESP_PutClientInServer
.L53:
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
	stfs 0,3828(11)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 ACESP_Respawn,.Lfe8-ACESP_Respawn
	.align 2
	.globl ACESP_FindFreeClient
	.type	 ACESP_FindFreeClient,@function
ACESP_FindFreeClient:
	stwu 1,-16(1)
	lis 11,maxclients@ha
	lwz 9,maxclients@l(11)
	li 5,0
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 8,12(1)
	cmpwi 0,8,0
	bc 4,1,.L56
	mulli 11,8,952
	lis 9,g_edicts@ha
	lwz 10,g_edicts@l(9)
	addi 0,11,952
	addi 11,11,1484
	add 7,0,10
	add 11,11,10
.L58:
	lwz 9,0(11)
	addic. 8,8,-1
	mr 6,7
	addi 11,11,-952
	addi 7,6,-952
	cmpw 7,9,5
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,9,0
	and 0,5,0
	or 5,0,9
	bc 12,1,.L58
.L56:
	lis 11,maxclients@ha
	lwz 9,maxclients@l(11)
	addi 5,5,1
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 8,12(1)
	cmpwi 0,8,0
	bc 4,1,.L62
	lis 9,g_edicts@ha
	mulli 10,8,952
	lwz 7,g_edicts@l(9)
	add 11,7,10
	addi 6,11,952
	lwz 0,88(6)
	cmpwi 0,0,0
	bc 12,2,.L62
	addi 0,10,952
	addi 9,10,1040
	add 11,0,7
	add 9,9,7
.L63:
	addic. 8,8,-1
	addi 11,11,-952
	bc 4,1,.L62
	lwzu 0,-952(9)
	mr 6,11
	cmpwi 0,0,0
	bc 4,2,.L63
.L62:
	lwz 3,88(6)
	stw 5,532(6)
	addic 3,3,-1
	subfe 3,3,3
	and 3,6,3
	la 1,16(1)
	blr
.Lfe9:
	.size	 ACESP_FindFreeClient,.Lfe9-ACESP_FindFreeClient
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
