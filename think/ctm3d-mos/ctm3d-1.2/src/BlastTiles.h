/*
================================
        ColorTileMatch
    Puzzle game written in C
         and with SDL
================================
    Written by BL0CKEDUSER
*/

#ifndef _BLAST_H
#define _BLAST_H

extern void BlastTilesFromMouse(int MouseHitX, int MouseHitY);
extern void BlastTilesFrom(int row, int column);
extern void RecursiveTileBlastFrom(int row, int column, int color);
extern void InitBlastTilesFrom(int row, int column);
extern void BlastTile(int row, int column);

#endif