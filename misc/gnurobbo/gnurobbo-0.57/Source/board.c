/*
 *   Copyright (C) notes:
 *   An Idea and Atari version: LK Avalon, Janusz Pelc, 1989
 *   	            Linux Code: Arkadiusz Lipiec, 2002
 *               		<alipiec@elka.pw.edu.pl>
 *
 *  GNU Robbo is free software - you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2, or (at your option)
 *  any later version.
 *
 *  GNU Robbo is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the impled warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with GNU CC; see the file COPYING. If not, write to the
 *  Free Software Foundation, 59 Temple Place - Suite 330,
 *  Boston, MA 02111-1307, USA.
 *
 */
#include "game.h"
#include "stdlib.h"
#include "string.h"

char* banner[8] ={
	".OOOOO...OO...OOO..OOO..OOO.....oO#$oO..............oO#.......#$o...............",
	"OOOOOOO..OOO..OOO..OOO..OOO.....O#$..#$.....O#$o....O#$.......$oO.........$oO#..",
	"OOO..OO..OOO..OOO..OOO..OOO.....#$o...oO...O#$.O#...#$oO#$....oO#$oO.....$oO.$o.",
	"OOO......OOOO.OOO..OOO..OOO.....$oO...O#..O#$...$o..$oO..oO...O#$..#$...$oO...O#",
	"OOO.OOO..OOOOOOOO..OOO..OOO.....oO#..O#...#$o...oO..oO#...#$..#$o...oO..oO#...#$",
	"OOO..OO..OOO.OOOO..OOO..OOO.....O#$oO#....$oO...O#..O#$...$o..$oO...O#..O#$...$o",
	"OOOOOOO..OOO..OOO..OOOOOOOO.....#$o..$o...oO#...#$..#$o...oO..oO#...#$..#$o...oO",
	".OOOOO...OOO..OOO...OOOOOO......$oO...O#...#$oO#$...$oO#$oO...O#$oO#$....oO#$oO."};

SDL_Rect set_rect(int x, int y, int w, int h)
{
	SDL_Rect rect;
	rect.x = x;
	rect.y = y;
	rect.w = w;
	rect.h = h;
	return rect;
}

Uint32 getpixel(SDL_Surface *surface, int x, int y) 
{
	int bpp = surface->format->BytesPerPixel;
	/* Here p is the address to the pixel we want to retrieve */
	Uint8 *p = (Uint8 *)surface->pixels + y * surface->pitch + x * bpp;
            
	switch(bpp) {
		case 1:
			return *p;
		case 2:
			return *(Uint16 *)p;
		case 3:
			if(SDL_BYTEORDER == SDL_BIG_ENDIAN)
				return p[0] << 16 | p[1] << 8 | p[2];
			else
				return p[0] | p[1] << 8 | p[2] << 16;
		case 4:
			return *(Uint32 *)p;
		default:
			return 0;       /* shouldn't happen, but avoids warnings */
	}
}


