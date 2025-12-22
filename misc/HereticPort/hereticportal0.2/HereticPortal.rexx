/* $VER: HereticPortal.rexx 0.2 (1999-02-01) */
options results

libs = "rexxsupport.library rexxtricks.library"
DO UNTIL libs='';PARSE VAR libs lib libs
IF EXISTS('libs:'lib)|EXISTS('Libs/'lib)|EXISTS(lib) THEN DO
IF ~show('L',lib) THEN call addlib(lib,0,-30,0);END;ELSE DO
Say 'Library Error. Unable to open 'lib
address HereticPortal ;quit
END;END

call Tags
SELECT
WHEN arg(1)="START" then call Start
WHEN arg(1)="CFGLOAD" then call Config_Heretic("Load")
WHEN arg(1)="CFGSAVE" then call Config_Heretic("Save")
WHEN arg(1)="LOADSETTINGS" then call LoadSettings
WHEN arg(1)="SAVESETTINGS" then call SaveSettings
 OTHERWISE call Init
end
exit

Init:
address HereticPortal
window ID DOOM TITLE '"HereticPortal v0.2"' COMMAND '"quit"' PORT HereticPortal ATTRS MUIA_Window_ScreenTitle '"HereticPortal 0.2 ©1999 Lorens Johansson Freely Distributable Emailware"'
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

 text help '"HereticPortal v0.2 by\nLorens Johansson (http://members.xoom.com/snorslex)\nIf you use this program, you are required to\nEmail the author (SnorsleX@SoftHome.net). Otherwise,\nhow is he supposed to know to keep supporting\nHereticPortal ?!?\n\033rLorens Johansson"' label "\033c\033bHereticPortal v0.2\033n\n\033cLorens Johansson\n\033cFreely Distributable Emailware"

 group REGISTER ATTRS MUIA_CycleChain 1 LABELS "Heretic (68k&PPC),AHeretic (68k),AmiHeretic (PPC),Information"

  group /* Heretic */
   group REGISTER ATTRS MUIA_CycleChain 1 LABELS "Main,Settings"
    group /* Main */
     group frame ATTRS MUIA_Group_Columns 8 label "Parameters"
      label "-asl"
      check ID C_ASL ATTRS MUIA_CycleChain 1 HELP '"Use asl requester to select screen mode defsult is PAL|LORES (in PPC version you will see other screen modes than lores, but please DO NOT select other resolution than 320*xxx)."'
      label "-directcgx"
      check ID C_DIR ATTRS MUIA_CycleChain 1 HELP '"Use fast copy routines instead of writepixel array does not work with window mode."'
      label "-fps"
      check ID C_FPS ATTRS MUIA_CycleChain 1 HELP '"Shows online fps counter."'
      label "-mouse"
      check ID C_MOU ATTRS MUIA_CycleChain 1 HELP '"Turns mouse on."'
      label "-music"
      check ID C_MUS ATTRS MUIA_CycleChain 1 HELP '"Enables music."'
      label "-nodoublebuffer"
      check ID C_NOD ATTRS MUIA_CycleChain 1 HELP '"Turns off double buffering."'
      label "-nosfx"
      check ID C_NOS ATTRS MUIA_CycleChain 1 HELP '"Disables sound fx effects."'
      label "-nosound"
      check ID C_NOO ATTRS MUIA_CycleChain 1 HELP '"Disables music and sfx (no sound at all)."'
      label "-window"
      check ID C_WIN ATTRS MUIA_CycleChain 1 HELP '"Display results in window on workbench screen workbench must have least 15 bit depth doublebuffering does not work on window."'
     endgroup
     space
     group ATTRS MUIA_Group_Columns 2
      label "Heretic Path:"
      popasl ID HPATH ATTRS MUIA_CycleChain 1 HELP '"Select the Heretic executable!"'
     endgroup
    endgroup /* Main */

    group /* Settings */
     group frame ATTRS MUIA_Group_Columns 2 label "Heretic.cfg"
      button ID CFGLO ATTRS MUIA_CycleChain 1 command """HereticPortal.rexx CFGLOAD""" label "Load Heretic.cfg"
      button ID CFGSA ATTRS MUIA_CycleChain 1 command """HereticPortal.rexx CFGSAVE""" label "Save Heretic.cfg"
     endgroup

     group REGISTER ATTRS MUIA_CycleChain 1 LABELS "Misc,Keys"
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
      group scroll ATTRS MUIA_Group_Columns 2 MUIA_Disabled 1
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
     endgroup
    endgroup /* Settings */
   endgroup
  endgroup

  group /* AHeretic */
   group REGISTER ATTRS MUIA_CycleChain 1 LABELS "Main,Settings"
    group /* Main */
     group ATTRS MUIA_Group_Columns 2
      label "AHeretic Path:"
      popasl ID AHPAT ATTRS MUIA_CycleChain 1 HELP '"Select the AHeretic executable!"'
     endgroup
    endgroup /* Main */
    group /* Settings */
     label "Coming soon..."
    endgroup /* Settings */
   endgroup
  endgroup /* AHeretic */

  group /* AmiHeretic */
   group REGISTER ATTRS MUIA_CycleChain 1 LABELS "Main,Settings"
    group /* Main */
     group ATTRS MUIA_Group_Columns 2
      label "AmiHeretic Path:"
      popasl ID AMHPA ATTRS MUIA_CycleChain 1 HELP '"Select the AmiHeretic executable!"'
     endgroup
    endgroup /* Main */
    group /* Settings */
     label "Coming soon..."
    endgroup /* Settings */
   endgroup
  endgroup /* AmiHeretic */

  group /* Information */
   group REGISTER ATTRS MUIA_CycleChain 1 LABELS "About,Cheats,Credits"
    group /* About */
     text label "\033c\033bHereticPortal v0.2\033n\n\033cFreely Distributable Emailware\n\n\033cPlease visit my homepage:\nhttp://members.xoom.com/snorslex/\n\nPlease E-Mail me if you like/hate the program!\nSnorsleX@SoftHome.net\n\n\033r©Copyright 1999 Lorens Johansson"
    endgroup /* About */
    group /* Cheats */
     list ID CHEAT TITLE """\033bCheat,\033bDescription""" ATTRS MUIA_CycleChain 1 MUIA_List_Format """MIW=15 BAR,""" MUIA_List_DragSortable 1
    endgroup /* Cheats */
    group /* Credits */
     view ATTRS MUIA_CycleChain 1 string "\033c\033bCredits goes to:\n\n\033lRobert Karlsson - Beta Testing and for the name HereticPortal :)"
    endgroup /* Credits */
   endgroup
  endgroup /* Information */

 endgroup

 group ATTRS MUIA_Group_Columns 2
  label "Which Port:"
  cycle ID WPORT ATTRS MUIA_CycleChain 1 help "Select which port to play!" labels "Heretic,AHeretic,AmiHeretic"
  label "Buffers:"
  slider ID BUFFS ATTRS MUIA_CycleChain 1 MUIA_Slider_Min 0 MUIA_Slider_Max 10000
 endgroup

 group ATTRS MUIA_Group_Columns 3
  button ID START ATTRS MUIA_CycleChain 1 help '"Starts Heretic."' COMMAND """HereticPortal.rexx START""" label "Run Heretic"
  space HORIZ
  button ID QUIT ATTRS MUIA_CycleChain 1 help '"Quits HereticPortal."' COMMAND '"quit"' PORT HereticPortal label "Quit HereticPortal"
 endgroup
