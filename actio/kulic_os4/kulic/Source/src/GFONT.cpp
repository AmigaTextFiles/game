
#include "stdh.h"
#include "GFont.h"

#define MAX_CHARTERS  40  // pocet pismenek ve fontu
#define SPACE         25  // sirka mezery (ma ID MAX_CHARTERS)
#define CHARSPACE      5  // vzdalenost mezi pismenky

BITMAP *my_font[MAX_CHARTERS];

typedef struct {
	char c;
	char file[80];
} st_fontdata;

const st_fontdata Fparams[MAX_CHARTERS] = {
	{'A', "gfx/font/A.BMP"},
	{'B', "gfx/font/B.BMP"},
	{'C', "gfx/font/C.BMP"},
	{'D', "gfx/font/D.BMP"},
	{'E', "gfx/font/E.BMP"},
	{'F', "gfx/font/F.BMP"},
	{'G', "gfx/font/G.BMP"},
	{'H', "gfx/font/H.BMP"},
	{'I', "gfx/font/I.BMP"},
	{'J', "gfx/font/J.BMP"},
	{'K', "gfx/font/K.BMP"},
	{'L', "gfx/font/L.BMP"},
	{'M', "gfx/font/M.BMP"},
	{'N', "gfx/font/N.BMP"},
	{'O', "gfx/font/O.BMP"},
	{'P', "gfx/font/P.BMP"},
	{'Q', "gfx/font/Q.BMP"},
	{'R', "gfx/font/R.BMP"},
	{'S', "gfx/font/S.BMP"},
	{'T', "gfx/font/T.BMP"},
	{'U', "gfx/font/U.BMP"},
	{'V', "gfx/font/V.BMP"},
	{'W', "gfx/font/W.BMP"},
	{'X', "gfx/font/X.BMP"},
	{'Y', "gfx/font/Y.BMP"},
	{'Z', "gfx/font/Z.BMP"},

	{'0', "gfx/font/0.BMP"},
	{'1', "gfx/font/1.BMP"},
	{'2', "gfx/font/2.BMP"},
	{'3', "gfx/font/3.BMP"},
	{'4', "gfx/font/4.BMP"},
	{'5', "gfx/font/5.BMP"},
	{'6', "gfx/font/6.BMP"},
	{'7', "gfx/font/7.BMP"},
	{'8', "gfx/font/8.BMP"},
	{'9', "gfx/font/9.BMP"},

	{'<', "gfx/font/ZLEVO.BMP"},
	{'>', "gfx/font/ZPRAVO.BMP"},
	{'-', "gfx/font/ZPOMLCKA.BMP"},
	{'.', "gfx/font/ZTECKA.BMP"},
};

bool LoadFontGFX() 
{
	char s[80];
	for(int i = 0; i < MAX_CHARTERS; i++) {
		sprintf(s, Fparams[i].file);
		if (!(my_font[i] = hload_shadow_bitmap(s))) {
			allegro_message("Misssigne file %s", s);
			return false;
		}
	}
	return true;
}

void DestroyFont()
{
	for(int i = 0; i < MAX_CHARTERS; i++) 
		if (my_font[i] != NULL) {
			destroy_bitmap(my_font[i]);
			my_font[i] = NULL;
		}
}

int GetTextWidth(char *c)
{
	int w = 0;
	int i;
	while(*c != '\0') {
		if ((i = GetFontID(*c)) != -1) {
			if (i != MAX_CHARTERS) 
				w += my_font[i]->w + CHARSPACE;
			else w += SPACE;
		}
		c++;
	}
	return w;
}

// Vrati id znaku v Fparams, jinak vraci -1
int GetFontID(char c)
{
	if (c == ' ') return MAX_CHARTERS;
	int i;
	for (i = 0; i < MAX_CHARTERS; i++)
		if (Fparams[i].c == c) break;
	if (i < MAX_CHARTERS) return i;
	return -1;
}


void DrawMyFontCenter(BITMAP *dst, int x, int y, int color, char *c)
{
	// font v 8BPP neni podporovan !!
	if (hscreen.m_bpp == 8) {
		textprintf_centre(dst, font, x, y, color, c);
		return;
	}

	x -=  GetTextWidth(c)/2;
	int i;
	while(*c != '\0') {
		if ((i = GetFontID(*c)) != -1) {
			if (i != MAX_CHARTERS) {
				BITMAP *colored = create_bitmap(my_font[i]->w, my_font[i]->h);
				clear_to_color(colored, color);
				hmasked_sprite(dst, colored, my_font[i], x, y);
				destroy_bitmap(colored);
				x += my_font[i]->w + CHARSPACE;
			}
			else x += SPACE;
		}
		c++;
	}
}

void DrawMyFontCenter_trans(BITMAP *dst, int x, int y, int color, char *c)
{
	// font v 8BPP neni podporovan !!
	if (hscreen.m_bpp == 8) {
		textprintf_centre(dst, font, x, y, color, c);
		return;
	}

	x -=  GetTextWidth(c)/2;
	int i;
	while(*c != '\0') {
		if ((i = GetFontID(*c)) != -1) {
			if (i != MAX_CHARTERS) {
				BITMAP *colored = create_bitmap(my_font[i]->w, my_font[i]->h);
				clear_to_color(colored, color);
				hmasked_sprite(dst, colored, my_font[i], x, y);
				destroy_bitmap(colored);
				x += my_font[i]->w + CHARSPACE;
			}
			else x += SPACE;
		}
		c++;
	}
}
