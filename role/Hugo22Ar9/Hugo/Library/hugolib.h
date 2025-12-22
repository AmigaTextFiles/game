!----------------------------------------------------------------------------
!
!            HUGO Library v2.2.2 by Kent Tessman (c) 1995-1996
!                     for use with Hugo Compiler v2.2
!
!----------------------------------------------------------------------------
! NOTE:  This file is formatted for an 80-column display; an "\" at the end
!        of a line indicates that the line continues as if unbroken.
!----------------------------------------------------------------------------

#version 2.2

constant BANNER "Written using Hugo v2.2 by Kent Tessman (c) 1995-1996"
constant HUGO_VERSION   "v2.2"

!----------------------------------------------------------------------------
! RESERVED PROPERTIES:
!----------------------------------------------------------------------------

!\ The first 6 are pre-defined by the compiler:

property name                           ! property 0:  basic object name
property before $additive $complex      ! pre-verb routines
property after  $additive $complex      ! post-verb routines
property noun                           ! noun(s) for referring to object
property adjective                      ! adjective(s) describing object
property article                        ! "a", "an", "some", etc.
\!

property nouns alias noun               !
property adjectives alias adjective     !
property preposition                    ! "in", "inside", "outside of", etc.
property prep alias preposition         !
property pronoun "it"                   ! "he", "him", "his", "himself"
property pronouns alias pronoun         !   (or equivalent)
property short_desc                     ! basic "X is here" description
property initial_desc                   ! same as above, before obj. is moved
property long_desc                      ! detailed description
property found_in                       ! in case of multiple parents
property type                           ! to identify the type of object
property size 10                        ! for holding/inventory purposes
property capacity                       !  "          "            "
property holding                        !  "          "            "
property reach                          ! for limiting accessible objects
property list_contents                  ! to override normal listing routine
property in_scope                       ! actor(s) which can access an object
property parse_rank                     ! for matching similarly named objects

! The following apply only to room objects:
property n_to                           !
property ne_to                          !
property e_to                           !
property se_to                          !
property s_to                           ! If the player can move from one 
property sw_to                          ! room to another in direction X,
property w_to                           ! X_to holds the object number of the
property nw_to                          ! second room.
property u_to                           !
property d_to                           !
property in_to                          !
property out_to                         !
property cant_go                        ! message if a move is invalid
property extra_scenery                  ! unimportant words/objects in desc.
property each_turn                      ! a routine called each turn

! The following apply only to non-room objects:
property door_to alias n_to             ! for handling "Enter <object>"
property key_object alias ne_to         ! if lockable, what is the key?
property when_open alias e_to           ! desc. for openable objects
property when_closed alias se_to        !   "    "     "        "
property ignore_response alias s_to     ! for unfriendly characters
property order_response alias sw_to     ! for giving orders to characters
property contains_desc alias w_to       ! instead of "X contains...", etc.
property inv_desc alias nw_to           ! for inventory listing only
property desc_detail alias u_to         ! parenthetical detail (ObjectIs)

property misc                           ! miscellaneous use


!----------------------------------------------------------------------------
! RESERVED ATTRIBUTES:
!----------------------------------------------------------------------------

attribute known                         ! set once an object is known about
attribute moved                         !  "  once an object is moved
attribute visited alias moved           !  "  once a room is visited
attribute static                        !  "  when object cannot be taken
attribute plural                        !  "  for plural objects
attribute living                        !  "  if object is a character
attribute female                        !  "  if character is female
attribute openable                      !  "  if object can be opened
attribute open                          !  "  if object is open
attribute lockable                      !  "  if object can be locked
attribute locked                        !  "  if object is locked
attribute unfriendly                    ! for characters
attribute light                         ! set if an object is/provides light
attribute readable                      !  "  if object can be read
attribute switchable                    !  "  if object can be turned on/off
attribute switchedon                    !  "  if object is on
attribute clothing                      !  "  if object can be worn
attribute worn                          !  "  if object is being worn
attribute mobile alias worn             !  "  if object may be moved around
attribute enterable                     !  "  if object may be entered
attribute container                     !  "  if things can be placed ON obj.
attribute platform                      !  "  if things can be placed IN obj.
					!     ("container" and "platform" are
					!      mutually exclusive)
attribute hidden                        !  "  if object isn't listed
attribute quiet                         !  "  if container/platform is quiet
					!     (contents not initially listed)
attribute transparent                   !  "  if object is not opaque

attribute workflag                      ! for library use
attribute already_listed alias workflag 

attribute special                       ! for miscellaneous use


!----------------------------------------------------------------------------
! RESERVED GLOBALS:
!----------------------------------------------------------------------------

!\ The first 10 are pre-defined by the compiler:

global object                           ! direct object of a verb action
global xobject                          ! indirect object
global self                             ! self-referential object
global words                            ! total number of words
global player                           ! the player object
global actor                            ! player, or a char. (for scripts)
global location                         ! location of the player object
global verbroutine                      ! the verb routine
global endflag                          ! if not false (0), run EndGame
global prompt                           ! for input line
global objects                          ! total number of objects
global linelength                       ! with current printing configuration
global pagelength                       !  "      "       "          "
\!

global MAX_SCORE                        ! total possible score
global FORMAT                           ! contains bitmap of format masks
global DEFAULT_FONT                     ! 0=monospaced normal text
global STATUSTYPE                       ! 0=none, 1=score/turns, 2=time
global DISPLAYTYPE                      ! 0=text, 1=graphics
global UNDO_OFF                         ! overrides undo when true

global counter                          ! elapsed turns (or time, as desired)
global score                            ! accumulated score
global verbosity                        ! for room descriptions
global nest                             ! used by ListObjects
global light_source                     ! in location
global event_flag                       ! set when something happens
global speaking                         ! if the player is talking to a char.
global old_location                     ! whenever location changes
global obstacle                         ! if something is stopping the player
global list_count                       ! number of unlisted objects
global need_newline                     ! true when newline should be printed
global override_indent                  ! true if no indent should be printed
global best_parse_rank                  ! for matching similarly named objects
global customerror_flag                 ! true after CustomError is called

#ifclear NO_SCRIPTS
constant MAX_SCRIPTS      16            !
constant MAX_SCRIPT_STEPS 32            !
global number_scripts                   ! for object scripts
array scriptdata[48]                    !
array setscript[1024]                   !
#endif

global MAX_RANK                         ! up to 10 levels of player ranking
array ranking[10]                       !   allowed for

global it_obj                           !
global them_obj                         !
global him_obj                          ! to reference objects via pronouns
global her_obj                          !
array replace_pronoun[4]                !

constant MAX_WORDS 32                   ! in a parsed input line
array oldword[MAX_WORDS]                ! for "again" command

global general                          ! for general use


!----------------------------------------------------------------------------
! COLOR CONSTANTS AND GLOBALS
!----------------------------------------------------------------------------

constant BLACK           0
constant BLUE            1
constant GREEN           2
constant CYAN            3
constant RED             4
constant MAGENTA         5
constant BROWN           6
constant WHITE           7
constant DARK_GRAY       8
constant LIGHT_BLUE      9
constant LIGHT_GREEN    10
constant LIGHT_CYAN     11
constant LIGHT_RED      12
constant LIGHT_MAGENTA  13
constant YELLOW         14
constant BRIGHT_WHITE   15

constant DEF_FOREGROUND 16
constant DEF_BACKGROUND 17

global TEXTCOLOR      = DEF_FOREGROUND  ! normal text color
global BGCOLOR        = DEF_BACKGROUND  ! normal background color
global SL_TEXTCOLOR   = BRIGHT_WHITE    ! statusline text color
global SL_BGCOLOR     = BLUE            ! statusline background color


!----------------------------------------------------------------------------
! PRINTING FORMAT MASKS
!
! The following are bitmasks added/subtracted from the FORMAT global
! to affect text/list output.  Combine formats using "+" or "|" as in:
!
!       FORMAT = LIST_F | GROUPPLURALS_F | ...
!----------------------------------------------------------------------------

constant LIST_F                 1       ! print itemized lists, not sentences
constant NORECURSE_F            2       ! do not recurse object contents
constant NOINDENT_F             4       ! do not indent listings
constant DESCFORM_F             8       ! alternate room desc. formatting
constant GROUPPLURALS_F        16       ! list plurals together where possible

! For internal use:

constant INVENTORY_F           32       ! list as player inventory
constant FIRSTCAPITAL_F        64       ! capitalize first article
constant ISORARE_F            128       ! print "is" or "are" at the start
constant ISORAREHERE_F        256       ! print "is here" or "are here" last
constant USECHARNAMES_F       512       ! before listing contents
constant TEMPLIST_F          1024       ! used if LIST_F must be overridden

global INVENTORY_MASK = 0               ! may be set by DoInventory


!----------------------------------------------------------------------------
! FONT STYLE BITMASKS
!
! Used with the Font routine to set or change the font style.  Combine
! settings using "+" or "|", as in:
!
!       Font(BOLD_ON | ITALIC_OFF | ...)
!----------------------------------------------------------------------------

#ifclear NO_FONTS
constant BOLD_ON         1
constant BOLD_OFF        2
constant ITALIC_ON       4
constant ITALIC_OFF      8
constant UNDERLINE_ON   16
constant UNDERLINE_OFF  32
constant PROP_ON        64              ! proportional printing
constant PROP_OFF      128
#endif


!----------------------------------------------------------------------------
! ADDITIONAL CONSTANTS (AND GLOBALS)
!----------------------------------------------------------------------------

constant UP_ARROW       11              ! special keystrokes
constant DOWN_ARROW     10
constant LEFT_ARROW      8
constant RIGHT_ARROW    21
constant ESCAPE_KEY     27
constant ENTER_KEY      13

constant AND_WORD       "and"           ! for language translation
constant ARE_WORD       "are"
constant HERE_WORD      "here"
constant IN_WORD        "in"
constant IS_WORD        "is"
constant ON_WORD        "on"

constant FILE_CHECK     4660            ! for readfile/writefile blocks

global INDENT_SIZE =  2			! for paragraph formatting
global AFTER_PERIOD = "  "            	! double-space after period


!----------------------------------------------------------------------------
! SYNONYMS, COMPOUNDS, AND REMOVALS
!----------------------------------------------------------------------------

synonym "and" for "~and"
synonym "except" for "~except"
synonym "but" for "~except"
synonym "all" for "~all"
synonym "everything" for "~all"
synonym "any" for "~any"
synonym "either" for "~any"
synonym "oops" for "~oops"
synonym "o" for "~oops"
synonym "mine" for "my"
synonym "myself" for "me"
synonym "herself" for "her"
synonym "himself" for "him"
synonym "themselves" for "them"

compound "mr", "."
compound "mrs", "."
compound "off", "of"
compound "out", "of"
compound "on", "to"
compound "in", "to"

removal "a", "an", "the", "some", "of"


!----------------------------------------------------------------------------
object nothing "nothing"                ! OBJECT 0:  the great granddaddy
{}


!----------------------------------------------------------------------------
! EndGame(end_type)
! called by the engine via EndGame(end_type) when endflag is not false 
! (endflag is cleared previous to calling); return false to terminate
!
! Default responses (in PrintEndGame):  1 = win, 2 = die, 3 = no resp.

routine EndGame(end_type)
{
	local r
	
	PrintStatusLine                 ! update one last time
	PrintEndGame(end_type)          ! print appropriate ending message

:AskAgain

	Message(&EndGame, 1)    ! ask to RESTART, RESTORE, (UNDO), or QUIT
	
	r = -1
	
	while true
	{
		GetInput
		select word[1]
			case "restart"
			{
				if restart
					{r = true
					PrintStatusline}
				else:  Message(&DoRestart, 2)   ! failed
				break
			}
			case "restore"
			{
				if restore
					{r = true
					PrintStatusline
					DescribePlace(location)}
				else:  Message(&DoRestore, 2)   ! failed
				break
			}
#ifclear NO_UNDO
			case "undo", "u"
			{
				if not UNDO_OFF
				{
					if undo
						{r = true
						PrintStatusLine
						DescribePlace(location)}
					else
						Message(&DoUndo, 1)  ! failed
				}                
				else
					Message(&DoUndo, 1)
				break
			}
#endif
			case "quit", "q"
				{r = 0
				break}

		Message(&EndGame, 2)    ! ask again (more succinctly)
	}

	if r = -1:  jump AskAgain

	return r
}

routine PrintEndGame(end_type)
{
	Font(BOLD_ON)
	select end_type
		case 1:  print "\n*** YOU'VE WON THE GAME! ***"
		case 2:  print "\n*** YOU HAVE DIED ***"
	Font(BOLD_OFF)
	PrintScore(true)
}

!----------------------------------------------------------------------------
routine PrintScore(end_of_game)
{
	if STATUSTYPE = 1 and MAX_SCORE
	{
		if end_of_game:  print ""
		print "You ";
		if not end_of_game
			print "have ";
		print "scored a total of ";
		print number score; " out of "; number MAX_SCORE;
		if ranking[0] ~= ""
		{
			print ", giving you the rank of ";
			
			! A complicated formula, since only 
			! integer division is allowed: 
			
			print ranking[(score*100)/MAX_SCORE*MAX_RANK/100]
		}
		print "."
	}
}

!----------------------------------------------------------------------------
! Parse is called by the engine without parameters; returning true signals
! the engine to reparse the input line

