	.file	"stdlog.c"
gcc2_compiled.:
	.section	".data"
	.align 2
	.type	 VEC_ORIGIN,@object
	.size	 VEC_ORIGIN,12
VEC_ORIGIN:
	.long 0x0
	.long 0x0
	.long 0x0
	.section	".sdata","aw"
	.align 2
	.type	 logfile,@object
	.size	 logfile,4
logfile:
	.long 0
	.align 2
	.type	 logstyle,@object
	.size	 logstyle,4
logstyle:
	.long 0
	.align 2
	.type	 StdLogFile,@object
	.size	 StdLogFile,4
StdLogFile:
	.long 0
	.align 2
	.type	 uiLogstyle,@object
	.size	 uiLogstyle,4
uiLogstyle:
	.long 0
	.section	".rodata"
	.align 2
.LC0:
	.string	"$Id: stdlog.c 1.5 1998/04/06 09:23:17 mdavies Exp $"
	.section	".sdata","aw"
	.align 2
	.type	 _unused_id_stdlog_c,@object
	.size	 _unused_id_stdlog_c,4
_unused_id_stdlog_c:
	.long .LC0
	.section	".rodata"
	.align 2
.LC1:
	.string	"$Id: stdlog.h 1.7 1998/04/06 09:24:23 mdavies Exp $"
	.section	".sdata","aw"
	.align 2
	.type	 _unused_id_stdlog_h,@object
	.size	 _unused_id_stdlog_h,4
_unused_id_stdlog_h:
	.long .LC1
	.section	".data"
	.align 2
	.type	 _sl_LogStyles,@object
_sl_LogStyles:
	.long _sl_LogVers
	.long _sl_LogPatch
	.long _sl_LogDate
	.long _sl_LogTime
	.long _sl_LogDeathFlags
	.long _sl_LogMapName
	.long _sl_LogPlayerName
	.long _sl_LogScore
	.long _sl_LogPlayerLeft
	.long _sl_LogGameStart
	.long _sl_LogGameEnd
	.long _sl_LogPlayerConnect
	.long _sl_LogPlayerTeamChange
	.long _sl_LogPlayerRename
	.size	 _sl_LogStyles,56
	.section	".rodata"
	.align 2
.LC2:
	.string	"\t\tStdLog\t1.2\n"
	.align 2
.LC3:
	.string	"\t\tPatchName\t%s\n"
	.align 2
.LC4:
	.string	"\t\tPatchName\t\n"
	.align 2
.LC5:
	.string	"%d %b %Y"
	.align 2
.LC6:
	.string	"\t\tLogDate\t%s\n"
	.align 2
.LC7:
	.string	"%H:%M:%S"
	.align 2
.LC8:
	.string	"\t\tLogTime\t%s\n"
	.align 2
.LC9:
	.string	"\t\tLogDeathFlags\t%u\n"
	.align 2
.LC10:
	.string	"\t\tMap\t%s\n"
	.align 2
.LC11:
	.string	"\t\tPlayer\t%s\t%s\t%.1f\n"
	.align 2
.LC12:
	.string	"\t\tPlayer\t%s\t\t%.1f\n"
	.align 2
.LC13:
	.string	"%s"
	.align 2
.LC14:
	.string	"\t"
	.align 2
.LC15:
	.string	"%d\t%.1f\n"
	.align 2
.LC16:
	.string	"\t%i\n"
	.align 2
.LC17:
	.string	"\t\tPlayerLeft\t%s\t\t%.1f\n"
	.align 2
.LC18:
	.string	"\t\tGameStart\t\t\t%.1f\n"
	.align 2
.LC19:
	.string	"\t\tGameEnd\t\t\t%.1f\n"
	.align 2
.LC20:
	.string	"\t\tPlayerConnect\t%s\t%s\t%.1f\n"
	.align 2
.LC21:
	.string	"\t\tPlayerConnect\t%s\t\t%.1f\n"
	.align 2
.LC22:
	.string	"\t\tPlayerTeamChange\t%s\t%s\t%.1f\n"
	.align 2
.LC23:
	.string	"\t\tPlayerTeamChange\t%s\t\t%.1f\n"
	.align 2
.LC24:
	.string	"\t\tPlayerRename\t%s\t%s\t%.1f\n"
	.align 2
.LC25:
	.string	"stdlogfile"
	.align 2
.LC26:
	.string	"0"
	.align 2
.LC27:
	.string	"stdlogname"
	.align 2
.LC28:
	.string	"ctc/StdLog.log"
	.align 2
.LC29:
	.string	"ctc/stdlog.log"
	.align 2
.LC30:
	.string	"a"
	.align 2
.LC31:
	.string	"Couldn't open %s"
	.align 2
.LC32:
	.long 0x0
	.section	".text"
	.align 2
	.type	 _sl_MaybeOpenFile,@function
_sl_MaybeOpenFile:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 31,logfile@ha
	mr 30,3
	lwz 0,logfile@l(31)
	cmpwi 0,0,0
	bc 4,2,.L42
	lwz 9,144(30)
	lis 3,.LC25@ha
	lis 4,.LC26@ha
	la 3,.LC25@l(3)
	la 4,.LC26@l(4)
	li 5,4
	mtlr 9
	blrl
	cmpwi 0,3,0
	stw 3,logfile@l(31)
	bc 12,2,.L38
