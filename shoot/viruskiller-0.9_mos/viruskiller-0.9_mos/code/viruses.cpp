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

#include "viruses.h"

void nightmareVirusGetStart(Virus *virus)
{
	int place = rand() % 4;

	if ((place == 0) || (place == 1))
		virus->x = Math::rrand(0, 800);

	if ((place == 2) || (place == 3))
		virus->y = Math::rrand(0, 600);

	if (place == 0)
		virus->y = -50;

	if (place == 1)
		virus->y = 650;

	if (place == 2)
		virus->x = -50;

	if (place == 3)
		virus->x = 850;
}

void addViruses(int amount)
{
	Sprite *virusSprite1 = graphics.getSprite("Virus1", true);
	Sprite *virusSprite2 = graphics.getSprite("Virus2", true);
	Sprite *virusSprite3 = graphics.getSprite("Virus3", true);

	Virus *virus;

	int place;
	int chompChance = 20 - (gameData.level);
	int destroyChance = 75 - (gameData.level);

	Math::limitInt(&chompChance, 3, 20);
	Math::limitInt(&destroyChance, 3, 75);

	for (int i = 0 ; i < amount ; i++)
	{
		place = rand() % 4;

		virus = new Virus();

		if (gameData.skill < 3)
			virus->setBase(&gameData.base[rand() % 4]);
		else
			nightmareVirusGetStart(virus);

		virus->type = VIRUS_THIEF;
		virus->sprite = virusSprite1;
		
		switch (gameData.skill)
		{
			case MODE_EASY:
				virus->speed = 3;
				break;
			case MODE_NORMAL:
				virus->speed = Math::rrand(2, 3);
				break;
			case MODE_HARD:
				virus->speed = Math::rrand(1, 3);
				break;
			case MODE_NIGHTMARE:
				virus->type = VIRUS_EAT;
				virus->sprite = virusSprite2;
				virus->speed = 10 - (gameData.level / 2);
				if (virus->speed < 4)
					virus->speed = 4;
				break;
			case MODE_ULTIMATE:
				virus->type = VIRUS_DESTROY;
				virus->sprite = virusSprite3;
				virus->speed = Math::rrand(2, 4);
				break;
		}

		if ((gameData.skill > MODE_EASY) && (gameData.skill < MODE_NIGHTMARE))
		{
			if ((rand() % chompChance) == 0)
			{
				virus->type = VIRUS_EAT;
				virus->sprite = virusSprite2;
			}

			if ((rand() % destroyChance) == 0)
			{
				virus->type = VIRUS_DESTROY;
				virus->sprite = virusSprite3;
				virus->speed = 4;
			}
		}

		gameData.addVirus(virus);
	}

	audio.playSound(SND_VIRUSLAUGH1 + rand() % 6, 2);
}

void nukeAllViruses()
{
	Virus *virus = (Virus*)gameData.virusList.getHead();

	while (virus->next != NULL)
	{
		virus = (Virus*)virus->next;

		if ((!virus->active) || (virus->insideDir) || (virus->health < 1))
			continue;

		virus->health = 0;

		if (virus->file != NULL)
				virus->file->stolen = false;

		addVirusDeathParticles((int)virus->x, (int)virus->y, virus->type);
		gameData.virusesKilled++;
#ifdef __MORPHOS__
		virus->active = false;
#endif

		if (gameData.skill < 3)
		{
			gameData.roundVirusesKilled++;
			graphics.setFontSize(0);
			graphics.setFontColor(0xff, 0x00, 0x00, 0x00, 0x00, 0x00);
			virus->pointsImage = graphics.getString(true, "+500");
			gameData.score += 500;
		}
	}

	audio.playSound(SND_EXPLOSION, 0);
}

