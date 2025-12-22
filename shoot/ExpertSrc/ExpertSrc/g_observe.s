	.file	"g_observe.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"%s left spectator mode\n"
	.align 2
.LC1:
	.string	"set spectator 0 u\n"
	.align 2
.LC2:
	.string	"Observer"
	.align 2
.LC3:
	.string	"%s became a spectator\n"
	.align 2
.LC4:
	.string	"set spectator 1 u\n"
	.align 2
.LC5:
	.string	"spectator"
	.align 3
.LC6:
	.long 0x40000000
	.long 0x0
	.section	".text"
	.align 2
	.globl spectatorStateChange
	.type	 spectatorStateChange,@function
spectatorStateChange:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lis 9,level@ha
	lwz 3,84(31)
	la 28,level@l(9)
	lfs 13,4(28)
	lfs 0,3604(3)
	fcmpu 0,13,0
	bc 4,1,.L20
	lis 4,.LC5@ha
	addi 3,3,188
	la 4,.LC5@l(4)
	bl Info_ValueForKey
	bl atoi
	mr. 3,3
	bc 12,2,.L33
	lwz 9,84(31)
	li 30,0
	cmpwi 0,9,0
	bc 12,2,.L22
	lwz 0,260(31)
	xori 30,0,1
	subfic 11,30,0
	adde 30,11,30
.L22:
	cmpwi 0,30,0
	bc 4,2,.L21
	lwz 0,3588(9)
	cmpwi 0,0,0
	bc 12,2,.L21
	mr 3,31
	bl ClientLeavePlay
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,256
	bc 12,2,.L25
	lwz 3,84(31)
	lis 4,.LC2@ha
	la 4,.LC2@l(4)
	addi 3,3,700
	bl gsTeamChange
.L25:
	lwz 0,184(31)
	li 9,1
	li 8,-1
	lwz 10,84(31)
	lis 29,gi@ha
	mr 3,31
	ori 0,0,1
	stw 9,260(31)
	la 11,gi@l(29)
	stw 0,184(31)
	stw 30,248(31)
	stw 8,3476(10)
	lwz 9,84(31)
	stw 30,88(9)
	stw 30,492(31)
	lwz 0,72(11)
	mtlr 0
	blrl
	lwz 0,gi@l(29)
	lis 4,.LC3@ha
	li 3,2
	lwz 5,84(31)
	la 4,.LC3@l(4)
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	lis 4,.LC4@ha
	mr 3,31
	la 4,.LC4@l(4)
	bl StuffCmd
	lfs 0,4(28)
	lis 9,.LC6@ha
	mr 3,31
	la 9,.LC6@l(9)
	lfd 13,0(9)
	lwz 9,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3604(9)
	bl ToggleChaseCam
	b .L20
.L21:
	cmpwi 0,3,0
	bc 4,2,.L20
.L33:
	lwz 0,84(31)
	li 9,0
	cmpwi 0,0,0
	bc 12,2,.L29
	lwz 0,260(31)
	xori 9,0,1
	subfic 11,9,0
	adde 9,11,9
.L29:
	cmpwi 0,9,0
	bc 12,2,.L20
	mr 3,31
	li 4,-1
	bl ObserverToTeam
.L20:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 spectatorStateChange,.Lfe1-spectatorStateChange
	.section	".rodata"
	.align 3
.LC7:
	.long 0x40000000
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Observe
	.type	 Cmd_Observe,@function
Cmd_Observe:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	li 30,0
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L36
	lwz 0,260(31)
	xori 30,0,1
	subfic 11,30,0
	adde 30,11,30
.L36:
	cmpwi 0,30,0
	bc 12,2,.L35
	mr 3,31
	li 4,-1
	bl ObserverToTeam
	b .L40
.L35:
	lwz 0,3588(9)
	cmpwi 0,0,0
	bc 12,2,.L40
	mr 3,31
	bl ClientLeavePlay
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,256
	bc 12,2,.L42
	lwz 3,84(31)
	lis 4,.LC2@ha
	la 4,.LC2@l(4)
	addi 3,3,700
	bl gsTeamChange
