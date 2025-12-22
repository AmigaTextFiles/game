IF EXISTS FONTS:Data70Quad.font
 IF EXISTS FONTS:Data70Quad
  IF EXISTS FONTS:Data70Quad/52
   Echo "Font already installed."
   Wait SECS 1
   Skip FINE
  EndIF
 EndIF
EndIF
SetEnv CopiaRiuscita="True"
Echo "I am copying the file Data70Quad.font in your fonts drawer..."
Wait SECS 1
Copy Fonts/Data70Quad.font FONTS: CLONE
Wait SECS 1
IF EXISTS FONTS:Data70Quad.font
 Echo "Data70Quad.font copied."
Else
 SetEnv CopiaRiuscita="False"
 Echo "Data70Quad.font not copied."
EndIF
Wait SECS 1
Echo "I am creating the drawer Data70Quad in your fonts drawer..."
Wait SECS 1
MakeDir FONTS:Data70Quad
Wait SECS 1
IF EXISTS FONTS:Data70Quad
 Echo "Data70 drawer created."
Else
 SetEnv CopiaRiuscita="False"
 Echo "Data70Quad drawer not created."
EndIF
Wait SECS 1
Echo "I am copying the file 52 in your drawer Data70Quad in your fonts drawer..."
Wait SECS 1
Copy Fonts/Data70Quad/52 FONTS:Data70 CLONE
Wait SECS 1
IF EXISTS FONTS:Data70Quad/52
 Echo "52 copied."
Else
 SetEnv CopiaRiuscita="False"
 Echo "52 not copied"
EndIF
Wait SECS 1
IF $CopiaRiuscita EQ "True"
 Echo "Data70Quad font installation completed."
Else
 Echo "Data70Quad font installation not completed."
EndIF
Lab FINE
