	.file	"g_cmd_teleport.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 stuff_light,@object
	.size	 stuff_light,4
stuff_light:
	.long 1
	.section	".rodata"
	.align 2
.LC0:
	.string	"max_teleport_shots"
	.align 2
.LC1:
	.string	"1"
	.align 2
.LC2:
	.string	"teleport_health"
	.align 2
.LC3:
	.string	"0"
	.align 2
.LC4:
	.string	"teleport_panic_time"
	.align 2
.LC5:
	.string	"15"
	.align 2
.LC6:
	.string	"Only predators can teleport\n"
	.align 2
.LC7:
	.string	"Teleporter not enabled\n"
	.align 2
.LC8:
	.string	"No more teleport shots left\n"
	.align 2
.LC9:
	.string	"Teleport location stored!\nBeam me up, Scotty!\n"
	.align 2
.LC10:
	.long 0x0
	.align 2
.LC11:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl Cmd_Store_Teleport_f
	.type	 Cmd_Store_Teleport_f,@function
Cmd_Store_Teleport_f:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 4,2,.L31
	lis 9,gi+8@ha
	lis 5,.LC6@ha
	lwz 0,gi+8@l(9)
	la 5,.LC6@l(5)
	b .L39
.L31:
	lis 9,max_teleport_shots@ha
	lwz 9,max_teleport_shots@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L33
	lfs 13,20(9)
	lis 9,.LC10@ha
	la 9,.LC10@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L34
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L33
.L34:
	lis 9,gi+148@ha
	lis 3,.LC0@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC1@ha
	la 3,.LC0@l(3)
	la 4,.LC1@l(4)
	mtlr 0
	blrl
.L33:
	lis 10,max_teleport_shots@ha
	lwz 9,max_teleport_shots@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	cmpwi 0,11,0
	bc 12,1,.L32
	lis 9,gi+8@ha
	lis 5,.LC7@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC7@l(5)
.L39:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L30
.L32:
	lwz 9,84(31)
	lwz 0,1820(9)
	cmpwi 0,0,0
	bc 12,1,.L38
	lis 9,gi+12@ha
	lis 4,.LC8@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC8@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L30
.L38:
	lfs 0,4(31)
	li 0,1
	lis 8,gi+12@ha
	lis 4,.LC9@ha
	mr 3,31
	la 4,.LC9@l(4)
	stfs 0,3836(9)
	lfs 0,8(31)
	lwz 9,84(31)
	stfs 0,3840(9)
	lfs 0,12(31)
	lwz 11,84(31)
	stfs 0,3844(11)
	lfs 0,16(31)
	lwz 9,84(31)
	stfs 0,3824(9)
	lfs 0,20(31)
	lwz 11,84(31)
	stfs 0,3828(11)
	lfs 0,24(31)
	lwz 10,84(31)
	stfs 0,3832(10)
	lwz 9,84(31)
	stw 0,3820(9)
	lwz 0,gi+12@l(8)
	mtlr 0
	crxor 6,6,6
	blrl
.L30:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Cmd_Store_Teleport_f,.Lfe1-Cmd_Store_Teleport_f
	.section	".rodata"
	.align 2
.LC12:
	.string	"Panic mode disabled. Run!\n"
	.align 2
.LC13:
	.string	"You don't have enough health to teleport\n"
	.align 2
.LC14:
	.long 0x0
	.align 2
.LC15:
	.long 0x41a00000
	.align 2
.LC16:
	.long 0x43480000
	.align 2
.LC17:
	.long 0x47800000
	.align 2
.LC18:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl Cmd_Load_Teleport_f
	.type	 Cmd_Load_Teleport_f,@function
Cmd_Load_Teleport_f:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 31,3
	li 4,0
	addi 3,1,8
	li 5,12
	crxor 6,6,6
	bl memset
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L40
	lwz 0,896(31)
	cmpwi 0,0,0
	bc 4,2,.L42
	lis 9,gi+8@ha
	lis 5,.LC6@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC6@l(5)
	b .L64
.L42:
	lis 9,max_teleport_shots@ha
	lwz 9,max_teleport_shots@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L44
	lfs 13,20(9)
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L45
	lis 11,.LC15@ha
	la 11,.LC15@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L44
.L45:
	lis 9,gi+148@ha
	lis 3,.LC0@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC1@ha
	la 3,.LC0@l(3)
	la 4,.LC1@l(4)
	mtlr 0
	blrl