.L42:
	lwz 0,184(31)
	li 9,1
	li 8,-1
	lwz 10,84(31)
	lis 29,gi@ha
	mr 3,31
	ori 0,0,1
	stw 9,260(31)
	la 11,gi@l(29)
	stw 0,184(31)
	stw 30,248(31)
	stw 8,3476(10)
	lwz 9,84(31)
	stw 30,88(9)
	stw 30,492(31)
	lwz 0,72(11)
	mtlr 0
	blrl
	lwz 0,gi@l(29)
	lis 4,.LC3@ha
	li 3,2
	lwz 5,84(31)
	la 4,.LC3@l(4)
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	lis 4,.LC4@ha
	mr 3,31
	la 4,.LC4@l(4)
	bl StuffCmd
	lis 9,level+4@ha
	lis 11,.LC7@ha
	lfs 0,level+4@l(9)
	la 11,.LC7@l(11)
	mr 3,31
	lfd 13,0(11)
	lwz 11,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3604(11)
	bl ToggleChaseCam
.L40:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 Cmd_Observe,.Lfe2-Cmd_Observe
	.section	".rodata"
	.align 2
.LC8:
	.string	"Chasecam disabled\n"
	.align 2
.LC9:
	.string	"No valid Chasecam targets\n"
	.align 2
.LC10:
	.string	"Chasecam enabled\n"
	.align 3
.LC11:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ToggleChaseCam
	.type	 ToggleChaseCam,@function
ToggleChaseCam:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 12,2,.L45
	li 0,0
	li 10,0
	stb 0,16(9)
	lis 11,gi+8@ha
	lis 5,.LC8@ha
	lwz 9,84(3)
	la 5,.LC8@l(5)
	li 4,2
	stw 10,3988(9)
	lwz 0,gi+8@l(11)
	b .L54
.L45:
	li 8,1
	b .L46
.L48:
	addi 8,8,1
.L46:
	xoris 0,8,0x8000
	lis 9,0x4330
	stw 0,12(1)
	lis 11,.LC11@ha
	la 11,.LC11@l(11)
	stw 9,8(1)
	lfd 12,0(11)
	lfd 0,8(1)
	lis 11,maxclients@ha
	lwz 9,maxclients@l(11)
	fsub 0,0,12
	lfs 13,20(9)
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L47
	lis 9,g_edicts@ha
	mulli 11,8,916
	lwz 0,g_edicts@l(9)
	add 11,0,11
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L48
	lwz 0,248(11)
	cmpwi 0,0,0
	bc 12,2,.L48
	lwz 9,84(3)
	li 0,1
	stw 11,3988(9)
	lwz 11,84(3)
	stw 0,3992(11)
.L47:
	lwz 9,84(3)
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 4,2,.L52
	lis 9,gi+8@ha
	lis 5,.LC9@ha
	lwz 0,gi+8@l(9)
	la 5,.LC9@l(5)
	li 4,2
.L54:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L44
.L52:
	lis 9,gi+8@ha
	lis 5,.LC10@ha
	lwz 0,gi+8@l(9)
	la 5,.LC10@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L44:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe3:
	.size	 ToggleChaseCam,.Lfe3-ToggleChaseCam
	.section	".rodata"
	.align 2
.LC12:
	.string	"No more valid Chasecam targets\n"
	.align 2
.LC13:
	.string	"xv 180 yb -72 string2 \"Chasing %s\""
	.align 3
.LC14:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC15:
	.long 0x42600000
	.align 2
.LC16:
	.long 0xc1f00000
	.align 2
.LC17:
	.long 0x41a00000
	.align 2
.LC18:
	.long 0x41800000
	.align 2
.LC19:
	.long 0x40c00000
	.align 2
.LC20:
	.long 0x3f800000
	.align 2
.LC21:
	.long 0x40000000
	.align 2
.LC22:
	.long 0x47800000
	.align 2
