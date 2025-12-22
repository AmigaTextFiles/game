	.file	"g_svcmds.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"MOTD reloaded.\n"
	.align 2
.LC1:
	.string	"Bad filter address: %s\n"
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
	bc 12,2,.L27
	addi 6,1,8
	li 5,0
.L28:
	stbx 5,8,6
	lbz 10,0(3)
	addi 0,10,-48
	cmplwi 0,0,9
	bc 12,1,.L30
	mr 7,6
	mr 9,5
.L31:
	rlwinm 9,9,0,0xff
	mulli 9,9,10
	addi 9,9,208
	add 11,10,9
	lbzu 10,1(3)
	mr 9,11
	addi 0,10,-48
	cmplwi 0,0,9
	bc 4,1,.L31
	stbx 11,8,7
.L30:
	lbz 0,0(3)
	xori 9,0,58
	subfic 11,9,0
	adde 9,11,9
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 4,2,.L27
	addi 8,8,1
	lbzu 0,1(3)
	cmpwi 7,8,3
	neg 0,0
	srwi 0,0,31
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	and. 11,0,9
	bc 4,2,.L28
.L27:
	lis 9,numipfilters@ha
	li 8,0
	lwz 6,8(1)
	lwz 0,numipfilters@l(9)
	cmpw 0,8,0
	bc 4,0,.L36
	lis 9,filterban@ha
	lis 11,ipfilters@ha
	lwz 7,filterban@l(9)
	mr 10,0
	la 11,ipfilters@l(11)
.L38:
	lwz 0,0(11)
	lwz 9,4(11)
	and 0,6,0
	cmpw 0,0,9
	bc 4,2,.L37
	lfs 0,20(7)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 3,28(1)
	b .L41
.L37:
	addi 8,8,1
	addi 11,11,12
	cmpw 0,8,10
	bc 12,0,.L38
.L36:
	lis 9,.LC2@ha
	lis 11,filterban@ha
	la 9,.LC2@l(9)
	lfs 13,0(9)
	lwz 9,filterban@l(11)
	lfs 0,20(9)
	fcmpu 7,0,13
	mfcr 3
	rlwinm 3,3,31,1
.L41:
	la 1,32(1)
	blr
.Lfe1:
	.size	 SV_FilterPacket,.Lfe1-SV_FilterPacket
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
	stwu 1,-192(1)
	mflr 0
	stmw 24,160(1)
	stw 0,196(1)
	lis 9,gi+156@ha
	lwz 0,gi+156@l(9)
	mtlr 0
	blrl
	cmpwi 0,3,2
	bc 12,1,.L44
	lis 5,.LC3@ha
	li 3,0
	la 5,.LC3@l(5)
	b .L74
.L44:
	lis 9,numipfilters@ha
	li 31,0
	lwz 11,numipfilters@l(9)
	cmpw 0,31,11
	bc 4,0,.L46
	lis 9,ipfilters@ha
	la 9,ipfilters@l(9)
	lwz 0,4(9)
	addi 10,9,4
	cmpwi 0,0,-1
	bc 12,2,.L46
	mr 9,10
.L47:
	addi 31,31,1
	cmpw 0,31,11
	bc 4,0,.L46
	lwzu 0,12(9)
	cmpwi 0,0,-1
	bc 4,2,.L47
.L46:
	lis 9,numipfilters@ha
	lwz 0,numipfilters@l(9)
	cmpw 0,31,0
	bc 4,2,.L51
	cmpwi 0,31,1024
	bc 4,2,.L52
	lis 5,.LC4@ha
	li 3,0
	la 5,.LC4@l(5)
.L74:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L43
.L72:
	lis 5,.LC1@ha
	mr 6,31
	la 5,.LC1@l(5)
	li 3,0
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	li 11,0
	b .L63
.L52:
	addi 0,31,1
	lis 9,numipfilters@ha
	stw 0,numipfilters@l(9)
