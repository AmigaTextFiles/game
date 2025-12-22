	.file	"camclient.c"
gcc2_compiled.:
	.section	".data"
	.align 2
	.type	 VEC_ORIGIN,@object
	.size	 VEC_ORIGIN,12
VEC_ORIGIN:
	.long 0x0
	.long 0x0
	.long 0x0
	.globl pDeadPlayer
	.section	".sdata","aw"
	.align 2
	.type	 pDeadPlayer,@object
	.size	 pDeadPlayer,4
pDeadPlayer:
	.long 0
	.section	".rodata"
	.align 2
.LC0:
	.string	"on"
	.align 2
.LC1:
	.string	"camera"
	.align 2
.LC2:
	.string	""
	.align 2
.LC3:
	.string	"off"
	.align 2
.LC4:
	.string	"follow"
	.align 2
.LC5:
	.string	"normal"
	.align 2
.LC6:
	.string	"min_xy"
	.align 2
.LC7:
	.string	"Min X/Y delta of %f unchanged!\n"
	.align 2
.LC8:
	.string	"Min X/Y delta of %f. set.\n"
	.align 2
.LC9:
	.string	"min_z"
	.align 2
.LC10:
	.string	"Min Z delta of %f unchanged!\n"
	.align 2
.LC11:
	.string	"Min Z delta of %f set.\n"
	.align 2
.LC12:
	.string	"min_angle"
	.align 2
.LC13:
	.string	"Min Yaw Angle delta of %f unchanged!\n"
	.align 2
.LC14:
	.string	"Min Yaw Angle delta of %f set.\n"
	.align 2
.LC15:
	.long 0x0
	.align 3
.LC16:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl CameraCmd
	.type	 CameraCmd,@function
CameraCmd:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,4
	mr 31,3
	lis 4,.LC0@ha
	mr 3,29
	la 4,.LC0@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L7
	lwz 9,84(31)
	lwz 0,3520(9)
	cmpwi 0,0,0
	bc 4,2,.L8
	lis 9,.LC15@ha
	lis 11,ctf@ha
	la 9,.LC15@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L9
	mr 3,31
	li 4,0
	crxor 6,6,6
	bl CTFJoinTeam1
	b .L8
.L9:
	mr 3,31
	li 4,0
	bl K2EnterGame
.L8:
	lis 9,.LC1@ha
	lis 11,.LC2@ha
	lwz 3,84(31)
	la 9,.LC1@l(9)
	li 30,0
	stw 9,280(31)
	la 11,.LC2@l(11)
	li 10,1
	li 0,6
	li 9,-1
	stw 11,268(31)
	stw 9,252(31)
	lis 6,0x42b4
	lis 7,0x4018
	stw 0,260(31)
	li 8,0
	lis 28,0x4008
	stw 30,552(31)
	li 29,0
	li 4,0
	stw 30,512(31)
	li 5,64
	stw 30,508(31)
	stw 30,400(31)
	stw 30,248(31)
	stw 30,492(31)
	stw 30,612(31)
	stw 30,608(31)
	stw 10,264(31)
	stw 10,3860(3)
	lwz 9,84(31)
	stw 6,112(9)
	lwz 11,84(31)
	stw 30,3864(11)
	lwz 9,84(31)
	stw 30,3872(9)
	lwz 11,84(31)
	stw 7,3888(11)
	stw 8,3892(11)
	lwz 9,84(31)
	stw 28,3896(9)
	stw 29,3900(9)
	lwz 11,84(31)
	stw 7,3904(11)
	stw 8,3908(11)
	lwz 9,84(31)
	stw 30,1788(9)
	lwz 11,84(31)
	stw 30,88(11)
	lwz 9,84(31)
	stw 30,3468(9)
	lwz 3,84(31)
	addi 3,3,120
	crxor 6,6,6
	bl memset
	lwz 9,84(31)
	lwz 4,3988(9)
	cmpwi 0,4,0
	bc 12,2,.L11
	mr 3,31
	li 5,1
	bl K2_SpawnKey
.L11:
	lwz 9,84(31)
	lwz 3,3996(9)
	cmpwi 0,3,0
	bc 12,2,.L12
	bl Release_Grapple
.L12:
	lwz 9,84(31)
	li 29,0
	mr 3,31
	stw 29,96(9)
	stw 29,104(9)
	stw 29,100(9)
	bl K2_InitClientVars
	mr 3,31
	bl K2_ResetClientKeyVars
	mr 3,31
	bl CTFPlayerResetGrapple
	mr 3,31
	bl CTFDeadDropFlag
	mr 3,31
	bl CTFDeadDropTech
	lwz 11,84(31)
	li 0,2
	mr 3,31
	stw 29,20(31)
	stw 29,24(31)
	stw 29,16(31)
	stw 30,64(31)
	stw 30,60(31)
	stw 30,40(31)
	stw 30,44(31)
	stw 30,56(31)
	stw 29,28(11)
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,32(9)
	lfs 0,24(31)
	lwz 11,84(31)
	stfs 0,36(11)
	lfs 0,16(31)
	lwz 9,84(31)
	stfs 0,3700(9)
	lfs 0,20(31)
	lwz 11,84(31)
	stfs 0,3704(11)
	lfs 0,24(31)
	lwz 10,84(31)
	stfs 0,3708(10)
	lwz 9,84(31)
	stw 30,3552(9)
	lwz 11,84(31)
	stw 30,3564(11)
	lwz 9,84(31)
	stw 0,716(9)
	lwz 11,84(31)
	sth 30,142(11)
	lwz 9,84(31)
	stw 30,3520(9)
	bl botRemovePlayer
	li 3,1
	b .L34
.L7:
	lis 4,.LC3@ha
	mr 3,29
	la 4,.LC3@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L14
	lwz 9,84(31)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L13
	stw 3,3860(9)
	li 4,0
	mr 3,31
	bl K2EnterGame
	li 3,1
	b .L34
.L14:
	lwz 9,280(31)
	li 3,0
	lbz 0,0(9)
	cmpwi 0,0,99
	bc 4,2,.L34
	lis 4,.LC4@ha
	mr 3,29
	la 4,.LC4@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L19
	lwz 9,84(31)
	stw 3,3864(9)
	b .L13
.L19:
	lis 4,.LC5@ha
	mr 3,29
	la 4,.LC5@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L21
	lwz 9,84(31)
	li 0,1
	stw 0,3864(9)
	b .L13
.L21:
	lis 4,.LC6@ha
	mr 3,29
	la 4,.LC6@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L23
	lwz 9,84(31)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L23
	mr 3,29
	bl atof
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfd 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L24
	lwz 9,84(31)
	lis 5,.LC7@ha
	mr 3,31
	la 5,.LC7@l(5)
	li 4,2
	b .L35
.L24:
	lwz 11,84(31)
	lis 5,.LC8@ha
	mr 3,31
	la 5,.LC8@l(5)
	li 4,2
	stfd 1,3888(11)
	lwz 9,84(31)
.L35:
	lfd 1,3888(9)
	creqv 6,6,6
	bl safe_cprintf
	b .L13
.L23:
	lis 4,.LC9@ha
	mr 3,29
	la 4,.LC9@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L27
	lwz 9,84(31)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L27
	mr 3,29
	bl atof
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfd 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L28
	lwz 9,84(31)
	lis 5,.LC10@ha
	mr 3,31
	la 5,.LC10@l(5)
	li 4,2
	b .L36
.L28:
	lwz 11,84(31)
	lis 5,.LC11@ha
	mr 3,31
	la 5,.LC11@l(5)
	li 4,2
	stfd 1,3896(11)
	lwz 9,84(31)
.L36:
	lfd 1,3896(9)
	creqv 6,6,6
	bl safe_cprintf
	b .L13
.L27:
	lis 4,.LC12@ha
	mr 3,29
	la 4,.LC12@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L13
	lwz 9,84(31)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L13
	mr 3,29
	bl atof
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfd 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L32
	lwz 9,84(31)
	lis 5,.LC13@ha
	mr 3,31
	la 5,.LC13@l(5)
	li 4,2
	lfd 1,3904(9)
	creqv 6,6,6
	bl safe_cprintf
	b .L13
