	.file	"eavy.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"item_flag_team1"
	.align 2
.LC1:
	.string	"item_flag_team2"
	.align 2
.LC2:
	.string	"info_player_deathmatch"
	.align 2
.LC3:
	.string	"info_player_start"
	.align 2
.LC4:
	.string	"Couldn't spawn flags!"
	.align 2
.LC5:
	.long 0x0
	.section	".text"
	.align 2
	.globl EAVYSpawnFlags
	.type	 EAVYSpawnFlags,@function
EAVYSpawnFlags:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 11,.LC5@ha
	lis 9,ctf@ha
	la 11,.LC5@l(11)
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L6
	lis 9,ctf_autoflagspawn@ha
	lwz 11,ctf_autoflagspawn@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L6
	lis 29,.LC0@ha
	li 4,280
	la 5,.LC0@l(29)
	li 3,0
	bl G_Find
	mr 31,3
	lis 5,.LC1@ha
	la 5,.LC1@l(5)
	li 3,0
	li 4,280
	bl G_Find
	cmpwi 0,31,0
	mr 30,3
	bc 4,2,.L9
	lis 5,.LC2@ha
	li 4,280
	la 5,.LC2@l(5)
	li 3,0
	bl G_Find
	bl EAVYFindFarthestFlagPosition
	mr. 31,3
	bc 4,2,.L15
	lis 5,.LC3@ha
	li 3,0
	la 5,.LC3@l(5)
	li 4,280
	bl G_Find
	mr. 31,3
	bc 12,2,.L9
.L15:
	la 0,.LC0@l(29)
	mr 3,31
	stw 0,280(31)
	bl ED_CallSpawn
.L9:
	cmpwi 0,30,0
	bc 4,2,.L12
	mr 3,31
	bl EAVYFindFarthestFlagPosition
	mr. 30,3
	bc 12,2,.L12
	lis 9,.LC1@ha
	mr 3,30
	la 9,.LC1@l(9)
	stw 9,280(30)
	bl ED_CallSpawn
.L12:
	subfic 0,31,0
	adde 9,0,31
	subfic 11,30,0
	adde 0,11,30
	or. 11,9,0
	bc 12,2,.L6
	lis 9,gi+28@ha
	lis 3,.LC4@ha
	lwz 0,gi+28@l(9)
	la 3,.LC4@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L6:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 EAVYSpawnFlags,.Lfe1-EAVYSpawnFlags
	.section	".rodata"
	.align 2
.LC6:
	.string	"info_player_team1"
	.align 2
.LC7:
	.string	"info_player_team2"
	.align 2
.LC8:
	.long 0x0
	.align 2
.LC9:
	.long 0x44000000
	.section	".text"
	.align 2
	.globl EAVYSpawnTeamNearFlag
	.type	 EAVYSpawnTeamNearFlag,@function
EAVYSpawnTeamNearFlag:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 11,.LC8@ha
	lis 9,ctf_autospawnnearflag@ha
	la 11,.LC8@l(11)
	mr 30,3
	lfs 13,0(11)
	li 31,0
	lwz 11,ctf_autospawnnearflag@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L25
	b .L27
.L29:
	lfs 0,4(30)
	addi 3,1,8
	lfs 13,4(31)
	lfs 12,8(30)
	lfs 11,12(30)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(31)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(31)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorLength
	lis 9,.LC9@ha
	la 9,.LC9@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L27
	lwz 3,280(30)
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L31
	lwz 0,64(31)
	lis 9,.LC6@ha
	mr 3,31
	lwz 11,68(31)
	la 9,.LC6@l(9)
	ori 0,0,256
	stw 9,280(31)
	ori 11,11,1024
	stw 0,64(31)
	stw 11,68(31)
	bl ED_CallSpawn
.L31:
	lwz 3,280(30)
	lis 4,.LC1@ha
	la 4,.LC1@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L27
	lwz 0,64(31)
	lis 9,.LC7@ha
	mr 3,31
	lwz 11,68(31)
	la 9,.LC7@l(9)
	ori 0,0,256
	stw 9,280(31)
	ori 11,11,4096
	stw 0,64(31)
	stw 11,68(31)
	bl ED_CallSpawn
.L27:
	lis 5,.LC2@ha
	mr 3,31
	la 5,.LC2@l(5)
	li 4,280
	bl G_Find
	mr. 31,3
	bc 4,2,.L29
.L25:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 EAVYSpawnTeamNearFlag,.Lfe2-EAVYSpawnTeamNearFlag
	.section	".rodata"
	.align 2
.LC10:
	.long 0x0
	.align 2
.LC11:
	.long 0x44000000
	.section	".text"
	.align 2
	.globl EAVYSpawnTeamNearFlagCheck
	.type	 EAVYSpawnTeamNearFlagCheck,@function
