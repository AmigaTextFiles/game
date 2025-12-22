OPT LARGE

MODULE 'tools/easygui', 'tools/exceptions', 'tools/copylist', 'amigalib/lists',
       'intuition/intuition', 'plugins/imagebutton', 'exec/lists', 'exec/nodes',
       '*iconsdef','*classdef', 'tools/constructors', 'graphics/text', 'diskfont',
       'dos/dos', 'asl', 'libraries/asl'

DEF  bp1=NIL:PTR TO imagebutton, bp2=NIL:PTR TO imagebutton,
     bp3=NIL:PTR TO imagebutton, bp4=NIL:PTR TO imagebutton,
     bnew=NIL:PTR TO imagebutton, bload=NIL:PTR TO imagebutton,
     bdraw=NIL:PTR TO imagebutton, bsave=NIL:PTR TO imagebutton,
     bundo=NIL:PTR TO imagebutton, bstats=NIL:PTR TO imagebutton

DEF  handWinds, currentHand=0, winner, discarder, score
DEF  players[4]:ARRAY OF PTR TO CHAR
DEF  p1NameGad, p2NameGad, p3NameGad, p4NameGad,
     p1StatusGad, p2StatusGad, p3StatusGad, p4StatusGad, statusGad,
     discarderGad, winnerGad, scoreGad, infoGad

DEF mh=NIL, ghmain:PTR TO guihandle, ghnew:PTR TO guihandle, 
    ghwinhand:PTR TO guihandle, ghshow:PTR TO guihandle, ghstats:PTR TO guihandle, res

DEF hands[16]:ARRAY OF hand, fontdesc:PTR TO textattr

DEF req:PTR TO filerequester

ENUM ERR_NONE, ERR_ASL, ERR_KICK, ERR_LIB
 