endwindow
listline.0 = 22
listline.1 = "\0333quicken,God Mode"
listline.2 = "\0333skel,All Keys"
listline.3 = "\0333shazam,Full-Strength Weapons"
listline.4 = "\0333rambo,All Weapons"
listline.5 = "\0333ponce,Full Health"
listline.6 = "\0333massacre,Kills all enemies on the level."
listline.7 = "\0333kitty,No Clip"
listline.8 = "\0333idkfa,No weapons."
listline.9 = "\0333iddqd,Instant death."
listline.10 = ",\033bJ:\033n Chaos Device."
listline.11 = ",\033bI:\033n Wings of Wrath."
listline.12 = ",\033bH:\033n Morph Ovum."
listline.13 = ",\033bG:\033n Time Bomb of the Ancients."
listline.14 = ",\033bF:\033n Torch."
listline.15 = ",\033bE:\033n Tome of Power."
listline.16 = ",\033bD:\033n Mystic Urn."
listline.17 = ",\033bC:\033n Quartz Flask."
listline.18 = ",\033bB:\033n Shadowsphere."
listline.19 = ",\033bA:\033n Ring of Invulnerability "
listline.20 = "\0333gimme#,Get Artifact. (A-J)"
listline.21 = "\0333engage#?,Level Skip. #=Episode ?=Level"
listline.22 = "\0333cockadoodledoo,Chicken mode."
i = 0
do listline.0
 i = i + 1
 list ID CHEAT INSERT STRING listline.i