.L51:
	lis 9,gi+160@ha
	li 3,2
	mulli 29,31,12
	lwz 0,gi+160@l(9)
	addi 27,1,136
	addi 28,1,140
	mr 24,29
	li 30,0
	mtlr 0
	blrl
	lis 9,ipfilters@ha
	mr 10,27
	la 9,ipfilters@l(9)
	li 0,0
	add 29,29,9
	mr 11,28
	li 9,4
	mr 31,3
	mtctr 9
.L73:
	stbx 0,30,10
	stbx 0,30,11
	addi 30,30,1
	bdnz .L73
	li 30,0
	li 25,0
	li 26,255
.L61:
	lbz 9,0(31)
	addi 9,9,-48
	cmplwi 0,9,9
	bc 12,1,.L72
	addi 3,1,8
	li 11,0
	mr 10,3
.L66:
	lbz 0,0(31)
	stbx 0,10,11
	lbzu 9,1(31)
	addi 11,11,1
	addi 9,9,-48
	cmplwi 0,9,9
	bc 4,1,.L66
	stbx 25,3,11
	bl atoi
	rlwinm 0,3,0,0xff
	stbx 3,30,27
	cmpwi 0,0,0
	bc 12,2,.L68
	stbx 26,30,28
.L68:
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L70
	addi 30,30,1
	addi 31,31,1
	cmpwi 0,30,3
	bc 4,1,.L61
.L70:
	lwz 0,140(1)
	li 11,1
	stw 0,0(29)
	lwz 9,136(1)
	li 0,0
	stw 0,8(29)
	stw 9,4(29)
.L63:
	cmpwi 0,11,0
	bc 4,2,.L43
	lis 9,ipfilters@ha
	li 0,-1
	la 9,ipfilters@l(9)
	addi 9,9,4
	stwx 0,9,24
.L43:
	lwz 0,196(1)
	mtlr 0
	lmw 24,160(1)
	la 1,192(1)
	blr
.Lfe2:
	.size	 SVCmd_AddIP_f,.Lfe2-SVCmd_AddIP_f
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
	stwu 1,-208(1)
	mflr 0
	stmw 24,176(1)
	stw 0,212(1)
	lis 9,gi@ha
	la 31,gi@l(9)
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,2
	bc 12,1,.L76
	lis 5,.LC5@ha
	li 3,0
	la 5,.LC5@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L75
.L107:
	lis 5,.LC1@ha
	mr 6,31
	la 5,.LC1@l(5)
	li 3,0
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	li 11,0
	b .L87
.L76:
	lwz 0,160(31)
	li 3,2
	addi 27,1,152
	addi 28,1,156
	addi 29,1,24
	mtlr 0
	addi 26,1,8
	li 30,0
	blrl
	li 10,4
	mr 11,27
	mtctr 10
	li 0,0
	mr 9,28
	mr 31,3
.L108:
	stbx 0,30,11
	stbx 0,30,9
	addi 30,30,1
	bdnz .L108
	li 30,0
	li 24,0
	li 25,255
.L85:
	lbz 9,0(31)
	addi 9,9,-48
	cmplwi 0,9,9
	bc 12,1,.L107
	li 11,0
.L90:
	lbz 0,0(31)
	stbx 0,29,11
	lbzu 9,1(31)
	addi 11,11,1
	addi 9,9,-48
	cmplwi 0,9,9
	bc 4,1,.L90
	stbx 24,29,11
	addi 3,1,24
	bl atoi
	rlwinm 0,3,0,0xff
	stbx 3,30,27
	cmpwi 0,0,0
	bc 12,2,.L92
	stbx 25,30,28
.L92:
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L94
	addi 30,30,1
	addi 31,31,1
	cmpwi 0,30,3
	bc 4,1,.L85
.L94:
	lwz 0,156(1)
	li 11,1
	stw 0,0(26)
	lwz 9,152(1)
	li 0,0
	stw 0,8(26)
	stw 9,4(26)
.L87:
	cmpwi 0,11,0
	bc 12,2,.L75
	lis 9,numipfilters@ha
	li 10,0
	lwz 0,numipfilters@l(9)
	lis 8,numipfilters@ha
	cmpw 0,10,0
	bc 4,0,.L97
	lis 9,ipfilters@ha
	lis 7,numipfilters@ha
	la 11,ipfilters@l(9)
	lis 6,numipfilters@ha
	mr 4,11
