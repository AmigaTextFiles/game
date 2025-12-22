IMPLEMENTATION MODULE bgSettings;
(****h* bg/bgSettings *************************************************
*
*       NAME
*           bgSettings
*
*       COPYRIGHT
*           © 1995, Marc Ewert
*
*       FUNCTION
*           Stellt Funktionen zum Einstellen von bg und die erhaltenen
*           Einstellungen.
*
*       AUTHOR
*           Marc Ewert
*
*       CREATION DATE
*           29.11.95
*
*       HISTORY
*           V1.00 - (11.03.96)
*                   * Erste Version.
*
*       NOTES
*
************************************************************************************
*)

IMPORT

  a   : Arts,
  arg : Arguments,
  ASL : AslL,
  d   : DosD,
  D   : DosL,
  fs  : FileSup,
  h   : Heap,
  i   : IntuitionD,
  IC  : IconL,
  l   : bgLocale,
  MD  : MuiD,
  ML  : MuiL,
  MM  : MuiMacros,
  mui : bgMui,
  rs  : ReqSup,
  s   : String,
  str : bgStrukturen,
  u   : UtilityD,
  wb  : WorkbenchD,
  y   : SYSTEM;

TYPE LONGINTPTR = POINTER TO LONGINT;

VAR kiFile, kiDir     : str.StrPtr;
    prefFile, prefDir : str.StrPtr;
    fileName          : str.Str;

(*--------------------------------------------------------------------------------*)

PROCEDURE LoadKiSettingsBlock (datei : d.FileHandlePtr; farbe : LONGINT; win : i.WindowPtr);
(****** bgSettings/LoadKiSettingsBlock ************************************************
*
*       NAME
*           LoadKiSettingsBlock
*
*       SYNOPSIS
*           LoadKiSettingsBlock ( datei, farbe, win )
*
*           LoadKiSettingsBlock ( FileHandlePtr, LONGINT, WindowPtr )
*
*       INPUTS
*           datei - Zeiger auf geöffnete KiSettingsDatei.
*           farbe - Farbe des einzuladenen KiSettingsBlock.
*           win   - Window für RetryRequester.
*
*       FUNCTION
*           Lädt die Eistellungen für die Bewertungsfunktion aus schon geöffneter
*           Datei.
*
*       NOTES
*
*       SEE ALSO
*
************************************************************************************
*)

VAR backSetting : SetArr;
    elem        : KiElem;
    x           : CARDINAL;

(*--------------------------------------------------------------------------------*)

PROCEDURE ReadCharacter (x : CARDINAL) : BOOLEAN;

VAR elem : KiElem;
    long : LONGINT;

BEGIN (* ReadCharacter *)

  FOR elem := MIN (KiElem) TO MAX (KiElem) DO
    IF NOT fs.ReadLongIntReq (datei, long, win) THEN RETURN FALSE
    ELSE backSetting[x,elem] := long;
    END (* IF *)
  END; (* FOR *)
  RETURN TRUE

END ReadCharacter;

(*--------------------------------------------------------------------------------*)

VAR com : str.Str;

BEGIN (* LoadKiSettingsBlock *)

  IF ReadCharacter (1) THEN
    IF ReadCharacter (2) THEN
      IF fs.ReadStringReq (datei, com, win) THEN
        IF farbe = 1 THEN MM.set (mui.wKiCom, MD.maStringContents, y.ADR (com))
        ELSE MM.set (mui.bKiCom, MD.maStringContents, y.ADR (com))
        END; (* IF *)
        FOR x := 1 TO 2 DO
          FOR elem := MIN (KiElem) TO MAX (KiElem) DO
            kiSetting [farbe,x,elem] := backSetting[x,elem];
            MM.set (mui.kiSlider[farbe,x,elem], MD.maNumericValue, backSetting[x,elem])
          END (* FOR *)
        END (* FOR *)
      END (* IF *)
    END (* IF *)
  END (* IF *)

END LoadKiSettingsBlock;

(*--------------------------------------------------------------------------------*)

