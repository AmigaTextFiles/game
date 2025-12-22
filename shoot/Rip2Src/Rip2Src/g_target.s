	.file	"g_target.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"target_speaker with no noise set at %s\n"
	.align 2
.LC1:
	.string	".wav"
	.align 2
.LC2:
	.string	"%s.wav"
	.align 2
.LC3:
	.long 0x0
	.align 2
.LC4:
	.long 0xbf800000
	.section	".text"
	.align 2
	.globl SP_target_speaker
	.type	 SP_target_speaker,@function
SP_target_speaker:
	stwu 1,-96(1)
	mflr 0
	stmw 29,84(1)
	stw 0,100(1)
	lis 9,st@ha
	mr 31,3
	la 29,st@l(9)
	lwz 3,36(29)
	cmpwi 0,3,0
	bc 4,2,.L16
	lis 29,gi@ha
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 4,3
	lwz 0,4(29)
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L15
.L16:
	lis 4,.LC1@ha
	la 4,.LC1@l(4)
	bl strstr
	cmpwi 0,3,0
	bc 4,2,.L17
	lis 5,.LC2@ha
	lwz 6,36(29)
	addi 3,1,8
	la 5,.LC2@l(5)
	li 4,64
	crxor 6,6,6
	bl Com_sprintf
	b .L18
.L17:
	lwz 4,36(29)
	addi 3,1,8
	li 5,64
	bl strncpy
.L18:
	lis 9,gi+36@ha
	addi 3,1,8
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
	lis 9,.LC3@ha
	lfs 0,584(31)
	la 9,.LC3@l(9)
	stw 3,576(31)
	lfs 12,0(9)
	fcmpu 0,0,12
	bc 4,2,.L19
	lis 0,0x3f80
	stw 0,584(31)
.L19:
	lfs 13,588(31)
	fcmpu 0,13,12
	bc 4,2,.L20
	lis 0,0x3f80
	stw 0,588(31)
	b .L21
.L20:
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L21
	stfs 12,588(31)
.L21:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L23
	lwz 0,576(31)
	stw 0,76(31)
