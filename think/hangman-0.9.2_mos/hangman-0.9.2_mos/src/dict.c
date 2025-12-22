/*
 *  Copyright (C) 2004 Tom Bradley
 *  tojabr@shiftygames.com
 *
 *  file: dict.c
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2, or (at your option)
 *  any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software Foundation,
 *  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 */

#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <stdio.h>
#include <time.h>

size_t sizeOfTable  = 3;
size_t numOfEntries = 0;

extern unsigned int longest_word;
extern unsigned int shortest_word;

struct node {
	char * word;
	struct node * next;
};

static struct node ** dictionary = 0;

static void addToDictionary(char * word);

/*****************************************************
 ****************************************************/
static int hashWord(char * word)
{
        size_t n = strlen(word), h = 0, g, l;

        for (l = n; l > 0; --l) {
                h = (h << 4) + word[n-l];
                if ((g = h & 0xf0000000)) {
                        h = h ^ (g >> 24);
                        h = h ^ g;
                }
        }

        return (h & 0xfffffff) % sizeOfTable;
}

/*****************************************************
 ****************************************************/
char * getWord()
{
	struct node * ptr = NULL, * pptr = NULL;
	int i, j;
#ifndef __MORPHOS__
	i = random()%sizeOfTable;
#else
	i = rand()%sizeOfTable;
#endif
	
	ptr = dictionary[i];
	while(!ptr) {
		i++;
		ptr = dictionary[i];
	}
#ifndef __MORPHOS__
	while(ptr && random() % 100 == 0) {
#else
	while(ptr && rand() % 100 == 0) {
#endif
		pptr = ptr;
		ptr = ptr->next;
	}
	
	return ptr->word;
}

/*****************************************************
 ****************************************************/
static void resize()
{
#ifdef __MORPHOS__
	struct node ** old_table;
	size_t i;
#endif
	unsigned int a;
        size_t old_size = sizeOfTable;
        sizeOfTable *= 2;
        numOfEntries = 0;
#ifndef __MORPHOS__
        struct node ** old_table = dictionary;
#else
        old_table = dictionary;
#endif

        dictionary = (struct node **)malloc(sizeof(struct node *) * sizeOfTable);
        if(!dictionary) {
	}
	/* Zero out entries */
	for(a = 0; a < sizeOfTable; a++)
		dictionary[a] = 0;

        /* now copy old table into new table
	   and delete the old one */
#ifndef __MORPHOS__
        for(size_t i = 0; i < old_size; i++) {
#else
        for(i = 0; i < old_size; i++) {
#endif
		struct node * d = NULL, * t = old_table[i];
		while(t) {
			addToDictionary(t->word);
			d = t;
			t = t->next;
			free(d->word);
			free(d);
		}
	}
	free(old_table);
}

/*****************************************************
 ****************************************************/
static void addToDictionary(char * word)
{
	struct node * ptr = NULL, * pptr = NULL;
	int slot = hashWord(word);

	ptr = dictionary[slot];
	while(ptr) {
		pptr = ptr;
		ptr = ptr->next;
	}

	ptr = (struct node *)malloc(sizeof(struct node));
	if(!ptr) {
		fprintf(stderr, "Error: Out of Memory.\n");
		exit(1);
	}
	if(pptr)
		pptr->next = ptr;
	else
		dictionary[slot] = ptr;

	ptr->next = 0;
	ptr->word = (char*)malloc(strlen(word) + 1);
	if(!ptr->word) {
		fprintf(stderr, "Error: Out of Memory.\n");
		exit(1);
	}

	strncpy(ptr->word, word, strlen(word));
	ptr->word[strlen(word)] = 0;
	numOfEntries++;

        if(numOfEntries > sizeOfTable * 5)
                resize();
}


/*****************************************************
 ****************************************************/
static void buildTree(char * filename)
{
#ifdef __MORPHOS__
	size_t i;
#endif
	FILE * input = NULL;
	unsigned int a;

	/* Delete the old dictionary if one exists */
	if(dictionary) {
#ifndef __MORPHOS__
		for(size_t i = 0; i < sizeOfTable; i++) {
#else
		for(i = 0; i < sizeOfTable; i++) {
#endif
			struct node * t = dictionary[i];
			while(t) {
				free(t->word);
				free(t);
			}
			dictionary[i] = 0;
		}

		free(dictionary);
	}
        dictionary = (struct node **)malloc(sizeof(struct node *) * sizeOfTable);
        if(!dictionary) {
		printf("oops\n");
	}

	/* Zero out entries */
	for(a = 0; a < sizeOfTable; a++)
		dictionary[a] = 0;

	input = fopen(filename, "r");
	if(!input) {
		fprintf(stderr, "Error: file %s doesn't exist.\n", filename);
		exit(1);
	}

	while(!feof(input)) {
		char word[256];
		int i;

		fscanf(input, "%s", word);

		if(!isupper(word[0]) && strlen(word) < longest_word && strlen(word) > shortest_word)
			addToDictionary(word);
	}

	fclose(input);
}


/*****************************************************
 ****************************************************/
void initDictionary(char * filename)
{
	printf("Using dictionary: %s\n", filename);
#ifndef __MORPHOS__
	srandom(time(0));
#else
	srand(time(0));
#endif
	buildTree(filename);
}

