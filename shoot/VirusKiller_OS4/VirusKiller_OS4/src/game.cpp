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

#include "game.h"

int showInGameOptions()
{
	float brightness;

	engine.flushInput();
	engine.clearInput();

	if (!engine.loadWidgets("data/inGameWidgets"))
		graphics.showErrorAndExit(ERR_FILE, "data/inGameWidgets");

	int cont, options, quit, quitno, quityes, back;
	cont = options = quit = quitno = quityes = back = 0;

	engine.setWidgetVariable("fullscreen", &engine.fullScreen);
	engine.setWidgetVariable("sound", &gameData.soundVolume);
	engine.setWidgetVariable("music", &gameData.musicVolume);
	engine.setWidgetVariable("gamma", &gameData.gamma);
	engine.setWidgetVariable("back", &back);

	engine.setWidgetVariable("continue", &cont);
	engine.setWidgetVariable("options", &options);
	engine.setWidgetVariable("quit", &quit);

	engine.setWidgetVariable("quitno", &quitno);
	engine.setWidgetVariable("quityes", &quityes);
	engine.showWidgetGroup("quitconf", false);
	engine.showWidgetGroup("gameoptions", true);
	engine.showWidgetGroup("options", false);
	
	engine.highlightWidget("continue");

	engine.flushInput();
	engine.clearInput();

	graphics.fade(210);

	graphics.drawRect(200, 150, 400, 300, graphics.black, graphics.white, graphics.screen);
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
			if (engine.widgetChanged("sound"))
				audio.setSoundVolume(gameData.soundVolume);

			if (engine.widgetChanged("music"))
				audio.setMusicVolume(gameData.musicVolume);

			if (engine.widgetChanged("fullscreen"))
				SDL_WM_ToggleFullScreen(graphics.screen);

			if (engine.widgetChanged("gamma"))
			{
				brightness = gameData.gamma;
				brightness /= 10;
				SDL_SetGamma(brightness, brightness, brightness);
			}
			
			graphics.drawRect(200, 150, 400, 300, graphics.black, graphics.white, graphics.screen);
			drawWidgets();
		}

		if (cont)
			break;

		if (options)
		{
			options = 0;
			engine.highlightWidget("fullscreen");
			engine.showWidgetGroup("gameoptions", false);
			engine.showWidgetGroup("options", true);
			graphics.drawRect(200, 150, 400, 300, graphics.black, graphics.white, graphics.screen);
			drawWidgets();
		}

		if (back)
		{
			back = 0;
			engine.highlightWidget("continue");
			engine.showWidgetGroup("gameoptions", true);
			engine.showWidgetGroup("options", false);
			graphics.drawRect(200, 150, 400, 300, graphics.black, graphics.white, graphics.screen);
			drawWidgets();
		}

		if (quitno)
		{
			engine.highlightWidget("continue");
			engine.showWidgetGroup("gameoptions", true);
			engine.showWidgetGroup("quitconf", false);
			graphics.drawRect(200, 150, 400, 300, graphics.black, graphics.white, graphics.screen);
			drawWidgets();
			quitno = 0;
		}

		if (quityes)
			return 1;

		if (quit)
		{
			engine.showWidgetGroup("options", false);
			engine.showWidgetGroup("gameoptions", false);
			engine.showWidgetGroup("quitconf", true);
			engine.highlightWidget("quitno");

			graphics.drawRect(200, 150, 400, 300, graphics.black, graphics.white, graphics.screen);
			drawWidgets();
			quit = 0;
		}
	}
	
	return 0;
}

