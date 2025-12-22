IMPLEMENTATION MODULE bgLocale ;

(****************************************************

This file was created automatically by 'FlexCat 1.5'
from "bg.cd".

                Do NOT edit by hand!

****************************************************)

FROM SYSTEM   IMPORT  ADR, ADDRESS, TAG, CAST ;
FROM UtilityD IMPORT  tagDone ;

IMPORT  ll  : OptLocaleL,
        ld  : LocaleD,
        A   : Arts,
        asl : AslD;

CONST
  builtinlanguage = "english" ;
  version = 0 ;

VAR
  catalog    : ld.CatalogPtr ;

TYPE
  AppString = RECORD
     id  : LONGINT ;
     str : ADDRESS ;
  END ;

  AppStringArray = ARRAY [0..63-1] OF AppString ;

CONST
  AppStrings = AppStringArray  {
    AppString{id : MSG_PLAYER_1, str : ADR(MSG_PLAYER_1Str)},
    AppString{id : MSG_PLAYER_2, str : ADR(MSG_PLAYER_2Str)},
    AppString{id : MSG_TRACE, str : ADR(MSG_TRACEStr)},
    AppString{id : MSG_LEVEL, str : ADR(MSG_LEVELStr)},
    AppString{id : MSG_BLINK, str : ADR(MSG_BLINKStr)},
    AppString{id : MSG_BLINK_TIME, str : ADR(MSG_BLINK_TIMEStr)},
    AppString{id : MSG_BOARD_TYPE, str : ADR(MSG_BOARD_TYPEStr)},
    AppString{id : MSG_KION, str : ADR(MSG_KIONStr)},
    AppString{id : MSG_SAVE, str : ADR(MSG_SAVEStr)},
    AppString{id : MSG_LOAD, str : ADR(MSG_LOADStr)},
    AppString{id : MSG_GENERAL, str : ADR(MSG_GENERALStr)},
    AppString{id : MSG_BOARD, str : ADR(MSG_BOARDStr)},
    AppString{id : MSG_AI, str : ADR(MSG_AIStr)},
    AppString{id : MSG_USE, str : ADR(MSG_USEStr)},
    AppString{id : MSG_WHITE_STONE, str : ADR(MSG_WHITE_STONEStr)},
    AppString{id : MSG_BLACK_STONE, str : ADR(MSG_BLACK_STONEStr)},
    AppString{id : MSG_WHITE_FIELD, str : ADR(MSG_WHITE_FIELDStr)},
    AppString{id : MSG_BLACK_FIELD, str : ADR(MSG_BLACK_FIELDStr)},
    AppString{id : MSG_PLAY, str : ADR(MSG_PLAYStr)},
    AppString{id : MSG_NEW, str : ADR(MSG_NEWStr)},
    AppString{id : MSG_MODE, str : ADR(MSG_MODEStr)},
    AppString{id : MSG_PLAY_2, str : ADR(MSG_PLAY_2Str)},
    AppString{id : MSG_SET, str : ADR(MSG_SETStr)},
    AppString{id : MSG_HUMAN, str : ADR(MSG_HUMANStr)},
    AppString{id : MSG_COMPUTER, str : ADR(MSG_COMPUTERStr)},
    AppString{id : MSG_WHITE_GOES_ON, str : ADR(MSG_WHITE_GOES_ONStr)},
    AppString{id : MSG_BLACK_GOES_ON, str : ADR(MSG_BLACK_GOES_ONStr)},
    AppString{id : MSG_WHITE_WINS, str : ADR(MSG_WHITE_WINSStr)},
    AppString{id : MSG_BLACK_WINS, str : ADR(MSG_BLACK_WINSStr)},
    AppString{id : MSG_THE_DICE_ARE, str : ADR(MSG_THE_DICE_AREStr)},
    AppString{id : MSG_ITS_YOUR_TURN, str : ADR(MSG_ITS_YOUR_TURNStr)},
    AppString{id : MSG_CALCULATE, str : ADR(MSG_CALCULATEStr)},
    AppString{id : MSG_BACK, str : ADR(MSG_BACKStr)},
    AppString{id : MSG_MOVES, str : ADR(MSG_MOVESStr)},
    AppString{id : MSG_WHITE_TARGET, str : ADR(MSG_WHITE_TARGETStr)},
    AppString{id : MSG_BLACK_TARGET, str : ADR(MSG_BLACK_TARGETStr)},
    AppString{id : MSG_BAR, str : ADR(MSG_BARStr)},
    AppString{id : MSG_SINGLE_PROB, str : ADR(MSG_SINGLE_PROBStr)},
    AppString{id : MSG_SINGLE, str : ADR(MSG_SINGLEStr)},
    AppString{id : MSG_DISTRIBUTION, str : ADR(MSG_DISTRIBUTIONStr)},
    AppString{id : MSG_DISTANCE, str : ADR(MSG_DISTANCEStr)},
    AppString{id : MSG_SIX, str : ADR(MSG_SIXStr)},
    AppString{id : MSG_BLOCK, str : ADR(MSG_BLOCKStr)},
    AppString{id : MSG_TARGET, str : ADR(MSG_TARGETStr)},
    AppString{id : MSG_HOME, str : ADR(MSG_HOMEStr)},
    AppString{id : MSG_KIWIN, str : ADR(MSG_KIWINStr)},
    AppString{id : MSG_LEFT_COPY, str : ADR(MSG_LEFT_COPYStr)},
    AppString{id : MSG_RIGHT_COPY, str : ADR(MSG_RIGHT_COPYStr)},
    AppString{id : MSG_WHITE, str : ADR(MSG_WHITEStr)},
    AppString{id : MSG_BLACK, str : ADR(MSG_BLACKStr)},
    AppString{id : MSG_RATING, str : ADR(MSG_RATINGStr)},
    AppString{id : MSG_LOAD_FILE, str : ADR(MSG_LOAD_FILEStr)},
    AppString{id : MSG_SAVE_FILE, str : ADR(MSG_SAVE_FILEStr)},
    AppString{id : MSG_ON, str : ADR(MSG_ONStr)},
    AppString{id : MSG_OFF, str : ADR(MSG_OFFStr)},
    AppString{id : MSG_PREF_WIN, str : ADR(MSG_PREF_WINStr)},
    AppString{id : MSG_PREFERENCES, str : ADR(MSG_PREFERENCESStr)},
    AppString{id : MSG_BLACK_BEGINS, str : ADR(MSG_BLACK_BEGINSStr)},
    AppString{id : MSG_WHITE_BEGINS, str : ADR(MSG_WHITE_BEGINSStr)},
    AppString{id : MSG_ABOUT, str : ADR(MSG_ABOUTStr)},
    AppString{id : MSG_WELCOME, str : ADR(MSG_WELCOMEStr)},
    AppString{id : MSG_ABOUT_MES, str : ADR(MSG_ABOUT_MESStr)},
    AppString{id : MSG_SAVE_2, str : ADR(MSG_SAVE_2Str)}
  } ;