.LC23:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl UpdateChaseCam
	.type	 UpdateChaseCam,@function
UpdateChaseCam:
	stwu 1,-1280(1)
	mflr 0
	stfd 30,1264(1)
	stfd 31,1272(1)
	stmw 25,1236(1)
	stw 0,1284(1)
	mr 31,3
	lwz 9,84(31)
	lwz 11,3988(9)
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 4,2,.L56
	bl ChaseNext
	lwz 9,84(31)
	lwz 11,3988(9)
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 4,2,.L56
	lis 9,gi+8@ha
	lis 5,.LC12@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC12@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl ToggleChaseCam
	b .L55
.L56:
	lwz 11,84(31)
	lis 10,0x4330
	lfs 9,4(31)
	lis 8,.LC14@ha
	lwz 29,3988(11)
	la 8,.LC14@l(8)
	lfs 11,8(31)
	lfs 13,4(29)
	lfs 12,12(31)
	lfd 10,0(8)
	stfs 13,24(1)
	lis 8,.LC15@ha
	lfs 0,8(29)
	la 8,.LC15@l(8)
	lfs 8,0(8)
	stfs 0,28(1)
	lfs 13,12(29)
	stfs 9,152(1)
	stfs 11,156(1)
	stfs 13,32(1)
	stfs 12,160(1)
	lwz 0,508(29)
	xoris 0,0,0x8000
	stw 0,1228(1)
	stw 10,1224(1)
	lfd 0,1224(1)
	fsub 0,0,10
	frsp 0,0
	fadds 13,13,0
	stfs 13,32(1)
	lwz 9,84(29)
	lfs 0,3876(9)
	stfs 0,168(1)
	fcmpu 0,0,8
	lwz 9,84(29)
	lfs 0,3880(9)
	stfs 0,172(1)
	lwz 9,84(29)
	lfs 0,3884(9)
	stfs 0,176(1)
	bc 4,1,.L58
	stfs 8,168(1)
.L58:
	addi 28,1,56
	addi 5,1,72
	addi 3,1,168
	addi 30,1,24
	mr 4,28
	li 6,0
	bl AngleVectors
	mr 3,28
	bl VectorNormalize
	lis 8,.LC16@ha
	mr 3,30
	la 8,.LC16@l(8)
	mr 4,28
	lfs 1,0(8)
	addi 5,1,8
	bl VectorMA
	lis 8,.LC17@ha
	lfs 0,12(29)
	la 8,.LC17@l(8)
	lfs 12,16(1)
	lfs 13,0(8)
	fadds 0,0,13
	fcmpu 0,12,0
	bc 4,0,.L59
	stfs 0,16(1)
.L59:
	lwz 0,552(29)
	cmpwi 0,0,0
	bc 4,2,.L60
	lis 9,.LC18@ha
	lfs 0,16(1)
	la 9,.LC18@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,16(1)
.L60:
	lis 9,gi@ha
	lis 25,vec3_origin@ha
	la 26,gi@l(9)
	lis 11,.LC19@ha
	lwz 10,48(26)
	addi 27,1,88
	la 5,vec3_origin@l(25)
	la 11,.LC19@l(11)
	mr 6,5
	addi 7,1,8
	mr 8,29
	mtlr 10
	lfs 31,0(11)
	mr 4,30
	li 9,3
	mr 3,27
	lis 11,.LC20@ha
	la 11,.LC20@l(11)
	addi 30,1,40
	lfs 30,0(11)
	blrl
	lis 8,.LC21@ha
	lfs 12,100(1)
	mr 4,28
	lfs 13,104(1)
	la 8,.LC21@l(8)
	mr 3,30
	lfs 0,108(1)
	mr 5,30
	lfs 1,0(8)
	stfs 12,40(1)
	stfs 13,44(1)
	stfs 0,48(1)
	bl VectorMA
	lfs 12,48(1)
	la 5,vec3_origin@l(25)
	mr 3,27
	lwz 11,48(26)
	mr 4,30
	mr 6,5
	lfs 0,44(1)
	addi 7,1,8
	mr 8,29
	fadds 12,12,31
	lfs 13,40(1)
	li 9,3
	mtlr 11
	stfs 0,12(1)
	stfs 13,8(1)
	stfs 12,16(1)
	blrl
	lfs 0,96(1)
	fcmpu 0,0,30
	bc 4,0,.L61
	lfs 0,108(1)
	lfs 12,100(1)
	lfs 13,104(1)
	fsubs 0,0,31
	stfs 12,40(1)
	stfs 13,44(1)
	stfs 0,48(1)
