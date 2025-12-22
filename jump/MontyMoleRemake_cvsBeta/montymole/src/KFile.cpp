/*!

	\author Kevan Thurstans

	\brief Simple file handling class.
						Wraps some of the standard C file functions.
						LoadAll method allows a quick easy way to load a whole file
						into some memory. Once created this memory block must be 
						destroyed by user, will not be destroyed by class.

	\date	:	06/10/01

*/

#include <stdio.h>
#include "KFile.h"



// Different modes when opening file
const char*	KFile::strModes[] = 
{	
	"rb",				// Read binary
	"wb"				// Write binary
};



KFile::KFile()
{
	fptr = NULL;			// No file opened yet
}

KFile::~KFile()
{
	if(fptr != NULL)	// File not closed yet
		Close();				// Attempt to close
}


/*!

	\brief Open.

	Attempt to open given file.

	@param const char* strFilename -	Name of file to open
	@param const MODE mode - read /write mode.

	@return bool true is file has opened correctly

*/

bool KFile::Open(const char* strFilename, const MODE mode)
{
	if(fptr != NULL)	// if another file is open
		Close();				// attempt to close it

	fptr = fopen(strFilename, strModes[mode]);	// attempt to open file and get ptr

	return (fptr != NULL);											// return result
}



/*****************************************************************************

	Close

	Attempt to close file.

	ENTRY	:	

	EXIT	: bool					true is file has opened correctly

*****************************************************************************/

bool KFile::Close()
{
	bool		bSuccess = false;

	if(fptr)
		bSuccess = (fclose(fptr) == 0x00);

	if(bSuccess)
		fptr = NULL;

	return bSuccess;
}



/*****************************************************************************

	GetSize

	Get number of bytes in file

	ENTRY	:	

	EXIT	: long					number of bytes in file

*****************************************************************************/

long KFile::GetSize()
{
	long		lFilesize=NOSIZE;		// start with nothing

	if(fptr)									// only do if file has been opened
	{
		fseek(fptr, 0L, SEEK_END);					// move to beginning of stream
		lFilesize = ftell(fptr);
		rewind(fptr);												// reset cursor to start of file
	}

	return lFilesize;
}



/*****************************************************************************

	LoadAll

	Load whole file into new memory block. 
	Block is independent of KFILE and will not be destroyed when out of scope.

	ENTRY	:	

	EXIT	: void*					pointer to new memory block holding file
												NULL is returned is file could not be loaded

*****************************************************************************/

void* KFile::LoadAll()
{
	long		lFilesize;							// Size of file
	char		*cMemoryBlock=NULL;			// memory holding loaded data

	if(fptr)												// check we have a file open
	{
		lFilesize = GetSize();				// get number of bytes held
		if(lFilesize > NOSIZE)	// if there is some data
		{
			cMemoryBlock = new char[lFilesize];	// create enough memory to load data into
			lFilesize = fread(cMemoryBlock, sizeof(char), lFilesize, fptr);
		}
	}

	return cMemoryBlock;						// return either memoryblock or NULL
}



/*****************************************************************************

	NAME	: Save

	DESCR.: Save data from given details

	ENTRY	: Uint8		*lpData - address of data to save
					long		size		- number of bytes to save

	EXIT	:

*****************************************************************************/

bool KFile::Save(char *lpData, long size)
{
	bool	bSuccess = false;
	long	lFilesize;								// Size of file

	if(fptr)												// check we have a file open
	{
		lFilesize = fwrite(lpData, sizeof(char), size, fptr);
		if(size == lFilesize)
			bSuccess = true;
	}

	return bSuccess;
}

/*!@}*/
