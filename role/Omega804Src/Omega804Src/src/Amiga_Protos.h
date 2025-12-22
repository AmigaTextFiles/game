/*
 * Amiga_protos.h by Jarkko Vatjus-Anttila
 */

#include "exec/types.h"
#include "amiga.h"

void initscr(void);
void amiga_colours(int custom);
void amiga_busy(int busy);
LONG amiga_req(int centre,UBYTE *text,UBYTE *gadgets,...);
void amiga_about(void);
void endwin(void);
void waddch(WINDOW *win,int c);
//void vwprintw(WINDOW *win,char *format,va_list list);
void draw_cursor(WINDOW *win);
void getyx(WINDOW *win,int *y,int *x);
void werase(WINDOW *win);
void wprintw(WINDOW *win,char *format,...);
void findchar(int c,int *x,int *y);
void printchrs(WINDOW *win,int f,int b,char *s,int l,char a);
void chrsout(WINDOW *win,int y);
void wrefresh(WINDOW *win);
void wmove(WINDOW *win,int y,int x);
WINDOW *newwin(int h,int w,int y,int x);
void wattrset(WINDOW *win,int attr);
void touchwin(WINDOW *win);
void scrollok(WINDOW *win,int ok);
void wstandout(WINDOW *win);
void wstandend(WINDOW *win);
void waddstr(WINDOW *win,char *s);
void clear(void);
void printw(char *format,...);
void move(int y,int x);
void refresh(void);
int wgetch(WINDOW *win);
int getch(void);
void noecho(void);
void crmode(void);
char *getlogin(void);
int getpid(void);
int chown(char *o,int u,int g);
int file_req(char *buffer);
int wbmain(struct WBStartup *wbmsg);