.L61:
	lfs 12,48(1)
	la 5,vec3_origin@l(25)
	mr 3,27
	lwz 0,48(26)
	mr 4,30
	mr 6,5
	lfs 0,44(1)
	addi 7,1,8
	mr 8,29
	fsubs 12,12,31
	lfs 13,40(1)
	li 9,3
	mtlr 0
	stfs 0,12(1)
	stfs 13,8(1)
	stfs 12,16(1)
	blrl
	lfs 0,96(1)
	fcmpu 0,0,30
	bc 4,0,.L62
	lfs 0,108(1)
	lfs 12,100(1)
	lfs 13,104(1)
	fadds 0,0,31
	stfs 12,40(1)
	stfs 13,44(1)
	stfs 0,48(1)
.L62:
	lwz 9,84(31)
	li 0,4
	lis 8,.LC22@ha
	lis 11,.LC23@ha
	la 8,.LC22@l(8)
	stw 0,0(9)
	la 11,.LC23@l(11)
	li 6,0
	li 0,3
	lfs 0,40(1)
	li 7,0
	lfs 13,44(1)
	mtctr 0
	lfs 12,48(1)
	lfs 10,0(8)
	lfs 11,0(11)
	stfs 0,4(31)
	stfs 13,8(31)
	stfs 12,12(31)
.L71:
	lwz 8,84(31)
	add 0,6,6
	lwz 9,84(29)
	addi 6,6,1
	addi 11,8,3456
	addi 9,9,3876
	lfsx 12,11,7
	addi 8,8,20
	lfsx 0,9,7
	addi 7,7,4
	fsubs 0,0,12
	fmuls 0,0,10
	fdivs 0,0,11
	fctiwz 13,0
	stfd 13,1224(1)
	lwz 10,1228(1)
	sthx 10,8,0
	bdnz .L71
	lwz 9,84(29)
	li 10,0
	lis 8,gi+72@ha
	lwz 11,84(31)
	mr 3,31
	lfs 0,3876(9)
	stfs 0,28(11)
	lwz 9,84(29)
	lwz 11,84(31)
	lfs 0,3880(9)
	stfs 0,32(11)
	lwz 9,84(29)
	lwz 11,84(31)
	lfs 0,3884(9)
	stfs 0,36(11)
	lwz 9,84(29)
	lwz 11,84(31)
	lfs 0,3876(9)
	stfs 0,3876(11)
	lwz 9,84(29)
	lwz 11,84(31)
	lfs 0,3880(9)
	stfs 0,3880(11)
	lwz 9,84(29)
	lwz 11,84(31)
	lfs 0,3884(9)
	stfs 0,3884(11)
	lwz 9,84(31)
	stw 10,508(31)
	lbz 0,16(9)
	ori 0,0,64
	stb 0,16(9)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	lwz 11,84(31)
	lwz 0,3728(11)
	cmpwi 0,0,0
	bc 4,2,.L70
	lwz 0,3736(11)
	cmpwi 0,0,0
	bc 4,2,.L70
	lwz 0,3740(11)
	cmpwi 0,0,0
	bc 4,2,.L70
	lwz 0,3744(11)
	cmpwi 0,0,0
	bc 4,2,.L70
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 8,0,31
	bc 12,2,.L69
.L70:
	lwz 9,84(31)
	lwz 0,3992(9)
	mr 11,9
	cmpwi 0,0,0
	bc 12,2,.L55