.L99:
	lwz 9,0(11)
	lwz 0,8(1)
	cmpw 0,9,0
	bc 4,2,.L98
	lwz 9,4(11)
	lwz 0,12(1)
	cmpw 0,9,0
	bc 4,2,.L98
	lwz 0,numipfilters@l(8)
	addi 10,10,1
	lis 5,.LC6@ha
	mtctr 10
	cmpw 0,10,0
	bc 4,0,.L102
	mulli 9,10,12
	lwz 0,numipfilters@l(6)
	subf 10,10,0
	addi 9,9,-12
	mtctr 10
	add 10,9,4
.L104:
	lwz 0,12(10)
	lwz 9,16(10)
	lwz 11,20(10)
	stw 0,0(10)
	stw 9,4(10)
	stw 11,8(10)
	addi 10,10,12
	bdnz .L104
.L102:
	lwz 9,numipfilters@l(7)
	la 5,.LC6@l(5)
	li 3,0
	li 4,2
	addi 9,9,-1
	stw 9,numipfilters@l(7)
	crxor 6,6,6
	bl safe_cprintf
	b .L75
.L98:
	lwz 0,numipfilters@l(8)
	addi 10,10,1
	addi 11,11,12
	cmpw 0,10,0
	bc 12,0,.L99
.L97:
	lis 9,gi+160@ha
	li 3,2
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	mr 6,3
	lis 5,.LC7@ha
	la 5,.LC7@l(5)
	li 3,0
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L75:
	lwz 0,212(1)
	mtlr 0
	lmw 24,176(1)
	la 1,208(1)
	blr
.Lfe3:
	.size	 SVCmd_RemoveIP_f,.Lfe3-SVCmd_RemoveIP_f
	.section	".rodata"
	.align 2
.LC8:
	.string	"Filter list:\n"
	.align 2
.LC9:
	.string	"%3i.%3i.%3i.%3i\n"
	.align 2
.LC10:
	.string	"%3i.%3i.%3i.%3i (%d more game(s))\n"
	.section	".text"
	.align 2
	.globl SVCmd_ListIP_f
	.type	 SVCmd_ListIP_f,@function
SVCmd_ListIP_f:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	lis 5,.LC8@ha
	li 3,0
	la 5,.LC8@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	li 29,0
	lis 26,numipfilters@ha
	lis 9,numipfilters@ha
	lwz 0,numipfilters@l(9)
	cmpw 0,29,0
	bc 4,0,.L111
	lis 9,ipfilters@ha
	addi 31,1,8
	la 9,ipfilters@l(9)
	lis 27,.LC9@ha
	addi 30,9,8
	lis 28,.LC10@ha
.L113:
	lwz 10,0(30)
	lwz 6,-4(30)
	cmpwi 0,10,0
	stw 6,8(1)
	bc 4,2,.L114
	lbz 7,1(31)
	srwi 6,6,24
	li 3,0
	lbz 8,2(31)
	li 4,2
	la 5,.LC9@l(27)
	lbz 9,3(31)
	crxor 6,6,6
	bl safe_cprintf
	b .L112
.L114:
	lbz 7,1(31)
	li 3,0
	li 4,2
	lbz 8,2(31)
	la 5,.LC10@l(28)
	lbz 9,3(31)
	lbz 6,8(1)
	crxor 6,6,6
	bl safe_cprintf
.L112:
	lwz 0,numipfilters@l(26)
	addi 29,29,1
	addi 30,30,12
	cmpw 0,29,0
	bc 12,0,.L113
.L111:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 SVCmd_ListIP_f,.Lfe4-SVCmd_ListIP_f
	.section	".rodata"
	.align 2
.LC11:
	.string	"game"
	.align 2
.LC12:
	.string	""
	.align 2
.LC13:
	.string	"%s/listip.cfg"
	.align 2
.LC14:
	.string	"action"
	.align 2
