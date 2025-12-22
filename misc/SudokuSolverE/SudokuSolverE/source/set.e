OPT MODULE

SET ONE,TWO,THREE,FOUR,FIVE,SIX,SEVEN,EIGHT,NINE
CONST EMPTYSET=0

EXPORT OBJECT digiset 
 theset
ENDOBJECT

PROC create() OF digiset IS self.theset := EMPTYSET

PROC toStr() OF digiset
 DEF s:PTR TO CHAR

 s := String(9)

 StrAdd(s,'')
 IF self.theset AND ONE THEN StrAdd(s,'1')
 IF self.theset AND TWO THEN StrAdd(s,'2')
 IF self.theset AND THREE THEN StrAdd(s,'3')
 IF self.theset AND FOUR THEN StrAdd(s,'4')
 IF self.theset AND FIVE THEN StrAdd(s,'5')
 IF self.theset AND SIX THEN StrAdd(s,'6')
 IF self.theset AND SEVEN THEN StrAdd(s,'7')
 IF self.theset AND EIGHT THEN StrAdd(s,'8')
 IF self.theset AND NINE THEN StrAdd(s,'9')
ENDPROC s

PROC card() OF digiset
 DEF c

 c:=0
 IF self.theset <> EMPTYSET
  IF self.theset AND ONE THEN INC c
  IF self.theset AND TWO THEN INC c
  IF self.theset AND THREE THEN INC c
  IF self.theset AND FOUR THEN INC c 
  IF self.theset AND FIVE THEN INC c 
  IF self.theset AND SIX THEN INC c
  IF self.theset AND SEVEN THEN INC c 
  IF self.theset AND EIGHT THEN INC c 
  IF self.theset AND NINE THEN INC c 
 ENDIF
ENDPROC c

PROC insert(d) OF digiset
 SELECT d
  CASE 1
   self.theset := self.theset OR ONE
  CASE 2
   self.theset := self.theset OR TWO
  CASE 3
   self.theset := self.theset OR THREE
  CASE 4
   self.theset := self.theset OR FOUR
  CASE 5
   self.theset := self.theset OR FIVE
  CASE 6
   self.theset := self.theset OR SIX
  CASE 7
   self.theset := self.theset OR SEVEN
  CASE 8
   self.theset := self.theset OR EIGHT
  CASE 9
   self.theset := self.theset OR NINE
 ENDSELECT
ENDPROC

PROC remove(d) OF digiset
 SELECT d
  CASE 1
   self.theset := self.theset AND Not(ONE)
  CASE 2
   self.theset := self.theset AND Not(TWO)
  CASE 3
   self.theset := self.theset AND Not(THREE)
  CASE 4
   self.theset := self.theset AND Not(FOUR)
  CASE 5
   self.theset := self.theset AND Not(FIVE)
  CASE 6
   self.theset := self.theset AND Not(SIX)
  CASE 7
   self.theset := self.theset AND Not(SEVEN)
  CASE 8
   self.theset := self.theset AND Not(EIGHT)
  CASE 9
   self.theset := self.theset AND Not(NINE)
 ENDSELECT
ENDPROC

PROC isIn(d) OF digiset
 SELECT d
  CASE 1
   RETURN IF self.theset AND ONE THEN TRUE ELSE FALSE
  CASE 2
   RETURN IF self.theset AND TWO THEN TRUE ELSE FALSE
  CASE 3
   RETURN IF self.theset AND THREE THEN TRUE ELSE FALSE
  CASE 4
   RETURN IF self.theset AND FOUR THEN TRUE ELSE FALSE
  CASE 5
   RETURN IF self.theset AND FIVE THEN TRUE ELSE FALSE
  CASE 6
   RETURN IF self.theset AND SIX THEN TRUE ELSE FALSE
  CASE 7
   RETURN IF self.theset AND SEVEN THEN TRUE ELSE FALSE
  CASE 8
   RETURN IF self.theset AND EIGHT THEN TRUE ELSE FALSE
  CASE 9
   RETURN IF self.theset AND NINE THEN TRUE ELSE FALSE
 ENDSELECT
ENDPROC 

PROC union(s:PTR TO digiset) OF digiset
 DEF newset:PTR TO digiset

 NEW newset.create()
 newset.theset := self.theset OR s.theset
ENDPROC newset

PROC unionInPlace(s:PTR TO digiset) OF digiset
 self.theset := self.theset OR s.theset
ENDPROC

PROC intersection(s:PTR TO digiset) OF digiset
 DEF newset:PTR TO digiset

 NEW newset.create()
 newset.theset := self.theset AND s.theset
ENDPROC newset

PROC intersectionInPlace(s:PTR TO digiset) OF digiset
 self.theset := self.theset AND s.theset
ENDPROC

PROC difference(s:PTR TO digiset) OF digiset
 DEF newset:PTR TO digiset

 NEW newset.create()
 newset.theset := self.theset AND Not(s.theset)
ENDPROC newset

PROC differenceInPlace(s:PTR TO digiset) OF digiset
 self.theset := self.theset AND Not(s.theset)
ENDPROC

PROC empty() OF digiset 
 self.theset := EMPTYSET
ENDPROC

PROC isEmpty() OF digiset 
 IF self.theset = EMPTYSET THEN RETURN TRUE ELSE RETURN FALSE
ENDPROC 

PROC equals(s:PTR TO digiset) OF digiset IS StrCmp(self.toStr(),s.toStr())
