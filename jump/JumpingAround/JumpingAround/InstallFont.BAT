If Exists FONTS:SteMar002.font
 If Exists FONTS:SteMar002/
  If Exists FONTS:SteMar002/9f
   Echo "Font already installed."
   Wait SECS 1
   Skip FINE
  EndIf
 EndIf
EndIf
SetEnv CopiaRiuscita="True"
Echo "I am copying the file SteMar002.font in your fonts drawer..."
Wait SECS 1
Copy Fonts/SteMar002.font FONTS: CLONE
Wait SECS 1
If Exists FONTS:SteMar002.font
 Echo "SteMar002.font copied."
Else
 SetEnv CopiaRiuscita="False"
 Echo "SteMar002.font not copied."
EndIf
Wait SECS 1
Echo "I am creating the drawer SteMar002 in your fonts drawer..."
Wait SECS 1
MakeDir FONTS:SteMar002
Wait SECS 1
If Exists FONTS:SteMar002
 Echo "SteMar002 drawer created."
Else
 SetEnv CopiaRiuscita="False"
 Echo "SteMar002 drawer not created."
EndIf
Wait SECS 1
Echo "I am copying the file 9f in your drawer SteMar002 in your fonts drawer..."
Wait SECS 1
Copy Fonts/SteMar002/9f FONTS:SteMar002/ CLONE
Wait SECS 1
IF Exists FONTS:SteMar002/9f
 Echo "9f copied."
Else
 SetEnv CopiaRiuscita="False"
 Echo "9f not copied."
EndIF
Wait SECS 1
IF $CopiaRiuscita EQ "True"
 Echo "SteMar002 font installation completed."
Else
 Echo "SteMar002 font installation not completed."
EndIF
Lab FINE