void load_bitmaps(){
	int i;
	SDL_Rect srcrect, destrect;

	#if SDL_BYTEORDER == SDL_BIG_ENDIAN
   		rmask = 0xff000000;
   		gmask = 0x00ff0000;
   		bmask = 0x0000ff00;
   		amask = 0x000000ff;
	#else
		rmask = 0x000000ff;
		gmask = 0x0000ff00;
		bmask = 0x00ff0000;
		amask = 0xff000000;
	#endif


	fgcolor.r = 255;
	fgcolor.g = 255;
	fgcolor.b = 255;
	bgcolor.r = 0;
	bgcolor.g = 0;
	bgcolor.b = 0;
                                
	destrect = set_rect(0,0,FIELD_SIZE,FIELD_SIZE);
	
	if((icons = SDL_LoadBMP(BMP_ICONS)) == NULL) {
		fprintf(stdout,"Cannot load icon bitmap: %s\n",BMP_ICONS);
		exit(1);
	}

	if((ciphers = SDL_LoadBMP(BMP_CIPHERS)) == NULL) {
		fprintf(stdout,"Cannot load ciphers' bitmap: %s\n",BMP_CIPHERS);
		exit(1);
	}

	image_startscreen = SDL_CreateRGBSurface(SDL_SWSURFACE,500,500,32,rmask,gmask,bmask,amask);
	icon = SDL_CreateRGBSurface(SDL_SWSURFACE,32,32,32,rmask,gmask,bmask,amask);

	SDL_SetColorKey(image_startscreen,SDL_SRCCOLORKEY,getpixel(image_startscreen,0,0));  /* transparency */
	SDL_SetColorKey(icons,SDL_SRCCOLORKEY,getpixel(icons,FIELD_SIZE/16,FIELD_SIZE/16));  /* transparency */
	SDL_SetColorKey(ciphers,SDL_SRCCOLORKEY,getpixel(ciphers,1,1));  /* transparency */

	for(i=0;i<8;i++) {   /* Robbo icons */
		robbo_img[i] = SDL_CreateRGBSurface(SDL_SWSURFACE,FIELD_SIZE,FIELD_SIZE,32,rmask,gmask,bmask,amask);
		srcrect = set_rect((2+i*34),172,FIELD_SIZE,FIELD_SIZE);
		SDL_BlitSurface(icons,&srcrect,robbo_img[i],&destrect);
	}

	for(i=0;i<10;i++) { /* Objects icons */
		score_img[i] = SDL_CreateRGBSurface(SDL_SWSURFACE,FIELD_SIZE,FIELD_SIZE,32,rmask,gmask,bmask,amask);
		srcrect = set_rect((i*18),0,FIELD_SIZE,FIELD_SIZE);
		SDL_BlitSurface(ciphers,&srcrect,score_img[i],&destrect);
	}
  
	score_screw = SDL_CreateRGBSurface(SDL_SWSURFACE,FIELD_SIZE,FIELD_SIZE,32,rmask,gmask,bmask,amask);
	score_robbo = SDL_CreateRGBSurface(SDL_SWSURFACE,FIELD_SIZE,FIELD_SIZE,32,rmask,gmask,bmask,amask);
	score_key = SDL_CreateRGBSurface(SDL_SWSURFACE,FIELD_SIZE,FIELD_SIZE,32,rmask,gmask,bmask,amask);
	score_bullet = SDL_CreateRGBSurface(SDL_SWSURFACE,FIELD_SIZE,FIELD_SIZE,32,rmask,gmask,bmask,amask);
	score_level = SDL_CreateRGBSurface(SDL_SWSURFACE,FIELD_SIZE,FIELD_SIZE,32,rmask,gmask,bmask,amask);
	
	srcrect = set_rect(104,172,32,32);
	SDL_BlitSurface(icons,&srcrect,icon,&destrect);
	
	if(FIELD_SIZE == 16) {
		srcrect = set_rect(69,52,FIELD_SIZE,FIELD_SIZE);
		SDL_BlitSurface(icons,&srcrect,score_screw,&destrect);
		srcrect = set_rect(86,52,FIELD_SIZE,FIELD_SIZE);
		SDL_BlitSurface(icons,&srcrect,score_robbo,&destrect);
		srcrect = set_rect(103,52,FIELD_SIZE,FIELD_SIZE);
		SDL_BlitSurface(icons,&srcrect,score_key,&destrect);
		srcrect = set_rect(120,52,FIELD_SIZE,FIELD_SIZE);
		SDL_BlitSurface(icons,&srcrect,score_bullet,&destrect);
		srcrect = set_rect(137,52,FIELD_SIZE,FIELD_SIZE);
		SDL_BlitSurface(icons,&srcrect,score_level,&destrect);	

	}
	else {
		srcrect = set_rect(138,104,FIELD_SIZE,FIELD_SIZE);
		SDL_BlitSurface(icons,&srcrect,score_screw,&destrect);
		srcrect = set_rect(172,104,FIELD_SIZE,FIELD_SIZE);
		SDL_BlitSurface(icons,&srcrect,score_robbo,&destrect);
		srcrect = set_rect(206,104,FIELD_SIZE,FIELD_SIZE);
		SDL_BlitSurface(icons,&srcrect,score_key,&destrect);
		srcrect = set_rect(240,104,FIELD_SIZE,FIELD_SIZE);
		SDL_BlitSurface(icons,&srcrect,score_bullet,&destrect);
		srcrect = set_rect(274,104,FIELD_SIZE,FIELD_SIZE);
		SDL_BlitSurface(icons,&srcrect,score_level,&destrect);	
	}
}