.L32:
	lwz 11,84(31)
	lis 5,.LC14@ha
	mr 3,31
	la 5,.LC14@l(5)
	li 4,2
	stfd 1,3904(11)
	lwz 9,84(31)
	lfd 1,3904(9)
	creqv 6,6,6
	bl safe_cprintf
.L13:
	li 3,0
.L34:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 CameraCmd,.Lfe1-CameraCmd
	.section	".rodata"
	.align 3
.LC17:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl NumPlayersVisible
	.type	 NumPlayersVisible,@function
NumPlayersVisible:
	stwu 1,-144(1)
	mflr 0
	stmw 25,116(1)
	stw 0,148(1)
	mr 26,3
	li 25,0
	bl EntityListHead
	mr. 27,3
	bc 12,2,.L44
.L46:
	lwz 31,0(27)
	lwz 9,84(31)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 4,2,.L45
	lis 9,gi@ha
	addi 30,31,4
	la 28,gi@l(9)
	addi 29,26,4
	lwz 9,56(28)
	mr 3,30
	mr 4,29
	mtlr 9
	blrl
	cmpwi 0,3,0
	li 0,0
	bc 12,2,.L50
	lwz 0,48(28)
	lis 5,vec3_origin@ha
	addi 3,1,24
	la 5,vec3_origin@l(5)
	li 9,3
	mtlr 0
	mr 4,30
	mr 7,29
	mr 6,5
	mr 8,31
	blrl
	lfs 0,4(26)
	addi 3,1,8
	lfs 13,4(31)
	lfs 12,8(26)
	lfs 11,12(26)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(31)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(31)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorLength
	li 0,0
	fctiwz 0,1
	stfd 0,104(1)
	lwz 9,108(1)
	cmpwi 0,9,999
	bc 12,1,.L50
	lfs 0,32(1)
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfd 13,0(9)
	fcmpu 7,0,13
	mfcr 0
	rlwinm 0,0,31,1
.L50:
	cmpwi 0,0,0
	bc 12,2,.L45
	lwz 10,0(27)
	addi 25,25,1
	lwz 0,64(10)
	andis. 9,0,0xc
	bc 12,2,.L45
	lwz 11,84(26)
	lwz 9,3868(11)
	cmpwi 0,9,0
	bc 12,2,.L53
	lwz 0,64(9)
	andis. 9,0,0xc
	bc 4,2,.L45
.L53:
	stw 10,3868(11)
.L45:
	lwz 27,4(27)
	cmpwi 0,27,0
	bc 4,2,.L46
.L44:
	mr 3,25
	lwz 0,148(1)
	mtlr 0
	lmw 25,116(1)
	la 1,144(1)
	blr
.Lfe2:
	.size	 NumPlayersVisible,.Lfe2-NumPlayersVisible
	.section	".rodata"
	.align 3
.LC18:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC19:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl ClosestVisible
	.type	 ClosestVisible,@function
ClosestVisible:
	stwu 1,-144(1)
	mflr 0
	stmw 24,112(1)
	stw 0,148(1)
	mr 26,3
	li 24,0
	bl EntityListHead
	li 25,-1
	mr. 28,3
	bc 12,2,.L57
.L59:
	lwz 31,0(28)
	lwz 9,84(31)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 4,2,.L58
	lis 9,gi@ha
	addi 30,31,4
	la 27,gi@l(9)
	addi 29,26,4
	lwz 9,56(27)
	mr 3,30
	mr 4,29
	mtlr 9
	blrl
	cmpwi 0,3,0
	li 0,0
	bc 12,2,.L62
	lwz 0,48(27)
	lis 5,vec3_origin@ha
	addi 3,1,40
	la 5,vec3_origin@l(5)
	li 9,3
	mtlr 0
	mr 4,30
	mr 7,29
	mr 6,5
	mr 8,31
	blrl
	lfs 0,4(26)
	addi 3,1,24
	lfs 13,4(31)
	lfs 12,8(26)
	lfs 11,12(26)
	fsubs 13,13,0
	stfs 13,24(1)
	lfs 0,8(31)
	fsubs 0,0,12
	stfs 0,28(1)
	lfs 13,12(31)
	fsubs 13,13,11
	stfs 13,32(1)
	bl VectorLength
	li 0,0
	fctiwz 0,1
	stfd 0,104(1)
	lwz 9,108(1)
	cmpwi 0,9,999
	bc 12,1,.L62
	lfs 0,48(1)
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfd 13,0(9)
	fcmpu 7,0,13
	mfcr 0
	rlwinm 0,0,31,1
.L62:
	cmpwi 0,0,0
	bc 12,2,.L58
	lwz 9,0(28)
	addi 3,1,8
	lfs 13,4(26)
	lfs 0,4(9)
	lfs 12,8(26)
	lfs 11,12(26)
	fsubs 0,0,13
	stfs 0,8(1)
	lwz 9,0(28)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,12(1)
	lwz 9,0(28)
	lfs 0,12(9)
	fsubs 0,0,11
	stfs 0,16(1)
	bl VectorLength
	lis 9,.LC19@ha
	la 9,.LC19@l(9)
	lfd 0,0(9)
	fcmpu 0,1,0
	cror 3,2,1
	bc 12,3,.L64
	fctiwz 0,1
	stfd 0,104(1)
	lwz 0,108(1)
	b .L65
.L64:
	fsub 0,1,0
	fctiwz 13,0
	stfd 13,104(1)
	lwz 0,108(1)
	xoris 0,0,0x8000
.L65:
	cmplw 0,0,25
	bc 4,0,.L58
	mr 25,0
	mr 24,28
.L58:
	lwz 28,4(28)
	cmpwi 0,28,0
	bc 4,2,.L59
.L57:
	cmpwi 0,24,0
	li 3,0
	bc 12,2,.L68
	lwz 3,0(24)
.L68:
	lwz 0,148(1)
	mtlr 0
	lmw 24,112(1)
	la 1,144(1)
	blr
.Lfe3:
	.size	 ClosestVisible,.Lfe3-ClosestVisible
	.section	".rodata"
	.align 2
.LC20:
	.long 0x0
	.align 2
.LC21:
	.long 0x43b40000
	.align 3
.LC22:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl PointCamAtTarget
	.type	 PointCamAtTarget,@function
PointCamAtTarget:
	stwu 1,-64(1)
	mflr 0
	stw 31,60(1)
	stw 0,68(1)
	mr 31,3
	addi 4,1,24
	lwz 11,84(31)
	addi 3,1,8
	lfs 13,4(31)
	lwz 9,3868(11)
	lfs 12,8(31)
	lfs 0,4(9)
	lfs 11,12(31)
	fsubs 0,0,13
	stfs 0,8(1)
	lwz 9,3868(11)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,12(1)
	lwz 9,3868(11)
	lfs 0,12(9)
	fsubs 0,0,11
	stfs 0,16(1)
	bl vectoangles
	lfs 12,28(1)
	li 0,0
	lfs 0,20(31)
	lfs 13,24(1)
	stw 0,24(31)
	fsubs 10,12,0
	stfs 13,16(31)
	fmr 0,10
	fctiwz 11,0
	stfd 11,48(1)
	lwz 0,52(1)
	srawi 11,0,31
	xor 9,11,0
	subf 9,11,9
	cmpwi 0,9,180
	bc 4,1,.L86
	lis 9,.LC20@ha
	lis 11,.LC21@ha
	la 9,.LC20@l(9)
	la 11,.LC21@l(11)
	lfs 12,0(9)
	lfs 13,0(11)
.L87:
	fcmpu 0,10,12
	bc 4,1,.L88
	fsubs 10,10,13
	b .L85
.L88:
	fadds 10,10,13
.L85:
	fmr 0,10
	fctiwz 11,0
	stfd 11,48(1)
	lwz 0,52(1)
	srawi 11,0,31
	xor 9,11,0
	subf 9,11,9
	cmpwi 0,9,180
	bc 12,1,.L87