.LC15:
	.string	"Writing %s.\n"
	.align 2
.LC16:
	.string	"wb"
	.align 2
.LC17:
	.string	"Couldn't open %s\n"
	.align 2
.LC18:
	.string	"set filterban %d\n"
	.align 2
.LC19:
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
	lis 3,.LC11@ha
	lwz 0,gi+144@l(9)
	lis 4,.LC12@ha
	li 5,0
	la 3,.LC11@l(3)
	la 4,.LC12@l(4)
	mtlr 0
	blrl
	lwz 5,4(3)
	lbz 0,0(5)
	cmpwi 0,0,0
	bc 4,2,.L118
	lis 4,.LC13@ha
	lis 5,.LC14@ha
	la 4,.LC13@l(4)
	la 5,.LC14@l(5)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L119
.L118:
	lis 4,.LC13@ha
	addi 3,1,8
	la 4,.LC13@l(4)
	crxor 6,6,6
	bl sprintf
.L119:
	lis 5,.LC15@ha
	li 4,2
	li 3,0
	la 5,.LC15@l(5)
	addi 6,1,8
	crxor 6,6,6
	bl safe_cprintf
	lis 4,.LC16@ha
	addi 3,1,8
	la 4,.LC16@l(4)
	bl fopen
	mr. 28,3
	bc 4,2,.L120
	lis 5,.LC17@ha
	li 3,0
	la 5,.LC17@l(5)
	li 4,2
	addi 6,1,8
	crxor 6,6,6
	bl safe_cprintf
	b .L117
.L120:
	lis 9,filterban@ha
	lwz 11,filterban@l(9)
	lis 4,.LC18@ha
	mr 3,28
	la 4,.LC18@l(4)
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
	bc 4,0,.L122
	lis 9,ipfilters@ha
	addi 30,1,136
	la 9,ipfilters@l(9)
	lis 27,.LC19@ha
	addi 31,9,4
.L124:
	lwz 0,4(31)
	cmpwi 0,0,0
	bc 4,2,.L123
	lwz 5,0(31)
	mr 3,28
	la 4,.LC19@l(27)
	stw 5,136(1)
	lbz 6,1(30)
	srwi 5,5,24
	lbz 7,2(30)
	lbz 8,3(30)
	crxor 6,6,6
	bl fprintf
.L123:
	lwz 0,numipfilters@l(26)
	addi 29,29,1
	addi 31,31,12
	cmpw 0,29,0
	bc 12,0,.L124
.L122:
	mr 3,28
	bl fclose
.L117:
	lwz 0,196(1)
	mtlr 0
	lmw 26,168(1)
	la 1,192(1)
	blr
.Lfe5:
	.size	 SVCmd_WriteIP_f,.Lfe5-SVCmd_WriteIP_f
	.section	".rodata"
	.align 2
.LC20:
	.string	"Changing to next map in rotation.\n"
	.align 2
.LC21:
	.string	"force"
	.align 2
.LC22:
	.string	"addip"
	.align 2
.LC23:
	.string	"removeip"
	.align 2
.LC24:
	.string	"listip"
	.align 2
.LC25:
	.string	"writeip"
	.align 2
.LC26:
	.string	"nextmap"
	.align 2
.LC27:
	.string	"reloadmotd"
	.align 2
.LC28:
	.string	"acedebug"
	.align 2
.LC29:
	.string	"on"
	.align 2
.LC30:
	.string	"ACE: Debug Mode On\n"
	.align 2
.LC31:
	.string	"ACE: Debug Mode Off\n"
	.align 2
.LC32:
	.string	"addbot"
	.align 2
.LC33:
	.string	"removebot"
	.align 2
.LC34:
	.string	"savenodes"
	.align 2
.LC35:
	.string	"Unknown server command \"%s\"\n"
	.align 2
.LC36:
	.long 0x0
	.section	".text"
	.align 2
	.globl ServerCommand
	.type	 ServerCommand,@function
ServerCommand:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,gi@ha
	li 3,1
	la 31,gi@l(9)
	lwz 9,160(31)
	mtlr 9
	blrl
	mr 29,3
	lis 4,.LC22@ha
	la 4,.LC22@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L130
	bl SVCmd_AddIP_f
	b .L131
