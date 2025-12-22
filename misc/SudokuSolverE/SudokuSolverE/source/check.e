OPT MODULE
OPT EXPORT

-> Defines to save typing through code
#define gsb(i,j,ch) game.setBoard(i,j,ch)
#define ggb(i,j) game.getBoard(i,j)
#define gsc(i,j,ch) game.insertCand(i,j,ch)
#define ggc(i,j) game.getCandidates(i,j)


MODULE '*globals','*sudokugui','*set', '*remove'

DEF game:PTR TO gamedata
DEF mainW : PTR TO sudokugui
DEF changed

-> Check for alone in candidates set
PROC checkUnique()
 DEF row,col
 DEF cands:PTR TO digiset
 DEF s[80]:STRING
 DEF num

 FOR row:=1 TO 9
  FOR col:=1 TO 9
   cands:=ggc(row,col)
   IF cands.card() = 1
    num:=Val(cands.toStr())
    gsb(row,col,num)
    StringF(s,' Fixed unique (\d,\d) \d',row,col,num)
    cands.empty()
    mainW.addInfo(s)
    removeCandidates(row,col,num)
   ENDIF
  ENDFOR
 ENDFOR
ENDPROC

-> Check for only hidden candidates in rows or columns
PROC checkHidden()
 DEF amount[10]:ARRAY
 DEF position[10]:ARRAY
 DEF i,j,row,col
 DEF cands:PTR TO digiset
 DEF s[80]:STRING

 -> Check if hidden in rows
 FOR row:=1 TO 9
  FOR i:=1 TO 9
   amount[i]:=0
   position[i]:=0
  ENDFOR
  FOR j:=1 TO 9
   cands:=ggc(row,j)
   FOR i:=1 TO 9
    IF cands.isIn(i)
     amount[i] := amount[i] + 1
     position[i] := j
    ENDIF
   ENDFOR 
  ENDFOR
  FOR i:=1 TO 9
   IF amount[i] = 1
    gsb(row,position[i],i)
    cands:=ggc(row,position[i])
    cands.empty()
    StringF(s,' Fixed hidden by row (\d,\d) \d',row,position[i],i)
    mainW.addInfo(s)
    removeCandidates(row,position[i],i)
   ENDIF
  ENDFOR
 ENDFOR 

 -> Check if hidden in cols
 FOR col:=1 TO 9
  FOR i:=1 TO 9
   amount[i]:=0
   position[i]:=0
  ENDFOR
  FOR j:=1 TO 9
   cands:=ggc(j,col)
   FOR i:=1 TO 9
    IF cands.isIn(i)
     amount[i] := amount[i] + 1
     position[i] := j
    ENDIF
   ENDFOR 
  ENDFOR
  FOR i:=1 TO 9
   IF amount[i] = 1
    gsb(position[i],col,i)
    cands:=ggc(position[i],col)
    cands.empty()
    StringF(s,' Fixed hidden by col (\d,\d) \d',position[i],col,i)
    mainW.addInfo(s)
    removeCandidates(position[i],col,i)
   ENDIF
  ENDFOR
 ENDFOR 
ENDPROC

PROC checkHiddenSeveralInQ()
 DEF qrow,qcol,row,col,num
 DEF cands:PTR TO digiset
 DEF s[80]:STRING
 DEF amount[4]:ARRAY
 
 FOR qrow:=0 TO 2
  FOR qcol:=0 TO 2
   -> Check the three rows
   FOR num:=1 TO 9
    amount[1]:=0
    amount[2]:=0
    amount[3]:=0
    FOR row:=1 TO 3
     FOR col:=1 TO 3
      cands:=ggc(qrow*3+row,qcol*3+col)
      IF cands.isIn(num)
       amount[row]:=amount[row]+1
      ENDIF
     ENDFOR
    ENDFOR
    IF (amount[1] > 0) AND (amount[2] = 0) AND (amount[3] = 0) 
     removeRowAvoidingQ(qrow*3+1,num,qcol)
    ENDIF
    IF (amount[1] = 0) AND (amount[2] > 0) AND (amount[3] = 0) 
     removeRowAvoidingQ(qrow*3+2,num,qcol)
    ENDIF
    IF (amount[1] = 0) AND (amount[2] = 0) AND (amount[3] > 0) 
     removeRowAvoidingQ(qrow*3+3,num,qcol)
    ENDIF
   ENDFOR
  -> Check the three cols 
   FOR num:=1 TO 9
    amount[1]:=0
    amount[2]:=0
    amount[3]:=0
    FOR col:=1 TO 3
     FOR row:=1 TO 3
      cands:=ggc(qrow*3+row,qcol*3+col)
      IF cands.isIn(num)
       amount[col]:=amount[col]+1
      ENDIF
     ENDFOR
    ENDFOR
    IF (amount[1] > 0) AND (amount[2] = 0) AND (amount[3] = 0) 
     removeColAvoidingQ(qcol*3+1,num,qrow)
    ENDIF
    IF (amount[1] = 0) AND (amount[2] > 0) AND (amount[3] = 0) 
     removeColAvoidingQ(qcol*3+2,num,qrow)
    ENDIF
    IF (amount[1] = 0) AND (amount[2] = 0) AND (amount[3] > 0) 
     removeColAvoidingQ(qcol*3+3,num,qrow)
    ENDIF
   ENDFOR
  ENDFOR
 ENDFOR 
