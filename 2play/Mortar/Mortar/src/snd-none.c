/* 
 * MORTAR
 * 
 * -- dummy sound stubs for no sound
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero Tamminen
 */

#include <stdio.h>
#include "mortar.h"

void snd_init(void)  {}
void snd_flush(void) {}
void snd_sync(void)  {}
void snd_exit(void)  {}
void song_stop(void) {}
void song_play(int idx, int times) {}

void snd_play(int idx)
{
#ifdef DEBUG
  if (idx < 0 || idx >= SOUNDS) {
    win_exit();
    fprintf(stderr, "snd-none.c/snd_play(): illegal sound ID!\n");
    exit(-1);
  }
#endif
}
