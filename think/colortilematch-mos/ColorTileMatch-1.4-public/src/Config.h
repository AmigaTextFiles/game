/*
================================
        ColorTileMatch
    Puzzle game written in C
         and with SDL
================================
    Written by BL0CKEDUSER
*/

/*****************************\
 *        Behold the         *
 *      GAME CONSTANTS       *
\*****************************/

#ifndef _CONFIG_H
#define _CONFIG_H

// Game screen size (aspect ratio 4:3, please !)
#define SCREEN_WIDTH 640
#define SCREEN_HEIGHT 480

// Relative tile quantity
#define R_TILE_QTY 5

// Delay, in game frames, between new tiles
#define NEW_TILE_DELAY 6

// Number of different tile colours
#define TILE_TYPES 5

// FPS
#define FPS 30
#define FPSOn 1
#define SHOW_FPS 0

#endif
