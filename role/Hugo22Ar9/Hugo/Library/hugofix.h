!----------------------------------------------------------------------------
!
!       HUGOFIX Debugging Library v2.2.1 by Kent Tessman (c) 1995-1996
!                     for use with Hugo Compiler v2.2
!
!----------------------------------------------------------------------------
!
!    NOTE:  These routines and the corresponding grammar table are
!           automatically included by HUGOLIB.H and GRAMMAR.G if the
!           DEBUG compiler flag is set.
!
!----------------------------------------------------------------------------

#version 2.2

#ifclear _COMPILING_HUGOLIB
#message warning "HUGOFIX.H not #included; #set DEBUG instead"
#endif

#ifset _COMPILING_HUGOLIB

! BITMASKS FOR debug_flags:
!
! NOTE:  The following statement is used frequently below:
!
!       system(x - (debug_flags & D_SOMEFLAG > 0))
!
! If D_SOMEFLAG is set in debug_flags, system(x-1) is called.  If not,
! system(x) is called.

global debug_flags

constant D_ATTRSET         1    ! attribute setting
constant D_ATTRTEST        2    ! attribute testing
constant D_EVENTS          4    ! event monitoring
constant D_EXPR            8    ! expression tracing
constant D_FUSES          16    ! fuse/daemon monitoring
constant D_LIMTRACE       32    ! limited code tracing
constant D_OBJMOVE        64    ! object movement
constant D_OBJNUM        128    ! object numbers
constant D_PARSE         256    ! parse monitoring
constant D_PROPSET       512    ! property setting
constant D_PROPTEST     1024    ! property testing
constant D_ARRAYSET     2048    ! array setting
constant D_SCRIPTS      4096    ! script monitoring
constant D_TRACE        8192    ! code tracing
constant D_VARSET      16384    ! global variable setting

global debug_selectobj          ! select object for prop. setting

