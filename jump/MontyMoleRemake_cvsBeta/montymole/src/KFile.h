/*! 
	\defgroup KTools
	@{
*/

/*!

	\class KFile.h
	\author Kevan Thurstans

	\brief Simple file handling class.
						Wraps some of the standard C file functions.
						LoadAll method allows a quick easy way to load a whole file
						into some memory. Once created this memory block must be 
						destroyed by user, will not be destroyed by class.

	\date	:	06/10/01
	\notes Update<BR>
	12/05/2005 - Improved OO side of code.

*/


#ifndef __KFILE_H
#define __KFILE_H

#include <stdio.h>




class KFile
{

public:

	enum MODE
	{	
		READONLY,		// read binary file
		WRITE			// write binary file
	};

	enum
	{
		NOSIZE = 0x00
	};


	KFile();
	~KFile();

	bool	Open(const char* strFilename, const MODE mode);	// Open pointer to given file
	bool	Close();												// Close file
	void*	LoadAll();											// Load Whole into new memory block & returns ptr
	bool	Save(char *lpData, long size);	// Save Data
	long	GetSize();											// Number of bytes in file.

private:

	FILE	*fptr;													// file pointer

	static const char *strModes[3];				// diferent ansi read/write modes

};


#endif /*!@}*/