PROC main() HANDLE

  IF KickVersion(36) = NIL THEN Raise(ERR_KICK)
  IF (aslbase := OpenLibrary('asl.library', 36)) = 0 THEN Raise(ERR_LIB) 
  IF (req := AllocAslRequest(ASL_FILEREQUEST,
               [ASL_HAIL, 'Select a file',
                ASL_HEIGHT, 200,
                ASL_WIDTH, 320,
                ASL_OKTEXT, 'Select',
                ASL_CANCELTEXT, 'Cancel', NIL])) = NIL THEN Raise(ERR_ASL)

  fontdesc := ['topaz.font', 8, FS_NORMAL, NIL]:textattr
  handWinds := ['ESWN','NESW','WNES','SWNE','SENW','ENWS','NWSE','WSEN','NWES',
               'WSNE','SEWN','ENSW','WNSE','SWEN','ESNW','NEWS']

  players[0] := String(50)
  players[1] := String(50)
  players[2] := String(50)
  players[3] := String(50)

  buildIcons()
  mh :=multiinit()

  ghmain := addmultiA(mh, 'MahjongScore',
    [ROWS,
      [COLS,
        [PLUGIN,{newGame},NEW bnew.imagebutton(new)],
        [PLUGIN,{loadGame},NEW bload.imagebutton(load)],
	[PLUGIN,{saveGame},NEW bsave.imagebutton(save,NIL,NIL,NIL,NIL,TRUE)],
        [SPACEH],
        [PLUGIN,{drawHand},NEW bdraw.imagebutton(draw,NIL,NIL,NIL,NIL,TRUE)],
        [PLUGIN,{undoHand},NEW bundo.imagebutton(undo,NIL,NIL,NIL,NIL,TRUE)],
        [SPACEH],
        [PLUGIN,{showStats},NEW bstats.imagebutton(stats,NIL,NIL,NIL,NIL,TRUE)]
      ],
      [SPACEV],
      [BAR],
      [SPACEV],
      [COLS,
        [PLUGIN,{handWon},NEW bp1.imagebutton(east,NIL,NIL,NIL,NIL,TRUE)],
        p1StatusGad := [TEXT, 'Player 1 | 0', NIL, FALSE, 4]
      ],
      [COLS,
        [PLUGIN,{handWon},NEW bp2.imagebutton(south,NIL,NIL,NIL,NIL,TRUE)],
        p2StatusGad := [TEXT, 'Player 2 | 0', NIL, FALSE, 4]
      ],
      [COLS,
        [PLUGIN,{handWon},NEW bp3.imagebutton(west,NIL,NIL,NIL,NIL,TRUE)],
        p3StatusGad := [TEXT, 'Player 3 | 0', NIL, FALSE, 4]
      ],
      [COLS,
        [PLUGIN,{handWon},NEW bp4.imagebutton(north,NIL,NIL,NIL,NIL,TRUE)],
        p4StatusGad := [TEXT, 'Player 4 | 0', NIL, FALSE, 4]
      ],
      [SPACEV],
      [BAR],
      [SPACEV],
      statusGad := [TEXT, 'Round: None Hand: None', NIL, FALSE, 4]
    ],
    [EG_WTYPE, WTYPE_NOSIZE, NIL])

  ghnew := addmultiA(mh, 'Players',
  [ROWS,
    [TEXT, 'Enter player names', NIL, FALSE, 3],
    [SPACEV],
    [SPACEV],
    [TEXT, 'Player #1', NIL, FALSE, 3],
    p1NameGad := [STR, {dummy}, '', players[0], 25, 5],
    [TEXT, 'Player #2', NIL, FALSE, 3],
    p2NameGad := [STR, {dummy}, '', players[1], 25, 5],
    [TEXT, 'Player #3', NIL, FALSE, 3],
    p3NameGad := [STR, {dummy}, '', players[2], 25, 5],
    [TEXT, 'Player #4', NIL, FALSE, 3],
    p4NameGad := [STR, {dummy}, '', players[3], 25, 5],
    [SPACEV],
    [SPACEV],
    [COLS,
      [BUTTON, {newOK}, 'Ok'],
      [BUTTON, {cancel}, 'Cancel']
    ]
  ],
  [EG_WTYPE, WTYPE_BASIC, EG_HIDE, TRUE, NIL])
   
  ghwinhand := addmultiA(mh, 'Hand won',
  [ROWS,
    [TEXT, 'Winner', NIL, FALSE, 3],
    [COLS,
      [SPACEH],
      winnerGad := [TEXT, 'Player #1', NIL, FALSE, 3]
    ],
    [TEXT, 'Discarder', NIL, FALSE, 3],
    discarderGad := [MX, {dummy}, NIL, ['One', 'Two', 'Three', 'Self-pick', NIL], FALSE, 0],
    [TEXT, 'Hand score', NIL, FALSE, 3],
    [COLS,
      [SPACEH],
      scoreGad := [INTEGER, {dummy}, NIL, NIL, 3]
    ],
    [SPACEV],
    [SPACEV],
    [COLS,
      [BUTTON, {winOK}, 'Ok'],
      [BUTTON, {cancel}, 'Cancel']
    ]
  ],
  [EG_WTYPE, WTYPE_BASIC, EG_HIDE, TRUE, NIL])

  ghshow := addmultiA(mh, 'Info',
  [ROWS,
    infoGad := [TEXT, 'The info', NIL, FALSE, 3],
    [SPACEV],
    [SPACEV],
    [BUTTON, {cancel}, 'Close']
  ],
    [EG_WTYPE, WTYPE_NOSIZE, EG_HIDE, TRUE, NIL])

  ghstats := addmultiA(mh, 'Game stats',
  [ROWS,
    [TEXT, 'The stats', NIL, FALSE, 3],
    [SPACEV],
    [SPACEV],
    [BUTTON, {cancel}, 'Close']
  ],
    [EG_WTYPE, WTYPE_NOSIZE, EG_HIDE, TRUE, EG_FONT, fontdesc, NIL])

  res := multiloop(mh)
EXCEPT DO
  END bnew,bp1,bp2, bp3, bp4, bsave, bload, bundo, bdraw, bstats
  Dispose(d1); Dispose(d2); Dispose(d3); Dispose(d4); Dispose(d5); Dispose(d6)
  Dispose(d7);Dispose(d8);Dispose(d9);Dispose(d10)
  cleanmulti(mh)
  IF req THEN FreeAslRequest(req)
  IF aslbase THEN CloseLibrary(aslbase)
  SELECT exception
    CASE ERR_ASL
      WriteF('Error: Impossible allocation of Requester ASL')
    CASE ERR_KICK
      WriteF('Error: asl.library < V36')
    CASE ERR_LIB
      WriteF('Error: Impossible opening of asl.library')
  ENDSELECT
  report_exception()
ENDPROC

