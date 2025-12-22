/* $VER: HereticPortal 0.7 (1999-02-16) */
options results
call Tags
SELECT
WHEN arg(1)="START" then call Start
WHEN arg(1)="LOAD_1" then call Config("Load","1_")
WHEN arg(1)="SAVE_1" then call Config("Save","1_")
WHEN arg(1)="LOAD_2" then call Config("Load","2_")
WHEN arg(1)="SAVE_2" then call Config("Save","2_")
WHEN arg(1)="LOAD_3" then call Config("Load","3_")
WHEN arg(1)="SAVE_3" then call Config("Save","3_")
WHEN arg(1)="LOADSETTINGS" then call LoadSettings
WHEN arg(1)="SAVESETTINGS" then call SaveSettings
OTHERWISE call Init
end
exit
Init:
address HereticPortal
window ID HMAIN TITLE '"HereticPortal v0.7"' COMMAND '"quit"' PORT HereticPortal ATTRS MUIA_Window_ScreenTitle '"HereticPortal 0.7 ©1999 Lorens Johansson Freely Distributable Emailware"'
menu LABEL "HereticPortal"
item COMMAND '"method 'MUIM_Application_AboutMUI' 0"' PORT HereticPortal ATTRS MUIA_Menuitem_Shortcut 'A' LABEL "About MUI"
item ATTRS MUIA_Menuitem_Title '-1'
item COMMAND '"quit"' PORT HereticPortal ATTRS MUIA_Menuitem_Shortcut 'Q' LABEL "Quit"
endmenu
menu LABEL "Settings"
item COMMAND '"method 'MUIM_Application_OpenConfigWindow'"' PORT HereticPortal ATTRS MUIA_Menuitem_Shortcut 'M' LABEL "MUI Settings..."
item ATTRS MUIA_Menuitem_Title '-1'
item COMMAND '"HereticPortal.rexx LOADSETTINGS"' ATTRS MUIA_Menuitem_Shortcut 'L' LABEL "Load Settings"
item COMMAND '"HereticPortal.rexx SAVESETTINGS"' ATTRS MUIA_Menuitem_Shortcut 'S' LABEL "Save Settings"
endmenu
text help '"HereticPortal v0.7 by\nLorens Johansson (http://members.xoom.com/snorslex)\nIf you use this program, you are required to\nEmail the author (SnorsleX@SoftHome.net). Otherwise,\nhow is he supposed to know to keep supporting\nHereticPortal ?!?\n\033rLorens Johansson"' label "\033c\033bHereticPortal v0.7\033n\n\033cLorens Johansson\n\033cFreely Distributable Emailware"
group REGISTER ATTRS MUIA_CycleChain 1 LABELS "Heretic (68k&PPC),AHeretic (68k),AmiHeretic (68k&PPC),Information"
group 
group REGISTER ATTRS MUIA_CycleChain 1 LABELS "Main,Settings"
group
label "\033cThis is made for version: \033b0.8"
group frame ATTRS MUIA_Group_Columns 3 label "Parameters"
space HORIZ
group
group ATTRS MUIA_Group_Columns 8
label "-asl"
check ID 1_ASL ATTRS MUIA_CycleChain 1 HELP '"Use asl requester to select screen mode defsult is PAL|LORES\n(in PPC version you will see other screen modes than lores,\nbut please DO NOT select other resolution than 320*xxx)."'
label "-bilinear"
check ID 1_BIL ATTRS MUIA_CycleChain 1 HELP '"Enables bilinear filtering in hicolor mode.\nTake a look at bilinear.iff, to see the difference."'
label "-directcgx"
check ID 1_DIR ATTRS MUIA_CycleChain 1 HELP '"Use fast copy routines instead of writepixel\narray does not work with window mode."'
label "-fps"
check ID 1_FPS ATTRS MUIA_CycleChain 1 HELP '"Shows online fps counter."'
label "-ham6"
check ID 1_HA6 ATTRS MUIA_CycleChain 1 HELP '"Sets display in hicolor on AGA to ham6."'
label "-ham8"
check ID 1_HA8 ATTRS MUIA_CycleChain 1 HELP '"Sets display in hicolor on AGA to ham8. Default in ham6."'
label "-hicolor"
check ID 1_HIC ATTRS MUIA_CycleChain 1 HELP '"Enables hicolor rendering."'
label "-joy"
check ID 1_JOY ATTRS MUIA_CycleChain 1 HELP '"Enables joystick support."'
label "-lowdetail"
check ID 1_LOW ATTRS MUIA_CycleChain 1 HELP '"Turns on low detail floor and ceiling rendering.\nLow detail can be also switched on/off with L key during game."'
label "-mouse"
check ID 1_MOU ATTRS MUIA_CycleChain 1 HELP '"Turns mouse on."'
label "-music"
check ID 1_MUS ATTRS MUIA_CycleChain 1 HELP '"Enables music."'
label "-nodoublebuffer"
check ID 1_NOD ATTRS MUIA_CycleChain 1 HELP '"Turns off double buffering."'
label "-nosfx"
check ID 1_NOS ATTRS MUIA_CycleChain 1 HELP '"Disables sound fx effects."'
label "-nosound"
check ID 1_NOO ATTRS MUIA_CycleChain 1 HELP '"Disables music and sfx (no sound at all)."'
label "-turbo"
check ID 1_TUR ATTRS MUIA_CycleChain 1 HELP '"This is actually a bug, which I made available as an option.\nTry this and die ;)"'
label "-window"
check ID 1_WIN ATTRS MUIA_CycleChain 1 HELP '"Display results in window on workbench screen workbench must have\nleast 15 bit depth doublebuffering does not work on window."'
endgroup
group ATTRS MUIA_Group_Columns 6
label "-bus"
check ID 1_CBU ATTRS MUIA_CycleChain 1 HELP '"Sets bus clock. Should be used with care. If Heretic runs too fast,\nyou can use this switch. After heretic starts, It prints actual bus\nclock. This value should be beetwen 50-70 Mhz. If it is really low\n(like 30Mhz or lower) type -bus 60000000 to get 60Mhz bus clock.\nTry different values here (but with care!!!)."' PORT INLINE,
COMMAND """if %s = 0 then do;
address HereticPortal string ID 1_SBU ATTRS '0x80423661' 1;
end;
else do;
address HereticPortal string ID 1_SBU ATTRS '0x80423661' 0;
end"""
string ID 1_SBU ATTRS MUIA_CycleChain 1 HELP '"Sets bus clock. Should be used with care. If Heretic runs too fast,\nyou can use this switch. After heretic starts, It prints actual bus\nclock. This value should be beetwen 50-70 Mhz. If it is really low\n(like 30Mhz or lower) type -bus 60000000 to get 60Mhz bus clock.\nTry different values here (but with care!!!)."'
label "-playdemo"
check ID 1_CPL ATTRS MUIA_CycleChain 1 HELP '"Plays the given demo."' PORT INLINE,
COMMAND """if %s = 0 then do;
address HereticPortal string ID 1_SPL ATTRS '0x80423661' 1;
end;
else do;
address HereticPortal string ID 1_SPL ATTRS '0x80423661' 0;
end"""
string ID 1_SPL ATTRS MUIA_CycleChain 1 HELP '"Plays the given demo."'
endgroup
endgroup
space HORIZ
endgroup
space
group ATTRS MUIA_Group_Columns 2
label "Heretic Path:"
popasl ID 1_PAT ATTRS MUIA_CycleChain 1 HELP '"Select the Heretic executable!"'
endgroup
endgroup
group
group frame ATTRS MUIA_Group_Columns 2 label "Heretic.cfg"
button ID 1_GLO ATTRS MUIA_CycleChain 1 command """HereticPortal.rexx LOAD_1""" label "Load Heretic.cfg"
button ID 1_GSA ATTRS MUIA_CycleChain 1 command """HereticPortal.rexx SAVE_1""" label "Save Heretic.cfg"
endgroup
group REGISTER ATTRS MUIA_CycleChain 1 LABELS "Misc,Keys,ChatMacros"
group scroll ATTRS MUIA_Group_Columns 2
label "Mouse Sensitivity:"
slider ID 1_1 ATTRS MUIA_CycleChain 1 MUIA_Slider_Min 0 MUIA_Slider_Max 9
label "Sfx Volume:"
slider ID 1_2 ATTRS MUIA_CycleChain 1 MUIA_Slider_Min 0 MUIA_Slider_Max 15
label "Music Volume:"
slider ID 1_3 ATTRS MUIA_CycleChain 1 MUIA_Slider_Min 0 MUIA_Slider_Max 15
label "Gamma Correct:"
slider ID 1_4 ATTRS MUIA_CycleChain 1 MUIA_Slider_Min 0 MUIA_Slider_Max 4
label "Screen Blocks:"
slider ID 1_5 ATTRS MUIA_CycleChain 1 MUIA_Slider_Min 3 MUIA_Slider_Max 11
endgroup
group scroll ATTRS MUIA_Group_Columns 2
label "Key Right:"
poplist ID 1_20 ATTRS MUIA_CycleChain 1 labels keys
label "Key Left:"
poplist ID 1_21 ATTRS MUIA_CycleChain 1 labels keys
label "Key Up:"
poplist ID 1_22 ATTRS MUIA_CycleChain 1 labels keys
label "Key Down:"
poplist ID 1_23 ATTRS MUIA_CycleChain 1 labels keys
label "Key Strafe Left:"
poplist ID 1_24 ATTRS MUIA_CycleChain 1 labels keys
label "Key Strafe Right:"
poplist ID 1_25 ATTRS MUIA_CycleChain 1 labels keys
label "Key Fly Up:"
poplist ID 1_26 ATTRS MUIA_CycleChain 1 labels keys
label "Key Fly Down:"
poplist ID 1_27 ATTRS MUIA_CycleChain 1 labels keys
label "Key Fly Center:"
poplist ID 1_28 ATTRS MUIA_CycleChain 1 labels keys
label "Key Look Up:"
poplist ID 1_29 ATTRS MUIA_CycleChain 1 labels keys
label "Key Look Down:"
poplist ID 1_30 ATTRS MUIA_CycleChain 1 labels keys
label "Key Look Center:"
poplist ID 1_31 ATTRS MUIA_CycleChain 1 labels keys
label "Key Inv Left:"
poplist ID 1_32 ATTRS MUIA_CycleChain 1 labels keys
label "Key Inv Right:"
poplist ID 1_33 ATTRS MUIA_CycleChain 1 labels keys
label "Key Use Artifact:"
poplist ID 1_34 ATTRS MUIA_CycleChain 1 labels keys
label "Key Fire:"
poplist ID 1_35 ATTRS MUIA_CycleChain 1 labels keys
label "Key Use:"
poplist ID 1_36 ATTRS MUIA_CycleChain 1 labels keys
label "Key Strafe:"
poplist ID 1_37 ATTRS MUIA_CycleChain 1 labels keys
label "Key Speed:"
poplist ID 1_38 ATTRS MUIA_CycleChain 1 labels keys
endgroup
group scroll ATTRS MUIA_Group_Columns 2
label "ChatMacro0:"
string ID 1_80 ATTRS MUIA_CycleChain 1
label "ChatMacro1:"
string ID 1_81 ATTRS MUIA_CycleChain 1
label "ChatMacro2:"
string ID 1_82 ATTRS MUIA_CycleChain 1
label "ChatMacro3:"
string ID 1_83 ATTRS MUIA_CycleChain 1
label "ChatMacro4:"
string ID 1_84 ATTRS MUIA_CycleChain 1
label "ChatMacro5:"
string ID 1_85 ATTRS MUIA_CycleChain 1
label "ChatMacro6:"
string ID 1_86 ATTRS MUIA_CycleChain 1
label "ChatMacro7:"
string ID 1_87 ATTRS MUIA_CycleChain 1
label "ChatMacro8:"
string ID 1_88 ATTRS MUIA_CycleChain 1
label "ChatMacro9:"
string ID 1_89 ATTRS MUIA_CycleChain 1
endgroup
endgroup
endgroup
endgroup
endgroup 
group 
group REGISTER ATTRS MUIA_CycleChain 1 LABELS "Main,Settings"
group
label "\033cThis is made for version: \033b0.2"
group frame ATTRS MUIA_Group_Columns 3 label "Parameters"
space HORIZ
label "\033cNone known yet..."
space HORIZ
endgroup
space
group ATTRS MUIA_Group_Columns 2
label "AHeretic Path:"
popasl ID 2_PAT ATTRS MUIA_CycleChain 1 HELP '"Select the AHeretic executable!"'
endgroup
endgroup
group
group frame ATTRS MUIA_Group_Columns 2 label "Heretic.cfg"
button ID 2_GLO ATTRS MUIA_CycleChain 1 command """HereticPortal.rexx LOAD_2""" label "Load Heretic.cfg"
button ID 2_GSA ATTRS MUIA_CycleChain 1 command """HereticPortal.rexx SAVE_2""" label "Save Heretic.cfg"
endgroup
group REGISTER ATTRS MUIA_CycleChain 1 LABELS "Misc,Keys,ChatMacros"
group scroll ATTRS MUIA_Group_Columns 2
label "Mouse Sensitivity:"
slider ID 2_1 ATTRS MUIA_CycleChain 1 MUIA_Slider_Min 0 MUIA_Slider_Max 9
label "Sfx Volume:"
slider ID 2_2 ATTRS MUIA_CycleChain 1 MUIA_Slider_Min 0 MUIA_Slider_Max 15
label "Music Volume:"
slider ID 2_3 ATTRS MUIA_CycleChain 1 MUIA_Slider_Min 0 MUIA_Slider_Max 15
label "Gamma Correct:"
slider ID 2_4 ATTRS MUIA_CycleChain 1 MUIA_Slider_Min 0 MUIA_Slider_Max 4
label "Screen Blocks:"
slider ID 2_5 ATTRS MUIA_CycleChain 1 MUIA_Slider_Min 3 MUIA_Slider_Max 11
endgroup
group scroll ATTRS MUIA_Group_Columns 2
label "Key Right:"
poplist ID 2_20 ATTRS MUIA_CycleChain 1 labels keys
label "Key Left:"
poplist ID 2_21 ATTRS MUIA_CycleChain 1 labels keys
label "Key Up:"
poplist ID 2_22 ATTRS MUIA_CycleChain 1 labels keys
label "Key Down:"
poplist ID 2_23 ATTRS MUIA_CycleChain 1 labels keys
label "Key Strafe Left:"
poplist ID 2_24 ATTRS MUIA_CycleChain 1 labels keys
label "Key Strafe Right:"
poplist ID 2_25 ATTRS MUIA_CycleChain 1 labels keys
label "Key Fly Up:"
poplist ID 2_26 ATTRS MUIA_CycleChain 1 labels keys
label "Key Fly Down:"
poplist ID 2_27 ATTRS MUIA_CycleChain 1 labels keys
label "Key Fly Center:"
poplist ID 2_28 ATTRS MUIA_CycleChain 1 labels keys
label "Key Look Up:"
poplist ID 2_29 ATTRS MUIA_CycleChain 1 labels keys
label "Key Look Down:"
poplist ID 2_30 ATTRS MUIA_CycleChain 1 labels keys
label "Key Look Center:"
poplist ID 2_31 ATTRS MUIA_CycleChain 1 labels keys
label "Key Inv Left:"
poplist ID 2_32 ATTRS MUIA_CycleChain 1 labels keys
label "Key Inv Right:"
poplist ID 2_33 ATTRS MUIA_CycleChain 1 labels keys
label "Key Use Artifact:"
poplist ID 2_34 ATTRS MUIA_CycleChain 1 labels keys
label "Key Fire:"
poplist ID 2_35 ATTRS MUIA_CycleChain 1 labels keys
label "Key Use:"
poplist ID 2_36 ATTRS MUIA_CycleChain 1 labels keys
label "Key Strafe:"
poplist ID 2_37 ATTRS MUIA_CycleChain 1 labels keys
label "Key Speed:"
poplist ID 2_38 ATTRS MUIA_CycleChain 1 labels keys
endgroup
group scroll ATTRS MUIA_Group_Columns 2
label "ChatMacro0:"
string ID 2_80 ATTRS MUIA_CycleChain 1
label "ChatMacro1:"
string ID 2_81 ATTRS MUIA_CycleChain 1
label "ChatMacro2:"
string ID 2_82 ATTRS MUIA_CycleChain 1
label "ChatMacro3:"
string ID 2_83 ATTRS MUIA_CycleChain 1
label "ChatMacro4:"
string ID 2_84 ATTRS MUIA_CycleChain 1
label "ChatMacro5:"
string ID 2_85 ATTRS MUIA_CycleChain 1
label "ChatMacro6:"
string ID 2_86 ATTRS MUIA_CycleChain 1
label "ChatMacro7:"
string ID 2_87 ATTRS MUIA_CycleChain 1
label "ChatMacro8:"
string ID 2_88 ATTRS MUIA_CycleChain 1
label "ChatMacro9:"
string ID 2_89 ATTRS MUIA_CycleChain 1
endgroup
endgroup
endgroup
endgroup
endgroup 
group 
group REGISTER ATTRS MUIA_CycleChain 1 LABELS "Main,Settings"
group
label "\033cThis is made for version: \033b2.0"
group frame ATTRS MUIA_Group_Columns 3 label "Parameters"
space HORIZ
group
group ATTRS MUIA_Group_Columns 8
label "-bat"
check ID 3_BAT ATTRS MUIA_CycleChain 1 HELP '"????? (Use only on PowerPC systems.)"'
label "-dbuf"
check ID 3_DBU ATTRS MUIA_CycleChain 1 HELP '"To enable Doublebuffering (Probably slightly slower on most Hardware, but less flicker for AGA...)"'
label "-gosure"
check ID 3_GOS ATTRS MUIA_CycleChain 1 HELP '"?????"'
label "-mmu"
check ID 3_MMU ATTRS MUIA_CycleChain 1 HELP '"????? (Use only on PowerPC systems.)"'
label "-music"
check ID 3_MUS ATTRS MUIA_CycleChain 1 HELP '"To activate music."'
label "-nosfx"
check ID 3_NOS ATTRS MUIA_CycleChain 1 HELP '"To deactive music and sound."'
endgroup
group ATTRS MUIA_Group_Columns 6
label "-height"
check ID 3_CHE ATTRS MUIA_CycleChain 1 HELP '"Select the height of the screen in pixels."' PORT INLINE,
COMMAND """if %s = 0 then do;
address HereticPortal string ID 3_SHE ATTRS '0x80423661' 1;
end;
else do;
address HereticPortal string ID 3_SHE ATTRS '0x80423661' 0;
end"""
string ID 3_SHE ATTRS MUIA_CycleChain 1 HELP '"Select the height of the screen in pixels."'
label "-width"
check ID 3_CWI ATTRS MUIA_CycleChain 1 HELP '"Select the width of the screen in pixels."' PORT INLINE,
COMMAND """if %s = 0 then do;
address HereticPortal string ID 3_SWI ATTRS '0x80423661' 1;
end;
else do;
address HereticPortal string ID 3_SWI ATTRS '0x80423661' 0;
end"""
string ID 3_SWI ATTRS MUIA_CycleChain 1 HELP '"Select the width of the screen in pixels."'
endgroup
endgroup
space HORIZ
endgroup
space
group ATTRS MUIA_Group_Columns 2
label "AmiHeretic Path:"
popasl ID 3_PAT ATTRS MUIA_CycleChain 1 HELP '"Select the AmiHeretic executable!"'
endgroup
endgroup
group
group frame ATTRS MUIA_Group_Columns 2 label "Heretic.cfg"
button ID 3_GLO ATTRS MUIA_CycleChain 1 command """HereticPortal.rexx LOAD_3""" label "Load Heretic.cfg"
button ID 3_GSA ATTRS MUIA_CycleChain 1 command """HereticPortal.rexx SAVE_3""" label "Save Heretic.cfg"
endgroup
group REGISTER ATTRS MUIA_CycleChain 1 LABELS "Misc,Keys,ChatMacros"
group scroll ATTRS MUIA_Group_Columns 2
label "Mouse Sensitivity:"
slider ID 3_1 ATTRS MUIA_CycleChain 1 MUIA_Slider_Min 0 MUIA_Slider_Max 9
label "Sfx Volume:"
slider ID 3_2 ATTRS MUIA_CycleChain 1 MUIA_Slider_Min 0 MUIA_Slider_Max 15
label "Music Volume:"
slider ID 3_3 ATTRS MUIA_CycleChain 1 MUIA_Slider_Min 0 MUIA_Slider_Max 15
label "Gamma Correct:"
slider ID 3_4 ATTRS MUIA_CycleChain 1 MUIA_Slider_Min 0 MUIA_Slider_Max 4
label "Screen Blocks:"
slider ID 3_5 ATTRS MUIA_CycleChain 1 MUIA_Slider_Min 3 MUIA_Slider_Max 11
endgroup
group scroll ATTRS MUIA_Group_Columns 2
label "Key Right:"
poplist ID 3_20 ATTRS MUIA_CycleChain 1 labels keys
label "Key Left:"
poplist ID 3_21 ATTRS MUIA_CycleChain 1 labels keys
label "Key Up:"
poplist ID 3_22 ATTRS MUIA_CycleChain 1 labels keys
label "Key Down:"
poplist ID 3_23 ATTRS MUIA_CycleChain 1 labels keys
label "Key Strafe Left:"
poplist ID 3_24 ATTRS MUIA_CycleChain 1 labels keys
label "Key Strafe Right:"
poplist ID 3_25 ATTRS MUIA_CycleChain 1 labels keys
label "Key Fly Up:"
poplist ID 3_26 ATTRS MUIA_CycleChain 1 labels keys
label "Key Fly Down:"
poplist ID 3_27 ATTRS MUIA_CycleChain 1 labels keys
label "Key Fly Center:"
poplist ID 3_28 ATTRS MUIA_CycleChain 1 labels keys
label "Key Look Up:"
poplist ID 3_29 ATTRS MUIA_CycleChain 1 labels keys
label "Key Look Down:"
poplist ID 3_30 ATTRS MUIA_CycleChain 1 labels keys
label "Key Look Center:"
poplist ID 3_31 ATTRS MUIA_CycleChain 1 labels keys
label "Key Inv Left:"
poplist ID 3_32 ATTRS MUIA_CycleChain 1 labels keys
label "Key Inv Right:"
poplist ID 3_33 ATTRS MUIA_CycleChain 1 labels keys
label "Key Use Artifact:"
poplist ID 3_34 ATTRS MUIA_CycleChain 1 labels keys
label "Key Fire:"
poplist ID 3_35 ATTRS MUIA_CycleChain 1 labels keys
label "Key Use:"
poplist ID 3_36 ATTRS MUIA_CycleChain 1 labels keys
label "Key Strafe:"
poplist ID 3_37 ATTRS MUIA_CycleChain 1 labels keys
label "Key Speed:"
poplist ID 3_38 ATTRS MUIA_CycleChain 1 labels keys
endgroup
group scroll ATTRS MUIA_Group_Columns 2
label "ChatMacro0:"
string ID 3_80 ATTRS MUIA_CycleChain 1
label "ChatMacro1:"
string ID 3_81 ATTRS MUIA_CycleChain 1
label "ChatMacro2:"
string ID 3_82 ATTRS MUIA_CycleChain 1
label "ChatMacro3:"
string ID 3_83 ATTRS MUIA_CycleChain 1
label "ChatMacro4:"
string ID 3_84 ATTRS MUIA_CycleChain 1
label "ChatMacro5:"
string ID 3_85 ATTRS MUIA_CycleChain 1
label "ChatMacro6:"
string ID 3_86 ATTRS MUIA_CycleChain 1
label "ChatMacro7:"
string ID 3_87 ATTRS MUIA_CycleChain 1
label "ChatMacro8:"
string ID 3_88 ATTRS MUIA_CycleChain 1
label "ChatMacro9:"
string ID 3_89 ATTRS MUIA_CycleChain 1
endgroup
endgroup
endgroup
endgroup
endgroup 
group 
group REGISTER ATTRS MUIA_CycleChain 1 LABELS "About,Cheats,Credits"
group
text label "\033c\033bHereticPortal v0.7\033n\n\033cFreely Distributable Emailware\n\n\033cPlease visit my homepage:\nhttp://members.xoom.com/snorslex/\n\nPlease E-Mail me if you like/hate the program!\nSnorsleX@SoftHome.net\n\n\033r©Copyright 1999 Lorens Johansson"
endgroup
group
list ID CHEAT TITLE """\033bCheat,\033bDescription""" ATTRS MUIA_CycleChain 1 MUIA_List_Format """MIW=15 BAR,""" MUIA_List_DragSortable 1
endgroup
group
view ATTRS MUIA_CycleChain 1 string "\033c\033bCredits goes to:\n\n\033lRobert Karlsson - Beta Testing and for the name HereticPortal :)"
endgroup
endgroup
endgroup 
endgroup
group ATTRS MUIA_Group_Columns 2
label "Which Port:"
cycle ID WPORT ATTRS MUIA_CycleChain 1 help "Select which port to play!" labels "Heretic,AHeretic,AmiHeretic"
label "Buffers:"
slider ID BUFFS ATTRS MUIA_CycleChain 1 MUIA_Slider_Min 0 MUIA_Slider_Max 10000
label "Stack Size:"
slider ID STACK ATTRS MUIA_CycleChain 1 MUIA_Slider_Min 0 MUIA_Slider_Max 200000
endgroup
group ATTRS MUIA_Group_Columns 3
button ID START ATTRS MUIA_CycleChain 1 help '"Starts Heretic."' COMMAND """HereticPortal.rexx START""" label "Run Heretic"
space HORIZ
button ID QUIT ATTRS MUIA_CycleChain 1 help '"Quits HereticPortal."' COMMAND '"quit"' PORT HereticPortal label "Quit HereticPortal"
endgroup
endwindow
c.0 = 22
c.1 = "\0333quicken,God Mode"
c.2 = "\0333skel,All Keys"
c.3 = "\0333shazam,Full-Strength Weapons"
c.4 = "\0333rambo,All Weapons"
c.5 = "\0333ponce,Full Health"
c.6 = "\0333massacre,Kills all enemies on the level."
c.7 = "\0333kitty,No Clip"
c.8 = "\0333idkfa,No weapons."
c.9 = "\0333iddqd,Instant death."
c.10 = ",\033bJ:\033n Chaos Device."
c.11 = ",\033bI:\033n Wings of Wrath."
c.12 = ",\033bH:\033n Morph Ovum."
c.13 = ",\033bG:\033n Time Bomb of the Ancients."
c.14 = ",\033bF:\033n Torch."
c.15 = ",\033bE:\033n Tome of Power."
c.16 = ",\033bD:\033n Mystic Urn."
c.17 = ",\033bC:\033n Quartz Flask."
c.18 = ",\033bB:\033n Shadowsphere."
c.19 = ",\033bA:\033n Ring of Invulnerability "
c.20 = "\0333gimme#,Get Artifact. (A-J)"
c.21 = "\0333engage#?,Level Skip. #=Episode ?=Level"
c.22 = "\0333cockadoodledoo,Chicken mode."
i = 0
do c.0
i = i + 1
list ID CHEAT INSERT STRING c.i
end
call LoadSettings
return
Start:
address command "cls"
say "-) Getting info from GUI. (-"
address HereticPortal
cycle ID WPORT
WHICHPORT = result
if WHICHPORT = "Heretic" then do
popasl ID 1_PAT
FULLPATH = result
end
if WHICHPORT = "AHeretic" then do
popasl ID 2_PAT
FULLPATH = result
end
if WHICHPORT = "AmiHeretic" then do
popasl ID 3_PAT
FULLPATH = result
end
plats = pos(':',FULLPATH)
DIR = left(FULLPATH,plats)
FULLPATH = delstr(FULLPATH, 1, plats)
done = 0
do until done = 1
plats = pos('/',FULLPATH)
if plats ~= 0 then do
DIR = DIR||left(FULLPATH,plats)
FULLPATH = delstr(FULLPATH, 1, plats)
end
else do
FILE = delstr(FULLPATH, 1, plats)
done = 1
end
end
if WHICHPORT = "Heretic" then do
check ID 1_ASL
if result = 1 then FILE = FILE||" -asl"
check ID 1_BIL
if result = 1 then FILE = FILE||" -bilinear"
check ID 1_DIR
if result = 1 then FILE = FILE||" -directcgx"
check ID 1_FPS
if result = 1 then FILE = FILE||" -fps"
check ID 1_HA6
if result = 1 then FILE = FILE||" -ham6"
check ID 1_HA8
if result = 1 then FILE = FILE||" -ham8"
check ID 1_HIC
if result = 1 then FILE = FILE||" -hicolor"
check ID 1_JOY
if result = 1 then FILE = FILE||" -joy"
check ID 1_LOW
if result = 1 then FILE = FILE||" -lowdetail"
check ID 1_MOU
if result = 1 then FILE = FILE||" -mouse"
check ID 1_MUS
if result = 1 then FILE = FILE||" -music"
check ID 1_NOD
if result = 1 then FILE = FILE||" -nodoublebuffer"
check ID 1_NOS
if result = 1 then FILE = FILE||" -nosfx"
check ID 1_NOO
if result = 1 then FILE = FILE||" -nosound"
check ID 1_TUR
if result = 1 then FILE = FILE||" -turbo"
check ID 1_WIN
if result = 1 then FILE = FILE||" -window"
check ID 1_CBU
if result = 1 then do
string ID 1_SBU
FILE = FILE||" -bus "||result
end
check ID 1_CPL
if result = 1 then do
string ID 1_SPL
FILE = FILE||" -playdemo "||result
end
end
if WHICHPORT = "AmiHeretic" then do
check ID 3_BAT
if result = 1 then FILE = FILE||" -bat"
check ID 3_DBU
if result = 1 then FILE = FILE||" -dbuf"
check ID 3_GOS
if result = 1 then FILE = FILE||" -gosure"
check ID 3_MMU
if result = 1 then FILE = FILE||" -mmu"
check ID 3_MUS
if result = 1 then FILE = FILE||" -music"
check ID 3_NOS
if result = 1 then FILE = FILE||" -nosfx"
check ID 3_CHE
if result = 1 then do
string ID 3_SHE
FILE = FILE||" -height "||result
end
check ID 3_CWI
if result = 1 then do
string ID 3_SWI
FILE = FILE||" -width "||result
end
end
say "-) Changing Directory. (-"
call PRAGMA(D,DIR)
say "-) Setting Stack Value (-"
Address HereticPortal slider id STACK ATTRS MUIA_Slider_Level
newstack = result
say "-) New Stack is ["||newstack||"] (-"
call pragma(S,newstack)
say "-) Caculates Buffers (-"
parse var DIR drive ":" rest
drive = drive || ":"
address command "addbuffers "||drive||" >t:buffers"
if ~open(buff,'t:buffers',"R") then do
say "-» Something went wrong when adding buffers to "||drive||" «-"
exit
end
buffers = readln(buff)
buffers = word(buffers,3)
call close(buff)
address command "delete t:buffers <>NIL: quiet"
say "-) There is "||buffers||" buffers on "||drive||" (-"
Address HereticPortal slider id BUFFS ATTRS MUIA_Slider_Level
newbuff = result
buffchange = newbuff - buffers
if buffchange > 0 then do
say "-) Needs to add "||buffchange||" buffers to "||drive||" (-"
say "-) Adding buffers. (-"
end
if buffchange < 0 then do
say "-) Needs to remove "||abs(buffchange)||" buffers from "||drive||" (-"
say "-) Removing buffers. (-"
end
address command "addbuffers "||drive buffchange||" >NIL:"
say "-) The commandline is ["||FILE||"] (-"
say "-) Launching "||WHICHPORT||". (-"
say ""
address command FILE
return
LoadSettings:
if open(set,'HereticPortal.prefs',"R") then do
address HereticPortal
call readln(set)
check ID 1_ASL ATTRS MUIA_Selected result
call readln(set)
check ID 1_BIL ATTRS MUIA_Selected result
call readln(set)
check ID 1_DIR ATTRS MUIA_Selected result
call readln(set)
check ID 1_FPS ATTRS MUIA_Selected result
call readln(set)
check ID 1_HA6 ATTRS MUIA_Selected result
call readln(set)
check ID 1_HA8 ATTRS MUIA_Selected result
call readln(set)
check ID 1_HIC ATTRS MUIA_Selected result
call readln(set)
check ID 1_JOY ATTRS MUIA_Selected result
call readln(set)
check ID 1_LOW ATTRS MUIA_Selected result
call readln(set)
check ID 1_MOU ATTRS MUIA_Selected result
call readln(set)
check ID 1_MUS ATTRS MUIA_Selected result
call readln(set)
check ID 1_NOD ATTRS MUIA_Selected result
call readln(set)
check ID 1_NOS ATTRS MUIA_Selected result
call readln(set)
check ID 1_NOO ATTRS MUIA_Selected result
call readln(set)
check ID 1_TUR ATTRS MUIA_Selected result
call readln(set)
check ID 1_WIN ATTRS MUIA_Selected result
call readln(set)
chk = result
if chk = 0 then string ID 1_SBU ATTRS MUIA_Disabled 1
check ID 1_CBU ATTRS MUIA_Selected chk
call readln(set)
string ID 1_SBU content result
call readln(set)
chk = result
if chk = 0 then string ID 1_SPL ATTRS MUIA_Disabled 1
check ID 1_CPL ATTRS MUIA_Selected chk
call readln(set)
string ID 1_SPL content result
call readln(set)
check ID 3_BAT ATTRS MUIA_Selected result
call readln(set)
check ID 3_DBU ATTRS MUIA_Selected result
call readln(set)
check ID 3_GOS ATTRS MUIA_Selected result
call readln(set)
check ID 3_MMU ATTRS MUIA_Selected result
call readln(set)
check ID 3_MUS ATTRS MUIA_Selected result
call readln(set)
check ID 3_NOS ATTRS MUIA_Selected result
call readln(set)
chk = result
if chk = 0 then string ID 3_SHE ATTRS MUIA_Disabled 1
check ID 3_CHE ATTRS MUIA_Selected chk
call readln(set)
string ID 3_SHE content result
call readln(set)
chk = result
if chk = 0 then string ID 3_SWI ATTRS MUIA_Disabled 1
check ID 3_CWI ATTRS MUIA_Selected chk
call readln(set)
string ID 3_SWI content result
call readln(set)
cycle ID WPORT ATTRS MUIA_Cycle_Active result
call readln(set)
slider ID BUFFS ATTRS MUIA_Slider_Level result
call readln(set)
slider ID STACK ATTRS MUIA_Slider_Level result
call readln(set)
popasl ID 1_PAT content result
call readln(set)
popasl ID 2_PAT content result
call readln(set)
popasl ID 3_PAT content result
call close(set)
end
else say "Could not find HereticPortal.Prefs"
return
SaveSettings:
call open(set,'HereticPortal.prefs',"W")
address HereticPortal
check ID 1_ASL
call writeln(set,result)
check ID 1_BIL
call writeln(set,result)
check ID 1_DIR
call writeln(set,result)
check ID 1_FPS
call writeln(set,result)
check ID 1_HA6
call writeln(set,result)
check ID 1_HA8
call writeln(set,result)
check ID 1_HIC
call writeln(set,result)
check ID 1_JOY
call writeln(set,result)
check ID 1_LOW
call writeln(set,result)
check ID 1_MOU
call writeln(set,result)
check ID 1_MUS
call writeln(set,result)
check ID 1_NOD
call writeln(set,result)
check ID 1_NOS
call writeln(set,result)
check ID 1_NOO
call writeln(set,result)
check ID 1_TUR
call writeln(set,result)
check ID 1_WIN
call writeln(set,result)
check ID 1_CBU
call writeln(set,result)
string ID 1_SBU
call writeln(set,result)
check ID 1_CPL
call writeln(set,result)
string ID 1_SPL
call writeln(set,result)
check ID 3_BAT
call writeln(set,result)
check ID 3_DBU
call writeln(set,result)
check ID 3_GOS
call writeln(set,result)
check ID 3_MMU
call writeln(set,result)
check ID 3_MUS
call writeln(set,result)
check ID 3_NOS
call writeln(set,result)
check ID 3_CHE
call writeln(set,result)
string ID 3_SHE
call writeln(set,result)
check ID 3_CWI
call writeln(set,result)
string ID 3_SWI
call writeln(set,result)
cycle ID WPORT
WhichP = result
if WhichP = "Heretic" then call writeln(set,"0")
if WhichP = "AHeretic" then call writeln(set,"1")
if WhichP = "AmiHeretic" then call writeln(set,"2")
slider ID BUFFS
call writeln(set,result)
slider ID STACK
call writeln(set,result)
popasl ID 1_PAT
call writeln(set,result)
popasl ID 2_PAT
call writeln(set,result)
popasl ID 3_PAT
call writeln(set,result)
call close(set)
return
Tags:
MUIA_Application_Sleep = 0x80425711
MUIA_AppMessage = 0x80421955
MUIA_CycleChain = 0x80421ce7
MUIA_Disabled = 0x80423661
MUIA_Group_Columns = 0x8042f416
MUIA_Group_Horiz = 0x8042536b
MUIA_Group_Rows = 0x8042b68f
MUIA_List_DragSortable = 0x80426099
MUIA_List_Format = 0x80423c0a
MUIA_Menuitem_Shortcut = 0x80422030
MUIA_Menuitem_Title = 0x804218be
MUIA_Radio_Active = 0x80429b41
MUIA_Selected = 0x8042654b
MUIA_Slider_Level = 0x8042ae3a
MUIA_Slider_Max = 0x8042d78a
MUIA_Slider_Min = 0x8042e404
MUIA_String_Contents = 0x80428ffd
MUIA_Weight = 0x80421d1f
MUIA_Window_ScreenTitle = 0x804234b0
MUIM_Application_AboutMUI = 0x8042d21d
MUIM_Application_OpenConfigWindow = 0x804299ba
R='0A'X
keys = "9-Tab,13-Return/Enter,27-Escape,29-*UNKNOWN*,31-*UNKNOWN*,32-Space,39-',42-Num_*,43-+/Num_+,44-Comma,45-Minus/Num_Minus,46-./Num_.,47-Num_/,48-0,49-1,50-2,51-3,52-4,53-5,54-6,55-7,56-8,57-9,60-<,61-*UNKNOWN*,63-*UNKNOWN*,64-*UNKNOWN*,68-*UNKNOWN*,71-Num_6,73-Num_9,79-Num_4,81-Num_7,82-Num_3,83-Num_1,90-*UNKNOWN*,91-*UNKNOWN*,92-Backslash,93-*UNKNOWN*,96-~,97-A,98-B,99-C,100-D,101-E,102-F,103-G,104-H,105-I,106-J,107-K,108-L,109-M,110-N,111-O,112-P,113-Q,114-R,115-S,116-T,117-U,118-V,119-W,120-X,121-Y,122-Z,157-Ctrl/Right_Amiga,172-Cursor_Left,173-Cursor_Up,174-Cursor_Right,175-Cursor_Down,182-Shift,184-Alt,"
Return 0
Config:
WINDID = arg(2)
address HereticPortal
popasl ID WINID||PAT
PATH = result
plats = pos(':',PATH)
DIR = left(PATH,plats)
PATH = delstr(PATH, 1, plats)
done = 0
do until done = 1
plats = pos('/',PATH)
if plats ~= 0 then do
DIR = DIR||left(PATH,plats)
PATH = delstr(PATH, 1, plats)
end
else done = 1
end
if ~exists(DIR||"Heretic.cfg") then do
say "Could not find Heretic.cfg, either it does not exists or the path to Heretic is wrong!"
return
end
address HereticPortal
button ID WINID||GLO ATTRS MUIA_Disabled 1
button ID WINID||GSA ATTRS MUIA_Disabled 1
call open(file,DIR||"Heretic.cfg","R")
i = 1
do until eof(file)
line.i = readln(file)
i = i + 1
end
line.0 = i - 1
if arg(1) = "Load" then lors = "L"
if arg(1) = "Save" then lors = "S"
call ch("mouse_sensitivity",WINID||1,lors,s)
call ch("sfx_volume",WINID||2,lors,s)
call ch("music_volume",WINID||3,lors,s)
call ch("usegamma",WINID||4,lors,s)
call ch("screenblocks",WINID||5,lors,s)
if lors = "L" then do
call ch("key_right",WINID||20,lors,"key")
call LoadKey(result,WINID||20)
call ch("key_left",WINID||21,lors,"key")
call LoadKey(result,WINID||21)
call ch("key_up",WINID||22,lors,"key")
call LoadKey(result,WINID||22)
call ch("key_down",WINID||23,lors,"key")
call LoadKey(result,WINID||23)
call ch("key_strafeleft",WINID||24,lors,"key")
call LoadKey(result,WINID||24)
call ch("key_straferight",WINID||25,lors,"key")
call LoadKey(result,WINID||25)
call ch("key_flyup",WINID||26,lors,"key")
call LoadKey(result,WINID||26)
call ch("key_flydown",WINID||27,lors,"key")
call LoadKey(result,WINID||27)
call ch("key_flycenter",WINID||28,lors,"key")
call LoadKey(result,WINID||28)
call ch("key_lookup",WINID||29,lors,"key")
call LoadKey(result,WINID||29)
call ch("key_lookdown",WINID||30,lors,"key")
call LoadKey(result,WINID||30)
call ch("key_lookcenter",WINID||31,lors,"key")
call LoadKey(result,WINID||31)
call ch("key_invleft",WINID||32,lors,"key")
call LoadKey(result,WINID||32)
call ch("key_invright",WINID||33,lors,"key")
call LoadKey(result,WINID||33)
call ch("key_useartifact",WINID||34,lors,"key")
call LoadKey(result,WINID||34)
call ch("key_fire",WINID||35,lors,"key")
call LoadKey(result,WINID||35)
call ch("key_use",WINID||36,lors,"key")
call LoadKey(result,WINID||36)
call ch("key_strafe",WINID||37,lors,"key")
call LoadKey(result,WINID||37)
call ch("key_speed",WINID||38,lors,"key")
call LoadKey(result,WINID||38)
end
if lors = "S" then do
call SaveKey(WINID||20)
call ch("key_right",WINID||20,lors,result)
call SaveKey(WINID||21)
call ch("key_left",WINID||21,lors,result)
call SaveKey(WINID||22)
call ch("key_up",WINID||22,lors,result)
call SaveKey(WINID||23)
call ch("key_down",WINID||23,lors,result)
call SaveKey(WINID||24)
call ch("key_strafeleft",WINID||24,lors,result)
call SaveKey(WINID||25)
call ch("key_straferight",WINID||25,lors,result)
call SaveKey(WINID||26)
call ch("key_flyup",WINID||26,lors,result)
call SaveKey(WINID||27)
call ch("key_flydown",WINID||27,lors,result)
call SaveKey(WINID||28)
call ch("key_flycenter",WINID||28,lors,result)
call SaveKey(WINID||29)
call ch("key_lookup",WINID||29,lors,result)
call SaveKey(WINID||30)
call ch("key_lookdown",WINID||30,lors,result)
call SaveKey(WINID||31)
call ch("key_lookcenter",WINID||31,lors,result)
call SaveKey(WINID||32)
call ch("key_invleft",WINID||32,lors,result)
call SaveKey(WINID||33)
call ch("key_invright",WINID||33,lors,result)
call SaveKey(WINID||34)
call ch("key_useartifact",WINID||34,lors,result)
call SaveKey(WINID||35)
call ch("key_fire",WINID||35,lors,result)
call SaveKey(WINID||36)
call ch("key_use	",WINID||36,lors,result)
call SaveKey(WINID||37)
call ch("key_strafe	",WINID||37,lors,result)
call SaveKey(WINID||38)
call ch("key_speed",WINID||38,lors,result)
end
call ch("chatmacro0",WINID||80,lors)
call ch("chatmacro1",WINID||81,lors)
call ch("chatmacro2",WINID||82,lors)
call ch("chatmacro3",WINID||83,lors)
call ch("chatmacro4",WINID||84,lors)
call ch("chatmacro5",WINID||85,lors)
call ch("chatmacro6",WINID||86,lors)
call ch("chatmacro7",WINID||87,lors)
call ch("chatmacro8",WINID||88,lors)
call ch("chatmacro9",WINID||89,lors)
call close(file)
call open(file,DIR||"Heretic.cfg",W)
i = 1
do until i = line.0
call writeln(file,line.i)
i = i + 1
end
call close(file)
address HereticPortal
button ID WINID||GLO ATTRS MUIA_Disabled 0
button ID WINID||GSA ATTRS MUIA_Disabled 0
return 0
LoadKey:
sak = arg(1)
plats = pos(""||sak||"",keys)
if plats ~= 0 then do
len = length(keys)
antal = len - plats + 1
keyjox = right(keys,antal)
sak = right(keys,antal)
sak = left(sak,pos(',',sak)-1)
end
poplist ID stringid content sak
return
SaveKey:
stringid = arg(1)
poplist ID stringid
sak = result
plats = pos(sak,keys)
len = length(keys)
antal = len - plats + 1
sak = right(keys,antal)
nysak = left(sak,pos('-',sak)-1)
return(nysak)
ch:
searchingfor = arg(1)
stringid = arg(2)
saveorload = arg(3)
ischat = pos("chatmacro",searchingfor)
type = arg(4)
key = ""
i = 1
do until i = line.0
if upper(left(line.i,length(searchingfor))) = upper(searchingfor) then do
if  ischat then parse var line.i RUBBISH '"' setting '"'
if ~ischat then parse var line.i RUBBISH "	" setting
if ~ischat then setting = Compress(setting,"	, ")
WASATLINE = i
if saveorload = "L" then do
select
when type = "S" then Address HereticPortal slider ID stringid ATTRS MUIA_Slider_Level setting
when type = "C" then Address HereticPortal cycle ID stringid ATTRS MUIA_Cycle_Active setting
when type = "key" then key = setting
otherwise Address HereticPortal string ID stringid content Setting
end
end
if saveorload = "S" then do
select
when type = "S" then address HereticPortal slider ID stringid
when type = "C" then address HereticPortal cycle ID stringid
when type = "key" then address HereticPortal poplist ID stringid
otherwise Address HereticPortal string ID stringid
end
changeto=result
if searchingfor = "key_use	" then searchingfor = "key_use"
if searchingfor = "key_strafe	" then searchingfor = "key_strafe"
if ~ischat then line.i = searchingfor"		"changeto
if ischat then line.i = searchingfor"		"'"'changeto'"'
end
end
i = i + 1
end
return(key)
