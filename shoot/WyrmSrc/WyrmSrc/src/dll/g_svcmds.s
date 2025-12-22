	.file	"g_svcmds.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"Svcmd_Test_f()\n"
	.align 2
.LC1:
	.string	"Bad filter address: %s\n"
	.section	".text"
	.align 2
	.type	 StringToFilter,@function
StringToFilter:
	stwu 1,-192(1)
	mflr 0
	stmw 23,156(1)
	stw 0,196(1)
	li 10,4
	addi 28,1,136
	mtctr 10
	addi 29,1,140
	mr 11,28
	mr 9,29
	mr 31,3
	mr 27,4
	li 30,0
	li 0,0
.L26:
	stbx 0,30,11
	stbx 0,30,9
	addi 30,30,1
	bdnz .L26
	lis 9,gi@ha
	li 30,0
	la 24,gi@l(9)
	lis 23,.LC1@ha
	li 25,0
	li 26,255
.L16:
	lbz 9,0(31)
	addi 9,9,-48
	cmplwi 0,9,9
	bc 4,1,.L17
	lwz 0,8(24)
	li 3,0
	la 5,.LC1@l(23)
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
	b .L25
.L17:
	addi 3,1,8
	li 11,0
	mr 10,3
.L20:
	lbz 0,0(31)
	lbzu 9,1(31)
	stbx 0,10,11
	addi 9,9,-48
	addi 11,11,1
	cmplwi 0,9,9
	bc 4,1,.L20
	stbx 25,3,11
	bl atoi
	rlwinm 0,3,0,0xff
	stbx 3,30,28
	cmpwi 0,0,0
	bc 12,2,.L22
	stbx 26,30,29
.L22:
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L14
	addi 30,30,1
	addi 31,31,1
	cmpwi 0,30,3
	bc 4,1,.L16
.L14:
	lwz 9,140(1)
	li 3,1
	lwz 0,136(1)
	stw 9,0(27)
	stw 0,4(27)
.L25:
	lwz 0,196(1)
	mtlr 0
	lmw 23,156(1)
	la 1,192(1)
	blr
.Lfe1:
	.size	 StringToFilter,.Lfe1-StringToFilter
	.section	".rodata"
	.align 2
.LC2:
	.long 0x0
	.section	".text"
	.align 2
	.globl SV_FilterPacket
	.type	 SV_FilterPacket,@function
SV_FilterPacket:
	stwu 1,-32(1)
	lbz 0,0(3)
	li 8,0
	cmpwi 0,0,0
	bc 12,2,.L29
	addi 6,1,8
	li 5,0
.L30:
	stbx 5,8,6
	lbz 10,0(3)
	addi 0,10,-48
	cmplwi 0,0,9
	bc 12,1,.L32
	mr 7,6
	mr 9,5
.L33:
	rlwinm 9,9,0,0xff
	mulli 9,9,10
	addi 9,9,208
	add 11,10,9
	lbzu 10,1(3)
	mr 9,11
	addi 0,10,-48
	cmplwi 0,0,9
	bc 4,1,.L33
	stbx 11,8,7
.L32:
	lbz 0,0(3)
	xori 9,0,58
	subfic 11,9,0
	adde 9,11,9
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 4,2,.L29
	addi 8,8,1
	lbzu 0,1(3)
	cmpwi 7,8,3
	neg 0,0
	srwi 0,0,31
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	and. 11,0,9
	bc 4,2,.L30
.L29:
	lis 9,numipfilters@ha
	li 8,0
	lwz 6,8(1)
	lwz 0,numipfilters@l(9)
	cmpw 0,8,0
	bc 4,0,.L38
	lis 9,filterban@ha
	lis 11,ipfilters@ha
	lwz 7,filterban@l(9)
	mr 10,0
	la 11,ipfilters@l(11)
.L40:
	lwz 0,0(11)
	lwz 9,4(11)
	and 0,6,0
	cmpw 0,0,9
	bc 4,2,.L39
	lfs 0,20(7)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 3,28(1)
	b .L43
.L39:
	addi 8,8,1
	addi 11,11,8
	cmpw 0,8,10
	bc 12,0,.L40
.L38:
	lis 9,.LC2@ha
	lis 11,filterban@ha
	la 9,.LC2@l(9)
	lfs 13,0(9)
	lwz 9,filterban@l(11)
	lfs 0,20(9)
	fcmpu 7,0,13
	mfcr 3
	rlwinm 3,3,31,1
.L43:
	la 1,32(1)
	blr
