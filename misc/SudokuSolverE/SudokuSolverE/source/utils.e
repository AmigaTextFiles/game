OPT MODULE
OPT EXPORT

-> Defines to save typing through code
#define gsb(i,j,ch) game.setBoard(i,j,ch)
#define ggb(i,j) game.getBoard(i,j)
#define gsc(i,j,ch) game.insertCand(i,j,ch)
#define ggc(i,j) game.getCandidates(i,j)


MODULE 'intuition/intuition',
       'intuition/screens',
       'graphics/gfx', 'dos/dos', 'asl', 'libraries/asl'

MODULE '*globals','*sudokugui','*set', '*check'

DEF game:PTR TO gamedata
DEF req:PTR TO filerequester
DEF mainW : PTR TO sudokugui
DEF changed
DEF showconsole

PROC loadGame()
  DEF fh,i,j
  DEF ch
  DEF buffer[50]:STRING, path[255]:STRING
  DEF s[1]:STRING

  IF AslRequest(req, NIL) = NIL THEN RETURN FALSE

  IF InStr(req.drawer, ':') = (StrLen(req.drawer) - 1) -> : Root drawer, no slash needed
    StringF(path, '\s\s', req.drawer, req.file)
  ELSE
    StringF(path, '\s/\s', req.drawer, req.file)
  ENDIF

  fh := Open(path, MODE_OLDFILE)
  IF fh = 0
    mainW.addInfo(' !!Error openning game!!')
    Close(fh)
    RETURN FALSE 
  ENDIF
  FOR i:=1 TO 9
   ReadStr(fh, buffer)
   FOR j:= 1 TO 9
    ch:=buffer[j-1]
    IF ch < "0" OR ch > "9"
     Close(fh)
     Raise(ERR_FILE)
     RETURN
    ENDIF
    StringF(s,'\c',ch)
    gsb(i,j,Val(s))
   ENDFOR
 ENDFOR
 Close(fh)
ENDPROC TRUE

PROC inRow(row,num)
 DEF col

 FOR col:=1 TO 9
  IF ggb(row,col) = num THEN RETURN TRUE
 ENDFOR
 RETURN FALSE
ENDPROC

PROC inCol(col,num)
 DEF row

 FOR row:=1 TO 9
   IF ggb(row,col) = num THEN RETURN TRUE
 ENDFOR
 RETURN FALSE
ENDPROC

PROC inQuad(row,col,num)
 DEF rowini,colini,i,j

 rowini:=row-Mod(row-1,3)
 colini:=col-Mod(col-1,3)
 FOR i:=rowini TO rowini+2
  FOR j:=colini TO colini+2
   IF ggb(i,j) = num THEN RETURN TRUE
  ENDFOR
 ENDFOR
 RETURN FALSE
ENDPROC

PROC buildCandidates()
 DEF row,col,num
 DEF cands:PTR TO digiset

 FOR row:=1 TO 9
  FOR col:=1 TO 9
   IF ggb(row,col) = 0
    cands:= ggc(row,col)
    FOR num:=1 TO 9
     IF Not(inRow(row,num)) AND Not(inCol(col,num)) AND Not(inQuad(row,col,num))
      cands.insert(num)
     ENDIF
    ENDFOR	
   ENDIF
  ENDFOR
 ENDFOR
ENDPROC

PROC showCandidates()
 DEF row,col
 DEF cands:PTR TO digiset

 WriteF('   [   1   ][   2   ][   3   ][   4   ][   5   ][   6   ][   7   ][   8   ][   9   ]\n')
 FOR row:=1 TO 9
   WriteF('[\d]',row)
  FOR col:=1 TO 9
   cands:=ggc(row,col)
   WriteF('\s[9]',cands.toStr())
  ENDFOR
  WriteF('\n') 
 ENDFOR
ENDPROC

PROC solve()
 IF showconsole
  WriteF('Initial candidates\n') 
  showCandidates()
 ENDIF
 changed:=TRUE
 WHILE (changed) AND (NOT isSolved())
  changed:=FALSE
  mainW.addInfo('<<New iteration>>')
  checkUnique()
  checkHidden()
  checkHiddenSeveralInQ()
  IF NOT changed THEN checkNakedPairs()
  IF NOT changed THEN checkHiddenPairsRow()
  IF NOT changed THEN checkHiddenPairsCol()
  IF NOT changed THEN checkNakedTriples()
  IF NOT changed THEN checkYWingRow()
  IF NOT changed THEN checkYWingCol()  
  IF NOT changed THEN checkXYWing()

  mainW.drawBoard()
  IF showconsole
   WriteF('After iteration candidates\n')
   showCandidates()
  ENDIF
 ENDWHILE

 IF NOT isSolved()
  mainW.addInfo('#No more progress#')
  IF showconsole THEN WriteF('#No more progress#')
 ELSE
  IF showconsole THEN WriteF('#Solved#')
  mainW.addInfo('#Solved#')
 ENDIF    
ENDPROC

PROC isSolved()
 DEF i,j,total

 total:=0
 FOR i:=1 TO 9
  FOR j:=1 TO 9
   IF ggb(i,j) <> 0 THEN INC total
  ENDFOR
 ENDFOR
ENDPROC total=81