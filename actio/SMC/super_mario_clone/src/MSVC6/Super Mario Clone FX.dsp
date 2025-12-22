# Microsoft Developer Studio Project File - Name="Super Mario Clone FX" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** NICHT BEARBEITEN **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=Super Mario Clone FX - Win32 Debug
!MESSAGE Dies ist kein gültiges Makefile. Zum Erstellen dieses Projekts mit NMAKE
!MESSAGE verwenden Sie den Befehl "Makefile exportieren" und führen Sie den Befehl
!MESSAGE 
!MESSAGE NMAKE /f "Super Mario Clone FX.mak".
!MESSAGE 
!MESSAGE Sie können beim Ausführen von NMAKE eine Konfiguration angeben
!MESSAGE durch Definieren des Makros CFG in der Befehlszeile. Zum Beispiel:
!MESSAGE 
!MESSAGE NMAKE /f "Super Mario Clone FX.mak" CFG="Super Mario Clone FX - Win32 Debug"
!MESSAGE 
!MESSAGE Für die Konfiguration stehen zur Auswahl:
!MESSAGE 
!MESSAGE "Super Mario Clone FX - Win32 Release" (basierend auf  "Win32 (x86) Console Application")
!MESSAGE "Super Mario Clone FX - Win32 Debug" (basierend auf  "Win32 (x86) Console Application")
!MESSAGE "Super Mario Clone FX - Win32 Release Debug" (basierend auf  "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "Super Mario Clone FX - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "..\..\"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /FR /YX /FD /c
# ADD BASE RSC /l 0x407 /d "NDEBUG"
# ADD RSC /l 0x407 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo /o"Super Mario Clone FX.bsc"
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /pdb:"Release\Super Mario Clone FX.pdb" /machine:I386
# SUBTRACT LINK32 /pdb:none

!ELSEIF  "$(CFG)" == "Super Mario Clone FX - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "..\..\"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
# ADD CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /FR /YX /FD /GZ /c
# SUBTRACT CPP /X
# ADD BASE RSC /l 0x407 /d "_DEBUG"
# ADD RSC /l 0x407 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo /o"Super Mario Clone FXD.bsc"
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /pdb:"Debug\Super Mario Clone FX.pdb" /debug /machine:I386 /out:"..\..\Super Mario Clone FXD.exe" /pdbtype:sept
# SUBTRACT LINK32 /pdb:none /nodefaultlib

!ELSEIF  "$(CFG)" == "Super Mario Clone FX - Win32 Release Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Super_Mario_Clone_FX___Win32_Release_Debug"
# PROP BASE Intermediate_Dir "Super_Mario_Clone_FX___Win32_Release_Debug"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "..\..\"
# PROP Intermediate_Dir "Release_Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /FR /YX /FD /c
# ADD CPP /nologo /MD /W3 /GX /Zi /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /FR /YX /FD /c
# ADD BASE RSC /l 0x407 /d "NDEBUG"
# ADD RSC /l 0x407 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"Release\Super Mario Clone FX.bsc"
# ADD BSC32 /nologo /o"Super Mario Clone FXRD.bsc"
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /pdb:"Release\Super Mario Clone FX.pdb" /machine:I386
# SUBTRACT BASE LINK32 /pdb:none
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:yes /pdb:"Release\Super Mario Clone FX.pdb" /debug /machine:I386 /out:"..\..\Super Mario Clone FXRD.exe"
# SUBTRACT LINK32 /pdb:none /nodefaultlib

!ENDIF 

# Begin Target

# Name "Super Mario Clone FX - Win32 Release"
# Name "Super Mario Clone FX - Win32 Debug"
# Name "Super Mario Clone FX - Win32 Release Debug"
# Begin Group "Quellcodedateien"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Group "Enemy"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\banzai_bill.cpp
# End Source File
# Begin Source File

SOURCE=..\enemy.cpp
# End Source File
# Begin Source File

SOURCE=..\goomba.cpp
# End Source File
# Begin Source File

SOURCE=..\jpiranha.cpp
# End Source File
# Begin Source File

SOURCE=..\rex.cpp
# End Source File
# Begin Source File

SOURCE=..\turtle.cpp
# End Source File
# End Group
# Begin Source File

SOURCE=..\animation.cpp
# End Source File
# Begin Source File

SOURCE=..\audio.cpp
# End Source File
# Begin Source File

SOURCE=..\box.cpp
# End Source File
# Begin Source File

SOURCE=..\cloud.cpp
# End Source File
# Begin Source File

SOURCE=..\dialog.cpp
# End Source File
# Begin Source File

SOURCE=..\globals.cpp
# End Source File
# Begin Source File

SOURCE=..\goldpiece.cpp
# End Source File
# Begin Source File

SOURCE=..\hud.cpp
# End Source File
# Begin Source File

SOURCE=..\level.cpp
# End Source File
# Begin Source File

SOURCE=..\leveleditor.cpp
# End Source File
# Begin Source File

SOURCE=..\levelexit.cpp
# End Source File
# Begin Source File

SOURCE=..\main.cpp
# End Source File
# Begin Source File

SOURCE=..\menu.cpp
# End Source File
# Begin Source File

SOURCE=..\overworld.cpp
# End Source File
# Begin Source File

SOURCE=..\player.cpp
# End Source File
# Begin Source File

SOURCE=..\powerup.cpp
# End Source File
# Begin Source File

SOURCE=..\preferences.cpp
# End Source File
# Begin Source File

SOURCE=..\savegame.cpp
# End Source File
# Begin Source File

SOURCE=..\sprite.cpp
# End Source File
# End Group
# Begin Group "Header-Dateien"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Group "Enemy header"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\include\banzai_bill.h
# End Source File
# Begin Source File

SOURCE=..\include\enemy.h
# End Source File
# Begin Source File

SOURCE=..\include\goomba.h
# End Source File
# Begin Source File

SOURCE=..\include\jpiranha.h
# End Source File
# Begin Source File

SOURCE=..\include\rex.h
# End Source File
# Begin Source File

SOURCE=..\include\turtle.h
# End Source File
# End Group
# Begin Source File

SOURCE=..\include\animation.h
# End Source File
# Begin Source File

SOURCE=..\include\audio.h
# End Source File
# Begin Source File

SOURCE=..\include\box.h
# End Source File
# Begin Source File

SOURCE=..\include\cloud.h
# End Source File
# Begin Source File

SOURCE=..\include\dialog.h
# End Source File
# Begin Source File

SOURCE=..\include\globals.h
# End Source File
# Begin Source File

SOURCE=..\include\goldpiece.h
# End Source File
# Begin Source File

SOURCE=..\include\hud.h
# End Source File
# Begin Source File

SOURCE=..\include\level.h
# End Source File
# Begin Source File

SOURCE=..\include\leveleditor.h
# End Source File
# Begin Source File

SOURCE=..\include\levelexit.h
# End Source File
# Begin Source File

SOURCE=..\include\main.h
# End Source File
# Begin Source File

SOURCE=..\include\menu.h
# End Source File
# Begin Source File

SOURCE=..\include\overworld.h
# End Source File
# Begin Source File

SOURCE=..\include\player.h
# End Source File
# Begin Source File

SOURCE=..\include\powerup.h
# End Source File
# Begin Source File

SOURCE=..\include\preferences.h
# End Source File
# Begin Source File

SOURCE=..\include\savegame.h
# End Source File
# Begin Source File

SOURCE=..\include\sprite.h
# End Source File
# End Group
# Begin Group "Ressourcendateien"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=..\include\framerate.h
# End Source File
# Begin Source File

SOURCE=.\idr_main.ico
# End Source File
# Begin Source File

SOURCE=..\include\img_manager.h
# End Source File
# Begin Source File

SOURCE=.\Skript.rc
# End Source File
# Begin Source File

SOURCE=.\libs\SDL.lib
# End Source File
# Begin Source File

SOURCE=.\libs\SDL_gfx.lib
# End Source File
# Begin Source File

SOURCE=.\libs\SDL_image.lib
# End Source File
# Begin Source File

SOURCE=.\libs\SDL_mixer.lib
# End Source File
# Begin Source File

SOURCE=.\libs\SDL_ttf.lib
# End Source File
# End Group
# End Target
# End Project