void draw_score()
{
	SDL_Rect srcrect;
	SDL_Rect destrect;
	int j, n, i;
	int ScoreLine = 440;

	destrect.x = 0;
	destrect.y = 440;
	destrect.w = screen->w;
	destrect.y = 50;
	

	j=FIELD_SIZE;
	n=100000;

	for(i=0;i<6;i++) {
		srcrect = set_rect(0,0,FIELD_SIZE/2,FIELD_SIZE);
		destrect = set_rect(j,ScoreLine,FIELD_SIZE/2,FIELD_SIZE);

		if(SDL_BlitSurface(score_img[(robbo.score/n)%10],&srcrect,screen,&destrect) < 0)
			fprintf(stdout,"BlitSurface error: %s\n",SDL_GetError());
		n = n/10;
		j= j + FIELD_SIZE/2;
	}

	srcrect = set_rect(0,0,FIELD_SIZE,FIELD_SIZE);
	destrect = set_rect(destrect.x+FIELD_SIZE,ScoreLine,FIELD_SIZE,FIELD_SIZE);

	if(SDL_BlitSurface(score_screw,&srcrect,screen,&destrect) < 0)
		fprintf(stdout,"BlitSurface error: %s\n",SDL_GetError());   

	j = destrect.x + FIELD_SIZE;
	n = 10;

	for(i=0;i<2;i++) {

		srcrect = set_rect(0,0,FIELD_SIZE/2,FIELD_SIZE);
		destrect = set_rect(j,ScoreLine,FIELD_SIZE/2,FIELD_SIZE);
 
		if(SDL_BlitSurface(score_img[(robbo.screws/n)%10],&srcrect,screen,&destrect) < 0)
			fprintf(stdout,"BlitSurface error: %s\n",SDL_GetError());
		j=j+FIELD_SIZE/2;
		n=n/10;
	}
	
	srcrect = set_rect(0,0,FIELD_SIZE,FIELD_SIZE);
	destrect = set_rect(destrect.x+FIELD_SIZE,ScoreLine,FIELD_SIZE,FIELD_SIZE);

	if(SDL_BlitSurface(score_robbo,&srcrect,screen,&destrect) < 0)
		fprintf(stdout,"BlitSurface error: %s\n",SDL_GetError());   

	j = destrect.x + FIELD_SIZE;
	n = 10;
	
	for(i=0;i<2;i++) {
		srcrect = set_rect(0,0,FIELD_SIZE/2,FIELD_SIZE);
		destrect = set_rect(j,ScoreLine,FIELD_SIZE/2,FIELD_SIZE);
 
		if(SDL_BlitSurface(score_img[((robbo.lives>0?robbo.lives:0)/n)%10],&srcrect,screen,&destrect) < 0)
			fprintf(stdout,"BlitSurface error: %s\n",SDL_GetError());
		j = j + FIELD_SIZE/2;
		n = n / 10;
	}

	srcrect = set_rect(0,0,FIELD_SIZE,FIELD_SIZE);
	destrect = set_rect(destrect.x+FIELD_SIZE,ScoreLine,FIELD_SIZE,FIELD_SIZE);

	if(SDL_BlitSurface(score_key,&srcrect,screen,&destrect) < 0)
		fprintf(stdout,"BlitSurface error: %s\n",SDL_GetError());   

	j = destrect.x + FIELD_SIZE;
	n = 10;

	for(i=0;i<2;i++) {
		srcrect = set_rect(0,0,FIELD_SIZE/2,FIELD_SIZE);
		destrect = set_rect(j,ScoreLine,FIELD_SIZE/2,FIELD_SIZE);
 
		if(SDL_BlitSurface(score_img[(robbo.keys/n)%10],&srcrect,screen,&destrect) < 0)
			fprintf(stdout,"BlitSurface error: %s\n",SDL_GetError());
		j = j + FIELD_SIZE/2;
		n = n / 10;
	}

	srcrect = set_rect(0,0,FIELD_SIZE,FIELD_SIZE);
	destrect = set_rect(destrect.x+FIELD_SIZE,ScoreLine,FIELD_SIZE,FIELD_SIZE);

	if(SDL_BlitSurface(score_bullet,&srcrect,screen,&destrect) < 0)
		fprintf(stdout,"BlitSurface error: %s\n",SDL_GetError());   

	j = destrect.x + FIELD_SIZE;
	n = 10;
 
	for(i=0;i<2;i++) {
		srcrect = set_rect(0,0,FIELD_SIZE/2,FIELD_SIZE);
		destrect = set_rect(j,ScoreLine,FIELD_SIZE/2,FIELD_SIZE);
 
		if(SDL_BlitSurface(score_img[(robbo.bullets/n)%10],&srcrect,screen,&destrect) < 0)
			fprintf(stdout,"BlitSurface error: %s\n",SDL_GetError());
		j = j + FIELD_SIZE/2;
		n = n / 10;
	}

	srcrect = set_rect(0,0,FIELD_SIZE,FIELD_SIZE);
	destrect = set_rect(destrect.x+FIELD_SIZE,ScoreLine,FIELD_SIZE,FIELD_SIZE);

	if(SDL_BlitSurface(score_level,&srcrect,screen,&destrect) < 0)
		fprintf(stdout,"BlitSurface error: %s\n",SDL_GetError());   

	j = destrect.x + FIELD_SIZE + FIELD_SIZE/4;
	n = 100;
 
	for(i=0;i<3;i++) {
	
		srcrect = set_rect(0,0,FIELD_SIZE/2,FIELD_SIZE);
		destrect = set_rect(j,ScoreLine,FIELD_SIZE/2,FIELD_SIZE);
 
		if(SDL_BlitSurface(score_img[(robbo.level/n)%10],&srcrect,screen,&destrect) < 0)
			fprintf(stdout,"BlitSurface error: %s\n",SDL_GetError());
		j = j + FIELD_SIZE/2;
		n = n / 10;
	}
}


