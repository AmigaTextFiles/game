	.file	"z_wedit.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"worldspawn"
	.align 2
.LC1:
	.string	"none"
	.align 2
.LC2:
	.string	""
	.align 2
.LC3:
	.string	"(spawnflags %i)\n"
	.align 2
.LC4:
	.string	"*NOT DEATHMATCH*"
	.align 2
.LC5:
	.string	"DEATHMATCH ONLY"
	.align 2
.LC6:
	.string	"*NOT EASY*"
	.align 2
.LC7:
	.string	"*NOT MED*"
	.align 2
.LC8:
	.string	"*NOT HARD*"
	.align 2
.LC9:
	.string	"foundEnt = %s\n origin = %s\n sFlags = %s\n item = %s\ntarget = %s\ntargetname = %s\n"
	.align 2
.LC10:
	.string	"foundEnt = %s\n origin = %s\nsFlags = %s\n model = %s\n target = %s\ntargetname = %s\nmessage = %s\n"
	.align 2
.LC11:
	.string	"X-hair pos = %s\n normal = %s\n self angles =%s\n"
	.align 3
.LC12:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC13:
	.long 0x46000000
	.section	".text"
	.align 2
	.globl CheckCrossHair
	.type	 CheckCrossHair,@function
CheckCrossHair:
	stwu 1,-624(1)
	mflr 0
	stmw 23,588(1)
	stw 0,628(1)
	mr 30,3
	lwz 0,508(30)
	lis 10,0x4330
	lis 5,.LC12@ha
	la 5,.LC12@l(5)
	lwz 3,84(30)
	li 11,0
	xoris 0,0,0x8000
	lfd 13,0(5)
	addi 28,1,32
	stw 0,580(1)
	addi 29,1,64
	addi 27,1,80
	stw 10,576(1)
	addi 4,1,16
	addi 3,3,4732
	lfd 0,576(1)
	mr 5,28
	li 6,0
	stw 11,52(1)
	li 31,0
	stw 11,48(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,56(1)
	bl AngleVectors
	lwz 3,84(30)
	addi 5,1,48
	addi 6,1,16
	mr 7,28
	mr 8,29
	addi 4,30,4
	bl P_ProjectSource
	lis 5,.LC13@ha
	addi 4,1,16
	la 5,.LC13@l(5)
	mr 3,29
	lfs 1,0(5)
	mr 5,27
	bl VectorMA
	lis 9,gi+48@ha
	addi 3,1,112
	lwz 0,gi+48@l(9)
	mr 4,29
	mr 7,27
	li 5,0
	li 6,0
	mr 8,30
	li 9,-1
	mtlr 0
	blrl
	lwz 3,164(1)
	cmpwi 0,3,0
	bc 12,2,.L7
	lwz 3,280(3)
	cmpwi 0,3,0
	bc 12,2,.L7
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	bl Q_stricmp
	srawi 5,3,31
	lwz 9,164(1)
	xor 0,5,3
	subf 0,0,5
	srawi 0,0,31
	and 31,9,0
.L7:
	cmpwi 0,31,0
	bc 12,2,.L9
	lis 9,.LC1@ha
	addi 3,1,176
	lwz 6,284(31)
	la 29,.LC1@l(9)
	lis 5,.LC3@ha
	lis 9,.LC2@ha
	la 5,.LC3@l(5)
	mr 27,3
	la 23,.LC2@l(9)
	li 4,384
	mr 26,29
	crxor 6,6,6
	bl Com_sprintf
	mr 28,29
	lwz 0,284(31)
	andi. 5,0,2048
	bc 12,2,.L10
	lis 4,.LC4@ha
	mr 3,27
	la 4,.LC4@l(4)
	bl strcat
.L10:
	lwz 9,284(31)
	rlwinm 0,9,0,21,23
	cmpwi 0,0,1792
	bc 4,2,.L11
	lis 4,.LC5@ha
	mr 3,27
	la 4,.LC5@l(4)
	bl strcat
	b .L12
.L11:
	andi. 0,9,256
	bc 12,2,.L13
	lis 4,.LC6@ha
	mr 3,27
	la 4,.LC6@l(4)
	bl strcat
.L13:
	lwz 0,284(31)
	andi. 5,0,512
	bc 12,2,.L14
	lis 4,.LC7@ha
	mr 3,27
	la 4,.LC7@l(4)
	bl strcat
.L14:
	lwz 0,284(31)
	andi. 5,0,1024
	bc 12,2,.L12
	lis 4,.LC8@ha
	mr 3,27
	la 4,.LC8@l(4)
	bl strcat
.L12:
	lfs 0,4(31)
	stfs 0,96(1)
	lfs 13,8(31)
	stfs 13,100(1)
	lfs 0,12(31)
	stfs 0,104(1)
	lwz 10,296(31)
	lwz 8,300(31)
	lwz 7,268(31)
	addic 11,10,-1
	subfe 11,11,11
	lwz 6,184(31)
	addic 0,8,-1
	subfe 0,0,0
	andc 10,10,11
	addic 9,7,-1
	subfe 9,9,9
	andc 8,8,0
	andc 7,7,9
	andi. 5,6,4
	and 0,29,0
	and 11,26,11
	and 9,23,9
	or 25,11,10
	or 24,0,8
	or 29,9,7
	bc 12,2,.L19
	lwz 11,648(31)
	lis 9,.LC1@ha
	la 26,.LC1@l(9)
	cmpwi 0,11,0
	bc 12,2,.L20
	lwz 26,0(11)
.L20:
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,1,96
	la 29,gi@l(29)
	bl vtos
	lwz 0,12(29)
	mr 6,3
	lis 4,.LC9@ha
	mr 3,30
	la 4,.LC9@l(4)
	mr 5,28
	mr 7,27
	mtlr 0
	mr 8,26
	mr 9,25
	mr 10,24
	crxor 6,6,6
	blrl
	b .L6
.L19:
	lwz 9,276(31)
	addi 3,1,96
	addic 0,9,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,28,0
	or 28,0,9
	bl vtos
	lis 9,gi+12@ha
	mr 6,3
	lwz 5,280(31)
	lwz 0,gi+12@l(9)
	lis 4,.LC10@ha
	mr 3,30
	la 4,.LC10@l(4)
	mr 7,27
	stw 28,8(1)
	mr 8,29
	mr 9,25
	mtlr 0
	mr 10,24
	crxor 6,6,6
	blrl
	b .L6
.L9:
	addi 28,1,96
	addi 3,1,136
	mr 4,28
	bl vectoangles
	lis 29,gi@ha
	addi 3,1,124
	la 29,gi@l(29)
	bl vtos
	mr 27,3
	mr 3,28
	bl vtos
	lwz 9,84(30)
	mr 28,3
	addi 3,9,4732
	bl vtos
	lwz 0,12(29)
	mr 7,3
	lis 4,.LC11@ha
	mr 3,30
	la 4,.LC11@l(4)
	mr 5,27
	mr 6,28
	mtlr 0
	crxor 6,6,6
	blrl
.L6:
	lwz 0,628(1)
	mtlr 0
	lmw 23,588(1)
	la 1,624(1)
	blr
.Lfe1:
	.size	 CheckCrossHair,.Lfe1-CheckCrossHair
	.section	".rodata"
	.align 2
.LC14:
	.long 0x46fffe00
	.align 2
.LC15:
	.long 0x41000000
	.align 3
.LC16:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC17:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl Think_WEdit
	.type	 Think_WEdit,@function
Think_WEdit:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 31,3
	li 27,-1
	lwz 9,84(31)
	li 29,-1
	lwz 10,4664(9)
	lwz 11,4620(9)
	lwz 0,4612(9)
	cmpwi 0,10,0
	or 0,11,0
	rlwinm 28,0,0,30,30
	rlwinm 30,0,0,31,31
	bc 12,2,.L25
	cmpwi 0,10,1
	bc 12,2,.L36
	b .L24
.L25:
	lwz 0,4900(9)
	cmpwi 0,0,-1
	bc 12,1,.L63
	lwz 0,4904(9)
	cmpwi 0,0,-1
	bc 4,1,.L28
	li 0,9
	mr 3,31
	stw 0,92(9)
	bl ChangeLeftWeapon
	b .L23
.L28:
	cmpwi 0,30,0
	bc 12,2,.L30
	rlwinm 0,11,0,0,30
	li 27,7
	stw 0,4620(9)
	li 11,5
	mr 3,31
	lwz 9,84(31)
	stw 11,92(9)
	bl CheckCrossHair
	b .L24
.L30:
	cmpwi 0,28,0
	bc 12,2,.L32
	rlwinm 0,11,0,31,29
	li 27,8
	stw 0,4620(9)
	li 11,5
	mr 3,31
	lwz 9,84(31)
	stw 11,92(9)
	bl Cmd_Noclip_f
	b .L24
.L32:
	lis 9,level+4@ha
	lfs 13,992(31)
	lis 10,.LC15@ha
	lfs 0,level+4@l(9)
	la 10,.LC15@l(10)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L34
	li 29,10
	li 27,1
	b .L24
.L34:
	li 29,9
	b .L24
.L36:
	lwz 0,4900(9)
	cmpwi 0,0,-1
	bc 4,1,.L37
.L63:
	li 29,53
	li 27,4
	b .L24
.L37:
	lwz 0,4904(9)
	cmpwi 0,0,-1
	bc 4,1,.L39
	mr 3,31
	bl ChangeLeftWeapon
	b .L23
.L39:
	neg 0,28
	srwi 0,0,31
	or. 10,30,0
	bc 12,2,.L24
	li 0,0
	li 11,9
	stw 0,4664(9)
	mr 3,31
	lwz 9,84(31)
	stw 11,92(9)
	bl Think_WEdit
	b .L23
.L24:
	lwz 9,84(31)
	lwz 0,92(9)
	mr 10,9
	cmpwi 0,0,9
	bc 12,2,.L44
	bc 12,1,.L59
	cmpwi 0,0,4
	bc 12,2,.L45
	cmpwi 0,0,8
	bc 12,2,.L48
	b .L56
.L59:
	cmpwi 0,0,52
	bc 12,2,.L51
	cmpwi 0,0,55
	bc 12,2,.L54
	b .L56
.L45:
	li 0,0
	li 11,9
	stw 0,4664(10)
	mr 3,31
	lwz 9,84(31)
	stw 11,92(9)
	bl Think_WEdit
	lwz 0,264(31)
	andi. 9,0,16
	bc 4,2,.L46
	xori 0,0,16
	stw 0,264(31)
.L46:
	lwz 0,264(31)
	andi. 10,0,32
	bc 4,2,.L23
	xori 0,0,32
	stw 0,264(31)
	b .L23
.L48:
	neg 0,28
	srwi 0,0,31
	or. 0,30,0
	bc 4,2,.L23
	stw 0,4664(10)
	lwz 9,84(31)
	li 0,9
	stw 0,92(9)
	b .L44
.L51:
	bl rand
	li 29,10
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC16@ha
	lis 11,.LC14@ha
	la 10,.LC16@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC17@ha
	lfs 12,.LC14@l(11)
	la 10,.LC17@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,0,.L44
	li 29,9
	li 27,0
	b .L44
.L54:
	lwz 0,4900(10)
	cmpwi 0,0,-1
	bc 4,1,.L44
	mr 3,31
	bl ChangeRightWeapon
	b .L44
.L56:
	cmpwi 0,29,-1
	bc 4,2,.L62
	lwz 9,92(10)
	addi 9,9,1
	stw 9,92(10)
.L44:
	cmpwi 0,29,-1
	bc 12,2,.L60
.L62:
	lwz 9,84(31)
	stw 29,92(9)
.L60:
	cmpwi 0,27,-1
	bc 12,2,.L23
	lwz 9,84(31)
	stw 27,4664(9)
.L23:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 Think_WEdit,.Lfe2-Think_WEdit
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
