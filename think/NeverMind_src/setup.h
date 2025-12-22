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

#define intuiversion 39L

const int screenwidth = 320;    /* Width Of Screen */
const int screenheight = 256;   /* Height Of Screen */
const int depth = 4;            /* Screen Depth */
const int prefsversion = 3;     /* Version of prefsfile */

extern struct Library *IntutionBase;
extern struct Library *GraphicsBase;
extern struct Library *AslBase;
extern struct Library *DiskFontBase;
extern struct Library *MEDPlayerBase;

extern struct Screen *gamescreen;      /* Our Screen! */
extern struct Window *gamewindow;      /* Our Window! */
extern struct RastPort *RPort;         /* The RastPort */

extern struct TextFont *gamefont;   /* The font :) */

void setup(void);
void shutdown(char *);
void loadprefs(void);
void saveprefs(void);
void mode_request(void);
void endmessage(char *);

extern char filename[256];
