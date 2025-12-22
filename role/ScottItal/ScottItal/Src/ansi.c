/*
 *  ANSI commands (some AMIGA specific) for Scott-Free, Write to CON:
 *
 *  ===================================================================
 *
 *  Version History AMIGA:
 *  Ver ,     Date,         Author, Comment
 *  -------------------------------------------------------------------
 *  1.0 , 28/07/96, Andreas Aumayr, First public release
 *  1.1 , 01/09/96, Andreas Aumayr, some more codes
 *  ___________________________________________________________________
 */


#include <dos/stdio.h>

#define ESC          "\x1b"
#define CSI          ESC "["
#define CLREOL       CSI "K""\0"
#define CLRSCR       "\x0c""\0"
#define CLRSYS       ESC "c""\0"
#define CURSOR_ON    CSI " p""\0"
#define CURSOR_OFF   CSI "0 p""\0"
#define CURSOR_LEFT  CSI "D""\0"
#define CURSOR_RIGHT CSI "C""\0"
#define DEF_TXTCOL   CSI "39;49m""\0"
#define DEL_CHAR     CSI "P"
#define INS_CHAR     CSI "@"
#define AUTO_WRAP    CSI "?7""\0"
#define AUTO_SCRL    CSI ">1""\0"

#define GREY        0
#define BLACK       1
#define WHITE       2
#define BLUE        3

char str_buf[1024];


struct FileHandle *CON_handle=NULL,*act_hdl=NULL,*env_hdl=NULL;

void WriteCON(char *stringa)
{
    Write((LONG)CON_handle,stringa,strlen(stringa));
}

void cursor(BOOL action)
{
    if (action) WriteCON(CURSOR_ON);
    else WriteCON(CURSOR_OFF);
}

void clrsys(void)
{
    WriteCON(CLRSYS);
    //WriteCON(AUTO_WRAP);
    //WriteCON(AUTO_SCRL);
}

void clrscr(void)
{
    WriteCON(CLRSCR);
}

void clreol(void)
{
    WriteCON(CLREOL);

}

void textcolor(int fg, int bg)
{
    sprintf(str_buf,CSI"0;%d;%dm\0",fg+30,bg+40);
    WriteCON(str_buf);
}

void background(int color)
{
    sprintf(str_buf,CSI">%dm\0",color);
    WriteCON(str_buf);
}

void gotoxy(int x, int y)
{
    sprintf(str_buf,CSI"%d;%dH\0",y,x);
    WriteCON(str_buf);
}

