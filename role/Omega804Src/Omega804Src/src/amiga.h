/* amiga.h */

#ifndef AMIGA_H
#define AMIGA_H

struct _win_st
{
  int _cury, _curx;
  int _maxy, _maxx;
  int _offy, _offx;
  int *_text;
  int *_disp;
  char *_lines;
  char _attr;
};

typedef struct _win_st WINDOW;

extern int LINES;
extern int COLS;

extern WINDOW *stdscr;
extern WINDOW *curscr;

#endif /* AMIGA_H */
