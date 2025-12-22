/**************************************************************************
 * TARGET ACQUIRED, (c) 1995, 2002 Michael Martin                         *
 *                                                                        *
 * You may use, distribute, or modify this code in accordance with the    *
 * BSD license: see LICENSE.txt for details.                              *
 **************************************************************************/

#ifndef __SCORES_H__
#define __SCORES_H__

typedef struct {
    char name[45];
    unsigned long hiscore;
} hiscorestruct;

void loadhiscores(void);
void savehiscores(void);
void updatehiscores(unsigned long);
void displayhiscores(void);

#endif
