IMPLEMENTATION MODULE iomsound;

IMPORT
  Arts,AS:AudioSupport,E:ExecD,EL:ExecL,FS:FileSystem,SYSTEM,DosL,MedLib;

CONST
  CLICKNAME="stoneclick.dump";
  BACKNAME="mod.praeludium";

TYPE
  SHead	=
    RECORD
      len : LONGINT;
      rate: CARDINAL;
      data: SYSTEM.ADDRESS;
    END;

VAR
  f	: FS.File;
  click,
  back  : SHead;
  act	: LONGINT;
  chan  : SHORTINT;
  cl	: BOOLEAN;
  song	: MedLib.MMD0Ptr;
  on	: SHORTINT;

PROCEDURE LoadSound(name:ARRAY OF CHAR; VAR sound:SHead):BOOLEAN;

  BEGIN
    FS.Lookup(f,name,2048,FALSE);
    IF f.res#FS.done THEN RETURN FALSE END;
    FS.ReadByteBlock(f,sound.len);
    FS.ReadByteBlock(f,sound.rate);
    sound.data:=EL.AllocMem(sound.len,E.MemReqSet{E.chip,E.public});
    IF sound.data=NIL THEN
      FS.Close(f);
      RETURN FALSE;
    END;
    FS.ReadBytes(f,sound.data,sound.len,act);
    FS.Close(f);
    RETURN TRUE;
  END LoadSound;

PROCEDURE StoneClick;
  VAR
    per : LONGCARD;
  BEGIN
    IF NOT cl THEN RETURN END;
    per:=AS.clock DIV click.rate;
    AS.PlaySound(chan,click.data,click.len,per,64,1);
  END StoneClick;

PROCEDURE StartBackgroundSound;

  BEGIN
    IF NOT MedLib.GetPlayer(FALSE) THEN
      song:=MedLib.LoadModule(SYSTEM.ADR(BACKNAME));
      MedLib.PlayModule(song);
    END;
    on:=0;
  END StartBackgroundSound;

PROCEDURE SwitchBackSound;
  BEGIN
    on:=(on+1) MOD 3;
    CASE on OF
    | 0 : AS.CloseChannel(chan);
    	  IF NOT MedLib.GetPlayer(FALSE) THEN
            MedLib.PlayModule(song);
          ELSE
            chan:=AS.OpenChannel(SYSTEM.BITSET{0,1,2,3});
          END;
    | 1 : MedLib.DimOffPlayer(15);
    	  DosL.Delay(10);
    	  MedLib.FreePlayer();
          chan:=AS.OpenChannel(SYSTEM.BITSET{0,1,2,3});
    | 2 : MedLib.DimOffPlayer(15);
    	  DosL.Delay(10);
    	  MedLib.FreePlayer();
	  AS.CloseChannel(chan);
    ELSE;
    END;
  END SwitchBackSound;

BEGIN
  AS.SetPriority(127);
  AS.DontAbort;
  AS.Filter(FALSE);
  cl:=LoadSound(CLICKNAME,click);
CLOSE
  MedLib.DimOffPlayer(15);
  DosL.Delay(20);
  MedLib.UnLoadModule(song);
  MedLib.FreePlayer();
  AS.CloseChannel(chan);
  IF click.data#NIL THEN
    EL.FreeMem(click.data,click.len);
  END;
  AS.Filter(TRUE);
END iomsound.imp

