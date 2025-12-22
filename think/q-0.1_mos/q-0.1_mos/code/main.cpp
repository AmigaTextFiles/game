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

#include "main.h"

void showHelp()
{
	printf("\n");
	printf("Q (Version %.1f, Release %d)\n", VERSION, RELEASE);
	printf("Copyright (C) 2003 Parallel Realities\n");
	printf("Licensed under the GPL\n\n");
	
	printf("Additional Commands\n");
	printf("\t-fullscreen         Start the game in Full Screen mode\n");
	printf("\n");

	exit(0);
}

void showVersion()
{
	printf("\n");
	printf("Q (Version %.1f, Release %d)\n", VERSION, RELEASE);
	printf("Copyright (C) 2003 Parallel Realities\n");
	printf("Licensed under the GPL\n\n");

	exit(0);
}

int main(int argc, char *argv[])
{
	for (int i = 1 ; i < argc ; i++)
	{
		if (strcmp(argv[i], "-fullscreen") == 0) engine.fullScreen = true;
		else if (strcmp(argv[i], "-version") == 0) showVersion();
		else if (strcmp(argv[i], "--help") == 0) showHelp();
	}

	atexit(cleanup);

	initSystem();
	
	int requiredSection = 0;

	graphics.quickSprite("Red Ball", graphics.loadImage("gfx/redBall.png"));
	graphics.quickSprite("Yellow Ball", graphics.loadImage("gfx/yellowBall.png"));
	graphics.quickSprite("Green Ball", graphics.loadImage("gfx/greenBall.png"));
	graphics.quickSprite("Blue Ball", graphics.loadImage("gfx/blueBall.png"));
	graphics.quickSprite("Q",  graphics.loadImage("gfx/q.png"));
	
	Sprite *arrow = graphics.addSprite("Arrows");
	arrow->setFrame(0, graphics.loadImage("gfx/arrowUp.png"), 60);
	arrow->setFrame(1, graphics.loadImage("gfx/arrowRight.png"), 60);
	arrow->setFrame(2, graphics.loadImage("gfx/arrowDown.png"), 60);
	arrow->setFrame(3, graphics.loadImage("gfx/arrowLeft.png"), 60);

	map.ballSprite[RED_BALL] = graphics.getSprite("Red Ball", true);
	map.ballSprite[YELLOW_BALL] = graphics.getSprite("Yellow Ball", true);
	map.ballSprite[GREEN_BALL] = graphics.getSprite("Green Ball", true);
	map.ballSprite[BLUE_BALL] = graphics.getSprite("Blue Ball", true);

	graphics.tile[1] = graphics.loadImage("gfx/wall1.png");
	graphics.tile[2] = graphics.loadImage("gfx/redWall.png");
	graphics.tile[3] = graphics.loadImage("gfx/yellowWall.png");
	graphics.tile[4] = graphics.loadImage("gfx/greenWall.png");
	graphics.tile[5] = graphics.loadImage("gfx/blueWall.png");
	
	graphics.loadBackground("gfx/title.png");

	map.ball[RED_BALL].ballType = MAP_RED;
	map.ball[YELLOW_BALL].ballType = MAP_YELLOW;
	map.ball[GREEN_BALL].ballType = MAP_GREEN;
	map.ball[BLUE_BALL].ballType = MAP_BLUE;

	while (true)
	{
		switch (requiredSection)
		{
			case 0:
				requiredSection = doTitle();
				break;
			case 1:
				requiredSection = doGame();
				break;
			case 2:
				requiredSection = editMap();
				break;
		}
	}

	return 0;
}
