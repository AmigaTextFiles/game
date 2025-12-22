	.file	"camclient.c"
gcc2_compiled.:
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
	.string	"camera"
	.align 2
.LC1:
	.string	""
	.section	".text"
	.align 2
	.globl MakeCamera
	.type	 MakeCamera,@function
MakeCamera:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	lis 11,.LC0@ha
	mr 9,3
	la 11,.LC0@l(11)
	lis 10,.LC1@ha
	lwz 25,84(9)
	stw 11,280(9)
	li 0,0
	li 7,1
	la 10,.LC1@l(10)
	li 11,6
	stw 0,552(9)
	li 8,-1
	stw 10,268(9)
	lis 4,0x42b4
	stw 11,260(9)
	lis 5,0x4026
	li 6,0
	stw 8,252(9)
	lis 28,0x4008
	li 29,0
	stw 0,512(9)
	lis 26,0x401c
	li 27,0
	stw 0,508(9)
	li 8,0
	li 24,2
	stw 0,400(9)
	stw 0,248(9)
	stw 0,492(9)
	stw 0,612(9)
	stw 0,608(9)
	stw 7,264(9)
	stw 7,3780(25)
	lwz 11,84(9)
	stw 4,112(11)
	lwz 10,84(9)
	stw 7,3784(10)
	lwz 11,84(9)
	stw 0,3792(11)
	lwz 10,84(9)
	stw 5,3808(10)
	stw 6,3812(10)
	lwz 11,84(9)
	stw 28,3816(11)
	stw 29,3820(11)
	lwz 10,84(9)
	stw 26,3824(10)
	stw 27,3828(10)
	stw 8,476(9)
	stw 0,64(9)
	stw 0,60(9)
	stw 0,40(9)
	stw 0,44(9)
	stw 0,56(9)
	stw 8,16(9)
	lwz 10,84(9)
	stw 8,20(9)
	stw 8,24(9)
	stw 8,28(10)
	lfs 0,20(9)
	lwz 11,84(9)
	stfs 0,32(11)
	lfs 0,24(9)
	lwz 10,84(9)
	stfs 0,36(10)
	lfs 0,16(9)
	lwz 11,84(9)
	stfs 0,3616(11)
	lfs 0,20(9)
	lwz 10,84(9)
	stfs 0,3620(10)
	lfs 0,24(9)
	lwz 8,84(9)
	stfs 0,3624(8)
	lwz 11,84(9)
	stw 0,3476(11)
	lwz 10,84(9)
	stw 0,3480(10)
	lwz 11,84(9)
	stw 24,716(11)
	lwz 10,84(9)
	sth 0,142(10)
	bl Chicken_Camera
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 MakeCamera,.Lfe1-MakeCamera
	.section	".rodata"
	.align 2
.LC2:
	.string	"on"
	.align 2
.LC3:
	.string	"Camera is not allowed\n"
	.align 2
.LC4:
	.string	"You are already a camera\n"
	.align 2
.LC5:
	.string	"You are already an observer\n"
	.align 2
.LC6:
	.string	"follow"
	.align 2
.LC7:
	.string	"normal"
	.align 2
.LC8:
	.string	"chicken"
	.align 2
.LC9:
	.string	"max_xy"
	.align 2
.LC10:
	.string	"Max X/Y delta of %f unchanged!\n"
	.align 2
.LC11:
	.string	"Max X/Y delta of %f. set.\n"
	.align 2
.LC12:
	.string	"max_z"
	.align 2
.LC13:
	.string	"Max Z delta of %f unchanged!\n"
	.align 2
.LC14:
	.string	"Max Z delta of %f set.\n"
	.align 2
.LC15:
	.string	"max_angle"
	.align 2
.LC16:
	.string	"Max Yaw Angle delta of %f unchanged!\n"
	.align 2
.LC17:
	.string	"Max Yaw Angle delta of %f set.\n"
	.align 3
.LC18:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl CameraCmd
	.type	 CameraCmd,@function
CameraCmd:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi@ha
	mr 31,3
	la 30,gi@l(9)
	li 3,1
	lwz 9,160(30)
	mtlr 9
	blrl
	lis 4,.LC2@ha
	la 4,.LC2@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L8
	lis 9,cameraAllowed@ha
	lwz 0,cameraAllowed@l(9)
	cmpwi 0,0,0
	bc 4,2,.L9
	lwz 0,8(30)
	lis 5,.LC3@ha
	mr 3,31
	la 5,.LC3@l(5)
	b .L33
.L9:
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L13
	lwz 0,3780(9)
	cmpwi 0,0,0
	bc 12,2,.L11
	lwz 0,8(30)
	lis 5,.LC4@ha
	mr 3,31
	la 5,.LC4@l(5)
	b .L33
.L11:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 4,2,.L13
	lwz 0,8(30)
	lis 5,.LC5@ha
	mr 3,31
	la 5,.LC5@l(5)
.L33:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L15
.L13:
	mr 3,31
	bl MakeCamera
	b .L15
.L8:
	lwz 9,160(30)
	li 3,1
	mtlr 9
	blrl
	lis 4,.LC6@ha
	la 4,.LC6@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L16
	lwz 9,84(31)
	stw 3,3784(9)
	b .L15
.L16:
	lwz 9,160(30)
	li 3,1
	mtlr 9
	blrl
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L18
	lwz 9,84(31)
	li 0,1
	stw 0,3784(9)
	b .L15
.L18:
	lwz 9,160(30)
	li 3,1
	mtlr 9
	blrl
	lis 4,.LC8@ha
	la 4,.LC8@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L20
	lwz 9,84(31)
	li 0,2
	stw 0,3784(9)
	b .L15
.L20:
	lwz 9,160(30)
	li 3,1
	mtlr 9
	blrl
	lis 4,.LC9@ha
	la 4,.LC9@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L22
	lwz 9,84(31)
	lwz 0,3780(9)
	cmpwi 0,0,0
	bc 12,2,.L22
	lwz 9,160(30)
	li 3,2
	mtlr 9
	blrl
	bl atof
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfd 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L23
	lwz 9,84(31)
	lis 5,.LC10@ha
	mr 3,31
	lwz 0,8(30)
	la 5,.LC10@l(5)
	li 4,2
	lfd 1,3808(9)
	b .L34
.L23:
	lwz 9,84(31)
	lis 5,.LC11@ha
	mr 3,31
	la 5,.LC11@l(5)
	li 4,2
	stfd 1,3808(9)
	lwz 11,84(31)
	lwz 0,8(30)
	lfd 1,3808(11)
	b .L34
.L22:
	lis 9,gi@ha
	li 3,1
	la 30,gi@l(9)
	lwz 9,160(30)
	mtlr 9
	blrl
	lis 4,.LC12@ha
	la 4,.LC12@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L26
	lwz 9,84(31)
	lwz 0,3780(9)
	cmpwi 0,0,0
	bc 12,2,.L26
	lwz 9,160(30)
	li 3,2
	mtlr 9
	blrl
	bl atof
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfd 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L27
	lwz 9,84(31)
	lis 5,.LC13@ha
	mr 3,31
	lwz 0,8(30)
	la 5,.LC13@l(5)
	li 4,2
	lfd 1,3816(9)
	b .L34
