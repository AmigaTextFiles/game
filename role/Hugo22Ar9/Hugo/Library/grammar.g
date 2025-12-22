!----------------------------------------------------------------------------
!
!           HUGO Verb Grammar v2.2.1 by Kent Tessman (c) 1995-1996
!                     for use with Hugo Compiler v2.2
!
!----------------------------------------------------------------------------
!
! All verb grammar must be defined or included at the start of a game file, 
! before any objects or executable code.
!
!----------------------------------------------------------------------------

#version 2.2

!----------------------------------------------------------------------------
! NON-ACTION VERBS:
!----------------------------------------------------------------------------

#ifclear NO_XVERBS

xverb "restore", "resume"
	*                                                       DoRestore
	* "game"/"story"                                        DoRestore

xverb "save", "suspend"
	*                                                       DoSave
	* "game"/"story"                                        DoSave

xverb "script", "transcript"
	*                                                       DoScriptOnOff
	* "on"/"off"                                            DoScriptOnOff

#ifclear NO_RECORDING
xverb "record"
	*                                                       DoRecordOnOff
	* "on"/"off"                                            DoRecordOnOff

xverb "playback"
	*                                                       DoRecordOnOff
#endif

xverb "quit", "q"
	*                                                       DoQuit
	* "game"                                                DoQuit

xverb "restart"
	*                                                       DoRestart
	* "game"                                                DoRestart

xverb "brief", "normal"
	*                                                       DoBrief

xverb "superbrief", "short"
	*                                                       DoSuperBrief

xverb "verbose", "long"
	*                                                       DoVerbose

xverb "display"
	*                                                       DoDisplay
	* "wide"/"tall"                                         DoDisplay

xverb "wide", "tall"
	*                                                       DoDisplay

xverb "score"
	*                                                       DoScore

xverb "hello", "hi", "howdy"
	*                                                       DoHello

#ifclear NO_UNDO
xverb "undo"
	*                                                       DoUndo
#endif

#endif  ! ifclear NO_XVERBS

!----------------------------------------------------------------------------
! ACTION VERBS:
!----------------------------------------------------------------------------

#ifclear NO_VERBS

!
! For looking and examining:
!

verb "look", "l"
	*                                                       DoLookAround
	* "in"/"inside" container                               DoLookIn
	* "on" platform                                         DoLookIn
	* "at" object                                           DoLook
	* "out"/"through" object                                DoLookThrough
	* "under"/"underneath"/"beneath" object                 DoLookUnder
	* "beside"/"behind"/"around" object                     DoLookUnder
	* object                                                DoLook
								
verb "examine", "x"
	*                                                       DoVague
	* object                                                DoLook


!
! For waiting around:
!

verb "wait", "z"
	*                                                       DoWait
	* "for" anything                                        DoWaitforChar
	* "until" number                                        DoWaitUntil
	* "until" "turn" number                                 DoWaitUntil
	* number                                                DoWait
	* number "minutes"/"turns"/"turn"/"minute"              DoWait
	* "for" number "minutes"/"turns"/"turn"/"minute"        DoWait


!
! For moving around:
!

verb "north", "n", "south", "s", "east", "e", "west", "w",\
	"southeast", "se", "southwest", "sw", "northwest", "nw",\
	"northeast", "ne", "up", "u", "down", "d", "in", "out", \
	"inside", "outside"
	*                                                       DoGo

verb "go", "walk"
	* "to"/"in"/"into"/"inside"/"through" object            DoEnter
	* "out" object                                          DoGo
	* "out"/"outside"                                       DoExit
	* object                                                DoGo

verb "enter", "board", "mount"
	*                                                       DoVague
	* object                                                DoEnter
							
verb "exit"
	*                                                       DoExit
	* object                                                DoExit

verb "sit", "lie"
	*                                                       DoEnter
	* "down"                                                DoEnter
	* "in"/"on" object                                      DoEnter
	* "down" "in"/"on" object                               DoEnter

verb "stand"
	*                                                       DoExit
	* "up"                                                  DoExit

verb "dismount"
	*                                                       DoExit
	* object                                                DoExit


!
! For moving, taking, and dropping objects:
!

verb "move"
	*                                                       DoVague
	* object                                                DoMove

verb "get", "grab", "snatch", "fetch"
	*                                                       DoVague
	* "up"/"out"/"off"/"down"                               DoExit
	* "outof"/"offof"/"off" object                          DoExit
	* "in"/"in"/"inside"/"on"                               DoEnter
	* "in"/"into"/"inside"/"on"/"onto" object               DoEnter
	* multinotheld "from"/"off"/"on"/"in" parent            DoGet
	* multinotheld "offof"/"outof" parent                   DoGet
	* multinotheld "from" "offof"/"outof"/"on"/"in" parent  DoGet
	* multinotheld                                          DoGet

verb "take"
	*                                                       DoVague
	* multinotheld                                          DoGet
	* "off" multiheld                                       DoTakeOff
	* multiheld "off"                                       DoTakeOff
	* multinotheld "from"/"off"/"on"/"in" parent            DoGet
	* multinotheld "offof"/"outof" parent                   DoGet
	* multinotheld "from" "offof"/"outof"/"on"/"in" parent  DoGet
	* "inventory"                                           DoInventory

