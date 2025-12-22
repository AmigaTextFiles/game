#ifndef GAME_TIMER_H
#define GAME_TIMER_H

#include <devices/timer.h>

typedef struct timerequest timer;

/* timer.c */

timer * OpenTimer (void);
void CloseTimer (timer *timer);

void SetTimer (timer *timer, uint32 secs, uint32 micro);
#define WaitTimer(timer) WaitIO((struct IORequest *)(timer));
void AbortTimer (timer *timer);

#endif /* GAME_TIMER_H */
