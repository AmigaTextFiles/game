/*
 *  Copyright (C) 2004 Tom Bradley
 *  tojabr@shiftygames.com
 *
 *  file: perm.c
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

struct node {
	char * word;
	struct node * next;    /* Next in the dictionary */
	struct node * m_next;  /* Next in the master word list */
};


static struct node ** dictionary = 0; /* collection of all words */
size_t sizeOfTable  = 3;
size_t numOfEntries = 0;

char * currentWordSet[500]; /* list of current words to find */
int numberCurrentWords = 0;

struct node * masterWordList = 0; /* list of all six letter words */
int masterWordCount = 0;
struct node * tail = 0;

/*****************************************************
 ****************************************************/
static void quit()
{
	SE_Quit();
}

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
 Look up a word in the dictionary
 ****************************************************/
int findWord(char * word, int n)
{
	struct node * ptr = 0;
	int slot = hashWord(word);
	
	ptr = dictionary[slot];
	while(ptr) {
		if(strncmp(word, ptr->word, n) == 0) {
			return 1;
		}

		ptr = ptr->next;
	}

	return 0;
}

static void resize();

/*****************************************************
add a word to the dictionary
 ****************************************************/
static void addToDictionary(char * word)
{
	struct node * ptr = 0, * pptr = 0;
	int slot = hashWord(word);

	ptr = dictionary[slot];
	while(ptr) {
		pptr = ptr;
		ptr = ptr->next;
	}

	ptr = (struct node *)malloc(sizeof(struct node));
	if(!ptr) {
		SE_Error("Out of Memory.");
		quit();
	}

	if(pptr)
		pptr->next = ptr;
	else
		dictionary[slot] = ptr;

	ptr->next = 0;
	ptr->word = (char *)malloc(sizeof(char) * (strlen(word) + 1) );
	if(!ptr->word) {
		SE_Error("Out of Memory.");
		quit();
	}

	strncpy(ptr->word, word, strlen(word));
	ptr->word[strlen(word)] = 0;

	numOfEntries++;

        if(numOfEntries > sizeOfTable * 5)
                resize();

	if(strlen(word) == 6) {		
		masterWordCount++;
		
		if(masterWordList) {
			ptr->m_next  = 0;
			tail->m_next = ptr;
			tail         = ptr;
		} else {
			masterWordList = tail = ptr;
		}
	}
}


/*****************************************************
 ****************************************************/
