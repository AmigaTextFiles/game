# Microsoft Developer Studio Project File - Name="wwii" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=wwii - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "wwii.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "wwii.mak" CFG="wwii - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "wwii - Win32 Release" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "wwii - Win32 Debug" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "wwii - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /FD /c
# ADD CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /FR /YX /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /o "NUL" /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /o "NUL" /win32
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /machine:I386 /out:"c:\games\quake2\dday\gamex86.dll"

!ELSEIF  "$(CFG)" == "wwii - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MTd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /YX /FD /c
# ADD CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /FR /YX /FD /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /o "NUL" /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /o "NUL" /win32
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /debug /machine:I386 /out:"c:\games\quake2\dday\gamex86.dll" /pdbtype:sept

!ENDIF 

# Begin Target

# Name "wwii - Win32 Release"
# Name "wwii - Win32 Debug"
# Begin Group "Source Files (*.c)"

# PROP Default_Filter "*.c"
# Begin Source File

SOURCE=.\src\g_ai.c
# End Source File
# Begin Source File

SOURCE=.\src\g_arty.c
# End Source File
# Begin Source File

SOURCE=.\src\g_cmds.c
# End Source File
# Begin Source File

SOURCE=.\src\g_combat.c
# End Source File
# Begin Source File

SOURCE=.\src\g_dll.win32.c
# End Source File
# Begin Source File

SOURCE=.\src\g_ents.c
# End Source File
# Begin Source File

SOURCE=.\src\g_func.c
# End Source File
# Begin Source File

SOURCE=.\src\g_items.c
# End Source File
# Begin Source File

SOURCE=.\src\g_main.c
# End Source File
# Begin Source File

SOURCE=.\src\g_maps.c
# End Source File
# Begin Source File

SOURCE=.\src\g_misc.c
# End Source File
# Begin Source File

SOURCE=.\src\g_monster.c
# End Source File
# Begin Source File

SOURCE=.\src\g_objectives.c
# End Source File
# Begin Source File

SOURCE=.\src\g_phys.c
# End Source File
# Begin Source File

SOURCE=.\src\g_save.c
# End Source File
# Begin Source File

SOURCE=.\src\g_spawn.c
# End Source File
# Begin Source File

SOURCE=.\src\g_svcmds.c
# End Source File
# Begin Source File

SOURCE=.\src\g_target.c
# End Source File
# Begin Source File

SOURCE=.\src\g_trigger.c
# End Source File
# Begin Source File

SOURCE=.\src\g_turret.c
# End Source File
# Begin Source File

SOURCE=.\src\g_utils.c
# End Source File
# Begin Source File

SOURCE=.\src\g_weapon.c
# End Source File
# Begin Source File

SOURCE=.\src\m_actor.c
# End Source File
# Begin Source File

SOURCE=.\src\m_flash.c
# End Source File
# Begin Source File

SOURCE=.\src\m_insane.c
# End Source File
# Begin Source File

SOURCE=.\src\m_move.c
# End Source File
# Begin Source File

SOURCE=.\src\p_classes.c
# End Source File
# Begin Source File

SOURCE=.\src\p_client.c
# End Source File
# Begin Source File

SOURCE=.\src\p_generic_wep.c
# End Source File
# Begin Source File

SOURCE=.\src\p_hud.c
# End Source File
# Begin Source File

SOURCE=.\src\p_menu.c
# End Source File
# Begin Source File

SOURCE=.\src\p_observer.c
# End Source File
# Begin Source File

SOURCE=.\src\p_trail.c
# End Source File
# Begin Source File

SOURCE=.\src\p_view.c
# End Source File
# Begin Source File

SOURCE=.\src\p_weapon.c
# End Source File
# Begin Source File

SOURCE=.\src\q_shared.c
# End Source File
# Begin Source File

SOURCE=.\src\u_entmgr.c
# End Source File
# Begin Source File

SOURCE=.\src\u_findfunc.c
# End Source File
# Begin Source File

SOURCE=.\src\x_fbomb.c
# End Source File
# Begin Source File

SOURCE=.\src\x_fire.c
# End Source File
# Begin Source File

SOURCE=.\src\z_removed.c
# End Source File
# End Group
# Begin Group "Header Files (*.h)"

# PROP Default_Filter "*.h"
# Begin Source File

SOURCE=.\src\allfuncs.h
# End Source File
# Begin Source File

SOURCE=.\src\funcarry.h
# End Source File
# Begin Source File

SOURCE=.\src\g_cmds.h
# End Source File
# Begin Source File

SOURCE=.\src\g_defines.h
# End Source File
# Begin Source File

SOURCE=.\src\g_dll.h
# End Source File
# Begin Source File

SOURCE=.\src\g_local.h
# End Source File
# Begin Source File

SOURCE=.\src\g_maps.h
# End Source File
# Begin Source File

SOURCE=.\src\game.h
# End Source File
# Begin Source File

SOURCE=.\src\m_actor.h
# End Source File
# Begin Source File

SOURCE=.\src\m_insane.h
# End Source File
# Begin Source File

SOURCE=.\src\m_player.h
# End Source File
# Begin Source File

SOURCE=.\src\p_classes.h
# End Source File
# Begin Source File

SOURCE=.\src\p_menu.h
# End Source File
# Begin Source File

SOURCE=.\src\p_menus.h
# End Source File
# Begin Source File

SOURCE=.\src\p_observer.h
# End Source File
# Begin Source File

SOURCE=.\src\q_shared.h
# End Source File
# Begin Source File

SOURCE=.\src\u_entmgr.h
# End Source File
# Begin Source File

SOURCE=.\src\u_findfunc.h
# End Source File
# Begin Source File

SOURCE=.\src\x_fbomb.h
# End Source File
# Begin Source File

SOURCE=.\src\x_fire.h
# End Source File
# End Group
# Begin Group "Misc"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\src\ChangeLog
# End Source File
# Begin Source File

SOURCE=.\src\g_dll.linux.c

!IF  "$(CFG)" == "wwii - Win32 Release"

!ELSEIF  "$(CFG)" == "wwii - Win32 Debug"

# PROP Exclude_From_Build 1

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\game.def
# End Source File
# Begin Source File

SOURCE=.\src\license.txt
# End Source File
# Begin Source File

SOURCE=.\src\Makefile
# End Source File
# Begin Source File

SOURCE=.\src\readme.txt
# End Source File
# End Group
# End Target
# End Project