PROCEDURE LoadKiSettingsHook (hook : u.HookPtr; obj1, farbePtr : MD.APTR) : MD.APTR;
(****** bgSettings/LoadKiSettingsHook ************************************************
*
*       NAME
*           LoadKiSettingsHook
*
*       SYNOPSIS
*           obj = LoadKiSettingsHook ( hook, obj1, farbePtr )
*
*           APTR = LoadKiSettingsHook ( HookPtr, APTR, APTR)
*
*       INPUTS
*           farbePtr - Zeiger auf die Farbe, dessen KiSettings eingeladen
*                      werden sollen.
*
*       FUNCTION
*           Lädt die Eistellungen für die Bewertungsfunktion.
*           Fragt User nach Filenamen.
*
*       NOTES
*
*       SEE ALSO
*
************************************************************************************
*)

VAR win         : i.WindowPtr;
    farbe, long : LONGINT;
    datei       : d.FileHandlePtr;
    ver, rev    : INTEGER;

BEGIN (* LoadKiSettingsHook *)

  farbe := y.CAST (LONGINTPTR, farbePtr)^;
  MM.get (obj1, MD.maWindow, y.ADR (win));
  IF rs.FileReq (fileReq, l.GetString (l.MSG_LOAD_FILE), y.ADR ("#?.car"), kiDir, kiFile, FALSE, win) THEN
    IF s.CanCopy (fileName, kiDir^) THEN
      s.Copy (fileName, kiDir^);
      IF D.AddPart (y.ADR (fileName), kiFile, SIZE (str.Str)) THEN
        IF fs.OpenCheckReq (datei, y.ADR (fileName), MM.MakeID ("MBKK"), ver, rev, TRUE, win) THEN
          IF (ver = 1) AND (rev = 0) THEN
            LoadKiSettingsBlock (datei, farbe, win)
          END; (* IF *)
          D.Close (datei)
        END (* IF *)
      END (* IF *)
    END (* IF *)
  END; (* IF *)
  RETURN 0

END LoadKiSettingsHook;

(*--------------------------------------------------------------------------------*)

PROCEDURE SaveKiSettingsBlock (datei : d.FileHandlePtr; farbe : LONGINT; win : i.WindowPtr);
(****** bgSettings/SaveKiSettingsBlock ************************************************
*
*       NAME
*           SaveKiSettingsBlock
*
*       SYNOPSIS
*           SaveKiSettingsBlock ( datei, farbe, win )
*
*           SaveKiSettingsBlock ( FileHandlePtr, LONGINT, WindowPtr )
*
*       INPUTS
*           datei - Schon geöffnete KiSettingsDatei.
*           farbe - Farbe der zu ladenden Einstellungen.
*           win   - Window für RetryRequester.
*
*       FUNCTION
*           Speichert die Eistellungen für die Bewertungsfunktion.
*
*       NOTES
*
*       SEE ALSO
*
************************************************************************************
*)

VAR elem   : KiElem;
    x      : CARDINAL;
    comPtr : str.StrPtr;

(*--------------------------------------------------------------------------------*)

PROCEDURE WriteCharacter (x : CARDINAL) : BOOLEAN;

VAR elem : KiElem;

BEGIN (* WriteCharacter *)

  FOR elem := MIN (KiElem) TO MAX (KiElem) DO
    IF NOT fs.WriteLongIntReq (datei, kiSetting[farbe,x,elem], win) THEN RETURN FALSE
    END (* IF *)
  END; (* FOR *)
  RETURN TRUE

END WriteCharacter;

(*--------------------------------------------------------------------------------*)

BEGIN (* SaveKiSettingsBlock *)

  IF WriteCharacter (1) THEN
    IF WriteCharacter (2) THEN
      IF farbe = 1 THEN MM.get (mui.wKiCom, MD.maStringContents, y.ADR (comPtr))
      ELSE MM.get (mui.bKiCom, MD.maStringContents, y.ADR (comPtr))
      END; (* IF *)
      IF fs.WriteStringReq (datei, comPtr^, win) THEN
      END (* IF *)
    END (* IF *)
  END (* IF *)

END SaveKiSettingsBlock;

(*--------------------------------------------------------------------------------*)