.L86:
	fmr 13,10
	lis 11,.LC22@ha
	la 11,.LC22@l(11)
	mr 10,9
	lfd 12,0(11)
	lis 8,0x4330
	fctiwz 0,13
	lwz 11,84(31)
	lfd 11,3904(11)
	stfd 0,48(1)
	lwz 9,52(1)
	srawi 11,9,31
	xor 0,11,9
	subf 0,11,0
	xoris 0,0,0x8000
	stw 0,52(1)
	stw 8,48(1)
	lfd 0,48(1)
	fsub 0,0,12
	fcmpu 0,0,11
	bc 4,1,.L91
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 0,0(9)
	fcmpu 0,10,0
	bc 4,1,.L92
	lfs 0,20(31)
	fadd 0,0,11
	frsp 0,0
	b .L95
.L92:
	lfs 0,20(31)
	fsub 0,0,11
	frsp 0,0
	b .L95
.L91:
	lfs 0,28(1)
.L95:
	stfs 0,20(31)
	lfs 0,16(31)
	lwz 9,84(31)
	stfs 0,28(9)
	lfs 0,20(31)
	lwz 11,84(31)
	stfs 0,32(11)
	lfs 0,24(31)
	lwz 9,84(31)
	stfs 0,36(9)
	lfs 0,16(31)
	lwz 11,84(31)
	stfs 0,3700(11)
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3704(9)
	lfs 13,24(31)
	lwz 9,84(31)
	stfs 13,3708(9)
	lwz 0,68(1)
	mtlr 0
	lwz 31,60(1)
	la 1,64(1)
	blr
.Lfe4:
	.size	 PointCamAtTarget,.Lfe4-PointCamAtTarget
	.section	".rodata"
	.align 3
.LC23:
	.long 0x3fe99999
	.long 0x9999999a
	.align 2
.LC24:
	.long 0x3f800000
	.align 2
.LC25:
	.long 0xc1000000
	.align 2
.LC26:
	.long 0x40800000
	.align 3
.LC27:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl RepositionAtTarget
	.type	 RepositionAtTarget,@function
RepositionAtTarget:
	stwu 1,-160(1)
	mflr 0
	stmw 27,140(1)
	stw 0,164(1)
	mr 31,3
	addi 29,1,40
	lwz 11,84(31)
	mr 27,4
	addi 28,1,56
	mr 4,29
	li 5,0
	lwz 9,3868(11)
	li 6,0
	mr 30,28
	lwz 3,84(9)
	addi 3,3,3700
	bl AngleVectors
	li 0,0
	mr 3,29
	stw 0,48(1)
	bl VectorNormalize
	lwz 10,84(31)
	lis 8,gi+48@ha
	li 9,1
	lfs 11,0(27)
	mr 3,28
	li 5,0
	lwz 11,3868(10)
	li 6,0
	addi 7,1,24
	lfs 12,40(1)
	lfs 0,4(11)
	lfs 13,4(27)
	lfs 10,44(1)
	fmadds 11,11,12,0
	lwz 0,gi+48@l(8)
	lfs 12,8(27)
	mtlr 0
	stfs 11,24(1)
	lwz 11,3868(10)
	lfs 0,8(11)
	fmadds 13,13,10,0
	stfs 13,28(1)
	lwz 11,3868(10)
	lfs 0,12(11)
	fadds 0,0,12
	stfs 0,32(1)
	lwz 4,3868(10)
	mr 8,4
	addi 4,4,4
	blrl
	lis 9,.LC24@ha
	lfs 13,64(1)
	la 9,.LC24@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L97
	lwz 11,84(31)
	addi 3,1,8
	lfs 0,68(1)
	lwz 9,3868(11)
	lfs 13,72(1)
	lfs 12,4(9)
	lfs 11,76(1)
	fsubs 0,0,12
	stfs 0,8(1)
	lwz 9,3868(11)
	lfs 0,8(9)
	fsubs 13,13,0
	stfs 13,12(1)
	lwz 9,3868(11)
	lfs 0,12(9)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorNormalize
	lis 9,.LC25@ha
	addi 3,1,68
	la 9,.LC25@l(9)
	addi 4,1,8
	lfs 1,0(9)
	mr 5,3
	bl VectorMA
	lfs 0,88(1)
	lis 9,.LC23@ha
	lfd 13,.LC23@l(9)
	fcmpu 0,0,13
	bc 4,1,.L97
	lis 9,.LC26@ha
	lfs 0,76(1)
	la 9,.LC26@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,76(1)
.L97:
	lfs 9,68(1)
	lis 9,.LC27@ha
	lfs 10,4(31)
	la 9,.LC27@l(9)
	mr 10,11
	lfd 12,0(9)
	lis 8,0x4330
	lwz 9,84(31)
	fsubs 0,9,10
	lfd 11,3888(9)
	fctiwz 13,0
	stfd 13,128(1)
	lwz 11,132(1)
	srawi 9,11,31
	xor 0,9,11
	subf 0,9,0
	xoris 0,0,0x8000
	stw 0,132(1)
	stw 8,128(1)
	lfd 0,128(1)
	fsub 0,0,12
	fcmpu 0,0,11
	bc 4,1,.L99
	fcmpu 0,9,10
	bc 4,1,.L100
	fmr 0,10
	fadd 0,0,11
	b .L113
.L100:
	fmr 0,10
	fsub 0,0,11
.L113:
	frsp 0,0
	stfs 0,4(31)
	b .L102
.L99:
	stfs 9,4(31)
.L102:
	lfs 9,72(1)
	lis 9,.LC27@ha
	lfs 10,8(31)
	la 9,.LC27@l(9)
	mr 10,11
	lfd 12,0(9)
	lis 8,0x4330
	lwz 9,84(31)
	fsubs 0,9,10
	lfd 11,3888(9)
	fctiwz 13,0
	stfd 13,128(1)
	lwz 11,132(1)
	srawi 9,11,31
	xor 0,9,11
	subf 0,9,0
	xoris 0,0,0x8000
	stw 0,132(1)
	stw 8,128(1)
	lfd 0,128(1)
	fsub 0,0,12
	fcmpu 0,0,11
	bc 4,1,.L103
	fcmpu 0,9,10
	bc 4,1,.L104
	fmr 0,10
	fadd 0,0,11
	b .L114
.L104:
	fmr 0,10
	fsub 0,0,11
.L114:
	frsp 0,0
	stfs 0,8(31)
	b .L106
.L103:
	stfs 9,8(31)
.L106:
	lfs 9,76(1)
	lis 9,.LC27@ha
	lfs 10,12(31)
	la 9,.LC27@l(9)
	mr 10,11
	lfd 12,0(9)
	lis 8,0x4330
	lwz 9,84(31)
	fsubs 0,9,10
	lfd 11,3896(9)
	fctiwz 13,0
	stfd 13,128(1)
	lwz 11,132(1)
	srawi 9,11,31
	xor 0,9,11
	subf 0,9,0
	xoris 0,0,0x8000
	stw 0,132(1)
	stw 8,128(1)
	lfd 0,128(1)
	fsub 0,0,12
	fcmpu 0,0,11
	bc 4,1,.L107
	fcmpu 0,9,10
	bc 4,1,.L108
	fmr 0,10
	fadd 0,0,11
	b .L115
.L108:
	fmr 0,10
	fsub 0,0,11
.L115:
	frsp 0,0
	stfs 0,12(31)
	b .L110
.L107:
	stfs 9,12(31)
