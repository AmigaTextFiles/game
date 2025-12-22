/* Timer.Device Functions protos for Flashback

   $VER: Timer.h 0.1 (01.12.2000)

*/

#ifndef TIMER_H
#define TIMER_H

struct timerequest *CreateTimer(ULONG theUnit);
void DeleteTimer(struct timerequest *WhichTimer);
BOOL Temps(struct timeval debut,struct timeval fin,int speed);

#endif
