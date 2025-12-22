/*
 * SDLjump
 * (C) 2005 Juan Pedro Bol�ar Puente
 * 
 * This simple but addictive game is based on xjump. Thanks for its author for
 * making such a great game :-)
 * 
 * tools.c
 */

/*
    Copyright (C) 2003-2004, Juan Pedro Bolivar Puente

    SDLjump is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    SDLjump is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with SDLjump; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

#ifdef __MORPHOS__
#include <machine/types.h>
#endif
#include <dirent.h>

#include "sdljump.h"
#include "tools.h"

extern L_gblOptions gblOps;

long getFileSize(char *fname)
{
    struct stat file;
     
    if(!stat(fname,&file)) {
        return file.st_size;
    }
    
    return 0;
}

int getFps()
{
    switch(gblOps.fps) {
    	case FPSNOLIMIT: return -1; 
    	case FPS100: return 100;
    	case FPS300: return 300;
    	case FPS40: return 40; 
    	default: return -1; 
    }
}

int isOdd(int n)
{
    if (n%2 == 0) 
        return 1;
    else 
        return -1;
}

int bool2sign(int n)
{
    if (n == 0)
        return -1;
    else
        return 1;
}

void pressAnyKey ()
{
	SDL_Event event;
	
	do {
		SDL_WaitEvent(NULL);
		SDL_PollEvent(&event);
	} while (event.type != SDL_KEYDOWN && event.type != SDL_MOUSEBUTTONDOWN);
	
	while (SDL_PollEvent(&event));
}

#ifdef __MORPHOS__
// light implementation of scandir
// sd_select will not be taken care of, as it's given no parameter in this context
// so no preselection will be executed
int scandir (const char *sd_dir, struct dirent ***sd_names, int (*sd_select)(struct dirent *), int (*sd_compare)(const void *, const void *))
{
	unsigned int sd_cntr00;
	struct dirent** sd_dirbuf;
	unsigned int sd_dirbufsize;
	struct dirent* sd_direntptr;
	DIR* sd_dirptr;
	signed int sd_entnr;
	BOOL sd_OK;
	signed int sd_retValue;
	
	
	sd_dirbufsize = 127;
	sd_entnr = 0;
	sd_OK = TRUE;
	
	sd_dirbuf = (struct dirent**)malloc(sd_dirbufsize * sizeof(struct dirent*));
	if (sd_dirbuf == NULL) {
		sd_OK = FALSE;
	} else {
		for (sd_cntr00 = 0; sd_cntr00 < sd_dirbufsize; sd_cntr00++) {
			sd_dirbuf[sd_cntr00] = NULL;
		}
		sd_dirptr = opendir(sd_dir);
		if (sd_dirptr == NULL) {
			sd_OK = FALSE;
		} else {
			while ((sd_direntptr = readdir(sd_dirptr)) != NULL) {
				sd_entnr++;
				if (sd_entnr >= sd_dirbufsize) {
					sd_OK = FALSE;
					fprintf(stderr, "WARNING: Number of entries in folder exceedes maximum (%d).\n", sd_dirbufsize);
				} else {
					sd_dirbuf[sd_entnr - 1] = (struct dirent*)malloc(sizeof(struct dirent));
					if (sd_dirbuf[sd_entnr - 1] == NULL) {
						sd_OK = FALSE;
					} else {
						memcpy(sd_dirbuf[sd_entnr - 1], sd_direntptr, sizeof(struct dirent));
					}
				}
			}
			*sd_names = sd_dirbuf;
			closedir(sd_dirptr);
		}
	}
	
	if (sd_OK == TRUE) {
		sd_retValue = sd_entnr;
	} else {
		sd_retValue = -1;
		for (sd_cntr00 = 0; sd_cntr00 < sd_entnr; sd_cntr00++) {
			free(sd_dirbuf[sd_cntr00]);
		}
		free(sd_dirbuf);
	}
	
	return sd_retValue;
}


int alphasort (const void *as_name1, const void *as_name2)
{
	int as_retValue = 0;
	
	
	
	return as_retValue;
}
#else
#ifdef WIN32
	#include "win/scandir.c"
#endif
#endif

int getDirList(char* folder, char*** tab)
{
	struct dirent **namelist;
    struct stat buf;
	char sbuf[256];
    int n;
	int r=0;


    n = scandir(folder, &namelist, 0, alphasort);
    if (n < 0)
        fprintf(stderr,"WARNING: Theme folder (%s) doesn't exist.\n",folder);
    else {
		while(n--) {
#ifdef __MORPHOS__
			sprintf(sbuf,"%s%s/",folder,namelist[n]->d_name);
#else
			sprintf(sbuf,"%s/%s",folder,namelist[n]->d_name);
#endif
			stat(sbuf, &buf);
			if (S_ISDIR(buf.st_mode) 
			&& (strcmp(namelist[n]->d_name, ".") != 0)
			&& (strcmp(namelist[n]->d_name, "..") != 0)) {
				*tab = realloc(*tab, sizeof(char*)*(r+1));
				if (((*tab)[r] = malloc(sizeof(char)*strlen(namelist[n]->d_name)+1)) != NULL) {
					strcpy((*tab)[r], namelist[n]->d_name);
				}
				r++;
			}
           	free(namelist[n]);
       	}
       	free(namelist);
	}
	return r;
}

int getFileList(char* folder, char*** tab)
{
	struct dirent **namelist;
//    struct stat buf;
	char sbuf[256];
    int n;
	int r=0;


    n = scandir(folder, &namelist, 0, alphasort);
    if (n < 0)
        fprintf(stderr,"WARNING: Theme folder (%s) doesn't exist.\n",folder);
    else {
		while(n--) {
#ifdef __MORPHOS__
			sprintf(sbuf,"%s%s",folder,namelist[n]->d_name);
#else
			sprintf(sbuf,"%s/%s",folder,namelist[n]->d_name);
#endif
			if ((strcmp(namelist[n]->d_name, ".") != 0)
			&& (strcmp(namelist[n]->d_name, "..") != 0)) {
				*tab = realloc(*tab, sizeof(char*)*(r+1));
				if (((*tab)[r] = malloc(sizeof(char)*strlen(namelist[n]->d_name)+1)) != NULL) {
					strcpy((*tab)[r], namelist[n]->d_name);
				}
				r++;
			}
           	free(namelist[n]);
       	}
       	free(namelist);
	}
	return r;
}

int sumStringTabs(char*** a, int an, char** b, int bn)
{
	int i;
	
	if ( (*a = realloc(*a, sizeof(char*)*(an+bn))) != NULL) {
		for (i = an; i < an+bn; i++) {
			(*a)[i] = b[i-an];
		}
		return i;
	} else {
		return 0;
	}
}

#ifdef __MORPHOS__
int sumStringTabs_Cat(char*** a, int an, char** b, int bn, char* string, BOOL directory_yn)
#else
int sumStringTabs_Cat(char*** a, int an, char** b, int bn, char* string)
#endif
{
	int i;
	char* newstr = NULL;
	if ( (*a = realloc(*a, sizeof(char*)*(an+bn))) != NULL) {
		for (i = an; i < an+bn; i++) {
		 	newstr = malloc(sizeof(char)*(strlen(string)+strlen(b[i-an])+2));
		 	strcpy(newstr,string);
#ifdef __MORPHOS__
		 	strcat(newstr,b[i-an]);
			if (directory_yn == TRUE) {
				strcat(newstr,"/");
			}
#else
			strcat(newstr,"/");
		 	strcat(newstr,b[i-an]);
#endif
			(*a)[i] = newstr;
		}
		return i;
	} else {
		return 0;
	}
}

int checkExtension(char* file, char* ext)
{
	int i, j;
	
	for (i = strlen(file)-1, j = 0; i >= 0 && j < strlen(ext); i--, j++)
		if (ext[ strlen(ext)-j-1 ] != file[ i ]) return FALSE;
	
	if (j == strlen(ext)) return TRUE;
	
	return FALSE;
}

//==============================================================================
// FADER
//==============================================================================

void setFader(fader_t* fader, int start, int target, int time, int loop)
{
	fader->value = fader->start = start;
	fader->target = target;
	fader->time = time;
	fader->loop = loop;
}

int updateFader(fader_t* fader, int ms)
{
	int swap;
	fader->value += fader->delta = (fader->target - fader->start)/fader->time * ms;
	if ((fader->target > fader->start && fader->value > fader->target)
	  || (fader->target < fader->start && fader->value < fader->target)) {
		fader->value = fader->target;
		fader->delta = 0;
		if (fader->loop) {
			swap = fader->start;
			fader->start = fader->target;
			fader->target = swap;
		}
		return TRUE;
	} 
	//if (fader->delta < 1) fader->delta = 1;
	return FALSE;
}

//==============================================================================
// RANDOM
//==============================================================================

int rnd( int range )
{
  return (float)rand() / RAND_MAX * range;
}

void srnd( void )
{
  srand( time(NULL) );
}

//==============================================================================
// FILE READING & WRITING
//==============================================================================

void putValue_int(FILE* tfile, char* data, int value)
{
    fprintf(tfile," %s = %d \n", data, value);
}

void putValue_str(FILE* tfile, char* data, char* value)
{
    fprintf(tfile," %s = \"%s\" \n", data, value);
}

void putComment(FILE* tfile, char* comment)
{
    fprintf(tfile,"# %s \n", comment);
}

void putLine(FILE* tfile)
{
    fprintf(tfile,"\n");
}

void findNextValue(FILE* tfile)
{
    char empty[MAX_CHAR];
    char c;
        
    fscanf(tfile, "%[ \n\t\f\r]",empty);
    c = getc(tfile);
    if (c == '#') {
        //fscanf(tfile, "%[^\n\f\r]",empty);
        fgets(empty,MAX_CHAR,tfile);
        findNextValue(tfile);
    }
    else {
        //fseek(tfile,-1,SEEK_CUR);
        ungetc(c,tfile);
    }
}

void skipValueStr(FILE* tfile)
{
    char str[MAX_CHAR];
    
    findNextValue(tfile);
    fscanf(tfile, "%[^\n\t\f\r =]",str);
	fscanf(tfile, "%[= \n\t\f\r]",str);
	fscanf(tfile, "\"%[^\"]\"", str);
}

int getValue_int(FILE* tfile, char * value)
{
    char tvalue[MAX_CHAR];
    char empty[MAX_CHAR];
    int data;
    
    findNextValue(tfile);
    fscanf(tfile, "%[^\n\t\f\r =]",tvalue);
    if (!strcmp(value,tvalue)) {
        fscanf(tfile, "%[= \n\t\f\r]",empty);
        fscanf(tfile, "%i", &data);
        return data;
    } else {
        printf("ERROR: Value Mismatch ('%s' expected but '%s' obtained)\n",value,tvalue);
        return 0;
    }
}

float getValue_float(FILE * tfile, char * value)
{
    char tvalue[MAX_CHAR];
    char empty[MAX_CHAR];
    float data;
    
    findNextValue(tfile);
    fscanf(tfile, "%[^\n\t\f\r =]",tvalue);
    if (!strcmp(value,tvalue)) {
        fscanf(tfile, "%[= \n\t\f\r]",empty);
        fscanf(tfile, "%f", &data);
        return data;
    } else {
        printf("ERROR: Value Mismatch ('%s' expected but '%s' obtained)\n",value,tvalue);
        return 0;
    }   
}

void getValue_str(FILE * tfile, char * value, char * data, char* path)
{
    char tvalue[MAX_CHAR];
    char empty[MAX_CHAR];
    char info[MAX_CHAR];
    
    findNextValue(tfile);
    fscanf(tfile, "%[^\n\t\f\r =]",tvalue);
    if (!strcmp(value,tvalue)) {
        fscanf(tfile, "%[= \n\t\f\r]",empty);
        fscanf(tfile, "\"%[^\"]\"", info);
        // If the string is a path, we add the data folder path before.
        if(path != NULL) {
#ifdef __MORPHOS__
            sprintf(data,"%s%s", path, info);
#else
            sprintf(data,"%s/%s", path, info);      
#endif
        } else {
            sprintf(data,"%s", info);
        }
        return;
    } else {
        printf("ERROR: Value Mismatch ('%s' expected but '%s' obtained)\n",value,tvalue);
        return;
    }   
}

char* getValue_charp(FILE * tfile, char * value)
{
    char tvalue[MAX_CHAR];
    char empty[MAX_CHAR];
    char info[MAX_CHAR];
	char* ret = NULL;
    
    findNextValue(tfile);
    fscanf(tfile, "%[^\n\t\f\r =]",tvalue);
    if (!strcmp(value,tvalue)) {
        fscanf(tfile, "%[= \n\t\f\r]",empty);
        fscanf(tfile, "\"%[^\"]\"", info);

		ret = malloc(sizeof(char)*(strlen(info)+1));
		strcpy(ret,info);
		
        return ret;
    } else {
        printf("ERROR: Value Mismatch ('%s' expected but '%s' obtained)\n",value,tvalue);
        return NULL;
    }   
}