PROC handWon(i,b:PTR TO imagebutton)
  SELECT b
    CASE bp1
      winner := 1
    CASE bp2
      winner := 2
    CASE bp3
      winner := 3
    CASE bp4
      winner := 4
    DEFAULT
      WriteF('Whaaaat!')
  ENDSELECT

  blockwin(ghmain)
  updateWinHand()
  openwin(ghwinhand)
ENDPROC

PROC refreshButtons()
  DEF winds:PTR TO CHAR

  IF currentHand = 17
    bp1.setdisabled(TRUE)
    bp2.setdisabled(TRUE)
    bp3.setdisabled(TRUE)
    bp4.setdisabled(TRUE)
    bdraw.setdisabled(TRUE)
    RETURN
  ENDIF

  bp1.setdisabled(FALSE)
  bp2.setdisabled(FALSE)
  bp3.setdisabled(FALSE)
  bp4.setdisabled(FALSE)

  bstats.setdisabled(FALSE)

  bsave.setdisabled(FALSE)
  bdraw.setdisabled(FALSE)
  IF currentHand > 1
    bundo.setdisabled(FALSE)
  ELSE
    bundo.setdisabled(TRUE)
  ENDIF

  winds := ListItem(handWinds,currentHand-1)

  setButtonImage(bp1, winds[0])
  setButtonImage(bp2, winds[1])
  setButtonImage(bp3, winds[2])
  setButtonImage(bp4, winds[3])
ENDPROC

PROC refreshStatus()
  DEF label[60]:STRING
  DEF round[10]:STRING
  DEF hand


  StringF(label, '\s | \d', players[0], computePlayerScore(1))
  settext(ghmain, p1StatusGad, label)
  StringF(label, '\s | \d', players[1], computePlayerScore(2))
  settext(ghmain, p2StatusGad, label)
  StringF(label, '\s | \d', players[2], computePlayerScore(3))
  settext(ghmain, p3StatusGad, label)
  StringF(label, '\s | \d', players[3], computePlayerScore(4))
  settext(ghmain, p4StatusGad, label)


  SELECT 20 OF currentHand
    CASE 1,2,3,4
      round := 'EAST'
    CASE 5,6,7,8
      round := 'SOUTH'
    CASE 9,10,11,12
      round := 'WEST'
    CASE 13,14,15,16,17
      round := 'NORTH'
    DEFAULT
      round := 'Whaaat!'
  ENDSELECT

  hand := currentHand
  IF currentHand = 17 THEN hand := 16
  
  StringF(label, 'Round: \s Hand: \d', round, hand)
  settext(ghmain, statusGad, label)
ENDPROC

PROC setButtonImage(bp:PTR TO imagebutton, wind)
  SELECT wind
    CASE "E"
      bp.setimage(east)
    CASE "S"
      bp.setimage(south)
    CASE "W"
      bp.setimage(west)
    CASE "N"
      bp.setimage(north)
    DEFAULT
      WriteF('Whaaaat!')
  ENDSELECT
ENDPROC

PROC newGame(i,b:PTR TO imagebutton)
  blockwin(ghmain)
  openwin(ghnew)
ENDPROC

PROC newOK(info:PTR TO guihandle)
  StrCopy(players[0], getstr(ghnew, p1NameGad))
  StrCopy(players[1], getstr(ghnew, p2NameGad))
  StrCopy(players[2], getstr(ghnew, p3NameGad))
  StrCopy(players[3], getstr(ghnew, p4NameGad))
  unblockwin(ghmain)
  closewin(ghnew)
  currentHand :=1
  refreshButtons()
  refreshStatus()
ENDPROC

PROC cancel(info:PTR TO guihandle)
  unblockwin(ghmain)
  closewin(info)
ENDPROC

PROC dummy()
ENDPROC

PROC undoHand()
  currentHand--
  refreshButtons()
  refreshStatus()
ENDPROC

PROC computePlayerScore(pl)
  DEF total=0, i
  
  FOR i:= 1 TO currentHand - 1
    total := total + hands[i-1].scores[pl-1]
  ENDFOR

  RETURN total
ENDPROC