void clear_screen()
{
	SDL_Rect srcrect, destrect;
	destrect = set_rect(0,0,screen->w,screen->h);
	SDL_FillRect(screen,&destrect,0);

	sprintf(TextBuffer,"Level author: %s,   Level code: %s",level.author,level.code);
		
		fgcolor.r = 255;
		fgcolor.b = 255;
		fgcolor.g = 255;
		bgcolor.r = 0;
		bgcolor.g = 0;
		bgcolor.b = 0;

		image = TTF_RenderUTF8_Shaded(font,TextBuffer,fgcolor, bgcolor);
		destrect = set_rect(FIELD_SIZE, 4, image->w, image->h);
		srcrect = set_rect(0,0,image->w, image->h);
		SDL_BlitSurface(image,&srcrect,screen,&destrect);
		SDL_FreeSurface(image);

}


/***************** drawing function ******************/

void show_gamearea()
{
	int x, y;
	int y_rest, x_rest, src_w, src_h, src_x, src_y, des_w, des_h, des_x, des_y;
	int i, j;
	SDL_Rect srcrect, destrect;

		y_rest = robbo.mapoffsety % FIELD_SIZE;
		x_rest = robbo.mapoffsetx % FIELD_SIZE;
		
		if((robbo.mapoffsety/FIELD_SIZE) > 6) {
			i = (robbo.mapoffsety/FIELD_SIZE)-6;
			y_rest = 0;
			}
		else {
			i = 0;
			y_rest = 0;
		}
		
		if((robbo.mapoffsety/FIELD_SIZE) < (level.y - 6))
			y_rest = 0;
		else {
			i = level.y - 12;
			y_rest = 0;
		}

		if((robbo.mapoffsetx/FIELD_SIZE) > 8) {
			j = (robbo.mapoffsetx/FIELD_SIZE) - 8;
			x_rest = 0;
			}
		else {
			j = 0;
			x_rest = 0;
		}
		
		if((robbo.mapoffsetx/FIELD_SIZE) < (level.x - 8))
			x_rest = 0;
		else {
			j = level.x - 16;
			x_rest = 0;
		}



	for(x = j; x < (17 + j); x++) {
		for(y = i; y < (i + 12); y++) {
		
		if(!board_changed[x][y] && !(robbo.x == x && robbo.y == y))	// no need to refresh
			continue;
		if(x == j) {
			des_x = FIELD_SIZE;
			des_w = FIELD_SIZE - x_rest;
			src_x = board[x][y].icon[board[x][y].state].x + x_rest;
			src_w = FIELD_SIZE - x_rest;
		}
		else if(x == (j+16)) {
			
			des_x = (x - j + 1) * FIELD_SIZE - x_rest;
			des_w = x_rest;
			src_x = board[x][y].icon[board[x][y].state].x;
			src_w = x_rest;
		}
		else {
			des_x = (x - j + 1) * FIELD_SIZE - x_rest;
			des_w = FIELD_SIZE;
			src_x = board[x][y].icon[board[x][y].state].x;
			src_w = FIELD_SIZE; 
		}	
		
		if(y == i) {
			 des_y = FIELD_SIZE;
			 des_h = FIELD_SIZE - y_rest;
			 src_y = board[x][y].icon[board[x][y].state].y + y_rest;
			 src_h = FIELD_SIZE - y_rest;
		}
		else if(y == (i+12)) {
			 des_y = (y - i + 1) * FIELD_SIZE - y_rest;
			 des_h = y_rest;
			 src_y = board[x][y].icon[board[x][y].state].y;
			 src_h = y_rest;
		}
		else {
			 des_y = (y - i + 1) * FIELD_SIZE - y_rest;
			 des_h = FIELD_SIZE;
			 src_y = board[x][y].icon[board[x][y].state].y;
			 src_h = FIELD_SIZE;
		}
			
		destrect = set_rect(des_x, des_y, des_w, des_h);
		srcrect = set_rect(src_x, src_y, src_w, src_h);
		
		if(level.now_is_blinking > 1)
				SDL_FillRect(screen, &destrect, 0x0ffffff);
			else
				SDL_FillRect(screen,&destrect, level.color);

			
	
			if(board[x][y].icon[board[x][y].state].x > 0 && board[x][y].icon[board[x][y].state].y > 0)
			{
				if(SDL_BlitSurface(icons,&srcrect,screen,&destrect) < 0)
					fprintf(stdout,"BlitSurface error: %s\n",SDL_GetError());
			}

			if(!(robbo.alive && (robbo.x == x && robbo.y == y && board[x][y].type != BIG_BOOM)))
						
			board_changed[x][y] = 0;
		}
	}
	

	src_x = (robbo.x - j + 1) * FIELD_SIZE - x_rest;
	src_y = (robbo.y - i + 1) * FIELD_SIZE - y_rest;
	
	if(robbo.alive && board[robbo.x][robbo.y].type != 42 && src_x >= FIELD_SIZE && src_x < 17 * FIELD_SIZE && src_y >= FIELD_SIZE && src_y < 13 * FIELD_SIZE) {	// if bigbum then robbo is hidden
		srcrect = set_rect(0,0,FIELD_SIZE,FIELD_SIZE);
		destrect = set_rect(src_x,src_y,FIELD_SIZE,FIELD_SIZE);
	
		if(SDL_BlitSurface(robbo_img[robbo.direction+robbo.state],&srcrect,screen,&destrect) < 0)
			fprintf(stdout,"Blad BlitSurface: %s\n",SDL_GetError());
	}


	if(level.now_is_blinking > 1) {
		level.now_is_blinking--;
		if(level.now_is_blinking == 1)
			board_needs_refresh();
	}

	if(score_was_changed) {
		destrect.x = 0;
		destrect.y = 440;
		destrect.w = screen->w;
		destrect.h = FIELD_SIZE;
		SDL_FillRect(screen, &destrect, 4);
		score_was_changed = 0;
		draw_score();
	}
	
	SDL_Flip(screen);
}