PROCEDURE SaveKiSettingsHook (hook : u.HookPtr; obj1, farbePtr : MD.APTR) : MD.APTR;
(****** bgSettings/SaveKiSettings ************************************************
*
*       NAME
*           SaveKiSettingsHook
*
*       SYNOPSIS
*           obj = SaveKiSettingsHook ( hook, obj1, farbePtr )
*
*           APTR = SaveKiSettingsHook ( HookPtr, APTR, APTR)
*
*       INPUTS
*           farbePtr - Zeiger auf die Farbe, dessen KiSettings gespeichert
*                      werden sollen.
*
*       FUNCTION
*           Speichert die Eistellungen für die Bewertungsfunktion.
*           Fragt User nach Filenamen.
*
*       NOTES
*
*       SEE ALSO
*
************************************************************************************
*)

VAR win      : i.WindowPtr;
    farbe    : LONGINT;
    datei    : d.FileHandlePtr;
    ver, rev : INTEGER;

BEGIN (* SaveKiSettingsHook *)

  farbe := y.CAST (LONGINTPTR, farbePtr)^;
  MM.get (obj1, MD.maWindow, y.ADR (win));
  IF rs.FileReq (fileReq, l.GetString (l.MSG_SAVE_FILE), y.ADR ("#?.car"), kiDir, kiFile, TRUE, win) THEN
    IF s.CanCopy (fileName, kiDir^) THEN
      s.Copy (fileName, kiDir^);
      IF D.AddPart (y.ADR (fileName), kiFile, SIZE (str.Str)) THEN
        ver := 1; rev := 0;
        IF fs.OpenCheckReq (datei, y.ADR (fileName), MM.MakeID ("MBKK"), ver, rev, FALSE, win) THEN
          SaveKiSettingsBlock (datei, farbe, win);
          D.Close (datei)
        END (* IF *)
      END (* IF *)
    END (* IF *)
  END; (* IF *)
  RETURN 0

END SaveKiSettingsHook;

(*--------------------------------------------------------------------------------*)

PROCEDURE LoadSettingsBlock (datei : d.FileHandlePtr; win : i.WindowPtr);
(****** bgSettings/LoadSettingsBlock ************************************************
*
*       NAME
*           LoadSettingsBlock
*
*       SYNOPSIS
*           LoadSettingsBlock ( datei, win )
*
*           LoadSettingsBlock ( FileHandlePtr, WindowPtr )
*
*       FUNCTION
*           Versucht einen SettingBlock aus der Datei zu laden.
*
*       INPUTS
*           datei - Datei mit SettingBlock.
*           win   - Fenster für RetryRequester.
*
*       NOTES
*
*       SEE ALSO
*
************************************************************************************
*)

BEGIN (* LoadSettingsBlock *)

  LoadKiSettingsBlock (datei, 1, win);
  LoadKiSettingsBlock (datei, 2, win);
  IF fs.ReadReq (datei, y.ADR (set), SIZE (set), win) = SIZE (set) THEN
    MM.set (mui.bgObj[0], MD.maCycleActive, set.player1);
    MM.set (mui.bgObj[1], MD.maCycleActive, set.player2);
    MM.set (mui.bgObj[2], MD.maCycleActive, set.trace);
    MM.set (mui.bgObj[3], MD.maNumericValue, set.level);
    MM.set (mui.bgObj[4], MD.maNumericValue, set.blink);
    MM.set (mui.bgObj[5], MD.maNumericValue, set.blinkTime);
    MM.set (mui.bgObj[6], MD.maNumericValue, set.boardType);
    MM.set (mui.itemIcons, MD.maMenuitemChecked, set.icons);
    MM.set (mui.bgObj[14], MD.maPendisplaySpec, y.ADR (set.whiteStone));
    MM.set (mui.bgObj[15], MD.maPendisplaySpec, y.ADR (set.blackStone));
    MM.set (mui.bgObj[16], MD.maPendisplaySpec, y.ADR (set.whiteField));
    MM.set (mui.bgObj[17], MD.maPendisplaySpec, y.ADR (set.blackField))
  END (* IF *)

END LoadSettingsBlock;

(*--------------------------------------------------------------------------------*)