PROC winOK(info:PTR TO guihandle)
  DEF pl

  score := getinteger(ghwinhand, scoreGad)

  IF score < 8
    settext(ghshow, infoGad, 'Score cannot be less than 8')
    openwin(ghshow)
    RETURN
  ENDIF
  unblockwin(ghmain)
  closewin(ghwinhand)
  hands[currentHand-1].hand := currentHand
  hands[currentHand-1].winner := winner
  hands[currentHand-1].discarder := discarder
  hands[currentHand-1].scorehand := score
  IF discarder = 0 -> Self-pick
    hands[currentHand-1].scores[winner-1] := (score + 8) * 3
    FOR pl := 1 TO 4
      IF pl <> winner
        hands[currentHand-1].scores[pl-1] := (score + 8) * -1
      ENDIF
    ENDFOR
  ELSE -> Normal win
    FOR pl := 1 TO 4
      IF pl = discarder
        hands[currentHand-1].scores[pl-1] := (score + 8) * -1
      ELSEIF pl = winner
        hands[currentHand-1].scores[pl-1] := score + 24
      ELSE
        hands[currentHand-1].scores[pl-1] := -8
      ENDIF
    ENDFOR
  ENDIF
  currentHand++
  refreshButtons()
  refreshStatus()
ENDPROC

PROC drawHand()
  DEF pl

  hands[currentHand-1].hand := currentHand
  hands[currentHand-1].winner := 0
  hands[currentHand-1].discarder := 0
  hands[currentHand-1].scorehand := 0
  FOR pl := 1 TO 4
      hands[currentHand-1].scores[pl-1] := 0
  ENDFOR
  currentHand++
  refreshButtons()
  refreshStatus()
ENDPROC

PROC showStats()
  DEF list:PTR TO lh, i, hand
  DEF disc, win, line

  hand := currentHand
  IF hand = 17 THEN hand := 16

  list := newlist()
  AddTail(list, newnode(NIL, 'Hand Score Winn. Disc.  P1   P2   P3   P4 '))
  AddTail(list, newnode(NIL, '==== ===== ===== ===== ==== ==== ==== ===='))
 
  FOR i:=1 TO hand - 1
      disc := String(5)
      win := String(5)
      IF hands[i-1].scorehand = 0 -> Draw hand
        disc := 'None'
        win := 'None'
      ELSE
        IF hands[i-1].discarder = 0
          disc := 'SP'
        ELSE
          StringF(disc,'\d', hands[i-1].discarder)
        ENDIF
        StringF(win,'\d', hands[i-1].winner)
      ENDIF
      line := String(50)
      StringF(line, '\d[4] \d[5] \s[5] \s[5] \d[4] \d[4] \d[4] \d[4]', hands[i-1].hand, hands[i-1].scorehand,
             win, disc, hands[i-1].scores[0], hands[i-1].scores[1], 
             hands[i-1].scores[2], hands[i-1].scores[3])
      AddTail(list, newnode(NIL, line))
  ENDFOR
  AddTail(list, newnode(NIL,'   '))
  line := String(50)
  StringF(line, '\s[22] \d[4] \d[4] \d[4] \d[4]', 'Total:',
         computePlayerScore(1), computePlayerScore(2), computePlayerScore(3), computePlayerScore(4))
  AddTail(list, newnode(NIL, line))

  changegui(ghstats,
    [ROWS,
      [LISTV,{dummy},'', 45, 18, list, TRUE, 0, 0],
      [SPACEV],
      [SPACEV],
      [BUTTON, {cancel}, 'Close']
    ])

    openwin(ghstats)
ENDPROC

PROC updateWinHand()

  DEF playersList

  discarder := 1 -> Initilize the default discarder element in MX

  SELECT winner
    CASE 1
      playersList := [players[1], players[2], players[3], 'Self-pick', NIL]
      discarder := 2 -> Just in case the winner is 1
    CASE 2
      playersList := [players[0], players[2], players[3], 'Self-pick', NIL]
    CASE 3
      playersList := [players[0], players[1], players[3], 'Self-pick', NIL]
    CASE 4
      playersList := [players[0], players[1], players[2], 'Self-pick', NIL]
  ENDSELECT

  changegui(ghwinhand,
   [ROWS,
    [TEXT, 'Winner', NIL, FALSE, 3],
    [COLS,
      [SPACEH],
      winnerGad := [TEXT, players[winner-1], NIL, FALSE, 3]
    ],
    [TEXT, 'Discarder', NIL, FALSE, 3],
    discarderGad := [MX, {setDiscarder}, NIL, playersList, FALSE, 0],
    [TEXT, 'Hand score', NIL, FALSE, 3],
    [COLS,
      [SPACEH],
      scoreGad := [INTEGER, {dummy}, NIL, NIL, 3]
    ],
    [SPACEV],
    [SPACEV],
    [COLS,
      [BUTTON, {winOK}, 'Ok'],
      [BUTTON, {cancel}, 'Cancel']
    ]
  ])
  setmx(ghwinhand, discarderGad, 0)
  setinteger(ghwinhand, scoreGad, 0)
