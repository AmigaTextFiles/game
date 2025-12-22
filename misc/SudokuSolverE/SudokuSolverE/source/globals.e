OPT MODULE

MODULE '*set'

EXPORT ENUM ERR_NONE, ERR_ASL, ERR_KICK, ERR_LIB, ERR_FILE

EXPORT DEF showconsole

EXPORT OBJECT gamedata
  PRIVATE theboard[10][10]:ARRAY OF INT
  PRIVATE thecandidates[10][10]:ARRAY OF LONG
ENDOBJECT

EXPORT DEF game:PTR TO gamedata

EXPORT PROC insertCand(i,j,num) OF gamedata
  DEF cand:PTR TO digiset
  cand:=self.thecandidates[i][j]
  cand.insert(num)
ENDPROC

EXPORT PROC getCandidates(i,j) OF gamedata IS self.thecandidates[i][j]

EXPORT PROC setBoard(i,j,n) OF gamedata
  self.theboard[i][j]:=n
ENDPROC

EXPORT PROC getBoard(i,j) OF gamedata IS self.theboard[i][j]

EXPORT PROC create() OF gamedata
  DEF cand:PTR TO digiset
  DEF i,j

  FOR i:=0 TO 9
    FOR j:=0 TO 9
      self.theboard[i][j]:=0
      NEW cand.create()
      self.thecandidates[i][j]:=cand
    ENDFOR
  ENDFOR
ENDPROC

EXPORT PROC initGlobals()
  NEW game.create()
ENDPROC
