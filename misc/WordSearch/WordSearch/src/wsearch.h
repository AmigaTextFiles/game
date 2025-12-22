#define Key(x,y) key[(x)*(py+1)+(y)]
#define Puzzle(x,y) puzzle[(x)*(py+1)+(y)]
#define Display(x,y) display[(x)*(max(px,py)+2)+(y)]

#define randint(max) (rand()%((max)+1))

#define PXINIT 9
#define PYINIT 9

#define MAXPUZ 1000

#define MAXWORD 50
#define MAXSIZE 50

/* globals */
extern int w,px,py,filter,rot;
extern char word[MAXWORD][MAXSIZE+1];
extern char *key, *puzzle, *display;