.L23:
	lis 9,Use_Target_Speaker@ha
	lis 11,gi+72@ha
	la 9,Use_Target_Speaker@l(9)
	mr 3,31
	stw 9,448(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
.L15:
	lwz 0,100(1)
	mtlr 0
	lmw 29,84(1)
	la 1,96(1)
	blr
.Lfe1:
	.size	 SP_target_speaker,.Lfe1-SP_target_speaker
	.section	".rodata"
	.align 2
.LC5:
	.string	"0"
	.align 2
.LC6:
	.string	"%s exited the level.\n"
	.align 2
.LC7:
	.string	"*"
	.align 2
.LC8:
	.long 0x0
	.section	".text"
	.align 2
	.globl use_target_changelevel
	.type	 use_target_changelevel,@function
use_target_changelevel:
	stwu 1,-48(1)
	mflr 0
	stw 31,44(1)
	stw 0,52(1)
	lis 11,.LC8@ha
	lis 9,level+200@ha
	la 11,.LC8@l(11)
	lfs 0,level+200@l(9)
	mr 31,3
	lfs 13,0(11)
	mr 3,4
	fcmpu 0,0,13
	bc 4,2,.L38
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L41
	lis 9,teamplay@ha
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L40
.L41:
	lis 9,g_edicts@ha
	lwz 11,g_edicts@l(9)
	lwz 0,1596(11)
	cmpwi 0,0,0
	bc 4,1,.L38
.L40:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,32(1)
	lwz 11,36(1)
	andi. 11,11,4096
	bc 4,2,.L43
	lis 9,g_edicts@ha
	lwz 0,g_edicts@l(9)
	cmpw 0,3,0
	bc 12,2,.L43
	lwz 9,484(3)
	lis 6,vec3_origin@ha
	mr 4,31
	la 6,vec3_origin@l(6)
	li 0,28
	stw 11,8(1)
	mulli 9,9,10
	mr 5,4
	stw 0,12(1)
	addi 7,3,4
	mr 8,6
	li 10,1000
	bl T_Damage
	b .L38
.L43:
	cmpwi 0,5,0
	bc 12,2,.L44
	lwz 5,84(5)
	cmpwi 0,5,0
	bc 12,2,.L44
	lis 9,gi@ha
	lis 4,.LC6@ha
	lwz 0,gi@l(9)
	la 4,.LC6@l(4)
	addi 5,5,700
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L44:
	lwz 3,504(31)
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L45
	lis 9,game@ha
	la 9,game@l(9)
	lwz 0,1552(9)
	rlwinm 0,0,0,0,23
	stw 0,1552(9)
.L45:
	mr 3,31
	bl BeginIntermission
.L38:
	lwz 0,52(1)
	mtlr 0
	lwz 31,44(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 use_target_changelevel,.Lfe2-use_target_changelevel
	.section	".rodata"
	.align 2
.LC9:
	.string	"target_changelevel with no map at %s\n"
	.align 2
.LC10:
	.string	"fact1"
	.align 2
.LC11:
	.string	"fact3"
	.align 2
.LC12:
	.string	"fact3$secret1"
	.align 2
.LC13:
	.string	"weapons/laser2.wav"
	.align 2
.LC14:
	.string	"laser_yaya"
	.align 3
.LC15:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC16:
	.long 0x42800000
	.align 2
.LC17:
	.long 0x42480000
	.align 2
.LC18:
	.long 0x3f000000
	.align 2
.LC19:
	.long 0x45000000
	.section	".text"
	.align 2
	.globl target_laser_think
	.type	 target_laser_think,@function
target_laser_think:
	stwu 1,-176(1)
	mflr 0
	stmw 26,152(1)
	stw 0,180(1)
	mr 31,3
	lis 4,.LC14@ha
	lwz 3,280(31)
	la 4,.LC14@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L72
	lis 9,level@ha
	lfs 13,596(31)
	la 9,level@l(9)
	lfs 0,4(9)
	fcmpu 0,0,13
	bc 4,1,.L72
	lis 9,.LC16@ha
	mr 3,31
	la 9,.LC16@l(9)
	mr 4,31
	lfs 1,0(9)
	li 5,0
	li 6,34
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 2,0(9)
	bl T_RadiusDamage
	li 3,5
	addi 4,31,4
	li 5,2
	bl G_PointEntity
	mr 3,31
	bl G_FreeEdict
	b .L71
.L72:
	lwz 0,284(31)
	addi 28,31,340
	lwz 3,540(31)
	cmpwi 7,0,0
	cmpwi 0,3,0
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	nor 9,0,0
	rlwinm 0,0,0,29,29
	rlwinm 9,9,0,28,28
	or 26,0,9
	bc 12,2,.L76
	lis 9,.LC18@ha
	lfs 12,340(31)
	addi 4,3,236
	lfs 13,344(31)
	la 9,.LC18@l(9)
	addi 5,1,112
	lfs 0,348(31)
	addi 3,3,212
	lfs 1,0(9)
	stfs 12,128(1)
	stfs 13,132(1)
	stfs 0,136(1)
	bl VectorMA
	lfs 12,112(1)
	mr 3,28
	lfs 11,4(31)
	lfs 13,116(1)
	lfs 0,120(1)
	fsubs 12,12,11
	lfs 10,8(31)
	lfs 11,12(31)
	fsubs 13,13,10
	stfs 12,340(31)
	fsubs 0,0,11
	stfs 13,344(31)
	stfs 0,348(31)
	bl VectorNormalize
	mr 3,28
	addi 4,1,128
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L76
	lwz 0,284(31)
	oris 0,0,0x8000
	stw 0,284(31)
.L76:
	lis 9,.LC19@ha
	lfs 12,4(31)
	addi 29,1,32
	lfs 13,8(31)
	la 9,.LC19@l(9)
	addi 3,1,16
	lfs 0,12(31)
	mr 4,28
	mr 5,29
	lfs 1,0(9)
	mr 30,31
	stfs 12,16(1)
	stfs 13,20(1)
	stfs 0,24(1)
	bl VectorMA
	mr 27,29
	addi 29,1,48
	b .L80
.L81:
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L82
	lwz 0,264(3)
	andi. 9,0,4
	bc 4,2,.L82
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 12,2,.L82
	lwz 0,1820(9)
	lwz 9,908(31)
	cmpw 0,0,9
	bc 12,2,.L82
	cmpwi 0,9,0
	bc 12,2,.L82
	lwz 5,548(31)
	li 0,4
	li 11,30
	lwz 9,516(31)
	lis 8,vec3_origin@ha
	mr 4,31
	stw 0,8(1)
	la 8,vec3_origin@l(8)
	mr 6,28
	stw 11,12(1)
	addi 7,1,60
	li 10,1
	bl T_Damage
.L82:
	lwz 9,100(1)
	lwz 0,184(9)
	mr 8,9
	andi. 9,0,4
	bc 4,2,.L85
	lwz 0,84(8)
	cmpwi 0,0,0
	bc 4,2,.L85
	lwz 0,284(31)
	cmpwi 0,0,0
	bc 4,0,.L79
	rlwinm 0,0,0,1,31
	lwz 7,60(31)
	mr 4,26
	stw 0,284(31)
	li 3,15
	addi 5,1,60
	addi 6,1,72
	li 8,2
	bl G_SplashEntity
	b .L79
.L85:
	lfs 0,60(1)
	mr 30,8
	lfs 13,64(1)
	lfs 12,68(1)
	stfs 0,16(1)
	stfs 13,20(1)
	stfs 12,24(1)
.L80:
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(11)
	mr 3,29
	mr 8,30
	addi 4,1,16
	li 5,0
	li 6,0
	mr 7,27
	mtlr 0
	ori 9,9,1
	blrl
	lwz 3,100(1)
	cmpwi 0,3,0
	bc 4,2,.L81
.L79:
	lfs 0,64(1)
	lis 9,level+4@ha
	lis 11,.LC15@ha
	lfs 13,68(1)
	lfs 12,60(1)
	stfs 0,32(31)
	stfs 13,36(31)
	stfs 12,28(31)
	lfs 0,level+4@l(9)
	lfd 13,.LC15@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L71:
	lwz 0,180(1)
	mtlr 0
	lmw 26,152(1)
	la 1,176(1)
	blr
.Lfe3:
	.size	 target_laser_think,.Lfe3-target_laser_think
	.section	".rodata"
	.align 2
.LC20:
	.string	"%s at %s: %s is a bad target\n"
	.section	".text"
	.align 2
	.globl target_laser_start
	.type	 target_laser_start,@function
target_laser_start:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	li 10,0
	lwz 9,284(31)
	li 11,1
	lwz 0,68(31)
	andi. 8,9,64
	stw 10,248(31)
	ori 0,0,160
	stw 11,40(31)
	stw 0,68(31)
	stw 10,260(31)
	li 0,4
	bc 12,2,.L98
	li 0,16
.L98:
	stw 0,56(31)
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L100
	lis 0,0xf2f2
	ori 0,0,61680
	b .L120
.L100:
	andi. 8,0,4
	bc 12,2,.L102
	lis 0,0xd0d1
	ori 0,0,53971
	b .L120
.L102:
	andi. 9,0,8
	bc 12,2,.L104
	lis 0,0xf3f3
	ori 0,0,61937
	b .L120
.L104:
	andi. 8,0,16
	bc 12,2,.L106
	lis 0,0xdcdd
	ori 0,0,57055
	b .L120
.L106:
	andi. 9,0,32
	bc 12,2,.L101
	lis 0,0xe0e1
	ori 0,0,58083
.L120:
	stw 0,60(31)
.L101:
	lwz 0,540(31)
	lis 29,gi@ha
	cmpwi 0,0,0
	bc 4,2,.L109
	lwz 5,296(31)
	cmpwi 0,5,0
	bc 12,2,.L110
	li 3,0
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L111
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC20@ha
	lwz 6,296(31)
	la 3,.LC20@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L111:
	stw 30,540(31)
	b .L109
.L110:
	addi 3,31,16
	addi 4,31,340
	bl G_SetMovedir
.L109:
	lwz 0,516(31)
	lis 9,target_laser_use@ha
	lis 11,target_laser_think@ha
	la 9,target_laser_use@l(9)
	la 11,target_laser_think@l(11)
	cmpwi 0,0,0
	stw 9,448(31)
	stw 11,436(31)
	bc 4,2,.L113
	li 0,1
	stw 0,516(31)
.L113:
	lis 0,0xc100
	lis 9,0x4100
	lis 11,gi+72@ha
	stw 0,196(31)
	mr 3,31
	stw 9,208(31)
	stw 0,188(31)
	stw 0,192(31)
	stw 9,200(31)
	stw 9,204(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	lwz 11,284(31)
	andi. 0,11,1
	bc 12,2,.L114
	lwz 0,548(31)
	cmpwi 0,0,0
	bc 4,2,.L115
	stw 31,548(31)
.L115:
	lwz 0,284(31)
	mr 3,31
	lwz 9,184(31)
	oris 0,0,0x8000
	ori 0,0,1
	rlwinm 9,9,0,0,30
	stw 0,284(31)
	stw 9,184(31)
	bl target_laser_think
	b .L117
.L114:
	lwz 0,184(31)
	rlwinm 11,11,0,0,30
	li 9,0
	stw 9,428(31)
	ori 0,0,1
	stw 11,284(31)
	stw 0,184(31)
.L117:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 target_laser_start,.Lfe4-target_laser_start
	.section	".rodata"
	.align 3
.LC21:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC22:
	.long 0x42c20000
	.align 3
.LC23:
	.long 0x43300000
	.long 0x0
	.section	".text"
	.align 2
	.globl target_lightramp_think
	.type	 target_lightramp_think,@function
target_lightramp_think:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 29,44(1)
	stw 0,68(1)
	lis 29,level@ha
	mr 31,3
	la 29,level@l(29)
	lfs 12,288(31)
	lis 11,.LC21@ha
	lfs 0,4(29)
	lis 9,.LC22@ha
	lis 10,gi+24@ha
	lfd 31,.LC21@l(11)
	la 9,.LC22@l(9)
	addi 4,1,8
	lfs 10,0(9)
	fsubs 0,0,12
	lfs 13,340(31)
	lfs 12,348(31)
	lwz 11,540(31)
	lwz 0,gi+24@l(10)
	fadds 13,13,10
	mtlr 0
	fdiv 0,0,31
	fmadd 0,0,12,13
	fctiwz 11,0
	stfd 11,32(1)
	lwz 9,36(1)
	slwi 9,9,8
	sth 9,8(1)
	lwz 3,644(11)
	addi 3,3,800
	blrl
	lfs 12,4(29)
	lfs 0,288(31)
	lfs 13,328(31)
	fsubs 0,12,0
	fcmpu 0,0,13
	bc 4,0,.L123
	fmr 0,12
	fadd 0,0,31
	frsp 0,0
	stfs 0,428(31)
	b .L124
.L123:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L124
	lfs 0,340(31)
	lis 0,0x4330
	mr 11,9
	lis 10,.LC23@ha
	lfs 13,348(31)
	la 10,.LC23@l(10)
	lfs 11,344(31)
	lfd 10,0(10)
	fneg 13,13
	stfs 11,340(31)
	fctiwz 12,0
	stfs 13,348(31)
	stfd 12,32(1)
	lwz 9,36(1)
	rlwinm 9,9,0,0xff
	stw 9,36(1)
	stw 0,32(1)
	lfd 0,32(1)
	fsub 0,0,10
	frsp 0,0
	stfs 0,344(31)
.L124:
	lwz 0,68(1)
	mtlr 0
	lmw 29,44(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe5:
	.size	 target_lightramp_think,.Lfe5-target_lightramp_think
	.section	".rodata"
	.align 2
.LC24:
	.string	"light"
	.align 2
.LC25:
	.string	"%s at %s "
	.align 2
.LC26:
	.string	"target %s (%s at %s) is not a light\n"
	.align 2
.LC27:
	.string	"%s target %s not found at %s\n"
	.align 2
.LC28:
	.string	"target_lightramp has bad ramp (%s) at %s\n"
	.align 2
.LC29:
	.string	"%s with no target at %s\n"
	.section	".text"
	.align 2
	.globl SP_target_lightramp
	.type	 SP_target_lightramp,@function
SP_target_lightramp:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 3,276(31)
	cmpwi 0,3,0
	bc 12,2,.L138
	bl strlen
	cmpwi 0,3,2
	bc 4,2,.L138
	lwz 11,276(31)
	lbz 9,0(11)
	cmplwi 0,9,96
	bc 4,1,.L138
	cmplwi 0,9,122
	bc 12,1,.L138
	lbz 0,1(11)
	cmplwi 0,0,96
	bc 4,1,.L138
	cmplwi 0,0,122
	bc 12,1,.L138
	cmpw 0,9,0
	bc 4,2,.L137
.L138:
	lis 29,gi@ha
	lwz 28,276(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC28@ha
	la 3,.LC28@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L136
.L137:
	mr 3,31
	bl G_FreeEdict
.L136:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 SP_target_lightramp,.Lfe6-SP_target_lightramp
	.section	".rodata"
	.align 2
.LC31:
	.long 0x46fffe00
	.align 3
.LC32:
	.long 0x4062c000
	.long 0x0
	.align 3
.LC33:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC34:
	.long 0x3f800000
	.align 2
.LC35:
	.long 0x0
	.align 3
.LC36:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC37:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC38:
	.long 0x40590000
	.long 0x0
	.section	".text"
	.align 2
	.globl target_earthquake_think
	.type	 target_earthquake_think,@function
target_earthquake_think:
	stwu 1,-96(1)
	mflr 0
	stfd 28,64(1)
	stfd 29,72(1)
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 25,36(1)
	stw 0,100(1)
	lis 9,level@ha
	mr 30,3
	la 31,level@l(9)
	lfs 13,476(30)
	lfs 0,4(31)
	fcmpu 0,13,0
	bc 4,0,.L141
	lis 9,gi+20@ha
	lis 10,.LC35@ha
	lwz 6,576(30)
	lwz 0,gi+20@l(9)
	lis 11,.LC35@ha
	la 10,.LC35@l(10)
	lis 9,.LC34@ha
	la 11,.LC35@l(11)
	lfs 2,0(10)
	la 9,.LC34@l(9)
	addi 3,30,4
	lfs 3,0(11)
	mtlr 0
	lfs 1,0(9)
	mr 4,30
	li 5,0
	blrl
	lfs 0,4(31)
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,476(30)
.L141:
	lis 9,maxclients@ha
	lis 10,.LC35@ha
	lwz 11,maxclients@l(9)
	la 10,.LC35@l(10)
	li 27,0
	lfs 13,0(10)
	lis 25,maxclients@ha
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L143
	lis 9,.LC31@ha
	lis 11,.LC32@ha
	lfs 28,.LC31@l(9)
	lis 26,g_edicts@ha
	lis 29,0x4330
	lfd 29,.LC32@l(11)
	lis 9,.LC36@ha
	li 28,0
	lis 11,.LC37@ha
	la 9,.LC36@l(9)
	la 11,.LC37@l(11)
	lfd 30,0(9)
	lfd 31,0(11)
.L145:
	lwz 9,g_edicts@l(26)
	add 9,9,28
	addi 31,9,1116
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L144
	lwz 10,84(31)
	cmpwi 0,10,0
	bc 12,2,.L144
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L144
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L144
	lwz 9,256(30)
	cmpwi 0,9,0
	bc 12,2,.L150
	lwz 11,84(9)
	cmpwi 0,11,0
	bc 12,2,.L150
	lwz 9,1820(10)
	lwz 0,1820(11)
	cmpw 0,9,0
	bc 12,2,.L144
.L150:
	li 0,0
	stw 0,552(31)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,376(31)
	xoris 3,3,0x8000
	stw 3,28(1)
	stw 29,24(1)
	lfd 13,24(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,29,12
	frsp 0,0
	stfs 0,376(31)
	bl rand
	rlwinm 3,3,0,17,31
	lwz 0,400(31)
	xoris 3,3,0x8000
	mr 11,9
	lfs 11,380(31)
	stw 3,28(1)
	xoris 0,0,0x8000
	lis 10,.LC38@ha
	stw 29,24(1)
	la 10,.LC38@l(10)
	lfd 13,24(1)
	stw 0,28(1)
	stw 29,24(1)
	fsub 13,13,31
	lfd 12,24(1)
	lfd 10,0(10)
	frsp 13,13
	fsub 12,12,31
	fdivs 13,13,28
	fdiv 10,10,12
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,29,11
	frsp 0,0
	stfs 0,380(31)
	lfs 13,328(30)
	fmul 13,13,10
	frsp 13,13
	stfs 13,384(31)
.L144:
	addi 27,27,1
	lwz 11,maxclients@l(25)
	xoris 0,27,0x8000
	addi 28,28,1116
	stw 0,28(1)
	stw 29,24(1)
	lfd 0,24(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L145
.L143:
	lis 9,level+4@ha
	lfs 0,288(30)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L153
	fmr 0,13
	lis 9,.LC33@ha
	lfd 13,.LC33@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(30)
	b .L154
.L153:
	lwz 0,256(30)
	cmpwi 0,0,0
	bc 12,2,.L154
	mr 3,30
	bl G_FreeEdict
.L154:
	lwz 0,100(1)
	mtlr 0
	lmw 25,36(1)
	lfd 28,64(1)
	lfd 29,72(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe7:
	.size	 target_earthquake_think,.Lfe7-target_earthquake_think
	.section	".rodata"
	.align 2
.LC40:
	.string	"untargeted %s at %s\n"
	.align 2
.LC41:
	.string	"world/quake.wav"
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.section	".text"
	.align 2
	.globl target_laser_use
	.type	 target_laser_use,@function
target_laser_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 10,3
	lwz 11,284(10)
	stw 5,548(10)
	andi. 0,11,1
	bc 12,2,.L92
	lwz 0,184(10)
	rlwinm 11,11,0,0,30
	li 9,0
	stw 9,428(10)
	ori 0,0,1
	stw 11,284(10)
	stw 0,184(10)
	b .L94
.L92:
	cmpwi 0,5,0
	bc 4,2,.L95
	stw 10,548(10)
.L95:
	lwz 0,284(10)
	mr 3,10
	lwz 9,184(10)
	oris 0,0,0x8000
	ori 0,0,1
	rlwinm 9,9,0,0,30
	stw 0,284(10)
	stw 9,184(10)
	bl target_laser_think
.L94:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 target_laser_use,.Lfe8-target_laser_use
	.align 2
	.globl target_laser_on
	.type	 target_laser_on,@function
target_laser_on:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 11,3
	lwz 0,548(11)
	cmpwi 0,0,0
	bc 4,2,.L89
	stw 11,548(11)
.L89:
	lwz 0,284(11)
	mr 3,11
	lwz 9,184(11)
	oris 0,0,0x8000
	ori 0,0,1
	rlwinm 9,9,0,0,30
	stw 0,284(11)
	stw 9,184(11)
	bl target_laser_think
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 target_laser_on,.Lfe9-target_laser_on
	.align 2
	.globl target_laser_off
	.type	 target_laser_off,@function
target_laser_off:
	lwz 0,284(3)
	li 11,0
	lwz 9,184(3)
	rlwinm 0,0,0,0,30
	stw 11,428(3)
	ori 9,9,1
	stw 0,284(3)
	stw 9,184(3)
	blr
.Lfe10:
	.size	 target_laser_off,.Lfe10-target_laser_off
	.align 2
	.globl Use_Target_Tent
	.type	 Use_Target_Tent,@function
Use_Target_Tent:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 4,3
	li 5,2
	lwz 3,644(4)
	addi 4,4,4
	bl G_PointEntity
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe11:
	.size	 Use_Target_Tent,.Lfe11-Use_Target_Tent
	.align 2
	.globl SP_target_temp_entity
	.type	 SP_target_temp_entity,@function
SP_target_temp_entity:
	lis 9,Use_Target_Tent@ha
	la 9,Use_Target_Tent@l(9)
	stw 9,448(3)
	blr
.Lfe12:
	.size	 SP_target_temp_entity,.Lfe12-SP_target_temp_entity
	.section	".rodata"
	.align 2
.LC42:
	.long 0x0
	.section	".text"
	.align 2
	.globl Use_Target_Speaker
	.type	 Use_Target_Speaker,@function
Use_Target_Speaker:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 5,284(3)
	andi. 0,5,3
	bc 12,2,.L9
	lwz 0,76(3)
	cmpwi 0,0,0
	bc 12,2,.L10
	li 0,0
	stw 0,76(3)
	b .L12
.L10:
	lwz 0,576(3)
	stw 0,76(3)
	b .L12
.L9:
	lis 9,gi+20@ha
	rlwinm 5,5,0,29,29
	lwz 0,gi+20@l(9)
	neg 5,5
	mr 4,3
	srawi 5,5,31
	lis 9,.LC42@ha
	lwz 6,576(4)
	andi. 5,5,18
	la 9,.LC42@l(9)
	lfs 1,584(4)
	mtlr 0
	addi 3,3,4
	lfs 3,0(9)
	ori 5,5,2
	lfs 2,588(4)
	blrl
.L12:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe13:
	.size	 Use_Target_Speaker,.Lfe13-Use_Target_Speaker
	.align 2
	.globl Use_Target_Help
	.type	 Use_Target_Help,@function
Use_Target_Help:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,284(3)
	andi. 9,0,1
	bc 12,2,.L25
	lwz 4,276(3)
	li 5,511
	lis 3,game@ha
	la 3,game@l(3)
	bl strncpy
	b .L26
.L25:
	lwz 4,276(3)
	li 5,511
	lis 3,game+512@ha
	la 3,game+512@l(3)
	bl strncpy
.L26:
	lis 11,game@ha
	la 11,game@l(11)
	lwz 9,1024(11)
	addi 9,9,1
	stw 9,1024(11)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe14:
	.size	 Use_Target_Help,.Lfe14-Use_Target_Help
	.align 2
	.globl SP_target_help
	.type	 SP_target_help,@function
SP_target_help:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe15:
	.size	 SP_target_help,.Lfe15-SP_target_help
	.section	".rodata"
	.align 2
.LC43:
	.long 0x3f800000
	.align 2
.LC44:
	.long 0x0
	.section	".text"
	.align 2
	.globl use_target_secret
	.type	 use_target_secret,@function
use_target_secret:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,gi+16@ha
	mr 29,3
	lwz 0,gi+16@l(9)
	mr 28,5
	lis 9,.LC43@ha
	lwz 5,576(29)
	li 4,2
	la 9,.LC43@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 2,0(9)
	lis 9,.LC44@ha
	la 9,.LC44@l(9)
	lfs 3,0(9)
	blrl
	lis 11,level@ha
	mr 3,29
	la 11,level@l(11)
	mr 4,28
	lwz 9,272(11)
	addi 9,9,1
	stw 9,272(11)
	bl G_UseTargets
	mr 3,29
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 use_target_secret,.Lfe16-use_target_secret
	.align 2
	.globl SP_target_secret
	.type	 SP_target_secret,@function
SP_target_secret:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe17:
	.size	 SP_target_secret,.Lfe17-SP_target_secret
	.section	".rodata"
	.align 2
.LC45:
	.long 0x3f800000
	.align 2
.LC46:
	.long 0x0
	.section	".text"
	.align 2
	.globl use_target_goal
	.type	 use_target_goal,@function
use_target_goal:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 31,3
	la 29,gi@l(9)
	mr 30,5
	lis 9,.LC45@ha
	lwz 11,16(29)
	la 9,.LC45@l(9)
	li 4,2
	lwz 5,576(31)
	lfs 1,0(9)
	mtlr 11
	lis 9,.LC45@ha
	la 9,.LC45@l(9)
	lfs 2,0(9)
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	lfs 3,0(9)
	blrl
	lis 11,level@ha
	la 11,level@l(11)
	lwz 9,280(11)
	lwz 0,276(11)
	addi 9,9,1
	cmpw 0,9,0
	stw 9,280(11)
	bc 4,2,.L31
	lwz 0,24(29)
	lis 4,.LC5@ha
	li 3,1
	la 4,.LC5@l(4)
	mtlr 0
	blrl
.L31:
	mr 3,31
	mr 4,30
	bl G_UseTargets
	mr 3,31
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 use_target_goal,.Lfe18-use_target_goal
	.align 2
	.globl SP_target_goal
	.type	 SP_target_goal,@function
SP_target_goal:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe19:
	.size	 SP_target_goal,.Lfe19-SP_target_goal
	.section	".rodata"
	.align 3
.LC47:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl target_explosion_explode
	.type	 target_explosion_explode,@function
target_explosion_explode:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	mr 29,3
	li 5,2
	li 3,5
	addi 4,29,4
	bl G_PointEntity
	lwz 9,516(29)
	lis 8,0x4330
	mr 10,11
	lis 7,.LC47@ha
	lwz 4,548(29)
	xoris 0,9,0x8000
	la 7,.LC47@l(7)
	stw 0,20(1)
	addi 9,9,40
	li 6,25
	stw 8,16(1)
	xoris 9,9,0x8000
	mr 3,29
	lfd 1,16(1)
	li 5,0
	stw 9,20(1)
	stw 8,16(1)
	lfd 0,0(7)
	lfd 2,16(1)
	fsub 1,1,0
	fsub 2,2,0
	frsp 1,1
	frsp 2,2
	bl T_RadiusDamage
	lfs 31,596(29)
	li 0,0
	mr 3,29
	lwz 4,548(29)
	stw 0,596(29)
	bl G_UseTargets
	stfs 31,596(29)
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe20:
	.size	 target_explosion_explode,.Lfe20-target_explosion_explode
	.section	".rodata"
	.align 2
.LC48:
	.long 0x0
	.align 3
.LC49:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl use_target_explosion
	.type	 use_target_explosion,@function
use_target_explosion:
	stwu 1,-48(1)
	mflr 0
	stfd 30,32(1)
	stfd 31,40(1)
	stw 31,28(1)
	stw 0,52(1)
	lis 7,.LC48@ha
	mr 31,3
	la 7,.LC48@l(7)
	lfs 13,596(31)
	lfs 30,0(7)
	stw 5,548(31)
	fcmpu 0,13,30
	bc 4,2,.L35
	li 3,5
	addi 4,31,4
	li 5,2
	bl G_PointEntity
	lwz 9,516(31)
	lis 8,0x4330
	mr 10,11
	lis 7,.LC49@ha
	lwz 4,548(31)
	xoris 0,9,0x8000
	la 7,.LC49@l(7)
	stw 0,20(1)
	addi 9,9,40
	li 6,25
	stw 8,16(1)
	xoris 9,9,0x8000
	mr 3,31
	lfd 1,16(1)
	li 5,0
	stw 9,20(1)
	stw 8,16(1)
	lfd 0,0(7)
	lfd 2,16(1)
	fsub 1,1,0
	fsub 2,2,0
	frsp 1,1
	frsp 2,2
	bl T_RadiusDamage
	lfs 31,596(31)
	mr 3,31
	lwz 4,548(31)
	stfs 30,596(31)
	bl G_UseTargets
	stfs 31,596(31)
	b .L34
.L35:
	lis 9,target_explosion_explode@ha
	lis 11,level+4@ha
	la 9,target_explosion_explode@l(9)
	stw 9,436(31)
	lfs 0,level+4@l(11)
	fadds 0,0,13
	stfs 0,428(31)
.L34:
	lwz 0,52(1)
	mtlr 0
	lwz 31,28(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe21:
	.size	 use_target_explosion,.Lfe21-use_target_explosion
	.align 2
	.globl SP_target_explosion
	.type	 SP_target_explosion,@function
SP_target_explosion:
	lis 9,use_target_explosion@ha
	li 0,1
	la 9,use_target_explosion@l(9)
	stw 0,184(3)
	stw 9,448(3)
	blr
.Lfe22:
	.size	 SP_target_explosion,.Lfe22-SP_target_explosion
	.align 2
	.globl SP_target_changelevel
	.type	 SP_target_changelevel,@function
SP_target_changelevel:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,504(31)
	cmpwi 0,0,0
	bc 4,2,.L47
	lis 29,gi@ha
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 4,3
	lwz 0,4(29)
	lis 3,.LC9@ha
	la 3,.LC9@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L46
.L47:
	lis 3,level+72@ha
	lis 4,.LC10@ha
	la 3,level+72@l(3)
	la 4,.LC10@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L48
	lwz 3,504(31)
	lis 4,.LC11@ha
	la 4,.LC11@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L48
	lis 9,.LC12@ha
	la 9,.LC12@l(9)
	stw 9,504(31)
.L48:
	lis 9,use_target_changelevel@ha
	li 0,1
	la 9,use_target_changelevel@l(9)
	stw 0,184(31)
	stw 9,448(31)
.L46:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe23:
	.size	 SP_target_changelevel,.Lfe23-SP_target_changelevel
	.section	".rodata"
	.align 3
.LC50:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl use_target_splash
	.type	 use_target_splash,@function
use_target_splash:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	mr 30,5
	lwz 4,532(31)
	li 3,10
	addi 5,31,4
	lwz 7,644(31)
	addi 6,31,340
	li 8,2
	bl G_SplashEntity
	lwz 11,516(31)
	cmpwi 0,11,0
	bc 12,2,.L50
	xoris 0,11,0x8000
	stw 0,20(1)
	lis 10,0x4330
	mr 3,31
	stw 10,16(1)
	addi 0,11,40
	mr 4,30
	mr 11,9
	lfd 1,16(1)
	xoris 0,0,0x8000
	lis 9,.LC50@ha
	stw 0,20(1)
	li 5,0
	la 9,.LC50@l(9)
	stw 10,16(1)
	li 6,29
	lfd 0,0(9)
	lfd 2,16(1)
	fsub 1,1,0
	fsub 2,2,0
	frsp 1,1
	frsp 2,2
	bl T_RadiusDamage
.L50:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe24:
	.size	 use_target_splash,.Lfe24-use_target_splash
	.align 2
	.globl SP_target_splash
	.type	 SP_target_splash,@function
SP_target_splash:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,use_target_splash@ha
	mr 31,3
	la 9,use_target_splash@l(9)
	addi 3,31,16
	stw 9,448(31)
	addi 4,31,340
	bl G_SetMovedir
	lwz 0,532(31)
	cmpwi 0,0,0
	bc 4,2,.L52
	li 0,32
	stw 0,532(31)
.L52:
	li 0,1
	stw 0,184(31)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe25:
	.size	 SP_target_splash,.Lfe25-SP_target_splash
	.section	".rodata"
	.align 2
.LC51:
	.long 0x0
	.section	".text"
	.align 2
	.globl use_target_spawner
	.type	 use_target_spawner,@function
use_target_spawner:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 30,3
	bl G_Spawn
	lwz 0,296(30)
	mr 31,3
	stw 0,280(31)
	lfs 0,4(30)
	stfs 0,4(31)
	lfs 13,8(30)
	stfs 13,8(31)
	lfs 0,12(30)
	stfs 0,12(31)
	lfs 13,16(30)
	stfs 13,16(31)
	lfs 0,20(30)
	stfs 0,20(31)
	lfs 13,24(30)
	stfs 13,24(31)
	bl ED_CallSpawn
	lis 29,gi@ha
	mr 3,31
	la 29,gi@l(29)
	lwz 9,76(29)
	mtlr 9
	blrl
	mr 3,31
	bl KillBox
	lwz 0,72(29)
	mr 3,31
	mtlr 0
	blrl
	lis 9,.LC51@ha
	lfs 13,328(30)
	la 9,.LC51@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L54
	lfs 0,340(30)
	stfs 0,376(31)
	lfs 13,344(30)
	stfs 13,380(31)
	lfs 0,348(30)
	stfs 0,384(31)
.L54:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe26:
	.size	 use_target_spawner,.Lfe26-use_target_spawner
	.section	".rodata"
	.align 2
.LC52:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_target_spawner
	.type	 SP_target_spawner,@function
SP_target_spawner:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,.LC52@ha
	mr 31,3
	la 9,.LC52@l(9)
	lfs 0,328(31)
	li 0,1
	lfs 13,0(9)
	lis 9,use_target_spawner@ha
	stw 0,184(31)
	la 9,use_target_spawner@l(9)
	fcmpu 0,0,13
	stw 9,448(31)
	bc 12,2,.L56
	addi 29,31,340
	addi 3,31,16
	mr 4,29
	bl G_SetMovedir
	lfs 1,328(31)
	mr 3,29
	mr 4,3
	bl VectorScale
.L56:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe27:
	.size	 SP_target_spawner,.Lfe27-SP_target_spawner
	.section	".rodata"
	.align 2
.LC53:
	.long 0x3f800000
	.align 2
.LC54:
	.long 0x0
	.section	".text"
	.align 2
	.globl use_target_blaster
	.type	 use_target_blaster,@function
use_target_blaster:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 29,3
	lfs 0,328(29)
	addi 4,29,4
	lwz 6,516(29)
	addi 5,29,340
	li 9,33
	li 8,8
	fctiwz 13,0
	stfd 13,24(1)
	lwz 7,28(1)
	bl fire_blaster
	lis 9,gi+16@ha
	mr 3,29
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC53@ha
	lwz 5,576(3)
	la 9,.LC53@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC53@ha
	la 9,.LC53@l(9)
	lfs 2,0(9)
	lis 9,.LC54@ha
	la 9,.LC54@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe28:
	.size	 use_target_blaster,.Lfe28-use_target_blaster
	.section	".rodata"
	.align 2
.LC55:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_target_blaster
	.type	 SP_target_blaster,@function
SP_target_blaster:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,use_target_blaster@ha
	mr 31,3
	la 9,use_target_blaster@l(9)
	addi 3,31,16
	addi 4,31,340
	stw 9,448(31)
	bl G_SetMovedir
	lis 9,gi+36@ha
	lis 3,.LC13@ha
	lwz 0,gi+36@l(9)
	la 3,.LC13@l(3)
	mtlr 0
	blrl
	lwz 0,516(31)
	stw 3,576(31)
	cmpwi 0,0,0
	bc 4,2,.L63
	li 0,15
	stw 0,516(31)
.L63:
	lis 9,.LC55@ha
	lfs 13,328(31)
	la 9,.LC55@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L64
	lis 0,0x447a
	stw 0,328(31)
.L64:
	li 0,1
	stw 0,184(31)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe29:
	.size	 SP_target_blaster,.Lfe29-SP_target_blaster
	.align 2
	.globl trigger_crosslevel_trigger_use
	.type	 trigger_crosslevel_trigger_use,@function
trigger_crosslevel_trigger_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,game@ha
	lwz 11,284(3)
	la 9,game@l(9)
	lwz 0,1552(9)
	or 0,0,11
	stw 0,1552(9)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe30:
	.size	 trigger_crosslevel_trigger_use,.Lfe30-trigger_crosslevel_trigger_use
	.align 2
	.globl SP_target_crosslevel_trigger
	.type	 SP_target_crosslevel_trigger,@function
SP_target_crosslevel_trigger:
	lis 9,trigger_crosslevel_trigger_use@ha
	li 0,1
	la 9,trigger_crosslevel_trigger_use@l(9)
	stw 0,184(3)
	stw 9,448(3)
	blr
.Lfe31:
	.size	 SP_target_crosslevel_trigger,.Lfe31-SP_target_crosslevel_trigger
	.align 2
	.globl target_crosslevel_target_think
	.type	 target_crosslevel_target_think,@function
target_crosslevel_target_think:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 11,game+1552@ha
	lwz 10,284(31)
	lwz 0,game+1552@l(11)
	rlwinm 9,10,0,24,31
	and 0,0,9
	cmpw 0,10,0
	bc 4,2,.L68
	mr 4,31
	bl G_UseTargets
	mr 3,31
	bl G_FreeEdict
.L68:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe32:
	.size	 target_crosslevel_target_think,.Lfe32-target_crosslevel_target_think
	.section	".rodata"
	.align 2
.LC56:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_target_crosslevel_target
	.type	 SP_target_crosslevel_target,@function
SP_target_crosslevel_target:
	lis 9,.LC56@ha
	lfs 0,596(3)
	la 9,.LC56@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L70
	lis 0,0x3f80
	stw 0,596(3)
.L70:
	lis 9,target_crosslevel_target_think@ha
	li 0,1
	lfs 13,596(3)
	la 9,target_crosslevel_target_think@l(9)
	stw 0,184(3)
	lis 11,level+4@ha
	stw 9,436(3)
	lfs 0,level+4@l(11)
	fadds 0,0,13
	stfs 0,428(3)
	blr
.Lfe33:
	.size	 SP_target_crosslevel_target,.Lfe33-SP_target_crosslevel_target
	.section	".rodata"
	.align 2
.LC57:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl SP_target_laser
	.type	 SP_target_laser,@function
SP_target_laser:
	lis 9,target_laser_start@ha
	lis 11,level+4@ha
	la 9,target_laser_start@l(9)
	stw 9,436(3)
	lis 9,.LC57@ha
	lfs 0,level+4@l(11)
	la 9,.LC57@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,428(3)
	blr
.Lfe34:
	.size	 SP_target_laser,.Lfe34-SP_target_laser
	.align 2
	.globl target_lightramp_use
	.type	 target_lightramp_use,@function
target_lightramp_use:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L127
	lis 9,gi@ha
	li 27,0
	la 30,gi@l(9)
	lis 24,.LC24@ha
	lis 25,.LC25@ha
	lis 26,.LC26@ha
	b .L130
.L131:
	lwz 3,280(27)
	la 4,.LC24@l(24)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L132
	lwz 29,280(31)
	addi 3,31,4
	bl vtos
	lwz 9,4(30)
	mr 5,3
	mr 4,29
	la 3,.LC25@l(25)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 29,296(31)
	addi 3,27,4
	lwz 28,280(27)
	bl vtos
	lwz 9,4(30)
	mr 6,3
	mr 4,29
	mr 5,28
	la 3,.LC26@l(26)
	mtlr 9
	crxor 6,6,6
	blrl
	b .L130
.L132:
	stw 27,540(31)
.L130:
	lwz 5,296(31)
	mr 3,27
	li 4,300
	bl G_Find
	mr. 27,3
	bc 4,2,.L131
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L127
	lis 29,gi@ha
	lwz 27,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	lwz 28,296(31)
	bl vtos
	mr 6,3
	lwz 0,4(29)
	mr 4,27
	lis 3,.LC27@ha
	mr 5,28
	la 3,.LC27@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L126
.L127:
	lis 9,level+4@ha
	mr 3,31
	lfs 0,level+4@l(9)
	stfs 0,288(31)
	bl target_lightramp_think
.L126:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe35:
	.size	 target_lightramp_use,.Lfe35-target_lightramp_use
	.section	".rodata"
	.align 3
.LC58:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC59:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl target_earthquake_use
	.type	 target_earthquake_use,@function
target_earthquake_use:
	stwu 1,-16(1)
	lwz 0,532(3)
	lis 8,0x4330
	lis 9,.LC59@ha
	lis 10,.LC58@ha
	xoris 0,0,0x8000
	la 9,.LC59@l(9)
	lfd 11,.LC58@l(10)
	stw 0,12(1)
	li 10,0
	stw 8,8(1)
	lfd 12,0(9)
	lfd 0,8(1)
	lis 9,level@ha
	la 9,level@l(9)
	lfs 13,4(9)
	fsub 0,0,12
	frsp 0,0
	fadds 13,13,0
	stfs 13,288(3)
	lfs 0,4(9)
	stw 10,476(3)
	stw 5,548(3)
	fadd 0,0,11
	frsp 0,0
	stfs 0,428(3)
	la 1,16(1)
	blr
.Lfe36:
	.size	 target_earthquake_use,.Lfe36-target_earthquake_use
	.section	".rodata"
	.align 2
.LC60:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_target_earthquake
	.type	 SP_target_earthquake,@function
SP_target_earthquake:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 4,2,.L158
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC40@ha
	la 3,.LC40@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L158:
	lwz 0,532(31)
	cmpwi 0,0,0
	bc 4,2,.L159
	li 0,5
	stw 0,532(31)
.L159:
	lis 9,.LC60@ha
	lfs 13,328(31)
	la 9,.LC60@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L160
	lis 0,0x4348
	stw 0,328(31)
.L160:
	lwz 0,184(31)
	lis 9,target_earthquake_think@ha
	lis 11,target_earthquake_use@ha
	la 9,target_earthquake_think@l(9)
	la 11,target_earthquake_use@l(11)
	ori 0,0,1
	stw 9,436(31)
	lis 10,gi+36@ha
	stw 0,184(31)
	lis 3,.LC41@ha
	stw 11,448(31)
	la 3,.LC41@l(3)
	lwz 0,gi+36@l(10)
	mtlr 0
	blrl
	stw 3,576(31)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe37:
	.size	 SP_target_earthquake,.Lfe37-SP_target_earthquake
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