void update_robbo_banner() {


}

void Create_DescriptionPage()
{
	SDL_Rect srcrect;
	SDL_Rect destrect;
	int i;
	char ver[30];
	
	sprintf(ver,"version:  %.2f",VERSION);
	
	bgcolor.r = 0;
	bgcolor.g = 0;
	bgcolor.b = 0;

	for(i = (0+ offset_description); i < (13+offset_description); i++) {
		if(i>4) {
			fgcolor.r = 255;
			fgcolor.b = 0;
			fgcolor.g = 0;
		}
		else
		{
			fgcolor.r = 255;
			fgcolor.b = 255;
			fgcolor.g = 255;
		}
		image = TTF_RenderUTF8_Shaded(font, Text[i], fgcolor, bgcolor);
		srcrect = set_rect(0, 0, image->w, image->h);
		destrect = set_rect(0, (i - offset_description) * (FONTSIZE + 3), image->w, image->h);
		SDL_BlitSurface(image,&srcrect,image_startscreen,&destrect);
		SDL_FreeSurface(image);
		
			fgcolor.r = 255;
			fgcolor.g = 128;
			fgcolor.b = 0;
	}
		image = TTF_RenderUTF8_Shaded(font,VERSION,fgcolor,bgcolor);
		destrect = set_rect(490, 80, 50, 50);
		srcrect = set_rect(0,0,image->w, image->h);
		SDL_BlitSurface(image,&srcrect,screen,&destrect);
		SDL_FreeSurface(image);
		
		for(i=0; i<3;i++) {
			if(i==MenuPosition && !typing_code) {
				TTF_SetFontStyle(font, TTF_STYLE_BOLD);
				fgcolor.r = 255;
				fgcolor.g = 128;
				fgcolor.b = 0;

			}
			else {
				TTF_SetFontStyle(font, TTF_STYLE_NORMAL);
				fgcolor.b = 255;
				fgcolor.g = 255;
				fgcolor.b = 255;
			}
			
			image = TTF_RenderUTF8_Shaded(font,MenuText[i],fgcolor, bgcolor);
			destrect = set_rect(380, 270 + i * (FONTSIZE + 3), image->w, image->h);
			srcrect = set_rect(0,0,image->w, image->h);
			SDL_BlitSurface(image,&srcrect,screen,&destrect);
			SDL_FreeSurface(image);
		}
			
		TTF_SetFontStyle(font, TTF_STYLE_NORMAL);
		fgcolor.r = 0;
		fgcolor.g = 255;
		fgcolor.b = 0;	
		
		image = TTF_RenderUTF8_Shaded(font,"Level: ",fgcolor, bgcolor);
		destrect = set_rect(380, 350, image->w, image->h);
		srcrect = set_rect(0,0,image->w, image->h);
		SDL_BlitSurface(image,&srcrect,screen,&destrect);
		SDL_FreeSurface(image);

		sprintf(TextBuffer,"%i", robbo.level);
		
		image = TTF_RenderUTF8_Shaded(font,TextBuffer,fgcolor, bgcolor);
		destrect = set_rect(420, 350, image->w, image->h);
		srcrect = set_rect(0,0,image->w, image->h);
		SDL_BlitSurface(image,&srcrect,screen,&destrect);
		SDL_FreeSurface(image);

		image = TTF_RenderUTF8_Shaded(font,"Code: ",fgcolor, bgcolor);
		destrect = set_rect(378, 370, image->w, image->h);
		srcrect = set_rect(0,0,image->w, image->h);
		SDL_BlitSurface(image,&srcrect,screen,&destrect);
		SDL_FreeSurface(image);
		
		if(typing_code == 1) {
			fgcolor.r = 255;
			fgcolor.g = 128;
			fgcolor.b = 0;
			image = TTF_RenderUTF8_Shaded(font,TypeBuffer,fgcolor, bgcolor);
		}
		else
		{
			sprintf(TextBuffer,"%s",level.code);
			image = TTF_RenderUTF8_Shaded(font,TextBuffer,fgcolor, bgcolor);
		}

		destrect.x += 43;
		destrect.w = image->w;
		destrect.h = image->h;
		srcrect = set_rect(0,0,image->w, image->h);
		SDL_BlitSurface(image,&srcrect,screen,&destrect);

		SDL_FreeSurface(image);

		fgcolor.r = 255;
		fgcolor.g = 128;
		fgcolor.b = 0;	

		image = TTF_RenderUTF8_Shaded(font,"Idea and ATARI game: Janusz Pelc, LK AVALON, 1989",fgcolor, bgcolor);
		destrect = set_rect(100, 410, image->w, image->h);
		srcrect = set_rect(0,0,image->w, image->h);
		SDL_BlitSurface(image,&srcrect,screen,&destrect);
		SDL_FreeSurface(image);
		
		image = TTF_RenderUTF8_Shaded(font,"Linux code: Arkadiusz Lipiec, 2002",fgcolor, bgcolor);
		destrect = set_rect(155, 430, image->w, image->h);
		srcrect = set_rect(0,0,image->w, image->h);
		SDL_BlitSurface(image,&srcrect,screen,&destrect);
		SDL_FreeSurface(image);		
}

