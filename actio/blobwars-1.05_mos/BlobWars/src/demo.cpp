#include "demo.h"

void showDemoStart()
{
	if (!engine.loadData("data/demoStart"))
	{
		graphics.showErrorAndExit("The requested file '%s' was not found.", "data/demoStart");
	}

	char line[1024];
	int y = 0;

	char *token = strtok((char*)engine.dataBuffer, "\n");
	
	SDL_Surface *title = graphics.loadImage("gfx/main/title.png");	
	graphics.blit(title, 320, 80, graphics.screen, true);
	SDL_FreeSurface(title);
	
	graphics.setFontSize(0);

	while (true)
	{
		sscanf(token, "%d %[^\n\r]", &y, line);
		
		if (y == -1)
		{
			break;
		}

		graphics.drawString(line, 320, y, true, graphics.screen);

		token = strtok(NULL, "\n");

		if (token == NULL)
		{
			break;
		}
	}

	engine.flushInput();
	engine.clearInput();

	while (true)
	{
		graphics.updateScreen();
		engine.getInput();
		
		if (engine.userAccepts())
		{
			break;
		}
	}
	
	SDL_FillRect(graphics.screen, NULL, graphics.black);
	graphics.delay(1000);
}

void showDemoEnd()
{
	audio.stopMusic();
	audio.stopAmbiance();
	
	SDL_FillRect(graphics.screen, NULL, graphics.black);
	graphics.delay(1000);
	
	if (!engine.loadData("data/demoEnd"))
	{
		graphics.showErrorAndExit("The requested file '%s' was not found.", "data/demoEnd");
	}
	
	SDL_FillRect(graphics.screen, NULL, graphics.black);
	SDL_Surface *pic = graphics.loadImage("gfx/main/montage.jpg");
	graphics.blit(pic, 0, 0, graphics.screen, false);
	SDL_FreeSurface(pic);
	
	SDL_Surface *title = graphics.loadImage("gfx/main/title.png");	
	graphics.blit(title, 320, 80, graphics.screen, true);
	SDL_FreeSurface(title);

	char line[1024];
	int y = 0;

	char *token = strtok((char*)engine.dataBuffer, "\n");

	while (true)
	{
		sscanf(token, "%d %[^\n\r]", &y, line);
		
		if (y == -1)
		{
			break;
		}

		graphics.drawString(line, 320, y, true, graphics.screen);

		token = strtok(NULL, "\n");

		if (token == NULL)
		{
			break;
		}
	}
	
	graphics.delay(5000);

	engine.flushInput();
	engine.clearInput();

	while (true)
	{
		graphics.updateScreen();
		engine.getInput();
		
		if (engine.userAccepts())
		{
			break;
		}
	}
	
	SDL_FillRect(graphics.screen, NULL, graphics.black);
	graphics.delay(1000);
	
	exit(0);
}
