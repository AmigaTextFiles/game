/*
 *  This file is part of Dune Legacy.
 *
 *  Dune Legacy is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  Dune Legacy is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Dune Legacy.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <Menu/MenuClass.h>

#include <globals.h>

#include <sand.h>



bool MenuClass::key_alt = false;

MenuClass::MenuClass() : Window(0,0,0,0)
{
	bAllowQuiting = true;
	retVal = -1;
	bClearScreen = true;
}

MenuClass::~MenuClass()
{
	;
}

void MenuClass::quit(int returnVal)
{
	retVal = returnVal;
	quiting = true;
}

int MenuClass::showMenu()
{
	SDL_Event	event;
	quiting = false;

	while (!quiting)
	{
	    int frameStart = SDL_GetTicks();

		draw();

		while(SDL_PollEvent(&event)) {
		    //check the events
			if(doInput(event) == false) {
				break;
			}
		}

		int frameTime = SDL_GetTicks() - frameStart;
        if(settings.Video.FrameLimit == true) {
            if(frameTime < 32) {
                SDL_Delay(32 - frameTime);
            }
        }
	}

	return retVal;
}

void MenuClass::draw()
{
	if(bClearScreen == true) {
		SDL_FillRect(screen, NULL, 0);
	}

	Window::Draw(screen);

	DrawSpecificStuff();

	drawCursor();

	SDL_Flip(screen);
}

void MenuClass::DrawSpecificStuff()
{
	;
}

bool MenuClass::doInput(SDL_Event &event)
{
	switch (event.type)
	{
		case (SDL_KEYDOWN):	// Look for a keypress
		{
			switch(event.key.keysym.sym) {

				case SDLK_LALT: case SDLK_RALT:
					key_alt = true;
					break;

				case SDLK_ESCAPE:
					if((pChildWindow == NULL) && (bAllowQuiting == true)) {
						quit();
					}
					break;

				case SDLK_RETURN:
					if (key_alt) {
						SDL_WM_ToggleFullScreen(screen);
						printf("switch\n");
					}
					break;

				case SDLK_PRINT: case SDLK_SYSREQ:
					SDL_SaveBMP(screen, "screenshot.bmp");
					printf("screenshot taken\n");
					break;

				default:
					break;
			}
		} break;

		case (SDL_KEYUP):	// Look for a keyrelease
		{
			switch(event.key.keysym.sym)
			{
				case SDLK_LALT:
				case SDLK_RALT:
					cursorFrame = CURSOR_NORMAL;
					key_alt = false;
					break;

				default:
					break;
			}
		} break;

		case SDL_MOUSEMOTION:
		{
			SDL_MouseMotionEvent* mouse = &event.motion;

			drawnMouseX = mouse->x;
			drawnMouseY = mouse->y;
		} break;

		case SDL_QUIT:
			if((pChildWindow == NULL) && (bAllowQuiting == true)) {
				quit();
			}
			break;

		default:
			break;
	}

	HandleInput(event);

	return !quiting;
}
