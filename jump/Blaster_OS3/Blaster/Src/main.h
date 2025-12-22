// main.h - Copyright (C) 2003 Oliver Pearce, see COPYING for details

#ifndef _MAIN_
#define _MAIN_

#include "coRect.h"
#include <SDL/SDL.h>

void DrawIMG(SDL_Surface *img, int x, int y);
void DrawBG();
void DrawScene();
void spriteKoll(CoRect* s1, CoRect* s2);
bool waffenKoll (CoRect* sprite);
void einfuellen(int x, int y, int w, int h, int typ, int x2, int y2);
void parseLevel();
int InitImages();
int initSounds();
void DrawIMG(SDL_Surface *img, int x, int y, int w, int h, int x2, int y2);
bool showStart(int param);
int mainLoop();
void reset();
void playSound(int code);
void waitForPlayer(int message = 3, int level = 1);
void showZwischentitel();
void saveScore();
void loadSave();
void loadSaveDefault();
void resetSave();
void saveLevel();

#endif
