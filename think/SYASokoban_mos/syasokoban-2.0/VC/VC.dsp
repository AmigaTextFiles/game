# Microsoft Developer Studio Project File - Name="VC" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Application" 0x0101

CFG=VC - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "VC.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "VC.mak" CFG="VC - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "VC - Win32 Release" (based on "Win32 (x86) Application")
!MESSAGE "VC - Win32 Debug" (based on "Win32 (x86) Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""$/SYASokoban2/VC", LKAAAAAA"
# PROP Scc_LocalPath "."
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "VC - Win32 Release"

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
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /YX /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x1c09 /d "NDEBUG"
# ADD RSC /l 0x1c09 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib SDL.lib SDLmain.lib /nologo /subsystem:windows /machine:I386 /out:"Release/Sokoban.exe"

!ELSEIF  "$(CFG)" == "VC - Win32 Debug"

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
# ADD CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /YX /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x1c09 /d "_DEBUG"
# ADD RSC /l 0x1c09 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib SDL.lib SDLmain.lib /nologo /subsystem:windows /debug /machine:I386 /out:"Debug/Sokoban.exe" /pdbtype:sept

!ENDIF 

# Begin Target

# Name "VC - Win32 Release"
# Name "VC - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=..\src\Game.cpp
# End Source File
# Begin Source File

SOURCE=..\src\Game.h
# End Source File
# Begin Source File

SOURCE=..\src\GameRegistry.cpp
# End Source File
# Begin Source File

SOURCE=..\src\GameRegistry.h
# End Source File
# Begin Source File

SOURCE=..\src\Games.cpp
# End Source File
# Begin Source File

SOURCE=..\src\Games.h
# End Source File
# Begin Source File

SOURCE=..\src\Main.cpp
# End Source File
# End Group
# Begin Group "Sokoban"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\src\Sokoban.cpp
# End Source File
# Begin Source File

SOURCE=..\src\Sokoban.h
# End Source File
# End Group
# Begin Group "Documentation"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\docs\doxygen.cfg
# End Source File
# Begin Source File

SOURCE=..\README.txt
# End Source File
# Begin Source File

SOURCE=..\docs\TODO.txt
# End Source File
# End Group
# Begin Group "SokobanLevels"

# PROP Default_Filter ""
# Begin Group "David Holland"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\data\sokoban\levels\david_hollands_dh1.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\david_hollands_dh1.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\david_hollands_dh2.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\david_hollands_dh2.txt
# End Source File
# End Group
# Begin Group "Howard Abed"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\data\sokoban\levels\howard_abed_1.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\howard_abed_1.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\howard_abed_2.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\howard_abed_2.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\howard_abed_3.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\howard_abed_3.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\howard_abed_4.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\howard_abed_4.txt
# End Source File
# End Group
# Begin Group "Aymeric du Peloux"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\data\sokoban\levels\microcosmos.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\microcosmos.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\minicosmos.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\minicosmos.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\nabokosmos.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\nabokosmos.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\picokosmos.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\picokosmos.txt
# End Source File
# End Group
# Begin Group "David Skinner"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\data\sokoban\levels\mas_microban.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\mas_microban.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\mas_sasquatch.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\mas_sasquatch.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\microban.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\microban.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\sasquatch.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\sasquatch.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\sasquatch_iii.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\sasquatch_iii.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\sasquatch_iv.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\sasquatch_iv.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\sasquatch_v.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\sasquatch_v.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\sasquatch_vi.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\sasquatch_vi.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\sasquatch_vii.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\sasquatch_vii.txt
# End Source File
# End Group
# Begin Group "Yoshio Murase"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\data\sokoban\levels\yoshio_murase.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\yoshio_murase.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\yoshio_murase_handmade.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\yoshio_murase_handmade.txt
# End Source File
# End Group
# Begin Group "Jacques Duthen"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\data\sokoban\levels\dimitri_and_yorick.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\dimitri_and_yorick.txt
# End Source File
# Begin Source File

SOURCE="..\data\sokoban\levels\sokogen-990602.desc"
# End Source File
# Begin Source File

SOURCE="..\data\sokoban\levels\sokogen-990602.txt"
# End Source File
# End Group
# Begin Group "Lee Haywood"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\data\sokoban\levels\sokevo.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\sokevo.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\sokhard.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\sokhard.txt
# End Source File
# End Group
# Begin Group "François Marques"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\data\sokoban\levels\fmarques_100boxes.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\fmarques_100boxes.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\fmarques_kokoban.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\fmarques_kokoban.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\fmarques_novoban.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\fmarques_novoban.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\fmarques_numbers.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\fmarques_numbers.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\fmarques_online.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\fmarques_online.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\fmarques_sokolate.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\fmarques_sokolate.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\fmarques_sokompact.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\fmarques_sokompact.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\fmarques_soloban.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\fmarques_soloban.txt
# End Source File
# End Group
# Begin Source File

SOURCE=..\data\sokoban\levels\default.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\default.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\marko_dzekic.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\marko_dzekic.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\phil_shapiro.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\phil_shapiro.txt
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\richard_weston.desc
# End Source File
# Begin Source File

SOURCE=..\data\sokoban\levels\richard_weston.txt
# End Source File
# End Group
# Begin Group "Framework"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\src\djControls.cpp
# End Source File
# Begin Source File

SOURCE=..\src\djControls.h
# End Source File
# Begin Source File

SOURCE=..\src\djDesktop.cpp
# End Source File
# Begin Source File

SOURCE=..\src\djDesktop.h
# End Source File
# Begin Source File

SOURCE=..\src\djFont.cpp
# End Source File
# Begin Source File

SOURCE=..\src\djFont.h
# End Source File
# Begin Source File

SOURCE=..\src\djGraph.cpp
# End Source File
# Begin Source File

SOURCE=..\src\djGraph.h
# End Source File
# Begin Source File

SOURCE=..\src\djItem.cpp
# End Source File
# Begin Source File

SOURCE=..\src\djItem.h
# End Source File
# Begin Source File

SOURCE=..\src\djMenu.cpp
# End Source File
# Begin Source File

SOURCE=..\src\djMenu.h
# End Source File
# Begin Source File

SOURCE=..\src\djSettings.cpp
# End Source File
# Begin Source File

SOURCE=..\src\djSettings.h
# End Source File
# Begin Source File

SOURCE=..\src\djUtils.cpp
# End Source File
# Begin Source File

SOURCE=..\src\djUtils.h
# End Source File
# End Group
# End Target
# End Project
