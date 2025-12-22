/****************************************************************
   This file was created automatically by `FlexCat 2.1'
   from "PlayFKiss.cd".
   Do not edit by hand!
****************************************************************/

OPT MODULE
OPT REG=5


->*****
->** External modules
->*****
MODULE 'locale' , 'libraries/locale'
MODULE 'utility/tagitem'


->*****
->** Object definitions
->*****
EXPORT OBJECT fc_type PRIVATE
  id:LONG
  str:PTR TO CHAR
ENDOBJECT

EXPORT OBJECT catalog_PlayFKiss PUBLIC
  msgMenuProject			:PTR TO fc_type
  msgMenuProjectEditWindow			:PTR TO fc_type
  msgMenuProjectPrefs			:PTR TO fc_type
  msgMenuProjectAppendCoords			:PTR TO fc_type
  msgMenuProjectSaveAll			:PTR TO fc_type
  msgMenuProjectClose			:PTR TO fc_type
  msgMenuProjectRedrawScreen			:PTR TO fc_type
  msgMenuProjectSaveScreen			:PTR TO fc_type
  msgMenuProjectAbout			:PTR TO fc_type
  msgMenuProjectQuit			:PTR TO fc_type
  msgMenuEdit			:PTR TO fc_type
  msgMenuEditUndo			:PTR TO fc_type
  msgMenuEditRedo			:PTR TO fc_type
  msgMenuEditUnfix			:PTR TO fc_type
  msgMenuEditRefix			:PTR TO fc_type
  msgMenuEditMoveCelForward			:PTR TO fc_type
  msgMenuEditMoveCelBack			:PTR TO fc_type
  msgMenuEditRevealCel			:PTR TO fc_type
  msgMenuEditPatrolBounds			:PTR TO fc_type
  msgMenuEditReset			:PTR TO fc_type
  msgMenuItem			:PTR TO fc_type
  msgMenuItemSet			:PTR TO fc_type
  msgMenuItemColor			:PTR TO fc_type
  msgAppCopyright			:PTR TO fc_type
  msgAppDescription			:PTR TO fc_type
  msgLoaderWindowTitle			:PTR TO fc_type
  msgLoaderStatus			:PTR TO fc_type
  msgLoaderStatusHelp			:PTR TO fc_type
  msgLoaderSet			:PTR TO fc_type
  msgLoaderSetHelp			:PTR TO fc_type
  msgLoaderSetInfoHelp			:PTR TO fc_type
  msgLoaderSetInfoNumber			:PTR TO fc_type
  msgLoaderSetInfoName			:PTR TO fc_type
  msgLoaderSetInfoObjectNumber			:PTR TO fc_type
  msgLoaderSetInfoSize			:PTR TO fc_type
  msgLoaderSetInfoPalette			:PTR TO fc_type
  msgLoaderSetInfoSets			:PTR TO fc_type
  msgLoaderSetInfoComment			:PTR TO fc_type
  msgLoaderSetStatsHelp			:PTR TO fc_type
  msgLoaderSetStatsObjects			:PTR TO fc_type
  msgLoaderSetStatsCels			:PTR TO fc_type
  msgLoaderSetStatsEvents			:PTR TO fc_type
  msgLoaderSetStatsActions			:PTR TO fc_type
  msgLoaderSetStatsColors			:PTR TO fc_type
  msgLoaderSetStatsMemory			:PTR TO fc_type
  msgLoaderErrorlist			:PTR TO fc_type
  msgLoaderErrorlistHelp			:PTR TO fc_type
  msgLoaderPlay			:PTR TO fc_type
  msgLoaderPlayHelp			:PTR TO fc_type
  msgLoaderPrefs			:PTR TO fc_type
  msgLoaderPrefsHelp			:PTR TO fc_type
  msgLoaderAbout			:PTR TO fc_type
  msgLoaderAboutHelp			:PTR TO fc_type
  msgLoaderQuit			:PTR TO fc_type
  msgLoaderQuitHelp			:PTR TO fc_type
  msgEditWindowTitle			:PTR TO fc_type
  msgEditObjectPage			:PTR TO fc_type
  msgEditCelPage			:PTR TO fc_type
  msgEditObjectStatics			:PTR TO fc_type
  msgEditObjectNumber			:PTR TO fc_type
  msgEditObjectCelNumber			:PTR TO fc_type
  msgEditObjectWidth			:PTR TO fc_type
  msgEditObjectHeight			:PTR TO fc_type
  msgEditObjectXPos			:PTR TO fc_type
  msgEditObjectYPos			:PTR TO fc_type
  msgEditObjectResetPosition			:PTR TO fc_type
  msgEditObjectUndoPosition			:PTR TO fc_type
  msgEditObjectFixValueHelp			:PTR TO fc_type
  msgEditObjectStore			:PTR TO fc_type
  msgEditObjectReset			:PTR TO fc_type
  msgEditObjectUnfix			:PTR TO fc_type
  msgEditObjectMax			:PTR TO fc_type
  msgEditCelCel			:PTR TO fc_type
  msgEditCelColorSet			:PTR TO fc_type
  msgEditCelName			:PTR TO fc_type
  msgEditCelXOffset			:PTR TO fc_type
  msgEditCelYOffset			:PTR TO fc_type
  msgEditCelWidth			:PTR TO fc_type
  msgEditCelHeight			:PTR TO fc_type
  msgEditCelForwards			:PTR TO fc_type
  msgEditCelBackwards			:PTR TO fc_type
  msgEditCelHide			:PTR TO fc_type
  msgPrefsWindowTitle			:PTR TO fc_type
  msgPrefsScreenMode			:PTR TO fc_type
  msgPrefsAnimationSpeed			:PTR TO fc_type
  msgPrefsAnimationSpeedHelp			:PTR TO fc_type
  msgPrefsEnforceBounds			:PTR TO fc_type
  msgPrefsFollowMouse			:PTR TO fc_type
  msgPrefsElasticFix			:PTR TO fc_type
  msgPrefsWBWindow			:PTR TO fc_type
  msgPrefsUseRTG			:PTR TO fc_type
  msgPrefsUpdate			:PTR TO fc_type
  msgPrefsUpdateObjectRegions			:PTR TO fc_type
  msgPrefsUpdateCelRegions			:PTR TO fc_type
  msgPrefsUpdateSimpleSquare			:PTR TO fc_type
  msgPrefsPointer			:PTR TO fc_type
  msgPrefsPointerSystem			:PTR TO fc_type
  msgPrefsPointerHand			:PTR TO fc_type
  msgPrefsPointerBlank			:PTR TO fc_type
  msgPrefsSave			:PTR TO fc_type
  msgPrefsUse			:PTR TO fc_type
  msgPrefsCancel			:PTR TO fc_type
  msgAboutWindowTitle			:PTR TO fc_type
  msgAboutListviewHelp			:PTR TO fc_type
  msgAboutOk			:PTR TO fc_type
  msgRevealWindowTitle			:PTR TO fc_type
  msgRevealWhichCel			:PTR TO fc_type
  msgOutputWindowTitle			:PTR TO fc_type
  msgStatusHello			:PTR TO fc_type
  msgStatusSelectCNFFile			:PTR TO fc_type
  msgStatusParsingCNFFile			:PTR TO fc_type
  msgStatusLoadingCelFiles			:PTR TO fc_type
  msgStatusUncompressingKissSet			:PTR TO fc_type
  msgStatusDeletingTemporaryFiles			:PTR TO fc_type
  msgStatusReady			:PTR TO fc_type
  msgErrorNoLibrary			:PTR TO fc_type
  msgErrorNoLibraryVersion			:PTR TO fc_type
  msgErrorNoMUIApplication			:PTR TO fc_type
  msgErrorOpenScreen			:PTR TO fc_type
  msgErrorOpenWindow			:PTR TO fc_type
  msgErrorCreateMenu			:PTR TO fc_type
  msgErrorNoCNFFiles			:PTR TO fc_type
  msgErrorUnknown			:PTR TO fc_type
  msgRequestTitleSelectCNFFile			:PTR TO fc_type
  msgRequestTitleSaveCNFFileAs			:PTR TO fc_type
  msgRequestTitleAppendCNFFile			:PTR TO fc_type
  msgRequestButtonYesNo			:PTR TO fc_type
  msgRequestButtonOK			:PTR TO fc_type
  msgRequestButtonSave			:PTR TO fc_type
  msgRequestMultipleCNFFiles			:PTR TO fc_type
  msgRequestCNFFileExsists			:PTR TO fc_type
