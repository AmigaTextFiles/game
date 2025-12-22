!----------------------------------------------------------------------------
!
!            Verb Stub Routines v2.3.2 by Kent Tessman (c) 1995-1997
!                       for use with Hugo Compiler v2.3
!
!----------------------------------------------------------------------------
!
! These routines provide default responses only; in most cases this amounts
! to a more colorful variation on "Try something else."  Any more meaningful
! response must be incorporated into the before property routines of the
! objects involved.  HUGOLIB.H includes this file if the VERBSTUBS flag
! is set.
!
!----------------------------------------------------------------------------

#version 2.3

#ifclear _COMPILING_HUGOLIB
#message warning "Verb stub routines not #included; #set VERBSTUBS instead"
#endif

#ifset _COMPILING_HUGOLIB

routine DoYes
	{"That was a rhetorical question.  (Although you sound rather
	positive.)"}

routine DoNo
	{"That was a rhetorical question.  (Although you sound rather
	negative.)"}

routine DoSorry
	{"Just don't let it happen again."}

routine DoUse
	{"Be a little more specific about what you'd like to do with ";
	print The(object); "."}

routine DoSmell
	{"You don't smell anything unusual."
	return true}

routine DoJump
	{"You jump up and down, accomplishing little."
	return true}

routine DoWaveHands
	{"You wave.  Nothing happens."
	return true}

routine DoWave
	{"You wave ";
	The(object)
	".  Nothing happens."
	return true}

routine DoThrowAt
{
	if not xobject
		{"You'll have to be a little more specific about what 
		you'd like to throw ";
		print The(object); " at."}
	elseif xobject is not living
		"What exactly are you hoping for?"
	else
		{"You ultimately decide that throwing ";
		print The(object); " at "; The(xobject);
		" isn't such a great idea."}
	return true
}

routine DoClimb
{
	if object
		{"You can't climb ";
		print The(object); "."}
	else:  "Not here; not now."
	return true
}

routine DoSleep
	{"Not now--there's work to be done."}

routine DoPush
	{"Pushing ";
	The(object)
	" doesn't get you anywhere."
	return true}

routine DoPull
	{"Pulling ";
	The(object)
	" doesn't get you anywhere."
	return true}

routine DoKiss
{
	if object is not living
		"You need to get out more."
	else
		{CThe(object)
		" doesn't seem to share your affection."
		return true}
}

routine DoSwim
	{"Not here, you won't."}

routine DoWake
	{"You're already awake, like it or not."}

routine DoWakeCharacter
	{"That's probably not necessary."}

routine DoTouch
	{"Fiddling with ";
	The(object)
	" probably isn't the best use of your time at the moment."}

routine DoTie
	{"Trying to tie ";
	The(object)
	" doesn't get you anywhere."}

routine DoUntie
	{"Trying to untie ";
	The(object)
	" doesn't get you anywhere."}

routine DoBurn
	{"You didn't learn anything as a child, did you?  Don't play 
	with fire.  And stay away from my house."}

routine DoCut
	{"A destructive and somewhat less than completely useful 
	course of action."}

routine DoDig
	{"That won't accomplish anything."}

routine DoYell
	{"You let out a hearty bellow.  Nothing else happens."
	return true}

routine DoSearch
	{"You don't find anything."
	return true}

routine DoHelp
	{"Unfortunately, 'twould seem you're on your own."}        

routine DoHelpChar
	{print CThe(object); IsorAre(object, true); 
	" not in need of your help at the moment."}

#endif  ! ifset _COMPILING_HUGOLIB
