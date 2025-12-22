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

#include "font.h"

#include "window.h"
#include "graphics.h"
#include "variable.h"

#include "files.h"

extern graphics Graphics;

font::font() {
	fontpic=0;
	type=-1;
}

font::~font() {
//	fprintf (stderr, "font (%d): %d\n", type, fontpic);
	if (fontpic>0) SDL_FreeSurface(fontpic);
}

void font::Initialize(int fonttype) {
	int i=0;

	fprintf (stderr, "Inititializing font as: %d\n", fonttype);

	FILE *fontdatafile;

	switch (fonttype) {
		case FONT_116:
			spacewidth=30;
			letterdist=10;
			fontpic = Graphics.LoadPicture(FONTS_FONT116_PNG);
			Graphics.SetTransparentColor(fontpic, 0, 0, 0);
			fontdatafile = fopen("fonts/font116.dat", "rb");
			for (i=0; i<100; i++) {
				variable::FromFile_Int(fontdatafile, &fontdata[i][0]);
				variable::FromFile_Int(fontdatafile, &fontdata[i][1]);
			}
			fclose (fontdatafile);
		break;
		case CHATFONT:
			spacewidth=3;
			letterdist=1;
			fontpic = Graphics.LoadPicture(FONTS_CHATFONT_PNG);
			Graphics.SetTransparentColor(fontpic, 255, 255, 255);
			fontdatafile = fopen("fonts/chatfont.dat", "rb");
			for (i=0; i<100; i++) {
				variable::FromFile_Int(fontdatafile, &fontdata[i][0]);
				variable::FromFile_Int(fontdatafile, &fontdata[i][1]);
			}
			fclose (fontdatafile);
		break;
		case ONWOOD:
			spacewidth=6;
			letterdist=3;
			fontpic = Graphics.LoadPicture(FONTS_ONWOOD_PNG);
			Graphics.SetTransparentColor(fontpic, 255, 255, 255);
			fontdatafile = fopen("fonts/onwood.dat", "rb");
			for (i=0; i<100; i++) {
				variable::FromFile_Int(fontdatafile, &fontdata[i][0]);
				variable::FromFile_Int(fontdatafile, &fontdata[i][1]);
			}
			fclose (fontdatafile);
		break;

		default:
			fprintf (stderr, "No such font in font::Initialize()!\n");
			exit(0);
		break;
	}

	type=fonttype;
}

int font::GetWidth(Uint8 letter) {
	int width=0;
	switch (letter) {
		case ' ':
			width = spacewidth;
		break;
		default:
			width = fontdata[letter-'!'][1];
		break;
	}
	return width+letterdist;
}

int font::WriteChar(SDL_Surface *screen, Uint8 letter, Uint32 cx, Uint32 cy) {
	int width=0;

	switch (letter) {
		case ' ':
			width = spacewidth+letterdist;
		break;
		default:
			Graphics.DrawPartOfIMG(screen, fontpic, cx, cy,
								fontdata[letter-'!'][1], fontpic->h, fontdata[letter-'!'][0], 0);
			width=GetWidth(letter);
		break;
	}
	return width;
}

void font::WriteString(SDL_Surface *screen, char *string, Uint32 cx, Uint32 cy, Uint32 flags) {
	if (!string) {
		fprintf (stderr, "String=(null)\n");
		return;
	}

	if ( (flags&FONT_XCENTERED)==FONT_XCENTERED) {
		int width=0;
		for (int i=0; string[i]!='\0'; i++) width+=GetWidth(string[i]);

		cx-=(int)(width/2);
	}

	if ( (flags&FONT_YCENTERED)==FONT_YCENTERED) {
		cy-=(int)(fontpic->h/2);
	}

	if ( (flags&FONT_RIGHTENED)==FONT_RIGHTENED) {
		int width=0;
		for (int i=0; string[i]!='\0'; i++) width+=GetWidth(string[i]);
		cx -= width;
	}

	for (int i=0; string[i]!='\0'; i++) {
		cx+=WriteChar(screen, (Uint8)string[i], cx, cy);
	}

}

int font::GetStringWidth(char *string) {
	int width=0;
	for (int i=0; string[i]!='\0'; i++) width+=GetWidth(string[i]);
	return width;
}

int font::GetHeight() {
	return fontpic->h;
}