.L27:
	lwz 9,84(31)
	lis 5,.LC14@ha
	mr 3,31
	la 5,.LC14@l(5)
	li 4,2
	stfd 1,3816(9)
	lwz 11,84(31)
	lwz 0,8(30)
	lfd 1,3816(11)
	b .L34
.L26:
	lis 9,gi@ha
	li 3,1
	la 30,gi@l(9)
	lwz 9,160(30)
	mtlr 9
	blrl
	lis 4,.LC15@ha
	la 4,.LC15@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L15
	lwz 9,84(31)
	lwz 0,3780(9)
	cmpwi 0,0,0
	bc 12,2,.L15
	lwz 9,160(30)
	li 3,2
	mtlr 9
	blrl
	bl atof
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfd 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L31
	lwz 9,84(31)
	lis 5,.LC16@ha
	mr 3,31
	lwz 0,8(30)
	la 5,.LC16@l(5)
	li 4,2
	lfd 1,3824(9)
.L34:
	mtlr 0
	creqv 6,6,6
	blrl
	b .L15
.L31:
	lwz 9,84(31)
	lis 5,.LC17@ha
	mr 3,31
	la 5,.LC17@l(5)
	li 4,2
	stfd 1,3824(9)
	lwz 11,84(31)
	lwz 0,8(30)
	lfd 1,3824(11)
	mtlr 0
	creqv 6,6,6
	blrl
.L15:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe2:
	.size	 CameraCmd,.Lfe2-CameraCmd
	.section	".rodata"
	.align 3
.LC19:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl NumPlayersVisible
	.type	 NumPlayersVisible,@function
NumPlayersVisible:
	stwu 1,-160(1)
	mflr 0
	stfd 31,152(1)
	stmw 23,116(1)
	stw 0,164(1)
	mr 26,3
	li 25,0
	bl EntityListHead
	mr. 27,3
	bc 12,2,.L42
	lis 9,.LC19@ha
	lis 23,gi@ha
	la 9,.LC19@l(9)
	lis 24,vec3_origin@ha
	lfd 31,0(9)
.L44:
	lwz 31,0(27)
	lwz 9,84(31)
	lwz 0,3780(9)
	cmpwi 0,0,0
	bc 4,2,.L43
	la 28,gi@l(23)
	addi 30,31,4
	lwz 9,56(28)
	addi 29,26,4
	mr 3,30
	mr 4,29
	mtlr 9
	blrl
	cmpwi 0,3,0
	li 0,0
	bc 12,2,.L48
	lwz 0,48(28)
	la 5,vec3_origin@l(24)
	addi 3,1,24
	li 9,3
	mr 4,30
	mtlr 0
	mr 6,5
	mr 7,29
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
	bc 12,1,.L48
	lfs 0,32(1)
	fcmpu 7,0,31
	mfcr 0
	rlwinm 0,0,31,1
.L48:
	addic 9,0,-1
	subfe 9,9,9
	addi 0,25,1
	andc 0,0,9
	and 9,25,9
	or 25,9,0
.L43:
	lwz 27,4(27)
	cmpwi 0,27,0
	bc 4,2,.L44
.L42:
	mr 3,25
	lwz 0,164(1)
	mtlr 0
	lmw 23,116(1)
	lfd 31,152(1)
	la 1,160(1)
	blr
.Lfe3:
	.size	 NumPlayersVisible,.Lfe3-NumPlayersVisible
	.section	".rodata"
	.align 3
.LC20:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC21:
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
	bc 12,2,.L53
.L55:
	lwz 31,0(28)
	lwz 9,84(31)
	lwz 0,3780(9)
	cmpwi 0,0,0
	bc 4,2,.L54
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
	bc 12,2,.L58
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
	bc 12,1,.L58
	lfs 0,48(1)
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfd 13,0(9)
	fcmpu 7,0,13
	mfcr 0
	rlwinm 0,0,31,1
.L58:
	cmpwi 0,0,0
	bc 12,2,.L54
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
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfd 0,0(9)
	fcmpu 0,1,0
	cror 3,2,1
	bc 12,3,.L60
	fctiwz 0,1
	stfd 0,104(1)
	lwz 0,108(1)
	b .L61
.L60:
	fsub 0,1,0
	fctiwz 13,0
	stfd 13,104(1)
	lwz 0,108(1)
	xoris 0,0,0x8000
.L61:
	cmplw 0,0,25
	bc 4,0,.L54
	mr 25,0
	mr 24,28
.L54:
	lwz 28,4(28)
	cmpwi 0,28,0
	bc 4,2,.L55
.L53:
	cmpwi 0,24,0
	li 3,0
	bc 12,2,.L64
	lwz 3,0(24)
.L64:
	lwz 0,148(1)
	mtlr 0
	lmw 24,112(1)
	la 1,144(1)
	blr
.Lfe4:
	.size	 ClosestVisible,.Lfe4-ClosestVisible
	.section	".rodata"
	.align 2
.LC22:
	.long 0x0
	.align 2
.LC23:
	.long 0x43b40000
	.align 3
.LC24:
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
	lwz 9,3788(11)
	lfs 12,8(31)
	lfs 0,4(9)
	lfs 11,12(31)
	fsubs 0,0,13
	stfs 0,8(1)
	lwz 9,3788(11)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,12(1)
	lwz 9,3788(11)
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
	bc 4,1,.L81
	lis 9,.LC22@ha
	lis 11,.LC23@ha
	la 9,.LC22@l(9)
	la 11,.LC23@l(11)
	lfs 12,0(9)
	lfs 13,0(11)
.L82:
	fcmpu 0,10,12
	bc 4,1,.L83
	fsubs 10,10,13
	b .L80
.L83:
	fadds 10,10,13
.L80:
	fmr 0,10
	fctiwz 11,0
	stfd 11,48(1)
	lwz 0,52(1)
	srawi 11,0,31
	xor 9,11,0
	subf 9,11,9
	cmpwi 0,9,180
	bc 12,1,.L82
.L81:
	fmr 13,10
	lis 11,.LC24@ha
	la 11,.LC24@l(11)
	mr 10,9
	lfd 12,0(11)
	lis 8,0x4330
	fctiwz 0,13
	lwz 11,84(31)
	lfd 11,3824(11)
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
	bc 4,1,.L86
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	lfs 0,0(9)
	fcmpu 0,10,0
	bc 4,1,.L87
	lfs 0,20(31)
	fadd 0,0,11
	frsp 0,0
	b .L90
.L87:
	lfs 0,20(31)
	fsub 0,0,11
	frsp 0,0
	b .L90
.L86:
	lfs 0,28(1)
