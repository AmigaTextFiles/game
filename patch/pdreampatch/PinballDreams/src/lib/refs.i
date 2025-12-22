	; *** Compulsory in the user program

	XDEF	_loader
	XDEF	_user_pbuffer
	XDEF	_general_pbuffer

	XDEF	_UserPatchRoutines
	XDEF	_EndUserPatchRoutines

	; *** Non-relocated routines. call normally with JSR
	; *** NEVER call them with JSRGEN: it would crash immediately.

	XREF	_init
	XREF	_CloseAll
	XREF	_LoadDisks
	XREF	_LoadDiskFromName
	XREF	_LoadDisksIndex
	XREF	_LoadFiles
	XREF	_LoadSmallFiles
	XREF	_Kick37Test
	XREF	_KickVerTest
	XREF	_GetMemFlag
	XREF	_FlushCachesSys
	XREF	_Degrade
	XREF	_TransfRoutines
	XREF	_SmartCrash
	XREF	_SaveOSData
	XREF	_FreezeAll
	XREF	_Display
	XREF	_SaveCustomRegs
	XREF	_RestoreCustomRegs
	XREF	_SaveCIARegs
	XREF	_RestoreCIARegs
	XREF	_InGameOSCall
	XREF	_LoadRNCFile
	XREF	_AllocExtMem
	XREF	_Test1MBChip
	XREF	_Test2MBChip
	XREF	_Reboot

	; *** Relocated routines. always call with JSRGEN (see macros.i)
	; *** from user program. It works with JSR but if the OS is killed
	; *** JSRGEN is safer as it jumps in the allocated block
	; *** which is in the top of memory (MEMF_REVERSE) if kick > 38

	XREF	_GoECS
	XREF	_ResetDisplay
	XREF	_ResetSprites
	XREF	_BlackScreen
	XREF	_BlockFastMem
	XREF	_InitTrackDisk
	XREF	_TrackLoadFast
	XREF	_TrackLoadHD
	XREF	_SetTDUnit
	XREF	_SetDisk
	XREF	_ReadRobSectorsFast
	XREF	_ReadFile
	XREF	_ReadFileFast
	XREF	_ReadFileHD
	XREF	_WriteFileHD
	XREF	_DeleteFileHD
	XREF	_ATNDecrunch
	XREF	_RNCDecrunch
	XREF	_RNCLength
	XREF	_FlushCachesHard
	XREF	_TestFile
	XREF	_PatchExceptions
	XREF	_StrcmpAsm
	XREF	_StrcpyAsm
	XREF	_StrlenAsm
	XREF	_ToUpperAsm
	XREF	_WaitMouse
	XREF	_WaitMouseInterrupt
	XREF	_GetDiskPointer
	XREF	_CheckAGA
	XREF	_InGameExit

	; *** exported variables

	XREF	_GeneralPatchRoutines
	XREF	_userstack

	; *** system

	XREF	_DosBase
	XREF	_SysBase