ENDPROC

PROC setDiscarder(selected)
  IF selected = 3
    discarder := 0 -> Self-pick
  ELSE
    SELECT winner
      CASE 1
        discarder := selected + 2
      CASE 2
        IF selected = 0
          discarder := 1
        ELSE
          discarder := selected + 2
        ENDIF
      CASE 3
        IF selected = 2
          discarder := 4
        ELSE
          discarder := selected + 1
        ENDIF
      CASE 4
        discarder := selected + 1
    ENDSELECT
  ENDIF
ENDPROC

PROC saveGame()
  DEF fh, i, hand, path[255]:STRING
 
  IF currentHand = 17 THEN hand := 16 ELSE hand := currentHand

  IF AslRequest(req, NIL) = NIL THEN RETURN

  IF InStr(req.drawer, ':') = (StrLen(req.drawer) - 1) -> : Root drawer, no slash needed
    StringF(path, '\s\s', req.drawer, req.file)
  ELSE
    StringF(path, '\s/\s', req.drawer, req.file)
  ENDIF

  fh := Open(path, MODE_NEWFILE)
  PutF(fh, '\s\n', '#MSF#')
  PutF(fh, '\s\n', players[0])
  PutF(fh, '\s\n', players[1])
  PutF(fh, '\s\n', players[2])
  PutF(fh, '\s\n', players[3])
  PutF(fh, '\d\n', currentHand)
  FOR i := 1 TO hand - 1
    PutF(fh, '\d \d \d \d \d \d \d \d\n', hands[i-1].hand, hands[i-1].scorehand,
             hands[i-1].winner, hands[i-1].discarder, hands[i-1].scores[0], hands[i-1].scores[1], 
             hands[i-1].scores[2], hands[i-1].scores[3]) 
  ENDFOR 
  Close(fh)
ENDPROC

PROC loadGame()
  DEF fh, i, value, charsread, p:PTR TO CHAR
  DEF buffer[50]:STRING, path[255]:STRING
 
  IF AslRequest(req, NIL) = NIL THEN RETURN

  IF InStr(req.drawer, ':') = (StrLen(req.drawer) - 1) -> : Root drawer, no slash needed
    StringF(path, '\s\s', req.drawer, req.file)
  ELSE
    StringF(path, '\s/\s', req.drawer, req.file)
  ENDIF

  fh := Open(path, MODE_OLDFILE)
  IF fh = 0
    settext(ghshow, infoGad, 'Error opening game saved')
    openwin(ghshow)
    Close(fh)
    RETURN  
  ENDIF
  ReadStr(fh, buffer)
  IF StrCmp( buffer, '#MSF#') = 0
    settext(ghshow, infoGad, 'Not a game file')
    openwin(ghshow)
    Close(fh)
    RETURN  
  ENDIF
  ReadStr(fh, players[0])
  ReadStr(fh, players[1])
  ReadStr(fh, players[2])
  ReadStr(fh, players[3])
  ReadStr(fh, buffer)
  currentHand := Val(buffer)
  FOR i := 1 TO currentHand - 1
    ReadStr(fh, buffer)
    p := buffer  
    value, charsread := Val(p)
    hands[i-1].hand := value
    p += charsread
    value, charsread := Val(p)
    hands[i-1].scorehand := value
    p += charsread
    value, charsread := Val(p)
    hands[i-1].winner := value
    p += charsread
    value, charsread := Val(p)
    hands[i-1].discarder := value
    p += charsread
    value, charsread := Val(p)
    hands[i-1].scores[0] := value
    p += charsread
    value, charsread := Val(p)
    hands[i-1].scores[1] := value
    p += charsread
    value, charsread := Val(p)
    hands[i-1].scores[2] := value
    p += charsread
    value, charsread := Val(p)
    hands[i-1].scores[3] := value
  ENDFOR
  Close(fh)
  refreshButtons()
  refreshStatus()
ENDPROC