.Lfe2:
	.size	 SV_FilterPacket,.Lfe2-SV_FilterPacket
	.section	".rodata"
	.align 2
.LC3:
	.string	"Usage:  addip <ip-mask>\n"
	.align 2
.LC4:
	.string	"IP filter list is full\n"
	.section	".text"
	.align 2
	.globl SVCmd_AddIP_f
	.type	 SVCmd_AddIP_f,@function
SVCmd_AddIP_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi@ha
	la 31,gi@l(9)
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,2
	bc 12,1,.L46
	lwz 0,8(31)
	lis 5,.LC3@ha
	li 3,0
	la 5,.LC3@l(5)
	b .L56
.L46:
	lis 9,numipfilters@ha
	li 31,0
	lwz 11,numipfilters@l(9)
	cmpw 0,31,11
	bc 4,0,.L48
	lis 9,ipfilters@ha
	la 9,ipfilters@l(9)
	lwz 0,4(9)
	addi 10,9,4
	cmpwi 0,0,-1
	bc 12,2,.L48
	mr 9,10
.L49:
	addi 31,31,1
	cmpw 0,31,11
	bc 4,0,.L48
	lwzu 0,8(9)
	cmpwi 0,0,-1
	bc 4,2,.L49
.L48:
	lis 9,numipfilters@ha
	lwz 0,numipfilters@l(9)
	cmpw 0,31,0
	bc 4,2,.L53
	cmpwi 0,31,1024
	bc 4,2,.L54
	lis 9,gi+8@ha
	lis 5,.LC4@ha
	lwz 0,gi+8@l(9)
	la 5,.LC4@l(5)
	li 3,0
.L56:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L45
.L54:
	addi 0,31,1
	lis 9,numipfilters@ha
	stw 0,numipfilters@l(9)
.L53:
	lis 9,gi+160@ha
	li 3,2
	lwz 0,gi+160@l(9)
	slwi 31,31,3
	mtlr 0
	blrl
	lis 9,ipfilters@ha
	la 30,ipfilters@l(9)
	add 4,31,30
	bl StringToFilter
	cmpwi 0,3,0
	bc 4,2,.L45
	addi 9,30,4
	li 0,-1
	stwx 0,9,31
.L45:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 SVCmd_AddIP_f,.Lfe3-SVCmd_AddIP_f
	.section	".rodata"
	.align 2
.LC5:
	.string	"Usage:  sv removeip <ip-mask>\n"
	.align 2
.LC6:
	.string	"Removed.\n"
	.align 2
.LC7:
	.string	"Didn't find %s.\n"
	.section	".text"
	.align 2
	.globl SVCmd_RemoveIP_f
	.type	 SVCmd_RemoveIP_f,@function
SVCmd_RemoveIP_f:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,gi@ha
	la 31,gi@l(9)
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,2
	bc 12,1,.L58
	lwz 0,8(31)
	lis 5,.LC5@ha
	li 3,0
	la 5,.LC5@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L57
.L58:
	lwz 9,160(31)
	li 3,2
	addi 29,1,8
	mtlr 9
	blrl
	mr 4,29
	bl StringToFilter
	cmpwi 0,3,0
	bc 12,2,.L57
	lis 9,numipfilters@ha
	li 10,0
	lwz 0,numipfilters@l(9)
	lis 8,numipfilters@ha
	cmpw 0,10,0
	bc 4,0,.L61
	lis 9,ipfilters@ha
	mr 3,31
	la 11,ipfilters@l(9)
	lis 7,numipfilters@ha
	mr 4,11
	lis 6,numipfilters@ha
.L63:
	lwz 9,0(11)
	lwz 0,8(1)
	cmpw 0,9,0
	bc 4,2,.L62
	lwz 9,4(11)
	lwz 0,4(29)
	cmpw 0,9,0
	bc 4,2,.L62
	lwz 0,numipfilters@l(8)
	addi 10,10,1
	lis 5,.LC6@ha
	mtctr 10
	cmpw 0,10,0
	bc 4,0,.L66
	slwi 0,10,3
	lwz 9,numipfilters@l(6)
	add 11,0,4
	mfctr 0
	subf 0,0,9
	mtctr 0
.L68:
	lfd 0,0(11)
	stfd 0,-8(11)
	addi 11,11,8
	bdnz .L68
.L66:
	lwz 0,8(3)
	la 5,.LC6@l(5)
	li 4,2
	lwz 9,numipfilters@l(7)
	li 3,0
	mtlr 0
	addi 9,9,-1
	stw 9,numipfilters@l(7)
	crxor 6,6,6
	blrl
	b .L57
