OPT MODULE
OPT EXPORT

MODULE 'afc/iffparser'

CONST MAXPATH=256

OBJECT pfkprefs
  screenmode:LONG
  screenoverscan:LONG
  screenautoscroll:CHAR
  wbwindow:CHAR
  animspeed:CHAR
  usebounds:CHAR
  regions:CHAR
  bounds:CHAR
  pointer:CHAR
  -> paths
  setsdir[MAXPATH]:STRING
  filepattern[32]:STRING
/*
        usefollow:=buffy[7]
        usesnap:=buffy[8]
        usenasty:=buffy[9]
*/
ENDOBJECT

PROC prefs_save(prefs:PTR TO pfkprefs,filename:PTR TO CHAR)
  DEF iff:PTR TO iffparser
  iff.iffparser()
  iff.save(filename)
  iff.createchunk("PREF","FORM")
  iff.createchunk("PREF","PRHD")
  iff.writechunk(prefs, SIZEOF pfkprefs)
  iff.closechunk()
  iff.closechunk()
  iff.close()
  END iff
ENDPROC

PROC prefs_load(prefs:PTR TO pfkprefs,filename:PTR TO CHAR)
  DEF tmp
  DEF iff:PTR TO iffparser
  iff.iffparser()
  iff.load(filename)
  tmp:=iff.first("PREF","PRHD")
  CopyMem(tmp,prefs,SIZEOF pfkprefs)
  iff.close()
  END iff
ENDPROC prefs

