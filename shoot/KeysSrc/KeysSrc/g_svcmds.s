	.file	"g_svcmds.c"
gcc2_compiled.:
	.section	".data"
	.align 2
	.type	 VEC_ORIGIN,@object
	.size	 VEC_ORIGIN,12
VEC_ORIGIN:
	.long 0x0
	.long 0x0
	.long 0x0
	.section	".rodata"
	.align 2
.LC0:
	.string	"Svcmd_Test_f()\n"
	.section	".text"
	.align 2
	.globl Svcmd_Teams_f
	.type	 Svcmd_Teams_f,@function
Svcmd_Teams_f:
	stwu 1,-160(1)
	mflr 0
	stmw 27,140(1)
	stw 0,164(1)
	li 31,2
	b .L19
.L21:
	lwz 0,160(30)
	mr 3,31
	li 29,0
	addi 27,31,1
	mtlr 0
	blrl
	mr 4,3
	addi 3,1,8
	bl strcpy
	lis 9,bot_teams@ha
	la 9,bot_teams@l(9)
	lwzx 0,9,29
	cmpwi 0,0,0
	bc 12,2,.L23
	mr 30,9
	li 28,1
	li 31,0
.L25:
	lwzx 9,31,30
	addi 4,1,8
	addi 29,29,1
	lwz 3,0(9)
	bl strcasecmp
	cmpwi 0,3,0
	addi 4,1,8
	bc 12,2,.L27
	lwzx 9,31,30
	lwz 3,4(9)
	bl strcasecmp
	cmpwi 0,3,0
	cmpwi 7,29,63
	bc 4,2,.L26
.L27:
	lwzx 9,31,30
	stw 28,140(9)
	b .L23
.L26:
	addi 31,31,4
	bc 12,29,.L23
	lwzx 0,31,30
	cmpwi 0,0,0
	bc 4,2,.L25
.L23:
	mr 31,27
.L19:
	lis 9,gi@ha
	la 30,gi@l(9)
	lwz 9,156(30)
	mtlr 9
	blrl
	cmpw 0,31,3
	bc 12,0,.L21
	lwz 0,164(1)
	mtlr 0
	lmw 27,140(1)
	la 1,160(1)
	blr
.Lfe1:
	.size	 Svcmd_Teams_f,.Lfe1-Svcmd_Teams_f
	.globl force_team
	.section	".sdata","aw"
	.align 2
	.type	 force_team,@object
	.size	 force_team,4
force_team:
	.long 0
	.section	".rodata"
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
.L59:
	stbx 0,30,11
	stbx 0,30,9
	addi 30,30,1
	bdnz .L59
	lis 9,gi@ha
	li 30,0
	la 24,gi@l(9)
	lis 23,.LC1@ha
	li 25,0
	li 26,255
.L49:
	lbz 9,0(31)
	addi 9,9,-48
	cmplwi 0,9,9
	bc 4,1,.L50
	lwz 0,8(24)
	li 3,0
	la 5,.LC1@l(23)
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
	b .L58
.L50:
	addi 3,1,8
	li 11,0
	mr 10,3
.L53:
	lbz 0,0(31)
	lbzu 9,1(31)
	stbx 0,10,11
	addi 9,9,-48
	addi 11,11,1
	cmplwi 0,9,9
	bc 4,1,.L53
	stbx 25,3,11
	bl atoi
	rlwinm 0,3,0,0xff
	stbx 3,30,28
	cmpwi 0,0,0
	bc 12,2,.L55
	stbx 26,30,29
.L55:
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L47
	addi 30,30,1
	addi 31,31,1
	cmpwi 0,30,3
	bc 4,1,.L49
.L47:
	lwz 9,140(1)
	li 3,1
	lwz 0,136(1)
	stw 9,0(27)
	stw 0,4(27)
.L58:
	lwz 0,196(1)
	mtlr 0
	lmw 23,156(1)
	la 1,192(1)
	blr
.Lfe2:
	.size	 StringToFilter,.Lfe2-StringToFilter
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
	bc 12,2,.L62
	addi 6,1,8
	li 5,0
.L63:
	stbx 5,8,6
	lbz 10,0(3)
	addi 0,10,-48
	cmplwi 0,0,9
	bc 12,1,.L65
	mr 7,6
	mr 9,5
.L66:
	rlwinm 9,9,0,0xff
	mulli 9,9,10
	addi 9,9,208
	add 11,10,9
	lbzu 10,1(3)
	mr 9,11
	addi 0,10,-48
	cmplwi 0,0,9
	bc 4,1,.L66
	stbx 11,8,7