.L69:
	li 0,0
	addi 28,1,184
	stw 0,3992(11)
	lis 4,.LC13@ha
	mr 3,28
	lwz 5,84(29)
	la 4,.LC13@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl sprintf
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,31
	li 4,0
	mtlr 0
	blrl
.L55:
	lwz 0,1284(1)
	mtlr 0
	lmw 25,1236(1)
	lfd 30,1264(1)
	lfd 31,1272(1)
	la 1,1280(1)
	blr
.Lfe4:
	.size	 UpdateChaseCam,.Lfe4-UpdateChaseCam
	.section	".rodata"
	.align 2
.LC24:
	.string	"Switching Chasecam targets\n"
	.comm	gametype,4,4
	.align 3
.LC25:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ChaseNext
	.type	 ChaseNext,@function
ChaseNext:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 9,gi+8@ha
	mr 31,3
	lwz 0,gi+8@l(9)
	lis 5,.LC24@ha
	la 5,.LC24@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,.LC25@ha
	lwz 10,84(31)
	lis 11,0x478b
	la 9,.LC25@l(9)
	ori 11,11,48365
	lfd 12,0(9)
	lis 6,0x4330
	lis 9,g_edicts@ha
	lwz 0,3988(10)
	lwz 8,g_edicts@l(9)
	lis 9,maxclients@ha
	lwz 10,maxclients@l(9)
	subf 0,8,0
	mr 7,8
	mullw 0,0,11
	lfs 13,20(10)
	srawi 10,0,2
	mulli 9,10,916
	add 8,9,7
.L79:
	addi 10,10,1
	xoris 0,10,0x8000
	addi 8,8,916
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 4,1,.L76
	addi 8,7,916
	li 10,1
.L76:
	mr 11,8
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L75
	lwz 0,248(11)
	lwz 9,84(31)
	cmpwi 0,0,0
	bc 4,2,.L74
.L75:
	lwz 9,84(31)
	lwz 0,3988(9)
	cmpw 0,11,0
	bc 4,2,.L79
.L74:
	stw 11,3988(9)
	li 0,1
	lwz 9,84(31)
	stw 0,3992(9)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 ChaseNext,.Lfe5-ChaseNext
	.align 2
	.globl ChasePrev
	.type	 ChasePrev,@function
ChasePrev:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 9,gi+8@ha
	mr 31,3
	lwz 0,gi+8@l(9)
	lis 5,.LC24@ha
	la 5,.LC24@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 8,84(31)
	lis 9,g_edicts@ha
	lis 11,0x478b
	lwz 10,g_edicts@l(9)
	ori 11,11,48365
	lwz 0,3988(8)
	lis 9,maxclients@ha
	mr 7,10
	lwz 8,maxclients@l(9)
	subf 0,10,0
	mullw 0,0,11
	srawi 10,0,2
.L87:
	addic. 10,10,-1
	bc 12,1,.L84
	lfs 0,20(8)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 10,20(1)
.L84:
	mulli 0,10,916
	add 11,7,0
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L83
	lwz 0,248(11)
	lwz 9,84(31)
	cmpwi 0,0,0
	bc 4,2,.L82
.L83:
	lwz 9,84(31)
	lwz 0,3988(9)
	cmpw 0,11,0
	bc 4,2,.L87
.L82:
	stw 11,3988(9)
	li 0,1
	lwz 9,84(31)
	stw 0,3992(9)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 ChasePrev,.Lfe6-ChasePrev
	.align 2
	.globl IsObserver
	.type	 IsObserver,@function
IsObserver:
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L7
	lwz 0,260(3)
	li 3,1
	cmpwi 0,0,1
	bclr 12,2
.L7:
	li 3,0
	blr
.Lfe7:
	.size	 IsObserver,.Lfe7-IsObserver
	.section	".rodata"
	.align 3
.LC26:
	.long 0x40000000
	.long 0x0
	.section	".text"
	.align 2
	.globl PlayerToObserver
	.type	 PlayerToObserver,@function
