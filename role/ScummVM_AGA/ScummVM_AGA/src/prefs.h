/* Prefs protos for FlashNG */

//#include "game.h"
#ifndef PREFS_H
#define PREFS_H

struct Prefs
{
	int sound, lives, startlevel, status;
    char name[20];
};

int storemodeid(unsigned long modeid);
unsigned long readmodeid(void);
//int LoadHIScores(int rank, struct score *player1);
//int SaveHIScores(int rank, struct score *player1);
//int loaddefaults(struct Prefs *sets);
//int savedefaults(struct Prefs *sets);


#endif
