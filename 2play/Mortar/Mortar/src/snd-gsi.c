/* 
 * MORTAR
 * 
 * -- sound functions for GSI (the Generic Sound Interface) v0.8
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero Tamminen
 *
 * GSI interface
 * - Copyright (C) W.H.Scholten 1996-1999
 * - See your gsi_interface.c include file for details.
 *
 * NOTES
 * - Works only if GSI server is running on the same machine or
 *   remote machine has same Mortar data dir in same place.
 */

#include <gsi/gsi_interface.c>
#include "mortar.h"

#undef SYNC_WORKS /* doesn't work yet */

static char Songs, *Song[SONGS];
static int Volume, Loaded[SOUNDS];


void snd_init(void)
{
  char *str, name[] = "sample_a";
  int idx;

  if (gsi_init(NULL)) {
#ifdef DEBUG
    fprintf(stderr, "snd-gsi.c/snd_init(): GSI init failed.\n");
#endif
    /* non-fatal */
    return;
  }

#ifdef SYNC_WORKS
  /* select the events we want to receive */
  gsi_enable_events (GSI_EVENTMASK_CHANNEL);
#endif

  str = getcwd(NULL, 0);  /* NULL works for linux only? */
  gsi_chdir(str);
  free(str);

  /* setup midi */
  Song[0] = get_string("intro");
  Song[1] = get_string("menu");
  Song[2] = get_string("battle");
  Song[3] = get_string("over");

  if (Song[0] || Song[1] || Song[2] || Song[3]) {
    str = get_string("volume");
    if (str && atoi(str)) {
      gsi_init_synth(0);
      Volume = gsi_get_volume(GSI_SYNTH);
      gsi_set_volume(GSI_SYNTH, atoi(str));
      Songs = 1;
    }
  }

  /* setup pcm audio */
  gsi_send_commands(1, GSI_CMD_GRAB_PCM);

  /* get settings from the first loaded sample */
  gsi_send_commands(1, GSI_CMD_USE_BEST_PCM_SETTINGS);

  idx = SOUNDS;
  while (--idx >= 0) {

    name[7] = 'a' + idx;
    str = get_string(name);
    if (str) {
      gsi_load_sample(idx, str);
      Loaded[idx] = 1;
    }
  }
}

void snd_exit(void)
{
  if (Volume) {
    gsi_set_volume(GSI_SYNTH, Volume);
  }
  gsi_sync();
  gsi_close();
}


void snd_play(int idx)
{
#ifdef DEBUG
  if (idx < 0 || idx >= SOUNDS) {
    win_exit();
    fprintf(stderr, "snd-gsi.c/snd_play(): illegal sound ID!\n");
    exit(-1);
  }
#endif
  if (Loaded[idx]) {
    /* each sound it's own channel */
    gsi_play_sound(-1, idx, GSI_CMD_PLAY);
  }
}

void snd_flush(void)
{
  /* called every frame */
  gsi_flush();
}

void snd_sync(void)
{
#ifdef SYNC_WORKS
  /* wait for sounds to end */
  for(;;) {
    int  i;

    for (i = 0; i < 256; i++) {
      if (gsi_get_channel_status(i) > 0) {
         break;
       }
     }
    if (i == 256) { 
      break;
    }
    gsi_wait_for_event (-1, 0); /* wait forever */
  }
#endif
}


/* zero 'times' loops the song */
void song_play(int idx, int times)
{
#ifdef DEBUG
  if (idx < 0 || idx >= SONGS) {
    win_exit();
    fprintf(stderr, "snd-gsi.c/song_play(): illegal song ID!\n");
    exit(-1);
  }
#endif
  if (Songs && Song[idx]) {
    gsi_load_song(Song[idx]);
    gsi_play_song(times);
  }
}

void song_stop(void)
{
  gsi_stop_song();
}