.L130:
	lis 4,.LC23@ha
	mr 3,29
	la 4,.LC23@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L132
	bl SVCmd_RemoveIP_f
	b .L131
.L132:
	lis 4,.LC24@ha
	mr 3,29
	la 4,.LC24@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L134
	bl SVCmd_ListIP_f
	b .L131
.L134:
	lis 4,.LC25@ha
	mr 3,29
	la 4,.LC25@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L136
	bl SVCmd_WriteIP_f
	b .L131
.L136:
	lis 4,.LC26@ha
	mr 3,29
	la 4,.LC26@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L138
	lwz 0,160(31)
	li 3,2
	mtlr 0
	blrl
	mr 29,3
	lis 4,.LC20@ha
	la 4,.LC20@l(4)
	li 3,2
	crxor 6,6,6
	bl safe_bprintf
	bl EndDMLevel
	cmpwi 0,29,0
	bc 12,2,.L131
	lis 4,.LC21@ha
	mr 3,29
	la 4,.LC21@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L131
	bl ExitLevel
	b .L131
.L138:
	lis 4,.LC27@ha
	mr 3,29
	la 4,.LC27@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L142
	bl ReadMOTDFile
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L131
.L142:
	lis 4,.LC28@ha
	mr 3,29
	la 4,.LC28@l(4)
	bl Q_stricmp
	mr. 28,3
	bc 4,2,.L145
	lwz 0,160(31)
	li 3,2
	mtlr 0
	blrl
	lis 4,.LC29@ha
	la 4,.LC29@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L146
	lis 4,.LC30@ha
	li 3,1
	la 4,.LC30@l(4)
	crxor 6,6,6
	bl safe_bprintf
	lis 9,debug_mode@ha
	li 0,1
	stw 0,debug_mode@l(9)
	b .L131
.L146:
	lis 4,.LC31@ha
	li 3,1
	la 4,.LC31@l(4)
	crxor 6,6,6
	bl safe_bprintf
	lis 9,debug_mode@ha
	stw 28,debug_mode@l(9)
	b .L131
.L145:
	lis 4,.LC32@ha
	mr 3,29
	la 4,.LC32@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L149
	lis 9,.LC36@ha
	lis 11,teamplay@ha
	la 9,.LC36@l(9)
	lfs 13,0(9)
	lwz 9,teamplay@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L150
	lwz 9,160(31)
	li 3,2
	mtlr 9
	blrl
	lwz 9,160(31)
	mr 28,3
	li 3,3
	mtlr 9
	blrl
	lwz 0,160(31)
	mr 29,3
	li 3,4
	mtlr 0
	blrl
	mr 5,3
	mr 4,29
	mr 3,28
	b .L157
.L150:
	lwz 9,160(31)
	li 3,2
	mtlr 9
	blrl
	lwz 0,160(31)
	mr 29,3
	li 3,3
	mtlr 0
	blrl
	mr 5,3
	mr 4,29
	li 3,0
.L157:
	li 6,0
	bl ACESP_SpawnBot
	b .L131
.L149:
	lis 4,.LC33@ha
	mr 3,29
	la 4,.LC33@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L153
	lwz 0,160(31)
	li 3,2
	mtlr 0
	blrl
	bl ACESP_RemoveBot
	b .L131
.L153:
	lis 4,.LC34@ha
	mr 3,29
	la 4,.LC34@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L155
	bl ACEND_SaveNodes
	b .L131
.L155:
	lis 5,.LC35@ha
	mr 6,29
	la 5,.LC35@l(5)
	li 3,0
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L131:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 ServerCommand,.Lfe6-ServerCommand
	.section	".rodata"
	.align 2
.LC37:
	.string	"kick %d\n"
	.align 2
.LC38:
	.string	"Unable to determine client->ipaddr for edict\n"
	.section	".text"
	.align 2
	.globl Ban_TeamKiller
	.type	 Ban_TeamKiller,@function
