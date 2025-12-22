/*
    Copyright (c) 2004-2005 Markus Kettunen

    This file is part of Blobtrix.

    Blobtrix is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Blobtrix is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Blobtrix; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/


#include "stringblock.h"

#include "keyboard.h"
#include "graphics.h"
#include "window.h"

#include <string.h>

extern keyboard Keyboard;
extern window Window;

stringblock::stringblock(font *f, SDL_Surface *bg, int x, int y, Uint32 flags, int width, int maxlen) {
	Font=f;
	this->bg=bg;
	this->x=x;
	this->y=y;
	this->flags=flags;
	this->width=width;
	this->maxlen=maxlen;

	passwd=false;

	this->space=0;

	cursor=0;
	memset(string, 0, 256);
}

stringblock::stringblock(font *f, SDL_Surface *bg, int x, int y, Uint32 flags, int width, int maxlen, bool space) {
	Font=f;
	this->bg=bg;
	this->x=x;
	this->y=y;
	this->flags=flags;
	this->width=width;
	this->maxlen=maxlen;

	passwd=false;

	this->space=space;
	cursor=0;
	memset(string, 0, 256);
}

void stringblock::MoveTo(int x, int y) {
	this->x=x;
	this->y=y;
}

void stringblock::SetBg(SDL_Surface *bg) {
	this->bg=bg;
}

void stringblock::SetPassword(bool b) {
	passwd=b;
}

void stringblock::Listen() {
	if (Keyboard.Pressed(SDLK_BACKSPACE) ) {
		cursor--;
		if (cursor<0) cursor=0;
		string[cursor]='\0';
		return;
	}

	char ch = Keyboard.GetAscii();
	if (ch!=0 && ch !='\n' && ch !='\r' && (!space || ch != ' ') ) {
		if ( (Uint8)ch >=' ' && (Uint8)ch <= ('~'+6) /* 6=ÅÄÖåäö */ ) {
			if (cursor<maxlen && GetStringWidth(string) + Font->GetWidth('_') + Font->GetWidth(ch) <= width ) {					
				string[cursor]=ch;
				cursor++;
				string[cursor]='\0';
			}
		}
	}
}

void stringblock::ListenNum() {
	if (Keyboard.Pressed(SDLK_BACKSPACE) ) {
		cursor--;
		if (cursor<0) cursor=0;
		string[cursor]='\0';
	}

	char ch = Keyboard.GetAscii();
	if (ch!=0 && ch !='\n' && ch !='\r') {
		if ( (Uint8)ch >='0' && (Uint8)ch <= '9' ) {
			if (cursor<maxlen && Font->GetStringWidth(string) + Font->GetWidth('_') + GetWidth(ch) <= width ) {					
				string[cursor]=ch;
				cursor++;
				string[cursor]='\0';
			}
		}
	}
}

void stringblock::Draw(int underscore) {
	if (!passwd) {
		if (underscore) {
			char *str = new char[strlen(string)+2];
			sprintf (str, "%s%c", string, '_');
			Font->WriteString(Window.GetScreen(), str, x, y, flags);
			delete[] str;
		} else {
			Font->WriteString(Window.GetScreen(), string, x, y, flags);
		}
	} else {
		char *str =new char[strlen(string)+1+underscore];

		int len=strlen(string);
		for (int i=0; i<len; i++) {
			str[i]='*';
		}
		if (underscore) {
			str[len]='_';
			str[len+1]='\0';
		} else {
			str[len]='\0';
		}
		Font->WriteString(Window.GetScreen(), str, x, y, flags);
		delete[] str;
	}
}

void stringblock::Clean() {
	int cx=x;
	int cy=y;

	int h=Font->GetHeight();
	int w=width;

	if ( (flags&FONT_YCENTERED)==FONT_YCENTERED) {
		cy-=(int)( Font->GetHeight()/2 );
	}
	if ( (flags&FONT_RIGHTENED)==FONT_RIGHTENED) {
		cx -= (int)( w/2 );
	}

	Graphics.DrawPartOfIMG(Window.GetScreen(), bg, cx, cy, w, h, cx, cy);
}

char *stringblock::Get() {
	return string;
}

void stringblock::Set(char *str) {
	strncpy(string, str, 255);
	string[256]='\0';
	cursor=strlen(string);
}

int stringblock::GetWidth(char ch) {
	if (!passwd) return Font->GetWidth(ch);
	else return Font->GetWidth('*');
}


int stringblock::GetStringWidth(char *str) {
	if (!passwd) return Font->GetStringWidth(str);
	else return Font->GetWidth('*')*strlen(str);
}