.L65:
	lbz 0,0(3)
	xori 9,0,58
	subfic 11,9,0
	adde 9,11,9
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 4,2,.L62
	addi 8,8,1
	lbzu 0,1(3)
	cmpwi 7,8,3
	neg 0,0
	srwi 0,0,31
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	and. 11,0,9
	bc 4,2,.L63
.L62:
	lis 9,numipfilters@ha
	li 8,0
	lwz 6,8(1)
	lwz 0,numipfilters@l(9)
	cmpw 0,8,0
	bc 4,0,.L71
	lis 9,filterban@ha
	lis 11,ipfilters@ha
	lwz 7,filterban@l(9)
	mr 10,0
	la 11,ipfilters@l(11)
.L73:
	lwz 0,0(11)
	lwz 9,4(11)
	and 0,6,0
	cmpw 0,0,9
	bc 4,2,.L72
	lfs 0,20(7)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 3,28(1)
	b .L76
.L72:
	addi 8,8,1
	addi 11,11,8
	cmpw 0,8,10
	bc 12,0,.L73
.L71:
	lis 9,.LC2@ha
	lis 11,filterban@ha
	la 9,.LC2@l(9)
	lfs 13,0(9)
	lwz 9,filterban@l(11)
	lfs 0,20(9)
	fcmpu 7,0,13
	mfcr 3
	rlwinm 3,3,31,1
.L76:
	la 1,32(1)
	blr
.Lfe3:
	.size	 SV_FilterPacket,.Lfe3-SV_FilterPacket
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
	bc 12,1,.L79
	lwz 0,8(31)
	lis 5,.LC3@ha
	li 3,0
	la 5,.LC3@l(5)
	b .L89
.L79:
	lis 9,numipfilters@ha
	li 31,0
	lwz 11,numipfilters@l(9)
	cmpw 0,31,11
	bc 4,0,.L81
	lis 9,ipfilters@ha
	la 9,ipfilters@l(9)
	lwz 0,4(9)
	addi 10,9,4
	cmpwi 0,0,-1
	bc 12,2,.L81
	mr 9,10
.L82:
	addi 31,31,1
	cmpw 0,31,11
	bc 4,0,.L81
	lwzu 0,8(9)
	cmpwi 0,0,-1
	bc 4,2,.L82
.L81:
	lis 9,numipfilters@ha
	lwz 0,numipfilters@l(9)
	cmpw 0,31,0
	bc 4,2,.L86
	cmpwi 0,31,1024
	bc 4,2,.L87
	lis 9,gi+8@ha
	lis 5,.LC4@ha
	lwz 0,gi+8@l(9)
	la 5,.LC4@l(5)
	li 3,0
.L89:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L78
.L87:
	addi 0,31,1
	lis 9,numipfilters@ha
	stw 0,numipfilters@l(9)
.L86:
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
	bc 4,2,.L78
	addi 9,30,4
	li 0,-1
	stwx 0,9,31
.L78:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 SVCmd_AddIP_f,.Lfe4-SVCmd_AddIP_f
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
	bc 12,1,.L91
	lwz 0,8(31)
	lis 5,.LC5@ha
	li 3,0
	la 5,.LC5@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L90
.L91:
	lwz 9,160(31)
	li 3,2
	addi 29,1,8
	mtlr 9
	blrl
	mr 4,29
	bl StringToFilter
	cmpwi 0,3,0
	bc 12,2,.L90
	lis 9,numipfilters@ha
	li 10,0
	lwz 0,numipfilters@l(9)
	lis 8,numipfilters@ha
	cmpw 0,10,0
	bc 4,0,.L94
	lis 9,ipfilters@ha
	mr 3,31
	la 11,ipfilters@l(9)
	lis 7,numipfilters@ha
	mr 4,11
	lis 6,numipfilters@ha
.L96:
	lwz 9,0(11)
	lwz 0,8(1)
	cmpw 0,9,0
	bc 4,2,.L95
	lwz 9,4(11)
	lwz 0,4(29)
	cmpw 0,9,0
	bc 4,2,.L95
	lwz 0,numipfilters@l(8)
	addi 10,10,1
	lis 5,.LC6@ha
	mtctr 10
	cmpw 0,10,0
	bc 4,0,.L99
	slwi 0,10,3
	lwz 9,numipfilters@l(6)
	add 11,0,4
	mfctr 0
	subf 0,0,9
	mtctr 0
.L101:
	lfd 0,0(11)
	stfd 0,-8(11)
	addi 11,11,8
	bdnz .L101
.L99:
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
	b .L90
.L95:
	lwz 0,numipfilters@l(8)
	addi 10,10,1
	addi 11,11,8
	cmpw 0,10,0
	bc 12,0,.L96