Ban_TeamKiller:
	stwu 1,-192(1)
	mflr 0
	stmw 23,156(1)
	stw 0,196(1)
	mr. 3,3
	mr 23,4
	li 10,0
	bc 12,2,.L170
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L170
	cmpwi 0,0,-4464
	bc 4,2,.L169
.L170:
	lis 5,.LC38@ha
	li 3,0
	la 5,.LC38@l(5)
	b .L201
.L169:
	lis 9,numipfilters@ha
	lwz 11,numipfilters@l(9)
	cmpw 0,10,11
	bc 4,0,.L172
	lis 9,ipfilters@ha
	la 9,ipfilters@l(9)
	lwz 0,4(9)
	addi 8,9,4
	cmpwi 0,0,-1
	bc 12,2,.L172
	mr 9,8
.L173:
	addi 10,10,1
	cmpw 0,10,11
	bc 4,0,.L172
	lwzu 0,12(9)
	cmpwi 0,0,-1
	bc 4,2,.L173
.L172:
	lis 9,numipfilters@ha
	lwz 0,numipfilters@l(9)
	cmpw 0,10,0
	bc 4,2,.L177
	cmpwi 0,10,1024
	bc 4,2,.L178
	lis 5,.LC4@ha
	li 3,0
	la 5,.LC4@l(5)
.L201:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	li 3,0
	b .L198
.L199:
	lis 5,.LC1@ha
	mr 6,31
	la 5,.LC1@l(5)
	li 3,0
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	li 11,0
	b .L189
.L178:
	addi 0,10,1
	lis 9,numipfilters@ha
	stw 0,numipfilters@l(9)
.L177:
	mulli 29,10,12
	lis 9,ipfilters@ha
	lwz 11,84(3)
	addi 27,1,136
	la 9,ipfilters@l(9)
	addi 28,1,140
	mr 24,29
	mr 8,27
	add 29,29,9
	mr 10,28
	li 9,4
	addi 31,11,4464
	mtctr 9
	li 30,0
	li 0,0
.L200:
	stbx 0,30,8
	stbx 0,30,10
	addi 30,30,1
	bdnz .L200
	li 30,0
	li 25,0
	li 26,255
.L187:
	lbz 9,0(31)
	addi 9,9,-48
	cmplwi 0,9,9
	bc 12,1,.L199
	addi 3,1,8
	li 11,0
	mr 10,3
.L192:
	lbz 0,0(31)
	stbx 0,10,11
	lbzu 9,1(31)
	addi 11,11,1
	addi 9,9,-48
	cmplwi 0,9,9
	bc 4,1,.L192
	stbx 25,3,11
	bl atoi
	rlwinm 0,3,0,0xff
	stbx 3,30,27
	cmpwi 0,0,0
	bc 12,2,.L194
	stbx 26,30,28
.L194:
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L196
	addi 30,30,1
	addi 31,31,1
	cmpwi 0,30,3
	bc 4,1,.L187
.L196:
	lwz 0,140(1)
	li 11,1
	stw 0,0(29)
	lwz 9,136(1)
	stw 23,8(29)
	stw 9,4(29)
.L189:
	cmpwi 0,11,0
	bc 12,2,.L179
	li 3,1
	b .L198
.L179:
	lis 9,ipfilters@ha
	li 0,-1
	la 9,ipfilters@l(9)
	li 3,0
	addi 9,9,4
	stwx 0,9,24
.L198:
	lwz 0,196(1)
	mtlr 0
	lmw 23,156(1)
	la 1,192(1)
	blr
.Lfe7:
	.size	 Ban_TeamKiller,.Lfe7-Ban_TeamKiller
	.section	".rodata"
	.align 2
.LC39:
	.string	"Unbanned teamkiller.\n"
	.section	".text"
	.align 2
	.globl UnBan_TeamKillers
	.type	 UnBan_TeamKillers,@function
