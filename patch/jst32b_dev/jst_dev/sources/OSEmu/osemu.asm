;*---------------------------------------------------------------------------
;  :Program.	osemu.asm
;  :Author.	Harry, Wepl
;  :RCS.	$Id: osemu.asm 1.1 1999/02/03 04:10:48 jotd Exp jotd $
;  :History.	all work before history starts done by Harry
;	30.06.98   Wepl     rework started
;	06.07.98   Wepl     rework finished
;	07.07.98   Wepl     exec.Supervisor,exec.SuperState,exec.UserState
;		            exec.FindTask,exec.FindPort,exec.OpenDevice
;		            graphics.alot,exec.DoIO
;	15.07.98   Wepl     work for Deuteros finished
;	31.07.1998 Harry    SSP set on memtop again as it is in kick1.3
;			    possibility of trainer routine added
;	10.08.98   Wepl     osemu header struct changed (SLAVETRAINER now
;			    in osemu-struct instead overgiven via reg)
;	10.08.98   Wepl     gfx.BltBitMap fixed
;	??.08.98   MrLarmer some additions
;	05.09.98   Wepl     AddIntServer/RemIntServer finally fixed
;			    ReadPixel,WritePixel added
;	06.09.98   Wepl     return values after init changed (bootblock)
;			    BltTemplate started (but unfinished)
;	22.09.98   Wepl     _SendIO is now the same as _DoIO (fix for Deuteros)
;	27.09.98   Harry    dos.lock (untested), device-names even-
;			    aligned (68000-prob), (usp) initialized 
;			    with stacksize (CC3 expects it in 4(usp) at
;			    start), dummy: dos.input+dos.output+
;			    exec.waitport
;	29.09.1998 Harry    list management functions implemented: 
;			    exec.insert, exec.(add|rem)(head|tail), exec.remove
;	07.10.1998 Harry    list handling debugged, libs as list, one process
;			    structure, exec.findtask changed, _initlibary
;			    splittet, exec.getmsg, dos.deviceproc, intuition.
;			    openwindow, intuition.closewindow, icon.library,
;			    intuition.cleardmrequest, dos.unloadseg, 
;			    minor fixes
;	11.10.1998 Harry    devices as list, dos.loadseg supports hunk_symbol,
;			    audio.device-dummy, gfx.allocraster, gfx.freeraster,
;			    gfx.bltclear, gfx.initbitmap (and #fe), intuition.
;			    lockibase dummy, layers.library, mathffp.library,
;			    trackdisk.device-msgport, execlib-table implemented
;			    directly, exec.copymem, exec.findname, minor fixes
;	19.10.1998 Harry    dos.examine, dos.unlock, exec.setintvector,
;			    audio-interrupts, gfx.getcolormap
;	20.10.1998 Harry    gfx.set(a|b)pen, gfx.setdrmd, gfx.initrastport,
;			    topaz.font-replacement, gfx.openfont, gfx.setfont,
;			    some gfx-structures
;	24.10.1998 Harry    gfx.text, some debugging, exec.allocsignal, 
;			    gfx.move, problem with input.addhandler, 
;			    exec.availmem keeps now a reserve of $1000, 
;			    gfx.freecolormap
;	31.10.98   Wepl     input.device fixed, color handling changed 
;			    (getcolormap,freecolormap,loadrgb4,initview,
;			    initvport,makevport,loadview,setrgb4,getsprite,
;			    freesprite,movesprite,changesprite,vbi
;	03.11.98   Wepl     bug in AllocMem fixed (size rounded up now)
;	25.11.1998 Harry    switched back to old gfx-viewport-stuff,
;			    gfx.loadview(0)
;       30.11.1998 MrLarmer exec.(create|delete)(iorequest|msgport),
;			    exec.freesignal, exec.allocsignal changed
;	01.12.1998 Harry    libs in osemu extended to V40 (as i dont have 
;			    3.1-includes working with asm-one do not have 
;			    the idea to replace the values by labels,
;			    ill change them back!), exec.exitintr
;       05.12.1998 Harry    some debugging, list handling debugged again,
;                           exec.allocmem:MEMF_LARGEST dummy, MEMF_REVERSE
;			    dummy, exec.setsignal, dos.currentdir, 
;			    dos.waitforchar, execbase.vblankfrequency,
;			    dos.duplock
;	09.01.1999 JOTD     bugfix in DoIO() return code (D0). "implemented"
;                           CMD_UPDATE (does nothing) and CMD_CLEAR
;	09.01.1999 JOTD     improved CloseWorkbench() intuition call
;                           Now returns 0 only once, and then 1
;                           Led Storm does not lock anymore now
;       10.01.1999 JOTD     added AlohaWorkbench() intuition call (dummy)
;                           added WaitBOFVP() (not accurate)
;                           added CloseScreen() (dummy)
;       14.01.1999 JOTD     added dos.library Info() function
;                           (for Flashback)
;       15.01.1999 JOTD     added D0=0 return codes in input.device
;       15.01.1999 JOTD     added lowlevel.library, nonvolatile.library
;                           added cd.device and freeanim.library (dummies)
;                           added exec CheckIO
;                           improved DoIO (dummy support of cd.device,cdtv.device)
;                           added WaitIO (dummy support of cd.device,cdtv.device)
;                           added SetFunction (for Banshee, now intro OK)
;       30.01.1999 JOTD     added keyboard.device (not complete)
;                           installed a default empty copperlist to avoid problems
;                           with JST
;       02.02.1999 JOTD     added complete lowlevel.library ReadJoyPort() function
;                           using function keys (F1-F5) for joypad extra buttons
;                           DoIO/SendIO: if device is not found, then return with
;                           no error (dummy for cd.device)
;                           Oscar CD32 now works perfectly!
;       18.03.1999 MrLarmer keyboard.device improved
;       	            FreeSignal improved
;
;       30.03.1999 JOTD     Added graphics.library InitTmpRas, InitArea
;       01.04.1999 JOTD     Added mathffp.library SPFlt,SPDiv (removed
;                           from intuition.s)
;       01.04.1999 JOTD     Added mathtrans.library SPATan (untested)
;       17.04.1999 JOTD     Dummy console.device added
;       19.05.1999 JOTD     Added CMD_WRITE to trackdisk DoIO (for ArcadePool)
;                           Added dummy entry for nonvolatile StoreEnv
;                           Added items in the OSEmu structure for use with JST
;                           Added OSEmu ID, version/release and version string
;                           Added whdmacros.i include for v10 WHDLoad .i files
;       26.05.1999 JOTD     Added EntryType to FileInfoBlock structure
;                           (Sensible Soccer CD32 v1.2 needed 2 $FFFF in struct
;                           to get hold of the filesize, the bastards!)
;       08.06.1999 JOTD     Added fastmemory support, debug entry (HRTMon)
;                           Added flush cache after LoadSeg() succeeded (v1.4)
;       11.06.1999 JOTD     Corrected LoadSeg() to allocate hunks in chip/fast (v1.5)
;	26.06.1999 JOTD     Added dummy AssignPath()
;                           Added disk.resource OpenResource() (no functions yet)
;                           Fixed a bug in Examine if not found (FreeMem problem)
;                           Added ExamineFH (SlamTilt)
;                           Added AllocRemember/FreeRemember (SlamTilt)
;       10.08.1999 JOTD     Added dummy disk.resource GetUnit()
;                           Added AllocEntry/FreeEntry (on Bored Seal request) (v1.7)
;       24.09.1999 JOTD     Bugfixed DupLock() (v1.8)
;	12.02.2000 JOTD	    Added dummy RemakeDisplay for Darkmere (v1.9)
;                           LoadSeg() bugfix: zero-length hunks are allowed
;       21.02.2000 Harry    Copperinterrupt implemented, Audioint and 
;                           Add/RemIcrVector fixed, minor changes (v1.10)
;	                    Added HUNK_DEBUG support to LoadSeg()
;       02.03.2000 JOTD     Added dummy IoErr() (v1.11)
;
;	Note:	- does not run with JumpingJackSon because 
;		  it expects an old bug in dos.LoadSeg (APTR instead BPTR)
;		- with Deuteros and Millenium2�2 the mouse poiner is invisible
;		  now (broken graphics clist stuff)
;
;  :Copyright.	GPL
;  :Language.	68000 Assembler
;  :Translator.	Asm-One V1.30 R399, Barfly V2.9, Asm-Pro V1.12, Devpac V3.14
;---------------------------------------------------------------------------*
; Currently emulated functions:
;	exec.library
;		_LVOAddHead
;		_LVOAddIntServer	;partial
;		_LVOAddPort		;dummy !
;		_LVOAddTail
;		_LVOAllocAbs
;		_LVOAllocMem
;		_LVOAllocSignal
;		_LVOAvailMem
;		_LVOCloseDevice		;dummy
;		_LVOCloseLibrary	;dummy
;		_LVOCopyMem		;not optimized
;		_LVODisable
;		_LVODoIO		;some of trackdisk/input
;		_LVOEnable
;		_LVOExitIntr		;experimentally
;		_LVOFindName
;		_LVOFindTask		;partially
;		_LVOForbid		;dummy
;		_LVOFreeMem
;		_LVOGetMsg		;dummy
;		_LVOInsert
;		_LVOOldOpenLibrary
;		_LVOOpenDevice		;only trackdisk/input !
;		_LVOOpenLibrary
;		_LVOOpenResource
;		_LVOPermit		;dummy
;		_LVORemove
;		_LVORemHead
;		_LVORemIntServer
;		_LVORemPort		;dummy
;		_LVORemTail
;		_LVOSendIO		;only input !
;		_LVOSetIntVector	;only audiointerrupts
;		_LVOSetSignal
;		_LVOSuperState		;exact v39
;		_LVOSupervisor
;		_LVOUserState		;exact v39
;	dos.library
;		_LVOClose
;		_LVOCurrentDir		;returns always 0 for rootdir
;		_LVODeviceProc		;dummy
;		_LVODupLock		;limited to files and null for rootdir
;		_LVOExamine		;doesnt work for dirs atm, only files and volumes
;		_LVOInput		;dummy
;		_LVOLoadSeg
;		_LVOLock		;atm no dirs, only files and volumes
;		_LVOOpen
;		_LVOOutput		;dummy
;		_LVORead
;		_LVOSeek
;		_LVOUnLoadSeg
;		_LVOUnLock		;internal the same as dos.close
;		_LVOWaitForChar		;atm dummy, implementation freezed
;		_LVOWrite
;	graphics.library
;		_LVOAllocRaster
;		_LVOBltBitMap		;has still some limitations !
;		_LVOBltClear		;with CPU
;		_LVOBltTemplate		;broken
;		_LVODisownBlitter	;dummy
;		_LVOChangeSprite
;		_LVODraw		;dummy !
;		_LVOFreeColorMap
;		_LVOFreeRaster
;		_LVOFreeSprite
;		_LVOGetColorMap
;		_LVOGetSprite
;		_LVOInitBitMap
;		_LVOInitRastPort
;		_LVOInitView		;dummy !
;		_LVOInitVPort		;dummy !
;		_LVOLoadView		;sets copperlist
;		_LVOLoadRGB4		;sets colors immediate
;		_LVOMakeVPort		;builds copperlist
;		_LVOMove
;		_LVOMoveSprite
;		_LVOMrgCop
;		_LVOOwnBlitter		;dummy
;		_LVOReadPixel
;		_LVOSetAPen
;		_LVOSetBPen
;		_LVOSetDrMd
;		_LVOSetRGB4		;sets color immediate
;		_LVOText
;		_LVOVBeamPos
;		_LVOWaitBlit
;		_LVOWaitTOF
;		_LVOWritePixel
;	intuition.library
;		_LVOClearDMRequest	;dummy
;		_LVOCloseWindow		;rudimentary
;		_LVOCloseWorkbench
;		_LVOOpenWindow		;rudimentary
;	ciaa.resource,ciab.resource
;		_LVOAddICRVector
;		_LVORemICRVector
;	icon.library
;	layers.library
;	mathffp.library
;	mathtrans.library
;---------------------------------------------------------------------------*
; programs using this stuff (non exhaustive list):
;	AnotherWorld (WHDLoad), Arcade Pool (JST), Blue Angel 69 (WHDLoad), 
;       Bombuzal (WHDLoad), Bubble Bobble (JST), Castle Master (WHDLoad), 
;       Colorado, Crazy Cars 3 (WHDLoad), Deuteros (WHDLoad), Flashback (JST), 
;       Flink CD32 (WHDLoad), JumpingJackSon (WHDLoad), Lionheart (WHDLoad),
;       Metal Mutant, North&South (WHDLoad), Oscar CD32 (JST), 
;       PushOver (WHDLoad), Sensible Soccer CD32 (JST), 
;       Shadow Fighter CD32 (JST), Son Of Stag series (JST), 
;       Street Fighter 1 (JST), Bubba and Stix (JST), Sierra Soccer (JST)...
;
; unfinished:
;	Millenium 2�2, Lords of War (works until title), 
;	Prehistorik (gfx.MrgCop must be improved),
;       Black Tiger (JST) (works until title), Led Storm (JST) (no gfx in game),
;	Imperium (JST)
;---------------------------------------------------------------------------*
; ToDo:
;	rewriting memory management for less memory waste
;	implement dos.waitforchar fully: allow open to raw:, read characters,
;	  close
;	support nonexisting files in dos.lib
;
;---------------------------------------------------------------------------*
; How to use in WHDLoad:
;
;	;load the osemu module
;		lea	(_osemu,pc),a0		;filename of the osemu module
;		lea	($400.w),a1		;the address on which you have
;						;assembled the osemu module
;		move.l	(_resload,pc),a2	;the resload base
;		jsr	(resload_LoadFileDecrunch,a2)	;this allows to
;						;compress the osemu
;	;init the osemu module
;						;system stack has to be on 
;						;top of memory (automatically
;						;done by whdload)
;		move.l	(_resload,pc),a0	;the resload base
;		lea	(_base,pc),a1		;the slave structure
;		jsr	$400
;
;	;start the program
;		move	#0,sr			;if the program uses the os it
;						;should executed in user mode
;
;	;if you want to add a trainer use this, to setup a routine which will
;	;be called each time a key is pressed (d0.b contains rawkeycode)
;		lea	(_trainer,pc),a0
;		move.l	a0,($404.w)
;	;if you want to use fast memory:
;		lea	(_base,pc),a1		;the slave structure
;		move.l	(ws_ExpMem,A1),($424.w)
;		move.l	#<expmem size>,($428.w)
;
;---------------------------------------------------------------------------*

;---------------------------------------------------------------------------*
; How to use in JST:
;
;	;allocate expansion memory if needed
;
;	move.l	#$100000,D0	; 1meg
;	JSRABS	AllocExtMem
;
;	;load the osemu module (when the OS is active)
;
;	JSRABS	UseHarryOSEmu
;
;	;start the program
;
;	GO_SUPERVISOR
;	SAVE_OSDATA	xxxx			; classical OS-kill call
;
;	move	#0,sr			;if the program uses the os it
;					;should executed in user mode
;					;but it's seldom necessary
;
;	;if you want to add a trainer use this, to setup a routine which will
;	;be called each time a key is pressed (d0.b contains rawkeycode)
;		lea	(_trainer,pc),a0
;		move.l	a0,$400+OSM_SLVTRAINER
;
;---------------------------------------------------------------------------*

	INCLUDE	whoami.i			;this contains only a symbol

	IFD HARRY				;(asm-one)
		INCDIR	ASM-ONE:INCLUDE2.0/
		INCLUDE LIBRARIES/DOS_LIB.I
		INCLUDE	LIBRARIES/DOS.I
		INCLUDE	DEVICES/INPUT.I
		INCLUDE	DEVICES/KEYBOARD.I
		INCLUDE	DEVICES/TRACKDISK.I
		INCLUDE	DOS/DOSEXTENS.I
		INCLUDE	DOS/DOSHUNKS.i
		INCLUDE RESOURCES/CIA_LIB.I
		INCLUDE EXEC/EXEC_LIB.I
		INCLUDE	EXEC/MEMORY.I
		INCLUDE	EXEC/TASKS.I
		INCLUDE	GRAPHICS/GRAPHICS_LIB.I
		INCLUDE	GRAPHICS/LAYERS_LIB.I
		INCLUDE	GRAPHICS/GFXBASE.I
		INCLUDE	GRAPHICS/DISPLAYINFO.I
		INCLUDE	GRAPHICS/SPRITE.I
		INCLUDE	HARDWARE/CUSTOM.I
		INCLUDE INTUITION/INTUITION_LIB.I
		INCLUDE INTUITION/INTUITION.I
		INCLUDE	MATH/MATHFFP_LIB.I
		INCLUDE	MATH/MATHTRANS_LIB.I
		INCLUDE	OWN/CCRMAKRO
		INCLUDE	OWN/WHDLOAD.I
		INCLUDE	WORKBENCH/ICON_LIB.I
		INCLUDE	OWN/WHDMACROS.I
		INCLUDE	OWN/LOWLEVEL_LIB.I
		INCLUDE	OWN/LOWLEVEL.I
		INCLUDE	OWN/NONVOLATILE_LIB.I
		INCLUDE RESOURCES/DISK_LIB.I
HUNKB_CHIP	=	30
HUNKB_FAST	=	31
	org	$400
	load	$100000
	ENDC
	IFD WEPL				;(barfly)
		INCDIR	Includes:
		INCLUDE	devices/input.i
		INCLUDE	devices/inputevent.i
		INCLUDE	devices/trackdisk.i
		INCLUDE	devices/keyboard.I
		INCLUDE	dos/dos.i
		INCLUDE	dos/doshunks.i
		INCLUDE	dos/dosextens.i
		INCLUDE	exec/memory.i
		INCLUDE	exec/tasks.i
		INCLUDE	graphics/gfx.i
		INCLUDE	graphics/gfxbase.i
		INCLUDE	graphics/rastport.i
		INCLUDE	graphics/sprite.i
		INCLUDE	graphics/view.i
		INCLUDE	intuition/intuition.i
		INCLUDE	lvo/cia.i
		INCLUDE	lvo/dos.i
		INCLUDE	lvo/exec.i
		INCLUDE	lvo/graphics.i
		INCLUDE	lvo/icon.i
		INCLUDE	lvo/intuition.i
		INCLUDE	lvo/layers.i
		INCLUDE	lvo/mathffp.i
		INCLUDE	lvo/mathtrans.i
		INCLUDE	whdload.i
		INCLUDE	whdmacros.i	; added for WHDLoad v10 includes

		IFD BARFLY
		BOPT	O+ OG+			;enable optimizing
		BOPT	ODd- ODe-		;disable mul optimizing
		BOPT	w4-			;disable 64k warnings
		SUPER				;disable supervisor warnings
		ENDC

		ORG	$400
		OUTPUT	OSEmu.400
		;OUTPUT	wart:a/anotherworld/osemumodule400.bin
		;OUTPUT	wart:b/bombuzal/osemumodule400.bin
		;OUTPUT	wart:d-f/deuteros/OSEmu.400
		;OUTPUT	wart:h-j/jumpingjackson/osemumodule400.bin
		;OUTPUT	wart:m/millennium2�2/OSEmu.400
		;OUTPUT	wart:n-p/north&south/OSEmu.400
	ENDC

	IFD JOTD				;(phxass/barfly)
		INCDIR	include:
		INCLUDE	"LVOs.i"
		INCLUDE	"jst_libs.i"
		INCLUDE	"dos/doshunks.i"
		INCLUDE "devices/trackdisk.i"
		INCLUDE "devices/input.i"
		INCLUDE	"devices/keyboard.I"
		INCLUDE "devices/inputevent.i"
		INCLUDE "exec/interrupts.i"
		INCLUDE	"graphics/gfx.i"
		INCLUDE	"graphics/gfxbase.i"
		INCLUDE	"graphics/rastport.i"
		INCLUDE	"graphics/sprite.i"
		INCLUDE	"graphics/view.i"
		INCLUDE	"intuition/intuition.i"
		INCLUDE	"libraries/lowlevel.i"
		INCLUDE	"libraries/nonvolatile.i"

		INCLUDE	"whdload.i"
		INCLUDE	"whdmacros.i"	; added for WHDLoad v10 includes

		IFD BARFLY
		BOPT	O+ OG+			;enable optimizing
		BOPT	ODd- ODe-		;disable mul optimizing
		BOPT	w4-			;disable 64k warnings
		BOPT	wo-			;disable optimizer warnings
		SUPER				;disable supervisor warnings
		ENDC

		ORG	$400
		OUTPUT	C:OSEmu.400

	ENDC

	IFD MR.LARMER				;(devpac)
		INCDIR	Include:
		INCLUDE	devices/input.i
		INCLUDE	devices/inputevent.i
		INCLUDE	devices/keyboard.i
		INCLUDE	devices/trackdisk.i
		INCLUDE	dos/dos.i
		INCLUDE	dos/doshunks.i
		INCLUDE	dos/dosextens.i
		INCLUDE	exec/memory.i
		INCLUDE	graphics/gfx.i
		INCLUDE	graphics/gfxbase.i
		INCLUDE	graphics/rastport.i
		INCLUDE	graphics/sprite.i
		INCLUDE	graphics/view.i
		INCLUDE	intuition/intuition.i
		INCLUDE	libraries/lowlevel.i
		INCLUDE	libraries/nonvolatile.i
		INCLUDE	lvo/cia_lib.i
		INCLUDE	lvo/dos_lib.i
		INCLUDE	lvo/exec_lib.i
		INCLUDE	lvo/graphics_lib.i
		INCLUDE	lvo/icon_lib.i
		INCLUDE	lvo/intuition_lib.i
		INCLUDE	lvo/layers_lib.i
		INCLUDE	lvo/lowlevel_lib.i
		INCLUDE	lvo/mathffp_lib.i
		INCLUDE	lvo/mathtrans_lib.i
;		INCLUDE	lvo/nonvolatile_lib.i
		INCLUDE	whdload.i

		OPT	O+ OG+			;enable optimizing
		OPT	P=68020

		ORG	$400
		OUTPUT	OSEmu.400
	ENDC

USPLENGTH=$2000		;reserved area for USP, enlarge if necessary

CORRECTDEVICES=1	;if set 0, module will be assembled with
			;cut-down devices (no list connection, no
			;msgport of td.dev, no library-like device-
			;structure)

; config bits for JST
; (WHDLoad has got its tags, why JST cannot have its ones :))

AFB_NTSC = 0
AFB_NOOSSWAP = 4

;---------------------------------------------------------------------------*
**************************************************************************
*   INITIALIZATION CALL                                                  *
**************************************************************************

		bra	_Init
		CNOP 0,4	;essential for correct OSEmu-Structure !

**************************************************************************
*   GLOBAL VARIABLES                                                     *
**************************************************************************

;-------------------------------------------------------------------------
; the following data are part of the OSEmu structure, the offsets of these
; data are guaranteed to remain unchanged for all future versions

VERSION = 1
RELEASE = 11

OSM_SLVTRAINER	DC.L	0	;OSEmu-Offset = 4
OSM_LASTLOADSEG	dc.l	0	;OSEmu-Offset = 8
OSM_ID		dc.b	"OSEM"	;OSEmu-Offset = 12 : added by JOTD
OSM_VER		dc.w	VERSION	;OSEmu-Offset = 16 : ""
		dc.w	RELEASE	;OSEmu-Offset = 18 : ""
OSM_COPPERADDR	dc.l	0	;OSEmu-Offset = 20 : "" 
OSM_ICONIFYCODE	dc.l	0	;OSEmu-Offset = 24 : ""
OSM_ICONIFYKEY	dc.l	0	;OSEmu-Offset = 28 : ""
OSM_JSTFLAGS	dc.l	0	;OSEmu-Offset = 32 : ""
OSM_EXPMEM	dc.l	0	;OSEmu-Offset = 36 : ""
OSM_EXPSIZE	dc.l	0	;OSEmu-Offset = 40 : ""
OSM_DEBUGENTRY	dc.l	0	;OSEmu-Offset = 44 : ""
		dc.l	0,0,0,0,0,0,0,0	; future use
; version string

	dc.b	"$VER: OSEmu v",VERSION+'0',".",RELEASE+'0',0
	cnop	0,4

;-------------------------------------------------------------------------

ALLOCMTABSIZE	DC.L	0		; chip memory
ALLOCFASTMTABSIZE	DC.L	0	; fast memory
_Slave		dc.l	0
_RESLOAD	dc.l	0
_dosbase	dc.l	0
_gfxbase	dc.l	0
_intbase	dc.l	0
_ilibbase	dc.l	0
_laybase	dc.l	0
_mffpbase	dc.l	0
_mtrbase	dc.l	0	; added by JOTD
_lowlbase	dc.l	0	; added by JOTD
_franbase	dc.l	0	; added by JOTD
_nonvbase	dc.l	0	; added by JOTD
_diskbase	dc.l	0	; added by JOTD
_ciaabase	dc.l	0
_ciabbase	dc.l	0
_inputhandler	dc.l	0			;input.device handler (interrupt server structure)
_inputevent	ds.b	ie_SIZEOF
_tags		dc.l	WHDLTAG_ATTNFLAGS_GET
		dc.w	0
_attnflags	dc.w	0
		dc.l	WHDLTAG_ECLOCKFREQ_GET
_eclockfreq	dc.l	0
		dc.l	WHDLTAG_MONITOR_GET
_monitor	dc.l	0
		dc.l	WHDLTAG_CHIPREVBITS_GET
_chiprev	dc.l	0
		dc.l	WHDLTAG_Private3
_p3		dc.l	0
		dc.l	0

_libtable	dc.l	_dosname,DOSINIT
		dc.l	_gfxname,GFXINIT
		dc.l	_intname,INTUIINIT
		dc.l	_execname,EXEC2INIT
		dc.l	_ilibname,ILIBINIT
		dc.l	_layname,LAYERSINIT
		dc.l	_mffpname,MATHFFPINIT
		dc.l	_lowlname,LOWLINIT
		dc.l	_franname,FRANINIT
		dc.l	_mtrname,MATHTRANSINIT
		dc.l	_nonvname,NONVINIT
		dc.l	0
_restable	dc.l	_ciaaname,CIAAINIT
		dc.l	_ciabname,CIABINIT
		dc.l	_diskname,DISKINIT
		dc.l	0

_devtable
_tddevtable	DC.L	_tdname,0
_inpdevtable	DC.L	_inpname,0
_auddevtable	DC.L	_audname,0
_cddevtable	DC.L	_cdname,0
_cdtvdevtable	DC.L	_cdtvname,0
_kbdevtable	DC.L	_kbdevname,0
_condevtable	DC.L	_condevname,0
		DC.L	0

; added by JOTD
sec_timer:
	dc.l	0
millisec_timer:
	dc.l	0

_last_joy0dat	dc.w	0

_sprites	ds.l	8

KBDVAL		DC.B	0
_last_lmb	dc.b	0
_last_rmb	dc.b	0

_mffpname	dc.b	'mathffp.library',0
_layname	dc.b	'layers.library',0
_ilibname	dc.b	'icon.library',0
_execname	dc.b	"exec.library",0
_dosname	dc.b	"dos.library",0
_gfxname	dc.b	"graphics.library",0
_intname	dc.b	"intuition.library",0
_lowlname	dc.b	"lowlevel.library",0	; added by JOTD
_franname	dc.b	"freeanim.library",0	; added by JOTD
_nonvname	dc.b	"nonvolatile.library",0	; added by JOTD
_mtrname	dc.b	"mathtrans.library",0	; added by JOTD
_ciaaname	dc.b	"ciaa.resource",0
_ciabname	dc.b	"ciab.resource",0
_diskname	dc.b	"disk.resource",0
	EVEN
_tdname		dc.b	'trackdisk.device',0
	EVEN
_inpname	dc.b	'input.device',0
	EVEN
_audname	dc.b	'audio.device',0
	EVEN
_cdname		dc.b	'cd.device',0
	EVEN
_cdtvname	dc.b	'cdtv.device',0
	EVEN
_kbdevname	dc.b	'keyboard.device',0
	EVEN
_condevname	dc.b	'console.device',0
	EVEN

;task gets a process structure

_EXECLIBTASK	DC.L	0
		DC.L	0
		DC.B	NT_TASK
		DC.B	0
		DC.L	_execname
		DC.B	0
		DC.B	TS_RUN
		DC.B	0
		DC.B	0
		DC.L	0		;TC_SIGALLOC
		DC.L	0
		DC.L	0
		DC.L	0
		DC.W	0
		DC.W	0
		DC.L	0
		DC.L	0
		DC.L	0
		DC.L	0
		DC.L	0
		DC.L	0
		DC.L	0
		DC.L	0
		DC.L	0

		DC.L	0
		DC.L	0
		DC.L	0
		DC.B	0
		DC.B	0

		DC.L	0

_EXECLIBMSGPORT	DC.L	0		;MUST FOLLOW DIRECTLY TO TASK
		DC.L	0		;CC3 EXPECTS THAT SO
		DC.B	NT_MSGPORT
		DC.B	0
		DC.L	0

		DC.B	PA_SIGNAL
		DC.B	0		;BIT 0 AS SIGNALBIT
		DC.L	_EXECLIBTASK

		DC.L	0		;NO MESSAGES YET
		DC.L	0
		DC.L	0
		DC.B	NT_MESSAGE
		DC.B	0


		DC.W	0
		DC.L	$EEEEEEEE	;INVALID SEGLIST
		DC.L	USPLENGTH-$20
		DC.L	$EEEEEEEC	;INVALID GLOBVEC
		DC.L	1
		DC.L	0
		DC.L	0
		DC.L	$EEEEEEEA
		DC.L	0
		DC.L	0
		DC.L	$EEEEEEEE
		DC.L	$EEEEEEEE
_bcplcorrect1	DC.L	_CLI
		DC.L	$EEEEEEEE
		DC.L	0
		DC.L	-1
_EXECLIBPROCESS_SIZEOF

	IFNE	_EXECLIBMSGPORT-_EXECLIBTASK-$5C
	FAIL
	ENDC

	IFNE	_EXECLIBPROCESS_SIZEOF-_EXECLIBTASK-$BC
	FAIL
	ENDC


	CNOP	0,4
_CLI		DC.L	0
		DC.L	$EEEEEEE
		DC.L	$EEEEEEE
		DC.L	0
_bcplcorrect2	DC.L	_ANIMNAME
		DC.L	20
		DC.L	$EEEEEEE
		DC.L	$EEEEEEE
		DC.L	$EEEEEEE
		DC.L	$EEEEEEE
		DC.L	0
		DC.L	0
		DC.L	$EEEEEEE
		DC.L	USPLENGTH-$20
		DC.L	$EEEEEEE
		DC.L	$EEEEEEE

	CNOP	0,4
_ANIMNAME	DC.B	8,'df0:anim',0

	EVEN

_EXECMINSIZE

	DS.B	822		;-_LVOExecReserved08

_EXECLIBBASE
	DC.L	_LIBLIST+4
	DC.L	_LIBLIST
	DC.B	NT_LIBRARY
	DC.B	0
	DC.L	_execname
					;end of node structure
	DC.B	4
	DC.B	$EE
	DC.W	-_LVOCopyMemQuick
	DC.W	$24C
	DC.W	$28			;version of exec.lib=KS3.1
	DC.W	$0A			;subversion
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.W	0
					;end of library structure
	DC.W	$44			;version: KS3.1
	DC.W	$EEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	0
	DC.L	0
	DC.L	0
	DC.L	0
	DC.L	0
	DC.L	$EEEEEEEE
	DC.L	0
	DC.W	$EEEE	

	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD

	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD

	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD

	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD

	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD

	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD

	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD

	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD

	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD

	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD

	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD

	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD

	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD

	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD

	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD

	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD
	DC.L	$DDDDDDDD

	DC.L	_EXECLIBTASK
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.W	$EEEE
	DC.W	$DDDD
	DC.W	$EEEE
	DC.B	-1
	DC.B	-1
	DC.W	0
	DC.W	$EEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE		;DUMMY, NORMALLY ALLOCATED SIGNALS
	DC.W	$EEEE

	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.W	$EEEE

	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.W	$EEEE

	IFNE	CORRECTDEVICES
_DEVLISTC	DC.L	_DEVLISTC+4
		DC.L	0
		DC.L	_DEVLISTC
		DC.B	NT_DEVICE
		DC.B	0
	ELSE
		DC.L	$EEEEEEEE		;DEVICELIST
		DC.L	$EEEEEEEE
		DC.L	$EEEEEEEE
		DC.W	$EEEE
	ENDC

	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.W	$EEEE

_LIBLIST	DC.L	_EXECLIBBASE
		DC.L	0
		DC.L	_EXECLIBBASE
		DC.B	NT_LIBRARY
		DC.B	0

	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.W	$EEEE

_TASKREADYLIST	DC.L	_TASKREADYLIST+4
		DC.L	0
		DC.L	_TASKREADYLIST
		DC.B	NT_TASK
		DC.B	0

	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.W	$EEEE

	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE

	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE

	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE

	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE

	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE

	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE

	DC.B	$EE			;VBLANK FREQU
	DC.B	$EE			;POWER SUPPLY FREQU
	
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.W	$EEEE

	DC.L	$EEEEEEEE
	DC.L	$EEEEEEEE
	DC.W	$EEEE

	DS.B	12
	DS.B	20
	DS.B	$2C
_EMAXSIZE

	IFNE	_EMAXSIZE-_EXECLIBBASE-$278
	FAIL
	ENDC


	IFNE	CORRECTDEVICES
_TDDMSGPORT
	DC.L	0
	DC.L	0
	DC.B	NT_MSGPORT
	DC.B	0
	DC.L	_tdname

	dc.b	0
	dc.b	0
	DC.L	_EXECLIBTASK

	DC.L	0
	DC.L	0
	DC.L	0
	DC.B	NT_MESSAGE
	DC.B	0

	DC.L	1			;DUE LORDS OF WAR -UNDOCUMENTED-

	ENDC

	cnop	0,4
_DummyCList:				; added by JOTD
	dc.l	$FFFFFFFE

**************************************************************************
*   VERSION                                                              *
**************************************************************************

	IFND BARFLY
		DC.B	'$VER: OS_EMUMODULE 0.26 +DEV (05-dec-1998 8:00:00)',0
	ELSE
		dc.b	"$VER: OSEmu "
		DOSCMD	"WDate >T:date"
		INCBIN	"T:date"
		dc.b	0
		dc.b	"$Id: osemu.asm 1.2 1999/02/03 04:10:48 jotd Exp jotd $"
	ENDC
	EVEN

**************************************************************************
*   GLOBAL INITIALIZATION                                                *
**************************************************************************
;REQUIRES NOW AT LEAST WHDLOAD 7.0
;ALTHOUGH THERE IS NO MULTITASKING IMPLEMENTED AT THE MOMENT,
;ALL FUNCTIONS MUST BE IMPLEMENTED REENTRANTLY
;
; IN:	A0 = resload base
;	A1 = pointer to slave structure
; OUT:	A1 = ioreq of trackdisk.device
;	A6 = execbase

_Init		movem.l	d0-a0/a2-a5,-(a7)

		cmp.w	#7,(ws_Version,a1)	;minimum version
		blo	_ill

		move.l	a0,_RESLOAD
		move.l	a1,(_Slave)

	;install a default copperlist

		move.l	#_DummyCList,(_custom+cop1lc)

	;correct structures
BCPLCORRECT	MACRO
		move.l	\1,d0
		lsr.l	#2,d0
		move.l	d0,\1
		ENDM
		BCPLCORRECT	_bcplcorrect1
		BCPLCORRECT	_bcplcorrect2

	;init memory managment

	; chip memory

		lea	_osemu_end,a0		;FIRST CLEAR WHOLE TABLE (MARK MEM AS USED)
		move.l	(ws_BaseMemSize,a1),d0
		SUBQ.L	#8,D0
		LSR.L	#3,D0			;OK, AMOUNT OF BITS TO CLEAR IS IN D0
		LSR.L	#3,D0			;AMOUNT OF BYTES TO CLEAR IN D0
.1		CLR.B	(A0)+
		SUBQ.L	#1,D0
		BPL.S	.1
		MOVE.L	A0,ALLOCMTABSIZE
		move.l	(ws_BaseMemSize,a1),d0
		SUB.L	A0,D0
		SUB.L	#$1000,D0		;$1000 SYSTEM STACK ON TOP
		MOVE.L	A0,A1			;FREE APPROPRIATE SIZE
		BSR	FREEM

	; fast memory if available

;;	clr.l	OSM_EXPMEM

		move.l	OSM_EXPMEM,a0		;FIRST CLEAR WHOLE TABLE (MARK MEM AS USED)
		cmp.l	#0,A0
		beq.b	.nofast
	
		move.l	OSM_EXPSIZE,d0
		SUBQ.L	#8,D0
		LSR.L	#3,D0			;OK, AMOUNT OF BITS TO CLEAR IS IN D0
		LSR.L	#3,D0			;AMOUNT OF BYTES TO CLEAR IN D0
.2		CLR.B	(A0)+
		SUBQ.L	#1,D0
		BPL.S	.2
		MOVE.L	A0,ALLOCFASTMTABSIZE	; not real size!

		move.l	OSM_EXPSIZE,d0
		add.l	OSM_EXPMEM,D0		; adds expbase
		SUB.L	A0,D0			; substracts expbase+tabsize
		SUB.L	#$100,D0		;$100 safety

		MOVE.L	A0,A1			;FREE APPROPRIATE SIZE
		BSR	FREEM

.nofast:
	;allocate stack
		move.l	#USPLENGTH,d0
		moveq	#MEMF_PUBLIC,d1	; MEMF_CHIP removed
		bsr	ALLOCM
		move.l	d0,a0
		MOVE.L	A0,_EXECLIBTASK+TC_SPLOWER
		add.l	#USPLENGTH-4,a0
		move.l	a0,usp
		MOVE.L	A0,_EXECLIBTASK+pr_StackBase
		MOVE.L	#USPLENGTH-$20,(A0)+
		MOVE.L	A0,_EXECLIBTASK+TC_SPUPPER

	;get whdload vars
		lea	_tags,a0
		move.l	_RESLOAD,a1
		jsr	(resload_Control,a1)

	;init libraries
		bsr	CIAAINIT		;required because int handling
		bsr	CIABINIT		;required because int handling
		bsr	EXECINIT
		bsr	GFXINIT			;required for display init (copper)
		IFNE	CORRECTDEVICES
		BSR.W	MAKEDEVICELIST
		ENDC
		move.w	#INTF_SETCLR!INTF_INTEN!INTF_EXTER!INTF_VERTB!INTF_PORTS,(_custom+intena)


	;flush caches
		move.l	(_RESLOAD),a0
		jsr	(resload_FlushCache,a0)

	;prepare return values
		move.l	(4),a6
		move.l	#$400+IOTD_SIZE,d0
		moveq	#0,d1
		jsr	(_LVOAllocMem,a6)
		move.l	d0,a2
		lea	(_tdname),a0
		moveq	#0,d0
		move.l	a2,a1
		moveq	#0,d1
		jsr	(_LVOOpenDevice,a6)
		move.l	a2,a1
		lea	(IOTD_SIZE,a2),a0
		move.l	a0,(IO_DATA,a1)
		move.l	#$400,(IO_LENGTH,a1)
		clr.l	(IO_OFFSET,a1)
		move.w	#CMD_READ,(IO_COMMAND,a1)

		movem.l	(a7)+,d0-a0/a2-a5

		rts

; Added by JOTD: enter debugger (useful for debugging with JST)

EnterDebugger:
	move.l	A0,-(A7)
	move.l	OSM_DEBUGENTRY,A0
	cmp.l	#0,A0
	beq.b	.exit
	jsr	(A0)
.exit
	move.l	(A7)+,A0
	rts

**************************************************************************
*   MISC FUNCTIONS                                                       *
**************************************************************************
;-----------------------------------------------
; IN:	D0 = ULONG size of jmp table
;	D1 = ULONG size of variable area
;	A0 = CPTR  subsystem name
; OUT:	D0 = APTR  librarybase

_InitStruct	movem.l	d0-d1/a0,-(a7)
		add.l	d1,d0
		moveq	#MEMF_CHIP,d1		;changed by JOTD
		bsr	ALLOCM
		move.l	d0,a0			;jmp table start
                move.l	d0,a1
		add.l	(a7),a1			;jmp table end

		lea	_LVOFail,a2
.1		move.w	#$4EB9,(A0)+
		move.l	a2,(a0)+
		cmp.l	a0,a1
		bhi	.1
		move.l	(8,a7),-4(a0)		;name of library
		move.l	a0,(A7)			;library base
		move.l	a0,a1			;variables start
		add.l	(4,a7),a1		;variables end
.2		move.w	#$eeee,(a0)+
		cmp.l	a0,a1
		bhi	.2
		MOVEM.L	(A7)+,D0/D1/A0
		rts

_InitLibrary	BSR.S	_InitStruct
		MOVE.L	D0,A1
		MOVE.B	#NT_LIBRARY,LN_TYPE(A1)
		SF	LN_PRI(A1)
		move.l	A0,LN_NAME(A1)		;name of library
		LEA.L	_LIBLIST(PC),A0
		BSR.W	_ADDTAIL
		rts

	IFNE	CORRECTDEVICES
_InitDevice	BSR.S	_InitStruct
		MOVE.L	D0,A1
		MOVE.B	#NT_LIBRARY,LN_TYPE(A1)
		SF	LN_PRI(A1)
		move.l	A0,LN_NAME(A1)		;name of library
		LEA.L	_DEVLISTC(PC),A0
		BSR.W	_ADDTAIL
		rts
	ENDC

_LVOFail	exg.l	d0,a6
		sub.l	d0,(a7)			;LVO
		exg.l	d0,a6
		subq.l	#6,(a7)
		move.l	(-4,a6),-(a7)		;name of library
_emufail	pea	TDREASON_OSEMUFAIL
		move.l	_RESLOAD(pc),-(a7)
		addq.l	#resload_Abort,(a7)
_rts		rts

EMUFAIL		MACRO
		pea	\1
		pea	\2
		bra	_emufail
		ENDM
EXECFAIL	MACRO
		EMUFAIL	\1,_execname
		ENDM
GFXFAIL		MACRO
		EMUFAIL	\1,_gfxname
		ENDM

;-----------------------------------------------
; IN:	A0 = CPTR  string 1
;	A0 = CPTR  string 2
; OUT:	D0 = LONG  0 if strings are equal

_strcmp		movem.l	a0-a1,-(a7)
.1		cmpm.b	(a0)+,(a1)+
		bne	.not
		tst.b	(-1,a0)
		bne	.1
		move	#0,d0
		movem.l	(a7)+,a0-a1
		rts

.not		moveq	#-1,d0
		movem.l	(a7)+,a0-a1
		rts

;-----------------------------------------------
; wait for vertical blank

_waitvb
.1		btst	#0,(_custom+vposr+1)
		beq	.1
.2		btst	#0,(_custom+vposr+1)
		bne	.2
		rts

_ill		illegal

**************************************************************************
*   EXEC LIBRARY                                                         *
**************************************************************************

EXEC2INIT
	move.l	A6,D0	; NightShift tries to open exec.library!
	rts

**************************************************************************
*   INITIALIZATION                                                       *
**************************************************************************

EXECINIT
	;	move.l	4,d0
	;	btst	#0,d0
	;	bne	.init
	;	rts

.init		lea	_EXECMINSIZE(PC),A0
		LEA.L	_EXECLIBBASE(PC),A1
		lea	_LVOFail,a2
.1		move.w	#$4EB9,(A0)+
		move.l	a2,(a0)+
		cmp.l	a0,a1
		bhi	.1
		move.l	#_execname,-4(a0)	;name of library
		MOVE.L	a1,a0
		move.l	a0,$4.W
		
		patch	_LVOOldOpenLibrary(a0),OPENLIB(pc)
		patch	_LVOOpenLibrary(a0),OPENLIB(pc)
		patch	_LVOCloseLibrary(A0),MYRTS(PC)

		patch	_LVOAllocMem(a0),ALLOCM(PC)
		patch	_LVOFreeMem(a0),FREEM(PC)
		patch	_LVOAvailMem(a0),AVAILM(PC)
		patch	_LVOAllocAbs(a0),ALLOCA(PC)
		patch	_LVOCopyMem(A0),_COPYMEM(PC)
		patch	_LVOAllocEntry(a0),ALLOCENTRY(PC)
		patch	_LVOFreeEntry(a0),FREEENTRY(PC)

		patch	_LVOForbid(a0),MYRTS(PC)
		patch	_LVOPermit(a0),MYRTS(PC)
		patch	_LVOSetIntVector(A0),_SETINTVECTOR(PC)
		patch	_LVOAddIntServer(a0),_AddIntServer(PC)
		patch	_LVORemIntServer(a0),_RemIntServer(PC)
		patch	-$24(A0),_ExitIntr(PC)
	;	patch	_LVOEnqueue(a0),_Enqueue(PC)
		patch	_LVOOpenResource(a0),OPENRES(PC)
		patch	_LVOSupervisor(a0),_Supervisor(PC)
		patch	_LVOSuperState(a0),_SuperState(PC)
		patch	_LVOUserState(a0),_UserState(PC)
		patch	_LVOFindTask(a0),_FINDTASK(PC)
		patch	_LVORemTask(a0),MYRTS(PC)
		patch	_LVOSetTaskPri(A0),MYRTZ(PC)

		patch	_LVOAddPort(a0),MYRTS(PC)
		patch	_LVOOpenDevice(a0),_OpenDevice(PC)
		patch	_LVODoIO(a0),_DoIO(PC)
		patch	_LVOWaitIO(A0),_WAITIO(PC)	; uncommented by JOTD
		patch	_LVOAbortIO(A0),_ABORTIO(PC)
		patch	_LVOCheckIO(A0),_CHECKIO(PC)	; added by JOTD
		patch	_LVOSendIO(a0),_SendIO(PC)
		patch	_LVOCloseDevice(a0),MYRTS(PC)
		patch	_LVORemPort(a0),MYRTS(PC)

		patch	_LVOAllocSignal(a0),_AllocSignal(PC)
		patch	_LVOFreeSignal(a0),_FreeSignal(PC)
		patch	_LVOSetSignal(a0),_SetSignal(PC)
		patch	_LVODisable(a0),_Disable(PC)
		patch	_LVOEnable(a0),_Enable(PC)
		patch	_LVOWaitPort(A0),MYRTS(PC)
		patch	_LVOGetMsg(A0),MYRTZ(PC)
		patch	_LVOCreateIORequest(A0),_CreateIORequest(PC)
		patch	_LVODeleteIORequest(A0),_DeleteIORequest(PC)
		patch	_LVOCreateMsgPort(A0),_CreateMsgPort(PC)
		patch	_LVODeleteMsgPort(A0),_DeleteMsgPort(PC)

		patch	_LVOInsert(A0),_INSERT(PC)
		patch	_LVOAddHead(A0),_ADDHEAD(PC)
		patch	_LVOAddTail(A0),_ADDTAIL(PC)
		patch	_LVORemove(A0),_REMOVE(PC)
		patch	_LVORemHead(A0),_REMHEAD(PC)
		patch	_LVORemTail(A0),_REMTAIL(PC)
		patch	_LVOFindName(A0),_FINDNAME(PC)

		patch	_LVOCacheControl(A0),MYRTZ(PC)	; added by JOTD
		patch	_LVOCacheClearU(A0),_CacheClearU(PC)	; added by JOTD
		patch	_LVOSetFunction(A0),_SetFunction(PC)	; added by JOTD
		patch	_LVOFindResident(A0),_FindResident(PC)	; added by JOTD

		move.w	(_attnflags),(AttnFlags,a0)

		MOVE.L	_Slave(PC),A1
		MOVE.L	ws_BaseMemSize(A1),A1
		MOVE.L	A1,SysStkUpper(A0)
		MOVE.L	A1,MaxLocMem(A0)
		LEA.L	-$1000(A1),A1
		MOVE.L	A1,SysStkLower(A0)
		MOVE.L	_monitor(PC),D0
		MOVEQ.L	#60,D1
		AND.L	#$FFFF1000,D0
		CMP.L	#$21000,D0
		BNE.S	.nopal
		moveq.l	#50,D1
.nopal
		move.b	d1,VBlankFrequency(A0)

	;clear int table
		lea	(IntVects,a0),a1
		moveq	#16*IV_SIZE/4-1,d0
.c1		MOVE.L	#$DDDDDDDD,(a1)+
		dbf	d0,.c1
	;init int table
		LEA.L	(IVPORTS,A0),A1
		MOVE.L	A1,(IV_DATA,a1)
		MOVE.L	#INT_SERVER,(IV_CODE,A1)
		move.l	#INTSERVNODE_CIAA,(IV_NODE,a1)

		LEA.L	(IVCOPER,A0),A1
		MOVE.L	A1,(IV_DATA,a1)
		MOVE.L	#INT_SERVER,(IV_CODE,A1)
		CLR.L	(IV_NODE,a1)

		LEA.L	(IVVERTB,A0),A1
		MOVE.L	A1,(IV_DATA,a1)
		MOVE.L	#INT_SERVER,(IV_CODE,A1)
		CLR.L	(IV_NODE,a1)

		LEA.L	(IVEXTER,A0),A1
		MOVE.L	A1,(IV_DATA,a1)
		MOVE.L	#INT_SERVER,(IV_CODE,A1)
		move.l	#INTSERVNODE_CIAB,(IV_NODE,a1)

		LEA.L	(IVAUD0,A0),A1
		MOVE.L	A1,(IV_DATA,a1)
		MOVE.L	#INT_SERVER,(IV_CODE,A1)
		move.l	#INTSERVNODE_AUDIO0,(IV_NODE,a1)

		LEA.L	(IVAUD1,A0),A1
		MOVE.L	A1,(IV_DATA,a1)
		MOVE.L	#INT_SERVER,(IV_CODE,A1)
		move.l	#INTSERVNODE_AUDIO1,(IV_NODE,a1)

		LEA.L	(IVAUD2,A0),A1
		MOVE.L	A1,(IV_DATA,a1)
		MOVE.L	#INT_SERVER,(IV_CODE,A1)
		move.l	#INTSERVNODE_AUDIO2,(IV_NODE,a1)

		LEA.L	(IVAUD3,A0),A1
		MOVE.L	A1,(IV_DATA,a1)
		MOVE.L	#INT_SERVER,(IV_CODE,A1)
		move.l	#INTSERVNODE_AUDIO3,(IV_NODE,a1)

	;init hardware ints
		move.l	#INT_68,$68
		move.l	#INT_6c,$6c
		MOVE.L	#INT_70,$70
		move.l	#INT_78,$78

		move.b	#$1f,$bfed01
		MOVE.B	#$8F,$BFED01
		tst.B	$BFED01
		move.b	#$1f,$bfdd00
;		MOVE.B	#$87,$BFDD00	; OS not enable TOD int (Mr.Larmer)
		MOVE.B	#$83,$BFDD00
		tst.b	$bfdd00
		
		move.w	#$7fff,(_custom+intena)

		rts

	IFNE	CORRECTDEVICES
MAKEDEVICELIST
		MOVE.L	4.W,A0
		move.l	#$24,d0
;		move.l	#LIB_SIZE,d1
		move.l	#LIB_SIZE+$a,d1
		lea	_tdname(PC),a0
		bsr	_InitDevice
		MOVE.L	d0,_tddevtable+4
		MOVE.L	D0,A0
		CLR.L	$28(A0)			;DUE LORDS OF WAR
		MOVE.L	#_TDDMSGPORT,$24(A0)	;-"-
		move.l	#$24,d0
		move.l	#LIB_SIZE,d1
		lea	_inpname(PC),a0
		bsr	_InitDevice
		MOVE.L	d0,_inpdevtable+4
		move.l	#$24,d0
		move.l	#LIB_SIZE,d1
		lea	_audname(PC),a0
		bsr	_InitDevice
		MOVE.L	d0,_auddevtable+4

		MOVE.L	D0,A0
		patch	-$1E(A0),_SENDAUDIO(PC)

		move.l	#$24,d0		; cd.device, added by JOTD
		move.l	#LIB_SIZE,d1
		lea	_cdname(PC),a0
		bsr	_InitDevice
		MOVE.L	d0,_cddevtable+4

		move.l	#$24,d0		; cdtv.device, added by JOTD
		move.l	#LIB_SIZE,d1
		lea	_cdtvname(PC),a0
		bsr	_InitDevice
		MOVE.L	d0,_cdtvdevtable+4

		move.l	#$24,d0		; dummy console.device
		move.l	#LIB_SIZE,d1
		lea	_condevname(PC),a0
		bsr	_InitDevice
		MOVE.L	d0,_condevtable+4

		move.l	#$24,d0
;		move.l	#LIB_SIZE,d1
		move.l	#$14C,d1
		lea	_kbdevname(PC),a0
		bsr	_InitDevice
		MOVE.L	d0,_kbdevtable+4

		move.l	d0,INTSERVNODE_SP+IS_DATA

		move.l	d0,a0
		lea	$70(a0),a0
		move.l	#$14C-$70-1,d0
.clear
		clr.b	(a0)+
		dbf	d0,.clear

		RTS

	ENDC

MYRTZ		MOVEQ.L	#0,D0
MYRTS		RTS

**************************************************************************
*   MISC EXEC FUCTIONS                                                   *
**************************************************************************

_CacheClearU
		movem.l	A0,-(A7)
		move.l	(_RESLOAD),a0
		jsr	(resload_FlushCache,a0)
		movem.l	(A7)+,A0
		rts

_FindResident:
	moveq.l	#0,D0
	rts

_SetFunction				; added by JOTD (Banshee)
		movem.l	D1,-(A7)
		move.l	2(A1,A0.W),D1
		move.l	D0,2(A1,A0.W)	; changed
		move.l	D1,D0		; old function
		movem.l	(A7)+,D1
		rts

_Supervisor	move.l	$bc,.s1
		move.l	#.c1,$bc
		trap	#15
		rts
.c1		move.l	.s1,$bc
		jmp	(a5)
.s1		dc.l	0

_SuperState	MOVE.L    A5,A0
		LEA       .ac,A5
		JMP       _LVOSupervisor(A6)
.ac		MOVE.L    A0,A5
		MOVEQ     #$00,D0
		BSET      #$05,(A7)
		BNE.S     .ca
		MOVE.W    (A7)+,SR
		MOVE.L    A7,D0
		MOVE.L    USP,A7
		BTST      #$00,$0129(A6)
		BEQ.S     .c6
		ADDQ.L    #$2,D0
.c6		ADDQ.L    #$4,D0
		RTS
.ca		RTE

_UserState	MOVE.L    (A7)+,A0
		MOVE.L    A7,USP
		MOVE.L    D0,A7
		ANDI.W    #$dfff,SR
		JMP       (A0)


_CreateIORequest
	movem.l	D2/D3,-(SP)
	move.l	D0,D2
	move.l	A0,D3
	beq.s	.error
	move.l	#$10001,D1
	jsr	_LVOAllocMem(A6)
	movea.l	D0,A0
	tst.l	D0
	beq.s	.error
	move.b	#NT_REPLYMSG,LN_TYPE(A0)
	move.l	D3,MN_REPLYPORT(A0)
	move.w	D2,MN_LENGTH(A0)
.error
	move.l	A0,D0
	movem.l	(SP)+,D2/D3
	rts

_DeleteIORequest
	move.l	A0,D0
	beq.s	.abort
	moveq	#-1,D0
	move.l	D0,LN_SUCC(A0)
	move.l	D0,IO_DEVICE(A0)
	moveq	#0,D0
	move.w	MN_LENGTH(A0),D0
	movea.l	A0,A1
	jsr	_LVOFreeMem(A6)
.abort
	rts

_CreateMsgPort
	moveq	#MP_SIZE,D0	;$22,D0
	move.l	#$10001,D1
	jsr	_LVOAllocMem(A6)
	move.l	D0,-(SP)
	beq.s	.error
	moveq	#-1,D0
	jsr	_LVOAllocSignal(A6)
	movea.l	(SP),A0
	move.b	#NT_MSGPORT,LN_TYPE(A0)
	move.b	#PA_SIGNAL,MP_FLAGS(A0)
	move.b	D0,MP_SIGBIT(A0)
	bmi.s	.abort
	move.l	ThisTask(A6),MP_SIGTASK(A0)
	lea	MP_MSGLIST(A0),A1
	move.l	A1,8(A1)
	addq.l	#4,A1
	clr.l	(A1)
	move.l	A1,-(A1)
.error
	move.l	(SP)+,D0
	rts

.abort
	moveq	#MP_SIZE,D0
	movea.l	A0,A1
	jsr	_LVOFreeMem(A6)
	clr.l	(SP)
	bra.s	.error

_DeleteMsgPort
	move.l	A0,-(SP)
	beq.s	.abort
	moveq	#0,D0
	move.b	MP_SIGBIT(A0),D0
	jsr	_LVOFreeSignal(A6)
	movea.l	(SP),A1
	moveq	#-1,D0
	move.l	D0,MP_MSGLIST(A1)
	move.l	D0,LN_SUCC(A1)
	moveq	#MP_SIZE,D0
	jsr	_LVOFreeMem(A6)
.abort
	addq.l	#4,SP
	rts


**************************************************************************
*   Task related functions                                               *
**************************************************************************

_AllocSignal
	movea.l	ThisTask(A6),A1
	move.l	TC_SIGALLOC(A1),D1
	cmp.b	#-1,D0
	beq.s	.search
	bset	D0,D1
	beq.s	.free
	bra.s	.err

.search
	moveq.l	#$20-1,D0
.search2
	bset	D0,D1
	beq.s	.free
	dbra	D0,.search2
.err
	moveq.l	#-1,D0
	rts

.free
	move.l	D1,TC_SIGALLOC(A1)
	moveq	#-1,D1
	bclr	D0,D1
	and.l	D1,TC_SIGRECVD(A1)
	and.l	D1,TC_SIGEXCEPT(A1)
	and.l	D1,TC_SIGWAIT(A1)
	rts

_FreeSignal
		cmp.b	#$FF,D0
		beq.s	.skip			; Mr Larmer: no more error
		movea.l	ThisTask(A6),A1
		move.l	TC_SIGALLOC(A1),D1
		bclr	D0,D1
		move.l	D1,TC_SIGALLOC(A1)
.skip
		rts


_SetSignal	MOVE.L	ThisTask(A6),A0
		MOVE.L	TC_SIGRECVD(A0),-(A7)
		AND.L	D1,D0
		NOT.L	D1
		AND.L	TC_SIGRECVD(A0),D1
		OR.L	D0,D1
		MOVE.L	D1,TC_SIGRECVD(A0)
		MOVE.L	(A7)+,d0
		rts

_Disable
		move.w	#INTF_INTEN,(_custom+intena)
		rts
_Enable
		move.w	#INTF_SETCLR!INTF_INTEN,(_custom+intena)
		rts

_FINDTASK	MOVE.L	A1,-(A7)	;fails if not own task searched
		TST.L	(A7)+
		BNE.S	.FAIL
		MOVE.L	4.W,A0
		MOVE.L	ThisTask(A0),D0
		RTS

.FAIL
;		MOVEQ.L	#0,d0
;		rts
		pea	_LVOFindTask
		pea	_execname
		bra	_emufail

**************************************************************************
*   MEMORYFUNCTIONS                                                      *
**************************************************************************

; AllocEntry(): Added by JOTD by request of Bored Seal
; Tested on DragonNinja

; < A0: memList
; > D0: allocated memList

ALLOCENTRY:
	movem.l	D1-A6,-(A7)
	move.l	A0,A5
	moveq.l	#0,D0
	move.w	LN_SIZE(A5),D0
	lsl.l	#3,D0
	add.l	#$10,D0
	move.l	D0,D5		; size
	move.l	#MEMF_PUBLIC,D1
	jsr	(_LVOAllocMem,a6)
	move.l	D0,D6
	beq.b	.fail

	; allocated OK

	move.l	D6,A4

	moveq.l	#0,D0
	move.l	A5,A0
	move.l	A4,A1
	move.l	D5,D0
	jsr	(_LVOCopyMem,a6)

	moveq.l	#0,D2
	move.w	LN_SIZE(A4),D2	; # of items
	
	add.l	#LN_SIZE+2,A4
.loop
	move.l	(A4)+,D1	; flags
	move.l	(A4)+,D0	; size
	jsr	(_LVOAllocMem,a6)
	beq.b	.fail		; alloc problem
	move.l	D0,-8(A4)	; store memblock start in flags (union)
	subq.l	#1,D2
	bne.b	.loop

	move.l	D6,D0		; new memlist
.exit
	movem.l	(A7)+,D1-A6
	rts

.fail:
	moveq.l	#0,D0
	bset	#31,D0
	bra.b	.exit

; FreeEntry(): still untested but should work

FREEENTRY:

	movem.l	D1-A6,-(A7)
	move.l	A0,A4

	move.w	LN_SIZE(A4),D2	; # of items
	
	add.l	#LN_SIZE+2,A4
.loop
	move.l	(A4)+,A1	; memory pointer
	move.l	(A4)+,D0	; memory size
	jsr	(_LVOFreeMem,a6)
	subq.l	#1,D2
	bne.b	.loop

.exit
	movem.l	(A7)+,D1-A6
	rts

_COPYMEM
	CMP.L	A0,A1
	BLS.S	.ASCEND
.DESCEND
	LEA.L	(A0,D0.L),A0
	LEA.L	(A1,D0.L),A1
.LD	MOVE.B	-(A0),-(A1)
	SUBQ.L	#1,D0
	BNE.S	.LD
	RTS

.ASCEND
.LA	MOVE.B	(A0)+,(A1)+
	SUBQ.L	#1,D0
	BNE.S	.LA
	RTS

FREEM
	TST.L	D0
	BNE.S	.NOZERO
	RTS

.NOZERO
	cmp.l	#$1000000,D0	; JOTD: safety, I had to switch off my amy
	bcc.b	.FREEMFAIL	; when the value passed was too high (here >16MB)!	

	CMP.L	#ALLOCMTAB,A1		; above ALLOCMTAB
	BHS.S	.OK			; okay, try to free
.FREEMFAIL
	pea	_LVOFreeMem
	pea	_execname
	bra	_emufail

.OK
	tst.l	OSM_EXPMEM
	beq.b	.FreeChip

	cmp.l	OSM_EXPMEM,A1
	bcs.b	.FreeChip	; below expansion memory -> chipmem

	; fast memory - added by JOTD

.FreeFast:
	move.l	OSM_EXPMEM,A0		; start of memory expansion
	add.l	OSM_EXPSIZE,A0		; size of memory expansion

	cmp.l	A0,A1
	bcc.b	.FREEMFAIL		; trying to free above memory expansion

	move.l	OSM_EXPMEM,A0		; start of memory table (fastmem)
	sub.l	A0,A1			; corrects offset on address !!
	bra.b	.FreeGeneric		; removed by Harry

	; chip memory - Harry's original

.FreeChip:
	LEA.L	ALLOCMTAB,A0		; start of memory table (chipmem)

.FreeGeneric:
	MOVEM.L	D2/D3/A2/A3,-(A7)
	MOVE.L	A1,D1
	ADDQ.L	#7,D0
	AND.L	#$FFFFFFF8,D1
	AND.L	#$FFFFFFF8,D0
	BEQ.S	.QU
	LSR.L	#3,D0			;# OF BITS TO CLEAR IN D0

					;FREE MEM NOT ON A $40-BOUNDARY
					;EVAL BEGINBYTE
	MOVE.L	D1,D2
	LSR.L	#6,D2
	LEA.L	(A0,D2.L),A0
	MOVEM.L	D1,-(A7)
	AND.L	#$3F,D1
	BEQ.S	.CNTCLR
	LSR.L	#3,D1
.2	BSET	D1,(A0)
	ADDQ.L	#1,D1
	ADDQ.L	#8,(A7)
	SUBQ.L	#1,D0
	BEQ.S	.1
	CMP.L	#8,D1
	BEQ.S	.CNTCLR2
	BRA.S	.2

.1	MOVEM.L	(A7)+,D1
	BRA.S	.QU

.CNTCLR2
	ADDQ.L	#1,A0
.CNTCLR
	MOVEM.L	(A7)+,D1

					;CLEAR $40-BOUNDARY-BYTES
.3	CMP.L	#8,D0
	BLO.S	.CLREND

	ST	(A0)+
	SUBQ.L	#8,D0
	BRA.S	.3


.CLREND					;CLEAR END NOT ENDING ON A $40-
	TST.L	D0			;BOUNDARY
	BEQ.S	.QU
	SUBQ.L	#1,D0
	BSET	D0,(A0)
	BRA.S	.CLREND

.QU	MOVEM.L	(A7)+,D2/D3/A2/A3
	RTS



;>D0:SIZE
;>D1:CONDITIONS
;<D0:ADDY
;LIMITATIONS:
;		-MEM ALWAYS CLEARED (MEMF_CLEAR ASSUMED)
;		-MEMORY IS $40-ALIGNED (SOME BYTES WASTED)
;		-MEMF_LARGEST IS IGNORED AS IN THE OS
;		-ATM, ALSO MEMF_REVERSE IS IGNORED

ALLOCM:
	tst.l	d0
	beq	.NOFAST	; not fatal anymore, allows broken programs to work

	MOVE.L	D1,-(A7)
	and.l	#~(MEMF_REVERSE!MEMF_LARGEST!MEMF_FAST!MEMF_CHIP!MEMF_CLEAR!MEMF_PUBLIC),(A7)+
	bne	.fail		; wrong flags
	btst	#MEMB_CHIP,d1	; chipmem required?
	BEQ.S	.FMEM		; JOTD: MEMB_CHIP not specified -> alloc fast
	
.NORMALCHIP
	MOVEM.L	D2-D5/A2/A3/A4,-(A7)

	addq.l	#7,d0
	LSR.L	#3,D0
	;SEARCH SUFFICIENT BIG MEMAREA

	LEA.L	ALLOCMTAB,A0	;FIND A BYTE != 0 (FREE MEM)
	move.l	ALLOCMTABSIZE,A3
	sub.l	A4,A4

	bsr	AllocGeneric

	MOVEM.L	(A7)+,D2-D5/A2/A3/A4
	RTS

.FMEM:
	tst.l	OSM_EXPMEM
	bne.b	.ALLOCFAST		; expansion available: allocate

	; no expansion: check if fast is required

	btst	#MEMB_FAST,d1
	bne.b	.NOFAST			; fastmem not available: error

	bra.b	.NORMALCHIP		; no fast memory configured: try chipmem

.ALLOCFAST
	MOVEM.L	D2-D5/A2/A3/A4,-(A7)
	addq.l	#7,d0
	LSR.L	#3,D0
	;SEARCH SUFFICIENT BIG MEMAREA

	move.l	OSM_EXPMEM,A0	;FIND A BYTE != 0 (FREE MEM)
	move.l	ALLOCFASTMTABSIZE,A3
	move.l	A0,A4		; offset to add for ALLOCA

	bsr	AllocGeneric

	MOVEM.L	(A7)+,D2-D5/A2/A3/A4
	RTS

.NOFAST
	moveq.l	#0,D0
	rts

.fail	
	EXECFAIL _LVOAllocMem

; Added by JOTD to be used with chip and fast alloc
; < A0: alloc table
; < A3: end of alloc table
; < A4: offset to add to calculated address (0 for chip, OSM_EXPMEM for fast)

AllocGeneric:
	MOVEQ.L	#0,D4
.2
	CMP.B	#$FF,(A0)+
	BEQ.S	.1
	ADD.L	#$40,D4
	CMP.L	A3,A0
	BNE.S	.2
	BRA.S	.ERR
					;found free mem
					;CHECK NOW SIZE 
.1	SUBQ.L	#1,A0
					;D4-BASE
.3
	MOVE.L	D0,-(A7)		;WANTED SIZE
	MOVE.L	D4,-(A7)		;FOUND ADDRESS

.6	TST.L	D0
	BMI.S	.CHKEND
	CMP.B	#$FF,(A0)
	BNE.S	.TOOSMALL
	ADDQ.L	#1,A0		;CHECK FOR EXCEEDING THE SIZE OF ALLOCMTAB
				;MAY BE OMITTED SINCE ITS END CONTAINS $0
	ADD.L	#$40,D4
	SUBQ.L	#8,D0
	BEQ.S	.CHKEND
	BRA.S	.6

.TOOSMALL				;LATER TODO: FIND EVENTUAL ZEROBITS

	ADDQ.L	#4,A7			;DISCARD D4 ON STACK
	MOVE.L	(A7)+,D0
	ADDQ.L	#1,A0
;	AND.L	#$FFFFFFC0,D4
	ADD.L	#$40,D4
	BRA.S	.2

.CHKEND
	MOVE.L	(A7)+,D4
	MOVE.L	(A7)+,D0
	LSL.L	#3,D0
;D0-SIZE
;D4-ABS
	;MARK AREA AS USED
	MOVE.L	D4,A1
	MOVE.L	D0,D2

	add.l	A4,A1			; added by JOTD, offset for fastmem
	BSR.W	ALLOCA
					;MEMORYSPACE ALREADY SUCESSFULLY
					;CHECKED, RETURNCODE MAY BE IGNORED

	MOVE.L	A1,A2
;	MOVE.L	D4,D2
	LSR.L	#2,D2
	BRA.S	.CLRM

.CLRM1	CLR.L	(A2)+
.CLRM	DBF	D2,.CLRM1
.exit
	tst.l	d0			;some progs expect an correct set zero flag
	rts
.ERR:
	moveq.l	#0,D0			; unable to allocate: table full
	rts

;RETURNS AT THE MOMENT ONLY THE SIZE OF THE LARGEST CHUNK-$1000 SAFETY
AVAILM
	MOVEM.L	A2/A3/D2/D3,-(A7)
	MOVE.L	D1,D2
	AND.L	#MEMF_FAST,D2
	BNE.S	.FMEM

	; check for chipmem available

	LEA.L	ALLOCMTAB,A0
	move.l	ALLOCMTABSIZE(pc),A3

	bsr	GenericAvail


.exit
	MOVEM.L	(A7)+,A2/A3/D2/D3
	RTS

.FMEM	
	move.l	OSM_EXPMEM,A0
	cmp.l	#0,A0
	beq.b	.nomem
	move.l	ALLOCFASTMTABSIZE(pc),A3

	bsr	GenericAvail
	bra.b	.exit

.nomem:
	moveq.l	#0,D0
	bra.b	.exit
	
; for chip & fast memory

GenericAvail:
	MOVEQ.L	#0,D2
	MOVEQ.L	#0,D3
.3	MOVE.B	(A0)+,D0
	CMP.B	#$FF,D0			;SEARCH CHUNK
	BNE.S	.1
	ADD.L	#$40,D3
	BRA.S	.2

.1	CMP.L	D2,D3			;END OF CHUNK, COMPARE SIZE WITH
	BLO.S	.4			;PREVIOUS SIZE
	MOVE.L	D3,D2			;ACTUAL IS LARGER -> NEW LARGEST SIZE
.4	MOVEQ.L	#0,D3			;RESET SIZE OF NEXT CHUNK
.2	CMP.L	A3,A0			;UNTIL MEMORYTABLE EXCEEDED
	BLO.S	.3
	cmp.l	d2,d3
	blo	.5
	move.l	d3,d2
.5
	CMP.L	#$2000,D2
	BLO.S	.6
	SUB.L	#$1000,D2
.6	MOVE.L	D2,D0
	rts

ALLOCA:
	tst.l	OSM_EXPMEM
	beq.b	.ALLOCA_CHIP	; no expansion: alloc chipmem
	cmp.l	OSM_EXPMEM,A1
	bcc.b	.ALLOCA_FAST	; above expansion: fast memory
.ALLOCA_CHIP:
	movem.l	A4,-(A7)
	LEA.L	ALLOCMTAB,A4	; chipmem alloc table
	bsr	GenericAllocAbs
	movem.l	(A7)+,A4
	move.l	D0,A1
	rts

.ALLOCA_FAST:
	movem.l	A4,-(A7)
	move.l	OSM_EXPMEM,A4		; fastmem alloc table
	sub.l	A4,A1			; substracts expbase from the address
	bsr	GenericAllocAbs		; the routine returns only offset
	add.l	A4,D0			; relative to memory block so we have to add expbase
	move.l	D0,A1			; A1=D0 for Harry!
	movem.l	(A7)+,A4
	rts

; < A4: allocmtab (added by JOTD to be used by fastmem and chipmem)


GenericAllocAbs
	MOVEM.L	D2/D3/A2/A3,-(A7)
	MOVE.L	A7,A3
	MOVE.L	_Slave(PC),A2
	MOVE.L	A1,D2
	ADD.L	D0,D2
	CMP.L	A2,D2
	BHS.W	.ERR

	move.l	A1,D1

;	ADDQ.L	#7,D1
	AND.L	#$FFFFFFF8,D1
	AND.L	#$FFFFFFF8,D0
	BEQ.W	.QU
	MOVEM.L	D0/D1,-(A7)

	LSR.L	#3,D0			;# OF BITS TO CLEAR IN D0

					;CHECK MEM NOT ON A $40-BOUNDARY
					;EVAL BEGINBYTE
	MOVE.L	D1,D2
	LSR.L	#6,D2
	move.L	A4,A0
	LEA.L	(A0,D2.L),A0
	MOVEM.L	D1,-(A7)
	AND.L	#$3F,D1
	BEQ.S	.CNTCHK
	LSR.L	#3,D1
.2	BTST	D1,(A0)
	BEQ.W	.ERR
	ADDQ.L	#1,D1
;	ADDQ.L	#8,(A7)
	SUBQ.L	#1,D0
	BEQ.S	.1
	CMP.L	#8,D1
	BEQ.S	.CNTCHK2
	BRA.S	.2

.1	MOVEM.L	(A7)+,D1
	BRA.S	.CONT

.CNTCHK2
	ADDQ.L	#1,A0
.CNTCHK
	MOVEM.L	(A7)+,D1

					;CLEAR $40-BOUNDARY-BYTES
.3	CMP.L	#8,D0
	BLO.S	.CLREND

	CMP.B	#$FF,(A0)+
	BNE.S	.ERR
	SUBQ.L	#8,D0
	BRA.S	.3


.CLREND
	TST.L	D0
	BEQ.S	.CONT
	SUBQ.L	#1,D0
	BTST	D0,(A0)
	BEQ.S	.ERR
	BRA.S	.CLREND

.CONT	MOVEM.L	(A7)+,D0/D1

					;ALLOC MEM

	LSR.L	#3,D0			;# OF BITS TO CLEAR IN D0

					;MARK MEM NOT ON A $40-BOUNDARY
					;EVAL BEGINBYTE
	MOVE.L	D1,D2
	LSR.L	#6,D2
	move.l	A4,A0
	LEA.L	(A0,D2.L),A0
	MOVEM.L	D1,-(A7)
	AND.L	#$3F,D1
	BEQ.S	.CNTMARK
	LSR.L	#3,D1
.22	BCLR	D1,(A0)
	ADDQ.L	#1,D1
;	ADDQ.L	#8,(A7)
	SUBQ.L	#1,D0
	BEQ.S	.21
	CMP.L	#8,D1
	BEQ.S	.CNTMARK2
	BRA.S	.22

.21	MOVEM.L	(A7)+,D1
	BRA.S	.QU

.CNTMARK2
	ADDQ.L	#1,A0
.CNTMARK
	MOVEM.L	(A7)+,D1

					;CLEAR $40-BOUNDARY-BYTES
.23	CMP.L	#8,D0
	BLO.S	.MARKEND

	SF	(A0)+
	SUBQ.L	#8,D0
	BRA.S	.23


.MARKEND
	TST.L	D0
	BEQ.S	.QU
	SUBQ.L	#1,D0
	BCLR	D0,(A0)
	BRA.S	.MARKEND

.QU

	MOVE.L	A3,A7
	MOVEM.L	(A7)+,D2/D3/A2/A3
	MOVE.L	D1,D0
	RTS
.ERR2
.ERR	MOVE.L	A3,A7
	MOVEM.L	(A7)+,D2/D3/A2/A3
	MOVEQ.L	#0,D0
	RTS


****************************************************************************
* LIST HANDLING IN EXEC                                                    *
****************************************************************************

	ifeq 1

_Enqueue	;a0=list a1=node
	MOVE.B    (LN_PRI,A1),D1
	MOVE.L    (LN_SUCC,A0),D0
.1908	MOVE.L    D0,A0
	MOVE.L    (LN_SUCC,A0),D0
	BEQ.S     .1914
	CMP.B     (LN_PRI,A0),D1
	BLE.S     .1908
.1914	MOVE.L    (LN_PRED,A0),D0
	MOVE.L    A1,(LN_PRED,A0)
	MOVE.L    A0,(LN_SUCC,A1)
	MOVE.L    D0,(LN_PRED,A1)
	MOVE.L    D0,A0
	MOVE.L    A1,(LN_SUCC,A0)
	RTS

	endc

_FINDNAME	;a0-list, a1-name, returns d0-node
	MOVEM.L	A2,-(A7)
	MOVE.L	A0,A2		;find listheader (lords of war *grr*)
.HSEARCH
	TST.L	4(A2)
	BEQ.S	.HFOUND
	MOVE.L	4(A2),A2
	BRA.S	.HSEARCH

.HFOUND
.LOOP	TST.L	(A2)
	BEQ.S	.NOTFOUND
	MOVE.L	(A2),A2
	MOVE.L	LN_NAME(A2),A0
	BSR.W	_strcmp
	TST.L	D0
	BEQ.S	.FOUND
	BRA.S	.LOOP

.FOUND	MOVE.L	A2,D0
	MOVEM.L	(A7)+,A2
	RTS

.NOTFOUND
	MOVEQ.L	#0,D0
	MOVEM.L	(A7)+,A2
	RTS


_INSERT		;a0-list a1-node to be inserted a2-node after which to insert
.HSEARCH
	TST.L	4(A0)
	BEQ.S	.HFOUND
	MOVE.L	4(A0),A0
	BRA.S	.HSEARCH

.HFOUND
	MOVE.L	A2,-(A7)
	TST.L	(A7)+
	BEQ.S	.ADDHEAD
	CMP.L	A0,A2
	BEQ.S	.ADDHEAD
	MOVE.L	LH_TAILPRED(A0),-(A7)
	CMPM.L	(A7)+,(A2)+	;IF INSERTING AT END -> .ADDTAIL
	LEA.L	-4(A2),A2
	BEQ.S	.ADDTAIL
	MOVE.L	(A2),A0		;SUCCESSOR
	MOVE.L	A1,(LN_PRED,A0)	;NEW PREDECESSOR
	MOVE.L	(A2),(A1)	;SUCCESSOR IN ELEMENT TO BE INSERTED
	MOVE.L	A2,(LN_PRED,A1)	;PREDECESSOR IN ELEMENT TO BE INSERTED
	MOVE.L	A1,(A2)		;INSERTED NODE IS SUCCESSOR
	RTS

.ADDTAIL
	MOVE.L	(A2),(A1)
	MOVE.L	A2,LN_PRED(A1)
	MOVE.L	A1,LH_TAILPRED(A0)
	MOVE.L	A1,(A2)
	RTS

.ADDHEAD
_ADDHEAD
	MOVE.L	A2,-(A7)
	MOVE.L	(A0),A2
	TST.L	(A2)
	BEQ.S	.EMPTYLIST

	MOVE.L	(A0),A2
	MOVE.L	A2,(A1)
	MOVE.L	LN_PRED(A2),LN_PRED(A1)
	MOVE.L	A1,LN_PRED(A2)
	MOVE.L	A1,(A0)
	BRA.S	.END

.EMPTYLIST
	MOVE.L	(A0),(A1)
	MOVE.L	LH_TAILPRED(A0),LN_PRED(A1)
	MOVE.L	A1,(A0)			;INSERT ELEMENT AS FIRST INTO *LIST
	MOVE.L	A1,LH_TAILPRED(A0)	;ELEMENT IS ALSO LAST ONE
.END	MOVE.L	(A7)+,A2
	RTS

_ADDTAIL
	MOVE.L	A2,-(A7)
	MOVE.L	(A0),A2
	TST.L	(A2)
	BEQ.S	.EMPTYLIST
	MOVE.L	LH_TAILPRED(A0),A2

	MOVE.L	(A2),(A1)
	MOVE.L	A2,LN_PRED(A1)
	MOVE.L	A1,LH_TAILPRED(A0)
	MOVE.L	A1,(A2)
	BRA.S	.END

.EMPTYLIST
	MOVE.L	(A0),(A1)
	MOVE.L	LH_TAILPRED(A0),LN_PRED(A1)
	MOVE.L	A1,(A0)			;INSERT ELEMENT AS FIRST INTO *LIST
	MOVE.L	A1,LH_TAILPRED(A0)
.END	MOVE.L	(A7)+,A2
	RTS

_REMOVE		;A1-NODE TO REMOVE
	MOVEM.L	A2,-(A7)
	MOVE.L	A1,A2
.HSEARCH
	TST.L	4(A2)
	BEQ.S	.HFOUND
	MOVE.L	4(A2),A2
	BRA.S	.HSEARCH

.HFOUND
	MOVE.L	(A1),A0
	TST.L	(A0)
	BEQ.S	.REMTAIL
	CMP.L	(A2),A1
	BEQ.S	.REMHEAD

	MOVE.L	LN_PRED(A1),A0
	MOVE.L	(A1),(A0)
	MOVE.L	(A1),A0
	MOVE.L	LN_PRED(A1),LN_PRED(A0)
.END	MOVEM.L	(A7)+,A2
	RTS

.REMHEAD
	MOVE.L	A2,A0
	BSR.S	_REMHEAD
	BRA.S	.END

.REMTAIL
	MOVE.L	A2,A0
	BSR.S	_REMTAIL
	BRA.S	.END

_REMHEAD
	MOVE.L	(A0),A1
	TST.L	(A1)
	BEQ.S	.EMPTYLIST
	MOVE.L	A2,-(A7)
	MOVE.L	(A0),A2
	MOVE.L	A2,D0
	MOVE.L	(A2),-(A7)
	TST.L	(A7)+
	BEQ.S	.SINGLEELEMENT
	MOVE.L	LN_PRED(A2),D1
	MOVE.L	(A2),A2
	MOVE.L	D1,LN_PRED(A2)
	MOVE.L	A2,(A0)
	MOVE.L	(A7)+,A2
	RTS

.SINGLEELEMENT
	MOVE.L	(A0),A2
	MOVE.L	(A2),(A0)
	MOVE.L	LN_PRED(A2),LH_TAILPRED(A0)
	MOVE.L	(A7)+,A2
	RTS

.EMPTYLIST
	MOVEQ.L	#0,D0
	RTS

_REMTAIL
	MOVE.L	(A0),A1
	TST.L	(A1)
	BEQ.S	.EMPTYLIST
	MOVE.L	A2,-(A7)
	MOVE.L	LH_TAILPRED(A0),A2
	MOVE.L	(A2),-(A7)
	TST.L	(A7)+
	BEQ.S	.SINGLEELEMENT
	MOVE.L	A2,D0
	MOVE.L	(A2),D1
	MOVE.L	LN_PRED(A2),A2
	MOVE.L	D1,(A2)
	MOVE.L	A2,LH_TAILPRED(A0)
	MOVE.L	(A7)+,A2
	RTS

.SINGLEELEMENT
	MOVE.L	A2,D0
	MOVE.L	(A2),(A0)
	MOVE.L	LN_PRED(A2),LH_TAILPRED(A0)
	MOVE.L	(A7)+,A2
	RTS

.EMPTYLIST
	MOVEQ.L	#0,D0
	RTS

****************************************************************************
* INTERRUPTPART IN EXEC                                                    *
****************************************************************************

INT_68		movem.l	d0-d1/a0-a1/a5-a6,-(a7)
		move.w	(_custom+intreqr),d0
		and.w	#INTF_PORTS,d0
		beq	.ports_end

	;call handler/server
.ports		PEA	.ports_cont(PC)
		move.l	(4).W,a1
		MOVE.L	(IVPORTS+IV_CODE,A1),-(A7)
		move.l	(IVPORTS+IV_DATA,a1),a1
		RTS
.ports_cont
.ports_end
		move.w	#INTF_PORTS,(_custom+intreq)
		movem.l	(a7)+,d0-d1/a0-a1/a5-a6
		rte

INTSERVNODE_CIAA
		dc.l	0		;LN_SUCC
		dc.l	0		;LN_PRED
		dc.b	NT_INTERRUPT	;LN_TYPE
		dc.b	120		;LN_PRI
		dc.l	_ciaaname	;LN_NAME
		dc.l	0		;IS_DATA
		dc.l	INT_CIAA	;IS_CODE

;---------------

INT_6c		movem.l	d0-d1/a0-a1/a5-a6,-(a7)
		move.w	(_custom+intreqr),d0
		and.w	#INTF_COPER!INTF_VERTB,d0
		AND.W	(_custom+intenar),d0
		beq	.vertb_end
		btst	#INTB_COPER,d0
		bne.s	.vertb_copper
 
.vertb
	;timer++

	add.l	#20,millisec_timer
	cmp.l	#1000,millisec_timer
	bcs	.skip

	addq.l	#1,sec_timer
	clr.l	millisec_timer
.skip
	;set copperlist (this should be the first !)
		move.l	_gfxbase(PC),a0
		move.l	(gb_LOFlist,a0),(_custom+cop2lc)
 ifeq 1
	;set sprites
		tst.b	(gb_SpriteReserved,a0)
		beq	.ns
		lea	(_sprites),a0
		lea	(_custom+sprpt),a1
		moveq	#7,d0
.ss		move.l	(a0)+,(a1)+
		dbf	d0,.ss
.ns
 endc
	;call handler/server
		PEA	.vertb_cont(PC)
		move.l	(4).W,a1
		MOVE.L	(IVVERTB+IV_CODE,A1),-(A7)
		move.l	(IVVERTB+IV_DATA,a1),a1
		RTS
.vertb_cont
	;input handler
		move.l	_inputhandler(PC),d0
		beq	.vertb_end
		moveq	#$6c,d0
		bsr	_InputHandlerVBI
.vertb_end
		move.w	#INTF_BLIT!INTF_VERTB,(_custom+intreq)

.vertb_vend
		movem.l	(a7)+,d0-d1/a0-a1/a5-a6
		rte
.vertb_copper
	;call copperhandler/server
		PEA	.vertb_cend(PC)
		move.l	(4).W,a1
		MOVE.L	(IVCOPER+IV_CODE,A1),-(A7)
		move.l	(IVCOPER+IV_DATA,a1),a1
		RTS

.vertb_cend
		move.w	#INTF_COPER,(_custom+intreq)
		bra.s	.vertb_vend

;---------------

INT_70		movem.l	d0-d1/D6/a0-a1/a5-a6,-(a7)
		move.w	(_custom+intreqr),d6
		AND.W	(_custom+intenar),d6
		and.w	#INTF_AUD0!INTF_AUD1!INTF_AUD2!INTF_AUD3,d6
		BTST	#7,D6
		BEQ.S	.AUD1

	;call handler/server
		move.l	#$80,d1
		PEA	.aud0_cont(PC)
		move.l	(4).W,a1
		MOVE.L	(IVAUD0+IV_CODE,A1),-(A7)
		move.l	(IVAUD0+IV_DATA,a1),a1
		RTS

.aud0_cont	move.w	#INTF_AUD0,(_custom+intreq)
		BCLR	#7,D6

.AUD1		BTST	#8,D6
		BEQ.S	.AUD2

	;call handler/server
		move.l	#$100,d1
		PEA	.aud1_cont(PC)
		move.l	(4).W,a1
		MOVE.L	(IVAUD1+IV_CODE,A1),-(A7)
		move.l	(IVAUD1+IV_DATA,a1),a1
		RTS

.aud1_cont	MOVE.W	#INTF_AUD1,(_custom+intreq)
		BCLR	#8,D6

.AUD2		BTST	#9,D6
		BEQ.S	.AUD3

	;call handler/server
		move.l	#$200,d1
		PEA	.aud2_cont(PC)
		move.l	(4).W,a1
		MOVE.L	(IVAUD2+IV_CODE,A1),-(A7)
		move.l	(IVAUD2+IV_DATA,a1),a1
		RTS

.aud2_cont	MOVE.W	#INTF_AUD2,(_custom+intreq)
		BCLR	#9,D6

.AUD3		BTST	#$A,D6
		BEQ.S	.aud_end

	;call handler/server
		move.l	#$400,d1
		PEA	.aud3_cont(PC)
		move.l	(4).W,a1
		MOVE.L	(IVAUD3+IV_CODE,A1),-(A7)
		move.l	(IVAUD3+IV_DATA,a1),a1
		RTS

.aud3_cont	MOVE.W	#INTF_AUD3,(_custom+intreq)
		BCLR	#$A,D6

.aud_end	movem.l	(a7)+,d0-d1/D6/a0-a1/a5-a6
		rte

INTSERVNODE_AUDIO0
		dc.l	0		;LN_SUCC
		dc.l	0		;LN_PRED
		dc.b	NT_INTERRUPT	;LN_TYPE
		dc.b	120		;LN_PRI
		dc.l	0		;LN_NAME
		dc.l	0		;IS_DATA
		dc.l	_AUD0_CODE	;IS_CODE

INTSERVNODE_AUDIO1
		dc.l	0		;LN_SUCC
		dc.l	0		;LN_PRED
		dc.b	NT_INTERRUPT	;LN_TYPE
		dc.b	120		;LN_PRI
		dc.l	0		;LN_NAME
		dc.l	0		;IS_DATA
		dc.l	_AUD1_CODE	;IS_CODE

INTSERVNODE_AUDIO2
		dc.l	0		;LN_SUCC
		dc.l	0		;LN_PRED
		dc.b	NT_INTERRUPT	;LN_TYPE
		dc.b	120		;LN_PRI
		dc.l	0		;LN_NAME
		dc.l	0		;IS_DATA
		dc.l	_AUD2_CODE	;IS_CODE

INTSERVNODE_AUDIO3
		dc.l	0		;LN_SUCC
		dc.l	0		;LN_PRED
		dc.b	NT_INTERRUPT	;LN_TYPE
		dc.b	120		;LN_PRI
		dc.l	0		;LN_NAME
		dc.l	0		;IS_DATA
		dc.l	_AUD3_CODE	;IS_CODE

_AUD0_CODE
_AUD1_CODE
_AUD2_CODE
_AUD3_CODE
		RTS


;---------------

INT_78		movem.l	d0-d1/a0-a1/a5-a6,-(a7)
		move.w	(_custom+intreqr),d0
		and.w	#INTF_EXTER,d0
		beq	.exter_end

	;call handler/server
.exter		PEA	.exter_cont(PC)
		move.l	(4).W,a1
		MOVE.L	(IVEXTER+IV_CODE,A1),-(A7)
		move.l	(IVEXTER+IV_DATA,a1),a1
		RTS
.exter_cont
.exter_end
		move.w	#INTF_EXTER,(_custom+intreq)
		movem.l	(a7)+,d0-d1/a0-a1/a5-a6
		rte

INTSERVNODE_CIAB
		dc.l	0		;LN_SUCC
		dc.l	0		;LN_PRED
		dc.b	NT_INTERRUPT	;LN_TYPE
		dc.b	120		;LN_PRI
		dc.l	_ciabname	;LN_NAME
		dc.l	0		;IS_DATA
		dc.l	INT_CIAB	;IS_CODE

;---------------

INT_SERVER
		move.l	(IV_NODE,a1),-(a7)
.loop		move.l	(a7),d0
		beq	.end
		move.l	d0,a0
		move.l	(LN_SUCC,a0),(a7)
		move.l	(IS_DATA,a0),a1
		TST.L	(IS_CODE,A0)
		BEQ.S	.loop
		move.l	(IS_CODE,a0),a6
		pea	(.loop)
		lea	(_custom),a0	;some require this
		jmp	(a6)
.end		addq.l	#4,a7
		rts

;---------------

_SETINTVECTOR	;D0-INT#, A1-INTERRUPTNODE, RET D0-OLD INTERRUPTNODE
		CMP.L	#$7,D0
		BLO.S	.NOTSUPPORTED
		CMP.L	#$B,D0
		BHS.S	.NOTSUPPORTED
		MULU	#$C,D0
		MOVE.L	4.W,A0
		LEA.L	IntVects(A0,D0.L),A0
		MOVE.L	IV_NODE(A0),D0
		MOVE.L	A1,IV_NODE(A0)
		RTS

.NOTSUPPORTED	pea	_LVOSetIntVector
		pea	_execname
		bra	_emufail


_AddIntServer	;d0=intnumber a1=interrupt

		movem.l	a2-a4,-(a7)
		mulu	#IV_SIZE,D0
		lea	(IntVects+IV_NODE,a6,d0.l),a2	;a2 = list base
		move.w	#INTF_INTEN,(_custom+intena)

		move.b	(LN_PRI,a1),d1			;d1 = priority
		sub.l	a3,a3				;a3 = predecessor
		move.l	(a2),a4				;a4 = successor

.next		move.l	a4,d0
		beq	.hangin
		cmp.b	(LN_PRI,a4),d1
		bgt	.hangin
		move.l	a4,a3
		move.l	(LN_SUCC,a3),a4
		bra	.next

.hangin		move.l	a3,(LN_PRED,a1)
		bne	.hi1
		move.l	a2,a3				;LN_SUCC == 0 !...
.hi1		move.l	a1,(LN_SUCC,a3)
		move.l	a4,(LN_SUCC,a1)
		beq	.hi2
		move.l	a1,(LN_PRED,a4)
.hi2
.end		move.w	#INTF_SETCLR!INTF_INTEN,(_custom+intena)
		movem.l	(a7)+,a2-a4
		rts

 ifeq 1
	MOVE.L    D2,-(A7)
	MOVE.L    D0,D2
	MOVE.L    D0,D1
	MULU.W    #IV_SIZE,D0
	LEA       (IntVects,A6,D0.W),A0
	MOVE.L    (A0),A0
	MOVE.W    #INTF_INTEN,(_custom+intena)
	ADDQ.B    #1,(IDNestCnt,A6)
	BSR.W     _Enqueue
	MOVE.W    #-$8000,D0
	BSET      D2,D0
	MOVE.W    D0,(_custom+intena)
	SUBQ.B    #1,(IDNestCnt,A6)
	BGE.S     .1654
	MOVE.W    #INTF_SETCLR!INTF_INTEN,(_custom+intena)
.1654	MOVE.L    (A7)+,D2
	RTS
 endc

_RemIntServer	;d0=intnumber a1=interrupt

	;this is a workaround for Millenium2�2, which does not set D0 correctly
		cmp.l	#$20,d0
		blo	.ok
		moveq	#5,d0
.ok
		movem.l	a2-a4,-(a7)
		mulu	#IV_SIZE,D0
		lea	(IntVects+IV_NODE,a6,d0.l),a2	;a2 = list base
		move.w	#INTF_INTEN,(_custom+intena)

		sub.l	a3,a3				;a3 = predecessor
		move.l	a2,a0
		
.next		move.l	(LN_SUCC,a0),a0
		cmp.l	a0,a1
		beq	.hangout
		move.l	a0,a3
		bra	.next

.hangout	move.l	(LN_SUCC,a1),a4			;a4 = successor
		move.l	a4,d0
		beq	.ho1
		move.l	a3,(LN_PRED,a4)
.ho1		move.l	a3,d0
		bne	.ho2
		move.l	a2,a3				;LN_SUCC == 0 !...
.ho2		move.l	a4,(LN_SUCC,a3)

.end		move.w	#INTF_SETCLR!INTF_INTEN,(_custom+intena)
		movem.l	(a7)+,a2-a4
		rts

_ExitIntr	MOVEM.L	(A7)+,D0-D1/A0-A1/A5-A6
		RTE

**************************************************************************
*   LIBRARY FUNCTIONS                                                    *
**************************************************************************

OPENLIB:
		move.l	a2,-(a7)

		lea	_libtable,a2
.next		move.l	(a2)+,a0
		move.l	a0,d0
		beq	.err
		bsr	_strcmp
		beq	.found
		addq.l	#4,a2
		bra	.next

.found		move.l	(a2),a0
		jsr	(a0)		;init
		
		move.l	(a7)+,a2
		rts

.err
		pea	_LVOOpenLibrary
		pea	_execname
		bra	_emufail

**************************************************************************
*   DEVICE FUNCTIONS                                                     *
**************************************************************************

_OpenDevice	;a0=name d0=unit a1=ioreq d1=flags
		moveM.l	D0/A0-a2,-(a7)

		MOVE.L	A0,A1
		lea	_devtable,a2
.next		move.l	(a2)+,a0
		move.l	a0,d0
		beq	.err
		bsr	_strcmp
		beq	.found
		addq.l	#4,a2
		bra	.next

.err		pea	_LVOOpenDevice
		pea	_execname
		bra	_emufail

.found
	cmp.l	#"cd.d",(A0)		; but what with A0 if will odd address (68000)
		beq	.dontopen	; added by JOTD

		MOVE.L	8(A7),A1
	IFNE	CORRECTDEVICES
		MOVE.L	(A2),(IO_DEVICE,A1)
	ELSE
		move.l	(a0),(IO_DEVICE,a1)
	ENDC
		move.l	(A7),(IO_UNIT,a1)
		move.b	d1,(IO_FLAGS,A1)
		MOVEM.L	(A7)+,D0/A0-A2
		moveq	#0,d0
		move.b	d0,(IO_ERROR,a1)
		rts

.dontopen
		MOVEM.L	(A7)+,D0/A0-A2
		moveq.l	#-1,D0
		rts

_InputHandlerVBI
	;check LMB
		btst	#CIAB_GAMEPORT0,(_ciaa+ciapra)
		seq	d0
		cmp.b	(_last_lmb),d0
		beq	.lmbend
		move.b	d0,(_last_lmb)
		lea	_inputevent,a0
		clr.l	(ie_NextEvent,a0)
		move.b	#IECLASS_RAWMOUSE,(ie_Class,a0)
		clr.b	(ie_SubClass,a0)
		move.w	#IECODE_LBUTTON,(ie_Code,a0)
		tst.b	d0
		bne	.lmb1
		or.w	#IECODE_UP_PREFIX,(ie_Code,a0)
.lmb1		moveq	#0,d0
		move.b	(_last_lmb),d1
		beq	.lmb2
		or.w	#IEQUALIFIER_LEFTBUTTON,d0
.lmb2		move.b	(_last_rmb),d1
		beq	.lmb3
		or.w	#IEQUALIFIER_RBUTTON,d0
.lmb3		move.w	d0,(ie_Qualifier,a0)
		pea	.lmbend
		move.l	_inputhandler,a1
		move.l	(IS_CODE,a1),-(a7)
		move.l	(IS_DATA,a1),a1
		rts					;a0=InputEvent a1=HandlerData
.lmbend
	;check RMB
		btst	#POTGOB_DATLY-8,(_custom+potinp)
		seq	d0
		cmp.b	(_last_rmb),d0
		beq	.rmbend
		move.b	d0,(_last_rmb)
		lea	_inputevent,a0
		clr.l	(ie_NextEvent,a0)
		move.b	#IECLASS_RAWMOUSE,(ie_Class,a0)
		clr.b	(ie_SubClass,a0)
		move.w	#IECODE_RBUTTON,(ie_Code,a0)
		tst.b	d0
		bne	.rmb1
		or.w	#IECODE_UP_PREFIX,(ie_Code,a0)
.rmb1		moveq	#0,d0
		move.b	(_last_lmb),d1
		beq	.rmb2
		or.w	#IEQUALIFIER_LEFTBUTTON,d0
.rmb2		move.b	(_last_rmb),d1
		beq	.rmb3
		or.w	#IEQUALIFIER_RBUTTON,d0
.rmb3		move.w	d0,(ie_Qualifier,a0)
		pea	.rmbend
		move.l	_inputhandler,a1
		move.l	(IS_CODE,a1),-(a7)
		move.l	(IS_DATA,a1),a1
		rts					;a0=InputEvent a1=HandlerData
.rmbend
	;check MouseMove
		move.w	(_custom+joy0dat),d0
		move.w	(_last_joy0dat),d1
		cmp.w	d0,d1
		beq	.rts
		move.w	d0,(_last_joy0dat)
		lea	_inputevent,a0
		clr.l	(ie_NextEvent,a0)
		move.b	#IECLASS_RAWMOUSE,(ie_Class,a0)
		clr.b	(ie_SubClass,a0)
		move.w	#IECODE_NOBUTTON,(ie_Code,a0)
		clr.w	(ie_Qualifier,a0)
		movem.l	d2-d3,-(a7)
		moveq	#0,d2
		move.b	d1,d2
		moveq	#0,d3
		move.b	d0,d3
		sub.w	d2,d3
		cmp.w	#127,d3
		bgt	.xsub
		cmp.w	#-128,d3
		bge	.xok
		add.w	#512,d3
.xsub		sub.w	#256,d3
.xok		move.w	d3,(ie_X,a0)
		movem.l	(a7)+,d2-d3
		lsr.w	#8,d0
		lsr.w	#8,d1
		sub.w	d1,d0
		cmp.w	#127,d0
		bgt	.ysub
		cmp.w	#-128,d0
		bge	.yok
		add.w	#512,d0
.ysub		sub.w	#256,d0
.yok		move.w	d0,(ie_Y,a0)
		move.l	_inputhandler,a1
		move.l	(IS_CODE,a1),-(a7)
		move.l	(IS_DATA,a1),a1
.rts		rts					;a0=InputEvent a1=HandlerData

_InputHandlerPI	lea	_inputevent,a0
		clr.l	(ie_NextEvent,a0)
		move.b	#IECLASS_RAWKEY,(ie_Class,a0)
		clr.b	(ie_SubClass,a0)
		moveq	#0,d0
		move.b	(KBDVAL),d0
		move.w	d0,(ie_Code,a0)
		clr.w	(ie_Qualifier,a0)
		move.l	_inputhandler,a1
		move.l	(IS_CODE,a1),-(a7)
		move.l	(IS_DATA,a1),a1
		rts					;a0=InputEvent a1=HandlerData

_SendIO
_DoIO		;a1=ioreq
		tst.l	(IO_DEVICE,A1)
		beq	.cd				; not found: ignore! (JOTD)

		move.w	(IO_COMMAND,a1),d0		;d0=command
	IFNE	CORRECTDEVICES
		MOVE.L	_tddevtable+4(PC),D1
		CMP.L	(IO_DEVICE,A1),D1
	ELSE
		cmp.l	#"trac",(IO_DEVICE,a1)
	ENDC
		beq	.trackdisk
	IFNE	CORRECTDEVICES
		MOVE.L	_inpdevtable+4(PC),D1
		CMP.L	(IO_DEVICE,A1),D1
	ELSE
		cmp.l	#"inpu",(IO_DEVICE,a1)
	ENDC
		beq	.input

	; cd.device added by Jeff

	IFNE	CORRECTDEVICES
		MOVE.L	_cddevtable+4(PC),D1
		CMP.L	(IO_DEVICE,A1),D1
	ELSE
		cmp.l	#"cd.d",(IO_DEVICE,a1)
	ENDC
		beq	.cd

	; cdtv.device added by Jeff

	IFNE	CORRECTDEVICES
		MOVE.L	_cdtvdevtable+4(PC),D1
		CMP.L	(IO_DEVICE,A1),D1
	ELSE
		cmp.l	#"cdtv",(IO_DEVICE,a1)
	ENDC
		beq	.cd

	; keyboard.device added by Jeff

	IFNE	CORRECTDEVICES
		MOVE.L	_kbdevtable+4(PC),D1
		CMP.L	(IO_DEVICE,A1),D1
	ELSE
		cmp.l	#"keyb",(IO_DEVICE,a1)
	ENDC
		beq	.keyboard

.fail
	move.l	D0,D6

		pea	_LVODoIO
		pea	_execname
		bra	_emufail
		
.cd
		moveq.l	#0,D0	; cd.device,cdtv.device: do nothing
		rts

.keyboard
		cmp.w	#KBD_READMATRIX,d0
		beq	.kb_readmatrix
		cmp.w	#KBD_READEVENT,d0

		cmp.w	#CMD_CLEAR,d0

		BRA	.fail
.kb_readmatrix
		move.l	a1,-(SP)
		moveq	#15,d0
		move.l	(IO_LENGTH,a1),d1
		move.l	(IO_DATA,a1),a0
		cmp.l	d0,d1
		bls.s	.lower
		move.w	d0,d1
.lower
		move.l	d1,(IO_ACTUAL,a1)
		move.l	(IO_DEVICE,a1),a1
		lea	$136(a1),a1
		bra.s	.goto
.loop
		move.b	(a1)+,(a0)+
.goto
		dbra	d1,.loop
		movea.l	(SP)+,a1

		clr.b	(IO_ERROR,a1)
		moveq.l	#0,d0
		rts

.input		cmp.w	#CMD_RESET,d0
		beq	.ret
		cmp.w	#IND_ADDHANDLER,d0
		beq	.i_addh
		cmp.w	#IND_REMHANDLER,d0
		beq	.i_remh
		cmp.w	#IND_SETMPORT,d0
		beq	.ret
		cmp.w	#IND_SETMTRIG,d0
		beq	.i_setmtrig
		BRA	.fail

.i_addh		move.w	(_custom+joy0dat),(_last_joy0dat)
		TST.L	_inputhandler
		BNE	.fail
		move.l	(IO_DATA,a1),_inputhandler
		moveq.l	#0,D0			; added by JOTD
		rts
.i_remh		clr.l	_inputhandler
		rts
.i_setmtrig	move.l	(IO_DATA,a1),.gpt
		moveq.l	#0,D0			; added by JOTD
		rts
.gpt		dc.l	0

.trackdisk	cmp.w	#CMD_READ,d0
		beq	.td_read
		cmp.w	#CMD_CLEAR,d0
		beq	.ret
		cmp.w	#TD_MOTOR,d0
		beq	.ret
		cmp.w	#TD_FORMAT,d0
		beq	.td_write
		cmp.w	#TD_REMOVE,d0
		beq	.ret
		cmp.w	#TD_CHANGENUM,d0
		beq	.ret
		cmp.w	#TD_CHANGESTATE,d0
		beq	.ret
		cmp.w	#ETD_SEEK,d0
		beq	.td_seek	; added by JOTD
		cmp.w	#TD_SEEK,d0
		beq	.td_seek	; added by JOTD
		cmp.w	#ETD_READ,d0
		beq	.td_read
		cmp.w	#ETD_WRITE,d0
		beq	.td_write
		cmp.w	#CMD_WRITE,d0
		beq	.td_write	; added by JOTD
		cmp.w	#ETD_UPDATE,d0
		beq	.ret
		cmp.w	#ETD_CLEAR,d0
		beq	.ret
		cmp.w	#ETD_MOTOR,d0
		beq	.ret
		cmp.w	#CMD_UPDATE,d0	; added by JOTD
		beq	.ret
		BRA.W	.fail

.td_seek:	; seek only moves the heads, nothing is read!
		beq	.ret

	;"deuteros" expects that a1 is unchanged !
.td_read	movem.l	d2/a1,-(a7)
		move.l	(IO_OFFSET,a1),d0
		move.l	(IO_LENGTH,a1),d1
		move.l	d1,(IO_ACTUAL,a1)	; Mr.Larmer
		move.l	(IO_UNIT,a1),d2
		addq.l	#1,d2
		move.l	(IO_DATA,a1),a0
		move.l	(_RESLOAD),a1
		jsr	(resload_DiskLoad,a1)
		movem.l	(a7)+,d2/a1
.ret		clr.b	(IO_ERROR,a1)
		moveq.l	#0,D0			; added by JOTD
		rts

.td_write	tst.l	_p3	; JOTD: what's this ???
		bne.b	.td_dowrite
		move.l	OSM_JSTFLAGS,D0
		btst	#AFB_NOOSSWAP,D0	; JST's NOOSSWAP set
		bne.b	.f			; don't write!
.td_dowrite
		movem.l	a1-a2,-(a7)
		clr.b	(IO_ERROR,a1)
		move.l	(IO_LENGTH,a1),d0	;size
		lea	(.disk),a0
		move.l	(IO_UNIT,a1),d1
		add.b	#"1",d1
		move.b	d1,(5,a0)		;name
		move.l	(IO_OFFSET,a1),d1	;offset
		move.l	(IO_DATA,a1),a1		;address
		move.l	(_RESLOAD),a2
		jsr	(resload_SaveFileOffset,a2)
		movem.l	(a7)+,a1-a2
		rts
.f		st	(IO_ERROR,a1)
		rts

.disk		dc.b	"Disk.",0,0,0

_SENDAUDIO
		CLR.B	IO_ERROR(A1)
		MOVEQ.L	#0,D0
		RTS

_WAITIO
	IFNE	CORRECTDEVICES
		MOVE.L	_cddevtable+4(PC),D1
		CMP.L	(IO_DEVICE,A1),D1
	ELSE
		cmp.l	#"cd.d",(IO_DEVICE,a1)
	ENDC
		beq	.cd

	IFNE	CORRECTDEVICES
		MOVE.L	_cdtvdevtable+4(PC),D1
		CMP.L	(IO_DEVICE,A1),D1
	ELSE
		cmp.l	#"cdtv",(IO_DEVICE,a1)
	ENDC
		beq	.cd

.fail		pea	_LVOWaitIO
		pea	_execname
		bra	_emufail
		
.cd
		CLR.B	IO_ERROR(A1)
		moveq.l	#0,D0	; cd.device,cdtv.device: do nothing
		RTS

_ABORTIO
		CLR.B	IO_ERROR(A1)
		MOVEQ.L	#0,D0
		RTS

_CHECKIO
		MOVE.L	A1,D0	; request has completed
		RTS

**************************************************************************
*   RESOURCE FUNCTIONS                                                   *
**************************************************************************

OPENRES		move.l	a2,-(a7)

		lea	_restable,a2
.next		move.l	(a2)+,a0
		move.l	a0,d0
		beq	.err
		bsr	_strcmp
		beq	.found
		addq.l	#4,a2
		bra	.next

.found		move.l	(a2),a0
		jsr	(a0)		;init
		
		move.l	(a7)+,a2
		rts

.err		pea	_LVOOpenResource
		pea	_execname
		bra	_emufail

**************************************************************************
*   DISK.RESOURCE                                                        *
**************************************************************************

DISKINIT	move.l	_diskbase,d0
		beq	.init
		rts

.init
		move.l	#-_LVOReadUnitID,D0
		move.l	#5*4,d1
		lea	_diskname,a0
		bsr	_InitStruct
		move.l	d0,_diskbase
		move.l	d0,a0

		; patches

		patch	_LVOGetUnit(a0),GETUNIT(pc)

		; clears interrupt structure

		clr.l	(a0)+
		clr.l	(a0)+
		clr.l	(a0)+
		clr.l	(a0)+
		clr.l	(a0)


		rts

GETUNIT:
	moveq.l	#-1,d0		; not exactly the thing to do but...
	rts


**************************************************************************
*   CIAA.RESOURCE                                                        *
**************************************************************************

CIAAINIT	move.l	_ciaabase,d0
		beq	.init
		rts

.init		move.l	#-_LVOSetICR,d0
		move.l	#5*4,d1
		lea	_ciaaname(pc),a0
		bsr	_InitStruct
		move.l	d0,a0
		move.l	d0,_ciaabase

		patch	_LVOAddICRVector(a0),CIAAADDICRV(pc)
		patch	_LVORemICRVector(a0),CIAAREMICRV(pc)

		clr.l	(a0)+
		clr.l	(a0)+
		clr.l	(a0)+
		move.l	#INTSERVNODE_SP,(a0)+
		clr.l	(a0)

		MOVE.B	#$FF,$BFE701

		rts

INTSERVNODE_SP	dc.l	0		;LN_SUCC
		dc.l	0		;LN_PRED
		dc.b	NT_INTERRUPT	;LN_TYPE
		dc.b	0		;LN_PRI
		dc.l	0		;LN_NAME
		dc.l	0		;IS_DATA
		dc.l	INT_KBD		;IS_CODE

INT_KBD
		movem.l	D2-D4/A6,-(SP)
		movea.l	A1,A6
		moveq	#0,D2
		move.b	$BFEC01,D2

		MOVE.B	#$41,$BFEE01

;		ori.b	#$40,$BFEE01

		MOVEQ.L	#2,D3
.4		MOVE.L	D1,-(A7)
		MOVE.B	$DFF006,D1
.3		CMP.B	$DFF006,D1
		BEQ.S	.3
		MOVE.L	(A7)+,D1
		DBF	D3,.4

		moveq	#0,D4
		not.b	D2
		ror.b	#1,D2

		MOVE.B	D2,KBDVAL

		cmpi.b	#$78,D2
		bne.s	lbC000078

		illegal
	ifeq	1
		bset	#0,$134(A6)
		beq.s	lbC00007E
		bset	#1,$134(A6)
		bne.w	lbC00012E
		movea.l	$124(A6),A1
		tst.l	(A1)
		beq.w	lbC00012C
lbC00005E
		move.l	(A1),D3
		beq.w	lbC00012E
		addq.w	#1,$132(A6)
		move.l	A6,-(SP)
		movea.l	$24(A6),A6
		jsr	-$B4(A6)
		movea.l	(SP)+,A6
		movea.l	D3,A1
		bra.s	lbC00005E
	endc
lbC000078
		bclr	#0,$134(A6)
lbC00007E
		move.w	D2,D1
		andi.w	#$7F,D1
		cmpi.w	#$71,D1
		bhi.w	lbC0000EA
		move.w	D1,D0
		andi.w	#7,D0
		lsr.w	#3,D1
		lea	$136(A6),A0
		btst	#7,D2
		bne.s	lbC0000AE
		bset	D0,0(A0,D1.W)
		cmpi.w	#12,D1
		bne.s	lbC0000CE
		bset	D0,$135(A6)
		bra.s	lbC0000CE
lbC0000AE
		bclr	D0,0(A0,D1.W)
		cmpi.w	#12,D1
		bne.s	lbC0000CE
		bclr	D0,$135(A6)
		bra.s	lbC0000CE
lbW0000BE
		dc.w	$80,$E0,$E0,$F0,$804,$7C,0,0
lbC0000CE
		move.w	D2,D1
		andi.w	#$7F,D1
		move.w	D1,D0
		andi.w	#7,D0
		lsr.w	#3,D1
		lea	lbW0000BE(PC),A0
		btst	D0,0(A0,D1.W)
		beq.s	lbC0000EA
		ori.w	#$100,D4
lbC0000EA
		move.w	$72(A6),D1
		move.w	D1,D0
		addq.w	#4,D0
		andi.w	#$7F,D0
		cmp.w	$70(A6),D0
		bne.s	lbC000108
		move.w	D1,D0
		move.w	#$7D,D2
		subq.w	#4,D1
		andi.w	#$7F,D1
lbC000108
		move.w	D2,$74(A6,D1.W)
		or.b	$135(A6),D4
		move.w	D4,$76(A6,D1.W)
		move.w	D0,$72(A6)
;		btst	#0,$3D(A6)
;		bne.s	lbC00012C
;		movea.l	$48(A6),A1
;		tst.l	(A1)
;		beq.s	lbC00012C
;		bsr.l	*-$FFFF0278
;lbC00012C

		MOVE.B	#$1,$BFEE01

;		andi.b	#$BF,$BFEE01

lbC00012E
		MOVE.B	KBDVAL,d0
		TST.L	OSM_SLVTRAINER
		BEQ.S	.NOTRAINER
		MOVE.L	OSM_SLVTRAINER(PC),A0
		JSR	(A0)
.NOTRAINER
		MOVE.B	D0,KBDVAL
		BEQ.S	.1
		move.l	(_Slave),a0
		CMP.B	(ws_keyexit,a0),D0
		BEQ.S	.QUIT
.1
		movem.l	(SP)+,D2-D4/A6
		move.l	_inputhandler(PC),d0
		bne	_InputHandlerPI
		rts

.QUIT		PEA	TDREASON_OK
		MOVE.L	_RESLOAD(PC),-(A7)
		add.l	#resload_Abort,(a7)
		rts

CIAAADDICRV	move.l	#$80,d1
		bset	d0,d1
		move.b	d1,$bfed01
		bra.s	ADDICRV

CIABADDICRV
		move.l	#$80,d1
		bset	d0,d1
		move.b	d1,$bfdd00


ADDICRV		lsl.w	#2,d0
		move.l	(a6,d0.w),d1
		bne	.1
		move.l	a1,(a6,d0.w)
.1		move.l	d1,d0
		rts
CIAAREMICRV	moveq.l	#0,d1
		bset	d0,d1
		move.b	d1,$bfed01
		bra.s	REMICRV

CIABREMICRV	moveq.l	#0,d1
		bset	d0,d1
		move.b	d1,$bfdd00

REMICRV		lsl.w	#2,d0
		cmp.l	(a6,d0.w),a1
		bne	.1
		clr.l	(a6,d0.w)
.1		rts



INT_CIAA	move.l	_ciaabase,a6
		MOVE.B	$BFED01,D0
INT_CIA
.chk		Bclr	#0,D0
		BNE.S	.ta
		Bclr	#1,D0
		BNE.S	.tb
		Bclr	#2,D0
		BNE.S	.alarm
		Bclr	#3,D0
		BNE.S	.sp
		Bclr	#4,D0
		BNE.S	.flag
		RTS

.ta		MOVE.L	(A6),A0
		BRA.S	.IN
.tb		MOVE.L	(4,A6),A0
		BRA.S	.IN
.alarm		MOVE.L	(8,A6),A0
		BRA.S	.IN
.sp		MOVE.L	(12,A6),A0
		BRA.S	.IN
.flag		MOVE.L	(16,A6),A0

.IN		move.l	a0,d1
		beq	.chk
		MOVE.L	(IS_DATA,A0),A1
		MOVE.L	(IS_CODE,A0),A0
		movem.l	d0/a6,-(a7)
		Jsr	(A0)
		movem.l	(a7)+,d0/a6
		bra	.chk

**************************************************************************
*   CIAB.RESOURCE                                                        *
**************************************************************************

CIABINIT	move.l	_ciabbase,d0
		beq	.init
		rts

.init		move.l	#-_LVOSetICR,d0
		move.l	#5*4,d1
		lea	_ciabname(pc),a0
		bsr	_InitStruct
		move.l	d0,a0
		move.l	d0,_ciabbase

		patch	_LVOAddICRVector(a0),CIABADDICRV(pc)
		patch	_LVORemICRVector(a0),CIABREMICRV(pc)
		
		clr.l	(a0)+
		clr.l	(a0)+
		clr.l	(a0)+
		clr.l	(a0)+
		clr.l	(a0)

		MOVE.B	#$FF,$BFD500
		MOVE.B	#$FF,$BFD700

		rts

INT_CIAB	move.l	_ciabbase,a6
		MOVE.B	$BFDD00,D0
		bra	INT_CIA

**************************************************************************
**************************************************************************

	INCLUDE	dos.s
	INCLUDE	freeanim.s
	INCLUDE	nonvolatile.s
	INCLUDE	graphics.s
	INCLUDE	intuition.s
	INCLUDE	lowlevel.s
	INCLUDE	mathffp.s
	INCLUDE	mathtrans.s

**************************************************************************
**************************************************************************
*   CHIPMEMORYTABLE AND MEMORY MANAGEMENT DATA                           *
**************************************************************************

;THIS HAS TO BE ABSOLUTELY THE LAST LABEL, THE TABLE HAS A LEN DEPENDING
;  FROM THE SIZE OF THE MEMORY
	DC.B	'OSEMUEND'
	CNOP	0,8
_osemu_end
ALLOCMTAB