.L90:
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
	stfs 0,3616(11)
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,3620(9)
	lfs 13,24(31)
	lwz 9,84(31)
	stfs 13,3624(9)
	lwz 0,68(1)
	mtlr 0
	lwz 31,60(1)
	la 1,64(1)
	blr
.Lfe5:
	.size	 PointCamAtTarget,.Lfe5-PointCamAtTarget
	.section	".rodata"
	.align 3
.LC25:
	.long 0x3fe99999
	.long 0x9999999a
	.align 2
.LC26:
	.long 0x3f800000
	.align 2
.LC27:
	.long 0xc1000000
	.align 2
.LC28:
	.long 0x40800000
	.align 3
.LC29:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl RepositionAtTarget
	.type	 RepositionAtTarget,@function
RepositionAtTarget:
	stwu 1,-144(1)
	mflr 0
	stmw 28,128(1)
	stw 0,148(1)
	mr 31,3
	mr 30,4
	lwz 9,84(31)
	lwz 9,3788(9)
	lwz 3,84(9)
	cmpwi 0,3,0
	bc 12,2,.L92
	addi 29,1,40
	addi 3,3,3616
	b .L110
.L92:
	addi 29,1,40
	addi 3,9,16
.L110:
	mr 4,29
	li 5,0
	li 6,0
	bl AngleVectors
	mr 3,29
	li 0,0
	addi 29,1,56
	stw 0,48(1)
	mr 28,29
	bl VectorNormalize
	lwz 10,84(31)
	lis 8,gi+48@ha
	li 9,1
	lfs 11,0(30)
	mr 3,29
	li 5,0
	lwz 11,3788(10)
	li 6,0
	addi 7,1,24
	lfs 12,40(1)
	lfs 0,4(11)
	lfs 13,4(30)
	lfs 10,44(1)
	fmadds 11,11,12,0
	lwz 0,gi+48@l(8)
	lfs 12,8(30)
	mtlr 0
	stfs 11,24(1)
	lwz 11,3788(10)
	lfs 0,8(11)
	fmadds 13,13,10,0
	stfs 13,28(1)
	lwz 11,3788(10)
	lfs 0,12(11)
	fadds 0,0,12
	stfs 0,32(1)
	lwz 4,3788(10)
	mr 8,4
	addi 4,4,4
	blrl
	lis 9,.LC26@ha
	lfs 13,64(1)
	la 9,.LC26@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L94
	lwz 11,84(31)
	addi 3,1,8
	lfs 0,68(1)
	lwz 9,3788(11)
	lfs 13,72(1)
	lfs 12,4(9)
	lfs 11,76(1)
	fsubs 0,0,12
	stfs 0,8(1)
	lwz 9,3788(11)
	lfs 0,8(9)
	fsubs 13,13,0
	stfs 13,12(1)
	lwz 9,3788(11)
	lfs 0,12(9)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorNormalize
	lis 9,.LC27@ha
	addi 3,1,68
	la 9,.LC27@l(9)
	addi 4,1,8
	lfs 1,0(9)
	mr 5,3
	bl VectorMA
	lfs 0,88(1)
	lis 9,.LC25@ha
	lfd 13,.LC25@l(9)
	fcmpu 0,0,13
	bc 4,1,.L94
	lis 9,.LC28@ha
	lfs 0,76(1)
	la 9,.LC28@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,76(1)
.L94:
	lfs 9,68(1)
	lis 9,.LC29@ha
	lfs 10,4(31)
	la 9,.LC29@l(9)
	mr 10,11
	lfd 12,0(9)
	lis 8,0x4330
	lwz 9,84(31)
	fsubs 0,9,10
	lfd 11,3808(9)
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
	bc 4,1,.L96
	fcmpu 0,9,10
	bc 4,1,.L97
	fmr 0,10
	fadd 0,0,11
	b .L111
.L97:
	fmr 0,10
	fsub 0,0,11
.L111:
	frsp 0,0
	stfs 0,4(31)
	b .L99
.L96:
	stfs 9,4(31)
.L99:
	lfs 9,72(1)
	lis 9,.LC29@ha
	lfs 10,8(31)
	la 9,.LC29@l(9)
	mr 10,11
	lfd 12,0(9)
	lis 8,0x4330
	lwz 9,84(31)
	fsubs 0,9,10
	lfd 11,3808(9)
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
	bc 4,1,.L100
	fcmpu 0,9,10
	bc 4,1,.L101
	fmr 0,10
	fadd 0,0,11
	b .L112
.L101:
	fmr 0,10
	fsub 0,0,11
.L112:
	frsp 0,0
	stfs 0,8(31)
	b .L103
.L100:
	stfs 9,8(31)
.L103:
	lfs 9,76(1)
	lis 9,.LC29@ha
	lfs 10,12(31)
	la 9,.LC29@l(9)
	mr 10,11
	lfd 12,0(9)
	lis 8,0x4330
	lwz 9,84(31)
	fsubs 0,9,10
	lfd 11,3816(9)
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
	bc 4,1,.L104
	fcmpu 0,9,10
	bc 4,1,.L105
	fmr 0,10
	fadd 0,0,11
	b .L113
.L105:
	fmr 0,10
	fsub 0,0,11
.L113:
	frsp 0,0
	stfs 0,12(31)
	b .L107
.L104:
	stfs 9,12(31)
.L107:
	lwz 11,84(31)
	lis 9,gi+48@ha
	mr 3,28
	lwz 0,gi+48@l(9)
	li 5,0
	li 6,0
	lwz 4,3788(11)
	li 9,1
	addi 7,31,4
	mtlr 0
	mr 8,4
	addi 4,4,4
	blrl
	lis 9,.LC26@ha
	lfs 13,64(1)
	la 9,.LC26@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L108
	lwz 11,84(31)
	addi 3,1,8
	lfs 0,68(1)
	lwz 9,3788(11)
	lfs 13,72(1)
	lfs 12,4(9)
	lfs 11,76(1)
	fsubs 0,0,12
	stfs 0,8(1)
	lwz 9,3788(11)
	lfs 0,8(9)
	fsubs 13,13,0
	stfs 13,12(1)
	lwz 9,3788(11)
	lfs 0,12(9)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorNormalize
	lis 9,.LC27@ha
	addi 3,1,68
	la 9,.LC27@l(9)
	addi 4,1,8
	lfs 1,0(9)
	mr 5,3
	bl VectorMA
	lfs 0,88(1)
	lis 9,.LC25@ha
	lfd 13,.LC25@l(9)
	fcmpu 0,0,13
	bc 4,1,.L109
	lis 9,.LC28@ha
	lfs 0,76(1)
	la 9,.LC28@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,76(1)
.L109:
	lfs 0,68(1)
	lfs 12,72(1)
	lfs 13,76(1)
	stfs 0,4(31)
	stfs 12,8(31)
	stfs 13,12(31)
.L108:
	lwz 0,148(1)
	mtlr 0
	lmw 28,128(1)
	la 1,144(1)
	blr
.Lfe6:
	.size	 RepositionAtTarget,.Lfe6-RepositionAtTarget
	.section	".rodata"
	.align 3