.L44:
	lis 10,max_teleport_shots@ha
	lwz 9,max_teleport_shots@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	cmpwi 0,11,0
	bc 12,1,.L43
	lis 9,gi+8@ha
	lis 5,.LC7@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC7@l(5)
.L64:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L40
.L43:
	lwz 9,84(31)
	lwz 0,1820(9)
	cmpwi 0,0,0
	bc 12,1,.L49
	lis 9,gi+12@ha
	lis 4,.LC8@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC8@l(4)
	b .L65
.L49:
	li 0,1
	li 10,122
	stw 0,3712(9)
	li 11,134
	lwz 9,84(31)
	stw 10,56(31)
	stw 11,3708(9)
	lwz 10,84(31)
	lwz 0,3820(10)
	cmpwi 0,0,0
	bc 4,2,.L50
	lis 11,level+4@ha
	lwz 0,3848(10)
	lfs 0,level+4@l(11)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	cmpw 0,0,9
	bc 4,0,.L51
	lis 9,gi+12@ha
	lis 4,.LC12@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC12@l(4)
	b .L65
.L51:
	mr 3,31
	bl randomTeleport
	b .L40
.L50:
	lis 9,teleport_health@ha
	lwz 9,teleport_health@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L53
	lfs 13,20(9)
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L54
	lis 11,.LC16@ha
	la 11,.LC16@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L53
.L54:
	lis 9,gi+148@ha
	lis 3,.LC2@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC3@ha
	la 3,.LC2@l(3)
	la 4,.LC3@l(4)
	mtlr 0
	blrl
.L53:
	lis 10,teleport_health@ha
	lwz 0,480(31)
	lwz 9,teleport_health@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	cmpw 0,0,11
	bc 4,0,.L52
	lis 9,gi+12@ha
	lis 4,.LC13@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC13@l(4)
.L65:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L40
.L52:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	addi 28,31,4
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,22
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,88(29)
	mr 3,28
	li 4,2
	mtlr 9
	blrl
	lwz 0,76(29)
	mr 3,31
	mtlr 0
	blrl
	lis 9,.LC17@ha
	lis 11,.LC18@ha
	la 9,.LC17@l(9)
	la 11,.LC18@l(11)
	lfs 10,0(9)
	li 0,0
	li 10,20
	lwz 9,84(31)
	li 8,6
	li 6,0
	lfs 11,0(11)
	li 7,0
	lfs 13,3836(9)
	li 11,3
	mtctr 11
	stfs 13,4(31)
	lfs 0,3840(9)
	stfs 0,8(31)
	lfs 13,3844(9)
	stfs 13,12(31)
	lfs 0,3836(9)
	stfs 0,28(31)
	lfs 13,3840(9)
	stfs 13,32(31)
	lfs 0,3844(9)
	stw 0,376(31)
	stw 0,384(31)
	stfs 0,36(31)
	stw 0,380(31)
	stb 10,17(9)
	lwz 11,84(31)
	lbz 0,16(11)
	ori 0,0,32
	stb 0,16(11)
	stw 8,80(31)
.L63:
	lwz 11,84(31)
	add 0,6,6
	addi 6,6,1
	addi 10,11,3468
	addi 9,11,3824
	lfsx 0,9,7
	addi 11,11,20
	lfsx 13,10,7
	addi 7,7,4
	fsubs 0,0,13
	fmuls 0,0,10
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,24(1)
	lwz 8,28(1)
	sthx 8,11,0
	bdnz .L63
	li 0,0
	lwz 11,84(31)
	mr 3,31
	stw 0,24(31)
	stw 0,20(31)
	stw 0,16(31)
	stw 0,28(11)
	stw 0,36(11)
	stw 0,32(11)
	lwz 9,84(31)
	stw 0,3652(9)
	stw 0,3660(9)
	stw 0,3656(9)
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 11,84(31)
	lwz 9,1820(11)
	addi 9,9,-1
	stw 9,1820(11)
.L40:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 Cmd_Load_Teleport_f,.Lfe2-Cmd_Load_Teleport_f
	.section	".rodata"
	.align 2
.LC19:
	.string	"misc/tele1.wav"
	.align 2
.LC20:
	.long 0x47800000
	.align 2
.LC21:
	.long 0x43b40000
	.align 2
.LC22:
	.long 0x41000000
	.align 2
.LC23:
	.long 0x3f800000
	.align 2