void GameOver()
{
	audio.stopMusic();
	
	if (engine.useAudio)
	{
		for (int i = 0 ; i < 8 ; i++)
		{
			Mix_HaltChannel(i);
		}
	}

	int x = 0;
	int y = 0;

	SDL_Rect r;

	for (int i = 0 ; i < 100 ; i++)
	{
		r.x = x;
		r.y = y;
		r.w = 80;
		r.h = 60;

		if (SDL_BlitSurface(graphics.screen, &r, graphics.tile[i], NULL))
			graphics.showErrorAndExit("Game Over section didn't work", "");

		x += 80;
		if (x == 800)
		{
			x = 0;
			y += 60;
		}
	}

	x = y = 0;

	float tx[100];
	float ty[100];
	float dx[100];
	float dy[100];

	for (int i = 0 ; i < 100 ; i++)
	{
		tx[i] = x;
		ty[i] = y;

		x += 80;
		if (x == 800)
		{
			x = 0;
			y += 60;
		}

		dx[i] = 0.00 + Math::rrand(-300, 300);
		if (dx[i])
			dx[i] /= 100;

		dy[i] = 0.00 + Math::rrand(-300, 300);
		if (dy[i])
			dy[i] /= 100;
	}
	
	graphics.clearScreen(graphics.black);
	graphics.drawString(400, 300, TXT_CENTERED, graphics.screen, "Game Over");

	for (int i = 0 ; i < 100 ; i++)
	{
		tx[i] += dx[i];
		ty[i] += dy[i];
		graphics.blit(graphics.tile[i], (int)tx[i], (int)ty[i], graphics.screen, false);
	}
	
	audio.playSound(SND_DIRDESTROYED6, 0);

	graphics.delay(250);

	audio.playSound(SND_GAMEOVER, 0);

	graphics.delay(1000);

	unsigned int then = SDL_GetTicks() + 6000;

	graphics.setFontSize(4);
	graphics.setFontColor(0xff, 0xff, 0xff, 0x00, 0x00, 0x00);

	engine.resetTimeDifference();

	audio.playSound(SND_DIRDESTROYED3, 1);

	while (true)
	{
		engine.doTimeDifference();
		graphics.updateScreen();
		engine.getInput();

		graphics.clearScreen(graphics.black);
		graphics.drawString(400, 300, TXT_CENTERED, graphics.screen, "Game Over");

		for (int i = 0 ; i < 100 ; i++)
		{
			graphics.blit(graphics.tile[i], (int)tx[i], (int)ty[i], graphics.screen, false);
			tx[i] += (dx[i] * engine.getTimeDifference());
			ty[i] += (dy[i] * engine.getTimeDifference());
		}

		if (SDL_GetTicks() > then)
			break;
	}
}

void doGameStuff()
{
	engine.doTimeDifference();
	graphics.updateScreen();
	engine.getInput();

	graphics.drawBackground();
	doDirectories();
	doItems();
	doViruses();
	doParticles();

	if (gameData.skill < 3)
		for (int i = 0 ; i < 4 ; i++)
			graphics.blit(gameData.base[i].image, gameData.base[i].x, gameData.base[i].y, graphics.screen, true);
		
	graphics.blit(graphics.infoBar, 0, 0, graphics.screen, false);

	graphics.setFontColor(0xff, 0xff, 0xff, 0x00, 0x00, 0x00);
	graphics.setFontSize(0);
	graphics.drawString(10, 10, TXT_LEFT, graphics.screen, "Score: %.7d", gameData.score);
	graphics.drawString(789, 10, TXT_RIGHT, graphics.screen, "Round: %d", gameData.level);

	graphics.drawString(265, 10, TXT_RIGHT, graphics.screen, "Kernel Power");
	graphics.drawRect(275, 11, 152, 12, graphics.black, graphics.white, graphics.screen);
	if (gameData.kernelPower > 0)
	{
		if (gameData.kernelPower > 150)
			graphics.drawRect(276, 12, ((int)gameData.kernelPower / 2), 10, graphics.green, graphics.screen);
		else if (gameData.kernelPower > 50)
			graphics.drawRect(276, 12, ((int)gameData.kernelPower / 2), 10, graphics.yellow, graphics.screen);
		else
			graphics.drawRect(276, 12, ((int)gameData.kernelPower / 2), 10, graphics.red, graphics.screen);
	}

	graphics.drawString(515, 10, TXT_LEFT, graphics.screen, "Thread Blockers: %d", gameData.threadStops);
}