end
call LoadSettings
return

Start:
say "-) Getting info from GUI. (-"
address HereticPortal
cycle ID WPORT
WHICHPORT = result
if WHICHPORT = "Heretic" then do
 popasl ID HPATH
 FULLPATH = result
end
if WHICHPORT = "AHeretic" then do
 popasl ID AHPAT
 FULLPATH = result
end
if WHICHPORT = "AmiHeretic" then do
 popasl ID AMHPA
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
 check ID C_ASL
 if result = 1 then  FILE = FILE||" -asl"
 check ID C_DIR
 if result = 1 then FILE = FILE||" -directcgx"
 check ID C_FPS
 if result = 1 then FILE = FILE||" -fps"
 check ID C_MOU
 if result = 1 then FILE = FILE||" -mouse"
 check ID C_MUS
 if result = 1 then FILE = FILE||" -music"
 check ID C_NOD
 if result = 1 then FILE = FILE||" -nodoublebuffer"
 check ID C_NOS
 if result = 1 then FILE = FILE||" -nosfx"
 check ID C_NOO
 if result = 1 then FILE = FILE||" -nosound"
 check ID C_WIN
 if result = 1 then FILE = FILE||" -window"
end
say "-) Changing Directory. (-"
call PRAGMA(D,DIR)
/*
say "-) Setting Stack Value (-"
Address HereticPortal knob id STAC ATTRS MUIA_Slider_Level
newstack = result
say "-) New Stack is ["newstack"] (-"
call pragma(S,newstack)
*/
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
if WHICHPORT = "Heretic" then do
 say "-) Launching Heretic. (-"
end
if WHICHPORT = "AHeretic" then do
 say "-) Launching AHeretic. (-"
end
if WHICHPORT = "AmiHeretic" then do
 say "-) Launching AmiHeretic. (-"
end
say ""
address command FILE
return

LoadSettings:
if open(set,'HereticPortal.prefs',"R") then do
 address HereticPortal
 call readln(set)
 check ID C_ASL ATTRS MUIA_Selected result
 call readln(set)
 check ID C_DIR ATTRS MUIA_Selected result
 call readln(set)
 check ID C_FPS ATTRS MUIA_Selected result
 call readln(set)
 check ID C_MOU ATTRS MUIA_Selected result
 call readln(set)
 check ID C_MUS ATTRS MUIA_Selected result
 call readln(set)
 check ID C_NOD ATTRS MUIA_Selected result
 call readln(set)
 check ID C_NOS ATTRS MUIA_Selected result
 call readln(set)
 check ID C_NOO ATTRS MUIA_Selected result
 call readln(set)
 check ID C_WIN ATTRS MUIA_Selected result
 call readln(set)
 cycle ID WPORT ATTRS MUIA_Cycle_Active result
 call readln(set)
 slider ID BUFFS ATTRS MUIA_Slider_Level result
 call readln(set)
 popasl ID HPATH content result
 call readln(set)
 popasl ID AHPAT content result
 call readln(set)
 popasl ID AMHPA content result
 call close(set)
