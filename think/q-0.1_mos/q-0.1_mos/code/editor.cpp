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

#include "editor.h"

bool showEditorOptions()
{
	engine.flushInput();
	engine.clearInput();

	if (!engine.loadWidgets("data/editorWidgets"))
		graphics.showErrorAndExit(ERR_FILE, "data/editorWidgets");

	graphics.drawRect(120, 100, 400, 300, graphics.black, graphics.white, graphics.screen);

	int cont, save, clear, options, detail, quit, saveno, saveyes, clearno, clearyes, quitno, quityes, saveOKButton;
	cont = save = clear = options = detail = quit = saveno = saveyes = clearno = clearyes = quitno = quityes = saveOKButton = 0;

	engine.setWidgetVariable("continue", &cont);
	engine.setWidgetVariable("save", &save);
	engine.setWidgetVariable("clear", &clear);
	engine.setWidgetVariable("detail", &detail);
	engine.setWidgetVariable("options", &options);
	engine.setWidgetVariable("quit", &quit);

	engine.setWidgetVariable("saveno", &saveno);
	engine.setWidgetVariable("saveyes", &saveyes);
	engine.setWidgetVariable("clearno", &clearno);
	engine.setWidgetVariable("clearyes", &clearyes);
	
	engine.setWidgetVariable("saveOKButton", &saveOKButton);

	engine.showWidgetGroup("saveconf", false);
	engine.showWidgetGroup("clearconf", false);
	engine.showWidgetGroup("quitconf", false);
	engine.showWidgetGroup("saveOK", false);
	engine.showWidgetGroup("saveFail", false);
	engine.showWidgetGroup("saveOKButton", false);

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
			
		if (save)
		{
			engine.setWidgetVariable("saveno", &saveno);
			engine.setWidgetVariable("saveyes", &saveyes);

			engine.showWidgetGroup("options", false);
			engine.showWidgetGroup("saveconf", true);
			engine.highlightWidget("saveno");

			graphics.drawRect(120, 100, 400, 300, graphics.black, graphics.white, graphics.screen);
			drawWidgets();
			save = 0;
		}

		if ((saveno) || (saveOKButton))
		{
			engine.highlightWidget("continue");
			engine.showWidgetGroup("options", true);
			engine.showWidgetGroup("saveconf", false);
			engine.showWidgetGroup("saveOK", false);
			engine.showWidgetGroup("saveFail", false);
			engine.showWidgetGroup("saveOKButton", false);
			graphics.drawRect(120, 100, 400, 300, graphics.black, graphics.white, graphics.screen);
			drawWidgets();
			saveno = saveOKButton = 0;
		}

		if (saveyes)
		{
			engine.highlightWidget("saveOKButton");

			if (map.saveMap())
			{
				engine.showWidgetGroup("saveOK", true);
				engine.showWidgetGroup("saveconf", false);
			}
			else
			{
				engine.showWidgetGroup("saveFail", true);
				engine.showWidgetGroup("saveconf", false);
			}

			engine.showWidgetGroup("saveOKButton", true);
			
			graphics.drawRect(120, 100, 400, 300, graphics.black, graphics.white, graphics.screen);
			drawWidgets();
			saveyes = 0;
		}
			
		if (clear)
		{
			engine.setWidgetVariable("clearno", &clearno);
			engine.setWidgetVariable("clearyes", &clearyes);

			engine.showWidgetGroup("options", false);
			engine.showWidgetGroup("clearconf", true);
			engine.highlightWidget("clearno");

			graphics.drawRect(120, 100, 400, 300, graphics.black, graphics.white, graphics.screen);
			drawWidgets();
			clear = 0;
		}

		if (clearno)
		{
			engine.highlightWidget("continue");
			engine.showWidgetGroup("options", true);
			engine.showWidgetGroup("clearconf", false);
			graphics.drawRect(120, 100, 400, 300, graphics.black, graphics.white, graphics.screen);
			drawWidgets();
			clearno = 0;
		}

		if (clearyes)
		{
			map.clear();
			break;
		}
			
		if (quityes)
			return true;

		if (quitno)
		{
			engine.highlightWidget("continue");
			engine.showWidgetGroup("options", true);
			engine.showWidgetGroup("quitconf", false);
			graphics.drawRect(120, 100, 400, 300, graphics.black, graphics.white, graphics.screen);
			drawWidgets();
			quitno = 0;
		}

		if (quit)
		{
			engine.setWidgetVariable("quitno", &quitno);
			engine.setWidgetVariable("quityes", &quityes);

			engine.showWidgetGroup("options", false);
			engine.showWidgetGroup("quitconf", true);
			engine.highlightWidget("quitno");

			graphics.drawRect(120, 100, 400, 300, graphics.black, graphics.white, graphics.screen);
			drawWidgets();
			quit = 0;
		}
	}
	
	return false;
}

