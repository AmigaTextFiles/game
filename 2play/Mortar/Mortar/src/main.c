/* 
 * MORTAR
 * 
 * -- main loop: option parsing, initializations
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero Tamminen
 */

#include <stdio.h>
#include <stdlib.h>
#include "mortar.h"

/* where everything is draw */
m_image_t *Screen;
int CycleColor;

/* toggle to palette optimizing for monochrome */
int Makemono = 0;

/* configuration file variables */
int TimeFrame, TimeInput;

#define OPT_CHAR  '-'


static int main_init(int argc, char *argv[])
{
  char *path, *conf, *lang;
  int wd, ht, rounds;

  wd = ht = rounds = 0;

#ifdef CONFIG_PATH
  path = CONFIG_PATH;
#else
  path = NULL;
#endif  
  conf = CONFIG_FILE;
  lang = NULL;
#ifdef AMIGA
  init_amiga();
#endif


  while (argc >= 1 && argv[0][0] == OPT_CHAR) {

    /* no option arg or not a single letter option? */
    if (argc < 2 || argv[0][2]) {
      if (path) {
        chdir(path);
      }
      if (!msg_language(lang)) {
        return 0;
      }
      msg_print(MSG_USAGE);
      return 0;
    }
    argv++;

    switch ((argv-1)[0][1]) {

#ifndef CONFIG_PATH
    case 'c':
      conf = *argv;
      break;

    case 'p':
      path = *argv;
      break;

    case 'l':
      lang = *argv;
      break;
#endif

    case 'w':
      wd = atoi(*argv);
      break;

    case 'h':
      ht = atoi(*argv);
      break;

    case 'r':
      rounds = atoi(*argv);
      break;

    default:
      if (path) {
        chdir(path);
      }
      if (!msg_language(lang)) {
        return 0;
      }
      msg_print(MSG_USAGE);
      return 0;
    }
    argc -= 2;
    argv++;
  }

  if (path) {
    /* change to data directory so that file loading
     * functions don't need to care about path
     * separators etc.
     */
    chdir(path);
  }
  if (!read_config(conf)) {
    if (!msg_language(lang)) {
      return 0;
    }
    msg_print(ERR_CONFIG);
    msg_print(MSG_USAGE);
    return 0;
  }

  /* load game strings and messages
   */
  if (lang) {
    if (!msg_language(lang)) {
      return 0;
    }
  } else {
    if (!msg_language(get_string("language"))) {
      return 0;
    }
  }
  msg_print(MSG_WELCOME);

  /* global configuration variables */
  TimeFrame = get_value("frame_time");
  TimeInput = get_value("input_time");

  if (!(TimeFrame && TimeInput)) {
    msg_print(ERR_VARS);
    return 0;
  }

  if (argc < 2 || argc > MAX_PLAYERS) {
    msg_print(MSG_USAGE);
    msg_print(ERR_PLAYERS);
    return 0;
  }

  if (!game_init(argc, argv)) {
    return 0;
  }


  /* command line overrides configuration file */
  if (rounds <= 0) {
    rounds = get_value("rounds");
  }
  if (wd <= 0) {
    wd = get_value("width");
  }
  if (ht <= 0) {
    ht = get_value("height");
  }

  /* window size may not be too small */
  if (wd && wd < 160) {
    wd = 160;
  }
  if (ht && ht < 100) {
    ht = 100;
  }

  if (!win_init(&wd, &ht)) {
    msg_print(ERR_WINIT);
    return 0;
  }

  if (!img_init(wd, ht)) {
    win_exit();
    msg_print(ERR_LOADING);
    return 0;
  }

  /* can fail, but that doesn't matter */
  snd_init();

  return (rounds < 1 ? 1 : rounds);
}


int main(int argc, char *argv[])
{
  int rounds, idx;

  rounds = main_init(argc-1, argv+1);
  if (!rounds) {
    return -1;
  }

  SRND(time(NULL));

  /* main loop */
  for (;;) {

    song_play(SONG_INTRO, 0);

    if (!do_intro()) {
      break;
    }

    /* initialize players */
    game_reset();

    idx = rounds;
    while (--idx >= 0) {
      if (!do_game()) {
        break;
      }
      /* wait a bit so that the winner can admire his/her
       * handiwork and others hang their heads in shame...
       */
      sleep(4);
    }

    song_play(SONG_OVER, 1);

    if (!do_gameover()) {
      break;
    }
  }

  game_results();
  song_stop();
  snd_exit();
  win_exit();

  msg_print(MSG_BYE);
  return 0;
}