.LC30:
	.long 0x3fe99999
	.long 0x9999999a
	.align 2
.LC31:
	.long 0x42200000
	.align 2
.LC32:
	.long 0x41f00000
	.align 2
.LC33:
	.long 0x3f800000
	.align 2
.LC34:
	.long 0xc1000000
	.align 2
.LC35:
	.long 0x40800000
	.align 3
.LC36:
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
	lis 9,.LC31@ha
	mr 30,4
	la 9,.LC31@l(9)
	lfs 12,0(30)
	mr 31,3
	lfs 11,0(9)
	addi 3,1,24
	lis 9,.LC32@ha
	lfs 13,4(30)
	li 5,0
	la 9,.LC32@l(9)
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
	lwz 8,3788(11)
	blrl
	lis 9,.LC33@ha
	lfs 13,32(1)
	la 9,.LC33@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L115
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
	lis 9,.LC34@ha
	addi 3,1,36
	la 9,.LC34@l(9)
	mr 4,29
	lfs 1,0(9)
	mr 5,3
	bl VectorMA
	lfs 0,56(1)
	lis 9,.LC30@ha
	lfd 13,.LC30@l(9)
	fcmpu 0,0,13
	bc 4,1,.L115
	lis 9,.LC35@ha
	lfs 0,44(1)
	la 9,.LC35@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,44(1)
.L115:
	lfs 9,36(1)
	lis 9,.LC36@ha
	lfs 10,4(31)
	la 9,.LC36@l(9)
	mr 10,11
	lfd 12,0(9)
	lis 8,0x4330
	lwz 9,84(31)
	fsubs 0,9,10
	lfd 11,3808(9)
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
	bc 4,1,.L117
	fcmpu 0,9,10
	bc 4,1,.L118
	fmr 0,10
	fadd 0,0,11
	b .L131
.L118:
	fmr 0,10
	fsub 0,0,11
.L131:
	frsp 0,0
	stfs 0,4(31)
	b .L120
.L117:
	stfs 9,4(31)
.L120:
	lfs 9,40(1)
	lis 9,.LC36@ha
	lfs 10,8(31)
	la 9,.LC36@l(9)
	mr 10,11
	lfd 12,0(9)
	lis 8,0x4330
	lwz 9,84(31)
	fsubs 0,9,10
	lfd 11,3808(9)
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
	bc 4,1,.L121
	fcmpu 0,9,10
	bc 4,1,.L122
	fmr 0,10
	fadd 0,0,11
	b .L132
.L122:
	fmr 0,10
	fsub 0,0,11
.L132:
	frsp 0,0
	stfs 0,8(31)
	b .L124
.L121:
	stfs 9,8(31)
.L124:
	lfs 9,44(1)
	lis 9,.LC36@ha
	lfs 10,12(31)
	la 9,.LC36@l(9)
	mr 10,11
	lfd 12,0(9)
	lis 8,0x4330
	lwz 9,84(31)
	fsubs 0,9,10
	lfd 11,3816(9)
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
	bc 4,1,.L125
	fcmpu 0,9,10
	bc 4,1,.L126
	fmr 0,10
	fadd 0,0,11
	b .L133
.L126:
	fmr 0,10
	fsub 0,0,11
.L133:
	frsp 0,0
	stfs 0,12(31)
	b .L128
.L125:
	stfs 9,12(31)
.L128:
	lis 9,gi+48@ha
	lwz 11,84(31)
	mr 3,28
	lwz 0,gi+48@l(9)
	mr 4,30
	li 5,0
	li 9,1
	lwz 8,3788(11)
	li 6,0
	addi 7,31,4
	mtlr 0
	blrl
	lis 9,.LC33@ha
	lfs 13,32(1)
	la 9,.LC33@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L129
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
	lis 9,.LC34@ha
	addi 3,1,36
	la 9,.LC34@l(9)
	mr 4,29
	lfs 1,0(9)
	mr 5,3
	bl VectorMA
	lfs 0,56(1)
	lis 9,.LC30@ha
	lfd 13,.LC30@l(9)
	fcmpu 0,0,13
	bc 4,1,.L130
	lis 9,.LC35@ha
	lfs 0,44(1)
	la 9,.LC35@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,44(1)
.L130:
	lfs 0,36(1)
	lfs 12,40(1)
	lfs 13,44(1)
	stfs 0,4(31)
	stfs 12,8(31)
	stfs 13,12(31)
.L129:
	lwz 0,148(1)
	mtlr 0
	lmw 28,128(1)
	la 1,144(1)
	blr
.Lfe7:
	.size	 RepositionAtOrigin,.Lfe7-RepositionAtOrigin
	.align 2
	.globl CameraFollowThink
	.type	 CameraFollowThink,@function
CameraFollowThink:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 29,3
	li 30,0
	bl EntityListHead
	li 28,0
	mr. 31,3
	bc 12,2,.L153
.L146:
	lwz 3,0(31)
	lwz 0,492(3)
	cmpwi 0,0,0
	bc 4,2,.L152
	lwz 9,84(3)
	lwz 0,3780(9)
	cmpwi 0,0,0
	bc 4,2,.L152
	bl NumPlayersVisible
	cmpw 0,3,28
	bc 4,1,.L148
	mr 28,3
	mr 30,31
	b .L152
.L148:
	mfcr 9
	rlwinm 9,9,3,1
	addic 11,3,-1
	subfe 0,11,3
	and. 11,0,9
	bc 12,2,.L152
	lwz 9,0(30)
	lwz 11,0(31)
	lwz 10,84(9)
	lwz 8,84(11)
	lwz 7,3424(10)
	lwz 9,3424(8)
	cmpw 7,7,9
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,31,0
	and 0,30,0
	or 30,0,9
.L152:
	lwz 31,4(31)
	cmpwi 0,31,0
	bc 4,2,.L146
.L153:
	cmpwi 0,30,0
	li 0,0
	bc 12,2,.L155
	lwz 0,0(30)
.L155:
	lwz 9,84(29)
	cmpwi 0,0,0
	stw 0,3788(9)
	bc 12,2,.L143
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
.L143:
	lwz 9,84(29)
	lwz 7,3788(9)
	mr 11,9
	cmpwi 0,7,0
	bc 12,2,.L156
	lwz 9,84(7)
	cmpwi 0,9,0
	bc 12,2,.L156
	lwz 0,3424(9)
	stw 0,3424(11)
	lwz 11,480(7)
	lwz 8,84(29)
	stw 11,480(29)
	lwz 9,84(7)
	lwz 0,3492(9)
	stw 0,3492(8)
	lwz 10,84(29)
	lwz 11,84(7)
	lwz 0,3492(10)
	addi 11,11,740
	addi 10,10,740
	slwi 0,0,2
	lwzx 9,11,0
	stwx 9,10,0
	b .L158
.L156:
	li 0,0
	li 9,999
	stw 0,3424(11)
	stw 9,480(29)
