-> $VER: PFLaunch.e 1.2 (11.04.98)

/*
Sneaky space-saving constructs

I'm using two constants MEMSIZE and NVBLOCK, which are precalculated
calculations with the constant HSLEN (they are HSLEN+10 and HSLEN/10+1,
respectively)

Why generate code to manipulate constants?!

Uses raw menupick values instead of pulling them out with (code generating)
macros. But why are the values $FFFFxxxx ? Well, because msg.code is an INT,
when I write code:=msg.code, E extracts the INT and sign-extends it to a
LONG. As bit 15 is always set (NOSUBMENU), it's always considered negative.
I could write code:=code AND $FFFF but that's more code for nothing! :)
*/


OPT OSVERSION=39, PREPROCESS

MODULE	'dos/dos', 'exec/memory', 'exec/nodes', 'exec/ports',
	'gadtools', 'libraries/gadtools', 'graphics/rastport',
	'graphics/text', 'intuition/intuition', 'intuition/screens',
	'lowlevel', 'nonvolatile', 'utility/tagitem', 'workbench/startup'

#define DEF_SCORES [ \
"TSL ",0,$50000000, "TSL ",0,$25000000, "TSL ",0,$10000000, "TSL ",0,$05000000, \
"TSL ",1,$00000000, "TSL ",0,$50000000, "TSL ",0,$25000000, "TSL ",0,$10000000, \
"   P","ARTY"," LAN","D   ", "  SP","EED ","DEVI","LS  ", \
"TSL ",1,$00000000, "TSL ",0,$50000000, "TSL ",0,$25000000, "TSL ",0,$10000000, \
"TSL ",1,$00000000, "TSL ",0,$50000000, "TSL ",0,$25000000, "TSL ",0,$10000000, \
" BIL","LION"," DOL","LAR ", " STO","NES ","N BO","NES "\
]

CONST HSLEN=256, MEMSIZE=266, NVBLOCKS=26

OBJECT table
  name, disk:CHAR, hs_off:CHAR
ENDOBJECT

DEF w:PTR TO window, s:PTR TO screen, tables:PTR TO table, hs

->---------------------------------------------------------------------------

PROC main()
  DEF dir, newdir=NIL

  tables := [
    'Party Land',              "2", 0,
    'Speed Devils',            "1", 48,
    'Million Dollar Gameshow', "3", 128,
    'Stones ''n'' Bones',      "4", 176
  ]:table

  SetChipRev(-1)

  IF newdir := GetProgramDir() THEN
    IF newdir := DupLock(newdir) THEN
      dir := CurrentDir(newdir)

  IF gadtoolsbase := OpenLibrary('gadtools.library', 39)
    IF nvbase := OpenLibrary('nonvolatile.library', 39)
      IF lowlevelbase := OpenLibrary('lowlevel.library', 39)
        IF hs := AllocVec(MEMSIZE, MEMF_CLEAR)
          IF s := LockPubScreen(NIL)

            createwindow()

            UnlockPubScreen(NIL, s)
          ENDIF
          FreeVec(hs)
        ENDIF
        CloseLibrary(lowlevelbase)
      ENDIF
      CloseLibrary(nvbase)
    ENDIF
    CloseLibrary(gadtoolsbase)
  ENDIF

  IF newdir THEN UnLock(CurrentDir(dir))
ENDPROC

->---------------------------------------------------------------------------

#define TXTLEN(x) TextLength(rp, bla := x, StrLen(bla))

PROC createwindow()
  DEF font:PTR TO textfont, gad:PTR TO gadget, rp:PTR TO rastport,
      gadlist, vi, menus, n, bla,
      gad_w=0, gad_h, off_x, off_y, wnd_w, wnd_h

  -> font sensitive gadget layout calculations
  rp := s.rastport
  font := rp.font

  off_x := s.wborleft
  off_y := s.wbortop + rp.txheight + 1

  -> gadget size
  FOR n := 0 TO 3 DO gad_w := Max(gad_w, 32 + TXTLEN(tables[n].name))
  gad_h := 6 + font.ysize

  -> window size
  wnd_w := off_x + s.wborright  + gad_w
  wnd_h := off_y + s.wborbottom + (gad_h * 4)

  IF vi := GetVisualInfoA(s, NIL)
    IF gad := CreateContext({gadlist})
      FOR n := 0 TO 3 DO gad := CreateGadgetA(BUTTON_KIND, gad, [
        off_x, off_y + (n*gad_h), -> xpos, ypos
        gad_w, gad_h,             -> width, height
        tables[n].name,           -> name
        s.font, n, 16, vi, 0
      ]:newgadget, NIL)

      IF menus := CreateMenusA([
        NM_TITLE, 0, 'Project',   NIL, 0,0,0,
        NM_ITEM,  0, 'About...',  '?', 0,0,0,
        NM_ITEM,  0, NM_BARLABEL, NIL, 0,0,0,
        NM_ITEM,  0, 'Quit',      'Q', 0,0,0,
        NM_END,   0, NIL,         NIL, 0,0,0
      ]:newmenu, NIL)

        IF LayoutMenusA(menus, vi, [GTMN_NEWLOOKMENUS, TRUE, TAG_DONE])

          IF w := OpenWindowTagList(NIL, [
            WA_LEFT,   (s.width - wnd_w) / 2,
            WA_TOP,    (s.height - wnd_h) / 2,
            WA_WIDTH,  wnd_w,
            WA_HEIGHT, wnd_h,

            WA_IDCMP, IDCMP_REFRESHWINDOW OR IDCMP_VANILLAKEY OR
                      IDCMP_GADGETUP      OR IDCMP_CLOSEWINDOW OR
                      IDCMP_MENUPICK,
            WA_FLAGS, WFLG_CLOSEGADGET OR WFLG_ACTIVATE OR WFLG_DRAGBAR OR
                      WFLG_DEPTHGADGET OR WFLG_NEWLOOKMENUS,

            WA_TITLE, 'Pinball Fantasies AGA',
            WA_SCREENTITLE, 'PFLaunch by Kyzer/CSG <kyzer@4u.net>',

            WA_PUBSCREEN, s,
            WA_GADGETS, gadlist,
            TAG_DONE
          ])

          IF SetMenuStrip(w, menus)
            Gt_RefreshWindow(w, NIL)

            handlewindow()

            ClearMenuStrip(w)
            ENDIF
            CloseWindow(w)
          ENDIF
        ENDIF
        FreeMenus(menus)
      ENDIF
      FreeGadgets(gadlist)
    ENDIF
    FreeVisualInfo(vi)
  ENDIF
