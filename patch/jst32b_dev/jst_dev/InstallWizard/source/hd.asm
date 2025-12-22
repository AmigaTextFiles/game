; *** %gamename% HD loader v1.0
; *** Written by %authorname%

	include  "syslibs.i"    			; !osemu
	include  "jst.i"

	HD_PARAMS   "",0,0       			; !fileload
	HD_PARAMS   "%diskfile%",%disksize%,%nbdisks% ; !diskload

loader:
	RELOC_MOVEL D0,trainer

	move.l   #%extsize%,D0			; !expmem
	JSRABS   AllocExtMem			; !expmem
	RELOC_MOVEL D0,ExtBase			; !expmem
	beq   MemErr				; !expmem

	Mac_printf  "%gamename% HD Loader v1.0"
	Mac_printf  "Coded by %authorname% © %year%"

	RELOC_TSTL  trainer
	beq   .skip

	NEWLINE
	Mac_printf  "Trainer activated"
.skip
	JSRGEN   CheckAGA			; !aga
	tst.l D0				; !aga
	bne   AgaErr				; !aga

	lea	subdir_name(pc),A0		; !subdir
	JSRABS	SetFilesPath			; !subdir

	JSRABS	UseHarryOSEmu			; !osemu

	JSRABS	LoadDisks			; !diskload
	move.l	#%sizelimit%,D0		; !fileload
	JSRABS	LoadSmallFiles			; !fileload

	moveq.l	#0,D0
	move.l	#CACRF_CopyBack,D1
	JSRABS	Degrade

	GO_SUPERVISOR
	SAVE_OSDATA	%chipsize%

;;	JSRGEN	FreezeAll
;;	move	#$2700,SR

	bsr	InstallBoot

	; **** boot stuff and patch

	JSRGEN	FlushCachesHard

	JSRGEN	InGameExit

InstallBoot:
	rts

MemErr:									; !expmem
	Mac_printf	"** Not enough memory to run %gamename%!"	; !expmem
	JMPABS		CloseAll					; !expmem

AgaErr:									; !aga
	Mac_printf	"** You need a A1200/A4000 to run %gamename%!"	; !aga
	JMPABS		CloseAll					; !aga


subdir_name:								; !subdir
	dc.b	"%subdir%",0						; !subdir
	cnop	0,4							; !subdir

trainer:
	dc.l  0
ExtBase:			; !expmem
	dc.l  0			; !expmem