UnBan_TeamKillers:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 9,numipfilters@ha
	li 10,0
	lwz 0,numipfilters@l(9)
	lis 28,numipfilters@ha
	cmpw 0,10,0
	bc 4,0,.L204
	lis 9,ipfilters+8@ha
	lis 29,numipfilters@ha
	la 30,ipfilters+8@l(9)
	lis 26,numipfilters@ha
	addi 27,30,-8
.L206:
	mulli 11,10,12
	lwzx 9,30,11
	cmpwi 0,9,0
	bc 4,1,.L205
	addi 0,9,-1
	cmpwi 0,0,0
	stwx 0,11,30
	bc 4,2,.L205
	lwz 0,numipfilters@l(28)
	addi 9,10,1
	addi 31,10,-1
	mtctr 9
	lis 5,.LC39@ha
	cmpw 0,9,0
	bc 4,0,.L210
	lwz 0,numipfilters@l(26)
	mulli 9,9,12
	mfctr 11
	subf 11,11,0
	addi 9,9,-12
	mtctr 11
	add 10,9,27
.L212:
	lwz 0,12(10)
	lwz 9,16(10)
	lwz 11,20(10)
	stw 0,0(10)
	stw 9,4(10)
	stw 11,8(10)
	addi 10,10,12
	bdnz .L212
.L210:
	lwz 9,numipfilters@l(29)
	la 5,.LC39@l(5)
	li 3,0
	li 4,2
	addi 9,9,-1
	stw 9,numipfilters@l(29)
	crxor 6,6,6
	bl safe_cprintf
	mr 10,31
.L205:
	lwz 0,numipfilters@l(28)
	addi 10,10,1
	cmpw 0,10,0
	bc 12,0,.L206
.L204:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 UnBan_TeamKillers,.Lfe8-UnBan_TeamKillers
	.align 2
	.globl SVCmd_ReloadMOTD_f
	.type	 SVCmd_ReloadMOTD_f,@function
SVCmd_ReloadMOTD_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl ReadMOTDFile
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 SVCmd_ReloadMOTD_f,.Lfe9-SVCmd_ReloadMOTD_f
	.comm	ipfilters,12288,4
	.comm	numipfilters,4,4
	.align 2
	.globl SVCmd_Nextmap_f
	.type	 SVCmd_Nextmap_f,@function
SVCmd_Nextmap_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 4,.LC20@ha
	la 4,.LC20@l(4)
	li 3,2
	crxor 6,6,6
	bl safe_bprintf
	bl EndDMLevel
	cmpwi 0,31,0
	bc 12,2,.L127
	lis 4,.LC21@ha
	mr 3,31
	la 4,.LC21@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L127
	bl ExitLevel
.L127:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe10:
	.size	 SVCmd_Nextmap_f,.Lfe10-SVCmd_Nextmap_f
	.align 2
	.globl Kick_Client
	.type	 Kick_Client,@function
Kick_Client:
	stwu 1,-304(1)
	mflr 0
	stmw 25,276(1)
	stw 0,308(1)
	mr 29,3
	li 30,0
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L158
	lis 9,game@ha
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,30,0
	bc 4,0,.L158
	lis 9,gi@ha
	mr 25,11
	la 26,gi@l(9)
	lis 27,g_edicts@ha
	lis 28,.LC37@ha
	li 31,996
.L163:
	lwz 0,g_edicts@l(27)
	add. 9,0,31
	bc 12,2,.L162
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L162
	lwz 0,84(9)
	xor 11,29,9
	subfic 10,11,0
	adde 11,10,11
	addic 10,0,-1
	subfe 9,10,0
	and. 0,9,11
	bc 12,2,.L162
	addi 3,1,8
	la 4,.LC37@l(28)
	mr 5,30
	crxor 6,6,6
	bl sprintf
	lwz 9,168(26)
	addi 3,1,8
	mtlr 9
	blrl
.L162:
	lwz 0,1544(25)
	addi 30,30,1
	addi 31,31,996
	cmpw 0,30,0
	bc 12,0,.L163
.L158:
	lwz 0,308(1)
	mtlr 0
	lmw 25,276(1)
	la 1,304(1)
	blr
.Lfe11:
	.size	 Kick_Client,.Lfe11-Kick_Client
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
