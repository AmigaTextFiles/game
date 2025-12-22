/*	Map Info: Parse entity and texture info from Quake 2 map files.
	Copyright 2010 C.D. Reimer (Email: webmaster@cdreimer-associates.com)
	
	Quake 2 is owned by Id Software LLC.  Other than glancing at the map
	file to determine parsing pattern, Map Info does not incoporate any
	code written by Id Software under the GNU General Public License.
	http://www.idsoftware.com/business/idtech2/

	This file is part of Map Info.

    Map Info is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Map Info is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Map Info.  If not, see <http://www.gnu.org/licenses/>.
    
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mapinfo.h"



/* create line buffer for processing file lines */
void* CreateLineBuffer(void)
{

	/* declare function variables */
	char *ptrBuffer = NULL;

	/* memory for the buffer */
	ptrBuffer = (char*)malloc(LINEBUFFER_SIZE);

	/* quit if memory error */
	if (ptrBuffer == NULL)
	{
		printf(ERROR_FORMAT, ERROR_MSG, ERROR_MSG_CLB1);
		exit(EXIT_FAILURE); 
	}

	/* reset buffer */
	ResetBuffer(ptrBuffer);

	/* return pointer */
	return(ptrBuffer);

}



/* load file into buffer */
void* LoadFileBuffer(char *filename)
{

	/* declare function variables */
	FILE *ptrFile;
	unsigned long numbytes;
	void *ptrBuffer;

	/* checking for non-valid filename - display error message and
	   return NULL, if needed */
	if ((strcmp(filename,"") == 0) | (filename == NULL))
	{
		printf(ERROR_FORMAT, ERROR_MSG, ERROR_MSG_LFB1);
		exit(EXIT_FAILURE);
	}

	/* open file for reading */
	ptrFile = fopen(filename, "rt");

	/* quit if the file does not exist - display error message and
	   return NULL, if needed */
	if (ptrFile == NULL)
	{
		printf(ERROR_FORMAT, ERROR_MSG, ERROR_MSG_LFB2);
		exit(EXIT_FAILURE);
	}

	/* get number of bytes from file */
	fseek(ptrFile, 0L, SEEK_END);
	numbytes = ftell(ptrFile);

	/* check to see if numbytes returns a zero or negative number */
	if (numbytes <= 0)
	{
		printf(ERROR_FORMAT, ERROR_MSG, ERROR_MSG_LFB4);
		exit(EXIT_FAILURE);	
	}

	/* reset file position indicator */
	fseek(ptrFile, 0L, SEEK_SET);

	/* allocate memory for the buffer */
	ptrBuffer = (char*)malloc(numbytes);

	/* quit if memory error - display error message and return
	   NULL, if needed */
	if (ptrBuffer == NULL)
	{
		printf(ERROR_FORMAT, ERROR_MSG, ERROR_MSG_LFB2);
		exit(EXIT_FAILURE);
	}

	/* copy file into buffer */
	fread(ptrBuffer, sizeof(char), numbytes, ptrFile);

	/* close file */
	fclose(ptrFile);

	/* return pointer */
	return(ptrBuffer);
}



/* reset line buffer */
void ResetBuffer(char *buffer)
{
	/* fill buffer with character '\0' */
	memset(buffer, '\0', LINEBUFFER_SIZE);
}



/* unload buffer from memory */
void UnloadBuffer(char *buffer)
{
	/* unallocated memory */
	free(buffer);

	/* set memory pointer to NULL to be on safe side */
	buffer = NULL;
}