routine Parse
{
	local a, n
	local reparse

	best_parse_rank = 0             ! reset each parser cycle
	nest = 0

	if nothing ~= 0                 ! best place to check this
		print "[WARNING:  Objects/classes defined before library]"
	
! The following, devised by Jim Newland, checks to see if the player        
! input refers to an unnecessary item of scenery (for example) which is
! nonetheless mentioned in the location description.

	for (a=1; a<=words and word[a]~=""; a=a+1)
	{
		if Inlist(location, extra_scenery, word[a])
		{
			Message(&Parse, 1)
			word[1] = ""            ! force ParseError(0)
			words = 0
			customerror_flag = true
			return true
		}
	}
	
	PreParse                        ! easily replaceable routine

	! Last player-specified object
	if object:  AssignPronoun(object)

	! To repeat last command
	if (word[1] = "again" or word[1] = "g") and words = 1
	{
		for (a=1; a<=oldword[0]; a=a+1)
			word[a] = oldword[a]
		words = oldword[0]
		reparse = true
		jump LeaveParse
	}

! Reword imperatives given as "Tell Bob to do something" as "Bob, do 
! something"

	elseif word[1] = "tell", "order", "instruct", "ask", "command"
	{
		for (a=1; a<=words and word[a]~=""; a=a+1)
		{
			if word[a] = "to"
			{
				DeleteWord(a)   ! "to"
				DeleteWord(1)   ! "tell", "order", etc.
				reparse = true
				break
			}
		}
	}

	local count, number_pronouns
	for (count=1; count<=words and word[count]~=""; count=count+1)
	{
		select word[count]

			! Rename pronouns to appropriate objects
			case "it", "them", "him", "her"
			{
				select word[count]
					case "it":   a = it_obj
					case "them": a = them_obj
					case "him":  a = him_obj
					case "her":  a = her_obj

				n = SetObjWord(count, a)
				replace_pronoun[number_pronouns] = a
				number_pronouns = number_pronouns + 1
				if n > 1
					count = count + (n - 1)
				reparse = true
			}

			! Allow for "then..." and "and then..."
			case "then"
			{
				word[count] = "."       ! end of this command
				if word[count-1] = "~and"
					DeleteWord(count-1)
				reparse = true
				break
			}
	}

	if number_pronouns > 0          ! print name(s) of assumed object(s)
	{
		Message(&Parse, 2)      ! "Assuming you mean..."
		for (count = 0; count < number_pronouns; count=count+1)
		{
			if count > 0
			{
				if number_pronouns > 2
					print ",";
				if count = number_pronouns - 1
					print " "; AND_WORD; 
			}
			print " ";
			if replace_pronoun[count].name = ""
				The(nothing)
			else
				The(replace_pronoun[count])
		}
		if number_pronouns > 1
			Message(&Parse, 3)      ! ", respectively"
		print ".)"
	}

#ifset USE_PLURAL_OBJECTS
	if ParsePluralObjects:  reparse = true
#endif

	! Store current command for future reference
	for (a=1; a<=words and a<MAX_WORDS; a=a+1)
		oldword[a] = word[a]
	oldword[a] = ""
	a = a - 1
	oldword[0] = a

:LeaveParse
	
#ifset DEBUG
	if debug_flags & D_PARSE
	{
		for (a=1; a<=words and word[a]~=""; a=a+1)
			print "["; word[a]; "] ";
		print newline
	}
#endif

	return reparse
}

routine PreParse                        ! to be REPLACED if needed
{}

