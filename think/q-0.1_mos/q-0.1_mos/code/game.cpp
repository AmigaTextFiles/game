/*
Copyright (C) 2003 Parallel Realities

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

*/

#include "game.h"

int showInGameOptions()
{
	engine.flushInput();
	engine.clearInput();

	if (!engine.loadWidgets("data/inGameWidgets"))
		graphics.showErrorAndExit(ERR_FILE, "data/inGameWidgets");

	graphics.drawRect(120, 100, 400, 300, graphics.black, graphics.white, graphics.screen);

	int cont, options, quit, quitno, quityes, restart, restartyes, restartno;
	cont = options = quit = quitno = quityes = restart = restartyes = restartno = 0;

	engine.setWidgetVariable("continue", &cont);
	engine.setWidgetVariable("restart", &restart);
	engine.setWidgetVariable("options", &options);
	engine.setWidgetVariable("quit", &quit);
	
	engine.enableWidget("options", false);

	engine.setWidgetVariable("quitno", &quitno);
	engine.setWidgetVariable("quityes", &quityes);
	engine.showWidgetGroup("quitconf", false);
	
	engine.setWidgetVariable("restartno", &restartno);
	engine.setWidgetVariable("restartyes", &restartyes);
	engine.showWidgetGroup("restartconf", false);

	engine.flushInput();
	engine.clearInput();

	drawWidgets();

	while (true)
	{
		graphics.updateScreen();
		engine.getInput();

		if (engine.keyState[SDLK_ESCAPE])
		{
			engine.keyState[SDLK_ESCAPE] = 0;
			break;
		}

		if (engine.processWidgets())
		{
			graphics.drawRect(120, 100, 400, 300, graphics.black, graphics.white, graphics.screen);
			drawWidgets();
		}

		if (cont)
			break;

		if (options)
			break;

		if (quitno)
		{
			engine.highlightWidget("continue");
			engine.showWidgetGroup("options", true);
			engine.showWidgetGroup("quitconf", false);
			graphics.drawRect(120, 100, 400, 300, graphics.black, graphics.white, graphics.screen);
			drawWidgets();
			quitno = 0;
		}

		if (quityes)
			return 2;

		if (quit)
		{
			engine.showWidgetGroup("options", false);
			engine.showWidgetGroup("quitconf", true);
			engine.highlightWidget("quitno");

			graphics.drawRect(120, 100, 400, 300, graphics.black, graphics.white, graphics.screen);
			drawWidgets();
			quit = 0;
		}

		if (restartno)
		{
			engine.highlightWidget("continue");
			engine.showWidgetGroup("options", true);
			engine.showWidgetGroup("restartconf", false);
			graphics.drawRect(120, 100, 400, 300, graphics.black, graphics.white, graphics.screen);
			drawWidgets();
			quitno = 0;
		}

		if (restartyes)
			return 1;

		if (restart)
		{
			engine.showWidgetGroup("options", false);
			engine.showWidgetGroup("restartconf", true);
			engine.highlightWidget("restartno");

			graphics.drawRect(120, 100, 400, 300, graphics.black, graphics.white, graphics.screen);
			drawWidgets();
			restart = 0;
		}
	}
	
	return 0;
}

void checkWallCollision(Ball *ball)
{
	if (map.data[ball->x][ball->y] == 0)
		return;

	if (map.data[ball->x][ball->y] == ball->ballType + 2)
		ball->remove();

	ball->x -= ball->dx;
	ball->y -= ball->dy;
	ball->dx = ball->dy = 0;
}

void checkOtherBallCollision(Ball *ball)
{
	for (int i = 0 ; i < MAX_BALLS ; i++)
		if ((ball != &map.ball[i]) && (map.ball[i].onBoard))
			if ((ball->x == map.ball[i].x) && (ball->y == map.ball[i].y))
				ball->backup();
}

bool moveBall(Ball *ball)
{
	if (ball->move())
	{
		checkWallCollision(ball);
		checkOtherBallCollision(ball);

		return true;
	}

	return false;
}

void drawMap()
{
	for (int x = 0 ; x < MAPWIDTH ; x++)
	{
		for (int y = 0 ; y < MAPHEIGHT ; y++)
		{
			if (map.data[x][y] == 0)
				continue;

			graphics.blit(graphics.tile[map.data[x][y]], x * 32, y * 32, graphics.screen, false);
		}
	}
}

void drawBalls()
{
	for (int i = 0 ; i < MAX_BALLS ; i++)
	{
		if (map.ball[i].onBoard)
		{
			graphics.blit(map.ball[i].image(), (map.ball[i].x * 32) + 16, (map.ball[i].y * 32) + 16, graphics.screen, true);
		}
	}
}

void drawArrows()
{
	Sprite *arrow = graphics.getSprite("Arrows", true);

	for (int i = 0 ; i < 4 ; i++)
		if (map.arrowX[i] != -1)
			graphics.blit(arrow->image[i], map.arrowX[i], map.arrowY[i], graphics.screen, true);
}