.L110:
	lwz 11,84(31)
	lis 9,gi+48@ha
	mr 3,30
	lwz 0,gi+48@l(9)
	li 5,0
	li 6,0
	lwz 4,3868(11)
	li 9,1
	addi 7,31,4
	mtlr 0
	mr 8,4
	addi 4,4,4
	blrl
	lis 9,.LC24@ha
	lfs 13,64(1)
	la 9,.LC24@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L111
	lwz 11,84(31)
	addi 3,1,8
	lfs 0,68(1)
	lwz 9,3868(11)
	lfs 13,72(1)
	lfs 12,4(9)
	lfs 11,76(1)
	fsubs 0,0,12
	stfs 0,8(1)
	lwz 9,3868(11)
	lfs 0,8(9)
	fsubs 13,13,0
	stfs 13,12(1)
	lwz 9,3868(11)
	lfs 0,12(9)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorNormalize
	lis 9,.LC25@ha
	addi 3,1,68
	la 9,.LC25@l(9)
	addi 4,1,8
	lfs 1,0(9)
	mr 5,3
	bl VectorMA
	lfs 0,88(1)
	lis 9,.LC23@ha
	lfd 13,.LC23@l(9)
	fcmpu 0,0,13
	bc 4,1,.L112
	lis 9,.LC26@ha
	lfs 0,76(1)
	la 9,.LC26@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,76(1)
.L112:
	lfs 0,68(1)
	lfs 12,72(1)
	lfs 13,76(1)
	stfs 0,4(31)
	stfs 12,8(31)
	stfs 13,12(31)
.L111:
	lwz 0,164(1)
	mtlr 0
	lmw 27,140(1)
	la 1,160(1)
	blr
.Lfe5:
	.size	 RepositionAtTarget,.Lfe5-RepositionAtTarget
	.section	".rodata"
	.align 3
.LC28:
	.long 0x3fe99999
	.long 0x9999999a
	.align 2
.LC29:
	.long 0x42200000
	.align 2
.LC30:
	.long 0x41f00000
	.align 2
.LC31:
	.long 0x3f800000
	.align 2
.LC32:
	.long 0xc1000000
	.align 2
.LC33:
	.long 0x40800000
	.align 3
.LC34:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl RepositionAtOrigin
	.type	 RepositionAtOrigin,@function
RepositionAtOrigin:
	stwu 1,-144(1)
	mflr 0
	stmw 28,128(1)
	stw 0,148(1)
	lis 9,.LC29@ha
	mr 30,4
	la 9,.LC29@l(9)
	lfs 12,0(30)
	mr 31,3
	lfs 11,0(9)
	addi 3,1,24
	lis 9,.LC30@ha
	lfs 13,4(30)
	li 5,0
	la 9,.LC30@l(9)
	lfs 0,8(30)
	li 6,0
	lfs 10,0(9)
	fadds 12,12,11
	addi 7,1,8
	mr 28,3
	fadds 13,13,11
	lis 9,gi+48@ha
	lwz 11,84(31)
	lwz 0,gi+48@l(9)
	fadds 0,0,10
	stfs 12,8(1)
	li 9,1
	stfs 13,12(1)
	mtlr 0
	stfs 0,16(1)
	lwz 8,3868(11)
	blrl
	lis 9,.LC31@ha
	lfs 13,32(1)
	la 9,.LC31@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L117
	lfs 11,0(30)
	addi 29,1,88
	lfs 12,36(1)
	mr 3,29
	lfs 10,4(30)
	lfs 13,40(1)
	fsubs 12,12,11
	lfs 0,44(1)
	lfs 11,8(30)
	fsubs 13,13,10
	stfs 12,88(1)
	fsubs 0,0,11
	stfs 13,92(1)
	stfs 0,96(1)
	bl VectorNormalize
	lis 9,.LC32@ha
	addi 3,1,36
	la 9,.LC32@l(9)
	mr 4,29
	lfs 1,0(9)
	mr 5,3
	bl VectorMA
	lfs 0,56(1)
	lis 9,.LC28@ha
	lfd 13,.LC28@l(9)
	fcmpu 0,0,13
	bc 4,1,.L117
	lis 9,.LC33@ha
	lfs 0,44(1)
	la 9,.LC33@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,44(1)
.L117:
	lfs 9,36(1)
	lis 9,.LC34@ha
	lfs 10,4(31)
	la 9,.LC34@l(9)
	mr 10,11
	lfd 12,0(9)
	lis 8,0x4330
	lwz 9,84(31)
	fsubs 0,9,10
	lfd 11,3888(9)
	fctiwz 13,0
	stfd 13,120(1)
	lwz 11,124(1)
	srawi 9,11,31
	xor 0,9,11
	subf 0,9,0
	xoris 0,0,0x8000
	stw 0,124(1)
	stw 8,120(1)
	lfd 0,120(1)
	fsub 0,0,12
	fcmpu 0,0,11
	bc 4,1,.L119
	fcmpu 0,9,10
	bc 4,1,.L120
	fmr 0,10
	fadd 0,0,11
	b .L134
.L120:
	fmr 0,10
	fsub 0,0,11
.L134:
	frsp 0,0
	stfs 0,4(31)
	b .L122
.L119:
	stfs 9,4(31)
.L122:
	lfs 9,40(1)
	lis 9,.LC34@ha
	lfs 10,8(31)
	la 9,.LC34@l(9)
	mr 10,11
	lfd 12,0(9)
	lis 8,0x4330
	lwz 9,84(31)
	fsubs 0,9,10
	lfd 11,3888(9)
	fctiwz 13,0
	stfd 13,120(1)
	lwz 11,124(1)
	srawi 9,11,31
	xor 0,9,11
	subf 0,9,0
	xoris 0,0,0x8000
	stw 0,124(1)
	stw 8,120(1)
	lfd 0,120(1)
	fsub 0,0,12
	fcmpu 0,0,11
	bc 4,1,.L123
	fcmpu 0,9,10
	bc 4,1,.L124
	fmr 0,10
	fadd 0,0,11
	b .L135
.L124:
	fmr 0,10
	fsub 0,0,11
.L135:
	frsp 0,0
	stfs 0,8(31)
	b .L126
.L123:
	stfs 9,8(31)
.L126:
	lfs 9,44(1)
	lis 9,.LC34@ha
	lfs 10,12(31)
	la 9,.LC34@l(9)
	mr 10,11
	lfd 12,0(9)
	lis 8,0x4330
	lwz 9,84(31)
	fsubs 0,9,10
	lfd 11,3896(9)
	fctiwz 13,0
	stfd 13,120(1)
	lwz 11,124(1)
	srawi 9,11,31
	xor 0,9,11
	subf 0,9,0
	xoris 0,0,0x8000
	stw 0,124(1)
	stw 8,120(1)
	lfd 0,120(1)
	fsub 0,0,12
	fcmpu 0,0,11
	bc 4,1,.L127
	fcmpu 0,9,10
	bc 4,1,.L128
	fmr 0,10
	fadd 0,0,11
	b .L136
.L128:
	fmr 0,10
	fsub 0,0,11
.L136:
	frsp 0,0
	stfs 0,12(31)
	b .L130
.L127:
	stfs 9,12(31)
.L130:
	lis 9,gi+48@ha
	lwz 11,84(31)
	mr 3,28
	lwz 0,gi+48@l(9)
	mr 4,30
	li 5,0
	li 9,1
	lwz 8,3868(11)
	li 6,0
	addi 7,31,4
	mtlr 0
	blrl
	lis 9,.LC31@ha
	lfs 13,32(1)
	la 9,.LC31@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L131
	lfs 9,8(30)
	addi 29,1,104
	lfs 11,0(30)
	mr 3,29
	lfs 10,4(30)
	lfs 12,36(1)
	lfs 13,40(1)
	lfs 0,44(1)
	fsubs 12,12,11
	fsubs 13,13,10
	fsubs 0,0,9
	stfs 12,104(1)
	stfs 13,108(1)
	stfs 0,112(1)
	bl VectorNormalize
	lis 9,.LC32@ha
	addi 3,1,36
	la 9,.LC32@l(9)
	mr 4,29
	lfs 1,0(9)
	mr 5,3
	bl VectorMA
	lfs 0,56(1)
	lis 9,.LC28@ha
	lfd 13,.LC28@l(9)
	fcmpu 0,0,13
	bc 4,1,.L131
	lis 9,.LC33@ha
	lfs 0,44(1)
	la 9,.LC33@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,44(1)
