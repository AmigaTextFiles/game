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

#include "headers.h"

Map::Map()
{
	for (int x = 0 ; x < MAPWIDTH ; x++)
	{
		for (int y = 0 ; y < MAPHEIGHT ; y++)
		{
			data[x][y] = 0;
		}
	}

	hours = minutes = seconds = 0;
	lastTime = SDL_GetTicks() + 1000;

	for (int i = 0 ; i < 4 ; i++)
		arrowX[i] = arrowY[i] = -1;

	for (int i = 0 ; i < MAX_BALLS ; i++)
		ball[i].remove();

	mapNumber = 0;
}

void Map::clear()
{
	for (int x = 0 ; x < MAPWIDTH ; x++)
	{
		for (int y = 0 ; y < MAPHEIGHT ; y++)
		{
			data[x][y] = 0;
		}
	}

	hours = minutes = seconds = 0;
	lastTime = SDL_GetTicks() + 1000;

	for (int i = 0 ; i < 4 ; i++)
		arrowX[i] = arrowY[i] = -1;

	for (int i = 0 ; i < MAX_BALLS ; i++)
		ball[i].remove();
}

void Map::registerEngine(Engine *engine)
{
	this->engine = engine;
}

void Map::incrementTime()
{
	if (SDL_GetTicks() < lastTime)
		return;

	seconds++;

	if (seconds == 60)
	{
		seconds = 0;
		minutes++;
	}

	if (minutes == 60)
	{
		minutes = 0;
		hours++;
	}
	
	lastTime = SDL_GetTicks() + 1000;
}

void Map::resetMapStats()
{
	hours = minutes = seconds = 0;
	lastTime = SDL_GetTicks() + 1000;
	moves = 0;
	
	for (int i = 0 ; i < 4 ; i++)
		arrowX[i] = arrowY[i] = -1;
}

void Map::clearArrows()
{
	for (int i = 0 ; i < 4 ; i++)
		arrowX[i] = arrowY[i] = -1;
}

void Map::setArrow(int i, int x, int y)
{
	if (data[x][y] == MAP_WALL)
		return;

	for (int b = 0 ; b < 4 ; b++)
		if ((ball[b].x == x) && (ball[b].y == y))
			return;

	arrowX[i] = (x * 32) + 16;
	arrowY[i] = (y * 32) + 16;
}

void Map::setArrows(Ball *ball)
{
	setArrow(0, ball->x, ball->y - 1);
	setArrow(1, ball->x + 1, ball->y);
	setArrow(2, ball->x, ball->y + 1);
	setArrow(3, ball->x - 1, ball->y);
}

void Map::addBall(int ballType, int x, int y)
{
	for (int i = 0 ; i < MAX_BALLS ; i++)
	{
		if ((ball[i].x == x) && (ball[i].y == y))
			return;
	}

	for (int i = 0 ; i < MAX_BALLS ; i++)
	{
		if (ball[i].x == -1)
		{
			ball[i].place(ballType, x, y, ballSprite[ballType]);
			return;
		}
	}
}

int Map::getBallType(char *ballType)
{
	for (int i = 0 ; i < 4 ; i++)
	{
		if (strcmp(ballTypes[i], ballType) == 0)
			return i;
	}

	return -1;
}

void Map::removeBallAt(int x, int y)
{
	for (int i = 0 ; i < MAX_BALLS ; i++)
	{
		if ((ball[i].x == x) && (ball[i].y == y))
		{
			ball[i].remove();
		}
	}
}

bool Map::saveMap()
{
	char mapName[PATH_MAX];
	sprintf(mapName, "data/%.4d", mapNumber);
	
	FILE *fp = fopen(mapName, "wb");
	if (!fp)
	{
		printf("Couldn't open %s for writing...\n", mapName);
		return false;
	}

	for (int y = 0 ; y < MAPHEIGHT ; y++)
	{
		for (int x = 0 ; x < MAPWIDTH ; x++)
		{
			fprintf(fp, "%d ", data[x][y]);
		}
		fprintf(fp, "\n");
	}

	for (int i = 0 ; i < MAX_BALLS ; i++)
	{
		if (ball[i].ballType > -1)
			fprintf(fp, "%s %d %d\n", ballTypes[ball[i].ballType], ball[i].x, ball[i].y);
		else
			fprintf(fp, "NONE -1 -1\n");
	}
		
	fclose(fp);
	
	printf("Saved '%s'\n", mapName);
		
	return true;
}

bool Map::loadMap()
{
	clear();

	char mapName[PATH_MAX], ballType[25];
	char *line;
	int x, y, ballX, ballY, tileIndex, ballDef;

	sprintf(mapName, "data/map%.4d", mapNumber);

	if (!engine->loadData(mapName))
	{
		printf("Failed to read '%s'\n", mapName);
		return false;
	}

	line = strtok(engine->dataBuffer, "\n");

	y = 0;

	while (line)
	{
		x = 0;

		while (true)
		{
			sscanf(line, "%d", &tileIndex);

			data[x][y] = tileIndex;

			while (true)
			{
				*line++;

				if (*line == ' ')
					break;
			}

			x++;

			if (x == MAPWIDTH)
				break;
		}

		y++;

		if (y == MAPHEIGHT)
			break;

		line = strtok(NULL, "\n");
	}

	for (int i = 0 ; i < MAX_BALLS ; i++)
	{
		line = strtok(NULL, "\n");
		sscanf(line, "%s %d %d", ballType, &ballX, &ballY);
		ballDef = getBallType(ballType);
		if (ballDef != UNDEFINED_BALL)
			ball[i].place(ballDef, ballX, ballY, ballSprite[ballDef]);
	}

	return true;
}

bool Map::loadPreviousMap()
{
	mapNumber--;
	if (mapNumber < 1)
		mapNumber = 1;
	return loadMap();
}

bool Map::loadNextMap()
{
	mapNumber++;
	return loadMap();
}