.L158:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe8:
	.size	 CameraFollowThink,.Lfe8-CameraFollowThink
	.section	".rodata"
	.align 3
.LC37:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC38:
	.long 0x40000000
	.align 2
.LC39:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl CameraNormalThink
	.type	 CameraNormalThink,@function
CameraNormalThink:
	stwu 1,-144(1)
	mflr 0
	stmw 26,120(1)
	stw 0,148(1)
	mr 30,3
	bl NumPlayersVisible
	lis 9,pDeadPlayer@ha
	mr 26,3
	lwz 31,pDeadPlayer@l(9)
	cmpwi 0,31,0
	bc 12,2,.L160
	lis 9,gi@ha
	addi 29,30,4
	la 27,gi@l(9)
	addi 28,31,4
	lwz 9,56(27)
	mr 3,29
	mr 4,28
	mtlr 9
	blrl
	cmpwi 0,3,0
	li 0,0
	bc 12,2,.L162
	lwz 0,48(27)
	lis 5,vec3_origin@ha
	addi 3,1,40
	la 5,vec3_origin@l(5)
	li 9,3
	mtlr 0
	mr 4,29
	mr 7,28
	mr 6,5
	mr 8,30
	blrl
	lfs 13,4(31)
	addi 3,1,24
	lfs 0,4(30)
	lfs 12,8(30)
	lfs 11,12(30)
	fsubs 0,0,13
	stfs 0,24(1)
	lfs 13,8(31)
	fsubs 12,12,13
	stfs 12,28(1)
	lfs 0,12(31)
	fsubs 11,11,0
	stfs 11,32(1)
	bl VectorLength
	li 0,0
	fctiwz 0,1
	stfd 0,112(1)
	lwz 9,116(1)
	cmpwi 0,9,999
	bc 12,1,.L162
	lfs 0,48(1)
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lfd 13,0(9)
	fcmpu 7,0,13
	mfcr 0
	rlwinm 0,0,31,1
.L162:
	cmpwi 0,0,0
	bc 12,2,.L160
	lis 9,pDeadPlayer@ha
	lwz 11,84(30)
	li 0,1
	lwz 10,pDeadPlayer@l(9)
	lis 8,level+4@ha
	mr 3,30
	lis 9,.LC38@ha
	stw 0,3792(11)
	la 9,.LC38@l(9)
	lfs 13,0(9)
	lwz 9,84(30)
	stw 10,3788(9)
	lfs 0,level+4@l(8)
	fadds 0,0,13
	stfs 0,476(30)
	bl PointCamAtTarget
	b .L164
.L160:
	lwz 11,84(30)
	lwz 0,3792(11)
	cmpwi 0,0,0
	bc 12,2,.L165
	lis 9,level+4@ha
	lfs 13,476(30)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L166
	li 0,0
	stw 0,3792(11)
	b .L164
.L166:
	lwz 9,3788(11)
	lwz 0,492(9)
	cmpwi 0,0,0
	bc 12,2,.L168
	lfs 0,4(9)
	stfs 0,3796(11)
	lwz 11,84(30)
	lwz 9,3788(11)
	lfs 0,8(9)
	stfs 0,3800(11)
	lwz 10,84(30)
	lwz 9,3788(10)
	lfs 0,12(9)
	stfs 0,3804(10)
.L168:
	lwz 9,84(30)
	addi 4,1,40
	addi 3,1,24
	lfs 0,4(30)
	lfs 13,3796(9)
	lfs 12,8(30)
	addi 9,9,3796
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
	stfs 0,3616(9)
	lfs 0,44(1)
	lwz 11,84(30)
	stfs 0,3620(11)
	lfs 0,48(1)
	lwz 9,84(30)
	stfs 0,3624(9)
	lwz 4,84(30)
	addi 4,4,3796
	bl RepositionAtOrigin
	b .L164
.L165:
	cmpwi 0,26,1
	bc 12,1,.L171
	lis 9,level+4@ha
	lfs 13,476(30)
	lis 11,0xc270
	lfs 0,level+4@l(9)
	lis 0,0x4220
	stw 11,12(1)
	stw 0,16(1)
	fcmpu 0,13,0
	stw 11,8(1)
	cror 3,2,1
	bc 4,3,.L172
	bl EntityListHead
	li 29,0
	li 28,0
	mr. 31,3
	bc 12,2,.L183
.L176:
	lwz 3,0(31)
	lwz 0,492(3)
	cmpwi 0,0,0
	bc 4,2,.L182
	lwz 9,84(3)
	lwz 0,3780(9)
	cmpwi 0,0,0
	bc 4,2,.L182
	bl NumPlayersVisible
	cmpw 0,3,28
	bc 4,1,.L178
	mr 28,3
	mr 29,31
	b .L182
.L178:
	mfcr 9
	rlwinm 9,9,3,1
	addic 11,3,-1
	subfe 0,11,3
	and. 11,0,9
	bc 12,2,.L182
	lwz 9,0(29)
	lwz 11,0(31)
	lwz 10,84(9)
	lwz 8,84(11)
	lwz 7,3424(10)
	lwz 9,3424(8)
	cmpw 7,7,9
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,31,0
	and 0,29,0
	or 29,0,9
.L182:
	lwz 31,4(31)
	cmpwi 0,31,0
	bc 4,2,.L176
.L183:
	cmpwi 0,29,0
	li 0,0
	bc 12,2,.L185
	lwz 0,0(29)
.L185:
	lwz 9,84(30)
	cmpwi 0,0,0
	stw 0,3788(9)
	bc 12,2,.L173
	lwz 9,84(30)
	lwz 3,3788(9)
	bl NumPlayersVisible
	cmpwi 0,3,1
	bc 4,1,.L173
	mr 3,30
	addi 4,1,8
	b .L237
.L173:
	mr 3,30
	bl ClosestVisible
	lwz 9,84(30)
	cmpwi 0,3,0
	stw 3,3788(9)
	bc 12,2,.L187
	mr 3,30
	addi 4,1,8
	b .L237
.L187:
	bl EntityListHead
	li 29,0
	li 28,0
	mr. 31,3
	bc 12,2,.L199
.L192:
	lwz 3,0(31)
	lwz 0,492(3)
	cmpwi 0,0,0
	bc 4,2,.L198
	lwz 9,84(3)
	lwz 0,3780(9)
	cmpwi 0,0,0
	bc 4,2,.L198
	bl NumPlayersVisible
	cmpw 0,3,28
	bc 4,1,.L194
	mr 28,3
	mr 29,31
	b .L198
.L194:
	mfcr 9
	rlwinm 9,9,3,1
	addic 11,3,-1
	subfe 0,11,3
	and. 11,0,9
	bc 12,2,.L198
	lwz 9,0(29)
	lwz 11,0(31)
	lwz 10,84(9)
	lwz 8,84(11)
	lwz 7,3424(10)
	lwz 9,3424(8)
	cmpw 7,7,9
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,31,0
	and 0,29,0
	or 29,0,9
