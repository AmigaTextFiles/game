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



void* CreateIndex(int size)
{
	struct index *ptrIndex = NULL;
	
	ptrIndex = malloc(sizeof(struct index) * size);
	
	/* quit if memory error */
	if (ptrIndex == NULL)
	{
		printf(ERROR_FORMAT, ERROR_MSG, ERROR_MSG_CI1);
		exit(EXIT_FAILURE); 
	}
	
	return ptrIndex;
}

/* initialize and sort numeric index array */
void SetIndexAlpha(struct list *sList, struct index *nIndex, char sort)
{
	/* function variables */
	int a = 0;
	int b = 0;
	int i = 0;
	int size = sList->nodeCount;
	struct node *current_node = sList->start;
	
	/* walking through list to initiate sort array by assigning value and pointer */
	for (i = 0; current_node != NULL; current_node = current_node->next, i++)
	{
		nIndex[i].value.item = current_node->item;
		nIndex[i].link = current_node;
	}
	
	/* bubble sort numeric values in ascending or descending order */
	for (a = 0; a < size; a++)
	{
		for (b = 0; b < size; b++)
		{
			switch(sort)
			{ 
				case 'a':
					if (strcmp(nIndex[a].value.item, nIndex[b].value.item) < 0)
						SwapPtrs(&nIndex[a], &nIndex[b], sizeof(struct index));
					break;
				
				case 'd':
					if (strcmp(nIndex[a].value.item, nIndex[b].value.item) > 0)
						SwapPtrs(&nIndex[a], &nIndex[b], sizeof(struct index));
						
				default:
					break;
			}
		}
	}
}


/* initialize and sort numeric index array */
void  SetIndexNumeric(struct list *sList, struct index *nIndex, const char sort)
{
	/* function variables */
	int a = 0;
	int b = 0;
	int i = 0;
	int size = sList->nodeCount;
	struct node *current_node= sList->start;
	
	/* walking through list to initiate sort array */
	for (i = 0; current_node != NULL; current_node = current_node->next, i++)
	{
		/* assign value and pointer */
		nIndex[i].value.count = current_node->count;
		nIndex[i].link = current_node;
	}
	
	/* bubble sort numeric values in ascending or descending order */
	for (a = 0; a < size; a++)
	{
		for (b = 0; b < size; b++)
		{
			switch(sort)
			{ 
				case 'a':
					if (nIndex[a].value.count < nIndex[b].value.count)
						SwapPtrs(&nIndex[a], &nIndex[b], sizeof(struct index));
					break;
				
				case 'd':
					if (nIndex[a].value.count > nIndex[b].value.count)
						SwapPtrs(&nIndex[a], &nIndex[b], sizeof(struct index));
						
				default:
					break;
			}
		}
	}
}



/* swap pointers in the sort array */
void SwapPtrs(void *a, void *b, size_t size)
{
	/* function variables */
	void * ptrTemp = NULL;
	
	/* set temp memory*/
	ptrTemp = malloc(size);

	/* quit if memory error */
	if (ptrTemp == NULL)
	{
		printf(ERROR_FORMAT, ERROR_MSG, ERROR_MSG_SP1);
		exit(EXIT_FAILURE); 
	}
	
	/* swap pointers */
	memcpy(ptrTemp,a,size);
	memcpy(a,b,size);
	memcpy(b,ptrTemp,size);
	
	/* release swap memory */
	free(ptrTemp);
}
