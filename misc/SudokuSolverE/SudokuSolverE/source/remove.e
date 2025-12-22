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

MODULE '*globals','*sudokugui','*set'

DEF game:PTR TO gamedata
DEF mainW : PTR TO sudokugui
DEF changed

PROC removeCandidates(row,col,num)
 DEF i,j,rowini,colini
 DEF cands:PTR TO digiset
 DEF s[80]:STRING

 rowini:=row-Mod(row-1,3)
 colini:=col-Mod(col-1,3)
 
 -> Remove in row
 FOR i:=1 TO 9
  cands:=ggc(row,i)
  IF cands.isIn(num)
   cands.remove(num)
   changed:=TRUE
   StringF(s,' Removed in row (\d,\d) \d',row,i,num)
   mainW.addInfo(s)
  ENDIF
 ENDFOR

 -> Remove in col
 FOR i:=1 TO 9
  cands:=ggc(i,col)
  IF cands.isIn(num)
   cands.remove(num)
   changed:=TRUE
   StringF(s,' Removed in col (\d,\d) \d',i,col,num)
   mainW.addInfo(s)
  ENDIF
 ENDFOR

 -> Remove in quad
 FOR i:=rowini TO rowini+2
  FOR j:=colini TO colini+2
   cands:=ggc(i,j)
   IF cands.isIn(num)
    cands.remove(num)
    changed:=TRUE
    StringF(s,' Removed in quad (\d,\d) \d',i,j,num)
    mainW.addInfo(s)
   ENDIF
  ENDFOR
 ENDFOR
ENDPROC

PROC removeRowAvoidingQ(row,num,qcol)
 DEF i
 DEF cands:PTR TO digiset
 DEF mod,div
 DEF s[80]:STRING

 FOR i:=1 TO 9
  mod,div:=Mod(i-1,3)
  IF div <> qcol
   cands:=ggc(row,i)
   IF cands.isIn(num)
    cands.remove(num)
    changed:=TRUE
    StringF(s,' Removed by several in row/quad (\d,\d) \d',row,i,num)
    mainW.addInfo(s)
   ENDIF
  ENDIF
 ENDFOR
ENDPROC

PROC removeColAvoidingQ(col,num,qrow)
 DEF i
 DEF cands:PTR TO digiset
 DEF mod,div
 DEF s[80]:STRING

 FOR i:=1 TO 9
  mod,div:=Mod(i-1,3)
  IF div <> qrow
   cands:=ggc(i,col)
   IF cands.isIn(num)
    cands.remove(num)
    changed:=TRUE
    StringF(s,' Removed by several in col/quad (\d,\d) \d',i,col,num)
    mainW.addInfo(s)
   ENDIF
  ENDIF
 ENDFOR
ENDPROC

PROC removeRowXYWing(row,col,num)
 DEF mod,div,colini,i
 DEF s[80]:STRING
 DEF cands:PTR TO digiset

 mod,div:=Mod(col-1,3)
 colini:=div*3+1
 FOR i:=colini TO colini+2
  cands:=ggc(row,i)
  IF cands.isIn(num)
   cands.remove(num)
   changed:=TRUE
   StringF(s,' Removed by XYWing in row (\d,\d) \d',row,i,num)
   mainW.addInfo(s)
  ENDIF
 ENDFOR
ENDPROC

PROC removeColXYWing(row,col,num)
 DEF mod,div,rowini,i
 DEF s[80]:STRING
 DEF cands:PTR TO digiset

 mod,div:=Mod(row-1,3)
 rowini:=div*3+1
 FOR i:=rowini TO rowini+2
  cands:=ggc(i,col)
  IF cands.isIn(num)
   cands.remove(num)
   changed:=TRUE
   StringF(s,' Removed by XYWing in col (\d,\d) \d',i,col,num)
   mainW.addInfo(s)
  ENDIF
 ENDFOR
ENDPROC

PROC removeColPair(col,row1,row2,pair:PTR TO digiset)
 DEF row
 DEF intersec:PTR TO digiset
 DEF cands:PTR TO digiset 
 DEF s[80]:STRING

 FOR row:=1 TO 9
  IF (row<>row1) AND (row<>row2)
   cands:=ggc(row,col)
   intersec:=cands.intersection(pair)
   IF NOT intersec.isEmpty()
    cands.differenceInPlace(pair)
    changed:=TRUE
    StringF(s,'Removed in col by naked pair (\d,\d) Pair \s',row,col,pair.toStr())
    mainW.addInfo(s)
   ENDIF
   END intersec 
  ENDIF
 ENDFOR
ENDPROC

PROC removeRowPair(row,col1,col2,pair:PTR TO digiset)
 DEF col
 DEF intersec:PTR TO digiset
 DEF cands:PTR TO digiset 
 DEF s[80]:STRING

 FOR col:=1 TO 9
  IF (col<>col1) AND (col<>col2)
   cands:=ggc(row,col)
   intersec:=cands.intersection(pair)
   IF NOT intersec.isEmpty()
    cands.differenceInPlace(pair)
    changed:=TRUE
    StringF(s,'Removed in row by naked pair (\d,\d) Pair \s',row,col,pair.toStr())
    mainW.addInfo(s)
   ENDIF 
   END intersec
  ENDIF
 ENDFOR
ENDPROC

PROC removeRowYWing(col1,col2,row1,row2,num)
 DEF row
 DEF s[80]:STRING
 DEF cands:PTR TO digiset

 FOR row:=1 TO 9
  IF (row<>row1) AND (row<>row2)
   cands:=ggc(row,col1)
   IF cands.isIn(num)
    cands.remove(num)
    changed:=TRUE
    StringF(s,' Removed by YWing in row (\d,\d) \d',row,col1,num)
    mainW.addInfo(s)
   ENDIF
   cands:=ggc(row,col2)
   IF cands.isIn(num)
    cands.remove(num)
    changed:=TRUE
    StringF(s,' Removed by YWing in row (\d,\d) \d',row,col2,num)
    mainW.addInfo(s)
   ENDIF   
  ENDIF
 ENDFOR
ENDPROC

PROC removeColYWing(row1,row2,col1,col2,num)
 DEF col
 DEF s[80]:STRING
 DEF cands:PTR TO digiset

 FOR col:=1 TO 9
  IF (col<>col1) AND (col<>col2)
   cands:=ggc(row1,col)
   IF cands.isIn(num)
    cands.remove(num)
    changed:=TRUE
    StringF(s,' Removed by YWing in col (\d,\d) \d',row1,col,num)
    mainW.addInfo(s)
   ENDIF
   cands:=ggc(row2,col)
   IF cands.isIn(num)
    cands.remove(num)
    changed:=TRUE
    StringF(s,' Removed by YWing in col (\d,\d) \d',row2,col,num)
    mainW.addInfo(s)
   ENDIF   
  ENDIF
 ENDFOR
ENDPROC