end
else say "Could not find HereticPortal.Prefs"
return

SaveSettings:
call open(set,'HereticPortal.prefs',"W")
 address HereticPortal
 check ID C_ASL
 call writeln(set,result)
 check ID C_DIR
 call writeln(set,result)
 check ID C_FPS
 call writeln(set,result)
 check ID C_MOU
 call writeln(set,result)
 check ID C_MUS
 call writeln(set,result)
 check ID C_NOD
 call writeln(set,result)
 check ID C_NOS
 call writeln(set,result)
 check ID C_NOO
 call writeln(set,result)
 check ID C_WIN
 call writeln(set,result)
 cycle ID WPORT
 WhichP = result
 if WhichP = "Heretic" then call writeln(set,"0")
 if WhichP = "AHeretic" then call writeln(set,"1")
 if WhichP = "AmiHeretic" then call writeln(set,"2")
 slider ID BUFFS
 call writeln(set,result)
 popasl ID HPATH
 call writeln(set,result)
 popasl ID AHPAT
 call writeln(set,result)
 popasl ID AMHPA
 call writeln(set,result)
call close(set)
return

Tags:
MUIA_Application_Sleep = 0x80425711
MUIA_AppMessage = 0x80421955
MUIA_ControlChar = 0x8042120b
MUIA_Cycle_Active = 0x80421788
MUIA_CycleChain = 0x80421ce7
MUIA_Disabled = 0x80423661
MUIA_Dropable = 0x8042fbce
MUIA_FillArea = 0x804294a3
MUIA_Gauge_Current = 0x8042f0dd
MUIA_Gauge_Divide = 0x8042d8df
MUIA_Gauge_Horiz =0x804232dd
MUIA_Gauge_InfoText = 0x8042bf15
MUIA_Gauge_Max = 0x8042bcdb
MUIA_Group_Columns = 0x8042f416
MUIA_Group_Horiz = 0x8042536b
MUIA_Group_Rows = 0x8042b68f
MUIA_List_Active = 0x8042391c
MUIA_List_AutoVisible = 0x8042a445
MUIA_List_DragSortable = 0x80426099
MUIA_List_DropMark = 0x8042aba6
MUIA_List_Entries = 0x80421654
MUIA_List_First = 0x804238d4
MUIA_List_Format = 0x80423c0a
MUIA_List_InsertPosition = 0x8042d0cd
MUIA_List_MinLineHeight = 0x8042d1c3
MUIA_List_Quiet = 0x8042d8c7
MUIA_List_Title = 0x80423e66
MUIA_List_Visible = 0x8042191f
MUIA_Menuitem_Checked = 0x8042562a
MUIA_Menuitem_Checkit = 0x80425ace
MUIA_Menuitem_Enabled = 0x8042ae0f
MUIA_Menuitem_Exclude = 0x80420bc6
MUIA_Menuitem_Shortcut = 0x80422030
MUIA_Menuitem_Title = 0x804218be
MUIA_Menuitem_Toggle = 0x80424d5c
MUIA_Numeric_Default = 0x804263e8
MUIA_Numeric_Format = 0x804263e9
MUIA_Numeric_Max = 0x8042d78a
MUIA_Numeric_Min = 0x8042e404
MUIA_Numeric_Reverse = 0x8042f2a0
MUIA_Numeric_RevLeftRight = 0x804294a7
MUIA_Numeric_RevUpDown = 0x804252dd
MUIA_Numeric_Value = 0x8042ae3a
MUIA_Radio_Active = 0x80429b41
MUIA_Selected = 0x8042654b
MUIA_ShowMe = 0x80429ba8
MUIA_Slider_Horiz = 0x8042fad1
MUIA_Slider_Level = 0x8042ae3a
MUIA_Slider_Max = 0x8042d78a
MUIA_Slider_Min = 0x8042e404
MUIA_String_Contents = 0x80428ffd
MUIA_Weight = 0x80421d1f
MUIA_Window_Activate = 0x80428d2f
MUIA_Window_AppWindow = 0x804280cf
MUIA_Window_Backdrop = 0x8042c0bb
MUIA_Window_Borderless = 0x80429b79
MUIA_Window_DepthGadget = 0x80421923
MUIA_Window_DragBar = 0x8042045d
MUIA_Window_Height = 0x80425846
MUIA_Window_IsSubWindow = 0x8042b5aa
MUIA_Window_NoMenus = 0x80429df5
MUIA_Window_Open = 0x80428aa0
MUIA_Window_PublicScreen = 0x804278e4
MUIA_Window_ScreenTitle = 0x804234b0
MUIA_Window_SizeGadget = 0x8042e33d
MUIA_Window_Sleep = 0x8042e7db