routine DoHugoFix
{
	local a, i, n, place

	select word[1]
	case "$", "$?"
	{
		"HUGOFIX DEBUGGING COMMANDS:\n\
		\_    $?  - Display this help menu\n"

		"Tracing:\n\
		\_    $ex - Toggle expression tracing\n\
		\_    $tr - Toggle code tracing\n
		\_    $tl - Toggle limited code tracing"

		"Monitoring:\n\
		\_    $as - Attribute setting monitor on/off\n\
		\_    $at - Attribute testing monitor on/off\n\
		\_    $om - Monitor object movement\n\
		\_    $on - Toggle object numbers\n\
		\_    $ev - Event monitor on/off"

	#ifclear NO_SCRIPTS
	       "\_    $sc - Script monitor on/off"
	#endif

	#ifclear NO_FUSES
	       "\_    $fd - Fuse/daemon monitor on/off"
	#endif

	       "\_    $pm - Parser monitoring on/off\n\
		\_    $ps - Property setting monitor on/off\n\
		\_    $pt - Property testing monitor on/off\n\
		\_    $gv - Global variable setting monitor on/off\n\
		\_    $rs - Array setting monitor on/off\n"

		"Object alteration:\n\
		\_    $ca <obj.> <attr. #> - Clear attribute\n\
		\_    $sa <obj.> <attr. #> - Set attribute\n\
		\_    $so <obj.>                  - Select object\n\
		\_    $sp <prop.> [#1 - 4] <val.> - Set property of selected 
			obj. to <val.>\n\
		\_    $mo <obj.> to <obj.> - Move object to new parent\n\
		\_    $mp <obj.>           - Move player object to new 
			parent\n"

		"Object testing:\n\
		\_    $fo <obj.>   - Find object\n\
		\_    $na <obj. #> - Print name of object number <obj.>\n\
		\_    $nu <obj.>   - Print number of object <obj.>\n\
		\_    $ta <obj.> <attr. #>          - Test attribute\n\
		\_    $tp <obj.> <prop. #> [#1 - 4] - Test property\n"
		
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
	case "$tr"
	{
		"[Trace";
		OnorOff(D_TRACE)
		system(2-(debug_flags & D_TRACE > 0)) 
	}
	case "$tl"
	{
		"[Limited tracing";
		OnorOff(D_LIMTRACE)
		system(22-(debug_flags & D_LIMTRACE > 0))
	}
	case "$ex"
	{
		"[Expression trace";
		OnorOff(D_EXPR)
		system(4-(debug_flags & D_EXPR > 0))
	}
	case "$as"
	{
		"[Attribute setting monitor";
		OnorOff(D_ATTRSET)
		system(6-(debug_flags & D_ATTRSET > 0))
	}
	case "$at"
	{
		"[Attribute testing monitor";
		OnorOff(D_ATTRTEST)
		system(8-(debug_flags & D_ATTRTEST > 0))
	}
	case "$ps"
	{
		"[Property setting monitor";
		OnorOff(D_PROPSET)
		system(10-(debug_flags & D_PROPSET > 0))
	}
	case "$pt"
	{
		"[Property testing monitor";
		OnorOff(D_PROPTEST)
		system(12-(debug_flags & D_PROPTEST > 0))
	}
	case "$gv"
	{
		"[Global variable setting monitor";
		OnorOff(D_VARSET)
		system(14-(debug_flags & D_VARSET > 0))
	}
	case "$rs"
	{
		"[Array setting monitor";
		OnorOff(D_ARRAYSET)
		system(16-(debug_flags & D_VARSET > 0))
	}
	case "$wo"
	{
		print "\""; object; "\""
	}
	case "$ev"
	{
		"[Event monitor";
		OnorOff(D_EVENTS)
		system(18-(debug_flags & D_EVENTS > 0))
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

	case "$ta"
	{
		print "[Testing obj. "; number object; 
		print " <"; object.name; "> is ";
		if not (object is xobject)
			print "not ";
		print "<attribute "; number xobject; ">]"
	}
	case "$tp"
	{
		n = 1
		if word[words] = "#2"
			n = 2
		elseif word[words] = "#3"
			n = 3
		elseif word[words] = "#4"
			n = 4

		a = object.xobject #n
		print "[Testing obj. "; number object; 
		print " <"; object.name; ">.<property "; number xobject; ">";
		if n > 1
			print " #"; number n;
		print " = ";
		print number a; " ($"; hex a; ")]"
	}
	case "$sa"
	{
		object is xobject
	}
	case "$ca"
	{
		object is not xobject
	}
	case "$so"
	{
		print "[Obj. "; number object; " ("; object.name; 
		") selected]"
		debug_selectobj = object
	}
	case "$sp"
	{
		n = 1
		if word[3] = "#2"
			n = 2
		elseif word[3] = "#3"
			n = 3
		elseif word[3] = "#4"
			n = 4

		debug_selectobj.object #n = xobject
	}
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
			MovePlayer(object)
	}
	case "$on"
	{
		"[Object numbers";
		OnorOff(D_OBJNUM)
	}
	case "$om"
	{
		"[Object movement monitor";
		OnorOff(D_OBJMOVE)
		system(20-(debug_flags & D_OBJMOVE > 0))
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
		nest = (object ~= 0)
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

		print "AVAILABLE DIRECTIONS FROM:  "; capital place.name
		for (i=n_obj; i<=out_obj; i=i+1)
		{
			print "\_ "; i.name; ":  ";
			n = place.(i.dir_to)
			if n > 1
				print n.name
			elseif n = 0
				if not place.cant_go
					print "You can't go that way."
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

	for (i=1; i<=nest; i=i+1)
		print ". . ";
	print "["; number obj; "] "; obj.name
	
	for nextobj in obj
		{nest = nest + 1
		DrawBranch(nextobj)
		nest = nest - 1}
}

replace The(obj)
{
	AssignPronoun(obj)

	if obj.article
		print "the ";
	print obj.name;
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

replace Art(obj)
{
	AssignPronoun(obj)

	if obj.article
		print obj.article; " ";
	print obj.name;
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