.L94:
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
.L90:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 SVCmd_RemoveIP_f,.Lfe5-SVCmd_RemoveIP_f
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
	.string	"Keys2 1.94"
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
	bc 4,2,.L111
	lis 4,.LC12@ha
	lis 5,.LC13@ha
	la 4,.LC12@l(4)
	la 5,.LC13@l(5)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L112
.L111:
	lis 4,.LC12@ha
	addi 3,1,8
	la 4,.LC12@l(4)
	crxor 6,6,6
	bl sprintf
.L112:
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
	bc 4,2,.L113
	lwz 0,8(31)
	lis 5,.LC16@ha
	li 3,0
	la 5,.LC16@l(5)
	li 4,2
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
	b .L110
.L113:
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
	bc 4,0,.L115
	lis 9,ipfilters@ha
	addi 31,1,136
	la 9,ipfilters@l(9)
	lis 27,.LC18@ha
	addi 30,9,4
.L117:
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
	bc 12,0,.L117
.L115:
	mr 3,28
	bl fclose
.L110:
	lwz 0,196(1)
	mtlr 0
	lmw 26,168(1)
	la 1,192(1)
	blr
.Lfe6:
	.size	 SVCmd_WriteIP_f,.Lfe6-SVCmd_WriteIP_f
	.section	".rodata"
	.align 2
.LC19:
	.string	"test"
	.align 2
.LC20:
	.string	"bots"
	.align 2
.LC21:
	.string	"teams"
	.align 2
.LC22:
	.string	"bluebots"
	.align 2
.LC23:
	.string	"redbots"
	.align 2
.LC24:
	.string	"addip"
	.align 2
.LC25:
	.string	"removeip"
	.align 2
.LC26:
	.string	"listip"
	.align 2
.LC27:
	.string	"writeip"
	.align 2
.LC28:
	.string	"Unknown server command \"%s\"\n"
	.section	".text"
	.align 2
	.globl ServerCommand
	.type	 ServerCommand,@function
ServerCommand:
	stwu 1,-176(1)
	mflr 0
	stmw 26,152(1)
	stw 0,180(1)
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
	bc 4,2,.L120
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L122
.L120:
	lis 4,.LC20@ha
	mr 3,31
	la 4,.LC20@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L123
	mr 30,29
	li 31,2
	b .L124
.L126:
	lwz 9,160(30)
	mr 3,31
	addi 31,31,1
	mtlr 9
	blrl
	mr 4,3
	addi 3,1,8
	bl strcpy
	addi 3,1,8
	bl strlen
	li 9,0
	cmpw 0,9,3
	bc 4,0,.L132
	addi 11,1,8
	li 10,32
.L129:
	lbzx 0,11,9
	cmpwi 0,0,126
	bc 4,2,.L131
	stbx 10,11,9
.L131:
	addi 9,9,1
	cmpw 0,9,3
	bc 12,0,.L129
.L132:
	addi 3,1,8
	bl spawn_bot
.L124:
	lwz 9,156(30)
	mtlr 9
	blrl
	cmpw 0,31,3
	bc 12,0,.L126
	b .L122
.L123:
	lis 4,.LC21@ha
	mr 3,31
	la 4,.LC21@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L136
	bl Svcmd_Teams_f
	b .L122
.L136:
	lis 4,.LC22@ha
	mr 3,31
	la 4,.LC22@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L138
	li 30,2
	lis 9,force_team@ha
	stw 30,force_team@l(9)
	b .L139
.L141:
	lwz 0,160(31)
	mr 3,30
	addi 30,30,1
	mtlr 0
	blrl
	bl spawn_bot
.L139:
	lis 9,gi@ha
	la 31,gi@l(9)
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpw 0,30,3
	bc 12,0,.L141
	b .L166
.L138:
	lis 4,.LC23@ha
	mr 3,31
	la 4,.LC23@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L145
	lis 9,force_team@ha
	li 0,1
	stw 0,force_team@l(9)
	li 30,2
	b .L146
.L148:
	lwz 0,160(31)
	mr 3,30
	addi 30,30,1
	mtlr 0
	blrl
	bl spawn_bot
.L146:
	lis 9,gi@ha
	la 31,gi@l(9)
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpw 0,30,3
	bc 12,0,.L148
.L166:
	lis 9,force_team@ha
	li 0,0
	stw 0,force_team@l(9)
	b .L122
.L145:
	lis 4,.LC24@ha
	mr 3,31
	la 4,.LC24@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L152
	bl SVCmd_AddIP_f
	b .L122
.L152:
	lis 4,.LC25@ha
	mr 3,31
	la 4,.LC25@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L154
	bl SVCmd_RemoveIP_f
	b .L122