ENDOBJECT


->*****
->** Global variables
->*****
DEF cat_PlayFKiss:PTR TO catalog


->*****
->** Creation procedure for fc_type object
->*****
PROC create(id,str:PTR TO CHAR) OF fc_type

  self.id:=id
  self.str:=str

ENDPROC

->*****
->** Procedure which returns the correct string according to the catalog
->*****
PROC getstr() OF fc_type IS 
  IF cat_PlayFKiss THEN GetCatalogStr(cat_PlayFKiss,self.id,self.str) ELSE self.str

PROC newcreate(id,stri)
DEF fct:PTR TO fc_type
ENDPROC NEW fct.create(id,stri)


->*****
->** Creation procedure for catalog_PlayFKiss object
->*****
PROC create() OF catalog_PlayFKiss
  cat_PlayFKiss:=NIL

  self.msgMenuProject:=newcreate(0,{str_0})
  self.msgMenuProjectEditWindow:=newcreate(1,{str_1})
  self.msgMenuProjectPrefs:=newcreate(2,{str_2})
  self.msgMenuProjectAppendCoords:=newcreate(3,{str_3})
  self.msgMenuProjectSaveAll:=newcreate(4,{str_4})
  self.msgMenuProjectClose:=newcreate(5,{str_5})
  self.msgMenuProjectRedrawScreen:=newcreate(6,{str_6})
  self.msgMenuProjectSaveScreen:=newcreate(7,{str_7})
  self.msgMenuProjectAbout:=newcreate(8,{str_8})
  self.msgMenuProjectQuit:=newcreate(9,{str_9})
  self.msgMenuEdit:=newcreate(10,{str_10})
  self.msgMenuEditUndo:=newcreate(11,{str_11})
  self.msgMenuEditRedo:=newcreate(12,{str_12})
  self.msgMenuEditUnfix:=newcreate(13,{str_13})
  self.msgMenuEditRefix:=newcreate(14,{str_14})
  self.msgMenuEditMoveCelForward:=newcreate(15,{str_15})
  self.msgMenuEditMoveCelBack:=newcreate(16,{str_16})
  self.msgMenuEditRevealCel:=newcreate(17,{str_17})
  self.msgMenuEditPatrolBounds:=newcreate(18,{str_18})
  self.msgMenuEditReset:=newcreate(19,{str_19})
  self.msgMenuItem:=newcreate(20,{str_20})
  self.msgMenuItemSet:=newcreate(21,{str_21})
  self.msgMenuItemColor:=newcreate(22,{str_22})
  self.msgAppCopyright:=newcreate(23,{str_23})
  self.msgAppDescription:=newcreate(24,{str_24})
  self.msgLoaderWindowTitle:=newcreate(25,{str_25})
  self.msgLoaderStatus:=newcreate(26,{str_26})
  self.msgLoaderStatusHelp:=newcreate(27,{str_27})
  self.msgLoaderSet:=newcreate(28,{str_28})
  self.msgLoaderSetHelp:=newcreate(29,{str_29})
  self.msgLoaderSetInfoHelp:=newcreate(30,{str_30})
  self.msgLoaderSetInfoNumber:=newcreate(31,{str_31})
  self.msgLoaderSetInfoName:=newcreate(32,{str_32})
  self.msgLoaderSetInfoObjectNumber:=newcreate(33,{str_33})
  self.msgLoaderSetInfoSize:=newcreate(34,{str_34})
  self.msgLoaderSetInfoPalette:=newcreate(35,{str_35})
  self.msgLoaderSetInfoSets:=newcreate(36,{str_36})
  self.msgLoaderSetInfoComment:=newcreate(37,{str_37})
  self.msgLoaderSetStatsHelp:=newcreate(38,{str_38})
  self.msgLoaderSetStatsObjects:=newcreate(39,{str_39})
  self.msgLoaderSetStatsCels:=newcreate(40,{str_40})
  self.msgLoaderSetStatsEvents:=newcreate(41,{str_41})
  self.msgLoaderSetStatsActions:=newcreate(42,{str_42})
  self.msgLoaderSetStatsColors:=newcreate(43,{str_43})
  self.msgLoaderSetStatsMemory:=newcreate(44,{str_44})
  self.msgLoaderErrorlist:=newcreate(45,{str_45})
  self.msgLoaderErrorlistHelp:=newcreate(46,{str_46})
  self.msgLoaderPlay:=newcreate(47,{str_47})
  self.msgLoaderPlayHelp:=newcreate(48,{str_48})
  self.msgLoaderPrefs:=newcreate(49,{str_49})
  self.msgLoaderPrefsHelp:=newcreate(50,{str_50})
  self.msgLoaderAbout:=newcreate(51,{str_51})
  self.msgLoaderAboutHelp:=newcreate(52,{str_52})
  self.msgLoaderQuit:=newcreate(53,{str_53})
  self.msgLoaderQuitHelp:=newcreate(54,{str_54})
  self.msgEditWindowTitle:=newcreate(55,{str_55})
  self.msgEditObjectPage:=newcreate(56,{str_56})
  self.msgEditCelPage:=newcreate(57,{str_57})
  self.msgEditObjectStatics:=newcreate(58,{str_58})
  self.msgEditObjectNumber:=newcreate(59,{str_59})
  self.msgEditObjectCelNumber:=newcreate(60,{str_60})
  self.msgEditObjectWidth:=newcreate(61,{str_61})
  self.msgEditObjectHeight:=newcreate(62,{str_62})
  self.msgEditObjectXPos:=newcreate(63,{str_63})
  self.msgEditObjectYPos:=newcreate(64,{str_64})
  self.msgEditObjectResetPosition:=newcreate(65,{str_65})
  self.msgEditObjectUndoPosition:=newcreate(66,{str_66})
  self.msgEditObjectFixValueHelp:=newcreate(67,{str_67})
  self.msgEditObjectStore:=newcreate(68,{str_68})
  self.msgEditObjectReset:=newcreate(69,{str_69})
  self.msgEditObjectUnfix:=newcreate(70,{str_70})
  self.msgEditObjectMax:=newcreate(71,{str_71})
  self.msgEditCelCel:=newcreate(72,{str_72})
  self.msgEditCelColorSet:=newcreate(73,{str_73})
  self.msgEditCelName:=newcreate(74,{str_74})
  self.msgEditCelXOffset:=newcreate(75,{str_75})
  self.msgEditCelYOffset:=newcreate(76,{str_76})
  self.msgEditCelWidth:=newcreate(77,{str_77})
  self.msgEditCelHeight:=newcreate(78,{str_78})
  self.msgEditCelForwards:=newcreate(79,{str_79})
  self.msgEditCelBackwards:=newcreate(80,{str_80})
  self.msgEditCelHide:=newcreate(81,{str_81})
  self.msgPrefsWindowTitle:=newcreate(82,{str_82})
  self.msgPrefsScreenMode:=newcreate(83,{str_83})
  self.msgPrefsAnimationSpeed:=newcreate(84,{str_84})
  self.msgPrefsAnimationSpeedHelp:=newcreate(85,{str_85})
  self.msgPrefsEnforceBounds:=newcreate(86,{str_86})
  self.msgPrefsFollowMouse:=newcreate(87,{str_87})
  self.msgPrefsElasticFix:=newcreate(88,{str_88})
  self.msgPrefsWBWindow:=newcreate(89,{str_89})
  self.msgPrefsUseRTG:=newcreate(90,{str_90})
  self.msgPrefsUpdate:=newcreate(91,{str_91})
  self.msgPrefsUpdateObjectRegions:=newcreate(92,{str_92})
  self.msgPrefsUpdateCelRegions:=newcreate(93,{str_93})
  self.msgPrefsUpdateSimpleSquare:=newcreate(94,{str_94})
  self.msgPrefsPointer:=newcreate(95,{str_95})
  self.msgPrefsPointerSystem:=newcreate(96,{str_96})
  self.msgPrefsPointerHand:=newcreate(97,{str_97})
  self.msgPrefsPointerBlank:=newcreate(98,{str_98})
  self.msgPrefsSave:=newcreate(99,{str_99})
  self.msgPrefsUse:=newcreate(100,{str_100})
  self.msgPrefsCancel:=newcreate(101,{str_101})
  self.msgAboutWindowTitle:=newcreate(102,{str_102})
  self.msgAboutListviewHelp:=newcreate(103,{str_103})
  self.msgAboutOk:=newcreate(104,{str_104})
  self.msgRevealWindowTitle:=newcreate(105,{str_105})
  self.msgRevealWhichCel:=newcreate(106,{str_106})
  self.msgOutputWindowTitle:=newcreate(107,{str_107})
  self.msgStatusHello:=newcreate(108,{str_108})
  self.msgStatusSelectCNFFile:=newcreate(109,{str_109})
  self.msgStatusParsingCNFFile:=newcreate(110,{str_110})
  self.msgStatusLoadingCelFiles:=newcreate(111,{str_111})
  self.msgStatusUncompressingKissSet:=newcreate(112,{str_112})
  self.msgStatusDeletingTemporaryFiles:=newcreate(113,{str_113})
  self.msgStatusReady:=newcreate(114,{str_114})
  self.msgErrorNoLibrary:=newcreate(115,{str_115})
  self.msgErrorNoLibraryVersion:=newcreate(116,{str_116})
  self.msgErrorNoMUIApplication:=newcreate(117,{str_117})
  self.msgErrorOpenScreen:=newcreate(118,{str_118})
  self.msgErrorOpenWindow:=newcreate(119,{str_119})
  self.msgErrorCreateMenu:=newcreate(120,{str_120})
  self.msgErrorNoCNFFiles:=newcreate(121,{str_121})
  self.msgErrorUnknown:=newcreate(122,{str_122})
  self.msgRequestTitleSelectCNFFile:=newcreate(123,{str_123})
  self.msgRequestTitleSaveCNFFileAs:=newcreate(124,{str_124})
  self.msgRequestTitleAppendCNFFile:=newcreate(125,{str_125})
  self.msgRequestButtonYesNo:=newcreate(126,{str_126})
  self.msgRequestButtonOK:=newcreate(127,{str_127})
  self.msgRequestButtonSave:=newcreate(128,{str_128})
  self.msgRequestMultipleCNFFiles:=newcreate(129,{str_129})
  self.msgRequestCNFFileExsists:=newcreate(130,{str_130})