void doVirusBulletCollisions()
{
	int mouseX = engine.getMouseX() - 2;
	int mouseY = engine.getMouseY() - 2;

	Virus *virus = (Virus*)gameData.virusList.getHead();

	while (virus->next != NULL)
	{
		virus = (Virus*)virus->next;

		if ((!virus->active) || (virus->insideDir) || (virus->health < 1))
			continue;

		if (Collision::collision(virus->x - 10, virus->y - 7, 20, 15, mouseX, mouseY, 4, 4))
		{
			virus->health = 0;

			audio.playSound(SND_VIRUSKILLED1 + rand() % 3, 4);

			if (virus->file != NULL)
				virus->file->stolen = false;

			addVirusDeathParticles((int)virus->x, (int)virus->y, virus->type);
			gameData.virusesKilled++;
			gameData.roundVirusesKilled++;
#ifdef __MORPHOS__
			virus->active = false;
#endif

			graphics.setFontSize(0);
			graphics.setFontColor(0xff, 0x00, 0x00, 0x00, 0x00, 0x00);

			if (gameData.skill < 3)
			{
				gameData.score += 50 + (50 * gameData.skill);
				virus->pointsImage = graphics.getString(true, "+%d", 50 + (50 * gameData.skill));
			}

			if (gameData.lastVirusKilled > 0)
			{
				gameData.currentChain++;

				if (gameData.currentChain > gameData.roundBiggestChain)
				{
					gameData.roundBiggestChain = gameData.currentChain;
					if (gameData.roundBiggestChain > gameData.biggestChain)
						gameData.biggestChain = gameData.roundBiggestChain;
				}

				graphics.setFontColor(0xff, 25 * gameData.currentChain, 10 * gameData.currentChain, 0x00, 0x00, 0x00);

				if (gameData.skill < 3)
				{
					virus->pointsImage = graphics.getString(true, "+%d", (50 + (50 * gameData.skill)) * gameData.currentChain);
					gameData.score += ((50 + (50 * gameData.skill)) * gameData.currentChain);
					gameData.lastVirusKilled = 50;
				}
			}
			else
			{
				gameData.currentChain = 1;
				gameData.lastVirusKilled = 50;
			}
			
			switch (virus->type)
			{
				case 0:
					gameData.kernelPower += 5;
					break;
				case 1:
					gameData.kernelPower += 15;
					break;
				case 2:
					gameData.kernelPower += 25;
					break;
			}

			return;
		}
	}
}

void virusDestroyDirectory(Virus *virus)
{
	virus->active = false;
	
	virus->targetDir->fileCount = 0;
}

void virusDestroyFile(Virus *virus)
{
	virus->active = false;

	virus->file->homeDirectory->fileCount--;
	if (virus->file->homeDirectory->label != NULL)
		SDL_FreeSurface(virus->file->homeDirectory->label);

	virus->file->homeDirectory->label = NULL;

	gameData.roundFilesLost++;
	gameData.filesLost++;
	gameData.score -= 1000;
}

void virusEatFile(Virus *virus)
{
	File *file = (File*)virus->targetDir->getRandomFile();

	if (file != NULL)
	{
		if (!file->stolen)
		{
			file->stolen = true;
			virus->file = file;
			virus->insideDir = false;
			audio.playSound(SND_VIRUSEATFILE, 5);
			virusDestroyFile(virus);
		}
	}

	virus->thinktime = Math::rrand(25, 100);
}

void nightmareVirusGoHome(Virus *virus)
{
	int x, y;

	int place = rand() % 4;

	if ((place == 0) || (place == 1))
			x = Math::rrand(0, 800);

	if ((place == 2) || (place == 3))
		y = Math::rrand(0, 600);

	if (place == 0)
		y = -50;

	if (place == 1)
		y = 650;

	if (place == 2)
		x = -50;

	if (place == 3)
		x = 850;

	Math::calculateSlope(virus->x, virus->y, x, y, &virus->dx, &virus->dy);

	virus->dx /= virus->speed;
	virus->dy /= virus->speed;
}

void virusStealFile(Virus *virus)
{
	File *file = (File*)virus->targetDir->getRandomFile();

	if (file != NULL)
	{
		if (!file->stolen)
		{
			file->stolen = true;
			virus->file = file;
			virus->hasFile = true;
			virus->insideDir = false;
			
			if (gameData.skill < 3)
			{
				virus->goHome();
			}
			else
			{
				nightmareVirusGoHome(virus);
			}
		}
	}

	virus->thinktime = Math::rrand(25, 100);

	// Don't wait too long if there aren't many files left...
	if ((virus->targetDir->fileCount <= 3) && (virus->targetDir->getRealFileCount() > 25))
		virus->thinktime = 1;
}