.L154:
	lis 4,.LC26@ha
	mr 3,31
	la 4,.LC26@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L156
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
	bc 4,0,.L122
	lis 9,ipfilters@ha
	mr 27,29
	la 9,ipfilters@l(9)
	addi 31,1,136
	addi 29,9,4
	lis 28,.LC9@ha
.L159:
	lwz 6,0(29)
	li 3,0
	li 4,2
	lwz 11,8(27)
	la 5,.LC9@l(28)
	addi 30,30,1
	stw 6,136(1)
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
	bc 12,0,.L159
	b .L122
.L156:
	lis 4,.LC27@ha
	mr 3,31
	la 4,.LC27@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L164
	bl SVCmd_WriteIP_f
	b .L122
.L164:
	lis 5,.LC28@ha
	mr 6,31
	la 5,.LC28@l(5)
	li 3,0
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L122:
	lwz 0,180(1)
	mtlr 0
	lmw 26,152(1)
	la 1,176(1)
	blr
.Lfe7:
	.size	 ServerCommand,.Lfe7-ServerCommand
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
	.comm	spawn_bots,4,4
	.comm	roam_calls_this_frame,4,4
	.comm	bestdirection_callsthisframe,4,4
	.comm	bot_chat_text,2048,4
	.comm	bot_chat_count,32,4
	.comm	last_bot_chat,32,4
	.comm	num_view_weapons,4,4
	.comm	view_weapon_models,4096,1
	.comm	botdebug,4,4
	.align 2
	.globl Svcmd_Test_f
	.type	 Svcmd_Test_f,@function
Svcmd_Test_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
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
.Lfe8:
	.size	 Svcmd_Test_f,.Lfe8-Svcmd_Test_f
	.align 2
	.globl Svcmd_Bots_f
	.type	 Svcmd_Bots_f,@function
Svcmd_Bots_f:
	stwu 1,-144(1)
	mflr 0
	stmw 30,136(1)
	stw 0,148(1)
	li 31,2
	b .L8
.L10:
	lwz 0,160(30)
	mr 3,31
	addi 31,31,1
	mtlr 0
	blrl
	mr 4,3
	addi 3,1,8
	bl strcpy
	addi 3,1,8
	bl strlen
	li 9,0
	cmpw 0,9,3
	bc 4,0,.L12
	addi 11,1,8
	li 10,32
.L14:
	lbzx 0,11,9
	cmpwi 0,0,126
	bc 4,2,.L13
	stbx 10,11,9
.L13:
	addi 9,9,1
	cmpw 0,9,3
	bc 12,0,.L14
.L12:
	addi 3,1,8
	bl spawn_bot
.L8:
	lis 9,gi@ha
	la 30,gi@l(9)
	lwz 9,156(30)
	mtlr 9
	blrl
	cmpw 0,31,3
	bc 12,0,.L10
	lwz 0,148(1)
	mtlr 0
	lmw 30,136(1)
	la 1,144(1)
	blr
.Lfe9:
	.size	 Svcmd_Bots_f,.Lfe9-Svcmd_Bots_f
	.align 2
	.globl Svcmd_Blueteam_f
	.type	 Svcmd_Blueteam_f,@function
Svcmd_Blueteam_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	li 30,2
	lis 9,force_team@ha
	stw 30,force_team@l(9)
	b .L31
.L33:
	lwz 0,160(31)
	mr 3,30
	addi 30,30,1
	mtlr 0
	blrl
	bl spawn_bot
.L31:
	lis 9,gi@ha
	la 31,gi@l(9)
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpw 0,30,3
	bc 12,0,.L33
	lis 9,force_team@ha
	li 0,0
	stw 0,force_team@l(9)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe10:
	.size	 Svcmd_Blueteam_f,.Lfe10-Svcmd_Blueteam_f
	.align 2
	.globl Svcmd_Redteam_f
	.type	 Svcmd_Redteam_f,@function
Svcmd_Redteam_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,force_team@ha
	li 0,1
	stw 0,force_team@l(9)
	li 30,2
	b .L36
.L38:
	lwz 0,160(31)
	mr 3,30
	addi 30,30,1
	mtlr 0
	blrl
	bl spawn_bot
.L36:
	lis 9,gi@ha
	la 31,gi@l(9)
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpw 0,30,3
	bc 12,0,.L38
	lis 9,force_team@ha
	li 0,0
	stw 0,force_team@l(9)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 Svcmd_Redteam_f,.Lfe11-Svcmd_Redteam_f
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
	bc 4,0,.L106
	lis 9,ipfilters@ha
	mr 27,31
	la 9,ipfilters@l(9)
	addi 31,1,8
	addi 29,9,4
	lis 28,.LC9@ha
.L108:
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
	bc 12,0,.L108
.L106:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe12:
	.size	 SVCmd_ListIP_f,.Lfe12-SVCmd_ListIP_f
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