.L198:
	lwz 31,4(31)
	cmpwi 0,31,0
	bc 4,2,.L192
.L199:
	cmpwi 0,29,0
	li 0,0
	bc 12,2,.L201
	lwz 0,0(29)
.L201:
	lwz 9,84(30)
	cmpwi 0,0,0
	stw 0,3788(9)
	bc 12,2,.L164
	mr 3,30
	addi 4,1,8
	bl RepositionAtTarget
	mr 3,30
	bl PointCamAtTarget
	li 0,0
	stw 0,476(30)
	b .L164
.L172:
	bl EntityListHead
	li 29,0
	li 28,0
	mr. 31,3
	bc 12,2,.L213
.L206:
	lwz 3,0(31)
	lwz 0,492(3)
	cmpwi 0,0,0
	bc 4,2,.L212
	lwz 9,84(3)
	lwz 0,3780(9)
	cmpwi 0,0,0
	bc 4,2,.L212
	bl NumPlayersVisible
	cmpw 0,3,28
	bc 4,1,.L208
	mr 28,3
	mr 29,31
	b .L212
.L208:
	mfcr 9
	rlwinm 9,9,3,1
	addic 11,3,-1
	subfe 0,11,3
	and. 11,0,9
	bc 12,2,.L212
	lwz 9,0(29)
	lwz 11,0(31)
	lwz 10,84(9)
	lwz 8,84(11)
	lwz 7,3424(10)
	lwz 9,3424(8)
	cmpw 7,7,9
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,31,0
	and 0,29,0
	or 29,0,9
.L212:
	lwz 31,4(31)
	cmpwi 0,31,0
	bc 4,2,.L206
.L213:
	cmpwi 0,29,0
	li 0,0
	bc 12,2,.L215
	lwz 0,0(29)
.L215:
	lwz 9,84(30)
	cmpwi 0,0,0
	stw 0,3788(9)
	bc 12,2,.L164
	lis 0,0xc270
	lis 9,0x4220
	mr 3,30
	stw 0,12(1)
	addi 4,1,8
	stw 9,16(1)
	stw 0,8(1)
.L237:
	bl RepositionAtTarget
	mr 3,30
	bl PointCamAtTarget
	b .L164
.L171:
	lis 9,level+4@ha
	lfs 13,476(30)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L217
	bl EntityListHead
	li 29,0
	li 28,0
	mr. 31,3
	bc 12,2,.L228
.L221:
	lwz 3,0(31)
	lwz 0,492(3)
	cmpwi 0,0,0
	bc 4,2,.L227
	lwz 9,84(3)
	lwz 0,3780(9)
	cmpwi 0,0,0
	bc 4,2,.L227
	bl NumPlayersVisible
	cmpw 0,3,28
	bc 4,1,.L223
	mr 28,3
	mr 29,31
	b .L227
.L223:
	mfcr 9
	rlwinm 9,9,3,1
	addic 11,3,-1
	subfe 0,11,3
	and. 11,0,9
	bc 12,2,.L227
	lwz 9,0(29)
	lwz 11,0(31)
	lwz 10,84(9)
	lwz 8,84(11)
	lwz 7,3424(10)
	lwz 9,3424(8)
	cmpw 7,7,9
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,31,0
	and 0,29,0
	or 29,0,9
.L227:
	lwz 31,4(31)
	cmpwi 0,31,0
	bc 4,2,.L221
.L228:
	cmpwi 0,29,0
	li 0,0
	bc 12,2,.L230
	lwz 0,0(29)
.L230:
	lwz 9,84(30)
	cmpwi 0,0,0
	stw 0,3788(9)
	bc 12,2,.L164
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
	lis 11,.LC39@ha
	lis 9,level+4@ha
	la 11,.LC39@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,476(30)
	b .L164
.L217:
	lwz 0,3788(11)
	cmpwi 0,0,0
	bc 12,2,.L164
	mr 3,30
	bl PointCamAtTarget
.L164:
	lwz 11,84(30)
	lis 9,pDeadPlayer@ha
	li 0,0
	stw 0,pDeadPlayer@l(9)
	lwz 7,3788(11)
	cmpwi 0,7,0
	bc 12,2,.L159
	lwz 9,84(7)
	cmpwi 0,9,0
	bc 12,2,.L234
	lwz 0,3424(9)
	stw 0,3424(11)
	lwz 11,480(7)
	lwz 8,84(30)
	stw 11,480(30)
	lwz 9,84(7)
	lwz 0,3492(9)
	stw 0,3492(8)
	lwz 10,84(30)
	lwz 11,84(7)
	lwz 0,3492(10)
	addi 11,11,740
	addi 10,10,740
	slwi 0,0,2
	lwzx 9,11,0
	stwx 9,10,0
	b .L159
.L234:
	stw 9,3424(11)
	li 0,999
	stw 0,480(30)
.L159:
	lwz 0,148(1)
	mtlr 0
	lmw 26,120(1)
	la 1,144(1)
	blr
.Lfe9:
	.size	 CameraNormalThink,.Lfe9-CameraNormalThink
	.section	".rodata"
	.align 2
.LC40:
	.long 0x471c4000
	.align 2
.LC41:
	.long 0x432f0000
	.align 2
.LC42:
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
	lis 9,.LC40@ha
	lfs 13,12(31)
	lis 29,gi@ha
	addi 28,1,72
	lfs 0,.LC40@l(9)
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
	lis 9,.LC41@ha
	lfs 11,28(1)
	mr 4,28
	la 9,.LC41@l(9)
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
	bc 4,0,.L239
	lis 9,.LC42@ha
	lwz 10,84(31)
	lis 11,0x4234
	la 9,.LC42@l(9)
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
	stfs 0,3616(9)
	lfs 0,20(31)
	lwz 11,84(31)
	stfs 0,3620(11)
	lfs 13,24(31)
	lwz 9,84(31)
	stfs 13,3624(9)
.L239:
	lwz 0,132(1)
	mtlr 0
	lmw 28,112(1)
	la 1,128(1)
	blr
.Lfe10:
	.size	 CameraStaticThink,.Lfe10-CameraStaticThink
	.section	".rodata"
	.align 2
.LC43:
	.string	"Now showing %s\n"
	.align 3
.LC44:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CameraThink
	.type	 CameraThink,@function
CameraThink:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 27,52(1)
	stw 0,84(1)
	mr 29,4
	mr 31,3
	lbz 0,1(29)
	andi. 9,0,1
	bc 12,2,.L241
	lwz 9,84(31)
	lwz 0,3500(9)
	andi. 10,0,1
	bc 4,2,.L241
	lwz 0,3784(9)
	cmpwi 0,0,2
	bc 12,2,.L241
	bl EntityListHead
	li 30,0
	lis 27,maxclients@ha
	b .L268
.L244:
	bl EntityListNext
.L268:
	lwz 9,84(31)
	lwz 9,3788(9)
	cmpwi 0,9,0
	bc 12,2,.L243
	lwz 0,0(3)
	cmpw 0,0,9
	bc 4,2,.L244
