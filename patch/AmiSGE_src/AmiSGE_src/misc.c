//========================================================================
//========================================================================
//
//  AmiSGE - miscellaneous functions
//
//	(c) 1999 John Girvin/Halibut Software, All Rights Reserved
//
//	This file may not be distributed, reproduced or altered, in full or in
//	part, without written permission from John Girvin. Legal action will be
//	taken in cases where this notice is not obeyed.
//
//========================================================================
//========================================================================

#include	"misc.h"

//========================================================================
// Convert string to upper-case in place
//========================================================================
STRPTR gfStrToUpper(
					STRPTR a_str
				   )
{
	STRPTR p = a_str;

	while (*p != '\0')
	{
		*p = toupper(*p);
		p++;
	}

	return(p);
}