.LC24:
	.long 0x0
	.section	".text"
	.align 2
	.globl randomTeleport
	.type	 randomTeleport,@function
randomTeleport:
	stwu 1,-64(1)
	mflr 0
	stmw 28,48(1)
	stw 0,68(1)
	mr 31,3
	addi 28,1,8
	addi 29,1,24
	li 4,0
	li 5,12
	mr 3,28
	crxor 6,6,6
	bl memset
	li 4,0
	li 5,12
	mr 3,29
	crxor 6,6,6
	bl memset
	lwz 0,184(31)
	mr 4,28
	mr 3,31
	mr 5,29
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	crxor 6,6,6
	bl SelectSpawnPoint
	lis 7,.LC20@ha
	lfs 0,8(1)
	lis 9,.LC21@ha
	la 7,.LC20@l(7)
	la 9,.LC21@l(9)
	lwz 8,84(31)
	lfs 7,0(7)
	li 0,3
	li 6,0
	lis 7,.LC22@ha
	lfs 8,0(9)
	mtctr 0
	la 7,.LC22@l(7)
	lfs 10,0(7)
	mr 11,9
	mr 10,9
	lis 7,.LC23@ha
	la 7,.LC23@l(7)
	fmuls 0,0,10
	lfs 9,0(7)
	li 7,0
	fctiwz 13,0
	stfd 13,40(1)
	lwz 9,44(1)
	sth 9,4(8)
	lfs 0,12(1)
	lwz 9,84(31)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,40(1)
	lwz 11,44(1)
	sth 11,6(9)
	lfs 0,16(1)
	lwz 9,84(31)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,40(1)
	lwz 10,44(1)
	sth 10,8(9)
	lfs 0,16(1)
	lfs 12,8(1)
	lfs 13,12(1)
	fadds 0,0,9
	stfs 12,28(31)
	stfs 13,32(31)
	stfs 0,36(31)
	stfs 12,4(31)
	stfs 13,8(31)
	stfs 0,12(31)
