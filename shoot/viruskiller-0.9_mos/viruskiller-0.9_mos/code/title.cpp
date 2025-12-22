/*
Copyright (C) 2004 Parallel Realities

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

void showTitle()
{
	SDL_Surface *prlogo = graphics.getSprite("PRLogo", true)->getCurrentFrame();
	SDL_Surface *presents = graphics.getSprite("Presents", true)->getCurrentFrame();
	SDL_Surface *sdl = graphics.getSprite("SDL", true)->getCurrentFrame();
	SDL_Surface *virusLogo = graphics.getSprite("TitleLogo", true)->getCurrentFrame();

	unsigned int then = SDL_GetTicks() + 2000;
	unsigned int now = then;
	int section = 0;
	int logoY = 300;
	
	engine.resetTimeDifference();

	while (true)
	{
		now = SDL_GetTicks();

		engine.doTimeDifference();
		graphics.updateScreen();
		graphics.clearScreen(graphics.black);
		engine.getInput();

		if (now > then)
		{
			section++;
			then = now + 5000;
			if ((section % 2) == 0)
				then = now + 1500;

			if (section == 6)
				then = now + 2000;
		}

		switch (section)
		{
			case 1:
				graphics.blit(prlogo, 400, 300, graphics.screen, true);
				break;
			case 3:
				graphics.blit(presents, 400, 300, graphics.screen, true);
				break;
			case 5:
				graphics.blit(sdl, 400, 300, graphics.screen, true);
				break;
		}

		if (section >= 7)
		{
			graphics.blit(virusLogo, 400, logoY, graphics.screen, true);
			if (section > 7)
				logoY -= (int)(2 * engine.getTimeDifference());
		}

		if ((engine.userAccepts()) || (logoY <= 100))
			return;
	}
}

void doTitleViruses()
{
	Virus *virus = (Virus*)gameData.virusList.getHead();

	while (virus->next != NULL)
	{
		virus = (Virus*)virus->next;

		virus->dy += (0.1 * engine.getTimeDifference());
		Math::limitFloat(&virus->dy, -8, 10);

		virus->y += virus->dy * engine.getTimeDifference();
		virus->x += virus->dx * engine.getTimeDifference();

		if (virus->y > 600)
		{
			virus->y = 600;
			virus->dy = Math::rrand(-8, -2);
		}

		if (virus->x < 0)
		{
			virus->x = 0;
			virus->dx = -virus->dx;
		}

		if (virus->x > 800)
		{
			virus->x = 800;
			virus->dx = -virus->dx;
		}

		graphics.blit(virus->sprite->getCurrentFrame(), (int)virus->x, (int)virus->y, graphics.screen, true);
	}
}

void addTitleViruses()
{
	Sprite *virusSprite1 = graphics.getSprite("Virus1", true);
	Sprite *virusSprite2 = graphics.getSprite("Virus2", true);
	Sprite *virusSprite3 = graphics.getSprite("Virus3", true);

	Virus *virus;

	for (int i = 0 ; i < 25 ; i++)
	{
		virus = new Virus();

		switch (rand() % 3)
		{
			case VIRUS_THIEF:
				virus->type = VIRUS_THIEF;
				virus->sprite = virusSprite1;
				break;
				
			case VIRUS_EAT:
				virus->type = VIRUS_EAT;
				virus->sprite = virusSprite2;
				break;

			case VIRUS_DESTROY:
				virus->type = VIRUS_DESTROY;
				virus->sprite = virusSprite3;
				break;
		}

		virus->x = Math::rrand(0, 800);
		virus->y = Math::rrand(-50, 0);

		virus->dx = Math::rrand(-2, 2);
		if (virus->dx == 0)
			virus->dx = Math::rrand(1, 2);

		gameData.addVirus(virus);
	}
}

int doTitle()
{
	graphics.clearScreen(graphics.black);
	graphics.delay(500);

	gameData.clear();

	SDL_Surface *title = graphics.getSprite("TitleLogo", true)->getCurrentFrame();
	
	if (!engine.loadWidgets("data/titleWidgets"))
		graphics.showErrorAndExit(ERR_FILE, "data/titleWidgets");
		
	Widget *widget = engine.getWidgetByName("labelManual");
	strcpy(widget->label, GAMEPLAYMANUAL);
		
	if (!engine.useAudio)
	{
		engine.enableWidget("soundvol", false);
		engine.enableWidget("musicvol", false);
	}
	
	float brightness;

	int start, options, credits, highscores, help, quit, back, easy, normal, hard, nightmare, ultimate;
	start = options = credits = highscores = help = quit = back = easy = normal = hard = nightmare = ultimate = 0;

	engine.setWidgetVariable("newGame", &start);
	engine.setWidgetVariable("highscores", &highscores);
	engine.setWidgetVariable("credits", &credits);
	engine.setWidgetVariable("options", &options);
	engine.setWidgetVariable("help", &help);
	engine.setWidgetVariable("quit", &quit);

	engine.setWidgetVariable("fullscreen", &engine.fullScreen);
	engine.setWidgetVariable("sound", &gameData.soundVolume);
	engine.setWidgetVariable("music", &gameData.musicVolume);
	engine.setWidgetVariable("gamma", &gameData.gamma);

	engine.setWidgetVariable("easy", &easy);
	engine.setWidgetVariable("normal", &normal);
	engine.setWidgetVariable("hard", &hard);
	engine.setWidgetVariable("nightmare", &nightmare);
	engine.setWidgetVariable("ultimate", &ultimate);

	engine.setWidgetVariable("back", &back);

	engine.showWidgetGroup("mainMenu", true);
	engine.showWidgetGroup("help", false);
	engine.showWidgetGroup("options", false);
	engine.showWidgetGroup("skill", false);
	engine.showWidgetGroup("back", false);

	engine.highlightWidget("newGame");

	bool showMenu = false;

	audio.loadMusic("music/Infection.mod");

	addTitleViruses();

	int then = SDL_GetTicks() + 2000;
	int now = SDL_GetTicks();
	int section = 0;
	
	#if USEPAK
		int sectionLimit = 13;

		if ((gameData.nightmareCount > 0) && (gameData.nightmareCount < 50))
			sectionLimit = 15;

		if (gameData.nightmareCount == 0)
			sectionLimit = 17;
	#else
		int sectionLimit = 17;
	#endif

	graphics.setFontColor(0xff, 0xff, 0xff, 0x00, 0x00, 0x00);
	graphics.setFontSize(1);

	audio.playMusic();
	
	if (!gameData.shownTitles)
	{
		showTitle();
		gameData.shownTitles = true;
	}

	engine.resetTimeDifference();

	engine.clearInput();
	engine.flushInput();

	while (true)
	{
		engine.doTimeDifference();

		now = SDL_GetTicks();

		graphics.updateScreen();

		engine.getInput();

		graphics.clearScreen(graphics.black);

		graphics.blit(title, 400, 100, graphics.screen, true);

		graphics.setFontSize(0);
		graphics.setFontColor(0xff, 0xff, 0xff, 0x00, 0x00, 0x00);
		graphics.drawString(10, 580, TXT_LEFT, graphics.screen, "Copyright (c) Parallel Realities 2004");
		graphics.drawString(790, 580, TXT_RIGHT, graphics.screen, "Version %.1f", VERSION);
		graphics.setFontSize(1);

		doTitleViruses();

		if (!showMenu)
		{
			if (now > then)
			{
				Math::wrapInt(&(++section), 0, sectionLimit);
				then = now + 4000;
				if ((section % 2) == 0)
					then = now + 1000;
			}

			switch (section)
			{
				case 1:
					graphics.drawString(400, 325, TXT_CENTERED, graphics.screen, "++ Main Design and Programming ++");
					graphics.drawString(400, 350, TXT_CENTERED, graphics.screen, "Stephen Sweeney");
					graphics.drawString(400, 375, TXT_CENTERED, graphics.screen, "Rik Sweeney");
					break;

				case 3:
					graphics.drawString(400, 325, TXT_CENTERED, graphics.screen, "++ File, Directory and Icon Graphics ++");
					graphics.drawString(400, 350, TXT_CENTERED, graphics.screen, "Everaldo (Crystal Icon Theme)");
					graphics.drawString(400, 400, TXT_CENTERED, graphics.screen, "++ Virus Graphics ++");
					graphics.drawString(400, 425, TXT_CENTERED, graphics.screen, "Stephen Sweeney");
					break;

				case 5:
					graphics.drawString(400, 325, TXT_CENTERED, graphics.screen, "++ Music By ++");
					graphics.drawString(400, 350, TXT_CENTERED, graphics.screen, "Rene Siekmann");
					graphics.drawString(400, 375, TXT_CENTERED, graphics.screen, "xtd / mystic & trsi");
					break;

				case 7:
					graphics.drawString(400, 325, TXT_CENTERED, graphics.screen, "++ %s Version By ++", PLATFORMNAME);
					graphics.drawString(400, 350, TXT_CENTERED, graphics.screen, PORTERSNAME);
					graphics.drawString(400, 375, TXT_CENTERED, graphics.screen, PORTERSEMAIL);
					break;

				case 9:
					showHighScores(MODE_EASY, 200);
					break;

				case 11:
					showHighScores(MODE_NORMAL, 200);
					break;

				case 13:
					showHighScores(MODE_HARD, 200);
					break;

				case 15:
					showHighScores(MODE_NIGHTMARE, 200);
					break;

				case 17:
					showHighScores(MODE_ULTIMATE, 200);
					break;
			}

			if (engine.userAccepts())
			{
				showMenu = true;
				engine.clearInput();
				engine.flushInput();
			}
		}
		else
		{
			if (engine.processWidgets())
			{
				if (engine.widgetChanged("fullscreen"))
					SDL_WM_ToggleFullScreen(graphics.screen);
					
				if (engine.widgetChanged("sound"))
					audio.setSoundVolume(gameData.soundVolume);

				if (engine.widgetChanged("music"))
					audio.setMusicVolume(gameData.musicVolume);

				if (engine.widgetChanged("gamma"))
				{
					brightness = gameData.gamma;
					brightness /= 10;
					SDL_SetGamma(brightness, brightness, brightness);
				}
			}

			drawWidgets();
			
			if (start)
			{
				start = 0;
				engine.showWidgetGroup("mainMenu", false);
				engine.showWidgetGroup("skill", true);
				engine.showWidgetGroup("back", true);
				engine.highlightWidget("normal");
				
				#if USEPAK
				if (gameData.nightmareCount > 50)
					engine.showWidget("nightmare", false);

				if (gameData.nightmareCount > 0)
					engine.showWidget("ultimate", false);
				#endif
			}

			if (options)
			{
				options = 0;
				engine.showWidgetGroup("mainMenu", false);
				engine.showWidgetGroup("options", true);
				engine.showWidgetGroup("back", true);
				engine.highlightWidget("fullscreen");
			}

			if (help)
			{
				help = 0;
				engine.showWidgetGroup("mainMenu", false);
				engine.showWidgetGroup("help", true);
				engine.showWidgetGroup("back", true);
				engine.highlightWidget("back");
			}

			if (back)
			{
				back = 0;
				engine.showWidgetGroup("mainMenu", true);
				engine.showWidgetGroup("options", false);
				engine.showWidgetGroup("skill", false);
				engine.showWidgetGroup("help", false);
				engine.showWidgetGroup("back", false);
				engine.highlightWidget("newGame");
			}

			if (highscores)
			{
				section = 9;
				then = now + 4000;
				showMenu = false;
				highscores = 0;
			}

			if (credits)
			{
				section = 1;
				then = now + 4000;
				showMenu = false;
				credits = 0;
			}

			if (quit)
				exit(0);

			if ((easy) || (normal) || (hard) || (nightmare) || (ultimate))
				break;

			if (engine.keyState[SDLK_ESCAPE])
			{
				showMenu = false;
				start = back = 0;
				engine.showWidgetGroup("mainMenu", true);
				engine.showWidgetGroup("skill", false);
				engine.showWidgetGroup("back", false);
				engine.highlightWidget("newGame");
				engine.keyState[SDLK_ESCAPE] = 0;
			}
			
			if (showMenu == false)
				graphics.setFontColor(0xff, 0xff, 0xff, 0x00, 0x00, 0x00);
		}
	}

	audio.stopMusic();
	gameData.clear();
	
	if (easy) gameData.skill = 0;
	if (normal) gameData.skill = 1;
	if (hard) gameData.skill = 2;
	if (nightmare) gameData.skill = 3;
	if (ultimate) gameData.skill = 4;

	return SECTION_GAME;
}