void drawEditPanel()
{
	graphics.setFontColor(0xff, 0xff, 0xff, 0x00, 0x00, 0x00);

	SDL_Surface *q = graphics.getSprite("Q", true)->image[0];

	graphics.drawLine(480, 0, 480, 480, graphics.white, graphics.screen);
	graphics.blit(q, 560, 60, graphics.screen, TXT_CENTERED);

	graphics.setFontSize(2);
	graphics.drawString(560, 150, TXT_CENTERED, graphics.screen, "Level : %d", map.mapNumber);
}

int editMap()
{
	int mouseX;
	int mouseY;
	int currentBrick = 1;
	int editing = 0;

	map.mapNumber = 0;
	map.loadNextMap();

	while (true)
	{
		engine.getInput();
		graphics.updateScreen();
		graphics.clearScreen(graphics.black);

		drawEditPanel();
		drawMap();
		drawBalls();

		mouseX = engine.getMouseX();
		mouseY = engine.getMouseY();

		Math::limitInt(&mouseX, 0, (MAPWIDTH - 1) * 32);
		Math::limitInt(&mouseY, 0, MAPHEIGHT * 32);

		mouseX /= 32;
		mouseY /= 32;

		switch (editing)
		{
			case 0:
				graphics.blit(graphics.tile[currentBrick], mouseX * 32, mouseY * 32, graphics.screen, false);
				break;
				
			case 1:
			case 2:
			case 3:
			case 4:
				graphics.blit(map.ballSprite[editing - 1]->getCurrentFrame(), mouseX * 32, mouseY * 32, graphics.screen, false);
				break;
		}

		if (engine.mouseLeft)
		{
			switch (editing)
			{
				case 0:
					map.data[mouseX][mouseY] = currentBrick;
					break;

				case 1:
				case 2:
				case 3:
				case 4:
					map.addBall(editing - 1, mouseX, mouseY);
					engine.mouseLeft = 0;
					break;
			}
		}
		
		if (engine.mouseRight)
		{
			switch (editing)
			{
				case 0:
					map.data[mouseX][mouseY] = 0;
					break;

				case 1:
				case 2:
				case 3:
				case 4:
					map.removeBallAt(mouseX, mouseY);
					break;
			}
		}

		if (engine.keyState[SDLK_COMMA]) {currentBrick--; engine.clearInput();}
		if (engine.keyState[SDLK_PERIOD]) {currentBrick++; engine.clearInput();}
		
		if (engine.keyState[SDLK_1]) {editing = 0; engine.clearInput();}
		if (engine.keyState[SDLK_2]) {editing = 1; engine.clearInput();}
		if (engine.keyState[SDLK_3]) {editing = 2; engine.clearInput();}
		if (engine.keyState[SDLK_4]) {editing = 3; engine.clearInput();}
		if (engine.keyState[SDLK_5]) {editing = 4; engine.clearInput();}

		if (engine.keyState[SDLK_PAGEUP]) {map.loadNextMap(); engine.clearInput();}
		if (engine.keyState[SDLK_PAGEDOWN]) {map.loadPreviousMap(); engine.clearInput();}

		if (engine.keyState[SDLK_ESCAPE])
			if (showEditorOptions())
				break;

		Math::wrapInt(&currentBrick, 1, 5);
	}
	
	graphics.clearScreen(graphics.black);
	graphics.delay(500);

	return 0;
}