.L131:
	lis 9,.LC31@ha
	lfs 13,32(1)
	la 9,.LC31@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L133
	lfs 0,36(1)
	lfs 12,40(1)
	lfs 13,44(1)
	stfs 0,4(31)
	stfs 12,8(31)
	stfs 13,12(31)
.L133:
	lwz 0,148(1)
	mtlr 0
	lmw 28,128(1)
	la 1,144(1)
	blr
.Lfe6:
	.size	 RepositionAtOrigin,.Lfe6-RepositionAtOrigin
	.align 2
	.globl CameraFollowThink
	.type	 CameraFollowThink,@function
CameraFollowThink:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 29,3
	lwz 9,84(29)
	lwz 0,3868(9)
	cmpwi 0,0,0
	bc 4,2,.L142
	bl EntityListHead
	li 30,0
	li 28,0
	mr. 31,3
	bc 12,2,.L152
.L145:
	lwz 3,0(31)
	lwz 0,492(3)
	cmpwi 0,0,0
	bc 4,2,.L151
	lwz 9,84(3)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 4,2,.L151
	lwz 0,3520(9)
	cmpwi 0,0,0
	bc 12,2,.L151
	bl NumPlayersVisible
	cmpw 0,3,28
	bc 4,1,.L147
	mr 28,3
	mr 30,31
	b .L151
.L147:
	mfcr 9
	rlwinm 9,9,3,1
	addic 11,3,-1
	subfe 0,11,3
	and. 11,0,9
	bc 12,2,.L151
	lwz 9,0(30)
	lwz 11,0(31)
	lwz 10,84(9)
	lwz 8,84(11)
	lwz 7,3464(10)
	lwz 9,3464(8)
	cmpw 7,7,9
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,31,0
	and 0,30,0
	or 30,0,9
.L151:
	lwz 31,4(31)
	cmpwi 0,31,0
	bc 4,2,.L145
.L152:
	cmpwi 0,30,0
	li 0,0
	bc 12,2,.L154
	lwz 0,0(30)
.L154:
	lwz 9,84(29)
	cmpwi 0,0,0
	stw 0,3868(9)
	bc 12,2,.L141
.L142:
	lis 0,0xc270
	lis 9,0x4220
	mr 3,29
	stw 0,12(1)
	addi 4,1,8
	stw 9,16(1)
	stw 0,8(1)
	bl RepositionAtTarget
	mr 3,29
	bl PointCamAtTarget
.L141:
	lwz 9,84(29)
	lwz 0,3868(9)
	cmpwi 0,0,0
	bc 4,2,.L157
	stw 0,3464(9)
	stw 0,480(29)
.L157:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 CameraFollowThink,.Lfe7-CameraFollowThink
	.section	".rodata"
	.align 3
.LC35:
	.long 0x40040000
	.long 0x0
	.align 2
.LC36:
	.long 0x41a00000
	.align 2
.LC37:
	.long 0x40400000
	.align 2
.LC38:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl CameraNormalThink
	.type	 CameraNormalThink,@function