void doRoundClear()
{
	if (engine.useAudio)
	{
		Mix_HaltChannel(6);
		Mix_HaltChannel(7);
		Mix_ResumeMusic();
	}

	Sprite *targeter = graphics.getSprite("Targeter", true);

	unsigned int now;
	unsigned int info = 0;

	int bonus = 0;

	bonus = gameData.roundVirusesKilled;
	
	if (gameData.roundFilesLost)
	{
		bonus /= gameData.roundFilesLost;
	}
	
	bonus *= (gameData.activeDirs * 10);

	unsigned int then = SDL_GetTicks() + 2000;

	while (true)
	{
		doGameStuff();

		now = SDL_GetTicks();

		if (now > then + 500)
		{
			graphics.fade(210);
		}

		if (now > then + 1000)
		{
			info = 1;
		}

		if (now > then + 3000)
		{
			info = 2;
		}

		if (now > then + 4000)
		{
			info = 3;
		}

		if (now > then + 5000)
		{
			break;
		}

		if (info == 1)
		{
			graphics.setFontSize(4);
			graphics.drawString(400, 100, TXT_CENTERED, graphics.screen, "Round #%d Clear", gameData.level);
			graphics.setFontSize(2);

			graphics.drawString(400, 200, TXT_RIGHT, graphics.screen, "Bonus");
			graphics.drawString(400, 250, TXT_RIGHT, graphics.screen, "Viruses Destroyed");
			graphics.drawString(400, 300, TXT_RIGHT, graphics.screen, "Files Lost");
			graphics.drawString(400, 350, TXT_RIGHT, graphics.screen, "Directories Lost");
			graphics.drawString(400, 400, TXT_RIGHT, graphics.screen, "Items Collected");
			graphics.drawString(400, 450, TXT_RIGHT, graphics.screen, "Biggest Chain");

			if (bonus > 0)
			{
				graphics.drawString(430, 200, TXT_LEFT, graphics.screen, "%d", bonus);
			}
			else
			{
				graphics.drawString(430, 200, TXT_LEFT, graphics.screen, "None");
			}
			
			graphics.drawString(430, 250, TXT_LEFT, graphics.screen, "%.4d", gameData.roundVirusesKilled);
			graphics.drawString(430, 300, TXT_LEFT, graphics.screen, "%.4d", gameData.roundFilesLost);
			graphics.drawString(430, 350, TXT_LEFT, graphics.screen, "%.4d", gameData.roundDirsLost);
			graphics.drawString(430, 400, TXT_LEFT, graphics.screen, "%.4d", gameData.roundItemsCollected);
			graphics.drawString(430, 450, TXT_LEFT, graphics.screen, "%.4d", gameData.roundBiggestChain);
		}
		else if (info == 3)
		{
			graphics.setFontSize(4);
			graphics.drawString(400, 270, TXT_CENTERED, graphics.screen, "Round #%d", (gameData.level + 1));
			graphics.drawString(400, 320, TXT_CENTERED, graphics.screen, "READY!");
		}

		graphics.blit(targeter->getCurrentFrame(), engine.getMouseX(), engine.getMouseY(), graphics.screen, true);

	}

	engine.resetTimeDifference();
	
	gameData.score += bonus;
}