MUIM_Application_AboutMUI = 0x8042d21d
MUIM_Application_OpenConfigWindow = 0x804299ba
MUIM_NoNotifySet = 0x8042216f
MUIM_Notify = 0x8042c9cb
MUIM_Set = 0x8042549a

MUIV_EveryTime = 0x49893131
MUIV_TriggerValue = 0x49893131

TRUE = 1
FALSE = 0
R='0A'X
keys = "9-Tab,13-Return,27-Escape,39-',43-+,45-(Minus),46-.,47-?????,48-0,49-1,50-2,51-3,52-4,53-5,54-6,55-7,56-8,57-9,61-(Equals),71-?????,73-?????,79-Num_4,81-Num_7,82-?????,83-Num_1,91-?????,92-Backslash,93-?????,97-A,98-B,99-C,100-D,101-E,102-F,103-G,104-H,105-I,106-J,107-K,108-L,109-M,110-N,111-O,112-P,113-Q,114-R,115-S,116-T,117-U,118-V,119-W,120-X,121-Y,122-Z,127-Backspace,157-CTRL,172-Cursor_Left,173-Cursor_Up,174-Cursor_Right,175-Cursor_Down,182-Right_Shift,183-Left_Shift,184-Right_Alt,185-Left_Alt,187-F1,188-F2,189-F3,190-F4,191-F5,192-F6,193-F7,194-F8,195-F9,196-F10,217-Left_Amiga,218-Right_Amiga,219-Del,220-Help,221-Num_7,222-Num_8,223-Num_9,224-Num_4,225-Num_5,226-Num_6,227-Num_1,228-Num_2,229-Num_3,230-Num_0,231-Num_.,232-Num_Enter,233-Num_(,234-Num_)"
Return 0

Config_Heretic:
 address HereticPortal
 popasl ID HPATH
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
  say "Heretic.cfg was not found! Looked in: "||DIR
  return
 end

 address HereticPortal
 button ID CFGLO ATTRS MUIA_Disabled 1
 button ID CFGSA ATTRS MUIA_Disabled 1

 call open(file,DIR||"Heretic.cfg","R")

 i = 1
 do until eof(file)
  line.i = readln(file)
  i = i + 1
 end

 line.0 = i - 1

 if arg(1) = "Load" then lors = "L"
 if arg(1) = "Save" then lors = "S"

 call ch("mouse_sensitivity",1_1,lors,s)
 call ch("sfx_volume",1_2,lors,s)
 call ch("music_volume",1_3,lors,s)
 call ch("usegamma",1_4,lors,s)
 call ch("screenblocks",1_5,lors,s)