void show_startscreen()
{
	SDL_Rect srcrect;
	SDL_Rect destrect;
	int i, j, colour;

	destrect = set_rect(0, 0, screen->w, screen->h);
	SDL_FillRect(screen, &destrect, 0);
	
	for(i=0;i<8;i++)
		for(j=0;j<80;j++) {
			switch(banner[i][j]) {
				case '.':
					continue;
				default:
					colour = 0x00ff00;
			}
		  	destrect = set_rect(j*5+80, i*7+36, 4, 6);
		  	SDL_FillRect(screen, &destrect, colour);
		}

 	srcrect = set_rect(0,0,image_startscreen->w,image_startscreen->h);
	destrect = set_rect(60,128,image_startscreen->w,image_startscreen->h);
	SDL_FillRect(image_startscreen,&srcrect,0);
	Create_DescriptionPage();
        SDL_BlitSurface(image_startscreen,&srcrect,screen,&destrect);


	destrect = set_rect(50,108,480,4);	/* green strip */
	SDL_FillRect(screen,&destrect,0x00ff00);
	destrect = set_rect(50,400,480,4);
	SDL_FillRect(screen,&destrect,0x00ff00);	
	destrect = set_rect(50,240,480,4);	/* green strip */
	SDL_FillRect(screen,&destrect,0x00ff00);
	destrect = set_rect(526,240,4,160);
	SDL_FillRect(screen,&destrect,0x00ff00);
	destrect = set_rect(50,240,4,160);
	SDL_FillRect(screen,&destrect,0x00ff00);
	destrect = set_rect(310,240,4,160);
	SDL_FillRect(screen,&destrect,0x00ff00);

	SDL_Flip(screen);
}

void show_endscreen() {
	SDL_Rect srcrect;
	SDL_Rect destrect;
	int i, j, colour;

	destrect = set_rect(0, 0, screen->w, screen->h);
	SDL_FillRect(screen, &destrect, 0);

	bgcolor.r = 0;
	bgcolor.g = 0;
	bgcolor.b = 0;

	for(i = 0; i < 4; i++) {
		if(i>2) {
			fgcolor.r = 255;
			fgcolor.b = 0;
			fgcolor.g = 0;
		}
		else
		{
			fgcolor.r = 255;
			fgcolor.b = 255;
			fgcolor.g = 255;
		}
		image = TTF_RenderUTF8_Shaded(font, EndScreen[i], fgcolor, bgcolor);
		srcrect = set_rect(0, 0, image->w, image->h);
		destrect = set_rect(60, i * (FONTSIZE + 3) + 200, image->w, image->h);
		SDL_BlitSurface(image,&srcrect,screen,&destrect);
		SDL_FreeSurface(screen);	
	}
	
	SDL_Flip(screen);
}

