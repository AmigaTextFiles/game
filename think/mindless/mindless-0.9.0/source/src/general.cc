/* general.cc
   Copyright (C) 2000  Mathias Broxvall

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

#include "general.h"
#include "SDL/SDL_image.h"
#include "SDL/SDL_ttf.h"

using namespace std;

TTF_Font *font,*bigFont;

SDL_Surface *loadImage(char *name) {
  char path[512];
  sprintf(path,"%s/images/%s",shareDir,name);
  SDL_Surface *img = IMG_Load(path);
  if(!img) { fprintf(stderr,"Error: Failed to load %s\n",path); fflush(stderr); exit(1); }
  return img;
}

void blit(SDL_Surface *image,int x, int y) {
  SDL_Rect source,dest;
  source.x=0; source.y=0; source.w=image->w; source.h=image->h;
  dest.x=x; dest.y=y; dest.w=image->w; dest.h=image->h;
  SDL_BlitSurface(image,&source,screen,&dest);
}

int mymod(int v,int m) {
  int tmp=v % m;
  while(tmp < 0) tmp += m;
  return tmp;
}

void generalInit() {
  char str[512];
  TTF_Init();
  sprintf(str,"%s/fonts/%s",shareDir,"font.ttf"); font = TTF_OpenFont(str,18); 
  if(!font) { fprintf(stderr,"Error: Failed to load font %s\n",str); exit(0); }
  bigFont = TTF_OpenFont(str,32); 
  if(!bigFont) { fprintf(stderr,"Error: Failed to load font %s\n",str); exit(0); }
}
void drawText(char *str,int x,int y,int center,int r,int g,int b) {
  SDL_Color fgColor={255,255,255};
  fgColor.r=r; fgColor.g=g; fgColor.b=b;
  SDL_Surface *text = TTF_RenderText_Blended(font, str, fgColor);
  blit(text,center?x-text->w/2:x,y);
  SDL_FreeSurface(text);
}
void drawBigText(char *str,int x,int y,int center,int r,int g,int b) {
  SDL_Color fgColor={255,255,255};
  fgColor.r=r; fgColor.g=g; fgColor.b=b;
  SDL_Surface *text = TTF_RenderText_Blended(bigFont, str, fgColor);
  blit(text,center?x-text->w/2:x,y);
  SDL_FreeSurface(text);
}