.L72:
	lwz 10,84(31)
	add 0,6,6
	lfsx 0,7,29
	addi 6,6,1
	addi 9,10,3468
	lfsx 13,9,7
	addi 10,10,20
	addi 7,7,4
	fsubs 0,0,13
	fmuls 0,0,7
	fdivs 0,0,8
	fctiwz 12,0
	stfd 12,40(1)
	lwz 11,44(1)
	sthx 11,10,0
	bdnz .L72
	lfs 0,28(1)
	li 0,0
	lis 10,level+4@ha
	lwz 11,84(31)
	li 8,6
	lis 29,gi@ha
	stw 0,24(31)
	la 29,gi@l(29)
	lis 3,.LC19@ha
	stfs 0,20(31)
	la 3,.LC19@l(3)
	stw 0,16(31)
	stw 0,28(11)
	lfs 0,20(31)
	lwz 9,84(31)
	stfs 0,32(9)
	lfs 0,24(31)
	lwz 11,84(31)
	stfs 0,36(11)
	lfs 0,16(31)
	lwz 9,84(31)
	stfs 0,3652(9)
	lfs 0,20(31)
	lwz 11,84(31)
	stfs 0,3656(11)
	lfs 0,24(31)
	lwz 9,84(31)
	stfs 0,3660(9)
	lfs 13,level+4@l(10)
	lwz 9,84(31)
	stfs 13,3808(9)
	stw 8,80(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 7,.LC23@ha
	lwz 0,16(29)
	lis 9,.LC23@ha
	la 7,.LC23@l(7)
	mr 5,3
	lfs 1,0(7)
	la 9,.LC23@l(9)
	li 4,2
	mtlr 0
	lis 7,.LC24@ha
	mr 3,31
	lfs 2,0(9)
	la 7,.LC24@l(7)
	lfs 3,0(7)
	blrl
	lwz 0,68(1)
	mtlr 0
	lmw 28,48(1)
	la 1,64(1)
	blr
.Lfe3:
	.size	 randomTeleport,.Lfe3-randomTeleport
	.comm	showscores,4,4
	.comm	nextdynamicset,4,4
	.comm	predatorModel,32,4
	.comm	predatorSkin,64,4
	.comm	marineSkin,64,4
	.section	".rodata"
	.align 2
.LC25:
	.long 0x0
	.align 2
.LC26:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl validateMaxTeleportShots
	.type	 validateMaxTeleportShots,@function
validateMaxTeleportShots:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC25@ha
	lis 9,max_teleport_shots@ha
	la 11,.LC25@l(11)
	lfs 0,0(11)
	lwz 11,max_teleport_shots@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L8
	lis 9,.LC26@ha
	la 9,.LC26@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L7
.L8:
	lis 9,gi+148@ha
	lis 3,.LC0@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC1@ha
	la 3,.LC0@l(3)
	la 4,.LC1@l(4)
	mtlr 0
	blrl
.L7:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe4:
	.size	 validateMaxTeleportShots,.Lfe4-validateMaxTeleportShots
	.section	".rodata"
	.align 2
.LC27:
	.long 0x0
	.align 2
.LC28:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl getMaxTeleportShots
	.type	 getMaxTeleportShots,@function
getMaxTeleportShots:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,max_teleport_shots@ha
	lwz 9,max_teleport_shots@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L10
	lfs 13,20(9)
	lis 9,.LC27@ha
	la 9,.LC27@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L11
	lis 9,.LC28@ha
	la 9,.LC28@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L10
.L11:
	lis 9,gi+148@ha
	lis 3,.LC0@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC1@ha
	la 3,.LC0@l(3)
	la 4,.LC1@l(4)
	mtlr 0
	blrl
.L10:
	lis 11,max_teleport_shots@ha
	lwz 9,max_teleport_shots@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe5:
	.size	 getMaxTeleportShots,.Lfe5-getMaxTeleportShots
	.section	".rodata"
	.align 2
.LC29:
	.long 0x0
	.align 2
.LC30:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl validateTeleportHealth
	.type	 validateTeleportHealth,@function
validateTeleportHealth:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC29@ha
	lis 9,teleport_health@ha
	la 11,.LC29@l(11)
	lfs 0,0(11)
	lwz 11,teleport_health@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L16
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L15
.L16:
	lis 9,gi+148@ha
	lis 3,.LC2@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC3@ha
	la 3,.LC2@l(3)
	la 4,.LC3@l(4)
	mtlr 0
	blrl
.L15:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 validateTeleportHealth,.Lfe6-validateTeleportHealth
	.section	".rodata"
	.align 2
.LC31:
	.long 0x0
	.align 2
.LC32:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl getTeleportHealth
	.type	 getTeleportHealth,@function
getTeleportHealth:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,teleport_health@ha
	lwz 9,teleport_health@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L18
	lfs 13,20(9)
	lis 9,.LC31@ha
	la 9,.LC31@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L19
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L18
.L19:
	lis 9,gi+148@ha
	lis 3,.LC2@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC3@ha
	la 3,.LC2@l(3)
	la 4,.LC3@l(4)
	mtlr 0
	blrl
.L18:
	lis 11,teleport_health@ha
	lwz 9,teleport_health@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe7:
	.size	 getTeleportHealth,.Lfe7-getTeleportHealth
	.section	".rodata"
	.align 2
.LC33:
	.long 0x0
	.align 2
.LC34:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl validatePanicTime
	.type	 validatePanicTime,@function
validatePanicTime:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC33@ha
	lis 9,teleport_panic_time@ha
	la 11,.LC33@l(11)
	lfs 0,0(11)
	lwz 11,teleport_panic_time@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L24
	lis 9,.LC34@ha
	la 9,.LC34@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L23
.L24:
	lis 9,gi+148@ha
	lis 3,.LC4@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC5@ha
	la 3,.LC4@l(3)
	la 4,.LC5@l(4)
	mtlr 0
	blrl
.L23:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 validatePanicTime,.Lfe8-validatePanicTime
	.section	".rodata"
	.align 2
.LC35:
	.long 0x0
	.align 2
.LC36:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl getPanicTime
	.type	 getPanicTime,@function
getPanicTime:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,teleport_panic_time@ha
	lwz 9,teleport_panic_time@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L26
	lfs 13,20(9)
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L27
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L26
.L27:
	lis 9,gi+148@ha
	lis 3,.LC4@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC5@ha
	la 3,.LC4@l(3)
	la 4,.LC5@l(4)
	mtlr 0
	blrl
.L26:
	lis 11,teleport_panic_time@ha
	lwz 9,teleport_panic_time@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 getPanicTime,.Lfe9-getPanicTime
	.comm	maplist_lastmap,64,4
	.comm	maplist2_lastmap,64,4
	.comm	maplist3_lastmap,64,4
	.comm	last_beat,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
