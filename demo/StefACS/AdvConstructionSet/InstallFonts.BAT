If Exists FONTS:Data70.font
 If Exists FONTS:Data70
  If Exists FONTS:Data70/13
   Echo "Font Data70 already installed."
   Wait SECS 1
  EndIF
 EndIF
Else
 SetEnv CopiaRiuscita="True"
 Echo "I am copying the file Data70.font in your fonts drawer..."
 Wait SECS 1
 Copy Fonts/Data70.font FONTS: CLONE
 Wait SECS 1
 IF EXISTS FONTS:Data70.font
  Echo "Data70.font copied."
 Else
  SetEnv CopiaRiuscita="False"
  Echo "Data70.font not copied."
 EndIF
 Wait SECS 1
 Echo "I am creating the drawer Data70 in your fonts drawer..."
 Wait SECS 1
 MakeDir FONTS:Data70
 Wait SECS 1
 IF EXISTS FONTS:Data70
  Echo "Data70 drawer created."
 Else
  SetEnv CopiaRiuscita="False"
  Echo "Data70 drawer not created."
 EndIf
 Wait SECS 1
 Echo "I am copying the file 13 in your drawer Data70 in your fonts drawer..."
 Wait SECS 1
 Copy Fonts/Data70/13 FONTS:Data70 CLONE
 Wait SECS 1
 If Exists FONTS:Data70/13
  Echo "13 copied."
 Else
  SetEnv CopiaRiuscita="False"
  Echo "13 not copied."
 EndIf
 Wait SECS 1
 If $CopiaRiuscita EQ "True"
  Echo "Data70 font installation completed."
 Else
  Echo "Data70 font installation not completed."
 EndIf
EndIf
If Exists FONTS:SteMar002.font
 If Exists FONTS:SteMar002
  If Exists FONTS:SteMar002/9f
   Echo "Font SteMar002 already installed."
   Wait SECS 1
  EndIf
 EndIf
Else
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
 EndIF
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
 EndIF
 Wait SECS 1
 Echo "I am copying the file 9f in your drawer SteMar002 in your fonts drawer..."
 Wait SECS 1
 Copy Fonts/SteMar002/9f FONTS:SteMar002 CLONE
 Wait SECS 1
 IF EXISTS FONTS:SteMar002/9f
  Echo "9f copied."
 Else
  SetEnv CopiaRiuscita="False"
  Echo "9f not copied."
 EndIF
 Wait SECS 1
 If $CopiaRiuscita EQ "True"
  Echo "SteMar002 font installation completed."
 Else
  Echo "SteMar002 font installation not completed."
 EndIF
EndIf