PROCEDURE LoadSettings (name : y.ADDRESS);
(****** bgSettings/LoadSettings ************************************************
*
*       NAME
*           LoadSettings
*
*       SYNOPSIS
*           LoadSettings ( name )
*
*           Loadsettings ( ADDRESS )
*
*       INPUTS
*           name - Name der Konfigurationsdatei.
*
*       FUNCTION
*           Versucht die Einstellungen aus der Datei name zu
*           laden. Ist name NIl, wird vorher ein Filerequester
*           zum auswaehlen der Datei geöffnet.
*
*       NOTES
*
*       SEE ALSO
*
************************************************************************************
*)

VAR datei    : d.FileHandlePtr;
    ver, rev : INTEGER;
    win      : i.WindowPtr;

BEGIN (* LoadSettings *)

  MM.get (mui.window, MD.maWindow, y.ADR (win));
  IF name = NIL THEN
    IF rs.FileReq (fileReq, l.GetString (l.MSG_LOAD_FILE), y.ADR ("#?.pref"), prefDir, prefFile, FALSE, win) THEN
      IF s.CanCopy (fileName, prefDir^) THEN
        s.Copy (fileName, prefDir^);
        IF D.AddPart (y.ADR (fileName), prefFile, SIZE (str.Str)) THEN
          name := y.ADR (fileName)
        END (* IF *)
      END (* IF *)
    END (* IF *)
  END; (* IF *)
  IF name <> NIL THEN
    IF fs.OpenCheckReq (datei, name, MM.MakeID ("MBSE"), ver, rev, TRUE, win) THEN
      IF (ver = 1) AND (rev = 0) THEN
        LoadSettingsBlock (datei, win)
      END; (* IF *)
      D.Close (datei)
    END (* IF *)
  END (* IF *)

END LoadSettings;

(*--------------------------------------------------------------------------------*)

PROCEDURE SaveSettingsBlock (datei : d.FileHandlePtr; win : i.WindowPtr);
(****** bgSettings/LoadSettingsBlock ************************************************
*
*       NAME
*           SaveSettingsBlock
*
*       SYNOPSIS
*           SaveSettingsBlock ( datei, win )
*
*           SaveSettingsBlock ( FileHandlePtr, WindowPtr )
*
*       FUNCTION
*           Versucht einen SettingBlock in eine Datei zu speichern.
*
*       INPUTS
*           datei - Datei für SettingBlock.
*           win   - Fenster für RetryRequester.
*
*       NOTES
*
*       SEE ALSO
*
************************************************************************************
*)

VAR pen : MD.mPenSpecPtr;

BEGIN (* SaveSettingsBlock *)

  SaveKiSettingsBlock (datei, 1, win);
  SaveKiSettingsBlock (datei, 2, win);
  MM.get (mui.bgObj[14], MD.maPendisplaySpec, y.ADR (pen));
  set.whiteStone := pen^;
  MM.get (mui.bgObj[15], MD.maPendisplaySpec, y.ADR (pen));
  set.blackStone := pen^;
  MM.get (mui.bgObj[16], MD.maPendisplaySpec, y.ADR (pen));
  set.whiteField := pen^;
  MM.get (mui.bgObj[17], MD.maPendisplaySpec, y.ADR (pen));
  set.blackField := pen^;
  IF fs.WriteReq (datei, y.ADR (set), SIZE (set), win) = SIZE (set) THEN
  END (* IF *)

END SaveSettingsBlock;

(*--------------------------------------------------------------------------------*)

PROCEDURE SaveSettings (name : y.ADDRESS);
(****** bgSettings/SaveSettings ************************************************
*
*       NAME
*           SaveSettings
*
*       SYNOPSIS
*           SaveSettings ( name )
*
*           SaveSettings ( ADDRESS )
*
*       FUNCTION
*           Versucht die Einstellungen in die Datei name zu
*           speichern. Ist es ENVARC:MUIBackgammon, dann auch
*           gleichzeitig in die Datei ENV:MUIBackgammon.
*           Ist name NIL, wird ein Filerequester geöffnet.
*
*       INPUTS
*           name - Name der Konfigurationsdatei.
*
*       NOTES
*
*       SEE ALSO
*
************************************************************************************
*)

VAR datei             : d.FileHandlePtr;
    ver, rev, len     : INTEGER;
    win               : i.WindowPtr;
    dummy             : BOOLEAN;
    diskObj           : wb.DiskObjectPtr;
    defaultTool, tmp  : str.Str;
    lock              : d.FileLockPtr;
    fileInfo          : d.FileInfoBlock;