void doViruses()
{
	gameData.lastVirusKilled -= (int)(1 * engine.getTimeDifference());
	if (gameData.lastVirusKilled <= 0)
		gameData.lastVirusKilled = 0;

	Virus *virus = (Virus*)gameData.virusList.getHead();
	Virus *previous = virus;
	gameData.virusList.resetTail();

	gameData.activeViruses = 0;

	while (virus->next != NULL)
	{
		virus = (Virus*)virus->next;

		if (virus->active)
		{
			gameData.activeViruses++;

			if (virus->health < 1)
				virus->health -= (int)(1 * engine.getTimeDifference());

			if (virus->health < -100)
				virus->active = 0;

			if (!virus->insideDir)
			{

				if (virus->health == 1)
					graphics.blit(virus->sprite->getCurrentFrame(), (int)virus->x, (int)virus->y, graphics.screen, true);
				else if (gameData.skill < 3)
					graphics.blit(virus->pointsImage, (int)virus->x, (int)virus->y, graphics.screen, true);

				if (virus->hasFile)
				{
					graphics.blit(virus->file->sprite->getCurrentFrame(), (int)virus->x, (int)virus->y - 48, graphics.screen, true);
					graphics.setFontSize(0);
					graphics.setFontColor(0xff, 0xff, 0xff, 0x00, 0x00, 0x00);
					graphics.drawString((int)virus->x, (int)virus->y - 20, TXT_CENTERED, graphics.screen, " %s ", virus->file->name);
				}
			}

			if ((virus->health == 1) && (gameData.threadStopTimer == 0))
			{
				virus->x -= (virus->dx * engine.getTimeDifference());
				virus->y -= (virus->dy * engine.getTimeDifference());
			}

			if (virus->targetDir != NULL)
			{
				if (!virus->targetDir->active)
				{
					virus->targetDir = NULL;
					virus->insideDir = false;
				}
			}

			if ((!virus->insideDir) && (!virus->hasFile))
			{
				if ((virus->targetDir != NULL) && (virus->targetDir->active))
				{
					if (Collision::collision(virus->x, virus->y, 8, 8, virus->targetDir->x - 16, virus->targetDir->y - 16, 32, 32))
					{
						virus->insideDir = true;
						virus->thinktime = Math::rrand(250, 500);
						if (virus->type == VIRUS_DESTROY)
						{
							audio.playSound(SND_VIRUSDESTROYDIR, 1);
							virus->thinktime = 200;
						}
						virus->dx = virus->dy = 0;
					}
				}
				else
				{
					virus->thinktime -= (int)(1 * engine.getTimeDifference());

					if (virus->thinktime <= 0)
					{
						if (gameData.activeDirs > 0)
						{
							virus->setDestinationDir(gameData.getRandomDirectory(true));
							virus->thinktime = Math::rrand(0, 5);
						}
						else
						{
							if (gameData.skill < 3)
							{
								virus->goHome();
							}
							else
							{
								nightmareVirusGoHome(virus);
							}

							virus->thinktime = (Math::rrand(2, 4) * 100);
						}
					}
				}
			}
			else if ((virus->insideDir) && (!virus->hasFile))
			{
    			virus->thinktime -= (int)(1 * engine.getTimeDifference());
				if (virus->thinktime <= 0)
				{
					switch (virus->type)
					{
						case VIRUS_THIEF:
							virusStealFile(virus);
							break;
						case VIRUS_EAT:
							virusEatFile(virus);
							break;
						case VIRUS_DESTROY:
							virusDestroyDirectory(virus);
							break;
					}
				}
			}
			else if (virus->hasFile)
			{
				if (gameData.skill < 3)
				{
					if (Collision::collision(virus->x, virus->y, 8, 8, virus->base->x, virus->base->y, 8, 8))
					{
						virusDestroyFile(virus);
						audio.playSound(SND_FILEDESTROYED1 + rand() % 3, 3);
					}
				}
				else
				{
					if ((virus->x < 0) || (virus->x > 800) || (virus->y < 0) || (virus->y > 600))
					{
						virusDestroyFile(virus);
						audio.playSound(SND_FILEDESTROYED1 + rand() % 3, 3);
					}
				}

				virus->thinktime -= (int)(1 * engine.getTimeDifference());
				if (virus->thinktime <= 0)
				{
					if (gameData.skill < 3)
						virus->goHome();
					else
						nightmareVirusGoHome(virus);
					virus->thinktime = (Math::rrand(2, 4) * 100);
				}
			}
		}

		if (virus->active)
		{
			previous = virus;
			gameData.virusList.setTail(virus);
		}
		else
		{
			gameData.virusList.remove(previous, virus);
			virus = previous;
		}
	}
}
