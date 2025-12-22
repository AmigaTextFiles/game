OPT MODULE
OPT EXPORT

MODULE 'intuition/intuition',
       'intuition/screens',
       'intuition/classusr',
       'intuition/classes',
       'intuition/gadgetclass',
       'libraries/bguim',
       'libraries/bgui',
       'utility/tagitem',
       'graphics/gfx',
       'tools/boopsi',
       'utility/hooks',
       'tools/inithook',
       'tools/installhook'

MODULE 'bgui'

MODULE '*globals','*utils'


ENUM GID_AREA = 1,
     GID_SETUP,
     GID_READ,
     GID_SOLVE,
     GID_CONSOLE,
     GID_QUIT,
     GID_INFO

ENUM NORMAL,SETUP

OBJECT sudokugui
  owindow      : PTR TO object
  window       : PTR TO window
  gadgets[ 5 ] : ARRAY OF LONG
  keyhook:hook
ENDOBJECT

DEF game:PTR TO gamedata
DEF mainW : PTR TO sudokugui
DEF mode,currow,curcol
DEF showconsole

PROC create() OF sudokugui

  mode := NORMAL

  self.gadgets[ GID_AREA - 1 ] := AreaObject,
                                    NoFrame,
                                    AREA_MinWidth,      135,
                                    AREA_MinHeight,     135,
                                    GA_ID,              GID_AREA,
                                  EndObject
  self.gadgets[ GID_SETUP - 1 ] := PrefButton( 'Set _Up', GID_SETUP )
  self.gadgets[ GID_READ - 1 ] := PrefButton( '_Read', GID_READ )
  self.gadgets[ GID_SOLVE - 1 ] := PrefButton( '_Solve', GID_SOLVE )
  self.gadgets[ GID_QUIT - 1 ] := PrefButton( '_Quit', GID_QUIT )
  self.gadgets[ GID_INFO -  1 ] := ListviewObject,
                                     LISTV_MinEntriesShown, 8,
                                     LISTV_ReadOnly, TRUE,
                                     LISTV_EntryArray,
                                       ['Welcome to SUDOKU Solver','',
                                        NIL],
                                     GA_ID, GID_INFO,
                                  EndObject


  self.owindow := WindowObject,
                    WINDOW_Title,           'SUDOKU Solver',
                    WINDOW_AutoAspect,      TRUE,
                    WINDOW_SmartRefresh,    TRUE,
                    WINDOW_AutoKeyLabel,    TRUE,
                    WINDOW_CloseOnEsc,      FALSE,
                    WINDOW_LockWidth, FALSE,
                    WINDOW_LockHeight, TRUE, 
                    WINDOW_IDCMPHookBits,   IDCMP_RAWKEY,
	            WINDOW_IDCMPHook, self.keyhook,
                    WINDOW_MasterGroup,
                      VGroupObject, 
                        StartMember,
                          HGroupObject,
                            NormalOffset,
                            NormalSpacing,
                            ShineRaster,
                            StartMember,
                              self.gadgets[ GID_AREA - 1 ],
                            EndMember,
                            VarSpace(DEFAULT_WEIGHT),
                            StartMember,
                              VGroupObject,
                                StartMember,
                                  self.gadgets[ GID_SETUP - 1 ],
                                  FixMinHeight,
                                EndMember,
                                StartMember,
                                  self.gadgets[ GID_READ - 1 ],
                                  FixMinHeight,
                                EndMember,
                                StartMember,
                                  self.gadgets[ GID_SOLVE - 1 ],
                                  FixMinHeight,
                                EndMember,
                                StartMember,
                                 self.gadgets[ GID_CONSOLE - 1 ] := KeyCheckBox( '_Console', FALSE, GID_CONSOLE ),
                                EndMember,
                              EndObject,
                            EndMember, 
                            VarSpace(400),
                            StartMember,
                              self.gadgets[ GID_QUIT - 1 ],
                              FixMinHeight,
                            EndMember,
                          EndObject,
                        EndMember,
                        StartMember,
                          self.gadgets[ GID_INFO - 1 ],   
                        EndMember,
                      EndObject,
                  EndObject