verb "pick"
	*                                                       DoVague
	* "up" multinotheld                                     DoGet
	* "up" multinotheld "from"/"off" parent                 DoGet
	* "up" multinotheld "offof"/"outof" parent              DoGet
	* multinotheld "up"                                     DoGet
	* multinotheld "up" "from"/"off" parent                 DoGet
	* multinotheld "up" "offof"/"outof" parent              DoGet
	* multinotheld                                          DoGet

verb "drop"
	*                                                       DoVague
	* multiheld "on" "ground"/"floor"                       DoPutonGround
	* multiheld "outside" xobject                           DoPutonGround
	* multiheld "in"/"into"/"inside" container              DoPutIn
	* multiheld "on" platform                               DoPutIn
	* multiheld                                             DoDrop
 
verb "leave"
	*                                                       DoExit
	* object                                                DoExit
	* multiheld "on"/"onto" "ground"/"floor"                DoPutonGround
	* multiheld "outside" xobject                           DoPutonGround
	* multiheld "in"/"inside" container                     DoPutIn
	* multiheld "on" platform                               DoPutIn
	* multiheld                                             DoDrop

verb "let"
	* "go" multiheld                                        DoDrop
	* multiheld "go"                                        DoDrop

verb "put", "place"
	*                                                       DoVague
	* multiheld "on"/"onto" "ground"/"floor"                DoPutonGround
	* multiheld "outside" xobject                           DoPutonGround
	* "down" multiheld                                      DoDrop
	* multiheld "down"                                      DoDrop
	* multiheld "in"/"into"/"inside" container              DoPutIn
	* multiheld "on"/"onto" platform                        DoPutIn
	* multiheld                                             DoDrop

verb "put"
	* multiheld "on"                                        DoWear
	* "on" multiheld                                        DoWear

verb "insert"
	*                                                       DoVague
	* held                                                  DoPutIn
	* held "in"/"into" object                               DoPutIn

verb "empty", "unload"
	*                                                       DoVague
	* container                                             DoEmpty
	* platform                                              DoEmpty
	* container "on"/"onto" "ground"/"floor"                DoEmptyGround
	* platform "on"/"onto" "ground"/"floor"                 DoEmptyGround


!
! Other object-handling verbs:
!

verb "give", "hand", "offer"
	*                                                       DoVague
	* object                                                DoGive
	* object "to" object                                    DoGive

verb "show"
	*                                                       DoVague
	* object                                                DoShow
	* object "to" xobject                                   DoShow

verb "inventory", "inv", "i"
	*                                                       DoInventory
	* "wide"/"tall"                                         DoInventory

verb "open"
	*                                                       DoVague
	* openable                                              DoOpen

verb "lock"
	*                                                       DoVague
	* lockable                                              DoLock
	* lockable "with" held                                  DoLock

verb "unlock"
	*                                                       DoVague
	* lockable                                              DoUnlock
	* lockable "with" held                                  DoUnlock

verb "close", "shut"
	*                                                       DoVague
	* openable                                              DoClose

verb "read", "peruse"
	*                                                       DoVague
	* readable                                              DoLook

verb "switch", "turn", "flip"
	*                                                       DoVague
	* switchable "on"                                       DoSwitchOn
	* "on" switchable                                       DoSwitchOn
	* switchable "off"                                      DoSwitchOff
	* "off" switchable                                      DoSwitchOff

verb "wear"
	*                                                       DoVague
	* multi                                                 DoWear

verb "remove"
	*                                                       DoVague
	* multi                                                 DoTakeOff
	* multi "from"/"outof"/"offof" parent                   DoGet

verb "listen"
	*                                                       DoListen
	* "to" object                                           DoListen

verb "hear"
	*                                                       DoListen
	* object                                                DoListen

verb "eat", "taste", "bite", "chew"
	*                                                       DoVague
	* object                                                DoEat

verb "drink", "sip", "swallow"
	*                                                       DoVague
	* object                                                DoDrink
	* "from" object                                         DoDrink

verb "hit", "strike", "break", "attack", "whack", "beat", "punch"
	*                                                       DoVague
	* object                                                DoHit
	* object "with" held                                    DoHit

verb "kill", "murder", "fight"
	*                                                       DoVague
	* living                                                DoHit


!
! For talking to characters:
!

verb "ask", "question", "consult"
	*                                                       DoAsk
	* living                                                DoAsk
	* living "about" anything                               DoAsk
	* "about" anything                                      DoAskQuestion

verb "talk", "speak"
	*                                                       DoTalk
	* "to" living                                           DoTalk
	* "to" living "about" anything                          DoTalk
	* "about" anything                                      DoAskQuestion

verb "tell"
	* "me" "about" anything                                 DoAskQuestion
	* living "about" anything                               DoTell

verb "explain"
	* "to" "me" "about" anything                            DoAskQuestion
	* "to" living "about" anything                          DoTell

verb "what"
	* "is"/"about" anything                                 DoAskQuestion

verb "who"                                             
	* "is" anything                                         DoAskQuestion

#endif  ! ifclear NO_VERBS

!----------------------------------------------------------------------------
! Include verb stub grammar if specified

#ifset VERBSTUBS
#include "verbstub.g"
#endif

!----------------------------------------------------------------------------
! Include debugging grammar if specified

#ifset DEBUG
#include "hugofix.g"
#endif

#ifset DEBUG_SMALL
#include "hugofix.g"
#endif

