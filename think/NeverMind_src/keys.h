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
/* Header file for NeverMind
   (C) 1997-1998 Lennart Johannesson */

int checkabort(void); /* Checks if ESC-key was pressed! */

int checkmove(void); /* Checks if You've pressed arrowkeys...
                        returns direction in that case... */

int checkmarkkey(void); /* Checks if you have pressed num. keypad */

void getjoydir(void); /* Get joy direction (if there is any) */
void getkeypress(void); /* Get pressed key (if pressed) */
void typekeynumber(void); /* Prints the number of the pressed key */
char highscorekeypress(void); /* Highscore key check */

extern int pressedkey;

const int move_left=0x4f;
const int move_right=0x4e;
const int move_up=0x4c;
const int move_down=0x4d;
const int space=64;
const int enter=68;
const int key_bs=0x41;

const int key_q=0x10;
const int key_w=0x11;
const int key_e=0x12;
const int key_r=0x13;
const int key_t=0x14;
const int key_y=0x15;
const int key_u=0x16;
const int key_i=0x17;
const int key_o=0x18;
const int key_p=0x19;
const int key_ao=0x1A;

const int key_a=0x20;
const int key_s=0x21;
const int key_d=0x22;
const int key_f=0x23;
const int key_g=0x24;
const int key_h=0x25;
const int key_j=0x26;
const int key_k=0x27;
const int key_l=0x28;
const int key_oe=0x29;
const int key_ae=0x2A;

const int key_z=0x31;
const int key_x=0x32;
const int key_c=0x33;
const int key_v=0x34;
const int key_b=0x35;
const int key_n=0x36;
const int key_m=0x37;
