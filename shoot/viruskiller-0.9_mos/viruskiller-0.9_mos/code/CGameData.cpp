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

#include "headers.h"

GameData::GameData()
{
	shownTitles = false;

	gamma = 10;
	soundVolume = 128;
	musicVolume = 100;

#ifndef __MORPHOS__
	strcpy(directorySearchPath, "/home");
#else
	strcpy(directorySearchPath, "Progdir:");
#endif

	maxDirectories = 0;
	maxFiles = 0;
	score = 0;
	activeViruses = 0;
	level = 1;
	activeDirs = 0;
	kernelPower = 300;
	skill = 0;

	threadStopTimer = 0;
	threadStops = 0;

	for (int x = 0 ; x < 5 ; x++)
		for (int y = 0 ; y < 5 ; y++)
			map[x][y] = 0;

	for (int i = 0 ; i < 5 ; i++)
	{
		highScore[i][0].set("MyDoom", 1000000 / ((i * 2) + 1), 100, 1);
		highScore[i][1].set("Blaster", 900000 / ((i * 2)  + 1), 100, 1);
		highScore[i][2].set("SoBigF", 800000 / ((i * 2)  + 1), 100, 1);
		highScore[i][3].set("Klez", 700000 / ((i * 2) + 1), 100, 1);
		highScore[i][4].set("iloveyou", 600000 / ((i * 2)  + 1), 100, 1);
		highScore[i][5].set("Melissa", 500000 / ((i * 2)  + 1), 100, 1);
		highScore[i][6].set("Slammer", 400000 / ((i * 2)  + 1), 100, 1);
		highScore[i][7].set("Sober", 300000 / ((i * 2)  + 1), 100, 1);
		highScore[i][8].set("Bugbear", 200000 / ((i * 2)  + 1), 100, 1);
		highScore[i][9].set("Code Red", 100000 / ((i * 2)  + 1), 100, 1);
	}

	nightmareCount = 100;
}

GameData::~GameData()
{
	destroy();
}

void GameData::clear()
{
	score = 0;
	activeViruses = 0;
	level = 1;
	
	virusesKilled = 0;
	roundVirusesKilled = 0;

	filesLost = 0;
	roundFilesLost = 0;

	dirsLost = 0;
	roundDirsLost = 0;

	biggestChain = 0;
	roundBiggestChain = 0;
	
	lastVirusKilled = 0;
	
	kernelPower = 300;
	
	threadStopTimer = 0;
	threadStops = 0;

	for (int x = 0 ; x < 5 ; x++)
		for (int y = 0 ; y < 5 ; y++)
			map[x][y] = 0;
			
	virusList.clear();
	particleList.clear();
	itemList.clear();
	
	Directory *dir = (Directory*)directoryList.getHead();

	while (dir->next != NULL)
	{
		dir = (Directory*)dir->next;
		dir->active = false;
		dir->x = dir->y = -1;
	}
}

void GameData::resetForNextRound()
{
	roundVirusesKilled = 0;
	roundFilesLost = 0;
	roundDirsLost = 0;
	roundBiggestChain = 0;
	currentChain = 0;
	lastVirusKilled = 50;
	roundItemsCollected = 0;

	for (int i = 0 ; i < 4 ; i++)
		base[i].place();

	kernelPower = 300;
	
	itemList.clear();
}

void GameData::destroy()
{
	virusList.clear();
	directoryList.clear();
	particleList.clear();
	itemList.clear();
}

Directory *GameData::addDirectory(char *name)
{
	char string[1024];
	char *realName, *previousName;

	strcpy(string, name);

	realName = strtok(string, "/");
	previousName = realName;

	while (realName != NULL)
	{
		previousName = realName;
		realName = strtok(NULL, "/");
	}

	name = previousName;

	Directory *dir = (Directory*)directoryList.getHead();

	while (dir->next != NULL)
	{
		dir = (Directory*)dir->next;

		if (strcmp(dir->name, name) == 0)
		{
			debug(("Directory '%s' already exists. Skipping.\n", dir->name));
			return dir;
		}
	}

	dir = new Directory();
	strncpy(dir->name, name, 49);
	directoryList.add(dir);
	maxDirectories++;

	//debug(("Added Directory '%s'\n", dir->name));

	return dir;
}

void GameData::addItem(Item *item)
{
	itemList.add(item);
}

void GameData::addVirus(Virus *virus)
{
	virusList.add(virus);
}

void GameData::addParticle(Particle *particle)
{
	particleList.add(particle);
}

void GameData::removeEmptyDirectories()
{
	Directory *dir = (Directory*)directoryList.getHead();
	Directory *previous;

	while (dir->next != NULL)
	{
		previous = dir;
		dir = (Directory*)dir->next;

		if (dir->fileCount == 0)
		{
			debug(("Directory '%s' is empty. Removing...\n", dir->name));
			directoryList.remove(previous, dir);
			dir = previous;
			maxDirectories--;
		}
	}
}


Directory *GameData::getRandomDirectory(bool active)
{
	Directory *dir = (Directory*)directoryList.getHead();

	int r = rand() % maxDirectories;
	int i = 0;

	while (dir->next != NULL)
	{
		dir = (Directory*)dir->next;
		if ((r == i) && (dir->active == active))
			return dir;

		i++;
	}

	return NULL;
}

void GameData::buildActiveDirList(int amount)
{
	int sanity = 0;
	int i = 0;
	
	Directory *dir = (Directory*)directoryList.getHead();

	while (true)
	{
		dir = getRandomDirectory(false);

		if (dir != NULL)
		{
			dir->active = true;
			i++;

			if (i == amount)
				break;
		}
		
		sanity++;
		
		if (sanity == 10000)
		{
			printf("Made 10,000 unsuccessful attempts to grab %d inactives directories!!\n", amount);
			exit(1);
		}
	}
}