ENDPROC

PROC checkXYWing()
 DEF cands1:PTR TO digiset
 DEF cands2:PTR TO digiset
 DEF cands3:PTR TO digiset
 DEF np:PTR TO digiset
 DEF intersec:PTR TO digiset
 DEF difference:PTR TO digiset 
 DEF difference2:PTR TO digiset
 DEF pstr[1]:STRING
 DEF i,j,k,row,col,qrow,qrow2,qcol,qcol2,rowini,colini,p,mod

 FOR qrow:=0 TO 2
  FOR qcol:=0 TO 2
   rowini:=qrow*3+1
   colini:=qcol*3+1
   FOR row:=rowini TO rowini+2
    FOR col:=colini TO colini+2
     cands1:=ggc(row,col)
     IF (cands1.card()=2)
      FOR i:=rowini TO rowini+2
       FOR j:=colini TO colini+2
        cands2:=ggc(i,j)
        IF (cands2.card()=2) AND (i<>row) AND (j<>col) AND (NOT cands1.equals(cands2))
         intersec:=cands1.intersection(cands2)
         IF NOT intersec.isEmpty()
          difference:=cands2.difference(cands1)
          pstr:=difference.toStr()
          p:=Val(pstr)
          difference2:=cands1.difference(cands2)
          np:=difference.union(difference2)
          -> Search the third pair
          -> First in the same row
          FOR k:=1 TO 9
           mod,qcol2:=Mod(k-1,3)
           cands3:=ggc(row,k)
           IF (cands3.equals(np)) AND (qcol<>qcol2)
            removeRowXYWing(row,col,p)
            removeRowXYWing(i,k,p)
           ENDIF
          ENDFOR
          -> Second in the same col
          FOR k:=1 TO 9
           mod,qrow2:=Mod(k-1,3)
           cands3:=ggc(k,col)
           IF (cands3.equals(np)) AND (qrow<>qrow2)
            removeColXYWing(row,col,p)
            removeColXYWing(k,j,p)
           ENDIF 
          ENDFOR
          END difference
          END difference2
          END np
         ENDIF
         END intersec
        ENDIF
       ENDFOR
      ENDFOR
     ENDIF
    ENDFOR
   ENDFOR
  ENDFOR
 ENDFOR
ENDPROC

PROC checkNakedPairs()
 DEF cands1:PTR TO digiset
 DEF cands2:PTR TO digiset
 DEF row,col,i,j,amount,row2,col2

 -> First in cols
 FOR col:=1 TO 9
  FOR i:=1 TO 9
   cands1:=ggc(i,col)
   IF cands1.card() = 2
    amount:=1
    FOR j:=1 TO 9
     cands2:=ggc(j,col)
     IF (i<>j) AND (cands1.equals(cands2))
      amount:=amount+1
      row2:=j
     ENDIF
    ENDFOR
    IF amount=2
     removeColPair(col,i,row2,cands1)
     EXIT TRUE
    ENDIF
   ENDIF
  ENDFOR
 ENDFOR

 -> Second in rows
 FOR row:=1 TO 9
  FOR i:=1 TO 9
   cands1:=ggc(row,i)
   IF cands1.card() = 2
    amount:=1
    FOR j:=1 TO 9
     cands2:=ggc(row,j)
     IF (i<>j) AND (cands1.equals(cands2))
      amount:=amount+1
      col2:=j
     ENDIF
    ENDFOR
    IF amount=2
     removeRowPair(row,i,col2,cands1)
     EXIT TRUE
    ENDIF
   ENDIF
  ENDFOR
 ENDFOR
ENDPROC