ENDPROC

->---------------------------------------------------------------------------

PROC handlewindow()
  DEF iaddr:PTR TO gadget, msg:PTR TO intuimessage,
      code, class, quitflag=0

  REPEAT
    WaitPort(w.userport)
    WHILE msg := Gt_GetIMsg(w.userport)
      class := msg.class
      code  := msg.code
      iaddr := msg.iaddress
      Gt_ReplyIMsg(msg)

      SELECT class
      CASE IDCMP_REFRESHWINDOW
        Gt_BeginRefresh(w)
        Gt_EndRefresh(w, TRUE)

      CASE IDCMP_CLOSEWINDOW
        quitflag := TRUE

      CASE IDCMP_VANILLAKEY
        IF (code >= "1") AND (code <= "4")
          play(code - "1")
        ENDIF
        IF (code = "Q") OR (code = "q") OR (code = "\e")
          quitflag:=TRUE
        ENDIF

      CASE IDCMP_GADGETUP
        play(iaddr.gadgetid)  -> gadgetid is 0-3

      CASE IDCMP_MENUPICK
        SELECT code
        CASE $FFFFF800   -> 'About...'
          request('by Digital Illusions.\n\n'+
            'Published by 21st Century Entertainment.', 'OK'
          )
        CASE $FFFFF840   -> 'Quit'
          quitflag:=TRUE
        ENDSELECT
      ENDSELECT
    ENDWHILE
  UNTIL quitflag
ENDPROC

->---------------------------------------------------------------------------

PROC play(lev)
  DEF req:requester, nv, gamedata:PTR TO LONG,
      dir, loadfile, olddir, file, disk
  
  disk := 'PFx:'
  file := 'pinfilex.dat'
  disk[2] := tables[lev].disk
  file[7] := lev + "a"

  IF nv := GetCopyNV('Pinball', 'Highscore', TRUE)
    CopyMem(nv, hs, HSLEN)
    FreeNVData(nv)
  ELSE
    CopyMem(DEF_SCORES, hs, HSLEN)
  ENDIF

  InitRequester(req)
  Request(req, w)
  SetWindowPointerA(w, [WA_BUSYPOINTER, TRUE, TAG_DONE])

  IF (loadfile := LoadSeg(file))=0
    IF dir := Lock(disk, SHARED_LOCK)
      olddir := CurrentDir(dir)
      loadfile := LoadSeg(file)
      CurrentDir(olddir)
      UnLock(dir)
    ENDIF
  ENDIF

  ClearPointer(w)
  EndRequest(req, w)

  IF loadfile=0
    request('Can''t load table', 'OK')
    RETURN
  ENDIF

  -> this is the data that the game code wants
  gamedata := [
    0, hs+tables[lev].hs_off, hs, dosbase, gfxbase, nvbase, lowlevelbase,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  ]

  Delay(50)
  CacheClearU()

	MOVEM.L	D1-D7/A0-A6,-(A7)
	MOVE.L	loadfile,A0
	MOVE.L	gamedata,A5

	ADDA.L	A0,A0
	ADDA.L	A0,A0
	JSR	4(A0)

	MOVEM.L	(A7)+,D1-D7/A0-A6
	TST.L	D0
	BEQ	noscores

  REPEAT
    IF StoreNV('Pinball', 'Highscore', hs, NVBLOCKS, FALSE)=0 THEN
      JUMP out
  UNTIL request('Can''t save highscores', 'Retry|Cancel')=0
out:

noscores:
  UnLoadSeg(loadfile)
ENDPROC

PROC request(a, b) IS EasyRequestArgs(w, [20, 0, 0, a, b], NIL, NIL)

CHAR '$VER: PFLaunch 1.2 (13.04.98)\0'
