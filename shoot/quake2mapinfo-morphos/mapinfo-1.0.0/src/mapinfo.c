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




/* main function */

int main(int argc, char *argv[])
{
	/* DECLARE MAIN VARIABLES */

	char columnType = 'D';
	char indexType = 'N';
	char outputType = 'F';
	char *ptrFileBuffer = NULL;
	char *ptrFilename = NULL;
	char *ptrLineBuffer = NULL;
	char *ptrLine = NULL;
	char sortOrder = 'd';

	int clColumnFlag = TRUE;
	int clEntFlag = TRUE;
	int clIndexFlag = TRUE;
	int clOutputFlag = TRUE;
	int clSortFlag = TRUE;
	int clTexFlag = TRUE;
	int i = 1;

	struct index *entitySorted = NULL;
	struct index *textureSorted = NULL;
	struct list entityList;
	struct list textureList;




	/* 							*/
	/* 	PARSE COMMAND LINE		*/
	/* 							*/

	if (argc > 1)
	{
		for( ; i < argc + 1; i++)
		{
			if ((strcmp(argv[i], CL_OPT_LA_SHORT) == 0) | (strcmp(argv[i], CL_OPT_LA_LONG) == 0))
			{
				if (clSortFlag)
				{
					sortOrder = 'a';
					clSortFlag = FALSE;
				}
				else
				{
					puts(CL_TOO_MANY_SORT_OPTIONS);
					puts(CL_OPT_USAGE);
					exit(EXIT_FAILURE);
				}
			}
			else if ((strcmp(argv[i], CL_OPT_BA_SHORT) == 0)
						| (strcmp(argv[i], CL_OPT_BA_LONG) == 0))
			{
				if (clSortFlag)
				{
					indexType = 'A';
					clIndexFlag = FALSE;
				}
				else
				{
					puts(CL_TOO_MANY_INDEX_OPTIONS);
					puts(CL_OPT_USAGE);
					exit(EXIT_FAILURE);
				}
			}
			else if ((strcmp(argv[i], CL_OPT_LD_SHORT) == 0)
						| (strcmp(argv[i], CL_OPT_LD_LONG) == 0))
			{
				if (clSortFlag)
				{
					sortOrder = 'd';
					clSortFlag = FALSE;
				}
				else
				{
					puts(CL_TOO_MANY_SORT_OPTIONS);
					puts(CL_OPT_USAGE);
					exit(EXIT_FAILURE);
				}
			}
			else if ((strcmp(argv[i], CL_OPT_BD_SHORT) == 0)
						| (strcmp(argv[i], CL_OPT_BD_LONG) == 0))
			{
				if (clColumnFlag)
				{
					columnType = 'D';
					clColumnFlag = FALSE;
				}
			}
			else if ((strcmp(argv[i], CL_OPT_LE_SHORT) == 0)
						| (strcmp(argv[i], CL_OPT_LE_LONG) == 0))
			{
				if (clEntFlag && clTexFlag)
				{
					clTexFlag = FALSE;

				}
				else
				{
					puts(CL_TOO_MANY_TYPE_OPTIONS);
					puts(CL_OPT_USAGE);
					exit(EXIT_FAILURE);
				}
			}
			else if ((strcmp(argv[i], CL_OPT_LF_SHORT) == 0)
						| (strcmp(argv[i], CL_OPT_LF_LONG) == 0))
			{
				if (argv[i + 1] != NULL)
				{
					ptrFilename = argv[i + 1];
					break;
				}
				else
				{
					puts(CL_MISSING_FILENAME);
					puts(CL_OPT_USAGE);
					exit(EXIT_FAILURE);
				}
			}
			else if ((strcmp(argv[i], CL_OPT_BF_SHORT) == 0)
						| (strcmp(argv[i], CL_OPT_BF_LONG) == 0))
			{
				if (clOutputFlag)
				{
					outputType = 'F';
					clOutputFlag = FALSE;
				}
				else
				{
					puts(CL_TOO_MANY_OUTPUT_OPTIONS);
					puts(CL_OPT_USAGE);
					exit(EXIT_FAILURE);
				}
			}
			else if ((strcmp(argv[i], CL_OPT_LH_SHORT) == 0)
						| (strcmp(argv[i], CL_OPT_LH_LONG) == 0))
			{
				printf("%s\n\n", CL_OPT_USAGE);
				printf(CL_OPT_SPACER, CL_OPT_LA, CL_OPT_LA_DESC);
				printf(CL_OPT_SPACER, CL_OPT_BA, CL_OPT_BA_DESC);
				printf(CL_OPT_SPACER, CL_OPT_LD, CL_OPT_LD_DESC);
				printf(CL_OPT_SPACER, CL_OPT_BD, CL_OPT_BD_DESC);
				printf(CL_OPT_SPACER, CL_OPT_LE, CL_OPT_LE_DESC);
				printf(CL_OPT_SPACER, CL_OPT_LF, CL_OPT_LF_DESC);
				printf(CL_OPT_SPACER, CL_OPT_BF, CL_OPT_BF_DESC);
				printf(CL_OPT_SPACER, CL_OPT_LH, CL_OPT_LH_DESC);
				printf(CL_OPT_SPACER, CL_OPT_LL, CL_OPT_LL_DESC);
				printf(CL_OPT_SPACER, CL_OPT_BN, CL_OPT_BN_DESC);
				printf(CL_OPT_SPACER, CL_OPT_BR, CL_OPT_BR_DESC);
				printf(CL_OPT_SPACER, CL_OPT_BS, CL_OPT_BS_DESC);
				printf(CL_OPT_SPACER, CL_OPT_LT, CL_OPT_LT_DESC);
				printf(CL_OPT_SPACER, CL_OPT_LU, CL_OPT_LU_DESC);
				printf(CL_OPT_SPACER, CL_OPT_LV, CL_OPT_LV_DESC);
				exit(EXIT_SUCCESS);
			}
			else if ((strcmp(argv[i], CL_OPT_LL_SHORT) == 0)
						| (strcmp(argv[i], CL_OPT_LL_LONG) == 0))
			{
				LicenseOutput();
				exit(EXIT_SUCCESS);
			}
			else if ((strcmp(argv[i], CL_OPT_BN_SHORT) == 0)
						| (strcmp(argv[i], CL_OPT_BN_LONG) == 0))
			{
				if (clSortFlag)
				{
					indexType = 'N';
					clIndexFlag = FALSE;
				}
				else
				{
					puts(CL_TOO_MANY_INDEX_OPTIONS);
					puts(CL_OPT_USAGE);
					exit(EXIT_FAILURE);
				}
			}
			else if ((strcmp(argv[i], CL_OPT_BR_SHORT) == 0)
						| (strcmp(argv[i], CL_OPT_BR_LONG) == 0))
			{
				if (clOutputFlag)
				{
					outputType = 'R';
					clOutputFlag = FALSE;
				}
				else
				{
					puts(CL_TOO_MANY_OUTPUT_OPTIONS);
					puts(CL_OPT_USAGE);
					exit(EXIT_FAILURE);
				}
			}
			else if ((strcmp(argv[i], CL_OPT_BS_SHORT) == 0)
						| (strcmp(argv[i], CL_OPT_BS_LONG) == 0))
			{
				if (clColumnFlag)
				{
					columnType = 'S';
					clColumnFlag = FALSE;
				}
				else
				{
					puts(CL_TOO_MANY_COLUMN_OPTIONS);
					puts(CL_OPT_USAGE);
					exit(EXIT_FAILURE);
				}
			}
			else if ((strcmp(argv[i], CL_OPT_LT_SHORT) == 0)
						| (strcmp(argv[i], CL_OPT_LT_LONG) == 0))
			{
				if (clEntFlag && clTexFlag)
				{
					clEntFlag = FALSE;
				}
				else
				{
					puts(CL_TOO_MANY_TYPE_OPTIONS);
					puts(CL_OPT_USAGE);
					exit(EXIT_FAILURE);
				}
			}
			else if ((strcmp(argv[i], CL_OPT_LU_SHORT) == 0)
						| (strcmp(argv[i], CL_OPT_LU_LONG) == 0))
			{
				if (clSortFlag)
				{
					sortOrder = 'u';
					clSortFlag = FALSE;
				}
				else
				{
					puts(CL_TOO_MANY_SORT_OPTIONS);
					puts(CL_OPT_USAGE);
					exit(EXIT_FAILURE);
				}
			}
			else if ((strcmp(argv[i], CL_OPT_LV_SHORT) == 0)
						| (strcmp(argv[i], CL_OPT_LV_LONG) == 0))
			{
				VersionOutput();
				exit(EXIT_SUCCESS);
			}
			else
			{
				printf(CL_ILLEGAL_OPTION);
				printf("%s\n", argv[i]);
				puts(CL_HELP);
				exit(EXIT_FAILURE);
			}

		}

	}
	else
	{
		puts(CL_MISSING_FILENAME);
		puts(CL_OPT_USAGE);
		exit(EXIT_FAILURE);
	}

	/*	force single column mode if only one type is being displayed	*/
	if ((clEntFlag == FALSE) | (clTexFlag == FALSE))
	{
		if ((columnType == 'D') && (outputType == 'F'))
			columnType = 'S';
	}



	/* 							*/
	/*	LOAD MAP FILE			*/
	/* 							*/

	/* load file buffer in memory */
	ptrFileBuffer = LoadFileBuffer(ptrFilename);

	/* create line buffer in memory */
	ptrLineBuffer = CreateLineBuffer();

	/* break file buffer into individual lines to process  */
	ptrLine = strtok(ptrFileBuffer, "\n");

	/*	initialize list structs to receive data	*/
	InitList(&entityList, NAME_E);
	InitList(&textureList, NAME_T);

	/* walk through file buffer line by line */
	while (ptrLine != NULL)
	{

		/* process selected three types of lines
		   BSP - extraenous lines to filter out
		   classname - beginning for entity info
		   ( - beginning for texture info */
		if (strstr(ptrLine, "BSP"))
			;
		else  if (strstr(ptrLine, "\"classname\""))
		{
			/* parse line for entity list */
			ParseEntity(ptrLine, ptrLineBuffer);

			/* build no */
			BuildList(&entityList, ptrLineBuffer);

			ResetBuffer(ptrLineBuffer);
		}

		/* process texture line */
		else if (strstr(ptrLine, "("))
		{
			/* parse for texture name */
			ParseTexture(ptrLine, ptrLineBuffer);

			BuildList(&textureList, ptrLineBuffer);

			ResetBuffer(ptrLineBuffer);
		}


		/* advance to next line */
		ptrLine = strtok(NULL, "\n");

	}

	/* unload buffers - no longer needed */
	UnloadBuffer(ptrFileBuffer);
	UnloadBuffer(ptrLineBuffer);

	/* check to see if list has usable data to work with */
	if ((entityList.start == NULL) & (textureList.start == NULL))
	{
		puts(CL_FILE_CONTAINS_NO_DATA);
		exit(EXIT_FAILURE);
	}
	
	

	/* 							*/
	/*	CREATE SORTED INDEX		*/
	/*							*/

	/* calculate list stats for entities */
	CalculateListStats(&entityList);

	/* create index */
	entitySorted = CreateIndex(entityList.nodeCount);

	/* set index to either alphabetical or numeric */
	if (indexType == 'A')
		SetIndexAlpha(&entityList, entitySorted, sortOrder);
	else
		SetIndexNumeric(&entityList, entitySorted, sortOrder);


	/* calculate list stats for textures */
	CalculateListStats(&textureList);

	/* create index */
	textureSorted = CreateIndex(textureList.nodeCount);

	/* set index to either alphabetical or numeric */
	if (indexType == 'A')
		SetIndexAlpha(&textureList, textureSorted, sortOrder);
	else
		SetIndexNumeric(&textureList, textureSorted, sortOrder);



	/*							*/
	/*	CONSOLE OUTPUT 			*/
	/*							*/

	if (outputType == 'R')
	{

			if (clEntFlag)
				RawOutput(&entityList, entitySorted);

			if (clEntFlag & clTexFlag)
				putchar('\n');

			if (clTexFlag)
				RawOutput(&textureList, textureSorted);

	}
	else
	{
		HeaderOutput();
		PathOutput(ptrFilename);

		if (columnType == 'S')
		{
			if (clEntFlag)
				SingleColumn(&entityList, entitySorted);

			if (clEntFlag & clTexFlag)
				putchar('\n');

			if (clTexFlag)
				SingleColumn(&textureList, textureSorted);
		}
		else
		{
			DoubleColumn(&entityList, entitySorted, &textureList, textureSorted);
		}
	}



	/* 							*/
	/* UNLOAD MEMORY			*/
	/* 							*/

	UnloadList(&entityList);
	UnloadList(&textureList);
	free(entitySorted);
	free(textureSorted);

	/* return status code */
	return(EXIT_SUCCESS);

}