/*
 if lors = "L" then do
  call ch("key_right",1_20,lors,"key")
  call LoadKey(result,"1_20")
  call ch("key_left",1_21,lors,"key")
  call LoadKey(result,"1_21")
  call ch("key_up",1_22,lors,"key")
  call LoadKey(result,"1_22")
  call ch("key_down",1_23,lors,"key")
  call LoadKey(result,"1_23")
  call ch("key_strafeleft",1_24,lors,"key")
  call LoadKey(result,"1_24")
  call ch("key_straferight",1_25,lors,"key")
  call LoadKey(result,"1_25")
  call ch("key_flyup",1_26,lors,"key")
  call LoadKey(result,"1_26")
  call ch("key_flydown",1_27,lors,"key")
  call LoadKey(result,"1_27")
  call ch("key_flycenter",1_28,lors,"key")
  call LoadKey(result,"1_28")
  call ch("key_lookup",1_29,lors,"key")
  call LoadKey(result,"1_29")
  call ch("key_lookdown",1_30,lors,"key")
  call LoadKey(result,"1_30")
  call ch("key_lookcenter",1_31,lors,"key")
  call LoadKey(result,"1_31")
  call ch("key_invleft",1_32,lors,"key")
  call LoadKey(result,"1_32")
  call ch("key_invright",1_33,lors,"key")
  call LoadKey(result,"1_33")
  call ch("key_useartifact",1_34,lors,"key")
  call LoadKey(result,"1_34")
  call ch("key_fire",1_35,lors,"key")
  call LoadKey(result,"1_35")
  call ch("key_use",1_36,lors,"key")
  call LoadKey(result,"1_36")
  call ch("key_strafe",1_37,lors,"key")
  call LoadKey(result,"1_37")
  call ch("key_speed",1_38,lors,"key")
  call LoadKey(result,"1_38")
 end
 if lors = "S" then do
  call SaveKey("1_20")
  call ch("key_right",1_20,lors,"key")
  call SaveKey("1_21")
  call ch("key_left",1_21,lors,"key")
  call SaveKey("1_22")
  call ch("key_up",1_22,lors,"key")
  call SaveKey("1_23")
  call ch("key_down",1_23,lors,"key")
  call SaveKey("1_24")
  call ch("key_strafeleft",1_24,lors,"key")
  call SaveKey("1_25")
  call ch("key_straferight",1_25,lors,"key")
  call SaveKey("1_26")
  call ch("key_flyup",1_26,lors,"key")
  call SaveKey("1_27")
  call ch("key_flydown",1_27,lors,"key")
  call SaveKey("1_28")
  call ch("key_flycenter",1_28,lors,"key")
  call SaveKey("1_29")
  call ch("key_lookup",1_29,lors,"key")
  call SaveKey("1_30")
  call ch("key_lookdown",1_30,lors,"key")
  call SaveKey("1_31")
  call ch("key_lookcenter",1_31,lors,"key")
  call SaveKey("1_32")
  call ch("key_invleft",1_32,lors,"key")
  call SaveKey("1_33")
  call ch("key_invright",1_33,lors,"key")
  call SaveKey("1_34")
  call ch("key_useartifact",1_34,lors,"key")
  call SaveKey("1_35")
  call ch("key_fire",1_35,lors,"key")
  call SaveKey("1_36")
  call ch("key_use",1_36,lors,"key")
  call SaveKey("1_37")
  call ch("key_strafe",1_37,lors,"key")
  call SaveKey("1_38")
  call ch("key_speed",1_38,lors,"key")
 end
*/
 call close(file)

 call open(file,DIR||"Heretic.cfg",W)

 i = 1
 do until i = line.0
  call writeln(file,line.i)
  i = i + 1
 end

 call close(file)

 address HereticPortal
 button ID CFGLO ATTRS MUIA_Disabled 0
 button ID CFGSA ATTRS MUIA_Disabled 0
return 0

LoadKey:
 sak = arg(1)
 plats = pos(""||sak||"",keys)
 len = length(keys)
 antal = len - plats + 1
 keyjox = right(keys,antal)
 sak = right(keys,antal)
 sak = left(sak,pos(',',sak)-1)
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
 sak = left(sak,pos('-',sak)-1)
return(sak)

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

   if upper(changeto) = upper("High") then changeto = 1
   if upper(changeto) = upper("Low")  then changeto = 0
   if upper(changeto) = upper("No")   then changeto = 0
   if upper(changeto) = upper("Yes")  then changeto = 1

   if ~ischat then line.i = searchingfor"		"changeto
   if  ischat then line.i = searchingfor"		"'"'changeto'"'
  end
 end
 i = i + 1
end
return(key)