static void resize()
{
#ifdef __MORPHOS__
	struct node ** old_table;
#endif

	unsigned int a;
        size_t old_size = sizeOfTable, i;
        sizeOfTable *= 2;
        numOfEntries = 0;
#ifdef __MORPHOS__
	old_table = dictionary;
#else
        struct node ** old_table = dictionary;
#endif

        dictionary = (struct node **)malloc(sizeof(struct node *) * sizeOfTable);
        if(!dictionary) {
		SE_Error("resize failed. Out of memory.");
		SE_Quit();
	}

	/* Zero out entries */
	for(a = 0; a < sizeOfTable; a++)
		dictionary[a] = 0;

        /* now copy old table into new table
	   and delete the old one */
        for(i = 0; i < old_size; i++) {
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
static void buildTree(char * filename)
{
	FILE * input = NULL;
	unsigned int a;
	size_t i;

	/* Delete the old dictionary if one exists */
	if(dictionary) {
		for(i = 0; i < sizeOfTable; i++) {
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
		SE_Error("Out of memory.");
		SE_Quit();
	}

	/* Zero out entries */
	for(a = 0; a < sizeOfTable; a++)
		dictionary[a] = 0;

	input = fopen(filename, "r");
	if(!input) {
		SE_Error("file %s doesn't exist.", filename);
		SE_Quit();
	}

	while(!feof(input)) {
		char word[256];
		int i, allalpha = 1;

		fscanf(input, "%s", word);

		for(i = 0; i < strlen(word); i++) {
			if(!isalpha(word[i])) {
				allalpha = 0;
			}
		}

		if(strlen(word) >= 3 && strlen(word) <= 6 && allalpha) {
			// change to lower cases
			for(i = 0; i < strlen(word); i++)
				word[i] = tolower(word[i]);
			addToDictionary(word);
			allalpha = 1;
		}
	}

	fclose(input);
}


/*****************************************************
 Check if a word is in the main dictionary, if it is
 add it to the temporary one for the current 
 word
 ****************************************************/
static void checkIfWord(char * a, int n)            
{
	int i;

	a[n] = 0;

	if(findWord(a, n)) {
		for(i = 0; i < numberCurrentWords; i++)
			if(!currentWordSet[i] || strncmp(currentWordSet[i], a, n) == 0)
				return;
		
		currentWordSet[i] = (char*)malloc(sizeof(char) * (n + 1));
		if(!currentWordSet[i]) {
			SE_Error("Out of Memory.");
			quit();
		}

		strncpy(currentWordSet[i], a, n);

		currentWordSet[i][n] = 0;

		numberCurrentWords++;
	}
}

/*****************************************************
 ****************************************************/
static void permutation(char * a, int n)
{
	unsigned int i, j;
	char p[n + 1], tmp;

	//printf("%s %d\n", a, n);
	checkIfWord(a, n);

	for(i = 0; i <= n; i++)
		p[i] = i;

	i = 1;
	//printf("loop\n");
	while(i < n) {
		p[i]--;
		j = i % 2 * p[i];

		tmp = a[j]; 
		a[j] = a[i]; 
		a[i] = tmp;

		//printf("%s  %d\n", a, i);
		checkIfWord(a, n);
		i = 1;
		while (!p[i]) {
			p[i] = i;
			i++; //compilier optimized these two lines into the error, broke into 2 lines
		}
		//printf("after = %d\n", i);
	}
}

/*****************************************************
 ****************************************************/
static void combination(char * letters)
{
        int i, j, k, l, m, n;
	char word[6];

        /* find all 3 letters combinations */
        for(i = 0; i < 4; i ++) {
                for(j = i + 1; j < 5; j ++) {
                        for(k = j + 1; k < 6; k++) {
				word[0] = letters[i];
				word[1] = letters[j];
				word[2] = letters[k];
				word[3] = 0;
				permutation(word, 3);
                        }
                }
        }

        /* find all 4 letters combinations */
        for(i = 0; i < 3; i ++) {
                for(j = i+1; j < 4; j ++) {
                        for(k = j+1; k < 5; k++) {
                                for(l = k+1; l < 6; l++) {
					word[0] = letters[i];
					word[1] = letters[j];
					word[2] = letters[k];
					word[3] = letters[l];
					permutation(word, 4);
                                }
                        }
                }
        }

        /* find all 5 letters combinations */
        for(i = 0; i < 2; i ++) {
                for(j = i+1; j < 3; j ++) {
                        for(k = j+1; k < 4; k++) {
                                for(l = k+1; l < 5; l++) {
                                        for(m = l+1; m < 6; m++) {
						word[0] = letters[i];
						word[1] = letters[j];
						word[2] = letters[k];
						word[3] = letters[l];
						word[4] = letters[m];
						permutation(word, 5);                        
					}
                                }
                        }
                }
        }
	
	/* find all 6 letter words */
	strncpy(word, letters, 6);
	permutation(word, 6);
}


/*****************************************************
 ****************************************************/
static char * getMasterWord()
{
	struct node * j = masterWordList;
#ifdef __MORPHOS__
	int i = rand() % masterWordCount;
#else
	int i = random() % masterWordCount;
#endif
	for(; i >= 0; i--) {
		j = j->m_next;
		if(j == 0)
			j = masterWordList;
	}

	return j->word;
}

/*****************************************************
 ****************************************************/
void getWord(char * letters)
{
	int i;

	do {
		for(i = 0; i < numberCurrentWords; i++)
			free(currentWordSet[i]);
		numberCurrentWords = 0;
		
		strncpy(letters,getMasterWord(), 6);

		combination(letters);
	} while (numberCurrentWords <= 6);


	/* Mix up the letters */
	for(i = 0; i < rand() % 100; i++) {
		char tmp;
		int a = rand()%6, b = rand()%6;
		tmp = letters[a];
		letters[a] = letters[b];
		letters[b] = tmp;
	}
}

/*****************************************************
 ****************************************************/
void initDictionary(char * name)
{
	buildTree(name);
}