CameraNormalThink:
	stwu 1,-80(1)
	mflr 0
	stmw 28,64(1)
	stw 0,84(1)
	mr 30,3
	bl NumPlayersVisible
	lwz 11,84(30)
	lwz 0,3872(11)
	cmpwi 0,0,0
	bc 4,2,.L223
	lwz 9,3868(11)
	cmpwi 0,9,0
	bc 12,2,.L159
	lwz 0,492(9)
	cmpwi 0,0,0
	bc 12,2,.L159
	li 0,1
	lis 9,level+4@ha
	stw 0,3872(11)
	mr 3,30
	lfs 0,level+4@l(9)
	lis 11,.LC35@ha
	la 11,.LC35@l(11)
	lfd 13,0(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,476(30)
	bl PointCamAtTarget
	b .L160
.L159:
	lwz 4,84(30)
	lwz 0,3872(4)
	cmpwi 0,0,0
	bc 12,2,.L161
.L223:
	lis 9,level+4@ha
	lfs 13,476(30)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L162
	lwz 9,84(30)
	li 0,0
	stw 0,3872(9)
	b .L160
.L162:
	lwz 11,84(30)
	lwz 9,3868(11)
	lwz 0,492(9)
	cmpwi 0,0,0
	bc 12,2,.L164
	lfs 0,4(9)
	stfs 0,3876(11)
	lwz 11,84(30)
	lwz 9,3868(11)
	lfs 0,8(9)
	stfs 0,3880(11)
	lwz 10,84(30)
	lwz 9,3868(10)
	lfs 0,12(9)
	stfs 0,3884(10)
.L164:
	lwz 9,84(30)
	addi 4,1,40
	addi 3,1,24
	lfs 0,4(30)
	lfs 13,3876(9)
	lfs 12,8(30)
	addi 9,9,3876
	lfs 11,12(30)
	fsubs 13,13,0
	stfs 13,24(1)
	lfs 0,4(9)
	fsubs 0,0,12
	stfs 0,28(1)
	lfs 13,8(9)
	fsubs 13,13,11
	stfs 13,32(1)
	bl vectoangles
	lfs 0,44(1)
	mr 3,30
	lfs 12,40(1)
	lfs 13,48(1)
	lwz 11,84(30)
	stfs 0,20(30)
	stfs 13,24(30)
	stfs 12,16(30)
	stfs 12,28(11)
	lfs 0,44(1)
	lwz 9,84(30)
	stfs 0,32(9)
	lfs 0,48(1)
	lwz 11,84(30)
	stfs 0,36(11)
	lfs 0,40(1)
	lwz 9,84(30)
	stfs 0,3700(9)
	lfs 0,44(1)
	lwz 11,84(30)
	stfs 0,3704(11)
	lfs 0,48(1)
	lwz 9,84(30)
	stfs 0,3708(9)
	lwz 4,84(30)
	addi 4,4,3876
	bl RepositionAtOrigin
	b .L160
.L161:
	cmpwi 0,3,1
	bc 12,1,.L167
	lis 9,level+4@ha
	lfs 13,476(30)
	lis 11,0xc270
	lfs 0,level+4@l(9)
	lis 0,0x4220
	stw 11,12(1)
	stw 0,16(1)
	fcmpu 0,13,0
	stw 11,8(1)
	bc 4,1,.L168
	cmpwi 0,3,0
	bc 4,1,.L169
	mr 3,30
	bl ClosestVisible
	lwz 9,84(30)
	cmpwi 0,3,0
	stw 3,3868(9)
	bc 12,2,.L160
	mr 3,30
	addi 4,1,8
	b .L224
.L169:
	bl EntityListHead
	li 29,0
	li 28,0
	mr. 31,3
	bc 12,2,.L182
.L175:
	lwz 3,0(31)
	lwz 0,492(3)
	cmpwi 0,0,0
	bc 4,2,.L181
	lwz 9,84(3)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 4,2,.L181
	lwz 0,3520(9)
	cmpwi 0,0,0
	bc 12,2,.L181
	bl NumPlayersVisible
	cmpw 0,3,28
	bc 4,1,.L177
	mr 28,3
	mr 29,31
	b .L181
.L177:
	mfcr 9
	rlwinm 9,9,3,1
	addic 11,3,-1
	subfe 0,11,3
	and. 11,0,9
	bc 12,2,.L181
	lwz 9,0(29)
	lwz 11,0(31)
	lwz 10,84(9)
	lwz 8,84(11)
	lwz 7,3464(10)
	lwz 9,3464(8)
	cmpw 7,7,9
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,31,0
	and 0,29,0
	or 29,0,9
.L181:
	lwz 31,4(31)
	cmpwi 0,31,0
	bc 4,2,.L175
.L182:
	cmpwi 0,29,0
	li 0,0
	bc 12,2,.L184
	lwz 0,0(29)
.L184:
	lwz 9,84(30)
	cmpwi 0,0,0
	stw 0,3868(9)
	bc 12,2,.L160
	mr 3,30
	addi 4,1,8
	bl RepositionAtTarget
	mr 3,30
	bl PointCamAtTarget
	li 0,0
	stw 0,476(30)
	b .L160
.L168:
	bl EntityListHead
	li 29,0
	li 28,0
	mr. 31,3
	bc 12,2,.L196
.L189:
	lwz 3,0(31)
	lwz 0,492(3)
	cmpwi 0,0,0
	bc 4,2,.L195
	lwz 9,84(3)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 4,2,.L195
	lwz 0,3520(9)
	cmpwi 0,0,0
	bc 12,2,.L195
	bl NumPlayersVisible
	cmpw 0,3,28
	bc 4,1,.L191
	mr 28,3
	mr 29,31
	b .L195
.L191:
	mfcr 9
	rlwinm 9,9,3,1
	addic 11,3,-1
	subfe 0,11,3
	and. 11,0,9
	bc 12,2,.L195
	lwz 9,0(29)
	lwz 11,0(31)
	lwz 10,84(9)
	lwz 8,84(11)
	lwz 7,3464(10)
	lwz 9,3464(8)
	cmpw 7,7,9
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,31,0
	and 0,29,0
	or 29,0,9
.L195:
	lwz 31,4(31)
	cmpwi 0,31,0
	bc 4,2,.L189
.L196:
	cmpwi 0,29,0
	li 0,0
	bc 12,2,.L198
	lwz 0,0(29)
.L198:
	lwz 9,84(30)
	cmpwi 0,0,0
	stw 0,3868(9)
	bc 12,2,.L160
	lis 0,0xc270
	lis 9,0x4220
	mr 3,30
	stw 0,12(1)
	addi 4,1,8
	stw 9,16(1)
	stw 0,8(1)
.L224:
	bl RepositionAtTarget
	mr 3,30
	bl PointCamAtTarget
	b .L160
.L167:
	lis 9,level@ha
	lfs 13,476(30)
	la 31,level@l(9)
	lfs 0,4(31)
	fcmpu 0,13,0
	bc 12,0,.L201
	lwz 4,3868(4)
	cmpwi 0,4,0
	bc 12,2,.L160
	lis 9,gi+56@ha
	addi 4,4,4
	lwz 0,gi+56@l(9)
	addi 3,30,4
	mtlr 0
	blrl
	cmpwi 0,3,0
	bc 4,2,.L200
.L201:
	bl EntityListHead
	li 29,0
	li 28,0
	mr. 31,3
	bc 12,2,.L212
.L205:
	lwz 3,0(31)
	lwz 0,492(3)
	cmpwi 0,0,0
	bc 4,2,.L211
	lwz 9,84(3)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 4,2,.L211
	lwz 0,3520(9)
	cmpwi 0,0,0
	bc 12,2,.L211
	bl NumPlayersVisible
	cmpw 0,3,28
	bc 4,1,.L207
	mr 28,3
	mr 29,31
	b .L211
.L207:
	mfcr 9
	rlwinm 9,9,3,1
	addic 11,3,-1
	subfe 0,11,3
	and. 11,0,9
	bc 12,2,.L211
	lwz 9,0(29)
	lwz 11,0(31)
	lwz 10,84(9)
	lwz 8,84(11)
	lwz 7,3464(10)
	lwz 9,3464(8)
	cmpw 7,7,9
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,31,0
	and 0,29,0
	or 29,0,9
.L211:
	lwz 31,4(31)
	cmpwi 0,31,0
	bc 4,2,.L205
.L212:
	cmpwi 0,29,0
	li 0,0
	bc 12,2,.L214
	lwz 0,0(29)
.L214:
	lwz 9,84(30)
	cmpwi 0,0,0
	stw 0,3868(9)
	bc 12,2,.L160
	lis 9,0xc270
	lis 0,0x42a0
	stw 9,12(1)
	mr 3,30
	stw 9,8(1)
	stw 0,16(1)
	bl PointCamAtTarget
	mr 3,30
	addi 4,1,8
	bl RepositionAtTarget
	lis 11,.LC36@ha
	lis 9,level+4@ha
	la 11,.LC36@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,476(30)
	b .L160
.L200:
	lwz 9,84(30)
	lwz 4,3868(9)
	cmpwi 0,4,0
	bc 12,2,.L160
	lis 9,.LC36@ha
	lfs 11,4(31)
	lis 11,.LC37@ha
	la 9,.LC36@l(9)
	la 11,.LC37@l(11)
	lfs 12,476(30)
	lfs 0,0(9)
	lfs 13,0(11)
	fadds 0,11,0
	fsubs 0,0,13
	fcmpu 0,12,0
	bc 12,1,.L218
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfs 0,0(9)
	fadds 0,11,0
	fcmpu 0,12,0
	bc 4,0,.L217
.L218:
	addi 4,4,4
	mr 3,30
	bl RepositionAtOrigin
.L217:
	mr 3,30
	bl PointCamAtTarget
.L160:
	lis 9,pDeadPlayer@ha
	li 0,0
	stw 0,pDeadPlayer@l(9)
	lwz 0,84(1)
	mtlr 0
	lmw 28,64(1)
	la 1,80(1)
	blr
.Lfe8:
	.size	 CameraNormalThink,.Lfe8-CameraNormalThink
	.section	".rodata"
	.align 2
.LC39:
	.long 0x471c4000
	.align 2
.LC40:
	.long 0x432f0000
	.align 2
.LC41:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl CameraStaticThink
	.type	 CameraStaticThink,@function
CameraStaticThink:
	stwu 1,-128(1)
	mflr 0
	stmw 28,112(1)
	stw 0,132(1)
	mr 31,3
	lis 9,.LC39@ha
	lfs 13,12(31)
	lis 29,gi@ha
	addi 28,1,72
	lfs 0,.LC39@l(9)
	la 29,gi@l(29)
	addi 3,1,8
	lwz 11,48(29)
	li 9,1
	addi 4,31,4
	lfs 12,4(31)
	li 5,0
	li 6,0
	fsubs 13,13,0
	mtlr 11
	mr 7,28
	mr 8,31
	lfs 0,8(31)
	stfs 12,72(1)
	stfs 13,80(1)
	stfs 0,76(1)
	blrl
	lis 9,.LC40@ha
	lfs 11,28(1)
	mr 4,28
	la 9,.LC40@l(9)
	lwz 0,48(29)
	addi 3,1,8
	lfs 13,0(9)
	li 5,0
	li 6,0
	lfs 12,20(1)
	li 9,1
	addi 7,1,88
	mtlr 0
	lfs 0,24(1)
	mr 8,31
	fadds 13,11,13
	stfs 11,80(1)
	stfs 12,88(1)
	stfs 0,92(1)
	stfs 13,96(1)
	stfs 12,72(1)
	stfs 0,76(1)
	blrl
	lfs 0,24(1)
	lis 9,level+4@ha
	lfs 13,28(1)
	lfs 12,20(1)
	stfs 0,8(31)
	stfs 13,12(31)
	stfs 12,4(31)
	lfs 13,level+4@l(9)
	lfs 0,476(31)
	fcmpu 0,0,13
	bc 4,0,.L226
	lis 9,.LC41@ha
	lwz 10,84(31)
	lis 11,0x4234
	la 9,.LC41@l(9)
	li 0,0
	stw 11,16(31)
	lfs 0,0(9)
	stw 0,24(31)
	stw 0,20(31)
	fadds 0,13,0
	stfs 0,476(31)
	stw 11,28(10)
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,32(9)
	lfs 0,24(31)
	lwz 11,84(31)
	stfs 0,36(11)
	lfs 0,16(31)
	lwz 9,84(31)
	stfs 0,3700(9)
	lfs 0,20(31)
	lwz 11,84(31)
	stfs 0,3704(11)
	lfs 13,24(31)
	lwz 9,84(31)
	stfs 13,3708(9)
.L226:
	lwz 0,132(1)
	mtlr 0
	lmw 28,112(1)
	la 1,128(1)
	blr
.Lfe9:
	.size	 CameraStaticThink,.Lfe9-CameraStaticThink
	.section	".rodata"
	.align 2
.LC42:
	.string	"Now showing %s\n"
	.align 3
.LC43:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CameraThink
	.type	 CameraThink,@function
CameraThink:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 27,36(1)
	stw 0,68(1)
	mr 31,3
	mr 29,4
	lwz 11,84(31)
	lwz 9,3868(11)
	cmpwi 0,9,0
	bc 12,2,.L230
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L229
.L230:
	lbz 0,1(29)
	andi. 9,0,1
	bc 12,2,.L228
	lwz 0,3584(11)
	andi. 10,0,1
	bc 4,2,.L228
.L229:
	bl EntityListHead
	li 30,0
	lis 27,maxclients@ha
	b .L251
.L233:
	bl EntityListNext
.L251:
	mr. 3,3
	bc 12,2,.L232
	lwz 9,84(31)
	lwz 9,3868(9)
	cmpwi 0,9,0
	bc 12,2,.L232
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L232
	lwz 0,0(3)
	cmpw 0,0,9
	bc 4,2,.L233
.L232:
	bl EntityListNext
	mr. 3,3
	bc 4,2,.L236
	bl EntityListHead
.L236:
	lis 9,.LC43@ha
	lis 28,0x4330
	la 9,.LC43@l(9)
	lfd 31,0(9)
.L241:
	lwz 9,0(3)
	lwz 0,248(9)
	cmpwi 0,0,0
	bc 4,2,.L238
	bl EntityListNext
	mr. 3,3
	bc 4,2,.L240
	bl EntityListHead
.L240:
	addi 30,30,1
	lwz 11,maxclients@l(27)
	xoris 0,30,0x8000
	stw 0,28(1)
	stw 28,24(1)
	lfd 0,24(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L241
.L238:
	xoris 0,30,0x8000
	lis 11,0x4330
	stw 0,28(1)
	lis 10,.LC43@ha
	la 10,.LC43@l(10)
	stw 11,24(1)
	lfd 12,0(10)
	lfd 0,24(1)
	lis 10,maxclients@ha
	lwz 11,maxclients@l(10)
	fsub 0,0,12
	lfs 13,20(11)
	frsp 0,0
	fcmpu 0,0,13
	bc 4,0,.L228
	lwz 0,0(3)
	lis 5,.LC42@ha
	li 4,2
	lwz 11,84(31)
	mr 3,31
	la 5,.LC42@l(5)
	stw 0,3868(11)
	lwz 9,84(31)
	lwz 11,3868(9)
	lwz 6,84(11)
	addi 6,6,700
	crxor 6,6,6
	bl safe_cprintf
.L228:
	lwz 11,84(31)
	li 10,4
	li 8,0
	lbz 0,1(29)
	stw 0,3584(11)
	lwz 9,84(31)
	stw 10,0(9)
	lwz 11,84(31)
	sth 8,18(11)
	bl EntityListNumber
	cmpwi 0,3,0
	bc 4,2,.L243
	mr 3,31
	mr 4,29
	bl CameraStaticThink
	b .L245
.L243:
	lwz 9,84(31)
	lwz 0,3864(9)
	cmpwi 0,0,0
	bc 4,2,.L247
	mr 3,31
	mr 4,29
	bl CameraFollowThink
	b .L245
.L247:
	mr 3,31
	mr 4,29
	bl CameraNormalThink
.L245:
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe10:
	.size	 CameraThink,.Lfe10-CameraThink
	.globl ulCount
	.section	".sdata","aw"
	.align 2
	.type	 ulCount,@object
	.size	 ulCount,4
ulCount:
	.long 0
	.section	".rodata"
	.align 2
.LC44:
	.string	"PrintEntityList\n"
	.align 2
.LC45:
	.string	"Name: %s "
	.align 2
.LC46:
	.string	"Class: %s\n"
	.align 2
.LC47:
	.string	"Actual Count: %d List Count %d\n"
	.section	".text"
	.align 2
	.globl EnitityListClean
	.type	 EnitityListClean,@function
EnitityListClean:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 27,pEntityListHead@ha
	b .L276
.L278:
	mr 11,3
	lwz 29,0(9)
	cmpwi 0,11,0
	mr 31,11
	bc 12,2,.L276
	lis 9,level@ha
	lis 30,ulCount@ha
	la 28,level@l(9)
.L284:
	lwz 10,0(11)
	mr 3,11
	cmpw 7,11,31
	lwz 9,84(10)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L285
	lfs 0,4(28)
	stfs 0,476(10)
.L285:
	lwz 0,0(11)
	cmpw 0,0,29
	bc 4,2,.L286
	bc 4,30,.L287
	lwz 0,4(11)
	stw 0,pEntityListHead@l(27)
	b .L288
.L287:
	lwz 0,4(11)
	stw 0,4(31)
.L288:
	bl free
	lwz 9,ulCount@l(30)
	li 11,0
	addi 9,9,-1
	stw 9,ulCount@l(30)
	b .L282
.L286:
	mr 31,11
	lwz 11,4(11)
.L282:
	cmpwi 0,11,0
	bc 4,2,.L284
.L276:
	lis 9,pEntityListHead@ha
	lwz 3,pEntityListHead@l(9)
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	and. 9,3,0
	bc 4,2,.L278
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 EnitityListClean,.Lfe11-EnitityListClean
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.comm	last_trail_time,4,4
	.comm	bot_frametime,8,8
	.comm	max_bots,4,4
	.comm	last_bot_spawn,4,4
	.comm	bot_male_names_used,4,4
	.comm	bot_female_names_used,4,4
	.comm	bot_count,4,4
	.comm	bot_teams,256,4
	.comm	total_teams,4,4
	.comm	the_client,4,4
	.comm	num_players,4,4
	.comm	players,1024,4
	.comm	weapons_head,4,4
	.comm	health_head,4,4
	.comm	bonus_head,4,4
	.comm	ammo_head,4,4
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_bullets,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_supershotgun,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.comm	botinfo_list,4,4
	.comm	total_bots,4,4
	.comm	teambot_list,4,4
	.comm	paused,4,4
	.align 2
	.globl PlayerDied
	.type	 PlayerDied,@function
PlayerDied:
	lwz 0,84(3)
	cmpwi 0,0,0
	bclr 12,2
	lis 9,pDeadPlayer@ha
	stw 3,pDeadPlayer@l(9)
	blr
.Lfe12:
	.size	 PlayerDied,.Lfe12-PlayerDied
	.align 2
	.globl EntityListRemove
	.type	 EntityListRemove,@function
EntityListRemove:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,pEntityListHead@ha
	mr 29,3
	lwz 3,pEntityListHead@l(9)
	lis 27,pEntityListHead@ha
	cmpwi 0,3,0
	mr 31,3
	bc 12,2,.L254
	lis 9,level@ha
	lis 30,ulCount@ha
	la 28,level@l(9)
.L255:
	lwz 11,0(3)
	lwz 9,84(11)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L256
	lfs 0,4(28)
	stfs 0,476(11)
.L256:
	lwz 0,0(3)
	cmpw 0,0,29
	bc 4,2,.L257
	cmpw 0,3,31
	bc 4,2,.L258
	lwz 0,4(3)
	stw 0,pEntityListHead@l(27)
	b .L259
.L258:
	lwz 0,4(3)
	stw 0,4(31)
.L259:
	bl free
	lwz 9,ulCount@l(30)
	li 3,0
	addi 9,9,-1
	stw 9,ulCount@l(30)
	b .L253
.L257:
	mr 31,3
	lwz 3,4(3)
.L253:
	cmpwi 0,3,0
	bc 4,2,.L255
.L254:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 EntityListRemove,.Lfe13-EntityListRemove
	.align 2
	.globl EntityListAdd
	.type	 EntityListAdd,@function
EntityListAdd:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	li 3,8
	bl malloc
	lis 10,ulCount@ha
	lis 11,pEntityListHead@ha
	lwz 9,ulCount@l(10)
	lwz 0,pEntityListHead@l(11)
	addi 9,9,1
	stw 3,pEntityListHead@l(11)
	stw 9,ulCount@l(10)
	stw 29,0(3)
	stw 0,4(3)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 EntityListAdd,.Lfe14-EntityListAdd
	.align 2
	.globl EntityListNumber
	.type	 EntityListNumber,@function
EntityListNumber:
	lis 9,ulCount@ha
	lwz 3,ulCount@l(9)
	blr
.Lfe15:
	.size	 EntityListNumber,.Lfe15-EntityListNumber
	.align 2
	.globl PrintEntityList
	.type	 PrintEntityList,@function
PrintEntityList:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,gi@ha
	lis 3,.LC44@ha
	la 30,gi@l(9)
	la 3,.LC44@l(3)
	lwz 9,4(30)
	li 29,0
	mtlr 9
	crxor 6,6,6
	blrl
	lis 9,pEntityListHead@ha
	lwz 31,pEntityListHead@l(9)
	cmpwi 0,31,0
	bc 12,2,.L270
	lis 27,.LC45@ha
	lis 28,.LC46@ha
.L272:
	lwz 9,0(31)
	la 3,.LC45@l(27)
	addi 29,29,1
	lwz 11,4(30)
	lwz 4,84(9)
	mtlr 11
	addi 4,4,700
	crxor 6,6,6
	blrl
	lwz 9,0(31)
	la 3,.LC46@l(28)
	lwz 11,4(30)
	lwz 4,280(9)
	mtlr 11
	crxor 6,6,6
	blrl
	lwz 31,4(31)
	cmpwi 0,31,0
	bc 4,2,.L272
.L270:
	lis 9,gi+4@ha
	lis 11,ulCount@ha
	lwz 0,gi+4@l(9)
	lis 3,.LC47@ha
	mr 4,29
	la 3,.LC47@l(3)
	lwz 5,ulCount@l(11)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 PrintEntityList,.Lfe16-PrintEntityList
	.align 2
	.globl EntityListHead
	.type	 EntityListHead,@function
EntityListHead:
	lis 9,pEntityListHead@ha
	lwz 0,pEntityListHead@l(9)
	srawi 9,0,31
	xor 3,9,0
	subf 3,3,9
	srawi 3,3,31
	and 3,0,3
	blr
.Lfe17:
	.size	 EntityListHead,.Lfe17-EntityListHead
	.align 2
	.globl EntityListNext
	.type	 EntityListNext,@function
EntityListNext:
	lwz 3,4(3)
	blr
.Lfe18:
	.size	 EntityListNext,.Lfe18-EntityListNext
	.comm	pTempFind,4,4
	.section	".rodata"
	.align 3
.LC48:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl IsVisible
	.type	 IsVisible,@function
IsVisible:
	stwu 1,-128(1)
	mflr 0
	stmw 27,108(1)
	stw 0,132(1)
	lis 9,gi@ha
	mr 31,3
	la 27,gi@l(9)
	mr 30,4
	lwz 9,56(27)
	addi 29,31,4
	addi 28,30,4
	mr 3,29
	mr 4,28
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 12,2,.L41
	lwz 0,48(27)
	lis 5,vec3_origin@ha
	addi 3,1,24
	la 5,vec3_origin@l(5)
	li 9,3
	mr 4,29
	mr 7,28
	mtlr 0
	mr 6,5
	mr 8,31
	blrl
	lfs 11,12(30)
	addi 3,1,8
	lfs 12,12(31)
	lfs 13,4(31)
	lfs 10,4(30)
	fsubs 12,12,11
	lfs 0,8(31)
	lfs 11,8(30)
	fsubs 13,13,10
	stfs 12,16(1)
	fsubs 0,0,11
	stfs 13,8(1)
	stfs 0,12(1)
	bl VectorLength
	fctiwz 0,1
	stfd 0,96(1)
	lwz 9,100(1)
	cmpwi 0,9,999
	bc 12,1,.L41
	lfs 0,32(1)
	lis 9,.LC48@ha
	li 3,1
	la 9,.LC48@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L294
.L41:
	li 3,0
.L294:
	lwz 0,132(1)
	mtlr 0
	lmw 27,108(1)
	la 1,128(1)
	blr
.Lfe19:
	.size	 IsVisible,.Lfe19-IsVisible
	.align 2
	.globl PlayerToFollow
	.type	 PlayerToFollow,@function
PlayerToFollow:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	bl EntityListHead
	li 30,0
	li 29,0
	mr. 31,3
	bc 12,2,.L72
.L74:
	lwz 3,0(31)
	lwz 0,492(3)
	cmpwi 0,0,0
	bc 4,2,.L73
	lwz 9,84(3)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 4,2,.L73
	lwz 0,3520(9)
	cmpwi 0,0,0
	bc 12,2,.L73
	bl NumPlayersVisible
	cmpw 0,3,29
	bc 4,1,.L76
	mr 29,3
	mr 30,31
	b .L73
.L76:
	mfcr 9
	rlwinm 9,9,3,1
	addic 11,3,-1
	subfe 0,11,3
	and. 11,0,9
	bc 12,2,.L73
	lwz 9,0(30)
	lwz 11,0(31)
	lwz 10,84(9)
	lwz 8,84(11)
	lwz 7,3464(10)
	lwz 9,3464(8)
	cmpw 7,7,9
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,31,0
	and 0,30,0
	or 30,0,9
.L73:
	lwz 31,4(31)
	cmpwi 0,31,0
	bc 4,2,.L74
.L72:
	cmpwi 0,30,0
	li 3,0
	bc 12,2,.L81
	lwz 3,0(30)
.L81:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 PlayerToFollow,.Lfe20-PlayerToFollow
	.align 2
	.globl CameraAloneThink
	.type	 CameraAloneThink,@function
CameraAloneThink:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl CameraStaticThink
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe21:
	.size	 CameraAloneThink,.Lfe21-CameraAloneThink
	.align 2
	.globl PointCamAtOrigin
	.type	 PointCamAtOrigin,@function
PointCamAtOrigin:
	stwu 1,-64(1)
	mflr 0
	stmw 29,52(1)
	stw 0,68(1)
	mr 29,3
	mr 9,4
	lfs 9,8(9)
	addi 3,1,8
	addi 4,1,24
	lfs 13,0(9)
	lfs 0,4(9)
	lfs 12,12(29)
	lfs 11,4(29)
	lfs 10,8(29)
	fsubs 9,9,12
	fsubs 13,13,11
	fsubs 0,0,10
	stfs 9,16(1)
	stfs 13,8(1)
	stfs 0,12(1)
	bl vectoangles
	lfs 0,28(1)
	lfs 12,24(1)
	lfs 13,32(1)
	lwz 11,84(29)
	stfs 0,20(29)
	stfs 13,24(29)
	stfs 12,16(29)
	stfs 12,28(11)
	lfs 0,28(1)
	lwz 9,84(29)
	stfs 0,32(9)
	lfs 0,32(1)
	lwz 11,84(29)
	stfs 0,36(11)
	lfs 0,24(1)
	lwz 9,84(29)
	stfs 0,3700(9)
	lfs 0,28(1)
	lwz 11,84(29)
	stfs 0,3704(11)
	lfs 0,32(1)
	lwz 9,84(29)
	stfs 0,3708(9)
	lwz 0,68(1)
	mtlr 0
	lmw 29,52(1)
	la 1,64(1)
	blr
.Lfe22:
	.size	 PointCamAtOrigin,.Lfe22-PointCamAtOrigin
	.align 2
	.globl UpdateValues
	.type	 UpdateValues,@function
UpdateValues:
	lwz 9,84(3)
	lwz 0,3868(9)
	cmpwi 0,0,0
	bclr 4,2
	stw 0,3464(9)
	stw 0,480(3)
	blr
.Lfe23:
	.size	 UpdateValues,.Lfe23-UpdateValues
	.comm	pEntityListHead,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
