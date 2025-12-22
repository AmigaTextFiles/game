//=========================================================================
//=========================================================================
//
//	AmiSGE - file access functions
// 
//	(c) 1999 John Girvin/Halibut Software, All Rights Reserved
//
//	This file may not be distributed, reproduced or altered, in full or in
//	part, without written permission from John Girvin. Legal action will be
//	taken in cases where this notice is not obeyed.
//
//=========================================================================
//=========================================================================

#include	"file.h"

//=========================================================================
// BOOL gfReadFile
//
// Load a file to a memory location and optionally return the length read
//=========================================================================
BOOL gfReadFile(
					STRPTR	 a_fnam,
					APTR	 a_buff,
					ULONG	*a_flen
			   )
{
	BOOL					retval = FALSE;
	ULONG					len;
	BPTR					pFH;
    struct FileInfoBlock *	pFIB;

	//=====================================================================
	// Allocate FIB 
	//=====================================================================
    if ((pFIB = (struct FileInfoBlock *)AllocDosObject(DOS_FIB, 0)) != NULL)
	{
		//=================================================================
		// Open the file
		//=================================================================
		if ((pFH = Open(a_fnam, MODE_OLDFILE)) != NULL)
		{
			//=============================================================
			// Get file length from filehandle
			//=============================================================
			if (ExamineFH(pFH, pFIB))
			{
				len = (ULONG)(pFIB->fib_Size);

				//=========================================================
				// Read the file to the buffer
				//=========================================================
				if (Read(pFH, a_buff, len) == len)
				{
					//=====================================================
					// Set returned file length if required
					//=====================================================
					if (a_flen != NULL)
					{
						(*a_flen) = len;
					}
					retval = TRUE;
				}
			}

			Close(pFH);
		}

		FreeDosObject(DOS_FIB, pFIB);
	}

	return(retval);
}

//=========================================================================
// BOOL gfWriteFile
//
// Write a buffer to disk
//=========================================================================
BOOL gfWriteFile(
					STRPTR	a_fnam,
					APTR	a_buff,
					ULONG	a_flen
				)
{
	BOOL retval = FALSE;
	BPTR pFH;

	if ((pFH = Open(a_fnam, MODE_NEWFILE)) != NULL)
	{
		if (Write(pFH, a_buff, a_flen) == a_flen)
		{
			retval = TRUE;
		}
		Close(pFH);
	}

	return(retval);
}
