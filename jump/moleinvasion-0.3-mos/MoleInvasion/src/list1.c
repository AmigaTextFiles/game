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
{	unsigned int i;
	myElt *save1,*save2;

	assert(list);
	save1=list->elt;
	
	for(i=0;i<list->size;i++)
	{	save2=save1->next;
		assert(save1->value);
		free(save1->value);
		assert(save1);
		free(save1);
		save1=save2;
	}
	free(list);
}

void AddToList(myList * list,void * value, unsigned int sizeofvalue)
{	unsigned int i;
	myElt **save;

	assert(list);
	save=&(list->elt);
	for(i=0;i<list->size;i++)
		save=&((*save)->next);
	(*save)=(myElt*)malloc(sizeof(myElt));
	(*save)->next=NULL;
	(*save)->value=(void*)malloc(sizeofvalue);
	memcpy((*save)->value,value,sizeofvalue);
	
	list->size++;
}

int RemoveFromList(myList * list,unsigned int pos)
{	unsigned int i;
	myElt **save1,*save2;
	
	assert(list);
	if(pos>=list->size)
		return 0;
	save1=&(list->elt);
	for(i=0;i<pos;i++)
		save1=&((*save1)->next);
	
	save2=*save1;
	assert(save2);
	*save1=(*save1)->next;
	free(save2);
	list->size--;
	return 1;
}

void * GetPosList(myList * list,unsigned int pos)
{	unsigned int i;
	myElt *save;
	
	assert(list);
	if(pos>=list->size)
		return 0;
	save=list->elt;
	for(i=0;i<pos;i++)
		save=save->next;
	
	return save->value;
}
