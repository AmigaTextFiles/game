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
#include <clib/intuition_protos.h>
#include <clib/exec_protos.h>
#include <clib/lowlevel_protos.h>
#include <clib/dos_protos.h>
#include <clib/graphics_protos.h>
#include "setup.h"
#include "keys.h"
#include <stdio.h>

void getkeypress(void)
{
	int key=pressedkey;
	struct IntuiMessage *imsg;
	struct MsgPort *uport;
	uport=gamewindow->UserPort;


	while(key==pressedkey)
	{
		WaitPort(uport);
		while((imsg = (struct IntuiMessage*)GetMsg(uport)))
		{
			pressedkey=(int)imsg->Code;
			ReplyMsg((struct Message*)imsg);
		}
		if(pressedkey==enter) pressedkey=space;
	
	}

//	int key;
//	key=pressedkey;
//	while(key==pressedkey)
//	{
//		WaitTOF();
//		pressedkey=GetKey()&0xff;
//		if(pressedkey==enter) pressedkey=space;
//		getjoydir();
//	}
}

char highscorekeypress(void)
{
	int key=pressedkey;
	struct IntuiMessage *imsg;
	struct MsgPort *uport;
	uport=gamewindow->UserPort;


	while(key==pressedkey)
	{
		WaitPort(uport);
		while((imsg = (struct IntuiMessage*)GetMsg(uport)))
		{
			pressedkey=(int)imsg->Code;
			ReplyMsg((struct Message*)imsg);
		}		
		if(pressedkey==key_a) return 'A';
		if(pressedkey==key_b) return 'B';
		if(pressedkey==key_c) return 'C';
		if(pressedkey==key_d) return 'D';
		if(pressedkey==key_e) return 'E';
		if(pressedkey==key_f) return 'F';
		if(pressedkey==key_g) return 'G';
		if(pressedkey==key_h) return 'H';
		if(pressedkey==key_i) return 'I';
		if(pressedkey==key_j) return 'J';
		if(pressedkey==key_k) return 'K';
		if(pressedkey==key_l) return 'L';
		if(pressedkey==key_m) return 'M';
		if(pressedkey==key_n) return 'N';
		if(pressedkey==key_o) return 'O';
		if(pressedkey==key_p) return 'P';
		if(pressedkey==key_q) return 'Q';
		if(pressedkey==key_r) return 'R';
		if(pressedkey==key_s) return 'S';
		if(pressedkey==key_t) return 'T';
		if(pressedkey==key_u) return 'U';
		if(pressedkey==key_v) return 'V';
		if(pressedkey==key_w) return 'W';
		if(pressedkey==key_x) return 'X';
		if(pressedkey==key_y) return 'Y';
		if(pressedkey==key_z) return 'Z';
		if(pressedkey==key_ao) return 'Å';
		if(pressedkey==key_ae) return 'Ä';
		if(pressedkey==key_oe) return 'Ö';

		if(pressedkey==space) return ' ';
		if(pressedkey==key_bs) return '-';
	}
	return '0';
}

/*
void getjoydir(void)
{
	ULONG action=NULL;
	action = ReadJoyPort(1);
	
	if(action&JPF_UP){ Delay(5); pressedkey=move_up; }
	if(action&JPF_DOWN){ Delay(5); pressedkey=move_down; }
	if(action&JPF_LEFT){ Delay(5); pressedkey=move_left; }
	if(action&JPF_RIGHT){ Delay(5); pressedkey=move_right; }
	if(action&JPF_BUTTON_RED){ Delay(5); pressedkey=space; }
}

*/
int checkabort(void)
{
	if(pressedkey==0x45) return(1);
	return(0);
}

void typekeynumber(void)
{
	printf("Pressedkey: %d\n",pressedkey);
}

int checkmarkkey(void)
{
	if(pressedkey>=0x3d && pressedkey<=0x3f) return(1);
	if(pressedkey>=0x2d && pressedkey<=0x2f) return(1);
	if(pressedkey>=0x1d && pressedkey<=0x1f) return(1);
	return(0);
}
