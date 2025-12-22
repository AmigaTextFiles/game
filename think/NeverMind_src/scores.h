/*
* This file is part of NeverMind.
* Copyright (C) 1998 Lennart Johannesson
* 
* NeverMind is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* NeverMind is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with NeverMind.  If not, see <http://www.gnu.org/licenses/>.
*
*/
#define max_namelength 25
#define number_hs 20

extern struct hs_post;

extern struct hs_post hiscores[];

extern int corruptfile;

int savescores(void); /* Save HighScores */
int loadscores(void); /* Load HighScores */
void displayscores(void); /* Shows the highscore-table */
int checkhighscore(int score); /* Checks if highscore is made... */
int finalscore(int score); /* Calculates the final score */
