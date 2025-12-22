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



/* compare incoming data to existing nodes and add new nodes */
void BuildList(struct list *sList, char *buffer)
{
	/* funcation variables */
	int missFlag = 1;
	struct node *current_node = NULL;

	/* set to list pointer start value */
	current_node = sList->start;

	/* walk through list */
	while (current_node)
	{
		/* check for a match with an existing node - if so, subtract one from missFlag */
		if (strcmp(current_node->item, buffer) == 0)
		{
			current_node->count++;
			missFlag--;
		}

		/* if not, advance to the next node */
		current_node = current_node->next;
	}

	/* create a node for new list data - if missFlag is still true */
	if (missFlag)
		Push(sList, buffer);
}


/* walk through list to calculate gathered data stats */
void  CalculateListStats(struct list *sList)
{
	/* funcation variables */
	struct node *current_node = sList->start;

	while (current_node)
	{
		sList->itemCount += current_node->count;
		sList->nodeCount++;
		current_node = current_node->next;
	}

}



/* initialize list pointer */
void InitList(struct list *sList, const char *name)
{
	/* function variables */
	int i = 0;
	int length = strlen(name);

	/* list name - initialize and set value */
	for ( ; i < NAME_SIZE + 1; i++)
		sList->name[i] = '\0';

	if ((length > 0) & (length < NAME_SIZE))
		strcpy(sList->name, name);

	/* list stats - set values */
	sList->itemCount = 0;
	sList->nodeCount = 0;

	/* list start - set value */
        sList->start = NULL;
}



/* remove node from list pointer */
void Pop(struct list *sList)
{
	if (sList->start != NULL)
	{
		struct node *tempNode = sList->start;
		sList->start = sList->start->next;
		free(tempNode);
	}
}


/* initialize and set node to list pointer */
void Push(struct list *sList, char *buffer)
{
	/* function variables */
	int i = 0;
	int length = strlen(buffer);
	struct node *tempNode = (struct node *)malloc(sizeof(struct node));

	/* node item - initialize and set value */
	for ( ; i < NAME_SIZE + 1; i++)
		tempNode->item[i] = '\0';

	if ((length > 0) & (length < NAME_SIZE))
		strcpy(tempNode->item, buffer);

	/* node count - initialize and set value */
	tempNode->count = 1;

	/* set node next pointer to previous node */
	tempNode->next = sList->start;

	/* set list pointer to node */
	sList->start = tempNode;
}



/* unload list from memory */
void UnloadList(struct list *sList)
{
	/*	function variable */
	struct node *current_node = sList->start;

	/* walk through list to pop one node off at a time */
	while (current_node)
	{
		Pop(sList);
		current_node = sList->start;
	}
}
