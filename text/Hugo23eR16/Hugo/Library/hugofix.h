!----------------------------------------------------------------------------
!
!       HUGOFIX Debugging Library v2.3.2 by Kent Tessman (c) 1995-1997
!                     for use with Hugo Compiler v2.3
!
!----------------------------------------------------------------------------
!
!    NOTE:  These routines and the corresponding grammar table are
!           automatically included by HUGOLIB.H and GRAMMAR.G if the
!           DEBUG compiler flag is set.
!
!----------------------------------------------------------------------------

#version 2.3

#ifclear _COMPILING_HUGOLIB
#message warning "HUGOFIX.H not #included; #set DEBUG instead"
#endif

#ifset _COMPILING_HUGOLIB

! BITMASKS FOR debug_flags:

global debug_flags

enumerate step *2
{
	D_FUSES = 1             ! fuse/daemon monitoring
	D_OBJNUM                ! object numbers
	D_PARSE                 ! parse monitoring
	D_SCRIPTS               ! script monitoring
}

routine DoHugoFix
{
	local i, n, place

	select word[1]
	case "$", "$?"
	{
		"HUGOFIX DEBUGGING COMMANDS:\n\
		\_    $?  - Display this help menu\n"

		"Monitoring:\n\
		\_    $on - Toggle object numbers\n"

	#ifclear NO_SCRIPTS
	       "\_    $sc - Script monitor on/off"
	#endif

	#ifclear NO_FUSES
	       "\_    $fd - Fuse/daemon monitor on/off"
	#endif

	       "\_    $pm - Parser monitoring on/off\n"

	       "Object movement:\n\
		\_    $mo <obj.> to <obj.> - Move object to new parent\n\
		\_    $mp <obj.>           - Move player object to new 
			parent\n"

		"Object testing:\n\
		\_    $fo <obj.>   - Find object\n\
		\_    $na <obj. #> - Print name of object number <obj.>\n\
		\_    $nu <obj.>   - Print number of object <obj.>\n"
		
		"Other utilities:"

	#ifclear NO_FUSES
	       "\_    $ac <obj.> [timer] - Activate fuse (with timer) or 
			daemon\n\
		\_    $de <obj.>         - Deactivate fuse or daemon"
	#endif

	#ifclear NO_OBJLIB
	       "\_    $di [obj.] - Audit directions (for room <obj.>)"
	#endif

	       "\_    $ot [obj.] - Print object tree (beginning with 
			<obj.>)\n\
		\_    $wo <val.> - Print dictionary word entry <val.>"
	}

	case "$wo"
	{
		print "\""; object; "\""
	}

#ifclear NO_SCRIPTS
	case "$sc"
	{
		"[Script monitor";
		OnorOff(D_SCRIPTS)
	}
#endif

#ifclear NO_FUSES
	case "$fd"
	{
		"[Fuse/daemon monitor";
		OnorOff(D_FUSES)
	}
#endif

	case "$fo"
	{
		"[Parent of obj. "; : print number object; " ("; \
		object.name; "):  Obj. ";
		print number (parent(object)); " ("; parent(object).name; ")]"
	}
	case "$mo"
	{
		print "[Obj. "; number object; " ("; object.name; ") "; 
		print "moved to obj. "; number xobject; " ("; 
		print xobject.name; ")]"
		move object to xobject
		object is not hidden
		object is known
	}
	case "$mp"
	{
		if parent(object) ~= 0 and object is not enterable
			{print "[Obj. "; number object; " ("; 
			print object.name; ") is not a room object]"}
		else
			MovePlayer(object, false, true)
	}
	case "$on"
	{
		"[Object numbers";
		OnorOff(D_OBJNUM)
	}
	case "$na"
	{
		print "\""; object.name; "\""
	}
	case "$nu"
	{
		print "[Obj. "; number object; "]"
	}
	case "$ot"
	{
		print "["; number object; "] "; object.name
		list_nest = (object ~= 0)
		for (i=0; i<objects; i=i+1)
		{
			if i ~= object and parent(i) = object
				DrawBranch(i)
		}
	}

#ifclear NO_FUSES
	case "$ac"
	{
		if object.type ~= fuse and object.type ~= daemon
			"Not a fuse or daemon."
		else
			{Activate(object)
			object.timer = xobject
			"Activated."}
	}
	case "$de"
	{
		if object.type ~= fuse and object.type ~= daemon
			"Not a fuse or daemon."
		else
			{Deactivate(object)
			"Deactivated."}
	}
#endif

	case "$pm"
	{
		"[Parser monitoring";
		OnorOff(D_PARSE)
	}

#ifclear NO_OBJLIB
	case "$di"
	{
		if object:  place = object
		else:  place = location

		print "DIRECTIONS FROM:  "; capital place.name; "\n"
		for i in direction
		{
			print "\_ "; i.name; ":  ";
			if &place.(i.dir_to)
				"(Property routine)"
			else
			{
				n = place.i.dir_to
				if n > 1
					print capital n.name
				elseif n = 0
				{
					if not place.cant_go
						print CThe(player); \
							" can't go that way."
				}
			}
		}
	}
#endif
}

routine OnorOff
{
	local a
	
	if not (debug_flags & a)
	{
		print " on.]"
		debug_flags = debug_flags | a
	}
	else
	{
		print " off.]"
		debug_flags = debug_flags & ~a
	}
}

routine DrawBranch(obj)
{
	local i, nextobj

	for (i=1; i<=list_nest; i++)
		print ". . ";
	print "["; number obj; "] "; obj.name
	
	for nextobj in obj
		{list_nest++
		DrawBranch(nextobj)
		list_nest--}
}

replace The(obj, a)
{
	AssignPronoun(obj)

	if obj = player and player_person = 1 and a
	{
		print player.pronoun #2;
		jump PrintTheObjNumber
	}

	if obj.article
		print "the ";
	print obj.name;

:PrintTheObjNumber
	if (debug_flags & D_OBJNUM)
		print " ["; number obj; "]";
}

replace CThe(obj)
{
	AssignPronoun(obj)

	if obj.article
		print "The "; obj.name;
	else
		print capital obj.name;
	if (debug_flags & D_OBJNUM)
		print " ["; number obj; "]";
}

replace Art(obj, a)
{
	AssignPronoun(obj)

	if obj = player and player_person = 1 and a
	{
		print player.pronoun #2;
		jump PrintArtObjNumber
	}

	if obj.article
		print obj.article; " ";
	print obj.name;

:PrintArtObjNumber
	if (debug_flags & D_OBJNUM)
		print " ["; number obj; "]";
}

replace CArt(obj)
{
	AssignPronoun(obj)

	if obj.article
		print capital obj.article; " "; obj.name;
	else
		print capital obj.name;
	if (debug_flags & D_OBJNUM)
		print " ["; number obj; "]";
}

#endif  ! ifset _COMPILING_HUGOLIB