.L62:
	lwz 0,numipfilters@l(8)
	addi 10,10,1
	addi 11,11,8
	cmpw 0,10,0
	bc 12,0,.L63
.L61:
	lis 29,gi@ha
	li 3,2
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	lwz 0,8(29)
	mr 6,3
	lis 5,.LC7@ha
	la 5,.LC7@l(5)
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L57:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 SVCmd_RemoveIP_f,.Lfe4-SVCmd_RemoveIP_f
	.section	".rodata"
	.align 2
.LC8:
	.string	"Filter list:\n"
	.align 2
.LC9:
	.string	"%3i.%3i.%3i.%3i\n"
	.align 2
.LC10:
	.string	"game"
	.align 2
.LC11:
	.string	""
	.align 2
.LC12:
	.string	"%s/listip.cfg"
	.align 2
.LC13:
	.string	"Wyrm 2 - World of Destruction"
	.align 2
.LC14:
	.string	"Writing %s.\n"
	.align 2
.LC15:
	.string	"wb"
	.align 2
.LC16:
	.string	"Couldn't open %s\n"
	.align 2
.LC17:
	.string	"set filterban %d\n"
	.align 2
.LC18:
	.string	"sv addip %i.%i.%i.%i\n"
	.section	".text"
	.align 2
	.globl SVCmd_WriteIP_f
	.type	 SVCmd_WriteIP_f,@function
SVCmd_WriteIP_f:
	stwu 1,-192(1)
	mflr 0
	stmw 26,168(1)
	stw 0,196(1)
	lis 9,gi+144@ha
	lis 3,.LC10@ha
	lwz 0,gi+144@l(9)
	lis 4,.LC11@ha
	li 5,0
	la 3,.LC10@l(3)
	la 4,.LC11@l(4)
	mtlr 0
	blrl
	lwz 5,4(3)
	lbz 0,0(5)
	cmpwi 0,0,0
	bc 4,2,.L78
	lis 4,.LC12@ha
	lis 5,.LC13@ha
	la 4,.LC12@l(4)
	la 5,.LC13@l(5)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L79
.L78:
	lis 4,.LC12@ha
	addi 3,1,8
	la 4,.LC12@l(4)
	crxor 6,6,6
	bl sprintf
.L79:
	lis 9,gi@ha
	lis 5,.LC14@ha
	la 31,gi@l(9)
	li 4,2
	lwz 9,8(31)
	la 5,.LC14@l(5)
	li 3,0
	addi 6,1,8
	mtlr 9
	crxor 6,6,6
	blrl
	lis 4,.LC15@ha
	addi 3,1,8
	la 4,.LC15@l(4)
	bl fopen
	mr. 28,3
	bc 4,2,.L80
	lwz 0,8(31)
	lis 5,.LC16@ha
	li 3,0
	la 5,.LC16@l(5)
	li 4,2
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
	b .L77
.L80:
	lis 9,filterban@ha
	lwz 11,filterban@l(9)
	lis 4,.LC17@ha
	mr 3,28
	la 4,.LC17@l(4)
	li 29,0
	lfs 0,20(11)
	lis 26,numipfilters@ha
	fctiwz 13,0
	stfd 13,160(1)
	lwz 5,164(1)
	crxor 6,6,6
	bl fprintf
	lis 9,numipfilters@ha
	lwz 0,numipfilters@l(9)
	cmpw 0,29,0
	bc 4,0,.L82
	lis 9,ipfilters@ha
	addi 31,1,136
	la 9,ipfilters@l(9)
	lis 27,.LC18@ha
	addi 30,9,4
.L84:
	lwz 5,0(30)
	mr 3,28
	la 4,.LC18@l(27)
	addi 29,29,1
	addi 30,30,8
	stw 5,136(1)
	lbz 6,1(31)
	srwi 5,5,24
	lbz 7,2(31)
	lbz 8,3(31)
	crxor 6,6,6
	bl fprintf
	lwz 0,numipfilters@l(26)
	cmpw 0,29,0
	bc 12,0,.L84
.L82:
	mr 3,28
	bl fclose
.L77:
	lwz 0,196(1)
	mtlr 0
	lmw 26,168(1)
	la 1,192(1)
	blr
.Lfe5:
	.size	 SVCmd_WriteIP_f,.Lfe5-SVCmd_WriteIP_f
	.section	".rodata"
	.align 2
.LC19:
	.string	"test"
	.align 2
.LC20:
	.string	"addip"
	.align 2