(*/// "CloseCatalog()" *)

PROCEDURE CloseCatalog() ;

BEGIN
  IF catalog # NIL THEN
    ll.CloseCatalog(catalog) ;
    catalog := NIL
  END;
END CloseCatalog ;

(*\*)

(*/// "OpenCatalog(loc : ld.LocalePtr ; language : ARRAY OF CHAR) ;" *)

PROCEDURE OpenCatalog(loc : ld.LocalePtr ; language : ARRAY OF CHAR) ;

VAR
   tagPtr : ADDRESS ;
   tags   : ARRAY [0..7] OF LONGINT ;

BEGIN
  CloseCatalog() ;
  IF (catalog = NIL) & (ll.localeBase # NIL) THEN
    IF language[0] # "o" THEN
      tagPtr := TAG(tags, ld.ocBuiltInLanguage, ADR(builtinlanguage),
                          ld.ocLanguage,        ADR(language),
                          ld.ocVersion,         version,
                          tagDone) ;
     ELSE
      tagPtr := TAG(tags, ld.ocBuiltInLanguage, ADR(builtinlanguage),
                          ld.ocVersion,         version,
                          tagDone) ;
    END (* IF *) ;
    catalog := ll.OpenCatalogA(loc, ADR("bg.catalog"), tagPtr) ;
  END (* IF *) ;
END OpenCatalog ;

(*\*)


PROCEDURE String(num : LONGINT) : ADDRESS ;

VAR
  i       : LONGINT ;
  default : ADDRESS ;

BEGIN
  i := 0 ;

  WHILE (i < 63) AND (AppStrings[i].id # num) DO
    INC(i)
  END (* WHILE *) ;

  IF i # 63 THEN
    default := AppStrings[i].str
   ELSE
    default := NIL
  END; (* IF *)

  IF catalog # NIL THEN
    RETURN ll.GetCatalogStr(catalog, num, default)
   ELSE
    RETURN default
  END (* IF *)

END String ;

(*/// "GetString(num : LONGINT) : ADDRESS" *)

PROCEDURE GetString(num : LONGINT) : ADDRESS ;

VAR str : asl.StrPtr;

BEGIN

  str := String (num);
  IF str <> NIL THEN
    IF str^[1] = 0C THEN        (* eingebauter Shortcut *)
      RETURN CAST (ADDRESS, str) + 2
    ELSE RETURN str
    END (* IF *)
  ELSE RETURN NIL
  END (* IF *)

END GetString ;

(*\*)

PROCEDURE GetKey ( num : LONGINT ) : CHAR;

VAR str : asl.StrPtr;

BEGIN

  str := String (num);
  IF str <> NIL THEN
    IF str^[1] = 0C THEN RETURN str^[0]
    END (* IF *)
  END; (* IF *)
  RETURN 0C

END GetKey;


PROCEDURE GetKeyPtr ( num : LONGINT ) : ADDRESS;

VAR str : asl.StrPtr;

BEGIN (* GetKeyPtr *)

  str := String (num);
  IF str <> NIL THEN
    IF str^[1] = 0C THEN RETURN str
    END (* IF *)
  END; (* IF *)
  RETURN NIL

END GetKeyPtr;


BEGIN

  IF ll.localeBase<>NIL THEN
    OpenCatalog (NIL,"")
  END (* IF *)

CLOSE

  CloseCatalog() ;

END bgLocale .
