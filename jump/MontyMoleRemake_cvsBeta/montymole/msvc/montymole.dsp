# Microsoft Developer Studio Project File - Name="montymole" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Application" 0x0101

CFG=montymole - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "montymole.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "montymole.mak" CFG="montymole - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "montymole - Win32 Release" (based on "Win32 (x86) Application")
!MESSAGE "montymole - Win32 Debug" (based on "Win32 (x86) Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "montymole - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /YX /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x809 /d "NDEBUG"
# ADD RSC /l 0x809 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /machine:I386

!ELSEIF  "$(CFG)" == "montymole - Win32 Debug"

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
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /YX /FD /GZ /c
# ADD CPP /nologo /MD /W3 /Gm /GX /ZI /Od /I "libs" /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /YX /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x809 /d "_DEBUG"
# ADD RSC /l 0x809 /i "..\libs" /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /debug /machine:I386 /pdbtype:sept /libpath:"libs"

!ENDIF 

# Begin Target

# Name "montymole - Win32 Release"
# Name "montymole - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=..\src\KFile.cpp
# End Source File
# Begin Source File

SOURCE=..\src\KJBackground.cpp
# End Source File
# Begin Source File

SOURCE=..\src\KJText.cpp
# End Source File
# Begin Source File

SOURCE=..\src\KPtrArray.cpp
# End Source File
# Begin Source File

SOURCE=..\src\KScreen.cpp
# End Source File
# Begin Source File

SOURCE=..\src\KSurface.cpp
# End Source File
# Begin Source File

SOURCE=..\src\main.cpp
# End Source File
# Begin Source File

SOURCE=..\src\MMCoal.cpp
# End Source File
# Begin Source File

SOURCE=..\src\MMCrusher.cpp
# End Source File
# Begin Source File

SOURCE=..\src\MMHelper.cpp
# End Source File
# Begin Source File

SOURCE=..\src\MMKiller.cpp
# End Source File
# Begin Source File

SOURCE=..\src\MMMonty.cpp
# End Source File
# Begin Source File

SOURCE=..\src\MMObject.cpp
# End Source File
# Begin Source File

SOURCE=..\src\MMRoom.cpp
# End Source File
# Begin Source File

SOURCE=..\src\MMRoomTests.cpp
# End Source File
# Begin Source File

SOURCE=..\src\MMSlider.cpp
# End Source File
# Begin Source File

SOURCE=..\src\MontyMap.cpp
# End Source File
# Begin Source File

SOURCE=..\src\MontyScreen.cpp
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=..\src\KFile.h
# End Source File
# Begin Source File

SOURCE=..\src\KGrowSurface.h
# End Source File
# Begin Source File

SOURCE=..\src\KJ.h
# End Source File
# Begin Source File

SOURCE=..\src\KJArrayTemplate.h
# End Source File
# Begin Source File

SOURCE=..\src\KJBackground.h
# End Source File
# Begin Source File

SOURCE=..\src\KJText.h
# End Source File
# Begin Source File

SOURCE=..\src\KPtrArray.h
# End Source File
# Begin Source File

SOURCE=..\src\KScreen.h
# End Source File
# Begin Source File

SOURCE=..\src\KSurface.h
# End Source File
# Begin Source File

SOURCE=..\src\MMCoal.h
# End Source File
# Begin Source File

SOURCE=..\src\MMCrusher.h
# End Source File
# Begin Source File

SOURCE=..\src\MMDataDefs.h
# End Source File
# Begin Source File

SOURCE=..\src\MMHelper.h
# End Source File
# Begin Source File

SOURCE=..\src\MMKiller.h
# End Source File
# Begin Source File

SOURCE=..\src\MMMonty.h
# End Source File
# Begin Source File

SOURCE=..\src\MMObject.h
# End Source File
# Begin Source File

SOURCE=..\src\MMRoom.h
# End Source File
# Begin Source File

SOURCE=..\src\MMRoomTests.h
# End Source File
# Begin Source File

SOURCE=..\src\MMSlider.h
# End Source File
# Begin Source File

SOURCE=..\src\MontyMap.h
# End Source File
# Begin Source File

SOURCE=..\src\MontyScreen.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# End Group
# Begin Source File

SOURCE=..\libs\SDLmain.lib
# End Source File
# Begin Source File

SOURCE=..\libs\SDL.lib
# End Source File
# End Target
# End Project