ENDPROC

PROC getCatalog() OF catalog_PlayFKiss IS cat_PlayFKiss

->*****
->** Opening catalog procedure (exported)
->*****
PROC open(loc=NIL:PTR TO locale,language=NIL:PTR TO CHAR ) OF catalog_PlayFKiss
DEF tag,
    tagarg

  self.close()
  IF localebase AND (cat_PlayFKiss=NIL)
    IF language
      tag:=OC_LANGUAGE
      tagarg:=language
    ELSE
      tag:=TAG_IGNORE
    ENDIF

    cat_PlayFKiss:=OpenCatalogA(loc,'PlayFKiss.catalog',
                         [OC_BUILTINLANGUAGE, 'english',
                          tag,                tagarg,
                          OC_VERSION,         0,
                          TAG_DONE,0])

  ENDIF

ENDPROC


->*****
->** Closing catalog procedure
->*****
PROC close() OF catalog_PlayFKiss

  IF cat_PlayFKiss
    CloseCatalog(cat_PlayFKiss)
    cat_PlayFKiss:=NIL
  ENDIF

ENDPROC


str_0: CHAR 'Project',0
str_1: CHAR 'Edit Window...',0
str_2: CHAR 'Preferences...',0
str_3: CHAR 'Append Coordinates...',0
str_4: CHAR 'Save All...',0
str_5: CHAR 'Close',0
str_6: CHAR 'Redraw Screen',0
str_7: CHAR 'Save Screen...',0
str_8: CHAR 'About...',0
str_9: CHAR 'Quit',0
str_10: CHAR 'Edit',0
str_11: CHAR 'Undo',0
str_12: CHAR 'Redo',0
str_13: CHAR 'Unfix',0
str_14: CHAR 'Refix',0
str_15: CHAR 'Move Cel Forawrd',0
str_16: CHAR 'Move Cel Back',0
str_17: CHAR 'Reveal Cel...',0
str_18: CHAR 'Patrol Bounds',0
str_19: CHAR 'Reset',0
str_20: CHAR 'Item',0
str_21: CHAR 'Set',0
str_22: CHAR 'Color',0
str_23: CHAR 'PUBLIC DOMAIN',0
str_24: CHAR 'Kisekae player for Amiga.',0
str_25: CHAR 'Loader',0
str_26: CHAR 'Status:',0
str_27: CHAR 'Displays current state of PlayFKiss.',0
str_28: CHAR 'Set:',0
str_29: CHAR 'Used to choose a .cnf file to load.',0
str_30: CHAR 'Displays cel and object information.',0
str_31: CHAR '\er#',0
str_32: CHAR '\ecName',0
str_33: CHAR '\ecObj',0
str_34: CHAR '\ecSize',0
str_35: CHAR '\ecPal',0
str_36: CHAR '\ecSets',0
str_37: CHAR '\ecComment',0
str_38: CHAR 'Assorted statistics of current .cnf file.',0
str_39: CHAR '\ebObjects:',0
str_40: CHAR '\ebCels:',0
str_41: CHAR '\ebEvents:',0
str_42: CHAR '\ebActions:',0
str_43: CHAR '\ebColors:',0
str_44: CHAR '\ebMemory:',0
str_45: CHAR 'Errors',0
str_46: CHAR 'Displays error messages.',0
str_47: CHAR 'Play',0
str_48: CHAR 'Go and play current set!',0
str_49: CHAR 'Prefs',0
str_50: CHAR 'Show Preferences window.',0
str_51: CHAR 'About',0
str_52: CHAR 'Display program information.',0
str_53: CHAR 'Quit',0
str_54: CHAR 'Duh, my name is George.',0
str_55: CHAR 'Edit',0
str_56: CHAR 'Object',0
str_57: CHAR 'Cel',0
str_58: CHAR 'Statistics on currently selected object',0
str_59: CHAR '\ebObj #:',0
str_60: CHAR '\eb# of cels:',0
str_61: CHAR '\ebWidth:',0
str_62: CHAR '\ebHeight:',0
str_63: CHAR '\ebX Pos:',0
str_64: CHAR '\ebX Pos:',0
str_65: CHAR 'Reset Pos',0
str_66: CHAR 'Undo Pos',0
str_67: CHAR 'Current object fix value.',0
str_68: CHAR 'Store',0
str_69: CHAR 'Reset',0
str_70: CHAR 'Unfix',0
str_71: CHAR 'Max',0
str_72: CHAR 'Cel',0
str_73: CHAR 'Color set:',0
str_74: CHAR 'Name:',0
str_75: CHAR 'X offset:',0
str_76: CHAR 'Y Offset:',0
str_77: CHAR 'Width:',0
str_78: CHAR 'Height:',0
str_79: CHAR 'Forwards',0
str_80: CHAR 'Backwards',0
str_81: CHAR 'Hide',0
str_82: CHAR 'Preferences',0
str_83: CHAR 'Screen Mode:',0
str_84: CHAR 'Animation Speed:',0
str_85: CHAR 'Decides how fast the timers will decrease.',0
str_86: CHAR 'Enforce Bounds',0
str_87: CHAR 'Follow Mouse',0
str_88: CHAR 'Elastic Fix',0
str_89: CHAR 'Window on Workbench',0
str_90: CHAR 'Use RTG',0
str_91: CHAR 'Update:',0
str_92: CHAR 'Object Regions',0
str_93: CHAR 'Cel Regions',0
str_94: CHAR 'Simple Square',0
str_95: CHAR 'Pointer:',0
str_96: CHAR 'System',0
str_97: CHAR 'Hand',0
str_98: CHAR 'Blank',0
str_99: CHAR '_Save',0
str_100: CHAR '_Use',0
str_101: CHAR '_Cancel',0
str_102: CHAR 'About...',0
str_103: CHAR 'Bubble help sucks, doesn\at it? :)',0
str_104: CHAR 'Ok',0
str_105: CHAR 'Reveal',0
str_106: CHAR 'Reveal which cel?',0
str_107: CHAR 'Output',0
str_108: CHAR 'Hello :)',0
str_109: CHAR 'Select CNF file...',0
str_110: CHAR 'Parsing CNF file...',0
str_111: CHAR 'Loading cel files...',0
str_112: CHAR 'Uncompressing Kiss Set...',0
str_113: CHAR 'Deleting temporary files...',0
str_114: CHAR 'Ready!',0
str_115: CHAR 'Missing %s.library!',0
str_116: CHAR 'Missing version %ld of %s.library!',0
str_117: CHAR 'Creating MUI application failed!',0
str_118: CHAR 'Unable to open a screen!\nWidth %ld\nHeight: %ld\nDepth: %d',0
str_119: CHAR 'Unable to open a window!\nWidth %ld\nHeight: %ld\nFlags: $%x\nIDCMP: $%x',0
str_120: CHAR 'Creating menu structure failed!',0
str_121: CHAR 'This archive doesn''t contain any CNF files!',0
str_122: CHAR 'Unknown exception!\nError %ld\nInfo: %ld''',0
str_123: CHAR 'Select .cnf file',0
str_124: CHAR 'Save .cnf file as',0
str_125: CHAR 'Select .cnf file',0
str_126: CHAR 'Yes|No',0
str_127: CHAR 'OK',0
str_128: CHAR 'Save',0
str_129: CHAR 'This archive contains multiple CNF files.\nSelect one you want to play.',0
str_130: CHAR 'Selected file already exists.\nDo you want to overwrite it?',0


/****************************************************************
   End of the automatically created part!
****************************************************************/