.LC21:
	.string	"removeip"
	.align 2
.LC22:
	.string	"listip"
	.align 2
.LC23:
	.string	"writeip"
	.align 2
.LC24:
	.string	"nightmare"
	.align 2
.LC25:
	.string	"Unknown server command \"%s\"\n"
	.section	".text"
	.align 2
	.globl ServerCommand
	.type	 ServerCommand,@function
ServerCommand:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	lis 9,gi@ha
	li 3,1
	la 29,gi@l(9)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 31,3
	lis 4,.LC19@ha
	la 4,.LC19@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L87
	lwz 0,8(29)
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L89
.L87:
	lis 4,.LC20@ha
	mr 3,31
	la 4,.LC20@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L90
	bl SVCmd_AddIP_f
	b .L89
.L90:
	lis 4,.LC21@ha
	mr 3,31
	la 4,.LC21@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L92
	bl SVCmd_RemoveIP_f
	b .L89
.L92:
	lis 4,.LC22@ha
	mr 3,31
	la 4,.LC22@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L94
	lwz 9,8(29)
	lis 5,.LC8@ha
	li 3,0
	la 5,.LC8@l(5)
	li 4,2
	mtlr 9
	li 30,0
	lis 26,numipfilters@ha
	crxor 6,6,6
	blrl
	lis 9,numipfilters@ha
	lwz 0,numipfilters@l(9)
	cmpw 0,30,0
	bc 4,0,.L89
	lis 9,ipfilters@ha
	mr 27,29
	la 9,ipfilters@l(9)
	addi 31,1,8
	addi 29,9,4
	lis 28,.LC9@ha
.L97:
	lwz 6,0(29)
	li 3,0
	li 4,2
	lwz 11,8(27)
	la 5,.LC9@l(28)
	addi 30,30,1
	stw 6,8(1)
	addi 29,29,8
	srwi 6,6,24
	lbz 7,1(31)
	mtlr 11
	lbz 8,2(31)
	lbz 9,3(31)
	crxor 6,6,6
	blrl
	lwz 0,numipfilters@l(26)
	cmpw 0,30,0
	bc 12,0,.L97
	b .L89
.L94:
	lis 4,.LC23@ha
	mr 3,31
	la 4,.LC23@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L102
	bl SVCmd_WriteIP_f
	b .L89
.L102:
	lis 4,.LC24@ha
	mr 3,31
	la 4,.LC24@l(4)
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L104
	li 3,1
	bl nightmareModeToggle
	b .L89
.L104:
	lwz 0,8(29)
	lis 5,.LC25@ha
	mr 6,31
	la 5,.LC25@l(5)
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L89:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 ServerCommand,.Lfe6-ServerCommand
	.align 2
	.globl Svcmd_Test_f
	.type	 Svcmd_Test_f,@function
Svcmd_Test_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+8@ha
	lis 5,.LC0@ha
	lwz 0,gi+8@l(9)
	la 5,.LC0@l(5)
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe7:
	.size	 Svcmd_Test_f,.Lfe7-Svcmd_Test_f
	.comm	ipfilters,8192,4
	.comm	numipfilters,4,4
	.align 2
	.globl SVCmd_ListIP_f
	.type	 SVCmd_ListIP_f,@function
SVCmd_ListIP_f:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	lis 9,gi@ha
	lis 5,.LC8@ha
	la 31,gi@l(9)
	la 5,.LC8@l(5)
	lwz 9,8(31)
	li 3,0
	li 4,2
	li 30,0
	lis 26,numipfilters@ha
	mtlr 9
	crxor 6,6,6
	blrl
	lis 9,numipfilters@ha
	lwz 0,numipfilters@l(9)
	cmpw 0,30,0
	bc 4,0,.L73
	lis 9,ipfilters@ha
	mr 27,31
	la 9,ipfilters@l(9)
	addi 31,1,8
	addi 29,9,4
	lis 28,.LC9@ha
.L75:
	lwz 6,0(29)
	li 3,0
	li 4,2
	lwz 11,8(27)
	la 5,.LC9@l(28)
	addi 30,30,1
	stw 6,8(1)
	addi 29,29,8
	srwi 6,6,24
	lbz 7,1(31)
	mtlr 11
	lbz 8,2(31)
	lbz 9,3(31)
	crxor 6,6,6
	blrl
	lwz 0,numipfilters@l(26)
	cmpw 0,30,0
	bc 12,0,.L75
.L73:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe8:
	.size	 SVCmd_ListIP_f,.Lfe8-SVCmd_ListIP_f
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
