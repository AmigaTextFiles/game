/* 
 * Copyright (C) 2009  Sean McKean
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef COMPUTER_H
#define COMPUTER_H

#include "main.h"
#include "types.h"


/*
 *  CPU_MIN_THINK_TIME is the minimum amount of time for the computer to
 *  take its turn, in milliseconds, but it may be more.
 */
#define CPU_MIN_THINK_TIME  500
#define BALANCE_DIVISOR  4

/* Function prototypes */
void ComputerCellTest( int, int *, int *, int *, int *, int *, int * );
int ComputerPickCellLevelHard( void );
int ComputerPickCellLevelMedium( void );
int ComputerPickCellRandom( void );
int ComputerFinishDelay( int );

#endif  /* COMPUTER_H */
