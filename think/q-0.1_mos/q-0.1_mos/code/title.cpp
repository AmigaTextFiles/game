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

#include "title.h"

int doTitle()
{
	SDL_Surface *q = graphics.getSprite("Q", true)->image[0];

	if (!engine.loadWidgets("data/titleWidgets"))
		graphics.showErrorAndExit(ERR_FILE, "data/titleWidgets");
		
	int start, edit, options, quit;
	start = edit = options = quit = 0;
	
	engine.setWidgetVariable("newGame", &start);
	engine.setWidgetVariable("editor", &edit);
	engine.setWidgetVariable("options", &options);
	engine.setWidgetVariable("quit", &quit);
	
	engine.enableWidget("editor", false);
	engine.enableWidget("options", false);

	graphics.drawBackground();
	graphics.blit(q, 320, 65, graphics.screen, true);
	drawWidgets();

	engine.clearInput();
	engine.flushInput();

	while (true)
	{
		graphics.updateScreen();
		engine.getInput();

		if (engine.processWidgets())
		{
			graphics.drawBackground();
			drawWidgets();
			graphics.blit(q, 320, 65, graphics.screen, true);
		}

		if ((start) || (edit) || (quit))
			break;
	}

	if (quit)
		exit(0);

	graphics.clearScreen(graphics.black);
	graphics.delay(500);

	if (start)
		return 1;

	if (edit)
		return 2;
		
	return 0;
}