PROC checkNakedTriples()
 DEF row,col,i,j,k,l,num,num2
 DEF cands1:PTR TO digiset
 DEF cands2:PTR TO digiset
 DEF cands3:PTR TO digiset
 DEF cands:PTR TO digiset
 DEF triple:PTR TO digiset
 DEF s[80]:STRING

 -> First in cols
 FOR col:=1 TO 9
  FOR i:=1 TO 9
   cands1:=ggc(i,col)
   IF NOT cands1.isEmpty()
    FOR j:=i+1 TO 9
     cands2:=ggc(j,col)
     IF NOT cands2.isEmpty()
      FOR k:=j+1 TO 9
       cands3:=ggc(k,col)
       IF NOT cands3.isEmpty()
        triple:=cands1.union(cands2.union(cands3))
        IF triple.card() = 3
         FOR l:=1 TO 9
          cands:=ggc(l,col)
          IF (l<>i) AND (l<>j) AND (l<>k) AND (NOT cands.isEmpty())
           num:=cands.card()
           cands.differenceInPlace(triple)
           num2:=cands.card()
           IF num <> num2
            changed:=TRUE
            StringF(s,' Removed by naked triple in col (\d,\d) Triple \s)',l,col,triple.toStr())
            mainW.addInfo(s)
           ENDIF
          ENDIF
         ENDFOR
        ENDIF
        END triple       
       ENDIF
      ENDFOR
     ENDIF
    ENDFOR
   ENDIF
  ENDFOR
 ENDFOR

 -> Second in rows
 FOR row:=1 TO 9
  FOR i:=1 TO 9
   cands1:=ggc(row,i)
   IF NOT cands1.isEmpty()
    FOR j:=i+1 TO 9
     cands2:=ggc(row,j)
     IF NOT cands2.isEmpty()
      FOR k:=j+1 TO 9
       cands3:=ggc(row,k)
       IF NOT cands3.isEmpty()
        triple:=cands1.union(cands2.union(cands3))
        IF triple.card() = 3
         FOR l:=1 TO 9
          cands:=ggc(row,l)
          IF (l<>i) AND (l<>j) AND (l<>k) AND (NOT cands.isEmpty())
           num:=cands.card()
           cands.differenceInPlace(triple)
           num2:=cands.card()
           IF num <> num2
            changed:=TRUE
            StringF(s,' Removed by naked triple in row (\d,\d) Triple \s)',row,l,triple.toStr())
            mainW.addInfo(s)
           ENDIF
          ENDIF
         ENDFOR
        ENDIF
        END triple
       ENDIF
      ENDFOR
     ENDIF
    ENDFOR
   ENDIF
  ENDFOR
 ENDFOR
ENDPROC

PROC checkHiddenPairsRow()
 DEF row,i,j,k,l,m
 DEF found
 DEF cands1:PTR TO digiset
 DEF cands2:PTR TO digiset
 DEF cands3:PTR TO digiset
 DEF intersec1:PTR TO digiset
 DEF intersec2:PTR TO digiset
 DEF pair:PTR TO digiset  
 DEF nums[9]:STRING
 DEF substr[1]:STRING
 DEF num1,num2
 DEF s[80]:STRING

 NEW pair

 FOR row:=1 TO 9
  FOR i:=1 TO 8
   FOR j:=i+1 TO 9
    cands1:=ggc(row,i)
    cands2:=ggc(row,j)
    intersec1:=cands1.intersection(cands2)
    IF intersec1.card() > 2
     StrCopy(nums,intersec1.toStr())
     FOR k:=0 TO StrLen(nums)-1
      FOR l:=k+1 TO StrLen(nums)-1
       StringF(substr,'\c',nums[k])
       num1:=Val(substr)
       StringF(substr,'\c',nums[l])
       num2:=Val(substr)
       pair.empty()
       pair.insert(num1)
       pair.insert(num2)
       found:=FALSE
       FOR m:=1 TO 9
        cands3:=ggc(row,m)
        intersec2:=cands3.intersection(pair)
        IF (m<>i) AND (m<>j) AND (NOT intersec2.isEmpty()) THEN found:=TRUE
        END intersec2
       ENDFOR
       IF NOT found
        IF (cands1.card()>2) OR (cands2.card()>2)
         changed:=TRUE
         cands1.empty()
         cands1.unionInPlace(pair)
         cands2.empty()
         cands2.unionInPlace(pair)
         StringF(s,' Removed by hidden pairs in row \d Cols \d,\d Pair \s',row,i,j,pair.toStr())
         mainW.addInfo(s)
         END pair
         RETURN
        ENDIF
       ENDIF
      ENDFOR
     ENDFOR
    ENDIF
    END intersec1
   ENDFOR
  ENDFOR
 ENDFOR

 END pair
ENDPROC