PlayerToObserver:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	bl ClientLeavePlay
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,256
	bc 12,2,.L18
	lwz 3,84(31)
	lis 4,.LC2@ha
	la 4,.LC2@l(4)
	addi 3,3,700
	bl gsTeamChange
.L18:
	lwz 0,184(31)
	li 11,0
	li 9,1
	lwz 7,84(31)
	li 10,-1
	lis 29,gi@ha
	ori 0,0,1
	stw 11,248(31)
	la 8,gi@l(29)
	stw 9,260(31)
	mr 3,31
	stw 0,184(31)
	stw 10,3476(7)
	lwz 9,84(31)
	stw 11,88(9)
	stw 11,492(31)
	lwz 0,72(8)
	mtlr 0
	blrl
	lwz 0,gi@l(29)
	lis 4,.LC3@ha
	li 3,2
	lwz 5,84(31)
	la 4,.LC3@l(4)
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	lis 4,.LC4@ha
	mr 3,31
	la 4,.LC4@l(4)
	bl StuffCmd
	lis 9,level+4@ha
	lis 11,.LC26@ha
	lfs 0,level+4@l(9)
	la 11,.LC26@l(11)
	mr 3,31
	lfd 13,0(11)
	lwz 11,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3604(11)
	bl ToggleChaseCam
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe8:
	.size	 PlayerToObserver,.Lfe8-PlayerToObserver
	.align 2
	.globl ObserverToPlayer
	.type	 ObserverToPlayer,@function
ObserverToPlayer:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,-1
	bl ObserverToTeam
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 ObserverToPlayer,.Lfe9-ObserverToPlayer
	.section	".rodata"
	.align 3
.LC27:
	.long 0x40000000
	.long 0x0
	.section	".text"
	.align 2
	.globl ObserverToTeam
	.type	 ObserverToTeam,@function
ObserverToTeam:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lis 11,sv_expflags@ha
	lwz 0,184(31)
	li 10,4
	lwz 8,sv_expflags@l(11)
	rlwinm 0,0,0,0,30
	stw 10,260(31)
	stw 0,184(31)
	lfs 0,20(8)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	andi. 0,9,256
	bc 12,2,.L13
	cmpwi 0,4,-1
	bc 4,2,.L14
	bl assignTeam
	b .L13
.L14:
	mr 3,31
	bl assignToTeam
.L13:
	lis 10,sv_utilflags@ha
	lwz 9,sv_utilflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,1
	bc 12,2,.L16
	lwz 29,84(31)
	lwz 3,3476(29)
	addi 29,29,700
	bl nameForTeam
	mr 4,3
	mr 3,29
	bl gsTeamChange
.L16:
	mr 3,31
	bl PutClientInServer
	lwz 11,84(31)
	li 0,6
	li 9,32
	stw 0,80(31)
	li 10,14
	lis 8,gi@ha
	stb 9,16(11)
	lis 4,.LC0@ha
	li 3,2
	lwz 9,84(31)
	la 4,.LC0@l(4)
	stb 10,17(9)
	lwz 0,gi@l(8)
	lwz 5,84(31)
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	lis 4,.LC1@ha
	mr 3,31
	la 4,.LC1@l(4)
	bl StuffCmd
	lis 9,level+4@ha
	lis 11,.LC27@ha
	lfs 0,level+4@l(9)
	la 11,.LC27@l(11)
	lfd 13,0(11)
	lwz 11,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3604(11)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe10:
	.size	 ObserverToTeam,.Lfe10-ObserverToTeam
	.align 2
	.globl markNotObserver
	.type	 markNotObserver,@function
markNotObserver:
	lwz 0,184(3)
	li 9,4
	stw 9,260(3)
	rlwinm 0,0,0,0,30
	stw 0,184(3)
	blr
.Lfe11:
	.size	 markNotObserver,.Lfe11-markNotObserver
	.comm	flags,4,4
	.comm	gCauseTable,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
