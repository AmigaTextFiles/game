/* Curses implementation for Amiga */

#define ERR (-1)

#define KEY_LEFT      (1000)
#define KEY_RIGHT     (1001)
#define KEY_HOME      (1002) /* Ctrl-Up */
#define KEY_END       (1003) /* Ctrl-Down */
#define KEY_DC        (1004)
#define KEY_BACKSPACE (1005)
#define KEY_ENTER     (1006)
#define KEY_PPAGE     (1007) /* Shift-Up */
#define KEY_NPAGE     (1008) /* Shift-Down */
#define KEY_UP        (1009)
#define KEY_DOWN      (1010)
#define KEY_IC        (1011)
#define KEY_HELP      (1012)

#define A_REVERSE   (1)
#define A_UNDERLINE (2)
#define A_BOLD      (4)

#ifndef SIGWINCH
#define SIGWINCH 0
#endif

typedef int chtype;

extern int stdscr, curscr;
extern int COLS, LINES;

void initscr(void);
void endwin(void);
void clear(void);
void refresh(void);
void wrefresh(int s);
void cbreak(void);
void noecho(void);
void nonl(void);
int getch(void);
void move(int y, int x);
void clrtoeol(void);
void addch(char c);
void mvaddch(int y, int x, char c);
void addstr(char* s);
int attron(int a);
int attrset(int a);
void intrflush(int s, int b);
void keypad(int s, int b);
void scrollok(int s, int b);
void* newterm(char* t, FILE* out, FILE* in);