PROC checkHiddenPairsCol()
 DEF col,i,j,k,l,m
 DEF found
 DEF cands1:PTR TO digiset
 DEF cands2:PTR TO digiset
 DEF cands3:PTR TO digiset
 DEF intersec1:PTR TO digiset
 DEF intersec2:PTR TO digiset
 DEF pair:PTR TO digiset  
 DEF nums[9]:STRING
 DEF substr[1]:STRING
 DEF num1,num2
 DEF s[80]:STRING

 NEW pair

 FOR col:=1 TO 9
  FOR i:=1 TO 8
   FOR j:=i+1 TO 9
    cands1:=ggc(i,col)
    cands2:=ggc(j,col)
    intersec1:=cands1.intersection(cands2)
    IF intersec1.card() > 2
     StrCopy(nums,intersec1.toStr())
     FOR k:=0 TO StrLen(nums)-1
      FOR l:=k+1 TO StrLen(nums)-1
       StringF(substr,'\c',nums[k])
       num1:=Val(substr)
       StringF(substr,'\c',nums[l])
       num2:=Val(substr)
       pair.empty()
       pair.insert(num1)
       pair.insert(num2)
       found:=FALSE
       FOR m:=1 TO 9
        cands3:=ggc(m,col)
        intersec2:=cands3.intersection(pair)
        IF (m<>i) AND (m<>j) AND (NOT intersec2.isEmpty()) THEN found:=TRUE
        END intersec2
       ENDFOR
       IF NOT found
        IF (cands1.card()>2) OR (cands2.card()>2)
         changed:=TRUE
         cands1.empty()
         cands1.unionInPlace(pair)
         cands2.empty()
         cands2.unionInPlace(pair)
         StringF(s,' Removed by hidden pairs in col \d Rows \d,\d Pair \s',col,i,j,pair.toStr())
         mainW.addInfo(s)
         END pair
         RETURN
        ENDIF
       ENDIF
      ENDFOR
     ENDFOR
    ENDIF
    END intersec1
   ENDFOR
  ENDFOR
 ENDFOR

 END pair
ENDPROC

PROC checkYWingRow()
 DEF num,total,col1r1,col2r1,col1r2,col2r2,qr1,qr2,row1,row2,col
 DEF cands1:PTR TO digiset
 DEF cands2:PTR TO digiset
 DEF mod

 FOR num:=1 TO 9
  FOR row1:=1 TO 9
   mod,qr1:=Mod(row1-1,3)
   total:=0
   FOR col:=1 TO 9
    cands1:=ggc(row1,col)
    IF cands1.isIn(num)
     IF total=0 THEN col1r1:=col ELSE col2r1:=col
     total:=total+1
    ENDIF
   ENDFOR
   IF total=2
    FOR row2:=1 TO 9
     mod,qr2:=Mod(row2-1,3)
     total:=0
     IF qr1<>qr2
      FOR col:=1 TO 9
       cands2:=ggc(row2,col)
       IF cands2.isIn(num)
        IF total=0 THEN col1r2:=col ELSE col2r2:=col
        total:=total+1
       ENDIF
      ENDFOR
      IF (total=2) AND (col1r1=col1r2) AND (col2r1=col2r2)
       removeRowYWing(col1r1,col2r1,row1,row2,num)
      ENDIF
     ENDIF
    ENDFOR
   ENDIF
  ENDFOR
 ENDFOR
ENDPROC

PROC checkYWingCol()
 DEF num,total,row1c1,row2c1,row1c2,row2c2,qc1,qc2,col1,col2,row
 DEF cands1:PTR TO digiset
 DEF cands2:PTR TO digiset
 DEF mod

 FOR num:=1 TO 9
  FOR col1:=1 TO 9
   mod,qc1:=Mod(col1-1,3)
   total:=0
   FOR row:=1 TO 9
    cands1:=ggc(row,col1)
    IF cands1.isIn(num)
     IF total=0 THEN row1c1:=row ELSE row2c1:=row
     total:=total+1
    ENDIF
   ENDFOR
   IF total=2
    FOR col2:=1 TO 9
     mod,qc2:=Mod(col2-1,3)
     total:=0
     IF qc1<>qc2
      FOR row:=1 TO 9
       cands2:=ggc(row,col2)
       IF cands2.isIn(num)
        IF total=0 THEN row1c2:=row ELSE row2c2:=row
        total:=total+1
       ENDIF
      ENDFOR
      IF (total=2) AND (row1c1=row1c2) AND (row2c1=row2c2)
       removeColYWing(row1c1,row2c1,col1,col2,num)
      ENDIF
     ENDIF
    ENDFOR
   ENDIF
  ENDFOR
 ENDFOR
ENDPROC