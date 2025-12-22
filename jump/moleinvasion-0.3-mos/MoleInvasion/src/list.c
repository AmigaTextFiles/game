/* MoleInvasion 0.1 - Copyright (C) 2004 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */

#include <assert.h>
#include <string.h>
#include "list.h"

myList * InitList()
{	myList *ret;

	ret=(myList*)malloc(sizeof(myList));
	ret->size=0;
	ret->elt=NULL;
	return ret;
}

void FreeList(myList * list)
{	int i;
	if(!list)
		return;
	if(list->elt)
		for(i=0;i<list->size;i++)
			free(list->elt[i].value);
	free(list->elt);
	free(list);
}

void AddToList(myList * list,void * value, unsigned int sizeofvalue)
{	
	assert(list);
	assert(value);
	list->elt=(myElt*)realloc(list->elt,sizeof(myElt)*(1+list->size));
	
	list->elt[list->size].value=(void*)malloc(sizeofvalue);
	memcpy(list->elt[list->size].value,value,sizeofvalue);
	
	list->size++;
}

int RemoveFromList(myList * list,unsigned int pos)
{	
	assert(list);
	if(pos>=list->size)
		return 0;

	free(list->elt[pos].value);

	while(pos+1<list->size)
	{	list->elt[pos].value=list->elt[pos+1].value;
		pos++;
	}
	
	list->size--;

	return 1;
}

void * GetPosList(myList * list,unsigned int pos)
{	
	assert(list);
	if(pos>=list->size)
		return NULL;
	
	return list->elt[pos].value;
}
