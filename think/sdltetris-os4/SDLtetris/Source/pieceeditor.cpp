#include "pieceeditor.h"
#include "pieces.h"
#include <SDL.h>
#include <SDL_image.h>
#include <stdio.h>
#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main (int argc, char * argv[])
{
	loadSDL();
	loadSpecs();
	curPiece = 0;
	changePiece(0);
	updateWin();
	int selected = -1;
	SDL_Event event;
	while (SDL_WaitEvent(&event) != 0)
	{
		SDL_keysym keysym = event.key.keysym;
		if (event.type == SDL_KEYDOWN)
		{
			if (keysym.sym == 276) // left arrow
			{
				if (keysym.mod & KMOD_LSHIFT)
				{
					thePiece.axis_x--;
				} else {
					changePiece(-1);
				}
				updateWin();
			} else if (keysym.sym == 275) { // right arrow
				if (keysym.mod & KMOD_LSHIFT)
				{
					thePiece.axis_x++;
				} else {
					changePiece(1);
				}
				updateWin();
			} else if (keysym.sym == 273) { // up arrow
				if (keysym.mod & KMOD_LSHIFT)
				{
					thePiece.axis_y--;
				} else {
					thePiece.turn(0);
				}
				updateWin();
			} else if (keysym.sym == 274) { // down arrow
				if (keysym.mod & KMOD_LSHIFT)
				{
					thePiece.axis_y++;
				} else {
					thePiece.turn(1);
				}
				updateWin();
			} else if (keysym.sym == SDLK_5)
			{
				thePiece.onHalf ? thePiece.onHalf = false : thePiece.onHalf = true;
				updateWin();
				specs[curPiece] = thePiece.getSpec();
			} else if (keysym.sym == SDLK_2)
			{
				thePiece.twoPos ? thePiece.twoPos = false : thePiece.twoPos = true;
				updateWin();
				specs[curPiece] = thePiece.getSpec();
			} else if (keysym.sym == SDLK_s)
			{
				saveSpecs();
			} else if (keysym.sym == SDLK_q)
			{
				return 0;
			}
		} else if (event.type == SDL_MOUSEBUTTONDOWN) {
			int x = event.button.x/20;
			int y = event.button.y/20;
			if (selected != -1)
			{
				thePiece.map[selected][0] = x;
				thePiece.map[selected][1] = y;
				specs[curPiece] = thePiece.getSpec();
				selected = -1;
				updateWin();
			} else {
				for (int i = 0; i < 4; i++)
				{
					if (thePiece.map[i][0] == x && thePiece.map[i][1] == y)
					{
						selected = i;
						break;
					}
				}
			}
		} else if (event.type == SDL_QUIT) {
			return 0;
		}
	}
	return(0);
}

void changePiece (int change)
{
	curPiece += change;
	if (curPiece >= 7) curPiece = 0;
	if (curPiece < 0) curPiece = 6;
	if (specs[curPiece] != "")
	{
		thePiece = piece(specs[curPiece],0,0,NULL);
	} else {
		thePiece = piece();
		thePiece.graphic = curPiece;
	}
}

void updateWin (void)
{
	SDL_Rect src, dest;
	SDL_GetClipRect(black, &src);
	SDL_GetClipRect(black, &dest);
	SDL_BlitSurface(black, &src, win, &dest);
	SDL_GetClipRect(blocks, &src);
	src.h = 20;
	src.y = thePiece.graphic*20;
	dest.h = src.h;
	dest.w = src.w;
	for (int i = 0; i < 4; i++)
	{
		dest.x = thePiece.map[i][0]*20;
		dest.y = thePiece.map[i][1]*20;
		SDL_BlitSurface(blocks, &src, win, &dest);
	}
	src.x = 0;
	src.y = 0;
	dest.x = thePiece.axis_x*20+10*thePiece.onHalf;
	dest.y = thePiece.axis_y*20+10*thePiece.onHalf;
	if (thePiece.twoPos)
	{
		SDL_BlitSurface(axis2, &src, win, &dest);
	} else {
		SDL_BlitSurface(axis, &src, win, &dest);
	}
	SDL_Flip(win);
}

void loadSpecs (void)
{
	ifstream file("data/pieces");
	string line;
	for (int i = 0; i < 7; i++)
	{
		if (getline(file, line) != 0)
		{
			specs[i] = line;
		} else {
			specs[i] = "";
		}
	}
}

void saveSpecs(void)
{
	ofstream file("data/pieces");
	for (int i = 0; i < 7; i++)
	{
		if (specs[i] != "")
		{
			file << specs[i] << "\n";
		}
	}
}

void loadSDL (void)
{
	if (SDL_Init(SDL_INIT_VIDEO) != 0)
	{
		printf("Unable to initialize SDL: %s (also, we're all gonna die)\n", SDL_GetError());
		return;
	}
	atexit(SDL_Quit);
	win = SDL_SetVideoMode(80, 80, 16, SDL_DOUBLEBUF | SDL_HWSURFACE);
	
	SDL_Surface *temp = SDL_CreateRGBSurface(SDL_SWSURFACE, 80, 80, 8, 0x0, 0x0, 0x0, 0x0);
	black = SDL_DisplayFormat(temp);
	SDL_FreeSurface(temp);
	temp = IMG_Load("data/blocks.png");
	blocks = SDL_DisplayFormat(temp);
	SDL_FreeSurface(temp);
	axis = IMG_Load("data/axis.png");
	axis2 = IMG_Load("data/axis2.png");
}