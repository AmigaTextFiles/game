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



/* output data in a double column format */
void DoubleColumn(struct list *eList, struct index *eIndex, struct list *tList,
					struct index *tIndex)
{

	/* function variables */
	unsigned int eCount = 0;
	unsigned long int eSize = eList->nodeCount;
	
	unsigned int tCount = 0;
	unsigned long int tSize = tList->nodeCount;
	
	unsigned long int lSize = (eSize > tSize ? eSize : tSize);
	unsigned long int i = 0;
	
	struct node *e_current_node = NULL;
	struct node *t_current_node = NULL;
	
	/* output data to console */
	puts(SPACER);
	
	/* first line */
	printf("| %4s | %-27s%4lu  |  %-27s%4lu |\n", CL_OUT_BLANK, eList->name, eSize, tList->name,
			tSize);
	
	puts(SPACER);
	
	/* formatted data in the middle */
	for (i = 0; i < lSize; i++)
	{
	
		printf("| %4lu | ", i + 1);
		
		if ( i < eSize)
		{
			e_current_node = eIndex[i].link;
			printf("%-25s", e_current_node->item);
			printf(" %5u" , e_current_node->count);
			eCount += e_current_node->count;
		}
		else
			printf("%-31s", "");
			
		printf("  |  ");
		
		if ( i < tSize)
		{
			t_current_node = tIndex[i].link;
			printf("%-25s", t_current_node->item);
			printf(" %5u" , t_current_node->count);
			tCount += t_current_node->count;
		}
		else
			printf("%-31s", CL_OUT_BLANK);
			
		printf(" |\n");
	
	}
	
	puts(SPACER);
	
	/* last line */
	printf("| %4s | %26s%5u  |  %26s%5u |\n", CL_OUT_BLANK, CL_OUT_TOTAL_REF, eCount,
			CL_OUT_TOTAL_REF, tCount);
	
	puts(SPACER);
}



/* output header info */
void HeaderOutput(void)
{
	puts(SPACER);
	printf("%s (%s)\n", CL_OUT_MAPINFO, CL_OUT_VERSION);
	printf("%s\n", CL_OUT_COPYRIGHT);
	printf("%s\n", CL_OUT_HEADER1);
	printf("%s\n", CL_OUT_HEADER2);
	printf("%s\n", SPACER);
}



/* output license info */
void LicenseOutput(void)
{
	printf("%s: %s\n", CL_OUT_MAPINFO, CL_OUT_MAPFILE_DESC);
	printf("%s\n\n", CL_OUT_COPYRIGHT);

	printf("%s\n", CL_OUT_ID1);
	printf("%s\n", CL_OUT_ID2);
	printf("%s\n", CL_OUT_ID3);
	printf("%s\n\n", CL_OUT_ID4);

    printf("%s%s\n", CL_OUT_MAPINFO, CL_OUT_GNU_A1);
    printf("%s\n", CL_OUT_GNU_A2);
    printf("%s\n", CL_OUT_GNU_A3);
	printf("%s\n\n", CL_OUT_GNU_A4);

   	printf("%s%s\n", CL_OUT_MAPINFO, CL_OUT_GNU_B1);
    printf("%s\n", CL_OUT_GNU_B2);
    printf("%s\n", CL_OUT_GNU_B3);
	printf("%s\n\n", CL_OUT_GNU_B4);
	
	printf("%s\n", CL_OUT_GNU_C1);
	printf("%s%s%s\n", CL_OUT_GNU_C2, CL_OUT_MAPINFO, CL_OUT_GNU_C3);
}


/* output version info */
void VersionOutput(void)
{
	printf("%s (%s)\n", CL_OUT_MAPINFO, CL_OUT_VERSION);
}

/* output map file path info */
void PathOutput(char *filename)
{
	printf("\n%s %s\n\n", CL_OUT_MAPFILE, filename);
}

/* output raw data with no formatting */
void RawOutput(struct list *sList, struct index *sIndex)
{

	/* function variables */
	int i = 0;
	int size = sList->nodeCount;
	struct node *current_node = NULL;
	
	for (i = 0; i < size; i++)
	{
		current_node = sIndex[i].link;
		
		printf("%s ", current_node->item);
		printf("%d\n" , current_node->count);
	}
}

/* output data in a double column format */
void SingleColumn(struct list *sList, struct index *sIndex)
{
	/* function variables */
	int i = 0;
	int size = sList->nodeCount;
	unsigned long int rCount = 0;
	struct node *current_node = NULL;
	
	puts(SPACER);
	
	/* first line */
	printf("| %4s | %-62s%4d  |\n", CL_OUT_BLANK, sList->name, size);
	
	puts(SPACER);
	
	/* formatted data in the middle */
	for (i = 0; i < size; i++)
	{
		current_node = sIndex[i].link;
		
		printf("| %4d | ", i + 1);
		printf("%-60s", current_node->item);
		printf(" %5d" , current_node->count);
		printf("  |\n");
		
		rCount += current_node->count;
		
	}
	
	puts(SPACER);
	
	/* last line */
	printf("| %4s | %61s%5ld  |\n", CL_OUT_BLANK, CL_OUT_TOTAL_REF, rCount);
	
	puts(SPACER);
}