ENDPROC

PROC start() OF sudokugui
  DEF sta_rc,sta_running,sta_signal


  IF self.owindow <> NIL
    inithook(self.keyhook,{keyHookFunc},self.owindow)
    self.window := WindowOpen( self.owindow )
    IF self.window <> NIL
      GetAttr( WINDOW_SigMask, self.owindow, {sta_signal} )
      sta_running := TRUE
      WHILE sta_running = TRUE
        Wait( sta_signal )
        WHILE (sta_rc := HandleEvent( self.owindow )) <> WMHI_NOMORE
          SELECT sta_rc
            CASE WMHI_CLOSEWINDOW 
             sta_running := FALSE
           CASE GID_QUIT         
             self.clearInfo()
             sta_running := FALSE
           CASE GID_AREA
             self.drawBoard()
           CASE GID_READ
             mode:=NORMAL
             END game
             initGlobals()
             self.clearInfo()
             self.drawBoard() 
             self.addInfo('#Loading game#')
             IF loadGame()
              self.addInfo(' Game loaded')
             ENDIF 
             self.drawBoard()
           CASE GID_SETUP
             END game
             DisableObject(self.window,self.gadgets[ GID_SETUP - 1 ])
             DisableObject(self.window,self.gadgets[ GID_READ - 1 ])
             DisableObject(self.window,self.gadgets[ GID_SOLVE - 1 ])
             initGlobals()
             self.drawBoard()
             mode:=SETUP
             currow:=1
             curcol:=1
             self.clearInfo()
             self.addInfo('#Entering setup mode#')
             self.addInfo(' Cursors to move through board')
             self.addInfo(' 1-9 to set number in cell')
             self.addInfo(' Spacebar to clear cell')
             self.addInfo(' ESC to leave setup mode')
             self.highLightCell(1,1,0)
           CASE GID_SOLVE
             self.clearInfo()
             self.addInfo('#Start solving#')
             self.addInfo(' Building cell candidates')
             buildCandidates()
             self.addInfo(' Cell candidates built')
             solve()
           CASE GID_CONSOLE
            GetAttr( GA_SELECTED, self.gadgets[ GID_CONSOLE - 1 ], {showconsole})
          ENDSELECT
        ENDWHILE
      ENDWHILE
      WindowClose( self.owindow )
    ENDIF
  ENDIF
ENDPROC

PROC end() OF sudokugui
  IF self.owindow <> NIL THEN DisposeObject( self.owindow )
ENDPROC

PROC addInfo(str) OF sudokugui
 AddEntryVisible(self.window, self.gadgets[ GID_INFO -  1 ], str, LVAP_TAIL)
 RedrawList(self.window, self.gadgets[ GID_INFO -  1 ])
ENDPROC

PROC clearInfo() OF sudokugui
 ClearList(self.window, self.gadgets[ GID_INFO -  1 ])
ENDPROC

PROC drawBoard() OF sudokugui
 DEF xgap,ygap,width,height
 DEF i,j,oldrp
 DEF sta_area: PTR TO ibox
 DEF win:PTR TO window
 DEF s[1]:STRING

 GetAttr( AREA_AreaBox, self.gadgets[ GID_AREA - 1 ], {sta_area} )

 xgap := sta_area.left
 ygap := sta_area.top
 width := 135
 height := 135

 win:= self.window
 oldrp:=SetStdRast(win.rport)

 Box(xgap,ygap,xgap+width,ygap+height,2)

 FOR i:=1 TO 10
  Line(xgap+ ((i-1)*15),ygap,xgap + ((i-1)*15),ygap+height)
  Line(xgap, ygap + ((i-1)*15),xgap + width, ygap + ((i-1)*15))
 ENDFOR

 SetTopaz(8)

 Colour(1)
 FOR i:= 1 TO 9
  FOR j:= 1 TO 9
   IF game.getBoard(i,j) = 0
    StrCopy(s,' ')
   ELSE
    StringF(s,'\d',game.getBoard(i,j))
   ENDIF
   TextF(xgap+((j-1)*15+4),ygap+((i-1)*15+11),s)
  ENDFOR
 ENDFOR 

 SetStdRast(oldrp)
