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
    AppString{id : MSG_PLAYER1, str : ADR(MSG_PLAYER1Str)},
    AppString{id : MSG_PLAYER2, str : ADR(MSG_PLAYER2Str)},
    AppString{id : MSG_TRACE, str : ADR(MSG_TRACEStr)},
    AppString{id : MSG_LEVEL, str : ADR(MSG_LEVELStr)},
    AppString{id : MSG_Blink, str : ADR(MSG_BlinkStr)},
    AppString{id : MSG_Blink_Time, str : ADR(MSG_Blink_TimeStr)},
    AppString{id : MSG_Board_Type, str : ADR(MSG_Board_TypeStr)},
    AppString{id : MSG_KION, str : ADR(MSG_KIONStr)},
    AppString{id : MSG_SAVE, str : ADR(MSG_SAVEStr)},
    AppString{id : MSG_LOAD, str : ADR(MSG_LOADStr)},
    AppString{id : MSG_General, str : ADR(MSG_GeneralStr)},
    AppString{id : MSG_Board, str : ADR(MSG_BoardStr)},
    AppString{id : MSG_AI, str : ADR(MSG_AIStr)},
    AppString{id : MSG_USE, str : ADR(MSG_USEStr)},
    AppString{id : MSG_WHITE_STONE_PEN, str : ADR(MSG_WHITE_STONE_PENStr)},
    AppString{id : MSG_BLACK_STONE_PEN, str : ADR(MSG_BLACK_STONE_PENStr)},
    AppString{id : MSG_WHITE_FIELD_PEN, str : ADR(MSG_WHITE_FIELD_PENStr)},
    AppString{id : MSG_BLACK_FIELD_PEN, str : ADR(MSG_BLACK_FIELD_PENStr)},
    AppString{id : MSG_PLAY, str : ADR(MSG_PLAYStr)},
    AppString{id : MSG_NEW, str : ADR(MSG_NEWStr)},
    AppString{id : MSG_MODE, str : ADR(MSG_MODEStr)},
    AppString{id : MSG_PLAY2, str : ADR(MSG_PLAY2Str)},
    AppString{id : MSG_SET, str : ADR(MSG_SETStr)},
    AppString{id : MSG_HUMAN, str : ADR(MSG_HUMANStr)},
    AppString{id : MSG_COMPUTER, str : ADR(MSG_COMPUTERStr)},
    AppString{id : MSG_WHITE_GOES_ON, str : ADR(MSG_WHITE_GOES_ONStr)},
    AppString{id : MSG_BLACK_GOES_ON, str : ADR(MSG_BLACK_GOES_ONStr)},
    AppString{id : MSG_WHITE_WINS, str : ADR(MSG_WHITE_WINSStr)},
    AppString{id : MSG_BLACK_WINS, str : ADR(MSG_BLACK_WINSStr)},
    AppString{id : MSG_THE_DICES_ARE, str : ADR(MSG_THE_DICES_AREStr)},
    AppString{id : MSG_ITS_YOUR_TURN, str : ADR(MSG_ITS_YOUR_TURNStr)},
    AppString{id : MSG_CALCULATE, str : ADR(MSG_CALCULATEStr)},
    AppString{id : MSG_BACK, str : ADR(MSG_BACKStr)},
    AppString{id : MSG_MOVES, str : ADR(MSG_MOVESStr)},
    AppString{id : MSG_WHITE_TARGET, str : ADR(MSG_WHITE_TARGETStr)},
    AppString{id : MSG_BLACK_TARGET, str : ADR(MSG_BLACK_TARGETStr)},
    AppString{id : MSG_BAR_LEV, str : ADR(MSG_BAR_LEVStr)},
    AppString{id : MSG_SINGLEPROB_LEV, str : ADR(MSG_SINGLEPROB_LEVStr)},
    AppString{id : MSG_SINGLE_LEV, str : ADR(MSG_SINGLE_LEVStr)},
    AppString{id : MSG_DISTRIBUTION_LEV, str : ADR(MSG_DISTRIBUTION_LEVStr)},
    AppString{id : MSG_DISTANCE_LEV, str : ADR(MSG_DISTANCE_LEVStr)},
    AppString{id : MSG_SIX_LEV, str : ADR(MSG_SIX_LEVStr)},
    AppString{id : MSG_BLOCK_LEV, str : ADR(MSG_BLOCK_LEVStr)},
    AppString{id : MSG_TARGET_LEV, str : ADR(MSG_TARGET_LEVStr)},
    AppString{id : MSG_HOME_LEV, str : ADR(MSG_HOME_LEVStr)},
    AppString{id : MSG_KIWIN, str : ADR(MSG_KIWINStr)},
    AppString{id : MSG_LEFTCOPY, str : ADR(MSG_LEFTCOPYStr)},
    AppString{id : MSG_RIGHTCOPY, str : ADR(MSG_RIGHTCOPYStr)},
    AppString{id : MSG_WHITE, str : ADR(MSG_WHITEStr)},
    AppString{id : MSG_BLACK, str : ADR(MSG_BLACKStr)},
    AppString{id : MSG_RATING, str : ADR(MSG_RATINGStr)},
    AppString{id : MSG_LOAD_FILE, str : ADR(MSG_LOAD_FILEStr)},
    AppString{id : MSG_SAVE_FILE, str : ADR(MSG_SAVE_FILEStr)},
    AppString{id : MSG_ON, str : ADR(MSG_ONStr)},
    AppString{id : MSG_OFF, str : ADR(MSG_OFFStr)},
    AppString{id : MSG_Prev_Win, str : ADR(MSG_Prev_WinStr)},
    AppString{id : MSG_Prev_On, str : ADR(MSG_Prev_OnStr)},
    AppString{id : MSG_Black_Begins, str : ADR(MSG_Black_BeginsStr)},
    AppString{id : MSG_White_Begins, str : ADR(MSG_White_BeginsStr)},
    AppString{id : MSG_ABOUT, str : ADR(MSG_ABOUTStr)},
    AppString{id : MSG_WELCOME, str : ADR(MSG_WELCOMEStr)},
    AppString{id : MSG_ABOUT_MES, str : ADR(MSG_ABOUT_MESStr)},
    AppString{id : MSG_SAVE2, str : ADR(MSG_SAVE2Str)}
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
    catalog := ll.OpenCatalogA(loc, ADR("MUIbg.catalog"), tagPtr) ;
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
