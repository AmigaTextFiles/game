MODULE bg;
(****h* bg/bg *************************************************
*
*       NAME
*           bg  ---  Backgammon
*
*       COPYRIGHT
*           © 1995, Marc Ewert
*
*       FUNCTION
*           Backgammon Spiel
*
*       AUTHOR
*           Marc Ewert
*
*       CREATION DATE
*           11.06.95
*
*       HISTORY
*           V1.00 - (11.03.95)
*                   * Erste Version
*           V2.00 - (..)
*                   * Komplett neu geschrieben, Einteilung in Subclasses
*
*       NOTES
*
************************************************************************************
*)

IMPORT

  a   : Arts,
  d   : DosD,
  E   : ExecL,
  i   : IntuitionD,
  I   : IntuitionL,
  IC  : IconL,
  l   : bgLocale,
  m   : bgMain,
  MC  : MuiClasses,
  MD  : MuiD,
  ML  : MuiL,
  MM  : MuiMacros,
  MS  : MuiSupport,
  ms  : MuiSup,
  mui : bgMui,
  s   : String,
  u   : UtilityD,
  wb  : WorkbenchD,
  y   : SYSTEM;

(*---------------------------------------------------------------------------*)
(*
PROCEDURE HandleArgs ();

CONST template = y.ADR ("FROM");
CONST help = y.ADR ("\nUsage: MUIBackgammon <from>\n<from>: name of configuration file");

TYPE Parameter = RECORD
                   name : mui.StrPtr;
                 END; (* RECORD *)

VAR rda, rdas  : d.RDArgsPtr;
    parms      : Parameter;
    name       : mui.Str;
    diskObject : wb.DiskObjectPtr;
    lock       : d.FileLockPtr;
    fileInfo   : d.FileInfoBlock;
    ch         : CHAR;

BEGIN (* HandleArgs *)

  parms.name := NIL;
  IF a.wbStarted THEN
    IF a.startupMsg <> NIL THEN
      diskObject := IC.GetDiskObject (y.CAST (wb.WBStartupPtr, a.startupMsg)^.argList^[0].name);
      IF diskObject <> NIL THEN
        parms.name := IC.FindToolType (diskObject^.toolTypes, y.ADR ("FROM"));
      END; (* IF *)
      IF y.CAST (wb.WBStartupPtr, a.startupMsg)^.numArgs > 1 THEN
        parms.name := y.CAST (wb.WBStartupPtr, a.startupMsg)^.argList^[1].name;
        lock := y.CAST (wb.WBStartupPtr, a.startupMsg)^.argList^[1].lock;
      END; (* IF *)
    END (* IF *)
  ELSE
    rdas := D.AllocDosObject (d.dosRdArgs, NIL);
    IF rdas <> NIL THEN
      rdas^.extHelp := help;
      rda := D.ReadArgs (template, y.ADR (parms), rdas)
    END (* IF *)
  END; (* IF *)

  name[0] := 0C;
  IF parms.name <> NIL THEN
    IF lock <> NIL THEN
      IF D.Examine (lock, y.ADR (fileInfo)) THEN
        IF s.CanCopy (name, fileInfo.fileName) THEN
          s.Copy (name, fileInfo.fileName);
          IF D.ParentDir (lock) <> NIL THEN ch := "/"
          ELSE ch := ":"
          END; (* IF *)
          IF s.CanConcatChar (name, ch) THEN s.ConcatChar (name, ch)
          END (* IF *)
        END (* IF *)
      END (* IF *)
    END; (* IF *)
    IF s.CanConcat (name, parms.name^) THEN
      s.Concat (name, parms.name^);
      set.LoadSettings (y.ADR (name))
    END (* IF *)
  ELSE
    set.LoadSettings (y.ADR (set.envName))
  END; (* IF *)

  IF rda <> NIL THEN D.FreeArgs (rda) END; (* IF *)
  IF rdas <> NIL THEN D.FreeDosObject (d.dosRdArgs, rdas) END; (* IF *)
  IF diskObject <> NIL THEN IC.FreeDiskObject (diskObject) END (* IF *)

END HandleArgs;
*)
(*--------------------------------------------------------------------------------*)

VAR signals  : y.LONGSET;
    app, win : MD.APTR;
    buffer   : ARRAY [0..16] OF LONGINT;

BEGIN (* Backgammon *)

  (* HandleArgs (); *)

  win := I.NewObjectA (m.MainClass^.class, NIL, y.TAG (buffer, u.tagDone));

  app := MM.ApplicationObject(y.TAG(buffer,
           MD.maApplicationTitle,        y.ADR("MUIBackgammon"),
           MD.maApplicationAuthor,       y.ADR("Marc Ewert"),
           MD.maApplicationVersion,      y.ADR("$VER: MUIBackgammon 1.0 (11.03.96)"),
           MD.maApplicationCopyright,    y.ADR("© 1996, Marc Ewert"),
           MD.maApplicationDescription,  y.ADR("Backgammon Game"),
           MD.maApplicationBase,         y.ADR("MUIBACKGAMMON"),
           (* MD.maApplicationMenustrip,    strip, *)
           MM.SubWindow,                 win,
           u.tagEnd));

  IF app <> NIL THEN
    MM.NoteClose (app, win, MD.mvApplicationReturnIDQuit);
    MM.set (win, MD.maWindowOpen, 1);
    signals := y.LONGSET{} ;
    LOOP
      IF MS.DOMethod (app, y.TAG (buffer, MD.mmApplicationNewInput, y.ADR(signals))) = MD.mvApplicationReturnIDQuit THEN EXIT END; (* IF *)
      IF signals <> y.LONGSET{} THEN
        INCL (signals, d.ctrlC);
        signals := E.Wait (signals);
        IF d.ctrlC IN signals THEN EXIT
        END (* IF *)
      END (* IF *)
    END; (* LOOP *)
    MM.set (win, MD.maWindowOpen, 0)
  END (* IF *)

CLOSE

  IF app <> NIL THEN ML.mDisposeObject (app)
  END (* IF *)

END bg.

