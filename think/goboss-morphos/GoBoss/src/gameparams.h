#ifndef _GAMEPARAMS_H
#define _GAMEPARAMS_H

typedef struct {
  int fullscreen;
  int gg_play[2];
} GameParams;

GameParams getParamsFromArgs (int argc, char **argv);

#endif