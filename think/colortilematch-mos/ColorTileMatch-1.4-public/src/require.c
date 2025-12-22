/*
================================
        ColorTileMatch
    Puzzle game written in C
         and with SDL
================================
    Written by BL0CKEDUSER
*/

#include <stdio.h>
#include "require.h"

void Require(int exp, char* operationName)
{
    if(!exp){
        printf("%s failed\n", operationName);
        exit(0);
    }
}