int doGame()
{
	graphics.clearScreen(graphics.black);
	graphics.delay(500);

	if (gameData.skill != MODE_ULTIMATE)
	{
		audio.loadMusic("music/DCC_Psychedhelic.mod");
	}
	else
	{
		audio.loadMusic("music/DarkAngel.mod");
	}
	
	loadRandomBackground();

	Sprite *targeter = graphics.getSprite("Targeter", true);

	gameData.clear();

	setupActiveDirectories(4);

	gameData.activeDirs = 4;

	unsigned int gameOverWait = 0;

	float virusSpawn = 100 * Math::rrand(2, 4);
	float itemSpawnTime = 100 * Math::rrand(ITEM_MINWAIT, ITEM_MAXWAIT);

	unsigned int roundTime = 15;
	unsigned int minViruses = 1 + (1 * gameData.skill);
	unsigned int maxViruses = 2 + (2 * gameData.skill);

	bool addMoreViruses = true;

	audio.playMusic();

	unsigned int green;
	float time = SDL_GetTicks();
	unsigned int lastTime = (int)time + (roundTime * 100);
	unsigned int now;

	bool playingBeamSound = false;

	engine.clearInput();
	engine.flushInput();

	gameData.resetForNextRound();

	doGameStuff();
	graphics.fade(210);
	graphics.setFontSize(4);
	graphics.setFontColor(0xff, 0xff, 0xff, 0x00, 0x00, 0x00);
	
	if (gameData.skill < 3)
	{
		graphics.drawString(400, 270, TXT_CENTERED, graphics.screen, "Round #%d", gameData.level);
		graphics.drawString(400, 320, TXT_CENTERED, graphics.screen, "READY!");
	}
	else if (gameData.skill == 3)
	{
		graphics.drawString(400, 270, TXT_CENTERED, graphics.screen, "Nightmare Mode");
		graphics.drawString(400, 320, TXT_CENTERED, graphics.screen, "Survive as long as you can!", gameData.level);
	}
	else
	{
		graphics.drawString(400, 270, TXT_CENTERED, graphics.screen, "The Ultimate Nightmare");
		graphics.drawString(400, 320, TXT_CENTERED, graphics.screen, "Good Luck!", gameData.level);
	}

	graphics.delay(2000);

	addViruses(minViruses);

	engine.resetTimeDifference();

	while (true)
	{
		now = SDL_GetTicks();

		if (gameData.threadStopTimer != 0)
		{
			gameData.threadStopTimer -= (1 * engine.getTimeDifference());

			if (gameData.threadStopTimer <= 0)
			{
				gameData.threadStopTimer = 0;
				
				if (engine.useAudio)
				{
					Mix_HaltChannel(6);
					Mix_ResumeMusic();
				}
			}
		}

		doGameStuff();

		graphics.blit(targeter->getCurrentFrame(), engine.getMouseX(), engine.getMouseY(), graphics.screen, true);

		if (engine.mouseLeft)
		{
			if (gameData.kernelPower > 0)
			{
				if (gameData.threadStopTimer == 0)
				{
					gameData.kernelPower -= (.4 * engine.getTimeDifference());
				}

				green = SDL_MapRGB(graphics.screen->format, Math::rrand(0, 100), Math::rrand(0, 255), 0);

				graphics.drawLine(0, 599, engine.getMouseX(), engine.getMouseY(), green, graphics.screen);
				graphics.drawLine(1, 598, engine.getMouseX(), engine.getMouseY(), green, graphics.screen);
				graphics.drawLine(2, 597, engine.getMouseX(), engine.getMouseY(), green, graphics.screen);
				graphics.drawLine(3, 596, engine.getMouseX(), engine.getMouseY(), green, graphics.screen);

				graphics.drawLine(799, 599, engine.getMouseX(), engine.getMouseY(), green, graphics.screen);
				graphics.drawLine(798, 598, engine.getMouseX(), engine.getMouseY(), green, graphics.screen);
				graphics.drawLine(797, 597, engine.getMouseX(), engine.getMouseY(), green, graphics.screen);
				graphics.drawLine(796, 596, engine.getMouseX(), engine.getMouseY(), green, graphics.screen);

				doVirusBulletCollisions();
				doBulletItemCollisions();

				addBulletParticle();

				Math::limitFloat(&gameData.kernelPower, 0, 300);

				if (!playingBeamSound)
				{
					audio.playSound(SND_KERNALBEAM, 7, -1);
					playingBeamSound = true;
				}
			}
			else
			{
				if (engine.useAudio)
				{
					Mix_HaltChannel(7);
				}			
			}
		}
		else
		{
			gameData.kernelPower += (.1 * engine.getTimeDifference());
			Math::limitFloat(&gameData.kernelPower, 0, 300);
			
			if (engine.useAudio)
			{
				Mix_HaltChannel(7);
			}
			
			playingBeamSound = false;
		}

		if ((engine.mouseRight) && (gameData.threadStops > 0))
		{
			if (gameData.threadStopTimer == 0)
			{
				gameData.threadStopTimer = 600;
				engine.mouseRight = 0;
				
				if (engine.useAudio)
				{
					Mix_PauseMusic();
				}
				
				audio.playSound(SND_CLOCK, 6, 2);
				gameData.threadStops--;
			}
		}

		if (addMoreViruses)
		{
			virusSpawn -= (1 * engine.getTimeDifference());

			if ((virusSpawn <= 0) && (gameData.threadStopTimer == 0))
			{
				virusSpawn = 100 * Math::rrand(2, 4);
				virusSpawn -= (gameData.level * 5);
				Math::limitFloat(&virusSpawn, 25, 400);
				addViruses(Math::rrand(minViruses, maxViruses));
			}
		}
		else if ((gameData.activeViruses == 0) && (gameData.activeDirs > 0))
		{
			doRoundClear();

			gameData.level++;

			if ((gameData.level % 2) == 0)
			{
				roundTime += 5;
			}
			else
			{
				maxViruses += 2;
			}

			lastTime = (int)time;

			if ((gameData.level % 5) == 0)
				minViruses += 2;

			time = lastTime = now;
			lastTime += (roundTime * 100);

			gameData.resetForNextRound();
			addViruses(minViruses);

			addMoreViruses = true;
		}

		if (gameData.threadStopTimer == 0)
		{
			time += (1 * engine.getTimeDifference());
		}

		itemSpawnTime -= (1 * engine.getTimeDifference());

		if (itemSpawnTime <= 0)
		{
			addItem();
			
			if (gameData.skill < 3)
			{
				itemSpawnTime = 100 * Math::rrand(ITEM_MINWAIT, ITEM_MAXWAIT);
			}
			else
			{
				itemSpawnTime = 100 * Math::rrand(ITEM_MINWAIT * 2, ITEM_MAXWAIT * 2);
			}
		}

		#if !USEPAK
		//if (time < lastTime)
			//graphics.drawString(10, 50, TXT_LEFT, graphics.screen, "Round Time: %d ", (lastTime - time) / 100);

		//if (now < gameData.itemSpawnTime)
			//graphics.drawString(10, 70, TXT_LEFT, graphics.screen, "Item Time: %d ", (gameData.itemSpawnTime - now) / 100);
		#endif

		if (time >= lastTime)
		{
			if (gameData.skill < 3)
			{
				addMoreViruses = false;
			}
			else
			{
				gameData.level++;

				maxViruses += 2 + (2 * gameData.skill);

				lastTime = (int)time;

				if ((gameData.level % 3) == 0)
				{
					minViruses += 2 + (2 * gameData.skill);
				}

				time = lastTime = now;
				lastTime += (roundTime * 100);
			}
		}

		if (gameData.activeDirs > 0)
		{
			if (gameData.skill >= 3)
			{
				gameData.score += (int)(50 * engine.getTimeDifference());
			}
		}

		if (gameData.activeDirs == 0)
		{
			if (gameOverWait == 0)
				gameOverWait = SDL_GetTicks() + 3000;

			if (now > gameOverWait)
				break;
		}
		
		engine.doPause();

		if ((engine.paused) && (gameData.activeDirs > 0))
		{
			graphics.fade(210);
			graphics.setFontSize(4);
			graphics.setFontColor(0xff, 0xff, 0xff, 0x00, 0x00, 0x00);
			graphics.drawString(400, 300, TXT_CENTERED, graphics.screen, "PAUSED");
			audio.pause();
		}

		while (engine.paused)
		{
			engine.getInput();
			engine.doPause();
			graphics.updateScreen();

			if (!engine.paused)
			{
				audio.resume();
				engine.resetTimeDifference();
			}
		}
		
		if (engine.keyState[SDLK_ESCAPE])
		{
			if (engine.useAudio)
			{
				for (int i = 0 ; i < 8 ; i++)
				{
					Mix_HaltChannel(i);
				}
			}

			if (showInGameOptions())
			{
				if (engine.useAudio)
				{
					audio.stopMusic();
					for (int i = 0 ; i < 8 ; i++)
					{
						Mix_HaltChannel(i);
					}
				}
				graphics.clearScreen(graphics.black);
				graphics.delay(500);
				gameData.virusList.clear();
				return SECTION_TITLE;
			}

			audio.resume();
			engine.resetTimeDifference();
		}
	}

	GameOver();

	if (gameData.skill == MODE_HARD)
	{
		if (gameData.nightmareCount > 0)
		{
			if (gameData.nightmareCount > 50)
			{
				gameData.nightmareCount -= gameData.level;
				Math::limitInt(&gameData.nightmareCount, 50, 100);
			}
			else
			{
				gameData.nightmareCount -= gameData.level;
			}

			debug(("Nightmare Count is now %d\n", gameData.nightmareCount));

			if (gameData.nightmareCount == 50)
			{
				graphics.clearScreen(graphics.black);
				graphics.delay(500);
				graphics.setFontSize(4);
				graphics.setFontColor(0xff, 0xff, 0x00, 0x00, 0x00, 0x00);
				audio.playSound(SND_POWERUP, 0);
				graphics.drawString(400, 300, TXT_CENTERED, graphics.screen, "Nightmare Mode is now Available");
				graphics.delay(3000);
			}
			else if (gameData.nightmareCount == 0)
			{
				graphics.clearScreen(graphics.black);
				graphics.delay(500);
				graphics.setFontSize(4);
				graphics.setFontColor(0x00, 0xff, 0xff, 0x00, 0x00, 0x00);
				audio.playSound(SND_POWERUP, 0);
				graphics.drawString(400, 300, TXT_CENTERED, graphics.screen, "Ultimate Nightmare Mode is now Available");
				graphics.delay(3000);
			}
		}
	}

	graphics.clearScreen(graphics.black);
	graphics.delay(500);

	gameData.virusList.clear();

	return SECTION_HIGHSCORE;
}