void checkArrowsClicked(Ball *ball)
{
	int x = engine.getMouseX() / 32;
	int y = engine.getMouseY() / 32;
	
	int aX, aY;

	for (int i = 0 ; i < 4 ; i++)
	{
		if (map.arrowX[i] != -1)
		{
			aX = (map.arrowX[i] - 16) / 32;
			aY = (map.arrowY[i] - 16) / 32;

			if ((x == aX) && (y == aY))
			{
				switch (i)
				{
					case 0:
						ball->dy = -1;
						break;
					case 1:
						ball->dx = 1;
						break;
					case 2:
						ball->dy = 1;
						break;
					case 3:
						ball->dx = -1;
						break;
				}
				
				map.moves++;
			}
		}
	}
}

Ball *selectBall(int cursorX, int cursorY)
{
	for (int i = 0 ; i < MAX_BALLS ; i++)
		if ((map.ball[i].x == cursorX) && (map.ball[i].y == cursorY)) return &map.ball[i];

	return NULL;
}

bool mapComplete()
{
	for (int i = 0 ; i < MAX_BALLS ; i++)
	{
		if (map.ball[i].onBoard)
			return false;
	}

	return true;
}

void drawPanel()
{
	SDL_Surface *q = graphics.getSprite("Q", true)->image[0];
	
	graphics.setFontColor(0xff, 0xff, 0xff, 0x00, 0x00, 0x00);

	graphics.drawLine(480, 0, 480, 480, graphics.white, graphics.screen);
	graphics.blit(q, 560, 60, graphics.screen, TXT_CENTERED);

	graphics.setFontSize(2);
	graphics.drawString(560, 150, TXT_CENTERED, graphics.screen, "Level : %d", map.mapNumber);

	graphics.setFontSize(2);
	graphics.drawString(560, 200, TXT_CENTERED, graphics.screen, "Moves : %d", map.moves);

	graphics.setFontSize(1);
	graphics.drawString(560, 450, TXT_CENTERED, graphics.screen, "Time : %.2d:%.2d:%.2d", map.hours, map.minutes, map.seconds);
}

void wipe()
{
	int x = 0;

	while (x < 16)
	{
		graphics.clearScreen(graphics.black);

		drawMap();
		drawBalls();
		drawPanel();

		for (int x2 = 0 ; x2 < x ; x2++)
			for (int y = 0 ; y < 15 ; y++)
				graphics.blit(graphics.tile[1], (int)(x2 * 32), y * 32, graphics.screen, false);

		graphics.delay(50);
		engine.getInput();

		x++;
	}
}

void unWipe()
{
	int x = 0;

	while (x < 16)
	{
		graphics.clearScreen(graphics.black);

		drawMap();
		drawBalls();
		drawPanel();

		for (int x2 = x ; x2 < 15 ; x2++)
			for (int y = 0 ; y < 15 ; y++)
				graphics.blit(graphics.tile[1], (int)(x2 * 32), y * 32, graphics.screen, false);

		graphics.delay(50);
		engine.getInput();

		x++;
	}
}

int doGame()
{
	map.mapNumber = 0;

	if (!map.loadNextMap())
	{
		printf("Couldn't Load Map\n");
		exit(1);
	}

	drawMap();

	int cursorX, cursorY;

	cursorX = cursorY = 8 * 32;

	bool showCursor = true;

	Ball *selectedBall = NULL;

	map.resetMapStats();
	
	bool quit = false;

	while (!quit)
	{
		graphics.updateScreen();
		graphics.animateSprites();

		map.incrementTime();

		showCursor = true;

		for (int i = 0 ; i < MAX_BALLS ; i++)
			if (moveBall(&map.ball[i]))
				showCursor = false;

		engine.clearInput();

		graphics.clearScreen(graphics.black);
		drawMap();
		drawBalls();
		drawPanel();

		engine.getInput();
		
		if (engine.keyState[SDLK_ESCAPE])
		{
			switch (showInGameOptions())
			{
				case 1:
					if (!map.loadMap())
					{
						graphics.delay(500);
						break;
					}
					map.resetMapStats();
					drawMap();
					drawBalls();
					break;
				case 2:
					quit = true;
					break;
			}
		}

		if (showCursor)
		{
			if (engine.mouseLeft)
			{
				checkArrowsClicked(selectedBall);

				map.clearArrows();

				selectedBall = selectBall(engine.getMouseX() / 32, engine.getMouseY() / 32);
				if (selectedBall != NULL)
					map.setArrows(selectedBall);

				engine.mouseLeft = 0;
			}
			
			drawArrows();

			if (mapComplete())
			{
				wipe();
				if (!map.loadNextMap())
				{
					graphics.delay(500);
					break;
				}
				map.resetMapStats();
				unWipe();
				drawMap();
				drawBalls();
			}
		}
		else
		{
			graphics.delay(50);
		}
	}
	
	graphics.clearScreen(graphics.black);
	graphics.delay(500);
	
	return 0;
}
