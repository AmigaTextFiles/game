#include "robot.h"

static int keys = 0;

void resetinput(void)
{
	keys = 0;
}

int getinput(void)
{
	SDL_Event event;
	int pause = 0;
	int restart = 0;

	while (SDL_PollEvent(&event))
	{
		if (event.type == SDL_QUIT)
			exit(0);
		if (event.type == SDL_KEYDOWN)
		{
			if (event.key.keysym.sym == SDLK_UP)
				keys |= KEY_UP;
			else if (event.key.keysym.sym == SDLK_DOWN)
				keys |= KEY_DOWN;
			else if (event.key.keysym.sym == SDLK_LEFT)
				keys |= KEY_LEFT;
			else if (event.key.keysym.sym == SDLK_RIGHT)
				keys |= KEY_RIGHT;
#ifdef CHEAT
			else if (event.key.keysym.sym == SDLK_k)
				return 10000;
#endif
			else if (event.key.keysym.sym == SDLK_F2)
				screen_save();
			else if (event.key.keysym.sym == SDLK_ESCAPE)
			{
				restart = 1;
				pause = 0;
			}
			else if (!restart && event.key.keysym.sym == SDLK_SPACE)
				pause = 1;
		}
		else if (event.type == SDL_KEYUP)
		{
			if (event.key.keysym.sym == SDLK_UP)
				keys &= ~KEY_UP;
			else if (event.key.keysym.sym == SDLK_DOWN)
				keys &= ~KEY_DOWN;
			else if (event.key.keysym.sym == SDLK_LEFT)
				keys &= ~KEY_LEFT;
			else if (event.key.keysym.sym == SDLK_RIGHT)
				keys &= ~KEY_RIGHT;
		}
	}

	if (pause)
		showpausedtext();

	while (pause)
	{
		SDL_Delay(10);
		while (SDL_PollEvent(&event))
		{
			if (event.type == SDL_QUIT)
				exit(0);
			if (event.type == SDL_KEYDOWN
				&& event.key.keysym.sym == SDLK_ESCAPE)
			{
				pause = 0;
				restart = 1;
			}
			if (event.type == SDL_KEYDOWN
				&& event.key.keysym.sym == SDLK_SPACE)
			{
				pause = 0;
			}
		}

		if (!pause)
		{
			restorescreen();
			timer_start(); /* don't confuse the timer */
		}
	}

	if (restart)
		return -1;
	return keys;
}
