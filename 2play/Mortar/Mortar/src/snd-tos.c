/* 
 * MORTAR
 * 
 * -- TOS XBIOS sound effects
 *
 * Original effects from GFA expert v.2,
 * C conversion by Eero Tamminen in 1994.
 */

typedef unsigned char UBYTE;

#define BEGIN   0x80
#define CHANNEL 0x81
#define PAUSE   0x82     /* followed by time in 1/50 seconds */
#define TERMI   0xFF     /* Sound        */
#define NATE    0x00     /*   terminator */

enum REGS {
  R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14
};

/* 14 parameters for the registers 0-13 and
 * tone variations: channel, start, +/-step, end
 */
static UBYTE ding[] = {
  R1,64, R2,1, R3,56, R4,1, R5,0, R6,0, R7,0,
  R8,252, R9,16, R10,16, R11,0, R12,20, R13,20, R14,0,
  TERMI,NATE
};
static UBYTE bell[] = {
  R1,64, R2,0, R3,120, R4,0, R5,0, R6,0, R7,0,
  R8,252, R9,16, R10,16, R11,0, R12,20, R13,20, R14,0,
  TERMI,NATE
};
static UBYTE gong[] = {
  R1,1, R2,5, R3,0, R4,5, R5,2, R6,5, R7,0,
  R8,248, R9,16, R10,16, R11,16, R12,0, R13,20, R14,1,
  TERMI,NATE
};
static UBYTE pieuw[] = {
  R1,1, R2,0, R3,0, R4,0, R5,0, R6,0, R7,0,
  R8,254, R9,16, R10,0, R11,0, R12,0, R13,35, R14,1,
  BEGIN,50, CHANNEL,0,1,100,
  TERMI,NATE
};
static UBYTE zap[] = {
  R1,0, R2,16, R3,0, R4,0, R5,0, R6,0, R7,0,
  R8,252, R9,15, R10,0, R11,0, R12,20, R13,0, R14,4,
  BEGIN,0, CHANNEL,1,1,15,
  PAUSE,1,
  R1,0, R2,16, R3,0, R4,0, R5,0, R6,0, R7,0,
  R8,252, R9,0, R10,0, R11,0, R12,20, R13,0, R14,4,
  TERMI,NATE
};
static UBYTE dlink[] = {
  R1,8, R2,2, R3,12, R4,4, R5,0, R6,0, R7,0,
  R8,252, R9,16, R10,16, R11,0, R12,20, R13,20, R14,9,
  BEGIN,200, CHANNEL,0,-20,0,
  PAUSE,1,
  R1,8, R2,2, R3,12, R4,4, R5,0, R6,0, R7,0,
  R8,252, R9,0, R10,0, R11,0, R12,20, R13,20, R14,9,
  TERMI,NATE
};
static UBYTE shot[] = {
  R1,0, R2,0, R3,0, R4,0, R5,0, R6,0, R7,15,
  R8,199, R9,16, R10,16, R11,16, R12,0, R13,16, R14,0,
  PAUSE,25,
  R1,0, R2,0, R3,0, R4,0, R5,0, R6,0, R7,15,
  R8,199, R9,0, R10,0, R11,0, R12,0, R13,16, R14,0,
  TERMI,NATE
};
static UBYTE explosion[] = {
  R1,0, R2,0, R3,0, R4,0, R5,0, R6,0, R7,31,
  R8,199, R9,16, R10,16, R11,16, R12,0, R13,50, R14,9,
  TERMI,NATE
};
static UBYTE laser[] = {
  R1,100, R2,0, R3,200, R4,0, R5,50, R6,0, R7,31,
  R8,220, R9,16, R10,0, R11,16, R12,127, R13,37, R14,0,
  BEGIN,0, CHANNEL,0,137,200,
  PAUSE,128,
  TERMI,NATE
};
static UBYTE fft[] = {
  R1,42, R2,2, R3,88, R4,4, R5,164, R6,8, R7,0,
  R8,199, R9,16, R10,16, R11,16, R12,106, R13,10, R14,4,
  BEGIN,124, CHANNEL,4,54,164,
  TERMI,NATE
};
static UBYTE thrill[] = {
  R1,86, R2,0, R3,86, R4,0, R5,0, R6,0, R7,0,
  R8,252, R9,16, R10,15, R11,0, R12,50, R13,1, R14,10,
  BEGIN,16, CHANNEL,9,-1,0,
  PAUSE,0,
  R1,86, R2,0, R3,86, R4,0, R5,0, R6,0, R7,0,
  R8,252, R9,0, R10,15, R11,0, R12,50, R13,1, R14,10,
  TERMI,NATE
};

/* -------------------------------------- */

#include <stdio.h>
#include <osbind.h>
#include "mortar.h"

static UBYTE *table[SOUNDS] = {
  dlink,    /* buy item */
  fft,    /* sell item */
  pieuw,    /* accept items */
  shot,   /* tank shooting */
  ding,   /* shield bouncing */
  laser,    /* shield teleporting */
  fft,    /* shield sucking */
  gong,   /* shield damper */
  bell,   /* shot flight event */
  dlink,    /* shot bounce from ground */
  zap,    /* shot splat against ground */
  explosion,  /* shot explosion */
  thrill    /* tank deathcry */
};


void snd_play(int idx)
{
#ifdef DEBUG
  if (idx < 0 || idx >= SOUNDS) {
    win_exit();
    fprintf(stderr, "snd-tos.c/snd_play(): illegal sound ID!\n");
    exit(-1);
  }
#endif
  if (table[idx]) {
    Dosound((void*)table[idx]);
  }
}

void snd_init(void)  {}
void snd_flush(void) {}
void snd_sync(void)  {}
void snd_exit(void)  {}
void song_stop(void) {}
void song_play(int idx, int times) {}
