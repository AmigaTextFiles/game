#include "wand_head.h"

extern int edit_mode;
extern char *edit_screen;
extern char screen[NOOFROWS][ROWLEN+1];

int rscreen(num,maxmoves)
int *maxmoves, num;
{
int  y,ch;
FILE *fp;
char name[50], buffer[80];
char (*row_ptr)[ROWLEN+1] = screen;
if(!edit_mode)
    sprintf(name,"%s/screen.%d",SCREENPATH,num);
else
    {
    if(!edit_screen)
        sprintf(name,"screen");
    else
	sprintf(name,"%s",edit_screen);
    }
fp = fopen(name,"r");
if(fp == NULL)
    {
    if(edit_mode)
	sprintf(buffer,"\nCannot find file %s.\n\n",name);
    else
        sprintf(buffer,"\nFile for screen %d unavailable.\n\n",num) ;
    addstr(buffer);
    }
else
    {
    for(y = 0;y<NOOFROWS;y++)
        {
        fgets((*row_ptr++),ROWLEN + 1,fp);
#ifndef AMIGA
	/* for some reason Amiga Lattice C behaves differently here */
	/* Amiga already removed the newline character */
	fgetc(fp);                         /* remove newline char*/
#endif
	}
    /* skip over final line, then read number of moves permitted */
    while ( (ch = fgetc(fp)) != '\n' && ch != EOF) {}
    if(fscanf(fp,"%d",maxmoves) != 1)
	*maxmoves=0;
    fclose(fp);
    }
return (fp == NULL);
}

int wscreen(num,maxmoves)
int maxmoves, num;
{
int  y,x;
FILE *fp;
char name[50];
char (*row_ptr)[ROWLEN+1] = screen;
if(!edit_screen)
    sprintf(name,"screen");
else
    sprintf(name,"%s",edit_screen);
fp = fopen(name,"w");
if(fp == NULL)
    {
#ifdef AMIGA
    strcpy(name, "ram:screenfile");
#else
    sprintf(name,"/tmp/screen.%d",getpid());
#endif
    fp = fopen(name,"w");
    move(21,0);
    addstr("Written file is ");
    addstr(name);
    refresh();
    }
if(fp == NULL)
    addstr("\nFile for screen cannot be written.\n\n") ;
else
    {
    for(y = 0;y<NOOFROWS;y++)
        {
	for(x = 0;x<ROWLEN;x++)
	    fputc(row_ptr[y][x],fp);
	fputc('\n',fp);
	};
    for(x = 0; x<ROWLEN;x++)
	fputc('#',fp);
    fputc('\n',fp);
    if(maxmoves != 0)
	fprintf(fp,"%d\n",maxmoves);
    fclose(fp);
    };
return (fp == NULL);
}
