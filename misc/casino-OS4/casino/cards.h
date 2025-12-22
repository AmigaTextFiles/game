#ifndef __CARDS_H__
#define __CARDS_H__

#include <Fl/Fl_GIF_Image.h>

#define TREFF 0
#define PIKK  1
#define HART  2
#define ROMB  3

#define PIKK2  (1*4+PIKK)
#define ROMB10 (9*4+ROMB)

extern int order[52];
extern int state[52];
extern int ondesk[52];
extern int ondesksel[52];
extern int ondesknr;
extern int mine[3];
extern int your[3];
extern int minesel[3];
extern int yoursel[3];
extern int minenr,yournr;
extern int score[4];
extern int gamestate;
extern int lastget;
extern int player;

extern int conversion[52];

extern Fl_GIF_Image *cards[52];
extern Fl_GIF_Image *deck;

int init_cards(const char *path);
void init_boxes();
void init_game();
void check_game();
void mixcards();
int draw();

#endif