ENDPROC 0

PROC highLightCell(i,j,color=2) OF sudokugui PRIVATE
 DEF x,y,oldrp
 DEF sta_area: PTR TO ibox
 DEF win:PTR TO window
 DEF s[1]:STRING

 GetAttr( AREA_AreaBox, self.gadgets[ GID_AREA - 1 ], {sta_area} )

 win:=self.window
 oldrp:=SetStdRast(win.rport)

 SetTopaz(8)

 x := sta_area.left+((j-1)*15)+1
 y := sta_area.top+((i-1)*15)+1
 Box(x,y,x+13,y+13,color)
 Colour(1)
 IF game.getBoard(i,j) = 0
  StrCopy(s,' ')
 ELSE
  StringF(s,'\d',game.getBoard(i,j))
 ENDIF

 TextF(x+3,y+10,s)
 
 SetStdRast(oldrp) 
ENDPROC

PROC keyHookFunc(hook:PTR TO hook, obj:PTR TO object, msg:PTR TO intuimessage)
  IF mode = SETUP
   ->WriteF('\d\n',msg.code)
   SELECT msg.code
     CASE 1 -> Number 1
       game.setBoard(currow,curcol,1)
       mainW.highLightCell(currow,curcol,0)
     CASE 2 -> Number 2
       game.setBoard(currow,curcol,2)
       mainW.highLightCell(currow,curcol,0)
     CASE 3 -> Number 3
       game.setBoard(currow,curcol,3)
       mainW.highLightCell(currow,curcol,0)
     CASE 4 -> Number 4
       game.setBoard(currow,curcol,4)
       mainW.highLightCell(currow,curcol,0)
     CASE 5 -> Number 5
       game.setBoard(currow,curcol,5)
       mainW.highLightCell(currow,curcol,0)
     CASE 6 -> Number 6
       game.setBoard(currow,curcol,6)
       mainW.highLightCell(currow,curcol,0)
     CASE 7 -> Number 7
       game.setBoard(currow,curcol,7)
       mainW.highLightCell(currow,curcol,0)
     CASE 8 -> Number 9
       game.setBoard(currow,curcol,8)
       mainW.highLightCell(currow,curcol,0)
     CASE 9 -> Number 9
       game.setBoard(currow,curcol,9)
       mainW.highLightCell(currow,curcol,0)
     CASE 64 -> Spacebar
       game.setBoard(currow,curcol,0)
       mainW.highLightCell(currow,curcol,0)
     CASE 69 -> Esc
       mode:=NORMAL
       mainW.highLightCell(currow,curcol)
       mainW.addInfo('#Leving setup mode#')
       EnableObject(mainW.window,mainW.gadgets[ GID_SETUP - 1 ])
       EnableObject(mainW.window,mainW.gadgets[ GID_READ - 1 ])
       EnableObject(mainW.window,mainW.gadgets[ GID_SOLVE - 1 ])
     CASE 76 -> Up
       IF currow > 1
         mainW.highLightCell(currow,curcol)
         DEC currow
         mainW.highLightCell(currow,curcol,0)
       ENDIF
     CASE 77 -> Down
       IF currow < 9
         mainW.highLightCell(currow,curcol)
         INC currow
         mainW.highLightCell(currow,curcol,0)
       ENDIF
     CASE 78 -> Right
       IF curcol < 9
         mainW.highLightCell(currow,curcol)
         INC curcol
         mainW.highLightCell(currow,curcol,0)
       ENDIF
     CASE 79 -> Left
       IF curcol > 1
         mainW.highLightCell(currow,curcol)
         DEC curcol
         mainW.highLightCell(currow,curcol,0)
       ENDIF
   ENDSELECT
  ENDIF
ENDPROC
