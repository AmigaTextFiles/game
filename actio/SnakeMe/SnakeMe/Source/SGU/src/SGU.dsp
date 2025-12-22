# Microsoft Developer Studio Project File - Name="SGU" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=SGU - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "SGU.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "SGU.mak" CFG="SGU - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "SGU - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "SGU - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "SGU - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "../lib"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /YX /FD /c
# ADD CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /YX /FD /c
# ADD BASE RSC /l 0x100c /d "NDEBUG"
# ADD RSC /l 0x100c /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ELSEIF  "$(CFG)" == "SGU - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "../lib"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /YX /FD /GZ /c
# ADD CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /YX /FD /GZ /c
# ADD BASE RSC /l 0x100c /d "_DEBUG"
# ADD RSC /l 0x100c /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ENDIF 

# Begin Target

# Name "SGU - Win32 Release"
# Name "SGU - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\SGU.CPP
# End Source File
# Begin Source File

SOURCE=.\SGU_GenUtils.cpp
# End Source File
# Begin Source File

SOURCE=.\SGU_List.cpp
# End Source File
# Begin Source File

SOURCE=.\SGU_Sprite.cpp
# End Source File
# Begin Source File

SOURCE=.\SGU_UI_Base.cpp
# End Source File
# Begin Source File

SOURCE=.\SGU_UI_SDB.cpp
# End Source File
# Begin Source File

SOURCE=.\SGU_UI_Theme.cpp
# End Source File
# Begin Source File

SOURCE=.\SGU_UI_WGButton.cpp
# End Source File
# Begin Source File

SOURCE=.\SGU_UI_WGFile.cpp
# End Source File
# Begin Source File

SOURCE=.\SGU_UI_WGIntBar.cpp
# End Source File
# Begin Source File

SOURCE=.\SGU_UI_WGList.cpp
# End Source File
# Begin Source File

SOURCE=.\SGU_UI_WGScrollBar.cpp
# End Source File
# Begin Source File

SOURCE=.\SGU_UI_WGText.cpp
# End Source File
# Begin Source File

SOURCE=.\SGU_UI_WGValueBar.cpp
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=..\include\SGU.h
# End Source File
# Begin Source File

SOURCE=..\include\SGU_GenUtils.h
# End Source File
# Begin Source File

SOURCE=..\include\SGU_List.h
# End Source File
# Begin Source File

SOURCE=..\include\SGU_Math.h
# End Source File
# Begin Source File

SOURCE=..\include\SGU_PixelUtils.h
# End Source File
# Begin Source File

SOURCE=..\include\SGU_Sprite.h
# End Source File
# Begin Source File

SOURCE=..\include\SGU_types.h
# End Source File
# Begin Source File

SOURCE=..\include\SGU_UI.h
# End Source File
# Begin Source File

SOURCE=..\include\SGU_UI_Base.h
# End Source File
# Begin Source File

SOURCE=..\include\SGU_UI_SDB.h
# End Source File
# Begin Source File

SOURCE=..\include\SGU_UI_Theme.h
# End Source File
# Begin Source File

SOURCE=..\include\SGU_UI_WGButton.h
# End Source File
# Begin Source File

SOURCE=..\include\SGU_UI_WGFile.h
# End Source File
# Begin Source File

SOURCE=..\include\SGU_UI_WGIntBar.h
# End Source File
# Begin Source File

SOURCE=..\include\SGU_UI_WGList.h
# End Source File
# Begin Source File

SOURCE=..\include\SGU_UI_WGScrollBar.h
# End Source File
# Begin Source File

SOURCE=..\include\SGU_UI_WGText.h
# End Source File
# Begin Source File

SOURCE=..\include\SGU_UI_WGValueBar.h
# End Source File
# End Group
# End Target
# End Project