.L243:
	bl EntityListNext
	mr. 3,3
	bc 4,2,.L247
	bl EntityListHead
.L247:
	lis 9,.LC44@ha
	lis 28,0x4330
	la 9,.LC44@l(9)
	lfd 31,0(9)
.L252:
	lwz 9,0(3)
	lwz 0,248(9)
	cmpwi 0,0,0
	bc 4,2,.L249
	bl EntityListNext
	mr. 3,3
	bc 4,2,.L251
	bl EntityListHead
.L251:
	addi 30,30,1
	lwz 11,maxclients@l(27)
	xoris 0,30,0x8000
	stw 0,44(1)
	stw 28,40(1)
	lfd 0,40(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L252
.L249:
	xoris 0,30,0x8000
	lis 11,0x4330
	stw 0,44(1)
	lis 10,.LC44@ha
	la 10,.LC44@l(10)
	stw 11,40(1)
	lfd 12,0(10)
	lfd 0,40(1)
	lis 10,maxclients@ha
	lwz 11,maxclients@l(10)
	fsub 0,0,12
	lfs 13,20(11)
	frsp 0,0
	fcmpu 0,0,13
	bc 4,0,.L241
	lwz 0,0(3)
	lis 10,gi+8@ha
	lis 5,.LC43@ha
	lwz 9,84(31)
	la 5,.LC43@l(5)
	mr 3,31
	li 4,2
	stw 0,3788(9)
	lwz 11,84(31)
	lwz 0,gi+8@l(10)
	lwz 9,3788(11)
	mtlr 0
	lwz 6,84(9)
	addi 6,6,700
	crxor 6,6,6
	blrl
.L241:
	lwz 11,84(31)
	li 10,4
	li 8,0
	lbz 0,1(29)
	stw 0,3500(11)
	lwz 9,84(31)
	stw 10,0(9)
	lwz 11,84(31)
	sth 8,18(11)
	bl EntityListNumber
	cmpwi 0,3,0
	bc 4,2,.L254
	mr 3,31
	mr 4,29
	bl CameraStaticThink
	b .L255
.L254:
	lwz 9,84(31)
	lwz 0,3784(9)
	cmpwi 0,0,1
	bc 12,2,.L265
	bc 12,1,.L267
	cmpwi 0,0,0
	bc 12,2,.L257
	b .L265
.L267:
	cmpwi 0,0,2
	bc 12,2,.L258
	b .L265
.L257:
	mr 3,31
	mr 4,29
	bl CameraFollowThink
	b .L255
.L258:
	mr 3,31
	bl Chicken_Follow
	lwz 9,84(31)
	cmpwi 0,3,0
	stw 3,3788(9)
	bc 12,2,.L259
	lis 0,0xc270
	lis 9,0x4220
	mr 3,31
	stw 0,12(1)
	addi 4,1,8
	stw 9,16(1)
	stw 0,8(1)
	bl RepositionAtTarget
	mr 3,31
	bl PointCamAtTarget
.L259:
	lwz 9,84(31)
	lwz 7,3788(9)
	mr 11,9
	cmpwi 0,7,0
	bc 12,2,.L260
	lwz 9,84(7)
	cmpwi 0,9,0
	bc 12,2,.L260
	lwz 0,3424(9)
	stw 0,3424(11)
	lwz 11,480(7)
	lwz 8,84(31)
	stw 11,480(31)
	lwz 9,84(7)
	lwz 0,3492(9)
	stw 0,3492(8)
	lwz 10,84(31)
	lwz 11,84(7)
	lwz 0,3492(10)
	addi 11,11,740
	addi 10,10,740
	slwi 0,0,2
	lwzx 9,11,0
	stwx 9,10,0
	b .L255
.L260:
	li 0,0
	li 9,999
	stw 0,3424(11)
	stw 9,480(31)
	b .L255
.L265:
	mr 3,31
	mr 4,29
	bl CameraNormalThink
.L255:
	lwz 0,84(1)
	mtlr 0
	lmw 27,52(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe11:
	.size	 CameraThink,.Lfe11-CameraThink
	.globl ulCount
	.section	".sdata","aw"
	.align 2
	.type	 ulCount,@object
	.size	 ulCount,4
ulCount:
	.long 0
	.section	".rodata"
	.align 2
.LC45:
	.string	"PrintEntityList\n"
	.align 2
.LC46:
	.string	"Name: %s "
	.align 2
.LC47:
	.string	"Class: %s\n"
	.align 2
.LC48:
	.string	"Actual Count: %d List Count %d\n"
	.align 2
.LC49:
	.string	"Name: %s\n"
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
	b .L293
.L295:
	lwz 11,0(31)
	lis 9,gi+4@ha
	lis 3,.LC49@ha
	lwz 0,gi+4@l(9)
	la 3,.LC49@l(3)
	lwz 4,84(11)
	mtlr 0
	addi 4,4,700
	crxor 6,6,6
	blrl
	lwz 11,pEntityListHead@l(30)
	lwz 29,0(31)
	cmpwi 0,11,0
	mr 31,11
	bc 12,2,.L293
	lis 9,level@ha
	lis 30,ulCount@ha
	la 28,level@l(9)
.L301:
	lwz 10,0(11)
	mr 3,11
	cmpw 7,11,31
	lwz 9,84(10)
	lwz 0,3780(9)
	cmpwi 0,0,0
	bc 12,2,.L302
	lfs 0,4(28)
	stfs 0,476(10)
.L302:
	lwz 0,0(11)
	cmpw 0,0,29
	bc 4,2,.L303
	bc 4,30,.L304
	lwz 0,4(11)
	stw 0,pEntityListHead@l(27)
	b .L305
.L304:
	lwz 0,4(11)
	stw 0,4(31)
.L305:
	bl free
	lwz 9,ulCount@l(30)
	li 11,0
	addi 9,9,-1
	stw 9,ulCount@l(30)
	b .L299
.L303:
	mr 31,11
	lwz 11,4(11)
.L299:
	cmpwi 0,11,0
	bc 4,2,.L301
.L293:
	lis 30,pEntityListHead@ha
	lwz 9,pEntityListHead@l(30)
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	and. 31,9,0
	bc 4,2,.L295
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 EnitityListClean,.Lfe12-EnitityListClean
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
.Lfe13:
	.size	 PlayerDied,.Lfe13-PlayerDied
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
	bc 12,2,.L271
	lis 9,level@ha
	lis 30,ulCount@ha
	la 28,level@l(9)
.L272:
	lwz 11,0(3)
	lwz 9,84(11)
	lwz 0,3780(9)
	cmpwi 0,0,0
	bc 12,2,.L273
	lfs 0,4(28)
	stfs 0,476(11)
.L273:
	lwz 0,0(3)
	cmpw 0,0,29
	bc 4,2,.L274
	cmpw 0,3,31
	bc 4,2,.L275
	lwz 0,4(3)
	stw 0,pEntityListHead@l(27)
	b .L276
.L275:
	lwz 0,4(3)
	stw 0,4(31)
.L276:
	bl free
	lwz 9,ulCount@l(30)
	li 3,0
	addi 9,9,-1
	stw 9,ulCount@l(30)
	b .L270
.L274:
	mr 31,3
	lwz 3,4(3)
.L270:
	cmpwi 0,3,0
	bc 4,2,.L272
.L271:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 EntityListRemove,.Lfe14-EntityListRemove
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
.Lfe15:
	.size	 EntityListAdd,.Lfe15-EntityListAdd
	.align 2
	.globl EntityListNumber
	.type	 EntityListNumber,@function
EntityListNumber:
	lis 9,ulCount@ha
	lwz 3,ulCount@l(9)
	blr
.Lfe16:
	.size	 EntityListNumber,.Lfe16-EntityListNumber
	.align 2
	.globl PrintEntityList
	.type	 PrintEntityList,@function
PrintEntityList:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,gi@ha
	lis 3,.LC45@ha
	la 30,gi@l(9)
	la 3,.LC45@l(3)
	lwz 9,4(30)
	li 29,0
	mtlr 9
	crxor 6,6,6
	blrl
	lis 9,pEntityListHead@ha
	lwz 31,pEntityListHead@l(9)
	cmpwi 0,31,0
	bc 12,2,.L287
	lis 27,.LC46@ha
	lis 28,.LC47@ha
.L289:
	lwz 9,0(31)
	la 3,.LC46@l(27)
	addi 29,29,1
	lwz 11,4(30)
	lwz 4,84(9)
	mtlr 11
	addi 4,4,700
	crxor 6,6,6
	blrl
	lwz 9,0(31)
	la 3,.LC47@l(28)
	lwz 11,4(30)
	lwz 4,280(9)
	mtlr 11
	crxor 6,6,6
	blrl
	lwz 31,4(31)
	cmpwi 0,31,0
	bc 4,2,.L289
.L287:
	lis 9,gi+4@ha
	lis 11,ulCount@ha
	lwz 0,gi+4@l(9)
	lis 3,.LC48@ha
	mr 4,29
	la 3,.LC48@l(3)
	lwz 5,ulCount@l(11)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 PrintEntityList,.Lfe17-PrintEntityList
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
.Lfe18:
	.size	 EntityListHead,.Lfe18-EntityListHead
	.align 2
	.globl EntityListNext
	.type	 EntityListNext,@function
EntityListNext:
	lwz 3,4(3)
	blr
.Lfe19:
	.size	 EntityListNext,.Lfe19-EntityListNext
	.comm	pTempFind,4,4
	.section	".rodata"
	.align 3
.LC50:
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
	bc 12,2,.L39
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
	bc 12,1,.L39
	lfs 0,32(1)
	lis 9,.LC50@ha
	li 3,1
	la 9,.LC50@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L311
.L39:
	li 3,0
.L311:
	lwz 0,132(1)
	mtlr 0
	lmw 27,108(1)
	la 1,128(1)
	blr
.Lfe20:
	.size	 IsVisible,.Lfe20-IsVisible
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
	bc 12,2,.L68
.L70:
	lwz 3,0(31)
	lwz 0,492(3)
	cmpwi 0,0,0
	bc 4,2,.L69
	lwz 9,84(3)
	lwz 0,3780(9)
	cmpwi 0,0,0
	bc 4,2,.L69
	bl NumPlayersVisible
	cmpw 0,3,29
	bc 4,1,.L72
	mr 29,3
	mr 30,31
	b .L69
.L72:
	mfcr 9
	rlwinm 9,9,3,1
	addic 11,3,-1
	subfe 0,11,3
	and. 11,0,9
	bc 12,2,.L69
	lwz 9,0(30)
	lwz 11,0(31)
	lwz 10,84(9)
	lwz 8,84(11)
	lwz 7,3424(10)
	lwz 9,3424(8)
	cmpw 7,7,9
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,31,0
	and 0,30,0
	or 30,0,9
.L69:
	lwz 31,4(31)
	cmpwi 0,31,0
	bc 4,2,.L70
.L68:
	cmpwi 0,30,0
	li 3,0
	bc 12,2,.L77
	lwz 3,0(30)
.L77:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 PlayerToFollow,.Lfe21-PlayerToFollow
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
	stfs 0,3616(9)
	lfs 0,28(1)
	lwz 11,84(29)
	stfs 0,3620(11)
	lfs 0,32(1)
	lwz 9,84(29)
	stfs 0,3624(9)
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
	lwz 11,84(3)
	lwz 7,3788(11)
	cmpwi 0,7,0
	bc 12,2,.L135
	lwz 9,84(7)
	cmpwi 0,9,0
	bc 12,2,.L135
	lwz 0,3424(9)
	stw 0,3424(11)
	lwz 11,480(7)
	lwz 8,84(3)
	stw 11,480(3)
	lwz 9,84(7)
	lwz 0,3492(9)
	stw 0,3492(8)
	lwz 10,84(3)
	lwz 11,84(7)
	lwz 0,3492(10)
	addi 11,11,740
	addi 10,10,740
	slwi 0,0,2
	lwzx 9,11,0
	stwx 9,10,0
	blr
.L135:
	lwz 9,84(3)
	li 0,0
	li 11,999
	stw 0,3424(9)
	stw 11,480(3)
	blr
.Lfe23:
	.size	 UpdateValues,.Lfe23-UpdateValues
	.align 2
	.globl CameraChickenThink
	.type	 CameraChickenThink,@function
CameraChickenThink:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	bl Chicken_Follow
	lwz 9,84(31)
	cmpwi 0,3,0
	stw 3,3788(9)
	bc 12,2,.L138
	lis 0,0xc270
	lis 9,0x4220
	mr 3,31
	stw 0,12(1)
	addi 4,1,8
	stw 9,16(1)
	stw 0,8(1)
	bl RepositionAtTarget
	mr 3,31
	bl PointCamAtTarget
.L138:
	lwz 9,84(31)
	lwz 7,3788(9)
	mr 11,9
	cmpwi 0,7,0
	bc 12,2,.L139
	lwz 9,84(7)
	cmpwi 0,9,0
	bc 12,2,.L139
	lwz 0,3424(9)
	stw 0,3424(11)
	lwz 11,480(7)
	lwz 8,84(31)
	stw 11,480(31)
	lwz 9,84(7)
	lwz 0,3492(9)
	stw 0,3492(8)
	lwz 10,84(31)
	lwz 11,84(7)
	lwz 0,3492(10)
	addi 11,11,740
	addi 10,10,740
	slwi 0,0,2
	lwzx 9,11,0
	stwx 9,10,0
	b .L141
.L139:
	li 0,0
	li 9,999
	stw 0,3424(11)
	stw 9,480(31)
.L141:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe24:
	.size	 CameraChickenThink,.Lfe24-CameraChickenThink
	.comm	pEntityListHead,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
