OPT LARGE

MODULE '*set', '*sudokugui'
MODULE '*globals'
MODULE 'dos/dos', 'asl', 'libraries/asl', 'tools/exceptions'

DEF mainW : PTR TO sudokugui
DEF game: PTR TO gamedata
DEF req:PTR TO filerequester

PROC main() HANDLE
  IF KickVersion(36) = NIL THEN Raise(ERR_KICK)
  IF (aslbase := OpenLibrary('asl.library', 36)) = 0 THEN Raise(ERR_LIB) 
  IF (req := AllocAslRequest(ASL_FILEREQUEST,
               [ASL_HAIL, 'Select a file',
                ASL_HEIGHT, 200,
                ASL_WIDTH, 320,
                ASL_OKTEXT, 'Select',
                ASL_CANCELTEXT, 'Cancel', NIL])) = NIL THEN Raise(ERR_ASL)

  mainW := NIL
  initGlobals()

  bguibase  := OpenLibrary( 'bgui.library', 41 )
  IF bguibase <> NIL
    NEW mainW.create()
    mainW.start()
  ELSE
   Raise(ERR_LIB)
  ENDIF
EXCEPT DO
  END game
  IF mainW <> NIL THEN END mainW
  IF bguibase  <> NIL THEN CloseLibrary( bguibase )
  IF game <> NIL THEN END game
  IF req THEN FreeAslRequest(req)
  IF aslbase THEN CloseLibrary(aslbase)
  SELECT exception
    CASE ERR_ASL
      WriteF('Error: Impossible allocation of Requester ASL\n')
    CASE ERR_KICK
      WriteF('Error: asl.library < V36\n')
    CASE ERR_LIB
      WriteF('Error: Impossible opening asl.library or bgui.library\n')
    CASE ERR_FILE
      WriteF('Error: Error in game file format\n')
  ENDSELECT
  report_exception()
ENDPROC