BEGIN (* SaveSettings *)

  MM.get (mui.window, MD.maWindow, y.ADR (win));
  IF name = NIL THEN
    IF rs.FileReq (fileReq, l.GetString (l.MSG_SAVE_FILE), y.ADR ("#?.pref"), prefDir, prefFile, TRUE, win) THEN
      IF s.CanCopy (fileName, prefDir^) THEN
        s.Copy (fileName, prefDir^);
        IF D.AddPart (y.ADR (fileName), prefFile, SIZE (str.Str)) THEN
          name := y.ADR (fileName)
        END (* IF *)
      END (* IF *)
    END (* IF *)
  END; (* IF *)
  IF name <> NIL THEN
    ver := 1; rev := 0;
    IF fs.OpenCheckReq (datei, name, MM.MakeID ("MBSE"), ver, rev, FALSE, win) THEN
      SaveSettingsBlock (datei, win);
      D.Close (datei);
      IF BOOLEAN (set.icons) AND (s.Compare (y.CAST (str.StrPtr, name)^, envName) <> 0)
      AND (s.Compare (y.CAST (str.StrPtr, name)^, envarcName) <> 0) THEN
        diskObj := IC.GetDefDiskObject (LONGINT (wb.project));
        IF diskObj <> NIL THEN
          lock := arg.GetLock (0);
          IF lock = NIL THEN
            dummy := D.GetCurrentDirName (y.ADR (defaultTool), SIZE (defaultTool))
          ELSE
            dummy := D.NameFromLock (arg.GetLock (0), y.ADR (defaultTool), SIZE (defaultTool))
          END; (* IF *)
          arg.GetArg (0, tmp, len);
          IF D.AddPart (y.ADR (defaultTool), y.ADR (tmp), SIZE (defaultTool)) THEN
            diskObj^.defaultTool := y.ADR (defaultTool)
          ELSE
            diskObj^.defaultTool := NIL
          END; (* IF *)
          diskObj^.stackSize := 10000;
          dummy := IC.PutDiskObject (name, diskObj)
        END (* IF *)
      END (* IF *)
    END (* IF *)
  END (* IF *)

END SaveSettings;

(*--------------------------------------------------------------------------------*)

VAR dummy      : BOOLEAN;
    len        : INTEGER;
    lock       : d.FileLockPtr;
    name, prog : str.Str;
    path       : str.StrPtr;

BEGIN (* bgSettings *)

  fileReq := rs.InitFileReq (0, 0, 0, 0);
  IF fileReq = NIL THEN a.Terminate END; (* IF *)
  lock := arg.GetLock (0);
  IF lock = NIL THEN
    dummy := D.GetCurrentDirName (y.ADR (name), SIZE (name))
  ELSE
    dummy := D.NameFromLock (arg.GetLock (0), y.ADR (name), SIZE (name))
  END; (* IF *)
  arg.GetArg (0, prog, len);
  IF D.AddPart (y.ADR (name), y.ADR (prog), SIZE (name)) THEN
    path := D.PathPart (y.ADR (name));
    path^[0] := 0C;
    IF D.AddPart (y.ADR (name), y.ADR ("Presets"), SIZE (name)) THEN
      h.Allocate (kiDir, s.Length (name)+1);
      h.Allocate (prefDir, s.Length (name)+1);
      IF (kiDir <> NIL) AND (prefDir <> NIL) THEN
        s.Copy (kiDir^, name);
        s.Copy (prefDir^, name)
      END (* IF *)
    END (* IF *)
  END; (* IF *)

CLOSE

  IF fileReq <> NIL THEN ASL.FreeAslRequest (fileReq) END; (* IF *)
  IF kiFile <> NIL THEN h.Deallocate (kiFile) END; (* IF *)
  IF kiDir <> NIL THEN h.Deallocate (kiDir) END; (* IF *)
  IF prefFile <> NIL THEN h.Deallocate (prefFile) END; (* IF *)
  IF prefDir <> NIL THEN h.Deallocate (prefDir) END; (* IF *)

END bgSettings.