routine SetObjWord(a, obj)      ! inserts unique name of <obj> at word <a>
{
	local i, n
	
	if obj.adjective                ! Allowing multiple adjectives...
	{
		n = obj.#adjectives
		if n > 4 {n = 4}        ! ...(up to 4)...

		if n > 1:  InsertWord(a, n-1)
		for (i=1; i<=n; i=i+1)
		{
			word[a] = obj.adjective #i
			a = a + 1
		}
	}
	
	if obj.noun                     ! ...and 1 noun (obj.noun #1)
	{       
		if n:  InsertWord(a)
		word[a] = obj.noun
		a = a + 1
		n = n + 1
	}
	
	return n
}

routine InsertWord(n, b)                ! inserts <b> words at position <n>
{
	local i
	
	if words+1 >= MAX_WORDS:  return

	if b = 0:  b = 1

	for (i=words+b; i>n; i=i-1)
		word[i] = word[i-b]
	words = words + b

	return b
}

routine DeleteWord(n, b)                ! deletes <b> words at position <n>
{
	local i

	if b = 0:  b = 1

	if (words < b) or (n + b >= MAX_WORDS):  return

	for (i=n; i<=words-b; i=i+1)
		word[i] = word[i+b]
	word[words] = ""
	words = words - b

	return b
}

routine ObjWord(wd, obj)                ! returns adjective or noun if <wd> 
{                                       ! is either for <obj>; else returns
	local i                         ! false

	if InList(obj, noun, wd)
		return noun

	if InList(obj, adjective, wd)
		return adjective

	return false                    ! didn't match either
}

!----------------------------------------------------------------------------
! ParseError(errornumber, object)
! prints an appropriate error message; if called by the engine, signals the
! engine to produce the default message by returning false
!
! (Note:  If <errornumber> is equal to or greater than 100, CustomError
! is called instead.  REPLACE CustomError for cases where custom error 
! messages are desired for user parsing routines.  Do not call CustomError
! directly.)

routine ParseError(errornumber, obj)
{
	if errornumber >= 100
	{
		CustomError(errornumber, obj)
		word[1] = ""            ! force ParseError(0)
		words = 0
		customerror_flag = true
		return true
	}
	if customerror_flag
	{
		customerror_flag = 0    ! CustomError already printed error
		return true
	}
	
	select errornumber
		
		case 6
			print "That doesn't make any sense."
		
		case 9
		{
			print "Nothing to ";
			if verbroutine
				print parse$; "."
			else:  print "do."
		}
		
		case 10
		{
			print "You haven't seen ";
			if obj is living
				print "anybody";
			else:  print "anything";
			print " like that."
		}
		
		case 11
		{
			if not ObjectisKnown(obj)
				ParseError(10, obj)
			elseif obj is living
			{
				CThe(obj)
				if obj is plural
					print " aren't";
				else:  print " isn't";
				print " here."
			}
			else
			{
				print "You don't see ";
				if obj is plural
					print "those."
				else:  print "that."
			}
		}
		case 12
			print "You can't do that with "; The(obj) ; "."
		
		case 14
		{
			if xobject is living
				print CThe(xobject); \
				" doesn't have "; The(obj); "."
			else
				print "You don't see "; The(obj); " there."
		}
		
		case 15
		{
			print "You aren't holding "; 
			if obj is plural
				print "those."
			else:  print "that."
		}
		
		case else: return false         ! print the default message

	return true                             ! message already printed
}

routine CustomError(errornumber, obj)   ! to be REPLACED if custom error
{}                                      ! messages are desired for user
					! parsing routines

!----------------------------------------------------------------------------
! SpeakTo is called by the engine when a command is addressed to a
! character object via:  SpeakTo(character)
!
! For example, the input line
!
!   <character>, get the <object>
!
! will call SpeakTo(<character>), with the global object containing <object>,
! and the verbroutine global set to &DoGet

#ifclear NO_VERBS

routine SpeakTo(char)
{
	speaking = 0
	
	if char is not living
	{
		ParseError(6)
		return
	}

	AssignPronoun(char)

	if not FindObject(char, location)
	{
		ParseError(11, char)
		return
	}
	elseif char = player
	{
		Message(&Speakto, 1)    ! "Stop talking to yourself..."
		return
	}

	if char is unfriendly
		jump IgnorePlayer

	speaking = char

	select verbroutine
		case 0                  ! Just the character name is given,
					! so just "X is listening."
			Message(&Speakto, 2, char)

		case &DoHello           ! Note the ampersands ("&")--or else
		{                       ! the routines themselves would run
			if not char.order_response
				Message(&Speakto, 3, char) ! "X nods hello."
		}
		case &DoAskQuestion
			return Perform(&DoAsk, char, object)
		
		case &DoTalk
		{
			if xobject
				ParseError(6)
			else     
				return Perform(&DoAsk, char, object)
		}
		case &DoTell
		{
			if object = player
				return Perform(&DoAsk, char, xobject)
			else
				jump TryResponse
		}
		case else
		{

! If the character can respond to a request, this should be dealt with by 
! an order_response property routine; order_response--if it exists--should
! return false if there is no response for the given verbroutine

:TryResponse
			
			if not char.order_response
				jump IgnorePlayer
			return true
		}
	return false

:IgnorePlayer

	if not char.ignore_response
		Message(&Speakto, 4, char)      ! "X ignores you."
	speaking = 0
	return true
}

#endif  ! ifclear NO_VERBS

!----------------------------------------------------------------------------
! Perform(&action, object, xobject)
! calls the verbroutine given by <action>, with globals object and xobject
! as given; returns value returned by <action> (or <object>.before)
!
! NOTE:  Ensure that the <action> is an address (preceded by &), not a
! standard routine call.

routine Perform(action, obj, xobj)
{
	local r
	local objtemp, xobjtemp, verbtemp

	objtemp = object
	xobjtemp = xobject
	verbtemp = verbroutine
	
	object = obj
	xobject = xobj
	verbroutine = action

	r = player.before               ! run before routines
	if r:  jump DonePerform
	r = location.before
	if r:  jump DonePerform
	r = xobject.before
	if r:  jump DonePerform
	r = object.before
	if r:  jump DonePerform

	r = call action                 ! object.after and xobject.after
					! run by verbroutine
	
	run player.after
	run location.after

:DonePerform
	verbroutine = verbtemp
	object = objtemp
	xobject = xobjtemp

	return r
}

!----------------------------------------------------------------------------
! AnyVerb(obj)
! returns <obj> if the verbroutine global is currently not in the set of
! xverbs; otherwise returns false

routine AnyVerb(obj)
{
	if verbroutine >= &DoHello and verbroutine <= &DoUndo
		return false
	else
		return obj
}

!----------------------------------------------------------------------------
! x = InList(object, property, y)
! returns false if <y> is not contained in the list of values held in
! <object>.<property>; otherwise returns the number of the (first) property
! element equal to <y>

routine InList(obj, prop, y)
{
	local i

	for (i=1; i<=obj.#prop; i=i+1)
	{
		if obj.prop #i = y:  return i
	}
}

!----------------------------------------------------------------------------
! x = FindObject(object, object location)
! returns false if <object> is unavailable in <object location>; returns
! 2 if <object> is visible but not physically accessible

routine FindObject(obj, objloc)
{
	local a, p

	if obj = nothing or obj = player:  return true

	if objloc = 0
	{
		if obj.parse_rank < best_parse_rank     
			return false
		else
			best_parse_rank = obj.parse_rank

		if not ObjectisKnown(obj)
			return false
		return true
	}
	
	if verbroutine = &DoGet 
	{
		if (word[2] = "~all" or word[3] = "~all") and 
			obj.type = scenery:
			return false
	}

#ifclear NO_FUSES
	if (obj.type = fuse or obj.type = daemon) and obj is not active
		return false
#endif
		
	p = parent(obj)

	if obj = objloc or p = objloc or p = player
		{obj is known
		return true}
	elseif (p is not openable or p is platform) and p is not quiet and
		p ~= nothing:
	{
		if FindObject(p, objloc) and ObjectisKnown(p)
			return true
	}
	elseif p is openable and p is open and p is not quiet and
		p ~= nothing:
	{
		if FindObject(p, objloc) and ObjectisKnown(p)
			return true
	}
	elseif p is openable, not open, transparent, not quiet and
		p ~= nothing:
	{
		if FindObject(p, objloc) and ObjectisKnown(p)
			return 2
	}
	elseif player not in location
	{
		if Contains(parent(player), object) and FindObject(p, objloc)
			return true
	}
	
	if obj.#found_in
	{
		for (a=1; a<=obj.#found_in; a=a+1)
		{
			if obj.found_in #a and (obj.found_in #a = objloc or
				FindObject(obj.found_in #a, objloc)):
				{obj is known
				return true}
		}
	}
	
	if obj.#in_scope
	{
		for (a=1; a<=obj.#in_scope; a=a+1)
		{
			if obj.in_scope #a=objloc or obj.in_scope #a=actor
				{obj is known
				return true}
			if obj.in_scope #a and
				FindObject(obj.in_scope #a, objloc):
				{obj is known
				return true}
		}
	}
}       

routine ObjectisKnown(a)                ! If it is undesirable to use the
{                                       ! rules for disqualifying hitherto
	if a is known                   ! unknown objects from player actions,
		return true             ! REPLACE ObjectisKnown with a routine
					! that always returns a true value
}

!----------------------------------------------------------------------------
! PutInScope(object, actor)
! makes <object> accessible to <actor> (where <actor> is usually the player)
! provided that <object> has an in_scope property with an empty slot--i.e. 
! one that equals 0; returns false if <object> cannot be placed in scope 
! of <actor>
!
! RemoveFromScope(object, actor)
! removes <object> from the scope of <actor>

routine PutInScope(obj, act)
{
	local a
	
	if act = 0:  act = player
	for (a=1; a<=obj.#in_scope; a=a+1)
	{
		if obj.in_scope #a = 0
			{obj.in_scope #a = act
			return true}
	}
}

routine RemoveFromScope(obj, act)
{
	local a

	for (a=1; a<=obj.#in_scope; a=a+1)
	{
		if obj.in_scope #a = act
			{obj.in_scope #a = 0
			return true}
	}
}

!----------------------------------------------------------------------------
! AssignPronoun(object)
! sets the appropriate pronoun global to <object>

routine AssignPronoun(obj)
{
	if obj = player {return}        
	
	if obj is not living
	{
		if obj is not plural
			it_obj = obj
		else
			them_obj = obj
	}
	else
	{
		if obj is plural
			them_obj = obj
		elseif obj is female
			her_obj = obj
		else
			him_obj = obj
	}
}

!----------------------------------------------------------------------------
! PrintStatusline
! prints an appropriate statusline as specified by global STATUSTYPE

routine PrintStatusline
{
	local temp_it_obj

	temp_it_obj = it_obj
	Font(BOLD_OFF | ITALIC_OFF | UNDERLINE_OFF | PROP_OFF)
	color SL_TEXTCOLOR, SL_BGCOLOR
	window
	{
		if not light_source
			print "In the dark";
		else
		{
			if FORMAT & DESCFORM_F:  print "\_"; 
			print capital location.name;
		}
		
		if linelength >= 80
			print to 65;
		else
			print to linelength

		if STATUSTYPE = 1
			print number score; " / "; number counter;
		elseif STATUSTYPE = 2
			print HoursMinutes(counter);
		print to linelength
	}
	color TEXTCOLOR, BGCOLOR
	Font(DEFAULT_FONT)
	it_obj = temp_it_obj
}

!----------------------------------------------------------------------------
! HoursMinutes(val)
! prints the time in 12-hour hh:mm format, as given by <val> minutes past
! midnight

routine HoursMinutes(val)
{
	local hours, minutes

	hours = val / 60
	minutes = val - hours * 60
	if hours > 12
		hours = hours - 12
	print number hours; ":";
	if minutes < 10
		print "0";
	print number minutes; " ";

	if counter > 720
		print "p.m.";
	else
		print "a.m.";
}

!----------------------------------------------------------------------------
! The(object)                           ! prints "the <object>"

routine The(obj)
{
	AssignPronoun(obj)

	if obj.article
		print "the ";
	print obj.name;
}

!----------------------------------------------------------------------------
! CThe(object)                          ! prints "The <object>"

routine CThe(obj)
{
	AssignPronoun(obj)

	if obj.article
		print "The "; obj.name;
	else
		print capital obj.name;
}

!----------------------------------------------------------------------------
! Art(object)

routine Art(obj)                        ! prints, for example, "an <object>"
{
	AssignPronoun(obj)

	if obj.article
		print obj.article; " ";
	print obj.name;
}

!----------------------------------------------------------------------------
! CArt(object)                          ! prints, for example, "An <object>"

routine CArt(obj)
{
	AssignPronoun(obj)

	if obj.article
		print capital obj.article; " "; obj.name;
	else
		print capital obj.name;
}

!----------------------------------------------------------------------------
! IsorAre(object, [optional parameter])
! prints "is" or "are" (or "'s" or "'re") to agree with <object>
!
! IsorAre(object, true)
! forces use of "is" and "are" instead of "'s" and "'re"

routine IsorAre(obj, a)
{
	if obj is plural
	{
		if a:  print " are";
		else:  print "'re";
	}
	else
	{
		if a:  print " is";
		else:  print "'s";
	}
}

!----------------------------------------------------------------------------
! MatchSubject(object)
! conjugates a present-tense verb to agree with <object>

routine MatchSubject(obj)
{
	if obj is not plural
		print "s";
}

!----------------------------------------------------------------------------
! NumberWord(number)
! prints a number in non-numerical word format, where <number> is between
! -32767 to 32767
!
! NumberWord(number, true)
! prints the word beginning with a capital letter if a second (true)
! argument is provided

routine NumberWord(n, c)
{
	local a, f

	if n = 0
	{
		if c:  print capital DigitWord(n);
		else:  print DigitWord(n);
		return
	}
	if n < 0      
	{
		if c:  print "Minus ";
		else:  print "minus ";
		n = -n
		c = 0
	}
	
	f = 1000
	while n
	{
		if n >= f
		{
			if a
			{
				if f = 100:     print ", ";
				elseif f = 10:  print " "; AND_WORD; " ";
				elseif f = 1:   print "-";
			}
			
			if f >= 100
			{
				if c:  NumberWord(n/f, c)
				else:  NumberWord(n/f)
				print " "; DigitWord(f);
				n = n-n/f*f
			}
			elseif f = 10 and (n >= 20)
			{
				if c:  print capital DigitWord(n/10*10);
				else:  print DigitWord(n/10*10);
				n = n-n/f*f
			}
			else
			{
				if c:  print capital DigitWord(n);
				else:  print DigitWord(n);
				n = 0
			}
			c = 0
			a = true
		}
		f = f/10
	}
}

routine DigitWord(n)
{
	select n
	case 0:         return "zero"
	case 1:         return "one"
	case 2:         return "two"
	case 3:         return "three"
	case 4:         return "four"
	case 5:         return "five"
	case 6:         return "six"
	case 7:         return "seven"
	case 8:         return "eight"
	case 9:         return "nine"
	case 10:        return "ten"
	case 11:        return "eleven"
	case 12:        return "twelve"
	case 13:        return "thirteen"
	case 14:        return "fourteen"
	case 15:        return "fifteen"
	case 16:        return "sixteen"
	case 17:        return "seventeen"
	case 18:        return "eighteen"
	case 19:        return "nineteen"
	case 20:        return "twenty"
	case 30:        return "thirty"
	case 40:        return "forty"
	case 50:        return "fifty"
	case 60:        return "sixty"
	case 70:        return "seventy"
	case 80:        return "eighty"
	case 90:        return "ninety"
	case 100:       return "hundred"
	case 1000:      return "thousand"
}

!----------------------------------------------------------------------------
! Indent
! indents only if the NOINDENT_F bit is not set in the FORMAT mask; returns 
! the null word "" (0 or false)

routine Indent
{
	local i
	
	if override_indent
		print AFTER_PERIOD;
	elseif not (FORMAT & NOINDENT_F) and INDENT_SIZE
	{
		print "\_";
		for (i=2; i<=INDENT_SIZE; i=i+1)
			print " ";
	}
	override_indent = false
}

!----------------------------------------------------------------------------
! DescribePlace(location, [optional parameter])
! prints a "You are in a..." message, followed by the location description,
! if required
!
! DescribePlace(location, true)
! forces a location description

routine DescribePlace(place, long)
{
	local obj, count, notlisted, tempformat

	if not light_source
		{Message(&DescribePlace, 1)     ! "It's too dark to see..."
		return}

	place is known
	Font(BOLD_ON)
	print "\n"; capital place.name;
	if location = place and player not in place
	{
		if parent(player).prep
			print ", "; parent(player).prep; " ";
		else
			print ", "; IN_WORD; " ";
		print Art(parent(player))
	}
	print newline
	Font(BOLD_OFF)
	override_indent = false

	if place is not visited and verbosity ~= 1
	{
		if &place.initial_desc or &place.long_desc
			Indent
		if not place.initial_desc
			run place.long_desc
	}
	elseif long = true or verbosity = 2
	{
		if &place.long_desc
			Indent
		run place.long_desc
	}
	
	if &place.list_contents and FORMAT & DESCFORM_F
		print ""        ! for double-space-after-heading formatting
	
	if not place.list_contents
	{
		nest = 0

		! For double-space-after-heading formatting:
		for obj in place
		{
			if obj is not hidden and obj ~= player and 
				(player not in obj or children(obj) > 1) and
				FORMAT & DESCFORM_F:
				{print ""
				break}
		}

		! List contents of chair, vehicle, etc. player is in
		if player not in location
			WhatsIn(Parent(player))
			
		! List all characters, if any
		count = 0
		for obj in place
		{
			if obj is hidden or obj is not living or 
				obj = player or player in obj:
				obj is already_listed
			else
			{
				obj is not already_listed
				ShortDescribe(obj)
				if obj is not already_listed
					count = count + 1
			}        
		}
		
		list_count = count
		count = 0

		if list_count           ! if characters are to be listed
		{
			tempformat = FORMAT
			FORMAT = FORMAT | FIRSTCAPITAL_F | ISORAREHERE_F
			FORMAT = FORMAT | USECHARNAMES_F
			if FORMAT & LIST_F
			{
				FORMAT = FORMAT & ~LIST_F       ! clear it
				FORMAT = FORMAT | TEMPLIST_F
			}
			Indent
			nest = 0
			ListObjects(place)
			FORMAT = tempformat
		}

		for obj in place
		{
#ifset USE_ATTACHABLES
			! Exclude all attachables for now (and characters)

			if obj is living or obj.type = attachable or
				player in obj
#endif
#ifclear USE_ATTACHABLES
			if obj is living or player in obj
#endif
				obj is already_listed
			else
				obj is not already_listed
		}
		
		for obj in place
		{
#ifset USE_PLURAL_OBJECTS
			! ...And don't list identical objects yet, either

			if (obj.identical_to).type = identical_class
			{
				if obj is not hidden
					count = count + 1
			}
			elseif obj ~= player and player not in obj
#endif
#ifclear USE_PLURAL_OBJECTS
			if obj ~= player and player not in obj
#endif
			{
				if obj is not already_listed and
					obj is not hidden:
				{
					ShortDescribe(obj)
					if obj is not already_listed
						notlisted = notlisted + 1
				}
			}
		}

		if notlisted or count
		{
			list_count = notlisted + count
			tempformat = FORMAT
			FORMAT = FORMAT | FIRSTCAPITAL_F | ISORAREHERE_F
			if FORMAT & LIST_F
			{
				FORMAT = FORMAT & ~LIST_F       ! clear it
				FORMAT = FORMAT | TEMPLIST_F
			}
			Indent
			nest = 0
			ListObjects(place)
			FORMAT = tempformat
		}

#ifclear NO_OBJLIB
#ifset USE_ATTACHABLES
		for obj in place
		{
			! Print attachables last
			if obj.type = attachable and obj is not hidden
			{
				ShortDescribe(obj)
				if obj is not already_listed
					Message(&DescribePlace, obj, 2)
			}
		}
#endif

		print newline
		override_indent = false
		
		! Finally, list contents of scenery objects
		for obj in place
		{
			if obj.type = scenery
				WhatsIn(obj)
		}
#endif  ! ifclear NO_OBJLIB
	
	}
}

!----------------------------------------------------------------------------
! ShortDescribe(object)
! prints the initial description of <object> if not moved (if it has one),
! or the when_open or when_closed message, if applicable, or the short 
! description if moved (if it has one).

routine ShortDescribe(obj)
{
	obj is known
	
	AssignPronoun(obj)

	if obj is not moved and &obj.initial_desc 
	{
		Indent
		run obj.initial_desc
		jump CheckContents
	}
			
	if obj is openable
	{
		if obj is open 
		{
			if &obj.when_open 
			{
				Indent
				run obj.when_open
				jump CheckContents
			}
		}
		elseif &obj.when_closed 
		{
			Indent
			run obj.when_closed
			jump CheckContents
		}
	}
			
	if &obj.short_desc 
		Indent
	
	if not obj.short_desc
		return

:CheckContents

	obj is already_listed
	AssignPronoun(obj)

	list_count = 0
	if children(obj) > 0 and (obj is not container or
		(obj is container and obj is not openable) or
		(obj is container and obj is openable and 
			(obj is open or obj is transparent))) and
		obj is not quiet:
	{
		nest = 0
		WhatsIn(obj)
	}
	if need_newline:  print newline
}

!----------------------------------------------------------------------------
! WhatsIn(object)
! lists the children of <object>, if any, in a relatively orderly manner

routine WhatsIn(obj)
{
	local i, flag, totallisted
	
	if FORMAT & NORECURSE_F
		return

	for i in obj
	{
		i is not already_listed
		if i is not hidden
			totallisted = totallisted + 1
	}

	if totallisted = 0
		return

	list_count = totallisted
	SpecialDesc(obj)
	
! If list_count is 0 now, but totallisted was not, something must have been 
! printed by SpecialDesc

	if list_count = 0
	{
		if FORMAT&INVENTORY_F and not (FORMAT&LIST_F) and nest = 0
			print ""
		return totallisted
	}

	if children(obj) = 1 and child(obj) = player
		return

	if obj is not container or
		(obj is container and (obj is not openable or
			(obj is openable and 
				(obj is open or obj is transparent)))) and
		(obj ~= player or FORMAT & INVENTORY_F) and obj is not quiet:
	{
		if obj.list_contents
			return totallisted

		if FORMAT & LIST_F
			print to (nest * INDENT_SIZE);
		else
			Indent                

		if obj.contains_desc    ! custom heading
		{
			if FORMAT & LIST_F
				print ":"
		}
		else
		{
			if obj = player
			{
				if FORMAT & LIST_F and list_count<totallisted
					print "\n";
				
				! "You are carrying..."
				Message(&WhatsIn, 1, totallisted)
				
				if FORMAT & LIST_F
					print ":"
			}
			elseif obj is living and not obj.prep
			{
				! "X has..."
				Message(&WhatsIn, 2, obj, totallisted)
				if FORMAT & LIST_F
					print ":"
			}
			else
			{
				if list_count < totallisted

					! "Also sitting on/in..."
					Message(&Whatsin, 3, obj)
				else

					! "Sitting on/in..."
					Message(&Whatsin, 4, obj)
				
				The(obj)
				FORMAT = FORMAT | ISORARE_F
			}
		}
		ListObjects(obj)
	}
	return totallisted
}

!----------------------------------------------------------------------------
! SpecialDesc(object)        
! checks the children of <object> and runs any applicable preliminary
! descriptions; returns the total number of remaining (i.e. non-listed) 
! objects in the list_count global variable

routine SpecialDesc(obj) 
{
	local a, c
		       
	if FORMAT & LIST_F
		return
	
	list_count = 0
	for a in obj
	{
		if a is not hidden
			c = c + 1
		
		if FORMAT & INVENTORY_F and obj = player 
		{
			if &a.inv_desc 
				Indent
			if a.inv_desc
			{
				if FORMAT & LIST_F:  print newline
				else:  print AFTER_PERIOD;
				AddSpecialDesc(a)
			}
		}
		
		elseif a is not moved
		{
			if &a.initial_desc 
			{
			  print newline
			  override_indent = false
			  if FORMAT & INVENTORY_F and FORMAT & NOINDENT_F
				print ""
			  Indent
			}
			if a.initial_desc
				AddSpecialDesc(a)
		}
	}
	list_count = c - list_count
}

routine AddSpecialDesc(a)
{
	a is already_listed
	a is known
	list_count = list_count + 1
	AssignPronoun(a)
}

!----------------------------------------------------------------------------
! ListObjects(object)          
! lists all the objects in <object>, providing that the list_count global 
! contains the total number of objects to be listed.  

routine ListObjects(thisobj)
{
	local i, j, k, obj, count, pluralcount
	local templist_count            ! temporary total of unlisted objs.
	local this_class, id_count      ! for identical (or plural) objects
	local tempformat
	
	nest = nest + 1
	for obj in thisobj
	{
		if obj is hidden
		{
			obj is already_listed
			if obj.type = scenery
				obj is known
		}
		else
			obj is known

		! Need to count identical (and possibly plural) objects
		! for grouping in listing

#ifset USE_PLURAL_OBJECTS
		if obj.identical_to and obj is not already_listed
		{
			this_class = obj.identical_to
			if this_class.type = identical_class or
				FORMAT & GROUPPLURALS_F:
			{
			  id_count = 1
			  for (i=1; i<=this_class.#plural_of; i=i+1)
			  {
			    j = this_class.plural_of #i
			    if j in thisobj and j~=obj and j is not hidden
			      {id_count = id_count + 1
			      pluralcount = pluralcount + 1
			      list_count = list_count - 1
			      j is already_listed}
			  }
			}
		}
#endif
		if obj is not already_listed and obj ~= player
		{
			! May have a leading "is" or "are" that needs to
			! be printed at the head of the list
			
			if FORMAT & ISORARE_F
			{
				if list_count = 1 and id_count <= 1 and
					obj is not plural:
					print " "; IS_WORD;
				else:  print " "; ARE_WORD;
				if FORMAT & LIST_F
					print ":"
				FORMAT = FORMAT & ~ISORARE_F    ! clear it
			}
			
			need_newline = false
			if obj is plural
				pluralcount = pluralcount + 1

			AssignPronoun(obj)
			if not (FORMAT & LIST_F)
			{       
			  if list_count > 2 and count
			    print ",";
			  if list_count > 1 and count = list_count - 1 
			    print " "; AND_WORD;
			  if not (FORMAT & FIRSTCAPITAL_F)
			    print " ";
			}
			else
			{
				print to (nest * INDENT_SIZE);
			}

#ifset USE_PLURAL_OBJECTS
			
			! If a number of identical (or possibly plural)
			! objects are grouped together, they are printed
			! as a single entry in the list
			
			if obj.identical_to and
				(this_class.type = identical_class or
				FORMAT & GROUPPLURALS_F):
			{
			  if id_count = 1
			  {
			    if FORMAT & FIRSTCAPITAL_F
			      CArt(obj)
			    else
			      Art(obj)
			  }
			  else
			  {
			    if FORMAT & FIRSTCAPITAL_F
			      print NumberWord(id_count, true);
			    else
			      print NumberWord(id_count); 
			    print " "; this_class.name;
			  
			    if this_class.type = plural_class
			    {
			      if FORMAT & LIST_F
				print ":";
			      else
				print " (";

			      k = 0
			      for (i=1; i<=this_class.#plural_of; i=i+1)
			      {
				j = this_class.plural_of #i
				if parent(j) = thisobj
				{
				  if not (FORMAT & LIST_F)
				  {
				    if id_count > 2 and k:  print ",";
				    if k = id_count - 1:  print " "; AND_WORD;
				    if k:  print " ";
				  }
				  else
				  {
				    print "\n"; to ((nest+1) * INDENT_SIZE);
				  }
				  Art(j)
				  ObjectIs(j)
				  k = k + 1
				}
			      }
			      if not (FORMAT & LIST_F):  print ")";
			    }
			  }
			}
			else
			{
#endif
				if FORMAT & FIRSTCAPITAL_F
					CArt(obj)
				else:  Art(obj)
				ObjectIs(obj)
#ifset USE_PLURAL_OBJECTS
			}
#endif
			FORMAT = FORMAT & ~FIRSTCAPITAL_F       ! clear it
			
			! For itemized listings, list the children of
			! each object immediately after that object (unless
			! it is a SpecialDesc-printed description)
			
			if FORMAT & LIST_F
			{
				print newline
				if children(obj)
				{
					if not obj.list_contents
					{
					  templist_count = list_count
					  WhatsIn(obj)
					  list_count = templist_count
					}
				}
			}
			count = count + 1
		}
	}
	
	! If not an itemized list, it is necessary to finish off the 
	! sentence, adding any necessary words at the end.  Then, the
	! children of all previously objects listed at this level are
	! listed.
	
	if not (FORMAT & LIST_F)
	{
		if count 
		{
			if nest = 1 and FORMAT & ISORAREHERE_F
			{
				if count + pluralcount > 1
					print " "; ARE_WORD;
				else:  print " "; IS_WORD;
				print " "; HERE_WORD;
				FORMAT = FORMAT & ~ISORAREHERE_F  ! clear it
				
				if not (FORMAT&LIST_F or FORMAT&TEMPLIST_F)
					override_indent = true
			}
			print ".";
			
			if FORMAT & NOINDENT_F  ! force spacing if needed
				k = 1
			else:  k = 0
		}

		for obj in thisobj
		{
			if children(obj) and obj is not hidden and
				(obj is not already_listed or 
					thisobj ~= location):
			{        
				if FORMAT & TEMPLIST_F
				{
					FORMAT = FORMAT | LIST_F & ~TEMPLIST_F 
					print newline
				}
				elseif k            ! print forced spacing
				{
					print AFTER_PERIOD;
					k = 0
				}
				
				templist_count = list_count
				WhatsIn(obj)
				list_count = templist_count
			}
		}
	}

	nest = nest - 1
	if nest = 0
	{
		if not (FORMAT & LIST_F)
		{
			print newline
			override_indent = false
			need_newline = false
		}
	}
}

!----------------------------------------------------------------------------
! PropertyList(object, property[, article])
! lists all the objects in <object>.<property>, returning the number of
! objects printed; if <article> is false or omitted, the indefinite article
! is used

routine PropertyList(obj, prop, artic)
{
	local a, b, n, total

	for (a=1; a<=obj.#prop; a=a+1)
	{
		if obj.prop #a:  total = total + 1
	}
	
	for (a=1; a<=obj.#prop; a=a+1)
	{
		b = obj.prop #a
		if b
		{
			if artic
				The(b)
			else
				Art(b)
			
			if a < total and total > 2
				print ", ";
			elseif a = total - 1:  print " ";

			if a = total - 1
				print AND_WORD; " ";
			n = n + 1
		}
	}
	return n
}

!----------------------------------------------------------------------------
! MovePlayer(location[, silent])
! moves the player to the object <location>, with no description if <silent>
! is true
!
! MovePlayer(direction[, silent])
! moves player in <direction>, where <direction> is a direction object
!
! MovePlayer calls DarkWarning when there is no light source in the new
! location; REPLACE it with a new DarkWarning routine for a more elaborate
! response, such as the possible demise of the player

routine MovePlayer(loc, silent)
{
	local l, v
	
#ifclear NO_OBJLIB
	if loc.type = direction
	{
		l = location.(loc.dir_to)
		if l > 1                ! since a message always returns 1
			loc = location.(loc.dir_to)
		else
			return
	}
#endif

#ifset USE_ATTACHABLES
	if ObjectisAttached(player, location, loc)
		return
#endif
	v = verbroutine
	verbroutine = &MovePlayer
	if location.before:  jump LeaveMovePlayer
	verbroutine = v
	
	move player to loc
	old_location = location
	if parent(loc) = 0              ! if it's likely a room object
		location = loc
	else                            ! if it's an enterable object
		location = parent(loc)  ! (noting that the object must be
					! in a room, not inside another
					! non-room object)

#ifset USE_ATTACHABLES
	MoveAllAttachables(player, old_location, location)
#endif
	
	PrintStatusline

:LeaveMovePlayer
	
	if not FindLight(location)
		DarkWarning
	elseif not silent
		{DescribePlace(location)
		location is visited}

	return true
}

routine DarkWarning
	{"You stumble around in the dark."}

!----------------------------------------------------------------------------
! x = FindLight(object)
! returns the object number of light_source if any light is visible from 
! within <object> (where <object> is usually a location)
!
! ObjectisLight is called by FindLight

routine FindLight(loc)
{
	light_source = 0

	if loc is light
		{light_source = loc
		return light_source}
	elseif ObjectisLight(player)
		return light_source
	return ObjectisLight(loc)
}

routine ObjectisLight(obj)
{
	local nextobj

	if obj is light
		{light_source = obj
		return light_source}
	if obj is not container or
		(obj is container and obj is not openable) or 
		(obj is container and obj is openable and
			(obj is open or obj is transparent)):
	{
		for nextobj in obj
		{
			if ObjectisLight(nextobj)
				return light_source
		}
	}
}

!----------------------------------------------------------------------------
! ObjectIs(object)
! prints a list of parenthetical attributes

routine ObjectIs(obj)
{
	local i, n
	
	if obj is clothing:  n = TestObjectIs(obj, worn, "being worn", n)
	n = TestObjectIs(obj, light, "providing light", n)

	if n:  print ")";
	
	run obj.desc_detail
}

routine TestObjectIs(obj, attr, str, n)
{
	if obj is attr
	{
		if n = 0
			print " (";
		else
			print " "; AND_WORD;
		print str;
		n = n + 1
	}
	return n
}

!----------------------------------------------------------------------------
! x = Acquire(object 1, object 2)
! moves <object 2> to <object 1>; returns true if successful

routine Acquire(newparent, newchild)
{
	local p
	
	CalculateHolding(newparent)
	
	if newparent.holding + newchild.size > newparent.capacity
		return false
	else
	{
		p = parent(newchild)
		CalculateHolding(p)
		p.holding = p.holding - newchild.size
		move newchild to newparent
		newchild is moved
		newparent.holding = newparent.holding + newchild.size
		return true
	}
}

!----------------------------------------------------------------------------
! CalculateHolding(object)
! recalculates the correct holding property for an object; used before 
! adding or subtracting children

routine CalculateHolding(obj)
{
	local i

	obj.holding = 0
	for i in obj
		obj.holding = obj.holding + i.size
}

!----------------------------------------------------------------------------
! x = Contains(object 1, object 2)
! returns true if <object 1> contains <object 2> (even as a grandchild)

routine Contains(obj, possible_child)
{
	local nextobj

	for (nextobj=parent(possible_child); nextobj; nextobj=parent(nextobj))
	{
		if nextobj = obj
			return true
	}
}

!----------------------------------------------------------------------------
! x = CheckReach(object)
! returns true if either player object's current parent has no reach
! property specified, or if <object> is in the list of reachable objects

routine CheckReach(obj)
{
	local i

	if not parent(player).reach or Contains(parent(player), obj)
		return true

	if parent(obj) is living
	{
		if verbroutine ~= &DoGet, &DoLook
			
			! "Except that X has it..."
			Message(&CheckReach, 1, obj)

		elseif verbroutine = &DoGet and parent(obj) is unfriendly
			
			! "Except that X doesn't want to give it to you..."
			Message(&CheckReach, 2, obj)
	}
	
	for (i=1; i<=parent(player).#reach; i=i+1)
	{
		if Contains(parent(player).reach #i, obj) or
			obj = parent(player).reach #i:
			return true
	}

	! "You can't reach it..."
	Message(&CheckReach, 3, obj)
}

!----------------------------------------------------------------------------
! GetInput
! receives input from the keyboard, parsing into the word[] array; unknown
! words--i.e. those that aren't in the dictionary--are equated to the null
! string ("")
!
! GetInput(prompt)
! where the optional <prompt> represents a dictionary word, prints <prompt> 
! before receiving input

routine GetInput(p)
{
	local temp

	temp = prompt
	prompt = p
	input
	prompt = temp
}

!----------------------------------------------------------------------------
! x = YesorNo
! returns true if word[1] is "yes", false if "no"; prompts for a
! new input if neither

routine YesorNo
{
	local w
	w = word[1]
	while true
	{
		if w = "yes", "y"
			return true
		elseif w = "no", "n"
			return false

		Message(&YesorNo)       ! ask "yes" or "no"
		GetInput
		w = word[1]
	}
}

!----------------------------------------------------------------------------
! Font(style mask)
! changes the font style based on the style(s) specified in <style mask>,
! which may consist of one or more font bitmask constants combined with
! the "+" or "|" operator:
!
!       Font(BOLD_ON | ITALIC_OFF | ...)

#ifclear NO_FONTS
routine Font(mask)
{
	if mask & BOLD_ON:        print "\B";
	if mask & BOLD_OFF:       print "\b";
	if mask & ITALIC_ON:      print "\I";
	if mask & ITALIC_OFF:     print "\i";
	if mask & UNDERLINE_ON:   print "\U";
	if mask & UNDERLINE_OFF:  print "\u";
	if mask & PROP_ON:        print "\P";
	if mask & PROP_OFF:       print "\p";
}
#endif


!----------------------------------------------------------------------------
! AUXILIARY MATH ROUTINES:
!
! Function:     Returns:
!
! higher(a, b)  the greater of <a> or <b>
! lower(a, b)   the lower of <a> or <b>
! mod(a, b)     the remainder of <a> divided by <b>
! pow(a, b)     <a> to the power of <b>

#ifclear NO_AUX_MATH

routine higher(a, b)
{
	if a > b:  return a
	return b
}

routine lower(a, b)
{
	if a < b:  return a
	return b
}

routine mod(a, b)
	{return a-(a/b*b)}

routine pow(a, b)
{
	local i, n

	if b = 0:  return 1
	if b < 0:  return 0
	n = a
	for (i=2; i<=b; i=i+1)
		n = n * a
	return n
}

#endif  ! ifclear NO_AUX_MATH

!----------------------------------------------------------------------------
! STRING ARRAY ROUTINES:
!
! StringCompare(array1, array2)
! returns 1 if <array1> is lexically greater than <array2>, -1 if <array1>
! is lexically less than <array2>, and 0 if the two string arrays are
! identical
!
! StringCopy(new, old)
! StringCopy(new, old, length)
! either copies the array beginning at <old> to <new>, to a maximum of
! <length> characters, if specified
!
! StringDictCompare(array, dictentry)
! for comparing a string array with a dictionary entry; return values are
! as for StringCompare
!
! StringEqual(array1, array2)
! returns true if the two strings are identical
!
! x = StringLength(array)
! returns the number of characters in string <array>
!
! StringPrint(array)
! StringPrint(array, start, end)
! either prints the string stored in <array>, beginning and ending with
! <start> and <end>, if specified

#ifclear NO_STRING_ARRAYS

#ifclear _TEMP_STRING_DEFINED
array _temp_string[256]                 ! maximum string length is 255 char.
#set _TEMP_STRING_DEFINED
#endif

routine StringCompare(a, b)
{
	local i, alen

	alen = StringLength(a)

	for (i=0; i<alen; i=i+1)
	{
		if array a[i] > array b[i]:     return  1
		elseif array a[i] < array b[i]: return -1
	}
	if array b[i] ~= 0:  return -1
}

routine StringCopy(new, old, len)
{
	local i
	
	if len = 0
		len = StringLength(old)

	for (i=0; i<len; i=i+1)
		array new[i] = array old[i]
	array new[len] = 0
}

routine StringDictCompare(a, d)
{
	string(_temp_string, d, 255)
	return StringCompare(a, _temp_string)
}

routine StringEqual(a, b)
	{return not StringCompare(a, b)}

routine StringLength(arr)
{
	local i
	i = 0
	while array arr[i] ~= 0
		i = i + 1
	return i
}

routine StringPrint(a, start, end)
{
	local i

	if end = 0
		end = StringLength(a)
	for (i=start; i<end; i=i+1)
	{
		if array a[i] = 0
			break
		printchar array a[i]
	}
}

#endif  ! ifclear NO_STRING_ARRAYS

!----------------------------------------------------------------------------
! x = Menu(number, [width])
! 
! The Menu routine expects the array menuitem[] to hold a series of
! dictionary entries representing the list of possible choices, with the 
! title of the menu contained in menuitem[0].  It returns the number chosen, 
! or 0 if none is selected.
!
! The argument <number> gives the number of menu items, and the optional 
! <width> gives the width of the menu, in characters.  If no width is 
! specified, it defaults to the greater of 20 or the longest menu choice.

#ifclear NO_MENUS

#ifclear _TEMP_STRING_DEFINED
array _temp_string[256]
#set _TEMP_STRING_DEFINED
#endif

array menuitem[11]                      ! up to 10 items (plus title)
global MENU_TEXTCOLOR
global MENU_BGCOLOR
global MENU_SELECTCOLOR
global MENU_SELECTBGCOLOR

routine Menu(num, width)
{
	local a, i, column, olda
	
	Font(BOLD_OFF | ITALIC_OFF | UNDERLINE_OFF | PROP_OFF)
	
	if MENU_TEXTCOLOR=0 and MENU_BGCOLOR=0  ! must not have been set
		{MENU_TEXTCOLOR = TEXTCOLOR
		MENU_BGCOLOR = BGCOLOR
		MENU_SELECTCOLOR = SL_TEXTCOLOR
		MENU_SELECTBGCOLOR = SL_BGCOLOR}
	
	if width = 0:  width = 20
	for (i=1; i<=num; i=i+1)        ! determine appropriate width
#ifclear NO_AUX_MATH
		width = higher(width, string(_temp_string, menuitem[i]))
#endif
#ifset NO_AUX_MATH
		{a = string(_temp_string, menuitem[i])
		if a > width:  width = a}
#endif

	column = linelength/2 - width/2

	CenterTitle(menuitem[0])        ! print title of menu

	color MENU_TEXTCOLOR, MENU_BGCOLOR
	Message(&Menu, 1)               ! print key commands
	
	for (i=1; i<=num; i=i+1)        ! print menu choices
	{
		color MENU_TEXTCOLOR, MENU_BGCOLOR
		locate column, (3+i)
		print menuitem[i]; to (column+width)
	}
	color TEXTCOLOR, BGCOLOR

	a = 1
	while true                      ! continuous loop
	{
		if a ~= olda
		{
			if olda ~= 0
				{locate column, (3+olda)
				color MENU_TEXTCOLOR, MENU_BGCOLOR
				print menuitem[olda]; to (column+width)}
			color MENU_SELECTCOLOR, MENU_SELECTBGCOLOR
			locate column, (3+a)
			print menuitem[a]; to (column+width)
			color TEXTCOLOR, BGCOLOR
		}
		locate (column+width), (3+a)
		olda = a
		pause
		select word[0]
		case 'N', 'n', DOWN_ARROW, RIGHT_ARROW
		{
			a = a + 1
			if a > num:  a = 1
		}
		case 'P', 'p', UP_ARROW, LEFT_ARROW
		{
			a = a - 1
			if a = 0:  a = num
		}
		case 'Q', 'q', ESCAPE_KEY
		{
			window:  print to linelength
			cls
			Font(DEFAULT_FONT)
			return 0
		}
		case ENTER_KEY
		{
			window:  print to linelength
			cls
			Font(DEFAULT_FONT)
			return a
		}

		if word[0] >= '0' and word[0] <= '9'
		{
			a = word[0] - '0'
			if a = 0:  a = 10
			if a > num:  a = olda
		}
	}
}    

routine CenterTitle(a)
{
	local l

	l = string(_temp_string, a)
	Font(BOLD_OFF | ITALIC_OFF | UNDERLINE_OFF | PROP_OFF)
	window
	{
		color MENU_SELECTCOLOR, MENU_SELECTBGCOLOR
		print to (linelength/2 - l/2); a; to linelength
	}
	color TEXTCOLOR, BGCOLOR
	Font(DEFAULT_FONT)
	cls
	locate 1,1
}

#endif  ! ifclear NO_MENUS

!\
*****************************************************************************

VERB ROUTINES:  (Globals object and xobject are set up by the engine)

*****************************************************************************
\!

#ifclear NO_VERBS

!----------------------------------------------------------------------------
routine DoVague
{
	Message(&DoVague)       ! "Be a little more specific..."
	return false
}

!----------------------------------------------------------------------------
! FOR LOOKING AND EXAMINING:
!----------------------------------------------------------------------------
routine DoLookAround
{
	DescribePlace(location, true)
	return true
}

!----------------------------------------------------------------------------
routine DoLook
{
	local i, tempformat
	
	if not light_source
		Message(&DoLook, 1)     ! "It's too dark to see anything."
	else
	{
		if not object.long_desc
			! "Looks just like you'd expect..."
			Message(&DoLook, 2)
		
		if object is living, transparent, not quiet
		{
			for i in object
			{
				if i is not hidden
					break
			}
			if i and object ~= player
			{
				tempformat = FORMAT
				FORMAT = FORMAT | NOINDENT_F
				nest = 0
				print ""
				WhatsIn(object)
				FORMAT = tempformat
			}
		}
		
		run object.after
		return true
	}
}

!----------------------------------------------------------------------------
routine DoLookIn
{
	local i, tempformat
	
	if not CheckReach(object):  return false

	if not light_source
		Message(&DoLook, 1)     ! "It's too dark to see anything."
	else
	{
		if object is container and (object is openable and
			object is not open and object is not transparent):
			Message(&DoLookIn, 1)           ! "It's closed."
		else
		{
			object is not quiet

			tempformat = FORMAT
			FORMAT = FORMAT | NOINDENT_F
			nest = 0
			
			if WhatsIn(object) = 0
				Message(&DoLookIn, 2)   ! "It's empty."
			
			FORMAT = tempformat
		}
		run object.after
		return true
	}
}

!----------------------------------------------------------------------------
routine DoLookThrough
{
	if object is not static
		if not CheckReach(object)
			return false
	
	if object is transparent
	{
		if object is container or children(object)
			return Perform(&DoLookIn, object)
		else
			return Perform(&DoLook, object)
	}

#ifclear NO_OBJLIB
	elseif object.type = door
	{
		if object is not open
			Message(&DoLookIn, 1)   ! "It's closed."
		else
		{
			! "Through it you can see..."
			Message(&DoLookThrough, 1)

			if location = object.found_in #1
				print The(object.found_in #2); "."
			else
				print The(object.found_in #1); "."
		}
		return true
	}
#endif
	else
		Message(&DoLookThrough, 2)  ! "You can't see through that."
}

!----------------------------------------------------------------------------
routine DoLookUnder
{
	if not CheckReach(object):  return false

	Message(&DoLookUnder, 1)        ! "You don't find anything."
	return true
}

!----------------------------------------------------------------------------
! FOR WAITING AROUND:
!----------------------------------------------------------------------------
routine DoWait(count)                   ! count argument is from DoWaitUntil
{
	if object = 0
		count = 3
	elseif count = 0
		count = object
	
	Message(&DoWait)                ! "Time passes..."
	event_flag = 0
	count = count - 1
	while count
	{
		main
		if event_flag
			if not KeepWaiting
				return
		count = count - 1
	}
	event_flag = 0
	return true
}

!----------------------------------------------------------------------------
routine DoWaitforChar
{
	local count

	if object is not living
		{ParseError(6)
		return false}

	if object in location
	{
		Message(&DoWaitforChar, 1)      ! "They're right here..."
		return true
	}

	Message(&DoWait, 1)                     ! "Time passes..."
	event_flag = 0
	do
	{
		main
		if object in location
		{
			! character has arrived
			Message(&DoWaitforChar, 2)
			event_flag = 0
			return
		}
		if event_flag
			if not KeepWaiting
				return
		count = count + 1
	}
	while (STATUSTYPE=2 and count<60) or (STATUSTYPE~=2 and count<20)

	Message(&DoWaitforChar, 3)      ! character hasn't arrived yet

	event_flag = 0
}

!----------------------------------------------------------------------------
routine DoWaitUntil
{
	if object = counter
		{Message(&DoWaitUntil, 1)       ! "Wow.  Time flies."
		return}
	elseif object < counter and (STATUSTYPE ~= 2 or object > 720)
		{Message(&DoWaitUntil, 2)       ! "You're ahead of your time."
		return}
	else
	{     
		if object < counter
			object = object * 60
		
		DoWait(object - counter + 1)
		
		! "It is now (whatever time/turn)..."
		Message(&DoWaitUntil, 3)
	}
	event_flag = 0
}

!----------------------------------------------------------------------------
routine KeepWaiting                     ! used by DoWait... routines
{
	event_flag = 0
	Message(&KeepWaiting)           ! "Keep waiting?"
	GetInput
	return YesorNo
}

!----------------------------------------------------------------------------
! FOR TALKING TO CHARACTERS:
!----------------------------------------------------------------------------
routine DoTalk
{
	if word[2] = "to" and not xobject
	{
		if object is unfriendly
		{
			if not object.ignore_response
				Message(&Speakto, 4)    ! "X ignores you."
			speaking = 0
		}
		elseif object = player
		{
			Message(&Speakto, 1)  ! "Stop talking to yourself."
			return false
		}
		else
		{
			speaking = object
			Message(&Speakto, 2)            ! "X is listening."
#ifclear NO_SCRIPTS
			SkipScript(object)
#endif
		}
		return true
	}

	Message(&DoTalk, 1)     ! "Tell or ask about something specific..."
	return false
}

!----------------------------------------------------------------------------
routine DoAsk
{
	if xobject = 0
	{
		Message(&DoAsk, 1)      ! "Ask about something specific..."
		return false
	}

	speaking = object

	if object is unfriendly
	{
		if not object.ignore_response
			Message(&Speakto, 4)    ! "X ignores you."
		speaking = 0
	}
	elseif object = player
		{Message(&DoAsk, 2)             ! "Talking to yourself..."
		return false}
	elseif xobject = player
		Message(&DoAsk, 3)              ! asking about yourself
	elseif xobject = object
	{
		if not object.after
			Message(&DoAsk, 4)      ! asking about him/herself
	}
	else
	{
		if xobject in location and xobject is living
			
			! "Not while the other person is in the room..."
			Message(&DoAsk, 5)

		elseif not object.after
			
			! "Doesn't seem to know anything..."
			Message(&DoAsk, 6)

#ifclear NO_SCRIPTS
		SkipScript(object)
#endif
	}
	return true
}

!----------------------------------------------------------------------------
routine DoAskQuestion
{
	if speaking = 0
		{Message(&DoAskQuestion)        ! "Not talking to anybody..."
		return false}
	elseif xobject
		{ParseError(6)
		return false}
	
	return Perform(&DoAsk, speaking, object)
}

!----------------------------------------------------------------------------
routine DoTell
{
	if object = player
		Message(&DoAsk, 2)      ! "Talking to yourself..."
	
	if xobject = 0
		{Message(&DoTell, 1)    ! "Tell about something specific..."
		return false}

	speaking = object
	
	
	if object is unfriendly
	{
		if not object.ignore_response
			Message(&Speakto, 4)    ! "X ignores you."
		speaking = 0
	}
	else
	{
		if not object.after
			Message(&DoTell, 2)     ! "Not interested..."
#ifclear NO_SCRIPTS
		SkipScript(object)
#endif
	}
	return true
}

!----------------------------------------------------------------------------
routine DoListen
{
	if not object
		{Message(&DoListen, 1)  ! "Be a little more specific..."
		return false}
	elseif not object.after
		Message(&DoListen, 2)   ! "Not making any sound..."
	return true
}

!----------------------------------------------------------------------------
! FOR MOVING AROUND
!----------------------------------------------------------------------------
routine DoGo
{
	local wordnum, moveto, m
	local w2

	if obstacle
	{
		Message(&DoGo, 1)               ! "X stops you from going..."
		return true
	}
	elseif player not in location           ! i.e. a vehicle, etc.
	{
		if parent(player).before 
			return true
	}

	if object.type = direction
	{
		moveto = object
		jump FoundDirection
	}
	
	wordnum = 1                             ! various phrasings
	if words > 1 and word[2] ~= ""
		wordnum = 2
	w2 = word[2]
	if w2 = "to" or w2 = "through"
		wordnum = 3
	elseif (w2 = "in" or w2 = "inside") and words > 2
		wordnum = 3

	select word[wordnum]

#ifclear NO_OBJLIB
		case "north", "n":      moveto = n_obj
		case "south", "s":      moveto = s_obj
		case "east", "e":       moveto = e_obj
		case "west", "w":       moveto = w_obj
		case "northwest", "nw": moveto = nw_obj
		case "northeast", "ne": moveto = ne_obj
		case "southeast", "se": moveto = se_obj
		case "southwest", "sw": moveto = sw_obj
		case "up", "u":         moveto = u_obj
		case "down", "d":       moveto = d_obj
		case "in", "inside":    moveto = in_obj
		case "out", "outside":  moveto = out_obj
#endif
#ifset NO_OBJLIB
		case "north", "n":      m = n_to
		case "south", "s":      m = s_to
		case "east", "e":       m = e_to
		case "west", "w":       m = w_to
		case "northwest", "nw": m = nw_to
		case "northeast", "ne": m = ne_to
		case "southeast", "se": m = se_to
		case "southwest", "sw": m = sw_to
		case "up", "u":         m = u_to
		case "down", "d":       m = d_to
		case "in", "inside":    m = in_to
		case "out", "outside":  m = out_to
#endif

		case else
		{
			if not object           
				{ParseError(6)  ! doesn't make any sense
				return}

			if object is enterable
				return Perform(&DoEnter, object)

			moveto = object.door_to
			if not moveto
				{Message(&DoEnter, 2)  ! "You can't enter..."
				return}
			if moveto = 1
				return true
		}

:FoundDirection

#ifclear NO_OBJLIB
	if moveto.type = direction
	{
		if not object
		{
			object = moveto
			if object.before
				return true
		}
		else:  object = moveto
		moveto = location.(moveto.dir_to)
	}
#endif
#ifset NO_OBJLIB
	if m
	{
		object = m
		moveto = location.m
	}
#endif

	if moveto = false
	{
		if not location.cant_go
			Message(&DoGo, 2)       ! "You can't go that way."
		object = 0
		return false
	}
	
	elseif moveto = true                    ! already printed message
		{object = 0                     ! (moveto is never 1)
		return true}
	
	elseif player not in location           ! sitting on or in an obj.

		Message(&DoGo, 3)               ! "You'll have to get up..."
	else
	{
		m = verbroutine                 ! check room exiting
		verbroutine = &DoExit
		if location.before
			return true
		verbroutine = m

		MovePlayer(moveto)

		object = 0
		return true
	}
	object = 0
}

!----------------------------------------------------------------------------
! Note that DoEnter and DoExit expect the preposition (alias prep) property 
! to hold the equivalent of "in" and "out" for the enterable object in 
! question; if there is no preposition property, "in" and "out" are the
! defaults.

routine DoEnter
{
	if not object
	{
		Message(&DoEnter, 1)    ! "Be a little more specific..."
		return false
	}
	
	if &object.door_to
		return Perform(&DoGo, object)   ! routine
	elseif object.door_to
		return Perform(&DoGo, object)   ! object

	if object is not enterable
		Message(&DoEnter, 2)    ! "You can't enter that."
	elseif player in object
		Message(&DoEnter, 3)    ! already in it
	elseif player not in location
		Message(&DoGo, 3)       ! "You'll have to get up..."
	elseif object is openable, not open
		Message(&DoLookIn, 1)   ! "X is closed."
	else
	{
		move player to object
		if not object.after
			Message(&DoEnter, 4)    ! "You get in..."
		object is not quiet
		return true
	}
	return
}

!----------------------------------------------------------------------------
routine DoExit
{
	local p
	
	if object = nothing or object = location
	{
		if player in location
			{word[1] = "out"
			word[2] = ""
			return Perform(&DoGo)}
	}

	p = parent(player)
  
	if object and player not in object
		Message(&DoExit, 1)             ! "You aren't in that."
	elseif p is openable, not open
		Message(&DoLookIn, 1)           ! "X is closed."
	else
	{
		if object = nothing
			object = p
		move player to location
		if not object.after
			Message(&DoExit, 2)     ! "You get out.."
	}
	return true
}

!----------------------------------------------------------------------------
! FOR MANIPULATING OBJECTS:
!----------------------------------------------------------------------------
routine DoInventory
{
	local i, n, tempformat

	if word[2] = "tall"
		INVENTORY_MASK = INVENTORY_MASK | LIST_F
	elseif word[2] = "wide"
		INVENTORY_MASK = INVENTORY_MASK & ~LIST_F
	
	tempformat = FORMAT
	FORMAT = FORMAT | INVENTORY_F | GROUPPLURALS_F | NOINDENT_F
	FORMAT = FORMAT | INVENTORY_MASK
	nest = 0
	if not WhatsIn(player)
		Message(&DoInventory)   ! "You aren't carrying anything."
	FORMAT = tempformat
	
	return true
}

!----------------------------------------------------------------------------
routine DoClose
{
	if not CheckReach(object):  return false

	if object is not openable
	{
		Message(&DoClose, 1)            ! "You can't close that."
		return
	}
	elseif object is not open
		Message(&DoClose, 2)            ! "It's already closed."
	else
	{
		object is not open
		object is moved
		if not object.after
			Message(&DoClose, 3)    ! "Closed."

		if not FindLight(location)      ! in case the light source
						! has been concealed
			
			Message(&DoClose, 4)    ! "Everything goes dark."
	}
	return true
}

!----------------------------------------------------------------------------
routine DoOpen
{
	local tempformat

	if not CheckReach(object):  return false

	if object is not openable
	{
		Message(&DoOpen, 1)             ! "You can't open that."
		return
	}
	elseif object is open
		Message(&DoOpen, 2)             ! "It's already closed."
	elseif object is locked
		Message(&DoOpen, 3)             ! "It's locked."
	else
	{
		object is open
		object is moved
		if not object.after
		{
			Message(&DoOpen, 4)     ! "Opened."

			FindLight(location)     ! in case the light source
						! has been revealed
			if children(object) and object is not quiet
			{
				print ""
				tempformat = FORMAT
				FORMAT = FORMAT | NOINDENT_F
				WhatsIn(object)
				FORMAT = tempformat
			}
		}
	}
	return true
}

!----------------------------------------------------------------------------
routine DoMove
{
	if not CheckReach(object):  return false

	Message(&DoMove)                ! "You can't move that."
	return true
}

!----------------------------------------------------------------------------
routine DoGet
{
	local p
	
	if object in player
		Message(&DoGet, 1)      ! "You already have that."
	elseif object = player
		{Message(&DoGet, 2)     ! player trying to get player
		return false}
	elseif object is living and object is static
		{Message(&DoGet, 3)     ! player trying to get character
		return false}
	elseif parent(object) is living and parent(object) is unfriendly
		Message(&DoGet, 4)      ! "X doesn't want to give it to you."
	elseif parent(object) is openable, not open and
		parent(object) is container:
		{Message(&DoGet, 5)     ! "X is closed."
		return false}
	elseif Contains(object, player)
		{Message(&DoGet, 6)     ! "Not while you're in/on it..."
		return false}
	else
	{
		if not CheckReach(object)
			return false
		elseif object is static
			Message(&DoGet, 7)      ! "You can't take that."
		elseif not parent(object).before
		{
			xobject = parent(object)

			if object not in location
				{CalculateHolding(xobject)
				p = xobject}

			if Acquire(player, object)
			{
				! if object was in something
				if p
					p.holding = p.holding - object.size

				object is not hidden
				
				if not object.after
				{
					if xobject.after = false
						! "Taken."
						Message(&DoGet, 8)
				}
			}
			else
				! "You're carrying too much to take that."
				Message(&DoGet, 9)
		}
	}
	return true
}

!----------------------------------------------------------------------------
routine DoDrop
{
	if object is clothing and object is worn
		Message(&DoDrop, 1)     ! "You'll have to take it off first."
	
	! For the following, xobject is true only 
	! when called by DoPutonGround:
	
	elseif player not in location and (parent(player) is container or
		parent(player) is platform) and not xobject:

		Perform(&DoPutIn, object, parent(player))
	else
	{
		move object to location
		object is moved
		player.holding = player.holding - object.size
		if not object.after
			Message(&DoDrop, 2)     ! "Dropped."
	}
	xobject = 0
	return true
}

routine DoPutonGround                   ! to override vehicles, etc.
{
	if xobject and player not in xobject
	{
		Message(&DoPutonGround, 1)      ! "You aren't in X."
		return false
	}
	xobject = 1
	return Perform(&DoDrop, object, xobject)
}

!----------------------------------------------------------------------------
routine DoPutIn
{
	if not xobject
		Message(&DoPutIn, 1)    ! "Put it in what?"
	elseif object is clothing and object is worn
		Message(&DoDrop, 1)     ! "Have to take it off first..."
	elseif xobject is container, openable, not open
		Message(&DoPutIn, 2)    ! "It's closed."
	elseif object = xobject
		Message(&DoPutIn, 3)    ! putting something in itself
	elseif xobject is not container and xobject is not platform
		Message(&DoPutIn, 3)    ! "Can't do that."
	elseif Contains(object, xobject)
		Message(&DoPutIn, 4)    ! putting a parent in its child
	elseif CheckReach(object) 
	{
		if CheckReach(xobject)
		{
			if Acquire(xobject,object)
			{
				player.holding = player.holding - object.size
				if not xobject.after
					! "You put X in/on Y."
					Message(&DoPutIn, 5)
			}
			else
				! "There's no room..."
				Message(&DoPutIn, 6)
		}
	}
	return true
}

!----------------------------------------------------------------------------
routine DoEmpty
{
	local a, b, obj, xobj
	
	CalculateHolding(object)
	
	if object is container, openable, not open 
		{Message(&DoEmpty, 1)           ! "It's closed."
		return true}
	if not children(object)
		{Message(&DoEmpty, 2)           ! "It's already empty."
		return true}

	while child(object)
	{
		print child(object).name; ":  ";
		
		if child(object) is static
			Message(&DoEmpty, 3)    ! "You can't move that."
		else                
		{
			a = player.holding
			b = child(object)
			obj = object
			xobj = xobject

			if player not in location and
				(parent(player) is platform or
					parent(player) is container) and
				not xobject:
				
				Perform(&DoPutIn, b, parent(player))
			else
				Perform(&DoDrop, b)

			object = obj
			xobject = xobj
			player.holding = a
			if b not in object
				object.holding = object.holding - b.size
		}
	}

	run object.after
	return true
}

routine DoEmptyGround                   ! to override vehicles, etc.
{
	xobject = 1
	return Perform(&DoEmpty, object, xobject)
}

!----------------------------------------------------------------------------
routine DoGive
{
	local a
	
	if not xobject
		{Message(&DoGive, 1)    ! "Be more specific..."
		return false}

	if object not in player
	{
		if not FindObject(object, location)
			ParseError(11, object)
		Message(&DoGive, 5)     ! "(taking it first)"
		Perform(&DoGet, object)
		if object not in player
			return false
		main                    ! counts as a turn
		a = true
	}
	
	if object is clothing, worn
		{Message(&DoDrop, 1)    ! "Have to take it off first..."
		return false}

	if xobject = player
		{Message(&DoGive, 2)    ! player giving something to player
		return false}
	
	if a:  print ""
	
	if not object.after
	{
		if not xobject.after
		{
			if xobject is not living
				! "Your kind gesture goes unnoticed."
				Message(&DoGive, 3)
			else
				! "X politely refuses."
				Message(&DoGive, 4)
		}
	}
	return true
}

!----------------------------------------------------------------------------
routine DoShow
{
	if not xobject
		{Message(&DoShow, 1)    ! "Be more specific..."
		return false}
	
	if not object.after
	{
		if not xobject.after
		{
			if xobject is not living
				! showing it to something inanimate
				Message(&DoShow, 2)
			else
				! character ignores it
				Message(&DoShow, 3)
		}
	}
	return true
}

!----------------------------------------------------------------------------
routine DoWear
{
	local a
	
	if object is not clothing
		{Message(&DoWear, 1)    ! "You can't wear that."
		return false}

	if object not in player
	{
		if not FindObject(object, location)
			ParseError(11, object)
		Message(&DoGive, 5)     ! "(taking it first)"
		Perform(&DoGet, object)
		if object not in player
			return false
		main                    ! counts as a turn
		a = true
	}

	if object is worn
		Message(&DoWear, 2)     ! "Already wearing that..."
	else
	{
		if a:  print ""
		object is worn
		if not object.after
			Message(&DoWear, 3)     ! "You put it on."
	}
	return true
}

!----------------------------------------------------------------------------
routine DoTakeOff
{
	if object is not clothing
		{Message(&DoTakeOff, 1)         ! "Can't do that..."
		return false}

	if object is not worn
		Message(&DoTakeOff, 2)          ! "You're not wearing that."
	else
	{
		object is not worn
		if not object.after
			Message(&DoTakeOff, 3)  ! "You take it off."
	}
	return true
}

!----------------------------------------------------------------------------
routine DoSwitchOn
{
	if not CheckReach(object):  return false

	if object is switchedon
		Message(&DoSwitchOn, 1)         ! "It's already on."
	else
	{
		object is switchedon
		if not object.after
			Message(&DoSwitchOn, 2)         ! "Switched on."
	}
	return true
}

!----------------------------------------------------------------------------
routine DoSwitchOff
{
	if not CheckReach(object):  return false

	if object is not switchedon
		Message(&DoSwitchOff, 1)        ! "It's already off."
	else
	{
		object is not switchedon
		if not object.after
			Message(&DoSwitchOff, 2)        ! "Switched off."
	}
	return true
}

!----------------------------------------------------------------------------
routine DoUnlock
{
	if not CheckReach(object):  return false

	if xobject ~= 0
	{
		if object.key_object ~= xobject
			{Message(&DoUnlock, 1)  ! "Doesn't seem to work..."
			return true}
	}
	elseif object.key_object and object.key_object not in player
	{
		Message(&DoUnlock, 2)           ! no key that fits
		return true
	}

	if object is not locked
		Message(&DoUnlock, 3)           ! already unlocked
	else
	{
		object is not locked
		if not object.after
		{
			if not xobject.after
				Message(&DoUnlock, 4)   ! "Unlocked."
		}
	}
	return true
}

!----------------------------------------------------------------------------
routine DoLock
{
	if not CheckReach(object):  return false

	if xobject ~= 0
	{
		if object.key_object ~= xobject
			{Message(&DoUnlock, 1)  ! "Doesn't seem to work..."
			return true}
	}
	elseif object.key_object and object.key_object not in player
	{
		Message(&DoUnlock, 2)           ! no key that fits
		return true
	}

	if object is locked
		Message(&DoLock, 1)             ! already locked
	elseif object is open
		Message(&DoLock, 2)             ! "Have to close it first..."
	else
	{
		object is locked
		if not object.after
		{
			if not xobject.after
				Message(&DoLock, 3)     ! "Locked."
		}
	}
	return true
}

!----------------------------------------------------------------------------
routine DoEat
{
	if not object.after
		Message(&DoEat)         ! "You can't eat that."
}

!----------------------------------------------------------------------------
routine DoDrink
{
	if not object.after
		Message(&DoDrink)       ! "You can't drink that."
}

!----------------------------------------------------------------------------
routine DoHit
{
	if not object.after
		Message(&DoHit)         ! "Doesn't accomplish much..."
}

#endif  ! ifclear NO_VERBS

!----------------------------------------------------------------------------
! NON-ACTION VERBS:
!----------------------------------------------------------------------------

#ifclear NO_XVERBS

routine DoHello
	{Message(&DoHello)}

routine DoBrief
	{Message(&DoBrief)
	verbosity = 0}

routine DoSuperbrief
	{Message(&DoSuperBrief)
	verbosity = 1}

routine DoVerbose
	{Message(&DoVerbose)
	verbosity = 2}

routine DoDisplay
{
	if word[1] = "tall" or word[2] = "tall"
	{
		Message(&DoDisplay, 1)          ! "Tall listings."
		FORMAT = FORMAT | LIST_F
	}
	elseif word[1] = "wide" or word[2] = "wide"
	{
		Message(&DoDisplay, 2)          ! "Wide listings."
		FORMAT = FORMAT & ~LIST_F
	}
	else
		Message(&DoDisplay, 3)          ! instructions
}

!----------------------------------------------------------------------------
routine DoSave
{
	if save
		Message(&DoSave, 1)             ! "Saved."
	else:  Message(&DoSave, 2)              ! "Unable to save."
}

!----------------------------------------------------------------------------
routine DoRestore
{
	if restore
		{Message(&DoRestore, 1)         ! "Restored."
		PrintStatusline
		DescribePlace(location, true)}
	else:  Message(&DoRestore, 2)           ! "Unable to restore."
}

!----------------------------------------------------------------------------
routine DoQuit
{
	PrintScore
	Message(&DoQuit)                        ! "Are you sure?"
	GetInput
	if YesorNo = true {quit}
}

!----------------------------------------------------------------------------
routine DoRestart
{
	Message(&DoRestart, 1)                  ! "Are you sure?"
	GetInput
	if YesorNo = true 
	{
		if restart
			PrintStatusline
		else
			Message(&DoRestart, 2)  ! "Unable to restart."
	}
}

!----------------------------------------------------------------------------
routine DoScriptOnOff
{
	if word[2] = "on" or words = 1
	{
		if not scripton
			Message(&DoScriptOnOff, 1)      ! "Unable to begin..."
		else
			Message(&DoScriptOnOff, 2)      ! "Transcription on."
	}
	elseif word[2] = "off"
	{
		if not scriptoff
			Message(&DoScriptOnOff, 3)      ! "Unable to end..."
		else
			Message(&DoScriptOnOff, 4)      ! "Transcription off."
	}
}

!----------------------------------------------------------------------------
#ifclear NO_RECORDING
routine DoRecordOnOff
{
	if word[1] = "playback"
	{
		if not playback
			Message(&DoRecordOnOff, 1)  ! "Unable to begin..."
		else
			Message(&DoRecordOnOff, 2)  ! "Playback beginning..."
	}
	elseif word[2] = "on" or words = 1
	{
		if not recordon
			Message(&DoRecordOnOff, 3)  ! "Unable to begin..."
		else
			Message(&DoRecordOnOff, 4)  ! "Recording on."
	}
	elseif word[2] = "off"
	{
		if not recordoff
			Message(&DoRecordOnOff, 5)  ! "Unable to end..."
		else
			Message(&DoRecordOnOff, 6)  ! "Recording off."
	}
}
#endif

!----------------------------------------------------------------------------
routine DoScore
{
	if STATUSTYPE ~= 1
		Message(&DoScore)               ! no scorekeeping
	else
		PrintScore
}

!----------------------------------------------------------------------------
routine DoUndo
{
	if not UNDO_OFF
	{
		if undo
			{PrintStatusline
			DescribePlace(location)}
		else
			Message(&DoUndo)
	}
	else
		Message(&DoUndo)
}

#endif  ! ifclear NO_XVERBS

!\
*****************************************************************************

FUSE AND DAEMON CLASSES AND ROUTINES

*****************************************************************************
\!

#ifclear NO_FUSES

attribute active alias known

property timer alias n_to               ! for fuses only
property tick alias ne_to               !

class fuse "fuse"
{
	type fuse
	size 0
	timer 0
	in_scope 0
	tick 
	{
		self.timer = self.timer - 1
		if self.timer < 0
			self.timer = 0
		
#ifset DEBUG
		if debug_flags & D_FUSES
		{        
			print "[Running fuse "; number self; ":  timer = ";
			print number self.timer; "]"
		}
#endif

		if self.timer = 0
			Deactivate(self)
		return self.timer
	}
}

class daemon "daemon"
{
	type daemon
	size 0
	in_scope 0
}

routine Activate(a, set)                ! <set> is for fuses only
{
	a.in_scope = player
	a is active
	if a.type = fuse
		a.timer = set
	elseif a.type = daemon and set
		print "[WARNING:  Attempt to set timer property 
		on daemon (object "; number a; ").]"
	elseif a.type ~= daemon
		print "[WARNING:  Attempt to activate non-fuse/\
		daemon (object "; number a; ").]"
	
#ifset DEBUG      
	if debug_flags & D_FUSES
	{
		print "[Activating "; a.name; " "; number a;
		if a.type = fuse
			print " (timer = "; number a.timer; ")";
		print "]"
	}
#endif

}

routine Deactivate(a)
{
	remove a
	a.in_scope = 0
	a is not active
	
	if a.type ~= fuse and a.type ~= daemon
		print "[WARNING:  Attempt to deactivate non-fuse/\
		daemon (object "; number a; ").]"

#ifset DEBUG
	if debug_flags & D_FUSES
	{
		print "[Deactivating "; a.name; " "; number a; "]"
	}
#endif

}

#endif  ! ifclear NO_FUSES


!\
*****************************************************************************

CHARACTER SCRIPT ROUTINES

*****************************************************************************
\!

#ifclear NO_SCRIPTS

!----------------------------------------------------------------------------
! x = Script(character, number of steps)
! initializes space for the script, and returns its location in the
! setscript array; returns -1 if MAX_SCRIPTS is exceeded
!
! SYNTAX:  setscript[script(char, steps)] =  &CharRoutine_1, object_1 \
!                                            &CharRoutine_2, object_2 \
!                                            ...
!                                            (maximum of 32 steps)

routine Script(obj, steps)
{
	local o

	o = 0
	while scriptdata[o * 3] ~= obj and scriptdata[o * 3] ~= 0 and
		o < MAX_SCRIPTS:
		o = o + 1
	if o = MAX_SCRIPTS
		return -1 
	if scriptdata[o * 3] = 0
		{scriptdata[o * 3] = obj                ! the object
		number_scripts = number_scripts + 1}
	scriptdata[o * 3 + 1] = 0                       ! starting step
	scriptdata[o * 3 + 2] = steps                   ! total no. of steps
	return o * MAX_SCRIPTS * 2
}

routine FindScript(obj)
{
	local o

	o = 0
	while scriptdata[o * 3] ~= obj and o < MAX_SCRIPTS
		o = o + 1
	return o
}

#endif  ! ifclear NO_SCRIPTS

!----------------------------------------------------------------------------
! RunScripts
! runs all active character scripts via:  CharRoutine(character, object)

routine RunScripts
{

#ifclear NO_SCRIPTS

	local a, obj, step, total, routine, b
	local tempactor, tempverb, tempobject

	for (; a<number_scripts; a=a+1)
	{
		obj = scriptdata[a * 3]         ! this object/character
		step = scriptdata[a * 3 + 1]    ! current step
		total = scriptdata[a * 3 + 2]   ! total steps in script

		if obj and total < 0            ! if skipping this script
			scriptdata[a * 3 + 2] = scriptdata[a * 3 + 2] + 32767
		
		elseif obj and step < total and step >= 0
		{
			! action
			routine = setscript[a * MAX_SCRIPT_STEPS + step * 2]

			! object being acted upon
			b = setscript[a * MAX_SCRIPT_STEPS + step * 2 + 1]
	   
#ifset DEBUG                        
			if debug_flags & D_SCRIPTS
			{
				print "[Script for obj. "; 
				print number obj; " ("; obj.name; "), step ";
				print number (step + 1); ":  $"; \
				hex routine; ", obj. ";
				print number b; " ("; b.name; ")]"
			}
#endif
	   
			scriptdata[a * 3 + 1] = step + 1
			tempactor = actor
			tempverb = verbroutine
			tempobject = object
			actor = obj
			verbroutine = routine
			object = b
			if not parent(actor).before
			{
				if not actor.before
				{
					if not object.before
					{
						call routine(obj, b)
						run actor.after
					}
				}
			}
			if actor in location:  actor is known
			actor = tempactor
			verbroutine = tempverb
			object = tempobject
		}
		elseif step >= 0
		{
			scriptdata[a * 3] = 0   ! clear this object's script
			if a = number_scripts - 1
				number_scripts = number_scripts - 1
		}
	}

#endif  ! ifclear NO_SCRIPTS

}

#ifclear NO_SCRIPTS

!----------------------------------------------------------------------------
! CancelScript(char)
! immediately halts execution of the script for <char>
!
! PauseScript(char)
! suspends execution of the script for <char>
!
! ResumeScript(char)
! resumes execution of a paused script
!
! SkipScript(char)
! skips <char>'s script only for the next call to RunScripts

routine CancelScript(obj)
{
	local o

	o = FindScript(obj)
	if o = MAX_SCRIPTS
		return
	scriptdata[o * 3] = 0
	if o = number_scripts - 1
		number_scripts = number_scripts - 1

#ifset DEBUG                        
		if debug_flags & D_SCRIPTS
		{
			print "[Script for obj. "; 
			print number obj; " ("; obj.name; ") ";
			print "cancelled]"
		}
#endif

	return true
}

routine PauseScript(obj)
{
	local o

	o = FindScript(obj)
	if o = MAX_SCRIPTS
		return
	if scriptdata[o * 3 + 1] >= 0           ! current step
	{
		scriptdata[o * 3 + 1] = scriptdata[o * 3 + 1] - 32767

#ifset DEBUG                        
		if debug_flags & D_SCRIPTS
		{
			print "[Script for obj. "; 
			print number obj; " ("; obj.name; ") ";
			print "paused]"
		}
#endif

		return true
	}
}

routine ResumeScript(obj)
{
	local o

	o = FindScript(obj)
	if o = MAX_SCRIPTS
		return
	if scriptdata[o * 3 + 1] < 0            ! current step
	{
		scriptdata[o * 3 + 1] = scriptdata[o * 3 + 1] + 32767

#ifset DEBUG                        
		if debug_flags & D_SCRIPTS
		{
			print "[Script for obj. "; 
			print number obj; " ("; obj.name; ") ";
			print "resumed]"
		}
#endif

		return true
	}
}

routine SkipScript(obj)
{
	local o

	o = FindScript(obj)
	if o = MAX_SCRIPTS
		return
	if scriptdata[o * 3 + 2] >= 0           ! total number of steps
	{
		scriptdata[o * 3 + 2] = scriptdata[o * 3 + 2] - 32767

#ifset DEBUG                        
		if debug_flags & D_SCRIPTS
		{
			print "[Skipping script for obj. "; 
			print number obj; " ("; obj.name; ")]"
		}
#endif

		return true
	}
}


!----------------------------------------------------------------------------
! BASIC CHARACTER VERB ROUTINES:
!----------------------------------------------------------------------------
! LoopScript
! may be used in a script to repeatedly return to the starting step; the 
! usage is:  &LoopScript, 0

routine LoopScript(obj)
{        
	local o

	while scriptdata[o * 3] ~= obj and o < MAX_SCRIPTS
		o = o + 1
	if o = MAX_SCRIPTS
		return
	scriptdata[o * 3 + 1] = 0

#ifset DEBUG                        
	if debug_flags & D_SCRIPTS
	{
		print "[Looping script for obj. "; 
		print number obj; " ("; obj.name; ")]"
	}
#endif

}

!----------------------------------------------------------------------------
! CharWait
! Script usage: &CharWait, 0

routine CharWait(char)
{

#ifset DEBUG
	if debug_flags & D_SCRIPTS
		{print "["; CThe(char); IsorAre(char, true); " waiting in:  ";
		print capital parent(char).name; ".]"}
#endif

	return true
}

!----------------------------------------------------------------------------
! CharMove
! Script usage:  &CharMove, <direction object>

routine CharMove(char, dir)
{
	local newroom

#ifclear NO_OBJLIB

	general = 1                     ! for signalling a character move
					! to, for example, door.door_to
	
	newroom = parent(char).(dir.dir_to)

	if char in location and general = 1             ! door.door_to sets
							! general = 2 if it
							! prints a message
	{
		Message(&CharMove, 1, char, dir)
		event_flag = true
	}
	elseif char in location
		event_flag = true
	
	move char to newroom
	
#ifset DEBUG        
	if debug_flags & D_SCRIPTS
	{
		print "["; CThe(char); IsorAre(char, true); " now in:  ";
		print capital parent(char).name; ".]"
	}
#endif

	if char in location and general = 1
	{
		Message(&CharMove, 2, char, dir)
		event_flag = true
	}
	elseif char in location
		event_flag = true

	general = 0                     ! always reset it

#endif  ! ifclear NO_OBJLIB

	run parent(char).after
	
	return true
}

!----------------------------------------------------------------------------
! CharGet
! Script usage:  &CharGet, <object>

routine CharGet(char, obj)
{
	if FindObject(obj, parent(char)) = 1
	{
		if Acquire(char, obj)
			if char in location 
			{
				Message(&CharGet, 1, char, obj)
				event_flag = true
			}
			return true
	}
}
 
!----------------------------------------------------------------------------
! CharDrop
! Script usage:  &CharDrop, <object>

routine CharDrop(char, obj)
{
	move obj to parent(char)
	char.holding = char.holding - obj.size
	if char in location 
	{
		Message(&CharDrop, 1, char, obj)
		event_flag = true
	}
	return true
}

#endif  ! ifclear NO_SCRIPTS


!\
*****************************************************************************

LIBRARY MESSAGES

Most of the text printed by the library is generated by the Message routine.
To replace all of the default responses, REPLACE the Message routine.  To
replace one or more responses, REPLACE the NewMessages routine, and return
true for any replacement message that is provided; if NewMessages returns a
false value, Message prints the default response.

NOTE:  Other routines in HUGOLIB.H that print text independent of the
Message routine are:  PrintEndGame, PrintScore, ParseError, PrintStatusLine,
HoursMinutes, The, CThe, Art, CArt, IsorAre, MatchSubject, NumberWord,
DigitWord, DarkWarning, ObjectIs, and various debugging messages.

*****************************************************************************
\!

!----------------------------------------------------------------------------
! Message(&routine, number)
! prints message <number> for <routine>
!
! Message (&routine, number, var1, var2)
! where one or two variables--which may be objects or any other value--
! are used by message <number> for <routine>

routine Message(r, num, a, b)
{
	! Check first to see if the NewMessages routine provides a 
	! replacement message:
	if NewMessages(r, num, a, b):  return

	select r
	
	case &EndGame
	{
		select num
		case 1
		{
			print "\nThe game has ended.  Do you want to RESTART, 
				RESTORE a saved game, ";
#ifclear NO_UNDO
			if not UNDO_OFF         ! if not otherwise overridden
				print "UNDO your last turn, ";
#endif
			print "or QUIT? ";
		}
		case 2
		{
			print "Enter RESTART, RESTORE, ";
#ifclear NO_UNDO
			if not UNDO_OFF
				print "UNDO, "; 
#endif
			print "or QUIT: ";
		}
	}

	case &Parse
	{
		select num
		case 1:  print "You don't need to refer to that."
		case 2:  print "(Assuming you mean";
		case 3:  print ", respectively";
	}
	
	case &Speakto
	{
		if a = 0:  a = object   ! Speakto messages are sometimes
					! co-opted by verb routines
		select num
		case 1:  print "Stop talking to yourself, and get on with it."
		case 2:  print CThe(a); IsorAre(a, true); " listening."
		case 3:  print CThe(a); " nod"; MatchSubject(a); \
				" hello to you."
		case 4:  print CThe(a); " ignore"; MatchSubject(a); " you."
	}

	case &DescribePlace
	{
		select num
		case 1:  print "It's too dark to see anything."
		case 2:  print "There"; IsorAre(a, true); " "; Art(a); \
				" here."
	}

	case &WhatsIn
	{
		select num
		case 1
		{
			print "You are ";
			if list_count < a
				print "also ";
			print "carrying";
		}
		case 2
		{
			if FORMAT & USECHARNAMES_F
				CArt(a)
			else
				print capital a.pronoun;
			if list_count < b
				print " also";
			if a is plural
				print " have";
			else
				print " has";
		}
		case 3
		{
			print "Also ";
			if a.prep
				print a.prep; " ";
			elseif a is platform
				print "sitting on ";
			else
				print "inside ";
		}
		case 4
		{
			if a.prep
				print capital a.prep; " ";
			elseif a is platform
				print "Sitting on ";
			else
				print "Inside ";
		}
	}

	case &CheckReach
	{
		select num
		case 1
		{
			print "Except that "; The(parent(a)); 
			if parent(a) is plural:  " have ";
			else:  " has ";
			print The(a); "."
		}
		case 2
		{
			print "Except that "; The(parent(a));
			if parent(a) is plural:  " don't";
			else:  " doesn't";
			print " want to give you "; The(a); "."
		}
		case 3:  print "You can't reach "; The(a); " from "; \
				The(parent(player)); "."
	}
	
	case &YesorNo:  print "Please answer YES or NO: ";

#ifclear NO_MENUS
	case &Menu
	{
		print "[N]ext item"; to (linelength - 11); "[Q]uit menu"
		print "[P]revious item"; to (linelength - 17); 
		print "[Enter] to select"
	}
#endif

#ifclear NO_VERBS

	case &DoVague:  print "Be a little more specific about what you'd 
				like to "; word[1]; "."

	case &DoLook
	{
		select num
		case 1:  print "It's too dark to see anything."
		case 2:  print CThe(object); " look"; MatchSubject(object); \
				" just like you'd expect."
	}

	case &DoLookIn
	{
		select num
		case 1:  print CThe(object); IsorAre(object, true); " closed."
		case 2:  print CThe(object); IsorAre(object, true); " empty."
	}

	case &DoLookThrough
	{
		select num
		case 1:  print "Through "; Art(object); " you can see ";
		case 2:  print "You can't see through that."
	}

	case &DoLookUnder:  print "You don't find anything "; word[2]; " "; \
				The(object); "."

	case &DoWait:  "Time passes..."

	case &DoWaitforChar
	{
		select num
		case 1:  print CThe(object); IsorAre(object, true); " right 
			here.  Good detective work."
		case 2
		{
			if object is plural
				print CThe(object); " have";
			else
				print CThe(object); " has";
			print " arrived.  ";
			if STATUSTYPE = 2
				print "It is now "; HoursMinutes(counter);
			else
				print newline
		}
		case 3
		{
			print "You've been waiting ";
			select STATUSTYPE
				case 2
					print "an hour";
				case else
					print "for twenty turns";
			print ", and "; The(object); " still ";
			if object is plural
				print "haven't";
			else
				print "hasn't";
			print " arrived."
		}
	}

	case &DoWaitUntil
	{
		select num
		case 1:  print "Wow.  Time flies."
		case 2:  print "You're ahead of your time."
		case 3
		{
			select STATUSTYPE
			case 2: print "It is now "; HoursMinutes(counter)
			case else: print "It is now turn "; number object; "."
		}
	}

	case &KeepWaiting:  print "\nDo you want to keep waiting (YES or 
				NO)? ";

	case &DoTalk:  print "Try asking or telling someone about 
				something specific."

	case &DoAsk
	{
		select num
		case 1:  print "Try asking someone about something in 
				particular."
		case 2:  print "Talking to yourself isn't a big step 
				forward."
		case 3:  print "Hopefully you know as much as anyone."
		case 4
		{
			print CThe(object); " would probably rather 
				not talk about "; object.pronoun #2; 
			if object is plural
				print "selves."
			else:  print "self."
		}
		case 5
		{
			print CThe(object); " glance"; MatchSubject(object);
			print " toward "; The(xobject); ".  "; \
				capital object.pronoun; " would probably 
				rather not say anything with "; \
				The(xobject); " right here."
		}
		case 6
		{
			CThe(object)
			if object is plural
				print " don't";
			else
				print " doesn't";
			print " seem to know anything about "; \
			The(xobject); "."
		}
	}

	case &DoAskQuestion:  print "You're not talking to anybody."

	case &DoTell
	{
		select num
		case 1:  print "Try telling someone about something in 
				particular."
		case 2:  print CThe(object); IsorAre(object, true); " not 
			particularly interested in "; The(xobject); "."
	}

	case &DoListen
	{
		select num
		case 1:  print "Be a little more specific about exactly what 
				you'd like to listen to."
		case 2:  print CThe(object); IsorAre(object, true); " not 
				making any sound."
	}

	case &DoGo
	{
		select num
		case 1:  print CThe(obstacle); " stop"; \
			MatchSubject(obstacle); " you from going anywhere."
		case 2:  print "You can't go that way."
		case 3
		{
			print "You'll have to get ";
			if parent(player).prep #2
				print parent(player).prep #2; " ";
			else
				print "out ";
			print "of "; The(parent(player)); " first."
		}
	}

	case &DoEnter
	{
		select num
		case 1:  print "You'll have to be a little more specific 
			about where you'd like to "; word[1]; "."
		case 2:  print "You can't enter "; The(object); "."
		case 3:  print "A bit redundant, don't you think?"
		case 4
		{
			print "You get ";
			if object.prep
				print object.prep;
			else
				print "into";
			print " "; The(object); "."
		}
	}

	case &DoExit
	{
		select num
		case 1
		{
			print "You aren't ";
			if object.prep
				print object.prep;
			else
				print "in"; 
			print " "; The(object); "."
		}
		case 2
		{
			print "You get ";
			if object.prep #2 
				print object.prep #2;
			else
				print "out";
			print " of "; The(object); "."
		}
	}

	case &DoInventory:  print "You aren't carrying anything."

	case &DoClose
	{
		select num
		case 1:  print "You can't close "; The(object); "."
		case 2:  print capital object.pronoun; IsorAre(object); \
				" already closed."
		case 3:  print "Closed."
		case 4:  print "\nEverything goes dark."

	}

	case &DoOpen
	{
		select num
		case 1:  print "You can't open "; The(object); "."
		case 2:  print capital object.pronoun; IsorAre(object); \
				" already open."
		case 3:  print CThe(object); IsorAre(object, true); " locked."
		case 4:  print "Opened."
	}

	case &DoMove:  print "You can't move "; The(object); "."

	case &DoGet
	{
		select num
		case 1:  print "You already have that."
		case 2:  print "This is not progress you are making."
		case 3:  print CThe(object); " probably wouldn't be too big 
				on that idea."
		case 4
		{
			print CThe(parent(object)); 
			if parent(object) is plural
				print " don't";
			else
				print " doesn't";
			print " want to give "; The(object); " to you."
		}
		case 5:  print CThe(parent(object)); \
			IsOrAre(parent(object), true); " closed."
		case 6
		{
			print "You can't take "; The(object); " while 
				you're ";
			if object.prep:  print object.prep
			elseif object is platform:  print "in"
			else:  print "on"
			if object is plural:  print "them."
			else:  print "it."
		}
		case 7:  print "You can't take that."
		case 8:  print "Taken."
		case 9:  print "You're carrying too much to take that."
	}

	case &DoDrop
	{
		select num
		case 1:  print "You'll have to take "; The(object); " off 
				first."
		case 2:  print "Dropped."
	}

	case &DoPutonGround
	{
		print "You aren't ";
		if xobject.prep
			print xobject.prep;
		else
			print "in";
		print " "; The(xobject); "."
	}

	case &DoPutIn
	{
		select num
		case 1:  print "You'll have to be a little more specific 
				about exactly with what you'd like to do 
				that."
		case 2:  print CThe(xobject); IsorAre(xobject, true); \
				" closed."
		case 3:  print "You can't do that."
		case 4:  print "Trying to bend the laws of physics, are we?"
		case 5
		{
			print "You put "; The(object);
			if xobject.prep
				print " "; xobject.prep; " ";
			elseif xobject is platform
				print " on ";
			else
				print " in ";
			print The(xobject); "."
		}
		case 6
		{
			print "There's no room ";
			if xobject.prep
				print xobject.prep; " ";
			elseif xobject is platform
				print "on ";
			else
				print "in ";
			print The(xobject); "."
		}
	}

	case &DoEmpty
	{
		select num
		case 1
		{
			print CThe(object); " "; IsorAre(object, true); \
				" closed."
		}
		case 2:  print CThe(object); " "; IsorAre(object, true); \
				" already empty."
		case 3:  print "You can't move that."
	}

	case &DoGive
	{
		select num
		case 1:  print "Try giving something to someone in 
				particular."
		case 2:  print "Not quite sure what you hope to accomplish 
				with that."
		case 3:  print "Your kind gesture goes unnoticed by "; \
				The(xobject); "."
		case 4
		{
			print CThe(xobject); 
			if xobject is not unfriendly
				print " politely"; 
			print " refuse"; MatchSubject(xobject); "."
		}
		case 5:  print "(taking "; The(object); " first)"
	}

	case &DoShow
	{
		select num
		case 1:  print "Try showing something to someone in 
				particular."
		case 2:  print "Showing "; Art(object); "to "; The(xobject); \
				" doesn't accomplish a whole lot."
		case 3:  print CThe(xobject); " ignore"; \
				MatchSubject(xobject); " "; The(object); "."
	}

	case &DoWear
	{
		select num
		case 1:  print "You can't wear "; The(object); "."
		case 2:  print "You're already wearing that."
		case 3:  print "You put on "; The(object); "."
	}

	case &DoTakeOff
	{
		select num
		case 1:  print "You're not wearing that."
		case 2:  print "You can't do that with "; The(object); "."
		case 3:  print "You take off "; The(object); "."
	}

	case &DoSwitchOn
	{
		select num
		case 1:  print capital object.pronoun; IsorAre(object); \
				" already turned on."
		case 2:  print "Switched on."
	}

	case &DoSwitchOff
	{
		select num
		case 1:  print capital object.pronoun; IsorAre(object); \
				" already turned off."
		case 2:  print "Switched off."
	}

	case &DoUnlock
	{
		select num
		case 1:  print "That doesn't seem to do the trick."
		case 2:  print "You're not holding any key that fits."
		case 3:  print capital object.pronoun; IsorAre(object); \
				" already unlocked."
		case 4
		{
			if not xobject and object.key_object
				print "(with "; The(object.key_object); ")"
			print "Unlocked."
		}
	}

	case &DoLock
	{
		select num
		case 1:  print capital object.pronoun; IsorAre(object); \
				" already locked."
		case 2:  print "You'll have to close "; object.pronoun; \
				" first."
		case 3
		{
			if not xobject and object.key_object
				print "(with "; The(object.key_object); ")"
			print "Locked."
		}
	}

	case &DoEat:  print "You can't eat "; The(object); "."

	case &DoDrink:  print "You can't drink "; The(object); "."

	case &DoHit:  print "Venting your frustrations on "; The(object); \
			" won't accomplish much."

#endif  ! ifclear NO_VERBS

#ifclear NO_XVERBS

	case &DoHello:  print "And to you."

	case &DoBrief:  print "Brief descriptions."
	case &DoSuperBrief:  print "Superbrief descriptions."
	case &DoVerbose:  print "Verbose descriptions."

	case &DoDisplay
	{
		select num
		case 1:  print "Tall listings."
		case 2:  print "Wide listings."
		case 3:  print "Type \"display tall\" or \"display wide\" to 
				alter the way objects are listed."
	}

	case &DoSave
	{
		select num
		case 1:  print "Saved."
		case 2:  print "Unable to save."
	}

	case &DoRestore
	{
		select num
		case 1:  print "Restored."
		case 2:  print "Unable to restore."
	}

	case &DoQuit:  print "Are you sure you want to quit (YES or NO)? ";

	case &DoRestart
	{
		select num
		case 1:  print "Are you sure you want to restart (YES or 
				NO)? ";
		case 2:  print "Unable to restart."
	}

	case &DoScriptOnOff
	{
		select num
		case 1:  print "Unable to begin transcription."
		case 2:  print "Transcription on."
		case 3:  print "Unable to end transcription."
		case 4:  print "Transcription off."
	}

#ifclear NO_RECORDING
	case &DoRecordOnOff
	{
		select num
		case 1:  print "Unable to begin command playback."
		case 2:  print "Command playback beginning."
		case 3:  print "Unable to begin command recording."
		case 4:  print "Command recording on."
		case 5:  print "Unable to end command recording."
		case 6:  print "Command recording off."
	}
#endif

	case &DoScore:  print "Nobody's keeping score."

	case &DoUndo:  print "Unable to undo."

#endif  ! ifclear NO_XVERBS

#ifclear NO_SCRIPTS
#ifclear NO_OBJLIB
	case &CharMove
	{
		select num
		case 1
		{
			print "\n"; CThe(a); " head"; MatchSubject(a); " ";
			if b = u_obj or b = d_obj
				print b.name; "ward."
			else
			{
				print "off to the ";
				print b.name; "."
			}
		}
		case 2
		{
			print "\n"; CThe(a); " arrive"; MatchSubject(a); \ 
				" from ";
			if b ~= u_obj and b ~= d_obj
				print "the "; (b.dir_from).name; "."
			elseif b = u_obj
				print "below."
			else
				print "above."
		}
	}
#endif  ! ifclear NO_OBJLIB

	case &CharGet:  print "\n"; CThe(a); " pick"; MatchSubject(a); \
			" up "; The(b); "."

	case &CharDrop:  print "\n"; CThe(a); " put"; MatchSubject(a); \
			" down "; The(b); "."
#endif  ! ifclear NO_SCRIPTS
}

routine NewMessages(r, num, a, b)       ! The NewMessages routine may be
{                                       ! REPLACED, and should return true
	return false                    ! if a replacement message <num>
}                                       ! exists for routine <r>


#set _COMPILING_HUGOLIB

!----------------------------------------------------------------------------
! Include object library unless otherwise specified

#ifclear NO_OBJLIB
#include "objlib.h"
#endif

!----------------------------------------------------------------------------
! Include verb stub routines if specified

#ifset VERBSTUBS
#include "verbstub.h"
#endif

!----------------------------------------------------------------------------
! Include debugging routines if specified

#ifset DEBUG
#include "hugofix.h"
#endif

#clear _COMPILING_HUGOLIB
#set _HUGOLIB_DEFINED

!----------------------------------------------------------------------------
! NOTE:  In addition to the flags VERBSTUBS and DEBUG which are used to 
! include additional library files, a number of compiler flags can be set 
! to exclude portions of HUGOLIB.H.  These are:  NO_AUX_MATH, NO_FONTS,
! NO_FUSES, NO_MENUS, NO_OBJLIB, NO_RECORDING, NO_SCRIPTS, NO_STRING_ARRAYS, 
! NO_VERBS, and NO_XVERBS.
!----------------------------------------------------------------------------

