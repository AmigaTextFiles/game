!----------------------------------------------------------------------------
!
!        HUGOFIX Library Grammar v2.2.1 by Kent Tessman (c) 1995-1996
!                     for use with Hugo Compiler v2.2
!
!----------------------------------------------------------------------------
!
! This grammar file is automatically included by GRAMMAR.G if the DEBUG 
! flag is set.
!
! NOTE:  The following verb definitions follow the somewhat non-standard
! practice of each calling the same verb routine (DoHugoFix), primarily
! to cut down on the sheer number of verbs.  DoHugoFix is responsible for
! differentiating which debugging command is intended based on word[1].
!
!----------------------------------------------------------------------------

#version 2.2

xverb "$", "$tr", "$tl", "$ex", "$as", "$at", "$ps", "$pt", "$gv", "$rs", \
	"$ev", "$om"                            
	*                                       DoHugoFix

xverb "$wo"
	* number                                DoHugoFix

#ifclear NO_SCRIPTS
xverb "$sc"
	*                                       DoHugoFix
#endif

#ifclear NO_FUSES
xverb "$fd"
	*                                       DoHugoFix
#endif

xverb "$sa"
	* anything number                       DoHugoFix
	* number number                         DoHugoFix

xverb "$ca"
	* anything number                       DoHugoFix
	* number number                         DoHugoFix

xverb "$sp"
	* number "#1"/"#2"/"#3"/"#4" number     DoHugoFix
	* number number                         DoHugoFix

xverb "$so"
	* anything                              DoHugoFix
	* number                                DoHugoFix

xverb "$ta"
	* anything number                       DoHugoFix
	* number number                         DoHugoFix

xverb "$tp"
	* anything number "#1"/"#2"/"#3"/"#4"   DoHugoFix
	* anything number                       DoHugoFix
	* number number "#1"/"#2"/"#3"/"#4"     DoHugoFix
	* number number                         DoHugoFix

xverb "$fo"
	* anything                              DoHugoFix
	* number                                DoHugoFix

xverb "$mo"
	* anything "to" anything                DoHugoFix
	* number "to" number                    DoHugoFix

xverb "$mp"
	* anything                              DoHugoFix
	* number                                DoHugoFix

xverb "$on"
	*                                       DoHugoFix

xverb "$nu"
	* anything                              DoHugoFix

xverb "$na"
	* number                                DoHugoFix

xverb "$ot"
	*                                       DoHugoFix
	* number                                DoHugoFix
	* anything                              DoHugoFix

xverb "$ac"
	* anything                              DoHugoFix
	* anything number                       DoHugoFix
	* number                                DoHugoFix
	* number number                         DoHugoFix

xverb "$de"
	* anything                              DoHugoFix
	* number                                DoHugoFix

xverb "$pm"
	*                                       DoHugoFix

#ifclear NO_OBJLIB
xverb "$di"
	*                                       DoHugoFix
	* number                                DoHugoFix
	* anything                              DoHugoFix
#endif