EAVYSpawnTeamNearFlagCheck:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 28,24(1)
	stw 0,52(1)
	lis 11,.LC10@ha
	lis 9,ctf_autospawnnearflag@ha
	la 11,.LC10@l(11)
	li 31,0
	lfs 13,0(11)
	lwz 11,ctf_autospawnnearflag@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L34
	lis 5,.LC0@ha
	li 4,280
	la 5,.LC0@l(5)
	li 3,0
	bl G_Find
	mr 30,3
	lis 29,.LC6@ha
	b .L36
.L38:
	lfs 0,4(30)
	addi 3,1,8
	lfs 13,4(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 13,8(30)
	lfs 0,8(31)
	fsubs 0,0,13
	stfs 0,12(1)
	lfs 0,12(30)
	lfs 13,12(31)
	fsubs 13,13,0
	stfs 13,16(1)
	bl VectorLength
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L36
	lwz 0,64(31)
	lis 9,.LC2@ha
	mr 3,31
	lwz 11,68(31)
	la 9,.LC2@l(9)
	rlwinm 0,0,0,24,22
	stw 9,280(31)
	rlwinm 11,11,0,20,18
	stw 0,64(31)
	stw 11,68(31)
	bl ED_CallSpawn
.L36:
	lis 5,.LC7@ha
	mr 3,31
	la 5,.LC7@l(5)
	li 4,280
	bl G_Find
	mr. 31,3
	bc 4,2,.L38
	lis 5,.LC1@ha
	li 3,0
	la 5,.LC1@l(5)
	li 4,280
	bl G_Find
	lis 9,.LC11@ha
	mr 30,3
	la 9,.LC11@l(9)
	lfs 31,0(9)
	lis 9,.LC2@ha
	la 28,.LC2@l(9)
	b .L41
.L43:
	lfs 0,4(30)
	addi 3,1,8
	lfs 13,4(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 13,8(30)
	lfs 0,8(31)
	fsubs 0,0,13
	stfs 0,12(1)
	lfs 13,12(31)
	lfs 0,12(30)
	fsubs 13,13,0
	stfs 13,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 4,0,.L41
	lwz 9,64(31)
	mr 3,31
	lwz 0,68(31)
	rlwinm 9,9,0,24,22
	stw 28,280(31)
	rlwinm 0,0,0,22,20
	stw 9,64(31)
	stw 0,68(31)
	bl ED_CallSpawn
.L41:
	mr 3,31
	li 4,280
	la 5,.LC6@l(29)
	bl G_Find
	mr. 31,3
	bc 4,2,.L43
.L34:
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 EAVYSpawnTeamNearFlagCheck,.Lfe3-EAVYSpawnTeamNearFlagCheck
	.section	".rodata"
	.align 2
.LC12:
	.long 0x0
	.section	".text"
	.align 2
	.globl EAVYFindFarthestFlagPosition
	.type	 EAVYFindFarthestFlagPosition,@function
EAVYFindFarthestFlagPosition:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	mr 30,3
	lis 5,.LC2@ha
	la 5,.LC2@l(5)
	li 3,0
	li 4,280
	li 31,0
	bl G_Find
	lis 9,.LC12@ha
	mr 29,3
	la 9,.LC12@l(9)
	lfs 31,0(9)
	b .L17
.L19:
	lfs 0,4(30)
	addi 3,1,8
	lfs 13,4(31)
	lfs 12,8(30)
	lfs 11,12(30)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(31)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(31)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 4,1,.L17
	fmr 31,1
	mr 29,31
.L17:
	lis 5,.LC2@ha
	mr 3,31
	la 5,.LC2@l(5)
	li 4,280
	bl G_Find
	mr. 31,3
	bc 4,2,.L19
	mr 3,29
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 EAVYFindFarthestFlagPosition,.Lfe4-EAVYFindFarthestFlagPosition
	.section	".rodata"
	.align 2
.LC13:
	.long 0x0
	.section	".text"
	.align 2
	.globl EAVYSetupFlagSpots
	.type	 EAVYSetupFlagSpots,@function
EAVYSetupFlagSpots:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,.LC13@ha
	lis 11,ctf@ha
	la 9,.LC13@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L22
	lis 5,.LC6@ha
	li 4,280
	la 5,.LC6@l(5)
	li 3,0
	bl G_Find
	mr 29,3
	lis 5,.LC7@ha
	la 5,.LC7@l(5)
	li 3,0
	li 4,280
	bl G_Find
	subfic 0,29,0
	adde 29,0,29
	subfic 9,3,0
	adde 3,9,3
	and. 0,29,3
	bc 12,2,.L22
	lis 5,.LC0@ha
	li 4,280
	la 5,.LC0@l(5)
	li 3,0
	bl G_Find
	bl EAVYSpawnTeamNearFlag
	lis 5,.LC1@ha
	li 4,280
	la 5,.LC1@l(5)
	li 3,0
	bl G_Find
	bl EAVYSpawnTeamNearFlag
	bl EAVYSpawnTeamNearFlagCheck
.L22:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 EAVYSetupFlagSpots,.Lfe5-EAVYSetupFlagSpots
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