.L42:
	lwz 9,logfile@l(31)
	lis 11,.LC32@ha
	lis 29,StdLogFile@ha
	la 11,.LC32@l(11)
	lfs 13,0(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L38
	lwz 0,StdLogFile@l(29)
	cmpwi 0,0,0
	bc 4,2,.L38
	lwz 9,144(30)
	lis 3,.LC27@ha
	lis 4,.LC28@ha
	la 3,.LC27@l(3)
	la 4,.LC28@l(4)
	mtlr 9
	li 5,4
	blrl
	mr. 3,3
	lis 9,.LC29@ha
	la 31,.LC29@l(9)
	bc 12,2,.L40
	lwz 31,4(3)
.L40:
	lis 4,.LC30@ha
	mr 3,31
	la 4,.LC30@l(4)
	bl fopen
	cmpwi 0,3,0
	stw 3,StdLogFile@l(29)
	bc 4,2,.L38
	lwz 0,28(30)
	lis 3,.LC31@ha
	mr 4,31
	la 3,.LC31@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L38:
	lis 9,StdLogFile@ha
	lwz 0,StdLogFile@l(9)
	addic 9,0,-1
	subfe 3,9,0
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 _sl_MaybeOpenFile,.Lfe1-_sl_MaybeOpenFile
	.section	".rodata"
	.align 2
.LC33:
	.string	"stdlogstyle"
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
	.section	".text"
	.align 2
	.globl sl_OpenLogFile
	.type	 sl_OpenLogFile,@function
sl_OpenLogFile:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl _sl_MaybeOpenFile
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe2:
	.size	 sl_OpenLogFile,.Lfe2-sl_OpenLogFile
	.align 2
	.globl sl_CloseLogFile
	.type	 sl_CloseLogFile,@function
sl_CloseLogFile:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 31,logfile@ha
	lwz 0,logfile@l(31)
	cmpwi 0,0,0
	bc 12,2,.L53
	lis 9,StdLogFile@ha
	lwz 3,StdLogFile@l(9)
	bl fclose
.L53:
	li 0,0
	lis 11,StdLogFile@ha
	lis 10,logstyle@ha
	lis 9,uiLogstyle@ha
	stw 0,StdLogFile@l(11)
	stw 0,uiLogstyle@l(9)
	stw 0,logfile@l(31)
	stw 0,logstyle@l(10)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 sl_CloseLogFile,.Lfe3-sl_CloseLogFile
	.section	".rodata"
	.align 3
.LC34:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_LogVers
	.type	 sl_LogVers,@function
sl_LogVers:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	bl _sl_MaybeOpenFile
	cmpwi 0,3,0
	bc 12,2,.L56
	lis 30,logstyle@ha
	lis 29,uiLogstyle@ha
	lwz 0,logstyle@l(30)
	cmpwi 0,0,0
	bc 4,2,.L62
	lwz 0,144(31)
	lis 3,.LC33@ha
	lis 4,.LC26@ha
	la 3,.LC33@l(3)
	la 4,.LC26@l(4)
	li 5,4
	mtlr 0
	blrl
	cmpwi 0,3,0
	stw 3,logstyle@l(30)
	bc 12,2,.L62
	lfs 0,20(3)
	lis 9,.LC34@ha
	la 11,uiLogstyle@l(29)
	la 9,.LC34@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L59
	fctiwz 0,13
	stfd 0,24(1)
	lwz 0,28(1)
	b .L60
.L59:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 0,28(1)
	xoris 0,0,0x8000
.L60:
	stw 0,0(11)
	lis 9,uiLogstyle@ha
	lwz 0,uiLogstyle@l(9)
	cmpwi 0,0,0
	bc 12,2,.L62
	li 0,0
	stw 0,uiLogstyle@l(29)
.L62:
	lis 11,uiLogstyle@ha
	lis 9,_sl_LogStyles@ha
	lwz 0,uiLogstyle@l(11)
	la 9,_sl_LogStyles@l(9)
	mulli 0,0,56
	lwzx 0,9,0
	mtlr 0
	blrl
.L56:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 sl_LogVers,.Lfe4-sl_LogVers
	.section	".rodata"
	.align 3
.LC35:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_LogPatch
	.type	 sl_LogPatch,@function
sl_LogPatch:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	mr 28,4
	bl _sl_MaybeOpenFile
	cmpwi 0,3,0
	bc 12,2,.L64
	lis 30,logstyle@ha
	lis 29,uiLogstyle@ha
	lwz 0,logstyle@l(30)
	cmpwi 0,0,0
	bc 4,2,.L70
	lwz 0,144(31)
	lis 3,.LC33@ha
	lis 4,.LC26@ha
	la 3,.LC33@l(3)
	la 4,.LC26@l(4)
	li 5,4
	mtlr 0
	blrl
	cmpwi 0,3,0
	stw 3,logstyle@l(30)
	bc 12,2,.L70
	lfs 0,20(3)
	lis 9,.LC35@ha
	la 11,uiLogstyle@l(29)
	la 9,.LC35@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L67
	fctiwz 0,13
	stfd 0,8(1)
	lwz 0,12(1)
	b .L68
.L67:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,8(1)
	lwz 0,12(1)
	xoris 0,0,0x8000
.L68:
	stw 0,0(11)
	lis 9,uiLogstyle@ha
	lwz 0,uiLogstyle@l(9)
	cmpwi 0,0,0
	bc 12,2,.L70
	li 0,0
	stw 0,uiLogstyle@l(29)
.L70:
	lis 9,uiLogstyle@ha
	lis 11,_sl_LogStyles@ha
	lwz 0,uiLogstyle@l(9)
	la 11,_sl_LogStyles@l(11)
	mr 3,28
	addi 11,11,4
	mulli 0,0,56
	lwzx 0,11,0
	mtlr 0
	blrl
.L64:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 sl_LogPatch,.Lfe5-sl_LogPatch
	.section	".rodata"
	.align 3
.LC36:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_LogDate
	.type	 sl_LogDate,@function
sl_LogDate:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	bl _sl_MaybeOpenFile
	cmpwi 0,3,0
	bc 12,2,.L72
	lis 30,logstyle@ha
	lis 29,uiLogstyle@ha
	lwz 0,logstyle@l(30)
	cmpwi 0,0,0
	bc 4,2,.L78
	lwz 0,144(31)
	lis 3,.LC33@ha
	lis 4,.LC26@ha
	la 3,.LC33@l(3)
	la 4,.LC26@l(4)
	li 5,4
	mtlr 0
	blrl
	cmpwi 0,3,0
	stw 3,logstyle@l(30)
	bc 12,2,.L78
	lfs 0,20(3)
	lis 9,.LC36@ha
	la 11,uiLogstyle@l(29)
	la 9,.LC36@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L75
	fctiwz 0,13
	stfd 0,24(1)
	lwz 0,28(1)
	b .L76
.L75:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 0,28(1)
	xoris 0,0,0x8000
.L76:
	stw 0,0(11)
	lis 9,uiLogstyle@ha
	lwz 0,uiLogstyle@l(9)
	cmpwi 0,0,0
	bc 12,2,.L78
	li 0,0
	stw 0,uiLogstyle@l(29)
.L78:
	lis 9,uiLogstyle@ha
	lis 11,_sl_LogStyles@ha
	lwz 0,uiLogstyle@l(9)
	la 11,_sl_LogStyles@l(11)
	addi 11,11,8
	mulli 0,0,56
	lwzx 0,11,0
	mtlr 0
	blrl
.L72:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 sl_LogDate,.Lfe6-sl_LogDate
	.section	".rodata"
	.align 3
.LC37:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_LogTime
	.type	 sl_LogTime,@function
sl_LogTime:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	bl _sl_MaybeOpenFile
	cmpwi 0,3,0
	bc 12,2,.L80
	lis 30,logstyle@ha
	lis 29,uiLogstyle@ha
	lwz 0,logstyle@l(30)
	cmpwi 0,0,0
	bc 4,2,.L86
	lwz 0,144(31)
	lis 3,.LC33@ha
	lis 4,.LC26@ha
	la 3,.LC33@l(3)
	la 4,.LC26@l(4)
	li 5,4
	mtlr 0
	blrl
	cmpwi 0,3,0
	stw 3,logstyle@l(30)
	bc 12,2,.L86
	lfs 0,20(3)
	lis 9,.LC37@ha
	la 11,uiLogstyle@l(29)
	la 9,.LC37@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L83
	fctiwz 0,13
	stfd 0,24(1)
	lwz 0,28(1)
	b .L84
.L83:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 0,28(1)
	xoris 0,0,0x8000
.L84:
	stw 0,0(11)
	lis 9,uiLogstyle@ha
	lwz 0,uiLogstyle@l(9)
	cmpwi 0,0,0
	bc 12,2,.L86
	li 0,0
	stw 0,uiLogstyle@l(29)
.L86:
	lis 9,uiLogstyle@ha
	lis 11,_sl_LogStyles@ha
	lwz 0,uiLogstyle@l(9)
	la 11,_sl_LogStyles@l(11)
	addi 11,11,12
	mulli 0,0,56
	lwzx 0,11,0
	mtlr 0
	blrl
.L80:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 sl_LogTime,.Lfe7-sl_LogTime
	.section	".rodata"
	.align 3
.LC38:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_LogDeathFlags
	.type	 sl_LogDeathFlags,@function
sl_LogDeathFlags:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	mr 28,4
	bl _sl_MaybeOpenFile
	cmpwi 0,3,0
	bc 12,2,.L88
	lis 30,logstyle@ha
	lis 29,uiLogstyle@ha
	lwz 0,logstyle@l(30)
	cmpwi 0,0,0
	bc 4,2,.L94
	lwz 0,144(31)
	lis 3,.LC33@ha
	lis 4,.LC26@ha
	la 3,.LC33@l(3)
	la 4,.LC26@l(4)
	li 5,4
	mtlr 0
	blrl
	cmpwi 0,3,0
	stw 3,logstyle@l(30)
	bc 12,2,.L94
	lfs 0,20(3)
	lis 9,.LC38@ha
	la 11,uiLogstyle@l(29)
	la 9,.LC38@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L91
	fctiwz 0,13
	stfd 0,8(1)
	lwz 0,12(1)
	b .L92
.L91:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,8(1)
	lwz 0,12(1)
	xoris 0,0,0x8000
.L92:
	stw 0,0(11)
	lis 9,uiLogstyle@ha
	lwz 0,uiLogstyle@l(9)
	cmpwi 0,0,0
	bc 12,2,.L94
	li 0,0
	stw 0,uiLogstyle@l(29)
.L94:
	lis 9,uiLogstyle@ha
	lis 11,_sl_LogStyles@ha
	lwz 0,uiLogstyle@l(9)
	la 11,_sl_LogStyles@l(11)
	mr 3,28
	addi 11,11,16
	mulli 0,0,56
	lwzx 0,11,0
	mtlr 0
	blrl
.L88:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 sl_LogDeathFlags,.Lfe8-sl_LogDeathFlags
	.section	".rodata"
	.align 3
.LC39:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_LogMapName
	.type	 sl_LogMapName,@function
sl_LogMapName:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	mr 28,4
	bl _sl_MaybeOpenFile
	cmpwi 0,3,0
	bc 12,2,.L96
	lis 30,logstyle@ha
	lis 29,uiLogstyle@ha
	lwz 0,logstyle@l(30)
	cmpwi 0,0,0
	bc 4,2,.L102
	lwz 0,144(31)
	lis 3,.LC33@ha
	lis 4,.LC26@ha
	la 3,.LC33@l(3)
	la 4,.LC26@l(4)
	li 5,4
	mtlr 0
	blrl
	cmpwi 0,3,0
	stw 3,logstyle@l(30)
	bc 12,2,.L102
	lfs 0,20(3)
	lis 9,.LC39@ha
	la 11,uiLogstyle@l(29)
	la 9,.LC39@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L99
	fctiwz 0,13
	stfd 0,8(1)
	lwz 0,12(1)
	b .L100
.L99:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,8(1)
	lwz 0,12(1)
	xoris 0,0,0x8000
.L100:
	stw 0,0(11)
	lis 9,uiLogstyle@ha
	lwz 0,uiLogstyle@l(9)
	cmpwi 0,0,0
	bc 12,2,.L102
	li 0,0
	stw 0,uiLogstyle@l(29)
.L102:
	lis 9,uiLogstyle@ha
	lis 11,_sl_LogStyles@ha
	lwz 0,uiLogstyle@l(9)
	la 11,_sl_LogStyles@l(11)
	mr 3,28
	addi 11,11,20
	mulli 0,0,56
	lwzx 0,11,0
	mtlr 0
	blrl
.L96:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 sl_LogMapName,.Lfe9-sl_LogMapName
	.section	".rodata"
	.align 3
.LC40:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_LogPlayerName
	.type	 sl_LogPlayerName,@function
sl_LogPlayerName:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 27,36(1)
	stw 0,68(1)
	mr 31,3
	mr 28,4
	fmr 31,1
	mr 27,5
	bl _sl_MaybeOpenFile
	cmpwi 0,3,0
	bc 12,2,.L104
	lis 30,logstyle@ha
	lis 29,uiLogstyle@ha
	lwz 0,logstyle@l(30)
	cmpwi 0,0,0
	bc 4,2,.L110
	lwz 0,144(31)
	lis 3,.LC33@ha
	lis 4,.LC26@ha
	la 3,.LC33@l(3)
	la 4,.LC26@l(4)
	li 5,4
	mtlr 0
	blrl
	cmpwi 0,3,0
	stw 3,logstyle@l(30)
	bc 12,2,.L110
	lfs 0,20(3)
	lis 9,.LC40@ha
	la 11,uiLogstyle@l(29)
	la 9,.LC40@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L107
	fctiwz 0,13
	stfd 0,24(1)
	lwz 0,28(1)
	b .L108
.L107:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 0,28(1)
	xoris 0,0,0x8000
.L108:
	stw 0,0(11)
	lis 9,uiLogstyle@ha
	lwz 0,uiLogstyle@l(9)
	cmpwi 0,0,0
	bc 12,2,.L110
	li 0,0
	stw 0,uiLogstyle@l(29)
.L110:
	lis 9,uiLogstyle@ha
	lis 11,_sl_LogStyles@ha
	fmr 1,31
	lwz 0,uiLogstyle@l(9)
	la 11,_sl_LogStyles@l(11)
	mr 3,28
	addi 11,11,24
	mr 4,27
	mulli 0,0,56
	lwzx 0,11,0
	mtlr 0
	blrl
.L104:
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe10:
	.size	 sl_LogPlayerName,.Lfe10-sl_LogPlayerName
	.section	".rodata"
	.align 3
.LC41:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_LogScore
	.type	 sl_LogScore,@function
sl_LogScore:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 23,36(1)
	stw 0,84(1)
	mr 31,3
	mr 28,4
	fmr 31,1
	mr 27,5
	mr 26,6
	mr 25,7
	mr 24,8
	mr 23,9
	bl _sl_MaybeOpenFile
	cmpwi 0,3,0
	bc 12,2,.L112
	lis 30,logstyle@ha
	lis 29,uiLogstyle@ha
	lwz 0,logstyle@l(30)
	cmpwi 0,0,0
	bc 4,2,.L118
	lwz 0,144(31)
	lis 3,.LC33@ha
	lis 4,.LC26@ha
	la 3,.LC33@l(3)
	la 4,.LC26@l(4)
	li 5,4
	mtlr 0
	blrl
	cmpwi 0,3,0
	stw 3,logstyle@l(30)
	bc 12,2,.L118
	lfs 0,20(3)
	lis 9,.LC41@ha
	la 11,uiLogstyle@l(29)
	la 9,.LC41@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L115
	fctiwz 0,13
	stfd 0,24(1)
	lwz 0,28(1)
	b .L116
.L115:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 0,28(1)
	xoris 0,0,0x8000
.L116:
	stw 0,0(11)
	lis 9,uiLogstyle@ha
	lwz 0,uiLogstyle@l(9)
	cmpwi 0,0,0
	bc 12,2,.L118
	li 0,0
	stw 0,uiLogstyle@l(29)
.L118:
	lis 9,uiLogstyle@ha
	lis 11,_sl_LogStyles@ha
	fmr 1,31
	lwz 0,uiLogstyle@l(9)
	la 11,_sl_LogStyles@l(11)
	mr 3,28
	addi 11,11,28
	mr 4,27
	mulli 0,0,56
	mr 5,26
	mr 6,25
	mr 7,24
	mr 8,23
	lwzx 0,11,0
	mtlr 0
	blrl
.L112:
	lwz 0,84(1)
	mtlr 0
	lmw 23,36(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe11:
	.size	 sl_LogScore,.Lfe11-sl_LogScore
	.section	".rodata"
	.align 3
.LC42:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_LogPlayerLeft
	.type	 sl_LogPlayerLeft,@function
sl_LogPlayerLeft:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 28,24(1)
	stw 0,52(1)
	mr 31,3
	mr 28,4
	fmr 31,1
	bl _sl_MaybeOpenFile
	cmpwi 0,3,0
	bc 12,2,.L120
	lis 30,logstyle@ha
	lis 29,uiLogstyle@ha
	lwz 0,logstyle@l(30)
	cmpwi 0,0,0
	bc 4,2,.L126
	lwz 0,144(31)
	lis 3,.LC33@ha
	lis 4,.LC26@ha
	la 3,.LC33@l(3)
	la 4,.LC26@l(4)
	li 5,4
	mtlr 0
	blrl
	cmpwi 0,3,0
	stw 3,logstyle@l(30)
	bc 12,2,.L126
	lfs 0,20(3)
	lis 9,.LC42@ha
	la 11,uiLogstyle@l(29)
	la 9,.LC42@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L123
	fctiwz 0,13
	stfd 0,16(1)
	lwz 0,20(1)
	b .L124
.L123:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	xoris 0,0,0x8000
.L124:
	stw 0,0(11)
	lis 9,uiLogstyle@ha
	lwz 0,uiLogstyle@l(9)
	cmpwi 0,0,0
	bc 12,2,.L126
	li 0,0
	stw 0,uiLogstyle@l(29)
.L126:
	lis 9,uiLogstyle@ha
	lis 11,_sl_LogStyles@ha
	fmr 1,31
	lwz 0,uiLogstyle@l(9)
	la 11,_sl_LogStyles@l(11)
	mr 3,28
	addi 11,11,32
	mulli 0,0,56
	lwzx 0,11,0
	mtlr 0
	blrl
.L120:
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe12:
	.size	 sl_LogPlayerLeft,.Lfe12-sl_LogPlayerLeft
	.section	".rodata"
	.align 3
.LC43:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_LogGameStart
	.type	 sl_LogGameStart,@function
sl_LogGameStart:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	mr 31,3
	fmr 31,1
	bl _sl_MaybeOpenFile
	cmpwi 0,3,0
	bc 12,2,.L128
	lis 30,logstyle@ha
	lis 29,uiLogstyle@ha
	lwz 0,logstyle@l(30)
	cmpwi 0,0,0
	bc 4,2,.L134
	lwz 0,144(31)
	lis 3,.LC33@ha
	lis 4,.LC26@ha
	la 3,.LC33@l(3)
	la 4,.LC26@l(4)
	li 5,4
	mtlr 0
	blrl
	cmpwi 0,3,0
	stw 3,logstyle@l(30)
	bc 12,2,.L134
	lfs 0,20(3)
	lis 9,.LC43@ha
	la 11,uiLogstyle@l(29)
	la 9,.LC43@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L131
	fctiwz 0,13
	stfd 0,16(1)
	lwz 0,20(1)
	b .L132
.L131:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	xoris 0,0,0x8000
.L132:
	stw 0,0(11)
	lis 9,uiLogstyle@ha
	lwz 0,uiLogstyle@l(9)
	cmpwi 0,0,0
	bc 12,2,.L134
	li 0,0
	stw 0,uiLogstyle@l(29)
.L134:
	lis 9,uiLogstyle@ha
	lis 11,_sl_LogStyles@ha
	fmr 1,31
	lwz 0,uiLogstyle@l(9)
	la 11,_sl_LogStyles@l(11)
	addi 11,11,36
	mulli 0,0,56
	lwzx 0,11,0
	mtlr 0
	blrl
.L128:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe13:
	.size	 sl_LogGameStart,.Lfe13-sl_LogGameStart
	.section	".rodata"
	.align 3
.LC44:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_LogGameEnd
	.type	 sl_LogGameEnd,@function
sl_LogGameEnd:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	mr 31,3
	fmr 31,1
	bl _sl_MaybeOpenFile
	cmpwi 0,3,0
	bc 12,2,.L136
	lis 30,logstyle@ha
	lis 29,uiLogstyle@ha
	lwz 0,logstyle@l(30)
	cmpwi 0,0,0
	bc 4,2,.L142
	lwz 0,144(31)
	lis 3,.LC33@ha
	lis 4,.LC26@ha
	la 3,.LC33@l(3)
	la 4,.LC26@l(4)
	li 5,4
	mtlr 0
	blrl
	cmpwi 0,3,0
	stw 3,logstyle@l(30)
	bc 12,2,.L142
	lfs 0,20(3)
	lis 9,.LC44@ha
	la 11,uiLogstyle@l(29)
	la 9,.LC44@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L139
	fctiwz 0,13
	stfd 0,16(1)
	lwz 0,20(1)
	b .L140
.L139:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	xoris 0,0,0x8000
.L140:
	stw 0,0(11)
	lis 9,uiLogstyle@ha
	lwz 0,uiLogstyle@l(9)
	cmpwi 0,0,0
	bc 12,2,.L142
	li 0,0
	stw 0,uiLogstyle@l(29)
.L142:
	lis 9,uiLogstyle@ha
	lis 11,_sl_LogStyles@ha
	fmr 1,31
	lwz 0,uiLogstyle@l(9)
	la 11,_sl_LogStyles@l(11)
	addi 11,11,40
	mulli 0,0,56
	lwzx 0,11,0
	mtlr 0
	blrl
.L136:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe14:
	.size	 sl_LogGameEnd,.Lfe14-sl_LogGameEnd
	.section	".rodata"
	.align 3
.LC45:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_LogPlayerConnect
	.type	 sl_LogPlayerConnect,@function
sl_LogPlayerConnect:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 27,36(1)
	stw 0,68(1)
	mr 31,3
	mr 28,4
	fmr 31,1
	mr 27,5
	bl _sl_MaybeOpenFile
	cmpwi 0,3,0
	bc 12,2,.L144
	lis 30,logstyle@ha
	lis 29,uiLogstyle@ha
	lwz 0,logstyle@l(30)
	cmpwi 0,0,0
	bc 4,2,.L150
	lwz 0,144(31)
	lis 3,.LC33@ha
	lis 4,.LC26@ha
	la 3,.LC33@l(3)
	la 4,.LC26@l(4)
	li 5,4
	mtlr 0
	blrl
	cmpwi 0,3,0
	stw 3,logstyle@l(30)
	bc 12,2,.L150
	lfs 0,20(3)
	lis 9,.LC45@ha
	la 11,uiLogstyle@l(29)
	la 9,.LC45@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L147
	fctiwz 0,13
	stfd 0,24(1)
	lwz 0,28(1)
	b .L148
.L147:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 0,28(1)
	xoris 0,0,0x8000
.L148:
	stw 0,0(11)
	lis 9,uiLogstyle@ha
	lwz 0,uiLogstyle@l(9)
	cmpwi 0,0,0
	bc 12,2,.L150
	li 0,0
	stw 0,uiLogstyle@l(29)
.L150:
	lis 9,uiLogstyle@ha
	lis 11,_sl_LogStyles@ha
	fmr 1,31
	lwz 0,uiLogstyle@l(9)
	la 11,_sl_LogStyles@l(11)
	mr 3,28
	addi 11,11,44
	mr 4,27
	mulli 0,0,56
	lwzx 0,11,0
	mtlr 0
	blrl
.L144:
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe15:
	.size	 sl_LogPlayerConnect,.Lfe15-sl_LogPlayerConnect
	.section	".rodata"
	.align 3
.LC46:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_LogPlayerTeamChange
	.type	 sl_LogPlayerTeamChange,@function
sl_LogPlayerTeamChange:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 27,36(1)
	stw 0,68(1)
	mr 31,3
	mr 28,4
	fmr 31,1
	mr 27,5
	bl _sl_MaybeOpenFile
	cmpwi 0,3,0
	bc 12,2,.L152
	lis 30,logstyle@ha
	lis 29,uiLogstyle@ha
	lwz 0,logstyle@l(30)
	cmpwi 0,0,0
	bc 4,2,.L158
	lwz 0,144(31)
	lis 3,.LC33@ha
	lis 4,.LC26@ha
	la 3,.LC33@l(3)
	la 4,.LC26@l(4)
	li 5,4
	mtlr 0
	blrl
	cmpwi 0,3,0
	stw 3,logstyle@l(30)
	bc 12,2,.L158
	lfs 0,20(3)
	lis 9,.LC46@ha
	la 11,uiLogstyle@l(29)
	la 9,.LC46@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L155
	fctiwz 0,13
	stfd 0,24(1)
	lwz 0,28(1)
	b .L156
.L155:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 0,28(1)
	xoris 0,0,0x8000
.L156:
	stw 0,0(11)
	lis 9,uiLogstyle@ha
	lwz 0,uiLogstyle@l(9)
	cmpwi 0,0,0
	bc 12,2,.L158
	li 0,0
	stw 0,uiLogstyle@l(29)
.L158:
	lis 9,uiLogstyle@ha
	lis 11,_sl_LogStyles@ha
	fmr 1,31
	lwz 0,uiLogstyle@l(9)
	la 11,_sl_LogStyles@l(11)
	mr 3,28
	addi 11,11,48
	mr 4,27
	mulli 0,0,56
	lwzx 0,11,0
	mtlr 0
	blrl
.L152:
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe16:
	.size	 sl_LogPlayerTeamChange,.Lfe16-sl_LogPlayerTeamChange
	.section	".rodata"
	.align 3
.LC47:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl sl_LogPlayerRename
	.type	 sl_LogPlayerRename,@function
sl_LogPlayerRename:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 27,36(1)
	stw 0,68(1)
	mr 31,3
	mr 28,4
	fmr 31,1
	mr 27,5
	bl _sl_MaybeOpenFile
	cmpwi 0,3,0
	bc 12,2,.L160
	lis 30,logstyle@ha
	lis 29,uiLogstyle@ha
	lwz 0,logstyle@l(30)
	cmpwi 0,0,0
	bc 4,2,.L166
	lwz 0,144(31)
	lis 3,.LC33@ha
	lis 4,.LC26@ha
	la 3,.LC33@l(3)
	la 4,.LC26@l(4)
	li 5,4
	mtlr 0
	blrl
	cmpwi 0,3,0
	stw 3,logstyle@l(30)
	bc 12,2,.L166
	lfs 0,20(3)
	lis 9,.LC47@ha
	la 11,uiLogstyle@l(29)
	la 9,.LC47@l(9)
	lfd 12,0(9)
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L163
	fctiwz 0,13
	stfd 0,24(1)
	lwz 0,28(1)
	b .L164
.L163:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 0,28(1)
	xoris 0,0,0x8000
.L164:
	stw 0,0(11)
	lis 9,uiLogstyle@ha
	lwz 0,uiLogstyle@l(9)
	cmpwi 0,0,0
	bc 12,2,.L166
	li 0,0
	stw 0,uiLogstyle@l(29)
.L166:
	lis 9,uiLogstyle@ha
	lis 11,_sl_LogStyles@ha
	fmr 1,31
	lwz 0,uiLogstyle@l(9)
	la 11,_sl_LogStyles@l(11)
	mr 3,28
	addi 11,11,52
	mr 4,27
	mulli 0,0,56
	lwzx 0,11,0
	mtlr 0
	blrl
.L160:
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe17:
	.size	 sl_LogPlayerRename,.Lfe17-sl_LogPlayerRename
	.align 2
	.type	 _sl_LogVers,@function
_sl_LogVers:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,StdLogFile@ha
	lis 4,.LC2@ha
	lwz 3,StdLogFile@l(9)
	la 4,.LC2@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe18:
	.size	 _sl_LogVers,.Lfe18-_sl_LogVers
	.align 2
	.type	 _sl_LogPatch,@function
_sl_LogPatch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr. 5,3
	bc 12,2,.L8
	lis 9,StdLogFile@ha
	lis 4,.LC3@ha
	lwz 3,StdLogFile@l(9)
	la 4,.LC3@l(4)
	crxor 6,6,6
	bl fprintf
	b .L9
.L8:
	lis 9,StdLogFile@ha
	lis 4,.LC4@ha
	lwz 3,StdLogFile@l(9)
	la 4,.LC4@l(4)
	crxor 6,6,6
	bl fprintf
.L9:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe19:
	.size	 _sl_LogPatch,.Lfe19-_sl_LogPatch
	.align 2
	.type	 _sl_LogDate,@function
_sl_LogDate:
	stwu 1,-80(1)
	mflr 0
	stmw 29,68(1)
	stw 0,84(1)
	li 3,0
	bl time
	cmpwi 0,3,-1
	stw 3,40(1)
	bc 12,2,.L11
	addi 3,1,40
	bl localtime
	mr. 31,3
	bc 12,2,.L11
	addi 29,1,8
	li 5,22
	li 4,0
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 5,.LC5@ha
	li 4,21
	la 5,.LC5@l(5)
	mr 6,31
	mr 3,29
	bl strftime
	lis 9,StdLogFile@ha
	lis 4,.LC6@ha
	lwz 3,StdLogFile@l(9)
	la 4,.LC6@l(4)
	mr 5,29
	crxor 6,6,6
	bl fprintf
.L11:
	lwz 0,84(1)
	mtlr 0
	lmw 29,68(1)
	la 1,80(1)
	blr
.Lfe20:
	.size	 _sl_LogDate,.Lfe20-_sl_LogDate
	.align 2
	.type	 _sl_LogTime,@function
_sl_LogTime:
	stwu 1,-80(1)
	mflr 0
	stmw 29,68(1)
	stw 0,84(1)
	li 3,0
	bl time
	cmpwi 0,3,-1
	stw 3,40(1)
	bc 12,2,.L14
	addi 3,1,40
	bl localtime
	mr. 31,3
	bc 12,2,.L14
	addi 29,1,8
	li 5,19
	li 4,0
	mr 3,29
	crxor 6,6,6
	bl memset
	lis 5,.LC7@ha
	li 4,18
	la 5,.LC7@l(5)
	mr 6,31
	mr 3,29
	bl strftime
	lis 9,StdLogFile@ha
	lis 4,.LC8@ha
	lwz 3,StdLogFile@l(9)
	la 4,.LC8@l(4)
	mr 5,29
	crxor 6,6,6
	bl fprintf
.L14:
	lwz 0,84(1)
	mtlr 0
	lmw 29,68(1)
	la 1,80(1)
	blr
.Lfe21:
	.size	 _sl_LogTime,.Lfe21-_sl_LogTime
	.align 2
	.type	 _sl_LogDeathFlags,@function
_sl_LogDeathFlags:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 5,3
	lis 9,StdLogFile@ha
	lis 4,.LC9@ha
	lwz 3,StdLogFile@l(9)
	la 4,.LC9@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe22:
	.size	 _sl_LogDeathFlags,.Lfe22-_sl_LogDeathFlags
	.align 2
	.type	 _sl_LogMapName,@function
_sl_LogMapName:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 5,3
	lis 9,StdLogFile@ha
	lis 4,.LC10@ha
	lwz 3,StdLogFile@l(9)
	la 4,.LC10@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe23:
	.size	 _sl_LogMapName,.Lfe23-_sl_LogMapName
	.align 2
	.type	 _sl_LogPlayerName,@function
_sl_LogPlayerName:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr. 6,4
	mr 5,3
	bc 12,2,.L19
	lis 9,StdLogFile@ha
	lis 4,.LC11@ha
	lwz 3,StdLogFile@l(9)
	la 4,.LC11@l(4)
	creqv 6,6,6
	bl fprintf
	b .L20
.L19:
	lis 9,StdLogFile@ha
	lis 4,.LC12@ha
	lwz 3,StdLogFile@l(9)
	la 4,.LC12@l(4)
	creqv 6,6,6
	bl fprintf
.L20:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe24:
	.size	 _sl_LogPlayerName,.Lfe24-_sl_LogPlayerName
	.align 2
	.type	 _sl_LogScore,@function
_sl_LogScore:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 25,12(1)
	stw 0,52(1)
	mr. 0,3
	mr 29,4
	fmr 31,1
	mr 28,5
	mr 27,6
	mr 26,7
	mr 25,8
	lis 31,StdLogFile@ha
	bc 12,2,.L22
	lis 4,.LC13@ha
	lwz 3,StdLogFile@l(31)
	mr 5,0
	la 4,.LC13@l(4)
	crxor 6,6,6
	bl fprintf
.L22:
	lis 9,StdLogFile@ha
	lis 30,.LC14@ha
	lwz 3,StdLogFile@l(9)
	la 4,.LC14@l(30)
	crxor 6,6,6
	bl fprintf
	cmpwi 0,29,0
	bc 12,2,.L23
	lis 4,.LC13@ha
	lwz 3,StdLogFile@l(31)
	mr 5,29
	la 4,.LC13@l(4)
	crxor 6,6,6
	bl fprintf
.L23:
	lwz 3,StdLogFile@l(31)
	la 4,.LC14@l(30)
	crxor 6,6,6
	bl fprintf
	cmpwi 0,28,0
	bc 12,2,.L24
	lis 4,.LC13@ha
	lwz 3,StdLogFile@l(31)
	mr 5,28
	la 4,.LC13@l(4)
	crxor 6,6,6
	bl fprintf
.L24:
	lwz 3,StdLogFile@l(31)
	la 4,.LC14@l(30)
	crxor 6,6,6
	bl fprintf
	cmpwi 0,27,0
	bc 12,2,.L25
	lis 4,.LC13@ha
	lwz 3,StdLogFile@l(31)
	mr 5,27
	la 4,.LC13@l(4)
	crxor 6,6,6
	bl fprintf
.L25:
	lwz 3,StdLogFile@l(31)
	la 4,.LC14@l(30)
	crxor 6,6,6
	bl fprintf
	fmr 1,31
	lwz 3,StdLogFile@l(31)
	lis 4,.LC15@ha
	mr 5,26
	la 4,.LC15@l(4)
	creqv 6,6,6
	bl fprintf
	lis 4,.LC16@ha
	lwz 3,StdLogFile@l(31)
	mr 5,25
	la 4,.LC16@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 0,52(1)
	mtlr 0
	lmw 25,12(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe25:
	.size	 _sl_LogScore,.Lfe25-_sl_LogScore
	.align 2
	.type	 _sl_LogPlayerLeft,@function
_sl_LogPlayerLeft:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 5,3
	lis 9,StdLogFile@ha
	lis 4,.LC17@ha
	lwz 3,StdLogFile@l(9)
	la 4,.LC17@l(4)
	creqv 6,6,6
	bl fprintf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe26:
	.size	 _sl_LogPlayerLeft,.Lfe26-_sl_LogPlayerLeft
	.align 2
	.type	 _sl_LogGameStart,@function
_sl_LogGameStart:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,StdLogFile@ha
	lis 4,.LC18@ha
	lwz 3,StdLogFile@l(9)
	la 4,.LC18@l(4)
	creqv 6,6,6
	bl fprintf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe27:
	.size	 _sl_LogGameStart,.Lfe27-_sl_LogGameStart
	.align 2
	.type	 _sl_LogGameEnd,@function
_sl_LogGameEnd:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,StdLogFile@ha
	lis 4,.LC19@ha
	lwz 3,StdLogFile@l(9)
	la 4,.LC19@l(4)
	creqv 6,6,6
	bl fprintf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe28:
	.size	 _sl_LogGameEnd,.Lfe28-_sl_LogGameEnd
	.align 2
	.type	 _sl_LogPlayerConnect,@function
_sl_LogPlayerConnect:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr. 6,4
	mr 5,3
	bc 12,2,.L30
	lis 9,StdLogFile@ha
	lis 4,.LC20@ha
	lwz 3,StdLogFile@l(9)
	la 4,.LC20@l(4)
	creqv 6,6,6
	bl fprintf
	b .L31
.L30:
	lis 9,StdLogFile@ha
	lis 4,.LC21@ha
	lwz 3,StdLogFile@l(9)
	la 4,.LC21@l(4)
	creqv 6,6,6
	bl fprintf
.L31:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe29:
	.size	 _sl_LogPlayerConnect,.Lfe29-_sl_LogPlayerConnect
	.align 2
	.type	 _sl_LogPlayerTeamChange,@function
_sl_LogPlayerTeamChange:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr. 6,4
	mr 5,3
	bc 12,2,.L33
	lis 9,StdLogFile@ha
	lis 4,.LC22@ha
	lwz 3,StdLogFile@l(9)
	la 4,.LC22@l(4)
	creqv 6,6,6
	bl fprintf
	b .L34
.L33:
	lis 9,StdLogFile@ha
	lis 4,.LC23@ha
	lwz 3,StdLogFile@l(9)
	la 4,.LC23@l(4)
	creqv 6,6,6
	bl fprintf
.L34:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe30:
	.size	 _sl_LogPlayerTeamChange,.Lfe30-_sl_LogPlayerTeamChange
	.align 2
	.type	 _sl_LogPlayerRename,@function
_sl_LogPlayerRename:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 6,4
	mr 5,3
	lis 9,StdLogFile@ha
	lis 4,.LC24@ha
	lwz 3,StdLogFile@l(9)
	la 4,.LC24@l(4)
	creqv 6,6,6
	bl fprintf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe31:
	.size	 _sl_LogPlayerRename,.Lfe31-_sl_LogPlayerRename
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
